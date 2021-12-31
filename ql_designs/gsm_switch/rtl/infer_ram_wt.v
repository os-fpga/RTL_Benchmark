
// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: infer_ram_wr.v
// Description	: infer a write through ram 
// Author	: Zefu Dai
// -------------------------------------------------------------------------------
// Version			: 
//	-- 2012-07-03 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

`include "timescale.v"

module infer_ram_wt
#(
	parameter	DWIDTH	= 18,	// data width of the SRAM, 36 bit when configured to be SDP BRAM, otherwise 18 bit wide
	parameter	AWIDTH	= 10		// address width of the SRAM
)
(
	// global
	input wire	clk_a,
	input wire	clk_b,
	
	// port a interface
	input	wire	en_a,
	input	wire	write_a,
	input	wire	[DWIDTH-1:0]	din_a,
	input	wire	[AWIDTH-1:0]	addr_a,
	output	wire 	[DWIDTH-1:0]	dout_a,
	
	// port b interface
	input	wire	en_b,
	input	wire	write_b,
	input	wire	[DWIDTH-1:0]	din_b,
	input	wire	[AWIDTH-1:0]	addr_b,
	output	wire 	[DWIDTH-1:0]	dout_b
	);
	
	alt_infer_ram_wt  
	#(
		.DWIDTH(DWIDTH),
		.AWIDTH(AWIDTH)
	) 
	alt_infer_ram_wt_inst (
		.clk_a(clk_a),
		.clk_b(clk_b),
		//.write_a(en_a&write_a),
    .write_a(write_a),
    .en_a(en_a),
		.din_a(din_a),
		.addr_a(addr_a),
		.dout_a(dout_a),
		//.write_b(en_b&write_b),
    .write_b(write_b),
    .en_b(en_b),
		.din_b(din_b),
		.addr_b(addr_b),
		.dout_b(dout_b)
		);

endmodule 

//Fix for altera ram inference
//Quartus does not like both write enable and general enables
module alt_infer_ram_wt
#(
	parameter	DWIDTH	= 18,	// data width of the SRAM, 36 bit when configured to be SDP BRAM, otherwise 18 bit wide
	parameter	AWIDTH	= 10		// address width of the SRAM
)
(
	// global
	input wire	clk_a,
	input wire	clk_b,
	
	// port a interface
	input	wire	en_a,
	input	wire	write_a,
	input	wire	[DWIDTH-1:0]	din_a,
	input	wire	[AWIDTH-1:0]	addr_a,
	output wire 	[DWIDTH-1:0]	dout_a,
	
	// port b interface
	input	wire	en_b,
	input	wire	write_b,
	input	wire	[DWIDTH-1:0]	din_b,
	input	wire	[AWIDTH-1:0]	addr_b,
	output	reg 	[DWIDTH-1:0]	dout_b
	
);
	//(* RAM_STYLE="BLOCK" *)
	//(* ramstyle = "M9K" *) reg	[DWIDTH-1:0] generic_ram [(2**AWIDTH)-1:0];
  reg	[DWIDTH-1:0] generic_ram [(2**AWIDTH)-1:0];
  
  wire clk_int;
  wire wr_int;
  wire	[DWIDTH-1:0]	din;
  wire	[AWIDTH-1:0]	addr;
  
  assign clk_int = (en_a)? clk_a: clk_b;
  assign wr_int = (en_a)? write_a: (write_b & en_b);
  assign din = (en_a)? din_a: din_b;
  assign addr = (en_a)? addr_a: addr_b;

  always @(posedge clk_int)
  begin
    if (wr_int)
      generic_ram[addr] <= din;
    dout_b <= generic_ram[addr_b];
	end
  
  assign dout_a = 0;

/*	 
    always @(posedge clk_b)begin
//	    if (en_b) begin
            if (write_b)begin
                generic_ram[addr_b] <= din_b;
                dout_b <= din_b;
            end
            else
                dout_b <= generic_ram[addr_b];
//        end
	end
*/
endmodule
