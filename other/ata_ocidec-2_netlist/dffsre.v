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


module \$_BUF_ (A, Y);
input A;
output Y;
assign Y = A;
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

input CI;                   // Carry-in (set for $sub)
input BI;                   // Invert-B (set for $sub)
output [Y_WIDTH-1:0] CO;    // Carry-out

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