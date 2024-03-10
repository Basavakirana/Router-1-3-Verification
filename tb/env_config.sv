class env_config extends uvm_object;

        `uvm_object_utils(env_config)

        int no_of_source = 1;
        int no_of_destination = 3;
        bit has_scoreboard = 1;
        bit has_vsequencer = 1;
        bit has_sagent = 1;
        bit has_dagent = 1;

        source_agt_config s_configh[];
        dest_agt_config d_configh[];

        extern function new(string name = "env_config");

        endclass

        function env_config:: new(string name = "env_config");
                super.new(name);
        endfunction
