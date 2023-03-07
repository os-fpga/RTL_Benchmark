// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcpit100_config.vh"
`include "atcpit100_const.vh"
module atcpit100_apbslv(
                         	  pclk,
                         	  presetn,
                         	  psel,
                         	  penable,
                         	  pwrite,
                         	  paddr,
                         	  pwdata,
                         	  prdata,
                         	  pit_intr,
                         `ifdef ATCPIT100_CH1_SUPPORT
                         	  ch1_intr_trig,
                         	  ch1_cntr,
                         	  ch1_reload,
                         	  ch1_mode_tmr32,
                         	  ch1_mode_tmr16,
                         	  ch1_mode_tmr8,
                         	  ch1_mode_pwm,
                         	  ch1_mode_pwm16,
                         	  ch1_mode_pwm8,
                         	  ch1_chclk,
                         	  ch1_chen,
                         	  ch1_pwmpark,
                         	  ch1_pwmoe,
                         `endif
                         `ifdef ATCPIT100_CH2_SUPPORT
                         	  ch2_intr_trig,
                         	  ch2_cntr,
                         	  ch2_reload,
                         	  ch2_mode_tmr32,
                         	  ch2_mode_tmr16,
                         	  ch2_mode_tmr8,
                         	  ch2_mode_pwm,
                         	  ch2_mode_pwm16,
                         	  ch2_mode_pwm8,
                         	  ch2_chclk,
                         	  ch2_chen,
                         	  ch2_pwmpark,
                         	  ch2_pwmoe,
                         `endif
                         `ifdef ATCPIT100_CH3_SUPPORT
                         	  ch3_intr_trig,
                         	  ch3_cntr,
                         	  ch3_reload,
                         	  ch3_mode_tmr32,
                         	  ch3_mode_tmr16,
                         	  ch3_mode_tmr8,
                         	  ch3_mode_pwm,
                         	  ch3_mode_pwm16,
                         	  ch3_mode_pwm8,
                         	  ch3_chclk,
                         	  ch3_chen,
                         	  ch3_pwmpark,
                         	  ch3_pwmoe,
                         `endif
                         	  ch0_intr_trig,
                         	  ch0_cntr,
                         	  ch0_reload,
                         	  ch0_mode_tmr32,
                         	  ch0_mode_tmr16,
                         	  ch0_mode_tmr8,
                         	  ch0_mode_pwm,
                         	  ch0_mode_pwm16,
                         	  ch0_mode_pwm8,
                         	  ch0_chclk,
                         	  ch0_chen,
                         	  ch0_pwmpark,
                         	  ch0_pwmoe
);

input			pclk;
input			presetn;
input			psel;
input			penable;
input			pwrite;
input	[6:2]	paddr;
input	[31:0]	pwdata;
output	[31:0]	prdata;

output			pit_intr;

`ifdef ATCPIT100_CH1_SUPPORT
input	[3:0]	ch1_intr_trig;
input	[31:0]	ch1_cntr;
output	[31:0]	ch1_reload;
output			ch1_mode_tmr32;
output			ch1_mode_tmr16;
output			ch1_mode_tmr8;
output			ch1_mode_pwm;
output			ch1_mode_pwm16;
output			ch1_mode_pwm8;
output			ch1_chclk;
output   [3:0]	ch1_chen;
output			ch1_pwmpark;
output			ch1_pwmoe;
`endif
`ifdef ATCPIT100_CH2_SUPPORT
input	[3:0]	ch2_intr_trig;
input	[31:0]	ch2_cntr;
output	[31:0]	ch2_reload;
output			ch2_mode_tmr32;
output			ch2_mode_tmr16;
output			ch2_mode_tmr8;
output			ch2_mode_pwm;
output			ch2_mode_pwm16;
output			ch2_mode_pwm8;
output			ch2_chclk;
output	[3:0]	ch2_chen;
output			ch2_pwmpark;
output			ch2_pwmoe;
`endif
`ifdef ATCPIT100_CH3_SUPPORT
input	[3:0]	ch3_intr_trig;
input	[31:0]	ch3_cntr;
output	[31:0]	ch3_reload;
output			ch3_mode_tmr32;
output			ch3_mode_tmr16;
output			ch3_mode_tmr8;
output			ch3_mode_pwm;
output			ch3_mode_pwm16;
output			ch3_mode_pwm8;
output			ch3_chclk;
output	[3:0]	ch3_chen;
output			ch3_pwmpark;
output			ch3_pwmoe;
`endif
input	[3:0]	ch0_intr_trig;
input	[31:0]	ch0_cntr;
output	[31:0]	ch0_reload;
output			ch0_mode_tmr32;
output			ch0_mode_tmr16;
output			ch0_mode_tmr8;
output			ch0_mode_pwm;
output			ch0_mode_pwm16;
output			ch0_mode_pwm8;
output			ch0_chclk;
output	[3:0]	ch0_chen;
output			ch0_pwmpark;
output			ch0_pwmoe;

wire			s0;
wire	[15:0]	s1;
wire	[15:0]	s2;
wire	[15:0]	s3;

wire			s4;
wire			s5;
wire			s6;
wire			s7;
wire			s8;


wire			s9;
wire			s10;
wire			s11;
wire	[4:0]	s12;
reg		[3:0]	s13;
reg		[3:0]	s14;
reg		[3:0]	ch0_chen;
reg		[31:0]	ch0_reload;
reg		[2:0]	s15;
reg				ch0_chclk;
reg				ch0_pwmpark;
`ifdef ATCPIT100_CH1_SUPPORT
wire			s16;
wire			s17;
wire			s18;
wire	[4:0]	s19;
reg		[3:0]	s20;
reg		[3:0]	s21;
reg		[3:0]	ch1_chen;
reg		[31:0]	ch1_reload;
reg		[2:0]	s22;
reg				ch1_chclk;
reg				ch1_pwmpark;
`else
wire 	[3:0]	s20;
wire 	[3:0]	s21;
wire 	[3:0]	ch1_chen;
assign			s20 = 4'b0;
assign			s21 = 4'b0;
assign			ch1_chen = 4'b0;
`endif
`ifdef ATCPIT100_CH2_SUPPORT
wire			s23;
wire			s24;
wire			s25;
wire	[4:0]	s26;
reg		[3:0]	s27;
reg		[3:0]	s28;
reg		[3:0]	ch2_chen;
reg		[31:0]	ch2_reload;
reg		[2:0]	s29;
reg				ch2_chclk;
reg				ch2_pwmpark;
`else
wire 	[3:0]	s27;
wire 	[3:0]	s28;
wire 	[3:0]	ch2_chen;
assign			s27 = 4'b0;
assign			s28 = 4'b0;
assign			ch2_chen = 4'b0;
`endif
`ifdef ATCPIT100_CH3_SUPPORT
wire			s30;
wire			s31;
wire			s32;
wire	[4:0]	s33;
reg		[3:0]	s34;
reg		[3:0]	s35;
reg		[3:0]	ch3_chen;
reg		[31:0]	ch3_reload;
reg		[2:0]	s36;
reg				ch3_chclk;
reg				ch3_pwmpark;
`else
wire 	[3:0]	s34;
wire 	[3:0]	s35;
wire 	[3:0]	ch3_chen;
assign			s34 = 4'b0;
assign			s35 = 4'b0;
assign			ch3_chen = 4'b0;
`endif


wire	ch0_mode_tmr32;
wire	ch0_mode_tmr16;
wire	ch0_mode_tmr8;
wire	ch0_mode_pwm;
wire	ch0_mode_pwm16;
wire	ch0_mode_pwm8;
wire	[3:0]	s37;
assign	ch0_mode_tmr32	= ~s15[1] &  s15[0];
assign	ch0_mode_tmr16	=  s15[1] & ~s15[0];
assign	ch0_mode_tmr8	=  s15[1] &  s15[0];
assign	ch0_mode_pwm	=  s15[2];
assign	ch0_mode_pwm16	= ~s15[1] & ~s15[0];
assign	ch0_mode_pwm8	=  s15[2] &  s15[1];
assign	s37[0]	= ch0_mode_tmr32 | ch0_mode_tmr16 | ch0_mode_tmr8;
assign	s37[1]	= (ch0_mode_tmr16 & ~ch0_mode_pwm) | ch0_mode_tmr8;
assign	s37[2]	= (ch0_mode_tmr8  & ~ch0_mode_pwm);
assign	s37[3]	= (ch0_mode_tmr8  & ~ch0_mode_pwm) | ch0_mode_pwm;
assign  ch0_pwmoe		= ch0_mode_pwm;

`ifdef ATCPIT100_CH1_SUPPORT
wire	ch1_mode_tmr32;
wire	ch1_mode_tmr16;
wire	ch1_mode_tmr8;
wire	ch1_mode_pwm;
wire	ch1_mode_pwm16;
wire	ch1_mode_pwm8;
wire	[3:0]	s38;
assign	ch1_mode_tmr32	= ~s22[1] &  s22[0];
assign	ch1_mode_tmr16	=  s22[1] & ~s22[0];
assign	ch1_mode_tmr8	=  s22[1] &  s22[0];
assign	ch1_mode_pwm	=  s22[2];
assign	ch1_mode_pwm16	= ~s22[1] & ~s22[0];
assign	ch1_mode_pwm8	=  s22[2] &  s22[1];
assign	s38[0]	= ch1_mode_tmr32 | ch1_mode_tmr16 | ch1_mode_tmr8;
assign	s38[1]	= (ch1_mode_tmr16 & ~ch1_mode_pwm) | ch1_mode_tmr8;
assign	s38[2]	= (ch1_mode_tmr8  & ~ch1_mode_pwm);
assign	s38[3]	= (ch1_mode_tmr8  & ~ch1_mode_pwm) | ch1_mode_pwm;
assign  ch1_pwmoe		= ch1_mode_pwm;
`endif

`ifdef ATCPIT100_CH2_SUPPORT
wire	ch2_mode_tmr32;
wire	ch2_mode_tmr16;
wire	ch2_mode_tmr8;
wire	ch2_mode_pwm;
wire	ch2_mode_pwm16;
wire	ch2_mode_pwm8;
wire	[3:0]	s39;
assign	ch2_mode_tmr32	= ~s29[1] &  s29[0];
assign	ch2_mode_tmr16	=  s29[1] & ~s29[0];
assign	ch2_mode_tmr8	=  s29[1] &  s29[0];
assign	ch2_mode_pwm	=  s29[2];
assign	ch2_mode_pwm16	= ~s29[1] & ~s29[0];
assign	ch2_mode_pwm8	=  s29[2] &  s29[1];
assign	s39[0]	= ch2_mode_tmr32 | ch2_mode_tmr16 | ch2_mode_tmr8;
assign	s39[1]	= (ch2_mode_tmr16 & ~ch2_mode_pwm) | ch2_mode_tmr8;
assign	s39[2]	= (ch2_mode_tmr8  & ~ch2_mode_pwm);
assign	s39[3]	= (ch2_mode_tmr8  & ~ch2_mode_pwm) | ch2_mode_pwm;
assign  ch2_pwmoe		= ch2_mode_pwm;
`endif

`ifdef ATCPIT100_CH3_SUPPORT
wire	ch3_mode_tmr32;
wire	ch3_mode_tmr16;
wire	ch3_mode_tmr8;
wire	ch3_mode_pwm;
wire	ch3_mode_pwm16;
wire	ch3_mode_pwm8;
wire	[3:0]	s40;
assign	ch3_mode_tmr32	= ~s36[1] &  s36[0];
assign	ch3_mode_tmr16	=  s36[1] & ~s36[0];
assign	ch3_mode_tmr8	=  s36[1] &  s36[0];
assign	ch3_mode_pwm	=  s36[2];
assign	ch3_mode_pwm16	= ~s36[1] & ~s36[0];
assign	ch3_mode_pwm8	=  s36[2] &  s36[1];
assign	s40[0]	= ch3_mode_tmr32 | ch3_mode_tmr16 | ch3_mode_tmr8;
assign	s40[1]	= (ch3_mode_tmr16 & ~ch3_mode_pwm) | ch3_mode_tmr8;
assign	s40[2]	= (ch3_mode_tmr8  & ~ch3_mode_pwm);
assign	s40[3]	= (ch3_mode_tmr8  & ~ch3_mode_pwm) | ch3_mode_pwm;
assign  ch3_pwmoe		= ch3_mode_pwm;
`endif

assign s1 = {s34, s27, s20, s13};

assign s2 = {s35, s28, s21, s14};

assign pit_intr = |s2;

assign s3  = {ch3_chen, ch2_chen, ch1_chen, ch0_chen};

assign s4		= psel & ({paddr[6:2], 2'b0} == 7'h00);
assign s5		= psel & ({paddr[6:2], 2'b0} == 7'h10);
assign s6	= psel & ({paddr[6:2], 2'b0} == 7'h14);
assign s7		= psel & ({paddr[6:2], 2'b0} == 7'h18);
assign s8		= psel & ({paddr[6:2], 2'b0} == 7'h1C);

assign s9	= psel & ({paddr[6:2], 2'b0} == 7'h20);
assign s10	= psel & ({paddr[6:2], 2'b0} == 7'h24);
assign s11	= psel & ({paddr[6:2], 2'b0} == 7'h28);
`ifdef ATCPIT100_CH1_SUPPORT
assign s16	= psel & ({paddr[6:2], 2'b0} == 7'h30);
assign s17	= psel & ({paddr[6:2], 2'b0} == 7'h34);
assign s18	= psel & ({paddr[6:2], 2'b0} == 7'h38);
`endif
`ifdef ATCPIT100_CH2_SUPPORT
assign s23	= psel & ({paddr[6:2], 2'b0} == 7'h40);
assign s24	= psel & ({paddr[6:2], 2'b0} == 7'h44);
assign s25	= psel & ({paddr[6:2], 2'b0} == 7'h48);
`endif
`ifdef ATCPIT100_CH3_SUPPORT
assign s30	= psel & ({paddr[6:2], 2'b0} == 7'h50);
assign s31	= psel & ({paddr[6:2], 2'b0} == 7'h54);
assign s32	= psel & ({paddr[6:2], 2'b0} == 7'h58);
`endif

assign s0 = penable & pwrite;



always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s13 <= 4'h0;
	else if (s0 & s6)
		s13 <= pwdata[3:0];
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s14[0] <= 1'b0;
	else if (s0 & s7 & pwdata[0])
		s14[0] <= 1'b0;
	else if (s13[0] & ch0_intr_trig[0])
		s14[0] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s14[1] <= 1'b0;
	else if (s0 & s7 & pwdata[1])
		s14[1] <= 1'b0;
	else if (s13[1] & ch0_intr_trig[1])
		s14[1] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s14[2] <= 1'b0;
	else if (s0 & s7 & pwdata[2])
		s14[2] <= 1'b0;
	else if (s13[2] & ch0_intr_trig[2])
		s14[2] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s14[3] <= 1'b0;
	else if (s0 & s7 & pwdata[3])
		s14[3] <= 1'b0;
	else if (s13[3] & ch0_intr_trig[3])
		s14[3] <= 1'b1;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		ch0_chen <= 4'h0;
	else if (s0 & s8)
		ch0_chen <= pwdata[3:0] & s37;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		s15  <= 3'd0;
		ch0_chclk   <= 1'b0;
		ch0_pwmpark <= 1'b0;
 	end
	else if (s0 & s9) begin
		s15  <= pwdata[2:0];
		ch0_chclk   <= pwdata[3];
		ch0_pwmpark <= pwdata[4];
	end
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		ch0_reload <= 32'h0;
	else if (s0 & s10)
		ch0_reload <= pwdata;
end

`ifdef ATCPIT100_CH1_SUPPORT
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s20 <= 4'h0;
	else if (s0 & s6)
		s20 <= pwdata[7:4];
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s21[0] <= 1'b0;
	else if (s0 & s7 & pwdata[4])
		s21[0] <= 1'b0;
	else if (s20[0] & ch1_intr_trig[0])
		s21[0] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s21[1] <= 1'b0;
	else if (s0 & s7 & pwdata[5])
		s21[1] <= 1'b0;
	else if (s20[1] & ch1_intr_trig[1])
		s21[1] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s21[2] <= 1'b0;
	else if (s0 & s7 & pwdata[6])
		s21[2] <= 1'b0;
	else if (s20[2] & ch1_intr_trig[2])
		s21[2] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s21[3] <= 1'b0;
	else if (s0 & s7 & pwdata[7])
		s21[3] <= 1'b0;
	else if (s20[3] & ch1_intr_trig[3])
		s21[3] <= 1'b1;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		ch1_chen <= 4'h0;
	else if (s0 & s8)
		ch1_chen <= pwdata[7:4] & s38;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		s22  <= 3'd0;
		ch1_chclk   <= 1'b0;
		ch1_pwmpark <= 1'b0;
 	end
	else if (s0 & s16) begin
		s22  <= pwdata[2:0];
		ch1_chclk   <= pwdata[3];
		ch1_pwmpark <= pwdata[4];
	end
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		ch1_reload <= 32'h0;
	else if (s0 & s17)
		ch1_reload <= pwdata;
end
`endif

`ifdef ATCPIT100_CH2_SUPPORT
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s27 <= 4'h0;
	else if (s0 & s6)
		s27 <= pwdata[11:8];
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s28[0] <= 1'b0;
	else if (s0 & s7 & pwdata[8])
		s28[0] <= 1'b0;
	else if (s27[0] & ch2_intr_trig[0])
		s28[0] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s28[1] <= 1'b0;
	else if (s0 & s7 & pwdata[9])
		s28[1] <= 1'b0;
	else if (s27[1] & ch2_intr_trig[1])
		s28[1] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s28[2] <= 1'b0;
	else if (s0 & s7 & pwdata[10])
		s28[2] <= 1'b0;
	else if (s27[2] & ch2_intr_trig[2])
		s28[2] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s28[3] <= 1'b0;
	else if (s0 & s7 & pwdata[11])
		s28[3] <= 1'b0;
	else if (s27[3] & ch2_intr_trig[3])
		s28[3] <= 1'b1;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		ch2_chen <= 4'h0;
	else if (s0 & s8)
		ch2_chen <= pwdata[11:8] & s39;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		s29  <= 3'd0;
		ch2_chclk   <= 1'b0;
		ch2_pwmpark <= 1'b0;
 	end
	else if (s0 & s23) begin
		s29  <= pwdata[2:0];
		ch2_chclk   <= pwdata[3];
		ch2_pwmpark <= pwdata[4];
	end
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		ch2_reload <= 32'h0;
	else if (s0 & s24)
		ch2_reload <= pwdata;
end
`endif

`ifdef ATCPIT100_CH3_SUPPORT
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s34 <= 4'h0;
	else if (s0 & s6)
		s34 <= pwdata[15:12];
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s35[0] <= 1'b0;
	else if (s0 & s7 & pwdata[12])
		s35[0] <= 1'b0;
	else if (s34[0] & ch3_intr_trig[0])
		s35[0] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s35[1] <= 1'b0;
	else if (s0 & s7 & pwdata[13])
		s35[1] <= 1'b0;
	else if (s34[1] & ch3_intr_trig[1])
		s35[1] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s35[2] <= 1'b0;
	else if (s0 & s7 & pwdata[14])
		s35[2] <= 1'b0;
	else if (s34[2] & ch3_intr_trig[2])
		s35[2] <= 1'b1;
end
always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s35[3] <= 1'b0;
	else if (s0 & s7 & pwdata[15])
		s35[3] <= 1'b0;
	else if (s34[3] & ch3_intr_trig[3])
		s35[3] <= 1'b1;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		ch3_chen <= 4'h0;
	else if (s0 & s8)
		ch3_chen <= pwdata[15:12] & s40;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		s36  <= 3'd0;
		ch3_chclk   <= 1'b0;
		ch3_pwmpark <= 1'b0;
 	end
	else if (s0 & s30) begin
		s36  <= pwdata[2:0];
		ch3_chclk   <= pwdata[3];
		ch3_pwmpark <= pwdata[4];
	end
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		ch3_reload <= 32'h0;
	else if (s0 & s31)
		ch3_reload <= pwdata;
end
`endif



assign s12 = {ch0_pwmpark, ch0_chclk, s15};
`ifdef ATCPIT100_CH1_SUPPORT
assign s19 = {ch1_pwmpark, ch1_chclk, s22};
`endif
`ifdef ATCPIT100_CH2_SUPPORT
assign s26 = {ch2_pwmpark, ch2_chclk, s29};
`endif
`ifdef ATCPIT100_CH3_SUPPORT
assign s33 = {ch3_pwmpark, ch3_chclk, s36};
`endif

assign prdata =	{32{~pwrite}} &
				({{32{s4}} & `ATCPIT100_PRODUCT_ID} |
				{29'h0, {3{s5}} & `ATCPIT100_NUM_CHANNEL} |
				{16'h0, {16{s6}} & s1} |
				{16'h0, {16{s7}} & s2} |
				{16'h0, {16{s8}} & s3} |
`ifdef ATCPIT100_CH1_SUPPORT
				{27'h0, { 5{s16}} & s19} |
				{{32{s17}} & ch1_reload} |
				{{32{s18}}  & ch1_cntr} |
`endif
`ifdef ATCPIT100_CH2_SUPPORT
				{27'h0, {5{s23}} & s26} |
				{{32{s24}} & ch2_reload} |
				{{32{s25}}  & ch2_cntr} |
`endif
`ifdef ATCPIT100_CH3_SUPPORT
				{27'h0, {5{s30}} & s33} |
				{{32{s31}} & ch3_reload} |
				{{32{s32}}  & ch3_cntr} |
`endif
				{27'h0, {5{s9}} & s12} |
				{{32{s10}} & ch0_reload} |
				{{32{s11}}  & ch0_cntr});

endmodule

