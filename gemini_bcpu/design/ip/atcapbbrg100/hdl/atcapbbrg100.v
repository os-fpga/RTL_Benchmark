// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


`include "atcapbbrg100_config.vh"
`include "atcapbbrg100_const.vh"

module atcapbbrg100(
`ifdef ATCAPBBRG100_SLV_1
	  ps1_psel,
	  ps1_prdata,
	  ps1_pready,
	  ps1_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_2
	  ps2_psel,
	  ps2_prdata,
	  ps2_pready,
	  ps2_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_3
	  ps3_psel,
	  ps3_prdata,
	  ps3_pready,
	  ps3_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_4
	  ps4_psel,
	  ps4_prdata,
	  ps4_pready,
	  ps4_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_5
	  ps5_psel,
	  ps5_prdata,
	  ps5_pready,
	  ps5_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_6
	  ps6_psel,
	  ps6_prdata,
	  ps6_pready,
	  ps6_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_7
	  ps7_psel,
	  ps7_prdata,
	  ps7_pready,
	  ps7_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_8
	  ps8_psel,
	  ps8_prdata,
	  ps8_pready,
	  ps8_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_9
	  ps9_psel,
	  ps9_prdata,
	  ps9_pready,
	  ps9_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_10
	  ps10_psel,
	  ps10_prdata,
	  ps10_pready,
	  ps10_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_11
	  ps11_psel,
	  ps11_prdata,
	  ps11_pready,
	  ps11_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_12
	  ps12_psel,
	  ps12_prdata,
	  ps12_pready,
	  ps12_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_13
	  ps13_psel,
	  ps13_prdata,
	  ps13_pready,
	  ps13_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_14
	  ps14_psel,
	  ps14_prdata,
	  ps14_pready,
	  ps14_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_15
	  ps15_psel,
	  ps15_prdata,
	  ps15_pready,
	  ps15_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_16
	  ps16_psel,
	  ps16_prdata,
	  ps16_pready,
	  ps16_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_17
	  ps17_psel,
	  ps17_prdata,
	  ps17_pready,
	  ps17_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_18
	  ps18_psel,
	  ps18_prdata,
	  ps18_pready,
	  ps18_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_19
	  ps19_psel,
	  ps19_prdata,
	  ps19_pready,
	  ps19_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_20
	  ps20_psel,
	  ps20_prdata,
	  ps20_pready,
	  ps20_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_21
	  ps21_psel,
	  ps21_prdata,
	  ps21_pready,
	  ps21_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_22
	  ps22_psel,
	  ps22_prdata,
	  ps22_pready,
	  ps22_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_23
	  ps23_psel,
	  ps23_prdata,
	  ps23_pready,
	  ps23_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_24
	  ps24_psel,
	  ps24_prdata,
	  ps24_pready,
	  ps24_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_25
	  ps25_psel,
	  ps25_prdata,
	  ps25_pready,
	  ps25_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_26
	  ps26_psel,
	  ps26_prdata,
	  ps26_pready,
	  ps26_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_27
	  ps27_psel,
	  ps27_prdata,
	  ps27_pready,
	  ps27_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_28
	  ps28_psel,
	  ps28_prdata,
	  ps28_pready,
	  ps28_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_29
	  ps29_psel,
	  ps29_prdata,
	  ps29_pready,
	  ps29_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_30
	  ps30_psel,
	  ps30_prdata,
	  ps30_pready,
	  ps30_pslverr,
`endif
`ifdef ATCAPBBRG100_SLV_31
	  ps31_psel,
	  ps31_prdata,
	  ps31_pready,
	  ps31_pslverr,
`endif
	  hclk,
	  hresetn,
	  hsel,
	  hready_in,
	  htrans,
	  haddr,
	  hsize,
	  hprot,
	  hwrite,
	  hwdata,
	  apb2ahb_clken,
	  hrdata,
	  hready,
	  hresp,
	  pclk,
	  presetn,
	  pprot,
	  pstrb,
	  paddr,
	  penable,
	  pwrite,
	  pwdata
);

parameter ST_AHB_IDLE		= 3'd0;
parameter ST_AHB_READ   	= 3'd1;
parameter ST_AHB_WRITE  	= 3'd2;
parameter ST_AHB_NONBUF 	= 3'd3;
parameter ST_AHB_ERROR_1  	= 3'd4;
parameter ST_AHB_ERROR_2  	= 3'd5;

parameter HTRANS_IDLE		= 2'd0;
parameter HTRANS_BUSY		= 2'd1;
parameter HRESP_OKAY		= 2'd0;
parameter HRESP_ERROR		= 2'd1;
parameter HRESP_RETRY		= 2'd2;
parameter HRESP_SPLIT		= 2'd3;

parameter ST_P_IDLE         = 2'd0;
parameter ST_P_SETUP        = 2'd1;
parameter ST_P_ACCESS       = 2'd2;

`ifdef ATCAPBBRG100_SLV_1
output			ps1_psel;
input [31:0]		ps1_prdata;
input			ps1_pready;
input			ps1_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_2
output			ps2_psel;
input [31:0]		ps2_prdata;
input			ps2_pready;
input			ps2_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_3
output			ps3_psel;
input [31:0]		ps3_prdata;
input			ps3_pready;
input			ps3_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_4
output			ps4_psel;
input [31:0]		ps4_prdata;
input			ps4_pready;
input			ps4_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_5
output			ps5_psel;
input [31:0]		ps5_prdata;
input			ps5_pready;
input			ps5_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_6
output			ps6_psel;
input [31:0]		ps6_prdata;
input			ps6_pready;
input			ps6_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_7
output			ps7_psel;
input [31:0]		ps7_prdata;
input			ps7_pready;
input			ps7_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_8
output			ps8_psel;
input [31:0]		ps8_prdata;
input			ps8_pready;
input			ps8_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_9
output			ps9_psel;
input [31:0]		ps9_prdata;
input			ps9_pready;
input			ps9_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_10
output			ps10_psel;
input [31:0]		ps10_prdata;
input			ps10_pready;
input			ps10_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_11
output			ps11_psel;
input [31:0]		ps11_prdata;
input			ps11_pready;
input			ps11_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_12
output			ps12_psel;
input [31:0]		ps12_prdata;
input			ps12_pready;
input			ps12_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_13
output			ps13_psel;
input [31:0]		ps13_prdata;
input			ps13_pready;
input			ps13_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_14
output			ps14_psel;
input [31:0]		ps14_prdata;
input			ps14_pready;
input			ps14_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_15
output			ps15_psel;
input [31:0]		ps15_prdata;
input			ps15_pready;
input			ps15_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_16
output			ps16_psel;
input [31:0]		ps16_prdata;
input			ps16_pready;
input			ps16_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_17
output			ps17_psel;
input [31:0]		ps17_prdata;
input			ps17_pready;
input			ps17_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_18
output			ps18_psel;
input [31:0]		ps18_prdata;
input			ps18_pready;
input			ps18_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_19
output			ps19_psel;
input [31:0]		ps19_prdata;
input			ps19_pready;
input			ps19_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_20
output			ps20_psel;
input [31:0]		ps20_prdata;
input			ps20_pready;
input			ps20_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_21
output			ps21_psel;
input [31:0]		ps21_prdata;
input			ps21_pready;
input			ps21_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_22
output			ps22_psel;
input [31:0]		ps22_prdata;
input			ps22_pready;
input			ps22_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_23
output			ps23_psel;
input [31:0]		ps23_prdata;
input			ps23_pready;
input			ps23_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_24
output			ps24_psel;
input [31:0]		ps24_prdata;
input			ps24_pready;
input			ps24_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_25
output			ps25_psel;
input [31:0]		ps25_prdata;
input			ps25_pready;
input			ps25_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_26
output			ps26_psel;
input [31:0]		ps26_prdata;
input			ps26_pready;
input			ps26_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_27
output			ps27_psel;
input [31:0]		ps27_prdata;
input			ps27_pready;
input			ps27_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_28
output			ps28_psel;
input [31:0]		ps28_prdata;
input			ps28_pready;
input			ps28_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_29
output			ps29_psel;
input [31:0]		ps29_prdata;
input			ps29_pready;
input			ps29_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_30
output			ps30_psel;
input [31:0]		ps30_prdata;
input			ps30_pready;
input			ps30_pslverr;
`endif
`ifdef ATCAPBBRG100_SLV_31
output			ps31_psel;
input [31:0]		ps31_prdata;
input			ps31_pready;
input			ps31_pslverr;
`endif

input				hclk;
input				hresetn;
input				hsel;
input				hready_in;
input	[1:0]			htrans;
input	[`ATCAPBBRG100_ADDR_MSB:0] haddr;
input	[2:0]			hsize;
input	[3:0]			hprot;
input				hwrite;
input	[31:0]			hwdata;
input				apb2ahb_clken;
output	[31:0]			hrdata;
output				hready;
output	[1:0]			hresp;

input				pclk;
input				presetn;
output  [2:0]			pprot;
output  [3:0]			pstrb;
output	[`ATCAPBBRG100_ADDR_MSB:0] paddr;
output				penable;
output				pwrite;
output	[31:0]			pwdata;
reg	[2:0]			s0;
reg    	[2:0]			s1;
reg				s2;
reg				penable;
reg				s3;
reg				s4;
reg				s5;
reg				s6;

wire				s7;
wire				s8;
wire	[`ATCAPBBRG100_ADDR_MSB:0] s9;
wire				s10;
wire				s11;
wire				s12;
wire				s13;
wire	[31:0]			s14;
wire				s15;
wire				s16;
wire				s17;
wire				s18;
wire	[31:0]			s19;
wire	[31:0]			s20;
wire				s21;
wire				s22;
wire				s23;
wire				s24;
wire	[32:0]			s25;
wire				s26;
wire				s27;
wire				s28;
wire				s29;
wire				s30;
wire				s31;
wire				s32;
wire	[3:0]			s33;
wire				s34;
wire				s35;
wire				s36;
wire				s37;
reg	[3:0]			s38;
wire	[5:0]			s39;
wire	[`ATCAPBBRG100_ADDR_MSB+8:0] s40;
wire	[`ATCAPBBRG100_ADDR_MSB+8:0] s41;
`ifdef ATCAPBBRG100_FLOP_OUT
reg     [`ATCAPBBRG100_ADDR_MSB+8:0] s42;
reg [1:0]                           s43, s44;
`endif

assign	hready 		= ~s11 & (
			(s0 == ST_AHB_IDLE)
			| ((s0 == ST_AHB_READ) & s13)
			| ((s0 == ST_AHB_NONBUF) & s13)
			| (s0 == ST_AHB_WRITE)
			| (s0 == ST_AHB_ERROR_2));
assign	hresp		= ((s0 == ST_AHB_ERROR_1) | (s0 == ST_AHB_ERROR_2)) ? HRESP_ERROR : HRESP_OKAY;
assign	hrdata		= s14;

assign	s24 = ((s17 & penable & s15) | s4) & (~s8);
assign	s23		= ~(|hprot[3:2]);
assign	s10	= hsel & hready_in & htrans[1];
assign	s13	= penable & s17 & ~s15 & apb2ahb_clken;
assign	s32     = hwrite & (s3 | hprot[3] | hprot[2]);

assign  s37        = ~hprot[0];
assign  s36        =  hprot[1];

assign  s39     = {hwrite, hsize, haddr[1:0]};
always @(*)begin
	case (s39)
	6'b101000: s38 = 4'b1111;
	6'b100100: s38 = 4'b0011;
	6'b100110: s38 = 4'b1100;
	6'b100000: s38 = 4'b0001;
	6'b100001: s38 = 4'b0010;
	6'b100010: s38 = 4'b0100;
	6'b100011: s38 = 4'b1000;
	default:   s38 = 4'b0000;
	endcase
end

always @(posedge hclk or negedge hresetn) begin
	if(~hresetn) begin
		s2		<= 1'b0;
	end
	else begin
		s2		<= s10 & hwrite;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if(~hresetn)
		s0	<= ST_AHB_IDLE;
	else
		s0	<= s1;
end

always @(*) begin
	case(s0)
		ST_AHB_READ:
			if (s24 & apb2ahb_clken)
				s1 = ST_AHB_ERROR_1;
			else if (hready_in & ((htrans == HTRANS_IDLE) | (htrans == HTRANS_BUSY)))
				s1 = ST_AHB_IDLE;
			else if (s10 & hwrite)
				s1 = (s23 & ~s3) ? ST_AHB_NONBUF : ST_AHB_WRITE;
			else
				s1 = ST_AHB_READ;
		ST_AHB_WRITE:
			if (hready_in & ((htrans == HTRANS_IDLE) | (htrans == HTRANS_BUSY)))
				s1 = ST_AHB_IDLE;
			else if (s10 & hwrite)
				s1 = (s23 & ~s3) ? ST_AHB_NONBUF : ST_AHB_WRITE;
			else if (s10 & ~hwrite)
				s1 = ST_AHB_READ;
			else
				s1 = ST_AHB_WRITE;
		ST_AHB_NONBUF:
			if (s24 & apb2ahb_clken)
				s1 = ST_AHB_ERROR_1;
			else if (hready_in & ((htrans == HTRANS_IDLE)| (htrans == HTRANS_BUSY)))
				s1 = ST_AHB_IDLE;
			else if (s10 & hwrite)
				s1 = (s23 & ~s3) ? ST_AHB_NONBUF : ST_AHB_WRITE;
			else if (s10)
				s1 = ST_AHB_READ;
			else
				s1 = ST_AHB_NONBUF;
		ST_AHB_ERROR_1:
			s1 = ST_AHB_ERROR_2;
		ST_AHB_ERROR_2:
			if (s10 & hwrite)
				s1 = (s23 & ~s3) ? ST_AHB_NONBUF : ST_AHB_WRITE;
			else if (s10 & ~hwrite)
				s1 = ST_AHB_READ;
			else if (hready_in)
				s1 = ST_AHB_IDLE;
			else
				s1 = ST_AHB_ERROR_2;
		default:
			if (s10 & hwrite)
				s1 = (s23 & ~s3) ? ST_AHB_NONBUF : ST_AHB_WRITE;
			else if (s10)
				s1 = ST_AHB_READ;
			else
				s1 = ST_AHB_IDLE;
	endcase
end

assign	s30	= s10;
assign	s40	= {s38, s36, s37, s32, hwrite, haddr[`ATCAPBBRG100_ADDR_MSB:2], 2'b00};
assign	s29	= (penable & s17) | (s4 & ~s12);

nds_sync_fifo_data #(
        .DATA_WIDTH (`ATCAPBBRG100_ADDR_MSB+9),
        .POINTER_INDEX_WIDTH (2),
        .FIFO_DEPTH (2)
) u_cmd_fifo (
	.w_reset_n  (hresetn         ),
	.r_reset_n  (presetn         ),
	.w_clk      (hclk            ),
	.r_clk      (pclk            ),
	.wr         (s30     ),
	.wr_data    (s40  ),
	.rd         (s29     ),
	.rd_data    (s41  ),
	.w_clk_empty(                ),
	.empty      (s12  ),
	.full       (s11   )
);

`ifdef ATCAPBBRG100_FLOP_OUT
always @(*) begin
    case (s43)
        ST_P_SETUP:
            s44 = ST_P_ACCESS;
        ST_P_ACCESS:
            s44 = s4? ST_P_IDLE : s17? ST_P_IDLE : ST_P_ACCESS;
        default:
            s44 = (~s12 & (~s7 | (s7 & ~s18)))? ST_P_SETUP : ST_P_IDLE ;
    endcase
end
always @(posedge pclk or negedge presetn) begin
	if (~presetn)
        s43 <= 2'b0;
    else
        s43 <= s44;
end

always @(posedge pclk) begin
    s42 <= s41;
end
`endif

assign	s21	= s2;
assign	s19 = hwdata;
assign	s22	= (penable & s17 & s7) | (s4 & ~s18);

nds_sync_fifo_data #(
        .DATA_WIDTH (32),
        .POINTER_INDEX_WIDTH (2),
        .FIFO_DEPTH (2)
) u_wdata_fifo (
	.w_reset_n  (hresetn           ),
	.r_reset_n  (presetn           ),
	.w_clk      (hclk              ),
	.r_clk      (pclk              ),
	.wr         (s21     ),
	.wr_data    (s19  ),
	.rd         (s22     ),
	.rd_data    (s20  ),
	.w_clk_empty(                  ),
	.empty      (s18  ),
	.full       (                  )
);

assign	paddr		= s9;
`ifdef ATCAPBBRG100_FLOP_OUT
assign	pwrite		= s31 & s7;
assign  pstrb       = {4{~s12 }} & s33;
`else
assign	pwrite		= ~s12 & s7;
assign  pstrb       = {4{~s12}} & s33;
`endif
assign	pwdata		= s20;
assign  pprot       = {s35, 1'b0, s34};


`ifdef ATCAPBBRG100_FLOP_OUT
assign s31 = (s43 == ST_P_IDLE)? 1'b0 : 1'b1;
`else
assign	s31		= s12 ? s5 :
			  (~s7 | (s7 & (~s18 | s6)));
`endif

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s5	<= 1'b0;
	else
		s5	<= (s10 & ~hwrite);
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s6 <= 1'b0;
	else
		s6 <= s2;
end


assign	s14		= ({32{s28}} & s25[31:0])
`ifdef ATCAPBBRG100_SLV_1
			| ({32{ps1_psel}} & ps1_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_2
			| ({32{ps2_psel}} & ps2_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_3
			| ({32{ps3_psel}} & ps3_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_4
			| ({32{ps4_psel}} & ps4_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_5
			| ({32{ps5_psel}} & ps5_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_6
			| ({32{ps6_psel}} & ps6_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_7
			| ({32{ps7_psel}} & ps7_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_8
			| ({32{ps8_psel}} & ps8_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_9
			| ({32{ps9_psel}} & ps9_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_10
			| ({32{ps10_psel}} & ps10_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_11
			| ({32{ps11_psel}} & ps11_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_12
			| ({32{ps12_psel}} & ps12_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_13
			| ({32{ps13_psel}} & ps13_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_14
			| ({32{ps14_psel}} & ps14_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_15
			| ({32{ps15_psel}} & ps15_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_16
			| ({32{ps16_psel}} & ps16_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_17
			| ({32{ps17_psel}} & ps17_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_18
			| ({32{ps18_psel}} & ps18_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_19
			| ({32{ps19_psel}} & ps19_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_20
			| ({32{ps20_psel}} & ps20_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_21
			| ({32{ps21_psel}} & ps21_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_22
			| ({32{ps22_psel}} & ps22_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_23
			| ({32{ps23_psel}} & ps23_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_24
			| ({32{ps24_psel}} & ps24_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_25
			| ({32{ps25_psel}} & ps25_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_26
			| ({32{ps26_psel}} & ps26_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_27
			| ({32{ps27_psel}} & ps27_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_28
			| ({32{ps28_psel}} & ps28_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_29
			| ({32{ps29_psel}} & ps29_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_30
			| ({32{ps30_psel}} & ps30_prdata)
`endif
`ifdef ATCAPBBRG100_SLV_31
			| ({32{ps31_psel}} & ps31_prdata)
`endif
;
assign	s17		= (s28 & s26)
`ifdef ATCAPBBRG100_SLV_1
			| (ps1_psel & ps1_pready)
`endif
`ifdef ATCAPBBRG100_SLV_2
			| (ps2_psel & ps2_pready)
`endif
`ifdef ATCAPBBRG100_SLV_3
			| (ps3_psel & ps3_pready)
`endif
`ifdef ATCAPBBRG100_SLV_4
			| (ps4_psel & ps4_pready)
`endif
`ifdef ATCAPBBRG100_SLV_5
			| (ps5_psel & ps5_pready)
`endif
`ifdef ATCAPBBRG100_SLV_6
			| (ps6_psel & ps6_pready)
`endif
`ifdef ATCAPBBRG100_SLV_7
			| (ps7_psel & ps7_pready)
`endif
`ifdef ATCAPBBRG100_SLV_8
			| (ps8_psel & ps8_pready)
`endif
`ifdef ATCAPBBRG100_SLV_9
			| (ps9_psel & ps9_pready)
`endif
`ifdef ATCAPBBRG100_SLV_10
			| (ps10_psel & ps10_pready)
`endif
`ifdef ATCAPBBRG100_SLV_11
			| (ps11_psel & ps11_pready)
`endif
`ifdef ATCAPBBRG100_SLV_12
			| (ps12_psel & ps12_pready)
`endif
`ifdef ATCAPBBRG100_SLV_13
			| (ps13_psel & ps13_pready)
`endif
`ifdef ATCAPBBRG100_SLV_14
			| (ps14_psel & ps14_pready)
`endif
`ifdef ATCAPBBRG100_SLV_15
			| (ps15_psel & ps15_pready)
`endif
`ifdef ATCAPBBRG100_SLV_16
			| (ps16_psel & ps16_pready)
`endif
`ifdef ATCAPBBRG100_SLV_17
			| (ps17_psel & ps17_pready)
`endif
`ifdef ATCAPBBRG100_SLV_18
			| (ps18_psel & ps18_pready)
`endif
`ifdef ATCAPBBRG100_SLV_19
			| (ps19_psel & ps19_pready)
`endif
`ifdef ATCAPBBRG100_SLV_20
			| (ps20_psel & ps20_pready)
`endif
`ifdef ATCAPBBRG100_SLV_21
			| (ps21_psel & ps21_pready)
`endif
`ifdef ATCAPBBRG100_SLV_22
			| (ps22_psel & ps22_pready)
`endif
`ifdef ATCAPBBRG100_SLV_23
			| (ps23_psel & ps23_pready)
`endif
`ifdef ATCAPBBRG100_SLV_24
			| (ps24_psel & ps24_pready)
`endif
`ifdef ATCAPBBRG100_SLV_25
			| (ps25_psel & ps25_pready)
`endif
`ifdef ATCAPBBRG100_SLV_26
			| (ps26_psel & ps26_pready)
`endif
`ifdef ATCAPBBRG100_SLV_27
			| (ps27_psel & ps27_pready)
`endif
`ifdef ATCAPBBRG100_SLV_28
			| (ps28_psel & ps28_pready)
`endif
`ifdef ATCAPBBRG100_SLV_29
			| (ps29_psel & ps29_pready)
`endif
`ifdef ATCAPBBRG100_SLV_30
			| (ps30_psel & ps30_pready)
`endif
`ifdef ATCAPBBRG100_SLV_31
			| (ps31_psel & ps31_pready)
`endif
;
assign	s15		= (s28 & s27)
`ifdef ATCAPBBRG100_SLV_1
			| (ps1_psel & ps1_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_2
			| (ps2_psel & ps2_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_3
			| (ps3_psel & ps3_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_4
			| (ps4_psel & ps4_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_5
			| (ps5_psel & ps5_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_6
			| (ps6_psel & ps6_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_7
			| (ps7_psel & ps7_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_8
			| (ps8_psel & ps8_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_9
			| (ps9_psel & ps9_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_10
			| (ps10_psel & ps10_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_11
			| (ps11_psel & ps11_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_12
			| (ps12_psel & ps12_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_13
			| (ps13_psel & ps13_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_14
			| (ps14_psel & ps14_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_15
			| (ps15_psel & ps15_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_16
			| (ps16_psel & ps16_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_17
			| (ps17_psel & ps17_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_18
			| (ps18_psel & ps18_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_19
			| (ps19_psel & ps19_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_20
			| (ps20_psel & ps20_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_21
			| (ps21_psel & ps21_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_22
			| (ps22_psel & ps22_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_23
			| (ps23_psel & ps23_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_24
			| (ps24_psel & ps24_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_25
			| (ps25_psel & ps25_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_26
			| (ps26_psel & ps26_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_27
			| (ps27_psel & ps27_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_28
			| (ps28_psel & ps28_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_29
			| (ps29_psel & ps29_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_30
			| (ps30_psel & ps30_pslverr)
`endif
`ifdef ATCAPBBRG100_SLV_31
			| (ps31_psel & ps31_pslverr)
`endif
;
assign	s16	= s28
`ifdef ATCAPBBRG100_SLV_1
			| ps1_psel
`endif
`ifdef ATCAPBBRG100_SLV_2
			| ps2_psel
`endif
`ifdef ATCAPBBRG100_SLV_3
			| ps3_psel
`endif
`ifdef ATCAPBBRG100_SLV_4
			| ps4_psel
`endif
`ifdef ATCAPBBRG100_SLV_5
			| ps5_psel
`endif
`ifdef ATCAPBBRG100_SLV_6
			| ps6_psel
`endif
`ifdef ATCAPBBRG100_SLV_7
			| ps7_psel
`endif
`ifdef ATCAPBBRG100_SLV_8
			| ps8_psel
`endif
`ifdef ATCAPBBRG100_SLV_9
			| ps9_psel
`endif
`ifdef ATCAPBBRG100_SLV_10
			| ps10_psel
`endif
`ifdef ATCAPBBRG100_SLV_11
			| ps11_psel
`endif
`ifdef ATCAPBBRG100_SLV_12
			| ps12_psel
`endif
`ifdef ATCAPBBRG100_SLV_13
			| ps13_psel
`endif
`ifdef ATCAPBBRG100_SLV_14
			| ps14_psel
`endif
`ifdef ATCAPBBRG100_SLV_15
			| ps15_psel
`endif
`ifdef ATCAPBBRG100_SLV_16
			| ps16_psel
`endif
`ifdef ATCAPBBRG100_SLV_17
			| ps17_psel
`endif
`ifdef ATCAPBBRG100_SLV_18
			| ps18_psel
`endif
`ifdef ATCAPBBRG100_SLV_19
			| ps19_psel
`endif
`ifdef ATCAPBBRG100_SLV_20
			| ps20_psel
`endif
`ifdef ATCAPBBRG100_SLV_21
			| ps21_psel
`endif
`ifdef ATCAPBBRG100_SLV_22
			| ps22_psel
`endif
`ifdef ATCAPBBRG100_SLV_23
			| ps23_psel
`endif
`ifdef ATCAPBBRG100_SLV_24
			| ps24_psel
`endif
`ifdef ATCAPBBRG100_SLV_25
			| ps25_psel
`endif
`ifdef ATCAPBBRG100_SLV_26
			| ps26_psel
`endif
`ifdef ATCAPBBRG100_SLV_27
			| ps27_psel
`endif
`ifdef ATCAPBBRG100_SLV_28
			| ps28_psel
`endif
`ifdef ATCAPBBRG100_SLV_29
			| ps29_psel
`endif
`ifdef ATCAPBBRG100_SLV_30
			| ps30_psel
`endif
`ifdef ATCAPBBRG100_SLV_31
			| ps31_psel
`endif
;
`ifdef ATCAPBBRG100_FLOP_OUT
assign s33  = s42[`ATCAPBBRG100_ADDR_MSB+8:`ATCAPBBRG100_ADDR_MSB+5];
assign s34 = s42[`ATCAPBBRG100_ADDR_MSB+4];
assign s35 = s42[`ATCAPBBRG100_ADDR_MSB+3];
assign s8  = s42[`ATCAPBBRG100_ADDR_MSB+2];
assign s7       = s42[`ATCAPBBRG100_ADDR_MSB+1];
assign s9     = s42[`ATCAPBBRG100_ADDR_MSB:0];
`else
assign s33  = s41[`ATCAPBBRG100_ADDR_MSB+8:`ATCAPBBRG100_ADDR_MSB+5];
assign s34 = s41[`ATCAPBBRG100_ADDR_MSB+4];
assign s35 = s41[`ATCAPBBRG100_ADDR_MSB+3];
assign s8  = s41[`ATCAPBBRG100_ADDR_MSB+2];
assign s7       = s41[`ATCAPBBRG100_ADDR_MSB+1];
assign s9     = s41[`ATCAPBBRG100_ADDR_MSB:0];
`endif

`ifdef ATCAPBBRG100_FLOP_OUT
always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		penable <= 1'b0;
    else
        penable <= (s44 == ST_P_ACCESS)? 1'b1 : 1'b0;
end


always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s4 <= 1'b0;
	else if (s4)
		s4 <= 1'b0;
	else if (s31 & ~s16)
		s4 <= 1'b1;
end

`else
always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		penable <= 1'b0;
	else if (~penable & s31 & s16)
		penable <= 1'b1;
	else if (s17)
		penable <= 1'b0;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s4 <= 1'b0;
	else if (s4)
		s4 <= 1'b0;
	else if (s31 & ~s16)
		s4 <= 1'b1;
end
`endif


`ifdef ATCAPBBRG100_SLV_0
assign	s28	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV0_OFFSET_LSB], {`ATCAPBBRG100_SLV0_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV0_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_1
assign	ps1_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV1_OFFSET_LSB], {`ATCAPBBRG100_SLV1_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV1_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_2
assign	ps2_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV2_OFFSET_LSB], {`ATCAPBBRG100_SLV2_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV2_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_3
assign	ps3_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV3_OFFSET_LSB], {`ATCAPBBRG100_SLV3_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV3_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_4
assign	ps4_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV4_OFFSET_LSB], {`ATCAPBBRG100_SLV4_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV4_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_5
assign	ps5_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV5_OFFSET_LSB], {`ATCAPBBRG100_SLV5_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV5_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_6
assign	ps6_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV6_OFFSET_LSB], {`ATCAPBBRG100_SLV6_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV6_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_7
assign	ps7_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV7_OFFSET_LSB], {`ATCAPBBRG100_SLV7_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV7_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_8
assign	ps8_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV8_OFFSET_LSB], {`ATCAPBBRG100_SLV8_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV8_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_9
assign	ps9_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV9_OFFSET_LSB], {`ATCAPBBRG100_SLV9_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV9_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_10
assign	ps10_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV10_OFFSET_LSB], {`ATCAPBBRG100_SLV10_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV10_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_11
assign	ps11_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV11_OFFSET_LSB], {`ATCAPBBRG100_SLV11_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV11_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_12
assign	ps12_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV12_OFFSET_LSB], {`ATCAPBBRG100_SLV12_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV12_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_13
assign	ps13_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV13_OFFSET_LSB], {`ATCAPBBRG100_SLV13_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV13_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_14
assign	ps14_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV14_OFFSET_LSB], {`ATCAPBBRG100_SLV14_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV14_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_15
assign	ps15_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV15_OFFSET_LSB], {`ATCAPBBRG100_SLV15_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV15_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_16
assign	ps16_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV16_OFFSET_LSB], {`ATCAPBBRG100_SLV16_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV16_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_17
assign	ps17_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV17_OFFSET_LSB], {`ATCAPBBRG100_SLV17_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV17_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_18
assign	ps18_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV18_OFFSET_LSB], {`ATCAPBBRG100_SLV18_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV18_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_19
assign	ps19_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV19_OFFSET_LSB], {`ATCAPBBRG100_SLV19_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV19_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_20
assign	ps20_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV20_OFFSET_LSB], {`ATCAPBBRG100_SLV20_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV20_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_21
assign	ps21_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV21_OFFSET_LSB], {`ATCAPBBRG100_SLV21_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV21_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_22
assign	ps22_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV22_OFFSET_LSB], {`ATCAPBBRG100_SLV22_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV22_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_23
assign	ps23_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV23_OFFSET_LSB], {`ATCAPBBRG100_SLV23_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV23_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_24
assign	ps24_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV24_OFFSET_LSB], {`ATCAPBBRG100_SLV24_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV24_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_25
assign	ps25_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV25_OFFSET_LSB], {`ATCAPBBRG100_SLV25_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV25_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_26
assign	ps26_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV26_OFFSET_LSB], {`ATCAPBBRG100_SLV26_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV26_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_27
assign	ps27_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV27_OFFSET_LSB], {`ATCAPBBRG100_SLV27_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV27_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_28
assign	ps28_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV28_OFFSET_LSB], {`ATCAPBBRG100_SLV28_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV28_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_29
assign	ps29_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV29_OFFSET_LSB], {`ATCAPBBRG100_SLV29_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV29_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_30
assign	ps30_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV30_OFFSET_LSB], {`ATCAPBBRG100_SLV30_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV30_OFFSET);
`endif
`ifdef ATCAPBBRG100_SLV_31
assign	ps31_psel	= s31 & ({paddr[`ATCAPBBRG100_OFFSET_MSB : `ATCAPBBRG100_SLV31_OFFSET_LSB], {`ATCAPBBRG100_SLV31_OFFSET_LSB{1'b0}}} == `ATCAPBBRG100_SLV31_OFFSET);
`endif
assign	s26	= 1'b1;
assign	s27	= 1'b0;



assign	s25	= ~s28 ? 33'h0 :
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h0) ? {1'b0,`ATCAPBBRG100_PRODUCT_ID} :
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h5) ? {32'h0, s3} :

`ifdef ATCAPBBRG100_SLV_1
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h8) ? `ATCAPBBRG100_SLV1_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_2
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h9) ? `ATCAPBBRG100_SLV2_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_3
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'ha) ? `ATCAPBBRG100_SLV3_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_4
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'hb) ? `ATCAPBBRG100_SLV4_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_5
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'hc) ? `ATCAPBBRG100_SLV5_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_6
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'hd) ? `ATCAPBBRG100_SLV6_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_7
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'he) ? `ATCAPBBRG100_SLV7_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_8
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'hf) ? `ATCAPBBRG100_SLV8_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_9
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h10) ? `ATCAPBBRG100_SLV9_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_10
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h11) ? `ATCAPBBRG100_SLV10_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_11
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h12) ? `ATCAPBBRG100_SLV11_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_12
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h13) ? `ATCAPBBRG100_SLV12_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_13
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h14) ? `ATCAPBBRG100_SLV13_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_14
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h15) ? `ATCAPBBRG100_SLV14_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_15
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h16) ? `ATCAPBBRG100_SLV15_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_16
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h17) ? `ATCAPBBRG100_SLV16_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_17
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h18) ? `ATCAPBBRG100_SLV17_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_18
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h19) ? `ATCAPBBRG100_SLV18_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_19
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1a) ? `ATCAPBBRG100_SLV19_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_20
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1b) ? `ATCAPBBRG100_SLV20_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_21
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1c) ? `ATCAPBBRG100_SLV21_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_22
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1d) ? `ATCAPBBRG100_SLV22_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_23
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1e) ? `ATCAPBBRG100_SLV23_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_24
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h1f) ? `ATCAPBBRG100_SLV24_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_25
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h20) ? `ATCAPBBRG100_SLV25_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_26
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h21) ? `ATCAPBBRG100_SLV26_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_27
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h22) ? `ATCAPBBRG100_SLV27_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_28
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h23) ? `ATCAPBBRG100_SLV28_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_29
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h24) ? `ATCAPBBRG100_SLV29_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_30
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h25) ? `ATCAPBBRG100_SLV30_CFG_REG :
`endif

`ifdef ATCAPBBRG100_SLV_31
	(paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h26) ? `ATCAPBBRG100_SLV31_CFG_REG :
`endif
	33'h0;

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s3		<= 1'b0;
	else if (s28 & s26 & pwrite & penable &
		 (paddr[`ATCAPBBRG100_REG_ADDR_MSB:2] == `ATCAPBBRG100_REG_ADDR_WIDTH'h5))
		s3		<= pwdata[0];
end

endmodule
