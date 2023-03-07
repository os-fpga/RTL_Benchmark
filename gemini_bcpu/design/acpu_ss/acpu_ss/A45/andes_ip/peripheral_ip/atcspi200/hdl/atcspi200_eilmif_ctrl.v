// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


`include "atcspi200_config.vh"
`include "atcspi200_const.vh"

module atcspi200_eilmif_ctrl (
	  eilm_resetn,
	  eilm_clk,
	  ahb2eilm_clken,
	  eilm_req,
	  eilm_web,
	  eilm_addr,
	  eilm_wait,
	  eilm_wdata,
	  eilm_rdata,
	  eilm_spi_busy,
	  eilm_spi_req,
	  eilm_rxf_rd_data,
	  eilm_rxf_rd,
	  eilm_addr_latched,
	  eilm_other_req,
	  eilm_spi_addr,
	  eilm_cmd_chg,
	  eilm_rxf_empty,
	  mem_intf_idle_clr_regclk,
	  reg_mem_idle_clr_sysclk
);

input		eilm_resetn;
input		eilm_clk;
input		ahb2eilm_clken;
input		eilm_req;
input	[3:0]	eilm_web;
input	[21:2]	eilm_addr;
output	 	eilm_wait;
input	[31:0]	eilm_wdata;
output	[31:0]	eilm_rdata;

input		eilm_spi_busy;
output		eilm_spi_req;
input	[31:0]	eilm_rxf_rd_data;
output		eilm_rxf_rd;
input		eilm_addr_latched;
input		eilm_other_req;

output	[31:0]	eilm_spi_addr;
input		eilm_cmd_chg;
input		eilm_rxf_empty;
input		mem_intf_idle_clr_regclk;
input		reg_mem_idle_clr_sysclk;


wire		s0;

wire            eilm_req;
wire            s1;
wire            s2;
wire            s3;
wire            s4;
wire            s5;
wire            s6;

wire            s7;
wire            s8;

reg [1:0]       s9, s10;
reg [2:0]       s11, s12;
reg [1:0]       s13, s14;

wire            s15;
wire            s16;

wire            s17;
wire            s18;

wire            s19;
wire            s20;

reg  [21:2]     s21;

wire            eilm_wait;
reg  [31:0]	eilm_rdata;
reg  [21:2]	s22;
localparam	SPI_IDLE  = 3'h0,
		SPI_RDATA = 3'h1,
		SPI_RREAD = 3'h3,
		SPI_RHOLD = 3'h2,
		SPI_WDATA = 3'h4;

localparam	EILM_IDLE  = 2'h0,
		EILM_READ  = 2'h1,
		EILM_WRITE = 2'h2;

localparam      MEM_CLR_IDLE    = 2'h0,
                MEM_CLR_BUSY    = 2'h1,
                MEM_RHOLD       = 2'h2;



assign s15 = s0 & ahb2eilm_clken;
assign s16 = eilm_rxf_rd & ahb2eilm_clken;

assign s1		= eilm_req & (s9 == EILM_IDLE);
assign s2		= s1 & (&eilm_web);
assign s3	= (s13 == MEM_RHOLD);
assign s4	= reg_mem_idle_clr_sysclk ? 1'b0 : (s3 | s2);
assign s5	= 1'b0;

assign s6 = ((eilm_addr[21:2] == s21[21:2]) & (&eilm_web)) |
			   (s14 == MEM_CLR_IDLE & s3 & (s22[21:2] == s21[21:2]));

always @(*)
begin
	case(s9)
		EILM_READ: begin
			if (s17)
				s10 = EILM_IDLE;
			else
				s10 = EILM_READ;
		end
		EILM_WRITE: begin
			if (s18)
				s10 = EILM_IDLE;
			else
				s10 = EILM_WRITE;
		end
		default : begin
			if (s4)
				s10 = EILM_READ;
			else if (s5)
				s10 = EILM_WRITE;
			else
				s10 = EILM_IDLE;
		end
	endcase
end

always @(negedge eilm_resetn or posedge eilm_clk)
begin
	if (!eilm_resetn)
		s9 <= EILM_IDLE;
	else
		s9 <= s10;
end

always @(negedge eilm_resetn or posedge eilm_clk)
begin
	if (!eilm_resetn)
		eilm_rdata <= 32'h0;
	else if (s16)
		eilm_rdata <= eilm_rxf_rd_data;
end

assign eilm_wait  = ((s9 == EILM_READ) & ~((s11 == SPI_RDATA) & s16) |
		(s9 == EILM_WRITE) & ~((s11 == SPI_WDATA) & s15)) | s3;

assign s7  = s9 == EILM_WRITE;
assign s8  = s9 == EILM_READ;

assign eilm_rxf_rd = ~eilm_rxf_empty & (s11 == SPI_RDATA);
assign s0 = 1'b0;

assign s17 = (s11 == SPI_RDATA) & s16;
assign s18 = (s11 == SPI_WDATA) & s15;


always @(*)
begin
	s12 = s11;
	case(s11)
		SPI_WDATA: begin
			if (s15)
				s12 = SPI_IDLE;
		end
		SPI_RDATA: begin
			if (s16) begin
				if (eilm_other_req | eilm_cmd_chg)
					s12 = SPI_IDLE;
				else
					s12 = SPI_RREAD;
			end
		end
		SPI_RREAD: begin
			if (s8 & ahb2eilm_clken)
				s12 = SPI_RDATA;
			else if (s8 & ~ahb2eilm_clken)
				s12 = SPI_RREAD;
			else if (s4 & s6 & ahb2eilm_clken)
				s12 = SPI_RDATA;
			else if (s4 & s6 & ~ahb2eilm_clken)
				s12 = SPI_RREAD;
			else if (s4 & ~s6)
				s12 = SPI_IDLE;
			else if (eilm_other_req | eilm_cmd_chg | s5)
				s12 = SPI_IDLE;
			else if (ahb2eilm_clken)
				s12 = SPI_RHOLD;
		end
		SPI_RHOLD: begin
			if (s4 & s6)
				s12 = SPI_RDATA;
			else if (s4 & ~s6)
				s12 = SPI_IDLE;
			else if (eilm_other_req || eilm_cmd_chg || s5 || mem_intf_idle_clr_regclk)
				s12 = SPI_IDLE;
		end
		default: begin
			if (~eilm_spi_busy) begin
				if (s7 & ahb2eilm_clken)
					s12 = SPI_WDATA;
				else if (s8 & ahb2eilm_clken)
					s12 = SPI_RDATA;
				else if (s5)
					s12 = SPI_WDATA;
				else if (s4)
					s12 = SPI_RDATA;
			end
		end
	endcase
end


always @(negedge eilm_resetn or posedge eilm_clk)
begin
	if (!eilm_resetn)
		s11 <= SPI_IDLE;
	else
		s11 <= s12;
end

always @(negedge eilm_resetn or posedge eilm_clk)
begin
        if (!eilm_resetn) begin
                s22 <= 20'h0;
        end
        else if (s2) begin
                s22 <= eilm_addr;
        end
end


always @(*)
begin
        s14 = s13;
        case(s13)
                MEM_CLR_BUSY: begin
                        if (!reg_mem_idle_clr_sysclk)
                                s14 = MEM_CLR_IDLE;
                        else if (s2)
                                s14 = MEM_RHOLD;
                end
                MEM_RHOLD: begin
                        if (!reg_mem_idle_clr_sysclk)
                                s14 = MEM_CLR_IDLE;
                end
                default: begin
                        if (reg_mem_idle_clr_sysclk && !s2)
                                s14 = MEM_CLR_BUSY;
                        else if (reg_mem_idle_clr_sysclk && s2)
                                s14 = MEM_RHOLD;
                end

        endcase
end

always @(negedge eilm_resetn or posedge eilm_clk)
begin
        if (!eilm_resetn)
                s13 <= MEM_CLR_IDLE;
        else
                s13 <= s14;
end

assign eilm_spi_req     = s11 != SPI_IDLE;
assign eilm_spi_addr    = {10'b0, s21[21:2], 2'h0};

assign s20 = ((s11 == SPI_RDATA) & eilm_addr_latched & ahb2eilm_clken) | (((s11 == SPI_RHOLD) | (s11 == SPI_RREAD)) & (s12 == SPI_RDATA));
assign s19 = ( (s11 == SPI_IDLE)  & (s9 == EILM_IDLE) & (s5 |  s4)) |
(((s11 == SPI_RHOLD) | (s11 == SPI_RREAD)) & (s5 | (s4 & (~s6))));

always @(negedge eilm_resetn or posedge eilm_clk)
begin
	if (!eilm_resetn)
		s21	<= 20'h0;
	else if (s19 && !s3)
		s21	<= eilm_addr[21:2];
	else if (s19 && s3)
		s21	<= s22[21:2];
	else if (s20)
		s21	<= s21 + 20'h1;
end

endmodule
