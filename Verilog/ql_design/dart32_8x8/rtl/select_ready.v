`timescale 1 ns/100 ps  // time unit = 1ns; precision = 1/10 ns
/* Select Ready
 *
 * Input: N-bit ready and N-bit ready-urgent
 * Output: N-bit grant vector
 * Selects 1 ready input (priority to urgent-ready signals) among the requesters
 */
module select_ready #(
    parameter N = 2
)
(
    input [N-1:0]   ready,
    input [N-1:0]   ready_urgent,
    output [N-1:0]  sel,
    output          sel_valid,
    output          sel_valid_urgent
);

    wire [N-1:0]    w_sel_normal;
    wire [N-1:0]    w_sel_urgent;

    arbiter_static #(.SIZE(N)) arb_normal (
        .requests (ready),
        .grants (w_sel_normal),
        .grant_valid (sel_valid));

    arbiter_static #(.SIZE(N)) arb_urgent (
        .requests (ready_urgent),
        .grants (w_sel_urgent),
        .grant_valid (sel_valid_urgent));

    assign sel = (sel_valid_urgent == 1'b1) ? w_sel_urgent : w_sel_normal;

endmodule

