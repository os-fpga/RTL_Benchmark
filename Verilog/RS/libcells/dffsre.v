module \$_BUF_ (A, Y);
input A;
output Y;
assign Y = A;
endmodule

module \$_TBUF_ (A, E, Y);
input A, E;
output Y;
assign Y = E ? A : 1'bz;
endmodule

module dff(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input C
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge C)
        Q <= D;
endmodule

module dffn(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input C
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(negedge C)
        Q <= D;
endmodule

module dffsre(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input C,
    input E,
    input R,
    input S
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;

    always @(posedge C or negedge S or negedge R)
        if (!R)
            Q <= 1'b0;
        else if (!S)
            Q <= 1'b1;
        else if (E)
            Q <= D;
        
endmodule

module dffnsre(
    output reg Q,
    input D,
    (* clkbuf_sink *)
    input C,
    input E,
    input R,
    input S
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;

    always @(negedge C or negedge S or negedge R)
        if (!R)
            Q <= 1'b0;
        else if (!S)
            Q <= 1'b1;
        else if (E)
            Q <= D;
        
endmodule

module latchsre (
    output reg Q,
    input S,
    input R,
    input D,
    input G,
    input E
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @*
        if (!R) 
            Q <= 1'b0;
        else if (!S) 
            Q <= 1'b1;
        else if (E && G) 
            Q <= D;
endmodule

module latchnsre (
    output reg Q,
    input S,
    input R,
    input D,
    input G,
    input E
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @*
        if (!R) 
            Q <= 1'b0;
        else if (!S) 
            Q <= 1'b1;
        else if (E && !G) 
            Q <= D;
endmodule

module adder_carry(
    output sumout,
    output cout,
    input p,
    input g,
    input cin
);
    assign sumout = p ^ cin;
    assign cout = p ? cin : g;

endmodule

module \$alu (A, B, CI, BI, X, Y, CO);

parameter A_SIGNED = 0;
parameter B_SIGNED = 0;
parameter A_WIDTH = 1;
parameter B_WIDTH = 1;
parameter Y_WIDTH = 1;

input [A_WIDTH-1:0] A;      // Input operand
input [B_WIDTH-1:0] B;      // Input operand
output [Y_WIDTH-1:0] X;     // A xor B (sign-extended, optional B inversion,
                            //          used in combination with
                            //          reduction-AND for $eq/$ne ops)
output [Y_WIDTH-1:0] Y;     // Sum

input CI;                   // Carry-in (set for $sub)rs

wire [Y_WIDTH-1:0] AA, BB;

generate
	if (A_SIGNED && B_SIGNED) begin:BLOCK1
		assign AA = $signed(A), BB = BI ? ~$signed(B) : $signed(B);
	end else begin:BLOCK2
		assign AA = $unsigned(A), BB = BI ? ~$unsigned(B) : $unsigned(B);
	end
endgenerate

// this is 'x' if Y and CO should be all 'x', and '0' otherwise
wire y_co_undef = ^{A, A, B, B, CI, CI, BI, BI};

assign X = AA ^ BB;
// Full adder
assign Y = (AA + BB + CI) ^ {Y_WIDTH{y_co_undef}};

function get_carry;
	input a, b, c;
	get_carry = (a&b) | (a&c) | (b&c);
endfunction

genvar i;
generate
	assign CO[0] = get_carry(AA[0], BB[0], CI) ^ y_co_undef;
	for (i = 1; i < Y_WIDTH; i = i+1) begin:BLOCK3
		assign CO[i] = get_carry(AA[i], BB[i], CO[i-1]) ^ y_co_undef;
	end
endgenerate

endmodule

// ************************************************************************ //
module \$mem_v2 (RD_CLK, RD_EN, RD_ARST, RD_SRST, RD_ADDR, RD_DATA, WR_CLK, WR_EN, WR_ADDR, WR_DATA);

parameter MEMID = "";
parameter signed SIZE = 4;
parameter signed OFFSET = 0;
parameter signed ABITS = 2;
parameter signed WIDTH = 8;
parameter signed INIT = 1'bx;

parameter signed RD_PORTS = 1;
parameter RD_CLK_ENABLE = 1'b1;
parameter RD_CLK_POLARITY = 1'b1;
parameter RD_TRANSPARENCY_MASK = 1'b0;
parameter RD_COLLISION_X_MASK = 1'b0;
parameter RD_WIDE_CONTINUATION = 1'b0;
parameter RD_CE_OVER_SRST = 1'b0;
parameter RD_ARST_VALUE = 1'b0;
parameter RD_SRST_VALUE = 1'b0;
parameter RD_INIT_VALUE = 1'b0;

parameter signed WR_PORTS = 1;
parameter WR_CLK_ENABLE = 1'b1;
parameter WR_CLK_POLARITY = 1'b1;
parameter WR_PRIORITY_MASK = 1'b0;
parameter WR_WIDE_CONTINUATION = 1'b0;

input [RD_PORTS-1:0] RD_CLK;
input [RD_PORTS-1:0] RD_EN;
input [RD_PORTS-1:0] RD_ARST;
input [RD_PORTS-1:0] RD_SRST;
input [RD_PORTS*ABITS-1:0] RD_ADDR;
output reg [RD_PORTS*WIDTH-1:0] RD_DATA;

input [WR_PORTS-1:0] WR_CLK;
input [WR_PORTS*WIDTH-1:0] WR_EN;
input [WR_PORTS*ABITS-1:0] WR_ADDR;
input [WR_PORTS*WIDTH-1:0] WR_DATA;

reg [WIDTH-1:0] memory [SIZE-1:0];

integer i, j, k;
reg [WR_PORTS-1:0] LAST_WR_CLK;
reg [RD_PORTS-1:0] LAST_RD_CLK;

function port_active;
	input clk_enable;
	input clk_polarity;
	input last_clk;
	input this_clk;
	begin
		casez ({clk_enable, clk_polarity, last_clk, this_clk})
			4'b0???: port_active = 1;
			4'b1101: port_active = 1;
			4'b1010: port_active = 1;
			default: port_active = 0;
		endcase
	end
endfunction

initial begin
	for (i = 0; i < SIZE; i = i+1)
		memory[i] = INIT >>> (i*WIDTH);
	RD_DATA = RD_INIT_VALUE;
end

always @(RD_CLK, RD_ARST, RD_ADDR, RD_DATA, WR_CLK, WR_EN, WR_ADDR, WR_DATA) begin
`ifdef SIMLIB_MEMDELAY
	#`SIMLIB_MEMDELAY;
`endif
	for (i = 0; i < RD_PORTS; i = i+1) begin
		if (RD_CLK_ENABLE[i] && RD_EN[i] && port_active(RD_CLK_ENABLE[i], RD_CLK_POLARITY[i], LAST_RD_CLK[i], RD_CLK[i])) begin
			// $display("Read from %s: addr=%b data=%b", MEMID, RD_ADDR[i*ABITS +: ABITS],  memory[RD_ADDR[i*ABITS +: ABITS] - OFFSET]);
			RD_DATA[i*WIDTH +: WIDTH] <= memory[RD_ADDR[i*ABITS +: ABITS] - OFFSET];

			for (j = 0; j < WR_PORTS; j = j+1) begin
				if (RD_TRANSPARENCY_MASK[i*WR_PORTS + j] && port_active(WR_CLK_ENABLE[j], WR_CLK_POLARITY[j], LAST_WR_CLK[j], WR_CLK[j]) && RD_ADDR[i*ABITS +: ABITS] == WR_ADDR[j*ABITS +: ABITS])
					for (k = 0; k < WIDTH; k = k+1)
						if (WR_EN[j*WIDTH+k])
							RD_DATA[i*WIDTH+k] <= WR_DATA[j*WIDTH+k];
				if (RD_COLLISION_X_MASK[i*WR_PORTS + j] && port_active(WR_CLK_ENABLE[j], WR_CLK_POLARITY[j], LAST_WR_CLK[j], WR_CLK[j]) && RD_ADDR[i*ABITS +: ABITS] == WR_ADDR[j*ABITS +: ABITS])
					for (k = 0; k < WIDTH; k = k+1)
						if (WR_EN[j*WIDTH+k])
							RD_DATA[i*WIDTH+k] <= 1'bx;
			end
		end
	end

	for (i = 0; i < WR_PORTS; i = i+1) begin
		if (port_active(WR_CLK_ENABLE[i], WR_CLK_POLARITY[i], LAST_WR_CLK[i], WR_CLK[i]))
			for (j = 0; j < WIDTH; j = j+1)
				if (WR_EN[i*WIDTH+j]) begin
					// $display("Write to %s: addr=%b data=%b", MEMID, WR_ADDR[i*ABITS +: ABITS], WR_DATA[i*WIDTH+j]);
					memory[WR_ADDR[i*ABITS +: ABITS] - OFFSET][j] = WR_DATA[i*WIDTH+j];
				end
	end

	for (i = 0; i < RD_PORTS; i = i+1) begin
		if (!RD_CLK_ENABLE[i]) begin
			// $display("Combinatorial read from %s: addr=%b data=%b", MEMID, RD_ADDR[i*ABITS +: ABITS],  memory[RD_ADDR[i*ABITS +: ABITS] - OFFSET]);
			RD_DATA[i*WIDTH +: WIDTH] <= memory[RD_ADDR[i*ABITS +: ABITS] - OFFSET];
		end
	end

	for (i = 0; i < RD_PORTS; i = i+1) begin
		if (RD_SRST[i] && port_active(RD_CLK_ENABLE[i], RD_CLK_POLARITY[i], LAST_RD_CLK[i], RD_CLK[i]) && (RD_EN[i] || !RD_CE_OVER_SRST[i]))
			RD_DATA[i*WIDTH +: WIDTH] <= RD_SRST_VALUE[i*WIDTH +: WIDTH];
		if (RD_ARST[i])
			RD_DATA[i*WIDTH +: WIDTH] <= RD_ARST_VALUE[i*WIDTH +: WIDTH];
	end

	LAST_RD_CLK <= RD_CLK;
	LAST_WR_CLK <= WR_CLK;
end

endmodule

//*******************************************************************************//
module \$bmux (A, S, Y);

parameter WIDTH = 0;
parameter S_WIDTH = 0;

input [(WIDTH << S_WIDTH)-1:0] A;
input [S_WIDTH-1:0] S;
output [WIDTH-1:0] Y;

wire [WIDTH-1:0] bm0_out, bm1_out;

generate
	if (S_WIDTH > 1) begin:muxlogic
		\$bmux #(.WIDTH(WIDTH), .S_WIDTH(S_WIDTH-1)) bm0 (.A(A), .S(S[S_WIDTH-2:0]), .Y(bm0_out));
		\$bmux #(.WIDTH(WIDTH), .S_WIDTH(S_WIDTH-1)) bm1 (.A(A[(WIDTH << S_WIDTH)-1:WIDTH << (S_WIDTH - 1)]), .S(S[S_WIDTH-2:0]), .Y(bm1_out));
		assign Y = S[S_WIDTH-1] ? bm1_out : bm0_out;
	end else if (S_WIDTH == 1) begin:simple
		assign Y = S ? A[1] : A[0];
	end else begin:passthru
		assign Y = A;
	end
endgenerate

endmodule

//**************************************************************************//

module \$lut (A, Y);

parameter WIDTH = 0;
parameter LUT = 0;

input [WIDTH-1:0] A;
output Y;

\$bmux #(.WIDTH(1), .S_WIDTH(WIDTH)) mux(.A(LUT), .S(A), .Y(Y));

endmodule

module RS_DSP2 ( // TODO: Name subject to change
      input  wire [19:0] a,
      input  wire [17:0] b,
      input  wire [ 5:0] acc_fir,
      output wire [37:0] z,
      output wire [17:0] dly_b,

    (* clkbuf_sink *)
    input wire        clk,
    input wire        reset,

    input wire [2:0] feedback,
    input wire        load_acc,
    input wire        unsigned_a,
    input wire        unsigned_b,

    input wire        f_mode,
    input wire [2:0] output_select,
    input wire        saturate_enable,
    input wire [5:0] shift_right,
    input wire        round,
    input wire        subtract,
    input wire        register_inputs
);

    parameter [79:0] MODE_BITS = 80'd0;

    localparam [19:0] COEFF_0 = MODE_BITS[19:0];
    localparam [19:0] COEFF_1 = MODE_BITS[39:20];
    localparam [19:0] COEFF_2 = MODE_BITS[59:40];
    localparam [19:0] COEFF_3 = MODE_BITS[79:60];

      localparam NBITS_ACC = 64;
      localparam NBITS_A = 20;
      localparam NBITS_B = 18;
      localparam NBITS_Z = 38;

      wire [NBITS_Z-1:0] dsp_full_z;
      wire [(NBITS_Z/2)-1:0] dsp_frac0_z;
      wire [(NBITS_Z/2)-1:0] dsp_frac1_z;

      wire [NBITS_B-1:0] dsp_full_dly_b;
      wire [(NBITS_B/2)-1:0] dsp_frac0_dly_b;
      wire [(NBITS_B/2)-1:0] dsp_frac1_dly_b;

      assign z = f_mode ? {dsp_frac1_z, dsp_frac0_z} : dsp_full_z;
      assign dly_b = f_mode ? {dsp_frac1_dly_b, dsp_frac0_dly_b} : dsp_full_dly_b;

    // Output used when fmode == 1
        dsp_t1_sim #(
        .NBITS_A(NBITS_A/2),
            .NBITS_B(NBITS_B/2),
            .NBITS_ACC(NBITS_ACC/2),
            .NBITS_Z(NBITS_Z/2)
        ) dsp_frac0 (
            .a_i(a[(NBITS_A/2)-1:0]),
            .b_i(b[(NBITS_B/2)-1:0]),
            .z_o(dsp_frac0_z),
            .dly_b_o(dsp_frac0_dly_b),

            .acc_fir_i(acc_fir),
            .feedback_i(feedback),
            .load_acc_i(load_acc),

            .unsigned_a_i(unsigned_a),
            .unsigned_b_i(unsigned_b),

            .clock_i(clk),
            .s_reset(reset),

            .saturate_enable_i(saturate_enable),
            .output_select_i(output_select),
            .round_i(round),
            .shift_right_i(shift_right),
            .subtract_i(subtract),
            .register_inputs_i(register_inputs),
            .coef_0_i(COEFF_0[(NBITS_A/2)-1:0]),
            .coef_1_i(COEFF_1[(NBITS_A/2)-1:0]),
            .coef_2_i(COEFF_2[(NBITS_A/2)-1:0]),
            .coef_3_i(COEFF_3[(NBITS_A/2)-1:0])
        );

    // Output used when fmode == 1
        dsp_t1_sim #(
        .NBITS_A(NBITS_A/2),
            .NBITS_B(NBITS_B/2),
            .NBITS_ACC(NBITS_ACC/2),
            .NBITS_Z(NBITS_Z/2)
        ) dsp_frac1 (
            .a_i(a[NBITS_A-1:NBITS_A/2]),
            .b_i(b[NBITS_B-1:NBITS_B/2]),
            .z_o(dsp_frac1_z),
            .dly_b_o(dsp_frac1_dly_b),

            .acc_fir_i(acc_fir),
            .feedback_i(feedback),
            .load_acc_i(load_acc),

            .unsigned_a_i(unsigned_a),
            .unsigned_b_i(unsigned_b),

            .clock_i(clk),
            .s_reset(reset),

            .saturate_enable_i(saturate_enable),
            .output_select_i(output_select),
            .round_i(round),
            .shift_right_i(shift_right),
            .subtract_i(subtract),
            .register_inputs_i(register_inputs),
            .coef_0_i(COEFF_0[NBITS_A-1:NBITS_A/2]),
            .coef_1_i(COEFF_1[NBITS_A-1:NBITS_A/2]),
            .coef_2_i(COEFF_2[NBITS_A-1:NBITS_A/2]),
            .coef_3_i(COEFF_3[NBITS_A-1:NBITS_A/2])
        );

    // Output used when fmode == 0
        dsp_t1_sim #(
             .NBITS_A(NBITS_A),
             .NBITS_B(NBITS_B),
             .NBITS_ACC(NBITS_ACC),
             .NBITS_Z(NBITS_Z)
        ) dsp_full (
            .a_i(a),
            .b_i(b),
            .z_o(dsp_full_z),
            .dly_b_o(dsp_full_dly_b),

            .acc_fir_i(acc_fir),
            .feedback_i(feedback),
            .load_acc_i(load_acc),

            .unsigned_a_i(unsigned_a),
            .unsigned_b_i(unsigned_b),

            .clock_i(clk),
            .s_reset(reset),

            .saturate_enable_i(saturate_enable),
            .output_select_i(output_select),
            .round_i(round),
            .shift_right_i(shift_right),
            .subtract_i(subtract),
            .register_inputs_i(register_inputs),
            .coef_0_i(COEFF_0),
            .coef_1_i(COEFF_1),
            .coef_2_i(COEFF_2),
            .coef_3_i(COEFF_3)
        );
endmodule

module RS_DSP2_MULT ( // TODO: Name subject to change
    input  wire [19:0] a,
    input  wire [17:0] b,
    output wire [37:0] z,

    // Port not available in architecture file
    input  wire       reset,

    input  wire       unsigned_a,
    input  wire       unsigned_b,

    input  wire       f_mode,
    input  wire [2:0] output_select,
    input  wire       register_inputs
);

    parameter [79:0] MODE_BITS = 80'd0;

    localparam [19:0] COEFF_0 = MODE_BITS[19:0];
    localparam [19:0] COEFF_1 = MODE_BITS[39:20];
    localparam [19:0] COEFF_2 = MODE_BITS[59:40];
    localparam [19:0] COEFF_3 = MODE_BITS[79:60];

    RS_DSP2 #(
        .MODE_BITS({COEFF_3, COEFF_2, COEFF_1, COEFF_0})
    ) dsp (
        .a(a),
        .b(b),
        .z(z),

	.reset(reset),

        .f_mode(f_mode),

        .feedback(3'b0),

        .unsigned_a(unsigned_a),
        .unsigned_b(unsigned_b),

        .output_select(3'b0),	// unregistered output: a * b (0)
        .register_inputs(1'b0)  // unregistered inputs
    );
endmodule

module dsp_t1_sim # (
    parameter NBITS_ACC  = 64,
    parameter NBITS_A    = 20,
    parameter NBITS_B    = 18,
    parameter NBITS_Z    = 38
)(
    input wire [NBITS_A-1:0] a_i,
    input wire [NBITS_B-1:0] b_i,
    output wire [NBITS_Z-1:0] z_o,
    output reg [NBITS_B-1:0] dly_b_o,

    input wire [5:0] acc_fir_i,
    input wire [2:0] feedback_i,
    input wire load_acc_i,

    input wire unsigned_a_i,
    input wire unsigned_b_i,

    input wire clock_i,
    input wire s_reset,

    input wire saturate_enable_i,
    input wire [2:0] output_select_i,
    input wire round_i,
    input wire [5:0] shift_right_i,
    input wire subtract_i,
    input wire register_inputs_i,
    input wire [NBITS_A-1:0] coef_0_i,
    input wire [NBITS_A-1:0] coef_1_i,
    input wire [NBITS_A-1:0] coef_2_i,
    input wire [NBITS_A-1:0] coef_3_i
);

// FIXME: The version of Icarus Verilog from Conda seems not to recognize the
// $error macro. Disable this sanity check for now because of that.
//`ifndef __ICARUS__
//    if (NBITS_ACC < NBITS_A + NBITS_B)
//        $error("NBITS_ACC must be > NBITS_A + NBITS_B");
//`endif

    // Input registers
    reg  [NBITS_A-1:0]  r_a;
    reg  [NBITS_B-1:0]  r_b;
    reg  [5:0]          r_acc_fir;
    reg                 r_unsigned_a;
    reg                 r_unsigned_b;
    reg                 r_load_acc;
    reg  [2:0]          r_feedback;
    reg  [5:0]          r_shift_d1;
    reg  [5:0]          r_shift_d2;
    reg         r_subtract;
    reg         r_sat;
    reg         r_rnd;
    reg [NBITS_ACC-1:0] acc;

    initial begin
        r_a          <= 0;
        r_b          <= 0;

        r_acc_fir    <= 0;
        r_unsigned_a <= 0;
        r_unsigned_b <= 0;
        r_feedback   <= 0;
        r_shift_d1   <= 0;
        r_shift_d2   <= 0;
        r_subtract   <= 0;
        r_load_acc   <= 0;
        r_sat        <= 0;
        r_rnd        <= 0;
    end

    always @(posedge clock_i or posedge s_reset) begin
        if (s_reset) begin

            r_a <= 'h0;
            r_b <= 'h0;

        r_acc_fir    <= 0;
            r_unsigned_a <= 0;
            r_unsigned_b <= 0;
            r_feedback   <= 0;
            r_shift_d1   <= 0;
            r_shift_d2   <= 0;
        r_subtract   <= 0;
            r_load_acc   <= 0;
            r_sat    <= 0;
            r_rnd    <= 0;

        end else begin

            r_a <= a_i;
            r_b <= b_i;

        r_acc_fir    <= acc_fir_i;
            r_unsigned_a <= unsigned_a_i;
            r_unsigned_b <= unsigned_b_i;
            r_feedback   <= feedback_i;
            r_shift_d1   <= shift_right_i;
            r_shift_d2   <= r_shift_d1;
        r_subtract   <= subtract_i;
            r_load_acc   <= load_acc_i;
            r_sat    <= r_sat;
            r_rnd    <= r_rnd;

        end
    end

    // Registered / non-registered input path select
    wire [NBITS_A-1:0]  a = register_inputs_i ? r_a : a_i;
    wire [NBITS_B-1:0]  b = register_inputs_i ? r_b : b_i;

    wire [5:0] acc_fir = register_inputs_i ? r_acc_fir : acc_fir_i;
    wire       unsigned_a = register_inputs_i ? r_unsigned_a : unsigned_a_i;
    wire       unsigned_b = register_inputs_i ? r_unsigned_b : unsigned_b_i;
    wire [2:0] feedback   = register_inputs_i ? r_feedback   : feedback_i;
    wire       load_acc   = register_inputs_i ? r_load_acc   : load_acc_i;
    wire       subtract   = register_inputs_i ? r_subtract   : subtract_i;
    wire       sat    = register_inputs_i ? r_sat : saturate_enable_i;
    wire       rnd    = register_inputs_i ? r_rnd : round_i;

    // Shift right control
    wire [5:0] shift_d1 = register_inputs_i ? r_shift_d1 : shift_right_i;
    wire [5:0] shift_d2 = output_select_i[1] ? shift_d1 : r_shift_d2;

    // Multiplier
    wire unsigned_mode = unsigned_a & unsigned_b;
    wire [NBITS_A-1:0] mult_a;
    assign mult_a = (feedback == 3'h0) ?   a :
                    (feedback == 3'h1) ?   a :
                    (feedback == 3'h2) ?   a :
                    (feedback == 3'h3) ?   acc[NBITS_A-1:0] :
                    (feedback == 3'h4) ?   coef_0_i :
                    (feedback == 3'h5) ?   coef_1_i :
                    (feedback == 3'h6) ?   coef_2_i :
                       coef_3_i;    // if feedback == 3'h7

    wire [NBITS_B-1:0] mult_b = (feedback == 2'h2) ? {NBITS_B{1'b0}}  : b;

    wire [NBITS_A-1:0] mult_sgn_a = mult_a[NBITS_A-1];
    wire [NBITS_A-1:0] mult_mag_a = (mult_sgn_a && !unsigned_a) ? (~mult_a + 1) : mult_a;
    wire [NBITS_B-1:0] mult_sgn_b = mult_b[NBITS_B-1];
    wire [NBITS_B-1:0] mult_mag_b = (mult_sgn_b && !unsigned_b) ? (~mult_b + 1) : mult_b;

    wire [NBITS_A+NBITS_B-1:0] mult_mag = mult_mag_a * mult_mag_b;
    wire mult_sgn = (mult_sgn_a && !unsigned_a) ^ (mult_sgn_b && !unsigned_b);

    wire [NBITS_A+NBITS_B-1:0] mult = (unsigned_a && unsigned_b) ?
        (mult_a * mult_b) : (mult_sgn ? (~mult_mag + 1) : mult_mag);

    // Sign extension
    wire [NBITS_ACC-1:0] mult_xtnd = unsigned_mode ?
        {{(NBITS_ACC-NBITS_A-NBITS_B){1'b0}},                    mult[NBITS_A+NBITS_B-1:0]} :
        {{(NBITS_ACC-NBITS_A-NBITS_B){mult[NBITS_A+NBITS_B-1]}}, mult[NBITS_A+NBITS_B-1:0]};

    // Adder
    wire [NBITS_ACC-1:0] acc_fir_int = unsigned_a ? {{(NBITS_ACC-NBITS_A){1'b0}},         a} :
                                                    {{(NBITS_ACC-NBITS_A){a[NBITS_A-1]}}, a} ;

    wire [NBITS_ACC-1:0] add_a = (subtract) ? (~mult_xtnd + 1) : mult_xtnd;
    wire [NBITS_ACC-1:0] add_b = (feedback_i == 3'h0) ? acc :
                                 (feedback_i == 3'h1) ? {{NBITS_ACC}{1'b0}} : (acc_fir_int << acc_fir);

    wire [NBITS_ACC-1:0] add_o = add_a + add_b;

    // Accumulator
    initial acc <= 0;

    always @(posedge clock_i or posedge s_reset)
        if (s_reset) acc <= 'h0;
        else begin
            if (load_acc)
                acc <= add_o;
            else
                acc <= acc;
        end

    // Adder/accumulator output selection
    wire [NBITS_ACC-1:0] acc_out = (output_select_i[1]) ? add_o : acc;

    // Round, shift, saturate
    wire [NBITS_ACC-1:0] acc_rnd = (rnd && (shift_right_i != 0)) ? (acc_out + ({{(NBITS_ACC-1){1'b0}}, 1'b1} << (shift_right_i - 1))) :
                                                                    acc_out;

    wire [NBITS_ACC-1:0] acc_shr = (unsigned_mode) ? (acc_rnd  >> shift_right_i) :
                                                     (acc_rnd >>> shift_right_i);

    wire [NBITS_ACC-1:0] acc_sat_u = (acc_shr[NBITS_ACC-1:NBITS_Z] != 0) ? {{(NBITS_ACC-NBITS_Z){1'b0}},{NBITS_Z{1'b1}}} :
                                                                           {{(NBITS_ACC-NBITS_Z){1'b0}},{acc_shr[NBITS_Z-1:0]}};

    wire [NBITS_ACC-1:0] acc_sat_s = ((|acc_shr[NBITS_ACC-1:NBITS_Z-1] == 1'b0) ||
                                      (&acc_shr[NBITS_ACC-1:NBITS_Z-1] == 1'b1)) ? {{(NBITS_ACC-NBITS_Z){1'b0}},{acc_shr[NBITS_Z-1:0]}} :
                                                                                   {{(NBITS_ACC-NBITS_Z){1'b0}},{acc_shr[NBITS_ACC-1],{NBITS_Z-1{~acc_shr[NBITS_ACC-1]}}}};

    wire [NBITS_ACC-1:0] acc_sat = (sat) ? ((unsigned_mode) ? acc_sat_u : acc_sat_s) : acc_shr;

    // Output signals
    wire [NBITS_Z-1:0]  z0;
    reg  [NBITS_Z-1:0]  z1;
    wire [NBITS_Z-1:0]  z2;

    assign z0 = mult_xtnd[NBITS_Z-1:0];
    assign z2 = acc_sat[NBITS_Z-1:0];

    initial z1 <= 0;

    always @(posedge clock_i or posedge s_reset)
        if (s_reset)
            z1 <= 0;
        else begin
            z1 <= (output_select_i == 3'b100) ? z0 : z2;
        end

    // Output mux
    assign z_o = (output_select_i == 3'h0) ?   z0 :
                 (output_select_i == 3'h1) ?   z2 :
                 (output_select_i == 3'h2) ?   z2 :
                 (output_select_i == 3'h3) ?   z2 :
                 (output_select_i == 3'h4) ?   z1 :
                 (output_select_i == 3'h5) ?   z1 :
                 (output_select_i == 3'h6) ?   z1 :
                           z1;  // if output_select_i == 3'h7

    // B input delayed passthrough
    initial dly_b_o <= 0;

    always @(posedge clock_i or posedge s_reset)
        if (s_reset)
            dly_b_o <= 0;
        else
            dly_b_o <= b_i;

endmodule