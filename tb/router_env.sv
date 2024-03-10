class router_env extends uvm_env;

        `uvm_component_utils(router_env)
        source_agt_top s_toph;
        dest_agt_top d_toph;
        router_vseqr vseqrh;
        router_sb sbh;
        env_config env_configh;

        extern function new (string name = "router_env", uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void connect_phase (uvm_phase phase);

        endclass

        function router_env:: new (string name = "router_env",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void router_env:: build_phase (uvm_phase phase);
                if(!uvm_config_db #(env_config)::get(this,"","env_config",env_configh))
                        `uvm_fatal("env_config","cannot get config data");
                super.build_phase(phase);
                                s_toph= source_agt_top::type_id::create("s_toph",this);
                                d_toph= dest_agt_top::type_id::create("d_toph",this);
                if(env_configh.has_vsequencer)
                                vseqrh = router_vseqr::type_id::create("vseqrh",this);
                if(env_configh.has_scoreboard)
                                sbh = router_sb::type_id::create("sbh",this);
        endfunction

        function void router_env:: connect_phase (uvm_phase phase);
                super.connect_phase(phase);
                if(env_configh.has_vsequencer)
                begin
                        foreach(vseqrh.s_seqrh[i])
                                vseqrh.s_seqrh[i] = s_toph.s_agnth[i].s_seqrh;
                        foreach(vseqrh.d_seqrh[i])
                                vseqrh.d_seqrh[i] = d_toph.d_agnth[i].d_seqrh;
                end

                if(env_configh.has_scoreboard)
                begin
                        s_toph.s_agnth[0].s_monh.monitor_port.connect(sbh.af_s.analysis_export);
                        foreach(d_toph.d_agnth[i])
                        d_toph.d_agnth[i].d_monh.monitor_port.connect(sbh.af_d[i].analysis_export);
                end
        endfunction
