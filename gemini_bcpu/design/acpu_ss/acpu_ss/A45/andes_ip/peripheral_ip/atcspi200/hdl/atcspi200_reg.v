// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcspi200_config.vh"
`include "atcspi200_const.vh"

module atcspi200_reg (
	  regrstn,
	  regclk,
	  reg_rd_a,
	  reg_wr_a,
	  reg_raddr,
	  reg_rdata,
	  reg_waddr,
	  reg_wdata,
	  spi_boot_intr,
	  spi_default_mode3,
	  spi_reset_regclk,
	  spi_reset_sysclk,
	  reg_spiif_setting,
`ifdef ATCSPI200_MEM_SUPPORT
	  mem_cmd_chg_window,
	  mem_cmd_chg,
	  mem_write_trans_ctrl,
	  mem_read_trans_ctrl,
	  mem_write_opcode,
	  mem_read_opcode,
	  mem_addr_len,
`endif
	  reg_opcode,
	  reg_spi_addr,
`ifdef ATCSPI200_SLAVE_SUPPORT
	  spi_master,
	  spi_default_as_slave,
	  slave_cmd,
	  slave_cmd_wr_regclk,
	  slave_status,
	  slave_rcnt_inc_regclk,
	  slave_wcnt_inc_regclk,
	  txf_underrun_regclk,
	  rxf_overrun_regclk,
	  slv_data_only_regclk,
`endif
	  spi_mode,
	  reg_addr_len,
	  spi_data_len,
	  spi_lsb,
	  spi_3line,
	  reg_trans_end_regclk,
	  reg_busy,
	  reg_req_regclk,
	  reg_trans_ctrl,
	  reg_spi_tramode,
	  reg_data_merge,
	  reg_txf_data_num,
`ifdef ATCSPI200_DIRECT_IO_SUPPORT
	  pio_sclk_in,
	  pio_miso_in,
	  pio_mosi_in,
	  pio_cs_in,
	  pio_enable,
	  pio_sclk_out,
	  pio_miso_out,
	  pio_mosi_out,
	  pio_cs_out,
	  pio_sclk_oe,
	  pio_miso_oe,
	  pio_mosi_oe,
	  pio_cs_oe,
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	  pio_wp_in,
	  pio_wp_out,
	  pio_wp_oe,
	  pio_hold_in,
	  pio_hold_out,
	  pio_hold_oe,
   `endif
`endif
	  reg_tx_dma_en,
	  reg_rx_dma_en,
	  rxf_rd_data,
	  reg_rxf_empty,
	  reg_txf_full,
	  reg_txf_wr_regclk,
	  reg_txf_clr_regclk,
	  txf_clr_level,
	  reg_rxf_rd_regclk,
	  reg_rxf_clr_regclk,
	  rxf_clr_level,
	  reg_txf_entries,
	  reg_rxf_entries,
	  txf_threshold_trigger,
	  rxf_threshold_trigger,
	  reg_busy_status,
	  reg_mem_idle_clr_sysclk
);

input			regrstn;
input			regclk;
input			reg_rd_a;
input			reg_wr_a;
input	[6:2]		reg_raddr;
output	[31:0]		reg_rdata;
input	[6:2]		reg_waddr;
input	[31:0]		reg_wdata;

output			spi_boot_intr;

input			spi_default_mode3;

output			spi_reset_regclk;
input			spi_reset_sysclk;
output	[13:0]		reg_spiif_setting;
`ifdef ATCSPI200_MEM_SUPPORT
	input		mem_cmd_chg_window;
	output		mem_cmd_chg;
	output	[30:0]	mem_write_trans_ctrl;
	output	[30:0]	mem_read_trans_ctrl;
	output	[7:0]	mem_write_opcode;
	output	[7:0]	mem_read_opcode;
	output	[1:0]	mem_addr_len;
`endif
output	[7:0]		reg_opcode;
output	[31:0]		reg_spi_addr;

`ifdef ATCSPI200_SLAVE_SUPPORT
	output		spi_master;
	input		spi_default_as_slave;
	input	[7:0]	slave_cmd;
	input		slave_cmd_wr_regclk;
	output	[31:0]	slave_status;
	input		slave_rcnt_inc_regclk;
	input		slave_wcnt_inc_regclk;
	input		txf_underrun_regclk;
	input		rxf_overrun_regclk;
	output		slv_data_only_regclk;
`endif
output	[1:0]		spi_mode;
output	[1:0]		reg_addr_len;
output	[4:0]		spi_data_len;
output			spi_lsb;
output			spi_3line;
input			reg_trans_end_regclk;
input			reg_busy;
output			reg_req_regclk;
output	[30:0]		reg_trans_ctrl;
output	[3:0]		reg_spi_tramode;
output			reg_data_merge;
output	[8:0]		reg_txf_data_num;

`ifdef ATCSPI200_DIRECT_IO_SUPPORT
	input		pio_sclk_in;
	input		pio_miso_in;
	input		pio_mosi_in;
	input		pio_cs_in;
	output		pio_enable;
	output		pio_sclk_out;
	output		pio_miso_out;
	output		pio_mosi_out;
	output		pio_cs_out;
	output		pio_sclk_oe;
	output		pio_miso_oe;
	output		pio_mosi_oe;
	output		pio_cs_oe;
	`ifdef ATCSPI200_QUADSPI_SUPPORT
		input	pio_wp_in;
		output	pio_wp_out;
		output	pio_wp_oe;
		input	pio_hold_in;
		output	pio_hold_out;
		output	pio_hold_oe;
	`endif
`endif

output			reg_tx_dma_en;
output			reg_rx_dma_en;

input	[31:0]		rxf_rd_data;
input			reg_rxf_empty;
input			reg_txf_full;
output			reg_txf_wr_regclk;
output			reg_txf_clr_regclk;
input			txf_clr_level;
output			reg_rxf_rd_regclk;
output			reg_rxf_clr_regclk;
input			rxf_clr_level;
input	[`ATCSPI200_TXFPTR_BITS-1:0]   reg_txf_entries;
input	[`ATCSPI200_RXFPTR_BITS-1:0]   reg_rxf_entries;
output			txf_threshold_trigger;
output			rxf_threshold_trigger;
output			reg_busy_status;
input			reg_mem_idle_clr_sysclk;

reg	[31:0]		reg_rdata_r;
wire			spi_reset_regclk;

wire [7:0]	    txf_threshold;
wire [7:0]	    rxf_threshold;

localparam		TXFPTR_BITS = `ATCSPI200_TXFPTR_BITS;
localparam		RXFPTR_BITS = `ATCSPI200_RXFPTR_BITS;
wire [7:0]		padded_reg_txf_entries;
wire [7:0]		padded_reg_rxf_entries;


wire			slave_sup;
wire			reg_pio_sup;
wire			quadspi_sup;
wire			dualspi_sup;
wire			eilm_mem_sup;
wire			ahb_mem_sup;
wire	[3:0]		txf_depth_inf;
wire	[3:0]		rxf_depth_inf;
wire			reg_txf_empty;
wire			reg_rxf_full;
`ifdef ATCSPI200_SLAVE_SUPPORT
reg			slv_cmd_int_r;
reg			txf_underrun_int_r;
reg			rxf_overrun_int_r;
reg			reg_slv_data_only_r;
`endif
reg			spi_trans_end_int_r;
reg			txf_thres_int_r;
reg			rxf_thres_int_r;
reg			spi_rstn_d1_r;
reg			spi_rstn_d2_r;
reg	[1:0]		spi_mode_r;
reg	[12:3]		reg_spi_format_r;

reg	[30:0]		reg_reg_tra_ctrl_r;
reg			reg_req_r;

`ifdef ATCSPI200_MEM_SUPPORT
	reg	[3:0]	reg_mem_cmd_r;
	reg		reg_mem_cmd_chg_r;
	reg	[3:0]	mem_cmd_r;

	wire	[30:0]	mem_write_trans_ctrl;
	reg	[30:0]	mem_read_trans_ctrl;
	wire	[7:0]	mem_write_opcode;
	reg	[7:0]	mem_read_opcode;
`endif

`ifdef ATCSPI200_DIRECT_IO_SUPPORT
	wire			reg_reg_pio_wr;
	reg	[8:0]		reg_reg_pio0_r;
	`ifdef ATCSPI200_QUADSPI_SUPPORT
		reg	[3:0]	reg_reg_pio1_r;
	`endif
`endif
reg	[7:0]		reg_reg_cmd_r;
reg	[`ATCSPI200_SPI_ADDR_MSB:0]	reg_reg_addr_r;
reg	[20:3]		reg_reg_ctrl_r;
reg	[5:0]		reg_int_en_r;
reg	[13:0]		reg_spiif_timing_r;
wire	[5:0]		reg_int_en;
wire	[5:0]		reg_int_st;

`ifdef ATCSPI200_SLAVE_SUPPORT
	reg		spi_master_r;
	reg		slave_underrun_r;
	reg		slave_overrun_r;
	reg	[18:0]	slave_status_r;
	reg	[9:0]	slave_rcnt_r;
	reg	[9:0]	slave_wcnt_r;
`else
	wire		spi_master;
`endif

wire			reg_spi_format_wr;
wire			reg_reg_tra_ctrl_wr;
wire			reg_reg_cmd_wr;
wire			reg_reg_addr_wr;
wire			reg_reg_data_wr;
wire			reg_reg_ctrl_wr;
wire			reg_int_en_wr;
wire			reg_int_status_wr;
wire			reg_spi_interface_wr;
`ifdef ATCSPI200_MEM_SUPPORT
	wire		reg_mem_spi_wr;
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
	wire		reg_slave_status_wr;
`endif

wire			reg_reg_data_rd;
wire			spi_data_merge;
wire	[1:0]		spi_addr_len;
wire			pin_cfg_en;

assign reg_rdata = reg_rdata_r;

assign reg_spi_format_wr         = reg_wr_a & (reg_waddr==5'h04);
`ifdef ATCSPI200_DIRECT_IO_SUPPORT
	assign reg_reg_pio_wr    = reg_wr_a & (reg_waddr==5'h05);
`endif
assign reg_reg_tra_ctrl_wr       = reg_wr_a & (reg_waddr==5'h08);
assign reg_reg_cmd_wr            = reg_wr_a & (reg_waddr==5'h09);
assign reg_reg_addr_wr           = reg_wr_a & (reg_waddr==5'h0a);
assign reg_reg_data_wr           = reg_wr_a & (reg_waddr==5'h0b);
assign reg_reg_ctrl_wr           = reg_wr_a & (reg_waddr==5'h0c);
assign reg_int_en_wr             = reg_wr_a & (reg_waddr==5'h0e);
assign reg_int_status_wr         = reg_wr_a & (reg_waddr==5'h0f);
assign reg_spi_interface_wr      = reg_wr_a & (reg_waddr==5'h10);
`ifdef ATCSPI200_MEM_SUPPORT
	assign reg_mem_spi_wr    = reg_wr_a & (reg_waddr==5'h14);
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
	assign reg_slave_status_wr = reg_wr_a & (reg_waddr==5'h18);
`endif
assign reg_reg_data_rd           = reg_rd_a & (reg_raddr==5'h0b);

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn) begin
		spi_rstn_d1_r <= 1'b1;
		spi_rstn_d2_r <= 1'b1;
	end
	else begin
		spi_rstn_d1_r <= 1'b0;
		spi_rstn_d2_r <= spi_rstn_d1_r;
	end
end
assign pin_cfg_en = spi_rstn_d2_r;

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		spi_mode_r <= 2'b0;
	else if (pin_cfg_en)
		spi_mode_r <= {spi_default_mode3, spi_default_mode3};
	else if (reg_spi_format_wr)
		spi_mode_r <= reg_wdata[1:0];
end
assign spi_mode       = spi_mode_r;

`ifdef ATCSPI200_SLAVE_SUPPORT
	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			spi_master_r <= 1'b1;
		else if (pin_cfg_en)
			spi_master_r <= ~spi_default_as_slave;
		else if (reg_spi_format_wr)
			spi_master_r <= ~reg_wdata[2];
	end
	assign spi_master     = spi_master_r;
`else
	assign spi_master	= 1'b1;
`endif


always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		reg_spi_format_r[12:3] <= 10'b10_00111_1_0_0;
	else if (reg_spi_format_wr)
		reg_spi_format_r[12:3] <= {reg_wdata[17:16], reg_wdata[12:7], reg_wdata[4:3]};
end

assign spi_addr_len   = reg_spi_format_r[12:11];
assign spi_data_len   = reg_spi_format_r[10:6];
assign spi_data_merge = reg_spi_format_r[5];
assign spi_3line      = reg_spi_format_r[4];
assign spi_lsb        = reg_spi_format_r[3];


`ifdef ATCSPI200_DIRECT_IO_SUPPORT
	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			reg_reg_pio0_r[8:0] <= 9'h001;
		else if (reg_reg_pio_wr)
			reg_reg_pio0_r[8:0] <= {reg_wdata[24], reg_wdata[19:16], reg_wdata[11:8]};
	end

	assign pio_cs_out   = reg_reg_pio0_r[0];
	assign pio_sclk_out = reg_reg_pio0_r[1];
	assign pio_mosi_out = reg_reg_pio0_r[2];
	assign pio_miso_out = reg_reg_pio0_r[3];
	assign pio_cs_oe    = reg_reg_pio0_r[4];
	assign pio_sclk_oe  = reg_reg_pio0_r[5];
	assign pio_mosi_oe  = reg_reg_pio0_r[6];
	assign pio_miso_oe  = reg_reg_pio0_r[7];
	assign pio_enable   = reg_reg_pio0_r[8];

	`ifdef ATCSPI200_QUADSPI_SUPPORT
		always @(negedge regrstn or posedge regclk)
		begin
			if (!regrstn)
				reg_reg_pio1_r[3:0] <= 4'h3;
			else if (reg_reg_pio_wr)
				reg_reg_pio1_r[3:0] <= {reg_wdata[21:20], reg_wdata[13:12]};
			else
				reg_reg_pio1_r <= reg_reg_pio1_r;
		end

		assign pio_wp_out   = reg_reg_pio1_r[0];
		assign pio_hold_out = reg_reg_pio1_r[1];
		assign pio_wp_oe    = reg_reg_pio1_r[2];
		assign pio_hold_oe  = reg_reg_pio1_r[3];

	`endif
`endif

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		reg_reg_tra_ctrl_r <= 31'b0;
	else if (reg_reg_tra_ctrl_wr)
		reg_reg_tra_ctrl_r <= reg_wdata[30:0];
end

`ifdef ATCSPI200_SLAVE_SUPPORT
always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		reg_slv_data_only_r <= 1'b0;
	else if (reg_reg_tra_ctrl_wr)
		reg_slv_data_only_r <= reg_wdata[31];
end
assign slv_data_only_regclk = reg_slv_data_only_r & ~spi_master;
`endif



always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		reg_reg_cmd_r <= 8'h0;
	else if (reg_reg_cmd_wr)
		reg_reg_cmd_r <= reg_wdata[7:0];
	`ifdef ATCSPI200_SLAVE_SUPPORT
		else if (slave_cmd_wr_regclk)
			reg_reg_cmd_r <= slave_cmd;
	`endif
end

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		reg_req_r <= 1'b0;
	else if ((reg_trans_end_regclk && !reg_mem_idle_clr_sysclk) || spi_reset_regclk)
		reg_req_r <= 1'b0;
	else if (reg_reg_cmd_wr & spi_master)
		reg_req_r <= 1'b1;
end

assign reg_opcode = reg_reg_cmd_r;
assign reg_req_regclk = reg_req_r & ~reg_mem_idle_clr_sysclk;

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		reg_reg_addr_r <= {`ATCSPI200_SPI_ADDR_WIDTH{1'b0}};
	else if (reg_reg_addr_wr)
		reg_reg_addr_r <= reg_wdata[`ATCSPI200_SPI_ADDR_MSB:0];
end

`ifdef ATCSPI200_SPI_ADDR_WIDTH_24
	assign reg_spi_addr = {8'b0, reg_reg_addr_r};
`else
	assign reg_spi_addr = reg_reg_addr_r;
`endif

assign reg_txf_wr_regclk = reg_reg_data_wr & ~reg_txf_full;
assign reg_rxf_rd_regclk = reg_reg_data_rd & ~reg_rxf_empty;


assign spi_reset_regclk = reg_reg_ctrl_wr & reg_wdata[0];
assign reg_rxf_clr_regclk = reg_reg_ctrl_wr & reg_wdata[1];
assign reg_txf_clr_regclk = reg_reg_ctrl_wr & reg_wdata[2];

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		reg_reg_ctrl_r[20:3] <= 18'h0;
	else if (reg_reg_ctrl_wr)
		reg_reg_ctrl_r[20:3] <= {reg_wdata[23:8], reg_wdata[4:3]};
end

assign txf_threshold = reg_reg_ctrl_r[20:13];
assign rxf_threshold = reg_reg_ctrl_r[12: 5];
assign reg_tx_dma_en = reg_reg_ctrl_r[4];
assign reg_rx_dma_en = reg_reg_ctrl_r[3];

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		reg_int_en_r <= 6'b0;
	else if (reg_int_en_wr)
		reg_int_en_r <= reg_wdata[5:0];
end

`ifdef ATCSPI200_SLAVE_SUPPORT
always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		slv_cmd_int_r <= 1'b0;
	else if (reg_int_status_wr & reg_wdata[5])
		slv_cmd_int_r <= 1'b0;
	else if (reg_int_en[5] & slave_cmd_wr_regclk)
		slv_cmd_int_r <= 1'b1;
	else if (~reg_int_en[5])
		slv_cmd_int_r <= 1'b0;
end
`endif

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		spi_trans_end_int_r <= 1'b0;
	else if (reg_int_status_wr & reg_wdata[4])
		spi_trans_end_int_r <= 1'b0;
	else if (reg_int_en[4] & reg_trans_end_regclk)
		spi_trans_end_int_r <= 1'b1;
	else if (~reg_int_en[4])
		spi_trans_end_int_r <= 1'b0;
end

assign txf_threshold_trigger = (padded_reg_txf_entries <= txf_threshold);
assign rxf_threshold_trigger = (padded_reg_rxf_entries >= rxf_threshold);

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		txf_thres_int_r <= 1'b0;
	else if ((reg_int_status_wr & reg_wdata[3]))
		txf_thres_int_r <= 1'b0;
	else if (reg_int_en[3] & txf_threshold_trigger)
		txf_thres_int_r <= 1'b1;
	else if (~reg_int_en[3])
		txf_thres_int_r <= 1'b0;
end

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		rxf_thres_int_r <= 1'b0;
	else if ((reg_int_status_wr & reg_wdata[2]))
		rxf_thres_int_r <= 1'b0;
	else if (reg_int_en[2] & rxf_threshold_trigger)
		rxf_thres_int_r <= 1'b1;
	else if (~reg_int_en[2])
		rxf_thres_int_r <= 1'b0;
end

`ifdef ATCSPI200_SLAVE_SUPPORT
always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		txf_underrun_int_r <= 1'b0;
	else if ((reg_int_status_wr & reg_wdata[1]))
		txf_underrun_int_r <= 1'b0;
	else if (reg_int_en[1] & txf_underrun_regclk)
		txf_underrun_int_r <= 1'b1;
	else if (~reg_int_en[1])
		txf_underrun_int_r <= 1'b0;
end

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		rxf_overrun_int_r <= 1'b0;
	else if ((reg_int_status_wr & reg_wdata[0]))
		rxf_overrun_int_r <= 1'b0;
	else if (reg_int_en[0] & rxf_overrun_regclk)
		rxf_overrun_int_r <= 1'b1;
	else if (~reg_int_en[0])
		rxf_overrun_int_r <= 1'b0;
end
`endif

assign spi_boot_intr = |reg_int_st;

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		reg_spiif_timing_r[13:0] <= {`ATCSPI200_CS2CLK_DEFAULT, `ATCSPI200_CSHT_DEFAULT, `ATCSPI200_SCLKDIV_DEFAULT};
	else if (reg_spi_interface_wr)
		reg_spiif_timing_r[13:0] <= reg_wdata[13:0];
end

`ifdef ATCSPI200_MEM_SUPPORT
	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			reg_mem_cmd_r <= `ATCSPI200_MEM_RDCMD_DEFAULT;
		else if (reg_mem_spi_wr)
			reg_mem_cmd_r <= reg_wdata[3:0];
	end

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			reg_mem_cmd_chg_r <= 1'b0;
		else if (reg_mem_spi_wr | reg_spi_interface_wr)
			reg_mem_cmd_chg_r <= 1'b1;
		else if (mem_cmd_chg_window)
			reg_mem_cmd_chg_r <= 1'b0;
	end

	assign mem_cmd_chg     = reg_mem_cmd_chg_r;

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			mem_cmd_r <= 4'h0;
		else if (mem_cmd_chg_window)
			mem_cmd_r <= reg_mem_cmd_r;
	end

	parameter	CMD_READ	= 4'h0;
	parameter	CMD_FAST_READ	= 4'h1;
	parameter	CMD_DREAD	= 4'h2;
	parameter	CMD_QREAD	= 4'h3;
	parameter	CMD_2READ	= 4'h4;
	parameter	CMD_4READ	= 4'h5;
	parameter	CMD_READ4B	= 4'h8;
	parameter	CMD_FAST_READ4B	= 4'h9;
	parameter	CMD_DREAD4B	= 4'ha;
	parameter	CMD_QREAD4B 	= 4'hb;
	parameter	CMD_2READ4B	= 4'hc;
	parameter	CMD_4READ4B	= 4'hd;

	parameter	ADDR_3BYTE	= 2'b10;
	parameter	ADDR_4BYTE	= 2'b11;

	assign mem_write_trans_ctrl = {	1'b1,	1'b1,	1'b0,	4'h1,	2'h0,	1'b0,	9'h3,	1'b0,	2'h0,	9'h3};
	assign mem_write_opcode = 8'h02;

	always @(*) begin
		case (mem_cmd_r)
			CMD_READ4B:
				mem_read_trans_ctrl = {	1'b1,	1'b1,	1'b0,	4'h2,	2'h0,	1'b0,	9'h3,	1'b0,	2'h0,	9'h3};
			CMD_FAST_READ, CMD_FAST_READ4B:
				mem_read_trans_ctrl = {	1'b1,	1'b1,	1'b0,	4'h9,	2'h0,	1'b0,	9'h3,	1'b0,	2'h0,	9'h3};
`ifdef ATCSPI200_QUADDUAL_SUPPORT
			CMD_DREAD, CMD_DREAD4B:
				mem_read_trans_ctrl = {	1'b1,	1'b1,	1'b0,	4'h9,	2'h1,	1'b0,	9'h3,	1'b0,	2'h1,	9'h3};
			CMD_2READ, CMD_2READ4B:
				mem_read_trans_ctrl = {	1'b1,	1'b1,	1'b1,	4'h2,	2'h1,	1'b1,	9'h3,	1'b0,	2'h0,	9'h3};
	`ifdef ATCSPI200_QUADSPI_SUPPORT
			CMD_QREAD, CMD_QREAD4B:
				mem_read_trans_ctrl = {	1'b1,	1'b1,	1'b0,	4'h9,	2'h2,	1'b0,	9'h3,	1'b0,	2'h3,	9'h3};
			CMD_4READ, CMD_4READ4B:
				mem_read_trans_ctrl = {	1'b1,	1'b1,	1'b1,	4'h9,	2'h2,	1'b1,	9'h3,	1'b0,	2'h1,	9'h3};
	`endif
`endif
			default:
				mem_read_trans_ctrl = {	1'b1,	1'b1,	1'b0,	4'h2,	2'h0,	1'b0,	9'h3,	1'b0,	2'h0,	9'h3};
		endcase
	end

	always @(*) begin
		case (mem_cmd_r)
			CMD_READ4B:	mem_read_opcode = 8'h13;
			CMD_FAST_READ:	mem_read_opcode = 8'h0b;
			CMD_FAST_READ4B:mem_read_opcode = 8'h0c;
`ifdef ATCSPI200_QUADDUAL_SUPPORT
			CMD_DREAD:	mem_read_opcode = 8'h3b;
			CMD_DREAD4B:	mem_read_opcode = 8'h3c;
			CMD_2READ:	mem_read_opcode = 8'hbb;
			CMD_2READ4B:	mem_read_opcode = 8'hbc;
	`ifdef ATCSPI200_QUADSPI_SUPPORT
			CMD_QREAD:	mem_read_opcode = 8'h6b;
			CMD_QREAD4B:	mem_read_opcode = 8'h6c;
			CMD_4READ:	mem_read_opcode = 8'heb;
			CMD_4READ4B:	mem_read_opcode = 8'hec;
	`endif
`endif
			default:	mem_read_opcode = 8'h03;
		endcase
	end

	assign mem_addr_len = mem_cmd_r[3] ? ADDR_4BYTE : ADDR_3BYTE;

`endif


`ifdef ATCSPI200_SLAVE_SUPPORT
	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			slave_status_r[15:0] <= 16'h0;
		else if (reg_slave_status_wr)
			slave_status_r[15:0] <= reg_wdata[15:0];
	end

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			slave_status_r[16] <= 1'b0;
		else if (reg_trans_end_regclk | spi_master | spi_reset_regclk)
			slave_status_r[16] <= 1'b0;
		else if (reg_slave_status_wr)
			slave_status_r[16] <= reg_wdata[16];
	end

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			slave_overrun_r <= 1'b0;
 		else if (reg_trans_end_regclk | spi_master)
			slave_overrun_r <= 1'b0;
		else if (rxf_overrun_regclk)
			slave_overrun_r <= 1'b1;
	end

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			slave_status_r[17] <= 1'b0;
		else if (spi_master)
			slave_status_r[17] <= 1'b0;
		else if (reg_slave_status_wr & reg_wdata[17])
			slave_status_r[17] <= 1'b0;
		else if (reg_trans_end_regclk)
			slave_status_r[17] <= slave_overrun_r | rxf_overrun_regclk;
	end

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			slave_underrun_r <= 1'b0;
		else if (reg_trans_end_regclk | spi_master)
			slave_underrun_r <= 1'b0;
		else if (txf_underrun_regclk)
			slave_underrun_r <= 1'b1;
	end

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			slave_status_r[18] <= 1'b0;
		else if (spi_master)
			slave_status_r[18] <= 1'b0;
		else if (reg_slave_status_wr & reg_wdata[18])
			slave_status_r[18] <= 1'b0;
		else if (reg_trans_end_regclk)
			slave_status_r[18] <= slave_underrun_r;
	end

	assign slave_status = {13'h0, slave_status_r};

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			slave_rcnt_r <= 10'h0;
		else if (spi_master | slave_cmd_wr_regclk)
			slave_rcnt_r <= 10'h0;
		else if (slave_rcnt_inc_regclk)
			slave_rcnt_r <= slave_rcnt_r + 10'h1;
	end

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			slave_wcnt_r <= 10'h0;
		else if (spi_master | slave_cmd_wr_regclk)
			slave_wcnt_r <= 10'h0;
		else if (slave_wcnt_inc_regclk)
			slave_wcnt_r <= slave_wcnt_r + 10'h1;
	end
`endif


`ifdef ATCSPI200_SLAVE_SUPPORT
	assign slave_sup = 1'b1;
`else
	assign slave_sup = 1'b0;
`endif

`ifdef ATCSPI200_DIRECT_IO_SUPPORT
	assign reg_pio_sup = 1'b1;
`else
	assign reg_pio_sup = 1'b0;
`endif

`ifdef ATCSPI200_QUADSPI_SUPPORT
	assign quadspi_sup = 1'b1;
`else
	assign quadspi_sup = 1'b0;
`endif

`ifdef ATCSPI200_QUADDUAL_SUPPORT
	assign dualspi_sup = 1'b1;
`else
	assign dualspi_sup = 1'b0;
`endif

`ifdef ATCSPI200_EILM_MEM_SUPPORT
	assign eilm_mem_sup = 1'b1;
`else
	assign eilm_mem_sup = 1'b0;
`endif

`ifdef ATCSPI200_AHB_MEM_SUPPORT
	assign ahb_mem_sup = 1'b1;
`else
	assign ahb_mem_sup = 1'b0;
`endif

assign txf_depth_inf = `ATCSPI200_TXFIFO_DEPTH_INF;
assign rxf_depth_inf = `ATCSPI200_RXFIFO_DEPTH_INF;

assign reg_txf_empty = reg_txf_entries == `ATCSPI200_TXFPTR_BITS'b0;
parameter RX_FIFO_DEPTH = `ATCSPI200_RXFIFO_DEPTH;
assign reg_rxf_full  = reg_rxf_entries == RX_FIFO_DEPTH[`ATCSPI200_RXFPTR_BITS-1:0];

generate
if (TXFPTR_BITS == 8) begin : padding_reg_txf_entries_0
	assign padded_reg_txf_entries = reg_txf_entries;
end
else begin : padding_reg_txf_entries_1
	assign padded_reg_txf_entries = {{(8-TXFPTR_BITS){1'b0}}, reg_txf_entries};
end
if (RXFPTR_BITS == 8) begin : padding_reg_rxf_entries_0
	assign padded_reg_rxf_entries = reg_rxf_entries;
end
else begin : padding_reg_rxf_entries_1
	assign padded_reg_rxf_entries = {{(8-RXFPTR_BITS){1'b0}}, reg_rxf_entries};
end
endgenerate

always @(negedge regrstn or posedge regclk)
begin
	if (!regrstn)
		reg_rdata_r <= 32'h0;
	else if (reg_rd_a) begin
		case(reg_raddr)
			5'h00: reg_rdata_r <= `ATCSPI200_PRODUCT_ID;
			5'h04: reg_rdata_r <= {14'h0, reg_spi_format_r[12:11], 3'h0, reg_spi_format_r[10:5], 2'h0, reg_spi_format_r[4:3], ~spi_master, spi_mode_r};
			`ifdef ATCSPI200_DIRECT_IO_SUPPORT
				`ifdef ATCSPI200_QUADSPI_SUPPORT
					5'h05: reg_rdata_r <= {7'h00, reg_reg_pio0_r[8], 2'h0, reg_reg_pio1_r[3:2], reg_reg_pio0_r[7:4], 2'h0, reg_reg_pio1_r[1:0], reg_reg_pio0_r[3:0], 2'h0, pio_hold_in, pio_wp_in, pio_miso_in, pio_mosi_in, pio_sclk_in, pio_cs_in};
				`else
					5'h05: reg_rdata_r <= {7'h00, reg_reg_pio0_r[8], 4'h0, reg_reg_pio0_r[7:4], 4'h0, reg_reg_pio0_r[3:0], 4'h0, pio_miso_in, pio_mosi_in, pio_sclk_in, pio_cs_in};
				`endif
			`endif
			`ifdef ATCSPI200_SLAVE_SUPPORT
			5'h08: reg_rdata_r <= {reg_slv_data_only_r, reg_trans_ctrl};
			`else
			5'h08: reg_rdata_r <= {1'b0, reg_trans_ctrl};
			`endif
			5'h09: reg_rdata_r <= {24'h0, reg_reg_cmd_r};
			5'h0a: reg_rdata_r <= reg_spi_addr;
			5'h0b: reg_rdata_r <= rxf_rd_data;
			5'h0c: reg_rdata_r <= {8'h0, reg_reg_ctrl_r[20:5], 3'h0, reg_reg_ctrl_r[4:3], txf_clr_level, rxf_clr_level, spi_reset_sysclk};
			5'h0d: reg_rdata_r <= {2'h0, padded_reg_txf_entries[7:6], 2'h0, padded_reg_rxf_entries[7:6], reg_txf_full, reg_txf_empty, padded_reg_txf_entries[5:0], reg_rxf_full, reg_rxf_empty, padded_reg_rxf_entries[5:0], 7'h0, reg_busy_status};
			5'h0e: reg_rdata_r <= {26'h0, reg_int_en};
			5'h0f: reg_rdata_r <= {26'h0, reg_int_st};
			5'h10: reg_rdata_r <= {18'h0, reg_spiif_timing_r};
			`ifdef ATCSPI200_MEM_SUPPORT
				5'h14: reg_rdata_r <= {23'h0, reg_mem_cmd_chg_r, 4'h0, reg_mem_cmd_r};
			`endif
			`ifdef ATCSPI200_SLAVE_SUPPORT
				5'h18: reg_rdata_r <= {13'h0, slave_status_r};
				5'h19: reg_rdata_r <= {6'h0, slave_wcnt_r, 6'h0 ,slave_rcnt_r};
			`endif
			5'h1f: reg_rdata_r <= {17'h0, slave_sup, eilm_mem_sup, ahb_mem_sup, reg_pio_sup, 1'b0, quadspi_sup, dualspi_sup, txf_depth_inf, rxf_depth_inf};
			default: reg_rdata_r <= 32'h0000;
		endcase
	end
end

assign reg_busy_status		= reg_req_regclk | reg_busy;
assign reg_spiif_setting	= reg_spiif_timing_r;
`ifdef ATCSPI200_QUADSPI_SUPPORT
	assign reg_trans_ctrl		= reg_reg_tra_ctrl_r;
`elsif ATCSPI200_QUADDUAL_SUPPORT
	assign reg_trans_ctrl		= {reg_reg_tra_ctrl_r[30:24], 1'b0, reg_reg_tra_ctrl_r[22:0]};
`else
	assign reg_trans_ctrl		= {reg_reg_tra_ctrl_r[30:29], 1'b0, reg_reg_tra_ctrl_r[27:24], 2'b0, reg_reg_tra_ctrl_r[21:0]};
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
	assign reg_int_en = reg_int_en_r;
	assign reg_int_st = {slv_cmd_int_r, spi_trans_end_int_r, txf_thres_int_r, rxf_thres_int_r, txf_underrun_int_r, rxf_overrun_int_r};
`else
	assign reg_int_en = {1'b0, reg_int_en_r[4:2], 2'b0};
	assign reg_int_st = {1'b0, spi_trans_end_int_r, txf_thres_int_r, rxf_thres_int_r, 2'b0};
`endif
assign reg_spi_tramode		= reg_reg_tra_ctrl_r[27:24];
assign reg_data_merge		= (spi_data_len == 5'h7) & spi_data_merge;
assign reg_addr_len		= spi_addr_len;
assign reg_txf_data_num		= reg_reg_tra_ctrl_r[20:12];

endmodule
