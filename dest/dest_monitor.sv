class dest_monitor extends uvm_monitor;

        `uvm_component_utils(dest_monitor)

        virtual router_if.D_MON_MP vif;
        dest_agt_config d_configh;
        uvm_analysis_port #(dest_transaction) monitor_port;

        extern function new (string name = "dest_monitor",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern task collect_data();
        extern function void report_phase (uvm_phase phase);

        endclass

        function dest_monitor::new (string name = "dest_monitor",uvm_component parent);
                super.new(name,parent);
                monitor_port = new("monitor_port",this);
        endfunction

        function void dest_monitor::build_phase (uvm_phase phase);
                super.build_phase(phase);
                if(!uvm_config_db #(dest_agt_config)::get(this,"","dest_agt_config",d_configh))
                   `uvm_fatal("d_mon","config data not recieved")
        endfunction

        function void dest_monitor::connect_phase (uvm_phase phase);
                vif = d_configh.vif;
        endfunction

        task dest_monitor::collect_data();
         //                       `uvm_info("DEST_MONITOR",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW)
//              @(vif.d_mon_cb);
                dest_transaction xtn;
                xtn = dest_transaction::type_id::create("xtn");
//          `uvm_info("DEST_MONITOR",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW)
                @(vif.d_mon_cb);
                while(~vif.d_mon_cb.read_enb) //!==1)
                @(vif.d_mon_cb);
                @(vif.d_mon_cb);
                xtn.header = vif.d_mon_cb.data_out;
                xtn.payload_data = new[xtn.header[7:2]];
                @(vif.d_mon_cb);
                foreach(xtn.payload_data[i])
                  begin
                //      while(vif.d_mon_cb.re)
        //              @(vif.d_mon_cb);
                        xtn.payload_data[i] = vif.d_mon_cb.data_out;
                        @(vif.d_mon_cb);
                  end
//              wait(~vif.d_mon_cb.valid_out)
        //      while(vif.d_mon_cb.re)
        //      @(vif.d_mon_cb);
                xtn.parity = vif.d_mon_cb.data_out;
                @(vif.d_mon_cb);

//              repeat(2)
//                      @(vif.d_mon_cb);
                      `uvm_info("DEST_MONITOR",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW)
                d_configh.mon_data_count ++;
//                      `uvm_info("DEST_MONITOR",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW)
                monitor_port.write(xtn);
        endtask

         task dest_monitor::run_phase (uvm_phase phase);
        forever
                begin
                        collect_data();
                end
        endtask

        function void dest_monitor::report_phase (uvm_phase phase);
                `uvm_info(get_type_name(), $sformatf("report: dest_monitor recieved %0d transactions", d_configh.mon_data_count),UVM_LOW)
        endfunction
