`timescale 1 ns / 1 ns
module main
	(
		clk,
		reset,
		start,
		finish,
		return_val
	);
  
`define MEMORY_CONTROLLER_TAGS 7
`define MEMORY_CONTROLLER_TAG_SIZE 3
`define TAG_countLeadingZerosHigh_1302 `MEMORY_CONTROLLER_TAG_SIZE'd0
`define TAG_float_exception_flags `MEMORY_CONTROLLER_TAG_SIZE'd1
`define TAG_test_in `MEMORY_CONTROLLER_TAG_SIZE'd2
`define TAG_test_out `MEMORY_CONTROLLER_TAG_SIZE'd3
`define TAG__str `MEMORY_CONTROLLER_TAG_SIZE'd4
`define TAG__str1 `MEMORY_CONTROLLER_TAG_SIZE'd5
`define TAG__str2 `MEMORY_CONTROLLER_TAG_SIZE'd6
`define MEMORY_CONTROLLER_ADDR_SIZE `MEMORY_CONTROLLER_TAG_SIZE+32
`define MEMORY_CONTROLLER_DATA_SIZE 64

output reg [31:0] return_val;
input clk;
input reset;
input start;
output reg finish;
reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] memory_controller_address;
reg memory_controller_write_enable;
reg [`MEMORY_CONTROLLER_DATA_SIZE-1:0] memory_controller_in;
wire [`MEMORY_CONTROLLER_DATA_SIZE-1:0] memory_controller_out;



memory_controller memory_controller_inst (
	.clk( clk ),
	.memory_controller_address( memory_controller_address ),
	.memory_controller_write_enable( memory_controller_write_enable ),
	.memory_controller_in( memory_controller_in ),
	.memory_controller_out( memory_controller_out )
);

reg roundAndPackFloat64_start;
wire roundAndPackFloat64_finish;
wire [63:0] roundAndPackFloat64_return_val;
wire [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] roundAndPackFloat64_memory_controller_address;
wire roundAndPackFloat64_memory_controller_write_enable;
wire [`MEMORY_CONTROLLER_DATA_SIZE-1:0] roundAndPackFloat64_memory_controller_in;
reg [`MEMORY_CONTROLLER_DATA_SIZE-1:0] roundAndPackFloat64_memory_controller_out;
reg [31:0] roundAndPackFloat64_zSign;
reg [31:0] roundAndPackFloat64_zExp;
reg [63:0] roundAndPackFloat64_zSig;
roundAndPackFloat64 roundAndPackFloat64_inst(
	.clk( clk ),
	.reset( reset ),
	.start( roundAndPackFloat64_start ),
	.finish( roundAndPackFloat64_finish ),
	.return_val( roundAndPackFloat64_return_val ),
	.memory_controller_address( roundAndPackFloat64_memory_controller_address ),
	.memory_controller_write_enable( roundAndPackFloat64_memory_controller_write_enable ),
	.memory_controller_in( roundAndPackFloat64_memory_controller_in ),
	.memory_controller_out( roundAndPackFloat64_memory_controller_out ),
	.zSign( roundAndPackFloat64_zSign ),
	.zExp( roundAndPackFloat64_zExp ),
	.zSig( roundAndPackFloat64_zSig )
);

reg float64_mul_start;
wire float64_mul_finish;
wire [63:0] float64_mul_return_val;
wire [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] float64_mul_memory_controller_address;
wire float64_mul_memory_controller_write_enable;
wire [`MEMORY_CONTROLLER_DATA_SIZE-1:0] float64_mul_memory_controller_in;
reg [`MEMORY_CONTROLLER_DATA_SIZE-1:0] float64_mul_memory_controller_out;
reg [63:0] float64_mul_a;
reg [63:0] float64_mul_b;
float64_mul float64_mul_inst(
	.clk( clk ),
	.reset( reset ),
	.start( float64_mul_start ),
	.finish( float64_mul_finish ),
	.return_val( float64_mul_return_val ),
	.memory_controller_address( float64_mul_memory_controller_address ),
	.memory_controller_write_enable( float64_mul_memory_controller_write_enable ),
	.memory_controller_in( float64_mul_memory_controller_in ),
	.memory_controller_out( float64_mul_memory_controller_out ),
	.a( float64_mul_a ),
	.b( float64_mul_b )
);
reg [9:0] cur_state;

parameter Wait = 10'd0;
parameter bb_nph = 10'd1;
parameter bb = 10'd2;
parameter bb_1 = 10'd3;
parameter bb_2 = 10'd4;
parameter bb_3 = 10'd5;
parameter bb_4 = 10'd6;
parameter bb_4_call_0 = 10'd7;
parameter bb_4_call_1 = 10'd8;
parameter bb_5 = 10'd9;
parameter bb_i = 10'd10;
parameter bb_i_1 = 10'd11;
parameter bb_i_2 = 10'd12;
parameter bb_i_3 = 10'd13;
parameter bb_i_4 = 10'd14;
parameter bb_i_5 = 10'd15;
parameter bb1_i_i = 10'd16;
parameter bb1_i_i_1 = 10'd17;
parameter bb1_i_i_2 = 10'd18;
parameter bb1_i_i_3 = 10'd19;
parameter bb1_i_i_4 = 10'd20;
parameter bb1_i_i_5 = 10'd21;
parameter bb1_i_i_6 = 10'd22;
parameter bb1_i_i_7 = 10'd23;
parameter bb1_i_i_8 = 10'd24;
parameter bb1_i_i_9 = 10'd25;
parameter bb1_i_i_10 = 10'd26;
parameter bb1_i_i_11 = 10'd27;
parameter bb1_i_i_12 = 10'd28;
parameter bb1_i_i_13 = 10'd29;
parameter bb1_i_i_14 = 10'd30;
parameter bb1_i_i_15 = 10'd31;
parameter bb1_i_i_16 = 10'd32;
parameter int32_to_float64_exit_i = 10'd33;
parameter int32_to_float64_exit_i_call_0 = 10'd34;
parameter int32_to_float64_exit_i_call_1 = 10'd35;
parameter int32_to_float64_exit_i_1 = 10'd36;
parameter int32_to_float64_exit_i_2 = 10'd37;
parameter int32_to_float64_exit_i_3 = 10'd38;
parameter int32_to_float64_exit_i_4 = 10'd39;
parameter int32_to_float64_exit_i_5 = 10'd40;
parameter bb_i_i = 10'd41;
parameter bb_i_i_1 = 10'd42;
parameter bb1_i1_i = 10'd43;
parameter bb1_i1_i_1 = 10'd44;
parameter bb1_i1_i_2 = 10'd45;
parameter bb_i14_i65_i_i = 10'd46;
parameter bb_i14_i65_i_i_1 = 10'd47;
parameter bb_i14_i65_i_i_2 = 10'd48;
parameter float64_is_signaling_nan_exit16_i66_i_i = 10'd49;
parameter float64_is_signaling_nan_exit16_i66_i_i_1 = 10'd50;
parameter float64_is_signaling_nan_exit16_i66_i_i_2 = 10'd51;
parameter bb_i_i69_i_i = 10'd52;
parameter bb_i_i69_i_i_1 = 10'd53;
parameter bb_i_i69_i_i_2 = 10'd54;
parameter float64_is_signaling_nan_exit_i70_i_i = 10'd55;
parameter float64_is_signaling_nan_exit_i70_i_i_1 = 10'd56;
parameter float64_is_signaling_nan_exit_i70_i_i_2 = 10'd57;
parameter float64_is_signaling_nan_exit_i70_i_i_3 = 10'd58;
parameter bb_i71_i_i = 10'd59;
parameter bb_i71_i_i_1 = 10'd60;
parameter bb_i71_i_i_2 = 10'd61;
parameter bb_i71_i_i_3 = 10'd62;
parameter bb1_i72_i_i = 10'd63;
parameter bb1_i72_i_i_1 = 10'd64;
parameter bb2_i73_i_i = 10'd65;
parameter bb2_i73_i_i_1 = 10'd66;
parameter bb3_i75_i_i = 10'd67;
parameter bb2_i_i = 10'd68;
parameter bb2_i_i_1 = 10'd69;
parameter bb3_i_i = 10'd70;
parameter bb3_i_i_1 = 10'd71;
parameter bb4_i_i = 10'd72;
parameter bb4_i_i_1 = 10'd73;
parameter bb4_i_i_2 = 10'd74;
parameter bb_i14_i49_i_i = 10'd75;
parameter bb_i14_i49_i_i_1 = 10'd76;
parameter bb_i14_i49_i_i_2 = 10'd77;
parameter float64_is_signaling_nan_exit16_i50_i_i = 10'd78;
parameter float64_is_signaling_nan_exit16_i50_i_i_1 = 10'd79;
parameter float64_is_signaling_nan_exit16_i50_i_i_2 = 10'd80;
parameter bb_i_i53_i_i = 10'd81;
parameter bb_i_i53_i_i_1 = 10'd82;
parameter bb_i_i53_i_i_2 = 10'd83;
parameter float64_is_signaling_nan_exit_i54_i_i = 10'd84;
parameter float64_is_signaling_nan_exit_i54_i_i_1 = 10'd85;
parameter float64_is_signaling_nan_exit_i54_i_i_2 = 10'd86;
parameter float64_is_signaling_nan_exit_i54_i_i_3 = 10'd87;
parameter bb_i55_i_i = 10'd88;
parameter bb_i55_i_i_1 = 10'd89;
parameter bb_i55_i_i_2 = 10'd90;
parameter bb_i55_i_i_3 = 10'd91;
parameter bb1_i56_i_i = 10'd92;
parameter bb1_i56_i_i_1 = 10'd93;
parameter bb2_i57_i_i = 10'd94;
parameter bb2_i57_i_i_1 = 10'd95;
parameter bb3_i59_i_i = 10'd96;
parameter bb5_i_i = 10'd97;
parameter bb5_i_i_1 = 10'd98;
parameter bb5_i_i_2 = 10'd99;
parameter bb5_i_i_3 = 10'd100;
parameter bb6_i_i = 10'd101;
parameter bb6_i_i_1 = 10'd102;
parameter bb7_i_i = 10'd103;
parameter bb8_i_i = 10'd104;
parameter bb8_i_i_1 = 10'd105;
parameter bb9_i_i = 10'd106;
parameter bb9_i_i_1 = 10'd107;
parameter bb9_i_i_2 = 10'd108;
parameter bb_i14_i_i_i = 10'd109;
parameter bb_i14_i_i_i_1 = 10'd110;
parameter bb_i14_i_i_i_2 = 10'd111;
parameter float64_is_signaling_nan_exit16_i_i_i = 10'd112;
parameter float64_is_signaling_nan_exit16_i_i_i_1 = 10'd113;
parameter float64_is_signaling_nan_exit16_i_i_i_2 = 10'd114;
parameter bb_i_i43_i_i = 10'd115;
parameter bb_i_i43_i_i_1 = 10'd116;
parameter bb_i_i43_i_i_2 = 10'd117;
parameter float64_is_signaling_nan_exit_i_i_i = 10'd118;
parameter float64_is_signaling_nan_exit_i_i_i_1 = 10'd119;
parameter float64_is_signaling_nan_exit_i_i_i_2 = 10'd120;
parameter float64_is_signaling_nan_exit_i_i_i_3 = 10'd121;
parameter bb_i_i_i = 10'd122;
parameter bb_i_i_i_1 = 10'd123;
parameter bb_i_i_i_2 = 10'd124;
parameter bb_i_i_i_3 = 10'd125;
parameter bb1_i44_i_i = 10'd126;
parameter bb1_i44_i_i_1 = 10'd127;
parameter bb2_i45_i_i = 10'd128;
parameter bb2_i45_i_i_1 = 10'd129;
parameter bb3_i_i2_i = 10'd130;
parameter bb10_i_i = 10'd131;
parameter bb12_i_i = 10'd132;
parameter bb12_i_i_1 = 10'd133;
parameter bb13_i_i = 10'd134;
parameter bb13_i_i_1 = 10'd135;
parameter bb13_i_i_2 = 10'd136;
parameter bb13_i_i_3 = 10'd137;
parameter bb14_i_i = 10'd138;
parameter bb14_i_i_1 = 10'd139;
parameter bb15_i_i = 10'd140;
parameter bb15_i_i_1 = 10'd141;
parameter bb16_i_i = 10'd142;
parameter bb16_i_i_1 = 10'd143;
parameter bb_i_i32_i_i = 10'd144;
parameter bb1_i_i34_i_i = 10'd145;
parameter bb1_i_i34_i_i_1 = 10'd146;
parameter normalizeFloat64Subnormal_exit42_i_i = 10'd147;
parameter normalizeFloat64Subnormal_exit42_i_i_1 = 10'd148;
parameter normalizeFloat64Subnormal_exit42_i_i_2 = 10'd149;
parameter normalizeFloat64Subnormal_exit42_i_i_3 = 10'd150;
parameter normalizeFloat64Subnormal_exit42_i_i_4 = 10'd151;
parameter normalizeFloat64Subnormal_exit42_i_i_5 = 10'd152;
parameter normalizeFloat64Subnormal_exit42_i_i_6 = 10'd153;
parameter normalizeFloat64Subnormal_exit42_i_i_7 = 10'd154;
parameter normalizeFloat64Subnormal_exit42_i_i_8 = 10'd155;
parameter normalizeFloat64Subnormal_exit42_i_i_9 = 10'd156;
parameter normalizeFloat64Subnormal_exit42_i_i_10 = 10'd157;
parameter normalizeFloat64Subnormal_exit42_i_i_11 = 10'd158;
parameter normalizeFloat64Subnormal_exit42_i_i_12 = 10'd159;
parameter normalizeFloat64Subnormal_exit42_i_i_13 = 10'd160;
parameter bb17_i_i = 10'd161;
parameter bb17_i_i_1 = 10'd162;
parameter bb18_i_i = 10'd163;
parameter bb18_i_i_1 = 10'd164;
parameter bb19_i_i = 10'd165;
parameter bb20_i_i = 10'd166;
parameter bb20_i_i_1 = 10'd167;
parameter bb_i_i_i_i = 10'd168;
parameter bb1_i_i_i_i = 10'd169;
parameter bb1_i_i_i_i_1 = 10'd170;
parameter normalizeFloat64Subnormal_exit_i_i = 10'd171;
parameter normalizeFloat64Subnormal_exit_i_i_1 = 10'd172;
parameter normalizeFloat64Subnormal_exit_i_i_2 = 10'd173;
parameter normalizeFloat64Subnormal_exit_i_i_3 = 10'd174;
parameter normalizeFloat64Subnormal_exit_i_i_4 = 10'd175;
parameter normalizeFloat64Subnormal_exit_i_i_5 = 10'd176;
parameter normalizeFloat64Subnormal_exit_i_i_6 = 10'd177;
parameter normalizeFloat64Subnormal_exit_i_i_7 = 10'd178;
parameter normalizeFloat64Subnormal_exit_i_i_8 = 10'd179;
parameter normalizeFloat64Subnormal_exit_i_i_9 = 10'd180;
parameter normalizeFloat64Subnormal_exit_i_i_10 = 10'd181;
parameter normalizeFloat64Subnormal_exit_i_i_11 = 10'd182;
parameter normalizeFloat64Subnormal_exit_i_i_12 = 10'd183;
parameter normalizeFloat64Subnormal_exit_i_i_13 = 10'd184;
parameter bb21_i_i = 10'd185;
parameter bb21_i_i_1 = 10'd186;
parameter bb21_i_i_2 = 10'd187;
parameter bb21_i_i_3 = 10'd188;
parameter bb21_i_i_4 = 10'd189;
parameter bb21_i_i_5 = 10'd190;
parameter bb21_i_i_6 = 10'd191;
parameter bb21_i_i_7 = 10'd192;
parameter bb21_i_i_8 = 10'd193;
parameter bb21_i_i_9 = 10'd194;
parameter bb1_i_i_i = 10'd195;
parameter bb1_i_i_i_1 = 10'd196;
parameter bb1_i_i_i_2 = 10'd197;
parameter bb2_i_i3_i = 10'd198;
parameter bb2_i_i3_i_1 = 10'd199;
parameter bb4_i_i_i = 10'd200;
parameter bb4_i_i_i_1 = 10'd201;
parameter bb4_i_i_i_2 = 10'd202;
parameter bb4_i_i_i_3 = 10'd203;
parameter bb4_i_i_i_4 = 10'd204;
parameter bb4_i_i_i_5 = 10'd205;
parameter bb4_i_i_i_6 = 10'd206;
parameter bb4_i_i_i_7 = 10'd207;
parameter bb4_i_i_i_8 = 10'd208;
parameter bb_nph_i_i_i = 10'd209;
parameter bb_nph_i_i_i_1 = 10'd210;
parameter bb_nph_i_i_i_2 = 10'd211;
parameter bb_nph_i_i_i_3 = 10'd212;
parameter bb_nph_i_i_i_4 = 10'd213;
parameter bb_nph_i_i_i_5 = 10'd214;
parameter bb5_i_i_i = 10'd215;
parameter bb5_i_i_i_1 = 10'd216;
parameter bb5_i_i_i_2 = 10'd217;
parameter bb5_i_i_i_3 = 10'd218;
parameter bb5_i_i_i_4 = 10'd219;
parameter bb5_i_i_i_5 = 10'd220;
parameter bb5_i_i_i_6 = 10'd221;
parameter bb5_i_i_i_7 = 10'd222;
parameter bb5_i_i_i_8 = 10'd223;
parameter bb6_bb7_crit_edge_i_i_i = 10'd224;
parameter bb6_bb7_crit_edge_i_i_i_1 = 10'd225;
parameter bb7_i_i_i = 10'd226;
parameter bb7_i_i_i_1 = 10'd227;
parameter bb7_i_i_i_2 = 10'd228;
parameter bb7_i_i_i_3 = 10'd229;
parameter bb7_i_i_i_4 = 10'd230;
parameter bb8_i_i_i = 10'd231;
parameter bb10_i_i4_i = 10'd232;
parameter bb10_i_i4_i_1 = 10'd233;
parameter estimateDiv128To64_exit_i_i = 10'd234;
parameter estimateDiv128To64_exit_i_i_1 = 10'd235;
parameter estimateDiv128To64_exit_i_i_2 = 10'd236;
parameter estimateDiv128To64_exit_i_i_3 = 10'd237;
parameter bb24_i_i = 10'd238;
parameter bb24_i_i_1 = 10'd239;
parameter bb24_i_i_2 = 10'd240;
parameter bb24_i_i_3 = 10'd241;
parameter bb24_i_i_4 = 10'd242;
parameter bb24_i_i_5 = 10'd243;
parameter bb24_i_i_6 = 10'd244;
parameter bb24_i_i_7 = 10'd245;
parameter bb24_i_i_8 = 10'd246;
parameter bb24_i_i_9 = 10'd247;
parameter bb24_i_i_10 = 10'd248;
parameter bb_nph_i_i = 10'd249;
parameter bb_nph_i_i_1 = 10'd250;
parameter bb_nph_i_i_2 = 10'd251;
parameter bb_nph_i_i_3 = 10'd252;
parameter bb_nph_i_i_4 = 10'd253;
parameter bb_nph_i_i_5 = 10'd254;
parameter bb_nph_i_i_6 = 10'd255;
parameter bb_nph_i_i_7 = 10'd256;
parameter bb25_i_i = 10'd257;
parameter bb25_i_i_1 = 10'd258;
parameter bb25_i_i_2 = 10'd259;
parameter bb25_i_i_3 = 10'd260;
parameter bb25_i_i_4 = 10'd261;
parameter bb25_i_i_5 = 10'd262;
parameter bb25_i_i_6 = 10'd263;
parameter bb25_i_i_7 = 10'd264;
parameter bb26_bb27_crit_edge_i_i = 10'd265;
parameter bb27_i_i = 10'd266;
parameter bb27_i_i_1 = 10'd267;
parameter bb27_i_i_2 = 10'd268;
parameter bb27_i_i_3 = 10'd269;
parameter bb28_i_i = 10'd270;
parameter bb28_i_i_1 = 10'd271;
parameter bb28_i_i_1_call_0 = 10'd272;
parameter bb28_i_i_1_call_1 = 10'd273;
parameter float64_div_exit_i = 10'd274;
parameter float64_div_exit_i_1 = 10'd275;
parameter float64_div_exit_i_2 = 10'd276;
parameter float64_div_exit_i_3 = 10'd277;
parameter float64_div_exit_i_4 = 10'd278;
parameter bb_i5_i = 10'd279;
parameter bb_i5_i_1 = 10'd280;
parameter bb_i4_i_i = 10'd281;
parameter bb_i4_i_i_1 = 10'd282;
parameter bb1_i5_i_i = 10'd283;
parameter bb1_i5_i_i_1 = 10'd284;
parameter bb2_i6_i_i = 10'd285;
parameter bb2_i6_i_i_1 = 10'd286;
parameter bb2_i6_i_i_2 = 10'd287;
parameter bb_i14_i55_i9_i_i = 10'd288;
parameter bb_i14_i55_i9_i_i_1 = 10'd289;
parameter bb_i14_i55_i9_i_i_2 = 10'd290;
parameter float64_is_signaling_nan_exit16_i56_i10_i_i = 10'd291;
parameter float64_is_signaling_nan_exit16_i56_i10_i_i_1 = 10'd292;
parameter float64_is_signaling_nan_exit16_i56_i10_i_i_2 = 10'd293;
parameter bb_i_i59_i13_i_i = 10'd294;
parameter bb_i_i59_i13_i_i_1 = 10'd295;
parameter bb_i_i59_i13_i_i_2 = 10'd296;
parameter float64_is_signaling_nan_exit_i60_i14_i_i = 10'd297;
parameter float64_is_signaling_nan_exit_i60_i14_i_i_1 = 10'd298;
parameter float64_is_signaling_nan_exit_i60_i14_i_i_2 = 10'd299;
parameter float64_is_signaling_nan_exit_i60_i14_i_i_3 = 10'd300;
parameter bb_i61_i15_i_i = 10'd301;
parameter bb_i61_i15_i_i_1 = 10'd302;
parameter bb_i61_i15_i_i_2 = 10'd303;
parameter bb_i61_i15_i_i_3 = 10'd304;
parameter bb1_i62_i16_i_i = 10'd305;
parameter bb1_i62_i16_i_i_1 = 10'd306;
parameter bb2_i63_i17_i_i = 10'd307;
parameter bb2_i63_i17_i_i_1 = 10'd308;
parameter bb3_i65_i19_i_i = 10'd309;
parameter bb4_i23_i_i = 10'd310;
parameter bb4_i23_i_i_1 = 10'd311;
parameter bb4_i23_i_i_2 = 10'd312;
parameter bb4_i23_i_i_3 = 10'd313;
parameter bb1_i46_i24_i_i = 10'd314;
parameter bb1_i46_i24_i_i_1 = 10'd315;
parameter bb2_i49_i_i_i = 10'd316;
parameter bb2_i49_i_i_i_1 = 10'd317;
parameter bb2_i49_i_i_i_2 = 10'd318;
parameter bb2_i49_i_i_i_3 = 10'd319;
parameter bb2_i49_i_i_i_4 = 10'd320;
parameter bb2_i49_i_i_i_5 = 10'd321;
parameter bb2_i49_i_i_i_6 = 10'd322;
parameter bb4_i50_i_i_i = 10'd323;
parameter bb4_i50_i_i_i_1 = 10'd324;
parameter bb8_i25_i_i = 10'd325;
parameter bb8_i25_i_i_1 = 10'd326;
parameter bb9_i26_i_i = 10'd327;
parameter bb9_i26_i_i_1 = 10'd328;
parameter bb10_i27_i_i = 10'd329;
parameter bb10_i27_i_i_1 = 10'd330;
parameter bb11_i28_i_i = 10'd331;
parameter bb11_i28_i_i_1 = 10'd332;
parameter bb11_i28_i_i_2 = 10'd333;
parameter bb_i14_i32_i_i_i = 10'd334;
parameter bb_i14_i32_i_i_i_1 = 10'd335;
parameter bb_i14_i32_i_i_i_2 = 10'd336;
parameter float64_is_signaling_nan_exit16_i33_i_i_i = 10'd337;
parameter float64_is_signaling_nan_exit16_i33_i_i_i_1 = 10'd338;
parameter float64_is_signaling_nan_exit16_i33_i_i_i_2 = 10'd339;
parameter bb_i_i36_i_i_i = 10'd340;
parameter bb_i_i36_i_i_i_1 = 10'd341;
parameter bb_i_i36_i_i_i_2 = 10'd342;
parameter float64_is_signaling_nan_exit_i37_i_i_i = 10'd343;
parameter float64_is_signaling_nan_exit_i37_i_i_i_1 = 10'd344;
parameter float64_is_signaling_nan_exit_i37_i_i_i_2 = 10'd345;
parameter float64_is_signaling_nan_exit_i37_i_i_i_3 = 10'd346;
parameter bb_i38_i_i_i = 10'd347;
parameter bb_i38_i_i_i_1 = 10'd348;
parameter bb_i38_i_i_i_2 = 10'd349;
parameter bb_i38_i_i_i_3 = 10'd350;
parameter bb1_i39_i_i_i = 10'd351;
parameter bb1_i39_i_i_i_1 = 10'd352;
parameter bb2_i40_i_i_i = 10'd353;
parameter bb2_i40_i_i_i_1 = 10'd354;
parameter bb3_i42_i_i_i = 10'd355;
parameter bb12_i29_i_i = 10'd356;
parameter bb12_i29_i_i_1 = 10'd357;
parameter bb13_i32_i_i = 10'd358;
parameter bb13_i32_i_i_1 = 10'd359;
parameter bb13_i32_i_i_2 = 10'd360;
parameter bb13_i32_i_i_3 = 10'd361;
parameter bb13_i32_i_i_4 = 10'd362;
parameter bb1_i28_i33_i_i = 10'd363;
parameter bb1_i28_i33_i_i_1 = 10'd364;
parameter bb2_i29_i36_i_i = 10'd365;
parameter bb2_i29_i36_i_i_1 = 10'd366;
parameter bb2_i29_i36_i_i_2 = 10'd367;
parameter bb2_i29_i36_i_i_3 = 10'd368;
parameter bb2_i29_i36_i_i_4 = 10'd369;
parameter bb2_i29_i36_i_i_5 = 10'd370;
parameter bb4_i_i37_i_i = 10'd371;
parameter bb4_i_i37_i_i_1 = 10'd372;
parameter bb17_i38_i_i = 10'd373;
parameter bb17_i38_i_i_1 = 10'd374;
parameter bb18_i39_i_i = 10'd375;
parameter bb18_i39_i_i_1 = 10'd376;
parameter bb18_i39_i_i_2 = 10'd377;
parameter bb19_i_i_i = 10'd378;
parameter bb19_i_i_i_1 = 10'd379;
parameter bb19_i_i_i_2 = 10'd380;
parameter bb_i14_i_i42_i_i = 10'd381;
parameter bb_i14_i_i42_i_i_1 = 10'd382;
parameter bb_i14_i_i42_i_i_2 = 10'd383;
parameter float64_is_signaling_nan_exit16_i_i43_i_i = 10'd384;
parameter float64_is_signaling_nan_exit16_i_i43_i_i_1 = 10'd385;
parameter float64_is_signaling_nan_exit16_i_i43_i_i_2 = 10'd386;
parameter bb_i_i_i46_i_i = 10'd387;
parameter bb_i_i_i46_i_i_1 = 10'd388;
parameter bb_i_i_i46_i_i_2 = 10'd389;
parameter float64_is_signaling_nan_exit_i_i47_i_i = 10'd390;
parameter float64_is_signaling_nan_exit_i_i47_i_i_1 = 10'd391;
parameter float64_is_signaling_nan_exit_i_i47_i_i_2 = 10'd392;
parameter float64_is_signaling_nan_exit_i_i47_i_i_3 = 10'd393;
parameter bb_i_i48_i_i = 10'd394;
parameter bb_i_i48_i_i_1 = 10'd395;
parameter bb_i_i48_i_i_2 = 10'd396;
parameter bb_i_i48_i_i_3 = 10'd397;
parameter bb1_i_i49_i_i = 10'd398;
parameter bb1_i_i49_i_i_1 = 10'd399;
parameter bb2_i_i50_i_i = 10'd400;
parameter bb2_i_i50_i_i_1 = 10'd401;
parameter bb3_i_i52_i_i = 10'd402;
parameter bb21_i_i_i = 10'd403;
parameter bb21_i_i_i_1 = 10'd404;
parameter bb22_i_i_i = 10'd405;
parameter bb22_i_i_i_1 = 10'd406;
parameter bb23_i_i_i = 10'd407;
parameter bb24_i57_i_i = 10'd408;
parameter bb24_i57_i_i_1 = 10'd409;
parameter bb24_i57_i_i_2 = 10'd410;
parameter bb24_i57_i_i_3 = 10'd411;
parameter bb24_i57_i_i_4 = 10'd412;
parameter bb24_i57_i_i_5 = 10'd413;
parameter bb25_i_i_i = 10'd414;
parameter roundAndPack_i_i_i = 10'd415;
parameter roundAndPack_i_i_i_1 = 10'd416;
parameter roundAndPack_i_i_i_1_call_0 = 10'd417;
parameter roundAndPack_i_i_i_1_call_1 = 10'd418;
parameter bb1_i6_i = 10'd419;
parameter bb1_i6_i_1 = 10'd420;
parameter bb_i_i7_i = 10'd421;
parameter bb_i_i7_i_1 = 10'd422;
parameter bb1_i_i8_i = 10'd423;
parameter bb2_i_i9_i = 10'd424;
parameter bb2_i_i9_i_1 = 10'd425;
parameter bb2_i_i9_i_2 = 10'd426;
parameter bb3_i_i10_i = 10'd427;
parameter bb3_i_i10_i_1 = 10'd428;
parameter bb3_i_i10_i_2 = 10'd429;
parameter bb_i14_i55_i_i_i = 10'd430;
parameter bb_i14_i55_i_i_i_1 = 10'd431;
parameter bb_i14_i55_i_i_i_2 = 10'd432;
parameter float64_is_signaling_nan_exit16_i56_i_i_i = 10'd433;
parameter float64_is_signaling_nan_exit16_i56_i_i_i_1 = 10'd434;
parameter float64_is_signaling_nan_exit16_i56_i_i_i_2 = 10'd435;
parameter bb_i_i59_i_i_i = 10'd436;
parameter bb_i_i59_i_i_i_1 = 10'd437;
parameter bb_i_i59_i_i_i_2 = 10'd438;
parameter float64_is_signaling_nan_exit_i60_i_i_i = 10'd439;
parameter float64_is_signaling_nan_exit_i60_i_i_i_1 = 10'd440;
parameter float64_is_signaling_nan_exit_i60_i_i_i_2 = 10'd441;
parameter float64_is_signaling_nan_exit_i60_i_i_i_3 = 10'd442;
parameter bb_i61_i_i_i = 10'd443;
parameter bb_i61_i_i_i_1 = 10'd444;
parameter bb_i61_i_i_i_2 = 10'd445;
parameter bb_i61_i_i_i_3 = 10'd446;
parameter bb1_i62_i_i_i = 10'd447;
parameter bb1_i62_i_i_i_1 = 10'd448;
parameter bb2_i63_i_i_i = 10'd449;
parameter bb2_i63_i_i_i_1 = 10'd450;
parameter bb3_i65_i_i_i = 10'd451;
parameter bb4_i_i11_i = 10'd452;
parameter bb4_i_i11_i_1 = 10'd453;
parameter bb4_i_i11_i_2 = 10'd454;
parameter bb4_i_i11_i_3 = 10'd455;
parameter bb6_i_i_i = 10'd456;
parameter bb7_i_i12_i = 10'd457;
parameter bb7_i_i12_i_1 = 10'd458;
parameter bb8_i_i13_i = 10'd459;
parameter bb8_i_i13_i_1 = 10'd460;
parameter bExpBigger_i_i_i = 10'd461;
parameter bExpBigger_i_i_i_1 = 10'd462;
parameter bb10_i_i14_i = 10'd463;
parameter bb10_i_i14_i_1 = 10'd464;
parameter bb11_i_i_i = 10'd465;
parameter bb11_i_i_i_1 = 10'd466;
parameter bb11_i_i_i_2 = 10'd467;
parameter bb_i14_i39_i_i_i = 10'd468;
parameter bb_i14_i39_i_i_i_1 = 10'd469;
parameter bb_i14_i39_i_i_i_2 = 10'd470;
parameter float64_is_signaling_nan_exit16_i40_i_i_i = 10'd471;
parameter float64_is_signaling_nan_exit16_i40_i_i_i_1 = 10'd472;
parameter float64_is_signaling_nan_exit16_i40_i_i_i_2 = 10'd473;
parameter bb_i_i43_i_i_i = 10'd474;
parameter bb_i_i43_i_i_i_1 = 10'd475;
parameter bb_i_i43_i_i_i_2 = 10'd476;
parameter float64_is_signaling_nan_exit_i44_i_i_i = 10'd477;
parameter float64_is_signaling_nan_exit_i44_i_i_i_1 = 10'd478;
parameter float64_is_signaling_nan_exit_i44_i_i_i_2 = 10'd479;
parameter float64_is_signaling_nan_exit_i44_i_i_i_3 = 10'd480;
parameter bb_i45_i_i_i = 10'd481;
parameter bb_i45_i_i_i_1 = 10'd482;
parameter bb_i45_i_i_i_2 = 10'd483;
parameter bb_i45_i_i_i_3 = 10'd484;
parameter bb1_i46_i_i_i = 10'd485;
parameter bb1_i46_i_i_i_1 = 10'd486;
parameter bb2_i47_i_i_i = 10'd487;
parameter bb2_i47_i_i_i_1 = 10'd488;
parameter bb3_i49_i_i_i = 10'd489;
parameter bb12_i_i_i = 10'd490;
parameter bb12_i_i_i_1 = 10'd491;
parameter bb12_i_i_i_2 = 10'd492;
parameter bb12_i_i_i_3 = 10'd493;
parameter bb13_i_i_i = 10'd494;
parameter bb13_i_i_i_1 = 10'd495;
parameter bb13_i_i_i_2 = 10'd496;
parameter bb13_i_i_i_3 = 10'd497;
parameter bb13_i_i_i_4 = 10'd498;
parameter bb1_i30_i_i_i = 10'd499;
parameter bb1_i30_i_i_i_1 = 10'd500;
parameter bb2_i33_i_i_i = 10'd501;
parameter bb2_i33_i_i_i_1 = 10'd502;
parameter bb2_i33_i_i_i_2 = 10'd503;
parameter bb2_i33_i_i_i_3 = 10'd504;
parameter bb2_i33_i_i_i_4 = 10'd505;
parameter bb2_i33_i_i_i_5 = 10'd506;
parameter bb4_i34_i_i_i = 10'd507;
parameter bb4_i34_i_i_i_1 = 10'd508;
parameter shift64RightJamming_exit36_i_i_i = 10'd509;
parameter bBigger_i_i_i = 10'd510;
parameter bBigger_i_i_i_1 = 10'd511;
parameter aExpBigger_i_i_i = 10'd512;
parameter aExpBigger_i_i_i_1 = 10'd513;
parameter bb17_i_i_i = 10'd514;
parameter bb17_i_i_i_1 = 10'd515;
parameter bb18_i_i_i = 10'd516;
parameter bb18_i_i_i_1 = 10'd517;
parameter bb18_i_i_i_2 = 10'd518;
parameter bb_i14_i_i_i_i = 10'd519;
parameter bb_i14_i_i_i_i_1 = 10'd520;
parameter bb_i14_i_i_i_i_2 = 10'd521;
parameter float64_is_signaling_nan_exit16_i_i_i_i = 10'd522;
parameter float64_is_signaling_nan_exit16_i_i_i_i_1 = 10'd523;
parameter float64_is_signaling_nan_exit16_i_i_i_i_2 = 10'd524;
parameter bb_i_i27_i_i_i = 10'd525;
parameter bb_i_i27_i_i_i_1 = 10'd526;
parameter bb_i_i27_i_i_i_2 = 10'd527;
parameter float64_is_signaling_nan_exit_i_i_i_i = 10'd528;
parameter float64_is_signaling_nan_exit_i_i_i_i_1 = 10'd529;
parameter float64_is_signaling_nan_exit_i_i_i_i_2 = 10'd530;
parameter float64_is_signaling_nan_exit_i_i_i_i_3 = 10'd531;
parameter bb_i_i_i15_i = 10'd532;
parameter bb_i_i_i15_i_1 = 10'd533;
parameter bb_i_i_i15_i_2 = 10'd534;
parameter bb_i_i_i15_i_3 = 10'd535;
parameter bb1_i28_i_i_i = 10'd536;
parameter bb1_i28_i_i_i_1 = 10'd537;
parameter bb2_i29_i_i_i = 10'd538;
parameter bb2_i29_i_i_i_1 = 10'd539;
parameter bb3_i_i_i_i = 10'd540;
parameter bb20_i_i_i = 10'd541;
parameter bb20_i_i_i_1 = 10'd542;
parameter bb20_i_i_i_2 = 10'd543;
parameter bb20_i_i_i_3 = 10'd544;
parameter bb1_i_i_i16_i = 10'd545;
parameter bb1_i_i_i16_i_1 = 10'd546;
parameter bb2_i_i_i_i = 10'd547;
parameter bb2_i_i_i_i_1 = 10'd548;
parameter bb2_i_i_i_i_2 = 10'd549;
parameter bb2_i_i_i_i_3 = 10'd550;
parameter bb2_i_i_i_i_4 = 10'd551;
parameter bb2_i_i_i_i_5 = 10'd552;
parameter bb2_i_i_i_i_6 = 10'd553;
parameter bb4_i_i_i_i = 10'd554;
parameter bb4_i_i_i_i_1 = 10'd555;
parameter shift64RightJamming_exit_i_i_i = 10'd556;
parameter aBigger_i_i_i = 10'd557;
parameter aBigger_i_i_i_1 = 10'd558;
parameter normalizeRoundAndPack_i_i_i = 10'd559;
parameter normalizeRoundAndPack_i_i_i_1 = 10'd560;
parameter normalizeRoundAndPack_i_i_i_2 = 10'd561;
parameter bb_i_i_i_i_i = 10'd562;
parameter bb1_i_i_i_i_i = 10'd563;
parameter bb1_i_i_i_i_i_1 = 10'd564;
parameter normalizeRoundAndPackFloat64_exit_i_i_i = 10'd565;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_1 = 10'd566;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_2 = 10'd567;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_3 = 10'd568;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_4 = 10'd569;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_5 = 10'd570;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_6 = 10'd571;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_7 = 10'd572;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_8 = 10'd573;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_9 = 10'd574;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_10 = 10'd575;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_11 = 10'd576;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_12 = 10'd577;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_13 = 10'd578;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_13_call_0 = 10'd579;
parameter normalizeRoundAndPackFloat64_exit_i_i_i_13_call_1 = 10'd580;
parameter float64_add_exit_i = 10'd581;
parameter float64_add_exit_i_1 = 10'd582;
parameter float64_add_exit_i_2 = 10'd583;
parameter bb2_i_i_i = 10'd584;
parameter bb2_i_i_i_1 = 10'd585;
parameter bb2_i_i_i_2 = 10'd586;
parameter bb3_i_i_i = 10'd587;
parameter bb3_i_i_i_1 = 10'd588;
parameter bb3_i_i_i_2 = 10'd589;
parameter bb3_i_i_i_3 = 10'd590;
parameter bb10_i_i_i = 10'd591;
parameter bb10_i_i_i_1 = 10'd592;
parameter sin_exit = 10'd593;
parameter sin_exit_1 = 10'd594;
parameter sin_exit_2 = 10'd595;
parameter sin_exit_3 = 10'd596;
parameter sin_exit_4 = 10'd597;
parameter bb2 = 10'd598;
reg [31:0] load_noop1;
reg [31:0] load_noop2;
reg [63:0] bSig_2_i_i_i;
reg [31:0] aExp_1_i_i_i;
reg [63:0] var446;
reg [31:0] zExp_0_i_i_i;
reg [63:0] zSig_0_i_i_i;
reg [31:0] zSign_addr_0_i_i_i;
reg  var447;
reg [31:0] extract_t_i_i_i_i_i;
reg [63:0] var448;
reg [31:0] extract_t4_i_i_i_i_i;
reg [31:0] shiftCount_0_i_i_i_i17_i;
reg [31:0] a_addr_0_off0_i_i_i_i_i;
reg [31:0] var450;
reg  var451;
reg [31:0] _a_i_i_i_i_i_i;
reg [31:0] shiftCount_0_i_i_i_i_i_i;
reg  var452;
reg [31:0] var453;
reg [31:0] var454;
reg [31:0] shiftCount_1_i_i_i_i_i_i;
reg [31:0] a_addr_1_i_i_i_i_i_i;
reg [31:0] var455;
reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] var456;
reg [31:0] var457;
reg [31:0] var458;
reg [31:0] var459;
reg [63:0] _cast_i_i_i_i;
reg [63:0] var461;
reg [31:0] var449;
reg [31:0] var460;
reg [63:0] var462;
reg [63:0] var237;
reg [31:0] var463;
reg [63:0] var464;
reg [63:0] var465;
reg  var466;
reg [63:0] var467;
reg  var468;
reg [31:0] var469;
reg [31:0] var470;
reg  or_cond_i;
reg [31:0] indvar_next_i;
reg [63:0] var473;
reg  var474;
reg [31:0] var475;
reg [31:0] var476;
reg [63:0] var471;
reg [31:0] var472;
reg  exitcond;
reg [31:0] i_04;
reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] scevgep;
reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] scevgep9;
reg [63:0] var0;
reg [63:0] var1;
reg [63:0] var2;
reg [31:0] indvar_i;
reg [31:0] inc_0_i;
reg [63:0] diff_0_i;
reg [63:0] app_0_i;
reg [31:0] tmp_i;
reg [31:0] tmp5_i;
reg [31:0] var3;
reg [31:0] var4;
reg [31:0] var5;
reg  var6;
reg [31:0] a_lobit_i_i;
reg  var9;
reg [31:0] var8;
reg [31:0] iftmp_44_0_i_i;
reg [31:0] var12;
reg  var13;
reg [31:0] _a_i_i_i;
reg [31:0] shiftCount_0_i_i_i;
reg  var15;
reg [31:0] var16;
reg [31:0] var17;
reg [31:0] shiftCount_1_i_i_i;
reg [31:0] a_addr_1_i_i_i;
reg [31:0] var18;
reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] var19;
reg [31:0] var20;
reg [31:0] var21;
reg [31:0] var22;
reg [63:0] var14;
reg [63:0] _cast_i_i;
reg [63:0] var25;
reg [31:0] var23;
reg [63:0] var10;
reg [63:0] var11;
reg [63:0] var24;
reg [63:0] var26;
reg [63:0] var27;
reg [63:0] var28;
reg [63:0] var7;
reg [63:0] var29;
reg [63:0] var30;
reg [63:0] var31;
reg [31:0] var35;
reg [31:0] var38;
reg [63:0] var32;
reg [63:0] var33;
reg [31:0] var36;
reg [31:0] var39;
reg [63:0] var34;
reg [63:0] var37;
reg [31:0] var40;
reg  var41;
reg  var42;
reg [63:0] var43;
reg  var44;
reg [63:0] var46;
reg  not__i12_i63_i_i;
reg [31:0] retval_i13_i64_i_i;
reg [31:0] var45;
reg [63:0] var47;
reg  var49;
reg [63:0] var48;
reg  var50;
reg [31:0] var124;
reg [31:0] var125;
reg [31:0] var126;
reg [31:0] var127;
reg [63:0] _cast_i41_i_i;
reg [63:0] var129;
reg [31:0] var128;
reg [63:0] bSig_0_i_i;
reg [31:0] bExp_0_i_i;
reg  var130;
reg  var131;
reg [63:0] var132;
reg  var133;
reg [31:0] extract_t_i_i_i_i;
reg [63:0] var134;
reg [31:0] extract_t4_i_i_i_i;
reg [31:0] shiftCount_0_i_i_i_i;
reg [31:0] a_addr_0_off0_i_i_i_i;
reg [31:0] var135;
reg [31:0] main_result_08;
reg [63:0] var52;
reg  not__i_i67_i_i;
reg [31:0] retval_i_i68_i_i;
reg [31:0] var51;
reg [63:0] var53;
reg [63:0] var54;
reg [31:0] var55;
reg  var56;
reg [31:0] var57;
reg [31:0] var58;
reg  var59;
reg  var61;
reg [63:0] iftmp_34_0_i74_i_i;
reg  var62;
reg  var63;
reg [63:0] var64;
reg  var65;
reg [63:0] var67;
reg  not__i12_i47_i_i;
reg [31:0] retval_i13_i48_i_i;
reg [31:0] var66;
reg [63:0] var68;
reg  var70;
reg [63:0] var69;
reg  var71;
reg [63:0] var73;
reg  not__i_i51_i_i;
reg [31:0] retval_i_i52_i_i;
reg [31:0] var72;
reg [63:0] var74;
reg [63:0] var75;
reg [31:0] var76;
reg  var77;
reg [31:0] var78;
reg [31:0] var79;
reg  var80;
reg  var81;
reg [63:0] iftmp_34_0_i58_i_i;
reg [31:0] var82;
reg [31:0] var83;
reg [63:0] var84;
reg [63:0] var85;
reg  var86;
reg [63:0] var87;
reg  var88;
reg [63:0] var90;
reg  not__i12_i_i_i;
reg [31:0] retval_i13_i_i_i;
reg [31:0] var89;
reg [63:0] var91;
reg  var93;
reg [63:0] var92;
reg  var94;
reg [63:0] var96;
reg  not__i_i_i_i;
reg [31:0] retval_i_i_i_i;
reg [31:0] var95;
reg [63:0] var97;
reg [63:0] var98;
reg [31:0] var99;
reg  var100;
reg [31:0] var101;
reg [31:0] var102;
reg  var103;
reg  var104;
reg [63:0] iftmp_34_0_i_i_i;
reg [63:0] var105;
reg  var106;
reg [63:0] var107;
reg [63:0] var109;
reg  var110;
reg [31:0] var108;
reg [31:0] var111;
reg [31:0] var112;
reg [63:0] var113;
reg [63:0] var114;
reg  var115;
reg [31:0] extract_t_i_i31_i_i;
reg [63:0] var116;
reg [31:0] extract_t4_i_i33_i_i;
reg [31:0] shiftCount_0_i_i35_i_i;
reg [31:0] a_addr_0_off0_i_i36_i_i;
reg [31:0] var117;
reg  var118;
reg [31:0] _a_i_i_i37_i_i;
reg [31:0] shiftCount_0_i_i_i38_i_i;
reg  var119;
reg [31:0] var120;
reg [31:0] var121;
reg [31:0] shiftCount_1_i_i_i39_i_i;
reg [31:0] a_addr_1_i_i_i40_i_i;
reg [31:0] var122;
reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] var123;
reg [63:0] var407;
reg [63:0] z_0_i35_i_i_i;
reg [63:0] var408;
reg [63:0] aSig_1_i_i_i;
reg [63:0] bSig_0_i_i_i;
reg [31:0] bExp_1_i_i_i;
reg [63:0] var410;
reg [31:0] var409;
reg  var411;
reg  var412;
reg [63:0] var413;
reg  var414;
reg [63:0] var416;
reg  not__i12_i_i_i_i;
reg [31:0] retval_i13_i_i_i_i;
reg [31:0] var415;
reg [63:0] var417;
reg  var419;
reg [63:0] var418;
reg  var420;
reg [63:0] var422;
reg  not__i_i_i_i_i;
reg [31:0] retval_i_i_i_i_i;
reg [31:0] var421;
reg [63:0] var423;
reg [63:0] var424;
reg [31:0] var425;
reg  var426;
reg [31:0] var427;
reg [31:0] var428;
reg  var429;
reg  var430;
reg [63:0] iftmp_34_0_i_i_i_i;
reg  var431;
reg [31:0] var432;
reg [63:0] var433;
reg [63:0] bSig_1_i_i_i;
reg  var136;
reg [31:0] _a_i_i_i_i_i;
reg [31:0] shiftCount_0_i_i_i_i_i;
reg  var137;
reg [31:0] var138;
reg [31:0] var139;
reg [31:0] shiftCount_1_i_i_i_i_i;
reg [31:0] a_addr_1_i_i_i_i_i;
reg [31:0] var140;
reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] var141;
reg [31:0] var142;
reg [31:0] var143;
reg [31:0] var144;
reg [31:0] var145;
reg [63:0] _cast_i_i_i;
reg [63:0] var147;
reg [31:0] var146;
reg [63:0] aSig_1_i_i;
reg [31:0] aExp_0_i_i;
reg [63:0] var149;
reg [63:0] var152;
reg [63:0] var148;
reg [63:0] var150;
reg [63:0] var153;
reg  var154;
reg [63:0] var155;
reg [63:0] var156;
reg [63:0] aSig_0_i_i;
reg [31:0] zExp_0_v_i_i;
reg [31:0] var151;
reg [31:0] zExp_0_i_i;
reg  var157;
reg [63:0] var159;
reg [63:0] var160;
reg  var161;
reg [63:0] var162;
reg [63:0] var163;
reg [63:0] iftmp_18_0_i_i_i;
reg [63:0] var165;
reg [63:0] var164;
reg [63:0] var166;
reg [63:0] var167;
reg [63:0] var168;
reg [63:0] var169;
reg [63:0] var170;
reg  var171;
reg [63:0] _neg_i_i_i_i;
reg [63:0] _neg2_i_i_i;
reg [63:0] var172;
reg [63:0] var173;
reg  var174;
reg [31:0] bSig_0130_i_i;
reg [31:0] tmp121_i_i;
reg [63:0] tmp122_i_i;
reg [63:0] tmp123_i_i;
reg [63:0] tmp124_i_i;
reg [63:0] tmp125_i_i;
reg [63:0] tmp126_i_i;
reg [63:0] var175;
reg [63:0] rem0_05_i_i_i;
reg [63:0] tmp117_i_i;
reg [63:0] tmp118_i_i;
reg [63:0] tmp23_i_i_i;
reg [63:0] rem1_04_i_i_i;
reg  var177;
reg [63:0] var178;
reg [63:0] var176;
reg [63:0] var179;
reg  var180;
reg [63:0] indvar_next_i_i_i;
reg [63:0] tmp_i_i_i;
reg [63:0] tmp11_i_i_i;
reg [63:0] tmp12_i_i_i;
reg [63:0] z_0_lcssa_i_i_i;
reg [63:0] rem0_0_lcssa_i_i_i;
reg [63:0] rem1_0_lcssa_i_i_i;
reg [63:0] var181;
reg [63:0] var182;
reg [63:0] var183;
reg  var184;
reg [63:0] var185;
reg [63:0] iftmp_27_0_i_i_i;
reg [63:0] var186;
reg [63:0] var158;
reg [63:0] var187;
reg  var188;
reg [63:0] var189;
reg [63:0] var190;
reg [63:0] var191;
reg [63:0] var192;
reg [63:0] var193;
reg [63:0] var194;
reg [63:0] var195;
reg [63:0] var196;
reg [63:0] var197;
reg  var198;
reg [63:0] iftmp_17_0_i_i_i;
reg [63:0] var199;
reg [63:0] var202;
reg [63:0] var200;
reg [63:0] var201;
reg  var203;
reg [63:0] var204;
reg  var205;
reg [63:0] _neg_i_i_i;
reg [63:0] _neg83_i_i;
reg [63:0] _neg82_i_i;
reg [63:0] _neg84_i_i;
reg [63:0] var206;
reg [63:0] var207;
reg  var208;
reg [63:0] tmp91_i_i;
reg [31:0] bSig_0129_i_i;
reg [31:0] tmp97_i_i;
reg [63:0] tmp98_i_i;
reg [63:0] tmp99_i_i;
reg [63:0] tmp101_i_i;
reg [63:0] tmp103_i_i;
reg [63:0] tmp105_i_i;
reg [63:0] tmp106_i_i;
reg [63:0] tmp107_i_i;
reg [63:0] tmp108_i_i;
reg [63:0] tmp111_i_i;
reg [63:0] tmp112_i_i;
reg [63:0] tmp114_i_i;
reg [63:0] indvar_i_i;
reg [63:0] rem1_087_i_i;
reg [63:0] rem0_085_i_i;
reg [63:0] tmp93_i_i;
reg [63:0] tmp115_i_i;
reg [63:0] var209;
reg  var210;
reg [63:0] var211;
reg [63:0] var212;
reg  var213;
reg [63:0] indvar_next_i_i;
reg [63:0] tmp92_i_i;
reg [63:0] tmp109_i_i;
reg [63:0] zSig_0_lcssa_i_i;
reg [63:0] rem1_0_lcssa_i_i;
reg  var214;
reg [63:0] var215;
reg [63:0] var216;
reg [63:0] zSig_1_i_i;
reg [63:0] var217;
reg [63:0] var60;
reg [63:0] var218;
reg [31:0] var220;
reg [63:0] var221;
reg [31:0] var224;
reg  var227;
reg [63:0] var219;
reg [31:0] var222;
reg [31:0] var225;
reg [63:0] var223;
reg [31:0] var226;
reg [31:0] var228;
reg [31:0] var229;
reg [63:0] var230;
reg [63:0] var233;
reg [63:0] var231;
reg [63:0] var234;
reg  var232;
reg  var235;
reg  var236;
reg [63:0] var238;
reg  var239;
reg [63:0] var241;
reg  not__i12_i53_i7_i_i;
reg [31:0] retval_i13_i54_i8_i_i;
reg [31:0] var240;
reg [63:0] var242;
reg  var244;
reg [63:0] var243;
reg  var245;
reg [63:0] var247;
reg  not__i_i57_i11_i_i;
reg [31:0] retval_i_i58_i12_i_i;
reg [31:0] var246;
reg [63:0] var248;
reg [63:0] var249;
reg [31:0] var250;
reg  var251;
reg [31:0] var252;
reg [31:0] var253;
reg  var254;
reg  var255;
reg [63:0] iftmp_34_0_i64_i18_i_i;
reg  var256;
reg [31:0] var257;
reg [63:0] var258;
reg [63:0] bSig_0_i21_i_i;
reg [31:0] expDiff_0_i22_i_i;
reg  var259;
reg  var260;
reg [63:0] _cast_i47_i_i_i;
reg [63:0] var262;
reg [31:0] var261;
reg [31:0] var263;
reg [63:0] _cast3_i48_i_i_i;
reg [63:0] var264;
reg  var265;
reg [63:0] var266;
reg [63:0] var267;
reg  var268;
reg [63:0] var269;
reg  var270;
reg  var271;
reg  var272;
reg [63:0] var273;
reg  var274;
reg [63:0] var276;
reg  not__i12_i30_i_i_i;
reg [31:0] retval_i13_i31_i_i_i;
reg [31:0] var275;
reg [63:0] var277;
reg  var279;
reg [63:0] var278;
reg  var280;
reg [63:0] var282;
reg  not__i_i34_i_i_i;
reg [31:0] retval_i_i35_i_i_i;
reg [31:0] var281;
reg [63:0] var283;
reg [63:0] var284;
reg [31:0] var285;
reg  var286;
reg [31:0] var287;
reg [31:0] var288;
reg  var289;
reg  var290;
reg [63:0] iftmp_34_0_i41_i_i_i;
reg [63:0] var291;
reg [63:0] var292;
reg  var293;
reg [63:0] var294;
reg [63:0] aSig_0_i30_i_i;
reg [31:0] var295;
reg [31:0] expDiff_1_i31_i_i;
reg [31:0] var296;
reg  var297;
reg  var298;
reg [63:0] _cast_i_i34_i_i;
reg [63:0] var300;
reg [31:0] var299;
reg [63:0] _cast3_i_i35_i_i;
reg [63:0] var301;
reg  var302;
reg [63:0] var303;
reg [63:0] var304;
reg  var305;
reg [63:0] var306;
reg  var307;
reg [63:0] var308;
reg  var309;
reg [63:0] var310;
reg  var311;
reg [63:0] var313;
reg  not__i12_i_i40_i_i;
reg [31:0] retval_i13_i_i41_i_i;
reg [31:0] var312;
reg [63:0] var314;
reg  var316;
reg [63:0] var315;
reg  var317;
reg [63:0] var319;
reg  not__i_i_i44_i_i;
reg [31:0] retval_i_i_i45_i_i;
reg [31:0] var318;
reg [63:0] var320;
reg [63:0] var321;
reg [31:0] var322;
reg  var323;
reg [31:0] var324;
reg [31:0] var325;
reg  var326;
reg  var327;
reg [63:0] iftmp_34_0_i_i51_i_i;
reg  var328;
reg [63:0] var329;
reg [63:0] var330;
reg [63:0] var331;
reg [63:0] var332;
reg [63:0] var333;
reg [63:0] aSig_1_i54_i_i;
reg [63:0] bSig_1_i55_i_i;
reg [31:0] zExp_0_i56_i_i;
reg [63:0] var334;
reg [63:0] var336;
reg [63:0] var337;
reg [31:0] var335;
reg  var338;
reg [63:0] __i_i_i;
reg [63:0] zSig_0_i58_i_i;
reg [31:0] zExp_1_i_i_i;
reg [63:0] var339;
reg [63:0] var340;
reg [63:0] var343;
reg [63:0] var341;
reg [63:0] var344;
reg  var342;
reg  var345;
reg [63:0] var346;
reg  var347;
reg [63:0] var348;
reg  var349;
reg [63:0] var351;
reg  not__i12_i53_i_i_i;
reg [31:0] retval_i13_i54_i_i_i;
reg [31:0] var350;
reg [63:0] var352;
reg  var354;
reg [63:0] var353;
reg  var355;
reg [63:0] var357;
reg  not__i_i57_i_i_i;
reg [31:0] retval_i_i58_i_i_i;
reg [31:0] var356;
reg [63:0] var358;
reg [63:0] var359;
reg [31:0] var360;
reg  var361;
reg [31:0] var362;
reg [31:0] var363;
reg  var364;
reg  var365;
reg [63:0] iftmp_34_0_i64_i_i_i;
reg [31:0] var366;
reg [31:0] var367;
reg [31:0] bExp_0_i_i_i;
reg [31:0] aExp_0_i_i_i;
reg  var368;
reg  var369;
reg  var370;
reg  var371;
reg [63:0] var372;
reg  var373;
reg [63:0] var375;
reg  not__i12_i37_i_i_i;
reg [31:0] retval_i13_i38_i_i_i;
reg [31:0] var374;
reg [63:0] var376;
reg  var378;
reg [63:0] var377;
reg  var379;
reg [63:0] var381;
reg  not__i_i41_i_i_i;
reg [31:0] retval_i_i42_i_i_i;
reg [31:0] var380;
reg [63:0] var382;
reg [63:0] var383;
reg [31:0] var384;
reg  var385;
reg [31:0] var386;
reg [31:0] var387;
reg  var388;
reg  var389;
reg [63:0] iftmp_34_0_i48_i_i_i;
reg [31:0] var390;
reg [63:0] var391;
reg [63:0] var392;
reg [63:0] var393;
reg  var394;
reg [63:0] var395;
reg [63:0] aSig_0_i_i_i;
reg [31:0] var396;
reg [31:0] expDiff_0_i_i_i;
reg [31:0] var397;
reg  var398;
reg  var399;
reg [63:0] _cast_i31_i_i_i;
reg [63:0] var401;
reg [31:0] var400;
reg [63:0] _cast3_i32_i_i_i;
reg [63:0] var402;
reg  var403;
reg [63:0] var404;
reg [63:0] var405;
reg  var406;
reg [31:0] expDiff_1_i_i_i;
reg  var434;
reg  var435;
reg [63:0] _cast_i26_i_i_i;
reg [63:0] var437;
reg [31:0] var436;
reg [31:0] var438;
reg [63:0] _cast3_i_i_i_i;
reg [63:0] var439;
reg  var440;
reg [63:0] var441;
reg [63:0] var442;
reg  var443;
reg [63:0] var444;
reg [63:0] z_0_i_i_i_i;
reg [63:0] var445;
reg [63:0] aSig_2_i_i_i;
reg [31:0] load_noop3;
reg [31:0] load_noop4;
reg [63:0] load_noop;
reg [31:0] load_noop17;
reg [63:0] load_noop18;
reg [31:0] load_noop5;
reg [31:0] load_noop6;
reg [31:0] load_noop7;
reg [31:0] load_noop8;
reg [31:0] load_noop9;
reg [31:0] load_noop10;
reg [31:0] load_noop11;
reg [31:0] load_noop12;
reg [31:0] load_noop13;
reg [31:0] load_noop14;
reg [31:0] load_noop15;
reg [31:0] load_noop16;

always @(posedge clk)
if (reset)
	cur_state = Wait;
else
case(cur_state)
	Wait:
	begin
		finish = 0;
		if (start == 1)
			cur_state = bb_nph;
		else
			cur_state = Wait;
	end
	bb_nph:
	begin
		/*   br label %bb*/
		main_result_08 = 32'd0;   /* for PHI node */
		i_04 = 32'd0;   /* for PHI node */
		cur_state = bb;
	end
	bb:
	begin
		/*   %main_result.08 = phi i32 [ 0, %bb.nph ], [ %477, %sin.exit_4 ] ; <i32> [#uses=1]*/

		/*   %i.04 = phi i32 [ 0, %bb.nph ], [ %473, %sin.exit_4 ] ; <i32> [#uses=3]*/

		/*   br label %bb_1*/
		cur_state = bb_1;
	end
	bb_1:
	begin
		/*   %scevgep = getelementptr [36 x i64]* @test_in, i32 0, i32 %i.04 ; <i64*> [#uses=1]*/
		scevgep = {`TAG_test_in, 32'b0} + ((i_04 + 36*(32'd0)) << 3);
		/*   %scevgep9 = getelementptr [36 x i64]* @test_out, i32 0, i32 %i.04 ; <i64*> [#uses=1]*/
		scevgep9 = {`TAG_test_out, 32'b0} + ((i_04 + 36*(32'd0)) << 3);
		/*   br label %bb_2*/
		cur_state = bb_2;
	end
	bb_2:
	begin
		/*   %0 = load i64* %scevgep, align 8                ; <i64> [#uses=1]*/
		/*   br label %bb_3*/
		cur_state = bb_3;
	end
	bb_3:
	begin
		var0 = memory_controller_out[63:0];
		/*   %load_noop = add i64 %0, 0                      ; <i64> [#uses=5]*/
		load_noop = var0 + 64'd0;
		/*   br label %bb_4*/
		cur_state = bb_4;
	end
	bb_4:
	begin
		/*   %1 = tail call fastcc i64 @float64_mul(i64 %load_noop, i64 %load_noop) nounwind ; <i64> [#uses=1]*/
		float64_mul_start = 1;
		/* Argument:   %load_noop = add i64 %0, 0                      ; <i64> [#uses=5]*/
		float64_mul_a = load_noop;
		/* Argument:   %load_noop = add i64 %0, 0                      ; <i64> [#uses=5]*/
		float64_mul_b = load_noop;
		cur_state = bb_4_call_0;
	end
	bb_4_call_0:
	begin
		float64_mul_start = 0;
		if (float64_mul_finish == 1)
			begin
			var1 = float64_mul_return_val;
			cur_state = bb_4_call_1;
			end
		else
			cur_state = bb_4_call_0;
	end
	bb_4_call_1:
	begin
		/*   br label %bb_5*/
		cur_state = bb_5;
	end
	bb_5:
	begin
		/*   %2 = xor i64 %1, -9223372036854775808           ; <i64> [#uses=1]*/
		var2 = var1 ^ -64'd9223372036854775808;
		/*   br label %bb.i*/
		indvar_i = 32'd0;   /* for PHI node */
		inc_0_i = 32'd1;   /* for PHI node */
		diff_0_i = load_noop;   /* for PHI node */
		app_0_i = load_noop;   /* for PHI node */
		cur_state = bb_i;
	end
	bb_i:
	begin
		/*   %indvar.i = phi i32 [ %indvar.next.i, %bb10.i.i.i_1 ], [ 0, %bb_5 ] ; <i32> [#uses=2]*/

		/*   %inc.0.i = phi i32 [ %463, %bb10.i.i.i_1 ], [ 1, %bb_5 ] ; <i32> [#uses=2]*/

		/*   %diff.0.i = phi i64 [ %217, %bb10.i.i.i_1 ], [ %load_noop, %bb_5 ] ; <i64> [#uses=1]*/

		/*   %app.0.i = phi i64 [ %462, %bb10.i.i.i_1 ], [ %load_noop, %bb_5 ] ; <i64> [#uses=27]*/

		/*   br label %bb.i_1*/
		cur_state = bb_i_1;
	end
	bb_i_1:
	begin
		/*   %tmp.i = shl i32 %indvar.i, 1                   ; <i32> [#uses=1]*/
		tmp_i = indvar_i <<< (32'd1 % 32);
		/*   %3 = shl i32 %inc.0.i, 1                        ; <i32> [#uses=1]*/
		var3 = inc_0_i <<< (32'd1 % 32);
		/*   br label %bb.i_2*/
		cur_state = bb_i_2;
	end
	bb_i_2:
	begin
		/*   %tmp5.i = add i32 %tmp.i, 2                     ; <i32> [#uses=1]*/
		tmp5_i = tmp_i + 32'd2;
		/*   %4 = or i32 %3, 1                               ; <i32> [#uses=1]*/
		var4 = var3 | 32'd1;
		/*   br label %bb.i_3*/
		cur_state = bb_i_3;
	end
	bb_i_3:
	begin
		/*   %5 = mul i32 %4, %tmp5.i                        ; <i32> [#uses=4]*/
		var5 = var4 * tmp5_i;
		/*   br label %bb.i_4*/
		cur_state = bb_i_4;
	end
	bb_i_4:
	begin
		/*   %6 = icmp eq i32 %5, 0                          ; <i1> [#uses=1]*/
		var6 = var5 == 32'd0;
		/*   br label %bb.i_5*/
		cur_state = bb_i_5;
	end
	bb_i_5:
	begin
		/*   br i1 %6, label %int32_to_float64.exit.i, label %bb1.i.i*/
		if (var6) begin
			var7 = 64'd0;   /* for PHI node */
			cur_state = int32_to_float64_exit_i;
		end
		else begin
			cur_state = bb1_i_i;
		end
	end
	bb1_i_i:
	begin
		/*   %a.lobit.i.i = lshr i32 %5, 31                  ; <i32> [#uses=2]*/
		a_lobit_i_i = var5 >>> (32'd31 % 32);
		/*   %7 = sub i32 0, %5                              ; <i32> [#uses=1]*/
		var8 = 32'd0 - var5;
		/*   br label %bb1.i.i_1*/
		cur_state = bb1_i_i_1;
	end
	bb1_i_i_1:
	begin
		/*   %8 = icmp eq i32 %a.lobit.i.i, 0                ; <i1> [#uses=1]*/
		var9 = a_lobit_i_i == 32'd0;
		/*   %9 = zext i32 %a.lobit.i.i to i64               ; <i64> [#uses=1]*/
		var10 = a_lobit_i_i;
		/*   br label %bb1.i.i_2*/
		cur_state = bb1_i_i_2;
	end
	bb1_i_i_2:
	begin
		/*   %iftmp.44.0.i.i = select i1 %8, i32 %5, i32 %7  ; <i32> [#uses=4]*/
		iftmp_44_0_i_i = (var9) ? var5 : var8;
		/*   %10 = shl i64 %9, 63                            ; <i64> [#uses=1]*/
		var11 = var10 <<< (64'd63 % 64);
		/*   br label %bb1.i.i_3*/
		cur_state = bb1_i_i_3;
	end
	bb1_i_i_3:
	begin
		/*   %11 = shl i32 %iftmp.44.0.i.i, 16               ; <i32> [#uses=1]*/
		var12 = iftmp_44_0_i_i <<< (32'd16 % 32);
		/*   %12 = icmp ult i32 %iftmp.44.0.i.i, 65536       ; <i1> [#uses=2]*/
		var13 = iftmp_44_0_i_i < 32'd65536;
		/*   %13 = zext i32 %iftmp.44.0.i.i to i64           ; <i64> [#uses=1]*/
		var14 = iftmp_44_0_i_i;
		/*   br label %bb1.i.i_4*/
		cur_state = bb1_i_i_4;
	end
	bb1_i_i_4:
	begin
		/*   %.a.i.i.i = select i1 %12, i32 %11, i32 %iftmp.44.0.i.i ; <i32> [#uses=3]*/
		_a_i_i_i = (var13) ? var12 : iftmp_44_0_i_i;
		/*   %shiftCount.0.i.i.i = select i1 %12, i32 16, i32 0 ; <i32> [#uses=2]*/
		shiftCount_0_i_i_i = (var13) ? 32'd16 : 32'd0;
		/*   br label %bb1.i.i_5*/
		cur_state = bb1_i_i_5;
	end
	bb1_i_i_5:
	begin
		/*   %14 = icmp ult i32 %.a.i.i.i, 16777216          ; <i1> [#uses=2]*/
		var15 = _a_i_i_i < 32'd16777216;
		/*   %15 = or i32 %shiftCount.0.i.i.i, 8             ; <i32> [#uses=1]*/
		var16 = shiftCount_0_i_i_i | 32'd8;
		/*   %16 = shl i32 %.a.i.i.i, 8                      ; <i32> [#uses=1]*/
		var17 = _a_i_i_i <<< (32'd8 % 32);
		/*   br label %bb1.i.i_6*/
		cur_state = bb1_i_i_6;
	end
	bb1_i_i_6:
	begin
		/*   %shiftCount.1.i.i.i = select i1 %14, i32 %15, i32 %shiftCount.0.i.i.i ; <i32> [#uses=1]*/
		shiftCount_1_i_i_i = (var15) ? var16 : shiftCount_0_i_i_i;
		/*   %a_addr.1.i.i.i = select i1 %14, i32 %16, i32 %.a.i.i.i ; <i32> [#uses=1]*/
		a_addr_1_i_i_i = (var15) ? var17 : _a_i_i_i;
		/*   br label %bb1.i.i_7*/
		cur_state = bb1_i_i_7;
	end
	bb1_i_i_7:
	begin
		/*   %17 = lshr i32 %a_addr.1.i.i.i, 24              ; <i32> [#uses=1]*/
		var18 = a_addr_1_i_i_i >>> (32'd24 % 32);
		/*   br label %bb1.i.i_8*/
		cur_state = bb1_i_i_8;
	end
	bb1_i_i_8:
	begin
		/*   %18 = getelementptr inbounds [256 x i32]* @countLeadingZerosHigh.1302, i32 0, i32 %17 ; <i32*> [#uses=1]*/
		var19 = {`TAG_countLeadingZerosHigh_1302, 32'b0} + ((var18 + 256*(32'd0)) << 2);
		/*   br label %bb1.i.i_9*/
		cur_state = bb1_i_i_9;
	end
	bb1_i_i_9:
	begin
		/*   %19 = load i32* %18, align 4                    ; <i32> [#uses=1]*/
		/*   br label %bb1.i.i_10*/
		cur_state = bb1_i_i_10;
	end
	bb1_i_i_10:
	begin
		var20 = memory_controller_out[31:0];
		/*   %load_noop1 = add i32 %19, 0                    ; <i32> [#uses=1]*/
		load_noop1 = var20 + 32'd0;
		/*   br label %bb1.i.i_11*/
		cur_state = bb1_i_i_11;
	end
	bb1_i_i_11:
	begin
		/*   %20 = add nsw i32 %load_noop1, %shiftCount.1.i.i.i ; <i32> [#uses=2]*/
		var21 = load_noop1 + shiftCount_1_i_i_i;
		/*   br label %bb1.i.i_12*/
		cur_state = bb1_i_i_12;
	end
	bb1_i_i_12:
	begin
		/*   %21 = add nsw i32 %20, 21                       ; <i32> [#uses=1]*/
		var22 = var21 + 32'd21;
		/*   %22 = sub i32 1053, %20                         ; <i32> [#uses=1]*/
		var23 = 32'd1053 - var21;
		/*   br label %bb1.i.i_13*/
		cur_state = bb1_i_i_13;
	end
	bb1_i_i_13:
	begin
		/*   %.cast.i.i = zext i32 %21 to i64                ; <i64> [#uses=1]*/
		_cast_i_i = var22;
		/*   %23 = zext i32 %22 to i64                       ; <i64> [#uses=1]*/
		var24 = var23;
		/*   br label %bb1.i.i_14*/
		cur_state = bb1_i_i_14;
	end
	bb1_i_i_14:
	begin
		/*   %24 = shl i64 %13, %.cast.i.i                   ; <i64> [#uses=1]*/
		var25 = var14 <<< (_cast_i_i % 64);
		/*   %25 = shl i64 %23, 52                           ; <i64> [#uses=1]*/
		var26 = var24 <<< (64'd52 % 64);
		/*   br label %bb1.i.i_15*/
		cur_state = bb1_i_i_15;
	end
	bb1_i_i_15:
	begin
		/*   %26 = add i64 %24, %10                          ; <i64> [#uses=1]*/
		var27 = var25 + var11;
		/*   br label %bb1.i.i_16*/
		cur_state = bb1_i_i_16;
	end
	bb1_i_i_16:
	begin
		/*   %27 = add i64 %26, %25                          ; <i64> [#uses=1]*/
		var28 = var27 + var26;
		/*   br label %int32_to_float64.exit.i*/
		var7 = var28;   /* for PHI node */
		cur_state = int32_to_float64_exit_i;
	end
	int32_to_float64_exit_i:
	begin
		/*   %28 = phi i64 [ %27, %bb1.i.i_16 ], [ 0, %bb.i_5 ] ; <i64> [#uses=16]*/

		/*   %29 = tail call fastcc i64 @float64_mul(i64 %diff.0.i, i64 %2) nounwind ; <i64> [#uses=13]*/
		float64_mul_start = 1;
		/* Argument:   %diff.0.i = phi i64 [ %217, %bb10.i.i.i_1 ], [ %load_noop, %bb_5 ] ; <i64> [#uses=1]*/
		float64_mul_a = diff_0_i;
		/* Argument:   %2 = xor i64 %1, -9223372036854775808           ; <i64> [#uses=1]*/
		float64_mul_b = var2;
		cur_state = int32_to_float64_exit_i_call_0;
	end
	int32_to_float64_exit_i_call_0:
	begin
		float64_mul_start = 0;
		if (float64_mul_finish == 1)
			begin
			var29 = float64_mul_return_val;
			cur_state = int32_to_float64_exit_i_call_1;
			end
		else
			cur_state = int32_to_float64_exit_i_call_0;
	end
	int32_to_float64_exit_i_call_1:
	begin
		/*   br label %int32_to_float64.exit.i_1*/
		cur_state = int32_to_float64_exit_i_1;
	end
	int32_to_float64_exit_i_1:
	begin
		/*   %30 = and i64 %29, 4503599627370495             ; <i64> [#uses=7]*/
		var30 = var29 & 64'd4503599627370495;
		/*   %31 = lshr i64 %29, 52                          ; <i64> [#uses=1]*/
		var31 = var29 >>> (64'd52 % 64);
		/*   %32 = and i64 %28, 4503599627370495             ; <i64> [#uses=7]*/
		var32 = var7 & 64'd4503599627370495;
		/*   %33 = lshr i64 %28, 52                          ; <i64> [#uses=1]*/
		var33 = var7 >>> (64'd52 % 64);
		/*   %34 = xor i64 %28, %29                          ; <i64> [#uses=5]*/
		var34 = var7 ^ var29;
		/*   br label %int32_to_float64.exit.i_2*/
		cur_state = int32_to_float64_exit_i_2;
	end
	int32_to_float64_exit_i_2:
	begin
		/*   %35 = trunc i64 %31 to i32                      ; <i32> [#uses=1]*/
		var35 = var31[31:0];
		/*   %36 = trunc i64 %33 to i32                      ; <i32> [#uses=1]*/
		var36 = var33[31:0];
		/*   %37 = lshr i64 %34, 63                          ; <i64> [#uses=1]*/
		var37 = var34 >>> (64'd63 % 64);
		/*   br label %int32_to_float64.exit.i_3*/
		cur_state = int32_to_float64_exit_i_3;
	end
	int32_to_float64_exit_i_3:
	begin
		/*   %38 = and i32 %35, 2047                         ; <i32> [#uses=4]*/
		var38 = var35 & 32'd2047;
		/*   %39 = and i32 %36, 2047                         ; <i32> [#uses=3]*/
		var39 = var36 & 32'd2047;
		/*   %40 = trunc i64 %37 to i32                      ; <i32> [#uses=1]*/
		var40 = var37[31:0];
		/*   br label %int32_to_float64.exit.i_4*/
		cur_state = int32_to_float64_exit_i_4;
	end
	int32_to_float64_exit_i_4:
	begin
		/*   %41 = icmp eq i32 %38, 2047                     ; <i1> [#uses=1]*/
		var41 = var38 == 32'd2047;
		/*   br label %int32_to_float64.exit.i_5*/
		cur_state = int32_to_float64_exit_i_5;
	end
	int32_to_float64_exit_i_5:
	begin
		/*   br i1 %41, label %bb.i.i, label %bb7.i.i*/
		if (var41) begin
			cur_state = bb_i_i;
		end
		else begin
			cur_state = bb7_i_i;
		end
	end
	bb_i_i:
	begin
		/*   %42 = icmp eq i64 %30, 0                        ; <i1> [#uses=1]*/
		var42 = var30 == 64'd0;
		/*   br label %bb.i.i_1*/
		cur_state = bb_i_i_1;
	end
	bb_i_i_1:
	begin
		/*   br i1 %42, label %bb2.i.i, label %bb1.i1.i*/
		if (var42) begin
			cur_state = bb2_i_i;
		end
		else begin
			cur_state = bb1_i1_i;
		end
	end
	bb1_i1_i:
	begin
		/*   %43 = and i64 %29, 9221120237041090560          ; <i64> [#uses=1]*/
		var43 = var29 & 64'd9221120237041090560;
		/*   br label %bb1.i1.i_1*/
		cur_state = bb1_i1_i_1;
	end
	bb1_i1_i_1:
	begin
		/*   %44 = icmp eq i64 %43, 9218868437227405312      ; <i1> [#uses=1]*/
		var44 = var43 == 64'd9218868437227405312;
		/*   br label %bb1.i1.i_2*/
		cur_state = bb1_i1_i_2;
	end
	bb1_i1_i_2:
	begin
		/*   br i1 %44, label %bb.i14.i65.i.i, label %float64_is_signaling_nan.exit16.i66.i.i*/
		if (var44) begin
			cur_state = bb_i14_i65_i_i;
		end
		else begin
			var45 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit16_i66_i_i;
		end
	end
	bb_i14_i65_i_i:
	begin
		/*   %45 = and i64 %29, 2251799813685247             ; <i64> [#uses=1]*/
		var46 = var29 & 64'd2251799813685247;
		/*   br label %bb.i14.i65.i.i_1*/
		cur_state = bb_i14_i65_i_i_1;
	end
	bb_i14_i65_i_i_1:
	begin
		/*   %not..i12.i63.i.i = icmp ne i64 %45, 0          ; <i1> [#uses=1]*/
		not__i12_i63_i_i = var46 != 64'd0;
		/*   br label %bb.i14.i65.i.i_2*/
		cur_state = bb_i14_i65_i_i_2;
	end
	bb_i14_i65_i_i_2:
	begin
		/*   %retval.i13.i64.i.i = zext i1 %not..i12.i63.i.i to i32 ; <i32> [#uses=1]*/
		retval_i13_i64_i_i = not__i12_i63_i_i;
		/*   br label %float64_is_signaling_nan.exit16.i66.i.i*/
		var45 = retval_i13_i64_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit16_i66_i_i;
	end
	float64_is_signaling_nan_exit16_i66_i_i:
	begin
		/*   %46 = phi i32 [ %retval.i13.i64.i.i, %bb.i14.i65.i.i_2 ], [ 0, %bb1.i1.i_2 ] ; <i32> [#uses=2]*/

		/*   %47 = shl i64 %28, 1                            ; <i64> [#uses=1]*/
		var47 = var7 <<< (64'd1 % 64);
		/*   %48 = and i64 %28, 9221120237041090560          ; <i64> [#uses=1]*/
		var48 = var7 & 64'd9221120237041090560;
		/*   br label %float64_is_signaling_nan.exit16.i66.i.i_1*/
		cur_state = float64_is_signaling_nan_exit16_i66_i_i_1;
	end
	float64_is_signaling_nan_exit16_i66_i_i_1:
	begin
		/*   %49 = icmp ugt i64 %47, -9007199254740992       ; <i1> [#uses=1]*/
		var49 = var47 > -64'd9007199254740992;
		/*   %50 = icmp eq i64 %48, 9218868437227405312      ; <i1> [#uses=1]*/
		var50 = var48 == 64'd9218868437227405312;
		/*   br label %float64_is_signaling_nan.exit16.i66.i.i_2*/
		cur_state = float64_is_signaling_nan_exit16_i66_i_i_2;
	end
	float64_is_signaling_nan_exit16_i66_i_i_2:
	begin
		/*   br i1 %50, label %bb.i.i69.i.i, label %float64_is_signaling_nan.exit.i70.i.i*/
		if (var50) begin
			cur_state = bb_i_i69_i_i;
		end
		else begin
			var51 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit_i70_i_i;
		end
	end
	bb_i_i69_i_i:
	begin
		/*   %51 = and i64 %28, 2251799813685247             ; <i64> [#uses=1]*/
		var52 = var7 & 64'd2251799813685247;
		/*   br label %bb.i.i69.i.i_1*/
		cur_state = bb_i_i69_i_i_1;
	end
	bb_i_i69_i_i_1:
	begin
		/*   %not..i.i67.i.i = icmp ne i64 %51, 0            ; <i1> [#uses=1]*/
		not__i_i67_i_i = var52 != 64'd0;
		/*   br label %bb.i.i69.i.i_2*/
		cur_state = bb_i_i69_i_i_2;
	end
	bb_i_i69_i_i_2:
	begin
		/*   %retval.i.i68.i.i = zext i1 %not..i.i67.i.i to i32 ; <i32> [#uses=1]*/
		retval_i_i68_i_i = not__i_i67_i_i;
		/*   br label %float64_is_signaling_nan.exit.i70.i.i*/
		var51 = retval_i_i68_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit_i70_i_i;
	end
	float64_is_signaling_nan_exit_i70_i_i:
	begin
		/*   %52 = phi i32 [ %retval.i.i68.i.i, %bb.i.i69.i.i_2 ], [ 0, %float64_is_signaling_nan.exit16.i66.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %53 = or i64 %29, 2251799813685248              ; <i64> [#uses=2]*/
		var53 = var29 | 64'd2251799813685248;
		/*   %54 = or i64 %28, 2251799813685248              ; <i64> [#uses=2]*/
		var54 = var7 | 64'd2251799813685248;
		/*   br label %float64_is_signaling_nan.exit.i70.i.i_1*/
		cur_state = float64_is_signaling_nan_exit_i70_i_i_1;
	end
	float64_is_signaling_nan_exit_i70_i_i_1:
	begin
		/*   %55 = or i32 %52, %46                           ; <i32> [#uses=1]*/
		var55 = var51 | var45;
		/*   br label %float64_is_signaling_nan.exit.i70.i.i_2*/
		cur_state = float64_is_signaling_nan_exit_i70_i_i_2;
	end
	float64_is_signaling_nan_exit_i70_i_i_2:
	begin
		/*   %56 = icmp eq i32 %55, 0                        ; <i1> [#uses=1]*/
		var56 = var55 == 32'd0;
		/*   br label %float64_is_signaling_nan.exit.i70.i.i_3*/
		cur_state = float64_is_signaling_nan_exit_i70_i_i_3;
	end
	float64_is_signaling_nan_exit_i70_i_i_3:
	begin
		/*   br i1 %56, label %bb1.i72.i.i, label %bb.i71.i.i*/
		if (var56) begin
			cur_state = bb1_i72_i_i;
		end
		else begin
			cur_state = bb_i71_i_i;
		end
	end
	bb_i71_i_i:
	begin
		/*   %57 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb.i71.i.i_1*/
		cur_state = bb_i71_i_i_1;
	end
	bb_i71_i_i_1:
	begin
		var57 = memory_controller_out[31:0];
		/*   %load_noop2 = add i32 %57, 0                    ; <i32> [#uses=1]*/
		load_noop2 = var57 + 32'd0;
		/*   br label %bb.i71.i.i_2*/
		cur_state = bb_i71_i_i_2;
	end
	bb_i71_i_i_2:
	begin
		/*   %58 = or i32 %load_noop2, 16                    ; <i32> [#uses=1]*/
		var58 = load_noop2 | 32'd16;
		/*   br label %bb.i71.i.i_3*/
		cur_state = bb_i71_i_i_3;
	end
	bb_i71_i_i_3:
	begin
		/*   store i32 %58, i32* @float_exception_flags, align 4*/
		/*   br label %bb1.i72.i.i*/
		cur_state = bb1_i72_i_i;
	end
	bb1_i72_i_i:
	begin
		/*   %59 = icmp eq i32 %52, 0                        ; <i1> [#uses=1]*/
		var59 = var51 == 32'd0;
		/*   br label %bb1.i72.i.i_1*/
		cur_state = bb1_i72_i_i_1;
	end
	bb1_i72_i_i_1:
	begin
		/*   br i1 %59, label %bb2.i73.i.i, label %float64_div.exit.i*/
		if (var59) begin
			cur_state = bb2_i73_i_i;
		end
		else begin
			var60 = var54;   /* for PHI node */
			cur_state = float64_div_exit_i;
		end
	end
	bb2_i73_i_i:
	begin
		/*   %60 = icmp eq i32 %46, 0                        ; <i1> [#uses=1]*/
		var61 = var45 == 32'd0;
		/*   br label %bb2.i73.i.i_1*/
		cur_state = bb2_i73_i_i_1;
	end
	bb2_i73_i_i_1:
	begin
		/*   br i1 %60, label %bb3.i75.i.i, label %float64_div.exit.i*/
		if (var61) begin
			cur_state = bb3_i75_i_i;
		end
		else begin
			var60 = var53;   /* for PHI node */
			cur_state = float64_div_exit_i;
		end
	end
	bb3_i75_i_i:
	begin
		/*   %iftmp.34.0.i74.i.i = select i1 %49, i64 %54, i64 %53 ; <i64> [#uses=1]*/
		iftmp_34_0_i74_i_i = (var49) ? var54 : var53;
		/*   br label %float64_div.exit.i*/
		var60 = iftmp_34_0_i74_i_i;   /* for PHI node */
		cur_state = float64_div_exit_i;
	end
	bb2_i_i:
	begin
		/*   %61 = icmp eq i32 %39, 2047                     ; <i1> [#uses=1]*/
		var62 = var39 == 32'd2047;
		/*   br label %bb2.i.i_1*/
		cur_state = bb2_i_i_1;
	end
	bb2_i_i_1:
	begin
		/*   br i1 %61, label %bb3.i.i, label %bb6.i.i*/
		if (var62) begin
			cur_state = bb3_i_i;
		end
		else begin
			cur_state = bb6_i_i;
		end
	end
	bb3_i_i:
	begin
		/*   %62 = icmp eq i64 %32, 0                        ; <i1> [#uses=1]*/
		var63 = var32 == 64'd0;
		/*   br label %bb3.i.i_1*/
		cur_state = bb3_i_i_1;
	end
	bb3_i_i_1:
	begin
		/*   br i1 %62, label %bb5.i.i, label %bb4.i.i*/
		if (var63) begin
			cur_state = bb5_i_i;
		end
		else begin
			cur_state = bb4_i_i;
		end
	end
	bb4_i_i:
	begin
		/*   %63 = and i64 %29, 9221120237041090560          ; <i64> [#uses=1]*/
		var64 = var29 & 64'd9221120237041090560;
		/*   br label %bb4.i.i_1*/
		cur_state = bb4_i_i_1;
	end
	bb4_i_i_1:
	begin
		/*   %64 = icmp eq i64 %63, 9218868437227405312      ; <i1> [#uses=1]*/
		var65 = var64 == 64'd9218868437227405312;
		/*   br label %bb4.i.i_2*/
		cur_state = bb4_i_i_2;
	end
	bb4_i_i_2:
	begin
		/*   br i1 %64, label %bb.i14.i49.i.i, label %float64_is_signaling_nan.exit16.i50.i.i*/
		if (var65) begin
			cur_state = bb_i14_i49_i_i;
		end
		else begin
			var66 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit16_i50_i_i;
		end
	end
	bb_i14_i49_i_i:
	begin
		/*   %65 = and i64 %29, 2251799813685247             ; <i64> [#uses=1]*/
		var67 = var29 & 64'd2251799813685247;
		/*   br label %bb.i14.i49.i.i_1*/
		cur_state = bb_i14_i49_i_i_1;
	end
	bb_i14_i49_i_i_1:
	begin
		/*   %not..i12.i47.i.i = icmp ne i64 %65, 0          ; <i1> [#uses=1]*/
		not__i12_i47_i_i = var67 != 64'd0;
		/*   br label %bb.i14.i49.i.i_2*/
		cur_state = bb_i14_i49_i_i_2;
	end
	bb_i14_i49_i_i_2:
	begin
		/*   %retval.i13.i48.i.i = zext i1 %not..i12.i47.i.i to i32 ; <i32> [#uses=1]*/
		retval_i13_i48_i_i = not__i12_i47_i_i;
		/*   br label %float64_is_signaling_nan.exit16.i50.i.i*/
		var66 = retval_i13_i48_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit16_i50_i_i;
	end
	float64_is_signaling_nan_exit16_i50_i_i:
	begin
		/*   %66 = phi i32 [ %retval.i13.i48.i.i, %bb.i14.i49.i.i_2 ], [ 0, %bb4.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %67 = shl i64 %28, 1                            ; <i64> [#uses=1]*/
		var68 = var7 <<< (64'd1 % 64);
		/*   %68 = and i64 %28, 9221120237041090560          ; <i64> [#uses=1]*/
		var69 = var7 & 64'd9221120237041090560;
		/*   br label %float64_is_signaling_nan.exit16.i50.i.i_1*/
		cur_state = float64_is_signaling_nan_exit16_i50_i_i_1;
	end
	float64_is_signaling_nan_exit16_i50_i_i_1:
	begin
		/*   %69 = icmp ugt i64 %67, -9007199254740992       ; <i1> [#uses=1]*/
		var70 = var68 > -64'd9007199254740992;
		/*   %70 = icmp eq i64 %68, 9218868437227405312      ; <i1> [#uses=1]*/
		var71 = var69 == 64'd9218868437227405312;
		/*   br label %float64_is_signaling_nan.exit16.i50.i.i_2*/
		cur_state = float64_is_signaling_nan_exit16_i50_i_i_2;
	end
	float64_is_signaling_nan_exit16_i50_i_i_2:
	begin
		/*   br i1 %70, label %bb.i.i53.i.i, label %float64_is_signaling_nan.exit.i54.i.i*/
		if (var71) begin
			cur_state = bb_i_i53_i_i;
		end
		else begin
			var72 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit_i54_i_i;
		end
	end
	bb_i_i53_i_i:
	begin
		/*   %71 = and i64 %28, 2251799813685247             ; <i64> [#uses=1]*/
		var73 = var7 & 64'd2251799813685247;
		/*   br label %bb.i.i53.i.i_1*/
		cur_state = bb_i_i53_i_i_1;
	end
	bb_i_i53_i_i_1:
	begin
		/*   %not..i.i51.i.i = icmp ne i64 %71, 0            ; <i1> [#uses=1]*/
		not__i_i51_i_i = var73 != 64'd0;
		/*   br label %bb.i.i53.i.i_2*/
		cur_state = bb_i_i53_i_i_2;
	end
	bb_i_i53_i_i_2:
	begin
		/*   %retval.i.i52.i.i = zext i1 %not..i.i51.i.i to i32 ; <i32> [#uses=1]*/
		retval_i_i52_i_i = not__i_i51_i_i;
		/*   br label %float64_is_signaling_nan.exit.i54.i.i*/
		var72 = retval_i_i52_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit_i54_i_i;
	end
	float64_is_signaling_nan_exit_i54_i_i:
	begin
		/*   %72 = phi i32 [ %retval.i.i52.i.i, %bb.i.i53.i.i_2 ], [ 0, %float64_is_signaling_nan.exit16.i50.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %73 = or i64 %29, 2251799813685248              ; <i64> [#uses=2]*/
		var74 = var29 | 64'd2251799813685248;
		/*   %74 = or i64 %28, 2251799813685248              ; <i64> [#uses=2]*/
		var75 = var7 | 64'd2251799813685248;
		/*   br label %float64_is_signaling_nan.exit.i54.i.i_1*/
		cur_state = float64_is_signaling_nan_exit_i54_i_i_1;
	end
	float64_is_signaling_nan_exit_i54_i_i_1:
	begin
		/*   %75 = or i32 %72, %66                           ; <i32> [#uses=1]*/
		var76 = var72 | var66;
		/*   br label %float64_is_signaling_nan.exit.i54.i.i_2*/
		cur_state = float64_is_signaling_nan_exit_i54_i_i_2;
	end
	float64_is_signaling_nan_exit_i54_i_i_2:
	begin
		/*   %76 = icmp eq i32 %75, 0                        ; <i1> [#uses=1]*/
		var77 = var76 == 32'd0;
		/*   br label %float64_is_signaling_nan.exit.i54.i.i_3*/
		cur_state = float64_is_signaling_nan_exit_i54_i_i_3;
	end
	float64_is_signaling_nan_exit_i54_i_i_3:
	begin
		/*   br i1 %76, label %bb1.i56.i.i, label %bb.i55.i.i*/
		if (var77) begin
			cur_state = bb1_i56_i_i;
		end
		else begin
			cur_state = bb_i55_i_i;
		end
	end
	bb_i55_i_i:
	begin
		/*   %77 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb.i55.i.i_1*/
		cur_state = bb_i55_i_i_1;
	end
	bb_i55_i_i_1:
	begin
		var78 = memory_controller_out[31:0];
		/*   %load_noop3 = add i32 %77, 0                    ; <i32> [#uses=1]*/
		load_noop3 = var78 + 32'd0;
		/*   br label %bb.i55.i.i_2*/
		cur_state = bb_i55_i_i_2;
	end
	bb_i55_i_i_2:
	begin
		/*   %78 = or i32 %load_noop3, 16                    ; <i32> [#uses=1]*/
		var79 = load_noop3 | 32'd16;
		/*   br label %bb.i55.i.i_3*/
		cur_state = bb_i55_i_i_3;
	end
	bb_i55_i_i_3:
	begin
		/*   store i32 %78, i32* @float_exception_flags, align 4*/
		/*   br label %bb1.i56.i.i*/
		cur_state = bb1_i56_i_i;
	end
	bb1_i56_i_i:
	begin
		/*   %79 = icmp eq i32 %72, 0                        ; <i1> [#uses=1]*/
		var80 = var72 == 32'd0;
		/*   br label %bb1.i56.i.i_1*/
		cur_state = bb1_i56_i_i_1;
	end
	bb1_i56_i_i_1:
	begin
		/*   br i1 %79, label %bb2.i57.i.i, label %float64_div.exit.i*/
		if (var80) begin
			cur_state = bb2_i57_i_i;
		end
		else begin
			var60 = var75;   /* for PHI node */
			cur_state = float64_div_exit_i;
		end
	end
	bb2_i57_i_i:
	begin
		/*   %80 = icmp eq i32 %66, 0                        ; <i1> [#uses=1]*/
		var81 = var66 == 32'd0;
		/*   br label %bb2.i57.i.i_1*/
		cur_state = bb2_i57_i_i_1;
	end
	bb2_i57_i_i_1:
	begin
		/*   br i1 %80, label %bb3.i59.i.i, label %float64_div.exit.i*/
		if (var81) begin
			cur_state = bb3_i59_i_i;
		end
		else begin
			var60 = var74;   /* for PHI node */
			cur_state = float64_div_exit_i;
		end
	end
	bb3_i59_i_i:
	begin
		/*   %iftmp.34.0.i58.i.i = select i1 %69, i64 %74, i64 %73 ; <i64> [#uses=1]*/
		iftmp_34_0_i58_i_i = (var70) ? var75 : var74;
		/*   br label %float64_div.exit.i*/
		var60 = iftmp_34_0_i58_i_i;   /* for PHI node */
		cur_state = float64_div_exit_i;
	end
	bb5_i_i:
	begin
		/*   %81 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb5.i.i_1*/
		cur_state = bb5_i_i_1;
	end
	bb5_i_i_1:
	begin
		var82 = memory_controller_out[31:0];
		/*   %load_noop4 = add i32 %81, 0                    ; <i32> [#uses=1]*/
		load_noop4 = var82 + 32'd0;
		/*   br label %bb5.i.i_2*/
		cur_state = bb5_i_i_2;
	end
	bb5_i_i_2:
	begin
		/*   %82 = or i32 %load_noop4, 16                    ; <i32> [#uses=1]*/
		var83 = load_noop4 | 32'd16;
		/*   br label %bb5.i.i_3*/
		cur_state = bb5_i_i_3;
	end
	bb5_i_i_3:
	begin
		/*   store i32 %82, i32* @float_exception_flags, align 4*/
		/*   br label %float64_div.exit.i*/
		var60 = 64'd9223372036854775807;   /* for PHI node */
		cur_state = float64_div_exit_i;
	end
	bb6_i_i:
	begin
		/*   %83 = or i64 %34, 9218868437227405312           ; <i64> [#uses=1]*/
		var84 = var34 | 64'd9218868437227405312;
		/*   br label %bb6.i.i_1*/
		cur_state = bb6_i_i_1;
	end
	bb6_i_i_1:
	begin
		/*   %84 = and i64 %83, -4503599627370496            ; <i64> [#uses=1]*/
		var85 = var84 & -64'd4503599627370496;
		/*   br label %float64_div.exit.i*/
		var60 = var85;   /* for PHI node */
		cur_state = float64_div_exit_i;
	end
	bb7_i_i:
	begin
		/*   switch i32 %39, label %bb17.i.i [
    i32 2047, label %bb8.i.i
    i32 0, label %bb12.i.i
  ]*/
		case(var39)
		32'd2047:
		begin
			cur_state = bb8_i_i;
		end
		32'd0:
		begin
			cur_state = bb12_i_i;
		end
		default:
		begin
			bSig_0_i_i = var32;   /* for PHI node */
			bExp_0_i_i = var39;   /* for PHI node */
			cur_state = bb17_i_i;
		end
endcase
	end
	bb8_i_i:
	begin
		/*   %85 = icmp eq i64 %32, 0                        ; <i1> [#uses=1]*/
		var86 = var32 == 64'd0;
		/*   br label %bb8.i.i_1*/
		cur_state = bb8_i_i_1;
	end
	bb8_i_i_1:
	begin
		/*   br i1 %85, label %bb10.i.i, label %bb9.i.i*/
		if (var86) begin
			cur_state = bb10_i_i;
		end
		else begin
			cur_state = bb9_i_i;
		end
	end
	bb9_i_i:
	begin
		/*   %86 = and i64 %29, 9221120237041090560          ; <i64> [#uses=1]*/
		var87 = var29 & 64'd9221120237041090560;
		/*   br label %bb9.i.i_1*/
		cur_state = bb9_i_i_1;
	end
	bb9_i_i_1:
	begin
		/*   %87 = icmp eq i64 %86, 9218868437227405312      ; <i1> [#uses=1]*/
		var88 = var87 == 64'd9218868437227405312;
		/*   br label %bb9.i.i_2*/
		cur_state = bb9_i_i_2;
	end
	bb9_i_i_2:
	begin
		/*   br i1 %87, label %bb.i14.i.i.i, label %float64_is_signaling_nan.exit16.i.i.i*/
		if (var88) begin
			cur_state = bb_i14_i_i_i;
		end
		else begin
			var89 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit16_i_i_i;
		end
	end
	bb_i14_i_i_i:
	begin
		/*   %88 = and i64 %29, 2251799813685247             ; <i64> [#uses=1]*/
		var90 = var29 & 64'd2251799813685247;
		/*   br label %bb.i14.i.i.i_1*/
		cur_state = bb_i14_i_i_i_1;
	end
	bb_i14_i_i_i_1:
	begin
		/*   %not..i12.i.i.i = icmp ne i64 %88, 0            ; <i1> [#uses=1]*/
		not__i12_i_i_i = var90 != 64'd0;
		/*   br label %bb.i14.i.i.i_2*/
		cur_state = bb_i14_i_i_i_2;
	end
	bb_i14_i_i_i_2:
	begin
		/*   %retval.i13.i.i.i = zext i1 %not..i12.i.i.i to i32 ; <i32> [#uses=1]*/
		retval_i13_i_i_i = not__i12_i_i_i;
		/*   br label %float64_is_signaling_nan.exit16.i.i.i*/
		var89 = retval_i13_i_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit16_i_i_i;
	end
	float64_is_signaling_nan_exit16_i_i_i:
	begin
		/*   %89 = phi i32 [ %retval.i13.i.i.i, %bb.i14.i.i.i_2 ], [ 0, %bb9.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %90 = shl i64 %28, 1                            ; <i64> [#uses=1]*/
		var91 = var7 <<< (64'd1 % 64);
		/*   %91 = and i64 %28, 9221120237041090560          ; <i64> [#uses=1]*/
		var92 = var7 & 64'd9221120237041090560;
		/*   br label %float64_is_signaling_nan.exit16.i.i.i_1*/
		cur_state = float64_is_signaling_nan_exit16_i_i_i_1;
	end
	float64_is_signaling_nan_exit16_i_i_i_1:
	begin
		/*   %92 = icmp ugt i64 %90, -9007199254740992       ; <i1> [#uses=1]*/
		var93 = var91 > -64'd9007199254740992;
		/*   %93 = icmp eq i64 %91, 9218868437227405312      ; <i1> [#uses=1]*/
		var94 = var92 == 64'd9218868437227405312;
		/*   br label %float64_is_signaling_nan.exit16.i.i.i_2*/
		cur_state = float64_is_signaling_nan_exit16_i_i_i_2;
	end
	float64_is_signaling_nan_exit16_i_i_i_2:
	begin
		/*   br i1 %93, label %bb.i.i43.i.i, label %float64_is_signaling_nan.exit.i.i.i*/
		if (var94) begin
			cur_state = bb_i_i43_i_i;
		end
		else begin
			var95 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit_i_i_i;
		end
	end
	bb_i_i43_i_i:
	begin
		/*   %94 = and i64 %28, 2251799813685247             ; <i64> [#uses=1]*/
		var96 = var7 & 64'd2251799813685247;
		/*   br label %bb.i.i43.i.i_1*/
		cur_state = bb_i_i43_i_i_1;
	end
	bb_i_i43_i_i_1:
	begin
		/*   %not..i.i.i.i = icmp ne i64 %94, 0              ; <i1> [#uses=1]*/
		not__i_i_i_i = var96 != 64'd0;
		/*   br label %bb.i.i43.i.i_2*/
		cur_state = bb_i_i43_i_i_2;
	end
	bb_i_i43_i_i_2:
	begin
		/*   %retval.i.i.i.i = zext i1 %not..i.i.i.i to i32  ; <i32> [#uses=1]*/
		retval_i_i_i_i = not__i_i_i_i;
		/*   br label %float64_is_signaling_nan.exit.i.i.i*/
		var95 = retval_i_i_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit_i_i_i;
	end
	float64_is_signaling_nan_exit_i_i_i:
	begin
		/*   %95 = phi i32 [ %retval.i.i.i.i, %bb.i.i43.i.i_2 ], [ 0, %float64_is_signaling_nan.exit16.i.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %96 = or i64 %29, 2251799813685248              ; <i64> [#uses=2]*/
		var97 = var29 | 64'd2251799813685248;
		/*   %97 = or i64 %28, 2251799813685248              ; <i64> [#uses=2]*/
		var98 = var7 | 64'd2251799813685248;
		/*   br label %float64_is_signaling_nan.exit.i.i.i_1*/
		cur_state = float64_is_signaling_nan_exit_i_i_i_1;
	end
	float64_is_signaling_nan_exit_i_i_i_1:
	begin
		/*   %98 = or i32 %95, %89                           ; <i32> [#uses=1]*/
		var99 = var95 | var89;
		/*   br label %float64_is_signaling_nan.exit.i.i.i_2*/
		cur_state = float64_is_signaling_nan_exit_i_i_i_2;
	end
	float64_is_signaling_nan_exit_i_i_i_2:
	begin
		/*   %99 = icmp eq i32 %98, 0                        ; <i1> [#uses=1]*/
		var100 = var99 == 32'd0;
		/*   br label %float64_is_signaling_nan.exit.i.i.i_3*/
		cur_state = float64_is_signaling_nan_exit_i_i_i_3;
	end
	float64_is_signaling_nan_exit_i_i_i_3:
	begin
		/*   br i1 %99, label %bb1.i44.i.i, label %bb.i.i.i*/
		if (var100) begin
			cur_state = bb1_i44_i_i;
		end
		else begin
			cur_state = bb_i_i_i;
		end
	end
	bb_i_i_i:
	begin
		/*   %100 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb.i.i.i_1*/
		cur_state = bb_i_i_i_1;
	end
	bb_i_i_i_1:
	begin
		var101 = memory_controller_out[31:0];
		/*   %load_noop5 = add i32 %100, 0                   ; <i32> [#uses=1]*/
		load_noop5 = var101 + 32'd0;
		/*   br label %bb.i.i.i_2*/
		cur_state = bb_i_i_i_2;
	end
	bb_i_i_i_2:
	begin
		/*   %101 = or i32 %load_noop5, 16                   ; <i32> [#uses=1]*/
		var102 = load_noop5 | 32'd16;
		/*   br label %bb.i.i.i_3*/
		cur_state = bb_i_i_i_3;
	end
	bb_i_i_i_3:
	begin
		/*   store i32 %101, i32* @float_exception_flags, align 4*/
		/*   br label %bb1.i44.i.i*/
		cur_state = bb1_i44_i_i;
	end
	bb1_i44_i_i:
	begin
		/*   %102 = icmp eq i32 %95, 0                       ; <i1> [#uses=1]*/
		var103 = var95 == 32'd0;
		/*   br label %bb1.i44.i.i_1*/
		cur_state = bb1_i44_i_i_1;
	end
	bb1_i44_i_i_1:
	begin
		/*   br i1 %102, label %bb2.i45.i.i, label %float64_div.exit.i*/
		if (var103) begin
			cur_state = bb2_i45_i_i;
		end
		else begin
			var60 = var98;   /* for PHI node */
			cur_state = float64_div_exit_i;
		end
	end
	bb2_i45_i_i:
	begin
		/*   %103 = icmp eq i32 %89, 0                       ; <i1> [#uses=1]*/
		var104 = var89 == 32'd0;
		/*   br label %bb2.i45.i.i_1*/
		cur_state = bb2_i45_i_i_1;
	end
	bb2_i45_i_i_1:
	begin
		/*   br i1 %103, label %bb3.i.i2.i, label %float64_div.exit.i*/
		if (var104) begin
			cur_state = bb3_i_i2_i;
		end
		else begin
			var60 = var97;   /* for PHI node */
			cur_state = float64_div_exit_i;
		end
	end
	bb3_i_i2_i:
	begin
		/*   %iftmp.34.0.i.i.i = select i1 %92, i64 %97, i64 %96 ; <i64> [#uses=1]*/
		iftmp_34_0_i_i_i = (var93) ? var98 : var97;
		/*   br label %float64_div.exit.i*/
		var60 = iftmp_34_0_i_i_i;   /* for PHI node */
		cur_state = float64_div_exit_i;
	end
	bb10_i_i:
	begin
		/*   %104 = and i64 %34, -9223372036854775808        ; <i64> [#uses=1]*/
		var105 = var34 & -64'd9223372036854775808;
		/*   br label %float64_div.exit.i*/
		var60 = var105;   /* for PHI node */
		cur_state = float64_div_exit_i;
	end
	bb12_i_i:
	begin
		/*   %105 = icmp eq i64 %32, 0                       ; <i1> [#uses=1]*/
		var106 = var32 == 64'd0;
		/*   br label %bb12.i.i_1*/
		cur_state = bb12_i_i_1;
	end
	bb12_i_i_1:
	begin
		/*   br i1 %105, label %bb13.i.i, label %bb16.i.i*/
		if (var106) begin
			cur_state = bb13_i_i;
		end
		else begin
			cur_state = bb16_i_i;
		end
	end
	bb13_i_i:
	begin
		/*   %106 = zext i32 %38 to i64                      ; <i64> [#uses=1]*/
		var107 = var38;
		/*   %107 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb13.i.i_1*/
		cur_state = bb13_i_i_1;
	end
	bb13_i_i_1:
	begin
		var108 = memory_controller_out[31:0];
		/*   %108 = or i64 %106, %30                         ; <i64> [#uses=1]*/
		var109 = var107 | var30;
		/*   %load_noop6 = add i32 %107, 0                   ; <i32> [#uses=2]*/
		load_noop6 = var108 + 32'd0;
		/*   br label %bb13.i.i_2*/
		cur_state = bb13_i_i_2;
	end
	bb13_i_i_2:
	begin
		/*   %109 = icmp eq i64 %108, 0                      ; <i1> [#uses=1]*/
		var110 = var109 == 64'd0;
		/*   br label %bb13.i.i_3*/
		cur_state = bb13_i_i_3;
	end
	bb13_i_i_3:
	begin
		/*   br i1 %109, label %bb14.i.i, label %bb15.i.i*/
		if (var110) begin
			cur_state = bb14_i_i;
		end
		else begin
			cur_state = bb15_i_i;
		end
	end
	bb14_i_i:
	begin
		/*   %110 = or i32 %load_noop6, 16                   ; <i32> [#uses=1]*/
		var111 = load_noop6 | 32'd16;
		/*   br label %bb14.i.i_1*/
		cur_state = bb14_i_i_1;
	end
	bb14_i_i_1:
	begin
		/*   store i32 %110, i32* @float_exception_flags, align 4*/
		/*   br label %float64_div.exit.i*/
		var60 = 64'd9223372036854775807;   /* for PHI node */
		cur_state = float64_div_exit_i;
	end
	bb15_i_i:
	begin
		/*   %111 = or i32 %load_noop6, 2                    ; <i32> [#uses=1]*/
		var112 = load_noop6 | 32'd2;
		/*   %112 = or i64 %34, 9218868437227405312          ; <i64> [#uses=1]*/
		var113 = var34 | 64'd9218868437227405312;
		/*   br label %bb15.i.i_1*/
		cur_state = bb15_i_i_1;
	end
	bb15_i_i_1:
	begin
		/*   store i32 %111, i32* @float_exception_flags, align 4*/
		/*   %113 = and i64 %112, -4503599627370496          ; <i64> [#uses=1]*/
		var114 = var113 & -64'd4503599627370496;
		/*   br label %float64_div.exit.i*/
		var60 = var114;   /* for PHI node */
		cur_state = float64_div_exit_i;
	end
	bb16_i_i:
	begin
		/*   %114 = icmp ult i64 %32, 4294967296             ; <i1> [#uses=1]*/
		var115 = var32 < 64'd4294967296;
		/*   br label %bb16.i.i_1*/
		cur_state = bb16_i_i_1;
	end
	bb16_i_i_1:
	begin
		/*   br i1 %114, label %bb.i.i32.i.i, label %bb1.i.i34.i.i*/
		if (var115) begin
			cur_state = bb_i_i32_i_i;
		end
		else begin
			cur_state = bb1_i_i34_i_i;
		end
	end
	bb_i_i32_i_i:
	begin
		/*   %extract.t.i.i31.i.i = trunc i64 %28 to i32     ; <i32> [#uses=1]*/
		extract_t_i_i31_i_i = var7[31:0];
		/*   br label %normalizeFloat64Subnormal.exit42.i.i*/
		shiftCount_0_i_i35_i_i = 32'd32;   /* for PHI node */
		a_addr_0_off0_i_i36_i_i = extract_t_i_i31_i_i;   /* for PHI node */
		cur_state = normalizeFloat64Subnormal_exit42_i_i;
	end
	bb1_i_i34_i_i:
	begin
		/*   %115 = lshr i64 %32, 32                         ; <i64> [#uses=1]*/
		var116 = var32 >>> (64'd32 % 64);
		/*   br label %bb1.i.i34.i.i_1*/
		cur_state = bb1_i_i34_i_i_1;
	end
	bb1_i_i34_i_i_1:
	begin
		/*   %extract.t4.i.i33.i.i = trunc i64 %115 to i32   ; <i32> [#uses=1]*/
		extract_t4_i_i33_i_i = var116[31:0];
		/*   br label %normalizeFloat64Subnormal.exit42.i.i*/
		shiftCount_0_i_i35_i_i = 32'd0;   /* for PHI node */
		a_addr_0_off0_i_i36_i_i = extract_t4_i_i33_i_i;   /* for PHI node */
		cur_state = normalizeFloat64Subnormal_exit42_i_i;
	end
	normalizeFloat64Subnormal_exit42_i_i:
	begin
		/*   %shiftCount.0.i.i35.i.i = phi i32 [ 32, %bb.i.i32.i.i ], [ 0, %bb1.i.i34.i.i_1 ] ; <i32> [#uses=1]*/

		/*   %a_addr.0.off0.i.i36.i.i = phi i32 [ %extract.t.i.i31.i.i, %bb.i.i32.i.i ], [ %extract.t4.i.i33.i.i, %bb1.i.i34.i.i_1 ] ; <i32> [#uses=3]*/

		/*   br label %normalizeFloat64Subnormal.exit42.i.i_1*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_1;
	end
	normalizeFloat64Subnormal_exit42_i_i_1:
	begin
		/*   %116 = shl i32 %a_addr.0.off0.i.i36.i.i, 16     ; <i32> [#uses=1]*/
		var117 = a_addr_0_off0_i_i36_i_i <<< (32'd16 % 32);
		/*   %117 = icmp ult i32 %a_addr.0.off0.i.i36.i.i, 65536 ; <i1> [#uses=2]*/
		var118 = a_addr_0_off0_i_i36_i_i < 32'd65536;
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_2*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_2;
	end
	normalizeFloat64Subnormal_exit42_i_i_2:
	begin
		/*   %.a.i.i.i37.i.i = select i1 %117, i32 %116, i32 %a_addr.0.off0.i.i36.i.i ; <i32> [#uses=3]*/
		_a_i_i_i37_i_i = (var118) ? var117 : a_addr_0_off0_i_i36_i_i;
		/*   %shiftCount.0.i.i.i38.i.i = select i1 %117, i32 16, i32 0 ; <i32> [#uses=2]*/
		shiftCount_0_i_i_i38_i_i = (var118) ? 32'd16 : 32'd0;
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_3*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_3;
	end
	normalizeFloat64Subnormal_exit42_i_i_3:
	begin
		/*   %118 = icmp ult i32 %.a.i.i.i37.i.i, 16777216   ; <i1> [#uses=2]*/
		var119 = _a_i_i_i37_i_i < 32'd16777216;
		/*   %119 = or i32 %shiftCount.0.i.i.i38.i.i, 8      ; <i32> [#uses=1]*/
		var120 = shiftCount_0_i_i_i38_i_i | 32'd8;
		/*   %120 = shl i32 %.a.i.i.i37.i.i, 8               ; <i32> [#uses=1]*/
		var121 = _a_i_i_i37_i_i <<< (32'd8 % 32);
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_4*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_4;
	end
	normalizeFloat64Subnormal_exit42_i_i_4:
	begin
		/*   %shiftCount.1.i.i.i39.i.i = select i1 %118, i32 %119, i32 %shiftCount.0.i.i.i38.i.i ; <i32> [#uses=1]*/
		shiftCount_1_i_i_i39_i_i = (var119) ? var120 : shiftCount_0_i_i_i38_i_i;
		/*   %a_addr.1.i.i.i40.i.i = select i1 %118, i32 %120, i32 %.a.i.i.i37.i.i ; <i32> [#uses=1]*/
		a_addr_1_i_i_i40_i_i = (var119) ? var121 : _a_i_i_i37_i_i;
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_5*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_5;
	end
	normalizeFloat64Subnormal_exit42_i_i_5:
	begin
		/*   %121 = lshr i32 %a_addr.1.i.i.i40.i.i, 24       ; <i32> [#uses=1]*/
		var122 = a_addr_1_i_i_i40_i_i >>> (32'd24 % 32);
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_6*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_6;
	end
	normalizeFloat64Subnormal_exit42_i_i_6:
	begin
		/*   %122 = getelementptr inbounds [256 x i32]* @countLeadingZerosHigh.1302, i32 0, i32 %121 ; <i32*> [#uses=1]*/
		var123 = {`TAG_countLeadingZerosHigh_1302, 32'b0} + ((var122 + 256*(32'd0)) << 2);
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_7*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_7;
	end
	normalizeFloat64Subnormal_exit42_i_i_7:
	begin
		/*   %123 = load i32* %122, align 4                  ; <i32> [#uses=1]*/
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_8*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_8;
	end
	normalizeFloat64Subnormal_exit42_i_i_8:
	begin
		var124 = memory_controller_out[31:0];
		/*   %load_noop7 = add i32 %123, 0                   ; <i32> [#uses=1]*/
		load_noop7 = var124 + 32'd0;
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_9*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_9;
	end
	normalizeFloat64Subnormal_exit42_i_i_9:
	begin
		/*   %124 = add nsw i32 %load_noop7, %shiftCount.0.i.i35.i.i ; <i32> [#uses=1]*/
		var125 = load_noop7 + shiftCount_0_i_i35_i_i;
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_10*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_10;
	end
	normalizeFloat64Subnormal_exit42_i_i_10:
	begin
		/*   %125 = add nsw i32 %124, %shiftCount.1.i.i.i39.i.i ; <i32> [#uses=2]*/
		var126 = var125 + shiftCount_1_i_i_i39_i_i;
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_11*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_11;
	end
	normalizeFloat64Subnormal_exit42_i_i_11:
	begin
		/*   %126 = add i32 %125, -11                        ; <i32> [#uses=1]*/
		var127 = var126 + -32'd11;
		/*   %127 = sub i32 12, %125                         ; <i32> [#uses=1]*/
		var128 = 32'd12 - var126;
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_12*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_12;
	end
	normalizeFloat64Subnormal_exit42_i_i_12:
	begin
		/*   %.cast.i41.i.i = zext i32 %126 to i64           ; <i64> [#uses=1]*/
		_cast_i41_i_i = var127;
		/*   br label %normalizeFloat64Subnormal.exit42.i.i_13*/
		cur_state = normalizeFloat64Subnormal_exit42_i_i_13;
	end
	normalizeFloat64Subnormal_exit42_i_i_13:
	begin
		/*   %128 = shl i64 %32, %.cast.i41.i.i              ; <i64> [#uses=1]*/
		var129 = var32 <<< (_cast_i41_i_i % 64);
		/*   br label %bb17.i.i*/
		bSig_0_i_i = var129;   /* for PHI node */
		bExp_0_i_i = var128;   /* for PHI node */
		cur_state = bb17_i_i;
	end
	bb17_i_i:
	begin
		/*   %bSig.0.i.i = phi i64 [ %128, %normalizeFloat64Subnormal.exit42.i.i_13 ], [ %32, %bb7.i.i ] ; <i64> [#uses=5]*/

		/*   %bExp.0.i.i = phi i32 [ %127, %normalizeFloat64Subnormal.exit42.i.i_13 ], [ %39, %bb7.i.i ] ; <i32> [#uses=1]*/

		/*   %129 = icmp eq i32 %38, 0                       ; <i1> [#uses=1]*/
		var130 = var38 == 32'd0;
		/*   br label %bb17.i.i_1*/
		cur_state = bb17_i_i_1;
	end
	bb17_i_i_1:
	begin
		/*   br i1 %129, label %bb18.i.i, label %bb21.i.i*/
		if (var130) begin
			cur_state = bb18_i_i;
		end
		else begin
			aSig_1_i_i = var30;   /* for PHI node */
			aExp_0_i_i = var38;   /* for PHI node */
			cur_state = bb21_i_i;
		end
	end
	bb18_i_i:
	begin
		/*   %130 = icmp eq i64 %30, 0                       ; <i1> [#uses=1]*/
		var131 = var30 == 64'd0;
		/*   br label %bb18.i.i_1*/
		cur_state = bb18_i_i_1;
	end
	bb18_i_i_1:
	begin
		/*   br i1 %130, label %bb19.i.i, label %bb20.i.i*/
		if (var131) begin
			cur_state = bb19_i_i;
		end
		else begin
			cur_state = bb20_i_i;
		end
	end
	bb19_i_i:
	begin
		/*   %131 = and i64 %34, -9223372036854775808        ; <i64> [#uses=1]*/
		var132 = var34 & -64'd9223372036854775808;
		/*   br label %float64_div.exit.i*/
		var60 = var132;   /* for PHI node */
		cur_state = float64_div_exit_i;
	end
	bb20_i_i:
	begin
		/*   %132 = icmp ult i64 %30, 4294967296             ; <i1> [#uses=1]*/
		var133 = var30 < 64'd4294967296;
		/*   br label %bb20.i.i_1*/
		cur_state = bb20_i_i_1;
	end
	bb20_i_i_1:
	begin
		/*   br i1 %132, label %bb.i.i.i.i, label %bb1.i.i.i.i*/
		if (var133) begin
			cur_state = bb_i_i_i_i;
		end
		else begin
			cur_state = bb1_i_i_i_i;
		end
	end
	bb_i_i_i_i:
	begin
		/*   %extract.t.i.i.i.i = trunc i64 %29 to i32       ; <i32> [#uses=1]*/
		extract_t_i_i_i_i = var29[31:0];
		/*   br label %normalizeFloat64Subnormal.exit.i.i*/
		shiftCount_0_i_i_i_i = 32'd32;   /* for PHI node */
		a_addr_0_off0_i_i_i_i = extract_t_i_i_i_i;   /* for PHI node */
		cur_state = normalizeFloat64Subnormal_exit_i_i;
	end
	bb1_i_i_i_i:
	begin
		/*   %133 = lshr i64 %30, 32                         ; <i64> [#uses=1]*/
		var134 = var30 >>> (64'd32 % 64);
		/*   br label %bb1.i.i.i.i_1*/
		cur_state = bb1_i_i_i_i_1;
	end
	bb1_i_i_i_i_1:
	begin
		/*   %extract.t4.i.i.i.i = trunc i64 %133 to i32     ; <i32> [#uses=1]*/
		extract_t4_i_i_i_i = var134[31:0];
		/*   br label %normalizeFloat64Subnormal.exit.i.i*/
		shiftCount_0_i_i_i_i = 32'd0;   /* for PHI node */
		a_addr_0_off0_i_i_i_i = extract_t4_i_i_i_i;   /* for PHI node */
		cur_state = normalizeFloat64Subnormal_exit_i_i;
	end
	normalizeFloat64Subnormal_exit_i_i:
	begin
		/*   %shiftCount.0.i.i.i.i = phi i32 [ 32, %bb.i.i.i.i ], [ 0, %bb1.i.i.i.i_1 ] ; <i32> [#uses=1]*/

		/*   %a_addr.0.off0.i.i.i.i = phi i32 [ %extract.t.i.i.i.i, %bb.i.i.i.i ], [ %extract.t4.i.i.i.i, %bb1.i.i.i.i_1 ] ; <i32> [#uses=3]*/

		/*   br label %normalizeFloat64Subnormal.exit.i.i_1*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_1;
	end
	normalizeFloat64Subnormal_exit_i_i_1:
	begin
		/*   %134 = shl i32 %a_addr.0.off0.i.i.i.i, 16       ; <i32> [#uses=1]*/
		var135 = a_addr_0_off0_i_i_i_i <<< (32'd16 % 32);
		/*   %135 = icmp ult i32 %a_addr.0.off0.i.i.i.i, 65536 ; <i1> [#uses=2]*/
		var136 = a_addr_0_off0_i_i_i_i < 32'd65536;
		/*   br label %normalizeFloat64Subnormal.exit.i.i_2*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_2;
	end
	normalizeFloat64Subnormal_exit_i_i_2:
	begin
		/*   %.a.i.i.i.i.i = select i1 %135, i32 %134, i32 %a_addr.0.off0.i.i.i.i ; <i32> [#uses=3]*/
		_a_i_i_i_i_i = (var136) ? var135 : a_addr_0_off0_i_i_i_i;
		/*   %shiftCount.0.i.i.i.i.i = select i1 %135, i32 16, i32 0 ; <i32> [#uses=2]*/
		shiftCount_0_i_i_i_i_i = (var136) ? 32'd16 : 32'd0;
		/*   br label %normalizeFloat64Subnormal.exit.i.i_3*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_3;
	end
	normalizeFloat64Subnormal_exit_i_i_3:
	begin
		/*   %136 = icmp ult i32 %.a.i.i.i.i.i, 16777216     ; <i1> [#uses=2]*/
		var137 = _a_i_i_i_i_i < 32'd16777216;
		/*   %137 = or i32 %shiftCount.0.i.i.i.i.i, 8        ; <i32> [#uses=1]*/
		var138 = shiftCount_0_i_i_i_i_i | 32'd8;
		/*   %138 = shl i32 %.a.i.i.i.i.i, 8                 ; <i32> [#uses=1]*/
		var139 = _a_i_i_i_i_i <<< (32'd8 % 32);
		/*   br label %normalizeFloat64Subnormal.exit.i.i_4*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_4;
	end
	normalizeFloat64Subnormal_exit_i_i_4:
	begin
		/*   %shiftCount.1.i.i.i.i.i = select i1 %136, i32 %137, i32 %shiftCount.0.i.i.i.i.i ; <i32> [#uses=1]*/
		shiftCount_1_i_i_i_i_i = (var137) ? var138 : shiftCount_0_i_i_i_i_i;
		/*   %a_addr.1.i.i.i.i.i = select i1 %136, i32 %138, i32 %.a.i.i.i.i.i ; <i32> [#uses=1]*/
		a_addr_1_i_i_i_i_i = (var137) ? var139 : _a_i_i_i_i_i;
		/*   br label %normalizeFloat64Subnormal.exit.i.i_5*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_5;
	end
	normalizeFloat64Subnormal_exit_i_i_5:
	begin
		/*   %139 = lshr i32 %a_addr.1.i.i.i.i.i, 24         ; <i32> [#uses=1]*/
		var140 = a_addr_1_i_i_i_i_i >>> (32'd24 % 32);
		/*   br label %normalizeFloat64Subnormal.exit.i.i_6*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_6;
	end
	normalizeFloat64Subnormal_exit_i_i_6:
	begin
		/*   %140 = getelementptr inbounds [256 x i32]* @countLeadingZerosHigh.1302, i32 0, i32 %139 ; <i32*> [#uses=1]*/
		var141 = {`TAG_countLeadingZerosHigh_1302, 32'b0} + ((var140 + 256*(32'd0)) << 2);
		/*   br label %normalizeFloat64Subnormal.exit.i.i_7*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_7;
	end
	normalizeFloat64Subnormal_exit_i_i_7:
	begin
		/*   %141 = load i32* %140, align 4                  ; <i32> [#uses=1]*/
		/*   br label %normalizeFloat64Subnormal.exit.i.i_8*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_8;
	end
	normalizeFloat64Subnormal_exit_i_i_8:
	begin
		var142 = memory_controller_out[31:0];
		/*   %load_noop8 = add i32 %141, 0                   ; <i32> [#uses=1]*/
		load_noop8 = var142 + 32'd0;
		/*   br label %normalizeFloat64Subnormal.exit.i.i_9*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_9;
	end
	normalizeFloat64Subnormal_exit_i_i_9:
	begin
		/*   %142 = add nsw i32 %load_noop8, %shiftCount.0.i.i.i.i ; <i32> [#uses=1]*/
		var143 = load_noop8 + shiftCount_0_i_i_i_i;
		/*   br label %normalizeFloat64Subnormal.exit.i.i_10*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_10;
	end
	normalizeFloat64Subnormal_exit_i_i_10:
	begin
		/*   %143 = add nsw i32 %142, %shiftCount.1.i.i.i.i.i ; <i32> [#uses=2]*/
		var144 = var143 + shiftCount_1_i_i_i_i_i;
		/*   br label %normalizeFloat64Subnormal.exit.i.i_11*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_11;
	end
	normalizeFloat64Subnormal_exit_i_i_11:
	begin
		/*   %144 = add i32 %143, -11                        ; <i32> [#uses=1]*/
		var145 = var144 + -32'd11;
		/*   %145 = sub i32 12, %143                         ; <i32> [#uses=1]*/
		var146 = 32'd12 - var144;
		/*   br label %normalizeFloat64Subnormal.exit.i.i_12*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_12;
	end
	normalizeFloat64Subnormal_exit_i_i_12:
	begin
		/*   %.cast.i.i.i = zext i32 %144 to i64             ; <i64> [#uses=1]*/
		_cast_i_i_i = var145;
		/*   br label %normalizeFloat64Subnormal.exit.i.i_13*/
		cur_state = normalizeFloat64Subnormal_exit_i_i_13;
	end
	normalizeFloat64Subnormal_exit_i_i_13:
	begin
		/*   %146 = shl i64 %30, %.cast.i.i.i                ; <i64> [#uses=1]*/
		var147 = var30 <<< (_cast_i_i_i % 64);
		/*   br label %bb21.i.i*/
		aSig_1_i_i = var147;   /* for PHI node */
		aExp_0_i_i = var146;   /* for PHI node */
		cur_state = bb21_i_i;
	end
	bb21_i_i:
	begin
		/*   %aSig.1.i.i = phi i64 [ %146, %normalizeFloat64Subnormal.exit.i.i_13 ], [ %30, %bb17.i.i_1 ] ; <i64> [#uses=1]*/

		/*   %aExp.0.i.i = phi i32 [ %145, %normalizeFloat64Subnormal.exit.i.i_13 ], [ %38, %bb17.i.i_1 ] ; <i32> [#uses=1]*/

		/*   %147 = shl i64 %bSig.0.i.i, 11                  ; <i64> [#uses=3]*/
		var148 = bSig_0_i_i <<< (64'd11 % 64);
		/*   br label %bb21.i.i_1*/
		cur_state = bb21_i_i_1;
	end
	bb21_i_i_1:
	begin
		/*   %148 = shl i64 %aSig.1.i.i, 10                  ; <i64> [#uses=1]*/
		var149 = aSig_1_i_i <<< (64'd10 % 64);
		/*   %149 = or i64 %147, -9223372036854775808        ; <i64> [#uses=9]*/
		var150 = var148 | -64'd9223372036854775808;
		/*   %150 = sub i32 %aExp.0.i.i, %bExp.0.i.i         ; <i32> [#uses=1]*/
		var151 = aExp_0_i_i - bExp_0_i_i;
		/*   br label %bb21.i.i_2*/
		cur_state = bb21_i_i_2;
	end
	bb21_i_i_2:
	begin
		/*   %151 = or i64 %148, 4611686018427387904         ; <i64> [#uses=2]*/
		var152 = var149 | 64'd4611686018427387904;
		/*   br label %bb21.i.i_3*/
		cur_state = bb21_i_i_3;
	end
	bb21_i_i_3:
	begin
		/*   %152 = shl i64 %151, 1                          ; <i64> [#uses=1]*/
		var153 = var152 <<< (64'd1 % 64);
		/*   br label %bb21.i.i_4*/
		cur_state = bb21_i_i_4;
	end
	bb21_i_i_4:
	begin
		/*   %153 = icmp ult i64 %152, %149                  ; <i1> [#uses=2]*/
		var154 = var153 < var150;
		/*   br label %bb21.i.i_5*/
		cur_state = bb21_i_i_5;
	end
	bb21_i_i_5:
	begin
		/*   %154 = zext i1 %153 to i64                      ; <i64> [#uses=1]*/
		var155 = var154;
		/*   %zExp.0.v.i.i = select i1 %153, i32 1021, i32 1022 ; <i32> [#uses=1]*/
		zExp_0_v_i_i = (var154) ? 32'd1021 : 32'd1022;
		/*   br label %bb21.i.i_6*/
		cur_state = bb21_i_i_6;
	end
	bb21_i_i_6:
	begin
		/*   %155 = xor i64 %154, 1                          ; <i64> [#uses=1]*/
		var156 = var155 ^ 64'd1;
		/*   %zExp.0.i.i = add i32 %150, %zExp.0.v.i.i       ; <i32> [#uses=1]*/
		zExp_0_i_i = var151 + zExp_0_v_i_i;
		/*   br label %bb21.i.i_7*/
		cur_state = bb21_i_i_7;
	end
	bb21_i_i_7:
	begin
		/*   %aSig.0.i.i = lshr i64 %151, %155               ; <i64> [#uses=5]*/
		aSig_0_i_i = var152 >>> (var156 % 64);
		/*   br label %bb21.i.i_8*/
		cur_state = bb21_i_i_8;
	end
	bb21_i_i_8:
	begin
		/*   %156 = icmp ugt i64 %149, %aSig.0.i.i           ; <i1> [#uses=1]*/
		var157 = var150 > aSig_0_i_i;
		/*   br label %bb21.i.i_9*/
		cur_state = bb21_i_i_9;
	end
	bb21_i_i_9:
	begin
		/*   br i1 %156, label %bb1.i.i.i, label %estimateDiv128To64.exit.i.i*/
		if (var157) begin
			cur_state = bb1_i_i_i;
		end
		else begin
			var158 = -64'd1;   /* for PHI node */
			cur_state = estimateDiv128To64_exit_i_i;
		end
	end
	bb1_i_i_i:
	begin
		/*   %157 = lshr i64 %149, 32                        ; <i64> [#uses=4]*/
		var159 = var150 >>> (64'd32 % 64);
		/*   %158 = and i64 %149, -4294967296                ; <i64> [#uses=2]*/
		var160 = var150 & -64'd4294967296;
		/*   br label %bb1.i.i.i_1*/
		cur_state = bb1_i_i_i_1;
	end
	bb1_i_i_i_1:
	begin
		/*   %159 = icmp ugt i64 %158, %aSig.0.i.i           ; <i1> [#uses=1]*/
		var161 = var160 > aSig_0_i_i;
		/*   br label %bb1.i.i.i_2*/
		cur_state = bb1_i_i_i_2;
	end
	bb1_i_i_i_2:
	begin
		/*   br i1 %159, label %bb2.i.i3.i, label %bb4.i.i.i*/
		if (var161) begin
			cur_state = bb2_i_i3_i;
		end
		else begin
			iftmp_18_0_i_i_i = -64'd4294967296;   /* for PHI node */
			cur_state = bb4_i_i_i;
		end
	end
	bb2_i_i3_i:
	begin
		/*   %160 = udiv i64 %aSig.0.i.i, %157               ; <i64> [#uses=1]*/
		var162 = aSig_0_i_i / var159;
		/*   br label %bb2.i.i3.i_1*/
		cur_state = bb2_i_i3_i_1;
	end
	bb2_i_i3_i_1:
	begin
		/*   %161 = shl i64 %160, 32                         ; <i64> [#uses=1]*/
		var163 = var162 <<< (64'd32 % 64);
		/*   br label %bb4.i.i.i*/
		iftmp_18_0_i_i_i = var163;   /* for PHI node */
		cur_state = bb4_i_i_i;
	end
	bb4_i_i_i:
	begin
		/*   %iftmp.18.0.i.i.i = phi i64 [ %161, %bb2.i.i3.i_1 ], [ -4294967296, %bb1.i.i.i_2 ] ; <i64> [#uses=3]*/

		/*   %162 = and i64 %147, 4294965248                 ; <i64> [#uses=1]*/
		var164 = var148 & 64'd4294965248;
		/*   br label %bb4.i.i.i_1*/
		cur_state = bb4_i_i_i_1;
	end
	bb4_i_i_i_1:
	begin
		/*   %163 = lshr i64 %iftmp.18.0.i.i.i, 32           ; <i64> [#uses=3]*/
		var165 = iftmp_18_0_i_i_i >>> (64'd32 % 64);
		/*   br label %bb4.i.i.i_2*/
		cur_state = bb4_i_i_i_2;
	end
	bb4_i_i_i_2:
	begin
		/*   %164 = mul i64 %163, %162                       ; <i64> [#uses=2]*/
		var166 = var165 * var164;
		/*   %165 = mul i64 %163, %157                       ; <i64> [#uses=1]*/
		var167 = var165 * var159;
		/*   br label %bb4.i.i.i_3*/
		cur_state = bb4_i_i_i_3;
	end
	bb4_i_i_i_3:
	begin
		/*   %166 = lshr i64 %164, 32                        ; <i64> [#uses=1]*/
		var168 = var166 >>> (64'd32 % 64);
		/*   %167 = shl i64 %164, 32                         ; <i64> [#uses=2]*/
		var169 = var166 <<< (64'd32 % 64);
		/*   %.neg2.i.i.i = sub i64 %aSig.0.i.i, %165        ; <i64> [#uses=1]*/
		_neg2_i_i_i = aSig_0_i_i - var167;
		/*   br label %bb4.i.i.i_4*/
		cur_state = bb4_i_i_i_4;
	end
	bb4_i_i_i_4:
	begin
		/*   %168 = sub i64 0, %167                          ; <i64> [#uses=1]*/
		var170 = 64'd0 - var169;
		/*   %169 = icmp ne i64 %167, 0                      ; <i1> [#uses=1]*/
		var171 = var169 != 64'd0;
		/*   %170 = sub i64 %.neg2.i.i.i, %166               ; <i64> [#uses=1]*/
		var172 = _neg2_i_i_i - var168;
		/*   br label %bb4.i.i.i_5*/
		cur_state = bb4_i_i_i_5;
	end
	bb4_i_i_i_5:
	begin
		/*   %.neg.i.i.i.i = select i1 %169, i64 -1, i64 0   ; <i64> [#uses=1]*/
		_neg_i_i_i_i = (var171) ? -64'd1 : 64'd0;
		/*   br label %bb4.i.i.i_6*/
		cur_state = bb4_i_i_i_6;
	end
	bb4_i_i_i_6:
	begin
		/*   %171 = add i64 %170, %.neg.i.i.i.i              ; <i64> [#uses=3]*/
		var173 = var172 + _neg_i_i_i_i;
		/*   br label %bb4.i.i.i_7*/
		cur_state = bb4_i_i_i_7;
	end
	bb4_i_i_i_7:
	begin
		/*   %172 = icmp slt i64 %171, 0                     ; <i1> [#uses=1]*/
		var174 = $signed(var173) < $signed(64'd0);
		/*   br label %bb4.i.i.i_8*/
		cur_state = bb4_i_i_i_8;
	end
	bb4_i_i_i_8:
	begin
		/*   br i1 %172, label %bb.nph.i.i.i, label %bb7.i.i.i*/
		if (var174) begin
			cur_state = bb_nph_i_i_i;
		end
		else begin
			z_0_lcssa_i_i_i = iftmp_18_0_i_i_i;   /* for PHI node */
			rem0_0_lcssa_i_i_i = var173;   /* for PHI node */
			rem1_0_lcssa_i_i_i = var170;   /* for PHI node */
			cur_state = bb7_i_i_i;
		end
	end
	bb_nph_i_i_i:
	begin
		/*   %bSig.0130.i.i = trunc i64 %bSig.0.i.i to i32   ; <i32> [#uses=1]*/
		bSig_0130_i_i = bSig_0_i_i[31:0];
		/*   %tmp125.i.i = shl i64 %bSig.0.i.i, 43           ; <i64> [#uses=1]*/
		tmp125_i_i = bSig_0_i_i <<< (64'd43 % 64);
		/*   br label %bb.nph.i.i.i_1*/
		cur_state = bb_nph_i_i_i_1;
	end
	bb_nph_i_i_i_1:
	begin
		/*   %tmp121.i.i = shl i32 %bSig.0130.i.i, 11        ; <i32> [#uses=1]*/
		tmp121_i_i = bSig_0130_i_i <<< (32'd11 % 32);
		/*   br label %bb.nph.i.i.i_2*/
		cur_state = bb_nph_i_i_i_2;
	end
	bb_nph_i_i_i_2:
	begin
		/*   %tmp122.i.i = zext i32 %tmp121.i.i to i64       ; <i64> [#uses=1]*/
		tmp122_i_i = tmp121_i_i;
		/*   br label %bb.nph.i.i.i_3*/
		cur_state = bb_nph_i_i_i_3;
	end
	bb_nph_i_i_i_3:
	begin
		/*   %tmp123.i.i = mul i64 %163, %tmp122.i.i         ; <i64> [#uses=1]*/
		tmp123_i_i = var165 * tmp122_i_i;
		/*   br label %bb.nph.i.i.i_4*/
		cur_state = bb_nph_i_i_i_4;
	end
	bb_nph_i_i_i_4:
	begin
		/*   %tmp124.i.i = mul i64 %tmp123.i.i, -4294967296  ; <i64> [#uses=2]*/
		tmp124_i_i = tmp123_i_i * -64'd4294967296;
		/*   br label %bb.nph.i.i.i_5*/
		cur_state = bb_nph_i_i_i_5;
	end
	bb_nph_i_i_i_5:
	begin
		/*   %tmp126.i.i = add i64 %tmp124.i.i, %tmp125.i.i  ; <i64> [#uses=1]*/
		tmp126_i_i = tmp124_i_i + tmp125_i_i;
		/*   br label %bb5.i.i.i*/
		var175 = 64'd0;   /* for PHI node */
		rem0_05_i_i_i = var173;   /* for PHI node */
		cur_state = bb5_i_i_i;
	end
	bb5_i_i_i:
	begin
		/*   %173 = phi i64 [ 0, %bb.nph.i.i.i_5 ], [ %indvar.next.i.i.i, %bb5.i.i.i_8 ] ; <i64> [#uses=3]*/

		/*   %rem0.05.i.i.i = phi i64 [ %171, %bb.nph.i.i.i_5 ], [ %177, %bb5.i.i.i_8 ] ; <i64> [#uses=1]*/

		/*   br label %bb5.i.i.i_1*/
		cur_state = bb5_i_i_i_1;
	end
	bb5_i_i_i_1:
	begin
		/*   %tmp117.i.i = mul i64 %173, %bSig.0.i.i         ; <i64> [#uses=1]*/
		tmp117_i_i = var175 * bSig_0_i_i;
		/*   %174 = add i64 %rem0.05.i.i.i, %157             ; <i64> [#uses=1]*/
		var176 = rem0_05_i_i_i + var159;
		/*   %indvar.next.i.i.i = add i64 %173, 1            ; <i64> [#uses=1]*/
		indvar_next_i_i_i = var175 + 64'd1;
		/*   br label %bb5.i.i.i_2*/
		cur_state = bb5_i_i_i_2;
	end
	bb5_i_i_i_2:
	begin
		/*   %tmp118.i.i = shl i64 %tmp117.i.i, 43           ; <i64> [#uses=2]*/
		tmp118_i_i = tmp117_i_i <<< (64'd43 % 64);
		/*   br label %bb5.i.i.i_3*/
		cur_state = bb5_i_i_i_3;
	end
	bb5_i_i_i_3:
	begin
		/*   %tmp23.i.i.i = add i64 %tmp118.i.i, %tmp126.i.i ; <i64> [#uses=2]*/
		tmp23_i_i_i = tmp118_i_i + tmp126_i_i;
		/*   %rem1.04.i.i.i = add i64 %tmp118.i.i, %tmp124.i.i ; <i64> [#uses=1]*/
		rem1_04_i_i_i = tmp118_i_i + tmp124_i_i;
		/*   br label %bb5.i.i.i_4*/
		cur_state = bb5_i_i_i_4;
	end
	bb5_i_i_i_4:
	begin
		/*   %175 = icmp ult i64 %tmp23.i.i.i, %rem1.04.i.i.i ; <i1> [#uses=1]*/
		var177 = tmp23_i_i_i < rem1_04_i_i_i;
		/*   br label %bb5.i.i.i_5*/
		cur_state = bb5_i_i_i_5;
	end
	bb5_i_i_i_5:
	begin
		/*   %176 = zext i1 %175 to i64                      ; <i64> [#uses=1]*/
		var178 = var177;
		/*   br label %bb5.i.i.i_6*/
		cur_state = bb5_i_i_i_6;
	end
	bb5_i_i_i_6:
	begin
		/*   %177 = add i64 %174, %176                       ; <i64> [#uses=3]*/
		var179 = var176 + var178;
		/*   br label %bb5.i.i.i_7*/
		cur_state = bb5_i_i_i_7;
	end
	bb5_i_i_i_7:
	begin
		/*   %178 = icmp slt i64 %177, 0                     ; <i1> [#uses=1]*/
		var180 = $signed(var179) < $signed(64'd0);
		/*   br label %bb5.i.i.i_8*/
		cur_state = bb5_i_i_i_8;
	end
	bb5_i_i_i_8:
	begin
		/*   br i1 %178, label %bb5.i.i.i, label %bb6.bb7_crit_edge.i.i.i*/
		if (var180) begin
			var175 = indvar_next_i_i_i;   /* for PHI node */
			rem0_05_i_i_i = var179;   /* for PHI node */
			cur_state = bb5_i_i_i;
		end
		else begin
			cur_state = bb6_bb7_crit_edge_i_i_i;
		end
	end
	bb6_bb7_crit_edge_i_i_i:
	begin
		/*   %tmp.i.i.i = mul i64 %173, -4294967296          ; <i64> [#uses=1]*/
		tmp_i_i_i = var175 * -64'd4294967296;
		/*   %tmp11.i.i.i = add i64 %iftmp.18.0.i.i.i, -4294967296 ; <i64> [#uses=1]*/
		tmp11_i_i_i = iftmp_18_0_i_i_i + -64'd4294967296;
		/*   br label %bb6.bb7_crit_edge.i.i.i_1*/
		cur_state = bb6_bb7_crit_edge_i_i_i_1;
	end
	bb6_bb7_crit_edge_i_i_i_1:
	begin
		/*   %tmp12.i.i.i = add i64 %tmp11.i.i.i, %tmp.i.i.i ; <i64> [#uses=1]*/
		tmp12_i_i_i = tmp11_i_i_i + tmp_i_i_i;
		/*   br label %bb7.i.i.i*/
		z_0_lcssa_i_i_i = tmp12_i_i_i;   /* for PHI node */
		rem0_0_lcssa_i_i_i = var179;   /* for PHI node */
		rem1_0_lcssa_i_i_i = tmp23_i_i_i;   /* for PHI node */
		cur_state = bb7_i_i_i;
	end
	bb7_i_i_i:
	begin
		/*   %z.0.lcssa.i.i.i = phi i64 [ %tmp12.i.i.i, %bb6.bb7_crit_edge.i.i.i_1 ], [ %iftmp.18.0.i.i.i, %bb4.i.i.i_8 ] ; <i64> [#uses=1]*/

		/*   %rem0.0.lcssa.i.i.i = phi i64 [ %177, %bb6.bb7_crit_edge.i.i.i_1 ], [ %171, %bb4.i.i.i_8 ] ; <i64> [#uses=1]*/

		/*   %rem1.0.lcssa.i.i.i = phi i64 [ %tmp23.i.i.i, %bb6.bb7_crit_edge.i.i.i_1 ], [ %168, %bb4.i.i.i_8 ] ; <i64> [#uses=1]*/

		/*   br label %bb7.i.i.i_1*/
		cur_state = bb7_i_i_i_1;
	end
	bb7_i_i_i_1:
	begin
		/*   %179 = shl i64 %rem0.0.lcssa.i.i.i, 32          ; <i64> [#uses=1]*/
		var181 = rem0_0_lcssa_i_i_i <<< (64'd32 % 64);
		/*   %180 = lshr i64 %rem1.0.lcssa.i.i.i, 32         ; <i64> [#uses=1]*/
		var182 = rem1_0_lcssa_i_i_i >>> (64'd32 % 64);
		/*   br label %bb7.i.i.i_2*/
		cur_state = bb7_i_i_i_2;
	end
	bb7_i_i_i_2:
	begin
		/*   %181 = or i64 %180, %179                        ; <i64> [#uses=2]*/
		var183 = var182 | var181;
		/*   br label %bb7.i.i.i_3*/
		cur_state = bb7_i_i_i_3;
	end
	bb7_i_i_i_3:
	begin
		/*   %182 = icmp ugt i64 %158, %181                  ; <i1> [#uses=1]*/
		var184 = var160 > var183;
		/*   br label %bb7.i.i.i_4*/
		cur_state = bb7_i_i_i_4;
	end
	bb7_i_i_i_4:
	begin
		/*   br i1 %182, label %bb8.i.i.i, label %bb10.i.i4.i*/
		if (var184) begin
			cur_state = bb8_i_i_i;
		end
		else begin
			iftmp_27_0_i_i_i = 64'd4294967295;   /* for PHI node */
			cur_state = bb10_i_i4_i;
		end
	end
	bb8_i_i_i:
	begin
		/*   %183 = udiv i64 %181, %157                      ; <i64> [#uses=1]*/
		var185 = var183 / var159;
		/*   br label %bb10.i.i4.i*/
		iftmp_27_0_i_i_i = var185;   /* for PHI node */
		cur_state = bb10_i_i4_i;
	end
	bb10_i_i4_i:
	begin
		/*   %iftmp.27.0.i.i.i = phi i64 [ %183, %bb8.i.i.i ], [ 4294967295, %bb7.i.i.i_4 ] ; <i64> [#uses=1]*/

		/*   br label %bb10.i.i4.i_1*/
		cur_state = bb10_i_i4_i_1;
	end
	bb10_i_i4_i_1:
	begin
		/*   %184 = or i64 %iftmp.27.0.i.i.i, %z.0.lcssa.i.i.i ; <i64> [#uses=1]*/
		var186 = iftmp_27_0_i_i_i | z_0_lcssa_i_i_i;
		/*   br label %estimateDiv128To64.exit.i.i*/
		var158 = var186;   /* for PHI node */
		cur_state = estimateDiv128To64_exit_i_i;
	end
	estimateDiv128To64_exit_i_i:
	begin
		/*   %185 = phi i64 [ %184, %bb10.i.i4.i_1 ], [ -1, %bb21.i.i_9 ] ; <i64> [#uses=6]*/

		/*   br label %estimateDiv128To64.exit.i.i_1*/
		cur_state = estimateDiv128To64_exit_i_i_1;
	end
	estimateDiv128To64_exit_i_i_1:
	begin
		/*   %186 = and i64 %185, 511                        ; <i64> [#uses=1]*/
		var187 = var158 & 64'd511;
		/*   br label %estimateDiv128To64.exit.i.i_2*/
		cur_state = estimateDiv128To64_exit_i_i_2;
	end
	estimateDiv128To64_exit_i_i_2:
	begin
		/*   %187 = icmp ult i64 %186, 3                     ; <i1> [#uses=1]*/
		var188 = var187 < 64'd3;
		/*   br label %estimateDiv128To64.exit.i.i_3*/
		cur_state = estimateDiv128To64_exit_i_i_3;
	end
	estimateDiv128To64_exit_i_i_3:
	begin
		/*   br i1 %187, label %bb24.i.i, label %bb28.i.i*/
		if (var188) begin
			cur_state = bb24_i_i;
		end
		else begin
			zSig_1_i_i = var158;   /* for PHI node */
			cur_state = bb28_i_i;
		end
	end
	bb24_i_i:
	begin
		/*   %188 = lshr i64 %149, 32                        ; <i64> [#uses=3]*/
		var189 = var150 >>> (64'd32 % 64);
		/*   %189 = lshr i64 %185, 32                        ; <i64> [#uses=3]*/
		var190 = var158 >>> (64'd32 % 64);
		/*   %190 = and i64 %147, 4294965248                 ; <i64> [#uses=2]*/
		var191 = var148 & 64'd4294965248;
		/*   %191 = and i64 %185, 4294967295                 ; <i64> [#uses=4]*/
		var192 = var158 & 64'd4294967295;
		/*   br label %bb24.i.i_1*/
		cur_state = bb24_i_i_1;
	end
	bb24_i_i_1:
	begin
		/*   %192 = mul i64 %191, %190                       ; <i64> [#uses=1]*/
		var193 = var192 * var191;
		/*   %193 = mul i64 %189, %190                       ; <i64> [#uses=1]*/
		var194 = var190 * var191;
		/*   %194 = mul i64 %191, %188                       ; <i64> [#uses=2]*/
		var195 = var192 * var189;
		/*   %195 = mul i64 %189, %188                       ; <i64> [#uses=1]*/
		var196 = var190 * var189;
		/*   br label %bb24.i.i_2*/
		cur_state = bb24_i_i_2;
	end
	bb24_i_i_2:
	begin
		/*   %196 = add i64 %193, %194                       ; <i64> [#uses=3]*/
		var197 = var194 + var195;
		/*   %.neg82.i.i = sub i64 %aSig.0.i.i, %195         ; <i64> [#uses=1]*/
		_neg82_i_i = aSig_0_i_i - var196;
		/*   br label %bb24.i.i_3*/
		cur_state = bb24_i_i_3;
	end
	bb24_i_i_3:
	begin
		/*   %197 = icmp ult i64 %196, %194                  ; <i1> [#uses=1]*/
		var198 = var197 < var195;
		/*   %198 = lshr i64 %196, 32                        ; <i64> [#uses=1]*/
		var199 = var197 >>> (64'd32 % 64);
		/*   %199 = shl i64 %196, 32                         ; <i64> [#uses=2]*/
		var200 = var197 <<< (64'd32 % 64);
		/*   br label %bb24.i.i_4*/
		cur_state = bb24_i_i_4;
	end
	bb24_i_i_4:
	begin
		/*   %iftmp.17.0.i.i.i = select i1 %197, i64 4294967296, i64 0 ; <i64> [#uses=1]*/
		iftmp_17_0_i_i_i = (var198) ? 64'd4294967296 : 64'd0;
		/*   %200 = add i64 %199, %192                       ; <i64> [#uses=3]*/
		var201 = var200 + var193;
		/*   br label %bb24.i.i_5*/
		cur_state = bb24_i_i_5;
	end
	bb24_i_i_5:
	begin
		/*   %201 = or i64 %iftmp.17.0.i.i.i, %198           ; <i64> [#uses=1]*/
		var202 = iftmp_17_0_i_i_i | var199;
		/*   %202 = icmp ult i64 %200, %199                  ; <i1> [#uses=1]*/
		var203 = var201 < var200;
		/*   %203 = sub i64 0, %200                          ; <i64> [#uses=2]*/
		var204 = 64'd0 - var201;
		/*   %204 = icmp ne i64 %200, 0                      ; <i1> [#uses=1]*/
		var205 = var201 != 64'd0;
		/*   br label %bb24.i.i_6*/
		cur_state = bb24_i_i_6;
	end
	bb24_i_i_6:
	begin
		/*   %.neg.i.i.i = select i1 %204, i64 -1, i64 0     ; <i64> [#uses=1]*/
		_neg_i_i_i = (var205) ? -64'd1 : 64'd0;
		/*   %.neg83.i.i = select i1 %202, i64 -1, i64 0     ; <i64> [#uses=1]*/
		_neg83_i_i = (var203) ? -64'd1 : 64'd0;
		/*   %.neg84.i.i = sub i64 %.neg82.i.i, %201         ; <i64> [#uses=1]*/
		_neg84_i_i = _neg82_i_i - var202;
		/*   br label %bb24.i.i_7*/
		cur_state = bb24_i_i_7;
	end
	bb24_i_i_7:
	begin
		/*   %205 = add i64 %.neg84.i.i, %.neg.i.i.i         ; <i64> [#uses=1]*/
		var206 = _neg84_i_i + _neg_i_i_i;
		/*   br label %bb24.i.i_8*/
		cur_state = bb24_i_i_8;
	end
	bb24_i_i_8:
	begin
		/*   %206 = add i64 %205, %.neg83.i.i                ; <i64> [#uses=2]*/
		var207 = var206 + _neg83_i_i;
		/*   br label %bb24.i.i_9*/
		cur_state = bb24_i_i_9;
	end
	bb24_i_i_9:
	begin
		/*   %207 = icmp slt i64 %206, 0                     ; <i1> [#uses=1]*/
		var208 = $signed(var207) < $signed(64'd0);
		/*   br label %bb24.i.i_10*/
		cur_state = bb24_i_i_10;
	end
	bb24_i_i_10:
	begin
		/*   br i1 %207, label %bb.nph.i.i, label %bb27.i.i*/
		if (var208) begin
			cur_state = bb_nph_i_i;
		end
		else begin
			zSig_0_lcssa_i_i = var158;   /* for PHI node */
			rem1_0_lcssa_i_i = var204;   /* for PHI node */
			cur_state = bb27_i_i;
		end
	end
	bb_nph_i_i:
	begin
		/*   %tmp91.i.i = add i64 %185, -1                   ; <i64> [#uses=1]*/
		tmp91_i_i = var158 + -64'd1;
		/*   %bSig.0129.i.i = trunc i64 %bSig.0.i.i to i32   ; <i32> [#uses=1]*/
		bSig_0129_i_i = bSig_0_i_i[31:0];
		/*   %tmp103.i.i = mul i64 %188, %191                ; <i64> [#uses=1]*/
		tmp103_i_i = var189 * var192;
		/*   br label %bb.nph.i.i_1*/
		cur_state = bb_nph_i_i_1;
	end
	bb_nph_i_i_1:
	begin
		/*   %tmp97.i.i = shl i32 %bSig.0129.i.i, 11         ; <i32> [#uses=1]*/
		tmp97_i_i = bSig_0129_i_i <<< (32'd11 % 32);
		/*   br label %bb.nph.i.i_2*/
		cur_state = bb_nph_i_i_2;
	end
	bb_nph_i_i_2:
	begin
		/*   %tmp98.i.i = zext i32 %tmp97.i.i to i64         ; <i64> [#uses=2]*/
		tmp98_i_i = tmp97_i_i;
		/*   br label %bb.nph.i.i_3*/
		cur_state = bb_nph_i_i_3;
	end
	bb_nph_i_i_3:
	begin
		/*   %tmp99.i.i = mul i64 %191, %tmp98.i.i           ; <i64> [#uses=2]*/
		tmp99_i_i = var192 * tmp98_i_i;
		/*   %tmp105.i.i = mul i64 %189, %tmp98.i.i          ; <i64> [#uses=1]*/
		tmp105_i_i = var190 * tmp98_i_i;
		/*   br label %bb.nph.i.i_4*/
		cur_state = bb_nph_i_i_4;
	end
	bb_nph_i_i_4:
	begin
		/*   %tmp101.i.i = sub i64 %149, %tmp99.i.i          ; <i64> [#uses=1]*/
		tmp101_i_i = var150 - tmp99_i_i;
		/*   %tmp106.i.i = add i64 %tmp103.i.i, %tmp105.i.i  ; <i64> [#uses=2]*/
		tmp106_i_i = tmp103_i_i + tmp105_i_i;
		/*   br label %bb.nph.i.i_5*/
		cur_state = bb_nph_i_i_5;
	end
	bb_nph_i_i_5:
	begin
		/*   %tmp107.i.i = mul i64 %tmp106.i.i, -4294967296  ; <i64> [#uses=1]*/
		tmp107_i_i = tmp106_i_i * -64'd4294967296;
		/*   %tmp111.i.i = shl i64 %tmp106.i.i, 32           ; <i64> [#uses=1]*/
		tmp111_i_i = tmp106_i_i <<< (64'd32 % 64);
		/*   br label %bb.nph.i.i_6*/
		cur_state = bb_nph_i_i_6;
	end
	bb_nph_i_i_6:
	begin
		/*   %tmp108.i.i = add i64 %tmp101.i.i, %tmp107.i.i  ; <i64> [#uses=1]*/
		tmp108_i_i = tmp101_i_i + tmp107_i_i;
		/*   %tmp112.i.i = add i64 %tmp99.i.i, %tmp111.i.i   ; <i64> [#uses=1]*/
		tmp112_i_i = tmp99_i_i + tmp111_i_i;
		/*   br label %bb.nph.i.i_7*/
		cur_state = bb_nph_i_i_7;
	end
	bb_nph_i_i_7:
	begin
		/*   %tmp114.i.i = sub i64 %149, %tmp112.i.i         ; <i64> [#uses=1]*/
		tmp114_i_i = var150 - tmp112_i_i;
		/*   br label %bb25.i.i*/
		indvar_i_i = 64'd0;   /* for PHI node */
		rem1_087_i_i = var204;   /* for PHI node */
		rem0_085_i_i = var207;   /* for PHI node */
		cur_state = bb25_i_i;
	end
	bb25_i_i:
	begin
		/*   %indvar.i.i = phi i64 [ 0, %bb.nph.i.i_7 ], [ %indvar.next.i.i, %bb25.i.i_7 ] ; <i64> [#uses=3]*/

		/*   %rem1.087.i.i = phi i64 [ %203, %bb.nph.i.i_7 ], [ %208, %bb25.i.i_7 ] ; <i64> [#uses=2]*/

		/*   %rem0.085.i.i = phi i64 [ %206, %bb.nph.i.i_7 ], [ %211, %bb25.i.i_7 ] ; <i64> [#uses=1]*/

		/*   br label %bb25.i.i_1*/
		cur_state = bb25_i_i_1;
	end
	bb25_i_i_1:
	begin
		/*   %tmp93.i.i = mul i64 %indvar.i.i, %149          ; <i64> [#uses=2]*/
		tmp93_i_i = indvar_i_i * var150;
		/*   %208 = add i64 %rem1.087.i.i, %149              ; <i64> [#uses=1]*/
		var209 = rem1_087_i_i + var150;
		/*   %indvar.next.i.i = add i64 %indvar.i.i, 1       ; <i64> [#uses=1]*/
		indvar_next_i_i = indvar_i_i + 64'd1;
		/*   br label %bb25.i.i_2*/
		cur_state = bb25_i_i_2;
	end
	bb25_i_i_2:
	begin
		/*   %tmp115.i.i = add i64 %tmp93.i.i, %tmp114.i.i   ; <i64> [#uses=1]*/
		tmp115_i_i = tmp93_i_i + tmp114_i_i;
		/*   br label %bb25.i.i_3*/
		cur_state = bb25_i_i_3;
	end
	bb25_i_i_3:
	begin
		/*   %209 = icmp ult i64 %tmp115.i.i, %rem1.087.i.i  ; <i1> [#uses=1]*/
		var210 = tmp115_i_i < rem1_087_i_i;
		/*   br label %bb25.i.i_4*/
		cur_state = bb25_i_i_4;
	end
	bb25_i_i_4:
	begin
		/*   %210 = zext i1 %209 to i64                      ; <i64> [#uses=1]*/
		var211 = var210;
		/*   br label %bb25.i.i_5*/
		cur_state = bb25_i_i_5;
	end
	bb25_i_i_5:
	begin
		/*   %211 = add i64 %210, %rem0.085.i.i              ; <i64> [#uses=2]*/
		var212 = var211 + rem0_085_i_i;
		/*   br label %bb25.i.i_6*/
		cur_state = bb25_i_i_6;
	end
	bb25_i_i_6:
	begin
		/*   %212 = icmp slt i64 %211, 0                     ; <i1> [#uses=1]*/
		var213 = $signed(var212) < $signed(64'd0);
		/*   br label %bb25.i.i_7*/
		cur_state = bb25_i_i_7;
	end
	bb25_i_i_7:
	begin
		/*   br i1 %212, label %bb25.i.i, label %bb26.bb27_crit_edge.i.i*/
		if (var213) begin
			indvar_i_i = indvar_next_i_i;   /* for PHI node */
			rem1_087_i_i = var209;   /* for PHI node */
			rem0_085_i_i = var212;   /* for PHI node */
			cur_state = bb25_i_i;
		end
		else begin
			cur_state = bb26_bb27_crit_edge_i_i;
		end
	end
	bb26_bb27_crit_edge_i_i:
	begin
		/*   %tmp92.i.i = sub i64 %tmp91.i.i, %indvar.i.i    ; <i64> [#uses=1]*/
		tmp92_i_i = tmp91_i_i - indvar_i_i;
		/*   %tmp109.i.i = add i64 %tmp93.i.i, %tmp108.i.i   ; <i64> [#uses=1]*/
		tmp109_i_i = tmp93_i_i + tmp108_i_i;
		/*   br label %bb27.i.i*/
		zSig_0_lcssa_i_i = tmp92_i_i;   /* for PHI node */
		rem1_0_lcssa_i_i = tmp109_i_i;   /* for PHI node */
		cur_state = bb27_i_i;
	end
	bb27_i_i:
	begin
		/*   %zSig.0.lcssa.i.i = phi i64 [ %tmp92.i.i, %bb26.bb27_crit_edge.i.i ], [ %185, %bb24.i.i_10 ] ; <i64> [#uses=1]*/

		/*   %rem1.0.lcssa.i.i = phi i64 [ %tmp109.i.i, %bb26.bb27_crit_edge.i.i ], [ %203, %bb24.i.i_10 ] ; <i64> [#uses=1]*/

		/*   br label %bb27.i.i_1*/
		cur_state = bb27_i_i_1;
	end
	bb27_i_i_1:
	begin
		/*   %213 = icmp ne i64 %rem1.0.lcssa.i.i, 0         ; <i1> [#uses=1]*/
		var214 = rem1_0_lcssa_i_i != 64'd0;
		/*   br label %bb27.i.i_2*/
		cur_state = bb27_i_i_2;
	end
	bb27_i_i_2:
	begin
		/*   %214 = zext i1 %213 to i64                      ; <i64> [#uses=1]*/
		var215 = var214;
		/*   br label %bb27.i.i_3*/
		cur_state = bb27_i_i_3;
	end
	bb27_i_i_3:
	begin
		/*   %215 = or i64 %214, %zSig.0.lcssa.i.i           ; <i64> [#uses=1]*/
		var216 = var215 | zSig_0_lcssa_i_i;
		/*   br label %bb28.i.i*/
		zSig_1_i_i = var216;   /* for PHI node */
		cur_state = bb28_i_i;
	end
	bb28_i_i:
	begin
		/*   %zSig.1.i.i = phi i64 [ %215, %bb27.i.i_3 ], [ %185, %estimateDiv128To64.exit.i.i_3 ] ; <i64> [#uses=1]*/

		/*   br label %bb28.i.i_1*/
		cur_state = bb28_i_i_1;
	end
	bb28_i_i_1:
	begin
		/*   %216 = tail call fastcc i64 @roundAndPackFloat64(i32 %40, i32 %zExp.0.i.i, i64 %zSig.1.i.i) nounwind ; <i64> [#uses=1]*/
		roundAndPackFloat64_start = 1;
		/* Argument:   %40 = trunc i64 %37 to i32                      ; <i32> [#uses=1]*/
		roundAndPackFloat64_zSign = var40;
		/* Argument:   %zExp.0.i.i = add i32 %150, %zExp.0.v.i.i       ; <i32> [#uses=1]*/
		roundAndPackFloat64_zExp = zExp_0_i_i;
		/* Argument:   %zSig.1.i.i = phi i64 [ %215, %bb27.i.i_3 ], [ %185, %estimateDiv128To64.exit.i.i_3 ] ; <i64> [#uses=1]*/
		roundAndPackFloat64_zSig = zSig_1_i_i;
		cur_state = bb28_i_i_1_call_0;
	end
	bb28_i_i_1_call_0:
	begin
		roundAndPackFloat64_start = 0;
		if (roundAndPackFloat64_finish == 1)
			begin
			var217 = roundAndPackFloat64_return_val;
			cur_state = bb28_i_i_1_call_1;
			end
		else
			cur_state = bb28_i_i_1_call_0;
	end
	bb28_i_i_1_call_1:
	begin
		/*   br label %float64_div.exit.i*/
		var60 = var217;   /* for PHI node */
		cur_state = float64_div_exit_i;
	end
	float64_div_exit_i:
	begin
		/*   %217 = phi i64 [ %216, %bb28.i.i_1 ], [ %131, %bb19.i.i ], [ %113, %bb15.i.i_1 ], [ 9223372036854775807, %bb14.i.i_1 ], [ %iftmp.34.0.i.i.i, %bb3.i.i2.i ], [ %104, %bb10.i.i ], [ %iftmp.34.0.i74.i.i, %bb3.i75.i.i ], [ %84, %bb6.i.i_1 ], [ %iftmp.34.0.i58.i.i, %bb3.i59.i.i ], [ 9223372036854775807, %bb5.i.i_3 ], [ %53, %bb2.i73.i.i_1 ], [ %54, %bb1.i72.i.i_1 ], [ %73, %bb2.i57.i.i_1 ], [ %74, %bb1.i56.i.i_1 ], [ %96, %bb2.i45.i.i_1 ], [ %97, %bb1.i44.i.i_1 ] ; <i64> [#uses=32]*/

		/*   %218 = lshr i64 %app.0.i, 63                    ; <i64> [#uses=1]*/
		var218 = app_0_i >>> (64'd63 % 64);
		/*   %219 = lshr i64 %app.0.i, 52                    ; <i64> [#uses=1]*/
		var219 = app_0_i >>> (64'd52 % 64);
		/*   br label %float64_div.exit.i_1*/
		cur_state = float64_div_exit_i_1;
	end
	float64_div_exit_i_1:
	begin
		/*   %220 = trunc i64 %218 to i32                    ; <i32> [#uses=5]*/
		var220 = var218[31:0];
		/*   %221 = lshr i64 %217, 63                        ; <i64> [#uses=1]*/
		var221 = var60 >>> (64'd63 % 64);
		/*   %222 = trunc i64 %219 to i32                    ; <i32> [#uses=1]*/
		var222 = var219[31:0];
		/*   %223 = lshr i64 %217, 52                        ; <i64> [#uses=1]*/
		var223 = var60 >>> (64'd52 % 64);
		/*   br label %float64_div.exit.i_2*/
		cur_state = float64_div_exit_i_2;
	end
	float64_div_exit_i_2:
	begin
		/*   %224 = trunc i64 %221 to i32                    ; <i32> [#uses=1]*/
		var224 = var221[31:0];
		/*   %225 = and i32 %222, 2047                       ; <i32> [#uses=14]*/
		var225 = var222 & 32'd2047;
		/*   %226 = trunc i64 %223 to i32                    ; <i32> [#uses=1]*/
		var226 = var223[31:0];
		/*   br label %float64_div.exit.i_3*/
		cur_state = float64_div_exit_i_3;
	end
	float64_div_exit_i_3:
	begin
		/*   %227 = icmp eq i32 %220, %224                   ; <i1> [#uses=1]*/
		var227 = var220 == var224;
		/*   %228 = and i32 %226, 2047                       ; <i32> [#uses=10]*/
		var228 = var226 & 32'd2047;
		/*   br label %float64_div.exit.i_4*/
		cur_state = float64_div_exit_i_4;
	end
	float64_div_exit_i_4:
	begin
		/*   %229 = sub i32 %225, %228                       ; <i32> [#uses=10]*/
		var229 = var225 - var228;
		/*   br i1 %227, label %bb.i5.i, label %bb1.i6.i*/
		if (var227) begin
			cur_state = bb_i5_i;
		end
		else begin
			cur_state = bb1_i6_i;
		end
	end
	bb_i5_i:
	begin
		/*   %230 = shl i64 %app.0.i, 9                      ; <i64> [#uses=1]*/
		var230 = app_0_i <<< (64'd9 % 64);
		/*   %231 = shl i64 %217, 9                          ; <i64> [#uses=1]*/
		var231 = var60 <<< (64'd9 % 64);
		/*   %232 = icmp sgt i32 %229, 0                     ; <i1> [#uses=1]*/
		var232 = $signed(var229) > $signed(32'd0);
		/*   br label %bb.i5.i_1*/
		cur_state = bb_i5_i_1;
	end
	bb_i5_i_1:
	begin
		/*   %233 = and i64 %230, 2305843009213693440        ; <i64> [#uses=8]*/
		var233 = var230 & 64'd2305843009213693440;
		/*   %234 = and i64 %231, 2305843009213693440        ; <i64> [#uses=8]*/
		var234 = var231 & 64'd2305843009213693440;
		/*   br i1 %232, label %bb.i4.i.i, label %bb8.i25.i.i*/
		if (var232) begin
			cur_state = bb_i4_i_i;
		end
		else begin
			cur_state = bb8_i25_i_i;
		end
	end
	bb_i4_i_i:
	begin
		/*   %235 = icmp eq i32 %225, 2047                   ; <i1> [#uses=1]*/
		var235 = var225 == 32'd2047;
		/*   br label %bb.i4.i.i_1*/
		cur_state = bb_i4_i_i_1;
	end
	bb_i4_i_i_1:
	begin
		/*   br i1 %235, label %bb1.i5.i.i, label %bb4.i23.i.i*/
		if (var235) begin
			cur_state = bb1_i5_i_i;
		end
		else begin
			cur_state = bb4_i23_i_i;
		end
	end
	bb1_i5_i_i:
	begin
		/*   %236 = icmp eq i64 %233, 0                      ; <i1> [#uses=1]*/
		var236 = var233 == 64'd0;
		/*   br label %bb1.i5.i.i_1*/
		cur_state = bb1_i5_i_i_1;
	end
	bb1_i5_i_i_1:
	begin
		/*   br i1 %236, label %float64_add.exit.i, label %bb2.i6.i.i*/
		if (var236) begin
			var237 = app_0_i;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
		else begin
			cur_state = bb2_i6_i_i;
		end
	end
	bb2_i6_i_i:
	begin
		/*   %237 = and i64 %app.0.i, 9221120237041090560    ; <i64> [#uses=1]*/
		var238 = app_0_i & 64'd9221120237041090560;
		/*   br label %bb2.i6.i.i_1*/
		cur_state = bb2_i6_i_i_1;
	end
	bb2_i6_i_i_1:
	begin
		/*   %238 = icmp eq i64 %237, 9218868437227405312    ; <i1> [#uses=1]*/
		var239 = var238 == 64'd9218868437227405312;
		/*   br label %bb2.i6.i.i_2*/
		cur_state = bb2_i6_i_i_2;
	end
	bb2_i6_i_i_2:
	begin
		/*   br i1 %238, label %bb.i14.i55.i9.i.i, label %float64_is_signaling_nan.exit16.i56.i10.i.i*/
		if (var239) begin
			cur_state = bb_i14_i55_i9_i_i;
		end
		else begin
			var240 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit16_i56_i10_i_i;
		end
	end
	bb_i14_i55_i9_i_i:
	begin
		/*   %239 = and i64 %app.0.i, 2251799813685247       ; <i64> [#uses=1]*/
		var241 = app_0_i & 64'd2251799813685247;
		/*   br label %bb.i14.i55.i9.i.i_1*/
		cur_state = bb_i14_i55_i9_i_i_1;
	end
	bb_i14_i55_i9_i_i_1:
	begin
		/*   %not..i12.i53.i7.i.i = icmp ne i64 %239, 0      ; <i1> [#uses=1]*/
		not__i12_i53_i7_i_i = var241 != 64'd0;
		/*   br label %bb.i14.i55.i9.i.i_2*/
		cur_state = bb_i14_i55_i9_i_i_2;
	end
	bb_i14_i55_i9_i_i_2:
	begin
		/*   %retval.i13.i54.i8.i.i = zext i1 %not..i12.i53.i7.i.i to i32 ; <i32> [#uses=1]*/
		retval_i13_i54_i8_i_i = not__i12_i53_i7_i_i;
		/*   br label %float64_is_signaling_nan.exit16.i56.i10.i.i*/
		var240 = retval_i13_i54_i8_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit16_i56_i10_i_i;
	end
	float64_is_signaling_nan_exit16_i56_i10_i_i:
	begin
		/*   %240 = phi i32 [ %retval.i13.i54.i8.i.i, %bb.i14.i55.i9.i.i_2 ], [ 0, %bb2.i6.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %241 = shl i64 %217, 1                          ; <i64> [#uses=1]*/
		var242 = var60 <<< (64'd1 % 64);
		/*   %242 = and i64 %217, 9221120237041090560        ; <i64> [#uses=1]*/
		var243 = var60 & 64'd9221120237041090560;
		/*   br label %float64_is_signaling_nan.exit16.i56.i10.i.i_1*/
		cur_state = float64_is_signaling_nan_exit16_i56_i10_i_i_1;
	end
	float64_is_signaling_nan_exit16_i56_i10_i_i_1:
	begin
		/*   %243 = icmp ugt i64 %241, -9007199254740992     ; <i1> [#uses=1]*/
		var244 = var242 > -64'd9007199254740992;
		/*   %244 = icmp eq i64 %242, 9218868437227405312    ; <i1> [#uses=1]*/
		var245 = var243 == 64'd9218868437227405312;
		/*   br label %float64_is_signaling_nan.exit16.i56.i10.i.i_2*/
		cur_state = float64_is_signaling_nan_exit16_i56_i10_i_i_2;
	end
	float64_is_signaling_nan_exit16_i56_i10_i_i_2:
	begin
		/*   br i1 %244, label %bb.i.i59.i13.i.i, label %float64_is_signaling_nan.exit.i60.i14.i.i*/
		if (var245) begin
			cur_state = bb_i_i59_i13_i_i;
		end
		else begin
			var246 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit_i60_i14_i_i;
		end
	end
	bb_i_i59_i13_i_i:
	begin
		/*   %245 = and i64 %217, 2251799813685247           ; <i64> [#uses=1]*/
		var247 = var60 & 64'd2251799813685247;
		/*   br label %bb.i.i59.i13.i.i_1*/
		cur_state = bb_i_i59_i13_i_i_1;
	end
	bb_i_i59_i13_i_i_1:
	begin
		/*   %not..i.i57.i11.i.i = icmp ne i64 %245, 0       ; <i1> [#uses=1]*/
		not__i_i57_i11_i_i = var247 != 64'd0;
		/*   br label %bb.i.i59.i13.i.i_2*/
		cur_state = bb_i_i59_i13_i_i_2;
	end
	bb_i_i59_i13_i_i_2:
	begin
		/*   %retval.i.i58.i12.i.i = zext i1 %not..i.i57.i11.i.i to i32 ; <i32> [#uses=1]*/
		retval_i_i58_i12_i_i = not__i_i57_i11_i_i;
		/*   br label %float64_is_signaling_nan.exit.i60.i14.i.i*/
		var246 = retval_i_i58_i12_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit_i60_i14_i_i;
	end
	float64_is_signaling_nan_exit_i60_i14_i_i:
	begin
		/*   %246 = phi i32 [ %retval.i.i58.i12.i.i, %bb.i.i59.i13.i.i_2 ], [ 0, %float64_is_signaling_nan.exit16.i56.i10.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %247 = or i64 %app.0.i, 2251799813685248        ; <i64> [#uses=2]*/
		var248 = app_0_i | 64'd2251799813685248;
		/*   %248 = or i64 %217, 2251799813685248            ; <i64> [#uses=2]*/
		var249 = var60 | 64'd2251799813685248;
		/*   br label %float64_is_signaling_nan.exit.i60.i14.i.i_1*/
		cur_state = float64_is_signaling_nan_exit_i60_i14_i_i_1;
	end
	float64_is_signaling_nan_exit_i60_i14_i_i_1:
	begin
		/*   %249 = or i32 %246, %240                        ; <i32> [#uses=1]*/
		var250 = var246 | var240;
		/*   br label %float64_is_signaling_nan.exit.i60.i14.i.i_2*/
		cur_state = float64_is_signaling_nan_exit_i60_i14_i_i_2;
	end
	float64_is_signaling_nan_exit_i60_i14_i_i_2:
	begin
		/*   %250 = icmp eq i32 %249, 0                      ; <i1> [#uses=1]*/
		var251 = var250 == 32'd0;
		/*   br label %float64_is_signaling_nan.exit.i60.i14.i.i_3*/
		cur_state = float64_is_signaling_nan_exit_i60_i14_i_i_3;
	end
	float64_is_signaling_nan_exit_i60_i14_i_i_3:
	begin
		/*   br i1 %250, label %bb1.i62.i16.i.i, label %bb.i61.i15.i.i*/
		if (var251) begin
			cur_state = bb1_i62_i16_i_i;
		end
		else begin
			cur_state = bb_i61_i15_i_i;
		end
	end
	bb_i61_i15_i_i:
	begin
		/*   %251 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb.i61.i15.i.i_1*/
		cur_state = bb_i61_i15_i_i_1;
	end
	bb_i61_i15_i_i_1:
	begin
		var252 = memory_controller_out[31:0];
		/*   %load_noop9 = add i32 %251, 0                   ; <i32> [#uses=1]*/
		load_noop9 = var252 + 32'd0;
		/*   br label %bb.i61.i15.i.i_2*/
		cur_state = bb_i61_i15_i_i_2;
	end
	bb_i61_i15_i_i_2:
	begin
		/*   %252 = or i32 %load_noop9, 16                   ; <i32> [#uses=1]*/
		var253 = load_noop9 | 32'd16;
		/*   br label %bb.i61.i15.i.i_3*/
		cur_state = bb_i61_i15_i_i_3;
	end
	bb_i61_i15_i_i_3:
	begin
		/*   store i32 %252, i32* @float_exception_flags, align 4*/
		/*   br label %bb1.i62.i16.i.i*/
		cur_state = bb1_i62_i16_i_i;
	end
	bb1_i62_i16_i_i:
	begin
		/*   %253 = icmp eq i32 %246, 0                      ; <i1> [#uses=1]*/
		var254 = var246 == 32'd0;
		/*   br label %bb1.i62.i16.i.i_1*/
		cur_state = bb1_i62_i16_i_i_1;
	end
	bb1_i62_i16_i_i_1:
	begin
		/*   br i1 %253, label %bb2.i63.i17.i.i, label %float64_add.exit.i*/
		if (var254) begin
			cur_state = bb2_i63_i17_i_i;
		end
		else begin
			var237 = var249;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb2_i63_i17_i_i:
	begin
		/*   %254 = icmp eq i32 %240, 0                      ; <i1> [#uses=1]*/
		var255 = var240 == 32'd0;
		/*   br label %bb2.i63.i17.i.i_1*/
		cur_state = bb2_i63_i17_i_i_1;
	end
	bb2_i63_i17_i_i_1:
	begin
		/*   br i1 %254, label %bb3.i65.i19.i.i, label %float64_add.exit.i*/
		if (var255) begin
			cur_state = bb3_i65_i19_i_i;
		end
		else begin
			var237 = var248;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb3_i65_i19_i_i:
	begin
		/*   %iftmp.34.0.i64.i18.i.i = select i1 %243, i64 %248, i64 %247 ; <i64> [#uses=1]*/
		iftmp_34_0_i64_i18_i_i = (var244) ? var249 : var248;
		/*   br label %float64_add.exit.i*/
		var237 = iftmp_34_0_i64_i18_i_i;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	bb4_i23_i_i:
	begin
		/*   %255 = icmp eq i32 %228, 0                      ; <i1> [#uses=2]*/
		var256 = var228 == 32'd0;
		/*   %256 = add i32 %229, -1                         ; <i32> [#uses=1]*/
		var257 = var229 + -32'd1;
		/*   %257 = or i64 %234, 2305843009213693952         ; <i64> [#uses=1]*/
		var258 = var234 | 64'd2305843009213693952;
		/*   br label %bb4.i23.i.i_1*/
		cur_state = bb4_i23_i_i_1;
	end
	bb4_i23_i_i_1:
	begin
		/*   %bSig.0.i21.i.i = select i1 %255, i64 %234, i64 %257 ; <i64> [#uses=4]*/
		bSig_0_i21_i_i = (var256) ? var234 : var258;
		/*   %expDiff.0.i22.i.i = select i1 %255, i32 %256, i32 %229 ; <i32> [#uses=4]*/
		expDiff_0_i22_i_i = (var256) ? var257 : var229;
		/*   br label %bb4.i23.i.i_2*/
		cur_state = bb4_i23_i_i_2;
	end
	bb4_i23_i_i_2:
	begin
		/*   %258 = icmp eq i32 %expDiff.0.i22.i.i, 0        ; <i1> [#uses=1]*/
		var259 = expDiff_0_i22_i_i == 32'd0;
		/*   br label %bb4.i23.i.i_3*/
		cur_state = bb4_i23_i_i_3;
	end
	bb4_i23_i_i_3:
	begin
		/*   br i1 %258, label %bb24.i57.i.i, label %bb1.i46.i24.i.i*/
		if (var259) begin
			aSig_1_i54_i_i = var233;   /* for PHI node */
			bSig_1_i55_i_i = bSig_0_i21_i_i;   /* for PHI node */
			zExp_0_i56_i_i = var225;   /* for PHI node */
			cur_state = bb24_i57_i_i;
		end
		else begin
			cur_state = bb1_i46_i24_i_i;
		end
	end
	bb1_i46_i24_i_i:
	begin
		/*   %259 = icmp slt i32 %expDiff.0.i22.i.i, 64      ; <i1> [#uses=1]*/
		var260 = $signed(expDiff_0_i22_i_i) < $signed(32'd64);
		/*   br label %bb1.i46.i24.i.i_1*/
		cur_state = bb1_i46_i24_i_i_1;
	end
	bb1_i46_i24_i_i_1:
	begin
		/*   br i1 %259, label %bb2.i49.i.i.i, label %bb4.i50.i.i.i*/
		if (var260) begin
			cur_state = bb2_i49_i_i_i;
		end
		else begin
			cur_state = bb4_i50_i_i_i;
		end
	end
	bb2_i49_i_i_i:
	begin
		/*   %.cast.i47.i.i.i = zext i32 %expDiff.0.i22.i.i to i64 ; <i64> [#uses=1]*/
		_cast_i47_i_i_i = expDiff_0_i22_i_i;
		/*   %260 = sub i32 0, %expDiff.0.i22.i.i            ; <i32> [#uses=1]*/
		var261 = 32'd0 - expDiff_0_i22_i_i;
		/*   br label %bb2.i49.i.i.i_1*/
		cur_state = bb2_i49_i_i_i_1;
	end
	bb2_i49_i_i_i_1:
	begin
		/*   %261 = lshr i64 %bSig.0.i21.i.i, %.cast.i47.i.i.i ; <i64> [#uses=1]*/
		var262 = bSig_0_i21_i_i >>> (_cast_i47_i_i_i % 64);
		/*   %262 = and i32 %260, 63                         ; <i32> [#uses=1]*/
		var263 = var261 & 32'd63;
		/*   br label %bb2.i49.i.i.i_2*/
		cur_state = bb2_i49_i_i_i_2;
	end
	bb2_i49_i_i_i_2:
	begin
		/*   %.cast3.i48.i.i.i = zext i32 %262 to i64        ; <i64> [#uses=1]*/
		_cast3_i48_i_i_i = var263;
		/*   br label %bb2.i49.i.i.i_3*/
		cur_state = bb2_i49_i_i_i_3;
	end
	bb2_i49_i_i_i_3:
	begin
		/*   %263 = shl i64 %bSig.0.i21.i.i, %.cast3.i48.i.i.i ; <i64> [#uses=1]*/
		var264 = bSig_0_i21_i_i <<< (_cast3_i48_i_i_i % 64);
		/*   br label %bb2.i49.i.i.i_4*/
		cur_state = bb2_i49_i_i_i_4;
	end
	bb2_i49_i_i_i_4:
	begin
		/*   %264 = icmp ne i64 %263, 0                      ; <i1> [#uses=1]*/
		var265 = var264 != 64'd0;
		/*   br label %bb2.i49.i.i.i_5*/
		cur_state = bb2_i49_i_i_i_5;
	end
	bb2_i49_i_i_i_5:
	begin
		/*   %265 = zext i1 %264 to i64                      ; <i64> [#uses=1]*/
		var266 = var265;
		/*   br label %bb2.i49.i.i.i_6*/
		cur_state = bb2_i49_i_i_i_6;
	end
	bb2_i49_i_i_i_6:
	begin
		/*   %266 = or i64 %265, %261                        ; <i64> [#uses=1]*/
		var267 = var266 | var262;
		/*   br label %bb24.i57.i.i*/
		aSig_1_i54_i_i = var233;   /* for PHI node */
		bSig_1_i55_i_i = var267;   /* for PHI node */
		zExp_0_i56_i_i = var225;   /* for PHI node */
		cur_state = bb24_i57_i_i;
	end
	bb4_i50_i_i_i:
	begin
		/*   %267 = icmp ne i64 %bSig.0.i21.i.i, 0           ; <i1> [#uses=1]*/
		var268 = bSig_0_i21_i_i != 64'd0;
		/*   br label %bb4.i50.i.i.i_1*/
		cur_state = bb4_i50_i_i_i_1;
	end
	bb4_i50_i_i_i_1:
	begin
		/*   %268 = zext i1 %267 to i64                      ; <i64> [#uses=1]*/
		var269 = var268;
		/*   br label %bb24.i57.i.i*/
		aSig_1_i54_i_i = var233;   /* for PHI node */
		bSig_1_i55_i_i = var269;   /* for PHI node */
		zExp_0_i56_i_i = var225;   /* for PHI node */
		cur_state = bb24_i57_i_i;
	end
	bb8_i25_i_i:
	begin
		/*   %269 = icmp slt i32 %229, 0                     ; <i1> [#uses=1]*/
		var270 = $signed(var229) < $signed(32'd0);
		/*   br label %bb8.i25.i.i_1*/
		cur_state = bb8_i25_i_i_1;
	end
	bb8_i25_i_i_1:
	begin
		/*   br i1 %269, label %bb9.i26.i.i, label %bb17.i38.i.i*/
		if (var270) begin
			cur_state = bb9_i26_i_i;
		end
		else begin
			cur_state = bb17_i38_i_i;
		end
	end
	bb9_i26_i_i:
	begin
		/*   %270 = icmp eq i32 %228, 2047                   ; <i1> [#uses=1]*/
		var271 = var228 == 32'd2047;
		/*   br label %bb9.i26.i.i_1*/
		cur_state = bb9_i26_i_i_1;
	end
	bb9_i26_i_i_1:
	begin
		/*   br i1 %270, label %bb10.i27.i.i, label %bb13.i32.i.i*/
		if (var271) begin
			cur_state = bb10_i27_i_i;
		end
		else begin
			cur_state = bb13_i32_i_i;
		end
	end
	bb10_i27_i_i:
	begin
		/*   %271 = icmp eq i64 %234, 0                      ; <i1> [#uses=1]*/
		var272 = var234 == 64'd0;
		/*   br label %bb10.i27.i.i_1*/
		cur_state = bb10_i27_i_i_1;
	end
	bb10_i27_i_i_1:
	begin
		/*   br i1 %271, label %bb12.i29.i.i, label %bb11.i28.i.i*/
		if (var272) begin
			cur_state = bb12_i29_i_i;
		end
		else begin
			cur_state = bb11_i28_i_i;
		end
	end
	bb11_i28_i_i:
	begin
		/*   %272 = and i64 %app.0.i, 9221120237041090560    ; <i64> [#uses=1]*/
		var273 = app_0_i & 64'd9221120237041090560;
		/*   br label %bb11.i28.i.i_1*/
		cur_state = bb11_i28_i_i_1;
	end
	bb11_i28_i_i_1:
	begin
		/*   %273 = icmp eq i64 %272, 9218868437227405312    ; <i1> [#uses=1]*/
		var274 = var273 == 64'd9218868437227405312;
		/*   br label %bb11.i28.i.i_2*/
		cur_state = bb11_i28_i_i_2;
	end
	bb11_i28_i_i_2:
	begin
		/*   br i1 %273, label %bb.i14.i32.i.i.i, label %float64_is_signaling_nan.exit16.i33.i.i.i*/
		if (var274) begin
			cur_state = bb_i14_i32_i_i_i;
		end
		else begin
			var275 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit16_i33_i_i_i;
		end
	end
	bb_i14_i32_i_i_i:
	begin
		/*   %274 = and i64 %app.0.i, 2251799813685247       ; <i64> [#uses=1]*/
		var276 = app_0_i & 64'd2251799813685247;
		/*   br label %bb.i14.i32.i.i.i_1*/
		cur_state = bb_i14_i32_i_i_i_1;
	end
	bb_i14_i32_i_i_i_1:
	begin
		/*   %not..i12.i30.i.i.i = icmp ne i64 %274, 0       ; <i1> [#uses=1]*/
		not__i12_i30_i_i_i = var276 != 64'd0;
		/*   br label %bb.i14.i32.i.i.i_2*/
		cur_state = bb_i14_i32_i_i_i_2;
	end
	bb_i14_i32_i_i_i_2:
	begin
		/*   %retval.i13.i31.i.i.i = zext i1 %not..i12.i30.i.i.i to i32 ; <i32> [#uses=1]*/
		retval_i13_i31_i_i_i = not__i12_i30_i_i_i;
		/*   br label %float64_is_signaling_nan.exit16.i33.i.i.i*/
		var275 = retval_i13_i31_i_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit16_i33_i_i_i;
	end
	float64_is_signaling_nan_exit16_i33_i_i_i:
	begin
		/*   %275 = phi i32 [ %retval.i13.i31.i.i.i, %bb.i14.i32.i.i.i_2 ], [ 0, %bb11.i28.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %276 = shl i64 %217, 1                          ; <i64> [#uses=1]*/
		var277 = var60 <<< (64'd1 % 64);
		/*   %277 = and i64 %217, 9221120237041090560        ; <i64> [#uses=1]*/
		var278 = var60 & 64'd9221120237041090560;
		/*   br label %float64_is_signaling_nan.exit16.i33.i.i.i_1*/
		cur_state = float64_is_signaling_nan_exit16_i33_i_i_i_1;
	end
	float64_is_signaling_nan_exit16_i33_i_i_i_1:
	begin
		/*   %278 = icmp ugt i64 %276, -9007199254740992     ; <i1> [#uses=1]*/
		var279 = var277 > -64'd9007199254740992;
		/*   %279 = icmp eq i64 %277, 9218868437227405312    ; <i1> [#uses=1]*/
		var280 = var278 == 64'd9218868437227405312;
		/*   br label %float64_is_signaling_nan.exit16.i33.i.i.i_2*/
		cur_state = float64_is_signaling_nan_exit16_i33_i_i_i_2;
	end
	float64_is_signaling_nan_exit16_i33_i_i_i_2:
	begin
		/*   br i1 %279, label %bb.i.i36.i.i.i, label %float64_is_signaling_nan.exit.i37.i.i.i*/
		if (var280) begin
			cur_state = bb_i_i36_i_i_i;
		end
		else begin
			var281 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit_i37_i_i_i;
		end
	end
	bb_i_i36_i_i_i:
	begin
		/*   %280 = and i64 %217, 2251799813685247           ; <i64> [#uses=1]*/
		var282 = var60 & 64'd2251799813685247;
		/*   br label %bb.i.i36.i.i.i_1*/
		cur_state = bb_i_i36_i_i_i_1;
	end
	bb_i_i36_i_i_i_1:
	begin
		/*   %not..i.i34.i.i.i = icmp ne i64 %280, 0         ; <i1> [#uses=1]*/
		not__i_i34_i_i_i = var282 != 64'd0;
		/*   br label %bb.i.i36.i.i.i_2*/
		cur_state = bb_i_i36_i_i_i_2;
	end
	bb_i_i36_i_i_i_2:
	begin
		/*   %retval.i.i35.i.i.i = zext i1 %not..i.i34.i.i.i to i32 ; <i32> [#uses=1]*/
		retval_i_i35_i_i_i = not__i_i34_i_i_i;
		/*   br label %float64_is_signaling_nan.exit.i37.i.i.i*/
		var281 = retval_i_i35_i_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit_i37_i_i_i;
	end
	float64_is_signaling_nan_exit_i37_i_i_i:
	begin
		/*   %281 = phi i32 [ %retval.i.i35.i.i.i, %bb.i.i36.i.i.i_2 ], [ 0, %float64_is_signaling_nan.exit16.i33.i.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %282 = or i64 %app.0.i, 2251799813685248        ; <i64> [#uses=2]*/
		var283 = app_0_i | 64'd2251799813685248;
		/*   %283 = or i64 %217, 2251799813685248            ; <i64> [#uses=2]*/
		var284 = var60 | 64'd2251799813685248;
		/*   br label %float64_is_signaling_nan.exit.i37.i.i.i_1*/
		cur_state = float64_is_signaling_nan_exit_i37_i_i_i_1;
	end
	float64_is_signaling_nan_exit_i37_i_i_i_1:
	begin
		/*   %284 = or i32 %281, %275                        ; <i32> [#uses=1]*/
		var285 = var281 | var275;
		/*   br label %float64_is_signaling_nan.exit.i37.i.i.i_2*/
		cur_state = float64_is_signaling_nan_exit_i37_i_i_i_2;
	end
	float64_is_signaling_nan_exit_i37_i_i_i_2:
	begin
		/*   %285 = icmp eq i32 %284, 0                      ; <i1> [#uses=1]*/
		var286 = var285 == 32'd0;
		/*   br label %float64_is_signaling_nan.exit.i37.i.i.i_3*/
		cur_state = float64_is_signaling_nan_exit_i37_i_i_i_3;
	end
	float64_is_signaling_nan_exit_i37_i_i_i_3:
	begin
		/*   br i1 %285, label %bb1.i39.i.i.i, label %bb.i38.i.i.i*/
		if (var286) begin
			cur_state = bb1_i39_i_i_i;
		end
		else begin
			cur_state = bb_i38_i_i_i;
		end
	end
	bb_i38_i_i_i:
	begin
		/*   %286 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb.i38.i.i.i_1*/
		cur_state = bb_i38_i_i_i_1;
	end
	bb_i38_i_i_i_1:
	begin
		var287 = memory_controller_out[31:0];
		/*   %load_noop10 = add i32 %286, 0                  ; <i32> [#uses=1]*/
		load_noop10 = var287 + 32'd0;
		/*   br label %bb.i38.i.i.i_2*/
		cur_state = bb_i38_i_i_i_2;
	end
	bb_i38_i_i_i_2:
	begin
		/*   %287 = or i32 %load_noop10, 16                  ; <i32> [#uses=1]*/
		var288 = load_noop10 | 32'd16;
		/*   br label %bb.i38.i.i.i_3*/
		cur_state = bb_i38_i_i_i_3;
	end
	bb_i38_i_i_i_3:
	begin
		/*   store i32 %287, i32* @float_exception_flags, align 4*/
		/*   br label %bb1.i39.i.i.i*/
		cur_state = bb1_i39_i_i_i;
	end
	bb1_i39_i_i_i:
	begin
		/*   %288 = icmp eq i32 %281, 0                      ; <i1> [#uses=1]*/
		var289 = var281 == 32'd0;
		/*   br label %bb1.i39.i.i.i_1*/
		cur_state = bb1_i39_i_i_i_1;
	end
	bb1_i39_i_i_i_1:
	begin
		/*   br i1 %288, label %bb2.i40.i.i.i, label %float64_add.exit.i*/
		if (var289) begin
			cur_state = bb2_i40_i_i_i;
		end
		else begin
			var237 = var284;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb2_i40_i_i_i:
	begin
		/*   %289 = icmp eq i32 %275, 0                      ; <i1> [#uses=1]*/
		var290 = var275 == 32'd0;
		/*   br label %bb2.i40.i.i.i_1*/
		cur_state = bb2_i40_i_i_i_1;
	end
	bb2_i40_i_i_i_1:
	begin
		/*   br i1 %289, label %bb3.i42.i.i.i, label %float64_add.exit.i*/
		if (var290) begin
			cur_state = bb3_i42_i_i_i;
		end
		else begin
			var237 = var283;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb3_i42_i_i_i:
	begin
		/*   %iftmp.34.0.i41.i.i.i = select i1 %278, i64 %283, i64 %282 ; <i64> [#uses=1]*/
		iftmp_34_0_i41_i_i_i = (var279) ? var284 : var283;
		/*   br label %float64_add.exit.i*/
		var237 = iftmp_34_0_i41_i_i_i;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	bb12_i29_i_i:
	begin
		/*   %290 = or i64 %app.0.i, 9218868437227405312     ; <i64> [#uses=1]*/
		var291 = app_0_i | 64'd9218868437227405312;
		/*   br label %bb12.i29.i.i_1*/
		cur_state = bb12_i29_i_i_1;
	end
	bb12_i29_i_i_1:
	begin
		/*   %291 = and i64 %290, -4503599627370496          ; <i64> [#uses=1]*/
		var292 = var291 & -64'd4503599627370496;
		/*   br label %float64_add.exit.i*/
		var237 = var292;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	bb13_i32_i_i:
	begin
		/*   %292 = icmp eq i32 %225, 0                      ; <i1> [#uses=2]*/
		var293 = var225 == 32'd0;
		/*   %293 = or i64 %233, 2305843009213693952         ; <i64> [#uses=1]*/
		var294 = var233 | 64'd2305843009213693952;
		/*   br label %bb13.i32.i.i_1*/
		cur_state = bb13_i32_i_i_1;
	end
	bb13_i32_i_i_1:
	begin
		/*   %aSig.0.i30.i.i = select i1 %292, i64 %233, i64 %293 ; <i64> [#uses=4]*/
		aSig_0_i30_i_i = (var293) ? var233 : var294;
		/*   %294 = zext i1 %292 to i32                      ; <i32> [#uses=1]*/
		var295 = var293;
		/*   br label %bb13.i32.i.i_2*/
		cur_state = bb13_i32_i_i_2;
	end
	bb13_i32_i_i_2:
	begin
		/*   %expDiff.1.i31.i.i = add i32 %229, %294         ; <i32> [#uses=3]*/
		expDiff_1_i31_i_i = var229 + var295;
		/*   br label %bb13.i32.i.i_3*/
		cur_state = bb13_i32_i_i_3;
	end
	bb13_i32_i_i_3:
	begin
		/*   %295 = sub i32 0, %expDiff.1.i31.i.i            ; <i32> [#uses=2]*/
		var296 = 32'd0 - expDiff_1_i31_i_i;
		/*   %296 = icmp eq i32 %expDiff.1.i31.i.i, 0        ; <i1> [#uses=1]*/
		var297 = expDiff_1_i31_i_i == 32'd0;
		/*   br label %bb13.i32.i.i_4*/
		cur_state = bb13_i32_i_i_4;
	end
	bb13_i32_i_i_4:
	begin
		/*   br i1 %296, label %bb24.i57.i.i, label %bb1.i28.i33.i.i*/
		if (var297) begin
			aSig_1_i54_i_i = aSig_0_i30_i_i;   /* for PHI node */
			bSig_1_i55_i_i = var234;   /* for PHI node */
			zExp_0_i56_i_i = var228;   /* for PHI node */
			cur_state = bb24_i57_i_i;
		end
		else begin
			cur_state = bb1_i28_i33_i_i;
		end
	end
	bb1_i28_i33_i_i:
	begin
		/*   %297 = icmp slt i32 %295, 64                    ; <i1> [#uses=1]*/
		var298 = $signed(var296) < $signed(32'd64);
		/*   br label %bb1.i28.i33.i.i_1*/
		cur_state = bb1_i28_i33_i_i_1;
	end
	bb1_i28_i33_i_i_1:
	begin
		/*   br i1 %297, label %bb2.i29.i36.i.i, label %bb4.i.i37.i.i*/
		if (var298) begin
			cur_state = bb2_i29_i36_i_i;
		end
		else begin
			cur_state = bb4_i_i37_i_i;
		end
	end
	bb2_i29_i36_i_i:
	begin
		/*   %.cast.i.i34.i.i = zext i32 %295 to i64         ; <i64> [#uses=1]*/
		_cast_i_i34_i_i = var296;
		/*   %298 = and i32 %expDiff.1.i31.i.i, 63           ; <i32> [#uses=1]*/
		var299 = expDiff_1_i31_i_i & 32'd63;
		/*   br label %bb2.i29.i36.i.i_1*/
		cur_state = bb2_i29_i36_i_i_1;
	end
	bb2_i29_i36_i_i_1:
	begin
		/*   %299 = lshr i64 %aSig.0.i30.i.i, %.cast.i.i34.i.i ; <i64> [#uses=1]*/
		var300 = aSig_0_i30_i_i >>> (_cast_i_i34_i_i % 64);
		/*   %.cast3.i.i35.i.i = zext i32 %298 to i64        ; <i64> [#uses=1]*/
		_cast3_i_i35_i_i = var299;
		/*   br label %bb2.i29.i36.i.i_2*/
		cur_state = bb2_i29_i36_i_i_2;
	end
	bb2_i29_i36_i_i_2:
	begin
		/*   %300 = shl i64 %aSig.0.i30.i.i, %.cast3.i.i35.i.i ; <i64> [#uses=1]*/
		var301 = aSig_0_i30_i_i <<< (_cast3_i_i35_i_i % 64);
		/*   br label %bb2.i29.i36.i.i_3*/
		cur_state = bb2_i29_i36_i_i_3;
	end
	bb2_i29_i36_i_i_3:
	begin
		/*   %301 = icmp ne i64 %300, 0                      ; <i1> [#uses=1]*/
		var302 = var301 != 64'd0;
		/*   br label %bb2.i29.i36.i.i_4*/
		cur_state = bb2_i29_i36_i_i_4;
	end
	bb2_i29_i36_i_i_4:
	begin
		/*   %302 = zext i1 %301 to i64                      ; <i64> [#uses=1]*/
		var303 = var302;
		/*   br label %bb2.i29.i36.i.i_5*/
		cur_state = bb2_i29_i36_i_i_5;
	end
	bb2_i29_i36_i_i_5:
	begin
		/*   %303 = or i64 %302, %299                        ; <i64> [#uses=1]*/
		var304 = var303 | var300;
		/*   br label %bb24.i57.i.i*/
		aSig_1_i54_i_i = var304;   /* for PHI node */
		bSig_1_i55_i_i = var234;   /* for PHI node */
		zExp_0_i56_i_i = var228;   /* for PHI node */
		cur_state = bb24_i57_i_i;
	end
	bb4_i_i37_i_i:
	begin
		/*   %304 = icmp ne i64 %aSig.0.i30.i.i, 0           ; <i1> [#uses=1]*/
		var305 = aSig_0_i30_i_i != 64'd0;
		/*   br label %bb4.i.i37.i.i_1*/
		cur_state = bb4_i_i37_i_i_1;
	end
	bb4_i_i37_i_i_1:
	begin
		/*   %305 = zext i1 %304 to i64                      ; <i64> [#uses=1]*/
		var306 = var305;
		/*   br label %bb24.i57.i.i*/
		aSig_1_i54_i_i = var306;   /* for PHI node */
		bSig_1_i55_i_i = var234;   /* for PHI node */
		zExp_0_i56_i_i = var228;   /* for PHI node */
		cur_state = bb24_i57_i_i;
	end
	bb17_i38_i_i:
	begin
		/*   %306 = icmp eq i32 %225, 2047                   ; <i1> [#uses=1]*/
		var307 = var225 == 32'd2047;
		/*   br label %bb17.i38.i.i_1*/
		cur_state = bb17_i38_i_i_1;
	end
	bb17_i38_i_i_1:
	begin
		/*   br i1 %306, label %bb18.i39.i.i, label %bb21.i.i.i*/
		if (var307) begin
			cur_state = bb18_i39_i_i;
		end
		else begin
			cur_state = bb21_i_i_i;
		end
	end
	bb18_i39_i_i:
	begin
		/*   %307 = or i64 %234, %233                        ; <i64> [#uses=1]*/
		var308 = var234 | var233;
		/*   br label %bb18.i39.i.i_1*/
		cur_state = bb18_i39_i_i_1;
	end
	bb18_i39_i_i_1:
	begin
		/*   %308 = icmp eq i64 %307, 0                      ; <i1> [#uses=1]*/
		var309 = var308 == 64'd0;
		/*   br label %bb18.i39.i.i_2*/
		cur_state = bb18_i39_i_i_2;
	end
	bb18_i39_i_i_2:
	begin
		/*   br i1 %308, label %float64_add.exit.i, label %bb19.i.i.i*/
		if (var309) begin
			var237 = app_0_i;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
		else begin
			cur_state = bb19_i_i_i;
		end
	end
	bb19_i_i_i:
	begin
		/*   %309 = and i64 %app.0.i, 9221120237041090560    ; <i64> [#uses=1]*/
		var310 = app_0_i & 64'd9221120237041090560;
		/*   br label %bb19.i.i.i_1*/
		cur_state = bb19_i_i_i_1;
	end
	bb19_i_i_i_1:
	begin
		/*   %310 = icmp eq i64 %309, 9218868437227405312    ; <i1> [#uses=1]*/
		var311 = var310 == 64'd9218868437227405312;
		/*   br label %bb19.i.i.i_2*/
		cur_state = bb19_i_i_i_2;
	end
	bb19_i_i_i_2:
	begin
		/*   br i1 %310, label %bb.i14.i.i42.i.i, label %float64_is_signaling_nan.exit16.i.i43.i.i*/
		if (var311) begin
			cur_state = bb_i14_i_i42_i_i;
		end
		else begin
			var312 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit16_i_i43_i_i;
		end
	end
	bb_i14_i_i42_i_i:
	begin
		/*   %311 = and i64 %app.0.i, 2251799813685247       ; <i64> [#uses=1]*/
		var313 = app_0_i & 64'd2251799813685247;
		/*   br label %bb.i14.i.i42.i.i_1*/
		cur_state = bb_i14_i_i42_i_i_1;
	end
	bb_i14_i_i42_i_i_1:
	begin
		/*   %not..i12.i.i40.i.i = icmp ne i64 %311, 0       ; <i1> [#uses=1]*/
		not__i12_i_i40_i_i = var313 != 64'd0;
		/*   br label %bb.i14.i.i42.i.i_2*/
		cur_state = bb_i14_i_i42_i_i_2;
	end
	bb_i14_i_i42_i_i_2:
	begin
		/*   %retval.i13.i.i41.i.i = zext i1 %not..i12.i.i40.i.i to i32 ; <i32> [#uses=1]*/
		retval_i13_i_i41_i_i = not__i12_i_i40_i_i;
		/*   br label %float64_is_signaling_nan.exit16.i.i43.i.i*/
		var312 = retval_i13_i_i41_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit16_i_i43_i_i;
	end
	float64_is_signaling_nan_exit16_i_i43_i_i:
	begin
		/*   %312 = phi i32 [ %retval.i13.i.i41.i.i, %bb.i14.i.i42.i.i_2 ], [ 0, %bb19.i.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %313 = shl i64 %217, 1                          ; <i64> [#uses=1]*/
		var314 = var60 <<< (64'd1 % 64);
		/*   %314 = and i64 %217, 9221120237041090560        ; <i64> [#uses=1]*/
		var315 = var60 & 64'd9221120237041090560;
		/*   br label %float64_is_signaling_nan.exit16.i.i43.i.i_1*/
		cur_state = float64_is_signaling_nan_exit16_i_i43_i_i_1;
	end
	float64_is_signaling_nan_exit16_i_i43_i_i_1:
	begin
		/*   %315 = icmp ugt i64 %313, -9007199254740992     ; <i1> [#uses=1]*/
		var316 = var314 > -64'd9007199254740992;
		/*   %316 = icmp eq i64 %314, 9218868437227405312    ; <i1> [#uses=1]*/
		var317 = var315 == 64'd9218868437227405312;
		/*   br label %float64_is_signaling_nan.exit16.i.i43.i.i_2*/
		cur_state = float64_is_signaling_nan_exit16_i_i43_i_i_2;
	end
	float64_is_signaling_nan_exit16_i_i43_i_i_2:
	begin
		/*   br i1 %316, label %bb.i.i.i46.i.i, label %float64_is_signaling_nan.exit.i.i47.i.i*/
		if (var317) begin
			cur_state = bb_i_i_i46_i_i;
		end
		else begin
			var318 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit_i_i47_i_i;
		end
	end
	bb_i_i_i46_i_i:
	begin
		/*   %317 = and i64 %217, 2251799813685247           ; <i64> [#uses=1]*/
		var319 = var60 & 64'd2251799813685247;
		/*   br label %bb.i.i.i46.i.i_1*/
		cur_state = bb_i_i_i46_i_i_1;
	end
	bb_i_i_i46_i_i_1:
	begin
		/*   %not..i.i.i44.i.i = icmp ne i64 %317, 0         ; <i1> [#uses=1]*/
		not__i_i_i44_i_i = var319 != 64'd0;
		/*   br label %bb.i.i.i46.i.i_2*/
		cur_state = bb_i_i_i46_i_i_2;
	end
	bb_i_i_i46_i_i_2:
	begin
		/*   %retval.i.i.i45.i.i = zext i1 %not..i.i.i44.i.i to i32 ; <i32> [#uses=1]*/
		retval_i_i_i45_i_i = not__i_i_i44_i_i;
		/*   br label %float64_is_signaling_nan.exit.i.i47.i.i*/
		var318 = retval_i_i_i45_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit_i_i47_i_i;
	end
	float64_is_signaling_nan_exit_i_i47_i_i:
	begin
		/*   %318 = phi i32 [ %retval.i.i.i45.i.i, %bb.i.i.i46.i.i_2 ], [ 0, %float64_is_signaling_nan.exit16.i.i43.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %319 = or i64 %app.0.i, 2251799813685248        ; <i64> [#uses=2]*/
		var320 = app_0_i | 64'd2251799813685248;
		/*   %320 = or i64 %217, 2251799813685248            ; <i64> [#uses=2]*/
		var321 = var60 | 64'd2251799813685248;
		/*   br label %float64_is_signaling_nan.exit.i.i47.i.i_1*/
		cur_state = float64_is_signaling_nan_exit_i_i47_i_i_1;
	end
	float64_is_signaling_nan_exit_i_i47_i_i_1:
	begin
		/*   %321 = or i32 %318, %312                        ; <i32> [#uses=1]*/
		var322 = var318 | var312;
		/*   br label %float64_is_signaling_nan.exit.i.i47.i.i_2*/
		cur_state = float64_is_signaling_nan_exit_i_i47_i_i_2;
	end
	float64_is_signaling_nan_exit_i_i47_i_i_2:
	begin
		/*   %322 = icmp eq i32 %321, 0                      ; <i1> [#uses=1]*/
		var323 = var322 == 32'd0;
		/*   br label %float64_is_signaling_nan.exit.i.i47.i.i_3*/
		cur_state = float64_is_signaling_nan_exit_i_i47_i_i_3;
	end
	float64_is_signaling_nan_exit_i_i47_i_i_3:
	begin
		/*   br i1 %322, label %bb1.i.i49.i.i, label %bb.i.i48.i.i*/
		if (var323) begin
			cur_state = bb1_i_i49_i_i;
		end
		else begin
			cur_state = bb_i_i48_i_i;
		end
	end
	bb_i_i48_i_i:
	begin
		/*   %323 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb.i.i48.i.i_1*/
		cur_state = bb_i_i48_i_i_1;
	end
	bb_i_i48_i_i_1:
	begin
		var324 = memory_controller_out[31:0];
		/*   %load_noop11 = add i32 %323, 0                  ; <i32> [#uses=1]*/
		load_noop11 = var324 + 32'd0;
		/*   br label %bb.i.i48.i.i_2*/
		cur_state = bb_i_i48_i_i_2;
	end
	bb_i_i48_i_i_2:
	begin
		/*   %324 = or i32 %load_noop11, 16                  ; <i32> [#uses=1]*/
		var325 = load_noop11 | 32'd16;
		/*   br label %bb.i.i48.i.i_3*/
		cur_state = bb_i_i48_i_i_3;
	end
	bb_i_i48_i_i_3:
	begin
		/*   store i32 %324, i32* @float_exception_flags, align 4*/
		/*   br label %bb1.i.i49.i.i*/
		cur_state = bb1_i_i49_i_i;
	end
	bb1_i_i49_i_i:
	begin
		/*   %325 = icmp eq i32 %318, 0                      ; <i1> [#uses=1]*/
		var326 = var318 == 32'd0;
		/*   br label %bb1.i.i49.i.i_1*/
		cur_state = bb1_i_i49_i_i_1;
	end
	bb1_i_i49_i_i_1:
	begin
		/*   br i1 %325, label %bb2.i.i50.i.i, label %float64_add.exit.i*/
		if (var326) begin
			cur_state = bb2_i_i50_i_i;
		end
		else begin
			var237 = var321;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb2_i_i50_i_i:
	begin
		/*   %326 = icmp eq i32 %312, 0                      ; <i1> [#uses=1]*/
		var327 = var312 == 32'd0;
		/*   br label %bb2.i.i50.i.i_1*/
		cur_state = bb2_i_i50_i_i_1;
	end
	bb2_i_i50_i_i_1:
	begin
		/*   br i1 %326, label %bb3.i.i52.i.i, label %float64_add.exit.i*/
		if (var327) begin
			cur_state = bb3_i_i52_i_i;
		end
		else begin
			var237 = var320;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb3_i_i52_i_i:
	begin
		/*   %iftmp.34.0.i.i51.i.i = select i1 %315, i64 %320, i64 %319 ; <i64> [#uses=1]*/
		iftmp_34_0_i_i51_i_i = (var316) ? var321 : var320;
		/*   br label %float64_add.exit.i*/
		var237 = iftmp_34_0_i_i51_i_i;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	bb21_i_i_i:
	begin
		/*   %327 = icmp eq i32 %225, 0                      ; <i1> [#uses=1]*/
		var328 = var225 == 32'd0;
		/*   %328 = add i64 %234, %233                       ; <i64> [#uses=2]*/
		var329 = var234 + var233;
		/*   br label %bb21.i.i.i_1*/
		cur_state = bb21_i_i_i_1;
	end
	bb21_i_i_i_1:
	begin
		/*   br i1 %327, label %bb22.i.i.i, label %bb23.i.i.i*/
		if (var328) begin
			cur_state = bb22_i_i_i;
		end
		else begin
			cur_state = bb23_i_i_i;
		end
	end
	bb22_i_i_i:
	begin
		/*   %329 = lshr i64 %328, 9                         ; <i64> [#uses=1]*/
		var330 = var329 >>> (64'd9 % 64);
		/*   %330 = and i64 %app.0.i, -9223372036854775808   ; <i64> [#uses=1]*/
		var331 = app_0_i & -64'd9223372036854775808;
		/*   br label %bb22.i.i.i_1*/
		cur_state = bb22_i_i_i_1;
	end
	bb22_i_i_i_1:
	begin
		/*   %331 = or i64 %329, %330                        ; <i64> [#uses=1]*/
		var332 = var330 | var331;
		/*   br label %float64_add.exit.i*/
		var237 = var332;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	bb23_i_i_i:
	begin
		/*   %332 = add i64 %328, 4611686018427387904        ; <i64> [#uses=1]*/
		var333 = var329 + 64'd4611686018427387904;
		/*   br label %roundAndPack.i.i.i*/
		zSig_0_i58_i_i = var333;   /* for PHI node */
		zExp_1_i_i_i = var225;   /* for PHI node */
		cur_state = roundAndPack_i_i_i;
	end
	bb24_i57_i_i:
	begin
		/*   %aSig.1.i54.i.i = phi i64 [ %233, %bb4.i23.i.i_3 ], [ %233, %bb2.i49.i.i.i_6 ], [ %233, %bb4.i50.i.i.i_1 ], [ %303, %bb2.i29.i36.i.i_5 ], [ %305, %bb4.i.i37.i.i_1 ], [ %aSig.0.i30.i.i, %bb13.i32.i.i_4 ] ; <i64> [#uses=1]*/

		/*   %bSig.1.i55.i.i = phi i64 [ %bSig.0.i21.i.i, %bb4.i23.i.i_3 ], [ %266, %bb2.i49.i.i.i_6 ], [ %268, %bb4.i50.i.i.i_1 ], [ %234, %bb2.i29.i36.i.i_5 ], [ %234, %bb4.i.i37.i.i_1 ], [ %234, %bb13.i32.i.i_4 ] ; <i64> [#uses=1]*/

		/*   %zExp.0.i56.i.i = phi i32 [ %225, %bb4.i23.i.i_3 ], [ %225, %bb2.i49.i.i.i_6 ], [ %225, %bb4.i50.i.i.i_1 ], [ %228, %bb2.i29.i36.i.i_5 ], [ %228, %bb4.i.i37.i.i_1 ], [ %228, %bb13.i32.i.i_4 ] ; <i32> [#uses=2]*/

		/*   br label %bb24.i57.i.i_1*/
		cur_state = bb24_i57_i_i_1;
	end
	bb24_i57_i_i_1:
	begin
		/*   %333 = or i64 %aSig.1.i54.i.i, 2305843009213693952 ; <i64> [#uses=1]*/
		var334 = aSig_1_i54_i_i | 64'd2305843009213693952;
		/*   %334 = add i32 %zExp.0.i56.i.i, -1              ; <i32> [#uses=1]*/
		var335 = zExp_0_i56_i_i + -32'd1;
		/*   br label %bb24.i57.i.i_2*/
		cur_state = bb24_i57_i_i_2;
	end
	bb24_i57_i_i_2:
	begin
		/*   %335 = add i64 %333, %bSig.1.i55.i.i            ; <i64> [#uses=2]*/
		var336 = var334 + bSig_1_i55_i_i;
		/*   br label %bb24.i57.i.i_3*/
		cur_state = bb24_i57_i_i_3;
	end
	bb24_i57_i_i_3:
	begin
		/*   %336 = shl i64 %335, 1                          ; <i64> [#uses=2]*/
		var337 = var336 <<< (64'd1 % 64);
		/*   br label %bb24.i57.i.i_4*/
		cur_state = bb24_i57_i_i_4;
	end
	bb24_i57_i_i_4:
	begin
		/*   %337 = icmp slt i64 %336, 0                     ; <i1> [#uses=2]*/
		var338 = $signed(var337) < $signed(64'd0);
		/*   br label %bb24.i57.i.i_5*/
		cur_state = bb24_i57_i_i_5;
	end
	bb24_i57_i_i_5:
	begin
		/*   %..i.i.i = select i1 %337, i64 %335, i64 %336   ; <i64> [#uses=2]*/
		__i_i_i = (var338) ? var336 : var337;
		/*   br i1 %337, label %bb25.i.i.i, label %roundAndPack.i.i.i*/
		if (var338) begin
			cur_state = bb25_i_i_i;
		end
		else begin
			zSig_0_i58_i_i = __i_i_i;   /* for PHI node */
			zExp_1_i_i_i = var335;   /* for PHI node */
			cur_state = roundAndPack_i_i_i;
		end
	end
	bb25_i_i_i:
	begin
		/*   br label %roundAndPack.i.i.i*/
		zSig_0_i58_i_i = __i_i_i;   /* for PHI node */
		zExp_1_i_i_i = zExp_0_i56_i_i;   /* for PHI node */
		cur_state = roundAndPack_i_i_i;
	end
	roundAndPack_i_i_i:
	begin
		/*   %zSig.0.i58.i.i = phi i64 [ %..i.i.i, %bb25.i.i.i ], [ %..i.i.i, %bb24.i57.i.i_5 ], [ %332, %bb23.i.i.i ] ; <i64> [#uses=1]*/

		/*   %zExp.1.i.i.i = phi i32 [ %zExp.0.i56.i.i, %bb25.i.i.i ], [ %334, %bb24.i57.i.i_5 ], [ %225, %bb23.i.i.i ] ; <i32> [#uses=1]*/

		/*   br label %roundAndPack.i.i.i_1*/
		cur_state = roundAndPack_i_i_i_1;
	end
	roundAndPack_i_i_i_1:
	begin
		/*   %338 = tail call fastcc i64 @roundAndPackFloat64(i32 %220, i32 %zExp.1.i.i.i, i64 %zSig.0.i58.i.i) nounwind ; <i64> [#uses=1]*/
		roundAndPackFloat64_start = 1;
		/* Argument:   %220 = trunc i64 %218 to i32                    ; <i32> [#uses=5]*/
		roundAndPackFloat64_zSign = var220;
		/* Argument:   %zExp.1.i.i.i = phi i32 [ %zExp.0.i56.i.i, %bb25.i.i.i ], [ %334, %bb24.i57.i.i_5 ], [ %225, %bb23.i.i.i ] ; <i32> [#uses=1]*/
		roundAndPackFloat64_zExp = zExp_1_i_i_i;
		/* Argument:   %zSig.0.i58.i.i = phi i64 [ %..i.i.i, %bb25.i.i.i ], [ %..i.i.i, %bb24.i57.i.i_5 ], [ %332, %bb23.i.i.i ] ; <i64> [#uses=1]*/
		roundAndPackFloat64_zSig = zSig_0_i58_i_i;
		cur_state = roundAndPack_i_i_i_1_call_0;
	end
	roundAndPack_i_i_i_1_call_0:
	begin
		roundAndPackFloat64_start = 0;
		if (roundAndPackFloat64_finish == 1)
			begin
			var339 = roundAndPackFloat64_return_val;
			cur_state = roundAndPack_i_i_i_1_call_1;
			end
		else
			cur_state = roundAndPack_i_i_i_1_call_0;
	end
	roundAndPack_i_i_i_1_call_1:
	begin
		/*   br label %float64_add.exit.i*/
		var237 = var339;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	bb1_i6_i:
	begin
		/*   %339 = shl i64 %app.0.i, 10                     ; <i64> [#uses=1]*/
		var340 = app_0_i <<< (64'd10 % 64);
		/*   %340 = shl i64 %217, 10                         ; <i64> [#uses=1]*/
		var341 = var60 <<< (64'd10 % 64);
		/*   %341 = icmp sgt i32 %229, 0                     ; <i1> [#uses=1]*/
		var342 = $signed(var229) > $signed(32'd0);
		/*   br label %bb1.i6.i_1*/
		cur_state = bb1_i6_i_1;
	end
	bb1_i6_i_1:
	begin
		/*   %342 = and i64 %339, 4611686018427386880        ; <i64> [#uses=9]*/
		var343 = var340 & 64'd4611686018427386880;
		/*   %343 = and i64 %340, 4611686018427386880        ; <i64> [#uses=9]*/
		var344 = var341 & 64'd4611686018427386880;
		/*   br i1 %341, label %aExpBigger.i.i.i, label %bb.i.i7.i*/
		if (var342) begin
			cur_state = aExpBigger_i_i_i;
		end
		else begin
			cur_state = bb_i_i7_i;
		end
	end
	bb_i_i7_i:
	begin
		/*   %344 = icmp slt i32 %229, 0                     ; <i1> [#uses=1]*/
		var345 = $signed(var229) < $signed(32'd0);
		/*   br label %bb.i.i7.i_1*/
		cur_state = bb_i_i7_i_1;
	end
	bb_i_i7_i_1:
	begin
		/*   br i1 %344, label %bExpBigger.i.i.i, label %bb1.i.i8.i*/
		if (var345) begin
			cur_state = bExpBigger_i_i_i;
		end
		else begin
			cur_state = bb1_i_i8_i;
		end
	end
	bb1_i_i8_i:
	begin
		/*   switch i32 %225, label %bb7.i.i12.i [
    i32 2047, label %bb2.i.i9.i
    i32 0, label %bb6.i.i.i
  ]*/
		case(var225)
		32'd2047:
		begin
			cur_state = bb2_i_i9_i;
		end
		32'd0:
		begin
			cur_state = bb6_i_i_i;
		end
		default:
		begin
			bExp_0_i_i_i = var228;   /* for PHI node */
			aExp_0_i_i_i = var225;   /* for PHI node */
			cur_state = bb7_i_i12_i;
		end
endcase
	end
	bb2_i_i9_i:
	begin
		/*   %345 = or i64 %343, %342                        ; <i64> [#uses=1]*/
		var346 = var344 | var343;
		/*   br label %bb2.i.i9.i_1*/
		cur_state = bb2_i_i9_i_1;
	end
	bb2_i_i9_i_1:
	begin
		/*   %346 = icmp eq i64 %345, 0                      ; <i1> [#uses=1]*/
		var347 = var346 == 64'd0;
		/*   br label %bb2.i.i9.i_2*/
		cur_state = bb2_i_i9_i_2;
	end
	bb2_i_i9_i_2:
	begin
		/*   br i1 %346, label %bb4.i.i11.i, label %bb3.i.i10.i*/
		if (var347) begin
			cur_state = bb4_i_i11_i;
		end
		else begin
			cur_state = bb3_i_i10_i;
		end
	end
	bb3_i_i10_i:
	begin
		/*   %347 = and i64 %app.0.i, 9221120237041090560    ; <i64> [#uses=1]*/
		var348 = app_0_i & 64'd9221120237041090560;
		/*   br label %bb3.i.i10.i_1*/
		cur_state = bb3_i_i10_i_1;
	end
	bb3_i_i10_i_1:
	begin
		/*   %348 = icmp eq i64 %347, 9218868437227405312    ; <i1> [#uses=1]*/
		var349 = var348 == 64'd9218868437227405312;
		/*   br label %bb3.i.i10.i_2*/
		cur_state = bb3_i_i10_i_2;
	end
	bb3_i_i10_i_2:
	begin
		/*   br i1 %348, label %bb.i14.i55.i.i.i, label %float64_is_signaling_nan.exit16.i56.i.i.i*/
		if (var349) begin
			cur_state = bb_i14_i55_i_i_i;
		end
		else begin
			var350 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit16_i56_i_i_i;
		end
	end
	bb_i14_i55_i_i_i:
	begin
		/*   %349 = and i64 %app.0.i, 2251799813685247       ; <i64> [#uses=1]*/
		var351 = app_0_i & 64'd2251799813685247;
		/*   br label %bb.i14.i55.i.i.i_1*/
		cur_state = bb_i14_i55_i_i_i_1;
	end
	bb_i14_i55_i_i_i_1:
	begin
		/*   %not..i12.i53.i.i.i = icmp ne i64 %349, 0       ; <i1> [#uses=1]*/
		not__i12_i53_i_i_i = var351 != 64'd0;
		/*   br label %bb.i14.i55.i.i.i_2*/
		cur_state = bb_i14_i55_i_i_i_2;
	end
	bb_i14_i55_i_i_i_2:
	begin
		/*   %retval.i13.i54.i.i.i = zext i1 %not..i12.i53.i.i.i to i32 ; <i32> [#uses=1]*/
		retval_i13_i54_i_i_i = not__i12_i53_i_i_i;
		/*   br label %float64_is_signaling_nan.exit16.i56.i.i.i*/
		var350 = retval_i13_i54_i_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit16_i56_i_i_i;
	end
	float64_is_signaling_nan_exit16_i56_i_i_i:
	begin
		/*   %350 = phi i32 [ %retval.i13.i54.i.i.i, %bb.i14.i55.i.i.i_2 ], [ 0, %bb3.i.i10.i_2 ] ; <i32> [#uses=2]*/

		/*   %351 = shl i64 %217, 1                          ; <i64> [#uses=1]*/
		var352 = var60 <<< (64'd1 % 64);
		/*   %352 = and i64 %217, 9221120237041090560        ; <i64> [#uses=1]*/
		var353 = var60 & 64'd9221120237041090560;
		/*   br label %float64_is_signaling_nan.exit16.i56.i.i.i_1*/
		cur_state = float64_is_signaling_nan_exit16_i56_i_i_i_1;
	end
	float64_is_signaling_nan_exit16_i56_i_i_i_1:
	begin
		/*   %353 = icmp ugt i64 %351, -9007199254740992     ; <i1> [#uses=1]*/
		var354 = var352 > -64'd9007199254740992;
		/*   %354 = icmp eq i64 %352, 9218868437227405312    ; <i1> [#uses=1]*/
		var355 = var353 == 64'd9218868437227405312;
		/*   br label %float64_is_signaling_nan.exit16.i56.i.i.i_2*/
		cur_state = float64_is_signaling_nan_exit16_i56_i_i_i_2;
	end
	float64_is_signaling_nan_exit16_i56_i_i_i_2:
	begin
		/*   br i1 %354, label %bb.i.i59.i.i.i, label %float64_is_signaling_nan.exit.i60.i.i.i*/
		if (var355) begin
			cur_state = bb_i_i59_i_i_i;
		end
		else begin
			var356 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit_i60_i_i_i;
		end
	end
	bb_i_i59_i_i_i:
	begin
		/*   %355 = and i64 %217, 2251799813685247           ; <i64> [#uses=1]*/
		var357 = var60 & 64'd2251799813685247;
		/*   br label %bb.i.i59.i.i.i_1*/
		cur_state = bb_i_i59_i_i_i_1;
	end
	bb_i_i59_i_i_i_1:
	begin
		/*   %not..i.i57.i.i.i = icmp ne i64 %355, 0         ; <i1> [#uses=1]*/
		not__i_i57_i_i_i = var357 != 64'd0;
		/*   br label %bb.i.i59.i.i.i_2*/
		cur_state = bb_i_i59_i_i_i_2;
	end
	bb_i_i59_i_i_i_2:
	begin
		/*   %retval.i.i58.i.i.i = zext i1 %not..i.i57.i.i.i to i32 ; <i32> [#uses=1]*/
		retval_i_i58_i_i_i = not__i_i57_i_i_i;
		/*   br label %float64_is_signaling_nan.exit.i60.i.i.i*/
		var356 = retval_i_i58_i_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit_i60_i_i_i;
	end
	float64_is_signaling_nan_exit_i60_i_i_i:
	begin
		/*   %356 = phi i32 [ %retval.i.i58.i.i.i, %bb.i.i59.i.i.i_2 ], [ 0, %float64_is_signaling_nan.exit16.i56.i.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %357 = or i64 %app.0.i, 2251799813685248        ; <i64> [#uses=2]*/
		var358 = app_0_i | 64'd2251799813685248;
		/*   %358 = or i64 %217, 2251799813685248            ; <i64> [#uses=2]*/
		var359 = var60 | 64'd2251799813685248;
		/*   br label %float64_is_signaling_nan.exit.i60.i.i.i_1*/
		cur_state = float64_is_signaling_nan_exit_i60_i_i_i_1;
	end
	float64_is_signaling_nan_exit_i60_i_i_i_1:
	begin
		/*   %359 = or i32 %356, %350                        ; <i32> [#uses=1]*/
		var360 = var356 | var350;
		/*   br label %float64_is_signaling_nan.exit.i60.i.i.i_2*/
		cur_state = float64_is_signaling_nan_exit_i60_i_i_i_2;
	end
	float64_is_signaling_nan_exit_i60_i_i_i_2:
	begin
		/*   %360 = icmp eq i32 %359, 0                      ; <i1> [#uses=1]*/
		var361 = var360 == 32'd0;
		/*   br label %float64_is_signaling_nan.exit.i60.i.i.i_3*/
		cur_state = float64_is_signaling_nan_exit_i60_i_i_i_3;
	end
	float64_is_signaling_nan_exit_i60_i_i_i_3:
	begin
		/*   br i1 %360, label %bb1.i62.i.i.i, label %bb.i61.i.i.i*/
		if (var361) begin
			cur_state = bb1_i62_i_i_i;
		end
		else begin
			cur_state = bb_i61_i_i_i;
		end
	end
	bb_i61_i_i_i:
	begin
		/*   %361 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb.i61.i.i.i_1*/
		cur_state = bb_i61_i_i_i_1;
	end
	bb_i61_i_i_i_1:
	begin
		var362 = memory_controller_out[31:0];
		/*   %load_noop12 = add i32 %361, 0                  ; <i32> [#uses=1]*/
		load_noop12 = var362 + 32'd0;
		/*   br label %bb.i61.i.i.i_2*/
		cur_state = bb_i61_i_i_i_2;
	end
	bb_i61_i_i_i_2:
	begin
		/*   %362 = or i32 %load_noop12, 16                  ; <i32> [#uses=1]*/
		var363 = load_noop12 | 32'd16;
		/*   br label %bb.i61.i.i.i_3*/
		cur_state = bb_i61_i_i_i_3;
	end
	bb_i61_i_i_i_3:
	begin
		/*   store i32 %362, i32* @float_exception_flags, align 4*/
		/*   br label %bb1.i62.i.i.i*/
		cur_state = bb1_i62_i_i_i;
	end
	bb1_i62_i_i_i:
	begin
		/*   %363 = icmp eq i32 %356, 0                      ; <i1> [#uses=1]*/
		var364 = var356 == 32'd0;
		/*   br label %bb1.i62.i.i.i_1*/
		cur_state = bb1_i62_i_i_i_1;
	end
	bb1_i62_i_i_i_1:
	begin
		/*   br i1 %363, label %bb2.i63.i.i.i, label %float64_add.exit.i*/
		if (var364) begin
			cur_state = bb2_i63_i_i_i;
		end
		else begin
			var237 = var359;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb2_i63_i_i_i:
	begin
		/*   %364 = icmp eq i32 %350, 0                      ; <i1> [#uses=1]*/
		var365 = var350 == 32'd0;
		/*   br label %bb2.i63.i.i.i_1*/
		cur_state = bb2_i63_i_i_i_1;
	end
	bb2_i63_i_i_i_1:
	begin
		/*   br i1 %364, label %bb3.i65.i.i.i, label %float64_add.exit.i*/
		if (var365) begin
			cur_state = bb3_i65_i_i_i;
		end
		else begin
			var237 = var358;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb3_i65_i_i_i:
	begin
		/*   %iftmp.34.0.i64.i.i.i = select i1 %353, i64 %358, i64 %357 ; <i64> [#uses=1]*/
		iftmp_34_0_i64_i_i_i = (var354) ? var359 : var358;
		/*   br label %float64_add.exit.i*/
		var237 = iftmp_34_0_i64_i_i_i;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	bb4_i_i11_i:
	begin
		/*   %365 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb4.i.i11.i_1*/
		cur_state = bb4_i_i11_i_1;
	end
	bb4_i_i11_i_1:
	begin
		var366 = memory_controller_out[31:0];
		/*   %load_noop13 = add i32 %365, 0                  ; <i32> [#uses=1]*/
		load_noop13 = var366 + 32'd0;
		/*   br label %bb4.i.i11.i_2*/
		cur_state = bb4_i_i11_i_2;
	end
	bb4_i_i11_i_2:
	begin
		/*   %366 = or i32 %load_noop13, 16                  ; <i32> [#uses=1]*/
		var367 = load_noop13 | 32'd16;
		/*   br label %bb4.i.i11.i_3*/
		cur_state = bb4_i_i11_i_3;
	end
	bb4_i_i11_i_3:
	begin
		/*   store i32 %366, i32* @float_exception_flags, align 4*/
		/*   br label %float64_add.exit.i*/
		var237 = 64'd9223372036854775807;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	bb6_i_i_i:
	begin
		/*   br label %bb7.i.i12.i*/
		bExp_0_i_i_i = 32'd1;   /* for PHI node */
		aExp_0_i_i_i = 32'd1;   /* for PHI node */
		cur_state = bb7_i_i12_i;
	end
	bb7_i_i12_i:
	begin
		/*   %bExp.0.i.i.i = phi i32 [ 1, %bb6.i.i.i ], [ %228, %bb1.i.i8.i ] ; <i32> [#uses=1]*/

		/*   %aExp.0.i.i.i = phi i32 [ 1, %bb6.i.i.i ], [ %225, %bb1.i.i8.i ] ; <i32> [#uses=1]*/

		/*   %367 = icmp ult i64 %343, %342                  ; <i1> [#uses=1]*/
		var368 = var344 < var343;
		/*   br label %bb7.i.i12.i_1*/
		cur_state = bb7_i_i12_i_1;
	end
	bb7_i_i12_i_1:
	begin
		/*   br i1 %367, label %aBigger.i.i.i, label %bb8.i.i13.i*/
		if (var368) begin
			aSig_2_i_i_i = var343;   /* for PHI node */
			bSig_2_i_i_i = var344;   /* for PHI node */
			aExp_1_i_i_i = aExp_0_i_i_i;   /* for PHI node */
			cur_state = aBigger_i_i_i;
		end
		else begin
			cur_state = bb8_i_i13_i;
		end
	end
	bb8_i_i13_i:
	begin
		/*   %368 = icmp ult i64 %342, %343                  ; <i1> [#uses=1]*/
		var369 = var343 < var344;
		/*   br label %bb8.i.i13.i_1*/
		cur_state = bb8_i_i13_i_1;
	end
	bb8_i_i13_i_1:
	begin
		/*   br i1 %368, label %bBigger.i.i.i, label %float64_add.exit.i*/
		if (var369) begin
			aSig_1_i_i_i = var343;   /* for PHI node */
			bSig_0_i_i_i = var344;   /* for PHI node */
			bExp_1_i_i_i = bExp_0_i_i_i;   /* for PHI node */
			cur_state = bBigger_i_i_i;
		end
		else begin
			var237 = 64'd0;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bExpBigger_i_i_i:
	begin
		/*   %369 = icmp eq i32 %228, 2047                   ; <i1> [#uses=1]*/
		var370 = var228 == 32'd2047;
		/*   br label %bExpBigger.i.i.i_1*/
		cur_state = bExpBigger_i_i_i_1;
	end
	bExpBigger_i_i_i_1:
	begin
		/*   br i1 %369, label %bb10.i.i14.i, label %bb13.i.i.i*/
		if (var370) begin
			cur_state = bb10_i_i14_i;
		end
		else begin
			cur_state = bb13_i_i_i;
		end
	end
	bb10_i_i14_i:
	begin
		/*   %370 = icmp eq i64 %343, 0                      ; <i1> [#uses=1]*/
		var371 = var344 == 64'd0;
		/*   br label %bb10.i.i14.i_1*/
		cur_state = bb10_i_i14_i_1;
	end
	bb10_i_i14_i_1:
	begin
		/*   br i1 %370, label %bb12.i.i.i, label %bb11.i.i.i*/
		if (var371) begin
			cur_state = bb12_i_i_i;
		end
		else begin
			cur_state = bb11_i_i_i;
		end
	end
	bb11_i_i_i:
	begin
		/*   %371 = and i64 %app.0.i, 9221120237041090560    ; <i64> [#uses=1]*/
		var372 = app_0_i & 64'd9221120237041090560;
		/*   br label %bb11.i.i.i_1*/
		cur_state = bb11_i_i_i_1;
	end
	bb11_i_i_i_1:
	begin
		/*   %372 = icmp eq i64 %371, 9218868437227405312    ; <i1> [#uses=1]*/
		var373 = var372 == 64'd9218868437227405312;
		/*   br label %bb11.i.i.i_2*/
		cur_state = bb11_i_i_i_2;
	end
	bb11_i_i_i_2:
	begin
		/*   br i1 %372, label %bb.i14.i39.i.i.i, label %float64_is_signaling_nan.exit16.i40.i.i.i*/
		if (var373) begin
			cur_state = bb_i14_i39_i_i_i;
		end
		else begin
			var374 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit16_i40_i_i_i;
		end
	end
	bb_i14_i39_i_i_i:
	begin
		/*   %373 = and i64 %app.0.i, 2251799813685247       ; <i64> [#uses=1]*/
		var375 = app_0_i & 64'd2251799813685247;
		/*   br label %bb.i14.i39.i.i.i_1*/
		cur_state = bb_i14_i39_i_i_i_1;
	end
	bb_i14_i39_i_i_i_1:
	begin
		/*   %not..i12.i37.i.i.i = icmp ne i64 %373, 0       ; <i1> [#uses=1]*/
		not__i12_i37_i_i_i = var375 != 64'd0;
		/*   br label %bb.i14.i39.i.i.i_2*/
		cur_state = bb_i14_i39_i_i_i_2;
	end
	bb_i14_i39_i_i_i_2:
	begin
		/*   %retval.i13.i38.i.i.i = zext i1 %not..i12.i37.i.i.i to i32 ; <i32> [#uses=1]*/
		retval_i13_i38_i_i_i = not__i12_i37_i_i_i;
		/*   br label %float64_is_signaling_nan.exit16.i40.i.i.i*/
		var374 = retval_i13_i38_i_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit16_i40_i_i_i;
	end
	float64_is_signaling_nan_exit16_i40_i_i_i:
	begin
		/*   %374 = phi i32 [ %retval.i13.i38.i.i.i, %bb.i14.i39.i.i.i_2 ], [ 0, %bb11.i.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %375 = shl i64 %217, 1                          ; <i64> [#uses=1]*/
		var376 = var60 <<< (64'd1 % 64);
		/*   %376 = and i64 %217, 9221120237041090560        ; <i64> [#uses=1]*/
		var377 = var60 & 64'd9221120237041090560;
		/*   br label %float64_is_signaling_nan.exit16.i40.i.i.i_1*/
		cur_state = float64_is_signaling_nan_exit16_i40_i_i_i_1;
	end
	float64_is_signaling_nan_exit16_i40_i_i_i_1:
	begin
		/*   %377 = icmp ugt i64 %375, -9007199254740992     ; <i1> [#uses=1]*/
		var378 = var376 > -64'd9007199254740992;
		/*   %378 = icmp eq i64 %376, 9218868437227405312    ; <i1> [#uses=1]*/
		var379 = var377 == 64'd9218868437227405312;
		/*   br label %float64_is_signaling_nan.exit16.i40.i.i.i_2*/
		cur_state = float64_is_signaling_nan_exit16_i40_i_i_i_2;
	end
	float64_is_signaling_nan_exit16_i40_i_i_i_2:
	begin
		/*   br i1 %378, label %bb.i.i43.i.i.i, label %float64_is_signaling_nan.exit.i44.i.i.i*/
		if (var379) begin
			cur_state = bb_i_i43_i_i_i;
		end
		else begin
			var380 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit_i44_i_i_i;
		end
	end
	bb_i_i43_i_i_i:
	begin
		/*   %379 = and i64 %217, 2251799813685247           ; <i64> [#uses=1]*/
		var381 = var60 & 64'd2251799813685247;
		/*   br label %bb.i.i43.i.i.i_1*/
		cur_state = bb_i_i43_i_i_i_1;
	end
	bb_i_i43_i_i_i_1:
	begin
		/*   %not..i.i41.i.i.i = icmp ne i64 %379, 0         ; <i1> [#uses=1]*/
		not__i_i41_i_i_i = var381 != 64'd0;
		/*   br label %bb.i.i43.i.i.i_2*/
		cur_state = bb_i_i43_i_i_i_2;
	end
	bb_i_i43_i_i_i_2:
	begin
		/*   %retval.i.i42.i.i.i = zext i1 %not..i.i41.i.i.i to i32 ; <i32> [#uses=1]*/
		retval_i_i42_i_i_i = not__i_i41_i_i_i;
		/*   br label %float64_is_signaling_nan.exit.i44.i.i.i*/
		var380 = retval_i_i42_i_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit_i44_i_i_i;
	end
	float64_is_signaling_nan_exit_i44_i_i_i:
	begin
		/*   %380 = phi i32 [ %retval.i.i42.i.i.i, %bb.i.i43.i.i.i_2 ], [ 0, %float64_is_signaling_nan.exit16.i40.i.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %381 = or i64 %app.0.i, 2251799813685248        ; <i64> [#uses=2]*/
		var382 = app_0_i | 64'd2251799813685248;
		/*   %382 = or i64 %217, 2251799813685248            ; <i64> [#uses=2]*/
		var383 = var60 | 64'd2251799813685248;
		/*   br label %float64_is_signaling_nan.exit.i44.i.i.i_1*/
		cur_state = float64_is_signaling_nan_exit_i44_i_i_i_1;
	end
	float64_is_signaling_nan_exit_i44_i_i_i_1:
	begin
		/*   %383 = or i32 %380, %374                        ; <i32> [#uses=1]*/
		var384 = var380 | var374;
		/*   br label %float64_is_signaling_nan.exit.i44.i.i.i_2*/
		cur_state = float64_is_signaling_nan_exit_i44_i_i_i_2;
	end
	float64_is_signaling_nan_exit_i44_i_i_i_2:
	begin
		/*   %384 = icmp eq i32 %383, 0                      ; <i1> [#uses=1]*/
		var385 = var384 == 32'd0;
		/*   br label %float64_is_signaling_nan.exit.i44.i.i.i_3*/
		cur_state = float64_is_signaling_nan_exit_i44_i_i_i_3;
	end
	float64_is_signaling_nan_exit_i44_i_i_i_3:
	begin
		/*   br i1 %384, label %bb1.i46.i.i.i, label %bb.i45.i.i.i*/
		if (var385) begin
			cur_state = bb1_i46_i_i_i;
		end
		else begin
			cur_state = bb_i45_i_i_i;
		end
	end
	bb_i45_i_i_i:
	begin
		/*   %385 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb.i45.i.i.i_1*/
		cur_state = bb_i45_i_i_i_1;
	end
	bb_i45_i_i_i_1:
	begin
		var386 = memory_controller_out[31:0];
		/*   %load_noop14 = add i32 %385, 0                  ; <i32> [#uses=1]*/
		load_noop14 = var386 + 32'd0;
		/*   br label %bb.i45.i.i.i_2*/
		cur_state = bb_i45_i_i_i_2;
	end
	bb_i45_i_i_i_2:
	begin
		/*   %386 = or i32 %load_noop14, 16                  ; <i32> [#uses=1]*/
		var387 = load_noop14 | 32'd16;
		/*   br label %bb.i45.i.i.i_3*/
		cur_state = bb_i45_i_i_i_3;
	end
	bb_i45_i_i_i_3:
	begin
		/*   store i32 %386, i32* @float_exception_flags, align 4*/
		/*   br label %bb1.i46.i.i.i*/
		cur_state = bb1_i46_i_i_i;
	end
	bb1_i46_i_i_i:
	begin
		/*   %387 = icmp eq i32 %380, 0                      ; <i1> [#uses=1]*/
		var388 = var380 == 32'd0;
		/*   br label %bb1.i46.i.i.i_1*/
		cur_state = bb1_i46_i_i_i_1;
	end
	bb1_i46_i_i_i_1:
	begin
		/*   br i1 %387, label %bb2.i47.i.i.i, label %float64_add.exit.i*/
		if (var388) begin
			cur_state = bb2_i47_i_i_i;
		end
		else begin
			var237 = var383;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb2_i47_i_i_i:
	begin
		/*   %388 = icmp eq i32 %374, 0                      ; <i1> [#uses=1]*/
		var389 = var374 == 32'd0;
		/*   br label %bb2.i47.i.i.i_1*/
		cur_state = bb2_i47_i_i_i_1;
	end
	bb2_i47_i_i_i_1:
	begin
		/*   br i1 %388, label %bb3.i49.i.i.i, label %float64_add.exit.i*/
		if (var389) begin
			cur_state = bb3_i49_i_i_i;
		end
		else begin
			var237 = var382;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb3_i49_i_i_i:
	begin
		/*   %iftmp.34.0.i48.i.i.i = select i1 %377, i64 %382, i64 %381 ; <i64> [#uses=1]*/
		iftmp_34_0_i48_i_i_i = (var378) ? var383 : var382;
		/*   br label %float64_add.exit.i*/
		var237 = iftmp_34_0_i48_i_i_i;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	bb12_i_i_i:
	begin
		/*   %389 = xor i32 %220, 1                          ; <i32> [#uses=1]*/
		var390 = var220 ^ 32'd1;
		/*   br label %bb12.i.i.i_1*/
		cur_state = bb12_i_i_i_1;
	end
	bb12_i_i_i_1:
	begin
		/*   %390 = zext i32 %389 to i64                     ; <i64> [#uses=1]*/
		var391 = var390;
		/*   br label %bb12.i.i.i_2*/
		cur_state = bb12_i_i_i_2;
	end
	bb12_i_i_i_2:
	begin
		/*   %391 = shl i64 %390, 63                         ; <i64> [#uses=1]*/
		var392 = var391 <<< (64'd63 % 64);
		/*   br label %bb12.i.i.i_3*/
		cur_state = bb12_i_i_i_3;
	end
	bb12_i_i_i_3:
	begin
		/*   %392 = or i64 %391, 9218868437227405312         ; <i64> [#uses=1]*/
		var393 = var392 | 64'd9218868437227405312;
		/*   br label %float64_add.exit.i*/
		var237 = var393;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	bb13_i_i_i:
	begin
		/*   %393 = icmp eq i32 %225, 0                      ; <i1> [#uses=2]*/
		var394 = var225 == 32'd0;
		/*   %394 = or i64 %342, 4611686018427387904         ; <i64> [#uses=1]*/
		var395 = var343 | 64'd4611686018427387904;
		/*   br label %bb13.i.i.i_1*/
		cur_state = bb13_i_i_i_1;
	end
	bb13_i_i_i_1:
	begin
		/*   %aSig.0.i.i.i = select i1 %393, i64 %342, i64 %394 ; <i64> [#uses=4]*/
		aSig_0_i_i_i = (var394) ? var343 : var395;
		/*   %395 = zext i1 %393 to i32                      ; <i32> [#uses=1]*/
		var396 = var394;
		/*   br label %bb13.i.i.i_2*/
		cur_state = bb13_i_i_i_2;
	end
	bb13_i_i_i_2:
	begin
		/*   %expDiff.0.i.i.i = add i32 %229, %395           ; <i32> [#uses=3]*/
		expDiff_0_i_i_i = var229 + var396;
		/*   br label %bb13.i.i.i_3*/
		cur_state = bb13_i_i_i_3;
	end
	bb13_i_i_i_3:
	begin
		/*   %396 = sub i32 0, %expDiff.0.i.i.i              ; <i32> [#uses=2]*/
		var397 = 32'd0 - expDiff_0_i_i_i;
		/*   %397 = icmp eq i32 %expDiff.0.i.i.i, 0          ; <i1> [#uses=1]*/
		var398 = expDiff_0_i_i_i == 32'd0;
		/*   br label %bb13.i.i.i_4*/
		cur_state = bb13_i_i_i_4;
	end
	bb13_i_i_i_4:
	begin
		/*   br i1 %397, label %shift64RightJamming.exit36.i.i.i, label %bb1.i30.i.i.i*/
		if (var398) begin
			z_0_i35_i_i_i = aSig_0_i_i_i;   /* for PHI node */
			cur_state = shift64RightJamming_exit36_i_i_i;
		end
		else begin
			cur_state = bb1_i30_i_i_i;
		end
	end
	bb1_i30_i_i_i:
	begin
		/*   %398 = icmp slt i32 %396, 64                    ; <i1> [#uses=1]*/
		var399 = $signed(var397) < $signed(32'd64);
		/*   br label %bb1.i30.i.i.i_1*/
		cur_state = bb1_i30_i_i_i_1;
	end
	bb1_i30_i_i_i_1:
	begin
		/*   br i1 %398, label %bb2.i33.i.i.i, label %bb4.i34.i.i.i*/
		if (var399) begin
			cur_state = bb2_i33_i_i_i;
		end
		else begin
			cur_state = bb4_i34_i_i_i;
		end
	end
	bb2_i33_i_i_i:
	begin
		/*   %.cast.i31.i.i.i = zext i32 %396 to i64         ; <i64> [#uses=1]*/
		_cast_i31_i_i_i = var397;
		/*   %399 = and i32 %expDiff.0.i.i.i, 63             ; <i32> [#uses=1]*/
		var400 = expDiff_0_i_i_i & 32'd63;
		/*   br label %bb2.i33.i.i.i_1*/
		cur_state = bb2_i33_i_i_i_1;
	end
	bb2_i33_i_i_i_1:
	begin
		/*   %400 = lshr i64 %aSig.0.i.i.i, %.cast.i31.i.i.i ; <i64> [#uses=1]*/
		var401 = aSig_0_i_i_i >>> (_cast_i31_i_i_i % 64);
		/*   %.cast3.i32.i.i.i = zext i32 %399 to i64        ; <i64> [#uses=1]*/
		_cast3_i32_i_i_i = var400;
		/*   br label %bb2.i33.i.i.i_2*/
		cur_state = bb2_i33_i_i_i_2;
	end
	bb2_i33_i_i_i_2:
	begin
		/*   %401 = shl i64 %aSig.0.i.i.i, %.cast3.i32.i.i.i ; <i64> [#uses=1]*/
		var402 = aSig_0_i_i_i <<< (_cast3_i32_i_i_i % 64);
		/*   br label %bb2.i33.i.i.i_3*/
		cur_state = bb2_i33_i_i_i_3;
	end
	bb2_i33_i_i_i_3:
	begin
		/*   %402 = icmp ne i64 %401, 0                      ; <i1> [#uses=1]*/
		var403 = var402 != 64'd0;
		/*   br label %bb2.i33.i.i.i_4*/
		cur_state = bb2_i33_i_i_i_4;
	end
	bb2_i33_i_i_i_4:
	begin
		/*   %403 = zext i1 %402 to i64                      ; <i64> [#uses=1]*/
		var404 = var403;
		/*   br label %bb2.i33.i.i.i_5*/
		cur_state = bb2_i33_i_i_i_5;
	end
	bb2_i33_i_i_i_5:
	begin
		/*   %404 = or i64 %403, %400                        ; <i64> [#uses=1]*/
		var405 = var404 | var401;
		/*   br label %shift64RightJamming.exit36.i.i.i*/
		z_0_i35_i_i_i = var405;   /* for PHI node */
		cur_state = shift64RightJamming_exit36_i_i_i;
	end
	bb4_i34_i_i_i:
	begin
		/*   %405 = icmp ne i64 %aSig.0.i.i.i, 0             ; <i1> [#uses=1]*/
		var406 = aSig_0_i_i_i != 64'd0;
		/*   br label %bb4.i34.i.i.i_1*/
		cur_state = bb4_i34_i_i_i_1;
	end
	bb4_i34_i_i_i_1:
	begin
		/*   %406 = zext i1 %405 to i64                      ; <i64> [#uses=1]*/
		var407 = var406;
		/*   br label %shift64RightJamming.exit36.i.i.i*/
		z_0_i35_i_i_i = var407;   /* for PHI node */
		cur_state = shift64RightJamming_exit36_i_i_i;
	end
	shift64RightJamming_exit36_i_i_i:
	begin
		/*   %z.0.i35.i.i.i = phi i64 [ %404, %bb2.i33.i.i.i_5 ], [ %406, %bb4.i34.i.i.i_1 ], [ %aSig.0.i.i.i, %bb13.i.i.i_4 ] ; <i64> [#uses=1]*/

		/*   %407 = or i64 %343, 4611686018427387904         ; <i64> [#uses=1]*/
		var408 = var344 | 64'd4611686018427387904;
		/*   br label %bBigger.i.i.i*/
		aSig_1_i_i_i = z_0_i35_i_i_i;   /* for PHI node */
		bSig_0_i_i_i = var408;   /* for PHI node */
		bExp_1_i_i_i = var228;   /* for PHI node */
		cur_state = bBigger_i_i_i;
	end
	bBigger_i_i_i:
	begin
		/*   %aSig.1.i.i.i = phi i64 [ %z.0.i35.i.i.i, %shift64RightJamming.exit36.i.i.i ], [ %342, %bb8.i.i13.i_1 ] ; <i64> [#uses=1]*/

		/*   %bSig.0.i.i.i = phi i64 [ %407, %shift64RightJamming.exit36.i.i.i ], [ %343, %bb8.i.i13.i_1 ] ; <i64> [#uses=1]*/

		/*   %bExp.1.i.i.i = phi i32 [ %228, %shift64RightJamming.exit36.i.i.i ], [ %bExp.0.i.i.i, %bb8.i.i13.i_1 ] ; <i32> [#uses=1]*/

		/*   %408 = xor i32 %220, 1                          ; <i32> [#uses=1]*/
		var409 = var220 ^ 32'd1;
		/*   br label %bBigger.i.i.i_1*/
		cur_state = bBigger_i_i_i_1;
	end
	bBigger_i_i_i_1:
	begin
		/*   %409 = sub i64 %bSig.0.i.i.i, %aSig.1.i.i.i     ; <i64> [#uses=1]*/
		var410 = bSig_0_i_i_i - aSig_1_i_i_i;
		/*   br label %normalizeRoundAndPack.i.i.i*/
		zExp_0_i_i_i = bExp_1_i_i_i;   /* for PHI node */
		zSig_0_i_i_i = var410;   /* for PHI node */
		zSign_addr_0_i_i_i = var409;   /* for PHI node */
		cur_state = normalizeRoundAndPack_i_i_i;
	end
	aExpBigger_i_i_i:
	begin
		/*   %410 = icmp eq i32 %225, 2047                   ; <i1> [#uses=1]*/
		var411 = var225 == 32'd2047;
		/*   br label %aExpBigger.i.i.i_1*/
		cur_state = aExpBigger_i_i_i_1;
	end
	aExpBigger_i_i_i_1:
	begin
		/*   br i1 %410, label %bb17.i.i.i, label %bb20.i.i.i*/
		if (var411) begin
			cur_state = bb17_i_i_i;
		end
		else begin
			cur_state = bb20_i_i_i;
		end
	end
	bb17_i_i_i:
	begin
		/*   %411 = icmp eq i64 %342, 0                      ; <i1> [#uses=1]*/
		var412 = var343 == 64'd0;
		/*   br label %bb17.i.i.i_1*/
		cur_state = bb17_i_i_i_1;
	end
	bb17_i_i_i_1:
	begin
		/*   br i1 %411, label %float64_add.exit.i, label %bb18.i.i.i*/
		if (var412) begin
			var237 = app_0_i;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
		else begin
			cur_state = bb18_i_i_i;
		end
	end
	bb18_i_i_i:
	begin
		/*   %412 = and i64 %app.0.i, 9221120237041090560    ; <i64> [#uses=1]*/
		var413 = app_0_i & 64'd9221120237041090560;
		/*   br label %bb18.i.i.i_1*/
		cur_state = bb18_i_i_i_1;
	end
	bb18_i_i_i_1:
	begin
		/*   %413 = icmp eq i64 %412, 9218868437227405312    ; <i1> [#uses=1]*/
		var414 = var413 == 64'd9218868437227405312;
		/*   br label %bb18.i.i.i_2*/
		cur_state = bb18_i_i_i_2;
	end
	bb18_i_i_i_2:
	begin
		/*   br i1 %413, label %bb.i14.i.i.i.i, label %float64_is_signaling_nan.exit16.i.i.i.i*/
		if (var414) begin
			cur_state = bb_i14_i_i_i_i;
		end
		else begin
			var415 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit16_i_i_i_i;
		end
	end
	bb_i14_i_i_i_i:
	begin
		/*   %414 = and i64 %app.0.i, 2251799813685247       ; <i64> [#uses=1]*/
		var416 = app_0_i & 64'd2251799813685247;
		/*   br label %bb.i14.i.i.i.i_1*/
		cur_state = bb_i14_i_i_i_i_1;
	end
	bb_i14_i_i_i_i_1:
	begin
		/*   %not..i12.i.i.i.i = icmp ne i64 %414, 0         ; <i1> [#uses=1]*/
		not__i12_i_i_i_i = var416 != 64'd0;
		/*   br label %bb.i14.i.i.i.i_2*/
		cur_state = bb_i14_i_i_i_i_2;
	end
	bb_i14_i_i_i_i_2:
	begin
		/*   %retval.i13.i.i.i.i = zext i1 %not..i12.i.i.i.i to i32 ; <i32> [#uses=1]*/
		retval_i13_i_i_i_i = not__i12_i_i_i_i;
		/*   br label %float64_is_signaling_nan.exit16.i.i.i.i*/
		var415 = retval_i13_i_i_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit16_i_i_i_i;
	end
	float64_is_signaling_nan_exit16_i_i_i_i:
	begin
		/*   %415 = phi i32 [ %retval.i13.i.i.i.i, %bb.i14.i.i.i.i_2 ], [ 0, %bb18.i.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %416 = shl i64 %217, 1                          ; <i64> [#uses=1]*/
		var417 = var60 <<< (64'd1 % 64);
		/*   %417 = and i64 %217, 9221120237041090560        ; <i64> [#uses=1]*/
		var418 = var60 & 64'd9221120237041090560;
		/*   br label %float64_is_signaling_nan.exit16.i.i.i.i_1*/
		cur_state = float64_is_signaling_nan_exit16_i_i_i_i_1;
	end
	float64_is_signaling_nan_exit16_i_i_i_i_1:
	begin
		/*   %418 = icmp ugt i64 %416, -9007199254740992     ; <i1> [#uses=1]*/
		var419 = var417 > -64'd9007199254740992;
		/*   %419 = icmp eq i64 %417, 9218868437227405312    ; <i1> [#uses=1]*/
		var420 = var418 == 64'd9218868437227405312;
		/*   br label %float64_is_signaling_nan.exit16.i.i.i.i_2*/
		cur_state = float64_is_signaling_nan_exit16_i_i_i_i_2;
	end
	float64_is_signaling_nan_exit16_i_i_i_i_2:
	begin
		/*   br i1 %419, label %bb.i.i27.i.i.i, label %float64_is_signaling_nan.exit.i.i.i.i*/
		if (var420) begin
			cur_state = bb_i_i27_i_i_i;
		end
		else begin
			var421 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit_i_i_i_i;
		end
	end
	bb_i_i27_i_i_i:
	begin
		/*   %420 = and i64 %217, 2251799813685247           ; <i64> [#uses=1]*/
		var422 = var60 & 64'd2251799813685247;
		/*   br label %bb.i.i27.i.i.i_1*/
		cur_state = bb_i_i27_i_i_i_1;
	end
	bb_i_i27_i_i_i_1:
	begin
		/*   %not..i.i.i.i.i = icmp ne i64 %420, 0           ; <i1> [#uses=1]*/
		not__i_i_i_i_i = var422 != 64'd0;
		/*   br label %bb.i.i27.i.i.i_2*/
		cur_state = bb_i_i27_i_i_i_2;
	end
	bb_i_i27_i_i_i_2:
	begin
		/*   %retval.i.i.i.i.i = zext i1 %not..i.i.i.i.i to i32 ; <i32> [#uses=1]*/
		retval_i_i_i_i_i = not__i_i_i_i_i;
		/*   br label %float64_is_signaling_nan.exit.i.i.i.i*/
		var421 = retval_i_i_i_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit_i_i_i_i;
	end
	float64_is_signaling_nan_exit_i_i_i_i:
	begin
		/*   %421 = phi i32 [ %retval.i.i.i.i.i, %bb.i.i27.i.i.i_2 ], [ 0, %float64_is_signaling_nan.exit16.i.i.i.i_2 ] ; <i32> [#uses=2]*/

		/*   %422 = or i64 %app.0.i, 2251799813685248        ; <i64> [#uses=2]*/
		var423 = app_0_i | 64'd2251799813685248;
		/*   %423 = or i64 %217, 2251799813685248            ; <i64> [#uses=2]*/
		var424 = var60 | 64'd2251799813685248;
		/*   br label %float64_is_signaling_nan.exit.i.i.i.i_1*/
		cur_state = float64_is_signaling_nan_exit_i_i_i_i_1;
	end
	float64_is_signaling_nan_exit_i_i_i_i_1:
	begin
		/*   %424 = or i32 %421, %415                        ; <i32> [#uses=1]*/
		var425 = var421 | var415;
		/*   br label %float64_is_signaling_nan.exit.i.i.i.i_2*/
		cur_state = float64_is_signaling_nan_exit_i_i_i_i_2;
	end
	float64_is_signaling_nan_exit_i_i_i_i_2:
	begin
		/*   %425 = icmp eq i32 %424, 0                      ; <i1> [#uses=1]*/
		var426 = var425 == 32'd0;
		/*   br label %float64_is_signaling_nan.exit.i.i.i.i_3*/
		cur_state = float64_is_signaling_nan_exit_i_i_i_i_3;
	end
	float64_is_signaling_nan_exit_i_i_i_i_3:
	begin
		/*   br i1 %425, label %bb1.i28.i.i.i, label %bb.i.i.i15.i*/
		if (var426) begin
			cur_state = bb1_i28_i_i_i;
		end
		else begin
			cur_state = bb_i_i_i15_i;
		end
	end
	bb_i_i_i15_i:
	begin
		/*   %426 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb.i.i.i15.i_1*/
		cur_state = bb_i_i_i15_i_1;
	end
	bb_i_i_i15_i_1:
	begin
		var427 = memory_controller_out[31:0];
		/*   %load_noop15 = add i32 %426, 0                  ; <i32> [#uses=1]*/
		load_noop15 = var427 + 32'd0;
		/*   br label %bb.i.i.i15.i_2*/
		cur_state = bb_i_i_i15_i_2;
	end
	bb_i_i_i15_i_2:
	begin
		/*   %427 = or i32 %load_noop15, 16                  ; <i32> [#uses=1]*/
		var428 = load_noop15 | 32'd16;
		/*   br label %bb.i.i.i15.i_3*/
		cur_state = bb_i_i_i15_i_3;
	end
	bb_i_i_i15_i_3:
	begin
		/*   store i32 %427, i32* @float_exception_flags, align 4*/
		/*   br label %bb1.i28.i.i.i*/
		cur_state = bb1_i28_i_i_i;
	end
	bb1_i28_i_i_i:
	begin
		/*   %428 = icmp eq i32 %421, 0                      ; <i1> [#uses=1]*/
		var429 = var421 == 32'd0;
		/*   br label %bb1.i28.i.i.i_1*/
		cur_state = bb1_i28_i_i_i_1;
	end
	bb1_i28_i_i_i_1:
	begin
		/*   br i1 %428, label %bb2.i29.i.i.i, label %float64_add.exit.i*/
		if (var429) begin
			cur_state = bb2_i29_i_i_i;
		end
		else begin
			var237 = var424;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb2_i29_i_i_i:
	begin
		/*   %429 = icmp eq i32 %415, 0                      ; <i1> [#uses=1]*/
		var430 = var415 == 32'd0;
		/*   br label %bb2.i29.i.i.i_1*/
		cur_state = bb2_i29_i_i_i_1;
	end
	bb2_i29_i_i_i_1:
	begin
		/*   br i1 %429, label %bb3.i.i.i.i, label %float64_add.exit.i*/
		if (var430) begin
			cur_state = bb3_i_i_i_i;
		end
		else begin
			var237 = var423;   /* for PHI node */
			cur_state = float64_add_exit_i;
		end
	end
	bb3_i_i_i_i:
	begin
		/*   %iftmp.34.0.i.i.i.i = select i1 %418, i64 %423, i64 %422 ; <i64> [#uses=1]*/
		iftmp_34_0_i_i_i_i = (var419) ? var424 : var423;
		/*   br label %float64_add.exit.i*/
		var237 = iftmp_34_0_i_i_i_i;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	bb20_i_i_i:
	begin
		/*   %430 = icmp eq i32 %228, 0                      ; <i1> [#uses=2]*/
		var431 = var228 == 32'd0;
		/*   %431 = add i32 %229, -1                         ; <i32> [#uses=1]*/
		var432 = var229 + -32'd1;
		/*   %432 = or i64 %343, 4611686018427387904         ; <i64> [#uses=1]*/
		var433 = var344 | 64'd4611686018427387904;
		/*   br label %bb20.i.i.i_1*/
		cur_state = bb20_i_i_i_1;
	end
	bb20_i_i_i_1:
	begin
		/*   %bSig.1.i.i.i = select i1 %430, i64 %343, i64 %432 ; <i64> [#uses=4]*/
		bSig_1_i_i_i = (var431) ? var344 : var433;
		/*   %expDiff.1.i.i.i = select i1 %430, i32 %431, i32 %229 ; <i32> [#uses=4]*/
		expDiff_1_i_i_i = (var431) ? var432 : var229;
		/*   br label %bb20.i.i.i_2*/
		cur_state = bb20_i_i_i_2;
	end
	bb20_i_i_i_2:
	begin
		/*   %433 = icmp eq i32 %expDiff.1.i.i.i, 0          ; <i1> [#uses=1]*/
		var434 = expDiff_1_i_i_i == 32'd0;
		/*   br label %bb20.i.i.i_3*/
		cur_state = bb20_i_i_i_3;
	end
	bb20_i_i_i_3:
	begin
		/*   br i1 %433, label %shift64RightJamming.exit.i.i.i, label %bb1.i.i.i16.i*/
		if (var434) begin
			z_0_i_i_i_i = bSig_1_i_i_i;   /* for PHI node */
			cur_state = shift64RightJamming_exit_i_i_i;
		end
		else begin
			cur_state = bb1_i_i_i16_i;
		end
	end
	bb1_i_i_i16_i:
	begin
		/*   %434 = icmp slt i32 %expDiff.1.i.i.i, 64        ; <i1> [#uses=1]*/
		var435 = $signed(expDiff_1_i_i_i) < $signed(32'd64);
		/*   br label %bb1.i.i.i16.i_1*/
		cur_state = bb1_i_i_i16_i_1;
	end
	bb1_i_i_i16_i_1:
	begin
		/*   br i1 %434, label %bb2.i.i.i.i, label %bb4.i.i.i.i*/
		if (var435) begin
			cur_state = bb2_i_i_i_i;
		end
		else begin
			cur_state = bb4_i_i_i_i;
		end
	end
	bb2_i_i_i_i:
	begin
		/*   %.cast.i26.i.i.i = zext i32 %expDiff.1.i.i.i to i64 ; <i64> [#uses=1]*/
		_cast_i26_i_i_i = expDiff_1_i_i_i;
		/*   %435 = sub i32 0, %expDiff.1.i.i.i              ; <i32> [#uses=1]*/
		var436 = 32'd0 - expDiff_1_i_i_i;
		/*   br label %bb2.i.i.i.i_1*/
		cur_state = bb2_i_i_i_i_1;
	end
	bb2_i_i_i_i_1:
	begin
		/*   %436 = lshr i64 %bSig.1.i.i.i, %.cast.i26.i.i.i ; <i64> [#uses=1]*/
		var437 = bSig_1_i_i_i >>> (_cast_i26_i_i_i % 64);
		/*   %437 = and i32 %435, 63                         ; <i32> [#uses=1]*/
		var438 = var436 & 32'd63;
		/*   br label %bb2.i.i.i.i_2*/
		cur_state = bb2_i_i_i_i_2;
	end
	bb2_i_i_i_i_2:
	begin
		/*   %.cast3.i.i.i.i = zext i32 %437 to i64          ; <i64> [#uses=1]*/
		_cast3_i_i_i_i = var438;
		/*   br label %bb2.i.i.i.i_3*/
		cur_state = bb2_i_i_i_i_3;
	end
	bb2_i_i_i_i_3:
	begin
		/*   %438 = shl i64 %bSig.1.i.i.i, %.cast3.i.i.i.i   ; <i64> [#uses=1]*/
		var439 = bSig_1_i_i_i <<< (_cast3_i_i_i_i % 64);
		/*   br label %bb2.i.i.i.i_4*/
		cur_state = bb2_i_i_i_i_4;
	end
	bb2_i_i_i_i_4:
	begin
		/*   %439 = icmp ne i64 %438, 0                      ; <i1> [#uses=1]*/
		var440 = var439 != 64'd0;
		/*   br label %bb2.i.i.i.i_5*/
		cur_state = bb2_i_i_i_i_5;
	end
	bb2_i_i_i_i_5:
	begin
		/*   %440 = zext i1 %439 to i64                      ; <i64> [#uses=1]*/
		var441 = var440;
		/*   br label %bb2.i.i.i.i_6*/
		cur_state = bb2_i_i_i_i_6;
	end
	bb2_i_i_i_i_6:
	begin
		/*   %441 = or i64 %440, %436                        ; <i64> [#uses=1]*/
		var442 = var441 | var437;
		/*   br label %shift64RightJamming.exit.i.i.i*/
		z_0_i_i_i_i = var442;   /* for PHI node */
		cur_state = shift64RightJamming_exit_i_i_i;
	end
	bb4_i_i_i_i:
	begin
		/*   %442 = icmp ne i64 %bSig.1.i.i.i, 0             ; <i1> [#uses=1]*/
		var443 = bSig_1_i_i_i != 64'd0;
		/*   br label %bb4.i.i.i.i_1*/
		cur_state = bb4_i_i_i_i_1;
	end
	bb4_i_i_i_i_1:
	begin
		/*   %443 = zext i1 %442 to i64                      ; <i64> [#uses=1]*/
		var444 = var443;
		/*   br label %shift64RightJamming.exit.i.i.i*/
		z_0_i_i_i_i = var444;   /* for PHI node */
		cur_state = shift64RightJamming_exit_i_i_i;
	end
	shift64RightJamming_exit_i_i_i:
	begin
		/*   %z.0.i.i.i.i = phi i64 [ %441, %bb2.i.i.i.i_6 ], [ %443, %bb4.i.i.i.i_1 ], [ %bSig.1.i.i.i, %bb20.i.i.i_3 ] ; <i64> [#uses=1]*/

		/*   %444 = or i64 %342, 4611686018427387904         ; <i64> [#uses=1]*/
		var445 = var343 | 64'd4611686018427387904;
		/*   br label %aBigger.i.i.i*/
		aSig_2_i_i_i = var445;   /* for PHI node */
		bSig_2_i_i_i = z_0_i_i_i_i;   /* for PHI node */
		aExp_1_i_i_i = var225;   /* for PHI node */
		cur_state = aBigger_i_i_i;
	end
	aBigger_i_i_i:
	begin
		/*   %aSig.2.i.i.i = phi i64 [ %444, %shift64RightJamming.exit.i.i.i ], [ %342, %bb7.i.i12.i_1 ] ; <i64> [#uses=1]*/

		/*   %bSig.2.i.i.i = phi i64 [ %z.0.i.i.i.i, %shift64RightJamming.exit.i.i.i ], [ %343, %bb7.i.i12.i_1 ] ; <i64> [#uses=1]*/

		/*   %aExp.1.i.i.i = phi i32 [ %225, %shift64RightJamming.exit.i.i.i ], [ %aExp.0.i.i.i, %bb7.i.i12.i_1 ] ; <i32> [#uses=1]*/

		/*   br label %aBigger.i.i.i_1*/
		cur_state = aBigger_i_i_i_1;
	end
	aBigger_i_i_i_1:
	begin
		/*   %445 = sub i64 %aSig.2.i.i.i, %bSig.2.i.i.i     ; <i64> [#uses=1]*/
		var446 = aSig_2_i_i_i - bSig_2_i_i_i;
		/*   br label %normalizeRoundAndPack.i.i.i*/
		zExp_0_i_i_i = aExp_1_i_i_i;   /* for PHI node */
		zSig_0_i_i_i = var446;   /* for PHI node */
		zSign_addr_0_i_i_i = var220;   /* for PHI node */
		cur_state = normalizeRoundAndPack_i_i_i;
	end
	normalizeRoundAndPack_i_i_i:
	begin
		/*   %zExp.0.i.i.i = phi i32 [ %aExp.1.i.i.i, %aBigger.i.i.i_1 ], [ %bExp.1.i.i.i, %bBigger.i.i.i_1 ] ; <i32> [#uses=1]*/

		/*   %zSig.0.i.i.i = phi i64 [ %445, %aBigger.i.i.i_1 ], [ %409, %bBigger.i.i.i_1 ] ; <i64> [#uses=4]*/

		/*   %zSign_addr.0.i.i.i = phi i32 [ %220, %aBigger.i.i.i_1 ], [ %408, %bBigger.i.i.i_1 ] ; <i32> [#uses=1]*/

		/*   br label %normalizeRoundAndPack.i.i.i_1*/
		cur_state = normalizeRoundAndPack_i_i_i_1;
	end
	normalizeRoundAndPack_i_i_i_1:
	begin
		/*   %446 = icmp ult i64 %zSig.0.i.i.i, 4294967296   ; <i1> [#uses=1]*/
		var447 = zSig_0_i_i_i < 64'd4294967296;
		/*   br label %normalizeRoundAndPack.i.i.i_2*/
		cur_state = normalizeRoundAndPack_i_i_i_2;
	end
	normalizeRoundAndPack_i_i_i_2:
	begin
		/*   br i1 %446, label %bb.i.i.i.i.i, label %bb1.i.i.i.i.i*/
		if (var447) begin
			cur_state = bb_i_i_i_i_i;
		end
		else begin
			cur_state = bb1_i_i_i_i_i;
		end
	end
	bb_i_i_i_i_i:
	begin
		/*   %extract.t.i.i.i.i.i = trunc i64 %zSig.0.i.i.i to i32 ; <i32> [#uses=1]*/
		extract_t_i_i_i_i_i = zSig_0_i_i_i[31:0];
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i*/
		shiftCount_0_i_i_i_i17_i = 32'd31;   /* for PHI node */
		a_addr_0_off0_i_i_i_i_i = extract_t_i_i_i_i_i;   /* for PHI node */
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i;
	end
	bb1_i_i_i_i_i:
	begin
		/*   %447 = lshr i64 %zSig.0.i.i.i, 32               ; <i64> [#uses=1]*/
		var448 = zSig_0_i_i_i >>> (64'd32 % 64);
		/*   br label %bb1.i.i.i.i.i_1*/
		cur_state = bb1_i_i_i_i_i_1;
	end
	bb1_i_i_i_i_i_1:
	begin
		/*   %extract.t4.i.i.i.i.i = trunc i64 %447 to i32   ; <i32> [#uses=1]*/
		extract_t4_i_i_i_i_i = var448[31:0];
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i*/
		shiftCount_0_i_i_i_i17_i = -32'd1;   /* for PHI node */
		a_addr_0_off0_i_i_i_i_i = extract_t4_i_i_i_i_i;   /* for PHI node */
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i:
	begin
		/*   %shiftCount.0.i.i.i.i17.i = phi i32 [ 31, %bb.i.i.i.i.i ], [ -1, %bb1.i.i.i.i.i_1 ] ; <i32> [#uses=1]*/

		/*   %a_addr.0.off0.i.i.i.i.i = phi i32 [ %extract.t.i.i.i.i.i, %bb.i.i.i.i.i ], [ %extract.t4.i.i.i.i.i, %bb1.i.i.i.i.i_1 ] ; <i32> [#uses=3]*/

		/*   %448 = add i32 %zExp.0.i.i.i, -1                ; <i32> [#uses=1]*/
		var449 = zExp_0_i_i_i + -32'd1;
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_1*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_1;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_1:
	begin
		/*   %449 = shl i32 %a_addr.0.off0.i.i.i.i.i, 16     ; <i32> [#uses=1]*/
		var450 = a_addr_0_off0_i_i_i_i_i <<< (32'd16 % 32);
		/*   %450 = icmp ult i32 %a_addr.0.off0.i.i.i.i.i, 65536 ; <i1> [#uses=2]*/
		var451 = a_addr_0_off0_i_i_i_i_i < 32'd65536;
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_2*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_2;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_2:
	begin
		/*   %.a.i.i.i.i.i.i = select i1 %450, i32 %449, i32 %a_addr.0.off0.i.i.i.i.i ; <i32> [#uses=3]*/
		_a_i_i_i_i_i_i = (var451) ? var450 : a_addr_0_off0_i_i_i_i_i;
		/*   %shiftCount.0.i.i.i.i.i.i = select i1 %450, i32 16, i32 0 ; <i32> [#uses=2]*/
		shiftCount_0_i_i_i_i_i_i = (var451) ? 32'd16 : 32'd0;
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_3*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_3;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_3:
	begin
		/*   %451 = icmp ult i32 %.a.i.i.i.i.i.i, 16777216   ; <i1> [#uses=2]*/
		var452 = _a_i_i_i_i_i_i < 32'd16777216;
		/*   %452 = or i32 %shiftCount.0.i.i.i.i.i.i, 8      ; <i32> [#uses=1]*/
		var453 = shiftCount_0_i_i_i_i_i_i | 32'd8;
		/*   %453 = shl i32 %.a.i.i.i.i.i.i, 8               ; <i32> [#uses=1]*/
		var454 = _a_i_i_i_i_i_i <<< (32'd8 % 32);
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_4*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_4;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_4:
	begin
		/*   %shiftCount.1.i.i.i.i.i.i = select i1 %451, i32 %452, i32 %shiftCount.0.i.i.i.i.i.i ; <i32> [#uses=1]*/
		shiftCount_1_i_i_i_i_i_i = (var452) ? var453 : shiftCount_0_i_i_i_i_i_i;
		/*   %a_addr.1.i.i.i.i.i.i = select i1 %451, i32 %453, i32 %.a.i.i.i.i.i.i ; <i32> [#uses=1]*/
		a_addr_1_i_i_i_i_i_i = (var452) ? var454 : _a_i_i_i_i_i_i;
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_5*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_5;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_5:
	begin
		/*   %454 = lshr i32 %a_addr.1.i.i.i.i.i.i, 24       ; <i32> [#uses=1]*/
		var455 = a_addr_1_i_i_i_i_i_i >>> (32'd24 % 32);
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_6*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_6;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_6:
	begin
		/*   %455 = getelementptr inbounds [256 x i32]* @countLeadingZerosHigh.1302, i32 0, i32 %454 ; <i32*> [#uses=1]*/
		var456 = {`TAG_countLeadingZerosHigh_1302, 32'b0} + ((var455 + 256*(32'd0)) << 2);
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_7*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_7;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_7:
	begin
		/*   %456 = load i32* %455, align 4                  ; <i32> [#uses=1]*/
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_8*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_8;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_8:
	begin
		var457 = memory_controller_out[31:0];
		/*   %load_noop16 = add i32 %456, 0                  ; <i32> [#uses=1]*/
		load_noop16 = var457 + 32'd0;
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_9*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_9;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_9:
	begin
		/*   %457 = add nsw i32 %load_noop16, %shiftCount.0.i.i.i.i17.i ; <i32> [#uses=1]*/
		var458 = load_noop16 + shiftCount_0_i_i_i_i17_i;
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_10*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_10;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_10:
	begin
		/*   %458 = add i32 %457, %shiftCount.1.i.i.i.i.i.i  ; <i32> [#uses=2]*/
		var459 = var458 + shiftCount_1_i_i_i_i_i_i;
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_11*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_11;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_11:
	begin
		/*   %.cast.i.i.i.i = zext i32 %458 to i64           ; <i64> [#uses=1]*/
		_cast_i_i_i_i = var459;
		/*   %459 = sub i32 %448, %458                       ; <i32> [#uses=1]*/
		var460 = var449 - var459;
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_12*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_12;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_12:
	begin
		/*   %460 = shl i64 %zSig.0.i.i.i, %.cast.i.i.i.i    ; <i64> [#uses=1]*/
		var461 = zSig_0_i_i_i <<< (_cast_i_i_i_i % 64);
		/*   br label %normalizeRoundAndPackFloat64.exit.i.i.i_13*/
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_13;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_13:
	begin
		/*   %461 = tail call fastcc i64 @roundAndPackFloat64(i32 %zSign_addr.0.i.i.i, i32 %459, i64 %460) nounwind ; <i64> [#uses=1]*/
		roundAndPackFloat64_start = 1;
		/* Argument:   %zSign_addr.0.i.i.i = phi i32 [ %220, %aBigger.i.i.i_1 ], [ %408, %bBigger.i.i.i_1 ] ; <i32> [#uses=1]*/
		roundAndPackFloat64_zSign = zSign_addr_0_i_i_i;
		/* Argument:   %459 = sub i32 %448, %458                       ; <i32> [#uses=1]*/
		roundAndPackFloat64_zExp = var460;
		/* Argument:   %460 = shl i64 %zSig.0.i.i.i, %.cast.i.i.i.i    ; <i64> [#uses=1]*/
		roundAndPackFloat64_zSig = var461;
		cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_13_call_0;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_13_call_0:
	begin
		roundAndPackFloat64_start = 0;
		if (roundAndPackFloat64_finish == 1)
			begin
			var462 = roundAndPackFloat64_return_val;
			cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_13_call_1;
			end
		else
			cur_state = normalizeRoundAndPackFloat64_exit_i_i_i_13_call_0;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_13_call_1:
	begin
		/*   br label %float64_add.exit.i*/
		var237 = var462;   /* for PHI node */
		cur_state = float64_add_exit_i;
	end
	float64_add_exit_i:
	begin
		/*   %462 = phi i64 [ %461, %normalizeRoundAndPackFloat64.exit.i.i.i_13 ], [ %iftmp.34.0.i64.i.i.i, %bb3.i65.i.i.i ], [ 9223372036854775807, %bb4.i.i11.i_3 ], [ %iftmp.34.0.i48.i.i.i, %bb3.i49.i.i.i ], [ %392, %bb12.i.i.i_3 ], [ %iftmp.34.0.i.i.i.i, %bb3.i.i.i.i ], [ %338, %roundAndPack.i.i.i_1 ], [ %331, %bb22.i.i.i_1 ], [ %iftmp.34.0.i.i51.i.i, %bb3.i.i52.i.i ], [ %iftmp.34.0.i41.i.i.i, %bb3.i42.i.i.i ], [ %291, %bb12.i29.i.i_1 ], [ %iftmp.34.0.i64.i18.i.i, %bb3.i65.i19.i.i ], [ %247, %bb2.i63.i17.i.i_1 ], [ %248, %bb1.i62.i16.i.i_1 ], [ %282, %bb2.i40.i.i.i_1 ], [ %283, %bb1.i39.i.i.i_1 ], [ %319, %bb2.i.i50.i.i_1 ], [ %320, %bb1.i.i49.i.i_1 ], [ %app.0.i, %bb18.i39.i.i_2 ], [ %app.0.i, %bb1.i5.i.i_1 ], [ 0, %bb8.i.i13.i_1 ], [ %357, %bb2.i63.i.i.i_1 ], [ %358, %bb1.i62.i.i.i_1 ], [ %381, %bb2.i47.i.i.i_1 ], [ %382, %bb1.i46.i.i.i_1 ], [ %422, %bb2.i29.i.i.i_1 ], [ %423, %bb1.i28.i.i.i_1 ], [ %app.0.i, %bb17.i.i.i_1 ] ; <i64> [#uses=4]*/

		/*   %463 = add nsw i32 %inc.0.i, 1                  ; <i32> [#uses=1]*/
		var463 = inc_0_i + 32'd1;
		/*   %464 = and i64 %217, 9223372036854775807        ; <i64> [#uses=1]*/
		var464 = var60 & 64'd9223372036854775807;
		/*   %465 = and i64 %217, 9218868437227405312        ; <i64> [#uses=1]*/
		var465 = var60 & 64'd9218868437227405312;
		/*   br label %float64_add.exit.i_1*/
		cur_state = float64_add_exit_i_1;
	end
	float64_add_exit_i_1:
	begin
		/*   %466 = icmp eq i64 %465, 9218868437227405312    ; <i1> [#uses=1]*/
		var466 = var465 == 64'd9218868437227405312;
		/*   br label %float64_add.exit.i_2*/
		cur_state = float64_add_exit_i_2;
	end
	float64_add_exit_i_2:
	begin
		/*   br i1 %466, label %bb2.i.i.i, label %bb10.i.i.i*/
		if (var466) begin
			cur_state = bb2_i_i_i;
		end
		else begin
			cur_state = bb10_i_i_i;
		end
	end
	bb2_i_i_i:
	begin
		/*   %467 = and i64 %217, 4503599627370495           ; <i64> [#uses=1]*/
		var467 = var60 & 64'd4503599627370495;
		/*   br label %bb2.i.i.i_1*/
		cur_state = bb2_i_i_i_1;
	end
	bb2_i_i_i_1:
	begin
		/*   %468 = icmp eq i64 %467, 0                      ; <i1> [#uses=1]*/
		var468 = var467 == 64'd0;
		/*   br label %bb2.i.i.i_2*/
		cur_state = bb2_i_i_i_2;
	end
	bb2_i_i_i_2:
	begin
		/*   br i1 %468, label %bb10.i.i.i, label %bb3.i.i.i*/
		if (var468) begin
			cur_state = bb10_i_i_i;
		end
		else begin
			cur_state = bb3_i_i_i;
		end
	end
	bb3_i_i_i:
	begin
		/*   %469 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb3.i.i.i_1*/
		cur_state = bb3_i_i_i_1;
	end
	bb3_i_i_i_1:
	begin
		var469 = memory_controller_out[31:0];
		/*   %load_noop17 = add i32 %469, 0                  ; <i32> [#uses=1]*/
		load_noop17 = var469 + 32'd0;
		/*   br label %bb3.i.i.i_2*/
		cur_state = bb3_i_i_i_2;
	end
	bb3_i_i_i_2:
	begin
		/*   %470 = or i32 %load_noop17, 16                  ; <i32> [#uses=1]*/
		var470 = load_noop17 | 32'd16;
		/*   br label %bb3.i.i.i_3*/
		cur_state = bb3_i_i_i_3;
	end
	bb3_i_i_i_3:
	begin
		/*   store i32 %470, i32* @float_exception_flags, align 4*/
		/*   br label %sin.exit*/
		cur_state = sin_exit;
	end
	bb10_i_i_i:
	begin
		/*   %or.cond.i = icmp ult i64 %464, 4532020583610935537 ; <i1> [#uses=1]*/
		or_cond_i = var464 < 64'd4532020583610935537;
		/*   %indvar.next.i = add i32 %indvar.i, 1           ; <i32> [#uses=1]*/
		indvar_next_i = indvar_i + 32'd1;
		/*   br label %bb10.i.i.i_1*/
		cur_state = bb10_i_i_i_1;
	end
	bb10_i_i_i_1:
	begin
		/*   br i1 %or.cond.i, label %sin.exit, label %bb.i*/
		if (or_cond_i) begin
			cur_state = sin_exit;
		end
		else begin
			indvar_i = indvar_next_i;   /* for PHI node */
			inc_0_i = var463;   /* for PHI node */
			diff_0_i = var60;   /* for PHI node */
			app_0_i = var237;   /* for PHI node */
			cur_state = bb_i;
		end
	end
	sin_exit:
	begin
		/*   %471 = load i64* %scevgep9, align 8             ; <i64> [#uses=1]*/
		/*   %472 = bitcast i64 %462 to double               ; <double> [#uses=1]*/
		var471 = var237;
		/*   %473 = add nsw i32 %i.04, 1                     ; <i32> [#uses=2]*/
		var472 = i_04 + 32'd1;
		/*   br label %sin.exit_1*/
		cur_state = sin_exit_1;
	end
	sin_exit_1:
	begin
		var473 = memory_controller_out[63:0];
		/*   %load_noop18 = add i64 %471, 0                  ; <i64> [#uses=2]*/
		load_noop18 = var473 + 64'd0;
		/*   %exitcond = icmp eq i32 %473, 36                ; <i1> [#uses=1]*/
		exitcond = var472 == 32'd36;
		/*   br label %sin.exit_2*/
		cur_state = sin_exit_2;
	end
	sin_exit_2:
	begin
		/*   %474 = icmp ne i64 %load_noop18, %462           ; <i1> [#uses=1]*/
		var474 = load_noop18 != var237;
		/*   %475 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([53 x i8]* @.str, i32 0, i32 0), i64 %load_noop, i64 %load_noop18, i64 %462, double %472) nounwind ; <i32> [#uses=0]*/
		$write("input=%016h expected=%016h output=%016h (%h)\n", load_noop, load_noop18, var237, var471);		/*   br label %sin.exit_3*/
		cur_state = sin_exit_3;
	end
	sin_exit_3:
	begin
		/*   %476 = zext i1 %474 to i32                      ; <i32> [#uses=1]*/
		var475 = var474;
		/*   br label %sin.exit_4*/
		cur_state = sin_exit_4;
	end
	sin_exit_4:
	begin
		/*   %477 = add nsw i32 %476, %main_result.08        ; <i32> [#uses=3]*/
		var476 = var475 + main_result_08;
		/*   br i1 %exitcond, label %bb2, label %bb*/
		if (exitcond) begin
			cur_state = bb2;
		end
		else begin
			main_result_08 = var476;   /* for PHI node */
			i_04 = var472;   /* for PHI node */
			cur_state = bb;
		end
	end
	bb2:
	begin
		/*   %478 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %477) nounwind ; <i32> [#uses=0]*/
		$write("%d\n", var476);		/*   ret i32 %477*/
		return_val = var476;
		finish = 1;
		cur_state = Wait;
	end
endcase
always @(*)
begin
	memory_controller_write_enable = 0;
	memory_controller_address = 0;
	memory_controller_in = 0;
		float64_mul_memory_controller_out = 0;
		float64_mul_memory_controller_out = 0;
		roundAndPackFloat64_memory_controller_out = 0;
		roundAndPackFloat64_memory_controller_out = 0;
		roundAndPackFloat64_memory_controller_out = 0;
	case(cur_state)
	default:
	begin
		// quartus issues a warning if we have no default case
	end
	bb_2:
	begin
		memory_controller_address = scevgep;
		memory_controller_write_enable = 0;
	end
	bb_4:
	begin
	end
	bb_4_call_0:
	begin
		memory_controller_address = float64_mul_memory_controller_address;
		memory_controller_write_enable = float64_mul_memory_controller_write_enable;
		memory_controller_in = float64_mul_memory_controller_in;
		float64_mul_memory_controller_out = memory_controller_out;
	end
	bb_4_call_1:
	begin
	end
	bb1_i_i_9:
	begin
		memory_controller_address = var19;
		memory_controller_write_enable = 0;
	end
	int32_to_float64_exit_i:
	begin
	end
	int32_to_float64_exit_i_call_0:
	begin
		memory_controller_address = float64_mul_memory_controller_address;
		memory_controller_write_enable = float64_mul_memory_controller_write_enable;
		memory_controller_in = float64_mul_memory_controller_in;
		float64_mul_memory_controller_out = memory_controller_out;
	end
	int32_to_float64_exit_i_call_1:
	begin
	end
	bb_i71_i_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb_i71_i_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var58;
	end
	bb_i55_i_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb_i55_i_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var79;
	end
	bb5_i_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb5_i_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var83;
	end
	bb_i_i_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb_i_i_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var102;
	end
	bb13_i_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb14_i_i_1:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var111;
	end
	bb15_i_i_1:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var112;
	end
	normalizeFloat64Subnormal_exit42_i_i_7:
	begin
		memory_controller_address = var123;
		memory_controller_write_enable = 0;
	end
	normalizeFloat64Subnormal_exit_i_i_7:
	begin
		memory_controller_address = var141;
		memory_controller_write_enable = 0;
	end
	bb28_i_i_1:
	begin
	end
	bb28_i_i_1_call_0:
	begin
		memory_controller_address = roundAndPackFloat64_memory_controller_address;
		memory_controller_write_enable = roundAndPackFloat64_memory_controller_write_enable;
		memory_controller_in = roundAndPackFloat64_memory_controller_in;
		roundAndPackFloat64_memory_controller_out = memory_controller_out;
	end
	bb28_i_i_1_call_1:
	begin
	end
	bb_i61_i15_i_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb_i61_i15_i_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var253;
	end
	bb_i38_i_i_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb_i38_i_i_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var288;
	end
	bb_i_i48_i_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb_i_i48_i_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var325;
	end
	roundAndPack_i_i_i_1:
	begin
	end
	roundAndPack_i_i_i_1_call_0:
	begin
		memory_controller_address = roundAndPackFloat64_memory_controller_address;
		memory_controller_write_enable = roundAndPackFloat64_memory_controller_write_enable;
		memory_controller_in = roundAndPackFloat64_memory_controller_in;
		roundAndPackFloat64_memory_controller_out = memory_controller_out;
	end
	roundAndPack_i_i_i_1_call_1:
	begin
	end
	bb_i61_i_i_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb_i61_i_i_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var363;
	end
	bb4_i_i11_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb4_i_i11_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var367;
	end
	bb_i45_i_i_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb_i45_i_i_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var387;
	end
	bb_i_i_i15_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb_i_i_i15_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var428;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_7:
	begin
		memory_controller_address = var456;
		memory_controller_write_enable = 0;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_13:
	begin
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_13_call_0:
	begin
		memory_controller_address = roundAndPackFloat64_memory_controller_address;
		memory_controller_write_enable = roundAndPackFloat64_memory_controller_write_enable;
		memory_controller_in = roundAndPackFloat64_memory_controller_in;
		roundAndPackFloat64_memory_controller_out = memory_controller_out;
	end
	normalizeRoundAndPackFloat64_exit_i_i_i_13_call_1:
	begin
	end
	bb3_i_i_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb3_i_i_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var470;
	end
	sin_exit:
	begin
		memory_controller_address = scevgep9;
		memory_controller_write_enable = 0;
	end
	endcase
end
endmodule