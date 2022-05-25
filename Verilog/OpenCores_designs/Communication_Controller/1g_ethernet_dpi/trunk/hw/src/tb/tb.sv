//////////////////////////////////////////////////////////////////////////////////
// Company:         
// Engineer:        IK
// 
// Create Date:     11:35:01 03/21/2013 
// Design Name:     
// Module Name:     tb
// Project Name:    
// Target Devices:  
// Tool versions:   
// Description:     
//                  
//                  
// Revision: 
// Revision 0.01 - File Created, 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module tb;
//////////////////////////////////////////////////////////////////////////////////
//
parameter   p_Tclk  =   5ns; // 50MHz
parameter   p_Trst  =   120ns;
// Eth MTU
parameter   p_ETH_MTU   =   8*1024; // Jumbo frame

//////////////////////////////////////////////////////////////////////////////////
    // SYS_CON
    reg     s_sys_clk;
    reg     s_eth_clk;
    reg     s_rst;
    // TSE-MDIO
    wire    s_tse_mdio;
    // TSE-RGMII
    wire            s_tse_rx_clk_i;
    wire            s_tse_rx_ctrl_i;
    wire    [ 3:0]  sv_tse_rxd_i;
    
    wire            s_tse_tx_clk_o;
    wire            s_tse_tx_ctrl_o;
    wire    [ 3:0]  sv_tse_txd_o;
    
//////////////////////////////////////////////////////////////////////////////////
//
// 
//
always 
begin   :   SYS_CLK
    #(p_Tclk / 2.0) s_sys_clk <= !s_sys_clk;
end

always
begin   :   ETH_CLK
    #(8ns / 2.0) s_eth_clk <= !s_eth_clk;
end

initial
begin   :   init_POR
    // 
    
    // clr
    s_sys_clk = 0;
    s_eth_clk = 0;
    s_rst = 0;
    
    // Final
end
//////////////////////////////////////////////////////////////////////////////////
//
// Instantiate DUT
//
microb_top              dut
(
// SYS_CON
.glbl_rst               (s_rst),
.sys_diff_clock_clk_n   (!s_sys_clk), // 200MHz clock input from board
.sys_diff_clock_clk_p   ( s_sys_clk),
// LED
.led_8bits_tri_o        (),
// UART
.rs232_uart_rxd         (1'b1),
.rs232_uart_txd         (),
// PHY rst
.phy_resetn             (),
// RGMII Interface
.rgmii_txd              (sv_tse_txd_o),
.rgmii_tx_ctl           (s_tse_tx_ctrl_o),
.rgmii_txc              (s_tse_tx_clk_o),
.rgmii_rxd              (sv_tse_rxd_i),
.rgmii_rx_ctl           (s_tse_rx_ctrl_i),
.rgmii_rxc              (s_tse_rx_clk_i),
// MDIO Interface
.mdio                   (s_tse_mdio),
.mdc                    ()
    
);
//////////////////////////////////////////////////////////////////////////////////
//
// ETH-PHY-MDIO BFM / ;)
//
pullup (s_tse_mdio);

//////////////////////////////////////////////////////////////////////////////////
//
// HOST BFM
//
eth_host_bfm        #(2*1024) // p_ETH_MTU
                    U_HOST_BFM
(
// RSTi
.i_arst             (s_tse_rst_n),
// RGMII-RX
.i_rgmii_rx_clk     (s_tse_tx_clk_o),
.i_rgmii_rx_ctrl    (s_tse_tx_ctrl_o),
.iv_rgmii_rxd       (sv_tse_txd_o),
// RGMII-TX
.o_rgmii_tx_clk     (s_tse_rx_clk_i),
.o_rgmii_tx_ctrl    (s_tse_rx_ctrl_i),
.ov_rgmii_txd       (sv_tse_rxd_i)
);
initial
begin   :   HOST_BFM_RUN
    #(p_Trst);
    fork
        U_HOST_BFM.run_tx();
        U_HOST_BFM.run_rx();
    join_none
end
//////////////////////////////////////////////////////////////////////////////////
//
// ETH logger / PCAP
//
rgmii_rx_if U_RGMII_RX (U_HOST_BFM.i_rgmii_rx_clk); // U_HOST_BFM-rx
assign U_RGMII_RX.i_rxc  = U_HOST_BFM.i_rgmii_rx_ctrl;
assign U_RGMII_RX.iv_rxd = U_HOST_BFM.iv_rgmii_rxd;

rgmii_rx_if U_RGMII_TX (U_HOST_BFM.o_rgmii_tx_clk); // U_HOST_BFM-tx
assign U_RGMII_TX.i_rxc  = U_HOST_BFM.o_rgmii_tx_ctrl;
assign U_RGMII_TX.iv_rxd = U_HOST_BFM.ov_rgmii_txd;

`include "bfm_eth_log_cl.sv"
bfm_eth_log_cl s_bfm_eth_log;
initial
begin   :   ETH_LOG_INIT
    s_bfm_eth_log = new("elog_hrx", U_RGMII_RX, U_RGMII_TX);
    s_bfm_eth_log.init(); ##10;
    s_bfm_eth_log.log_run();
end
//////////////////////////////////////////////////////////////////////////////////
//
// TB Tasks
//
task dut_arst;
    // simple async
    s_rst <= 1; #(p_Tclk);
    s_rst <= 0;
    // Final
endtask : dut_arst

default clocking cb @(s_sys_clk);
endclocking : cb

//////////////////////////////////////////////////////////////////////////////////
endmodule
