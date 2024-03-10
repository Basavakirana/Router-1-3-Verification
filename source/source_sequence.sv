class source_sequence extends uvm_sequence #(source_transaction);

        `uvm_object_utils(source_sequence)
//      bit[1:0] addr;

        extern function new (string name = "source_sequence");
//      extern task body;

        endclass

        function source_sequence::new (string name = "source_sequence");
                super.new(name);
        endfunction

//      task source_sequence::body;
//              if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
 //                  `uvm_fatal("seq","config data not got");
//      endtask

class small_source_sequence extends source_sequence;


        `uvm_object_utils(small_source_sequence)

        bit[1:0]addr;
        extern function new (string name = "small_source_sequence");
        extern task body;

        endclass

        function small_source_sequence::new (string name = "small_source_sequence");
                super.new(name);
        endfunction

        task small_source_sequence::body;
//              super.body();
 if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                   `uvm_fatal("seq","config data not got");
                req = source_transaction::type_id::create("req");
                start_item(req);
                assert(req.randomize with {header[7:2] inside {[1:15]}&& header[1:0] == addr ;});
                finish_item(req);
        endtask

class medium_source_sequence extends source_sequence;

        `uvm_object_utils(medium_source_sequence)

        bit[1:0]addr;
        extern function new (string name = "medium_source_sequence");
        extern task body;

        endclass

        function medium_source_sequence::new (string name = "medium_source_sequence");
                super.new(name);
        endfunction

        task medium_source_sequence::body;
//              super.body();
                if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                   `uvm_fatal("seq","config data not got");
                req = source_transaction::type_id::create("req");
                start_item(req);
                assert(req.randomize with {header[7:2] inside {[16:30]}&& header[1:0] == addr ;});
                finish_item(req);
        endtask



class big_source_sequence extends source_sequence;

        `uvm_object_utils(big_source_sequence)

        bit[1:0]addr;
        extern function new (string name = "big_source_sequence");
        extern task body;

        endclass

        function big_source_sequence::new (string name = "big_source_sequence");
                super.new(name);
        endfunction

        task big_source_sequence::body;
//              super.body();
                if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                   `uvm_fatal("seq","config data not got");
                req = source_transaction::type_id::create("req");
                start_item(req);
                assert(req.randomize with {header[7:2] inside {[31:63]}&& header[1:0] == addr ;});
                finish_item(req);
        endtask


class random_source_sequence extends source_sequence;

        `uvm_object_utils(random_source_sequence)

        bit[1:0]addr;
        extern function new (string name = "random_source_sequence");
        extern task body;

        endclass

        function random_source_sequence::new (string name = "random_source_sequence");
                super.new(name);
        endfunction

        task random_source_sequence::body;
//              super.body();
                if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
                   `uvm_fatal("seq","config data not got");
                req = source_transaction::type_id::create("req");
                start_item(req);
                assert(req.randomize with {header[7:2] == 16  && header[1:0] == addr ;});
                finish_item(req);
        endtask
