/*
--------------------------------------------------------------------------------

Module: ram_dq.sv

Function: 
- Infers a parameterized simple DQ synchronous RAM.

Instantiates: 
- Nothing (block RAM should be synthesized).

Notes:
- Writes accept data after the address & write enable on the clock.
- Reads present data after the address on the clock.
- Configurable read-during-write mode.
- Optional output data registering (likely an internal BRAM resource).

--------------------------------------------------------------------------------
*/

module ram_dq
	#(
	parameter										REG_OUT			= 1,  // 1=enable output registering
	parameter										DATA_W			= 16,
	parameter										ADDR_W			= 8,
	parameter										MODE 				= "WAR"  // options here are "RAW" and "WAR"
	)
	(
	input			logic								clk_i,			// clock
	input			logic	[ADDR_W-1:0]			addr_i,			// address
	input			logic								wr_i,				// write enable, active high
	input			logic	[DATA_W-1:0]			data_i,			// write data
	output		logic	[DATA_W-1:0]			data_o			// read data
	);

	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	localparam										CAPACITY			= 2**ADDR_W;  // total words possible to store
	logic					[DATA_W-1:0]			ram[0:CAPACITY-1];  // memory
	logic					[DATA_W-1:0]			data_rd;	



	/*
	================
	== code start ==
	================
	*/



	// write
	always_ff @ ( posedge clk_i ) begin
		if ( wr_i ) begin
			ram[addr_i] <= data_i;
		end
	end

	// read
	always_ff @ ( posedge clk_i ) begin
		data_rd <= ( wr_i & MODE == "WAR" ) ? data_i : ram[addr_i];
	end

	// optional output reg
	generate
		if ( REG_OUT ) begin
			always_ff @ ( posedge clk_i ) begin
				data_o <= data_rd;
			end
		end else begin
			always_comb data_o = data_rd;
		end
	endgenerate


endmodule
