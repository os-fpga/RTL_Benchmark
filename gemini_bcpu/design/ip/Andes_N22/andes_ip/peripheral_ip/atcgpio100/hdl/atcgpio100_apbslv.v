// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary


`include "atcgpio100_config.vh"
`include "atcgpio100_const.vh"

module atcgpio100_apbslv(
                          	  pclk,
                          	  presetn,
                          	  psel,
                          	  penable,
                          	  pwrite,
                          	  paddr,
                          	  pwdata,
                          	  prdata,
                          `ifdef ATCGPIO100_PULL_SUPPORT
                          	  gpio_pullup,
                          	  gpio_pulldown,
                          `endif
                          `ifdef ATCGPIO100_INTR_SUPPORT
                          	  gpio_ch_intr_trg,
                          	  gpio_intr_en,
                          	  gpio_intr_mode_b0,
                          	  gpio_intr_mode_b1,
                          	  gpio_intr_mode_b2,
                          	  gpio_intr,
                          `endif
                          `ifdef ATCGPIO100_DEBOUNCE_SUPPORT
                          	  gpio_db_en,
                          	  gpio_db_scale,
                          	  gpio_db_clk,
                          `endif
                          	  gpio_din,
                          	  gpio_out,
                          	  gpio_oe,
                          	  gpio_in_en
);

parameter GPIO_MSB = `ATCGPIO100_GPIO_NUM - 1;
parameter GPIO_C0  = 33 - `ATCGPIO100_GPIO_NUM;

input          		pclk;
input          		presetn;
input          		psel;
input          		penable;
input          		pwrite;
input 	[7:0] 		paddr;
input 	[31:0] 		pwdata;
output  [31:0] 		prdata;

`ifdef ATCGPIO100_PULL_SUPPORT
output 	[GPIO_MSB:0] 	gpio_pullup;
output 	[GPIO_MSB:0] 	gpio_pulldown;
`endif
`ifdef ATCGPIO100_INTR_SUPPORT
input  	[GPIO_MSB:0] 	gpio_ch_intr_trg;
output 	[GPIO_MSB:0] 	gpio_intr_en;
output 	[GPIO_MSB:0] 	gpio_intr_mode_b0;
output 	[GPIO_MSB:0] 	gpio_intr_mode_b1;
output 	[GPIO_MSB:0] 	gpio_intr_mode_b2;
output         	    	gpio_intr;
`endif
`ifdef ATCGPIO100_DEBOUNCE_SUPPORT
output 	[GPIO_MSB:0] 	gpio_db_en;
output  [7:0] 		gpio_db_scale;
output              	gpio_db_clk;
`endif

input  	[GPIO_MSB:0] 	gpio_din;
output 	[GPIO_MSB:0] 	gpio_out;
output 	[GPIO_MSB:0] 	gpio_oe;
output 	[GPIO_MSB:0] 	gpio_in_en;

wire	[31:0] 		prdata;
wire	[5:0] 		gpio_num;
wire                	gpio_out_sel;
wire	[GPIO_MSB:0] 	gpio_out_nx;

wire                	id_sel;
wire                	config_sel;
wire                	gpio_din_sel;
wire                	gpio_do_sel;
wire                	gpio_chdir_sel;
wire                	gpio_do0_sel;
wire                	gpio_do1_sel;
`ifdef ATCGPIO100_PULL_SUPPORT
wire                	gpio_pull_en_sel;
wire                	gpio_pull_mode_sel;
`endif
`ifdef ATCGPIO100_INTR_SUPPORT
wire		    	gpio_intr_en_sel;
wire                	gpio_ch0_7_intr_mode_sel;
wire                	gpio_ch8_15_intr_mode_sel;
wire           	    	gpio_ch16_23_intr_mode_sel;
wire                	gpio_ch24_31_intr_mode_sel;
wire                	gpio_intr_sel;
`endif
`ifdef ATCGPIO100_DEBOUNCE_SUPPORT
wire                	gpio_db_en_sel;
wire                	gpio_db_ctl_sel;
`endif

reg 	[GPIO_MSB:0] 	gpio_out;
reg 	[GPIO_MSB:0] 	gpio_chdir;

`ifdef ATCGPIO100_PULL_SUPPORT
reg 	[GPIO_MSB:0] 	gpio_pull_en;
reg 	[GPIO_MSB:0] 	gpio_pull_mode;
`endif
`ifdef ATCGPIO100_INTR_SUPPORT
reg	[GPIO_MSB:0]	gpio_intr_en;
reg 	[GPIO_MSB:0] 	gpio_intr_mode_b0;
reg 	[GPIO_MSB:0] 	gpio_intr_mode_b1;
reg 	[GPIO_MSB:0] 	gpio_intr_mode_b2;
reg     [127:0] 	gpio_intr_mode_prdata;
reg    	[GPIO_MSB:0] 	gpio_ch_intr;
reg    	[GPIO_MSB:0] 	gpio_ch_intr_nx;
`endif
`ifdef ATCGPIO100_DEBOUNCE_SUPPORT
reg     [7:0] 		gpio_db_scale;
reg              	gpio_db_clk;
reg 	[GPIO_MSB:0] 	gpio_db_en;
`endif

assign gpio_num   	= 6'd`ATCGPIO100_GPIO_NUM;

assign gpio_oe 		= gpio_chdir;
assign gpio_in_en 	= ~gpio_chdir;

`ifdef ATCGPIO100_INTR_SUPPORT
assign gpio_intr 	= |gpio_ch_intr[GPIO_MSB:0];
`endif

`ifdef ATCGPIO100_PULL_SUPPORT
assign gpio_pullup   	= gpio_pull_en & ~gpio_pull_mode;
assign gpio_pulldown 	= gpio_pull_en & gpio_pull_mode;
`endif

assign id_sel          			= psel & (paddr[7:2]==6'b0000_00);
assign config_sel      			= psel & (paddr[7:2]==6'b0001_00);
assign gpio_din_sel               	= psel & (paddr[7:2]==6'b0010_00);
assign gpio_do_sel                	= psel & (paddr[7:2]==6'b0010_01);
assign gpio_chdir_sel            	= psel & (paddr[7:2]==6'b0010_10);
assign gpio_do0_sel               	= psel & (paddr[7:2]==6'b0010_11);
assign gpio_do1_sel               	= psel & (paddr[7:2]==6'b0011_00);

`ifdef ATCGPIO100_PULL_SUPPORT
assign gpio_pull_en_sel			= psel & (paddr[7:2]==6'b0100_00);
assign gpio_pull_mode_sel		= psel & (paddr[7:2]==6'b0100_01);
`endif

`ifdef ATCGPIO100_INTR_SUPPORT
assign gpio_intr_en_sel   		= psel & (paddr[7:2]==6'b0101_00);
assign gpio_ch0_7_intr_mode_sel   	= psel & (paddr[7:2]==6'b0101_01);
assign gpio_ch8_15_intr_mode_sel  	= psel & (paddr[7:2]==6'b0101_10);
assign gpio_ch16_23_intr_mode_sel 	= psel & (paddr[7:2]==6'b0101_11);
assign gpio_ch24_31_intr_mode_sel 	= psel & (paddr[7:2]==6'b0110_00);
assign gpio_intr_sel              	= psel & (paddr[7:2]==6'b0110_01);
`endif

`ifdef ATCGPIO100_DEBOUNCE_SUPPORT
assign gpio_db_en_sel             	= psel & (paddr[7:2]==6'b0111_00);
assign gpio_db_ctl_sel            	= psel & (paddr[7:2]==6'b0111_01);
`endif



assign gpio_out_sel = gpio_do_sel | gpio_do0_sel | gpio_do1_sel;

assign gpio_out_nx = (pwdata[GPIO_MSB:0] & {`ATCGPIO100_GPIO_NUM{gpio_do_sel}}) |
                     ((~pwdata[GPIO_MSB:0]) & gpio_out & {`ATCGPIO100_GPIO_NUM{gpio_do0_sel}}) |
                     ((pwdata[GPIO_MSB:0] | gpio_out) & {`ATCGPIO100_GPIO_NUM{gpio_do1_sel}});

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
        	gpio_out <= {`ATCGPIO100_GPIO_NUM{1'b0}};
	end
    	else if (penable & pwrite & gpio_out_sel) begin
        	gpio_out <= gpio_out_nx;
	end
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
        	gpio_chdir <= {`ATCGPIO100_GPIO_NUM{1'b0}};
	end
    	else if (penable & pwrite & gpio_chdir_sel) begin
        	gpio_chdir <= pwdata[GPIO_MSB:0];
	end
end

`ifdef ATCGPIO100_PULL_SUPPORT
always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
		gpio_pull_en <= {`ATCGPIO100_GPIO_NUM{1'b0}};
    	end
    	else if (penable & pwrite & gpio_pull_en_sel) begin
        	gpio_pull_en <= pwdata[GPIO_MSB:0];
    	end
end

always @(posedge pclk or negedge presetn) begin
    	if (~presetn) begin
        	gpio_pull_mode <= {`ATCGPIO100_GPIO_NUM{1'b0}};
    	end
    	else if (penable & pwrite & gpio_pull_mode_sel) begin
        	gpio_pull_mode <= pwdata[GPIO_MSB:0];
    	end
end
`endif

`ifdef ATCGPIO100_INTR_SUPPORT
integer i0;
integer i1;
integer i2;
integer i3;
integer i4;
integer i5;

always @(posedge pclk or negedge presetn) begin
    	if (~presetn) begin
        	gpio_intr_en <= {`ATCGPIO100_GPIO_NUM{1'b0}};
    	end
    	else if (penable & pwrite & gpio_intr_en_sel) begin
        	gpio_intr_en <= pwdata[GPIO_MSB:0];
    	end
end

always @(posedge pclk or negedge presetn) begin
    	if (~presetn) begin
        	gpio_intr_mode_b0 <= {`ATCGPIO100_GPIO_NUM{1'b0}};
        	gpio_intr_mode_b1 <= {`ATCGPIO100_GPIO_NUM{1'b0}};
        	gpio_intr_mode_b2 <= {`ATCGPIO100_GPIO_NUM{1'b0}};
    	end
    	else if (penable & pwrite & gpio_ch0_7_intr_mode_sel) begin
        	for(i0 = 0; (i0 < 8) && (i0 < `ATCGPIO100_GPIO_NUM); i0 = i0 + 1) begin
            		gpio_intr_mode_b0[i0] <= pwdata[i0*4];
            		gpio_intr_mode_b1[i0] <= pwdata[i0*4+1];
            		gpio_intr_mode_b2[i0] <= pwdata[i0*4+2];
        	end
    	end
    	else if (penable & pwrite & gpio_ch8_15_intr_mode_sel) begin
        	for(i1 = 8; (i1 < 16) && (i1 < `ATCGPIO100_GPIO_NUM); i1 = i1 + 1) begin
            		gpio_intr_mode_b0[i1] <= pwdata[(i1-8)*4];
            		gpio_intr_mode_b1[i1] <= pwdata[(i1-8)*4+1];
            		gpio_intr_mode_b2[i1] <= pwdata[(i1-8)*4+2];
        	end
    	end
    	else if (penable & pwrite & gpio_ch16_23_intr_mode_sel) begin
        	for(i2 = 16; (i2 < 24) && (i2 < `ATCGPIO100_GPIO_NUM); i2 = i2 + 1) begin
            		gpio_intr_mode_b0[i2] <= pwdata[(i2-16)*4];
            		gpio_intr_mode_b1[i2] <= pwdata[(i2-16)*4+1];
            		gpio_intr_mode_b2[i2] <= pwdata[(i2-16)*4+2];
        	end
    	end
    	else if (penable & pwrite & gpio_ch24_31_intr_mode_sel) begin
        	for(i3 = 24; (i3 < 32) && (i3 < `ATCGPIO100_GPIO_NUM); i3 = i3 + 1) begin
            		gpio_intr_mode_b0[i3] <= pwdata[(i3-24)*4];
            		gpio_intr_mode_b1[i3] <= pwdata[(i3-24)*4+1];
            		gpio_intr_mode_b2[i3] <= pwdata[(i3-24)*4+2];
        	end
    	end
end

always @(*) begin
	for (i4 = 0; i4 < 32; i4 = i4 + 1) begin
        	if (i4 < `ATCGPIO100_GPIO_NUM) begin
            		gpio_intr_mode_prdata[i4*4+:4] = {1'b0, gpio_intr_mode_b2[i4], gpio_intr_mode_b1[i4], gpio_intr_mode_b0[i4]};
		end
		else begin
           		gpio_intr_mode_prdata[i4*4+:4] = 4'b0;
		end
    	end
end

always @ (*) begin
	for (i5 = 0; i5 < `ATCGPIO100_GPIO_NUM; i5 = i5 + 1) begin
    		gpio_ch_intr_nx[i5] = (penable & pwrite & gpio_intr_sel & pwdata [i5]) ? 1'b0 :
                                                                  gpio_ch_intr_trg[i5] ? 1'b1 : gpio_ch_intr[i5];
	end
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
        	gpio_ch_intr <= {`ATCGPIO100_GPIO_NUM{1'b0}};
	end
	else begin
        	gpio_ch_intr <= gpio_ch_intr_nx;
	end
end
`endif

`ifdef ATCGPIO100_DEBOUNCE_SUPPORT
always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
        	gpio_db_clk   <= 1'b0;
        	gpio_db_scale <= 8'h0;
    	end
    	else if (penable & pwrite & gpio_db_ctl_sel) begin
        	gpio_db_clk   <= pwdata[31];
        	gpio_db_scale <= pwdata[7:0];
    	end
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
        	gpio_db_en <= {`ATCGPIO100_GPIO_NUM{1'b0}};
    	end
    	else if (penable & pwrite & gpio_db_en_sel) begin
        	gpio_db_en <= pwdata[GPIO_MSB:0];
    	end
end
`endif

`ifdef ATCGPIO100_PULL_SUPPORT
wire	[32:0]	gpio_pull_en_b33 	= {{GPIO_C0{1'b0}}, gpio_pull_en};
wire	[32:0]	gpio_pull_mode_b33 	= {{GPIO_C0{1'b0}}, gpio_pull_mode};
`endif

`ifdef ATCGPIO100_INTR_SUPPORT
wire	[32:0]	gpio_intr_en_b33 	= {{GPIO_C0{1'b0}}, gpio_intr_en};
wire	[32:0]	gpio_ch_intr_b33 	= {{GPIO_C0{1'b0}}, gpio_ch_intr};
`endif

`ifdef ATCGPIO100_DEBOUNCE_SUPPORT
wire	[32:0]	gpio_db_en_b33		= {{GPIO_C0{1'b0}}, gpio_db_en};
`endif

wire	[32:0]	gpio_din_b33		= {{GPIO_C0{1'b0}}, gpio_din};
wire	[32:0]	gpio_out_b33		= {{GPIO_C0{1'b0}}, gpio_out};
wire	[32:0]	gpio_chdir_b33		= {{GPIO_C0{1'b0}}, gpio_chdir};
assign prdata =	{32{~pwrite}} &
		(({32{id_sel}} & `ATCGPIO100_PRODUCT_ID) |
		({32{config_sel}} & {`_ATCGPIO100_PULL_EXIST, `_ATCGPIO100_INTR_EXIST, `_ATCGPIO100_DEBOUNCE_EXIST, 23'h0, gpio_num}) |
		`ifdef ATCGPIO100_PULL_SUPPORT
                ({32{gpio_pull_en_sel}} & gpio_pull_en_b33[31:0]) |
                ({32{gpio_pull_mode_sel}} & gpio_pull_mode_b33[31:0]) |
		`endif
		`ifdef ATCGPIO100_INTR_SUPPORT
                ({32{gpio_intr_en_sel}} & gpio_intr_en_b33[31:0]) |
                ({32{gpio_ch0_7_intr_mode_sel}}   & gpio_intr_mode_prdata[31:0]) |
                ({32{gpio_ch8_15_intr_mode_sel}}  & gpio_intr_mode_prdata[63:32]) |
                ({32{gpio_ch16_23_intr_mode_sel}} & gpio_intr_mode_prdata[95:64]) |
                ({32{gpio_ch24_31_intr_mode_sel}} & gpio_intr_mode_prdata[127:96]) |
                ({32{gpio_intr_sel}} & gpio_ch_intr_b33[31:0]) |
		`endif
		`ifdef ATCGPIO100_DEBOUNCE_SUPPORT
                ({32{gpio_db_ctl_sel}} & {gpio_db_clk, 23'd0, gpio_db_scale}) |
                ({32{gpio_db_en_sel}} & gpio_db_en_b33[31:0]) |
		`endif
                ({32{gpio_din_sel}} & gpio_din_b33[31:0]) |
                ({32{gpio_do_sel}} & gpio_out_b33[31:0]) |
                ({32{gpio_chdir_sel}} & gpio_chdir_b33[31:0]));


endmodule

