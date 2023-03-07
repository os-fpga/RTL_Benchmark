// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcspi200_config.vh"
`include "atcspi200_const.vh"

module atcspi200_regif_ctrl (
`ifdef ATCSPI200_SLAVE_SUPPORT
	  spi_master,
`endif
	  reg_txf_data_num,
	  reg_data_merge,
	  reg_txf_wr_regclk,
	  reg_trans_end_regclk,
	  regrstn,
	  regclk,
	  spi_reset_regclk,
	  reg_spi_tramode,
	  reg_txf_full,
	  reg_rxf_empty,
	  reg_tx_dma_en,
	  reg_rx_dma_en,
	  spi_tx_dma_req,
	  spi_rx_dma_req,
	  spi_tx_dma_ack,
	  spi_rx_dma_ack,
	  txf_threshold_trigger,
	  rxf_threshold_trigger,
	  reg_opcode
);

`ifdef ATCSPI200_SLAVE_SUPPORT
input		spi_master;
`endif

input	[8:0]	reg_txf_data_num;
input		reg_data_merge;
input		reg_txf_wr_regclk;
input		reg_trans_end_regclk;

input		regrstn;
input		regclk;
input		spi_reset_regclk;
input	[3:0]	reg_spi_tramode;

input		reg_txf_full;
input		reg_rxf_empty;

input		reg_tx_dma_en;
input		reg_rx_dma_en;
output		spi_tx_dma_req;
output		spi_rx_dma_req;
input		spi_tx_dma_ack;
input		spi_rx_dma_ack;

input		txf_threshold_trigger;
input		rxf_threshold_trigger;
input	[7:0]	reg_opcode;
`ifdef ATCSPI200_SLAVE_SUPPORT
`else
	wire	spi_master = 1'b1;
`endif
wire		s0;
wire		s1;
wire		s2;
reg	[9:0]	s3;
wire		s4;
wire		s5;

reg		s6;
reg		s7;
wire		s8;

reg		s9;
wire		s10;
wire		s11;

parameter       SLAVE_RDATA1    = 8'h0b,
                SLAVE_RDATA2    = 8'h0c,
                SLAVE_RDATA4    = 8'h0e;


assign s0 = (reg_spi_tramode == 4'h0) || (reg_spi_tramode == 4'h3) || (reg_spi_tramode == 4'h4) || (reg_spi_tramode == 4'h5) || (reg_spi_tramode == 4'h6);
assign s1 = s0 || (reg_spi_tramode == 4'h1) || (reg_spi_tramode == 4'h8);
assign s2 = s0 || (reg_spi_tramode == 4'h2) || (reg_spi_tramode == 4'h9);

assign s11 = !spi_master && ((reg_opcode == SLAVE_RDATA1) || (reg_opcode == SLAVE_RDATA2) || (reg_opcode == SLAVE_RDATA4));

always @(negedge regrstn or posedge regclk)
begin
	if (~regrstn)
		s3 <= 10'b0;
	else if (spi_reset_regclk | reg_trans_end_regclk)
		s3 <= 10'b0;
	else if (reg_txf_wr_regclk)
		s3 <= s3 + (reg_data_merge ? 10'h4 : 10'h1);
end

assign s8 = s11 ? 1'b0 : (s3 > {1'b0, reg_txf_data_num});
assign s4 = !reg_txf_full && txf_threshold_trigger && s1 && !s8;

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		s6 <= 1'b0;
	else if (spi_reset_regclk || !reg_tx_dma_en)
		s6 <= 1'b0;
	else if (spi_tx_dma_ack)
		s6 <= 1'b0;
	else if (s4)
		s6 <= 1'b1;
end

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		s9 <= 1'b0;
	else if (spi_reset_regclk)
		s9 <= 1'b0;
	else if (reg_trans_end_regclk)
		s9 <= 1'b1;
	else if (s9)
		s9 <= ~reg_rxf_empty;
end

assign s10 = (reg_trans_end_regclk || s9);
assign s5 = !reg_rxf_empty && (rxf_threshold_trigger || s10) && s2;

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		s7 <= 1'b0;
	else if (spi_reset_regclk || !reg_rx_dma_en)
		s7 <= 1'b0;
	else if (spi_rx_dma_ack)
		s7 <= 1'b0;
	else if (s5)
		s7 <= 1'b1;
end

assign spi_tx_dma_req = s6;
assign spi_rx_dma_req = s7;

endmodule

