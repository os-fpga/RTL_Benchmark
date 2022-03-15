/*
--------------------------------------------------------------------------------

Module : hive_op_decode.sv

--------------------------------------------------------------------------------

Function:
- Opcode decoder for hive processor.

Instantiates: 
- Nothing.

Dependencies:
- hive_pkg.sv

Notes:
- I/O registered.
- Operates on the current thread in the stage (i.e. no internal state).
- Illegal opcodes are only flagged, not necessarily safely decoded as NOP.

--------------------------------------------------------------------------------
*/

module hive_op_decode
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// state I/O
	input			logic								clt_i,						// clear thread, active high
	output		logic								clt_o,						// clear thread
	input			logic								irq_i,						// irq, active high
	output		logic								irq_o,						// irq, active high
	output		logic								irt_o,						// irq return, active high
	input			logic	[CODE_W-1:0]			opcode_i,					// opcode
	output		logic								op_er_o,						// 1=illegal operation encountered
	// data I/O
	output		logic	[STACKS-1:0]			stk_im_o,					// stack immediate
	output		logic	[ALU_W-1:0]				alu_im_o,					// alu immediate
	output		logic	[PC_W-1:0]				pc_im_o,						// pc immediate
	output		logic	[MEM_IM_W-1:0]			mem_im_o,					// mem immediate
	// pc pipe control
	output		logic								cnd_o,						// 1 : conditional
	output		logic								lit_o,						// 1 : pc=pc++ for literal data
	output		logic								jmp_o,						// 1 : pc=pc+B|I for jump (cond)
	output		logic								gto_o,						// 1 : pc=B for goto / gosub / irt
	// conditional masks
	output		TST_T								tst_o,						// test field
	// stacks control
	output		logic								cls_im_o,					// stack clear (stk_im_o)
	output		logic								pop_im_o,					// stack pop (from stk_im_o)
	output		logic								pop_a_o,						// stack a pop (from sa_o)
	output		logic								pop_b_o,						// stack b pop (from sb_o)
	output		logic								psh_a_o,						// stack push (to sa_o)
	output		logic	[STK_W-1:0]				sa_o,							// a stack selector
	output		logic	[STK_W-1:0]				sb_o,							// b stack selector
	// immediate flags
	output		logic								imda_o,						// 1=immediate data
	output		logic								imad_o,						// 1=immediate address
	// alu control
	output		logic								sgn_o,						// 1=signed
	output		logic								ext_o,						// 1=extended
	output		logic								low_o,						// 1=low
	output		LG_T								lg_o,							// logic operation
	output		logic								add_o,						// 1=add
	output		logic								sub_o,						// 1=subtract
	output		logic								mul_o,						// 1=multiply
	output		logic								shl_o,						// 1=shift left
	output		logic								pow_o,						// 1=power of 2
	output		logic								pgc_o,						// 1=return pc
	output		logic								mem_rd_o,					// 1=mem read
	output		logic								mem_wr_o,					// 1=mem write
	output		logic								reg_rd_o,					// 1=reg read
	output		logic								reg_wr_o						// 1=reg write
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*;
	import hive_types::*;
	//
	logic					[CODE_W-1:0]			oc;
	logic												clt, irq;
	logic					[STK_W-1:0]				oc_sa, oc_sb;
	logic 											oc_pa, oc_pb;
	TST_T												oc_tl_ab, oc_th_az, oc_tl_az;
	logic					[3:0]						oc_4u;
	logic					[5:0]						oc_6u;
	logic	signed		[5:0]						oc_6s;
	logic					[STACKS-1:0]			oc_8lu;
	logic	signed		[STACKS-1:0]			oc_8ls;
	logic	signed		[STACKS-1:0]			oc_8hs;
	//
	logic 											pop_a, pop_b;



	/*
	================
	== code start ==
	================
	*/

	// register inputs
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			clt <= '1;  // note: assert clear @ async reset!
			irq <= '0;
			oc <= '0;
		end else begin
			clt <= clt_i;
			irq <= irq_i;
			oc <= opcode_i;
		end
	end


	// split out opcode fields
	always_comb	oc_sa = oc[2:0];
	always_comb	oc_pa = oc[3];
	always_comb	oc_sb = oc[6:4];
	always_comb	oc_pb = oc[7];
	always_comb	oc_tl_ab = TST_T'( { 1'b1, oc[10:8] } );
	always_comb	oc_tl_az = TST_T'( { 2'b00, oc[9:8] } );
	always_comb	oc_th_az = TST_T'( { 2'b00, oc[13:12] } );
	always_comb	oc_4u = oc[11:8];
	always_comb	oc_6u = oc[9:4];
	always_comb	oc_6s = $signed( oc_6u );
	always_comb	oc_8lu = oc[7:0];
	always_comb	oc_8ls = $signed( oc_8lu );
	always_comb	oc_8hs = $signed( oc[11:4] );


	// register if & case: clear, interrupt, and opcode decode
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			op_er_o <= '0;
			clt_o <= '0;
			irq_o <= '0;
			irt_o <= '0;
			cnd_o <= '0;
			lit_o <= '0;
			jmp_o <= '0;
			gto_o <= '0;
			tst_o <= TST_T'( 'x );
			cls_im_o <= '0;
			pop_im_o <= '0;
			pop_a_o <= '0;
			pop_b_o <= '0;
			psh_a_o <= '0;
			sa_o <= '0;
			sb_o <= '0;
			imda_o <= '0;
			imad_o <= '0;
			stk_im_o <= '0;
			pc_im_o <= 'x;
			alu_im_o <= 'x;
			mem_im_o <= 'x;
			sgn_o <= '0;
			ext_o <= '0;
			low_o <= '0;
			lg_o <= LG_T'( 'x );
			add_o <= '0;
			sub_o <= '0;
			mul_o <= '0;
			shl_o <= '0;
			pow_o <= '0;
			pgc_o <= '0;
			mem_rd_o <= '0;
			mem_wr_o <= '0;
			reg_rd_o <= '0;
			reg_wr_o <= '0;
		end else begin
			// clocked default values
			op_er_o <= '0;  // default is no error
			clt_o <= '0;  // default is no pc clear
			irq_o <= '0;  // default is no int
			irt_o <= '0;  // default is no irq return
			cnd_o <= '0;  // default is unconditional
			lit_o <= '0;  // default is no follow
			jmp_o <= '0;  // default is no jump
			gto_o <= '0;  // default is no goto
			tst_o <= TST_T'( 'x );  // default is don't care
			cls_im_o <= '0;  // default is no im stack clear
			pop_im_o <= '0;  // default is no im pop
			pop_a_o <= '0;  // default is no pop a
			pop_b_o <= '0;  // default is no pop b
			psh_a_o <= '0;  // default is no push
			sa_o <= oc_sa;  // default is opcode directive
			sb_o <= oc_sb;  // default is opcode directive
			imda_o <= '0;  // default is not immediate data
			imad_o <= '0;  // default is not immediate address
			stk_im_o <= oc_8lu;  // default is im_8lu
			pc_im_o <= oc_8hs;  // default is im_8hs
			alu_im_o <= oc_8hs;  // default is im_8hs
			mem_im_o <= oc_4u;  // default is im_4u
			sgn_o <= '0;  // default is unsigned
			low_o <= '0;  // default is not low
			ext_o <= '0;  // default is unextended
			lg_o <= LG_T'( 'x );  // default is don't care
			add_o <= '0;  // default is thru
			sub_o <= '0;   // default is thru
			mul_o <= '0;  // default is thru
			shl_o <= '0;   // default is thru
			pow_o <= '0;   // default is thru
			pgc_o <= '0;  // default is thru
			mem_rd_o <= '0;  // default is don't read
			mem_wr_o <= '0;  // default is don't write
			reg_rd_o <= '0;  // default is don't read
			reg_wr_o <= '0;  // default is don't write
			if ( clt ) begin  // clear thread
				clt_o <= '1;  // clear pc
				cls_im_o <= '1;  // clear stacks
				stk_im_o <= '1;  // clear all stacks
			end else if ( irq ) begin  // interrupt thread
				irq_o <= '1;  // issue irq
				psh_a_o <= '1;  // push a
				sa_o <= 'b0;  // push to stack 0
				pgc_o <= '1;  // push pc
			end else begin
				// examine upper byte
				unique casex ( oc[15:8] )
					{4'h0, 4'b0xxx} : begin  // 0x0 : misc low group
						unique case ( oc[15:8] )
							`nop >> 8 : begin  // test upper byte of this 16 bit definition
								// do nothing
							end
							`pop : begin
								pop_im_o <= '1;  // pop via im
							end
							`cls : begin
								cls_im_o <= '1;  // cls via im
							end
							`jmp_8 : begin
								jmp_o <= '1;  // jump
								imad_o <= '1;  // immediate address
								pc_im_o <= oc_8ls;  // lower signed
							end
							default: begin
								op_er_o <= '1;  // illegal op!
							end
						endcase
					end
					{4'h0, 4'b1xxx} : begin  // 0x0 : misc high group
						// group defaults
						pop_a_o <= oc_pa;  // pop a
						pop_b_o <= oc_pb;  // pop b
						psh_a_o <= '1;  // push a
						//
						unique case ( oc[15:8] )
							`pgc : begin
								pgc_o <= '1;  // push pc
							end
							`lit : begin
								lit_o <= '1;  // lit
								mem_rd_o <= '1;  // read
								jmp_o <= '1;  // jump 2
								imad_o <= '1;
								pc_im_o <= 'd2;
							end
							`lit_s : begin
								lit_o <= '1;  // lit
								mem_rd_o <= '1;  // read
								low_o <= '1;  // low
								sgn_o <= '1;  // signed
								jmp_o <= '1;  // jump 1
								imad_o <= '1;
								pc_im_o <= 'd1;
							end
							`lit_u : begin
								lit_o <= '1;  // lit
								mem_rd_o <= '1;  // read
								low_o <= '1;  // low
								jmp_o <= '1;  // jump 1
								imad_o <= '1;
								pc_im_o <= 'd1;
							end
							default: begin
								op_er_o <= '1;  // illegal op!
							end
						endcase
					end
					{4'h1, 4'b0xxx} : begin  // 0x1 : skp group
						// group defaults
						pop_a_o <= oc_pa;  // pop a
						pop_b_o <= oc_pb;  // pop b
						jmp_o <= '1;  // jump
						cnd_o <= '1;  // conditional
						imad_o <= '1;  // immediate address
						tst_o <= oc_tl_ab;  // lo ab test field
						pc_im_o <= 'd1;  // 1
						//
						unique case ( oc[15:8] )
							`skp_e, `skp_ne, `skp_lu, `skp_nlu : begin
								// defaults
							end
							`skp_o, `skp_no, `skp_ls, `skp_nls : begin
								sgn_o <= '1;  // signed
							end
							default: begin
								op_er_o <= '1;  // illegal op!
							end
						endcase
					end
					{4'h1, 4'b1xxx} : begin  // 0x1 : sk2 group
						// group defaults
						pop_a_o <= oc_pa;  // pop a
						pop_b_o <= oc_pb;  // pop b
						jmp_o <= '1;  // jump
						cnd_o <= '1;  // conditional
						imad_o <= '1;  // immediate address
						tst_o <= oc_tl_ab;  // lo ab test field
						pc_im_o <= 'd2;  // 2
						//
						unique case ( oc[15:8] )
							`sk2_e, `sk2_ne, `sk2_lu, `sk2_nlu : begin
								// defaults
							end
							`sk2_o, `sk2_no, `sk2_ls, `sk2_nls : begin
								sgn_o <= '1;  // signed
							end
							default: begin
								op_er_o <= '1;  // illegal op!
							end
						endcase
					end
					{4'h2, 4'hx} : begin  // 0x2 : branch group
						// group defaults
						pop_a_o <= oc_pa;  // pop a
						pop_b_o <= oc_pb;  // pop b
						tst_o <= oc_tl_az;  // lo az test field
						//
						unique case ( oc[15:8] )
							`jmp_z, `jmp_nz, `jmp_lz, `jmp_nlz : begin
								jmp_o <= '1;  // jump
								cnd_o <= '1;  // conditional
							end
							`gto_z, `gto_nz, `gto_lz, `gto_nlz : begin
								gto_o <= '1;  // goto
								cnd_o <= '1;  // conditional
							end
							`jmp : begin
								jmp_o <= '1;  // jump
							end
							`gto : begin
								gto_o <= '1;  // goto
							end
							`irt : begin
								gto_o <= '1;  // goto
								irt_o <= '1;  // irq return
							end
							`gsb : begin
								psh_a_o <= '1;  // push a
								gto_o <= '1;  // goto
								pgc_o <= '1;  // psh pc
							end
							default: begin
								op_er_o <= '1;  // illegal op!
							end
						endcase
					end
					{4'h3, 4'hx} : begin  // 0x3 : logical group
						// group defaults
						pop_a_o <= oc_pa;  // pop a
						pop_b_o <= oc_pb;  // pop b
						psh_a_o <= '1;  // push a
						//
						unique case ( oc[15:8] )
							`cpy : begin
								lg_o <= lg_cpy;
							end
							`bnh : begin
								lg_o <= lg_bnh;
							end
							`cpy_s : begin
								lg_o <= lg_cpy;
								low_o <= 'b1;  // low
								sgn_o <= 'b1;  // signed
							end
							`cpy_u : begin
								lg_o <= lg_cpy;
								low_o <= 'b1;  // low
							end
							`not : begin
								lg_o <= lg_not;
							end
							`and : begin
								lg_o <= lg_and;
							end
							`orr : begin
								lg_o <= lg_orr;
							end
							`xor : begin
								lg_o <= lg_xor;
							end
							`bra : begin
								lg_o <= lg_bra;
							end
							`bro : begin
								lg_o <= lg_bro;
							end
							`brx : begin
								lg_o <= lg_brx;
							end
							`flp : begin
								lg_o <= lg_flp;
							end
							`lzc : begin
								lg_o <= lg_lzc;
							end
							default: begin
								op_er_o <= '1;  // illegal op!
							end
						endcase
					end
					{`mem_r, 4'hx} : begin  // 0x4 : memory read
						pop_a_o <= oc_pa;  // pop a
						pop_b_o <= oc_pb;  // pop b
						psh_a_o <= '1;  // push a
						mem_rd_o <= '1;  // read
						mem_im_o <= oc_4u << 1;  // *2
					end
					{`mem_w, 4'hx} : begin  // 0x5 : memory write
						pop_a_o <= oc_pa;  // pop a
						pop_b_o <= oc_pb;  // pop b
						mem_wr_o <= '1;  // write
						mem_im_o <= oc_4u << 1;  // *2
					end
					{`mem_rs, 4'hx} : begin  // 0x6 : memory read low signed
						pop_a_o <= oc_pa;  // pop a
						pop_b_o <= oc_pb;  // pop b
						psh_a_o <= '1;  // push a
						mem_rd_o <= '1;  // read
						low_o <= '1;  // low
						sgn_o <= '1;  // signed
					end
					{`mem_wl, 4'hx} : begin  // 0x7 : memory write low
						pop_a_o <= oc_pa;  // pop a
						pop_b_o <= oc_pb;  // pop b
						mem_wr_o <= '1;  // write
						low_o <= '1;  // low
					end
					{4'h8, 4'hx} : begin  // 0x8 : arithmetic group
						// group defaults
						pop_a_o <= oc_pa;  // pop a
						pop_b_o <= oc_pb;  // pop b
						psh_a_o <= '1;  // push a
						//
						unique case ( oc[15:8] )
							`add : begin
								add_o <= '1;  // add
							end
							`add_s : begin
								add_o <= '1;  // add
								ext_o <= '1;  // extended
								sgn_o <= '1;  // signed
							end
							`add_u : begin
								add_o <= '1;  // add
								ext_o <= '1;  // extended
							end
							`sub : begin
								sub_o <= '1;  // sub
							end
							`sub_s : begin
								sub_o <= '1;  // sub
								ext_o <= '1;  // extended
								sgn_o <= '1;  // signed
							end
							`sub_u : begin
								sub_o <= '1;  // sub
								ext_o <= '1;  // extended
							end
							`mul : begin
								mul_o <= '1;  // multiply
							end
							`mul_s : begin
								mul_o <= '1;  // multiply
								ext_o <= '1;  // extended
								sgn_o <= '1;  // signed
							end
							`mul_u : begin
								mul_o <= '1;  // multiply
								ext_o <= '1;  // extended
							end
							`shl_s : begin
								shl_o <= '1;  // shift left
								sgn_o <= '1;  // signed
							end
							`shl_u : begin
								shl_o <= '1;  // shift left
							end
							`pow : begin
								pow_o <= '1;  // power of 2
							end
							default: begin
								op_er_o <= '1;  // illegal op!
							end
						endcase
					end
					{4'h9, 4'hx} : begin  // 0x9 : IM[6] group
						// group defaults
						pop_a_o <= oc_pa;  // pop a only
						//
						case ( oc[15:10] )
							`shl_6s : begin
								psh_a_o <= '1;  // push a
								alu_im_o <= oc_6s;  // im_6s
								imda_o <= '1;  // immediate b data
								shl_o <= '1;  // shift left
								sgn_o <= '1;  // signed
							end
							`shp_6u : begin
								psh_a_o <= '1;  // push a
								alu_im_o <= oc_6s;  // im_6s
								imda_o <= '1;  // immediate b data
								shl_o <= '1;  // shift left
								pow_o <= '1;  // power of 2
							end
							`reg_r : begin
								psh_a_o <= '1;  // push a
								reg_rd_o <= '1;  // read
							end
							`reg_w : begin
								reg_wr_o <= 'b1;  // write
							end
						endcase
					end
					{`add_8, 4'hx} : begin  // 0xa : IM[8] add
						pop_a_o <= oc_pa;  // pop a only
						psh_a_o <= '1;  // push a
						imda_o <= '1;  // immediate b data
						add_o <= '1;  // add
						sgn_o <= '1;  // signed
					end
					{`byt, 4'hx} : begin  // 0xb : IM[8] data
						pop_a_o <= oc_pa;  // pop a only
						psh_a_o <= '1;  // push a
						imda_o <= '1;  // immediate b data
						lg_o <= lg_cpy;  // copy b
						sgn_o <= '1;  // signed
					end
					{4'b11xx, 4'hx} : begin  // 0xc thru 0xf : IM[8] jump
						pop_a_o <= oc_pa;  // pop a only
						jmp_o <= '1;  // jump
						cnd_o <= '1;  // conditional
						imad_o <= '1;  // immediate address
						tst_o <= oc_th_az;  // hi az test field
					end
				endcase
			end
		end
	end
	

endmodule
