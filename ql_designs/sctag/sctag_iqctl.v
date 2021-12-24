// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_iqctl.v
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
////////////////////////////////////////////////////////////////////////////////

module sctag_iqctl
 (/*AUTOARG*/
   // Outputs
   so, iq_array_wr_en, iq_array_wr_wl, iq_array_rd_en, 
   iq_array_rd_wl, sctag_pcx_stall_pq, iq_arbctl_vld_px2, 
   pcx_sctag_atm_px2_p, iqctl_sel_pcx, iqctl_sel_c1, iqctl_hold_rd, 
   sel_c1reg_over_iqarray, 
   // Inputs
   rclk, arst_l, grst_l, se, si, pcx_sctag_data_rdy_px1, 
   pcx_sctag_atm_px1, sehold, arbctl_iqsel_px2
   ) ;

input          rclk;
input          arst_l;
input          grst_l;
input          se;
input          si;
input          pcx_sctag_data_rdy_px1;
input          pcx_sctag_atm_px1;
input		sehold; // NEW_PIN post 4.2
input          arbctl_iqsel_px2;

output	       so;
output	       iq_array_wr_en;
output	[3:0]  iq_array_wr_wl;
output	       iq_array_rd_en;
output	[3:0]  iq_array_rd_wl;

output         sctag_pcx_stall_pq;

output         iq_arbctl_vld_px2;
output         pcx_sctag_atm_px2_p;

output         iqctl_sel_pcx;
output         iqctl_sel_c1;
output         iqctl_hold_rd;

output         sel_c1reg_over_iqarray;


////////////////////////////////////////////////////////////////////////////////
// Local Wires declaration
////////////////////////////////////////////////////////////////////////////////
wire           pcx_sctag_data_rdy_px2 ;
wire           pcx_sctag_data_rdy_px2_d1 ;
wire           arbctl_iqsel_px2_d1 ;

wire           set_c1_reg_inst_vld ;
wire           c1_reg_inst_vld ;

wire           inc_wr_ptr_px2 ;
wire           inc_wr_ptr_c1 ;
wire           sel_wrptr_same, sel_wrptr_plus1 ;
wire  [3:0]    wrptr, wrptr_plus1 ;
wire  [3:0]    wrptr_d1, wrptr_plus1_d1 ;

wire           inc_rd_ptr_px2 ;
wire  [3:0]    rdptr, rdptr_plus1 ;
wire  [3:0]    rdptr_d1 ;

wire           sel_qcount_plus1 ;
wire           sel_qcount_minus1 ;
wire           sel_qcount_same ;
wire  [4:0]    que_cnt, que_cnt_plus1, que_cnt_minus1 ;
wire  [4:0]    next_que_cnt ;
wire           que_cnt_0, que_cnt_0_p, que_cnt_0_n ;
wire           que_cnt_1, que_cnt_1_p, que_cnt_1_n ;
wire           que_cnt_1_plus, que_cnt_1_plus_p, que_cnt_1_plus_n ;
wire           que_cnt_2, que_cnt_2_p, que_cnt_2_n ;
wire           que_cnt_2_plus_p ;
wire           que_cnt_3_p ;
wire           que_cnt_11_p ;
wire           que_cnt_12, que_cnt_12_p, que_cnt_12_n ;
wire           que_cnt_12_plus, que_cnt_12_plus_p, que_cnt_12_plus_n ;
wire           que_cnt_13_p ;
wire           que_cnt_13_plus_p ;

wire           set_iqctl_sel_iq ;
wire           set_iqctl_sel_pcx ;
wire           iqctl_sel_iq;
wire           iqctl_sel_iq_d1;
wire           iqctl_sel_iq_fe;


wire            dbb_rst_l;
///////////////////////////////////////////////////////////////////
 // Reset flop
 ///////////////////////////////////////////////////////////////////

 dffrl_async    #(1)    reset_flop      (.q(dbb_rst_l),
                                        .clk(rclk),
                                        .rst_l(arst_l),
                                        .din(grst_l),
                                        .se(se), .si(), .so());



////////////////////////////////////////////////////////////////////////////////
dff_s #(1)   ff_pcx_sctag_data_rdy_px2
            (.q   (pcx_sctag_data_rdy_px2),
             .din (pcx_sctag_data_rdy_px1),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;

dff_s #(1)   ff_pcx_sctag_data_rdy_px2_d1
            (.q   (pcx_sctag_data_rdy_px2_d1),
             .din (pcx_sctag_data_rdy_px2),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;

dff_s #(1)   ff_pcx_sctag_atm_px2_p
            (.q   (pcx_sctag_atm_px2_p),
             .din (pcx_sctag_atm_px1),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;



dff_s #(1)   ff_arbctl_iqsel_px2_d1
            (.q   (arbctl_iqsel_px2_d1),
             .din (arbctl_iqsel_px2),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;


////////////////////////////////////////////////////////////////////////////////
// "c1_reg_inst_vld" signal will be used to indicate that there is a valid
// instructon in the C1 Flop. C1 flop instruction is only valid if the queue is
// empty and the instruction issued by the pcx is not selected in the same cycle
// by the arbiter. C1 flop is used to store the instruction for only one cycle
// in the case queue is empty and instruction issued by pcx is not selected by
// arbiter in the same cycle.
////////////////////////////////////////////////////////////////////////////////

assign set_c1_reg_inst_vld = ((que_cnt_0 | (que_cnt_1 & sel_qcount_minus1)) &
                               ~c1_reg_inst_vld & pcx_sctag_data_rdy_px2 & ~arbctl_iqsel_px2) |
                             (((c1_reg_inst_vld) |
                               (que_cnt_1 & ~sel_qcount_minus1 & ~sel_qcount_plus1) |
                               (que_cnt_2 &  sel_qcount_minus1)) &
                               pcx_sctag_data_rdy_px2 & arbctl_iqsel_px2) ;

dff_s #(1)   ff_pcx_inst_vld_c1
            (.q   (c1_reg_inst_vld),
             .din (set_c1_reg_inst_vld),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;


////////////////////////////////////////////////////////////////////////////////
// Pipeline for Write Enable and Write Pointer generation for PH2 write
//
//===================================================
//    PX2            |               C1             |
//===================================================
//       write into  |                  write into  |
//       IQ array    |                  IQ array    |
//                   |                              |
//       gen wrt en  |                  gen wrt en  |
//                   |                              |
//       gen inc wrt | Mux select new   gen inc wrt |
//       ptr signal  | wrt pointer      ptr signal  |
//                   |                              |
//       gen wrt ptr |                  gen wrt ptr |
//       plus 1      |                  plus 1      |
//===================================================
////////////////////////////////////////////////////////////////////////////////

assign inc_wr_ptr_px2 = pcx_sctag_data_rdy_px2 & (~arbctl_iqsel_px2 |
                        ((~que_cnt_0 & ~(que_cnt_1 & sel_qcount_minus1)) |
                           c1_reg_inst_vld)) ;

dff_s #(1)   ff_inc_wr_ptr_c1
            (.q   (inc_wr_ptr_c1),
             .din (inc_wr_ptr_px2),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;

assign	sel_wrptr_plus1 = dbb_rst_l &  inc_wr_ptr_c1 ;
assign	sel_wrptr_same  = dbb_rst_l & ~inc_wr_ptr_c1 ; 

assign	wrptr_plus1     = wrptr + 4'b1 ;

mux3ds #(4)  mux_wrptr
              (.dout (wrptr[3:0]),
               .in0  (4'b0),                 .sel0 (~dbb_rst_l),
               .in1  (wrptr_plus1_d1[3:0]),  .sel1 (sel_wrptr_plus1),
               .in2  (wrptr_d1[3:0]),        .sel2 (sel_wrptr_same)
              ) ;


dff_s #(4)   ff_array_wr_ptr_plus1
            (.q   (wrptr_plus1_d1[3:0]),
             .din (wrptr_plus1[3:0]),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;

dff_s #(4)   ff_array_wr_ptr
            (.q   (wrptr_d1[3:0]),
             .din (wrptr[3:0]),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;

assign  iq_array_wr_en = pcx_sctag_data_rdy_px2 ;
assign  iq_array_wr_wl = wrptr ;


////////////////////////////////////////////////////////////////////////////////
//==================================================
//    PX2            |            C1               |
//==================================================
//      gen rd en    |                gen rd en    |
//                   |                             |
//     mux slect new | gen rd ptr    mux slect new |
//       rd ptr      |   plus 1        rd ptr      |
//==================================================
//
// Generation of Mux select for selecting between Read Pointer and it's
// Incremented value depends on the 'arbctl_iqsel_px2' signal. New value of
// write pointer is selected and transmitted to the IQ array for reading the
// array. Since 'arbctl_iqsel_px2' signal arrives late in the cycle this may
// create timing problem.
//
////////////////////////////////////////////////////////////////////////////////

assign  iq_array_rd_en = iq_arbctl_vld_px2 ;
assign	iq_array_rd_wl = rdptr ;

assign  inc_rd_ptr_px2 =  c1_reg_inst_vld |
                          (que_cnt_1 & sel_qcount_plus1 & arbctl_iqsel_px2) |
                          (que_cnt_1_plus & ~(que_cnt_2 & sel_qcount_minus1) &
                           arbctl_iqsel_px2) ;


assign	rdptr_plus1    = rdptr_d1 + 4'b1 ;

mux2ds #(4)  mux_rdptr
              (.dout (rdptr[3:0]),
               .in0  (rdptr_d1[3:0]),     .sel0 (~inc_rd_ptr_px2),
               .in1  (rdptr_plus1[3:0]),  .sel1 (inc_rd_ptr_px2)
              ) ;


dffrl_s #(4)  ff_array_rd_ptr
             (.q   (rdptr_d1[3:0]),
              .din (rdptr[3:0]),
              .clk (rclk),  .rst_l(dbb_rst_l),
              .se(se), .si  (), .so  ()
             ) ;


////////////////////////////////////////////////////////////////////////////////
//==============================================================================
//    PX2                |            C1             |         C2
//==============================================================================
//       latch pcx rdy   |  gen qcount inc, dec or   | new Qcount vlue
//       & iqsel signals |         same sig.         |
//                       |                           |
//                       | gen next compare values   | new compare values
//                       | based on current qcount   |
//                       | & inc, dec or same signal |
//                       |                           |
//                       |           latch pcx rdy   | gen qcount inc, dec or
//                       |           & iqsel signals |       same sig.
//                       |                           |
//                       |                           | gen next compare values
//                       |                           | based on current qcount
//                       |                           | & inc, dec or same signal
//                       |                           |
//                       |                           |          latch pcx rdy
//                       |                           |          & iqsel signals
////////////////////////////////////////////////////////////////////////////////

assign  sel_qcount_plus1  =  pcx_sctag_data_rdy_px2_d1 & ~arbctl_iqsel_px2_d1 ;
assign	sel_qcount_minus1 = ~pcx_sctag_data_rdy_px2_d1 &  arbctl_iqsel_px2_d1 ;
assign  sel_qcount_same   = ~(sel_qcount_plus1 | sel_qcount_minus1) ;

assign	que_cnt_plus1     = que_cnt + 5'b1 ;
assign	que_cnt_minus1    = que_cnt - 5'b1 ;

mux3ds #(5)  mux_que_cnt
              (.dout (next_que_cnt[4:0]),
               .in0 (que_cnt_plus1[4:0]),   .sel0 (sel_qcount_plus1),
               .in1 (que_cnt_minus1[4:0]),  .sel1 (sel_qcount_minus1),
               .in2 (que_cnt[4:0]),         .sel2 (sel_qcount_same)
              ) ;
dffrl_s #(5)  ff_que_cnt
             (.q   (que_cnt[4:0]),
              .din (next_que_cnt[4:0]),
              .clk (rclk),  .rst_l (dbb_rst_l),
              .se(se), .si  (), .so  ()
             ) ;



assign  que_cnt_0_p       = ~(|que_cnt[4:0]) ;
assign  que_cnt_1_p       = (~que_cnt_1_plus & que_cnt[0]) ;
assign  que_cnt_1_plus_p  = |(que_cnt[4:1]) ;
assign  que_cnt_2_p       = ~(|que_cnt[4:2] | que_cnt[0]) & que_cnt[1] ;
assign  que_cnt_2_plus_p  = (|que_cnt[4:2]) | (&que_cnt[1:0]) ;
assign  que_cnt_3_p       = ~(|que_cnt[4:2]) & (&que_cnt[1:0]) ;
assign  que_cnt_11_p      = (que_cnt == 5'd11) ;
assign  que_cnt_12_p      = (que_cnt == 5'd12) ;
assign  que_cnt_12_plus_p = (que_cnt >  5'd12) ;
assign  que_cnt_13_p      = (que_cnt == 5'd13) ;
assign  que_cnt_13_plus_p = (que_cnt >  5'd13) ;


assign  que_cnt_0_n       = (que_cnt_0_p & sel_qcount_same)  |
                            (que_cnt_1_p & sel_qcount_minus1) ;
assign  que_cnt_1_n       = (que_cnt_1_p & sel_qcount_same)  |
                            (que_cnt_0_p & sel_qcount_plus1) |
                            (que_cnt_2_p & sel_qcount_minus1) ;
assign  que_cnt_1_plus_n  = (que_cnt_1_plus_p & (sel_qcount_same | sel_qcount_plus1)) |
                            (que_cnt_1_p & sel_qcount_plus1) |
                            (que_cnt_2_plus_p & sel_qcount_minus1) ;
assign  que_cnt_2_n       = (que_cnt_2_p & sel_qcount_same)  |
                            (que_cnt_1_p & sel_qcount_plus1) |
                            (que_cnt_3_p & sel_qcount_minus1) ;
assign  que_cnt_12_n      = (que_cnt_12_p & sel_qcount_same)  |
                            (que_cnt_11_p & sel_qcount_plus1) |
                            (que_cnt_13_p & sel_qcount_minus1) ;
assign  que_cnt_12_plus_n = (que_cnt_12_plus_p & (sel_qcount_same | sel_qcount_plus1)) |
                            (que_cnt_12_p & sel_qcount_plus1) |
                            (que_cnt_13_plus_p & sel_qcount_minus1) ;



dff_s #(1)   ff_que_cnt_0
            (.q   (que_cnt_0),
             .din (que_cnt_0_n),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;

dff_s #(1)   ff_que_cnt_1
            (.q   (que_cnt_1),
             .din (que_cnt_1_n),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;

dff_s #(1)   ff_que_cnt_1_plus
            (.q   (que_cnt_1_plus),
             .din (que_cnt_1_plus_n),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;

dff_s #(1)   ff_que_cnt_2
            (.q   (que_cnt_2),
             .din (que_cnt_2_n),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;

dff_s #(1)   ff_que_cnt_12
            (.q   (que_cnt_12),
             .din (que_cnt_12_n),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;

dff_s #(1)   ff_que_cnt_12_plus
            (.q   (que_cnt_12_plus),
             .din (que_cnt_12_plus_n),
             .clk (rclk),
             .se(se), .si  (), .so  ()
            ) ;


////////////////////////////////////////////////////////////////////////////////
// ----\/ FIX for macrotest \/---------
// sehold is high during macrotest. This will ensure that the array
// data is always chosen over the c1reg data during macrotest.
////////////////////////////////////////////////////////////////////////////////
assign  sel_c1reg_over_iqarray = (wrptr_d1 == rdptr_d1)  & ~sehold ;


////////////////////////////////////////////////////////////////////////////////
// MUX sel generation for IQ dp.
////////////////////////////////////////////////////////////////////////////////

//assign  iqctl_sel_iq  = ~c1_reg_inst_vld &
//                        (que_cnt_1_plus | (que_cnt_1 & ~arbctl_iqsel_px2_d1)) ;
assign  set_iqctl_sel_iq = ~set_c1_reg_inst_vld &
                           (que_cnt_1_plus_n | (que_cnt_1_n & ~arbctl_iqsel_px2)) ;
dff_s #(1)   ff_iqctl_sel_iq
            (.q   (iqctl_sel_iq),
             .din (set_iqctl_sel_iq),
             .clk (rclk),
             .se  (se), .si  (), .so  ()
            ) ;


//assign  iqctl_sel_c1  = c1_reg_inst_vld ;
dff_s #(1)   ff_iqctl_sel_c1
            (.q   (iqctl_sel_c1),
             .din (set_c1_reg_inst_vld),
             .clk (rclk),
             .se  (se), .si  (), .so  ()
            ) ;


//assign  iqctl_sel_pcx = ~iqctl_sel_iq & ~iqctl_sel_c1 ;
assign  set_iqctl_sel_pcx = ~set_iqctl_sel_iq & ~set_c1_reg_inst_vld ;
dff_s #(1)   ff_iqctl_sel_pcx
            (.q   (iqctl_sel_pcx),
             .din (set_iqctl_sel_pcx),
             .clk (rclk),
             .se  (se), .si  (), .so  ()
            ) ;




dff_s #(1)   ff_iqctl_sel_iq_d1
            (.q   (iqctl_sel_iq_d1),
             .din (iqctl_sel_iq),
             .clk (rclk),
             .se  (se), .si  (), .so  ()
            ) ;

assign  iqctl_sel_iq_fe = iqctl_sel_iq_d1 & ~iqctl_sel_iq ;

assign  iqctl_hold_rd   = iqctl_sel_iq & ~arbctl_iqsel_px2 & ~iqctl_sel_iq_fe ;


////////////////////////////////////////////////////////////////////////////////
// IQ COUNT
//
// MUX here
//      PQ  PA  PX1 PX2  C1   C2(counter update for pckt in PX2)
//          PQ  PA  PX1  PX2  C1   C2
//              PQ  PA   PX1  PX2  C1	C2
//                  PQ   PA   PX1  PX2  C1
//                       PQ   PA   PX1  PX2  C1   C2
//                            PQ   PA   PX1  PX2  C1
//
// When the stall is signalled, there can potentially be 5 packets in C1, 
// PX2, Px1, PA and PQ that need to be queued in the IQ. The packet in PQ may
// be an atomic hence, the high water mark is 11.
////////////////////////////////////////////////////////////////////////////////

assign sctag_pcx_stall_pq = que_cnt_12_plus |
                           (que_cnt_12 & (pcx_sctag_data_rdy_px2_d1 &
                                            ~arbctl_iqsel_px2_d1)) ;

assign iq_arbctl_vld_px2  = pcx_sctag_data_rdy_px2 | c1_reg_inst_vld |
                            (que_cnt_1_plus | (que_cnt_1 & ~sel_qcount_minus1)) ;
                            


endmodule
