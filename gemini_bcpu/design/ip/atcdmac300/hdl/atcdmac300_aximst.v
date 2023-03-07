// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_aximst(
                          	  aclk,
                          	  aresetn,
                          	  awid,
                          	  awaddr,
                          	  awlen,
                          	  awsize,
                          	  awburst,
                          	  awlock,
                          	  awcache,
                          	  awprot,
                          	  awvalid,
                          	  awready,
                          	  wstrb,
                          	  wlast,
                          	  wdata,
                          	  wvalid,
                          	  wready,
                          	  bid,
                          	  bresp,
                          	  bvalid,
                          	  bready,
                          	  arid,
                          	  araddr,
                          	  arlen,
                          	  arsize,
                          	  arburst,
                          	  arlock,
                          	  arcache,
                          	  arprot,
                          	  arvalid,
                          	  arready,
                          	  rid,
                          	  rresp,
                          	  rlast,
                          	  rdata,
                          	  rvalid,
                          	  rready,
                          `ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
                          	  dma1_mst_wr_mask,
                          	  dma1_mst_req,
                          	  dma1_mst_addr,
                          	  dma1_mst_write,
                          	  dma1_mst_size,
                          	  dma1_mst_fix,
                          	  dma1_mst_len,
                          	  dma1_mst_wdata,
                          	  dma1_current_channel,
                          	  mst_dma1_grant,
                          	  mst_dma1_rd_ack,
                          	  mst_dma1_wr_ack,
                          	  mst_dma1_rdata,
                          	  mst_dma1_rlast,
                          	  mst_dma1_error,
                          	  mst_dma1_bvalid,
                          `endif
                          	  dma0_mst_wr_mask,
                          	  dma0_mst_req,
                          	  dma0_mst_addr,
                          	  dma0_mst_write,
                          	  dma0_mst_size,
                          	  dma0_mst_fix,
                          	  dma0_mst_len,
                          	  dma0_mst_wdata,
                          	  dma0_current_channel,
                          	  mst_dma0_grant,
                          	  mst_dma0_rd_ack,
                          	  mst_dma0_wr_ack,
                          	  mst_dma0_rdata,
                          	  mst_dma0_rlast,
                          	  mst_dma0_error,
                          	  mst_dma0_bvalid
);
localparam	BURST_FIX	=  2'b00;
localparam	BURST_INCR	=  2'b01;
localparam	SLVERR		=  2'b10;
localparam	DECERR		=  2'b11;

input          					aclk;
input          					aresetn;
output	[2:0]					awid;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]		awaddr;
output	[7:0]					awlen;
output	[2:0]					awsize;
output	[1:0]					awburst;
output						awlock;
output	[3:0]					awcache;
output	[2:0]					awprot;
output						awvalid;
input						awready;
output	[(`DMA_WSTRB_WIDTH-1):0]		wstrb;
output						wlast;
output	[(`DMA_DATA_WIDTH-1):0]			wdata;
output						wvalid;
input						wready;
input	[2:0]					bid;
input	[1:0]					bresp;
input						bvalid;
output						bready;
output	[2:0] 					arid;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]		araddr;
output	[7:0]					arlen;
output	[2:0]					arsize;
output	[1:0]					arburst;
output						arlock;
output	[3:0]					arcache;
output	[2:0]					arprot;
output						arvalid;
input						arready;
input	[2:0]					rid;
input	[1:0]					rresp;
input						rlast;
input	[(`DMA_DATA_WIDTH-1):0]			rdata;
input						rvalid;
output						rready;

`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
input						dma1_mst_wr_mask;
input						dma1_mst_req;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]		dma1_mst_addr;
input						dma1_mst_write;
input	[2:0]					dma1_mst_size;
input						dma1_mst_fix;
input	[7:0]					dma1_mst_len;
input	[(`DMA_DATA_WIDTH-1):0]			dma1_mst_wdata;
input	[2:0]					dma1_current_channel;
output						mst_dma1_grant;
output						mst_dma1_rd_ack;
output						mst_dma1_wr_ack;
output	[(`DMA_DATA_WIDTH-1):0]			mst_dma1_rdata;
output						mst_dma1_rlast;
output						mst_dma1_error;
output						mst_dma1_bvalid;
`endif

input						dma0_mst_wr_mask;
input						dma0_mst_req;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]		dma0_mst_addr;
input						dma0_mst_write;
input	[2:0]					dma0_mst_size;
input						dma0_mst_fix;
input	[7:0]					dma0_mst_len;
input	[(`DMA_DATA_WIDTH-1):0]			dma0_mst_wdata;
input	[2:0]					dma0_current_channel;
output						mst_dma0_grant;
output						mst_dma0_rd_ack;
output						mst_dma0_wr_ack;
output	[(`DMA_DATA_WIDTH-1):0]			mst_dma0_rdata;
output                  			mst_dma0_rlast;
output						mst_dma0_error;
output						mst_dma0_bvalid;

reg	[8:0]					s0;
reg						wlast;
reg						s1;
reg						s2;
reg						s3;
reg						s4;
reg	[(`DMA_DATA_WIDTH-1):0]			s5;
reg						s6;

wire	[1:0]					s7;
wire						s8;
wire	[2:0]					s9;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0]		s10;
wire	[1:0]					s11;
wire	[2:0]					s12;
wire	[7:0]					s13;
wire						s14;
wire						s15;
wire	[(`DMA_DATA_WIDTH-1):0]			s16;
wire						s17;
wire						s18;
wire	[2:0]					s19;
wire	[(`ATCDMAC300_ADDR_WIDTH-1):0]		s20;
wire	[1:0]					s21;
wire	[2:0]					s22;
wire	[7:0]					s23;
wire						s24;
wire						s25;
wire	[(`DMA_DATA_WIDTH-1):0]			s26;
reg						s27;
wire						s28;
wire						s29;
wire						s30;
wire						s31;
reg	[(`DMA_DATA_WIDTH-1):0]			wdata;
wire	[`DMA_WSTRB_WIDTH:0]			s32;
reg	[(`DMA_WSTRB_WIDTH-1):0]		wstrb;
wire	[(`DMA_WSTRB_WIDTH-1):0]		s33;
wire						s34;
wire						s35;
wire						s36;
reg						s37;
wire						s38;
wire						s39;
wire						s40;
wire						s41;
wire	[8:0]					s42;
wire						s43;
reg	[`ATCDMAC300_BYTE_OFFSET_WIDTH-1:0]	s44;
reg						s45;
wire						s46;

`ifdef ATCDMAC300_DUAL_DMA_CORE_SUPPORT
reg						s47;
reg						s48;
reg						s49;
reg						s50;
wire						s51;
wire						s52;
wire						s53;
wire						s54;
wire						s55;
wire						s56;
wire						s57;
wire						s58;
wire	[1:0]					s59;

assign	s55		= !dma0_mst_write  && dma0_mst_req;
assign	s56		=  dma0_mst_write  && dma0_mst_req;
assign	s57		= !dma1_mst_write  && dma1_mst_req;
assign	s58		=  dma1_mst_write  && dma1_mst_req;
assign	s59		=  dma1_mst_fix     ? BURST_FIX : BURST_INCR;

assign	s51	= (s47  && s55) || ((!s49) && s55);
assign	s52	= (s48  && s56) || ((!s50) && s56);
assign	s53	= (s49  && s57) || ((!s47) && s57 && (!s55));
assign	s54	= (s50  && s58) || ((!s48) && s58 && (!s56));

assign	s8		= (s55  && s47) || (s57  && s49);
assign	s18		= (s56  && s48) || (s58  && s50);
assign	s9		=  s47 ? dma0_current_channel : dma1_current_channel;
assign	s19		=  s48 ? dma0_current_channel : dma1_current_channel;
assign	s24		=  s48 ? dma0_mst_wr_mask : dma1_mst_wr_mask;
assign	s25		=  s48 ? dma0_mst_write   : dma1_mst_write;
assign	s26		=  s48 ? dma0_mst_wdata   : dma1_mst_wdata;

assign	s10		=  s47 ? dma0_mst_addr  : dma1_mst_addr;
assign	s11	=  s47 ? s7 : s59;
assign	s12		=  s47 ? dma0_mst_size  : dma1_mst_size;
assign	s13		=  s47 ? dma0_mst_len   : dma1_mst_len;

assign	s20		=  s48 ? dma0_mst_addr  : dma1_mst_addr;
assign	s21	=  s48 ? s7 : s59;
assign	s22		=  s48 ? dma0_mst_size  : dma1_mst_size;
assign	s23		=  s48 ? dma0_mst_len   : dma1_mst_len;

assign	mst_dma0_grant		= (s47 && s14)    || (s48 && s28);
assign	mst_dma0_error		= (s47 && s6) || (s48 && s31);
assign	mst_dma0_rd_ack		= (s47 && s4  );
assign	mst_dma0_wr_ack		= (s48 && s29);
assign	mst_dma0_rlast		=  s47 && s37;
assign	mst_dma0_bvalid		=  s48 && s17;
assign	mst_dma0_rdata		=  s5;

assign	mst_dma1_grant		= (s49 && s14)    || (s50 && s28);
assign	mst_dma1_error		= (s49 && s6) || (s50 && s31);
assign	mst_dma1_rd_ack		= (s49 && s4  );
assign	mst_dma1_wr_ack		= (s50 && s29);
assign	mst_dma1_rlast		=  s49 && s37;
assign	mst_dma1_bvalid		=  s50 && s17;
assign	mst_dma1_rdata		=  s5;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		s47		<= 1'b0;
		s48		<= 1'b0;
		s49		<= 1'b0;
		s50		<= 1'b0;
	end
	else begin
		s47		<= s51;
		s48		<= s52;
		s49		<= s53;
		s50		<= s54;
	end
end

`else
assign	s9		=   dma0_current_channel;
assign	s19		=   dma0_current_channel;
assign	s8		= (!dma0_mst_write) && dma0_mst_req;
assign	s18		=   dma0_mst_write && dma0_mst_req;
assign	s24		=   dma0_mst_wr_mask;
assign	s10		=   dma0_mst_addr;
assign	s20		=   dma0_mst_addr;
assign	s12		=   dma0_mst_size;
assign	s22		=   dma0_mst_size;
assign	s13		=   dma0_mst_len;
assign	s23		=   dma0_mst_len;
assign	s11	=   s7;
assign	s21	=   s7;
assign	s25		=   dma0_mst_write;
assign	s26		=   dma0_mst_wdata;
assign	mst_dma0_grant		=   s14    || s28;
assign	mst_dma0_error		=   s6 || s31;
assign	mst_dma0_rd_ack		=   s4;
assign	mst_dma0_wr_ack		=   s29;
assign	mst_dma0_rdata		=   s5;
assign	mst_dma0_rlast		=   s37;
assign	mst_dma0_bvalid		=   s17;
`endif

assign	s7		=   dma0_mst_fix ? BURST_FIX : BURST_INCR;
assign	s38		=   rvalid && rready   &&  rlast;
assign	s39		=   wvalid && wready   &&  wlast;
assign	s40		=   bvalid && bready;
assign	s34	= (arvalid && arready) || (s1 && (!s37));
assign	s35	= (awvalid && awready) || (s2 && (!s39));
assign	s36	= (awvalid && awready) || (s3  && (!s40));
assign	s17		=  s40;
assign	arvalid			=  s8 && (!s1);
assign	awvalid			=  s18 && (!s24);
assign	bready			=  s3;
assign	rready			=  s1;

assign	arid			=  s9;
assign	araddr			=  s10;
assign	arlen			=  s13;
assign	arsize			=  s12;
assign	arburst			=  s11;
assign	arcache			=  4'h0;
assign	arlock			=  1'b0;
assign	arprot			=  3'h0;

assign	awid			=  s19;
assign	awaddr			=  s20;
assign	awlen			=  s23;
assign	awsize			=  s22;
assign	awburst			=  s21;
assign	awcache			=  4'h0;
assign	awlock			=  1'b0;
assign	awprot			=  3'h0;
assign	wvalid			=  s25 && s2 && (!s27);
assign	s33		=  s32[(`DMA_WSTRB_WIDTH-1):0] << s44;

assign	s16		=   rdata;
assign	s14	=  arvalid && arready;
assign	s15		=   rvalid &&  rready;
assign	s30	=   rvalid &&  rready && ((rresp == SLVERR) || (rresp == DECERR));
assign	s46	= (s30 || s45) && (!s38);
assign	s28	=  awvalid && awready;
assign	s29		=  (wvalid &&  wready && (!wlast)) || s27;
assign	s31	=   bvalid &&  bready && ((bresp == SLVERR) || (bresp == DECERR));

assign	s43		=  awready && awvalid;
assign	s41		= (s42 == 9'h1);
assign	s42		=  s43 ? {1'b0, awlen} + 9'h1 : (wvalid && wready) ? s0 - 9'h1 : s0;
assign	s32		=
				  (s22 == 3'h1) ? {{`DMA_WSTRB_WIDTH-1{1'b0}}, { 2{1'b1}}} :
				  (s22 == 3'h2) ? {{`DMA_WSTRB_WIDTH-3{1'b0}}, { 4{1'b1}}} :
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				  (s22 == 3'h3) ? {{`DMA_WSTRB_WIDTH-7{1'b0}}, { 8{1'b1}}} :
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				  (s22 == 3'h4) ? {{`DMA_WSTRB_WIDTH-15{1'b0}},{16{1'b1}}} :
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				  (s22 == 3'h5) ? {{`DMA_WSTRB_WIDTH-31{1'b0}},{32{1'b1}}} :
`endif
`endif
`endif
							      {{`DMA_WSTRB_WIDTH{1'b0}}, { 1{1'b1}}} ;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		s1		<= 1'b0;
		s2		<= 1'b0;
		s3		<= 1'b0;
		wlast			<= 1'b0;
		s0			<= 9'b0;
		s27	<= 1'b0;
		s4	<= 1'b0;
		s5	<= {`DMA_DATA_WIDTH{1'b0}};
		s37	<= 1'b0;
		s6	<= 1'b0;
		s45	<= 1'b0;
	end
	else begin
		s1		<= s34;
		s2		<= s35;
		s3		<= s36;
		wlast			<= s41;
		s0			<= s42;
		s27	<= s28;
		s4	<= s15;
		s5	<= s16;
		s37	<= s38;
		s6	<= (s45 || s30) && s38;
		s45	<= s46;
	end
end
always @(posedge aclk or negedge aresetn)
	if (!aresetn) begin
		wdata			<= {`DMA_DATA_WIDTH{1'b0}};
		wstrb			<= {`DMA_WSTRB_WIDTH{1'b0}};
	end
	else if (s27 || (wvalid && wready)) begin
		wdata			<= s26;
		wstrb			<= s33;
	end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s44 	<= {`ATCDMAC300_BYTE_OFFSET_WIDTH{1'b0}};
	else if (awvalid && awready)
		s44 	<= awaddr[(`ATCDMAC300_BYTE_OFFSET_WIDTH-1):0];
	else if ((s27 || (wvalid &&  wready)) && (s21 == BURST_INCR))
		s44 	<= s44 + ({{`ATCDMAC300_BYTE_OFFSET_WIDTH-1{1'b0}}, 1'b1} << s22);
end
endmodule
