class router_vseq extends uvm_sequence #(uvm_sequence_item);

        `uvm_object_utils(router_vseq)

        source_sequencer s_seqrh[];
        dest_sequencer d_seqrh[];
        router_vseqr vseqrh;
        env_config env_configh;

        bit[1:0] addr;

        extern function new (string name = "router_vseq");
        extern task body;

        endclass

        function router_vseq::new (string name = "router_vseq");
                super.new(name);
        endfunction

        task router_vseq::body;
//               if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
  //                `uvm_fatal("seq","config data not got");

                if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",env_configh))
                  `uvm_fatal("v_seq","cannot get config data");
                assert($cast(vseqrh,m_sequencer))
                else
                     `uvm_error(get_full_name(),"cast failed");
                s_seqrh =new[env_configh.no_of_source];
                d_seqrh =new[env_configh.no_of_destination];
                foreach(s_seqrh[i])
                        s_seqrh[i] = vseqrh.s_seqrh[i];
                foreach(d_seqrh[i])
                        d_seqrh[i] = vseqrh.d_seqrh[i];
        endtask

class virtual_small_sequence extends router_vseq;

        `uvm_object_utils(virtual_small_sequence)

        small_source_sequence s_seq;
        true_dest_sequence d_seq;
        bit[1:0]addr;

        extern function new (string name = "virtual_small_sequence");
        extern task body;

        endclass

        function virtual_small_sequence::new (string name ="virtual_small_sequence");
                super.new(name);
        endfunction

        task virtual_small_sequence::body;
                super.body;
             if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                   `uvm_fatal("seq","config data not got");
         s_seq= small_source_sequence::type_id::create("s_seq");
         d_seq =true_dest_sequence::type_id::create("d_seq");

                fork
                        begin
                                foreach(s_seqrh[i])
                                s_seq.start(s_seqrh[i]);
                        end
                        begin
                                if(addr==00)
                                        d_seq.start(d_seqrh[0]);
                                if(addr==01)
                                        d_seq.start(d_seqrh[1]);
                                if(addr==10)
                                        d_seq.start(d_seqrh[2]);
                        end
                join
        endtask
class virtual_medium_sequence extends router_vseq;

        `uvm_object_utils(virtual_medium_sequence)

        bit[1:0]addr;
        medium_source_sequence s_seq;
        true_dest_sequence d_seq;

        extern function new (string name = "virtual_medium_sequence");
        extern task body;

        endclass

        function virtual_medium_sequence::new (string name ="virtual_medium_sequence");
                super.new(name);
        endfunction

        task virtual_medium_sequence::body;
                super.body;
if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                   `uvm_fatal("seq","config data not got");
         s_seq= medium_source_sequence::type_id::create("s_seq");
         d_seq =true_dest_sequence::type_id::create("d_seq");

                fork
                        begin
                                foreach(s_seqrh[i])
                                s_seq.start(s_seqrh[i]);
                        end
                        begin
                                if(addr==00)
                                        d_seq.start(d_seqrh[0]);
                                if(addr==01)
                                        d_seq.start(d_seqrh[1]);
                                if(addr==10)
                                        d_seq.start(d_seqrh[2]);
                        end
                join
        endtask

class virtual_big_sequence extends router_vseq;

        `uvm_object_utils(virtual_big_sequence)

        bit[1:0]addr;
        big_source_sequence s_seq;
        true_dest_sequence d_seq;

        extern function new (string name = "virtual_big_sequence");
        extern task body;

        endclass

        function virtual_big_sequence::new (string name ="virtual_big_sequence");
                super.new(name);
        endfunction

        task virtual_big_sequence::body;
                super.body;
if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                   `uvm_fatal("seq","config data not got");
         s_seq= big_source_sequence::type_id::create("s_seq");
         d_seq =true_dest_sequence::type_id::create("d_seq");

                fork
                        begin
                                foreach(s_seqrh[i])
                                s_seq.start(s_seqrh[i]);
                        end
                        begin
                                if(addr==00)
                                        d_seq.start(d_seqrh[0]);
                                if(addr==01)
                                        d_seq.start(d_seqrh[1]);
                                if(addr==10)
                                        d_seq.start(d_seqrh[2]);
                        end
                join
        endtask

class virtual_random_sequence extends router_vseq;

        `uvm_object_utils(virtual_random_sequence)

        bit[1:0]addr;
        random_source_sequence s_seq;
        true_dest_sequence d_seq;

        extern function new (string name = "virtual_random_sequence");
        extern task body;

        endclass

        function virtual_random_sequence::new (string name ="virtual_random_sequence");
                super.new(name);
        endfunction

        task virtual_random_sequence::body;
                super.body;
if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                   `uvm_fatal("seq","config data not got");
         s_seq= random_source_sequence::type_id::create("s_seq");
         d_seq =true_dest_sequence::type_id::create("d_seq");

                fork
                        begin
                                foreach(s_seqrh[i])
                                s_seq.start(s_seqrh[i]);
                        end
                        begin
                                if(addr==00)
                                        d_seq.start(d_seqrh[0]);
                                if(addr==01)
                                        d_seq.start(d_seqrh[1]);
                                if(addr==10)
                                        d_seq.start(d_seqrh[2]);
                        end
                join
        endtask
class soft_rst_sequence extends router_vseq;

        `uvm_object_utils(soft_rst_sequence)

        bit[1:0]addr;
        medium_source_sequence s_seq;
        false_dest_sequence d_seq;

        extern function new (string name = "soft_rst_sequence");
        extern task body;

        endclass

        function soft_rst_sequence::new (string name ="soft_rst_sequence");
                super.new(name);
        endfunction

        task soft_rst_sequence::body;
                super.body;
        if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                   `uvm_fatal("seq","config data not got");
         s_seq= medium_source_sequence::type_id::create("s_seq");
         d_seq =false_dest_sequence::type_id::create("d_seq");

                fork
                        begin
                                foreach(s_seqrh[i])
                                s_seq.start(s_seqrh[i]);
                        end
                        begin
                                if(addr==00)
                                        d_seq.start(d_seqrh[0]);
                                if(addr==01)
                                        d_seq.start(d_seqrh[1]);
                                if(addr==10)
                                        d_seq.start(d_seqrh[2]);
                        end
                join
        endtask
