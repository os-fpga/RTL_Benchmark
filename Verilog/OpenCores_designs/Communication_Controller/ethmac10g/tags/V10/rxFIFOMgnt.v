`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    16:23:08 11/24/05
// Design Name:    
// Module Name:    rxFIFOMgnt
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module rxFIFOMgnt(rxclk_180, reset, rxd64, rxc_fifo, inband_fcs, receiving, recv_end, rx_data_valid, rx_data);
    input rxclk_180;
    input reset;
    input [63:0] rxd64;
	 input [7:0] rxc_fifo;
	 input receiving;
	 input recv_end;
	 input inband_fcs;

	 output[7:0] rx_data_valid;
	 output[63:0] rx_data;

	 wire rxfifo_full;
	 wire rxfifo_empty;
	 wire[7:0] byte_cnt;
	 wire fifo_rd_en;
	 wire fifo_wr_en;

	 assign fifo_rd_en = ~rxfifo_empty;
	 assign fifo_wr_en = receiving & ~recv_end;
	 
	 rxdatafifo rxdatain(.clk(rxclk_180),
	                  .sinit(reset),
	                  .din(rxd64),
	       				.wr_en(fifo_wr_en),
                   	.rd_en(fifo_rd_en),
	                  .dout(rx_data),
	                  .full(rxfifo_full),
	                  .empty(rxfifo_empty),
	                  .data_count(byte_cnt));

	 rxcntrlfifo rxcntrlin(.clk(rxclk_180),
	                  .sinit(reset),
	                  .din(rxc_fifo),
	       				.wr_en(fifo_wr_en),
                   	.rd_en(fifo_rd_en),
	                  .dout(rx_data_valid),
	                  .full(),
	                  .empty());
	                  


endmodule
