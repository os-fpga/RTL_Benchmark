`timescale 1 ns/100 ps  // time unit = 1ns; precision = 1/10 ns
/* Select Early x N
 * select_early_N.v
 *
 * Combinational module that selects the earliest of N (= 2^n) input timestamps
 */

module select_early_N (
    ts_in,
    valid,
    tmin,
    sel,
    sel_valid
);
    `include "math.v"

    parameter N = 2;
    parameter WIDTH = 3;    // Width of the timestamp to be compared
    localparam LOG_N = CLogB2(N-1);
    
    input [N*WIDTH-1:0] ts_in;
    input       [N-1:0] valid;
    
    output  [WIDTH-1:0] tmin;
    output  [LOG_N-1:0] sel;
    output              sel_valid;

    // We only support x2, x4 and x8 for now
    // psl ERROR_unsupported_N: assert always {N == 2 || N == 4 || N == 8 || N == 9};

    assign sel_valid = |valid;

    generate
        if (N == 2)
        begin
            wire    [WIDTH-1:0] t0;
            wire    [WIDTH-1:0] t1;
            wire    [WIDTH-1:0] w_tdiff;
            wire                w_early;

            assign t1 = ts_in[2*WIDTH-1:WIDTH];
            assign t0 = ts_in[WIDTH-1:0];
            assign w_tdiff = t1 - t0;
            assign w_early = ~w_tdiff[WIDTH-1]; // w_early = (t1 - t0 >= 0)

            assign sel = (w_early & valid[1]) | ~valid[0];
            assign tmin = (sel == 1'b0) ? t0 : t1;
        end
        else if (N == 4 || N == 8)
        begin
            wire    [WIDTH-1:0] w_tmin;
            wire    [WIDTH-1:0] w_tmin_0;
            wire    [WIDTH-1:0] w_tmin_1;
            wire    [LOG_N-2:0] w_sel_0;
            wire    [LOG_N-2:0] w_sel_1;

            wire          [1:0] w_valid;
            wire                w_sel;
            wire    [LOG_N-2:0] w_sub_sel;

            select_early_N #(.N(N/2), .WIDTH(WIDTH)) u0 (
                .ts_in (ts_in[N/2*WIDTH-1:0]),
                .valid (valid[N/2-1:0]),
                .tmin (w_tmin_0),
                .sel (w_sel_0),
                .sel_valid (w_valid[0]));

            select_early_N #(.N(N/2), .WIDTH(WIDTH)) u1 (
                .ts_in (ts_in[N*WIDTH-1:N/2*WIDTH]),
                .valid (valid[N-1:N/2]),
                .tmin (w_tmin_1),
                .sel (w_sel_1),
                .sel_valid (w_valid[1]));

            select_early_N #(.N(2), .WIDTH(WIDTH)) u (
                .ts_in ({w_tmin_1, w_tmin_0}),
                .valid (w_valid),
                .tmin (w_tmin),
                .sel (w_sel),
                .sel_valid ());

            assign w_sub_sel = (w_sel == 1'b0) ? w_sel_0 : w_sel_1;

            assign tmin = w_tmin;
            assign sel = {w_sel, w_sub_sel};
        end
        else if (N == 9)
        begin
            wire    [WIDTH-1:0] w_tmin_8;
            wire          [2:0] w_sel_8;
            wire                w_valid_8;

            wire                w_sel;
            wire          [2:0] w_sub_sel;
            wire          [1:0] w_tmin;

            select_early_N #(.N(8), .WIDTH(WIDTH)) u8 (
                .ts_in (ts_in[8*WIDTH-1:0]),
                .valid (valid[7:0]),
                .tmin (w_tmin_8),
                .sel (w_sel_8),
                .sel_valid (w_valid_8));

            select_early_N #(.N(2), .WIDTH(WIDTH)) u2 (
                .ts_in ({ts_in[9*WIDTH-1:8*WIDTH], w_tmin_8}),
                .valid ({valid[8], w_valid_8}),
                .tmin (w_tmin),
                .sel (w_sel),
                .sel_valid ());

            assign w_sub_sel = (w_sel == 1'b0) ? w_sel_8 : 3'b000;

            assign tmin = w_tmin;
            assign sel = {w_sel, w_sub_sel};
        end
        else
        begin
            assign tmin = {(WIDTH){1'b0}};
            assign sel = {(LOG_N){1'b0}};
        end
    endgenerate
endmodule

