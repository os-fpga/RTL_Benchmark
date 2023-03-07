// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


`include "atcspi200_config.vh"
`include "atcspi200_const.vh"

module atcspi200_spiif (
		  spi_rstn,
		  spi_clock,
		  scan_test,
		  scan_enable,
		  spi_reset_sclk,
		  spi_req,
		  spi_busy,
	`ifdef ATCSPI200_SLAVE_SUPPORT
		  spi_master,
		  spi_slave_cs_assert,
	`endif
		  first_slv_tx_word,
		  first_slv_tx_bit,
		  spi_mode,
		  spi_3line,
	`ifdef ATCSPI200_QUADSPI_SUPPORT
		  spi_quad,
	`endif
	`ifdef ATCSPI200_QUADDUAL_SUPPORT
		  spi_dual,
	`endif
		  reg_spiif_setting,
		  spi_cs_deassert,
		  spi_txdata_rd,
		  spi_rxdata_wr,
		  spi_tx_hold,
		  spi_rx_hold,
		  spi_txdata,
		  spi_oe,
		  spi_rxdata,
	`ifdef ATCSPI200_DIRECT_IO_SUPPORT
		  pio_enable,
		  pio_sclk_out,
		  pio_sclk_in,
		  pio_sclk_oe,
		  pio_cs_out,
		  pio_cs_in,
		  pio_cs_oe,
		  pio_miso_out,
		  pio_miso_in,
		  pio_miso_oe,
		  pio_mosi_out,
		  pio_mosi_in,
		  pio_mosi_oe,
	   `ifdef ATCSPI200_QUADSPI_SUPPORT
		  pio_wp_out,
		  pio_wp_in,
		  pio_wp_oe,
		  pio_hold_out,
		  pio_hold_in,
		  pio_hold_oe,
	   `endif
	`endif
	`ifdef ATCSPI200_QUADSPI_SUPPORT
		  spi_wp_n_in,
		  spi_wp_n_out,
		  spi_wp_n_oe,
		  spi_hold_n_in,
		  spi_hold_n_out,
		  spi_hold_n_oe,
	`endif
		  spi_clk_in,
		  spi_clk_out,
		  spi_clk_oe,
	`ifdef ATCSPI200_SLAVE_SUPPORT
		  spi_cs_n_in,
	`else
	   `ifdef ATCSPI200_DIRECT_IO_SUPPORT
		  spi_cs_n_in,
	   `endif
	`endif
		  spi_cs_n_out,
		  spi_cs_n_oe,
		  spi_mosi_in,
		  spi_mosi_out,
		  spi_mosi_oe,
		  spi_miso_in,
		  spi_miso_out,
		  spi_miso_oe
);
`ifdef ATCSPI200_QUADSPI_SUPPORT
	parameter SPI_IN_WIDTH = 4;
	parameter SPI_OUT_WIDTH = 4;
	parameter SPI_OE_WIDTH = 3;
`else
	parameter SPI_IN_WIDTH = 2;
	parameter SPI_OUT_WIDTH = 2;
	parameter SPI_OE_WIDTH = 2;
`endif

input		spi_rstn;
input		spi_clock;
input		scan_test;
input		scan_enable;
input		spi_reset_sclk;
input		spi_req;
output		spi_busy;
`ifdef ATCSPI200_SLAVE_SUPPORT
input		spi_master;
output		spi_slave_cs_assert;
`endif
input       first_slv_tx_word;
input       first_slv_tx_bit;
input	[1:0]	spi_mode;
input		spi_3line;
`ifdef ATCSPI200_QUADSPI_SUPPORT
input		spi_quad;
`endif
`ifdef ATCSPI200_QUADDUAL_SUPPORT
input		spi_dual;
`endif
input	[13:0]	reg_spiif_setting;
output		spi_cs_deassert;
output		spi_txdata_rd;
output		spi_rxdata_wr;
input		spi_tx_hold;
input		spi_rx_hold;
input	[3:0]	spi_txdata;
input	[2:0]	spi_oe;
output	[3:0]	spi_rxdata;

`ifdef ATCSPI200_DIRECT_IO_SUPPORT
	input		pio_enable;
	input		pio_sclk_out;
	output		pio_sclk_in;
	input		pio_sclk_oe;
	input		pio_cs_out;
	output		pio_cs_in;
	input		pio_cs_oe;
	input		pio_miso_out;
	output		pio_miso_in;
	input		pio_miso_oe;
	input		pio_mosi_out;
	output		pio_mosi_in;
	input		pio_mosi_oe;
	`ifdef ATCSPI200_QUADSPI_SUPPORT
		input	pio_wp_out;
		output	pio_wp_in;
		input	pio_wp_oe;
		input	pio_hold_out;
		output	pio_hold_in;
		input	pio_hold_oe;
	`endif
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
	input		spi_wp_n_in;
	output		spi_wp_n_out;
	output		spi_wp_n_oe;
	input		spi_hold_n_in;
	output		spi_hold_n_out;
	output		spi_hold_n_oe;
`endif
input			spi_clk_in;
output			spi_clk_out;
output			spi_clk_oe;
`ifdef ATCSPI200_SLAVE_SUPPORT
input			spi_cs_n_in;
`else
	`ifdef ATCSPI200_DIRECT_IO_SUPPORT
input			spi_cs_n_in;
	`endif
`endif
output			spi_cs_n_out;
output			spi_cs_n_oe;
input			spi_mosi_in;
output			spi_mosi_out;
output			spi_mosi_oe;
input			spi_miso_in;
output			spi_miso_out;
output			spi_miso_oe;

`ifdef ATCSPI200_SLAVE_SUPPORT
	reg		spi_oe_override;
	reg		[SPI_OE_WIDTH-1:0]	spi_oe_slv_r;
	reg		[SPI_OUT_WIDTH-1:0]	spi_out_slv_r;
`else
	wire		spi_oe_override = 1'b0;
	wire		[SPI_OE_WIDTH-1:0]	spi_oe_slv_r = {SPI_OE_WIDTH{1'b1}};
	wire		[SPI_OUT_WIDTH-1:0]	spi_out_slv_r = {SPI_OUT_WIDTH{1'b1}};
	wire		spi_master = 1'b1;
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
`else
	wire		spi_quad = 1'b0;
`endif
`ifdef ATCSPI200_QUADDUAL_SUPPORT
`else
	wire		spi_dual = 1'b0;
`endif
reg	[2:0]		spi_cs_r, spi_ns;
reg	[7:0]		period_cnt_r;
reg	[3:0]		clock_cnt_r;
wire			msclk_edge;
wire			msclk_edge_hold;
wire			spi_m_cs_end;
wire			spi_m_start_end;
wire			spi_m_end_end;
reg			master_sclk_r;
wire			master_sclk;
reg			master_cs_r;
reg			master_rxdata_wr_lvl_r;
reg	[SPI_OE_WIDTH-1:0]	spi_oe_r;
reg	[SPI_OUT_WIDTH-1:0]	spi_out_r;
reg	[SPI_IN_WIDTH-1:0]	spi_in_r;
reg	[SPI_IN_WIDTH-1:0]	spi_in_d1_r;
reg	[3:0]			spi_rxdata;

reg		spi_rx_hold_d_r;
wire		master_clk_en;
reg		master_clk_d_en_r;
wire		master_gclk_org;
wire		master_gclk_d;
wire		master_gclk;
wire		sclk_1t;

`ifdef ATCSPI200_SLAVE_SUPPORT
	wire		spi_clk_posedge;
	wire		spi_clk_negedge;
	wire		spi_cs_n_in_syn;
	wire		spi_cs_in_posedge;
	wire		spi_cs_in_negedge;
	wire		spi_tx_edge_slv;
	wire		spi_rx_edge_slv;
	wire		spi_w_clk_slv;
`endif

`ifdef NDS_FPGA
(* KEEP = "TRUE" *) wire spi_r_clk;    // synthesis syn_keep=1 
(* KEEP = "TRUE" *) wire spi_r_clk_a1; // synthesis syn_keep=1 
`else
wire spi_r_clk;
`endif
wire			spi_clock_inv;
wire	[3:0]		cs_high_period;
wire	[1:0]		cs2sclk_period;
wire	[7:0]		spi_clk_period;

assign cs2sclk_period = reg_spiif_setting[13:12];
assign cs_high_period = reg_spiif_setting[11:8];
assign spi_clk_period = reg_spiif_setting[7:0];

assign sclk_1t	= spi_clk_period == 8'hff;
parameter	SPI_M_IDLE  = 3'h0,
		SPI_M_START = 3'h1,
		SPI_M_CLK1H = 3'h3,
		SPI_M_CLK2H = 3'h2,
		SPI_M_CLKF  = 3'h5,
		SPI_M_END   = 3'h6,
		SPI_M_CS    = 3'h4;

always @(*)
begin
	case(spi_cs_r)
		SPI_M_START: begin
			if (spi_m_start_end & ~spi_tx_hold)
				spi_ns = sclk_1t ? SPI_M_CLKF : SPI_M_CLK1H;
			else
				spi_ns = spi_cs_r;
		end
		SPI_M_CLK1H: begin
			if (msclk_edge & ~spi_rx_hold)
				spi_ns = SPI_M_CLK2H;
			else
				spi_ns = spi_cs_r;
		end
		SPI_M_CLK2H: begin
			if (msclk_edge & ~spi_req)
				spi_ns = SPI_M_END;
			else if (msclk_edge & spi_req & ~spi_tx_hold)
				spi_ns = SPI_M_CLK1H;
			else
				spi_ns = spi_cs_r;
		end
		SPI_M_CLKF: begin
			if (~spi_req & ~spi_rx_hold)
				spi_ns = SPI_M_END;
			else
				spi_ns = spi_cs_r;
		end
		SPI_M_END: begin
			if (spi_m_end_end)
				spi_ns = SPI_M_CS;
			else
				spi_ns = spi_cs_r;
		end
		SPI_M_CS: begin
			if (spi_m_cs_end)
				spi_ns = SPI_M_IDLE;
			else
				spi_ns = spi_cs_r;
		end
		default: begin
			if (spi_master & spi_req)
				spi_ns = SPI_M_START;
			else
				spi_ns = spi_cs_r;
		end
	endcase
end

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		spi_cs_r <= 3'h0;
	else if (spi_reset_sclk)
		spi_cs_r <= 3'h0;
	else
		spi_cs_r <= spi_ns;
end

`ifdef ATCSPI200_SLAVE_SUPPORT
	assign spi_busy = spi_master ? (spi_cs_r != SPI_M_IDLE) : ~spi_cs_n_in_syn;
`else
	assign spi_busy = spi_cs_r != SPI_M_IDLE;
`endif

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		period_cnt_r <= 8'h0;
	else if (!spi_master | spi_reset_sclk | sclk_1t | !spi_busy)
		period_cnt_r <= 8'h0;
	else if (msclk_edge) begin
		if ((spi_m_start_end & spi_tx_hold) | ((spi_cs_r == SPI_M_CLK1H) & spi_rx_hold) | ((spi_cs_r == SPI_M_CLK2H) & spi_req & spi_tx_hold) |
			((spi_cs_r == SPI_M_END) & (clock_cnt_r == 4'h0) & spi_rx_hold))
			period_cnt_r <= period_cnt_r;
		else
			period_cnt_r <= 8'h0;
	end
	else
		period_cnt_r <= period_cnt_r + 8'h1;
end

assign msclk_edge      = sclk_1t ? 1'b1                        :  period_cnt_r >= spi_clk_period;
assign msclk_edge_hold = sclk_1t ? ~spi_tx_hold & ~spi_rx_hold : (period_cnt_r >= spi_clk_period) &
	~((spi_m_start_end & spi_tx_hold) | ((spi_cs_r == SPI_M_CLK1H) & spi_rx_hold) | ((spi_cs_r == SPI_M_CLK2H) & spi_req & spi_tx_hold) |
	((spi_cs_r == SPI_M_END) & (clock_cnt_r == 4'h0) & spi_rx_hold));

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		clock_cnt_r <= 4'h0;
	else if (spi_master == 1'b0)
		clock_cnt_r <= 4'h0;
	else if ((spi_cs_r != SPI_M_START) & (spi_cs_r != SPI_M_END) & (spi_cs_r != SPI_M_CS))
		clock_cnt_r <= 4'h0;
	else if (spi_m_cs_end | (spi_m_start_end & ~spi_tx_hold) | spi_m_end_end)
		clock_cnt_r <= 4'h0;
	else if (msclk_edge_hold)
		clock_cnt_r <= clock_cnt_r + 4'h1;
end

assign spi_m_cs_end    = (spi_cs_r == SPI_M_CS)    & (clock_cnt_r >= cs_high_period)         & msclk_edge;
assign spi_m_start_end = (spi_cs_r == SPI_M_START) & (clock_cnt_r >= {2'h0, cs2sclk_period}) & msclk_edge;
assign spi_m_end_end   = (spi_cs_r == SPI_M_END)   & (clock_cnt_r >= {2'h0, cs2sclk_period}) & msclk_edge_hold;

assign master_clk_en = (spi_ns == SPI_M_CLKF) & ~spi_tx_hold & ~spi_rx_hold;
assign spi_clock_inv = scan_test ? spi_clock : ~spi_clock;

always @(negedge spi_rstn or posedge spi_clock_inv) begin
	if (~spi_rstn)
		master_clk_d_en_r <= 1'b0;
	else
		master_clk_d_en_r <= master_clk_en;
end

gck  master_gclk_0 (.clk_out(master_gclk_org), .clk_en(master_clk_en),     .clk_in(spi_clock), .test_en(scan_enable));
gck  master_gclk_1 (.clk_out(master_gclk_d),   .clk_en(master_clk_d_en_r), .clk_in(~spi_clock), .test_en(scan_enable));

assign master_gclk = spi_mode[0] ? master_gclk_org : master_gclk_d;
assign master_sclk = spi_mode[1] ^ (master_gclk | master_sclk_r);

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		master_sclk_r <= 1'b0;
	else if (spi_reset_sclk | ~spi_master | sclk_1t)
		master_sclk_r <= 1'b0;
	else if (spi_cs_r != spi_ns)begin
		if (spi_ns == SPI_M_CLK1H)
			master_sclk_r <= spi_mode[0];
		else if (spi_ns == SPI_M_CLK2H)
			master_sclk_r <= ~spi_mode[0];
		else
			master_sclk_r <= 1'b0;
	end
end

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		master_cs_r <= 1'b1;
	else if (!spi_master | spi_reset_sclk | (spi_ns == SPI_M_IDLE) | (spi_ns == SPI_M_CS))
		master_cs_r <= 1'b1;
	else
		master_cs_r <= 1'b0;
end

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		master_rxdata_wr_lvl_r <= 1'b0;
	else if (!spi_master | spi_reset_sclk | (spi_cs_r == SPI_M_IDLE))
		master_rxdata_wr_lvl_r <= 1'b0;
	else if (msclk_edge_hold) begin
		if (sclk_1t)
			master_rxdata_wr_lvl_r <= (spi_cs_r == SPI_M_CLKF);
		else
			master_rxdata_wr_lvl_r <= (spi_cs_r == SPI_M_CLK2H);
	end
end

`ifdef ATCSPI200_SLAVE_SUPPORT
	nds_sync_l2l spi_clk_in_syn (
		.b_reset_n(spi_rstn),
		.b_clk(spi_clock),
		.a_signal(spi_clk_in),
		.b_signal(),
		.b_signal_rising_edge_pulse(spi_clk_posedge),
		.b_signal_falling_edge_pulse(spi_clk_negedge),
		.b_signal_edge_pulse()
	);

	nds_sync_l2l #(.RESET_VALUE (1'b1)) spi_cs_n_syn (
		.b_reset_n(spi_rstn),
		.b_clk(spi_clock),
		.a_signal(spi_cs_n_in),
		.b_signal(spi_cs_n_in_syn),
		.b_signal_rising_edge_pulse(spi_cs_in_posedge),
		.b_signal_falling_edge_pulse(spi_cs_in_negedge),
		.b_signal_edge_pulse()
	);

	assign spi_tx_edge_slv = (spi_master | spi_cs_n_in_syn) ? 1'b0 : (((spi_mode == 2'h0)|(spi_mode == 2'h3)) ? spi_clk_negedge : spi_clk_posedge);
	assign spi_rx_edge_slv = (spi_master | spi_cs_n_in_syn) ? 1'b0 : (((spi_mode == 2'h0)|(spi_mode == 2'h3)) ? spi_clk_posedge : spi_clk_negedge);

	assign spi_txdata_rd = spi_master ? ( ((spi_ns == SPI_M_CLK1H) | (spi_ns == SPI_M_CLKF)) & msclk_edge_hold ) : spi_tx_edge_slv;
	assign spi_rxdata_wr = spi_master ? (master_rxdata_wr_lvl_r & msclk_edge_hold) : spi_rx_edge_slv;

	assign spi_cs_deassert  = spi_master ? ((spi_cs_r == SPI_M_CS) & (spi_ns   == SPI_M_IDLE)) : spi_cs_in_posedge;
	assign spi_slave_cs_assert = ~spi_master & spi_cs_in_negedge;

`else
	assign spi_txdata_rd =  ((spi_ns == SPI_M_CLK1H) | (spi_ns == SPI_M_CLKF)) & msclk_edge_hold;
	assign spi_rxdata_wr = master_rxdata_wr_lvl_r & msclk_edge_hold;

	assign spi_cs_deassert  = (spi_cs_r == SPI_M_CS) & (spi_ns == SPI_M_IDLE);
`endif


assign spi_r_clk = scan_test ? spi_clock : (spi_mode[0] ^ spi_mode[1] ^ spi_clk_in);

`ifdef ATCSPI200_SLAVE_SUPPORT
	assign spi_w_clk_slv = scan_test ? spi_clock : ~spi_r_clk;

	always @(negedge spi_rstn or posedge spi_clock)
	begin
		if (!spi_rstn)
			spi_oe_override <= 1'b1;
		else if (spi_cs_deassert | spi_reset_sclk | spi_master)
			spi_oe_override <= 1'b1;
		else if (spi_tx_edge_slv)
			spi_oe_override <= 1'b0;
	end

	always @(negedge spi_rstn or posedge spi_w_clk_slv)
	begin
		if (!spi_rstn)
			spi_out_slv_r <= {SPI_OUT_WIDTH{1'b1}};
		else if (~spi_master) begin
			`ifdef ATCSPI200_QUADSPI_SUPPORT
				spi_out_slv_r[3:2] <= spi_quad ? spi_txdata[3:2] : 2'b11;
			`endif
			spi_out_slv_r[1] <= (spi_quad | spi_dual) ? spi_txdata[1] : spi_txdata[0];
			spi_out_slv_r[0] <= (spi_quad | spi_dual | spi_3line) ? spi_txdata[0] : 1'b1;
		end
	end

	always @(negedge spi_rstn or posedge spi_w_clk_slv)
	begin
		if (!spi_rstn)
			spi_oe_slv_r <= {SPI_OE_WIDTH{1'b0}};
		else if (~spi_master) begin
			`ifdef ATCSPI200_QUADSPI_SUPPORT
				spi_oe_slv_r[2] <= spi_oe[2];
			`endif
			spi_oe_slv_r[1:0] <= (spi_master | spi_3line) ? spi_oe[1:0] : {spi_oe[0], spi_oe[1]};
		end
	end
`else
`endif

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		spi_out_r <= {SPI_OUT_WIDTH{1'b1}};
	else if (spi_txdata_rd) begin
		`ifdef ATCSPI200_QUADSPI_SUPPORT
			spi_out_r[3:2] <= spi_quad ? spi_txdata[3:2] : 2'b11;
		`endif
		spi_out_r[1] <= (spi_quad | spi_dual | spi_master) ? spi_txdata[1] : spi_txdata[0];
		spi_out_r[0] <= (spi_quad | spi_dual | spi_master| spi_3line) ? spi_txdata[0] : 1'b1;
	end
end

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		spi_oe_r <= {SPI_OE_WIDTH{1'b0}};
	else if (spi_txdata_rd) begin
		`ifdef ATCSPI200_QUADSPI_SUPPORT
			spi_oe_r[2] <= spi_oe[2];
		`endif
		spi_oe_r[1:0] <= (spi_master | spi_3line) ? spi_oe[1:0] : {spi_oe[0], spi_oe[1]};
	end
end

`ifdef ATCSPI200_DIRECT_IO_SUPPORT
	assign pio_sclk_in = spi_clk_in;
	assign pio_cs_in   = spi_cs_n_in;
	assign pio_mosi_in = spi_mosi_in;
	assign pio_miso_in = spi_miso_in;

	assign spi_clk_out	= pio_enable ? pio_sclk_out : master_sclk;
	assign spi_cs_n_out	= pio_enable ? pio_cs_out   : master_cs_r;
	assign spi_mosi_out	= pio_enable ? pio_mosi_out : spi_master ? spi_out_r[0] : spi_out_slv_r[0];
    assign spi_miso_out	= pio_enable ? pio_miso_out : spi_master ? spi_out_r[1] : first_slv_tx_word ? first_slv_tx_bit : spi_out_slv_r[1];

	assign spi_clk_oe    = pio_enable ? pio_sclk_oe : spi_master;
	assign spi_cs_n_oe   = pio_enable ? pio_cs_oe   : spi_master;
	assign spi_mosi_oe   = pio_enable ? pio_mosi_oe : spi_master ? spi_oe_r[0] : spi_oe_override ? 1'b0 : spi_oe_slv_r[0];
	assign spi_miso_oe   = pio_enable ? pio_miso_oe : spi_master ? spi_oe_r[1] : spi_oe_override ? 1'b1 : spi_oe_slv_r[1];
	`ifdef ATCSPI200_QUADSPI_SUPPORT
		assign pio_wp_in   = spi_wp_n_in;
		assign pio_hold_in = spi_hold_n_in;

		assign spi_wp_n_out   = pio_enable ? pio_wp_out   : spi_master ? spi_out_r[2] : spi_out_slv_r[2];
		assign spi_hold_n_out = pio_enable ? pio_hold_out : spi_master ? spi_out_r[3] : spi_out_slv_r[3];

		assign spi_wp_n_oe   = pio_enable ? pio_wp_oe   : spi_master ? spi_oe_r[2] : spi_oe_override ? 1'b0 : spi_oe_slv_r[2];
		assign spi_hold_n_oe = pio_enable ? pio_hold_oe : spi_master ? spi_oe_r[2] : spi_oe_override ? 1'b0 : spi_oe_slv_r[2];
	`endif
`else
	assign spi_clk_out	= master_sclk;
	assign spi_cs_n_out	= master_cs_r;
	assign spi_mosi_out	= spi_master ? spi_out_r[0] : spi_out_slv_r[0];
	assign spi_miso_out	= spi_master ? spi_out_r[1] : first_slv_tx_word ? first_slv_tx_bit : spi_out_slv_r[1];

	assign spi_clk_oe	= spi_master;
	assign spi_cs_n_oe	= spi_master;
	assign spi_mosi_oe	= spi_master ? spi_oe_r[0] : spi_oe_override ? 1'b0 : spi_oe_slv_r[0];
	assign spi_miso_oe	= spi_master ? spi_oe_r[1] : spi_oe_override ? 1'b1 : spi_oe_slv_r[1];
	`ifdef ATCSPI200_QUADSPI_SUPPORT
		assign spi_wp_n_out	= spi_master ? spi_out_r[2] : spi_out_slv_r[2];
		assign spi_hold_n_out	= spi_master ? spi_out_r[3] : spi_out_slv_r[3];

		assign spi_wp_n_oe	= spi_master ? spi_oe_r[2] : spi_oe_override ? 1'b0 : spi_oe_slv_r[2];
		assign spi_hold_n_oe	= spi_master ? spi_oe_r[2] : spi_oe_override ? 1'b0 : spi_oe_slv_r[2];
	`endif
`endif

always @(posedge spi_r_clk)
begin
`ifdef ATCSPI200_QUADSPI_SUPPORT
	spi_in_r[3] <= spi_hold_n_in;
	spi_in_r[2] <= spi_wp_n_in;
`endif
	spi_in_r[1] <= spi_miso_in;
	spi_in_r[0] <= spi_mosi_in;
end

always @(negedge spi_rstn or posedge spi_clock_inv)
begin
	if (~spi_rstn)
		spi_in_d1_r <= {SPI_IN_WIDTH{1'b0}};
	else if (spi_master & sclk_1t & ~spi_rx_hold_d_r)
		spi_in_d1_r <= spi_in_r;
end

always @(*) begin
	if (spi_master & sclk_1t) begin
		`ifdef ATCSPI200_QUADSPI_SUPPORT
			spi_rxdata[3] = spi_in_d1_r[3];
			spi_rxdata[2] = spi_in_d1_r[2];
		`else
			spi_rxdata[3:2] = 2'b0;
		`endif
		spi_rxdata[1] = spi_in_d1_r[1];
		spi_rxdata[0] = (~spi_master | spi_quad | spi_dual | spi_3line) ? spi_in_d1_r[0] : spi_in_d1_r[1];
	end
	else begin
		`ifdef ATCSPI200_QUADSPI_SUPPORT
			spi_rxdata[3] = spi_in_r[3];
			spi_rxdata[2] = spi_in_r[2];
		`else
			spi_rxdata[3:2] = 2'b0;
		`endif
		spi_rxdata[1] = spi_in_r[1];
		spi_rxdata[0] = (~spi_master | spi_quad | spi_dual | spi_3line) ? spi_in_r[0] : spi_in_r[1];
	end
end

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (~spi_rstn)
		spi_rx_hold_d_r <= 1'b0;
	else
		spi_rx_hold_d_r <= spi_rx_hold;
end

endmodule
