class dest_sequence extends uvm_sequence #(dest_transaction);

        `uvm_object_utils(dest_sequence)

        bit[1:0]addr;
        extern function new (string name = "dest_sequence");

        endclass

        function dest_sequence::new (string name = "dest_sequence");
                super.new(name);
        endfunction

class true_dest_sequence extends dest_sequence;

        `uvm_object_utils(true_dest_sequence)

        extern function new (string name = "true_dest_sequence");
        extern task body;

        endclass

        function true_dest_sequence::new (string name = "true_dest_sequence");
                super.new(name);
        endfunction

        task true_dest_sequence::body;
                req = dest_transaction::type_id::create("req");
                start_item(req);
                assert(req.randomize with {cycle inside {[1:28]};});
$display("RANDOMIZED RD SEQ");
`uvm_info("ROUTER RD SEQ",$sformatf("printing from rd seq \n %s",req.sprint()),UVM_LOW)

$display("PRINTED SEQ");
                finish_item(req);
        endtask

class false_dest_sequence extends dest_sequence;

        `uvm_object_utils(false_dest_sequence)

        extern function new (string name = "false_dest_sequence");
        extern task body;

        endclass

        function false_dest_sequence::new (string name = "false_dest_sequence");
                super.new(name);
        endfunction

        task false_dest_sequence::body;
                req = dest_transaction::type_id::create("req");
                start_item(req);
                assert(req.randomize with {cycle inside {[30:40]};});
                finish_item(req);
        endtask
