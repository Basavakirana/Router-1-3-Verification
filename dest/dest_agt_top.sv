class dest_agt_top extends uvm_env;

        `uvm_component_utils(dest_agt_top)

        env_config env_configh;
        dest_agt_config d_configh[];
        dest_agt d_agnth[];

        extern function new (string name = "dest_agt_top",uvm_component parent);
        extern function void build_phase (uvm_phase phase);

        endclass

        function dest_agt_top:: new (string name = "dest_agt_top",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void dest_agt_top::build_phase(uvm_phase phase);
                if(!uvm_config_db #(env_config)::get(this,"","env_config",env_configh))
                        `uvm_fatal("d_agt_top","cannot get config data");
                d_agnth = new[env_configh.no_of_destination];
                if(env_configh.has_dagent)
                foreach(d_agnth[i])
                        begin
                                d_agnth[i] = dest_agt::type_id::create($sformatf("d_agnth[%0d]",i),this);
                                uvm_config_db #(dest_agt_config)::set(this,$sformatf("d_agnth[%0d]*",i),"dest_agt_config",env_configh.d_configh[i]);
                        end
        endfunction
