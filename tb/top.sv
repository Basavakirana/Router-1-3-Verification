
module top;

        bit clock;
        always #5 clock = ~clock;
        // import ram_test_pkg
        import router_test_pkg::*;


        // import the UVM package
        import uvm_pkg::*;

        // include the uvm_macros.svh
        `include "uvm_macros.svh"

        router_if in(clock);
        router_if in0(clock);
        router_if in1(clock);
        router_if in2(clock);
        router_top RTL ( .data_in(in.data_in),.pkt_valid(in.pkt_valid),.clk(clock),.rst(in.resetn),.err(in.error),.busy(in.busy),
                         .rd_en0(in0.read_enb),.data_out0(in0.data_out),.vld_out0(in0.valid_out),
                         .rd_en1(in1.read_enb),.data_out1(in1.data_out),.vld_out1(in1.valid_out),
                         .rd_en2(in2.read_enb),.data_out2(in2.data_out),.vld_out2(in2.valid_out));


  // Within initial block
     // Call run_test("ram_random_test")
        initial begin
                uvm_config_db #(virtual router_if)::set(null,"*","vif",in);
                uvm_config_db #(virtual router_if)::set(null,"*","vif[0]",in0);
                uvm_config_db #(virtual router_if)::set(null,"*","vif[1]",in1);
                uvm_config_db #(virtual router_if)::set(null,"*","vif[2]",in2);
                run_test();
        end
endmodule : top
