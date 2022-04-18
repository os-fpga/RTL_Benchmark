`timescale 1 ns/100 ps	// time unit = 1ns; precision = 1/10 ns
/* Rotating Priority Encoder
 * rotate_prio.v
 *
 * Given a set of valid signals and a priority value, output
 * one-hot select vector
 */
module rotate_prio (
    prio,
    in_valid,
    out_sel
);
`include "math.v"

    parameter SIZE = 2;

    input [CLogB2(SIZE-1)-1: 0] prio;
    input           [SIZE-1: 0] in_valid;
    output          [SIZE-1: 0] out_sel;

    wire    [SIZE-1: 0] w_norm_valid;
    wire    [SIZE-1: 0] w_norm_sel;

    assign w_norm_valid = (in_valid << (SIZE - prio)) | (in_valid >> prio);
    assign out_sel = (w_norm_sel << prio) | (w_norm_sel >> (SIZE-prio));

    arbiter_static #(.SIZE(SIZE)) arb (
        .requests (w_norm_valid),
        .grants (w_norm_sel),
        .grant_valid ());

endmodule

