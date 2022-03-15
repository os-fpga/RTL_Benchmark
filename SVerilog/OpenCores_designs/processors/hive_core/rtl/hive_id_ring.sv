/*
--------------------------------------------------------------------------------

Module : hive_id_ring.sv

--------------------------------------------------------------------------------

Function:
- Processor thread id pipeline.

Instantiates:
- (1x) hive_base_reg.sv

Dependencies:
- hive_pkg.sv

Notes:
- 8 stage pipeline.
- Counter in stage 1 ensures long-term correct operation.

--------------------------------------------------------------------------------
*/

module hive_id_ring
	(
	// clocks & resets
	input			logic								clk_i,  // clock
	input			logic								rst_i,  // async. reset, active high
	// threads
	output		ID_T								id_o,
	// rbus interface
	input			logic	[RBUS_ADDR_W-1:0]		rbus_addr_i,				// address
	input			logic								rbus_wr_i,					// data write enable, active high
	input			logic								rbus_rd_i,					// data read enable, active high
	input			logic	[ALU_W-1:0]				rbus_wr_data_i,			// write data
	output		logic	[ALU_W-1:0]				rbus_rd_data_o				// read data
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*; 
	import hive_types::*; 
	import hive_rst_vals::*; 
	//
	logic		[ALU_W-1:0]							time_2;


	/*
	================
	== code start ==
	================
	*/

	// time counter & id pipe
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			id_o[0] <= ID_RST[0];
			id_o[1] <= ID_RST[1];
			time_2  <= ID_RST[2];
			id_o[3] <= ID_RST[3];
			id_o[4] <= ID_RST[4];
			id_o[5] <= ID_RST[5];
			id_o[6] <= ID_RST[6];
			id_o[7] <= ID_RST[7];
		end else begin
			id_o[0] <= id_o[7];
			id_o[1] <= id_o[0];
			time_2  <= time_2 + 1'b1;
			id_o[3] <= id_o[2];
			id_o[4] <= id_o[3];
			id_o[5] <= id_o[4];
			id_o[6] <= id_o[5];
			id_o[7] <= id_o[6];
		end
	end

	// connect time counter to id pipe
	always_comb id_o[2] = THD_W'(time_2);


	/*
	-----------------
	-- time_id_reg --
	-----------------
	*/

	hive_base_reg
	#(
	.DATA_W			( ALU_W ),
	.ADDR_W			( RBUS_ADDR_W ),
	.ADDR				( `TIME_ADDR ),
	.WR_MODE			( "THRU" ),
	.RD_MODE			( "THRU" ),
	.WR_MASK			( '0 )  // kill write side
	)
	time_reg
	(
	.*,
	.reg_wr_o		(  ),
	.reg_rd_o		(  ),
	.reg_data_o		(  ),
	.reg_data_i		( time_2 )
	);


endmodule
