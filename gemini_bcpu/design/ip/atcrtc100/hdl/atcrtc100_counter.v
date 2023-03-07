// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcrtc100_config.vh"
`include "atcrtc100_const.vh"

module atcrtc100_counter (
		  rtc_rstn,
		  rtc_clk,
		  rtc_1hz_pls,
		  ctr_sdo,
		  ctr_upd_sync,
		  rtc_alm_rtclk,
		  rtc_en_rtclk,
		  alarm_wakeup_en_rtclk,
	`ifdef ATCRTC100_HALF_SECOND_SUPPORT
		  hsec_int_detect,
	`endif
		  sec_int_detect,
		  min_int_detect,
		  hour_int_detect,
		  day_int_detect,
		  alarm_int_detect,
		  alarm_wakeup,
		  rtc_ctr,
		  min_trim_trig,
		  hour_trim_trig,
		  day_trim_trig,
		  resume_trim_min,
		  resume_trim_hour,
		  resume_trim_day
);

`ifdef ATCRTC100_HALF_SECOND_SUPPORT
parameter	SEC_OVERFLOW	= 7'd119;
`else
parameter	SEC_OVERFLOW	= 6'd59;
`endif
parameter	MIN_OVERFLOW	= 6'd59;
parameter	HOUR_OVERFLOW	= 5'd23;

input					rtc_rstn;
input					rtc_clk;
input					rtc_1hz_pls;
input	[`ATCRTC100_SDO_WIDTH-1: 0]	ctr_sdo;
input					ctr_upd_sync;
input	[`ATCRTC100_ALM_WIDTH-1: 0]	rtc_alm_rtclk;
input					rtc_en_rtclk;
input					alarm_wakeup_en_rtclk;
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
	output				hsec_int_detect;
`endif
output					sec_int_detect;
output					min_int_detect;
output					hour_int_detect;
output					day_int_detect;
output					alarm_int_detect;
output					alarm_wakeup;
output	[`ATCRTC100_SDO_WIDTH-1: 0]	rtc_ctr;
output					min_trim_trig;
output					hour_trim_trig;
output					day_trim_trig;
output					resume_trim_min;
output					resume_trim_hour;
output					resume_trim_day;

reg 	[`ATCRTC100_SEC_WIDTH-1: 0]	s0;
reg 	[`ATCRTC100_MIN_WIDTH-1: 0]	s1;
reg 	[`ATCRTC100_HOUR_WIDTH-1: 0]	s2;
reg 	[`ATCRTC100_DAY_WIDTH-1: 0]	s3;

reg					alarm_wakeup;

reg					s4;

wire					s5;
wire					s6;
wire					s7;
wire	[`ATCRTC100_SDO_WIDTH-1: 0]	rtc_ctr;

reg	[`ATCRTC100_SEC_WIDTH-1: 0]	s8;
reg	[`ATCRTC100_MIN_WIDTH-1: 0]	s9;
reg	[`ATCRTC100_HOUR_WIDTH-1: 0]	s10;
reg	[`ATCRTC100_DAY_WIDTH-1: 0]	s11;

wire	[`ATCRTC100_SDO_SEC_WIDTH-1: 0]	s12;
wire	[`ATCRTC100_MIN_WIDTH-1: 0]	s13;
wire	[`ATCRTC100_HOUR_WIDTH-1: 0]	s14;
wire	[`ATCRTC100_DAY_WIDTH-1: 0]	s15;

wire					s16;

wire					min_trim_trig;
wire					hour_trim_trig;
wire					day_trim_trig;
wire					resume_trim_min;
wire					resume_trim_hour;
wire					resume_trim_day;

`ifdef ATCRTC100_HALF_SECOND_SUPPORT
	assign rtc_ctr = {s3, s2, s1, s0[`ATCRTC100_SEC_WIDTH-1:1]};
`else
	assign rtc_ctr = {s3, s2, s1, s0};
`endif

assign {s15, s14, s13, s12} = ctr_sdo;

assign s5	=          (s0 == SEC_OVERFLOW);
assign s6	= s5 & (s1 == MIN_OVERFLOW);
assign s7	= s6 & (s2 == HOUR_OVERFLOW);

assign min_trim_trig =
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
			(s0 == (SEC_OVERFLOW - 7'd2));
`else
			(s0 == (SEC_OVERFLOW - 6'd1));
`endif
assign hour_trim_trig = min_trim_trig  & (s1 == MIN_OVERFLOW);
assign day_trim_trig  = hour_trim_trig & (s2 == HOUR_OVERFLOW);

assign resume_trim_min  =
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
			(s0 == (SEC_OVERFLOW - 7'd1));
`else
			s5;
`endif
assign resume_trim_hour = resume_trim_min  & (s1 == MIN_OVERFLOW);
assign resume_trim_day  = resume_trim_hour & (s2 == HOUR_OVERFLOW);

`ifdef ATCRTC100_HALF_SECOND_SUPPORT
	assign s16 = ({s2, s1, s0} == {rtc_alm_rtclk, 1'b0});
	assign hsec_int_detect	= s4;
	assign sec_int_detect	= s4 & (s0[0] == 1'b0);
`else
	assign s16 = ({s2, s1, s0} == rtc_alm_rtclk);
	assign sec_int_detect	= s4;
`endif


assign min_int_detect	= sec_int_detect  & (s0 == {`ATCRTC100_SEC_WIDTH{1'b0}});
assign hour_int_detect	= min_int_detect  & (s1 == {`ATCRTC100_MIN_WIDTH{1'b0}});
assign day_int_detect	= hour_int_detect & (s2 == {`ATCRTC100_HOUR_WIDTH{1'b0}});
assign alarm_int_detect	= s4 & s16;

always @ (posedge rtc_clk or negedge rtc_rstn) begin
	if (~rtc_rstn)
		s4 <= 1'b0;
	else
		s4 <= rtc_1hz_pls;
end


always @(*) begin
	if (ctr_upd_sync)
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
		s8 = {s12, 1'b0};
`else
		s8 = s12;
`endif
	else if (rtc_en_rtclk & rtc_1hz_pls) begin
		if (s5)
			s8 = {`ATCRTC100_SEC_WIDTH{1'b0}};
		else
			s8 = (s0 + {{(`ATCRTC100_SEC_WIDTH - 1){1'b0}}, 1'b1});
	end
	else
		s8 = s0;
end

always @(*) begin
	if (ctr_upd_sync)
		s9 = s13;
	else if (rtc_en_rtclk & rtc_1hz_pls) begin
		if (s5) begin
			if(s6)
				s9 = {`ATCRTC100_MIN_WIDTH{1'b0}};
			else
				s9 = (s1 + {{(`ATCRTC100_MIN_WIDTH - 1){1'b0}}, 1'b1});
		end
		else
			s9 = s1;
	end
	else
		s9 = s1;
end

always @(*) begin
	if (ctr_upd_sync)
		s10 = s14;
	else if (rtc_en_rtclk & rtc_1hz_pls) begin
		if (s6) begin
			if (s7)
				s10 = {`ATCRTC100_HOUR_WIDTH{1'b0}};
			else
				s10 = (s2 + {{(`ATCRTC100_HOUR_WIDTH - 1){1'b0}}, 1'b1});
		end
		else
			s10 = s2;
	end
	else
		s10 = s2;
end

always @(*) begin
	if (ctr_upd_sync)
		s11 = s15;
	else if (rtc_en_rtclk & rtc_1hz_pls) begin
		if (s7)
			s11 = (s3 + {{(`ATCRTC100_DAY_WIDTH - 1){1'b0}}, 1'b1});
		else
			s11 = s3;
	end
	else
		s11 = s3;
end


always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (~rtc_rstn)
		s0 <= {`ATCRTC100_SEC_WIDTH{1'b0}};
	else
		s0 <= s8;
end

always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (~rtc_rstn)
		s1 <= {`ATCRTC100_MIN_WIDTH{1'b0}};
	else
		s1 <= s9;
end

always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (~rtc_rstn)
		s2 <= {`ATCRTC100_HOUR_WIDTH{1'b0}};
	else
		s2 <= s10;
end

always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (~rtc_rstn)
		s3 <= {`ATCRTC100_DAY_WIDTH{1'b0}};
	else
		s3 <= s11;
end


always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (~rtc_rstn)
		alarm_wakeup <= 1'b0;
	else if (alarm_wakeup)
		alarm_wakeup <= 1'b0;
	else if (s4 & s16 & rtc_en_rtclk & alarm_wakeup_en_rtclk)
		alarm_wakeup <= 1'b1;
end

endmodule
