/*
--------------------------------------------------------------------------------

Module : hive_pkg.sv

--------------------------------------------------------------------------------

Function:
- Packages for hive processor

Instantiates: 
- Nothing.

Dependencies:
- None.

--------------------------------------------------------------------------------
*/
package hive_params;

	// version
	parameter CORE_VER		= 'h806;	// core version

	// basic params, do not change unless you know what you are doing!
	parameter THREADS			= 8;		// number of threads (=pipe stages)
	parameter STACKS			= 8;		// number of stacks per thread
	parameter CODE_W			= 16;		// opcode width
	parameter ALU_W			= 32;		// alu width
	parameter MEM_IM_W		= 5;		// main memory immediate width
	parameter LG_W				= 4;		// logic function selector width
	parameter TST_W			= 4;		// test field width
	// ok to change
	parameter PC_W				= 13;		// pc width (s/b >= MEM_ADDR_W)
	parameter MEM_ADDR_W		= 13;		// main memory address width
	parameter MEM_ROM_W		= 0;		// main memory rom area address width (0=disable)
	parameter RBUS_ADDR_W	= 6;		// register set address width
	parameter STK_PTR_W		= 5;		// stack pointer width
	parameter PROT_POP		= 1;		// 1=stacks pop error protection, 0=none
	parameter PROT_PSH		= 1;		// 1=stacks push error protection, 0=none
	parameter CLK_HZ	 		= 160000000;	// core clock rate (Hz)
	parameter SYNC_W 			= 2;		// number of resync regs (1 or larger)

	// derivations of basic params
	parameter ZSX_W			= ALU_W+1;
	parameter DBL_W			= ALU_W<<1;
	parameter LOW_W			= ALU_W>>1;
	parameter MEM_DEPTH		= 1<<MEM_ADDR_W;
	parameter THD_W			= $clog2(THREADS);
	parameter STK_W			= $clog2(STACKS);
	parameter STK_LVL_W		= STK_PTR_W+1;	// stack level width

	// vector params (ok to change)
	parameter [PC_W-1:0] CLT_BASE = 'h0;	// thread clear address base (concat)
	parameter [PC_W-1:0] CLT_SPAN = 2;		// thread clear address span (2^n)
	parameter [PC_W-1:0] IRQ_BASE = 'h20;	// interrupt address base (concat)
	parameter [PC_W-1:0] IRQ_SPAN = 2;		// interrupt address span (2^n)
	parameter [THREADS-1:0] XSR_LIVE_MASK = '1;		// 1=enable input
	parameter [THREADS-1:0] XSR_SYNC_MASK = '1;		// 1=resync input
	parameter [THREADS-1:0] XSR_RISE_MASK = '1;		// 1=detect rising edge
	parameter [THREADS-1:0] XSR_FALL_MASK = '1;		// 1=detect falling edge

	// uart params (ok to change)
	parameter UART_DATA_W		= 8;		// uart data width (bits)
	parameter UART_BAUD			= 115200;	// uart baud rate (Hz)
	parameter UART_OSR			= 16;		// uart oversample rate (3 or larger)
	parameter UART_STOP_BITS	= 1;		// number of stop bits

endpackage



package hive_defines;

	// lg alias values
	`define lg_cpy		4'h0
	`define lg_bnh		4'h1
	`define lg_cpy_s	4'h2
	`define lg_cpy_u	4'h3
	`define lg_not		4'h4
	`define lg_and		4'h5
	`define lg_orr		4'h6
	`define lg_xor		4'h7
	`define lg_bra		4'h8
	`define lg_bro		4'h9
	`define lg_brx		4'ha
	`define lg_flp		4'hc
	`define lg_lzc		4'hd

	
	// test alias values
	`define tst_z		2'h0
	`define tst_nz		2'h1
	`define tst_lz		2'h2
	`define tst_nlz	2'h3
	//
	`define tst_e		3'h0
	`define tst_ne		3'h1
	`define tst_ls		3'h2
	`define tst_nls	3'h3
	`define tst_o		3'h4
	`define tst_no		3'h5
	`define tst_lu		3'h6
	`define tst_nlu	3'h7


	// defines for bootcode readability
	`define __			4'h0
	`define s0			4'h0
	`define s1			4'h1
	`define s2			4'h2
	`define s3			4'h3
	`define s4			4'h4
	`define s5			4'h5
	`define s6			4'h6
	`define s7			4'h7
	`define P0			4'h8
	`define P1			4'h9
	`define P2			4'ha
	`define P3			4'hb
	`define P4			4'hc
	`define P5			4'hd
	`define P6			4'he
	`define P7			4'hf


	// encode opcode prefixes
	`define nop			{4'h0, 4'h0, 4'h0, 4'h0}
	`define pop			{4'h0, 4'h1}
	`define cls			{4'h0, 4'h2}
	`define jmp_8		{4'h0, 4'h4}
	//
	`define pgc			{4'h0, 4'h8}
	`define lit			{4'h0, 4'hc}
	`define lit_s		{4'h0, 4'hd}
	`define lit_u		{4'h0, 4'hf}
	//
	`define skp_e		{4'h1, 1'b0, `tst_e}
	`define skp_ne		{4'h1, 1'b0, `tst_ne}
	`define skp_ls		{4'h1, 1'b0, `tst_ls}
	`define skp_nls	{4'h1, 1'b0, `tst_nls}
	`define skp_o		{4'h1, 1'b0, `tst_o}
	`define skp_no		{4'h1, 1'b0, `tst_no}
	`define skp_lu		{4'h1, 1'b0, `tst_lu}
	`define skp_nlu	{4'h1, 1'b0, `tst_nlu}
	//
	`define sk2_e		{4'h1, 1'b1, `tst_e}
	`define sk2_ne		{4'h1, 1'b1, `tst_ne}
	`define sk2_ls		{4'h1, 1'b1, `tst_ls}
	`define sk2_nls	{4'h1, 1'b1, `tst_nls}
	`define sk2_o		{4'h1, 1'b1, `tst_o}
	`define sk2_no		{4'h1, 1'b1, `tst_no}
	`define sk2_lu		{4'h1, 1'b1, `tst_lu}
	`define sk2_nlu	{4'h1, 1'b1, `tst_nlu}
	//
	`define jmp_z		{4'h2, 2'b00, `tst_z}
	`define jmp_nz		{4'h2, 2'b00, `tst_nz}
	`define jmp_lz		{4'h2, 2'b00, `tst_lz}
	`define jmp_nlz	{4'h2, 2'b00, `tst_nlz}
	`define gto_z		{4'h2, 2'b01, `tst_z}
	`define gto_nz		{4'h2, 2'b01, `tst_nz}
	`define gto_lz		{4'h2, 2'b01, `tst_lz}
	`define gto_nlz	{4'h2, 2'b01, `tst_nlz}
	`define jmp			{4'h2, 4'hc}
	`define gto			{4'h2, 4'hd}
	`define irt			{4'h2, 4'he}
	`define gsb			{4'h2, 4'hf}
	//
	`define cpy			{4'h3, `lg_cpy}
	`define bnh			{4'h3, `lg_bnh}
	`define cpy_s		{4'h3, `lg_cpy_s}
	`define cpy_u		{4'h3, `lg_cpy_u}
	`define not			{4'h3, `lg_not}
	`define and			{4'h3, `lg_and}
	`define orr			{4'h3, `lg_orr}
	`define xor			{4'h3, `lg_xor}
	`define bra			{4'h3, `lg_bra}
	`define bro			{4'h3, `lg_bro}
	`define brx			{4'h3, `lg_brx}
	`define flp			{4'h3, `lg_flp}
	`define lzc			{4'h3, `lg_lzc}
	//
	`define mem_r		4'h4
	`define mem_w		4'h5
	`define mem_rs		4'h6
	`define mem_wl		4'h7
	//
	`define add			{4'h8, 4'h0}
	`define add_s		{4'h8, 4'h2}
	`define add_u		{4'h8, 4'h3}
	`define sub			{4'h8, 4'h4}
	`define sub_s		{4'h8, 4'h6}
	`define sub_u		{4'h8, 4'h7}
	`define mul			{4'h8, 4'h8}
	`define mul_s		{4'h8, 4'ha}
	`define mul_u		{4'h8, 4'hb}
	`define shl_s		{4'h8, 4'hc}
	`define shl_u		{4'h8, 4'hd}
	`define pow			{4'h8, 4'he}
	//
	`define shl_6s		{4'h9, 2'b00}
	`define shp_6u		{4'h9, 2'b01}
	`define reg_r		{4'h9, 2'b10}
	`define reg_w		{4'h9, 2'b11}
	//
	`define add_8		4'ha
	`define byt			4'hb
	//
	`define jmp_8z		{2'b11, `tst_z}
	`define jmp_8nz	{2'b11, `tst_nz}
	`define jmp_8lz	{2'b11, `tst_lz}
	`define jmp_8nlz	{2'b11, `tst_nlz}


	// encode register set addresses
	`define VER_ADDR		6'h0 
	`define TIME_ADDR		6'h1
	`define VECT_ADDR		6'h2
	`define ERROR_ADDR	6'h3
	`define UART_ADDR		6'h4
	`define GPIO_ADDR		6'h5

endpackage



package hive_types;

	// we need these
	import hive_defines::*;
	import hive_params::*;

	
	// thread ID type
	typedef logic [THD_W-1:0] ID_T[THREADS];

	
	// program counter type
	typedef logic [PC_W-1:0] PC_T[THREADS];


	// enumerated test type
	typedef enum logic [TST_W-1:0] 
		{
		tst_z		= {2'b0, `tst_z},
		tst_nz	= {2'b0, `tst_nz},
		tst_lz	= {2'b0, `tst_lz},
		tst_nlz	= {2'b0, `tst_nlz},
		tst_e		= {1'b1, `tst_e},
		tst_ne	= {1'b1, `tst_ne},
		tst_ls	= {1'b1, `tst_ls},
		tst_nls	= {1'b1, `tst_nls},
		tst_o		= {1'b1, `tst_o},
		tst_no	= {1'b1, `tst_no},
		tst_lu	= {1'b1, `tst_lu},
		tst_nlu	= {1'b1, `tst_nlu}
		} TST_T;


	// enumerated logical function select type
	typedef enum logic [LG_W-1:0] 
		{
		lg_cpy	= `lg_cpy,
		lg_bnh	= `lg_bnh,
		lg_not	= `lg_not,
		lg_and	= `lg_and,
		lg_orr	= `lg_orr,
		lg_xor	= `lg_xor,
		lg_bra	= `lg_bra,
		lg_bro	= `lg_bro,
		lg_brx	= `lg_brx,
		lg_flp	= `lg_flp,
		lg_lzc	= `lg_lzc
		} LG_T;


	// a few defines for readability
	`define ax			4'hx
	`define bx			4'hx
	`define i4x			4'hx
	`define i6x			6'bxxxxxx
	`define i8x			8'hxx


endpackage



package hive_rst_vals;

	// we need these
	import hive_params::*;
	import hive_types::*;

	// ID reset values
	parameter ID_T ID_RST = '{ 1, 0, 7, 6, 5, 4, 3, 2 };

endpackage



package hive_funcs;

	// we need these
	import hive_params::*;

	// return leading zero count of input value
	function automatic logic [ALU_W-1:0] lzc;
	input logic [ALU_W-1:0] in;
	integer j;
		begin
			lzc = ALU_W'( ALU_W );
			// priority encoder (find MSB 1 position)
			for (j = 0; j < ALU_W; j = j + 1) begin 
				if (in[j]) begin
					lzc = ALU_W'( ALU_W - 1 - j );
				end
			end
		end
	endfunction

	// flip input value
	function automatic logic [ALU_W-1:0] flip;
	input logic [ALU_W-1:0] in;
	integer i;
		begin
			for (i = 0; i < ALU_W; i = i + 1) begin
				flip[i] = in[ALU_W-1-i];
			end
		end
	endfunction

endpackage
