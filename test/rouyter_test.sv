class router_test extends uvm_test;

        `uvm_component_utils(router_test)

        router_env envh;
        env_config env_configh;
        source_agt_config s_configh[];
        dest_agt_config d_configh[];

        int no_of_source = 1;
        int no_of_destination = 3;
        bit has_scoreboard = 1;
        bit has_vsequencer = 1;
        bit has_sagent = 1;
        bit has_dagent = 1;

        bit [1:0] addr;
//      addr = $random (00|01|10)

        extern function new (string name ="router_test", uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern function void end_of_elaboration_phase (uvm_phase phase);

        endclass

        function router_test::new (string name = "router_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void router_test::build_phase (uvm_phase phase);
//                     addr = $random (00|01|10);
                uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
                env_configh = env_config::type_id::create("env_configh");

                s_configh = new[no_of_source];
                env_configh.s_configh = new[no_of_source];
                foreach(s_configh[i])
                        begin
                                s_configh[i] = source_agt_config::type_id::create($sformatf("s_configh[%0d]",i));
                                if(!uvm_config_db #(virtual router_if)::get(this,"","vif",s_configh[i].vif))
                                    `uvm_fatal("test","cannot get config data");
                                s_configh[i].is_active = UVM_ACTIVE;
                                env_configh.s_configh[i] = s_configh[i];
                        end

                d_configh = new[no_of_destination];
                env_configh.d_configh = new[no_of_destination];
                foreach(d_configh[i])
                        begin
                                d_configh[i] = dest_agt_config::type_id::create($sformatf("d_configh[%0d]",i));
                                if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("vif[%0d]",i),d_configh[i].vif))
                                    `uvm_fatal("test","cannot get config data");
                                d_configh[i].is_active = UVM_ACTIVE;
                                env_configh.d_configh[i] = d_configh[i];
                        end

                env_configh.no_of_source = no_of_source;
                env_configh.no_of_destination = no_of_destination;
                env_configh.has_scoreboard = has_scoreboard;
                env_configh.has_vsequencer = has_vsequencer;
                uvm_config_db #(env_config)::set(this,"*","env_config",env_configh);
                super.build_phase(phase);
                envh = router_env::type_id::create("envh",this);
        endfunction

        function void router_test:: end_of_elaboration_phase(uvm_phase phase);
                uvm_top.print_topology();
        endfunction
class small_test extends router_test;

        `uvm_component_utils(small_test)

        virtual_small_sequence vseq;
//      bit[1:0]addr;

        extern function new (string name = "small_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function small_test::new (string name ="small_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void small_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task small_test::run_phase (uvm_phase phase);
                 addr ={$random} %3;
                uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
                phase.raise_objection(this);
                     vseq = virtual_small_sequence::type_id::create("vseq");
                vseq.start(envh.vseqrh);
#300;
                phase.drop_objection(this);
        endtask

class medium_test extends router_test;

        `uvm_component_utils(medium_test)

        virtual_medium_sequence vseq;
//      bit[1:0]addr;

        extern function new (string name = "medium_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function medium_test::new (string name ="medium_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void medium_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task medium_test::run_phase (uvm_phase phase);
                 addr ={$random} %3;
                uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
                phase.raise_objection(this);
                      vseq = virtual_medium_sequence::type_id::create("vseq");
                vseq.start(envh.vseqrh);
#100;
                phase.drop_objection(this);
        endtask

class big_test extends router_test;

        `uvm_component_utils(big_test)

        virtual_big_sequence vseq;
//      bit[1:0]addr;

        extern function new (string name = "big_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function big_test::new (string name ="big_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void big_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task big_test::run_phase (uvm_phase phase);
                 addr ={$random} %3;
                uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
                phase.raise_objection(this);
       vseq = virtual_big_sequence::type_id::create("vseq");
                vseq.start(envh.vseqrh);
#100;
                phase.drop_objection(this);
        endtask

class random_test extends router_test;

        `uvm_component_utils(random_test)

        virtual_random_sequence vseq;
//      bit[1:0]addr;

        extern function new (string name = "random_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function random_test::new (string name ="random_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void random_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task random_test::run_phase (uvm_phase phase);
                 addr ={$random} %3;
                uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
                phase.raise_objection(this);
      vseq = virtual_random_sequence::type_id::create("vseq");
                vseq.start(envh.vseqrh);
#100;
                phase.drop_objection(this);
        endtask

class soft_rst_test extends router_test;

        `uvm_component_utils(soft_rst_test)

//      bit[1:0]addr;
      soft_rst_sequence vseq;

        extern function new (string name = "soft_rst_test",uvm_component parent);
        extern function void build_phase (uvm_phase phase);
        extern task run_phase (uvm_phase phase);

        endclass

        function soft_rst_test::new (string name ="soft_rst_test",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void soft_rst_test::build_phase (uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task soft_rst_test::run_phase (uvm_phase phase);
                 addr ={$random} %3;
                uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
                phase.raise_objection(this);
                         vseq = soft_rst_sequence::type_id::create("vseq");
                vseq.start(envh.vseqrh);
#100;
                phase.drop_objection(this);
        endtask
