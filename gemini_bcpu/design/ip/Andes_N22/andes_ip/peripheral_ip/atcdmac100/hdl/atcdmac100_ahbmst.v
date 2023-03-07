// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcdmac100_config.vh"
`include "atcdmac100_const.vh"

module atcdmac100_ahbmst(
                          	  hclk,
                          	  hresetn,
                          	  hbusreq_mst,
                          	  hlock_mst,
                          	  htrans_mst,
                          	  haddr_mst,
                          	  hwrite_mst,
                          	  hsize_mst,
                          	  hburst_mst,
                          	  hprot_mst,
                          	  hwdata_mst,
                          	  hgrant_mst,
                          	  hready_mst,
                          	  hresp_mst,
                          	  hrdata_mst,
                          	  dma_mst_req,
                          	  dma_mst_addr,
                          	  dma_mst_write,
                          	  dma_mst_size,
                          	  dma_mst_burst,
                          	  dma_mst_wdata,
                          	  dma_mst_direction_change,
				  arb_end_1st_cycle,
                          	  addr_cross_1k,
                          	  mst_dma_addr,
                          	  mst_dma_grant,
                          	  mst_dma_1st_ap,
                          	  mst_dma_ack,
                          	  mst_dma_rdata,
                          	  mst_dma_error,
                          	  mst_dma_retry_2nd_cycle,
                          	  mst_dma_retry_ap
);

parameter ADDR_WIDTH 	= 32;
parameter ADDR_MSB 	= ADDR_WIDTH - 1;
parameter DATA_WIDTH 	= 32;
parameter DATA_MSB 	= DATA_WIDTH - 1;

parameter HTRANS_IDLE		= 2'b00;
parameter HTRANS_BUSY		= 2'b01;
parameter HTRANS_NONSEQ		= 2'b10;
parameter HTRANS_SEQ		= 2'b11;
parameter HSIZE_BYTE		= 3'b000;
parameter HSIZE_HWORD		= 3'b001;
parameter HSIZE_WORD		= 3'b010;
parameter HRESP_OKAY		= 2'b00;
parameter HRESP_ERROR		= 2'b01;
parameter HRESP_RETRY		= 2'b10;
parameter HRESP_SPLIT		= 2'b11;
parameter HBURST_SINGLE		= 3'b000;
parameter HBURST_INCR		= 3'b001;
parameter HBURST_WRAP4		= 3'b010;
parameter HBURST_INCR4		= 3'b011;
parameter HBURST_WRAP8		= 3'b100;
parameter HBURST_INCR8		= 3'b101;
parameter HBURST_WRAP16		= 3'b110;
parameter HBURST_INCR16		= 3'b111;

input          		hclk;
input          		hresetn;

output			hbusreq_mst;
output			hlock_mst;
output	[1:0]		htrans_mst;
output	[ADDR_MSB:0]	haddr_mst;
output			hwrite_mst;
output	[2:0]		hsize_mst;
output	[2:0]		hburst_mst;
output	[3:0]		hprot_mst;
output	[DATA_MSB:0]	hwdata_mst;
input			hgrant_mst;
input			hready_mst;
input	[1:0]		hresp_mst;
input	[DATA_MSB:0]	hrdata_mst;

input			dma_mst_req;
input	[ADDR_MSB:0]	dma_mst_addr;
input			dma_mst_write;
input	[1:0]		dma_mst_size;
input	[2:0]		dma_mst_burst;
input	[DATA_MSB:0]	dma_mst_wdata;
input			dma_mst_direction_change;
input			arb_end_1st_cycle;
input			addr_cross_1k;
output	[ADDR_MSB:0]	mst_dma_addr;
output			mst_dma_grant;
output			mst_dma_1st_ap;
output			mst_dma_ack;
output	[DATA_MSB:0]	mst_dma_rdata;
output			mst_dma_error;
output			mst_dma_retry_2nd_cycle;
output			mst_dma_retry_ap;

reg			hbusreq_mst;
reg	[1:0]		htrans_mst;
reg	[ADDR_MSB:0]	haddr_mst;
reg			hwrite_mst;
reg	[2:0]		hsize_mst;
reg	[2:0]		hburst_mst;
reg	[DATA_MSB:0]	hwdata_mst;

wire			s0;
wire	[1:0]		s1;
wire	[ADDR_MSB:0]	s2;
wire			s3;
wire	[2:0]		s4;
wire	[2:0]		s5;
wire	[DATA_MSB:0]	s6;

wire			s7;
wire			s8;

wire			s9;
reg			s10;
wire			s11;
wire			s12;

wire			s13;
reg			s14;
wire			s15;
wire			s16;

reg	[3:0]		s17;
wire	[3:0]		s18;
wire	[3:0]		s19;
wire			s20;

wire			s21;

reg 			s22;
wire			s23;
wire			s24;

wire			s25;
reg			s26;
wire			s27;

wire			s28;
wire 			s29;
wire			s30;
wire			s31;
wire			s32;
wire			s33;

wire			s34;
wire			s35;

reg	[ADDR_MSB:0]	s36;
reg			s37;
reg	[1:0]		s38;
reg	[DATA_MSB:0]	s39;

reg			s40;
wire			s41;
wire			s42;
wire			s43;
wire			s44;
reg			s45;
wire			s46;

reg	[2:0]		s47;
reg			mst_dma_1st_ap;

assign	s0		= dma_mst_req | s43;
assign	s6		= mst_dma_retry_ap ? s39 : dma_mst_wdata;
assign	s2		= s43 ? s36 : dma_mst_addr;
assign	s5		= s33 ? HBURST_SINGLE : dma_mst_burst;
assign	s4		= s43 ? {1'b0,s38} : {1'b0, dma_mst_size};
assign 	s3		= s43 ? s37 : dma_mst_write;
assign	s1		= {s30, s32};

assign	s34		= (hresp_mst == HRESP_ERROR);
assign	s35			= (hresp_mst == HRESP_OKAY);

assign	mst_dma_addr		= haddr_mst;
assign	mst_dma_error 		= s26 & s34;
assign	mst_dma_grant		= s23 & ~s8;
assign	mst_dma_ack 		= s27 & s35;
assign	mst_dma_rdata		= hrdata_mst;
assign	mst_dma_retry_ap	= s40;
assign	mst_dma_retry_2nd_cycle	= s45;

assign	s44	= s8 & ~hready_mst;
assign	s46 = hresp_mst[1] & hready_mst & ~s26;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s45 <= 1'b0;
	end
	else begin
		s45 <= s44;
	end
end

assign	s29		= htrans_mst[1];

assign	s24	= s22 & hready_mst;
assign	s23	= s24 & s29;
assign	s25 		= s23;
assign	s27	= s26 & hready_mst;

assign	s28		= arb_end_1st_cycle | (s24 & ~(s46 | s34)) | s45 | (dma_mst_direction_change & s27);

assign	s7 		= |hresp_mst & ~hready_mst;
assign	s30	= ~s7 & (dma_mst_req | s43);
assign	s33		= s31 | s9 | s13;
assign	s32		= s30 & ~(s20 | s33);

assign	s8		= hresp_mst[1] & s26;


always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s47 <= 3'b0;
	end
	else begin
		s47 <= dma_mst_burst;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s22	<= 1'b0;
	end
	else if (hready_mst) begin
		s22	<= hgrant_mst;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		mst_dma_1st_ap	<= 1'b0;
	end
	else  begin
		mst_dma_1st_ap	<= hgrant_mst & hready_mst;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s26 	<= 1'b0;
	end
	else if (hready_mst) begin
		s26	<= s25;
	end
end

assign s43 = s8 | (s40 & ~ mst_dma_grant);
assign s42	= s45;
assign s41	= mst_dma_grant;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s40 <= 1'b0;
	end
	else begin
		s40 <= s42 | (s40 & ~s41);
	end
end

assign 	s11 = s43 | (s29 & ~hgrant_mst & hready_mst & ~s20);
assign 	s12 = s20;
assign	s9     = s11 | (s10 & ~s12);

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s10 <= 1'b0;
	end
	else begin
		s10 <= s11 | (s10 & ~s12);
	end
end

assign	s15 = addr_cross_1k & s20 & s28;
assign	s16 = (s20 & s28 & ~s45) | ~dma_mst_req;
assign	s13     = s15 | (s14 & ~s16);

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s14 	<= 1'b0;
	end
	else if (s28) begin
		s14 	<= s15 | (s14 & ~s16);
	end
end

assign s31 	= (dma_mst_burst == HBURST_SINGLE);
assign s19 	= (s47 == HBURST_INCR4) ? 4'h3 :
			  (s47 == HBURST_INCR8) ? 4'h7 : 4'hf;

assign s18 = (dma_mst_direction_change || s44 || !dma_mst_req) ? 4'h0 :
			   ((s17 == s19) && s23) ? 4'h0 :
			   s23 ? s17 + 4'h1 :
			   s17;

assign s20 	= dma_mst_direction_change | ((s17 == s19) & s23) | ((s17 == 4'b0) & ~s23);

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s17 <= 4'b0;
	end
	else begin
		s17 <= s18;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s36 	<= {ADDR_WIDTH{1'b0}};
		s37 	<= 1'b0;
		s38	<= 2'b0;
	end
	else if (s23) begin
		s36	<= haddr_mst;
		s37	<= hwrite_mst;
		s38	<= hsize_mst[1:0];
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s39 	<= {DATA_WIDTH{1'b0}};
	end
	else if (s27) begin
		s39	<= hwdata_mst;
	end
end

assign s21 = !(hbusreq_mst && !(hgrant_mst && hready_mst));

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		hbusreq_mst 	<= 1'b0;
	end
	else if (s21) begin
		hbusreq_mst 	<= s0;
	end
end

assign	hlock_mst = 1'b0;
assign	hprot_mst = 4'b0;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		htrans_mst 	<= 2'b0;
		hsize_mst 	<= 3'b0;
		hburst_mst 	<= 3'b0;
		hwrite_mst 	<= 1'b0;
	end
	else if (arb_end_1st_cycle || hready_mst || s7 || (dma_mst_direction_change && s27)) begin
		htrans_mst 	<= s1;
		hsize_mst 	<= s4;
		hburst_mst 	<= s5;
		hwrite_mst 	<= s3;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		haddr_mst	<= {ADDR_WIDTH{1'b0}};
	end
	else if (s28) begin
		haddr_mst 	<= s2;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		hwdata_mst 	<= {DATA_WIDTH{1'b0}};
	end
	else if (s25) begin
		hwdata_mst 	<= s6;
	end
end

endmodule
