class source_transaction extends uvm_sequence_item;

        `uvm_object_utils(source_transaction)

        rand bit[7:0] header;
        rand bit[7:0]payload_data[];
        bit[7:0] parity;
        bit error;

        constraint c1{header[1:0]!= 3;}
        constraint c2{payload_data.size == header[7:2];}
        constraint c3{header[7:2] != 0;}

        extern function new (string name = "source_transaction");
        extern function void do_print (uvm_printer printer);
        extern function void post_randomize();

        endclass

        function source_transaction::new (string name = "source_transaction");
                super.new(name);
        endfunction

        function void source_transaction::do_print (uvm_printer printer);
                printer.print_field("header", this.header,8, UVM_BIN);
          foreach(payload_data[i])
                printer.print_field($sformatf("payload_data[%0d]",i), this.payload_data[i],8, UVM_DEC);
                printer.print_field("parity", this.parity,8, UVM_DEC);
        endfunction

        function void source_transaction::post_randomize();
                parity = header;
                foreach(payload_data[i])
                    begin
                         parity = payload_data[i] ^ parity;
                    end
        endfunction
~
