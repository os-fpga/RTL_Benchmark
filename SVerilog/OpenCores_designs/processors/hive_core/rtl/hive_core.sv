/*
--------------------------------------------------------------------------------

Module : hive_core.sv

--------------------------------------------------------------------------------

Function:
- General purpose barrel processor FPGA core with:
  - 8 threads & 8 stage pipeline
  - 8 indexed LIFO stacks per thread w/ pop control
  - 32 bit data
  - 16 bit opcode
  - 32 bit GPIO
  - Double buffered UART

Instantiates (at this level):
- hive_control_ring.sv
- hive_data_ring.sv
- hive_main_mem.sv
- hive_version.sv
- hive_error.sv

Dependencies:
- hive_pkg.sv

--------------------------------------------------------------------------------
*/

module hive_core
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	//
	input			logic								cla_i,						// clear all threads, active high
	input			logic	[THREADS-1:0]			xsr_i,						// external IRQ request
	// rbus interface
	output		logic	[RBUS_ADDR_W-1:0]		rbus_addr_o,				// address
	output		logic								rbus_wr_o,					// data write enable, active high
	output		logic								rbus_rd_o,					// data read enable, active high
	output		logic	[ALU_W-1:0]				rbus_wr_data_o,			// write data
	input			logic	[ALU_W-1:0]				rbus_rd_data_i				// read data
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*; 
	import hive_types::*; 
	//
	logic					[CODE_W-1:0]			opcode_6;
	logic												op_er;
	logic					[STK_W-1:0]				sa, sb;
	logic												imda;
	logic												sgn, ext, low;
	logic												lg;
	logic												add, sub, mul, shl, pow, pgc;
	logic												cls_im, pop_im, pop_a, pop_b, psh_a;
	logic												pop_er, psh_er;
	logic					[STACKS-1:0]			stk_im;
	logic					[ALU_W-1:0]				alu_im;
	logic					[MEM_IM_W-1:0]			mem_im;
	logic												flg_nz_2, flg_lz_2, flg_od_2, flg_ne_2, flg_lt_2;
	ID_T												id;
	PC_T												pc;
	logic					[ALU_W-1:0]				a, b, mem_4;
	logic												reg_rd, reg_wr;
	logic												mem_rd, mem_wr;
	logic												lit;
	logic					[ALU_W-1:0]				rbus_rd_data;
	logic					[ALU_W-1:0]				ver_rd_data, time_rd_data, vect_rd_data, error_rd_data;


	/*
	================
	== code start ==
	================
	*/


	// control ring
	hive_control_ring  hive_control_ring
	(
	.*,
	.opcode_i			( opcode_6 ),
	.op_er_o				( op_er ),
	.b_i					( b ),
	.alu_im_o			( alu_im ),
	.sa_o					( sa ),
	.sb_o					( sb ),
	.imda_o				( imda ),
	.sgn_o				( sgn ),
	.ext_o				( ext ),
	.low_o				( low ),
	.lg_o					( lg ),
	.add_o				( add ),
	.sub_o				( sub ),
	.mul_o				( mul ),
	.shl_o				( shl ),
	.pow_o				( pow ),
	.pgc_o				( pgc ),
	.lit_o				( lit ),
	.mem_im_o			( mem_im ),
	.mem_rd_o			( mem_rd ),
	.mem_wr_o			( mem_wr ),
	.reg_rd_o			( reg_rd ),
	.reg_wr_o			( reg_wr ),
	.stk_im_o			( stk_im ),
	.cls_im_o			( cls_im ),
	.pop_im_o			( pop_im ),
	.pop_a_o				( pop_a ),
	.pop_b_o				( pop_b ),
	.psh_a_o				( psh_a ),
	.flg_nz_2_i			( flg_nz_2 ),
	.flg_lz_2_i			( flg_lz_2 ),
	.flg_od_2_i			( flg_od_2 ),
	.flg_ne_2_i			( flg_ne_2 ),
	.flg_lt_2_i			( flg_lt_2 ),
	.id_o					( id ),
	.pc_o					( pc ),
	.rbus_addr_i		( rbus_addr_o ),
	.rbus_wr_i			( rbus_wr_o ),
	.rbus_rd_i			( rbus_rd_o ),
	.rbus_wr_data_i	( rbus_wr_data_o ),
	.time_rd_data_o	( time_rd_data ),
	.vect_rd_data_o	( vect_rd_data )
	);


	// data ring
	hive_data_ring  hive_data_ring
	(
	.*,
	.sa_i					( sa ),
	.sb_i					( sb ),
	.imda_i				( imda ),
	.sgn_i				( sgn ),
	.ext_i				( ext ),
	.low_i				( low ),
	.lg_i					( lg ),
	.add_i				( add ),
	.sub_i				( sub ),
	.mul_i				( mul ),
	.shl_i				( shl ),
	.pow_i				( pow ),
	.pgc_i				( pgc ),
	.mem_rd_i			( mem_rd ),
	.reg_rd_i			( reg_rd ),
	.reg_wr_i			( reg_wr ),
	.stk_im_i			( stk_im ),
	.cls_im_i			( cls_im ),
	.pop_im_i			( pop_im ),
	.pop_a_i				( pop_a ),
	.pop_b_i				( pop_b ),
	.psh_a_i				( psh_a ),
	.id_i					( id ),
	.alu_im_i			( alu_im ),
	.pc_2_i				( pc[2] ),
	.mem_4_i				( mem_4 ),
	.a_o					( a ),
	.b_o					( b ),
	.rbus_rd_data_i	( rbus_rd_data ),
	.flg_nz_2_o			( flg_nz_2 ),
	.flg_lz_2_o			( flg_lz_2 ),
	.flg_od_2_o			( flg_od_2 ),
	.flg_ne_2_o			( flg_ne_2 ),
	.flg_lt_2_o			( flg_lt_2 ),
	.pop_er_o			( pop_er ),
	.psh_er_o			( psh_er )
	);


	// big ORing of rbus read data
	always_comb rbus_rd_data = 
		ver_rd_data | 
		time_rd_data | 
		vect_rd_data |
		error_rd_data |
		rbus_rd_data_i;


	// instruction and data memory
	hive_main_mem  hive_main_mem
	(
	.*,
	.lit_i				( lit ),
	.low_i				( low ),
	.wr_i					( mem_wr ),
	.pc_1_i				( pc[1] ),
	.im_i					( mem_im ),
	.b_i					( b ),
	.a_i					( a ),
	.mem_4_o				( mem_4 ),
	.pc_4_i				( pc[4] ),
	.opcode_6_o			( opcode_6 )
	);


	// version
	hive_version  hive_version
	(
	.*,
	.rbus_addr_i		( rbus_addr_o ),
	.rbus_wr_i			( rbus_wr_o ),
	.rbus_rd_i			( rbus_rd_o ),
	.rbus_wr_data_i	( rbus_wr_data_o ),
	.rbus_rd_data_o	( ver_rd_data )
	);


	// error
	hive_error  hive_error
	(
	.*,
	.rbus_addr_i		( rbus_addr_o ),
	.rbus_wr_i			( rbus_wr_o ),
	.rbus_rd_i			( rbus_rd_o ),
	.rbus_wr_data_i	( rbus_wr_data_o ),
	.rbus_rd_data_o	( error_rd_data ),
	.op_er_i				( op_er ),
	.pop_er_i			( pop_er ),
	.psh_er_i			( psh_er ),
	.id_i					( id )
	);


endmodule
