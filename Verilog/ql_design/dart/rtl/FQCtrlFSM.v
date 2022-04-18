`timescale 1ns / 1ps
/* FQCtrlFSM.v
 * Bandwidth control unit for FQ. One per FQ. The path from in_ready to
 * out_timestamp completes in 1 cycle.
 *
 * Config path
 *      config_in -> {bandwidth, latency} -> config_out
 */
 //TODO: Not finished. Use FQCtrl.v instead.
`include "const.v"
module FQCtrlFSM(
    clock,
    reset,
    sim_time,
    sim_time_tick,
    in_ready,
    in_timestamp,
    out_timestamp,
    config_in,
    config_in_valid,
    config_out,
    config_out_valid
);
    localparam RESET = 0, COUNT = 1;
    
    input   clock;
    input   reset;
    input   [`TS_WIDTH-1:0] sim_time;
    input                   sim_time_tick;
    input                   in_ready;
    input   [`TS_WIDTH-1:0] in_timestamp;    
    output  [`TS_WIDTH-1:0] out_timestamp;
    
    // Config ports
    input                   config_in_valid;
    input           [15: 0] config_in;
    output                  config_out_valid;
    output          [15: 0] config_out;

    // Internal states
    reg     [`BW_WIDTH-1:0] bandwidth;
    reg             [ 7: 0] latency;
    reg     [`BW_WIDTH-1:0] count;
    reg     [`TS_WIDTH-1:0] last_ts;
    reg     [`TS_WIDTH-1:0] reset_when;
    
    reg                     state;
    reg                     next_state;
    
    // Wires
    reg             [ 1: 0] w_count_sel;
    reg     [`TS_WIDTH-1:0] w_ts_bw_component;
    wire                    in_ts_is_newer;
    
    // Output
    assign config_out_valid = config_in_valid;
    assign config_out = {bandwidth, latency};
    assign out_timestamp = w_ts_bw_component + latency;
    
    
    // Wires
    assign in_ts_is_newer = (in_timestamp > last_ts) ? 1'b1 : 1'b0;
    
    //
    // Configuration logic
    //
    always @(posedge clock or posedge reset)
    begin
        if (reset)
            {bandwidth, latency} <= {(`BW_WIDTH+8){1'b0}};
        else if (config_in_valid)
            {bandwidth, latency} <= config_in;
    end
    
    //
    // FSM
    //
    always @(posedge clock or posedge reset)
    begin
        if (reset)
            state <= 2'b00;
        else
            state <= next_state;
    end
    
    // FSM state transition
    always @(*)
    begin
        next_state = state;
        w_count_sel = 2;            // Keep old count value
        
        case (state)
            RESET:
            begin
                if (in_ready)
                begin
                    next_state = COUNT;
                    w_count_sel = 1;        // Set count to 1
                end
            end
            
            COUNT:
            begin
                if (in_ready)
                begin
                    if (count == bandwidth || in_ts_is_newer == 1'b1)
                        w_count_sel = 1;    // Set count to 1
                    else
                        w_count_sel = 3;    // Increment count
                end
                /*else if (sim_time_tick == 1'b1 && reset_when == sim_time)
                begin
                    next_state = RESET;
                    w_count_sel = 0;        // Set count to 0
                end*/
            end
        endcase
    end
    
    always @(posedge clock or posedge reset)
    begin
        if (reset)
        begin
            count       <= {(`BW_WIDTH){1'b0}};
            last_ts     <= {(`TS_WIDTH){1'b0}};
            reset_when  <= {(`TS_WIDTH){1'b0}};
        end
        else
        begin
            if (w_count_sel[1] == 1'b0)
                count <= {{(`BW_WIDTH-1){1'b0}}, w_count_sel[0]};
            else
                count <= count + {{(`BW_WIDTH-1){1'b0}}, w_count_sel[0]};
            
            last_ts <= w_ts_bw_component;
            
            if (w_count_sel == 0)   // Reset counter
                reset_when <= reset_when + 1;
            else
                reset_when <= out_timestamp;
        end
    end
    
    always @(*)
    begin
        if (w_count_sel == 2'b1)
            w_ts_bw_component = in_timestamp;
        else
            w_ts_bw_component = last_ts + 1;
    end
endmodule
