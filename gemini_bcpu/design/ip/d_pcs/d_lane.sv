/**********************************************
********COPYRIGHT(c) Rapid Silicon, 2022*******
Design: Data lane module within D PHY PCS layer.
Date:       20220912
Owner:      YousafG
********************************************/


import d_pcs_pkg::*;


module d_lane 
# (parameter DEVICE_P = MASTER)
(

// Clock and reset interface
    // clock from the IOE through clock tree (should be 1/8 of serial rate)
    input           clk_byte_hs,
    // clock from the PLL towards PCS as well as controller (always less than clk_byte_hs)
    input           TxClkEsc,
    // resets
    input           rst_byte_hs_n,
    input           rst_esc_n,

// PPI interface
    // TX HS interface
    input           ppi_TxRequestHS,
    input   [7:0]   ppi_TxDataHS,
    output          ppi_TxReadyHS,
    input           ppi_TxSkewCalHS,
    // RX HS interface
    output  [7:0]   ppi_RxDataHS,
    output          ppi_RxValidHS,
    output          ppi_RxActiveHS,
    output          ppi_RxSyncHS,
    output          ppi_RxSkewCalHS,
    // TX LP interface
    input           ppi_TxRequestEsc,
    input           ppi_TxLpdtEsc,
    input           ppi_TxUlpsEsc,
    input           ppi_TxUlpsExit,
    input   [3:0]   ppi_TxTriggerEsc,
    input   [7:0]   ppi_TxDataEsc,
    input           ppi_TxValidEsc,
    output          ppi_TxReadyEsc,
    // RX LP interface
    output          ppi_RxClkEsc,
    output          ppi_RxLpdtEsc,
    output          ppi_RxUlpsEsc,
    output  [3:0]   ppi_RxTriggerEsc,
    output  [7:0]   ppi_RxDataEsc,
    output          ppi_RxValidEsc,
    // Control/status interface
    input           ppi_TurnRequest,
    output          ppi_Direction,
    input           ppi_TurnDisable,
    input           ppi_ForceRxMode,
    input           ppi_ForceTxStopMode,
    output          ppi_Stopstate,
    input           ppi_Enable,
    output          ppi_UlpsActiveNot,          
    
    // Error interface
    output          ppi_ErrSotHS,
    output          ppi_ErrSotSyncHS,
    output          ppi_ErrEsc,
    output          ppi_ErrControl,
    output          ppi_ErrcontentionLP_Dp,
    output          ppi_ErrcontentionLP_Dn,
    
// IOE interface
    // TX data/clock interface (source syncronous interface)
    output  [7:0]   tx_hs_data,
    output          tx_hs_clk,
    output          tx_lp_dp,
    output          tx_lp_dn,

    // RX data interface
    input   [7:0]   rx_hs_data,    
    input           rx_lp_dp,
    input           rx_lp_dn,

    //TX control interface
    output          tx_hs_en,
    output          tx_lp_en,
        
    //RX control interface
    output          rx_hs_en,
    output          rx_lp_en,
    output          rx_term_en,
    input           rx_cdet_dp,
    input           rx_cdet_dn,
                 
    // TX/RX delay control interface
    output          dly_ld,
    output          dly_adj,
    output          dly_inc,
    input           dly_adj_done,
    input   [5:0]   dly_tap,

    //RX channel control interface
    output          rx_sfifo_reset,
    output          rx_bitslip_adj,
    input   [3:0]   rx_bitslip_val,
    output          rx_dpa_restart,
    input           rx_dpa_lock,
    input           rx_dpa_error,
    input   [2:0]   rx_dpa_ph

) ;
endmodule
