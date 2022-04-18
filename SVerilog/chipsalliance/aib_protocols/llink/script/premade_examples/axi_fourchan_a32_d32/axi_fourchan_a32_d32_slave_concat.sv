module axi_fourchan_a32_d32_slave_concat  (

// Transmit data from Logic Links
  output logic [ 43:  0]    rx_ch0_ar_data      ,
  output logic              rx_ch0_ar_push_ovrd ,
  output logic              rx_ch0_ar_pushbit   ,
  input  logic              tx_ch0_ar_credit    ,

  output logic [ 43:  0]    rx_ch0_aw_data      ,
  output logic              rx_ch0_aw_push_ovrd ,
  output logic              rx_ch0_aw_pushbit   ,
  input  logic              tx_ch0_aw_credit    ,

  output logic [ 48:  0]    rx_ch0_w_data       ,
  output logic              rx_ch0_w_push_ovrd  ,
  output logic              rx_ch0_w_pushbit    ,
  input  logic              tx_ch0_w_credit     ,

  input  logic [ 34:  0]    tx_ch0_r_data       ,
  output logic              tx_ch0_r_pop_ovrd   ,
  input  logic              tx_ch0_r_pushbit    ,
  output logic              rx_ch0_r_credit     ,

  input  logic [  1:  0]    tx_ch0_b_data       ,
  output logic              tx_ch0_b_pop_ovrd   ,
  input  logic              tx_ch0_b_pushbit    ,
  output logic              rx_ch0_b_credit     ,

  output logic [ 43:  0]    rx_ch1_ar_data      ,
  output logic              rx_ch1_ar_push_ovrd ,
  output logic              rx_ch1_ar_pushbit   ,
  input  logic              tx_ch1_ar_credit    ,

  output logic [ 43:  0]    rx_ch1_aw_data      ,
  output logic              rx_ch1_aw_push_ovrd ,
  output logic              rx_ch1_aw_pushbit   ,
  input  logic              tx_ch1_aw_credit    ,

  output logic [ 48:  0]    rx_ch1_w_data       ,
  output logic              rx_ch1_w_push_ovrd  ,
  output logic              rx_ch1_w_pushbit    ,
  input  logic              tx_ch1_w_credit     ,

  input  logic [ 34:  0]    tx_ch1_r_data       ,
  output logic              tx_ch1_r_pop_ovrd   ,
  input  logic              tx_ch1_r_pushbit    ,
  output logic              rx_ch1_r_credit     ,

  input  logic [  1:  0]    tx_ch1_b_data       ,
  output logic              tx_ch1_b_pop_ovrd   ,
  input  logic              tx_ch1_b_pushbit    ,
  output logic              rx_ch1_b_credit     ,

  output logic [ 43:  0]    rx_ch2_ar_data      ,
  output logic              rx_ch2_ar_push_ovrd ,
  output logic              rx_ch2_ar_pushbit   ,
  input  logic              tx_ch2_ar_credit    ,

  output logic [ 43:  0]    rx_ch2_aw_data      ,
  output logic              rx_ch2_aw_push_ovrd ,
  output logic              rx_ch2_aw_pushbit   ,
  input  logic              tx_ch2_aw_credit    ,

  output logic [ 48:  0]    rx_ch2_w_data       ,
  output logic              rx_ch2_w_push_ovrd  ,
  output logic              rx_ch2_w_pushbit    ,
  input  logic              tx_ch2_w_credit     ,

  input  logic [ 34:  0]    tx_ch2_r_data       ,
  output logic              tx_ch2_r_pop_ovrd   ,
  input  logic              tx_ch2_r_pushbit    ,
  output logic              rx_ch2_r_credit     ,

  input  logic [  1:  0]    tx_ch2_b_data       ,
  output logic              tx_ch2_b_pop_ovrd   ,
  input  logic              tx_ch2_b_pushbit    ,
  output logic              rx_ch2_b_credit     ,

  output logic [ 43:  0]    rx_ch3_ar_data      ,
  output logic              rx_ch3_ar_push_ovrd ,
  output logic              rx_ch3_ar_pushbit   ,
  input  logic              tx_ch3_ar_credit    ,

  output logic [ 43:  0]    rx_ch3_aw_data      ,
  output logic              rx_ch3_aw_push_ovrd ,
  output logic              rx_ch3_aw_pushbit   ,
  input  logic              tx_ch3_aw_credit    ,

  output logic [ 48:  0]    rx_ch3_w_data       ,
  output logic              rx_ch3_w_push_ovrd  ,
  output logic              rx_ch3_w_pushbit    ,
  input  logic              tx_ch3_w_credit     ,

  input  logic [ 34:  0]    tx_ch3_r_data       ,
  output logic              tx_ch3_r_pop_ovrd   ,
  input  logic              tx_ch3_r_pushbit    ,
  output logic              rx_ch3_r_credit     ,

  input  logic [  1:  0]    tx_ch3_b_data       ,
  output logic              tx_ch3_b_pop_ovrd   ,
  input  logic              tx_ch3_b_pushbit    ,
  output logic              rx_ch3_b_credit     ,

// PHY Interconnect
  output logic [319:  0]    tx_phy0             ,
  input  logic [319:  0]    rx_phy0             ,
  output logic [319:  0]    tx_phy1             ,
  input  logic [319:  0]    rx_phy1             ,

  input  logic              clk_wr              ,
  input  logic              clk_rd              ,
  input  logic              rst_wr_n            ,
  input  logic              rst_rd_n            ,

  input  logic              m_gen2_mode         ,
  input  logic              tx_online           ,

  input  logic              tx_stb_userbit      ,
  input  logic [  3:  0]    tx_mrk_userbit      

);

////////////////////////////////////////////////////////////
// TX Packet Section
  logic [  4:  0]                                tx_requestor                  ;
  logic [  4:  0]                                tx_grant_onehotish            ;
  logic [  2:  0]                                tx_grant_enc_data             ;
  logic [582:  0]                                tx_packet_data                ;
  logic [582:  0]                                tx_packet_data0               ;
  logic [582:  0]                                tx_packet_data1               ;
  logic [582:  0]                                tx_packet_data2               ;
  logic [582:  0]                                tx_packet_data3               ;
  logic [582:  0]                                tx_packet_data4               ;

  rrarb #(.REQUESTORS(5)) rrarb_itx
          (// Outputs
           .grant                     (tx_grant_onehotish),
           // Inputs
           .clk_core                  (clk_wr),
           .rst_core_n                (rst_wr_n),
           .requestor                 (tx_requestor),
           .advance                   (1'b1));
  // This converts from one-hot-ish rrarb output to encoded value
  always_comb
  begin: onehot_2_enc
    integer tx_index;
    tx_grant_enc_data = 0;
    for (tx_index=0; tx_index < 5; tx_index = tx_index + 1)
      if (tx_grant_onehotish[tx_index])
        tx_grant_enc_data = tx_grant_enc_data | tx_index; // the OR helps with multi-bit onehot cases
  end


  // This assigns the data portion of packetizing
  always_comb
  begin
    case(tx_grant_enc_data)
       3'd0    : tx_packet_data = tx_packet_data0;
       3'd1    : tx_packet_data = tx_packet_data1;
       3'd2    : tx_packet_data = tx_packet_data2;
       3'd3    : tx_packet_data = tx_packet_data3;
       3'd4    : tx_packet_data = tx_packet_data4;
      default  : tx_packet_data = tx_packet_data4;
    endcase
  end

  // This controls if we can pop the TX FIFO
  assign tx_ch0_r_pop_ovrd = (tx_grant_enc_data == 3'd1) ? 1'b0 : 1'b1;
  assign tx_ch0_b_pop_ovrd = (tx_grant_enc_data == 3'd0) ? 1'b0 : 1'b1;
  assign tx_ch1_r_pop_ovrd = (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : 1'b1;
  assign tx_ch1_b_pop_ovrd = (tx_grant_enc_data == 3'd2) ? 1'b0 : 1'b1;
  assign tx_ch2_r_pop_ovrd = (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : 1'b1;
  assign tx_ch2_b_pop_ovrd = (tx_grant_enc_data == 3'd3) ? 1'b0 : 1'b1;
  assign tx_ch3_r_pop_ovrd = (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : (tx_grant_enc_data == 3'd4) ? 1'b0 : 1'b1;
  assign tx_ch3_b_pop_ovrd = (tx_grant_enc_data == 3'd4) ? 1'b0 : 1'b1;

  // Request to Arbitrate
  assign tx_requestor [0] = tx_ch3_r_pushbit  | tx_ch2_r_pushbit  | tx_ch1_r_pushbit  | tx_ch0_b_pushbit ; 
  assign tx_requestor [1] = tx_ch3_r_pushbit  | tx_ch2_r_pushbit  | tx_ch1_r_pushbit  | tx_ch0_r_pushbit ; 
  assign tx_requestor [2] = tx_ch3_r_pushbit  | tx_ch2_r_pushbit  | tx_ch1_r_pushbit  | tx_ch1_b_pushbit ; 
  assign tx_requestor [3] = tx_ch3_r_pushbit  | tx_ch2_r_pushbit  | tx_ch1_r_pushbit  | tx_ch2_b_pushbit ; 
  assign tx_requestor [4] = tx_ch3_r_pushbit  | tx_ch2_r_pushbit  | tx_ch1_r_pushbit  | tx_ch3_b_pushbit ; 

  // Data to Transmit
  assign tx_packet_data0      [  0 +: 35] = tx_ch3_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data0      [ 35 +:  1] = tx_ch3_r_pushbit                 ; // Push Bit
  assign tx_packet_data0      [ 36 +: 35] = tx_ch2_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data0      [ 71 +:  1] = tx_ch2_r_pushbit                 ; // Push Bit
  assign tx_packet_data0      [ 72 +: 35] = tx_ch1_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data0      [107 +:  1] = tx_ch1_r_pushbit                 ; // Push Bit
  assign tx_packet_data0      [108 +:  2] = tx_ch0_b_data        [  0 +:  2] ; // Llink Data
  assign tx_packet_data0      [110 +:  1] = tx_ch0_b_pushbit                 ; // Push Bit
  assign tx_packet_data0      [111 +:472] = 472'b0                           ; // Spare

  assign tx_packet_data1      [  0 +: 35] = tx_ch3_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data1      [ 35 +:  1] = tx_ch3_r_pushbit                 ; // Push Bit
  assign tx_packet_data1      [ 36 +: 35] = tx_ch2_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data1      [ 71 +:  1] = tx_ch2_r_pushbit                 ; // Push Bit
  assign tx_packet_data1      [ 72 +: 35] = tx_ch1_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data1      [107 +:  1] = tx_ch1_r_pushbit                 ; // Push Bit
  assign tx_packet_data1      [108 +: 35] = tx_ch0_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data1      [143 +:  1] = tx_ch0_r_pushbit                 ; // Push Bit
  assign tx_packet_data1      [144 +:439] = 439'b0                           ; // Spare

  assign tx_packet_data2      [  0 +: 35] = tx_ch3_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data2      [ 35 +:  1] = tx_ch3_r_pushbit                 ; // Push Bit
  assign tx_packet_data2      [ 36 +: 35] = tx_ch2_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data2      [ 71 +:  1] = tx_ch2_r_pushbit                 ; // Push Bit
  assign tx_packet_data2      [ 72 +: 35] = tx_ch1_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data2      [107 +:  1] = tx_ch1_r_pushbit                 ; // Push Bit
  assign tx_packet_data2      [108 +:  2] = tx_ch1_b_data        [  0 +:  2] ; // Llink Data
  assign tx_packet_data2      [110 +:  1] = tx_ch1_b_pushbit                 ; // Push Bit
  assign tx_packet_data2      [111 +:472] = 472'b0                           ; // Spare

  assign tx_packet_data3      [  0 +: 35] = tx_ch3_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data3      [ 35 +:  1] = tx_ch3_r_pushbit                 ; // Push Bit
  assign tx_packet_data3      [ 36 +: 35] = tx_ch2_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data3      [ 71 +:  1] = tx_ch2_r_pushbit                 ; // Push Bit
  assign tx_packet_data3      [ 72 +: 35] = tx_ch1_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data3      [107 +:  1] = tx_ch1_r_pushbit                 ; // Push Bit
  assign tx_packet_data3      [108 +:  2] = tx_ch2_b_data        [  0 +:  2] ; // Llink Data
  assign tx_packet_data3      [110 +:  1] = tx_ch2_b_pushbit                 ; // Push Bit
  assign tx_packet_data3      [111 +:472] = 472'b0                           ; // Spare

  assign tx_packet_data4      [  0 +: 35] = tx_ch3_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data4      [ 35 +:  1] = tx_ch3_r_pushbit                 ; // Push Bit
  assign tx_packet_data4      [ 36 +: 35] = tx_ch2_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data4      [ 71 +:  1] = tx_ch2_r_pushbit                 ; // Push Bit
  assign tx_packet_data4      [ 72 +: 35] = tx_ch1_r_data        [  0 +: 35] ; // Llink Data
  assign tx_packet_data4      [107 +:  1] = tx_ch1_r_pushbit                 ; // Push Bit
  assign tx_packet_data4      [108 +:  2] = tx_ch3_b_data        [  0 +:  2] ; // Llink Data
  assign tx_packet_data4      [110 +:  1] = tx_ch3_b_pushbit                 ; // Push Bit
  assign tx_packet_data4      [111 +:472] = 472'b0                           ; // Spare

// TX Packet Section
////////////////////////////////////////////////////////////

// No RX Packetization, so tie off packetization signals
  assign rx_ch0_ar_push_ovrd              = 1'b0                             ;
  assign rx_ch0_aw_push_ovrd              = 1'b0                             ;
  assign rx_ch0_w_push_ovrd               = 1'b0                             ;
  assign rx_ch1_ar_push_ovrd              = 1'b0                             ;
  assign rx_ch1_aw_push_ovrd              = 1'b0                             ;
  assign rx_ch1_w_push_ovrd               = 1'b0                             ;
  assign rx_ch2_ar_push_ovrd              = 1'b0                             ;
  assign rx_ch2_aw_push_ovrd              = 1'b0                             ;
  assign rx_ch2_w_push_ovrd               = 1'b0                             ;
  assign rx_ch3_ar_push_ovrd              = 1'b0                             ;
  assign rx_ch3_aw_push_ovrd              = 1'b0                             ;
  assign rx_ch3_w_push_ovrd               = 1'b0                             ;

////////////////////////////////////////////////////////////
// TX Section

//   TX_CH_WIDTH           = 320; // Gen2 running at Quarter Rate
//   TX_DATA_WIDTH         = 299; // Usable Data per Channel
//   TX_PERSISTENT_STROBE  = 1'b1;
//   TX_PERSISTENT_MARKER  = 1'b1;
//   TX_STROBE_GEN2_LOC    = 'd76;
//   TX_MARKER_GEN2_LOC    = 'd4;
//   TX_STROBE_GEN1_LOC    = 'd38;
//   TX_MARKER_GEN1_LOC    = 'd39;
//   TX_ENABLE_STROBE      = 1'b1;
//   TX_ENABLE_MARKER      = 1'b1;
//   TX_DBI_PRESENT        = 1'b1;
//   TX_REG_PHY            = 1'b0;

  localparam TX_REG_PHY    = 1'b0;

  logic [319:  0]                                tx_phy_preflop_0              ;
  logic [319:  0]                                tx_phy_preflop_1              ;
  logic [319:  0]                                tx_phy_flop_0_reg             ;
  logic [319:  0]                                tx_phy_flop_1_reg             ;

  always_ff @(posedge clk_wr or negedge rst_wr_n)
  if (~rst_wr_n)
  begin
    tx_phy_flop_0_reg                     <= 320'b0                                ;
    tx_phy_flop_1_reg                     <= 320'b0                                ;
  end
  else
  begin
    tx_phy_flop_0_reg                     <= tx_phy_preflop_0                      ;
    tx_phy_flop_1_reg                     <= tx_phy_preflop_1                      ;
  end


  assign tx_phy0                          = TX_REG_PHY ? tx_phy_flop_0_reg : tx_phy_preflop_0             ;
  assign tx_phy1                          = TX_REG_PHY ? tx_phy_flop_1_reg : tx_phy_preflop_1             ;

  assign tx_phy_preflop_0 [  0] = tx_grant_enc_data   [  0] ;
  assign tx_phy_preflop_0 [  1] = tx_grant_enc_data   [  1] ;
  assign tx_phy_preflop_0 [  2] = tx_grant_enc_data   [  2] ;
  assign tx_phy_preflop_0 [  3] = tx_packet_data      [  0] ;
  assign tx_phy_preflop_0 [  4] = tx_mrk_userbit[0]         ; // MARKER
  assign tx_phy_preflop_0 [  5] = tx_packet_data      [  1] ;
  assign tx_phy_preflop_0 [  6] = tx_packet_data      [  2] ;
  assign tx_phy_preflop_0 [  7] = tx_packet_data      [  3] ;
  assign tx_phy_preflop_0 [  8] = tx_packet_data      [  4] ;
  assign tx_phy_preflop_0 [  9] = tx_packet_data      [  5] ;
  assign tx_phy_preflop_0 [ 10] = tx_packet_data      [  6] ;
  assign tx_phy_preflop_0 [ 11] = tx_packet_data      [  7] ;
  assign tx_phy_preflop_0 [ 12] = tx_packet_data      [  8] ;
  assign tx_phy_preflop_0 [ 13] = tx_packet_data      [  9] ;
  assign tx_phy_preflop_0 [ 14] = tx_packet_data      [ 10] ;
  assign tx_phy_preflop_0 [ 15] = tx_packet_data      [ 11] ;
  assign tx_phy_preflop_0 [ 16] = tx_packet_data      [ 12] ;
  assign tx_phy_preflop_0 [ 17] = tx_packet_data      [ 13] ;
  assign tx_phy_preflop_0 [ 18] = tx_packet_data      [ 14] ;
  assign tx_phy_preflop_0 [ 19] = tx_packet_data      [ 15] ;
  assign tx_phy_preflop_0 [ 20] = tx_packet_data      [ 16] ;
  assign tx_phy_preflop_0 [ 21] = tx_packet_data      [ 17] ;
  assign tx_phy_preflop_0 [ 22] = tx_packet_data      [ 18] ;
  assign tx_phy_preflop_0 [ 23] = tx_packet_data      [ 19] ;
  assign tx_phy_preflop_0 [ 24] = tx_packet_data      [ 20] ;
  assign tx_phy_preflop_0 [ 25] = tx_packet_data      [ 21] ;
  assign tx_phy_preflop_0 [ 26] = tx_packet_data      [ 22] ;
  assign tx_phy_preflop_0 [ 27] = tx_packet_data      [ 23] ;
  assign tx_phy_preflop_0 [ 28] = tx_packet_data      [ 24] ;
  assign tx_phy_preflop_0 [ 29] = tx_packet_data      [ 25] ;
  assign tx_phy_preflop_0 [ 30] = tx_packet_data      [ 26] ;
  assign tx_phy_preflop_0 [ 31] = tx_packet_data      [ 27] ;
  assign tx_phy_preflop_0 [ 32] = tx_packet_data      [ 28] ;
  assign tx_phy_preflop_0 [ 33] = tx_packet_data      [ 29] ;
  assign tx_phy_preflop_0 [ 34] = tx_packet_data      [ 30] ;
  assign tx_phy_preflop_0 [ 35] = tx_packet_data      [ 31] ;
  assign tx_phy_preflop_0 [ 36] = tx_packet_data      [ 32] ;
  assign tx_phy_preflop_0 [ 37] = tx_packet_data      [ 33] ;
  assign tx_phy_preflop_0 [ 38] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [ 39] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [ 40] = tx_packet_data      [ 34] ;
  assign tx_phy_preflop_0 [ 41] = tx_packet_data      [ 35] ;
  assign tx_phy_preflop_0 [ 42] = tx_packet_data      [ 36] ;
  assign tx_phy_preflop_0 [ 43] = tx_packet_data      [ 37] ;
  assign tx_phy_preflop_0 [ 44] = tx_packet_data      [ 38] ;
  assign tx_phy_preflop_0 [ 45] = tx_packet_data      [ 39] ;
  assign tx_phy_preflop_0 [ 46] = tx_packet_data      [ 40] ;
  assign tx_phy_preflop_0 [ 47] = tx_packet_data      [ 41] ;
  assign tx_phy_preflop_0 [ 48] = tx_packet_data      [ 42] ;
  assign tx_phy_preflop_0 [ 49] = tx_packet_data      [ 43] ;
  assign tx_phy_preflop_0 [ 50] = tx_packet_data      [ 44] ;
  assign tx_phy_preflop_0 [ 51] = tx_packet_data      [ 45] ;
  assign tx_phy_preflop_0 [ 52] = tx_packet_data      [ 46] ;
  assign tx_phy_preflop_0 [ 53] = tx_packet_data      [ 47] ;
  assign tx_phy_preflop_0 [ 54] = tx_packet_data      [ 48] ;
  assign tx_phy_preflop_0 [ 55] = tx_packet_data      [ 49] ;
  assign tx_phy_preflop_0 [ 56] = tx_packet_data      [ 50] ;
  assign tx_phy_preflop_0 [ 57] = tx_packet_data      [ 51] ;
  assign tx_phy_preflop_0 [ 58] = tx_packet_data      [ 52] ;
  assign tx_phy_preflop_0 [ 59] = tx_packet_data      [ 53] ;
  assign tx_phy_preflop_0 [ 60] = tx_packet_data      [ 54] ;
  assign tx_phy_preflop_0 [ 61] = tx_packet_data      [ 55] ;
  assign tx_phy_preflop_0 [ 62] = tx_packet_data      [ 56] ;
  assign tx_phy_preflop_0 [ 63] = tx_packet_data      [ 57] ;
  assign tx_phy_preflop_0 [ 64] = tx_packet_data      [ 58] ;
  assign tx_phy_preflop_0 [ 65] = tx_packet_data      [ 59] ;
  assign tx_phy_preflop_0 [ 66] = tx_packet_data      [ 60] ;
  assign tx_phy_preflop_0 [ 67] = tx_packet_data      [ 61] ;
  assign tx_phy_preflop_0 [ 68] = tx_packet_data      [ 62] ;
  assign tx_phy_preflop_0 [ 69] = tx_packet_data      [ 63] ;
  assign tx_phy_preflop_0 [ 70] = tx_packet_data      [ 64] ;
  assign tx_phy_preflop_0 [ 71] = tx_packet_data      [ 65] ;
  assign tx_phy_preflop_0 [ 72] = tx_packet_data      [ 66] ;
  assign tx_phy_preflop_0 [ 73] = tx_packet_data      [ 67] ;
  assign tx_phy_preflop_0 [ 74] = tx_packet_data      [ 68] ;
  assign tx_phy_preflop_0 [ 75] = tx_packet_data      [ 69] ;
  assign tx_phy_preflop_0 [ 76] = tx_stb_userbit             ; // STROBE
  assign tx_phy_preflop_0 [ 77] = tx_packet_data      [ 70] ;
  assign tx_phy_preflop_0 [ 78] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [ 79] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [ 80] = tx_packet_data      [ 71] ;
  assign tx_phy_preflop_0 [ 81] = tx_packet_data      [ 72] ;
  assign tx_phy_preflop_0 [ 82] = tx_packet_data      [ 73] ;
  assign tx_phy_preflop_0 [ 83] = tx_packet_data      [ 74] ;
  assign tx_phy_preflop_0 [ 84] = tx_mrk_userbit[1]         ; // MARKER
  assign tx_phy_preflop_0 [ 85] = tx_packet_data      [ 75] ;
  assign tx_phy_preflop_0 [ 86] = tx_packet_data      [ 76] ;
  assign tx_phy_preflop_0 [ 87] = tx_packet_data      [ 77] ;
  assign tx_phy_preflop_0 [ 88] = tx_packet_data      [ 78] ;
  assign tx_phy_preflop_0 [ 89] = tx_packet_data      [ 79] ;
  assign tx_phy_preflop_0 [ 90] = tx_packet_data      [ 80] ;
  assign tx_phy_preflop_0 [ 91] = tx_packet_data      [ 81] ;
  assign tx_phy_preflop_0 [ 92] = tx_packet_data      [ 82] ;
  assign tx_phy_preflop_0 [ 93] = tx_packet_data      [ 83] ;
  assign tx_phy_preflop_0 [ 94] = tx_packet_data      [ 84] ;
  assign tx_phy_preflop_0 [ 95] = tx_packet_data      [ 85] ;
  assign tx_phy_preflop_0 [ 96] = tx_packet_data      [ 86] ;
  assign tx_phy_preflop_0 [ 97] = tx_packet_data      [ 87] ;
  assign tx_phy_preflop_0 [ 98] = tx_packet_data      [ 88] ;
  assign tx_phy_preflop_0 [ 99] = tx_packet_data      [ 89] ;
  assign tx_phy_preflop_0 [100] = tx_packet_data      [ 90] ;
  assign tx_phy_preflop_0 [101] = tx_packet_data      [ 91] ;
  assign tx_phy_preflop_0 [102] = tx_packet_data      [ 92] ;
  assign tx_phy_preflop_0 [103] = tx_packet_data      [ 93] ;
  assign tx_phy_preflop_0 [104] = tx_packet_data      [ 94] ;
  assign tx_phy_preflop_0 [105] = tx_packet_data      [ 95] ;
  assign tx_phy_preflop_0 [106] = tx_packet_data      [ 96] ;
  assign tx_phy_preflop_0 [107] = tx_packet_data      [ 97] ;
  assign tx_phy_preflop_0 [108] = tx_packet_data      [ 98] ;
  assign tx_phy_preflop_0 [109] = tx_packet_data      [ 99] ;
  assign tx_phy_preflop_0 [110] = tx_packet_data      [100] ;
  assign tx_phy_preflop_0 [111] = tx_packet_data      [101] ;
  assign tx_phy_preflop_0 [112] = tx_packet_data      [102] ;
  assign tx_phy_preflop_0 [113] = tx_packet_data      [103] ;
  assign tx_phy_preflop_0 [114] = tx_packet_data      [104] ;
  assign tx_phy_preflop_0 [115] = tx_packet_data      [105] ;
  assign tx_phy_preflop_0 [116] = tx_packet_data      [106] ;
  assign tx_phy_preflop_0 [117] = tx_packet_data      [107] ;
  assign tx_phy_preflop_0 [118] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [119] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [120] = tx_packet_data      [108] ;
  assign tx_phy_preflop_0 [121] = tx_packet_data      [109] ;
  assign tx_phy_preflop_0 [122] = tx_packet_data      [110] ;
  assign tx_phy_preflop_0 [123] = tx_packet_data      [111] ;
  assign tx_phy_preflop_0 [124] = tx_packet_data      [112] ;
  assign tx_phy_preflop_0 [125] = tx_packet_data      [113] ;
  assign tx_phy_preflop_0 [126] = tx_packet_data      [114] ;
  assign tx_phy_preflop_0 [127] = tx_packet_data      [115] ;
  assign tx_phy_preflop_0 [128] = tx_packet_data      [116] ;
  assign tx_phy_preflop_0 [129] = tx_packet_data      [117] ;
  assign tx_phy_preflop_0 [130] = tx_packet_data      [118] ;
  assign tx_phy_preflop_0 [131] = tx_packet_data      [119] ;
  assign tx_phy_preflop_0 [132] = tx_packet_data      [120] ;
  assign tx_phy_preflop_0 [133] = tx_packet_data      [121] ;
  assign tx_phy_preflop_0 [134] = tx_packet_data      [122] ;
  assign tx_phy_preflop_0 [135] = tx_packet_data      [123] ;
  assign tx_phy_preflop_0 [136] = tx_packet_data      [124] ;
  assign tx_phy_preflop_0 [137] = tx_packet_data      [125] ;
  assign tx_phy_preflop_0 [138] = tx_packet_data      [126] ;
  assign tx_phy_preflop_0 [139] = tx_packet_data      [127] ;
  assign tx_phy_preflop_0 [140] = tx_packet_data      [128] ;
  assign tx_phy_preflop_0 [141] = tx_packet_data      [129] ;
  assign tx_phy_preflop_0 [142] = tx_packet_data      [130] ;
  assign tx_phy_preflop_0 [143] = tx_packet_data      [131] ;
  assign tx_phy_preflop_0 [144] = tx_packet_data      [132] ;
  assign tx_phy_preflop_0 [145] = tx_packet_data      [133] ;
  assign tx_phy_preflop_0 [146] = tx_packet_data      [134] ;
  assign tx_phy_preflop_0 [147] = tx_packet_data      [135] ;
  assign tx_phy_preflop_0 [148] = tx_packet_data      [136] ;
  assign tx_phy_preflop_0 [149] = tx_packet_data      [137] ;
  assign tx_phy_preflop_0 [150] = tx_packet_data      [138] ;
  assign tx_phy_preflop_0 [151] = tx_packet_data      [139] ;
  assign tx_phy_preflop_0 [152] = tx_packet_data      [140] ;
  assign tx_phy_preflop_0 [153] = tx_packet_data      [141] ;
  assign tx_phy_preflop_0 [154] = tx_packet_data      [142] ;
  assign tx_phy_preflop_0 [155] = tx_packet_data      [143] ;
  assign tx_phy_preflop_0 [156] = tx_packet_data      [144] ;
  assign tx_phy_preflop_0 [157] = tx_packet_data      [145] ;
  assign tx_phy_preflop_0 [158] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [159] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [160] = tx_packet_data      [146] ;
  assign tx_phy_preflop_0 [161] = tx_packet_data      [147] ;
  assign tx_phy_preflop_0 [162] = tx_packet_data      [148] ;
  assign tx_phy_preflop_0 [163] = tx_packet_data      [149] ;
  assign tx_phy_preflop_0 [164] = tx_mrk_userbit[2]         ; // MARKER
  assign tx_phy_preflop_0 [165] = tx_packet_data      [150] ;
  assign tx_phy_preflop_0 [166] = tx_packet_data      [151] ;
  assign tx_phy_preflop_0 [167] = tx_packet_data      [152] ;
  assign tx_phy_preflop_0 [168] = tx_packet_data      [153] ;
  assign tx_phy_preflop_0 [169] = tx_packet_data      [154] ;
  assign tx_phy_preflop_0 [170] = tx_packet_data      [155] ;
  assign tx_phy_preflop_0 [171] = tx_packet_data      [156] ;
  assign tx_phy_preflop_0 [172] = tx_packet_data      [157] ;
  assign tx_phy_preflop_0 [173] = tx_packet_data      [158] ;
  assign tx_phy_preflop_0 [174] = tx_packet_data      [159] ;
  assign tx_phy_preflop_0 [175] = tx_packet_data      [160] ;
  assign tx_phy_preflop_0 [176] = tx_packet_data      [161] ;
  assign tx_phy_preflop_0 [177] = tx_packet_data      [162] ;
  assign tx_phy_preflop_0 [178] = tx_packet_data      [163] ;
  assign tx_phy_preflop_0 [179] = tx_packet_data      [164] ;
  assign tx_phy_preflop_0 [180] = tx_packet_data      [165] ;
  assign tx_phy_preflop_0 [181] = tx_packet_data      [166] ;
  assign tx_phy_preflop_0 [182] = tx_packet_data      [167] ;
  assign tx_phy_preflop_0 [183] = tx_packet_data      [168] ;
  assign tx_phy_preflop_0 [184] = tx_packet_data      [169] ;
  assign tx_phy_preflop_0 [185] = tx_packet_data      [170] ;
  assign tx_phy_preflop_0 [186] = tx_packet_data      [171] ;
  assign tx_phy_preflop_0 [187] = tx_packet_data      [172] ;
  assign tx_phy_preflop_0 [188] = tx_packet_data      [173] ;
  assign tx_phy_preflop_0 [189] = tx_packet_data      [174] ;
  assign tx_phy_preflop_0 [190] = tx_packet_data      [175] ;
  assign tx_phy_preflop_0 [191] = tx_packet_data      [176] ;
  assign tx_phy_preflop_0 [192] = tx_packet_data      [177] ;
  assign tx_phy_preflop_0 [193] = tx_packet_data      [178] ;
  assign tx_phy_preflop_0 [194] = tx_packet_data      [179] ;
  assign tx_phy_preflop_0 [195] = tx_packet_data      [180] ;
  assign tx_phy_preflop_0 [196] = tx_packet_data      [181] ;
  assign tx_phy_preflop_0 [197] = tx_packet_data      [182] ;
  assign tx_phy_preflop_0 [198] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [199] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [200] = tx_packet_data      [183] ;
  assign tx_phy_preflop_0 [201] = tx_packet_data      [184] ;
  assign tx_phy_preflop_0 [202] = tx_packet_data      [185] ;
  assign tx_phy_preflop_0 [203] = tx_packet_data      [186] ;
  assign tx_phy_preflop_0 [204] = tx_packet_data      [187] ;
  assign tx_phy_preflop_0 [205] = tx_packet_data      [188] ;
  assign tx_phy_preflop_0 [206] = tx_packet_data      [189] ;
  assign tx_phy_preflop_0 [207] = tx_packet_data      [190] ;
  assign tx_phy_preflop_0 [208] = tx_packet_data      [191] ;
  assign tx_phy_preflop_0 [209] = tx_packet_data      [192] ;
  assign tx_phy_preflop_0 [210] = tx_packet_data      [193] ;
  assign tx_phy_preflop_0 [211] = tx_packet_data      [194] ;
  assign tx_phy_preflop_0 [212] = tx_packet_data      [195] ;
  assign tx_phy_preflop_0 [213] = tx_packet_data      [196] ;
  assign tx_phy_preflop_0 [214] = tx_packet_data      [197] ;
  assign tx_phy_preflop_0 [215] = tx_packet_data      [198] ;
  assign tx_phy_preflop_0 [216] = tx_packet_data      [199] ;
  assign tx_phy_preflop_0 [217] = tx_packet_data      [200] ;
  assign tx_phy_preflop_0 [218] = tx_packet_data      [201] ;
  assign tx_phy_preflop_0 [219] = tx_packet_data      [202] ;
  assign tx_phy_preflop_0 [220] = tx_packet_data      [203] ;
  assign tx_phy_preflop_0 [221] = tx_packet_data      [204] ;
  assign tx_phy_preflop_0 [222] = tx_packet_data      [205] ;
  assign tx_phy_preflop_0 [223] = tx_packet_data      [206] ;
  assign tx_phy_preflop_0 [224] = tx_packet_data      [207] ;
  assign tx_phy_preflop_0 [225] = tx_packet_data      [208] ;
  assign tx_phy_preflop_0 [226] = tx_packet_data      [209] ;
  assign tx_phy_preflop_0 [227] = tx_packet_data      [210] ;
  assign tx_phy_preflop_0 [228] = tx_packet_data      [211] ;
  assign tx_phy_preflop_0 [229] = tx_packet_data      [212] ;
  assign tx_phy_preflop_0 [230] = tx_packet_data      [213] ;
  assign tx_phy_preflop_0 [231] = tx_packet_data      [214] ;
  assign tx_phy_preflop_0 [232] = tx_packet_data      [215] ;
  assign tx_phy_preflop_0 [233] = tx_packet_data      [216] ;
  assign tx_phy_preflop_0 [234] = tx_packet_data      [217] ;
  assign tx_phy_preflop_0 [235] = tx_packet_data      [218] ;
  assign tx_phy_preflop_0 [236] = tx_packet_data      [219] ;
  assign tx_phy_preflop_0 [237] = tx_packet_data      [220] ;
  assign tx_phy_preflop_0 [238] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [239] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [240] = tx_packet_data      [221] ;
  assign tx_phy_preflop_0 [241] = tx_packet_data      [222] ;
  assign tx_phy_preflop_0 [242] = tx_packet_data      [223] ;
  assign tx_phy_preflop_0 [243] = tx_packet_data      [224] ;
  assign tx_phy_preflop_0 [244] = tx_mrk_userbit[3]         ; // MARKER
  assign tx_phy_preflop_0 [245] = tx_packet_data      [225] ;
  assign tx_phy_preflop_0 [246] = tx_packet_data      [226] ;
  assign tx_phy_preflop_0 [247] = tx_packet_data      [227] ;
  assign tx_phy_preflop_0 [248] = tx_packet_data      [228] ;
  assign tx_phy_preflop_0 [249] = tx_packet_data      [229] ;
  assign tx_phy_preflop_0 [250] = tx_packet_data      [230] ;
  assign tx_phy_preflop_0 [251] = tx_packet_data      [231] ;
  assign tx_phy_preflop_0 [252] = tx_packet_data      [232] ;
  assign tx_phy_preflop_0 [253] = tx_packet_data      [233] ;
  assign tx_phy_preflop_0 [254] = tx_packet_data      [234] ;
  assign tx_phy_preflop_0 [255] = tx_packet_data      [235] ;
  assign tx_phy_preflop_0 [256] = tx_packet_data      [236] ;
  assign tx_phy_preflop_0 [257] = tx_packet_data      [237] ;
  assign tx_phy_preflop_0 [258] = tx_packet_data      [238] ;
  assign tx_phy_preflop_0 [259] = tx_packet_data      [239] ;
  assign tx_phy_preflop_0 [260] = tx_packet_data      [240] ;
  assign tx_phy_preflop_0 [261] = tx_packet_data      [241] ;
  assign tx_phy_preflop_0 [262] = tx_packet_data      [242] ;
  assign tx_phy_preflop_0 [263] = tx_packet_data      [243] ;
  assign tx_phy_preflop_0 [264] = tx_packet_data      [244] ;
  assign tx_phy_preflop_0 [265] = tx_packet_data      [245] ;
  assign tx_phy_preflop_0 [266] = tx_packet_data      [246] ;
  assign tx_phy_preflop_0 [267] = tx_packet_data      [247] ;
  assign tx_phy_preflop_0 [268] = tx_packet_data      [248] ;
  assign tx_phy_preflop_0 [269] = tx_packet_data      [249] ;
  assign tx_phy_preflop_0 [270] = tx_packet_data      [250] ;
  assign tx_phy_preflop_0 [271] = tx_packet_data      [251] ;
  assign tx_phy_preflop_0 [272] = tx_packet_data      [252] ;
  assign tx_phy_preflop_0 [273] = tx_packet_data      [253] ;
  assign tx_phy_preflop_0 [274] = tx_packet_data      [254] ;
  assign tx_phy_preflop_0 [275] = tx_packet_data      [255] ;
  assign tx_phy_preflop_0 [276] = tx_packet_data      [256] ;
  assign tx_phy_preflop_0 [277] = tx_packet_data      [257] ;
  assign tx_phy_preflop_0 [278] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [279] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [280] = tx_packet_data      [258] ;
  assign tx_phy_preflop_0 [281] = tx_packet_data      [259] ;
  assign tx_phy_preflop_0 [282] = tx_packet_data      [260] ;
  assign tx_phy_preflop_0 [283] = tx_packet_data      [261] ;
  assign tx_phy_preflop_0 [284] = tx_packet_data      [262] ;
  assign tx_phy_preflop_0 [285] = tx_packet_data      [263] ;
  assign tx_phy_preflop_0 [286] = tx_packet_data      [264] ;
  assign tx_phy_preflop_0 [287] = tx_packet_data      [265] ;
  assign tx_phy_preflop_0 [288] = tx_packet_data      [266] ;
  assign tx_phy_preflop_0 [289] = tx_packet_data      [267] ;
  assign tx_phy_preflop_0 [290] = tx_packet_data      [268] ;
  assign tx_phy_preflop_0 [291] = tx_packet_data      [269] ;
  assign tx_phy_preflop_0 [292] = tx_packet_data      [270] ;
  assign tx_phy_preflop_0 [293] = tx_packet_data      [271] ;
  assign tx_phy_preflop_0 [294] = tx_packet_data      [272] ;
  assign tx_phy_preflop_0 [295] = tx_packet_data      [273] ;
  assign tx_phy_preflop_0 [296] = tx_packet_data      [274] ;
  assign tx_phy_preflop_0 [297] = tx_packet_data      [275] ;
  assign tx_phy_preflop_0 [298] = tx_packet_data      [276] ;
  assign tx_phy_preflop_0 [299] = tx_packet_data      [277] ;
  assign tx_phy_preflop_0 [300] = tx_packet_data      [278] ;
  assign tx_phy_preflop_0 [301] = tx_packet_data      [279] ;
  assign tx_phy_preflop_0 [302] = tx_packet_data      [280] ;
  assign tx_phy_preflop_0 [303] = tx_packet_data      [281] ;
  assign tx_phy_preflop_0 [304] = tx_packet_data      [282] ;
  assign tx_phy_preflop_0 [305] = tx_packet_data      [283] ;
  assign tx_phy_preflop_0 [306] = tx_packet_data      [284] ;
  assign tx_phy_preflop_0 [307] = tx_packet_data      [285] ;
  assign tx_phy_preflop_0 [308] = tx_packet_data      [286] ;
  assign tx_phy_preflop_0 [309] = tx_packet_data      [287] ;
  assign tx_phy_preflop_0 [310] = tx_packet_data      [288] ;
  assign tx_phy_preflop_0 [311] = tx_packet_data      [289] ;
  assign tx_phy_preflop_0 [312] = tx_packet_data      [290] ;
  assign tx_phy_preflop_0 [313] = tx_packet_data      [291] ;
  assign tx_phy_preflop_0 [314] = tx_packet_data      [292] ;
  assign tx_phy_preflop_0 [315] = tx_packet_data      [293] ;
  assign tx_phy_preflop_0 [316] = tx_packet_data      [294] ;
  assign tx_phy_preflop_0 [317] = tx_packet_data      [295] ;
  assign tx_phy_preflop_0 [318] = 1'b0                      ; // DBI
  assign tx_phy_preflop_0 [319] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [  0] = tx_packet_data      [296] ;
  assign tx_phy_preflop_1 [  1] = tx_packet_data      [297] ;
  assign tx_phy_preflop_1 [  2] = tx_packet_data      [298] ;
  assign tx_phy_preflop_1 [  3] = tx_packet_data      [299] ;
  assign tx_phy_preflop_1 [  4] = tx_mrk_userbit[0]         ; // MARKER
  assign tx_phy_preflop_1 [  5] = tx_packet_data      [300] ;
  assign tx_phy_preflop_1 [  6] = tx_packet_data      [301] ;
  assign tx_phy_preflop_1 [  7] = tx_packet_data      [302] ;
  assign tx_phy_preflop_1 [  8] = tx_packet_data      [303] ;
  assign tx_phy_preflop_1 [  9] = tx_packet_data      [304] ;
  assign tx_phy_preflop_1 [ 10] = tx_packet_data      [305] ;
  assign tx_phy_preflop_1 [ 11] = tx_packet_data      [306] ;
  assign tx_phy_preflop_1 [ 12] = tx_packet_data      [307] ;
  assign tx_phy_preflop_1 [ 13] = tx_packet_data      [308] ;
  assign tx_phy_preflop_1 [ 14] = tx_packet_data      [309] ;
  assign tx_phy_preflop_1 [ 15] = tx_packet_data      [310] ;
  assign tx_phy_preflop_1 [ 16] = tx_packet_data      [311] ;
  assign tx_phy_preflop_1 [ 17] = tx_packet_data      [312] ;
  assign tx_phy_preflop_1 [ 18] = tx_packet_data      [313] ;
  assign tx_phy_preflop_1 [ 19] = tx_packet_data      [314] ;
  assign tx_phy_preflop_1 [ 20] = tx_packet_data      [315] ;
  assign tx_phy_preflop_1 [ 21] = tx_packet_data      [316] ;
  assign tx_phy_preflop_1 [ 22] = tx_packet_data      [317] ;
  assign tx_phy_preflop_1 [ 23] = tx_packet_data      [318] ;
  assign tx_phy_preflop_1 [ 24] = tx_packet_data      [319] ;
  assign tx_phy_preflop_1 [ 25] = tx_packet_data      [320] ;
  assign tx_phy_preflop_1 [ 26] = tx_packet_data      [321] ;
  assign tx_phy_preflop_1 [ 27] = tx_packet_data      [322] ;
  assign tx_phy_preflop_1 [ 28] = tx_packet_data      [323] ;
  assign tx_phy_preflop_1 [ 29] = tx_packet_data      [324] ;
  assign tx_phy_preflop_1 [ 30] = tx_packet_data      [325] ;
  assign tx_phy_preflop_1 [ 31] = tx_packet_data      [326] ;
  assign tx_phy_preflop_1 [ 32] = tx_packet_data      [327] ;
  assign tx_phy_preflop_1 [ 33] = tx_packet_data      [328] ;
  assign tx_phy_preflop_1 [ 34] = tx_packet_data      [329] ;
  assign tx_phy_preflop_1 [ 35] = tx_packet_data      [330] ;
  assign tx_phy_preflop_1 [ 36] = tx_packet_data      [331] ;
  assign tx_phy_preflop_1 [ 37] = tx_packet_data      [332] ;
  assign tx_phy_preflop_1 [ 38] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [ 39] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [ 40] = tx_packet_data      [333] ;
  assign tx_phy_preflop_1 [ 41] = tx_packet_data      [334] ;
  assign tx_phy_preflop_1 [ 42] = tx_packet_data      [335] ;
  assign tx_phy_preflop_1 [ 43] = tx_packet_data      [336] ;
  assign tx_phy_preflop_1 [ 44] = tx_packet_data      [337] ;
  assign tx_phy_preflop_1 [ 45] = tx_packet_data      [338] ;
  assign tx_phy_preflop_1 [ 46] = tx_packet_data      [339] ;
  assign tx_phy_preflop_1 [ 47] = tx_packet_data      [340] ;
  assign tx_phy_preflop_1 [ 48] = tx_packet_data      [341] ;
  assign tx_phy_preflop_1 [ 49] = tx_packet_data      [342] ;
  assign tx_phy_preflop_1 [ 50] = tx_packet_data      [343] ;
  assign tx_phy_preflop_1 [ 51] = tx_packet_data      [344] ;
  assign tx_phy_preflop_1 [ 52] = tx_packet_data      [345] ;
  assign tx_phy_preflop_1 [ 53] = tx_packet_data      [346] ;
  assign tx_phy_preflop_1 [ 54] = tx_packet_data      [347] ;
  assign tx_phy_preflop_1 [ 55] = tx_packet_data      [348] ;
  assign tx_phy_preflop_1 [ 56] = tx_packet_data      [349] ;
  assign tx_phy_preflop_1 [ 57] = tx_packet_data      [350] ;
  assign tx_phy_preflop_1 [ 58] = tx_packet_data      [351] ;
  assign tx_phy_preflop_1 [ 59] = tx_packet_data      [352] ;
  assign tx_phy_preflop_1 [ 60] = tx_packet_data      [353] ;
  assign tx_phy_preflop_1 [ 61] = tx_packet_data      [354] ;
  assign tx_phy_preflop_1 [ 62] = tx_packet_data      [355] ;
  assign tx_phy_preflop_1 [ 63] = tx_packet_data      [356] ;
  assign tx_phy_preflop_1 [ 64] = tx_packet_data      [357] ;
  assign tx_phy_preflop_1 [ 65] = tx_packet_data      [358] ;
  assign tx_phy_preflop_1 [ 66] = tx_packet_data      [359] ;
  assign tx_phy_preflop_1 [ 67] = tx_packet_data      [360] ;
  assign tx_phy_preflop_1 [ 68] = tx_packet_data      [361] ;
  assign tx_phy_preflop_1 [ 69] = tx_packet_data      [362] ;
  assign tx_phy_preflop_1 [ 70] = tx_packet_data      [363] ;
  assign tx_phy_preflop_1 [ 71] = tx_packet_data      [364] ;
  assign tx_phy_preflop_1 [ 72] = tx_packet_data      [365] ;
  assign tx_phy_preflop_1 [ 73] = tx_packet_data      [366] ;
  assign tx_phy_preflop_1 [ 74] = tx_packet_data      [367] ;
  assign tx_phy_preflop_1 [ 75] = tx_packet_data      [368] ;
  assign tx_phy_preflop_1 [ 76] = tx_stb_userbit             ; // STROBE
  assign tx_phy_preflop_1 [ 77] = tx_packet_data      [369] ;
  assign tx_phy_preflop_1 [ 78] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [ 79] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [ 80] = tx_packet_data      [370] ;
  assign tx_phy_preflop_1 [ 81] = tx_packet_data      [371] ;
  assign tx_phy_preflop_1 [ 82] = tx_packet_data      [372] ;
  assign tx_phy_preflop_1 [ 83] = tx_packet_data      [373] ;
  assign tx_phy_preflop_1 [ 84] = tx_mrk_userbit[1]         ; // MARKER
  assign tx_phy_preflop_1 [ 85] = tx_packet_data      [374] ;
  assign tx_phy_preflop_1 [ 86] = tx_packet_data      [375] ;
  assign tx_phy_preflop_1 [ 87] = tx_packet_data      [376] ;
  assign tx_phy_preflop_1 [ 88] = tx_packet_data      [377] ;
  assign tx_phy_preflop_1 [ 89] = tx_packet_data      [378] ;
  assign tx_phy_preflop_1 [ 90] = tx_packet_data      [379] ;
  assign tx_phy_preflop_1 [ 91] = tx_packet_data      [380] ;
  assign tx_phy_preflop_1 [ 92] = tx_packet_data      [381] ;
  assign tx_phy_preflop_1 [ 93] = tx_packet_data      [382] ;
  assign tx_phy_preflop_1 [ 94] = tx_packet_data      [383] ;
  assign tx_phy_preflop_1 [ 95] = tx_packet_data      [384] ;
  assign tx_phy_preflop_1 [ 96] = tx_packet_data      [385] ;
  assign tx_phy_preflop_1 [ 97] = tx_packet_data      [386] ;
  assign tx_phy_preflop_1 [ 98] = tx_packet_data      [387] ;
  assign tx_phy_preflop_1 [ 99] = tx_packet_data      [388] ;
  assign tx_phy_preflop_1 [100] = tx_packet_data      [389] ;
  assign tx_phy_preflop_1 [101] = tx_packet_data      [390] ;
  assign tx_phy_preflop_1 [102] = tx_packet_data      [391] ;
  assign tx_phy_preflop_1 [103] = tx_packet_data      [392] ;
  assign tx_phy_preflop_1 [104] = tx_packet_data      [393] ;
  assign tx_phy_preflop_1 [105] = tx_packet_data      [394] ;
  assign tx_phy_preflop_1 [106] = tx_packet_data      [395] ;
  assign tx_phy_preflop_1 [107] = tx_packet_data      [396] ;
  assign tx_phy_preflop_1 [108] = tx_packet_data      [397] ;
  assign tx_phy_preflop_1 [109] = tx_packet_data      [398] ;
  assign tx_phy_preflop_1 [110] = tx_packet_data      [399] ;
  assign tx_phy_preflop_1 [111] = tx_packet_data      [400] ;
  assign tx_phy_preflop_1 [112] = tx_packet_data      [401] ;
  assign tx_phy_preflop_1 [113] = tx_packet_data      [402] ;
  assign tx_phy_preflop_1 [114] = tx_packet_data      [403] ;
  assign tx_phy_preflop_1 [115] = tx_packet_data      [404] ;
  assign tx_phy_preflop_1 [116] = tx_packet_data      [405] ;
  assign tx_phy_preflop_1 [117] = tx_packet_data      [406] ;
  assign tx_phy_preflop_1 [118] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [119] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [120] = tx_packet_data      [407] ;
  assign tx_phy_preflop_1 [121] = tx_packet_data      [408] ;
  assign tx_phy_preflop_1 [122] = tx_packet_data      [409] ;
  assign tx_phy_preflop_1 [123] = tx_packet_data      [410] ;
  assign tx_phy_preflop_1 [124] = tx_packet_data      [411] ;
  assign tx_phy_preflop_1 [125] = tx_packet_data      [412] ;
  assign tx_phy_preflop_1 [126] = tx_packet_data      [413] ;
  assign tx_phy_preflop_1 [127] = tx_packet_data      [414] ;
  assign tx_phy_preflop_1 [128] = tx_packet_data      [415] ;
  assign tx_phy_preflop_1 [129] = tx_packet_data      [416] ;
  assign tx_phy_preflop_1 [130] = tx_packet_data      [417] ;
  assign tx_phy_preflop_1 [131] = tx_packet_data      [418] ;
  assign tx_phy_preflop_1 [132] = tx_packet_data      [419] ;
  assign tx_phy_preflop_1 [133] = tx_packet_data      [420] ;
  assign tx_phy_preflop_1 [134] = tx_packet_data      [421] ;
  assign tx_phy_preflop_1 [135] = tx_packet_data      [422] ;
  assign tx_phy_preflop_1 [136] = tx_packet_data      [423] ;
  assign tx_phy_preflop_1 [137] = tx_packet_data      [424] ;
  assign tx_phy_preflop_1 [138] = tx_packet_data      [425] ;
  assign tx_phy_preflop_1 [139] = tx_packet_data      [426] ;
  assign tx_phy_preflop_1 [140] = tx_packet_data      [427] ;
  assign tx_phy_preflop_1 [141] = tx_packet_data      [428] ;
  assign tx_phy_preflop_1 [142] = tx_packet_data      [429] ;
  assign tx_phy_preflop_1 [143] = tx_packet_data      [430] ;
  assign tx_phy_preflop_1 [144] = tx_packet_data      [431] ;
  assign tx_phy_preflop_1 [145] = tx_packet_data      [432] ;
  assign tx_phy_preflop_1 [146] = tx_packet_data      [433] ;
  assign tx_phy_preflop_1 [147] = tx_packet_data      [434] ;
  assign tx_phy_preflop_1 [148] = tx_packet_data      [435] ;
  assign tx_phy_preflop_1 [149] = tx_packet_data      [436] ;
  assign tx_phy_preflop_1 [150] = tx_packet_data      [437] ;
  assign tx_phy_preflop_1 [151] = tx_packet_data      [438] ;
  assign tx_phy_preflop_1 [152] = tx_packet_data      [439] ;
  assign tx_phy_preflop_1 [153] = tx_packet_data      [440] ;
  assign tx_phy_preflop_1 [154] = tx_packet_data      [441] ;
  assign tx_phy_preflop_1 [155] = tx_packet_data      [442] ;
  assign tx_phy_preflop_1 [156] = tx_packet_data      [443] ;
  assign tx_phy_preflop_1 [157] = tx_packet_data      [444] ;
  assign tx_phy_preflop_1 [158] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [159] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [160] = tx_packet_data      [445] ;
  assign tx_phy_preflop_1 [161] = tx_packet_data      [446] ;
  assign tx_phy_preflop_1 [162] = tx_packet_data      [447] ;
  assign tx_phy_preflop_1 [163] = tx_packet_data      [448] ;
  assign tx_phy_preflop_1 [164] = tx_mrk_userbit[2]         ; // MARKER
  assign tx_phy_preflop_1 [165] = tx_packet_data      [449] ;
  assign tx_phy_preflop_1 [166] = tx_packet_data      [450] ;
  assign tx_phy_preflop_1 [167] = tx_packet_data      [451] ;
  assign tx_phy_preflop_1 [168] = tx_packet_data      [452] ;
  assign tx_phy_preflop_1 [169] = tx_packet_data      [453] ;
  assign tx_phy_preflop_1 [170] = tx_packet_data      [454] ;
  assign tx_phy_preflop_1 [171] = tx_packet_data      [455] ;
  assign tx_phy_preflop_1 [172] = tx_packet_data      [456] ;
  assign tx_phy_preflop_1 [173] = tx_packet_data      [457] ;
  assign tx_phy_preflop_1 [174] = tx_packet_data      [458] ;
  assign tx_phy_preflop_1 [175] = tx_packet_data      [459] ;
  assign tx_phy_preflop_1 [176] = tx_packet_data      [460] ;
  assign tx_phy_preflop_1 [177] = tx_packet_data      [461] ;
  assign tx_phy_preflop_1 [178] = tx_packet_data      [462] ;
  assign tx_phy_preflop_1 [179] = tx_packet_data      [463] ;
  assign tx_phy_preflop_1 [180] = tx_packet_data      [464] ;
  assign tx_phy_preflop_1 [181] = tx_packet_data      [465] ;
  assign tx_phy_preflop_1 [182] = tx_packet_data      [466] ;
  assign tx_phy_preflop_1 [183] = tx_packet_data      [467] ;
  assign tx_phy_preflop_1 [184] = tx_packet_data      [468] ;
  assign tx_phy_preflop_1 [185] = tx_packet_data      [469] ;
  assign tx_phy_preflop_1 [186] = tx_packet_data      [470] ;
  assign tx_phy_preflop_1 [187] = tx_packet_data      [471] ;
  assign tx_phy_preflop_1 [188] = tx_packet_data      [472] ;
  assign tx_phy_preflop_1 [189] = tx_packet_data      [473] ;
  assign tx_phy_preflop_1 [190] = tx_packet_data      [474] ;
  assign tx_phy_preflop_1 [191] = tx_packet_data      [475] ;
  assign tx_phy_preflop_1 [192] = tx_packet_data      [476] ;
  assign tx_phy_preflop_1 [193] = tx_packet_data      [477] ;
  assign tx_phy_preflop_1 [194] = tx_packet_data      [478] ;
  assign tx_phy_preflop_1 [195] = tx_packet_data      [479] ;
  assign tx_phy_preflop_1 [196] = tx_packet_data      [480] ;
  assign tx_phy_preflop_1 [197] = tx_packet_data      [481] ;
  assign tx_phy_preflop_1 [198] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [199] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [200] = tx_packet_data      [482] ;
  assign tx_phy_preflop_1 [201] = tx_packet_data      [483] ;
  assign tx_phy_preflop_1 [202] = tx_packet_data      [484] ;
  assign tx_phy_preflop_1 [203] = tx_packet_data      [485] ;
  assign tx_phy_preflop_1 [204] = tx_packet_data      [486] ;
  assign tx_phy_preflop_1 [205] = tx_packet_data      [487] ;
  assign tx_phy_preflop_1 [206] = tx_packet_data      [488] ;
  assign tx_phy_preflop_1 [207] = tx_packet_data      [489] ;
  assign tx_phy_preflop_1 [208] = tx_packet_data      [490] ;
  assign tx_phy_preflop_1 [209] = tx_packet_data      [491] ;
  assign tx_phy_preflop_1 [210] = tx_packet_data      [492] ;
  assign tx_phy_preflop_1 [211] = tx_packet_data      [493] ;
  assign tx_phy_preflop_1 [212] = tx_packet_data      [494] ;
  assign tx_phy_preflop_1 [213] = tx_packet_data      [495] ;
  assign tx_phy_preflop_1 [214] = tx_packet_data      [496] ;
  assign tx_phy_preflop_1 [215] = tx_packet_data      [497] ;
  assign tx_phy_preflop_1 [216] = tx_packet_data      [498] ;
  assign tx_phy_preflop_1 [217] = tx_packet_data      [499] ;
  assign tx_phy_preflop_1 [218] = tx_packet_data      [500] ;
  assign tx_phy_preflop_1 [219] = tx_packet_data      [501] ;
  assign tx_phy_preflop_1 [220] = tx_packet_data      [502] ;
  assign tx_phy_preflop_1 [221] = tx_packet_data      [503] ;
  assign tx_phy_preflop_1 [222] = tx_packet_data      [504] ;
  assign tx_phy_preflop_1 [223] = tx_packet_data      [505] ;
  assign tx_phy_preflop_1 [224] = tx_packet_data      [506] ;
  assign tx_phy_preflop_1 [225] = tx_packet_data      [507] ;
  assign tx_phy_preflop_1 [226] = tx_packet_data      [508] ;
  assign tx_phy_preflop_1 [227] = tx_packet_data      [509] ;
  assign tx_phy_preflop_1 [228] = tx_packet_data      [510] ;
  assign tx_phy_preflop_1 [229] = tx_packet_data      [511] ;
  assign tx_phy_preflop_1 [230] = tx_packet_data      [512] ;
  assign tx_phy_preflop_1 [231] = tx_packet_data      [513] ;
  assign tx_phy_preflop_1 [232] = tx_packet_data      [514] ;
  assign tx_phy_preflop_1 [233] = tx_packet_data      [515] ;
  assign tx_phy_preflop_1 [234] = tx_packet_data      [516] ;
  assign tx_phy_preflop_1 [235] = tx_packet_data      [517] ;
  assign tx_phy_preflop_1 [236] = tx_packet_data      [518] ;
  assign tx_phy_preflop_1 [237] = tx_packet_data      [519] ;
  assign tx_phy_preflop_1 [238] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [239] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [240] = tx_packet_data      [520] ;
  assign tx_phy_preflop_1 [241] = tx_packet_data      [521] ;
  assign tx_phy_preflop_1 [242] = tx_packet_data      [522] ;
  assign tx_phy_preflop_1 [243] = tx_packet_data      [523] ;
  assign tx_phy_preflop_1 [244] = tx_mrk_userbit[3]         ; // MARKER
  assign tx_phy_preflop_1 [245] = tx_packet_data      [524] ;
  assign tx_phy_preflop_1 [246] = tx_packet_data      [525] ;
  assign tx_phy_preflop_1 [247] = tx_packet_data      [526] ;
  assign tx_phy_preflop_1 [248] = tx_packet_data      [527] ;
  assign tx_phy_preflop_1 [249] = tx_packet_data      [528] ;
  assign tx_phy_preflop_1 [250] = tx_packet_data      [529] ;
  assign tx_phy_preflop_1 [251] = tx_packet_data      [530] ;
  assign tx_phy_preflop_1 [252] = tx_packet_data      [531] ;
  assign tx_phy_preflop_1 [253] = tx_packet_data      [532] ;
  assign tx_phy_preflop_1 [254] = tx_packet_data      [533] ;
  assign tx_phy_preflop_1 [255] = tx_packet_data      [534] ;
  assign tx_phy_preflop_1 [256] = tx_packet_data      [535] ;
  assign tx_phy_preflop_1 [257] = tx_packet_data      [536] ;
  assign tx_phy_preflop_1 [258] = tx_packet_data      [537] ;
  assign tx_phy_preflop_1 [259] = tx_packet_data      [538] ;
  assign tx_phy_preflop_1 [260] = tx_packet_data      [539] ;
  assign tx_phy_preflop_1 [261] = tx_packet_data      [540] ;
  assign tx_phy_preflop_1 [262] = tx_packet_data      [541] ;
  assign tx_phy_preflop_1 [263] = tx_packet_data      [542] ;
  assign tx_phy_preflop_1 [264] = tx_packet_data      [543] ;
  assign tx_phy_preflop_1 [265] = tx_packet_data      [544] ;
  assign tx_phy_preflop_1 [266] = tx_packet_data      [545] ;
  assign tx_phy_preflop_1 [267] = tx_packet_data      [546] ;
  assign tx_phy_preflop_1 [268] = tx_packet_data      [547] ;
  assign tx_phy_preflop_1 [269] = tx_packet_data      [548] ;
  assign tx_phy_preflop_1 [270] = tx_packet_data      [549] ;
  assign tx_phy_preflop_1 [271] = tx_packet_data      [550] ;
  assign tx_phy_preflop_1 [272] = tx_packet_data      [551] ;
  assign tx_phy_preflop_1 [273] = tx_packet_data      [552] ;
  assign tx_phy_preflop_1 [274] = tx_packet_data      [553] ;
  assign tx_phy_preflop_1 [275] = tx_packet_data      [554] ;
  assign tx_phy_preflop_1 [276] = tx_packet_data      [555] ;
  assign tx_phy_preflop_1 [277] = tx_packet_data      [556] ;
  assign tx_phy_preflop_1 [278] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [279] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [280] = tx_packet_data      [557] ;
  assign tx_phy_preflop_1 [281] = tx_packet_data      [558] ;
  assign tx_phy_preflop_1 [282] = tx_packet_data      [559] ;
  assign tx_phy_preflop_1 [283] = tx_packet_data      [560] ;
  assign tx_phy_preflop_1 [284] = tx_packet_data      [561] ;
  assign tx_phy_preflop_1 [285] = tx_packet_data      [562] ;
  assign tx_phy_preflop_1 [286] = tx_packet_data      [563] ;
  assign tx_phy_preflop_1 [287] = tx_packet_data      [564] ;
  assign tx_phy_preflop_1 [288] = tx_packet_data      [565] ;
  assign tx_phy_preflop_1 [289] = tx_packet_data      [566] ;
  assign tx_phy_preflop_1 [290] = tx_packet_data      [567] ;
  assign tx_phy_preflop_1 [291] = tx_packet_data      [568] ;
  assign tx_phy_preflop_1 [292] = tx_packet_data      [569] ;
  assign tx_phy_preflop_1 [293] = tx_packet_data      [570] ;
  assign tx_phy_preflop_1 [294] = tx_packet_data      [571] ;
  assign tx_phy_preflop_1 [295] = tx_packet_data      [572] ;
  assign tx_phy_preflop_1 [296] = tx_packet_data      [573] ;
  assign tx_phy_preflop_1 [297] = tx_packet_data      [574] ;
  assign tx_phy_preflop_1 [298] = tx_packet_data      [575] ;
  assign tx_phy_preflop_1 [299] = tx_packet_data      [576] ;
  assign tx_phy_preflop_1 [300] = tx_packet_data      [577] ;
  assign tx_phy_preflop_1 [301] = tx_packet_data      [578] ;
  assign tx_phy_preflop_1 [302] = tx_packet_data      [579] ;
  assign tx_phy_preflop_1 [303] = tx_packet_data      [580] ;
  assign tx_phy_preflop_1 [304] = tx_packet_data      [581] ;
  assign tx_phy_preflop_1 [305] = tx_packet_data      [582] ;
  assign tx_phy_preflop_1 [306] = tx_ch0_ar_credit          ;
  assign tx_phy_preflop_1 [307] = tx_ch0_aw_credit          ;
  assign tx_phy_preflop_1 [308] = tx_ch0_w_credit           ;
  assign tx_phy_preflop_1 [309] = tx_ch1_ar_credit          ;
  assign tx_phy_preflop_1 [310] = tx_ch1_aw_credit          ;
  assign tx_phy_preflop_1 [311] = tx_ch1_w_credit           ;
  assign tx_phy_preflop_1 [312] = tx_ch2_ar_credit          ;
  assign tx_phy_preflop_1 [313] = tx_ch2_aw_credit          ;
  assign tx_phy_preflop_1 [314] = tx_ch2_w_credit           ;
  assign tx_phy_preflop_1 [315] = tx_ch3_ar_credit          ;
  assign tx_phy_preflop_1 [316] = tx_ch3_aw_credit          ;
  assign tx_phy_preflop_1 [317] = tx_ch3_w_credit           ;
  assign tx_phy_preflop_1 [318] = 1'b0                      ; // DBI
  assign tx_phy_preflop_1 [319] = 1'b0                      ; // DBI
// TX Section
////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// RX Section

//   RX_CH_WIDTH           = 320; // Gen2 running at Quarter Rate
//   RX_DATA_WIDTH         = 299; // Usable Data per Channel
//   RX_PERSISTENT_STROBE  = 1'b1;
//   RX_PERSISTENT_MARKER  = 1'b1;
//   RX_STROBE_GEN2_LOC    = 'd76;
//   RX_MARKER_GEN2_LOC    = 'd4;
//   RX_STROBE_GEN1_LOC    = 'd38;
//   RX_MARKER_GEN1_LOC    = 'd39;
//   RX_ENABLE_STROBE      = 1'b1;
//   RX_ENABLE_MARKER      = 1'b1;
//   RX_DBI_PRESENT        = 1'b1;
//   RX_REG_PHY            = 1'b0;

  localparam RX_REG_PHY    = 1'b0;

  logic [319:  0]                                rx_phy_postflop_0             ;
  logic [319:  0]                                rx_phy_postflop_1             ;
  logic [319:  0]                                rx_phy_flop_0_reg             ;
  logic [319:  0]                                rx_phy_flop_1_reg             ;

  always_ff @(posedge clk_rd or negedge rst_rd_n)
  if (~rst_rd_n)
  begin
    rx_phy_flop_0_reg                     <= 320'b0                                ;
    rx_phy_flop_1_reg                     <= 320'b0                                ;
  end
  else
  begin
    rx_phy_flop_0_reg                     <= rx_phy0                               ;
    rx_phy_flop_1_reg                     <= rx_phy1                               ;
  end


  assign rx_phy_postflop_0                = RX_REG_PHY ? rx_phy_flop_0_reg : rx_phy0             ;
  assign rx_phy_postflop_1                = RX_REG_PHY ? rx_phy_flop_1_reg : rx_phy1             ;

  assign rx_ch0_ar_pushbit         = rx_phy_postflop_0 [  0];
  assign rx_ch0_ar_data      [  0] = rx_phy_postflop_0 [  1];
  assign rx_ch0_ar_data      [  1] = rx_phy_postflop_0 [  2];
  assign rx_ch0_ar_data      [  2] = rx_phy_postflop_0 [  3];
//       MARKER                    = rx_phy_postflop_0 [  4]
  assign rx_ch0_ar_data      [  3] = rx_phy_postflop_0 [  5];
  assign rx_ch0_ar_data      [  4] = rx_phy_postflop_0 [  6];
  assign rx_ch0_ar_data      [  5] = rx_phy_postflop_0 [  7];
  assign rx_ch0_ar_data      [  6] = rx_phy_postflop_0 [  8];
  assign rx_ch0_ar_data      [  7] = rx_phy_postflop_0 [  9];
  assign rx_ch0_ar_data      [  8] = rx_phy_postflop_0 [ 10];
  assign rx_ch0_ar_data      [  9] = rx_phy_postflop_0 [ 11];
  assign rx_ch0_ar_data      [ 10] = rx_phy_postflop_0 [ 12];
  assign rx_ch0_ar_data      [ 11] = rx_phy_postflop_0 [ 13];
  assign rx_ch0_ar_data      [ 12] = rx_phy_postflop_0 [ 14];
  assign rx_ch0_ar_data      [ 13] = rx_phy_postflop_0 [ 15];
  assign rx_ch0_ar_data      [ 14] = rx_phy_postflop_0 [ 16];
  assign rx_ch0_ar_data      [ 15] = rx_phy_postflop_0 [ 17];
  assign rx_ch0_ar_data      [ 16] = rx_phy_postflop_0 [ 18];
  assign rx_ch0_ar_data      [ 17] = rx_phy_postflop_0 [ 19];
  assign rx_ch0_ar_data      [ 18] = rx_phy_postflop_0 [ 20];
  assign rx_ch0_ar_data      [ 19] = rx_phy_postflop_0 [ 21];
  assign rx_ch0_ar_data      [ 20] = rx_phy_postflop_0 [ 22];
  assign rx_ch0_ar_data      [ 21] = rx_phy_postflop_0 [ 23];
  assign rx_ch0_ar_data      [ 22] = rx_phy_postflop_0 [ 24];
  assign rx_ch0_ar_data      [ 23] = rx_phy_postflop_0 [ 25];
  assign rx_ch0_ar_data      [ 24] = rx_phy_postflop_0 [ 26];
  assign rx_ch0_ar_data      [ 25] = rx_phy_postflop_0 [ 27];
  assign rx_ch0_ar_data      [ 26] = rx_phy_postflop_0 [ 28];
  assign rx_ch0_ar_data      [ 27] = rx_phy_postflop_0 [ 29];
  assign rx_ch0_ar_data      [ 28] = rx_phy_postflop_0 [ 30];
  assign rx_ch0_ar_data      [ 29] = rx_phy_postflop_0 [ 31];
  assign rx_ch0_ar_data      [ 30] = rx_phy_postflop_0 [ 32];
  assign rx_ch0_ar_data      [ 31] = rx_phy_postflop_0 [ 33];
  assign rx_ch0_ar_data      [ 32] = rx_phy_postflop_0 [ 34];
  assign rx_ch0_ar_data      [ 33] = rx_phy_postflop_0 [ 35];
  assign rx_ch0_ar_data      [ 34] = rx_phy_postflop_0 [ 36];
  assign rx_ch0_ar_data      [ 35] = rx_phy_postflop_0 [ 37];
//       DBI                       = rx_phy_postflop_0 [ 38];
//       DBI                       = rx_phy_postflop_0 [ 39];
  assign rx_ch0_ar_data      [ 36] = rx_phy_postflop_0 [ 40];
  assign rx_ch0_ar_data      [ 37] = rx_phy_postflop_0 [ 41];
  assign rx_ch0_ar_data      [ 38] = rx_phy_postflop_0 [ 42];
  assign rx_ch0_ar_data      [ 39] = rx_phy_postflop_0 [ 43];
  assign rx_ch0_ar_data      [ 40] = rx_phy_postflop_0 [ 44];
  assign rx_ch0_ar_data      [ 41] = rx_phy_postflop_0 [ 45];
  assign rx_ch0_ar_data      [ 42] = rx_phy_postflop_0 [ 46];
  assign rx_ch0_ar_data      [ 43] = rx_phy_postflop_0 [ 47];
  assign rx_ch0_aw_pushbit         = rx_phy_postflop_0 [ 48];
  assign rx_ch0_aw_data      [  0] = rx_phy_postflop_0 [ 49];
  assign rx_ch0_aw_data      [  1] = rx_phy_postflop_0 [ 50];
  assign rx_ch0_aw_data      [  2] = rx_phy_postflop_0 [ 51];
  assign rx_ch0_aw_data      [  3] = rx_phy_postflop_0 [ 52];
  assign rx_ch0_aw_data      [  4] = rx_phy_postflop_0 [ 53];
  assign rx_ch0_aw_data      [  5] = rx_phy_postflop_0 [ 54];
  assign rx_ch0_aw_data      [  6] = rx_phy_postflop_0 [ 55];
  assign rx_ch0_aw_data      [  7] = rx_phy_postflop_0 [ 56];
  assign rx_ch0_aw_data      [  8] = rx_phy_postflop_0 [ 57];
  assign rx_ch0_aw_data      [  9] = rx_phy_postflop_0 [ 58];
  assign rx_ch0_aw_data      [ 10] = rx_phy_postflop_0 [ 59];
  assign rx_ch0_aw_data      [ 11] = rx_phy_postflop_0 [ 60];
  assign rx_ch0_aw_data      [ 12] = rx_phy_postflop_0 [ 61];
  assign rx_ch0_aw_data      [ 13] = rx_phy_postflop_0 [ 62];
  assign rx_ch0_aw_data      [ 14] = rx_phy_postflop_0 [ 63];
  assign rx_ch0_aw_data      [ 15] = rx_phy_postflop_0 [ 64];
  assign rx_ch0_aw_data      [ 16] = rx_phy_postflop_0 [ 65];
  assign rx_ch0_aw_data      [ 17] = rx_phy_postflop_0 [ 66];
  assign rx_ch0_aw_data      [ 18] = rx_phy_postflop_0 [ 67];
  assign rx_ch0_aw_data      [ 19] = rx_phy_postflop_0 [ 68];
  assign rx_ch0_aw_data      [ 20] = rx_phy_postflop_0 [ 69];
  assign rx_ch0_aw_data      [ 21] = rx_phy_postflop_0 [ 70];
  assign rx_ch0_aw_data      [ 22] = rx_phy_postflop_0 [ 71];
  assign rx_ch0_aw_data      [ 23] = rx_phy_postflop_0 [ 72];
  assign rx_ch0_aw_data      [ 24] = rx_phy_postflop_0 [ 73];
  assign rx_ch0_aw_data      [ 25] = rx_phy_postflop_0 [ 74];
  assign rx_ch0_aw_data      [ 26] = rx_phy_postflop_0 [ 75];
//       STROBE                    = rx_phy_postflop_0 [ 76]
  assign rx_ch0_aw_data      [ 27] = rx_phy_postflop_0 [ 77];
//       DBI                       = rx_phy_postflop_0 [ 78];
//       DBI                       = rx_phy_postflop_0 [ 79];
  assign rx_ch0_aw_data      [ 28] = rx_phy_postflop_0 [ 80];
  assign rx_ch0_aw_data      [ 29] = rx_phy_postflop_0 [ 81];
  assign rx_ch0_aw_data      [ 30] = rx_phy_postflop_0 [ 82];
  assign rx_ch0_aw_data      [ 31] = rx_phy_postflop_0 [ 83];
//       MARKER                    = rx_phy_postflop_0 [ 84]
  assign rx_ch0_aw_data      [ 32] = rx_phy_postflop_0 [ 85];
  assign rx_ch0_aw_data      [ 33] = rx_phy_postflop_0 [ 86];
  assign rx_ch0_aw_data      [ 34] = rx_phy_postflop_0 [ 87];
  assign rx_ch0_aw_data      [ 35] = rx_phy_postflop_0 [ 88];
  assign rx_ch0_aw_data      [ 36] = rx_phy_postflop_0 [ 89];
  assign rx_ch0_aw_data      [ 37] = rx_phy_postflop_0 [ 90];
  assign rx_ch0_aw_data      [ 38] = rx_phy_postflop_0 [ 91];
  assign rx_ch0_aw_data      [ 39] = rx_phy_postflop_0 [ 92];
  assign rx_ch0_aw_data      [ 40] = rx_phy_postflop_0 [ 93];
  assign rx_ch0_aw_data      [ 41] = rx_phy_postflop_0 [ 94];
  assign rx_ch0_aw_data      [ 42] = rx_phy_postflop_0 [ 95];
  assign rx_ch0_aw_data      [ 43] = rx_phy_postflop_0 [ 96];
  assign rx_ch0_w_pushbit          = rx_phy_postflop_0 [ 97];
  assign rx_ch0_w_data       [  0] = rx_phy_postflop_0 [ 98];
  assign rx_ch0_w_data       [  1] = rx_phy_postflop_0 [ 99];
  assign rx_ch0_w_data       [  2] = rx_phy_postflop_0 [100];
  assign rx_ch0_w_data       [  3] = rx_phy_postflop_0 [101];
  assign rx_ch0_w_data       [  4] = rx_phy_postflop_0 [102];
  assign rx_ch0_w_data       [  5] = rx_phy_postflop_0 [103];
  assign rx_ch0_w_data       [  6] = rx_phy_postflop_0 [104];
  assign rx_ch0_w_data       [  7] = rx_phy_postflop_0 [105];
  assign rx_ch0_w_data       [  8] = rx_phy_postflop_0 [106];
  assign rx_ch0_w_data       [  9] = rx_phy_postflop_0 [107];
  assign rx_ch0_w_data       [ 10] = rx_phy_postflop_0 [108];
  assign rx_ch0_w_data       [ 11] = rx_phy_postflop_0 [109];
  assign rx_ch0_w_data       [ 12] = rx_phy_postflop_0 [110];
  assign rx_ch0_w_data       [ 13] = rx_phy_postflop_0 [111];
  assign rx_ch0_w_data       [ 14] = rx_phy_postflop_0 [112];
  assign rx_ch0_w_data       [ 15] = rx_phy_postflop_0 [113];
  assign rx_ch0_w_data       [ 16] = rx_phy_postflop_0 [114];
  assign rx_ch0_w_data       [ 17] = rx_phy_postflop_0 [115];
  assign rx_ch0_w_data       [ 18] = rx_phy_postflop_0 [116];
  assign rx_ch0_w_data       [ 19] = rx_phy_postflop_0 [117];
//       DBI                       = rx_phy_postflop_0 [118];
//       DBI                       = rx_phy_postflop_0 [119];
  assign rx_ch0_w_data       [ 20] = rx_phy_postflop_0 [120];
  assign rx_ch0_w_data       [ 21] = rx_phy_postflop_0 [121];
  assign rx_ch0_w_data       [ 22] = rx_phy_postflop_0 [122];
  assign rx_ch0_w_data       [ 23] = rx_phy_postflop_0 [123];
  assign rx_ch0_w_data       [ 24] = rx_phy_postflop_0 [124];
  assign rx_ch0_w_data       [ 25] = rx_phy_postflop_0 [125];
  assign rx_ch0_w_data       [ 26] = rx_phy_postflop_0 [126];
  assign rx_ch0_w_data       [ 27] = rx_phy_postflop_0 [127];
  assign rx_ch0_w_data       [ 28] = rx_phy_postflop_0 [128];
  assign rx_ch0_w_data       [ 29] = rx_phy_postflop_0 [129];
  assign rx_ch0_w_data       [ 30] = rx_phy_postflop_0 [130];
  assign rx_ch0_w_data       [ 31] = rx_phy_postflop_0 [131];
  assign rx_ch0_w_data       [ 32] = rx_phy_postflop_0 [132];
  assign rx_ch0_w_data       [ 33] = rx_phy_postflop_0 [133];
  assign rx_ch0_w_data       [ 34] = rx_phy_postflop_0 [134];
  assign rx_ch0_w_data       [ 35] = rx_phy_postflop_0 [135];
  assign rx_ch0_w_data       [ 36] = rx_phy_postflop_0 [136];
  assign rx_ch0_w_data       [ 37] = rx_phy_postflop_0 [137];
  assign rx_ch0_w_data       [ 38] = rx_phy_postflop_0 [138];
  assign rx_ch0_w_data       [ 39] = rx_phy_postflop_0 [139];
  assign rx_ch0_w_data       [ 40] = rx_phy_postflop_0 [140];
  assign rx_ch0_w_data       [ 41] = rx_phy_postflop_0 [141];
  assign rx_ch0_w_data       [ 42] = rx_phy_postflop_0 [142];
  assign rx_ch0_w_data       [ 43] = rx_phy_postflop_0 [143];
  assign rx_ch0_w_data       [ 44] = rx_phy_postflop_0 [144];
  assign rx_ch0_w_data       [ 45] = rx_phy_postflop_0 [145];
  assign rx_ch0_w_data       [ 46] = rx_phy_postflop_0 [146];
  assign rx_ch0_w_data       [ 47] = rx_phy_postflop_0 [147];
  assign rx_ch0_w_data       [ 48] = rx_phy_postflop_0 [148];
  assign rx_ch0_r_credit           = rx_phy_postflop_0 [149];
  assign rx_ch0_b_credit           = rx_phy_postflop_0 [150];
  assign rx_ch1_ar_pushbit         = rx_phy_postflop_0 [151];
  assign rx_ch1_ar_data      [  0] = rx_phy_postflop_0 [152];
  assign rx_ch1_ar_data      [  1] = rx_phy_postflop_0 [153];
  assign rx_ch1_ar_data      [  2] = rx_phy_postflop_0 [154];
  assign rx_ch1_ar_data      [  3] = rx_phy_postflop_0 [155];
  assign rx_ch1_ar_data      [  4] = rx_phy_postflop_0 [156];
  assign rx_ch1_ar_data      [  5] = rx_phy_postflop_0 [157];
//       DBI                       = rx_phy_postflop_0 [158];
//       DBI                       = rx_phy_postflop_0 [159];
  assign rx_ch1_ar_data      [  6] = rx_phy_postflop_0 [160];
  assign rx_ch1_ar_data      [  7] = rx_phy_postflop_0 [161];
  assign rx_ch1_ar_data      [  8] = rx_phy_postflop_0 [162];
  assign rx_ch1_ar_data      [  9] = rx_phy_postflop_0 [163];
//       MARKER                    = rx_phy_postflop_0 [164]
  assign rx_ch1_ar_data      [ 10] = rx_phy_postflop_0 [165];
  assign rx_ch1_ar_data      [ 11] = rx_phy_postflop_0 [166];
  assign rx_ch1_ar_data      [ 12] = rx_phy_postflop_0 [167];
  assign rx_ch1_ar_data      [ 13] = rx_phy_postflop_0 [168];
  assign rx_ch1_ar_data      [ 14] = rx_phy_postflop_0 [169];
  assign rx_ch1_ar_data      [ 15] = rx_phy_postflop_0 [170];
  assign rx_ch1_ar_data      [ 16] = rx_phy_postflop_0 [171];
  assign rx_ch1_ar_data      [ 17] = rx_phy_postflop_0 [172];
  assign rx_ch1_ar_data      [ 18] = rx_phy_postflop_0 [173];
  assign rx_ch1_ar_data      [ 19] = rx_phy_postflop_0 [174];
  assign rx_ch1_ar_data      [ 20] = rx_phy_postflop_0 [175];
  assign rx_ch1_ar_data      [ 21] = rx_phy_postflop_0 [176];
  assign rx_ch1_ar_data      [ 22] = rx_phy_postflop_0 [177];
  assign rx_ch1_ar_data      [ 23] = rx_phy_postflop_0 [178];
  assign rx_ch1_ar_data      [ 24] = rx_phy_postflop_0 [179];
  assign rx_ch1_ar_data      [ 25] = rx_phy_postflop_0 [180];
  assign rx_ch1_ar_data      [ 26] = rx_phy_postflop_0 [181];
  assign rx_ch1_ar_data      [ 27] = rx_phy_postflop_0 [182];
  assign rx_ch1_ar_data      [ 28] = rx_phy_postflop_0 [183];
  assign rx_ch1_ar_data      [ 29] = rx_phy_postflop_0 [184];
  assign rx_ch1_ar_data      [ 30] = rx_phy_postflop_0 [185];
  assign rx_ch1_ar_data      [ 31] = rx_phy_postflop_0 [186];
  assign rx_ch1_ar_data      [ 32] = rx_phy_postflop_0 [187];
  assign rx_ch1_ar_data      [ 33] = rx_phy_postflop_0 [188];
  assign rx_ch1_ar_data      [ 34] = rx_phy_postflop_0 [189];
  assign rx_ch1_ar_data      [ 35] = rx_phy_postflop_0 [190];
  assign rx_ch1_ar_data      [ 36] = rx_phy_postflop_0 [191];
  assign rx_ch1_ar_data      [ 37] = rx_phy_postflop_0 [192];
  assign rx_ch1_ar_data      [ 38] = rx_phy_postflop_0 [193];
  assign rx_ch1_ar_data      [ 39] = rx_phy_postflop_0 [194];
  assign rx_ch1_ar_data      [ 40] = rx_phy_postflop_0 [195];
  assign rx_ch1_ar_data      [ 41] = rx_phy_postflop_0 [196];
  assign rx_ch1_ar_data      [ 42] = rx_phy_postflop_0 [197];
//       DBI                       = rx_phy_postflop_0 [198];
//       DBI                       = rx_phy_postflop_0 [199];
  assign rx_ch1_ar_data      [ 43] = rx_phy_postflop_0 [200];
  assign rx_ch1_aw_pushbit         = rx_phy_postflop_0 [201];
  assign rx_ch1_aw_data      [  0] = rx_phy_postflop_0 [202];
  assign rx_ch1_aw_data      [  1] = rx_phy_postflop_0 [203];
  assign rx_ch1_aw_data      [  2] = rx_phy_postflop_0 [204];
  assign rx_ch1_aw_data      [  3] = rx_phy_postflop_0 [205];
  assign rx_ch1_aw_data      [  4] = rx_phy_postflop_0 [206];
  assign rx_ch1_aw_data      [  5] = rx_phy_postflop_0 [207];
  assign rx_ch1_aw_data      [  6] = rx_phy_postflop_0 [208];
  assign rx_ch1_aw_data      [  7] = rx_phy_postflop_0 [209];
  assign rx_ch1_aw_data      [  8] = rx_phy_postflop_0 [210];
  assign rx_ch1_aw_data      [  9] = rx_phy_postflop_0 [211];
  assign rx_ch1_aw_data      [ 10] = rx_phy_postflop_0 [212];
  assign rx_ch1_aw_data      [ 11] = rx_phy_postflop_0 [213];
  assign rx_ch1_aw_data      [ 12] = rx_phy_postflop_0 [214];
  assign rx_ch1_aw_data      [ 13] = rx_phy_postflop_0 [215];
  assign rx_ch1_aw_data      [ 14] = rx_phy_postflop_0 [216];
  assign rx_ch1_aw_data      [ 15] = rx_phy_postflop_0 [217];
  assign rx_ch1_aw_data      [ 16] = rx_phy_postflop_0 [218];
  assign rx_ch1_aw_data      [ 17] = rx_phy_postflop_0 [219];
  assign rx_ch1_aw_data      [ 18] = rx_phy_postflop_0 [220];
  assign rx_ch1_aw_data      [ 19] = rx_phy_postflop_0 [221];
  assign rx_ch1_aw_data      [ 20] = rx_phy_postflop_0 [222];
  assign rx_ch1_aw_data      [ 21] = rx_phy_postflop_0 [223];
  assign rx_ch1_aw_data      [ 22] = rx_phy_postflop_0 [224];
  assign rx_ch1_aw_data      [ 23] = rx_phy_postflop_0 [225];
  assign rx_ch1_aw_data      [ 24] = rx_phy_postflop_0 [226];
  assign rx_ch1_aw_data      [ 25] = rx_phy_postflop_0 [227];
  assign rx_ch1_aw_data      [ 26] = rx_phy_postflop_0 [228];
  assign rx_ch1_aw_data      [ 27] = rx_phy_postflop_0 [229];
  assign rx_ch1_aw_data      [ 28] = rx_phy_postflop_0 [230];
  assign rx_ch1_aw_data      [ 29] = rx_phy_postflop_0 [231];
  assign rx_ch1_aw_data      [ 30] = rx_phy_postflop_0 [232];
  assign rx_ch1_aw_data      [ 31] = rx_phy_postflop_0 [233];
  assign rx_ch1_aw_data      [ 32] = rx_phy_postflop_0 [234];
  assign rx_ch1_aw_data      [ 33] = rx_phy_postflop_0 [235];
  assign rx_ch1_aw_data      [ 34] = rx_phy_postflop_0 [236];
  assign rx_ch1_aw_data      [ 35] = rx_phy_postflop_0 [237];
//       DBI                       = rx_phy_postflop_0 [238];
//       DBI                       = rx_phy_postflop_0 [239];
  assign rx_ch1_aw_data      [ 36] = rx_phy_postflop_0 [240];
  assign rx_ch1_aw_data      [ 37] = rx_phy_postflop_0 [241];
  assign rx_ch1_aw_data      [ 38] = rx_phy_postflop_0 [242];
  assign rx_ch1_aw_data      [ 39] = rx_phy_postflop_0 [243];
//       MARKER                    = rx_phy_postflop_0 [244]
  assign rx_ch1_aw_data      [ 40] = rx_phy_postflop_0 [245];
  assign rx_ch1_aw_data      [ 41] = rx_phy_postflop_0 [246];
  assign rx_ch1_aw_data      [ 42] = rx_phy_postflop_0 [247];
  assign rx_ch1_aw_data      [ 43] = rx_phy_postflop_0 [248];
  assign rx_ch1_w_pushbit          = rx_phy_postflop_0 [249];
  assign rx_ch1_w_data       [  0] = rx_phy_postflop_0 [250];
  assign rx_ch1_w_data       [  1] = rx_phy_postflop_0 [251];
  assign rx_ch1_w_data       [  2] = rx_phy_postflop_0 [252];
  assign rx_ch1_w_data       [  3] = rx_phy_postflop_0 [253];
  assign rx_ch1_w_data       [  4] = rx_phy_postflop_0 [254];
  assign rx_ch1_w_data       [  5] = rx_phy_postflop_0 [255];
  assign rx_ch1_w_data       [  6] = rx_phy_postflop_0 [256];
  assign rx_ch1_w_data       [  7] = rx_phy_postflop_0 [257];
  assign rx_ch1_w_data       [  8] = rx_phy_postflop_0 [258];
  assign rx_ch1_w_data       [  9] = rx_phy_postflop_0 [259];
  assign rx_ch1_w_data       [ 10] = rx_phy_postflop_0 [260];
  assign rx_ch1_w_data       [ 11] = rx_phy_postflop_0 [261];
  assign rx_ch1_w_data       [ 12] = rx_phy_postflop_0 [262];
  assign rx_ch1_w_data       [ 13] = rx_phy_postflop_0 [263];
  assign rx_ch1_w_data       [ 14] = rx_phy_postflop_0 [264];
  assign rx_ch1_w_data       [ 15] = rx_phy_postflop_0 [265];
  assign rx_ch1_w_data       [ 16] = rx_phy_postflop_0 [266];
  assign rx_ch1_w_data       [ 17] = rx_phy_postflop_0 [267];
  assign rx_ch1_w_data       [ 18] = rx_phy_postflop_0 [268];
  assign rx_ch1_w_data       [ 19] = rx_phy_postflop_0 [269];
  assign rx_ch1_w_data       [ 20] = rx_phy_postflop_0 [270];
  assign rx_ch1_w_data       [ 21] = rx_phy_postflop_0 [271];
  assign rx_ch1_w_data       [ 22] = rx_phy_postflop_0 [272];
  assign rx_ch1_w_data       [ 23] = rx_phy_postflop_0 [273];
  assign rx_ch1_w_data       [ 24] = rx_phy_postflop_0 [274];
  assign rx_ch1_w_data       [ 25] = rx_phy_postflop_0 [275];
  assign rx_ch1_w_data       [ 26] = rx_phy_postflop_0 [276];
  assign rx_ch1_w_data       [ 27] = rx_phy_postflop_0 [277];
//       DBI                       = rx_phy_postflop_0 [278];
//       DBI                       = rx_phy_postflop_0 [279];
  assign rx_ch1_w_data       [ 28] = rx_phy_postflop_0 [280];
  assign rx_ch1_w_data       [ 29] = rx_phy_postflop_0 [281];
  assign rx_ch1_w_data       [ 30] = rx_phy_postflop_0 [282];
  assign rx_ch1_w_data       [ 31] = rx_phy_postflop_0 [283];
  assign rx_ch1_w_data       [ 32] = rx_phy_postflop_0 [284];
  assign rx_ch1_w_data       [ 33] = rx_phy_postflop_0 [285];
  assign rx_ch1_w_data       [ 34] = rx_phy_postflop_0 [286];
  assign rx_ch1_w_data       [ 35] = rx_phy_postflop_0 [287];
  assign rx_ch1_w_data       [ 36] = rx_phy_postflop_0 [288];
  assign rx_ch1_w_data       [ 37] = rx_phy_postflop_0 [289];
  assign rx_ch1_w_data       [ 38] = rx_phy_postflop_0 [290];
  assign rx_ch1_w_data       [ 39] = rx_phy_postflop_0 [291];
  assign rx_ch1_w_data       [ 40] = rx_phy_postflop_0 [292];
  assign rx_ch1_w_data       [ 41] = rx_phy_postflop_0 [293];
  assign rx_ch1_w_data       [ 42] = rx_phy_postflop_0 [294];
  assign rx_ch1_w_data       [ 43] = rx_phy_postflop_0 [295];
  assign rx_ch1_w_data       [ 44] = rx_phy_postflop_0 [296];
  assign rx_ch1_w_data       [ 45] = rx_phy_postflop_0 [297];
  assign rx_ch1_w_data       [ 46] = rx_phy_postflop_0 [298];
  assign rx_ch1_w_data       [ 47] = rx_phy_postflop_0 [299];
  assign rx_ch1_w_data       [ 48] = rx_phy_postflop_0 [300];
  assign rx_ch1_r_credit           = rx_phy_postflop_0 [301];
  assign rx_ch1_b_credit           = rx_phy_postflop_0 [302];
  assign rx_ch2_ar_pushbit         = rx_phy_postflop_0 [303];
  assign rx_ch2_ar_data      [  0] = rx_phy_postflop_0 [304];
  assign rx_ch2_ar_data      [  1] = rx_phy_postflop_0 [305];
  assign rx_ch2_ar_data      [  2] = rx_phy_postflop_0 [306];
  assign rx_ch2_ar_data      [  3] = rx_phy_postflop_0 [307];
  assign rx_ch2_ar_data      [  4] = rx_phy_postflop_0 [308];
  assign rx_ch2_ar_data      [  5] = rx_phy_postflop_0 [309];
  assign rx_ch2_ar_data      [  6] = rx_phy_postflop_0 [310];
  assign rx_ch2_ar_data      [  7] = rx_phy_postflop_0 [311];
  assign rx_ch2_ar_data      [  8] = rx_phy_postflop_0 [312];
  assign rx_ch2_ar_data      [  9] = rx_phy_postflop_0 [313];
  assign rx_ch2_ar_data      [ 10] = rx_phy_postflop_0 [314];
  assign rx_ch2_ar_data      [ 11] = rx_phy_postflop_0 [315];
  assign rx_ch2_ar_data      [ 12] = rx_phy_postflop_0 [316];
  assign rx_ch2_ar_data      [ 13] = rx_phy_postflop_0 [317];
//       DBI                       = rx_phy_postflop_0 [318];
//       DBI                       = rx_phy_postflop_0 [319];
  assign rx_ch2_ar_data      [ 14] = rx_phy_postflop_1 [  0];
  assign rx_ch2_ar_data      [ 15] = rx_phy_postflop_1 [  1];
  assign rx_ch2_ar_data      [ 16] = rx_phy_postflop_1 [  2];
  assign rx_ch2_ar_data      [ 17] = rx_phy_postflop_1 [  3];
//       MARKER                    = rx_phy_postflop_1 [  4]
  assign rx_ch2_ar_data      [ 18] = rx_phy_postflop_1 [  5];
  assign rx_ch2_ar_data      [ 19] = rx_phy_postflop_1 [  6];
  assign rx_ch2_ar_data      [ 20] = rx_phy_postflop_1 [  7];
  assign rx_ch2_ar_data      [ 21] = rx_phy_postflop_1 [  8];
  assign rx_ch2_ar_data      [ 22] = rx_phy_postflop_1 [  9];
  assign rx_ch2_ar_data      [ 23] = rx_phy_postflop_1 [ 10];
  assign rx_ch2_ar_data      [ 24] = rx_phy_postflop_1 [ 11];
  assign rx_ch2_ar_data      [ 25] = rx_phy_postflop_1 [ 12];
  assign rx_ch2_ar_data      [ 26] = rx_phy_postflop_1 [ 13];
  assign rx_ch2_ar_data      [ 27] = rx_phy_postflop_1 [ 14];
  assign rx_ch2_ar_data      [ 28] = rx_phy_postflop_1 [ 15];
  assign rx_ch2_ar_data      [ 29] = rx_phy_postflop_1 [ 16];
  assign rx_ch2_ar_data      [ 30] = rx_phy_postflop_1 [ 17];
  assign rx_ch2_ar_data      [ 31] = rx_phy_postflop_1 [ 18];
  assign rx_ch2_ar_data      [ 32] = rx_phy_postflop_1 [ 19];
  assign rx_ch2_ar_data      [ 33] = rx_phy_postflop_1 [ 20];
  assign rx_ch2_ar_data      [ 34] = rx_phy_postflop_1 [ 21];
  assign rx_ch2_ar_data      [ 35] = rx_phy_postflop_1 [ 22];
  assign rx_ch2_ar_data      [ 36] = rx_phy_postflop_1 [ 23];
  assign rx_ch2_ar_data      [ 37] = rx_phy_postflop_1 [ 24];
  assign rx_ch2_ar_data      [ 38] = rx_phy_postflop_1 [ 25];
  assign rx_ch2_ar_data      [ 39] = rx_phy_postflop_1 [ 26];
  assign rx_ch2_ar_data      [ 40] = rx_phy_postflop_1 [ 27];
  assign rx_ch2_ar_data      [ 41] = rx_phy_postflop_1 [ 28];
  assign rx_ch2_ar_data      [ 42] = rx_phy_postflop_1 [ 29];
  assign rx_ch2_ar_data      [ 43] = rx_phy_postflop_1 [ 30];
  assign rx_ch2_aw_pushbit         = rx_phy_postflop_1 [ 31];
  assign rx_ch2_aw_data      [  0] = rx_phy_postflop_1 [ 32];
  assign rx_ch2_aw_data      [  1] = rx_phy_postflop_1 [ 33];
  assign rx_ch2_aw_data      [  2] = rx_phy_postflop_1 [ 34];
  assign rx_ch2_aw_data      [  3] = rx_phy_postflop_1 [ 35];
  assign rx_ch2_aw_data      [  4] = rx_phy_postflop_1 [ 36];
  assign rx_ch2_aw_data      [  5] = rx_phy_postflop_1 [ 37];
//       DBI                       = rx_phy_postflop_1 [ 38];
//       DBI                       = rx_phy_postflop_1 [ 39];
  assign rx_ch2_aw_data      [  6] = rx_phy_postflop_1 [ 40];
  assign rx_ch2_aw_data      [  7] = rx_phy_postflop_1 [ 41];
  assign rx_ch2_aw_data      [  8] = rx_phy_postflop_1 [ 42];
  assign rx_ch2_aw_data      [  9] = rx_phy_postflop_1 [ 43];
  assign rx_ch2_aw_data      [ 10] = rx_phy_postflop_1 [ 44];
  assign rx_ch2_aw_data      [ 11] = rx_phy_postflop_1 [ 45];
  assign rx_ch2_aw_data      [ 12] = rx_phy_postflop_1 [ 46];
  assign rx_ch2_aw_data      [ 13] = rx_phy_postflop_1 [ 47];
  assign rx_ch2_aw_data      [ 14] = rx_phy_postflop_1 [ 48];
  assign rx_ch2_aw_data      [ 15] = rx_phy_postflop_1 [ 49];
  assign rx_ch2_aw_data      [ 16] = rx_phy_postflop_1 [ 50];
  assign rx_ch2_aw_data      [ 17] = rx_phy_postflop_1 [ 51];
  assign rx_ch2_aw_data      [ 18] = rx_phy_postflop_1 [ 52];
  assign rx_ch2_aw_data      [ 19] = rx_phy_postflop_1 [ 53];
  assign rx_ch2_aw_data      [ 20] = rx_phy_postflop_1 [ 54];
  assign rx_ch2_aw_data      [ 21] = rx_phy_postflop_1 [ 55];
  assign rx_ch2_aw_data      [ 22] = rx_phy_postflop_1 [ 56];
  assign rx_ch2_aw_data      [ 23] = rx_phy_postflop_1 [ 57];
  assign rx_ch2_aw_data      [ 24] = rx_phy_postflop_1 [ 58];
  assign rx_ch2_aw_data      [ 25] = rx_phy_postflop_1 [ 59];
  assign rx_ch2_aw_data      [ 26] = rx_phy_postflop_1 [ 60];
  assign rx_ch2_aw_data      [ 27] = rx_phy_postflop_1 [ 61];
  assign rx_ch2_aw_data      [ 28] = rx_phy_postflop_1 [ 62];
  assign rx_ch2_aw_data      [ 29] = rx_phy_postflop_1 [ 63];
  assign rx_ch2_aw_data      [ 30] = rx_phy_postflop_1 [ 64];
  assign rx_ch2_aw_data      [ 31] = rx_phy_postflop_1 [ 65];
  assign rx_ch2_aw_data      [ 32] = rx_phy_postflop_1 [ 66];
  assign rx_ch2_aw_data      [ 33] = rx_phy_postflop_1 [ 67];
  assign rx_ch2_aw_data      [ 34] = rx_phy_postflop_1 [ 68];
  assign rx_ch2_aw_data      [ 35] = rx_phy_postflop_1 [ 69];
  assign rx_ch2_aw_data      [ 36] = rx_phy_postflop_1 [ 70];
  assign rx_ch2_aw_data      [ 37] = rx_phy_postflop_1 [ 71];
  assign rx_ch2_aw_data      [ 38] = rx_phy_postflop_1 [ 72];
  assign rx_ch2_aw_data      [ 39] = rx_phy_postflop_1 [ 73];
  assign rx_ch2_aw_data      [ 40] = rx_phy_postflop_1 [ 74];
  assign rx_ch2_aw_data      [ 41] = rx_phy_postflop_1 [ 75];
//       STROBE                    = rx_phy_postflop_1 [ 76]
  assign rx_ch2_aw_data      [ 42] = rx_phy_postflop_1 [ 77];
//       DBI                       = rx_phy_postflop_1 [ 78];
//       DBI                       = rx_phy_postflop_1 [ 79];
  assign rx_ch2_aw_data      [ 43] = rx_phy_postflop_1 [ 80];
  assign rx_ch2_w_pushbit          = rx_phy_postflop_1 [ 81];
  assign rx_ch2_w_data       [  0] = rx_phy_postflop_1 [ 82];
  assign rx_ch2_w_data       [  1] = rx_phy_postflop_1 [ 83];
//       MARKER                    = rx_phy_postflop_1 [ 84]
  assign rx_ch2_w_data       [  2] = rx_phy_postflop_1 [ 85];
  assign rx_ch2_w_data       [  3] = rx_phy_postflop_1 [ 86];
  assign rx_ch2_w_data       [  4] = rx_phy_postflop_1 [ 87];
  assign rx_ch2_w_data       [  5] = rx_phy_postflop_1 [ 88];
  assign rx_ch2_w_data       [  6] = rx_phy_postflop_1 [ 89];
  assign rx_ch2_w_data       [  7] = rx_phy_postflop_1 [ 90];
  assign rx_ch2_w_data       [  8] = rx_phy_postflop_1 [ 91];
  assign rx_ch2_w_data       [  9] = rx_phy_postflop_1 [ 92];
  assign rx_ch2_w_data       [ 10] = rx_phy_postflop_1 [ 93];
  assign rx_ch2_w_data       [ 11] = rx_phy_postflop_1 [ 94];
  assign rx_ch2_w_data       [ 12] = rx_phy_postflop_1 [ 95];
  assign rx_ch2_w_data       [ 13] = rx_phy_postflop_1 [ 96];
  assign rx_ch2_w_data       [ 14] = rx_phy_postflop_1 [ 97];
  assign rx_ch2_w_data       [ 15] = rx_phy_postflop_1 [ 98];
  assign rx_ch2_w_data       [ 16] = rx_phy_postflop_1 [ 99];
  assign rx_ch2_w_data       [ 17] = rx_phy_postflop_1 [100];
  assign rx_ch2_w_data       [ 18] = rx_phy_postflop_1 [101];
  assign rx_ch2_w_data       [ 19] = rx_phy_postflop_1 [102];
  assign rx_ch2_w_data       [ 20] = rx_phy_postflop_1 [103];
  assign rx_ch2_w_data       [ 21] = rx_phy_postflop_1 [104];
  assign rx_ch2_w_data       [ 22] = rx_phy_postflop_1 [105];
  assign rx_ch2_w_data       [ 23] = rx_phy_postflop_1 [106];
  assign rx_ch2_w_data       [ 24] = rx_phy_postflop_1 [107];
  assign rx_ch2_w_data       [ 25] = rx_phy_postflop_1 [108];
  assign rx_ch2_w_data       [ 26] = rx_phy_postflop_1 [109];
  assign rx_ch2_w_data       [ 27] = rx_phy_postflop_1 [110];
  assign rx_ch2_w_data       [ 28] = rx_phy_postflop_1 [111];
  assign rx_ch2_w_data       [ 29] = rx_phy_postflop_1 [112];
  assign rx_ch2_w_data       [ 30] = rx_phy_postflop_1 [113];
  assign rx_ch2_w_data       [ 31] = rx_phy_postflop_1 [114];
  assign rx_ch2_w_data       [ 32] = rx_phy_postflop_1 [115];
  assign rx_ch2_w_data       [ 33] = rx_phy_postflop_1 [116];
  assign rx_ch2_w_data       [ 34] = rx_phy_postflop_1 [117];
//       DBI                       = rx_phy_postflop_1 [118];
//       DBI                       = rx_phy_postflop_1 [119];
  assign rx_ch2_w_data       [ 35] = rx_phy_postflop_1 [120];
  assign rx_ch2_w_data       [ 36] = rx_phy_postflop_1 [121];
  assign rx_ch2_w_data       [ 37] = rx_phy_postflop_1 [122];
  assign rx_ch2_w_data       [ 38] = rx_phy_postflop_1 [123];
  assign rx_ch2_w_data       [ 39] = rx_phy_postflop_1 [124];
  assign rx_ch2_w_data       [ 40] = rx_phy_postflop_1 [125];
  assign rx_ch2_w_data       [ 41] = rx_phy_postflop_1 [126];
  assign rx_ch2_w_data       [ 42] = rx_phy_postflop_1 [127];
  assign rx_ch2_w_data       [ 43] = rx_phy_postflop_1 [128];
  assign rx_ch2_w_data       [ 44] = rx_phy_postflop_1 [129];
  assign rx_ch2_w_data       [ 45] = rx_phy_postflop_1 [130];
  assign rx_ch2_w_data       [ 46] = rx_phy_postflop_1 [131];
  assign rx_ch2_w_data       [ 47] = rx_phy_postflop_1 [132];
  assign rx_ch2_w_data       [ 48] = rx_phy_postflop_1 [133];
  assign rx_ch2_r_credit           = rx_phy_postflop_1 [134];
  assign rx_ch2_b_credit           = rx_phy_postflop_1 [135];
  assign rx_ch3_ar_pushbit         = rx_phy_postflop_1 [136];
  assign rx_ch3_ar_data      [  0] = rx_phy_postflop_1 [137];
  assign rx_ch3_ar_data      [  1] = rx_phy_postflop_1 [138];
  assign rx_ch3_ar_data      [  2] = rx_phy_postflop_1 [139];
  assign rx_ch3_ar_data      [  3] = rx_phy_postflop_1 [140];
  assign rx_ch3_ar_data      [  4] = rx_phy_postflop_1 [141];
  assign rx_ch3_ar_data      [  5] = rx_phy_postflop_1 [142];
  assign rx_ch3_ar_data      [  6] = rx_phy_postflop_1 [143];
  assign rx_ch3_ar_data      [  7] = rx_phy_postflop_1 [144];
  assign rx_ch3_ar_data      [  8] = rx_phy_postflop_1 [145];
  assign rx_ch3_ar_data      [  9] = rx_phy_postflop_1 [146];
  assign rx_ch3_ar_data      [ 10] = rx_phy_postflop_1 [147];
  assign rx_ch3_ar_data      [ 11] = rx_phy_postflop_1 [148];
  assign rx_ch3_ar_data      [ 12] = rx_phy_postflop_1 [149];
  assign rx_ch3_ar_data      [ 13] = rx_phy_postflop_1 [150];
  assign rx_ch3_ar_data      [ 14] = rx_phy_postflop_1 [151];
  assign rx_ch3_ar_data      [ 15] = rx_phy_postflop_1 [152];
  assign rx_ch3_ar_data      [ 16] = rx_phy_postflop_1 [153];
  assign rx_ch3_ar_data      [ 17] = rx_phy_postflop_1 [154];
  assign rx_ch3_ar_data      [ 18] = rx_phy_postflop_1 [155];
  assign rx_ch3_ar_data      [ 19] = rx_phy_postflop_1 [156];
  assign rx_ch3_ar_data      [ 20] = rx_phy_postflop_1 [157];
//       DBI                       = rx_phy_postflop_1 [158];
//       DBI                       = rx_phy_postflop_1 [159];
  assign rx_ch3_ar_data      [ 21] = rx_phy_postflop_1 [160];
  assign rx_ch3_ar_data      [ 22] = rx_phy_postflop_1 [161];
  assign rx_ch3_ar_data      [ 23] = rx_phy_postflop_1 [162];
  assign rx_ch3_ar_data      [ 24] = rx_phy_postflop_1 [163];
//       MARKER                    = rx_phy_postflop_1 [164]
  assign rx_ch3_ar_data      [ 25] = rx_phy_postflop_1 [165];
  assign rx_ch3_ar_data      [ 26] = rx_phy_postflop_1 [166];
  assign rx_ch3_ar_data      [ 27] = rx_phy_postflop_1 [167];
  assign rx_ch3_ar_data      [ 28] = rx_phy_postflop_1 [168];
  assign rx_ch3_ar_data      [ 29] = rx_phy_postflop_1 [169];
  assign rx_ch3_ar_data      [ 30] = rx_phy_postflop_1 [170];
  assign rx_ch3_ar_data      [ 31] = rx_phy_postflop_1 [171];
  assign rx_ch3_ar_data      [ 32] = rx_phy_postflop_1 [172];
  assign rx_ch3_ar_data      [ 33] = rx_phy_postflop_1 [173];
  assign rx_ch3_ar_data      [ 34] = rx_phy_postflop_1 [174];
  assign rx_ch3_ar_data      [ 35] = rx_phy_postflop_1 [175];
  assign rx_ch3_ar_data      [ 36] = rx_phy_postflop_1 [176];
  assign rx_ch3_ar_data      [ 37] = rx_phy_postflop_1 [177];
  assign rx_ch3_ar_data      [ 38] = rx_phy_postflop_1 [178];
  assign rx_ch3_ar_data      [ 39] = rx_phy_postflop_1 [179];
  assign rx_ch3_ar_data      [ 40] = rx_phy_postflop_1 [180];
  assign rx_ch3_ar_data      [ 41] = rx_phy_postflop_1 [181];
  assign rx_ch3_ar_data      [ 42] = rx_phy_postflop_1 [182];
  assign rx_ch3_ar_data      [ 43] = rx_phy_postflop_1 [183];
  assign rx_ch3_aw_pushbit         = rx_phy_postflop_1 [184];
  assign rx_ch3_aw_data      [  0] = rx_phy_postflop_1 [185];
  assign rx_ch3_aw_data      [  1] = rx_phy_postflop_1 [186];
  assign rx_ch3_aw_data      [  2] = rx_phy_postflop_1 [187];
  assign rx_ch3_aw_data      [  3] = rx_phy_postflop_1 [188];
  assign rx_ch3_aw_data      [  4] = rx_phy_postflop_1 [189];
  assign rx_ch3_aw_data      [  5] = rx_phy_postflop_1 [190];
  assign rx_ch3_aw_data      [  6] = rx_phy_postflop_1 [191];
  assign rx_ch3_aw_data      [  7] = rx_phy_postflop_1 [192];
  assign rx_ch3_aw_data      [  8] = rx_phy_postflop_1 [193];
  assign rx_ch3_aw_data      [  9] = rx_phy_postflop_1 [194];
  assign rx_ch3_aw_data      [ 10] = rx_phy_postflop_1 [195];
  assign rx_ch3_aw_data      [ 11] = rx_phy_postflop_1 [196];
  assign rx_ch3_aw_data      [ 12] = rx_phy_postflop_1 [197];
//       DBI                       = rx_phy_postflop_1 [198];
//       DBI                       = rx_phy_postflop_1 [199];
  assign rx_ch3_aw_data      [ 13] = rx_phy_postflop_1 [200];
  assign rx_ch3_aw_data      [ 14] = rx_phy_postflop_1 [201];
  assign rx_ch3_aw_data      [ 15] = rx_phy_postflop_1 [202];
  assign rx_ch3_aw_data      [ 16] = rx_phy_postflop_1 [203];
  assign rx_ch3_aw_data      [ 17] = rx_phy_postflop_1 [204];
  assign rx_ch3_aw_data      [ 18] = rx_phy_postflop_1 [205];
  assign rx_ch3_aw_data      [ 19] = rx_phy_postflop_1 [206];
  assign rx_ch3_aw_data      [ 20] = rx_phy_postflop_1 [207];
  assign rx_ch3_aw_data      [ 21] = rx_phy_postflop_1 [208];
  assign rx_ch3_aw_data      [ 22] = rx_phy_postflop_1 [209];
  assign rx_ch3_aw_data      [ 23] = rx_phy_postflop_1 [210];
  assign rx_ch3_aw_data      [ 24] = rx_phy_postflop_1 [211];
  assign rx_ch3_aw_data      [ 25] = rx_phy_postflop_1 [212];
  assign rx_ch3_aw_data      [ 26] = rx_phy_postflop_1 [213];
  assign rx_ch3_aw_data      [ 27] = rx_phy_postflop_1 [214];
  assign rx_ch3_aw_data      [ 28] = rx_phy_postflop_1 [215];
  assign rx_ch3_aw_data      [ 29] = rx_phy_postflop_1 [216];
  assign rx_ch3_aw_data      [ 30] = rx_phy_postflop_1 [217];
  assign rx_ch3_aw_data      [ 31] = rx_phy_postflop_1 [218];
  assign rx_ch3_aw_data      [ 32] = rx_phy_postflop_1 [219];
  assign rx_ch3_aw_data      [ 33] = rx_phy_postflop_1 [220];
  assign rx_ch3_aw_data      [ 34] = rx_phy_postflop_1 [221];
  assign rx_ch3_aw_data      [ 35] = rx_phy_postflop_1 [222];
  assign rx_ch3_aw_data      [ 36] = rx_phy_postflop_1 [223];
  assign rx_ch3_aw_data      [ 37] = rx_phy_postflop_1 [224];
  assign rx_ch3_aw_data      [ 38] = rx_phy_postflop_1 [225];
  assign rx_ch3_aw_data      [ 39] = rx_phy_postflop_1 [226];
  assign rx_ch3_aw_data      [ 40] = rx_phy_postflop_1 [227];
  assign rx_ch3_aw_data      [ 41] = rx_phy_postflop_1 [228];
  assign rx_ch3_aw_data      [ 42] = rx_phy_postflop_1 [229];
  assign rx_ch3_aw_data      [ 43] = rx_phy_postflop_1 [230];
  assign rx_ch3_w_pushbit          = rx_phy_postflop_1 [231];
  assign rx_ch3_w_data       [  0] = rx_phy_postflop_1 [232];
  assign rx_ch3_w_data       [  1] = rx_phy_postflop_1 [233];
  assign rx_ch3_w_data       [  2] = rx_phy_postflop_1 [234];
  assign rx_ch3_w_data       [  3] = rx_phy_postflop_1 [235];
  assign rx_ch3_w_data       [  4] = rx_phy_postflop_1 [236];
  assign rx_ch3_w_data       [  5] = rx_phy_postflop_1 [237];
//       DBI                       = rx_phy_postflop_1 [238];
//       DBI                       = rx_phy_postflop_1 [239];
  assign rx_ch3_w_data       [  6] = rx_phy_postflop_1 [240];
  assign rx_ch3_w_data       [  7] = rx_phy_postflop_1 [241];
  assign rx_ch3_w_data       [  8] = rx_phy_postflop_1 [242];
  assign rx_ch3_w_data       [  9] = rx_phy_postflop_1 [243];
//       MARKER                    = rx_phy_postflop_1 [244]
  assign rx_ch3_w_data       [ 10] = rx_phy_postflop_1 [245];
  assign rx_ch3_w_data       [ 11] = rx_phy_postflop_1 [246];
  assign rx_ch3_w_data       [ 12] = rx_phy_postflop_1 [247];
  assign rx_ch3_w_data       [ 13] = rx_phy_postflop_1 [248];
  assign rx_ch3_w_data       [ 14] = rx_phy_postflop_1 [249];
  assign rx_ch3_w_data       [ 15] = rx_phy_postflop_1 [250];
  assign rx_ch3_w_data       [ 16] = rx_phy_postflop_1 [251];
  assign rx_ch3_w_data       [ 17] = rx_phy_postflop_1 [252];
  assign rx_ch3_w_data       [ 18] = rx_phy_postflop_1 [253];
  assign rx_ch3_w_data       [ 19] = rx_phy_postflop_1 [254];
  assign rx_ch3_w_data       [ 20] = rx_phy_postflop_1 [255];
  assign rx_ch3_w_data       [ 21] = rx_phy_postflop_1 [256];
  assign rx_ch3_w_data       [ 22] = rx_phy_postflop_1 [257];
  assign rx_ch3_w_data       [ 23] = rx_phy_postflop_1 [258];
  assign rx_ch3_w_data       [ 24] = rx_phy_postflop_1 [259];
  assign rx_ch3_w_data       [ 25] = rx_phy_postflop_1 [260];
  assign rx_ch3_w_data       [ 26] = rx_phy_postflop_1 [261];
  assign rx_ch3_w_data       [ 27] = rx_phy_postflop_1 [262];
  assign rx_ch3_w_data       [ 28] = rx_phy_postflop_1 [263];
  assign rx_ch3_w_data       [ 29] = rx_phy_postflop_1 [264];
  assign rx_ch3_w_data       [ 30] = rx_phy_postflop_1 [265];
  assign rx_ch3_w_data       [ 31] = rx_phy_postflop_1 [266];
  assign rx_ch3_w_data       [ 32] = rx_phy_postflop_1 [267];
  assign rx_ch3_w_data       [ 33] = rx_phy_postflop_1 [268];
  assign rx_ch3_w_data       [ 34] = rx_phy_postflop_1 [269];
  assign rx_ch3_w_data       [ 35] = rx_phy_postflop_1 [270];
  assign rx_ch3_w_data       [ 36] = rx_phy_postflop_1 [271];
  assign rx_ch3_w_data       [ 37] = rx_phy_postflop_1 [272];
  assign rx_ch3_w_data       [ 38] = rx_phy_postflop_1 [273];
  assign rx_ch3_w_data       [ 39] = rx_phy_postflop_1 [274];
  assign rx_ch3_w_data       [ 40] = rx_phy_postflop_1 [275];
  assign rx_ch3_w_data       [ 41] = rx_phy_postflop_1 [276];
  assign rx_ch3_w_data       [ 42] = rx_phy_postflop_1 [277];
//       DBI                       = rx_phy_postflop_1 [278];
//       DBI                       = rx_phy_postflop_1 [279];
  assign rx_ch3_w_data       [ 43] = rx_phy_postflop_1 [280];
  assign rx_ch3_w_data       [ 44] = rx_phy_postflop_1 [281];
  assign rx_ch3_w_data       [ 45] = rx_phy_postflop_1 [282];
  assign rx_ch3_w_data       [ 46] = rx_phy_postflop_1 [283];
  assign rx_ch3_w_data       [ 47] = rx_phy_postflop_1 [284];
  assign rx_ch3_w_data       [ 48] = rx_phy_postflop_1 [285];
  assign rx_ch3_r_credit           = rx_phy_postflop_1 [286];
  assign rx_ch3_b_credit           = rx_phy_postflop_1 [287];
//       nc                        = rx_phy_postflop_1 [288];
//       nc                        = rx_phy_postflop_1 [289];
//       nc                        = rx_phy_postflop_1 [290];
//       nc                        = rx_phy_postflop_1 [291];
//       nc                        = rx_phy_postflop_1 [292];
//       nc                        = rx_phy_postflop_1 [293];
//       nc                        = rx_phy_postflop_1 [294];
//       nc                        = rx_phy_postflop_1 [295];
//       nc                        = rx_phy_postflop_1 [296];
//       nc                        = rx_phy_postflop_1 [297];
//       nc                        = rx_phy_postflop_1 [298];
//       nc                        = rx_phy_postflop_1 [299];
//       nc                        = rx_phy_postflop_1 [300];
//       nc                        = rx_phy_postflop_1 [301];
//       nc                        = rx_phy_postflop_1 [302];
//       nc                        = rx_phy_postflop_1 [303];
//       nc                        = rx_phy_postflop_1 [304];
//       nc                        = rx_phy_postflop_1 [305];
//       nc                        = rx_phy_postflop_1 [306];
//       nc                        = rx_phy_postflop_1 [307];
//       nc                        = rx_phy_postflop_1 [308];
//       nc                        = rx_phy_postflop_1 [309];
//       nc                        = rx_phy_postflop_1 [310];
//       nc                        = rx_phy_postflop_1 [311];
//       nc                        = rx_phy_postflop_1 [312];
//       nc                        = rx_phy_postflop_1 [313];
//       nc                        = rx_phy_postflop_1 [314];
//       nc                        = rx_phy_postflop_1 [315];
//       nc                        = rx_phy_postflop_1 [316];
//       nc                        = rx_phy_postflop_1 [317];
//       DBI                       = rx_phy_postflop_1 [318];
//       DBI                       = rx_phy_postflop_1 [319];

// RX Section
////////////////////////////////////////////////////////////


endmodule
