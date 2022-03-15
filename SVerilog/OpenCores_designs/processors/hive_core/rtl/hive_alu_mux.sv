/*
--------------------------------------------------------------------------------

Module : hive_alu_mux.sv

--------------------------------------------------------------------------------

Function:
- Multiplexer for processor ALU.

Instantiates:
- (5x) pipe.sv

Dependencies:
- hive_pkg.sv

Notes:
- Inputs at stage 0, outputs at stage 6.
- Default behavior is logical pass-thru.

--------------------------------------------------------------------------------
*/

module hive_alu_mux
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// control I/O
	input			logic								sgn_i,						// 1=signed
	input			logic								low_i,						// 1=low
	input			logic								as_i,							// 1=add/subtract
	input			logic								ms_i,							// 1=multiply/shift
	input			logic								pgc_i,						// 1=return pc
	input			logic								reg_rd_i,					// 1=read
	input			logic								mem_rd_i,					// 1=read
	// data I/O
	input			logic	[ALU_W-1:0]				res_lg_2_i,					// logical result
	input			logic	[ALU_W-1:0]				res_as_2_i,					// add/subtract result
	input			logic	[PC_W-1:0]				pc_2_i,						// program counter
	input			logic	[ALU_W-1:0]				rbus_rd_data_i,			// rbus read data
	input			logic	[ALU_W-1:0]				mem_4_i,						// mem read data
	input			logic	[ALU_W-1:0]				res_ms_5_i,					// multiply/shift result
	output		logic	[ALU_W-1:0]				data_6_o						// data out
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	//
	logic												pgc_2;
	logic												as_2;
	logic												reg_rd_2, reg_rd_3;
	logic												low_2, low_3, low_4, low_5;
	logic												sgn_2, sgn_3, sgn_4, sgn_5;
	logic												mem_rd_2, mem_rd_3, mem_rd_4;
	logic												ms_2, ms_3, ms_4, ms_5;
	logic					[ALU_W-1:0]				data_3, data_4, data_5;
	logic					[ALU_W-1:0]				mux_2, mux_3, mux_4, mux_5;
	logic					[ALU_W-1:0]				rbus_rd_data_3;


	/*
	================
	== code start ==
	================
	*/


	// 0 to 2 regs
	pipe
	#(
	.DEPTH		( 2 ),
	.WIDTH		( 7 ),
	.RESET_VAL	( 0 )
	)
	regs_0_2
	(
	.*,
	.data_i		( { pgc_i, as_i, reg_rd_i, mem_rd_i, ms_i, sgn_i, low_i } ),
	.data_o		( { pgc_2, as_2, reg_rd_2, mem_rd_2, ms_2, sgn_2, low_2   } )
	);


	// mux 2
	always_comb begin
		unique casex ( { pgc_2, as_2 } )
			'b01    : mux_2 <= res_as_2_i;  // arithmetic
			'b1x    : mux_2 <= pc_2_i;  // pc unsigned
			default : mux_2 <= res_lg_2_i;  // default is logical pass-thru
		endcase
	end


	// 2 to 3 regs
	pipe
	#(
	.DEPTH		( 1 ),
	.WIDTH		( 5+ALU_W+ALU_W ),
	.RESET_VAL	( 0 )
	)
	regs_2_3
	(
	.*,
	.data_i		( { reg_rd_2, mem_rd_2, ms_2, sgn_2, low_2, rbus_rd_data_i, mux_2  } ),
	.data_o		( { reg_rd_3, mem_rd_3, ms_3, sgn_3, low_3, rbus_rd_data_3, data_3 } )
	);


	// mux 3
	always_comb begin
		unique casex ( reg_rd_3 )
			'b1     : mux_3 <= rbus_rd_data_3;  // reg read
			default : mux_3 <= data_3;  // default is pass-thru
		endcase
	end


	// 3 to 4 regs
	pipe
	#(
	.DEPTH		( 1 ),
	.WIDTH		( 4+ALU_W ),
	.RESET_VAL	( 0 )
	)
	regs_3_4
	(
	.*,
	.data_i		( { mem_rd_3, ms_3, sgn_3, low_3, mux_3  } ),
	.data_o		( { mem_rd_4, ms_4, sgn_4, low_4, data_4 } )
	);


	// mux 4
	always_comb begin
		unique casex ( mem_rd_4 )
			'b1     : mux_4 <= mem_4_i;
			default : mux_4 <= data_4;  // default is pass-thru
		endcase
	end


	// 4 to 5 regs
	pipe
	#(
	.DEPTH		( 1 ),
	.WIDTH		( 3+ALU_W ),
	.RESET_VAL	( 0 )
	)
	regs_4_5
	(
	.*,
	.data_i		( { ms_4, sgn_4, low_4, mux_4  } ),
	.data_o		( { ms_5, sgn_5, low_5, data_5 } )
	);


	// mux 5
	always_comb begin
		unique casex ( { ms_5, sgn_5, low_5 } )
			'b001   : mux_5 <= data_5[LOW_W-1:0];  // low zero extend
			'b011   : mux_5 <= $signed( data_5[LOW_W-1:0] );  // low sign extend
			'b1xx   : mux_5 <= res_ms_5_i;  // mult result
			default : mux_5 <= data_5;  // default is logical pass-thru
		endcase
	end


	// 5 to 6 regs
	pipe
	#(
	.DEPTH		( 1 ),
	.WIDTH		( ALU_W ),
	.RESET_VAL	( 0 )
	)
	d_out_regs
	(
	.*,
	.data_i		( mux_5 ),
	.data_o		( data_6_o )
	);

	
endmodule
