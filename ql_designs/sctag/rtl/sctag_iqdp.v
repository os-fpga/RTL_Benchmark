// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_iqdp.v
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
module sctag_iqdp
 (/*AUTOARG*/
   // Outputs
   so, iq_arbdp_data_px2, iq_arbdp_addr_px2, iq_arbdp_inst_px2, 
   iq_arbctl_atm_px2, iq_arbctl_csr_px2, iq_arbctl_st_px2, 
   iq_arbctl_vbit_px2, iqdp_iqarray_data_in, 
   // Inputs
   rclk, se, si, pcx_sctag_data_px2, pcx_sctag_atm_px2_p, 
   iq_array_rd_data_c1, iqctl_sel_pcx, iqctl_sel_c1, iqctl_hold_rd, 
   sel_c1reg_over_iqarray
   ) ;


input           rclk;
input           se;
input           si;
input  [123:0]  pcx_sctag_data_px2;
input           pcx_sctag_atm_px2_p;
input  [124:0]  iq_array_rd_data_c1;
input           iqctl_sel_pcx;
input           iqctl_sel_c1;
input           iqctl_hold_rd;
input           sel_c1reg_over_iqarray;

output          so;
output [63:0]   iq_arbdp_data_px2;
output [39:0]   iq_arbdp_addr_px2;
output [18:0]   iq_arbdp_inst_px2;
output          iq_arbctl_atm_px2;
output          iq_arbctl_csr_px2;
output          iq_arbctl_st_px2;
output		iq_arbctl_vbit_px2;
output	[124:0]	iqdp_iqarray_data_in ; // ECO pin

wire            en_clk;
wire   [124:0]  pcx_sctag_data_c1;
wire   [124:0]  tmp_iq_array_rd_data_c1;
wire   [124:0]  iq_array_rd_data_c2;
wire   [124:0]  mux_c1c2_rd_data;
wire   [124:0]  inst;

// The following bus is an ECO change that was needed tO 
// solve a mintime violation for this path going from the 
// CCX to the iqarray.

assign	iqdp_iqarray_data_in = { pcx_sctag_atm_px2_p, pcx_sctag_data_px2[123:0] } ;

dff_s #(125) ff_pcx_sctag_data_c1
            (.q   (pcx_sctag_data_c1[124:0]),
             .din ({pcx_sctag_atm_px2_p, pcx_sctag_data_px2[123:0]}),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;


clken_buf  clk_buf0
            (.clk(en_clk),
             .rclk(rclk),
             .enb_l(iqctl_hold_rd),
             .tmb_l(~se)
            ) ;

mux2ds #(125)  mux_iq_array_rd_data_c1
                (.dout (tmp_iq_array_rd_data_c1[124:0]),
                 .in0  (iq_array_rd_data_c1[124:0]),  .sel0 (~sel_c1reg_over_iqarray),
                 .in1  (pcx_sctag_data_c1[124:0]),    .sel1 (sel_c1reg_over_iqarray)
                ) ;

dff_s #(125) ff_iq_array_rd_data_c2
            (.q   (iq_array_rd_data_c2[124:0]),
             .din (tmp_iq_array_rd_data_c1[124:0]),
             .clk (en_clk),
             .se(se), .si  (), .so  ()
            ) ;

mux2ds #(125)  u_mux_c1c2_rd_data
                (.dout (mux_c1c2_rd_data[124:0]),
                 .in0  (pcx_sctag_data_c1[124:0]),     .sel0 (iqctl_sel_c1),
                 .in1  (iq_array_rd_data_c2[124:0]),   .sel1 (~iqctl_sel_c1)
                ) ;
mux2ds #(125)  mux_inst
                (.dout (inst[124:0]),
                 .in0  ({pcx_sctag_atm_px2_p,
                         pcx_sctag_data_px2[123:0]}),  .sel0 (iqctl_sel_pcx),
                 .in1  (mux_c1c2_rd_data[124:0]),      .sel1 (~iqctl_sel_pcx)
                ) ;



assign iq_arbdp_data_px2  = inst[63:0] ;
assign iq_arbdp_addr_px2  = inst[103:64] ;
assign iq_arbdp_inst_px2  = inst[122:104] ;
assign iq_arbctl_vbit_px2 = inst[123];
assign iq_arbctl_atm_px2  = inst[124] ;
assign iq_arbctl_csr_px2  = (inst[103:101] == 3'b101) & (inst[99] == 1'b1) ;
assign iq_arbctl_st_px2   = ( (inst[122:118] == 5'b00001)  |	// Store
				(( inst[122:118] == 5'b01101)  &
				   ~inst[117]) )  ;		// FWD_REQ with
								// R/Wbar == 0
endmodule
