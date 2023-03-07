// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcdmac100_config.vh"
`include "atcdmac100_const.vh"

module atcdmac100_fifo (
                         	  hclk,
                         	  hresetn,
                         	  dma_soft_reset,
                         	  dma_fifo_wr,
                         	  dma_fifo_last_wr,
                         	  dma_fifo_last_rd,
                         	  dma_fifo_wdata,
                         	  dma_fifo_rd_size,
                         	  dma_fifo_wr_size,
                         	  dma_fifo_rd,
                         	  dma_fifo_rbyte_offset,
                         	  dma_fifo_wbyte_offset,
                         	  dma_fifo_flush,
                         	  dma_fifo_src_addr_dec,
                         	  dma_fifo_dst_addr_dec,
                         	  dma_fifo_rdata,
				  dma_idle_state
);
parameter ADDR_WIDTH 	= 32;
parameter ADDR_MSB 	= ADDR_WIDTH - 1;
parameter DATA_WIDTH 	= 32;
parameter DATA_MSB 	= DATA_WIDTH - 1;

parameter HSIZE_BYTE		= 2'b00;
parameter HSIZE_HWORD		= 2'b01;
parameter HSIZE_WORD		= 2'b10;

input          				hclk;
input          				hresetn;
input					dma_soft_reset;

input					dma_fifo_wr;
input					dma_fifo_last_wr;
input					dma_fifo_last_rd;
input	[DATA_MSB:0]			dma_fifo_wdata;
input	[1:0]				dma_fifo_rd_size;
input	[1:0]				dma_fifo_wr_size;
input					dma_fifo_rd;
input	[1:0]				dma_fifo_rbyte_offset;
input	[1:0]				dma_fifo_wbyte_offset;
input					dma_fifo_flush;
input					dma_fifo_src_addr_dec;
input					dma_fifo_dst_addr_dec;
input					dma_idle_state;

output	[DATA_MSB:0]			dma_fifo_rdata;
reg	[DATA_MSB:0]			dma_fifo_rdata;

wire					s0;

reg 	[1:0]				s1;
reg 	[1:0]				s2;
wire 	[1:0]				s3;
wire 	[1:0]				s4;
wire					s5;
wire					s6;
wire 	[1:0]				s7;
wire 	[1:0]				s8;
reg 	[7:0]				s9;
reg 	[7:0]				s10;
reg 	[7:0]				s11;
wire	[7:0]				s12;
wire	[7:0]				s13;
wire	[7:0]				s14;
wire 	[7:0]				s15;
wire 	[7:0]				s16;
wire 	[7:0]				s17;
wire 					s18;
wire 					s19;
wire 					s20;

reg	      [15:0]			s21;
wire	[DATA_MSB:0]			s22;
wire	[DATA_MSB:0]			s23;

wire					s24;
wire					s25;
wire					s26;
wire					s27;
wire					s28;
wire					s29;
wire					s30;
wire	[DATA_MSB:0]			s31;
wire	[DATA_MSB:0]			s32;
reg	[DATA_MSB:0]			s33;
wire	[DATA_MSB:0]			s34;
wire	[DATA_MSB:0]			s35;

wire					s36;
wire					s37;
wire					s38;

wire					s39;
wire					s40;
wire					s41;
wire					s42;

wire					s43;

wire	[`ATCDMAC100_FIFO_POINTER_WIDTH-1:0] s44;
wire	[`ATCDMAC100_FIFO_POINTER_WIDTH-1:0] s45;
wire	[`ATCDMAC100_FIFO_POINTER_WIDTH-1:0] s46;

wire					s47;

assign	s43		= dma_fifo_flush | dma_soft_reset;

assign	s39 	= (dma_fifo_rd_size == HSIZE_BYTE);
assign	s40 	= (dma_fifo_rd_size == HSIZE_HWORD);
assign	s41 	= (dma_fifo_rd_size == HSIZE_WORD);

assign	s4[0] = 	s41 ? 1'b0 :
				s39 ? ~s2[0] : 1'b0;
assign	s4[1] = 	s41 ? 1'b0 :
				s39 ? (s2[0] ^ s2[1]) : ~s2[1];
assign	s6    =	dma_soft_reset | (dma_fifo_rd & dma_fifo_last_rd) | dma_idle_state;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s2 <= 2'b0;
	end
	else if (s6) begin
		s2 <= 2'b0;
	end
	else if (dma_fifo_rd & ~s41) begin
		s2 <= s4;
	end
end

assign	s8 = 	s41 ?  s2 :
				s40 ? {~s2[1], s2[0]} :
						   ~s2;

assign	s7    = dma_fifo_dst_addr_dec ? s8 : s2;

assign	s42	= dma_fifo_src_addr_dec ^ dma_fifo_dst_addr_dec;
assign	s35	= s25 ? s31 : s32;
assign	s34	= s42 ? {s35[7:0], s35[15:8], s35[23:16], s35[31:24]} : s35;

always @(*) begin
	case (s7)
		2'b01: begin
			s33[31:24] 	= s34[7:0];
			s33[23:0] 	= s34[31:8];
		end
		2'b10: begin
			s33[31:16] 	= s34[15:0];
			s33[15:0] 	= s34[31:16];
		end
		2'b11: begin
			s33[31:8] 	= s34[23:0];
			s33[7:0] 	= s34[31:24];
		end
		default: begin
			s33 		= s34[31:0];
		end
	endcase
end

always @(*) begin
	case (dma_fifo_rbyte_offset)
		2'b01: begin
			dma_fifo_rdata[31:8]	= s33[23:0];
			dma_fifo_rdata[7:0] 	= s33[31:24];
		end
		2'b10: begin
			dma_fifo_rdata[31:16] 	= s33[15:0];
			dma_fifo_rdata[15:0] 	= s33[31:16];
		end
		2'b11: begin
			dma_fifo_rdata[31:24] 	= s33[7:0];
			dma_fifo_rdata[23:0] 	= s33[31:8];
		end
		default: begin
			dma_fifo_rdata 		= s33;
		end
	endcase
end

assign	s36 	= (dma_fifo_wr_size == HSIZE_BYTE);
assign	s37 	= (dma_fifo_wr_size == HSIZE_HWORD);
assign	s38 	= (dma_fifo_wr_size == HSIZE_WORD);

assign	s3[0] = 	s38 ? 1'b0 :
				s36 ? ~s1[0] : 1'b0;
assign	s3[1] = 	s38 ? 1'b0 :
				s36 ? (s1[0] ^ s1[1]) : ~s1[1];
assign	s5    =	dma_soft_reset | (dma_fifo_wr & s24) | dma_idle_state;

assign s24 = s0 | dma_fifo_last_wr;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s1 <= 2'b0;
	end
	else if (s5) begin
		s1 <= 2'b0;
	end
	else if (dma_fifo_wr & ~s38) begin
		s1 <= s3;
	end
end

always @(*) begin
	case (dma_fifo_wbyte_offset)
		2'b01: begin
			s21	 	= dma_fifo_wdata[23:8];
		end
		2'b10: begin
			s21	 	= dma_fifo_wdata[31:16];
		end
		2'b11: begin
			s21[15:8] 	= dma_fifo_wdata[ 7: 0];
			s21[ 7:0] 	= dma_fifo_wdata[31:24];
		end
		default: begin
			s21 		= dma_fifo_wdata[15: 0];
		end
	endcase
end

assign s15 = s21[7:0];
assign s16 = s36 ? s21[7:0] : s21[15:8];
assign s17 = s21[7:0];

assign s18 = dma_fifo_wr & (s36 | s37) & (s1 == 2'b00);
assign s19 = dma_fifo_wr & ((s36 & (s1 == 2'b01)) |
			   (s37 & (s1 == 2'b00)));
assign s20 = dma_fifo_wr & (s36 & (s1 == 2'b10));

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s9 <= 8'b0;
	end
	else if (s18) begin
		s9 <= s15;
	end

end
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s10 <= 8'b0;
	end
	else if (s19) begin
		s10 <= s16;
	end

end
always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
		s11 <= 8'b0;
	end
	else if (s20) begin
		s11 <= s17;
	end

end

assign s12 = (dma_fifo_wr & dma_fifo_last_wr & s18) ? s15 : s9;
assign s13 = (dma_fifo_wr & dma_fifo_last_wr & s19) ? s16 : s10;
assign s14 = (dma_fifo_wr & dma_fifo_last_wr & s20) ? s17 : s11;

assign s22 = dma_fifo_src_addr_dec ? {s13, s12, s21[15:0]} :
					 {s21[15:0], s13, s12};
assign s23  = dma_fifo_src_addr_dec ? {s12, s13, s14, s21[7:0]} :
					 {s21[7:0], s14, s13, s12};

assign s31 = s38  ? dma_fifo_wdata :
		    s37 ? s22 :
		    			s23;

assign s46 = s44 + {{(`ATCDMAC100_FIFO_POINTER_WIDTH-1){1'b0}}, 1'b1};

assign s47 = 	(s38 | dma_fifo_last_wr |
			(s37 & (s1 == 2'b10)) |
			(s36 & (s1 == 2'b11)));

assign s0 =	s47 & (s45 == {~s46[`ATCDMAC100_FIFO_POINTER_WIDTH-1], s46[`ATCDMAC100_FIFO_POINTER_WIDTH-2:0]});

assign s26 = dma_fifo_last_wr & dma_fifo_rd & dma_fifo_last_rd & s29;
assign s25 = dma_fifo_wr & s47 & s29;

assign s27 = dma_fifo_wr & s47 & ~s26;

assign s28 = dma_fifo_rd & ~s29 & (dma_fifo_last_rd | s41 |
		(s40 & (s2 == 2'b10)) |
		(s39 & (s2 == 2'b11)));


nds_sync_fifo_clr #(
        .DATA_WIDTH (DATA_WIDTH),
	.FIFO_DEPTH ({26'b0, `ATCDMAC100_FIFO_DEPTH}),
        .POINTER_INDEX_WIDTH (`ATCDMAC100_FIFO_POINTER_WIDTH)
) nds_sync_fifo_clr (
	.reset_n(hresetn),
	.clk(hclk),
	.wr(s27),
	.wr_data(s31),
	.rd(s28),
	.rd_data(s32),
	.empty(s29),
	.full(s30),
	.wr_ptr(s44),
	.rd_ptr(s45),
	.fifo_clr(s43)
);

endmodule
