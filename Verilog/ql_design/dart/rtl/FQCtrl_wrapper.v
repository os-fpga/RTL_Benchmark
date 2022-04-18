`timescale 1ns / 1ps
/* FQCtrl_test.v
 * Wrapper module to test the critical path of FQCtrl
 */
`include "const.v"
module FQCtrl_wrapper(
    clock,
    reset,
    in_ready,
    in_timestamp,
    config_in,
    config_in_valid,
    out
);
    input                   clock;
    input                   reset;
    input                   in_ready;
    input   [`TS_WIDTH-1:0] in_timestamp;    
    output           [15:0] out;
    
    // Config ports
    input                   config_in_valid;
    input           [15: 0] config_in;
    
    reg                     r_in_ready;
    reg     [`TS_WIDTH-1:0] r_in_timestamp;
    reg             [15: 0] r_config_in;
    reg                     r_config_in_valid;
    reg     [`TS_WIDTH-1:0] r_out_timestamp;
    reg             [15: 0] r_config_out;
    reg                     r_config_out_valid;
    
    wire    [`TS_WIDTH-1:0] w_out_timestamp;
    wire            [15: 0] w_config_out;
    wire                    w_config_out_valid;
    
    assign out = (r_config_out_valid) ? r_config_out : r_out_timestamp;
    
    always @(posedge clock or posedge reset)
    begin
        if (reset)
        begin
            r_in_ready <= 0;
            r_in_timestamp <= 0;
            r_config_in <= 0;
            r_config_in_valid <= 0;
            r_out_timestamp <= 0;
            r_config_out <= 0;
            r_config_out_valid <= 0;
        end
        else
        begin
            r_in_ready <= in_ready;
            r_in_timestamp <= in_timestamp;
            r_config_in <= config_in;
            r_config_in_valid <= config_in_valid;
            r_out_timestamp <= w_out_timestamp;
            r_config_out <= w_config_out;
            r_config_out_valid <= w_config_out_valid;
        end
    end
    
    FQCtrl ut (
        .clock (clock),
        .reset (reset),
        .in_ready (r_in_ready),
        .in_timestamp (r_in_timestamp),
        .out_timestamp (w_out_timestamp),
        .config_in (r_config_in),
        .config_in_valid (r_config_in_valid),
        .config_out (w_config_out),
        .config_out_valid (w_config_out_valid));


endmodule
