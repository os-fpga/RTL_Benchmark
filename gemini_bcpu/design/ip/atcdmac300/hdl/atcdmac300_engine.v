// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_engine (
                           `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  dma_mst1_req,
                           	  dma_mst1_addr,
                           	  dma_mst1_write,
                           	  dma_mst1_size,
                           	  dma_mst1_fix,
                           	  dma_mst1_wdata,
                           	  dma_mst1_len,
                           	  mst1_dma_grant,
                           	  mst1_dma_rd_ack,
                           	  mst1_dma_wr_ack,
                           	  mst1_dma_rdata,
                           	  mst1_dma_rlast,
                           	  mst1_dma_bvalid,
                           	  mst1_dma_error,
                           `endif
                           	  dma_mst0_req,
                           	  dma_mst_wr_mask,
                           	  dma_mst0_addr,
                           	  dma_mst0_write,
                           	  dma_mst0_size,
                           	  dma_mst0_fix,
                           	  dma_mst0_wdata,
                           	  dma_mst0_len,
                           	  mst0_dma_grant,
                           	  mst0_dma_rd_ack,
                           	  mst0_dma_wr_ack,
                           	  mst0_dma_rdata,
                           	  mst0_dma_rlast,
                           	  mst0_dma_bvalid,
                           	  mst0_dma_error,
                           	  idle_state,
                           	  arb_end,
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
                           `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  ch_src_bus_inf_idx,
                           	  ch_dst_bus_inf_idx,
                           `endif
                           `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                           	  ch_llp,
                              `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  ch_lld_bus_inf_idx,
                              `endif
                           `endif
                           	  ch_abt,
                           	  dma_ch_src_ack,
                           	  dma_ch_dst_ack,
                           	  dma_ch_ctl_wen,
                           	  dma_ch_en_wen,
                           	  dma_ch_src_addr_wen,
                           	  dma_ch_dst_addr_wen,
                           `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                           	  dma_ch_llp_wen,
                           `endif
                           	  dma_ch_tts_wen,
                           	  dma_ch_tc_wen,
                           	  dma_ch_err_wen,
                           	  dma_ch_int_wen,
                           	  dma_ch_ctl_wdata,
                           	  dma_ch_ctl_wdata_pri,
                           `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  dma_ch_ctl_wdata_idx,
                           `endif
                           	  dma_ch_tts_wdata,
                           	  dma_ch_src_addr_wdata,
                           	  dma_ch_dst_addr_wdata,
                           `ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
                           	  dma_ch_llp_wdata,
                              `ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
                           	  dma_ch_llp_wdata_idx,
                              `endif
                           `endif
                           	  aclk,
                           	  aresetn,
                           	  dma_soft_reset
);
localparam	ADDR_MSB	= `ATCDMAC300_ADDR_WIDTH - 1;
localparam	TTS_MSB		= `ATCDMAC300_TTS_WIDTH - 1;
localparam	ADDR_WEN_MSB	= ADDR_MSB > 31 ? 1 : 0;

localparam	ST_IDLE		= 3'b000;
localparam	ST_READ		= 3'b001;
localparam	ST_READ_ACK	= 3'b010;
localparam	ST_WRITE	= 3'b011;
localparam	ST_WRITE_ACK	= 3'b100;
localparam	ST_LL		= 3'b101;
localparam	ST_END		= 3'b110;

`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma_mst1_req;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma_mst1_addr;
output					dma_mst1_write;
output	[2:0]				dma_mst1_size;
output					dma_mst1_fix;
output	[(`DMA_DATA_WIDTH-1):0]		dma_mst1_wdata;
output	[7:0]				dma_mst1_len;
input					mst1_dma_grant;
input					mst1_dma_rd_ack;
input					mst1_dma_wr_ack;
input	[(`DMA_DATA_WIDTH-1):0]		mst1_dma_rdata;
input                                   mst1_dma_rlast;
input                                   mst1_dma_bvalid;
input					mst1_dma_error;
`endif

output					dma_mst0_req;
output					dma_mst_wr_mask;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma_mst0_addr;
output					dma_mst0_write;
output	[2:0]				dma_mst0_size;
output					dma_mst0_fix;
output	[(`DMA_DATA_WIDTH-1):0]		dma_mst0_wdata;
output	[7:0]				dma_mst0_len;
input					mst0_dma_grant;
input					mst0_dma_rd_ack;
input					mst0_dma_wr_ack;
input	[(`DMA_DATA_WIDTH-1):0]		mst0_dma_rdata;
input                                   mst0_dma_rlast;
input                                   mst0_dma_bvalid;
input					mst0_dma_error;

output					idle_state;
input 					arb_end;
input	[1:0]				ch_src_addr_ctl;
input	[1:0]				ch_dst_addr_ctl;
input	[2:0]				ch_src_width;
input	[2:0]				ch_dst_width;
input	[3:0]				ch_src_burst_size;
input					ch_src_mode;
input					ch_src_request;
input					ch_dst_mode;
input					ch_dst_request;
input	[(`ATCDMAC300_TTS_WIDTH-1):0]	ch_tts;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_src_addr;
input	[(`ATCDMAC300_ADDR_WIDTH-1):0]	ch_dst_addr;
input					ch_int_tc_mask;
input					ch_int_err_mask;
input					ch_int_abt_mask;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_src_bus_inf_idx;
input					ch_dst_bus_inf_idx;
`endif

`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
input	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_llp;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
input					ch_lld_bus_inf_idx;
	`endif
`else
wire	[(`ATCDMAC300_ADDR_WIDTH-1):3]	ch_llp = {`ATCDMAC300_ADDR_WIDTH-3{1'b0}};
wire					ch_lld_bus_inf_idx = 1'b0;
`endif
input					ch_abt;
output					dma_ch_src_ack;
output					dma_ch_dst_ack;
output					dma_ch_ctl_wen;
output					dma_ch_en_wen;
output	[ADDR_WEN_MSB:0]		dma_ch_src_addr_wen;
output	[ADDR_WEN_MSB:0]		dma_ch_dst_addr_wen;
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[ADDR_WEN_MSB:0]		dma_ch_llp_wen;
`endif
output					dma_ch_tts_wen;
output					dma_ch_tc_wen;
output					dma_ch_err_wen;
output					dma_ch_int_wen;
output	[27:1]				dma_ch_ctl_wdata;
output					dma_ch_ctl_wdata_pri;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output	[1:0]				dma_ch_ctl_wdata_idx;
`endif
output	[(`ATCDMAC300_TTS_WIDTH-1):0]	dma_ch_tts_wdata;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma_ch_src_addr_wdata;
output	[(`ATCDMAC300_ADDR_WIDTH-1):0]	dma_ch_dst_addr_wdata;
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
output	[(`ATCDMAC300_ADDR_WIDTH-1):3]	dma_ch_llp_wdata;
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
output					dma_ch_llp_wdata_idx;
	`endif
`endif

input					aclk;
input					aresetn;
input					dma_soft_reset;

reg	[(`ATCDMAC300_BYTE_OFFSET_WIDTH-1):0]	dma_fifo_byte_offset;
wire					dma_fifo_flush;
wire					dma_fifo_last_wr;
wire					dma_fifo_rd;
wire	[2:0]				dma_fifo_size;
wire	[(`DMA_DATA_WIDTH-1):0]		dma_fifo_wdata;
wire					dma_fifo_wr;
wire					dma_fifo_src_addr_dec;
wire					dma_fifo_dst_addr_dec;
wire	[(`DMA_DATA_WIDTH-1):0]		dma_fifo_rdata;

wire					idle_state;
wire					s0;
wire					s1;
wire					s2;
wire					s3;
wire					s4;
wire					s5;
reg	[2:0]				s6;
reg	[2:0]				s7;
reg					s8;
reg					s9;
wire					s10;
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef ATCDMAC300_DATA_WIDTH_128
reg					s11;
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_256
reg	[1:0]				s12;
	`endif

reg					s13;
reg					s14;
wire					s15;
wire					s16;
`else
wire					s11 	 = 1'b0;
wire	[1:0]				s12 	 = 2'b0;
wire					s13 	 = 1'b0;
wire					s14 = 1'b0;
wire					s15 	 = 1'b0;
wire					s16 	 = 1'b0;
`endif

reg					s17;
reg					s18;
reg					s19;
wire					s20;
reg					s21;
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
wire					s40;
wire					s41;
wire					s42;
wire					s43;
wire					s44;
wire					s45;
wire					s46;
wire					s47;
wire					s48;
wire					s49;
`ifdef 	ATCDMAC300_DATA_WIDTH_GE_64
wire					s50;
`else
wire					s50 = 1'b0;
`endif
`ifdef 	ATCDMAC300_DATA_WIDTH_GE_128
wire					s51;
`else
wire					s51 = 1'b0;
`endif
`ifdef 	ATCDMAC300_DATA_WIDTH_GE_256
wire					s52;
`else
wire					s52 = 1'b0;
`endif

wire	[10:0]				s53;
reg					s54;
wire					s55;
wire					s56;
wire					s57;
reg					s58;
reg	[10:0]				s59;

`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
reg	[2:0]				s60;
wire	[2:0]				s61;
`else
wire	[2:0]				s60 = 3'd0;
`endif

wire	[ADDR_MSB:0]			s62;
wire	[ADDR_MSB:0]			s63;
wire	[ADDR_MSB:0]			s64;
wire	[ADDR_MSB:0]			s65;
wire	[31:0]				s66;
wire					s67;
wire					s68;
wire	[10:0]				s69;
reg	[8:0]				s70;
wire	[8:0]				s71;
wire	[8:0]				s72;

wire					s73;
reg	[ADDR_MSB:0]			s74;
wire	[ADDR_MSB:0]			s75;
wire					s76;
reg	[2:0]				s77;
wire	[2:0]				s78;
reg					s79;
wire					s80;
wire	[(`DMA_DATA_WIDTH-1):0]		s81;
wire	[7:0]				s82;
wire					s83;
reg					s84;
wire					s85;
wire					s86;
wire	[(`DMA_DATA_WIDTH-1):0]		s87;
wire					s88;
wire					s89;
wire					s90;

reg	[10:0]				s91;
reg	[10:0]				s92;
wire	[10:0]				s93;
wire	[10:0]				s94;
wire	[10:0]				s95;
wire	[10:0]				s96;
wire	[12:0]				s97;
wire	[11:0]				s98;
wire	[10:0]				s99;
wire	[ 2:0]				s100;
reg					s101;
reg					s102;
wire					s103;

assign	idle_state 		= (s6 == ST_IDLE);
assign	s0 		= (s6 == ST_READ);
assign	s1 		= (s6 == ST_WRITE);
assign	s2 		= (s6 == ST_END);
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign	s16 		= (s6 == ST_LL);
`endif

assign	dma_ch_src_ack		= (s6 == ST_READ_ACK)  && ch_src_request;
assign	dma_ch_dst_ack		= (s6 == ST_WRITE_ACK) && ch_dst_request;

assign	s73		= (s1 && s9) ||
				  ( s0 &&  s8) ||
				  (   s16 &&    s13);
assign  dma_mst_wr_mask 	=  s101 || s102;
assign	s76		=  s1;
assign	s81		=  dma_fifo_rdata;
assign	s75		=  s16 ? {ch_llp[(`ATCDMAC300_ADDR_WIDTH-1):3],3'b0} :
						       s1 ? ch_dst_addr          : ch_src_addr;
assign	s78		=  s16 ?   3'h2 : s1 ? ch_dst_width         : ch_src_width;
assign	s80		=  s16 ?   1'b0 : s1 ? s35         : s34;
assign  s82     	=  s16 ?   8'h7 : s72[7:0];
assign  s72		=  s70  - 9'h1;
assign	s57		=  s90;
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
reg	s104;
wire	s105;
assign	s105		=    s16 ? ((s60 == 3'h0) ? ch_lld_bus_inf_idx : s14) :
				   s0 ?                          ch_src_bus_inf_idx : ch_dst_bus_inf_idx;
assign	dma_mst1_addr		=  s74;
assign	dma_mst1_write		=  s76;
assign	dma_mst1_size		=  s77;
assign	dma_mst1_fix		=  s79;
assign	dma_mst1_wdata		=  s81;
assign	dma_mst1_len		=  s82;
assign	dma_mst0_addr		=  s74;
assign	dma_mst0_write		=  s76;
assign	dma_mst0_size		=  s77;
assign	dma_mst0_fix		=  s79;
assign	dma_mst0_wdata		=  s81;
assign	dma_mst0_len		=  s82;
assign	dma_mst1_req		=  s104 && s73;
assign	dma_mst0_req		= !s104 && s73;
assign	s83		=  s104 ? mst1_dma_grant  : mst0_dma_grant;
assign	s85		=  s104 ? mst1_dma_rd_ack : mst0_dma_rd_ack;
assign	s86		=  s104 ? mst1_dma_wr_ack : mst0_dma_wr_ack;
assign	s87		=  s104 ? mst1_dma_rdata  : mst0_dma_rdata;
assign	s90		=  s104 ? mst1_dma_error  : mst0_dma_error;
assign	s88		=  s104 ? mst1_dma_rlast  : mst0_dma_rlast;
assign	s89		=  s104 ? mst1_dma_bvalid : mst0_dma_bvalid;

always @(posedge aclk or negedge aresetn)
	if (!aresetn)
		s104	<= 1'b0;
	else
		s104	<= s105;

`else

assign	dma_mst0_addr		=  s74;
assign	dma_mst0_write		=  s76;
assign	dma_mst0_size		=  s77;
assign	dma_mst0_fix		=  s79;
assign	dma_mst0_wdata		=  s81;
assign	dma_mst0_len		=  s82;

assign	dma_mst0_req		=  s73;
assign	s83		=  mst0_dma_grant;
assign	s85		=  mst0_dma_rd_ack;
assign	s86		=  mst0_dma_wr_ack;
assign 	s87		=  mst0_dma_rdata;
assign	s90		=  mst0_dma_error;
assign	s88		=  mst0_dma_rlast;
assign	s89		=  mst0_dma_bvalid;
`endif

assign	dma_fifo_flush 	     	=  s58;
assign	dma_fifo_rd		=  s1  && s86;
assign	dma_fifo_wr		=  s0   && s85;
assign 	dma_fifo_last_wr 	=  s54 && s88;
assign	dma_fifo_size		=  s0 ? ch_src_width : ch_dst_width;
assign	dma_fifo_wdata		=  s87;
assign 	dma_fifo_src_addr_dec 	=  s32;
assign 	dma_fifo_dst_addr_dec 	=  s33;

assign	s66	=
`ifdef ATCDMAC300_DATA_WIDTH_64
				              s60[0] 		   ?	s87[63:32] :
`endif
`ifdef ATCDMAC300_DATA_WIDTH_128
				   ({s11,s60[1:0]} == 3'b001) ?	s87[ 63:32] :
				   ({s11,s60[1:0]} == 3'b010) ?	s87[ 95:64] :
				   ({s11,s60[1:0]} == 3'b011) ?	s87[127:96] :
				   ({s11,s60[1:0]} == 3'b100) ?	s87[ 95:64] :
				   ({s11,s60[1:0]} == 3'b101) ?	s87[127:96] :
				   ({s11,s60[1:0]} == 3'b110) ?	s87[ 31: 0] :
				   ({s11,s60[1:0]} == 3'b111) ?	s87[ 63:32] :
`endif
`ifdef ATCDMAC300_DATA_WIDTH_256

				   ({s12,s60[2:0]} == 5'b00001) ?	s87[ 63: 32] :
				   ({s12,s60[2:0]} == 5'b00010) ?	s87[ 95: 64] :
				   ({s12,s60[2:0]} == 5'b00011) ?	s87[127: 96] :
				   ({s12,s60[2:0]} == 5'b00100) ?	s87[159:128] :
				   ({s12,s60[2:0]} == 5'b00101) ?	s87[191:160] :
				   ({s12,s60[2:0]} == 5'b00110) ?	s87[223:192] :
				   ({s12,s60[2:0]} == 5'b00111) ?	s87[255:224] :
				   ({s12,s60[2:0]} == 5'b01000) ?	s87[ 95: 64] :
				   ({s12,s60[2:0]} == 5'b01001) ?	s87[127: 96] :
				   ({s12,s60[2:0]} == 5'b01010) ?	s87[159:128] :
				   ({s12,s60[2:0]} == 5'b01011) ?	s87[191:160] :
				   ({s12,s60[2:0]} == 5'b01100) ?	s87[223:192] :
				   ({s12,s60[2:0]} == 5'b01101) ?	s87[255:224] :
				   ({s12,s60[2:0]} == 5'b01110) ?	s87[ 31:  0] :
				   ({s12,s60[2:0]} == 5'b01111) ?	s87[ 63: 32] :
				   ({s12,s60[2:0]} == 5'b10000) ?	s87[159:128] :
				   ({s12,s60[2:0]} == 5'b10001) ?	s87[191:160] :
				   ({s12,s60[2:0]} == 5'b10010) ?	s87[223:192] :
				   ({s12,s60[2:0]} == 5'b10011) ?	s87[255:224] :
				   ({s12,s60[2:0]} == 5'b10100) ?	s87[ 31:  0] :
				   ({s12,s60[2:0]} == 5'b10101) ?	s87[ 63: 32] :
				   ({s12,s60[2:0]} == 5'b10110) ?	s87[ 95: 64] :
				   ({s12,s60[2:0]} == 5'b10111) ?	s87[127: 96] :
				   ({s12,s60[2:0]} == 5'b11000) ?	s87[223:192] :
				   ({s12,s60[2:0]} == 5'b11001) ?	s87[255:224] :
				   ({s12,s60[2:0]} == 5'b11010) ?	s87[ 31:  0] :
				   ({s12,s60[2:0]} == 5'b11011) ?	s87[ 63: 32] :
				   ({s12,s60[2:0]} == 5'b11100) ?	s87[ 95: 64] :
				   ({s12,s60[2:0]} == 5'b11101) ?	s87[127: 96] :
				   ({s12,s60[2:0]} == 5'b11110) ?	s87[159:128] :
				   ({s12,s60[2:0]} == 5'b11111) ?	s87[191:160] :
`endif
				   							s87[ 31:  0];

generate
	if (ADDR_WEN_MSB == 1) begin : address_gt_32_wen
assign 	dma_ch_src_addr_wen[1]	= (s16 && (s60 == 3'b011) && s85) || (s0  && s84);
assign 	dma_ch_dst_addr_wen[1]	= (s16 && (s60 == 3'b101) && s85) || (s1 && s84);
	`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign 	dma_ch_llp_wen[1]	= (s16 && (s60 == 3'b111) && s85);
	`endif
end
endgenerate

assign	dma_ch_en_wen		= s2 && ((!(|ch_tts)) || ch_abt || s21 || s58 || s15);
assign	dma_ch_ctl_wen		= (s16 && (s60 == 3'b000) && s85);
assign	dma_ch_tts_wen		= (s16 && (s60 == 3'b001) && s85) || (s0  && s84);
assign 	dma_ch_src_addr_wen[0]	= (s16 && (s60 == 3'b010) && s85) || (s0  && s84);
assign 	dma_ch_dst_addr_wen[0] 	= (s16 && (s60 == 3'b100) && s85) || (s1 && s84);
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign 	dma_ch_llp_wen[0]	= (s16 && (s60 == 3'b110) && s85);
`endif
assign	dma_ch_tc_wen		= s2 && ((!(|ch_tts)) || s15) && (!s58) && (!s21);
assign 	dma_ch_err_wen		= s2 && (s58 ||   s21);
assign 	dma_ch_int_wen		= (dma_ch_tc_wen       && (!s17))  ||
				  (dma_ch_err_wen      && (!s18)) ||
				  (ch_abt && s2 && (!s19));
assign	dma_ch_ctl_wdata	=  s66[27:1];
assign	dma_ch_ctl_wdata_pri	=  s66[29];
`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
assign	dma_ch_ctl_wdata_idx	=  s66[31:30];
`endif
assign	dma_ch_src_addr_wdata 	=  s64;
assign	dma_ch_dst_addr_wdata 	=  s64;
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
assign	dma_ch_llp_wdata_idx	=  s66[0];
	`endif
generate
	if (ADDR_MSB < 32) begin : address_width_less_than_32
assign	dma_ch_llp_wdata[ADDR_MSB:3]	=  s66[ADDR_MSB:3];
	end
	else begin : address_width_not_less_than_32
assign	dma_ch_llp_wdata[ADDR_MSB:32]	=  s66[ADDR_MSB-32:0];
assign	dma_ch_llp_wdata[      31:3]	=  s66[         31:3];
	end
endgenerate
`endif
assign	s67		= ((s0 && s32) || (s1 && s33));
assign	s68		= ((s0 && s34) || (s1 && s35));
assign	s63		= {{ADDR_MSB{1'b0}},1'b1} << s77;
assign	s62		= s68 ? {`ATCDMAC300_ADDR_WIDTH{1'b0}} : {{ADDR_MSB-10{1'b0}},s69};
assign	dma_ch_tts_wdata	= s16 ? s66[TTS_MSB:0] : (ch_tts - {{(`ATCDMAC300_TTS_WIDTH-9){1'b0}},s70});
assign	s65		= s67 ? (s74 - s63) :  (s74 + s62);

generate
   if (ADDR_MSB > 31) begin : addr_width_gt_32
assign	s64 	= s16 ? (((s60 == 3'h2) || (s60 == 3'h4)) ? {{ADDR_MSB-31{1'b0}},s66[31:0]}
                                                                                               : {s66[ADDR_MSB-32:0],{32'b0}}
				             ) : s65;
   end
   else begin : addr_width_not_gt_32
assign	s64 	= s16 ? s66[ADDR_MSB:0] : s65;
   end
endgenerate
assign	s30		= (ch_src_addr_ctl == 2'b00);
assign	s32		= (ch_src_addr_ctl == 2'b01);
assign	s34		= (ch_src_addr_ctl == 2'b10);
assign	s31		= (ch_dst_addr_ctl == 2'b00);
assign	s33		= (ch_dst_addr_ctl == 2'b01);
assign	s35		= (ch_dst_addr_ctl == 2'b10);

assign	s36		= (ch_src_width == 3'b000);
assign	s37		= (ch_src_width == 3'b001);
assign	s38		= (ch_src_width == 3'b010);
assign	s39	= (ch_src_width == 3'b011);
assign	s40	= (ch_src_width == 3'b100);
assign	s41	= (ch_src_width == 3'b101);
assign	s42		= (ch_dst_width == 3'b000);
assign	s43		= (ch_dst_width == 3'b001);
assign	s44		= (ch_dst_width == 3'b010);
assign	s45	= (ch_dst_width == 3'b011);
assign	s46	= (ch_dst_width == 3'b100);
assign	s47	= (ch_dst_width == 3'b101);

assign	s23		=  (s37	  &&   ch_src_addr[  0])
				|| (s43	  &&   ch_dst_addr[  0])
				|| (s38	  && (|ch_src_addr[1:0]))
				|| (s44	  && (|ch_dst_addr[1:0]))
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				|| (s39 && (|ch_src_addr[2:0]))
				|| (s45 && (|ch_dst_addr[2:0]))
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (s40	  && (|ch_src_addr[3:0]))
				|| (s46	  && (|ch_dst_addr[3:0]))
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s41  && (|ch_src_addr[4:0]))
				|| (s47  && (|ch_dst_addr[4:0]))
`endif
`endif
`endif
				;

assign 	s48	=   s36        &&  (ch_tts[  0]           || (ch_src_burst_size == 4'h0));
assign 	s49	=  (s36        && ((ch_tts[1:0] == 2'h2 ) || (ch_src_burst_size == 4'h1)))
				|| (s37       &&  (ch_tts[  0]           || (ch_src_burst_size == 4'h0)));
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
assign	s50	=  (s36        && ((ch_tts[2:0] == 3'h4 ) || (ch_src_burst_size == 4'h2)))
				|| (s37       && ((ch_tts[1:0] == 2'h2 ) || (ch_src_burst_size == 4'h1)))
				|| (s38        &&  (ch_tts[  0]           || (ch_src_burst_size == 4'h0)));
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
assign	s51 =
				   (s36        && ((ch_tts[3:0] == 4'h8 ) || (ch_src_burst_size == 4'h3)))
				|| (s37       && ((ch_tts[2:0] == 3'h4 ) || (ch_src_burst_size == 4'h2)))
				|| (s38        && ((ch_tts[1:0] == 2'h2 ) || (ch_src_burst_size == 4'h1)))
				|| (s39 &&  (ch_tts[  0]           || (ch_src_burst_size == 4'h0)));
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
assign	s52 =
				   (s36        && ((ch_tts[4:0] == 5'h10) || (ch_src_burst_size == 4'h4)))
				|| (s37       && ((ch_tts[3:0] == 4'h8 ) || (ch_src_burst_size == 4'h3)))
				|| (s38        && ((ch_tts[2:0] == 3'h4 ) || (ch_src_burst_size == 4'h2)))
				|| (s39 && ((ch_tts[1:0] == 2'h2 ) || (ch_src_burst_size == 4'h1)))
				|| (s40   &&  (ch_tts[  0]           || (ch_src_burst_size == 4'h0)));
`endif
`endif
`endif

assign	s22		=  (s43       &&          s48)
				|| (s44        && (        s48
                                                            ||       s49))
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				|| (s45 && (        s48
                                                            ||       s49
                                                            ||        s50))
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (s46   && (        s48
                                                            ||       s49
                                                            ||        s50
                                                            || s51))
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s47  && (        s48
                                                            ||       s49
                                                            ||        s50
                                                            || s51
                                                            ||   s52))
`endif
`endif
`endif
				;

assign	s24 	= (ch_src_width == 3'h7) || (ch_src_width == 3'h6)
`ifdef ATCDMAC300_DATA_WIDTH_32
				|| s41  || s40 || s39
`endif
`ifdef ATCDMAC300_DATA_WIDTH_64
				|| s41  || s40
`endif
`ifdef ATCDMAC300_DATA_WIDTH_128
				|| s41
`endif
			 	;
assign	s25 	= (ch_dst_width    == 3'h7) || (ch_dst_width == 3'h6)
`ifdef ATCDMAC300_DATA_WIDTH_32
				|| s47 || s46 || s45
`endif
`ifdef ATCDMAC300_DATA_WIDTH_64
				|| s47 || s46
`endif
`ifdef ATCDMAC300_DATA_WIDTH_128
				|| s47
`endif
				;
assign	s26 	= (ch_src_addr_ctl == 2'b11);
assign	s27 	= (ch_dst_addr_ctl == 2'b11);
assign	s28	= (ch_src_burst_size == 4'hb) || (ch_src_burst_size == 4'hc) || (ch_src_burst_size == 4'hd) ||
				  (ch_src_burst_size == 4'he) || (ch_src_burst_size == 4'hf);
assign 	s29		= s24 || s25 || s26 || s27 ||
				  s28;
assign 	s20		= s0 && (!s8) && ((!(|ch_tts)) || s23 || s22 || s29);

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s21 <= 1'b0;
	else
		s21 <= s20;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		dma_fifo_byte_offset	<= {`ATCDMAC300_BYTE_OFFSET_WIDTH{1'b0}};
	else if (s73 && s83)
		dma_fifo_byte_offset	<= s74[`ATCDMAC300_BYTE_OFFSET_WIDTH-1:0];
	else if ((s86 && s1 && s31) || (s85 && s0 && s30))
		dma_fifo_byte_offset	<= dma_fifo_byte_offset + ({{`ATCDMAC300_BYTE_OFFSET_WIDTH-1{1'b0}},1'h1} << s77);
end

assign	s100			  = s0 ? ch_src_width      : ch_dst_width;
assign	s98			  = s0 ? ch_src_addr[11:0] : ch_dst_addr[11:0];
assign	s99		  = s0 ? s91 : s92;
assign	s97		  = 13'h1000 - {1'b0,s98};
assign	s95 = ((s97 > {2'b0, s99}) ? s99 : s97[10:0]) >> s100;
assign	s94	  = ((|ch_tts[31:11]) || (ch_tts[10:0] > s59)) ? s59 : ch_tts[10:0];
assign	s96	  = ( s1     || (s94 > s95)) ? s95 :
                                                                                                                 s94;
assign	s71		  = ((s0 && s32) || (s1 && s33)) ? 9'h1   :
                                    (((s0 && s34) || (s1 && s35)) && (|s96[10:4])) ? 9'h10 :
                                    (|s96[10:8])                                       ? 9'd256 :   s96[8:0];
assign	s69		  = {2'h0,s70[8:0]} << (s0 ? ch_src_width : ch_dst_width);
assign	s103	  = ((s1 && s83) || s102) && (!s89);
assign	s53	  = 11'b1 << ch_src_burst_size;
assign	s10	  = idle_state && arb_end;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s59 <= 11'b0;
	else if (s10)
		s59 <= s53;
	else if (s0 && s83)
		s59 <= s59 - {2'b0,s70};
end

wire	s106	= (idle_state && arb_end) || (s1 && s4);
assign	s93	=  s91 - s69;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s91 <= 11'b0;
	else if (s106)
		s91 <= `ATCDMAC300_FIFO_BYTE;
	else if (s0 && s83)
		s91 <= s93;
end

wire	s107 = (idle_state && arb_end) || (s1 && s4);
always @(posedge aclk or negedge aresetn)
	if (!aresetn)
		s92 <= 11'b0;
	else if (dma_soft_reset || s57)
		s92 <= 11'b0;
	else if (s0 && s83)
		s92 <= s92 + s69;
	else if (s1 && s83)
		s92 <= s92 - s69;

`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
assign	s61 = s60 + 3'b1;
assign	s15	= s13 && (!s17);

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s60	<= 3'b0;
	else if (dma_soft_reset || s57)
		s60	<= 3'b0;
	else if (s16 && s85)
		s60	<= s61;
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s13	<= 1'b0;
	else if (dma_soft_reset)
		s13	<= 1'b0;
	else
		s13	<= s16;
end
`endif

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		s17 	<= 1'b0;
		s18 	<= 1'b0;
		s19 	<= 1'b0;
	end
	else if (idle_state && arb_end) begin
		s17	<= ch_int_tc_mask;
		s18	<= ch_int_err_mask;
		s19	<= ch_int_abt_mask;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		s6 	<= ST_IDLE;
		s8	<= 1'b0;
		s9	<= 1'b0;
		s58		<= 1'b0;
	end
	else if (dma_soft_reset) begin
		s6 	<= ST_IDLE;
		s8	<= 1'b0;
		s9	<= 1'b0;
		s58		<= 1'b0;
	end
	else begin
		s6 	<= s7;
		s8	<= s0;
		s9	<= s1;
		s58		<= s57;
	end
end
`ifdef ATCDMAC300_CHAIN_TRANSFER_SUPPORT
	`ifdef ATCDMAC300_DUAL_MASTER_IF_SUPPORT
always @(posedge aclk or negedge aresetn)
	if (!aresetn)
		s14	<= 1'b0;
	else if (s16 && s83)
		s14	<= ch_lld_bus_inf_idx;
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_128
always @(posedge aclk or negedge aresetn)
	if (!aresetn)
		s11		<= 1'b0;
	else if (s16 && s83)
		s11		<= ch_llp[3];
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_256
always @(posedge aclk or negedge aresetn)
	if (!aresetn)
		s12		<= 2'b0;
	else if (s16 && s83)
		s12		<= ch_llp[4:3];
	`endif
`endif

assign s56 = s88 || s90;
assign s55 = s83 &&
		         (s0    && (
					    (s59 	  == {                           2'b0,s70})
					||  (s93 == {                          11'b0             })
					||  (ch_tts 		  == {{`ATCDMAC300_TTS_WIDTH-9{1'b0}},s70})
					   ));

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		s54 		<= 1'b0;
		s102		<= 1'b0;
		s70		<= 9'b0;
		s74		<= {`ATCDMAC300_ADDR_WIDTH{1'b0}};
		s77		<= 3'b0;
		s79		<= 1'b0;
		s101	<= 1'b0;
		s84	<= 1'b0;
	end
	else begin
		s54		<= s55 || (s54 && (!s56));
		s102		<= s103;
		s70		<= s71;
		s74		<= s75;
		s77		<= s78;
		s79		<= s80;
		s101	<= (s92 == 11'h0);
		s84	<= s83;
	end
end
assign s3		=  s54 && s88;
assign s4	=  s101 && s89;
assign s5 	= (s60 == 3'b111) && s85;

always @(*) begin
	case(s6)
		ST_READ: begin
			s7 = (s20 || s57) 	? ST_END	:
					(!s3) 				? ST_READ	:
					( ch_src_mode && ((!(|s59)) || (!(|ch_tts))))	? ST_READ_ACK	: ST_WRITE;
		end
		ST_READ_ACK: begin
			s7 = ch_src_request 				? ST_READ_ACK	: ST_WRITE;
		end
		ST_WRITE: begin
			s7 = s57 				? ST_END	:
					(!s4)   				? ST_WRITE	:
					((|s59) && (|ch_tts))		? ST_READ	:
					( ch_dst_mode && ((!(|s59)) || (!(|ch_tts))))	? ST_WRITE_ACK	:
					((!(|ch_tts)) && (|ch_llp[(`ATCDMAC300_ADDR_WIDTH-1):3]))
										? ST_LL 	: ST_END;
		end
		ST_WRITE_ACK: begin
			s7 = ch_dst_request 				? ST_WRITE_ACK	:
					((!(|ch_tts)) && (|ch_llp[(`ATCDMAC300_ADDR_WIDTH-1):3]))
										? ST_LL		: ST_END;
		end
		ST_LL: begin
			s7 = (!s5)				? ST_LL		:
					(s57 || ch_abt)		? ST_END	: ST_IDLE;
		end
		ST_END: begin
			s7 = ST_IDLE;
		end
		default: begin
			s7 = arb_end 				? ST_READ	: ST_IDLE;
		end

	endcase
end

atcdmac300_fifo atcdmac300_fifo (
	.aclk                  (aclk			),
	.aresetn               (aresetn			),
	.dma_soft_reset        (dma_soft_reset		),
	.dma_fifo_wr           (dma_fifo_wr		),
	.dma_fifo_last_wr      (dma_fifo_last_wr	),
	.dma_fifo_wdata        (dma_fifo_wdata		),
	.dma_fifo_size         (dma_fifo_size		),
	.dma_fifo_rd           (dma_fifo_rd		),
	.dma_fifo_byte_offset  (dma_fifo_byte_offset	),
	.dma_fifo_flush        (dma_fifo_flush		),
	.dma_fifo_src_addr_dec (dma_fifo_src_addr_dec	),
	.dma_fifo_dst_addr_dec (dma_fifo_dst_addr_dec	),
	.dma_fifo_rdata        (dma_fifo_rdata		)
);


endmodule
