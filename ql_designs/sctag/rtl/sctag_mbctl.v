// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_mbctl.v
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
`include "iop.h"
`include "sctag.h"


////////////////////////////////////////////////////////////////////////
// Local header file includes / local defines
// Update on 3/10/2003: Added a gate_off_par_err_c2 signal to gate off
// 			par error insertion when an instruction actually
//		 	hits the $ or FB. However if an instruction is inserted
//			due to another reason, then tagdp_par_err_c2 is used
//			for all other purposes.
////////////////////////////////////////////////////////////////////////

module sctag_mbctl( /*AUTOARG*/
   // Outputs
   so, mbctl_arbctl_cnt12_px2_prev, mbctl_arbctl_snp_cnt8_px1, 
   mbctl_arbctl_vld_px1, mbctl_nondep_fbhit_c3, mbctl_hit_c3, 
   mbctl_arbctl_hit_c3, mbctl_arbdp_ctrue_px2, mbctl_arb_l2rd_en, 
   mbctl_arb_dramrd_en, mbctl_tagctl_hit_unqual_c2, 
   mbctl_corr_err_c2, mbctl_uncorr_err_c2, mbctl_wr64_miss_comp_c3, 
   mbctl_wbctl_mbid_c4, mbf_insert_mbid_c4, mbf_insert_c4, 
   mbctl_hit_c4, mbf_delete_c4, mbctl_fbctl_next_vld_c4, 
   mbctl_fbctl_next_link_c4, mbctl_fbctl_dram_pick, mbctl_fbctl_fbid, 
   mbctl_fbctl_way, mbctl_fbctl_way_fbid_vld, mbtag_wr_en_c2, 
   mb_write_wl, mbctl_buf_rd_en, mb_read_wl, mbctl_dep_c8, 
   mb_data_write_wl, mbctl_evict_c8, mbctl_tecc_c8, mbctl_mbentry_c8, 
   mbdata_wr_en_c8, sctag_dram_rd_req, sctag_dram_rd_dummy_req, 
   // Inputs
   tagctl_miss_unqual_c2, tagctl_hit_unqual_c2, tagctl_hit_c3, 
   tagctl_lru_way_c4, tagctl_rdma_vld_px0_p, mbctl_rdma_reg_vld_c2, 
   tagctl_hit_not_comp_c3, alt_tagctl_miss_unqual_c3, 
   arbdp_pst_with_ctrue_c2, arbdp_mbctl_pst_no_ctrue_c2, 
   decdp_cas2_inst_c2, arbdp_inst_mb_c2, decdp_pst_inst_c2, 
   decdp_cas1_inst_c2, arbdp_inst_mb_entry_c1, arbdp_tecc_inst_mb_c8, 
   arbdp_rdma_inst_c1, decdp_ld64_inst_c2, decdp_wr64_inst_c2, 
   decdp_bis_inst_c3, arbctl_csr_st_c2, arbctl_evict_vld_c2, 
   arbctl_mbctl_inst_vld_c2, arbctl_pst_ctrue_en_c8, 
   arbctl_mbctl_hit_off_c1, arbctl_evict_tecc_vld_c2, 
   arbdp_inst_dep_c2, arbdp_addr_c1c2comp_c1, arbdp_addr_c1c3comp_c1, 
   idx_c1c2comp_c1, idx_c1c3comp_c1, arbctl_mbctl_cas1_hit_c8, 
   arbctl_mbctl_ctrue_c9, arbctl_mbctl_mbsel_c1, mb_cam_match, 
   mb_cam_match_idx, decc_uncorr_err_c8, decc_spcd_corr_err_c8, 
   decc_spcfb_corr_err_c8, fbctl_mbctl_match_c2, 
   fbctl_mbctl_stinst_match_c2, fbctl_mbctl_entry_avail, 
   fbf_ready_miss_r1, fbf_enc_ld_mbid_r1, fbf_st_or_dep_rdy_c4, 
   fbf_enc_dep_mbid_c4, fb_count_eq_0, fbctl_mbctl_fbid_d2, 
   fbctl_mbctl_nofill_d2, wbctl_hit_unqual_c2, 
   wbctl_mbctl_dep_rdy_en, wbctl_mbctl_dep_mbid, 
   rdmatctl_hit_unqual_c2, rdmatctl_mbctl_dep_mbid, 
   rdmatctl_mbctl_dep_rdy_en, tagctl_mbctl_par_err_c3, 
   dram_sctag_rd_ack, l2_bypass_mode_on, l2_dir_map_on, rclk, arst_l, 
   grst_l, dbginit_l, si, se, rst_tri_en, arbctl_tecc_c2, 
   arbctl_mbctl_inval_inst_c2
   );

// from tagctl
input	tagctl_miss_unqual_c2; // Miss not qualified with  inst vld or mbctl_hit_c2
input	tagctl_hit_unqual_c2;
input	tagctl_hit_c3 ; // from tagctl.
input	[3:0]	tagctl_lru_way_c4; // encoded way from tagctl.

input	tagctl_rdma_vld_px0_p; // used in mbctl for l2 pick logic.
input	mbctl_rdma_reg_vld_c2; // used by mbctl to insert instructions.
input	tagctl_hit_not_comp_c3; // indicates that hit completion was gated off
input	alt_tagctl_miss_unqual_c3; // indicates a tag mismatch unqualled.


// from arb
input	arbdp_pst_with_ctrue_c2 ; // from arbdec.
input	arbdp_mbctl_pst_no_ctrue_c2 ; // from arbdec. includes LDSTUB/SWAPs pin on TOP
input	decdp_cas2_inst_c2; // from arbdec.
input	arbdp_inst_mb_c2;
input	decdp_pst_inst_c2;
input	decdp_cas1_inst_c2;
input	[3:0]	arbdp_inst_mb_entry_c1;
input	arbdp_tecc_inst_mb_c8; // indicates a tecc instruction from mbf

input	arbdp_rdma_inst_c1; // POST_3.0 pin replaces arbdp_rdma_inst_c2
input	decdp_ld64_inst_c2; // this signal indicates an rdma rd.
input	decdp_wr64_inst_c2;
input	decdp_bis_inst_c3; // NEW_PIN from arbdec. indicating a Block INIT store.

// from arbctl
input	arbctl_csr_st_c2;
input	arbctl_evict_vld_c2 ; // from arbctl.
input	arbctl_mbctl_inst_vld_c2;
input	arbctl_pst_ctrue_en_c8; // from arbctl. PST ctrue only.
input	arbctl_mbctl_hit_off_c1; // frm arbctl used to turn off hits.
input	arbctl_evict_tecc_vld_c2; // POST_2.0 pin.
input	arbdp_inst_dep_c2 ; // POST_2.0 pin.

// input	arbctl_addr_c1eqc2_c1 ; // from arbctl ( 32b address compare ) OLD_PIN
// input	arbctl_addr_c1eqc3_c1 ; // from arbctl ( 32b address compare ) OLD_PIN

input	arbdp_addr_c1c2comp_c1; // NEW_PIN
input	arbdp_addr_c1c3comp_c1; // NEW_PIN
input	idx_c1c2comp_c1; // NEW_PIN
input	idx_c1c3comp_c1; // NEW_PIN

input	arbctl_mbctl_cas1_hit_c8;// CAS1 hit.
input	arbctl_mbctl_ctrue_c9 ; // compare result for CAS1
input	arbctl_mbctl_mbsel_c1;

// from mbtag
input	[15:0]	mb_cam_match ; // from mbtag.
input	[15:0]	mb_cam_match_idx ; // NEW_PIN replacing mb_cam_match14

// from deccdp
input	decc_uncorr_err_c8 ; // ecc result for CAS1
input	decc_spcd_corr_err_c8;
input	decc_spcfb_corr_err_c8 ; 

// from fbctl.
input	fbctl_mbctl_match_c2 ; // from fbctl.
input	fbctl_mbctl_stinst_match_c2 ; // NEW_PIN 
input	fbctl_mbctl_entry_avail; // from fbctl.
input	fbf_ready_miss_r1; // miss ready 
input	[3:0]	fbf_enc_ld_mbid_r1 ; // miss entry 
input	fbf_st_or_dep_rdy_c4;// st or dep rdy enable
input	[3:0] fbf_enc_dep_mbid_c4; // st or dep entry mbid
input	fb_count_eq_0; // from fbctl.
input	[2:0]	fbctl_mbctl_fbid_d2 ; // inserting fbid 
input		fbctl_mbctl_nofill_d2;// for no fills.

// wbctl
input	wbctl_hit_unqual_c2 ; // from wbctl.
input	wbctl_mbctl_dep_rdy_en ; // rdy wbb dependents
input	[3:0]	wbctl_mbctl_dep_mbid; // wbb dependent mbid.

// rdmatctl.
input	rdmatctl_hit_unqual_c2; // from rdmatctl
input	[3:0]	rdmatctl_mbctl_dep_mbid; // from rdmatctl
input	rdmatctl_mbctl_dep_rdy_en;


input	tagctl_mbctl_par_err_c3 ; // parity err from tagdp.

// dram interface
input	dram_sctag_rd_ack;

// from csr
input	l2_bypass_mode_on;
input	l2_dir_map_on; // NEW_PIN




input	rclk;
input	arst_l;
input	grst_l;
input	dbginit_l;
input	si, se;
input	rst_tri_en;

input	arbctl_tecc_c2; // POST_3.0 PIN

output	so;


// to arbctl
//output		mbctl_arbctl_cnt11_px1 ; // OLD_PIN
output		mbctl_arbctl_cnt12_px2_prev ;
output		mbctl_arbctl_snp_cnt8_px1;
output		mbctl_arbctl_vld_px1 ; 
output		mbctl_nondep_fbhit_c3; // to arbctl for dir CAM input generation.

// to tagdp_ctl
output	mbctl_hit_c3; // POST_2.0 pin

output	mbctl_arbctl_hit_c3 ; // POST_4.2 pin ( place on the left towards the top )
input	arbctl_mbctl_inval_inst_c2 ; // POST_4.2 pin ( place on the left towards the top )


// to arbaddr and arbdec.
output	mbctl_arbdp_ctrue_px2; // instruction CTRUE bit.
output	mbctl_arb_l2rd_en; // rd flop en to arbaddr and arbdec.
output	mbctl_arb_dramrd_en; // rd flop en to arbaddr and arbdec

// to tagctl.
output	mbctl_tagctl_hit_unqual_c2;
output	mbctl_corr_err_c2, mbctl_uncorr_err_c2 ;
output	mbctl_wr64_miss_comp_c3; // to tagctl for setting rdma reg vld.

// to wbctl.
output	[3:0]	mbctl_wbctl_mbid_c4; // write mbid to RDY in WBB after write to DRAM.

// to fbctl.
output	[3:0]	mbf_insert_mbid_c4;
output		mbf_insert_c4;
output 		mbctl_hit_c4;
output		mbf_delete_c4;
output		mbctl_fbctl_next_vld_c4;
output	[3:0]	mbctl_fbctl_next_link_c4;
output		mbctl_fbctl_dram_pick ;

output	[2:0]	mbctl_fbctl_fbid;
output	[3:0]	mbctl_fbctl_way ;
output		mbctl_fbctl_way_fbid_vld ;

// to mbtag 
output		mbtag_wr_en_c2 ;// output to mbtag only
output	[15:0]	mb_write_wl ; // output to mbtag  
output		mbctl_buf_rd_en; // output to mbtag and mbdata 
output	[15:0]	mb_read_wl ; // output to mbtag and mbdata.

// to mbdata.
output		mbctl_dep_c8; // to mbdata.
output	[15:0]	mb_data_write_wl; // to mbdata
output		mbctl_evict_c8; // to mbdata
output		mbctl_tecc_c8 ; // to mbdata
output	[3:0]	mbctl_mbentry_c8 ; // to mbdata
output		mbdata_wr_en_c8  ;

// to BTU
output	sctag_dram_rd_req ;
output	sctag_dram_rd_dummy_req;

wire	mbf_insert_c2; 
wire	mbf_delete_miss_c2;
wire	mbf_delete_c2, mbf_delete_c3;
wire	[15:0]	reset_valid_bit_c3;
wire	[15:0]	mb_write_ptr_c2, mb_write_ptr_c3 ;
wire	[3:0]	mb_entry_c3;
wire	[15:0]	dec_mb_entry_c3;


wire    [4:0]   mb_count_prev;
wire    [4:0]   mb_count_c4; // Actual count.
wire    [4:0]   mb_count_plus1;
wire    [4:0]   mb_count_minus1;
wire		cnt_reset, mb_count_en ;
wire	[15:0]	mb_tag_wr_wl_c3;

wire	[3:0]	inst_mb_entry_c2;
wire	[15:0] cam_hit_vec_c1 ;
wire	[15:0] hit_off_bypass_vec_c1 ;
wire	[15:0] hit_on_bypass_vec_c1 ;
wire	[15:0] tmp_cam_hit_vec_c1, tmp_cam_hit_vec_c2 ;
wire	tmp_cam_hit_c2;
wire		mbctl_hit_c2;
wire	[15:0]	mbctl_hit_vec_c2, mbctl_hit_vec_c3;
wire	[15:0]	dec_mb_entry_c2;

wire	inst_mb_c3;
wire	mb_inst_vld_c3;
wire	mb_rewrite_en_c3;
wire	mbdata_wr_en_c3, mbdata_wr_en_c4;
wire	mbdata_wr_en_c5, mbdata_wr_en_c6;
wire	mbdata_wr_en_c7  ;

wire	[3:0]	enc_tag_wr_wl_c2, enc_tag_wr_wl_c3;
wire	[15:0]	insert_ptr_c8 ;
wire	[15:0]	mb_data_wr_wl_c8 ;

wire	[3:0]	enc_data_wr_wl_c4, enc_data_wr_wl_c5;
wire	[3:0]	enc_data_wr_wl_c6, enc_data_wr_wl_c7;
wire	[3:0]	enc_data_wr_wl_c8 ;

// Control Bits.
wire	[15:0]	mb_valid_prev, mb_valid;
wire	[15:0]	mb_bis_prev, mb_bis;
wire	[15:0]	mb_rdma_prev, mb_rdma;
wire	[15:0]	mb_young_prev, mb_young ;
wire	[15:0]	mb_ctrue_prev, mb_ctrue ;
wire	[15:0]	mb_dram_ready, mb_dram_ready_in;
wire	[15:0]	mb_evict_ready, mb_evict_ready_in ;
wire	[15:0]	mb_tecc_ready, mb_tecc_ready_in ;
wire	[15:0]	mb_data_vld_in, mb_data_vld;
wire	[15:0]	mb_l2_ready_in, mb_l2_ready;
wire	[15:0]	mb_way_vld_in , mb_way_vld ;
wire	[15:0]	mb_fbid_vld_in , mb_fbid_vld ;
wire	[15:0]	mb_corr_err_in, mb_corr_err ;
wire	[15:0]	mb_uncorr_err_in, mb_uncorr_err ;

wire	[3:0]	way0, way1, way2, way3 ;
wire	[3:0]	way4, way5, way6, way7 ;
wire	[3:0]	way8, way9, way10, way11 ;
wire	[3:0]	way12, way13, way14, way15 ;
wire	[3:0]	next_link_entry0, next_link_entry1, next_link_entry2, next_link_entry3;
wire	[3:0]	next_link_entry4, next_link_entry5, next_link_entry6, next_link_entry7;
wire	[3:0]	next_link_entry8, next_link_entry9, next_link_entry10, next_link_entry11;
wire	[3:0]	next_link_entry12, next_link_entry13, next_link_entry14, next_link_entry15;
wire	[2:0]	fbid0, fbid1, fbid2, fbid3 ;
wire	[2:0]	fbid4, fbid5, fbid6, fbid7 ;
wire	[2:0]	fbid8, fbid9, fbid10, fbid11 ;
wire	[2:0]	fbid12, fbid13, fbid14, fbid15 ;



wire	[15:0]	 mb_way_fb_vld_reset ;
wire	[15:0]	way_fbid_vld;

// Mux selects for muxing out the next link field
wire	sel_0to3, sel_4to7, sel_8to11, sel_12to15 ;
wire	sel_default_0123, sel_default_4567 ;
wire	sel_default_89ab, sel_default_cdef ;
wire	sel_default_nlink;

wire		mbctl_next_vld_c3;
wire	[3:0]	mbctl_next_link_c3;

wire	inst_mb_c4, inst_mb_c5, inst_mb_c6;
wire	inst_mb_c7, inst_mb_c8;
wire	[15:0]	cas_rdy_set_c9;
wire	[15:0]	cas_ctrue_set_c9;
wire	[3:0] 	mbctl_ctrue_rdy_entry;
wire	[3:0]	nextlink_id0123, nextlink_id4567 ;
wire	[3:0]	nextlink_id89ab, nextlink_idcdef ;
wire	[15:0]	next_link_wr_en_c3 ;
wire	[3:0]	enc_data_wr_wl_c3;

wire	mb_hit_off_c1_d1;

wire	mbctl_dep_inst_c3, mbctl_dep_inst_c4;
wire	mbctl_dep_inst_c5, mbctl_dep_inst_c6;
wire	mbctl_dep_inst_c7;


wire	mbctl_mark_evict_tmp_c2;
wire	mbctl_mark_evict_tmp_c3;
wire	mbctl_mark_dram_rdy_c3;
wire	dram_rdy_c4, dram_rdy_c5 ;
wire	dram_rdy_c6, dram_rdy_c7, dram_rdy_c8 ;
wire	mbctl_evict_c7;

wire	mbctl_tecc_c4, mbctl_tecc_c5 ;
wire	mbctl_tecc_c6, mbctl_tecc_c7 ;

wire	[15:0]	dram_ready_set_c8, reset_dram_ready ;
wire		dram_pick;

wire	dram_ack_pending_in;
wire	dram_ack_pend_state;
wire	dram_sctag_rd_ack_d1;

wire		ready_miss_r2;
wire	[3:0]	ld_mbid_r2 ;
wire	[15:0]	mb_miss_rdy_r2 ; 
wire	st_or_dep_rdy_c5;
wire	[3:0]	dep_mbid_c5;
wire	[15:0]	fb_dep_rdy_c5;
wire	cas1_inst_c3;
wire	mb_dep_rdy_en_c3, mb_dep_rdy_en_c4;
wire	[15:0]	mb_dep_rdy_c4;
wire	[3:0]	wbb_dep_mbid_d1;
wire		wbb_dep_rdy_en_d1;
wire	[15:0]	wbb_dep_rdy_d1;
wire	rdmat_dep_rdy_en_d1;
wire	[3:0]	rdmat_dep_mbid_d1;
wire	[15:0]	rdmat_dep_rdy_d1;

wire	mbid_vld_in, mbid_vld;
wire	set_mbid_vld, reset_mbid_vld, set_mbid_vld_prev;
wire	rdy_csr_inst_en;
wire	[3:0]	csr_mbid;
wire	[15:0]	csr_inst_rdy ;
wire	[15:0]	cas2_or_pst_rdy_c8;
wire	dram_pick_prev;

wire	[15:0]	l2_pick_vec, dram_pick_vec, mb_read_pick_vec ;
wire	[3:0]	pick_quad0_in, pick_quad1_in, pick_quad2_in, pick_quad3_in;
wire	[3:0]	pick_quad_in;

wire		sel_dram_lshift, sel_dram_same ;
wire	[3:0]	dram_pick_state_lshift, dram_pick_state,dram_pick_state_prev ;

wire		sel_dram_lshift_quad0, sel_dram_same_quad0 ;
wire	[3:0]	dram_pick_state_lshift_quad0, dram_pick_state_quad0;
wire	[3:0]	dram_pick_state_prev_quad0 ;

wire		sel_dram_lshift_quad1, sel_dram_same_quad1 ;
wire	[3:0]	dram_pick_state_lshift_quad1, dram_pick_state_quad1;
wire	[3:0]	dram_pick_state_prev_quad1 ;

wire		sel_dram_lshift_quad2, sel_dram_same_quad2 ;
wire	[3:0]	dram_pick_state_lshift_quad2, dram_pick_state_quad2;
wire	[3:0]	dram_pick_state_prev_quad2 ;

wire		sel_dram_lshift_quad3, sel_dram_same_quad3 ;
wire	[3:0]	dram_pick_state_lshift_quad3, dram_pick_state_quad3;
wire	[3:0]	dram_pick_state_prev_quad3 ;

wire	sel_l2_lshift, sel_l2_same, init_pick_state;
wire	[3:0]	l2_pick_state_prev, l2_pick_state_lshift;
wire	[3:0]	l2_pick_state;
wire	sel_l2_lshift_quad0, sel_l2_same_quad0 ;
wire	[3:0]	l2_pick_state_prev_quad0, l2_pick_state_lshift_quad0;
wire	[3:0]	l2_pick_state_quad0;
wire	sel_l2_lshift_quad1, sel_l2_same_quad1 ;
wire	[3:0]	l2_pick_state_prev_quad1, l2_pick_state_lshift_quad1;
wire	[3:0]	l2_pick_state_quad1;
wire	sel_l2_lshift_quad2, sel_l2_same_quad2 ;
wire	[3:0]	l2_pick_state_prev_quad2, l2_pick_state_lshift_quad2;
wire	[3:0]	l2_pick_state_quad2;
wire	sel_l2_lshift_quad3, sel_l2_same_quad3 ;
wire	[3:0]	l2_pick_state_prev_quad3, l2_pick_state_lshift_quad3;
wire	[3:0]	l2_pick_state_quad3;
wire	[3:0]	pick_state;
wire	[3:0]	pick_state_quad0, pick_state_quad1;
wire	[3:0]	pick_state_quad2, pick_state_quad3;
wire	pick_s0_quad0, 	pick_s1_quad0, pick_s2_quad0, pick_s3_quad0;
wire	pick_s0_quad1, 	pick_s1_quad1, pick_s2_quad1, pick_s3_quad1;
wire	pick_s0_quad2, 	pick_s1_quad2, pick_s2_quad2, pick_s3_quad2;
wire	pick_s0_quad3, 	pick_s1_quad3, pick_s2_quad3, pick_s3_quad3;
wire	pick_s0, pick_s1, pick_s2, pick_s3 ;
wire	[3:0]	pick_quad0_sel, pick_quad1_sel ;
wire	[3:0]	pick_quad2_sel, pick_quad3_sel ;
wire	[3:0]	pick_quad_sel;
wire	[15:0]	picker_out, picker_out_d1, picker_out_d2 ;
wire		picker_out_qual;

wire	l2_pick, l2_pick_d1;
wire	l2_wait_set, l2_wait_reset ;
wire	l2_wait_in, l2_wait ;
wire	l2_pick_read_ctrue;
wire	evict_vld_unqual_c3;

wire	evict_vld_c3, evict_vld_c4;
wire	[15:0]	dec_wr_wl_c4;
 wire	[15:0]	dec_dram_pick_d2 ;

wire	way_fbid_rd_vld_prev;
wire	fbsel_0to3, fbsel_4to7, fbsel_8to11; 
wire	fbsel_def_0123, fbsel_def_4567, fbsel_def_89ab, fbsel_def_cdef ;
wire	fbsel_def_vld ; 
wire	[3:0]	way0123, way4567, way89ab, waycdef;
wire	[2:0]	fbid0123, fbid4567, fbid89ab, fbidcdef ;

wire	[15:0]	mb_entry_dec_c1;
wire	mbctl_corr_err_unqual_c2, mbctl_uncorr_err_unqual_c2;
wire	mbctl_corr_err_c1, mbctl_uncorr_err_c1 ;
wire	[3:0]	mbf_insert_mbid_c3;
wire		mbf_insert_c3;
wire	nondep_fbhit_c2_unqual;
wire	rdma_inst_c3;
wire	[15:0]	mb_l2_ready_qual_in, mb_l2_ready_qual ;

wire	mbf_insert_c3_tmp, inst_mb_c3_1;
wire	wr64_inst_c3;

wire	mb_rdma_count_en;
wire	[3:0]	mb_rdma_count_c4, mb_rdma_count_plus1; 
wire	[3:0]	mb_rdma_count_prev, mb_rdma_count_minus1; 
wire	inc_rdma_cnt_c3;

wire	buffer_miss_vld_c2, buffer_miss_vld_c3;
wire	rdma_comp_rdy_c3, rdma_comp_rdy_c4, rdma_comp_rdy_c5;
wire	rdma_comp_rdy_c6, rdma_comp_rdy_c7, rdma_comp_rdy_c8 ;
wire	wr64_miss_not_comp_c3;
wire	ld64_inst_c3, ld64_inst_c4, ld64_inst_c5 ;
wire	ld64_inst_c6, ld64_inst_c7 ;

wire	fbctl_match_c3, fbctl_match_c3_unqual ;
wire	l2_bypass_mode_on_d1;

wire	mbctl_rdma_gate_off_c2;
wire	rdma_reg_vld_c3;
wire	fbctl_stinst_match_c3;
wire	dummy_req_d1, dummy_req_d2 ;

wire	[15:0]	mb_cam_hit_vec_c1 ;

wire	tmp_cam_hit_c1_3to0, tmp_cam_hit_c1_7to4;
wire	tmp_cam_hit_c1_11to8, tmp_cam_hit_c1_15to12;
wire	tmp_cam_hit_c2_3to0, tmp_cam_hit_c2_7to4;
wire	tmp_cam_hit_c2_11to8, tmp_cam_hit_c2_15to12;

wire	l2_dir_map_on_d1;
wire	mbctl_c1c3_match_c1;
wire	mbctl_c1c2_match_c1, mbctl_c1c2_match_c1_d1;
wire    [15:0]  mb_valid_ifin;
wire	dram_pick_1, dram_pick_2_l ;

wire	evict_par_err_c3, evict_par_err_c4; 
wire	evict_par_err_c5; 
wire	evict_par_err_c6, evict_par_err_c7; 
wire	[15:0]	mb_tag_wr_wl_c3_tmp;

wire	[15:0]	cam_idx_hit_vec_c1, idx_on_bypass_vec_c1;
wire	[15:0]	tmp_idx_hit_vec_c1, tmp_idx_hit_vec_c2;
wire	[15:0]	mbctl_idx_hit_vec_c2, mbctl_idx_hit_vec_c3 ;
wire	tmp_hit_unqual_c2 ;
wire	nondep_fbhit_c3_unqual;
wire	hit_vec_qual, idx_hit_vec_qual;
wire	mbissue_inst_vld_c2;

wire	[1:0]	cout1;
wire	[1:0]	cout2;
wire	[1:0]	cout3;
wire	[1:0]	cout4;
wire	[1:0]	cout5;

wire	[2:0]	cout2_1;
wire	[2:0]	cout2_2;
wire	[2:0]	cout2_3;

wire	[3:0]	cout3_tmp ;
wire	[4:0]	cout3_final ;

wire	set_mb_idx_full_c4, reset_mb_idx_full_c4 ;
wire	mb_idx_count_full_c4, mb_idx_count_full_c5;
wire	[4:0]	hit_count_c4;

wire	mb_rewrite_en_c4;
wire	mb_rewrite_en_c5, mb_rewrite_en_c6;
wire	mb_rewrite_en_c7, mb_rewrite_en_c8;

wire	[3:0]	dec_low_insert_ptr, dec_hi_insert_ptr;
wire	mb_inst_vld_c3_1;
wire	[15:0]	mb_way_fb_vld_tmp;
wire		mb_way_fb_vld_tmp_0to3;
wire		mb_way_fb_vld_tmp_4to7;
wire		mb_way_fb_vld_tmp_8to11;
wire            dbb_rst_l;
wire	mbctl_tecc_c3;
wire tagctl_hit_unqual_c3;
wire	mb_inst_vld_c3_2;
wire	mbctl_c1c2_match_c1_d1_1;
wire	mbf_insert_c3_tmp_1, mbf_delete_c3_tmp_1 ;
wire	inst_mb_c3_2;
wire	dram_pick_2;
wire	evict_tecc_vld_c3;
wire	mbctl_dep_inst_c2;
wire	dep_inst_c3, tecc_c3 ;
wire	inst_mb_c9;
wire	[3:0]	enc_data_wr_wl_c9;
wire	cas1_hit_c9;
wire	uncorr_err_c9;
wire	[15:0]	pst_ctrue_set_c8;
wire	mbctl_corr_err_c8; 

wire	rdma_inst_c2;
wire	fbsel_0to3_d1, fbsel_4to7_d1;
wire	fbsel_8to11_d1, fbsel_def_vld_d1;
wire	sel_mux0, sel_mux1;
wire	sel_mux2, sel_mux3;
wire	[3:0]	way0123_d1, way4567_d1 ;
wire	[3:0]	way89ab_d1, waycdef_d1 ;
wire	[2:0]	fbid0123_d1, fbid4567_d1;
wire	[2:0]	fbid89ab_d1, fbidcdef_d1;
wire	[3:0]	enc_data_wr_wl_c7_1;
wire	[3:0]	mb_entry_c3_1;
wire	mb_inval_inst_c3;
/////////////////////////////////////////////////////////////////
//
// OFF mode  exceptions in  mbctl:
//
// 1) In the L2 off mode,  a mbf dependent is readied on a
//    fill buffer hit unless, the fill buffer entry has fb_stinst=1
//    or the instruction hitting the FIll Buffer is a CAS1 
//
// 2) Eviction pass is turned off by preventing the setting of
//    the EVICT bit. Remember to not turn off the dram request.
//	( Look at the expression for mbctl_evict_c7 )
//
/////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////
 // Reset flop
 ///////////////////////////////////////////////////////////////////

 dffrl_async    #(1)    reset_flop      (.q(dbb_rst_l),
                                        .clk(rclk),
                                        .rst_l(arst_l),
                                        .din(grst_l),
                                        .se(se), .si(), .so());



/////////////////////////////////////////////////////////////////
// An RDMA instruction that is not a PST will not access the
// $  or the FB if the rdma reg vld is asserted.
//
// This signal is used for gating off completions becuase of
// FB hits.
/////////////////////////////////////////////////////////////////

assign  mbctl_rdma_gate_off_c2 = ( mbctl_rdma_reg_vld_c2 
                                //~arbdp_mbctl_pst_no_ctrue_c2  not needed since we use this  for completions only
                                & rdma_inst_c2 );


///////////////////////////////////////////////////////////////////////////
// MISS BUFFER INSERTION : An entry is inserted into the Miss Buffer under
//	the following conditions
//	* Valid instruction has to be a non Miss Buffer
//	  instruction AND
//	* An L2 tag miss with the following exceptions
//		- Tecc instruction
//		- diagnostic instruction
//		- interrupt instruction.
//		- inval instruction.
//		- cas2 instruction.
//		- wr64 instruction not hitting the fill Buffer
//	* A Pst with no ctrue ( INcludes LDSTUB/SWAPS)
//	* An rdma instrution that encounters rdma_reg_vld.
//	* A CAS2 instruction 
//	* Miss Buffer hit.
//	* WB or RDMAt hit.
//	* CSR store.
//	**** A non Allocating instruction that encounters a Parity error.
//
// MISS BUFFER DELETION : An entry is deleted from the Miss Buffer if
//	* It is issued from the Miss Buffer
//	  AND
//	* a non-partial store $ or FB hit.
//	* Pst with ctrue $ or FB hit.
//	* CSR store from the Miss Buffer. 
//
// MISS BUFFER INSERTION PIPELINE:
//---------------------------------------------------------------------
// 	C1		C2		C3		C4
//---------------------------------------------------------------------
//	Cam		generate	write		valid=1
//	mbf		wr ptr		mbf tag
//							mb_count[4:0]
//							mb_count>5
//							mb_count>12
//					insertion
//					condition
//					counter
//					logic
//---------------------------------------------------------------------
// TIMING tagctl_miss_unqual_c2 is the most critical condition for insertion.
//	  It takes ~17 gates to arrive at mbctl.
//	  If parity has to be factored into the insertion equation, it would have
//	  to be Ored in C3. 
//	  
//	
//////////////////////////////////////////////////////////////////////////


assign	mbtag_wr_en_c2 = ~arbdp_inst_mb_c2 & arbctl_mbctl_inst_vld_c2 ;

assign	mbf_insert_c2 =  ( 
			((arbdp_mbctl_pst_no_ctrue_c2 | // pst no ctrue
			decdp_cas2_inst_c2 |  // cas2
			arbctl_csr_st_c2 ) |  // csr store c2
			wbctl_hit_unqual_c2 | // wb tag match
			rdmatctl_hit_unqual_c2 | // rdma tag match
			mbctl_rdma_gate_off_c2 ) &  // rdma reg vld.
			mbtag_wr_en_c2 )  |
			mbctl_hit_c2 |  // dependent insertion.
			( tagctl_miss_unqual_c2 & 
			 ~(decdp_wr64_inst_c2 & ~fbctl_mbctl_match_c2) & // not an RDMA 64B write that misses FB
			mbtag_wr_en_c2 ); 

// Parity error insertion is turned off for a tag hit 
dff_s   #(1)  ff_tagctl_hit_unqual_c3    (.din(tagctl_hit_unqual_c2), .clk(rclk), 
		.q(tagctl_hit_unqual_c3), .se(se), .si(), .so());

//assign	 mbctl_tagctl_hit_unqual_c3 = tagctl_hit_unqual_c3 ;


			
dff_s   #(1)  ff_mbf_insert_c3    (.din(mbf_insert_c2), .clk(rclk), 
		.q(mbf_insert_c3_tmp), .se(se), .si(), .so());

dff_s   #(1)  ff_mbf_insert_c3_1    (.din(mbf_insert_c2), .clk(rclk), 
		.q(mbf_insert_c3_tmp_1), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_mb_c3_1    (.din(arbdp_inst_mb_c2), .clk(rclk), 
		.q(inst_mb_c3_1), .se(se), .si(), .so());

assign	mbf_insert_c3 = mbf_insert_c3_tmp | ( ~inst_mb_c3_1 & 
				tagctl_mbctl_par_err_c3  &
				~tagctl_hit_unqual_c3 ) ;	// tecc insert is 
								// the most critical 
								// insertion condition.





assign	mbf_delete_miss_c2 = ( ~decdp_pst_inst_c2 |  // non partial store inst
				arbdp_pst_with_ctrue_c2 ) & // pst with ctrue
			 	mbissue_inst_vld_c2 &
				( tagctl_hit_unqual_c2 | 
				(fbctl_mbctl_match_c2 & 
				~mbctl_rdma_gate_off_c2 )) ;

//-----\/ FIX for bug #4619 --\/-----
// inval/csr instructions will get deleted from the miss buffer
// when they are issued out of there.
//-----\/ FIX for bug #4619 --\/-----

assign	mbf_delete_c2  = ( ( arbctl_csr_st_c2 | arbctl_mbctl_inval_inst_c2 )  
			& mbissue_inst_vld_c2   )  |
		 	mbf_delete_miss_c2 ;  // delete a miss after it hits $ or FB


dff_s   #(1)  ff_mbf_delete_c3    (.din(mbf_delete_c2), .clk(rclk), 
		.q(mbf_delete_c3_tmp), .se(se), .si(), .so());

dff_s   #(1)  ff_mbf_delete_c3_1    (.din(mbf_delete_c2), .clk(rclk), 
		.q(mbf_delete_c3_tmp_1), .se(se), .si(), .so());

assign	mbf_delete_c3 = ( inst_mb_c3 & mbctl_wr64_miss_comp_c3  & ~tagctl_mbctl_par_err_c3) | mbf_delete_c3_tmp ; 

///////////////////////////////////////////////////////////////////////
// mbctl_nondep_fbhit_c3: This signal indicates an FB tag match 
// for an instruction that is not a miss buffer dependent.
//
// A store  instruction issued from the Xbar that misses the Miss Buffer
// but hits the Fill Buffer should CAM the directory and invalidate
// the L1s that share the line. 
// If we simply look at tagctl_hitl2orfb_c3, we will miss the above
// case. 
//
// However, for all tag miss cases encountering a parity error, the
// store is inserted into the Miss Buffer and replayed for sending an ACK
//
// mbctl_nondep_fbhit_c3 should be low when a tag parity error occurs.
// This is because we don't want to CAM the directory for the case when
// a tag miss but a fb hit is encountered for a non miss buffer instruction.
///////////////////////////////////////////////////////////////////////


assign	nondep_fbhit_c2_unqual =  fbctl_mbctl_match_c2 & 
				~mbctl_tagctl_hit_unqual_c2 ; 

//dff   #(1)  ff_mbctl_nondep_fbhit_c3    (.din(nondep_fbhit_c2_unqual), .clk(rclk), 
		//.q(nondep_fbhit_c3_unqual), .se(se), .si(), .so());
//
//assign	mbctl_nondep_fbhit_c3 = nondep_fbhit_c3_unqual & 
				//~tagctl_mbctl_par_err_c3 &
				//mb_inst_vld_c3 ;

// -------------\/ FIX for int_5.0 \/-------------------------------
// mbctl_nondep_fbhit_c3 is no longer qualfied with mb_inst_vld_c3
// or tagctl_mbctl_par_err_c3 since it is a critical signal.
// -----------------------------------------------------------------

dff_s   #(1)  ff_mbctl_nondep_fbhit_c3    (.din(nondep_fbhit_c2_unqual), .clk(rclk),
                .q(mbctl_nondep_fbhit_c3), .se(se), .si(), .so());



//////////////////////////////////////////////////////////////////////////////
// mbf Insertion pointer.
// The Insertion pointer is determined in C2 based on the 
// valid bit written by the C4 instruction. One cycle of
// forwarding is required to prevent overwriting a valid
// entry as shown in the following pipeline.
//-----------------------------------------------------
//	C2		C3		C4
//-----------------------------------------------------
//	calc.		write		valid=1
//	wr ptr.
//-----------------------------------------------------
//			C2		C3		
//-----------------------------------------------------
//			calc		
//			wr ptr.
//
// 	Timing optimization: The wr ptr in C2 can assume that the 
// 	operation in C3 is going to insert. This will not affect the
//	insertion of the C2 op even if the assumption turns out to 
//	be incorrect.
/////////////////////////////////////////////////////////////////////////////////





assign  mb_valid_ifin = ( mb_valid | (mb_write_ptr_c3 & 
			{16{mb_inst_vld_c3_1}} ));

assign  mb_write_ptr_c2[0] = ~mb_valid_ifin[0];
assign  mb_write_ptr_c2[1] = ~mb_valid_ifin[1] &       (mb_valid_ifin[0]) ;
assign  mb_write_ptr_c2[2] = ~mb_valid_ifin[2] &   (&(mb_valid_ifin[1:0])) ;
assign  mb_write_ptr_c2[3] = ~mb_valid_ifin[3] &  (&(mb_valid_ifin[2:0])) ;
assign  mb_write_ptr_c2[4] = ~mb_valid_ifin[4] &  (&(mb_valid_ifin[3:0])) ;
assign  mb_write_ptr_c2[5] = ~mb_valid_ifin[5] &   (&(mb_valid_ifin[4:0])) ;
assign  mb_write_ptr_c2[6] = ~mb_valid_ifin[6] &   (&(mb_valid_ifin[5:0])) ;
assign  mb_write_ptr_c2[7] = ~mb_valid_ifin[7] &   (&(mb_valid_ifin[6:0])) ;
assign  mb_write_ptr_c2[8] = ~mb_valid_ifin[8] &   (&(mb_valid_ifin[7:0])) ;
assign  mb_write_ptr_c2[9] = ~mb_valid_ifin[9] &   (&(mb_valid_ifin[8:0])) ;
assign  mb_write_ptr_c2[10] = ~mb_valid_ifin[10] &   (&(mb_valid_ifin[9:0])) ;
assign  mb_write_ptr_c2[11] = ~mb_valid_ifin[11] &   (&(mb_valid_ifin[10:0])) ;
assign  mb_write_ptr_c2[12] = ~mb_valid_ifin[12] &   (&(mb_valid_ifin[11:0])) ;
assign  mb_write_ptr_c2[13] = ~mb_valid_ifin[13] &   (&(mb_valid_ifin[12:0])) ;
assign  mb_write_ptr_c2[14] = ~mb_valid_ifin[14] &   (&(mb_valid_ifin[13:0])) ;
assign  mb_write_ptr_c2[15] = ~mb_valid_ifin[15] &   (&(mb_valid_ifin[14:0])) ;


assign	mb_write_wl = mb_write_ptr_c2 ; // wordline for mbtag write

//////////////////////////////////////////////////////////////
// Generate 2 signals  :
// mb_count, 
// mbctl_arbctl_cnt12_px2 count >= 12
//
// The cnt12 condition is calculated in C3 and staged to C4.
// The inflight instructions that need to be accounted for are
// PX2*, C1, C2 C3, 
//
// ( The PX2 instruction is not stalled if it is the 2nd packet
// of a CAS instruction and if the first one has gone through.)
// Hence the high water mark is asserted when there are 12 or
// more instructions in the Miss Buffer.
//
// Timing notes:
// The mb_cnt12_px2_prev is calculated in the C3 stage 
// every "valid" C3 op is presumed to insert if it is not issued
// from the Miss Buffer. If this is the case, the Miss Buffer will
// have to accomodate the ops in C2, C1, PX2 and PX1. Hence this
// signal is asserted when the miss buffer counter is at 11 
// and the C3 op is not from the miss buffer. OR
// if the miss buffer counter > 11
//
//////////////////////////////////////////////////////////////

assign	cnt_reset = ( ~dbb_rst_l ) ;

// insertion and deletion cannot happen at the same time.
assign	mb_count_en = ( mbf_insert_c3 | mbf_delete_c3 ) ;
 

assign  mb_count_plus1  = mb_count_c4+ 5'b1 ;
assign  mb_count_minus1 = mb_count_c4- 5'b1 ;

mux2ds  #(5) mux_mbf_count  (.dout (mb_count_prev[4:0]),
                    .in0(mb_count_plus1[4:0]), .in1(mb_count_minus1[4:0]),
                    .sel0(mbf_insert_c3), .sel1(~mbf_insert_c3));

dffre_s   #(5)  ff_mb_count_c4 (.din(mb_count_prev[4:0]),
                 .en(mb_count_en), .clk(rclk), .rst(cnt_reset),
                 .q(mb_count_c4[4:0]), .se(se), .si(), .so());

//assign	mbctl_arbctl_cnt12_px2_prev = 
		//(( mb_count_c4== 5'd11 ) & mbf_insert_c3 & ~mbf_delete_c3 )  |
	     	//( mb_count_c4 > 5'd11 ) ;

assign	mbctl_arbctl_cnt12_px2_prev = 
		mb_idx_count_full_c4  |  // indicates 7 or more entries with
					// the same index in the mIss buffer.
		(( mb_count_c4== 5'd11 ) 
		& mb_inst_vld_c3 & ~inst_mb_c3 )  | // assume that 
	     	( mb_count_c4 > 5'd11 ) ;


// synopsys translate_off
always	@(mb_count_c4  ) begin
	if(  mb_count_c4 > 5'd16 )  begin
`ifdef MODELSIM
	$display("MB_COUNT", "illegal mb insertion with mb_count 16");
//`else
//	$error("MB_COUNT", "illegal mb insertion with mb_count 16");
`endif	
	end
	else  begin end// do nothing.
end
// synopsys translate_on


dff_s   #(1)  ff_rdma_inst_c2    
		(.din(arbdp_rdma_inst_c1), .clk(rclk),
             .q(rdma_inst_c2), .se(se), .si(), .so());

dff_s   #(1)  ff_rdma_inst_c3    
		(.din(rdma_inst_c2), .clk(rclk),
             .q(rdma_inst_c3), .se(se), .si(), .so());


//////////////////////////////////////////////////////////////////////
// PREVENTION of LIVELOCK
// RDMA instructions in the Miss Buffer have a high water mark of
// 8 for the following reason.
// When the interface to the jbi frees up, an instruction from the
// snoop/jbi interface will have a higher priority to issue than
// the miss Buffer. It is possible to construct a livelock case
// where, entries from the snpq always get selected over older
// miss buffer snoops. If the miss Buffer is filled with snoops,
// it will cause the pipeline to be completely hogged by snoops.
// 
// To prevent this livelock, we maintain a snoop instruction counter
//  in the Miss Buffer. Whenever this counter reaches 8. it disallows
// any instruction from the snoop Q from issuing to the pipeline until
// the counter value drops below 8.
//////////////////////////////////////////////////////////////////////

assign	mb_rdma_count_en = ( mbf_insert_c3 | mbf_delete_c3 ) & rdma_inst_c3 ;
assign  mb_rdma_count_plus1  = mb_rdma_count_c4+ 4'b1 ;
assign  mb_rdma_count_minus1 = mb_rdma_count_c4- 4'b1 ;

assign	inc_rdma_cnt_c3 = mbf_insert_c3 & rdma_inst_c3;


mux2ds  #(4) mux_mbf_rdma_count  (.dout (mb_rdma_count_prev[3:0]),
                .in0(mb_rdma_count_plus1[3:0]), 
		.in1(mb_rdma_count_minus1[3:0]),
                .sel0(inc_rdma_cnt_c3), 
		.sel1(~inc_rdma_cnt_c3));

dffre_s   #(4)  ff_mb_rdma_count_c4 (.din(mb_rdma_count_prev[3:0]),
                 .en(mb_rdma_count_en), .clk(rclk), .rst(cnt_reset),
                 .q(mb_rdma_count_c4[3:0]), .se(se), .si(), .so());

assign	mbctl_arbctl_snp_cnt8_px1 = ( mb_rdma_count_c4 >= 4'd8 );

//////////////////////////////////////////////////////////////
//MB_CAM_EN logic in arbctl.
// mbcam is asserted for the following conditions
// * PX2 instruction from the IQ is valid
// * PX2 instruction from the snoop Q is valid.
// * C1 instruction is stalled 
// In case 1 and 2 it is possible that the instruction never got issued
// because of a mbf full condition or a copyback Q full condition.
// However, the miss buffer cam is still asserted speculatively for
// timing reasons. 
// 
// The Hit vector generated by the cam operation is appropriately 
// qualified in mbctl to gate off any false hits due to speculative
// camming.
////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// CAM hit generation: This operation requires forwarding due to 
// the offset between insertion and CAMMING.
//-----------------------------------------------------------------------------
// op A		C1(cam)		C2	C3(enqueue/dequeue)	C4(valid=1/0)
// op B				C1	C2			C3		
// op C					C1			C2
// op D								C1
//-----------------------------------------------------------------------------
// The earliest operation that can see the effects of OP A is OP D. 
// If we want OP B and OP C to see the effects of OP A, we need to forward
// that information while generating mb Hit.
//
// forwarding all the information from a C2 op to a C1 op presents 
// a timing problem. Performing the bypassing in C2 will cause mbctl_hit_c2 to be
// the critical component of the hit_way_vld_c2 signal. One way of solving these
// two problems is to decouple hit_vec_c2 and mbctl_hit_c2 logic cones.
// 
//
// Bypass Logic for hit_vec and hit in C1 and C2.
//
// C1:
// - Bypass all information from C3 to the C1 operation.
// - If the C2 operation is from the Miss Buffer, turn off hit for the
//   entry of the C2 operation.
// 
// C2:
// - If C3 operation inserts, use address match and entry to OR with the result
//   from C1.
// - If C3 operation from the miss buffer, does not delete, use address match
//   and entry to OR with the result from C1.
//
////////////////////////////////////////////////////////////////////////////////

dff_s   #(4)  ff_inst_mb_entry_c2    (.din(arbdp_inst_mb_entry_c1[3:0]), .clk(rclk), 
		.q(inst_mb_entry_c2[3:0]), .se(se), .si(), .so());

assign	dec_mb_entry_c2[0]	= ( inst_mb_entry_c2 == 4'd0 ) ;
assign	dec_mb_entry_c2[1]	= ( inst_mb_entry_c2 == 4'd1 ) ;
assign	dec_mb_entry_c2[2]	= ( inst_mb_entry_c2 == 4'd2 ) ;
assign	dec_mb_entry_c2[3]	= ( inst_mb_entry_c2 == 4'd3 ) ;
assign	dec_mb_entry_c2[4]	= ( inst_mb_entry_c2 == 4'd4 ) ;
assign	dec_mb_entry_c2[5]	= ( inst_mb_entry_c2 == 4'd5 ) ;
assign	dec_mb_entry_c2[6]	= ( inst_mb_entry_c2 == 4'd6 ) ;
assign	dec_mb_entry_c2[7]	= ( inst_mb_entry_c2 == 4'd7 ) ;
assign	dec_mb_entry_c2[8]	= ( inst_mb_entry_c2 == 4'd8 ) ;
assign	dec_mb_entry_c2[9]	= ( inst_mb_entry_c2 == 4'd9 ) ;
assign	dec_mb_entry_c2[10]	= ( inst_mb_entry_c2 == 4'd10 ) ;
assign	dec_mb_entry_c2[11]	= ( inst_mb_entry_c2 == 4'd11 ) ;
assign	dec_mb_entry_c2[12]	= ( inst_mb_entry_c2 == 4'd12 ) ;
assign	dec_mb_entry_c2[13]	= ( inst_mb_entry_c2 == 4'd13 ) ;
assign	dec_mb_entry_c2[14]	= ( inst_mb_entry_c2 == 4'd14 ) ;
assign	dec_mb_entry_c2[15]	= ( inst_mb_entry_c2 == 4'd15 ) ;




/////////////////////////
// HIt vector generation 
/////////////////////////

dff_s   #(1)  ff_l2_dir_map_on_d1(.din(l2_dir_map_on), .clk(rclk),
               .q(l2_dir_map_on_d1), .se(se), .si(), .so());


// miss buffer cam match
assign	mb_cam_hit_vec_c1 = ( mb_cam_match_idx & 
				{16{l2_dir_map_on_d1}} ) |
			     mb_cam_match  ;

// C1-C3 addr match.
assign	mbctl_c1c3_match_c1 = ( idx_c1c3comp_c1 & 
				l2_dir_map_on_d1 ) |
				arbdp_addr_c1c3comp_c1 ;


// C1-c2 addr match.
assign	mbctl_c1c2_match_c1 = ( idx_c1c2comp_c1 & 
				l2_dir_map_on_d1 ) |
				arbdp_addr_c1c2comp_c1 ;

assign	cam_hit_vec_c1 = ( mb_cam_hit_vec_c1 & mb_valid ); // addr or idx match
assign	cam_idx_hit_vec_c1 = ( mb_cam_match_idx & mb_valid );  // idx match only

// turn off hits for a C3 delete and a C2 
// inst from the miss buffer ( speculating that it will cause
// a deletion ).

assign	mbissue_inst_vld_c2 = ( arbdp_inst_mb_c2 & 
			arbctl_mbctl_inst_vld_c2 ) ;

assign	hit_off_bypass_vec_c1 = 
			( dec_mb_entry_c3 & {16{mbf_delete_c3_tmp}} ) | // entry dequeued in C3
    			( dec_mb_entry_c2 & {16{mbissue_inst_vld_c2}}) ; // entry from C2 if from mb

// turn on hits for a insert in C3.

assign	hit_on_bypass_vec_c1 = ( {16{mbctl_c1c3_match_c1}} &  // not qualified with inst vlds.
				 mb_tag_wr_wl_c3_tmp )  ;

assign	idx_on_bypass_vec_c1 = ({16{idx_c1c3comp_c1 }} &
				 mb_tag_wr_wl_c3_tmp ) ;


assign	tmp_cam_hit_vec_c1 = ( cam_hit_vec_c1 | 
				hit_on_bypass_vec_c1 ) & 
				~hit_off_bypass_vec_c1 ;

assign	tmp_idx_hit_vec_c1 = ( cam_idx_hit_vec_c1 | 
				idx_on_bypass_vec_c1 ) & 
				~hit_off_bypass_vec_c1 ;


assign	tmp_cam_hit_c1_3to0 = |( tmp_cam_hit_vec_c1[3:0] ) ;
assign	tmp_cam_hit_c1_7to4 = |( tmp_cam_hit_vec_c1[7:4] ) ;
assign	tmp_cam_hit_c1_11to8 = |( tmp_cam_hit_vec_c1[11:8] ) ;
assign	tmp_cam_hit_c1_15to12 = |( tmp_cam_hit_vec_c1[15:12] ) ;


dff_s   #(1)  ff_tmp_cam_hit_c2_3to0    (.din(tmp_cam_hit_c1_3to0), 
				.clk(rclk), 
		.q(tmp_cam_hit_c2_3to0), .se(se), .si(), .so());

dff_s   #(1)  ff_tmp_cam_hit_c1_7to4    (.din(tmp_cam_hit_c1_7to4), 
				.clk(rclk), 
		.q(tmp_cam_hit_c2_7to4), .se(se), .si(), .so());

dff_s   #(1)  ff_tmp_cam_hit_c2_11to8    (.din(tmp_cam_hit_c1_11to8), 
				.clk(rclk), 
		.q(tmp_cam_hit_c2_11to8), .se(se), .si(), .so());

dff_s   #(1)  ff_tmp_cam_hit_c2_15to12    (.din(tmp_cam_hit_c1_15to12), 
				.clk(rclk), 
		.q(tmp_cam_hit_c2_15to12), .se(se), .si(), .so());

dff_s   #(16)  ff_tmp_cam_hit_vec_c2    (.din(tmp_cam_hit_vec_c1[15:0]), 
				.clk(rclk), 
				.q(tmp_cam_hit_vec_c2[15:0]), 
				.se(se), .si(), .so());

dff_s   #(16)  ff_tmp_idx_hit_vec_c2    (.din(tmp_idx_hit_vec_c1[15:0]), 
				.clk(rclk), 
				.q(tmp_idx_hit_vec_c2[15:0]), 
				.se(se), .si(), .so());

dff_s   #(1)  ff_mbctl_c1c2_match_c1_d1   (.din(mbctl_c1c2_match_c1), 
				.clk(rclk), 
				.q(mbctl_c1c2_match_c1_d1), 
				.se(se), .si(), .so());

dff_s   #(1)  ff_mbctl_c1c2_match_c1_d1_1   (.din(mbctl_c1c2_match_c1), 
				.clk(rclk), 
				.q(mbctl_c1c2_match_c1_d1_1), 
				.se(se), .si(), .so());


dff_s   #(1)  ff_mb_hit_off_c1_d1    (.din(arbctl_mbctl_hit_off_c1), .clk(rclk), 
		.q(mb_hit_off_c1_d1), .se(se), .si(), .so());

/////////////////////////
// HIt generation 
/////////////////////////

assign	hit_vec_qual = ~mb_hit_off_c1_d1 & arbctl_mbctl_inst_vld_c2 ;

assign	mbctl_hit_vec_c2 = {16{hit_vec_qual}} &
		( tmp_cam_hit_vec_c2  | // cam hit + c3 byp
		( {16{mbctl_c1c2_match_c1_d1}} &  mb_tag_wr_wl_c3_tmp )| // C2 insert byp
		( {16{mbctl_c1c2_match_c1_d1 & mb_inst_vld_c3_1 &
		inst_mb_c3 &  ~mbf_delete_c3_tmp}} & dec_mb_entry_c3 )
		) ;	// C2 not delete bypass.

dff_s   #(16)  ff_mbctl_hit_vec_c3    (.din(mbctl_hit_vec_c2[15:0]), .clk(rclk), 
		.q(mbctl_hit_vec_c3[15:0]), .se(se), .si(), .so());



assign	tmp_cam_hit_c2 = ( tmp_cam_hit_c2_3to0 |
			tmp_cam_hit_c2_7to4 |
			tmp_cam_hit_c2_11to8 |
			tmp_cam_hit_c2_15to12 );

// this signal is going to be critical.

assign	tmp_hit_unqual_c2 = 
		( mbctl_c1c2_match_c1_d1_1 & mbf_insert_c3_tmp_1 ) | // C2 insert bypass
		( mbctl_c1c2_match_c1_d1_1 & inst_mb_c3_2 & mb_inst_vld_c3_2 &
		 ~mbf_delete_c3_tmp_1 ) ; // C2 not delete bypass  

assign	mbctl_tagctl_hit_unqual_c2 = (  tmp_hit_unqual_c2  |
				 tmp_cam_hit_c2 ) & ~mb_hit_off_c1_d1 ;  // cam hit + c3 bypass

assign	mbctl_hit_c2 =  mbctl_tagctl_hit_unqual_c2 
			& arbctl_mbctl_inst_vld_c2 ;


/////////////////////////
// IDX HIt generation 
// used for generating mbfull
/////////////////////////


dff_s   #(1)  ff_idx_c1c2comp_c1_d1   (.din(idx_c1c2comp_c1), 
				.clk(rclk), 
				.q(idx_c1c2comp_c1_d1), 
				.se(se), .si(), .so());


assign	idx_hit_vec_qual = ~mb_hit_off_c1_d1 & arbctl_mbctl_inst_vld_c2 ;

assign	mbctl_idx_hit_vec_c2 = {16{idx_hit_vec_qual}} &
		(   tmp_idx_hit_vec_c2 | 	// cam hit + c3 byp
		( {16{idx_c1c2comp_c1_d1}} & mb_tag_wr_wl_c3_tmp )| // C2 insert byp
		( {16{idx_c1c2comp_c1_d1 & mb_inst_vld_c3_1 &
		 inst_mb_c3 &  ~mbf_delete_c3_tmp}} & dec_mb_entry_c3 )) ;// C2 not delete bypass.

dff_s   #(16)  ff_mbctl_idx_hit_vec_c3    (.din(mbctl_idx_hit_vec_c2[15:0]), .clk(rclk), 
		.q(mbctl_idx_hit_vec_c3[15:0]), .se(se), .si(), .so());


/////////////////////////
// Adder to add 16 bits from
// hit_vec_c3
/////////////////////////



/////////////////////////////
// STAGE1
////////////////////////////
adder_1b	bit0_2(
                 // Outputs
                 .cout                  (cout1[1]),
                 .sum                   (cout1[0]),
                 // Inputs
                 .oper1                 (mbctl_idx_hit_vec_c3[0]),
                 .oper2                 (mbctl_idx_hit_vec_c3[1]),
                 .cin                   (mbctl_idx_hit_vec_c3[2]));

adder_1b	bit3_5(
                 // Outputs
                 .cout                  (cout2[1]),
                 .sum                   (cout2[0]),
                 // Inputs
                 .oper1                 (mbctl_idx_hit_vec_c3[3]),
                 .oper2                 (mbctl_idx_hit_vec_c3[4]),
                 .cin                   (mbctl_idx_hit_vec_c3[5]));

adder_1b	bit6_8(
                 // Outputs
                 .cout                  (cout3[1]),
                 .sum                   (cout3[0]),
                 // Inputs
                 .oper1                 (mbctl_idx_hit_vec_c3[6]),
                 .oper2                 (mbctl_idx_hit_vec_c3[7]),
                 .cin                   (mbctl_idx_hit_vec_c3[8]));

adder_1b	bit9_11(
                 // Outputs
                 .cout                  (cout4[1]),
                 .sum                   (cout4[0]),
                 // Inputs
                 .oper1                 (mbctl_idx_hit_vec_c3[9]),
                 .oper2                 (mbctl_idx_hit_vec_c3[10]),
                 .cin                   (mbctl_idx_hit_vec_c3[11]));

adder_1b	bit12_14(
                 // Outputs
                 .cout                  (cout5[1]),
                 .sum                   (cout5[0]),
                 // Inputs
                 .oper1                 (mbctl_idx_hit_vec_c3[12]),
                 .oper2                 (mbctl_idx_hit_vec_c3[13]),
                 .cin                   (mbctl_idx_hit_vec_c3[14]));

/////////////////////////////
// STAGE2
////////////////////////////


adder_2b	bits0_5(
                  // Outputs
                  .sum                  (cout2_1[1:0]),
                  .cout                 (cout2_1[2]),
                  // Inputs
                  .oper1                (cout1[1:0]),
                  .oper2                (cout2[1:0]),
                  .cin                  (mbctl_idx_hit_vec_c3[15]));


adder_2b	bits6_11(
                  // Outputs
                  .sum                  (cout2_2[1:0]),
                  .cout                 (cout2_2[2]),
                  // Inputs
                  .oper1                (cout3[1:0]),
                  .oper2                (cout4[1:0]),
                  .cin                  (1'b0));


adder_2b	bits12_16(
                  // Outputs
                  .sum                  (cout2_3[1:0]),
                  .cout                 (cout2_3[2]),
                  // Inputs
                  .oper1                (cout5[1:0]),
                  .oper2                (2'b0),
                  .cin                  (1'b0));


/////////////////////////////
// STAGE3
////////////////////////////


adder_3b	bits0_10(
                   // Outputs
                   .sum                 (cout3_tmp[2:0]),
                   .cout                (cout3_tmp[3]),
                   // Inputs
                   .oper1               (cout2_1[2:0]),
                   .oper2               (cout2_2[2:0]),
                   .cin                 (1'b0));

/////////////////////////////
// STAGE3.5
////////////////////////////

adder_4b        bits0_15(
                   // Outputs
                   .sum                 (cout3_final[3:0]),
                   .cout                (cout3_final[4]),
                   // Inputs
                   .oper1               (cout3_tmp[3:0]),
                   .oper2               ({1'b0, cout2_3[2:0]}),
                   .cin                 (1'b0));

//////////////////////////////////////////////////////////////////////////////
// If an instruction encounters 7 or more hits in the Miss buffer to the
// same index, the pipe is stalled and miss buffer full is asserted by
// arbctl until the miss buffer count drops to 7
//////////////////////////////////////////////////////////////////////////////

dff_s   #(5)  ff_hit_count_c4    (.din(cout3_final[4:0]), .clk(rclk), 
			.q(hit_count_c4[4:0]), .se(se), .si(), .so());

// hit count = 7 or greater
assign	set_mb_idx_full_c4 = hit_count_c4[3] | hit_count_c4[4] |
		( hit_count_c4[2] & hit_count_c4[1] & hit_count_c4[0] );

// miss buffer count is 7 or less 
assign	reset_mb_idx_full_c4 = ~mb_count_c4[3] & ~mb_count_c4[4]  ;
		      


assign	mb_idx_count_full_c4 = ( mb_idx_count_full_c5 | 
			set_mb_idx_full_c4 )
			& ~reset_mb_idx_full_c4  ;

dffrl_s   #(1)  ff_mb_idx_count_full_c5    (.din(mb_idx_count_full_c4), .clk(rclk), 
			.q(mb_idx_count_full_c5), .se(se), 
			.si(), .so(), .rst_l(dbb_rst_l));




//////////////////////////////////////////////////////////////////////////////
// mbdata Insertion 
// Write the miss Buffer data array in the C9 cycle of the  following types of
// instructions:
// 1) Miss Buffer instruction that is not deleted in C3
// 2) Iq instr instruction that is inserted in the Miss Buffer.
//////////////////////////////////////////////////////////////////////////////

dff_s   #(1)  ff_inst_mb_c3    (.din(arbdp_inst_mb_c2), .clk(rclk), 
			.q(inst_mb_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_mb_c3_2    (.din(arbdp_inst_mb_c2), .clk(rclk), 
			.q(inst_mb_c3_2), .se(se), .si(), .so());

dff_s   #(1)  ff_mb_inst_vld_c3 (.din(arbctl_mbctl_inst_vld_c2), .clk(rclk), 
			.q(mb_inst_vld_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_mb_inst_vld_c3_1 (.din(arbctl_mbctl_inst_vld_c2), .clk(rclk), 
			.q(mb_inst_vld_c3_1), .se(se), .si(), .so());

dff_s   #(1)  ff_mb_inst_vld_c3_2 (.din(arbctl_mbctl_inst_vld_c2), .clk(rclk), 
			.q(mb_inst_vld_c3_2), .se(se), .si(), .so());


assign	mb_rewrite_en_c3 =  (  inst_mb_c3 &  
				~mbf_delete_c3 &
                                 mb_inst_vld_c3_1 ) ;

dff_s   #(1)  ff_mb_rewrite_en_c4    (.din(mb_rewrite_en_c3), .clk(rclk), 
			.q(mb_rewrite_en_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_mb_rewrite_en_c5    (.din(mb_rewrite_en_c4), .clk(rclk), 
			.q(mb_rewrite_en_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_mb_rewrite_en_c6    (.din(mb_rewrite_en_c5), .clk(rclk), 
			.q(mb_rewrite_en_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_mb_rewrite_en_c7    (.din(mb_rewrite_en_c6), .clk(rclk), 
			.q(mb_rewrite_en_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_mb_rewrite_en_c8    (.din(mb_rewrite_en_c7), .clk(rclk), 
			.q(mb_rewrite_en_c8), .se(se), .si(), .so());


assign	mbdata_wr_en_c3 = ( mbf_insert_c3 | mb_rewrite_en_c3 ) ;

dff_s   #(1)  ff_mbdata_wr_en_c4    (.din(mbdata_wr_en_c3), .clk(rclk), 
			.q(mbdata_wr_en_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_mbdata_wr_en_c5    (.din(mbdata_wr_en_c4), .clk(rclk), 
			.q(mbdata_wr_en_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_mbdata_wr_en_c6    (.din(mbdata_wr_en_c5), .clk(rclk), 
			.q(mbdata_wr_en_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_mbdata_wr_en_c7    (.din(mbdata_wr_en_c6), .clk(rclk), 
			.q(mbdata_wr_en_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_mbdata_wr_en_c8    (.din(mbdata_wr_en_c7), .clk(rclk), 
			.q(mbdata_wr_en_c8), .se(se), .si(), .so());


//////////////////////////////////////////////////////////////////////////////
// mbdata wr wordline 
// The wordline chosen for a write into MBDATA is either of the following
// * wordline that just got inserted.
// * wordline that just got reinserted
// * Wordline of the dependent instruction ( Used only to RDY a  CAS2 instruction
//  and not to write into mbdata )
//////////////////////////////////////////////////////////////////////////////

assign  enc_tag_wr_wl_c2[0] = ( mb_write_ptr_c2[1] | mb_write_ptr_c2[3] |
                                mb_write_ptr_c2[5] | mb_write_ptr_c2[7] |
                                mb_write_ptr_c2[9] | mb_write_ptr_c2[11] |
                                mb_write_ptr_c2[13] | mb_write_ptr_c2[15]
                               );

assign  enc_tag_wr_wl_c2[1] = ( mb_write_ptr_c2[2] | mb_write_ptr_c2[3] |
                                mb_write_ptr_c2[6] | mb_write_ptr_c2[7] |
                                mb_write_ptr_c2[10] | mb_write_ptr_c2[11] |
                                mb_write_ptr_c2[14] | mb_write_ptr_c2[15]
                                        );

assign  enc_tag_wr_wl_c2[2] = ( mb_write_ptr_c2[4] | mb_write_ptr_c2[5] |
                                mb_write_ptr_c2[6] | mb_write_ptr_c2[7] |
                                mb_write_ptr_c2[12] | mb_write_ptr_c2[13] |
                                mb_write_ptr_c2[14] | mb_write_ptr_c2[15]
                                );

assign  enc_tag_wr_wl_c2[3] = ( mb_write_ptr_c2[8] | mb_write_ptr_c2[9] |
                                mb_write_ptr_c2[10] | mb_write_ptr_c2[11] |
                                mb_write_ptr_c2[12] | mb_write_ptr_c2[13] |
                                mb_write_ptr_c2[14] | mb_write_ptr_c2[15]
                                );

dff_s   #(4)  ff_enc_tag_wr_wl_c3    (.din(enc_tag_wr_wl_c2[3:0]), .clk(rclk), 
			.q(enc_tag_wr_wl_c3[3:0]), .se(se), .si(), .so());

mux3ds  #(4) mux_enc_data_wr_wl_c3  (.dout(enc_data_wr_wl_c3[3:0]),
                                .in0(enc_tag_wr_wl_c3[3:0]), // inserting entry in C3
                                .in1(mb_entry_c3[3:0]), // reinserting entry in C3
                                .in2(mbctl_next_link_c3[3:0]),// depdendent of C3 instruction
                                .sel0(mbf_insert_c3),
                                .sel1(mb_rewrite_en_c3),
                                .sel2(~mbdata_wr_en_c3));


assign	mbctl_wbctl_mbid_c4 = enc_data_wr_wl_c4 ;

dff_s   #(4)  ff_enc_data_wr_wl_c4    (.din(enc_data_wr_wl_c3[3:0]), .clk(rclk), 
			.q(enc_data_wr_wl_c4[3:0]), .se(se), .si(), .so());

dff_s   #(4)  ff_enc_data_wr_wl_c5    (.din(enc_data_wr_wl_c4[3:0]), .clk(rclk), 
			.q(enc_data_wr_wl_c5[3:0]), .se(se), .si(), .so());

dff_s   #(4)  ff_enc_data_wr_wl_c6    (.din(enc_data_wr_wl_c5[3:0]), .clk(rclk), 
			.q(enc_data_wr_wl_c6[3:0]), .se(se), .si(), .so());

dff_s   #(4)  ff_enc_data_wr_wl_c7    (.din(enc_data_wr_wl_c6[3:0]), .clk(rclk), 
			.q(enc_data_wr_wl_c7[3:0]), .se(se), .si(), .so());

dff_s   #(4)  ff_enc_data_wr_wl_c8    (.din(enc_data_wr_wl_c7[3:0]), .clk(rclk), 
			.q(enc_data_wr_wl_c8[3:0]), .se(se), .si(), .so());

dff_s   #(4)  ff_enc_data_wr_wl_c9    (.din(enc_data_wr_wl_c8[3:0]), .clk(rclk), 
			.q(enc_data_wr_wl_c9[3:0]), .se(se), .si(), .so());


//assign  insert_ptr_c8[0] =  ( enc_data_wr_wl_c8 == 4'd0 ) ;
//assign  insert_ptr_c8[1] =  ( enc_data_wr_wl_c8 == 4'd1 ) ;
//assign  insert_ptr_c8[2] =  ( enc_data_wr_wl_c8 == 4'd2 ) ;
//assign  insert_ptr_c8[3] =  ( enc_data_wr_wl_c8 == 4'd3 ) ;
//assign  insert_ptr_c8[4] =  ( enc_data_wr_wl_c8 == 4'd4 ) ;
//assign  insert_ptr_c8[5] =  ( enc_data_wr_wl_c8 == 4'd5 ) ;
//assign  insert_ptr_c8[6] =  ( enc_data_wr_wl_c8 == 4'd6 ) ;
//assign  insert_ptr_c8[7] =  ( enc_data_wr_wl_c8 == 4'd7 ) ;
//assign  insert_ptr_c8[8] =  ( enc_data_wr_wl_c8 == 4'd8 ) ;
//assign  insert_ptr_c8[9] =  ( enc_data_wr_wl_c8 == 4'd9 ) ;
//assign  insert_ptr_c8[10] = ( enc_data_wr_wl_c8 == 4'd10 ) ;
//assign  insert_ptr_c8[11] = ( enc_data_wr_wl_c8 == 4'd11 ) ;
//assign  insert_ptr_c8[12] = ( enc_data_wr_wl_c8 == 4'd12 ) ;
//assign  insert_ptr_c8[13] = ( enc_data_wr_wl_c8 == 4'd13 ) ;
//assign  insert_ptr_c8[14] = ( enc_data_wr_wl_c8 == 4'd14 ) ;
//assign  insert_ptr_c8[15] = ( enc_data_wr_wl_c8 == 4'd15 ) ;


assign dec_low_insert_ptr[0] = ( enc_data_wr_wl_c8[1:0] == 2'd0 );
assign dec_low_insert_ptr[1] = ( enc_data_wr_wl_c8[1:0] == 2'd1 );
assign dec_low_insert_ptr[2] = ( enc_data_wr_wl_c8[1:0] == 2'd2 );
assign dec_low_insert_ptr[3] = ( enc_data_wr_wl_c8[1:0] == 2'd3 );

assign dec_hi_insert_ptr[0] = ( enc_data_wr_wl_c8[3:2] == 2'd0 );
assign dec_hi_insert_ptr[1] = ( enc_data_wr_wl_c8[3:2] == 2'd1 );
assign dec_hi_insert_ptr[2] = ( enc_data_wr_wl_c8[3:2] == 2'd2 );
assign dec_hi_insert_ptr[3] = ( enc_data_wr_wl_c8[3:2] == 2'd3 );


assign	insert_ptr_c8[0] = ( dec_hi_insert_ptr[0] & 
				dec_low_insert_ptr[0] ) ;
assign	insert_ptr_c8[1] = ( dec_hi_insert_ptr[0] & 
				dec_low_insert_ptr[1] ) ;
assign	insert_ptr_c8[2] = ( dec_hi_insert_ptr[0] & 
				dec_low_insert_ptr[2] ) ;
assign	insert_ptr_c8[3] = ( dec_hi_insert_ptr[0] & 
				dec_low_insert_ptr[3] ) ;

assign	insert_ptr_c8[4] = ( dec_hi_insert_ptr[1] & 
				dec_low_insert_ptr[0] ) ;
assign	insert_ptr_c8[5] = ( dec_hi_insert_ptr[1] & 
				dec_low_insert_ptr[1] ) ;
assign	insert_ptr_c8[6] = ( dec_hi_insert_ptr[1] & 
				dec_low_insert_ptr[2] ) ;
assign	insert_ptr_c8[7] = ( dec_hi_insert_ptr[1] & 
				dec_low_insert_ptr[3] ) ;

assign	insert_ptr_c8[8] = ( dec_hi_insert_ptr[2] & 
				dec_low_insert_ptr[0] ) ;
assign	insert_ptr_c8[9] = ( dec_hi_insert_ptr[2] & 
				dec_low_insert_ptr[1] ) ;
assign	insert_ptr_c8[10] = ( dec_hi_insert_ptr[2] & 
				dec_low_insert_ptr[2] ) ;
assign	insert_ptr_c8[11] = ( dec_hi_insert_ptr[2] & 
				dec_low_insert_ptr[3] ) ;

assign	insert_ptr_c8[12] = ( dec_hi_insert_ptr[3] & 
				dec_low_insert_ptr[0] ) ;
assign	insert_ptr_c8[13] = ( dec_hi_insert_ptr[3] & 
				dec_low_insert_ptr[1] ) ;
assign	insert_ptr_c8[14] = ( dec_hi_insert_ptr[3] & 
				dec_low_insert_ptr[2] ) ;
assign	insert_ptr_c8[15] = ( dec_hi_insert_ptr[3] & 
				dec_low_insert_ptr[3] ) ;


assign  mb_data_wr_wl_c8  = insert_ptr_c8 & {16{mbdata_wr_en_c8}} ;

assign  mb_data_write_wl = mb_data_wr_wl_c8 ; 

assign	mbctl_mbentry_c8 = enc_data_wr_wl_c8 ;

//////////////////////////////////////////////////////////////////////////////
// DEP bit is used by the st ack logic to send an ACK for a store issued
// out of the Miss Buffer.
// 
// THis bit is set
// - if an instruction hits the Miss Buffer
// - an instruction from the Miss Buffer encountering a tag par err.
// - an instruction from the Miss Buffer with tecc=1
// - an instruction from the IQ  encountering a tag parity error.
//////////////////////////////////////////////////////////////////////////////


assign	mbctl_dep_inst_c2 =  mbctl_hit_c2 ;

dff_s   #(1)  ff_mbf_dep_c3    (.din(mbctl_dep_inst_c2), .clk(rclk),
             .q(mbctl_dep_inst_c3_tmp), .se(se), .si(), .so());

// the following signal represents the DEP bit of an instr.
dff_s   #(1)  ff_dep_inst_c3    (.din(arbdp_inst_dep_c2), .clk(rclk),
             .q(dep_inst_c3), .se(se), .si(), .so());

// the following signal represents the TECC bit of an instr.
dff_s   #(1)  ff_tecc_c3    (.din(arbctl_tecc_c2), .clk(rclk),
             .q(tecc_c3), .se(se), .si(), .so());

assign	mbctl_dep_inst_c3 = mbctl_dep_inst_c3_tmp |  // if mbf hit set DEP
			( dep_inst_c3 & tagctl_mbctl_par_err_c3 & ~tagctl_hit_unqual_c3 ) | // if a tagpar do not reset DEP
			( dep_inst_c3 & tecc_c3 ) |  // if a tag scrub, do not reset DEP
			( ~inst_mb_c3 & tagctl_mbctl_par_err_c3  & ~tagctl_hit_unqual_c3) ; // if a tagpar set DEP

dff_s   #(1)  ff_mbf_dep_c4    (.din(mbctl_dep_inst_c3), .clk(rclk),
             .q(mbctl_dep_inst_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_mbf_dep_c5    (.din(mbctl_dep_inst_c4), .clk(rclk),
             .q(mbctl_dep_inst_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_mbf_dep_c6    (.din(mbctl_dep_inst_c5), .clk(rclk),
             .q(mbctl_dep_inst_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_mbf_dep_c7    (.din(mbctl_dep_inst_c6), .clk(rclk),
             .q(mbctl_dep_inst_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_mbf_dep_c8    (.din(mbctl_dep_inst_c7), .clk(rclk),
             .q(mbctl_dep_c8), .se(se), .si(), .so());

//////////////////////////////////////////////////////////////////////////////
// EVICT bit in MBdata
//  The evict bit is set for a "true miss" to indicate that its
//  next pass is going to cause an EVICTION. The EVICT bit is reset
//  when an evict instruction makes a pass down the Pipe.
// Tecc cases are exception cases: EVICT bit is not reset for an evict
// instruction pass if that pass encounters a TECC error.
//////////////////////////////////////////////////////////////////////////////


assign	buffer_miss_vld_c2 = ~mbctl_tagctl_hit_unqual_c2 &
				~fbctl_mbctl_match_c2 &
				~wbctl_hit_unqual_c2 &
				~rdmatctl_hit_unqual_c2 &
				arbctl_mbctl_inst_vld_c2 ;
assign	mbctl_mark_evict_tmp_c2 = 
			 tagctl_miss_unqual_c2 & // 0 for an evict instruction
			 buffer_miss_vld_c2 ;

dff_s   #(1)  ff_mbctl_mark_evict_tmp_c3    
		(.din(mbctl_mark_evict_tmp_c2), .clk(rclk),
             .q(mbctl_mark_evict_tmp_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_evict_vld_unqual_c3    (.din(arbctl_evict_vld_c2), .clk(rclk),
             .q(evict_vld_unqual_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_decdp_wr64_inst_c3    (.din(decdp_wr64_inst_c2), .clk(rclk),
             .q(wr64_inst_c3), .se(se), .si(), .so());


dff_s   #(1)  ff_decdp_ld64_inst_c3    (.din(decdp_ld64_inst_c2), .clk(rclk),
             .q(ld64_inst_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_ld64_inst_c4    (.din(ld64_inst_c3), .clk(rclk),
             .q(ld64_inst_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_ld64_inst_c5    (.din(ld64_inst_c4), .clk(rclk),
             .q(ld64_inst_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_ld64_inst_c6    (.din(ld64_inst_c5), .clk(rclk),
             .q(ld64_inst_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_ld64_inst_c7    (.din(ld64_inst_c6), .clk(rclk),
             .q(ld64_inst_c7), .se(se), .si(), .so());

assign	mbctl_mark_dram_rdy_c3 = ( mbctl_mark_evict_tmp_c3 &
		~wr64_inst_c3 & // do not set EVICT for a wr64 instruction
		~tagctl_mbctl_par_err_c3 ) ;  // a par err will gate setting of EVICT

dff_s   #(1)  ff_dram_rdy_c4    (.din(mbctl_mark_dram_rdy_c3), .clk(rclk),
             .q(dram_rdy_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_dram_rdy_c5    (.din(dram_rdy_c4), .clk(rclk),
             .q(dram_rdy_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_dram_rdy_c6    (.din(dram_rdy_c5), .clk(rclk),
             .q(dram_rdy_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_dram_rdy_c7    (.din(dram_rdy_c6), .clk(rclk),
             .q(dram_rdy_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_dram_rdy_c8    (.din(dram_rdy_c7), .clk(rclk),
             .q(dram_rdy_c8), .se(se), .si(), .so());


// If an eviction packet encounters a tag parity error,
// the EVICT bit needs to be set again so that the instruction
// can make an eviction pass after the tag has been 
// repaired.
//
// Similarly if an evict packet is issued with tecc=1 
// the evict_ready bit needs to be set again for that packet.
// Both the above cases are covered in the expression for
// evict_par_err_c3


dff_s   #(1)  ff_evict_par_err_c3    (.din(arbctl_evict_tecc_vld_c2), .clk(rclk),
             .q(evict_tecc_vld_c3), .se(se), .si(), .so());

assign  evict_par_err_c3 = ( evict_vld_unqual_c3 & tagctl_mbctl_par_err_c3)  |
				evict_tecc_vld_c3;

dff_s   #(1)  ff_evict_par_err_c4    (.din(evict_par_err_c3), .clk(rclk),
             .q(evict_par_err_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_evict_par_err_c5    (.din(evict_par_err_c4), .clk(rclk),
             .q(evict_par_err_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_evict_par_err_c6    (.din(evict_par_err_c5), .clk(rclk),
             .q(evict_par_err_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_evict_par_err_c7    (.din(evict_par_err_c6), .clk(rclk),
             .q(evict_par_err_c7), .se(se), .si(), .so());


// all ld64 are no_fill instructions.

// The following expression for the EVICT bit  is used for
// causing an eviction pass. It is not used for making a
// request to DRAM. Hence, if we want to turn off the eviction
// pass while not turning off requests to DRAM, this is the place
// to do it.

assign	mbctl_evict_c7 = ( dram_rdy_c7 
			& ~ld64_inst_c7  // LD 64 no fill
			& ~l2_bypass_mode_on_d1) // L2 off
			| evict_par_err_c7 ;  

dff_s   #(1)  ff_mbctl_evict_c8    (.din(mbctl_evict_c7), .clk(rclk),
             .q(mbctl_evict_c8), .se(se), .si(), .so());

//////////////////////////////////////////////////////////////////////////////
// The Code in this section handles a RDMA instruction completion.
// i.e. if an instruction is not able to complete because of
// "rdma_reg_vld" being high, this logic will enable the READY
// condition for such an instruction that gets inserted in 
// the Miss Buffer. 
// 
// 
// Completion of a wr64  is signalled if it misses 
// everything ( $, FB WBB and RDMAT). Remember that 
// the tagctl_miss_unqual_c2 is already qualified with
// ~tagctl_rdma_reg_vld so completion is actually off
// when that signal is high.
//////////////////////////////////////////////////////////////////////////////


// removed  the tagctl_mbctl_par_err_c3 for timing reasons.
// THe following signal will be transmitted to tagctl 
// where it is used after qualification with *par_err_c3.

assign	mbctl_wr64_miss_comp_c3 = mbctl_mark_evict_tmp_c3 & 
	//////			~tagctl_mbctl_par_err_c3 &  
				wr64_inst_c3 ;

dff_s   #(1)  ff_buffer_miss_vld_c3    (.din(buffer_miss_vld_c2), .clk(rclk),
             .q(buffer_miss_vld_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_rdma_reg_vld_c3    (.din(mbctl_rdma_reg_vld_c2), .clk(rclk),
             .q(rdma_reg_vld_c3), .se(se), .si(), .so());

assign	wr64_miss_not_comp_c3 = buffer_miss_vld_c3 &
				alt_tagctl_miss_unqual_c3 & 
				~tagctl_mbctl_par_err_c3 & 
				wr64_inst_c3 &
				rdma_reg_vld_c3;

assign	rdma_comp_rdy_c3 = ( wr64_miss_not_comp_c3 | tagctl_hit_not_comp_c3 ) ;

dff_s   #(1)  ff_rdma_comp_rdy_c4    (.din(rdma_comp_rdy_c3), .clk(rclk),
             .q(rdma_comp_rdy_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_rdma_comp_rdy_c5    (.din(rdma_comp_rdy_c4), .clk(rclk),
             .q(rdma_comp_rdy_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_rdma_comp_rdy_c6    (.din(rdma_comp_rdy_c5), .clk(rclk),
             .q(rdma_comp_rdy_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_rdma_comp_rdy_c7    (.din(rdma_comp_rdy_c6), .clk(rclk),
             .q(rdma_comp_rdy_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_rdma_comp_rdy_c8    (.din(rdma_comp_rdy_c7), .clk(rclk),
             .q(rdma_comp_rdy_c8), .se(se), .si(), .so());

//////////////////////////////////////////////////////////////////////////////
// TECC bit in MBdata:
//	The TECC bit is set in mbdata if a tag parity is encountered for an
//  	instruction that writes/rewrites into the miss Buffer.
// This bit is used to cause a scrub when the instruction is reissued.
//////////////////////////////////////////////////////////////////////////////


assign	mbctl_tecc_c3 = tagctl_mbctl_par_err_c3 & 
			~tagctl_hit_unqual_c3 &
			buffer_miss_vld_c3; // a hit in any of the buffers
					    // triggers an alternate ready mechanism
					    // that might set L2 ready 
					    // Hence, tecc_ready setting needs to
					    // be disabled in this case.

dff_s   #(1)  ff_mbctl_tecc_c4    (.din(mbctl_tecc_c3), .clk(rclk),
             .q(mbctl_tecc_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_mbctl_tecc_c5    (.din(mbctl_tecc_c4), .clk(rclk),
             .q(mbctl_tecc_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_mbctl_tecc_c6    (.din(mbctl_tecc_c5), .clk(rclk),
             .q(mbctl_tecc_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_mbctl_tecc_c7    (.din(mbctl_tecc_c6), .clk(rclk),
             .q(mbctl_tecc_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_mbctl_tecc_c8    (.din(mbctl_tecc_c7), .clk(rclk),
             .q(mbctl_tecc_c8), .se(se), .si(), .so());

///////////////////////////////////////////////////////
// VALID bit : set on insertion and reset on deletion
///////////////////////////////////////////////////////

dffrl_s   #(16)  ff_mb_write_ptr_c3    (.din(mb_write_ptr_c2[15:0]), .clk(rclk),
			.rst_l(dbb_rst_l),
                     .q(mb_write_ptr_c3[15:0]), .se(se), .si(), .so());

assign	mb_tag_wr_wl_c3 = mb_write_ptr_c3 & {16{mbf_insert_c3}} ;
assign	mb_tag_wr_wl_c3_tmp = mb_write_ptr_c3 & {16{mbf_insert_c3_tmp}} ;

dff_s   #(4)  ff_mb_entry_c3    (.din(inst_mb_entry_c2[3:0]), .clk(rclk),
                       .q(mb_entry_c3[3:0]), .se(se), .si(), .so());

dff_s   #(4)  ff_mb_entry_c3_1    (.din(inst_mb_entry_c2[3:0]), .clk(rclk),
                       .q(mb_entry_c3_1[3:0]), .se(se), .si(), .so());

assign	dec_mb_entry_c3[0]	= ( mb_entry_c3_1 == 4'd0 ) ;
assign	dec_mb_entry_c3[1]	= ( mb_entry_c3_1 == 4'd1 ) ;
assign	dec_mb_entry_c3[2]	= ( mb_entry_c3_1 == 4'd2 ) ;
assign	dec_mb_entry_c3[3]	= ( mb_entry_c3_1 == 4'd3 ) ;
assign	dec_mb_entry_c3[4]	= ( mb_entry_c3_1 == 4'd4 ) ;
assign	dec_mb_entry_c3[5]	= ( mb_entry_c3_1 == 4'd5 ) ;
assign	dec_mb_entry_c3[6]	= ( mb_entry_c3_1 == 4'd6 ) ;
assign	dec_mb_entry_c3[7]	= ( mb_entry_c3_1 == 4'd7 ) ;
assign	dec_mb_entry_c3[8]	= ( mb_entry_c3_1 == 4'd8 ) ;
assign	dec_mb_entry_c3[9]	= ( mb_entry_c3_1 == 4'd9 ) ;
assign	dec_mb_entry_c3[10]	= ( mb_entry_c3_1 == 4'd10 ) ;
assign	dec_mb_entry_c3[11]	= ( mb_entry_c3_1 == 4'd11 ) ;
assign	dec_mb_entry_c3[12]	= ( mb_entry_c3_1 == 4'd12 ) ;
assign	dec_mb_entry_c3[13]	= ( mb_entry_c3_1 == 4'd13 ) ;
assign	dec_mb_entry_c3[14]	= ( mb_entry_c3_1 == 4'd14 ) ;
assign	dec_mb_entry_c3[15]	= ( mb_entry_c3_1 == 4'd15 ) ;

// Used by fbctl since this is the same as fill entry.

assign	reset_valid_bit_c3 = ( dec_mb_entry_c3 & {16{mbf_delete_c3}} ) ;

assign	mb_valid_prev = ( mb_tag_wr_wl_c3 | mb_valid ) & ~reset_valid_bit_c3 ;

dffrl_s   #(16)  ff_valid_bit    (.din(mb_valid_prev[15:0]), .clk(rclk), 
	.rst_l(dbb_rst_l), .q(mb_valid[15:0]), .se(se), .si(), .so());


///////////////////////////////////////////////////////
// RDMA bit : set on insertion of a RDMA instruction 
//	and reset on deletion
// used only for purposes of picking an instruction
// in the Miss Buffer.
///////////////////////////////////////////////////////


assign 	mb_rdma_prev = (( mb_tag_wr_wl_c3 & {16{rdma_inst_c3}} ) |
			 mb_rdma ) & ~reset_valid_bit_c3 ;

dffrl_s   #(16)  ff_rdma_bit    (.din(mb_rdma_prev[15:0]), .clk(rclk), 
	.rst_l(dbb_rst_l), .q(mb_rdma[15:0]), .se(se), .si(), .so());


///////////////////////////////////////////////////////
// BIS bit : set on insertion of a BIS instruction
//      and reset on deletion
// used to assert a dummy request to DRAM 
///////////////////////////////////////////////////////

assign  mb_bis_prev = (( mb_tag_wr_wl_c3 & {16{decdp_bis_inst_c3}} ) 
			| mb_bis ) & ~reset_valid_bit_c3 ;

dffrl_s   #(16)  ff_bis_bit    (.din(mb_bis_prev[15:0]), .clk(rclk),
        .rst_l(dbb_rst_l), .q(mb_bis[15:0]), .se(se), .si(), .so());


//////////////////////////////////////////////////////////////////////////
// DRAM READY  bit : set on insertion/reinsertion
//		 of a "true miss" in C8.
//		and reset on a PICK for dram issue.
// The reason the dram_ready bit is set in C7 is as follows:
// 
// ------------------------------------------------------------------------
// #1		#2(C8)		#3(C9)		#4((c10)	#5(c11)
// ------------------------------------------------------------------------
// dram_ready	dram_pick_prev	dram_pick	read		req
// set							
//								write
//								fbtag.
//								other
//								fb fields.
// --------------------------------------------------------------------------
// fbtagecc and other fields of fb come from mbdata.
// mbdata gets written in c9. Hence it cannot be read before
// c10.
// This required cycle #4 to correspond to c10.
//////////////////////////////////////////////////////////////////////////

 assign	dram_ready_set_c8 = ( insert_ptr_c8 & {16{mbdata_wr_en_c8 
					& dram_rdy_c8}}  ) ;

 assign	reset_dram_ready = ( picker_out & {16{dram_pick}} ) ;

 assign	mb_dram_ready_in = ( mb_dram_ready | dram_ready_set_c8 ) &
				~( reset_dram_ready ) ;

 dffrl_s   #(16)  ff_dram_ready_bit    (.din(mb_dram_ready_in[15:0]), .clk(rclk), 
	.rst_l(dbb_rst_l), .q(mb_dram_ready[15:0]), .se(se), .si(), .so());


			

/////////////////////////////////////////////////////////////////
// YOUNG bit : Denotes the Youngest MB entry for that address.
// 
// Set in the C3 cycle of non-dependent insertion and reset
// in the C3 cycle of an instruction hitting a young miss Buffer
// entry.Also reset on dequeue.
/////////////////////////////////////////////////////////////////

assign	mb_young_prev = ( mb_tag_wr_wl_c3 | mb_young ) &
			~( mbctl_hit_vec_c3 | reset_valid_bit_c3 ) ;

dffrl_s   #(16)  ff_young_bit    (.din(mb_young_prev[15:0]), .clk(rclk), 
	.rst_l(dbb_rst_l), .q(mb_young[15:0]), .se(se), .si(), .so());

/////////////////////////////////////////////////////////////////
// NEXT LINK Field : Denotes the next(agewise) dependent's miss buffer
//		    ID.
// 
// Set in the C3 cycle of dependents insertion into the Miss Buffer.
// However next link is set for the older entry and not for the inserting
// entry.
/////////////////////////////////////////////////////////////////

assign	next_link_wr_en_c3  = mb_young & mbctl_hit_vec_c3 ;


dffe_s   #(4)  ff_next_link0    ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[0]),
                        .clk(rclk), .q(next_link_entry0[3:0]),
			     .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link1 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[1]),
                        .clk(rclk), .q(next_link_entry1[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link2 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[2]),
                        .clk(rclk), .q(next_link_entry2[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link3 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[3]),
                        .clk(rclk), .q(next_link_entry3[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link4 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[4]),
                        .clk(rclk), .q(next_link_entry4[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link5 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[5]),
                        .clk(rclk), .q(next_link_entry5[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link6 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[6]),
                        .clk(rclk), .q(next_link_entry6[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link7 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[7]),
                        .clk(rclk), .q(next_link_entry7[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link8 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[8]),
                        .clk(rclk), .q(next_link_entry8[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link9 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[9]),
                        .clk(rclk), .q(next_link_entry9[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link10 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[10]),
                        .clk(rclk), .q(next_link_entry10[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link11 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[11]),
                        .clk(rclk), .q(next_link_entry11[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link12 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[12]),
                        .clk(rclk), .q(next_link_entry12[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link13 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[13]),
                        .clk(rclk), .q(next_link_entry13[3:0]),
                        .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link14 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[14]),
                        .clk(rclk), .q(next_link_entry14[3:0]),
                       .se(se), .si(), .so());
dffe_s   #(4)  ff_next_link15 ( .din(enc_tag_wr_wl_c3[3:0]),
                        .en(next_link_wr_en_c3[15]),
                        .clk(rclk), .q(next_link_entry15[3:0]),
                        .se(se), .si(), .so());
		  
////////////////////////////////////////////////////////////////////
// CTRUE bit : Denotes "final" pass for a partial store/swap/ldstub
//       and "store" for a CAS2 instruction in the miss buffer.
//	- This bit is set in the C8 cycle of a parital store hitting
// 	 the $ for the inserting/resinserting entry in C8.
// 	- Also set in C8  of a CAS1 packet hitting in the cache/fb
//	  if the compare operation is true.But this bit is set 
//	  for the Miss Buffer entry of the CAS2 dependent of the 
//	  CAS1 packet and not for the CAS1 packet itself.
// If CAS1 is issued from the Miss Buffer, the CTRUE bit is set for
// its miss buffer dependent.
// If CAS1 is issued from the IQ, The CTRUE bit is set for the 
// miss buffer entry of the instruction that is following 2 cycles
// after.
////////////////////////////////////////////////////////////////////

dff_s   #(1)  ff_inst_mb_c4    (.din(inst_mb_c3), .clk(rclk), 
			.q(inst_mb_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_mb_c5    (.din(inst_mb_c4), .clk(rclk), 
			.q(inst_mb_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_mb_c6    (.din(inst_mb_c5), .clk(rclk), 
			.q(inst_mb_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_mb_c7    (.din(inst_mb_c6), .clk(rclk), 
			.q(inst_mb_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_mb_c8    (.din(inst_mb_c7), .clk(rclk), 
			.q(inst_mb_c8), .se(se), .si(), .so());


dff_s   #(1)  ff_inst_mb_c9    (.din(inst_mb_c8), .clk(rclk), 
			.q(inst_mb_c9), .se(se), .si(), .so());



dff_s   #(4)  ff_enc_data_wr_wl_c7_1    (.din(enc_data_wr_wl_c6[3:0]), .clk(rclk), 
			.q(enc_data_wr_wl_c7_1[3:0]), .se(se), .si(), .so());

mux2ds  #(4) mux_ctrue_entry  (.dout(mbctl_ctrue_rdy_entry[3:0]),
                           .in0(enc_data_wr_wl_c9[3:0]),// cas1 from mb contains cas2(dep) id
                           .in1(enc_data_wr_wl_c7_1[3:0]), // cas1 from IQ. contains cas2 id
                           .sel0(inst_mb_c9),
                           .sel1(~inst_mb_c9));


dff_s   #(1)  ff_cas1_hit_c9    (.din(arbctl_mbctl_cas1_hit_c8), .clk(rclk), 
			.q(cas1_hit_c9), .se(se), .si(), .so());


 assign  cas_rdy_set_c9[0] = ( mbctl_ctrue_rdy_entry == 4'd0 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[1] = ( mbctl_ctrue_rdy_entry == 4'd1 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[2] = ( mbctl_ctrue_rdy_entry == 4'd2 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[3] = ( mbctl_ctrue_rdy_entry == 4'd3 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[4] = ( mbctl_ctrue_rdy_entry == 4'd4 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[5] = ( mbctl_ctrue_rdy_entry == 4'd5 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[6] = ( mbctl_ctrue_rdy_entry == 4'd6 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[7] = ( mbctl_ctrue_rdy_entry == 4'd7 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[8] = ( mbctl_ctrue_rdy_entry == 4'd8 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[9] = ( mbctl_ctrue_rdy_entry == 4'd9 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[10] = ( mbctl_ctrue_rdy_entry == 4'd10 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[11] = ( mbctl_ctrue_rdy_entry == 4'd11 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[12] = ( mbctl_ctrue_rdy_entry == 4'd12 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[13] = ( mbctl_ctrue_rdy_entry == 4'd13 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[14] = ( mbctl_ctrue_rdy_entry == 4'd14 ) 
              		& cas1_hit_c9; 
 assign  cas_rdy_set_c9[15] = ( mbctl_ctrue_rdy_entry == 4'd15 ) 
              		& cas1_hit_c9; 

dff_s   #(1)  ff_uncorr_err_c9    (.din(decc_uncorr_err_c8), .clk(rclk), 
			.q(uncorr_err_c9), .se(se), .si(), .so());


assign	cas_ctrue_set_c9 =  cas_rdy_set_c9 & 
			{16{arbctl_mbctl_ctrue_c9 & // compare is true
			~uncorr_err_c9 }} ; // no error in the read.
 

assign	pst_ctrue_set_c8 = insert_ptr_c8 & {16{arbctl_pst_ctrue_en_c8}} ;

assign	mb_ctrue_prev = ( pst_ctrue_set_c8 | // pst ctrue
			  cas_ctrue_set_c9 | // cas2 ctrue.
				mb_ctrue ) & 
			~reset_valid_bit_c3 ;
 
dffrl_s   #(16)  ff_ctrue_bit    (.din(mb_ctrue_prev[15:0]), .clk(rclk), 
	.rst_l(dbb_rst_l), .q(mb_ctrue[15:0]), .se(se), .si(), .so());


//////////////////////////////////////////////////////////////////////////////
// Miss Buffer ID to the Fill Buffer: The ID( mbf entry #) of a miss buffer 
// instruction is written into the Fill Buffer in the following cases
// 1) INstruction from the miss buffer is deleted due to a Fill Buffer hit
//    and hence the dependent instruction's ID is written into the FIll Buffer.
// 2) Instruction from the IQ hits the Fill Buffer ( and is a non-dependent
//    instruction ) so its ID is written into the Fill Buffer.
// 3) ID of a "true miss" when it requests to DRAM and enqueues in the FB
// Here is the Pipeline for case 1 and case 2.
//
// case 1: The next link mux has to be done in C3 to 
// 	   handle the case where a dependent was just issued
//	   from the IQ one cycle before the Miss Buffer
//	   instruction that will complete.
//---------------------------------------------
//	C3		C4		C5
//---------------------------------------------
//			mbf 		fbf
//			delete		write
//	nextlink mux
//
//	nextlink vld
//	logic
//------------------------------------
//
// 
// case 2
//------------------------------------
// 	C4		C5
//------------------------------------
// 	mbf insert	fbf write
//				
//	enc tag wr ptr
//----------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////

// case 2 related control output

assign	mbf_insert_mbid_c3 = enc_tag_wr_wl_c3 ;

dff_s   #(4)  ff_mbf_insert_mbid_c4    (.din(mbf_insert_mbid_c3[3:0]), .clk(rclk), 
		.q(mbf_insert_mbid_c4[3:0]), .se(se), .si(), .so());

dff_s   #(1)  ff_mbf_insert_c4    (.din(mbf_insert_c3), .clk(rclk), 
		.q(mbf_insert_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_mbctl_hit_c3    (.din(mbctl_hit_c2), .clk(rclk), 
		.q(mbctl_hit_c3), .se(se), .si(), .so());

//--\/--- ADDED TO FIX bug#4619 -----\/-----------
dff_s   #(1)  ff_mbctl_arbctl_hit_c3    (.din(mbctl_hit_c2), .clk(rclk), 
		.q(mbctl_arbctl_hit_c3), .se(se), .si(), .so());
//--\/--- ADDED TO FIX bug#4619 -----\/-----------

dff_s   #(1)  ff_mbctl_hit_c4    (.din(mbctl_hit_c3), .clk(rclk), 
		.q(mbctl_hit_c4), .se(se), .si(), .so());


// Case 1 related.

assign	mbctl_next_vld_c3 = ( |( dec_mb_entry_c3 & ~mb_young))  & 
				inst_mb_c3  &
                                mb_inst_vld_c3_1 ;

dff_s   #(1)  ff_mbctl_fbctl_next_vld_c4    (.din(mbctl_next_vld_c3), .clk(rclk),
             .q(mbctl_fbctl_next_vld_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_mbf_delete_c4    (.din(mbf_delete_c3), .clk(rclk),
             .q(mbf_delete_c4), .se(se), .si(), .so());



assign  sel_0to3 = |( dec_mb_entry_c3[3:0] );
assign  sel_4to7 = |( dec_mb_entry_c3[7:4] );
assign  sel_8to11 = |( dec_mb_entry_c3[11:8] );
assign  sel_12to15 = |( dec_mb_entry_c3[15:12] );

assign  sel_default_0123 =  ~sel_0to3 | dec_mb_entry_c3[3]  ;
assign  sel_default_4567 =  ~sel_4to7 | dec_mb_entry_c3[7]  ;
assign  sel_default_89ab =  ~sel_8to11 | dec_mb_entry_c3[11] ;
assign  sel_default_cdef =  ~sel_12to15 | dec_mb_entry_c3[15] ;

assign  sel_default_nlink = ~( sel_0to3 | sel_4to7 | sel_8to11 ) ;

mux4ds  #(4) mux_nextlink_0123  (.dout(nextlink_id0123[3:0]),
          .in0(next_link_entry0[3:0]), .in1(next_link_entry1[3:0]),
          .in2(next_link_entry2[3:0]), .in3(next_link_entry3[3:0]),
          .sel0(dec_mb_entry_c3[0]), .sel1(dec_mb_entry_c3[1]),
          .sel2(dec_mb_entry_c3[2]), .sel3(sel_default_0123));

mux4ds  #(4) mux_nextlink_4567  (.dout(nextlink_id4567[3:0]),
          .in0(next_link_entry4[3:0]), .in1(next_link_entry5[3:0]),
          .in2(next_link_entry6[3:0]), .in3(next_link_entry7[3:0]),
          .sel0(dec_mb_entry_c3[4]), .sel1(dec_mb_entry_c3[5]),
          .sel2(dec_mb_entry_c3[6]), .sel3(sel_default_4567));

mux4ds  #(4) mux_nextlink_89ab  (.dout(nextlink_id89ab[3:0]),
          .in0(next_link_entry8[3:0]), .in1(next_link_entry9[3:0]),
          .in2(next_link_entry10[3:0]), .in3(next_link_entry11[3:0]),
          .sel0(dec_mb_entry_c3[8]), .sel1(dec_mb_entry_c3[9]),
          .sel2(dec_mb_entry_c3[10]), .sel3(sel_default_89ab));

mux4ds  #(4) mux_nextlink_cdef  (.dout(nextlink_idcdef[3:0]),
          .in0(next_link_entry12[3:0]), .in1(next_link_entry13[3:0]),
          .in2(next_link_entry14[3:0]), .in3(next_link_entry15[3:0]),
          .sel0(dec_mb_entry_c3[12]), .sel1(dec_mb_entry_c3[13]),
          .sel2(dec_mb_entry_c3[14]), .sel3(sel_default_cdef));


mux4ds  #(4) mux_next_link_c3  (.dout(mbctl_next_link_c3[3:0]),
          .in0(nextlink_id0123[3:0]), .in1(nextlink_id4567[3:0]),
          .in2(nextlink_id89ab[3:0]), .in3(nextlink_idcdef[3:0]),
          .sel0(sel_0to3), .sel1(sel_4to7),
          .sel2(sel_8to11), .sel3(sel_default_nlink));

dff_s   #(4)  ff_mbctl_fbctl_next_link_c4    (.din(mbctl_next_link_c3[3:0]), .clk(rclk),
             .q(mbctl_fbctl_next_link_c4[3:0]), .se(se), .si(), .so());



//////////////////////////////////////////////////////////////////////////////
// MB_DATA_VLD in mbctl: A zero in this bit for a valid instruction is 
//			 used to indicate that the instruction is inflight	
//			 and even if READY=1 , it cannot be picked for issue.
//////////////////////////////////////////////////////////////////////////////

assign	mb_data_vld_in =  (( insert_ptr_c8 & {16{mbdata_wr_en_c8}} ) |
				mb_data_vld ) & 
			~( picker_out_d1 & {16{l2_pick_d1}} ) ; // reset on pick


dffrl_s   #(16)  ff_mb_data_vld    (.din(mb_data_vld_in[15:0]), .clk(rclk),
        .rst_l(dbb_rst_l), .q(mb_data_vld[15:0]), .se(se), .si(), .so());


//////////////////////////////////////////////////////////////////////////////
// EVICT READY bit in Mbctl: THis is a duplicate of the evict bit
//	written into mbdata.  USed for
//	* Picking instructions for their eviction pass.
//	* Potentially disable the pick of evict ready entries
//	  when the WBB is full thereby removing the WBB full condition
//	  from the arbiter.
// 	Notice that tecc pick has a higher priority than an evict pick.
// A mb_tecc_ready pick was originally designed not to reset the evict_ready
// bit. However, if evict_ready & tecc_ready, we can reset both the ready bits
// because, the tecc&evict instruction will cause a scrub and also cause evict_ready
// to be set again.
//////////////////////////////////////////////////////////////////////////////

assign  mb_evict_ready_in = (( insert_ptr_c8 & {16{mbctl_evict_c8}}) | 
				mb_evict_ready ) &
                        //~( picker_out_d1 &  ~mb_tecc_ready & {16{l2_pick_d1}} ) ; 
                        ~( picker_out_d1 &   {16{l2_pick_d1}} ) ; 
		// reset on pick

dffrl_s   #(16)  ff_mb_evict_ready    (.din(mb_evict_ready_in[15:0]), .clk(rclk),
        .rst_l(dbb_rst_l), .q(mb_evict_ready[15:0]), .se(se), .si(), .so());

//////////////////////////////////////////////////////////////////////////////
// TECC READY bit in Mbctl: THis is a duplicate of the tecc bit
//	written into mbdata.  USed for
//	* Picking instructions for their tecc pass.
// 	Tecc pick has a higher priority than an evict pick.
// Notice that all TECCs do not cause the setting of a TECC bit in the $.
// If an instruction gets bypassed data from the Fill Buffer, the tecc is 
// a don't care. ALso, a parity error will not be signalled if a hit 
// is encountered inspite of a parity error in another way
//////////////////////////////////////////////////////////////////////////////

assign  mb_tecc_ready_in = (( insert_ptr_c8 & {16{mbctl_tecc_c8 
				& mbdata_wr_en_c8 }}) | 
				mb_tecc_ready ) &
                  ~( picker_out_d1 &  {16{l2_pick_d1}} ) ; // reset on pick

dffrl_s   #(16)  ff_mb_tecc_ready    (.din(mb_tecc_ready_in[15:0]), .clk(rclk),
        .rst_l(dbb_rst_l), .q(mb_tecc_ready[15:0]), .se(se), .si(), .so());

//////////////////////////////////////////////////////////////////////////////
// L2_READY in mbctl: This bit is set for any instruction in the mBF that is
//	ready for issue/reissue down the L2 pipeline. the READY bit for an 
// 	entry is reset when that entry is "l2 picked". The following
//	components go into the L2_READY set condition.
//	* Misses Readied on dram data arrival by  the FIll Buffer.
//	* Stores/ Miss Buffer dependents readied on a Fill by the 
//	  Fill Buffer ( Readied in the C4 cycle of a FILL ).
//	* Miss Buffer dependents readied when the older instruction
//	  dequeues from the Miss Buffer. ( in the C4 stage of the older inst.) 
//	* WBB dependents readied when the Write back is acked by DRAM/BTU
//	* Ready a CSR instruction when the FIll Buffer is empty and the mIss Buffer
//	  has only one entry available.
//	* Ready a Partial store for its 2nd pass if the 1st pass is able to 
//	  set the CTRUE bit.
//	* Ready a CAS2 packet if the CAS1 packet hits the $ or FB after the
//	  first packet has reached C8.
//	* Ready a STQ2 packet if the STQ1 packet hits the $ or FB after the
//        first packet has reached C4
//	* Ready a tecc instruction in C8
//////////////////////////////////////////////////////////////////////////////

//////
// Misses Readied on dram data arrival by  the FIll Buffer
//--------------------------------------
//	R1			R2
//------------------------------------
//	rd_data_vld_d1		ready
//				dep
// 	mux out
//	ID of true miss
//	mbf inst. in
//	fbctl.
//////


dff_s   #(1)  ff_ready_miss_r2(.din(fbf_ready_miss_r1), .clk(rclk),
                               .q(ready_miss_r2), .se(se), .si(), .so());

dff_s   #(4)  ff_fbf_enc_ld_mbid_r1(.din(fbf_enc_ld_mbid_r1[3:0]), .clk(rclk),
                               .q(ld_mbid_r2[3:0]), .se(se), .si(), .so());

assign  mb_miss_rdy_r2[0] = ( ld_mbid_r2 == 4'd0) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[1] = ( ld_mbid_r2 == 4'd1) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[2] = ( ld_mbid_r2 == 4'd2) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[3] = ( ld_mbid_r2 == 4'd3) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[4] = ( ld_mbid_r2 == 4'd4) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[5] = ( ld_mbid_r2 == 4'd5) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[6] = ( ld_mbid_r2 == 4'd6) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[7] = ( ld_mbid_r2 == 4'd7) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[8] = ( ld_mbid_r2 == 4'd8) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[9] = ( ld_mbid_r2 == 4'd9) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[10] = ( ld_mbid_r2 == 4'd10) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[11] = ( ld_mbid_r2 == 4'd11) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[12] = ( ld_mbid_r2 == 4'd12) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[13] = ( ld_mbid_r2 == 4'd13) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[14] = ( ld_mbid_r2 == 4'd14) & ready_miss_r2 ;
assign  mb_miss_rdy_r2[15] = ( ld_mbid_r2 == 4'd15) & ready_miss_r2 ;

//////
// Stores/ Miss Buffer dependents in FB
// readied in the C5 cycle of a Fill
//--------------------------------------
//	C4			C5
//------------------------------------
//	fill_complete_c4	ready
//				dep
// 	mux out
//	ID of dependent
//	mbf inst. in
//	fbctl.
//////


dff_s   #(1)  ff_fbf_st_or_dep_rdy_c5(.din(fbf_st_or_dep_rdy_c4), .clk(rclk),
               .q(st_or_dep_rdy_c5), .se(se), .si(), .so());

dff_s   #(4)  ff_fbf_enc_dep_mbid_c5(.din(fbf_enc_dep_mbid_c4[3:0]), .clk(rclk),
               .q(dep_mbid_c5[3:0]), .se(se), .si(), .so());



assign  fb_dep_rdy_c5[0] = ( dep_mbid_c5 == 4'd0) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[1] = ( dep_mbid_c5 == 4'd1) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[2] = ( dep_mbid_c5 == 4'd2) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[3] = ( dep_mbid_c5 == 4'd3) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[4] = ( dep_mbid_c5 == 4'd4) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[5] = ( dep_mbid_c5 == 4'd5) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[6] = ( dep_mbid_c5 == 4'd6) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[7] = ( dep_mbid_c5 == 4'd7) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[8] = ( dep_mbid_c5 == 4'd8) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[9] = ( dep_mbid_c5 == 4'd9) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[10] = ( dep_mbid_c5 == 4'd10) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[11] = ( dep_mbid_c5 == 4'd11) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[12] = ( dep_mbid_c5 == 4'd12) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[13] = ( dep_mbid_c5 == 4'd13) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[14] = ( dep_mbid_c5 == 4'd14) & st_or_dep_rdy_c5 ;
assign  fb_dep_rdy_c5[15] = ( dep_mbid_c5 == 4'd15) & st_or_dep_rdy_c5 ;

//////
//  Miss Buffer dependents READY:
//--------------------------------------
//	C3			C4
//------------------------------------
//	mbf_delete_c3		ready
//				dep
// 	mux out
//	ID of dependent
//	mbf inst. in
//	mbctl.
//
//	find out
//	if next_link
//	is vld.
//------------------------------------
//
// We  do not ready a miss buffer dependent immediately 
// after the older instruction dequeues from the Miss buffer.
// There are cases where the dependent may have to wait in the miss buffer
// for other events to occur. For example, a load that hits the fill Buffer
// will not ready the Miss Buffer dependent.
// 
//
// dep rdy conditions:
// - older instruction hits the $ ( non cas1).
// - older instruction is a wr64 and completes.
// - older instruction is a ld64 and hits the FB.
// -older instruction hits FB in $ off mode.
// 
//////


dff_s   #(1)  ff_decdp_cas1_inst_c2(.din(decdp_cas1_inst_c2), .clk(rclk),
               .q(cas1_inst_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_l2_bypass_mode_on_d1(.din(l2_bypass_mode_on), .clk(rclk),
               .q(l2_bypass_mode_on_d1), .se(se), .si(), .so());


dff_s   #(1)  ff_fbctl_match_c3(.din(fbctl_mbctl_match_c2), .clk(rclk),
               .q(fbctl_match_c3_unqual), .se(se), .si(), .so());

assign	fbctl_match_c3 =  fbctl_match_c3_unqual &   mb_inst_vld_c3 ;

dff_s   #(1)  ff_fbctl_stinst_match_c3(.din(fbctl_mbctl_stinst_match_c2), .clk(rclk),
               .q(fbctl_stinst_match_c3), .se(se), .si(), .so());

//-----\/ FIX for bug #4619 --\/-----
// inval instructions will ready their dependents 
// when they are deleted from the miss buffer
//-----\/ FIX for bug #4619 --\/-----


dff_s   #(1)  ff_mb_inval_inst_c3(.din(arbctl_mbctl_inval_inst_c2), .clk(rclk),
               .q(mb_inval_inst_c3), .se(se), .si(), .so());


assign	mb_dep_rdy_en_c3 =  mbctl_next_vld_c3 & mbf_delete_c3 & (
			(tagctl_hit_c3 & ~cas1_inst_c3) |
			( mb_inval_inst_c3 ) | // fix for 4619
			( mbctl_wr64_miss_comp_c3 & ~tagctl_mbctl_par_err_c3 ) | 
			(fbctl_match_c3 & ~cas1_inst_c3 &
				(ld64_inst_c3  |   // fb match for ld64
				(l2_bypass_mode_on_d1 & 
				~fbctl_stinst_match_c3 )
			) // no fill or $ OFF
			) );

dff_s   #(1)  ff_mb_dep_rdy_en_c4(.din(mb_dep_rdy_en_c3), .clk(rclk),
               .q(mb_dep_rdy_en_c4), .se(se), .si(), .so());

assign  mb_dep_rdy_c4[0] = ( mbctl_fbctl_next_link_c4 == 4'd0) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[1] = ( mbctl_fbctl_next_link_c4 == 4'd1) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[2] = ( mbctl_fbctl_next_link_c4 == 4'd2) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[3] = ( mbctl_fbctl_next_link_c4 == 4'd3) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[4] = ( mbctl_fbctl_next_link_c4 == 4'd4) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[5] = ( mbctl_fbctl_next_link_c4 == 4'd5) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[6] = ( mbctl_fbctl_next_link_c4 == 4'd6) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[7] = ( mbctl_fbctl_next_link_c4 == 4'd7) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[8] = ( mbctl_fbctl_next_link_c4 == 4'd8) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[9] = ( mbctl_fbctl_next_link_c4 == 4'd9) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[10] = ( mbctl_fbctl_next_link_c4 == 4'd10) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[11] = ( mbctl_fbctl_next_link_c4 == 4'd11) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[12] = ( mbctl_fbctl_next_link_c4 == 4'd12) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[13] = ( mbctl_fbctl_next_link_c4 == 4'd13) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[14] = ( mbctl_fbctl_next_link_c4 == 4'd14) & mb_dep_rdy_en_c4 ;
assign  mb_dep_rdy_c4[15] = ( mbctl_fbctl_next_link_c4 == 4'd15) & mb_dep_rdy_en_c4 ;

///////////
// Ready from Wbctl for WBB hits sitting in the Miss Buffer.
//--------------------------------------
//	1			2			
//------------------------------------
//	wbb eviction		ready
//	complete
//				dep
// 	mux out
//	ID of dependent
///////////


dff_s   #(1)  ff_wbb_dep_rdy_en_d1(.din(wbctl_mbctl_dep_rdy_en), .clk(rclk),
               .q(wbb_dep_rdy_en_d1), .se(se), .si(), .so());

dff_s   #(4)  ff_dep_mbid_d1(.din(wbctl_mbctl_dep_mbid[3:0]), .clk(rclk),
               .q(wbb_dep_mbid_d1[3:0]), .se(se), .si(), .so());


assign  wbb_dep_rdy_d1[0] = ( wbb_dep_mbid_d1 == 4'd0) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[1] = ( wbb_dep_mbid_d1 == 4'd1) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[2] = ( wbb_dep_mbid_d1 == 4'd2) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[3] = ( wbb_dep_mbid_d1 == 4'd3) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[4] = ( wbb_dep_mbid_d1 == 4'd4) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[5] = ( wbb_dep_mbid_d1 == 4'd5) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[6] = ( wbb_dep_mbid_d1 == 4'd6) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[7] = ( wbb_dep_mbid_d1 == 4'd7) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[8] = ( wbb_dep_mbid_d1 == 4'd8) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[9] = ( wbb_dep_mbid_d1 == 4'd9) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[10] = ( wbb_dep_mbid_d1 == 4'd10) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[11] = ( wbb_dep_mbid_d1 == 4'd11) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[12] = ( wbb_dep_mbid_d1 == 4'd12) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[13] = ( wbb_dep_mbid_d1 == 4'd13) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[14] = ( wbb_dep_mbid_d1 == 4'd14) & wbb_dep_rdy_en_d1 ;
assign  wbb_dep_rdy_d1[15] = ( wbb_dep_mbid_d1 == 4'd15) & wbb_dep_rdy_en_d1 ;

///////////
// Ready from rdmatctl for rdmat hits sitting in the Miss Buffer.
//--------------------------------------
//	1			2			
//------------------------------------
//	rdmat eviction		ready
//	complete
//				dep
// 	mux out
//	ID of dependent
///////////



dff_s   #(1)  ff_rdmatb_dep_rdy_en_d1(.din(rdmatctl_mbctl_dep_rdy_en), .clk(rclk),
               .q(rdmat_dep_rdy_en_d1), .se(se), .si(), .so());

dff_s   #(4)  ff_dep_rdmat_mbid_d1(.din(rdmatctl_mbctl_dep_mbid[3:0]), .clk(rclk),
               .q(rdmat_dep_mbid_d1[3:0]), .se(se), .si(), .so());


assign  rdmat_dep_rdy_d1[0] = ( rdmat_dep_mbid_d1 == 4'd0) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[1] = ( rdmat_dep_mbid_d1 == 4'd1) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[2] = ( rdmat_dep_mbid_d1 == 4'd2) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[3] = ( rdmat_dep_mbid_d1 == 4'd3) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[4] = ( rdmat_dep_mbid_d1 == 4'd4) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[5] = ( rdmat_dep_mbid_d1 == 4'd5) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[6] = ( rdmat_dep_mbid_d1 == 4'd6) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[7] = ( rdmat_dep_mbid_d1 == 4'd7) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[8] = ( rdmat_dep_mbid_d1 == 4'd8) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[9] = ( rdmat_dep_mbid_d1 == 4'd9) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[10] = ( rdmat_dep_mbid_d1 == 4'd10) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[11] = ( rdmat_dep_mbid_d1 == 4'd11) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[12] = ( rdmat_dep_mbid_d1 == 4'd12) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[13] = ( rdmat_dep_mbid_d1 == 4'd13) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[14] = ( rdmat_dep_mbid_d1 == 4'd14) & rdmat_dep_rdy_en_d1 ;
assign  rdmat_dep_rdy_d1[15] = ( rdmat_dep_mbid_d1 == 4'd15) & rdmat_dep_rdy_en_d1 ;

///////////
// C8 ready. 
// * Ready for CAS2 ( readies dependent entry  in C9)
// * PST 2nd pass  ( Readies same instruction in mb)
// * tag parity detected (  Readies same instruction in mb)
// * A TECC instruction ( Readies same instruction in mb)
///////////


assign	cas2_or_pst_rdy_c8 = ( mb_data_wr_wl_c8 &  // insert or reinsert pointer.
					{16{arbctl_pst_ctrue_en_c8  | // pst ctrue enable c8
					arbdp_tecc_inst_mb_c8 |// tecc instruction
					rdma_comp_rdy_c8}} ) | // rdma reg incomplete instruction
				cas_rdy_set_c9 ; // CAS rdy set c9( does not imply ctrue=1)


///////////////////////////////
// CSR store ready:
// A CSR store is inserted in the Miss Buffer 
// like any miss. The MBID of a CSR store is saved
// since there can only be one CSR store pending
// in the L2$. Once the cache is disabled all snoops
// will receive a miss response from the L2.
//
// Pipeline for writing mbid and mbid vld for
// a CSR write.
//-------------------------------------------
// 	C3		C4
//-------------------------------------------
//			mbidvld=1
//			mbid = valid
//
//			if mb_count=1
//			& fb_count=0
//			set RDY.
///////////////////////////////


assign	set_mbid_vld_prev=  arbctl_csr_st_c2  & // CSR store
                       mbtag_wr_en_c2 ;

dff_s   #(1)  ff_set_mbid_vld(.din(set_mbid_vld_prev), .clk(rclk), 
               .q(set_mbid_vld), .se(se), .si(), .so());
		
assign	reset_mbid_vld = ( mb_count_c4==5'd1)  // only entry is csr write
			& fb_count_eq_0 ; // fill buffer empty.
                        

assign	mbid_vld_in = ((  mbid_vld  & ~reset_mbid_vld ) | set_mbid_vld ) ;

dffrl_s   #(1)  ff_mbid_vld(.din(mbid_vld_in), .clk(rclk), .rst_l(dbb_rst_l),
               .q(mbid_vld), .se(se), .si(), .so());

assign	rdy_csr_inst_en = mbid_vld & reset_mbid_vld ;


dffe_s   #(4)  ff_mbid(.din(enc_tag_wr_wl_c3[3:0]), .clk(rclk), 
		.en(set_mbid_vld),
               .q(csr_mbid[3:0]), .se(se), .si(), .so());

assign  csr_inst_rdy[0] = ( csr_mbid == 4'd0) & rdy_csr_inst_en ;
assign  csr_inst_rdy[1] = ( csr_mbid == 4'd1) & rdy_csr_inst_en ;
assign  csr_inst_rdy[2] = ( csr_mbid == 4'd2) & rdy_csr_inst_en ;
assign  csr_inst_rdy[3] = ( csr_mbid == 4'd3) & rdy_csr_inst_en ;
assign  csr_inst_rdy[4] = ( csr_mbid == 4'd4) & rdy_csr_inst_en ;
assign  csr_inst_rdy[5] = ( csr_mbid == 4'd5) & rdy_csr_inst_en ;
assign  csr_inst_rdy[6] = ( csr_mbid == 4'd6) & rdy_csr_inst_en ;
assign  csr_inst_rdy[7] = ( csr_mbid == 4'd7) & rdy_csr_inst_en ;
assign  csr_inst_rdy[8] = ( csr_mbid == 4'd8) & rdy_csr_inst_en ;
assign  csr_inst_rdy[9] = ( csr_mbid == 4'd9) & rdy_csr_inst_en ;
assign  csr_inst_rdy[10] = ( csr_mbid == 4'd10) & rdy_csr_inst_en ;
assign  csr_inst_rdy[11] = ( csr_mbid == 4'd11) & rdy_csr_inst_en ;
assign  csr_inst_rdy[12] = ( csr_mbid == 4'd12) & rdy_csr_inst_en ;
assign  csr_inst_rdy[13] = ( csr_mbid == 4'd13) & rdy_csr_inst_en ;
assign  csr_inst_rdy[14] = ( csr_mbid == 4'd14) & rdy_csr_inst_en ;
assign  csr_inst_rdy[15] = ( csr_mbid == 4'd15) & rdy_csr_inst_en ;



assign  mb_l2_ready_in = ( 
			mb_miss_rdy_r2 | // miss readied by fill data
			fb_dep_rdy_c5  | // miss/dep readied by fill op
			mb_dep_rdy_c4 |	// mbf dep ready
			wbb_dep_rdy_d1 |	// wbb dependent ready	
			rdmat_dep_rdy_d1 | // rdma dep ready
			cas2_or_pst_rdy_c8 | 	// ctrue instr
			csr_inst_rdy | // csr stores.
                        mb_l2_ready ) &
                       ~( picker_out_d1 & 
			~mb_evict_ready &  // if evict ready is set, that is
					   // the that will be reset before l2_ready.
			~mb_tecc_ready &     // if tecc ready is set, that will be 
					   // the first to get reset.
			{16{l2_pick_d1}} ) ; // reset on pick

dffrl_s   #(16)  ff_mb_l2_ready    (.din(mb_l2_ready_in[15:0]), .clk(rclk),
        .rst_l(dbb_rst_l), .q(mb_l2_ready[15:0]), .se(se), .si(), .so());


/////////////////////////////////////////////////////////////////////////////////
// Interface with the L2 Arbiter:
//  An instruction is picked for L2 issue if the the MB tag and 
//  data are not in use for a DRAM issue.
//
//  THe Miss buffer can issue instructions to the L2 pipeline 
//  at the rate of 1 every 3 cycles. Here is the pipeline for
//  miss buffer issue. The following pipeline assumes that
//  the instruction picked by the Miss Buffer for issue is 
//  immediately picked for issue by the arbiter.
//
//--------------------------------------------------------------------------
// inst A	PICK		READ (PX1)		ISSUE(PX2)	
//--------------------------------------------------------------------------
//		-pick if
//		~l2_wait	
//		or mbsel_c1	-read mbtag		
//				-read mbdata		
//		-set l2_wait	-enable px2 rd flop
//				if l2_pick_d1		- hold mbtag
//							  and mbdata if
//							  l2_wait
//--------------------------------------------------------------------------
//
// l2_pick is similar to dram pick. It is used to turn off 
// L2_READY, EVICT_READY and DATA_VLD bits in mbctl.
//
// picker_out_qual  is used to qualify a pick.
// If this signal is low, it implies that either
// an l2 pick is pending issue or
// a  dram_pick is pending acknowledgement
// or there is no "READY" instruction for dram or l2 issue.
//
/////////////////////////////////////////////////////////////////////////////////


assign	l2_pick = |( l2_pick_vec )  & picker_out_qual & ~dram_pick_2  &
			~mb_rewrite_en_c8 ;

dff_s   #(1)  ff_l2_pick_d1(.din(l2_pick), .clk(rclk), 
               .q(l2_pick_d1), .se(se), .si(), .so());


assign	l2_wait_set = l2_pick & ( ~l2_wait | arbctl_mbctl_mbsel_c1) ;
assign	l2_wait_reset = arbctl_mbctl_mbsel_c1 ;

// In the following case, set takes preference over the reset
// condition.
assign	l2_wait_in =  ( l2_wait  & ~l2_wait_reset) |
			l2_wait_set  ;

dffrl_s   #(1)  ff_l2_wait(.din(l2_wait_in), .clk(rclk), .rst_l(dbb_rst_l),
               .q(l2_wait), .se(se), .si(), .so());


assign	picker_out_qual = ~l2_wait | 	// l2 pick active
			 arbctl_mbctl_mbsel_c1 | // l2 pick selected
			  dram_pick_2 ;	// dram pick


assign	mbctl_buf_rd_en = l2_pick | dram_pick_2 ;

// Signals  for enabling rd data flops for the Miss Buffer.
assign	mbctl_arb_l2rd_en = l2_pick_d1;

assign	mbctl_arbctl_vld_px1 = l2_wait ;

////////////////////////////
// CTRUE bit to L2.
// THis is the only bit going to 
// the arbiter as part of the instr.
// from mbctl.
////////////////////////////


assign	l2_pick_read_ctrue = |( picker_out_d1 & mb_ctrue ) ;

dffe_s   #(1)  ff_read_reg_ctrue_in    (.din(l2_pick_read_ctrue),
                 .en(l2_pick_d1), .clk(rclk),
                 .q(mbctl_arbdp_ctrue_px2), .se(se), .si(), .so());



//////////////////////////////////////////////////////////////////
// Interface with DRAM: 
// An entry with dram_ready is picked to issue a request to 
// DRAM. If it is determined in cycle X that there is atleast one
// dram_ready entry in the MBF, then the pick in cycle X+1 is 
// reserved for issue to DRAM. Unless the following conditions are
// true:
// * Fill Buffer has no entry available.
// * Prev request is pending to DRAM
//
// Pipeline for RD requests to DRAM:
//-----------------------------------------------------------------
//	#1		#2		#3		#4
//-----------------------------------------------------------------
// dram_pick_prev	pick		mbtag rd	2-1 addr mux
//							rd_req xmit
//							rd_addr xmit
//
//							write TAG,WR/RD,
//							mbf entry, 
//							into FB
//							
//-----------------------------------------------------------------
// In the best case, cycle #1 can coincide with C4 of a miss inst.
//
// The Dram ready bit is set in C8. Hence it can only be consumed
// in C9. dram_pick_prev is set in C8 based on the dram set 
// condition. This condition was added on 2/3/2003
//////////////////////////////////////////////////////////////////

dff_s   #(1)  ff_dram_sctag_rd_ack_d1    (.din(dram_sctag_rd_ack), .clk(rclk),
             .q(dram_sctag_rd_ack_d1), .se(se), .si(), .so());

assign	dram_pick_prev = ~dram_pick & // back to back picks not allowed.
			~mb_rewrite_en_c7 & // read and write in same cyc not allowed.
			( dram_sctag_rd_ack_d1 | // ack from Dram
			~dram_ack_pend_state ) & // request pending in dram
			fbctl_mbctl_entry_avail & // fill buffer has entries
			( |( mb_dram_ready)   |
			( mbdata_wr_en_c8 & dram_rdy_c8 ) ); // atleast one ready entry

dff_s   #(1)  ff_mbctl_fbctl_dram_pick    (.din(dram_pick_prev), .clk(rclk),
             .q(mbctl_fbctl_dram_pick), .se(se), .si(), .so());

dff_s   #(1)  ff_dram_pick    (.din(dram_pick_prev), .clk(rclk),
             .q(dram_pick), .se(se), .si(), .so());

dff_s   #(1)  ff_dram_pick_2    (.din(dram_pick_prev), .clk(rclk),
             .q(dram_pick_2), .se(se), .si(), .so());



dff_s   #(1)  ff_dram_pick_d1    (.din(dram_pick), .clk(rclk),
             .q(dram_pick_d1), .se(se), .si(), .so());

dff_s   #(1)  ff_dram_pick_d2    (.din(dram_pick_d1), .clk(rclk),
             .q(dram_pick_d2), .se(se), .si(), .so());

assign	mbctl_arb_dramrd_en = dram_pick_d1;

assign	sctag_dram_rd_req = dram_pick_d2 ;


assign	dummy_req_d1 = |( mb_bis & picker_out_d1 ) & dram_pick_d1 ;

dff_s   #(1)  ff_dummy_req_d2    (.din(dummy_req_d1), .clk(rclk),
             .q(dummy_req_d2), .se(se), .si(), .so());

assign	sctag_dram_rd_dummy_req = dummy_req_d2 ; 



assign	dram_ack_pending_in = ( dram_ack_pend_state | 
			dram_pick ) &
		~dram_sctag_rd_ack_d1 ;

dffrl_s   #(1)  ff_dram_ack_pend_state (.din(dram_ack_pending_in), .clk(rclk),	
		.rst_l(dbb_rst_l),
             .q(dram_ack_pend_state), .se(se), .si(), .so());


////////////////////////////////////////////////////////////////////
// Miss Buffer to Fill Buffer Miss Interface.
//
// The fields required for processing a miss in the Fill Buffer are
// written in two stages: 
// 1) When it is picked for dram issue i.e. during fill buffer insertion
// 2) When an eviction is performed.
// 
// THe following Bits are used for saving the fields required
// by the Fill Buffer for miss processing that may not be available
// at the time of fill Buffer insertion.
//
// WAY, FBID, WAY_VLD and FBID_VLD
//
// Fill Buffer id valid is asserted in the d2 cycle of a dram_pick
// IN the same cycle FBID is written in mbctl.
// 
// WAY and way_vld are asserted in the C4 cycle of an eviction
// operation.
//
// Prioritized(FBID_VLD and WAY_VLD) is used to mux out the
// WAY and FBID fields from the selected miss buffer entry.
// Also, this one hot vector is used for resetting FBID_VLD & WAY_VLD.
////////////////////////////////////////////////////////////////////

//////////////
// WAY FIELD: This Field needs to be maintained in mbctl
//      WAY is stored into the WAY FIELD when an eviction
//      operation completes and gets a way allocated for
//      a Miss in the Miss Buffer.
//      Needs to be used in conjunction with EVICT_DONE
//      which is synonymous with "way valid" 
//
//      Written in the C4 cycle of an eviction operation.
/////////////

assign		evict_vld_c3  = evict_vld_unqual_c3 & 
			~tagctl_mbctl_par_err_c3 ;

dff_s   #(1)  ff_evict_vld_c4    (.din(evict_vld_c3), .clk(rclk),
             .q(evict_vld_c4), .se(se), .si(), .so());

assign  dec_wr_wl_c4[0] = ( enc_data_wr_wl_c4==4'd0 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[1] = ( enc_data_wr_wl_c4==4'd1 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[2] = ( enc_data_wr_wl_c4==4'd2 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[3] = ( enc_data_wr_wl_c4==4'd3 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[4] = ( enc_data_wr_wl_c4==4'd4 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[5] = ( enc_data_wr_wl_c4==4'd5 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[6] = ( enc_data_wr_wl_c4==4'd6 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[7] = ( enc_data_wr_wl_c4==4'd7 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[8] = ( enc_data_wr_wl_c4==4'd8 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[9] = ( enc_data_wr_wl_c4==4'd9 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[10] = ( enc_data_wr_wl_c4==4'd10 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[11] = ( enc_data_wr_wl_c4==4'd11 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[12] = ( enc_data_wr_wl_c4==4'd12 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[13] = ( enc_data_wr_wl_c4==4'd13 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[14] = ( enc_data_wr_wl_c4==4'd14 ) & evict_vld_c4 ;
assign  dec_wr_wl_c4[15] = ( enc_data_wr_wl_c4==4'd15 ) & evict_vld_c4 ;
  
  dffe_s   #(4)  ff_way0    ( .din(tagctl_lru_way_c4[3:0]),
				 .se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[0]), .clk(rclk), .q(way0[3:0])); 
  dffe_s   #(4)  ff_way1    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[1]), .clk(rclk), .q(way1[3:0])); 
  dffe_s   #(4)  ff_way2    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[2]), .clk(rclk), .q(way2[3:0])); 
  dffe_s   #(4)  ff_way3    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[3]), .clk(rclk), .q(way3[3:0])); 
  dffe_s   #(4)  ff_way4    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[4]), .clk(rclk), .q(way4[3:0])); 
  dffe_s   #(4)  ff_way5    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[5]), .clk(rclk), .q(way5[3:0])); 
  dffe_s   #(4)  ff_way6    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[6]), .clk(rclk), .q(way6[3:0])); 
  dffe_s   #(4)  ff_way7    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[7]), .clk(rclk), .q(way7[3:0])); 
  dffe_s   #(4)  ff_way8    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[8]), .clk(rclk), .q(way8[3:0])); 
  dffe_s   #(4)  ff_way9    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[9]), .clk(rclk), .q(way9[3:0])); 
  dffe_s   #(4)  ff_way10    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[10]), .clk(rclk), .q(way10[3:0])); 
  dffe_s   #(4)  ff_way11    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[11]), .clk(rclk), .q(way11[3:0])); 
  dffe_s   #(4)  ff_way12    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[12]), .clk(rclk), .q(way12[3:0])); 
  dffe_s   #(4)  ff_way13    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[13]), .clk(rclk), .q(way13[3:0])); 
  dffe_s   #(4)  ff_way14    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[14]), .clk(rclk), .q(way14[3:0])); 
  dffe_s   #(4)  ff_way15    ( .din(tagctl_lru_way_c4[3:0]),
				.se(se), .si(), .so(),
                        .en(dec_wr_wl_c4[15]), .clk(rclk), .q(way15[3:0])); 

////////////
// WAY_VLD bit 
// set when an eviction is done in the C4 cycle
// of an eviction packet and reset when the evicted way
// is written into the Fill Buffer.
////////////
assign	mb_way_vld_in = ( mb_way_vld | dec_wr_wl_c4 ) &
			~mb_way_fb_vld_reset ;

dffrl_s   #(16)  ff_mb_way_vld    (.din(mb_way_vld_in[15:0]), .clk(rclk),
      .rst_l(dbb_rst_l), .q(mb_way_vld[15:0]), .se(se), .si(), .so());

//////////////
// FBID FIELD: 
// 	FBID is tracked in the Miss Buffer 
// 	to perform the write of Miss fields in FB
//	asynchronous with the dram pick.
//
// For a No Fill entry, fbid vld is not set
// This is because way_vld will not be set for
// this instruction as it never makes an eviction
// pass. 
//////////////



  assign  dec_dram_pick_d2 = picker_out_d2 & {16{dram_pick_d2 & ~fbctl_mbctl_nofill_d2}} ;
  
  dffe_s   #(3)  ff_fbid0    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[0]), .clk(rclk), .q(fbid0[2:0])); 
  dffe_s   #(3)  ff_fbid1    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[1]), .clk(rclk), .q(fbid1[2:0])); 
  dffe_s   #(3)  ff_fbid2    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[2]), .clk(rclk), .q(fbid2[2:0])); 
  dffe_s   #(3)  ff_fbid3    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[3]), .clk(rclk), .q(fbid3[2:0])); 
  dffe_s   #(3)  ff_fbid4    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[4]), .clk(rclk), .q(fbid4[2:0])); 
  dffe_s   #(3)  ff_fbid5    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[5]), .clk(rclk), .q(fbid5[2:0])); 
  dffe_s   #(3)  ff_fbid6    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[6]), .clk(rclk), .q(fbid6[2:0])); 
  dffe_s   #(3)  ff_fbid7    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[7]), .clk(rclk), .q(fbid7[2:0])); 
  dffe_s   #(3)  ff_fbid8    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[8]), .clk(rclk), .q(fbid8[2:0])); 
  dffe_s   #(3)  ff_fbid9    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[9]), .clk(rclk), .q(fbid9[2:0])); 
  dffe_s   #(3)  ff_fbid10    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[10]), .clk(rclk), .q(fbid10[2:0])); 
  dffe_s   #(3)  ff_fbid11    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[11]), .clk(rclk), .q(fbid11[2:0])); 
  dffe_s   #(3)  ff_fbid12    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[12]), .clk(rclk), .q(fbid12[2:0])); 
  dffe_s   #(3)  ff_fbid13    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[13]), .clk(rclk), .q(fbid13[2:0])); 
  dffe_s   #(3)  ff_fbid14    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[14]), .clk(rclk), .q(fbid14[2:0])); 
  dffe_s   #(3)  ff_fbid15    ( .din(fbctl_mbctl_fbid_d2[2:0]),
				.se(se), .si(), .so(),
                        .en(dec_dram_pick_d2[15]), .clk(rclk), .q(fbid15[2:0])); 

////////////
// FBID_VLD  
// set when dram _pick_d2 is asserted.
// to indicate that the entry in the Miss Buffer
// has been picked for requesting to dram
////////////

// bug #2196.
// a ld64 miss or any operation in 
// Off mode, will cause fbid_vld to be set 
// but the "mb_way_fb_vld_reset" reset condition
// will never happen. This causes the bit to have
// stale state. Resetting now with fbid vld.
assign	mb_fbid_vld_in = ( mb_fbid_vld | dec_dram_pick_d2 ) &
			~(mb_way_fb_vld_reset | 
				reset_valid_bit_c3) ;

dffrl_s   #(16)  ff_mb_fbid_vld    (.din(mb_fbid_vld_in[15:0]), .clk(rclk),
      .rst_l(dbb_rst_l), .q(mb_fbid_vld[15:0]), .se(se), .si(), .so());

////////////
// Muxing out way and fbid for
// writing into  FBctl
////////////


assign	way_fbid_vld = ( mb_fbid_vld & mb_way_vld) ;

assign	way_fbid_rd_vld_prev = |(way_fbid_vld) ;

dff_s   #(1)  ff_mbctl_fbctl_way_fbid_vld    
		(.din(way_fbid_rd_vld_prev), .clk(rclk),
             .q(mbctl_fbctl_way_fbid_vld), .se(se), .si(), .so());


// Needs to be coded differently for timing.

assign	mb_way_fb_vld_tmp[0] = way_fbid_vld[0] ;
assign	mb_way_fb_vld_tmp[1] = way_fbid_vld[1] &   ~(way_fbid_vld[0]);
assign  mb_way_fb_vld_tmp[2] = way_fbid_vld[2] &   ~(|(way_fbid_vld[1:0])) ;
assign	mb_way_fb_vld_tmp[3] = way_fbid_vld[3] &  ~(|(way_fbid_vld[2:0])) ;
assign  fbsel_def_0123 =  ~(|way_fbid_vld[2:0]);

assign  mb_way_fb_vld_tmp[4] = way_fbid_vld[4] ;
assign  mb_way_fb_vld_tmp[5] = way_fbid_vld[5] &   ~(way_fbid_vld[4]);
assign  mb_way_fb_vld_tmp[6] = way_fbid_vld[6] &   ~(|(way_fbid_vld[5:4])) ;
assign  mb_way_fb_vld_tmp[7] = way_fbid_vld[7] &  ~(|(way_fbid_vld[6:4])) ;
assign  fbsel_def_4567 =  ~(|way_fbid_vld[6:4]);

assign  mb_way_fb_vld_tmp[8] = way_fbid_vld[8] ;
assign  mb_way_fb_vld_tmp[9] = way_fbid_vld[9] &   ~(way_fbid_vld[8]);
assign  mb_way_fb_vld_tmp[10] = way_fbid_vld[10] &   ~(|(way_fbid_vld[9:8])) ;
assign  mb_way_fb_vld_tmp[11] = way_fbid_vld[11] &  ~(|(way_fbid_vld[10:8])) ;
assign  fbsel_def_89ab =  ~(|way_fbid_vld[10:8]);

assign  mb_way_fb_vld_tmp[12] = way_fbid_vld[12] ;
assign  mb_way_fb_vld_tmp[13] = way_fbid_vld[13] &   ~(way_fbid_vld[12]);
assign  mb_way_fb_vld_tmp[14] = way_fbid_vld[14] &   ~(|(way_fbid_vld[13:12])) ;
assign  mb_way_fb_vld_tmp[15] = way_fbid_vld[15] &  ~(|(way_fbid_vld[14:12])) ;
assign  fbsel_def_cdef =  ~(|way_fbid_vld[14:12]);

assign	mb_way_fb_vld_tmp_0to3 = |( way_fbid_vld[3:0]) ;
assign	mb_way_fb_vld_tmp_4to7 = |( way_fbid_vld[7:4]) ;
assign	mb_way_fb_vld_tmp_8to11 = |( way_fbid_vld[11:8]) ;




// signal to reset way vld and fbid vld.
assign	mb_way_fb_vld_reset[3:0] = mb_way_fb_vld_tmp[3:0] ;
assign	mb_way_fb_vld_reset[7:4] = mb_way_fb_vld_tmp[7:4]  & 
					~{4{mb_way_fb_vld_tmp_0to3}} ;
assign	mb_way_fb_vld_reset[11:8] = mb_way_fb_vld_tmp[11:8] & 
					~{4{mb_way_fb_vld_tmp_0to3}} &
					~{4{mb_way_fb_vld_tmp_4to7}};
assign	mb_way_fb_vld_reset[15:12] = mb_way_fb_vld_tmp[15:12]  & 
					~{4{mb_way_fb_vld_tmp_0to3}}
					& ~{4{mb_way_fb_vld_tmp_4to7}} & 
					~{4{mb_way_fb_vld_tmp_8to11}} ;

assign  fbsel_0to3 = mb_way_fb_vld_tmp_0to3 ;
assign  fbsel_4to7 = mb_way_fb_vld_tmp_4to7 & ~mb_way_fb_vld_tmp_0to3;
assign  fbsel_8to11 = mb_way_fb_vld_tmp_8to11 & ~mb_way_fb_vld_tmp_0to3 &
			~mb_way_fb_vld_tmp_4to7 ;
assign  fbsel_def_vld = ~( fbsel_0to3 | fbsel_4to7 | fbsel_8to11 ) ;

dff_s   #(1)  ff_fbsel_0to3_d1    (.din(fbsel_0to3), .clk(rclk),
             .q(fbsel_0to3_d1), .se(se), .si(), .so());

dff_s   #(1)  ff_fbsel_4to7_d1    (.din(fbsel_4to7), .clk(rclk),
             .q(fbsel_4to7_d1), .se(se), .si(), .so());

dff_s   #(1)  ff_fbsel_8tob_d1    (.din(fbsel_8to11), .clk(rclk),
             .q(fbsel_8to11_d1), .se(se), .si(), .so());

dff_s   #(1)  ff_fbsel_ctof_d1    (.din(fbsel_def_vld), .clk(rclk),
             .q(fbsel_def_vld_d1), .se(se), .si(), .so());

assign	sel_mux0 = fbsel_0to3_d1 & ~rst_tri_en;
assign	sel_mux1 = fbsel_4to7_d1 & ~rst_tri_en;
assign	sel_mux2 = fbsel_8to11_d1 & ~rst_tri_en;
assign	sel_mux3 = fbsel_def_vld_d1 | rst_tri_en;


////////////////////////////////////
// 1st level of muxing out the way for Fb write.
////////////////////////////////////
mux4ds  #(4) mux_way_0123  (.dout(way0123[3:0]),
          .in0(way0[3:0]), .in1(way1[3:0]),
          .in2(way2[3:0]), .in3(way3[3:0]),
          .sel0(mb_way_fb_vld_tmp[0]), .sel1(mb_way_fb_vld_tmp[1]),
          .sel2(mb_way_fb_vld_tmp[2]), .sel3(fbsel_def_0123));

mux4ds  #(4) mux_way_4567  (.dout(way4567[3:0]),
          .in0(way4[3:0]), .in1(way5[3:0]),
          .in2(way6[3:0]), .in3(way7[3:0]),
          .sel0(mb_way_fb_vld_tmp[4]), .sel1(mb_way_fb_vld_tmp[5]),
          .sel2(mb_way_fb_vld_tmp[6]), .sel3(fbsel_def_4567));

mux4ds  #(4) mux_way_89ab  (.dout(way89ab[3:0]),
          .in0(way8[3:0]), .in1(way9[3:0]),
          .in2(way10[3:0]), .in3(way11[3:0]),
          .sel0(mb_way_fb_vld_tmp[8]), .sel1(mb_way_fb_vld_tmp[9]),
          .sel2(mb_way_fb_vld_tmp[10]), .sel3(fbsel_def_89ab));

mux4ds  #(4) mux_way_cdef  (.dout(waycdef[3:0]),
          .in0(way12[3:0]), .in1(way13[3:0]),
          .in2(way14[3:0]), .in3(way15[3:0]),
          .sel0(mb_way_fb_vld_tmp[12]), .sel1(mb_way_fb_vld_tmp[13]),
          .sel2(mb_way_fb_vld_tmp[14]), .sel3(fbsel_def_cdef));



dff_s   #(4)  ff_mbctl_fbctl_way_0123    
		(.din(way0123[3:0]), .clk(rclk),
             .q(way0123_d1[3:0]), .se(se), .si(), .so());

dff_s   #(4)  ff_mbctl_fbctl_way_4567    
		(.din(way4567[3:0]), .clk(rclk),
             .q(way4567_d1[3:0]), .se(se), .si(), .so());

dff_s   #(4)  ff_mbctl_fbctl_way_89ab    
		(.din(way89ab[3:0]), .clk(rclk),
             .q(way89ab_d1[3:0]), .se(se), .si(), .so());

dff_s   #(4)  ff_mbctl_fbctl_way_cdef    
		(.din(waycdef[3:0]), .clk(rclk),
             .q(waycdef_d1[3:0]), .se(se), .si(), .so());


////////////////////////////////////
// 2nd  level of muxing out the way for Fb write.
////////////////////////////////////

mux4ds  #(4) mux_way_prev  (.dout(mbctl_fbctl_way[3:0]),
          .in0(way0123_d1[3:0]), .in1(way4567_d1[3:0]),
          .in2(way89ab_d1[3:0]), .in3(waycdef_d1[3:0]),
          .sel0(sel_mux0), .sel1(sel_mux1),
          .sel2(sel_mux2), .sel3(sel_mux3));



////////////////////////////////////////////////////
// 1'st level of muxing out the fbid for Fb write.
//////////////////////////////////////////////////

mux4ds  #(3) mux_fbid_0123  (.dout(fbid0123[2:0]),
          .in0(fbid0[2:0]), .in1(fbid1[2:0]),
          .in2(fbid2[2:0]), .in3(fbid3[2:0]),
          .sel0(mb_way_fb_vld_tmp[0]), .sel1(mb_way_fb_vld_tmp[1]),
          .sel2(mb_way_fb_vld_tmp[2]), .sel3(fbsel_def_0123));

mux4ds  #(3) mux_fbid_4567  (.dout(fbid4567[2:0]),
          .in0(fbid4[2:0]), .in1(fbid5[2:0]),
          .in2(fbid6[2:0]), .in3(fbid7[2:0]),
          .sel0(mb_way_fb_vld_tmp[4]), .sel1(mb_way_fb_vld_tmp[5]),
          .sel2(mb_way_fb_vld_tmp[6]), .sel3(fbsel_def_4567));

mux4ds  #(3) mux_fbid_89ab  (.dout(fbid89ab[2:0]),
          .in0(fbid8[2:0]), .in1(fbid9[2:0]),
          .in2(fbid10[2:0]), .in3(fbid11[2:0]),
          .sel0(mb_way_fb_vld_tmp[8]), .sel1(mb_way_fb_vld_tmp[9]),
          .sel2(mb_way_fb_vld_tmp[10]), .sel3(fbsel_def_89ab));

mux4ds  #(3) mux_fbid_cdef  (.dout(fbidcdef[2:0]),
          .in0(fbid12[2:0]), .in1(fbid13[2:0]),
          .in2(fbid14[2:0]), .in3(fbid15[2:0]),
          .sel0(mb_way_fb_vld_tmp[12]), .sel1(mb_way_fb_vld_tmp[13]),
          .sel2(mb_way_fb_vld_tmp[14]), .sel3(fbsel_def_cdef));


dff_s   #(3)  ff_mbctl_fbctl_fbid_0123    
		(.din(fbid0123[2:0]), .clk(rclk),
             .q(fbid0123_d1[2:0]), .se(se), .si(), .so());

dff_s   #(3)  ff_mbctl_fbctl_fbid_4567    
		(.din(fbid4567[2:0]), .clk(rclk),
             .q(fbid4567_d1[2:0]), .se(se), .si(), .so());

dff_s   #(3)  ff_mbctl_fbctl_fbid_89ab    
		(.din(fbid89ab[2:0]), .clk(rclk),
             .q(fbid89ab_d1[2:0]), .se(se), .si(), .so());

dff_s   #(3)  ff_mbctl_fbctl_fbid_cdef    
		(.din(fbidcdef[2:0]), .clk(rclk),
             .q(fbidcdef_d1[2:0]), .se(se), .si(), .so());


//////////////////////////////////////////////////
// 2nd  level of muxing out the fbid for Fb write.
///////////////////////////////////////////////////

mux4ds  #(3) mux_fbid  (.dout(mbctl_fbctl_fbid[2:0]),
          .in0(fbid0123_d1[2:0]), .in1(fbid4567_d1[2:0]),
          .in2(fbid89ab_d1[2:0]), .in3(fbidcdef_d1[2:0]),
          .sel0(sel_mux0), .sel1(sel_mux1),
          .sel2(sel_mux2), .sel3(sel_mux3));



/////////////////////////////////////////////////////////////
// ERROR LOGIC:
//	CERR and UERR bits are set for all instructions that
//	make two passes even when they hit the L2. THis includes
//	psts, cas, swap/ldstub instrctions.
//
// CERR: For PSTs, Ldstubs, SWAPs and CAs instructions, 
// the l2 data or Fb corr err signal is recorded in mb_corr_err
// so as to signal a disrupting trap to the sparc and thread
// that the instr. is performed by. Note that only for a non-atomic
// store, this ERR is actually signalled with a store. For
// atomic stores, this is not used.Gating off of atomic stores
// is done in tagctl.
//
// UNCORR: This bit has a dual purpose. The one mentioned above
// and also it is used to gate off the store part of the atomic
// or a partial store.
/////////////////////////////////////////////////////////////


// A CAS sets its ctrue bit only in C9.
// The following logic uses either the C8 errors or the C9 errors
// for setting the mbctl_err bits based on whether the "ctrue setting"
// instruction is a regular PST or a CAS instruction.



assign	  mbctl_corr_err_c8 = decc_spcd_corr_err_c8 | decc_spcfb_corr_err_c8 ;

assign       mb_corr_err_in = ( (pst_ctrue_set_c8 & {16{ mbctl_corr_err_c8}})| // PST errors
				//(cas_ctrue_set_c9 & {16{ mbctl_corr_err_c9}})| // CAS errors.
				mb_corr_err  )
                                & ~reset_valid_bit_c3 ;

dffrl_s   #(16)  ff_mb_corr_err    (.din(mb_corr_err_in[15:0]), .clk(rclk),
                                .q(mb_corr_err[15:0]), .rst_l(dbb_rst_l),
                                .se(se), .si(), .so());

assign       mb_uncorr_err_in = (( pst_ctrue_set_c8 & {16{decc_uncorr_err_c8}}) |
				 ( cas_ctrue_set_c9 & {16{uncorr_err_c9}}) |
				 mb_uncorr_err  ) 
				& ~reset_valid_bit_c3 ;

dffrl_s   #(16)  ff_mb_uncorr_err    (.din(mb_uncorr_err_in[15:0]), .clk(rclk),
				.q(mb_uncorr_err[15:0]), 
				.rst_l(dbb_rst_l),
                                .se(se), .si(), .so());


//////////////////////////////////////////////////////////
// ERR bit to sctag_tagctl to gate off writes to the 
// data array.
//////////////////////////////////////////////////////////

assign  mb_entry_dec_c1[0] =  ( arbdp_inst_mb_entry_c1 == 4'd0 ) ;
assign  mb_entry_dec_c1[1] =  ( arbdp_inst_mb_entry_c1 == 4'd1 ) ;
assign  mb_entry_dec_c1[2] =  ( arbdp_inst_mb_entry_c1 == 4'd2 ) ;
assign  mb_entry_dec_c1[3] =  ( arbdp_inst_mb_entry_c1 == 4'd3 ) ;
assign  mb_entry_dec_c1[4] =  ( arbdp_inst_mb_entry_c1 == 4'd4 ) ;
assign  mb_entry_dec_c1[5] =  ( arbdp_inst_mb_entry_c1 == 4'd5 ) ;
assign  mb_entry_dec_c1[6] =  ( arbdp_inst_mb_entry_c1 == 4'd6 ) ;
assign  mb_entry_dec_c1[7] =  ( arbdp_inst_mb_entry_c1 == 4'd7 ) ;
assign  mb_entry_dec_c1[8] =  ( arbdp_inst_mb_entry_c1 == 4'd8 ) ;
assign  mb_entry_dec_c1[9] =  ( arbdp_inst_mb_entry_c1 == 4'd9 ) ;
assign  mb_entry_dec_c1[10] = ( arbdp_inst_mb_entry_c1 == 4'd10 ) ;
assign  mb_entry_dec_c1[11] = ( arbdp_inst_mb_entry_c1 == 4'd11 ) ;
assign  mb_entry_dec_c1[12] = ( arbdp_inst_mb_entry_c1 == 4'd12 ) ;
assign  mb_entry_dec_c1[13] = ( arbdp_inst_mb_entry_c1 == 4'd13 ) ;
assign  mb_entry_dec_c1[14] = ( arbdp_inst_mb_entry_c1 == 4'd14 ) ;
assign  mb_entry_dec_c1[15] = ( arbdp_inst_mb_entry_c1 == 4'd15 ) ;

assign  mbctl_corr_err_c1 = |( mb_entry_dec_c1 & mb_corr_err )  ;

assign  mbctl_uncorr_err_c1 = |( mb_entry_dec_c1 & mb_uncorr_err ) ;

dff_s   #(1)  ff_mbctl_corr_err_c2    (.din(mbctl_corr_err_c1), .clk(rclk),
                                .q(mbctl_corr_err_unqual_c2),
                                .se(se), .si(), .so());

dff_s   #(1)  ff_mbctl_uncorr_err_c2    (.din(mbctl_uncorr_err_c1), .clk(rclk),
                                .q(mbctl_uncorr_err_unqual_c2),
                                .se(se), .si(), .so());

//assign	mbctl_corr_err_c2 = arbdp_inst_mb_c2 & mbctl_corr_err_unqual_c2 ;
//assign	mbctl_uncorr_err_c2 = arbdp_inst_mb_c2 & mbctl_uncorr_err_unqual_c2 ;

// arbdp_inst_mb_c2 qualification may not be required since
// these expressions are qualified with pst_with_ctrue_c?
// which implies that an instruction is from the Miss Buffer.

assign	mbctl_corr_err_c2 =   mbctl_corr_err_unqual_c2 ;
assign	mbctl_uncorr_err_c2 =   mbctl_uncorr_err_unqual_c2 ;




////////////////////////////////////////////////////////////////////////
// MBF  PICKER: THe picker in the MBF is shared between L2 and DRAM
//	request picks. The DRAM request pick has preference over
//	the L2 request.
//
// l2 pick: mb_l2_ready is pre-conditioned to account for rdma reads.
// 	An rdma read  will be  picked only if the rdma register in
//	tagctl is invalid. Since the PICK is performed in PX0, the
//	rdma register valid signal from tagctl is a PX0_p signal that
// 	is used after flopping one cycle.
//
//	For more details, read the description of the rdma register 
//	in tagctl.
//
////////////////////////////////////////////////////////////////////////



assign	mb_l2_ready_qual_in = mb_l2_ready_in & 
			~({16{tagctl_rdma_vld_px0_p}} & mb_rdma ) ;

dff_s   #(16)  ff_mb_l2_ready_qual    (.din(mb_l2_ready_qual_in[15:0]), .clk(rclk),
                  .q(mb_l2_ready_qual[15:0]), .se(se), .si(), .so());


dff_s   #(1)  ff_dram_pick_1    (.din(dram_pick_prev), .clk(rclk),
             .q(dram_pick_1), .se(se), .si(), .so());

dff_s   #(1)  ff_dram_pick_2_l    (.din(~dram_pick_prev), .clk(rclk),
             .q(dram_pick_2_l), .se(se), .si(), .so());


assign  dram_pick_vec  = mb_dram_ready ;

assign  l2_pick_vec = (( mb_l2_ready_qual | mb_evict_ready | mb_tecc_ready)
                        & mb_data_vld) ;

mux2ds #(16) mux_mb_read_pick_vec ( .dout ( mb_read_pick_vec[15:0]),
                         .in0(dram_pick_vec[15:0]),
                         .in1(l2_pick_vec[15:0]),
                         .sel0(dram_pick_1),
                         .sel1(dram_pick_2_l));




/////////////////
// PICKER
/////////////////
assign  pick_quad0_in = mb_read_pick_vec[3:0] ;
assign  pick_quad1_in = mb_read_pick_vec[7:4] ;
assign  pick_quad2_in = mb_read_pick_vec[11:8] ;
assign  pick_quad3_in = mb_read_pick_vec[15:12] ;

assign  pick_quad_in[0] = |( pick_quad0_in ) ;
assign  pick_quad_in[1] = |( pick_quad1_in ) ;
assign  pick_quad_in[2] = |( pick_quad2_in ) ;
assign  pick_quad_in[3] = |( pick_quad3_in ) ;


assign	init_pick_state = ~dbb_rst_l | ~dbginit_l;
assign	sel_dram_lshift = dram_pick_d1 & ~init_pick_state ;
assign	sel_dram_same = ~dram_pick_d1  & ~init_pick_state ;

assign	dram_pick_state_lshift = { dram_pick_state[2:0], dram_pick_state[3] } ;

mux3ds  #(4) mux_dram_st  (.dout(dram_pick_state_prev[3:0]),
                           .in0(4'b1),
                           .in1(dram_pick_state_lshift[3:0]),
                           .in2(dram_pick_state[3:0]),
                           .sel0(init_pick_state),
                           .sel1(sel_dram_lshift),
                           .sel2(sel_dram_same)) ;

dff_s   #(4)  ff_dram_state    (.din(dram_pick_state_prev[3:0]), .clk(rclk),
               .q(dram_pick_state[3:0]), .se(se), .si(), .so());


// DRAM STATE quad0
assign  sel_dram_lshift_quad0 = dram_pick_d1 & (|(picker_out_d1[3:0])) & 
				 ~init_pick_state ;
assign  sel_dram_same_quad0 = ~( dram_pick_d1  & (|(picker_out_d1[3:0])) )  
				&  ~init_pick_state ;
assign  dram_pick_state_lshift_quad0 = { dram_pick_state_quad0[2:0], 
				dram_pick_state_quad0[3] } ;

mux3ds  #(4) mux_dram_st_quad0  (.dout(dram_pick_state_prev_quad0[3:0]),
                           .in0(4'b1),
                           .in1(dram_pick_state_lshift_quad0[3:0]),
                           .in2(dram_pick_state_quad0[3:0]),
                           .sel0(init_pick_state),
                           .sel1(sel_dram_lshift_quad0),
                           .sel2(sel_dram_same_quad0)) ;


dff_s   #(4)  ff_dram_state_quad0    (.din(dram_pick_state_prev_quad0[3:0]), .clk(rclk),
                .q(dram_pick_state_quad0[3:0]), .se(se), .si(), .so());


// DRAM STATE quad1



assign  sel_dram_lshift_quad1 = dram_pick_d1 & (|(picker_out_d1[7:4])) 
			&  ~init_pick_state ;
assign  sel_dram_same_quad1 = ~( dram_pick_d1  & (|(picker_out_d1[7:4])) )  
			&  ~init_pick_state ;
assign  dram_pick_state_lshift_quad1 = { dram_pick_state_quad1[2:0], 
			dram_pick_state_quad1[3] } ;

mux3ds  #(4) mux_dram_st_quad1  (.dout(dram_pick_state_prev_quad1[3:0]),
                           .in0(4'b1),
                           .in1(dram_pick_state_lshift_quad1[3:0]),
                           .in2(dram_pick_state_quad1[3:0]),
                           .sel0(init_pick_state),
                           .sel1(sel_dram_lshift_quad1),
                           .sel2(sel_dram_same_quad1)) ;


dff_s   #(4)  ff_dram_state_quad1    (.din(dram_pick_state_prev_quad1[3:0]), .clk(rclk),
                            .q(dram_pick_state_quad1[3:0]), .se(se), .si(), .so());


// DRAM STATE quad2
assign  sel_dram_lshift_quad2 = dram_pick_d1 & (|(picker_out_d1[11:8])) 
				&  ~init_pick_state ;
assign  sel_dram_same_quad2 = ~( dram_pick_d1  & (|(picker_out_d1[11:8])) )  
				&  ~init_pick_state ;
assign  dram_pick_state_lshift_quad2 = { dram_pick_state_quad2[2:0], 
			dram_pick_state_quad2[3] } ;

mux3ds  #(4) mux_dram_st_quad2  (.dout(dram_pick_state_prev_quad2[3:0]),
                           .in0(4'b1),
                           .in1(dram_pick_state_lshift_quad2[3:0]),
                           .in2(dram_pick_state_quad2[3:0]),
                           .sel0(init_pick_state),
                           .sel1(sel_dram_lshift_quad2),
                           .sel2(sel_dram_same_quad2)) ;


dff_s   #(4)  ff_dram_state_quad2    (.din(dram_pick_state_prev_quad2[3:0]), .clk(rclk),
               .q(dram_pick_state_quad2[3:0]), .se(se), .si(), .so());

// DRAM STATE quad3
assign  sel_dram_lshift_quad3 = dram_pick_d1 & (|(picker_out_d1[15:12])) 
				&  ~init_pick_state ;
assign  sel_dram_same_quad3 = ~( dram_pick_d1  & (|(picker_out_d1[15:12])) )  
				&  ~init_pick_state ;
assign  dram_pick_state_lshift_quad3 = { dram_pick_state_quad3[2:0], 
				dram_pick_state_quad3[3] } ;

mux3ds  #(4) mux_dram_st_quad3  (.dout(dram_pick_state_prev_quad3[3:0]),
                           .in0(4'b1),
                           .in1(dram_pick_state_lshift_quad3[3:0]),
                           .in2(dram_pick_state_quad3[3:0]),
                           .sel0(init_pick_state),
                           .sel1(sel_dram_lshift_quad3),
                           .sel2(sel_dram_same_quad3)) ;

dff_s   #(4)  ff_dram_state_quad3    (.din(dram_pick_state_prev_quad3[3:0]), .clk(rclk),
               .q(dram_pick_state_quad3[3:0]), .se(se), .si(), .so());






// L2  STATE
assign  sel_l2_lshift = l2_pick_d1 &  ~init_pick_state  ;
assign  sel_l2_same =  ~l2_pick_d1    &  ~init_pick_state  ;
assign	l2_pick_state_lshift = { l2_pick_state[2:0], l2_pick_state[3] } ;

mux3ds  #(4) mux_l2_st  (.dout(l2_pick_state_prev[3:0]),
                           .in0(4'b1),
                           .in1(l2_pick_state_lshift[3:0]),
                           .in2(l2_pick_state[3:0]),
                           .sel0(init_pick_state),
                           .sel1(sel_l2_lshift),
                           .sel2(sel_l2_same)) ;


dff_s   #(4)  ff_l2_state    (.din(l2_pick_state_prev[3:0]), .clk(rclk),
                    .q(l2_pick_state[3:0]), .se(se), .si(), .so());



// L2 state quad0


assign  sel_l2_lshift_quad0 = ( l2_pick_d1 & (|(picker_out_d1[3:0]))) &  
				~init_pick_state  ;
assign  sel_l2_same_quad0 =   ~( l2_pick_d1 & (|(picker_out_d1[3:0])) )   
				&  ~init_pick_state ;
assign  l2_pick_state_lshift_quad0 = { l2_pick_state_quad0[2:0], l2_pick_state_quad0[3] } ;

mux3ds  #(4) mux_l2_st_quad0  (.dout(l2_pick_state_prev_quad0[3:0]),
                           .in0(4'b1),
                           .in1(l2_pick_state_lshift_quad0[3:0]),
                           .in2(l2_pick_state_quad0[3:0]),
                           .sel0(init_pick_state),
                           .sel1(sel_l2_lshift_quad0),
                           .sel2(sel_l2_same_quad0)) ;


dff_s   #(4)  ff_l2_state_quad0    (.din(l2_pick_state_prev_quad0[3:0]), .clk(rclk),
                 .q(l2_pick_state_quad0[3:0]), .se(se), .si(), .so());

// L2 state quad1

assign  sel_l2_lshift_quad1 = ( l2_pick_d1 & (|(picker_out_d1[7:4])) ) 
				&  ~init_pick_state  ;
assign  sel_l2_same_quad1 =   ~( l2_pick_d1 & (|(picker_out_d1[7:4])) )   
				&  ~init_pick_state ;
assign  l2_pick_state_lshift_quad1 = { l2_pick_state_quad1[2:0], 
				l2_pick_state_quad1[3] } ;

mux3ds  #(4) mux_l2_st_quad1  (.dout(l2_pick_state_prev_quad1[3:0]),
                           .in0(4'b1),
                           .in1(l2_pick_state_lshift_quad1[3:0]),
                           .in2(l2_pick_state_quad1[3:0]),
                           .sel0(init_pick_state),
                           .sel1(sel_l2_lshift_quad1),
                           .sel2(sel_l2_same_quad1)) ;


dff_s   #(4)  ff_l2_state_quad1    (.din(l2_pick_state_prev_quad1[3:0]), .clk(rclk),
                 .q(l2_pick_state_quad1[3:0]), .se(se), .si(), .so());

// L2 state quad2


assign  sel_l2_lshift_quad2 = ( l2_pick_d1 & (|(picker_out_d1[11:8])) ) 
			&  ~init_pick_state  ;
assign  sel_l2_same_quad2 =   ~( l2_pick_d1 & (|(picker_out_d1[11:8])) )   
			&  ~init_pick_state ;
assign  l2_pick_state_lshift_quad2 = { l2_pick_state_quad2[2:0], 
			l2_pick_state_quad2[3] } ;

mux3ds  #(4) mux_l2_st_quad2  (.dout(l2_pick_state_prev_quad2[3:0]),
                           .in0(4'b1),
                           .in1(l2_pick_state_lshift_quad2[3:0]),
                           .in2(l2_pick_state_quad2[3:0]),
                           .sel0(init_pick_state),
                           .sel1(sel_l2_lshift_quad2),
                           .sel2(sel_l2_same_quad2)) ;


dff_s   #(4)  ff_l2_state_quad2    (.din(l2_pick_state_prev_quad2[3:0]), .clk(rclk),
                 .q(l2_pick_state_quad2[3:0]), .se(se), .si(), .so());


// L2 state quad3


assign  sel_l2_lshift_quad3 = ( l2_pick_d1 & (|(picker_out_d1[15:12])) ) 
			&  ~init_pick_state  ;
assign  sel_l2_same_quad3 =   ~( l2_pick_d1 & (|(picker_out_d1[15:12])) )   
			&  ~init_pick_state ;
assign  l2_pick_state_lshift_quad3 = { l2_pick_state_quad3[2:0], 
			l2_pick_state_quad3[3] } ;

mux3ds  #(4) mux_l2_st_quad3  (.dout(l2_pick_state_prev_quad3[3:0]),
                           .in0(4'b1),
                           .in1(l2_pick_state_lshift_quad3[3:0]),
                           .in2(l2_pick_state_quad3[3:0]),
                           .sel0(init_pick_state),
                           .sel1(sel_l2_lshift_quad3),
                           .sel2(sel_l2_same_quad3)) ;


dff_s   #(4)  ff_l2_state_quad3    (.din(l2_pick_state_prev_quad3[3:0]), .clk(rclk),
                         .q(l2_pick_state_quad3[3:0]), .se(se), .si(), .so());


// mux for picking the anchor of the RPE.
// real dram pick


mux2ds #(4) mux_pick_state ( .dout ( pick_state[3:0]),
                         .in0(l2_pick_state[3:0]),
                         .in1(dram_pick_state[3:0]),
                         .sel0(~dram_pick),
                         .sel1(dram_pick));

mux2ds #(4) mux_pick_state_quad0 ( .dout(pick_state_quad0[3:0]),
                         .in0(l2_pick_state_quad0[3:0]),
                         .in1(dram_pick_state_quad0[3:0]),
                         .sel0(~dram_pick),
                         .sel1(dram_pick));

mux2ds #(4) mux_pick_state_quad1 ( .dout (pick_state_quad1[3:0]),
                         .in0(l2_pick_state_quad1[3:0]),
                         .in1(dram_pick_state_quad1[3:0]),
                         .sel0(~dram_pick),
                         .sel1(dram_pick));

mux2ds #(4) mux_pick_state_quad2 ( .dout (pick_state_quad2[3:0]),
                         .in0(l2_pick_state_quad2[3:0]),
                         .in1(dram_pick_state_quad2[3:0]),
                         .sel0(~dram_pick),
                         .sel1(dram_pick));

mux2ds #(4) mux_pick_state_quad3 ( .dout (pick_state_quad3[3:0]),
                         .in0(l2_pick_state_quad3[3:0]),
                         .in1(dram_pick_state_quad3[3:0]),
                         .sel0(~dram_pick),
                         .sel1(dram_pick));




assign  pick_s0 = pick_state[0] ;
assign	pick_s1 = pick_state[1] ;
assign	pick_s2 = pick_state[2] ;
assign  pick_s3 = pick_state[3] ;


assign	pick_s0_quad0 = pick_state_quad0[0];
assign	pick_s1_quad0 = pick_state_quad0[1];
assign	pick_s2_quad0 = pick_state_quad0[2];
assign	pick_s3_quad0 = pick_state_quad0[3];


assign	pick_s0_quad1 = pick_state_quad1[0];
assign	pick_s1_quad1 = pick_state_quad1[1];
assign	pick_s2_quad1 = pick_state_quad1[2];
assign	pick_s3_quad1 = pick_state_quad1[3];


assign	pick_s0_quad2 = pick_state_quad2[0];
assign	pick_s1_quad2 = pick_state_quad2[1];
assign	pick_s2_quad2 = pick_state_quad2[2];
assign	pick_s3_quad2 = pick_state_quad2[3];


assign	pick_s0_quad3 = pick_state_quad3[0];
assign	pick_s1_quad3 = pick_state_quad3[1];
assign	pick_s2_quad3 = pick_state_quad3[2];
assign	pick_s3_quad3 = pick_state_quad3[3];




// QUAD0 bits.
assign	pick_quad0_sel[0] = pick_quad0_in[0] &  ( pick_s0_quad0 | 
		( pick_s1_quad0 & ~( pick_quad0_in[1] |
			pick_quad0_in[2] | pick_quad0_in[3] ) ) |
			( pick_s2_quad0 & ~(pick_quad0_in[2] | pick_quad0_in[3] )) |
			( pick_s3_quad0 & ~(pick_quad0_in[3] )  ) ) ;


assign	pick_quad0_sel[1] = pick_quad0_in[1] &  ( pick_s1_quad0 |
                ( pick_s2_quad0 & ~( pick_quad0_in[2] |
                        pick_quad0_in[3] | pick_quad0_in[0] ) ) |
                        ( pick_s3_quad0 & ~(pick_quad0_in[3] | pick_quad0_in[0] )) |
                        ( pick_s0_quad0 & ~(pick_quad0_in[0] )  ) ) ;


assign	pick_quad0_sel[2] = pick_quad0_in[2] &  ( pick_s2_quad0 |
                ( pick_s3_quad0 & ~( pick_quad0_in[3] |
                        pick_quad0_in[0] | pick_quad0_in[1] ) ) |
                        ( pick_s0_quad0 & ~(pick_quad0_in[0] | pick_quad0_in[1] )) |
                        ( pick_s1_quad0 & ~(pick_quad0_in[1] )  ) ) ;

assign	pick_quad0_sel[3] = pick_quad0_in[3] &  ( pick_s3_quad0 |
                ( pick_s0_quad0 & ~( pick_quad0_in[0] |
                        pick_quad0_in[1] | pick_quad0_in[2] ) ) |
                        ( pick_s1_quad0 & ~(pick_quad0_in[1] | pick_quad0_in[2] )) |
                        ( pick_s2_quad0 & ~(pick_quad0_in[2] )  ) ) ;


// QUAD1 bits.
assign  pick_quad1_sel[0] = pick_quad1_in[0] &  ( pick_s0_quad1 |
                ( pick_s1_quad1 & ~( pick_quad1_in[1] |
                        pick_quad1_in[2] | pick_quad1_in[3] ) ) |
                        ( pick_s2_quad1 & ~(pick_quad1_in[2] | pick_quad1_in[3] )) |
                        ( pick_s3_quad1 & ~(pick_quad1_in[3] )  ) ) ;


assign  pick_quad1_sel[1] = pick_quad1_in[1] &  ( pick_s1_quad1 |
                ( pick_s2_quad1 & ~( pick_quad1_in[2] |
                        pick_quad1_in[3] | pick_quad1_in[0] ) ) |
                        ( pick_s3_quad1 & ~(pick_quad1_in[3] | pick_quad1_in[0] )) |
                        ( pick_s0_quad1 & ~(pick_quad1_in[0] )  ) ) ;


assign  pick_quad1_sel[2] = pick_quad1_in[2] &  ( pick_s2_quad1 |
                ( pick_s3_quad1 & ~( pick_quad1_in[3] |
                        pick_quad1_in[0] | pick_quad1_in[1] ) ) |
                        ( pick_s0_quad1 & ~(pick_quad1_in[0] | pick_quad1_in[1] )) |
                        ( pick_s1_quad1 & ~(pick_quad1_in[1] )  ) ) ;

assign  pick_quad1_sel[3] = pick_quad1_in[3] &  ( pick_s3_quad1 |
                ( pick_s0_quad1 & ~( pick_quad1_in[0] |
                        pick_quad1_in[1] | pick_quad1_in[2] ) ) |
                        ( pick_s1_quad1 & ~(pick_quad1_in[1] | pick_quad1_in[2] )) |
                        ( pick_s2_quad1 & ~(pick_quad1_in[2] )  ) ) ; 

// QUAD2 bits.
assign  pick_quad2_sel[0] = pick_quad2_in[0] &  ( pick_s0_quad2 |
                ( pick_s1_quad2 & ~( pick_quad2_in[1] |
                        pick_quad2_in[2] | pick_quad2_in[3] ) ) |
                        ( pick_s2_quad2 & ~(pick_quad2_in[2] | pick_quad2_in[3] )) |
                        ( pick_s3_quad2 & ~(pick_quad2_in[3] )  ) ) ;


assign  pick_quad2_sel[1] = pick_quad2_in[1] &  ( pick_s1_quad2 |
                ( pick_s2_quad2 & ~( pick_quad2_in[2] |
                        pick_quad2_in[3] | pick_quad2_in[0] ) ) |
                        ( pick_s3_quad2 & ~(pick_quad2_in[3] | pick_quad2_in[0] )) |
                        ( pick_s0_quad2 & ~(pick_quad2_in[0] )  ) ) ;


assign  pick_quad2_sel[2] = pick_quad2_in[2] &  ( pick_s2_quad2 |
                ( pick_s3_quad2 & ~( pick_quad2_in[3] |
                        pick_quad2_in[0] | pick_quad2_in[1] ) ) |
                        ( pick_s0_quad2 & ~(pick_quad2_in[0] | pick_quad2_in[1] )) |
                        ( pick_s1_quad2 & ~(pick_quad2_in[1] )  ) ) ;

assign  pick_quad2_sel[3] = pick_quad2_in[3] &  ( pick_s3_quad2 |
                ( pick_s0_quad2 & ~( pick_quad2_in[0] |
                        pick_quad2_in[1] | pick_quad2_in[2] ) ) |
                        ( pick_s1_quad2 & ~(pick_quad2_in[1] | pick_quad2_in[2] )) |
                        ( pick_s2_quad2 & ~(pick_quad2_in[2] )  ) ) ; 


// QUAD3 bits.
assign  pick_quad3_sel[0] = pick_quad3_in[0] &  ( pick_s0_quad3 |
                ( pick_s1_quad3 & ~( pick_quad3_in[1] |
                        pick_quad3_in[2] | pick_quad3_in[3] ) ) |
                        ( pick_s2_quad3 & ~(pick_quad3_in[2] | pick_quad3_in[3] )) |
                        ( pick_s3_quad3 & ~(pick_quad3_in[3] )  ) ) ;


assign  pick_quad3_sel[1] = pick_quad3_in[1] &  ( pick_s1_quad3 |
                ( pick_s2_quad3 & ~( pick_quad3_in[2] |
                        pick_quad3_in[3] | pick_quad3_in[0] ) ) |
                        ( pick_s3_quad3 & ~(pick_quad3_in[3] | pick_quad3_in[0] )) |
                        ( pick_s0_quad3 & ~(pick_quad3_in[0] )  ) ) ;


assign  pick_quad3_sel[2] = pick_quad3_in[2] &  ( pick_s2_quad3 |
                ( pick_s3_quad3 & ~( pick_quad3_in[3] |
                        pick_quad3_in[0] | pick_quad3_in[1] ) ) |
                        ( pick_s0_quad3 & ~(pick_quad3_in[0] | pick_quad3_in[1] )) |
                        ( pick_s1_quad3 & ~(pick_quad3_in[1] )  ) ) ;

assign  pick_quad3_sel[3] = pick_quad3_in[3] &  ( pick_s3_quad3 |
                ( pick_s0_quad3 & ~( pick_quad3_in[0] |
                        pick_quad3_in[1] | pick_quad3_in[2] ) ) |
                        ( pick_s1_quad3 & ~(pick_quad3_in[1] | pick_quad3_in[2] )) |
                        ( pick_s2_quad3 & ~(pick_quad3_in[2] )  ) ) ; 


// QUAD3 bits.
assign  pick_quad_sel[0] = pick_quad_in[0] &  ( pick_s0 |
                ( pick_s1 & ~( pick_quad_in[1] |
                        pick_quad_in[2] | pick_quad_in[3] ) ) |
                        ( pick_s2 & ~(pick_quad_in[2] | pick_quad_in[3] )) |
                        ( pick_s3 & ~(pick_quad_in[3] )  ) ) ;


assign  pick_quad_sel[1] = pick_quad_in[1] &  ( pick_s1 |
                ( pick_s2 & ~( pick_quad_in[2] |
                        pick_quad_in[3] | pick_quad_in[0] ) ) |
                        ( pick_s3 & ~(pick_quad_in[3] | pick_quad_in[0] )) |
                        ( pick_s0 & ~(pick_quad_in[0] )  ) ) ;


assign  pick_quad_sel[2] = pick_quad_in[2] &  ( pick_s2 |
                ( pick_s3 & ~( pick_quad_in[3] |
                        pick_quad_in[0] | pick_quad_in[1] ) ) |
                        ( pick_s0 & ~(pick_quad_in[0] | pick_quad_in[1] )) |
                        ( pick_s1 & ~(pick_quad_in[1] )  ) ) ;

assign  pick_quad_sel[3] = pick_quad_in[3] &  ( pick_s3 |
                ( pick_s0 & ~( pick_quad_in[0] |
                        pick_quad_in[1] | pick_quad_in[2] ) ) |
                        ( pick_s1 & ~(pick_quad_in[1] | pick_quad_in[2] )) |
                        ( pick_s2 & ~(pick_quad_in[2] )  ) ) ; 


assign picker_out[3:0]	= pick_quad0_sel & {4{pick_quad_sel[0] & picker_out_qual }}  ;
assign picker_out[7:4]	= pick_quad1_sel & {4{pick_quad_sel[1] & picker_out_qual }}  ;
assign picker_out[11:8]	= pick_quad2_sel & {4{pick_quad_sel[2] & picker_out_qual }}  ;
assign picker_out[15:12] = pick_quad3_sel & {4{pick_quad_sel[3]& picker_out_qual }}  ;


dff_s   #(16)  ff_picker_out_d1    (.din(picker_out[15:0]), .clk(rclk),
                  .q(picker_out_d1[15:0]), .se(se), .si(), .so());

dff_s   #(16)  ff_picker_out_d2    (.din(picker_out_d1[15:0]), .clk(rclk),
                  .q(picker_out_d2[15:0]), .se(se), .si(), .so());

// Read wordlines for the tag and data arrays.
// setup will depend on timing of picker_out_qual i.e. "mbsel_px" 

assign	mb_read_wl = picker_out ;



endmodule


module adder_1b(/*AUTOARG*/
   // Outputs
   cout, sum, 
   // Inputs
   oper1, oper2, cin
   );
input   oper1;
input   oper2;
input   cin;
output  cout;
output  sum;

assign  sum = oper1 ^ oper2 ^ cin ;
assign  cout =  ( cin & ( oper1 | oper2 ) ) |
                ( oper1 & oper2 ) ;

endmodule

module adder_2b(/*AUTOARG*/
   // Outputs
   sum, cout, 
   // Inputs
   oper1, oper2, cin
   );

input   [1:0]	oper1;
input   [1:0]	oper2;
input   cin;
output  [1:0]	sum;
output  cout;

wire    [1:0]   gen, prop;
wire    [2:0]   carry ;

assign  carry[0] = cin;

assign  gen[0] = oper1[0] & oper2[0] ;
assign  prop[0] = oper1[0] | oper2[0] ;
assign  sum[0] = oper1[0] ^ oper2[0] ^ carry[0] ;


assign  carry[1] = ( carry[0]  & prop[0] ) | gen[0] ;

assign  gen[1] = oper1[1] & oper2[1] ;
assign  prop[1] = oper1[1] | oper2[1] ;
assign  sum[1] = oper1[1] ^ oper2[1] ^ carry[1] ;

assign  carry[2] = ( carry[0] & prop[0]  & prop[1] ) |
                ( gen[0]  &  prop[1] ) |
                 gen[1] ;

assign  cout = carry[2] ;


endmodule


module adder_3b(/*AUTOARG*/
   // Outputs
   sum, cout, 
   // Inputs
   oper1, oper2, cin
   );

input   [2:0]	oper1;
input   [2:0]	oper2;
input   cin;
output  [2:0]	sum;
output	cout;

wire    [2:0]   gen, prop;
wire    [3:0]   carry ;

assign  carry[0] = cin;

assign  gen[0] = oper1[0] & oper2[0] ;
assign  prop[0] = oper1[0] | oper2[0] ;
assign  sum[0] = oper1[0] ^ oper2[0] ^ carry[0] ;


assign  carry[1] = ( carry[0]  & prop[0] ) | gen[0] ;

assign  gen[1] = oper1[1] & oper2[1] ;
assign  prop[1] = oper1[1] | oper2[1] ;
assign  sum[1] = oper1[1] ^ oper2[1] ^ carry[1] ;

assign  carry[2] = ( carry[0]  & prop[0] & prop[1] ) |
                ( gen[0]  & prop[1] ) | gen[1]   ;

assign  gen[2] = oper1[2] & oper2[2] ;
assign  prop[2] = oper1[2] | oper2[2] ;
assign  sum[2] = oper1[2] ^ oper2[2] ^ carry[2] ;

assign  carry[3] = ( carry[0]  & prop[0] & prop[1] & prop[2] ) |
                        ( gen[0]  & prop[1] & prop[2] ) |
                        ( gen[1]  & prop[2] ) | gen[2]   ;


assign  cout = carry[3];

endmodule

module adder_4b(/*AUTOARG*/
   // Outputs
   sum, cout, 
   // Inputs
   oper1, oper2, cin
   );

input   [3:0]	oper1;
input   [3:0]	oper2;
input   cin;
output  [3:0]	sum;
output	cout;

wire    [3:0]   gen, prop;
wire    [4:0]   carry ;

assign  carry[0] = cin;

assign  gen[0] = oper1[0] & oper2[0] ;
assign  prop[0] = oper1[0] | oper2[0] ;
assign  sum[0] = oper1[0] ^ oper2[0] ^ carry[0] ;


assign  carry[1] = ( carry[0]  & prop[0] ) | gen[0] ;

assign  gen[1] = oper1[1] & oper2[1] ;
assign  prop[1] = oper1[1] | oper2[1] ;
assign  sum[1] = oper1[1] ^ oper2[1] ^ carry[1] ;

assign  carry[2] = ( carry[0]  & prop[0] & prop[1] ) |
                ( gen[0]  & prop[1] ) | gen[1]   ;

assign  gen[2] = oper1[2] & oper2[2] ;
assign  prop[2] = oper1[2] | oper2[2] ;
assign  sum[2] = oper1[2] ^ oper2[2] ^ carry[2] ;

assign  carry[3] = ( carry[0]  & prop[0] & prop[1] & prop[2] ) |
                        ( gen[0]  & prop[1] & prop[2] ) |
                        ( gen[1]  & prop[2] ) | gen[2]   ;

assign  gen[3] = oper1[3] & oper2[3] ;
assign  prop[3] = oper1[3] | oper2[3] ;
assign  sum[3] = oper1[3] ^ oper2[3] ^ carry[3] ;

assign  carry[4] = ( carry[0]  & prop[0] & prop[1] & prop[2]  & prop[3] ) |
                        ( gen[0]  & prop[1] & prop[2] & prop[3] ) |
                        ( gen[1]  & prop[2] & prop[3] ) | 
			( gen[2] & prop[3] ) |
			( gen[3] );   



assign  cout = carry[4];

endmodule



