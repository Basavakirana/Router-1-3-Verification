class dest_driver extends uvm_driver #(dest_transaction);

        `uvm_component_utils(dest_driver)

        virtual router_if.D_DR_MP vif;
        dest_agt_config d_configh;


        extern function new (string name = "dest_driver",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern task drive_to_dut (dest_transaction xtn);
        extern function void report_phase (uvm_phase phase);

        endclass

        function dest_driver::new (string name = "dest_driver",uvm_component parent);
                super.new(name,parent);
        endfunction
        function void dest_driver::build_phase (uvm_phase phase);
                super.build_phase(phase);
                if(!uvm_config_db #(dest_agt_config)::get(this,"","dest_agt_config",d_configh))
                   `uvm_fatal("d_drv","config data not recieved");
        endfunction

        function void dest_driver::connect_phase (uvm_phase phase);
                super.connect_phase(phase);
                vif = d_configh.vif;
        endfunction

        task dest_driver::run_phase (uvm_phase phase);
                forever
                       begin
                                seq_item_port.get_next_item(req);
                                drive_to_dut(req);
                                seq_item_port.item_done();
                        end
        endtask

        task dest_driver::drive_to_dut(dest_transaction xtn);
        begin
//              `uvm_info("DEST_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW)
                @(vif.d_dr_cb);
                wait(vif.d_dr_cb.valid_out)// !==1)
                repeat(xtn.cycle) @(vif.d_dr_cb);
                vif.d_dr_cb.read_enb <= 1'b1;
                wait(!vif.d_dr_cb.valid_out )//===1)
                @(vif.d_dr_cb);
                vif.d_dr_cb.read_enb <=1'b0;

                repeat(2)
                        @(vif.d_dr_cb);

                d_configh.drv_data_count ++;
                        @(vif.d_dr_cb);
                `uvm_info("DEST_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW)
        end
        endtask

        function void dest_driver::report_phase (uvm_phase phase);
                `uvm_info(get_type_name(), $sformatf("report: dest_driver sent %0d transactions", d_configh.drv_data_count),UVM_LOW)
        endfunction
