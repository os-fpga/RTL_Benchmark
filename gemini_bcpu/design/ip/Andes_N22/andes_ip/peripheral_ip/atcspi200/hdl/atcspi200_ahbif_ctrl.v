// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcspi200_config.vh"
`include "atcspi200_const.vh"

module atcspi200_ahbif_ctrl (
	  hresetn,
	  hclk,
	  hsel,
	  hwrite,
	  haddr,
	  htrans,
	  hreadyin,
	  hreadyout,
	  hrdata,
	  hresp,
`ifdef ATCSPI200_HSPLIT_SUPPORT
	  hmaster,
	  hsplit,
`endif
	  ahb_spi_busy,
	  ahb_spi_req,
	  ahb_rxf_empty,
	  ahb_rxf_rd_data,
	  ahb_rxf_rd,
	  ahb_addr_latched,
	  ahb_other_req,
	  ahb_spi_addr,
	  ahb_cmd_chg,
	  mem_intf_idle_clr_regclk,
	  reg_mem_idle_clr_sysclk,
	  ahb_mem_idle_regclk
);

`ifdef ATCSPI200_ADDR_WIDTH_24
	parameter	AHB_SPI_ADDR_MSB = 23;
`elsif ATCSPI200_SPI_ADDR_WIDTH_24
	parameter	AHB_SPI_ADDR_MSB = 23;
`else
	parameter	AHB_SPI_ADDR_MSB = 31;
`endif


input		hresetn;
input		hclk;
input		hsel;
input		hwrite;
input	[`ATCSPI200_HADDR_WIDTH-1:0]   haddr;
input	[1:0]	htrans;
input		hreadyin;
output		hreadyout;
output	[31:0]	hrdata;
output	[1:0]	hresp;
`ifdef ATCSPI200_HSPLIT_SUPPORT
	input  [`ATCSPI200_HMASTER_BIT-1:0] hmaster;
	output [`ATCSPI200_HSPLIT_BIT-1:0]  hsplit;
`endif

input		ahb_spi_busy;
output		ahb_spi_req;
input		ahb_rxf_empty;
input	[31:0]	ahb_rxf_rd_data;
output		ahb_rxf_rd;
input		ahb_addr_latched;
input		ahb_other_req;

output	[31:0]	ahb_spi_addr;
input		ahb_cmd_chg;
input		mem_intf_idle_clr_regclk;
input		reg_mem_idle_clr_sysclk;
output		ahb_mem_idle_regclk;


wire            s0;
wire            s1;
wire            s2;
wire            s3;
wire            s4;
wire            s5;
wire            s6;
wire		s7;

wire            s8;

`ifdef ATCSPI200_HSPLIT_SUPPORT
	wire            s9, s10;
	reg             s11, s12;
	wire            s13;

	wire [`ATCSPI200_HSPLIT_BIT-1:0] s14;
	reg  [`ATCSPI200_HSPLIT_BIT-1:0] s15, s16;
	reg  [`ATCSPI200_HADDR_WIDTH-1:2]      s17, s18;
	reg  [31:0]      s19, s20;
	reg              s21, s22;
	reg              s23;

	wire            s24;
`endif

wire            s25;
wire            s26;

reg [2:0]       s27, s28;
reg [2:0]       s29, s30;
reg [1:0]	s31, s32;

wire            s33;
wire            s34;

reg  [AHB_SPI_ADDR_MSB:2]     s35;

wire            hreadyout;
wire [31:0]     hrdata;
wire [1:0]      hresp;
wire		s36;
reg  [AHB_SPI_ADDR_MSB:2]	s37;
reg		s38;
localparam	SPI_IDLE  	= 3'h0,
		SPI_RDATA 	= 3'h1,
		SPI_RHOLD 	= 3'h3,
		SPI_WADDR 	= 3'h4,
		SPI_WDATA 	= 3'h5;

localparam	MEM_CLR_IDLE  	= 2'h0,
		MEM_CLR_BUSY 	= 2'h1,
		MEM_RHOLD 	= 2'h2;


assign s0 = hsel & ((htrans == 2'b10) | (htrans == 2'b11));
assign ahb_mem_idle_regclk	= s38;

assign s1    	= s0 & hreadyin;
assign s2     	= s1 & ~hwrite;
assign s36	= (s31 == MEM_RHOLD);
assign s3 	= reg_mem_idle_clr_sysclk ? 1'b0 : (s36 | s2);
assign s4 	= 1'b0;
assign s5 = s1 & hwrite;


assign s6 = ((haddr[AHB_SPI_ADDR_MSB:2] == s35[AHB_SPI_ADDR_MSB:2]) & ~hwrite & s1) |
		       ((s32 == MEM_CLR_IDLE) & s36 & (s37[AHB_SPI_ADDR_MSB:2] == s35[AHB_SPI_ADDR_MSB:2]));

`ifdef ATCSPI200_HSPLIT_SUPPORT
	assign s9 = (haddr[`ATCSPI200_HADDR_MSB:2] == s17[`ATCSPI200_HADDR_MSB:2]) & s21;
	assign s10 = (haddr[`ATCSPI200_HADDR_MSB:2] == s18[`ATCSPI200_HADDR_MSB:2]) & s22;
	assign s8  = s9 | s10;
	assign s13    = s11 | s12;
`else
	assign s8 = 1'b0;
`endif


`ifdef ATCSPI200_HSPLIT_SUPPORT
	localparam	AHB_IDLE   = 3'h0,
			AHB_READ   = 3'h1,
			AHB_WRITE  = 3'h2,
			AHB_SDATA1 = 3'h4,
			AHB_SDATA2 = 3'h5,
			AHB_WAIT   = 3'h7,
			AHB_ERR1   = 3'h3,
			AHB_ERR2   = 3'h6;

	always @(*)
	begin
		case(s27)
			AHB_READ: begin
				if (s3 & s8)
					s28 = AHB_READ;
				else if (s4 & s24)
					s28 = AHB_ERR1;
				else if (s3 & ~s8)
					s28 = AHB_SDATA1;
				else if (s4 & ~s24)
					s28 = AHB_SDATA1;
				else
					s28 = AHB_IDLE;
			end
			AHB_ERR1: begin
				s28 = AHB_ERR2;
			end
			AHB_ERR2: begin
				if (s3)
					s28 = AHB_READ;
				else if (s5)
					s28 = AHB_ERR1;
				else
					s28 = AHB_IDLE;
			end
			AHB_WRITE: begin
				if (s3 & s8)
					s28 = AHB_READ;
				else if (s4 & s24)
					s28 = AHB_WRITE;
				else if (s3 & ~s8)
					s28 = AHB_SDATA1;
				else if (s4 & ~s24)
					s28 = AHB_SDATA1;
				else
					s28 = AHB_IDLE;
			end
			AHB_SDATA1: begin
				s28 = AHB_SDATA2;
			end
			AHB_SDATA2: begin
				s28 = AHB_WAIT;
			end
			AHB_WAIT: begin
				if (s7 | ahb_rxf_rd | (s29 == SPI_RHOLD) | (s29 == SPI_IDLE)) begin
					if (s3 & s8)
						s28 = AHB_READ;
					else if (s4 & s24)
						s28 = AHB_ERR1;
					else if (s3 & ~s8)
						s28 = AHB_SDATA1;
					else if (s4 & ~s24)
						s28 = AHB_SDATA1;
					else
						s28 = AHB_IDLE;
				end
				else begin
					if (s3 & ~s8)
						s28 = AHB_SDATA1;
					else if (s4)
						s28 = AHB_SDATA1;
					else if (s3 & s8)
						s28 = AHB_WAIT;
					else
						s28 = AHB_WAIT;
				end
			end
			default : begin
				if (s3 & s8)
					s28 = AHB_READ;
				else if (s4 & s24)
					s28 = AHB_ERR1;
				else if (s3 & ~s8)
					s28 = AHB_SDATA1;
				else if (s4 & ~s24)
					s28 = AHB_SDATA1;
				else
					s28 = AHB_IDLE;
			end
		endcase
	end

	assign s25 = 1'b0;
	assign s26 = s27 == AHB_SDATA1;
	assign s24 = ~( (s29 == SPI_WADDR) | ((s29 == SPI_WDATA) & ~s7) | ((s29 == SPI_RDATA) & ~ahb_rxf_rd) |
				((s29 == SPI_IDLE) & ((s27 == AHB_WRITE) | (s27 == AHB_SDATA1) | (s27 == AHB_SDATA2))) );

	always @(negedge hresetn or posedge hclk)
	begin
		if (!hresetn) begin
			s11 <= 1'b0;
			s12 <= 1'b0;
		end
		else begin
			s11 <= s9;
			s12 <= s10;
		end
	end

	assign s14 = (1<<hmaster);

	always @(negedge hresetn or posedge hclk)
	begin
		if (!hresetn)
			s15 <= {(`ATCSPI200_HSPLIT_BIT){1'b0}};
		else if ((s3 & ~s8) | (s4 & ~s24))
			s15 <= (s15 | s14);
	end

	always @(negedge hresetn or posedge hclk)
	begin
		if (~hresetn)
			split_addr_0_r <= {(`ATCSPI200_HADDR_WIDTH-2){1'b0}};
		else if (s3 & ~s8 & (s23 == 1'b0))
			s17 <= haddr[`ATCSPI200_HADDR_MSB:2];
	end

	always @(negedge hresetn or posedge hclk)
	begin
		if (!hresetn)
			s18 <= {(`ATCSPI200_HADDR_WIDTH-2){1'b0}};
		else if (s3 & ~s8 & (s23 == 1'b1))
			s18 <= haddr[`ATCSPI200_HADDR_MSB:2];
	end

	always @(negedge hresetn or posedge hclk)
	begin
		if (!hresetn)
			s19 <= 32'b0;
		else if ((s27 == AHB_WAIT) & ahb_rxf_rd & (s23 == 1'b0))
			s19 <= ahb_rxf_rd_data;
	end

	always @(negedge hresetn or posedge hclk)
	begin
		if (!hresetn)
			s20 <= 32'h0;
		else if ((s27 == AHB_WAIT) & ahb_rxf_rd & (s23 == 1'b1))
			s20 <= ahb_rxf_rd_data;
	end

	always @(negedge hresetn or posedge hclk)
	begin
		if (!hresetn)
			s21 <= 1'b0;
		else if (s3 & ~s8 & (s23 == 1'b0))
			s21 <= 1'b0;
		else if ((s27 == AHB_WAIT) & ahb_rxf_rd & (s23 == 1'b0))
			s21 <= 1'b1;
	end

	always @(negedge hresetn or posedge hclk)
	begin
		if (!hresetn)
			s22 <= 1'b0;
		else if (s3 & ~s8 & (s23 == 1'b1))
			s22 <= 1'b0;
		else if ((s27 == AHB_WAIT) & ahb_rxf_rd & (s23 == 1'b1))
			s22 <= 1'b1;
	end

	always @(*)
	begin
		if (!hresetn)
			s23 <= 1'b0;
		else if ((s27 == AHB_WAIT) & ahb_rxf_rd)
			s23 <= ~s23;
		else
			s23 <= s23;
	end

`else

	localparam	AHB_IDLE  = 3'h0,
			AHB_READ  = 3'h1,
			AHB_ERR1  = 3'h2,
			AHB_ERR2  = 3'h3,
			AHB_WRITE = 3'h4,
			AHB_WW    = 3'h6,
			AHB_WR    = 3'h5;

	always @(*)
	begin
		case(s27)
			AHB_READ: begin
				if (ahb_rxf_rd) begin
					if (s3)
						s28 = AHB_READ;
					else if (s5)
						s28 = AHB_ERR1;
					else
						s28 = AHB_IDLE;
				end
				else
					s28 = AHB_READ;
			end
			AHB_ERR1: begin
				s28 = AHB_ERR2;
			end
			AHB_WRITE: begin
				if (s29 == SPI_WDATA) begin
					if (s7) begin
						if (s3)
							s28 = AHB_READ;
						else if (s4)
							s28 = AHB_WRITE;
						else
							s28 = AHB_IDLE;
					end
					else begin
						if (s3)
							s28 = AHB_WR;
						else if (s4)
							s28 = AHB_WW;
						else
							s28 = AHB_WRITE;
					end
				end
				else
					s28 = AHB_WRITE;
			end
			AHB_ERR2: begin
				if (s3)
					s28 = AHB_READ;
				else if (s5)
					s28 = AHB_ERR1;
				else
					s28 = AHB_IDLE;
			end
			AHB_WW: begin
				if (s7)
					s28 = AHB_WRITE;
				else
					s28 = AHB_WW;
			end
			AHB_WR: begin
				if (s7)
					s28 = AHB_READ;
				else
					s28 = AHB_WR;
			end
			default : begin
				if (s3)
					s28 = AHB_READ;
				else if (s5)
					s28 = AHB_ERR1;
				else
					s28 = AHB_IDLE;
			end
		endcase
	end

	assign s25  = 1'b0;
	assign s26  = (s27 == AHB_READ);

`endif

always @(negedge hresetn or posedge hclk)
begin
	if (!hresetn)
		s27 <= AHB_IDLE;
	else
		s27 <= s28;
end

always @(negedge hresetn or posedge hclk)
begin
	if (!hresetn) begin
		s37 <= {(AHB_SPI_ADDR_MSB-1){1'b0}};
	end
	else if (s2) begin
		s37 <= haddr[AHB_SPI_ADDR_MSB:2];
	end
end




`ifdef ATCSPI200_HSPLIT_SUPPORT
	assign hreadyout = ((s27 != AHB_SDATA1) & (s27 != AHB_ERR1)) & ~s36;
	assign hrdata = s12 ? s20 : s19;
	assign hresp = ((s27 == AHB_SDATA1) | (s27 == AHB_SDATA2)) ? 2'b11 : ((s27 == AHB_ERR1) | (s27 == AHB_ERR2)) ? 2'b01 : 2'b00;
	assign hsplit = ( (s27 == AHB_WAIT) & (s7 | ahb_rxf_rd | (s29 == SPI_RHOLD) | (s29 == SPI_IDLE)) ) ? s15 : {(`ATCSPI200_HSPLIT_BIT){1'b0}};
`else
	assign hreadyout = ((s27 == AHB_IDLE) | (s27 == AHB_ERR2) | ((s27 == AHB_READ) & ahb_rxf_rd)) & ~s36;
	assign hrdata = ahb_rxf_rd_data;
	assign hresp = ((s27 == AHB_ERR1) | (s27 == AHB_ERR2)) ? 2'b01 : 2'b00;
`endif


always @(*)
begin
	s32 = s31;
	case(s31)
		MEM_CLR_BUSY: begin
			if (!reg_mem_idle_clr_sysclk)
				s32 = MEM_CLR_IDLE;
			else if (s2)
				s32 = MEM_RHOLD;
			else if ((s27 == AHB_READ) && !ahb_rxf_rd)
				s32 = MEM_RHOLD;
		end
		MEM_RHOLD: begin
			if (!reg_mem_idle_clr_sysclk)
				s32 = MEM_CLR_IDLE;
		end
		default: begin
			if (reg_mem_idle_clr_sysclk && !s2)
				s32 = MEM_CLR_BUSY;
			else if (reg_mem_idle_clr_sysclk && s2)
				s32 = MEM_RHOLD;
		end

	endcase
end

always @(negedge hresetn or posedge hclk)
begin
	if (!hresetn)
		s31 <= MEM_CLR_IDLE;
	else
		s31 <= s32;
end



always @(*)
begin
	s30 = s29;
	case(s29)
		SPI_WADDR: begin
			if (ahb_addr_latched)
				s30 = SPI_WDATA;
		end
		SPI_WDATA: begin
			if (s7)
				s30 = SPI_IDLE;
		end
		SPI_RDATA: begin
			if (ahb_rxf_rd) begin
				if (s3 & ~s8 & s6)
					s30 = SPI_RDATA;
				else if (s3 & ~s8 & ~s6)
					s30 = SPI_IDLE;
				else if (ahb_other_req | ahb_cmd_chg | s4)
					s30 = SPI_IDLE;
				else
					s30 = SPI_RHOLD;
			end
		end
		SPI_RHOLD: begin
			if (s3 & ~s8 & s6)
				s30 = SPI_RDATA;
			else if (s3 & ~s8 & ~s6)
				s30 = SPI_IDLE;
			else if (ahb_other_req || ahb_cmd_chg || s4 || mem_intf_idle_clr_regclk)
				s30 = SPI_IDLE;
		end
		default: begin
			if (~ahb_spi_busy) begin
				if (s25)
					s30 = SPI_WADDR;
				else if (s26)
					s30 = SPI_RDATA;
				else if (s4)
					s30 = SPI_WADDR;
				else if (s3)
					s30 = SPI_RDATA;
			end
		end
	endcase
end

always @(negedge hresetn or posedge hclk)
begin
	if (!hresetn)
		s29 <= SPI_IDLE;
	else
		s29 <= s30;
end


assign s33 = ((s29 == SPI_IDLE)  & (s27 == AHB_IDLE | (s27 == AHB_ERR2 & s3))  & (s4 | (s3 & ~s8))) |
`ifdef ATCSPI200_HSPLIT_SUPPORT
	((s29 == SPI_IDLE)  & (s27 == AHB_READ)  & (s4 | (s3 & ~s8))) |
	((s29 == SPI_IDLE)  & (s27 == AHB_WAIT)  & (s4 | (s3 & ~s8))) |
	((s29 == SPI_WDATA) & s7              & (s4 | (s3 & ~s8))) |
	((s29 == SPI_RDATA) & ahb_rxf_rd              & (s4 | (s3 & ~s8 & ~s6))) |
`else
	((s29 == SPI_WDATA) & (s27 == AHB_WRITE) & (s4 | (s3))) |
	((s29 == SPI_RDATA) & (s27 == AHB_READ)  & (s4 | (s3 & ~s6))) |
`endif
((s29 == SPI_RHOLD)                                & (s4 | (s3 & ~s8 & ~s6)));

assign s34 = ((s29 == SPI_RDATA) & ahb_addr_latched) |
			((s29 == SPI_RDATA) & ahb_rxf_rd & s3 & ~s8 & s6) |
			((s29 == SPI_RHOLD)              & s3 & ~s8 & s6);



always @(negedge hresetn or posedge hclk)
begin
	if (!hresetn)
		s35 <= {(AHB_SPI_ADDR_MSB-1){1'b0}};
	else if (s33 && !s36)
		s35 <= haddr[AHB_SPI_ADDR_MSB:2];
	else if (s33 && s36)
		s35 <= s37[AHB_SPI_ADDR_MSB:2];
	else if (s34)
		s35 <= s35 + {{(AHB_SPI_ADDR_MSB-2){1'b0}}, 1'b1};
end

`ifdef ATCSPI200_SPI_ADDR_WIDTH_24
	assign ahb_spi_addr = {8'b0, s35[AHB_SPI_ADDR_MSB:2], 2'b0};
`elsif ATCSPI200_ADDR_WIDTH_24
	assign ahb_spi_addr = {8'b0, s35[AHB_SPI_ADDR_MSB:2], 2'b0};
`else
	assign ahb_spi_addr = {s35[AHB_SPI_ADDR_MSB:2], 2'b0};
`endif

always @(negedge hresetn or posedge hclk)
begin
	if (!hresetn)
		s38 <= 1'b0;
	else
		s38 <= (htrans == 2'b0);
end



assign ahb_spi_req = s29 != SPI_IDLE;
assign s7 = 1'b0;
`ifdef ATCSPI200_HSPLIT_SUPPORT
	assign ahb_rxf_rd = (s27 == AHB_WAIT) & !ahb_rxf_empty & (s29 == SPI_RDATA);
`else
	assign ahb_rxf_rd = (s27 == AHB_READ) & !ahb_rxf_empty & (s29 == SPI_RDATA);
`endif

endmodule

