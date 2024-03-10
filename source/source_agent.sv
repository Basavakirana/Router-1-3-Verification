class source_agt extends uvm_agent;

        `uvm_component_utils(source_agt)

        source_agt_config s_configh;
        source_driver s_drvh;
        source_monitor s_monh;
        source_sequencer s_seqrh;

        extern function new (string name = "source_agt",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function source_agt:: new (string name = "source_agt",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void source_agt:: build_phase (uvm_phase phase);
           super.build_phase(phase);
                if(!uvm_config_db #(source_agt_config)::get(this,"","source_agt_config",s_configh))
                   `uvm_fatal("s_agt","config data not recieved");
                s_monh = source_monitor::type_id::create("s_monh",this);
                if(s_configh.is_active == UVM_ACTIVE)
                  begin
                        s_drvh = source_driver::type_id::create("s_drvh",this);
                        s_seqrh = source_sequencer::type_id::create("s_seqrh",this);
                  end
        endfunction

        function void source_agt:: connect_phase (uvm_phase phase);
                super.connect_phase(phase);
        if(s_configh.is_active == UVM_ACTIVE)
                s_drvh.seq_item_port.connect(s_seqrh.seq_item_export);
        endfunction

        task source_agt::run_phase(uvm_phase phase);
                uvm_top.print_topology();
        endtask
