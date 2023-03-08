// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcspi200_config.vh"
`include "atcspi200_const.vh"

module atcspi200_ctrl (
	  spi_clock,
	  spi_rstn,
	  spi_reset_sclk,
`ifdef ATCSPI200_SLAVE_SUPPORT
	  spi_master,
	  slave_cmd,
	  slave_cmd_wr_sclk,
	  slave_status,
	  slave_rcnt_inc_sclk,
	  slave_wcnt_inc_sclk,
	  rxf_overrun_sclk,
	  txf_underrun_sclk,
	  spi_slave_cs_assert,
	  slv_data_only_sclk,
`endif
	  first_slv_tx_word,
	  first_slv_tx_bit,
	  spi_mode,
	  arb_addr_len,
	  spi_data_len,
	  spi_lsb,
	  spi_3line,
	  spi_busy,
	  arb_busy_sclk,
	  arb_trans_ctrl,
	  arb_data_merge,
	  arb_req_sclk,
	  arb_trans_end_sclk,
	  arb_opcode,
	  arb_addr,
	  txf_empty,
	  rxf_full,
	  txf_rd,
	  rxf_wr,
	  txf_rd_data,
	  rxf_wr_data,
`ifdef ATCSPI200_MEM_SUPPORT
	  arb_mem_req_sclk,
	  arb_addr_latched_sclk,
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
	  spi_quad,
`endif
`ifdef ATCSPI200_QUADDUAL_SUPPORT
	  spi_dual,
`endif
	  spi_cs_deassert,
	  spi_txdata_rd,
	  spi_rxdata_wr,
	  spi_req,
	  spi_txdata,
	  spi_oe,
	  spi_rxdata,
	  spi_tx_hold,
	  spi_rx_hold,
	  mem_intf_idle_clr_sclk
);

input			spi_clock;
input			spi_rstn;

input			spi_reset_sclk;

`ifdef ATCSPI200_SLAVE_SUPPORT
	input		spi_master;
	output	[7:0]	slave_cmd;
	output		slave_cmd_wr_sclk;
	input	[31:0]	slave_status;
	output		slave_rcnt_inc_sclk;
	output		slave_wcnt_inc_sclk;
	output		rxf_overrun_sclk;
	output		txf_underrun_sclk;
	input		spi_slave_cs_assert;
	input		slv_data_only_sclk;
`endif
output			first_slv_tx_word;
output			first_slv_tx_bit;

input	[1:0]		spi_mode;
input	[1:0]		arb_addr_len;
input	[4:0]		spi_data_len;
input			spi_lsb;
input			spi_3line;
input			spi_busy;

output			arb_busy_sclk;
input	[30:0]		arb_trans_ctrl;
input			arb_data_merge;

input			arb_req_sclk;
output			arb_trans_end_sclk;

input	[7:0]		arb_opcode;
input	[31:0]		arb_addr;
input			txf_empty;
input			rxf_full;
output			txf_rd;
output			rxf_wr;
input	[31:0]		txf_rd_data;
output	[31:0]		rxf_wr_data;
`ifdef ATCSPI200_MEM_SUPPORT
input			arb_mem_req_sclk;
output			arb_addr_latched_sclk;
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
output			spi_quad;
`endif
`ifdef ATCSPI200_QUADDUAL_SUPPORT
output			spi_dual;
`endif

input			spi_cs_deassert;
input			spi_txdata_rd;
input			spi_rxdata_wr;
output			spi_req;
output	[3:0]		spi_txdata;
output	[2:0]		spi_oe;
input	[3:0]		spi_rxdata;

output			spi_tx_hold;
output			spi_rx_hold;
output			mem_intf_idle_clr_sclk;
wire			ctrl_req;
reg			arb_req_invalid;
reg			arb_busy_sclk;

wire	[3:0]		spi_trans_mode;
wire	[1:0]		spi_data_dq;
wire			arb_addr_dq;
wire	[1:0]		arb_data_dq;
wire			arb_cmd_en;
wire			arb_addr_en;
wire	[3:0]		arb_trans_mode;
wire			arb_token_en;
wire			arb_token_val;
wire	[8:0]		arb_wr_num;
wire	[1:0]		arb_dummy_num;
wire	[8:0]		arb_rd_num;

reg	[3:0]		ctrl_cs_r, ctrl_ns, trans_mode_ns;
reg	[4:0]		tx_bit_cnt_r;
reg	[4:0]		rx_bit_cnt_r;
reg	[8:0]		data_cnt_r;
reg	[1:0]		tx_rx_diff_cnt_r;
reg	[1:0]		rx_mask_cnt_r;
reg			rx_mask;
reg			rx_shift_reg_full_r;

reg	[3:0]		spi_txdata;
reg	[2:0]		spi_oe;
reg	[31:0]		rx_shift_reg_r, rx_shift_reg_nx;
reg	[31:0]		tx_mux_r;

`ifdef ATCSPI200_SLAVE_SUPPORT
	reg	[3:0]	slave_trans_mode;
	reg	[1:0]	slave_data_dq;
	reg	[7:0]	slave_cmd;
	wire		slave_read_status;
	wire		spi_trans_s_cmd_end;
	wire		spi_trans_s_dummy_end;
	reg		txf_underrun_flag_r;
	wire		undefined_length_rd_cmd;
	wire		undefined_length_wr_cmd;
	wire		slv_data_only;
`else
	wire		spi_master = 1'b1;
	wire		spi_slave_cs_assert = 1'b0;
`endif
reg			first_slv_tx_word;
reg			first_slv_tx_bit;
wire			spi_trans_cmd_end;
wire			spi_trans_addr_end;
wire			spi_trans_token_end;
wire			spi_trans_w_end;
wire			spi_trans_d_end;
wire			spi_trans_r_end;
wire			spi_wait_r_end;
wire			tx_bit_cnt_clr;
wire			data_cnt_clr;

reg			tx_ready;

reg			tx_byte_hit;
wire			tx_unit_hit;
reg			rx_byte_hit;
reg			tx_word_hit;
reg			rx_word_hit;
reg	[4:0]		ctrl_word_len;
`ifdef ATCSPI200_QUADDUAL_SUPPORT
	reg		spi_dual;
`else
	wire		spi_dual = 1'b0;
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
	reg		spi_quad;
`else
	wire		spi_quad = 1'b0;
`endif
`ifdef ATCSPI200_MEM_SUPPORT
`else
	wire		arb_mem_req_sclk = 1'b0;
`endif
parameter	SPI_CTRL_IDLE    = 4'h0,
		SPI_CTRL_CMD     = 4'h8,
		SPI_CTRL_ADDR    = 4'h9,
		SPI_CTRL_TOKEN   = 4'hb,
		SPI_CTRL_NODATA  = 4'ha,
		SPI_CTRL_S_CMD   = 4'hc,
		SPI_CTRL_S_DUMMY = 4'hd,
		SPI_CTRL_W_ONLY  = 4'h1,
		SPI_CTRL_R_ONLY  = 4'h2,
		SPI_CTRL_DUMMY   = 4'h3,
		SPI_CTRL_RW      = 4'h4,
		SPI_CTRL_W_END   = 4'h5,
		SPI_CTRL_R_END   = 4'h6,
		SPI_CTRL_R_END2  = 4'h7;

parameter	SPI_TRA_WR     = 4'h0,
		SPI_TRA_WO     = 4'h1,
		SPI_TRA_RO     = 4'h2,
		SPI_TRA_W_R    = 4'h3,
		SPI_TRA_R_W    = 4'h4,
		SPI_TRA_W_D_R  = 4'h5,
		SPI_TRA_R_D_W  = 4'h6,
		SPI_TRA_NODATA = 4'h7,
		SPI_TRA_D_W    = 4'h8,
		SPI_TRA_D_R    = 4'h9;


always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		arb_req_invalid <= 1'b0;
	else if (spi_reset_sclk | ~arb_req_sclk)
		arb_req_invalid <= 1'b0;
	else if ((ctrl_cs_r != ctrl_ns) & (ctrl_ns == SPI_CTRL_IDLE))
		arb_req_invalid <= 1'b1;
end

assign ctrl_req = arb_req_sclk & ~arb_req_invalid;

`ifdef ATCSPI200_SLAVE_SUPPORT
	assign arb_trans_end_sclk = (ctrl_cs_r != SPI_CTRL_IDLE) & (ctrl_ns == SPI_CTRL_IDLE) & ~slave_read_status;
`else
	assign arb_trans_end_sclk = (ctrl_cs_r != SPI_CTRL_IDLE) & (ctrl_ns == SPI_CTRL_IDLE);
`endif

`ifdef ATCSPI200_SLAVE_SUPPORT
 	parameter	SLAVE_RSTATUS1  = 8'h05,
			SLAVE_RSTATUS2  = 8'h15,
			SLAVE_RSTATUS4  = 8'h25,
			SLAVE_RDATA1    = 8'h0b,
			SLAVE_RDATA2    = 8'h0c,
			SLAVE_RDATA4    = 8'h0e,
			SLAVE_WDATA1    = 8'h51,
			SLAVE_WDATA2    = 8'h52,
			SLAVE_WDATA4    = 8'h54;

	always@(negedge spi_rstn or posedge spi_clock) begin
		if (!spi_rstn)
			slave_cmd <= 8'h0;
		else if (spi_reset_sclk | spi_master | spi_cs_deassert)
			slave_cmd <= 8'h0;
		else if (slave_cmd_wr_sclk) begin
			slave_cmd <= rx_shift_reg_r[7:0];
		end
	end

	assign slave_read_status = (slave_cmd == SLAVE_RSTATUS1) | (slave_cmd == SLAVE_RSTATUS2) | (slave_cmd == SLAVE_RSTATUS4);

	always @(*)
	begin
		case(slave_cmd)
			SLAVE_RSTATUS1, SLAVE_RDATA1: begin
				slave_trans_mode = SPI_TRA_WO;
				slave_data_dq = 2'h0;
			end
			SLAVE_WDATA1: begin
				slave_trans_mode = SPI_TRA_RO;
				slave_data_dq = 2'h0;
			end
			`ifdef ATCSPI200_QUADDUAL_SUPPORT
				SLAVE_RSTATUS2, SLAVE_RDATA2: begin
					slave_trans_mode = SPI_TRA_WO;
					slave_data_dq = 2'h1;
				end
				SLAVE_WDATA2: begin
					slave_trans_mode = SPI_TRA_RO;
					slave_data_dq = 2'h1;
				end

			`endif
			`ifdef ATCSPI200_QUADSPI_SUPPORT
				SLAVE_RSTATUS4, SLAVE_RDATA4: begin
					slave_trans_mode = SPI_TRA_WO;
					slave_data_dq = 2'h2;
				end
				SLAVE_WDATA4: begin
					slave_trans_mode = SPI_TRA_RO;
					slave_data_dq = 2'h2;
				end
			`endif
			default: begin
				slave_trans_mode = arb_trans_mode;
				slave_data_dq = arb_data_dq;
			end
		endcase
	end
`endif

assign arb_cmd_en	= arb_trans_ctrl[30];
assign arb_addr_en	= arb_trans_ctrl[29];
assign arb_trans_mode	= arb_trans_ctrl[27:24];
assign arb_token_en	= arb_trans_ctrl[21];
assign arb_token_val	= arb_trans_ctrl[11];
assign arb_dummy_num	= arb_trans_ctrl[10:9];
assign arb_addr_dq	= arb_trans_ctrl[28];
assign arb_data_dq	= arb_trans_ctrl[23:22];

`ifdef ATCSPI200_SLAVE_SUPPORT
	assign spi_trans_mode = spi_master ? arb_trans_mode : slave_trans_mode;
	assign spi_data_dq = spi_master ? arb_data_dq : slave_data_dq;
	assign undefined_length_rd_cmd = !spi_master && ((slave_cmd == SLAVE_RDATA1) || (slave_cmd == SLAVE_RDATA2) || (slave_cmd == SLAVE_RDATA4));
	assign undefined_length_wr_cmd = !spi_master && ((slave_cmd == SLAVE_WDATA1) || (slave_cmd == SLAVE_WDATA2) || (slave_cmd == SLAVE_WDATA4));
	assign arb_wr_num = undefined_length_wr_cmd ? 9'h1ff : arb_trans_ctrl[20:12];
	assign arb_rd_num = undefined_length_rd_cmd ? 9'h1ff : arb_trans_ctrl[8:0];
	assign slv_data_only = slv_data_only_sclk;
`else
	assign spi_trans_mode = arb_trans_mode;
	assign spi_data_dq = arb_data_dq;
	assign arb_wr_num = arb_trans_ctrl[20:12];
	assign arb_rd_num = arb_trans_ctrl[8:0];
`endif

always @(*)
begin
	case(ctrl_cs_r)
		SPI_CTRL_W_ONLY: begin
			if (spi_trans_mode == SPI_TRA_W_R)
				trans_mode_ns = SPI_CTRL_R_ONLY;
			else if (spi_trans_mode == SPI_TRA_W_D_R)
				trans_mode_ns = SPI_CTRL_DUMMY;
			else if (spi_master)
				trans_mode_ns = SPI_CTRL_W_END;
			else
				trans_mode_ns = ctrl_cs_r;
		end
		SPI_CTRL_R_ONLY: begin
			if ((spi_trans_mode == SPI_TRA_R_W))
				trans_mode_ns = SPI_CTRL_W_ONLY;
			else if ((spi_trans_mode == SPI_TRA_R_D_W))
				trans_mode_ns = SPI_CTRL_DUMMY;
			else if (spi_master)
				trans_mode_ns = SPI_CTRL_R_END;
			else
				trans_mode_ns = ctrl_cs_r;
		end
		SPI_CTRL_DUMMY: begin
			if ((spi_trans_mode == SPI_TRA_W_D_R)|(spi_trans_mode == SPI_TRA_D_R))
				trans_mode_ns = SPI_CTRL_R_ONLY;
			else
				trans_mode_ns = SPI_CTRL_W_ONLY;
		end
		default: begin
			if (spi_trans_mode == SPI_TRA_WR)
				trans_mode_ns = SPI_CTRL_RW;
			else if ((spi_trans_mode == SPI_TRA_WO) | (spi_trans_mode == SPI_TRA_W_R) | (spi_trans_mode == SPI_TRA_W_D_R))
				trans_mode_ns = SPI_CTRL_W_ONLY;
			else if ((spi_trans_mode == SPI_TRA_RO) | (spi_trans_mode == SPI_TRA_R_W) | (spi_trans_mode == SPI_TRA_R_D_W))
				trans_mode_ns = SPI_CTRL_R_ONLY;
			else if ((spi_trans_mode == SPI_TRA_D_W) | (spi_trans_mode == SPI_TRA_D_R))
				trans_mode_ns = SPI_CTRL_DUMMY;
			else
				trans_mode_ns = SPI_CTRL_NODATA;
		end
	endcase
end


always @(*)
begin
	if ((~spi_master & spi_cs_deassert) | (arb_mem_req_sclk & ~ctrl_req))
		ctrl_ns = SPI_CTRL_IDLE;
	else
	case(ctrl_cs_r)
		SPI_CTRL_CMD: begin
			if (spi_trans_cmd_end) begin
				if (arb_addr_en)
					ctrl_ns = SPI_CTRL_ADDR;
				else if (arb_token_en)
					ctrl_ns = SPI_CTRL_TOKEN;
				else
					ctrl_ns = trans_mode_ns;
			end
			else
				ctrl_ns = ctrl_cs_r;
		end
		SPI_CTRL_ADDR: begin
			if (spi_trans_addr_end)	begin
				if (arb_token_en)
					ctrl_ns = SPI_CTRL_TOKEN;
				else
					ctrl_ns = trans_mode_ns;
			end
			else
				ctrl_ns = ctrl_cs_r;
		end
		SPI_CTRL_TOKEN: begin
			if (spi_trans_token_end)
				ctrl_ns = trans_mode_ns;
			else
				ctrl_ns = ctrl_cs_r;
		end
		SPI_CTRL_NODATA: begin
			if (spi_master)
				ctrl_ns = SPI_CTRL_IDLE;
			else
				ctrl_ns = ctrl_cs_r;
		end
		`ifdef ATCSPI200_SLAVE_SUPPORT
			SPI_CTRL_S_CMD: begin
				if (spi_master)
					ctrl_ns = SPI_CTRL_IDLE;
				else if (spi_trans_s_cmd_end)
					ctrl_ns = SPI_CTRL_S_DUMMY;
				else
					ctrl_ns = ctrl_cs_r;
			end
			SPI_CTRL_S_DUMMY: begin
				if (spi_trans_s_dummy_end)
					ctrl_ns = trans_mode_ns;
				else
					ctrl_ns = ctrl_cs_r;
			end
		`endif
		SPI_CTRL_W_ONLY: begin
			if (spi_trans_w_end)
				ctrl_ns = trans_mode_ns;
			else
				ctrl_ns = ctrl_cs_r;
		end
		SPI_CTRL_R_ONLY: begin
			if (spi_trans_r_end)
				ctrl_ns = trans_mode_ns;
			else
				ctrl_ns = ctrl_cs_r;
		end
		SPI_CTRL_DUMMY: begin
			if (spi_trans_d_end)
				ctrl_ns = trans_mode_ns;
			else
				ctrl_ns = ctrl_cs_r;
		end
		SPI_CTRL_RW: begin
			if (spi_trans_w_end & spi_master)
				ctrl_ns = SPI_CTRL_R_END;
			else
				ctrl_ns = ctrl_cs_r;
		end
		SPI_CTRL_W_END: begin
			if (spi_wait_r_end)
				ctrl_ns = SPI_CTRL_R_END2;
			else
				ctrl_ns = ctrl_cs_r;
		end
		SPI_CTRL_R_END: begin
			if (spi_wait_r_end)
				ctrl_ns = SPI_CTRL_R_END2;
			else
				ctrl_ns = ctrl_cs_r;
		end
 		SPI_CTRL_R_END2: begin
			if (~rx_shift_reg_full_r)
				ctrl_ns = SPI_CTRL_IDLE;
			else
				ctrl_ns = ctrl_cs_r;
		end
		default: begin
			if (ctrl_req) begin
				if (arb_cmd_en)
					ctrl_ns = SPI_CTRL_CMD;
				else if (arb_addr_en)
					ctrl_ns = SPI_CTRL_ADDR;
				else if (arb_token_en)
					ctrl_ns = SPI_CTRL_TOKEN;
				else
					ctrl_ns = trans_mode_ns;
			end
		`ifdef ATCSPI200_SLAVE_SUPPORT
			else if (spi_slave_cs_assert & slv_data_only)
				ctrl_ns = SPI_CTRL_RW;
        `endif
			else if (spi_slave_cs_assert)
				ctrl_ns = SPI_CTRL_S_CMD;
			else
				ctrl_ns = ctrl_cs_r;
		end
	endcase
end
assign spi_trans_cmd_end	= spi_txdata_rd & tx_unit_hit;
assign spi_trans_addr_end	= spi_txdata_rd & tx_word_hit;
assign spi_trans_token_end	= spi_txdata_rd & tx_unit_hit;
`ifdef ATCSPI200_SLAVE_SUPPORT
	assign spi_trans_s_cmd_end   = spi_txdata_rd & tx_unit_hit;
	assign spi_trans_s_dummy_end = spi_txdata_rd & tx_unit_hit;
`endif

assign spi_trans_w_end    = arb_mem_req_sclk ? ~ctrl_req : (spi_txdata_rd & tx_unit_hit & (data_cnt_r == arb_wr_num));
assign spi_trans_r_end    = arb_mem_req_sclk ? ~ctrl_req : (spi_txdata_rd & tx_unit_hit & (data_cnt_r == arb_rd_num));
assign spi_trans_d_end    = spi_txdata_rd & tx_unit_hit & (data_cnt_r[1:0] == arb_dummy_num);
assign spi_wait_r_end     = spi_rxdata_wr & (rx_mask_cnt_r == 2'h1) | (rx_mask_cnt_r == 2'h0);

`ifdef ATCSPI200_MEM_SUPPORT
assign arb_addr_latched_sclk = (ctrl_cs_r != ctrl_ns) & (ctrl_ns == SPI_CTRL_ADDR);
`endif

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		ctrl_cs_r <= SPI_CTRL_IDLE;
	else if (spi_reset_sclk)
		ctrl_cs_r <= SPI_CTRL_IDLE;
	else
		ctrl_cs_r <= ctrl_ns;
end

always @(negedge spi_rstn or posedge spi_clock)
	if (~spi_rstn)
		arb_busy_sclk <= 1'b0;
	else if (spi_master)
		arb_busy_sclk <= (spi_busy | (ctrl_ns != SPI_CTRL_IDLE));
	else
		arb_busy_sclk <= spi_busy;


always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		data_cnt_r <= 9'h0;
	else if ((spi_reset_sclk | data_cnt_clr | (ctrl_cs_r == SPI_CTRL_IDLE)))
		data_cnt_r <= 9'h0;
	else if ((ctrl_cs_r == SPI_CTRL_RW) | (ctrl_cs_r == SPI_CTRL_R_ONLY) | (ctrl_cs_r == SPI_CTRL_W_ONLY) | (ctrl_cs_r == SPI_CTRL_DUMMY)) begin
		if (spi_txdata_rd & tx_unit_hit) begin
			data_cnt_r <= data_cnt_r + 9'h1;
		end
	end
end

`ifdef ATCSPI200_SLAVE_SUPPORT
	assign tx_bit_cnt_clr = (ctrl_cs_r != ctrl_ns) | spi_cs_deassert;
`else
	assign tx_bit_cnt_clr = ctrl_cs_r != ctrl_ns;
`endif

assign data_cnt_clr = tx_bit_cnt_clr | ((((ctrl_cs_r == SPI_CTRL_W_ONLY) & (data_cnt_r == arb_wr_num)) | ((ctrl_cs_r == SPI_CTRL_R_ONLY) & (data_cnt_r == arb_rd_num))) & arb_mem_req_sclk & spi_txdata_rd & tx_unit_hit);

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		first_slv_tx_word <= 1'b0;
	else if (spi_slave_cs_assert & ~spi_mode[0])
		first_slv_tx_word <= 1'b1;
	else if (spi_txdata_rd)
		first_slv_tx_word <= 1'b0;
end

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		first_slv_tx_bit <= 1'b0;
	else if (first_slv_tx_word)
		first_slv_tx_bit <= tx_mux_r[(spi_lsb ? 5'h0 : ctrl_word_len)];
	else if (spi_txdata_rd)
		first_slv_tx_bit <= 1'b0;
end



always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		tx_bit_cnt_r <= 5'h0;
	else if (spi_slave_cs_assert)
		tx_bit_cnt_r <= spi_mode[0] ? 5'h0 : 5'h1;
	else if (spi_reset_sclk | tx_bit_cnt_clr)
		tx_bit_cnt_r <= 5'h0;
	else if (spi_txdata_rd) begin
		if (tx_word_hit)
			tx_bit_cnt_r <= 5'h0;
		else
			tx_bit_cnt_r <= tx_bit_cnt_r + (spi_quad ? 5'h4 : spi_dual ? 5'h2 : 5'h1);
	end
end


wire [1:0] tx_rx_diff_cnt_nx;
assign tx_rx_diff_cnt_nx = tx_rx_diff_cnt_r + (spi_txdata_rd ? 2'b1 : 2'b0) - (spi_rxdata_wr ? 2'b1 : 2'b0);

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		tx_rx_diff_cnt_r <= 2'h0;
	else if (spi_reset_sclk)
		tx_rx_diff_cnt_r <= 2'h0;
	else if (spi_cs_deassert)
		tx_rx_diff_cnt_r <= 2'h0;
	else if (spi_slave_cs_assert)
		tx_rx_diff_cnt_r <= spi_mode[0] ? 2'h0 : 2'h1;
	else
		tx_rx_diff_cnt_r <= tx_rx_diff_cnt_nx;
end

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		rx_mask_cnt_r <= 2'h0;
	else if (spi_reset_sclk)
		rx_mask_cnt_r <= 2'h0;
	else if (ctrl_cs_r != ctrl_ns) begin
		if ((ctrl_ns == SPI_CTRL_RW) | (ctrl_ns == SPI_CTRL_R_ONLY))
			rx_mask_cnt_r <= tx_rx_diff_cnt_nx;
		`ifdef ATCSPI200_SLAVE_SUPPORT
			else if (ctrl_ns == SPI_CTRL_S_CMD)
				rx_mask_cnt_r <= 2'b0;
			else if (ctrl_cs_r == SPI_CTRL_S_CMD)
				rx_mask_cnt_r <= tx_rx_diff_cnt_nx;
		`endif
		else if ((ctrl_cs_r == SPI_CTRL_RW) | (ctrl_cs_r == SPI_CTRL_R_ONLY))
			rx_mask_cnt_r <= tx_rx_diff_cnt_nx;
		else
			rx_mask_cnt_r <= 2'h0;
	end
	else if (spi_rxdata_wr & (rx_mask_cnt_r != 2'h0))
		rx_mask_cnt_r <= rx_mask_cnt_r - 2'h1;
end

always @(*)
begin
	if ((ctrl_cs_r == SPI_CTRL_RW) | (ctrl_cs_r == SPI_CTRL_R_ONLY) | (ctrl_cs_r == SPI_CTRL_S_CMD))
		rx_mask = rx_mask_cnt_r != 2'h0;
	else
		rx_mask = rx_mask_cnt_r == 2'h0;
end

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		rx_bit_cnt_r <= 5'h0;
	else if (spi_reset_sclk | rx_mask | spi_slave_cs_assert)
		rx_bit_cnt_r <= 5'h0;
	else if (spi_rxdata_wr) begin
		if (rx_word_hit)
			rx_bit_cnt_r <= 5'h0;
		else
			rx_bit_cnt_r <= rx_bit_cnt_r + (spi_quad ? 5'h4 : spi_dual ? 5'h2 : 5'h1);
	end
end

always @(*)
begin
	case (ctrl_cs_r)
		SPI_CTRL_CMD:	ctrl_word_len = 5'h7;
		SPI_CTRL_TOKEN: ctrl_word_len = 5'h7;
`ifdef ATCSPI200_SLAVE_SUPPORT
		SPI_CTRL_S_DUMMY: ctrl_word_len = 5'h7;
		SPI_CTRL_S_CMD:	ctrl_word_len = 5'h7;
		SPI_CTRL_W_ONLY: ctrl_word_len = (slave_read_status | arb_data_merge) ? 5'd31 : spi_data_len;
`endif
		SPI_CTRL_ADDR:	ctrl_word_len = {arb_addr_len, 3'b111};
		default:	ctrl_word_len = arb_data_merge ? 5'd31 : spi_data_len;
	endcase
end

always @(*)
begin
	if (spi_quad)
		tx_byte_hit = tx_bit_cnt_r[2] == ctrl_word_len[2];
	else if (spi_dual)
		tx_byte_hit = tx_bit_cnt_r[2:1] == ctrl_word_len[2:1];
	else
		tx_byte_hit = tx_bit_cnt_r[2:0] == ctrl_word_len[2:0];
end

assign tx_unit_hit = (tx_byte_hit & arb_data_merge) | tx_word_hit;

always @(*)
begin
	if (tx_byte_hit) begin
		if (arb_data_merge) begin
			if ((ctrl_cs_r == SPI_CTRL_CMD) | (ctrl_cs_r == SPI_CTRL_TOKEN) | (ctrl_cs_r == SPI_CTRL_DUMMY) | (ctrl_cs_r == SPI_CTRL_S_DUMMY))
				tx_word_hit = 1'b1;
			else if (ctrl_cs_r == SPI_CTRL_ADDR)
				tx_word_hit = tx_bit_cnt_r[4:3] == arb_addr_len;
			else
				tx_word_hit = (tx_bit_cnt_r[4:3] == 2'h3) | ((ctrl_cs_r == SPI_CTRL_W_ONLY) & arb_mem_req_sclk & (data_cnt_r == arb_wr_num));
		end
		else
			tx_word_hit = tx_bit_cnt_r[4:3] == ctrl_word_len[4:3];
	end
	else
		tx_word_hit = 1'b0;
end

always @(*)
begin
	if (spi_quad)
		rx_byte_hit = rx_bit_cnt_r[2] == ctrl_word_len[2];
	else if (spi_dual)
		rx_byte_hit = rx_bit_cnt_r[2:1] == ctrl_word_len[2:1];
	else
		rx_byte_hit = rx_bit_cnt_r[2:0] == ctrl_word_len[2:0];
end

always @(*)
begin
	if (rx_byte_hit) begin
		if (arb_data_merge)
			rx_word_hit = (rx_bit_cnt_r[4:3] == 2'h3) | ((ctrl_cs_r != SPI_CTRL_RW) & (ctrl_cs_r != SPI_CTRL_R_ONLY) & rx_mask_cnt_r == 2'h1);
		else
			rx_word_hit = rx_bit_cnt_r[4:3] == ctrl_word_len[4:3];
	end
	else
		rx_word_hit = 1'b0;
end

`ifdef ATCSPI200_QUADDUAL_SUPPORT
	always @(*)
	begin
		if ((ctrl_cs_r == SPI_CTRL_CMD) | (ctrl_cs_r == SPI_CTRL_S_CMD) | (ctrl_cs_r == SPI_CTRL_S_DUMMY))
			spi_dual = 1'b0;
		else if ((ctrl_cs_r == SPI_CTRL_ADDR) | (ctrl_cs_r == SPI_CTRL_TOKEN))
			spi_dual = arb_addr_dq & (spi_data_dq == 2'h1);
		else
			spi_dual = (spi_data_dq == 2'h1);
	end
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
	always @(*)
	begin
		if ((ctrl_cs_r == SPI_CTRL_CMD) | (ctrl_cs_r == SPI_CTRL_S_CMD) | (ctrl_cs_r == SPI_CTRL_S_DUMMY))
			spi_quad = 1'b0;
		else if ((ctrl_cs_r == SPI_CTRL_ADDR) | (ctrl_cs_r == SPI_CTRL_TOKEN))
			spi_quad = arb_addr_dq & (spi_data_dq == 2'h2);
		else
			spi_quad = (spi_data_dq == 2'h2);
	end
`endif

`ifdef ATCSPI200_SLAVE_SUPPORT
	assign txf_rd = ~txf_empty & ((spi_txdata_rd & tx_word_hit) | ~tx_ready) & ((ctrl_ns == SPI_CTRL_RW) | (ctrl_ns == SPI_CTRL_W_ONLY)) & ~slave_read_status;
`else
	assign txf_rd = ~txf_empty & ((spi_txdata_rd & tx_word_hit) | ~tx_ready) & ((ctrl_ns == SPI_CTRL_RW) | (ctrl_ns == SPI_CTRL_W_ONLY));
`endif

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		tx_ready <= 1'b0;
	else if (spi_reset_sclk | spi_cs_deassert)
		tx_ready <= 1'b0;
	else if (txf_rd)
		tx_ready <= 1'b1;
	else if (spi_txdata_rd & tx_word_hit)
		tx_ready <= 1'b0;
end

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		tx_mux_r <= 32'h0;
	else if (txf_rd)
		tx_mux_r <= (arb_data_merge & ~spi_lsb) ? {txf_rd_data[7:0], txf_rd_data[15:8], txf_rd_data[23:16], txf_rd_data[31:24]} : txf_rd_data;
	else if (ctrl_cs_r != ctrl_ns) begin
		if (ctrl_ns == SPI_CTRL_CMD)
			tx_mux_r <= {24'h0, arb_opcode};
		`ifdef ATCSPI200_SLAVE_SUPPORT
			else if ((ctrl_ns == SPI_CTRL_W_ONLY) & slave_read_status)
				tx_mux_r <= (arb_data_merge & ~spi_lsb) ? {slave_status[7:0], slave_status[15:8], slave_status[23:16], slave_status[31:24]} : slave_status;
		`endif
		else if (ctrl_ns == SPI_CTRL_ADDR)
			tx_mux_r <= arb_addr;
		else if (ctrl_ns == SPI_CTRL_TOKEN)
			tx_mux_r <= arb_token_val ? 32'h69696969 : 32'h0;
		else
			tx_mux_r <= 32'h0;
	end
end

wire	[4:0]	tx_ptr;
wire	[3:0]	quad_txdata, dual_txdata, sngl_txdata;

assign tx_ptr = spi_lsb ? tx_bit_cnt_r : ctrl_word_len - tx_bit_cnt_r;

assign quad_txdata = spi_lsb ?	{tx_mux_r[{tx_ptr[4:2], 2'h0}], tx_mux_r[{tx_ptr[4:2], 2'h1}], tx_mux_r[{tx_ptr[4:2], 2'h2}], tx_mux_r[{tx_ptr[4:2], 2'h3}]} :
				{tx_mux_r[{tx_ptr[4:2], 2'h3}], tx_mux_r[{tx_ptr[4:2], 2'h2}], tx_mux_r[{tx_ptr[4:2], 2'h1}], tx_mux_r[{tx_ptr[4:2], 2'h0}]};
assign dual_txdata = spi_lsb ?	{2'b11, tx_mux_r[{tx_ptr[4:1], 1'h0}], tx_mux_r[{tx_ptr[4:1], 1'h1}]} :
				{2'b11, tx_mux_r[{tx_ptr[4:1], 1'h1}], tx_mux_r[{tx_ptr[4:1], 1'h0}]};
assign sngl_txdata = 		{3'b111, tx_mux_r[tx_ptr]};


always @(*)
begin
	spi_txdata[3:0] = spi_quad ? quad_txdata : spi_dual ? dual_txdata : sngl_txdata;
end

wire	[4:0]	rx_ptr;
wire	[3:0]	quad_rxdata, dual_rxdata, sngl_rxdata;

assign rx_ptr = spi_lsb ? rx_bit_cnt_r : (ctrl_word_len - rx_bit_cnt_r);

assign quad_rxdata[3:0] = spi_lsb ? {spi_rxdata[0], spi_rxdata[1], spi_rxdata[2], spi_rxdata[3]} : spi_rxdata;

assign dual_rxdata[0] = (rx_ptr[1] == 1'b0) ? spi_lsb ? spi_rxdata[1] : spi_rxdata[0] : rx_shift_reg_r[{rx_ptr[4:2], 2'h0}];
assign dual_rxdata[1] = (rx_ptr[1] == 1'b0) ? spi_lsb ? spi_rxdata[0] : spi_rxdata[1] : rx_shift_reg_r[{rx_ptr[4:2], 2'h1}];
assign dual_rxdata[2] = (rx_ptr[1] == 1'b1) ? spi_lsb ? spi_rxdata[1] : spi_rxdata[0] : rx_shift_reg_r[{rx_ptr[4:2], 2'h2}];
assign dual_rxdata[3] = (rx_ptr[1] == 1'b1) ? spi_lsb ? spi_rxdata[0] : spi_rxdata[1] : rx_shift_reg_r[{rx_ptr[4:2], 2'h3}];

assign sngl_rxdata[0] = (rx_ptr[1:0] == 2'h0) ? spi_rxdata[0] : rx_shift_reg_r[{rx_ptr[4:2], 2'h0}];
assign sngl_rxdata[1] = (rx_ptr[1:0] == 2'h1) ? spi_rxdata[0] : rx_shift_reg_r[{rx_ptr[4:2], 2'h1}];
assign sngl_rxdata[2] = (rx_ptr[1:0] == 2'h2) ? spi_rxdata[0] : rx_shift_reg_r[{rx_ptr[4:2], 2'h2}];
assign sngl_rxdata[3] = (rx_ptr[1:0] == 2'h3) ? spi_rxdata[0] : rx_shift_reg_r[{rx_ptr[4:2], 2'h3}];

always @(*) begin
	`ifdef ATCSPI200_SLAVE_SUPPORT
		rx_shift_reg_nx = (rxf_wr | slave_cmd_wr_sclk) ? 32'h0 : rx_shift_reg_r;
	`else
		rx_shift_reg_nx = rxf_wr ? 32'h0 : rx_shift_reg_r;
	`endif
	if (spi_rxdata_wr & ~rx_mask) begin
		rx_shift_reg_nx[{rx_ptr[4:2], 2'h3}] = spi_quad ? quad_rxdata[3] : spi_dual ? dual_rxdata[3] : sngl_rxdata[3];
		rx_shift_reg_nx[{rx_ptr[4:2], 2'h2}] = spi_quad ? quad_rxdata[2] : spi_dual ? dual_rxdata[2] : sngl_rxdata[2];
		rx_shift_reg_nx[{rx_ptr[4:2], 2'h1}] = spi_quad ? quad_rxdata[1] : spi_dual ? dual_rxdata[1] : sngl_rxdata[1];
		rx_shift_reg_nx[{rx_ptr[4:2], 2'h0}] = spi_quad ? quad_rxdata[0] : spi_dual ? dual_rxdata[0] : sngl_rxdata[0];
	end
end

always@(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		rx_shift_reg_r <= 32'h0;
	else
		rx_shift_reg_r <= rx_shift_reg_nx;
end

assign rxf_wr_data = (arb_data_merge & ~spi_lsb) ? {rx_shift_reg_r[7:0], rx_shift_reg_r[15:8], rx_shift_reg_r[23:16], rx_shift_reg_r[31:24]} : rx_shift_reg_r;

always @(negedge spi_rstn or posedge spi_clock)
begin
	if (!spi_rstn)
		rx_shift_reg_full_r <= 1'b0;
	else if (spi_reset_sclk | (arb_mem_req_sclk & ~ctrl_req))
		rx_shift_reg_full_r <= 1'b0;
	else if ((spi_rxdata_wr & ~rx_mask & rx_word_hit) | (~spi_master & ((rx_bit_cnt_r != 5'h0) & spi_cs_deassert)))
		rx_shift_reg_full_r <= 1'b1;
`ifdef ATCSPI200_SLAVE_SUPPORT
	else if (rxf_wr | slave_cmd_wr_sclk)
`else
	else if (rxf_wr)
`endif
		rx_shift_reg_full_r <= 1'b0;
end

`ifdef ATCSPI200_SLAVE_SUPPORT
	assign slave_cmd_wr_sclk = ~spi_master & rx_shift_reg_full_r & (((ctrl_cs_r == SPI_CTRL_S_DUMMY) & ~slave_read_status) | (ctrl_cs_r == SPI_CTRL_S_CMD));
	assign rxf_wr = ~rxf_full & rx_shift_reg_full_r & ~slave_cmd_wr_sclk;
`else
	assign rxf_wr = ~rxf_full & rx_shift_reg_full_r;
`endif

always @(*)
begin
	if ((ctrl_cs_r == SPI_CTRL_ADDR) | (ctrl_cs_r == SPI_CTRL_TOKEN)) begin
		spi_oe[2] = spi_master ? 1'b1 : 1'b0;
		spi_oe[1] = spi_master ? (spi_quad | spi_dual) : 1'b0;
		spi_oe[0] = spi_master ? 1'b1 : ~(spi_quad | spi_dual);
	end
	else if (ctrl_cs_r == SPI_CTRL_W_ONLY) begin
		spi_oe[2] = spi_master ? 1'b1 : spi_quad;
		spi_oe[1] = spi_quad | spi_dual;
		spi_oe[0] = 1'b1;
	end
	else if ((ctrl_cs_r == SPI_CTRL_R_ONLY) | (ctrl_cs_r == SPI_CTRL_DUMMY) | (ctrl_cs_r == SPI_CTRL_R_END)) begin
		spi_oe[2] = spi_master ? ~spi_quad : 1'b0;
		spi_oe[1] = 1'b0;
		spi_oe[0] = ~(spi_quad | spi_dual | spi_3line);
	end
	else begin
		spi_oe[2] = spi_master ? 1'b1 : 1'b0;
		spi_oe[1] = 1'b0;
		spi_oe[0] = 1'b1;
	end
end

`ifdef ATCSPI200_SLAVE_SUPPORT
	always @(negedge spi_rstn or posedge spi_clock)
	begin
		if (~spi_rstn)
			txf_underrun_flag_r <= 1'b0;
		else if (spi_master | spi_reset_sclk | spi_slave_cs_assert | txf_underrun_sclk)
			txf_underrun_flag_r <= 1'b0;
		else if (spi_tx_hold & spi_txdata_rd & ~slave_read_status & (tx_bit_cnt_r == 5'h0))
			txf_underrun_flag_r <= 1'b1;
	end

	assign slave_rcnt_inc_sclk = ~spi_master & tx_unit_hit & spi_txdata_rd & ((ctrl_cs_r == SPI_CTRL_R_ONLY) | (ctrl_cs_r == SPI_CTRL_RW));
	assign slave_wcnt_inc_sclk = ~spi_master & tx_unit_hit & spi_txdata_rd & ((ctrl_cs_r == SPI_CTRL_W_ONLY) | (ctrl_cs_r == SPI_CTRL_RW));
	assign rxf_overrun_sclk = ~spi_master & spi_rx_hold & spi_rxdata_wr & ~slave_cmd_wr_sclk & (rx_bit_cnt_r == 5'h0);
	assign txf_underrun_sclk = ~spi_master & txf_underrun_flag_r & spi_rxdata_wr;
`endif

assign spi_req = ((ctrl_cs_r == SPI_CTRL_IDLE) & ctrl_req) | (ctrl_cs_r == SPI_CTRL_CMD) | (ctrl_cs_r == SPI_CTRL_ADDR) | (ctrl_cs_r == SPI_CTRL_TOKEN) | (ctrl_cs_r == SPI_CTRL_DUMMY) | (ctrl_cs_r == SPI_CTRL_RW) | (ctrl_cs_r == SPI_CTRL_R_ONLY) | (ctrl_cs_r == SPI_CTRL_W_ONLY);

assign spi_tx_hold = !tx_ready & ((ctrl_cs_r == SPI_CTRL_W_ONLY) | (ctrl_cs_r == SPI_CTRL_RW));

assign spi_rx_hold = rx_shift_reg_full_r & rxf_full & ~rx_mask;

assign mem_intf_idle_clr_sclk = spi_rx_hold & arb_mem_req_sclk;
endmodule
