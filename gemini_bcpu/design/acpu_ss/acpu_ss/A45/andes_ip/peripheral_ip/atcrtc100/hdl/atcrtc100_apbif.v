// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcrtc100_config.vh"
`include "atcrtc100_const.vh"

module atcrtc100_apbif (
	  pclk,
	  presetn,
	  psel,
	  penable,
	  paddr,
	  pwdata,
	  pwrite,
	  prdata,
	  rtc_clk,
	  rtc_rstn,
	  rtc_clk_falling_edge,
	  rtc_ctr,
	  sec_int_detect,
	  min_int_detect,
	  hour_int_detect,
	  day_int_detect,
	  alarm_int_detect,
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
	  hsec_int_detect,
	  rtc_int_hsec,
`endif
	  ctr_sdo,
	  rtc_alm_rtclk,
	  ctr_upd_sync,
	  rtc_en_rtclk,
	  alarm_wakeup_en_rtclk,
	  ft_en_rtclk,
	  rtc_int_sec,
	  rtc_int_min,
	  rtc_int_hour,
	  rtc_int_day,
	  rtc_int_alarm,
	  reg_sec_trim_rtclk,
	  reg_sign_sec_trim_rtclk,
	  reg_min_trim_rtclk,
	  reg_sign_min_trim_rtclk,
	  reg_hour_trim_rtclk,
	  reg_sign_hour_trim_rtclk,
	  reg_day_trim_rtclk,
	  reg_sign_day_trim_rtclk
);

input					pclk;
input					presetn;
input					psel;
input					penable;
input	[5:2]				paddr;
input	[31:0]				pwdata;
input					pwrite;
output	[31:0]				prdata;

input					rtc_clk;
input					rtc_rstn;

input					rtc_clk_falling_edge;
input	[`ATCRTC100_SDO_WIDTH-1:0]	rtc_ctr;

input					sec_int_detect;
input					min_int_detect;
input					hour_int_detect;
input					day_int_detect;
input					alarm_int_detect;
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
	input				hsec_int_detect;
	output				rtc_int_hsec;
`endif

output	[`ATCRTC100_SDO_WIDTH-1:0]	ctr_sdo;
output	[`ATCRTC100_ALM_WIDTH-1:0]	rtc_alm_rtclk;
output					ctr_upd_sync;
output					rtc_en_rtclk;
output					alarm_wakeup_en_rtclk;
output					ft_en_rtclk;
output					rtc_int_sec;
output					rtc_int_min;
output					rtc_int_hour;
output					rtc_int_day;
output					rtc_int_alarm;
output	[4:0]				reg_sec_trim_rtclk;
output					reg_sign_sec_trim_rtclk;
output	[4:0]				reg_min_trim_rtclk;
output					reg_sign_min_trim_rtclk;
output	[4:0]				reg_hour_trim_rtclk;
output					reg_sign_hour_trim_rtclk;
output	[4:0]				reg_day_trim_rtclk;
output					reg_sign_day_trim_rtclk;

reg 	[5:2]				s0;

reg	[`ATCRTC100_SDO_WIDTH-1:0]	ctr_sdo;
reg	[`ATCRTC100_ALM_WIDTH-1:0]	s1;
reg	[`ATCRTC100_CTL_WIDTH-1:0]	s2;
reg	[`ATCRTC100_ST_WIDTH-1:2]	s3;
reg	[4:0]				s4;
reg					s5;
reg	[4:0]				s6;
reg					s7;
reg	[4:0]				s8;
reg					s9;
reg	[4:0]				s10;
reg					s11;

reg	[`ATCRTC100_ALM_WIDTH-1:0]	rtc_alm_rtclk;
reg	[`ATCRTC100_CTL_WIDTH-1:0]	s12;
reg	[4:0]				reg_sec_trim_rtclk;
reg					reg_sign_sec_trim_rtclk;
reg	[4:0]				reg_min_trim_rtclk;
reg					reg_sign_min_trim_rtclk;
reg	[4:0]				reg_hour_trim_rtclk;
reg					reg_sign_hour_trim_rtclk;
reg	[4:0]				reg_day_trim_rtclk;
reg					reg_sign_day_trim_rtclk;

reg					s13;
reg					ctr_upd_sync;
reg					s14;
reg					s15;
reg					s16;
reg					s17;
reg					s18;
reg					s19;

reg					s20;
wire					rtc_en_rtclk;
wire					alarm_wakeup_en_rtclk;
wire					ft_en_rtclk;
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
wire					s31;
wire					s32;

wire					s33;
wire					s34;
wire					s35;
wire					s36;
wire					s37;

wire					s38;

wire					rtc_int_sec;
wire					rtc_int_min;
wire					rtc_int_hour;
wire					rtc_int_day;
wire					rtc_int_alarm;
wire	[31:0]				s39, s40, s41;
wire                                    s42;

`ifdef ATCRTC100_HALF_SECOND_SUPPORT
	wire			s43;
	wire			s44;
	wire			rtc_int_hsec;
	assign rtc_int_hsec = s3[7];
`endif

assign {rtc_int_sec, rtc_int_min, rtc_int_hour, rtc_int_day, rtc_int_alarm} = s3[6:2];

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s0 <= 4'b0;
	else if (psel)
		s0 <= paddr;
end

assign s27  = ({s0, 2'b0} == 6'h0);
assign s28  = ({s0, 2'b0} == 6'h10);
assign s29  = ({s0, 2'b0} == 6'h14);
assign s30  = ({s0, 2'b0} == 6'h18);
assign s31   = ({s0, 2'b0} == 6'h1c);
assign s32 = ({s0, 2'b0} == 6'h20);

generate

localparam I32_M_ATCRTC100_SDO_WIDTH = 32 - `ATCRTC100_SDO_WIDTH;
if (I32_M_ATCRTC100_SDO_WIDTH > 0) begin : atcrtc100_sdo_width_greater_zero
	assign s39 = {{I32_M_ATCRTC100_SDO_WIDTH{1'b0}}, ctr_sdo};
end
else begin : atcrtc100_sdo_width_eq_zero
	assign s39 = ctr_sdo[31:0];
end

localparam I32_M_ATCRTC100_ALM_WIDTH = 32 - `ATCRTC100_ALM_WIDTH;
if (I32_M_ATCRTC100_ALM_WIDTH > 0) begin : atcrtc100_alm_width_greater_zero
	assign s40 = {{I32_M_ATCRTC100_ALM_WIDTH{1'b0}}, s1};
end
else begin : atcrtc100_alm_width_eq_zero
	assign s40 = s1[31:0];
end

localparam I32_M_ATCRTC100_CTL_WIDTH = 32 - `ATCRTC100_CTL_WIDTH;
if (I32_M_ATCRTC100_CTL_WIDTH > 0) begin : atcrtc100_ctl_width_greater_zero
	assign s41 = {{I32_M_ATCRTC100_CTL_WIDTH{1'b0}}, s2};
end
else begin : atcrtc100_ctl_width_eq_zero
	assign s41 = s2[31:0];
end

endgenerate

assign prdata =
	({32{s27}} & `ATCRTC100_PRODUCT_ID) |
	({32{s28}} & s39) |
	({32{s29}} & s40) |
	({32{s30}} & s41) |
	({32{s31}}  & {15'b0, s20, {(16 - `ATCRTC100_ST_WIDTH){1'b0}}, s3, 2'b0}) |
	({32{s32}} & {s11,  2'b0, s10,
	                       s9, 2'b0, s8,
			       s7,  2'b0, s6,
			       s5,  2'b0, s4});

assign s38 = psel & pwrite & penable;


always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s13 <= 1'b0;
	else if (s38 & s28)
		s13 <= 1'b1;
	else if (rtc_clk_falling_edge)
		s13 <= 1'b0;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		ctr_upd_sync <= 1'b0;
	else if (rtc_clk_falling_edge)
		ctr_upd_sync <= s13;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s14 <= 1'b0;
	else if (s38 & s29)
		s14 <= 1'b1;
	else if (rtc_clk_falling_edge)
		s14 <= 1'b0;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s15 <= 1'b0;
	else if (rtc_clk_falling_edge)
		s15 <= s14;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s16 <= 1'b0;
	else if (s38 & s30)
		s16 <= 1'b1;
	else if (rtc_clk_falling_edge)
		s16 <= 1'b0;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s17 <= 1'b0;
	else if (rtc_clk_falling_edge)
		s17 <=  s16;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s18 <= 1'b0;
	else if (s38 & s32)
		s18 <= 1'b1;
	else if (rtc_clk_falling_edge)
		s18 <= 1'b0;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s19 <= 1'b0;
	else if (rtc_clk_falling_edge)
		s19 <= s18;
end

assign s42 =   s13 | ctr_upd_sync
                   | s14 | s15
		   | s16 | s17
		   | s18 | s19 ;

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s20 <= 1'b1;
	else if (s38 & (s28 | s29 | s30 | s32))
		s20 <= 1'b0;
	else if (!s42)
		s20 <= 1'b1;
end


always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		ctr_sdo <= {(`ATCRTC100_SDO_WIDTH){1'b0}};
	else if (s38 & s28 & !ctr_upd_sync)
		ctr_sdo <= pwdata[`ATCRTC100_SDO_WIDTH-1: 0];
	else if (rtc_clk_falling_edge & !s13)
		ctr_sdo <= rtc_ctr;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s1 <= {(`ATCRTC100_ALM_WIDTH){1'b0}};
	else if (s38 & s29 & !s15)
		s1 <= pwdata[`ATCRTC100_ALM_WIDTH-1: 0];
	else if (rtc_clk_falling_edge & !s14)
		s1 <= rtc_alm_rtclk;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s2 <= {(`ATCRTC100_CTL_WIDTH){1'b0}};
	else if (s38 & s30 & !s17)
		s2 <= pwdata[`ATCRTC100_CTL_WIDTH-1:0];
	else if (rtc_clk_falling_edge & !s16)
		s2 <= s12;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
		s4       <= 5'd0;
		s5  <= 1'd0;
		s6       <= 5'd0;
		s7  <= 1'd0;
		s8      <= 5'd0;
		s9 <= 1'd0;
		s10       <= 5'd0;
		s11  <= 1'd0;
	end
	else if (s38 & s32 & !s19) begin
		s4       <= pwdata[4:0];
		s5  <= pwdata[7];
		s6       <= pwdata[12:8];
		s7  <= pwdata[15];
		s8      <= pwdata[20:16];
		s9 <= pwdata[23];
		s10       <= pwdata[28:24];
		s11  <= pwdata[31];
	end
	else if (rtc_clk_falling_edge & !s18) begin
		s4       <= reg_sec_trim_rtclk;
		s5  <= reg_sign_sec_trim_rtclk;
		s6       <= reg_min_trim_rtclk;
		s7  <= reg_sign_min_trim_rtclk;
		s8      <= reg_hour_trim_rtclk;
		s9 <= reg_sign_hour_trim_rtclk;
		s10       <= reg_day_trim_rtclk;
		s11  <= reg_sign_day_trim_rtclk;
	end
end

always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (~rtc_rstn)
		rtc_alm_rtclk <= {(`ATCRTC100_ALM_WIDTH){1'b0}};
	else if (s15)
		rtc_alm_rtclk <= s1;
end

always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (~rtc_rstn)
		s12 <= {(`ATCRTC100_CTL_WIDTH){1'b0}};
	else if (s17)
		s12 <= s2;
end

always @(posedge rtc_clk or negedge rtc_rstn) begin
	if (~rtc_rstn) begin
		reg_sec_trim_rtclk       <= 5'd0;
		reg_sign_sec_trim_rtclk  <= 1'd0;
		reg_min_trim_rtclk       <= 5'd0;
		reg_sign_min_trim_rtclk  <= 1'd0;
		reg_hour_trim_rtclk      <= 5'd0;
		reg_sign_hour_trim_rtclk <= 1'd0;
		reg_day_trim_rtclk       <= 5'd0;
		reg_sign_day_trim_rtclk  <= 1'd0;
	end
	else if (s19) begin
		reg_sec_trim_rtclk       <= s4;
		reg_sign_sec_trim_rtclk  <= s5;
		reg_min_trim_rtclk       <= s6;
		reg_sign_min_trim_rtclk  <= s7;
		reg_hour_trim_rtclk      <= s8;
		reg_sign_hour_trim_rtclk <= s9;
		reg_day_trim_rtclk       <= s10;
		reg_sign_day_trim_rtclk  <= s11;
	end
end

assign {s21, s22, s23, s24, s25} = s2[6:2];
assign s26 = s2[0];
`ifdef ATCRTC100_HALF_SECOND_SUPPORT
assign s43 = s2[7];
`endif

assign rtc_en_rtclk = s12[0];
assign alarm_wakeup_en_rtclk = s12[1];
assign ft_en_rtclk  = s12[8];

assign s33  = s31 & s38 & pwdata[6];
assign s34  = s31 & s38 & pwdata[5];
assign s35 = s31 & s38 & pwdata[4];
assign s36  = s31 & s38 & pwdata[3];
assign s37  = s31 & s38 & pwdata[2];

`ifdef ATCRTC100_HALF_SECOND_SUPPORT
assign s44 = s31 & s38 & pwdata[7];

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s3[7] <= 1'b0;
	else if (s44)
		s3[7] <= 1'b0;
	else if (rtc_clk_falling_edge & s26 & s43 & hsec_int_detect)
		s3[7] <= 1'b1;
end
`endif

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s3[6] <= 1'b0;
	else if (s33)
		s3[6] <= 1'b0;
	else if (rtc_clk_falling_edge & s26 & s21 & sec_int_detect)
		s3[6] <= 1'b1;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s3[5] <= 1'b0;
	else if (s34)
		s3[5] <= 1'b0;
	else if (rtc_clk_falling_edge & s26 & s22 & min_int_detect)
		s3[5] <= 1'b1;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s3[4] <= 1'b0;
	else if (s35)
		s3[4] <= 1'b0;
	else if (rtc_clk_falling_edge & s26 & s23 & hour_int_detect)
		s3[4] <= 1'b1;
end

always  @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s3[3] <= 1'b0;
	else if (s36)
		s3[3] <= 1'b0;
	else if (rtc_clk_falling_edge & s26 & s24 & day_int_detect)
		s3[3] <= 1'b1;
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn)
		s3[2] <= 1'b0;
	else if (s37)
		s3[2] <= 1'b0;
	else if (rtc_clk_falling_edge & s26 & s25 & alarm_int_detect)
		s3[2] <= 1'b1;
end

endmodule


