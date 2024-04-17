`include "sp_ram.sv"
module sp_ram_top  #(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10) (
	input [(DATA_WIDTH-1):0] data,data1,
	input [(ADDR_WIDTH-1):0] addr,addr1,
	input we, we1,clk,
	output [(DATA_WIDTH-1):0] q,q1
);

sp_ram # (
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  )
  sp_ram_inst (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
  );

  sp_ram # (
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  )
  sp_ram_inst1 (
    .data(data1),
    .addr(addr1),
    .we(we1),
    .clk(clk),
    .q(q1)
  );

endmodule 
