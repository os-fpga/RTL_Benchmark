//////////////////////////////////////////////////////////////////////////////////
// Company:          
// Engineer:        IK
// 
// Create Date:     11:35:01 03/21/2013 
// Design Name:     
// Module Name:     rgmii_rx_if
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

interface rgmii_rx_if 
(
    input i_clk
);
//////////////////////////////////////////////////////////////////////////////////
// 
localparam  lp_MTU = 1500;
// 
localparam  lp_ETH_SFD_LEN = 8; // ...the corresponding hexadecimal representation is 0x55 0x55 0x55 0x55 0x55 0x55 0x55 0xD5.
//////////////////////////////////////////////////////////////////////////////////
    // 
    logic           i_rxc;
    logic   [ 3:0]  iv_rxd;
    // 
    bit [ 7:0]  sv_rx_pkt[lp_MTU];
    int         sv_bpos;
    int         sv_rx_len;
    // 
    bit         s_verbose;
    
//////////////////////////////////////////////////////////////////////////////////
//
default clocking cb @(posedge i_clk or negedge i_clk);
endclocking : cb

//////////////////////////////////////////////////////////////////////////////////
//
task init(input i_verbose=0);
    // 
    sv_bpos = 0;
    sv_rx_len = 0;
    s_verbose = i_verbose;
    // 
    foreach(sv_rx_pkt[i])
        sv_rx_pkt[i] = 0;
    // Final
endtask : init

task rx_pkt;
    // 
    do @cb;
    while (i_rxc == 0);
    // 
    sv_bpos = 0;
    sv_rx_len = 0;
    foreach(sv_rx_pkt[i])
        sv_rx_pkt[i] = 0;
    // 
    do begin : RX_PKT
        // 
        if (sv_bpos == 0)
            begin
                sv_rx_pkt[sv_rx_len][3:0] = iv_rxd;
                sv_bpos = 1;
            end
        else
            begin
                sv_rx_pkt[sv_rx_len++][7:4] = iv_rxd;
                sv_bpos = 0;
            end
        //
        @cb;
        end while(i_rxc == 1); 
        if (s_verbose)
            $display("[%t]: %m: rx-done", $time);
    // 
endtask : rx_pkt
//////////////////////////////////////////////////////////////////////////////////
//
//
//

function int rx_pkt_len;
    return(sv_rx_len-lp_ETH_SFD_LEN);
endfunction : rx_pkt_len

function [7:0] rx_pkt_data(input int ii_idx);
    return(sv_rx_pkt[lp_ETH_SFD_LEN+ii_idx]);
endfunction : rx_pkt_data

//////////////////////////////////////////////////////////////////////////////////
endinterface : rgmii_rx_if
