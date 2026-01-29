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

 /*               class env_config extends uvm_object;

  `uvm_object_utils(env_config)

  int no_of_source;
  int no_of_destination;
  bit has_scoreboard;
  bit has_vsequencer;
  bit has_sagent;
  bit has_dagent;

  source_agt_config s_configh[];
  dest_agt_config   d_configh[];

  function new(string name = "env_config");
    super.new(name);
  endfunction

endclass   
class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  env_config env_cfg;

  function new(string name="base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env_cfg = env_config::type_id::create("env_cfg");

    // Set topology HERE
    env_cfg.no_of_source      = 1;
    env_cfg.no_of_destination = 3;
    env_cfg.has_scoreboard    = 1;
    env_cfg.has_vsequencer    = 1;
    env_cfg.has_sagent        = 1;
    env_cfg.has_dagent        = 1;

    // Create agent configs based on count
    env_cfg.s_configh = new[env_cfg.no_of_source];
    foreach (env_cfg.s_configh[i])
      env_cfg.s_configh[i] = source_agt_config::type_id::create($sformatf("s_cfg[%0d]", i));

    env_cfg.d_configh = new[env_cfg.no_of_destination];
    foreach (env_cfg.d_configh[i])
      env_cfg.d_configh[i] = dest_agt_config::type_id::create($sformatf("d_cfg[%0d]", i));

    // Put into config DB
    uvm_config_db#(env_config)::set(this, "*", "env_config", env_cfg);
  endfunction

endclass */

