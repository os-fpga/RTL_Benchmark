// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_tagdp_ctl.v
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Description:
//      This module contains the control required for detecting
//	a parity error in a tag read.
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



`include 	"iop.h"
`include 	"sctag.h"

module sctag_tagdp_ctl( /*AUTOARG*/
   // Outputs
   triad0_muxsel_c3, triad1_muxsel_c3, triad2_muxsel_c3, 
   triad3_muxsel_c3, tag_quad_muxsel_c3, bist_vuad_wr_data, 
   bist_vuad_index, bist_vuad_vd, bist_vuad_write, 
   vuad_dp_diag_data_c7_buf, tagdp_mbctl_par_err_c3, 
   tagdp_tagctl_par_err_c3, tagdp_arbctl_par_err_c3, tag_error_c8, 
   so, lru_way_sel_c3, evict_c3, invalid_evict_c3, 
   // Inputs
   vuad_dp_valid_c2, tag_parity_c2, tag_way_sel_c2, 
   vuad_tagdp_sel_c2_d1, bist_way_px, bist_enable_px, 
   arbdp_diag_wr_way_c2, arbctl_tecc_way_c2, arbctl_normal_tagacc_c2, 
   arbctl_tagdp_tecc_c2, arbctl_tagdp_perr_vld_c2, mbctl_hit_c3, 
   l2_dir_map_on, arbctl_l2tag_vld_c4, rst_tri_en, mbist_write_data, 
   mbist_l2v_index, mbist_l2v_vd, mbist_l2v_write, 
   vuad_dp_diag_data_c7, rclk, si, se, grst_l, arst_l, dbginit_l, 
   vuad_dp_used_c2, vuad_dp_alloc_c2, arbctl_evict_vld_c2
   );





input	[11:0]	vuad_dp_valid_c2; 
input	[11:0]	tag_parity_c2; // from tagdp.needs to be mapped 
			       // @ the top level.

input	[11:0]	tag_way_sel_c2; // This can be a delayed version of the way selects.POST_3.0
input		vuad_tagdp_sel_c2_d1; //POST_3.0

// Adding all the mux control logic for tagdp and tagl_dp into 
// this block.
// All bist inputs come from a PX2 flop in the bist controller.
input   [3:0]   bist_way_px; // from tagbist
input           bist_enable_px; // from tagbist


                                 // calculations.
output  [2:0]   triad0_muxsel_c3;
output  [2:0]   triad1_muxsel_c3;
output  [2:0]   triad2_muxsel_c3;
output  [2:0]   triad3_muxsel_c3;
output  [3:0]   tag_quad_muxsel_c3 ; // to tagdp

input   [3:0]   arbdp_diag_wr_way_c2 ; // Wr or read way for tag Diagnostic Accesses.
input   [3:0]   arbctl_tecc_way_c2;
input           arbctl_normal_tagacc_c2 ; // indicates that lru way from vuad is used for
                                 // tag selection
input           arbctl_tagdp_tecc_c2; // NEW_PIN . sel tecc way
input		arbctl_tagdp_perr_vld_c2; // POST_2.0 PIN
input		mbctl_hit_c3; // POST_2.0 PIN

input           l2_dir_map_on;  // NEW_PIN from csr
input           arbctl_l2tag_vld_c4; // from tagctl
input		rst_tri_en;

input	[7:0]	mbist_write_data; // POST_4.2 signals
output	[7:0]	bist_vuad_wr_data ; // POST_4.2 signals.


input	[9:0]	mbist_l2v_index; // POST_4.2 signals
input		mbist_l2v_vd; // POST_4.2 signals
input		mbist_l2v_write; // POST_4.2 signals

output	[9:0]	bist_vuad_index; // POST_4.2 signals
output		bist_vuad_vd; // POST_4.2 signals
output		bist_vuad_write; // POST_4.2 signals

input	[25:0]	vuad_dp_diag_data_c7 ; // POST_4.2 signals
output	[25:0]	vuad_dp_diag_data_c7_buf; // POST_4.2 signals






input		 rclk;
input		 si, se;
input            grst_l;
input            arst_l;
input            dbginit_l;




output          tagdp_mbctl_par_err_c3 ;  // can be made a C3 signal.
output		tagdp_tagctl_par_err_c3; // used to gate off eviction way
output		tagdp_arbctl_par_err_c3; // used to gate off an eviction signal

output		tag_error_c8; // to fbctl and csr.


output		so;

input   [11:0]   vuad_dp_used_c2 ;
input   [11:0]   vuad_dp_alloc_c2 ;

output  [11:0]   lru_way_sel_c3;

// to tagdp
// All outputs are xmitted in C2 and used in C3.
// Buffer the following so that they can transmit to tagdp.

input           arbctl_evict_vld_c2;

output          evict_c3;
output		invalid_evict_c3;








wire	par_err_c2, par_err_c3;
wire	tagdp_par_err_c4, tagdp_par_err_c5;
wire	tag_error_c6, tag_error_c7 ;


wire   [2:0]   lru_triad0_muxsel_c2 ;
wire   [2:0]   lru_triad1_muxsel_c2 ;
wire   [2:0]   lru_triad2_muxsel_c2 ;
wire   [2:0]   lru_triad3_muxsel_c2 ;


wire    [3:0]   diag_wr_way_c3;
wire    [3:0]   diag_wr_way_c4;

wire    [3:0]   dec_lower_tag_way_c2;
wire    [3:0]   dec_high_tag_way_c2;

wire    [3:0]   bist_way_c1;
wire    [3:0]   bist_way_c2;
wire            bist_enable_c1;
wire            bist_enable_c2;

wire   [3:0]   lru_quad_muxsel_c2;
wire	[3:0]	lru_quad_muxsel_c3;

wire    [2:0]   tag_triad0_muxsel_c2 ;
wire    [2:0]   tag_triad1_muxsel_c2 ;
wire    [2:0]   tag_triad2_muxsel_c2 ;
wire    [2:0]   tag_triad3_muxsel_c2 ;

wire    [2:0] dir_triad0_way_c2, dir_triad1_way_c2 ;
wire    [2:0] dir_triad2_way_c2, dir_triad3_way_c2 ;

wire    [2:0]   tag_triad0_muxsel_c3;
wire    [2:0]   tag_triad1_muxsel_c3;
wire    [2:0]   tag_triad2_muxsel_c3;
wire    [2:0]   tag_triad3_muxsel_c3;


wire    [3:0]   dir_quad_way_c2;
wire    [3:0]   dir_quad_way_c3;
wire            sel_bist_way_c2 ;
wire            sel_diag_way_c4 ;
wire            sel_tecc_way_c2 ;

wire    [1:0]   enc_high_tag_way_c2;
wire    [1:0]   enc_lower_tag_way_c2;
wire            use_dec_sel_c2;
wire    use_dec_sel_c3;
wire    l2_dir_map_on_d1;
wire    sel_dir_way_c2; // pick way indicated by addr<21:18>

	
wire	[2:0] muxsel_triad0_way_c2 ;
wire	[2:0] muxsel_triad1_way_c2 ;
wire	[2:0] muxsel_triad2_way_c2 ;
wire	[2:0] muxsel_triad3_way_c2 ;
wire	nondep_tagdp_par_err_c3;
wire	evict_vld_c3_1, evict_vld_c3_2;
wire	evict_c3_1;
	

wire    dbb_rst_l;
wire	par_err_c3_2;

wire	[11:0]	lru_way_sel_c3_1;
wire	[11:0]	valid_c3;


// ----------------------\/ POST 4.2 repeater addition \/-------------------------
assign	bist_vuad_wr_data = mbist_write_data ;
assign	bist_vuad_write =  mbist_l2v_write ;
assign 	bist_vuad_vd = mbist_l2v_vd ;
assign	bist_vuad_index = mbist_l2v_index ;
assign	vuad_dp_diag_data_c7_buf = vuad_dp_diag_data_c7 ;
// ----------------------\/ POST 4.2 repeater addition \/-------------------------

///////////////////////////////////////////////////////////////////
// Reset flop
///////////////////////////////////////////////////////////////////

dffrl_async    #(1)    reset_flop      (.q(dbb_rst_l),
                                        .clk(rclk),
                                        .rst_l(arst_l),
                                        .din(grst_l),
                                        .se(se), .si(), .so());

dff_s   #(1)    ff_evict_c3_1
              (.q   (evict_vld_c3_1),
               .din (arbctl_evict_vld_c2),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;
dff_s   #(1)    ff_evict_c3_2
              (.q   (evict_vld_c3_2),
               .din (arbctl_evict_vld_c2),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;

assign  evict_c3     = evict_vld_c3_1 & ~par_err_c3 ;


assign	evict_c3_1  =  evict_vld_c3_2 & ~par_err_c3_2 ;


// evict qualification is performed in arbctl.
assign	invalid_evict_c3 =   |(lru_way_sel_c3_1 & ~valid_c3) ;



////////////////////////////////////////////
// The tag compare operation is a 27 bit
// compare. The overall Parity bit is 
// not part of the compare. 
// 
// An error in any bit of the tag will cause
// the lkup operation to fail except for
// that in the overall parity bit.
// In case of an error in P, we need to 
// turn off signalling a parity error.
//
// That is done using the not_hit_way_c2 signal
//assign	tagdp_par_err_c2 = 	arbctl_tagdp_perr_vld_c2 & // inst vld from arbctl
//	(|( tag_parity_c2 & not_hit_way_c2  )) ;
////////////////////////////////////////////

////////////////////////////////////////////
// An eviction is turned off if
// par_err_c3 is asserted. This is becuase
// the eviction could very well pick a way 
// with a corrupted tag and this would end
// up in memory corruption.
////////////////////////////////////////////


// the following signal is used for reporting purposes only
assign	par_err_c2 = arbctl_tagdp_perr_vld_c2 & |(tag_parity_c2 & vuad_dp_valid_c2);


// the following signals are used for control in the pipeline.
// In mbctl, tagctl, vuad, arbctl this par err signal is used
// for different purposes. In all cases it is used only for
// an EVICT instruction or for a miss.
// In mbctl, it is used in the insertion expression provided
// the instruction also misses the $ and FB.

dff_s  #(1)  ff_tagdp_par_err_c3  (.din(par_err_c2), .clk(rclk),
                              .q(par_err_c3), .se(se), .si(), .so());

dff_s  #(1)  ff_tagdp_par_err_c3_2  (.din(par_err_c2), .clk(rclk),
                              .q(par_err_c3_2), .se(se), .si(), .so());

dff_s  #(1)  ff_tagdp_mbctl_par_err_c3  (.din(par_err_c2), .clk(rclk),
                              .q(tagdp_mbctl_par_err_c3), .se(se), .si(), .so());

dff_s  #(1)  ff_tagdp_tagctl_par_err_c3  (.din(par_err_c2), .clk(rclk),
                              .q(tagdp_tagctl_par_err_c3), .se(se), .si(), .so());

dff_s  #(1)  ff_tagdp_arbctl_par_err_c3  (.din(par_err_c2), .clk(rclk),
                              .q(tagdp_arbctl_par_err_c3), .se(se), .si(), .so());


// In all the destination blocks, vuad, tagctl, mbctl and arbctl, this
// par_err signal is used only for a non-dep instruction.
// Dependents will not report a parity error at all.
// Hovewer, reporting is enabled for all hit cases that encounter a 
// tag corruption. 


assign	nondep_tagdp_par_err_c3 = par_err_c3 & ~mbctl_hit_c3;


dff_s  #(1)  ff_tagdp_par_err_c4  (.din(nondep_tagdp_par_err_c3), .clk(rclk),
                              .q(tagdp_par_err_c4), .se(se), .si(), .so());

dff_s  #(1)  ff_tagdp_par_err_c5  (.din(tagdp_par_err_c4), .clk(rclk),
                              .q(tagdp_par_err_c5), .se(se), .si(), .so());

dff_s  #(1)  ff_tag_error_c6  (.din(tagdp_par_err_c5), .clk(rclk),
                              .q(tag_error_c6), .se(se), .si(), .so());

dff_s  #(1)  ff_tag_error_c7  (.din(tag_error_c6), .clk(rclk),
                              .q(tag_error_c7), .se(se), .si(), .so());

dff_s  #(1)  ff_tag_error_c8  (.din(tag_error_c7), .clk(rclk),
                              .q(tag_error_c8), .se(se), .si(), .so());



/////////////////////////////////////////////
// Mux select generation to read
// out the evicted tag &
// 16:1 muxing of the tag read
//
// In C2 we generate the muxselects for all the
// 4 triads.
// These mux selects are generated for the following
// 2 categories of accesses.
// I)Normal accesses: sels generated by vuad_dp
// II) Direct Accesses: Diagnostic/direct mapped, BIST, tecc 
//
// In C3 we generate the mux selects for the 4-1 mux in
// this block.
/////////////////////////////////////////////


dff_s  #(1)  ff_l2_dir_map_on_d1  (.din(l2_dir_map_on), .clk(rclk),
		  .q(l2_dir_map_on_d1), .se(se), .si(), .so());

dff_s  #(4)  ff_diag_way_c3  (.din(arbdp_diag_wr_way_c2[3:0]), .clk(rclk),
          .q(diag_wr_way_c3[3:0]), .se(se), .si(), .so());

dff_s  #(4)  ff_diag_way_c4  (.din(diag_wr_way_c3[3:0]), .clk(rclk),
          .q(diag_wr_way_c4[3:0]), .se(se), .si(), .so());

dff_s  #(4)  ff_lru_quad_muxsel_c2  (.din(lru_quad_muxsel_c2[3:0]), .clk(rclk),
	  .q(lru_quad_muxsel_c3[3:0]), .se(se), .si(), .so());

dff_s  #(4)  ff_bist_way_c1  (.din(bist_way_px[3:0]), .clk(rclk),
	  .q(bist_way_c1[3:0]), .se(se), .si(), .so());

dff_s  #(4)  ff_bist_way_c2  (.din(bist_way_c1[3:0]), .clk(rclk),
	  .q(bist_way_c2[3:0]), .se(se), .si(), .so());

dff_s  #(1)  ff_bist_enable_c1  (.din(bist_enable_px), .clk(rclk),
	  .q(bist_enable_c1), .se(se), .si(), .so());

dff_s  #(1)  ff_bist_enable_c2  (.din(bist_enable_c1), .clk(rclk),
	  .q(bist_enable_c2), .se(se), .si(), .so());


assign	sel_bist_way_c2 =  bist_enable_c2 ;
assign	sel_diag_way_c4 = ~bist_enable_c2 & arbctl_l2tag_vld_c4;	
assign	sel_tecc_way_c2 = ~bist_enable_c2 & ~arbctl_l2tag_vld_c4  &
			arbctl_tagdp_tecc_c2 ;
assign	sel_dir_way_c2 = ~arbctl_tagdp_tecc_c2 & ~bist_enable_c2 &
			~arbctl_l2tag_vld_c4 ;

mux4ds	#(2)	mux_way_low (	.dout (enc_lower_tag_way_c2[1:0]),
                             	.in0(bist_way_c2[1:0]),  // bist way c2
				.in1(diag_wr_way_c4[1:0]), // diag way c4
                             	.in2(arbctl_tecc_way_c2[1:0]),// tecc way c2( from a counter in arbdec)
                             	.in3(arbdp_diag_wr_way_c2[1:0]),// addr_c2<19:18>
                             	.sel0(sel_bist_way_c2),  // bist way sel
				.sel1(sel_diag_way_c4), // no bist way sel and diag sel.
				.sel2(sel_tecc_way_c2), // tecc way
                             	.sel3(sel_dir_way_c2)); // default is dir mapped way.

assign	dec_lower_tag_way_c2[0] =(enc_lower_tag_way_c2 == 2'd0 ) ;
assign	dec_lower_tag_way_c2[1] =(enc_lower_tag_way_c2 == 2'd1 ) ;
assign	dec_lower_tag_way_c2[2] =(enc_lower_tag_way_c2 == 2'd2 ) ;
assign	dec_lower_tag_way_c2[3] =(enc_lower_tag_way_c2 == 2'd3 ) ;

mux4ds	#(2)	mux_way_high (.dout (enc_high_tag_way_c2[1:0]),
                             	.in0(bist_way_c2[3:2]), // bist way c2
				.in1(diag_wr_way_c4[3:2]),  // diag way c4
                             	.in2(arbctl_tecc_way_c2[3:2]), // tecc way c2( from a counter in arbdec)
                             	.in3(arbdp_diag_wr_way_c2[3:2]),// addr_c2<21:20>
                             	.sel0(sel_bist_way_c2), // bist way sel
				.sel1(sel_diag_way_c4), // no bist way sel and diag sel.
				.sel2(sel_tecc_way_c2), // tecc
                             	.sel3(sel_dir_way_c2)); // default is dir mapped way.

assign	dec_high_tag_way_c2[0] = (enc_high_tag_way_c2 == 2'd0 ) ;
assign	dec_high_tag_way_c2[1] = (enc_high_tag_way_c2 == 2'd1 ) ;
assign	dec_high_tag_way_c2[2] = (enc_high_tag_way_c2 == 2'd2 ) ;
assign	dec_high_tag_way_c2[3] = (enc_high_tag_way_c2 == 2'd3 ) ;

//  Triad0 muxselects
//  Tags in Triad0 correspond to way=0,1,2

assign	dir_triad0_way_c2[0] = dec_high_tag_way_c2[0]  & 
				dec_lower_tag_way_c2[0] ; // 0000
assign	dir_triad0_way_c2[1] = dec_high_tag_way_c2[0]  & 
				dec_lower_tag_way_c2[1] ; // 0001
assign	dir_triad0_way_c2[2] = dec_high_tag_way_c2[0]  & 
				dec_lower_tag_way_c2[2] ; // 0010

assign	dir_quad_way_c2[0] = |( dir_triad0_way_c2 ) ;
				

assign	muxsel_triad0_way_c2[1:0] = dir_triad0_way_c2[1:0];
assign	muxsel_triad0_way_c2[2] = ~( dir_triad0_way_c2[1] |
				dir_triad0_way_c2[0] ) ;
				
				
//  Triad1 muxselects
//  Tags in Triad1 correspond to way=3,4 or 12,5 or 13

assign	dir_triad1_way_c2[0] = dec_high_tag_way_c2[0]  & 
				dec_lower_tag_way_c2[3] ; // 0011

assign	dir_triad1_way_c2[1] = ( dec_high_tag_way_c2[1]  |
				 dec_high_tag_way_c2[3] )  & 
				dec_lower_tag_way_c2[0] ; // 0100 or 1100

assign	dir_triad1_way_c2[2] = ( dec_high_tag_way_c2[1]  |
				 dec_high_tag_way_c2[3] )  & 
				dec_lower_tag_way_c2[1] ; // 0101 or 1101

assign	dir_quad_way_c2[1] = |( dir_triad1_way_c2 ) ;
				
				
assign	muxsel_triad1_way_c2[1:0] = dir_triad1_way_c2[1:0];
assign	muxsel_triad1_way_c2[2] = ~( dir_triad1_way_c2[1] |
				dir_triad1_way_c2[0] ) ;
				
				

//  Triad2 muxselects
//  Tags in Triad2 correspond to way=6 or 14,7 or 15,8

assign	dir_triad2_way_c2[0] = ( dec_high_tag_way_c2[1]  |
				 dec_high_tag_way_c2[3] )  & 
				dec_lower_tag_way_c2[2] ; // 0110 or 1110

assign	dir_triad2_way_c2[1] = ( dec_high_tag_way_c2[1]  |
				 dec_high_tag_way_c2[3] )  & 
				dec_lower_tag_way_c2[3] ; // 0111 or 1111

assign	dir_triad2_way_c2[2] =  dec_high_tag_way_c2[2]   & 
				dec_lower_tag_way_c2[0] ; // 1000


assign	dir_quad_way_c2[2] = |( dir_triad2_way_c2 ) ;

assign	muxsel_triad2_way_c2[1:0] = dir_triad2_way_c2[1:0];
assign	muxsel_triad2_way_c2[2] = ~( dir_triad2_way_c2[1] |
				dir_triad2_way_c2[0] ) ;
				
//  Triad3 muxselects
//  Tags in Triad3 correspond to way=9, 10, 11

assign  dir_triad3_way_c2[0] =  dec_high_tag_way_c2[2]  &
                                dec_lower_tag_way_c2[1] ; // 1001

assign  dir_triad3_way_c2[1] = dec_high_tag_way_c2[2] &
				dec_lower_tag_way_c2[2] ; // 1010
                               
assign  dir_triad3_way_c2[2] =  dec_high_tag_way_c2[2]   &
                                dec_lower_tag_way_c2[3] ; // 1011


assign	dir_quad_way_c2[3] = |( dir_triad3_way_c2 ) ;


assign	use_dec_sel_c2 = ( ~arbctl_normal_tagacc_c2  |
				bist_enable_c2 |
				l2_dir_map_on_d1 ) ;

dff_s  #(1)  ff_use_dec_sel_c3  (.din(use_dec_sel_c2), .clk(rclk),
          .q(use_dec_sel_c3), .se(se), .si(), .so());

assign	muxsel_triad3_way_c2[1:0] = dir_triad3_way_c2[1:0];
assign	muxsel_triad3_way_c2[2] = ~( dir_triad3_way_c2[1] |
				dir_triad3_way_c2[0] ) ;
				
/////////
// TRIAD0
/////////

// Use a mux flop for the following to reduce the setup on lru_triad0_muxsel_c2
mux2ds #(3) mux_tag_triad0_muxsel_c2 ( .dout (tag_triad0_muxsel_c2[2:0]),
              			.in0(muxsel_triad0_way_c2[2:0]), 
				.in1(lru_triad0_muxsel_c2[2:0]),
              			.sel0(use_dec_sel_c2), 
				.sel1(~use_dec_sel_c2));

dff_s  #(3)  ff_tag_triad0_muxsel_c2  (.din(tag_triad0_muxsel_c2[2:0]), .clk(rclk),
                       .q(tag_triad0_muxsel_c3[2:0]), .se(se), .si(), .so());

// rst_tri_en required for mux ex
assign	triad0_muxsel_c3[2:1] = tag_triad0_muxsel_c3[2:1] & ~{2{rst_tri_en}} ;
assign	triad0_muxsel_c3[0] = tag_triad0_muxsel_c3[0]  |  rst_tri_en ;


/////////
// TRIAD1
/////////

// Use a mux flop for the following to reduce the setup on lru_triad1_muxsel_c2
mux2ds #(3) mux_tag_triad1_muxsel_c2 ( .dout (tag_triad1_muxsel_c2[2:0]),
                                .in0(muxsel_triad1_way_c2[2:0]),
                                .in1(lru_triad1_muxsel_c2[2:0]),
                                .sel0(use_dec_sel_c2),
                                .sel1(~use_dec_sel_c2));

dff_s  #(3)  ff_tag_triad1_muxsel_c2  (.din(tag_triad1_muxsel_c2[2:0]), .clk(rclk),
                       .q(tag_triad1_muxsel_c3[2:0]), .se(se), .si(), .so());

// rst_tri_en required for mux ex
assign  triad1_muxsel_c3[2:1] = tag_triad1_muxsel_c3[2:1] & ~{2{rst_tri_en}} ;
assign  triad1_muxsel_c3[0] = tag_triad1_muxsel_c3[0]  |  rst_tri_en ;



/////////
// TRIAD2
/////////

// Use a mux flop for the following to reduce the setup on lru_triad2_muxsel_c2
mux2ds #(3) mux_tag_triad2_muxsel_c2 ( .dout (tag_triad2_muxsel_c2[2:0]),
                                .in0(muxsel_triad2_way_c2[2:0]),
                                .in1(lru_triad2_muxsel_c2[2:0]),
                                .sel0(use_dec_sel_c2),
                                .sel1(~use_dec_sel_c2));

dff_s  #(3)  ff_tag_triad2_muxsel_c2  (.din(tag_triad2_muxsel_c2[2:0]), .clk(rclk),
                       .q(tag_triad2_muxsel_c3[2:0]), .se(se), .si(), .so());

// rst_tri_en required for mux ex
assign  triad2_muxsel_c3[2:1] = tag_triad2_muxsel_c3[2:1] & ~{2{rst_tri_en}} ;
assign  triad2_muxsel_c3[0] = tag_triad2_muxsel_c3[0]  |  rst_tri_en ;



/////////
// TRIAD3
/////////

// Use a mux flop for the following to reduce the setup on lru_triad3_muxsel_c2
mux2ds #(3) mux_tag_triad3_muxsel_c2 ( .dout (tag_triad3_muxsel_c2[2:0]),
                                .in0(muxsel_triad3_way_c2[2:0]),
                                .in1(lru_triad3_muxsel_c2[2:0]),
                                .sel0(use_dec_sel_c2),
                                .sel1(~use_dec_sel_c2));

dff_s  #(3)  ff_tag_triad3_muxsel_c2  (.din(tag_triad3_muxsel_c2[2:0]), .clk(rclk),
                       .q(tag_triad3_muxsel_c3[2:0]), .se(se), .si(), .so());

// rst_tri_en required for mux ex
assign  triad3_muxsel_c3[2:1] = tag_triad3_muxsel_c3[2:1] & ~{2{rst_tri_en}} ;
assign  triad3_muxsel_c3[0] = tag_triad3_muxsel_c3[0]  |  rst_tri_en ;










dff_s  #(4)  ff_dir_quad_way_c3  (.din(dir_quad_way_c2[3:0]), .clk(rclk),
                              .q(dir_quad_way_c3[3:0]), .se(se), .si(), .so());








/////////
// QUAD
/////////

// Use the C5 select from the diagnostic read/BIST or the C3 select from Lru.

assign	tag_quad_muxsel_c3[0] = (( dir_quad_way_c3[0]  & use_dec_sel_c3 ) 
				| ( ~use_dec_sel_c3 & lru_quad_muxsel_c3[0] ))  
				& ~rst_tri_en ;
assign	tag_quad_muxsel_c3[1] = (( dir_quad_way_c3[1]  & use_dec_sel_c3 ) 
				| ( ~use_dec_sel_c3 & lru_quad_muxsel_c3[1] ))  
				& ~rst_tri_en ;
assign	tag_quad_muxsel_c3[2] = (( dir_quad_way_c3[2]  & use_dec_sel_c3 ) 
				| ( ~use_dec_sel_c3 & lru_quad_muxsel_c3[2] ))  
				& ~rst_tri_en ;
assign	tag_quad_muxsel_c3[3] = (( dir_quad_way_c3[3]  & use_dec_sel_c3 ) 
				| ( ~use_dec_sel_c3 & lru_quad_muxsel_c3[3] ))  
				| rst_tri_en ;





//*****************************************************************************
// LRU state flop.
// * initialized to 1 on reset.
// * left shifted ( rotate) on every eviction.
// * else maintains its state.
//*****************************************************************************


wire		lshift_lru_triad0;
wire		no_lshift_lru_triad0;
wire	[2:0]	lru_state_lshift_triad0;
wire	[2:0]	lru_state_triad0 ;
wire	[2:0]	lru_state_triad0_p ;

wire            lshift_lru_triad1;
wire            no_lshift_lru_triad1;
wire    [2:0]   lru_state_lshift_triad1;
wire    [2:0]   lru_state_triad1 ;
wire    [2:0]   lru_state_triad1_p ;

wire            lshift_lru_triad2;
wire            no_lshift_lru_triad2;
wire    [2:0]   lru_state_lshift_triad2;
wire    [2:0]   lru_state_triad2 ;
wire    [2:0]   lru_state_triad2_p ;

wire            lshift_lru_triad3;
wire            no_lshift_lru_triad3;
wire    [2:0]   lru_state_lshift_triad3;
wire    [2:0]   lru_state_triad3 ;
wire    [2:0]   lru_state_triad3_p ;

wire		pick_triad0;
wire		pick_triad1;
wire		pick_triad2;
wire		pick_triad3;


wire	[11:0]	vec_unvuad_dp_used_c2;
wire	[11:0]	vec_unvuad_dp_alloc_c2;
wire	sel_unvuad_dp_used_c2;

//wire	vuad_dp_way_avail_c2;
wire	vec_unalloc0to2_c2;
wire	vec_unalloc3to5_c2;
wire	vec_unalloc6to8_c2;
wire	vec_unalloc9to11_c2;

wire	vec_unused0to2_c2;
wire	vec_unused3to5_c2;
wire	vec_unused6to8_c2;
wire	vec_unused9to11_c2;

wire	[3:0]	used_lru_quad_c2;

wire	[2:0]	used_lru_triad0_c2;
wire	[2:0]	used_lru_triad1_c2;
wire	[2:0]	used_lru_triad2_c2;
wire	[2:0]	used_lru_triad3_c2;

wire	[3:0]	alloc_lru_quad_c2;

wire	[2:0]	alloc_lru_triad0_c2;
wire	[2:0]	alloc_lru_triad1_c2;
wire	[2:0]	alloc_lru_triad2_c2;
wire	[2:0]	alloc_lru_triad3_c2;

wire	[2:0]	used_triad0_tagsel_c2;
wire	[2:0]	alloc_triad0_tagsel_c2;
wire	[2:0]	lru_triad0_tagsel_c2;
wire	[2:0]	used_triad1_tagsel_c2;
wire	[2:0]	alloc_triad1_tagsel_c2;
wire	[2:0]	lru_triad1_tagsel_c2;
wire	[2:0]	used_triad2_tagsel_c2;
wire	[2:0]	alloc_triad2_tagsel_c2;
wire	[2:0]	lru_triad2_tagsel_c2;
wire	[2:0]	used_triad3_tagsel_c2;
wire	[2:0]	alloc_triad3_tagsel_c2;
wire	[2:0]	lru_triad3_tagsel_c2;

wire	[3:0]	used_quad_sel_c2;
wire	[3:0]	alloc_quad_sel_c2;
wire	[3:0]	lru_quad_sel_c2;

wire	[11:0]	lru_way_sel_c2;

wire		lshift_lru;
wire		no_lshift_lru;
wire	[3:0]	lru_state_lshift;
wire	[3:0]	lru_state_p;
wire	[3:0]	lru_state;

wire		init_lru_state;
wire	[3:0]	dec_lo_dir_way_c2;
wire	[3:0]	dec_hi_dir_way_c2;
wire	[11:0]	dec_dir_way_c2;
wire	[11:0]	evict_way_sel_c2;

wire	[11:0]	spec_alloc_c2, spec_alloc_c3;
wire	[11:0]	mod_alloc_c2;


////////////////////////////////////////////////////////////////////////////////
// LRU algorithm is used to select a way, out of 16 ways, to be evicted out of
// the L2 Cache. The algorithm used for the way select is not a tru LRU (Least
// Recently Used) algorithm but Round Robin arbitration. Round Robin arbitration
// is done in two stages by dividing 12 ways in 4 triads of 3 ways each
// Triad0[3:0] = Way[2:0],
// Triad1[3:0] = Way[5:3],
// Triad2[3:0] = Way[8:6],
// Triad3[3:0] = Way[11:9].
//
// First Round Robin is done within each quads to select one of the 3 ways
// and then Round Robin is done to select one of the four quads.
// A 4 bit one hot shift register maintains the state of the arbiter. An one
// at the bit location corresponding to a way represents highest priority for
// that way. Everytime an eviction takes place, state register is updated by
// shifting it left by one bit otherwise state of the register does not change.
// State register is used in C2 for the way selection and it is updated in the
// C3. On reset state rtegister is initialized to a state such that way0 has the
// highest priority.
//
// Way selection algorithm depends on the Used and Allocate bit of the VUAD
// array, read during C1, for the way selection. First priority is given to the
// ways that has not been Used and has not been Allocated for the eviction in
// the previous cycle. If there is no Unused and Unallocated way then a way that
// has not been previously Allocated is given preference.
// Note : Invalid bit is not used for the way selection as if a way is Invalid
//        then its Used bit will not be set, so checking Invalid bit is
//        redundant.
////////////////////////////////////////////////////////////////////////////////


// QUAD ANCHOR

assign	init_lru_state	= ~dbb_rst_l | ~dbginit_l ;


assign	lshift_lru = evict_c3_1 & ~init_lru_state;
assign	no_lshift_lru = ~evict_c3_1 & ~init_lru_state ;
assign	lru_state_lshift = { lru_state[2:0], lru_state[3] } ;

mux3ds  #(4) mux_lru_st   (.dout (lru_state_p[3:0]),
                            .in0(4'b0001),
                            .in1(lru_state_lshift[3:0]),
                            .in2(lru_state[3:0]),
			    .sel0(init_lru_state),
                            .sel1(lshift_lru),
			    .sel2(no_lshift_lru));


dff_s    #(4)   ff_lru_state   (.din(lru_state_p[3:0]),
                               .clk(rclk),
                               .q(lru_state[3:0]),
                               .se(se),
                               .si(),
                               .so());


// Triad0 ANCHOR
assign  lshift_lru_triad0 = evict_c3_1 & pick_triad0 & ~init_lru_state;
assign  no_lshift_lru_triad0 = ~( evict_c3_1 &  pick_triad0 )  & ~init_lru_state   ;
assign  lru_state_lshift_triad0 = { lru_state_triad0[1:0], lru_state_triad0[2] } ;

mux3ds  #(3) mux_lru_st_triad0   (.dout (lru_state_triad0_p[2:0]),
                            .in0(3'b001),
                            .in1(lru_state_lshift_triad0[2:0]),
                            .in2(lru_state_triad0[2:0]),
                            .sel0(init_lru_state),
                            .sel1(lshift_lru_triad0),
                            .sel2(no_lshift_lru_triad0));


dff_s    #(3)   ff_lru_state_triad0   (.din(lru_state_triad0_p[2:0]),
                               .clk(rclk),
                               .q(lru_state_triad0[2:0]),
                               .se(se),
                               .si(),
                               .so());


// Triad1 ANCHOR
assign  lshift_lru_triad1 = evict_c3_1 & pick_triad1 & ~init_lru_state;
assign  no_lshift_lru_triad1 = ~( evict_c3_1 &  pick_triad1 )  & ~init_lru_state   ;
assign  lru_state_lshift_triad1 = { lru_state_triad1[1:0], lru_state_triad1[2] } ;

mux3ds  #(3) mux_lru_st_triad1   (.dout (lru_state_triad1_p[2:0]),
                            .in0(3'b001),
                            .in1(lru_state_lshift_triad1[2:0]),
                            .in2(lru_state_triad1[2:0]),
                            .sel0(init_lru_state),
                            .sel1(lshift_lru_triad1),
                            .sel2(no_lshift_lru_triad1));


dff_s    #(3)   ff_lru_state_triad1   (.din(lru_state_triad1_p[2:0]),
                               .clk(rclk),
                               .q(lru_state_triad1[2:0]),
                               .se(se),
                               .si(),
                               .so());

// Triad2 ANCHOR
assign  lshift_lru_triad2 = evict_c3_1 & pick_triad2 & ~init_lru_state;
assign  no_lshift_lru_triad2 = ~( evict_c3_1 &  pick_triad2 )  & ~init_lru_state   ;
assign  lru_state_lshift_triad2 = { lru_state_triad2[1:0], lru_state_triad2[2] } ;

mux3ds  #(3) mux_lru_st_triad2   (.dout (lru_state_triad2_p[2:0]),
                            .in0(3'b001),
                            .in1(lru_state_lshift_triad2[2:0]),
                            .in2(lru_state_triad2[2:0]),
                            .sel0(init_lru_state),
                            .sel1(lshift_lru_triad2),
                            .sel2(no_lshift_lru_triad2));


dff_s    #(3)   ff_lru_state_triad2   (.din(lru_state_triad2_p[2:0]),
                               .clk(rclk),
                               .q(lru_state_triad2[2:0]),
                               .se(se),
                               .si(),
                               .so());


// Triad2 ANCHOR
assign  lshift_lru_triad3 = evict_c3_1 & pick_triad3 & ~init_lru_state;
assign  no_lshift_lru_triad3 = ~( evict_c3_1 &  pick_triad3 )  & ~init_lru_state   ;
assign  lru_state_lshift_triad3 = { lru_state_triad3[1:0], lru_state_triad3[2] } ;

mux3ds  #(3) mux_lru_st_triad3   (.dout (lru_state_triad3_p[2:0]),
                            .in0(3'b001),
                            .in1(lru_state_lshift_triad3[2:0]),
                            .in2(lru_state_triad3[2:0]),
                            .sel0(init_lru_state),
                            .sel1(lshift_lru_triad3),
                            .sel2(no_lshift_lru_triad3));


dff_s    #(3)   ff_lru_state_triad3   (.din(lru_state_triad3_p[2:0]),
                               .clk(rclk),
                               .q(lru_state_triad3[2:0]),
                               .se(se),
                               .si(),
                               .so());




//************************************************************************************
// LRU algorithm
// *  3 vectors are computed ( Invalid[15:0], Unused[15:0], Unallocated[15:0] )
// *  On vector is selected based on the 3 select bits read out of the array in C1,
//    invalid, unused, unallocated
// *  A state register is used to decide which quadrant to pick.
// *  The same state register picks a way in each of the 4 quadrants.
//************************************************************************************

//
// If an instruction in C2 sets the alloc bit, it needs to be bypassed
// to the instruction that immediately follows it. This is done speculatively
// using the spec_alloc_c3 signal if the instruction in C2 is to the same index
// as an instruction in C3.


assign	spec_alloc_c2 = ( tag_way_sel_c2 & vuad_dp_valid_c2 ) ;

dff_s    #(12)   ff_spec_alloc_c3   (.din(spec_alloc_c2[11:0]),
                               .clk(rclk), .q(spec_alloc_c3[11:0]),
                               .se(se), .si(), .so());

assign	mod_alloc_c2 = ( vuad_dp_alloc_c2 | 
			( spec_alloc_c3  & {12{vuad_tagdp_sel_c2_d1}} ) );

// 2-3 gates.
assign	vec_unvuad_dp_used_c2 = ~vuad_dp_used_c2 & ~mod_alloc_c2 ; 
assign	vec_unvuad_dp_alloc_c2 = ~mod_alloc_c2 ;	

assign	sel_unvuad_dp_used_c2 = |( vec_unvuad_dp_used_c2) ; // WAY lock will be ORED to this

// 2-3 gates.
assign	vec_unused0to2_c2   = |(vec_unvuad_dp_used_c2[2:0]);
assign	vec_unused3to5_c2   = |(vec_unvuad_dp_used_c2[5:3]);
assign	vec_unused6to8_c2  = |(vec_unvuad_dp_used_c2[8:6]);
assign	vec_unused9to11_c2 = |(vec_unvuad_dp_used_c2[11:9]);

// vec_unallocxtoxc2 is used to select one of the four quads.
assign	vec_unalloc0to2_c2   = |(vec_unvuad_dp_alloc_c2[2:0]);
assign	vec_unalloc3to5_c2   = |(vec_unvuad_dp_alloc_c2[5:3]);
assign	vec_unalloc6to8_c2  = |(vec_unvuad_dp_alloc_c2[8:6]);
assign	vec_unalloc9to11_c2 = |(vec_unvuad_dp_alloc_c2[11:9]);


/////////////////////////////
//UNUSED ROUND ROBIN PICK
/////////////////////////////
assign	used_lru_quad_c2 = {  vec_unused9to11_c2, 
			vec_unused6to8_c2, 
			vec_unused3to5_c2, 
			vec_unused0to2_c2 } ;

assign	used_lru_triad0_c2 = vec_unvuad_dp_used_c2[2:0] ;
assign	used_lru_triad1_c2 = vec_unvuad_dp_used_c2[5:3] ;
assign	used_lru_triad2_c2 = vec_unvuad_dp_used_c2[8:6] ;
assign	used_lru_triad3_c2 = vec_unvuad_dp_used_c2[11:9] ;

/////////////////////////////
//UNALLOC ROUND ROBIN PICK
/////////////////////////////
assign	alloc_lru_quad_c2 = { vec_unalloc9to11_c2, 
			vec_unalloc6to8_c2, 	
			vec_unalloc3to5_c2, 
			vec_unalloc0to2_c2 } ;

assign	alloc_lru_triad0_c2 = vec_unvuad_dp_alloc_c2[2:0] ;
assign	alloc_lru_triad1_c2 = vec_unvuad_dp_alloc_c2[5:3] ;
assign	alloc_lru_triad2_c2 = vec_unvuad_dp_alloc_c2[8:6] ;
assign	alloc_lru_triad3_c2 = vec_unvuad_dp_alloc_c2[11:9] ;

/************ LRU way within triad0 ************************/


assign  used_triad0_tagsel_c2[0] =   used_lru_triad0_c2[0] &
          ( lru_state_triad0[0]  |
          ( lru_state_triad0[1] & ~( used_lru_triad0_c2[1] |
                        used_lru_triad0_c2[2] ) ) |
          ( lru_state_triad0[2] & ~used_lru_triad0_c2[2] ) ) ;

assign  used_triad0_tagsel_c2[1] =   used_lru_triad0_c2[1] &
          ( lru_state_triad0[1]  |
          ( lru_state_triad0[2] & ~( used_lru_triad0_c2[2] |
                        used_lru_triad0_c2[0] )) |
          ( lru_state_triad0[0] & ~used_lru_triad0_c2[0])  ) ;

assign  used_triad0_tagsel_c2[2] =   used_lru_triad0_c2[2] &
          ( lru_state_triad0[2]  |
          ( lru_state_triad0[0] & ~(used_lru_triad0_c2[0] | 
			used_lru_triad0_c2[1])) |
          ( lru_state_triad0[1] & ~used_lru_triad0_c2[1] ) ) ;
               

assign  alloc_triad0_tagsel_c2[0] =   alloc_lru_triad0_c2[0] &
          ( lru_state_triad0[0]  |
          ( lru_state_triad0[1] & ~( alloc_lru_triad0_c2[1] |
                        alloc_lru_triad0_c2[2] ) ) |
          ( lru_state_triad0[2] & ~alloc_lru_triad0_c2[2] ) ) ;

assign  alloc_triad0_tagsel_c2[1] =   alloc_lru_triad0_c2[1] &
          ( lru_state_triad0[1]  |
          ( lru_state_triad0[2] & ~( alloc_lru_triad0_c2[2] |
                        alloc_lru_triad0_c2[0] )) |
          ( lru_state_triad0[0] & ~alloc_lru_triad0_c2[0])  ) ;

assign  alloc_triad0_tagsel_c2[2] =   alloc_lru_triad0_c2[2] &
          ( lru_state_triad0[2]  |
          ( lru_state_triad0[0] & ~(alloc_lru_triad0_c2[0] | 
			alloc_lru_triad0_c2[1])) |
          ( lru_state_triad0[1] & ~alloc_lru_triad0_c2[1] ) ) ;



mux2ds  #(3) mux_used_lru_triad0   (.dout (lru_triad0_tagsel_c2[2:0]),
                            .in0(used_triad0_tagsel_c2[2:0]),
                            .in1(alloc_triad0_tagsel_c2[2:0]),
                            .sel0(sel_unvuad_dp_used_c2),
                            .sel1(~sel_unvuad_dp_used_c2));


assign	lru_triad0_muxsel_c2[1:0] = lru_triad0_tagsel_c2[1:0] ;
assign	lru_triad0_muxsel_c2[2] = ~( lru_triad0_tagsel_c2[1] | lru_triad0_tagsel_c2[0] ) ;

/************ LRU way within triad1 ************************/


assign  used_triad1_tagsel_c2[0] =   used_lru_triad1_c2[0] &
          ( lru_state_triad1[0]  |
          ( lru_state_triad1[1] & ~( used_lru_triad1_c2[1] |
                        used_lru_triad1_c2[2] ) ) |
          ( lru_state_triad1[2] & ~used_lru_triad1_c2[2] ) ) ;

assign  used_triad1_tagsel_c2[1] =   used_lru_triad1_c2[1] &
          ( lru_state_triad1[1]  |
          ( lru_state_triad1[2] & ~( used_lru_triad1_c2[2] |
                        used_lru_triad1_c2[0] )) |
          ( lru_state_triad1[0] & ~used_lru_triad1_c2[0])  ) ;

assign  used_triad1_tagsel_c2[2] =   used_lru_triad1_c2[2] &
          ( lru_state_triad1[2]  |
          ( lru_state_triad1[0] & ~(used_lru_triad1_c2[0] | 
			used_lru_triad1_c2[1])) |
          ( lru_state_triad1[1] & ~used_lru_triad1_c2[1] ) ) ;
               

assign  alloc_triad1_tagsel_c2[0] =   alloc_lru_triad1_c2[0] &
          ( lru_state_triad1[0]  |
          ( lru_state_triad1[1] & ~( alloc_lru_triad1_c2[1] |
                        alloc_lru_triad1_c2[2] ) ) |
          ( lru_state_triad1[2] & ~alloc_lru_triad1_c2[2] ) ) ;

assign  alloc_triad1_tagsel_c2[1] =   alloc_lru_triad1_c2[1] &
          ( lru_state_triad1[1]  |
          ( lru_state_triad1[2] & ~( alloc_lru_triad1_c2[2] |
                        alloc_lru_triad1_c2[0] )) |
          ( lru_state_triad1[0] & ~alloc_lru_triad1_c2[0])  ) ;

assign  alloc_triad1_tagsel_c2[2] =   alloc_lru_triad1_c2[2] &
          ( lru_state_triad1[2]  |
          ( lru_state_triad1[0] & ~(alloc_lru_triad1_c2[0] | 
			alloc_lru_triad1_c2[1])) |
          ( lru_state_triad1[1] & ~alloc_lru_triad1_c2[1] ) ) ;



mux2ds  #(3) mux_used_lru_triad1   (.dout (lru_triad1_tagsel_c2[2:0]),
                            .in0(used_triad1_tagsel_c2[2:0]),
                            .in1(alloc_triad1_tagsel_c2[2:0]),
                            .sel0(sel_unvuad_dp_used_c2),
                            .sel1(~sel_unvuad_dp_used_c2));



assign	lru_triad1_muxsel_c2[1:0] = lru_triad1_tagsel_c2[1:0] ;
assign	lru_triad1_muxsel_c2[2] = ~( lru_triad1_tagsel_c2[1] | lru_triad1_tagsel_c2[0] ) ;


/************ LRU way within triad2 ************************/


assign  used_triad2_tagsel_c2[0] =   used_lru_triad2_c2[0] &
          ( lru_state_triad2[0]  |
          ( lru_state_triad2[1] & ~( used_lru_triad2_c2[1] |
                        used_lru_triad2_c2[2] ) ) |
          ( lru_state_triad2[2] & ~used_lru_triad2_c2[2] ) ) ;

assign  used_triad2_tagsel_c2[1] =   used_lru_triad2_c2[1] &
          ( lru_state_triad2[1]  |
          ( lru_state_triad2[2] & ~( used_lru_triad2_c2[2] |
                        used_lru_triad2_c2[0] )) |
          ( lru_state_triad2[0] & ~used_lru_triad2_c2[0])  ) ;

assign  used_triad2_tagsel_c2[2] =   used_lru_triad2_c2[2] &
          ( lru_state_triad2[2]  |
          ( lru_state_triad2[0] & ~(used_lru_triad2_c2[0] | 
			used_lru_triad2_c2[1])) |
          ( lru_state_triad2[1] & ~used_lru_triad2_c2[1] ) ) ;
               

assign  alloc_triad2_tagsel_c2[0] =   alloc_lru_triad2_c2[0] &
          ( lru_state_triad2[0]  |
          ( lru_state_triad2[1] & ~( alloc_lru_triad2_c2[1] |
                        alloc_lru_triad2_c2[2] ) ) |
          ( lru_state_triad2[2] & ~alloc_lru_triad2_c2[2] ) ) ;

assign  alloc_triad2_tagsel_c2[1] =   alloc_lru_triad2_c2[1] &
          ( lru_state_triad2[1]  |
          ( lru_state_triad2[2] & ~( alloc_lru_triad2_c2[2] |
                        alloc_lru_triad2_c2[0] )) |
          ( lru_state_triad2[0] & ~alloc_lru_triad2_c2[0])  ) ;

assign  alloc_triad2_tagsel_c2[2] =   alloc_lru_triad2_c2[2] &
          ( lru_state_triad2[2]  |
          ( lru_state_triad2[0] & ~(alloc_lru_triad2_c2[0] | 
			alloc_lru_triad2_c2[1])) |
          ( lru_state_triad2[1] & ~alloc_lru_triad2_c2[1] ) ) ;



mux2ds  #(3) mux_used_lru_triad2   (.dout (lru_triad2_tagsel_c2[2:0]),
                            .in0(used_triad2_tagsel_c2[2:0]),
                            .in1(alloc_triad2_tagsel_c2[2:0]),
                            .sel0(sel_unvuad_dp_used_c2),
                            .sel1(~sel_unvuad_dp_used_c2));


assign	lru_triad2_muxsel_c2[1:0] = lru_triad2_tagsel_c2[1:0] ;
assign	lru_triad2_muxsel_c2[2] = ~( lru_triad2_tagsel_c2[1] | lru_triad2_tagsel_c2[0] ) ;


/************ LRU way within triad3 ************************/


assign  used_triad3_tagsel_c2[0] =   used_lru_triad3_c2[0] &
          ( lru_state_triad3[0]  |
          ( lru_state_triad3[1] & ~( used_lru_triad3_c2[1] |
                        used_lru_triad3_c2[2] ) ) |
          ( lru_state_triad3[2] & ~used_lru_triad3_c2[2] ) ) ;

assign  used_triad3_tagsel_c2[1] =   used_lru_triad3_c2[1] &
          ( lru_state_triad3[1]  |
          ( lru_state_triad3[2] & ~( used_lru_triad3_c2[2] |
                        used_lru_triad3_c2[0] )) |
          ( lru_state_triad3[0] & ~used_lru_triad3_c2[0])  ) ;

assign  used_triad3_tagsel_c2[2] =   used_lru_triad3_c2[2] &
          ( lru_state_triad3[2]  |
          ( lru_state_triad3[0] & ~(used_lru_triad3_c2[0] | 
			used_lru_triad3_c2[1])) |
          ( lru_state_triad3[1] & ~used_lru_triad3_c2[1] ) ) ;
               

assign  alloc_triad3_tagsel_c2[0] =   alloc_lru_triad3_c2[0] &
          ( lru_state_triad3[0]  |
          ( lru_state_triad3[1] & ~( alloc_lru_triad3_c2[1] |
                        alloc_lru_triad3_c2[2] ) ) |
          ( lru_state_triad3[2] & ~alloc_lru_triad3_c2[2] ) ) ;

assign  alloc_triad3_tagsel_c2[1] =   alloc_lru_triad3_c2[1] &
          ( lru_state_triad3[1]  |
          ( lru_state_triad3[2] & ~( alloc_lru_triad3_c2[2] |
                        alloc_lru_triad3_c2[0] )) |
          ( lru_state_triad3[0] & ~alloc_lru_triad3_c2[0])  ) ;

assign  alloc_triad3_tagsel_c2[2] =   alloc_lru_triad3_c2[2] &
          ( lru_state_triad3[2]  |
          ( lru_state_triad3[0] & ~(alloc_lru_triad3_c2[0] | 
			alloc_lru_triad3_c2[1])) |
          ( lru_state_triad3[1] & ~alloc_lru_triad3_c2[1] ) ) ;



mux2ds  #(3) mux_used_lru_triad3   (.dout (lru_triad3_tagsel_c2[2:0]),
                            .in0(used_triad3_tagsel_c2[2:0]),
                            .in1(alloc_triad3_tagsel_c2[2:0]),
                            .sel0(sel_unvuad_dp_used_c2),
                            .sel1(~sel_unvuad_dp_used_c2));


assign	lru_triad3_muxsel_c2[1:0] = lru_triad3_tagsel_c2[1:0] ;
assign	lru_triad3_muxsel_c2[2] = ~( lru_triad3_tagsel_c2[1] | lru_triad3_tagsel_c2[0] ) ;


/************ LRU  quad ************************/


assign  used_quad_sel_c2[0] =   used_lru_quad_c2[0] &
                ( lru_state[0]  |
          ( lru_state[1] & ~( used_lru_quad_c2[1] |
                        used_lru_quad_c2[2] | used_lru_quad_c2[3] )) |
          ( lru_state[2] & ~( used_lru_quad_c2[2] | used_lru_quad_c2[3] )) |
          ( lru_state[3] & ~(used_lru_quad_c2[3] ))  ) ;

assign  used_quad_sel_c2[1] =   used_lru_quad_c2[1] &
                ( lru_state[1]  |
          ( lru_state[2] & ~( used_lru_quad_c2[0] |
                        used_lru_quad_c2[2] | used_lru_quad_c2[3] )) |
          ( lru_state[3] & ~( used_lru_quad_c2[3] | used_lru_quad_c2[0] )) |
          ( lru_state[0] & ~(used_lru_quad_c2[0] ))  ) ;

assign  used_quad_sel_c2[2] =   used_lru_quad_c2[2] &
                ( lru_state[2]  |
          ( lru_state[3] & ~( used_lru_quad_c2[0] |
                        used_lru_quad_c2[1] | used_lru_quad_c2[3] )) |
          ( lru_state[0] & ~( used_lru_quad_c2[0] | used_lru_quad_c2[1] )) |
          ( lru_state[1] & ~(used_lru_quad_c2[1] ))  ) ;

assign  used_quad_sel_c2[3] =   used_lru_quad_c2[3] &
                ( lru_state[3]  |
          ( lru_state[0] & ~( used_lru_quad_c2[0] |
                                used_lru_quad_c2[1] | used_lru_quad_c2[2] )) |
          ( lru_state[1] & ~( used_lru_quad_c2[2] | used_lru_quad_c2[1] )) |
          ( lru_state[2] & ~(used_lru_quad_c2[2] ))  ) ;


assign  alloc_quad_sel_c2[0] =   alloc_lru_quad_c2[0] &
                ( lru_state[0]  |
          ( lru_state[1] & ~( alloc_lru_quad_c2[1] |
                        alloc_lru_quad_c2[2] | alloc_lru_quad_c2[3] )) |
          ( lru_state[2] & ~( alloc_lru_quad_c2[2] | alloc_lru_quad_c2[3] )) |
          ( lru_state[3] & ~(alloc_lru_quad_c2[3] ))  ) ;

assign  alloc_quad_sel_c2[1] =   alloc_lru_quad_c2[1] &
                ( lru_state[1]  |
          ( lru_state[2] & ~( alloc_lru_quad_c2[0] |
                        alloc_lru_quad_c2[2] | alloc_lru_quad_c2[3] )) |
          ( lru_state[3] & ~( alloc_lru_quad_c2[3] | alloc_lru_quad_c2[0] )) |
          ( lru_state[0] & ~(alloc_lru_quad_c2[0] ))  ) ;

assign  alloc_quad_sel_c2[2] =   alloc_lru_quad_c2[2] &
                ( lru_state[2]  |
          ( lru_state[3] & ~( alloc_lru_quad_c2[0] |
                        alloc_lru_quad_c2[1] | alloc_lru_quad_c2[3] )) |
          ( lru_state[0] & ~( alloc_lru_quad_c2[0] | alloc_lru_quad_c2[1] )) |
          ( lru_state[1] & ~(alloc_lru_quad_c2[1] ))  ) ;

assign  alloc_quad_sel_c2[3] =   alloc_lru_quad_c2[3] &
                ( lru_state[3]  |
          ( lru_state[0] & ~( alloc_lru_quad_c2[0] |
                                alloc_lru_quad_c2[1] | alloc_lru_quad_c2[2] )) |
          ( lru_state[1] & ~( alloc_lru_quad_c2[2] | alloc_lru_quad_c2[1] )) |
          ( lru_state[2] & ~(alloc_lru_quad_c2[2] ))  ) ;

mux2ds  #(4) mux_used_lru_quad   (.dout (lru_quad_sel_c2[3:0]),
                            .in0(used_quad_sel_c2[3:0]),
                            .in1(alloc_quad_sel_c2[3:0]),
                            .sel0(sel_unvuad_dp_used_c2),
                            .sel1(~sel_unvuad_dp_used_c2));

assign	lru_quad_muxsel_c2[2:0] = lru_quad_sel_c2[2:0] ;
assign	lru_quad_muxsel_c2[3] = ~( lru_quad_sel_c2[2] | lru_quad_sel_c2[1] | lru_quad_sel_c2[0] ) ;


// lru_way_sel_c2 takes 14-15 gates to compute.
assign	lru_way_sel_c2[2:0]   = lru_triad0_tagsel_c2 & {3{lru_quad_sel_c2[0]}} ;
assign	lru_way_sel_c2[5:3]   = lru_triad1_tagsel_c2 & {3{lru_quad_sel_c2[1]}} ;
assign	lru_way_sel_c2[8:6]  = lru_triad2_tagsel_c2 & {3{lru_quad_sel_c2[2]}} ;
assign	lru_way_sel_c2[11:9] = lru_triad3_tagsel_c2 & {3{lru_quad_sel_c2[3]}} ;


assign	dec_lo_dir_way_c2[0] = ( arbdp_diag_wr_way_c2[1:0]==2'd0 ) ;
assign	dec_lo_dir_way_c2[1] = ( arbdp_diag_wr_way_c2[1:0]==2'd1 ) ;
assign	dec_lo_dir_way_c2[2] = ( arbdp_diag_wr_way_c2[1:0]==2'd2 ) ;
assign	dec_lo_dir_way_c2[3] = ( arbdp_diag_wr_way_c2[1:0]==2'd3 ) ;


assign	dec_hi_dir_way_c2[0] = ( arbdp_diag_wr_way_c2[3:2]==2'd0 ) ;
assign	dec_hi_dir_way_c2[1] = ( arbdp_diag_wr_way_c2[3:2]==2'd1 ) ;
assign	dec_hi_dir_way_c2[2] = ( arbdp_diag_wr_way_c2[3:2]==2'd2 ) ;
assign	dec_hi_dir_way_c2[3] = ( arbdp_diag_wr_way_c2[3:2]==2'd3 ) ;


assign	dec_dir_way_c2[0] = dec_hi_dir_way_c2[0] &
				dec_lo_dir_way_c2[0] ; // 0000

assign	dec_dir_way_c2[1] = dec_hi_dir_way_c2[0] &
				dec_lo_dir_way_c2[1] ; // 0001

assign	dec_dir_way_c2[2] = dec_hi_dir_way_c2[0] &
				dec_lo_dir_way_c2[2] ; // 0010

assign	dec_dir_way_c2[3] = dec_hi_dir_way_c2[0] &
				dec_lo_dir_way_c2[3] ; // 0011

assign  dec_dir_way_c2[4] = ( dec_hi_dir_way_c2[1] |
				dec_hi_dir_way_c2[3] )  &
                                dec_lo_dir_way_c2[0] ; // 0100 or 1100

assign  dec_dir_way_c2[5] = ( dec_hi_dir_way_c2[1] |
				dec_hi_dir_way_c2[3] )  &
                                dec_lo_dir_way_c2[1] ; // 0101 or 1101

assign  dec_dir_way_c2[6] = ( dec_hi_dir_way_c2[1] |
				dec_hi_dir_way_c2[3] )  &
                                dec_lo_dir_way_c2[2] ; // 0110 or 1110

assign  dec_dir_way_c2[7] = ( dec_hi_dir_way_c2[1] |
				dec_hi_dir_way_c2[3] )  &
                                dec_lo_dir_way_c2[3] ; // 0111 or 1111


assign	dec_dir_way_c2[8] = dec_hi_dir_way_c2[2] &
				dec_lo_dir_way_c2[0] ; // 1000

assign	dec_dir_way_c2[9] = dec_hi_dir_way_c2[2] &
				dec_lo_dir_way_c2[1] ; // 1001

assign	dec_dir_way_c2[10] = dec_hi_dir_way_c2[2] &
				dec_lo_dir_way_c2[2] ; // 1010

assign	dec_dir_way_c2[11] = dec_hi_dir_way_c2[2] &
				dec_lo_dir_way_c2[3] ; // 1011


mux2ds #(12)  mux_evict_way_sel_c2
              (.dout (evict_way_sel_c2[11:0]),
               .in0  (dec_dir_way_c2[11:0]),  .sel0 (l2_dir_map_on_d1),
               .in1  (lru_way_sel_c2[11:0]),  .sel1 (~l2_dir_map_on_d1)
              ) ;


dff_s    #(12)   ff_lru_way_c3   (.din(evict_way_sel_c2[11:0]),
                               .clk(rclk),
                               .q(lru_way_sel_c3[11:0]),
                               .se(se),
                               .si(),
                               .so());

dff_s    #(12)   ff_lru_way_c3_1   (.din(evict_way_sel_c2[11:0]),
                               .clk(rclk),
                               .q(lru_way_sel_c3_1[11:0]),
                               .se(se),
                               .si(),
                               .so());

dff_s    #(12)   ff_valid_c3   (.din(vuad_dp_valid_c2[11:0]),
                               .clk(rclk),
                               .q(valid_c3[11:0]),
                               .se(se),
                               .si(),
                               .so());

assign	pick_triad0 = |(lru_way_sel_c3_1[2:0]  ) ;
assign	pick_triad1 = |(lru_way_sel_c3_1[5:3]  ) ;
assign	pick_triad2 = |(lru_way_sel_c3_1[8:6] ) ;
assign	pick_triad3 = |(lru_way_sel_c3_1[11:9]) ;

endmodule




