// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_oqctl.v
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
////////////////////////////////////////////////////////////////////////
// Global header file includes
////////////////////////////////////////////////////////////////////////
`define	ACK_IDLE	0
`define	ACK_WAIT	1
`define	ACK_CCX_REQ	2

`include 	"iop.h"

`include 	"sctag.h"


module sctag_oqctl(/*AUTOARG*/
   // Outputs
   so, sctag_cpx_req_cq, sctag_cpx_atom_cq, oqctl_diag_acc_c8, 
   oqctl_rqtyp_rtn_c7, oqctl_cerr_ack_c7, oqctl_uerr_ack_c7, 
   str_ld_hit_c7, fwd_req_ret_c7, atm_inst_ack_c7, strst_ack_c7, 
   oqctl_int_ack_c7, oqctl_imiss_hit_c8, oqctl_pf_ack_c7, 
   oqctl_rmo_st_c7, oqctl_l2_miss_c7, mux1_sel_data_c7, 
   mux_csr_sel_c7, sel_inval_c7, out_mux1_sel_c7, out_mux2_sel_c7, 
   sel_array_out_l, sel_mux1_c6, sel_mux2_c6, sel_mux3_c6, 
   mux_vec_sel_c6, oqarray_wr_en, oqarray_rd_en, oqarray_wr_ptr, 
   oqarray_rd_ptr, oqctl_arbctl_full_px2, oqctl_st_complete_c7, 
   // Inputs
   arbdp_cpuid_c5, arbdp_int_bcast_c5, decdp_strld_inst_c6, 
   decdp_atm_inst_c6, decdp_pf_inst_c5, arbctl_evict_c5, 
   dirdp_req_vec_c6, tagctl_imiss_hit_c5, tagctl_ld_hit_c5, 
   tagctl_nonmem_comp_c6, tagctl_st_ack_c5, tagctl_strst_ack_c5, 
   tagctl_uerr_ack_c5, tagctl_cerr_ack_c5, tagctl_int_ack_c5, 
   tagctl_st_req_c5, tagctl_fwd_req_ret_c5, sel_rdma_inval_vec_c5, 
   tagctl_rdma_wr_comp_c4, tagctl_store_inst_c5, 
   tagctl_fwd_req_ld_c6, tagctl_rmo_st_ack_c5, tagctl_inst_mb_c5, 
   tagctl_hit_c5, arbctl_inst_l2data_vld_c6, 
   arbctl_inst_l2tag_vld_c6, arbctl_inst_l2vuad_vld_c6, 
   arbctl_csr_rd_en_c7, lkup_bank_ena_dcd_c4, lkup_bank_ena_icd_c4, 
   rst_tri_en, sehold, cpx_sctag_grant_cx, arst_l, grst_l, si, se, 
   rclk
   );


// from arbdecdp
input	[2:0]	arbdp_cpuid_c5; // account for fwd_req cpuid
input		arbdp_int_bcast_c5;
input		decdp_strld_inst_c6;
input		decdp_atm_inst_c6;
input	decdp_pf_inst_c5; // NEW_PIN from arbdec

// from arbctl.
input		arbctl_evict_c5;



input	[7:0]	dirdp_req_vec_c6;

// from tagctl.
input	tagctl_imiss_hit_c5;
input	tagctl_ld_hit_c5;
input	tagctl_nonmem_comp_c6;
input	tagctl_st_ack_c5; 
input	tagctl_strst_ack_c5;
input	tagctl_uerr_ack_c5;
input	tagctl_cerr_ack_c5;
input	tagctl_int_ack_c5;
input	tagctl_st_req_c5;
input	tagctl_fwd_req_ret_c5; // tells oqctl to send a req 2 cycles later.
//input	tagctl_fwd_req_in_c5;
input	sel_rdma_inval_vec_c5;
input	tagctl_rdma_wr_comp_c4;
input	tagctl_store_inst_c5;
input	tagctl_fwd_req_ld_c6;
input	tagctl_rmo_st_ack_c5; // NEW_PIN from tagctl
input	tagctl_inst_mb_c5; //  NEW_PIN  from tagctl.
input	tagctl_hit_c5; // NEW_PIN from tagctl.

// from arbctl.
input   arbctl_inst_l2data_vld_c6;
input   arbctl_inst_l2tag_vld_c6;
input   arbctl_inst_l2vuad_vld_c6;
input	arbctl_csr_rd_en_c7;

input	[3:0]	lkup_bank_ena_dcd_c4;
input	[3:0]	lkup_bank_ena_icd_c4;

input	rst_tri_en;

input   sehold ; // NEW PIN POST_4.2

// from cpx
input	[7:0]	cpx_sctag_grant_cx;

input		arst_l, grst_l;
input		si, se;
input		rclk;

output		so;

// cpx 
output	[7:0]	sctag_cpx_req_cq ;
output		sctag_cpx_atom_cq;

// to oqdp.
output		oqctl_diag_acc_c8;
output	[3:0]	oqctl_rqtyp_rtn_c7;
output		oqctl_cerr_ack_c7 ;
output		oqctl_uerr_ack_c7 ;
output		str_ld_hit_c7;
output		fwd_req_ret_c7;
output		atm_inst_ack_c7;
output		strst_ack_c7;
output		oqctl_int_ack_c7;
output		oqctl_imiss_hit_c8;
output		oqctl_pf_ack_c7; // NEW_PIN to oqdp.
output		oqctl_rmo_st_c7; // NEW_PIN to oqdp
output		oqctl_l2_miss_c7; // NEW_PIN to oqdp


// mux selects to oqdp
output  [3:0]   mux1_sel_data_c7;
output          mux_csr_sel_c7;
output          sel_inval_c7;
output  [2:0]   out_mux1_sel_c7; // sel for mux1 // new_pin POST_3.3 advanced to C7
output  [2:0]   out_mux2_sel_c7; // sel for mux2 // new_pin POST_3.3 advanced to C7
output		sel_array_out_l; // NEW_PIN

// outputs going to dirvec_dp
output  [3:0]   sel_mux1_c6;
output  [3:0]   sel_mux2_c6;
output          sel_mux3_c6;
output  [3:0]   mux_vec_sel_c6;



// to oq array.
output		oqarray_wr_en;
output		oqarray_rd_en;
output	[3:0]	oqarray_wr_ptr;
output	[3:0]	oqarray_rd_ptr;

// to arbctl
output		oqctl_arbctl_full_px2;

// to tagctl
output		oqctl_st_complete_c7;


wire	int_bcast_c5, int_bcast_c6;
wire	[7:0]	dec_cpu_c5, dec_cpu_c6, dec_cpu_c7;
wire	sel_stinv_req_c5, sel_stinv_req_c6;
wire	sel_inv_vec_c5, sel_inv_vec_c6 ;
wire	sel_dec_vec_c5, sel_dec_vec_c5_d1;
wire	sel_dec_vec_c6, sel_dec_vec_c6_d1;
wire	[7:0]	inval_vec_c6;
wire	[3:0]	sel_req_out_c6;
wire	[7:0]   req_out_c6, req_out_c7;
wire	imiss1_out_c6, imiss1_out_c7, imiss1_out_c8;
wire	imiss2_out_c6, imiss2_out_c7;
wire	[7:0]	imiss2_req_vec_c6, imiss2_req_vec_c7;
wire	c6_req_vld, c7_req_vld;
wire	sel_c7_req, sel_c7_req_d1 ;
wire	old_req_vld_d1, oq_count_nonzero_d1;
wire	mux1_sel_c7_req, mux1_sel_dec_vec_c6;
wire	mux1_sel_def_c6, mux1_sel_dec_vec_c7;
wire	imiss1_to_xbar_tmp_c6; 
wire	[7:0]	imiss2_to_xbar_tmp_c6;

wire	mux2_sel_inv_vec_c6;
wire	oq_count_nonzero;
wire	mux3_sel_oq_req;
wire	imiss1_oq_or_pipe;
wire	sel_old_req;
wire	imiss1_to_xbarq_c6, imiss1_to_xbarq_c7;


wire	[7:0]	imiss2_from_oq, imiss2_oq_or_pipe;
wire	[7:0]	req_to_xbarq_c6, req_to_xbarq_c7;
wire	[7:0]	imiss2_to_xbarq_c6, imiss2_to_xbarq_c7;
wire	[7:0]	mux2_req_vec_c6, mux3_req_vec_c6;
wire	[7:0]	mux1_req_vec_c6;

wire	[4:0]	oq_count_p;

wire	[7:0]	bcast_st_req_c6, bcast_inval_req_c6;
wire		bcast_req_c6,bcast_req_c7 ;
wire		bcast_req_pipe;
wire		bcast_req_oq_or_pipe, bcast_to_xbar_c6, bcast_to_xbar_c7;
wire	[7:0]	bcast_req_xbarqfull_c6, req_to_que_in_xbarq_c7;
wire		allow_new_req_bcast, allow_old_req_bcast ;
wire		allow_req_c6, allow_req_c7 ;
wire	[7:0]	que_in_xbarq_c7;
wire		old_req_vld ;

wire	[3:0]	load_ret, stack_ret, imiss_err_or_int_rqtyp_c7 ;
wire	st_req_c6, st_req_c7, int_req_sel_c7 ;
wire	fwd_req_ret_c6 ;
wire	int_ack_c6, int_ack_c7 ;
wire	ld_hit_c6, ld_hit_c7 ;
wire	strld_inst_c7;
wire	atm_inst_c7;
wire	strst_ack_c6 ;
wire	uerr_ack_c6, uerr_ack_c7 ;
wire	cerr_ack_c6, cerr_ack_c7 ;
wire	imiss_req_sel_c7, err_req_sel_c7 ;
wire	sel_evict_vec_c7;
wire	imiss_err_or_int_sel_c7, sel_st_ack_c7, sel_ld_ret_c7;
wire	[3:0]	rqtyp_rtn_c7;

wire	inc_wr_ptr, inc_wr_ptr_d1, inc_rd_ptr, inc_rd_ptr_d1;
wire	[15:0]	wr_word_line, rd_word_line;
wire	[3:0]	enc_wr_ptr, enc_rd_ptr;
wire	[3:0]   enc_wr_ptr_d1, enc_rd_ptr_d1;
wire	[15:0]	wr_ptr, wr_ptr_d1, wr_ptr_lsby1;
wire		wr_ptr0_n, wr_ptr0_n_d1 ;
wire	[15:0]	rd_ptr, rd_ptr_d1, rd_ptr_lsby1;
wire		rd_ptr0_n, rd_ptr0_n_d1 ;

wire	sel_count_inc, sel_count_dec, sel_count_def;
wire	[4:0]	oq_count_plus_1,oq_count_minus_1, oq_count_reset_p ;
wire	[4:0]	oq_count_d1, oq_count_plus_1_d1, oq_count_minus_1_d1;
wire	oqctl_full_px1;


wire    [11:0]   oq0_out;
wire    [11:0]   oq1_out;
wire    [11:0]   oq2_out;
wire    [11:0]   oq3_out;
wire    [11:0]   oq4_out;
wire    [11:0]   oq5_out;
wire    [11:0]   oq6_out;
wire    [11:0]   oq7_out;
wire    [11:0]   oq8_out;
wire    [11:0]   oq9_out;
wire    [11:0]   oq10_out;
wire    [11:0]   oq11_out;
wire    [11:0]   oq12_out;
wire    [11:0]   oq13_out;
wire    [11:0]   oq14_out;
wire    [11:0]   oq15_out;

wire	[7:0]	oq_rd_out;
wire	imiss1_rd_out, imiss2_rd_out;
wire	oq_bcast_out;

wire	[1:0]	xbar0_cnt, xbar0_cnt_p, xbar0_cnt_plus1, xbar0_cnt_minus1;
wire	[1:0]	xbar1_cnt, xbar1_cnt_p, xbar1_cnt_plus1, xbar1_cnt_minus1;
wire	[1:0]	xbar2_cnt, xbar2_cnt_p, xbar2_cnt_plus1, xbar2_cnt_minus1;
wire	[1:0]	xbar3_cnt, xbar3_cnt_p, xbar3_cnt_plus1, xbar3_cnt_minus1;
wire	[1:0]	xbar4_cnt, xbar4_cnt_p, xbar4_cnt_plus1, xbar4_cnt_minus1;
wire	[1:0]	xbar5_cnt, xbar5_cnt_p, xbar5_cnt_plus1, xbar5_cnt_minus1;
wire	[1:0]	xbar6_cnt, xbar6_cnt_p, xbar6_cnt_plus1, xbar6_cnt_minus1;
wire	[1:0]	xbar7_cnt, xbar7_cnt_p, xbar7_cnt_plus1, xbar7_cnt_minus1;
wire	[7:0]	xbarq_full, xbarq_cnt1;

wire    [7:0]   inc_xbar_cnt;
wire    [7:0]   dec_xbar_cnt;
wire    [7:0]   nochange_xbar_cnt;
wire    [7:0]   change_xbar_cnt;


wire    [15:0]  oq_out_bit7,oq_out_bit6,oq_out_bit5,oq_out_bit4;
wire    [15:0]  oq_out_bit3,oq_out_bit2,oq_out_bit1,oq_out_bit0;
wire    [15:0]  imiss1_oq_out;
wire    [15:0]  imiss2_oq_out;
wire    [15:0]  bcast_oq_out ;
wire	[7:0]	evict_inv_vec;

wire	[15:0]	rdma_oq_out;
wire	oq_rdma_out;
wire	rdma_inv_c6, rdma_inv_c7;
wire	rdma_to_xbar_tmp_c6, rdma_oq_or_pipe;
wire	rdma_to_xbarq_c6, rdma_to_xbarq_c7 ;

wire	rdma_wr_comp_c5;
wire	dir_hit_c6 ;
wire	ack_idle_state_in_l, ack_idle_state_l ;
wire	oqctl_st_complete_c6 ;
wire	[2:0]	rdma_state_in, rdma_state;
wire	rdma_req_sent_c7;

wire	oqctl_prev_data_c7;
wire	oqctl_sel_oq_c7;
wire	oqctl_sel_old_req_c7;
wire	oqctl_sel_inval_c6;

wire            store_inst_c6;
wire            store_inst_c7;

wire            diag_data_sel_c7;
wire            diag_tag_sel_c7;
wire            diag_vuad_sel_c7;
wire            diag_lddata_sel_c7;
wire            diag_ldtag_sel_c7;
wire            diag_ldvuad_sel_c7;
wire            diag_lddata_sel_c8;
wire            diag_ldtag_sel_c8;
wire            diag_ldvuad_sel_c8;
wire            diag_def_sel_c7;
wire            diag_def_sel_c8;

wire            fwd_req_vld_ld_c7;

wire            oqctl_sel_inval_c7;

wire            csr_reg_rd_en_c8;


wire            sel_old_data_c7;


wire    [2:0]   cpuid_c5;
wire    [2:0]   inst_cpuid_c6;
wire    [6:0]   dec_cpuid_c6 ;
wire    [6:0]   dec_cpuid_c5;

wire    [3:0]   lkup_bank_ena_dcd_c5;
wire    [3:0]   lkup_bank_ena_icd_c5;

wire    [3:0]   mux_vec_sel_c5;
wire    [3:0]   mux_vec_sel_c6_unqual ;
wire	pf_inst_c6, pf_inst_c7 ;
wire	rmo_st_c6, rmo_st_c7 ;
wire	l2_miss_c5, l2_miss_c6, l2_miss_c7 ;


wire	[3:0]	enc_wr_ptr_d2 ;
wire		inc_wr_ptr_d2;

wire            dbb_rst_l;
wire		inc_rd_ptr_d1_1, inc_rd_ptr_d1_2;
wire	 inc_wr_ptr_d1_1, inc_wr_ptr_d1_2;
wire	st_ack_c6, st_ack_c7;
wire	oq_count_15_p,  oq_count_15_d1;
wire	oq_count_16_p,  oq_count_16_d1;
wire	wr_wl_disable;

///////////////////////////////////////////////////////////////////
 // Reset flop
 ///////////////////////////////////////////////////////////////////

 dffrl_async    #(1)    reset_flop      (.q(dbb_rst_l),
                                        .clk(rclk),
                                        .rst_l(arst_l),
                                        .din(grst_l),
                                        .se(se), .si(), .so());



///////////////////////////////////////////////////////////////////////////
// Request vector generation.
// The CPUs need to be either invalidated or acknowledged for actions that
// happen in the L2 $. Most of these actions are caused by cpu requests to 
// the L2. However, evictions and disrupting errors are independent of 
// requests coming from the CPU and form a portion of the requests going
// to the CPUs
//
// All requests are sent to the CPUs in C7 except requests in response
// to diagnostic accesses which are sent a cycle later.
//
// Request can be generated from an instruction in the pipe or an older
// request.  The request vector is generated in C6 The request vector is generated in C6.
// The 4 sources of requests in the following logic are as follows:
// * Request in pipe
// * delayed ( 1cycle ) Request in pipe
// * Request from the OQ.
// * Request that was selected from the above  3 sources but
//   was not able to send to the xbar because of a xbar fulll condition
//
///////////////////////////////////////////////////////////////////////////




assign	int_bcast_c5 = tagctl_int_ack_c5 & arbdp_int_bcast_c5 ;

dff_s   #(1)  ff_int_bcast_c6    ( .din(int_bcast_c5), .clk(rclk),
                    .q(int_bcast_c6), .se(se), .si(), .so());


///////////////
// FWD req responses are now forwarded to the 
// cpu that made the request.
//////////
//
//mux2ds  #(3) mux_cpuid_c5 (.dout(cpu_c5[2:0]),
//                       	.in0(arbdp_cpuid_c5[2:0]), // instr cpu id 
//				.in1(3'b0), // fwd req response alwaya to cpu0
//                       	.sel0(~tagctl_fwd_req_in_c5), // no fwd req
//				.sel1(tagctl_fwd_req_in_c5)); // fwd req
//////////////

assign  dec_cpu_c5[0] = ( arbdp_cpuid_c5[2:0] == 3'd0 ) | int_bcast_c5 ;
assign  dec_cpu_c5[1] = ( arbdp_cpuid_c5[2:0] == 3'd1 ) | int_bcast_c5 ;
assign  dec_cpu_c5[2] = ( arbdp_cpuid_c5[2:0] == 3'd2 ) | int_bcast_c5 ;
assign  dec_cpu_c5[3] = ( arbdp_cpuid_c5[2:0] == 3'd3 ) | int_bcast_c5 ;
assign  dec_cpu_c5[4] = ( arbdp_cpuid_c5[2:0] == 3'd4 ) | int_bcast_c5 ;
assign  dec_cpu_c5[5] = ( arbdp_cpuid_c5[2:0] == 3'd5 ) | int_bcast_c5 ;
assign  dec_cpu_c5[6] = ( arbdp_cpuid_c5[2:0] == 3'd6 ) | int_bcast_c5 ;
assign  dec_cpu_c5[7] = ( arbdp_cpuid_c5[2:0] == 3'd7 ) | int_bcast_c5 ;

dff_s   #(8)  ff_dec_cpu_c6    ( .din(dec_cpu_c5[7:0]), .clk(rclk),
                    .q(dec_cpu_c6[7:0]), .se(se), .si(), .so());
dff_s   #(8)  ff_dec_cpu_c7    ( .din(dec_cpu_c6[7:0]), .clk(rclk),
                    .q(dec_cpu_c7[7:0]), .se(se), .si(), .so());


// select the req vec for the instruction in C6 for a diagnostic
// access or a CSR instruction store completion.

assign	sel_dec_vec_c6 = tagctl_nonmem_comp_c6;

dff_s   #(1)  ff_sel_dec_vec_c7    ( .din(sel_dec_vec_c6), .clk(rclk),
                    	.q(sel_dec_vec_c6_d1), .se(se), .si(), .so());

dff_s   #(1)  ff_diag_acc_c8    ( .din(sel_dec_vec_c6_d1), .clk(rclk),
         		.q(oqctl_diag_acc_c8), .se(se), .si(), .so());



assign	sel_stinv_req_c5 = ( tagctl_st_ack_c5 
			| tagctl_strst_ack_c5 )   ;

dff_s   #(1)  ff_sel_stinv_req_c6    ( .din(sel_stinv_req_c5), .clk(rclk),
                    .q(sel_stinv_req_c6), .se(se), .si(), .so());

assign	sel_inv_vec_c5 =  ( arbctl_evict_c5 | sel_rdma_inval_vec_c5 ) ;

dff_s   #(1)  ff_sel_inv_vec_c6    ( .din(sel_inv_vec_c5), .clk(rclk),
                    .q(sel_inv_vec_c6), .se(se), .si(), .so());

assign	sel_dec_vec_c5 = ( tagctl_imiss_hit_c5 | 
			tagctl_ld_hit_c5 |
			tagctl_uerr_ack_c5 |
			tagctl_cerr_ack_c5 |
			tagctl_int_ack_c5 )  ;

dff_s   #(1)  ff_sel_dec_vec_c5_d1    ( .din(sel_dec_vec_c5), .clk(rclk),
                    .q(sel_dec_vec_c5_d1), .se(se), .si(), .so());


// invalidate/stack vector
assign	inval_vec_c6 = ( dirdp_req_vec_c6 |
                ( dec_cpu_c6 & 
		{8{sel_stinv_req_c6}} ) ) ;


assign	sel_req_out_c6[0] = sel_dec_vec_c5_d1 ;
assign	sel_req_out_c6[1] = sel_dec_vec_c6_d1 & ~sel_dec_vec_c5_d1 ;
assign	sel_req_out_c6[2] = ( sel_stinv_req_c6 | sel_inv_vec_c6 )  & ~sel_dec_vec_c5_d1 &
				~sel_dec_vec_c6_d1 ;
assign	sel_req_out_c6[3] = ~( sel_stinv_req_c6 | 
				sel_inv_vec_c6 |
				sel_dec_vec_c5_d1 |
				sel_dec_vec_c6_d1 ) ;


// pipeline request C6
mux4ds #(8) mux_req_out_c6 ( .dout (req_out_c6[7:0]),
                  	.in0(dec_cpu_c6[7:0]), 
			.in1(dec_cpu_c7[7:0]),
                  	.in2(inval_vec_c6[7:0]), 
			.in3(8'b0),
                  	.sel0(sel_req_out_c6[0]), 
			.sel1(sel_req_out_c6[1]),
                  	.sel2(sel_req_out_c6[2]), 
			.sel3(sel_req_out_c6[3]));

dff_s   #(8)  ff_req_out_c7 ( .din(req_out_c6[7:0]), .clk(rclk),
           	.q(req_out_c7[7:0]), .se(se), .si(), .so());


// imiss 1 request C6.

dff_s   #(1)  ff_imiss1_out_c6    ( .din(tagctl_imiss_hit_c5), .clk(rclk),
                    .q(imiss1_out_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_imiss1_out_c7    ( .din(imiss1_out_c6), .clk(rclk),
                 .q(imiss1_out_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_imiss1_out_c8    ( .din(imiss1_out_c7), .clk(rclk),
                 .q(imiss1_out_c8), .se(se), .si(), .so());

assign	oqctl_imiss_hit_c8 = imiss1_out_c8 ;

assign	imiss2_out_c6 = imiss1_out_c7;
assign	imiss2_out_c7 = imiss1_out_c8;

assign  imiss2_req_vec_c6 = {8{imiss2_out_c6}} & req_out_c7 ;

dff_s   #(8)  ff_imiss2_req_vec_c7( .din(imiss2_req_vec_c6[7:0]), .clk(rclk),
               .q(imiss2_req_vec_c7[7:0]), .se(se), .si(), .so());


//////////////////////
// A request in the pipe is valid under the following conditions.
//  -dir inval vec is non-zero for an eviction
//  -an imiss 2nd packet is in C7
//  -all conditions that cause assertion of sel_dec_vec_c5_d1
//  -all conditions that cause the assertion of sel_dec_vec_c6_d1
//
// A delayed pipe( by 1 cycle ) request is selected 
// over an incomping pipe request in Cycle T
// if the pipe request is cycle T-1 was overruled due
// to higher priority requests.
//////////////////////

assign	evict_inv_vec = {8{sel_inv_vec_c6}} & dirdp_req_vec_c6 ;

assign	c6_req_vld  = |( evict_inv_vec | imiss2_req_vec_c6 ) |
			sel_dec_vec_c5_d1 | 
			sel_stinv_req_c6 | 
			sel_dec_vec_c6_d1 ;
				
dff_s   #(1)  ff_c6_req_vld    ( .din(c6_req_vld), .clk(rclk),
                 .q(c7_req_vld), .se(se), .si(), .so());

assign  sel_c7_req = c7_req_vld & ( sel_c7_req_d1 |// selected delayed pipe req
                old_req_vld_d1 | 	// selected existing req to xbar
		oq_count_nonzero_d1) ; // selected from OQ.

dff_s   #(1)  ff_sel_c7_req_d1   (.din(sel_c7_req), .clk(rclk),
                .q(sel_c7_req_d1), .se(se), .si(), .so());




//////////////////////////
// request Mux1.
// Select between the following
// request sources -
// - delayed pipe req
// - c6 pipe req
// - c7 pipe req
// - default.
//
// A delayed pipe request has the
// highest priority.
//////////////////////////
assign mux1_sel_c7_req = sel_c7_req  ;

assign mux1_sel_dec_vec_c6 =  sel_dec_vec_c5_d1  & ~sel_c7_req;
assign mux1_sel_dec_vec_c7 =  sel_dec_vec_c6_d1 &
				~sel_dec_vec_c5_d1 &
				~sel_c7_req ;

assign	mux1_sel_def_c6 = ~( sel_dec_vec_c5_d1 |
			  sel_dec_vec_c6_d1 ) &
			  ~sel_c7_req ;
				

mux4ds #(8) mux_mux1_req_vec_c6 ( .dout (mux1_req_vec_c6[7:0]),
             		.in0(req_out_c7[7:0]), 
			.in1(dec_cpu_c6[7:0]),
               		.in2(dec_cpu_c7[7:0]), 
			.in3(8'b0),
               		.sel0(mux1_sel_c7_req), 
			.sel1(mux1_sel_dec_vec_c6),
               		.sel2(mux1_sel_dec_vec_c7), 
			.sel3(mux1_sel_def_c6));


mux2ds  #(1) mux_mux1_imiss1_c6 (.dout(imiss1_to_xbar_tmp_c6),
                       	.in0(imiss1_out_c6),
			.in1(imiss1_out_c7),
                       	.sel0(~sel_c7_req),
			.sel1(sel_c7_req));

mux2ds  #(8) mux_mux1_imiss2_c6 (.dout(imiss2_to_xbar_tmp_c6[7:0]),
                       	.in0(imiss2_req_vec_c6[7:0]),
			.in1(imiss2_req_vec_c7[7:0]),
                       	.sel0(~sel_c7_req),
			.sel1(sel_c7_req));

assign	rdma_inv_c6 = rdma_state[`ACK_WAIT] &  |( dirdp_req_vec_c6 );

dff_s   #(1)  ff_rdma_inv_c7 ( .din(rdma_inv_c6), .clk(rclk),
                   .q(rdma_inv_c7), .se(se), .si(),.so());

mux2ds  #(1) mux_mux1_rdma_c6 (.dout(rdma_to_xbar_tmp_c6),
                       	.in0(rdma_inv_c6),
			.in1(rdma_inv_c7),
                       	.sel0(~sel_c7_req),
			.sel1(sel_c7_req));

//////////////////////////
// request Mux2.
// Select between the following
// - Mux1 request
// - invalidation/ack vector.
//////////////////////////



assign	mux2_sel_inv_vec_c6 = mux1_sel_def_c6 & 
			( sel_stinv_req_c6 | sel_inv_vec_c6 );
				

mux2ds #(8) mux_mux2_req_c6 ( .dout (mux2_req_vec_c6[7:0]),
                   	.in0(mux1_req_vec_c6[7:0]), 
			.in1(inval_vec_c6[7:0]),
                   	.sel0(~mux2_sel_inv_vec_c6), 
			.sel1(mux2_sel_inv_vec_c6)) ;

//////////////////////////
// request Mux3.
// Select between the following
// - Mux2 request
// - Oq request.
// OQ request has priority
//////////////////////////



assign  mux3_sel_oq_req = dbb_rst_l & oq_count_nonzero;

mux2ds #(8) mux_mux3_req_vec_c6 ( .dout (mux3_req_vec_c6[7:0]),
                	.in0(mux2_req_vec_c6[7:0]), 
		 	.in1(oq_rd_out[7:0]),
           		.sel0(~mux3_sel_oq_req), 
			.sel1(mux3_sel_oq_req));

mux2ds #(1) mux_imiss1_oq_or_pipe ( .dout (imiss1_oq_or_pipe),
                        .in0(imiss1_to_xbar_tmp_c6), 
			.in1(imiss1_rd_out),
                        .sel0(~mux3_sel_oq_req), 
			.sel1(mux3_sel_oq_req));

mux2ds #(1) mux_rdma_oq_or_pipe ( .dout (rdma_oq_or_pipe),
                        .in0(rdma_to_xbar_tmp_c6), 
			.in1(oq_rdma_out),
                        .sel0(~mux3_sel_oq_req), 
			.sel1(mux3_sel_oq_req));

assign  imiss2_from_oq = {8{imiss2_rd_out}} & req_to_xbarq_c7 ;

mux2ds #(8) mux_imiss2_oq_or_pipe ( .dout (imiss2_oq_or_pipe[7:0]),
                  	.in0(imiss2_to_xbar_tmp_c6[7:0]), 
			.in1(imiss2_from_oq[7:0]),
                  	.sel0(~mux3_sel_oq_req), 
			.sel1(mux3_sel_oq_req));




//////////////////////////
// A 2 to 1 mux flop to select
// either the old request 
// or a new one.
//////////////////////////

mux2ds #(8) mux_req_to_xbar_c6 ( .dout (req_to_xbarq_c6[7:0]),
                        .in0(req_to_xbarq_c7[7:0]), 
			.in1(mux3_req_vec_c6[7:0]),
                        .sel0(sel_old_req), 
			.sel1(~sel_old_req));

dff_s   #(8)  ff_xbar_req_c7    (.din(req_to_xbarq_c6[7:0]), .clk(rclk),
                        .q(req_to_xbarq_c7[7:0]), .se(se), .si(), .so());

// use a mux flop here
mux2ds #(1) mux_imiss1_to_xbar_c6 ( .dout (imiss1_to_xbarq_c6),
                        .in0(imiss1_to_xbarq_c7), 
			.in1(imiss1_oq_or_pipe),
                        .sel0(sel_old_req), 
			.sel1(~sel_old_req));

dff_s   #(1)  ff_imiss1_to_xbarq_c7 ( .din(imiss1_to_xbarq_c6), .clk(rclk),
                        .q(imiss1_to_xbarq_c7), .se(se), .si(),.so());


// use a mux flop here
mux2ds #(1) mux_rdma_to_xbar_c6 ( .dout (rdma_to_xbarq_c6),
                        .in0(rdma_to_xbarq_c7), 
			.in1(rdma_oq_or_pipe),
                        .sel0(sel_old_req), 
			.sel1(~sel_old_req));

dff_s   #(1)  ff_rdma_to_xbarq_c7 ( .din(rdma_to_xbarq_c6), .clk(rclk),
                        .q(rdma_to_xbarq_c7), .se(se), .si(),.so());

// use a mux flop here
mux2ds #(8) mux_imiss2_to_xbar_c6 ( .dout (imiss2_to_xbarq_c6[7:0]),
                        .in0(imiss2_to_xbarq_c7[7:0]), 
			.in1(imiss2_oq_or_pipe[7:0]),
                        .sel0(sel_old_req), 
			.sel1(~sel_old_req));

dff_s   #(8)  ff_imiss2_to_xbarq_c7    ( .din(imiss2_to_xbarq_c6[7:0]), .clk(rclk),
                        .q(imiss2_to_xbarq_c7[7:0]), .se(se), .si(), .so());


///////////////////////////////////////////////////////////////////////////
// For TSO it is essential that a multicast request be queued up in all
// Xbar Qs at the same time. In order for this to happen, a request that 
// is multicast will have to wait for all destination Xbar Qs to be 
// available.
//
// The following requests are multicast requests.
// - eviction requests ( that go to atleast one cpu ).
// - interrupt broadcasts
// - store invalidates ( that go to more than one cpu ).
///////////////////////////////////////////////////////////////////////////


assign  bcast_st_req_c6 = {8{sel_stinv_req_c6}} & ~dec_cpu_c6  ;
assign  bcast_inval_req_c6  =  {8{sel_inv_vec_c6}}  ;

assign  bcast_req_c6 =  int_bcast_c6 |
        	(|( ( bcast_st_req_c6 | bcast_inval_req_c6) 
		& dirdp_req_vec_c6 ) )  ;

dff_s   #(1)  ff_bcast_req_c6    ( .din(bcast_req_c6), .clk(rclk),
               .q(bcast_req_c7), .se(se), .si(), .so());


mux2ds  #(1) mux_bcast_req_pipe (.dout(bcast_req_pipe),
                                .in0(bcast_req_c7),.in1(bcast_req_c6),
                                .sel0(sel_c7_req),.sel1(~sel_c7_req));

mux2ds  #(1) mux_bcast_req_oq_or_pipe ( .dout( bcast_req_oq_or_pipe),
                        .in0(bcast_req_pipe),.in1(oq_bcast_out),
                        .sel0(~oq_count_nonzero),.sel1(oq_count_nonzero));

// use a mux flop here
mux2ds #(1) mux_bcast_to_xbar_c6 ( .dout (bcast_to_xbar_c6),
                         .in0(bcast_to_xbar_c7), .in1(bcast_req_oq_or_pipe),
                         .sel0(sel_old_req), .sel1(~sel_old_req));

dff_s   #(1)  ff_bcast_to_xbar_c7    ( .din(bcast_to_xbar_c6), .clk(rclk),
                        .q(bcast_to_xbar_c7), .se(se), .si(),.so());


////////////////////////
// logic for disallowing a request from transmitting.
//
// A request that is in the pipe will be gated off  
// if:
// - xbar is full or 
// - xbar=1 and incrementing in that cycle.
// 
// Request that has already made it to the output
// of the request muxes will be gate off if
// - xbar is full.
////////////////////////



assign  bcast_req_xbarqfull_c6 = ( xbarq_full 
			| ( xbarq_cnt1 & que_in_xbarq_c7 ) );


assign  allow_new_req_bcast = (&( ~mux3_req_vec_c6 | 
				~bcast_req_xbarqfull_c6 )) |
                                ~bcast_req_oq_or_pipe ;

assign  allow_old_req_bcast =   (&( ~req_to_que_in_xbarq_c7 | 
					~xbarq_full )) |
                                        ~bcast_to_xbar_c7 ;



// use a mux flop here
mux2ds #(1) mux_allow_req_c6 ( .dout (allow_req_c6),
                         .in0(allow_old_req_bcast), .in1(allow_new_req_bcast),
                         .sel0(sel_old_req), .sel1(~sel_old_req));

dff_s   #(1)  ff_allow_req_c7    ( .din(allow_req_c6), .clk(rclk),
                        .q(allow_req_c7), .se(se), .si(),.so());

assign  req_to_que_in_xbarq_c7 = ( req_to_xbarq_c7  | imiss2_to_xbarq_c7)  ;

assign  que_in_xbarq_c7 =   req_to_que_in_xbarq_c7 & {8{allow_req_c7}};

assign  old_req_vld = |( req_to_que_in_xbarq_c7 & xbarq_full & 
			~cpx_sctag_grant_cx ) |
                        ~allow_req_c7 ;

assign  sel_old_req = dbb_rst_l & old_req_vld ;


assign	sctag_cpx_req_cq = req_to_xbarq_c7 & {8{allow_req_c7}};
assign	sctag_cpx_atom_cq = imiss1_to_xbarq_c7 ;



///////////////////////////////////////////////////////////
// RQTYP and other signals sent to oqdp
// RQTYP is generated using several stages of muxing as follows:
// 1. mux between st ack and fwd reply
// 2. mux between ld ret and fwd reply
// 3. mux between int_ack, imiss_ret and err_ack
// 4. mux between mux1, mux2 and mux3 outputs and eviction_ret.
// 5. If an ack is a strm load or strm store ret, then the streaming
//    bit of the request type is set.
//
// The request type logic is performed in C7.
///////////////////////////////////////////////////////////

dff_s   #(1)  ff_fwd_req_ret_c6    ( .din(tagctl_fwd_req_ret_c5), .clk(rclk),
                    .q(fwd_req_ret_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_fwd_req_ret_c7    ( .din(fwd_req_ret_c6), .clk(rclk),
                    .q(fwd_req_ret_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_int_ack_c6    ( .din(tagctl_int_ack_c5), .clk(rclk),
                    .q(int_ack_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_int_ack_c7    ( .din(int_ack_c6), .clk(rclk),
                    .q(int_ack_c7), .se(se), .si(), .so());

assign	oqctl_int_ack_c7 = int_ack_c7;

dff_s   #(1)  ff_ld_hit_c6    ( .din(tagctl_ld_hit_c5), .clk(rclk),
                    .q(ld_hit_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_ld_hit_c7    ( .din(ld_hit_c6), .clk(rclk),
                    .q(ld_hit_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_st_req_c6    ( .din(tagctl_st_req_c5), .clk(rclk),
                    .q(st_req_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_st_req_c7    ( .din(st_req_c6), .clk(rclk),
                    .q(st_req_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_strst_ack_c6    ( .din(tagctl_strst_ack_c5), .clk(rclk),
                    .q(strst_ack_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_strst_ack_c7    ( .din(strst_ack_c6), .clk(rclk),
                    .q(strst_ack_c7), .se(se), .si(), .so());


// RMO store ACK.

dff_s   #(1)  ff_rmo_st_c6    ( .din(tagctl_rmo_st_ack_c5), .clk(rclk),
                    .q(rmo_st_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_rmo_st_c7    ( .din(rmo_st_c6), .clk(rclk),
                    .q(rmo_st_c7), .se(se), .si(), .so());

assign	oqctl_rmo_st_c7 = rmo_st_c7 ;



dff_s   #(1)  ff_sel_inv_vec_c7    ( .din(sel_inv_vec_c6), .clk(rclk),
                    .q(sel_evict_vec_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_uerr_ack_c6    ( .din(tagctl_uerr_ack_c5), .clk(rclk),
                    .q(uerr_ack_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_uerr_ack_c7    ( .din(uerr_ack_c6), .clk(rclk),
                    .q(uerr_ack_c7), .se(se), .si(), .so());


assign	oqctl_uerr_ack_c7 = uerr_ack_c7 ;

dff_s   #(1)  ff_st_ack_c6    ( .din(tagctl_st_ack_c5), .clk(rclk),
                    .q(st_ack_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_st_ack_c7    ( .din(st_ack_c6), .clk(rclk),
                    .q(st_ack_c7), .se(se), .si(), .so());


dff_s   #(1)  ff_cerr_ack_c6    ( .din(tagctl_cerr_ack_c5), .clk(rclk),
                    .q(cerr_ack_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_cerr_ack_c7    ( .din(cerr_ack_c6), .clk(rclk),
                    .q(cerr_ack_c7), .se(se), .si(), .so());

assign	oqctl_cerr_ack_c7 = cerr_ack_c7 ;

dff_s   #(1)  ff_strld_inst_c7    ( .din(decdp_strld_inst_c6), .clk(rclk),
                    .q(strld_inst_c7), .se(se), .si(), .so());

dff_s   #(1)  ff_atm_inst_c7    ( .din(decdp_atm_inst_c6), .clk(rclk),
                    .q(atm_inst_c7), .se(se), .si(), .so());



////////////////////////////////////////////////////////
// L2 miss is reported for LDs, IMIsses(1st pckt only )
// and stores. In all these cases, a miss is reported
// - if the instruction is issued from the miss Buffer
// - or if a st ack is sent for an instruction missing the
// L2.
////////////////////////////////////////////////////////

assign	l2_miss_c5 =  (tagctl_inst_mb_c5 & 
			( tagctl_st_ack_c5 | 
			tagctl_ld_hit_c5 |
			tagctl_imiss_hit_c5 )) |
			( ~tagctl_hit_c5 & 
			  tagctl_st_ack_c5 );
			

dff_s   #(1)  ff_l2_miss_c6    ( .din(l2_miss_c5), .clk(rclk),
                    .q(l2_miss_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_l2_miss_c7    ( .din(l2_miss_c6), .clk(rclk),
                    .q(l2_miss_c7), .se(se), .si(), .so());

assign	oqctl_l2_miss_c7 = l2_miss_c7 ;

/////////////////////////////////////////
// A prefetch instruction has a "LOAD"
// opcode . Used to set bit 128 of the CPX
// packet 
/////////////////////////////////////////

dff_s   #(1)  ff_pf_inst_c6    ( .din(decdp_pf_inst_c5), .clk(rclk),
                    .q(pf_inst_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_pf_inst_c7    ( .din(pf_inst_c6), .clk(rclk),
                    .q(pf_inst_c7), .se(se), .si(), .so());

assign	 oqctl_pf_ack_c7 = pf_inst_c7 & ld_hit_c7 ;


mux2ds #(4) mux_load_ret ( .dout (load_ret[3:0]),
                        .in0(`LOAD_RET), 
			.in1(`FWD_RPY_RET),
                        .sel0(~fwd_req_ret_c7), 
			.sel1(fwd_req_ret_c7));

mux2ds #(4) mux_stack_ret ( .dout (stack_ret[3:0]),
                        .in0(`ST_ACK), 
			.in1(`FWD_RPY_RET),
                        .sel0(~fwd_req_ret_c7), 
			.sel1(fwd_req_ret_c7));


assign	imiss_req_sel_c7 = imiss1_out_c7 | imiss1_out_c8 ;
assign	err_req_sel_c7 = ( ~imiss_req_sel_c7 & ~int_ack_c7 );
assign	int_req_sel_c7 =  int_ack_c7 & ~imiss_req_sel_c7 ;

mux3ds #(4) mux_imiss_err_or_intreq_c5 ( .dout (imiss_err_or_int_rqtyp_c7[3:0]),
                          	.in0(`IFILL_RET), 
				.in1(`INT_RET),
                          	.in2(`ERR_RET),
                          	.sel0(imiss_req_sel_c7), 
				.sel1(int_req_sel_c7),
                          	.sel2(err_req_sel_c7));

assign  imiss_err_or_int_sel_c7 = ( imiss_req_sel_c7 | int_ack_c7 |
                                 uerr_ack_c7 | cerr_ack_c7) & 
				~sel_evict_vec_c7 ; // no eviction

assign	sel_st_ack_c7 = ( st_req_c7 | strst_ack_c7 ) & 
			~imiss_err_or_int_sel_c7 
			& ~sel_evict_vec_c7 ;

assign	sel_ld_ret_c7 = ~imiss_err_or_int_sel_c7 & ~sel_st_ack_c7 &
			~sel_evict_vec_c7 ;


mux4ds #(4) mux_req_type_c7 ( .dout (rqtyp_rtn_c7[3:0]),
                        .in0(load_ret[3:0]), 	// load return
			.in1(stack_ret[3:0]),	// store ack return
                        .in2(`EVICT_REQ), // evict req
			.in3(imiss_err_or_int_rqtyp_c7[3:0]), //imiss err or int
                        .sel0(sel_ld_ret_c7), 	
			.sel1(sel_st_ack_c7),
                        .sel2(sel_evict_vec_c7), 
			.sel3(imiss_err_or_int_sel_c7));


assign	str_ld_hit_c7 = strld_inst_c7 & ld_hit_c7 ;

assign  oqctl_rqtyp_rtn_c7[3] = rqtyp_rtn_c7[3] ;
assign  oqctl_rqtyp_rtn_c7[2] = rqtyp_rtn_c7[2] ;
assign  oqctl_rqtyp_rtn_c7[1] = rqtyp_rtn_c7[1] | str_ld_hit_c7 | strst_ack_c7 ;
assign  oqctl_rqtyp_rtn_c7[0] = rqtyp_rtn_c7[0] ;


assign	atm_inst_ack_c7 =  ( atm_inst_c7 & ( ld_hit_c7 | st_ack_c7 ) ) | 
				imiss1_out_c8 ;







////////////////////////////////////////////////////////////////////
// Oq counter:  The Oq counter  is a C9 flop. However, the 
// full signal is generated in C8 using the previous value
// of the counter. The full signal is asserted when the 
// counter is 7 or higher. THis means that instructions
// PX2-C8 can be accomodated in the OQ. Here re the pipelines
// for incrementing and decrementing OQ count.
//-----------------------------------------------------------------
//	#1(C7)			#2(C8)		#3		#4
//-----------------------------------------------------------------
//	
//	if the C7 req 
//	is still vld
//	AND ((oq_count!=0 )	inc counter. 
//	 OR old_req_vld ).
//
//	setup wline for		wr_Data into
//	oqarray write.		oqarray
//
//	setup wline for
//	req Q write.
//	
//	req Q write.
//-----------------------------------------------------------------
//	#1			#2			#3
//-----------------------------------------------------------------
//  	inc rd pointer
//	if ~oldreq		dec counter		send to CPX
//	and if oq_count
//	non_zero		rd data
//				from array
//	setup wline
//	for reading next
//	entry.(earliest
//	issue out of
//	OQ is in C10)
//
////////////////////////////////////////////////////////////////////


////////////////////
// Wr Pointer
////////////////////


assign  inc_wr_ptr = sel_c7_req 
		& (oq_count_nonzero | old_req_vld) ;

// use a big flop that has a fanout of 16 so that the 
// output of the flop can be used directly to mux out
// the wr ptr
dffrl_s   #(1)  ff_inc_wr_ptr_d1    ( .din(inc_wr_ptr), .clk(rclk),
		  .rst_l(dbb_rst_l),
                  .q(inc_wr_ptr_d1), .se(se), .si(), .so());

dffrl_s   #(1)  ff_inc_wr_ptr_d1_1    ( .din(inc_wr_ptr), .clk(rclk),
		  .rst_l(dbb_rst_l),
                  .q(inc_wr_ptr_d1_1), .se(se), .si(), .so());

dffrl_s   #(1)  ff_inc_wr_ptr_d1_2    ( .din(inc_wr_ptr), .clk(rclk),
		  .rst_l(dbb_rst_l),
                  .q(inc_wr_ptr_d1_2), .se(se), .si(), .so());


assign  oqarray_wr_en = inc_wr_ptr_d1 ; // wen for array write

assign	wr_word_line  = wr_ptr & {16{~wr_wl_disable}} ; // wline for req Q write.

assign  enc_wr_ptr[0] = ( wr_ptr[1] | wr_ptr[3] | wr_ptr[5] |
                         wr_ptr[7] | wr_ptr[9] | wr_ptr[11] |
                         wr_ptr[13] | wr_ptr[15] ) ;

assign  enc_wr_ptr[1] = ( wr_ptr[2] | wr_ptr[3] | wr_ptr[6] |
                          wr_ptr[7] | wr_ptr[10] | wr_ptr[11] |
                          wr_ptr[14] | wr_ptr[15] ) ;

assign  enc_wr_ptr[2] = ( wr_ptr[4] | wr_ptr[5] | wr_ptr[6] |
                          wr_ptr[7] | wr_ptr[12] | wr_ptr[13] |
                          wr_ptr[14] | wr_ptr[15] ) ;

assign  enc_wr_ptr[3] = ( wr_ptr[8] | wr_ptr[9] | wr_ptr[10] |
                          wr_ptr[11] | wr_ptr[12] | wr_ptr[13] |
                          wr_ptr[14] | wr_ptr[15] ) ;

dff_s   #(4)  ff_enc_wr_ptr_d1    ( .din(enc_wr_ptr[3:0]), .clk(rclk),
                  .q(enc_wr_ptr_d1[3:0]), .se(se), .si(), .so());





assign  oqarray_wr_ptr  = enc_wr_ptr_d1 ; // write wline for array


assign  wr_ptr_lsby1 = { wr_ptr_d1[14:0], wr_ptr_d1[15] } ;

mux2ds #(16) mux_wr_ptr ( .dout (wr_ptr[15:0]), // used for FIFO write
                        .in0(wr_ptr_lsby1[15:0]), // advanced
			.in1(wr_ptr_d1[15:0]), // same
                        .sel0(inc_wr_ptr_d1_1),  // sel advance
			.sel1(~inc_wr_ptr_d1_1));


dffrl_s   #(15)  ff_wr_ptr15to1_d1    ( .din(wr_ptr[15:1]), .clk(rclk),
        .rst_l(dbb_rst_l), .q(wr_ptr_d1[15:1]), .se(se), .si(), .so());

assign	wr_ptr0_n = ~wr_ptr[0];

dffrl_s   #(1)  ff_wr_ptr0_d1    ( .din(wr_ptr0_n), .clk(rclk),
        .rst_l(dbb_rst_l), .q(wr_ptr0_n_d1), .se(se), .si(), .so());

assign	wr_ptr_d1[0] = ~wr_ptr0_n_d1;

////////////////////
// Rd Pointer
////////////////////

assign  inc_rd_ptr = oq_count_nonzero & ~old_req_vld ;

dffrl_s   #(1)  ff_inc_rd_ptr_d1    ( .din(inc_rd_ptr), .clk(rclk),
		 .rst_l(dbb_rst_l),
                 .q(inc_rd_ptr_d1), .se(se), .si(), .so());

dffrl_s   #(1)  ff_inc_rd_ptr_d1_1    ( .din(inc_rd_ptr), .clk(rclk),
		 .rst_l(dbb_rst_l),
                 .q(inc_rd_ptr_d1_1), .se(se), .si(), .so());

dffrl_s   #(1)  ff_inc_rd_ptr_d1_2    ( .din(inc_rd_ptr), .clk(rclk),
		 .rst_l(dbb_rst_l),
                 .q(inc_rd_ptr_d1_2), .se(se), .si(), .so());




assign  oqarray_rd_en =  oq_count_nonzero; // array rd enable


assign	rd_word_line    =  rd_ptr ; // wline for req Q read


assign  enc_rd_ptr[0] = ( rd_ptr[1] | rd_ptr[3] | rd_ptr[5] |
                          rd_ptr[7] | rd_ptr[9] | rd_ptr[11] |
                          rd_ptr[13] | rd_ptr[15] ) ;

assign  enc_rd_ptr[1] = ( rd_ptr[2] | rd_ptr[3] | rd_ptr[6] |
                          rd_ptr[7] | rd_ptr[10] | rd_ptr[11] |
                          rd_ptr[14] | rd_ptr[15] ) ;

assign  enc_rd_ptr[2] = ( rd_ptr[4] | rd_ptr[5] | rd_ptr[6] |
                          rd_ptr[7] | rd_ptr[12] | rd_ptr[13] |
                          rd_ptr[14] | rd_ptr[15] ) ;

assign  enc_rd_ptr[3] = ( rd_ptr[8] | rd_ptr[9] | rd_ptr[10] |
                          rd_ptr[11] | rd_ptr[12] | rd_ptr[13] |
                          rd_ptr[14] | rd_ptr[15] ) ;

assign  oqarray_rd_ptr = enc_rd_ptr; // ph1 read 

assign  rd_ptr_lsby1 = { rd_ptr_d1[14:0], rd_ptr_d1[15] } ;

mux2ds #(16) mux_rd_ptr ( .dout (rd_ptr[15:0]),
                    	.in0(rd_ptr_lsby1[15:0]), 
			.in1(rd_ptr_d1[15:0]),
                        .sel0(inc_rd_ptr_d1_1), 
			.sel1(~inc_rd_ptr_d1_1));

dffrl_s   #(15)  ff_rd_ptr15to1_d1    ( .din(rd_ptr[15:1]), .clk(rclk),
        .rst_l(dbb_rst_l), .q(rd_ptr_d1[15:1]), .se(se), .si(), .so());

assign	rd_ptr0_n = ~rd_ptr[0] ;

dffrl_s   #(1)  ff_rd_ptr0_d1    ( .din(rd_ptr0_n), .clk(rclk),
        .rst_l(dbb_rst_l), .q(rd_ptr0_n_d1), .se(se), .si(), .so());

assign	rd_ptr_d1[0] = ~rd_ptr0_n_d1;

//////////////////
// What If????
// Wrptr == Rdptr.
// If the Wr ptr is equal t th eread ptr.
// the array read data is not going to 
// be  correct. In this case, the 
// write data needs to be forwarded to
// the rd data.
//////////////////
dff_s   #(4)  ff_enc_wr_ptr_d2    ( .din(enc_wr_ptr_d1[3:0]), .clk(rclk),
                  .q(enc_wr_ptr_d2[3:0]), .se(se), .si(), .so());

dff_s   #(4)  ff_enc_rd_ptr_d1    ( .din(enc_rd_ptr[3:0]), .clk(rclk),
                  .q(enc_rd_ptr_d1[3:0]), .se(se), .si(), .so());

dff_s   #(1)  ff_inc_wr_ptr_d2    ( .din(inc_wr_ptr_d1), .clk(rclk),
                  .q(inc_wr_ptr_d2), .se(se), .si(), .so());

//////---\/ FIx for macrotest \/---------
// sehold assertion during macrotest will guarantee that
// the array output is always picked.
// /////////////////////////////////////////////////////

assign	sel_array_out_l = (( enc_wr_ptr_d2 == enc_rd_ptr_d1 )  &
				inc_wr_ptr_d2  & 	// WR
				oq_count_nonzero_d1) & 	// RD
				~sehold ;

//////////////////
// OQ counter.
// assert full when 6 or greater.
//
// Bug#4503. The oqcount full assumption is
// wrong. Here is why 
// Currently we assert oq_count_full when the
// counter is 7.
// The case that will cause the worst case skid
// and break the above assumption is as follows.
//-------------------------------------
// cycle #X		cycle #X+1
//-------------------------------------
//
// C8 (~stall if		C9(cnt=6)
//     cnt <= 6)
// C7			C8(7)
// C6			C7(8)
// C5			C6(9)
// C4			C5(10)
// C3			C4(11)
// C2			C3(12)
// C1			C2(13)
// PX2			C1(14 and 15)
// PX1			PX2(16 and 17)
//
//-------------------------------------
// The C1 instruction could be an imiss. that requires 2 slots in the IQ.
// Similarly, the PX2 instruction could be an IMISS/CAS that requires 2 slots.
// This would put the counter at 17. Hence the oq counter full needs to be asserted 
// at 6 or more

//////////////////


assign  sel_count_inc = inc_wr_ptr_d1_2 & ~inc_rd_ptr_d1_2;
assign  sel_count_dec = ~inc_wr_ptr_d1 & inc_rd_ptr_d1 ;
assign  sel_count_def = ~( sel_count_inc | sel_count_dec ) ;

assign  oq_count_plus_1 =  (oq_count_p + 5'b1 )  ;
assign  oq_count_minus_1 = ( oq_count_p - 5'b1 ) ;
assign  oq_count_reset_p = ( oq_count_p );

dffrl_s   #(5)  ff_oq_cnt_d1    ( .din(oq_count_reset_p[4:0]), .clk(rclk),
                  .rst_l(dbb_rst_l),.q(oq_count_d1[4:0]), .se(se), .si(), .so());

dff_s   #(5)  ff_oq_cnt_plus1_d1    ( .din(oq_count_plus_1[4:0]), .clk(rclk),
                  .q(oq_count_plus_1_d1[4:0]), .se(se), .si(), .so());

dff_s   #(5)  ff_oq_cnt_minus1_d1    ( .din(oq_count_minus_1[4:0]), .clk(rclk),
                  .q(oq_count_minus_1_d1[4:0]), .se(se), .si(), .so());

mux3ds #(5) mux_oq_count ( .dout (oq_count_p[4:0]),
                        .in0(oq_count_d1[4:0]), 
			.in1(oq_count_minus_1_d1[4:0]),
                        .in2(oq_count_plus_1_d1[4:0]),
                        .sel0(sel_count_def), 
			.sel1(sel_count_dec),
                        .sel2(sel_count_inc));

assign  oq_count_nonzero = |( oq_count_p) ; 

// Read bug report for Bug # 3352.
// Funtionality to turn OFF the wr_wordline when the 
// counter is at 16 or is going to reach 16 . Since the 
// wr pointer advances with every write, we need to prevent
// a write when the counter is 16 and the pointer has wrapped
// around. 
// Here is pipeline.
//--------------------------------------------------------
// 	X		X+1		X+2
//--------------------------------------------------------
// 1)	cnt_p==15	insert=1	
//			delete=0
//			cnt_p=16	
// 	wr_wline!=0	wr_wline=0;	
//
// 2)	cnt_p==16	if delete=0
//	wr_wline==0	wr_wline=0;
//
//			if delete=1
//			wr_wline!=0;
//--------------------------------------------------------

assign	oq_count_15_p = ( oq_count_p == 5'hf ) ;

dff_s   #(1)  ff_oq_count_15_d1    ( .din(oq_count_15_p), .clk(rclk),
                  .q(oq_count_15_d1), .se(se), .si(), .so());

assign	oq_count_16_p = ( oq_count_p == 5'h10 ) ;

dff_s   #(1)  ff_oq_count_16_d1    ( .din(oq_count_16_p), .clk(rclk),
                  .q(oq_count_16_d1), .se(se), .si(), .so());


assign	wr_wl_disable = ( ( oq_count_15_d1 & sel_count_inc ) |
			( oq_count_16_d1 & ~sel_count_dec ) ) ;

assign	oqctl_full_px1 = ( oq_count_p[2] & oq_count_p[1])  |
			 ( oq_count_p[3] ) |
			 ( oq_count_p[4] ) ;

dff_s   #(1)  ff_oqctl_arbctl_full_px2    ( .din(oqctl_full_px1), .clk(rclk),
                  .q(oqctl_arbctl_full_px2), .se(se), .si(), .so());

////////////////////////////////////////////////////////////////////
// Oqdp mux select generation:
////////////////////////////////////////////////////////////////////

dff_s   #(1)  ff_oq_count_nonzero_d1    (.din(oq_count_nonzero), .clk(rclk),
                              .q(oq_count_nonzero_d1), .se(se), .si(), .so());

dff_s   #(1)  ff_old_req_vld_d1   (.din(old_req_vld), .clk(rclk),
                              .q(old_req_vld_d1), .se(se), .si(), .so());


assign  oqctl_sel_inval_c6 = ( sel_inv_vec_c6 | sel_stinv_req_c6  | int_ack_c6 |
                                mux1_sel_dec_vec_c7  )  ;

assign  oqctl_sel_old_req_c7  = old_req_vld_d1 ;

assign  oqctl_sel_oq_c7 = inc_rd_ptr_d1 ;

assign  oqctl_prev_data_c7 = sel_c7_req_d1 & ~old_req_vld_d1 & 
			~oq_count_nonzero_d1 ;



///////////////////////////////////////////////////////////////////////////////////
// OQ request Q
///////////////////////////////////////////////////////////////////////////////////

dffe_s   #(12)  ff_oq0_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[0]),
			     .clk(rclk), .q(oq0_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq1_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[1]),
			     .clk(rclk), .q(oq1_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq2_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[2]),
			     .clk(rclk), .q(oq2_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq3_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[3]),
			     .clk(rclk), .q(oq3_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq4_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[4]),
			     .clk(rclk), .q(oq4_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq5_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[5]),
			     .clk(rclk), .q(oq5_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq6_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[6]),
			     .clk(rclk), .q(oq6_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq7_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[7]),
			     .clk(rclk), .q(oq7_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq8_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[8]),
			     .clk(rclk), .q(oq8_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq9_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[9]),
			     .clk(rclk), .q(oq9_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq10_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[10]),
			     .clk(rclk), .q(oq10_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq11_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[11]),
			     .clk(rclk), .q(oq11_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq12_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[12]),
			     .clk(rclk), .q(oq12_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq13_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[13]),
			     .clk(rclk), .q(oq13_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq14_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[14]),
			     .clk(rclk), .q(oq14_out[11:0]), .se(se), .si(), .so());

dffe_s   #(12)  ff_oq15_out    ( .din({rdma_inv_c7,bcast_req_c7,req_out_c7[7:0],imiss1_out_c7,imiss2_out_c7}), 
			     .en(wr_word_line[15]),
			     .clk(rclk), .q(oq15_out[11:0]), .se(se), .si(), .so());


assign	oq_out_bit7 = { oq15_out[9],oq14_out[9],oq13_out[9],oq12_out[9],
                        oq11_out[9],oq10_out[9],oq9_out[9],oq8_out[9],
                        oq7_out[9],oq6_out[9],oq5_out[9],oq4_out[9],
                        oq3_out[9],oq2_out[9],oq1_out[9],oq0_out[9] } ;

assign	oq_out_bit6 = { oq15_out[8],oq14_out[8],oq13_out[8],oq12_out[8],
                        oq11_out[8],oq10_out[8],oq9_out[8],oq8_out[8],
                        oq7_out[8],oq6_out[8],oq5_out[8],oq4_out[8],
                        oq3_out[8],oq2_out[8],oq1_out[8],oq0_out[8] } ;

assign	oq_out_bit5 = { oq15_out[7],oq14_out[7],oq13_out[7],oq12_out[7],
                        oq11_out[7],oq10_out[7],oq9_out[7],oq8_out[7],
                        oq7_out[7],oq6_out[7],oq5_out[7],oq4_out[7],
                        oq3_out[7],oq2_out[7],oq1_out[7],oq0_out[7] } ;

assign	oq_out_bit4 = { oq15_out[6],oq14_out[6],oq13_out[6],oq12_out[6],
                        oq11_out[6],oq10_out[6],oq9_out[6],oq8_out[6],
                        oq7_out[6],oq6_out[6],oq5_out[6],oq4_out[6],
                        oq3_out[6],oq2_out[6],oq1_out[6],oq0_out[6] } ;

assign	oq_out_bit3 = { oq15_out[5],oq14_out[5],oq13_out[5],oq12_out[5],
                        oq11_out[5],oq10_out[5],oq9_out[5],oq8_out[5],
                        oq7_out[5],oq6_out[5],oq5_out[5],oq4_out[5],
                        oq3_out[5],oq2_out[5],oq1_out[5],oq0_out[5] } ;

assign	oq_out_bit2 = { oq15_out[4],oq14_out[4],oq13_out[4],oq12_out[4],
                        oq11_out[4],oq10_out[4],oq9_out[4],oq8_out[4],
                        oq7_out[4],oq6_out[4],oq5_out[4],oq4_out[4],
                        oq3_out[4],oq2_out[4],oq1_out[4],oq0_out[4] } ;

assign	oq_out_bit1 = { oq15_out[3],oq14_out[3],oq13_out[3],oq12_out[3],
                        oq11_out[3],oq10_out[3],oq9_out[3],oq8_out[3],
                        oq7_out[3],oq6_out[3],oq5_out[3],oq4_out[3],
                        oq3_out[3],oq2_out[3],oq1_out[3],oq0_out[3] } ;

assign	oq_out_bit0 = { oq15_out[2],oq14_out[2],oq13_out[2],oq12_out[2],
                        oq11_out[2],oq10_out[2],oq9_out[2],oq8_out[2],
                        oq7_out[2],oq6_out[2],oq5_out[2],oq4_out[2],
                        oq3_out[2],oq2_out[2],oq1_out[2],oq0_out[2] } ;

assign	imiss2_oq_out = { oq15_out[0],oq14_out[0],oq13_out[0],oq12_out[0],
			oq11_out[0],oq10_out[0],oq9_out[0],oq8_out[0],
			oq7_out[0],oq6_out[0],oq5_out[0],oq4_out[0],
			oq3_out[0],oq2_out[0],oq1_out[0],oq0_out[0] };

assign	imiss1_oq_out = { oq15_out[1],oq14_out[1],oq13_out[1],oq12_out[1],
			oq11_out[1],oq10_out[1],oq9_out[1],oq8_out[1],
			oq7_out[1],oq6_out[1],oq5_out[1],oq4_out[1],
			oq3_out[1],oq2_out[1],oq1_out[1],oq0_out[1] };

assign	bcast_oq_out = { oq15_out[10],oq14_out[10],oq13_out[10],oq12_out[10],
                        oq11_out[10],oq10_out[10],oq9_out[10],oq8_out[10],
                        oq7_out[10],oq6_out[10],oq5_out[10],oq4_out[10],
                        oq3_out[10],oq2_out[10],oq1_out[10],oq0_out[10] };

assign	rdma_oq_out = { oq15_out[11],oq14_out[11],oq13_out[11],oq12_out[11],
                        oq11_out[11],oq10_out[11],oq9_out[11],oq8_out[11],
                        oq7_out[11],oq6_out[11],oq5_out[11],oq4_out[11],
                        oq3_out[11],oq2_out[11],oq1_out[11],oq0_out[11] };


assign	oq_rd_out[7] 	= |( oq_out_bit7 & rd_word_line )  ;
assign	oq_rd_out[6] 	= |( oq_out_bit6 & rd_word_line )  ;
assign	oq_rd_out[5] 	= |( oq_out_bit5 & rd_word_line )  ;
assign	oq_rd_out[4] 	= |( oq_out_bit4 & rd_word_line )  ;
assign	oq_rd_out[3] 	= |( oq_out_bit3 & rd_word_line )  ;
assign	oq_rd_out[2] 	= |( oq_out_bit2 & rd_word_line )  ;
assign	oq_rd_out[1] 	= |( oq_out_bit1 & rd_word_line )  ;
assign	oq_rd_out[0] 	= |( oq_out_bit0 & rd_word_line )  ;

assign  imiss1_rd_out = |( imiss1_oq_out & rd_word_line ) ;

assign  imiss2_rd_out = |( imiss2_oq_out & rd_word_line ) ;

assign	oq_bcast_out = |( bcast_oq_out & rd_word_line ) ;

assign	oq_rdma_out  = |( rdma_oq_out & rd_word_line ) ;


///////////////////////////////////////////////////////////////////////////////////
// CROSSBAR Q COUNT
/** The crossbar q count is maintained here */
// Each crossbar queue is incremented if
// * A request is issued to that destination
//   OR if "atomic" is high and a request was issued to that 
//   destination 
// Each crossbar queue is decremented if
// * A  grant is received from the crossbar for a request
// * crossbar queue counters are initialized to 0 on reset

// The crossbar Q full signal is high if
// * the crossbar count is 2
// * the crossbar count is non-zero and the request is an imiss return.
///////////////////////////////////////////////////////////////////////////////////

assign  xbarq_full[0] = ( xbar0_cnt[1])  ;
assign  xbarq_full[1] = ( xbar1_cnt[1])  ;
assign  xbarq_full[2] = ( xbar2_cnt[1])  ;
assign  xbarq_full[3] = ( xbar3_cnt[1])  ;
assign  xbarq_full[4] = ( xbar4_cnt[1])  ;
assign  xbarq_full[5] = ( xbar5_cnt[1])  ;
assign  xbarq_full[6] = ( xbar6_cnt[1])  ;
assign  xbarq_full[7] = ( xbar7_cnt[1])  ;
	
assign  xbarq_cnt1[0] = ( xbar0_cnt[0])  ;
assign  xbarq_cnt1[1] = ( xbar1_cnt[0])  ;
assign  xbarq_cnt1[2] = ( xbar2_cnt[0])  ;
assign  xbarq_cnt1[3] = ( xbar3_cnt[0])  ;
assign  xbarq_cnt1[4] = ( xbar4_cnt[0])  ;
assign  xbarq_cnt1[5] = ( xbar5_cnt[0])  ;
assign  xbarq_cnt1[6] = ( xbar6_cnt[0])  ;
assign  xbarq_cnt1[7] = ( xbar7_cnt[0])  ;
	
assign  inc_xbar_cnt[0] = ( que_in_xbarq_c7[0] & ~xbarq_full[0] & ~cpx_sctag_grant_cx[0] )  ;
assign  dec_xbar_cnt[0] = ( ~que_in_xbarq_c7[0] & cpx_sctag_grant_cx[0] ) ;
assign  nochange_xbar_cnt[0] = ~dec_xbar_cnt[0] & ~inc_xbar_cnt[0] ;
assign  change_xbar_cnt[0] = ~nochange_xbar_cnt[0] ;
assign  xbar0_cnt_plus1[1:0] = xbar0_cnt[1:0] + 2'b1 ;
assign  xbar0_cnt_minus1[1:0] = xbar0_cnt[1:0] - 2'b1 ;

mux2ds #(2)  mux_xbar0_cnt   ( .dout (xbar0_cnt_p[1:0]),
                       .in0(xbar0_cnt_plus1[1:0]), .in1(xbar0_cnt_minus1[1:0]),
                       .sel0(inc_xbar_cnt[0]),     .sel1(~inc_xbar_cnt[0])) ;

dffrle_s   #(2)  ff_xbar0    ( .din(xbar0_cnt_p[1:0]), .clk(rclk),
                             .rst_l(dbb_rst_l), .en(change_xbar_cnt[0]),
                             .q(xbar0_cnt[1:0]), .se(se), .si(), .so());

	
assign  inc_xbar_cnt[1] = ( que_in_xbarq_c7[1] & ~xbarq_full[1] & ~cpx_sctag_grant_cx[1] )  ;
assign  dec_xbar_cnt[1] = ( ~que_in_xbarq_c7[1] & cpx_sctag_grant_cx[1] ) ;
assign  nochange_xbar_cnt[1] = ~dec_xbar_cnt[1] & ~inc_xbar_cnt[1] ;
assign  change_xbar_cnt[1] = ~nochange_xbar_cnt[1] ;
assign  xbar1_cnt_plus1[1:0] = xbar1_cnt[1:0] + 2'b1 ;
assign  xbar1_cnt_minus1[1:0] = xbar1_cnt[1:0] - 2'b1 ;

mux2ds #(2)  mux_xbar1_cnt   ( .dout (xbar1_cnt_p[1:0]),
                       .in0(xbar1_cnt_plus1[1:0]), .in1(xbar1_cnt_minus1[1:0]),
                       .sel0(inc_xbar_cnt[1]),     .sel1(~inc_xbar_cnt[1])) ;

dffrle_s   #(2)  ff_xbar1    ( .din(xbar1_cnt_p[1:0]), .clk(rclk),
                             .rst_l(dbb_rst_l), .en(change_xbar_cnt[1]),
                             .q(xbar1_cnt[1:0]), .se(se), .si(), .so());

	
assign  inc_xbar_cnt[2] = ( que_in_xbarq_c7[2] & ~xbarq_full[2] & ~cpx_sctag_grant_cx[2] )  ;
assign  dec_xbar_cnt[2] = ( ~que_in_xbarq_c7[2] & cpx_sctag_grant_cx[2] ) ;
assign  nochange_xbar_cnt[2] = ~dec_xbar_cnt[2] & ~inc_xbar_cnt[2] ;
assign  change_xbar_cnt[2] = ~nochange_xbar_cnt[2] ;
assign  xbar2_cnt_plus1[1:0] = xbar2_cnt[1:0] + 2'b1 ;
assign  xbar2_cnt_minus1[1:0] = xbar2_cnt[1:0] - 2'b1 ;

mux2ds #(2)  mux_xbar2_cnt   ( .dout (xbar2_cnt_p[1:0]),
                       .in0(xbar2_cnt_plus1[1:0]), .in1(xbar2_cnt_minus1[1:0]),
                       .sel0(inc_xbar_cnt[2]),     .sel1(~inc_xbar_cnt[2])) ;

dffrle_s   #(2)  ff_xbar2    ( .din(xbar2_cnt_p[1:0]), .clk(rclk),
                             .rst_l(dbb_rst_l), .en(change_xbar_cnt[2]),
                             .q(xbar2_cnt[1:0]), .se(se), .si(), .so());

	
assign  inc_xbar_cnt[3] = ( que_in_xbarq_c7[3] & ~xbarq_full[3] & ~cpx_sctag_grant_cx[3] )  ;
assign  dec_xbar_cnt[3] = ( ~que_in_xbarq_c7[3] & cpx_sctag_grant_cx[3] ) ;
assign  nochange_xbar_cnt[3] = ~dec_xbar_cnt[3] & ~inc_xbar_cnt[3] ;
assign  change_xbar_cnt[3] = ~nochange_xbar_cnt[3] ;
assign  xbar3_cnt_plus1[1:0] = xbar3_cnt[1:0] + 2'b1 ;
assign  xbar3_cnt_minus1[1:0] = xbar3_cnt[1:0] - 2'b1 ;

mux2ds #(2)  mux_xbar3_cnt   ( .dout (xbar3_cnt_p[1:0]),
                       .in0(xbar3_cnt_plus1[1:0]), .in1(xbar3_cnt_minus1[1:0]),
                       .sel0(inc_xbar_cnt[3]),     .sel1(~inc_xbar_cnt[3])) ;

dffrle_s   #(2)  ff_xbar3    ( .din(xbar3_cnt_p[1:0]), .clk(rclk),
                             .rst_l(dbb_rst_l), .en(change_xbar_cnt[3]),
                             .q(xbar3_cnt[1:0]), .se(se), .si(), .so());

	
assign  inc_xbar_cnt[4] = ( que_in_xbarq_c7[4] & ~xbarq_full[4] & ~cpx_sctag_grant_cx[4] )  ;
assign  dec_xbar_cnt[4] = ( ~que_in_xbarq_c7[4] & cpx_sctag_grant_cx[4] ) ;
assign  nochange_xbar_cnt[4] = ~dec_xbar_cnt[4] & ~inc_xbar_cnt[4] ;
assign  change_xbar_cnt[4] = ~nochange_xbar_cnt[4] ;
assign  xbar4_cnt_plus1[1:0] = xbar4_cnt[1:0] + 2'b1 ;
assign  xbar4_cnt_minus1[1:0] = xbar4_cnt[1:0] - 2'b1 ;

mux2ds #(2)  mux_xbar4_cnt   ( .dout (xbar4_cnt_p[1:0]),
                       .in0(xbar4_cnt_plus1[1:0]), .in1(xbar4_cnt_minus1[1:0]),
                       .sel0(inc_xbar_cnt[4]),     .sel1(~inc_xbar_cnt[4])) ;

dffrle_s   #(2)  ff_xbar4    ( .din(xbar4_cnt_p[1:0]), .clk(rclk),
                             .rst_l(dbb_rst_l), .en(change_xbar_cnt[4]),
                             .q(xbar4_cnt[1:0]), .se(se), .si(), .so());

	
assign  inc_xbar_cnt[5] = ( que_in_xbarq_c7[5] & ~xbarq_full[5] & ~cpx_sctag_grant_cx[5] )  ;
assign  dec_xbar_cnt[5] = ( ~que_in_xbarq_c7[5] & cpx_sctag_grant_cx[5] ) ;
assign  nochange_xbar_cnt[5] = ~dec_xbar_cnt[5] & ~inc_xbar_cnt[5] ;
assign  change_xbar_cnt[5] = ~nochange_xbar_cnt[5] ;
assign  xbar5_cnt_plus1[1:0] = xbar5_cnt[1:0] + 2'b1 ;
assign  xbar5_cnt_minus1[1:0] = xbar5_cnt[1:0] - 2'b1 ;

mux2ds #(2)  mux_xbar5_cnt   ( .dout (xbar5_cnt_p[1:0]),
                       .in0(xbar5_cnt_plus1[1:0]), .in1(xbar5_cnt_minus1[1:0]),
                       .sel0(inc_xbar_cnt[5]),     .sel1(~inc_xbar_cnt[5])) ;

dffrle_s   #(2)  ff_xbar5    ( .din(xbar5_cnt_p[1:0]), .clk(rclk),
                             .rst_l(dbb_rst_l), .en(change_xbar_cnt[5]),
                             .q(xbar5_cnt[1:0]), .se(se), .si(), .so());

	
assign  inc_xbar_cnt[6] = ( que_in_xbarq_c7[6] & ~xbarq_full[6] & ~cpx_sctag_grant_cx[6] )  ;
assign  dec_xbar_cnt[6] = ( ~que_in_xbarq_c7[6] & cpx_sctag_grant_cx[6] ) ;
assign  nochange_xbar_cnt[6] = ~dec_xbar_cnt[6] & ~inc_xbar_cnt[6] ;
assign  change_xbar_cnt[6] = ~nochange_xbar_cnt[6] ;
assign  xbar6_cnt_plus1[1:0] = xbar6_cnt[1:0] + 2'b1 ;
assign  xbar6_cnt_minus1[1:0] = xbar6_cnt[1:0] - 2'b1 ;

mux2ds #(2)  mux_xbar6_cnt   ( .dout (xbar6_cnt_p[1:0]),
                       .in0(xbar6_cnt_plus1[1:0]), .in1(xbar6_cnt_minus1[1:0]),
                       .sel0(inc_xbar_cnt[6]),     .sel1(~inc_xbar_cnt[6])) ;

dffrle_s   #(2)  ff_xbar6    ( .din(xbar6_cnt_p[1:0]), .clk(rclk),
                             .rst_l(dbb_rst_l), .en(change_xbar_cnt[6]),
                             .q(xbar6_cnt[1:0]), .se(se), .si(), .so());

	
assign  inc_xbar_cnt[7] = ( que_in_xbarq_c7[7] & ~xbarq_full[7] & ~cpx_sctag_grant_cx[7] )  ;
assign  dec_xbar_cnt[7] = ( ~que_in_xbarq_c7[7] & cpx_sctag_grant_cx[7] ) ;
assign  nochange_xbar_cnt[7] = ~dec_xbar_cnt[7] & ~inc_xbar_cnt[7] ;
assign  change_xbar_cnt[7] = ~nochange_xbar_cnt[7] ;
assign  xbar7_cnt_plus1[1:0] = xbar7_cnt[1:0] + 2'b1 ;
assign  xbar7_cnt_minus1[1:0] = xbar7_cnt[1:0] - 2'b1 ;

mux2ds #(2)  mux_xbar7_cnt   ( .dout (xbar7_cnt_p[1:0]),
                       .in0(xbar7_cnt_plus1[1:0]), .in1(xbar7_cnt_minus1[1:0]),
                       .sel0(inc_xbar_cnt[7]),     .sel1(~inc_xbar_cnt[7])) ;

dffrle_s   #(2)  ff_xbar7    ( .din(xbar7_cnt_p[1:0]), .clk(rclk),
                             .rst_l(dbb_rst_l), .en(change_xbar_cnt[7]),
                             .q(xbar7_cnt[1:0]), .se(se), .si(), .so());




///////////////////////////////////////////////////////////////
//
// RDMA store completion state machine.
//
// An RDMA store WR8 or WR64 acks the src only after
// all the L1$ invalidates have queued up at the crossbar.
// There are 3 possible cases with stores.
//
// - Stores missing the L2 send a completion signal in C7
// - Store missing the L1 ( i.e. directory ) will send a
//   completion signal in C7.
// - Stores hitting the L1 will send a completion signal
//   after making a request to the crossbar.
// ACK_WAIT state is hit on completion.
// ACK_CCX_REQ_ST is hit on a completion followed by a directory hit.
// The following table represents all state transitions in this
// FSM.
//
//---------------------------------------------------------------------------
// STATES	ACK_IDLE		ACK_WAIT		ACK_CCX_REQ
//---------------------------------------------------------------------------
// ACK_IDLE	~comp_c5		comp_c5			never
//
//---------------------------------------------------------------------------
// ACK_WAIT	~hit_c6			 			directory
//		or no			never			hit_c6
//		directory
//		hit
//---------------------------------------------------------------------------
// ACK_CCX_REQ  req_cq & 		never			~(rdma_inv
//		rdma_invtoxbar					to xbar & req)
//---------------------------------------------------------------------------
// 
// oqctl_st_complete_c7 if there is a transition
//  			to the ACK_IDLE state from 
//			ACK_WAIT or ACK_CCX_REQ
//
///////////////////////////////////////////////////////////////


dff_s   #(1)  ff_rdma_wr_comp_c5   (.din(tagctl_rdma_wr_comp_c4), .clk(rclk),
                              .q(rdma_wr_comp_c5), .se(se), .si(), .so());


assign	dir_hit_c6 = |(dirdp_req_vec_c6);

assign	rdma_req_sent_c7 = |(sctag_cpx_req_cq) & 
				rdma_to_xbarq_c7 ;

assign  rdma_state_in[`ACK_IDLE] =       ( 	
			(rdma_state[`ACK_WAIT] & ~dir_hit_c6) | // NO L1 INVAL
                        (rdma_state[`ACK_CCX_REQ] & 
			rdma_req_sent_c7 )| // L1 INVAL SENT
                        rdma_state[`ACK_IDLE] 
			)  & ~rdma_wr_comp_c5 ; // completion of a write

assign  ack_idle_state_in_l = ~rdma_state_in[`ACK_IDLE] ;

dffrl_s   #(1)  ff_rdma_req_state_0    (.din(ack_idle_state_in_l), .clk(rclk),
                .rst_l(dbb_rst_l),
                .q(ack_idle_state_l), .se(se), .si(), .so());

assign  rdma_state[`ACK_IDLE] = ~ack_idle_state_l ;


assign  rdma_state_in[`ACK_WAIT] = 
			(rdma_state[`ACK_IDLE] & rdma_wr_comp_c5 ) ;


assign  rdma_state_in[`ACK_CCX_REQ] = (
			(rdma_state[`ACK_WAIT] & dir_hit_c6 ) | 
							// l1 INVAL to BE SENT
                        rdma_state[`ACK_CCX_REQ]) &
                        ~rdma_req_sent_c7 ;

dffrl_s   #(2)  ff_rdma_state
                (.din(rdma_state_in[`ACK_CCX_REQ:`ACK_WAIT]), 
		.clk(rclk), .rst_l(dbb_rst_l),
                .q(rdma_state[`ACK_CCX_REQ:`ACK_WAIT]),
                .se(se), .si(), .so());


assign	oqctl_st_complete_c6 = rdma_state_in[`ACK_IDLE] &
				~rdma_state[`ACK_IDLE] ;

dff_s   #(1)  ff_oqctl_st_complete_c6   (.din(oqctl_st_complete_c6), .clk(rclk),
                   .q(oqctl_st_complete_c7), .se(se), .si(), .so());





////////////////////////////////////////
// Generation of mux selects for
// oqdp. This was previously done in
// oq_dctl. Now that logic has been
// merged into oqctl. (11/05/2002).
////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////
// staging flops.

dff_s   #(1)   ff_store_inst_c6
              (.q   (store_inst_c6),
               .din (tagctl_store_inst_c5),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;
dff_s   #(1)   ff_store_inst_c7
              (.q   (store_inst_c7),
               .din (store_inst_c6),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;


dff_s   #(1)   ff_csr_reg_rd_en_c8
              (.q   (csr_reg_rd_en_c8),
               .din (arbctl_csr_rd_en_c7),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;


dff_s   #(1)   ff_sel_inval_c7
              (.q   (oqctl_sel_inval_c7),
               .din (oqctl_sel_inval_c6),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;


dff_s   #(1)   ff_fwd_req_vld_ld_c7
              (.q   (fwd_req_vld_ld_c7),
               .din (tagctl_fwd_req_ld_c6),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;


////////////////////////////////////////////////////////////////////////////////
// DATA Diagnostic access.
// remember tagctl_fwd_req_ld_c6 is only asserted for non-diag accesses.
// "mux1_sel_data_c7[3:0]" is used for select signal for a 39 bit 4to1 MUX in
// OQDP that selects among Diag data, Tag Diag data, VUAD Diag data & Interrupt
// return data.
////////////////////////////////////////////////////////////////////////////////
dff_s   #(1)   ff_diag_data_sel_c7
              (.q   (diag_data_sel_c7),
               .din (arbctl_inst_l2data_vld_c6),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;


assign  diag_lddata_sel_c7 = (diag_data_sel_c7 & ~store_inst_c7) |
                              tagctl_fwd_req_ld_c6 ;


dff_s   #(1)   ff_diag_lddata_sel_c8
              (.q   (diag_lddata_sel_c8),
               .din (diag_lddata_sel_c7),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;


assign  mux1_sel_data_c7[0] = diag_lddata_sel_c8 & ~rst_tri_en ;
// rst_tri_en is used to insure mux exclusivity during the scan testing

////////////////////////////////////////
// Tag Diagnostic access.
////////////////////////////////////////
dff_s   #(1)   ff_diag_tag_sel_c7
              (.q   (diag_tag_sel_c7),
               .din (arbctl_inst_l2tag_vld_c6),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;


assign  diag_ldtag_sel_c7 = diag_tag_sel_c7 & ~store_inst_c7 ;


dff_s   #(1)   ff_diag_ldtag_sel_c8
              (.q   (diag_ldtag_sel_c8),
               .din (diag_ldtag_sel_c7),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;


assign  mux1_sel_data_c7[1] = diag_ldtag_sel_c8 & ~rst_tri_en ;

////////////////////////////////////////
// VUAD Diagnostic access.
////////////////////////////////////////
dff_s   #(1)   ff_diag_vuad_sel_c7
              (.q   (diag_vuad_sel_c7),
               .din (arbctl_inst_l2vuad_vld_c6),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;

assign  diag_ldvuad_sel_c7 = diag_vuad_sel_c7 & ~store_inst_c7 ;


dff_s   #(1)   ff_diag_ldvuad_sel_c8
              (.q   (diag_ldvuad_sel_c8),
               .din (diag_ldvuad_sel_c7),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;

assign  mux1_sel_data_c7[2] = diag_ldvuad_sel_c8 & ~rst_tri_en ;

////////////////////////////////////////
// default mux sel
////////////////////////////////////////
assign  diag_def_sel_c7 = ~(diag_lddata_sel_c7 | diag_ldtag_sel_c7 |
                            diag_ldvuad_sel_c7) ;

dff_s   #(1)   ff_diag_def_sel_c8
              (.q   (diag_def_sel_c8),
               .din (diag_def_sel_c7),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;

assign  mux1_sel_data_c7[3] = diag_def_sel_c8 | rst_tri_en ;


////////////////////////////////////////////////////////////////////////////////
assign	mux_csr_sel_c7 = csr_reg_rd_en_c8 ; // buferred here.


////////////////////////////////////////////////////////////////////////////////
// mux select to choose between
// inval and retdp data for oqarray_datain
////////////////////////////////////////////////////////////////////////////////
assign  sel_inval_c7 = oqctl_sel_inval_c7 | diag_lddata_sel_c8 |
                       diag_ldtag_sel_c8  | diag_ldvuad_sel_c8 |  
                       fwd_req_vld_ld_c7 ;


////////////////////////////////////////////////////////////////////////////////
// mux select for 3-1 mux in oqdp.
// sel0 .... old packet
// sel1 .... oq data
// sel2 .... def.
////////////////////////////////////////////////////////////////////////////////

assign  out_mux1_sel_c7[0] = oqctl_sel_old_req_c7 ;
assign	out_mux1_sel_c7[1] = oqctl_sel_oq_c7 ;
assign	out_mux1_sel_c7[2] = ~(oqctl_sel_old_req_c7 | oqctl_sel_oq_c7 )  ;

////////////////////////////////////////////////////////////////////////////////
// mux2 select for 3-1 mux in oqdp.
// sel0.....oq,old or prev data
// sel1.....inval data
// sel2.....def 
////////////////////////////////////////////////////////////////////////////////
assign  sel_old_data_c7 = (oqctl_sel_old_req_c7 | oqctl_sel_oq_c7 |
                           oqctl_prev_data_c7);

assign  out_mux2_sel_c7[0] = sel_old_data_c7 ;
assign  out_mux2_sel_c7[1] = sel_inval_c7 & ~sel_old_data_c7 ;
assign  out_mux2_sel_c7[2] = ~(sel_old_data_c7 | sel_inval_c7) ;



////////////////////////////////////////////////////////////////////////////////
// Directory in L2 is arranged in the form of 32 Panels (8 Rows x 4 Columns).
// Each panel contains 1 Set (4 Ways) for each of the 8 CPU. A Panel is selected
// for Camming based on address bit <4,5,8,9,10> for the D$ Cam and address bit
// <5,8,9,10,11> for the I$ Cam. In D$ bit <10,9,8> is used for selecting a Row
// and bit <5,4> is used for selecting the a Column. In I$ bit <10,9,8> is used
// for selecting a Row and bit <5,11> is used for selecting a Column.
//
// I$ and D$ Cam produce a 128 bit output which corresponds to the CAM hit or
// miss output bit for a Row of 4 Panels (each panel have 32 entry, 4 way of a
// set for each of the 8 cpu). In case of an eviction all the 128 bit of the
// D$ Cam and only 64 bits of the I$ Cam will be valid. In case of Load only
// 4 bit of the I$ cam output will be valid (For Load, if the data requested by
// a particular cpu is also present in the I$ of the same processor then that
// data in L1's I$ must be invalidated. So for a load only one panel in
// I$ Cam will be Cammed and only bits corresponding to that particular cpu will
// be relevant). In case of Imiss, in first cycle one set of the 4 bit of the
// D$ Cam output will be valid and in the second cycle another set of the 4 bit
// of the D$ Cam output will be valid.
// To mux out relevant 4 bits out of the 128 bit output from the I$ and D$ Cam
// Three stage muxing is done. First 8to1 muxing is done in 2 stages (first
// 4to1 and then 2to1) to mux out all the 16 bits corresponding a particular cpu.
// This muxing is done based on the cpu id. Then 4:1 muxing is done to select a
// particular column out of the four column, this is done based on the address
// bit <5,4> for the D$ and address bit <5,11> for the I$.
// 
// sel_mux1_c6[3:0], sel_mux2_c6[3:0] and sel_mux3_c6 is used for the 8to1
// Muxing. sel_mux1_c6[3:0] & sel_mux2_c6[3:0] is used for the 4to1 muxing in
// the first stage and sel_mux3_c6 is used to do 2to1 muxing in the second
// stage.
// mux_vec_sel_c6[3:0] is used to do final 4to1 Muxing.
//
////////////////////////////////////////////////////////////////////////////////
// the arbdp_cpuid_c5 requires ~10 gates of setup.

dff_s   #(3)   ff_dirvec_cpuid_c6
              (.q   (inst_cpuid_c6[2:0]),
               .din (arbdp_cpuid_c5[2:0]),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;

mux2ds #(3)  mux_dirvec_cpuid_c5
              (.dout (cpuid_c5[2:0]),
               .in0  (arbdp_cpuid_c5[2:0]),  .sel0 (~imiss1_out_c6),
               .in1  (inst_cpuid_c6[2:0]),   .sel1 (imiss1_out_c6)
              ) ;


assign  dec_cpuid_c5[0] = (cpuid_c5 == 3'd0) ;
assign  dec_cpuid_c5[1] = (cpuid_c5 == 3'd1) ;
assign  dec_cpuid_c5[2] = (cpuid_c5 == 3'd2) ;
assign  dec_cpuid_c5[3] = (cpuid_c5 == 3'd3) ;
assign  dec_cpuid_c5[4] = (cpuid_c5 == 3'd4) ;
assign  dec_cpuid_c5[5] = (cpuid_c5 == 3'd5) ;
assign  dec_cpuid_c5[6] = (cpuid_c5 == 3'd6) ;

dff_s   #(7)   ff_dec_cpuid_c6
              (.q   (dec_cpuid_c6[6:0]),
               .din (dec_cpuid_c5[6:0]),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;


assign  sel_mux1_c6[0] =   dec_cpuid_c6[0] & ~rst_tri_en ;
assign  sel_mux1_c6[1] =   dec_cpuid_c6[1] & ~rst_tri_en ;
assign  sel_mux1_c6[2] =   dec_cpuid_c6[2] & ~rst_tri_en ;
assign  sel_mux1_c6[3] = ~(dec_cpuid_c6[0] | dec_cpuid_c6[1] |
                           dec_cpuid_c6[2]) | rst_tri_en ;

assign  sel_mux2_c6[0] =   dec_cpuid_c6[4] & ~rst_tri_en ;
assign  sel_mux2_c6[1] =   dec_cpuid_c6[5] & ~rst_tri_en ;
assign  sel_mux2_c6[2] =   dec_cpuid_c6[6] & ~rst_tri_en ;
assign  sel_mux2_c6[3] = ~(dec_cpuid_c6[4] | dec_cpuid_c6[5] |
                           dec_cpuid_c6[6]) | rst_tri_en ;

assign  sel_mux3_c6    =   |(dec_cpuid_c6[3:0]) ;



////////////////////////////////////////////////////////////////////////////////
// mux selects for the mux that selects the data
// for way-wayvld bits of the cpx packet.

dff_s   #(4)   ff_lkup_bank_ena_icd_c5
              (.q   (lkup_bank_ena_icd_c5[3:0]),
               .din (lkup_bank_ena_icd_c4[3:0]),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;

dff_s   #(4)   ff_lkup_bank_ena_dcd_c5
              (.q   (lkup_bank_ena_dcd_c5[3:0]),
               .din (lkup_bank_ena_dcd_c4[3:0]),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;


assign  mux_vec_sel_c5[0] = (lkup_bank_ena_icd_c5[0] | lkup_bank_ena_dcd_c5[0] |
                             lkup_bank_ena_icd_c5[1]) ;
assign  mux_vec_sel_c5[1] =  lkup_bank_ena_dcd_c5[1] & ~mux_vec_sel_c5[0] ;
assign  mux_vec_sel_c5[2] =  (lkup_bank_ena_icd_c5[2] | lkup_bank_ena_dcd_c5[2] |
                              lkup_bank_ena_icd_c5[3]) &
                            ~(mux_vec_sel_c5[0] | mux_vec_sel_c5[1]) ;
assign  mux_vec_sel_c5[3] = ~(mux_vec_sel_c5[0] | mux_vec_sel_c5[1] |
                              mux_vec_sel_c5[2]) ;

dff_s   #(4)   ff_mux_vec_sel_c6
              (.q   (mux_vec_sel_c6_unqual[3:0]),
               .din (mux_vec_sel_c5[3:0]),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;

assign  mux_vec_sel_c6[0] = mux_vec_sel_c6_unqual[0] & ~rst_tri_en ;
assign  mux_vec_sel_c6[1] = mux_vec_sel_c6_unqual[1] & ~rst_tri_en ;
assign  mux_vec_sel_c6[2] = mux_vec_sel_c6_unqual[2] & ~rst_tri_en ;
assign  mux_vec_sel_c6[3] = mux_vec_sel_c6_unqual[3] |  rst_tri_en ;


endmodule













