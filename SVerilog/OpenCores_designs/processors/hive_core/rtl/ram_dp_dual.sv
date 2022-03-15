/*
--------------------------------------------------------------------------------

Module: ram_dp_dual.sv

Function: 
- Infers two parameterized dual port synchronous RAMs.

Instantiates: 
- Nothing (block RAM should be synthesized).

Notes:
- All ports are in the same clock domain.
- Writes accept data after the address & write enable on the clock.
- Reads present data after the address on the clock.
- Configurable read-during-write mode (for the same port).
- Optional output data registering (likely an internal BRAM resource).
- This module is kind of stupid but necessary due to the limited
  memory initialization options in SV.

--------------------------------------------------------------------------------
*/

module ram_dp_dual
	#(
	parameter										DATA_W			= 16,
	parameter										ADDR_W			= 13,
	parameter										A_REG				= 1,  // 1=enable A output registering
	parameter										B_REG				= 1,  // 1=enable B output registering
	parameter										A_MODE 			= "RAW",  // options here are "RAW" and "WAR"
	parameter										B_MODE 			= "WAR"  // options here are "RAW" and "WAR"
	)
	(
	// clock
	input			logic								clk_i,				// clock
	// port A
	input			logic	[ADDR_W-1:0]			a1_addr_i,			// A1 address
	input			logic	[ADDR_W-1:0]			a0_addr_i,			// A0 address
	input			logic								a1_wr_i,				// A1 write enable, active high
	input			logic								a0_wr_i,				// A0 write enable, active high
	input			logic	[DATA_W-1:0]			a1_i,					// A1 write data
	input			logic	[DATA_W-1:0]			a0_i,					// A0 write data
	output		logic	[DATA_W-1:0]			a1_o,					// A1 read data
	output		logic	[DATA_W-1:0]			a0_o,					// A0 read data
	// port B
	input			logic	[ADDR_W-1:0]			b1_addr_i,			// B1 address
	input			logic	[ADDR_W-1:0]			b0_addr_i,			// B0 address
	input			logic								b1_wr_i,				// B1 write enable, active high
	input			logic								b0_wr_i,				// B0 write enable, active high
	input			logic	[DATA_W-1:0]			b1_i,					// B1 write data
	input			logic	[DATA_W-1:0]			b0_i,					// B0 write data
	output		logic	[DATA_W-1:0]			b1_o,					// B1 read data
	output		logic	[DATA_W-1:0]			b0_o					// B0 read data
	);

	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	localparam										DEPTH		= 1<<ADDR_W;	// per memory storage
	(* ram_init_file = "hive_even.mif" *)	logic		[DATA_W-1:0]			ram0[0:DEPTH-1];
	(* ram_init_file = "hive_odd.mif" *)	logic		[DATA_W-1:0]			ram1[0:DEPTH-1];
	logic					[DATA_W-1:0]			a0_rd, a1_rd, b0_rd, b1_rd;
	//
	// `include "boot_code\boot_code_inv_f.sv"


	/*
	================
	== code start ==
	================
	*/


	// write
	always_ff @ ( posedge clk_i ) begin
		if ( a1_wr_i ) begin
			ram1[a1_addr_i] <= a1_i;
		end
		if ( a0_wr_i ) begin
			ram0[a0_addr_i] <= a0_i;
		end
	end
	
	always_ff @ ( posedge clk_i ) begin
		if ( b1_wr_i ) begin
			ram1[b1_addr_i] <= b1_i;
		end
		if ( b0_wr_i ) begin
			ram0[b0_addr_i] <= b0_i;
		end
	end


	// read
	always_ff @ ( posedge clk_i ) begin
		a1_rd <= ( a1_wr_i & A_MODE == "WAR" ) ? a1_i : ram1[a1_addr_i];
		a0_rd <= ( a0_wr_i & A_MODE == "WAR" ) ? a0_i : ram0[a0_addr_i];
		//
		b1_rd <= ( b1_wr_i & B_MODE == "WAR" ) ? b1_i : ram1[b1_addr_i];
		b0_rd <= ( b0_wr_i & B_MODE == "WAR" ) ? b0_i : ram0[b0_addr_i];
	end


	// optional output reg
	generate
		if ( A_REG ) begin
			always_ff @ ( posedge clk_i ) begin
				a1_o <= a1_rd;
				a0_o <= a0_rd;
			end
		end else begin
			always_comb a1_o = a1_rd;
			always_comb a0_o = a0_rd;
		end
		//
		if ( B_REG ) begin
			always_ff @ ( posedge clk_i ) begin
				b1_o <= b1_rd;
				b0_o <= b0_rd;
			end
		end else begin
			always_comb b1_o = b1_rd;
			always_comb b0_o = b0_rd;
		end
	endgenerate


endmodule
