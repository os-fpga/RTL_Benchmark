`timescale 1 ns/100 ps  // time unit = 1ns; precision = 1/10 ns
`include "const.v"

 /* Flit Out Interface
  * flit_out_inf.v
  *
  * Given timestamp of a flit, generate the ready signals.
  * Since we only use 4-bit time differences, a flit that arrives at the output 
  * of the FQ more than 8 steps late will be considered a "future" flit due to
  * timestamp overflow. However, this should not happen because incoming flits to
  * the FQ should never be late.
  * A flit may wait at the output of the FQ for more than 8 steps after its timestamp
  * if the downstream Router cannot route this flit. In this case, the r_valid bi-modal
  * state machine will keep the ready signal high even when timestamp overflows.
  */
  
module flit_out_inf (
    input                   clock,
    input                   reset,
    input                   dequeue,
    input                   flit_valid,
    input   [`TS_WIDTH-1:0] flit_timestamp,
    input   [`TS_WIDTH-1:0] sim_time,
    output                  ready       // ready when flit_timestamp <= sim_time
);
    parameter WIDTH = `TS_WIDTH;        // Number of bits to use to compute time difference

    wire   [WIDTH-1: 0] w_timestamp_diff;
    wire                w_valid;
    reg                 r_valid;
    
    // Ready
    assign w_timestamp_diff = sim_time[WIDTH-1:0] - flit_timestamp[WIDTH-1:0];
    assign w_valid = ~w_timestamp_diff[WIDTH-1] & flit_valid;
    assign ready = w_valid | r_valid;
    
    always @(posedge clock)
    begin
        if (reset)
            r_valid <= 0;
        else if (~r_valid)
            r_valid <= w_valid & ~dequeue;
        else if (dequeue)
            r_valid <= 0;
    end
endmodule
