class source_driver extends uvm_driver #(source_transaction);

        `uvm_component_utils(source_driver)

        virtual router_if.S_DR_MP vif;
        source_agt_config s_configh;

        extern function new (string name = "source_driver",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern task drive_to_dut (source_transaction xtn);
        extern function void report_phase (uvm_phase phase);

        endclass

        function source_driver::new (string name = "source_driver",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void source_driver::build_phase (uvm_phase phase);
                if(!uvm_config_db #(source_agt_config)::get(this,"","source_agt_config",s_configh))
                    `uvm_fatal("s_driver","cannot get config data");
                super.build_phase(phase);
        endfunction

        function void source_driver::connect_phase (uvm_phase phase);
                super.connect_phase(phase);
                vif = s_configh.vif;
        endfunction

        task source_driver::run_phase (uvm_phase phase);
                @(vif.s_dr_cb);
                vif.s_dr_cb.resetn <=0;
                @(vif.s_dr_cb);
                vif.s_dr_cb.resetn <=1;
                forever
                        begin
                                seq_item_port.get_next_item(req);
                                drive_to_dut(req);
                                seq_item_port.item_done();
                        end
        endtask

        task source_driver::drive_to_dut (source_transaction xtn);
                wait(~vif.s_dr_cb.busy);
                @(vif.s_dr_cb)
                vif.s_dr_cb.pkt_valid <=1;
                vif.s_dr_cb.data_in <=xtn.header;
                @(vif.s_dr_cb);
                foreach( xtn.payload_data[i])
                        begin
                                wait(~vif.s_dr_cb.busy);
                                vif.s_dr_cb.data_in <= xtn.payload_data[i];
                                @(vif.s_dr_cb);
                        end
                wait(~vif.s_dr_cb.busy);
//              @(vif.s_dr_cb);
                vif.s_dr_cb.pkt_valid <=0;
                vif.s_dr_cb.data_in <= xtn.parity;
                repeat(2)

                        @(vif.s_dr_cb);
                s_configh.drv_data_count ++;
                      `uvm_info("SOURCE_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW)
        endtask

        function void source_driver::report_phase (uvm_phase phase);
                `uvm_info(get_type_name(), $sformatf("report: source_driver sent %0d transactions", s_configh.drv_data_count),UVM_LOW)
        endfunction
