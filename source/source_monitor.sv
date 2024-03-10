class source_monitor extends uvm_monitor;

        `uvm_component_utils(source_monitor)

        virtual router_if.S_MON_MP vif;
        source_agt_config s_configh;
        uvm_analysis_port #(source_transaction) monitor_port;
        source_transaction xtn;

        extern function new (string name = "source_monitor",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern task collect_data();
        extern function void report_phase (uvm_phase phase);

        endclass

        function source_monitor::new (string name = "source_monitor",uvm_component parent);
                super.new(name,parent);
                monitor_port = new("monitor_port",this);
        endfunction

        function void source_monitor::build_phase (uvm_phase phase);
                if(!uvm_config_db #(source_agt_config)::get(this,"","source_agt_config",s_configh))
                   `uvm_fatal("MON","cannot get config data");
                super.build_phase(phase);
        endfunction

        function void source_monitor::connect_phase (uvm_phase phase);
                super.connect_phase(phase);
                vif = s_configh.vif;
        endfunction

        task source_monitor::run_phase (uvm_phase phase);
                forever
                        collect_data();
                //      #1000 $finish;
        endtask

        task source_monitor::collect_data();
                @(vif.s_mon_cb);
                wait(~vif.s_mon_cb.busy && vif.s_mon_cb.pkt_valid)
                xtn = source_transaction::type_id::create("xtn");
                xtn.header = vif.s_mon_cb.data_in;
//                       @(vif.s_mon_cb);
                xtn.payload_data = new[xtn.header[7:2]];
//              wait(vif.s_mon_cb.busy)
                @(vif.s_mon_cb);
                foreach (xtn.payload_data[i])
                        begin
//                              @(vif.s_mon_cb);
                                wait(~vif.s_mon_cb.busy && vif.s_mon_cb.pkt_valid)
                                @(vif.s_mon_cb)
                                xtn.payload_data[i] = vif.s_mon_cb.data_in;
                                //@(vif.s_mon_cb);
                        end
//              @(vif.s_mon_cb)
                wait(~vif.s_mon_cb.busy && ~vif.s_mon_cb.pkt_valid)
                @(vif.s_mon_cb)
                xtn.parity = vif.s_mon_cb.data_in;
                repeat(2)

                        @(vif.s_mon_cb);
                s_configh.mon_data_count ++;
                                `uvm_info("SOURCE_monitor",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW)
                monitor_port.write(xtn);
        endtask

        function void source_monitor::report_phase (uvm_phase phase);
                `uvm_info(get_type_name(), $sformatf("report: source_monitor recieved %0d transactions", s_configh.mon_data_count),UVM_LOW)
        endfunction

