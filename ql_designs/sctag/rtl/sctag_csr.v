// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_csr.v
// Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
// DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
// 
// The above named program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public
// License version 2 as published by the Free Software Foundation.
// 
// The above named program is distributed in the hope that it will be 
// useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
// 
// You should have received a copy of the GNU General Public
// License along with this work; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
// 
// ========== Copyright Header End ============================================
//  
// 	The following registers are maintained here.
//	A8 , A9, B8, B9 - L2 control register
//	AA, BA - L2 Error Enable Register
//	AB, BB - L2 Error Status register.
//	AC, BC - L2 Error Address register.
//	AD, BD - L2 Error Injection Register.
//	AE,AF, BE, BF - L2 Tag SelF time MArgin Register
// 	The L2 diagnostic addresses are as follows
//	A0-A3, B0-B3 - L2 data
//	A4,A5, B0,B5 - L2 Address
//	A6,A7,B6,B7 - L2 VUAD

`include "iop.h"
`include "sctag.h"


////////////////////////////////////////////////////////////////////////
// Local header file includes / local defines
////////////////////////////////////////////////////////////////////////

module sctag_csr( /*AUTOARG*/
   // Outputs
   so, csr_fbctl_scrub_ready, l2_bypass_mode_on, csr_fbctl_l2off, 
   csr_tagctl_l2off, csr_wbctl_l2off, csr_mbctl_l2off, 
   csr_vuad_l2off, l2_dir_map_on, l2_dbg_en, l2_steering_tid, 
   error_nceen, error_ceen, csr_wr_dirpinj_en, oneshot_dir_clear_c3, 
   csr_rd_data_c8, error_status_veu, error_status_vec, sctag_clk_tr, 
   // Inputs
   csr_inst_wr_data_c8, csr_bist_read_data, arst_l, grst_l, si, se, 
   dbginit_l, rclk, csr_erren_wr_en_c8, csr_ctl_wr_en_c8, 
   csr_errstate_wr_en_c8, csr_errinj_wr_en_c8, csr_rd_mux1_sel_c7, 
   csr_rd_mux2_sel_c7, csr_rd_mux3_sel_c7, arbdp_csr_addr_c9, 
   evict_addr, rdmard_addr_c12, dir_addr_c9, scrub_addr_way, 
   data_ecc_idx, err_state_in_rw, err_state_in_mec, err_state_in_meu, 
   err_state_in, mux1_synd_sel, mux2_synd_sel, csr_synd_wr_en, 
   vuad_syndrome_c9, lda_syndrome_c9, wr_enable_tid_c9, 
   csr_tid_wr_en, csr_async_wr_en, set_async_c9, error_rw_en, 
   diag_wr_en, mux1_addr_sel, mux2_addr_sel, csr_addr_wr_en, 
   arbctl_dir_wr_en_c4, oqdp_tid_c8
   );

output	so;

output	csr_fbctl_scrub_ready; // to fbctl.
output	l2_bypass_mode_on; // to arbctl
output	csr_fbctl_l2off;
output	csr_tagctl_l2off;
output	csr_wbctl_l2off;
output	csr_mbctl_l2off;
output	csr_vuad_l2off;
output	l2_dir_map_on; // NEW_PIN
output	l2_dbg_en;	// NEW_PIN
output	[4:0]	l2_steering_tid; // NEW_PIN
output	error_nceen, error_ceen ;
output	csr_wr_dirpinj_en;
output	oneshot_dir_clear_c3; // NEW_PIN left


// STM register.
//output  [7:0]   sctag_cam2_stm;
//output  [7:0]   sctag_dir_stm;	// REMOVED POST_4.0
//output  [3:0]   sctag_tag_stm;
//output	[3:0]	sctag_scdata_l2d_cbit;	 // REMOVED POST_4.0

output	[63:0]	csr_rd_data_c8;
output	error_status_veu, error_status_vec ;

input	[63:0]	csr_inst_wr_data_c8;	// from arbdata POST_2.0 Left Replacement for mbdata*
input	[12:0]	csr_bist_read_data; // ADDED POST_2.0 tstub input. Left
output		sctag_clk_tr; // TOP POST_2.0

input 		arst_l, grst_l, si, se;
input		dbginit_l;
input 		rclk;

// from CSR CTL.
input		csr_erren_wr_en_c8;
input		csr_ctl_wr_en_c8;
input		csr_errstate_wr_en_c8;
input		csr_errinj_wr_en_c8;
//input		csr_stm_wr_en_c8; // REMOVED POST_4.0
//input       csr_erraddr_wr_en_c8; // REMOVED POST_4.0



// read enables from csr_ctl.
input	[3:0]	csr_rd_mux1_sel_c7;
input		csr_rd_mux2_sel_c7;
input	[1:0]	csr_rd_mux3_sel_c7;


// Address inputs.
input	[39:4]	arbdp_csr_addr_c9 ; // c9 instruction addr from arbaddrdp
input	[39:6]	evict_addr ;	// from evicttag_dp.
input	[39:6]  rdmard_addr_c12; // from arbaddrdp.
input	[10:0]	dir_addr_c9 ; // from arbctl
input   [3:0]   scrub_addr_way;   // from tagctl
input	[9:0] 	data_ecc_idx; // 	from arbaddr



// Status register bits from csr_ctl
input           err_state_in_rw ;
input           err_state_in_mec ;
input           err_state_in_meu ;
input   [`ERR_LDAC:`ERR_VEU]   err_state_in ;

// Syndrome mux selects
input  [1:0]   mux1_synd_sel; // vuad and wr data
input  [1:0]   mux2_synd_sel; // ldau and default
input          csr_synd_wr_en;

// Syndrome inputs.
input   [3:0]	vuad_syndrome_c9; // from vuad dp.
input	[27:0]	lda_syndrome_c9; // from deccdp

// TID
input	wr_enable_tid_c9 ;
input	csr_tid_wr_en;

// ASYNC
input	csr_async_wr_en; 
input	set_async_c9;	// ADDED POST_4.0
//input	wr_enable_async_c9; // from csr_ctl // REMOVED POST_4.0
//input		arbdp_async_bit_c8; // from arbdec // REMOVED POST_4.0
input	error_rw_en;  // ADDED POST_4.0
input	diag_wr_en;  // ADDED POST_4.0



// Addr
input  [3:0]   mux1_addr_sel;
input  [2:0]   mux2_addr_sel;
input          csr_addr_wr_en;


input	arbctl_dir_wr_en_c4;
input   [4:0]   oqdp_tid_c8;            // From oqdp of sctag_oqdp.v

wire	[4:0]	inst_tid_c9;

wire	[21:1]	csr_l2_control_prev;
wire	[21:0]	csr_l2_control_reg;

wire	[31:0]	scrub_counter, scrub_counter_plus1;
wire	[31:0]	scrub_counter_p;

wire	[2:0]	csr_l2_erren_prev;
wire	[2:0]	csr_l2_erren_reg;

wire	unqual_scrub_ready; 
wire	sel_scrub_zero;
wire	[39:4]	csr_l2_erraddr_reg;
wire	[63:0]	csr_l2_errstate_reg;
wire	[1:0]	csr_l2_errinj_reg;
//wire	[24:0]	csr_l2_stm_prev, csr_l2_stm_reg;
wire	[63:0]	mux1_data_out_c7, mux2_data_out_c7;


wire	csr_l2_control_prev_0_l, csr_l2_control_reg_0_l ;
wire	[63:0]	csr_rd_data_c7;
wire	[31:0]	mux1_synd_c9 ;
wire	[63:0]	csr_l2_errstate_prev;
wire	[13:0]	scrub_addr;
wire	[39:4]	mux1_addr_c9;
wire	[39:4]	csr_l2_erraddr_prev;
wire	[1:0]	csr_l2_errinj_prev;

wire	[63:0]	  rd_errstate_reg;
wire            dbb_rst_l;
wire	dbg_trigger;
wire	error_in;
wire	sctag_clk_tr_prev;
///////////////////////////////////////////////////////////////////
 // Reset flop
 ///////////////////////////////////////////////////////////////////

 dffrl_async    #(1)    reset_flop      (.q(dbb_rst_l),
                                        .clk(rclk),
                                        .rst_l(arst_l),
                                        .din(grst_l),
                                        .se(se), .si(), .so());



///////////////////////////////////////////////////////////////////////////////////
// L2 BIST CONTROL REGISTER Address<39:32>= 0xa8
//
//______________________________________________________________________________
//
//	BIST_ReadOnly<12:9> BIST_WR fields<8:0>
//______________________________________________________________________________
// This register is physically located in the test stub. 
// a 13 bit bus from the tstub is used for read.
///////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////
// L2 BANK CONTROL REgister Address<39:32> 0xa9 ;
//______________________________________________________________________________
// 
//	DIR_CLEAR DBG_EN	Steering <19:15> SCB INERVal<14:3> SCB_EN  direct_mapped_on L2_OFF
//_____________________________________________________________________________
// dir clr: This bit is used to perform a one shot clear of the 
// dbg en: mux select for the dbgbus that goes to the IOB
// Steering id = {cpuid, tid }
// scrub_interval: SCB interval  12 bits 
// scrub_enable:	scb_en
// direct_mapped_on : direct mapped mode.
// l2_off: l2 off mode.
///////////////////////////////////////////////////////////////////////////////////

assign	csr_l2_control_prev[21:1] =   csr_inst_wr_data_c8[21:1]  ; 

//////////////
// L2 off bit
// This bit is set to 
// 1 at POR.
//////////////


assign	csr_l2_control_prev_0_l  =  ~csr_inst_wr_data_c8[0] ;

dffre_s     #(1)    ff_csr_l2_control_reg_0   (.din(csr_l2_control_prev_0_l), 
			.en(csr_ctl_wr_en_c8), .rst(~dbb_rst_l) ,
			.clk(rclk), .q(csr_l2_control_reg_0_l), .se(se), .si(), .so());

assign	csr_l2_control_reg[0] = ~csr_l2_control_reg_0_l ;

assign	l2_bypass_mode_on = csr_l2_control_reg[0] ;
assign	csr_fbctl_l2off = csr_l2_control_reg[0] ;
assign	csr_tagctl_l2off = csr_l2_control_reg[0] ;
assign	csr_wbctl_l2off = csr_l2_control_reg[0] ;
assign	csr_mbctl_l2off = csr_l2_control_reg[0] ;
assign	csr_vuad_l2off = csr_l2_control_reg[0] ;

assign	l2_dir_map_on = csr_l2_control_reg[1]  & ~csr_l2_control_reg[0]; // when both L2_OFF and L2_DIR_MAP
									 // are 1, L2_DIR_MAP is ignored.
assign	l2_steering_tid = csr_l2_control_reg[19:15] ;


//////////////
// other mode bits
//////////////
dffre_s     #(2)    ff_csr_l2_control_reg_2to1   (.din(csr_l2_control_prev[2:1]), 
		.en(csr_ctl_wr_en_c8), .rst(~dbb_rst_l) ,
		.clk(rclk), .q(csr_l2_control_reg[2:1]), .se(se), .si(), .so());

//////////////
// scrub interval.
//////////////
dffre_s      #(12)    ff_csr_l2_control_reg_scb_int   (.din(csr_l2_control_prev[14:3]), 
		.en(csr_ctl_wr_en_c8), .rst(~dbb_rst_l) ,
		.clk(rclk), .q(csr_l2_control_reg[14:3]), .se(se), .si(), .so());

//////////////
// steering bits + dbgen
//////////////
dffre_s     #(5)    ff_csr_l2_control_reg_steering   (.din(csr_l2_control_prev[19:15]), 
		.en(csr_ctl_wr_en_c8), .rst(~dbb_rst_l) ,
		.clk(rclk), .q(csr_l2_control_reg[19:15]), .se(se), .si(), .so());

//////////////
// dbgen needs to be preserved across 
// a reset
//////////////

dffe_s     #(1)    ff_csr_l2_control_reg_dbg   (.din(csr_l2_control_prev[20]), 
		.en(csr_ctl_wr_en_c8), 
		.clk(rclk), .q(csr_l2_control_reg[20]), 
		.se(se), .si(), .so());

assign	l2_dbg_en = csr_l2_control_reg[20] ;

//////////////
// Directory clear bit.
//////////////
dffre_s     #(1)    ff_csr_l2_control_reg_dir_clr   (.din(csr_l2_control_prev[21]), 
		.en(csr_ctl_wr_en_c8), .rst(~dbb_rst_l) ,
		.clk(rclk), .q(csr_l2_control_reg[21]), .se(se), .si(), .so());

/////////////////////////
// Directory clear logic
// The dir clr bit is followed by
// two shadow flops.
// If the pattern on the two following flops is
// 2'b10, the directory is cleared. Else it is not.
// This ensures that one diagnostic write will perform
// only one clear without destroying the contents of the
// L2.ESR dir_Ctl bit.
/////////////////////////

dff_s     #(1)    ff_dir_clr_d1   (.din(csr_l2_control_reg[21]), .clk(rclk),
		.q(dir_clr_d1), .se(se), .si(), .so());

dff_s     #(1)    ff_dir_clr_d2   (.din(dir_clr_d1), .clk(rclk),
		.q(dir_clr_d2), .se(se), .si(), .so());

assign	 oneshot_dir_clear_c3 = dir_clr_d1 & ~dir_clr_d2 ;



/////////////////////////////////////////////////////////
// Scrub counter.
// The scrub interval is programmable and has a range of
// 1M - 4B cycles.
// After a scrub interval, one set of the cache is
// scrubbed. The scrub operation is synchronized with the
// occurrence of the next fill after the scrub counter
// expires.
/////////////////////////////////////////////////////////


	assign	sel_scrub_zero = ~dbginit_l | 
					~dbb_rst_l |
					unqual_scrub_ready ;

	assign	scrub_counter_plus1 = scrub_counter + 32'b1; 

	mux2ds  #(32) mux_scrub_count      (.dout(scrub_counter_p[31:0]),
			 .in0(32'b0), .in1(scrub_counter_plus1[31:0]),
			 .sel0(sel_scrub_zero), .sel1(~sel_scrub_zero));

	dff_s     #(32)    ff_scrub_count   (.din(scrub_counter_p[31:0]), .clk(rclk),
			.q(scrub_counter[31:0]), .se(se), .si(), .so());

	assign	unqual_scrub_ready = ( scrub_counter[31:0] == 
			{ csr_l2_control_reg[14:3], 20'b0} ) ;

	assign	csr_fbctl_scrub_ready = unqual_scrub_ready & 
				csr_l2_control_reg[2] ;

/////////////////////////////////////////////////////////
// L2 error enable register. 
// --------------------------
//DBG_TRIG_EN	NCEEN	CEEN
//---------------------------
/////////////////////////////////////////////////////////


	assign	csr_l2_erren_prev[0]  = csr_inst_wr_data_c8[0] ;
	assign	csr_l2_erren_prev[1]  = csr_inst_wr_data_c8[1] ;
	assign	csr_l2_erren_prev[2]  = csr_inst_wr_data_c8[2] ;

	dffre_s     #(3)    ff_csr_l2_erren_d1   (.din(csr_l2_erren_prev[2:0]), 
		.en(csr_erren_wr_en_c8), .clk(rclk), .rst(~dbb_rst_l),
		.q(csr_l2_erren_reg[2:0]), .se(se), .si(), .so());

	assign	dbg_trigger  = 	csr_l2_erren_reg[2] ;
	assign	error_nceen  = 	csr_l2_erren_reg[1] ;
	assign	error_ceen  = 	csr_l2_erren_reg[0] ;


//////////////////////////////////////////////////////////////////////////////////
// L2 error status register. ( addr = ab )
// ------------------------------------------------------------------------------
// MEU MEC RW ASYN TID LDAC LDAU LDWC LDWULDRC LDRU LDSC LDSU LTC LRU LVU DAC DAU
//-------------------------------------------------------------------------------
// DRC	DRU	DSC	DSU	VEC 	VEU RSVD<34:32>	SYND<31:0>
//-------------------------------------------------------------------------------
// Keep the old value unless the new value being written is a 1.
//////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////
// SYNDROME	(NON_STICKY)
// * vuad errors
// * ldac/ldau
// * ldrc/ldru for rdma writes only.
//////////////////////////////////////


mux2ds  #(32) synd_c9_mux1      (.dout(mux1_synd_c9[31:0]),
                                .in0({28'b0,vuad_syndrome_c9[3:0]}),
                                .in1(csr_inst_wr_data_c8[31:0]),
                                .sel0(mux1_synd_sel[0]),
                                .sel1(mux1_synd_sel[1]));

mux2ds  #(32) synd_c9_mux2      (.dout(csr_l2_errstate_prev[31:0]),
                                .in0(mux1_synd_c9[31:0]),
                                .in1({4'b0,lda_syndrome_c9[27:0]}),
                                .sel0(mux2_synd_sel[1]),
                                .sel1(mux2_synd_sel[0]));

dffe_s     #(32)    ff_csr_l2_errsynd_d1   
			(.din(csr_l2_errstate_prev[31:0]),
                         .en(csr_synd_wr_en), .clk(rclk),
                         .q(csr_l2_errstate_reg[31:0]),
                         .se(se), .si(), .so());


//////////////////////////////////////
// TID BITS
//////////////////////////////////////


dff_s     #(5)    ff_inst_tid_c9   (.q(inst_tid_c9[4:0]), .clk(rclk),
                               .din(oqdp_tid_c8[4:0]),
                               .se(se), .si(), .so());

mux2ds  #(5)    mux_tid_c9      
			(.dout(csr_l2_errstate_prev[`ERR_TID_HI:`ERR_TID_LO]),
                         .in0(inst_tid_c9[4:0]),
                         .in1(csr_inst_wr_data_c8[`ERR_TID_HI:`ERR_TID_LO]),
                         .sel0(wr_enable_tid_c9),
                         .sel1(~wr_enable_tid_c9));

dffe_s     #(5)    ff_csr_l2_erritid_d1 
		(.din(csr_l2_errstate_prev[`ERR_TID_HI:`ERR_TID_LO]),
                 .en(csr_tid_wr_en), .clk(rclk),
                 .q(csr_l2_errstate_reg[`ERR_TID_HI:`ERR_TID_LO]),
                 .se(se), .si(), .so());


//////////////////////////////////////
// ASYNC BIT	(NON_STICKY)
//////////////////////////////////////


assign          csr_l2_errstate_prev[`ERR_ASYNC] =
                     ( diag_wr_en & csr_inst_wr_data_c8[`ERR_ASYNC]) | // diag write
                     ( set_async_c9) ; // async ld hit

dffe_s    #(1)    ff_async_bit (.din(csr_l2_errstate_prev[`ERR_ASYNC]), .clk(rclk),
                    	.q(csr_l2_errstate_reg[`ERR_ASYNC]),
			.en(csr_async_wr_en),
                   	.se(se), .si(), .so());



//////////////////////////////////////
// RW BITS	(NON_STICKY)
//////////////////////////////////////

assign  csr_l2_errstate_prev[`ERR_RW] =
                        ( diag_wr_en & csr_inst_wr_data_c8[`ERR_RW] ) |
                           err_state_in_rw ;


dffe_s     #(1)    ff_csr_l2_errrw_d1 (.din(csr_l2_errstate_prev[`ERR_RW]), .clk(rclk),
                 .q(csr_l2_errstate_reg[`ERR_RW]),
		 .en(error_rw_en),
                 .se(se), .si(), .so());


//////////////////////////////////////
// Error bits	(STICKY)
//////////////////////////////////////

assign	csr_l2_errstate_prev[60] = csr_inst_wr_data_c8[60];

assign  csr_l2_errstate_prev[`ERR_MEU]  =
                       ( ~( csr_errstate_wr_en_c8 &
                       csr_inst_wr_data_c8[`ERR_MEU] )  &
                       csr_l2_errstate_reg[`ERR_MEU]
                       ) | err_state_in_meu ;


assign  csr_l2_errstate_prev[`ERR_MEC]  =
                       ( ~( csr_errstate_wr_en_c8 &
                       csr_inst_wr_data_c8[`ERR_MEC] )  &
                       csr_l2_errstate_reg[`ERR_MEC]
                       ) | err_state_in_mec ;

assign  csr_l2_errstate_prev[`ERR_LDAC:`ERR_VEU] =
                       ( ~({19{csr_errstate_wr_en_c8}} &
                        csr_inst_wr_data_c8[`ERR_LDAC:`ERR_VEU])  &
                        csr_l2_errstate_reg[`ERR_LDAC:`ERR_VEU]
                        ) | err_state_in[`ERR_LDAC:`ERR_VEU]  ;


dff_s     #(1)    ff_csr_l2_errmeu_d1 (.din(csr_l2_errstate_prev[`ERR_MEU]), 
			.clk(rclk),
                 	.q(csr_l2_errstate_reg[`ERR_MEU]),
                 	.se(se), .si(), .so());

dff_s     #(1)    ff_csr_l2_errmec_d1 (.din(csr_l2_errstate_prev[`ERR_MEC]), 
			.clk(rclk),
                 	.q(csr_l2_errstate_reg[`ERR_MEC]),
                 	.se(se), .si(), .so());

dff_s    #(19)    ff_csr_l2_errstate_d1
                (.din(csr_l2_errstate_prev[`ERR_LDAC:`ERR_VEU]), 
		 .clk(rclk),
                 .q(csr_l2_errstate_reg[`ERR_LDAC:`ERR_VEU]),
                 .se(se), .si(), .so());

assign  error_status_veu = csr_l2_errstate_reg[`ERR_VEU] ;
assign  error_status_vec = csr_l2_errstate_reg[`ERR_VEC] ;

// The following signal implies that an error was detected.
assign	error_in = err_state_in[`ERR_VEU] | err_state_in[`ERR_VEC] ;

assign sctag_clk_tr_prev = error_in & dbg_trigger ;

dff_s     #(1)    ff_sctag_clk_tr (.din(sctag_clk_tr_prev),
			.clk(rclk),
                 	.q(sctag_clk_tr),
                 	.se(se), .si(), .so());


//////////////////////////////////////////////////////////////////////////////////
// L2 Error Address Register	( addr = ac )
// -------------------------------------------
//			Addr<39:4>,4'b0 
// -------------------------------------------
//     dir_addr<10:6> = panel #
//     dir_addr<5:1> = entry #
//     dir_addr<0> = I$ , 0= d$
//////////////////////////////////////////////////////////////////////////////////



assign  scrub_addr = { scrub_addr_way, data_ecc_idx } ;

mux4ds  #(36) addr_c9_mux1      (.dout(mux1_addr_c9[39:4]),
                                .in0({23'b0,dir_addr_c9[10:0],2'b0}), 
                                .in1({20'b0,scrub_addr[13:0],2'b0}), 
                                .in2({evict_addr[39:6],2'b0}),
                                .in3({rdmard_addr_c12[39:6],2'b0}),
                                .sel0(mux1_addr_sel[0]),
                                .sel1(mux1_addr_sel[1]),
                                .sel2(mux1_addr_sel[2]),
                                .sel3(mux1_addr_sel[3]));

mux3ds  #(36) addr_c9_mux2      (.dout(csr_l2_erraddr_prev[39:4]),
                                .in0(mux1_addr_c9[39:4]),
                                .in1(arbdp_csr_addr_c9[39:4]),
                                .in2(csr_inst_wr_data_c8[39:4]),
                                .sel0(mux2_addr_sel[0]),
                                .sel1(mux2_addr_sel[1]),
                                .sel2(mux2_addr_sel[2]));

dffe_s     #(36)    ff_csr_l2_erraddr_d1   (.din(csr_l2_erraddr_prev[39:4]),
                              .en(csr_addr_wr_en), .clk(rclk),
                              .q(csr_l2_erraddr_reg[39:4]),
                              .se(se), .si(), .so());

//////////////////////////////////////////////////////////////////////////////////
// L2 Error INJ Register    ( addr = ad )
// -------------------------------------------
//                      SSHOT,ENB
// -------------------------------------------
//////////////////////////////////////////////////////////////////////////////////


// ENB bit.
// Set on write.
// Reset on write OR if ONESHOT bit is set.

assign  csr_l2_errinj_prev[0] = ( csr_l2_errinj_reg[0] |
                                csr_errinj_wr_en_c8 & csr_inst_wr_data_c8[0] )
                                & ~((arbctl_dir_wr_en_c4  & csr_l2_errinj_reg[1] ) |
                                (csr_errinj_wr_en_c8 & ~csr_inst_wr_data_c8[0] )) ;

// SSHOT bit can only be set or reset using a CSR Write
assign  csr_l2_errinj_prev[1] = ( csr_l2_errinj_reg[1] |
                                csr_errinj_wr_en_c8 & csr_inst_wr_data_c8[1] )
                                & ~( csr_errinj_wr_en_c8 & ~csr_inst_wr_data_c8[1] ) ;



dffrl_s     #(2)    ff_csr_l2_errinj_d1   
			(.din(csr_l2_errinj_prev[1:0]), .clk(rclk),
                         .q(csr_l2_errinj_reg[1:0]), .rst_l(dbb_rst_l),
                         .se(se), .si(), .so());

assign  csr_wr_dirpinj_en = csr_l2_errinj_reg[0] ;


//////////////////////////////////////////////////////////////////////////////////
// THIS REGISTER DOES NOT EXIST ANYMORE.
// L2 SELF TIME MARGIN REGISTER ( ae or af)
// ------------------------------------------------
//        CAM2<7:0> DIR<7:0> DATA<3:0> TAG<3:0>
// ------------------------------------------------
//////////////////////////////////////////////////////////////////////////////////


	//assign  csr_l2_stm_prev[23:0] = csr_inst_wr_data_c8[23:0] ;

	//dffre     #(24)    ff_csr_l2_stm_reg   (.din(csr_l2_stm_prev[23:0]),
                 //.en(csr_stm_wr_en_c8), .clk(rclk), .rst(~dbb_rst_l),
		//.q(csr_l2_stm_reg[23:0]), .se(se), .si(), .so());

	//assign  sctag_scdata_l2d_cbit = csr_l2_stm_reg[3:0] ;
 	//assign  sctag_cam2_stm = csr_l2_stm_reg[23:16] ;
	//assign  sctag_dir_stm = csr_l2_stm_reg[15:8] ;
	//assign  sctag_tag_stm = csr_l2_stm_reg[7:4] ;




//////////////////////////////////////////////////////////////////////////////////
// READ OPERATION
//////////////////////////////////////////////////////////////////////////////////

assign  rd_errstate_reg = { csr_l2_errstate_reg[63:61],1'b0,
                            csr_l2_errstate_reg[59:35],3'b0,
                            csr_l2_errstate_reg[31:0] } ;


mux4ds  #(64) mux_mux1_data_out_c7      (.dout ( mux1_data_out_c7[63:0] ) ,
                                .in0({51'b0,csr_bist_read_data[12:0]}),	// A8
                                .in1({42'b0,csr_l2_control_reg[21:0]}), // A9
                                .in2({61'b0,csr_l2_erren_reg[2:0]}),	// AA
                                .in3(rd_errstate_reg[63:0]),	// AB
                                .sel0(csr_rd_mux1_sel_c7[0]),
                                .sel1(csr_rd_mux1_sel_c7[1]),
                                .sel2(csr_rd_mux1_sel_c7[2]),
                                .sel3(csr_rd_mux1_sel_c7[3]));

mux3ds  #(64) mux_mux2_data_out_c7      (.dout (mux2_data_out_c7[63:0] ) ,
                                .in0({24'b0,csr_l2_erraddr_reg[39:4],4'b0}),	// AC
                                .in1({62'b0,csr_l2_errinj_reg[1:0]}),		// AD
                                .in2(64'b0),	// AE or AF
                                .sel0(csr_rd_mux1_sel_c7[0]),
                                .sel1(csr_rd_mux1_sel_c7[1]),
                                .sel2(csr_rd_mux2_sel_c7));

mux2ds  #(64) mux3_data_out_c8      (.dout ( csr_rd_data_c7[63:0] ) ,
                                .in0({mux1_data_out_c7[63:0]}),
                                .in1({mux2_data_out_c7[63:0]}),
                                .sel0(csr_rd_mux3_sel_c7[0]),
                                .sel1(csr_rd_mux3_sel_c7[1]));

dff_s     #(64) ff_csr_rd_data_c8   (.din(csr_rd_data_c7[63:0]),
        		.clk(rclk), 
			.q(csr_rd_data_c8[63:0]), 
			.se(se), .si(), .so());

endmodule

