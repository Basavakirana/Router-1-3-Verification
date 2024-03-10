class source_agt_top extends uvm_env;

        `uvm_component_utils(source_agt_top)

        env_config env_configh;
        source_agt_config s_configh[];
        source_agt s_agnth[];

        extern function new (string name = "source_agt_top", uvm_component parent);
        extern function void build_phase (uvm_phase phase);

        endclass

        function source_agt_top:: new (string name = "source_agt_top",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void source_agt_top::build_phase (uvm_phase phase);
                if(!uvm_config_db #(env_config)::get(this,"","env_config",env_configh))
                        `uvm_fatal("s_agt_top","cannot get config data");
                s_agnth = new[env_configh.no_of_source];
                if(env_configh.has_sagent)
                foreach(s_agnth[i])
                        begin
                                s_agnth[i]= source_agt::type_id::create($sformatf("s_agnth[%0d]",i),this);
                                uvm_config_db #(source_agt_config)::set(this,$sformatf("s_agnth[%0d]*",i),"source_agt_config",env_configh.s_configh[i]);
                        end
        endfunction
