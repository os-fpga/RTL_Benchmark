// Copyright (C) 2022 RapidSilicon
//

// Basic DFF

module \$_DFF_P_ (D, C, Q);
    input D;
    input C;
    output Q;
    dff _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C));
endmodule

// Async reset
module \$_DFF_PP0_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(!R), .S(1'b1));
endmodule

// Async reset
module \$_DFF_PN0_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(R), .S(1'b1));
endmodule

// Async set
module \$_DFF_PP1_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(1'b1), .S(!R));
endmodule

// Async set
module \$_DFF_PN1_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(1'b1), .S(R));
endmodule

module  \$_DFFE_PP_ (D, C, E, Q);
    input D;
    input C;
    input E;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(1'b1), .S(1'b1));
endmodule

module  \$_DFFE_PN_ (D, C, E, Q);
    input D;
    input C;
    input E;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(1'b1), .S(1'b1));
endmodule

// Async reset, enable
module  \$_DFFE_PP0P_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(!R), .S(1'b1));
endmodule

module  \$_DFFE_PP0N_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(!R), .S(1'b1));
endmodule

module  \$_DFFE_PN0P_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(R), .S(1'b1));
endmodule

module  \$_DFFE_PN0N_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(R), .S(1'b1));
endmodule
// Async set, enable

module  \$_DFFE_PP1P_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(1'b1), .S(!R));
endmodule

module  \$_DFFE_PP1N_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(1'b1), .S(!R));
endmodule

module  \$_DFFE_PN1P_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(1'b1), .S(R));
endmodule

module  \$_DFFE_PN1N_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(1'b1), .S(R));
endmodule

// Async set & reset

module \$_DFFSR_PPP_ (D, C, R, S, Q);
    input D;
    input C;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(!R), .S(!S));
endmodule

module \$_DFFSR_PNP_ (D, Q, C, R, S);
    input D;
    input C;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(!R), .S(S));
endmodule

module \$_DFFSR_PNN_ (D, Q, C, R, S);
    input D;
    input C;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(R), .S(S));
endmodule

module \$_DFFSR_PPN_ (D, Q, C, R, S);
    input D;
    input C;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(R), .S(!S));
endmodule

module \$_DFFSR_NPP_ (D, Q, C, R, S);
    input D;
    input C;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(!R), .S(!S));
endmodule

module \$_DFFSR_NNP_ (D, Q, C, R, S);
    input D;
    input C;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(!R), .S(S));
endmodule

module \$_DFFSR_NNN_ (D, Q, C, R, S);
    input D;
    input C;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(R), .S(S));
endmodule

module \$_DFFSR_NPN_ (D, Q, C, R, S);
    input D;
    input C;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(R), .S(!S));
endmodule

// Async set, reset & enable

module \$_DFFSRE_PPPP_ (D, Q, C, E, R, S);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(!R), .S(!S));
endmodule

module \$_DFFSRE_PNPP_ (D, Q, C, E, R, S);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(!R), .S(S));
endmodule

module \$_DFFSRE_PPNP_ (D, Q, C, E, R, S);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(R), .S(!S));
endmodule

module \$_DFFSRE_PNNP_ (D, Q, C, E, R, S);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(R), .S(S));
endmodule

module \$_DFFSRE_PPPN_ (D, Q, C, E, R, S);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(!R), .S(!S));
endmodule

module \$_DFFSRE_PNPN_ (D, Q, C, E, R, S);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(!R), .S(S));
endmodule

module \$_DFFSRE_PPNN_ (D, Q, C, E, R, S);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(R), .S(!S));
endmodule

module \$_DFFSRE_PNNN_ (D, Q, C, E, R, S);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(R), .S(S));
endmodule

// Latch with async set and reset
module  \$_DLATCHSR_PPP_ (input E, S, R, D, output Q);
    latchsre _TECHMAP_REPLACE_ (.D(D), .Q(Q), .E(1'b1), .G(E),  .R(!R), .S(!S));
endmodule

module  \$_DLATCHSR_NPP_ (input E, S, R, D, output Q);
    latchnsre _TECHMAP_REPLACE_ (.D(D), .Q(Q), .E(1'b1), .G(E),  .R(!R), .S(!S));
endmodule

module \$_DFF_N_ (D, C, Q);
    input D;
    input C;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    dffn _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C));
endmodule

module \$_DFF_NP0_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(!R), .S(1'b1));
endmodule

module \$_DFF_NN0_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(R), .S(1'b1));
endmodule

module \$_DFF_NP1_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(1'b1), .S(!R));
endmodule

module \$_DFF_NN1_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(1'b1), .R(1'b1), .S(R));
endmodule

module  \$_DFFE_NP_ (D, C, E, Q);
    input D;
    input C;
    input E;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(1'b1), .S(1'b1));
endmodule

module  \$_DFFE_NN_ (D, C, E, Q);
    input D;
    input C;
    input E;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(1'b1), .S(1'b1));
endmodule

module  \$_DFFE_NP0P_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(!R), .S(1'b1));
endmodule

module  \$_DFFE_NP0N_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(!R), .S(1'b1));
endmodule

module  \$_DFFE_NN0P_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(R), .S(1'b1));
endmodule

module  \$_DFFE_NN0N_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(R), .S(1'b1));
endmodule

module  \$_DFFE_NP1P_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(1'b1), .S(!R));
endmodule

module  \$_DFFE_NP1N_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(1'b1), .S(!R));
endmodule

module  \$_DFFE_NN1P_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(1'b1), .S(R));
endmodule

module  \$_DFFE_NN1N_ (D, C, E, R, Q);
    input D;
    input C;
    input E;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(1'b1), .S(R));
endmodule

module \$_DFFSRE_NPPP_ (D, C, E, R, S, Q);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(!R), .S(!S));
endmodule

module \$_DFFSRE_NNPP_ (D, C, E, R, S, Q);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(!R), .S(S));
endmodule

module \$_DFFSRE_NPNP_ (D, C, E, R, S, Q);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(R), .S(!S));
endmodule

module \$_DFFSRE_NNNP_ (D, C, E, R, S, Q);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(E), .R(R), .S(S));
endmodule


module \$_DFFSRE_NPPN_ (D, C, E, R, S, Q);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(!R), .S(!S));
endmodule

module \$_DFFSRE_NNPN_ (D, C, E, R, S, Q);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(!R), .S(S));
endmodule

module \$_DFFSRE_NPNN_ (D, C, E, R, S, Q);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(R), .S(!S));
endmodule

module \$_DFFSRE_NNNN_ (D, C, E, R, S, Q);
    input D;
    input C;
    input E;
    input R;
    input S;
    output Q;
    dffnsre _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .E(!E), .R(R), .S(S));
endmodule

module \$__SHREG_DFF_P_ (D, Q, C);
    input D;
    input C;
    output Q;

    parameter DEPTH = 2;
    reg [DEPTH-2:0] q;
    genvar i;
    generate for (i = 0; i < DEPTH; i = i + 1) begin: slice


        // First in chain
        generate if (i == 0) begin
                 sh_dff #() shreg_beg (
                    .Q(q[i]),
                    .D(D),
                    .C(C)
                );
        end endgenerate
        // Middle in chain
        generate if (i > 0 && i != DEPTH-1) begin
                 sh_dff #() shreg_mid (
                    .Q(q[i]),
                    .D(q[i-1]),
                    .C(C)
                );
        end endgenerate
        // Last in chain
        generate if (i == DEPTH-1) begin
                 sh_dff #() shreg_end (
                    .Q(Q),
                    .D(q[i-1]),
                    .C(C)
                );
        end endgenerate
   end: slice
   endgenerate

endmodule

// Sync reset
module \$_SDFF_PP0_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    sdffr _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .R(R));
endmodule

module \$_SDFF_PN0_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    sdffr _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .R(!R));
endmodule

module \$_SDFF_NP0_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    sdffr #(.IS_C_INVERTED(1'b1)) _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .R(R));
endmodule

module \$_SDFF_NN0_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    parameter _TECHMAP_WIREINIT_Q_ = 1'bx;
    sdffr #(.IS_C_INVERTED(1'b1)) _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .R(!R));
endmodule

// Sync set
module \$_SDFF_PP1_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    sdffs _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .S(R));
endmodule

module \$_SDFF_PN1_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    sdffs _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .S(!R));
endmodule

module \$_SDFF_NP1_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    sdffs #(.IS_C_INVERTED(1'b1)) _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .S(R));
endmodule

module \$_SDFF_NN1_ (D, C, R, Q);
    input D;
    input C;
    input R;
    output Q;
    sdffs #(.IS_C_INVERTED(1'b1)) _TECHMAP_REPLACE_ (.Q(Q), .D(D), .C(C), .S(!R));
endmodule
