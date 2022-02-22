// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_arbdatadp.v
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
/*
//  Module Name: arbdp.v
//  Description:      This block contains the L2 arbiter Datapath
//
// L2 ARB INSTRUCTION FORMAT
//
// Data 4/7/2003
// Changed sctag_scdata_stdecc_c2 to arbdp_store_data_c2. Use a strong
// driver
// Use a strong driver for word_lower_cmp_c8 and word_upper_cmp_c8
*/
////////////////////////////////////////////////////////////////////////
// Global header file includes
////////////////////////////////////////////////////////////////////////

`include 	"iop.h"
`include 	"sctag.h"


////////////////////////////////////////////////////////////////////////
// Local header file includes / local define
////////////////////////////////////////////////////////////////////////

module sctag_arbdatadp( /*AUTOARG*/
   // Outputs
   so, arbdp_oqdp_int_ret_c7, arbdp_store_data_c2, 
   arbdata_wr_data_c2, mbdata_inst_data_c8, csr_inst_wr_data_c8, 
   csr_bist_wr_data_c8, word_lower_cmp_c8, word_upper_cmp_c8, 
   // Inputs
   iq_arbdp_data_px2, snpq_arbdp_data_px2, mb_data_read_data, 
   mbctl_arb_l2rd_en, mux2_snpsel_px2, mux3_bufsel_px2, 
   mux4_c1sel_px2, arbctl_decc_data_sel_c9, bist_or_diag_acc_c1, 
   arbdp_poison_c1, bist_data_data_c1, bist_data_enable_c1, 
   deccdp_arbdp_data_c8, dword_mask_c8, rclk, si, se
   );

input	[63:0]	iq_arbdp_data_px2; // IQ data

input	[63:0]	snpq_arbdp_data_px2 ; // from snpdp

input	[63:0]	mb_data_read_data; // data read from the Miss Buffer.
input		mbctl_arb_l2rd_en; // clk enable for latching L2 arb Miss Buffer data.

// from arbctl.
input	mux2_snpsel_px2; // sel snp data over mbf data
input	mux3_bufsel_px2; // sel buf or IQ data.
input	mux4_c1sel_px2;  // sel stall data.
input	arbctl_decc_data_sel_c9; // scrub data sel for stores.
input	bist_or_diag_acc_c1;  // sel bist or diag data.
input	arbdp_poison_c1; // NEW_PIN ( pin is to the left ).

// from databist
input   [7:0]   bist_data_data_c1 ; // PIN grown from 2 bits in int_2.0
input           bist_data_enable_c1 ;

input	[63:0]	deccdp_arbdp_data_c8;	// from deccdp.

// partial store related mask 
input	[7:0]	dword_mask_c8; // from arbdecdp.

input		rclk;	
input		si,se;

output		so;
output	[17:0]	arbdp_oqdp_int_ret_c7; // interrupt vector
output	[77:0]	arbdp_store_data_c2; // store data with ecc.,
output	[33:0]	arbdata_wr_data_c2; // for tag write
output	[63:0]	mbdata_inst_data_c8; // for mbdata write ( merged data ).

output	[63:0]	csr_inst_wr_data_c8;// added for timing reasons. previously
				    // was using mbdata_inst_data_c8.
				    // New pin added POST_2.0. Place pins 
				    // @ the bottom and align with appropriate
				    // bit position pitch

output	[6:0]	csr_bist_wr_data_c8; //  added pin for tstub functionality.
				     // Place pins at the bottom. align
				     // with the appropriate bit position pitch.
				     // New pin added POST_2.0


output		word_lower_cmp_c8; // addr 0x4; from arbdata
output		word_upper_cmp_c8; // addr 0x0; from arbdata


 wire	[63:0]	arbdp_mux0_data_px2;
 wire	[63:0]	arbdp_mux1_data_px2;
 wire	[63:0]	arbdp_mux2_data_px2;

 wire	[63:0]	arbdp_inst_data_c1;
 wire	[63:0]	arbdp_inst_data_c2;
 wire	[13:0]	arbdp_inst_ecc_c1;
 wire	[13:0]	arbdp_inst_ecc_c2;
 wire	[63:0]	arbdp_inst_data_c3;
 wire	[63:0]	arbdp_inst_data_c4;
 wire	[63:0]	arbdp_inst_data_c5;
 wire	[63:0]	arbdp_inst_data_c6;
 wire	[63:0]	arbdp_inst_data_c7;
 wire	[63:0]	arbdp_inst_data_c8;

 wire	[77:0] arbdp_bist_data_c1 ;
 wire	[63:0] bist_or_diag_data_c1 ;
 wire	[63:0]	store_data_c1;
 wire	[13:0] bist_or_diag_ecc_c1 ;
 wire	[63:0] postecc_data_c1;
 wire	[63:0] poison_data_c1;
 wire	[63:0] arbdp_wr_data_c1	;
 wire	[63:0]	arbdp_wr_data_c2;
 wire	[13:0] arbdp_wr_ecc_c1	;

 wire	[63:0]	deccdp_data_c9; // data from deccdp is flopped here.

wire	[63:0]	mbf_data_px2;// Mbf instruction
wire		en_clk_mbdata;

wire		poison_qual_c1;
assign	poison_qual_c1 = arbdp_poison_c1 &  ~arbctl_decc_data_sel_c9 ;

//*********************************
// Miss Buffer data processing.
//*********************************

clken_buf  clk_buf_mbdata  (.clk(en_clk_mbdata),                
				.rclk(rclk),
                          .enb_l(~mbctl_arb_l2rd_en),  
				.tmb_l(~se));


dff_s   #(64)  ff_read_mbdata_reg    (.din(mb_data_read_data[63:0]), .clk(en_clk_mbdata),
                        .q(mbf_data_px2[63:0]), .se(se), .si(), .so());


//***************************************
// Arbiter muxes for data.
// Store data can come from 5 srcs.
// IQ, MB, diagnostic write, BIST or scrub.
//***************************************

mux2ds  #(64) mux0_data_px      (.dout ( arbdp_mux0_data_px2[63:0] ) ,
                                .in0(mbf_data_px2[63:0] ), // miss buffer data
                                .in1(snpq_arbdp_data_px2[63:0]), // SNP data.
                                .sel0(~mux2_snpsel_px2),	// select buffer data
                                .sel1(mux2_snpsel_px2)) ;

mux2ds  #(64) mux1_data_px      (.dout ( arbdp_mux1_data_px2[63:0] ) ,
                                .in0(arbdp_mux0_data_px2[63:0] ), // miss buffer/snp data
                                .in1(iq_arbdp_data_px2[63:0]), // IQ data.
                                .sel0(mux3_bufsel_px2),	// select buffer data
                                .sel1(~mux3_bufsel_px2)) ;

// A mux flop can be used for C1 data instead of a mux2 + flop.
mux2ds  #(64) mux2_instr_px   (.dout (arbdp_mux2_data_px2[63:0]) ,
                               .in0(arbdp_mux1_data_px2[63:0]),
                               .in1(arbdp_inst_data_c1[63:0]),
                               .sel0(~mux4_c1sel_px2),
                               .sel1(mux4_c1sel_px2)) ;

dff_s     #(64)    ff_data_c1     (.din(arbdp_mux2_data_px2[63:0]), .clk(rclk),
                   .q(arbdp_inst_data_c1[63:0]), .se(se), .si(), .so());


// data ecc data flopped to C9
dff_s     #(64)    ff_deccdp_data_c9     (.din(deccdp_arbdp_data_c8[63:0]), .clk(rclk), 
		 .q(deccdp_data_c9[63:0]), .se(se), .si(), .so());


// normal store data is a combination of scrub/store data.
mux2ds  #(64) mux_store_data_c1      (.dout (store_data_c1[63:0]),
                               .in0(deccdp_data_c9[63:0]), // scrub data
                               .in1(arbdp_inst_data_c1[63:0]), // store data.
                               .sel0(arbctl_decc_data_sel_c9),// decc scrub data sel
                               .sel1(~arbctl_decc_data_sel_c9));// no decc scrub

zzecc_sctag_pgen_32b  ecc_bit31to0 ( .dout(postecc_data_c1[31:0]), 
			     .parity(arbdp_inst_ecc_c1[6:0]),
			     .din(store_data_c1[31:0])
			   );

zzecc_sctag_pgen_32b  ecc_bit63to32 ( .dout(postecc_data_c1[63:32]), 
			     .parity(arbdp_inst_ecc_c1[13:7]),
			     .din(store_data_c1[63:32])
			   );

assign  arbdp_bist_data_c1[38:0] = {bist_data_data_c1[6:0], 
				bist_data_data_c1[7:0], 
				bist_data_data_c1[7:0],
				bist_data_data_c1[7:0],
				bist_data_data_c1[7:0] } ;

assign	arbdp_bist_data_c1[77:39] = {bist_data_data_c1[6:0], 
                                bist_data_data_c1[7:0], 
                                bist_data_data_c1[7:0],
                                bist_data_data_c1[7:0],
                                bist_data_data_c1[7:0] } ;


// Apply poison bit Xor to the 
// 2 LSBs of each 32 Bit word.
assign	poison_data_c1[31:0]  = {	postecc_data_c1[31:2], 
				( postecc_data_c1[1] ^ poison_qual_c1 ),
				( postecc_data_c1[0] ^ poison_qual_c1 )
			 };

// bits 31:0
mux2ds  #(32) mux1_bist_diag_data_c1   (.dout (bist_or_diag_data_c1[31:0]), // bist or diag data
                                .in0(arbdp_bist_data_c1[38:7]),  // bist data
                                .in1(arbdp_wr_data_c2[38:7]),  // diagnostic data
                                .sel0(bist_data_enable_c1),	// bist enable
                                .sel1(~bist_data_enable_c1));	// diagnostic enable(or def)

mux2ds  #(32) mux_wr_data_c1_63to32    (.dout (arbdp_wr_data_c1[31:0]), 
                                .in0(poison_data_c1[31:0]), // new data from mb or iq
                                .in1(bist_or_diag_data_c1[31:0]), //  bist or diag data
                                .sel0(~bist_or_diag_acc_c1), // default
                                .sel1(bist_or_diag_acc_c1)); // bist or diagnostic enable.

dff_s     #(32)    ff_data31to0_c2   (.din(arbdp_wr_data_c1[31:0]), .clk(rclk),
                               .q(arbdp_wr_data_c2[31:0]), .se(se), .si(), .so());



// bits 63:32

// Apply poison bit Xor to the 
// 2 LSBs of each 32 Bit word.
assign	poison_data_c1[63:32]  = {	postecc_data_c1[63:34], 
				( postecc_data_c1[33] ^ poison_qual_c1 ),
				( postecc_data_c1[32] ^ poison_qual_c1 )
			 };
mux2ds  #(32) mux2_bist_diag_data_c1   (.dout(bist_or_diag_data_c1[63:32]), // bist or diag data
                                .in0(arbdp_bist_data_c1[77:46]), // bist data
                                .in1(arbdp_wr_data_c2[38:7]), // diagnostic data
                                .sel0(bist_data_enable_c1),	// bist enable
                                .sel1(~bist_data_enable_c1));	// diagnostic enable(or def)

mux2ds  #(32) mux_wr_data_c1      (.dout (arbdp_wr_data_c1[63:32]),
                                .in0(poison_data_c1[63:32]),	// new data from mb or iq
                                .in1(bist_or_diag_data_c1[63:32]), //  bist or diag data
                                .sel0(~bist_or_diag_acc_c1),	// default
                                .sel1(bist_or_diag_acc_c1));	// bist or diagnostic enable

dff_s     #(32)    ff_data63to32_c2   (.din(arbdp_wr_data_c1[63:32]), .clk(rclk), 
				.q(arbdp_wr_data_c2[63:32]), .se(se), .si(), .so());



// ecc bits [6:0]
mux2ds  #(7) mux1_bist_diag_ecc_c1      (.dout (bist_or_diag_ecc_c1[6:0]), // bist or diag ecc
                                .in0(arbdp_bist_data_c1[6:0]),	// bist ecc
                                .in1(arbdp_wr_data_c2[6:0]), // diagnostic ecc
                                .sel0(bist_data_enable_c1),	// bist enable
                                .sel1(~bist_data_enable_c1));	// diagnostic enable(or def)

mux2ds  #(7) mux_wr_ecc0to6_c1      (.dout (arbdp_wr_ecc_c1[6:0]),
                                .in0(arbdp_inst_ecc_c1[6:0]),// ecc for new data from mb or iq
                                .in1(bist_or_diag_ecc_c1[6:0]),	 //  bist or diag ecc
                                .sel0(~bist_or_diag_acc_c1),	// default
                                .sel1(bist_or_diag_acc_c1));	// bist or diagnostic enable

dff_s     #(7)    ff_ecc0to6_c2   (.din(arbdp_wr_ecc_c1[6:0]), .clk(rclk),
                               .q(arbdp_inst_ecc_c2[6:0]), .se(se), .si(), .so());


// ecc bits [13:7]
mux2ds  #(7) mux2_bist_diag_ecc_c1      (.dout (bist_or_diag_ecc_c1[13:7]),	// bist or diag ecc
                                .in0(arbdp_bist_data_c1[45:39]),	// bist ecc
                                .in1(arbdp_wr_data_c2[6:0]),	// diagnostic ecc
                                .sel0(bist_data_enable_c1),	// bist enable
                                .sel1(~bist_data_enable_c1));	// diagnostic enable(or def)

mux2ds  #(7) mux_wr_ecc7to13_c2     (.dout (arbdp_wr_ecc_c1[13:7]),
                                .in0(arbdp_inst_ecc_c1[13:7]), //eccfor new data from mb or iq
                                .in1(bist_or_diag_ecc_c1[13:7]),//  bist or diag ecc	
                                .sel0(~bist_or_diag_acc_c1),// default
                                .sel1(bist_or_diag_acc_c1)); // bist or diagnostic enable

dff_s     #(7)    ff_ecc7to13_c2   (.din(arbdp_wr_ecc_c1[13:7]), .clk(rclk),
                               .q(arbdp_inst_ecc_c2[13:7]), .se(se), .si(), .so());



// stdecc to scdata and scbuf.
assign	arbdp_store_data_c2=  { arbdp_wr_data_c2[63:32], arbdp_inst_ecc_c2[13:7],
				   arbdp_wr_data_c2[31:0], arbdp_inst_ecc_c2[6:0] } ;




//**********************************************
// C3.. C8 staging flops.
//**********************************************

dff_s     #(64)    ff_data_c2   (.din(arbdp_inst_data_c1[63:0]), .clk(rclk),
                               .q(arbdp_inst_data_c2[63:0]), .se(se), .si(), .so());

assign	arbdata_wr_data_c2 = arbdp_inst_data_c2[33:0] ; // data to the tag for diagnostic
							// writes.
dff_s     #(64)    ff_data_c3   (.din(arbdp_inst_data_c2[63:0]), .clk(rclk),
                               .q(arbdp_inst_data_c3[63:0]), .se(se), .si(), .so());

							// diagostic writes.
dff_s     #(64)    ff_data_c4   (.din(arbdp_inst_data_c3[63:0]), .clk(rclk),
                               .q(arbdp_inst_data_c4[63:0]), .se(se), .si(), .so());

dff_s     #(64)    ff_data_c5   (.din(arbdp_inst_data_c4[63:0]), .clk(rclk),
                               .q(arbdp_inst_data_c5[63:0]), .se(se), .si(), .so());


dff_s     #(64)    ff_data_c6   (.din(arbdp_inst_data_c5[63:0]), .clk(rclk),
                               .q(arbdp_inst_data_c6[63:0]), .se(se), .si(), .so());

dff_s     #(64)    ff_data_c7   (.din(arbdp_inst_data_c6[63:0]), .clk(rclk),
                               .q(arbdp_inst_data_c7[63:0]), .se(se), .si(), .so());

assign	arbdp_oqdp_int_ret_c7 = arbdp_inst_data_c7[17:0] ; // interrupt vector to oqdp.

dff_s     #(64)    ff_data_c8   (.din(arbdp_inst_data_c7[63:0]), .clk(rclk),
                               .q(arbdp_inst_data_c8[63:0]), .se(se), .si(), .so());

//**********************************************
// MERGE operation for partial stores.
//**********************************************
mux2ds  #(8) mux0_data_c6  (.dout (mbdata_inst_data_c8[63:56]),
                             .in0(arbdp_inst_data_c8[63:56]),
                             .in1(deccdp_arbdp_data_c8[63:56]),
                             .sel0(dword_mask_c8[0]),
                             .sel1(~dword_mask_c8[0]));

mux2ds  #(8) mux1_data_c6  (.dout (mbdata_inst_data_c8[55:48]),
                             .in0(arbdp_inst_data_c8[55:48]),
                             .in1(deccdp_arbdp_data_c8[55:48]),
                             .sel0(dword_mask_c8[1]),
                             .sel1(~dword_mask_c8[1]));

mux2ds  #(8) mux2_data_c6  (.dout (mbdata_inst_data_c8[47:40]),
                             .in0(arbdp_inst_data_c8[47:40]),
                             .in1(deccdp_arbdp_data_c8[47:40]),
                             .sel0(dword_mask_c8[2]),
                             .sel1(~dword_mask_c8[2]));

mux2ds  #(8) mux3_data_c6  (.dout (mbdata_inst_data_c8[39:32]),
                             .in0(arbdp_inst_data_c8[39:32]),
                             .in1(deccdp_arbdp_data_c8[39:32]),
                             .sel0(dword_mask_c8[3]),
                             .sel1(~dword_mask_c8[3]));

mux2ds  #(8) mux4_data_c6  (.dout (mbdata_inst_data_c8[31:24]),
                             .in0(arbdp_inst_data_c8[31:24]),
                             .in1(deccdp_arbdp_data_c8[31:24]),
                             .sel0(dword_mask_c8[4]),
                             .sel1(~dword_mask_c8[4]));

mux2ds  #(8) mux5_data_c6  (.dout (mbdata_inst_data_c8[23:16]),
                             .in0(arbdp_inst_data_c8[23:16]),
                             .in1(deccdp_arbdp_data_c8[23:16]),
                             .sel0(dword_mask_c8[5]),
                             .sel1(~dword_mask_c8[5]));

mux2ds  #(8) mux6_data_c6  (.dout (mbdata_inst_data_c8[15:8]),
                             .in0(arbdp_inst_data_c8[15:8]),
                             .in1(deccdp_arbdp_data_c8[15:8]),
                             .sel0(dword_mask_c8[6]),
                             .sel1(~dword_mask_c8[6]));

mux2ds  #(8) mux7_data_c6  (.dout (mbdata_inst_data_c8[7:0]),
                             .in0(arbdp_inst_data_c8[7:0]),
                             .in1(deccdp_arbdp_data_c8[7:0]),
                             .sel0(dword_mask_c8[7]),
                             .sel1(~dword_mask_c8[7]));





//***************************************
// CAS COMPARATORS
//***************************************

// CAS instruction to addr 0x4
assign  word_lower_cmp_c8 = ( arbdp_inst_data_c8[31:0] == deccdp_arbdp_data_c8[31:0] ) ;
// CAS instruction to addr 0x0
assign  word_upper_cmp_c8 = ( arbdp_inst_data_c8[63:32] == deccdp_arbdp_data_c8[63:32] ) ;


//**********************************************
// C8 data sent to the CSR block for writes.
//**********************************************

assign	csr_inst_wr_data_c8 = arbdp_inst_data_c8 ;

assign	csr_bist_wr_data_c8 = arbdp_inst_data_c8[6:0] ;

// Removed csr_bist_wr_data_c8 2-1 mux.

endmodule
