/*
--------------------------------------------------------------------------------

Module: hive_version

Function: 
- Reports core version

Instantiates:
- (1x) hive_base_reg.sv

Notes:
- None.

--------------------------------------------------------------------------------
*/

module hive_version
	(
	// clocks & resets
	input		logic							clk_i,							// clock
	input		logic							rst_i,							// async. reset, active hi
	// rbus interface
	input		logic	[RBUS_ADDR_W-1:0]	rbus_addr_i,					// address
	input		logic							rbus_wr_i,						// data write enable, active high
	input		logic							rbus_rd_i,						// data read enable, active high
	input		logic	[ALU_W-1:0]			rbus_wr_data_i,				// write data
	output	logic	[ALU_W-1:0]			rbus_rd_data_o					// read data
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/	
	import hive_params::*; 
	import hive_defines::*; 


	
	/*
	================
	== code start ==
	================
	*/


	// rbus registers
	hive_base_reg
	#(
	.DATA_W			( ALU_W ),
	.ADDR_W			( RBUS_ADDR_W ),
	.ADDR				( `VER_ADDR ),
	.WR_MODE			( "THRU" ),
	.RD_MODE			( "THRU" ),
	.WR_MASK			( '0 )  // kill write side
	)
	ver_reg
	(
	.*,
	.reg_wr_o			(  ),
	.reg_rd_o			(  ),
	.reg_data_i			( CORE_VER ),
	.reg_data_o			(  )
	);

	
endmodule
