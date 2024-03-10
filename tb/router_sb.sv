class router_sb extends uvm_scoreboard;

        `uvm_component_utils(router_sb)

        uvm_tlm_analysis_fifo #(source_transaction) af_s;
        uvm_tlm_analysis_fifo #(dest_transaction) af_d[];

        source_transaction source_data, source_cov_data;
        dest_transaction dest_data, dest_cov_data;
        env_config env_configh;

        int data_verified_count;

        covergroup router_fcov1;
                option.per_instance = 1;

                CHANNEL : coverpoint source_cov_data.header[1:0] { bins low = {2'b00};
                                                                  bins mid = {2'b01};
                                                                  bins high = {2'b10};}

                PAYLOAD_SIZE : coverpoint source_cov_data.header[7:2] { bins small_packet = {[1:15]};
                                                                       bins medium_packet = {[16:30]};
                                                                       bins big_packet = {[31:63]};}

                CHANNEL_X_PAYLOAD_SIZE : cross CHANNEL, PAYLOAD_SIZE;
        endgroup

        covergroup router_fcov2;
                option.per_instance = 1;

                CHANNEL : coverpoint dest_cov_data.header[1:0] { bins low = {2'b00};
                                                                  bins mid = {2'b01};
                                                                  bins high = {2'b10};}

                PAYLOAD_SIZE : coverpoint dest_cov_data.header[7:2] { bins small_packet = {[1:15]};
                                                                       bins medium_packet = {[16:30]};
                                                                       bins big_packet = {[31:63]};}

                CHANNEL_X_PAYLOAD_SIZE : cross CHANNEL, PAYLOAD_SIZE;
        endgroup

        extern function new (string name = "router_sb",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);
        extern task check_data (dest_transaction dest);
        extern function void report_phase (uvm_phase phase);

        endclass

        function router_sb::new (string name = "router_sb",uvm_component parent);
                super.new(name,parent);
                router_fcov1 = new;
                router_fcov2 = new;
        endfunction

        function void router_sb::build_phase (uvm_phase phase);
                if(!uvm_config_db #(env_config)::get(this,"","env_config",env_configh))
                   `uvm_fatal("sb","cannot get config data");
                af_s = new("af_s",this);
                af_d = new[env_configh.no_of_destination];
                foreach(af_d[i])
                        af_d[i] = new($sformatf("af_d[%0d]",i),this);
                super.build_phase(phase);
                source_data = source_transaction::type_id::create("source_data");
                dest_data = dest_transaction::type_id::create("dest_data");
        endfunction

        task router_sb::run_phase (uvm_phase phase);
                fork
                    begin
                        forever
                               begin
                                    af_s.get(source_data);
                                    `uvm_info("write sb","write_data",UVM_LOW)
                                    source_data.print;
                                    source_cov_data = source_data;
                                    router_fcov1.sample();
                               end
                     end

                    begin
                         forever
                            begin
                              fork
                                begin
                                     af_d[0].get(dest_data);
                                     `uvm_info("read_sb[0]","read_data",UVM_LOW)
                                      dest_data.print;
                                      check_data(dest_data);
                                      dest_cov_data = dest_data;
                                      router_fcov2.sample();
                                end
                                begin
                                     af_d[1].get(dest_data);
                                     `uvm_info("read_sb[1]","read_data",UVM_LOW)
                                      dest_data.print;
                                      check_data(dest_data);
                                      dest_cov_data = dest_data;
                                      router_fcov2.sample();
                                end
                                begin
                                     af_d[2].get(dest_data);
                                     `uvm_info("read_sb[2]","read_data",UVM_LOW)
                                      dest_data.print;
                                      check_data(dest_data);
                                      dest_cov_data = dest_data;
                                      router_fcov2.sample();
                                end
                              join_any
                              disable fork;
                           end
                    end
                join
        endtask

        task router_sb::check_data(dest_transaction dest);
                if(dest.header == source_data.header)
                   `uvm_info("sb","header matched successfully",UVM_MEDIUM)
                else
                    `uvm_error("sb","header mismatch")

                if(dest.payload_data == source_data.payload_data)
                   `uvm_info("sb","payload matched successfully",UVM_MEDIUM)
                else
                    `uvm_error("sb","payload mismatch")

                if(dest.parity == source_data.parity)
                   `uvm_info("sb","parity matched successfully",UVM_MEDIUM)
                else
                    `uvm_error("sb","parity mismatch")

                data_verified_count++;

        endtask

        function void router_sb::report_phase (uvm_phase phase);
                `uvm_info(get_type_name(), $sformatf("report: router_sb verified %0d transactions", data_verified_count),UVM_LOW)
        endfunction
