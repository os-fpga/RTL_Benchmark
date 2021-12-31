// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_decc_ctl.v
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
module sctag_decc_ctl(/*AUTOARG*/
   // Outputs
   decc_bscd_corr_err_c8, decc_bscd_uncorr_err_c8, 
   decc_spcd_corr_err_c8, decc_spcd_uncorr_err_c8, 
   decc_scrd_corr_err_c8, decc_scrd_uncorr_err_c8, 
   decc_spcfb_corr_err_c8, decc_spcfb_uncorr_err_c8, 
   decc_uncorr_err_c8, sel_higher_word_c7, sel_higher_dword_c7, 
   dword_sel_c7, retdp_err_c8, so, 
   // Inputs
   tagctl_decc_addr3_c7, arbctl_inst_l2data_vld_c6, 
   data_ecc_active_c3, bist_data_enable_c1, bist_data_waddr_c1, 
   arbdp_addr22_c7, arbdp_waddr_c6, error_ceen, error_nceen, 
   tagctl_spc_rd_vld_c7, tagctl_bsc_rd_vld_c7, 
   tagctl_scrub_rd_vld_c7, fbctl_spc_corr_err_c7, 
   fbctl_spc_uncorr_err_c7, fbctl_spc_rd_vld_c7, rclk, si, se, 
   check0_c7, check1_c7, check2_c7, check3_c7, parity0_c7, 
   parity1_c7, parity2_c7, parity3_c7
   );

input	tagctl_decc_addr3_c7;
input	arbctl_inst_l2data_vld_c6;
input	data_ecc_active_c3;

input	bist_data_enable_c1;
input	[1:0]	bist_data_waddr_c1;
input	arbdp_addr22_c7;
input	[1:0]	arbdp_waddr_c6;

input	error_ceen ;  // Correctable error enables
input	error_nceen ; // Uncorrectable error enables



output          decc_bscd_corr_err_c8 ;    // spc data
output          decc_bscd_uncorr_err_c8 ;  // spc data
output          decc_spcd_corr_err_c8 ;    // spc data
output          decc_spcd_uncorr_err_c8 ;  // spc data
output          decc_scrd_corr_err_c8 ;    // scrub
output          decc_scrd_uncorr_err_c8 ;  // scrub
output          decc_spcfb_corr_err_c8 ;   // spc data from fb
output          decc_spcfb_uncorr_err_c8 ; // spc data from fb
output          decc_uncorr_err_c8;        // an uncorr err has happenned Unqual

input           tagctl_spc_rd_vld_c7 ;   // input for err classification
input		tagctl_bsc_rd_vld_c7; // NEW_PIN
input           tagctl_scrub_rd_vld_c7 ; // input for err classification

input           fbctl_spc_corr_err_c7;	// indicates that an corr err was 
                                        // received from the DRAM
input           fbctl_spc_uncorr_err_c7; // indicates that an uncorr err was 
					// received from the DRAM
input           fbctl_spc_rd_vld_c7; // indicates that an FB read is active for a 
				     // sparc instruction


output		sel_higher_word_c7;
output		sel_higher_dword_c7;
output		dword_sel_c7;

output	[2:0]	retdp_err_c8;

input		rclk;
input		si, se;
output		so;

// from deccdp.
input	[5:0]	check0_c7, check1_c7, check2_c7, check3_c7 ;
input		parity0_c7, parity1_c7, parity2_c7, parity3_c7 ;

wire	[3:0]	corr_err_c7;
wire	[3:0]	uncorr_err_c7;
wire		data_corr_err_c7;
wire		data_uncorr_err_c7;

wire    [1:0]   bist_data_waddr_c2;
wire    [1:0]   bist_data_waddr_c3;
wire    [1:0]   bist_data_waddr_c4;
wire    [1:0]   bist_data_waddr_c5;
wire    [1:0]   bist_data_waddr_c6;

wire            bist_data_enable_c2;
wire            bist_data_enable_c3;
wire            bist_data_enable_c4;
wire            bist_data_enable_c5;
wire            bist_data_enable_c6;

/*
wire            spc_data_corr_err_c7 ;
wire            spc_data_uncorr_err_c7 ;
*/
wire            scr_data_corr_err_c7 ;
wire            scr_data_uncorr_err_c7 ;

/*wire            spcfb_uncorr_err_c7;
wire            spcfb_corr_err_c7;
*/


wire    [2:0]   retdp_err_c7 ;
wire            error_ceen_d1 ;
wire            error_nceen_d1 ;



wire    [1:0]   waddr_c7; // 3:2
wire    [1:0]   diag_addr_c7;

wire            sel_higher_word_c6;
wire            sel_higher_dword_c6;
wire            sel_higher_word_c7;
wire            sel_higher_dword_c7;

wire            sel_bist_c6;
wire            sel_diag_c7;
wire            sel_def_c6;


wire	data_corr_err_c8, fbctl_spc_rd_vld_c8, fbctl_spc_corr_err_c8;
wire	spc_rd_vld_c8, bsc_rd_vld_c8;
wire	fbctl_spc_uncorr_err_c8;




assign  corr_err_c7[0] =  parity0_c7 ;
assign  corr_err_c7[1] =  parity1_c7 ;
assign  corr_err_c7[2] =  parity2_c7 ;
assign  corr_err_c7[3] =  parity3_c7 ;

assign  data_corr_err_c7 =  |( corr_err_c7[3:0] )  ;

assign  uncorr_err_c7[0] = |(check0_c7[5:0]) & ~parity0_c7 ;
assign  uncorr_err_c7[1] = |(check1_c7[5:0]) & ~parity1_c7 ;
assign  uncorr_err_c7[2] = |(check2_c7[5:0]) & ~parity2_c7 ;
assign  uncorr_err_c7[3] = |(check3_c7[5:0]) & ~parity3_c7 ;

assign  data_uncorr_err_c7 =  |(uncorr_err_c7[3:0]) ;







dff_s   #(1)    ff_bist_en_c2
              (.q   (bist_data_enable_c2), .din (bist_data_enable_c1),
               .clk (rclk), .se(se), .si  (), .so  ()) ;
dff_s   #(1)    ff_bist_en_c3
              (.q   (bist_data_enable_c3), .din (bist_data_enable_c2),
               .clk (rclk), .se(se), .si  (), .so  ()) ;
dff_s   #(1)    ff_bist_en_c4
              (.q   (bist_data_enable_c4), .din (bist_data_enable_c3),
               .clk (rclk), .se(se), .si  (), .so  ()) ;
dff_s   #(1)    ff_bist_en_c5
              (.q   (bist_data_enable_c5), .din (bist_data_enable_c4),
               .clk (rclk), .se(se), .si  (), .so  ()) ;
dff_s   #(1)    ff_bist_en_c6
              (.q   (bist_data_enable_c6), .din (bist_data_enable_c5),
               .clk (rclk), .se(se), .si  (), .so  ()) ;


dff_s   #(2)   ff_bist_waddr_c2
              (.q   (bist_data_waddr_c2[1:0]), .din (bist_data_waddr_c1[1:0]),
               .clk (rclk), .se(se), .si  (), .so  ()) ;
dff_s   #(2)   ff_bist_waddr_c3
              (.q   (bist_data_waddr_c3[1:0]), .din (bist_data_waddr_c2[1:0]),
               .clk (rclk), .se(se), .si  (), .so  ()) ; 
dff_s   #(2)   ff_bist_waddr_c4
              (.q   (bist_data_waddr_c4[1:0]), .din (bist_data_waddr_c3[1:0]),
               .clk (rclk), .se(se), .si  (), .so  ()) ;
dff_s   #(2)   ff_bist_waddr_c5
              (.q   (bist_data_waddr_c5[1:0]), .din (bist_data_waddr_c4[1:0]),
               .clk (rclk), .se(se), .si  (), .so  ()) ;
dff_s   #(2)   ff_bist_waddr_c6
              (.q   (bist_data_waddr_c6[1:0]), .din (bist_data_waddr_c5[1:0]),
               .clk (rclk), .se(se), .si  (), .so  ()) ;



dff_s   #(1)   ff_decc_uncorr_err_c8
              (.q   (decc_uncorr_err_c8), .din (data_uncorr_err_c7),
               .clk (rclk), .se(se), .si  (), .so  ()) ;


dff_s   #(1)   ff_data_corr_err_c8 
		(.q   (data_corr_err_c8), .din (data_corr_err_c7),
               		.clk (rclk), .se(se), .si  (), .so  ()
		) ;

dff_s   #(1)   ff_spc_rd_vld_c8 
		(.q   (spc_rd_vld_c8), .din (tagctl_spc_rd_vld_c7),
               		.clk (rclk), .se(se), .si  (), .so  ()
		) ;

assign	decc_spcd_corr_err_c8 = data_corr_err_c8 & spc_rd_vld_c8;
assign	decc_spcd_uncorr_err_c8 = decc_uncorr_err_c8 & spc_rd_vld_c8;

assign	scr_data_corr_err_c7 = (((corr_err_c7[3] | corr_err_c7[2]) & ~tagctl_decc_addr3_c7) |
				((corr_err_c7[1] | corr_err_c7[0]) & tagctl_decc_addr3_c7)
			) & tagctl_scrub_rd_vld_c7 ;

dff_s   #(1)   ff_decc_scrd_corr_err_c8
              	(.q   (decc_scrd_corr_err_c8), .din (scr_data_corr_err_c7),
               		.clk (rclk), .se(se), .si  (), .so  ()
		) ;

assign  scr_data_uncorr_err_c7 = (((uncorr_err_c7[3] | uncorr_err_c7[2]) & ~tagctl_decc_addr3_c7) |
                                  ((uncorr_err_c7[1] | uncorr_err_c7[0]) & tagctl_decc_addr3_c7)
                                  ) & tagctl_scrub_rd_vld_c7 ;

dff_s   #(1)    ff_decc_scrd_uncorr_err_c8
              (.q   (decc_scrd_uncorr_err_c8), .din (scr_data_uncorr_err_c7),
               .clk (rclk), .se(se), .si  (), .so  ()) ;



dff_s   #(1)   ff_fbctl_spc_rd_vld_c8
              	(.q   (fbctl_spc_rd_vld_c8), .din (fbctl_spc_rd_vld_c7),
               		.clk (rclk), .se(se), .si  (), .so  ()
		) ;

dff_s   #(1)   ff_fbctl_spc_corr_err_c8
              	(.q   (fbctl_spc_corr_err_c8), .din (fbctl_spc_corr_err_c7),
               		.clk (rclk), .se(se), .si  (), .so  ()
		) ;

dff_s   #(1)   ff_fbctl_spc_uncorr_err_c8
              	(.q   (fbctl_spc_uncorr_err_c8), .din (fbctl_spc_uncorr_err_c7),
               		.clk (rclk), .se(se), .si  (), .so  ()
		) ;

assign	decc_spcfb_corr_err_c8    = (data_corr_err_c8 & fbctl_spc_rd_vld_c8) |  
				fbctl_spc_corr_err_c8;


assign	decc_spcfb_uncorr_err_c8    = (decc_uncorr_err_c8 & fbctl_spc_rd_vld_c8) |  
				fbctl_spc_uncorr_err_c8;


dff_s   #(1)   ff_bsc_rd_vld_c8
              	(.q   (bsc_rd_vld_c8), .din (tagctl_bsc_rd_vld_c7),
               		.clk (rclk), .se(se), .si  (), .so  ()
		) ;

assign	decc_bscd_corr_err_c8  = data_corr_err_c8 & bsc_rd_vld_c8;

assign	decc_bscd_uncorr_err_c8  = decc_uncorr_err_c8 & bsc_rd_vld_c8;





// error_ceen and error_nceen are the register bits for enabling the reporting
// of the correctable and uncorrectable error respectively.

dff_s   #(1)    ff_error_ceen_d1
              (.q   (error_ceen_d1), .din (error_ceen),
               .clk (rclk), .se(se), .si  (), .so  ()) ;

dff_s   #(1)    ff_error_nceen_d1
              (.q   (error_nceen_d1), .din (error_nceen), .clk (rclk),
               .se(se), .si  (), .so  ()) ;


// only precise error reporting is handled here.
assign  retdp_err_c7[0] = (data_corr_err_c7 | fbctl_spc_corr_err_c7)   &
			( ( tagctl_spc_rd_vld_c7 | fbctl_spc_rd_vld_c7 |
			fbctl_spc_corr_err_c7 ) & error_ceen_d1 ) ;

//assign  retdp_err_c7[0] = (spc_data_corr_err_c7 | spcfb_corr_err_c7)   
                           //& error_ceen_d1 ;

assign  retdp_err_c7[1] = (data_uncorr_err_c7 | fbctl_spc_uncorr_err_c7)   &
			( ( tagctl_spc_rd_vld_c7 | fbctl_spc_rd_vld_c7 |
			fbctl_spc_uncorr_err_c7 ) & error_nceen_d1 ) ;

//assign  retdp_err_c7[1] = (spc_data_uncorr_err_c7 | spcfb_uncorr_err_c7)  
                           //& error_nceen_d1 ;
assign  retdp_err_c7[2] = 1'b0 ;  // RSVD


dff_s   #(3)    ff_retdp_err_c8
              (.q   (retdp_err_c8[2:0]), .din (retdp_err_c7[2:0]), .clk (rclk),
               .se(se), .si  (), .so  ()) ;



//////////////////////////////////////////////////////////////////////////
//
// data that is xmitted to the arbdatadp block
// The following 2-1 mUX is used for psts.
// In C6, the data is merged with partial dirty data and written into
// the Miss Buffer.
// arbdp_waddr_c6[1:0] is the Address bit[3:2] of the regular instruction.
// "arbdp_addr22_c7" is the Address Bit[22] of the Diagnostic access.
// It is equivalent to the address bit[2] for the diagnostic access and is
// used for selecting 32 bit out of 128 bit read from the L2$ data array.
//
//////////////////////////////////////////////////////////////////////////

// arbdp_waddr_c6[1:0] is the Address bit[3:2] of the regular instruction.
dff_s   #(2)    ff_waddr_c7
              (.q   (waddr_c7[1:0]),
               .din (arbdp_waddr_c6[1:0]),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;

assign diag_addr_c7 = {waddr_c7[1], arbdp_addr22_c7} ;



// Address bit[3] of Scrub instruction, used for selecting 64 bit out of
// 128 bit read from the L2$ data array.



dff_s   #(1)    ff_decc_active_c4
              (.q   (data_ecc_active_c4),
               .din (data_ecc_active_c3),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;
dff_s   #(1)    ff_decc_active_c5
              (.q   (data_ecc_active_c5),
               .din (data_ecc_active_c4),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;
dff_s   #(1)    ff_decc_active_c6
              (.q   (data_ecc_active_c6),
               .din (data_ecc_active_c5),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;
dff_s   #(1)    ff_decc_active_c7
              (.q   (data_ecc_active_c7),
               .din (data_ecc_active_c6),
               .clk (rclk),
               .se(se), .si  (), .so  ()
              ) ;

assign dword_sel_c7 = (diag_addr_c7[1] & ~data_ecc_active_c7) 
		| tagctl_decc_addr3_c7 ;

// the following data muxes are used for
//  1. diagnostic accesses to l2data
//  2. tap reads to DRAm addresses.
//  3. bist accesses to l2data.
// these operation need 39 bit data out of the 156 bit read from the L2 array,
// so the data needs to be muxed 4:1. The 4to1 muxing is done in two stages
// of 2to1 muxing using the address bit[3:2] as the select signals.

dff_s   #(1)    ff_diag_data_vld_c7 
		(.q   (diag_data_vld_c7), .din (arbctl_inst_l2data_vld_c6), 
		.clk (rclk), .se(se), .si  (), .so  ()) ;


assign	sel_bist_c6 = bist_data_enable_c6 ;
assign	sel_diag_c7 = diag_data_vld_c7  & ~bist_data_enable_c6 ;
assign	sel_def_c6  = ~diag_data_vld_c7 & ~bist_data_enable_c6 ;

assign  sel_higher_word_c6 = (diag_addr_c7[0]       & sel_diag_c7) |
                             (bist_data_waddr_c6[0] & sel_bist_c6) |
                             (arbdp_waddr_c6[0]     & sel_def_c6) ;

dff_s   #(1)    ff_sel_higher_word_c7
              (.q   (sel_higher_word_c7), .din (sel_higher_word_c6),
               .clk (rclk), .se(se), .si  (), .so  ()) ;


assign  sel_higher_dword_c6 = (diag_addr_c7[1]       & sel_diag_c7) |
                              (bist_data_waddr_c6[1] & sel_bist_c6) |
                              (arbdp_waddr_c6[1]     & sel_def_c6) ;

dff_s   #(1)    ff_sel_higher_dword_c7
              (.q   (sel_higher_dword_c7), .din (sel_higher_dword_c6),
               .clk (rclk), .se(se), .si  (), .so  ()) ;


endmodule
