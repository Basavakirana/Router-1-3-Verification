class dest_agt extends uvm_agent;

        `uvm_component_utils(dest_agt)

        dest_agt_config d_configh;
        dest_driver d_drvh;
        dest_monitor d_monh;
        dest_sequencer d_seqrh;

        extern function new (string name = "dest_agt",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);

        endclass

        function dest_agt::new (string name = "dest_agt",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void dest_agt::build_phase (uvm_phase phase);
            super.build_phase(phase);
                if(!uvm_config_db #(dest_agt_config)::get(this,"","dest_agt_config",d_configh))
                    `uvm_fatal("d_agt","cannot get config data")
                d_monh = dest_monitor::type_id::create("d_monh",this);
                if(d_configh.is_active == UVM_ACTIVE)
                  begin
                        d_drvh = dest_driver::type_id::create("d_drvh",this);
                        d_seqrh = dest_sequencer::type_id::create("d_seqrh",this);
                  end
        endfunction

        function void dest_agt:: connect_phase (uvm_phase phase);
                super.connect_phase(phase);
        if(d_configh.is_active == UVM_ACTIVE)
                d_drvh.seq_item_port.connect(d_seqrh.seq_item_export);
        endfunction

