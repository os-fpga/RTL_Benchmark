//////////////////////////////////////////////////////////////////////////////////
// Company:          
// Engineer:        IK
// 
// Create Date:     11:35:01 03/21/2013 
// Design Name:     
// Module Name:     eth_host_bfm
// Project Name:    
// Target Devices:  
// Tool versions:   
// Description:     
//                  
//                  DPC-C import:
//                      -> 'test_bfm' / {net-adapt}
//                  
//                  DPI-C export:
//                  
//                      -> host_initial
//                      -> host_delay
//                      -> host_final
//                  
//                      -> eth_frm_read_len
//                      -> eth_frm_read
//                  
//                      -> eth_frm_write_len
//                      -> eth_frm_write
//                  
// Revision: 
// Revision 0.01 - File Created, 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module eth_host_bfm #(parameter p_ETH_MTU = 1536)
(
    // RSTi
    input   i_arst,
    // RGMII-RX
    input           i_rgmii_rx_clk,
    input           i_rgmii_rx_ctrl,
    input   [ 3:0]  iv_rgmii_rxd,
    // RGMII-TX
    output  logic           o_rgmii_tx_clk,
    output  logic           o_rgmii_tx_ctrl,
    output  logic   [ 3:0]  ov_rgmii_txd
);
//////////////////////////////////////////////////////////////////////////////////
localparam lp_BQNTY = 8;
//////////////////////////////////////////////////////////////////////////////////
// eth-pkt record
typedef struct {
    bit [7:0] data[];
    int len;
} packet_t;
// mbox for eth-pkt
typedef mailbox#(packet_t) pkt_mbox_t;
//////////////////////////////////////////////////////////////////////////////////
    // PKT-mboxes / TX+RX parts
    pkt_mbox_t tx_pkt_mailbox = new(/*lp_BQNTY*/);
    pkt_mbox_t rx_pkt_mailbox = new(lp_BQNTY);
    // 4dbg-tx
    packet_t    tx_pkt;
    int         tx_pkt_idx;
    // 4dbg-rx
    packet_t    rx_pkt;
    int         rx_pkt_idx;
    
    bit [7:0] data0 [256];
    int len0;
    
    // low-tx
    packet_t        tx_pkt_low;
    bit     [ 7:0]  sv_rgmii_txd;
    int             si_eth_tx_frm_cnt;
    // low-rx
    packet_t        rx_pkt_low;
    bit     [ 7:0]  sv_rgmii_rxd;
    bit             s_rgmii_rx_frm_end;
    int             si_eth_rx_frm_cnt;
    
//////////////////////////////////////////////////////////////////////////////////
//
// RGMII RX-TX Init
//
initial 
begin   :   INIT
    // tx-ctrl
    o_rgmii_tx_clk = 0;
    o_rgmii_tx_ctrl = 0;
    ov_rgmii_txd = 0;
    // pkt
    tx_pkt_low.data = new [p_ETH_MTU];
    tx_pkt_low.len = -1;
    
    rx_pkt_low.data = new [p_ETH_MTU];
    rx_pkt_low.len = -1;
    
    rx_pkt.data = new [p_ETH_MTU];
    rx_pkt.len = -1;
    rx_pkt_idx = 0;
    
    tx_pkt_idx = 0;
    tx_pkt.data = new [p_ETH_MTU];
    tx_pkt.len = -1;
    
            // init-data
            tx_pkt.data[0] = 8'h55;
            tx_pkt.data[1] = 8'h55;
            tx_pkt.data[2] = 8'h55;
            tx_pkt.data[3] = 8'h55;
            tx_pkt.data[4] = 8'h55;
            tx_pkt.data[5] = 8'h55;
            tx_pkt.data[6] = 8'h55;
            tx_pkt.data[7] = 8'hD5;

    // Final
end
//////////////////////////////////////////////////////////////////////////////////
//
// RGMII RX-TX Clocking
//
clocking cb_rx @(posedge i_rgmii_rx_clk);
endclocking : cb_rx;

clocking cb_tx @(posedge o_rgmii_tx_clk);
endclocking : cb_tx;

always 
begin   :   TX_CLK
    #(4ns) o_rgmii_tx_clk <= !o_rgmii_tx_clk;
end

//////////////////////////////////////////////////////////////////////////////////
//
// HDL RGMII
//
task run_tx;
    // 
   forever
        eth_tx_frm();
    // Final
endtask : run_tx

task run_rx;
    // 
   forever
        eth_rx_frm();
    // Final
endtask : run_rx
//////////////////////////////////////////////////////////////////////////////////
//
// RGMII-TX
//
task eth_tx_frm;
    // 
    //
    @cb_tx;
    if (tx_pkt_mailbox.num())
        begin   :   ETH_TX
            // init
            sv_rgmii_txd = 0;
            si_eth_tx_frm_cnt = 0;
            // get
            tx_pkt_mailbox.get(tx_pkt_low);
            // chk
            /*if ((tx_pkt_low.len + 8) < (64 + 8))
                tx_pkt_low.len = 64;*/
            // out
            do begin : OUT
                sv_rgmii_txd = tx_pkt_low.data[si_eth_tx_frm_cnt++];
                write_byte(sv_rgmii_txd, (si_eth_tx_frm_cnt == (tx_pkt_low.len + 8)));
            end while (si_eth_tx_frm_cnt != (tx_pkt_low.len + 8));
        end
    // Final
endtask : eth_tx_frm

task write_byte(input bit [7:0] iv_data, input bit i_final);
    // 
    @(negedge o_rgmii_tx_clk); #2ns;
    o_rgmii_tx_ctrl <= 1;
    ov_rgmii_txd <= iv_data[3:0];
    @(posedge o_rgmii_tx_clk); #2ns;
    ov_rgmii_txd <= iv_data[7:4];
    if (i_final)
        begin   :   END
            @(negedge o_rgmii_tx_clk); #2ns;
            o_rgmii_tx_ctrl <= 0;
            ov_rgmii_txd <= 0;
        end
    // Final
endtask : write_byte
//////////////////////////////////////////////////////////////////////////////////
//
// RGMII-RX
//
task eth_rx_frm;
    // 
    // wait for RXC rise
    do @(posedge i_rgmii_rx_clk or negedge i_rgmii_rx_clk);
    while(i_rgmii_rx_ctrl == 0);
    // init
    sv_rgmii_rxd = 0;
    s_rgmii_rx_frm_end = 0;
    si_eth_rx_frm_cnt = 0;
    // rx-proc
    do begin : RX
        read_byte((si_eth_rx_frm_cnt == 0), sv_rgmii_rxd, s_rgmii_rx_frm_end);
        if (!s_rgmii_rx_frm_end)
            begin   :   WRK
                if (si_eth_rx_frm_cnt > 7) // !=> cut {55, .., D5} here
                    begin   :   WR_RX_PKT
                        rx_pkt_low.data[(si_eth_rx_frm_cnt - 8)] = sv_rgmii_rxd;
                    end
                si_eth_rx_frm_cnt++;
            end
    end while (s_rgmii_rx_frm_end == 0);
    s_rgmii_rx_frm_end = 0;
    rx_pkt_low.len = (si_eth_rx_frm_cnt - 8); $display("[%t]: %m: len=%x", $time, rx_pkt_low.len);
    rx_pkt_mailbox.put(rx_pkt_low);
    // final-dly
    @cb_rx;
    // Final
endtask : eth_rx_frm

task read_byte(input bit i_init, output bit [7:0] ov_data, output bit o_end);
    // init
    ov_data = -1;
    o_end = 0;
    // rx-dly
    if (i_init == 0) // 2nd, 3rd, .. starts
        @(posedge i_rgmii_rx_clk or negedge i_rgmii_rx_clk); // initial start - NO-DLY (eth_rx_frm -> 'wait for RXC rise')
    // lsb / prev detected RXC == 1 {RXEN-marker}
    ov_data[3:0] = iv_rgmii_rxd;
    // msb
    @(posedge i_rgmii_rx_clk or negedge i_rgmii_rx_clk);
    ov_data[7:4] = iv_rgmii_rxd;
    // frm-end chk
    if (i_rgmii_rx_ctrl == 0)
        o_end = 1;
    // Final
endtask : read_byte
//////////////////////////////////////////////////////////////////////////////////
//
// DPC-C routines
//  => GLBL
//

// DPI-C export / cpp-hdl
export "DPI-C" task host_initial;
export "DPI-C" task host_delay;
export "DPI-C" task host_final;

task host_initial;
    // 
    do @cb_tx; // use our stable TX-CLK
    while (i_arst == 1); 
    repeat(100) @cb_tx;
    $display("[%t]: %m: START", $time); 
    // Final
endtask : host_initial

task host_delay(input int ii_value);
    //
    repeat(ii_value)
        @cb_tx;
    // Final
endtask : host_delay

task host_final;
    //
    repeat(10) @cb_tx;
    $finish;//$stop;
    // Final
endtask : host_final


// DPC-C import / MAIN
import "DPI-C" context task test_bfm();

initial 
begin   :   MAIN_NET_ADAPT
    test_bfm();
end

//////////////////////////////////////////////////////////////////////////////////
//
// DPC-C routines
//  => RGMII-RX
//

export "DPI-C" task eth_frm_read_len;
export "DPI-C" task eth_frm_read;

task eth_frm_read_len(output int ov_len);
    // 
    @cb_rx; // !!!
    if (rx_pkt_mailbox.num())
        begin   :   HAVE_RXD
            rx_pkt_mailbox.get(rx_pkt);
            ov_len = rx_pkt.len;
            rx_pkt_idx++; $display("[%t]: %m: len=%x", $time, rx_pkt.len);
        end
    else
        ov_len = -1;
    // Final
endtask : eth_frm_read_len

task eth_frm_read(output int ov_data, input int iv_position);
    // 
    ov_data = rx_pkt.data[iv_position];
    // Final
endtask : eth_frm_read
//////////////////////////////////////////////////////////////////////////////////
//
// DPC-C routines
//  => RGMII-TX
//

export "DPI-C" task eth_frm_write_len; // !=> init pkt-PUT
export "DPI-C" task eth_frm_write;

task eth_frm_write_len(input int iv_len);
    
    len0 = iv_len;
    for (int i = 0; i < iv_len; i++) begin data0[i] = tx_pkt.data[i]; end
    
    // put
    tx_pkt.len = iv_len; 
    tx_pkt_mailbox.put(tx_pkt);
    // nxt-idx
    tx_pkt_idx++;
    // Final
endtask : eth_frm_write_len;

task eth_frm_write(input int iv_data, input int iv_position);
    // wr
    @cb_tx; // !!!
    tx_pkt.data[iv_position+8] = iv_data;
    // Final
endtask : eth_frm_write


//////////////////////////////////////////////////////////////////////////////////
endmodule
