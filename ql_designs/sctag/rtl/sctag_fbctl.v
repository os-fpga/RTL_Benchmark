// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_fbctl.v
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
////////////////////////////////////////////////////////////////////////

module sctag_fbctl( /*AUTOARG*/
   // Outputs
   fbctl_fbtag_wr_ptr, fbctl_fbtag_wr_en, fbctl_buf_rd_en, 
   fbctl_fbtag_rd_ptr, so, fbctl_tagctl_hit_c2, fbctl_fbd_rd_en_c2, 
   fbctl_fbd_rd_entry_c2, dram_sctag_chunk_id_r1, 
   dram_sctag_data_vld_r1, fbctl_fbd_wr_entry_r1, 
   sctag_dram_rd_req_id, fb_count_eq_0, fbctl_mbctl_entry_avail, 
   fbctl_mbctl_match_c2, fbctl_mbctl_fbid_d2, fbf_enc_ld_mbid_r1, 
   fbf_ready_miss_r1, fbf_enc_dep_mbid_c4, fbf_st_or_dep_rdy_c4, 
   fbctl_mbctl_nofill_d2, fbctl_mbctl_stinst_match_c2, 
   scdata_fb_hit_c3, fbctl_vuad_bypassed_c3, fbctl_arb_l2rd_en, 
   fbctl_arbdp_way_px2, fbctl_arbdp_tecc_px2, fbctl_arbdp_entry_px2, 
   fbctl_arbctl_vld_px1, fbctl_corr_err_c8, fbctl_uncorr_err_c8, 
   dram_scb_mecc_err_d1, dram_scb_secc_err_d1, fbctl_spc_corr_err_c7, 
   fbctl_spc_uncorr_err_c7, fbctl_spc_rd_vld_c7, 
   fbctl_bsc_corr_err_c12, fbctl_ld64_fb_hit_c12, fbctl_dis_cerr_c3, 
   fbctl_dis_uerr_c3, 
   // Inputs
   rdmard_cerr_c12, rdmard_uerr_c12, ev_cerr_r6, ev_uerr_r6, 
   rst_tri_en, mbctl_fbctl_next_vld_c4, mbctl_fbctl_next_link_c4, 
   mbf_delete_c4, mbctl_hit_c4, mbf_insert_c4, 
   mbdata_fbctl_mbf_entry, mbctl_fbctl_dram_pick, mbctl_fbctl_fbid, 
   mbctl_fbctl_way, mbctl_fbctl_way_fbid_vld, mbf_insert_mbid_c4, 
   mbdata_fbctl_rqtyp_d1, mbdata_fbctl_rsvd_d1, decdp_imiss_inst_c2, 
   arbdp_inst_mb_entry_c1, decdp_cas1_inst_c2, arbdp_rdma_inst_c1, 
   mbctl_rdma_reg_vld_c2, decc_scrd_uncorr_err_c8, 
   decc_scrd_corr_err_c8, decc_bscd_corr_err_c8, 
   decc_bscd_uncorr_err_c8, tag_error_c8, tagctl_rd64_complete_c11, 
   cerr_ack_tmp_c4, uerr_ack_tmp_c4, spc_rd_cond_c3, 
   csr_fbctl_scrub_ready, arbctl_fbctl_fbsel_c1, arbctl_fill_vld_c2, 
   arbctl_fbctl_hit_off_c1, arbctl_fbctl_inst_vld_c2, 
   decdp_wr8_inst_c2, arbdp_inst_mb_c2, decdp_ld64_inst_c2, 
   fb_cam_match, l2_bypass_mode_on, l2_dir_map_on, 
   dram_sctag_data_vld_r0, dram_sctag_rd_req_id_r0, 
   dram_sctag_chunk_id_r0, dram_sctag_secc_err_r2, 
   dram_sctag_mecc_err_r2, dram_sctag_scb_mecc_err, 
   dram_sctag_scb_secc_err, tagctl_rdma_gate_off_c2, arst_l, grst_l, 
   dbginit_l, si, se, rclk
   );

// from rdmatctl.
input	rdmard_cerr_c12, rdmard_uerr_c12;
input	ev_cerr_r6, ev_uerr_r6;
input	rst_tri_en ;
// to fbtag.
output	[7:0]	fbctl_fbtag_wr_ptr; // PH1 write.
output		fbctl_fbtag_wr_en; // PH1 write.
output		fbctl_buf_rd_en;	// to fbtag.
output	[7:0]	fbctl_fbtag_rd_ptr ; // to fbtag.
output		so;

// to tagctl
output		fbctl_tagctl_hit_c2 ;  
output		fbctl_fbd_rd_en_c2; // to fbdata via tagctl
output	[2:0]	fbctl_fbd_rd_entry_c2; // to fbdata via tagctl
output	[1:0]	dram_sctag_chunk_id_r1; // to tagctl
output		dram_sctag_data_vld_r1; // to tagctl
output	[2:0]	fbctl_fbd_wr_entry_r1 ;

// to dram
output	[2:0]	sctag_dram_rd_req_id ;

// to mbctl.
output		fb_count_eq_0; // to mbctl for csr inst ready
output		fbctl_mbctl_entry_avail ; // to mbctl for dram pick
output		fbctl_mbctl_match_c2; // to mbctl for eviction and
output	[2:0]	fbctl_mbctl_fbid_d2;
output	[3:0]	fbf_enc_ld_mbid_r1;
output		fbf_ready_miss_r1;
output	[3:0]	fbf_enc_dep_mbid_c4;
output		fbf_st_or_dep_rdy_c4;
output	fbctl_mbctl_nofill_d2; // to mbctl
output	fbctl_mbctl_stinst_match_c2; // NEW_PIN

// to scdata
output		scdata_fb_hit_c3; // used in C5 to select between

// to vuad dp
output		fbctl_vuad_bypassed_c3;


// to arb
output		fbctl_arb_l2rd_en; // to arbaddr
output	[3:0]	fbctl_arbdp_way_px2; // goes to arbctl and arbdecdp.
output		fbctl_arbdp_tecc_px2;
output	[2:0]	fbctl_arbdp_entry_px2;
output		fbctl_arbctl_vld_px1; // to arbctl 

// to csr
output	fbctl_corr_err_c8 ; // to csr
output	fbctl_uncorr_err_c8 ; // to csr
output	dram_scb_mecc_err_d1, dram_scb_secc_err_d1;

// to deccdp
output	fbctl_spc_corr_err_c7; // to deccdp
output	fbctl_spc_uncorr_err_c7; // to deccdp
output	fbctl_spc_rd_vld_c7; // to deccdp
output	fbctl_bsc_corr_err_c12; // to deccdp NEW_PIN
output	fbctl_ld64_fb_hit_c12; // to deccdp NEW_PIN

// to oqctl.
output	fbctl_dis_cerr_c3;
output	fbctl_dis_uerr_c3; 


// from  mbctl
input		mbctl_fbctl_next_vld_c4;
input	[3:0]	mbctl_fbctl_next_link_c4;
input		mbf_delete_c4;
input		mbctl_hit_c4;
input		mbf_insert_c4;
input	[3:0]	mbdata_fbctl_mbf_entry;
input		mbctl_fbctl_dram_pick;
input   [2:0]   mbctl_fbctl_fbid;
input   [3:0]   mbctl_fbctl_way ;
input           mbctl_fbctl_way_fbid_vld ;
input	[3:0]	mbf_insert_mbid_c4;

// from mbdata.
input	[4:0]	mbdata_fbctl_rqtyp_d1; // from mbdata.
input		mbdata_fbctl_rsvd_d1; // RSVD bit from mbdata

// from arbdec
input		decdp_imiss_inst_c2;
//input		decdp_ld_inst_c2;  // REMOVED POST_4.0
input	[2:0]	arbdp_inst_mb_entry_c1;
input		decdp_cas1_inst_c2;// from arbdec


input	arbdp_rdma_inst_c1;  // POST_3.0 pin From arbdec Left
input	mbctl_rdma_reg_vld_c2; // POST_3.0 pin from tagctl Bottom.

// from deccdp.
input	decc_scrd_uncorr_err_c8;
input	decc_scrd_corr_err_c8;
input	decc_bscd_corr_err_c8;
input	decc_bscd_uncorr_err_c8;

// from tagdp
input	tag_error_c8; // from tagdp/

// from tagctl
input	tagctl_rd64_complete_c11; // from tagctl. NEW_PIN
input	cerr_ack_tmp_c4, uerr_ack_tmp_c4 ; // POST_2.0 pins
input	spc_rd_cond_c3; // POST_3.2 pins


// from csr block
input	csr_fbctl_scrub_ready ;

// from arbctl
input		arbctl_fbctl_fbsel_c1; // from arbctl
input		arbctl_fill_vld_c2;
input		arbctl_fbctl_hit_off_c1; // from arbctl. used to disable hits.
input		arbctl_fbctl_inst_vld_c2;
input		decdp_wr8_inst_c2;

// from arbdec
input		arbdp_inst_mb_c2 ;
input		decdp_ld64_inst_c2;


// from fbtag
input	[7:0] 	fb_cam_match;

// from csr
input	      l2_bypass_mode_on ;
input	      l2_dir_map_on ; // NEW_PIN

// from BTU
input		dram_sctag_data_vld_r0; // data vld r0
input	[2:0]	dram_sctag_rd_req_id_r0 ; // req id r0
input	[1:0]	dram_sctag_chunk_id_r0;  // 16B chunk address.
input	dram_sctag_secc_err_r2;
input	dram_sctag_mecc_err_r2;
input	dram_sctag_scb_mecc_err;
input	dram_sctag_scb_secc_err;

// from scbug.evict

// from fbctl.
input	tagctl_rdma_gate_off_c2;

input	arst_l, grst_l, dbginit_l ;
input	si, se;
input	rclk;








wire	dram_pick_d1  ;
wire	[7:0]	fb_wr_ptr_d1;
wire	[2:0]	enc_wr_ptr_d1;

// fb control bits.
wire	[7:0]	fb_set_valid, fb_valid_prev , fb_valid ;
wire	[7:0]	fb_stinst;
wire	[7:0]	fb_nofill;
wire	[7:0]	fb_l2_ready_in,	fb_l2_ready;
wire	[7:0]	fb_bypassed_in, fb_bypassed ;
wire	[3:0]	way0, way1, way2, way3;
wire	[3:0]	way4, way5, way6, way7;
wire	[7:0]	fb_way_vld_in, fb_way_vld;
wire	[3:0]	mbid0, mbid1, mbid2, mbid3;
wire	[3:0]	mbid4, mbid5, mbid6, mbid7;
wire	[7:0]	fb_next_link_vld_in, fb_next_link_vld;
wire	[7:0]	fb_cerr, fb_uerr ;
wire	fb_cerr_pend;
wire	fb_uerr_pend;
wire	fb_tecc_pend;




wire	[7:0]	fill_entry_num_c3, fill_complete_c3, fill_complete_c4;
wire		fill_vld_c3  ;
wire	fb_count_en, fb_count_rst;
wire	[3:0]	fb_count_prev, fb_count_plus1, fb_count_minus1 ;
wire	[3:0]	fb_count;

wire	[4:0]	mbf_rqtyp_d2;
wire	[7:0]	fb_set_valid_d2;
wire		fb_stinst_d2;

wire		l2_bypass_mode_on_d1 ;
wire  [2:0]   mbctl_fbctl_fbid_d1;
wire  [3:0]   mbctl_fbctl_way_d1 ;
wire          mbctl_fbctl_way_vld_d1 ;
wire  [7:0]   dec_mb_fb_id_d1;

wire	[7:0]	fb_hit_vec_c2 ;
wire	imiss_ld64_fb_hit_c2, imiss_ld64_fb_hit_c3 ;

wire	[1:0]	dram_return_cnt, dram_return_cnt_plus1 ;
wire	dram_cnt_reset;
wire	dram_data_vld_r1;
wire	[2:0]	dram_rd_req_id_r1;
wire	cas1_inst_c3, cas1_inst_c4;
wire	dram_count_state0, dram_count_state2 ;
wire	[7:0]	fb_hit_vec_c3, fb_hit_vec_c4 ;
wire	[7:0]	dec_rdreq_id_r0_d1;

wire	dep_ptr_wr_en_c4, non_dep_mbf_insert_c4;
wire	[7:0]	dep_wr_ptr_c4, non_dep_wr_ptr_c4;
wire	[3:0]	mbf_entry_d2;
wire	[7:0]	sel_def_mbid;


wire	[3:0]	mbid0_in, mbid1_in, mbid2_in, mbid3_in;
wire	[3:0]	mbid4_in, mbid5_in, mbid6_in, mbid7_in;

wire	[7:0]	fb_l2_rd_ptr_in;
wire	[7:0]	fb_l2_rd_ptr;

wire	[3:0]	mux1_mbid_r1, mux2_mbid_r1 ;
wire	[3:0]	mux1_dep_mbid_c4, mux2_dep_mbid_c4 ;
wire	ready_ld_r0_d1 ;
wire	fill_entry_0to3_c4 ;
wire	[7:0]	fill_entry_num_c1, fill_entry_num_c2 ;

wire	pick_s0, pick_s1, pick_s2, pick_s3 ;
wire	pick_s0_quad0, pick_s1_quad0, pick_s2_quad0, pick_s3_quad0 ;
wire	pick_s0_quad1, pick_s1_quad1, pick_s2_quad1, pick_s3_quad1 ;
wire	pick_quad_s0, pick_quad_s1 ;

wire	[3:0]	pick_quad0_in, pick_quad1_in ;
wire	[1:0]	pick_quad_in ;
wire	[3:0]	pick_quad0_sel, pick_quad1_sel ;
wire	[1:0]	pick_quad_sel;

wire	[7:0]	l2_pick_vec;
wire		l2_pick, l2_pick_d1 ;
wire		l2_wait_in, l2_wait;

wire	init_pick_state;
wire	sel_l2st_lshift, sel_l2st_same; 
wire	[3:0]	l2_rd_state_lshift, l2_rd_state_in, l2_rd_state ;

wire	sel_l2st_lshift_quad0, sel_l2st_same_quad0;
wire	[3:0]	l2_rd_state_lshift_quad0, l2_rd_state_in_quad0, l2_rd_state_quad0 ;

wire	sel_l2st_lshift_quad1, sel_l2st_same_quad1;
wire	[3:0]	l2_rd_state_lshift_quad1, l2_rd_state_in_quad1, l2_rd_state_quad1 ;

wire	[2:0]	enc_l2_rd_ptr ;
wire	[3:0]	mux1_way, mux2_way, fill_way ;

wire		sctag_scdata_fb_hit_c2; // used in C5 to select between
wire	sel_c2_entry;
wire	[2:0]	fb_rd_entry_c2;
wire	[2:0]	enc_hit_vec_c2, enc_hit_vec_c3 ;
wire	[2:0]	fill_entry_c2;

wire		mecc_err_r3, secc_err_r3;
wire		fbctl_corr_err_c3, fbctl_corr_err_c4, fbctl_corr_err_c5;
wire		fbctl_corr_err_c6, fbctl_corr_err_c7 ;
wire		fbctl_uncorr_err_c3, fbctl_uncorr_err_c4, fbctl_uncorr_err_c5;
wire		fbctl_uncorr_err_c6, fbctl_uncorr_err_c7 ;
wire		dram_data_vld_r2, dram_data_vld_r3 ;
wire	[2:0]	dram_rd_req_id_r2, dram_rd_req_id_r3 ;
wire	[7:0]	fb_cerr_in, fb_uerr_in ;
wire	[7:0]	fb_cerr_prev, fb_uerr_prev ;

wire	fbctl_hit_c3;
wire	spc_rd_vld_c3;
wire	spc_rd_vld_c4, spc_rd_vld_c5 ;
wire	spc_rd_vld_c6, spc_rd_vld_c7 ;
wire	[7:0]	clear_err_c3;
wire	spc_corr_err_c3, spc_corr_err_c4, spc_corr_err_c5;
wire	spc_corr_err_c6, spc_corr_err_c7 ;
wire	spc_uncorr_err_c3, spc_uncorr_err_c4, spc_uncorr_err_c5;
wire	spc_uncorr_err_c6, spc_uncorr_err_c7 ;
wire	fb_uerr_pend_set, fb_uerr_pend_reset, fb_uerr_pend_in ;
wire	fb_cerr_pend_set, fb_cerr_pend_reset, fb_cerr_pend_in ;
wire	fb_tecc_pend_set, fb_tecc_pend_reset;
wire	fb_tecc_pend_in;

wire	fbctl_hit_c2;
wire	fb_nofill_d2;

wire	[7:0]	no_fill_entry_dequeue_c3; 
wire		en_dequeue_c3;
wire		en_hit_dequeue_c2;
wire		ready_ld64_r0_d1;
wire		mbf_rsvd_d2;
wire	fb_nofill_rst;
wire	qual_hit_vec_c2, qual_hit_vec_c3, qual_hit_vec_c4;

wire	[7:0]	dep_wr_qual_c4;

wire	[2:0]	fill_entry_c3;
wire	sel_c2_fill_entry;
wire	sel_c3_fill_entry;
wire	sel_def_hit_entry_mux1;
wire	l2_dir_map_on_d1;
wire	dram_data_vld_r0_d1;

wire	[1:0]	dram_sctag_chunk_id_r0_d1;
wire	[2:0]	dram_rd_req_id_r0_d1;
wire	fbhit_cerr_err_c3, fbhit_uerr_err_c3 ;
wire	bsc_corr_err_c3, ld64_fb_hit_c3;
wire	wr8_inst_c3, wr8_inst_c4;
wire            dbb_rst_l;
wire	[7:0]	dec_fill_entry_c3;
wire		cerr_ack_c4, uerr_ack_c4 ;
wire	inst_vld_c3;
wire	fbcerr0_d1, fbuerr0_d1;


wire	[7:0]	fill_complete_sel ;
wire	fill_complete_4to7_def, fill_complete_0to3_def ;
wire	[7:0]	fb_l2_rd_ptr_sel;
wire	way_mux1_def, way_mux2_def ;
wire	rdreq_0to3_def, rdreq_4to7_def ;

wire	[7:0]	dep_wr_ptr_c4_rst, non_dep_wr_ptr_c4_rst;
wire	[7:0]	fb_set_valid_d2_rst;
wire 	fb_tecc_pend_d1;
////////////////////////////////////////////////////////////////////////////////
// L2 OFF MODE :
//
// The RTL for fbctl contains the following exceptions to handle off mode operation.
//
// 1) A non Store, non LD64 entry is invalidated in C2 on a Fill Buffer hit.
//    stores have to be kept around to write to DRAM, LD64s turn the valid bit
//    of in C3( they can afford to do so due to the access bubbles following a ld64).
//
// 2) Fill Buffer is one deep only 
//
// 3) fb_l2_ready is set only in the following  case, 
//	 A non CAS1 instruction hitting an entry with fb_stinst =1 .
//
// 4) Fill does not wake up stores by default. It only wakes up
//    dependent instructions in the Miss Buffer.
// 
// 5) dep wr enable is asserted only if an instruction( other than a CAS1) hits
//    a Fill Buffer entry with fb_stinst=1.
//
// 6) Fill Pipeline is skewed by one cycle.
//
// 7)  In l2_bypass_mode, the way_vld bit is not required to be set.
//	for an l2_pick
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// L2 DIR MAP MODE ON
//
//  This mode is different from the regular mode of operation in the following
// ways
// - Loads/Imisses are not readied by the second incoming packet of data from the 
//   dram. Check the expression for ready_miss_r1
// - Loads/Imisses are readied similar to stores, i.e. after a Fill.
////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////
 // Reset flop
 ///////////////////////////////////////////////////////////////////

 dffrl_async    #(1)    reset_flop      (.q(dbb_rst_l),
                                        .clk(rclk),
                                        .rst_l(arst_l),
                                        .din(grst_l),
                                        .se(se), .si(), .so());


////////////////////////////////////////////////////////////////////////////////
// Fill Buffer Insertion Pipeline.
// The Fill Buffer (FB) is inserted when a Miss Buffer is read for making
// a request to DRAM. The following pipeline is used for FB insertion
//
//------------------------------------------------------------------------------
//	D0			D1				D2
//------------------------------------------------------------------------------
//	dram pick (mbctl)	read mbtag			write fbtag+ecc
//
//				read mbdata
//				for rqtyp and tag ecc		write "stinst" 
//								write insert mbid
//		
//	xmit dram pick		generate wr ptr			fb_entry_avail 
//	to fbctl.		xmit to fbtag.			logic
//
//				xmit dram_pickd1		xmit inserting
//				as wen to fbtag.		fbid to mbf
//								
//				set valid bit			xmit addr(arbaddrdp)
//								xmit req id (fbctl)
//				update fbcount			xmit req ( mbctl).
//
//								
//------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////

//////////////////
// 1.  Generation of insertion ptr
// and wen for fbtag.
//////////////////
dff_s   #(1)  ff_dram_pick_d1    (.din(mbctl_fbctl_dram_pick), .clk(rclk),
                         .q(dram_pick_d1), .se(se), .si(), .so());

assign	fb_wr_ptr_d1[0] = ~fb_valid[0] ;
assign	fb_wr_ptr_d1[1] = fb_valid[0] & ~fb_valid[1];
assign	fb_wr_ptr_d1[2] = &(fb_valid[1:0]) & ~fb_valid[2] ;
assign	fb_wr_ptr_d1[3] = &(fb_valid[2:0]) & ~fb_valid[3] ;
assign	fb_wr_ptr_d1[4] = &(fb_valid[3:0]) & ~fb_valid[4] ;
assign	fb_wr_ptr_d1[5] = &(fb_valid[4:0]) & ~fb_valid[5] ;
assign	fb_wr_ptr_d1[6] = &(fb_valid[5:0]) & ~fb_valid[6] ;
assign	fb_wr_ptr_d1[7] = &(fb_valid[6:0]) & ~fb_valid[7] ;

assign	fbctl_fbtag_wr_ptr = fb_wr_ptr_d1 ;
assign	fbctl_fbtag_wr_en = dram_pick_d1 ;

//////////////////
// 2.  xmit fbid to mbf
// for mbctl tracking.THe fbid is later
// re-transmitted to fbctl for writing the way
// and way valid fields in fbctl.
//////////////////

assign	enc_wr_ptr_d1[0] = fb_wr_ptr_d1[1] | fb_wr_ptr_d1[3] | 
	   fb_wr_ptr_d1[5] | fb_wr_ptr_d1[7]  ;
assign	enc_wr_ptr_d1[1] = fb_wr_ptr_d1[2] | fb_wr_ptr_d1[3] |
	   fb_wr_ptr_d1[6] | fb_wr_ptr_d1[7]  ;
assign	enc_wr_ptr_d1[2] = fb_wr_ptr_d1[4] | fb_wr_ptr_d1[5] |
   	   fb_wr_ptr_d1[6] | fb_wr_ptr_d1[7]  ;

dff_s   #(3)  ff_fbctl_mbctl_fbid_d2    (.din(enc_wr_ptr_d1[2:0]), .clk(rclk),
                  .q(fbctl_mbctl_fbid_d2[2:0]), .se(se), .si(), .so());

///////////////////////////////////////////////////////////////
// 3.The sctag-dram interface for read requests consists of
// req, req_id and addr signals all of which are 
// transmitted in the D2 stage
///////////////////////////////////////////////////////////////

assign	sctag_dram_rd_req_id = fbctl_mbctl_fbid_d2 ;


//////////////////////////////////////////////////////////
// VALID bit logic.
// The Valid bit is set in cycle D1 of a miss insertion.
// It is reset in the C3 cycle of a FIll. Since a Fill is
// followed by 3 bubbles, the earliest operation following
// a Fill will be in C1 when the fill is in C4. This means that
// an operation following the fill ( to the same $ line)
// will never hit the FB.
//
// Valid bit is also reset for a nofill entry if that entry
// encounters a hit. Since ld64s are the only instructions that
// will cause a no_fill entry, the reset operation can be
// performed in C3 like that for a Fill operation. This is 
// because a ld64 is followed by two bubbles.
//
// Valid bit is reset for a fb hit to entry 0 in l2 off mode
// if that entry has fb_stinst==0. In this case, the valid bit
// will have to be reset in C2 since the following instruction
// will have to see the effects of it.Hence this reset condition
// is the most critical.
//////////////////////////////////////////////////////////

dff_s   #(1)  ff_fill_vld_c3    (.din(arbctl_fill_vld_c2), .clk(rclk),
                .q(fill_vld_c3), .se(se), .si(), .so()); 


assign	no_fill_entry_dequeue_c3 =  (fb_hit_vec_c3 & fb_nofill  & 
				{8{qual_hit_vec_c3}});

// In l2 off mode, any non-store entry is dequeued 
// when an inst hits  the Fill Buffer.

dff_s   #(1)  ff_l2_bypass_mode_on    (.din(l2_bypass_mode_on), .clk(rclk),
                    .q(l2_bypass_mode_on_d1), .se(se), .si(), .so());

dff_s   #(1)  ff_l2_dir_map_on_d1    (.din(l2_dir_map_on), .clk(rclk),
                    .q(l2_dir_map_on_d1), .se(se), .si(), .so());

// In OFF mode, an instruction(B) may be in C1 when
// a C2 instruction(A) hits the Fill Buffer. Hence the valid bit
// reset condition should be flopped to C3 so that instruction B
// can see the effects of instruction A on the Fill Buffer.
// However, en_hit_dequeue_c2 had a critical component, rdma_gate_off_c2
// This component has been removed and replaced with
// rdma_inst_c2 & mbctl_rdma_reg_vld_c2.


dff_s   #(1)  ff_rdma_inst_c2    (.din(arbdp_rdma_inst_c1), .clk(rclk),
               .q(rdma_inst_c2), .se(se), .si(), .so());

assign	en_hit_dequeue_c2 = arbdp_inst_mb_c2  &
                                arbctl_fbctl_inst_vld_c2 &
				~(rdma_inst_c2 & mbctl_rdma_reg_vld_c2) &
				fb_hit_vec_c2[0] & 
				~fb_stinst[0] & // not a store
				 ~fb_nofill[0] & // not a  ld64
				l2_bypass_mode_on_d1 ; // OFF mode on.

assign	dec_fill_entry_c3[7:1] = fill_entry_num_c3[7:1] & {7{fill_vld_c3}} ;

assign	fill_complete_c3[7:1] = dec_fill_entry_c3[7:1] |
				no_fill_entry_dequeue_c3[7:1] ;

assign	dec_fill_entry_c3[0] = fill_entry_num_c3[0] & fill_vld_c3 ;

assign  fill_complete_c3[0] = 	dec_fill_entry_c3[0] | 
				no_fill_entry_dequeue_c3[0] |
				en_hit_dequeue_c2 ; // off mode condition only.

// COVERAGE: exercise all fill_complete_c3[7:0] conditions. 
// especially all en_hit_dequeue_c2 conditions.

assign	fb_set_valid = fb_wr_ptr_d1  
			& {8{dram_pick_d1}} ;

dff_s   #(8)  ff_fb_set_valid_d2    (.din(fb_set_valid[7:0]), .clk(rclk),
		.q(fb_set_valid_d2[7:0]), .se(se), .si(), .so());

assign	fb_valid_prev = ( fb_set_valid_d2 | fb_valid )   &
			~fill_complete_c3;

dffrl_s   #(8)  ff_valid_bit    (.din(fb_valid_prev[7:0]), .clk(rclk), 
	.rst_l(dbb_rst_l), .q(fb_valid[7:0]), .se(se), .si(), .so());

//////////////////////////////////////////////////////////
// FB Counter 
// Increment and decrement conditions are the same as
// set and reset conditions of the valid bit, respectively.
// 
// fb_count_eq_0 is required by mbctl to ready a csr write.
//
// fbctl_mbctl_entry_avail is required by mbctl as a condition
// for dram_pick.
//////////////////////////////////////////////////////////

assign	en_dequeue_c3 = (|( no_fill_entry_dequeue_c3 )) |
				fill_vld_c3   |
				en_hit_dequeue_c2 ;


assign  fb_count_en = ( dram_pick_d1 | en_dequeue_c3 ) & 
			~( dram_pick_d1 & en_dequeue_c3 )  ;

assign  fb_count_plus1  = fb_count + 4'b1 ;
assign  fb_count_minus1 = fb_count - 4'b1 ;

assign	fb_count_rst = (~dbb_rst_l );

mux2ds  #(4) mux_fb_count  (.dout (fb_count_prev[3:0]),
          	.in0(fb_count_plus1[3:0]), .in1(fb_count_minus1[3:0]),
                .sel0(dram_pick_d1), .sel1(~dram_pick_d1));

dffre_s   #(4)  ff_fb_count   (.din(fb_count_prev[3:0]), 
	  .clk(rclk), .rst(fb_count_rst),.en(fb_count_en),
         .q(fb_count[3:0]), .se(se), .si(), .so()); 

assign	fb_count_eq_0 = ( fb_count == 4'b0 ) ;

///////////////////////////////////////////
// in L2 off mode, Fb is only one deep.
///////////////////////////////////////////


assign	fbctl_mbctl_entry_avail = 
	( ~fb_count[3] & ~l2_bypass_mode_on_d1 )  |
	( fb_count_eq_0 & l2_bypass_mode_on_d1 ) ;



//////////////////////////////////////////////////////////
// STINST: Set for any miss that requires a fill to happen  
//	  before it is processed out of the Miss Buffer.
//
//	   Lds , Imisses and Strloads are the only requests which bypass
//	   data out of the fill buffer. All other instructions
//	   will wait for a FIll to happen before they are readied
//	   in the mIss Buffer.
//
//	   This bit is not valid unless fb_valid is set.
//////////////////////////////////////////////////////////

dff_s   #(5)  ff_rqtyp_d2    (.din(mbdata_fbctl_rqtyp_d1[4:0]), .clk(rclk),
			.q(mbf_rqtyp_d2[4:0]), .se(se), .si(), .so());

dff_s   #(1)  ff_snp_d2    (.din(mbdata_fbctl_rsvd_d1), .clk(rclk),
			.q(mbf_rsvd_d2), .se(se), .si(), .so());


assign	fb_stinst_d2 = (~( mbf_rqtyp_d2 == `IMISS_RQ ) & 
			~( mbf_rqtyp_d2 == `LOAD_RQ )  & 
			~( mbf_rqtyp_d2 == `STRLOAD_RQ )  & 
			~( mbf_rsvd_d2 & mbf_rqtyp_d2[0] ) ) ;

dffe_s   #(1)  ff_stinst_0    (.din(fb_stinst_d2), .en(fb_set_valid_d2[0]),
		.clk(rclk), .q(fb_stinst[0]), .se(se), .si(), .so());
dffe_s   #(1)  ff_stinst_1    (.din(fb_stinst_d2), .en(fb_set_valid_d2[1]),
		.clk(rclk), .q(fb_stinst[1]), .se(se), .si(), .so());
dffe_s   #(1)  ff_stinst_2    (.din(fb_stinst_d2), .en(fb_set_valid_d2[2]),
		.clk(rclk), .q(fb_stinst[2]), .se(se), .si(), .so());
dffe_s   #(1)  ff_stinst_3    (.din(fb_stinst_d2), .en(fb_set_valid_d2[3]),
		.clk(rclk), .q(fb_stinst[3]), .se(se), .si(), .so());
dffe_s   #(1)  ff_stinst_4    (.din(fb_stinst_d2), .en(fb_set_valid_d2[4]),
		.clk(rclk), .q(fb_stinst[4]), .se(se), .si(), .so());
dffe_s   #(1)  ff_stinst_5    (.din(fb_stinst_d2), .en(fb_set_valid_d2[5]),
		.clk(rclk), .q(fb_stinst[5]), .se(se), .si(), .so());
dffe_s   #(1)  ff_stinst_6    (.din(fb_stinst_d2), .en(fb_set_valid_d2[6]),
		.clk(rclk), .q(fb_stinst[6]), .se(se), .si(), .so());
dffe_s   #(1)  ff_stinst_7    (.din(fb_stinst_d2), .en(fb_set_valid_d2[7]),
		.clk(rclk), .q(fb_stinst[7]), .se(se), .si(), .so());


//////////////////////////////////////////////////////////
// NO_FILL: Set or reset when an entry is written into
// 	    the fbtags. 
//	    Set for a ld64 instruction and reset for any
//	    other instruction.
//	    Used in the valid bit setting and l2_ready logic.
//
// fbctl_mbctl_nofill_d2 is used to not turn on fbid_vld in 
// the miss buffer.
//////////////////////////////////////////////////////////



assign	fb_nofill_d2 = mbf_rsvd_d2 & mbf_rqtyp_d2[0] ;
assign	fbctl_mbctl_nofill_d2 = fb_nofill_d2 ;
assign	fb_nofill_rst = ~dbb_rst_l;

dffre_s   #(1)  ff_nofill_0    (.din(fb_nofill_d2), .en(fb_set_valid_d2[0]),
		.rst(fb_nofill_rst),
        	.clk(rclk), .q(fb_nofill[0]), .se(se), .si(), .so());
dffre_s   #(1)  ff_nofill_1    (.din(fb_nofill_d2), .en(fb_set_valid_d2[1]),
		.rst(fb_nofill_rst),
        	.clk(rclk), .q(fb_nofill[1]), .se(se), .si(), .so());
dffre_s   #(1)  ff_nofill_2    (.din(fb_nofill_d2), .en(fb_set_valid_d2[2]),
		.rst(fb_nofill_rst),
        	.clk(rclk), .q(fb_nofill[2]), .se(se), .si(), .so());
dffre_s   #(1)  ff_nofill_3    (.din(fb_nofill_d2), .en(fb_set_valid_d2[3]),
		.rst(fb_nofill_rst),
        	.clk(rclk), .q(fb_nofill[3]), .se(se), .si(), .so());
dffre_s   #(1)  ff_nofill_4    (.din(fb_nofill_d2), .en(fb_set_valid_d2[4]),
		.rst(fb_nofill_rst),
        	.clk(rclk), .q(fb_nofill[4]), .se(se), .si(), .so());
dffre_s   #(1)  ff_nofill_5    (.din(fb_nofill_d2), .en(fb_set_valid_d2[5]),
		.rst(fb_nofill_rst),
        	.clk(rclk), .q(fb_nofill[5]), .se(se), .si(), .so());
dffre_s   #(1)  ff_nofill_6    (.din(fb_nofill_d2), .en(fb_set_valid_d2[6]),
		.rst(fb_nofill_rst),
        	.clk(rclk), .q(fb_nofill[6]), .se(se), .si(), .so());
dffre_s   #(1)  ff_nofill_7    (.din(fb_nofill_d2), .en(fb_set_valid_d2[7]),
		.rst(fb_nofill_rst),
        	.clk(rclk), .q(fb_nofill[7]), .se(se), .si(), .so());





///////////////////////////////////////////////////////////////////////
// FB CAM EN: THe FB cam is enabled if inst_vld_c1.
// FB hit is enabled (in arbctl) .
//
// The Hit logic in C2 generates the following signals.
// 
// fbctl_mbctl_match_c2 : used by mbctl to turn off eviction for
//		an insrtuction that misses the tag. Notice
//		that this signal is not qualified with
//		inst_vld_c2.
//
// fbctl_mbctl_stinst_match_c2: fb hit entry corresponds to a store
//
// fbctl_tagctl_hit_c2 : Used in tagctl to generate tagctl_hit_l2orfb_c2.
//		This signal is high only if an instruction from
//		the miss buffer hits the FIll buffer.Not gated off when
//		the rdma register is vld.
//
///////////////////////////////////////////////////////////////////////



dff_s   #(1)  ff_fb_hit_off_c1_d1    (.din(arbctl_fbctl_hit_off_c1), .clk(rclk),
                .q(fb_hit_off_c1_d1), .se(se), .si(), .so());

// fb_hit_vec_c2:
// indicates that a valid instruction hits
// the fill buffer.

assign	fb_hit_vec_c2 = fb_cam_match & fb_valid  & 
			{8{~fb_hit_off_c1_d1 }} ;

assign	fbctl_tagctl_hit_c2 = |( fb_hit_vec_c2 )  & // tag match in fb
			arbdp_inst_mb_c2  &
			arbctl_fbctl_inst_vld_c2 ;// Miss buffer instruction
			// tagctl_rdma_gate_off_c2 qual done in tagctl.

assign	fbctl_mbctl_match_c2 = |( fb_hit_vec_c2 ) ; //  not qualified with inst vld.


assign	fbctl_mbctl_stinst_match_c2 = ( fb_hit_vec_c2[0] & fb_stinst[0]) ; // matches a 
					// store instruction.


assign  fbctl_hit_c2 = fbctl_tagctl_hit_c2 & ~tagctl_rdma_gate_off_c2 ;



assign	imiss_ld64_fb_hit_c2 = ( decdp_imiss_inst_c2 |
			decdp_ld64_inst_c2 )  & fbctl_hit_c2 ;

dff_s   #(1)  ff_imiss_ld64_fb_hit_c3    (.din(imiss_ld64_fb_hit_c2), .clk(rclk),
               .q(imiss_ld64_fb_hit_c3), .se(se), .si(), .so());

///////////////////////////////////////////////////////////////////////
//
// scdata_fb_hit_c3: Generated as a select for Fill Buffer data
//	   	over $ data.
//	   	C3 cycle of a regular load/imiss or
//		C4 cycle of an imiss hitting the Fill Buffer.
//		C4 cycle of a FIll in l2 off mode.
//		This signal is staged for two cycles and used
//		in scdata for the Fbdata vs L2data mux.
//
///////////////////////////////////////////////////////////////////////

assign	sctag_scdata_fb_hit_c2 = fbctl_hit_c2 | // ld or imiss 1st packet
		imiss_ld64_fb_hit_c3 |  // imiss 2nd packet
		(fill_vld_c3 & l2_bypass_mode_on_d1 ); // fill in OFF mode 
				
dff_s   #(1)  ff_scdata_fb_hit_c3    (.din(sctag_scdata_fb_hit_c2), .clk(rclk),
               .q(scdata_fb_hit_c3), .se(se), .si(), .so());




assign  qual_hit_vec_c2 = ~tagctl_rdma_gate_off_c2 & arbdp_inst_mb_c2  &
                                arbctl_fbctl_inst_vld_c2 ;

dff_s   #(1)  ff_qual_hit_vec_c3    (.din(qual_hit_vec_c2), .clk(rclk),
               .q(qual_hit_vec_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_qual_hit_vec_c4    (.din(qual_hit_vec_c3), .clk(rclk),
               .q(qual_hit_vec_c4), .se(se), .si(), .so());


///////////////////////////////////////////////////////////////////
// BYPASSED bit: The Bypassed bit is used to
// tell if an instruction already
// received bypassed data from the
// Fill Buffer. If not, then the 
// ALLOC bit in vuad is not reset
// by the FIll but rather by the 
// operation that hits the $.
//
// Set in the C3 cycle of a mbf instruction hitting
// the fill buffer and reset in C3 cycle of a Fill
// Bypassed bit is not set for a no fill Entry 
// or in the $ off mode. 
///////////////////////////////////////////////////////////////////


assign  fb_bypassed_in = ( fb_bypassed | 
			(fb_hit_vec_c3 & {8{qual_hit_vec_c3}} &
			~fb_nofill &
			 ~{8{l2_bypass_mode_on_d1}})
			 ) & ~fill_complete_c3;

dffrl_s   #(8)  ff_bypassed (.din(fb_bypassed_in[7:0]), .clk(rclk), .rst_l(dbb_rst_l),
         .q(fb_bypassed[7:0]), .se(se), .si(), .so());

assign	fill_entry_num_c1[0] = ( arbdp_inst_mb_entry_c1[2:0] == 3'd0 );
assign	fill_entry_num_c1[1] = ( arbdp_inst_mb_entry_c1[2:0] == 3'd1 );
assign	fill_entry_num_c1[2] = ( arbdp_inst_mb_entry_c1[2:0] == 3'd2 );
assign	fill_entry_num_c1[3] = ( arbdp_inst_mb_entry_c1[2:0] == 3'd3 );
assign	fill_entry_num_c1[4] = ( arbdp_inst_mb_entry_c1[2:0] == 3'd4 );
assign	fill_entry_num_c1[5] = ( arbdp_inst_mb_entry_c1[2:0] == 3'd5 );
assign	fill_entry_num_c1[6] = ( arbdp_inst_mb_entry_c1[2:0] == 3'd6 );
assign	fill_entry_num_c1[7] = ( arbdp_inst_mb_entry_c1[2:0] == 3'd7 );

dff_s   #(8)  ff_fill_entry_num_c2    (.din(fill_entry_num_c1[7:0]), .clk(rclk),
               .q(fill_entry_num_c2[7:0]), .se(se), .si(), .so());

dff_s   #(8)  ff_fill_entry_num_c3    (.din(fill_entry_num_c2[7:0]), .clk(rclk),
               .q(fill_entry_num_c3[7:0]), .se(se), .si(), .so());

dff_s   #(1)  ff_inst_vld_c3    (.din(arbctl_fbctl_inst_vld_c2), .clk(rclk),
               .q(inst_vld_c3), .se(se), .si(), .so());

assign	fbctl_vuad_bypassed_c3 = |( fb_bypassed & fill_entry_num_c3 ) &
                        inst_vld_c3 ;


//////////////////////////////////////////////////////////////////////
// MBF interface: Way,  WAY_VLD bits in fbctl are written
// by mbctl. 
//WAY and WAY_VLD are written when an instruction in the 
//miss buffer performs its "eviction" pass and gets a way allocated.
// The above explanation assumes that an eviction pass will always
// follow a request to dram. However, in cases that the dram request
// happens after the eviction pass, the WAY and WAY_VLD bits
// are written immediately after the DRAM request. 
//
// Here is the pipeline for writing the way and evict_done bits.
// if eviction happens after a request to DRAM is issued by the 
// miss buffer
// ---------------------------------------------------------------
// 	C4/			C5/			C6/
//----------------------------------------------------------------
//	write			pick
//	way vld bit.		one mbf entry		write
//	(mbctl)			with wayvld and		way into
//				fbid vld.		entry pointed
//							by fbid.
//				muxout
//				way and
//				fbid.			set evict_done
// ---------------------------------------------------------------
//
///////////////////////////////////////////////////////////////////////



dff_s   #(3)  ff_mbctl_fbctl_fbid_d1    (.din(mbctl_fbctl_fbid[2:0]), .clk(rclk),
         	.q(mbctl_fbctl_fbid_d1[2:0]), .se(se), .si(), .so());

dff_s   #(4)  ff_mbctl_fbctl_way_d1    (.din(mbctl_fbctl_way[3:0]), .clk(rclk),
         	.q(mbctl_fbctl_way_d1[3:0]), .se(se), .si(), .so());

dff_s   #(1)  ff_mbctl_fbctl_way_vld_d1    (.din(mbctl_fbctl_way_fbid_vld), .clk(rclk),
         	.q(mbctl_fbctl_way_vld_d1), .se(se), .si(), .so());

assign	dec_mb_fb_id_d1[0] = ( mbctl_fbctl_fbid_d1[2:0] == 3'd0 ) &
				mbctl_fbctl_way_vld_d1;
assign	dec_mb_fb_id_d1[1] = ( mbctl_fbctl_fbid_d1[2:0] == 3'd1 ) &
				mbctl_fbctl_way_vld_d1;
assign	dec_mb_fb_id_d1[2] = ( mbctl_fbctl_fbid_d1[2:0] == 3'd2 ) &
				mbctl_fbctl_way_vld_d1;
assign	dec_mb_fb_id_d1[3] = ( mbctl_fbctl_fbid_d1[2:0] == 3'd3 ) &
				mbctl_fbctl_way_vld_d1;
assign	dec_mb_fb_id_d1[4] = ( mbctl_fbctl_fbid_d1[2:0] == 3'd4 ) &
				mbctl_fbctl_way_vld_d1;
assign	dec_mb_fb_id_d1[5] = ( mbctl_fbctl_fbid_d1[2:0] == 3'd5 ) &
				mbctl_fbctl_way_vld_d1;
assign	dec_mb_fb_id_d1[6] = ( mbctl_fbctl_fbid_d1[2:0] == 3'd6 ) &
				mbctl_fbctl_way_vld_d1;
assign	dec_mb_fb_id_d1[7] = ( mbctl_fbctl_fbid_d1[2:0] == 3'd7 ) &
				mbctl_fbctl_way_vld_d1;


///////////
// WAY<3:0>
///////////

dffe_s   #(4)  ff_way0    (.din(mbctl_fbctl_way_d1[3:0]), .en(dec_mb_fb_id_d1[0]),
                        .clk(rclk), .q(way0[3:0]), .se(se), .si(), .so());
dffe_s   #(4)  ff_way1    (.din(mbctl_fbctl_way_d1[3:0]), .en(dec_mb_fb_id_d1[1]),
                        .clk(rclk), .q(way1[3:0]), .se(se), .si(), .so());
dffe_s   #(4)  ff_way2    (.din(mbctl_fbctl_way_d1[3:0]), .en(dec_mb_fb_id_d1[2]),
                        .clk(rclk), .q(way2[3:0]), .se(se), .si(), .so());
dffe_s   #(4)  ff_way3    (.din(mbctl_fbctl_way_d1[3:0]), .en(dec_mb_fb_id_d1[3]),
                        .clk(rclk), .q(way3[3:0]), .se(se), .si(), .so());
dffe_s   #(4)  ff_way4    (.din(mbctl_fbctl_way_d1[3:0]), .en(dec_mb_fb_id_d1[4]),
                        .clk(rclk), .q(way4[3:0]), .se(se), .si(), .so());
dffe_s   #(4)  ff_way5    (.din(mbctl_fbctl_way_d1[3:0]), .en(dec_mb_fb_id_d1[5]),
                        .clk(rclk), .q(way5[3:0]), .se(se), .si(), .so());
dffe_s   #(4)  ff_way6    (.din(mbctl_fbctl_way_d1[3:0]), .en(dec_mb_fb_id_d1[6]),
                        .clk(rclk), .q(way6[3:0]), .se(se), .si(), .so());
dffe_s   #(4)  ff_way7    (.din(mbctl_fbctl_way_d1[3:0]), .en(dec_mb_fb_id_d1[7]),
                        .clk(rclk), .q(way7[3:0]), .se(se), .si(), .so());

///////////
// WAY_VLD
// set at the time of an eviction "pass" ( or after a dram pick )
// and reset at the time of fill
// Can also be reset if picked by the L2_ARB picker.
///////////

assign	fb_way_vld_in = ( fb_way_vld |  dec_mb_fb_id_d1 ) & ~fill_complete_c3 ;


dffrl_s   #(8)  ff_way_vld    (.din(fb_way_vld_in[7:0]), .clk(rclk), 
	.rst_l(dbb_rst_l), .q(fb_way_vld[7:0]), .se(se), .si(), .so());


////////////////////////////////////////////////////////////////////////////////
// DRAM interface.:
// Data arriving from DRAM is written into the Fill Buffer
// 128 bits at a time. Here is the pipeline.
//
//-----------------------------------------------------------------------------
// R0		R1		R2	R3	R4	R5(PX2)
//-----------------------------------------------------------------------------
//		-inc		-data	-write
// -data_vld	dram_cnt	from	into
// from dram			dram	FB
//					to	in PH2
//					scbuf
//
//		-if dram_cnt_in	-READY	-PICK   -READ	-ISSUE
//		is 2, rdy miss	logic
//		in mbf		in mbctl
//-----------------------------------------------------------------------------
//
// New addition;
// Added a R0_d1 stage between R0 and R1
//
////////////////////////////////////////////////////////////////////////////////

//////////////
// dram packet
// counter
//////////////

dff_s   #(1)  ff_data_vld_r0_d1  (.din(dram_sctag_data_vld_r0), .clk(rclk),
                        .q(dram_data_vld_r0_d1), .se(se), .si(), .so());

dff_s   #(1)  ff_data_vld_r1  (.din(dram_data_vld_r0_d1), .clk(rclk),
                        .q(dram_data_vld_r1), .se(se), .si(), .so());

assign	dram_sctag_data_vld_r1 = dram_data_vld_r1;

dff_s   #(2)  ff_dram_sctag_chunk_id_r0_d1 (.din(dram_sctag_chunk_id_r0[1:0]), 
		.clk(rclk),
		.q(dram_sctag_chunk_id_r0_d1[1:0]), .se(se), .si(), .so());

dff_s   #(2)  ff_dram_sctag_chunk_id_r1 (.din(dram_sctag_chunk_id_r0_d1[1:0]), 
		.clk(rclk),
		.q(dram_sctag_chunk_id_r1[1:0]), .se(se), .si(), .so());

dff_s   #(3)  ff_sctag_req_id_r0_d1 (.din(dram_sctag_rd_req_id_r0[2:0]), 
		.clk(rclk),
		.q(dram_rd_req_id_r0_d1[2:0]), .se(se), .si(), .so());

dff_s   #(3)  ff_sctag_req_id_r1 (.din(dram_rd_req_id_r0_d1[2:0]), 
		.clk(rclk),
		.q(dram_rd_req_id_r1[2:0]), .se(se), .si(), .so());



// counter
assign	dram_return_cnt_plus1 = dram_return_cnt + 2'b1 ;

assign	dram_cnt_reset = ~dbb_rst_l ;

dffre_s   #(2)  ff_dram_cnt    (.din(dram_return_cnt_plus1[1:0]), .clk(rclk), 
			.rst(dram_cnt_reset),	.en(dram_data_vld_r0_d1),
                        .q(dram_return_cnt[1:0]), .se(se), .si(), .so());


assign	dram_count_state0 = (dram_return_cnt == 2'd0);
assign	dram_count_state2 = (dram_return_cnt == 2'd2);

////////////////
// Miss Buffer  Ld/Imiss miss  Ready
// A load/Imiss instruction is readied if 
// dram_count_state1 & dram_data_vld_r1 implying
// that the 2nd packet has arrived from DRAM.
//
// In off mode, an instruction is readied 
// when all packets arrive from DRAM
////////////////

assign	dec_rdreq_id_r0_d1[0] =  ( dram_rd_req_id_r0_d1 == 3'd0 ) ;
assign	dec_rdreq_id_r0_d1[1] =  ( dram_rd_req_id_r0_d1 == 3'd1 ) ;
assign	dec_rdreq_id_r0_d1[2] =  ( dram_rd_req_id_r0_d1 == 3'd2 ) ;
assign	dec_rdreq_id_r0_d1[3] =  ( dram_rd_req_id_r0_d1 == 3'd3 ) ;
assign	dec_rdreq_id_r0_d1[4] =  ( dram_rd_req_id_r0_d1 == 3'd4 ) ;
assign	dec_rdreq_id_r0_d1[5] =  ( dram_rd_req_id_r0_d1 == 3'd5 ) ;
assign	dec_rdreq_id_r0_d1[6] =  ( dram_rd_req_id_r0_d1 == 3'd6 ) ;
assign	dec_rdreq_id_r0_d1[7] =  ( dram_rd_req_id_r0_d1 == 3'd7 ) ;

assign	rdreq_0to3_def = ~(|dec_rdreq_id_r0_d1[2:0]);
assign	rdreq_4to7_def = ~(|dec_rdreq_id_r0_d1[6:4]);

mux4ds  #(4) mux1_rtn_mbid  (.dout(mux1_mbid_r1[3:0]),
           .in0(mbid0[3:0]), .in1(mbid1[3:0]), .in2(mbid2[3:0]), .in3(mbid3[3:0]),
           .sel0(dec_rdreq_id_r0_d1[0]), .sel1(dec_rdreq_id_r0_d1[1]),
           .sel2(dec_rdreq_id_r0_d1[2]), .sel3(rdreq_0to3_def));

mux4ds  #(4) mux2_rtn_mbid  (.dout(mux2_mbid_r1[3:0]),
           .in0(mbid4[3:0]), .in1(mbid5[3:0]), .in2(mbid6[3:0]), .in3(mbid7[3:0]),
           .sel0(dec_rdreq_id_r0_d1[4]), .sel1(dec_rdreq_id_r0_d1[5]),
           .sel2(dec_rdreq_id_r0_d1[6]), .sel3(rdreq_4to7_def));

mux2ds  #(4) mux3_rtn_mbid  (.dout(fbf_enc_ld_mbid_r1[3:0]),
            .in0(mux1_mbid_r1[3:0]), .in1(mux2_mbid_r1[3:0]),
            .sel0(~dram_rd_req_id_r0_d1[2]), .sel1(dram_rd_req_id_r0_d1[2]));



assign	ready_ld_r0_d1 = |( dec_rdreq_id_r0_d1 & ~fb_stinst  & ~fb_nofill) ; // => ld/imiss instr.
assign	ready_ld64_r0_d1 = |( dec_rdreq_id_r0_d1 &  fb_nofill) ; // => ld64 instr.

// The following signal is actually an r0_d1 signal.
assign	fbf_ready_miss_r1 = ( dram_count_state0 & dram_data_vld_r0_d1 & // 1 packets received
			~l2_bypass_mode_on_d1 &	// L2 ON
			~l2_dir_map_on_d1 &
			 ready_ld_r0_d1 ) |	// ld/imiss instr
			( dram_count_state2 &  dram_data_vld_r0_d1 & // 3 packets received
			( l2_bypass_mode_on_d1 | ready_ld64_r0_d1 ) ) ; // L2 OFF and any instruction.
				
				


///////////////////////////////////////////////////////////
// L2 ready: is set to indicate that all packets for this
// miss request have arrived from DRAM. ALongwith WAY_VLD,
// this bit is used as a pick condition for a FILL.
// 
// Set when dram_count_state2 and dram_data_vld_r1 is high
// in l2 ON mode.
// 
// In cache OFF mode, L2 ready is set if an instruction 
// hits an FB entry with fb_stinst=1, implying that the
// line is dirty in the FIll Buffer and needs to be written 
// back to DRAM , exception is a CAS1. IN the case of a cas1
// instruction, the ready bit is not set.
///////////////////////////////////////////////////////////


dff_s   #(1)  ff_cas1_inst_c3    (.din(decdp_cas1_inst_c2), .clk(rclk),
                        .q(cas1_inst_c3), .se(se), .si(), .so());
dff_s   #(1)  ff_cas1_inst_c4    (.din(cas1_inst_c3), .clk(rclk),
                        .q(cas1_inst_c4), .se(se), .si(), .so());

dff_s   #(8)  ff_fb_hit_vec_c3  (.din(fb_hit_vec_c2[7:0]), .clk(rclk),
                        .q(fb_hit_vec_c3[7:0]), .se(se), .si(), .so());
dff_s   #(8)  ff_fb_hit_vec_c4  (.din(fb_hit_vec_c3[7:0]), .clk(rclk),
                        .q(fb_hit_vec_c4[7:0]), .se(se), .si(), .so());

assign  fb_l2_ready_in[7:1] = ( ({7{dram_count_state2 & 
				 dram_data_vld_r0_d1  }} // last pckt from dram
				& dec_rdreq_id_r0_d1[7:1] // id of incoming pckt
				& ~fb_nofill[7:1] )|  // not a no fill req.
				fb_l2_ready[7:1] ) & 
				~fb_l2_rd_ptr[7:1] ; 

assign	fb_l2_ready_in[0] = ( ( dram_count_state2 & 
				~l2_bypass_mode_on_d1 &
				dram_data_vld_r0_d1 
				& ~fb_nofill[0] 
			       & dec_rdreq_id_r0_d1[0] ) |
			      ( l2_bypass_mode_on_d1 &  // l2 off
				fb_stinst[0] & 	// ~imiss and ~ld & ~ld64
				mbf_delete_c4 &		// mbf dequeue
				fb_hit_vec_c4[0] & 	// hit in fb
				qual_hit_vec_c4 &
				~cas1_inst_c4 ) |	// not a CAS1
				fb_l2_ready[0] 
			     ) & ~fb_l2_rd_ptr[0]  ;

dffrl_s   #(8)  ff_fb_l2_ready  (.din(fb_l2_ready_in[7:0]), .clk(rclk), 
			.rst_l(dbb_rst_l),
                      .q(fb_l2_ready[7:0]), .se(se), .si(), .so());


///////////////////////////////////////////////////////////////////////////
// Interface with L2 ARB:
// The Fill Buffer can issue instructions at the rate of 1 every 4 cycles.
// and the issue pipeline is similar to that of the Miss Buffer.
//--------------------------------------------------------------------------
// inst A       PICK            READ (PX1)              ISSUE(PX2)
//--------------------------------------------------------------------------
//              -pick if
//              ~l2_wait
//              or fbsel_c1     -read fbtag
//
//              -set l2_wait    -enable px2 rd flop
//                              if l2_pick_d1       	- hold fbtag
//							  until next l2_pick
//
//				-way and fbid
//				 to arbdec.
//--------------------------------------------------------------------------
// ENtires that are l2_ready and way_vld are picked for FIlls.
// However, in l2_bypass_mode, the way_vld bit is not required to be set.
//
///////////////////////////////////////////////////////////////////////////


assign	l2_pick_vec[7:1] = ( fb_l2_ready[7:1] &  fb_way_vld[7:1] )   & ~{7{l2_wait}} ;
assign	l2_pick_vec[0] = ( fb_l2_ready[0] &  (fb_way_vld[0]| l2_bypass_mode_on_d1) )   & ~l2_wait ;

assign  l2_pick = |( l2_pick_vec )  ;

dff_s   #(1)  ff_l2_pick_d1(.din(l2_pick), .clk(rclk),
               .q(l2_pick_d1), .se(se), .si(), .so());


assign  l2_wait_in =  ( l2_pick | l2_wait)  
		& ~arbctl_fbctl_fbsel_c1 ;

dffrl_s   #(1)  ff_l2_wait(.din(l2_wait_in), .clk(rclk), .rst_l(dbb_rst_l),
               .q(l2_wait), .se(se), .si(), .so());

assign  fbctl_buf_rd_en = l2_pick ;

assign  fbctl_arb_l2rd_en = l2_pick_d1;

assign  fbctl_arbctl_vld_px1 = l2_wait ;


//////////////////////////
// FBID field to L2 arbdec
//////////////////////////

assign  enc_l2_rd_ptr[0] = fb_l2_rd_ptr[1] | fb_l2_rd_ptr[3] |
                           fb_l2_rd_ptr[5] | fb_l2_rd_ptr[7]  ;

assign  enc_l2_rd_ptr[1] = fb_l2_rd_ptr[2] | fb_l2_rd_ptr[3] |
                           fb_l2_rd_ptr[6] | fb_l2_rd_ptr[7]  ;

assign  enc_l2_rd_ptr[2] = fb_l2_rd_ptr[4] | fb_l2_rd_ptr[5] |
                           fb_l2_rd_ptr[6] | fb_l2_rd_ptr[7]  ;


dffe_s   #(3)  ff_l2_entry_px2 ( .din(enc_l2_rd_ptr[2:0]), .en(l2_pick_d1),
               .clk(rclk), .q(fbctl_arbdp_entry_px2[2:0]), 
			.se(se), .si(), .so());


//////////////////////
// WAY field to L2 arbdec
//////////////////////

assign	way_mux1_def = ~(|fb_l2_rd_ptr[2:0]);
assign	way_mux2_def = ~(|fb_l2_rd_ptr[6:4]);

assign	fb_l2_rd_ptr_sel[0] = fb_l2_rd_ptr[0] & ~rst_tri_en;
assign	fb_l2_rd_ptr_sel[1] = fb_l2_rd_ptr[1] & ~rst_tri_en;
assign	fb_l2_rd_ptr_sel[2] = fb_l2_rd_ptr[2] & ~rst_tri_en;
assign	fb_l2_rd_ptr_sel[3] = way_mux1_def | rst_tri_en ;

assign	fb_l2_rd_ptr_sel[4] = fb_l2_rd_ptr[4] & ~rst_tri_en;
assign	fb_l2_rd_ptr_sel[5] = fb_l2_rd_ptr[5] & ~rst_tri_en;
assign	fb_l2_rd_ptr_sel[6] = fb_l2_rd_ptr[6] & ~rst_tri_en;
assign	fb_l2_rd_ptr_sel[7] = way_mux2_def | rst_tri_en ;


mux4ds  #(4) l2_way_mux1  (.dout (mux1_way[3:0]),
                  .in0(way0[3:0]),.in1(way1[3:0]),
                  .in2(way2[3:0]),.in3(way3[3:0]),
                  .sel0(fb_l2_rd_ptr_sel[0]), .sel1(fb_l2_rd_ptr_sel[1]),
                  .sel2(fb_l2_rd_ptr_sel[2]), .sel3(fb_l2_rd_ptr_sel[3]));

mux4ds  #(4) l2_way_mux2  (.dout (mux2_way[3:0]),
                  .in0(way4[3:0]),.in1(way5[3:0]),
                  .in2(way6[3:0]),.in3(way7[3:0]),
                  .sel0(fb_l2_rd_ptr_sel[4]),.sel1(fb_l2_rd_ptr_sel[5]),
                  .sel2(fb_l2_rd_ptr_sel[6]),.sel3(fb_l2_rd_ptr_sel[7]));

mux2ds  #(4) l2_way_mux  (.dout (fill_way[3:0]),
                     .in0(mux2_way[3:0]), .in1(mux1_way[3:0]),
                     .sel0(enc_l2_rd_ptr[2]),.sel1(~enc_l2_rd_ptr[2]));

dffe_s   #(4)  ff_l2_way_px2 ( .din(fill_way[3:0]), .en(l2_pick_d1),
              .clk(rclk), .q(fbctl_arbdp_way_px2[3:0]), 
		.se(se), .si(), .so());



///////////////////////////////////////////////////////////////////////////
// Writing MBID into the FIll Buffer.
// There are 3 conditions under which the mbid of an instruction is written
// into the Fill Buffer so that the fill buffer can ready that instruction 
// after a fill. They are as following:
// 1. A miss buffer dependent's mbID is written into the fill Buffer when 
//    the older instruction hits the fill buffer and completes ( dequeues from mb)
//    This is done in the C4 cycle of the older instruction.
// 2. A non dependent instruction that issues from the IQ cannot receive data
//    from the FIll Buffer. The mbID of the instruction is written into the 
//    Fill Buffer so that it can be readied when a fill is performed.
//    The mbID write into the Fill Buffer is performed in C4.
// 3. The ID of a miss requesting to DRAM is writted into the Fill Buffer in
//    the D2 cycle of the l2-dram request pipeline.
//
//
// A next_link VALID bit is set when the mbid comes from either 1 or 2 above.
// The next_link VALID bit is reset when a fill is complete.
//
///////////////////////////////////////////////////////////////////////////



assign	dep_ptr_wr_en_c4 = mbctl_fbctl_next_vld_c4 & mbf_delete_c4  &
				~cas1_inst_c4; // cas1 dependents never woken up by the FBF


assign  dep_wr_qual_c4  = ( {8{~l2_bypass_mode_on_d1}} |  // l2 $ ON
			fb_stinst ) ;	// Fill Buffer instruction is a Store.

assign  dep_wr_ptr_c4 = fb_hit_vec_c4  & dep_wr_qual_c4 & 
				{8{dep_ptr_wr_en_c4 }}  ;



assign	non_dep_mbf_insert_c4 =  mbf_insert_c4 & ~mbctl_hit_c4;

assign	non_dep_wr_ptr_c4 = fb_hit_vec_c4 & 
			{8{non_dep_mbf_insert_c4 }} ;


assign	non_dep_wr_ptr_c4_rst = non_dep_wr_ptr_c4  & ~{8{rst_tri_en}} ;
assign	dep_wr_ptr_c4_rst = dep_wr_ptr_c4 & ~{8{rst_tri_en}} ;
assign	fb_set_valid_d2_rst = fb_set_valid_d2 & ~{8{rst_tri_en}} ;


dff_s   #(4)  ff_mbf_entry_d2    (.din(mbdata_fbctl_mbf_entry[3:0]), .clk(rclk),
                        .q(mbf_entry_d2[3:0]), .se(se), .si(), .so());

assign	sel_def_mbid  = ~( dep_wr_ptr_c4 | fb_set_valid_d2_rst |
		   non_dep_wr_ptr_c4 ) | {8{rst_tri_en}}  ;

mux4ds  #(4) mux_mbid0  (.dout(mbid0_in[3:0]),
        .in0(mbctl_fbctl_next_link_c4[3:0]), .in1(mbf_entry_d2[3:0]),
        .in2(mbf_insert_mbid_c4[3:0]), .in3(mbid0[3:0]),
        .sel0(dep_wr_ptr_c4_rst[0]), .sel1(fb_set_valid_d2_rst[0]),
        .sel2(non_dep_wr_ptr_c4_rst[0]), .sel3(sel_def_mbid[0]));

dff_s   #(4)  ff_mbid0    (.din(mbid0_in[3:0]), .clk(rclk),
          .q(mbid0[3:0]), .se(se), .si(), .so());


mux4ds  #(4) mux_mbid1  (.dout(mbid1_in[3:0]),
        .in0(mbctl_fbctl_next_link_c4[3:0]), .in1(mbf_entry_d2[3:0]),
        .in2(mbf_insert_mbid_c4[3:0]), .in3(mbid1[3:0]),
        .sel0(dep_wr_ptr_c4_rst[1]), .sel1(fb_set_valid_d2_rst[1]),
        .sel2(non_dep_wr_ptr_c4_rst[1]), .sel3(sel_def_mbid[1]));

dff_s   #(4)  ff_mbid1    (.din(mbid1_in[3:0]), .clk(rclk),
        .q(mbid1[3:0]), .se(se), .si(), .so());


mux4ds  #(4) mux_mbid2  (.dout(mbid2_in[3:0]),
        .in0(mbctl_fbctl_next_link_c4[3:0]), .in1(mbf_entry_d2[3:0]),
        .in2(mbf_insert_mbid_c4[3:0]), .in3(mbid2[3:0]),
        .sel0(dep_wr_ptr_c4_rst[2]), .sel1(fb_set_valid_d2_rst[2]),
        .sel2(non_dep_wr_ptr_c4_rst[2]), .sel3(sel_def_mbid[2]));

dff_s   #(4)  ff_mbid2    (.din(mbid2_in[3:0]), .clk(rclk),
        .q(mbid2[3:0]), .se(se), .si(), .so());

mux4ds  #(4) mux_mbid3  (.dout(mbid3_in[3:0]),
        .in0(mbctl_fbctl_next_link_c4[3:0]), .in1(mbf_entry_d2[3:0]),
        .in2(mbf_insert_mbid_c4[3:0]), .in3(mbid3[3:0]),
        .sel0(dep_wr_ptr_c4_rst[3]), .sel1(fb_set_valid_d2_rst[3]),
        .sel2(non_dep_wr_ptr_c4_rst[3]), .sel3(sel_def_mbid[3]));

dff_s   #(4)  ff_mbid3    (.din(mbid3_in[3:0]), .clk(rclk),
        .q(mbid3[3:0]), .se(se), .si(), .so());

mux4ds  #(4) mux_mbid4  (.dout(mbid4_in[3:0]),
        .in0(mbctl_fbctl_next_link_c4[3:0]), .in1(mbf_entry_d2[3:0]),
        .in2(mbf_insert_mbid_c4[3:0]), .in3(mbid4[3:0]),
        .sel0(dep_wr_ptr_c4_rst[4]), .sel1(fb_set_valid_d2_rst[4]),
        .sel2(non_dep_wr_ptr_c4_rst[4]), .sel3(sel_def_mbid[4]));

dff_s   #(4)  ff_mbid4    (.din(mbid4_in[3:0]), .clk(rclk),
             .q(mbid4[3:0]), .se(se), .si(), .so());

mux4ds  #(4) mux_mbid5  (.dout(mbid5_in[3:0]),
        .in0(mbctl_fbctl_next_link_c4[3:0]), .in1(mbf_entry_d2[3:0]),
        .in2(mbf_insert_mbid_c4[3:0]), .in3(mbid5[3:0]),
        .sel0(dep_wr_ptr_c4_rst[5]), .sel1(fb_set_valid_d2_rst[5]),
        .sel2(non_dep_wr_ptr_c4_rst[5]), .sel3(sel_def_mbid[5]));

dff_s   #(4)  ff_mbid5    (.din(mbid5_in[3:0]), .clk(rclk),
             .q(mbid5[3:0]), .se(se), .si(), .so());

mux4ds  #(4) mux_mbid6  (.dout(mbid6_in[3:0]),
        .in0(mbctl_fbctl_next_link_c4[3:0]), .in1(mbf_entry_d2[3:0]),
        .in2(mbf_insert_mbid_c4[3:0]), .in3(mbid6[3:0]),
        .sel0(dep_wr_ptr_c4_rst[6]), .sel1(fb_set_valid_d2_rst[6]),
        .sel2(non_dep_wr_ptr_c4_rst[6]), .sel3(sel_def_mbid[6]));

dff_s   #(4)  ff_mbid6    (.din(mbid6_in[3:0]), .clk(rclk),
             .q(mbid6[3:0]), .se(se), .si(), .so());

mux4ds  #(4) mux_mbid7  (.dout(mbid7_in[3:0]),
        .in0(mbctl_fbctl_next_link_c4[3:0]), .in1(mbf_entry_d2[3:0]),
        .in2(mbf_insert_mbid_c4[3:0]), .in3(mbid7[3:0]),
        .sel0(dep_wr_ptr_c4_rst[7]), .sel1(fb_set_valid_d2_rst[7]),
        .sel2(non_dep_wr_ptr_c4_rst[7]), .sel3(sel_def_mbid[7]));

dff_s   #(4)  ff_mbid7    (.din(mbid7_in[3:0]), .clk(rclk),
             .q(mbid7[3:0]), .se(se), .si(), .so());

//////////////////////////////////////////////////////////////////////
// FB  next link valid:
// Set in the C4 cycle of an operation that writes mbid into
// the Fill Buffer. REset in the C4 cycle of a Fill operation.
//
// NOTE: The resetting of next_link vld cannot be done before C4
// since it is only set in C4 of a miss buffer/IQ operation.
//////////////////////////////////////////////////////////////////////

dff_s   #(8)  ff_fill_complete_c4    (.din(fill_complete_c3[7:0]), .clk(rclk),
             	.q(fill_complete_c4[7:0]), .se(se), .si(), .so());


assign	fb_next_link_vld_in = ( fb_next_link_vld |
				dep_wr_ptr_c4 |
				non_dep_wr_ptr_c4 ) & 
				~fill_complete_c4 ;

dffrl_s   #(8)  ff_fb_next_link_vld    (.din(fb_next_link_vld_in[7:0]), .clk(rclk), 
	.rst_l(dbb_rst_l), .q(fb_next_link_vld[7:0]), .se(se), .si(), .so());


////////////////
// Ready logic for dependent instructions.
// Dependents/Store instructions are readied on a Fill.
//
// In L2 off mode, stores are readied when the FB entry has
// the complete 64Bytes. Hence, we do not ready stores on
// a Fill in L2 OFF mode.
/////////////////

assign  fill_entry_0to3_c4 = |( fill_complete_c4[3:0]) ;


// Added for one hot sel and scan protection.
assign	fill_complete_0to3_def = ~(|fill_complete_c4[2:0]);
assign	fill_complete_4to7_def = ~(|fill_complete_c4[6:4]);

assign	fill_complete_sel[0] = fill_complete_c4[0] & ~rst_tri_en;
assign	fill_complete_sel[1] = fill_complete_c4[1] & ~rst_tri_en;
assign	fill_complete_sel[2] = fill_complete_c4[2] & ~rst_tri_en;
assign	fill_complete_sel[3] = fill_complete_0to3_def | rst_tri_en ;

assign	fill_complete_sel[4] = fill_complete_c4[4] & ~rst_tri_en;
assign	fill_complete_sel[5] = fill_complete_c4[5] & ~rst_tri_en;
assign	fill_complete_sel[6] = fill_complete_c4[6] & ~rst_tri_en;
assign	fill_complete_sel[7] = fill_complete_4to7_def | rst_tri_en ;


mux4ds  #(4) mux1_dep_mbid  (.dout(mux1_dep_mbid_c4[3:0]),
           .in0(mbid0[3:0]), .in1(mbid1[3:0]), .in2(mbid2[3:0]), .in3(mbid3[3:0]),
           .sel0(fill_complete_sel[0]), .sel1(fill_complete_sel[1]),
           .sel2(fill_complete_sel[2]), .sel3(fill_complete_sel[3]));

mux4ds  #(4) mux2_dep_mbid  (.dout(mux2_dep_mbid_c4[3:0]),
           .in0(mbid4[3:0]), .in1(mbid5[3:0]), .in2(mbid6[3:0]), .in3(mbid7[3:0]),
           .sel0(fill_complete_sel[4]), .sel1(fill_complete_sel[5]),
           .sel2(fill_complete_sel[6]), .sel3(fill_complete_sel[7]));


mux2ds  #(4) mux3_dep_mbid  (.dout(fbf_enc_dep_mbid_c4[3:0]),
           .in0(mux1_dep_mbid_c4[3:0]), .in1(mux2_dep_mbid_c4[3:0]),
           .sel0(fill_entry_0to3_c4), .sel1(~fill_entry_0to3_c4));


assign  fbf_st_or_dep_rdy_c4 =  |( fill_complete_c4 & 
		(	fb_next_link_vld |	// real dep.
		(fb_stinst & ~{8{l2_bypass_mode_on_d1}}) | 	// store inst
		(~fb_stinst & ~fb_nofill & {8{l2_dir_map_on_d1}} )) // any inst in dir map mode.
						// no FILLS have to be gated off because they
						// are invalidated in this cycle.
				 );



//////////////////////////////////////////////////////////////////////
// FB data interface.
// fbdata has two ports 1r and 1w. Read is performed in PH1 and write
// in PH2. 
//
// THe operations causing a read are as follows:
// - Any operation that hits the FB in 
// - An Imiss operation hitting the FB accesses it for 2 cycles.
// - A Fill operation 
// Here is the pipeline for read enable and read wl generation.
//
//-------------------------------------------------------------------
//	C2		C3		C4
//-------------------------------------------------------------------
//	generate	flop		read	
//	hit		in tagctl 	FB data.
//  	and hit entry
//
//	generate wen	xmit
//	and wordline	to fbdata
//
//	xmit to 
//	tagctl
//-------------------------------------------------------------------
//
//////////////////////////////////////////////////////////////////////

/////////
// Wr en and wr wordline generation.
/////////


// change r1 to r2 in the following equation.
mux2ds #(3) mux_fbwr_entry_c2  (.dout(fbctl_fbd_wr_entry_r1[2:0]),
           .in0(enc_hit_vec_c2[2:0]), .in1(dram_rd_req_id_r1[2:0]),
           .sel0(~dram_sctag_data_vld_r1), .sel1(dram_sctag_data_vld_r1));


/////////
//
// Rd en and rd wordline generation.
// 
/////////

assign	sel_c2_fill_entry = arbctl_fill_vld_c2 & ~l2_bypass_mode_on_d1 ;
assign	sel_c3_fill_entry = fill_vld_c3  & l2_bypass_mode_on_d1 ;

assign	fbctl_fbd_rd_en_c2 = fbctl_tagctl_hit_c2 | // replaced from fbctl_hit_c2
			imiss_ld64_fb_hit_c3 | 
			sel_c2_fill_entry |
			sel_c3_fill_entry ;

assign  enc_hit_vec_c2[0] = fb_hit_vec_c2[1] | fb_hit_vec_c2[3] |
                           fb_hit_vec_c2[5] | fb_hit_vec_c2[7]  ;

assign  enc_hit_vec_c2[1] = fb_hit_vec_c2[2] | fb_hit_vec_c2[3] |
                           fb_hit_vec_c2[6] | fb_hit_vec_c2[7]  ;

assign  enc_hit_vec_c2[2] = fb_hit_vec_c2[4] | fb_hit_vec_c2[5] |
                           fb_hit_vec_c2[6] | fb_hit_vec_c2[7]  ;


dff_s   #(3)  ff_enc_hit_vec_c3    (.din(enc_hit_vec_c2[2:0]), .clk(rclk),
               .q(enc_hit_vec_c3[2:0]), .se(se), .si(), .so());

dff_s   #(3)  ff_fill_entry_c2    (.din(arbdp_inst_mb_entry_c1[2:0]), .clk(rclk),
               .q(fill_entry_c2[2:0]), .se(se), .si(), .so());

dff_s   #(3)  ff_fill_entry_c3    (.din(fill_entry_c2[2:0]), .clk(rclk),
               .q(fill_entry_c3[2:0]), .se(se), .si(), .so());


// Pick C2 fill entry if Fill and $ ON
// Pick C3 fill entry if Fill and $ OFF.
// Else pick C3 hit entry.

assign	sel_def_hit_entry_mux1 = ~sel_c2_fill_entry & ~sel_c3_fill_entry ;


mux3ds  #(3) mux1_fb_entry_c2  (.dout(fb_rd_entry_c2[2:0]),
           	.in0(fill_entry_c2[2:0]), 
		.in1(fill_entry_c3[2:0]),
		.in2(enc_hit_vec_c3[2:0]),
           	.sel0(sel_c2_fill_entry), 
           	.sel1(sel_c3_fill_entry), 
		.sel2(sel_def_hit_entry_mux1));

assign	sel_c2_entry = sel_def_hit_entry_mux1 & ~imiss_ld64_fb_hit_c3  ;

mux2ds  #(3) mux2_fb_entry_c2  (.dout(fbctl_fbd_rd_entry_c2[2:0]),
           	.in0(enc_hit_vec_c2[2:0]), 
		.in1(fb_rd_entry_c2[2:0]),
           	.sel0(sel_c2_entry), 
		.sel1(~sel_c2_entry));


///////////////
// PICKER
///////////////

// Pick from the FIll Buffer.
assign  init_pick_state = ~dbb_rst_l | ~dbginit_l ;

// PICK STATE
assign  sel_l2st_lshift = arbctl_fbctl_fbsel_c1 & ~init_pick_state ;
assign  sel_l2st_same = ~arbctl_fbctl_fbsel_c1  & ~init_pick_state ;
assign  l2_rd_state_lshift = { l2_rd_state[2:0], l2_rd_state[3] } ;

mux3ds  #(4) mux_l2_rd_state  (.dout(l2_rd_state_in[3:0]),
                      .in0(4'b1), .in1(l2_rd_state_lshift[3:0]),
                      .in2(l2_rd_state[3:0]),
                      .sel0(init_pick_state), .sel1(sel_l2st_lshift),
                      .sel2(sel_l2st_same)) ;
dff_s   #(4)  ff_l2_rd_state    (.din(l2_rd_state_in[3:0]), .clk(rclk),
                        .q(l2_rd_state[3:0]), .se(se), .si(), .so());

// PICK STATE quad0
assign  sel_l2st_lshift_quad0 = ( arbctl_fbctl_fbsel_c1 
		&  (|(fb_l2_rd_ptr[3:0])) ) & ~init_pick_state ;
assign  sel_l2st_same_quad0 = ~( arbctl_fbctl_fbsel_c1 &  
		(|(fb_l2_rd_ptr[3:0])) )  & ~init_pick_state ;
assign  l2_rd_state_lshift_quad0 = { l2_rd_state_quad0[2:0], l2_rd_state_quad0[3] } ;

mux3ds  #(4) mux_l2_rd_state_quad0  (.dout(l2_rd_state_in_quad0[3:0]),
                           .in0(4'b1), .in1(l2_rd_state_lshift_quad0[3:0]),
                           .in2(l2_rd_state_quad0[3:0]),
                           .sel0(init_pick_state), .sel1(sel_l2st_lshift_quad0),
                           .sel2(sel_l2st_same_quad0)) ;
dff_s   #(4)  ff_l2_rd_state_quad0    (.din(l2_rd_state_in_quad0[3:0]), .clk(rclk),
                        .q(l2_rd_state_quad0[3:0]), .se(se), .si(), .so());
// PICK STATE quad1
assign  sel_l2st_lshift_quad1 = ( arbctl_fbctl_fbsel_c1 
		&  (|(fb_l2_rd_ptr[3:0])) ) & ~init_pick_state ;
assign  sel_l2st_same_quad1 = ~( arbctl_fbctl_fbsel_c1 
		&  (|(fb_l2_rd_ptr[3:0])) )  & ~init_pick_state ;
assign  l2_rd_state_lshift_quad1 = { l2_rd_state_quad1[2:0], l2_rd_state_quad1[3] } ;

mux3ds  #(4) mux_l2_rd_state_quad1  (.dout(l2_rd_state_in_quad1[3:0]),
                           .in0(4'b1), .in1(l2_rd_state_lshift_quad1[3:0]),
                           .in2(l2_rd_state_quad1[3:0]),
                           .sel0(init_pick_state), .sel1(sel_l2st_lshift_quad1),
                           .sel2(sel_l2st_same_quad1)) ;
dff_s   #(4)  ff_l2_rd_state_quad1    (.din(l2_rd_state_in_quad1[3:0]), .clk(rclk),
                        .q(l2_rd_state_quad1[3:0]), .se(se), .si(), .so());



// anchor
assign  pick_s0 = l2_rd_state[0] ;
assign  pick_s1 = l2_rd_state[1] ;
assign  pick_s2 = l2_rd_state[2] ;
assign  pick_s3 = l2_rd_state[3] ;

assign  pick_s0_quad0 = l2_rd_state_quad0[0];
assign  pick_s1_quad0 = l2_rd_state_quad0[1];
assign  pick_s2_quad0 = l2_rd_state_quad0[2];
assign  pick_s3_quad0 = l2_rd_state_quad0[3];

assign  pick_s0_quad1 = l2_rd_state_quad1[0];
assign  pick_s1_quad1 = l2_rd_state_quad1[1];
assign  pick_s2_quad1 = l2_rd_state_quad1[2];
assign  pick_s3_quad1 = l2_rd_state_quad1[3];


// anchor quads
assign  pick_quad_s0 = ( pick_s0 | pick_s2 ) ;
assign  pick_quad_s1 = ( pick_s1 | pick_s3 ) ;

// sel vector
assign  pick_quad0_in = ( l2_pick_vec[3:0] );
assign  pick_quad1_in = ( l2_pick_vec[7:4] ) ;

// sel vector  quad
assign  pick_quad_in[0] = |( pick_quad0_in ) ;
assign  pick_quad_in[1] = |( pick_quad1_in ) ;


// QUAD0 bits.
assign  pick_quad0_sel[0] = pick_quad0_in[0] &  ( pick_s0_quad0 |
                ( pick_s1_quad0 & ~( pick_quad0_in[1] |
                        pick_quad0_in[2] | pick_quad0_in[3] ) ) |
                        ( pick_s2_quad0 & ~(pick_quad0_in[2] | pick_quad0_in[3] )) |
                        ( pick_s3_quad0 & ~(pick_quad0_in[3] )  ) ) ;

assign  pick_quad0_sel[1] = pick_quad0_in[1] &  ( pick_s1_quad0 |
                ( pick_s2_quad0 & ~( pick_quad0_in[2] |
                        pick_quad0_in[3] | pick_quad0_in[0] ) ) |
                        ( pick_s3_quad0 & ~(pick_quad0_in[3] | pick_quad0_in[0] )) |
                        ( pick_s0_quad0 & ~(pick_quad0_in[0] )  ) ) ;


assign  pick_quad0_sel[2] = pick_quad0_in[2] &  ( pick_s2_quad0 |
                ( pick_s3_quad0 & ~( pick_quad0_in[3] |
                        pick_quad0_in[0] | pick_quad0_in[1] ) ) |
                        ( pick_s0_quad0 & ~(pick_quad0_in[0] | pick_quad0_in[1] )) |
                        ( pick_s1_quad0 & ~(pick_quad0_in[1] )  ) ) ;

assign  pick_quad0_sel[3] = pick_quad0_in[3] &  ( pick_s3_quad0 |
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

// QUAD

assign  pick_quad_sel[0] = pick_quad_in[0] &  ( pick_quad_s0 |
                ( pick_quad_s1 & ~pick_quad_in[1] ) )   ;

assign  pick_quad_sel[1] = pick_quad_in[1] &  ( pick_quad_s1 |
                ( pick_quad_s0 & ~pick_quad_in[0] ) )   ;

assign  fb_l2_rd_ptr_in[3:0] = ( pick_quad0_sel[3:0]  & {4{pick_quad_sel[0]}} ) ;
assign  fb_l2_rd_ptr_in[7:4] = ( pick_quad1_sel[3:0]  & {4{pick_quad_sel[1]}} ) ; 

assign	fbctl_fbtag_rd_ptr  = fb_l2_rd_ptr_in ;

dff_s   #(8)  ff_l2_rd_ptr   (.din(fb_l2_rd_ptr_in[7:0]), .clk(rclk),
            .q(fb_l2_rd_ptr[7:0]), .se(se), .si(), .so());


//////////////////////////////////////////////////////////////////////////////////
// DRAM related ERRORs
// fb_Cerr and fb_uerr: 
//
// When a DRAM read access encounters an error, an error indication is sent
// to the L2$. The L2 uses this indication to set DAC/DAU bits in the Error
// Status register.
// fb_cerr or fb_uerr bits are set synchronous with any data xfer from dram.
//
// If an instruction issued from the Miss Buffer hits an entry in the Fill Buffer
// with fb_cerr or fb_uerr, an error indication is reported to the sparcs 
// and the err bits are reset in fbctl. 
// AN error is not cleared in the case of a wr8 hitting the fill buffer in
// OFF mode. In this case, we wait for the fill to clear the ERROR 
// after causing a DAU to be reported.This is because a WR8 instruction will
// not be sending a st_ack but an evict_ack to the sparcs. The ERR field of
// a CPX evict_ack is ignored.
//
// Note: Set condition has a higher priority than the reset condition.
//
// If a fill happens before the bypass operation, an error indication is sent( to the cores)
// synchronous with the fill oepration and  the error bits are reset in fbctl.
//
// The following signals are generated in sctag_fbctl for logging and 
// reporting.
//
// Logging
//  fbctl_spc_uncorr_err_c7; //   
//  fbctl_spc_corr_err_c7; //   
//  fbctl_spc_rd_vld_c7; // 	
//  fbctl_bsc_corr_err_c12; // 
//  fbctl_ld64_fb_hit_c12; // 
//
// Reporting.
//  fbctl_dis_cerr_c3;
//  fbctl_dis_uerr_c3;
//
//
//
// fbctl_corr_err_c8, fbctl_uncorr_err_c8: Used only for logging of 
// 	errors DAC/DAU in sctag_csr_ctl.v. Generated during a Fill.
//
// fbctl_spc_corr_err_c7, fbctl_spc_uncorr_err_c7: Used for logging
//  	of DAC/DAU hits during sparc reads hitting the FIll buffer.
//	Also used to report errors to the issuing sparcs for 
//	Load/imiss/pst_read hits.
//
// fbctl_spc_rd_vld_c7: Used for reporting errors to the issuing sparc.
//	This bit will be used to detect any bit flips in the data that
//	is in the Fill Buffer. Any errors coming from DRAM will already
//	be detected by the above two signals fbctl_spc_corr_err_c7 &
//	fbctl_spc_uncorr_err_c7.
//
// fbctl_bsc_corr_err_c12: Used to detect correctable errors in 
//	an RDMA read instruction when it misses the L2. Used 
// 	for logging
//
// fbctl_ld64_fbhit_c12: Used for differentiating between an LDRU
// 	and a DRU error while logging.
//
//
//	
//
//			
//////////////////////////////////////////////////////////////////////////////////



dff_s   #(1)  ff_secc_err_r3 (.din(dram_sctag_secc_err_r2), .clk(rclk),
		.q(secc_err_r3), .se(se), .si(), .so());

dff_s   #(1)  ff_mecc_err_r3 (.din(dram_sctag_mecc_err_r2), .clk(rclk),
		.q(mecc_err_r3), .se(se), .si(), .so());

dff_s   #(1)  ff_data_vld_r2  (.din(dram_data_vld_r1), .clk(rclk),
                        .q(dram_data_vld_r2), .se(se), .si(), .so());
dff_s   #(1)  ff_data_vld_r3  (.din(dram_data_vld_r2), .clk(rclk),
                        .q(dram_data_vld_r3), .se(se), .si(), .so());

dff_s   #(3)  ff_dram_rd_req_id_r2 (.din(dram_rd_req_id_r1[2:0]), .clk(rclk),
			.q(dram_rd_req_id_r2[2:0]), .se(se), .si(), .so());

dff_s   #(3)  ff_dram_rd_req_id_r3 (.din(dram_rd_req_id_r2[2:0]), .clk(rclk),
			.q(dram_rd_req_id_r3[2:0]), .se(se), .si(), .so());


assign  fb_cerr_in[0] =  ( dram_rd_req_id_r3 == 3'd0 ) & secc_err_r3  & dram_data_vld_r3;
assign  fb_cerr_in[1] =  ( dram_rd_req_id_r3 == 3'd1 ) & secc_err_r3  & dram_data_vld_r3;
assign  fb_cerr_in[2] =  ( dram_rd_req_id_r3 == 3'd2 ) & secc_err_r3  & dram_data_vld_r3;
assign  fb_cerr_in[3] =  ( dram_rd_req_id_r3 == 3'd3 ) & secc_err_r3  & dram_data_vld_r3;
assign  fb_cerr_in[4] =  ( dram_rd_req_id_r3 == 3'd4 ) & secc_err_r3  & dram_data_vld_r3;
assign  fb_cerr_in[5] =  ( dram_rd_req_id_r3 == 3'd5 ) & secc_err_r3  & dram_data_vld_r3;
assign  fb_cerr_in[6] =  ( dram_rd_req_id_r3 == 3'd6 ) & secc_err_r3  & dram_data_vld_r3;
assign  fb_cerr_in[7] =  ( dram_rd_req_id_r3 == 3'd7 ) & secc_err_r3  & dram_data_vld_r3;

assign  fb_uerr_in[0] =  ( dram_rd_req_id_r3 == 3'd0 ) & mecc_err_r3  & dram_data_vld_r3;
assign  fb_uerr_in[1] =  ( dram_rd_req_id_r3 == 3'd1 ) & mecc_err_r3  & dram_data_vld_r3;
assign  fb_uerr_in[2] =  ( dram_rd_req_id_r3 == 3'd2 ) & mecc_err_r3  & dram_data_vld_r3;
assign  fb_uerr_in[3] =  ( dram_rd_req_id_r3 == 3'd3 ) & mecc_err_r3  & dram_data_vld_r3;
assign  fb_uerr_in[4] =  ( dram_rd_req_id_r3 == 3'd4 ) & mecc_err_r3  & dram_data_vld_r3;
assign  fb_uerr_in[5] =  ( dram_rd_req_id_r3 == 3'd5 ) & mecc_err_r3  & dram_data_vld_r3;
assign  fb_uerr_in[6] =  ( dram_rd_req_id_r3 == 3'd6 ) & mecc_err_r3  & dram_data_vld_r3;
assign  fb_uerr_in[7] =  ( dram_rd_req_id_r3 == 3'd7 ) & mecc_err_r3  & dram_data_vld_r3;


dff_s   #(1)  ff_wr8_inst_c3    (.din(decdp_wr8_inst_c2), .clk(rclk),
                .q(wr8_inst_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_wr8_inst_c4    (.din(wr8_inst_c3), .clk(rclk),
                .q(wr8_inst_c4), .se(se), .si(), .so());


assign	clear_err_c3 = fb_hit_vec_c3 & {8{fbctl_hit_c3 & ~wr8_inst_c3}} ; 

assign  fb_cerr_prev = ( fb_cerr  & ~( fill_complete_c3 | clear_err_c3 ) ) 
			| fb_cerr_in ;
assign  fb_uerr_prev = ( fb_uerr  & ~( fill_complete_c3 | clear_err_c3 ) ) 
			| fb_uerr_in ;

dffrl_s   #(8)  ff_fb_cerr (.din(fb_cerr_prev[7:0]), .clk(rclk), .q(fb_cerr[7:0]),
			.rst_l(dbb_rst_l),
                        .se(se), .si(), .so());

dffrl_s   #(8)  ff_fb_uerr (.din(fb_uerr_prev[7:0]), .clk(rclk), .q(fb_uerr[7:0]),
			.rst_l(dbb_rst_l),
                        .se(se), .si(), .so());

//////////////////////////
// Error during a FIll: 
// Reported to the CSR block.
//
// The fb_cerr/fb_uerr bits are 
// cleared by a fill or a HIT
// except for a wr8 hit.
// 
// However, a fbctl_corr err
// or fbctl_uncorr_err is 
// signalled only for a fill.
//
//////////////////////////

assign  fbctl_corr_err_c3 = |( dec_fill_entry_c3 & fb_cerr )  ;
assign  fbctl_uncorr_err_c3 = |( dec_fill_entry_c3 & fb_uerr )   ;


dff_s   #(1)  ff_fbctl_corr_err_c4  (.din(fbctl_corr_err_c3), .clk(rclk),
                                .q(fbctl_corr_err_c4), .se(se), .si(), .so());
dff_s   #(1)  ff_fbctl_corr_err_c5  (.din(fbctl_corr_err_c4), .clk(rclk),
                                .q(fbctl_corr_err_c5), .se(se), .si(), .so());
dff_s   #(1)  ff_fbctl_corr_err_c6  (.din(fbctl_corr_err_c5), .clk(rclk),
                                .q(fbctl_corr_err_c6), .se(se), .si(), .so());
dff_s   #(1)  ff_fbctl_corr_err_c7  (.din(fbctl_corr_err_c6), .clk(rclk),
                                .q(fbctl_corr_err_c7), .se(se), .si(), .so());
dff_s   #(1)  ff_fbctl_corr_err_c8  (.din(fbctl_corr_err_c7), .clk(rclk),
                                .q(fbctl_corr_err_c8), .se(se), .si(), .so());

dff_s   #(1)  ff_fbctl_uncorr_err_c4(.din(fbctl_uncorr_err_c3), .clk(rclk),
                              .q(fbctl_uncorr_err_c4), .se(se), .si(), .so());
dff_s   #(1)  ff_fbctl_uncorr_err_c5(.din(fbctl_uncorr_err_c4), .clk(rclk),
                              .q(fbctl_uncorr_err_c5), .se(se), .si(), .so());
dff_s   #(1)  ff_fbctl_uncorr_err_c6(.din(fbctl_uncorr_err_c5), .clk(rclk),
                              .q(fbctl_uncorr_err_c6), .se(se), .si(), .so());
dff_s   #(1)  ff_fbctl_uncorr_err_c7(.din(fbctl_uncorr_err_c6), .clk(rclk),
                              .q(fbctl_uncorr_err_c7), .se(se), .si(), .so());
dff_s   #(1)  ff_fbctl_uncorr_err_c8(.din(fbctl_uncorr_err_c7), .clk(rclk),
                              .q(fbctl_uncorr_err_c8), .se(se), .si(), .so());



///////////////////////////
// Error During a Hit.
// Sent to the deccdp block
///////////////////////////
dff_s   #(1)  ff_fbctl_hit_c3(.din(fbctl_hit_c2), .clk(rclk),
                              .q(fbctl_hit_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_fbctl_hit_c4(.din(fbctl_hit_c3), .clk(rclk),
                              .q(fbctl_hit_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_imiss_inst_c3(.din(decdp_imiss_inst_c2), .clk(rclk),
                              .q(imiss_inst_c3), .se(se), .si(), .so());

dff_s   #(1)  ff_imiss_inst_c4(.din(imiss_inst_c3), .clk(rclk),
                              .q(imiss_inst_c4), .se(se), .si(), .so());


dff_s   #(1)  ff_ld64_inst_c3(.din(decdp_ld64_inst_c2), .clk(rclk),
                              .q(ld64_inst_c3), .se(se), .si(), .so());

assign  spc_rd_vld_c3  = (fbctl_hit_c3 & spc_rd_cond_c3) | // any read of the Fill buffer.( other than rdma inst)
							    // should cause spc_rd_vld_c3 to go high.
                        ( fbctl_hit_c4 & imiss_inst_c4 ) ;




////////////////////////////
// sparc read
////////////////////////////

dff_s   #(1)  ff_spc_rd_vld_c4(.din(spc_rd_vld_c3), .clk(rclk),
                              .q(spc_rd_vld_c4), .se(se), .si(), .so());
dff_s   #(1)  ff_spc_rd_vld_c5(.din(spc_rd_vld_c4), .clk(rclk),
                              .q(spc_rd_vld_c5), .se(se), .si(), .so());
dff_s   #(1)  ff_spc_rd_vld_c6(.din(spc_rd_vld_c5), .clk(rclk),
                              .q(spc_rd_vld_c6), .se(se), .si(), .so());
dff_s   #(1)  ff_spc_rd_vld_c7(.din(spc_rd_vld_c6), .clk(rclk),
                              .q(spc_rd_vld_c7), .se(se), .si(), .so());

assign  fbctl_spc_rd_vld_c7 = spc_rd_vld_c7 ;

dff_s   #(1)  ff_fbcerr0_d1(.din(fb_cerr[0]), .clk(rclk),
                .q(fbcerr0_d1), .se(se), .si(), .so());

dff_s   #(1)  ff_fbuerr0_d1(.din(fb_uerr[0]), .clk(rclk),
                .q(fbuerr0_d1), .se(se), .si(), .so());

// In the OFF mode, fb_cerr & fb_uerr are reset in the C2 cycle of 
// a hit. Hence they are unavailable for setting fbhit_cerr_err_c3 &
// fbhit_uerr_err_c3. This problem can be solved by flopping fb_cerr_0 and
// fb_uerr_0 and using them in the L2 off mode for flagging errors.
//

assign  fbhit_cerr_err_c3 = (|( fb_hit_vec_c3 & fb_cerr ) | 
				(fb_hit_vec_c3[0] & fbcerr0_d1 & l2_bypass_mode_on_d1))
				 & qual_hit_vec_c3 ;
assign  fbhit_uerr_err_c3 = (|( fb_hit_vec_c3 & fb_uerr ) | 
				(fb_hit_vec_c3[0] & fbuerr0_d1 & l2_bypass_mode_on_d1))
				 & qual_hit_vec_c3 ;


assign  spc_corr_err_c3 = fbhit_cerr_err_c3 &
                                spc_rd_vld_c3 ; // the first packet of
                                                  // an imiss will clear
                                                  // the cerr bit.

assign  spc_uncorr_err_c3 = fbhit_uerr_err_c3 &
                                spc_rd_vld_c3 ; // the first packet of
                                                  // an imiss will clear
                                                  // the uerr bit.
////////////////////////////
// sparc corr err
////////////////////////////

dff_s   #(1)  ff_spc_corr_err_c4    (.din(spc_corr_err_c3), .clk(rclk),
                                .q(spc_corr_err_c4), .se(se), .si(), .so());
dff_s   #(1)  ff_spc_corr_err_c5    (.din(spc_corr_err_c4), .clk(rclk),
                                .q(spc_corr_err_c5), .se(se), .si(), .so());
dff_s   #(1)  ff_spc_corr_err_c6    (.din(spc_corr_err_c5), .clk(rclk),
                                .q(spc_corr_err_c6), .se(se), .si(), .so());
dff_s   #(1)  ff_spc_corr_err_c7    (.din(spc_corr_err_c6), .clk(rclk),
                                .q(spc_corr_err_c7), .se(se), .si(), .so());

assign  fbctl_spc_corr_err_c7 = spc_corr_err_c7 ;

////////////////////////////
// sparc uncorr err
////////////////////////////

dff_s   #(1)  ff_spc_uncorr_err_c4    (.din(spc_uncorr_err_c3), .clk(rclk),
                                .q(spc_uncorr_err_c4), .se(se), .si(), .so());
dff_s   #(1)  ff_spc_uncorr_err_c5    (.din(spc_uncorr_err_c4), .clk(rclk),
                                .q(spc_uncorr_err_c5), .se(se), .si(), .so());
dff_s   #(1)  ff_spc_uncorr_err_c6    (.din(spc_uncorr_err_c5), .clk(rclk),
                                .q(spc_uncorr_err_c6), .se(se), .si(), .so());
dff_s   #(1)  ff_spc_uncorr_err_c7    (.din(spc_uncorr_err_c6), .clk(rclk),
                                .q(spc_uncorr_err_c7), .se(se), .si(), .so());

assign  fbctl_spc_uncorr_err_c7 = spc_uncorr_err_c7 ;

////////////////////////////
// bsc corr err
////////////////////////////

assign  bsc_corr_err_c3 =  ( fbctl_hit_c3 & ld64_inst_c3 ) &
                                fbhit_cerr_err_c3 ;

dff_s   #(1)  ff_bsc_corr_err_c4    (.din(bsc_corr_err_c3), .clk(rclk),
                                .q(bsc_corr_err_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_bsc_corr_err_c5    (.din(bsc_corr_err_c4), .clk(rclk),
                                .q(bsc_corr_err_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_bsc_corr_err_c6    (.din(bsc_corr_err_c5), .clk(rclk),
                                .q(bsc_corr_err_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_bsc_corr_err_c7    (.din(bsc_corr_err_c6), .clk(rclk),
                                .q(bsc_corr_err_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_bsc_corr_err_c8    (.din(bsc_corr_err_c7), .clk(rclk),
                                .q(bsc_corr_err_c8), .se(se), .si(), .so());

dff_s   #(1)  ff_bsc_corr_err_c9    (.din(bsc_corr_err_c8), .clk(rclk),
                                .q(bsc_corr_err_c9), .se(se), .si(), .so());

dff_s   #(1)  ff_bsc_corr_err_c10    (.din(bsc_corr_err_c9), .clk(rclk),
                                .q(bsc_corr_err_c10), .se(se), .si(), .so());

dff_s   #(1)  ff_bsc_corr_err_c11    (.din(bsc_corr_err_c10), .clk(rclk),
                                .q(bsc_corr_err_c11), .se(se), .si(), .so());

dff_s   #(1)  ff_bsc_corr_err_c12    (.din(bsc_corr_err_c11), .clk(rclk),
                                .q(bsc_corr_err_c12), .se(se), .si(), .so());

assign  fbctl_bsc_corr_err_c12 = bsc_corr_err_c12 ;


////////////////////////////
// ld64 fb hit c12
////////////////////////////


assign  ld64_fb_hit_c3 = (fbctl_hit_c3 & ld64_inst_c3) ;

dff_s   #(1)  ff_ld64_fb_hit_c4    (.din(ld64_fb_hit_c3), .clk(rclk),
                                .q(ld64_fb_hit_c4), .se(se), .si(), .so());

dff_s   #(1)  ff_ld64_fb_hit_c5    (.din(ld64_fb_hit_c4), .clk(rclk),
                                .q(ld64_fb_hit_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_ld64_fb_hit_c6    (.din(ld64_fb_hit_c5), .clk(rclk),
                                .q(ld64_fb_hit_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_ld64_fb_hit_c7    (.din(ld64_fb_hit_c6), .clk(rclk),
                                .q(ld64_fb_hit_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_ld64_fb_hit_c8    (.din(ld64_fb_hit_c7), .clk(rclk),
                                .q(ld64_fb_hit_c8), .se(se), .si(), .so());

dff_s   #(1)  ff_ld64_fb_hit_c9    (.din(ld64_fb_hit_c8), .clk(rclk),
                                .q(ld64_fb_hit_c9), .se(se), .si(), .so());
dff_s   #(1)  ff_ld64_fb_hit_c10    (.din(ld64_fb_hit_c9), .clk(rclk),
                                .q(ld64_fb_hit_c10), .se(se), .si(), .so());

dff_s   #(1)  ff_ld64_fb_hit_c11    (.din(ld64_fb_hit_c10), .clk(rclk),
                                .q(ld64_fb_hit_c11), .se(se), .si(), .so());

dffe_s   #(1)  ff_ld64_fb_hit_c12    (.din(ld64_fb_hit_c11), .clk(rclk),
                                    .en(tagctl_rd64_complete_c11),
                                .q(ld64_fb_hit_c12), .se(se), .si(), .so());

assign  fbctl_ld64_fb_hit_c12 = ld64_fb_hit_c12;





//////////////////////////////////////////////////////////////////////////////////
// Asynchronous errors :
// Errors due to the following cases are reported as disrupting erross
// * eviction C and U
// * l2 scrub. C and U
// * dram scrub C and U
// * tag error.	C only
//
//////////////////////////////////////////////////////////////////////////////////


dff_s   #(1)  ff_dram_scb_mecc_err_d1    (.din(dram_sctag_scb_mecc_err), .clk(rclk),
                        .q(dram_scb_mecc_err_d1), .se(se), .si(), .so());

dff_s   #(1)  ff_dram_scb_secc_err_d1    (.din(dram_sctag_scb_secc_err), .clk(rclk),
                        .q(dram_scb_secc_err_d1), .se(se), .si(), .so());



//////////////
// UERR PEND
//
// POST_2.0 conditions:
//
// If an error is encountered while performing 
// the read part of a partial wr8. the error is
// recorded in the miss buffer and then registered
// as a pending error in fbctl . An ERROR indication
// is sent to the "steering sparc" on a FILL.
//
//////////////////////////////////////////////////////////


assign	uerr_ack_c4 = uerr_ack_tmp_c4 & wr8_inst_c4 ;

assign  fb_uerr_pend_set =     ev_uerr_r6 |	// eviction
				uerr_ack_c4 | 
                              dram_scb_mecc_err_d1 | // dram scrub err
                              decc_scrd_uncorr_err_c8 | // l2 scrub err.
				rdmard_uerr_c12 | // Ld64 error
				decc_bscd_uncorr_err_c8 ; // WR8 error in ON mode only.

assign  fb_uerr_pend_reset = (~fb_uerr_pend_set & fill_vld_c3 );

assign  fb_uerr_pend_in = ( fb_uerr_pend_set | fb_uerr_pend )
                                & ~fb_uerr_pend_reset ;

dffrl_s   #(1)  ff_fb_uerr_pend    (.din(fb_uerr_pend_in), .clk(rclk),.rst_l(dbb_rst_l),
                        .q(fb_uerr_pend), .se(se), .si(), .so());

//////////////
// CERR PEND
//////////////
assign	cerr_ack_c4 = cerr_ack_tmp_c4 & wr8_inst_c4 ;

assign  fb_cerr_pend_set =     ev_cerr_r6 |	// eviction
			cerr_ack_c4 | 
                        dram_scb_secc_err_d1 | // dram scrub err
			tag_error_c8 | 
                        decc_scrd_corr_err_c8 | // l2 scrub err.
			rdmard_cerr_c12 | // Ld 64 error. for LDRC
			fbctl_bsc_corr_err_c12 | // ld 64 error for DRC
			decc_bscd_corr_err_c8 ; // Wr8 error in L2 ON mode only

assign  fb_cerr_pend_reset = (~fb_cerr_pend_set & fill_vld_c3 );

assign  fb_cerr_pend_in = ( fb_cerr_pend_set | fb_cerr_pend )
                                & ~fb_cerr_pend_reset ;

dffrl_s   #(1)  ff_fb_cerr_pend    (.din(fb_cerr_pend_in), .clk(rclk),.rst_l(dbb_rst_l),
                        .q(fb_cerr_pend), .se(se), .si(), .so());


///////////////
//
// A Disrupting error is sent to the Thread and 
// Core pointed to by the steering control fields in the
// L2 control register.
//
// A disrupting error is sent under the following conditions.
// - A fill when the fb_?err bit is still set.
// - A Fill occurring after any of the following errors happen
//  1. eviction
//  2. scrub err from dram.
//  3. l2 scrub error.
//  4. rdma rd error.
//  5. err while performing the rd part of a Wr8 inst.
//  6. Tag ecc error.
// 
///////////////

assign  fbctl_dis_cerr_c3  =  fbctl_corr_err_c3   | // bypass operation
                        ( fill_vld_c3 & fb_cerr_pend ) ; // Fill operation

assign  fbctl_dis_uerr_c3  =  fbctl_uncorr_err_c3   |	
                        ( fill_vld_c3 & fb_uerr_pend ) ;





//////////////////////////////////////////////////////////////
// SCRUB / TECC: 
// The tecc bit
// in fbctl is used to get a scrub started.
// Reset in the C1 cycle of a FILL.
///////////////////////////////////////////////////////////////


assign  fb_tecc_pend_set = csr_fbctl_scrub_ready ;

assign  fb_tecc_pend_reset = ( ~csr_fbctl_scrub_ready & fb_tecc_pend_d1 &  arbctl_fbctl_fbsel_c1 );

assign  fb_tecc_pend_in = ( fb_tecc_pend_set | fb_tecc_pend ) & ~fb_tecc_pend_reset ;

dffrl_s   #(1)  ff_fb_tecc_pend    (.din(fb_tecc_pend_in), .clk(rclk),.rst_l(dbb_rst_l),
                                .q(fb_tecc_pend), .se(se), .si(), .so());

dff_s   #(1)  ff_fb_tecc_pend_d1    (.din(fb_tecc_pend), .clk(rclk),
                                .q(fb_tecc_pend_d1), .se(se), .si(), .so());


assign  fbctl_arbdp_tecc_px2  = fb_tecc_pend ;


endmodule




			     
