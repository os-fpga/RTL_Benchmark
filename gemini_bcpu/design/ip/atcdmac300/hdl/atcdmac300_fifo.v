// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_fifo (
                         	  aclk,
                         	  aresetn,
                         	  dma_soft_reset,
                         	  dma_fifo_wr,
                         	  dma_fifo_last_wr,
                         	  dma_fifo_wdata,
                         	  dma_fifo_size,
                         	  dma_fifo_rd,
                         	  dma_fifo_byte_offset,
                         	  dma_fifo_flush,
                         	  dma_fifo_src_addr_dec,
                         	  dma_fifo_dst_addr_dec,
                         	  dma_fifo_rdata
);

localparam	BYTE_OFFSET_WIDTH	= `ATCDMAC300_BYTE_OFFSET_WIDTH;
localparam	DMA_DATA_MSB		= `DMA_DATA_WIDTH - 1;
localparam	BYTE_OFFSET_MSB		=  BYTE_OFFSET_WIDTH - 1;
parameter	SIZE_BYTE		= 3'b000;
parameter	SIZE_HALF_WORD		= 3'b001;
parameter	SIZE_WORD		= 3'b010;
parameter	SIZE_DOUBLE_WORD	= 3'b011;
parameter	SIZE_QUAD_WORD		= 3'b100;
parameter	SIZE_EIGHT_WORD		= 3'b101;

input          					aclk;
input          					aresetn;
input						dma_soft_reset;

input						dma_fifo_wr;
input						dma_fifo_last_wr;
input	[(`DMA_DATA_WIDTH-1):0]			dma_fifo_wdata;
input	[2:0]					dma_fifo_size;
input						dma_fifo_rd;
input	[`ATCDMAC300_BYTE_OFFSET_WIDTH-1:0]	dma_fifo_byte_offset;
input						dma_fifo_flush;
input						dma_fifo_src_addr_dec;
input						dma_fifo_dst_addr_dec;

output	[(`DMA_DATA_WIDTH-1):0]			dma_fifo_rdata;
reg	[(`DMA_DATA_WIDTH-1):0]			dma_fifo_rdata;

wire						s0;
reg	[(`DMA_DATA_WIDTH-1):0]			s1;

wire						s2;
wire						s3;
wire						s4;
wire						s5;
wire						s6;
wire	[(`DMA_DATA_WIDTH-1):0]			s7;
wire	[(`DMA_DATA_WIDTH-1):0]			s8;
reg	[(`DMA_DATA_WIDTH-1):0]			s9;
wire	[(`DMA_DATA_WIDTH-1):0]			s10;

wire						s11;
wire						s12;
wire						s13;
wire						s14;
wire						s15;
wire						s16;
wire						s17;

wire						s18;

wire	[`ATCDMAC300_FIFO_POINTER_WIDTH-1:0]	s19;
wire	[`ATCDMAC300_FIFO_POINTER_WIDTH-1:0]	s20;
wire	[`ATCDMAC300_FIFO_POINTER_WIDTH-1:0]	s21;
wire	[`ATCDMAC300_FIFO_POINTER_WIDTH-1:0]	s22;

wire 	[BYTE_OFFSET_MSB:0]			s23;
wire	[BYTE_OFFSET_MSB:0]			s24;
wire 	[BYTE_OFFSET_MSB:0]			s25;
wire 	[BYTE_OFFSET_MSB:0]			s26;
reg 	[BYTE_OFFSET_MSB:0]			s27;
reg 	[BYTE_OFFSET_MSB:0]			s28;
wire						s29;
wire						s30;
wire 						s31;

reg 	[7:0]					s32;
reg 	[7:0]					s33;
reg 	[7:0]					s34;
wire	[7:0]					s35;
wire	[7:0]					s36;
wire	[7:0]					s37;
wire 						s38;
wire 						s39;
wire 						s40;
wire 	[7:0]					s41;
wire 	[7:0]					s42;
wire 	[7:0]					s43;
wire	[(`DMA_DATA_WIDTH-1):0]			s44;
wire	[(`DMA_DATA_WIDTH-1):0]			s45;
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
reg 	[7:0]					s46;
reg 	[7:0]					s47;
reg 	[7:0]					s48;
reg 	[7:0]					s49;
wire 	[7:0]					s50;
wire 	[7:0]					s51;
wire 	[7:0]					s52;
wire 	[7:0]					s53;
wire 	[7:0]					s54;
wire 	[7:0]					s55;
wire 	[7:0]					s56;
wire 	[7:0]					s57;
wire 						s58;
wire 						s59;
wire 						s60;
wire 						s61;
wire	[(`DMA_DATA_WIDTH-1):0]			s62;
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
reg 	[7:0]					s63;
reg 	[7:0]					s64;
reg 	[7:0]					s65;
reg 	[7:0]					s66;
reg 	[7:0]					s67;
reg 	[7:0]					s68;
reg 	[7:0]					s69;
reg 	[7:0]					s70;
wire 	[7:0]					s71;
wire 	[7:0]					s72;
wire 	[7:0]					s73;
wire 	[7:0]					s74;
wire 	[7:0]					s75;
wire 	[7:0]					s76;
wire 	[7:0]					s77;
wire 	[7:0]					s78;
wire 	[7:0]					s79;
wire 	[7:0]					s80;
wire 	[7:0]					s81;
wire 	[7:0]					s82;
wire 	[7:0]					s83;
wire 	[7:0]					s84;
wire 	[7:0]					s85;
wire 	[7:0]					s86;
wire 						s87;
wire 						s88;
wire 						s89;
wire 						s90;
wire 						s91;
wire 						s92;
wire 						s93;
wire 						s94;
wire	[(`DMA_DATA_WIDTH-1):0]			s95;
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
reg 	[7:0]					s96;
reg 	[7:0]					s97;
reg 	[7:0]					s98;
reg 	[7:0]					s99;
reg 	[7:0]					s100;
reg 	[7:0]					s101;
reg 	[7:0]					s102;
reg 	[7:0]					s103;
reg 	[7:0]					s104;
reg 	[7:0]					s105;
reg 	[7:0]					s106;
reg 	[7:0]					s107;
reg 	[7:0]					s108;
reg 	[7:0]					s109;
reg 	[7:0]					s110;
reg 	[7:0]					s111;
wire 	[7:0]					s112;
wire 	[7:0]					s113;
wire 	[7:0]					s114;
wire 	[7:0]					s115;
wire 	[7:0]					s116;
wire 	[7:0]					s117;
wire 	[7:0]					s118;
wire 	[7:0]					s119;
wire 	[7:0]					s120;
wire 	[7:0]					s121;
wire 	[7:0]					s122;
wire 	[7:0]					s123;
wire 	[7:0]					s124;
wire 	[7:0]					s125;
wire 	[7:0]					s126;
wire 	[7:0]					s127;
wire 	[7:0]					s128;
wire 	[7:0]					s129;
wire 	[7:0]					s130;
wire 	[7:0]					s131;
wire 	[7:0]					s132;
wire 	[7:0]					s133;
wire 	[7:0]					s134;
wire 	[7:0]					s135;
wire 	[7:0]					s136;
wire 	[7:0]					s137;
wire 	[7:0]					s138;
wire 	[7:0]					s139;
wire 	[7:0]					s140;
wire 	[7:0]					s141;
wire 	[7:0]					s142;
wire 	[7:0]					s143;
wire 						s144;
wire 						s145;
wire 						s146;
wire 						s147;
wire 						s148;
wire 						s149;
wire 						s150;
wire 						s151;
wire 						s152;
wire 						s153;
wire 						s154;
wire 						s155;
wire 						s156;
wire 						s157;
wire 						s158;
wire 						s159;
wire	[(`DMA_DATA_WIDTH-1):0]			s160;

`endif
`endif
`endif

assign	s18		=  dma_fifo_flush | dma_soft_reset;
assign	s11		= (dma_fifo_size == SIZE_BYTE);
assign	s12	= (dma_fifo_size == SIZE_HALF_WORD);
assign	s13		= (dma_fifo_size == SIZE_WORD);
assign	s14	= (dma_fifo_size == SIZE_DOUBLE_WORD);
assign	s15	= (dma_fifo_size == SIZE_QUAD_WORD);
assign	s16	= (dma_fifo_size == SIZE_EIGHT_WORD);
assign	s17	=  dma_fifo_src_addr_dec ^ dma_fifo_dst_addr_dec;
assign	s0		=  s18       || (dma_fifo_wr && dma_fifo_last_wr) || (dma_fifo_rd && s31);
assign	s3 		=  dma_fifo_rd      && (s31 || s29);
assign	s2			=  dma_fifo_wr      &&  s30;
assign	s30 	=  dma_fifo_last_wr ||  s29;
assign	s24	= {BYTE_OFFSET_WIDTH{1'b1}} << dma_fifo_size;
assign	s23	= ~s27 & s24;
assign	s25	=  dma_fifo_dst_addr_dec ? s23 : s27;
assign	s21		=  s19 + `ATCDMAC300_FIFO_POINTER_WIDTH'b1;
assign	s22		=  s20 + `ATCDMAC300_FIFO_POINTER_WIDTH'b1;
assign	s6		= (s22 == s19);
assign s31		=  s6 && ((s26 == s28)
	`ifdef ATCDMAC300_DATA_WIDTH_256
							|| s16
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_128
							|| s15
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_64
							|| s14
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_32
							|| s13
	`endif
						       );

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		s28 <= {BYTE_OFFSET_WIDTH{1'b0}};
	end
	else if (dma_fifo_wr & dma_fifo_last_wr) begin
		s28 <= s26;
	end
end
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		s27 <= {BYTE_OFFSET_WIDTH{1'b0}};
	end
	else if (s0) begin
		s27 <= {BYTE_OFFSET_WIDTH{1'b0}};
	end
	else if ((dma_fifo_wr || dma_fifo_rd)
	`ifdef ATCDMAC300_DATA_WIDTH_32
						&& (!s13)
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_64
						&& (!s14)
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_128
						&& (!s15)
	`endif
	`ifdef ATCDMAC300_DATA_WIDTH_256
						&& (!s16)
	`endif
		) begin
		s27 <= s26;
	end
end

nds_sync_fifo_clr #(
        .DATA_WIDTH	     (`DMA_DATA_WIDTH),
        .FIFO_DEPTH	     (`ATCDMAC300_FIFO_DEPTH),
        .POINTER_INDEX_WIDTH (`ATCDMAC300_FIFO_POINTER_WIDTH)
) nds_sync_fifo_clr (
	.reset_n(aresetn),
	.clk(aclk),
	.wr(s2),
	.wr_data(s7),
	.rd(s3),
	.rd_data(s8),
	.empty(s4),
	.full(s5),
	.wr_ptr(s19),
	.rd_ptr(s20),
	.fifo_clr(s18)
);

	assign	s10 = s17 ? {
				     s8[  7:  0], s8[ 15:  8], s8[ 23: 16], s8[ 31: 24]
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				    ,s8[ 39: 32], s8[ 47: 40], s8[ 55: 48], s8[ 63: 56]
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				    ,s8[ 71: 64], s8[ 79: 72], s8[ 87: 80], s8[ 95: 88]
				    ,s8[103: 96], s8[111:104], s8[119:112], s8[127:120]
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				    ,s8[135:128], s8[143:136], s8[151:144], s8[159:152]
				    ,s8[167:160], s8[175:168], s8[183:176], s8[191:184]
				    ,s8[199:192], s8[207:200], s8[215:208], s8[223:216]
				    ,s8[231:224], s8[239:232], s8[247:240], s8[255:248]
`endif
`endif
`endif
				     } : s8;


`ifdef ATCDMAC300_DATA_WIDTH_32
	assign s29 	=  (s11  && (s27 ==  {`ATCDMAC300_BYTE_OFFSET_WIDTH{1'b1}}))
				|| (s12 && (s27 == {{`ATCDMAC300_BYTE_OFFSET_WIDTH-1{1'b1}},1'b0}))
				|| (s13);

	assign	s26 =   s27  +
						    (s12 ?	{{`ATCDMAC300_BYTE_OFFSET_WIDTH-1{1'b1}},1'b0} :
						     s11  ?	{{`ATCDMAC300_BYTE_OFFSET_WIDTH-1{1'b0}},1'b1} :
									 {`ATCDMAC300_BYTE_OFFSET_WIDTH{1'b0}});

	always @(*) begin
		case (s25[1:0])
			2'b01: begin
				s9[31:24] 	= s10[7:0];
				s9[23:0] 	= s10[31:8];
			end
			2'b10: begin
				s9[31:16] 	= s10[15:0];
				s9[15:0] 	= s10[31:16];
			end
			2'b11: begin
				s9[31:8] 	= s10[23:0];
				s9[7:0] 	= s10[31:24];
			end
			default: begin
				s9 		= s10[31:0];
			end
		endcase
	end

	always @(*) begin
		case (dma_fifo_byte_offset[1:0])
			2'b01: begin
				dma_fifo_rdata[31:8]	= s9[23:0];
				dma_fifo_rdata[7:0] 	= s9[31:24];
			end
			2'b10: begin
				dma_fifo_rdata[31:16] 	= s9[15:0];
				dma_fifo_rdata[15:0] 	= s9[31:16];
			end
			2'b11: begin
				dma_fifo_rdata[31:24] 	= s9[7:0];
				dma_fifo_rdata[23:0] 	= s9[31:8];
			end
			default: begin
				dma_fifo_rdata[31:0]	= s9[31:0];
			end
		endcase
	end

	always @(*) begin
		case (dma_fifo_byte_offset[1:0])
			2'b01: begin
				s1[31:24] 	= dma_fifo_wdata[7:0];
				s1[23:0] 	= dma_fifo_wdata[31:8];
			end
			2'b10: begin
				s1[31:16] 	= dma_fifo_wdata[15:0];
				s1[15:0] 	= dma_fifo_wdata[31:16];
			end
			2'b11: begin
				s1[31:8] 	= dma_fifo_wdata[23:0];
				s1[7:0] 	= dma_fifo_wdata[31:24];
			end
			default: begin
				s1 		= dma_fifo_wdata;
			end
		endcase
	end


	assign s7 = s13  ? 	dma_fifo_wdata :
			    s12 ? 	s44 :
			    			s45;

	assign s44 = dma_fifo_src_addr_dec ? {s36,            s35, s1[15:0]} :
						              {s1[15:0], s36, s35};
	assign s45  = dma_fifo_src_addr_dec ? {s35,            s36, s37, s1[7:0]} :
						              {s1[7:0],  s37, s36, s35};

`endif
`ifdef ATCDMAC300_DATA_WIDTH_64
	assign s29 	=  (s11	   && (s27 ==	3'b111))
				|| (s12	   && (s27 ==	3'b110))
				|| (s13	   && (s27 ==	3'b100))
				|| (s14);

	assign	s26	= s27 + (s13  	?	3'b100 :
						 s12 	?	3'b010 :
						 s11  	?	3'b001 :
										3'b000);
	always @(*) begin
		case (s25[2:0])
			3'b001: begin
				s9[63:56] 	= s10[7:0];
				s9[55:0] 	= s10[63:8];
			end
			3'b010: begin
				s9[63:48] 	= s10[15:0];
				s9[47:0] 	= s10[63:16];
			end
			3'b011: begin
				s9[63:40] 	= s10[23:0];
				s9[39:0] 	= s10[63:24];
			end
			3'b100: begin
				s9[63:32] 	= s10[31:0];
				s9[31:0] 	= s10[63:32];
			end
			3'b101: begin
				s9[63:24] 	= s10[39:0];
				s9[23:0] 	= s10[63:40];
			end
			3'b110: begin
				s9[63:16] 	= s10[47:0];
				s9[15:0] 	= s10[63:48];
			end
			3'b111: begin
				s9[63:8] 	= s10[55:0];
				s9[7:0] 	= s10[63:56];
			end
			default: begin
				s9 		= s10[63:0];
			end
		endcase
	end
	always @(*) begin
		case (dma_fifo_byte_offset[2:0])
			3'b001: begin
				dma_fifo_rdata[63:8]	= s9[55:0];
				dma_fifo_rdata[7:0] 	= s9[63:56];
			end
			3'b010: begin
				dma_fifo_rdata[63:16] 	= s9[47:0];
				dma_fifo_rdata[15:0] 	= s9[63:48];
			end
			3'b011: begin
				dma_fifo_rdata[63:24] 	= s9[39:0];
				dma_fifo_rdata[23:0] 	= s9[63:40];
			end
			3'b100: begin
				dma_fifo_rdata[63:32] 	= s9[31:0];
				dma_fifo_rdata[31:0] 	= s9[63:32];
			end
			3'b101: begin
				dma_fifo_rdata[63:40] 	= s9[23:0];
				dma_fifo_rdata[39:0] 	= s9[63:24];
			end
			3'b110: begin
				dma_fifo_rdata[63:48] 	= s9[15:0];
				dma_fifo_rdata[47:0] 	= s9[63:16];
			end
			3'b111: begin
				dma_fifo_rdata[63:56] 	= s9[7:0];
				dma_fifo_rdata[55:0] 	= s9[63:8];
			end
			default: begin
				dma_fifo_rdata 		= s9;
			end
		endcase
	end
	always @(*) begin
		case (dma_fifo_byte_offset[2:0])
			3'b001: begin
				s1[63:56] 	= dma_fifo_wdata[7:0];
				s1[55:0] 	= dma_fifo_wdata[63:8];
			end
			3'b010: begin
				s1[63:48] 	= dma_fifo_wdata[15:0];
				s1[47:0] 	= dma_fifo_wdata[63:16];
			end
			3'b011: begin
				s1[63:40] 	= dma_fifo_wdata[23:0];
				s1[39:0] 	= dma_fifo_wdata[63:24];
			end
			3'b100: begin
				s1[63:32] 	= dma_fifo_wdata[31:0];
				s1[31:0] 	= dma_fifo_wdata[63:32];
			end
			3'b101: begin
				s1[63:24] 	= dma_fifo_wdata[39:0];
				s1[23:0] 	= dma_fifo_wdata[63:40];
			end
			3'b110: begin
				s1[63:16] 	= dma_fifo_wdata[47:0];
				s1[15:0] 	= dma_fifo_wdata[63:48];
			end
			3'b111: begin
				s1[63:8] 	= dma_fifo_wdata[55:0];
				s1[7:0] 	= dma_fifo_wdata[63:56];
			end
			default: begin
				s1[63:0] 	= dma_fifo_wdata[63:0];
			end
		endcase
	end

	assign s62 = dma_fifo_src_addr_dec ?
	{s50,            s37, s36, s35, s1[31:0]} :
	{s1[31:0], s50, s37, s36, s35};
	assign s44 = dma_fifo_src_addr_dec ?
	{s36,            s35, s50, s37, s52, s51, s1[15:0]} :
	{s1[15:0], s52, s51, s50, s37, s36, s35};
	assign s45 = dma_fifo_src_addr_dec ?
	{s35,           s36, s37, s50, s51, s52, s53, s1[7:0]} :
	{s1[7:0], s53, s52, s51, s50, s37, s36, s35};

	assign s7 = s14 ? dma_fifo_wdata :
                            s13        ? s62 :
			    s12       ? s44 :
                                                     s45;

`endif
`ifdef ATCDMAC300_DATA_WIDTH_128
	assign s29 	=  (s11	   && (s27 ==	4'b1111))
				|| (s12	   && (s27 ==	4'b1110))
				|| (s13	   && (s27 ==	4'b1100))
				|| (s14 && (s27 ==	4'b1000))
				|| (s15);

	assign	s26	= s27 + (s14	?	4'b1000 :
						 s13	?	4'b0100 :
						 s12	?	4'b0010 :
						 s11	?	4'b0001 :
										4'b0000);
	always @(*) begin
		case (s25[3:0])
			4'b0001: begin
				s9[127:120] 	= s10[  7:  0];
				s9[119:  0] 	= s10[127:  8];
			end
			4'b0010: begin
				s9[127:112] 	= s10[ 15:  0];
				s9[111:  0] 	= s10[127:  16];
			end
			4'b0011: begin
				s9[127:104] 	= s10[ 23:  0];
				s9[103:  0] 	= s10[127: 24];
			end
			4'b0100: begin
				s9[127: 96] 	= s10[ 31:  0];
				s9[ 95:  0] 	= s10[127: 32];
			end
			4'b0101: begin
				s9[127: 88] 	= s10[ 39:  0];
				s9[ 87:  0] 	= s10[127: 40];
			end
			4'b0110: begin
				s9[127: 80] 	= s10[ 47:  0];
				s9[ 79:  0] 	= s10[127: 48];
			end
			4'b0111: begin
				s9[127: 72] 	= s10[ 55:  0];
				s9[ 71:  0] 	= s10[127: 56];
			end
			4'b1000: begin
				s9[127: 64] 	= s10[ 63:  0];
				s9[ 63:  0] 	= s10[127: 64];
			end
			4'b1001: begin
				s9[127: 56] 	= s10[ 71:  0];
				s9[ 55:  0] 	= s10[127: 72];
			end
			4'b1010: begin
				s9[127: 48] 	= s10[ 79:  0];
				s9[ 47:  0] 	= s10[127: 80];
			end
			4'b1011: begin
				s9[127: 40] 	= s10[ 87:  0];
				s9[ 39:  0] 	= s10[127: 88];
			end
			4'b1100: begin
				s9[127: 32] 	= s10[ 95:  0];
				s9[ 31:  0] 	= s10[127: 96];
			end
			4'b1101: begin
				s9[127: 24] 	= s10[103:  0];
				s9[ 23:  0] 	= s10[127:104];
			end
			4'b1110: begin
				s9[127: 16] 	= s10[111:  0];
				s9[ 15:  0] 	= s10[127:112];
			end
			4'b1111: begin
				s9[127:  8] 	= s10[119:  0];
				s9[  7:  0] 	= s10[127:120];
			end
			default: begin
				s9[127:  0]	= s10[127:0];
			end
		endcase
	end
	always @(*) begin
		case (dma_fifo_byte_offset[3:0])
			4'b0001: begin
				dma_fifo_rdata[127:  8]		= s9[119:  0];
				dma_fifo_rdata[  7:  0] 	= s9[127:120];
			end
			4'b0010: begin
				dma_fifo_rdata[127: 16] 	= s9[111:  0];
				dma_fifo_rdata[ 15:  0] 	= s9[127:112];
			end
			4'b0011: begin
				dma_fifo_rdata[127: 24] 	= s9[103:  0];
				dma_fifo_rdata[ 23:  0] 	= s9[127:104];
			end
			4'b0100: begin
				dma_fifo_rdata[127: 32] 	= s9[ 95:  0];
				dma_fifo_rdata[ 31:  0] 	= s9[127: 96];
			end
			4'b0101: begin
				dma_fifo_rdata[127: 40] 	= s9[ 87:  0];
				dma_fifo_rdata[ 39:  0] 	= s9[127: 88];
			end
			4'b0110: begin
				dma_fifo_rdata[127: 48] 	= s9[ 79:  0];
				dma_fifo_rdata[ 47:  0] 	= s9[127: 80];
			end
			4'b0111: begin
				dma_fifo_rdata[127: 56] 	= s9[ 71:  0];
				dma_fifo_rdata[ 55:  0] 	= s9[127: 72];
			end
			4'b1000: begin
				dma_fifo_rdata[127: 64] 	= s9[ 63:  0];
				dma_fifo_rdata[ 63:  0] 	= s9[127: 64];
			end
			4'b1001: begin
				dma_fifo_rdata[127: 72]		= s9[ 55:  0];
				dma_fifo_rdata[ 71:  0] 	= s9[127: 56];
			end
			4'b1010: begin
				dma_fifo_rdata[127: 80] 	= s9[ 47:  0];
				dma_fifo_rdata[ 79:  0] 	= s9[127: 48];
			end
			4'b1011: begin
				dma_fifo_rdata[127: 88] 	= s9[ 39:  0];
				dma_fifo_rdata[ 87:  0] 	= s9[127: 40];
			end
			4'b1100: begin
				dma_fifo_rdata[127: 96] 	= s9[ 31:  0];
				dma_fifo_rdata[ 95:  0] 	= s9[127: 32];
			end
			4'b1101: begin
				dma_fifo_rdata[127:104] 	= s9[ 23:  0];
				dma_fifo_rdata[103:  0] 	= s9[127: 24];
			end
			4'b1110: begin
				dma_fifo_rdata[127:112] 	= s9[ 15:  0];
				dma_fifo_rdata[111:  0] 	= s9[127: 16];
			end
			4'b1111: begin
				dma_fifo_rdata[127:120] 	= s9[  7:  0];
				dma_fifo_rdata[119:  0] 	= s9[127:  8];
			end
			default: begin
				dma_fifo_rdata[127:  0] 	= s9[127:  0];
			end
		endcase
	end
	always @(*) begin
		case (dma_fifo_byte_offset[3:0])
			4'b0001: begin
				s1[127:120] 	= dma_fifo_wdata[  7:  0];
				s1[119:  0] 	= dma_fifo_wdata[127:  8];
			end
			4'b0010: begin
				s1[127:112] 	= dma_fifo_wdata[ 15:  0];
				s1[111:  0] 	= dma_fifo_wdata[127: 16];
			end
			4'b0011: begin
				s1[127:104] 	= dma_fifo_wdata[ 23:  0];
				s1[103:  0] 	= dma_fifo_wdata[127: 24];
			end
			4'b0100: begin
				s1[127: 96] 	= dma_fifo_wdata[ 31:  0];
				s1[ 95:  0] 	= dma_fifo_wdata[127: 32];
			end
			4'b0101: begin
				s1[127: 88] 	= dma_fifo_wdata[ 39:  0];
				s1[87:   0] 	= dma_fifo_wdata[127: 40];
			end
			4'b0110: begin
				s1[127: 80] 	= dma_fifo_wdata[ 47:  0];
				s1[ 79:  0] 	= dma_fifo_wdata[127: 48];
			end
			4'b0111: begin
				s1[127: 72] 	= dma_fifo_wdata[ 55:  0];
				s1[ 71:  0] 	= dma_fifo_wdata[127: 56];
			end
			4'b1000: begin
				s1[127: 64] 	= dma_fifo_wdata[ 63:  0];
				s1[ 63:  0] 	= dma_fifo_wdata[127: 64];
			end
			4'b1001: begin
				s1[127: 56] 	= dma_fifo_wdata[ 71:  0];
				s1[ 55:  0] 	= dma_fifo_wdata[127: 72];
			end
			4'b1010: begin
				s1[127: 48] 	= dma_fifo_wdata[ 79:  0];
				s1[ 47:  0] 	= dma_fifo_wdata[127: 80];
			end
			4'b1011: begin
				s1[127: 40] 	= dma_fifo_wdata[ 87:  0];
				s1[ 39:  0] 	= dma_fifo_wdata[127: 88];
			end
			4'b1100: begin
				s1[127: 32] 	= dma_fifo_wdata[ 95:  0];
				s1[ 31:  0] 	= dma_fifo_wdata[127: 96];
			end
			4'b1101: begin
				s1[127: 24] 	= dma_fifo_wdata[103:  0];
				s1[ 23:  0] 	= dma_fifo_wdata[127:104];
			end
			4'b1110: begin
				s1[127: 16] 	= dma_fifo_wdata[111:  0];
				s1[ 15:  0] 	= dma_fifo_wdata[127:112];
			end
			4'b1111: begin
				s1[127:  8] 	= dma_fifo_wdata[119:  0];
				s1[  7:  0] 	= dma_fifo_wdata[127:120];
			end
			default: begin
				s1[127:  0] 	= dma_fifo_wdata[127:  0];
			end
		endcase
	end

	assign s95 =	 dma_fifo_src_addr_dec ?
						{s71           , s53 , s52           , s51             ,
						 s50           , s37 , s36           , s35             ,
						                                                                     s1[63:0]} :
						{s1[63:0]                                                                      ,
						 s71           , s53 , s52           , s51             ,
						 s50           , s37 , s36           , s35           } ;

	assign s62 =		 dma_fifo_src_addr_dec ?
						{s50           , s37 , s36           , s35             ,
						 s71           , s53 , s52           , s51             ,
						 s75          , s74, s73           , s72             ,
						                                                                     s1[31:0]} :
						{s1[31:0]                                                                      ,
						 s75          , s74, s73           , s72             ,
						 s71           , s53 , s52           , s51             ,
						 s50           , s37 , s36           , s35           } ;

	assign s44 =		 dma_fifo_src_addr_dec ?
						{s36           , s35 , s50           , s37             ,
						 s52           , s51 , s71           , s53             ,
						 s73           , s72 , s75          , s74            ,
						 s77          , s76,                           s1[15:0]} :
						{s1[15:0],                 s77          , s76            ,
						 s75          , s74, s73           , s72             ,
						 s71           , s53 , s52           , s51             ,
						 s50           , s37 , s36           , s35           } ;

	assign s45 =		 dma_fifo_src_addr_dec ?
						{s35           , s36 , s37           , s50             ,
						 s51           , s52 , s53           , s71             ,
						 s72           , s73 , s74          , s75            ,
						 s76          , s77, s78          , s1[ 7:0]} :
						{s1[ 7:0], s78, s77          , s76            ,
						 s75          , s74, s73           , s72             ,
						 s71           , s53 , s52           , s51             ,
						 s50           , s37 , s36           , s35           } ;

	assign s7 = s15   ? dma_fifo_wdata :
			    s14 ? s95 :
                            s13        ? s62 :
			    s12       ? s44 :
                                                     s45;

`endif
`ifdef ATCDMAC300_DATA_WIDTH_256
	assign s29 	=  (s11	   && (s27 ==	5'b11111))
				|| (s12	   && (s27 ==	5'b11110))
				|| (s13	   && (s27 ==	5'b11100))
				|| (s14 && (s27 ==	5'b11000))
				|| (s15   && (s27 ==	5'b10000))
				|| (s16);

	assign	s26	= s27 + (s15	?	5'b10000 :
						 s14	?	5'b01000 :
						 s13	?	5'b00100 :
						 s12	?	5'b00010 :
						 s11	?	5'b00001 :
								  		5'b00000);
	always @(*) begin
		case (s25[4:0])
			5'b00001: begin
				s9[255:248] 	= s10[  7:  0];
				s9[247:  0] 	= s10[255:  8];
			end
			5'b00010: begin
				s9[255:240] 	= s10[ 15:  0];
				s9[239:  0] 	= s10[255: 16];
			end
			5'b00011: begin
				s9[255:232] 	= s10[ 23:  0];
				s9[231:  0] 	= s10[255: 24];
			end
			5'b00100: begin
				s9[255:224] 	= s10[ 31:  0];
				s9[223:  0] 	= s10[255: 32];
			end
			5'b00101: begin
				s9[255:216] 	= s10[ 39:  0];
				s9[215:  0] 	= s10[255: 40];
			end
			5'b00110: begin
				s9[255:208] 	= s10[ 47:  0];
				s9[207:  0] 	= s10[255: 48];
			end
			5'b00111: begin
				s9[255:200] 	= s10[ 55:  0];
				s9[199:  0] 	= s10[255: 56];
			end
			5'b01000: begin
				s9[255:192] 	= s10[ 63:  0];
				s9[191:  0] 	= s10[255: 64];
			end
			5'b01001: begin
				s9[255:184] 	= s10[ 71:  0];
				s9[183:  0] 	= s10[255: 72];
			end
			5'b01010: begin
				s9[255:176] 	= s10[ 79:  0];
				s9[175:  0] 	= s10[255: 80];
			end
			5'b01011: begin
				s9[255:168] 	= s10[ 87:  0];
				s9[167:  0] 	= s10[255: 88];
			end
			5'b01100: begin
				s9[255:160] 	= s10[ 95:  0];
				s9[159:  0] 	= s10[255: 96];
			end
			5'b01101: begin
				s9[255:152] 	= s10[103:  0];
				s9[151:  0] 	= s10[255:104];
			end
			5'b01110: begin
				s9[255:144] 	= s10[111:  0];
				s9[143:  0] 	= s10[255:112];
			end
			5'b01111: begin
				s9[255:136] 	= s10[119:  0];
				s9[135:  0] 	= s10[255:120];
			end
			5'b10000: begin
				s9[255:128] 	= s10[127:  0];
				s9[127:  0] 	= s10[255:128];
			end
			5'b10001: begin
				s9[255:120] 	= s10[135:  0];
				s9[119:  0] 	= s10[255:136];
			end
			5'b10010: begin
				s9[255:112] 	= s10[143:  0];
				s9[111:  0] 	= s10[255:144];
			end
			5'b10011: begin
				s9[255:104] 	= s10[151:  0];
				s9[103:  0] 	= s10[255:152];
			end
			5'b10100: begin
				s9[255: 96] 	= s10[159:  0];
				s9[ 95:  0] 	= s10[255:160];
			end
			5'b10101: begin
				s9[255: 88] 	= s10[167:  0];
				s9[ 87:  0] 	= s10[255:168];
			end
			5'b10110: begin
				s9[255: 80] 	= s10[175:  0];
				s9[ 79:  0] 	= s10[255:176];
			end
			5'b10111: begin
				s9[255: 72] 	= s10[183:  0];
				s9[ 71:  0] 	= s10[255:184];
			end
			5'b11000: begin
				s9[255: 64] 	= s10[191:  0];
				s9[ 63:  0] 	= s10[255:192];
			end
			5'b11001: begin
				s9[255: 56] 	= s10[199:  0];
				s9[ 55:  0] 	= s10[255:200];
			end
			5'b11010: begin
				s9[255: 48] 	= s10[207:  0];
				s9[ 47:  0] 	= s10[255:208];
			end
			5'b11011: begin
				s9[255: 40] 	= s10[215:  0];
				s9[ 39:  0] 	= s10[255:216];
			end
			5'b11100: begin
				s9[255: 32] 	= s10[223:  0];
				s9[ 31:  0] 	= s10[255:224];
			end
			5'b11101: begin
				s9[255: 24] 	= s10[231:  0];
				s9[ 23:  0] 	= s10[255:232];
			end
			5'b11110: begin
				s9[255: 16] 	= s10[239:  0];
				s9[ 15:  0] 	= s10[255:240];
			end
			5'b11111: begin
				s9[255:  8] 	= s10[247:  0];
				s9[  7:  0] 	= s10[255:248];
			end
			default: begin
				s9[255:  0]	= s10[255:0];
			end
		endcase
	end
	always @(*) begin
		case (dma_fifo_byte_offset[4:0])
			5'b00001: begin
				dma_fifo_rdata[255:  8]		= s9[247:  0];
				dma_fifo_rdata[  7:  0] 	= s9[255:248];
			end
			5'b00010: begin
				dma_fifo_rdata[255: 16] 	= s9[239:  0];
				dma_fifo_rdata[ 15:  0] 	= s9[255:240];
			end
			5'b00011: begin
				dma_fifo_rdata[255: 24] 	= s9[231:  0];
				dma_fifo_rdata[ 23:  0] 	= s9[255:232];
			end
			5'b00100: begin
				dma_fifo_rdata[255: 32] 	= s9[223:  0];
				dma_fifo_rdata[ 31:  0] 	= s9[255:224];
			end
			5'b00101: begin
				dma_fifo_rdata[255: 40] 	= s9[215:  0];
				dma_fifo_rdata[ 39:  0] 	= s9[255:216];
			end
			5'b00110: begin
				dma_fifo_rdata[255: 48] 	= s9[207:  0];
				dma_fifo_rdata[ 47:  0] 	= s9[255:208];
			end
			5'b00111: begin
				dma_fifo_rdata[255: 56] 	= s9[199:  0];
				dma_fifo_rdata[ 55:  0] 	= s9[255:200];
			end
			5'b01000: begin
				dma_fifo_rdata[255: 64] 	= s9[191:  0];
				dma_fifo_rdata[ 63:  0] 	= s9[255:192];
			end
			5'b01001: begin
				dma_fifo_rdata[255: 72]		= s9[183:  0];
				dma_fifo_rdata[ 71:  0] 	= s9[255:184];
			end
			5'b01010: begin
				dma_fifo_rdata[255: 80] 	= s9[175:  0];
				dma_fifo_rdata[ 79:  0] 	= s9[255:176];
			end
			5'b01011: begin
				dma_fifo_rdata[255: 88] 	= s9[167:  0];
				dma_fifo_rdata[ 87:  0] 	= s9[255:168];
			end
			5'b01100: begin
				dma_fifo_rdata[255: 96] 	= s9[159:  0];
				dma_fifo_rdata[ 95:  0] 	= s9[255:160];
			end
			5'b01101: begin
				dma_fifo_rdata[255:104] 	= s9[151:  0];
				dma_fifo_rdata[103:  0] 	= s9[255:152];
			end
			5'b01110: begin
				dma_fifo_rdata[255:112] 	= s9[143:  0];
				dma_fifo_rdata[111:  0] 	= s9[255:144];
			end
			5'b01111: begin
				dma_fifo_rdata[255:120] 	= s9[135:  0];
				dma_fifo_rdata[119:  0] 	= s9[255:136];
			end
			5'b10000: begin
				dma_fifo_rdata[255:128] 	= s9[127:  0];
				dma_fifo_rdata[127:  0] 	= s9[255:128];
			end
			5'b10001: begin
				dma_fifo_rdata[255:136]		= s9[119:  0];
				dma_fifo_rdata[135:  0] 	= s9[255:120];
			end
			5'b10010: begin
				dma_fifo_rdata[255:144] 	= s9[111:  0];
				dma_fifo_rdata[143:  0] 	= s9[255:112];
			end
			5'b10011: begin
				dma_fifo_rdata[255:152] 	= s9[103:  0];
				dma_fifo_rdata[151:  0] 	= s9[255:104];
			end
			5'b10100: begin
				dma_fifo_rdata[255:160] 	= s9[ 95:  0];
				dma_fifo_rdata[159:  0] 	= s9[255: 96];
			end
			5'b10101: begin
				dma_fifo_rdata[255:168] 	= s9[ 87:  0];
				dma_fifo_rdata[167:  0] 	= s9[255: 88];
			end
			5'b10110: begin
				dma_fifo_rdata[255:176] 	= s9[ 79:  0];
				dma_fifo_rdata[175:  0] 	= s9[255: 80];
			end
			5'b10111: begin
				dma_fifo_rdata[255:184] 	= s9[ 71:  0];
				dma_fifo_rdata[183:  0] 	= s9[255: 72];
			end
			5'b11000: begin
				dma_fifo_rdata[255:192] 	= s9[ 63:  0];
				dma_fifo_rdata[191:  0] 	= s9[255: 64];
			end
			5'b11001: begin
				dma_fifo_rdata[255:200]		= s9[ 55:  0];
				dma_fifo_rdata[199:  0] 	= s9[255: 56];
			end
			5'b11010: begin
				dma_fifo_rdata[255:208] 	= s9[ 47:  0];
				dma_fifo_rdata[207:  0] 	= s9[255: 48];
			end
			5'b11011: begin
				dma_fifo_rdata[255:216] 	= s9[ 39:  0];
				dma_fifo_rdata[215:  0] 	= s9[255: 40];
			end
			5'b11100: begin
				dma_fifo_rdata[255:224] 	= s9[ 31:  0];
				dma_fifo_rdata[223:  0] 	= s9[255: 32];
			end
			5'b11101: begin
				dma_fifo_rdata[255:232] 	= s9[ 23:  0];
				dma_fifo_rdata[231:  0] 	= s9[255: 24];
			end
			5'b11110: begin
				dma_fifo_rdata[255:240] 	= s9[ 15:  0];
				dma_fifo_rdata[239:  0] 	= s9[255: 16];
			end
			5'b11111: begin
				dma_fifo_rdata[255:248] 	= s9[  7:  0];
				dma_fifo_rdata[247:  0] 	= s9[255:  8];
			end
			default: begin
				dma_fifo_rdata[255:  0] 	= s9[255:  0];
			end
		endcase
	end
	always @(*) begin
		case (dma_fifo_byte_offset[4:0])
			5'b00001: begin
				s1[255:248] 	= dma_fifo_wdata[  7:  0];
				s1[247:  0] 	= dma_fifo_wdata[255:  8];
			end
			5'b00010: begin
				s1[255:240] 	= dma_fifo_wdata[ 15:  0];
				s1[239:  0] 	= dma_fifo_wdata[255: 16];
			end
			5'b00011: begin
				s1[255:232] 	= dma_fifo_wdata[ 23:  0];
				s1[231:  0] 	= dma_fifo_wdata[255: 24];
			end
			5'b00100: begin
				s1[255:224] 	= dma_fifo_wdata[ 31:  0];
				s1[223:  0] 	= dma_fifo_wdata[255: 32];
			end
			5'b00101: begin
				s1[255:216] 	= dma_fifo_wdata[ 39:  0];
				s1[215:  0] 	= dma_fifo_wdata[255: 40];
			end
			5'b00110: begin
				s1[255:208] 	= dma_fifo_wdata[ 47:  0];
				s1[207:  0] 	= dma_fifo_wdata[255: 48];
			end
			5'b00111: begin
				s1[255:200] 	= dma_fifo_wdata[ 55:  0];
				s1[199:  0] 	= dma_fifo_wdata[255: 56];
			end
			5'b01000: begin
				s1[255:192] 	= dma_fifo_wdata[ 63:  0];
				s1[191:  0] 	= dma_fifo_wdata[255: 64];
			end
			5'b01001: begin
				s1[255:184] 	= dma_fifo_wdata[ 71:  0];
				s1[183:  0] 	= dma_fifo_wdata[255: 72];
			end
			5'b01010: begin
				s1[255:176] 	= dma_fifo_wdata[ 79:  0];
				s1[175:  0] 	= dma_fifo_wdata[255: 80];
			end
			5'b01011: begin
				s1[255:168] 	= dma_fifo_wdata[ 87:  0];
				s1[167:  0] 	= dma_fifo_wdata[255: 88];
			end
			5'b01100: begin
				s1[255:160] 	= dma_fifo_wdata[ 95:  0];
				s1[159:  0] 	= dma_fifo_wdata[255: 96];
			end
			5'b01101: begin
				s1[255:152] 	= dma_fifo_wdata[103:  0];
				s1[151:  0] 	= dma_fifo_wdata[255:104];
			end
			5'b01110: begin
				s1[255:144] 	= dma_fifo_wdata[111:  0];
				s1[143:  0] 	= dma_fifo_wdata[255:112];
			end
			5'b01111: begin
				s1[255:136] 	= dma_fifo_wdata[119:  0];
				s1[135:  0] 	= dma_fifo_wdata[255:120];
			end
			5'b10000: begin
				s1[255:128] 	= dma_fifo_wdata[127:  0];
				s1[127:  0] 	= dma_fifo_wdata[255:128];
			end
			5'b10001: begin
				s1[255:120] 	= dma_fifo_wdata[135:  0];
				s1[119:  0] 	= dma_fifo_wdata[255:136];
			end
			5'b10010: begin
				s1[255:112] 	= dma_fifo_wdata[143:  0];
				s1[111:  0] 	= dma_fifo_wdata[255:144];
			end
			5'b10011: begin
				s1[255:104] 	= dma_fifo_wdata[151:  0];
				s1[103:  0] 	= dma_fifo_wdata[255:152];
			end
			5'b10100: begin
				s1[255: 96] 	= dma_fifo_wdata[159:  0];
				s1[ 95:  0] 	= dma_fifo_wdata[255:160];
			end
			5'b10101: begin
				s1[255: 88] 	= dma_fifo_wdata[167:  0];
				s1[87:   0] 	= dma_fifo_wdata[255:168];
			end
			5'b10110: begin
				s1[255: 80] 	= dma_fifo_wdata[175:  0];
				s1[ 79:  0] 	= dma_fifo_wdata[255:176];
			end
			5'b10111: begin
				s1[255: 72] 	= dma_fifo_wdata[183:  0];
				s1[ 71:  0] 	= dma_fifo_wdata[255:184];
			end
			5'b11000: begin
				s1[255: 64] 	= dma_fifo_wdata[191:  0];
				s1[ 63:  0] 	= dma_fifo_wdata[255:192];
			end
			5'b11001: begin
				s1[255: 56] 	= dma_fifo_wdata[199:  0];
				s1[ 55:  0] 	= dma_fifo_wdata[255:200];
			end
			5'b11010: begin
				s1[255: 48] 	= dma_fifo_wdata[207:  0];
				s1[ 47:  0] 	= dma_fifo_wdata[255:208];
			end
			5'b11011: begin
				s1[255: 40] 	= dma_fifo_wdata[215:  0];
				s1[ 39:  0] 	= dma_fifo_wdata[255:216];
			end
			5'b11100: begin
				s1[255: 32] 	= dma_fifo_wdata[223:  0];
				s1[ 31:  0] 	= dma_fifo_wdata[255:224];
			end
			5'b11101: begin
				s1[255: 24] 	= dma_fifo_wdata[231:  0];
				s1[ 23:  0] 	= dma_fifo_wdata[255:232];
			end
			5'b11110: begin
				s1[255: 16] 	= dma_fifo_wdata[239:  0];
				s1[ 15:  0] 	= dma_fifo_wdata[255:240];
			end
			5'b11111: begin
				s1[255:  8] 	= dma_fifo_wdata[247:  0];
				s1[  7:  0] 	= dma_fifo_wdata[255:248];
			end
			default: begin
				s1[255:  0] 	= dma_fifo_wdata[255:  0];
			end
		endcase
	end

	assign s160 =	 dma_fifo_src_addr_dec ?
						{s112          , s78, s77          , s76             ,
						 s75          , s74, s73           , s72              ,
						 s71           , s53 , s52           , s51              ,
						 s50           , s37 , s36           , s35              ,
						                                                                     s1[127:0]} :
						{s1[127:0]                                                                      ,
						 s112          , s78, s77          , s76             ,
						 s75          , s74, s73           , s72              ,
						 s71           , s53 , s52           , s51              ,
						 s50           , s37 , s36           , s35            } ;

	assign s95 =	 dma_fifo_src_addr_dec ?
						{s71           , s53 , s52           , s51             ,
						 s50           , s37 , s36           , s35             ,
						 s112          , s78, s77          , s76            ,
						 s75          , s74, s73           , s72             ,
						 s120          , s119, s118          , s117            ,
						 s116          , s115, s114          , s113            ,
						                                                                     s1[63:0]} :
						{s1[63:0]                                                                      ,
						 s120          , s119, s118          , s117            ,
						 s116          , s115, s114          , s113            ,
						 s112          , s78, s77          , s76            ,
						 s75          , s74, s73           , s72             ,
						 s71           , s53 , s52           , s51             ,
						 s50           , s37 , s36           , s35           } ;

	assign s62 =		 dma_fifo_src_addr_dec ?
						{s50           , s37 , s36           , s35             ,
						 s71           , s53 , s52           , s51             ,
						 s75          , s74, s73           , s72             ,
						 s112          , s78, s77          , s76            ,
						 s116          , s115, s114          , s113            ,
						 s120          , s119, s118          , s117            ,
						 s124          , s123, s122          , s121            ,
						                                                                     s1[31:0]} :
						{s1[31:0]                                                                      ,
						 s124          , s123, s122          , s121            ,
						 s120          , s119, s118          , s117            ,
						 s116          , s115, s114          , s113            ,
						 s112          , s78, s77          , s76            ,
						 s75          , s74, s73           , s72             ,
						 s71           , s53 , s52           , s51             ,
						 s50           , s37 , s36           , s35           } ;

	assign s44 =		 dma_fifo_src_addr_dec ?
						{s36           , s35 , s50           , s37             ,
						 s52           , s51 , s71           , s53             ,
						 s73           , s72 , s75          , s74            ,
						 s77          , s76, s112          , s78            ,
						 s114          , s113, s116          , s115            ,
						 s118          , s117, s120          , s119            ,
						 s122          , s121, s124          , s123            ,
						 s126          , s125,                           s1[15:0]} :
						{s1[15:0]                , s126          , s125            ,
						 s124          , s123, s122          , s121            ,
						 s120          , s119, s118          , s117            ,
						 s116          , s115, s114          , s113            ,
						 s112          , s78, s77          , s76            ,
						 s75          , s74, s73           , s72             ,
						 s71           , s53 , s52           , s51             ,
						 s50           , s37 , s36           , s35           } ;

	assign s45 =		 dma_fifo_src_addr_dec ?
						{s35           , s36 , s37           , s50             ,
						 s51           , s52 , s53           , s71             ,
						 s72           , s73 , s74          , s75            ,
						 s76          , s77, s78          , s112            ,
						 s113          , s114, s115          , s116            ,
						 s117          , s118, s119          , s120            ,
						 s121          , s122, s123          , s124            ,
						 s125          , s126, s127          , s1[ 7:0]} :
						{s1[ 7:0], s127, s126          , s125            ,
						 s124          , s123, s122          , s121            ,
						 s120          , s119, s118          , s117            ,
						 s116          , s115, s114          , s113            ,
						 s112          , s78, s77          , s76            ,
						 s75          , s74, s73           , s72             ,
						 s71           , s53 , s52           , s51             ,
						 s50           , s37 , s36           , s35           } ;

	assign s7 = s16  ? dma_fifo_wdata :
			    s15   ? s160 :
			    s14 ? s95 :
                            s13        ? s62 :
			    s12       ? s44 :
                                                     s45;

`endif
assign s35		= (dma_fifo_wr & dma_fifo_last_wr & s38) ? s41 : s32;
assign s36		= (dma_fifo_wr & dma_fifo_last_wr & s39) ? s42 : s33;
assign s37		= (dma_fifo_wr & dma_fifo_last_wr & s40) ? s43 : s34;
assign s41 	=										s1[ 7: 0];
assign s42	= (s11 			) ?	s1[ 7: 0] : 	s1[15: 8];
assign s43 	= (s11 || s12	) ?	s1[ 7: 0] :	s1[23:16];

assign s38 = dma_fifo_wr && (
				   (s11        && (s27 == {BYTE_OFFSET_WIDTH{1'h0}}))
				|| (s12       && (s27 == {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				|| (s13        && (s27 == {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (s14 && (s27 == {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (s27 == {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
	`endif
				);
assign s39 = dma_fifo_wr && (
				   (s11        && (s27 == {{BYTE_OFFSET_WIDTH-1{1'h0}}, 1'd1}))
				|| (s12       && (s27 ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				|| (s13        && (s27 ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (s14 && (s27 ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (s27 ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
	`endif
				);
assign s40 = dma_fifo_wr && (
				   (s11        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-1{1'h0}}, 2'd2}))
				|| (s12       && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-1{1'h0}}, 2'd2}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_64
				|| (s13        && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (s14 && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
	`endif
				);

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s32 <= 8'b0;
		else if (s38)
			s32 <= s41;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s33 <= 8'b0;
		else if (s39)
			s33 <= s42;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s34 <= 8'b0;
		else if (s40)
			s34 <= s43;
`ifdef ATCDMAC300_DATA_WIDTH_GE_64
assign s50		= (dma_fifo_wr & dma_fifo_last_wr & s58) ? s54 : s46;
assign s51		= (dma_fifo_wr & dma_fifo_last_wr & s59) ? s55 : s47;
assign s52		= (dma_fifo_wr & dma_fifo_last_wr & s60) ? s56 : s48;
assign s53		= (dma_fifo_wr & dma_fifo_last_wr & s61) ? s57 : s49;

assign s54	=  s11 					    ? s1[ 7: 0] :
				   s12					    ? s1[15: 8] : s1[31:24] ;
assign s55	= (s11  || s12 || s13) ? s1[ 7: 0] : s1[39:32];
assign s56	=  s11 					    ? s1[ 7: 0] :
				  (s12 || s13) 		    ? s1[15: 8] : s1[47:40];
assign s57	= (s11  || s12)		    ? s1[ 7: 0] :
				   s13					    ? s1[23:16] : s1[55:48];


assign s58 = dma_fifo_wr && (
				   (s11        && (s27 == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 2'd3}))
				|| (s12       && (s27 == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 2'd2}))
				|| (s13        && (s27 ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (s14 && (s27 ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (s27 ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
				);

assign s59 = dma_fifo_wr && (
				   (s11        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
				|| (s12       && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
				|| (s13        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (s14 && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
				);

assign s60 = dma_fifo_wr && (
				   (s11        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd5}))
				|| (s12       && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
				|| (s13        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (s14 && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
				);

assign s61 = dma_fifo_wr && (
				   (s11        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd6}))
				|| (s12       && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd6}))
				|| (s13        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-2{1'h0}}, 3'd4}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_128
				|| (s14 && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
	`endif
				);

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s46 <= 8'b0;
		else if (s58)
			s46 <= s54;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s47 <= 8'b0;
		else if (s59)
			s47 <= s55;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s48 <= 8'b0;
		else if (s60)
			s48 <= s56;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s49 <= 8'b0;
		else if (s61)
			s49 <= s57;
`ifdef ATCDMAC300_DATA_WIDTH_GE_128
assign s71		= (dma_fifo_wr & dma_fifo_last_wr & s87)  ? s79  : s63;
assign s72		= (dma_fifo_wr & dma_fifo_last_wr & s88)  ? s80  : s64;
assign s73		= (dma_fifo_wr & dma_fifo_last_wr & s89)  ? s81  : s65;
assign s74		= (dma_fifo_wr & dma_fifo_last_wr & s90) ? s82 : s66;
assign s75		= (dma_fifo_wr & dma_fifo_last_wr & s91) ? s83 : s67;
assign s76		= (dma_fifo_wr & dma_fifo_last_wr & s92) ? s84 : s68;
assign s77		= (dma_fifo_wr & dma_fifo_last_wr & s93) ? s85 : s69;
assign s78		= (dma_fifo_wr & dma_fifo_last_wr & s94) ? s86 : s70;

assign s79	= (s11)				? s1[  7:  0] :
				  (s12) 				? s1[ 15:  8] :
				  (s13)				? s1[ 31: 24] :
										  s1[ 63: 56] ;

assign s80	= (s11  || s12 || s13 || s14)
										? s1[  7:  0] :
										  s1[ 71: 64] ;

assign s81	= (s11)				? s1[  7:  0] :
				  (s12 || s13 || s14)
										? s1[ 15:  8] :
										  s1[ 79: 72] ;

assign s82	= (s11  || s12)	? s1[  7:  0] :
				  (s13  || s14)	? s1[ 23: 16] :
										  s1[ 87: 80] ;

assign s83	= (s11)				? s1[  7:  0] :
				  (s12)				? s1[ 15:  8] :
				  (s13  || s14)	? s1[ 31: 24] :
										  s1[ 95: 88] ;

assign s84	= (s11  || s12 || s13)
										? s1[  7:  0] :
				  (s14)			? s1[ 39: 32] :
										  s1[103: 96] ;

assign s85	= (s11)				? s1[  7:  0] :
				  (s12 || s13)		? s1[ 15:  8] :
				  (s14)			? s1[ 47: 40] :
										  s1[111:104] ;

assign s86	= (s11  || s12)	? s1[  7:  0] :
				  (s13)				? s1[ 23: 16] :
				  (s14)			? s1[ 55: 48] :
										  s1[119:112] ;
assign s87 = dma_fifo_wr && (
				   (s11        && (s27 == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 3'd7}))
				|| (s12       && (s27 == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 3'd6}))
				|| (s13        && (s27 == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 3'd4}))
				|| (s14 && (s27 ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (s27 ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign s88 = dma_fifo_wr && (
				   (s11        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (s12       && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (s13        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (s14 && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign s89 = dma_fifo_wr && (
				   (s11        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd9}))
				|| (s12       && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (s13        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (s14 && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign s90 = dma_fifo_wr && (
				   (s11        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd10}))
				|| (s12       && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd10}))
				|| (s13        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (s14 && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign s91 = dma_fifo_wr && (
				   (s11        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd11}))
				|| (s12       && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd10}))
				|| (s13        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
				|| (s14 && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign s92 = dma_fifo_wr && (
				   (s11        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (s12       && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (s13        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (s14 && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign s93 = dma_fifo_wr && (
				   (s11        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd13}))
				|| (s12       && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (s13        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (s14 && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

assign s94 = dma_fifo_wr && (
				   (s11        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd14}))
				|| (s12       && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd14}))
				|| (s13        && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd12}))
				|| (s14 && ({1'b0, s27} == {{BYTE_OFFSET_WIDTH-3{1'h0}}, 4'd8}))
	`ifdef ATCDMAC300_DATA_WIDTH_GE_256
				|| (s15   && (       s27  ==  {BYTE_OFFSET_WIDTH{1'h0}}))
	`endif
				);

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s63 <= 8'b0;
		else if (s87)
			s63 <= s79;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s64 <= 8'b0;
		else if (s88)
			s64 <= s80;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s65 <= 8'b0;
		else if (s89)
			s65 <= s81;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s66 <= 8'b0;
		else if (s90)
			s66 <= s82;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s67 <= 8'b0;
		else if (s91)
			s67 <= s83;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s68 <= 8'b0;
		else if (s92)
			s68 <= s84;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s69 <= 8'b0;
		else if (s93)
			s69 <= s85;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s70 <= 8'b0;
		else if (s94)
			s70 <= s86;
`ifdef ATCDMAC300_DATA_WIDTH_GE_256
assign s112		= (dma_fifo_wr & dma_fifo_last_wr & s144) ? s128 : s96;
assign s113		= (dma_fifo_wr & dma_fifo_last_wr & s145) ? s129 : s97;
assign s114		= (dma_fifo_wr & dma_fifo_last_wr & s146) ? s130 : s98;
assign s115		= (dma_fifo_wr & dma_fifo_last_wr & s147) ? s131 : s99;
assign s116		= (dma_fifo_wr & dma_fifo_last_wr & s148) ? s132 : s100;
assign s117		= (dma_fifo_wr & dma_fifo_last_wr & s149) ? s133 : s101;
assign s118		= (dma_fifo_wr & dma_fifo_last_wr & s150) ? s134 : s102;
assign s119		= (dma_fifo_wr & dma_fifo_last_wr & s151) ? s135 : s103;
assign s120		= (dma_fifo_wr & dma_fifo_last_wr & s152) ? s136 : s104;
assign s121		= (dma_fifo_wr & dma_fifo_last_wr & s153) ? s137 : s105;
assign s122		= (dma_fifo_wr & dma_fifo_last_wr & s154) ? s138 : s106;
assign s123		= (dma_fifo_wr & dma_fifo_last_wr & s155) ? s139 : s107;
assign s124		= (dma_fifo_wr & dma_fifo_last_wr & s156) ? s140 : s108;
assign s125		= (dma_fifo_wr & dma_fifo_last_wr & s157) ? s141 : s109;
assign s126		= (dma_fifo_wr & dma_fifo_last_wr & s158) ? s142 : s110;
assign s127		= (dma_fifo_wr & dma_fifo_last_wr & s159) ? s143 : s111;

assign s128	= (s11)				? s1[  7:  0] :
				  (s12)				? s1[ 15:  8] :
				  (s13)				? s1[ 31: 24] :
				  (s14)			? s1[ 63: 56] :
										  s1[127:120] ;

assign s129	= 						  s1[  7:  0] ;

assign s130	= (s11)				? s1[  7:  0] :
										  s1[ 15:  8] ;

assign s131	= (s11  || s12)	? s1[  7:  0] :
										  s1[ 23: 16] ;

assign s132	= (s11)				? s1[  7:  0] :
				  (s12)				? s1[ 15:  8] :
										  s1[ 31: 24] ;

assign s133	= (s11  || s12  || s13)
										? s1[  7:  0] :
										  s1[ 39: 32] ;

assign s134	= (s11)				? s1[  7:  0] :
				  (s12 || s13)		? s1[ 15:  8] :
										  s1[ 47: 40] ;

assign s135	= (s11  ||s12)		? s1[  7:  0] :
				  (s13)				? s1[ 23: 16] :
										  s1[ 55: 48] ;

assign s136	= (s11)				? s1[  7:  0] :
				  (s12)				? s1[ 15:  8] :
				  (s13)				? s1[ 31: 24] :
										  s1[ 63: 56] ;

assign s137	= (s11  || s12  || s13 || s14)
										? s1[  7:  0] :
										  s1[ 71: 64] ;

assign s138	= (s11)				? s1[  7:  0] :
				  (s12 || s13   || s14)
										? s1[ 15:  8] :
										  s1[ 79: 72] ;

assign s139	= (s11  || s12)	? s1[  7:  0] :
				  (s13  || s14)	? s1[ 23: 16] :
										  s1[ 87: 80] ;

assign s140	= (s11)				? s1[  7:  0] :
				  (s12)				? s1[ 15:  8] :
				  (s13  || s14)	? s1[ 31: 24] :
										  s1[ 95: 88] ;

assign s141	= (s11  || s12  ||s13 )
										? s1[  7:  0] :
				  (s14)			? s1[ 39: 32] :
										  s1[103: 96] ;

assign s142	= (s11)				? s1[  7:  0] :
				  (s12 || s13)		? s1[ 15:  8] :
				  (s14)			? s1[ 47: 40] :
										  s1[111:104] ;

assign s143	= (s11  ||s12)		? s1[  7:  0] :
				  (s13)				? s1[ 23: 16] :
				  (s14)			? s1[ 55: 48] :
										  s1[119:112] ;

assign s144 = dma_fifo_wr && (
				   (s11        && (s27 == {1'h0, 4'd15}))
				|| (s12       && (s27 == {1'h0, 4'd14}))
				|| (s13        && (s27 == {1'h0, 4'd12}))
				|| (s14 && (s27 == {1'h0, 4'd8}))
				|| (s15   && (s27 ==  5'h0)));

assign s145 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd16))
				|| (s12       && (s27 == 5'd16))
				|| (s13        && (s27 == 5'd16))
				|| (s14 && (s27 == 5'd16))
				|| (s15   && (s27 == 5'd16)));

assign s146 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd17))
				|| (s12       && (s27 == 5'd16))
				|| (s13        && (s27 == 5'd16))
				|| (s14 && (s27 == 5'd16))
				|| (s15   && (s27 == 5'd16)));

assign s147 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd18))
				|| (s12       && (s27 == 5'd18))
				|| (s13        && (s27 == 5'd16))
				|| (s14 && (s27 == 5'd16))
				|| (s15   && (s27 == 5'd16)));

assign s148 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd19))
				|| (s12       && (s27 == 5'd18))
				|| (s13        && (s27 == 5'd16))
				|| (s14 && (s27 == 5'd16))
				|| (s15   && (s27 == 5'd16)));

assign s149 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd20))
				|| (s12       && (s27 == 5'd20))
				|| (s13        && (s27 == 5'd20))
				|| (s14 && (s27 == 5'd16))
				|| (s15   && (s27 == 5'd16)));

assign s150 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd21))
				|| (s12       && (s27 == 5'd20))
				|| (s13        && (s27 == 5'd20))
				|| (s14 && (s27 == 5'd16))
				|| (s15   && (s27 == 5'd16)));

assign s151 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd22))
				|| (s12       && (s27 == 5'd22))
				|| (s13        && (s27 == 5'd20))
				|| (s14 && (s27 == 5'd16))
				|| (s15   && (s27 == 5'd16)));

assign s152 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd23))
				|| (s12       && (s27 == 5'd22))
				|| (s13        && (s27 == 5'd20))
				|| (s14 && (s27 == 5'd16))
				|| (s15   && (s27 == 5'd16)));

assign s153 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd24))
				|| (s12       && (s27 == 5'd24))
				|| (s13        && (s27 == 5'd24))
				|| (s14 && (s27 == 5'd24))
				|| (s15   && (s27 == 5'd16)));

assign s154 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd25))
				|| (s12       && (s27 == 5'd24))
				|| (s13        && (s27 == 5'd24))
				|| (s14 && (s27 == 5'd24))
				|| (s15   && (s27 == 5'd16)));

assign s155 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd26))
				|| (s12       && (s27 == 5'd26))
				|| (s13        && (s27 == 5'd24))
				|| (s14 && (s27 == 5'd24))
				|| (s15   && (s27 == 5'd16)));

assign s156 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd27))
				|| (s12       && (s27 == 5'd26))
				|| (s13        && (s27 == 5'd24))
				|| (s14 && (s27 == 5'd24))
				|| (s15   && (s27 == 5'd16)));

assign s157 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd28))
				|| (s12       && (s27 == 5'd28))
				|| (s13        && (s27 == 5'd28))
				|| (s14 && (s27 == 5'd24))
				|| (s15   && (s27 == 5'd16)));

assign s158 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd29))
				|| (s12       && (s27 == 5'd28))
				|| (s13        && (s27 == 5'd28))
				|| (s14 && (s27 == 5'd24))
				|| (s15   && (s27 == 5'd16)));

assign s159 = dma_fifo_wr && (
				   (s11        && (s27 == 5'd30))
				|| (s12       && (s27 == 5'd30))
				|| (s13        && (s27 == 5'd28))
				|| (s14 && (s27 == 5'd24))
				|| (s15   && (s27 == 5'd16)));

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s96 <= 8'b0;
		else if (s144)
			s96 <= s128;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s97 <= 8'b0;
		else if (s145)
			s97 <= s129;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s98 <= 8'b0;
		else if (s146)
			s98 <= s130;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s99 <= 8'b0;
		else if (s147)
			s99 <= s131;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s100 <= 8'b0;
		else if (s148)
			s100 <= s132;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s101 <= 8'b0;
		else if (s149)
			s101 <= s133;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s102 <= 8'b0;
		else if (s150)
			s102 <= s134;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s103 <= 8'b0;
		else if (s151)
			s103 <= s135;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s104 <= 8'b0;
		else if (s152)
			s104 <= s136;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s105 <= 8'b0;
		else if (s153)
			s105 <= s137;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s106 <= 8'b0;
		else if (s154)
			s106 <= s138;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s107 <= 8'b0;
		else if (s155)
			s107 <= s139;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s108 <= 8'b0;
		else if (s156)
			s108 <= s140;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s109 <= 8'b0;
		else if (s157)
			s109 <= s141;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s110 <= 8'b0;
		else if (s158)
			s110 <= s142;

	always @(posedge aclk or negedge aresetn)
		if (!aresetn)
			s111 <= 8'b0;
		else if (s159)
			s111 <= s143;
`endif
`endif
`endif

endmodule
