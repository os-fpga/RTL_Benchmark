// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module atcpit100_ch(
                     	  pclk,
                     	  presetn,
                     	  extclk_en,
                     	  pit_pause,
                     	  reload,
                     	  mode_tmr32,
                     	  mode_tmr16,
                     	  mode_tmr8,
                     	  mode_pwm,
                     	  mode_pwm16,
                     	  mode_pwm8,
                     	  ch_clk,
                     	  ch_en,
                     	  pwm_park,
                     	  intr_trig,
                     	  pwm,
                     	  cntr
);

input			pclk;
input			presetn;
input			extclk_en;
input			pit_pause;
input	[31:0]		reload;
input			mode_tmr32;
input			mode_tmr16;
input			mode_tmr8;
input			mode_pwm;
input			mode_pwm16;
input			mode_pwm8;
input			ch_clk;
input	[3:0]		ch_en;
input			pwm_park;
output	[3:0]		intr_trig;
output			pwm;
output	[31:0]		cntr;

reg			pwm;
reg			s0;

wire	[7:0]		s1;
wire	[7:0]		s2;
wire	[7:0]		s3;
wire	[7:0]		s4;
assign			cntr = {s4, s3, s2, s1};

wire			clk_en;
wire			s5;
wire			s6;
wire			s7;
wire			s8;
wire			s9;
wire			s10;
wire			s11;
wire			s12;
wire			s13;
wire			s14;
wire			s15;
wire			s16;
wire			s17;
wire			s18;
wire			s19;
wire			s20;
wire			s21;
wire			s22;
wire			s23;
wire			s24;
wire			s25;
wire			s26;


wire	s27;
wire	s28;
wire	s29;
wire	s30;
wire	s31;
wire	s32;
wire	s33;
wire	s34;
wire	s35;
wire	s36;
wire	s37;
wire	s38;
wire	s39;
wire	s40;
wire	s41;
wire	s42;

assign s5		= mode_tmr32 & ch_en[0];
assign s6	= mode_tmr16 & ch_en[0];
assign s7	= mode_tmr16 & ~mode_pwm & ch_en[1];
assign s8	= mode_tmr8 & ch_en[0];
assign s9	= mode_tmr8 & ch_en[1];
assign s10	= mode_tmr8 & ~mode_pwm & ch_en[2];
assign s11	= mode_tmr8 & ~mode_pwm & ch_en[3];
assign s12	= mode_pwm16 & ~pwm & ch_en[3];
assign s13	= mode_pwm16 &  pwm & ch_en[3];
assign s14	= mode_pwm8  & ~pwm & ch_en[3];
assign s15	= mode_pwm8  &  pwm & ch_en[3];

assign s16	= s5 & s30 & s34 & s38 & s42;
assign s17 = s6 & s30 & s34;
assign s18 = s7 & s38 & s42;
assign s19  = s8 & s30;
assign s20  = s9 & s34;
assign s21  = s10 & s38;
assign s22  = s11 & s42;
assign s24 = s12 & s30 & s34;
assign s23 = s13 & s38 & s42;
assign s26 = s14 & s38;
assign s25 = s15 & s42;

assign s27	= ~(s5 | s6 | s8 | s12);
assign s31	= ~(s5 | s6 | s9 | s12);
assign s35	= ~(s5 | s7 | s10 | s13 | s14);
assign s39	= ~(s5 | s7 | s11 | s13 | s15);

assign s28 = s16 | s17 | s19 | s24;
assign s32 = s16 | s17 | s20 | s24;
assign s36 = s16 | s18 | s21 | s23 | s26;
assign s40 = s16 | s18 | s22 | s23 | s25;

assign s29 = s8 | s6 | s5 | s12;
assign s33 = ((s5 | s6 | s12) & s30) | s9;
assign s37 = (s5 & s30 & s34) | s7 | s13 | s10 | s14;
assign s41 = (s5 & s38 & s34 & s30) | ((s7 | s13) & s38) | s11 | s15;

assign clk_en = ch_clk | extclk_en;

assign intr_trig[0] = ~pit_pause & clk_en & (s19 | s17 | s16);
assign intr_trig[1] = ~pit_pause & clk_en & (s20 | s18);
assign intr_trig[2] = ~pit_pause & clk_en &  s21;
assign intr_trig[3] = ~pit_pause & clk_en &  s22;

always @( * ) begin
	if (mode_pwm16)
		s0 = s24 | ~s23;
	else
		s0 = s26 | ~s25;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		pwm <= 1'b0;
	else if (~(mode_pwm & ch_en[3]))
		pwm <= pwm_park;
	else if (~pit_pause & clk_en & mode_pwm & (s23 | s24 | s25 | s26))
		pwm <= s0;
end


atcpit100_cntr u_cntr0(
	.pclk		(pclk),
	.presetn	(presetn),
	.clk_en		(clk_en),
	.off		(s27),
	.decr		(s29),
	.load		(s28),
	.func		(reload[7:0]),
	.pit_pause	(pit_pause),
	.eq0		(s30),
	.cntr		(s1)
);

atcpit100_cntr u_cntr1(
	.pclk		(pclk),
	.presetn	(presetn),
	.clk_en		(clk_en),
	.off		(s31),
	.decr		(s33),
	.load		(s32),
	.func		(reload[15:8]),
	.pit_pause	(pit_pause),
	.eq0		(s34),
	.cntr		(s2)
);

atcpit100_cntr u_cntr2(
	.pclk		(pclk),
	.presetn	(presetn),
	.clk_en		(clk_en),
	.off		(s35),
	.decr		(s37),
	.load		(s36),
	.func		(reload[23:16]),
	.pit_pause	(pit_pause),
	.eq0		(s38),
	.cntr		(s3)
);

atcpit100_cntr u_cntr3(
	.pclk		(pclk),
	.presetn	(presetn),
	.clk_en		(clk_en),
	.off		(s39),
	.decr		(s41),
	.load		(s40),
	.func		(reload[31:24]),
	.pit_pause	(pit_pause),
	.eq0		(s42),
	.cntr		(s4)
);

endmodule

