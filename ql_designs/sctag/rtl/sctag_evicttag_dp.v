// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_evicttag_dp.v
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
// Change 4/7/2003: Added a pin, vuad_idx_c3 to the bottom.
////////////////////////////////////////////////////////////////////////

module sctag_evicttag_dp( /*AUTOARG*/
   // Outputs
   evicttag_addr_px2, so, evict_addr, sctag_dram_addr, lkup_addr_c1, 
   mb_write_addr, wb_write_addr, vuad_idx_c3, 
   // Inputs
   wb_read_data, rdma_read_data, mb_read_data, fb_read_data, 
   arbdp_cam_addr_px2, tagdp_evict_tag_c4, wbctl_wr_addr_sel, 
   wb_or_rdma_wr_req_en, mbctl_arb_l2rd_en, mbctl_arb_dramrd_en, 
   fbctl_arb_l2rd_en, mux1_mbsel_px1, arbctl_evict_c4, rclk, si, se, 
   sehold
   );





output	[39:0]	evicttag_addr_px2;
output		so;
output	[39:6]	evict_addr ; 	    // to the csr block
output	[39:5]	sctag_dram_addr;
output	[39:8]	lkup_addr_c1; // address to lkup buffer tags.
output	[39:0]	mb_write_addr; 
output	[39:0]	wb_write_addr;
output	[9:0]	vuad_idx_c3; // Bottom.

input	[39:6]	wb_read_data ; // wr address from wb
input	[39:6]	rdma_read_data; // wr address from rdmawb
input	[39:0]	mb_read_data;
input	[39:0]	fb_read_data;

input	[39:0]	arbdp_cam_addr_px2;
input	[`TAG_WIDTH-1:6] tagdp_evict_tag_c4;

input	wbctl_wr_addr_sel ; // sel wb_read_data
input	wb_or_rdma_wr_req_en ; // enable wr addr flop.
input	mbctl_arb_l2rd_en;
input	mbctl_arb_dramrd_en;
input	fbctl_arb_l2rd_en;
input	mux1_mbsel_px1; // from arbctl
input	arbctl_evict_c4;// from arbctl.

input		rclk; 
input		si, se ;
input	sehold;

wire	[39:0]	mbf_addr_px2, fbf_addr_px2;
wire		dram_pick_d2;
wire	[39:6]	evict_rd_data;
wire	[39:6]	dram_wr_addr;
wire	[39:5]	dram_read_addr;


wire	[39:0]	inst_addr_c1; 
wire	[39:0]	inst_addr_c2, inst_addr_c3;
wire	[39:0] inst_addr_c4;
wire	[39:0] evict_addr_c4;
wire	mux1_mbsel_px2_1;
wire	mux1_mbsel_px2_2;
wire	mux1_mbsel_px2_3;
wire	mux1_mbsel_px2_4;
//////////////////////////////
// Arb mux between MB and FB
//////////////////////////////

dff_s    #(40) ff_read_mb_tag_reg    (.din(mb_read_data[39:0]), .clk(clk_1),
		.q(mbf_addr_px2[39:0]), .se(se), .si(), .so());
clken_buf  clk_buf1  (.clk(clk_1), .rclk(rclk), .enb_l(~mbctl_arb_l2rd_en), .tmb_l(~se));


dff_s    #(40) ff_read_fb_tag_reg    (.din(fb_read_data[39:0]), .clk(clk_2),
		.q(fbf_addr_px2[39:0]), .se(se), .si(), .so());
clken_buf  clk_buf2  (.clk(clk_2), .rclk(rclk), .enb_l(~fbctl_arb_l2rd_en), .tmb_l(~se));


// Change 6/12/2003: 
// -created 4 sets fo selects for the evicttag_addr_px2 mux.
// -in the implementation, invert the data before muxing,
//  use a 2x or 4x mux and drive the output of the mux
// with a 40x driver.

dff_s    #(1) ff_mux1_mbsel_px2_1    (.din(mux1_mbsel_px1), .clk(rclk),
		.q(mux1_mbsel_px2_1), .se(se), .si(), .so());

dff_s    #(1) ff_mux1_mbsel_px2_2    (.din(mux1_mbsel_px1), .clk(rclk),
		.q(mux1_mbsel_px2_2), .se(se), .si(), .so());

dff_s    #(1) ff_mux1_mbsel_px2_3    (.din(mux1_mbsel_px1), .clk(rclk),
		.q(mux1_mbsel_px2_3), .se(se), .si(), .so());

dff_s    #(1) ff_mux1_mbsel_px2_4    (.din(mux1_mbsel_px1), .clk(rclk),
		.q(mux1_mbsel_px2_4), .se(se), .si(), .so());

mux2ds  #(10) mux_mux1_addr_px2_9_0 (.dout (evicttag_addr_px2[9:0]) ,
                .in0(mbf_addr_px2[9:0]), .in1(fbf_addr_px2[9:0] ),
                .sel0(mux1_mbsel_px2_1), .sel1(~mux1_mbsel_px2_1)) ;

mux2ds  #(10) mux_mux1_addr_px2_19_10 (.dout (evicttag_addr_px2[19:10]) ,
                .in0(mbf_addr_px2[19:10]), .in1(fbf_addr_px2[19:10] ),
                .sel0(mux1_mbsel_px2_2), .sel1(~mux1_mbsel_px2_2)) ;

mux2ds  #(10) mux_mux1_addr_px2_29_20 (.dout (evicttag_addr_px2[29:20]) ,
                .in0(mbf_addr_px2[29:20]), .in1(fbf_addr_px2[29:20] ),
                .sel0(mux1_mbsel_px2_3), .sel1(~mux1_mbsel_px2_3)) ;

mux2ds  #(10) mux_mux1_addr_px2_39_30 (.dout (evicttag_addr_px2[39:30]) ,
                .in0(mbf_addr_px2[39:30]), .in1(fbf_addr_px2[39:30] ),
                .sel0(mux1_mbsel_px2_4), .sel1(~mux1_mbsel_px2_4)) ;




//////////////////////////////
// dram read addr flop.
//////////////////////////////


dff_s   #(35)  ff_dram_read_addr    (.din(mb_read_data[39:5]), .clk(clk_3),
		.q(dram_read_addr[39:5]), .se(se), .si(), .so());
clken_buf  clk_buf3  (.clk(clk_3), .rclk(rclk), .enb_l(~mbctl_arb_dramrd_en), .tmb_l(~se));

// dffe   #(35)  ff_dram_read_addr    (.din(mb_read_data[39:5]), .clk(rclk),
// 		   .en(mbctl_arb_dramrd_en),
// 		   .q(dram_read_addr[39:5]), .se(se), .si(), .so());

//////////////////////////////
// MUX Between RDMA and WB addresses.
// and wr addr flop
//////////////////////////////

mux2ds #(34) rdmawb_addr_mux ( .dout ( evict_rd_data[39:6]),
               .in0(rdma_read_data[39:6]), // rdma evict addr
               .in1(wb_read_data[39:6]), // wb evict addr
               .sel0(~wbctl_wr_addr_sel), // sel rdma evict addr
               .sel1(wbctl_wr_addr_sel)); // sel wb evict addr.

dff_s   #(34)  ff_wb_rdma_write_addr    (.din(evict_rd_data[39:6]), 
		.clk(clk_4), .q(dram_wr_addr[39:6]), .se(se), .si(), .so());
clken_buf  clk_buf4  (.clk(clk_4), .rclk(rclk), .enb_l(~wb_or_rdma_wr_req_en), .tmb_l(~se));

// dffe   #(34)  ff_wb_rdma_write_addr    (.din(evict_rd_data[39:6]), 
// 		   .en(wb_or_rdma_wr_req_en),
// 		   .clk(rclk), .q(dram_wr_addr[39:6]), .se(se), .si(), .so());

assign		evict_addr  =  dram_wr_addr[39:6] ;

// ctl flop. This flop is here for timing reasons.
dff_s    #(1)  ff_dram_pick_d2(.din(mbctl_arb_dramrd_en), .clk(rclk),
               .q(dram_pick_d2), .se(se), .si(), .so());

//////////////////////////////
// Addr to DRAM
//////////////////////////////
mux2ds #(35) dram_addr_mux ( .dout ( sctag_dram_addr[39:5]),
                      .in0(dram_read_addr[39:5]),
                      .in1({dram_wr_addr[39:6],1'b0}),
                      .sel0(dram_pick_d2),
                      .sel1(~dram_pick_d2));


//////////////////////////////
// CAM addresses.
// mb write addr.
// wb write addr.
//////////////////////////////


// New functionality POST_4.0
// sehold will make ff_lkup_addr_c1 non-transparent.


clken_buf  clk_buf5  (.clk(clk_5), .rclk(rclk), .enb_l(sehold), .tmb_l(~se));

dff_s    #(40) ff_lkup_addr_c1    (.din(arbdp_cam_addr_px2[39:0]), .clk(clk_5),
                .q(inst_addr_c1[39:0]), .se(se), .si(), .so());

assign	lkup_addr_c1  = inst_addr_c1[39:8] ;

dff_s    #(40) ff_inst_addr_c2    (.din(inst_addr_c1[39:0]), .clk(rclk),
                .q(inst_addr_c2[39:0]), .se(se), .si(), .so());

assign	mb_write_addr = inst_addr_c2 ;

dff_s    #(40) ff_inst_addr_c3    (.din(inst_addr_c2[39:0]), .clk(rclk),
                .q(inst_addr_c3[39:0]), .se(se), .si(), .so());


assign	  vuad_idx_c3 = inst_addr_c3[17:8] ;

dff_s    #(40) ff_inst_addr_c4    (.din(inst_addr_c3[39:0]), .clk(rclk),
                .q(inst_addr_c4[39:0]), .se(se), .si(), .so());

assign	evict_addr_c4[39:18] = tagdp_evict_tag_c4[`TAG_WIDTH-1:6] ;
assign	evict_addr_c4[17:6] = inst_addr_c4[17:6] ;
assign  evict_addr_c4[5:0] = 6'b0 ;

mux2ds #(40) mux_wbb_wraddr_c3 ( .dout (wb_write_addr[39:0]),
              .in0(inst_addr_c4[39:0]), .in1(evict_addr_c4[39:0]),
              .sel0(~arbctl_evict_c4), .sel1(arbctl_evict_c4));





endmodule

