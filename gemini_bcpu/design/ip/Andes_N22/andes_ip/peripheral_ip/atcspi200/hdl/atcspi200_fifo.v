// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcspi200_config.vh"
`include "atcspi200_const.vh"

module atcspi200_fifo(
	  spi_clock,
	  spi_rstn,
	  sysclk,
	  sysrstn,
	  txf_clr_sysclk,
	  txf_wr,
	  txf_wr_data,
	  txf_rd,
	  txf_rd_data,
	  txf_empty,
	  txf_full,
	  txf_entries,
	  txf_clr_level,
	  rxf_clr_sysclk,
	  rxf_wr,
	  rxf_wr_data,
	  rxf_rd,
	  rxf_rd_data,
	  rxf_empty,
	  rxf_full,
	  rxf_entries,
	  rxf_clr_level
);

localparam TX_FIFO_DEPTH = `ATCSPI200_TXFIFO_DEPTH;
localparam RX_FIFO_DEPTH = `ATCSPI200_RXFIFO_DEPTH;

input		spi_clock;
input		spi_rstn;
input		sysclk;
input		sysrstn;

input		txf_clr_sysclk;
input		txf_wr;
input	[31:0]	txf_wr_data;
input		txf_rd;
output	[31:0]	txf_rd_data;
output		txf_empty;
output		txf_full;
output	[`ATCSPI200_TXFPTR_BITS-1:0]	txf_entries;
output		txf_clr_level;

input		rxf_clr_sysclk;
input		rxf_wr;
input	[31:0]	rxf_wr_data;
input		rxf_rd;
output	[31:0]	rxf_rd_data;
output		rxf_empty;
output		rxf_full;
output	[`ATCSPI200_RXFPTR_BITS-1:0]	rxf_entries;
output		rxf_clr_level;

reg		txf_clr_level;
reg		rxf_clr_level;
wire		s0, s1;
wire		s2, s3;

always @(negedge sysrstn or posedge sysclk)
begin
	if (~sysrstn)
		txf_clr_level <= 1'b0;
	else if (txf_clr_sysclk)
		txf_clr_level <= 1'b1;
	else if (s1)
		txf_clr_level <= 1'b0;
end

nds_sync_l2l txf_clr_sync(
	.b_reset_n			(spi_rstn),
	.b_clk				(spi_clock),
	.a_signal			(txf_clr_level),
	.b_signal			(s0),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);
nds_sync_l2l txf_clr_ack_sync(
	.b_reset_n			(sysrstn),
	.b_clk				(sysclk),
	.a_signal			(s0),
	.b_signal			(s1),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);


nds_async_fifo_clr #(
        .DATA_WIDTH (32),
        .FIFO_DEPTH (TX_FIFO_DEPTH),
        .POINTER_INDEX_WIDTH (`ATCSPI200_TXFPTR_BITS)
) u_spi_txfifo(
	.w_reset_n(sysrstn),
	.r_reset_n(spi_rstn),
	.w_clk(sysclk),
	.r_clk(spi_clock),
	.w_fifo_clr(txf_clr_level),
	.r_fifo_clr(s0),
	.wr(txf_wr),
	.wr_data(txf_wr_data),
	.rd(txf_rd),
	.rd_data(txf_rd_data),
	.empty(txf_empty),
	.full(txf_full),
	.w_data_num(txf_entries),
	.r_data_num()
);


always @(negedge sysrstn or posedge sysclk)
begin
	if (~sysrstn)
		rxf_clr_level <= 1'b0;
	else if (rxf_clr_sysclk)
		rxf_clr_level <= 1'b1;
	else if (s3)
		rxf_clr_level <= 1'b0;
end

nds_sync_l2l rxf_clr_sync(
	.b_reset_n			(spi_rstn),
	.b_clk				(spi_clock),
	.a_signal			(rxf_clr_level),
	.b_signal			(s2),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);
nds_sync_l2l rxf_clr_ack_sync(
	.b_reset_n			(sysrstn),
	.b_clk				(sysclk),
	.a_signal			(s2),
	.b_signal			(s3),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

nds_async_fifo_clr #(
        .DATA_WIDTH (32),
        .FIFO_DEPTH (RX_FIFO_DEPTH),
        .POINTER_INDEX_WIDTH (`ATCSPI200_RXFPTR_BITS)
) u_spi_rxfifo(
	.w_reset_n(spi_rstn),
	.r_reset_n(sysrstn),
	.w_clk(spi_clock),
	.r_clk(sysclk),
	.w_fifo_clr(s2),
	.r_fifo_clr(rxf_clr_level),
	.wr(rxf_wr),
	.wr_data(rxf_wr_data),
	.rd(rxf_rd),
	.rd_data(rxf_rd_data),
	.empty(rxf_empty),
	.full(rxf_full),
	.w_data_num(),
	.r_data_num(rxf_entries)
);

endmodule
