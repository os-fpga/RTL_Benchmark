/**********************************************
********COPYRIGHT(c) Rapid Silicon, 2022*******
Design: Top Level module for D PHY PCS layer.
Date:       20220912
Owner:      YousafG
********************************************/

import d_pcs_pkg::*;


module d_pcs 
#(  parameter DEVICE_P          = MASTER,
    parameter NUM_DATA_LANES_P  = 4
)
(

// Clock and reset interface
    // clock from the IOE through clock tree (should be 1/8 of serial rate)
    input                               clk_byte_hs,
    // clock from the PLL towards PCS as well as controller (always less than clk_byte_hs)
    input                               TxClkEsc,
    // resets
    input                               rst_byte_hs_n,
    input                               rst_esc_n, 

 // C_PPI interface
    input                               ppi_C_TxRequestHS,
    input                               ppi_C_TxUlpsClk,
    input                               ppi_C_TxUlpsExit,
    output                              ppi_C_RxClkActiveHS,
    output                              ppi_C_RxUlpsClkNot,
    output                              ppi_C_Stopstate,
    input                               ppi_C_Enable,
    output                              ppi_C_UlpsActiveNot,

 // D_PPI interface
    // TX HS interface
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_TxRequestHS,
    input   [NUM_DATA_LANES_P-1:0][7:0] ppi_D_TxDataHS,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_TxReadyHS,
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_TxSkewCalHS,
    // RX HS interface
    output  [NUM_DATA_LANES_P-1:0][7:0] ppi_D_RxDataHS,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_RxValidHS,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_RxActiveHS,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_RxSyncHS,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_RxSkewCalHS,
    // TX LP interface
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_TxRequestEsc,
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_TxLpdtEsc,
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_TxUlpsEsc,
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_TxUlpsExit,
    input   [NUM_DATA_LANES_P-1:0][3:0] ppi_D_TxTriggerEsc,
    input   [NUM_DATA_LANES_P-1:0][7:0] ppi_D_TxDataEsc,
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_TxValidEsc,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_TxReadyEsc,
    // RX LP interface
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_RxClkEsc,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_RxLpdtEsc,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_RxUlpsEsc,
    output  [NUM_DATA_LANES_P-1:0][3:0] ppi_D_RxTriggerEsc,
    output  [NUM_DATA_LANES_P-1:0][7:0] ppi_D_RxDataEsc,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_RxValidEsc,
    // Control/status interface
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_TurnRequest,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_Direction,
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_TurnDisable,
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_ForceRxMode,
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_ForceTxStopMode,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_Stopstate,
    input   [NUM_DATA_LANES_P-1:0]      ppi_D_Enable,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_UlpsActiveNot,          
    
    // Error interface
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_ErrSotHS,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_ErrSotSyncHS,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_ErrEsc,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_ErrControl,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_ErrcontentionLP_Dp,
    output  [NUM_DATA_LANES_P-1:0]      ppi_D_ErrcontentionLP_Dn,   

// C_IOE interface (C_GBI)
    // TX data/clock interface (source syncronous interface)
    output  [7:0]                       C_tx_hs_data,
    output                              C_tx_hs_clk,
    output                              C_tx_lp_dp,
    output                              C_tx_lp_dn,
    // RX data interface
    input                               C_rx_lp_dp,
    input                               C_rx_lp_dn,

    //TX/RX control interface
    output                              C_hs_en,
    output                              C_lp_en,
    output                              C_term_en, 
          
    // TX/RX delay control interface
    output                              C_dly_ld,
    output                              C_dly_adj,
    output                              C_dly_inc,
    input                               C_dly_adj_done,
    input   [5:0]                       C_dly_tap,

// D_IOE interface (D_GBI)
    // TX data/clock interface (source syncronous interface)
    output  [NUM_DATA_LANES_P-1:0][7:0] D_tx_hs_data,
    output  [NUM_DATA_LANES_P-1:0]      D_tx_hs_clk,
    output  [NUM_DATA_LANES_P-1:0]      D_tx_lp_dp,
    output  [NUM_DATA_LANES_P-1:0]      D_tx_lp_dn,

    // RX data interface
    input   [NUM_DATA_LANES_P-1:0][7:0] D_rx_hs_data,    
    input   [NUM_DATA_LANES_P-1:0]      D_rx_lp_dp,
    input   [NUM_DATA_LANES_P-1:0]      D_rx_lp_dn,

    //TX control interface
    output  [NUM_DATA_LANES_P-1:0]      D_tx_hs_en,
    output  [NUM_DATA_LANES_P-1:0]      D_tx_lp_en,
        
    //RX control interface
    output  [NUM_DATA_LANES_P-1:0]      D_rx_hs_en,
    output  [NUM_DATA_LANES_P-1:0]      D_rx_lp_en,
    output  [NUM_DATA_LANES_P-1:0]      D_rx_term_en,
    input   [NUM_DATA_LANES_P-1:0]      D_rx_cdet_dp,
    input   [NUM_DATA_LANES_P-1:0]      D_rx_cdet_dn,
                 
    // TX/RX delay control interface
    output  [NUM_DATA_LANES_P-1:0]      D_dly_ld,
    output  [NUM_DATA_LANES_P-1:0]      D_dly_adj,
    output  [NUM_DATA_LANES_P-1:0]      D_dly_inc,
    input   [NUM_DATA_LANES_P-1:0]      D_dly_adj_done,
    input   [NUM_DATA_LANES_P-1:0][5:0] D_dly_tap,

    //RX channel control interface
    output  [NUM_DATA_LANES_P-1:0]      D_rx_sfifo_reset,
    output  [NUM_DATA_LANES_P-1:0]      D_rx_bitslip_adj,
    input   [NUM_DATA_LANES_P-1:0][3:0] D_rx_bitslip_val,
    output  [NUM_DATA_LANES_P-1:0]      D_rx_dpa_restart,
    input   [NUM_DATA_LANES_P-1:0]      D_rx_dpa_lock,
    input   [NUM_DATA_LANES_P-1:0]      D_rx_dpa_error,
    input   [NUM_DATA_LANES_P-1:0][2:0] D_rx_dpa_ph

);

c_lane #(.DEVICE_P (DEVICE_P)) c_lane_i (
    .clk_byte_hs            (clk_byte_hs),
    .TxClkEsc               (TxClkEsc),
    .rst_byte_hs_n          (rst_byte_hs_n),
    .rst_esc_n              (rst_esc_n),
    .ppi_TxRequestHS        (ppi_C_TxRequestHS),
    .ppi_TxUlpsClk          (ppi_C_TxUlpsClk),
    .ppi_TxUlpsExit         (ppi_C_TxUlpsExit),		
    .ppi_RxClkActiveHS      (ppi_C_RxClkActiveHS),
    .ppi_RxUlpsClkNot       (ppi_C_RxUlpsClkNot),
    .ppi_Stopstate          (ppi_C_Stopstate),
    .ppi_Enable             (ppi_C_Enable),
    .ppi_UlpsActiveNot      (ppi_C_UlpsActiveNot),
    .tx_hs_data             (C_tx_hs_data),
    .tx_hs_clk              (C_tx_hs_clk),
    .tx_lp_dp               (C_tx_lp_dp),
    .tx_lp_dn               (C_tx_lp_dn),
    .rx_lp_dp               (C_rx_lp_dp),
    .rx_lp_dn               (C_rx_lp_dn),
    .hs_en                  (C_hs_en),
    .lp_en                  (C_lp_en),
    .term_en                (C_term_en),
    .dly_ld                 (C_dly_ld),
    .dly_adj                (C_dly_adj),
    .dly_inc                (C_dly_inc),
    .dly_adj_done           (C_dly_adj_done),
    .dly_tap                (C_dly_tap)

    
);

genvar i;

generate
    for(i = 0; i <NUM_DATA_LANES_P; i++) begin
        
        d_lane #(.DEVICE_P (DEVICE_P)) d_lane_i (
            .clk_byte_hs            (clk_byte_hs),
            .TxClkEsc               (TxClkEsc),
            .rst_byte_hs_n          (rst_byte_hs_n),
            .rst_esc_n              (rst_esc_n),
            .ppi_TxRequestHS        (ppi_D_TxRequestHS[i]),
            .ppi_TxDataHS           (ppi_D_TxDataHS[i]),
            .ppi_TxReadyHS          (ppi_D_TxReadyHS[i]),
            .ppi_TxSkewCalHS        (ppi_D_TxSkewCalHS[i]),
            .ppi_RxDataHS           (ppi_D_RxDataHS[i]),
            .ppi_RxValidHS          (ppi_D_RxValidHS[i]),
            .ppi_RxActiveHS         (ppi_D_RxActiveHS[i]),
            .ppi_RxSyncHS           (ppi_D_RxSyncHS[i]),
            .ppi_RxSkewCalHS        (ppi_D_RxSkewCalHS[i]),
            .ppi_TxRequestEsc       (ppi_D_TxRequestEsc[i]),
            .ppi_TxLpdtEsc          (ppi_D_TxLpdtEsc[i]),
            .ppi_TxUlpsEsc          (ppi_D_TxUlpsEsc[i]),
            .ppi_TxUlpsExit         (ppi_D_TxUlpsExit[i]),
            .ppi_TxTriggerEsc       (ppi_D_TxTriggerEsc[i]),
            .ppi_TxDataEsc          (ppi_D_TxDataEsc[i]),
            .ppi_TxValidEsc         (ppi_D_TxValidEsc[i]),
            .ppi_TxReadyEsc         (ppi_D_TxReadyEsc[i]),
            .ppi_RxClkEsc           (ppi_D_RxClkEsc[i]),
            .ppi_RxLpdtEsc          (ppi_D_RxLpdtEsc[i]),
            .ppi_RxUlpsEsc          (ppi_D_RxUlpsEsc[i]),
            .ppi_RxTriggerEsc       (ppi_D_RxTriggerEsc[i]),
            .ppi_RxDataEsc          (ppi_D_RxDataEsc[i]),
            .ppi_RxValidEsc         (ppi_D_RxValidEsc[i]),
            .ppi_TurnRequest        (ppi_D_TurnRequest[i]),
            .ppi_Direction          (ppi_D_Direction [i]),
            .ppi_TurnDisable        (ppi_D_TurnDisable[i]),
            .ppi_ForceRxMode        (ppi_D_ForceRxMode[i]),
            .ppi_ForceTxStopMode    (ppi_D_ForceTxStopMode[i]),
            .ppi_Stopstate          (ppi_D_Stopstate[i]),
            .ppi_Enable             (ppi_D_Enable[i]),
            .ppi_UlpsActiveNot      (ppi_D_UlpsActiveNot[i]),
            .ppi_ErrSotHS           (ppi_D_ErrSotHS[i]),
            .ppi_ErrSotSyncHS       (ppi_D_ErrSotSyncHS[i]),
            .ppi_ErrEsc             (ppi_D_ErrEsc[i]),
            .ppi_ErrControl         (ppi_D_ErrControl[i]),
            .ppi_ErrcontentionLP_Dp (ppi_D_ErrcontentionLP_Dp[i]),
            .ppi_ErrcontentionLP_Dn (ppi_D_ErrcontentionLP_Dn[i]),
            .tx_hs_data             (D_tx_hs_data[i]),
            .tx_hs_clk              (D_tx_hs_clk[i]),
            .tx_lp_dp               (D_tx_lp_dp[i]),
            .tx_lp_dn               (D_tx_lp_dn[i]),
            .rx_hs_data             (D_rx_hs_data[i]),
            .rx_lp_dp               (D_rx_lp_dp[i]),
            .rx_lp_dn               (D_rx_lp_dn[i]),
            .tx_hs_en               (D_tx_hs_en[i]),
            .tx_lp_en               (D_tx_lp_en[i]),
            .rx_hs_en               (D_rx_hs_en[i]),
            .rx_lp_en               (D_rx_lp_en[i]),
            .rx_term_en             (D_rx_term_en[i]),
            .rx_cdet_dp             (D_rx_cdet_dp[i]),
            .rx_cdet_dn             (D_rx_cdet_dn[i]),
            .dly_ld                 (D_dly_ld[i]),
            .dly_adj                (D_dly_adj[i]),
            .dly_inc                (D_dly_inc[i]),
            .dly_adj_done           (D_dly_adj_done[i]),
            .dly_tap                (D_dly_tap[i]),
            .rx_sfifo_reset         (D_rx_sfifo_reset[i]),
            .rx_bitslip_adj         (D_rx_bitslip_adj[i]),
            .rx_bitslip_val         (D_rx_bitslip_val[i]),
            .rx_dpa_restart         (D_rx_dpa_restart[i]),
            .rx_dpa_lock            (D_rx_dpa_lock[i]),
            .rx_dpa_error           (D_rx_dpa_error[i]),
            .rx_dpa_ph              (D_rx_dpa_ph[i])
            
        );
   
    end
endgenerate

endmodule
