// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcuart100_config.vh"
`include "atcuart100_const.vh"

module atcuart100_txctrl (
`ifdef ATCUART100_UCLK_PCLK_SAME
`else
	  uclk,
	  urstn,
`endif
	  pclk,
	  presetn,
	  fifo_enable,
	  dma_mode,
	  txfifo_threshold,
	  fcr_txfifo_rst,
	  uart_auto_cts,
	  txfifo_datain,
	  txfifo_write,
	  txfifo_empty,
	  tx_shift_empty,
	  txfifo_full,
	  txfifo_dataout,
	  tx_data_ready,
	  txfifo_read,
	  uart_tx_busy,
	  tx_active,
	  dma_tx_req,
	  dma_tx_ack
);
localparam [31:0] TX_FIFO_DEPTH =  (1<<`ATCUART100_FIFO_DEPTH_BIT);
`ifdef ATCUART100_UCLK_PCLK_SAME
`else
input				uclk;
input				urstn;
`endif
input				pclk;
input				presetn;

input				fifo_enable;
input				dma_mode;
input	[1:0]			txfifo_threshold;
input				fcr_txfifo_rst;
input				uart_auto_cts;
input	[7:0]			txfifo_datain;
input				txfifo_write;
output				txfifo_empty;
output				tx_shift_empty;
output				txfifo_full;

output	[7:0]			txfifo_dataout;
output				tx_data_ready;
input				txfifo_read;
input				uart_tx_busy;
output				tx_active;

output				dma_tx_req;
input				dma_tx_ack;

wire					s0;
wire					s1;
wire					txfifo_full;
wire	[7:0]				s2;
wire					s3;
wire	[`ATCUART100_FIFO_DEPTH_BIT:0]	s4;

wire	[`ATCUART100_FIFO_DEPTH_BIT:0]	wr_ptr;
wire	[`ATCUART100_FIFO_DEPTH_BIT:0]	rd_ptr;
`ifdef ATCUART100_UCLK_PCLK_SAME
`else
reg					s5;
wire					s6;
wire					s7;
wire					s8;
wire					s9;
`endif

wire					s10;
reg					s11;

assign tx_data_ready = s1 & uart_auto_cts;
assign tx_active = tx_data_ready | uart_tx_busy;
`ifdef ATCUART100_UCLK_PCLK_SAME
assign tx_shift_empty = (~uart_tx_busy);
`else
always @(negedge urstn or posedge uclk)
begin
	if (~urstn)
		s5 <= 1'b0;
	else
		s5 <= uart_tx_busy;
end

nds_sync_l2l lsr_overrun_syn (
	.b_reset_n(presetn),
	.b_clk(pclk),
	.a_signal(s5),
	.b_signal(s6),
	.b_signal_rising_edge_pulse(),
	.b_signal_falling_edge_pulse(),
	.b_signal_edge_pulse()
);


assign tx_shift_empty = ((~s6) & (~s9));
`endif

nds_sync_fifo_clr #(
        .DATA_WIDTH (8),
        .FIFO_DEPTH (TX_FIFO_DEPTH),
        .POINTER_INDEX_WIDTH ((`ATCUART100_FIFO_DEPTH_BIT + 1))
) uart_txfifo (
	.reset_n(presetn),
	.clk(pclk),
	.wr(txfifo_write),
	.wr_data(txfifo_datain),
	.rd(s0),
	.rd_data(s2),
	.empty(txfifo_empty),
	.full(s3),
	.fifo_clr(fcr_txfifo_rst),
	.wr_ptr(wr_ptr),
	.rd_ptr(rd_ptr)
);

assign s4   = {s3, {wr_ptr[`ATCUART100_FIFO_DEPTH_BIT-1:0] - rd_ptr[`ATCUART100_FIFO_DEPTH_BIT-1:0]}};
`ifdef ATCUART100_UCLK_PCLK_SAME
assign txfifo_dataout   = s2;
assign s1    = (~txfifo_empty);
assign s0 = txfifo_read;

`else
nds_async_buff #(.DATA_WIDTH (8)) tx_holding (
	.w_reset_n(presetn),
	.r_reset_n(urstn),
	.w_clk(pclk),
	.r_clk(uclk),
	.wr(s0),
	.wr_data(s2),
	.rd(s7),
	.rd_data(txfifo_dataout),
	.empty(s8),
	.full(s9)
);

assign s7 = (txfifo_read & (~s8));

assign s1    = (~s8);
assign s0 = ((~s9) & (~txfifo_empty) & (~fcr_txfifo_rst));

`endif

assign txfifo_full = (fifo_enable ? s3 : ~txfifo_empty);

assign s10 = ((txfifo_threshold == 2'h0) ? (~txfifo_full) :
			((txfifo_threshold == 2'h1) ? (s4[`ATCUART100_FIFO_DEPTH_BIT:`ATCUART100_FIFO_DEPTH_BIT-2] < 3'b011) :
			((txfifo_threshold == 2'h2) ? (s4[`ATCUART100_FIFO_DEPTH_BIT:`ATCUART100_FIFO_DEPTH_BIT-1] < 2'b01) :
						   (~(|s4[`ATCUART100_FIFO_DEPTH_BIT:2])) )));

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s11 <= 1'b0;
	else if (dma_tx_ack)
		s11 <= 1'b0;
	else if (dma_mode & fifo_enable)
		s11 <= (s11 | s10);
	else
		s11 <= (s11 | (~txfifo_full));
end

assign dma_tx_req = s11;

endmodule
