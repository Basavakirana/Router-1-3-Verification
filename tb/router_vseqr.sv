class router_vseqr extends uvm_sequencer #(uvm_sequence_item);

        `uvm_component_utils(router_vseqr)

        source_sequencer s_seqrh[];
        dest_sequencer d_seqrh[];
        env_config env_configh;

        extern function new (string name = "router_vseqr",uvm_component parent);
        extern function void build_phase (uvm_phase phase);

        endclass

        function router_vseqr::new (string name = "router_vseqr",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void router_vseqr::build_phase (uvm_phase phase);
                if(!uvm_config_db #(env_config)::get(this,"","env_config",env_configh))
                   `uvm_fatal("v_seqr","cannot get config data");
                s_seqrh = new[env_configh.no_of_source];
                d_seqrh = new[env_configh.no_of_destination];
        endfunction
