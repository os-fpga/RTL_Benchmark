// Copyright (C) 2022 RapidSilicon
//
module \$_BUF_ (A, Y);
input A;
output Y;
assign Y = A;
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



