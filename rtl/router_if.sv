interface router_if(input bit clock);
logic[7:0]data_in;
logic [7:0]data_out;
logic resetn;
logic error;
logic busy;
logic valid_out;
logic pkt_valid;
logic read_enb;

clocking s_dr_cb@(posedge clock);
default input #1 output #1;
output data_in;
output pkt_valid;
output resetn;
input error;
input busy;
endclocking


clocking d_dr_cb@(posedge clock);
default input #1 output #1;
output read_enb;
input valid_out;
endclocking



clocking s_mon_cb@(posedge clock);
default input #1 output #1;
input data_in;
input pkt_valid;
input resetn;
input error;
input busy;
endclocking

clocking d_mon_cb@(posedge clock);
default input #1 output #1;
input read_enb;
input data_out;
endclocking

modport S_DR_MP(clocking s_dr_cb);
modport S_MON_MP(clocking s_mon_cb);
modport D_DR_MP(clocking d_dr_cb);
modport D_MON_MP(clocking d_mon_cb);




endinterface
