////////////////////////////////////////////////////////////
//
//        (C) Copyright 2021 Eximius Design
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
////////////////////////////////////////////////////////////

module axi_st_d256_dm_drng_2_up_half_slave_concat  (

// Data from Logic Links
  output logic [ 513:   0]   rx_st_data          ,
  output logic               rx_st_push_ovrd     ,
  output logic               rx_st_pushbit       ,
  input  logic [   3:   0]   tx_st_credit        ,

// PHY Interconnect
  output logic [  79:   0]   tx_phy0             ,
  input  logic [  79:   0]   rx_phy0             ,
  output logic [  79:   0]   tx_phy1             ,
  input  logic [  79:   0]   rx_phy1             ,
  output logic [  79:   0]   tx_phy2             ,
  input  logic [  79:   0]   rx_phy2             ,
  output logic [  79:   0]   tx_phy3             ,
  input  logic [  79:   0]   rx_phy3             ,
  output logic [  79:   0]   tx_phy4             ,
  input  logic [  79:   0]   rx_phy4             ,
  output logic [  79:   0]   tx_phy5             ,
  input  logic [  79:   0]   rx_phy5             ,
  output logic [  79:   0]   tx_phy6             ,
  input  logic [  79:   0]   rx_phy6             ,

  input  logic               clk_wr              ,
  input  logic               clk_rd              ,
  input  logic               rst_wr_n            ,
  input  logic               rst_rd_n            ,

  input  logic               m_gen2_mode         ,
  input  logic               tx_online           ,

  input  logic               tx_stb_userbit      ,
  input  logic [   1:   0]   tx_mrk_userbit      

);

// No TX Packetization, so tie off packetization signals

// No RX Packetization, so tie off packetization signals
  assign rx_st_push_ovrd                    = 1'b0                               ;

//////////////////////////////////////////////////////////////////
// TX Section

//   TX_CH_WIDTH           = 80; // Gen1Only running at Half Rate
//   TX_DATA_WIDTH         = 76; // Usable Data per Channel
//   TX_PERSISTENT_STROBE  = 1'b1;
//   TX_PERSISTENT_MARKER  = 1'b1;
//   TX_STROBE_GEN2_LOC    = 'd1;
//   TX_MARKER_GEN2_LOC    = 'd39;
//   TX_STROBE_GEN1_LOC    = 'd1;
//   TX_MARKER_GEN1_LOC    = 'd39;
//   TX_ENABLE_STROBE      = 1'b1;
//   TX_ENABLE_MARKER      = 1'b1;
//   TX_DBI_PRESENT        = 1'b0;
//   TX_REG_PHY            = 1'b0;

  localparam TX_REG_PHY    = 1'b0;  // If set, this enables boundary FF for timing reasons

  logic [  79:   0]                              tx_phy_preflop_0              ;
  logic [  79:   0]                              tx_phy_preflop_1              ;
  logic [  79:   0]                              tx_phy_preflop_2              ;
  logic [  79:   0]                              tx_phy_preflop_3              ;
  logic [  79:   0]                              tx_phy_preflop_4              ;
  logic [  79:   0]                              tx_phy_preflop_5              ;
  logic [  79:   0]                              tx_phy_preflop_6              ;
  logic [  79:   0]                              tx_phy_flop_0_reg             ;
  logic [  79:   0]                              tx_phy_flop_1_reg             ;
  logic [  79:   0]                              tx_phy_flop_2_reg             ;
  logic [  79:   0]                              tx_phy_flop_3_reg             ;
  logic [  79:   0]                              tx_phy_flop_4_reg             ;
  logic [  79:   0]                              tx_phy_flop_5_reg             ;
  logic [  79:   0]                              tx_phy_flop_6_reg             ;

  always_ff @(posedge clk_wr or negedge rst_wr_n)
  if (~rst_wr_n)
  begin
    tx_phy_flop_0_reg                       <= 80'b0                                   ;
    tx_phy_flop_1_reg                       <= 80'b0                                   ;
    tx_phy_flop_2_reg                       <= 80'b0                                   ;
    tx_phy_flop_3_reg                       <= 80'b0                                   ;
    tx_phy_flop_4_reg                       <= 80'b0                                   ;
    tx_phy_flop_5_reg                       <= 80'b0                                   ;
    tx_phy_flop_6_reg                       <= 80'b0                                   ;
  end
  else
  begin
    tx_phy_flop_0_reg                       <= tx_phy_preflop_0                        ;
    tx_phy_flop_1_reg                       <= tx_phy_preflop_1                        ;
    tx_phy_flop_2_reg                       <= tx_phy_preflop_2                        ;
    tx_phy_flop_3_reg                       <= tx_phy_preflop_3                        ;
    tx_phy_flop_4_reg                       <= tx_phy_preflop_4                        ;
    tx_phy_flop_5_reg                       <= tx_phy_preflop_5                        ;
    tx_phy_flop_6_reg                       <= tx_phy_preflop_6                        ;
  end

  assign tx_phy0                            = TX_REG_PHY ? tx_phy_flop_0_reg : tx_phy_preflop_0               ;
  assign tx_phy1                            = TX_REG_PHY ? tx_phy_flop_1_reg : tx_phy_preflop_1               ;
  assign tx_phy2                            = TX_REG_PHY ? tx_phy_flop_2_reg : tx_phy_preflop_2               ;
  assign tx_phy3                            = TX_REG_PHY ? tx_phy_flop_3_reg : tx_phy_preflop_3               ;
  assign tx_phy4                            = TX_REG_PHY ? tx_phy_flop_4_reg : tx_phy_preflop_4               ;
  assign tx_phy5                            = TX_REG_PHY ? tx_phy_flop_5_reg : tx_phy_preflop_5               ;
  assign tx_phy6                            = TX_REG_PHY ? tx_phy_flop_6_reg : tx_phy_preflop_6               ;

  logic                                          tx_st_credit_r0               ;
  logic                                          tx_st_credit_r1               ;
  logic                                          tx_st_credit_r2               ;
  logic                                          tx_st_credit_r3               ;

  // Asymmetric Credit Logic
  assign tx_st_credit_r0                    = tx_st_credit         [   0 +:   1] ;
  assign tx_st_credit_r1                    = tx_st_credit         [   1 +:   1] ;
  assign tx_st_credit_r2                    = 1'b0                               ;
  assign tx_st_credit_r3                    = 1'b0                               ;

  assign tx_phy_preflop_0 [   0] = tx_st_credit_r0            ;
  assign tx_phy_preflop_0 [   1] = tx_stb_userbit             ; // STROBE
  assign tx_phy_preflop_0 [   2] = 1'b0                       ;
  assign tx_phy_preflop_0 [   3] = 1'b0                       ;
  assign tx_phy_preflop_0 [   4] = 1'b0                       ;
  assign tx_phy_preflop_0 [   5] = 1'b0                       ;
  assign tx_phy_preflop_0 [   6] = 1'b0                       ;
  assign tx_phy_preflop_0 [   7] = 1'b0                       ;
  assign tx_phy_preflop_0 [   8] = 1'b0                       ;
  assign tx_phy_preflop_0 [   9] = 1'b0                       ;
  assign tx_phy_preflop_0 [  10] = 1'b0                       ;
  assign tx_phy_preflop_0 [  11] = 1'b0                       ;
  assign tx_phy_preflop_0 [  12] = 1'b0                       ;
  assign tx_phy_preflop_0 [  13] = 1'b0                       ;
  assign tx_phy_preflop_0 [  14] = 1'b0                       ;
  assign tx_phy_preflop_0 [  15] = 1'b0                       ;
  assign tx_phy_preflop_0 [  16] = 1'b0                       ;
  assign tx_phy_preflop_0 [  17] = 1'b0                       ;
  assign tx_phy_preflop_0 [  18] = 1'b0                       ;
  assign tx_phy_preflop_0 [  19] = 1'b0                       ;
  assign tx_phy_preflop_0 [  20] = 1'b0                       ;
  assign tx_phy_preflop_0 [  21] = 1'b0                       ;
  assign tx_phy_preflop_0 [  22] = 1'b0                       ;
  assign tx_phy_preflop_0 [  23] = 1'b0                       ;
  assign tx_phy_preflop_0 [  24] = 1'b0                       ;
  assign tx_phy_preflop_0 [  25] = 1'b0                       ;
  assign tx_phy_preflop_0 [  26] = 1'b0                       ;
  assign tx_phy_preflop_0 [  27] = 1'b0                       ;
  assign tx_phy_preflop_0 [  28] = 1'b0                       ;
  assign tx_phy_preflop_0 [  29] = 1'b0                       ;
  assign tx_phy_preflop_0 [  30] = 1'b0                       ;
  assign tx_phy_preflop_0 [  31] = 1'b0                       ;
  assign tx_phy_preflop_0 [  32] = 1'b0                       ;
  assign tx_phy_preflop_0 [  33] = 1'b0                       ;
  assign tx_phy_preflop_0 [  34] = 1'b0                       ;
  assign tx_phy_preflop_0 [  35] = 1'b0                       ;
  assign tx_phy_preflop_0 [  36] = 1'b0                       ;
  assign tx_phy_preflop_0 [  37] = 1'b0                       ;
  assign tx_phy_preflop_0 [  38] = 1'b0                       ;
  assign tx_phy_preflop_0 [  39] = tx_mrk_userbit[0]          ; // MARKER
  assign tx_phy_preflop_1 [   0] = 1'b0                       ;
  assign tx_phy_preflop_1 [   1] = tx_stb_userbit             ; // STROBE
  assign tx_phy_preflop_1 [   2] = 1'b0                       ;
  assign tx_phy_preflop_1 [   3] = 1'b0                       ;
  assign tx_phy_preflop_1 [   4] = 1'b0                       ;
  assign tx_phy_preflop_1 [   5] = 1'b0                       ;
  assign tx_phy_preflop_1 [   6] = 1'b0                       ;
  assign tx_phy_preflop_1 [   7] = 1'b0                       ;
  assign tx_phy_preflop_1 [   8] = 1'b0                       ;
  assign tx_phy_preflop_1 [   9] = 1'b0                       ;
  assign tx_phy_preflop_1 [  10] = 1'b0                       ;
  assign tx_phy_preflop_1 [  11] = 1'b0                       ;
  assign tx_phy_preflop_1 [  12] = 1'b0                       ;
  assign tx_phy_preflop_1 [  13] = 1'b0                       ;
  assign tx_phy_preflop_1 [  14] = 1'b0                       ;
  assign tx_phy_preflop_1 [  15] = 1'b0                       ;
  assign tx_phy_preflop_1 [  16] = 1'b0                       ;
  assign tx_phy_preflop_1 [  17] = 1'b0                       ;
  assign tx_phy_preflop_1 [  18] = 1'b0                       ;
  assign tx_phy_preflop_1 [  19] = 1'b0                       ;
  assign tx_phy_preflop_1 [  20] = 1'b0                       ;
  assign tx_phy_preflop_1 [  21] = 1'b0                       ;
  assign tx_phy_preflop_1 [  22] = 1'b0                       ;
  assign tx_phy_preflop_1 [  23] = 1'b0                       ;
  assign tx_phy_preflop_1 [  24] = 1'b0                       ;
  assign tx_phy_preflop_1 [  25] = 1'b0                       ;
  assign tx_phy_preflop_1 [  26] = 1'b0                       ;
  assign tx_phy_preflop_1 [  27] = 1'b0                       ;
  assign tx_phy_preflop_1 [  28] = 1'b0                       ;
  assign tx_phy_preflop_1 [  29] = 1'b0                       ;
  assign tx_phy_preflop_1 [  30] = 1'b0                       ;
  assign tx_phy_preflop_1 [  31] = 1'b0                       ;
  assign tx_phy_preflop_1 [  32] = 1'b0                       ;
  assign tx_phy_preflop_1 [  33] = 1'b0                       ;
  assign tx_phy_preflop_1 [  34] = 1'b0                       ;
  assign tx_phy_preflop_1 [  35] = 1'b0                       ;
  assign tx_phy_preflop_1 [  36] = 1'b0                       ;
  assign tx_phy_preflop_1 [  37] = 1'b0                       ;
  assign tx_phy_preflop_1 [  38] = 1'b0                       ;
  assign tx_phy_preflop_1 [  39] = tx_mrk_userbit[0]          ; // MARKER
  assign tx_phy_preflop_2 [   0] = 1'b0                       ;
  assign tx_phy_preflop_2 [   1] = tx_stb_userbit             ; // STROBE
  assign tx_phy_preflop_2 [   2] = 1'b0                       ;
  assign tx_phy_preflop_2 [   3] = 1'b0                       ;
  assign tx_phy_preflop_2 [   4] = 1'b0                       ;
  assign tx_phy_preflop_2 [   5] = 1'b0                       ;
  assign tx_phy_preflop_2 [   6] = 1'b0                       ;
  assign tx_phy_preflop_2 [   7] = 1'b0                       ;
  assign tx_phy_preflop_2 [   8] = 1'b0                       ;
  assign tx_phy_preflop_2 [   9] = 1'b0                       ;
  assign tx_phy_preflop_2 [  10] = 1'b0                       ;
  assign tx_phy_preflop_2 [  11] = 1'b0                       ;
  assign tx_phy_preflop_2 [  12] = 1'b0                       ;
  assign tx_phy_preflop_2 [  13] = 1'b0                       ;
  assign tx_phy_preflop_2 [  14] = 1'b0                       ;
  assign tx_phy_preflop_2 [  15] = 1'b0                       ;
  assign tx_phy_preflop_2 [  16] = 1'b0                       ;
  assign tx_phy_preflop_2 [  17] = 1'b0                       ;
  assign tx_phy_preflop_2 [  18] = 1'b0                       ;
  assign tx_phy_preflop_2 [  19] = 1'b0                       ;
  assign tx_phy_preflop_2 [  20] = 1'b0                       ;
  assign tx_phy_preflop_2 [  21] = 1'b0                       ;
  assign tx_phy_preflop_2 [  22] = 1'b0                       ;
  assign tx_phy_preflop_2 [  23] = 1'b0                       ;
  assign tx_phy_preflop_2 [  24] = 1'b0                       ;
  assign tx_phy_preflop_2 [  25] = 1'b0                       ;
  assign tx_phy_preflop_2 [  26] = 1'b0                       ;
  assign tx_phy_preflop_2 [  27] = 1'b0                       ;
  assign tx_phy_preflop_2 [  28] = 1'b0                       ;
  assign tx_phy_preflop_2 [  29] = 1'b0                       ;
  assign tx_phy_preflop_2 [  30] = 1'b0                       ;
  assign tx_phy_preflop_2 [  31] = 1'b0                       ;
  assign tx_phy_preflop_2 [  32] = 1'b0                       ;
  assign tx_phy_preflop_2 [  33] = 1'b0                       ;
  assign tx_phy_preflop_2 [  34] = 1'b0                       ;
  assign tx_phy_preflop_2 [  35] = 1'b0                       ;
  assign tx_phy_preflop_2 [  36] = 1'b0                       ;
  assign tx_phy_preflop_2 [  37] = 1'b0                       ;
  assign tx_phy_preflop_2 [  38] = 1'b0                       ;
  assign tx_phy_preflop_2 [  39] = tx_mrk_userbit[0]          ; // MARKER
  assign tx_phy_preflop_3 [   0] = 1'b0                       ;
  assign tx_phy_preflop_3 [   1] = tx_stb_userbit             ; // STROBE
  assign tx_phy_preflop_3 [   2] = 1'b0                       ;
  assign tx_phy_preflop_3 [   3] = 1'b0                       ;
  assign tx_phy_preflop_3 [   4] = 1'b0                       ;
  assign tx_phy_preflop_3 [   5] = 1'b0                       ;
  assign tx_phy_preflop_3 [   6] = 1'b0                       ;
  assign tx_phy_preflop_3 [   7] = 1'b0                       ;
  assign tx_phy_preflop_3 [   8] = 1'b0                       ;
  assign tx_phy_preflop_3 [   9] = 1'b0                       ;
  assign tx_phy_preflop_3 [  10] = 1'b0                       ;
  assign tx_phy_preflop_3 [  11] = 1'b0                       ;
  assign tx_phy_preflop_3 [  12] = 1'b0                       ;
  assign tx_phy_preflop_3 [  13] = 1'b0                       ;
  assign tx_phy_preflop_3 [  14] = 1'b0                       ;
  assign tx_phy_preflop_3 [  15] = 1'b0                       ;
  assign tx_phy_preflop_3 [  16] = 1'b0                       ;
  assign tx_phy_preflop_3 [  17] = 1'b0                       ;
  assign tx_phy_preflop_3 [  18] = 1'b0                       ;
  assign tx_phy_preflop_3 [  19] = 1'b0                       ;
  assign tx_phy_preflop_3 [  20] = 1'b0                       ;
  assign tx_phy_preflop_3 [  21] = 1'b0                       ;
  assign tx_phy_preflop_3 [  22] = 1'b0                       ;
  assign tx_phy_preflop_3 [  23] = 1'b0                       ;
  assign tx_phy_preflop_3 [  24] = 1'b0                       ;
  assign tx_phy_preflop_3 [  25] = 1'b0                       ;
  assign tx_phy_preflop_3 [  26] = 1'b0                       ;
  assign tx_phy_preflop_3 [  27] = 1'b0                       ;
  assign tx_phy_preflop_3 [  28] = 1'b0                       ;
  assign tx_phy_preflop_3 [  29] = 1'b0                       ;
  assign tx_phy_preflop_3 [  30] = 1'b0                       ;
  assign tx_phy_preflop_3 [  31] = 1'b0                       ;
  assign tx_phy_preflop_3 [  32] = 1'b0                       ;
  assign tx_phy_preflop_3 [  33] = 1'b0                       ;
  assign tx_phy_preflop_3 [  34] = 1'b0                       ;
  assign tx_phy_preflop_3 [  35] = 1'b0                       ;
  assign tx_phy_preflop_3 [  36] = 1'b0                       ;
  assign tx_phy_preflop_3 [  37] = 1'b0                       ;
  assign tx_phy_preflop_3 [  38] = 1'b0                       ;
  assign tx_phy_preflop_3 [  39] = tx_mrk_userbit[0]          ; // MARKER
  assign tx_phy_preflop_4 [   0] = 1'b0                       ;
  assign tx_phy_preflop_4 [   1] = tx_stb_userbit             ; // STROBE
  assign tx_phy_preflop_4 [   2] = 1'b0                       ;
  assign tx_phy_preflop_4 [   3] = 1'b0                       ;
  assign tx_phy_preflop_4 [   4] = 1'b0                       ;
  assign tx_phy_preflop_4 [   5] = 1'b0                       ;
  assign tx_phy_preflop_4 [   6] = 1'b0                       ;
  assign tx_phy_preflop_4 [   7] = 1'b0                       ;
  assign tx_phy_preflop_4 [   8] = 1'b0                       ;
  assign tx_phy_preflop_4 [   9] = 1'b0                       ;
  assign tx_phy_preflop_4 [  10] = 1'b0                       ;
  assign tx_phy_preflop_4 [  11] = 1'b0                       ;
  assign tx_phy_preflop_4 [  12] = 1'b0                       ;
  assign tx_phy_preflop_4 [  13] = 1'b0                       ;
  assign tx_phy_preflop_4 [  14] = 1'b0                       ;
  assign tx_phy_preflop_4 [  15] = 1'b0                       ;
  assign tx_phy_preflop_4 [  16] = 1'b0                       ;
  assign tx_phy_preflop_4 [  17] = 1'b0                       ;
  assign tx_phy_preflop_4 [  18] = 1'b0                       ;
  assign tx_phy_preflop_4 [  19] = 1'b0                       ;
  assign tx_phy_preflop_4 [  20] = 1'b0                       ;
  assign tx_phy_preflop_4 [  21] = 1'b0                       ;
  assign tx_phy_preflop_4 [  22] = 1'b0                       ;
  assign tx_phy_preflop_4 [  23] = 1'b0                       ;
  assign tx_phy_preflop_4 [  24] = 1'b0                       ;
  assign tx_phy_preflop_4 [  25] = 1'b0                       ;
  assign tx_phy_preflop_4 [  26] = 1'b0                       ;
  assign tx_phy_preflop_4 [  27] = 1'b0                       ;
  assign tx_phy_preflop_4 [  28] = 1'b0                       ;
  assign tx_phy_preflop_4 [  29] = 1'b0                       ;
  assign tx_phy_preflop_4 [  30] = 1'b0                       ;
  assign tx_phy_preflop_4 [  31] = 1'b0                       ;
  assign tx_phy_preflop_4 [  32] = 1'b0                       ;
  assign tx_phy_preflop_4 [  33] = 1'b0                       ;
  assign tx_phy_preflop_4 [  34] = 1'b0                       ;
  assign tx_phy_preflop_4 [  35] = 1'b0                       ;
  assign tx_phy_preflop_4 [  36] = 1'b0                       ;
  assign tx_phy_preflop_4 [  37] = 1'b0                       ;
  assign tx_phy_preflop_4 [  38] = 1'b0                       ;
  assign tx_phy_preflop_4 [  39] = tx_mrk_userbit[0]          ; // MARKER
  assign tx_phy_preflop_5 [   0] = 1'b0                       ;
  assign tx_phy_preflop_5 [   1] = tx_stb_userbit             ; // STROBE
  assign tx_phy_preflop_5 [   2] = 1'b0                       ;
  assign tx_phy_preflop_5 [   3] = 1'b0                       ;
  assign tx_phy_preflop_5 [   4] = 1'b0                       ;
  assign tx_phy_preflop_5 [   5] = 1'b0                       ;
  assign tx_phy_preflop_5 [   6] = 1'b0                       ;
  assign tx_phy_preflop_5 [   7] = 1'b0                       ;
  assign tx_phy_preflop_5 [   8] = 1'b0                       ;
  assign tx_phy_preflop_5 [   9] = 1'b0                       ;
  assign tx_phy_preflop_5 [  10] = 1'b0                       ;
  assign tx_phy_preflop_5 [  11] = 1'b0                       ;
  assign tx_phy_preflop_5 [  12] = 1'b0                       ;
  assign tx_phy_preflop_5 [  13] = 1'b0                       ;
  assign tx_phy_preflop_5 [  14] = 1'b0                       ;
  assign tx_phy_preflop_5 [  15] = 1'b0                       ;
  assign tx_phy_preflop_5 [  16] = 1'b0                       ;
  assign tx_phy_preflop_5 [  17] = 1'b0                       ;
  assign tx_phy_preflop_5 [  18] = 1'b0                       ;
  assign tx_phy_preflop_5 [  19] = 1'b0                       ;
  assign tx_phy_preflop_5 [  20] = 1'b0                       ;
  assign tx_phy_preflop_5 [  21] = 1'b0                       ;
  assign tx_phy_preflop_5 [  22] = 1'b0                       ;
  assign tx_phy_preflop_5 [  23] = 1'b0                       ;
  assign tx_phy_preflop_5 [  24] = 1'b0                       ;
  assign tx_phy_preflop_5 [  25] = 1'b0                       ;
  assign tx_phy_preflop_5 [  26] = 1'b0                       ;
  assign tx_phy_preflop_5 [  27] = 1'b0                       ;
  assign tx_phy_preflop_5 [  28] = 1'b0                       ;
  assign tx_phy_preflop_5 [  29] = 1'b0                       ;
  assign tx_phy_preflop_5 [  30] = 1'b0                       ;
  assign tx_phy_preflop_5 [  31] = 1'b0                       ;
  assign tx_phy_preflop_5 [  32] = 1'b0                       ;
  assign tx_phy_preflop_5 [  33] = 1'b0                       ;
  assign tx_phy_preflop_5 [  34] = 1'b0                       ;
  assign tx_phy_preflop_5 [  35] = 1'b0                       ;
  assign tx_phy_preflop_5 [  36] = 1'b0                       ;
  assign tx_phy_preflop_5 [  37] = 1'b0                       ;
  assign tx_phy_preflop_5 [  38] = 1'b0                       ;
  assign tx_phy_preflop_5 [  39] = tx_mrk_userbit[0]          ; // MARKER
  assign tx_phy_preflop_6 [   0] = 1'b0                       ;
  assign tx_phy_preflop_6 [   1] = tx_stb_userbit             ; // STROBE
  assign tx_phy_preflop_6 [   2] = 1'b0                       ;
  assign tx_phy_preflop_6 [   3] = 1'b0                       ;
  assign tx_phy_preflop_6 [   4] = 1'b0                       ;
  assign tx_phy_preflop_6 [   5] = 1'b0                       ;
  assign tx_phy_preflop_6 [   6] = 1'b0                       ;
  assign tx_phy_preflop_6 [   7] = 1'b0                       ;
  assign tx_phy_preflop_6 [   8] = 1'b0                       ;
  assign tx_phy_preflop_6 [   9] = 1'b0                       ;
  assign tx_phy_preflop_6 [  10] = 1'b0                       ;
  assign tx_phy_preflop_6 [  11] = 1'b0                       ;
  assign tx_phy_preflop_6 [  12] = 1'b0                       ;
  assign tx_phy_preflop_6 [  13] = 1'b0                       ;
  assign tx_phy_preflop_6 [  14] = 1'b0                       ;
  assign tx_phy_preflop_6 [  15] = 1'b0                       ;
  assign tx_phy_preflop_6 [  16] = 1'b0                       ;
  assign tx_phy_preflop_6 [  17] = 1'b0                       ;
  assign tx_phy_preflop_6 [  18] = 1'b0                       ;
  assign tx_phy_preflop_6 [  19] = 1'b0                       ;
  assign tx_phy_preflop_6 [  20] = 1'b0                       ;
  assign tx_phy_preflop_6 [  21] = 1'b0                       ;
  assign tx_phy_preflop_6 [  22] = 1'b0                       ;
  assign tx_phy_preflop_6 [  23] = 1'b0                       ;
  assign tx_phy_preflop_6 [  24] = 1'b0                       ;
  assign tx_phy_preflop_6 [  25] = 1'b0                       ;
  assign tx_phy_preflop_6 [  26] = 1'b0                       ;
  assign tx_phy_preflop_6 [  27] = 1'b0                       ;
  assign tx_phy_preflop_6 [  28] = 1'b0                       ;
  assign tx_phy_preflop_6 [  29] = 1'b0                       ;
  assign tx_phy_preflop_6 [  30] = 1'b0                       ;
  assign tx_phy_preflop_6 [  31] = 1'b0                       ;
  assign tx_phy_preflop_6 [  32] = 1'b0                       ;
  assign tx_phy_preflop_6 [  33] = 1'b0                       ;
  assign tx_phy_preflop_6 [  34] = 1'b0                       ;
  assign tx_phy_preflop_6 [  35] = 1'b0                       ;
  assign tx_phy_preflop_6 [  36] = 1'b0                       ;
  assign tx_phy_preflop_6 [  37] = 1'b0                       ;
  assign tx_phy_preflop_6 [  38] = 1'b0                       ;
  assign tx_phy_preflop_6 [  39] = tx_mrk_userbit[0]          ; // MARKER
  assign tx_phy_preflop_0 [  40] = tx_st_credit_r1            ;
  assign tx_phy_preflop_0 [  41] = 1'b0                       ; // STROBE (unused)
  assign tx_phy_preflop_0 [  42] = 1'b0                       ;
  assign tx_phy_preflop_0 [  43] = 1'b0                       ;
  assign tx_phy_preflop_0 [  44] = 1'b0                       ;
  assign tx_phy_preflop_0 [  45] = 1'b0                       ;
  assign tx_phy_preflop_0 [  46] = 1'b0                       ;
  assign tx_phy_preflop_0 [  47] = 1'b0                       ;
  assign tx_phy_preflop_0 [  48] = 1'b0                       ;
  assign tx_phy_preflop_0 [  49] = 1'b0                       ;
  assign tx_phy_preflop_0 [  50] = 1'b0                       ;
  assign tx_phy_preflop_0 [  51] = 1'b0                       ;
  assign tx_phy_preflop_0 [  52] = 1'b0                       ;
  assign tx_phy_preflop_0 [  53] = 1'b0                       ;
  assign tx_phy_preflop_0 [  54] = 1'b0                       ;
  assign tx_phy_preflop_0 [  55] = 1'b0                       ;
  assign tx_phy_preflop_0 [  56] = 1'b0                       ;
  assign tx_phy_preflop_0 [  57] = 1'b0                       ;
  assign tx_phy_preflop_0 [  58] = 1'b0                       ;
  assign tx_phy_preflop_0 [  59] = 1'b0                       ;
  assign tx_phy_preflop_0 [  60] = 1'b0                       ;
  assign tx_phy_preflop_0 [  61] = 1'b0                       ;
  assign tx_phy_preflop_0 [  62] = 1'b0                       ;
  assign tx_phy_preflop_0 [  63] = 1'b0                       ;
  assign tx_phy_preflop_0 [  64] = 1'b0                       ;
  assign tx_phy_preflop_0 [  65] = 1'b0                       ;
  assign tx_phy_preflop_0 [  66] = 1'b0                       ;
  assign tx_phy_preflop_0 [  67] = 1'b0                       ;
  assign tx_phy_preflop_0 [  68] = 1'b0                       ;
  assign tx_phy_preflop_0 [  69] = 1'b0                       ;
  assign tx_phy_preflop_0 [  70] = 1'b0                       ;
  assign tx_phy_preflop_0 [  71] = 1'b0                       ;
  assign tx_phy_preflop_0 [  72] = 1'b0                       ;
  assign tx_phy_preflop_0 [  73] = 1'b0                       ;
  assign tx_phy_preflop_0 [  74] = 1'b0                       ;
  assign tx_phy_preflop_0 [  75] = 1'b0                       ;
  assign tx_phy_preflop_0 [  76] = 1'b0                       ;
  assign tx_phy_preflop_0 [  77] = 1'b0                       ;
  assign tx_phy_preflop_0 [  78] = 1'b0                       ;
  assign tx_phy_preflop_0 [  79] = tx_mrk_userbit[1]          ; // MARKER
  assign tx_phy_preflop_1 [  40] = 1'b0                       ;
  assign tx_phy_preflop_1 [  41] = 1'b0                       ; // STROBE (unused)
  assign tx_phy_preflop_1 [  42] = 1'b0                       ;
  assign tx_phy_preflop_1 [  43] = 1'b0                       ;
  assign tx_phy_preflop_1 [  44] = 1'b0                       ;
  assign tx_phy_preflop_1 [  45] = 1'b0                       ;
  assign tx_phy_preflop_1 [  46] = 1'b0                       ;
  assign tx_phy_preflop_1 [  47] = 1'b0                       ;
  assign tx_phy_preflop_1 [  48] = 1'b0                       ;
  assign tx_phy_preflop_1 [  49] = 1'b0                       ;
  assign tx_phy_preflop_1 [  50] = 1'b0                       ;
  assign tx_phy_preflop_1 [  51] = 1'b0                       ;
  assign tx_phy_preflop_1 [  52] = 1'b0                       ;
  assign tx_phy_preflop_1 [  53] = 1'b0                       ;
  assign tx_phy_preflop_1 [  54] = 1'b0                       ;
  assign tx_phy_preflop_1 [  55] = 1'b0                       ;
  assign tx_phy_preflop_1 [  56] = 1'b0                       ;
  assign tx_phy_preflop_1 [  57] = 1'b0                       ;
  assign tx_phy_preflop_1 [  58] = 1'b0                       ;
  assign tx_phy_preflop_1 [  59] = 1'b0                       ;
  assign tx_phy_preflop_1 [  60] = 1'b0                       ;
  assign tx_phy_preflop_1 [  61] = 1'b0                       ;
  assign tx_phy_preflop_1 [  62] = 1'b0                       ;
  assign tx_phy_preflop_1 [  63] = 1'b0                       ;
  assign tx_phy_preflop_1 [  64] = 1'b0                       ;
  assign tx_phy_preflop_1 [  65] = 1'b0                       ;
  assign tx_phy_preflop_1 [  66] = 1'b0                       ;
  assign tx_phy_preflop_1 [  67] = 1'b0                       ;
  assign tx_phy_preflop_1 [  68] = 1'b0                       ;
  assign tx_phy_preflop_1 [  69] = 1'b0                       ;
  assign tx_phy_preflop_1 [  70] = 1'b0                       ;
  assign tx_phy_preflop_1 [  71] = 1'b0                       ;
  assign tx_phy_preflop_1 [  72] = 1'b0                       ;
  assign tx_phy_preflop_1 [  73] = 1'b0                       ;
  assign tx_phy_preflop_1 [  74] = 1'b0                       ;
  assign tx_phy_preflop_1 [  75] = 1'b0                       ;
  assign tx_phy_preflop_1 [  76] = 1'b0                       ;
  assign tx_phy_preflop_1 [  77] = 1'b0                       ;
  assign tx_phy_preflop_1 [  78] = 1'b0                       ;
  assign tx_phy_preflop_1 [  79] = tx_mrk_userbit[1]          ; // MARKER
  assign tx_phy_preflop_2 [  40] = 1'b0                       ;
  assign tx_phy_preflop_2 [  41] = 1'b0                       ; // STROBE (unused)
  assign tx_phy_preflop_2 [  42] = 1'b0                       ;
  assign tx_phy_preflop_2 [  43] = 1'b0                       ;
  assign tx_phy_preflop_2 [  44] = 1'b0                       ;
  assign tx_phy_preflop_2 [  45] = 1'b0                       ;
  assign tx_phy_preflop_2 [  46] = 1'b0                       ;
  assign tx_phy_preflop_2 [  47] = 1'b0                       ;
  assign tx_phy_preflop_2 [  48] = 1'b0                       ;
  assign tx_phy_preflop_2 [  49] = 1'b0                       ;
  assign tx_phy_preflop_2 [  50] = 1'b0                       ;
  assign tx_phy_preflop_2 [  51] = 1'b0                       ;
  assign tx_phy_preflop_2 [  52] = 1'b0                       ;
  assign tx_phy_preflop_2 [  53] = 1'b0                       ;
  assign tx_phy_preflop_2 [  54] = 1'b0                       ;
  assign tx_phy_preflop_2 [  55] = 1'b0                       ;
  assign tx_phy_preflop_2 [  56] = 1'b0                       ;
  assign tx_phy_preflop_2 [  57] = 1'b0                       ;
  assign tx_phy_preflop_2 [  58] = 1'b0                       ;
  assign tx_phy_preflop_2 [  59] = 1'b0                       ;
  assign tx_phy_preflop_2 [  60] = 1'b0                       ;
  assign tx_phy_preflop_2 [  61] = 1'b0                       ;
  assign tx_phy_preflop_2 [  62] = 1'b0                       ;
  assign tx_phy_preflop_2 [  63] = 1'b0                       ;
  assign tx_phy_preflop_2 [  64] = 1'b0                       ;
  assign tx_phy_preflop_2 [  65] = 1'b0                       ;
  assign tx_phy_preflop_2 [  66] = 1'b0                       ;
  assign tx_phy_preflop_2 [  67] = 1'b0                       ;
  assign tx_phy_preflop_2 [  68] = 1'b0                       ;
  assign tx_phy_preflop_2 [  69] = 1'b0                       ;
  assign tx_phy_preflop_2 [  70] = 1'b0                       ;
  assign tx_phy_preflop_2 [  71] = 1'b0                       ;
  assign tx_phy_preflop_2 [  72] = 1'b0                       ;
  assign tx_phy_preflop_2 [  73] = 1'b0                       ;
  assign tx_phy_preflop_2 [  74] = 1'b0                       ;
  assign tx_phy_preflop_2 [  75] = 1'b0                       ;
  assign tx_phy_preflop_2 [  76] = 1'b0                       ;
  assign tx_phy_preflop_2 [  77] = 1'b0                       ;
  assign tx_phy_preflop_2 [  78] = 1'b0                       ;
  assign tx_phy_preflop_2 [  79] = tx_mrk_userbit[1]          ; // MARKER
  assign tx_phy_preflop_3 [  40] = 1'b0                       ;
  assign tx_phy_preflop_3 [  41] = 1'b0                       ; // STROBE (unused)
  assign tx_phy_preflop_3 [  42] = 1'b0                       ;
  assign tx_phy_preflop_3 [  43] = 1'b0                       ;
  assign tx_phy_preflop_3 [  44] = 1'b0                       ;
  assign tx_phy_preflop_3 [  45] = 1'b0                       ;
  assign tx_phy_preflop_3 [  46] = 1'b0                       ;
  assign tx_phy_preflop_3 [  47] = 1'b0                       ;
  assign tx_phy_preflop_3 [  48] = 1'b0                       ;
  assign tx_phy_preflop_3 [  49] = 1'b0                       ;
  assign tx_phy_preflop_3 [  50] = 1'b0                       ;
  assign tx_phy_preflop_3 [  51] = 1'b0                       ;
  assign tx_phy_preflop_3 [  52] = 1'b0                       ;
  assign tx_phy_preflop_3 [  53] = 1'b0                       ;
  assign tx_phy_preflop_3 [  54] = 1'b0                       ;
  assign tx_phy_preflop_3 [  55] = 1'b0                       ;
  assign tx_phy_preflop_3 [  56] = 1'b0                       ;
  assign tx_phy_preflop_3 [  57] = 1'b0                       ;
  assign tx_phy_preflop_3 [  58] = 1'b0                       ;
  assign tx_phy_preflop_3 [  59] = 1'b0                       ;
  assign tx_phy_preflop_3 [  60] = 1'b0                       ;
  assign tx_phy_preflop_3 [  61] = 1'b0                       ;
  assign tx_phy_preflop_3 [  62] = 1'b0                       ;
  assign tx_phy_preflop_3 [  63] = 1'b0                       ;
  assign tx_phy_preflop_3 [  64] = 1'b0                       ;
  assign tx_phy_preflop_3 [  65] = 1'b0                       ;
  assign tx_phy_preflop_3 [  66] = 1'b0                       ;
  assign tx_phy_preflop_3 [  67] = 1'b0                       ;
  assign tx_phy_preflop_3 [  68] = 1'b0                       ;
  assign tx_phy_preflop_3 [  69] = 1'b0                       ;
  assign tx_phy_preflop_3 [  70] = 1'b0                       ;
  assign tx_phy_preflop_3 [  71] = 1'b0                       ;
  assign tx_phy_preflop_3 [  72] = 1'b0                       ;
  assign tx_phy_preflop_3 [  73] = 1'b0                       ;
  assign tx_phy_preflop_3 [  74] = 1'b0                       ;
  assign tx_phy_preflop_3 [  75] = 1'b0                       ;
  assign tx_phy_preflop_3 [  76] = 1'b0                       ;
  assign tx_phy_preflop_3 [  77] = 1'b0                       ;
  assign tx_phy_preflop_3 [  78] = 1'b0                       ;
  assign tx_phy_preflop_3 [  79] = tx_mrk_userbit[1]          ; // MARKER
  assign tx_phy_preflop_4 [  40] = 1'b0                       ;
  assign tx_phy_preflop_4 [  41] = 1'b0                       ; // STROBE (unused)
  assign tx_phy_preflop_4 [  42] = 1'b0                       ;
  assign tx_phy_preflop_4 [  43] = 1'b0                       ;
  assign tx_phy_preflop_4 [  44] = 1'b0                       ;
  assign tx_phy_preflop_4 [  45] = 1'b0                       ;
  assign tx_phy_preflop_4 [  46] = 1'b0                       ;
  assign tx_phy_preflop_4 [  47] = 1'b0                       ;
  assign tx_phy_preflop_4 [  48] = 1'b0                       ;
  assign tx_phy_preflop_4 [  49] = 1'b0                       ;
  assign tx_phy_preflop_4 [  50] = 1'b0                       ;
  assign tx_phy_preflop_4 [  51] = 1'b0                       ;
  assign tx_phy_preflop_4 [  52] = 1'b0                       ;
  assign tx_phy_preflop_4 [  53] = 1'b0                       ;
  assign tx_phy_preflop_4 [  54] = 1'b0                       ;
  assign tx_phy_preflop_4 [  55] = 1'b0                       ;
  assign tx_phy_preflop_4 [  56] = 1'b0                       ;
  assign tx_phy_preflop_4 [  57] = 1'b0                       ;
  assign tx_phy_preflop_4 [  58] = 1'b0                       ;
  assign tx_phy_preflop_4 [  59] = 1'b0                       ;
  assign tx_phy_preflop_4 [  60] = 1'b0                       ;
  assign tx_phy_preflop_4 [  61] = 1'b0                       ;
  assign tx_phy_preflop_4 [  62] = 1'b0                       ;
  assign tx_phy_preflop_4 [  63] = 1'b0                       ;
  assign tx_phy_preflop_4 [  64] = 1'b0                       ;
  assign tx_phy_preflop_4 [  65] = 1'b0                       ;
  assign tx_phy_preflop_4 [  66] = 1'b0                       ;
  assign tx_phy_preflop_4 [  67] = 1'b0                       ;
  assign tx_phy_preflop_4 [  68] = 1'b0                       ;
  assign tx_phy_preflop_4 [  69] = 1'b0                       ;
  assign tx_phy_preflop_4 [  70] = 1'b0                       ;
  assign tx_phy_preflop_4 [  71] = 1'b0                       ;
  assign tx_phy_preflop_4 [  72] = 1'b0                       ;
  assign tx_phy_preflop_4 [  73] = 1'b0                       ;
  assign tx_phy_preflop_4 [  74] = 1'b0                       ;
  assign tx_phy_preflop_4 [  75] = 1'b0                       ;
  assign tx_phy_preflop_4 [  76] = 1'b0                       ;
  assign tx_phy_preflop_4 [  77] = 1'b0                       ;
  assign tx_phy_preflop_4 [  78] = 1'b0                       ;
  assign tx_phy_preflop_4 [  79] = tx_mrk_userbit[1]          ; // MARKER
  assign tx_phy_preflop_5 [  40] = 1'b0                       ;
  assign tx_phy_preflop_5 [  41] = 1'b0                       ; // STROBE (unused)
  assign tx_phy_preflop_5 [  42] = 1'b0                       ;
  assign tx_phy_preflop_5 [  43] = 1'b0                       ;
  assign tx_phy_preflop_5 [  44] = 1'b0                       ;
  assign tx_phy_preflop_5 [  45] = 1'b0                       ;
  assign tx_phy_preflop_5 [  46] = 1'b0                       ;
  assign tx_phy_preflop_5 [  47] = 1'b0                       ;
  assign tx_phy_preflop_5 [  48] = 1'b0                       ;
  assign tx_phy_preflop_5 [  49] = 1'b0                       ;
  assign tx_phy_preflop_5 [  50] = 1'b0                       ;
  assign tx_phy_preflop_5 [  51] = 1'b0                       ;
  assign tx_phy_preflop_5 [  52] = 1'b0                       ;
  assign tx_phy_preflop_5 [  53] = 1'b0                       ;
  assign tx_phy_preflop_5 [  54] = 1'b0                       ;
  assign tx_phy_preflop_5 [  55] = 1'b0                       ;
  assign tx_phy_preflop_5 [  56] = 1'b0                       ;
  assign tx_phy_preflop_5 [  57] = 1'b0                       ;
  assign tx_phy_preflop_5 [  58] = 1'b0                       ;
  assign tx_phy_preflop_5 [  59] = 1'b0                       ;
  assign tx_phy_preflop_5 [  60] = 1'b0                       ;
  assign tx_phy_preflop_5 [  61] = 1'b0                       ;
  assign tx_phy_preflop_5 [  62] = 1'b0                       ;
  assign tx_phy_preflop_5 [  63] = 1'b0                       ;
  assign tx_phy_preflop_5 [  64] = 1'b0                       ;
  assign tx_phy_preflop_5 [  65] = 1'b0                       ;
  assign tx_phy_preflop_5 [  66] = 1'b0                       ;
  assign tx_phy_preflop_5 [  67] = 1'b0                       ;
  assign tx_phy_preflop_5 [  68] = 1'b0                       ;
  assign tx_phy_preflop_5 [  69] = 1'b0                       ;
  assign tx_phy_preflop_5 [  70] = 1'b0                       ;
  assign tx_phy_preflop_5 [  71] = 1'b0                       ;
  assign tx_phy_preflop_5 [  72] = 1'b0                       ;
  assign tx_phy_preflop_5 [  73] = 1'b0                       ;
  assign tx_phy_preflop_5 [  74] = 1'b0                       ;
  assign tx_phy_preflop_5 [  75] = 1'b0                       ;
  assign tx_phy_preflop_5 [  76] = 1'b0                       ;
  assign tx_phy_preflop_5 [  77] = 1'b0                       ;
  assign tx_phy_preflop_5 [  78] = 1'b0                       ;
  assign tx_phy_preflop_5 [  79] = tx_mrk_userbit[1]          ; // MARKER
  assign tx_phy_preflop_6 [  40] = 1'b0                       ;
  assign tx_phy_preflop_6 [  41] = 1'b0                       ; // STROBE (unused)
  assign tx_phy_preflop_6 [  42] = 1'b0                       ;
  assign tx_phy_preflop_6 [  43] = 1'b0                       ;
  assign tx_phy_preflop_6 [  44] = 1'b0                       ;
  assign tx_phy_preflop_6 [  45] = 1'b0                       ;
  assign tx_phy_preflop_6 [  46] = 1'b0                       ;
  assign tx_phy_preflop_6 [  47] = 1'b0                       ;
  assign tx_phy_preflop_6 [  48] = 1'b0                       ;
  assign tx_phy_preflop_6 [  49] = 1'b0                       ;
  assign tx_phy_preflop_6 [  50] = 1'b0                       ;
  assign tx_phy_preflop_6 [  51] = 1'b0                       ;
  assign tx_phy_preflop_6 [  52] = 1'b0                       ;
  assign tx_phy_preflop_6 [  53] = 1'b0                       ;
  assign tx_phy_preflop_6 [  54] = 1'b0                       ;
  assign tx_phy_preflop_6 [  55] = 1'b0                       ;
  assign tx_phy_preflop_6 [  56] = 1'b0                       ;
  assign tx_phy_preflop_6 [  57] = 1'b0                       ;
  assign tx_phy_preflop_6 [  58] = 1'b0                       ;
  assign tx_phy_preflop_6 [  59] = 1'b0                       ;
  assign tx_phy_preflop_6 [  60] = 1'b0                       ;
  assign tx_phy_preflop_6 [  61] = 1'b0                       ;
  assign tx_phy_preflop_6 [  62] = 1'b0                       ;
  assign tx_phy_preflop_6 [  63] = 1'b0                       ;
  assign tx_phy_preflop_6 [  64] = 1'b0                       ;
  assign tx_phy_preflop_6 [  65] = 1'b0                       ;
  assign tx_phy_preflop_6 [  66] = 1'b0                       ;
  assign tx_phy_preflop_6 [  67] = 1'b0                       ;
  assign tx_phy_preflop_6 [  68] = 1'b0                       ;
  assign tx_phy_preflop_6 [  69] = 1'b0                       ;
  assign tx_phy_preflop_6 [  70] = 1'b0                       ;
  assign tx_phy_preflop_6 [  71] = 1'b0                       ;
  assign tx_phy_preflop_6 [  72] = 1'b0                       ;
  assign tx_phy_preflop_6 [  73] = 1'b0                       ;
  assign tx_phy_preflop_6 [  74] = 1'b0                       ;
  assign tx_phy_preflop_6 [  75] = 1'b0                       ;
  assign tx_phy_preflop_6 [  76] = 1'b0                       ;
  assign tx_phy_preflop_6 [  77] = 1'b0                       ;
  assign tx_phy_preflop_6 [  78] = 1'b0                       ;
  assign tx_phy_preflop_6 [  79] = tx_mrk_userbit[1]          ; // MARKER
// TX Section
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
// RX Section

//   RX_CH_WIDTH           = 80; // Gen1Only running at Half Rate
//   RX_DATA_WIDTH         = 76; // Usable Data per Channel
//   RX_PERSISTENT_STROBE  = 1'b1;
//   RX_PERSISTENT_MARKER  = 1'b1;
//   RX_STROBE_GEN2_LOC    = 'd1;
//   RX_MARKER_GEN2_LOC    = 'd39;
//   RX_STROBE_GEN1_LOC    = 'd1;
//   RX_MARKER_GEN1_LOC    = 'd39;
//   RX_ENABLE_STROBE      = 1'b1;
//   RX_ENABLE_MARKER      = 1'b1;
//   RX_DBI_PRESENT        = 1'b0;
//   RX_REG_PHY            = 1'b0;

  localparam RX_REG_PHY    = 1'b0;  // If set, this enables boundary FF for timing reasons

  logic [  79:   0]                              rx_phy_postflop_0             ;
  logic [  79:   0]                              rx_phy_postflop_1             ;
  logic [  79:   0]                              rx_phy_postflop_2             ;
  logic [  79:   0]                              rx_phy_postflop_3             ;
  logic [  79:   0]                              rx_phy_postflop_4             ;
  logic [  79:   0]                              rx_phy_postflop_5             ;
  logic [  79:   0]                              rx_phy_postflop_6             ;
  logic [  79:   0]                              rx_phy_flop_0_reg             ;
  logic [  79:   0]                              rx_phy_flop_1_reg             ;
  logic [  79:   0]                              rx_phy_flop_2_reg             ;
  logic [  79:   0]                              rx_phy_flop_3_reg             ;
  logic [  79:   0]                              rx_phy_flop_4_reg             ;
  logic [  79:   0]                              rx_phy_flop_5_reg             ;
  logic [  79:   0]                              rx_phy_flop_6_reg             ;

  always_ff @(posedge clk_rd or negedge rst_rd_n)
  if (~rst_rd_n)
  begin
    rx_phy_flop_0_reg                       <= 80'b0                                   ;
    rx_phy_flop_1_reg                       <= 80'b0                                   ;
    rx_phy_flop_2_reg                       <= 80'b0                                   ;
    rx_phy_flop_3_reg                       <= 80'b0                                   ;
    rx_phy_flop_4_reg                       <= 80'b0                                   ;
    rx_phy_flop_5_reg                       <= 80'b0                                   ;
    rx_phy_flop_6_reg                       <= 80'b0                                   ;
  end
  else
  begin
    rx_phy_flop_0_reg                       <= rx_phy0                                 ;
    rx_phy_flop_1_reg                       <= rx_phy1                                 ;
    rx_phy_flop_2_reg                       <= rx_phy2                                 ;
    rx_phy_flop_3_reg                       <= rx_phy3                                 ;
    rx_phy_flop_4_reg                       <= rx_phy4                                 ;
    rx_phy_flop_5_reg                       <= rx_phy5                                 ;
    rx_phy_flop_6_reg                       <= rx_phy6                                 ;
  end


  assign rx_phy_postflop_0                  = RX_REG_PHY ? rx_phy_flop_0_reg : rx_phy0               ;
  assign rx_phy_postflop_1                  = RX_REG_PHY ? rx_phy_flop_1_reg : rx_phy1               ;
  assign rx_phy_postflop_2                  = RX_REG_PHY ? rx_phy_flop_2_reg : rx_phy2               ;
  assign rx_phy_postflop_3                  = RX_REG_PHY ? rx_phy_flop_3_reg : rx_phy3               ;
  assign rx_phy_postflop_4                  = RX_REG_PHY ? rx_phy_flop_4_reg : rx_phy4               ;
  assign rx_phy_postflop_5                  = RX_REG_PHY ? rx_phy_flop_5_reg : rx_phy5               ;
  assign rx_phy_postflop_6                  = RX_REG_PHY ? rx_phy_flop_6_reg : rx_phy6               ;

  logic                                          rx_st_pushbit_r0              ;
  logic                                          rx_st_pushbit_r1              ;

  assign rx_st_pushbit        = rx_st_pushbit_r0    |
                                rx_st_pushbit_r1    ;

  assign rx_st_pushbit_r0           = rx_phy_postflop_0 [   0];
//       STROBE                     = rx_phy_postflop_0 [   1]
  assign rx_st_data          [   0] = rx_phy_postflop_0 [   2];
  assign rx_st_data          [   1] = rx_phy_postflop_0 [   3];
  assign rx_st_data          [   2] = rx_phy_postflop_0 [   4];
  assign rx_st_data          [   3] = rx_phy_postflop_0 [   5];
  assign rx_st_data          [   4] = rx_phy_postflop_0 [   6];
  assign rx_st_data          [   5] = rx_phy_postflop_0 [   7];
  assign rx_st_data          [   6] = rx_phy_postflop_0 [   8];
  assign rx_st_data          [   7] = rx_phy_postflop_0 [   9];
  assign rx_st_data          [   8] = rx_phy_postflop_0 [  10];
  assign rx_st_data          [   9] = rx_phy_postflop_0 [  11];
  assign rx_st_data          [  10] = rx_phy_postflop_0 [  12];
  assign rx_st_data          [  11] = rx_phy_postflop_0 [  13];
  assign rx_st_data          [  12] = rx_phy_postflop_0 [  14];
  assign rx_st_data          [  13] = rx_phy_postflop_0 [  15];
  assign rx_st_data          [  14] = rx_phy_postflop_0 [  16];
  assign rx_st_data          [  15] = rx_phy_postflop_0 [  17];
  assign rx_st_data          [  16] = rx_phy_postflop_0 [  18];
  assign rx_st_data          [  17] = rx_phy_postflop_0 [  19];
  assign rx_st_data          [  18] = rx_phy_postflop_0 [  20];
  assign rx_st_data          [  19] = rx_phy_postflop_0 [  21];
  assign rx_st_data          [  20] = rx_phy_postflop_0 [  22];
  assign rx_st_data          [  21] = rx_phy_postflop_0 [  23];
  assign rx_st_data          [  22] = rx_phy_postflop_0 [  24];
  assign rx_st_data          [  23] = rx_phy_postflop_0 [  25];
  assign rx_st_data          [  24] = rx_phy_postflop_0 [  26];
  assign rx_st_data          [  25] = rx_phy_postflop_0 [  27];
  assign rx_st_data          [  26] = rx_phy_postflop_0 [  28];
  assign rx_st_data          [  27] = rx_phy_postflop_0 [  29];
  assign rx_st_data          [  28] = rx_phy_postflop_0 [  30];
  assign rx_st_data          [  29] = rx_phy_postflop_0 [  31];
  assign rx_st_data          [  30] = rx_phy_postflop_0 [  32];
  assign rx_st_data          [  31] = rx_phy_postflop_0 [  33];
  assign rx_st_data          [  32] = rx_phy_postflop_0 [  34];
  assign rx_st_data          [  33] = rx_phy_postflop_0 [  35];
  assign rx_st_data          [  34] = rx_phy_postflop_0 [  36];
  assign rx_st_data          [  35] = rx_phy_postflop_0 [  37];
  assign rx_st_data          [  36] = rx_phy_postflop_0 [  38];
//       MARKER                     = rx_phy_postflop_0 [  39]
  assign rx_st_data          [  37] = rx_phy_postflop_1 [   0];
//       STROBE                     = rx_phy_postflop_1 [   1]
  assign rx_st_data          [  38] = rx_phy_postflop_1 [   2];
  assign rx_st_data          [  39] = rx_phy_postflop_1 [   3];
  assign rx_st_data          [  40] = rx_phy_postflop_1 [   4];
  assign rx_st_data          [  41] = rx_phy_postflop_1 [   5];
  assign rx_st_data          [  42] = rx_phy_postflop_1 [   6];
  assign rx_st_data          [  43] = rx_phy_postflop_1 [   7];
  assign rx_st_data          [  44] = rx_phy_postflop_1 [   8];
  assign rx_st_data          [  45] = rx_phy_postflop_1 [   9];
  assign rx_st_data          [  46] = rx_phy_postflop_1 [  10];
  assign rx_st_data          [  47] = rx_phy_postflop_1 [  11];
  assign rx_st_data          [  48] = rx_phy_postflop_1 [  12];
  assign rx_st_data          [  49] = rx_phy_postflop_1 [  13];
  assign rx_st_data          [  50] = rx_phy_postflop_1 [  14];
  assign rx_st_data          [  51] = rx_phy_postflop_1 [  15];
  assign rx_st_data          [  52] = rx_phy_postflop_1 [  16];
  assign rx_st_data          [  53] = rx_phy_postflop_1 [  17];
  assign rx_st_data          [  54] = rx_phy_postflop_1 [  18];
  assign rx_st_data          [  55] = rx_phy_postflop_1 [  19];
  assign rx_st_data          [  56] = rx_phy_postflop_1 [  20];
  assign rx_st_data          [  57] = rx_phy_postflop_1 [  21];
  assign rx_st_data          [  58] = rx_phy_postflop_1 [  22];
  assign rx_st_data          [  59] = rx_phy_postflop_1 [  23];
  assign rx_st_data          [  60] = rx_phy_postflop_1 [  24];
  assign rx_st_data          [  61] = rx_phy_postflop_1 [  25];
  assign rx_st_data          [  62] = rx_phy_postflop_1 [  26];
  assign rx_st_data          [  63] = rx_phy_postflop_1 [  27];
  assign rx_st_data          [  64] = rx_phy_postflop_1 [  28];
  assign rx_st_data          [  65] = rx_phy_postflop_1 [  29];
  assign rx_st_data          [  66] = rx_phy_postflop_1 [  30];
  assign rx_st_data          [  67] = rx_phy_postflop_1 [  31];
  assign rx_st_data          [  68] = rx_phy_postflop_1 [  32];
  assign rx_st_data          [  69] = rx_phy_postflop_1 [  33];
  assign rx_st_data          [  70] = rx_phy_postflop_1 [  34];
  assign rx_st_data          [  71] = rx_phy_postflop_1 [  35];
  assign rx_st_data          [  72] = rx_phy_postflop_1 [  36];
  assign rx_st_data          [  73] = rx_phy_postflop_1 [  37];
  assign rx_st_data          [  74] = rx_phy_postflop_1 [  38];
//       MARKER                     = rx_phy_postflop_1 [  39]
  assign rx_st_data          [  75] = rx_phy_postflop_2 [   0];
//       STROBE                     = rx_phy_postflop_2 [   1]
  assign rx_st_data          [  76] = rx_phy_postflop_2 [   2];
  assign rx_st_data          [  77] = rx_phy_postflop_2 [   3];
  assign rx_st_data          [  78] = rx_phy_postflop_2 [   4];
  assign rx_st_data          [  79] = rx_phy_postflop_2 [   5];
  assign rx_st_data          [  80] = rx_phy_postflop_2 [   6];
  assign rx_st_data          [  81] = rx_phy_postflop_2 [   7];
  assign rx_st_data          [  82] = rx_phy_postflop_2 [   8];
  assign rx_st_data          [  83] = rx_phy_postflop_2 [   9];
  assign rx_st_data          [  84] = rx_phy_postflop_2 [  10];
  assign rx_st_data          [  85] = rx_phy_postflop_2 [  11];
  assign rx_st_data          [  86] = rx_phy_postflop_2 [  12];
  assign rx_st_data          [  87] = rx_phy_postflop_2 [  13];
  assign rx_st_data          [  88] = rx_phy_postflop_2 [  14];
  assign rx_st_data          [  89] = rx_phy_postflop_2 [  15];
  assign rx_st_data          [  90] = rx_phy_postflop_2 [  16];
  assign rx_st_data          [  91] = rx_phy_postflop_2 [  17];
  assign rx_st_data          [  92] = rx_phy_postflop_2 [  18];
  assign rx_st_data          [  93] = rx_phy_postflop_2 [  19];
  assign rx_st_data          [  94] = rx_phy_postflop_2 [  20];
  assign rx_st_data          [  95] = rx_phy_postflop_2 [  21];
  assign rx_st_data          [  96] = rx_phy_postflop_2 [  22];
  assign rx_st_data          [  97] = rx_phy_postflop_2 [  23];
  assign rx_st_data          [  98] = rx_phy_postflop_2 [  24];
  assign rx_st_data          [  99] = rx_phy_postflop_2 [  25];
  assign rx_st_data          [ 100] = rx_phy_postflop_2 [  26];
  assign rx_st_data          [ 101] = rx_phy_postflop_2 [  27];
  assign rx_st_data          [ 102] = rx_phy_postflop_2 [  28];
  assign rx_st_data          [ 103] = rx_phy_postflop_2 [  29];
  assign rx_st_data          [ 104] = rx_phy_postflop_2 [  30];
  assign rx_st_data          [ 105] = rx_phy_postflop_2 [  31];
  assign rx_st_data          [ 106] = rx_phy_postflop_2 [  32];
  assign rx_st_data          [ 107] = rx_phy_postflop_2 [  33];
  assign rx_st_data          [ 108] = rx_phy_postflop_2 [  34];
  assign rx_st_data          [ 109] = rx_phy_postflop_2 [  35];
  assign rx_st_data          [ 110] = rx_phy_postflop_2 [  36];
  assign rx_st_data          [ 111] = rx_phy_postflop_2 [  37];
  assign rx_st_data          [ 112] = rx_phy_postflop_2 [  38];
//       MARKER                     = rx_phy_postflop_2 [  39]
  assign rx_st_data          [ 113] = rx_phy_postflop_3 [   0];
//       STROBE                     = rx_phy_postflop_3 [   1]
  assign rx_st_data          [ 114] = rx_phy_postflop_3 [   2];
  assign rx_st_data          [ 115] = rx_phy_postflop_3 [   3];
  assign rx_st_data          [ 116] = rx_phy_postflop_3 [   4];
  assign rx_st_data          [ 117] = rx_phy_postflop_3 [   5];
  assign rx_st_data          [ 118] = rx_phy_postflop_3 [   6];
  assign rx_st_data          [ 119] = rx_phy_postflop_3 [   7];
  assign rx_st_data          [ 120] = rx_phy_postflop_3 [   8];
  assign rx_st_data          [ 121] = rx_phy_postflop_3 [   9];
  assign rx_st_data          [ 122] = rx_phy_postflop_3 [  10];
  assign rx_st_data          [ 123] = rx_phy_postflop_3 [  11];
  assign rx_st_data          [ 124] = rx_phy_postflop_3 [  12];
  assign rx_st_data          [ 125] = rx_phy_postflop_3 [  13];
  assign rx_st_data          [ 126] = rx_phy_postflop_3 [  14];
  assign rx_st_data          [ 127] = rx_phy_postflop_3 [  15];
  assign rx_st_data          [ 128] = rx_phy_postflop_3 [  16];
  assign rx_st_data          [ 129] = rx_phy_postflop_3 [  17];
  assign rx_st_data          [ 130] = rx_phy_postflop_3 [  18];
  assign rx_st_data          [ 131] = rx_phy_postflop_3 [  19];
  assign rx_st_data          [ 132] = rx_phy_postflop_3 [  20];
  assign rx_st_data          [ 133] = rx_phy_postflop_3 [  21];
  assign rx_st_data          [ 134] = rx_phy_postflop_3 [  22];
  assign rx_st_data          [ 135] = rx_phy_postflop_3 [  23];
  assign rx_st_data          [ 136] = rx_phy_postflop_3 [  24];
  assign rx_st_data          [ 137] = rx_phy_postflop_3 [  25];
  assign rx_st_data          [ 138] = rx_phy_postflop_3 [  26];
  assign rx_st_data          [ 139] = rx_phy_postflop_3 [  27];
  assign rx_st_data          [ 140] = rx_phy_postflop_3 [  28];
  assign rx_st_data          [ 141] = rx_phy_postflop_3 [  29];
  assign rx_st_data          [ 142] = rx_phy_postflop_3 [  30];
  assign rx_st_data          [ 143] = rx_phy_postflop_3 [  31];
  assign rx_st_data          [ 144] = rx_phy_postflop_3 [  32];
  assign rx_st_data          [ 145] = rx_phy_postflop_3 [  33];
  assign rx_st_data          [ 146] = rx_phy_postflop_3 [  34];
  assign rx_st_data          [ 147] = rx_phy_postflop_3 [  35];
  assign rx_st_data          [ 148] = rx_phy_postflop_3 [  36];
  assign rx_st_data          [ 149] = rx_phy_postflop_3 [  37];
  assign rx_st_data          [ 150] = rx_phy_postflop_3 [  38];
//       MARKER                     = rx_phy_postflop_3 [  39]
  assign rx_st_data          [ 151] = rx_phy_postflop_4 [   0];
//       STROBE                     = rx_phy_postflop_4 [   1]
  assign rx_st_data          [ 152] = rx_phy_postflop_4 [   2];
  assign rx_st_data          [ 153] = rx_phy_postflop_4 [   3];
  assign rx_st_data          [ 154] = rx_phy_postflop_4 [   4];
  assign rx_st_data          [ 155] = rx_phy_postflop_4 [   5];
  assign rx_st_data          [ 156] = rx_phy_postflop_4 [   6];
  assign rx_st_data          [ 157] = rx_phy_postflop_4 [   7];
  assign rx_st_data          [ 158] = rx_phy_postflop_4 [   8];
  assign rx_st_data          [ 159] = rx_phy_postflop_4 [   9];
  assign rx_st_data          [ 160] = rx_phy_postflop_4 [  10];
  assign rx_st_data          [ 161] = rx_phy_postflop_4 [  11];
  assign rx_st_data          [ 162] = rx_phy_postflop_4 [  12];
  assign rx_st_data          [ 163] = rx_phy_postflop_4 [  13];
  assign rx_st_data          [ 164] = rx_phy_postflop_4 [  14];
  assign rx_st_data          [ 165] = rx_phy_postflop_4 [  15];
  assign rx_st_data          [ 166] = rx_phy_postflop_4 [  16];
  assign rx_st_data          [ 167] = rx_phy_postflop_4 [  17];
  assign rx_st_data          [ 168] = rx_phy_postflop_4 [  18];
  assign rx_st_data          [ 169] = rx_phy_postflop_4 [  19];
  assign rx_st_data          [ 170] = rx_phy_postflop_4 [  20];
  assign rx_st_data          [ 171] = rx_phy_postflop_4 [  21];
  assign rx_st_data          [ 172] = rx_phy_postflop_4 [  22];
  assign rx_st_data          [ 173] = rx_phy_postflop_4 [  23];
  assign rx_st_data          [ 174] = rx_phy_postflop_4 [  24];
  assign rx_st_data          [ 175] = rx_phy_postflop_4 [  25];
  assign rx_st_data          [ 176] = rx_phy_postflop_4 [  26];
  assign rx_st_data          [ 177] = rx_phy_postflop_4 [  27];
  assign rx_st_data          [ 178] = rx_phy_postflop_4 [  28];
  assign rx_st_data          [ 179] = rx_phy_postflop_4 [  29];
  assign rx_st_data          [ 180] = rx_phy_postflop_4 [  30];
  assign rx_st_data          [ 181] = rx_phy_postflop_4 [  31];
  assign rx_st_data          [ 182] = rx_phy_postflop_4 [  32];
  assign rx_st_data          [ 183] = rx_phy_postflop_4 [  33];
  assign rx_st_data          [ 184] = rx_phy_postflop_4 [  34];
  assign rx_st_data          [ 185] = rx_phy_postflop_4 [  35];
  assign rx_st_data          [ 186] = rx_phy_postflop_4 [  36];
  assign rx_st_data          [ 187] = rx_phy_postflop_4 [  37];
  assign rx_st_data          [ 188] = rx_phy_postflop_4 [  38];
//       MARKER                     = rx_phy_postflop_4 [  39]
  assign rx_st_data          [ 189] = rx_phy_postflop_5 [   0];
//       STROBE                     = rx_phy_postflop_5 [   1]
  assign rx_st_data          [ 190] = rx_phy_postflop_5 [   2];
  assign rx_st_data          [ 191] = rx_phy_postflop_5 [   3];
  assign rx_st_data          [ 192] = rx_phy_postflop_5 [   4];
  assign rx_st_data          [ 193] = rx_phy_postflop_5 [   5];
  assign rx_st_data          [ 194] = rx_phy_postflop_5 [   6];
  assign rx_st_data          [ 195] = rx_phy_postflop_5 [   7];
  assign rx_st_data          [ 196] = rx_phy_postflop_5 [   8];
  assign rx_st_data          [ 197] = rx_phy_postflop_5 [   9];
  assign rx_st_data          [ 198] = rx_phy_postflop_5 [  10];
  assign rx_st_data          [ 199] = rx_phy_postflop_5 [  11];
  assign rx_st_data          [ 200] = rx_phy_postflop_5 [  12];
  assign rx_st_data          [ 201] = rx_phy_postflop_5 [  13];
  assign rx_st_data          [ 202] = rx_phy_postflop_5 [  14];
  assign rx_st_data          [ 203] = rx_phy_postflop_5 [  15];
  assign rx_st_data          [ 204] = rx_phy_postflop_5 [  16];
  assign rx_st_data          [ 205] = rx_phy_postflop_5 [  17];
  assign rx_st_data          [ 206] = rx_phy_postflop_5 [  18];
  assign rx_st_data          [ 207] = rx_phy_postflop_5 [  19];
  assign rx_st_data          [ 208] = rx_phy_postflop_5 [  20];
  assign rx_st_data          [ 209] = rx_phy_postflop_5 [  21];
  assign rx_st_data          [ 210] = rx_phy_postflop_5 [  22];
  assign rx_st_data          [ 211] = rx_phy_postflop_5 [  23];
  assign rx_st_data          [ 212] = rx_phy_postflop_5 [  24];
  assign rx_st_data          [ 213] = rx_phy_postflop_5 [  25];
  assign rx_st_data          [ 214] = rx_phy_postflop_5 [  26];
  assign rx_st_data          [ 215] = rx_phy_postflop_5 [  27];
  assign rx_st_data          [ 216] = rx_phy_postflop_5 [  28];
  assign rx_st_data          [ 217] = rx_phy_postflop_5 [  29];
  assign rx_st_data          [ 218] = rx_phy_postflop_5 [  30];
  assign rx_st_data          [ 219] = rx_phy_postflop_5 [  31];
  assign rx_st_data          [ 220] = rx_phy_postflop_5 [  32];
  assign rx_st_data          [ 221] = rx_phy_postflop_5 [  33];
  assign rx_st_data          [ 222] = rx_phy_postflop_5 [  34];
  assign rx_st_data          [ 223] = rx_phy_postflop_5 [  35];
  assign rx_st_data          [ 224] = rx_phy_postflop_5 [  36];
  assign rx_st_data          [ 225] = rx_phy_postflop_5 [  37];
  assign rx_st_data          [ 226] = rx_phy_postflop_5 [  38];
//       MARKER                     = rx_phy_postflop_5 [  39]
  assign rx_st_data          [ 227] = rx_phy_postflop_6 [   0];
//       STROBE                     = rx_phy_postflop_6 [   1]
  assign rx_st_data          [ 228] = rx_phy_postflop_6 [   2];
  assign rx_st_data          [ 229] = rx_phy_postflop_6 [   3];
  assign rx_st_data          [ 230] = rx_phy_postflop_6 [   4];
  assign rx_st_data          [ 231] = rx_phy_postflop_6 [   5];
  assign rx_st_data          [ 232] = rx_phy_postflop_6 [   6];
  assign rx_st_data          [ 233] = rx_phy_postflop_6 [   7];
  assign rx_st_data          [ 234] = rx_phy_postflop_6 [   8];
  assign rx_st_data          [ 235] = rx_phy_postflop_6 [   9];
  assign rx_st_data          [ 236] = rx_phy_postflop_6 [  10];
  assign rx_st_data          [ 237] = rx_phy_postflop_6 [  11];
  assign rx_st_data          [ 238] = rx_phy_postflop_6 [  12];
  assign rx_st_data          [ 239] = rx_phy_postflop_6 [  13];
  assign rx_st_data          [ 240] = rx_phy_postflop_6 [  14];
  assign rx_st_data          [ 241] = rx_phy_postflop_6 [  15];
  assign rx_st_data          [ 242] = rx_phy_postflop_6 [  16];
  assign rx_st_data          [ 243] = rx_phy_postflop_6 [  17];
  assign rx_st_data          [ 244] = rx_phy_postflop_6 [  18];
  assign rx_st_data          [ 245] = rx_phy_postflop_6 [  19];
  assign rx_st_data          [ 246] = rx_phy_postflop_6 [  20];
  assign rx_st_data          [ 247] = rx_phy_postflop_6 [  21];
  assign rx_st_data          [ 248] = rx_phy_postflop_6 [  22];
  assign rx_st_data          [ 249] = rx_phy_postflop_6 [  23];
  assign rx_st_data          [ 250] = rx_phy_postflop_6 [  24];
  assign rx_st_data          [ 251] = rx_phy_postflop_6 [  25];
  assign rx_st_data          [ 252] = rx_phy_postflop_6 [  26];
  assign rx_st_data          [ 253] = rx_phy_postflop_6 [  27];
  assign rx_st_data          [ 254] = rx_phy_postflop_6 [  28];
  assign rx_st_data          [ 255] = rx_phy_postflop_6 [  29];
//       nc                         = rx_phy_postflop_6 [  30];
//       nc                         = rx_phy_postflop_6 [  31];
//       nc                         = rx_phy_postflop_6 [  32];
//       nc                         = rx_phy_postflop_6 [  33];
//       nc                         = rx_phy_postflop_6 [  34];
//       nc                         = rx_phy_postflop_6 [  35];
//       nc                         = rx_phy_postflop_6 [  36];
//       nc                         = rx_phy_postflop_6 [  37];
//       nc                         = rx_phy_postflop_6 [  38];
//       MARKER                     = rx_phy_postflop_6 [  39]
  assign rx_st_pushbit_r1           = rx_phy_postflop_0 [  40];
//       STROBE                     = rx_phy_postflop_0 [  41]
  assign rx_st_data          [ 256] = rx_phy_postflop_0 [  42];
  assign rx_st_data          [ 257] = rx_phy_postflop_0 [  43];
  assign rx_st_data          [ 258] = rx_phy_postflop_0 [  44];
  assign rx_st_data          [ 259] = rx_phy_postflop_0 [  45];
  assign rx_st_data          [ 260] = rx_phy_postflop_0 [  46];
  assign rx_st_data          [ 261] = rx_phy_postflop_0 [  47];
  assign rx_st_data          [ 262] = rx_phy_postflop_0 [  48];
  assign rx_st_data          [ 263] = rx_phy_postflop_0 [  49];
  assign rx_st_data          [ 264] = rx_phy_postflop_0 [  50];
  assign rx_st_data          [ 265] = rx_phy_postflop_0 [  51];
  assign rx_st_data          [ 266] = rx_phy_postflop_0 [  52];
  assign rx_st_data          [ 267] = rx_phy_postflop_0 [  53];
  assign rx_st_data          [ 268] = rx_phy_postflop_0 [  54];
  assign rx_st_data          [ 269] = rx_phy_postflop_0 [  55];
  assign rx_st_data          [ 270] = rx_phy_postflop_0 [  56];
  assign rx_st_data          [ 271] = rx_phy_postflop_0 [  57];
  assign rx_st_data          [ 272] = rx_phy_postflop_0 [  58];
  assign rx_st_data          [ 273] = rx_phy_postflop_0 [  59];
  assign rx_st_data          [ 274] = rx_phy_postflop_0 [  60];
  assign rx_st_data          [ 275] = rx_phy_postflop_0 [  61];
  assign rx_st_data          [ 276] = rx_phy_postflop_0 [  62];
  assign rx_st_data          [ 277] = rx_phy_postflop_0 [  63];
  assign rx_st_data          [ 278] = rx_phy_postflop_0 [  64];
  assign rx_st_data          [ 279] = rx_phy_postflop_0 [  65];
  assign rx_st_data          [ 280] = rx_phy_postflop_0 [  66];
  assign rx_st_data          [ 281] = rx_phy_postflop_0 [  67];
  assign rx_st_data          [ 282] = rx_phy_postflop_0 [  68];
  assign rx_st_data          [ 283] = rx_phy_postflop_0 [  69];
  assign rx_st_data          [ 284] = rx_phy_postflop_0 [  70];
  assign rx_st_data          [ 285] = rx_phy_postflop_0 [  71];
  assign rx_st_data          [ 286] = rx_phy_postflop_0 [  72];
  assign rx_st_data          [ 287] = rx_phy_postflop_0 [  73];
  assign rx_st_data          [ 288] = rx_phy_postflop_0 [  74];
  assign rx_st_data          [ 289] = rx_phy_postflop_0 [  75];
  assign rx_st_data          [ 290] = rx_phy_postflop_0 [  76];
  assign rx_st_data          [ 291] = rx_phy_postflop_0 [  77];
  assign rx_st_data          [ 292] = rx_phy_postflop_0 [  78];
//       MARKER                     = rx_phy_postflop_0 [  79]
  assign rx_st_data          [ 293] = rx_phy_postflop_1 [  40];
//       STROBE                     = rx_phy_postflop_1 [  41]
  assign rx_st_data          [ 294] = rx_phy_postflop_1 [  42];
  assign rx_st_data          [ 295] = rx_phy_postflop_1 [  43];
  assign rx_st_data          [ 296] = rx_phy_postflop_1 [  44];
  assign rx_st_data          [ 297] = rx_phy_postflop_1 [  45];
  assign rx_st_data          [ 298] = rx_phy_postflop_1 [  46];
  assign rx_st_data          [ 299] = rx_phy_postflop_1 [  47];
  assign rx_st_data          [ 300] = rx_phy_postflop_1 [  48];
  assign rx_st_data          [ 301] = rx_phy_postflop_1 [  49];
  assign rx_st_data          [ 302] = rx_phy_postflop_1 [  50];
  assign rx_st_data          [ 303] = rx_phy_postflop_1 [  51];
  assign rx_st_data          [ 304] = rx_phy_postflop_1 [  52];
  assign rx_st_data          [ 305] = rx_phy_postflop_1 [  53];
  assign rx_st_data          [ 306] = rx_phy_postflop_1 [  54];
  assign rx_st_data          [ 307] = rx_phy_postflop_1 [  55];
  assign rx_st_data          [ 308] = rx_phy_postflop_1 [  56];
  assign rx_st_data          [ 309] = rx_phy_postflop_1 [  57];
  assign rx_st_data          [ 310] = rx_phy_postflop_1 [  58];
  assign rx_st_data          [ 311] = rx_phy_postflop_1 [  59];
  assign rx_st_data          [ 312] = rx_phy_postflop_1 [  60];
  assign rx_st_data          [ 313] = rx_phy_postflop_1 [  61];
  assign rx_st_data          [ 314] = rx_phy_postflop_1 [  62];
  assign rx_st_data          [ 315] = rx_phy_postflop_1 [  63];
  assign rx_st_data          [ 316] = rx_phy_postflop_1 [  64];
  assign rx_st_data          [ 317] = rx_phy_postflop_1 [  65];
  assign rx_st_data          [ 318] = rx_phy_postflop_1 [  66];
  assign rx_st_data          [ 319] = rx_phy_postflop_1 [  67];
  assign rx_st_data          [ 320] = rx_phy_postflop_1 [  68];
  assign rx_st_data          [ 321] = rx_phy_postflop_1 [  69];
  assign rx_st_data          [ 322] = rx_phy_postflop_1 [  70];
  assign rx_st_data          [ 323] = rx_phy_postflop_1 [  71];
  assign rx_st_data          [ 324] = rx_phy_postflop_1 [  72];
  assign rx_st_data          [ 325] = rx_phy_postflop_1 [  73];
  assign rx_st_data          [ 326] = rx_phy_postflop_1 [  74];
  assign rx_st_data          [ 327] = rx_phy_postflop_1 [  75];
  assign rx_st_data          [ 328] = rx_phy_postflop_1 [  76];
  assign rx_st_data          [ 329] = rx_phy_postflop_1 [  77];
  assign rx_st_data          [ 330] = rx_phy_postflop_1 [  78];
//       MARKER                     = rx_phy_postflop_1 [  79]
  assign rx_st_data          [ 331] = rx_phy_postflop_2 [  40];
//       STROBE                     = rx_phy_postflop_2 [  41]
  assign rx_st_data          [ 332] = rx_phy_postflop_2 [  42];
  assign rx_st_data          [ 333] = rx_phy_postflop_2 [  43];
  assign rx_st_data          [ 334] = rx_phy_postflop_2 [  44];
  assign rx_st_data          [ 335] = rx_phy_postflop_2 [  45];
  assign rx_st_data          [ 336] = rx_phy_postflop_2 [  46];
  assign rx_st_data          [ 337] = rx_phy_postflop_2 [  47];
  assign rx_st_data          [ 338] = rx_phy_postflop_2 [  48];
  assign rx_st_data          [ 339] = rx_phy_postflop_2 [  49];
  assign rx_st_data          [ 340] = rx_phy_postflop_2 [  50];
  assign rx_st_data          [ 341] = rx_phy_postflop_2 [  51];
  assign rx_st_data          [ 342] = rx_phy_postflop_2 [  52];
  assign rx_st_data          [ 343] = rx_phy_postflop_2 [  53];
  assign rx_st_data          [ 344] = rx_phy_postflop_2 [  54];
  assign rx_st_data          [ 345] = rx_phy_postflop_2 [  55];
  assign rx_st_data          [ 346] = rx_phy_postflop_2 [  56];
  assign rx_st_data          [ 347] = rx_phy_postflop_2 [  57];
  assign rx_st_data          [ 348] = rx_phy_postflop_2 [  58];
  assign rx_st_data          [ 349] = rx_phy_postflop_2 [  59];
  assign rx_st_data          [ 350] = rx_phy_postflop_2 [  60];
  assign rx_st_data          [ 351] = rx_phy_postflop_2 [  61];
  assign rx_st_data          [ 352] = rx_phy_postflop_2 [  62];
  assign rx_st_data          [ 353] = rx_phy_postflop_2 [  63];
  assign rx_st_data          [ 354] = rx_phy_postflop_2 [  64];
  assign rx_st_data          [ 355] = rx_phy_postflop_2 [  65];
  assign rx_st_data          [ 356] = rx_phy_postflop_2 [  66];
  assign rx_st_data          [ 357] = rx_phy_postflop_2 [  67];
  assign rx_st_data          [ 358] = rx_phy_postflop_2 [  68];
  assign rx_st_data          [ 359] = rx_phy_postflop_2 [  69];
  assign rx_st_data          [ 360] = rx_phy_postflop_2 [  70];
  assign rx_st_data          [ 361] = rx_phy_postflop_2 [  71];
  assign rx_st_data          [ 362] = rx_phy_postflop_2 [  72];
  assign rx_st_data          [ 363] = rx_phy_postflop_2 [  73];
  assign rx_st_data          [ 364] = rx_phy_postflop_2 [  74];
  assign rx_st_data          [ 365] = rx_phy_postflop_2 [  75];
  assign rx_st_data          [ 366] = rx_phy_postflop_2 [  76];
  assign rx_st_data          [ 367] = rx_phy_postflop_2 [  77];
  assign rx_st_data          [ 368] = rx_phy_postflop_2 [  78];
//       MARKER                     = rx_phy_postflop_2 [  79]
  assign rx_st_data          [ 369] = rx_phy_postflop_3 [  40];
//       STROBE                     = rx_phy_postflop_3 [  41]
  assign rx_st_data          [ 370] = rx_phy_postflop_3 [  42];
  assign rx_st_data          [ 371] = rx_phy_postflop_3 [  43];
  assign rx_st_data          [ 372] = rx_phy_postflop_3 [  44];
  assign rx_st_data          [ 373] = rx_phy_postflop_3 [  45];
  assign rx_st_data          [ 374] = rx_phy_postflop_3 [  46];
  assign rx_st_data          [ 375] = rx_phy_postflop_3 [  47];
  assign rx_st_data          [ 376] = rx_phy_postflop_3 [  48];
  assign rx_st_data          [ 377] = rx_phy_postflop_3 [  49];
  assign rx_st_data          [ 378] = rx_phy_postflop_3 [  50];
  assign rx_st_data          [ 379] = rx_phy_postflop_3 [  51];
  assign rx_st_data          [ 380] = rx_phy_postflop_3 [  52];
  assign rx_st_data          [ 381] = rx_phy_postflop_3 [  53];
  assign rx_st_data          [ 382] = rx_phy_postflop_3 [  54];
  assign rx_st_data          [ 383] = rx_phy_postflop_3 [  55];
  assign rx_st_data          [ 384] = rx_phy_postflop_3 [  56];
  assign rx_st_data          [ 385] = rx_phy_postflop_3 [  57];
  assign rx_st_data          [ 386] = rx_phy_postflop_3 [  58];
  assign rx_st_data          [ 387] = rx_phy_postflop_3 [  59];
  assign rx_st_data          [ 388] = rx_phy_postflop_3 [  60];
  assign rx_st_data          [ 389] = rx_phy_postflop_3 [  61];
  assign rx_st_data          [ 390] = rx_phy_postflop_3 [  62];
  assign rx_st_data          [ 391] = rx_phy_postflop_3 [  63];
  assign rx_st_data          [ 392] = rx_phy_postflop_3 [  64];
  assign rx_st_data          [ 393] = rx_phy_postflop_3 [  65];
  assign rx_st_data          [ 394] = rx_phy_postflop_3 [  66];
  assign rx_st_data          [ 395] = rx_phy_postflop_3 [  67];
  assign rx_st_data          [ 396] = rx_phy_postflop_3 [  68];
  assign rx_st_data          [ 397] = rx_phy_postflop_3 [  69];
  assign rx_st_data          [ 398] = rx_phy_postflop_3 [  70];
  assign rx_st_data          [ 399] = rx_phy_postflop_3 [  71];
  assign rx_st_data          [ 400] = rx_phy_postflop_3 [  72];
  assign rx_st_data          [ 401] = rx_phy_postflop_3 [  73];
  assign rx_st_data          [ 402] = rx_phy_postflop_3 [  74];
  assign rx_st_data          [ 403] = rx_phy_postflop_3 [  75];
  assign rx_st_data          [ 404] = rx_phy_postflop_3 [  76];
  assign rx_st_data          [ 405] = rx_phy_postflop_3 [  77];
  assign rx_st_data          [ 406] = rx_phy_postflop_3 [  78];
//       MARKER                     = rx_phy_postflop_3 [  79]
  assign rx_st_data          [ 407] = rx_phy_postflop_4 [  40];
//       STROBE                     = rx_phy_postflop_4 [  41]
  assign rx_st_data          [ 408] = rx_phy_postflop_4 [  42];
  assign rx_st_data          [ 409] = rx_phy_postflop_4 [  43];
  assign rx_st_data          [ 410] = rx_phy_postflop_4 [  44];
  assign rx_st_data          [ 411] = rx_phy_postflop_4 [  45];
  assign rx_st_data          [ 412] = rx_phy_postflop_4 [  46];
  assign rx_st_data          [ 413] = rx_phy_postflop_4 [  47];
  assign rx_st_data          [ 414] = rx_phy_postflop_4 [  48];
  assign rx_st_data          [ 415] = rx_phy_postflop_4 [  49];
  assign rx_st_data          [ 416] = rx_phy_postflop_4 [  50];
  assign rx_st_data          [ 417] = rx_phy_postflop_4 [  51];
  assign rx_st_data          [ 418] = rx_phy_postflop_4 [  52];
  assign rx_st_data          [ 419] = rx_phy_postflop_4 [  53];
  assign rx_st_data          [ 420] = rx_phy_postflop_4 [  54];
  assign rx_st_data          [ 421] = rx_phy_postflop_4 [  55];
  assign rx_st_data          [ 422] = rx_phy_postflop_4 [  56];
  assign rx_st_data          [ 423] = rx_phy_postflop_4 [  57];
  assign rx_st_data          [ 424] = rx_phy_postflop_4 [  58];
  assign rx_st_data          [ 425] = rx_phy_postflop_4 [  59];
  assign rx_st_data          [ 426] = rx_phy_postflop_4 [  60];
  assign rx_st_data          [ 427] = rx_phy_postflop_4 [  61];
  assign rx_st_data          [ 428] = rx_phy_postflop_4 [  62];
  assign rx_st_data          [ 429] = rx_phy_postflop_4 [  63];
  assign rx_st_data          [ 430] = rx_phy_postflop_4 [  64];
  assign rx_st_data          [ 431] = rx_phy_postflop_4 [  65];
  assign rx_st_data          [ 432] = rx_phy_postflop_4 [  66];
  assign rx_st_data          [ 433] = rx_phy_postflop_4 [  67];
  assign rx_st_data          [ 434] = rx_phy_postflop_4 [  68];
  assign rx_st_data          [ 435] = rx_phy_postflop_4 [  69];
  assign rx_st_data          [ 436] = rx_phy_postflop_4 [  70];
  assign rx_st_data          [ 437] = rx_phy_postflop_4 [  71];
  assign rx_st_data          [ 438] = rx_phy_postflop_4 [  72];
  assign rx_st_data          [ 439] = rx_phy_postflop_4 [  73];
  assign rx_st_data          [ 440] = rx_phy_postflop_4 [  74];
  assign rx_st_data          [ 441] = rx_phy_postflop_4 [  75];
  assign rx_st_data          [ 442] = rx_phy_postflop_4 [  76];
  assign rx_st_data          [ 443] = rx_phy_postflop_4 [  77];
  assign rx_st_data          [ 444] = rx_phy_postflop_4 [  78];
//       MARKER                     = rx_phy_postflop_4 [  79]
  assign rx_st_data          [ 445] = rx_phy_postflop_5 [  40];
//       STROBE                     = rx_phy_postflop_5 [  41]
  assign rx_st_data          [ 446] = rx_phy_postflop_5 [  42];
  assign rx_st_data          [ 447] = rx_phy_postflop_5 [  43];
  assign rx_st_data          [ 448] = rx_phy_postflop_5 [  44];
  assign rx_st_data          [ 449] = rx_phy_postflop_5 [  45];
  assign rx_st_data          [ 450] = rx_phy_postflop_5 [  46];
  assign rx_st_data          [ 451] = rx_phy_postflop_5 [  47];
  assign rx_st_data          [ 452] = rx_phy_postflop_5 [  48];
  assign rx_st_data          [ 453] = rx_phy_postflop_5 [  49];
  assign rx_st_data          [ 454] = rx_phy_postflop_5 [  50];
  assign rx_st_data          [ 455] = rx_phy_postflop_5 [  51];
  assign rx_st_data          [ 456] = rx_phy_postflop_5 [  52];
  assign rx_st_data          [ 457] = rx_phy_postflop_5 [  53];
  assign rx_st_data          [ 458] = rx_phy_postflop_5 [  54];
  assign rx_st_data          [ 459] = rx_phy_postflop_5 [  55];
  assign rx_st_data          [ 460] = rx_phy_postflop_5 [  56];
  assign rx_st_data          [ 461] = rx_phy_postflop_5 [  57];
  assign rx_st_data          [ 462] = rx_phy_postflop_5 [  58];
  assign rx_st_data          [ 463] = rx_phy_postflop_5 [  59];
  assign rx_st_data          [ 464] = rx_phy_postflop_5 [  60];
  assign rx_st_data          [ 465] = rx_phy_postflop_5 [  61];
  assign rx_st_data          [ 466] = rx_phy_postflop_5 [  62];
  assign rx_st_data          [ 467] = rx_phy_postflop_5 [  63];
  assign rx_st_data          [ 468] = rx_phy_postflop_5 [  64];
  assign rx_st_data          [ 469] = rx_phy_postflop_5 [  65];
  assign rx_st_data          [ 470] = rx_phy_postflop_5 [  66];
  assign rx_st_data          [ 471] = rx_phy_postflop_5 [  67];
  assign rx_st_data          [ 472] = rx_phy_postflop_5 [  68];
  assign rx_st_data          [ 473] = rx_phy_postflop_5 [  69];
  assign rx_st_data          [ 474] = rx_phy_postflop_5 [  70];
  assign rx_st_data          [ 475] = rx_phy_postflop_5 [  71];
  assign rx_st_data          [ 476] = rx_phy_postflop_5 [  72];
  assign rx_st_data          [ 477] = rx_phy_postflop_5 [  73];
  assign rx_st_data          [ 478] = rx_phy_postflop_5 [  74];
  assign rx_st_data          [ 479] = rx_phy_postflop_5 [  75];
  assign rx_st_data          [ 480] = rx_phy_postflop_5 [  76];
  assign rx_st_data          [ 481] = rx_phy_postflop_5 [  77];
  assign rx_st_data          [ 482] = rx_phy_postflop_5 [  78];
//       MARKER                     = rx_phy_postflop_5 [  79]
  assign rx_st_data          [ 483] = rx_phy_postflop_6 [  40];
//       STROBE                     = rx_phy_postflop_6 [  41]
  assign rx_st_data          [ 484] = rx_phy_postflop_6 [  42];
  assign rx_st_data          [ 485] = rx_phy_postflop_6 [  43];
  assign rx_st_data          [ 486] = rx_phy_postflop_6 [  44];
  assign rx_st_data          [ 487] = rx_phy_postflop_6 [  45];
  assign rx_st_data          [ 488] = rx_phy_postflop_6 [  46];
  assign rx_st_data          [ 489] = rx_phy_postflop_6 [  47];
  assign rx_st_data          [ 490] = rx_phy_postflop_6 [  48];
  assign rx_st_data          [ 491] = rx_phy_postflop_6 [  49];
  assign rx_st_data          [ 492] = rx_phy_postflop_6 [  50];
  assign rx_st_data          [ 493] = rx_phy_postflop_6 [  51];
  assign rx_st_data          [ 494] = rx_phy_postflop_6 [  52];
  assign rx_st_data          [ 495] = rx_phy_postflop_6 [  53];
  assign rx_st_data          [ 496] = rx_phy_postflop_6 [  54];
  assign rx_st_data          [ 497] = rx_phy_postflop_6 [  55];
  assign rx_st_data          [ 498] = rx_phy_postflop_6 [  56];
  assign rx_st_data          [ 499] = rx_phy_postflop_6 [  57];
  assign rx_st_data          [ 500] = rx_phy_postflop_6 [  58];
  assign rx_st_data          [ 501] = rx_phy_postflop_6 [  59];
  assign rx_st_data          [ 502] = rx_phy_postflop_6 [  60];
  assign rx_st_data          [ 503] = rx_phy_postflop_6 [  61];
  assign rx_st_data          [ 504] = rx_phy_postflop_6 [  62];
  assign rx_st_data          [ 505] = rx_phy_postflop_6 [  63];
  assign rx_st_data          [ 506] = rx_phy_postflop_6 [  64];
  assign rx_st_data          [ 507] = rx_phy_postflop_6 [  65];
  assign rx_st_data          [ 508] = rx_phy_postflop_6 [  66];
  assign rx_st_data          [ 509] = rx_phy_postflop_6 [  67];
  assign rx_st_data          [ 510] = rx_phy_postflop_6 [  68];
  assign rx_st_data          [ 511] = rx_phy_postflop_6 [  69];
//       nc                         = rx_phy_postflop_6 [  70];
//       nc                         = rx_phy_postflop_6 [  71];
//       nc                         = rx_phy_postflop_6 [  72];
//       nc                         = rx_phy_postflop_6 [  73];
//       nc                         = rx_phy_postflop_6 [  74];
//       nc                         = rx_phy_postflop_6 [  75];
//       nc                         = rx_phy_postflop_6 [  76];
//       nc                         = rx_phy_postflop_6 [  77];
//       nc                         = rx_phy_postflop_6 [  78];
//       MARKER                     = rx_phy_postflop_6 [  79]
  assign rx_st_data          [ 512] = rx_st_pushbit_r0;
  assign rx_st_data          [ 513] = rx_st_pushbit_r1;

// RX Section
//////////////////////////////////////////////////////////////////


endmodule
