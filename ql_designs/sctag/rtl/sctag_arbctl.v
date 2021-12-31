// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_arbctl.v
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
`include 	"iop.h"
`include	"sctag.h"

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Description:
//	This module contains the following
//	// Mux sel logic for arbitration.
//	// select logic for advancing IQ/SNP/MB/FB pointers.
//	// mux selects for the dir CAM address muxes in arbaddrdp.
//	// Mux selects for the error addresses
//	// Instruction valid C1 and C2 
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

////////////////////////////////////////////////////////////////////////
// Local header file includes / local define
////////////////////////////////////////////////////////////////////////

module sctag_arbctl( /*AUTOARG*/
   // Outputs
   arbctl_mbctl_inval_inst_c2, arbctl_acc_vd_c2, arbctl_acc_ua_c2, 
   so, mux1_mbsel_px2, mux2_snpsel_px2, mux3_bufsel_px2, 
   mux4_c1sel_px2, data_ecc_idx_en, data_ecc_idx_reset, 
   sel_tecc_addr_px2, sel_decc_addr_px2, sel_diag_addr_px2, 
   sel_diag_tag_addr_px2, inc_tag_ecc_cnt_c3_n, 
   sel_lkup_stalled_tag_px2, bist_or_diag_acc_c1, 
   sel_decc_or_bist_idx, sel_vuad_bist_px2, arbctl_mbctl_inst_vld_c2, 
   arbctl_fbctl_inst_vld_c2, arbctl_inst_vld_c2, 
   arbctl_tagctl_inst_vld_c2, arbctl_wbctl_inst_vld_c2, 
   arbctl_imiss_hit_c10, arbctl_imiss_hit_c4, arbctl_evict_c3, 
   arbctl_evict_c4, sel_c2_stall_idx_c1, arbctl_vuad_acc_px2, 
   arbctl_tag_wr_px2, arbctl_vuad_idx2_sel_px2_n, 
   arbctl_mb_camen_px2, arbctl_fbctl_fbsel_c1, arbctl_mbctl_mbsel_c1, 
   arbctl_iqsel_px2, arbctl_evict_vld_c2, arbctl_inst_diag_c1, 
   arbctl_inst_vld_c1, scdata_fbrd_c3, arbctl_mbctl_ctrue_c9, 
   arbctl_mbctl_cas1_hit_c8, arbctl_decc_data_sel_c9, 
   arbctl_tecc_way_c2, arbctl_l2tag_vld_c4, dword_mask_c8, 
   arbctl_fill_vld_c2, arbctl_imiss_vld_c2, arbctl_normal_tagacc_c2, 
   arbctl_tagdp_tecc_c2, arbctl_dir_vld_c3_l, arbctl_dc_rd_en_c3, 
   arbctl_ic_rd_en_c3, arbctl_dc_wr_en_c3, arbctl_ic_wr_en_c3, 
   arbctl_dir_panel_dcd_c3, arbctl_dir_panel_icd_c3, 
   arbctl_lkup_bank_ena_dcd_c3, arbctl_lkup_bank_ena_icd_c3, 
   arbctl_inval_mask_dcd_c3, arbctl_inval_mask_icd_c3, 
   arbctl_wr_dc_dir_entry_c3, arbctl_wr_ic_dir_entry_c3, dir_addr_c9, 
   arbctl_dir_wr_en_c4, arbctl_csr_wr_en_c7, arbctl_csr_rd_en_c7, 
   arbctl_evict_c5, arbctl_waysel_gate_c2, arbctl_data_diag_st_c2, 
   arbctl_inval_inst_c2, arbctl_inst_diag_c2, decdp_ld64_inst_c1, 
   arbctl_waysel_inst_vld_c2, arbctl_coloff_inst_vld_c2, 
   arbctl_rdwr_inst_vld_c2, ic_inval_vld_c7, dc_inval_vld_c7, 
   arbctl_inst_l2data_vld_c6, arbctl_csr_wr_en_c3, 
   arbctl_csr_rd_en_c3, arbctl_diag_complete_c3, 
   arbctl_tagctl_pst_with_ctrue_c1, arbctl_csr_st_c2, 
   arbctl_mbctl_hit_off_c1, arbctl_pst_ctrue_en_c8, 
   arbctl_evict_tecc_vld_c2, arbctl_fbctl_hit_off_c1, 
   arbctl_wbctl_hit_off_c1, arbctl_inst_l2vuad_vld_c6, 
   arbctl_inst_l2tag_vld_c6, arbctl_snpsel_c1, 
   arbctl_dbgdp_inst_vld_c3, decdp_tagctl_wr_c1, decdp_pst_inst_c2, 
   decdp_fwd_req_c2, decdp_swap_inst_c2, decdp_imiss_inst_c2, 
   decdp_inst_int_c2, decdp_inst_int_c1, decdp_ld64_inst_c2, 
   decdp_bis_inst_c3, decdp_rmo_st_c3, decdp_strst_inst_c2, 
   decdp_wr8_inst_c2, decdp_wr64_inst_c2, decdp_st_inst_c2, 
   decdp_st_inst_c3, decdp_st_with_ctrue_c2, decdp_ld_inst_c2, 
   arbdp_dword_st_c2, arbdp_pst_with_ctrue_c2, decdp_cas1_inst_c2, 
   decdp_cas2_inst_c2, decdp_cas2_from_mb_c2, 
   decdp_cas2_from_mb_ctrue_c2, arbctl_inst_l2vuad_vld_c3, 
   write_req_c3, atomic_req_c3, prim_req_c3, decdp_pf_inst_c5, 
   decdp_strld_inst_c6, decdp_atm_inst_c6, store_err_c8, 
   arbdp_tecc_inst_mb_c8, arbctl_tagdp_perr_vld_c2, 
   arbdp_tagctl_pst_no_ctrue_c2, arbdp_mbctl_pst_no_ctrue_c2, 
   arbdp_vuadctl_pst_no_ctrue_c2, arbctl_tecc_c2, 
   vuadctl_no_bypass_px2, sel_way_px2, diag_or_tecc_write_px2, 
   arbctl_tag_rd_px2, arbctl_tag_way_px2, mux1_mbsel_px1, 
   wr8_inst_no_ctrue_c1, 
   // Inputs
   oqctl_arbctl_full_px2, mbctl_arbctl_vld_px1, 
   mbctl_arbctl_cnt12_px2_prev, mbctl_arbctl_snp_cnt8_px1, 
   wbctl_arbctl_full_px1, mbctl_arbctl_hit_c3, fbctl_arbctl_vld_px1, 
   iq_arbctl_vld_px2, iq_arbctl_vbit_px2, iq_arbctl_atm_px2, 
   iq_arbctl_csr_px2, iq_arbctl_st_px2, snpq_arbctl_vld_px1, 
   tagctl_decc_data_sel_c8, tagctl_rdma_vld_px1, data_ecc_active_c3, 
   decc_tag_acc_en_px2, mbctl_nondep_fbhit_c3, mbist_arb_l2d_en, 
   bist_vuad_rd_en_px1, arbdp_inst_fb_c2, arbdp_ioaddr_c1_39to37, 
   arbdp_ioaddr_c1_35to33, size_field_c8, word_lower_cmp_c8, 
   word_upper_cmp_c8, arbaddrdp_addr2_c8, arbdp_inst_size_c7, 
   arbdp_diag_wr_way_c2, arbdp_inst_byte_addr_c7, arbdp_inst_way_c1, 
   arbdp_tecc_c1, fbctl_arbdp_way_px2, arbdp_inst_mb_c2, 
   arbdp_inst_fb_c1, arbdp_inst_dep_c2, tagctl_hit_l2orfb_c3, 
   tagdp_arbctl_par_err_c3, invalid_evict_c3, arbdp_inst_nc_c3, 
   arbdp_cpuid_c3, arbdp_cpuid_c4, arbdp_cpuid_c5, arbdp_cpuid_c6, 
   arbdp_l1way_c3, arbdp_addr11to8_c3, arbdp_new_addr5to4_px2, 
   arbdp_addr5to4_c1, arbdp_addr5to4_c2, arbdp_addr5to4_c3, 
   arbdp_inst_fb_c3, arbdp_inst_mb_c3, arbdp_inst_tecc_c3, 
   arbdp_inst_bufidhi_c1, arbdp_inst_bufid1_c1, arbdp_inst_mb_c1, 
   arbdp_evict_c1, arbdp_inst_rqtyp_c1, arbdp_inst_rsvd_c1, 
   arbdp_inst_nc_c1, arbdp_word_addr_c1, arbdp_inst_ctrue_c1, 
   arbdp_inst_size_c1, arbdp_addr_start_c2, arbdp_rdma_inst_c2, 
   arbdp_inst_bufidlo_c2, arbdp_inst_rqtyp_c2, arbdp_inst_rqtyp_c6, 
   arbaddr_addr22_c2, bist_acc_vd_px1, mbist_arbctl_l2t_write, 
   l2_bypass_mode_on, rclk, grst_l, arst_l, dbginit_l, si, se, 
   sehold
   );

 input	oqctl_arbctl_full_px2; // oq is full. Comes from a flop in oqctl. oq=6 or greater

 input	mbctl_arbctl_vld_px1; // valid Miss Buffer instruction.
 input	mbctl_arbctl_cnt12_px2_prev; // NEW_PIN
 input	mbctl_arbctl_snp_cnt8_px1; // 8 or more snoop entries in the mbf.

 input	wbctl_arbctl_full_px1; // wb is full. Comes from a flop in wbctl
	 			// has to accomodate the instruction in PX2 and C1 

 input  mbctl_arbctl_hit_c3 ; // POST_4.2 pin ( place on the right towards the bottom )
 output arbctl_mbctl_inval_inst_c2 ; // POST_4.2 pin ( place on the right towards the bottom )

 input	fbctl_arbctl_vld_px1; // valid fill in the Fill Buffer.

 input	iq_arbctl_vld_px2; // valid iq instruction
 input	iq_arbctl_vbit_px2; // vbit in the payload.
 input	iq_arbctl_atm_px2; // Px2 packet is atomic with the following packet.
 input	iq_arbctl_csr_px2; // may be critical.
 input	iq_arbctl_st_px2; // predecode from iqdp.

 input	snpq_arbctl_vld_px1; // valid instruction at the head of the snoop q.

 


 input	tagctl_decc_data_sel_c8; // decc state machine store data state.
 input	tagctl_rdma_vld_px1;
 input 	data_ecc_active_c3; // decc state machine active.
 input	decc_tag_acc_en_px2; // decc FSM tag access state.
 input	mbctl_nondep_fbhit_c3; 



 
 input	mbist_arb_l2d_en; // from databist  POST_3.2
 input	bist_vuad_rd_en_px1;
 

 input	arbdp_inst_fb_c2; // fill instruction
 
 input	[39:37] arbdp_ioaddr_c1_39to37 ; // bits 39-32 are used to determine if the
				 // address space is DRAM or diagnostic.
 input	[35:33] arbdp_ioaddr_c1_35to33 ; // bits 39-32 are used to determine if the
                                 // address space is DRAM or diagnostic.


 // CAS compare related inputs
 input	[1:0]	size_field_c8; // from arbdec for cas compare.
 input		word_lower_cmp_c8; // from arbdata for cas compare.
 input		word_upper_cmp_c8; // from arbdec for cas compare.
 input		arbaddrdp_addr2_c8; // from arbdec for cas compare.
 
 // dwod mask generation inputs
 input	[2:0]	arbdp_inst_size_c7;

 input	[3:0]   arbdp_diag_wr_way_c2; // from the addr of a tag write instruction
  input	[2:0]	arbdp_inst_byte_addr_c7; // from arbaddr.

 input	[3:0]	arbdp_inst_way_c1 ;  // from bits of a C1 instruction 
 input		arbdp_tecc_c1 ;

 input	[3:0]	fbctl_arbdp_way_px2; // new instruction way.



 input	arbdp_inst_mb_c2;
 input	arbdp_inst_fb_c1;
 input	arbdp_inst_dep_c2;

 input	tagctl_hit_l2orfb_c3 ;
 input	tagdp_arbctl_par_err_c3; // used to gate off evicts in C3
 input  invalid_evict_c3 ; // from vuad dp.
 input	arbdp_inst_nc_c3 ;
 input	[2:0]	arbdp_cpuid_c3, arbdp_cpuid_c4, arbdp_cpuid_c5, arbdp_cpuid_c6; // from arbdec 
 input	[1:0]	arbdp_l1way_c3;

 input	[7:4]	arbdp_addr11to8_c3 ; // from arbaddr



 input	[1:0]	arbdp_new_addr5to4_px2; // from arbaddr not including stall mux results
 input	[1:0]	arbdp_addr5to4_c1; // from arbaddr not including stall mux results
 input	[1:1]	arbdp_addr5to4_c2; // from arbaddr not including stall mux results
 input	[1:0]	arbdp_addr5to4_c3; // from arbaddr not including stall mux results

input	arbdp_inst_fb_c3, arbdp_inst_mb_c3, arbdp_inst_tecc_c3;

input   arbdp_inst_bufidhi_c1 ; // NEW_PIN decode
input	arbdp_inst_bufid1_c1; 
input   arbdp_inst_mb_c1 ; // NEW_PIN decode
input   arbdp_evict_c1; // NEW_PIN decode. 
input	[`L2_RQTYP_HI:`L2_RQTYP_LO] arbdp_inst_rqtyp_c1 ; // NEW_PIN decode
input	arbdp_inst_rsvd_c1; // NEW_PIN decode
input	arbdp_inst_nc_c1 ; // NEW_PIN decode
input	[1:0]	arbdp_word_addr_c1; 
input		arbdp_inst_ctrue_c1;
input	[`L2_SZ_HI:`L2_SZ_LO]	arbdp_inst_size_c1;

input	arbdp_addr_start_c2; // NEW_PIN decode
input   arbdp_rdma_inst_c2; // NEW_PIN decode
input   arbdp_inst_bufidlo_c2 ; // NEW_PIN decode
input	[`L2_RQTYP_HI:`L2_RQTYP_LO] arbdp_inst_rqtyp_c2 ; // NEW_PIN decode
input	[`L2_RQTYP_HI:`L2_RQTYP_LO] arbdp_inst_rqtyp_c6 ; // NEW_PIN decode
 

 input	arbaddr_addr22_c2 ; // NEW_PIN
 input	bist_acc_vd_px1 ; // NEW_PIN from sctag_mbist.v
 input	mbist_arbctl_l2t_write ; // POST_4.0

 output	arbctl_acc_vd_c2 ; // NEW_PIN
 output	arbctl_acc_ua_c2 ; // NEW_PIN

 // csr inputs
 input	l2_bypass_mode_on;

 // new pin POST_2.0
 // new pin POST_2.0

 input	rclk;
 input	grst_l;
 input	arst_l;
 input	dbginit_l;
 input	si,se;
 input	sehold;


 output	so;

 output	mux1_mbsel_px2; // to all arbdps.
 output	mux2_snpsel_px2; // to all arbdps.
 output	mux3_bufsel_px2; // to all arbdps.
 output	mux4_c1sel_px2; // to all arbdps.

 output data_ecc_idx_en ; // to arbaddr 
 output data_ecc_idx_reset ; // to arbaddr.

 output sel_tecc_addr_px2; // sel for tecc,decc,diagtag mux in px2.
 output sel_decc_addr_px2; // sel for tecc,decc,diagtag mux in px2.
 output sel_diag_addr_px2; // sel for tecc,decc,diagtag mux in px2.
 output sel_diag_tag_addr_px2; // sel between C1 address and address from diag/tecc/decc accesses.
 output inc_tag_ecc_cnt_c3_n; // tecc instruction in C3.
 output sel_lkup_stalled_tag_px2; // sel tecc/diagtag/c1 tag address.

 output	bist_or_diag_acc_c1; // sel bist/diag data in arbaddr.
			     // used for bist vs diagnostic way selection
			     // in tagctl.

 output	sel_decc_or_bist_idx; // NEW_PIN
 output	sel_vuad_bist_px2 ; // NEW_PIN
 // output	sel_stall_vuad_idx; // to arbaddrdp. NEW_PIN

 output	arbctl_mbctl_inst_vld_c2; // instruction valid to mbctl
 output	arbctl_fbctl_inst_vld_c2; // instruction valid to fbctl.
 output	arbctl_inst_vld_c2; // valid instruction in C2.to arbaddr

 output	arbctl_tagctl_inst_vld_c2; // same as inst_vld_c2

 output	arbctl_wbctl_inst_vld_c2;

 output	arbctl_imiss_hit_c10; // mux select for err reporting for imisses
 output	arbctl_imiss_hit_c4; // mux select for dir cam address

 output	arbctl_evict_c3; // mux select for dir cam address
 output	arbctl_evict_c4; // mux select for writing the approp
			 // address into the directory

 output	sel_c2_stall_idx_c1; // this signal goes to the set logic in
			     // arbaddr
 output	arbctl_vuad_acc_px2; // is an enable for vuad access.
 output	arbctl_tag_wr_px2; // to tag for writes.
 output arbctl_vuad_idx2_sel_px2_n; 	// sel adr2 ( stalled addr ) for vuad access.

 output	arbctl_mb_camen_px2; // mbcam en.

 output	arbctl_fbctl_fbsel_c1 ; // indicates that an fb instruction got picked
 output	arbctl_mbctl_mbsel_c1; // indicates that an fb instruction got picked.
 output	arbctl_iqsel_px2; // indicates that the iq instruction got picked.

 output	arbctl_evict_vld_c2; // output to vuad dp.
 output	arbctl_inst_diag_c1; // output to vuad dp.


 output	arbctl_inst_vld_c1; // valid instruction in C1 

 // to scdata
 output	scdata_fbrd_c3; // mux select for wr data in scdata.

 // to mbctl
 output	arbctl_mbctl_ctrue_c9 ; // compare true. 
 output	arbctl_mbctl_cas1_hit_c8; // cas1 hit qualifier for the above inst.

 output 	arbctl_decc_data_sel_c9; // scrub data write select to arbdatadp ;
 output [3:0]	arbctl_tecc_way_c2; // to tagdp for tagecc related reads.
 output		arbctl_l2tag_vld_c4; // to tagdp for diagnostic read 
 // output		arbctl_int_or_diag_acc_c1; // to tagdp POST_2.0

 output	[7:0]	dword_mask_c8; // used in arbdata for pst merging.

 output		arbctl_fill_vld_c2; // to tagctl.
 output		arbctl_imiss_vld_c2; // to tagctl for way select mux


/////////////////////
// TAG DP outputs
/////////////////////
 output	arbctl_normal_tagacc_c2; // to tagdp
 output	arbctl_tagdp_tecc_c2; // NEW_PIN indicates that a tecc op is
			      // reading the tags.




/////////////////////
// Directory or Dir rep outputs 
/////////////////////
 // output		dir_vld_dcd_c4_l,  dir_vld_icd_c4_l; // OLD_PIN
output		arbctl_dir_vld_c3_l;  
output		arbctl_dc_rd_en_c3, arbctl_ic_rd_en_c3 ; // NEW_PIN
output		arbctl_dc_wr_en_c3,arbctl_ic_wr_en_c3 ; // NEW_PIN
output	[4:0]	arbctl_dir_panel_dcd_c3, arbctl_dir_panel_icd_c3 ; // NEW_PIN
output	[3:0]	arbctl_lkup_bank_ena_dcd_c3, arbctl_lkup_bank_ena_icd_c3 ; // NEW_PIN
output [7:0]	arbctl_inval_mask_dcd_c3,arbctl_inval_mask_icd_c3; // NEW_PIN
output	[4:0]	arbctl_wr_dc_dir_entry_c3, arbctl_wr_ic_dir_entry_c3 ; // NEW_PIN


 //output	[3:0]	lkup_bank_ena_dcd_c4, lkup_bank_ena_icd_c4 ; //  OLD_PIN

 output [10:0]  dir_addr_c9; // NEW_PIN

 output		arbctl_dir_wr_en_c4; // NEW_PIN to the csrblock


output	arbctl_csr_wr_en_c7; // to the csr block
output	arbctl_csr_rd_en_c7; // to oq_dctl.


 output	arbctl_evict_c5; // to oqctl.

///////////////////////
// tagctl outputs
///////////////////////
 output	arbctl_waysel_gate_c2;
 output	arbctl_data_diag_st_c2;
 output	arbctl_inval_inst_c2;
 output	arbctl_inst_diag_c2;
output	decdp_ld64_inst_c1; // POST_3.4 constrain it properly.

 output	 arbctl_waysel_inst_vld_c2; // POST_2.0
 output	 arbctl_coloff_inst_vld_c2; // POST_2.0
 output	 arbctl_rdwr_inst_vld_c2; // POST_2.0
 // output	 arbctl_wen_inst_vld_c2; // REMOVED POST_4.0

 output	ic_inval_vld_c7, dc_inval_vld_c7 ; // outputs to oqdp to send a st ack


 output	arbctl_inst_l2data_vld_c6; // diagnostic data access to deccdp.


output	arbctl_csr_wr_en_c3; // to tagctl for st ack generation
output	arbctl_csr_rd_en_c3; // to tagctl.
output	arbctl_diag_complete_c3;
output	arbctl_tagctl_pst_with_ctrue_c1 ; // POST_3.4 pin Bottom.
///////////////////////
// mbctl outputs
///////////////////////
output	arbctl_csr_st_c2; // to mbctl for insert and delete logic.
output	arbctl_mbctl_hit_off_c1 ; // turn off mb tag hit if this signal is high.
output	arbctl_pst_ctrue_en_c8;
output	arbctl_evict_tecc_vld_c2 ; // POST_2.0 pin

///////////////////////
// fbctl outputs
///////////////////////
 output	arbctl_fbctl_hit_off_c1 ; // turn off fb tag hit if this signal is high.

///////////////////////
// wbctl outputs
///////////////////////
 output	arbctl_wbctl_hit_off_c1 ; // turn off wb tag hit if this signal is high.

///////////////////////
// oq_dctl outputs
///////////////////////
  output	arbctl_inst_l2vuad_vld_c6;
  output	arbctl_inst_l2tag_vld_c6;

///////////////////////
// to snpctl
///////////////////////
 output	arbctl_snpsel_c1;

output	arbctl_dbgdp_inst_vld_c3; // to dbgdp.

output	decdp_tagctl_wr_c1;

output	decdp_pst_inst_c2 ;
output	decdp_fwd_req_c2;
output	decdp_swap_inst_c2;
output	decdp_imiss_inst_c2;
output	decdp_inst_int_c2, decdp_inst_int_c1 ; // NEW_PIN decode
output	decdp_ld64_inst_c2; // NEW_PIN decod
output	decdp_bis_inst_c3, decdp_rmo_st_c3; // NEW_PIN decode
output	decdp_strst_inst_c2; // NEW_PIN decode
output	decdp_wr8_inst_c2, decdp_wr64_inst_c2 ; // NEW_PIN decode
output	decdp_st_inst_c2, decdp_st_inst_c3 ; // NEW_PIN decode.
output	decdp_st_with_ctrue_c2;
output	decdp_ld_inst_c2;
output	arbdp_dword_st_c2 ;
output	arbdp_pst_with_ctrue_c2;
output	decdp_cas1_inst_c2;
output	decdp_cas2_inst_c2;
output	decdp_cas2_from_mb_c2;
output	decdp_cas2_from_mb_ctrue_c2;

output	arbctl_inst_l2vuad_vld_c3; // to vuaddp_ctl

output	write_req_c3, atomic_req_c3, prim_req_c3 ; // to arbdecdp

output	decdp_pf_inst_c5;
output	decdp_strld_inst_c6, decdp_atm_inst_c6 ; 

output	store_err_c8;
output	arbdp_tecc_inst_mb_c8;
output	arbctl_tagdp_perr_vld_c2; // POST_2.0 pin

output	arbdp_tagctl_pst_no_ctrue_c2; // POST 3.0 pin
output	arbdp_mbctl_pst_no_ctrue_c2; // POST 3.0 pin
output	arbdp_vuadctl_pst_no_ctrue_c2; // POST 3.0 pin

output	arbctl_tecc_c2; // POST_3.0 PIN

 output	vuadctl_no_bypass_px2; // POST_3.1 pin

 output		sel_way_px2;  // selects go to arbaddr to wr data muxes
 output		diag_or_tecc_write_px2 ;  // selects go to arbaddr to wr data muxes
 output		arbctl_tag_rd_px2; // to tag for reads.
 output [11:0]	arbctl_tag_way_px2; // tag write way.
 output	mux1_mbsel_px1;
 output		wr8_inst_no_ctrue_c1; // POST_3.4


 wire	arbctl_tag_acc_px2 ; // indicates that the tag array is accessed.
 wire	sel_delayed_fill_wr_c1, sel_fill_wr_px2;

 wire		set_gate_off_prim_req_px2;
 wire		gate_off_prim_req_c1;
 wire		gate_off_prim_req_state;
 wire		gate_off_prim_req_state_in;

 wire	arbctl_inst_l2vuad_c2 ;
 wire	inst_l2vuad_vld_c2, inst_l2vuad_vld_c3, inst_l2vuad_vld_c4 ;
 wire	inst_l2tag_vld_c3, inst_l2tag_vld_c4;

 wire	arbctl_multi_cyc_c1;
 wire	arbctl_stall_c2 ;
 wire	same_col_stall_c1, arbctl_prev_stall_c1, arbctl_stall_c1 ;
 wire	decdp_st_inst_c3_1;


 wire   mbf_valid_px1,mbf_valid_px2;
 wire   snp_valid_px2;
 wire   fbf_valid_px1;

 wire   mbsel_px2,mbsel_c1;
 wire   snpsel_px2,snpsel_c1,snpsel_c2, snpsel_c3;
 wire   fbsel_px2,fbsel_c1;
 wire	iqsel_px2;
 wire	mbfull_px2;
 wire	arbctl_inst_vld_px2;
 wire	inst_vld_c2_prev;
 
 wire   atm_instr_c1, atm_instr_px2;
 wire	inc_tag_ecc_cnt_c3;


 wire	arbctl_inst_l2tag_c2;
 wire	inst_l2tag_vld_c2; // needed in muxsel generation for arbaddr
 wire	arbctl_inst_l2data_c2;
 wire	inst_l2data_vld_c2; // used in muxsel generation for arbdata
 wire	inst_l2data_vld_c3, inst_l2data_vld_c4;
 wire	inst_l2data_vld_c5, inst_l2data_vld_c6;
 wire	cmp_lower_c9, cmp_upper_c9, cmp_dword_c9;

 wire	[6:0]	tecc_st_cnt_plus1, tecc_st_cnt ;

 wire	[3:0]	tag_diag_or_tecc_way_c2;
 wire	[3:0]	stalled_tag;

 wire	[2:0]	inst_size_c7;
 wire	[2:0]	end_addr_2to0;

 wire	[7:0]	dec_start_addr;
 wire	[7:0]	dec_end_addr;
 wire	[7:0]	cum_or_start_addr_c7;
 wire	[7:0]	cum_or_end_addr_c7 ;
 wire	[7:0]	dword_mask_c7; 
 wire	hit_l2orfb_c4, hit_l2orfb_c5, hit_l2orfb_c6, hit_l2orfb_c7, hit_l2orfb_c8 ;
 wire	arbctl_inst_vld_c3; // used to qualify address compares
 wire	arbctl_inst_vld_c3_1; // used to qualify address compares

 
 wire	[10:0]	dir_addr_cnt_plus1,dir_addr_cnt_c3;
 wire	[10:0]	dir_addr_cnt_c4,dir_addr_cnt_c5;
 wire	[10:0]	dir_addr_cnt_c6,dir_addr_cnt_c7, dir_addr_cnt_c8;
 wire	[4:0]	dir_entry_c3, dir_entry_c4, dir_entry_c5, dir_entry_c6 ;
 wire	[4:0]	tmp_wr_dir_entry_c3, wr_dir_entry_c3 ;	
 wire		def_inval_entry;
 wire	[4:0]	dc_wr_panel_c3, dc_wr_panel_c4;
 wire	[4:0]	dc_wr_panel_c5, dc_wr_panel_c6;
 wire	[4:0]	tmp_dc_wr_panel_c3;
 wire	[4:0]	ic_wr_panel_c3, ic_wr_panel_c4;
 wire	[4:0]	ic_wr_panel_c5, ic_wr_panel_c6;
 wire	[4:0]	tmp_ic_wr_panel_c3;
 wire	[7:0]	self_inval_mask_c3, others_inval_mask_c3, tmp_inval_mask_c3 ;
 wire	[2:0]	cpuid_c3;
 wire		ld_inst_c3, ld_hit_c3, sel_stld_mask;
 wire		inval_inst_vld_c2 ;
 wire		dc_inval_vld_c3, ic_inval_vld_c3, inval_inst_vld_c3; 
 wire		dc_inval_vld_c4, ic_inval_vld_c4, inval_inst_vld_c4; 
 wire		dc_inval_vld_c5, ic_inval_vld_c5, inval_inst_vld_c5; 
 wire		dc_inval_vld_c6, ic_inval_vld_c6, inval_inst_vld_c6; 
 wire		dc_inval_c3, ic_inval_c3;
 
 wire	[3:0]	dc_cam_addr_c3, ic_cam_addr_c3 ;
 wire		enc_cam_addr_c4 ;
 wire		dc_hitqual_cam_en0_c3, dc_hitqual_cam_en1_c3, ic_hitqual_cam_en_c2 ;

 wire		tmp_bank_icd_c3 ;

 wire	st_cam_en_c2 ;
  wire	waysel_gate_c1;

 wire	arbctl_imiss_hit_c5, arbctl_imiss_hit_c7 ;
 wire	arbctl_imiss_hit_c8, arbctl_imiss_hit_c9 ;
 wire	tecc_inst_c2;
 wire	tecc_tag_acc_en_px2;
 wire	inc_tag_ecc_cnt_c2;
 wire	data_ecc_active_c4 ; // used for stall.
 wire	arbctl_inst_csr_c2;

 wire	imiss_inst_c3;
 wire	st_cam_en_c3;
 wire	sp_cam_en_c2, sp_cam_en_c3; // special instruction cam en
 wire	ic_hitqual_cam_en_c3;
wire	imiss_hit_c3;

wire	arbctl_evict_unqual_c3;
wire	arbctl_csr_wr_en_c2, arbctl_csr_wr_en_c4;
wire	arbctl_csr_wr_en_c5, arbctl_csr_wr_en_c6, arbctl_csr_wr_en_c8;
wire	arbctl_csr_rd_en_c2, arbctl_csr_rd_en_c4;
wire	arbctl_csr_rd_en_c5, arbctl_csr_rd_en_c6;
  wire	inst_l2vuad_vld_c5, inst_l2vuad_vld_c6;
  wire	inst_l2tag_vld_c5, inst_l2tag_vld_c6;

 wire	arbctl_inst_csr_c1;
 wire	arbctl_inst_l2data_c1;
 wire	arbctl_inst_l2tag_c1;
 wire	arbctl_inst_l2vuad_c1;
 wire	store_inst_en_c3 ;

 wire	sp_tag_access_c1, sp_tag_access_px2 ;
 wire	arbctl_tag_acc_c1;
 wire	normal_tagacc_c1, normal_tagacc_c2;
 wire	arbctl_stall_unqual_c2;

 wire	wr64_inst_c3;
 wire	rdma_64B_stall;
 wire	arbctl_fill_vld_c3;
 wire	arbctl_imiss_hit_c6; 

 wire	gate_off_buf_req_px2;
 wire	snp_muxsel_px1  ;
 wire	arbctl_dir_wr_en_c3;

 wire	 bist_enable_c1, bist_enable_c2 ;
 wire	bist_acc_vd_c1, bist_acc_vd_c2 ;

 // Decode 


wire	decdp_inst_int_or_inval_c1; 
wire	arbdp_inst_mb_or_fb_c1 ;

wire	decdp_rmo_st_c2, decdp_bis_inst_c2 ;
wire	decdp_strst_inst_c1;
wire	decdp_wr8_inst_c1, decdp_wr64_inst_c1 ;
wire	decdp_st_inst_c1;
wire	dec_evict_c1, dec_evict_c2;

wire	decdp_strpst_inst_c1, decdp_rdmapst_inst_c1;
wire	decdp_pst_inst_c1;
wire	pst_with_ctrue_c1, decdp_cas1_inst_c1;
wire	decdp_cas2_inst_c1, decdp_cas2_from_mb_c1;
wire	decdp_cas2_from_mb_ctrue_c1;
wire	decdp_cas2_from_xbar_c1;
wire	decdp_pst_st_c1, pst_no_ctrue_c1;
wire	st_with_ctrue_c1;
wire	arbdp_tecc_inst_c1;
wire	store_err_c2, store_err_c3, store_err_c4 ;
wire	store_err_c5, store_err_c6, store_err_c7 ;
wire	decdp_fwd_req_c1;
wire	decdp_swap_inst_c1;
wire	decdp_camld_inst_c1, decdp_camld_inst_c2;
wire	decdp_imiss_inst_c1; 
wire	decdp_ld_inst_c1;
wire	decdp_pf_inst_c1, decdp_pf_inst_c2;
wire	decdp_pf_inst_c3, decdp_pf_inst_c4;
wire	dword_st_c1;
wire	decdp_dc_inval_c1, decdp_dc_inval_c2;
wire	decdp_ic_inval_c1, decdp_ic_inval_c2;
wire	multi_cyc_op_c1;
wire	decdp_pst_inst_c3, decdp_pst_inst_c4, decdp_pst_inst_c5;
wire	decdp_pst_inst_c6, decdp_pst_inst_c7 ;
wire	pst_no_ctrue_c3, pst_no_ctrue_c4, pst_no_ctrue_c5 ;
wire	pst_no_ctrue_c6, pst_no_ctrue_c7 ;
wire	arbdp_pst_no_ctrue_c8;
wire	decdp_cas1_inst_c3, decdp_cas1_inst_c4, decdp_cas1_inst_c5 ;
wire	decdp_cas1_inst_c6, decdp_cas1_inst_c7, decdp_cas1_inst_c8 ;
wire	sp_pst_inst_c2, sp_pst_inst_c3, sp_pst_inst_c4 ;
wire	sp_pst_inst_c5, sp_pst_inst_c6, sp_pst_inst_c7 ;
wire	decdp_strpst_inst_c2, decdp_rdmapst_inst_c2;
wire	write_req_c2, atomic_req_c2;
wire	arbdp_tecc_inst_mb_c3, arbdp_tecc_inst_mb_c4;
wire	arbdp_tecc_inst_mb_c5, arbdp_tecc_inst_mb_c6;
wire	arbdp_tecc_inst_mb_c7;
wire	tecc_st_cnt_reset;

 wire	arbctl_inst_vld_c2_1, arbctl_inst_vld_c2_2;
 wire	arbctl_inst_vld_c2_3, arbctl_inst_vld_c2_4;
 wire	arbctl_inst_vld_c2_5, arbctl_inst_vld_c2_6;
 wire	arbctl_inst_vld_c2_7;


wire	imiss_stall_op_c1inc1;
wire	decdp_cas1_inst_c1_1, decdp_cas1_inst_c2_1;
wire	arbctl_stall_tmp_c1;
wire	mbf_valid_px2_1;
wire	fbf_valid_px2_1;
wire	snp_valid_px2_1;
wire	arbctl_inst_vld_c1_1;
wire	decdp_st_inst_c2_1;
wire	decdp_strst_inst_c2_1;
wire	tecc_tag_acc_en_px1;
wire	arbctl_tagdp_tecc_c1;
wire	arbctl_csr_wr_en_c3_1;
wire	decdp_wr64_inst_c2_1;
wire	arbdp_pst_no_ctrue_c2_1;
wire	parerr_gate_c1, parerr_gate_c2;
wire	dec_evict_tecc_c1, dec_evict_tecc_c2;
wire	arbdp_evict_c2, arbdp_evict_c3;
 wire	arbctl_inst_vld_c2_8, arbctl_inst_vld_c2_9;
 wire	arbctl_inst_vld_c2_10;
 wire	bist_vuad_rd_en_px2;
 wire	bist_acc_vd_px2;
  wire	store_inst_vld_c3;
  wire	store_inst_vld_c3_1;
 wire	lower_cas_c8, lower_cas_c9;
 wire	upper_cas_c8, upper_cas_c9;
 wire	word_lower_cmp_c8, word_lower_cmp_c9;
 wire	word_upper_cmp_c8, word_upper_cmp_c9;
wire	[3:0]	enc_tag_way_px2;
wire	[3:0]	dec_lo_way_sel_c1;
wire	[2:0]	dec_hi_way_sel_c1 ;
wire	decdp_st_inst_c3_2, arbctl_inst_vld_c3_2 ;
wire	store_inst_vld_c3_2;
wire	arbctl_inst_l2tag_c2_1;
  wire	scrub_fsm_count_eq_5_px1, scrub_fsm_count_eq_6_px2;
 wire	diag_or_tecc_acc_px2, diag_or_tecc_acc_c1;
 wire	diag_or_scr_way_sel;
wire	inst_l2tag_vld_c2_1;
  wire	scrub_fsm_count_eq_0_px1, scrub_fsm_count_eq_1_px2 ;
wire	inst_bufid1_c2;
 wire	mux3_bufsel_px1;
 wire	snp_valid_px1;
 wire	wr8_inst_pst_c1;

wire	arbdp_inst_fb_c1_qual;

assign	arbdp_inst_fb_c1_qual =  arbdp_inst_fb_c1 & arbctl_inst_vld_c1_1;



 ///////////////////////////////////////////////////////////////////
 //
 // L2 $ OFF mode exceptions in arbctl:
 // 	IN the L2 $ off mode, a fill can only be issued if the
 // 	wbb is not full. This is factored into the fbsel logic in PX1
 //
 ///////////////////////////////////////////////////////////////////


 ///////////////////////////////////////////////////////////////////
 // Reset flop
 ///////////////////////////////////////////////////////////////////

 dffrl_async	#(1)	reset_flop	(.q(dbb_rst_l), 
					.clk(rclk),
                        		.rst_l(arst_l),
                    			.din(grst_l), 
					.se(se), .si(), .so());


 ///////////////////////////////////////////////////////////////////
 // Sel for  picking ctu data over sparc data for a BIST control reg
 // CSR write. 
 ///////////////////////////////////////////////////////////////////
 

 ///////////////////////////////////////////////////////////////////
 //pipeline for gating off instructions due to CSR stores.
 //--------------------------------------------------------------------
 // 		PX2		C1
 //--------------------------------------------------------------------
 //		csr store
 //		selected
 //		from IQ
 //				assert
 //				primary
 //				request 
 //				blackout.
 //				
 //--------------------------------------------------------------------
 //				PX2
 //--------------------------------------------------------------------
 //				
 //				gate off
 //				issue from
 //				all srcs except
 //				C1
 //				
 //				
 //--------------------------------------------------------------------
 //				PX1		PX2
 //--------------------------------------------------------------------
 //				gate off
 //				issue from
 //				snpQ		
 //
 //						gate
 //						off issue
 //						from IQ
 //
 //						continue
 //						fb/mb reqs.
 //					
 ////////////////////////////////////////////////////////////////



 assign set_gate_off_prim_req_px2 = (  iq_arbctl_csr_px2 &  // csr address
	                            iq_arbctl_st_px2 &  // store
				    iq_arbctl_vbit_px2 & 
	                            iqsel_px2 ) ; // select an IQ instruction.

 dff_s     #(1)    ff_gate_off_prim_req_c1     (.q(gate_off_prim_req_c1), .clk(rclk), 
                 .din(set_gate_off_prim_req_px2), .se(se), .si(), .so());

 assign gate_off_prim_req_state_in = ( gate_off_prim_req_state | // gate off state==1
                             gate_off_prim_req_c1 ) & // PX2 req is a csr store.
                            ~( arbctl_csr_wr_en_c8 ) ;

 dffrl_s     #(1)    ff_gate_off_prim_req_state     (.q(gate_off_prim_req_state), .clk(rclk), 
			.rst_l(dbb_rst_l),
		    .din(gate_off_prim_req_state_in), .se(se), .si(), .so());


 // miss buffer instructions are blacked out for 2 cycles after issue.  
 assign	mbf_valid_px1 = ( mbctl_arbctl_vld_px1 & ~mbsel_px2 & ~mbsel_c1 )  & //  2 cycle blackout.
		         ~wbctl_arbctl_full_px1; // wb can accept only 2 more reqs

 // snpq instructions are blacked out for 4 cycles after issue.
 // A snoop/rdma instruction is issued one every 4 cycles at best.
 // In the C3 cycle of a snoop, the rdma register vld signal
 // will go high ( if the rdma instruction can complete ) and 
 // prevent an instruction from issuing until the register goes low.

 // A snoop is blacked out until, the previous snoop has had
 // an opportunity to set rdma_reg_vld in C4.


 assign	snp_muxsel_px1 = ( snpq_arbctl_vld_px1 & 
	  ~snpsel_px2 & ~snpsel_c1 & ~snpsel_c2  & ~snpsel_c3) // blacked out for 4 cycles.
		& ~mbctl_arbctl_snp_cnt8_px1 // no more than 8 snp entries in the mbf
		//& ~mbctl_arbctl_cnt11_px1 // no more than 11 entries in the mbf
		& ~tagctl_rdma_vld_px1 // reg_vld for stores is ~ 6 cycles and for loads is ~17 cycles
 		& ~gate_off_prim_req_state & // csr instruction in the pipe c2 or beyond.
	      	~gate_off_prim_req_c1; // csr instruction in C1

 dff_s     #(1)    ff_l2_bypass_mode_on_d1     (.q(l2_bypass_mode_on_d1), .clk(rclk), 
                 .din(l2_bypass_mode_on), .se(se), .si(), .so());

 // fill buffer instructions. are blacked out for 2 cycles after issue.
 assign	fbf_valid_px1 = ( fbctl_arbctl_vld_px1 & ~fbsel_px2 & ~fbsel_c1 )  // 2 cycle blackout
			& ~(wbctl_arbctl_full_px1 & l2_bypass_mode_on_d1 ) ; // wb is inserted by 
									  // a fill in OFF mode.

 assign	mux1_mbsel_px1 = mbf_valid_px1 ; // introduced for evicttagdp.


 dff_s     #(1)    ff_mbf_valid_px2     (.q(mbf_valid_px2), .clk(rclk),
                                       .din(mbf_valid_px1), .se(se), .si(), .so());

 dff_s     #(1)    ff_mbf_valid_px2_1     (.q(mbf_valid_px2_1), .clk(rclk),
                                       .din(mbf_valid_px1), .se(se), .si(), .so());

 dff_s     #(1)    ff_fbf_valid_px2_1     (.q(fbf_valid_px2_1), .clk(rclk),
                                       .din(fbf_valid_px1), .se(se), .si(), .so());

 assign	snp_valid_px1 = snp_muxsel_px1 & ~mbctl_arbctl_cnt12_px2_prev ;

 dff_s     #(1)    ff_snp_valid_px2     (.din(snp_valid_px1), .clk(rclk),
                                       .q(snp_valid_px2), .se(se), .si(), .so());

 dff_s     #(1)    ff_snp_valid_px2_1     (.din(snp_valid_px1), .clk(rclk),
                                       .q(snp_valid_px2_1), .se(se), .si(), .so());

 assign	mux3_bufsel_px1 = ( mbf_valid_px1 | fbf_valid_px1 | snp_valid_px1 ) &
			~atm_instr_px2 ;

 dff_s     #(1)    ff_mux3_bufsel_px2     (.din(mux3_bufsel_px1), .clk(rclk),
                                       .q(mux3_bufsel_px2), .se(se), .si(), .so());


 // mux3 selects between the BUffer/snp instructions and the instruction from the IQ,
 // IQ instructions have priority only if the instruction currently in C1 is atomic with
 // the instruction in PX2.
 //assign	mux3_bufsel_px2 = ( mbf_valid_px2_1 | fbf_valid_px2 | snp_valid_px2 ) & 
			    //~atm_instr_c1;


////////////////////////////////////////////////////////
// mux select for addresses
//////////////////////////////////////////////////////

 // Mux1 in the arbiter selects between a Miss Buffer instruction and
 // a Fill. The Miss Buffer instruction has higher priority

 assign	mux1_mbsel_px2 = mbf_valid_px2 ;

 // mux2 selects between the MB/FB instruction or an external snoop
 // snoop has a higher priority.

 assign	mux2_snpsel_px2 = snp_valid_px2  ;

 /////////////////////////////////////////////////////////////////////////////////////////////////
 // atomic instruction logic
 // an atomic instruction in PX2 stage of the IQ pipe will cause the PX1 instruction to be issued
 // immediately following it. However, if there is a stall asserted for the atomic instruction in C1,
 // the selection of the following instruction from the IQ is postponed until after the stall.
 // IQ pipeline
 //--------------------------------------------------------------------
 //	PX1 		PX2		C1		
 //--------------------------------------------------------------------
 //			atomic 		
 //			attribute
 //			bit from
 //			IQ.
 //--------------------------------------------------------------------
 //	PX2 		C1		C2		
 //--------------------------------------------------------------------
 //			atomic
 //			attribute
 //			of C1 instr.
 //			in case of
 //			a C1 stall.
 //--------------------------------------------------------------------
 //			PX1		PX2 		
 //--------------------------------------------------------------------
 //					choose
 //					IQ 
 //					instr.
 //					if stall
 //					is 0.
 ////////////////////////////////////////////////////////////////////////////////////////////////

 assign	atm_instr_px2 = ( iq_arbctl_atm_px2 &  iqsel_px2 )  // atomic instruction from IQ
	 | ( atm_instr_c1 & arbctl_stall_c2 ) ; // C1 instruction is an atomic that is stalled.

 dff_s    #(1)    ff_atm_instr_c1     (.q(atm_instr_c1), .clk(rclk),
                                      .din(atm_instr_px2), .se(se), .si(), .so());

 // mux3 selects between the BUffer/snp instructions and the instruction from the IQ,
 // IQ instructions have priority only if the instruction currently in C1 is atomic with
 // the instruction in PX2.

 //assign	mux3_bufsel_px2 = ( mbf_valid_px2_1 | fbf_valid_px2 | snp_valid_px2 ) & 
			    //~atm_instr_c1;

 assign	mux4_c1sel_px2 = arbctl_stall_c2 & dbb_rst_l;



 //mux selects


 assign sel_tecc_addr_px2 = inc_tag_ecc_cnt_c3 ;
 assign sel_decc_addr_px2 = ~inc_tag_ecc_cnt_c3 & data_ecc_active_c4 ;
 assign sel_diag_addr_px2 = ~inc_tag_ecc_cnt_c3 & ~data_ecc_active_c4;

 assign inc_tag_ecc_cnt_c3_n = ~inc_tag_ecc_cnt_c3 ;

 //////////////////////////////////////////////////////////////////////
 // Scrub index enable :
 // When a tecc fill is active in C2.
 //////////////////////////////////////////////////////////////////////

 dff_s   #(1)  ff_tecc_c2   (.din(arbdp_tecc_c1), .clk(rclk),
                        .q(tecc_c2), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_tecc_c2   (.din(arbdp_tecc_c1), .clk(rclk),
                        .q(arbctl_tecc_c2), .se(se), .si(), .so());
 

 dff_s   #(1)  ff_data_ecc_active_c4   (.din(data_ecc_active_c3), .clk(rclk),
                        .q(data_ecc_active_c4), .se(se), .si(), .so());

 assign data_ecc_idx_en = ( arbctl_fill_vld_c2 & tecc_c2 ) ;
 assign data_ecc_idx_reset =   ( ~dbb_rst_l | ~dbginit_l );



 // The following mux select is used in selecting the C2 address(stalled)
 // over the c1 address.
 // The set to be scrubbed for data ecc is part of the C1 address and not 
 // part of the stalled C2 address.
 assign	sel_c2_stall_idx_c1 = ( arbctl_stall_unqual_c2 & ~data_ecc_active_c4 );

 //////////////////////////////////////////////////////////
 // The 3 addresses making up the stalled vuad address
 // are
 // - C1 instruction address
 // - DECC scrub address
 // - Bist address.
 //////////////////////////////////////////////////////////

 //assign	sel_vuad_bist_px2 = ( bist_vuad_rd_en_px2 |
 //		bist_vuad_wr_en_px2 )  ;


 dff_s   #(1)  ff_bist_vuad_rd_en_px1   (.din(bist_vuad_rd_en_px1), .clk(rclk),
                        .q(bist_vuad_rd_en_px2), .se(se), .si(), .so());

 assign	 sel_vuad_bist_px2 = bist_vuad_rd_en_px2;

 assign	sel_decc_or_bist_idx = ( data_ecc_active_c4 |
				bist_vuad_rd_en_px2  ) ;

 // The following signal is a copy of sel_decc_or_bist_idx
 // and is used to disable bypassing of vuad data from the 
 // other stages of the pipe so as to read the array output
 
 assign	vuadctl_no_bypass_px2 = ( data_ecc_active_c4 |
                                bist_vuad_rd_en_px2  ) ;


 assign arbctl_vuad_idx2_sel_px2_n = ~( arbctl_stall_c2 | 
					bist_vuad_rd_en_px2 |
	                               data_ecc_active_c4)  ;

 //assign	sel_stall_vuad_idx = ( arbctl_stall_c2 |
				//bist_vuad_rd_en_px2  |
				//data_ecc_active_c4 ) ;

 
 ////////////////////////////////////////////////////////////////////////////////////////////
 // VUAD bist related signals.
 ////////////////////////////////////////////////////////////////////////////////////////////


 dff_s   #(1)  ff_bist_enable_c1   (.din(bist_vuad_rd_en_px2), .clk(rclk),
                        .q(bist_enable_c1), .se(se), .si(), .so());

 dff_s   #(1)  ff_bist_enable_c2   (.din(bist_enable_c1), .clk(rclk),
                        .q(bist_enable_c2), .se(se), .si(), .so());


 dff_s   #(1)  ff_bist_acc_vd_px2   (.din(bist_acc_vd_px1), .clk(rclk),
                        .q(bist_acc_vd_px2), .se(se), .si(), .so());

 dff_s   #(1)  ff_bist_acc_vd_c1   (.din(bist_acc_vd_px2), .clk(rclk),
                        .q(bist_acc_vd_c1), .se(se), .si(), .so());

 dff_s   #(1)  ff_bist_acc_vd_c2   (.din(bist_acc_vd_c1), .clk(rclk),
                        .q(bist_acc_vd_c2), .se(se), .si(), .so());



 assign	arbctl_acc_vd_c2 = ( arbaddr_addr22_c2 & inst_l2vuad_vld_c2 ) |
			   ( bist_acc_vd_c2 & bist_enable_c2 ) ;

 assign	arbctl_acc_ua_c2 = ( ~arbaddr_addr22_c2 & inst_l2vuad_vld_c2 ) |
			   ( ~bist_acc_vd_c2 & bist_enable_c2 ) ;


 

 ////////////////////////////////////////////////////////////////////////////////////////////
 // Mux selects for arbdata muxes
 ////////////////////////////////////////////////////////////////////////////////////////////

 assign	bist_or_diag_acc_c1 =  ( inst_l2data_vld_c2 | mbist_arb_l2d_en );
 

 ////////////////////////////////////////////////////////////////////////
 // the following signal indicates that the tag array is accessed.
 // It is asserted aggressively when
 // // mbf,fbf,snp or iq instructions are valid OR
 // // when there is a stalled instruction in C1 OR
 // // when there is a tecc, decc or diagnostic tag access OR
 // // when a BIST access is performed.
 ////////////////////////////////////////////////////////////////////////

 assign	arbctl_tag_acc_px2 = ( arbctl_stall_c2| 
				tecc_tag_acc_en_px2 | 
				inst_l2tag_vld_c2 | 
				decc_tag_acc_en_px2 | // may not be reqd??????
				 mbf_valid_px2_1 | fbf_valid_px2_1 | snp_valid_px2_1  |
				iq_arbctl_vld_px2 ) ;

 ////////////////////////////////////////////////////////////////////////
 // arbctl_normal_tagacc_c2 is used by tagdp to either select the dec
 // way or lru_way 
 // Dec way is used by the following instructions 
 // tecc, tag diagnostic access, data ecc, fill
 ////////////////////////////////////////////////////////////////////////

 dff_s   #(1)  ff_arbctl_tag_acc_c1   (.din(arbctl_tag_acc_px2), .clk(rclk),
                        .q(arbctl_tag_acc_c1), .se(se), .si(), .so());

 assign	sp_tag_access_px2 = tecc_tag_acc_en_px2 | // tecc tag access
				inst_l2tag_vld_c2 | // diagnostic tag access
				decc_tag_acc_en_px2  ; // decc tag access.

 dff_s   #(1)  ff_sp_tag_access_c1   (.din(sp_tag_access_px2), .clk(rclk),
                        .q(sp_tag_access_c1), .se(se), .si(), .so());

 assign normal_tagacc_c1= arbctl_tag_acc_c1 
				& ~sp_tag_access_c1 ;

 dff_s   #(1)  ff_normal_tagacc_c2   (.din(normal_tagacc_c1), .clk(rclk),
                        .q(normal_tagacc_c2), .se(se), .si(), .so());

 assign	arbctl_normal_tagacc_c2 = normal_tagacc_c2 & ~arbctl_fill_vld_c2 ;


 ////////////////////////////////////////////////////////////////////////
 // vuad rd access en
 // Similar to tag access expression minus
 // tag diagnostic access.
 ////////////////////////////////////////////////////////////////////////

 assign	arbctl_vuad_acc_px2 = arbctl_stall_c2 | decc_tag_acc_en_px2 |
				tecc_tag_acc_en_px2 |
				mbf_valid_px2_1 | fbf_valid_px2_1 | snp_valid_px2_1 |
				iq_arbctl_vld_px2 |
				bist_vuad_rd_en_px2 ;

 ////////////////////////////////////////////////////////////////////////
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

 assign	arbctl_mb_camen_px2 = iq_arbctl_vld_px2 |  snp_valid_px2_1 |
				arbctl_stall_c2 ;
				

 // Miss buffer count is a C4 flop.
 // Instructions in C1,C2,C3 are inflight ops that can be inserted.
 // //The instruction in PX2 is picked if atleast 4 entries are available in the MBF. ( mbcount <= 12) 
 // //If PX2 is a block store atleast 11 entries should be availabe in the MBF. ( mb_count <= 5 ) 

 dff_s     #(1)    ff_mbfull_px2     (.q(mbfull_px2), .clk(rclk),
                                  .din(mbctl_arbctl_cnt12_px2_prev), .se(se), .si(), .so());


 assign	gate_off_buf_req_px2 = ( iq_arbctl_vld_px2 & atm_instr_c1 ) | // iq atomic instr.
                            gate_off_prim_req_c1 | // csr instruction in C1.
                            oqctl_arbctl_full_px2 | // OQ full
                            arbctl_stall_c2 ; // stall


 assign	mbsel_px2 = mbf_valid_px2_1  & ~snp_valid_px2_1 & dbb_rst_l & 
		~gate_off_buf_req_px2;

 assign	fbsel_px2 = fbf_valid_px2_1 & ~mbf_valid_px2_1  & ~snp_valid_px2_1 & dbb_rst_l &
		~gate_off_buf_req_px2 ;


 assign	snpsel_px2 = snp_valid_px2_1 &  dbb_rst_l & 
		~gate_off_buf_req_px2 ;

// ////// most critical signal in this block 
 assign	iqsel_px2 =  iq_arbctl_vld_px2 & dbb_rst_l & ( 
                               	( ~(	mbf_valid_px2_1 | 
					fbf_valid_px2_1 | 
					snp_valid_px2_1 ) // no buffer instructions.
                                  	& ~mbfull_px2 &  // mbf is not full
                                  	~gate_off_prim_req_c1 & 
				  	~gate_off_prim_req_state & // csr store in the pipe
	                          	~oqctl_arbctl_full_px2 )  // oqfull in PX2
	                	| atm_instr_c1 ) &  // if c1 is atomic IQ has lower priority than only stall_c1.
	                   ~arbctl_stall_c2 ; // stall

assign	arbctl_iqsel_px2 = iqsel_px2 ;

 dff_s     #(1)    ff_mbsel_c1     (.q(mbsel_c1), .clk(rclk),
                                  .din(mbsel_px2), .se(se), .si(), .so());

 assign	arbctl_mbctl_mbsel_c1 = mbsel_c1 ;


 dff_s     #(1)    ff_fbsel_c1     (.q(fbsel_c1), .clk(rclk),
                                  .din(fbsel_px2), .se(se), .si(), .so());

assign	arbctl_fbctl_fbsel_c1 = fbsel_c1 ;

 dff_s     #(1)    ff_snpsel_c1     (.q(snpsel_c1), .clk(rclk),
                                   .din(snpsel_px2), .se(se), .si(), .so());
 dff_s     #(1)    ff_snpsel_c2     (.q(snpsel_c2), .clk(rclk),
                                   .din(snpsel_c1), .se(se), .si(), .so());
 dff_s     #(1)    ff_snpsel_c3     (.q(snpsel_c3), .clk(rclk),
                                   .din(snpsel_c2), .se(se), .si(), .so());


 assign	arbctl_snpsel_c1 = snpsel_c1 ;

////////////////////////////////////////////////////////////////
// mux selects for dir cam address
// An eviction is turned off in C3 if a 
// parity error is detected during the eviction operation.
////////////////////////////////////////////////////////////////

 assign	arbctl_evict_vld_c2 = dec_evict_c2 & arbctl_inst_vld_c2_6 ;

 // eviction address vs normal addresses
 dff_s   #(1)  ff_arbctl_evict_c3  (.din(arbctl_evict_vld_c2), .clk(rclk),
                 .q(arbctl_evict_unqual_c3), .se(se), .si(), .so());

 assign	arbctl_evict_c3 = arbctl_evict_unqual_c3 & ~tagdp_arbctl_par_err_c3 ;

 dff_s   #(1)  ff_arbctl_evict_c4  (.din(arbctl_evict_c3), .clk(rclk),
                 .q(arbctl_evict_c4), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_evict_c5  (.din(arbctl_evict_c4), .clk(rclk),
                 .q(arbctl_evict_c5), .se(se), .si(), .so());



 assign	arbctl_imiss_vld_c2 = decdp_imiss_inst_c2 & arbctl_inst_vld_c2_6 ;
 

 dff_s   #(1)  ff_imiss_inst_c3  (.din(decdp_imiss_inst_c2), .clk(rclk),
                 .q(imiss_inst_c3), .se(se), .si(), .so());

 assign	imiss_hit_c3 = imiss_inst_c3 & tagctl_hit_l2orfb_c3 ;

 // c4 vs c3 addresses.
 dff_s   #(1)  ff_arbctl_imiss_hit_c4  (.din(imiss_hit_c3), .clk(rclk),
                 .q(arbctl_imiss_hit_c4), .se(se), .si(), .so());


////////////////////////////////////////////////////////////////
// mux selects for imiss address for err 
// reporting.
// Used to determine if the C7 or C8 address should be chosen for error logging.
////////////////////////////////////////////////////////////////
 
 dff_s   #(1)  ff_arbctl_imiss_hit_c5  (.din(arbctl_imiss_hit_c4), .clk(rclk),
                 .q(arbctl_imiss_hit_c5), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_imiss_hit_c6  (.din(arbctl_imiss_hit_c5), .clk(rclk),
                 .q(arbctl_imiss_hit_c6), .se(se), .si(), .so());
 
 dff_s   #(1)  ff_arbctl_imiss_hit_c7  (.din(arbctl_imiss_hit_c6), .clk(rclk),
                 .q(arbctl_imiss_hit_c7), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_imiss_hit_c8  (.din(arbctl_imiss_hit_c7), .clk(rclk),
                 .q(arbctl_imiss_hit_c8), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_imiss_hit_c9  (.din(arbctl_imiss_hit_c8), .clk(rclk),
                 .q(arbctl_imiss_hit_c9), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_imiss_hit_c10  (.din(arbctl_imiss_hit_c9), .clk(rclk),
                 .q(arbctl_imiss_hit_c10), .se(se), .si(), .so());

 ////////////////////////////////////////////////////////////////////
 // Decode based on address.
 ////////////////////////////////////////////////////////////////////

 // Fix for bug#3789
 // an interrupt issued with a diagnostic address is not 
 // marked as a diagnostic instruction.

 assign arbctl_inst_diag_c1 = arbctl_inst_vld_c1_1 &
		~( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `INT_RQ ) &
                        ( arbdp_ioaddr_c1_39to37[39:37] == 3'h5 );  // A0-BF

 dff_s   #(1)  ff_arbctl_inst_diag_c2  (.din(arbctl_inst_diag_c1), .clk(rclk),
                 .q(arbctl_inst_diag_c2), .se(se), .si(), .so());

 //assign arbctl_int_or_diag_acc_c1 = ( arbctl_inst_diag_c1 | 
			//decdp_inst_int_or_inval_c1 ) ; // all instructions that do not insert in mbf

  //A8 and above.
 assign arbctl_inst_csr_c1 = arbctl_inst_diag_c1 &
                                arbdp_ioaddr_c1_35to33[35] ;

 dff_s   #(1)  ff_arbctl_inst_csr_c1  (.din(arbctl_inst_csr_c1), .clk(rclk),
                 .q(arbctl_inst_csr_c2), .se(se), .si(), .so());

  // A0, A1, A2, A3
 assign arbctl_inst_l2data_c1 = arbctl_inst_diag_c1 & 
			~arbdp_ioaddr_c1_35to33[35] & ~arbdp_ioaddr_c1_35to33[34] ;

 dff_s   #(1)  ff_arbctl_inst_l2data_c2  (.din(arbctl_inst_l2data_c1), .clk(rclk),
                 .q(arbctl_inst_l2data_c2), .se(se), .si(), .so());

 assign	inst_l2data_vld_c2 = arbctl_inst_l2data_c2 & arbctl_inst_vld_c2_6;

 dff_s   #(1)  ff_inst_l2data_vld_c3  (.din(inst_l2data_vld_c2), .clk(rclk),
                 .q(inst_l2data_vld_c3), .se(se), .si(), .so());
 dff_s   #(1)  ff_inst_l2data_vld_c4  (.din(inst_l2data_vld_c3), .clk(rclk),
                 .q(inst_l2data_vld_c4), .se(se), .si(), .so());
 dff_s   #(1)  ff_inst_l2data_vld_c5  (.din(inst_l2data_vld_c4), .clk(rclk),
                 .q(inst_l2data_vld_c5), .se(se), .si(), .so());
 dff_s   #(1)  ff_inst_l2data_vld_c6  (.din(inst_l2data_vld_c5), .clk(rclk),
                 .q(inst_l2data_vld_c6), .se(se), .si(), .so());

 assign	arbctl_inst_l2data_vld_c6 = inst_l2data_vld_c6 ;

 //////////////////////////////////////////
 // csr store signal is used to
 // enqueue or dequeue an instruction from
 // the miss buffer.
 //////////////////////////////////////////


 assign	arbctl_csr_st_c2 = arbctl_inst_csr_c2 & decdp_st_inst_c2_1 ;



 assign	arbctl_csr_wr_en_c2 = arbctl_csr_st_c2 & 	
			arbdp_inst_mb_c2  &
			arbctl_inst_vld_c2_6 ;
 
 dff_s   #(1)  ff_arbctl_csr_wr_en_c3  (.din(arbctl_csr_wr_en_c2), .clk(rclk),
                 .q(arbctl_csr_wr_en_c3), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_csr_wr_en_c3_1  (.din(arbctl_csr_wr_en_c2), .clk(rclk),
                 .q(arbctl_csr_wr_en_c3_1), .se(se), .si(), .so());


 dff_s   #(1)  ff_arbctl_csr_wr_en_c4  (.din(arbctl_csr_wr_en_c3_1), .clk(rclk),
                 .q(arbctl_csr_wr_en_c4), .se(se), .si(), .so());
 dff_s   #(1)  ff_arbctl_csr_wr_en_c5  (.din(arbctl_csr_wr_en_c4), .clk(rclk),
                 .q(arbctl_csr_wr_en_c5), .se(se), .si(), .so());
 dff_s   #(1)  ff_arbctl_csr_wr_en_c6  (.din(arbctl_csr_wr_en_c5), .clk(rclk),
                 .q(arbctl_csr_wr_en_c6), .se(se), .si(), .so());
 dff_s   #(1)  ff_arbctl_csr_wr_en_c7  (.din(arbctl_csr_wr_en_c6), .clk(rclk),
                 .q(arbctl_csr_wr_en_c7), .se(se), .si(), .so());
 dff_s   #(1)  ff_arbctl_csr_wr_en_c8  (.din(arbctl_csr_wr_en_c7), .clk(rclk),
                 .q(arbctl_csr_wr_en_c8), .se(se), .si(), .so());


  assign arbctl_csr_rd_en_c2 = arbctl_inst_csr_c2 & decdp_ld_inst_c2 &
				arbctl_inst_vld_c2_6;

 dff_s   #(1)  ff_arbctl_csr_rd_en_c3  (.din(arbctl_csr_rd_en_c2), .clk(rclk),
                 .q(arbctl_csr_rd_en_c3), .se(se), .si(), .so());
 dff_s   #(1)  ff_arbctl_csr_rd_en_c4  (.din(arbctl_csr_rd_en_c3), .clk(rclk),
                 .q(arbctl_csr_rd_en_c4), .se(se), .si(), .so());
 dff_s   #(1)  ff_arbctl_csr_rd_en_c5  (.din(arbctl_csr_rd_en_c4), .clk(rclk),
                 .q(arbctl_csr_rd_en_c5), .se(se), .si(), .so());
 dff_s   #(1)  ff_arbctl_csr_rd_en_c6  (.din(arbctl_csr_rd_en_c5), .clk(rclk),
                 .q(arbctl_csr_rd_en_c6), .se(se), .si(), .so());
 dff_s   #(1)  ff_arbctl_csr_rd_en_c7  (.din(arbctl_csr_rd_en_c6), .clk(rclk),
                 .q(arbctl_csr_rd_en_c7), .se(se), .si(), .so());

 ////////////////////////
 // data diagnostic store for R/W calculation
 ////////////////////////
 assign	arbctl_data_diag_st_c2 = inst_l2data_vld_c2 & decdp_st_inst_c2_1 ;


  // A4 or A5
 assign arbctl_inst_l2tag_c1 = arbctl_inst_diag_c1 & 
			~arbdp_ioaddr_c1_35to33[35] & arbdp_ioaddr_c1_35to33[34] & 	
			~arbdp_ioaddr_c1_35to33[33] ;


 dff_s   #(1)  ff_arbctl_inst_l2tag_c2  (.din(arbctl_inst_l2tag_c1), .clk(rclk),
                 .q(arbctl_inst_l2tag_c2), .se(se), .si(), .so());
	
 assign	inst_l2tag_vld_c2 = arbctl_inst_l2tag_c2 & arbctl_inst_vld_c2_6 ;

 dff_s   #(1)  ff_arbctl_inst_l2tag_c2_1  (.din(arbctl_inst_l2tag_c1), .clk(rclk),
                 .q(arbctl_inst_l2tag_c2_1), .se(se), .si(), .so());
	
 assign	inst_l2tag_vld_c2_1 = arbctl_inst_l2tag_c2_1 & arbctl_inst_vld_c2_6 ;

 dff_s   #(1)  ff_inst_l2tag_vld_c3  (.din(inst_l2tag_vld_c2), .clk(rclk),
                 .q(inst_l2tag_vld_c3), .se(se), .si(), .so());

 dff_s   #(1)  ff_inst_l2tag_vld_c4  (.din(inst_l2tag_vld_c3), .clk(rclk),
                 .q(inst_l2tag_vld_c4), .se(se), .si(), .so());

 assign	arbctl_l2tag_vld_c4 = inst_l2tag_vld_c4 ; // to tagdp.

 dff_s   #(1)  ff_inst_l2tag_vld_c5  (.din(inst_l2tag_vld_c4), .clk(rclk),
                 .q(inst_l2tag_vld_c5), .se(se), .si(), .so());

 dff_s   #(1)  ff_inst_l2tag_vld_c6  (.din(inst_l2tag_vld_c5), .clk(rclk),
                 .q(inst_l2tag_vld_c6), .se(se), .si(), .so());

	
 assign	arbctl_inst_l2tag_vld_c6 = inst_l2tag_vld_c6 ;
  


  // A6 or A7
 assign arbctl_inst_l2vuad_c1 = arbctl_inst_diag_c1 & 
			~arbdp_ioaddr_c1_35to33[35] & arbdp_ioaddr_c1_35to33[34] & 	
			arbdp_ioaddr_c1_35to33[33] ;

  dff_s   #(1)  ff_arbctl_inst_l2vuad_c2  (.din(arbctl_inst_l2vuad_c1), .clk(rclk),
                 .q(arbctl_inst_l2vuad_c2), .se(se), .si(), .so());

  assign inst_l2vuad_vld_c2 = arbctl_inst_l2vuad_c2 & arbctl_inst_vld_c2_7 ;

  dff_s   #(1)  ff_inst_l2vuad_vld_c3  (.din(inst_l2vuad_vld_c2), .clk(rclk),
                 .q(inst_l2vuad_vld_c3), .se(se), .si(), .so());

  assign	arbctl_inst_l2vuad_vld_c3 = inst_l2vuad_vld_c3 ;

  dff_s   #(1)  ff_inst_l2vuad_vld_c4  (.din(inst_l2vuad_vld_c3), .clk(rclk),
                 .q(inst_l2vuad_vld_c4), .se(se), .si(), .so());

  dff_s   #(1)  ff_inst_l2vuad_vld_c5  (.din(inst_l2vuad_vld_c4), .clk(rclk),
                 .q(inst_l2vuad_vld_c5), .se(se), .si(), .so());

  dff_s   #(1)  ff_inst_l2vuad_vld_c6  (.din(inst_l2vuad_vld_c5), .clk(rclk),
                 .q(inst_l2vuad_vld_c6), .se(se), .si(), .so());


  assign	arbctl_inst_l2vuad_vld_c6 = inst_l2vuad_vld_c6 ;
  
  assign  arbctl_diag_complete_c3 = inst_l2vuad_vld_c3 |
				inst_l2tag_vld_c3 |
				inst_l2data_vld_c3;




////////////////////////////////////////////////////////////
// refer to scrub pipeline
// The following signal tagctl_decc_data_sel_c8 is used to
// select between store data and decc scrub data.
/////////////////////////////////////////////////////////////
 dff_s   #(1)  ff_decc_data_sel_c9  (.din(tagctl_decc_data_sel_c8), .clk(rclk),
             .q(arbctl_decc_data_sel_c9), .se(se), .si(), .so());




 ////////////////////////////////////////////////////////////////////////////
 // CAs compare results and control signal
 // to mbctl.
 // arbctl_mbctl_ctrue_c9 is the compare result.
 // arbctl_mbctl_cas1_hit_c8 is the qualifier.
 ////////////////////////////////////////////////////////////////////////////

 assign	lower_cas_c8 = size_field_c8[1] & ~size_field_c8[0] & arbaddrdp_addr2_c8 ;

 dff_s   #(1)  ff_lower_cas_c9  (.din(lower_cas_c8), .clk(rclk),
             .q(lower_cas_c9), .se(se), .si(), .so());

 assign	upper_cas_c8 = size_field_c8[1] & ~size_field_c8[0] & ~arbaddrdp_addr2_c8 ;

 dff_s   #(1)  ff_upper_cas_c9  (.din(upper_cas_c8), .clk(rclk),
             .q(upper_cas_c9), .se(se), .si(), .so());


 dff_s   #(1)  ff_word_lower_cmp_c9  (.din(word_lower_cmp_c8), .clk(rclk),
             .q(word_lower_cmp_c9), .se(se), .si(), .so());

 dff_s   #(1)  ff_word_upper_cmp_c9  (.din(word_upper_cmp_c8), .clk(rclk),
             .q(word_upper_cmp_c9), .se(se), .si(), .so());


 assign	cmp_lower_c9 =  word_lower_cmp_c9 & lower_cas_c9;

 assign	cmp_upper_c9 = word_upper_cmp_c9 & upper_cas_c9;

 assign	cmp_dword_c9 =  word_lower_cmp_c9 & word_upper_cmp_c9 ;

 assign	arbctl_mbctl_ctrue_c9 =  ( cmp_dword_c9 | cmp_lower_c9 | cmp_upper_c9 )  ;

 assign	arbctl_mbctl_cas1_hit_c8 =  decdp_cas1_inst_c8 & hit_l2orfb_c8 ;
 

 ////////////////////////////////////////////////////////////////////////////////////
 // tecc count is maintained
 // here. The tag ecc pipeline is as follows.
 //
 //--------------------------------------------------------
 //	C1(tecc inst	C2(setup tag read 
 //	   from mb or 	   of corrupted
 //	   snpiQ)	   idx 
 //			
 //			   store affected
 //			   idx in arbaddr
 //				
 //			   start
 //			   counting.
 //--------------------------------------------------------
 //
 //
 //-------------------------------------------------------------------------------
 // count<2:0>  1(px2)	2(c1)	3(c2)	4(c3)	5(c4)	6(px2)	7(c1)	8
 //-------------------------------------------------------------------------------
 // action 	setup  	tagrd   setup	mux 	corre	setup	tagwr	do nothing
 //		idx	   	muxsel	tag 	tag 	wr	
 //							idx
 //-------------------------------------------------------------------------------
 // STALL lasts for 128 cycles.
 // When the counter is 1 or 6, the tag_acc_px2 needs to be enabled 
 // for a tagecc operation. If an instruction is present in C1, the 
 // tag will be enabled for the entire duration of the tag ecc operation.
 ////////////////////////////////////////////////////////////////////////////////////

 


  dff_s   #(1)  ff_tecc_inst_c2  (.din(arbdp_tecc_inst_c1), .clk(rclk), 
                        .q(tecc_inst_c2), .se(se), .si(), .so());
  
  assign inc_tag_ecc_cnt_c2 = ( tecc_inst_c2 & arbctl_inst_vld_c2_7 ) |
					(|( tecc_st_cnt )) ;



  dff_s   #(1)  ff_inc_tag_ecc_cnt_c3  (.din(inc_tag_ecc_cnt_c2), .clk(rclk), 
                        .q(inc_tag_ecc_cnt_c3), .se(se), .si(), .so());

  assign	tecc_st_cnt_plus1 = tecc_st_cnt + 7'b1 ;

  assign	tecc_st_cnt_reset = ~dbb_rst_l |
				    ~dbginit_l | 
				    (tecc_st_cnt == 7'b1011_111 );

  dffre_s   #(7)  ff_tag_ecc_fsm_count  (.din(tecc_st_cnt_plus1[6:0]),
                 .en(inc_tag_ecc_cnt_c2), .clk(rclk), .rst(tecc_st_cnt_reset),
                 .q(tecc_st_cnt[6:0]), .se(se), .si(), .so());
  
  assign	arbctl_tecc_way_c2 = tecc_st_cnt[6:3] ; // tecc way.
  assign	scrub_fsm_count_eq_5_px1  = (tecc_st_cnt[2:0] == 3'd5) ;

  dff_s  #(1)  ff_scrub_fsm_count_eq_6_px2  (.din(scrub_fsm_count_eq_5_px1),
                  .clk(rclk), 
                 .q(scrub_fsm_count_eq_6_px2), .se(se), .si(), .so());

  assign	scrub_fsm_count_eq_0_px1  = (tecc_st_cnt[2:0] == 3'd0) &
					inc_tag_ecc_cnt_c2 ;

  dff_s  #(1)  ff_scrub_fsm_count_eq_1_px2  (.din(scrub_fsm_count_eq_0_px1),
                  .clk(rclk), 
                 .q(scrub_fsm_count_eq_1_px2), .se(se), .si(), .so());



  assign tecc_tag_acc_en_px1 =  (( tecc_st_cnt[2:0] == 3'd0 )  & inc_tag_ecc_cnt_c2 ) |
				( tecc_st_cnt[2:0] == 3'd5 );

  dff_s   #(1)  ff_tecc_tag_acc_en_px2  (.din(tecc_tag_acc_en_px1), .clk(rclk), 
                        .q(tecc_tag_acc_en_px2), .se(se), .si(), .so());

  assign	arbctl_tagdp_tecc_c1 = ( tecc_st_cnt[2:0] == 3'd2 );


  dff_s   #(1)  ff_arbctl_tagdp_tecc_c2  (.din(arbctl_tagdp_tecc_c1), .clk(rclk), 
                        .q(arbctl_tagdp_tecc_c2), .se(se), .si(), .so());




 ///////////////////////////////////////////////////////////////////////
 // tag is written if
 // - a Fill instruction is allowed to issue in PX2 and is not superceded 
 // by a stall condition or  diag/tecc/decc active.
 // - A diagnostic tag write in C2
 // _ Tecc tag write state.
 // - Fill stalled in C1 but not superceded by diag/tecc/decc  active.
 ////////////////////////////////////////////////////////////////////////



 // Used to select between the way and wrdata of a C1 instruction vs
 // a tecc or diagnostic instruction.
 assign	diag_or_tecc_write_px2 = (decdp_st_inst_c2_1 & inst_l2tag_vld_c2_1 ) |
				scrub_fsm_count_eq_6_px2 ;

 assign	diag_or_scr_way_sel = inst_l2tag_vld_c2_1 |  scrub_fsm_count_eq_6_px2 ;

 assign	diag_or_tecc_acc_px2 = (inst_l2tag_vld_c2_1 ) |
				scrub_fsm_count_eq_6_px2 |
				scrub_fsm_count_eq_1_px2 |
				data_ecc_active_c4 ;

 assign sel_diag_tag_addr_px2 = diag_or_tecc_acc_px2 ;
	                        

 assign	sel_lkup_stalled_tag_px2 = ( arbctl_stall_c2 | 
		                     diag_or_tecc_acc_px2 ) ;
	                        
			
 dff_s   #(1)  ff_diag_or_tecc_acc_c1  (.din(diag_or_tecc_acc_px2), .clk(rclk), 
                        .q(diag_or_tecc_acc_c1), .se(se), .si(), .so());

 assign	sel_fill_wr_px2  = fbsel_px2 &  ~diag_or_tecc_acc_px2  & ~l2_bypass_mode_on_d1;

 // A fill will write into the tag in C1 instead of in PX2 if
 // the fill is stalled in C1 due to a decc, tecc or tag diagnostic access.
 // This means that one cycle after the tecc, decc or diagnostic operation 
 // finishes accessing the tag, the fill in C1 will access the tag.

 assign sel_delayed_fill_wr_c1 = arbdp_inst_fb_c1_qual &  diag_or_tecc_acc_c1  &
				 ~diag_or_tecc_acc_px2  & ~l2_bypass_mode_on_d1 ;

 assign	arbctl_tag_wr_px2 = sel_fill_wr_px2 |
			diag_or_tecc_write_px2 | // diagnostic or tecc write.
			sel_delayed_fill_wr_c1 ;
										   // cyc after.

 // added POST_4.0 for bug #3897. If mbist is ON when a diagnostic 
 // write is issued to turn it off, the Mbist write should take precedence over
 // the diagnostic access.

 assign	arbctl_tag_rd_px2 = ~arbctl_tag_wr_px2 
				& arbctl_tag_acc_px2    
				& ~mbist_arbctl_l2t_write ;

 assign	sel_way_px2 = ~sel_delayed_fill_wr_c1 & ~diag_or_tecc_acc_px2 ;
				

 //////////////////////////////////////////////////////////
 // way for tag writes is determined here.
 //////////////////////////////////////////////////////////

  mux2ds   #(4)   mux1_tag_way_px(.dout ( tag_diag_or_tecc_way_c2[3:0] ) , // diag or tag write way
                        .in0(tecc_st_cnt[6:3]),			// tecc way counter
                        .in1(arbdp_diag_wr_way_c2[3:0] ),	// diagnostic way
                        .sel0(inc_tag_ecc_cnt_c3),		// tecc under process
                        .sel1(~inc_tag_ecc_cnt_c3));		// default

  mux2ds   #(4)   mux2_tag_way_px(.dout (stalled_tag[3:0]) , // stalled or diag or tag write way
                        .in0(tag_diag_or_tecc_way_c2[3:0]),	// diag or tag tecc way counter
                        .in1(arbdp_inst_way_c1[3:0] ),		// stalled instr way
                        .sel0(diag_or_scr_way_sel),	// diag or tecc under process
                        .sel1(~diag_or_scr_way_sel));	// default

  mux2ds   #(4)   mux3_tag_way_px(.dout (enc_tag_way_px2[3:0]) , // stalled or diag or tag write way
                        .in0(stalled_tag[3:0]),	// diag or tag tecc way counter or stalled way
                        .in1(fbctl_arbdp_way_px2[3:0] ),		// fbtag 
                        .sel0(~sel_way_px2),	
                        .sel1(sel_way_px2));	

////////////////////////////////////////////////////////////////////////////////
// Decode the tag way here
////////////////////////////////////////////////////////////////////////////////

assign  dec_lo_way_sel_c1[0] = ( enc_tag_way_px2[1:0]==2'd0 ) ;
assign  dec_lo_way_sel_c1[1] = ( enc_tag_way_px2[1:0]==2'd1 ) ;
assign  dec_lo_way_sel_c1[2] = ( enc_tag_way_px2[1:0]==2'd2 ) ;
assign  dec_lo_way_sel_c1[3] = ( enc_tag_way_px2[1:0]==2'd3 ) ;

assign  dec_hi_way_sel_c1[0] = ( enc_tag_way_px2[3:2]==2'd0 ) ;
assign  dec_hi_way_sel_c1[1] = ( enc_tag_way_px2[3:2]==2'd1 ) ;
assign  dec_hi_way_sel_c1[2] = ( enc_tag_way_px2[3:2]==2'd2 ) ;


assign  arbctl_tag_way_px2[0] = dec_hi_way_sel_c1[0] & dec_lo_way_sel_c1[0] ; // 0000
assign  arbctl_tag_way_px2[1] = dec_hi_way_sel_c1[0] & dec_lo_way_sel_c1[1] ; // 0001
assign  arbctl_tag_way_px2[2] = dec_hi_way_sel_c1[0] & dec_lo_way_sel_c1[2] ; // 0010
assign  arbctl_tag_way_px2[3] = dec_hi_way_sel_c1[0] & dec_lo_way_sel_c1[3] ; // 0011

assign  arbctl_tag_way_px2[4] = dec_hi_way_sel_c1[1] & dec_lo_way_sel_c1[0] ; 
assign  arbctl_tag_way_px2[5] = dec_hi_way_sel_c1[1] & dec_lo_way_sel_c1[1] ; 
assign  arbctl_tag_way_px2[6] = dec_hi_way_sel_c1[1] & dec_lo_way_sel_c1[2] ; 
assign  arbctl_tag_way_px2[7] = dec_hi_way_sel_c1[1] & dec_lo_way_sel_c1[3] ; 

assign  arbctl_tag_way_px2[8] = dec_hi_way_sel_c1[2] & dec_lo_way_sel_c1[0] ; // 1000
assign  arbctl_tag_way_px2[9] = dec_hi_way_sel_c1[2] & dec_lo_way_sel_c1[1] ; // 1001
assign  arbctl_tag_way_px2[10] = dec_hi_way_sel_c1[2] & dec_lo_way_sel_c1[2] ; // 1010
assign  arbctl_tag_way_px2[11] = dec_hi_way_sel_c1[2] & dec_lo_way_sel_c1[3] ; // 1011


////////////////////////////////////////////////////////////////////////////////
// dword mask generation logic for pst data merging.
////////////////////////////////////////////////////////////////////////////////

 assign  inst_size_c7[0] = ( (~arbdp_inst_size_c7[0] & ~arbdp_inst_size_c7[1] & ~sp_pst_inst_c7  ) |
                                ( arbdp_inst_size_c7[0] & sp_pst_inst_c7 ) ) ;
 assign  inst_size_c7[1] = ( (arbdp_inst_size_c7[0] & ~arbdp_inst_size_c7[1] & ~sp_pst_inst_c7  ) |
                                ( arbdp_inst_size_c7[1] & sp_pst_inst_c7 ) ) ;
 assign  inst_size_c7[2] =   (~arbdp_inst_size_c7[0] & arbdp_inst_size_c7[1] & ~sp_pst_inst_c7  ) |
                        	( arbdp_inst_size_c7[2] & sp_pst_inst_c7 )  ;


 assign	 end_addr_2to0 = ( arbdp_inst_byte_addr_c7[2:0] + inst_size_c7[2:0] 
				- 3'b1 ) ;

 assign  dec_start_addr[0] = ( arbdp_inst_byte_addr_c7[2:0] == 3'd0 ) ;
 assign  dec_start_addr[1] = ( arbdp_inst_byte_addr_c7[2:0] == 3'd1 ) ;
 assign  dec_start_addr[2] = ( arbdp_inst_byte_addr_c7[2:0] == 3'd2 );
 assign  dec_start_addr[3] = ( arbdp_inst_byte_addr_c7[2:0] == 3'd3 ) ;
 assign  dec_start_addr[4] = ( arbdp_inst_byte_addr_c7[2:0] == 3'd4 ) ;
 assign  dec_start_addr[5] = ( arbdp_inst_byte_addr_c7[2:0] == 3'd5 ) ;
 assign  dec_start_addr[6] = ( arbdp_inst_byte_addr_c7[2:0] == 3'd6 ) ;
 assign  dec_start_addr[7] = ( arbdp_inst_byte_addr_c7[2:0] == 3'd7 ) ;

 assign  dec_end_addr[0] = ( end_addr_2to0  == 3'd0 ) ;
 assign  dec_end_addr[1] = ( end_addr_2to0  == 3'd1 ) ;
 assign  dec_end_addr[2] = ( end_addr_2to0  == 3'd2 ) ;
 assign  dec_end_addr[3] = ( end_addr_2to0  == 3'd3 ) ;
 assign  dec_end_addr[4] = ( end_addr_2to0  == 3'd4 ) ;
 assign  dec_end_addr[5] = ( end_addr_2to0  == 3'd5 ) ;
 assign  dec_end_addr[6] = ( end_addr_2to0  == 3'd6 ) ;
 assign  dec_end_addr[7] = ( end_addr_2to0  == 3'd7 ) ;

 assign  cum_or_start_addr_c7[0] = dec_start_addr[0] ;
 assign  cum_or_start_addr_c7[1] = |(dec_start_addr[1:0]) ;
 assign  cum_or_start_addr_c7[2] = |(dec_start_addr[2:0]) ;
 assign  cum_or_start_addr_c7[3] = |(dec_start_addr[3:0]) ;
 assign  cum_or_start_addr_c7[4] = |(dec_start_addr[4:0]) ;
 assign  cum_or_start_addr_c7[5] = |(dec_start_addr[5:0]) ;
 assign  cum_or_start_addr_c7[7] = |(dec_start_addr[7:0]) ;
 assign  cum_or_start_addr_c7[6] = |(dec_start_addr[6:0]) ;

 assign  cum_or_end_addr_c7[7] = dec_end_addr[7] ;
 assign  cum_or_end_addr_c7[6] = |(dec_end_addr[7:6]) ;
 assign  cum_or_end_addr_c7[5] = |(dec_end_addr[7:5]) ;
 assign  cum_or_end_addr_c7[4] = |(dec_end_addr[7:4]) ;
 assign  cum_or_end_addr_c7[3] = |(dec_end_addr[7:3]) ;
 assign  cum_or_end_addr_c7[2] = |(dec_end_addr[7:2]) ;
 assign  cum_or_end_addr_c7[1] = |(dec_end_addr[7:1]) ;
 assign  cum_or_end_addr_c7[0] = |(dec_end_addr[7:0]) ;

 dff_s     #(1)    ff_hit_l2orfb_c4 (.din(tagctl_hit_l2orfb_c3), .clk(rclk),
                                  .q(hit_l2orfb_c4),
                                  .se(se), .si(), .so());
 dff_s     #(1)    ff_hit_l2orfb_c5 (.din(hit_l2orfb_c4), .clk(rclk),
                                  .q(hit_l2orfb_c5),
                                  .se(se), .si(), .so());
 dff_s     #(1)    ff_hit_l2orfb_c6 (.din(hit_l2orfb_c5), .clk(rclk),
                                  .q(hit_l2orfb_c6),
                                  .se(se), .si(), .so());
 dff_s     #(1)    ff_hit_l2orfb_c7 (.din(hit_l2orfb_c6), .clk(rclk),
                                  .q(hit_l2orfb_c7),
                                  .se(se), .si(), .so());
 dff_s     #(1)    ff_hit_l2orfb_c8 (.din(hit_l2orfb_c7), .clk(rclk),
                                  .q(hit_l2orfb_c8),
                                  .se(se), .si(), .so());

 
 assign	 dword_mask_c7 = (cum_or_start_addr_c7 & cum_or_end_addr_c7) |
                        {8{~decdp_pst_inst_c7|~hit_l2orfb_c7}} ;


 dff_s     #(8)    ff_dword_mask_c8 (.din(dword_mask_c7[7:0]), .clk(rclk),
                                  .q(dword_mask_c8[7:0]),
                                  .se(se), .si(), .so());


 // ////////////////////////////////////////////////////////////////////////////////////
 // PST CTRUE WR EN
 // Write ctrue for a PST if its  pass hits the cache or FB so that the next
 // pass will perform a store to the $
 // ////////////////////////////////////////////////////////////////////////////////////


 assign arbctl_pst_ctrue_en_c8 = arbdp_pst_no_ctrue_c8 & hit_l2orfb_c8 ;

 // ////////////////////////////////////////////////////////////////////////////////////
 // Select for the mux in data array between store data and fill data.
 // ///////////////////////////////////////////////////////////////////////////////////

 assign	arbctl_fill_vld_c2 = ( arbdp_inst_fb_c2 & arbctl_inst_vld_c2_7) ;

 dff_s     #(1)    ff_fbrd_c3 (.din(arbctl_fill_vld_c2), .clk(rclk),
                 .q(arbctl_fill_vld_c3), .se(se), .si(), .so());

 assign	scdata_fbrd_c3 = arbctl_fill_vld_c3 ;




 //////////////////////////////////////////////////////////////////////
 // DIrectory access Signals are generated here
 /////////////////////////////////////////////////////////////////////

 ////////////////////////////////////////////////////////////////////////
 // 1. Bank enable for the  D$ directories.
 //	C2		C3	
 //================================
 //    store		imiss2 hit
 //    hit			
 //  				
 //    atm hit		eviction
 //			of valid line
 //    
 //    imiss1 hit 	xmit to dir
 //	
 //    bst hit
 //    snp hit
 ////////////////////////////////////////////////////////////////////////

 
 assign	st_cam_en_c2 = ( decdp_st_inst_c2_1 | decdp_strst_inst_c2_1 ) &
		 ~( decdp_fwd_req_c2 | arbctl_inst_diag_c2 ) & 
		 ( ~arbdp_inst_mb_c2 | arbdp_inst_dep_c2 ) ;

 dff_s   #(1)  ff_st_cam_en_c3   (.din(st_cam_en_c2), .clk(rclk),
             	.q(st_cam_en_c3), .se(se), .si(), .so());

// special instructions cam en.
// 2/20/2003 Changed decdp_cas2_from_mb_c2 to
// decdp_cas2_from_mb_ctrue_c2 in the following expressions.
// A CAS instruction will not cam the D$ directory unless
// the compare results are true.
// Remember: THe I$ directory WILL BE CAMMED irrespective
// of the compare results.

 assign	sp_cam_en_c2 = ( ~arbdp_pst_no_ctrue_c2_1 & decdp_swap_inst_c2 ) |
			( ~arbdp_pst_no_ctrue_c2_1 & decdp_wr8_inst_c2 ) |
                                decdp_cas2_from_mb_ctrue_c2 ;


 dff_s   #(1)  ff_sp_cam_en_c3   (.din(sp_cam_en_c2), .clk(rclk),
             	.q(sp_cam_en_c3), .se(se), .si(), .so());

 assign	dc_cam_addr_c3[0] = ( arbdp_addr5to4_c3 == 2'd0 ) ;
 assign	dc_cam_addr_c3[1] = ( arbdp_addr5to4_c3 == 2'd1 ) ;
 assign	dc_cam_addr_c3[2] = ( arbdp_addr5to4_c3 == 2'd2 ) ;
 assign	dc_cam_addr_c3[3] = ( arbdp_addr5to4_c3 == 2'd3 ) ;


 //---------\/ POST_4.2 change required for timing \/------
 // mbctl_nondep_fbhit_c3 is an unqualified signal from mbctl
 //---------\/ POST_4.2 change required for timing \/------
 

 assign	store_inst_en_c3 = ( tagctl_hit_l2orfb_c3 | 
			( mbctl_nondep_fbhit_c3  & ~tagdp_arbctl_par_err_c3 & arbctl_inst_vld_c3_2) ) ;

 // cam entries with addr<5>==0 for the 1st imiss packet.
 assign	dc_hitqual_cam_en0_c3 =	( st_cam_en_c3  & store_inst_en_c3 ) 
				| ( tagctl_hit_l2orfb_c3 & sp_cam_en_c3) 
				| imiss_hit_c3 ;

 
 assign	dc_hitqual_cam_en1_c3 = ( st_cam_en_c3  & store_inst_en_c3 ) 
				| ( sp_cam_en_c3 & tagctl_hit_l2orfb_c3 )  ;

 dff_s   #(1)  ff_enc_cam_addr_c4  (.din(arbdp_addr5to4_c3[1]), .clk(rclk),
          		.q(enc_cam_addr_c4), .se(se), .si(), .so());
 
 // snoops and block stores need to be included in this expression.
 assign	arbctl_lkup_bank_ena_dcd_c3[0] = ( dc_cam_addr_c3[0] &  // cam for store,atomic, imiss packet1
			 dc_hitqual_cam_en0_c3 ) |
			( arbctl_evict_c3 & ~invalid_evict_c3 ) | // eviction CAM
			 ( wr64_inst_c3  & tagctl_hit_l2orfb_c3 );

 assign	arbctl_lkup_bank_ena_dcd_c3[1] = ( dc_cam_addr_c3[1] &  // cam for store,atomic, imiss packet2
			 dc_hitqual_cam_en1_c3)  |
			( arbctl_evict_c3 & ~invalid_evict_c3 ) |
			(  ~enc_cam_addr_c4  &  arbctl_imiss_hit_c4 )|// addr<5>=0 cam for 2nd imiss packet
			 ( wr64_inst_c3  & tagctl_hit_l2orfb_c3 );

 assign	arbctl_lkup_bank_ena_dcd_c3[2] = ( dc_cam_addr_c3[2] &  // cam for store,atomic, imiss packet1
			 dc_hitqual_cam_en0_c3)  |
			( arbctl_evict_c3 & ~invalid_evict_c3 ) |
			(wr64_inst_c3  &  tagctl_hit_l2orfb_c3 ); 

 assign	arbctl_lkup_bank_ena_dcd_c3[3] = ( dc_cam_addr_c3[3] &  // cam for store,atomic, imiss packet2
			 dc_hitqual_cam_en1_c3 )  |
			( arbctl_evict_c3 & ~invalid_evict_c3 ) |
			( enc_cam_addr_c4 & arbctl_imiss_hit_c4 )|  // addr<5>=1 cam for 2nd imiss packet
			( wr64_inst_c3  &  tagctl_hit_l2orfb_c3 );


 ////////////////////////////////////////////////////////////////////////
 // 2. Bank enable for the  I$ directories.
 //	C2		C3		
 //==================================
 //    store		 	
 //    hit			
 //  				
 //    atm hit		eviction
 //			of valid line
 //    
 //    ld hit		xmit to
 //			dir
 //    bst hit 
 //    snp hit
 ////////////////////////////////////////////////////////////////////////

 assign	ic_cam_addr_c3[0] = ( {arbdp_addr5to4_c3[1], arbdp_addr11to8_c3[7]} == 2'd0 ) ;
 assign	ic_cam_addr_c3[1] = ( {arbdp_addr5to4_c3[1], arbdp_addr11to8_c3[7]} == 2'd1 ) ;
 assign	ic_cam_addr_c3[2] = ( {arbdp_addr5to4_c3[1], arbdp_addr11to8_c3[7]} == 2'd2 ) ;
 assign	ic_cam_addr_c3[3] = ( {arbdp_addr5to4_c3[1], arbdp_addr11to8_c3[7]} == 2'd3 ) ;

 //-------\/ Added this logic POST_4.2 \/----------
 // For a BLD, NC=1. The D$ is not filled with BLD data returned by
 // the L2. In this case, it will be incorrect to invalidate the i$
 // because the i$ logic cannot handle more than one invalidate per
 // outstanding load whereas a BLD will invalidate 2 lines in the I$( potentially)

 dff_s   #(1)  ff_arbctl_inst_nc_c2   (.din(arbdp_inst_nc_c1), .clk(rclk),
             	.q(arbctl_inst_nc_c2), .se(se), .si(), .so());

 assign	ic_hitqual_cam_en_c2 = (( ~arbdp_pst_no_ctrue_c2_1 & decdp_swap_inst_c2 ) |
				( ~arbdp_pst_no_ctrue_c2_1 & decdp_wr8_inst_c2 ) |
				decdp_cas2_from_mb_c2 | 		
				( decdp_camld_inst_c2 & ~arbctl_inst_nc_c2 )) ;

 dff_s   #(1)  ff_ic_hitqual_cam_en_c3   (.din(ic_hitqual_cam_en_c2), .clk(rclk),
             	.q(ic_hitqual_cam_en_c3), .se(se), .si(), .so());

 // instructions that cam only one directory panel are included here.

 assign	tmp_bank_icd_c3 = ( st_cam_en_c3 & store_inst_en_c3 ) |
		( ic_hitqual_cam_en_c3 & tagctl_hit_l2orfb_c3 ) ;


 // Addr<11>==0 qualification is necessary for evictions, bsts and snoops
 assign	arbctl_lkup_bank_ena_icd_c3[0]  =  ( tmp_bank_icd_c3 & ic_cam_addr_c3[0] ) | 
			 ( ((arbctl_evict_c3 & ~invalid_evict_c3) | 
			(wr64_inst_c3 & tagctl_hit_l2orfb_c3 )  ) 
			& ~arbdp_addr11to8_c3[7])  ;
 // Addr<11>==1 qualification is necessary for evictions, bsts and snoops
 assign	arbctl_lkup_bank_ena_icd_c3[1]  =  ( tmp_bank_icd_c3 & ic_cam_addr_c3[1] ) | 
			 ( ((arbctl_evict_c3 & ~invalid_evict_c3) | 
			(wr64_inst_c3 & tagctl_hit_l2orfb_c3 )  ) 
			& arbdp_addr11to8_c3[7])  ;

 // Addr<11>==0 qualification is necessary for evictions, bsts and snoops
 assign	arbctl_lkup_bank_ena_icd_c3[2]  = ( tmp_bank_icd_c3 & ic_cam_addr_c3[2] ) |
			 ( ((arbctl_evict_c3 & ~invalid_evict_c3) |
			(wr64_inst_c3 & tagctl_hit_l2orfb_c3 )  ) 
			& ~arbdp_addr11to8_c3[7])  ;

 // Addr<11>==1 qualification is necessary for evictions, bsts and snoops
 assign	arbctl_lkup_bank_ena_icd_c3[3]  =  ( tmp_bank_icd_c3 & ic_cam_addr_c3[3] ) |
			 ( ((arbctl_evict_c3 & ~invalid_evict_c3) | 
			(wr64_inst_c3 & tagctl_hit_l2orfb_c3 )  ) 
			& arbdp_addr11to8_c3[7])  ;

  
 ////////////////////////////////////////////////////////////////////////
 // 3 & 4. Row address for the  D$ directories. ( This logic is in arbaddrdp.)
 ////////////////////////////////////////////////////////////////////////

 ////////////////////////////////////////////////////////////////////////
 // 5. INvalidate mask  for the  d$ directories. 
 //	// For a normal store in C3 invalidate all other cpus
 //	// For an imiss ld in C3 or C4  invalidate the decoded cpu
 //	// invalidate all cpus as the default case.
 ////////////////////////////////////////////////////////////////////////

  mux2ds   #(3)   mux_cpuid_c3(.dout (cpuid_c3[2:0]) , // c3 invalidation cpu
                        .in0(arbdp_cpuid_c4[2:0]),	// c4 instruction cpuid
                        .in1(arbdp_cpuid_c3[2:0] ),	// c3 instruction cpuid
                        .sel0(arbctl_imiss_hit_c4),	// sel c4 cpuid
                        .sel1(~arbctl_imiss_hit_c4));	// sel default.

  assign	self_inval_mask_c3[0] = ( cpuid_c3 == 3'd0 ) ;
  assign 	self_inval_mask_c3[1] = ( cpuid_c3 == 3'd1 ) ;
  assign	self_inval_mask_c3[2] = ( cpuid_c3 == 3'd2 ) ;
  assign	self_inval_mask_c3[3] = ( cpuid_c3 == 3'd3 ) ;
  assign	self_inval_mask_c3[4] = ( cpuid_c3 == 3'd4 ) ;
  assign	self_inval_mask_c3[5] = ( cpuid_c3 == 3'd5 ) ;
  assign	self_inval_mask_c3[6] = ( cpuid_c3 == 3'd6 ) ;
  assign	self_inval_mask_c3[7] = ( cpuid_c3 == 3'd7 ) ;

  assign	others_inval_mask_c3 = ~self_inval_mask_c3 ;

  dff_s   #(1)  ff_ld_inst_c3  (.din(decdp_camld_inst_c2), .clk(rclk),
             .q(ld_inst_c3), .se(se), .si(), .so());
  

  // store hit includes that case where the store hits the Fill Buffer
  // and not the Miss Buffer.
  //assign st_inst_hit_c3 =  decdp_st_inst_c3 & store_inst_en_c3 ;

 // Store inst vld c3 can be used in place of st_inst_hit_c3 in
 // * inval mask logic.
 // * dir rd entry logic
 // * dir error logic
 // * dir rd panel logic.


 
  assign store_inst_vld_c3 = decdp_st_inst_c3 & arbctl_inst_vld_c3 ;
  assign store_inst_vld_c3_1 = decdp_st_inst_c3_1 & arbctl_inst_vld_c3_1 ;
  assign store_inst_vld_c3_2 = decdp_st_inst_c3_2 & arbctl_inst_vld_c3_2 ;


  assign ld_hit_c3 =  ld_inst_c3 & tagctl_hit_l2orfb_c3;

  assign sel_stld_mask = ( ( store_inst_vld_c3_2 & 
				~decdp_rmo_st_c3 &  // Inval every cpu on an eviction or a rmo store
					~arbctl_evict_unqual_c3  ) 
				| imiss_hit_c3 |
				arbctl_imiss_hit_c4 | ld_hit_c3 );

  mux2ds   #(8)   mux1_inval_mask_c3(.dout (tmp_inval_mask_c3[7:0]) , // lds and stores mask
                        .in0(others_inval_mask_c3[7:0]), // stores mask
                        .in1(self_inval_mask_c3[7:0] ),	// loads mask
                        .sel0(store_inst_vld_c3_1),	// sel stores mask
                        .sel1(~store_inst_vld_c3_1)); // sel default.

  mux2ds   #(8)   mux2_inval_mask_c3(.dout (arbctl_inval_mask_dcd_c3[7:0]) , // inval_mask_dcd
                        .in0(tmp_inval_mask_c3[7:0]), // stores/lds  mask
                        .in1(8'hFF),	// default mask 
                        .sel0(sel_stld_mask),	// sel stldimiss mask
                        .sel1(~sel_stld_mask)); // sel default.


	
 ////////////////////////////////////////////////////////////////////////
 // 6. INvalidate mask  for the  i$ directories. 
 //	// For an  ld in C3  invalidate the decoded cpu
 // 	// invalidate all cpus in the default case.
 ////////////////////////////////////////////////////////////////////////
  
  mux2ds   #(8)   mux1_ic_inval_mask_c3(.dout (arbctl_inval_mask_icd_c3[7:0]) , // inval_mask_icd
                        .in0(self_inval_mask_c3[7:0]), // lds  mask
                        .in1(8'hFF),	// default mask 
                        .sel0(ld_hit_c3),	// sel lds mask
                        .sel1(~ld_hit_c3)); // sel default.



 ////////////////////////////////////////////////////////////////////////
 // 7. Wr enable into the D$ & I$ directory 
 ////////////////////////////////////////////////////////////////////////

  dff_s   #(1)  ff_dc_inval_c3  (.din(decdp_dc_inval_c2), .clk(rclk),
                              .q(dc_inval_c3), .se(se), .si(), .so());

  dff_s   #(1)  ff_ic_inval_c3  (.din(decdp_ic_inval_c2), .clk(rclk),
                              .q(ic_inval_c3), .se(se), .si(), .so());

  assign	inval_inst_vld_c2 = ( decdp_dc_inval_c2 | 
					decdp_ic_inval_c2 ) &
					arbctl_inst_vld_c2_7 ;

  assign	arbctl_inval_inst_c2 = inval_inst_vld_c2 ;

//----\/ FIX for bug#4619 \/--------------------------------------
  assign	arbctl_mbctl_inval_inst_c2 = ( decdp_dc_inval_c2 |
                                        decdp_ic_inval_c2 ) ;


  assign     dc_inval_vld_c3 = dc_inval_c3 & arbctl_inst_vld_c3 & ~mbctl_arbctl_hit_c3 ;
  assign     ic_inval_vld_c3 = ic_inval_c3 & arbctl_inst_vld_c3 & ~mbctl_arbctl_hit_c3 ;
//----\/ FIX for bug#4619 \/--------------------------------------
//  assign     dc_inval_vld_c3 = dc_inval_c3 & arbctl_inst_vld_c3 ;
//  assign     ic_inval_vld_c3 = ic_inval_c3 & arbctl_inst_vld_c3 ;
 

	dff_s   #(1)  ff_dc_inval_vld_c4  (.din(dc_inval_vld_c3), .clk(rclk),
                   	.q(dc_inval_vld_c4), .se(se), .si(), .so());
	dff_s   #(1)  ff_dc_inval_vld_c5  (.din(dc_inval_vld_c4), .clk(rclk),
                   	.q(dc_inval_vld_c5), .se(se), .si(), .so());
	dff_s   #(1)  ff_dc_inval_vld_c6  (.din(dc_inval_vld_c5), .clk(rclk),
                   	.q(dc_inval_vld_c6), .se(se), .si(), .so());
	dff_s   #(1)  ff_dc_inval_vld_c7  (.din(dc_inval_vld_c6), .clk(rclk),
                   	.q(dc_inval_vld_c7), .se(se), .si(), .so());


	dff_s   #(1)  ff_ic_inval_vld_c4  (.din(ic_inval_vld_c3), .clk(rclk),
                   	.q(ic_inval_vld_c4), .se(se), .si(), .so());
	dff_s   #(1)  ff_ic_inval_vld_c5  (.din(ic_inval_vld_c4), .clk(rclk),
                   	.q(ic_inval_vld_c5), .se(se), .si(), .so());
	dff_s   #(1)  ff_ic_inval_vld_c6  (.din(ic_inval_vld_c5), .clk(rclk),
                   	.q(ic_inval_vld_c6), .se(se), .si(), .so());
	dff_s   #(1)  ff_ic_inval_vld_c7  (.din(ic_inval_vld_c6), .clk(rclk),
                   	.q(ic_inval_vld_c7), .se(se), .si(), .so());


 assign	inval_inst_vld_c3 = dc_inval_vld_c3 | ic_inval_vld_c3 ;
 assign	inval_inst_vld_c4 = dc_inval_vld_c4 | ic_inval_vld_c4 ;
 assign	inval_inst_vld_c5 = dc_inval_vld_c5 | ic_inval_vld_c5 ;
 assign	inval_inst_vld_c6 = dc_inval_vld_c6 | ic_inval_vld_c6 ;



 // Date : 2/2/2002: 
 // In L2 bypass mode, the directory write for Fb hits is
 // disabled 


 assign	arbctl_dc_wr_en_c3 =  ( ld_hit_c3 & ~arbdp_inst_nc_c3
			& ~l2_bypass_mode_on_d1 ) | 
			dc_inval_vld_c3 | 		// l1_way 00
			dc_inval_vld_c4 |		// l1_way 01
			dc_inval_vld_c5 | 		// l1_way 10
			dc_inval_vld_c6 ;		// l1_way 11
	
  
 assign	arbctl_ic_wr_en_c3 =  ( imiss_hit_c3 & ~arbdp_inst_nc_c3
			& ~l2_bypass_mode_on_d1 ) | 
			ic_inval_vld_c3 | 		// l1_way 00
			ic_inval_vld_c4 |		// l1_way 01
			ic_inval_vld_c5 | 		// l1_way 10
			ic_inval_vld_c6 ;		// l1_way 11


 ////////////////////////////////////////////////////////////////////////
 // The Error injection register in csr needs this signal.
 ////////////////////////////////////////////////////////////////////////
 assign	arbctl_dir_wr_en_c3 = ( arbctl_dc_wr_en_c3 |
				arbctl_ic_wr_en_c3 ) ;

 dff_s   #(1)  ff_arbctl_dir_wr_en_c4  (.din(arbctl_dir_wr_en_c3), .clk(rclk),
           	.q(arbctl_dir_wr_en_c4), .se(se), .si(), .so());


 ////////////////////////////////////////////////////////////////////////
 // 8. Rd enable into the d$ and I$ directories
 // A read is performed when a store hit is in C3.
 //	dir_addr_cnt<10:6> = panel #
 //	dir_addr_cnt<5:1> = entry #
 // 	dir_addr_cnt<0> = I$ , 0= d$
 // 	Pipeline for reads.
 //--------------------------------------------------------------------------------
 // 	C3	 	C4		C5		C6		C7
 //--------------------------------------------------------------------------------
 //   setup		xmit		Dir		Parity		Error
 //   dir		inside		Rd		Calc.		Xmit
 //   rd access		the dir						to arbctl
 //   I$/d$
 ////////////////////////////////////////////////////////////////////////

 assign	dir_addr_cnt_plus1 = dir_addr_cnt_c3 + 11'b1 ;

 dffre_s   #(11)  ff_dir_addr_cnt  (.q(dir_addr_cnt_c3[10:0]),
                 .en(store_inst_vld_c3), .clk(rclk), .rst(data_ecc_idx_reset),
                 .din(dir_addr_cnt_plus1[10:0]), .se(se), .si(), .so());

 assign	arbctl_dc_rd_en_c3 = ~dir_addr_cnt_c3[0] & store_inst_vld_c3_1 ;
 assign	arbctl_ic_rd_en_c3 = dir_addr_cnt_c3[0] & store_inst_vld_c3_1 ;

  
  dff_s   #(11)  ff_dir_addr_cnt_c4  (.din(dir_addr_cnt_c3[10:0]), .clk(rclk),
             .q(dir_addr_cnt_c4[10:0]), .se(se), .si(), .so());
  dff_s   #(11)  ff_dir_addr_cnt_c5  (.din(dir_addr_cnt_c4[10:0]), .clk(rclk),
             .q(dir_addr_cnt_c5[10:0]), .se(se), .si(), .so());
  dff_s   #(11)  ff_dir_addr_cnt_c6  (.din(dir_addr_cnt_c5[10:0]), .clk(rclk),
             .q(dir_addr_cnt_c6[10:0]), .se(se), .si(), .so());
  dff_s   #(11)  ff_dir_addr_cnt_c7  (.din(dir_addr_cnt_c6[10:0]), .clk(rclk),
             .q(dir_addr_cnt_c7[10:0]), .se(se), .si(), .so());

			 

 /////////////////
 // sent to the CSR
 // block for ERR
 //  reporting.
 /////////////////

 dff_s   #(11)  ff_dir_addr_c8  (.din(dir_addr_cnt_c7[10:0]), .clk(rclk),
            .q(dir_addr_cnt_c8[10:0]), .se(se), .si(), .so());

 dff_s   #(11)  ff_dir_addr_c9  (.din(dir_addr_cnt_c8[10:0]), .clk(rclk),
            .q(dir_addr_c9[10:0]), .se(se), .si(), .so());



 ////////////////////////////////////////////////////////////////////////
 // 9. Rd/Wr entry number 
 ////////////////////////////////////////////////////////////////////////

 assign	dir_entry_c3 = { arbdp_cpuid_c3, arbdp_l1way_c3 } ;
 assign	dir_entry_c4 = { arbdp_cpuid_c4, 2'b01 } ;
 assign	dir_entry_c5 = { arbdp_cpuid_c5, 2'b10 } ;
 assign	dir_entry_c6 = { arbdp_cpuid_c6, 2'b11 } ;

 assign	def_inval_entry = ~( inval_inst_vld_c4 |
                                inval_inst_vld_c5 |
                                        inval_inst_vld_c6 ) ;

 mux4ds  #(5) mux_inval_dir_entry_c3 (.dout (tmp_wr_dir_entry_c3[4:0]),
                               .in0(dir_entry_c3[4:0]), .in1(dir_entry_c4[4:0]),
                                .in2(dir_entry_c5[4:0]), .in3(dir_entry_c6[4:0]),
                                .sel0(def_inval_entry), .sel1(inval_inst_vld_c4),
                                .sel2(inval_inst_vld_c5), .sel3(inval_inst_vld_c6));

 
 assign	wr_dir_entry_c3[1:0] = tmp_wr_dir_entry_c3[1:0] & ~{2{inval_inst_vld_c3}} ;
 assign	wr_dir_entry_c3[4:2] = tmp_wr_dir_entry_c3[4:2] ;


 
 mux2ds  #(5) mux_dir_entry_c3   (.dout (arbctl_wr_dc_dir_entry_c3[4:0]),
                                .in0(dir_addr_cnt_c3[5:1]), .in1(wr_dir_entry_c3[4:0]),
                                .sel0(store_inst_vld_c3_1), .sel1(~store_inst_vld_c3_1));

 assign	arbctl_wr_ic_dir_entry_c3 = arbctl_wr_dc_dir_entry_c3 ;

 ////////////////////////////////////////////////////////////////////////
 // 10. Rd/Wr Panel number 
 //	d$ panel number = A<10-8>, A<5-4> 
 //	i$ panel number	= B<10-8>, B<5,11>
 ////////////////////////////////////////////////////////////////////////


 assign	dc_wr_panel_c3 = { arbdp_addr11to8_c3[6:4], arbdp_addr5to4_c3[1:0]};

  dff_s   #(5)  ff_dc_wr_panel_c4  (.din(dc_wr_panel_c3[4:0]), .clk(rclk),
             	.q(dc_wr_panel_c4[4:0]), .se(se), .si(), .so());
  dff_s   #(5)  ff_dc_wr_panel_c5  (.din(dc_wr_panel_c4[4:0]), .clk(rclk),
             	.q(dc_wr_panel_c5[4:0]), .se(se), .si(), .so());
  dff_s   #(5)  ff_dc_wr_panel_c6  (.din(dc_wr_panel_c5[4:0]), .clk(rclk),
             	.q(dc_wr_panel_c6[4:0]), .se(se), .si(), .so());

 mux4ds  #(5) mux_inval_dc_panel_c3 (.dout (tmp_dc_wr_panel_c3[4:0]),
                                .in0(dc_wr_panel_c3[4:0]), .in1(dc_wr_panel_c4[4:0]),
                                .in2(dc_wr_panel_c5[4:0]), .in3(dc_wr_panel_c6[4:0]),
                                .sel0(def_inval_entry), .sel1(inval_inst_vld_c4),
                                .sel2(inval_inst_vld_c5), .sel3(inval_inst_vld_c6));

 mux2ds  #(5) mux_dc_dir_panel_c3   (.dout (arbctl_dir_panel_dcd_c3[4:0]),
                                .in0(dir_addr_cnt_c3[10:6]), .in1(tmp_dc_wr_panel_c3[4:0]),
                                .sel0(store_inst_vld_c3_2), .sel1(~store_inst_vld_c3_2));


 assign	ic_wr_panel_c3 = { arbdp_addr11to8_c3[6:4], arbdp_addr5to4_c3[1], 
					arbdp_addr11to8_c3[7]};
 
  dff_s   #(5)  ff_ic_wr_panel_c4  (.din(ic_wr_panel_c3[4:0]), .clk(rclk),
             	.q(ic_wr_panel_c4[4:0]), .se(se), .si(), .so());
  dff_s   #(5)  ff_ic_wr_panel_c5  (.din(ic_wr_panel_c4[4:0]), .clk(rclk),
             	.q(ic_wr_panel_c5[4:0]), .se(se), .si(), .so());
  dff_s   #(5)  ff_ic_wr_panel_c6  (.din(ic_wr_panel_c5[4:0]), .clk(rclk),
             	.q(ic_wr_panel_c6[4:0]), .se(se), .si(), .so());

 mux4ds  #(5) mux_inval_ic_panel_c3 (.dout (tmp_ic_wr_panel_c3[4:0]),
                                .in0(ic_wr_panel_c3[4:0]), .in1(ic_wr_panel_c4[4:0]),
                                .in2(ic_wr_panel_c5[4:0]), .in3(ic_wr_panel_c6[4:0]),
                                .sel0(def_inval_entry), .sel1(inval_inst_vld_c4),
                                .sel2(inval_inst_vld_c5), .sel3(inval_inst_vld_c6));

 mux2ds  #(5) mux_ic_dir_panel_c3   (.dout (arbctl_dir_panel_icd_c3[4:0]),
                                .in0(dir_addr_cnt_c3[10:6]), .in1(tmp_ic_wr_panel_c3[4:0]),
                                .sel0(store_inst_vld_c3_2), .sel1(~store_inst_vld_c3_2));
 //////////////////////////////////////////////////////////////////////////
 // Valid bit written into the directory entries is 
 // * 0 when an invalidation instruction is active
 // * 1 by default.
 //////////////////////////////////////////////////////////////////////////

 assign	arbctl_dir_vld_c3_l = ~( inval_inst_vld_c3 |
				inval_inst_vld_c4 |
				inval_inst_vld_c5 |
				inval_inst_vld_c6 ) ;
 
 //////////////////////////////////////////////////////////////////////////
 // 2nd cycle stall condition for WR64 and RD64
 //////////////////////////////////////////////////////////////////////////
 assign	rdma_64B_stall = ( decdp_wr64_inst_c2_1 | decdp_ld64_inst_c2 ) &
				arbctl_inst_vld_c2_7 ;
 
  dff_s   #(1)  ff_wr64_inst_c3  (.din(decdp_wr64_inst_c2_1), .clk(rclk),
             	.q(wr64_inst_c3), .se(se), .si(), .so());

 //////////////////////////////////////////////////////////////////////////
 // Way select gate
 // Way selects are turned off for the following types of operations.
 // * INterrupts 
 // * L1 $ inval instructions.
 // * Fills.
 // * Diagnostic instructions.
 // * cas2 from the xbar.
 // * Tecc instructions.
 // * eviction instructions.
 //////////////////////////////////////////////////////////////////////////


 assign	waysel_gate_c1 = ~( decdp_inst_int_or_inval_c1 | // int or inval instr.
				arbdp_inst_fb_c1_qual | // Fills.
				arbctl_inst_diag_c1 | 	// diagnostic instruction
				decdp_cas2_from_xbar_c1 |  // cas2 from xbar
				dec_evict_c1	| // eviction instruction.
				arbdp_tecc_c1	); // tecc instruction
			
  dff_s   #(1)  ff_waysel_gate_c2  (.din(waysel_gate_c1), .clk(rclk),
             	.q(arbctl_waysel_gate_c2), .se(se), .si(), .so());

 //////////////////////////////////////////////////////////////////////////
 // Par err gate C1
 // Parity error is gated off for the tag under the following conditions:
 // - INterrupts
 // L1 $ inval instructions
 // Fills
 // Diagnostic instructions
 // Tecc instructions
 //////////////////////////////////////////////////////////////////////////

 assign parerr_gate_c1 = ~( decdp_inst_int_or_inval_c1 | // int or inval instr.
                                arbdp_inst_fb_c1_qual | // Fills.
                                arbctl_inst_diag_c1 |
				arbdp_tecc_c1   );

 dff_s   #(1)  ff_parerr_gate_c1  (.din(parerr_gate_c1), .clk(rclk),
             	.q(parerr_gate_c2), .se(se), .si(), .so());

 assign	arbctl_tagdp_perr_vld_c2 = arbctl_inst_vld_c2  
					& ~l2_bypass_mode_on_d1 
					& parerr_gate_c2 ;



 //////////////////////////////////////////////////////////////////////////
 // Stall logic.
 // The following instructions/events cause the C1 instruction in 
 // the pipe to be stalled.
 // * evictions. 	(2 cycle stall )
 // * Fills. 	(2 cycle stall )
 // * Imiss. 	(1 cycle stall )
 // * tecc. 	(n cycle stall )
 // * diagnostic access. 	(data=2, tag=3, vuad=4) 
 // * snoop access ( n cycle stall )
 // * SAme col stall 
 // 
 // The above multicycle stall conditions are detected in C1 
 // and so is the same col stall. This is qualfied with 
 // arbctl_unstalled_inst_c1.
 // WHen a multicycle instruction is in C2 or beyond, inst_vld_cn is
 // used for qualifying that instruction.
 //
 //////////////////////////////////////////////////////////////////////////

 assign	arbctl_multi_cyc_c1 = ( multi_cyc_op_c1 | 	// all mutlcyc ops except diagnostics.
			arbctl_inst_diag_c1 )  
 			& ~arbctl_stall_c2  &  arbctl_inst_vld_c1_1 ; // unstalled valid instruction in C1.

 //////////////////////////////////////////////////////////////////////////
 // imiss_col_stall_c1: 	
 //--------------------------------------------------------------------
 //	instA 		C1		C2		C3
 //	instB				C1 stall	C1 stall
 //     OR
 //	instB				PX2 nostall	C1 stall
 //--------------------------------------------------------------------
 // when an imiss packet is in C2, stall is high due to arbctl_multi_cyc_c1.
 // when the imiss packet is in C3, stall is high if the instruction stalled
 // in C1 or in PX2 accesses the same column as the second imiss packet .
 // ** arbdp_new_addr5to4_px2 ** is the output of the address muxes in arbaddrdp
 // not including the final stall mux.
 //////////////////////////////////////////////////////////////////////////
 
 //assign	imiss_col_stall_c1 =  ( (( {arbdp_addr5to4_c2[1],1'b1 } == arbdp_addr5to4_c1[1:0] ) & // C1 inst == C2 col.
//				 arbctl_stall_c2 ) |		// implies that the c1 instruction is valid 
//			     (( {arbdp_addr5to4_c2[1],1'b1 } == arbdp_new_addr5to4_px2[1:0] ) &
//				~arbctl_stall_c2 ) )  & arbctl_imiss_vld_c2 ;
//


assign	imiss_stall_op_c1inc1 = (( {arbdp_addr5to4_c2[1],1'b1 } == arbdp_addr5to4_c1[1:0] ) & // C1 inst == C2 col.
                                 arbctl_stall_c2 ) & arbctl_imiss_vld_c2 ;

assign	same_col_stall_c1 = ~arbctl_stall_c2 & (
				(  arbctl_inst_vld_c1_1 &
				~(arbdp_addr5to4_c1[1] ^ arbdp_new_addr5to4_px2[1] ) & 		// addr 5,4c1 = addr5,4px2
				~(arbdp_addr5to4_c1[0] ^ arbdp_new_addr5to4_px2[0] ) )  |
				( arbctl_imiss_vld_c2 &
				~( arbdp_addr5to4_c2[1] ^ arbdp_new_addr5to4_px2[1] ) & 	// addr 5,1c2 = addr5,1 px2
				 arbdp_new_addr5to4_px2[0] ) ) ;				// and imiss 2nd pckt in C1



 //////////////////////////////////////////////////////////////////////////
 // same_col_stall_c1: 	
 //--------------------------------------------------------------------
 //	instA 				C1 nostall	C2		
 //	instB				PX2 		C1 stall
 //--------------------------------------------------------------------
 // If a packet in PX2 has the same address as a packet in C1 that is not
 // currently stalling in C1.
 //////////////////////////////////////////////////////////////////////////

 //assign	same_col_stall_c1 = ( arbdp_addr5to4_c1 == arbdp_new_addr5to4_px2 ) & 
//				~arbctl_stall_c2 &  arbctl_inst_vld_c1_1 ; // unstalled valid instruction in C1.


 
 //////////////
 // The following component of stall does not require any qualification 
 // since it already is qualified with inst vld in the appropriate stages.
// Notice that in the case of tecc or decc stalls, the stall is asserted for 
 // one more cycle than the operation itself so that the instruction stalled in
 // C1 can again access the tags and VUAD array.
 //////////////


 assign	arbctl_prev_stall_c1 = arbctl_evict_vld_c2 | // evict last cyc
			 (arbctl_fill_vld_c2 | arbctl_fill_vld_c3)  |  // fill last 2 cycles
			rdma_64B_stall | // 64B rdma access 
			( inval_inst_vld_c2 | inval_inst_vld_c3 | inval_inst_vld_c4 )| // inval cyc2-4 
			( inst_l2data_vld_c2 ) | // data diag. last cyc 
			( inst_l2tag_vld_c2 | inst_l2tag_vld_c3 ) | // tag last 2 cycles
			( inst_l2vuad_vld_c2 | inst_l2vuad_vld_c3 | inst_l2vuad_vld_c4 ) | // vuad last 3 cycles.
			 ( inc_tag_ecc_cnt_c2 | inc_tag_ecc_cnt_c3 ) | // tecc stall 
			 ( data_ecc_active_c4 ) ; // decc stall from tagctl.
				
assign	arbctl_stall_tmp_c1 = ( imiss_stall_op_c1inc1 ) |
			( arbctl_multi_cyc_c1 ) |
			( arbctl_prev_stall_c1 ) ;
			
assign	arbctl_stall_c1 = (arbctl_stall_tmp_c1 | same_col_stall_c1) ;
 
dff_s   #(1)  ff_arbctl_stall_c1  (.din(arbctl_stall_c1), .clk(rclk),
          	.q(arbctl_stall_unqual_c2), .se(se), .si(), .so());


assign	arbctl_stall_c2 = arbctl_stall_unqual_c2 &  arbctl_inst_vld_c1_1 ;
 
//////////////////////////////////////////////////////////
//// instruction valid logic
// An instruction from the IQ/PCX without V=1 is considered
// to be an invalid instruction.
// Since the V bit is part of the payload, it is late arriving
// compared to the rdy bit. 
//
// THe rdy bit  is used to enable tag vuad  and cam access.
// However, the V bit of the packet needs to be high
// for the instruction to be considered valid.
//////////////////////////////////////////////////////////

 assign	arbctl_inst_vld_px2 = ( arbctl_stall_c2 |
 	mbsel_px2 | 
	fbsel_px2 | 
	snpsel_px2 | 
	( iqsel_px2 & iq_arbctl_vbit_px2 )  
	)  ;
				

 // arbctl_inst_vld_c1 is used only for 
 // enabling the lkup in bw_r_cm16x40b i.e. fb,wb and rdma tags.
 // This flop is disabled by the assertion of sehold.
 dffre_s   #(1)  ff_arbctl_inst_vld_c1  (.din(arbctl_inst_vld_px2), .clk(rclk), 
		 .en(~sehold), .rst(~dbb_rst_l),
	         .q(arbctl_inst_vld_c1), .se(se), .si(), .so());

 dffrl_s   #(1)  ff_arbctl_inst_vld_c1_1  (.din(arbctl_inst_vld_px2), .clk(rclk), 
		 .rst_l(dbb_rst_l),
	         .q(arbctl_inst_vld_c1_1), .se(se), .si(), .so());
 
 // the following expression indicates if an instruction will be
 // valid in the next cycle in the C2 stage.

 assign	inst_vld_c2_prev =  arbctl_inst_vld_c1_1 
				& ~arbctl_stall_unqual_c2 ;

// make 8 copies of instruction valid
// since it is heavily loaded.

 dff_s   #(1)  ff_arbctl_inst_vld_c2  (.din(inst_vld_c2_prev), .clk(rclk), 
	         .q(arbctl_inst_vld_c2), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_inst_vld_c2_1  (.din(inst_vld_c2_prev), .clk(rclk), 
	         .q(arbctl_inst_vld_c2_1), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_inst_vld_c2_2  (.din(inst_vld_c2_prev), .clk(rclk), 
	         .q(arbctl_inst_vld_c2_2), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_inst_vld_c2_3  (.din(inst_vld_c2_prev), .clk(rclk), 
	         .q(arbctl_inst_vld_c2_3), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_inst_vld_c2_4  (.din(inst_vld_c2_prev), .clk(rclk), 
	         .q(arbctl_inst_vld_c2_4), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_inst_vld_c2_5  (.din(inst_vld_c2_prev), .clk(rclk), 
	         .q(arbctl_inst_vld_c2_5), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_inst_vld_c2_6  (.din(inst_vld_c2_prev), .clk(rclk), 
	         .q(arbctl_inst_vld_c2_6), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_inst_vld_c2_7  (.din(inst_vld_c2_prev), .clk(rclk), 
	         .q(arbctl_inst_vld_c2_7), .se(se), .si(), .so());

 assign	arbctl_tagctl_inst_vld_c2 = arbctl_inst_vld_c2_2;

 dff_s   #(1)  ff_arbctl_inst_vld_c2_8  (.din(inst_vld_c2_prev), .clk(rclk), 
	         .q(arbctl_inst_vld_c2_8), .se(se), .si(), .so());

 assign	arbctl_waysel_inst_vld_c2 = arbctl_inst_vld_c2_8 ; // to tagctl waysel comp.

 dff_s   #(1)  ff_arbctl_inst_vld_c2_9  (.din(inst_vld_c2_prev), .clk(rclk), 
	         .q(arbctl_inst_vld_c2_9), .se(se), .si(), .so());

 assign	arbctl_coloff_inst_vld_c2 = arbctl_inst_vld_c2_9 ; // to tagctl coloff comp.

 dff_s   #(1)  ff_arbctl_inst_vld_c2_10  (.din(inst_vld_c2_prev), .clk(rclk), 
	         .q(arbctl_inst_vld_c2_10), .se(se), .si(), .so());

 assign	arbctl_rdwr_inst_vld_c2 = arbctl_inst_vld_c2_10 ; // to tagctl rdwr comp.



 assign	arbctl_mbctl_inst_vld_c2 = arbctl_inst_vld_c2_3 ;
 assign	arbctl_fbctl_inst_vld_c2 = arbctl_inst_vld_c2_4 ;
 assign	arbctl_wbctl_inst_vld_c2 = arbctl_inst_vld_c2_5 ;

 dff_s   #(1)  ff_arbctl_inst_vld_c3  (.din(arbctl_inst_vld_c2), .clk(rclk), 
	         .q(arbctl_inst_vld_c3), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_inst_vld_c3_1  (.din(arbctl_inst_vld_c2_1), .clk(rclk), 
	         .q(arbctl_inst_vld_c3_1), .se(se), .si(), .so());

 dff_s   #(1)  ff_arbctl_inst_vld_c3_2  (.din(arbctl_inst_vld_c2_1), .clk(rclk), 
	         .q(arbctl_inst_vld_c3_2), .se(se), .si(), .so());

 assign	arbctl_dbgdp_inst_vld_c3 = arbctl_inst_vld_c3 ;

 ////////////////////////////////////////////////////////////////////////
 // MB CAM hit DISABLE  : arbctl_mbctl_hit_off_c1 
 // Miss Buffer hit is disabled in the following conditions:
 // * MB or FB instruction.
 // * invalid instruction.
 // * INVAL instruction 
 // * Diagnostic 
 // * INterrupt instruction
 ////////////////////////////////////////////////////////////////////////
//-----------\/ FIX for BUG#4619. Mb is cammed on a INVAL instruction as well \/---------

 assign	arbctl_mbctl_hit_off_c1 = ~arbctl_inst_vld_c1_1 | // invalid instruction
			//decdp_inst_int_or_inval_c1 | // int or inval c1
			decdp_inst_int_c1 | // int C1
			arbdp_inst_mb_or_fb_c1 |  // mb or fb 
			arbctl_inst_diag_c1 ; // diagnostic access

//-----------\/ FIX for BUG#4619. Mb is cammed on a INVAL instruction as well \/---------

 ////////////////////////////////////////////////////////////////////////
 // FB CAM hit DISABLE  : arbctl_fbctl_hit_off_c1 
 // Fill Buffer hit is disabled in the following conditions:
 // * FB instruction.
 // * invalid instruction.
 // * INVAL instruction 
 // * Diagnostic 
 // * INterrupt instruction
 // * TECC instruction.
 // * EVICT instruction
 ////////////////////////////////////////////////////////////////////////


 assign	arbctl_fbctl_hit_off_c1 = ~arbctl_inst_vld_c1_1 | // invalid instruction
                        decdp_inst_int_or_inval_c1 | // int or inval c1
                        arbdp_inst_fb_c1_qual |  // mb or fb
                        arbctl_inst_diag_c1 |  // diagnostic access
			arbdp_tecc_c1  |  // tecc instruction
			dec_evict_c1 ; // eviction pass

 ////////////////////////////////////////////////////////////////////////
 // WB CAM hit DISABLE  : arbctl_wbctl_hit_off_c1 
 // WB Buffer hit is disabled in the following conditions:
 // * FB instruction.
 // * invalid instruction.
 // * INVAL instruction 
 // * Diagnostic 
 // * INterrupt instruction
 // * TECC instruction.
 ////////////////////////////////////////////////////////////////////////


 assign	arbctl_wbctl_hit_off_c1 = ~arbctl_inst_vld_c1_1 | // invalid instruction
                        decdp_inst_int_or_inval_c1 | // int or inval c1
                        arbdp_inst_fb_c1_qual |  // mb or fb
                        arbctl_inst_diag_c1 |  // diagnostic access
			arbdp_tecc_c1  ;  // tecc instruction





 // Decode logic.

  //////////////////////////////////////////////////////
 // unqualled eviction packet.
 // If an instruction is a TECC instruction then eviction
 // is turned off.Why?
 // An instruction making an eviction pass could detect a
 // TECC error. In this case, we mark the TECC bit in the
 // miss Buffer and also keep the EVICT bit set. When the
 // instruction makes its next pass through the L2 pipeline
 // It will cause TECC repair and reset TECC_READY.
 // The following pass will cause an eviction and reset EVICT_READY.
//  IN order for this to happen, we need to set the EVICT bit for
//  an EVICTIOn instruction with tecc=1.
// 
 //////////////////////////////////////////////////////

 assign	dec_evict_c1 = arbdp_evict_c1 & ~arbdp_tecc_c1 ;

 dff_s   #(1)  ff_dec_evict_c2  (.din(dec_evict_c1), .clk(rclk),
                 .q(dec_evict_c2), .se(se), .si(), .so());

 assign	dec_evict_tecc_c1 = arbdp_evict_c1 & arbdp_tecc_c1 ;
 
 dff_s   #(1)  ff_dec_evict_tecc_c2  (.din(dec_evict_tecc_c1), .clk(rclk),
                 .q(dec_evict_tecc_c2), .se(se), .si(), .so());

 assign	arbctl_evict_tecc_vld_c2 = dec_evict_tecc_c2 & 
					arbctl_inst_vld_c2_6 ;

 //////////////////////////////////////////////////////
// normal store instruction
//////////////////////////////////////////////////////
assign  decdp_st_inst_c1  = ~arbdp_inst_rsvd_c1 & (
                ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `STORE_RQ ) |
                (( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `FWD_RQ )  &
               ~arbdp_inst_nc_c1 )        );

dff_s     #(1)    ff_decdp_st_inst_c2     (.din(decdp_st_inst_c1),  
        .clk(rclk), .q(decdp_st_inst_c2), .se(se), .si(), .so());

dff_s     #(1)    ff_decdp_st_inst_c2_1     (.din(decdp_st_inst_c1),  
        .clk(rclk), .q(decdp_st_inst_c2_1), .se(se), .si(), .so());

dff_s     #(1)    ff_decdp_st_inst_c3     (.din(decdp_st_inst_c2_1),  
        .clk(rclk), .q(decdp_st_inst_c3), .se(se), .si(), .so());

dff_s     #(1)    ff_decdp_st_inst_c3_1     (.din(decdp_st_inst_c2_1),  
        .clk(rclk), .q(decdp_st_inst_c3_1), .se(se), .si(), .so());

dff_s     #(1)    ff_decdp_st_inst_c3_2     (.din(decdp_st_inst_c2_1),  
        .clk(rclk), .q(decdp_st_inst_c3_2), .se(se), .si(), .so());


//////////////////////////////////////////////////////
// 1) A normal store with bit[109] = 1 is treated like a
//              Block init store if it is performed to
//              address 0 within a cacheline.
// bug #3395
// PCX[109] is used to denote an RMO store ( BST or BIST ).
// PCX[110] is used to denote a BST.
//////////////////////////////////////////////////////



dff_s     #(1)   ff_arbdp_inst_bufid1_c2 (.din(arbdp_inst_bufid1_c1), .clk(rclk),
               .q(inst_bufid1_c2), .se(se), .si(), .so());






assign   decdp_bis_inst_c2 = arbdp_addr_start_c2 &    // addr<5:0> = 0
                       ~arbdp_rdma_inst_c2 &
			~inst_bufid1_c2 & // implies a BST and not BIST
        ( arbdp_inst_rqtyp_c2[`L2_RQTYP_HI:`L2_RQTYP_LO] == `STORE_RQ ) & 
			arbdp_inst_bufidlo_c2 ;

dff_s     #(1)    ff_decdp_bis_inst_c2  (.din(decdp_bis_inst_c2),  
        .clk(rclk), .q(decdp_bis_inst_c3), .se(se), .si(), .so());






assign  decdp_rmo_st_c2 = ~arbdp_rdma_inst_c2 &      // not a JBI inst
        ( arbdp_inst_rqtyp_c2[`L2_RQTYP_HI:`L2_RQTYP_LO] == `STORE_RQ )  &
        		arbdp_inst_bufidlo_c2 ;

dff_s     #(1)    ff_decdp_rmo_st_c2    (.din(decdp_rmo_st_c2),  
        .clk(rclk), .q(decdp_rmo_st_c3), .se(se), .si(), .so());


//////////////////////////////////////////////////////
// streaming store
//////////////////////////////////////////////////////
assign  decdp_strst_inst_c1  =  ~arbdp_inst_rsvd_c1  & 
              ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `STRST_RQ)   ;

dff_s     #(1)    ff_decdp_strst_inst_c2     (.din(decdp_strst_inst_c1),  
        .clk(rclk), .q(decdp_strst_inst_c2), .se(se), .si(), .so());


dff_s     #(1)    ff_decdp_strst_inst_c2_1     (.din(decdp_strst_inst_c1),  
        .clk(rclk), .q(decdp_strst_inst_c2_1), .se(se), .si(), .so());

//////////////////////////////////////////////////////
// rdma store instructions.
//////////////////////////////////////////////////////

assign  decdp_wr8_inst_c1 =  arbdp_inst_rsvd_c1 & 
                        arbdp_inst_rqtyp_c1[`L2_RQTYP_LO+1] ;

assign  decdp_wr64_inst_c1 =  arbdp_inst_rsvd_c1 & 
                        arbdp_inst_rqtyp_c1[`L2_RQTYP_LO+2] ;

dff_s     #(1)    ff_decdp_wr8_inst_c2     (.din(decdp_wr8_inst_c1),  
        .clk(rclk), .q(decdp_wr8_inst_c2), .se(se), .si(), .so());

dff_s     #(1)    ff_decdp_wr64_inst_c2     (.din(decdp_wr64_inst_c1), 
        .clk(rclk), .q(decdp_wr64_inst_c2), .se(se), .si(), .so());

dff_s     #(1)    ff_decdp_wr64_inst_c2_1     (.din(decdp_wr64_inst_c1), 
        .clk(rclk), .q(decdp_wr64_inst_c2_1), .se(se), .si(), .so());



 //////////////////////////////////////////////////////
 // rdma ld instruction
 //////////////////////////////////////////////////////

assign decdp_ld64_inst_c1 = arbdp_inst_rsvd_c1 &
                        arbdp_inst_rqtyp_c1[`L2_RQTYP_LO] ;

dff_s  #(1)    ff_decdp_ld64_inst_c1 (.din(decdp_ld64_inst_c1), 
        .clk(rclk), .q(decdp_ld64_inst_c2), .se(se), .si(), .so());




//////////////////////////////////////////////////////
// interrupt access to tagdp via arbctl for disabling tag parity errors.
//////////////////////////////////////////////////////

assign  decdp_inst_int_c1 = ~arbdp_inst_rsvd_c1 &
                            ~arbdp_evict_c1 &
        ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `INT_RQ ) ;

dff_s     #(1)    ff_decdp_inst_int_c2     (.din(decdp_inst_int_c1),
        .clk(rclk), .q(decdp_inst_int_c2), .se(se), .si(), .so());


assign decdp_inst_int_or_inval_c1  = decdp_inst_int_c1 |
                                ( arbdp_inst_bufidhi_c1 &
                                 ~arbdp_inst_fb_c1_qual  &
                                 ~arbdp_inst_rsvd_c1 ) ;


assign arbdp_inst_mb_or_fb_c1 = arbdp_inst_mb_c1 |
                                arbdp_inst_fb_c1_qual ;


//////////////////////////////////////////////////////
 // the following decoded signals are required in vuad dp.
 // *pst with and without ctrue logic
 // *cas1 instruction decode.
 // *cas2 instruction decode.
 //////////////////////////////////////////////////////


 assign decdp_strpst_inst_c1 = ~arbdp_inst_rsvd_c1 &
                                ~arbdp_evict_c1 &
           ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `STRST_RQ) & 
         (( arbdp_word_addr_c1[1:0] != 2'b0 ) | 
         (arbdp_inst_size_c1[`L2_SZ_HI-1:`L2_SZ_LO] != 2'b0)) ;


 // new net created to relieve timing pressure from the
 // arbctl_tagctl_pst_no_ctrue_c2 signal that is used
 // in the way_sel expression inside tagctl.
 // This expr does not need a ~RSVD qualification as that is
 // done inside tagctl.

 assign	wr8_inst_pst_c1 = ~arbdp_evict_c1 & 
				arbdp_inst_rqtyp_c1[`L2_RQTYP_LO+1] & 
	(( arbdp_word_addr_c1[1:0] != 2'b0 ) | // lsb address bits.
         (arbdp_inst_size_c1[`L2_SZ_HI-1:`L2_SZ_LO] != 2'b0)) ;

 assign decdp_rdmapst_inst_c1 = arbdp_inst_rsvd_c1 &
				wr8_inst_pst_c1 ;

 assign	wr8_inst_no_ctrue_c1 = wr8_inst_pst_c1 & ~arbdp_inst_ctrue_c1 ;


 assign  decdp_pst_inst_c1  =   ( ~arbdp_inst_rsvd_c1 &
				  ~( arbdp_ioaddr_c1_39to37[39:37] == 3'h5 ) &
                                ~arbdp_evict_c1 & (
        ( ~arbdp_inst_size_c1[`L2_SZ_HI-1] &
        ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `STORE_RQ ) ) | 
        ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `SWAP_RQ ) ))  | 
                decdp_strpst_inst_c1 | 
                decdp_rdmapst_inst_c1 ; 

 assign decdp_pst_st_c1 = ~arbdp_inst_rsvd_c1 &
                          ~arbdp_evict_c1 &
        ( ~arbdp_inst_size_c1[`L2_SZ_HI-1] &
        ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `STORE_RQ )) ;


 assign pst_no_ctrue_c1 = ( decdp_pst_inst_c1 & 
			~arbdp_inst_ctrue_c1);

 //////////////////////////////////////////////////////////////
 // decdp_st_with_ctrue_c2:
 // This signal is used for generating an ERR packet 
 // for PST 2nd passes that encountered an error during 
 // the first pass.
 // All partial stores ( with the exception of atomic stores )
 // are included in this signal.
 //////////////////////////////////////////////////////////////

   dff_s     #(1)    ff_decdp_pst_inst_c2   (.din(decdp_pst_inst_c1),
        .clk(rclk), .q(decdp_pst_inst_c2), .se(se), .si(), .so());

   dff_s     #(1)    ff_decdp_pst_inst_c3   (.din(decdp_pst_inst_c2),
        .clk(rclk), .q(decdp_pst_inst_c3), .se(se), .si(), .so());

   dff_s     #(1)    ff_decdp_pst_inst_c4   (.din(decdp_pst_inst_c3),
        .clk(rclk), .q(decdp_pst_inst_c4), .se(se), .si(), .so());

   dff_s     #(1)    ff_decdp_pst_inst_c5   (.din(decdp_pst_inst_c4),
        .clk(rclk), .q(decdp_pst_inst_c5), .se(se), .si(), .so());

   dff_s     #(1)    ff_decdp_pst_inst_c6   (.din(decdp_pst_inst_c5),
        .clk(rclk), .q(decdp_pst_inst_c6), .se(se), .si(), .so());

   dff_s     #(1)    ff_decdp_pst_inst_c7   (.din(decdp_pst_inst_c6),
        .clk(rclk), .q(decdp_pst_inst_c7), .se(se), .si(), .so());

 assign st_with_ctrue_c1  = ( decdp_pst_st_c1 | decdp_strpst_inst_c1 |
		decdp_rdmapst_inst_c1  ) & arbdp_inst_ctrue_c1 ;

 dff_s     #(1)    ff_st_no_ctrue_c1   (.din(st_with_ctrue_c1),
        .clk(rclk), .q(decdp_st_with_ctrue_c2), .se(se), .si(), .so());


 assign decdp_cas1_inst_c1 =   ~arbdp_inst_rsvd_c1 &
                                ~arbdp_evict_c1 &
             ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `CAS1_RQ )  ;

 assign decdp_cas1_inst_c1_1 = decdp_cas1_inst_c1;

 assign decdp_cas2_inst_c1 =   ~arbdp_inst_rsvd_c1 &
                                ~arbdp_evict_c1 &
             ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `CAS2_RQ )  ;

 assign decdp_cas2_from_mb_c1 = decdp_cas2_inst_c1 
				& arbdp_inst_mb_c1 ;


 assign decdp_cas2_from_mb_ctrue_c1 = decdp_cas2_from_mb_c1 &
                                        arbdp_inst_ctrue_c1 ;

 assign decdp_cas2_from_xbar_c1 = decdp_cas2_inst_c1 
				& ~arbdp_inst_mb_c1 ;



 //////////////////////////////////////////////////////
 // The following signal indicates that a tecc repair
 // sequence needs to be initiated in arbctl.
 // The appropriate counters need to be initialized.
 //////////////////////////////////////////////////////

 assign arbdp_tecc_inst_c1 = arbdp_tecc_c1 & arbdp_inst_mb_c1;

 dff_s     #(1)    ff_arbdp_pst_no_ctrue_c2_1   (.din(pst_no_ctrue_c1),
        .clk(rclk), .q(arbdp_pst_no_ctrue_c2_1), .se(se), .si(), .so());

 //assign pst_with_ctrue_c1 =  decdp_pst_inst_c1 
			// & arbdp_inst_ctrue_c1 ;

 // It is not necessary to use decdp_pst_inst_c1 
 // Any instruction issued from the miss buffer with ctrue=1 is either 
 // a partial store or a CAS2.
 assign pst_with_ctrue_c1 =  arbdp_inst_mb_c1 
			 & arbdp_inst_ctrue_c1 ;

 assign	arbctl_tagctl_pst_with_ctrue_c1 = pst_with_ctrue_c1 ;


 dff_s     #(1)    ff_arbdp_pst_with_ctrue_c2   (.din(pst_with_ctrue_c1),
        .clk(rclk), .q(arbdp_pst_with_ctrue_c2), .se(se), .si(), .so());

 dff_s     #(1)    ff_arbdp_tagctl_pst_no_ctrue_c2   (.din(pst_no_ctrue_c1),
        .clk(rclk), .q(arbdp_tagctl_pst_no_ctrue_c2), .se(se), .si(), .so());

 dff_s     #(1)    ff_arbdp_mbctl_pst_no_ctrue_c2   (.din(pst_no_ctrue_c1),
        .clk(rclk), .q(arbdp_mbctl_pst_no_ctrue_c2), .se(se), .si(), .so());

 dff_s     #(1)    ff_arbdp_vuadctl_pst_no_ctrue_c2   (.din(pst_no_ctrue_c1),
        .clk(rclk), .q(arbdp_vuadctl_pst_no_ctrue_c2), .se(se), .si(), .so());



 // multiple copies needed due to the loading internally.
 dff_s     #(1)   ff_decdp_cas1_inst_c2 (.din(decdp_cas1_inst_c1), .clk(rclk),
                .q(decdp_cas1_inst_c2), .se(se), .si(), .so());

 dff_s     #(1)   ff_decdp_cas1_inst_c2_1 (.din(decdp_cas1_inst_c1_1), .clk(rclk),
                .q(decdp_cas1_inst_c2_1), .se(se), .si(), .so());


 dff_s     #(1)   ff_decdp_cas2_inst_c2 (.din(decdp_cas2_inst_c1), .clk(rclk),
                .q(decdp_cas2_inst_c2), .se(se), .si(), .so());

 dff_s     #(1)   ff_decdp_cas2_from_mb_c2 
		(.din(decdp_cas2_from_mb_c1), .clk(rclk),
                .q(decdp_cas2_from_mb_c2), .se(se), .si(), .so());

 dff_s     #(1)   ff_decdp_cas2_from_mb_ctrue_c2 
		(.din(decdp_cas2_from_mb_ctrue_c1), .clk(rclk),
                .q(decdp_cas2_from_mb_ctrue_c2), .se(se), .si(), .so());



//////////////////////////////////////////////////////
 // This signal is used for RW bit in the L2_ESR
 // The following Store/Atomic instructions can encounter
 // an error while performing a Read
 // - Partial stores.
 // - LDSTUB/SWAP.
 // - CAS
 // - Streaming Partial stores.
 //////////////////////////////////////////////////////


 assign store_err_c2 = ( decdp_pst_inst_c2 | decdp_cas1_inst_c2_1 )  &
			 arbctl_inst_vld_c2_5 ;

 dff_s     #(1)   ff_store_err_c3 (.din(store_err_c2), .clk(rclk),
                .q(store_err_c3), .se(se), .si(), .so());

 dff_s     #(1)   ff_store_err_c4 (.din(store_err_c3), .clk(rclk),
                .q(store_err_c4), .se(se), .si(), .so());

 dff_s     #(1)   ff_store_err_c5 (.din(store_err_c4), .clk(rclk),
                .q(store_err_c5), .se(se), .si(), .so());

 dff_s     #(1)   ff_store_err_c6 (.din(store_err_c5), .clk(rclk),
                .q(store_err_c6), .se(se), .si(), .so());

 dff_s     #(1)   ff_store_err_c7 (.din(store_err_c6), .clk(rclk),
                .q(store_err_c7), .se(se), .si(), .so());

 dff_s     #(1)   ff_store_err_c8 (.din(store_err_c7), .clk(rclk),
                .q(store_err_c8), .se(se), .si(), .so());

//////////////////////////////////////////////////////
// The following is used in RD./Wr logic in tagctl.
//////////////////////////////////////////////////////
assign decdp_tagctl_wr_c1 =   ( decdp_strst_inst_c1
                                | decdp_st_inst_c1
                                | decdp_wr8_inst_c1 )
                                & ~decdp_pst_inst_c1 ;

//////////////////////////////////////////////////////
// forward req
// used in arbctl to enable store invals for all
// cpus.
//////////////////////////////////////////////////////

assign decdp_fwd_req_c1 = ~arbdp_inst_rsvd_c1 &
                                ~arbdp_evict_c1 &
                ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == 5'b01101 )  ;

dff_s     #(1)   ff_decdp_fwd_req_c2 (.din(decdp_fwd_req_c1), .clk(rclk),
                .q(decdp_fwd_req_c2), .se(se), .si(), .so());


//////////////////////////////////////////////////////
// SWAP/LDSTUB decode
//////////////////////////////////////////////////////

 assign  decdp_swap_inst_c1 = ~arbdp_inst_rsvd_c1 &
                               ~arbdp_evict_c1 &
            ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `SWAP_RQ ) ;

 dff_s     #(1)   ff_decdp_swap_inst_c2 (.din(decdp_swap_inst_c1), .clk(rclk),
                .q(decdp_swap_inst_c2), .se(se), .si(), .so());

 //////////////////////////////////////////////////////
 // IMISS decode
 // Remember to disqualify INVAL instructions.
 //////////////////////////////////////////////////////

  assign  decdp_imiss_inst_c1  =  ~arbdp_inst_rsvd_c1 &
                                  ~arbdp_evict_c1 &
                                ~arbdp_inst_bufidhi_c1 &
       ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `IMISS_RQ ) ;

 dff_s     #(1)   ff_decdp_imiss_inst_c2 (.din(decdp_imiss_inst_c1), 
  .clk(rclk), .q(decdp_imiss_inst_c2), .se(se), .si(), .so());

 //////////////////////////////////////////////////////
 // LD that cams the I$ decode
 // Streaming loads and FWD req loads are not included.
 //////////////////////////////////////////////////////


 assign decdp_camld_inst_c1 = ~arbdp_inst_rsvd_c1 &
                                 ~arbdp_evict_c1 &
                                ~arbdp_inst_bufidhi_c1 &
          ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `LOAD_RQ ) ;

 dff_s     #(1)   ff_decdp_camld_inst_c2 (.din(decdp_camld_inst_c1), 
	.clk(rclk), .q(decdp_camld_inst_c2), .se(se), .si(), .so());


 /////////////////////////////////////////////////////
 // Ld instruction decode for sending a request back
 // with data.
 /////////////////////////////////////////////////////


 assign  decdp_ld_inst_c1  =  ~arbdp_inst_rsvd_c1 &
                                ~arbdp_evict_c1 &
                                ~arbdp_inst_bufidhi_c1 &
          (( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `LOAD_RQ) |
           ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `STRLOAD_RQ) |
           (( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `FWD_RQ) &
                                arbdp_inst_nc_c1 )
          );

 dff_s     #(1)   ff_decdp_ld_inst_c2 (.din(decdp_ld_inst_c1), .clk(rclk),
                .q(decdp_ld_inst_c2), .se(se), .si(), .so());

 /////////////////////////////////////////////////////
 // Prefetch instruction.
 // At this time, the instruction is not qualified
 // so it could be an eviction pass of a prefetch
 // instruction. THe qualification is done in oqctl.
 /////////////////////////////////////////////////////


 assign decdp_pf_inst_c1 = ~arbdp_inst_rsvd_c1 &
                           arbdp_inst_bufid1_c1 &
             ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `LOAD_RQ ) ;

 dff_s     #(1)   ff_decdp_pf_inst_c2 (.din(decdp_pf_inst_c1), .clk(rclk),
                .q(decdp_pf_inst_c2), .se(se), .si(), .so());

 dff_s     #(1)   ff_decdp_pf_inst_c3 (.din(decdp_pf_inst_c2), .clk(rclk),
                .q(decdp_pf_inst_c3), .se(se), .si(), .so());

 dff_s     #(1)   ff_decdp_pf_inst_c4 (.din(decdp_pf_inst_c3), .clk(rclk),
                .q(decdp_pf_inst_c4), .se(se), .si(), .so());

 dff_s     #(1)   ff_decdp_pf_inst_c5 (.din(decdp_pf_inst_c4), .clk(rclk),
                .q(decdp_pf_inst_c5), .se(se), .si(), .so());


 
///////////////////////////////////////////////////////
 // Streaming load indication to oqctl in C6
 // Used in rqtyp logic
 // Note: This is an unqualled instruction and has to
 // be qualified with load hit to be accurate.
 ///////////////////////////////////////////////////////

 assign decdp_strld_inst_c6 = 
	( arbdp_inst_rqtyp_c6[`L2_RQTYP_HI:`L2_RQTYP_LO] == `STRLOAD_RQ) ;

 assign decdp_atm_inst_c6 = ( arbdp_inst_rqtyp_c6[`L2_RQTYP_HI:`L2_RQTYP_LO] == `SWAP_RQ ) |
                            ( arbdp_inst_rqtyp_c6[`L2_RQTYP_HI:`L2_RQTYP_LO] == `CAS1_RQ ) |
                            ( arbdp_inst_rqtyp_c6[`L2_RQTYP_HI:`L2_RQTYP_LO] == `CAS2_RQ ) ;


 //////////////////////////////////////////////////////
 // The following expression is used for word enable generation in
 // tagctl.
 // A store is considered to be a DWORD store under the following
 // conditions:
 // 1) strm store or rdma wr8 with size=0
 // 2) cas2 from mb or a regular store with sz=3
 //////////////////////////////////////////////////////

 assign dword_st_c1 = (( decdp_strst_inst_c1 | decdp_wr8_inst_c1 )  &          // strm or jbi WR8
                       ( arbdp_inst_size_c1[`L2_SZ_HI:`L2_SZ_LO] == 3'b0 )) |        // strm store size=0
                      (( decdp_st_inst_c1 | decdp_cas2_from_mb_c1 ) &
                       (arbdp_inst_size_c1[`L2_SZ_HI-1:`L2_SZ_LO] == 2'b11 ))|  // size=3
                       ( decdp_pst_inst_c1 &  arbdp_inst_ctrue_c1) ;             // pst write  is always a dword write.

 dff_s     #(1)   ff_arbdp_dword_st_c2 (.din(dword_st_c1), .clk(rclk),
                .q(arbdp_dword_st_c2), .se(se), .si(), .so());


 /////////////////////////////////////////////////////
 // INVAL instruction decode to arbctl
 // ~arbdp_inst_c1[`L2_EVICT]  qualification is not necessary
 // as these instructions can only come from the IQ and not
 // from the Miss Buffer.
 /////////////////////////////////////////////////////


 assign decdp_dc_inval_c1 = arbdp_inst_bufidhi_c1 &
                        ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `LOAD_RQ ) &
                                ~arbdp_inst_rsvd_c1 ;

 assign decdp_ic_inval_c1 = arbdp_inst_bufidhi_c1 & 
                    ( arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] == `IMISS_RQ ) &
                                ~arbdp_inst_rsvd_c1 ;

 dff_s     #(1)   ff_decdp_dc_inval_c2 (.din(decdp_dc_inval_c1), .clk(rclk),
                .q(decdp_dc_inval_c2), .se(se), .si(), .so());

 dff_s     #(1)   ff_decdp_ic_inval_c2 (.din(decdp_ic_inval_c1), .clk(rclk),
                .q(decdp_ic_inval_c2), .se(se), .si(), .so());

 
 //////////////////////////////////////////////////////////////////////////
 // Stall logic.( logic is in sctag_arbctl but some of the
 //             components are calculated here ).
 // The following instructions/events cause the C1 instruction in
 // the pipe to be stalled.
 // * evictions.        (2 cycle stall )
 // * Fills.    (2 cycle stall )
 // * Imiss.    (1 cycle stall )
 // * tecc.     (n cycle stall )
 // * diagnostic access.        (data=2, tag=3, vuad=4)
 // * snoop access ( n cycle stall )
 // * SAme col stall
 //
 // The above multicycle stall conditions are detected in C1
 // and so is the same col stall. This is qualfied with
 // arbctl_unstalled_inst_c1.
 // WHen a multicycle instruction is in C2 or beyond, inst_vld_cn is
 // used for qualifying that instruction.
 /////////////////////////////////////////////////////////////////////////////

 assign multi_cyc_op_c1 = arbdp_evict_c1 | // eviction
                        arbdp_inst_fb_c1_qual | // fill instruction
                        decdp_imiss_inst_c1 | // imiss
                        decdp_ic_inval_c1 | // i$ invalidate
                        decdp_dc_inval_c1 | // d$ invalidate
                        arbdp_tecc_c1 | // tecc instruction.
                       arbdp_inst_rsvd_c1 ; // jbi instruction



/////////////////////////////////////////////////////
//PST no ctrue is staged till C8 and then
//qualified with a hit signal to generate the
// write enable  for mb_ctrue.
// The write enable generation is done in arbctl.
// the Ctrue logic is performed in mbctl.
//////////////////////////////////////////////////////

 dff_s     #(1)    ff_pst_no_ctrue_c3   (.din(arbdp_pst_no_ctrue_c2_1),
        .clk(rclk), .q(pst_no_ctrue_c3), .se(se), .si(), .so());

 dff_s     #(1)    ff_pst_no_ctrue_c4   (.din(pst_no_ctrue_c3),
        .clk(rclk), .q(pst_no_ctrue_c4), .se(se), .si(), .so());

 dff_s     #(1)    ff_pst_no_ctrue_c5   (.din(pst_no_ctrue_c4),
        .clk(rclk), .q(pst_no_ctrue_c5), .se(se), .si(), .so());

 dff_s     #(1)    ff_pst_no_ctrue_c6   (.din(pst_no_ctrue_c5),
        .clk(rclk), .q(pst_no_ctrue_c6), .se(se), .si(), .so());

 dff_s     #(1)    ff_pst_no_ctrue_c7   (.din(pst_no_ctrue_c6),
        .clk(rclk), .q(pst_no_ctrue_c7), .se(se), .si(), .so());

 dff_s     #(1)    ff_pst_no_ctrue_c8   (.din(pst_no_ctrue_c7),
        .clk(rclk), .q(arbdp_pst_no_ctrue_c8), .se(se), .si(), .so());


/////////////////////////////////////////////////////
// CAs1 instruction
/////////////////////////////////////////////////////

 dff_s     #(1)    ff_decdp_cas1_inst_c3   (.din(decdp_cas1_inst_c2_1),
        .clk(rclk), .q(decdp_cas1_inst_c3), .se(se), .si(), .so());

 dff_s     #(1)    ff_decdp_cas1_inst_c4   (.din(decdp_cas1_inst_c3),
        .clk(rclk), .q(decdp_cas1_inst_c4), .se(se), .si(), .so());

 dff_s     #(1)    ff_decdp_cas1_inst_c5   (.din(decdp_cas1_inst_c4),
        .clk(rclk), .q(decdp_cas1_inst_c5), .se(se), .si(), .so());

 dff_s     #(1)    ff_decdp_cas1_inst_c6   (.din(decdp_cas1_inst_c5),
        .clk(rclk), .q(decdp_cas1_inst_c6), .se(se), .si(), .so());

 dff_s     #(1)    ff_decdp_cas1_inst_c7   (.din(decdp_cas1_inst_c6),
        .clk(rclk), .q(decdp_cas1_inst_c7), .se(se), .si(), .so());

 dff_s     #(1)    ff_decdp_cas1_inst_c8   (.din(decdp_cas1_inst_c7),
        .clk(rclk), .q(decdp_cas1_inst_c8), .se(se), .si(), .so());



///////////////////////////////////////////////////
// Special store logic. Used to generate byte masks for
// streaming stores and wr8s
///////////////////////////////////////////////////

   dff_s     #(1)    ff_decdp_strpst_inst_c2   (.din(decdp_strpst_inst_c1),
        	.clk(rclk), .q(decdp_strpst_inst_c2), .se(se), .si(), .so());
				
   dff_s     #(1)    ff_decdp_rdmapst_inst_c2   (.din(decdp_rdmapst_inst_c1),
        	.clk(rclk), .q(decdp_rdmapst_inst_c2), .se(se), .si(), .so());

  assign	sp_pst_inst_c2 = ( decdp_strpst_inst_c2 |
			decdp_rdmapst_inst_c2 ) ;

   dff_s     #(1)    ff_sp_pst_inst_c3   (.din(sp_pst_inst_c2),
        	.clk(rclk), .q(sp_pst_inst_c3), .se(se), .si(), .so());

   dff_s     #(1)    ff_sp_pst_inst_c4   (.din(sp_pst_inst_c3),
        	.clk(rclk), .q(sp_pst_inst_c4), .se(se), .si(), .so());

   dff_s     #(1)    ff_sp_pst_inst_c5   (.din(sp_pst_inst_c4),
        	.clk(rclk), .q(sp_pst_inst_c5), .se(se), .si(), .so());

   dff_s     #(1)    ff_sp_pst_inst_c6   (.din(sp_pst_inst_c5),
        	.clk(rclk), .q(sp_pst_inst_c6), .se(se), .si(), .so());

   dff_s     #(1)    ff_sp_pst_inst_c7   (.din(sp_pst_inst_c6),
        	.clk(rclk), .q(sp_pst_inst_c7), .se(se), .si(), .so());


//////////////////////////////////////////////////////
// dbg information sent to dbgdp
// {    JBI instruction
//      Primary request
//      Write ( store, strmstore, wr64, wr8 )
//      Atomic ( cas or swap )
//      cpuid<2:0>,
//      tid   }
//////////////////////////////////////////////////////

assign  prim_req_c3 = ~(arbdp_inst_fb_c3 |
			arbdp_inst_mb_c3 );

assign  write_req_c2 = decdp_strst_inst_c2_1  |
                        decdp_st_inst_c2_1 |
			decdp_wr8_inst_c2 |
			decdp_wr64_inst_c2_1 ;

assign  atomic_req_c2 = ( decdp_swap_inst_c2 |
                        decdp_cas1_inst_c2_1 |
                        decdp_cas2_inst_c2);

dff_s     #(1)    ff_atomic_req_c3     (.din(atomic_req_c2),
        .clk(rclk), .q(atomic_req_c3), .se(se), .si(), .so());

dff_s     #(1)    ff_write_req_c2     (.din(write_req_c2),
        .clk(rclk), .q(write_req_c3), .se(se), .si(), .so());


/////////////////////////////////////////////////////
// TECC instruction in C8 is used by the mbctl
// READY Logic. HEnce, this bit should not be looking
// at only the TECC bit of an instruction but also
// the fact that it got issued out of the MBF
//
// If an eviction packet has tecc_c3==1, the L2 ready bit
// is not set but EVICT_READY is set.
/////////////////////////////////////////////////////

dff_s     #(1)    ff_arbdp_evict_c2   (.din(arbdp_evict_c1),
        .clk(rclk), .q(arbdp_evict_c2), .se(se), .si(), .so());

dff_s     #(1)    ff_arbdp_evict_c3   (.din(arbdp_evict_c2),
        .clk(rclk), .q(arbdp_evict_c3), .se(se), .si(), .so());


assign  arbdp_tecc_inst_mb_c3 = arbdp_inst_tecc_c3 &
                                arbdp_inst_mb_c3  &
				~arbdp_evict_c3 ;

dff_s     #(1)    ff_arbdp_tecc_inst_mb_c4   (.din(arbdp_tecc_inst_mb_c3),
        .clk(rclk), .q(arbdp_tecc_inst_mb_c4), .se(se), .si(), .so());

dff_s     #(1)    ff_arbdp_tecc_inst_mb_c5   (.din(arbdp_tecc_inst_mb_c4),
        .clk(rclk), .q(arbdp_tecc_inst_mb_c5), .se(se), .si(), .so());

dff_s     #(1)    ff_arbdp_tecc_inst_mb_c6   (.din(arbdp_tecc_inst_mb_c5),
        .clk(rclk), .q(arbdp_tecc_inst_mb_c6), .se(se), .si(), .so());

dff_s     #(1)    ff_arbdp_tecc_inst_mb_c7   (.din(arbdp_tecc_inst_mb_c6),
        .clk(rclk), .q(arbdp_tecc_inst_mb_c7), .se(se), .si(), .so());

dff_s     #(1)    ff_arbdp_tecc_inst_mb_c8   (.din(arbdp_tecc_inst_mb_c7),
        .clk(rclk), .q(arbdp_tecc_inst_mb_c8), .se(se), .si(), .so());


				
endmodule













