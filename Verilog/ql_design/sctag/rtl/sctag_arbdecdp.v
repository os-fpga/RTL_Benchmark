// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_arbdecdp.v
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

// change ( 6/12/2003 ).
// Input arbdp_word_addr_c7 has changed to arbdp_byte_addr_c6 
// sctag_scbuf_ctag_c7 logic has moved to C6. The new 
// output is called arbdec_ctag_c6;
// Comments
// Change 4/10/2003: Added one pin arbdp_rdma_inst_c1 to the left.
// 		

////////////////////////////////////////////////////////////////////////
// Global header file includes
////////////////////////////////////////////////////////////////////////

`include 	"iop.h"
`include 	"sctag.h"


////////////////////////////////////////////////////////////////////////
// Local header file includes / local define
////////////////////////////////////////////////////////////////////////

module sctag_arbdecdp( /*AUTOARG*/
   // Outputs
   so, arbdp_inst_c8, arbdp_inst_way_c1, arbdp_tecc_c1, 
   arbdp_poison_c1, arbdp_inst_mb_entry_c1, arbdp_inst_fb_c1, 
   arbdp_inst_mb_c1, arbdp_evict_c1, arbdp_inst_rqtyp_c1, 
   arbdp_inst_rsvd_c1, arbdp_inst_nc_c1, arbdp_inst_size_c1, 
   arbdp_inst_bufidhi_c1, arbdp_inst_bufid1_c1, arbdp_inst_ctrue_c1, 
   arbdp_inst_fb_c2, arbdp_inst_mb_c2, arbdp_rdma_entry_c3, 
   arbdp_rdma_inst_c1, arbdp_rdma_inst_c2, arbdp_inst_dep_c2, 
   arbdp_inst_way_c2, arbdp_inst_rqtyp_c2, arbdp_inst_bufidlo_c2, 
   arbdp_inst_rqtyp_c6, arbdp_inst_way_c3, arbdp_inst_fb_c3, 
   arbdp_inst_mb_c3, arbdp_inst_tecc_c3, arbdp_inst_nc_c3, 
   arbdp_l1way_c3, arbdec_dbgdp_inst_c3, arbdp_cpuid_c3, 
   arbdp_cpuid_c4, arbdp_cpuid_c5, arbdp_cpuid_c6, 
   arbdp_int_bcast_c5, arbdp_inst_l1way_c7, arbdp_inst_size_c7, 
   arbdp_inst_tid_c7, arbdp_inst_cpuid_c7, arbdp_inst_nc_c7, 
   arbdec_ctag_c6, arbdp_async_bit_c8, size_field_c8, 
   // Inputs
   snpq_arbdp_inst_px2, iq_arbdp_inst_px2, mb_data_read_data, 
   mbctl_arbdp_ctrue_px2, mbctl_arb_l2rd_en, fbctl_arbdp_entry_px2, 
   fbctl_arbdp_tecc_px2, l2_steering_tid, fbctl_arbdp_way_px2, 
   mux1_mbsel_px2, mux2_snpsel_px2, mux3_bufsel_px2, mux4_c1sel_px2, 
   prim_req_c3, write_req_c3, atomic_req_c3, si, se, rclk, 
   arbdp_byte_addr_c6
   );


 // snp IQ instruction fields
 input [`JBI_HDR_SZ-1:0]        snpq_arbdp_inst_px2; // grown by 1 bit since 2.0

 // IQ instruction fields
 input 	[18:0]	iq_arbdp_inst_px2 ; // from iq ( no valid bit required )

 // Miss buffer instruction fields
 input [`MBD_EVICT:`MBD_SZ_LO] mb_data_read_data ; // grown by 1 bit since 2.0 
 input		mbctl_arbdp_ctrue_px2;
 input		mbctl_arb_l2rd_en ;  // from mbctl

 // Fill buffer instruction fields
 input	[2:0]	fbctl_arbdp_entry_px2;
 input		fbctl_arbdp_tecc_px2;
 input	[4:0]	l2_steering_tid;
 input	[3:0]	fbctl_arbdp_way_px2;


 input	mux1_mbsel_px2; // arbctl
 input	mux2_snpsel_px2; // arbctl
 input  mux3_bufsel_px2; // arbctl
 input  mux4_c1sel_px2; // arbctl
 input	prim_req_c3, write_req_c3, atomic_req_c3 ; // NEW_PIN

 input	si, se;
 input	rclk;

 input	[1:0]	arbdp_byte_addr_c6; // from arbaddr


 output	so;
 output	[`L2_POISON:`L2_SZ_LO] arbdp_inst_c8; // to mbdata.



 output	[3:0]	arbdp_inst_way_c1;
 output		arbdp_tecc_c1 ; // used in arbctl for waysel gate

 output		arbdp_poison_c1; // NEW_PIN to arbdata 
 output	[3:0]	arbdp_inst_mb_entry_c1; // Miss Buffer entry to mbctl
 output		arbdp_inst_fb_c1 ; // used by arbctl to turn off fb hits.
 output		arbdp_inst_mb_c1 ; // used by arbctl to turn off fb hits.
 output		arbdp_evict_c1; // unqualled evict to arbctl
 output   [`L2_RQTYP_HI:`L2_RQTYP_LO] arbdp_inst_rqtyp_c1 ; // NEW_PIN decode
 output   	arbdp_inst_rsvd_c1; // NEW_PIN decode
 output   	arbdp_inst_nc_c1 ; // NEW_PIN decode
 output	[`L2_SZ_HI:`L2_SZ_LO] arbdp_inst_size_c1; // NEW_PIN decode
 output		arbdp_inst_bufidhi_c1;
 output		arbdp_inst_bufid1_c1; // buf_id hi-1
 output		arbdp_inst_ctrue_c1;



 output		arbdp_inst_fb_c2; // output to arbctl for 
				 // generation of scdata wrdata mux sel.
 output		arbdp_inst_mb_c2;	
 output	[1:0]	arbdp_rdma_entry_c3;
 output		arbdp_rdma_inst_c1; // used in mbctl,fbctl,tagctl.
 output		arbdp_rdma_inst_c2; // used in arbctl.
 output		arbdp_inst_dep_c2; // to arbctl for dir cam logic
 output	[3:0]	arbdp_inst_way_c2; //  used in vuad dp.v
 output [`L2_RQTYP_HI:`L2_RQTYP_LO] arbdp_inst_rqtyp_c2 ; // NEW_PIN decode
 output   	arbdp_inst_bufidlo_c2 ; // NEW_PIN decode
 output	[`L2_RQTYP_HI:`L2_RQTYP_LO]  arbdp_inst_rqtyp_c6 ;


 output	[3:0]	arbdp_inst_way_c3; // used in tagctl.v
 output		arbdp_inst_fb_c3; 
 output 	arbdp_inst_mb_c3; 
 output 	arbdp_inst_tecc_c3;
 output		arbdp_inst_nc_c3; // L1 non allocating instruction
 output	[1:0]	arbdp_l1way_c3; // l1 replacement way.
 output	[8:0]	arbdec_dbgdp_inst_c3; // ro dbgdp
 output	[2:0]	arbdp_cpuid_c3;

 output	[2:0]	 arbdp_cpuid_c4; 


 output	[2:0]	arbdp_cpuid_c5, arbdp_cpuid_c6; 
 output		arbdp_int_bcast_c5; // to oqctl.

 output	[1:0]	arbdp_inst_l1way_c7; // to oqdp
 output	[2:0]	arbdp_inst_size_c7; // to oqdp
 output	[1:0]	arbdp_inst_tid_c7; // to oqdp
 output	[2:0]	arbdp_inst_cpuid_c7; // to oqdp
 output		arbdp_inst_nc_c7; // to oqdp
 output	[14:0]	arbdec_ctag_c6; // to SCBUF

 output		arbdp_async_bit_c8; // To CSR NEW_PIN
 output [1:0]	size_field_c8;  // used for CAS instructions compare qualification






 wire	[`L2_FBF:`L2_SZ_LO] snpq_inst_px2;
 wire	[`L2_FBF:`L2_SZ_LO] iq_inst_px2;
 wire	[`L2_FBF:`L2_SZ_LO] fbf_inst_px2;
 wire	[`L2_FBF:`L2_SZ_LO] mbf_inst_px2;

 wire	[`L2_FBF:`L2_SZ_LO] mux1_inst_px2;
 wire	[`L2_FBF:`L2_SZ_LO] mux2_inst_px2;
 wire	[`L2_FBF:`L2_SZ_LO] mux3_inst_px2;
 wire	[`L2_FBF:`L2_SZ_LO] mux4_inst_px2;

 wire	[`L2_FBF:`L2_SZ_LO] arbdp_inst_c1;
 wire	[`L2_FBF:`L2_SZ_LO] arbdp_inst_c2;
 wire	[`L2_FBF:`L2_SZ_LO] arbdp_inst_c3;

 wire	[`L2_POISON:`L2_SZ_LO] arbdp_inst_c4;
 wire	[`L2_POISON:`L2_SZ_LO] arbdp_inst_c5;
 wire	[`L2_POISON:`L2_SZ_LO] arbdp_inst_c6;
 wire	[`L2_POISON:`L2_SZ_LO] arbdp_inst_c7;





wire	clk_0;




//////////////////////////////////////////////////////////////////////////////////////
// INSTRUCTION FIELDS		MBF	FBF	SNP			IQ/PCX
//////////////////////////////////////////////////////////////////////////////////////
//	L2_FBF			0	1	0			0
//	L2_MBF			1	0	0			0
//	L2_SNP			0	0	1			0
//	L2_CTRUE		V	0	0			0
//	L2_EVICT		V	0	0			0
//	L2_DEP			V	0	0			0
//	L2_TECC			V	V	0			0
//	L2_ENTRY<3:0>		mbid	fbid
// 	L2_POISON		0	0	V			0
//	L2_RDMA<1:0>		V	0	V			0
//	L2_RQTYP<4:0>		V**	1F	ctag<11:10>.V<2:0>	V
//	L2_NC			V	0	0			V
//	L2_RSVD			0	0	1			0
//	L2_CPUID<2:0>		V**	0***	ctag<9:7>		V
// 	L2_TID<1:0>		V	0***	ctag<6:5>		V			
//	L2_BUFID<2:0>		rsvd	X	ctag<4:2>		rsvd
//	L2_L1WY<1:0>		V	X	ctag<1:0>		V
//	L2_SZ_HI<2:0>		V	X	V			V
//////////////////////////////////////////////////////////////////////////////////////

// snoop instuction.
 

  assign snpq_inst_px2[`L2_FBF] = 1'b0 ;
  assign snpq_inst_px2[`L2_MBF] = 1'b0 ;
  assign snpq_inst_px2[`L2_SNP] = 1'b1 ; // currently this bit is RSVD

  assign snpq_inst_px2[`L2_CTRUE] = 1'b0 ;
  assign snpq_inst_px2[`L2_EVICT] = 1'b0; 
  assign snpq_inst_px2[`L2_DEP] = 1'b0 ;
  assign snpq_inst_px2[`L2_TECC] = 1'b0 ;
  assign snpq_inst_px2[`L2_POISON] = snpq_arbdp_inst_px2[`JBINST_POISON];

  assign  snpq_inst_px2[`L2_ENTRY_HI:`L2_ENTRY_LO] = 4'b0 ;
  
  assign  snpq_inst_px2[`L2_RDMA_HI:`L2_RDMA_LO] = {
		snpq_arbdp_inst_px2[`JBINST_ENTRY_HI:`JBINST_ENTRY_LO] } ;

  assign snpq_inst_px2[`L2_RQTYP_HI:`L2_RQTYP_LO] = 
 		{
		snpq_arbdp_inst_px2[`JBINST_CTAG_HI:`JBINST_CTAG_HI-1], 
		snpq_arbdp_inst_px2[`JBINST_RQ_WR64:`JBINST_RQ_RD]
		} ;

  assign  snpq_inst_px2[`L2_NC] = 1'b0 ;

  assign  snpq_inst_px2[`L2_RSVD] = snpq_arbdp_inst_px2[`JBINST_RSVD]; // Changed POST_4.0

  assign  snpq_inst_px2[`L2_CPUID_HI:`L2_CPUID_LO] = 
		{ snpq_arbdp_inst_px2[`JBINST_CTAG_HI-2:`JBINST_CTAG_HI-4]};

  assign  snpq_inst_px2[`L2_TID_HI:`L2_TID_LO] = 
		{ snpq_arbdp_inst_px2[`JBINST_CTAG_HI-5:`JBINST_CTAG_HI-6]};

  assign  snpq_inst_px2[`L2_BUFID_HI:`L2_BUFID_LO] = 
		{ snpq_arbdp_inst_px2[`JBINST_CTAG_HI-7:`JBINST_CTAG_HI-9]};

  assign  snpq_inst_px2[`L2_L1WY_HI:`L2_L1WY_LO] = 
		{ snpq_arbdp_inst_px2[`JBINST_CTAG_HI-10:`JBINST_CTAG_HI-11]};

  assign  snpq_inst_px2[`L2_SZ_HI:`L2_SZ_LO] = 
		snpq_arbdp_inst_px2[`JBINST_SZ_HI:`JBINST_SZ_LO];

//**********************
// iq instuction.
//**********************

// inst bits 30:20
  assign	iq_inst_px2[`L2_FBF:`L2_ENTRY_LO] = 11'b0 ;
  assign	iq_inst_px2[`L2_POISON] = 1'b0 ;

  assign	iq_inst_px2[`L2_RDMA_HI:`L2_RDMA_LO] = 2'b0;
// inst bits 19:0
  assign	iq_inst_px2[`L2_RQTYP_HI:`L2_SZ_LO] = 
		{iq_arbdp_inst_px2[18:13],
		1'b0, 	// RSVD bit
		iq_arbdp_inst_px2[`L2_CPUID_HI:`L2_SZ_LO]} ;	


//**********************
// fill buffer instuction.
//**********************
// inst bits  30:20
  assign  fbf_inst_px2[`L2_FBF] = 1'b1 ;
  assign  fbf_inst_px2[`L2_MBF] = 1'b0 ;
  assign  fbf_inst_px2[`L2_SNP] = 1'b0 ;
  assign  fbf_inst_px2[`L2_RSVD] = 1'b0 ;

  assign  fbf_inst_px2[`L2_CTRUE] = 1'b0 ;
  assign  fbf_inst_px2[`L2_EVICT] = 1'b0;
  assign  fbf_inst_px2[`L2_DEP] = 1'b0 ;
  assign  fbf_inst_px2[`L2_TECC] = fbctl_arbdp_tecc_px2 ;
  assign  fbf_inst_px2[`L2_ENTRY_HI:`L2_ENTRY_LO] = { 1'b0 , fbctl_arbdp_entry_px2[2:0] } ;

// inst bits 19:0
  assign  fbf_inst_px2[`L2_POISON] = 1'b0;
  assign  fbf_inst_px2[`L2_RDMA_HI:`L2_RDMA_LO] = 2'b0;
  assign  fbf_inst_px2[`L2_RQTYP_HI:`L2_RQTYP_LO] = 5'b11111;
  assign  fbf_inst_px2[`L2_NC] = 1'b0 ;
  assign  fbf_inst_px2[`L2_RSVD] = 1'b0 ;
  assign  fbf_inst_px2[`L2_CPUID_HI:`L2_CPUID_LO] = l2_steering_tid[4:2];
  assign  fbf_inst_px2[`L2_TID_HI:`L2_TID_LO] = l2_steering_tid[1:0];
  assign  fbf_inst_px2[`L2_BUFID_HI:`L2_BUFID_HI-3] = fbctl_arbdp_way_px2[3:0] ;
  assign  fbf_inst_px2[`L2_BUFID_HI-4:`L2_SZ_LO] = 4'b0 ;


//**********************
// miss buffer instuction.
//**********************
 
  assign  mbf_inst_px2[`L2_FBF] = 1'b0 ;
  assign  mbf_inst_px2[`L2_MBF] = 1'b1 ;
  assign  mbf_inst_px2[`L2_SNP] = 1'b0 ;
  assign  mbf_inst_px2[`L2_CTRUE] = mbctl_arbdp_ctrue_px2; 

//   dffe   #(7)  ff_read_mbdata_reg_inst1    
// 			   (.din(mb_data_read_data[`MBD_EVICT:`MBD_ENTRY_LO]), 
// 			   .clk(rclk), .en(mbctl_arb_l2rd_en),
// 			   .q(mbf_inst_px2[`L2_EVICT:`L2_ENTRY_LO]), .se(se), .si(), .so());
// 
//   dffe   #(23)  ff_read_mbdata_reg_inst2    
// 			   (.din(mb_data_read_data[`MBD_POISON:`MBD_SZ_LO]), 
// 			   .clk(rclk), .en(mbctl_arb_l2rd_en),
// 			   .q(mbf_inst_px2[`L2_POISON:`L2_SZ_LO]), .se(se), .si(), .so());

  clken_buf  ckbuf_0  (.clk(clk_0), .rclk(rclk), .enb_l(~mbctl_arb_l2rd_en), .tmb_l(~se));

  dff_s   #(7)  ff_read_mbdata_reg_inst1    
			(.din(mb_data_read_data[`MBD_EVICT:`MBD_ENTRY_LO]), 
			.clk(clk_0),
                        .q(mbf_inst_px2[`L2_EVICT:`L2_ENTRY_LO]), .se(se), .si(), .so());

  dff_s   #(23)  ff_read_mbdata_reg_inst2    
			(.din(mb_data_read_data[`MBD_POISON:`MBD_SZ_LO]), 
			.clk(clk_0),
                        .q(mbf_inst_px2[`L2_POISON:`L2_SZ_LO]), .se(se), .si(), .so());



//************************
// arbiter muxes
// arbiter is split into two rows
// The first row contains 11 bits. The second row contains 20 bits.
//************************

 mux2ds  #(11) mux_mux1_inst1_px2 (.dout (mux1_inst_px2[`L2_FBF:`L2_ENTRY_LO]) ,
                .in0(mbf_inst_px2[`L2_FBF:`L2_ENTRY_LO]), // mbf inst 30:20
		.in1(fbf_inst_px2[`L2_FBF:`L2_ENTRY_LO] ), // fbf inst  30:20
                .sel0(mux1_mbsel_px2), .sel1(~mux1_mbsel_px2)) ;

 mux2ds  #(23) mux_mux1_inst2_px2 (.dout (mux1_inst_px2[`L2_POISON:`L2_SZ_LO]) ,
                .in0(mbf_inst_px2[`L2_POISON:`L2_SZ_LO]), // mbf inst 19:0
		.in1(fbf_inst_px2[`L2_POISON:`L2_SZ_LO] ), // fbf inst  19:0
                .sel0(mux1_mbsel_px2), .sel1(~mux1_mbsel_px2)) ;


 mux2ds  #(11) mux_mux2_inst1_px2(.dout (mux2_inst_px2[`L2_FBF:`L2_ENTRY_LO]) ,
                .in0(snpq_inst_px2[`L2_FBF:`L2_ENTRY_LO]), // snoop 
		.in1(mux1_inst_px2[`L2_FBF:`L2_ENTRY_LO]), // fbf/mbf instuction 30:20
                .sel0(mux2_snpsel_px2), .sel1(~mux2_snpsel_px2));

 mux2ds  #(23) mux_mux2_inst2_px2 (.dout (mux2_inst_px2[`L2_POISON:`L2_SZ_LO]) ,
                .in0(snpq_inst_px2[`L2_POISON:`L2_SZ_LO]), // snoop inst 19:0
		.in1(mux1_inst_px2[`L2_POISON:`L2_SZ_LO] ), // fbf/mbf inst  19:0
                .sel0(mux2_snpsel_px2), .sel1(~mux2_snpsel_px2)) ;


 mux2ds  #(11) mux_mux3_inst1_px2(.dout (mux3_inst_px2[`L2_FBF:`L2_ENTRY_LO]) ,
                .in0(mux2_inst_px2[`L2_FBF:`L2_ENTRY_LO]), // snoop and mbf and fbf
		.in1(iq_inst_px2[`L2_FBF:`L2_ENTRY_LO]), // iq instuction 30:20
                .sel0(mux3_bufsel_px2), .sel1(~mux3_bufsel_px2));

 mux2ds  #(23) mux_mux3_inst2_px2 (.dout (mux3_inst_px2[`L2_POISON:`L2_SZ_LO]) ,
                .in0(mux2_inst_px2[`L2_POISON:`L2_SZ_LO]), // snoop and mbf  and fbf
		.in1(iq_inst_px2[`L2_POISON:`L2_SZ_LO] ), // iq inst  19:0
                .sel0(mux3_bufsel_px2), .sel1(~mux3_bufsel_px2)) ;


 // a mux flop cannot be used here.
 mux2ds  #(11) mux_mux4_inst1_px2(.dout (mux4_inst_px2[`L2_FBF:`L2_ENTRY_LO]) ,
                .in0(mux3_inst_px2[`L2_FBF:`L2_ENTRY_LO]), // snoop and mbf and fbf and iq
		.in1(arbdp_inst_c1[`L2_FBF:`L2_ENTRY_LO]), // c1 instuction 30:20
                .sel0(~mux4_c1sel_px2), .sel1(mux4_c1sel_px2));

 mux2ds  #(23) mux_mux4_inst2_px2 (.dout (mux4_inst_px2[`L2_POISON:`L2_SZ_LO]) ,
                .in0(mux3_inst_px2[`L2_POISON:`L2_SZ_LO]), // snoop and mbf  and fbf and iq
		.in1(arbdp_inst_c1[`L2_POISON:`L2_SZ_LO] ), // c1 inst  19:0
                .sel0(~mux4_c1sel_px2), .sel1(mux4_c1sel_px2)) ;


 dff_s     #(11)    ff_inst1_c1    (.din(mux4_inst_px2[`L2_FBF:`L2_ENTRY_LO]),
                                .clk(rclk),
                               .q(arbdp_inst_c1[`L2_FBF:`L2_ENTRY_LO]),
                                .se(se), .si(), .so());

 dff_s     #(11)    ff_inst1_c2    (.din(arbdp_inst_c1[`L2_FBF:`L2_ENTRY_LO]),
                                .clk(rclk),
                               .q(arbdp_inst_c2[`L2_FBF:`L2_ENTRY_LO]),
                                .se(se), .si(), .so());

 dff_s     #(11)    ff_inst1_c3    (.din(arbdp_inst_c2[`L2_FBF:`L2_ENTRY_LO]),
                                .clk(rclk),
                               .q(arbdp_inst_c3[`L2_FBF:`L2_ENTRY_LO]),
                                .se(se), .si(), .so());


 dff_s     #(23)    ff_inst2_c1    (.din(mux4_inst_px2[`L2_POISON:`L2_SZ_LO]),
                                .clk(rclk),
                               .q(arbdp_inst_c1[`L2_POISON:`L2_SZ_LO]),
                                .se(se), .si(), .so());


 dff_s     #(23)    ff_inst2_c2    (.din(arbdp_inst_c1[`L2_POISON:`L2_SZ_LO]),
                                .clk(rclk),
                               .q(arbdp_inst_c2[`L2_POISON:`L2_SZ_LO]),
                                .se(se), .si(), .so());

 dff_s     #(23)    ff_inst2_c3    (.din(arbdp_inst_c2[`L2_POISON:`L2_SZ_LO]),
                                .clk(rclk),
                               .q(arbdp_inst_c3[`L2_POISON:`L2_SZ_LO]),
                                .se(se), .si(), .so());


 dff_s     #(23)    ff_inst2_c4    (.din(arbdp_inst_c3[`L2_POISON:`L2_SZ_LO]),
                                .clk(rclk),
                               .q(arbdp_inst_c4[`L2_POISON:`L2_SZ_LO]),
                                .se(se), .si(), .so());

 dff_s     #(23)    ff_inst2_c5    (.din(arbdp_inst_c4[`L2_POISON:`L2_SZ_LO]),
                                .clk(rclk),
                               .q(arbdp_inst_c5[`L2_POISON:`L2_SZ_LO]),
                                .se(se), .si(), .so());


 dff_s     #(23)    ff_inst2_c6    (.din(arbdp_inst_c5[`L2_POISON:`L2_SZ_LO]),
                                .clk(rclk),
                               .q(arbdp_inst_c6[`L2_POISON:`L2_SZ_LO]),
                                .se(se), .si(), .so());


 dff_s     #(23)    ff_inst2_c7    (.din(arbdp_inst_c6[`L2_POISON:`L2_SZ_LO]),
                                .clk(rclk),
                               .q(arbdp_inst_c7[`L2_POISON:`L2_SZ_LO]),
                                .se(se), .si(), .so());

 dff_s     #(23)    ff_inst2_c8    (.din(arbdp_inst_c7[`L2_POISON:`L2_SZ_LO]),
                                .clk(rclk),
                               .q(arbdp_inst_c8[`L2_POISON:`L2_SZ_LO]),
                                .se(se), .si(), .so());


//////////////////////////////////////////////////////
// C1 Bits used in decode
//////////////////////////////////////////////////////

assign	arbdp_poison_c1 = arbdp_inst_c1[`L2_POISON];
				
assign  arbdp_inst_way_c1 = arbdp_inst_c1[`L2_BUFID_HI:`L2_BUFID_HI-3] ; 

assign	arbdp_inst_fb_c1 = arbdp_inst_c1[`L2_FBF] ; // used by
				// arbctl to  turn off fb hits.
assign	arbdp_evict_c1 = arbdp_inst_c1[`L2_EVICT] ;  

assign	arbdp_tecc_c1 = arbdp_inst_c1[`L2_TECC] ;

assign	arbdp_inst_mb_c1 = arbdp_inst_c1[`L2_MBF] ;

assign	arbdp_inst_rsvd_c1 = arbdp_inst_c1[`L2_RSVD] ;

assign	arbdp_inst_nc_c1 = arbdp_inst_c1[`L2_NC] ;

assign	arbdp_inst_ctrue_c1 = arbdp_inst_c1[`L2_CTRUE] ;

assign	arbdp_inst_size_c1[`L2_SZ_HI:`L2_SZ_LO] =
			arbdp_inst_c1[`L2_SZ_HI:`L2_SZ_LO];

assign	arbdp_inst_bufidhi_c1 = arbdp_inst_c1[`L2_BUFID_HI] ;

assign	arbdp_inst_bufid1_c1 = arbdp_inst_c1[`L2_BUFID_HI-1];

assign	arbdp_inst_rqtyp_c1 = arbdp_inst_c1[`L2_RQTYP_HI:`L2_RQTYP_LO] ;

assign  arbdp_inst_mb_entry_c1 = arbdp_inst_c1[`L2_ENTRY_HI:`L2_ENTRY_LO] ;

assign	arbdp_rdma_inst_c1 = arbdp_inst_c1[`L2_RSVD] ;
//////////////////////////////////////////////////////
// C2 Bits used in decode
//////////////////////////////////////////////////////

assign	arbdp_inst_bufidlo_c2 =  arbdp_inst_c2[`L2_BUFID_LO] ;

assign  arbdp_inst_mb_c2 = arbdp_inst_c2[`L2_MBF] ; // used in vuad dp, arbctl

assign  arbdp_inst_fb_c2 = arbdp_inst_c2[`L2_FBF] ;  // fill instruction in C2.
						      // output to arbctl and vuad dp.
assign  arbdp_inst_dep_c2 = arbdp_inst_c2[`L2_DEP];
				
assign	arbdp_rdma_inst_c2 = arbdp_inst_c2[`L2_RSVD] ;

assign	arbdp_inst_rqtyp_c2 = arbdp_inst_c2[`L2_RQTYP_HI:`L2_RQTYP_LO] ;

assign  arbdp_inst_way_c2 = arbdp_inst_c2[`L2_BUFID_HI:`L2_BUFID_HI-3] ; 

//////////////////////////////////////////////////////
// C3 Bits used in decode
//////////////////////////////////////////////////////

assign  arbdp_inst_mb_c3 = arbdp_inst_c3[`L2_MBF] ;

assign  arbdp_inst_fb_c3 = arbdp_inst_c3[`L2_FBF] ;

assign	arbdp_inst_tecc_c3 = arbdp_inst_c3[`L2_TECC];

assign  arbdp_inst_way_c3 = arbdp_inst_c3[`L2_BUFID_HI:`L2_BUFID_HI-3] ; 

assign	arbdp_rdma_entry_c3 = arbdp_inst_c3[`L2_RDMA_HI:`L2_RDMA_LO] ;

assign	arbdp_inst_nc_c3 = arbdp_inst_c3[`L2_NC] ;

assign	arbdp_l1way_c3 = arbdp_inst_c3[`L2_L1WY_HI:`L2_L1WY_LO] ;

//////////////////////////////////////////////////////
// C5+ Bits used in decode
//////////////////////////////////////////////////////

assign  arbdp_int_bcast_c5 = arbdp_inst_c5[`L2_NC] ;

assign	arbdp_inst_rqtyp_c6 = arbdp_inst_c6[`L2_RQTYP_HI:`L2_RQTYP_LO] ;



//////////////////////////////////////////////////////
// CTAG sent to scbuf 
// Ctag<14:0> = { addr_c7<1:0>, r/wbar, ctag<11:0> }
//////////////////////////////////////////////////////

assign	arbdec_ctag_c6[14:0] =  { arbdp_byte_addr_c6[1:0],
		arbdp_inst_c6[`L2_RQTYP_LO],	// rd
		arbdp_inst_c6[`L2_RQTYP_HI:`L2_RQTYP_HI-1], // ctag 11:10
		arbdp_inst_c6[`L2_CPUID_HI:`L2_L1WY_LO] } ; 


// Fields that go to oqdp for return to the 
// sparcs 

assign	arbdp_inst_l1way_c7 = arbdp_inst_c7[`L2_L1WY_HI:`L2_L1WY_LO] ;
assign	arbdp_inst_size_c7 = arbdp_inst_c7[`L2_SZ_HI:`L2_SZ_LO] ;
assign	arbdp_inst_tid_c7 = arbdp_inst_c7[`L2_TID_HI:`L2_TID_LO] ;
assign	arbdp_inst_cpuid_c7 = arbdp_inst_c7[`L2_CPUID_HI:`L2_CPUID_LO] ;
assign	arbdp_inst_nc_c7 = arbdp_inst_c7[`L2_NC] ;





// to arbctl for determining if an instruction 
// is a CAS or CASX.

assign	size_field_c8[1:0]= arbdp_inst_c8[`L2_SZ_HI-1:`L2_SZ_LO] ; 

assign	arbdp_async_bit_c8 = arbdp_inst_c8[`L2_SZ_HI] ;





 // cpu id in C3,C4,C5,C6 to arbctl for 
 // directory invalidation mask calculation.
// C6 and C7 cpuid are used in direvec_ctl for 
 // dirvec_dp mux selects

assign  arbdp_cpuid_c3  = arbdp_inst_c3[`L2_CPUID_HI:`L2_CPUID_LO] ;
assign  arbdp_cpuid_c4  = arbdp_inst_c4[`L2_CPUID_HI:`L2_CPUID_LO] ;
assign  arbdp_cpuid_c5  = arbdp_inst_c5[`L2_CPUID_HI:`L2_CPUID_LO] ;
assign  arbdp_cpuid_c6  = arbdp_inst_c6[`L2_CPUID_HI:`L2_CPUID_LO] ;


// dbg information sent to dbgdp
// { 	JBI instruction
//	Primary request
//	Write ( store, strmstore, wr64, wr8 )
//	Atomic ( cas or swap )
// 	cpuid<2:0>,
//	tid   }



assign	arbdec_dbgdp_inst_c3 = { arbdp_inst_c3[`L2_RSVD],	// JBI instruction bit
			prim_req_c3,			// PRIM req from JBI/PCX interface
			write_req_c3,			// Any write
			atomic_req_c3,			// SWAP/CAS
			arbdp_inst_c3[`L2_CPUID_HI:`L2_CPUID_LO], // CPUID
			arbdp_inst_c3[`L2_TID_HI:`L2_TID_LO] 	// TID
			} ;
endmodule







