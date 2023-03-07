// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcrtc100_config.vh"
`include "atcrtc100_const.vh"

module atcrtc100_pulsegen (
	  rtc_rstn,
	  rtc_clk,
	  rtc_en_rtclk,
	  rtc_1hz_pls,
	  ft_test_en,
	  ft_test_out,
	  reg_sec_trim_rtclk,
	  reg_sign_sec_trim_rtclk,
	  reg_min_trim_rtclk,
	  reg_sign_min_trim_rtclk,
	  reg_hour_trim_rtclk,
	  reg_sign_hour_trim_rtclk,
	  reg_day_trim_rtclk,
	  reg_sign_day_trim_rtclk,
	  min_trim_trig,
	  hour_trim_trig,
	  day_trim_trig,
	  resume_trim_min,
	  resume_trim_hour,
	  resume_trim_day,
	  presetn,
	  pclk,
	  rtc_clk_falling_edge
);

parameter	NDS_RTC100_IDLE      = 2'b00;
parameter	NDS_RTC100_TRIM_PLUS = 2'b01;
parameter	NDS_RTC100_CNTR_TICK = 2'b10;

input					rtc_rstn;
input					rtc_clk;
input					rtc_en_rtclk;
output					rtc_1hz_pls;
input					ft_test_en;
output					ft_test_out;
input	[4:0]				reg_sec_trim_rtclk;
input					reg_sign_sec_trim_rtclk;
input	[4:0]				reg_min_trim_rtclk;
input					reg_sign_min_trim_rtclk;
input	[4:0]				reg_hour_trim_rtclk;
input					reg_sign_hour_trim_rtclk;
input	[4:0]				reg_day_trim_rtclk;
input					reg_sign_day_trim_rtclk;
input					min_trim_trig;
input					hour_trim_trig;
input					day_trim_trig;
input					resume_trim_min;
input					resume_trim_hour;
input					resume_trim_day;
input					presetn;
input					pclk;
output					rtc_clk_falling_edge;

reg	[`ATCRTC100_DIVIDER_WIDTH-1:0]	s0;
reg	[`ATCRTC100_DIVIDER_WIDTH-1:0]	s1;
reg	[`ATCRTC100_DIVIDER_WIDTH-1:0]	s2;
reg					rtc_1hz_pls;

reg	[1:0]				s3;
reg	[1:0]				s4;

reg					ft_test_out;
wire					rtc_clk_falling_edge;

wire					s5;
wire					s6;
wire					s7;
wire					s8;

wire					s9;

wire	[4:0]				s10;
wire	[4:0]				s11;
wire	[4:0]				s12;
wire	[4:0]				s13;
wire	[4:0]				s14;
wire	[`ATCRTC100_DIVIDER_WIDTH-1:0]	s15;

wire					s16;
wire					s17;
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
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
reg					s31;
wire					s32;
wire					s33;
wire					s34;
`endif

`ifdef ATCRTC100_HALF_SECOND_SUPPORT
assign s33 = ~s31 & s9 & (s4 == NDS_RTC100_CNTR_TICK);
assign s34 =  s31 & s9 & (s4 == NDS_RTC100_CNTR_TICK);
assign s32  =  s33 | (s31 & ~s34);

always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (!rtc_rstn) begin
		s31 <= 1'b0;
	end
	else begin
		s31 <= s32;
	end
end
`endif

assign s5    = (|reg_sec_trim_rtclk);
assign s6    = (|reg_min_trim_rtclk);
assign s7   = (|reg_hour_trim_rtclk);
assign s8    = (|reg_day_trim_rtclk);

assign s10  = (~reg_sec_trim_rtclk);
assign s11  = (~reg_min_trim_rtclk);
assign s12 = (~reg_hour_trim_rtclk);
assign s13  = (~reg_day_trim_rtclk);
assign s14   =   ((day_trim_trig   && s8)  || resume_trim_day)  ? s13
                         : (((hour_trim_trig && s7) || resume_trim_hour) ? s12
			 : (((min_trim_trig  && s6)  || resume_trim_min)  ? s11
			 : s10));

localparam DIVIDER_WIDTH = `ATCRTC100_DIVIDER_WIDTH;

generate
if (DIVIDER_WIDTH>5) begin: gen_driver_width_gt_5
	assign s15      = {{(DIVIDER_WIDTH - 5){1'b1}}, s14} + {{(`ATCRTC100_DIVIDER_WIDTH - 1){1'b0}}, 1'b1};
end
else begin
	assign s15      = s14[DIVIDER_WIDTH-1:0] + {{(DIVIDER_WIDTH - 1){1'b0}}, 1'b1};
end
endgenerate

assign s9 = &s2;

wire	[DIVIDER_WIDTH-1:0]	s35;
wire	[DIVIDER_WIDTH-1:0]	s36;
wire	[DIVIDER_WIDTH-1:0]	s37;
wire	[DIVIDER_WIDTH-1:0]	s38;
generate
if (DIVIDER_WIDTH>5) begin: gen_counter_mux_gt_5
	assign s35  = {{(DIVIDER_WIDTH - 5){1'b0}}, reg_day_trim_rtclk};
	assign s36 = {{(DIVIDER_WIDTH - 5){1'b0}}, reg_hour_trim_rtclk};
	assign s37  = {{(DIVIDER_WIDTH - 5){1'b0}}, reg_min_trim_rtclk};
	assign s38  = {{(DIVIDER_WIDTH - 5){1'b0}}, reg_sec_trim_rtclk};
end
else begin
	assign s35  = reg_day_trim_rtclk[DIVIDER_WIDTH-1:0];
	assign s36 = reg_hour_trim_rtclk[DIVIDER_WIDTH-1:0];
	assign s37  = reg_min_trim_rtclk[DIVIDER_WIDTH-1:0];
	assign s38  = reg_sec_trim_rtclk[DIVIDER_WIDTH-1:0];
end
endgenerate

always @* begin
	s1 = s2;
	if (rtc_en_rtclk) begin
		if (s4 == NDS_RTC100_IDLE) begin
			if((day_trim_trig && s8) || resume_trim_day) begin
				if(reg_sign_day_trim_rtclk) begin
					s1 = s15;
				end
				else begin
					s1 = s35;
				end
			end
			else if((hour_trim_trig && s7) || resume_trim_hour) begin
				if(reg_sign_hour_trim_rtclk) begin
					s1 = s15;
				end
				else begin
					s1 = s36;
				end
			end
			else if((min_trim_trig && s6) || resume_trim_min) begin
				if(reg_sign_min_trim_rtclk) begin
					s1 = s15;
				end
				else begin
					s1 = s37;
				end
			end
			else if(s5) begin
				if(reg_sign_sec_trim_rtclk) begin
					s1 = s15;
				end
				else begin
					s1 = s38;
				end
			end
		end
	end
	else begin
		s1 = {(`ATCRTC100_DIVIDER_WIDTH){1'b0}};
	end
end

always @* begin
	s0 = s1 + {{(`ATCRTC100_DIVIDER_WIDTH - 1){1'b0}}, 1'b1};
	if (s9 &&
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
		(s4 == NDS_RTC100_CNTR_TICK) && s31) begin
`else
		(s4 == NDS_RTC100_CNTR_TICK)) begin
`endif
		if (day_trim_trig && s8) begin
			if(reg_sign_day_trim_rtclk) begin
				s0 = s15;
			end
			else begin
				s0 = s35;
			end
		end
		else if (hour_trim_trig && s7) begin
			if (reg_sign_hour_trim_rtclk) begin
				s0 = s15;
			end
			else begin
				s0 = s36;
			end
		end
		else if (min_trim_trig && s6) begin
			if (reg_sign_min_trim_rtclk) begin
				s0 = s15;
			end
			else begin
				s0 = s37;
			end
		end
		else if (s5) begin
			if (reg_sign_sec_trim_rtclk) begin
				s0 = s15;
			end
			else begin
				s0 = s38;
			end
		end
	end
end


always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (!rtc_rstn) begin
		s2 <= {(`ATCRTC100_DIVIDER_WIDTH){1'b0}};
	end
	else if (rtc_en_rtclk) begin
		s2 <= s0;
	end
	else begin
		s2 <= {(`ATCRTC100_DIVIDER_WIDTH){1'b0}};
	end
end

always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (!rtc_rstn)
		rtc_1hz_pls <= 1'b0;
	else
		rtc_1hz_pls <= s9 & (s4 == NDS_RTC100_CNTR_TICK);
end

always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (!rtc_rstn) begin
		s4 <= NDS_RTC100_IDLE;
	end
	else begin
		s4 <= s3;
	end
end

always @* begin
	case (s4)
		NDS_RTC100_TRIM_PLUS: begin
			if (rtc_en_rtclk) begin
				if (s9) begin
					s3 = NDS_RTC100_CNTR_TICK;
				end
				else begin
					s3 = NDS_RTC100_TRIM_PLUS;
				end
			end
			else begin
				s3 = NDS_RTC100_IDLE;
			end
		end
		NDS_RTC100_CNTR_TICK: begin
			if (rtc_en_rtclk) begin
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
				if (s9 && s31 &&
`else
				if (s9 &&
`endif
					(   s16
					 | (s18 && !s17)
					 | (s20  && !(s17 | s19))
					 | (s22  && !(s17 | s19 | s21)))
				) begin
					s3 = NDS_RTC100_TRIM_PLUS;
				end
				else begin
					s3 = NDS_RTC100_CNTR_TICK;
				end
			end
			else begin
				s3 = NDS_RTC100_IDLE;
			end
		end
		default: begin
			if (rtc_en_rtclk) begin
				if (  (s23  && (reg_day_trim_rtclk  != 5'd1))
				    | (s25 && (reg_hour_trim_rtclk != 5'd1) && !s24)
				    | (s27  && (reg_min_trim_rtclk  != 5'd1) && !(s24 | s26))
				    | (s29  && (reg_sec_trim_rtclk  != 5'd1) && !(s24 | s26 | s28))) begin
					s3 = NDS_RTC100_TRIM_PLUS;
				end
				else begin
					s3 = NDS_RTC100_CNTR_TICK;
				end
			end
			else begin
				s3 = NDS_RTC100_IDLE;
			end
		end
	endcase
end

assign s16   = s8  & day_trim_trig  & reg_sign_day_trim_rtclk;
assign s18  = s7 & hour_trim_trig & reg_sign_hour_trim_rtclk;
assign s20   = s6  & min_trim_trig  & reg_sign_min_trim_rtclk;
assign s22   = s5                   & reg_sign_sec_trim_rtclk;

assign s17  = s8  & day_trim_trig  & ~reg_sign_day_trim_rtclk;
assign s19 = s7 & hour_trim_trig & ~reg_sign_hour_trim_rtclk;
assign s21  = s6  & min_trim_trig  & ~reg_sign_min_trim_rtclk;

assign s23   = s8  & (day_trim_trig  | resume_trim_day)  & reg_sign_day_trim_rtclk;
assign s25  = s7 & (hour_trim_trig | resume_trim_hour) & reg_sign_hour_trim_rtclk;
assign s27   = s6  & (min_trim_trig  | resume_trim_min)  & reg_sign_min_trim_rtclk;
assign s29   = s5                                        & reg_sign_sec_trim_rtclk;

assign s24  = s8  & (day_trim_trig  | resume_trim_day)  & ~reg_sign_day_trim_rtclk;
assign s26 = s7 & (hour_trim_trig | resume_trim_hour) & ~reg_sign_hour_trim_rtclk;
assign s28  = s6  & (min_trim_trig  | resume_trim_min)  & ~reg_sign_min_trim_rtclk;

assign s30 = ft_test_en & (&s2[4:0]) & (s4 == NDS_RTC100_CNTR_TICK);

always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (!rtc_rstn) begin
		ft_test_out <= 1'b0;
	end
	else if (s30) begin
		ft_test_out <= ~ft_test_out;
	end
end


nds_sync_l2l u_sync_l2l_extclk (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(rtc_clk),
	.b_signal			(),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(rtc_clk_falling_edge),
	.b_signal_edge_pulse		()
);

endmodule

