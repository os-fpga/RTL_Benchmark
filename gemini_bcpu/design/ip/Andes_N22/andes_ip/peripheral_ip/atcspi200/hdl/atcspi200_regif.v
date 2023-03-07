// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcspi200_config.vh"
`include "atcspi200_const.vh"

module atcspi200_regif (
`ifdef ATCSPI200_REG_AHB
	  regrstn,
	  regclk,
	  hsel_reg,
	  hwrite,
	  haddr,
	  htrans,
	  hreadyin,
	  hreadyout_reg,
	  hwdata,
	  hrdata_reg,
	  hresp_reg,
`endif
`ifdef ATCSPI200_REG_EILM
	  eilm_req,
	  eilm_web,
	  eilm_addr,
	  eilm_wdata,
	  eilm_wait,
	  eilm_rdata,
`endif
`ifdef ATCSPI200_REG_APB
	  regrstn,
	  regclk,
	  psel,
	  penable,
	  pwrite,
	  paddr,
	  pwdata,
	  prdata,
	  pready,
`endif
	  reg_rdata,
	  reg_rd_a,
	  reg_wr_a,
	  reg_raddr,
	  reg_waddr,
	  reg_wdata,
	  reg_txf_full,
	  reg_rxf_empty,
	  reg_txf_entries,
	  reg_busy_status,
	  reg_mem_idle_clr_sysclk
);

`ifdef ATCSPI200_REG_AHB
	input                regrstn;
	input                regclk;
	input                hsel_reg;
	input                hwrite;
	input  [6:2]	     haddr;
	input  [1:0]         htrans;
	input                hreadyin;
	output               hreadyout_reg;
	input  [31:0]        hwdata;
	output [31:0]        hrdata_reg;
	output [1:0]         hresp_reg;
`endif
`ifdef ATCSPI200_REG_EILM
	input                eilm_req;
	input   [3:0]        eilm_web;
	input  [19:2]        eilm_addr;
	input  [31:0]        eilm_wdata;
	output               eilm_wait;
	output [31:0]        eilm_rdata;
`endif
`ifdef ATCSPI200_REG_APB
	input                regrstn;
	input                regclk;
	input                psel;
	input                penable;
	input                pwrite;
	input  [31:0]        paddr;
	input  [31:0]        pwdata;
	output [31:0]        prdata;
	output		     pready;
`endif

input  [31:0]     reg_rdata;

output                       reg_rd_a;
output                       reg_wr_a;
output [6:2]                 reg_raddr;
output [6:2]                 reg_waddr;
output [31:0]     	     reg_wdata;
input			     reg_txf_full;
input			     reg_rxf_empty;
input	[`ATCSPI200_TXFPTR_BITS-1:0] reg_txf_entries;
input			     reg_busy_status;
input			     reg_mem_idle_clr_sysclk;



`ifdef ATCSPI200_REG_AHB
	localparam	HSTATE_IDLE	= 1'b0;
	localparam	HSTATE_DATA	= 1'b1;
	localparam	DATA_REG	= 5'h0b;
	localparam	NON_SEQ		= 2'b10;
	localparam	SEQ		= 2'b11;

	wire		s0;
	wire		s1;
	reg		s2;
	reg  [6:2]	s3;
	wire		s4;
	reg		s5;

	reg		s6, s7;
	reg		s8, s9;

	wire		s10, s11, s12;
	wire 		s13;
	wire		s14, s15;
	wire		s16 = &reg_txf_entries[`ATCSPI200_TXFPTR_BITS-2:0];

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn) begin
			s6 <= 1'b1;
		end
		else if (s14) begin
			s6 <= (reg_busy_status|reg_mem_idle_clr_sysclk) ? (hwrite ? (~(reg_txf_full | (s16 & (s2 & s12)))) : ~reg_rxf_empty) : 1'b1;
		end
		else if (s15) begin
			s6 <= (reg_busy_status|reg_mem_idle_clr_sysclk) ? (s7 ? ~reg_txf_full : ~reg_rxf_empty) : 1'b1;
		end
		else begin
			s6 <= 1'b1;
		end
	end

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn)
			s8 <= HSTATE_IDLE;
		else
			s8 <= s9;
	end

	always @*
	begin
		s9 = (s8 == HSTATE_IDLE && s11 && s10) ? HSTATE_DATA :
			      (s8 == HSTATE_DATA && !s10 && s6 == 1'b1) ? HSTATE_IDLE : s8;
	end

	always@(negedge regrstn or posedge regclk)
	begin
		if (!regrstn) begin
			s2	<= 1'b0;
			s5	<= 1'b0;
		end
		else begin
			s2	<= s0;
			s5	<= s4;
		end
	end

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn) begin
			s3	<= 5'h00;
			s7 	<= 1'b0;
		end
		else if (s0 | s4 | s1) begin
			s3	<= haddr[6:2];
			s7 	<= hwrite;
		end
	end

	assign s13	= (s9 == HSTATE_IDLE);
	assign s11	= (haddr[6:2] == DATA_REG);
	assign s12	= (s3 == DATA_REG);
	assign s14	= ~s13 & ( hsel_reg & s11 & s10);
	assign s15	= ~s13 & s12;
	assign s10 		= (hsel_reg && ((htrans == NON_SEQ) | (htrans == SEQ)) && hreadyin);
	assign s1	=  s10 & ~hwrite;
	assign reg_rd_a		= ((s1 & (s11 ? ~reg_rxf_empty : 1'b1)) | (~s6 & ~s7 & ~reg_rxf_empty)) | s5;
	assign s0	=  s10 &  hwrite;
	assign reg_wr_a		= (s2 & (s12 ? ~reg_txf_full : 1'b1)) | (~s6 & s7 & ~reg_txf_full);
	assign reg_wdata	= hwdata;

	assign reg_raddr	= s5 ? s3 :
				  (s6 == 1'b0) ? s3 : haddr[6:2];
	assign reg_waddr	= s3;

	assign hrdata_reg	= reg_rdata;

	assign s4	= s2 & reg_rd_a & ((reg_raddr == reg_waddr && reg_raddr != 5'hb) | ((reg_raddr == 5'hd) & ((reg_waddr == 5'h9) | (reg_waddr == 5'hb))));
	assign hreadyout_reg	= ~s5 & s6;
	assign hresp_reg	= 2'h0;
`endif

`ifdef ATCSPI200_REG_EILM
	assign reg_rd_a		= eilm_req &  (&eilm_web);
	assign reg_wr_a		= eilm_req & ~(&eilm_web);
	assign reg_wdata	= eilm_wdata;

	assign reg_raddr	= eilm_addr[6:2];
	assign reg_waddr	= eilm_addr[6:2];
	assign eilm_rdata	= reg_rdata;
	assign eilm_wait	= 1'b0;
`endif

`ifdef ATCSPI200_REG_APB
	localparam	PSTATE_IDLE   = 1'b0;
	localparam	PSTATE_ACCESS = 1'b1;

	reg 		s17;
	reg	 	s18, s19;
	wire		s20 = paddr[6:2] == 5'h0b;
	wire 		s21 = s19 == PSTATE_IDLE;

	always @(negedge regrstn or posedge regclk)
	begin
		if (!regrstn) begin
			s17 <= 1'b1;
		end
		else if (!s21 && s20) begin
			s17 <= (reg_busy_status|reg_mem_idle_clr_sysclk) ? (pwrite ? ~reg_txf_full : ~reg_rxf_empty) : 1'b1;
		end
		else begin
			s17 <= 1'b1;
		end
	end

	always @(negedge regrstn or posedge regclk)
	begin
		if (~regrstn) begin
			s18 <= PSTATE_IDLE;
		end
		else begin
			s18 <= s19;
		end
	end

	always @*
	begin
		s19 = (s18 == PSTATE_IDLE && psel) ? PSTATE_ACCESS :
			      (s18 == PSTATE_ACCESS && s17) ? PSTATE_IDLE : s18;
	end

	assign reg_rd_a		= psel & ~pwrite & (~penable | ~s17) & (s20 ? ~reg_rxf_empty : 1'b1);
	assign reg_wr_a		= psel & penable & pwrite & s17;
	assign reg_wdata	= pwdata;

	assign reg_raddr	= paddr[6:2];
	assign reg_waddr	= paddr[6:2];
	assign prdata		= reg_rdata;
	assign pready		= s17;
`endif

endmodule
