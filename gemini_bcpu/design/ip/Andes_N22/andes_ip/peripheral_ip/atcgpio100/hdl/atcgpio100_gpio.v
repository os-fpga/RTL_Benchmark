// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary


`include "atcgpio100_config.vh"
`include "atcgpio100_const.vh"

module atcgpio100_gpio(
                        	  pclk,
                        	  presetn,
                        	  extclk,
                        `ifdef ATCGPIO100_INTR_SUPPORT
                        	  gpio_intr_en,
                        	  gpio_intr_mode_b0,
                        	  gpio_intr_mode_b1,
                        	  gpio_intr_mode_b2,
                        	  gpio_ch_intr_trg,
                        `endif
                        `ifdef ATCGPIO100_DEBOUNCE_SUPPORT
                        	  gpio_db_en,
                        	  gpio_db_scale,
                        	  gpio_db_clk,
                        `endif
                        	  gpio_in,
                        	  gpio_din,
                        	  gpio_in_en
);

parameter GPIO_MSB = `ATCGPIO100_GPIO_NUM - 1;

input               pclk;
input               presetn;
input               extclk;

`ifdef ATCGPIO100_INTR_SUPPORT
input  [GPIO_MSB:0] gpio_intr_en;
input  [GPIO_MSB:0] gpio_intr_mode_b0;
input  [GPIO_MSB:0] gpio_intr_mode_b1;
input  [GPIO_MSB:0] gpio_intr_mode_b2;
output [GPIO_MSB:0] gpio_ch_intr_trg;
`endif

`ifdef ATCGPIO100_DEBOUNCE_SUPPORT
input  [GPIO_MSB:0] gpio_db_en;
input         [7:0] gpio_db_scale;
input               gpio_db_clk;
`else
wire   [GPIO_MSB:0] gpio_db_en = {`ATCGPIO100_GPIO_NUM{1'b0}};
`endif

input  [GPIO_MSB:0] gpio_in;
output [GPIO_MSB:0] gpio_din;
input  [GPIO_MSB:0] gpio_in_en;

reg    [GPIO_MSB:0] s0;
reg    [GPIO_MSB:0] s1;
reg    [GPIO_MSB:0] s2;
reg    [GPIO_MSB:0] s3;

`ifdef ATCGPIO100_DEBOUNCE_SUPPORT
wire   [GPIO_MSB:0] s4;
reg    [GPIO_MSB:0] s5;
wire   [GPIO_MSB:0] s6;
wire          [7:0] s7;
wire                s8;
wire                s9;
wire                s10;
reg    [GPIO_MSB:0] s11;
reg    [GPIO_MSB:0] s12;
reg    [GPIO_MSB:0] s13;
reg           [7:0] s14;
reg                 s15;
reg                 s16;
`else
wire   [GPIO_MSB:0] s11 = {`ATCGPIO100_GPIO_NUM{1'b0}};
`endif


`ifdef ATCGPIO100_INTR_SUPPORT
wire   [GPIO_MSB:0] s17;
wire   [GPIO_MSB:0] s18;
wire   [GPIO_MSB:0] s19;
wire   [GPIO_MSB:0] s20;
wire   [GPIO_MSB:0] s21;
`endif


assign gpio_din         = s2;

`ifdef ATCGPIO100_INTR_SUPPORT
assign gpio_ch_intr_trg = gpio_in_en & gpio_intr_en & s21;

assign s17          = s2 & ~s3;

assign s18          = ~s2 & s3;

assign s19          = s2;

assign s20          = ~s2;

assign s21 	=
	~gpio_intr_mode_b2 & (
		( gpio_intr_mode_b1 & ~gpio_intr_mode_b0 & s19) |
		( gpio_intr_mode_b1 &  gpio_intr_mode_b0 & s20)
	) |
	gpio_intr_mode_b2 & (
		(~gpio_intr_mode_b1 &  gpio_intr_mode_b0 & s18) |
		( gpio_intr_mode_b1 & ~gpio_intr_mode_b0 & s17) |
		( gpio_intr_mode_b1 &  gpio_intr_mode_b0 & (s17 | s18))
	);
`endif

`ifdef ATCGPIO100_DEBOUNCE_SUPPORT
assign s4            = gpio_in_en & gpio_db_en;

assign s6      = s4 & ~s5;

assign s8       = |s4;

assign s10           = (s15 & ~s16) | gpio_db_clk;
assign s7       = s14 - 8'h1;

assign s9     = s7[7] & ~s14[7] & s10;
`endif

always @(posedge pclk or negedge presetn) begin
    	if (~presetn) begin
        	s0 <= {`ATCGPIO100_GPIO_NUM{1'b0}};
        	s1 <= {`ATCGPIO100_GPIO_NUM{1'b0}};
	end
    	else begin
            	s0 <= (gpio_in_en & gpio_in) | (~gpio_in_en & s0);
            	s1 <= s0;
    	end
end

always @(posedge pclk or negedge presetn) begin
    	if (~presetn) begin
        	s2 <= {`ATCGPIO100_GPIO_NUM{1'b0}};
    	end
    	else begin
            	s2 <= (gpio_in_en & gpio_db_en & s11) | ((~gpio_in_en | ~gpio_db_en) & s1);
    	end
end

`ifdef ATCGPIO100_INTR_SUPPORT
always @(posedge pclk or negedge presetn) begin
    	if (~presetn) begin
        	s3 <= {`ATCGPIO100_GPIO_NUM{1'b0}};
    	end
    	else begin
            	s3 <= s2;
    	end
end
`endif

`ifdef ATCGPIO100_DEBOUNCE_SUPPORT
integer s22;
integer s23;

always @(posedge pclk or negedge presetn) begin
    	if (~presetn) begin
        	s5 <= {`ATCGPIO100_GPIO_NUM{1'b0}};
    	end
    	else begin
        	s5 <= s4;
    	end
end


always @(posedge pclk or negedge presetn) begin
    	if (~presetn) begin
        	s12 <= {`ATCGPIO100_GPIO_NUM{1'h0}};
        	s13 <= {`ATCGPIO100_GPIO_NUM{1'h0}};
    	end
    	else begin
        	for (s22=0; s22<`ATCGPIO100_GPIO_NUM; s22=s22+1) begin
            		s12[s22] <= s6[s22] ? s1[s22] : (s4[s22] & s9) ? s1[s22] : s12[s22];
            		s13[s22] <= s6[s22] ? s1[s22] : (s4[s22] & s9) ? s12[s22] : s13[s22];
        	end
    	end
end

always @(*) begin
    	for (s23=0; s23<`ATCGPIO100_GPIO_NUM; s23=s23+1) begin
		if (s6[s23]) begin
            		s11[s23] = s2[s23];
		end
		else if (s12[s23] & s13[s23]) begin
            		s11[s23] = 1'b1;
		end
		else if (~(s12[s23] | s13[s23])) begin
            		s11[s23] = 1'b0;
		end
		else begin
            		s11[s23] = s2[s23];
		end
    	end
end

always @(posedge pclk or negedge presetn) begin
    	if (~presetn) begin
        	s15 <= 1'b0;
        	s16 <= 1'b0;
    	end
    	else if (s8 & ~gpio_db_clk) begin
        	s15 <= extclk;
        	s16 <= s15;
    	end
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
        	s14 <= 8'h0;
	end
	else if (s9) begin
        	s14 <= gpio_db_scale;
	end
	else if (s8 & s10) begin
        	s14 <= s7;
	end
end
`endif

endmodule

