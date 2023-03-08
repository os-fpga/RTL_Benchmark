/**********************************************
********COPYRIGHT(c) Rapid Silicon, 2022*******
Design: Clock lane module within D PHY PCS layer.
Date:       20220912
Owner:      YousafG
********************************************/


import d_pcs_pkg::*;


module c_lane
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
    input           ppi_TxRequestHS,
    input           ppi_TxUlpsClk,
    input           ppi_TxUlpsExit,
    output          ppi_RxClkActiveHS,
    output          ppi_RxUlpsClkNot,
    output          ppi_Stopstate,
    input           ppi_Enable,
    output          ppi_UlpsActiveNot,
// IOE interface
    // TX data/clock interface (source syncronous interface)
    output  [7:0]   tx_hs_data,
    output          tx_hs_clk,
    output          tx_lp_dp,
    output          tx_lp_dn,
    // RX data interface
    input           rx_lp_dp,
    input           rx_lp_dn,

    //TX/RX control interface
    output          hs_en,
    output          lp_en,
    output          term_en, // only used in RX mode
          
    // TX/RX delay control interface
    output           dly_ld,
    output           dly_adj,
    output           dly_inc,
    input            dly_adj_done,
    input   [5:0]    dly_tap

) ;

endmodule
