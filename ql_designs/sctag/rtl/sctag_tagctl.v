// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_tagctl.v
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
/////////////////////////////////////////////////////////////////////
// Global header file includes
////////////////////////////////////////////////////////////////////////

`include 	"iop.h"

`include 	"sctag.h"


module sctag_tagctl( /*AUTOARG*/
   // Outputs
   tagctl_hit_way_vld_c3, tagctl_st_to_data_array_c3, 
   tagctl_hit_l2orfb_c3, tagctl_miss_unqual_c2, tagctl_hit_unqual_c2, 
   tagctl_hit_c3, tagctl_lru_way_c4, tagctl_rdma_vld_px0_p, 
   tagctl_hit_not_comp_c3, alt_tagctl_miss_unqual_c3, 
   mbctl_rdma_reg_vld_c2, scbuf_fbwr_wen_r2, scbuf_fbd_stdatasel_c3, 
   scdata_way_sel_c2, scdata_col_offset_c2, scdata_rd_wr_c2, 
   scdata_word_en_c2, tagctl_decc_addr3_c7, decc_tag_acc_en_px2, 
   data_ecc_active_c3, tagctl_decc_data_sel_c8, 
   tagctl_scrub_rd_vld_c7, tagctl_spc_rd_vld_c7, 
   tagctl_bsc_rd_vld_c7, scrub_addr_way, tagctl_imiss_hit_c5, 
   tagctl_ld_hit_c5, tagctl_strst_ack_c5, tagctl_st_ack_c5, 
   tagctl_st_req_c5, tagctl_nonmem_comp_c6, tagctl_uerr_ack_c5, 
   tagctl_cerr_ack_c5, tagctl_int_ack_c5, tagctl_fwd_req_ret_c5, 
   sel_rdma_inval_vec_c5, tagctl_rdma_wr_comp_c4, 
   tagctl_rmo_st_ack_c5, tagctl_inst_mb_c5, tagctl_hit_c5, 
   tagctl_store_inst_c5, tagctl_fwd_req_ld_c6, 
   tagctl_rdma_gate_off_c2, tagctl_rd64_complete_c11, 
   uerr_ack_tmp_c4, cerr_ack_tmp_c4, spc_rd_cond_c3, 
   tagctl_rdma_vld_px1, tagctl_rdma_ev_en_c4, tagctl_inc_rdma_cnt_c4, 
   tagctl_set_rdma_reg_vld_c4, tagctl_jbi_req_en_c6, so, 
   tagctl_mbctl_par_err_c3, 
   // Inputs
   tag_way_sel_c2, vuad_dp_valid_c2, lru_way_sel_c3, 
   tagdp_tagctl_par_err_c3, bist_data_enc_way_sel_c1, 
   bist_data_enable_c1, bist_data_wr_enable_c1, bist_data_waddr_c1, 
   arbdp_addr5to4_c1, arbdp_addr3to2_c1, arbaddr_addr22_c2, 
   arbdp_diag_wr_way_c2, arbdp_inst_way_c3, decdp_tagctl_wr_c1, 
   decdp_cas2_from_mb_ctrue_c2, decdp_cas2_from_mb_c2, 
   decdp_strst_inst_c2, arbdp_dword_st_c2, decdp_rmo_st_c3, 
   arbdp_rdma_inst_c1, decdp_ld64_inst_c1, decdp_wr64_inst_c2, 
   decdp_wr8_inst_c2, arbctl_tagctl_pst_with_ctrue_c1, 
   l2_bypass_mode_on, bist_or_diag_acc_c1, arbctl_fill_vld_c2, 
   arbctl_imiss_vld_c2, arbctl_evict_vld_c2, 
   arbctl_tagctl_inst_vld_c2, arbctl_waysel_gate_c2, 
   arbctl_data_diag_st_c2, arbctl_csr_wr_en_c3, arbctl_csr_rd_en_c3, 
   arbctl_diag_complete_c3, decc_scrd_uncorr_err_c8, 
   mbctl_tagctl_hit_unqual_c2, mbctl_uncorr_err_c2, 
   mbctl_corr_err_c2, mbctl_wr64_miss_comp_c3, decdp_swap_inst_c2, 
   arbdp_tagctl_pst_no_ctrue_c2, decdp_cas1_inst_c2, 
   decdp_ld_inst_c2, arbdp_inst_mb_c2, arbdp_inst_dep_c2, 
   decdp_st_inst_c2, decdp_st_with_ctrue_c2, decdp_inst_int_c2, 
   decdp_fwd_req_c2, arbctl_inst_diag_c2, arbctl_inval_inst_c2, 
   arbctl_waysel_inst_vld_c2, arbctl_coloff_inst_vld_c2, 
   arbctl_rdwr_inst_vld_c2, wr8_inst_no_ctrue_c1, 
   fbctl_tagctl_hit_c2, dram_sctag_chunk_id_r1, 
   dram_sctag_data_vld_r1, fbctl_dis_cerr_c3, fbctl_dis_uerr_c3, 
   oqctl_st_complete_c7, arbdp_tecc_c1, arst_l, grst_l, dbginit_l, 
   rclk, si, se, error_nceen, error_ceen, tagdp_mbctl_par_err_c3
   );

output	[11:0]	tagctl_hit_way_vld_c3; // to vuad dp qualified with mbctl already
output		tagctl_st_to_data_array_c3; // to vuad dp for dirty bit setting.
output		tagctl_hit_l2orfb_c3;

// to mbctl
output		tagctl_miss_unqual_c2;	// used for miss Buffer insertion. 
output		tagctl_hit_unqual_c2;  // used  for miss buffer deletion.
output		tagctl_hit_c3; // used in mbctl to ready dependents.
output	[3:0]	tagctl_lru_way_c4 ; // to mbctl for registering the lru way.

output		tagctl_rdma_vld_px0_p; // to the miss buffer picker.
output		tagctl_hit_not_comp_c3;
output		alt_tagctl_miss_unqual_c3;
output		mbctl_rdma_reg_vld_c2 ; // POST 3.0 pin TOP

// to scbuf fbdata
output	[15:0]	scbuf_fbwr_wen_r2;
output		scbuf_fbd_stdatasel_c3;

// to scdata
output	[11:0]	scdata_way_sel_c2;
output	[3:0]	scdata_col_offset_c2;
//output		scdata_hold_c3; 	// REMOVED POST_4.0
output		scdata_rd_wr_c2;	
output	[15:0]	scdata_word_en_c2;

output	tagctl_decc_addr3_c7; // deccdp for 64b mux sel
output	decc_tag_acc_en_px2; // arbctl for tag/vuad acc en generation
output	data_ecc_active_c3 ; // arbctl for arb mux sel generation
output	tagctl_decc_data_sel_c8; // used by arbdata to sel scrub data over store data.
output	tagctl_scrub_rd_vld_c7 ; // to deccdp.
output	tagctl_spc_rd_vld_c7; // to deccdp indicating that a spc read is ON
output	tagctl_bsc_rd_vld_c7; // NEW_PIN to decc_ctl
output	[3:0]	scrub_addr_way; // goes to csr

// to oqctl
output	tagctl_imiss_hit_c5; // meant for generating req_vec and type.
output	tagctl_ld_hit_c5; // meant for generating req_vec
output	tagctl_strst_ack_c5; // meant for generating req_vec
output	tagctl_st_ack_c5; // meant for generating req_vec
output	tagctl_st_req_c5; // meant for generating rqtyp
output	tagctl_nonmem_comp_c6; // csr or diagnotic instructions complete.
output	tagctl_uerr_ack_c5;
output	tagctl_cerr_ack_c5;
output	tagctl_int_ack_c5;
output	tagctl_fwd_req_ret_c5; // to oqctl
//output	tagctl_fwd_req_in_c5; // to oqctl.
output	sel_rdma_inval_vec_c5; // to oqctl.
output	tagctl_rdma_wr_comp_c4;  // to oqctl for rdma state m/c
output	tagctl_rmo_st_ack_c5; // NEW_PIN to oqctl.v
output	tagctl_inst_mb_c5; // NEW_PIN to oqctl.v
output	tagctl_hit_c5; // NEW_PIN to oqctl.v

// to oq_dctl
output	tagctl_store_inst_c5; // to oq_dctl.
output	tagctl_fwd_req_ld_c6; 

// to fbctl
output	tagctl_rdma_gate_off_c2; // to fbctl for gating off fb hit.
output  tagctl_rd64_complete_c11; // NEW_PIN
output	uerr_ack_tmp_c4, cerr_ack_tmp_c4 ; // POST_2.0 pins
output	spc_rd_cond_c3 ; // POST 3.2

// to arbctl
output	tagctl_rdma_vld_px1; // to the arbiter.

// rdmatctl.
output	tagctl_rdma_ev_en_c4;

// to scbuf_rep
output		tagctl_inc_rdma_cnt_c4; // NEW_PIN
output		tagctl_set_rdma_reg_vld_c4 ; // NEW_PIN
output		tagctl_jbi_req_en_c6; // NEW_PIN


output	so;

input	[11:0]	tag_way_sel_c2; // from the tag

input	[11:0]	vuad_dp_valid_c2; // from vuad dp
input	[11:0]	lru_way_sel_c3; // from vuad dp

input		tagdp_tagctl_par_err_c3 ; // from tagdp.

input	[3:0]	bist_data_enc_way_sel_c1;
input		bist_data_enable_c1;
input		bist_data_wr_enable_c1;
input	[3:0]	bist_data_waddr_c1;

// from arbaddr
input   [1:0]	arbdp_addr5to4_c1; // from arbaddr
input   [1:0]	arbdp_addr3to2_c1; // from arbaddr

input		arbaddr_addr22_c2; // diagnostic word address. from arbaddr.
input	[3:0]	arbdp_diag_wr_way_c2; // from arbaddr. addr<21..18>

// from arbdec
input	[3:0]	arbdp_inst_way_c3; // from arbdec
input	decdp_tagctl_wr_c1; // indicates a write into the L2$ data array. 
				    // from arbdec
input	decdp_cas2_from_mb_ctrue_c2; // indicates that cas2 will write into the L2. 
				    // from arbdec.
input	decdp_cas2_from_mb_c2;
input	decdp_strst_inst_c2;
input	arbdp_dword_st_c2 ; // indicates a 64b write to the data array
input	decdp_rmo_st_c3; // NEW_PIN from arbdec.

// rdma related decoded inputs from arbdec.
input	arbdp_rdma_inst_c1; // POST 3.0 pin replaces arbdp_rdma_inst_c2 
input	decdp_ld64_inst_c1; // indicates a 64B read from the data array from BSC/JBI
input	decdp_wr64_inst_c2; 
input	decdp_wr8_inst_c2;

// from tagctl  POST_3.4 Top
input	arbctl_tagctl_pst_with_ctrue_c1 ;

input	l2_bypass_mode_on;

input	bist_or_diag_acc_c1;
input	arbctl_fill_vld_c2;
input	arbctl_imiss_vld_c2; 
input	arbctl_evict_vld_c2; 
input	arbctl_tagctl_inst_vld_c2;
input	arbctl_waysel_gate_c2;
input	arbctl_data_diag_st_c2; // diagnostic store to data array from arbctl.
input	arbctl_csr_wr_en_c3 ; // csr write from miss Buffer,
input	arbctl_csr_rd_en_c3 ; // csr read
input	arbctl_diag_complete_c3; // vuad, tag, data access

input	decc_scrd_uncorr_err_c8;

// from mbctl.
input	mbctl_tagctl_hit_unqual_c2; // mbctl hit not qualled with instr vld.
input	mbctl_uncorr_err_c2; // mbf uncorr err means no store. 
input	mbctl_corr_err_c2;
input	mbctl_wr64_miss_comp_c3 ; // indicates wr64 completion
//input	mbctl_gate_off_par_err_c3 ; // from mbctl POST_3.4


// arbdec
input	decdp_swap_inst_c2;
input	arbdp_tagctl_pst_no_ctrue_c2;	 // Pin on TOP
input	decdp_cas1_inst_c2;
input	decdp_ld_inst_c2;
input	arbdp_inst_mb_c2; // from arbdec
input	arbdp_inst_dep_c2; // from arbdec
input	decdp_st_inst_c2; // from arbdec.
input	decdp_st_with_ctrue_c2;
input	decdp_inst_int_c2;
input	decdp_fwd_req_c2; // from arbdec

// arbctl.
input	arbctl_inst_diag_c2; // from arbctl.
input	arbctl_inval_inst_c2;
input  arbctl_waysel_inst_vld_c2; // POST_2.0
input  arbctl_coloff_inst_vld_c2; // POST_2.0
input  arbctl_rdwr_inst_vld_c2; // POST_2.0
// input  arbctl_wen_inst_vld_c2; // REMOVED POST_4.0
input	wr8_inst_no_ctrue_c1; // POST_3.4


// from fbctl
input		fbctl_tagctl_hit_c2; // fbctl hit.
input	[1:0]	dram_sctag_chunk_id_r1; // chunk id for fbdata wr
input		dram_sctag_data_vld_r1;
input	fbctl_dis_cerr_c3;
input	fbctl_dis_uerr_c3;

input		oqctl_st_complete_c7; // from oqctl.

input	arbdp_tecc_c1; // from arbdec. Simply the tecc bit of an instruction.
input	arst_l, grst_l, dbginit_l ;
input	rclk;
input	si, se;
input	error_nceen, error_ceen ; // POST_3.2

input	tagdp_mbctl_par_err_c3;
output	tagctl_mbctl_par_err_c3;




wire	[2:0]	tagctl_jbi_req_state_in, tagctl_jbi_req_state;

wire	[3:0]	mux1_way_sel_c1, mux2_way_sel_c1, mux3_way_sel_c1;
wire		data_array_acc_active_c1, qual_way_sel_c1;
wire	[11:0]	dec_way_sel_c1;

wire	evict_unqual_vld_c3;
wire	[11:0]	mux4_way_sel_c1, hit_way_vld_c2, temp_way_sel_c2;

wire	[3:0]	encoded_lru_way_c3;
wire	tagctl_hit_c2;

wire	[1:0]	mux1_col_offset_c1, mux2_col_offset_c1, mux3_col_offset_c1;
wire	[3:0]	dec_col_offset_prev_c1, col_offset_dec_prev_c2;
wire	[3:0]	dec_col_offset_c2;
//wire	data_hold_c2;
wire	tagctl_wr_c2;
wire	prev_rd_wr_c1, prev_rd_wr_c2;

wire	[15:0]	bist_word_en_c1;
wire	[15:0]	dec_word_addr_c2;
wire	[15:0]	word_en_c2 ;
wire	[15:0]	diag_word_en_c2 ;
wire	[15:0]	mux1_wen_c1 ;
wire	[15:0]	data_ecc_wen_c1 ;
wire	[15:0]	mux2_wen_c1;
wire	[15:0]	tmp_word_en_c2 ;
wire	[15:0]	prev_wen_c1, prev_wen_c2 ;


wire	tecc_c2; 

wire	scrub_fsm_reset, scrub_fsm_en ; 
wire	[3:0]	scrub_fsm_cnt, scrub_fsm_cnt_plus1 ;
wire	scrub_addr_reset, scrub_addr_en ;
wire	[6:0]	scrub_addr_cnt_plus1, scrub_addr_cnt ;
wire	[11:0]	dec_scrub_addr_way;
wire	scrub_way_vld_c2,scrub_way_vld_c3;
wire	scrub_way_vld_c4,scrub_way_vld_c5;
wire	scrub_way_vld_c6,scrub_way_vld_c7;
wire	qual_col_offset_c1;
wire	data_array_wr_active_c1 ;
wire	scrub_rd_vld_c8, scrub_wr_disable_c8 ;
wire	scrub_wr_disable_c9;
wire	imiss_tag_hit_c3, imiss_tag_hit_c4 ;
wire	tagctl_spc_rd_vld_c3;
wire	tagctl_spc_rd_vld_c4, tagctl_spc_rd_vld_c5;
wire	tagctl_spc_rd_vld_c6;

wire		tagctl_hit_l2orfb_c2;
wire	waysel_match_c2;

wire	[15:0]	dram_fbd_wen_r1 ;
wire	[15:0]	sctag_scbuf_fbwr_wen_r1;
wire	imiss_vld_c3;
wire	imiss_hit_c3, imiss_hit_c4, imiss_hit_c5 ;
wire	swap_inst_c3, pst_no_ctrue_c3, cas1_inst_c3, ld_inst_c3 ;
wire	ld_hit_c3, ld_hit_c4, ld_hit_c5;


wire	inst_vld_c3, inst_diag_c3, inst_mb_c3;
wire	mbctl_hit_unqual_c3;
wire	inst_dep_c3   ;
wire	pst_with_ctrue_c3, inval_inst_c3;
wire	ack_c3, st_ack_c3, strst_ack_c3, cas2_from_mb_c3; 

wire	csr_wr_en_c4, strstore_inst_c3 ;
wire	diag_complete_c4;

wire	st_ack_c4, st_ack_c5;
wire	strst_ack_c4, strst_ack_c5;
wire	st_req_c3, st_req_c4, st_req_c5 ;
wire	nonmem_comp_c4, nonmem_comp_c5, nonmem_comp_c6;


wire	st_with_ctrue_c3, mbctl_uerr_c3, mbctl_cerr_c3 ;
wire	uerr_ack_c3, uerr_ack_c4, uerr_ack_c5 ;
wire	cerr_ack_c3, cerr_ack_c4, cerr_ack_c5 ;

wire	inst_int_c3, int_ack_c3;
wire	int_ack_c4, int_ack_c5;

wire	fwd_req_c3, fwd_req_vld_diag_c3, fwd_req_vld_diagn_c3;
wire	fwd_req_vld_diag_c4;
wire	fwd_req_ret_c3, fwd_req_ret_c4, fwd_req_ret_c5 ;

wire	store_inst_c3, store_inst_c4, store_inst_c5;
wire	fwd_req_ld_c3, fwd_req_ld_c4, fwd_req_ld_c5, fwd_req_ld_c6 ;
wire	dram_sctag_data_vld_r2;

wire	sel_store_wen;

wire	fill_vld_c3;

wire	tagctl_rdmard_vld_c2, sel_c3_hit_way ;

wire	ld64_inst_c3, wr64_inst_c3, wr8_inst_c3;
wire	set_rdma_reg_vld_c3, reset_rdma_reg_vld;
wire	rd64_complete_c3;
wire	wr64_hit_complete_c3, wr8_complete_c3;
wire	rdma_reg_vld_in, rdma_reg_vld;

wire	[3:0]	rdma_cnt_plus1, rdma_cnt;
wire	rdma_cnt_reset, inc_rdma_cnt_c3;
wire	set_rdma_reg_vld_c4; 
wire	idle_state_in_l,idle_state_l;
wire	inc_rdma_cnt_c4; 
wire	 reset_rdma_vld_px0_p_in;
wire	rdma_vld_px0_p_in, rdma_vld_px0_p;
wire	reset_rdma_vld_px1_in ;
wire	rdma_vld_px1_in, rdma_vld_px1; 
wire	tagctl_rdma_ev_en_c3;


wire	tagctl_fb_hit_c2;
wire	[15:0]	fbd_word_en_c2;
wire	alt_tagctl_hit_unqual_c2;
wire	tagctl_hit_not_comp_c2;
wire	alt_tagctl_miss_unqual_c2;


wire	sel_rdma_inval_vec_c3, sel_rdma_inval_vec_c4 ;
wire	tagctl_rdma_wr_comp_c3; 
 wire	[15:0]	dec_word_addr_c1;
 wire	[1:0]	addr5to4_c2;
//wire	fwd_req_in_c3, fwd_req_in_c4, fwd_req_in_c5 ;
wire	rmo_st_ack_c3, rmo_st_ack_c4, rmo_st_ack_c5 ;
wire	inst_mb_c4, inst_mb_c5 ;

wire	tagctl_hit_c4;
wire	st_to_data_array_c3;
wire	rdma_inst_c3;
wire	tagctl_bsc_rd_vld_c3, tagctl_bsc_rd_vld_c4;
wire	tagctl_bsc_rd_vld_c5, tagctl_bsc_rd_vld_c6;


wire    rd64_complete_c4, rd64_complete_c5, rd64_complete_c6;
wire    rd64_complete_c7, rd64_complete_c8, rd64_complete_c9;
wire    rd64_complete_c10, rd64_complete_c11 ;

wire	[3:0]	dec_lo_way_sel_c1;
wire	[3:0]	dec_hi_way_sel_c1;
wire	[3:0]	dec_lo_scb_way; 
wire	[2:0] 	dec_hi_scb_way ;

wire		dbb_rst_l;
wire	uerr_ack_tmp_c3,cerr_ack_tmp_c3;
wire	vld_mbf_miss_c2;
wire	st_to_data_array_c2;
wire	[11:0]	way_sel_unqual_c2_n;
wire	vld_mbf_miss_c2_n;
wire	prev_rd_wr_c2_1;
wire	[11:0]	tagctl_hit_way_vld_c2;

wire	rdma_inst_c2;
wire	tecc_c3;
 wire	sel_prev_wen_c1, sel_prev_wen_c2;
wire	error_ceen_d1, error_nceen_d1;
wire	pst_with_ctrue_c2;
wire	tagctl_hit_unqual_c3;
wire	ld64_inst_c2;
wire	wr8_inst_no_ctrue_c2;
wire	bist_data_enable_c2;
wire	col_offset_sel_c2;
wire	decc_tag_acc_en_px1;
wire	dirty_bit_set_c2;
///////////////////////////////////////////////////////////////////
 // Reset flop
 ///////////////////////////////////////////////////////////////////

 dffrl_async    #(1)    reset_flop      (.q(dbb_rst_l),
                                        .clk(rclk),
                                        .rst_l(arst_l),
                                        .din(grst_l),
                                        .se(se), .si(), .so());



dff_s   #(1)  ff_l2_bypass_mode_on    (.din(l2_bypass_mode_on), .clk(rclk), 
				.q(l2_bypass_mode_on_d1), .se(se), .si(), .so());

dff_s   #(1)  ff_fill_vld_c3    (.din(arbctl_fill_vld_c2), .clk(rclk), 
				.q(fill_vld_c3), .se(se), .si(), .so());

////////////////////////////////////////////////////////////////////////////////////
// Way Select Logic.
// The way chosen for data access is from the following components
// * bist way
// * diagnostic data access way
// * scrub way
// * fill way 
// * hit way C3 ( imiss or an rdma rd i.e.ld64)
// * hit way 
// * lru way for an eviction
////////////////////////////////////////////////////////////////////////////////////


mux2ds  #(4) mux_mux1_way_sel_c1   (.dout (mux1_way_sel_c1[3:0]), // bist or diagnostic way.
                               	.in0(bist_data_enc_way_sel_c1[3:0]), // bist data
				.in1(arbdp_diag_wr_way_c2[3:0]), // diagnostic
                               	.sel0(bist_data_enable_c1), 
				.sel1(~bist_data_enable_c1));

mux2ds  #(4) mux_mux2_way_sel_c1   (.dout (mux2_way_sel_c1[3:0]), // bist/diagnostic or scrub way.
                               	.in0(mux1_way_sel_c1[3:0]), // bist data
				.in1(scrub_addr_way[3:0]), // scrub
                               	.sel0(~data_array_acc_active_c1), // no scrub access
				.sel1(data_array_acc_active_c1)); // scrub access

mux2ds  #(4) mux_mux3_way_sel_c1   (.dout (mux3_way_sel_c1[3:0]), // bist/diagnostic/scrub or fill way.
                               	.in0(mux2_way_sel_c1[3:0]), // bist data
				.in1(arbdp_inst_way_c3[3:0]), // fill way
                               	.sel0(~fill_vld_c3), // fill vld in C2.
				.sel1(fill_vld_c3));

assign	tagctl_mbctl_par_err_c3 = tagdp_mbctl_par_err_c3 ;

assign	qual_way_sel_c1 = ( bist_or_diag_acc_c1 | 	// L2 cache can be OFF.
			( fill_vld_c3 & ~l2_bypass_mode_on_d1 ) | // l2 cache is ON
			  data_array_acc_active_c1 ) ; // scrub state machine is accessing
							// the data $.


assign  dec_lo_way_sel_c1[0] = ( mux3_way_sel_c1[1:0]==2'd0 )
                                        & qual_way_sel_c1 ;
assign  dec_lo_way_sel_c1[1] = ( mux3_way_sel_c1[1:0]==2'd1 )
                                        & qual_way_sel_c1 ;
assign  dec_lo_way_sel_c1[2] = ( mux3_way_sel_c1[1:0]==2'd2 )
                                        & qual_way_sel_c1 ;
assign  dec_lo_way_sel_c1[3] = ( mux3_way_sel_c1[1:0]==2'd3 )
                                        & qual_way_sel_c1 ;


assign  dec_hi_way_sel_c1[0] = ( mux3_way_sel_c1[3:2]==2'd0 ) ;

assign  dec_hi_way_sel_c1[1] = ( mux3_way_sel_c1[3:2]==2'd1 ) ;

assign  dec_hi_way_sel_c1[2] = ( mux3_way_sel_c1[3:2]==2'd2 ) ;

assign  dec_hi_way_sel_c1[3] = ( mux3_way_sel_c1[3:2]==2'd3 ) ;



assign  dec_way_sel_c1[0] = dec_hi_way_sel_c1[0] &
                                dec_lo_way_sel_c1[0] ; // 0000

assign  dec_way_sel_c1[1] = dec_hi_way_sel_c1[0] &
                                dec_lo_way_sel_c1[1] ; // 0001

assign  dec_way_sel_c1[2] = dec_hi_way_sel_c1[0] &
                                dec_lo_way_sel_c1[2] ; // 0010

assign  dec_way_sel_c1[3] = dec_hi_way_sel_c1[0] &
                                dec_lo_way_sel_c1[3] ; // 0011

assign  dec_way_sel_c1[4] = ( dec_hi_way_sel_c1[1] |
                                dec_hi_way_sel_c1[3] )  &
                                dec_lo_way_sel_c1[0] ; // 0100 or 1100

assign  dec_way_sel_c1[5] = ( dec_hi_way_sel_c1[1] |
                                dec_hi_way_sel_c1[3] )  &
                                dec_lo_way_sel_c1[1] ; // 0101 or 1101

assign  dec_way_sel_c1[6] = ( dec_hi_way_sel_c1[1] |
                                dec_hi_way_sel_c1[3] )  &
                                dec_lo_way_sel_c1[2] ; // 0110 or 1110

assign  dec_way_sel_c1[7] = ( dec_hi_way_sel_c1[1] |
                                dec_hi_way_sel_c1[3] )  &
                                dec_lo_way_sel_c1[3] ; // 0111 or 1111

assign  dec_way_sel_c1[8] = dec_hi_way_sel_c1[2] &
                                dec_lo_way_sel_c1[0] ; // 1000

assign  dec_way_sel_c1[9] = dec_hi_way_sel_c1[2] &
                                dec_lo_way_sel_c1[1] ; // 1001

assign  dec_way_sel_c1[10] = dec_hi_way_sel_c1[2] &
                                dec_lo_way_sel_c1[2] ; // 1010

assign  dec_way_sel_c1[11] = dec_hi_way_sel_c1[2] &
                                dec_lo_way_sel_c1[3] ; // 1011

dff_s   #(1)  ff_ld64_inst_c2    (.din(decdp_ld64_inst_c1), .clk(rclk), 
				.q(ld64_inst_c2), .se(se), .si(), .so());


assign	tagctl_rdmard_vld_c2 = ld64_inst_c2 & arbctl_tagctl_inst_vld_c2 ;
			
assign	sel_c3_hit_way = ( arbctl_imiss_vld_c2 
				| tagctl_rdmard_vld_c2 ) &
			~mbctl_tagctl_hit_unqual_c2 &
			~l2_bypass_mode_on_d1 ;

// Use a mux flop to reduce setup.
mux2ds  #(12) mux_mu4_way_sel_c1   (.dout (mux4_way_sel_c1[11:0]), // bist/diag/fill/scrub OR imiss
                               	.in0(dec_way_sel_c1[11:0]), // bist/diag/fill/scrub way decoded
				.in1(hit_way_vld_c2[11:0]), // hit way C2 
                               	.sel0(~sel_c3_hit_way), 
				.sel1(sel_c3_hit_way));// imiss or rdma rd vld in C2.

dff_s     #(12)  ff_temp_way_sel_c2    (.din(mux4_way_sel_c1[11:0]), .clk(rclk),
               .q(temp_way_sel_c2[11:0]), .se(se), .si(), .so());


/////////////////////////////////////////////////////////////////
// An unqualled version of evict is used to 
// send the way selects to the data array
// If a tag parity error is detected while performing 
// an eviction pass, the data array is read but, eviction 
// is not performed during this pass.
/////////////////////////////////////////////////////////////////

dff_s   #(1)  ff_evict_unqual_vld_c3    (.din(arbctl_evict_vld_c2), .clk(rclk),
                    .q(evict_unqual_vld_c3), .se(se), .si(), .so());

/////////////////////////////////////////////////////////////////
// An RDMA instruction that is not a PST will not access the
// $  or the FB if the rdma reg vld is asserted.
/////////////////////////////////////////////////////////////////
dff_s   #(1)  ff_wr8_no_ctrue_c2    (.din(wr8_inst_no_ctrue_c1), .clk(rclk),
                    .q(wr8_inst_no_ctrue_c2), .se(se), .si(), .so());

assign	tagctl_rdma_gate_off_c2 = ( rdma_reg_vld &
				~wr8_inst_no_ctrue_c2 & rdma_inst_c2 );


/////////////////////////////////////////////////////////////////
// The following signal is sent to vuad dp.
// On a miss Buffer hit, the way selects are turned off to prevent 
// any dirty bit update in the vuad array
// critical signals - arbctl_tagctl_inst_vld_c2,  arbctl_waysel_gate_c2
//			arbdp_tagctl_pst_no_ctrue_c2, rdma_inst_c2 	
//			Use higher metal layer for all these signals.
/////////////////////////////////////////////////////////////////


assign	hit_way_vld_c2 = tag_way_sel_c2 & vuad_dp_valid_c2 & 
				{12{arbctl_waysel_inst_vld_c2 & 
				~tagctl_rdma_gate_off_c2 &
				arbctl_waysel_gate_c2  }} ; 


assign	vld_mbf_miss_c2 = ~mbctl_tagctl_hit_unqual_c2 & arbctl_waysel_inst_vld_c2;

assign	tagctl_hit_way_vld_c2 = hit_way_vld_c2  &
			{12{vld_mbf_miss_c2}}; 

dff_s     #(12)  ff_tagctl_hit_way_vld_c3    (.din(tagctl_hit_way_vld_c2[11:0]), .clk(rclk),
               .q(tagctl_hit_way_vld_c3[11:0]), .se(se), .si(), .so());


assign	way_sel_unqual_c2_n = ~(temp_way_sel_c2 |  
		//  way for a bist/diag/fill/scrub OR imiss 2nd packet.
 		( hit_way_vld_c2 & {12{~l2_bypass_mode_on_d1 & ~ld64_inst_c2 }} )|  
		// C2 instruction hit way 
		(lru_way_sel_c3 & {12{evict_unqual_vld_c3 &
		~tagdp_tagctl_par_err_c3 }})) ;

assign	vld_mbf_miss_c2_n = mbctl_tagctl_hit_unqual_c2 & arbctl_waysel_inst_vld_c2 ;

assign	scdata_way_sel_c2 = ~(way_sel_unqual_c2_n | {12{vld_mbf_miss_c2_n}}) ; 
			// C2 way select is turned off if the instruction in C2 is a
			// mbf hit.





//////////////////////////////////////////////////////////////////////
// MISS condition for miss buffer insertion.
// tag miss is high  if all  the following conditions are true.
// - no tag match
// - NOT an interrupt or invalidate instruction.
// - NOT a diagnostic instruction
// - NOT a tecc instruction
// - NOT a cas2 from the xbar.
//
// The tagctl_miss_unqual_c2 is also qualified with the 
// tagctl_rdma_reg_vld_c2 for a decdp_wr64_inst_c2 so that
// we do not "complete" a wr64 miss when it actually encounters
// rdma_reg_vld = 1
// 
// The tagctl_miss_unqual_c2 is only gated off by a wr64 rdma instruction
// and not by ld64 or wr8 because in those cases tagctl_miss_unqual_c2 is
// not used as a completion condition but to make a request to 
// DRAM
//////////////////////////////////////////////////////////////////////

assign	 waysel_match_c2 = |( tag_way_sel_c2 & vuad_dp_valid_c2 ) ;

assign	 tagctl_miss_unqual_c2 = (~waysel_match_c2 | l2_bypass_mode_on_d1) &	// no way sel match
				~( rdma_reg_vld & decdp_wr64_inst_c2 )  // not a wr64 with rdma_reg_vld
				& arbctl_waysel_gate_c2   ;


//////////////////////////////////////////////////////////////////////
// A version of tagctl_miss* that is not gated off by 
// the tagctl_rdma_reg_vld_c2 signal. This is used 
// to indicate  "what could have been" if the  rdma_reg_vld 
// was 0.
//////////////////////////////////////////////////////////////////////


assign	alt_tagctl_miss_unqual_c2 = (~waysel_match_c2 | 
					l2_bypass_mode_on_d1) &    // no way sel match
					  arbctl_waysel_gate_c2;

dff_s   #(1)  ff_alt_tagctl_miss_unqual_c3    (.din(alt_tagctl_miss_unqual_c2), .clk(rclk),
                    .q(alt_tagctl_miss_unqual_c3), .se(se), .si(), .so());

/////////////////////////////////////////////////////////////////////
// HIT logic
// hit way vld is qualified with ~l2_bypass_mode_on_d1 
// for generating the hit signal.
// tagctl_hit_unqual_c2 is used to delete an instruction from the mbf.
// 
//////////////////////////////////////////////////////////////////////

assign	tagctl_hit_unqual_c2 = waysel_match_c2  & arbctl_waysel_gate_c2 &
				 ~tagctl_rdma_gate_off_c2 &
				~l2_bypass_mode_on_d1;
	
assign	tagctl_hit_c2 =  tagctl_hit_unqual_c2  & vld_mbf_miss_c2 ;


dff_s   #(1)  ff_tagctl_hit_c3    (.din(tagctl_hit_c2), .clk(rclk),
                      .q(tagctl_hit_c3), .se(se), .si(), .so());

// same as the expression for fbctl_hit_c2 in fbctl.

assign	tagctl_fb_hit_c2 = fbctl_tagctl_hit_c2  & ~tagctl_rdma_gate_off_c2;

assign	tagctl_hit_l2orfb_c2 = ( tagctl_hit_c2 | tagctl_fb_hit_c2 ) ;



dff_s   #(1)  ff_tagctl_hit_l2orfb_c3    (.din(tagctl_hit_l2orfb_c2), .clk(rclk),
                    .q(tagctl_hit_l2orfb_c3), .se(se), .si(), .so());

///////////////////////////////////////
// If an rdma instruction hitting the 
// $ is not able to complete because
// of tagctl_rdma_gate_off_c2 being ON
// that instruction will be inserted in
// the Miss Buffer and readied in C7.
//
// - The insertion condition is taken 
// care off by looking at rdma_reg_vld & rdma_inst
///////////////////////////////////////


assign	alt_tagctl_hit_unqual_c2 = waysel_match_c2  & arbctl_waysel_gate_c2 &
				~l2_bypass_mode_on_d1;

assign	tagctl_hit_not_comp_c2 =  (( alt_tagctl_hit_unqual_c2 &  
					vld_mbf_miss_c2  ) | 
				fbctl_tagctl_hit_c2 ) &
				tagctl_rdma_gate_off_c2 ;
					
dff_s   #(1)  ff_tagctl_hit_not_comp_c3    (.din(tagctl_hit_not_comp_c2), .clk(rclk),
                    .q(tagctl_hit_not_comp_c3), .se(se), .si(), .so());




///////////////////////////////////////
// ** eviction way recorded in the 
// Miss Buffer and used for a Fill.
////////////////////////////////////////

assign	encoded_lru_way_c3[0] = ( lru_way_sel_c3[1] | lru_way_sel_c3[3] | lru_way_sel_c3[5] |
				lru_way_sel_c3[7] | lru_way_sel_c3[9] | lru_way_sel_c3[11] ) ;
assign	encoded_lru_way_c3[1] = ( lru_way_sel_c3[2] | lru_way_sel_c3[3] | lru_way_sel_c3[6] |
				lru_way_sel_c3[7] | lru_way_sel_c3[10] | lru_way_sel_c3[11] );
assign	encoded_lru_way_c3[2] = ( lru_way_sel_c3[4] | lru_way_sel_c3[5] | lru_way_sel_c3[6] |
				lru_way_sel_c3[7] ) ; 
assign	encoded_lru_way_c3[3] = ( lru_way_sel_c3[8] | lru_way_sel_c3[9] | lru_way_sel_c3[10] |
				lru_way_sel_c3[11] ) ;

dff_s   #(4)  ff_encoded_lru_c4    (.din(encoded_lru_way_c3[3:0]), .clk(rclk),
                     .q(tagctl_lru_way_c4[3:0]), .se(se), .si(), .so());


//////////////////////////////////////////////////////////////////////
// COL OFFSET LOGIC
// col offset(16B bank accessed ) is dependent on the instruction in the pipe as shown 
// * bist col offset in C1
// * diagnostic data access in C2
// * decc scrub access.
// * col offset of an imiss 2nd packet
// * fill 
// * evict
// * col offset of the valid instruction in C2.
//////////////////////////////////////////////////////////////////////

 dff_s   #(2)  ff_addr5to4_c2    (.din(arbdp_addr5to4_c1[1:0]), .clk(rclk),
                    .q(addr5to4_c2[1:0]), .se(se), .si(), .so());

mux2ds  #(2) mux_mux1_col_c1   (.dout (mux1_col_offset_c1[1:0]), // bist or diagnostic col.
                               	.in0(bist_data_waddr_c1[3:2]), // bist data
				.in1(addr5to4_c2[1:0]), // diagnostic 16B address.
                               	.sel0(bist_data_enable_c1), 
				.sel1(~bist_data_enable_c1));

mux2ds  #(2) mux_mux2_col_c1   (.dout (mux2_col_offset_c1[1:0]), // bist/diagnostic or scrub col.
                               	.in0(mux1_col_offset_c1[1:0]), // bist or diag col
				.in1(scrub_addr_cnt[2:1]), // scrub
                               	.sel0(~data_array_acc_active_c1), //  no scrub access
				.sel1(data_array_acc_active_c1));


mux2ds  #(2) mux_mux3_col_c1   (.dout (mux3_col_offset_c1[1:0]), // bist/diag/scrub  or imiss 2nd pckt col.
                               	.in0(mux2_col_offset_c1[1:0]), // bist/diag/scrub
				.in1({addr5to4_c2[1],1'b1}), // imiss 2nd packt
                               	.sel0(~arbctl_imiss_vld_c2), // default
				.sel1(arbctl_imiss_vld_c2));  // imiss 2nd packet active.


assign	qual_col_offset_c1 = ( arbctl_imiss_vld_c2 | 
				bist_or_diag_acc_c1 |
				data_array_acc_active_c1 ) ;

assign	dec_col_offset_prev_c1[0] = ( ( mux3_col_offset_c1[1:0] == 2'b00 ) & qual_col_offset_c1 ) | 
				fill_vld_c3 |
				tagctl_rdmard_vld_c2 |
				arbctl_evict_vld_c2 ;
assign	dec_col_offset_prev_c1[1] = ( ( mux3_col_offset_c1[1:0] == 2'b01 ) & qual_col_offset_c1 ) |
				fill_vld_c3 |
				tagctl_rdmard_vld_c2 |
                                arbctl_evict_vld_c2 ;
assign	dec_col_offset_prev_c1[2] =  ( ( mux3_col_offset_c1[1:0] == 2'b10 ) & qual_col_offset_c1 ) |
				fill_vld_c3 |
				tagctl_rdmard_vld_c2 |
                                arbctl_evict_vld_c2 ;
assign	dec_col_offset_prev_c1[3] = ( ( mux3_col_offset_c1[1:0] == 2'b11 ) & qual_col_offset_c1 ) |
				fill_vld_c3 |
				tagctl_rdmard_vld_c2 |
                                arbctl_evict_vld_c2 ;

assign	dec_col_offset_c2[0] = ( addr5to4_c2[1:0] == 2'd0 );
assign	dec_col_offset_c2[1] = ( addr5to4_c2[1:0] == 2'd1 );
assign	dec_col_offset_c2[2] = ( addr5to4_c2[1:0] == 2'd2 );
assign	dec_col_offset_c2[3] = ( addr5to4_c2[1:0] == 2'd3 );

dff_s   #(4)  ff_dec_col_offset_prev_c2    (.din(dec_col_offset_prev_c1[3:0]), .clk(rclk), 
			  .q(col_offset_dec_prev_c2[3:0]), .se(se), .si(), .so());

dff_s   #(1)  ff_bist_data_enable_c2    (.din(bist_data_enable_c1), .clk(rclk), 
			  .q(bist_data_enable_c2), .se(se), .si(), .so());



assign	col_offset_sel_c2 = arbctl_coloff_inst_vld_c2 & ~bist_data_enable_c2 ;

// Big  Endian to Little Endian conversion 
// required to match data array implementation.

mux2ds  #(4) mux_mux4_col_c2   (.dout ({scdata_col_offset_c2[0],
					scdata_col_offset_c2[1],
					scdata_col_offset_c2[2],
					scdata_col_offset_c2[3]}),
                       	.in0(col_offset_dec_prev_c2[3:0]), // prev instruc col offset
			.in1(dec_col_offset_c2[3:0]), // current instruction col offset
                      	.sel0(~col_offset_sel_c2), // sel prev instruc.
			.sel1(col_offset_sel_c2));  // sel current instruction


//////////////////////////////////////////
// hold the prev value if col_offset is non-one hot.
// This logic is not necessary since scdata uses a default.
//////////////////////////////////////////

//mux2ds  #(4) mux_tmp_col_c2   (.dout (tmp_col_offset_c2[3:0]), // col offset
                       	//.in0(col_offset_dec_prev_c2[3:0]), // prev instruc col offset
			//.in1(dec_col_offset_c2[3:0]), // current instruction col offset
                      	//.sel0(~arbctl_wen_inst_vld_c2), // sel prev instruc.
			//.sel1(arbctl_wen_inst_vld_c2));  // sel current instruction

//assign	data_hold_c2 = (&(tmp_col_offset_c2)) |
			//~(|(tmp_col_offset_c2))  ;
//
//dff   #(1)  ff_hold_c3_l  (.din(data_hold_c2), .clk(rclk),
                    //.q(scdata_hold_c3), .se(se), .si(), .so());
//



///////////////////////////////////////////////////////////////////
// tagctl_spc_rd_vld_c7 is asserted to indicate to deccdp that 
// a sparc read is active and that any error that is detected in the
// data needs to be reported as an L2 read error.
///////////////////////////////////////////////////////////////////

assign	imiss_tag_hit_c3 = imiss_vld_c3 & tagctl_hit_c3 ;

dff_s   #(1)  ff_imiss_tag_hit_c4    (.din(imiss_tag_hit_c3), .clk(rclk),
                           .q(imiss_tag_hit_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_rdma_inst_c2    (.din(arbdp_rdma_inst_c1), .clk(rclk),
                           .q(rdma_inst_c2), .se(se), .si(), .so());

dff_s   #(1)  ff_rdma_inst_c3    (.din(rdma_inst_c2), .clk(rclk),
                           .q(rdma_inst_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_st_to_data_array_c3    (.din(st_to_data_array_c2), 
		   .clk(rclk), .q(st_to_data_array_c3), .se(se), .si(), .so());

// sparc rd vld is asserted for assertion of sparc errors detected in
// the deccdp datapath.
// A rd is valid if 
// * C3 tag hit and rd is high for a non-rdma, non-pst with ctrue, non cas2 from mb
//   instruction
// * C4 tag hit for an imiss instruction.
//
// A pst with ctrue ( or a cas2 from mb ) instruction will cause a rd to the $  
// only if the earlier
// read detected an error. Hence, there is no need to detect another error on
// its second pass.

// spc_rd_cond_c3 is used by fbctl to assert 
// errors in OFF mode when a PST, SWAP or CAS2 hits
// the fill buffer and detects an ERROR.
// Read bug#3116.

assign	spc_rd_cond_c3 = ~pst_with_ctrue_c3 & 
			 ~cas2_from_mb_c3 & 
			 ~st_to_data_array_c3 &
			 ~rdma_inst_c3 ;


assign	tagctl_spc_rd_vld_c3 =  
			( tagctl_hit_c3 & // hitting the $
			spc_rd_cond_c3) | imiss_tag_hit_c4 ;

dff_s   #(1)  ff_tagctl_spc_rd_vld_c4    (.din(tagctl_spc_rd_vld_c3), .clk(rclk),
                           .q(tagctl_spc_rd_vld_c4), .se(se), .si(), .so());
dff_s   #(1)  ff_tagctl_spc_rd_vld_c5    (.din(tagctl_spc_rd_vld_c4), .clk(rclk),
                           .q(tagctl_spc_rd_vld_c5), .se(se), .si(), .so());
dff_s   #(1)  ff_tagctl_spc_rd_vld_c6    (.din(tagctl_spc_rd_vld_c5), .clk(rclk),
                           .q(tagctl_spc_rd_vld_c6), .se(se), .si(), .so());
dff_s   #(1)  ff_tagctl_spc_rd_vld_c7    (.din(tagctl_spc_rd_vld_c6), .clk(rclk),
                           .q(tagctl_spc_rd_vld_c7), .se(se), .si(), .so());


///////////////////////////////////////////////////////////////////
// tagctl_bsc_rd_vld_c7 is asserted to indicate to deccdp that 
// a bsc(wr8) read is active and that any error that is detected in the
// data needs to be reported as an L2 read error.
///////////////////////////////////////////////////////////////////

// A Wr8 with ctrue instruction will cause a rd to the $  
// only if the earlier
// read detected an error. Hence, there is no need to detect another error on
// its second pass.

assign	tagctl_bsc_rd_vld_c3 = ( tagctl_hit_c3 & // hitting the $
		   	~st_to_data_array_c3 & 
			~pst_with_ctrue_c3 &
			wr8_inst_c3 ) ;  


dff_s   #(1)  ff_tagctl_bsc_rd_vld_c4    (.din(tagctl_bsc_rd_vld_c3), .clk(rclk),
                           .q(tagctl_bsc_rd_vld_c4), .se(se), .si(), .so());
dff_s   #(1)  ff_tagctl_bsc_rd_vld_c5    (.din(tagctl_bsc_rd_vld_c4), .clk(rclk),
                           .q(tagctl_bsc_rd_vld_c5), .se(se), .si(), .so());
dff_s   #(1)  ff_tagctl_bsc_rd_vld_c6    (.din(tagctl_bsc_rd_vld_c5), .clk(rclk),
                           .q(tagctl_bsc_rd_vld_c6), .se(se), .si(), .so());
dff_s   #(1)  ff_tagctl_bsc_rd_vld_c7    (.din(tagctl_bsc_rd_vld_c6), .clk(rclk),
                           .q(tagctl_bsc_rd_vld_c7), .se(se), .si(), .so());




					
//////////////////////////////////////////
// Read Write logic.
// Write is set for the following instr.
// * Fill, 
// * diagnostic store.
// * data scrub write
// * bist write.
// * normal write in C2.
//////////////////////////////////////////
dff_s   #(1)  ff_decdp_tagctl_wr_c2  (.din(decdp_tagctl_wr_c1), .clk(rclk),
                    .q(tagctl_wr_c2), .se(se), .si(), .so());

assign	prev_rd_wr_c1 = fill_vld_c3 | // fill instruction vld
		arbctl_data_diag_st_c2  | // diagnostic store
		( data_array_wr_active_c1 & ~scrub_wr_disable_c9 ) | // scrub write operation
		 bist_data_wr_enable_c1  ; // bist wr.

dff_s   #(1) ff_prev_rd_wr_c2  (.din(prev_rd_wr_c1), .clk(rclk),
		    .q(prev_rd_wr_c2), .se(se), .si(), .so());

dff_s   #(1) ff_pst_with_ctrue_c2  (.din(arbctl_tagctl_pst_with_ctrue_c1), .clk(rclk),
		    .q(pst_with_ctrue_c2), .se(se), .si(), .so());

// mbf_hit is not used to 
assign 	scdata_rd_wr_c2 =  ~prev_rd_wr_c2  & 
				 ~( (( tagctl_wr_c2 ) | // non diagnostic, non partial st.
                ( decdp_cas2_from_mb_ctrue_c2 ) | // cas2 2nd pass
                ( pst_with_ctrue_c2 & ~mbctl_uncorr_err_c2 )) &  // pst 2nd pass
                arbctl_rdwr_inst_vld_c2 &  // instruction vld in C2
                ~arbctl_inst_diag_c2 )  ;

//////////////////////////////////////////
// tagctl_st_to_data_array_c2 logic 
// indicates that a C2 instruction is 
// going to write into the L2 data array.
//////////////////////////////////////////


dff_s   #(1) ff_prev_rd_wr_c2_1  (.din(prev_rd_wr_c1), .clk(rclk),
		    .q(prev_rd_wr_c2_1), .se(se), .si(), .so());

assign	st_to_data_array_c2 = ~scdata_rd_wr_c2 & ~prev_rd_wr_c2_1 ;
///////////////////////
// ECO fix for bug#5085.
// the signal ff_tagctl_st_to_data_array_c3
// is used only in vuaddp_ctl to set the
// dirty bit in the VUAD. A partial store
// that encounters an uncorrectable error during 
// its read, should set the dirty bit in the VUAD
// eventhough the write is disabled.
///////////////////////


assign	dirty_bit_set_c2 = st_to_data_array_c2 | pst_with_ctrue_c2 ;


dff_s   #(1) ff_tagctl_st_to_data_array_c3  (.din(dirty_bit_set_c2), .clk(rclk),
		    .q(tagctl_st_to_data_array_c3), .se(se), .si(), .so());


//////////////////////////////////////////
// WORD ENABLE logic.
//////////////////////////////////////////


 assign  bist_word_en_c1[0] = ( bist_data_waddr_c1 == 4'd0 ) ;
 assign  bist_word_en_c1[1] = ( bist_data_waddr_c1 == 4'd1 ) ;
 assign  bist_word_en_c1[2] = ( bist_data_waddr_c1 == 4'd2 )  ;
 assign  bist_word_en_c1[3] = ( bist_data_waddr_c1 == 4'd3 )  ;
 assign  bist_word_en_c1[4] = ( bist_data_waddr_c1 == 4'd4 )  ;
 assign  bist_word_en_c1[5] = ( bist_data_waddr_c1 == 4'd5 )  ;
 assign  bist_word_en_c1[6] = ( bist_data_waddr_c1 == 4'd6 )  ;
 assign  bist_word_en_c1[7] =  ( bist_data_waddr_c1 == 4'd7 ) ;
 assign  bist_word_en_c1[8] = ( bist_data_waddr_c1 == 4'd8 )  ;
 assign  bist_word_en_c1[9] =  ( bist_data_waddr_c1 == 4'd9 )  ;
 assign  bist_word_en_c1[10] =  ( bist_data_waddr_c1 == 4'd10 )  ;
 assign  bist_word_en_c1[11] =  ( bist_data_waddr_c1 == 4'd11 )  ;
 assign  bist_word_en_c1[12] =  ( bist_data_waddr_c1 == 4'd12 )  ;
 assign  bist_word_en_c1[13] =  ( bist_data_waddr_c1 == 4'd13 )  ;
 assign  bist_word_en_c1[14] =  ( bist_data_waddr_c1 == 4'd14 )  ;
 assign  bist_word_en_c1[15] =  ( bist_data_waddr_c1 == 4'd15 )  ;

 assign diag_word_en_c2[0] = word_en_c2[0]  & ~arbaddr_addr22_c2 ;
 assign diag_word_en_c2[1] = word_en_c2[1]  & arbaddr_addr22_c2 ;
 assign diag_word_en_c2[2] = word_en_c2[2]  & ~arbaddr_addr22_c2 ;
 assign diag_word_en_c2[3] = word_en_c2[3]  & arbaddr_addr22_c2 ;
 assign diag_word_en_c2[4] = word_en_c2[4]  & ~arbaddr_addr22_c2 ;
 assign diag_word_en_c2[5] = word_en_c2[5]  & arbaddr_addr22_c2 ;
 assign diag_word_en_c2[6] = word_en_c2[6]  & ~arbaddr_addr22_c2 ;
 assign diag_word_en_c2[7] = word_en_c2[7]  & arbaddr_addr22_c2 ;
 assign diag_word_en_c2[8] = word_en_c2[8]  & ~arbaddr_addr22_c2 ;
 assign diag_word_en_c2[9] = word_en_c2[9]  & arbaddr_addr22_c2 ;
 assign diag_word_en_c2[10] = word_en_c2[10]  & ~arbaddr_addr22_c2 ;
 assign diag_word_en_c2[11] = word_en_c2[11]  & arbaddr_addr22_c2 ;
 assign diag_word_en_c2[12] = word_en_c2[12]  & ~arbaddr_addr22_c2 ;
 assign diag_word_en_c2[13] = word_en_c2[13]  & arbaddr_addr22_c2 ;
 assign diag_word_en_c2[14] = word_en_c2[14]  & ~arbaddr_addr22_c2 ;
 assign diag_word_en_c2[15] = word_en_c2[15]  & arbaddr_addr22_c2 ;

 mux2ds  #(16) mux_mux1_wen_c1   (.dout (mux1_wen_c1[15:0]), // bist or diagnostic wen.
                               	.in0(bist_word_en_c1[15:0]), // bist wen
				.in1(diag_word_en_c2[15:0]), // diagnostic word enable.
                               	.sel0(bist_data_enable_c1), 
				.sel1(~bist_data_enable_c1));

 assign  data_ecc_wen_c1[0] = ( scrub_addr_cnt[2:0] == 3'd0 ) ;
 assign  data_ecc_wen_c1[1] = ( scrub_addr_cnt[2:0] == 3'd0 ) ;
 assign  data_ecc_wen_c1[2] = ( scrub_addr_cnt[2:0] == 3'd1 ) ;
 assign  data_ecc_wen_c1[3] = ( scrub_addr_cnt[2:0] == 3'd1 ) ;
 assign  data_ecc_wen_c1[4] = ( scrub_addr_cnt[2:0] == 3'd2 ) ;
 assign  data_ecc_wen_c1[5] = ( scrub_addr_cnt[2:0] == 3'd2 ) ;
 assign  data_ecc_wen_c1[6] = ( scrub_addr_cnt[2:0] == 3'd3 ) ;
 assign  data_ecc_wen_c1[7] =  ( scrub_addr_cnt[2:0] == 3'd3 ) ;
 assign  data_ecc_wen_c1[8] = ( scrub_addr_cnt[2:0] == 3'd4 ) ;
 assign  data_ecc_wen_c1[9] =  ( scrub_addr_cnt[2:0] == 3'd4 ) ;
 assign  data_ecc_wen_c1[10] =  ( scrub_addr_cnt[2:0] == 3'd5 ) ;
 assign  data_ecc_wen_c1[11] =  ( scrub_addr_cnt[2:0] == 3'd5 ) ;
 assign  data_ecc_wen_c1[12] =  ( scrub_addr_cnt[2:0] == 3'd6 ) ;
 assign  data_ecc_wen_c1[13] =  ( scrub_addr_cnt[2:0] == 3'd6 ) ;
 assign  data_ecc_wen_c1[14] =  ( scrub_addr_cnt[2:0] == 3'd7 ) ;
 assign  data_ecc_wen_c1[15] =  ( scrub_addr_cnt[2:0] == 3'd7 ) ;

 mux2ds  #(16) mux_mux2_wen_c1   (.dout (mux2_wen_c1[15:0]), // bist/diagnostic or scrub wen.
                               	.in0(mux1_wen_c1[15:0]), // bist or diag wen
				.in1(data_ecc_wen_c1[15:0]), // scrub
                               	.sel0(bist_or_diag_acc_c1), // bist or diagnostic access.
				.sel1(~bist_or_diag_acc_c1));

 assign	 prev_wen_c1 = ( mux2_wen_c1 | {16{fill_vld_c3}}) ;

 dff_s   #(16)  ff_prev_wen_c1    (.din(prev_wen_c1[15:0]), .clk(rclk),
                    .q(prev_wen_c2[15:0]), .se(se), .si(), .so());


 // The delayed word en  is picked in the following cases
 // bist_data_enable_c1
 // diagnostic access c1
 // data_array_wr_active_c1
 // fill in C3

 assign	sel_prev_wen_c1 = ( bist_or_diag_acc_c1 | data_array_wr_active_c1 |
				fill_vld_c3 ) ;

 dff_s   #(1)  ff_sel_prev_wen_c2    (.din(sel_prev_wen_c1), .clk(rclk),
                    .q(sel_prev_wen_c2), .se(se), .si(), .so());

 // Critical in the generation of wenables.
 assign  dec_word_addr_c1[0] = ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd0 ) ;
 assign  dec_word_addr_c1[1] = ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd1 ) ;
 assign  dec_word_addr_c1[2] = ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd2 )  ;
 assign  dec_word_addr_c1[3] = ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd3 )  ;
 assign  dec_word_addr_c1[4] = ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd4 )  ;
 assign  dec_word_addr_c1[5] = ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd5 )  ;
 assign  dec_word_addr_c1[6] = ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd6 )  ;
 assign  dec_word_addr_c1[7] =  ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd7 ) ;
 assign  dec_word_addr_c1[8] = ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd8 )  ;
 assign  dec_word_addr_c1[9] =  ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd9 )  ;
 assign  dec_word_addr_c1[10] =  ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd10 )  ;
 assign  dec_word_addr_c1[11] =  ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd11 )  ;
 assign  dec_word_addr_c1[12] =  ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd12 )  ;
 assign  dec_word_addr_c1[13] =  ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd13 )  ;
 assign  dec_word_addr_c1[14] =  ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd14 )  ;
 assign  dec_word_addr_c1[15] =  ( {arbdp_addr5to4_c1,arbdp_addr3to2_c1} == 4'd15 )  ;

 dff_s   #(16)  ff_dec_word_addr_c2    (.din(dec_word_addr_c1[15:0]), .clk(rclk),
                    .q(dec_word_addr_c2[15:0]), .se(se), .si(), .so());

 assign	word_en_c2[0] = (dec_word_addr_c2[0]) | ( dec_word_addr_c2[1] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[1] = (dec_word_addr_c2[1]) | ( dec_word_addr_c2[0] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[2] = (dec_word_addr_c2[2]) | ( dec_word_addr_c2[3] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[3] = (dec_word_addr_c2[3]) | ( dec_word_addr_c2[2] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[4] = (dec_word_addr_c2[4]) | ( dec_word_addr_c2[5] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[5] = (dec_word_addr_c2[5]) | ( dec_word_addr_c2[4] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[6] = (dec_word_addr_c2[6]) | ( dec_word_addr_c2[7] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[7] = (dec_word_addr_c2[7]) | ( dec_word_addr_c2[6] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[8] = (dec_word_addr_c2[8]) | ( dec_word_addr_c2[9] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[9] = (dec_word_addr_c2[9]) | ( dec_word_addr_c2[8] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[10] = (dec_word_addr_c2[10]) | ( dec_word_addr_c2[11] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[11] = (dec_word_addr_c2[11]) | ( dec_word_addr_c2[10] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[12] = (dec_word_addr_c2[12]) | ( dec_word_addr_c2[13] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[13] = (dec_word_addr_c2[13]) | ( dec_word_addr_c2[12] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[14] = (dec_word_addr_c2[14]) | ( dec_word_addr_c2[15] & arbdp_dword_st_c2 ) ;
 assign	word_en_c2[15] = (dec_word_addr_c2[15]) | ( dec_word_addr_c2[14] & arbdp_dword_st_c2 ) ;
			
 // word en mux
 mux2ds #(16) mux_word_en_c2 ( .dout ( {scdata_word_en_c2[0],
					scdata_word_en_c2[1],
					scdata_word_en_c2[2],
					scdata_word_en_c2[3],
					scdata_word_en_c2[4],
					scdata_word_en_c2[5],
					scdata_word_en_c2[6],
					scdata_word_en_c2[7],
					scdata_word_en_c2[8],
					scdata_word_en_c2[9],
					scdata_word_en_c2[10],
					scdata_word_en_c2[11],
					scdata_word_en_c2[12],
					scdata_word_en_c2[13],
					scdata_word_en_c2[14],
					scdata_word_en_c2[15]}),
  	                    .in0(word_en_c2[15:0]), 
			    .in1(prev_wen_c2[15:0]),
                      	.sel0(~sel_prev_wen_c2), 
			.sel1(sel_prev_wen_c2));

 mux2ds #(16) mux_tmp_word_en_c2 ( .dout ( tmp_word_en_c2[15:0]),
  	                    .in0(word_en_c2[15:0]), 
			    .in1(prev_wen_c2[15:0]),
                      	.sel0(~sel_prev_wen_c2), 
			.sel1(sel_prev_wen_c2));





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Scrub Pipeline.
// CSR bit[7]  is used to determine if scrub mode is ON.
// If so { CSR[19:8], 7FFFF } is the scrub frequency.
//
// A Scrub is initiated by a FIll Operation after a scrub period defined above
// expires. Here's the pipeline.
// BUG: There is a problem with starting the scrub pipeline when the 
//
//	C3		
//-----------------------------
//	fill
//	op with
//	tecc=1
//
//	start
//	scrub fsm
//	cnt=0		cnt=1
//
//
// SCRUB ADDR COUNTER [6:3] = WAY<3:0> ( when way reaches 11, reset the addr counter )
// SCRUB ADDR COUNTER [2:0] = 64b address.
//--------------------------------------------------------------------------------------------------------------------
// cnt=   2	3	4	5	6	7	8	9	10	11	12	13	14	15
//--------------------------------------------------------------------------------------------------------------------
// pseudo 
// stage PX2	C1	C2	C3	C4	C5	C6	C7	C8(px2)	C1	c2	C3	C4	C5
//--------------------------------------------------------------------------------------------------------------------
// setup 	tagrd	rdout	xmit	rd1	rd2	xmit	ecc	mux	mux		xmit	wr1	wr2
// tagrd		valid   scrub			to	corr	out	with
// with scrub		bit	way			sctag		64b	c1 inst
// idx 				to						data		
//		gen		scdata								
//		way, 								perform		cnt=0 
//		rd								stecc
//		from								& gen
//		scdata								waysel
//										scdata_wr
//										& col_off
//			vbit	
//			& way	v1	v2	v3	v4	v5	v6	v7
//--------------------------------------------------------------------------------------------------------------------
// 													cnt=1	  2	
//--------------------------------------------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dff_s   #(1)  ff_tecc_c2    (.din(arbdp_tecc_c1), .clk(rclk),
                    .q(tecc_c2), .se(se), .si(), .so());


assign	scrub_fsm_reset = ~dbb_rst_l | 
			~dbginit_l | 
			( scrub_fsm_cnt[3:0] == 4'b1100) ;

assign	scrub_fsm_en =  ( (|( scrub_fsm_cnt ))  | 
			 (|(scrub_addr_cnt)) |
			 ( fill_vld_c3 & tecc_c3 ) // trigger for data scb.
			)  ;

assign	scrub_fsm_cnt_plus1  = scrub_fsm_cnt + 4'b1 ;

dffre_s   #(4)  ff_scrub_fsm_cnt  (.din(scrub_fsm_cnt_plus1[3:0]),
                 .en(scrub_fsm_en), .clk(rclk), .rst(scrub_fsm_reset),
                 .q(scrub_fsm_cnt[3:0]), .se(se), .si(), .so());


assign	scrub_addr_reset = ~dbb_rst_l | ~dbginit_l  |
		 (( scrub_addr_cnt[6:0] == 7'b1011_111 )  &
			( scrub_fsm_cnt[3:0] == 4'b1100)) ; // After scrubbing the
							// last DWORD of way 11. reset 
							// addr_cnt

assign	scrub_addr_en = ( scrub_fsm_cnt[3:0] == 4'b1100) & ~scrub_addr_reset ;

assign	scrub_addr_cnt_plus1 = scrub_addr_cnt + 7'b1 ;

dffre_s   #(7)  ff_scrub_addr_cnt  (.din(scrub_addr_cnt_plus1[6:0]),
                 .en(scrub_addr_en), .clk(rclk), .rst(scrub_addr_reset),
                 .q(scrub_addr_cnt[6:0]), .se(se), .si(), .so());


////////////////////////////////////////////////////////////
// The following signal, decc_tag_acc_en_px2 is used
// to indicate to arbctl that a tag access needs to be performed
// in the next cycle.
////////////////////////////////////////////////////////////

// ------------\/ Added the following logic for timing \/-----------

assign	decc_tag_acc_en_px1 = ( scrub_fsm_cnt[3:0] == 4'b0001 ) &
			scrub_fsm_en ;

dffre_s   #(1)  ff_decc_tag_acc_en_px2  (.din(decc_tag_acc_en_px1),
                 .en(scrub_fsm_en), .clk(rclk), .rst(scrub_fsm_reset),
                 .q(decc_tag_acc_en_px2), .se(se), .si(), .so());

// ------------\/ Added the above logic for timing \/-----------

//assign	decc_tag_acc_en_px2 = ( scrub_fsm_cnt[3:0] == 4'b0010 );

////////////////////////////////////////////////////////////
// The following signal data_ecc_active_c3 is used by arbaddr to select
// the decc idx  for tag access
////////////////////////////////////////////////////////////

assign	data_ecc_active_c3 = scrub_fsm_en ;
			

////////////////////////////////////////////////////////////
// The waysels, coloffset word_en, set etc are chosen for 
// a scrub instruction in C1.
// Hence, data_array-acc_active_c1 should be set when
// the fsm_counter = 3or 11
////////////////////////////////////////////////////////////

assign	data_array_wr_active_c1 = ( scrub_fsm_cnt[3:0] == 4'b1011 ) ; // wr

assign	data_array_acc_active_c1 = 
			( scrub_fsm_cnt[3:0] == 4'b0011 ) | // rd
			data_array_wr_active_c1 ;

		
////////////////////////////////////////////////////////////
// refer to scrub pipeline
// The following signal tagctl_decc_data_sel_c8 is used to 
// select between store data and decc scrub data.
/////////////////////////////////////////////////////////////

assign	tagctl_decc_data_sel_c8 = (scrub_fsm_cnt[3:0] == 4'b1010);

////////////////////////////////////////////////////////////
// refer to scrub pipeline
// The following signal tagctl_decc_addr3_c7 is used to 
// mux out the DWORD that is being scrubbed.
/////////////////////////////////////////////////////////////

assign	tagctl_decc_addr3_c7 = scrub_addr_cnt[0] ;

assign	scrub_addr_way = scrub_addr_cnt[6:3] ;


assign  dec_lo_scb_way[0] = ( scrub_addr_way[1:0]==2'd0 );
assign  dec_lo_scb_way[1] = ( scrub_addr_way[1:0]==2'd1 );
assign  dec_lo_scb_way[2] = ( scrub_addr_way[1:0]==2'd2 );
assign  dec_lo_scb_way[3] = ( scrub_addr_way[1:0]==2'd3 );


assign  dec_hi_scb_way[0] = ( scrub_addr_way[3:2]==2'd0 ) ;
assign  dec_hi_scb_way[1] = ( scrub_addr_way[3:2]==2'd1 ) ;
assign  dec_hi_scb_way[2] = ( scrub_addr_way[3:2]==2'd2 ) ;

assign  dec_scrub_addr_way[0] = dec_hi_scb_way[0] &
                                dec_lo_scb_way[0] ; // 0000

assign  dec_scrub_addr_way[1] = dec_hi_scb_way[0] &
                                dec_lo_scb_way[1] ; // 0001

assign  dec_scrub_addr_way[2] = dec_hi_scb_way[0] &
                                dec_lo_scb_way[2] ; // 0010

assign  dec_scrub_addr_way[3] = dec_hi_scb_way[0] &
                                dec_lo_scb_way[3] ; // 0011

assign  dec_scrub_addr_way[4] = dec_hi_scb_way[1] &
                                dec_lo_scb_way[0] ; // 0100 

assign  dec_scrub_addr_way[5] = dec_hi_scb_way[1] &
                                dec_lo_scb_way[1] ; // 0101 

assign  dec_scrub_addr_way[6] = dec_hi_scb_way[1] & 
                                dec_lo_scb_way[2] ; // 0110 

assign  dec_scrub_addr_way[7] = dec_hi_scb_way[1] &
                                dec_lo_scb_way[3] ; // 0111 

assign  dec_scrub_addr_way[8] = dec_hi_scb_way[2] &
                                dec_lo_scb_way[0] ; // 1000

assign  dec_scrub_addr_way[9] = dec_hi_scb_way[2] &
                                dec_lo_scb_way[1] ; // 1001

assign  dec_scrub_addr_way[10] = dec_hi_scb_way[2] &
                                dec_lo_scb_way[2] ; // 1010

assign  dec_scrub_addr_way[11] = dec_hi_scb_way[2] &
                                dec_lo_scb_way[3] ; // 1011


assign  scrub_way_vld_c2 = |( dec_scrub_addr_way & vuad_dp_valid_c2 ) ;

dff_s  #(1)  ff_scrub_way_vld_c3  (.din(scrub_way_vld_c2), .clk(rclk),
                   .q(scrub_way_vld_c3), .se(se), .si(), .so());
dff_s  #(1)  ff_scrub_way_vld_c4  (.din(scrub_way_vld_c3), .clk(rclk),
                   .q(scrub_way_vld_c4), .se(se), .si(), .so());
dff_s  #(1)  ff_scrub_way_vld_c5  (.din(scrub_way_vld_c4), .clk(rclk),
                   .q(scrub_way_vld_c5), .se(se), .si(), .so());
dff_s  #(1)  ff_scrub_way_vld_c6  (.din(scrub_way_vld_c5), .clk(rclk),
                   .q(scrub_way_vld_c6), .se(se), .si(), .so());
dff_s  #(1)  ff_scrub_way_vld_c7  (.din(scrub_way_vld_c6), .clk(rclk),
                   .q(scrub_way_vld_c7), .se(se), .si(), .so());

////////////////////////////////////////////////////////////
// tagctl_scrub_rd_vld_c7 indicates to deccdp that 
// any error information on data read from the data array
// should be reported only if this signal is high 
////////////////////////////////////////////////////////////

assign	tagctl_scrub_rd_vld_c7 = ( scrub_fsm_cnt[3:0] == 4'b1001 ) 
			& scrub_way_vld_c7 ;

////////////////////////////////////////////////////////////
// scrub write is disabled 
// if the valid bit of the line being scrubbed is 0, 
// OR if the read part of the scrub detected a dbit err.
// The  write operation of a line scrub happens 8 cycles after
// the read. The valid bit and error information need to be
// staged until the pseudo C1 stage of the WRite operation.
////////////////////////////////////////////////////////////
dff_s   #(1)  ff_scrub_rd_vld_c8    (.din(tagctl_scrub_rd_vld_c7), .clk(rclk),
                              .q(scrub_rd_vld_c8), .se(se), .si(), .so());

assign	scrub_wr_disable_c8 = ~scrub_rd_vld_c8 | decc_scrd_uncorr_err_c8 ;

dff_s   #(1)  ff_scrub_wr_disable_c9    (.din(scrub_wr_disable_c8), .clk(rclk),
                              .q(scrub_wr_disable_c9), .se(se), .si(), .so());



//////////////////////////////////////////////////////////////////////
// Fb data interface.
// All fbdata signals are generated in fbctl and flopped here
// before transmitting to scbuf. THe excetion is wen 
//////////////////////////////////////////////////////////////////////




assign  dram_fbd_wen_r1[0]= ( dram_sctag_chunk_id_r1[1:0] == 2'd0 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[1]= ( dram_sctag_chunk_id_r1[1:0] == 2'd0 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[2]= ( dram_sctag_chunk_id_r1[1:0] == 2'd0 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[3]= ( dram_sctag_chunk_id_r1[1:0] == 2'd0 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[4]= ( dram_sctag_chunk_id_r1[1:0] == 2'd1 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[5]= ( dram_sctag_chunk_id_r1[1:0] == 2'd1 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[6]= ( dram_sctag_chunk_id_r1[1:0] == 2'd1 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[7]= ( dram_sctag_chunk_id_r1[1:0] == 2'd1 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[8]= ( dram_sctag_chunk_id_r1[1:0] == 2'd2 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[9]= ( dram_sctag_chunk_id_r1[1:0] == 2'd2 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[10]= ( dram_sctag_chunk_id_r1[1:0] == 2'd2 ) &
				dram_sctag_data_vld_r1;
assign  dram_fbd_wen_r1[11]= ( dram_sctag_chunk_id_r1[1:0] == 2'd2 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[12]= ( dram_sctag_chunk_id_r1[1:0] == 2'd3 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[13]= ( dram_sctag_chunk_id_r1[1:0] == 2'd3 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[14]= ( dram_sctag_chunk_id_r1[1:0] == 2'd3 ) &
				dram_sctag_data_vld_r1; 
assign  dram_fbd_wen_r1[15]= ( dram_sctag_chunk_id_r1[1:0] == 2'd3 ) &
				dram_sctag_data_vld_r1; 

//
// In off mode, the following instructions are allowed to write to the
// FB
// - non partial stores/streaming stores or wr8s.
// All other instructions are forbidden from writing into the fbf.
//

assign	sel_store_wen = ~dram_sctag_data_vld_r1 & 
			 st_to_data_array_c2
                	& l2_bypass_mode_on_d1  ;

assign 	fbd_word_en_c2 = tmp_word_en_c2 & {16{tagctl_fb_hit_c2}} ;

mux2ds #(16) mux_fb_word_en_c2 ( .dout ( sctag_scbuf_fbwr_wen_r1[15:0]),
             	.in0(dram_fbd_wen_r1[15:0]), // dram data wen logic above
		.in1(fbd_word_en_c2[15:0]), // from cache wen logic only asserted when
					    // Fb hit is high.
                .sel0(~sel_store_wen),  // dram data transfer active
		.sel1(sel_store_wen));

dff_s   #(16)  ff_scbuf_fbwr_wen_r2    (.din(sctag_scbuf_fbwr_wen_r1[15:0]), 
		.clk(rclk),
                .q(scbuf_fbwr_wen_r2[15:0]), .se(se), .si(), .so());


/////////////////////////////////////////////////
// In L2 off mode, the following signal is
// used to select store data over data from DRAM
/////////////////////////////////////////////////

dff_s   #(1)  ff_data_vld_r3    (.din(dram_sctag_data_vld_r1), .clk(rclk),
                   .q(dram_sctag_data_vld_r2), .se(se), .si(), .so());

assign	scbuf_fbd_stdatasel_c3 = ~dram_sctag_data_vld_r2 ;

//////////////////////////////////////////////////////////////////////////
// Signals going to oqctl.
// Imiss return is sent for an imiss hit.
// 
//
//////////////////////////////////////////////////////////////////////////


dff_s   #(1)  ff_imiss_vld_c3    (.din(arbctl_imiss_vld_c2), .clk(rclk),
                   .q(imiss_vld_c3), .se(se), .si(), .so());

assign	imiss_hit_c3 = imiss_vld_c3 & tagctl_hit_l2orfb_c3;

dff_s   #(1)  ff_imiss_hit_c4    (.din(imiss_hit_c3), .clk(rclk),
                   .q(imiss_hit_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_imiss_hit_c5    (.din(imiss_hit_c4), .clk(rclk),
                   .q(imiss_hit_c5), .se(se), .si(), .so());

assign	tagctl_imiss_hit_c5 = imiss_hit_c5 ;


/////////////////////////
// Ld return packet is sent for the following cases:
// - ld hit,
// - swap hit first pass.
// - cas1 hit 
/////////////////////////

dff_s   #(1)  ff_swap_inst_c3    (.din(decdp_swap_inst_c2), .clk(rclk),
                   .q(swap_inst_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_pst_no_ctrue_c3    (.din(arbdp_tagctl_pst_no_ctrue_c2), .clk(rclk),
                   .q(pst_no_ctrue_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_cas1_inst_c3    (.din(decdp_cas1_inst_c2), .clk(rclk),
                   .q(cas1_inst_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_ld_inst_c3    (.din(decdp_ld_inst_c2), .clk(rclk),
                   .q(ld_inst_c3), .se(se), .si(), .so());


assign	ld_hit_c3 = ( ( swap_inst_c3 & pst_no_ctrue_c3 ) |
		     cas1_inst_c3  |
		ld_inst_c3 ) & tagctl_hit_l2orfb_c3;
			

dff_s   #(1)  ff_ld_hit_c4    (.din(ld_hit_c3), .clk(rclk),
                   .q(ld_hit_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_ld_hit_c5    (.din(ld_hit_c4), .clk(rclk),
                   .q(ld_hit_c5), .se(se), .si(), .so());


assign	tagctl_ld_hit_c5 = ld_hit_c5 ;

/////////////////////////
// St ack is sent for the following cases:
// - cas2 from mb hitting the $.
// - swap 2nd pass hitting the $
// - non-dep store.
// - inval instruction
// - diagnostic write delayed st ack.
// -csr write from miss buffer delayed st ack
/////////////////////////

dff_s   #(1)  ff_inst_vld_c3    (.din(arbctl_tagctl_inst_vld_c2), .clk(rclk),
                   .q(inst_vld_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_diag_c3    (.din(arbctl_inst_diag_c2), .clk(rclk),
                   .q(inst_diag_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_mb_c3    (.din(arbdp_inst_mb_c2), .clk(rclk),
                   .q(inst_mb_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_mb_c4    (.din(inst_mb_c3), .clk(rclk),
                   .q(inst_mb_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_mb_c5    (.din(inst_mb_c4), .clk(rclk),
                   .q(inst_mb_c5), .se(se), .si(), .so());


assign	tagctl_inst_mb_c5 = inst_mb_c5 ;


dff_s   #(1)  ff_mbctl_hit_unqual_c3    (.din(mbctl_tagctl_hit_unqual_c2), .clk(rclk),
                   .q(mbctl_hit_unqual_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_dep_c3    (.din(arbdp_inst_dep_c2), .clk(rclk),
                   .q(inst_dep_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_store_inst_c3    (.din(decdp_st_inst_c2), .clk(rclk),
                   .q(store_inst_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_store_inst_c4    (.din(store_inst_c3), .clk(rclk),
                   .q(store_inst_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_store_inst_c5    (.din(store_inst_c4), .clk(rclk),
                   .q(store_inst_c5), .se(se), .si(), .so());


assign	tagctl_store_inst_c5  = store_inst_c5 ; // to oq_dctl.

dff_s   #(1)  ff_cas2_from_mb_c3    (.din(decdp_cas2_from_mb_c2), .clk(rclk), 
			.q(cas2_from_mb_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_pst_with_ctrue_c3    (.din(pst_with_ctrue_c2), .clk(rclk), 
			.q(pst_with_ctrue_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_inval_inst_c3    (.din(arbctl_inval_inst_c2), .clk(rclk),
                   .q(inval_inst_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_strstore_c3    (.din (decdp_strst_inst_c2),.clk(rclk),
                   .q(strstore_inst_c3), .se(se), .si(), .so());


dff_s   #(1)  ff_diag_rd_en_c3    (.din(arbctl_csr_rd_en_c3), .clk(rclk),
                   .q(csr_rd_en_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_diag_wr_en_c3    (.din(arbctl_csr_wr_en_c3), .clk(rclk),
                   .q(csr_wr_en_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_diag_complete_c4    (.din(arbctl_diag_complete_c3), .clk(rclk),
                   .q(diag_complete_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_tecc_c3    (.din(tecc_c2), .clk(rclk),
                    .q(tecc_c3), .se(se), .si(), .so());

// A STore instruction will send an  ack if it is
// - not issued from the MB and hits the $ and not the miss buffer
// - not issued from the mb and misses the $ AND does not encounter 
// a parity error AND misses the miss buffer.
// - issued from the MB with DEP=1 and hits the $ 
// - issued from the MB with DEP=1 nd misses the $ AND does not encounter 
// a parity error.
// - not a tag scrub instruction.

dff_s   #(1)  ff_tagctl_hit_unqual_c3    (.din(tagctl_hit_unqual_c2), .clk(rclk),
                      .q(tagctl_hit_unqual_c3), .se(se), .si(), .so());

assign	ack_c3 = inst_vld_c3 & 	
		~tecc_c3 &
		~inst_diag_c3 & 
		( ( tagctl_hit_l2orfb_c3 | ~(tagdp_tagctl_par_err_c3 & ~tagctl_hit_unqual_c3) ) &
		  (( ~inst_mb_c3 & ~mbctl_hit_unqual_c3) | inst_dep_c3 ) 
		) ;

	//( ( ~inst_mb_c3 & ~mbctl_hit_unqual_c3 ) | 
		//(( mbctl_gate_off_par_err_c3 |  // gate off par err for hits
		//~tagdp_tagctl_par_err_c3 )  
		//& inst_dep_c3 )
	//);

///////////////////////
// The following signal is used in oqctl to 
// pick between the dir req vec and dec req vec.
///////////////////////

//-----\/ FIX for bug#4619 ------ \/
// added a ~mbctl_hit_unqual_c3 qualification to
// a inval instruction.
//-----\/ FIX for bug#4619 ------ \/
assign	st_ack_c3 = ( store_inst_c3 & ack_c3 )  | // plain store ack
		( ( cas2_from_mb_c3 |  // cas2 hit
		( pst_with_ctrue_c3 & swap_inst_c3 ) )  // swap pass2 hit
		& tagctl_hit_l2orfb_c3 ) | 
		( inval_inst_c3 & inst_vld_c3 & ~mbctl_hit_unqual_c3 )   ; // invalidate instr

dff_s   #(1)  ff_st_ack_c4    (.din(st_ack_c3), .clk(rclk),
                   .q(st_ack_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_st_ack_c5    (.din(st_ack_c4), .clk(rclk),
                   .q(st_ack_c5), .se(se), .si(), .so());

assign	tagctl_st_ack_c5 = st_ack_c5 ;


dff_s   #(1)  ff_tagctl_hit_c4    (.din(tagctl_hit_c3), .clk(rclk),
                      .q(tagctl_hit_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_tagctl_hit_c5    (.din(tagctl_hit_c4), .clk(rclk),
                      .q(tagctl_hit_c5), .se(se), .si(), .so());




///////////////////////
// the following signal is used in oqctl to
// generate the correct request type.
///////////////////////

assign	st_req_c3 = st_ack_c3 | csr_wr_en_c4 |
			( store_inst_c4 & diag_complete_c4 ) ;

dff_s   #(1)  ff_st_req_c4    (.din(st_req_c3), .clk(rclk),
                   .q(st_req_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_st_req_c5    (.din(st_req_c4), .clk(rclk),
                   .q(st_req_c5), .se(se), .si(), .so());


assign	tagctl_st_req_c5 = st_req_c5 ;

///////////////////////
// streaming store ack
///////////////////////

assign	strst_ack_c3 =  strstore_inst_c3 & ack_c3 ;

dff_s   #(1)  ff_strst_ack_c4    (.din(strst_ack_c3), .clk(rclk),
                   .q(strst_ack_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_strst_ack_c5    (.din(strst_ack_c4), .clk(rclk),
                   .q(strst_ack_c5), .se(se), .si(), .so());

assign	tagctl_strst_ack_c5 = strst_ack_c5 ;

//////////////////////
// rmo store ack
/////////////////////

assign	rmo_st_ack_c3 = decdp_rmo_st_c3 & ack_c3 ;

dff_s   #(1)  ff_rmo_st_ack_c4    (.din(rmo_st_ack_c3), .clk(rclk),
                   .q(rmo_st_ack_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_rmo_st_ack_c5    (.din(rmo_st_ack_c4), .clk(rclk),
                   .q(rmo_st_ack_c5), .se(se), .si(), .so());

assign	tagctl_rmo_st_ack_c5 =  rmo_st_ack_c5;



///////////////////////
// diag or csr complete( non memory )
///////////////////////

assign	nonmem_comp_c4 = diag_complete_c4 |
				  csr_wr_en_c4 |
				csr_rd_en_c4 ;

dff_s   #(1)  ff_nonmem_comp_c5    (.din(nonmem_comp_c4), .clk(rclk),
                   .q(nonmem_comp_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_nonmem_comp_c6    (.din(nonmem_comp_c5), .clk(rclk),
                   .q(nonmem_comp_c6), .se(se), .si(), .so());

assign	tagctl_nonmem_comp_c6 = nonmem_comp_c6 ;

////////////////////////////////////////////////////
//
// correctable and non correctable err ack
//
// - When a PST instruction makes its second pass
// an error indication is sent to spcX Ty.
//
// (Atomics are not included in this because
// the load part of the atomic sends an error similar
// to loads.)
//
// - A fill will also send an error indication
//   to SPc0 T0 if the uncorr/err bit is set
//   in fbctl
// 
////////////////////////////////////////////////////

// POST_2.0 additions.
// tagcl_?err_ack is asserted to 
// send an error packet to a sparc
// for partial stores.
//
// Wr8s need to be excluded from this
// since they differ from regular stores
// in the following aspect. 
// regular stores send an ack/inval packet
// when they make their first non-dependent
// pass down the pipe.
// wr8s send an invalidate(eviction) packet 
// when they make their final pass down the pipe
// Hence the error indication needs to be sent
// along with a fill instead of being sent with
// the 2nd pass of a store.




dff_s   #(1)  ff_st_with_ctrue_c3    (.din(decdp_st_with_ctrue_c2), .clk(rclk),
                   .q(st_with_ctrue_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_mbctl_uerr_c3    (.din(mbctl_uncorr_err_c2), .clk(rclk),
                   .q(mbctl_uerr_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_mbctl_cerr_c3    (.din(mbctl_corr_err_c2), .clk(rclk),
                   .q(mbctl_cerr_c3), .se(se), .si(), .so());


// tagctl_hit_c3 is used to qualify st_with_ctrue_c3.
// st_with_ctrue_c3 is qualfied everywhere else.
// Bug # 3528:	6/26/2003
// The qualification with tagctl_hit_c3 instead of tagctl_hit_l2orfb_c3 assumes that
// the $ is turned ON. THis causes ?err_ack_tmp_c3 to be deasserted for psts in OFF
// mode. This has been changed to tagctl_hit_l2orfb_c3 to  solve the problem.

assign	uerr_ack_tmp_c3 =  ( mbctl_uerr_c3 & st_with_ctrue_c3  & tagctl_hit_l2orfb_c3 &
				inst_vld_c3 ) | fbctl_dis_uerr_c3  ;

dff_s   #(1)  ff_uerr_ack_tmp_c4    (.din(uerr_ack_tmp_c3), .clk(rclk),
                   .q(uerr_ack_tmp_c4), .se(se), .si(), .so());

assign	uerr_ack_c3 = uerr_ack_tmp_c3 & ~wr8_inst_c3 ;

dff_s   #(1)  ff_uerr_ack_c4    (.din(uerr_ack_c3), .clk(rclk),
                   .q(uerr_ack_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_uerr_ack_c5    (.din(uerr_ack_c4), .clk(rclk),
                   .q(uerr_ack_c5), .se(se), .si(), .so());

// Reporting of errors to the sparc depends on the error_ceen 
// and error_nceen bits. If these bits are turned off, the spc
// does not reveive any errors from the L2.
// There is one caveat. The error that causes tagctl_uerr_ack_c5
// or tagctl_cerr_ack_c5 to go HIGH may have occurred before 
// or after the changing of error_Ceen and error_nceen bits.



dff_s   #(1)    ff_error_ceen_d1
              (.q   (error_ceen_d1), .din (error_ceen),
               .clk (rclk), .se(se), .si  (), .so  ()) ;

dff_s   #(1)    ff_error_nceen_d1
              (.q   (error_nceen_d1), .din (error_nceen), .clk (rclk),
               .se(se), .si  (), .so  ()) ;


assign	tagctl_uerr_ack_c5 = uerr_ack_c5  & error_nceen_d1 ;

// tagctl_hit_c3 is used to qualify st_with_ctrue_c3.
// st_with_ctrue_c3 is qualfied everywhere else.
// Bug # 3528:	6/26/2003
// The qualification with tagctl_hit_c3 instead of tagctl_hit_l2orfb_c3 assumes that
// the $ is turned ON. THis causes ?err_ack_tmp_c3 to be deasserted for psts in OFF
// mode. This has been changed to tagctl_hit_l2orfb_c3 to  solve the problem.
assign	cerr_ack_tmp_c3 =   ( mbctl_cerr_c3 & st_with_ctrue_c3  & tagctl_hit_l2orfb_c3 &
				inst_vld_c3 ) | fbctl_dis_cerr_c3 ;

dff_s   #(1)  ff_cerr_ack_tmp_c4    (.din(cerr_ack_tmp_c3), .clk(rclk),
                   .q(cerr_ack_tmp_c4), .se(se), .si(), .so());



assign	cerr_ack_c3 = cerr_ack_tmp_c3 & ~wr8_inst_c3 ;

dff_s   #(1)  ff_cerr_ack_c4    (.din(cerr_ack_c3), .clk(rclk),
                   .q(cerr_ack_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_cerr_ack_c5    (.din(cerr_ack_c4), .clk(rclk),
                   .q(cerr_ack_c5), .se(se), .si(), .so());

assign	tagctl_cerr_ack_c5 = cerr_ack_c5 & error_ceen_d1 ;

//////////////////////
//
// interrupt acknowledgement
//
//////////////////////


dff_s   #(1)  ff_inst_int_c3    (.din(decdp_inst_int_c2), .clk(rclk),
                   .q(inst_int_c3), .se(se), .si(), .so());

assign	int_ack_c3 = inst_int_c3 & inst_vld_c3 ;

dff_s   #(1)  ff_int_ack_c4    (.din(int_ack_c3), .clk(rclk),
                   .q(int_ack_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_int_ack_c5    (.din(int_ack_c4), .clk(rclk),
                   .q(int_ack_c5), .se(se), .si(), .so());

assign	tagctl_int_ack_c5 = int_ack_c5 ;

///////////////////////
//
// fwd req return :
// 1. A diag fwd req will
// send a delayed(1cyc) reponse.
// 2. A non-diag fwd req will send its response
//    similar to any other request in C8	
// 
///////////////////////




dff_s   #(1)  ff_fwd_req_c3    (.din(decdp_fwd_req_c2), .clk(rclk),
                   .q(fwd_req_c3), .se(se), .si(), .so());

assign	fwd_req_vld_diag_c3 = fwd_req_c3 & 
			inst_vld_c3 &
			inst_diag_c3 ;

assign	fwd_req_vld_diagn_c3 = fwd_req_c3 &
                        inst_vld_c3 &
                        ~inst_diag_c3 ;

dff_s   #(1)  ff_fwd_req_vld_diag_c4    (.din(fwd_req_vld_diag_c3), .clk(rclk),
                   .q(fwd_req_vld_diag_c4), .se(se), .si(), .so());

assign	fwd_req_ret_c3 = fwd_req_vld_diag_c4 | fwd_req_vld_diagn_c3;


dff_s   #(1)  ff_fwd_req_ret_c4    (.din(fwd_req_ret_c3), .clk(rclk),
                   .q(fwd_req_ret_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_fwd_req_ret_c5    (.din(fwd_req_ret_c4), .clk(rclk),
                   .q(fwd_req_ret_c5), .se(se), .si(), .so());

assign	tagctl_fwd_req_ret_c5 = fwd_req_ret_c5 ;


// FWD req acks were earlier sent to cpu#0.
// Now, the ack is sent to the cpu that forwards the IOB request.

// the following signal is high only for non-diag reads
assign	fwd_req_ld_c3 = fwd_req_vld_diagn_c3  & ld_inst_c3 ;

dff_s   #(1)  ff_fwd_req_ld_c4    (.din(fwd_req_ld_c3), .clk(rclk),
                   .q(fwd_req_ld_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_fwd_req_ld_c5    (.din(fwd_req_ld_c4), .clk(rclk),
                   .q(fwd_req_ld_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_fwd_req_ld_c6    (.din(fwd_req_ld_c5), .clk(rclk),
                   .q(fwd_req_ld_c6), .se(se), .si(), .so());

assign	tagctl_fwd_req_ld_c6 = fwd_req_ld_c6 ;




/////////////////////////////////////////////////////////////
//
// indicates that the rdma register
// is in use. This register has the following set
// reset conditions.
//
// Set in the C3 cycle of
// - WR8 and ~no_Ctrue hitting the $.
// - Wr64 hitting the $ 
//	or missing the ($ and FB and MB and WB and rdma WB)
// - ld64 hitting the $ or Fb.
//
// Reset the rdma reg valid under the following conditions.
// - For a Ld64, rdma reg valid is deasserted when the counter
//   reaches 17.
// _ For a store the rdma reg valid is deasserted when the 
//   OQ is able to make the invalidate request to the primary 
//   caches.
//
//
// ld rdma reg vld.
//-----------------------------------------------------------------------------------
// C3		c4	c5	c6	c7.... C14..   	C16	c18 	c19	c20
// start	
// count_c3	count=1						count=15			
//			
//-----------------------------------------------------------------------------------
//
//reg_vld=1						allow
//							arb sel	rv_c2_p=0
//							in next 
//							cyc, cnt=13
//
//						allow
//						mb pick.	
//						in next cyc
//						count=11
//-----------------------------------------------------------------------------------
//
//OPeration B								C2
//
//-----------------------------------------------------------------------------------
// => reg_vld_px2_p = 0, when count=13. = C16
// => reg_vld_px0_p = 0 when count = 11 = C14
//
// Since the occupation latency of the rdma interface for stores
// is not fixed, the counter is reset and rv_c2_p, rv_px2_p and rv_px0_p
// go low in the same cycle.
//
// *** rdma_reg_vld is a C4 flop whose results are consumed by a C2 instruction.
// However, this works fine because any rdma instruction causes a 1 cycle
// bubble in the pipe.
// 
// *** a RD64 response can immediately be followed by a write response
//	since the number of cycles that a read occupies the interface
//	is static(17 cycles). However, a write response cannot be immediately
//	followed by another response for atleast 7 cycles.
/////////////////////////////////////////////////////////////


dff_s   #(1)  ff_ld64_inst_c3    (.din(ld64_inst_c2), .clk(rclk), 
		.q(ld64_inst_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_wr64_inst_c3    (.din(decdp_wr64_inst_c2), .clk(rclk), 
		.q(wr64_inst_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_wr8_inst_c3    (.din(decdp_wr8_inst_c2), .clk(rclk), 
		.q(wr8_inst_c3), .se(se), .si(), .so());

//dff   #(1)  ff_arbdp_tagctl_pst_no_ctrue_c2    (.din(arbdp_tagctl_pst_no_ctrue_c2), .clk(rclk), 
//		.q(pst_no_ctrue_c3), .se(se), .si(), .so());

//////////
// hit completion for
// all types of rdma instructions
// HIT is only asserted if rdma_reg_vld=0
//////////
assign	rd64_complete_c3 = 	( ld64_inst_c3 & tagctl_hit_l2orfb_c3 );
assign	wr64_hit_complete_c3 =   ( wr64_inst_c3 & tagctl_hit_l2orfb_c3 ) ;
assign	wr8_complete_c3 = ( wr8_inst_c3 & ~pst_no_ctrue_c3 &
				tagctl_hit_l2orfb_c3 ) ;

//////////////////////////////////////
// select inval vector
// to oqctl for selecting 
// the results of the directory CAM
// for generating the request vector
// and invalidation packet.
//////////////////////////////////////


assign sel_rdma_inval_vec_c3 = ( wr8_inst_c3 | wr64_inst_c3 ) &
                                tagctl_hit_l2orfb_c3;

dff_s   #(1)  ff_sel_rdma_inval_vec_c4  (.din(sel_rdma_inval_vec_c3), .clk(rclk),
                .q(sel_rdma_inval_vec_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_sel_rdma_inval_vec_c5  (.din(sel_rdma_inval_vec_c4), .clk(rclk),
                .q(sel_rdma_inval_vec_c5), .se(se), .si(), .so());


//////////
// tagctl_rdma_ev_en_c4 is used to
// set dram_req in sctag_rdmatctl
/////////


// 10/3/2003 : tagdp_tagctl_par_err_c3 qualification is 
// needed for every expression that has mbctl_wr64_miss_comp_c3
// THis is because mbctl_wr64_miss_comp_c3 is now not qualified
// with tagctl_mbctl_par_err_c3.


assign	tagctl_rdma_ev_en_c3 = ( mbctl_wr64_miss_comp_c3 & ~tagdp_tagctl_par_err_c3) |
				wr64_hit_complete_c3  ;

dff_s   #(1)  ff_tagctl_rdma_ev_en_c3    (.din(tagctl_rdma_ev_en_c3), .clk(rclk), 
		.q(tagctl_rdma_ev_en_c4), .se(se), .si(), .so());

assign	tagctl_rdma_wr_comp_c3 =  (mbctl_wr64_miss_comp_c3  & ~tagdp_tagctl_par_err_c3 ) |
                                wr8_complete_c3 |
                                wr64_hit_complete_c3 ;

assign	set_rdma_reg_vld_c3 = ( rd64_complete_c3  | 
				tagctl_rdma_wr_comp_c3 ) ;


assign	reset_rdma_reg_vld = ( &(rdma_cnt) |  // reset for lds
			oqctl_st_complete_c7 ) ; // reset for stores.

assign	rdma_reg_vld_in = ( rdma_reg_vld  | set_rdma_reg_vld_c3 ) &
				~reset_rdma_reg_vld ;

dffrl_s   #(1)  ff_rdma_reg_vld    (.din(rdma_reg_vld_in), .clk(rclk), 
			.rst_l(dbb_rst_l),
			.q(rdma_reg_vld), .se(se), .si(), .so());

dff_s   #(1)  ff_tagctl_rdma_wr_comp_c4    (.din(tagctl_rdma_wr_comp_c3), .clk(rclk), 
		.q(tagctl_rdma_wr_comp_c4), .se(se), .si(), .so());

//////////
// tagctl_rdma_reg_vld_c2 is consumed by
// a C2 instruction.
//////////
dffrl_s   #(1)  ff_mbctl_rdma_reg_vld_c2    (.din(rdma_reg_vld_in), .clk(rclk), 
			.rst_l(dbb_rst_l),
			.q(mbctl_rdma_reg_vld_c2), .se(se), .si(), .so());


//////////////////////////
//
//tagctl_rdma_vld_px0_p:
//
// the following signal is high from the C4 cycle of an 
// instruction setting rdma_reg_vld and will be reset
// when the rdma rd counter is 11 or when oqctl_st_complete_c7
// is high
//
// It is used in mbctl to permit an L2 pick in the next
// cycle for an RDMA instruction. Pipeline is as follows
//--------------------------------------------------------------------------------
// cnt11		12	13	14	15	16	17
//-------------------------------------------------------------------------------
//							rdma_reg_vld==0
// reset
// rdma_vld_px0_p	pre	pick	read	issue	C1	C2
//			cond		mbuffer	PX2
//			L2 rdy
//			in mbctl
//--------------------------------------------------------------------------------

// Introduced a  1 cycle latency in the reintroduction of
// rdma instructions after the setting of rdma_reg_vld.
// This is to make sure that the rdma rd address is kept
// around until an error on the last packet is reported.
//		
//////////////////////////

assign	reset_rdma_vld_px0_p_in = (rdma_cnt == 4'd11 ) 
				|  oqctl_st_complete_c7 ;

assign	rdma_vld_px0_p_in = ( set_rdma_reg_vld_c3 | rdma_vld_px0_p )
				& ~reset_rdma_vld_px0_p_in ;

dffrl_s   #(1)  ff_rdma_vld_px0_p    (.din(rdma_vld_px0_p_in), .clk(rclk), 
		.rst_l(dbb_rst_l),
		.q(rdma_vld_px0_p), .se(se), .si(), .so());

assign tagctl_rdma_vld_px0_p = rdma_vld_px0_p ;

//////////////////////////
//
//tagctl_rdma_vld_px1:
//
// the following signal is high from the C4 cycle of an
// instruction setting rdma_reg_vld and will be reset
// when the rdma rd counter is 13 or when oqctl_st_complete_c7
// is high
//
//--------------------------------------------------------------------------------
// cnt13		14		15	16	17
//-------------------------------------------------------------------------------
//						rdma_reg_vld==0
// reset
// rdma_vld_px1		allow		issue
//			snp		snp	C1	C2
//			selection	PX2
//			in arbctl
//--------------------------------------------------------------------------------
// It is used in arbctl to permit an RDMA instruction
// to be picked.
//
// Introduced a  1 cycle latency in the reintroduction of
// rdma instructions after the setting of rdma_reg_vld.
// This is to make sure that the rdma rd address is kept
// around until an error on the last packet is reported.
//
//////////////////////////


assign  reset_rdma_vld_px1_in = (rdma_cnt == 4'd12 )
                                |  oqctl_st_complete_c7 ;

assign  rdma_vld_px1_in = ( set_rdma_reg_vld_c3 | rdma_vld_px1 )
                                & ~reset_rdma_vld_px1_in ;

dffrl_s   #(1)  ff_rdma_vld_px1    (.din(rdma_vld_px1_in), .clk(rclk),
                .rst_l(dbb_rst_l),
                .q(rdma_vld_px1), .se(se), .si(), .so());

assign tagctl_rdma_vld_px1 = rdma_vld_px1 ;

////////////////////////////////////////////////////////////////////////
// Write the CTAG into the CTAG register in scbuf
// if an instruction completes.
////////////////////////////////////////////////////////////////////////

dff_s   #(1)  ff_set_rdma_reg_vld_c4    (.din(set_rdma_reg_vld_c3), .clk(rclk), 
		.q(set_rdma_reg_vld_c4), .se(se), .si(), .so());

assign	tagctl_set_rdma_reg_vld_c4 = set_rdma_reg_vld_c4 ;

////////////////////////////////////////////////////////////////////////
//
// request to jbi:
// the above signal may or may not be synchronous with the setting
// of rdma_reg_vld. 
// - For loads , this signal is sent in C7, 
// - for store  misses this is a C8 signal. 
// - For stores that hit any L1$, this
// signal is transmitted only after all L1 $ invalidate packets are
// queued up in the CPX.
//
// The following FSM is used to perform the above function.
//	
//--------------------------------------------------------------------------------
// 	STATES		IDLE		ST_REQ_ST		LD_REQ_ST
//--------------------------------------------------------------------------------
//	IDLE		rst or		set rdma_reg	set rdma reg
//			~rdma_reg	& WR8 or WR64	and LD64
//--------------------------------------------------------------------------------
//	ST_REQ_ST	oqctl_st_	~oqctl_st_	-
//			complete_c7	complete_c7
//--------------------------------------------------------------------------------
//	LD_REQ_ST	rdmardcount	-		rdmardcount!=15
//			==15		
//--------------------------------------------------------------------------------
//
//	req_en_c7 = 1  if LD_REQ_ST & rdmardcount=4;
//	req_en_c7 = 1  if ST_REQ_ST & oqctl_st_complete_c7;
//
// Note: Since the counter is a C4 flop whose results are consumed by
//	 a C2 instruction, there is no transition between ST_REQ_ST & LD_REQ_ST.
//	 After, IDLE state is reached, the FSM remains in that state for
//	 atleast two more cycles.
//
//	***rdma_reg_vld above is nothing but an OR of ST_REQ_ST  and LD_REQ_ST states.
//
////////////////////////////////////////////////////////////////////////

assign	tagctl_jbi_req_state_in[`IDLE] = 	((tagctl_jbi_req_state[`ST_REQ_ST] 
					& oqctl_st_complete_c7) | // STORE DONE
					( tagctl_jbi_req_state[`LD_REQ_ST] 
					& (&(rdma_cnt)) ) |	// LOAD DONE
				      	tagctl_jbi_req_state[`IDLE] )  &
					~set_rdma_reg_vld_c3 ;

assign	idle_state_in_l = ~tagctl_jbi_req_state_in[`IDLE] ;

dffrl_s   #(1)  ff_tagctl_jbi_req_state_0    (.din(idle_state_in_l), .clk(rclk), 
		.rst_l(dbb_rst_l),
		.q(idle_state_l), .se(se), .si(), .so());

assign	tagctl_jbi_req_state[`IDLE] = ~idle_state_l ; 


assign	tagctl_jbi_req_state_in[`ST_REQ_ST] = ((tagctl_jbi_req_state[`IDLE] &
					set_rdma_reg_vld_c3 & ~ld64_inst_c3 ) | // NON LD REQ
					tagctl_jbi_req_state[`ST_REQ_ST]) &
					~oqctl_st_complete_c7;	// not ST_DONE
						
						
assign	tagctl_jbi_req_state_in[`LD_REQ_ST] = ((tagctl_jbi_req_state[`IDLE] &
					set_rdma_reg_vld_c3 & ld64_inst_c3 ) | // LD REQ
					tagctl_jbi_req_state[`LD_REQ_ST]) &
					~(&(rdma_cnt));	// LD_DONE
						

dffrl_s   #(2)  ff_tagctl_jbi_req_state    
		(.din(tagctl_jbi_req_state_in[`LD_REQ_ST:`ST_REQ_ST]), .clk(rclk), 
		.rst_l(dbb_rst_l),
		.q(tagctl_jbi_req_state[`LD_REQ_ST:`ST_REQ_ST]), 
		.se(se), .si(), .so());


assign	tagctl_jbi_req_en_c6 = ( tagctl_jbi_req_state[`LD_REQ_ST] &
				( rdma_cnt == 4'd3 ) ) |
				( tagctl_jbi_req_state[`ST_REQ_ST] &
					oqctl_st_complete_c7 ) ;





////////////////////////////////////
//
// rdma rd counter
// trigger the count
// in C3, and in C18
// the counter is reset
//
// The rdmard counter is a C4 flop.
//
/////////////////////////////////////

assign inc_rdma_cnt_c3 =  |(rdma_cnt) | rd64_complete_c3 ;

dffrl_s   #(1)  ff_inc_rdma_cnt_c4    (.din(inc_rdma_cnt_c3), .clk(rclk), 
		.rst_l(dbb_rst_l),
		.q(inc_rdma_cnt_c4), .se(se), .si(), .so());

assign	tagctl_inc_rdma_cnt_c4 = inc_rdma_cnt_c4 ;

assign	rdma_cnt_plus1 = rdma_cnt +4'b1 ;

assign	rdma_cnt_reset = ~dbb_rst_l ;

dffre_s   #(4)  ff_rdmard_cnt  (.din(rdma_cnt_plus1[3:0]),
                 .en(inc_rdma_cnt_c3), .clk(rclk), .rst(rdma_cnt_reset),
                 .q(rdma_cnt[3:0]), .se(se), .si(), .so());




////////////////////////////////////////////
// rdma rd pipeline For holding error state
// and address.
//
//
//c5: 	$ read cyc1
//c6: 	$ read cyc2
//c7: 	 xmit inside scdata 
//c8: 	 xmit from scdata to scbuf 
//c9: 	 mux data
//c10:	 perform ECC.
//c11:	 xmit data and xmit errors to sctag
//   :   HOLD the C11 address 
//       and C11 errors in fbctl.
//c12:	 flop errors in sctag.
//
//
// The hold signal in C11 is generated here.
//
////////////////////////////////////////////

dff_s   #(1)  ff_rd64_complete_c4    (.din(rd64_complete_c3), .clk(rclk), 
		.q(rd64_complete_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_rd64_complete_c5    (.din(rd64_complete_c4), .clk(rclk), 
		.q(rd64_complete_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_rd64_complete_c6    (.din(rd64_complete_c5), .clk(rclk), 
		.q(rd64_complete_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_rd64_complete_c7    (.din(rd64_complete_c6), .clk(rclk), 
		.q(rd64_complete_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_rd64_complete_c8    (.din(rd64_complete_c7), .clk(rclk), 
		.q(rd64_complete_c8), .se(se), .si(), .so());

dff_s   #(1)  ff_rd64_complete_c9    (.din(rd64_complete_c8), .clk(rclk), 
		.q(rd64_complete_c9), .se(se), .si(), .so());

dff_s   #(1)  ff_rd64_complete_c10    (.din(rd64_complete_c9), .clk(rclk), 
		.q(rd64_complete_c10), .se(se), .si(), .so());

dff_s   #(1)  ff_rd64_complete_c11    (.din(rd64_complete_c10), .clk(rclk), 
		.q(rd64_complete_c11), .se(se), .si(), .so());

assign	tagctl_rd64_complete_c11 = rd64_complete_c11 ;





endmodule






