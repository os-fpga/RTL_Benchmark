`timescale 1ns / 1ps
/* FQCtrl.v
 * Bandwidth control unit for FQ. One per FQ. The path from in_ready to
 * out_timestamp completes in 1 cycle.
 *
 * Config path
 *      config_in -> {bandwidth, latency} -> config_out
 */
`include "const.v"
module FQCtrl(
    clock,
    reset,
    in_ready,
    in_timestamp,
    out_timestamp,
    config_in,
    config_in_valid,
    config_out,
    config_out_valid,
    bandwidth,
    latency
);
    localparam RESET = 0, COUNT = 1;
    
    input   clock;
    input   reset;
    input                   in_ready;
    input   [`TS_WIDTH-1:0] in_timestamp;    
    output  [`TS_WIDTH-1:0] out_timestamp;
    
    // Config ports
    input                   config_in_valid;
    input           [15: 0] config_in;
    output                  config_out_valid;
    output          [15: 0] config_out;

    // Exposing parameters
    output  [`BW_WIDTH-1:0] bandwidth;
    output [`LAT_WIDTH-1:0] latency;

    // Internal states
    reg     [`BW_WIDTH-1:0] bandwidth;
    reg    [`LAT_WIDTH-1:0] latency;
    reg     [`BW_WIDTH-1:0] count;
    reg     [`TS_WIDTH-1:0] last_ts;
    
    // Wires
    reg     [`BW_WIDTH-1:0] w_count;
    reg     [`TS_WIDTH-1:0] w_ts_bw_component;
    
    // Output
    assign config_out_valid = config_in_valid;
    assign config_out = {bandwidth, latency};
    assign out_timestamp = w_ts_bw_component + {2'b00, latency};
    
    //
    // Configuration logic
    //
    always @(posedge clock)
    begin
        if (reset)
            {bandwidth, latency} <= {(`BW_WIDTH+`LAT_WIDTH){1'b0}};
        else if (config_in_valid)
            {bandwidth, latency} <= config_in;
    end

    //
    // FQ Control
    //
	wire w_in_timestamp_gt_last_ts;
	wire [`TS_WIDTH-1:0] w_ts_diff;
	
	assign w_ts_diff = last_ts - in_timestamp;
	assign w_in_timestamp_gt_last_ts = w_ts_diff[`TS_WIDTH-1];
	
    always @(*)
    begin
        w_count = count;
        w_ts_bw_component = in_timestamp;
        
        if (in_ready)
        begin
            if (count == bandwidth || w_in_timestamp_gt_last_ts == 1'b1)
                w_count = 1;
            else
                w_count = count + 1;
            
            // Huge area...
            if (w_in_timestamp_gt_last_ts)
                w_ts_bw_component = in_timestamp;
            else if (count == bandwidth)
                w_ts_bw_component = last_ts + 1;
            else
                w_ts_bw_component = last_ts;
        end
    end
    
    always @(posedge clock)
    begin
        if (reset)
        begin
            last_ts <= 0;
            count   <= 0;
        end
        else if (in_ready)
        begin
            last_ts <= w_ts_bw_component;
            count   <= w_count;
        end
    end

endmodule

