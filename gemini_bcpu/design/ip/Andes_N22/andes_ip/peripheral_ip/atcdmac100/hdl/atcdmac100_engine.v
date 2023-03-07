// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcdmac100_config.vh"
`include "atcdmac100_const.vh"

module atcdmac100_engine (
                           	  hclk,
                           	  hresetn,
                           	  dma_soft_reset,
                           	  idle_state,
                           	  arb_end,
                           	  arb_end_1st_cycle,
                           	  dma_mst_req,
                           	  dma_mst_addr,
                           	  dma_mst_write,
                           	  dma_mst_size,
                           	  dma_mst_wdata,
                           	  dma_mst_burst,
                           	  dma_mst_direction_change,
                           	  addr_cross_1k,
                           	  mst_dma_addr,
                           	  mst_dma_grant,
                           	  mst_dma_1st_ap,
                           	  mst_dma_ack,
                           	  mst_dma_rdata,
                           	  mst_dma_error,
                           	  mst_dma_retry_2nd_cycle,
                           	  mst_dma_retry_ap,
                           	  ch_src_addr_ctl,
                           	  ch_dst_addr_ctl,
                           	  ch_src_width,
                           	  ch_dst_width,
                           	  ch_src_burst_size,
                           	  ch_src_mode,
                           	  ch_src_request,
                           	  ch_dst_mode,
                           	  ch_dst_request,
                           	  ch_tts,
                           	  ch_src_addr,
                           	  ch_dst_addr,
                           	  ch_int_tc_mask,
                           	  ch_int_err_mask,
                           	  ch_int_abt_mask,
                           `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                           	  ch_llp,
                           `endif
                           	  ch_abt,
                           	  dma_ch_src_ack,
                           	  dma_ch_dst_ack,
                           	  dma_ch_ctl_wen,
                           	  dma_ch_en_wen,
                           	  dma_ch_src_addr_wen,
                           	  dma_ch_dst_addr_wen,
                           `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
                           	  dma_ch_llp_wen,
                           	  dma_ch_llp_wdata,
                           `endif
                           	  dma_ch_tts_wen,
                           	  dma_ch_tc_wen,
                           	  dma_ch_err_wen,
                           	  dma_ch_int_wen,
                           	  dma_ch_ctl_wdata,
                           	  dma_ch_tts_wdata,
                           	  dma_ch_src_addr_wdata,
                           	  dma_ch_dst_addr_wdata,
                           	  dma_fifo_rbyte_offset,
                           	  dma_fifo_wbyte_offset,
                           	  dma_fifo_flush,
                           	  dma_fifo_last_wr,
                           	  dma_fifo_last_rd,
                           	  dma_fifo_rd,
                           	  dma_fifo_wr_size,
                           	  dma_fifo_rd_size,
                           	  dma_fifo_wdata,
                           	  dma_fifo_wr,
                           	  dma_fifo_src_addr_dec,
                           	  dma_fifo_dst_addr_dec,
                           	  dma_fifo_rdata
);
parameter  ADDR_WIDTH 	= 32;
parameter  DATA_WIDTH 	= 32;

localparam ADDR_MSB 	= ADDR_WIDTH - 1;
localparam DATA_MSB 	= DATA_WIDTH - 1;

localparam FIFO_COUNTER_WIDTH	= `ATCDMAC100_FIFO_DEPTH ==  6'd4 ? 5 :
				  `ATCDMAC100_FIFO_DEPTH ==  6'd8 ? 6 :
				  `ATCDMAC100_FIFO_DEPTH == 6'd16 ? 7 : 8;
localparam FIFO_COUNTER_MSB	= FIFO_COUNTER_WIDTH - 1;
localparam [FIFO_COUNTER_MSB:0] FIFO_CAPACITY	= `ATCDMAC100_FIFO_DEPTH << 2;

localparam DMAC_MSB 	= {28'h0, {`ATCDMAC100_CH_NUM - 4'd1}};

localparam ST_IDLE		= 3'b000;
localparam ST_READ		= 3'b001;
localparam ST_READ_END		= 3'b010;
localparam ST_WRITE		= 3'b011;
localparam ST_WRITE_END		= 3'b100;
localparam ST_LLP		= 3'b101;
localparam ST_LLP_END		= 3'b110;
localparam ST_END		= 3'b111;

localparam HBURST_SINGLE	= 3'b000;
localparam HBURST_INCR		= 3'b001;
localparam HBURST_INCR4		= 3'b011;
localparam HBURST_INCR8		= 3'b101;
localparam HBURST_INCR16	= 3'b111;

input					hclk;
input					hresetn;
input					dma_soft_reset;

output					idle_state;
input 					arb_end;
output 					arb_end_1st_cycle;

output					dma_mst_req;
output	[ADDR_MSB:0]			dma_mst_addr;
output					dma_mst_write;
output	[1:0]				dma_mst_size;
output	[DATA_MSB:0]			dma_mst_wdata;
output	[2:0]				dma_mst_burst;
output					dma_mst_direction_change;
output					addr_cross_1k;
input	[ADDR_MSB:0]			mst_dma_addr;
input					mst_dma_grant;
input					mst_dma_1st_ap;
input					mst_dma_ack;
input	[DATA_MSB:0]			mst_dma_rdata;
input					mst_dma_error;
input					mst_dma_retry_2nd_cycle;
input					mst_dma_retry_ap;

input	[1:0]				ch_src_addr_ctl;
input	[1:0]				ch_dst_addr_ctl;
input	[1:0]				ch_src_width;
input	[1:0]				ch_dst_width;
input	[2:0]				ch_src_burst_size;
input					ch_src_mode;
input					ch_src_request;
input					ch_dst_mode;
input					ch_dst_request;
input	[21:0]				ch_tts;
input	[ADDR_MSB:0]			ch_src_addr;
input	[ADDR_MSB:0]			ch_dst_addr;
input					ch_int_tc_mask;
input					ch_int_err_mask;
input					ch_int_abt_mask;

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
input	[ADDR_MSB:0]			ch_llp;
`else
wire	[ADDR_MSB:0]			ch_llp = {ADDR_WIDTH{1'b0}};
`endif
input					ch_abt;
output					dma_ch_src_ack;
output					dma_ch_dst_ack;
output					dma_ch_ctl_wen;
output					dma_ch_en_wen;
output					dma_ch_src_addr_wen;
output					dma_ch_dst_addr_wen;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
output					dma_ch_llp_wen;
output	[ADDR_MSB:0]			dma_ch_llp_wdata;
`endif
output					dma_ch_tts_wen;
output					dma_ch_tc_wen;
output					dma_ch_err_wen;
output					dma_ch_int_wen;
output	[31:1]				dma_ch_ctl_wdata;
output	[21:0]				dma_ch_tts_wdata;
output	[ADDR_MSB:0]			dma_ch_src_addr_wdata;
output	[ADDR_MSB:0]			dma_ch_dst_addr_wdata;

output	[1:0]				dma_fifo_rbyte_offset;
output	[1:0]				dma_fifo_wbyte_offset;
output					dma_fifo_flush;
output					dma_fifo_last_wr;
output					dma_fifo_last_rd;
output					dma_fifo_rd;
output	[1:0]				dma_fifo_wr_size;
output	[1:0]				dma_fifo_rd_size;
output	[31:0]				dma_fifo_wdata;
output					dma_fifo_wr;
output					dma_fifo_src_addr_dec;
output					dma_fifo_dst_addr_dec;
input	[31:0]				dma_fifo_rdata;

wire					idle_state;
wire					s0;
wire					s1;
wire					s2;
wire					s3;
wire					s4;
reg	[2:0]				s5;
reg	[2:0]				s6;
wire					s7;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire					s8;
wire					s9;
`else
wire					s8 = 1'b0;
wire					s9 = 1'b0;
`endif

reg					dma_ch_src_ack;
reg					dma_ch_dst_ack;
reg					s10;
reg					s11;
wire					s12;
reg					s13;
reg					s14;
reg					s15;
wire					s16;
reg					s17;
wire					s18;
wire					s19;
wire					s20;
wire					s21;
wire					s22;
wire					s23;
wire					s24;
wire					s25;
wire					s26;
wire					s27;
wire					s28;
wire					s29;
wire					s30;
wire					s31;
wire					s32;
wire					s33;
wire					s34;
wire					s35;
wire					s36;
wire					s37;
wire					s38;
wire					s39;
wire	[7:0]				s40;
wire	[2:0]				s41;

wire					s42;
wire					s43;
wire					s44;
wire					s45;
wire					s46;
wire					s47;
wire					addr_cross_1k;
wire					s48;
wire					s49;
wire					s50;
reg					s51;
wire					s52;
wire					s53;
wire					s54;
reg					s55;
reg					s56;
reg	[7:0]				s57;
wire	[7:0]				s58;
reg	[21:0]				s59;
wire	[21:0]				s60;
wire	[2:0]				s61;
wire	[2:0]				s62;
reg	[FIFO_COUNTER_MSB:0]		s63;
wire	[FIFO_COUNTER_MSB:0]		s64;
wire	[2:0]				s65;
wire	[2:0]				s66;
wire					s67;
reg					s68;
wire					s69;
wire					s70;

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
reg	[2:0]				s71;
wire	[2:0]				s72;
`else
wire	[2:0]				s71 = 3'd0;
`endif

wire	[ADDR_MSB:0]			s73;
reg	[1:0]				s74;
reg	[1:0]				s75;
wire	[ADDR_MSB:0]			s76;
reg	[ADDR_MSB:0]			s77;
wire					s78;
wire					s79;
wire					s80;
wire					s81;
wire					s82;
wire					s83;

wire					s84;

wire					s85;
wire					s86;
wire					s87;

wire					s88;
wire					s89;

reg					s90;

reg	[31:0]				dma_fifo_wdata;
reg					dma_fifo_wr;
reg					dma_fifo_last_wr;

reg					s91;

assign	idle_state 		= (s5 == ST_IDLE);
assign	s0 		= (s5 == ST_READ);
assign	s1 		= (s5 == ST_READ_END);
assign	s2 		= (s5 == ST_WRITE);
assign	s3 	= (s5 == ST_WRITE_END);
assign	s4 		= (s5 == ST_END);

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign	s8		= (s5 == ST_LLP);
assign	s9		= (s5 == ST_LLP_END);
`endif

assign 	s42 = s45 & mst_dma_grant;
assign 	s43 = s46 & mst_dma_grant;
assign 	s44 = s47 & mst_dma_grant;
assign	dma_mst_req	= ((s86 | s0) & ~s42) |
			  ((s85 | s8) & ~s43) |
			  ((s87 | s2) & ~s44);
assign	dma_mst_addr 	=  s85	? ch_llp :
			   s87	? ch_dst_addr :
			   s86	? ch_src_addr : s76;
assign	dma_mst_write	= s87 | s2;
assign	dma_mst_size	= (s85 || s8) ? 2'b10 :
			  (s87 || s2) ? ch_dst_width : ch_src_width;
assign	dma_mst_wdata	= dma_fifo_rdata;
assign	s54	= mst_dma_error;
assign	dma_mst_burst	= (s85 || s8) ? HBURST_SINGLE :
			  (s87 || s2) ? s66 : s65;

assign	dma_fifo_flush 	     	= s55;
assign	dma_fifo_rd		= s2 & mst_dma_grant & ~mst_dma_retry_ap;
assign	dma_fifo_wr_size	= ch_src_width;
assign	dma_fifo_rd_size	= ch_dst_width;
assign 	dma_fifo_src_addr_dec 	= s28;
assign 	dma_fifo_dst_addr_dec 	= s29;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		dma_fifo_wr		<= 1'b0;
		dma_fifo_wdata		<= 32'b0;
		dma_fifo_last_wr 	<= 1'b0;
	end
	else begin
		dma_fifo_wr		<= s84 & mst_dma_ack;
		dma_fifo_wdata		<= (s84 & mst_dma_ack) ? mst_dma_rdata : dma_fifo_wdata;
		dma_fifo_last_wr 	<= s1;
	end
end

assign dma_fifo_last_rd = s47;

assign	dma_ch_en_wen		= s4 & ((ch_tts == 22'b0) | ch_abt | s17 | s55);
assign	dma_ch_ctl_wen		= s8 & (s71 == 3'b001) & mst_dma_ack;
assign 	dma_ch_src_addr_wen 	= ((s0 | s1)  & mst_dma_ack) | (s8 & (s71 == 3'b010) & mst_dma_ack);
assign 	dma_ch_dst_addr_wen 	= ((s2 | s3) & mst_dma_ack) | (s8 & (s71 == 3'b011) & mst_dma_ack);
assign	dma_ch_tts_wen		= ((s0 | s1)  & mst_dma_ack) | (s8 & (s71 == 3'b100) & mst_dma_ack);
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign 	dma_ch_llp_wen 		= (s8 | s9) & (s71 == 3'b101) & mst_dma_ack;
`endif
assign	dma_ch_tc_wen		= s4 & ~ s56 & (~|ch_tts) & ~s55 & ~s17;
assign 	dma_ch_err_wen		= s4 & ~ s56 & (s55 | s17);
assign 	dma_ch_int_wen		= (dma_ch_tc_wen & ~s13) |
				  (dma_ch_err_wen & ~s14) |
				  (ch_abt & ~s15);
assign	dma_ch_ctl_wdata	= mst_dma_rdata[31:1];
assign	dma_ch_src_addr_wdata 	= s73;
assign	dma_ch_dst_addr_wdata 	= s73;
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign	dma_ch_llp_wdata 	= (s71 == 3'b101) ? mst_dma_rdata[ADDR_MSB:0] : s76;
`endif
assign	dma_ch_tts_wdata	= s8 ? mst_dma_rdata[21:0] : s59;

assign	s76		= mst_dma_addr + s77;
assign	s73 	= s8 ? mst_dma_rdata[ADDR_MSB:0] : mst_dma_addr;

assign	s26	= (ch_src_addr_ctl == 2'b00);
assign	s27 	= (ch_dst_addr_ctl == 2'b00);
assign	s28	= (ch_src_addr_ctl == 2'b01);
assign	s29 	= (ch_dst_addr_ctl == 2'b01);
assign	s30	= (ch_src_addr_ctl == 2'b10);
assign	s31	= (ch_dst_addr_ctl == 2'b10);

assign	s32	= (ch_src_width == 2'b00);
assign	s33	= (ch_src_width == 2'b01);
assign	s34	= (ch_src_width == 2'b10);
assign	s35	= (ch_dst_width == 2'b00);
assign	s36	= (ch_dst_width == 2'b01);
assign	s37	= (ch_dst_width == 2'b10);

assign	s78 = 	(( s0) & s26 & s34) |
		((s2) & s27 & s37) |
		(s8);
assign	s79 = 	(( s0) & s26 & s33) |
		((s2) & s27 & s36);
assign	s80 = 	(( s0) & s26 & s32) |
		((s2) & s27 & s35);
assign	s81 = 	(( s0) & s28 & s34) |
		((s2) & s29 & s37);
assign	s82 = 	(( s0) & s28 & s33) |
		((s2) & s29 & s36);
assign	s83 = 	(( s0) & s28 & s32) |
		((s2) & s29 & s35);

assign	s19 	= (ch_src_width[0] & ch_src_addr[0]) | (ch_src_width[1] & |ch_src_addr[1:0]) |
			  (ch_dst_width[0] & ch_dst_addr[0]) | (ch_dst_width[1] & |ch_dst_addr[1:0]);

assign 	s38 = s32 & (ch_tts[0] | (ch_src_burst_size == 3'b000));
assign 	s39 = (s33 & (ch_tts[0] | (ch_src_burst_size == 3'b000))) |
			      (s32 & ((ch_tts[1:0] == 2'b10) | (ch_src_burst_size == 3'b001)));

assign	s18	= (s37 & (s39 | s38)) |
			  (s36 & s38);

assign	s21 	= (ch_src_width == 2'b11);
assign	s22 	= (ch_dst_width == 2'b11);
assign	s23 	= (ch_src_addr_ctl == 2'b11);
assign	s24 	= (ch_dst_addr_ctl == 2'b11);
assign 	s25		= s21 | s22 | s23 | s24;

assign 	s16 = arb_end & ((ch_tts == 22'b0) | s19 | s18 | s25);

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s17 <= 1'b0;
	end
	else begin
		s17 <= s16;
	end
end

always @(*) begin
	case({s78, s79, s80, s81, s82, s83})
		6'b000001: s77 = {ADDR_WIDTH{1'b1}};
		6'b000010: s77 = {{(ADDR_WIDTH-1){1'b1}},1'b0};
		6'b000100: s77 = {{(ADDR_WIDTH-2){1'b1}},2'b00};
		6'b001000: s77 = {{(ADDR_WIDTH-1){1'b0}},1'b1};
		6'b010000: s77 = {{(ADDR_WIDTH-2){1'b0}},2'b10};
		6'b100000: s77 = {{(ADDR_WIDTH-3){1'b0}},3'b100};
		default: s77 = {ADDR_WIDTH{1'b0}};
	endcase
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s74	<= 2'b0;
	end
	else if (mst_dma_grant) begin
		s74	<= mst_dma_addr[1:0];
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s75	<= 2'b0;
	end
	else begin
		s75	<= s74;
	end
end

assign	dma_fifo_rbyte_offset = mst_dma_addr[1:0];

assign	dma_fifo_wbyte_offset = s75;

assign	s40 = 8'b1 << ch_src_burst_size;

assign	s20 = (({1'b0,ch_src_burst_size} + {2'b0, ch_src_width}) > `ATCDMAC100_FIFO_BYTE);

assign	s65 = 	(s30 || s28 || s67 || (ch_src_burst_size < 3'h2) || s20) ? HBURST_SINGLE :
			(ch_src_burst_size == 3'h2) ? HBURST_INCR4 :
			(ch_src_burst_size == 3'h3) ? HBURST_INCR8 : HBURST_INCR16;

assign	s41 = 	(ch_dst_width > ch_src_width) ? (ch_src_burst_size - {1'b0, (ch_dst_width - ch_src_width)}) :
				(ch_src_width > ch_dst_width) ? (ch_src_burst_size + {1'b0, (ch_src_width - ch_dst_width)}) :
								ch_src_burst_size;

assign	s66 = 	(s31 || s29 || ((~|ch_tts) || (~|dma_ch_tts_wdata && dma_ch_tts_wen)) || (s41 < 3'h2) || s20) ? HBURST_SINGLE :
			(s41 == 3'h2) ? HBURST_INCR4 :
			(s41 == 3'h3) ? HBURST_INCR8 : HBURST_INCR16;

assign s7 = idle_state & arb_end;

assign s58 = 	((s0 || s1) && mst_dma_retry_2nd_cycle) ? s57 + 8'h1  :
				s7 ? 		s40 :
				(s0 && mst_dma_grant) ? s57 - 8'h1  : s57;

assign s60   = 	((s0 || s1) && mst_dma_retry_2nd_cycle) ? s59 + 22'h1  :
				s7 ? 		ch_tts :
				(s0 && mst_dma_grant) ? s59 - 22'h1  : s59;

assign s61	= 3'b1 << ch_src_width;
assign s62	= 3'b1 << ch_dst_width;

assign s64  = 	!(s0 || s1|| s2 || s3) ? {(FIFO_COUNTER_WIDTH){1'b0}} :
				((s0 || s1) && mst_dma_retry_2nd_cycle) ? 	s63 - {{(FIFO_COUNTER_WIDTH-3){1'b0}}, s61} :
				(s0 && mst_dma_grant) ? 				s63 + {{(FIFO_COUNTER_WIDTH-3){1'b0}}, s61} :
				((s2 || s3) && mst_dma_retry_2nd_cycle) ? s63 + {{(FIFO_COUNTER_WIDTH-3){1'b0}}, s62} :
				(s2 && mst_dma_grant) ? 				s63 - {{(FIFO_COUNTER_WIDTH-3){1'b0}}, s62} : s63;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s57	<= 8'b0;
		s59	<= 22'b0;
		s63	<= {(FIFO_COUNTER_WIDTH){1'b0}};
	end
	else if (dma_soft_reset || s54) begin
		s57	<= 8'b0;
		s59	<= 22'b0;
		s63	<= {(FIFO_COUNTER_WIDTH){1'b0}};
	end
	else begin
		s57	<= s58;
		s59	<= s60;
		s63	<= s64;
	end
end

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
assign	s72  = 	!(s8 || s9) ? 3'b0 :
				((s8 || s9) && mst_dma_retry_2nd_cycle) ? s71 - 3'd1 :
				(s8 && mst_dma_grant) ? s71 + 3'd1 : s71;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s71 <= 3'b0;
	end
	else if (dma_soft_reset || s54) begin
		s71 <= 3'b0;
	end
	else  begin
		s71 <= s72;
	end
end
`endif

assign arb_end_1st_cycle = arb_end & ~s90;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s90 <= 1'b0;
	end
	else begin
		s90 <= arb_end;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s13 	<= 1'b0;
		s14 	<= 1'b0;
		s15 	<= 1'b0;
	end
	else if (idle_state && arb_end) begin
		s13	<= ch_int_tc_mask;
		s14	<= ch_int_err_mask;
		s15	<= ch_int_abt_mask;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s55		<= 1'b0;
	end
	else if (dma_soft_reset) begin
		s55		<= 1'b0;
	end
	else begin
		s55		<= s54;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s5 	<= ST_IDLE;
	end
	else if (dma_soft_reset) begin
		s5 	<= ST_IDLE;
	end
	else begin
		s5 	<= s6;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s56	<= 1'b0;
	end
	else if (dma_soft_reset) begin
		s56	<= 1'b0;
	end
	else begin
		s56	<= s4;
	end
end

assign s69 = ({14'b0,s40} > ch_tts) & s7;
assign s70 = ({14'b0,s40} <= ch_tts) & s7;
assign s67 = (s69 | s68) & ~s70;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s68	<= 1'b0;
	end
	else begin
		s68	<= s69 | (s68 & ~s70);
	end
end

assign addr_cross_1k = s48;

assign s52 = (&dma_mst_addr[9:6]) & (|dma_mst_addr[5:0]);

assign s53 = s52;

assign s49	= s53;
assign s50	= dma_mst_direction_change | mst_dma_1st_ap;
assign s48	= s49 | (s51 & ~s50);

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s51 <= 1'b0;
	end
	else begin
		s51 <= s49 | (s51 & ~s50);
	end
end

assign s88 =  |s59 & |s57;
assign s89 = ~|ch_tts & |ch_llp;

assign s45 = (s0 & (((s57 == 8'b1) | (s59 == 22'b1)) | (s63 == (FIFO_CAPACITY - {{(FIFO_COUNTER_WIDTH-3){1'b0}}, s61}))));
assign s46 = (s8 & (s71 == 3'b100));
assign s47 = s2 & (s63 == {{(FIFO_COUNTER_WIDTH-3){1'b0}}, s62});


assign s84	= (s0 | s1);

assign s86	 = (s3 & s88) | (arb_end_1st_cycle & ~s16);
assign s85	 = s3 & s89;
assign s87 = s1;

assign dma_mst_direction_change = s1 || s3;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s91	<= 1'b0;
	end
	else if (arb_end_1st_cycle) begin
		s91	<= ~s16;
	end
	else if (s54) begin
		s91	<= 1'b0;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		dma_ch_src_ack	<= 1'b0;
		s10 <= 1'b0;
	end
	else if (arb_end || idle_state) begin
		dma_ch_src_ack	<= 1'b0;
		s10 <= ~ch_src_mode;
	end
	else if (s1 && !s88 && mst_dma_ack && ch_src_mode) begin
		dma_ch_src_ack	<= ch_src_request;
	end
	else if ((!ch_src_request) && (!s10)) begin
		dma_ch_src_ack	<= 1'b0;
		s10 <= 1'b1;
	end
end

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		dma_ch_dst_ack	<= 1'b0;
		s11 <= 1'b0;
	end
	else if (arb_end || idle_state) begin
		dma_ch_dst_ack	<= 1'b0;
		s11 <= ~ch_dst_mode;
	end
	else if (s3 && !s88 && mst_dma_ack && ch_dst_mode) begin
		dma_ch_dst_ack	<= ch_dst_request;
	end
	else if ((!ch_dst_request) && (!s11)) begin
		dma_ch_dst_ack	<= 1'b0;
		s11 <= 1'b1;
	end
end

assign	s12 = s10 & s11;

always @* begin
	case(s5)
		ST_READ: begin
			s6 = s54 ? ST_END :
					s45 && mst_dma_grant ? ST_READ_END : ST_READ;
		end
		ST_READ_END: begin
			s6 = s54 ? ST_END :
					mst_dma_retry_2nd_cycle ? ST_READ :
					!mst_dma_ack ? ST_READ_END : ST_WRITE;
		end
		ST_WRITE: begin
			s6 = s54 	? ST_END :
					s47 && mst_dma_grant ? ST_WRITE_END : ST_WRITE;
		end
		ST_WRITE_END: begin
			s6 =	s54 ? ST_END :
					mst_dma_retry_2nd_cycle ? ST_WRITE :
				 	!mst_dma_ack ? ST_WRITE_END :
					s88 ? ST_READ :
					s89 ? ST_LLP : ST_END;
		end
		ST_LLP: begin
			s6 = s54 ? ST_END  :
					s46 && mst_dma_grant ? ST_LLP_END : ST_LLP;
		end
		ST_LLP_END: begin
			s6 = s54 ? ST_END  :
					mst_dma_retry_2nd_cycle ? ST_LLP :
					!mst_dma_ack ? ST_LLP_END : ST_IDLE;
		end
		ST_END: begin
			s6 = (s91 && !s12) ? ST_END : ST_IDLE;
		end
		default: begin
			s6 =  arb_end_1st_cycle ? (s16 ? ST_END : ST_READ) : ST_IDLE;
		end

	endcase
end

endmodule
