//////////////////////////////////////////////////////////////////////
////                                                              ////
////  tb_ethernet.v                                               ////
////                                                              ////
////  This file is part of the Ethernet IP core project           ////
////  http://www.opencores.org/projects/ethmac/                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Igor Mohor (igorM@opencores.org)                      ////
////                                                              ////
////  All additional information is avaliable in the Readme.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2001, 2002 Authors                             ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.2  2002/07/19 14:02:47  mohor
// Clock mrx_clk set to 2.5 MHz.
//
// Revision 1.1  2002/07/19 13:57:53  mohor
// Testing environment also includes traffic cop, memory interface and host
// interface.
//
//
//
//
//



`include "tb_eth_defines.v"
`include "eth_defines.v"
`include "timescale.v"

module tb_ethernet();


parameter Tp = 1;


reg           wb_clk_o;
reg           wb_rst_o;

reg           mtx_clk;
reg           mrx_clk;

wire   [3:0]  MTxD;
wire          MTxEn;
wire          MTxErr;

reg    [3:0]  MRxD;     // This goes to PHY
reg           MRxDV;    // This goes to PHY
reg           MRxErr;   // This goes to PHY
reg           MColl;    // This goes to PHY
reg           MCrs;     // This goes to PHY

wire          Mdi_I;
wire          Mdo_O;
wire          Mdo_OE;
wire          Mdc_O;

integer tx_log;
integer rx_log;

reg StartTB;

`ifdef ETH_XILINX_RAMB4
  reg gsr;
`endif


integer packet_ready_cnt, send_packet_cnt;


// Ethernet Slave Interface signals
wire [31:0] eth_sl_wb_adr_i, eth_sl_wb_dat_o, eth_sl_wb_dat_i;
wire  [3:0] eth_sl_wb_sel_i;
wire        eth_sl_wb_we_i, eth_sl_wb_cyc_i, eth_sl_wb_stb_i, eth_sl_wb_ack_o, eth_sl_wb_err_o;

// Memory Slave Interface signals
wire [31:0] mem_sl_wb_adr_i, mem_sl_wb_dat_o, mem_sl_wb_dat_i;
wire  [3:0] mem_sl_wb_sel_i;
wire        mem_sl_wb_we_i, mem_sl_wb_cyc_i, mem_sl_wb_stb_i, mem_sl_wb_ack_o, mem_sl_wb_err_o;

// Ethernet Master Interface signals
wire [31:0] eth_ma_wb_adr_o, eth_ma_wb_dat_i, eth_ma_wb_dat_o;
wire  [3:0] eth_ma_wb_sel_o;
wire        eth_ma_wb_we_o, eth_ma_wb_cyc_o, eth_ma_wb_stb_o, eth_ma_wb_ack_i, eth_ma_wb_err_i;

// Host Master Interface signals
wire [31:0] host_ma_wb_adr_o, host_ma_wb_dat_i, host_ma_wb_dat_o;
wire  [3:0] host_ma_wb_sel_o;
wire        host_ma_wb_we_o, host_ma_wb_cyc_o, host_ma_wb_stb_o, host_ma_wb_ack_i, host_ma_wb_err_i;



eth_cop i_eth_cop
(
  // WISHBONE common
  .wb_clk_i(wb_clk_o), .wb_rst_i(wb_rst_o), 

  // WISHBONE MASTER 1  Ethernet Master Interface is connected here
  .m1_wb_adr_i(eth_ma_wb_adr_o),  .m1_wb_sel_i(eth_ma_wb_sel_o),  .m1_wb_we_i (eth_ma_wb_we_o), 
  .m1_wb_dat_o(eth_ma_wb_dat_i),  .m1_wb_dat_i(eth_ma_wb_dat_o),  .m1_wb_cyc_i(eth_ma_wb_cyc_o), 
  .m1_wb_stb_i(eth_ma_wb_stb_o),  .m1_wb_ack_o(eth_ma_wb_ack_i),  .m1_wb_err_o(eth_ma_wb_err_i), 

  // WISHBONE MASTER 2  Host Interface is connected here
  .m2_wb_adr_i(host_ma_wb_adr_o), .m2_wb_sel_i(host_ma_wb_sel_o), .m2_wb_we_i (host_ma_wb_we_o), 
  .m2_wb_dat_o(host_ma_wb_dat_i), .m2_wb_dat_i(host_ma_wb_dat_o), .m2_wb_cyc_i(host_ma_wb_cyc_o), 
  .m2_wb_stb_i(host_ma_wb_stb_o), .m2_wb_ack_o(host_ma_wb_ack_i), .m2_wb_err_o(host_ma_wb_err_i), 

  // WISHBONE slave 1   Ethernet Slave Interface is connected here
 	.s1_wb_adr_o(eth_sl_wb_adr_i),  .s1_wb_sel_o(eth_sl_wb_sel_i),  .s1_wb_we_o (eth_sl_wb_we_i), 
 	.s1_wb_cyc_o(eth_sl_wb_cyc_i),  .s1_wb_stb_o(eth_sl_wb_stb_i),  .s1_wb_ack_i(eth_sl_wb_ack_o), 
 	.s1_wb_err_i(eth_sl_wb_err_o),  .s1_wb_dat_i(eth_sl_wb_dat_o),  .s1_wb_dat_o(eth_sl_wb_dat_i), 

  // WISHBONE slave 2   Memory Interface is connected here
 	.s2_wb_adr_o(mem_sl_wb_adr_i),  .s2_wb_sel_o(mem_sl_wb_sel_i),  .s2_wb_we_o (mem_sl_wb_we_i), 
 	.s2_wb_cyc_o(mem_sl_wb_cyc_i),  .s2_wb_stb_o(mem_sl_wb_stb_i),  .s2_wb_ack_i(mem_sl_wb_ack_o), 
 	.s2_wb_err_i(mem_sl_wb_err_o),  .s2_wb_dat_i(mem_sl_wb_dat_o),  .s2_wb_dat_o(mem_sl_wb_dat_i)
);




// Connecting Ethernet top module
eth_top ethtop
(
  // WISHBONE common
  .wb_clk_i(wb_clk_o),              .wb_rst_i(wb_rst_o), 

  // WISHBONE slave
 	.wb_adr_i(eth_sl_wb_adr_i[11:2]), .wb_sel_i(eth_sl_wb_sel_i),   .wb_we_i(eth_sl_wb_we_i), 
 	.wb_cyc_i(eth_sl_wb_cyc_i),       .wb_stb_i(eth_sl_wb_stb_i),   .wb_ack_o(eth_sl_wb_ack_o), 
 	.wb_err_o(eth_sl_wb_err_o),       .wb_dat_i(eth_sl_wb_dat_i),   .wb_dat_o(eth_sl_wb_dat_o), 
 	
  // WISHBONE master
  .m_wb_adr_o(eth_ma_wb_adr_o),     .m_wb_sel_o(eth_ma_wb_sel_o), .m_wb_we_o(eth_ma_wb_we_o), 
  .m_wb_dat_i(eth_ma_wb_dat_i),     .m_wb_dat_o(eth_ma_wb_dat_o), .m_wb_cyc_o(eth_ma_wb_cyc_o), 
  .m_wb_stb_o(eth_ma_wb_stb_o),     .m_wb_ack_i(eth_ma_wb_ack_i), .m_wb_err_i(eth_ma_wb_err_i), 

  //TX
  .mtx_clk_pad_i(mtx_clk), .mtxd_pad_o(MTxD), .mtxen_pad_o(MTxEn), .mtxerr_pad_o(MTxErr),

  //RX
  .mrx_clk_pad_i(mrx_clk), .mrxd_pad_i(MRxD), .mrxdv_pad_i(MRxDV), .mrxerr_pad_i(MRxErr), 
  .mcoll_pad_i(MColl),    .mcrs_pad_i(MCrs), 
  
  // MIIM
  .mdc_pad_o(Mdc_O), .md_pad_i(Mdi_I), .md_pad_o(Mdo_O), .md_padoe_o(Mdo_OE),
  
  .int_o()
);



// Connecting Memory Interface Module
eth_memory i_eth_memory
(
  // WISHBONE common
 	.wb_clk_i(wb_clk_o),         .wb_rst_i(wb_rst_o), 

  // WISHBONE slave:   Memory Interface is connected here
 	.wb_adr_i(mem_sl_wb_adr_i),  .wb_sel_i(mem_sl_wb_sel_i),  .wb_we_i (mem_sl_wb_we_i), 
 	.wb_cyc_i(mem_sl_wb_cyc_i),  .wb_stb_i(mem_sl_wb_stb_i),  .wb_ack_o(mem_sl_wb_ack_o), 
 	.wb_err_o(mem_sl_wb_err_o),  .wb_dat_o(mem_sl_wb_dat_o),  .wb_dat_i(mem_sl_wb_dat_i)
);


// Connecting Host Interface
eth_host eth_host
(
  // WISHBONE common
  .wb_clk_i(wb_clk_o),         .wb_rst_i(wb_rst_o), 

  // WISHBONE master
  .wb_adr_o(host_ma_wb_adr_o), .wb_sel_o(host_ma_wb_sel_o), .wb_we_o (host_ma_wb_we_o), 
  .wb_dat_i(host_ma_wb_dat_i), .wb_dat_o(host_ma_wb_dat_o), .wb_cyc_o(host_ma_wb_cyc_o), 
  .wb_stb_o(host_ma_wb_stb_o), .wb_ack_i(host_ma_wb_ack_i), .wb_err_i(host_ma_wb_err_i)
);





// Reset pulse
initial
begin
  MCrs=0;                                     // This should come from PHY
  MColl=0;                                    // This should come from PHY
  MRxD=0;                                     // This should come from PHY
  MRxDV=0;                                    // This should come from PHY
  MRxErr=0;                                   // This should come from PHY
  packet_ready_cnt = 0;
  send_packet_cnt = 0;
  tx_log = $fopen("ethernet_tx.log");
  rx_log = $fopen("ethernet_rx.log");
  wb_rst_o =  1'b1;
`ifdef ETH_XILINX_RAMB4
  gsr           =  1'b0;
  #100 gsr      =  1'b1;
  #100 gsr      =  1'b0;
`endif
  #100 wb_rst_o =  1'b0;
  #100 StartTB  =  1'b1;
end

`ifdef ETH_XILINX_RAMB4
  assign glbl.GSR = gsr;
`endif



// Generating wb_clk_o clock
initial
begin
  wb_clk_o=0;
//  forever #2.5 wb_clk_o = ~wb_clk_o;  // 2*2.5 ns -> 200.0 MHz    
//  forever #5 wb_clk_o = ~wb_clk_o;  // 2*5 ns -> 100.0 MHz    
//  forever #10 wb_clk_o = ~wb_clk_o;  // 2*10 ns -> 50.0 MHz    
  forever #12.5 wb_clk_o = ~wb_clk_o;  // 2*12.5 ns -> 40 MHz    
//  forever #15 wb_clk_o = ~wb_clk_o;  // 2*10 ns -> 33.3 MHz    
//  forever #20 wb_clk_o = ~wb_clk_o;  // 2*20 ns -> 25 MHz    
//  forever #25 wb_clk_o = ~wb_clk_o;  // 2*25 ns -> 20.0 MHz
//  forever #31.25 wb_clk_o = ~wb_clk_o;  // 2*31.25 ns -> 16.0 MHz    
//  forever #50 wb_clk_o = ~wb_clk_o;  // 2*50 ns -> 10.0 MHz
//  forever #55 wb_clk_o = ~wb_clk_o;  // 2*55 ns ->  9.1 MHz    
end

// Generating mtx_clk clock
initial
begin
  mtx_clk=0;
//  #3 forever #20 mtx_clk = ~mtx_clk;   // 2*20 ns -> 25 MHz
  #3 forever #200 mtx_clk = ~mtx_clk;   // 2*200 ns -> 2.5 MHz
end

// Generating mrx_clk clock
initial
begin
  mrx_clk=0;
//  #16 forever #20 mrx_clk = ~mrx_clk;   // 2*20 ns -> 25 MHz
  #16 forever #200 mrx_clk = ~mrx_clk;   // 2*200 ns -> 2.5 MHz
end

reg [31:0] tmp;
initial
begin
  wait(StartTB);  // Start of testbench
  

  eth_host.wb_write(`ETH_MODER, 4'hf, 32'h0); // Reset OFF
  eth_host.wb_read(`ETH_MODER, 4'hf, tmp);

  eth_host.wb_write(32'hd0000000, 4'hf, `ETH_MODER_RXEN  | `ETH_MODER_TXEN | `ETH_MODER_PRO | 
                                        `ETH_MODER_CRCEN | `ETH_MODER_PAD); // Set MODER register
  eth_host.wb_read(32'hd0000000, 4'hf, tmp);
  

  initialize_txbd(3);
  initialize_rxbd(6);

  set_packet(16'h34, 8'h1);
  set_packet(16'h34, 8'h11);
  send_packet;
  set_packet(16'h34, 8'h21);
  set_packet(16'h34, 8'h31);
  send_packet;

  GetDataOnMRxD(100, `BROADCAST_XFR); // LengthRx bytes is comming on MRxD[3:0] signals

  repeat (100) @(posedge mrx_clk);   // Waiting for TxEthMac to finish transmit


  GetDataOnMRxD(70, `BROADCAST_XFR); // LengthRx bytes is comming on MRxD[3:0] signals


  repeat (10000) @(posedge wb_clk_o);   // Waiting for TxEthMac to finish transmit
  
  $display("\n\n End of simulation");
  $stop;



end
  


task initialize_txbd;
  input [6:0] txbd_num;
  
  integer i;
  integer bd_status_addr, buf_addr, bd_ptr_addr;
  
  for(i=0; i<txbd_num; i=i+1) begin
    buf_addr = `TX_BUF_BASE + i * 32'h600;
    bd_status_addr = `TX_BD_BASE + i * 8;
    bd_ptr_addr = bd_status_addr + 4; 
    
    // Initializing BD - status
    if(i==txbd_num-1)
      eth_host.wb_write(bd_status_addr, 4'hf, 32'h00007800);    // last BD: + WRAP
    else
      eth_host.wb_write(bd_status_addr, 4'hf, 32'h00005800);    // IRQ + PAD + CRC

    eth_host.wb_write(bd_ptr_addr, 4'hf, buf_addr);             // Initializing BD - pointer
  end
endtask // initialize_txbd


task initialize_rxbd;
  input [6:0] rxbd_num;
  
  integer i;
  integer bd_status_addr, buf_addr, bd_ptr_addr;
  
  for(i=0; i<rxbd_num; i=i+1) begin
    buf_addr = `RX_BUF_BASE + i * 32'h600;
    bd_status_addr = `RX_BD_BASE + i * 8;
    bd_ptr_addr = bd_status_addr + 4; 
    
    // Initializing BD - status
    if(i==rxbd_num-1)
      eth_host.wb_write(bd_status_addr, 4'hf, 32'h0000e000);    // last BD: + WRAP
    else
      eth_host.wb_write(bd_status_addr, 4'hf, 32'h0000c000);    // IRQ + PAD + CRC

    eth_host.wb_write(bd_ptr_addr, 4'hf, buf_addr);             // Initializing BD - pointer
  end
endtask // initialize_rxbd


task set_packet;
  input  [15:0] len;
  input   [7:0] start_data;

  integer i, sd;
  integer bd_status_addr, bd_ptr_addr, buffer, bd;
  
  begin
    sd = start_data;
    bd_status_addr = `TX_BD_BASE + packet_ready_cnt * 8;
    bd_ptr_addr = bd_status_addr + 4; 
    
    // Reading BD + buffer pointer
    eth_host.wb_read(bd_status_addr, 4'hf, bd);
    eth_host.wb_read(bd_ptr_addr, 4'hf, buffer);

    while(bd & `ETH_TX_BD_READY) begin  // Buffer is ready. Don't touch !!!
      repeat(100) @(posedge wb_clk_o);
      i=i+1;
      eth_host.wb_read(bd_status_addr, 4'hf, bd);
      if(i>1000)  begin
        $display("(%0t)(%m)Waiting for TxBD ready to clear timeout", $time);
        $stop;
      end
    end

    // First write might not be word allign.
    if(buffer[1:0]==1)  begin
      eth_host.wb_write(buffer-1, 4'h7, {8'h0, sd[7:0], sd[7:0]+3'h1, sd[7:0]+3'h2});
      sd=sd+3;
      i=3;
    end
    else if(buffer[1:0]==2)  begin
      eth_host.wb_write(buffer-2, 4'h3, {16'h0, sd[7:0], sd[7:0]+3'h1});
      sd=sd+2;
      i=2;
    end      
    else if(buffer[1:0]==3)  begin
      eth_host.wb_write(buffer-3, 4'h1, {24'h0, sd[7:0]});
      sd=sd+1;
      i=1;
    end
    else
      i=0;


    for(i=i; i<len-4; i=i+4) begin   // Last 0-3 bytes are not written
      eth_host.wb_write(buffer+i, 4'hf, {sd[7:0], sd[7:0]+3'h1, sd[7:0]+3'h2, sd[7:0]+3'h3});
      sd=sd+4;
    end
    
    
    // Last word
    if(len-i==3)
      eth_host.wb_write(buffer+i, 4'he, {sd[7:0], sd[7:0]+3'h1, sd[7:0]+3'h2, 8'h0});
    else if(len-i==2)
      eth_host.wb_write(buffer+i, 4'hc, {sd[7:0], sd[7:0]+3'h1, 16'h0});
    else if(len-i==1)
      eth_host.wb_write(buffer+i, 4'h8, {sd[7:0], 24'h0});
    else if(len-i==4)
      eth_host.wb_write(buffer+i, 4'hf, {sd[7:0], sd[7:0]+3'h1, sd[7:0]+3'h2, sd[7:0]+3'h3});
    else
      $display("(%0t)(%m) ERROR", $time);
    

    // Checking WRAP bit
    if(bd & `ETH_TX_BD_WRAP)
      packet_ready_cnt = 0;
    else
      packet_ready_cnt = packet_ready_cnt+1;

    // Writing len to bd
    bd = bd | (len<<16);
    eth_host.wb_write(bd_status_addr, 4'hf, bd);
    
  end
endtask // set_packet


task send_packet;

  integer bd_status_addr, bd_ptr_addr, buffer, bd;
  
  begin
    bd_status_addr = `TX_BD_BASE + send_packet_cnt * 8;
    bd_ptr_addr = bd_status_addr + 4; 
    
    // Reading BD + buffer pointer
    eth_host.wb_read(bd_status_addr, 4'hf, bd);
    eth_host.wb_read(bd_ptr_addr, 4'hf, buffer);

    if(bd & `ETH_TX_BD_WRAP)
      send_packet_cnt=0;
    else
      send_packet_cnt=send_packet_cnt+1;

    // Setting ETH_TX_BD_READY bit
    bd = bd | `ETH_TX_BD_READY;
    eth_host.wb_write(bd_status_addr, 4'hf, bd);
  end


endtask // send_packet


task GetDataOnMRxD;
  input [15:0] Len;
  input [31:0] TransferType;
  integer tt;

  begin
    @ (posedge mrx_clk);
    #1MRxDV=1'b1;
    
    for(tt=0; tt<15; tt=tt+1)
      begin
        MRxD=4'h5;              // preamble
        @ (posedge mrx_clk);
        #1;
      end

    MRxD=4'hd;                // SFD
    
    for(tt=1; tt<(Len+1); tt=tt+1)
      begin
        @ (posedge mrx_clk);
        #1;
  	    if(TransferType == `UNICAST_XFR && tt == 1)
	        MRxD= 4'h0;   // Unicast transfer
	      else if(TransferType == `BROADCAST_XFR && tt < 7)
	        MRxD = 4'hf;
	      else
          MRxD=tt[3:0]; // Multicast transfer

        @ (posedge mrx_clk);
	      #1;
	      if(TransferType == `BROADCAST_XFR && tt < 7)
	        MRxD = 4'hf;
	      else
          MRxD=tt[7:4];
      end

    @ (posedge mrx_clk);
    #1;
    MRxDV=1'b0;
  end
endtask // GetDataOnMRxD


endmodule
