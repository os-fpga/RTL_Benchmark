// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_csr_ctl.v
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
//      The following registers are maintained here.
//      A8, B8 - L2 BIST control register.
//      A9, B9 - L2 control register
//      AA, BA - L2 Error Enable Register
//      AB, BB - L2 Error Status register.
//      AC, BC - L2 Error Address register.
//      AD, BD - L2 Error Injection Register.
//      AE,AF, BE, BF - L2 Tag SelF time MArgin Register
//      The L2 diagnostic addresses are as follows
//      A0-A3, B0-B3 - L2 data
//      A4,A5, B0,B5 - L2 Address
//      A6,A7,B6,B7 - L2 VUAD


`include "iop.h"
`include "sctag.h"


////////////////////////////////////////////////////////////////////////
// Local header file includes / local defines
////////////////////////////////////////////////////////////////////////

module sctag_csr_ctl( /*AUTOARG*/
   // Outputs
   fbctl_decc_scrd_corr_err_c8, fbctl_decc_scrd_uncorr_err_c8, 
   mbctl_decc_spcfb_corr_err_c8, mbctl_decc_spcd_corr_err_c8, 
   fbctl_decc_bscd_corr_err_c8, fbctl_decc_bscd_uncorr_err_c8, 
   arbctl_data_ecc_active_c3, decc_data_ecc_active_c3, 
   tagdp_l2_dir_map_on, mbctl_l2_dir_map_on, fbctl_l2_dir_map_on, 
   arbctl_dbginit_l, mbctl_dbginit_l, fbctl_dbginit_l, 
   tagctl_dbginit_l, tagdp_ctl_dbginit_l, csr_dbginit_l, 
   wbctl_dbginit_l, so, csr_ctl_wr_en_c8, csr_erren_wr_en_c8, 
   csr_errstate_wr_en_c8, csr_errinj_wr_en_c8, err_state_in_rw, 
   err_state_in_mec, err_state_in_meu, err_state_in, csr_synd_wr_en, 
   mux1_synd_sel, mux2_synd_sel, wr_enable_tid_c9, csr_tid_wr_en, 
   csr_async_wr_en, set_async_c9, error_rw_en, diag_wr_en, 
   mux1_addr_sel, mux2_addr_sel, csr_addr_wr_en, csr_rd_mux1_sel_c7, 
   csr_rd_mux2_sel_c7, csr_rd_mux3_sel_c7, sctag_por_req, 
   csr_bist_wr_en_c8, 
   // Inputs
   arbctl_csr_wr_en_c7, arbdp_word_addr_c6, rclk, si, se, rst_tri_en, 
   vuad_error_c8, dir_error_c8, decc_spcd_corr_err_c8, 
   decc_spcd_uncorr_err_c8, decc_scrd_corr_err_c8, 
   decc_scrd_uncorr_err_c8, decc_spcfb_corr_err_c8, 
   decc_spcfb_uncorr_err_c8, decc_bscd_corr_err_c8, 
   decc_bscd_uncorr_err_c8, tag_error_c8, data_ecc_active_c3, 
   l2_dir_map_on, dbginit_l, dram_scb_secc_err_d1, 
   dram_scb_mecc_err_d1, fbctl_uncorr_err_c8, fbctl_corr_err_c8, 
   fbctl_bsc_corr_err_c12, fbctl_ld64_fb_hit_c12, ev_uerr_r6, 
   ev_cerr_r6, rdmard_uerr_c12, rdmard_cerr_c12, error_status_vec, 
   error_status_veu, store_err_c8, arbdp_async_bit_c8, str_ld_hit_c7
   );

input		arbctl_csr_wr_en_c7;
input	[2:0]	arbdp_word_addr_c6;	

input		rclk;
input		si, se;
input		rst_tri_en;


// from vuaddp
input		vuad_error_c8; // from vuad dp.
// from arbctl.
input		dir_error_c8 ; // from the directory


// from decc_ctl.v
input   	decc_spcd_corr_err_c8 ;	// error in 156 bit data 
input   	decc_spcd_uncorr_err_c8 ; // error in 156 bit data 
input   	decc_scrd_corr_err_c8 ;// error in 156 bit data 
input  		decc_scrd_uncorr_err_c8 ;// error in 156 bit data 
input   	decc_spcfb_corr_err_c8 ; // error in 156 bit data or error 
input   	decc_spcfb_uncorr_err_c8 ; // error in 156 bit data or error 
input		decc_bscd_corr_err_c8; // error in 156 bit data ( for WR8s)
input		decc_bscd_uncorr_err_c8; // error in 156 bit data ( for WR8s)



// from tagdp.v
input		tag_error_c8;

input	data_ecc_active_c3 ; // POST_4.2 ( Right)
output	fbctl_decc_scrd_corr_err_c8; // POST_4.2 ( Top)
output	fbctl_decc_scrd_uncorr_err_c8; // POST_4.2 ( Top)
output	mbctl_decc_spcfb_corr_err_c8; // POST_4.2 (Top)
output	mbctl_decc_spcd_corr_err_c8 ; // POST_4.2 (Top)
output	fbctl_decc_bscd_corr_err_c8; // POST_4.2 ( Top)
output	fbctl_decc_bscd_uncorr_err_c8; // POST_4.2 ( Top)
output	arbctl_data_ecc_active_c3; // POST_4.2 ( Top)
output	decc_data_ecc_active_c3; // POST_4.2 ( Top)

input		l2_dir_map_on; // POST_4.2 ( Left)

output		tagdp_l2_dir_map_on; // POST_4.2 ( Left/Bottom)
output		mbctl_l2_dir_map_on; // POST_4.2 ( Top) 
output		fbctl_l2_dir_map_on; // POST_4.2 ( Top) 



input		dbginit_l ;	// POST_4.2	Bottom
output		arbctl_dbginit_l ;	// POST_4.2 TOp
output		mbctl_dbginit_l ;	// POST_4.2		Top
output		fbctl_dbginit_l ;	// POST_4.2	Top
output		tagctl_dbginit_l ;	// POST_4.2	Top
output		tagdp_ctl_dbginit_l ;	// POST_4.2 Left
output		csr_dbginit_l ;	// POST_4.2 Left
output		wbctl_dbginit_l ;	// POST_4.2 Top

// from fbctl.v
input		dram_scb_secc_err_d1; // scrub error from DRAM
input		dram_scb_mecc_err_d1; // scrub error from DRAM
input   	fbctl_uncorr_err_c8 ; // Errors from DRAM in response to a read
input   	fbctl_corr_err_c8 ; //  Errors from DRAM in response to a read
input		fbctl_bsc_corr_err_c12;  // Errors from DRAM in response to a rd64 miss.
input		fbctl_ld64_fb_hit_c12;	 // qualification for errors found in 	
					// rdma rd stream out data path. 

// from rdmatctl.v
input		ev_uerr_r6;// wb errors from the evict dp.
input		ev_cerr_r6;// wb errors from the evict dp.
input		rdmard_uerr_c12;
input		rdmard_cerr_c12;

// from csr
input		error_status_vec;
input		error_status_veu;
 
// from arbdec
input		store_err_c8;
input		arbdp_async_bit_c8; // ADDED POST_4.0

input	str_ld_hit_c7; // from oqctl.
// csr_ctl
output	so;
output		csr_ctl_wr_en_c8 ;
output		csr_erren_wr_en_c8;
output		csr_errstate_wr_en_c8;
output		csr_errinj_wr_en_c8;
//output		csr_stm_wr_en_c8; // REMOVED POST_4.0


 
// 21 control bits in Status register.
output          err_state_in_rw ;
output          err_state_in_mec ;
output          err_state_in_meu ;

output  [`ERR_LDAC:`ERR_VEU]   err_state_in ;

output		csr_synd_wr_en;
output	[1:0]	mux1_synd_sel;
output	[1:0]	mux2_synd_sel;

output	wr_enable_tid_c9;
output	csr_tid_wr_en;
output	csr_async_wr_en;
// output	wr_enable_async_c9; REMOVED POST_4.0
output		set_async_c9 ; // ADDED POST_4.0
output		error_rw_en ; // ADDED POST_4.0
output		diag_wr_en; // ADDED POST_4.0


output	[3:0]	mux1_addr_sel;
output  [2:0]	mux2_addr_sel;
output		csr_addr_wr_en;
// output	csr_erraddr_wr_en_c8; // REMOVED POST_4.0

// read enables.
output	[3:0]	csr_rd_mux1_sel_c7;
output		csr_rd_mux2_sel_c7;
output	[1:0]	csr_rd_mux3_sel_c7;

// these outputs need to be removed.
output		sctag_por_req; // POST_4.2
output	csr_bist_wr_en_c8; // POST_2.0


wire	control_reg_write_en, control_reg_write_en_d1;
wire	erren_reg_write_en, erren_reg_write_en_d1;
wire	errst_reg_write_en, errst_reg_write_en_d1;
wire	erraddr_reg_write_en, erraddr_reg_write_en_d1;
wire	errinj_reg_write_en, errinj_reg_write_en_d1;
//wire	stm_reg_write_en, stm_reg_write_en_d1;

wire	[2:0]	word_addr_c7;
wire	[2:0]	mux1_sel_c6, mux1_sel_c7;

wire    [63:0]  err_status_in;
wire    [63:0]  err_state_new_c9;
wire    [63:0]  err_state_new_c8;
wire    [7:0]   new_uerr_vec_c9 ;
wire    [7:0]   wr_uerr_vec_c9 ;
wire    [6:0]   new_cerr_vec_c9 ;
wire    [6:0]   wr_cerr_vec_c9 ;

wire	rdma_pst_err_c9;
wire	store_error_c9 ;
wire	rdmard_uerr_c13, rdmard_cerr_c13 ;

wire	str_ld_hit_c8, str_ld_hit_c9 ;
wire	err_sel, new_err_sel;
wire	rdmard_addr_sel_c13;
wire	bsc_corr_err_c13;

wire	en_por_c7, en_por_c7_d1; 
wire	bist_reg_write_en, bist_reg_write_en_d1;
wire	[3:0]	mux1_addr_sel_tmp;
wire	[2:0]	mux2_addr_sel_tmp ;
wire	pipe_addr_sel;
wire	bscd_uncorr_err_c9, bscd_corr_err_c9 ;
wire		csr_erraddr_wr_en_c8;
wire	async_bit_c9, wr_enable_async_c9;
wire	error_spc, error_bsc ;



// --------------\/------- Added repeaters post_4.2 ---\/ --------

	assign	arbctl_dbginit_l = dbginit_l ;
	assign	mbctl_dbginit_l = dbginit_l ;
	assign	fbctl_dbginit_l = dbginit_l ;
	assign	wbctl_dbginit_l = dbginit_l ;
	assign	csr_dbginit_l = dbginit_l ;
	assign	tagctl_dbginit_l = dbginit_l ;
	assign	tagdp_ctl_dbginit_l = dbginit_l ;

	//decc_spcd_uncorr_err_c8 repeater not needed.
	//decc_spcfb_corr_err_c8 repeater not needed.

	assign	fbctl_decc_scrd_corr_err_c8 = decc_scrd_corr_err_c8;
	assign	fbctl_decc_scrd_uncorr_err_c8 = decc_scrd_uncorr_err_c8 ;
	assign  fbctl_decc_bscd_corr_err_c8 = decc_bscd_corr_err_c8 ;
	assign	fbctl_decc_bscd_uncorr_err_c8 = decc_bscd_uncorr_err_c8 ; 
	assign	mbctl_decc_spcd_corr_err_c8 = decc_spcd_corr_err_c8 ;
	assign	mbctl_decc_spcfb_corr_err_c8 = decc_spcfb_corr_err_c8 ;
	assign	arbctl_data_ecc_active_c3 = data_ecc_active_c3 ;
	assign	decc_data_ecc_active_c3 = data_ecc_active_c3 ;
	assign	tagdp_l2_dir_map_on = l2_dir_map_on ;
	assign	mbctl_l2_dir_map_on = l2_dir_map_on ;
	assign	fbctl_l2_dir_map_on = l2_dir_map_on ;

// --------------\/------- Added repeaters post_4.2 ---\/ --------
/////////////////////////////////////////////////////
// Exception cases:
//
// - Wr8s will cause  DAU to be set in OFF mode. ( if an uncorr err 
//   is signalled by DRAM).
// - Wr8 will cause  DAC to be set. in OFF/ON mode.
/////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// CSR pipeline.
//
//============================================================
// 	C7		C8		C9		
//============================================================
//	generate	mux out		xmit
//	mux selects	rd data		to 
//					ccx
//						
//			enable
//			a write
//					
//============================================================
//
// Eventhough the Write and Read operations do not happen in the
// same cycle, no data forwarding is required because the write
// is followed by ATLEAST one bubble
//
// Errors update the ESR and EAR in the C10 cycle. 
// Hence a CSR load may actually miss the error that occurred
// just before it.
////////////////////////////////////////////////////////////////////////////////

//////////////////////////
// I) WR ENABLE GENERATION
//
// Write pipeline.
// A CSR store is performed 
// in the C8 cycle.
//////////////////////////

dff_s     #(3)    ff_word_addr_c7   (.din(arbdp_word_addr_c6[2:0]), 
				.clk(rclk),
                               .q(word_addr_c7[2:0]),
                               .se(se), .si(), .so());

//////////////////////////
// BIST REG	 A8
// This register can be written by software or
// by JTAG via the CTU
//////////////////////////



assign  bist_reg_write_en =  arbctl_csr_wr_en_c7 & 
			 (word_addr_c7==3'h0 ) ; // A8

dff_s     #(1)    ff_bist_reg_write_en_d1   (.din(bist_reg_write_en), 
				.clk(rclk),
                               .q(bist_reg_write_en_d1),
                               .se(se), .si(), .so());

assign	csr_bist_wr_en_c8 = bist_reg_write_en_d1  ;

//////////////////////////
// CONTROL REG	 A9
//////////////////////////
assign  control_reg_write_en =  arbctl_csr_wr_en_c7 & 
			 (word_addr_c7==3'h1 ) ; // A9

dff_s     #(1)    ff_control_reg_write_en_d1   (.din(control_reg_write_en), 
				.clk(rclk),
                               .q(control_reg_write_en_d1),
                               .se(se), .si(), .so());

assign	csr_ctl_wr_en_c8 = control_reg_write_en_d1  ;

//////////////////////////
// ERR ENABLE REG	AA
//////////////////////////
assign	erren_reg_write_en = arbctl_csr_wr_en_c7 & 
				 (word_addr_c7==3'h2) ; // AA

dff_s     #(1)    ff_erren_reg_write_en_d1   (.din(erren_reg_write_en), 
				.clk(rclk),
                               .q(erren_reg_write_en_d1),
                               .se(se), .si(), .so());

assign  csr_erren_wr_en_c8 = erren_reg_write_en_d1  ;

//////////////////////////
// ERR STATE REG	AB
//////////////////////////
assign  errst_reg_write_en = arbctl_csr_wr_en_c7 & 
                                 (word_addr_c7==3'h3) ; // AB

dff_s     #(1)    ff_errst_reg_write_en_d1   (.din(errst_reg_write_en), .clk(rclk),
                               .q(errst_reg_write_en_d1),
                               .se(se), .si(), .so());

assign  csr_errstate_wr_en_c8 = errst_reg_write_en_d1 ;

//////////////////////////
// ERR ADDR REG	AC
//////////////////////////
assign  erraddr_reg_write_en = arbctl_csr_wr_en_c7 &
                                 (word_addr_c7==3'h4) ; // AC

dff_s     #(1)    ff_erraddr_reg_write_en_d1   (.din(erraddr_reg_write_en), .clk(rclk),
                               .q(erraddr_reg_write_en_d1),
                               .se(se), .si(), .so());


assign  csr_erraddr_wr_en_c8 = erraddr_reg_write_en_d1 ;

//////////////////////////
// ERR INJ  REG AD
//////////////////////////
assign  errinj_reg_write_en = arbctl_csr_wr_en_c7 &
                                 (word_addr_c7==3'h5) ;	// AD


dff_s     #(1)    ff_errinj_reg_write_en_d1   (.din(errinj_reg_write_en), .clk(rclk),
                               .q(errinj_reg_write_en_d1),
                               .se(se), .si(), .so());

assign  csr_errinj_wr_en_c8 = errinj_reg_write_en_d1   ;

//////////////////////////
// THIS REGISTER HAS BEEN REMOVED FROM THE SPEC
// STM  REG	AE or AF
//////////////////////////
//assign  stm_reg_write_en = arbctl_csr_wr_en_c7 &
                                 //( (word_addr_c7==3'h6) |
				   //(word_addr_c7==3'h7)
				 //) ;
//dff     #(1)    ff_stm_reg_write_en_d1   (.din(stm_reg_write_en), .clk(rclk),
                               //.q(stm_reg_write_en_d1),
                               //.se(se), .si(), .so());
//
//
//assign  csr_stm_wr_en_c8 = stm_reg_write_en_d1   ;






//////////////////////////
// RD enable generation.
//////////////////////////

assign	mux1_sel_c6[0] = ( arbdp_word_addr_c6[1:0] == 2'd0 ) ; // A8 or Ac
assign	mux1_sel_c6[1] = ( arbdp_word_addr_c6[1:0] == 2'd1 ) ; // A9 or Ad
assign	mux1_sel_c6[2] = ( arbdp_word_addr_c6[1:0] == 2'd2 ) ; //Aa  or Ae


dff_s     #(3)    ff_mux1_sel_c7   (.din(mux1_sel_c6[2:0]), .clk(rclk),
                               .q(mux1_sel_c7[2:0]),
                               .se(se), .si(), .so());

assign	csr_rd_mux1_sel_c7[0] = mux1_sel_c7[0] & ~rst_tri_en ;
assign	csr_rd_mux1_sel_c7[1] = mux1_sel_c7[1] & ~rst_tri_en ;
assign	csr_rd_mux1_sel_c7[2] = mux1_sel_c7[2] & ~rst_tri_en ;
assign	csr_rd_mux1_sel_c7[3] = ~(|(mux1_sel_c7[2:0])) | rst_tri_en;

assign  csr_rd_mux2_sel_c7 = ~( mux1_sel_c7[0] | 
					mux1_sel_c7[1] ) | rst_tri_en  ;


assign	csr_rd_mux3_sel_c7[0] = ~word_addr_c7[2] ;
assign	csr_rd_mux3_sel_c7[1] = word_addr_c7[2] ;





//////////////////////////
// ERROR LOGGING LOGIC.
// UNCORR ERRORS.
//////////////////////////

/////////////////////////////////////////////////////
// LVU bit
// vuad parity. Addr=C9, syndrome = parity_c9<3:0>
// set this bit, if there is no pending uncorr err.
/////////////////////////////////////////////////////

assign	err_state_new_c8[`ERR_LVU]  = vuad_error_c8  ;

dff_s     #(1)    ff_err_state_new_c9_lvu   
			(.din(err_state_new_c8[`ERR_LVU]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_LVU]),
                         .se(se), .si(), .so());

assign	err_status_in[`ERR_LVU] = ~error_status_veu & 
			err_state_new_c9[`ERR_LVU] ;

/////////////////////////////////////////////////////
// LRU bit
// dir parity. Addr=index	syndrome = X
// set this bit if no lvu occurs and no pending uncorr err.
/////////////////////////////////////////////////////

assign	err_state_new_c8[`ERR_LRU] =   dir_error_c8 ; // directory error

dff_s     #(1)    ff_err_state_new_c9_lru   
			(.din(err_state_new_c8[`ERR_LRU]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_LRU]),
                         .se(se), .si(), .so());

assign	err_status_in[`ERR_LRU] = ~( err_state_new_c9[`ERR_LVU] |
			error_status_veu )  &
			err_state_new_c9[`ERR_LRU] ;

/////////////////////////////////////////////////////
// LDSU bit
// set for a scrub
//  Address=C7. Syndrome = data_syndrome from decc
/////////////////////////////////////////////////////

assign	err_state_new_c8[`ERR_LDSU] = decc_scrd_uncorr_err_c8 ; // scrub  uncorr err

dff_s     #(1)    ff_err_state_new_c9_ldsu   
			(.din(err_state_new_c8[`ERR_LDSU]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_LDSU]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_LDSU] = ~( err_state_new_c9[`ERR_LVU] |
                        err_state_new_c9[`ERR_LRU]  |
                        error_status_veu ) &
                        err_state_new_c9[`ERR_LDSU] ;

/////////////////////////////////////////////////////
// LDAU bit
// set for any kind of access LD/ST/ATOMIC/PST 
// Address=C9. Syndrome = data_syndrome from decc
// Only set for accesses that hit the $
/////////////////////////////////////////////////////

assign	err_state_new_c8[`ERR_LDAU] = decc_spcd_uncorr_err_c8 ; // data uncorr err

dff_s     #(1)    ff_err_state_new_c9_ldau   
			(.din(err_state_new_c8[`ERR_LDAU]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_LDAU]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_LDAU] = ~( err_state_new_c9[`ERR_LVU] |
		      err_state_new_c9[`ERR_LRU]  |
		      error_status_veu ) &
		    err_state_new_c9[`ERR_LDAU] ;

/////////////////////////////////////////////////////
// LDWU bit
// eviction error logging done in cycles r7 through r14 
// of an evict. Address logging is also done in the
// same 8 cycle window 
// ??? may need to change leave_state2 counter to 13 
// in wbctl.v
/////////////////////////////////////////////////////

assign	err_state_new_c8[`ERR_LDWU] = ev_uerr_r6 ; // eviction   uncorr err

dff_s     #(1)    ff_err_state_new_c9_ldwu   
			(.din(err_state_new_c8[`ERR_LDWU]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_LDWU]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_LDWU] = ~( err_state_new_c9[`ERR_LVU] |
			     err_state_new_c9[`ERR_LRU]  |
			     err_state_new_c9[`ERR_LDAU] |
			     err_state_new_c9[`ERR_LDSU] |
			     error_status_veu ) &
			     err_state_new_c9[`ERR_LDWU] ;


/////////////////////////////////////////////////////
// LDRU bit
// Set for an RDMA Read or an RDMA Write ( Partial ) 
//  or RDMA Write which 
// returns with an error from the DRAM. 
// Only set for accesses that hit the $
/////////////////////////////////////////////////////


assign	err_state_new_c8[`ERR_LDRU] =    decc_bscd_uncorr_err_c8 | 
				  ( rdmard_uerr_c12 & 
				~fbctl_ld64_fb_hit_c12 ) ;

dff_s     #(1)    ff_err_state_new_c9_ldru   
			(.din(err_state_new_c8[`ERR_LDRU]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_LDRU]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_LDRU] = ~( err_state_new_c9[`ERR_LVU] |
                        err_state_new_c9[`ERR_LRU] | 
		    	err_state_new_c9[`ERR_LDAU] |
		     	err_state_new_c9[`ERR_LDSU] |
			err_state_new_c9[`ERR_LDWU] |
			error_status_veu ) & 
			err_state_new_c9[`ERR_LDRU] ;

/////////////////////////////////////////////////////
// DRU bit
// FB hit only  for LD64/
// Wr8s will cause  DAU to be set in OFF mode.
/////////////////////////////////////////////////////
assign	err_state_new_c8[`ERR_DRU] = 
			( rdmard_uerr_c12 &
                                fbctl_ld64_fb_hit_c12) ;

dff_s     #(1)    ff_err_state_new_c9_dru   
			(.din(err_state_new_c8[`ERR_DRU]), .clk(rclk), 
			.q(err_state_new_c9[`ERR_DRU]),
                        .se(se), .si(), .so());

assign  err_status_in[`ERR_DRU] = ~( err_state_new_c9[`ERR_LVU] |
                             err_state_new_c9[`ERR_LRU]  |
                             err_state_new_c9[`ERR_LDAU] |
                             err_state_new_c9[`ERR_LDRU] |
                             err_state_new_c9[`ERR_LDSU] |
                             err_state_new_c9[`ERR_LDRU] |
                             err_state_new_c9[`ERR_LDWU] |
                             error_status_veu) & 
			     err_state_new_c9[`ERR_DRU] ;

/////////////////////////////////////////////////////
// DAU bit
// only set for a FB hit or a FILL
/////////////////////////////////////////////////////

assign	err_state_new_c8[`ERR_DAU]  = 
		( decc_spcfb_uncorr_err_c8 | // from a spc instruction
		fbctl_uncorr_err_c8 )  ;  // from a fill.

dff_s     #(1)    ff_err_state_new_c9_dau   
			(.din(err_state_new_c8[`ERR_DAU]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_DAU]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_DAU] = ~( err_state_new_c9[`ERR_LVU] |
                            err_state_new_c9[`ERR_LRU]  |
                            err_state_new_c9[`ERR_LDAU] |
                            err_state_new_c9[`ERR_LDRU] |
                            err_state_new_c9[`ERR_LDSU] |
                            err_state_new_c9[`ERR_LDRU] |
			    err_state_new_c9[`ERR_LDWU] |
                             err_state_new_c9[`ERR_DRU] |
                            error_status_veu ) & 
			err_state_new_c9[`ERR_DAU] ;





/////////////////////////////////////////////////////
// DSU bit
// This bit does not influence MEU
// and does not need to go through the
// priority logic
/////////////////////////////////////////////////////

assign	err_state_new_c8[`ERR_DSU] =  dram_scb_mecc_err_d1 ; 
		// scrub in DRAM causing an error.

dff_s     #(1)    ff_err_state_new_c9_dsu   
			(.din(err_state_new_c8[`ERR_DSU]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_DSU]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_DSU] = err_state_new_c9[`ERR_DSU] ;
				 
				

/////////////////////////////////////////////////////
// MEU bit
// Multiple error uncorrectable bit is set if multiple 
// uncorrectable errors happen in the same cycle or
// are separated in time.
// This bit is set if the vector being written in
// is different from the vector that is detected 
/////////////////////////////////////////////////////

assign	new_uerr_vec_c9 = { err_state_new_c9[`ERR_LDAU],
			   err_state_new_c9[`ERR_LDWU],
			   err_state_new_c9[`ERR_LDRU],
			   err_state_new_c9[`ERR_LDSU],
			   err_state_new_c9[`ERR_LRU],
			   err_state_new_c9[`ERR_LVU],
			   err_state_new_c9[`ERR_DAU],
			   err_state_new_c9[`ERR_DRU] } ;

// atleast 10 gates to do the priority.
assign	wr_uerr_vec_c9 = { err_status_in[`ERR_LDAU],
                           err_status_in[`ERR_LDWU],
                           err_status_in[`ERR_LDRU],
                           err_status_in[`ERR_LDSU],
                           err_status_in[`ERR_LRU],
                           err_status_in[`ERR_LVU],
                           err_status_in[`ERR_DAU],
                           err_status_in[`ERR_DRU] } ;

assign	err_status_in[`ERR_MEU] = |( ~wr_uerr_vec_c9 & new_uerr_vec_c9 ) ; 




/////////////////////////////////////////////////////
// VEU bit
/////////////////////////////////////////////////////
assign	err_status_in[`ERR_VEU] = |(new_uerr_vec_c9) ;



/////////////////////////////////////////////////////
// ERROR LOGGING LOGIC.
// CORR ERRORS.
// correctible errors are logged if 
// * there is no uncorr err in the same cycle.
// * there is no pending corr or uncorr err.
/////////////////////////////////////////////////////

/////////////////////////////////////////////////////
// LTC bit
/////////////////////////////////////////////////////

assign	err_state_new_c8[`ERR_LTC]  = tag_error_c8 ;

dff_s     #(1)    ff_err_state_new_c9_ltc   
			(.din(err_state_new_c8[`ERR_LTC]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_LTC]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_LTC] = ~( err_status_in[`ERR_VEU] |
		 & error_status_veu |
		   error_status_vec ) & 
		err_state_new_c9[`ERR_LTC] ;

/////////////////////////////////////////////////////
// LDSC bit
// addr=C9 and syndrome = data synd.
/////////////////////////////////////////////////////

assign	err_state_new_c8[`ERR_LDSC] = decc_scrd_corr_err_c8 ;

dff_s     #(1)    ff_err_state_new_c9_ldsc   
			(.din(err_state_new_c8[`ERR_LDSC]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_LDSC]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_LDSC] = ~( err_status_in[`ERR_VEU] |
                               error_status_veu |
                               error_status_vec |
                               err_state_new_c9[`ERR_LTC] ) &
                               err_state_new_c9[`ERR_LDSC] ; // LDAC and LDSC are mutex
								
/////////////////////////////////////////////////////
// LDAC bit
/////////////////////////////////////////////////////
assign	err_state_new_c8[`ERR_LDAC] = decc_spcd_corr_err_c8 ; 
					
dff_s     #(1)    ff_err_state_new_c9_ldac   
			(.din(err_state_new_c8[`ERR_LDAC]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_LDAC]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_LDAC] =  ~( err_status_in[`ERR_VEU] |
                         error_status_veu |
                         error_status_vec |
		  err_state_new_c9[`ERR_LTC] ) &
			err_state_new_c9[`ERR_LDAC] ;

/////////////////////////////////////////////////////
// LDWC bit
// comes from a Wback 
// addr = evicted address and syndrome = datasyndrome.
/////////////////////////////////////////////////////

assign	err_state_new_c8[`ERR_LDWC] = ev_cerr_r6  ;

dff_s     #(1)    ff_err_state_new_c9_ldwc   	
			(.din(err_state_new_c8[`ERR_LDWC]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_LDWC]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_LDWC] = ~( err_status_in[`ERR_VEU] |
                               error_status_veu |
                               error_status_vec |
                              err_state_new_c9[`ERR_LTC] |
		   	err_state_new_c9[`ERR_LDSC] |
			   err_state_new_c9[`ERR_LDAC]  ) &
                           err_state_new_c9[`ERR_LDWC] ; // LDAC and LDSC are mutex


/////////////////////////////////////////////////////
// LDRC bit
// comes from an RDMA Read access and 
// only for a $ hit
/////////////////////////////////////////////////////

assign	err_state_new_c8[`ERR_LDRC] =  decc_bscd_corr_err_c8 |
                                  ( rdmard_cerr_c12 &
                                ~fbctl_ld64_fb_hit_c12 ) ;
					

dff_s     #(1)    ff_err_state_new_c9_ldrc   
			(.din(err_state_new_c8[`ERR_LDRC]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_LDRC]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_LDRC] =  ~( err_status_in[`ERR_VEU] |
                         error_status_veu |
                        error_status_vec |
                        err_state_new_c9[`ERR_LTC] |
                        err_state_new_c9[`ERR_LDSC] | 
			err_state_new_c9[`ERR_LDWC] |
                        err_state_new_c9[`ERR_LDAC]  ) & 
			err_state_new_c9[`ERR_LDRC] ;

/////////////////////////////////////////////////////
// DRC bit
// ld 64 will cause DRC to be set.
/////////////////////////////////////////////////////
assign	err_state_new_c8[`ERR_DRC] = 	fbctl_bsc_corr_err_c12 ;

dff_s     #(1)    ff_err_state_new_c9_drc   
			(.din(err_state_new_c8[`ERR_DRC]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_DRC]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_DRC] = ~( err_status_in[`ERR_VEU] |
                        error_status_veu |
                        error_status_vec |
                        err_state_new_c9[`ERR_LTC] |
                        err_state_new_c9[`ERR_LDSC] | 
                        err_state_new_c9[`ERR_LDAC]  |
                        err_state_new_c9[`ERR_LDWC] | 
                        err_state_new_c9[`ERR_LDRC] 
			) &
                        err_state_new_c9[`ERR_DRC];

/////////////////////////////////////////////////////
// DAC bit
// Only an fb hit or a fill
/////////////////////////////////////////////////////
assign	err_state_new_c8[`ERR_DAC]  = ( decc_spcfb_corr_err_c8 |
					fbctl_corr_err_c8 )   ;

dff_s     #(1)    ff_err_state_new_c9_dac   
			(.din(err_state_new_c8[`ERR_DAC]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_DAC]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_DAC] = ~( err_status_in[`ERR_VEU] |
                                    error_status_veu |
                                   error_status_vec |
                                   err_state_new_c9[`ERR_LTC] |
                                   err_state_new_c9[`ERR_LDSC] | 
                                   err_state_new_c9[`ERR_LDAC]  |
                                   err_state_new_c9[`ERR_LDWC] | 
                                   err_state_new_c9[`ERR_LDRC] |
                                   err_state_new_c9[`ERR_DRC] 
					) & 
				err_state_new_c9[`ERR_DAC];

/////////////////////////////////////////////////////
// DSC bit
/////////////////////////////////////////////////////
assign	err_state_new_c8[`ERR_DSC] = dram_scb_secc_err_d1 ;

dff_s     #(1)    ff_err_state_new_c9_dsc   
			(.din(err_state_new_c8[`ERR_DSC]), .clk(rclk),
                         .q(err_state_new_c9[`ERR_DSC]),
                         .se(se), .si(), .so());

assign  err_status_in[`ERR_DSC] = err_state_new_c9[`ERR_DSC] ;

/////////////////////////////////////////////////////
// MEC bit
// set if the corr err detected is unable to record in the L2 esr
// OR if an uncorrectable err happens when a corr err has already occurred.
/////////////////////////////////////////////////////

assign	wr_cerr_vec_c9 = {  err_status_in[`ERR_LTC],
			    err_status_in[`ERR_LDAC],
			    err_status_in[`ERR_LDRC],
			    err_status_in[`ERR_LDWC],
			    err_status_in[`ERR_LDSC],
			    err_status_in[`ERR_DAC],
			    err_status_in[`ERR_DRC] } ;

assign	new_cerr_vec_c9 = {  err_state_new_c9[`ERR_LTC],
			    err_state_new_c9[`ERR_LDAC],
			    err_state_new_c9[`ERR_LDRC],
			    err_state_new_c9[`ERR_LDWC],
			    err_state_new_c9[`ERR_LDSC],
			    err_state_new_c9[`ERR_DAC],
			    err_state_new_c9[`ERR_DRC] } ;

assign  err_status_in[`ERR_MEC] = (|( ~wr_cerr_vec_c9 & new_cerr_vec_c9 )) |
			 ( err_status_in[`ERR_VEU] & error_status_vec ) ;

/////////////////////////////////////////////////////
// VEC bit
/////////////////////////////////////////////////////
assign	err_status_in[`ERR_VEC] = |( new_cerr_vec_c9 ) ;



/////////////////////////////////////////////////////
// RW bit
// 1 for a write access
// Set to 1 for Stores, strm stores, CAs, SWAP, LDSTUB
// or rdma psts that encounter an error.
/////////////////////////////////////////////////////


assign	rdma_pst_err_c9 = bscd_uncorr_err_c9 | bscd_corr_err_c9 ;


dff_s     #(1)    ff_store_error_c9   
			(.din(store_err_c8), .clk(rclk),
                         .q(store_error_c9),
                         .se(se), .si(), .so());

assign	error_spc = ( err_status_in[`ERR_LDAU] | err_status_in[`ERR_LDAC] |
                err_status_in[`ERR_DAU] | err_status_in[`ERR_DAC]) ;

assign	error_bsc = ( err_status_in[`ERR_LDRU] | err_status_in[`ERR_LDRC] |
                err_status_in[`ERR_DRU] | err_status_in[`ERR_DRC] );

assign	err_status_in[`ERR_RW] = ( store_error_c9 & error_spc) |
				( rdma_pst_err_c9 & error_bsc & 
				~( rdmard_uerr_c13 | rdmard_cerr_c13 ) ) ;

assign	error_rw_en  = ( error_spc | error_bsc )  |
			(  diag_wr_en ) ;


/////////////////////////////////////////////////////
// ERROR STATUS BITS to CSR from csr_ctl.
/////////////////////////////////////////////////////
assign	err_state_in_mec = err_status_in[`ERR_MEC];
assign	err_state_in_meu = err_status_in[`ERR_MEU];

assign	err_state_in_rw = err_status_in[`ERR_RW];


assign	err_state_in[`ERR_LDAC:`ERR_VEU] = err_status_in[`ERR_LDAC:`ERR_VEU] ;


/////////////////////////////////////////////////////
// SYNDROME
// recorded for
// * vuad errors
// * ldac/ldau
// * ldrc/ldru for rdma writes only.
/////////////////////////////////////////////////////

dff_s     #(1)    ff_rdmard_uerr_c13   
			(.din(rdmard_uerr_c12), .clk(rclk),
                         .q(rdmard_uerr_c13),
                         .se(1'b0), .si(), .so());

dff_s     #(1)    ff_rdmard_cerr_c13   
			(.din(rdmard_cerr_c12), .clk(rclk),
                         .q(rdmard_cerr_c13),
                         .se(1'b0), .si(), .so());


assign    mux1_synd_sel[0] = err_status_in[`ERR_LVU];
assign    mux1_synd_sel[1] = ~err_status_in[`ERR_LVU];
assign    mux2_synd_sel[0] = ((err_state_new_c9[`ERR_LDAU] | 
				err_state_new_c9[`ERR_LDAC]) |
                              (( err_state_new_c9[`ERR_LDRU] | 
				err_state_new_c9[`ERR_LDRC] ) &
                               ~( rdmard_uerr_c13 | rdmard_cerr_c13 ))
                              ) ;

assign    mux2_synd_sel[1] = ~mux2_synd_sel[0] ;


assign  csr_synd_wr_en =  diag_wr_en | 
			( new_err_sel & ( mux1_synd_sel[0] | mux2_synd_sel[0] )) ;




/////////////////////////////////////////////////////
// TID
// reported for
// * ldac/ldau errors
// * dac/dau errors when they are
//   detected/reported by an instruction other than a FILL
/////////////////////////////////////////////////////


assign  wr_enable_tid_c9 = ( err_status_in[`ERR_LDAC] |
                             err_status_in[`ERR_LDAU] |
                             err_status_in[`ERR_DAC] |
                             err_status_in[`ERR_DAU] ) ;

assign  csr_tid_wr_en = ( wr_enable_tid_c9 | diag_wr_en ) ;



/////////////////////////////////////////////////////
// ASYNC
// reported for only ldac/ldau errors.
/////////////////////////////////////////////////////

dff_s     #(1)    ff_str_ld_hit_c8   (.din(str_ld_hit_c7), .clk(rclk),
                               .q(str_ld_hit_c8),
                               .se(1'b0), .si(), .so());

dff_s     #(1)    ff_str_ld_hit_c9   (.din(str_ld_hit_c8), .clk(rclk),
                               .q(str_ld_hit_c9),
                               .se(1'b0), .si(), .so());

dff_s     #(1)    ff_async_bit_c9   (.q(async_bit_c9), .clk(rclk),
                          .din(arbdp_async_bit_c8),
                          .se(se), .si(), .so());


assign  wr_enable_async_c9 = (err_status_in[`ERR_LDAC] |
				err_status_in[`ERR_DAC] |
				err_status_in[`ERR_DAU] |
                    		err_status_in[`ERR_LDAU] ) ;


assign	set_async_c9 = str_ld_hit_c9 & async_bit_c9 ;

assign  csr_async_wr_en =  ( wr_enable_async_c9 |
                            diag_wr_en ) ;




/////////////////////////////////////////////////////
// ADDRESS PRIORITIES
/////////////////////////////////////////////////////
// 
// 1. LVU		pipe-addr
// 2. LRU		dir_addr
// 3a. LDSU		scrub addr
// 3b. LDAU		pipe_addr.
// 4.  LDWU		evict_addr
// 5a. LDRU		rdma rd addr.
// 5b. LDRU		pipe_addr.
// 6a.  DRU		rdma rd addr.
// 6b.  DRU		pipe addr 
// 6c.	DAU		pipe_addr
// 7.	LTC		pipe_addr
// 8a.  LDSC		scrub addr.
// 8b.  LDAC		pipe_addr
// 9. LDWC		evict_addr
// 10a. LDRC		rdma rd addr.
// 10b. LDRC		pipe_addr.
// 11a  DRC		rdma rd addr.
// 11b	DRC		pipe addr
// 11c  DAC		pipe_addr.
/////////////////////////////////////////////////////

dff_s     #(1)    ff_bscd_uncorr_err_c9   
			(.din(decc_bscd_uncorr_err_c8), .clk(rclk),
                         .q(bscd_uncorr_err_c9),
                         .se(se), .si(), .so());

dff_s     #(1)    ff_bscd_corr_err_c9   
			(.din(decc_bscd_corr_err_c8), .clk(rclk),
                         .q(bscd_corr_err_c9),
                         .se(se), .si(), .so());

dff_s     #(1)    ff_bsc_corr_err_c13  
			(.din(fbctl_bsc_corr_err_c12), .clk(rclk),
                         .q(bsc_corr_err_c13),
                         .se(1'b0), .si(), .so());

assign  mux1_addr_sel_tmp[0] = err_state_new_c9[`ERR_LRU] ; // sel dir addr.

assign  mux1_addr_sel_tmp[1] =  
		(( err_state_new_c9[`ERR_LDSU]  & ~err_state_new_c9[`ERR_LRU] ) |
                 ( err_state_new_c9[`ERR_LDSC]  & ~err_status_in[`ERR_VEU]) ) ; // scrub addr.

assign  mux1_addr_sel_tmp[2] =  (( err_state_new_c9[`ERR_LDWU]  & ~err_state_new_c9[`ERR_LDSU]
                                & ~err_state_new_c9[`ERR_LRU] ) |
                             (  err_state_new_c9[`ERR_LDWC]  &
                                ~err_status_in[`ERR_VEU] &
                                ~err_state_new_c9[`ERR_LDSC]) ) ; // evict addr.

assign  mux1_addr_sel_tmp[3] = ~|(mux1_addr_sel_tmp[2:0]);


assign	mux1_addr_sel[0] = mux1_addr_sel_tmp[0] & ~rst_tri_en ;
assign	mux1_addr_sel[1] = mux1_addr_sel_tmp[1] & ~rst_tri_en ;
assign	mux1_addr_sel[2] = mux1_addr_sel_tmp[2] & ~rst_tri_en ;
assign	mux1_addr_sel[3] = ( mux1_addr_sel_tmp[3] |  rst_tri_en ) ;


assign    err_sel = ( err_status_in[`ERR_VEC] |
                     err_status_in[`ERR_VEU] ) ;

assign	diag_wr_en = csr_errstate_wr_en_c8  & ~err_sel ;

assign  rdmard_addr_sel_c13 = ( (err_state_new_c9[`ERR_LDRU] | err_state_new_c9[`ERR_DRU] ) |
                              (( err_state_new_c9[`ERR_LDRC] | err_state_new_c9[`ERR_DRC]) 
				& ~err_status_in[`ERR_VEU])) & 
				(rdmard_uerr_c13 |
                                rdmard_cerr_c13 | 
				bsc_corr_err_c13 );	// rdma rd addr only


// Fix for bug#4375
// when an error is detected in a  rdma rd and a wr8 in the same cycle, 
// the wr8 address is discarded and the rdma rd address is selected.
// the pipe_addr_sel expression needed appropriate qualifications with
// rdmard_uerr_c13 & ( rdmard_cerr_c13 | bsc_corr_err_c13 ) 

assign	pipe_addr_sel	= ( err_state_new_c9[`ERR_LVU]  | 
				(~err_state_new_c9[`ERR_LRU] & err_state_new_c9[`ERR_LDAU] ) |
		(~err_state_new_c9[`ERR_LRU] & ~err_state_new_c9[`ERR_LDWU] & bscd_uncorr_err_c9  & ~rdmard_uerr_c13))  |
			 (~err_status_in[`ERR_VEU] & 
				(err_state_new_c9[`ERR_LTC] |
				 err_state_new_c9[`ERR_LDAC] |
				 ( bscd_corr_err_c9 & ~err_state_new_c9[`ERR_LDWC] & ~rdmard_cerr_c13 & ~bsc_corr_err_c13 ))
			 ); 	 // pipe addr only

				 
			

assign  mux2_addr_sel_tmp[0] = ( rdmard_addr_sel_c13 |
                                (|(mux1_addr_sel_tmp[2:0])) ) &
				~pipe_addr_sel   ; // sel mux1 
							  // if err
							  // or rdma rd

assign  mux2_addr_sel_tmp[1] = err_sel & ~mux2_addr_sel_tmp[0] ;  // sel pipe addr
							  // a9

assign  mux2_addr_sel_tmp[2] = ~(mux2_addr_sel_tmp[1] | mux2_addr_sel_tmp[0] ) ;
							// sel wr data.

assign	mux2_addr_sel[0] = mux2_addr_sel_tmp[0] & ~rst_tri_en ;
assign	mux2_addr_sel[1] = mux2_addr_sel_tmp[1] & ~rst_tri_en ;
assign	mux2_addr_sel[2] = ( mux2_addr_sel_tmp[2] |  rst_tri_en ) ;

assign  new_err_sel = |(wr_uerr_vec_c9)  | (|(wr_cerr_vec_c9) ) ;

// An error gets priority to write into the EAR if an error
// and a diagnostic write try to update the EAR in the same cycle.
// Bug #3986. 
// err_addr_sel indicates that an error occurred. In this case,
// any diagnostic write is disabled.

assign  csr_addr_wr_en = ( csr_erraddr_wr_en_c8 & ~err_sel ) | new_err_sel ;



/////////////////////////////////////////////////////
// POR signalled for LVU/LRU
// PMB requires reset assertion for 6 cycles.
// The following signal is not a C8 signal but 
// that is the name it has been given.
//
// This request is conditioned in JBI with an enable bit
// before actually causing a POR.
/////////////////////////////////////////////////////

assign  en_por_c7 = ( err_state_new_c9[`ERR_LVU] | err_state_new_c9[`ERR_LRU] ) ;

dff_s     #(1)    ff_en_por_c7_d1   (.din(en_por_c7), .clk(rclk),
                               .q(en_por_c7_d1),
                               .se(1'b0), .si(), .so());

assign	sctag_por_req = en_por_c7_d1 ;





				
			

endmodule

