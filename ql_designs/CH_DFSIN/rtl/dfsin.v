`timescale 1 ns / 1 ns
module memory_controller
(
	clk,
	memory_controller_address,
	memory_controller_write_enable,
	memory_controller_in,
	memory_controller_out
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

input clk;
input [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] memory_controller_address;
input memory_controller_write_enable;
input [`MEMORY_CONTROLLER_DATA_SIZE-1:0] memory_controller_in;
output reg [`MEMORY_CONTROLLER_DATA_SIZE-1:0] memory_controller_out;


reg [7:0] countLeadingZerosHigh_1302_address;
reg countLeadingZerosHigh_1302_write_enable;
reg [31:0] countLeadingZerosHigh_1302_in;
wire [31:0] countLeadingZerosHigh_1302_out;

ram_one_port countLeadingZerosHigh_1302 (
	.clk( clk ),
	.address( countLeadingZerosHigh_1302_address ),
	.write_enable( countLeadingZerosHigh_1302_write_enable ),
	.data( countLeadingZerosHigh_1302_in ),
	.q( countLeadingZerosHigh_1302_out )
);
defparam countLeadingZerosHigh_1302.width_a = 32;
defparam countLeadingZerosHigh_1302.widthad_a = 8;
defparam countLeadingZerosHigh_1302.numwords_a = 256;
defparam countLeadingZerosHigh_1302.init_file = "countLeadingZerosHigh_1302.mif";

reg [0:0] float_exception_flags_address;
reg float_exception_flags_write_enable;
reg [31:0] float_exception_flags_in;
wire [31:0] float_exception_flags_out;

ram_one_port float_exception_flags (
	.clk( clk ),
	.address( float_exception_flags_address ),
	.write_enable( float_exception_flags_write_enable ),
	.data( float_exception_flags_in ),
	.q( float_exception_flags_out )
);
defparam float_exception_flags.width_a = 32;
defparam float_exception_flags.widthad_a = 1;
defparam float_exception_flags.numwords_a = 1;
defparam float_exception_flags.init_file = "float_exception_flags.mif";

reg [5:0] test_in_address;
reg test_in_write_enable;
reg [63:0] test_in_in;
wire [63:0] test_in_out;

ram_one_port test_in (
	.clk( clk ),
	.address( test_in_address ),
	.write_enable( test_in_write_enable ),
	.data( test_in_in ),
	.q( test_in_out )
);
defparam test_in.width_a = 64;
defparam test_in.widthad_a = 6;
defparam test_in.numwords_a = 36;
defparam test_in.init_file = "test_in.mif";

reg [5:0] test_out_address;
reg test_out_write_enable;
reg [63:0] test_out_in;
wire [63:0] test_out_out;

ram_one_port test_out (
	.clk( clk ),
	.address( test_out_address ),
	.write_enable( test_out_write_enable ),
	.data( test_out_in ),
	.q( test_out_out )
);
defparam test_out.width_a = 64;
defparam test_out.widthad_a = 6;
defparam test_out.numwords_a = 36;
defparam test_out.init_file = "test_out.mif";

reg [5:0] _str_address;
reg _str_write_enable;
reg [7:0] _str_in;
wire [7:0] _str_out;

ram_one_port _str (
	.clk( clk ),
	.address( _str_address ),
	.write_enable( _str_write_enable ),
	.data( _str_in ),
	.q( _str_out )
);
defparam _str.width_a = 8;
defparam _str.widthad_a = 6;
defparam _str.numwords_a = 53;
defparam _str.init_file = "_str.mif";

reg [1:0] _str1_address;
reg _str1_write_enable;
reg [7:0] _str1_in;
wire [7:0] _str1_out;

ram_one_port _str1 (
	.clk( clk ),
	.address( _str1_address ),
	.write_enable( _str1_write_enable ),
	.data( _str1_in ),
	.q( _str1_out )
);
defparam _str1.width_a = 8;
defparam _str1.widthad_a = 2;
defparam _str1.numwords_a = 4;
defparam _str1.init_file = "_str1.mif";

reg [4:0] _str2_address;
reg _str2_write_enable;
reg [7:0] _str2_in;
wire [7:0] _str2_out;

ram_one_port _str2 (
	.clk( clk ),
	.address( _str2_address ),
	.write_enable( _str2_write_enable ),
	.data( _str2_in ),
	.q( _str2_out )
);
defparam _str2.width_a = 8;
defparam _str2.widthad_a = 5;
defparam _str2.numwords_a = 32;
defparam _str2.init_file = "_str2.mif";
wire [`MEMORY_CONTROLLER_TAG_SIZE-1:0] tag = memory_controller_address[`MEMORY_CONTROLLER_ADDR_SIZE-1:`MEMORY_CONTROLLER_ADDR_SIZE-`MEMORY_CONTROLLER_TAG_SIZE];
reg [`MEMORY_CONTROLLER_TAG_SIZE-1:0] prevTag;
always @(posedge clk)
	prevTag = tag;
always @(*)
begin
countLeadingZerosHigh_1302_address = 0;
countLeadingZerosHigh_1302_write_enable = 0;
countLeadingZerosHigh_1302_in = 0;
float_exception_flags_address = 0;
float_exception_flags_write_enable = 0;
float_exception_flags_in = 0;
test_in_address = 0;
test_in_write_enable = 0;
test_in_in = 0;
test_out_address = 0;
test_out_write_enable = 0;
test_out_in = 0;
_str_address = 0;
_str_write_enable = 0;
_str_in = 0;
_str1_address = 0;
_str1_write_enable = 0;
_str1_in = 0;
_str2_address = 0;
_str2_write_enable = 0;
_str2_in = 0;
case(tag)
	default:
	begin
		// quartus issues a warning if we have no default case
	end
	`TAG_countLeadingZerosHigh_1302:
	begin
		if (memory_controller_address[1:0] != 0)
		begin
			$display("Error: memory address not aligned to ram word size!");
			//$finish;
		end
		countLeadingZerosHigh_1302_address = memory_controller_address[8-1+2:2];
		countLeadingZerosHigh_1302_write_enable = memory_controller_write_enable;
		countLeadingZerosHigh_1302_in[32-1:0] = memory_controller_in[32-1:0];
	end
	`TAG_float_exception_flags:
	begin
		if (memory_controller_address[1:0] != 0)
		begin
			$display("Error: memory address not aligned to ram word size!");
			//$finish;
		end
		float_exception_flags_address = memory_controller_address[1-1+2:2];
		float_exception_flags_write_enable = memory_controller_write_enable;
		float_exception_flags_in[32-1:0] = memory_controller_in[32-1:0];
	end
	`TAG_test_in:
	begin
		if (memory_controller_address[2:0] != 0)
		begin
			$display("Error: memory address not aligned to ram word size!");
			//$finish;
		end
		test_in_address = memory_controller_address[6-1+3:3];
		test_in_write_enable = memory_controller_write_enable;
		test_in_in[64-1:0] = memory_controller_in[64-1:0];
	end
	`TAG_test_out:
	begin
		if (memory_controller_address[2:0] != 0)
		begin
			$display("Error: memory address not aligned to ram word size!");
			//$finish;
		end
		test_out_address = memory_controller_address[6-1+3:3];
		test_out_write_enable = memory_controller_write_enable;
		test_out_in[64-1:0] = memory_controller_in[64-1:0];
	end
	`TAG__str:
	begin
		_str_address = memory_controller_address[6-1+0:0];
		_str_write_enable = memory_controller_write_enable;
		_str_in[8-1:0] = memory_controller_in[8-1:0];
	end
	`TAG__str1:
	begin
		_str1_address = memory_controller_address[2-1+0:0];
		_str1_write_enable = memory_controller_write_enable;
		_str1_in[8-1:0] = memory_controller_in[8-1:0];
	end
	`TAG__str2:
	begin
		_str2_address = memory_controller_address[5-1+0:0];
		_str2_write_enable = memory_controller_write_enable;
		_str2_in[8-1:0] = memory_controller_in[8-1:0];
	end
endcase
memory_controller_out = 0;
case(prevTag)
	default:
	begin
		// quartus issues a warning if we have no default case
	end
	`TAG_countLeadingZerosHigh_1302:
		memory_controller_out = countLeadingZerosHigh_1302_out;
	`TAG_float_exception_flags:
		memory_controller_out = float_exception_flags_out;
	`TAG_test_in:
		memory_controller_out = test_in_out;
	`TAG_test_out:
		memory_controller_out = test_out_out;
	`TAG__str:
		memory_controller_out = _str_out;
	`TAG__str1:
		memory_controller_out = _str1_out;
	`TAG__str2:
		memory_controller_out = _str2_out;
endcase
end
endmodule 

`timescale 1 ns / 1 ns
module roundAndPackFloat64
	(
		clk,
		reset,
		start,
		finish,
		return_val,
		zSign,
		zExp,
		zSig,
		memory_controller_write_enable,
		memory_controller_address,
		memory_controller_in,
		memory_controller_out
	);

output reg [63:0] return_val;
input clk;
input reset;
input start;
output reg finish;
input [31:0] zSign;
input [31:0] zExp;
input [63:0] zSig;
output reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] memory_controller_address;
output reg memory_controller_write_enable;
output reg [`MEMORY_CONTROLLER_DATA_SIZE-1:0] memory_controller_in;
input wire [`MEMORY_CONTROLLER_DATA_SIZE-1:0] memory_controller_out;

reg [5:0] cur_state;

parameter Wait = 6'd0;
parameter bb7 = 6'd1;
parameter bb7_1 = 6'd2;
parameter bb7_2 = 6'd3;
parameter bb8 = 6'd4;
parameter bb8_1 = 6'd5;
parameter bb9 = 6'd6;
parameter bb9_1 = 6'd7;
parameter bb10 = 6'd8;
parameter bb10_1 = 6'd9;
parameter bb10_2 = 6'd10;
parameter bb11 = 6'd11;
parameter bb11_1 = 6'd12;
parameter bb11_2 = 6'd13;
parameter bb11_3 = 6'd14;
parameter bb12 = 6'd15;
parameter bb12_1 = 6'd16;
parameter bb13 = 6'd17;
parameter bb13_1 = 6'd18;
parameter bb1_i = 6'd19;
parameter bb1_i_1 = 6'd20;
parameter bb2_i = 6'd21;
parameter bb2_i_1 = 6'd22;
parameter bb2_i_2 = 6'd23;
parameter bb2_i_3 = 6'd24;
parameter bb2_i_4 = 6'd25;
parameter bb2_i_5 = 6'd26;
parameter bb4_i = 6'd27;
parameter bb4_i_1 = 6'd28;
parameter shift64RightJamming_exit = 6'd29;
parameter shift64RightJamming_exit_1 = 6'd30;
parameter shift64RightJamming_exit_2 = 6'd31;
parameter shift64RightJamming_exit_3 = 6'd32;
parameter shift64RightJamming_exit_4 = 6'd33;
parameter bb16 = 6'd34;
parameter bb16_1 = 6'd35;
parameter bb16_2 = 6'd36;
parameter bb16_3 = 6'd37;
parameter bb17 = 6'd38;
parameter bb17_1 = 6'd39;
parameter bb17_2 = 6'd40;
parameter bb18 = 6'd41;
parameter bb18_1 = 6'd42;
parameter bb18_2 = 6'd43;
parameter bb18_3 = 6'd44;
parameter bb19 = 6'd45;
parameter bb19_1 = 6'd46;
parameter bb19_2 = 6'd47;
parameter bb19_3 = 6'd48;
parameter bb19_4 = 6'd49;
parameter bb19_5 = 6'd50;
parameter bb19_6 = 6'd51;
parameter bb19_7 = 6'd52;
parameter bb19_8 = 6'd53;
reg [31:0] var0;
reg [15:0] var1;
reg [31:0] var2;
reg [63:0] z_0_i;
reg [31:0] var25;
reg [31:0] var26;
reg  var27;
reg [31:0] var28;
reg [31:0] var29;
reg [63:0] zSig_addr_0;
reg [31:0] roundBits_0;
reg [31:0] zExp_addr_0;
reg  var30;
reg [31:0] var31;
reg [31:0] var32;
reg  var3;
reg [31:0] var14;
reg  var15;
reg  var16;
reg [63:0] _cast_i;
reg [63:0] var18;
reg [31:0] var17;
reg [63:0] _cast3_i;
reg [63:0] var19;
reg  var20;
reg [63:0] var21;
reg [63:0] var22;
reg  var23;
reg [63:0] var24;
reg  var4;
reg  var5;
reg [63:0] var6;
reg  var7;
reg [31:0] var9;
reg [31:0] var11;
reg [63:0] var8;
reg [63:0] var10;
reg [63:0] var12;
reg  var13;
reg [63:0] var33;
reg [63:0] var37;
reg  var34;
reg [31:0] var38;
reg [31:0] not_var40;
reg [63:0] var41;
reg [63:0] var42;
reg  var43;
reg [63:0] var35;
reg [63:0] var39;
reg [63:0] var36;
reg [63:0] _op;
reg [63:0] var45;
reg [63:0] var44;
reg [63:0] var46;
reg [31:0] load_noop1;
reg [31:0] load_noop;
reg [31:0] load_noop2;

always @(posedge clk)
if (reset)
	cur_state = Wait;
else
case(cur_state)
	Wait:
	begin
		finish = 0;
		if (start == 1)
			cur_state = bb7;
		else
			cur_state = Wait;
	end
	bb7:
	begin
		/*   %0 = trunc i64 %zSig to i32                     ; <i32> [#uses=1]*/
		var0 = zSig[31:0];
		/*   %1 = trunc i32 %zExp to i16                     ; <i16> [#uses=1]*/
		var1 = zExp[15:0];
		/*   br label %bb7_1*/
		cur_state = bb7_1;
	end
	bb7_1:
	begin
		/*   %2 = and i32 %0, 1023                           ; <i32> [#uses=2]*/
		var2 = var0 & 32'd1023;
		/*   %3 = icmp ugt i16 %1, 2044                      ; <i1> [#uses=1]*/
		var3 = var1 > 16'd2044;
		/*   br label %bb7_2*/
		cur_state = bb7_2;
	end
	bb7_2:
	begin
		/*   br i1 %3, label %bb8, label %bb17*/
		if (var3) begin
			cur_state = bb8;
		end
		else begin
			zSig_addr_0 = zSig;   /* for PHI node */
			roundBits_0 = var2;   /* for PHI node */
			zExp_addr_0 = zExp;   /* for PHI node */
			cur_state = bb17;
		end
	end
	bb8:
	begin
		/*   %4 = icmp sgt i32 %zExp, 2045                   ; <i1> [#uses=1]*/
		var4 = $signed(zExp) > $signed(32'd2045);
		/*   br label %bb8_1*/
		cur_state = bb8_1;
	end
	bb8_1:
	begin
		/*   br i1 %4, label %bb11, label %bb9*/
		if (var4) begin
			cur_state = bb11;
		end
		else begin
			cur_state = bb9;
		end
	end
	bb9:
	begin
		/*   %5 = icmp eq i32 %zExp, 2045                    ; <i1> [#uses=1]*/
		var5 = zExp == 32'd2045;
		/*   br label %bb9_1*/
		cur_state = bb9_1;
	end
	bb9_1:
	begin
		/*   br i1 %5, label %bb10, label %bb12*/
		if (var5) begin
			cur_state = bb10;
		end
		else begin
			cur_state = bb12;
		end
	end
	bb10:
	begin
		/*   %6 = add i64 %zSig, 512                         ; <i64> [#uses=1]*/
		var6 = zSig + 64'd512;
		/*   br label %bb10_1*/
		cur_state = bb10_1;
	end
	bb10_1:
	begin
		/*   %7 = icmp slt i64 %6, 0                         ; <i1> [#uses=1]*/
		var7 = $signed(var6) < $signed(64'd0);
		/*   br label %bb10_2*/
		cur_state = bb10_2;
	end
	bb10_2:
	begin
		/*   br i1 %7, label %bb11, label %bb12*/
		if (var7) begin
			cur_state = bb11;
		end
		else begin
			cur_state = bb12;
		end
	end
	bb11:
	begin
		/*   %8 = load i32* @float_exception_flags, align 4  ; <i32> [#uses=1]*/
		/*   %9 = zext i32 %zSign to i64                     ; <i64> [#uses=1]*/
		var8 = zSign;
		/*   br label %bb11_1*/
		cur_state = bb11_1;
	end
	bb11_1:
	begin
		var9 = memory_controller_out[31:0];
		/*   %load_noop = add i32 %8, 0                      ; <i32> [#uses=1]*/
		load_noop = var9 + 32'd0;
		/*   %10 = shl i64 %9, 63                            ; <i64> [#uses=1]*/
		var10 = var8 <<< (64'd63 % 64);
		/*   br label %bb11_2*/
		cur_state = bb11_2;
	end
	bb11_2:
	begin
		/*   %11 = or i32 %load_noop, 9                      ; <i32> [#uses=1]*/
		var11 = load_noop | 32'd9;
		/*   %12 = or i64 %10, 9218868437227405312           ; <i64> [#uses=1]*/
		var12 = var10 | 64'd9218868437227405312;
		/*   br label %bb11_3*/
		cur_state = bb11_3;
	end
	bb11_3:
	begin
		/*   store i32 %11, i32* @float_exception_flags, align 4*/
		/*   ret i64 %12*/
		return_val = var12;
		finish = 1;
		cur_state = Wait;
	end
	bb12:
	begin
		/*   %13 = icmp slt i32 %zExp, 0                     ; <i1> [#uses=1]*/
		var13 = $signed(zExp) < $signed(32'd0);
		/*   br label %bb12_1*/
		cur_state = bb12_1;
	end
	bb12_1:
	begin
		/*   br i1 %13, label %bb13, label %bb17*/
		if (var13) begin
			cur_state = bb13;
		end
		else begin
			zSig_addr_0 = zSig;   /* for PHI node */
			roundBits_0 = var2;   /* for PHI node */
			zExp_addr_0 = zExp;   /* for PHI node */
			cur_state = bb17;
		end
	end
	bb13:
	begin
		/*   %14 = sub i32 0, %zExp                          ; <i32> [#uses=2]*/
		var14 = 32'd0 - zExp;
		/*   %15 = icmp eq i32 %zExp, 0                      ; <i1> [#uses=1]*/
		var15 = zExp == 32'd0;
		/*   br label %bb13_1*/
		cur_state = bb13_1;
	end
	bb13_1:
	begin
		/*   br i1 %15, label %shift64RightJamming.exit, label %bb1.i*/
		if (var15) begin
			z_0_i = zSig;   /* for PHI node */
			cur_state = shift64RightJamming_exit;
		end
		else begin
			cur_state = bb1_i;
		end
	end
	bb1_i:
	begin
		/*   %16 = icmp slt i32 %14, 64                      ; <i1> [#uses=1]*/
		var16 = $signed(var14) < $signed(32'd64);
		/*   br label %bb1.i_1*/
		cur_state = bb1_i_1;
	end
	bb1_i_1:
	begin
		/*   br i1 %16, label %bb2.i, label %bb4.i*/
		if (var16) begin
			cur_state = bb2_i;
		end
		else begin
			cur_state = bb4_i;
		end
	end
	bb2_i:
	begin
		/*   %.cast.i = zext i32 %14 to i64                  ; <i64> [#uses=1]*/
		_cast_i = var14;
		/*   %17 = and i32 %zExp, 63                         ; <i32> [#uses=1]*/
		var17 = zExp & 32'd63;
		/*   br label %bb2.i_1*/
		cur_state = bb2_i_1;
	end
	bb2_i_1:
	begin
		/*   %18 = lshr i64 %zSig, %.cast.i                  ; <i64> [#uses=1]*/
		var18 = zSig >>> (_cast_i % 64);
		/*   %.cast3.i = zext i32 %17 to i64                 ; <i64> [#uses=1]*/
		_cast3_i = var17;
		/*   br label %bb2.i_2*/
		cur_state = bb2_i_2;
	end
	bb2_i_2:
	begin
		/*   %19 = shl i64 %zSig, %.cast3.i                  ; <i64> [#uses=1]*/
		var19 = zSig <<< (_cast3_i % 64);
		/*   br label %bb2.i_3*/
		cur_state = bb2_i_3;
	end
	bb2_i_3:
	begin
		/*   %20 = icmp ne i64 %19, 0                        ; <i1> [#uses=1]*/
		var20 = var19 != 64'd0;
		/*   br label %bb2.i_4*/
		cur_state = bb2_i_4;
	end
	bb2_i_4:
	begin
		/*   %21 = zext i1 %20 to i64                        ; <i64> [#uses=1]*/
		var21 = var20;
		/*   br label %bb2.i_5*/
		cur_state = bb2_i_5;
	end
	bb2_i_5:
	begin
		/*   %22 = or i64 %21, %18                           ; <i64> [#uses=1]*/
		var22 = var21 | var18;
		/*   br label %shift64RightJamming.exit*/
		z_0_i = var22;   /* for PHI node */
		cur_state = shift64RightJamming_exit;
	end
	bb4_i:
	begin
		/*   %23 = icmp ne i64 %zSig, 0                      ; <i1> [#uses=1]*/
		var23 = zSig != 64'd0;
		/*   br label %bb4.i_1*/
		cur_state = bb4_i_1;
	end
	bb4_i_1:
	begin
		/*   %24 = zext i1 %23 to i64                        ; <i64> [#uses=1]*/
		var24 = var23;
		/*   br label %shift64RightJamming.exit*/
		z_0_i = var24;   /* for PHI node */
		cur_state = shift64RightJamming_exit;
	end
	shift64RightJamming_exit:
	begin
		/*   %z.0.i = phi i64 [ %22, %bb2.i_5 ], [ %24, %bb4.i_1 ], [ %zSig, %bb13_1 ] ; <i64> [#uses=3]*/

		/*   br label %shift64RightJamming.exit_1*/
		cur_state = shift64RightJamming_exit_1;
	end
	shift64RightJamming_exit_1:
	begin
		/*   %25 = trunc i64 %z.0.i to i32                   ; <i32> [#uses=1]*/
		var25 = z_0_i[31:0];
		/*   br label %shift64RightJamming.exit_2*/
		cur_state = shift64RightJamming_exit_2;
	end
	shift64RightJamming_exit_2:
	begin
		/*   %26 = and i32 %25, 1023                         ; <i32> [#uses=3]*/
		var26 = var25 & 32'd1023;
		/*   br label %shift64RightJamming.exit_3*/
		cur_state = shift64RightJamming_exit_3;
	end
	shift64RightJamming_exit_3:
	begin
		/*   %27 = icmp eq i32 %26, 0                        ; <i1> [#uses=1]*/
		var27 = var26 == 32'd0;
		/*   br label %shift64RightJamming.exit_4*/
		cur_state = shift64RightJamming_exit_4;
	end
	shift64RightJamming_exit_4:
	begin
		/*   br i1 %27, label %bb17, label %bb16*/
		if (var27) begin
			zSig_addr_0 = z_0_i;   /* for PHI node */
			roundBits_0 = var26;   /* for PHI node */
			zExp_addr_0 = 32'd0;   /* for PHI node */
			cur_state = bb17;
		end
		else begin
			cur_state = bb16;
		end
	end
	bb16:
	begin
		/*   %28 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb16_1*/
		cur_state = bb16_1;
	end
	bb16_1:
	begin
		var28 = memory_controller_out[31:0];
		/*   %load_noop1 = add i32 %28, 0                    ; <i32> [#uses=1]*/
		load_noop1 = var28 + 32'd0;
		/*   br label %bb16_2*/
		cur_state = bb16_2;
	end
	bb16_2:
	begin
		/*   %29 = or i32 %load_noop1, 4                     ; <i32> [#uses=1]*/
		var29 = load_noop1 | 32'd4;
		/*   br label %bb16_3*/
		cur_state = bb16_3;
	end
	bb16_3:
	begin
		/*   store i32 %29, i32* @float_exception_flags, align 4*/
		/*   br label %bb17*/
		zSig_addr_0 = z_0_i;   /* for PHI node */
		roundBits_0 = var26;   /* for PHI node */
		zExp_addr_0 = 32'd0;   /* for PHI node */
		cur_state = bb17;
	end
	bb17:
	begin
		/*   %zSig_addr.0 = phi i64 [ %z.0.i, %shift64RightJamming.exit_4 ], [ %z.0.i, %bb16_3 ], [ %zSig, %bb12_1 ], [ %zSig, %bb7_2 ] ; <i64> [#uses=1]*/

		/*   %roundBits.0 = phi i32 [ %26, %shift64RightJamming.exit_4 ], [ %26, %bb16_3 ], [ %2, %bb12_1 ], [ %2, %bb7_2 ] ; <i32> [#uses=2]*/

		/*   %zExp_addr.0 = phi i32 [ 0, %shift64RightJamming.exit_4 ], [ 0, %bb16_3 ], [ %zExp, %bb12_1 ], [ %zExp, %bb7_2 ] ; <i32> [#uses=1]*/

		/*   br label %bb17_1*/
		cur_state = bb17_1;
	end
	bb17_1:
	begin
		/*   %30 = icmp eq i32 %roundBits.0, 0               ; <i1> [#uses=1]*/
		var30 = roundBits_0 == 32'd0;
		/*   br label %bb17_2*/
		cur_state = bb17_2;
	end
	bb17_2:
	begin
		/*   br i1 %30, label %bb19, label %bb18*/
		if (var30) begin
			cur_state = bb19;
		end
		else begin
			cur_state = bb18;
		end
	end
	bb18:
	begin
		/*   %31 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb18_1*/
		cur_state = bb18_1;
	end
	bb18_1:
	begin
		var31 = memory_controller_out[31:0];
		/*   %load_noop2 = add i32 %31, 0                    ; <i32> [#uses=1]*/
		load_noop2 = var31 + 32'd0;
		/*   br label %bb18_2*/
		cur_state = bb18_2;
	end
	bb18_2:
	begin
		/*   %32 = or i32 %load_noop2, 1                     ; <i32> [#uses=1]*/
		var32 = load_noop2 | 32'd1;
		/*   br label %bb18_3*/
		cur_state = bb18_3;
	end
	bb18_3:
	begin
		/*   store i32 %32, i32* @float_exception_flags, align 4*/
		/*   br label %bb19*/
		cur_state = bb19;
	end
	bb19:
	begin
		/*   %33 = add i64 %zSig_addr.0, 512                 ; <i64> [#uses=1]*/
		var33 = zSig_addr_0 + 64'd512;
		/*   %34 = icmp eq i32 %roundBits.0, 512             ; <i1> [#uses=1]*/
		var34 = roundBits_0 == 32'd512;
		/*   %35 = zext i32 %zSign to i64                    ; <i64> [#uses=1]*/
		var35 = zSign;
		/*   %36 = zext i32 %zExp_addr.0 to i64              ; <i64> [#uses=1]*/
		var36 = zExp_addr_0;
		/*   br label %bb19_1*/
		cur_state = bb19_1;
	end
	bb19_1:
	begin
		/*   %37 = lshr i64 %33, 10                          ; <i64> [#uses=1]*/
		var37 = var33 >>> (64'd10 % 64);
		/*   %38 = zext i1 %34 to i32                        ; <i32> [#uses=1]*/
		var38 = var34;
		/*   %39 = shl i64 %35, 63                           ; <i64> [#uses=1]*/
		var39 = var35 <<< (64'd63 % 64);
		/*   %.op = shl i64 %36, 52                          ; <i64> [#uses=1]*/
		_op = var36 <<< (64'd52 % 64);
		/*   br label %bb19_2*/
		cur_state = bb19_2;
	end
	bb19_2:
	begin
		/*   %not = xor i32 %38, -1                          ; <i32> [#uses=1]*/
		not_var40 = var38 ^ -32'd1;
		/*   br label %bb19_3*/
		cur_state = bb19_3;
	end
	bb19_3:
	begin
		/*   %40 = sext i32 %not to i64                      ; <i64> [#uses=1]*/
		var41 = $signed(not_var40);
		/*   br label %bb19_4*/
		cur_state = bb19_4;
	end
	bb19_4:
	begin
		/*   %41 = and i64 %40, %37                          ; <i64> [#uses=2]*/
		var42 = var41 & var37;
		/*   br label %bb19_5*/
		cur_state = bb19_5;
	end
	bb19_5:
	begin
		/*   %42 = icmp eq i64 %41, 0                        ; <i1> [#uses=1]*/
		var43 = var42 == 64'd0;
		/*   %43 = or i64 %41, %39                           ; <i64> [#uses=1]*/
		var44 = var42 | var39;
		/*   br label %bb19_6*/
		cur_state = bb19_6;
	end
	bb19_6:
	begin
		/*   %44 = select i1 %42, i64 0, i64 %.op            ; <i64> [#uses=1]*/
		var45 = (var43) ? 64'd0 : _op;
		/*   br label %bb19_7*/
		cur_state = bb19_7;
	end
	bb19_7:
	begin
		/*   %45 = add i64 %44, %43                          ; <i64> [#uses=1]*/
		var46 = var45 + var44;
		/*   br label %bb19_8*/
		cur_state = bb19_8;
	end
	bb19_8:
	begin
		/*   ret i64 %45*/
		return_val = var46;
		finish = 1;
		cur_state = Wait;
	end
endcase
always @(*)
begin
	memory_controller_write_enable = 0;
	memory_controller_address = 0;
	memory_controller_in = 0;
	case(cur_state)
	default:
	begin
		// quartus issues a warning if we have no default case
	end
	bb11:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb11_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var11;
	end
	bb16:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb16_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var29;
	end
	bb18:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb18_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var32;
	end
	endcase
end
endmodule
`timescale 1 ns / 1 ns
module float64_mul
	(
		clk,
		reset,
		start,
		finish,
		return_val,
		a,
		b,
		memory_controller_write_enable,
		memory_controller_address,
		memory_controller_in,
		memory_controller_out
	);

output reg [63:0] return_val;
input clk;
input reset;
input start;
output reg finish;
input [63:0] a;
input [63:0] b;
output reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] memory_controller_address;
output reg memory_controller_write_enable;
output reg [`MEMORY_CONTROLLER_DATA_SIZE-1:0] memory_controller_in;
input wire [`MEMORY_CONTROLLER_DATA_SIZE-1:0] memory_controller_out;


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
reg [7:0] cur_state;

parameter Wait = 8'd0;
parameter entry = 8'd1;
parameter entry_1 = 8'd2;
parameter entry_2 = 8'd3;
parameter entry_3 = 8'd4;
parameter entry_4 = 8'd5;
parameter bb = 8'd6;
parameter bb_1 = 8'd7;
parameter bb1 = 8'd8;
parameter bb1_1 = 8'd9;
parameter bb1_2 = 8'd10;
parameter bb4 = 8'd11;
parameter bb4_1 = 8'd12;
parameter bb4_2 = 8'd13;
parameter bb_i14_i42 = 8'd14;
parameter bb_i14_i42_1 = 8'd15;
parameter bb_i14_i42_2 = 8'd16;
parameter float64_is_signaling_nan_exit16_i43 = 8'd17;
parameter float64_is_signaling_nan_exit16_i43_1 = 8'd18;
parameter float64_is_signaling_nan_exit16_i43_2 = 8'd19;
parameter bb_i_i46 = 8'd20;
parameter bb_i_i46_1 = 8'd21;
parameter bb_i_i46_2 = 8'd22;
parameter float64_is_signaling_nan_exit_i47 = 8'd23;
parameter float64_is_signaling_nan_exit_i47_1 = 8'd24;
parameter float64_is_signaling_nan_exit_i47_2 = 8'd25;
parameter float64_is_signaling_nan_exit_i47_3 = 8'd26;
parameter bb_i48 = 8'd27;
parameter bb_i48_1 = 8'd28;
parameter bb_i48_2 = 8'd29;
parameter bb_i48_3 = 8'd30;
parameter bb1_i49 = 8'd31;
parameter bb1_i49_1 = 8'd32;
parameter bb2_i50 = 8'd33;
parameter bb2_i50_1 = 8'd34;
parameter bb3_i52 = 8'd35;
parameter bb3_i52_1 = 8'd36;
parameter propagateFloat64NaN_exit55 = 8'd37;
parameter propagateFloat64NaN_exit55_1 = 8'd38;
parameter bb5 = 8'd39;
parameter bb5_1 = 8'd40;
parameter bb5_2 = 8'd41;
parameter bb5_3 = 8'd42;
parameter bb6 = 8'd43;
parameter bb6_1 = 8'd44;
parameter bb6_2 = 8'd45;
parameter bb6_3 = 8'd46;
parameter bb7 = 8'd47;
parameter bb7_1 = 8'd48;
parameter bb7_2 = 8'd49;
parameter bb8 = 8'd50;
parameter bb8_1 = 8'd51;
parameter bb9 = 8'd52;
parameter bb9_1 = 8'd53;
parameter bb10 = 8'd54;
parameter bb10_1 = 8'd55;
parameter bb10_2 = 8'd56;
parameter bb_i14_i = 8'd57;
parameter bb_i14_i_1 = 8'd58;
parameter bb_i14_i_2 = 8'd59;
parameter float64_is_signaling_nan_exit16_i = 8'd60;
parameter float64_is_signaling_nan_exit16_i_1 = 8'd61;
parameter float64_is_signaling_nan_exit16_i_2 = 8'd62;
parameter bb_i_i39 = 8'd63;
parameter bb_i_i39_1 = 8'd64;
parameter bb_i_i39_2 = 8'd65;
parameter float64_is_signaling_nan_exit_i = 8'd66;
parameter float64_is_signaling_nan_exit_i_1 = 8'd67;
parameter float64_is_signaling_nan_exit_i_2 = 8'd68;
parameter float64_is_signaling_nan_exit_i_3 = 8'd69;
parameter bb_i = 8'd70;
parameter bb_i_1 = 8'd71;
parameter bb_i_2 = 8'd72;
parameter bb_i_3 = 8'd73;
parameter bb1_i = 8'd74;
parameter bb1_i_1 = 8'd75;
parameter bb2_i = 8'd76;
parameter bb2_i_1 = 8'd77;
parameter bb3_i = 8'd78;
parameter bb3_i_1 = 8'd79;
parameter propagateFloat64NaN_exit = 8'd80;
parameter propagateFloat64NaN_exit_1 = 8'd81;
parameter bb11 = 8'd82;
parameter bb11_1 = 8'd83;
parameter bb11_2 = 8'd84;
parameter bb11_3 = 8'd85;
parameter bb12 = 8'd86;
parameter bb12_1 = 8'd87;
parameter bb12_2 = 8'd88;
parameter bb12_3 = 8'd89;
parameter bb13 = 8'd90;
parameter bb13_1 = 8'd91;
parameter bb13_2 = 8'd92;
parameter bb14 = 8'd93;
parameter bb14_1 = 8'd94;
parameter bb15 = 8'd95;
parameter bb15_1 = 8'd96;
parameter bb16 = 8'd97;
parameter bb16_1 = 8'd98;
parameter bb17 = 8'd99;
parameter bb17_1 = 8'd100;
parameter bb_i_i28 = 8'd101;
parameter bb1_i_i30 = 8'd102;
parameter bb1_i_i30_1 = 8'd103;
parameter normalizeFloat64Subnormal_exit38 = 8'd104;
parameter normalizeFloat64Subnormal_exit38_1 = 8'd105;
parameter normalizeFloat64Subnormal_exit38_2 = 8'd106;
parameter normalizeFloat64Subnormal_exit38_3 = 8'd107;
parameter normalizeFloat64Subnormal_exit38_4 = 8'd108;
parameter normalizeFloat64Subnormal_exit38_5 = 8'd109;
parameter normalizeFloat64Subnormal_exit38_6 = 8'd110;
parameter normalizeFloat64Subnormal_exit38_7 = 8'd111;
parameter normalizeFloat64Subnormal_exit38_8 = 8'd112;
parameter normalizeFloat64Subnormal_exit38_9 = 8'd113;
parameter normalizeFloat64Subnormal_exit38_10 = 8'd114;
parameter normalizeFloat64Subnormal_exit38_11 = 8'd115;
parameter normalizeFloat64Subnormal_exit38_12 = 8'd116;
parameter normalizeFloat64Subnormal_exit38_13 = 8'd117;
parameter bb18 = 8'd118;
parameter bb18_1 = 8'd119;
parameter bb19 = 8'd120;
parameter bb19_1 = 8'd121;
parameter bb20 = 8'd122;
parameter bb20_1 = 8'd123;
parameter bb21 = 8'd124;
parameter bb21_1 = 8'd125;
parameter bb_i_i = 8'd126;
parameter bb1_i_i = 8'd127;
parameter bb1_i_i_1 = 8'd128;
parameter normalizeFloat64Subnormal_exit = 8'd129;
parameter normalizeFloat64Subnormal_exit_1 = 8'd130;
parameter normalizeFloat64Subnormal_exit_2 = 8'd131;
parameter normalizeFloat64Subnormal_exit_3 = 8'd132;
parameter normalizeFloat64Subnormal_exit_4 = 8'd133;
parameter normalizeFloat64Subnormal_exit_5 = 8'd134;
parameter normalizeFloat64Subnormal_exit_6 = 8'd135;
parameter normalizeFloat64Subnormal_exit_7 = 8'd136;
parameter normalizeFloat64Subnormal_exit_8 = 8'd137;
parameter normalizeFloat64Subnormal_exit_9 = 8'd138;
parameter normalizeFloat64Subnormal_exit_10 = 8'd139;
parameter normalizeFloat64Subnormal_exit_11 = 8'd140;
parameter normalizeFloat64Subnormal_exit_12 = 8'd141;
parameter normalizeFloat64Subnormal_exit_13 = 8'd142;
parameter bb22 = 8'd143;
parameter bb22_1 = 8'd144;
parameter bb22_2 = 8'd145;
parameter bb22_3 = 8'd146;
parameter bb22_4 = 8'd147;
parameter bb22_5 = 8'd148;
parameter bb22_6 = 8'd149;
parameter bb22_7 = 8'd150;
parameter bb22_8 = 8'd151;
parameter bb22_9 = 8'd152;
parameter bb22_10 = 8'd153;
parameter bb22_11 = 8'd154;
parameter bb22_12 = 8'd155;
parameter bb22_13 = 8'd156;
parameter bb22_14 = 8'd157;
parameter bb22_15 = 8'd158;
parameter bb22_15_call_0 = 8'd159;
parameter bb22_15_call_1 = 8'd160;
parameter bb22_16 = 8'd161;
reg [31:0] var5;
reg  var50;
reg [63:0] var49;
reg  var51;
reg [63:0] var53;
reg  not__i_i;
reg [31:0] retval_i_i;
reg [31:0] var52;
reg [63:0] var54;
reg [63:0] var55;
reg [31:0] var56;
reg  var57;
reg [31:0] var58;
reg [31:0] var59;
reg  var60;
reg  var62;
reg [63:0] iftmp_34_0_i;
reg [63:0] var61;
reg [63:0] var63;
reg [31:0] shiftCount_0_i_i_i;
reg  var95;
reg [31:0] var96;
reg [31:0] var97;
reg [31:0] shiftCount_1_i_i_i;
reg [31:0] a_addr_1_i_i_i;
reg [31:0] var98;
reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] var99;
reg [31:0] var100;
reg [31:0] var101;
reg [31:0] var102;
reg [31:0] var103;
reg [63:0] _cast_i;
reg [63:0] var105;
reg [31:0] var104;
reg [63:0] var119;
reg [63:0] var118;
reg [63:0] var120;
reg [63:0] var121;
reg  var122;
reg [63:0] iftmp_17_0_i;
reg [63:0] var123;
reg [63:0] var126;
reg [63:0] var124;
reg [63:0] var125;
reg  var127;
reg [63:0] var129;
reg [63:0] var130;
reg [63:0] var132;
reg  var128;
reg [63:0] var131;
reg [63:0] var133;
reg [63:0] _mask;
reg  var134;
reg [63:0] _mask_lobit;
reg [63:0] tmp;
reg [63:0] zSig0_0;
reg [31:0] zExp_0_v;
reg [31:0] var112;
reg [31:0] zExp_0;
reg [31:0] var38;
reg [31:0] var39;
reg [63:0] var40;
reg [63:0] var41;
reg [63:0] var0;
reg [63:0] var1;
reg [31:0] var8;
reg [63:0] var2;
reg [63:0] var3;
reg [31:0] var6;
reg [31:0] var9;
reg [63:0] var4;
reg [63:0] var7;
reg [31:0] var10;
reg  var11;
reg  var12;
reg  var13;
reg  var14;
reg  var15;
reg [63:0] var16;
reg  var17;
reg [63:0] var19;
reg  not__i12_i40;
reg [31:0] retval_i13_i41;
reg [31:0] var18;
reg [63:0] var20;
reg  var22;
reg [63:0] var21;
reg  var23;
reg [63:0] var25;
reg  not__i_i44;
reg [31:0] retval_i_i45;
reg [31:0] var24;
reg [63:0] var26;
reg [63:0] var27;
reg [31:0] var28;
reg  var29;
reg [31:0] var30;
reg [31:0] var31;
reg  var32;
reg  var34;
reg [63:0] iftmp_34_0_i51;
reg [63:0] var33;
reg [63:0] var35;
reg [63:0] var36;
reg  var37;
reg [31:0] bExp_0;
reg [63:0] bSig_0;
reg [63:0] var106;
reg [63:0] var108;
reg [63:0] var107;
reg [63:0] var109;
reg [63:0] var113;
reg [63:0] var110;
reg [63:0] var114;
reg [63:0] var116;
reg [63:0] var111;
reg [63:0] var115;
reg [63:0] var117;
reg  var42;
reg  var43;
reg [63:0] var44;
reg  var45;
reg [63:0] var47;
reg  not__i12_i;
reg [31:0] retval_i13_i;
reg [31:0] var46;
reg [63:0] var48;
reg [63:0] var64;
reg  var65;
reg [31:0] var66;
reg [31:0] var67;
reg [63:0] var68;
reg [63:0] var69;
reg  var70;
reg  var71;
reg [63:0] var72;
reg  var73;
reg [31:0] extract_t_i_i27;
reg [63:0] var74;
reg [31:0] extract_t4_i_i29;
reg [31:0] shiftCount_0_i_i31;
reg [31:0] a_addr_0_off0_i_i32;
reg [31:0] var75;
reg  var76;
reg [31:0] _a_i_i_i33;
reg [31:0] shiftCount_0_i_i_i34;
reg  var77;
reg [31:0] var78;
reg [31:0] var79;
reg [31:0] shiftCount_1_i_i_i35;
reg [31:0] a_addr_1_i_i_i36;
reg [31:0] var80;
reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] var81;
reg [31:0] var82;
reg [31:0] var83;
reg [31:0] var84;
reg [31:0] var85;
reg [63:0] _cast_i37;
reg [63:0] var87;
reg [31:0] var86;
reg [63:0] aSig_0;
reg [31:0] aExp_0;
reg  var88;
reg  var89;
reg [63:0] var90;
reg  var91;
reg [31:0] extract_t_i_i;
reg [63:0] var92;
reg [31:0] extract_t4_i_i;
reg [31:0] shiftCount_0_i_i;
reg [31:0] a_addr_0_off0_i_i;
reg [31:0] var93;
reg  var94;
reg [31:0] _a_i_i_i;
reg [63:0] var135;
reg [31:0] load_noop1;
reg [31:0] load_noop;
reg [31:0] load_noop2;
reg [31:0] load_noop3;
reg [31:0] load_noop4;
reg [31:0] load_noop5;

always @(posedge clk)
if (reset)
	cur_state = Wait;
else
case(cur_state)
	Wait:
	begin
		finish = 0;
		if (start == 1)
			cur_state = entry;
		else
			cur_state = Wait;
	end
	entry:
	begin
		/*   %0 = and i64 %a, 4503599627370495               ; <i64> [#uses=7]*/
		var0 = a & 64'd4503599627370495;
		/*   %1 = lshr i64 %a, 52                            ; <i64> [#uses=1]*/
		var1 = a >>> (64'd52 % 64);
		/*   %2 = and i64 %b, 4503599627370495               ; <i64> [#uses=8]*/
		var2 = b & 64'd4503599627370495;
		/*   %3 = lshr i64 %b, 52                            ; <i64> [#uses=1]*/
		var3 = b >>> (64'd52 % 64);
		/*   %4 = xor i64 %b, %a                             ; <i64> [#uses=5]*/
		var4 = b ^ a;
		/*   br label %entry_1*/
		cur_state = entry_1;
	end
	entry_1:
	begin
		/*   %5 = trunc i64 %1 to i32                        ; <i32> [#uses=1]*/
		var5 = var1[31:0];
		/*   %6 = trunc i64 %3 to i32                        ; <i32> [#uses=1]*/
		var6 = var3[31:0];
		/*   %7 = lshr i64 %4, 63                            ; <i64> [#uses=1]*/
		var7 = var4 >>> (64'd63 % 64);
		/*   br label %entry_2*/
		cur_state = entry_2;
	end
	entry_2:
	begin
		/*   %8 = and i32 %5, 2047                           ; <i32> [#uses=4]*/
		var8 = var5 & 32'd2047;
		/*   %9 = and i32 %6, 2047                           ; <i32> [#uses=5]*/
		var9 = var6 & 32'd2047;
		/*   %10 = trunc i64 %7 to i32                       ; <i32> [#uses=1]*/
		var10 = var7[31:0];
		/*   br label %entry_3*/
		cur_state = entry_3;
	end
	entry_3:
	begin
		/*   %11 = icmp eq i32 %8, 2047                      ; <i1> [#uses=1]*/
		var11 = var8 == 32'd2047;
		/*   br label %entry_4*/
		cur_state = entry_4;
	end
	entry_4:
	begin
		/*   br i1 %11, label %bb, label %bb8*/
		if (var11) begin
			cur_state = bb;
		end
		else begin
			cur_state = bb8;
		end
	end
	bb:
	begin
		/*   %12 = icmp eq i64 %0, 0                         ; <i1> [#uses=1]*/
		var12 = var0 == 64'd0;
		/*   br label %bb_1*/
		cur_state = bb_1;
	end
	bb_1:
	begin
		/*   br i1 %12, label %bb1, label %bb4*/
		if (var12) begin
			cur_state = bb1;
		end
		else begin
			cur_state = bb4;
		end
	end
	bb1:
	begin
		/*   %13 = icmp eq i32 %9, 2047                      ; <i1> [#uses=1]*/
		var13 = var9 == 32'd2047;
		/*   %14 = icmp ne i64 %2, 0                         ; <i1> [#uses=1]*/
		var14 = var2 != 64'd0;
		/*   br label %bb1_1*/
		cur_state = bb1_1;
	end
	bb1_1:
	begin
		/*   %15 = and i1 %13, %14                           ; <i1> [#uses=1]*/
		var15 = var13 & var14;
		/*   br label %bb1_2*/
		cur_state = bb1_2;
	end
	bb1_2:
	begin
		/*   br i1 %15, label %bb4, label %bb5*/
		if (var15) begin
			cur_state = bb4;
		end
		else begin
			cur_state = bb5;
		end
	end
	bb4:
	begin
		/*   %16 = and i64 %a, 9221120237041090560           ; <i64> [#uses=1]*/
		var16 = a & 64'd9221120237041090560;
		/*   br label %bb4_1*/
		cur_state = bb4_1;
	end
	bb4_1:
	begin
		/*   %17 = icmp eq i64 %16, 9218868437227405312      ; <i1> [#uses=1]*/
		var17 = var16 == 64'd9218868437227405312;
		/*   br label %bb4_2*/
		cur_state = bb4_2;
	end
	bb4_2:
	begin
		/*   br i1 %17, label %bb.i14.i42, label %float64_is_signaling_nan.exit16.i43*/
		if (var17) begin
			cur_state = bb_i14_i42;
		end
		else begin
			var18 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit16_i43;
		end
	end
	bb_i14_i42:
	begin
		/*   %18 = and i64 %a, 2251799813685247              ; <i64> [#uses=1]*/
		var19 = a & 64'd2251799813685247;
		/*   br label %bb.i14.i42_1*/
		cur_state = bb_i14_i42_1;
	end
	bb_i14_i42_1:
	begin
		/*   %not..i12.i40 = icmp ne i64 %18, 0              ; <i1> [#uses=1]*/
		not__i12_i40 = var19 != 64'd0;
		/*   br label %bb.i14.i42_2*/
		cur_state = bb_i14_i42_2;
	end
	bb_i14_i42_2:
	begin
		/*   %retval.i13.i41 = zext i1 %not..i12.i40 to i32  ; <i32> [#uses=1]*/
		retval_i13_i41 = not__i12_i40;
		/*   br label %float64_is_signaling_nan.exit16.i43*/
		var18 = retval_i13_i41;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit16_i43;
	end
	float64_is_signaling_nan_exit16_i43:
	begin
		/*   %19 = phi i32 [ %retval.i13.i41, %bb.i14.i42_2 ], [ 0, %bb4_2 ] ; <i32> [#uses=2]*/

		/*   %20 = shl i64 %b, 1                             ; <i64> [#uses=1]*/
		var20 = b <<< (64'd1 % 64);
		/*   %21 = and i64 %b, 9221120237041090560           ; <i64> [#uses=1]*/
		var21 = b & 64'd9221120237041090560;
		/*   br label %float64_is_signaling_nan.exit16.i43_1*/
		cur_state = float64_is_signaling_nan_exit16_i43_1;
	end
	float64_is_signaling_nan_exit16_i43_1:
	begin
		/*   %22 = icmp ugt i64 %20, -9007199254740992       ; <i1> [#uses=1]*/
		var22 = var20 > -64'd9007199254740992;
		/*   %23 = icmp eq i64 %21, 9218868437227405312      ; <i1> [#uses=1]*/
		var23 = var21 == 64'd9218868437227405312;
		/*   br label %float64_is_signaling_nan.exit16.i43_2*/
		cur_state = float64_is_signaling_nan_exit16_i43_2;
	end
	float64_is_signaling_nan_exit16_i43_2:
	begin
		/*   br i1 %23, label %bb.i.i46, label %float64_is_signaling_nan.exit.i47*/
		if (var23) begin
			cur_state = bb_i_i46;
		end
		else begin
			var24 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit_i47;
		end
	end
	bb_i_i46:
	begin
		/*   %24 = and i64 %b, 2251799813685247              ; <i64> [#uses=1]*/
		var25 = b & 64'd2251799813685247;
		/*   br label %bb.i.i46_1*/
		cur_state = bb_i_i46_1;
	end
	bb_i_i46_1:
	begin
		/*   %not..i.i44 = icmp ne i64 %24, 0                ; <i1> [#uses=1]*/
		not__i_i44 = var25 != 64'd0;
		/*   br label %bb.i.i46_2*/
		cur_state = bb_i_i46_2;
	end
	bb_i_i46_2:
	begin
		/*   %retval.i.i45 = zext i1 %not..i.i44 to i32      ; <i32> [#uses=1]*/
		retval_i_i45 = not__i_i44;
		/*   br label %float64_is_signaling_nan.exit.i47*/
		var24 = retval_i_i45;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit_i47;
	end
	float64_is_signaling_nan_exit_i47:
	begin
		/*   %25 = phi i32 [ %retval.i.i45, %bb.i.i46_2 ], [ 0, %float64_is_signaling_nan.exit16.i43_2 ] ; <i32> [#uses=2]*/

		/*   %26 = or i64 %a, 2251799813685248               ; <i64> [#uses=2]*/
		var26 = a | 64'd2251799813685248;
		/*   %27 = or i64 %b, 2251799813685248               ; <i64> [#uses=2]*/
		var27 = b | 64'd2251799813685248;
		/*   br label %float64_is_signaling_nan.exit.i47_1*/
		cur_state = float64_is_signaling_nan_exit_i47_1;
	end
	float64_is_signaling_nan_exit_i47_1:
	begin
		/*   %28 = or i32 %25, %19                           ; <i32> [#uses=1]*/
		var28 = var24 | var18;
		/*   br label %float64_is_signaling_nan.exit.i47_2*/
		cur_state = float64_is_signaling_nan_exit_i47_2;
	end
	float64_is_signaling_nan_exit_i47_2:
	begin
		/*   %29 = icmp eq i32 %28, 0                        ; <i1> [#uses=1]*/
		var29 = var28 == 32'd0;
		/*   br label %float64_is_signaling_nan.exit.i47_3*/
		cur_state = float64_is_signaling_nan_exit_i47_3;
	end
	float64_is_signaling_nan_exit_i47_3:
	begin
		/*   br i1 %29, label %bb1.i49, label %bb.i48*/
		if (var29) begin
			cur_state = bb1_i49;
		end
		else begin
			cur_state = bb_i48;
		end
	end
	bb_i48:
	begin
		/*   %30 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb.i48_1*/
		cur_state = bb_i48_1;
	end
	bb_i48_1:
	begin
		var30 = memory_controller_out[31:0];
		/*   %load_noop = add i32 %30, 0                     ; <i32> [#uses=1]*/
		load_noop = var30 + 32'd0;
		/*   br label %bb.i48_2*/
		cur_state = bb_i48_2;
	end
	bb_i48_2:
	begin
		/*   %31 = or i32 %load_noop, 16                     ; <i32> [#uses=1]*/
		var31 = load_noop | 32'd16;
		/*   br label %bb.i48_3*/
		cur_state = bb_i48_3;
	end
	bb_i48_3:
	begin
		/*   store i32 %31, i32* @float_exception_flags, align 4*/
		/*   br label %bb1.i49*/
		cur_state = bb1_i49;
	end
	bb1_i49:
	begin
		/*   %32 = icmp eq i32 %25, 0                        ; <i1> [#uses=1]*/
		var32 = var24 == 32'd0;
		/*   br label %bb1.i49_1*/
		cur_state = bb1_i49_1;
	end
	bb1_i49_1:
	begin
		/*   br i1 %32, label %bb2.i50, label %propagateFloat64NaN.exit55*/
		if (var32) begin
			cur_state = bb2_i50;
		end
		else begin
			var33 = var27;   /* for PHI node */
			cur_state = propagateFloat64NaN_exit55;
		end
	end
	bb2_i50:
	begin
		/*   %33 = icmp eq i32 %19, 0                        ; <i1> [#uses=1]*/
		var34 = var18 == 32'd0;
		/*   br label %bb2.i50_1*/
		cur_state = bb2_i50_1;
	end
	bb2_i50_1:
	begin
		/*   br i1 %33, label %bb3.i52, label %propagateFloat64NaN.exit55*/
		if (var34) begin
			cur_state = bb3_i52;
		end
		else begin
			var33 = var26;   /* for PHI node */
			cur_state = propagateFloat64NaN_exit55;
		end
	end
	bb3_i52:
	begin
		/*   %iftmp.34.0.i51 = select i1 %22, i64 %27, i64 %26 ; <i64> [#uses=1]*/
		iftmp_34_0_i51 = (var22) ? var27 : var26;
		/*   br label %bb3.i52_1*/
		cur_state = bb3_i52_1;
	end
	bb3_i52_1:
	begin
		/*   ret i64 %iftmp.34.0.i51*/
		return_val = iftmp_34_0_i51;
		finish = 1;
		cur_state = Wait;
	end
	propagateFloat64NaN_exit55:
	begin
		/*   %34 = phi i64 [ %26, %bb2.i50_1 ], [ %27, %bb1.i49_1 ] ; <i64> [#uses=1]*/

		/*   br label %propagateFloat64NaN.exit55_1*/
		cur_state = propagateFloat64NaN_exit55_1;
	end
	propagateFloat64NaN_exit55_1:
	begin
		/*   ret i64 %34*/
		return_val = var33;
		finish = 1;
		cur_state = Wait;
	end
	bb5:
	begin
		/*   %35 = zext i32 %9 to i64                        ; <i64> [#uses=1]*/
		var35 = var9;
		/*   br label %bb5_1*/
		cur_state = bb5_1;
	end
	bb5_1:
	begin
		/*   %36 = or i64 %35, %2                            ; <i64> [#uses=1]*/
		var36 = var35 | var2;
		/*   br label %bb5_2*/
		cur_state = bb5_2;
	end
	bb5_2:
	begin
		/*   %37 = icmp eq i64 %36, 0                        ; <i1> [#uses=1]*/
		var37 = var36 == 64'd0;
		/*   br label %bb5_3*/
		cur_state = bb5_3;
	end
	bb5_3:
	begin
		/*   br i1 %37, label %bb6, label %bb7*/
		if (var37) begin
			cur_state = bb6;
		end
		else begin
			cur_state = bb7;
		end
	end
	bb6:
	begin
		/*   %38 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb6_1*/
		cur_state = bb6_1;
	end
	bb6_1:
	begin
		var38 = memory_controller_out[31:0];
		/*   %load_noop1 = add i32 %38, 0                    ; <i32> [#uses=1]*/
		load_noop1 = var38 + 32'd0;
		/*   br label %bb6_2*/
		cur_state = bb6_2;
	end
	bb6_2:
	begin
		/*   %39 = or i32 %load_noop1, 16                    ; <i32> [#uses=1]*/
		var39 = load_noop1 | 32'd16;
		/*   br label %bb6_3*/
		cur_state = bb6_3;
	end
	bb6_3:
	begin
		/*   store i32 %39, i32* @float_exception_flags, align 4*/
		/*   ret i64 9223372036854775807*/
		return_val = 64'd9223372036854775807;
		finish = 1;
		cur_state = Wait;
	end
	bb7:
	begin
		/*   %40 = or i64 %4, 9218868437227405312            ; <i64> [#uses=1]*/
		var40 = var4 | 64'd9218868437227405312;
		/*   br label %bb7_1*/
		cur_state = bb7_1;
	end
	bb7_1:
	begin
		/*   %41 = and i64 %40, -4503599627370496            ; <i64> [#uses=1]*/
		var41 = var40 & -64'd4503599627370496;
		/*   br label %bb7_2*/
		cur_state = bb7_2;
	end
	bb7_2:
	begin
		/*   ret i64 %41*/
		return_val = var41;
		finish = 1;
		cur_state = Wait;
	end
	bb8:
	begin
		/*   %42 = icmp eq i32 %9, 2047                      ; <i1> [#uses=1]*/
		var42 = var9 == 32'd2047;
		/*   br label %bb8_1*/
		cur_state = bb8_1;
	end
	bb8_1:
	begin
		/*   br i1 %42, label %bb9, label %bb14*/
		if (var42) begin
			cur_state = bb9;
		end
		else begin
			cur_state = bb14;
		end
	end
	bb9:
	begin
		/*   %43 = icmp eq i64 %2, 0                         ; <i1> [#uses=1]*/
		var43 = var2 == 64'd0;
		/*   br label %bb9_1*/
		cur_state = bb9_1;
	end
	bb9_1:
	begin
		/*   br i1 %43, label %bb11, label %bb10*/
		if (var43) begin
			cur_state = bb11;
		end
		else begin
			cur_state = bb10;
		end
	end
	bb10:
	begin
		/*   %44 = and i64 %a, 9221120237041090560           ; <i64> [#uses=1]*/
		var44 = a & 64'd9221120237041090560;
		/*   br label %bb10_1*/
		cur_state = bb10_1;
	end
	bb10_1:
	begin
		/*   %45 = icmp eq i64 %44, 9218868437227405312      ; <i1> [#uses=1]*/
		var45 = var44 == 64'd9218868437227405312;
		/*   br label %bb10_2*/
		cur_state = bb10_2;
	end
	bb10_2:
	begin
		/*   br i1 %45, label %bb.i14.i, label %float64_is_signaling_nan.exit16.i*/
		if (var45) begin
			cur_state = bb_i14_i;
		end
		else begin
			var46 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit16_i;
		end
	end
	bb_i14_i:
	begin
		/*   %46 = and i64 %a, 2251799813685247              ; <i64> [#uses=1]*/
		var47 = a & 64'd2251799813685247;
		/*   br label %bb.i14.i_1*/
		cur_state = bb_i14_i_1;
	end
	bb_i14_i_1:
	begin
		/*   %not..i12.i = icmp ne i64 %46, 0                ; <i1> [#uses=1]*/
		not__i12_i = var47 != 64'd0;
		/*   br label %bb.i14.i_2*/
		cur_state = bb_i14_i_2;
	end
	bb_i14_i_2:
	begin
		/*   %retval.i13.i = zext i1 %not..i12.i to i32      ; <i32> [#uses=1]*/
		retval_i13_i = not__i12_i;
		/*   br label %float64_is_signaling_nan.exit16.i*/
		var46 = retval_i13_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit16_i;
	end
	float64_is_signaling_nan_exit16_i:
	begin
		/*   %47 = phi i32 [ %retval.i13.i, %bb.i14.i_2 ], [ 0, %bb10_2 ] ; <i32> [#uses=2]*/

		/*   %48 = shl i64 %b, 1                             ; <i64> [#uses=1]*/
		var48 = b <<< (64'd1 % 64);
		/*   %49 = and i64 %b, 9221120237041090560           ; <i64> [#uses=1]*/
		var49 = b & 64'd9221120237041090560;
		/*   br label %float64_is_signaling_nan.exit16.i_1*/
		cur_state = float64_is_signaling_nan_exit16_i_1;
	end
	float64_is_signaling_nan_exit16_i_1:
	begin
		/*   %50 = icmp ugt i64 %48, -9007199254740992       ; <i1> [#uses=1]*/
		var50 = var48 > -64'd9007199254740992;
		/*   %51 = icmp eq i64 %49, 9218868437227405312      ; <i1> [#uses=1]*/
		var51 = var49 == 64'd9218868437227405312;
		/*   br label %float64_is_signaling_nan.exit16.i_2*/
		cur_state = float64_is_signaling_nan_exit16_i_2;
	end
	float64_is_signaling_nan_exit16_i_2:
	begin
		/*   br i1 %51, label %bb.i.i39, label %float64_is_signaling_nan.exit.i*/
		if (var51) begin
			cur_state = bb_i_i39;
		end
		else begin
			var52 = 32'd0;   /* for PHI node */
			cur_state = float64_is_signaling_nan_exit_i;
		end
	end
	bb_i_i39:
	begin
		/*   %52 = and i64 %b, 2251799813685247              ; <i64> [#uses=1]*/
		var53 = b & 64'd2251799813685247;
		/*   br label %bb.i.i39_1*/
		cur_state = bb_i_i39_1;
	end
	bb_i_i39_1:
	begin
		/*   %not..i.i = icmp ne i64 %52, 0                  ; <i1> [#uses=1]*/
		not__i_i = var53 != 64'd0;
		/*   br label %bb.i.i39_2*/
		cur_state = bb_i_i39_2;
	end
	bb_i_i39_2:
	begin
		/*   %retval.i.i = zext i1 %not..i.i to i32          ; <i32> [#uses=1]*/
		retval_i_i = not__i_i;
		/*   br label %float64_is_signaling_nan.exit.i*/
		var52 = retval_i_i;   /* for PHI node */
		cur_state = float64_is_signaling_nan_exit_i;
	end
	float64_is_signaling_nan_exit_i:
	begin
		/*   %53 = phi i32 [ %retval.i.i, %bb.i.i39_2 ], [ 0, %float64_is_signaling_nan.exit16.i_2 ] ; <i32> [#uses=2]*/

		/*   %54 = or i64 %a, 2251799813685248               ; <i64> [#uses=2]*/
		var54 = a | 64'd2251799813685248;
		/*   %55 = or i64 %b, 2251799813685248               ; <i64> [#uses=2]*/
		var55 = b | 64'd2251799813685248;
		/*   br label %float64_is_signaling_nan.exit.i_1*/
		cur_state = float64_is_signaling_nan_exit_i_1;
	end
	float64_is_signaling_nan_exit_i_1:
	begin
		/*   %56 = or i32 %53, %47                           ; <i32> [#uses=1]*/
		var56 = var52 | var46;
		/*   br label %float64_is_signaling_nan.exit.i_2*/
		cur_state = float64_is_signaling_nan_exit_i_2;
	end
	float64_is_signaling_nan_exit_i_2:
	begin
		/*   %57 = icmp eq i32 %56, 0                        ; <i1> [#uses=1]*/
		var57 = var56 == 32'd0;
		/*   br label %float64_is_signaling_nan.exit.i_3*/
		cur_state = float64_is_signaling_nan_exit_i_3;
	end
	float64_is_signaling_nan_exit_i_3:
	begin
		/*   br i1 %57, label %bb1.i, label %bb.i*/
		if (var57) begin
			cur_state = bb1_i;
		end
		else begin
			cur_state = bb_i;
		end
	end
	bb_i:
	begin
		/*   %58 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb.i_1*/
		cur_state = bb_i_1;
	end
	bb_i_1:
	begin
		var58 = memory_controller_out[31:0];
		/*   %load_noop2 = add i32 %58, 0                    ; <i32> [#uses=1]*/
		load_noop2 = var58 + 32'd0;
		/*   br label %bb.i_2*/
		cur_state = bb_i_2;
	end
	bb_i_2:
	begin
		/*   %59 = or i32 %load_noop2, 16                    ; <i32> [#uses=1]*/
		var59 = load_noop2 | 32'd16;
		/*   br label %bb.i_3*/
		cur_state = bb_i_3;
	end
	bb_i_3:
	begin
		/*   store i32 %59, i32* @float_exception_flags, align 4*/
		/*   br label %bb1.i*/
		cur_state = bb1_i;
	end
	bb1_i:
	begin
		/*   %60 = icmp eq i32 %53, 0                        ; <i1> [#uses=1]*/
		var60 = var52 == 32'd0;
		/*   br label %bb1.i_1*/
		cur_state = bb1_i_1;
	end
	bb1_i_1:
	begin
		/*   br i1 %60, label %bb2.i, label %propagateFloat64NaN.exit*/
		if (var60) begin
			cur_state = bb2_i;
		end
		else begin
			var61 = var55;   /* for PHI node */
			cur_state = propagateFloat64NaN_exit;
		end
	end
	bb2_i:
	begin
		/*   %61 = icmp eq i32 %47, 0                        ; <i1> [#uses=1]*/
		var62 = var46 == 32'd0;
		/*   br label %bb2.i_1*/
		cur_state = bb2_i_1;
	end
	bb2_i_1:
	begin
		/*   br i1 %61, label %bb3.i, label %propagateFloat64NaN.exit*/
		if (var62) begin
			cur_state = bb3_i;
		end
		else begin
			var61 = var54;   /* for PHI node */
			cur_state = propagateFloat64NaN_exit;
		end
	end
	bb3_i:
	begin
		/*   %iftmp.34.0.i = select i1 %50, i64 %55, i64 %54 ; <i64> [#uses=1]*/
		iftmp_34_0_i = (var50) ? var55 : var54;
		/*   br label %bb3.i_1*/
		cur_state = bb3_i_1;
	end
	bb3_i_1:
	begin
		/*   ret i64 %iftmp.34.0.i*/
		return_val = iftmp_34_0_i;
		finish = 1;
		cur_state = Wait;
	end
	propagateFloat64NaN_exit:
	begin
		/*   %62 = phi i64 [ %54, %bb2.i_1 ], [ %55, %bb1.i_1 ] ; <i64> [#uses=1]*/

		/*   br label %propagateFloat64NaN.exit_1*/
		cur_state = propagateFloat64NaN_exit_1;
	end
	propagateFloat64NaN_exit_1:
	begin
		/*   ret i64 %62*/
		return_val = var61;
		finish = 1;
		cur_state = Wait;
	end
	bb11:
	begin
		/*   %63 = zext i32 %8 to i64                        ; <i64> [#uses=1]*/
		var63 = var8;
		/*   br label %bb11_1*/
		cur_state = bb11_1;
	end
	bb11_1:
	begin
		/*   %64 = or i64 %63, %0                            ; <i64> [#uses=1]*/
		var64 = var63 | var0;
		/*   br label %bb11_2*/
		cur_state = bb11_2;
	end
	bb11_2:
	begin
		/*   %65 = icmp eq i64 %64, 0                        ; <i1> [#uses=1]*/
		var65 = var64 == 64'd0;
		/*   br label %bb11_3*/
		cur_state = bb11_3;
	end
	bb11_3:
	begin
		/*   br i1 %65, label %bb12, label %bb13*/
		if (var65) begin
			cur_state = bb12;
		end
		else begin
			cur_state = bb13;
		end
	end
	bb12:
	begin
		/*   %66 = load i32* @float_exception_flags, align 4 ; <i32> [#uses=1]*/
		/*   br label %bb12_1*/
		cur_state = bb12_1;
	end
	bb12_1:
	begin
		var66 = memory_controller_out[31:0];
		/*   %load_noop3 = add i32 %66, 0                    ; <i32> [#uses=1]*/
		load_noop3 = var66 + 32'd0;
		/*   br label %bb12_2*/
		cur_state = bb12_2;
	end
	bb12_2:
	begin
		/*   %67 = or i32 %load_noop3, 16                    ; <i32> [#uses=1]*/
		var67 = load_noop3 | 32'd16;
		/*   br label %bb12_3*/
		cur_state = bb12_3;
	end
	bb12_3:
	begin
		/*   store i32 %67, i32* @float_exception_flags, align 4*/
		/*   ret i64 9223372036854775807*/
		return_val = 64'd9223372036854775807;
		finish = 1;
		cur_state = Wait;
	end
	bb13:
	begin
		/*   %68 = or i64 %4, 9218868437227405312            ; <i64> [#uses=1]*/
		var68 = var4 | 64'd9218868437227405312;
		/*   br label %bb13_1*/
		cur_state = bb13_1;
	end
	bb13_1:
	begin
		/*   %69 = and i64 %68, -4503599627370496            ; <i64> [#uses=1]*/
		var69 = var68 & -64'd4503599627370496;
		/*   br label %bb13_2*/
		cur_state = bb13_2;
	end
	bb13_2:
	begin
		/*   ret i64 %69*/
		return_val = var69;
		finish = 1;
		cur_state = Wait;
	end
	bb14:
	begin
		/*   %70 = icmp eq i32 %8, 0                         ; <i1> [#uses=1]*/
		var70 = var8 == 32'd0;
		/*   br label %bb14_1*/
		cur_state = bb14_1;
	end
	bb14_1:
	begin
		/*   br i1 %70, label %bb15, label %bb18*/
		if (var70) begin
			cur_state = bb15;
		end
		else begin
			aSig_0 = var0;   /* for PHI node */
			aExp_0 = var8;   /* for PHI node */
			cur_state = bb18;
		end
	end
	bb15:
	begin
		/*   %71 = icmp eq i64 %0, 0                         ; <i1> [#uses=1]*/
		var71 = var0 == 64'd0;
		/*   br label %bb15_1*/
		cur_state = bb15_1;
	end
	bb15_1:
	begin
		/*   br i1 %71, label %bb16, label %bb17*/
		if (var71) begin
			cur_state = bb16;
		end
		else begin
			cur_state = bb17;
		end
	end
	bb16:
	begin
		/*   %72 = and i64 %4, -9223372036854775808          ; <i64> [#uses=1]*/
		var72 = var4 & -64'd9223372036854775808;
		/*   br label %bb16_1*/
		cur_state = bb16_1;
	end
	bb16_1:
	begin
		/*   ret i64 %72*/
		return_val = var72;
		finish = 1;
		cur_state = Wait;
	end
	bb17:
	begin
		/*   %73 = icmp ult i64 %0, 4294967296               ; <i1> [#uses=1]*/
		var73 = var0 < 64'd4294967296;
		/*   br label %bb17_1*/
		cur_state = bb17_1;
	end
	bb17_1:
	begin
		/*   br i1 %73, label %bb.i.i28, label %bb1.i.i30*/
		if (var73) begin
			cur_state = bb_i_i28;
		end
		else begin
			cur_state = bb1_i_i30;
		end
	end
	bb_i_i28:
	begin
		/*   %extract.t.i.i27 = trunc i64 %a to i32          ; <i32> [#uses=1]*/
		extract_t_i_i27 = a[31:0];
		/*   br label %normalizeFloat64Subnormal.exit38*/
		shiftCount_0_i_i31 = 32'd32;   /* for PHI node */
		a_addr_0_off0_i_i32 = extract_t_i_i27;   /* for PHI node */
		cur_state = normalizeFloat64Subnormal_exit38;
	end
	bb1_i_i30:
	begin
		/*   %74 = lshr i64 %0, 32                           ; <i64> [#uses=1]*/
		var74 = var0 >>> (64'd32 % 64);
		/*   br label %bb1.i.i30_1*/
		cur_state = bb1_i_i30_1;
	end
	bb1_i_i30_1:
	begin
		/*   %extract.t4.i.i29 = trunc i64 %74 to i32        ; <i32> [#uses=1]*/
		extract_t4_i_i29 = var74[31:0];
		/*   br label %normalizeFloat64Subnormal.exit38*/
		shiftCount_0_i_i31 = 32'd0;   /* for PHI node */
		a_addr_0_off0_i_i32 = extract_t4_i_i29;   /* for PHI node */
		cur_state = normalizeFloat64Subnormal_exit38;
	end
	normalizeFloat64Subnormal_exit38:
	begin
		/*   %shiftCount.0.i.i31 = phi i32 [ 32, %bb.i.i28 ], [ 0, %bb1.i.i30_1 ] ; <i32> [#uses=1]*/

		/*   %a_addr.0.off0.i.i32 = phi i32 [ %extract.t.i.i27, %bb.i.i28 ], [ %extract.t4.i.i29, %bb1.i.i30_1 ] ; <i32> [#uses=3]*/

		/*   br label %normalizeFloat64Subnormal.exit38_1*/
		cur_state = normalizeFloat64Subnormal_exit38_1;
	end
	normalizeFloat64Subnormal_exit38_1:
	begin
		/*   %75 = shl i32 %a_addr.0.off0.i.i32, 16          ; <i32> [#uses=1]*/
		var75 = a_addr_0_off0_i_i32 <<< (32'd16 % 32);
		/*   %76 = icmp ult i32 %a_addr.0.off0.i.i32, 65536  ; <i1> [#uses=2]*/
		var76 = a_addr_0_off0_i_i32 < 32'd65536;
		/*   br label %normalizeFloat64Subnormal.exit38_2*/
		cur_state = normalizeFloat64Subnormal_exit38_2;
	end
	normalizeFloat64Subnormal_exit38_2:
	begin
		/*   %.a.i.i.i33 = select i1 %76, i32 %75, i32 %a_addr.0.off0.i.i32 ; <i32> [#uses=3]*/
		_a_i_i_i33 = (var76) ? var75 : a_addr_0_off0_i_i32;
		/*   %shiftCount.0.i.i.i34 = select i1 %76, i32 16, i32 0 ; <i32> [#uses=2]*/
		shiftCount_0_i_i_i34 = (var76) ? 32'd16 : 32'd0;
		/*   br label %normalizeFloat64Subnormal.exit38_3*/
		cur_state = normalizeFloat64Subnormal_exit38_3;
	end
	normalizeFloat64Subnormal_exit38_3:
	begin
		/*   %77 = icmp ult i32 %.a.i.i.i33, 16777216        ; <i1> [#uses=2]*/
		var77 = _a_i_i_i33 < 32'd16777216;
		/*   %78 = or i32 %shiftCount.0.i.i.i34, 8           ; <i32> [#uses=1]*/
		var78 = shiftCount_0_i_i_i34 | 32'd8;
		/*   %79 = shl i32 %.a.i.i.i33, 8                    ; <i32> [#uses=1]*/
		var79 = _a_i_i_i33 <<< (32'd8 % 32);
		/*   br label %normalizeFloat64Subnormal.exit38_4*/
		cur_state = normalizeFloat64Subnormal_exit38_4;
	end
	normalizeFloat64Subnormal_exit38_4:
	begin
		/*   %shiftCount.1.i.i.i35 = select i1 %77, i32 %78, i32 %shiftCount.0.i.i.i34 ; <i32> [#uses=1]*/
		shiftCount_1_i_i_i35 = (var77) ? var78 : shiftCount_0_i_i_i34;
		/*   %a_addr.1.i.i.i36 = select i1 %77, i32 %79, i32 %.a.i.i.i33 ; <i32> [#uses=1]*/
		a_addr_1_i_i_i36 = (var77) ? var79 : _a_i_i_i33;
		/*   br label %normalizeFloat64Subnormal.exit38_5*/
		cur_state = normalizeFloat64Subnormal_exit38_5;
	end
	normalizeFloat64Subnormal_exit38_5:
	begin
		/*   %80 = lshr i32 %a_addr.1.i.i.i36, 24            ; <i32> [#uses=1]*/
		var80 = a_addr_1_i_i_i36 >>> (32'd24 % 32);
		/*   br label %normalizeFloat64Subnormal.exit38_6*/
		cur_state = normalizeFloat64Subnormal_exit38_6;
	end
	normalizeFloat64Subnormal_exit38_6:
	begin
		/*   %81 = getelementptr inbounds [256 x i32]* @countLeadingZerosHigh.1302, i32 0, i32 %80 ; <i32*> [#uses=1]*/
		var81 = {`TAG_countLeadingZerosHigh_1302, 32'b0} + ((var80 + 256*(32'd0)) << 2);
		/*   br label %normalizeFloat64Subnormal.exit38_7*/
		cur_state = normalizeFloat64Subnormal_exit38_7;
	end
	normalizeFloat64Subnormal_exit38_7:
	begin
		/*   %82 = load i32* %81, align 4                    ; <i32> [#uses=1]*/
		/*   br label %normalizeFloat64Subnormal.exit38_8*/
		cur_state = normalizeFloat64Subnormal_exit38_8;
	end
	normalizeFloat64Subnormal_exit38_8:
	begin
		var82 = memory_controller_out[31:0];
		/*   %load_noop4 = add i32 %82, 0                    ; <i32> [#uses=1]*/
		load_noop4 = var82 + 32'd0;
		/*   br label %normalizeFloat64Subnormal.exit38_9*/
		cur_state = normalizeFloat64Subnormal_exit38_9;
	end
	normalizeFloat64Subnormal_exit38_9:
	begin
		/*   %83 = add nsw i32 %load_noop4, %shiftCount.0.i.i31 ; <i32> [#uses=1]*/
		var83 = load_noop4 + shiftCount_0_i_i31;
		/*   br label %normalizeFloat64Subnormal.exit38_10*/
		cur_state = normalizeFloat64Subnormal_exit38_10;
	end
	normalizeFloat64Subnormal_exit38_10:
	begin
		/*   %84 = add nsw i32 %83, %shiftCount.1.i.i.i35    ; <i32> [#uses=2]*/
		var84 = var83 + shiftCount_1_i_i_i35;
		/*   br label %normalizeFloat64Subnormal.exit38_11*/
		cur_state = normalizeFloat64Subnormal_exit38_11;
	end
	normalizeFloat64Subnormal_exit38_11:
	begin
		/*   %85 = add i32 %84, -11                          ; <i32> [#uses=1]*/
		var85 = var84 + -32'd11;
		/*   %86 = sub i32 12, %84                           ; <i32> [#uses=1]*/
		var86 = 32'd12 - var84;
		/*   br label %normalizeFloat64Subnormal.exit38_12*/
		cur_state = normalizeFloat64Subnormal_exit38_12;
	end
	normalizeFloat64Subnormal_exit38_12:
	begin
		/*   %.cast.i37 = zext i32 %85 to i64                ; <i64> [#uses=1]*/
		_cast_i37 = var85;
		/*   br label %normalizeFloat64Subnormal.exit38_13*/
		cur_state = normalizeFloat64Subnormal_exit38_13;
	end
	normalizeFloat64Subnormal_exit38_13:
	begin
		/*   %87 = shl i64 %0, %.cast.i37                    ; <i64> [#uses=1]*/
		var87 = var0 <<< (_cast_i37 % 64);
		/*   br label %bb18*/
		aSig_0 = var87;   /* for PHI node */
		aExp_0 = var86;   /* for PHI node */
		cur_state = bb18;
	end
	bb18:
	begin
		/*   %aSig.0 = phi i64 [ %87, %normalizeFloat64Subnormal.exit38_13 ], [ %0, %bb14_1 ] ; <i64> [#uses=2]*/

		/*   %aExp.0 = phi i32 [ %86, %normalizeFloat64Subnormal.exit38_13 ], [ %8, %bb14_1 ] ; <i32> [#uses=1]*/

		/*   %88 = icmp eq i32 %9, 0                         ; <i1> [#uses=1]*/
		var88 = var9 == 32'd0;
		/*   br label %bb18_1*/
		cur_state = bb18_1;
	end
	bb18_1:
	begin
		/*   br i1 %88, label %bb19, label %bb22*/
		if (var88) begin
			cur_state = bb19;
		end
		else begin
			bExp_0 = var9;   /* for PHI node */
			bSig_0 = var2;   /* for PHI node */
			cur_state = bb22;
		end
	end
	bb19:
	begin
		/*   %89 = icmp eq i64 %2, 0                         ; <i1> [#uses=1]*/
		var89 = var2 == 64'd0;
		/*   br label %bb19_1*/
		cur_state = bb19_1;
	end
	bb19_1:
	begin
		/*   br i1 %89, label %bb20, label %bb21*/
		if (var89) begin
			cur_state = bb20;
		end
		else begin
			cur_state = bb21;
		end
	end
	bb20:
	begin
		/*   %90 = and i64 %4, -9223372036854775808          ; <i64> [#uses=1]*/
		var90 = var4 & -64'd9223372036854775808;
		/*   br label %bb20_1*/
		cur_state = bb20_1;
	end
	bb20_1:
	begin
		/*   ret i64 %90*/
		return_val = var90;
		finish = 1;
		cur_state = Wait;
	end
	bb21:
	begin
		/*   %91 = icmp ult i64 %2, 4294967296               ; <i1> [#uses=1]*/
		var91 = var2 < 64'd4294967296;
		/*   br label %bb21_1*/
		cur_state = bb21_1;
	end
	bb21_1:
	begin
		/*   br i1 %91, label %bb.i.i, label %bb1.i.i*/
		if (var91) begin
			cur_state = bb_i_i;
		end
		else begin
			cur_state = bb1_i_i;
		end
	end
	bb_i_i:
	begin
		/*   %extract.t.i.i = trunc i64 %b to i32            ; <i32> [#uses=1]*/
		extract_t_i_i = b[31:0];
		/*   br label %normalizeFloat64Subnormal.exit*/
		shiftCount_0_i_i = 32'd32;   /* for PHI node */
		a_addr_0_off0_i_i = extract_t_i_i;   /* for PHI node */
		cur_state = normalizeFloat64Subnormal_exit;
	end
	bb1_i_i:
	begin
		/*   %92 = lshr i64 %2, 32                           ; <i64> [#uses=1]*/
		var92 = var2 >>> (64'd32 % 64);
		/*   br label %bb1.i.i_1*/
		cur_state = bb1_i_i_1;
	end
	bb1_i_i_1:
	begin
		/*   %extract.t4.i.i = trunc i64 %92 to i32          ; <i32> [#uses=1]*/
		extract_t4_i_i = var92[31:0];
		/*   br label %normalizeFloat64Subnormal.exit*/
		shiftCount_0_i_i = 32'd0;   /* for PHI node */
		a_addr_0_off0_i_i = extract_t4_i_i;   /* for PHI node */
		cur_state = normalizeFloat64Subnormal_exit;
	end
	normalizeFloat64Subnormal_exit:
	begin
		/*   %shiftCount.0.i.i = phi i32 [ 32, %bb.i.i ], [ 0, %bb1.i.i_1 ] ; <i32> [#uses=1]*/

		/*   %a_addr.0.off0.i.i = phi i32 [ %extract.t.i.i, %bb.i.i ], [ %extract.t4.i.i, %bb1.i.i_1 ] ; <i32> [#uses=3]*/

		/*   br label %normalizeFloat64Subnormal.exit_1*/
		cur_state = normalizeFloat64Subnormal_exit_1;
	end
	normalizeFloat64Subnormal_exit_1:
	begin
		/*   %93 = shl i32 %a_addr.0.off0.i.i, 16            ; <i32> [#uses=1]*/
		var93 = a_addr_0_off0_i_i <<< (32'd16 % 32);
		/*   %94 = icmp ult i32 %a_addr.0.off0.i.i, 65536    ; <i1> [#uses=2]*/
		var94 = a_addr_0_off0_i_i < 32'd65536;
		/*   br label %normalizeFloat64Subnormal.exit_2*/
		cur_state = normalizeFloat64Subnormal_exit_2;
	end
	normalizeFloat64Subnormal_exit_2:
	begin
		/*   %.a.i.i.i = select i1 %94, i32 %93, i32 %a_addr.0.off0.i.i ; <i32> [#uses=3]*/
		_a_i_i_i = (var94) ? var93 : a_addr_0_off0_i_i;
		/*   %shiftCount.0.i.i.i = select i1 %94, i32 16, i32 0 ; <i32> [#uses=2]*/
		shiftCount_0_i_i_i = (var94) ? 32'd16 : 32'd0;
		/*   br label %normalizeFloat64Subnormal.exit_3*/
		cur_state = normalizeFloat64Subnormal_exit_3;
	end
	normalizeFloat64Subnormal_exit_3:
	begin
		/*   %95 = icmp ult i32 %.a.i.i.i, 16777216          ; <i1> [#uses=2]*/
		var95 = _a_i_i_i < 32'd16777216;
		/*   %96 = or i32 %shiftCount.0.i.i.i, 8             ; <i32> [#uses=1]*/
		var96 = shiftCount_0_i_i_i | 32'd8;
		/*   %97 = shl i32 %.a.i.i.i, 8                      ; <i32> [#uses=1]*/
		var97 = _a_i_i_i <<< (32'd8 % 32);
		/*   br label %normalizeFloat64Subnormal.exit_4*/
		cur_state = normalizeFloat64Subnormal_exit_4;
	end
	normalizeFloat64Subnormal_exit_4:
	begin
		/*   %shiftCount.1.i.i.i = select i1 %95, i32 %96, i32 %shiftCount.0.i.i.i ; <i32> [#uses=1]*/
		shiftCount_1_i_i_i = (var95) ? var96 : shiftCount_0_i_i_i;
		/*   %a_addr.1.i.i.i = select i1 %95, i32 %97, i32 %.a.i.i.i ; <i32> [#uses=1]*/
		a_addr_1_i_i_i = (var95) ? var97 : _a_i_i_i;
		/*   br label %normalizeFloat64Subnormal.exit_5*/
		cur_state = normalizeFloat64Subnormal_exit_5;
	end
	normalizeFloat64Subnormal_exit_5:
	begin
		/*   %98 = lshr i32 %a_addr.1.i.i.i, 24              ; <i32> [#uses=1]*/
		var98 = a_addr_1_i_i_i >>> (32'd24 % 32);
		/*   br label %normalizeFloat64Subnormal.exit_6*/
		cur_state = normalizeFloat64Subnormal_exit_6;
	end
	normalizeFloat64Subnormal_exit_6:
	begin
		/*   %99 = getelementptr inbounds [256 x i32]* @countLeadingZerosHigh.1302, i32 0, i32 %98 ; <i32*> [#uses=1]*/
		var99 = {`TAG_countLeadingZerosHigh_1302, 32'b0} + ((var98 + 256*(32'd0)) << 2);
		/*   br label %normalizeFloat64Subnormal.exit_7*/
		cur_state = normalizeFloat64Subnormal_exit_7;
	end
	normalizeFloat64Subnormal_exit_7:
	begin
		/*   %100 = load i32* %99, align 4                   ; <i32> [#uses=1]*/
		/*   br label %normalizeFloat64Subnormal.exit_8*/
		cur_state = normalizeFloat64Subnormal_exit_8;
	end
	normalizeFloat64Subnormal_exit_8:
	begin
		var100 = memory_controller_out[31:0];
		/*   %load_noop5 = add i32 %100, 0                   ; <i32> [#uses=1]*/
		load_noop5 = var100 + 32'd0;
		/*   br label %normalizeFloat64Subnormal.exit_9*/
		cur_state = normalizeFloat64Subnormal_exit_9;
	end
	normalizeFloat64Subnormal_exit_9:
	begin
		/*   %101 = add nsw i32 %load_noop5, %shiftCount.0.i.i ; <i32> [#uses=1]*/
		var101 = load_noop5 + shiftCount_0_i_i;
		/*   br label %normalizeFloat64Subnormal.exit_10*/
		cur_state = normalizeFloat64Subnormal_exit_10;
	end
	normalizeFloat64Subnormal_exit_10:
	begin
		/*   %102 = add nsw i32 %101, %shiftCount.1.i.i.i    ; <i32> [#uses=2]*/
		var102 = var101 + shiftCount_1_i_i_i;
		/*   br label %normalizeFloat64Subnormal.exit_11*/
		cur_state = normalizeFloat64Subnormal_exit_11;
	end
	normalizeFloat64Subnormal_exit_11:
	begin
		/*   %103 = add i32 %102, -11                        ; <i32> [#uses=1]*/
		var103 = var102 + -32'd11;
		/*   %104 = sub i32 12, %102                         ; <i32> [#uses=1]*/
		var104 = 32'd12 - var102;
		/*   br label %normalizeFloat64Subnormal.exit_12*/
		cur_state = normalizeFloat64Subnormal_exit_12;
	end
	normalizeFloat64Subnormal_exit_12:
	begin
		/*   %.cast.i = zext i32 %103 to i64                 ; <i64> [#uses=1]*/
		_cast_i = var103;
		/*   br label %normalizeFloat64Subnormal.exit_13*/
		cur_state = normalizeFloat64Subnormal_exit_13;
	end
	normalizeFloat64Subnormal_exit_13:
	begin
		/*   %105 = shl i64 %2, %.cast.i                     ; <i64> [#uses=1]*/
		var105 = var2 <<< (_cast_i % 64);
		/*   br label %bb22*/
		bExp_0 = var104;   /* for PHI node */
		bSig_0 = var105;   /* for PHI node */
		cur_state = bb22;
	end
	bb22:
	begin
		/*   %bExp.0 = phi i32 [ %104, %normalizeFloat64Subnormal.exit_13 ], [ %9, %bb18_1 ] ; <i32> [#uses=1]*/

		/*   %bSig.0 = phi i64 [ %105, %normalizeFloat64Subnormal.exit_13 ], [ %2, %bb18_1 ] ; <i64> [#uses=2]*/

		/*   %106 = shl i64 %aSig.0, 10                      ; <i64> [#uses=1]*/
		var106 = aSig_0 <<< (64'd10 % 64);
		/*   %107 = lshr i64 %aSig.0, 22                     ; <i64> [#uses=1]*/
		var107 = aSig_0 >>> (64'd22 % 64);
		/*   br label %bb22_1*/
		cur_state = bb22_1;
	end
	bb22_1:
	begin
		/*   %108 = shl i64 %bSig.0, 11                      ; <i64> [#uses=1]*/
		var108 = bSig_0 <<< (64'd11 % 64);
		/*   %109 = or i64 %107, 1073741824                  ; <i64> [#uses=1]*/
		var109 = var107 | 64'd1073741824;
		/*   %110 = lshr i64 %bSig.0, 21                     ; <i64> [#uses=1]*/
		var110 = bSig_0 >>> (64'd21 % 64);
		/*   %111 = and i64 %106, 4294966272                 ; <i64> [#uses=2]*/
		var111 = var106 & 64'd4294966272;
		/*   %112 = add nsw i32 %bExp.0, %aExp.0             ; <i32> [#uses=1]*/
		var112 = bExp_0 + aExp_0;
		/*   br label %bb22_2*/
		cur_state = bb22_2;
	end
	bb22_2:
	begin
		/*   %113 = and i64 %109, 4294967295                 ; <i64> [#uses=2]*/
		var113 = var109 & 64'd4294967295;
		/*   %114 = or i64 %110, 2147483648                  ; <i64> [#uses=1]*/
		var114 = var110 | 64'd2147483648;
		/*   %115 = and i64 %108, 4294965248                 ; <i64> [#uses=2]*/
		var115 = var108 & 64'd4294965248;
		/*   br label %bb22_3*/
		cur_state = bb22_3;
	end
	bb22_3:
	begin
		/*   %116 = and i64 %114, 4294967295                 ; <i64> [#uses=2]*/
		var116 = var114 & 64'd4294967295;
		/*   %117 = mul i64 %115, %111                       ; <i64> [#uses=1]*/
		var117 = var115 * var111;
		/*   %118 = mul i64 %115, %113                       ; <i64> [#uses=2]*/
		var118 = var115 * var113;
		/*   br label %bb22_4*/
		cur_state = bb22_4;
	end
	bb22_4:
	begin
		/*   %119 = mul i64 %116, %111                       ; <i64> [#uses=1]*/
		var119 = var116 * var111;
		/*   %120 = mul i64 %116, %113                       ; <i64> [#uses=1]*/
		var120 = var116 * var113;
		/*   br label %bb22_5*/
		cur_state = bb22_5;
	end
	bb22_5:
	begin
		/*   %121 = add i64 %119, %118                       ; <i64> [#uses=3]*/
		var121 = var119 + var118;
		/*   br label %bb22_6*/
		cur_state = bb22_6;
	end
	bb22_6:
	begin
		/*   %122 = icmp ult i64 %121, %118                  ; <i1> [#uses=1]*/
		var122 = var121 < var118;
		/*   %123 = lshr i64 %121, 32                        ; <i64> [#uses=1]*/
		var123 = var121 >>> (64'd32 % 64);
		/*   %124 = shl i64 %121, 32                         ; <i64> [#uses=2]*/
		var124 = var121 <<< (64'd32 % 64);
		/*   br label %bb22_7*/
		cur_state = bb22_7;
	end
	bb22_7:
	begin
		/*   %iftmp.17.0.i = select i1 %122, i64 4294967296, i64 0 ; <i64> [#uses=1]*/
		iftmp_17_0_i = (var122) ? 64'd4294967296 : 64'd0;
		/*   %125 = add i64 %124, %117                       ; <i64> [#uses=2]*/
		var125 = var124 + var117;
		/*   br label %bb22_8*/
		cur_state = bb22_8;
	end
	bb22_8:
	begin
		/*   %126 = or i64 %iftmp.17.0.i, %123               ; <i64> [#uses=1]*/
		var126 = iftmp_17_0_i | var123;
		/*   %127 = icmp ult i64 %125, %124                  ; <i1> [#uses=1]*/
		var127 = var125 < var124;
		/*   %128 = icmp ne i64 %125, 0                      ; <i1> [#uses=1]*/
		var128 = var125 != 64'd0;
		/*   br label %bb22_9*/
		cur_state = bb22_9;
	end
	bb22_9:
	begin
		/*   %129 = zext i1 %127 to i64                      ; <i64> [#uses=1]*/
		var129 = var127;
		/*   %130 = add i64 %126, %120                       ; <i64> [#uses=1]*/
		var130 = var126 + var120;
		/*   %131 = zext i1 %128 to i64                      ; <i64> [#uses=1]*/
		var131 = var128;
		/*   br label %bb22_10*/
		cur_state = bb22_10;
	end
	bb22_10:
	begin
		/*   %132 = add i64 %130, %129                       ; <i64> [#uses=2]*/
		var132 = var130 + var129;
		/*   br label %bb22_11*/
		cur_state = bb22_11;
	end
	bb22_11:
	begin
		/*   %133 = or i64 %132, %131                        ; <i64> [#uses=1]*/
		var133 = var132 | var131;
		/*   %.mask = and i64 %132, 4611686018427387904      ; <i64> [#uses=2]*/
		_mask = var132 & 64'd4611686018427387904;
		/*   br label %bb22_12*/
		cur_state = bb22_12;
	end
	bb22_12:
	begin
		/*   %134 = icmp eq i64 %.mask, 0                    ; <i1> [#uses=1]*/
		var134 = _mask == 64'd0;
		/*   %.mask.lobit = lshr i64 %.mask, 62              ; <i64> [#uses=1]*/
		_mask_lobit = _mask >>> (64'd62 % 64);
		/*   br label %bb22_13*/
		cur_state = bb22_13;
	end
	bb22_13:
	begin
		/*   %tmp = xor i64 %.mask.lobit, 1                  ; <i64> [#uses=1]*/
		tmp = _mask_lobit ^ 64'd1;
		/*   %zExp.0.v = select i1 %134, i32 -1024, i32 -1023 ; <i32> [#uses=1]*/
		zExp_0_v = (var134) ? -32'd1024 : -32'd1023;
		/*   br label %bb22_14*/
		cur_state = bb22_14;
	end
	bb22_14:
	begin
		/*   %zSig0.0 = shl i64 %133, %tmp                   ; <i64> [#uses=1]*/
		zSig0_0 = var133 <<< (tmp % 64);
		/*   %zExp.0 = add i32 %112, %zExp.0.v               ; <i32> [#uses=1]*/
		zExp_0 = var112 + zExp_0_v;
		/*   br label %bb22_15*/
		cur_state = bb22_15;
	end
	bb22_15:
	begin
		/*   %135 = tail call fastcc i64 @roundAndPackFloat64(i32 %10, i32 %zExp.0, i64 %zSig0.0) nounwind ; <i64> [#uses=1]*/
		roundAndPackFloat64_start = 1;
		/* Argument:   %10 = trunc i64 %7 to i32                       ; <i32> [#uses=1]*/
		roundAndPackFloat64_zSign = var10;
		/* Argument:   %zExp.0 = add i32 %112, %zExp.0.v               ; <i32> [#uses=1]*/
		roundAndPackFloat64_zExp = zExp_0;
		/* Argument:   %zSig0.0 = shl i64 %133, %tmp                   ; <i64> [#uses=1]*/
		roundAndPackFloat64_zSig = zSig0_0;
		cur_state = bb22_15_call_0;
	end
	bb22_15_call_0:
	begin
		roundAndPackFloat64_start = 0;
		if (roundAndPackFloat64_finish == 1)
			begin
			var135 = roundAndPackFloat64_return_val;
			cur_state = bb22_15_call_1;
			end
		else
			cur_state = bb22_15_call_0;
	end
	bb22_15_call_1:
	begin
		/*   br label %bb22_16*/
		cur_state = bb22_16;
	end
	bb22_16:
	begin
		/*   ret i64 %135*/
		return_val = var135;
		finish = 1;
		cur_state = Wait;
	end
endcase
always @(*)
begin
	memory_controller_write_enable = 0;
	memory_controller_address = 0;
	memory_controller_in = 0;
		roundAndPackFloat64_memory_controller_out = 0;
	case(cur_state)
	default:
	begin
		// quartus issues a warning if we have no default case
	end
	bb_i48:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb_i48_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var31;
	end
	bb6:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb6_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var39;
	end
	bb_i:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb_i_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var59;
	end
	bb12:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 0;
	end
	bb12_3:
	begin
		memory_controller_address = {`TAG_float_exception_flags, 32'b0};
		memory_controller_write_enable = 1;
		memory_controller_in = var67;
	end
	normalizeFloat64Subnormal_exit38_7:
	begin
		memory_controller_address = var81;
		memory_controller_write_enable = 0;
	end
	normalizeFloat64Subnormal_exit_7:
	begin
		memory_controller_address = var99;
		memory_controller_write_enable = 0;
	end
	bb22_15:
	begin
	end
	bb22_15_call_0:
	begin
		memory_controller_address = roundAndPackFloat64_memory_controller_address;
		memory_controller_write_enable = roundAndPackFloat64_memory_controller_write_enable;
		memory_controller_in = roundAndPackFloat64_memory_controller_in;
		roundAndPackFloat64_memory_controller_out = memory_controller_out;
	end
	bb22_15_call_1:
	begin
	end
	endcase
end
endmodule
`timescale 1 ns / 1 ns
module memset
	(
		clk,
		reset,
		start,
		finish,
		return_val,
		m,
		c,
		n,
		memory_controller_write_enable,
		memory_controller_address,
		memory_controller_in,
		memory_controller_out
	);

output reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] return_val;
input clk;
input reset;
input start;
output reg finish;
input [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] m;
input [31:0] c;
input [31:0] n;
output reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] memory_controller_address;
output reg memory_controller_write_enable;
output reg [`MEMORY_CONTROLLER_DATA_SIZE-1:0] memory_controller_in;
input wire [`MEMORY_CONTROLLER_DATA_SIZE-1:0] memory_controller_out;

reg [3:0] cur_state;

parameter Wait = 4'd0;
parameter entry = 4'd1;
parameter entry_1 = 4'd2;
parameter entry_2 = 4'd3;
parameter bb = 4'd4;
parameter bb_1 = 4'd5;
parameter bb1 = 4'd6;
parameter bb1_1 = 4'd7;
parameter bb1_2 = 4'd8;
parameter bb_nph = 4'd9;
parameter bb2 = 4'd10;
parameter bb2_1 = 4'd11;
parameter bb2_2 = 4'd12;
parameter bb2_3 = 4'd13;
parameter bb2_4 = 4'd14;
parameter bb4 = 4'd15;
reg [31:0] var0;
reg  var1;
reg [7:0] var2;
reg [31:0] var4;
reg [31:0] var5;
reg  var3;
reg [31:0] tmp;
reg [31:0] indvar;
reg [31:0] tmp8;
reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] scevgep;
reg [`MEMORY_CONTROLLER_ADDR_SIZE-1:0] s_07;
reg [31:0] indvar_next;
reg  exitcond;

always @(posedge clk)
if (reset)
	cur_state = Wait;
else
case(cur_state)
	Wait:
	begin
		finish = 0;
		if (start == 1)
			cur_state = entry;
		else
			cur_state = Wait;
	end
	entry:
	begin
		/*   %0 = and i32 %n, 3                              ; <i32> [#uses=1]*/
		var0 = n & 32'd3;
		/*   br label %entry_1*/
		cur_state = entry_1;
	end
	entry_1:
	begin
		/*   %1 = icmp eq i32 %0, 0                          ; <i1> [#uses=1]*/
		var1 = var0 == 32'd0;
		/*   br label %entry_2*/
		cur_state = entry_2;
	end
	entry_2:
	begin
		/*   br i1 %1, label %bb1, label %bb*/
		if (var1) begin
			cur_state = bb1;
		end
		else begin
			cur_state = bb;
		end
	end
	bb:
	begin
		/*   %2 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([32 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]*/
		$write("Expecting word-aligned memset!\n");		/*   br label %bb_1*/
		cur_state = bb_1;
	end
	bb_1:
	begin
		/*   tail call void @exit(i32 1) noreturn nounwind*/
		//$finish;		/*   unreachable*/
	end
	bb1:
	begin
		/*   %3 = trunc i32 %c to i8                         ; <i8> [#uses=1]*/
		var2 = c[7:0];
		/*   %4 = icmp ult i32 %n, 4                         ; <i1> [#uses=1]*/
		var3 = n < 32'd4;
		/*   br label %bb1_1*/
		cur_state = bb1_1;
	end
	bb1_1:
	begin
		/*   %5 = sext i8 %3 to i32                          ; <i32> [#uses=1]*/
		var4 = $signed(var2);
		/*   br label %bb1_2*/
		cur_state = bb1_2;
	end
	bb1_2:
	begin
		/*   %6 = mul i32 %5, 16843009                       ; <i32> [#uses=1]*/
		var5 = var4 * 32'd16843009;
		/*   br i1 %4, label %bb4, label %bb.nph*/
		if (var3) begin
			cur_state = bb4;
		end
		else begin
			cur_state = bb_nph;
		end
	end
	bb_nph:
	begin
		/*   %tmp = lshr i32 %n, 2                           ; <i32> [#uses=1]*/
		tmp = n >>> (32'd2 % 32);
		/*   br label %bb2*/
		indvar = 32'd0;   /* for PHI node */
		cur_state = bb2;
	end
	bb2:
	begin
		/*   %indvar = phi i32 [ 0, %bb.nph ], [ %indvar.next, %bb2_4 ] ; <i32> [#uses=2]*/

		/*   br label %bb2_1*/
		cur_state = bb2_1;
	end
	bb2_1:
	begin
		/*   %tmp8 = shl i32 %indvar, 2                      ; <i32> [#uses=1]*/
		tmp8 = indvar <<< (32'd2 % 32);
		/*   %indvar.next = add i32 %indvar, 1               ; <i32> [#uses=2]*/
		indvar_next = indvar + 32'd1;
		/*   br label %bb2_2*/
		cur_state = bb2_2;
	end
	bb2_2:
	begin
		/*   %scevgep = getelementptr i8* %m, i32 %tmp8      ; <i8*> [#uses=1]*/
		scevgep = m + ((tmp8) << 0);
		/*   %exitcond = icmp eq i32 %indvar.next, %tmp      ; <i1> [#uses=1]*/
		exitcond = indvar_next == tmp;
		/*   br label %bb2_3*/
		cur_state = bb2_3;
	end
	bb2_3:
	begin
		/*   %s.07 = bitcast i8* %scevgep to i32*            ; <i32*> [#uses=1]*/
		s_07 = scevgep;
		/*   br label %bb2_4*/
		cur_state = bb2_4;
	end
	bb2_4:
	begin
		/*   store i32 %6, i32* %s.07, align 4*/
		/*   br i1 %exitcond, label %bb4, label %bb2*/
		if (exitcond) begin
			cur_state = bb4;
		end
		else begin
			indvar = indvar_next;   /* for PHI node */
			cur_state = bb2;
		end
	end
	bb4:
	begin
		/*   ret i8* %m*/
		return_val = m;
		finish = 1;
		cur_state = Wait;
	end
endcase
always @(*)
begin
	memory_controller_write_enable = 0;
	memory_controller_address = 0;
	memory_controller_in = 0;
	case(cur_state)
	default:
	begin
		// quartus issues a warning if we have no default case
	end
	bb2_4:
	begin
		memory_controller_address = s_07;
		memory_controller_write_enable = 1;
		memory_controller_in = var5;
	end
	endcase
end
endmodule
module ram_one_port
(
	clk,
	address,
	write_enable,
	data,
	q
);

parameter width_a = 32;  
parameter widthad_a = 9;
parameter numwords_a = 512;
parameter init_file = "UNUSED";

input clk;
input [(widthad_a-1):0] address;
input write_enable;
input [(width_a-1):0] data;
output [(width_a-1):0] q;

t_bram_sclk	#(.AWIDTH(widthad_a), .DWIDTH(width_a), .DEPTH(numwords_a))
      reg_file1(
				.we_a (write_enable),
				.clk (clk),
				.addr_a (address),
				.addr_b (address),
				.data_a (data),
        .q_a (q)
        );

/*
altsyncram	altsyncram_component (
            .wren_a (write_enable),
            .clock0 (clk),
            .address_a (address),
            .data_a (data),
            .q_a (q),
            .aclr0 (1'b0),
            .aclr1 (1'b0),
            .address_b (1'b1),
            .addressstall_a (1'b0),
            .addressstall_b (1'b0),
            .byteena_a (1'b1),
            .byteena_b (1'b1),
            .clock1 (1'b1),
            .clocken0 (1'b1),
            .clocken1 (1'b1),
            .clocken2 (1'b1),
            .clocken3 (1'b1),
            .data_b (1'b1),
            .eccstatus (),
            .q_b (),
            .rden_a (1'b1),
            .rden_b (1'b1),
            .wren_b (1'b0));

defparam
    altsyncram_component.clock_enable_input_a = "BYPASS",
    altsyncram_component.clock_enable_output_a = "BYPASS",
	 altsyncram_component.init_file = init_file,
    altsyncram_component.intended_device_family = "Stratix IV",
    altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
    altsyncram_component.lpm_type = "altsyncram",
    altsyncram_component.numwords_a = numwords_a,
    altsyncram_component.operation_mode = "SINGLE_PORT",
    altsyncram_component.outdata_aclr_a = "NONE",
    altsyncram_component.outdata_reg_a = "UNREGISTERED",
    altsyncram_component.power_up_uninitialized = "FALSE",
    altsyncram_component.read_during_write_mode_port_a = "DONT_CARE",
    altsyncram_component.widthad_a = widthad_a,
    altsyncram_component.width_a = width_a,
    altsyncram_component.width_byteena_a = 1;
*/
endmodule 

module t_bram_sclk #(parameter AWIDTH = 5,
parameter DWIDTH = 32, parameter DEPTH = 32)
(
	data_a, 
  addr_a, 
  addr_b,
	we_a,
  clk,
	q_a
);

  input [DWIDTH-1 :0] data_a;
  input [AWIDTH-1 :0] addr_a, addr_b;
  input we_a, clk;
  output reg [DWIDTH-1 :0] q_a;
  
	// Declare the RAM variable
	reg [DWIDTH-1 :0] ram[DEPTH-1 :0];
	
	// Port A
	always @ (posedge clk)
	begin
		if (we_a) 
			ram[addr_a] <= data_a;
		q_a <= ram[addr_b];
	end
	

endmodule
