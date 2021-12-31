`timescale 1ns / 1ps
/* CreditCounter
 * CreditCounter.v
 *
 * A single credit counter
 *
 * Config path:
 *      config_in -> r_count -> config_out
 */
module CreditCounter(
    clock,
    reset,
    enable,
    sim_time_tick,
    config_in,
    config_in_valid,
    config_out,
    config_out_valid,
    credit_in_valid,
    credit_ack,
    decrement,
    count_out
);
    parameter WIDTH = 4;            // Width of credit counter
    
    // Global ports
    input                       clock;
    input                       reset;
    input                       enable;
    input                       sim_time_tick;

    // Configuration ports
    input          [WIDTH-1: 0] config_in;
    input                       config_in_valid;
    output         [WIDTH-1: 0] config_out;
    output                      config_out_valid;

    // Credit ports
    input                       credit_in_valid;
    output                      credit_ack;

    input                       decrement;
    output         [WIDTH-1: 0] count_out;
    

    reg     [WIDTH-1:0] r_count;
    reg     [WIDTH-1:0] w_count;
    
    // Output
    assign count_out = r_count;
    assign config_out = r_count;
    assign config_out_valid = config_in_valid;
    assign credit_ack = enable & credit_in_valid;


    always @(posedge clock)
    begin
        if (reset)
            r_count <= 0;
        else if (config_in_valid)
            r_count <= config_in;
        else if (enable)
            r_count <= w_count;
    end

    always @(*)
    begin
        if (credit_in_valid & ~decrement)
            w_count = r_count + 1;
        else if (~credit_in_valid & decrement)
            w_count = r_count - 1;
        else
            w_count = r_count;
    end

endmodule

