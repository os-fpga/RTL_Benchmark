// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_rdmatctl.v
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
`include "sctag.h"
////////////////////////////////////////////////////////////////////////
// Local header file includes / local defines
////////////////////////////////////////////////////////////////////////

module sctag_rdmatctl( /*AUTOARG*/
   // Outputs
   rdmat_wr_entry_s1, or_rdmat_valid, rdmat_pick_vec, 
   rdmatctl_hit_unqual_c2, rdmatctl_mbctl_dep_rdy_en, 
   rdmatctl_mbctl_dep_mbid, rdmat_wr_wl_s2, sctag_scbuf_fbwr_wl_r2, 
   sctag_scbuf_fbrd_en_c3, sctag_scbuf_fbrd_wl_c3, 
   sctag_scbuf_word_vld_c7, sctag_scbuf_ctag_en_c7, 
   sctag_scbuf_req_en_c7, sctag_scbuf_word_c7, rdmard_cerr_c12, 
   rdmard_uerr_c12, ev_uerr_r6, ev_cerr_r6, so, 
   sctag_scbuf_fbwr_wen_r2, sctag_scbuf_fbd_stdatasel_c3, 
   sctag_scbuf_ctag_c7, 
   // Inputs
   rdmatag_wr_en_s2, reset_rdmat_vld, set_rdmat_acked, 
   rdmat_cam_match_c2, arbctl_wbctl_inst_vld_c2, 
   arbctl_wbctl_hit_off_c1, arbdp_rdma_entry_c3, mbctl_wbctl_mbid_c4, 
   mbctl_hit_c4, tagctl_rdma_ev_en_c4, scbuf_fbd_stdatasel_c3, 
   scbuf_fbwr_wen_r2, rst_tri_en, arst_l, grst_l, rclk, si, se, 
   scbuf_sctag_rdma_cerr_c10, scbuf_sctag_rdma_uerr_c10, 
   scbuf_sctag_ev_uerr_r5, scbuf_sctag_ev_cerr_r5, arbdec_ctag_c6, 
   tagctl_inc_rdma_cnt_c4, tagctl_set_rdma_reg_vld_c4, 
   tagctl_jbi_req_en_c6, arbdp_rdmatctl_addr_c6, fbctl_fbd_rd_en_c2, 
   fbctl_fbd_rd_entry_c2, fbctl_fbd_wr_entry_r1
   );


output	[1:0]	rdmat_wr_entry_s1; // to snp ctl.

output		or_rdmat_valid; // to wbctl
output	[3:0]	rdmat_pick_vec; // to wbctl

output		rdmatctl_hit_unqual_c2 ; // to mbctl
output		rdmatctl_mbctl_dep_rdy_en;// to mbctl
output	[3:0]	rdmatctl_mbctl_dep_mbid; // to mbctl

output	[3:0]	rdmat_wr_wl_s2;

output  [2:0]   sctag_scbuf_fbwr_wl_r2; // NEW_PIN
output          sctag_scbuf_fbrd_en_c3; // NEW_PIN
output  [2:0]   sctag_scbuf_fbrd_wl_c3; // NEW_PIN
output          sctag_scbuf_word_vld_c7; // NEW_PIN
output          sctag_scbuf_ctag_en_c7; // NEW_PIN
output          sctag_scbuf_req_en_c7;  // NEW_PIN
output  [3:0]   sctag_scbuf_word_c7; // NEW_PIN

output	rdmard_cerr_c12, rdmard_uerr_c12;  // NEW_PIN
output	ev_uerr_r6, ev_cerr_r6; // NEW_PIN


output	so;

input		rdmatag_wr_en_s2 ; // from snpctl.

input	[3:0]	reset_rdmat_vld; // comes from  wbctl
input	[3:0]	set_rdmat_acked; // from wbctl

input	[3:0]	rdmat_cam_match_c2; // from cm2

input		arbctl_wbctl_inst_vld_c2 ; // from arbctl.
input		arbctl_wbctl_hit_off_c1 ; // from arbctl.
input	[1:0]	arbdp_rdma_entry_c3; // mbid

input   [3:0]   mbctl_wbctl_mbid_c4; // mbctl
input           mbctl_hit_c4; // mbctl

input		tagctl_rdma_ev_en_c4; // generated in tagctl;


input		scbuf_fbd_stdatasel_c3;
input	[15:0]	scbuf_fbwr_wen_r2;

output	[15:0] 	sctag_scbuf_fbwr_wen_r2 ;
output		sctag_scbuf_fbd_stdatasel_c3 ;



input	rst_tri_en ;
input	arst_l;
input	grst_l;
input	rclk;
input	si, se;

// from scbuf
input	scbuf_sctag_rdma_cerr_c10; // NEW_PIN
input	scbuf_sctag_rdma_uerr_c10; // NEW_PIN
// from scbuf
input   scbuf_sctag_ev_uerr_r5; // NEW_PIN
input   scbuf_sctag_ev_cerr_r5; // NEW_PIN
input	[14:0]	arbdec_ctag_c6; // NEW_PIN POST_3.3 Bottom
 
output	[14:0]	sctag_scbuf_ctag_c7; // NEW_PIN POST_3.3 TOp







// from tagctl.
input           tagctl_inc_rdma_cnt_c4; // NEW_PIN
input           tagctl_set_rdma_reg_vld_c4 ; // NEW_PIN
input           tagctl_jbi_req_en_c6; // NEW_PIN

// from arbaddr
input   [5:2]   arbdp_rdmatctl_addr_c6; // NEW_PIN

// from fbctl
input           fbctl_fbd_rd_en_c2; // rd en for fbdata NEW_PIN
input   [2:0]   fbctl_fbd_rd_entry_c2; // rd entry for fbdata NEW_PIN
input   [2:0]   fbctl_fbd_wr_entry_r1; // entry for fbdata wr NEW_PIN

wire    jbi_req_en_c7;

wire    inc_rdma_cnt_c5, inc_rdma_cnt_c6, inc_rdma_cnt_c7 ;
wire    set_rdma_reg_vld_c5 , set_rdma_reg_vld_c6, set_rdma_reg_vld_c7 ;
wire    [3:0]   rdma_state_in, rdma_state_plus1 , rdma_state ;
wire    inc_state_en;
wire    rdma_state_en;


wire	[3:0]	rdma_wr_ptr_s1, rdma_wr_ptr_s2;
wire	[3:0]	rdma_valid_prev, rdma_valid ;

wire	[3:0]	rdma_cam_hit_vec_c2, rdma_cam_hit_vec_c3, rdma_cam_hit_vec_c4;
wire		rdmatctl_hit_qual_c2, rdmatctl_hit_qual_c3, rdmatctl_hit_qual_c4;

wire		mbid_wr_en ;
wire	[3:0]	sel_insert_mbid_c4;

wire	[3:0]	mbid0, mbid1, mbid2, mbid3;
wire	[3:0]	rdma_mbid_vld_in, rdma_mbid_vld ;
wire	[3:0]	sel_mbid;
wire		sel_def_mbid;
wire	[3:0]	enc_mbid;

wire	[3:0]	rdma_acked_in, rdma_acked;

wire	[3:0]	rdma_dram_req_in, rdma_dram_req ;
wire	[3:0]	noalloc_evict_dram_c4;
wire	or_rdma_mbid_vld;
wire	[1:0]	rdma_entry_c4;
wire	arbctl_wbctl_hit_off_c2;
wire	[3:0]	sel_mbid_rst;

wire            dbb_rst_l;
///////////////////////////////////////////////////////////////////
// Reset flop
///////////////////////////////////////////////////////////////////

 dffrl_async    #(1)    reset_flop      (.q(dbb_rst_l),
                                        .clk(rclk),
                                        .rst_l(arst_l),
                                        .din(grst_l),
                                        .se(se), .si(), .so());


assign		sctag_scbuf_fbd_stdatasel_c3 = scbuf_fbd_stdatasel_c3 ;
assign		sctag_scbuf_fbwr_wen_r2 = scbuf_fbwr_wen_r2 ;

//assign	jbi_req_vld_buf = jbi_sctag_req_vld;
//assign	jbi_req_buf = jbi_sctag_req;

/////////////////////////////////////////
// Repeater for ctag from arbdec.
/////////////////////////////////////////
dff_s   #(15)  ff_sctag_scbuf_ctag_c7    (.din(arbdec_ctag_c6[14:0]), .clk(rclk),
                    .q(sctag_scbuf_ctag_c7[14:0]), .se(se), .si(), .so());

/////////////////////////////////////////
// Generating the wr ptr for rdmat
/////////////////////////////////////////

assign	rdma_wr_ptr_s1[0] = ~rdma_valid[0] ;
assign	rdma_wr_ptr_s1[1] = rdma_valid[0] & ~rdma_valid[1];
assign	rdma_wr_ptr_s1[2] = (rdma_valid[0] & rdma_valid[1]) & ~rdma_valid[2] ;
assign	rdma_wr_ptr_s1[3] = ( rdma_valid[0] & rdma_valid[1] & rdma_valid[2])  
			& ~rdma_valid[3] ;

assign	rdmat_wr_entry_s1[0] = ( rdma_wr_ptr_s1[1] | rdma_wr_ptr_s1[3] ) ;
assign	rdmat_wr_entry_s1[1] = ( rdma_wr_ptr_s1[2] | rdma_wr_ptr_s1[3] ) ;

dff_s   #(4)  ff_rdma_wr_ptr_s2    (.din(rdma_wr_ptr_s1[3:0]), .clk(rclk),
                    .q(rdma_wr_ptr_s2[3:0]), .se(se), .si(), .so());

assign	rdmat_wr_wl_s2 = rdma_wr_ptr_s2 ;

///////////////////////////////////////////////////////////////////
// Pipeline for setting and resetting the valid bits 
// for the rdmat 
//
// Set Pipeline.
//-----------------------------------------------------------------
// 	S1			S2		S3
//-----------------------------------------------------------------
//	xmit wr entry		snpctl		
//	pick to			generates
//	snpctl			rdmat/rdmad	vld=1
//				wren and wrwl
//
//				
//				set valid bit
//-----------------------------------------------------------------
//
//
// Reset Pipeline 
//-----------------------------------------------------------------
// 	R0	R5 ..... R11		R12
//-----------------------------------------------------------------
//		evict	 evict		evict
//		data1	 data7		data8
//
//			 reset		valid=0
//			 valid.
//-----------------------------------------------------------------
///////////////////////////////////////////////////////////////////

assign	rdma_valid_prev = ( rdma_wr_ptr_s2 & {4{rdmatag_wr_en_s2}}  
			| rdma_valid )  
			& ~reset_rdmat_vld ;

dffrl_s   #(4)  ff_valid_bit    (.din(rdma_valid_prev[3:0]), .clk(rclk), 
			.rst_l(dbb_rst_l),
                       .q(rdma_valid[3:0]), .se(se), .si(), .so());


////////////////////////////////////////////////////////////////////
// Hit calculation.
// RDMA hit is asserted only under the  following conditions. 
// wb_valid = 1
// wb_dram_req = 1 => that the Wr64 corresponding to that entry
// 		    has cleared all dependencies and successfully
//		    completed an issue down the pipe.
// wb_acked = 1 => an ack was received for the Wr req sent to 
//		   dram. 
////////////////////////////////////////////////////////////////////

dff_s   #(1)   ff_arbctl_wbctl_hit_off_c2
              (.q   (arbctl_wbctl_hit_off_c2),
               .din (arbctl_wbctl_hit_off_c1),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;

assign	rdma_cam_hit_vec_c2 =  ( rdmat_cam_match_c2 & 
				rdma_valid & rdma_dram_req & 
				~( rdma_acked |  {4{arbctl_wbctl_hit_off_c2}} ) );

assign 	rdmatctl_hit_unqual_c2 = |( rdma_cam_hit_vec_c2 )  ;

dff_s   #(4)   ff_rdma_cam_hit_vec_c3
              (.q   (rdma_cam_hit_vec_c3[3:0]),
               .din (rdma_cam_hit_vec_c2[3:0]),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;
dff_s   #(4)   ff_rdma_cam_hit_vec_c4
              (.q   (rdma_cam_hit_vec_c4[3:0]),
               .din (rdma_cam_hit_vec_c3[3:0]),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;

assign	rdmatctl_hit_qual_c2 = rdmatctl_hit_unqual_c2 & 
			arbctl_wbctl_inst_vld_c2 ;

dff_s   #(1)   ff_rdmatctl_hit_qual_c3
              (.q   (rdmatctl_hit_qual_c3),
               .din (rdmatctl_hit_qual_c2),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;
dff_s   #(1)   ff_rdmatctl_hit_qual_c4
              (.q   (rdmatctl_hit_qual_c4),
               .din (rdmatctl_hit_qual_c3),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;


////////////////////////////////////////////////////////////////////////////////
// MBID and MBID_vld.
// Written in the C4 cycle of a non-dependent instruction that hits
// the rdma buffer.
//
// When an ack is received from DRAM for the entry with mbid_vld,
// the corresponding mbid is used to wake up the miss buffer entry
// that depends on the write.The ack may be received when the instruction
// is in flight i.e in C2, C3 otr C4 and yet to set mbid vld. But that is
// okay since the "acked" bit can only be set for one entry in the WBB at
// a time.
// MBID_vld is reset when an entry has mbid_vld =1 and acked=1
//
////////////////////////////////////////////////////////////////////////////////


assign  mbid_wr_en = rdmatctl_hit_qual_c4 & ~mbctl_hit_c4;
assign  sel_insert_mbid_c4 = {4{mbid_wr_en}} & rdma_cam_hit_vec_c4 ;

dffe_s   #(4)  ff_mbid0    (.din( mbctl_wbctl_mbid_c4[3:0]), 
			.en(sel_insert_mbid_c4[0]),
                        .clk(rclk), .q(mbid0[3:0]), .se(se), .si(), .so());

dffe_s   #(4)  ff_mbid1    (.din(mbctl_wbctl_mbid_c4[3:0]), 
			.en(sel_insert_mbid_c4[1]), 
			.clk(rclk), .q(mbid1[3:0]), .se(se), .si(), .so());

dffe_s   #(4)  ff_mbid2    (.din(mbctl_wbctl_mbid_c4[3:0]), 
			.en(sel_insert_mbid_c4[2]),
                        .clk(rclk), .q(mbid2[3:0]), .se(se), .si(), .so());

dffe_s   #(4)  ff_mbid3    (.din(mbctl_wbctl_mbid_c4[3:0]), 
			.en(sel_insert_mbid_c4[3]), 
			.clk(rclk), .q(mbid3[3:0]), .se(se), .si(), .so());


assign  rdma_mbid_vld_in = 	( rdma_mbid_vld | sel_insert_mbid_c4 ) & 
				 ~(sel_mbid[3:0])    ;

dffrl_s   #(4)  ff_rdma_mbid_vld    (.din(rdma_mbid_vld_in[3:0]), 
				.clk(rclk),.rst_l(dbb_rst_l),
                                .q(rdma_mbid_vld[3:0]), .se(se), .si(), .so());



///////////////////////////////////////////////////////////////////
// Mbf dependent Ready logic.
///////////////////////////////////////////////////////////////////

assign	sel_mbid	= rdma_acked & rdma_mbid_vld ;

assign	sel_def_mbid = ~( sel_mbid[2] | sel_mbid[1] | sel_mbid[0] ) ;

assign	 sel_mbid_rst[0] = sel_mbid[0] & ~rst_tri_en ;
assign	 sel_mbid_rst[1] = sel_mbid[1] & ~rst_tri_en ;
assign	 sel_mbid_rst[2] = sel_mbid[2] & ~rst_tri_en ;
assign	 sel_mbid_rst[3] = (sel_def_mbid |  rst_tri_en ) ;



mux4ds  #(4) rdma_mb_mbid  (.dout (enc_mbid[3:0]),
                             .in0(mbid0[3:0]), .in1(mbid1[3:0]),
                             .in2(mbid2[3:0]), .in3(mbid3[3:0]),
                             .sel0(sel_mbid_rst[0]), .sel1(sel_mbid_rst[1]),
                             .sel2(sel_mbid_rst[2]), .sel3(sel_mbid_rst[3]));


assign	rdmatctl_mbctl_dep_rdy_en = |(sel_mbid[3:0]);
assign	rdmatctl_mbctl_dep_mbid = enc_mbid[3:0];



///////////////////////////////////////////////////////////////////////////////
// This bit indicates if  an entry in the RDMA WR Buffer 
// can be evicted to DRAM.
//
// The dram req bit of an  entry is set in the C4 cycle of 
// a WR64 instruction that completes successfully. 
// A Wr64 instruction much like the RD64 instruction is 
// followed by 2 bubbles. This means that an instruction
// following it 2 cycles later will see the dram_req
// bit without any need for bypassing.
///////////////////////////////////////////////////////////////////////////////

dff_s   #(2)  ff_rdma_entry_c4    (.din( arbdp_rdma_entry_c3[1:0]), 
                        .clk(rclk), .q(rdma_entry_c4[1:0]), .se(se), .si(), .so());

assign	noalloc_evict_dram_c4[0] = ( rdma_entry_c4[1:0] == 2'b00 ) & 
					tagctl_rdma_ev_en_c4 ;
assign	noalloc_evict_dram_c4[1] = ( rdma_entry_c4[1:0] == 2'b01 ) & 
					tagctl_rdma_ev_en_c4 ;
assign	noalloc_evict_dram_c4[2] = ( rdma_entry_c4[1:0] == 2'b10 ) & 
					tagctl_rdma_ev_en_c4 ;
assign	noalloc_evict_dram_c4[3] = ( rdma_entry_c4[1:0] == 2'b11 ) & 
					tagctl_rdma_ev_en_c4 ;

assign  rdma_dram_req_in = ( rdma_dram_req | noalloc_evict_dram_c4 )
                                & ~reset_rdmat_vld;

dffrl_s   #(4)  ff_dram_req    (.din(rdma_dram_req_in[3:0]), .clk(rclk),
		   	.rst_l(dbb_rst_l),
                   	.q(rdma_dram_req[3:0]), .se(se), .si(), .so());

assign	or_rdmat_valid = |( rdma_dram_req ) ;

assign	or_rdma_mbid_vld = |( rdma_dram_req & rdma_mbid_vld);

mux2ds #(4)  mux_pick_quad0_in
              (.dout (rdmat_pick_vec[3:0]),
               .in0  (rdma_dram_req[3:0]),     .sel0 (~or_rdma_mbid_vld),
               .in1  (rdma_mbid_vld[3:0]),  .sel1 (or_rdma_mbid_vld)
              ) ;


///////////////////////////////////////////////////////////////////////////////
// ACKED  bit
// Set when an entry is acked by the DRAM controller.
//  Reset along with the valid bit.
///////////////////////////////////////////////////////////////////////////////


assign  rdma_acked_in = ( rdma_acked | set_rdmat_acked ) & 
				~reset_rdmat_vld ;

dffrl_s    #(4)   ff_rdma_acked   (.din(rdma_acked_in[3:0]), .clk(rclk),
		   	.rst_l(dbb_rst_l),
                  	.q(rdma_acked[3:0]), .se(se), .si(), .so());

dff_s   #(1)  ff_sctag_scbuf_fbrd_en_c3    (.din(fbctl_fbd_rd_en_c2), .clk(rclk),
                        .q(sctag_scbuf_fbrd_en_c3), .se(se), .si(), .so());

dff_s   #(3)  ff_sctag_scbuf_fbrd_wl_c3    (.din(fbctl_fbd_rd_entry_c2[2:0]),
                        .clk(rclk),
                       .q(sctag_scbuf_fbrd_wl_c3[2:0]), .se(se), .si(), .so());

dff_s   #(3)  ff_sctag_scbuf_fbwr_wl_r2    (.din(fbctl_fbd_wr_entry_r1[2:0]),
                        .clk(rclk),
                       .q(sctag_scbuf_fbwr_wl_r2[2:0]), .se(se), .si(), .so());



dff_s   #(1)  ff_inc_rdma_cnt_c5    (.din(tagctl_inc_rdma_cnt_c4), .clk(rclk),
                .q(inc_rdma_cnt_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_inc_rdma_cnt_c6    (.din(inc_rdma_cnt_c5), .clk(rclk),
                .q(inc_rdma_cnt_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_inc_rdma_cnt_c7    (.din(inc_rdma_cnt_c6), .clk(rclk),
                .q(inc_rdma_cnt_c7), .se(se), .si(), .so());

assign  sctag_scbuf_word_vld_c7 = inc_rdma_cnt_c7 ;

dff_s   #(1)  ff_set_rdma_reg_vld_c5    (.din(tagctl_set_rdma_reg_vld_c4), .clk(rclk),
                .q(set_rdma_reg_vld_c5), .se(se), .si(), .so());

dff_s   #(1)  ff_set_rdma_reg_vld_c6    (.din(set_rdma_reg_vld_c5), .clk(rclk),
                .q(set_rdma_reg_vld_c6), .se(se), .si(), .so());

dff_s   #(1)  ff_set_rdma_reg_vld_c7    (.din(set_rdma_reg_vld_c6), .clk(rclk),
                .q(set_rdma_reg_vld_c7), .se(se), .si(), .so());

assign  sctag_scbuf_ctag_en_c7 = set_rdma_reg_vld_c7 ;

dff_s   #(1)  ff_tagctl_jbi_req_en_c7    (.din(tagctl_jbi_req_en_c6), .clk(rclk),
                .q(jbi_req_en_c7), .se(se), .si(), .so());

assign  sctag_scbuf_req_en_c7 = jbi_req_en_c7 ;

/////////////////////////////////////////
// rdma state counter.
// streaming to jbi is done critical word
// first.
// The counter that determines the mux selects
// to do this is maintained here.
/////////////////////////////////////////
assign  inc_state_en = inc_rdma_cnt_c6 & ~set_rdma_reg_vld_c6 ;
                        // implies ld64 beyond c6.

assign  rdma_state_en = (inc_rdma_cnt_c6 | set_rdma_reg_vld_c6 );

assign  rdma_state_plus1 = rdma_state + 4'b1;


mux2ds  #(4) mux_rdma_state_in   (.dout (rdma_state_in[3:0]),
                                .in0(rdma_state_plus1[3:0]),
                                .in1(arbdp_rdmatctl_addr_c6[5:2]),
                                .sel0(inc_state_en),
                                .sel1(~inc_state_en));


dffe_s   #(4)  ff_rdmard_st  (.din(rdma_state_in[3:0]),
                 .en(rdma_state_en), .clk(rclk),
                 .q(rdma_state[3:0]), .se(se), .si(), .so());

assign  sctag_scbuf_word_c7 = rdma_state ;


//////////////////////////////////////////////////////////////////////////
// Buffer repeater for the rdma rd err
// signals.
// These signals are actually C11 signals coming
// in from scbuf even though the suffix reads
// C10( rdmard operation is skewed by 1 cyc). 
// Here's the pipeline.
//
//--------------------------------------------------------------------
//	C5	C6	C7	C8	C9	C10	C11
//--------------------------------------------------------------------
//	$rd	$rd	xmit	xmit	mux	ecc	xmit
//							err
//							to
//							sctag
//--------------------------------------------------------------------
//
/////////////////////////////////////////////////////////////////////////
dff_s   #(1)  ff_rdmard_cerr_c12    (.din(scbuf_sctag_rdma_cerr_c10), .clk(rclk),
                        .q(rdmard_cerr_c12), .se(se), .si(), .so());

dff_s   #(1)  ff_rdmard_uerr_c12    (.din(scbuf_sctag_rdma_uerr_c10), .clk(rclk),
                        .q(rdmard_uerr_c12), .se(se), .si(), .so());




dff_s   #(1)  ff_ev_uerr_r6    (.din(scbuf_sctag_ev_uerr_r5), .clk(rclk),
                .q(ev_uerr_r6), .se(se), .si(), .so());

dff_s   #(1)  ff_ev_cerr_r6    (.din(scbuf_sctag_ev_cerr_r5), .clk(rclk),
                .q(ev_cerr_r6), .se(se), .si(), .so());

endmodule

