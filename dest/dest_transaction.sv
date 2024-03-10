class dest_transaction extends uvm_sequence_item;

        `uvm_object_utils(dest_transaction)

        bit[7:0] header;
        bit[7:0] payload_data[];
        bit[7:0] parity;
        rand bit[5:0] cycle;

        extern function new (string name = "dest_transaction");
        extern function void do_print (uvm_printer printer);

        endclass

        function dest_transaction::new (string name = "dest_transaction");
                super.new(name);
        endfunction

        function void dest_transaction::do_print (uvm_printer printer);
                printer.print_field("header",this.header,8,UVM_DEC);
                foreach(payload_data[i])
                        printer.print_field($sformatf("payload_data[%0d]",i),this.payload_data[i],8,UVM_DEC);
                printer.print_field("parity",this.parity,8,UVM_DEC);
                printer.print_field("cycle",this.cycle,6,UVM_DEC);
        endfunction
