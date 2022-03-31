`timescale 1 ns/100 ps  // time unit = 1ns; precision = 1/10 ns
/* Partition of Nodes.
 * 
 * Configuration chain: 
 *      config_in -> 2 x 2 x Node -> config_out
 *
 * RAM config chain:
 *      in -> 2 x 2 x Routers -> 2 x RoutingTable -> out
 *
 * Stats chain:
 *      in -> 2 x 2 x node -> out
 */
 
`include "const.v"
module Partition (
    clock,
    reset,
    enable,
    stop_injection,
    measure,
    sim_time,
    sim_time_tick,
    error,
    is_quiescent,
    can_increment,

    // Configuration and Stats interfaces
    config_in_valid,
    config_in,
    config_out_valid,
    config_out,
    
    ram_config_in_valid,
    ram_config_in,
    ram_config_out_valid,
    ram_config_out,

    stats_shift,
    stats_in,
    stats_out,
    
    // ICSourcePart interface (x2)
    fsp_vec_valid,
    fsp_vec_valid_urgent,
    fsp_vec_data,
    fsp_vec_nexthop,
    fsp_vec_dequeue,
    
    csp_vec_valid,
    csp_vec_valid_urgent,
    csp_vec_data,
    csp_vec_nexthop,
    csp_vec_dequeue,

    // ICDestPart interface 0
    fdp_valid,
    fdp_data,
    fdp_nexthop,
    fdp_ack,
    
    cdp_valid,
    cdp_data,
    cdp_nexthop,
    cdp_ack
);
    `include "math.v"
    `include "util.v"
    
    parameter [3:0] DPID = 1;   // 4-bit DestPart ID
    parameter N = 2;            // Number of Nodes in this Partition
    parameter NPORTS = 5;
    localparam NTBL = (N+1)/2;  // Number of RoutingTables needed
    localparam LOG_NPORTS = CLogB2(NPORTS-1);

    // Global interfaces
    input                   clock;
    input                   reset;
    input                   enable;
    input                   stop_injection;
    input                   measure;
    input   [`TS_WIDTH-1:0] sim_time;
    input                   sim_time_tick;
    output                  error;
    output                  is_quiescent;
    output                  can_increment;

    // Configuration and Stats interfaces
    input                   config_in_valid;
    input           [15: 0] config_in;
    output                  config_out_valid;
    output          [15: 0] config_out;
    
    input                   ram_config_in_valid;
    input           [15: 0] ram_config_in;
    output                  ram_config_out_valid;
    output          [15: 0] ram_config_out;

    input                   stats_shift;
    input           [15: 0] stats_in;
    output          [15: 0] stats_out;
    
    // ICSourcePart interface (x2)
    output             [N-1: 0] fsp_vec_valid;
    output             [N-1: 0] fsp_vec_valid_urgent;
    output  [N*`FLIT_WIDTH-1:0] fsp_vec_data;
    output     [N*`A_WIDTH-1:0] fsp_vec_nexthop;
    input              [N-1: 0] fsp_vec_dequeue;
    
    output             [N-1: 0] csp_vec_valid;
    output             [N-1: 0] csp_vec_valid_urgent;
    output [N*`CREDIT_WIDTH-1:0] csp_vec_data;
    output     [N*`A_WIDTH-1:0] csp_vec_nexthop;
    input               [N-1:0] csp_vec_dequeue;

    // ICDestPart interface 0
    input                       fdp_valid;
    input     [`FLIT_WIDTH-1:0] fdp_data;
    input             [`A_FQID] fdp_nexthop;
    output                      fdp_ack;
    
    input                       cdp_valid;
    input   [`CREDIT_WIDTH-1:0] cdp_data;
    input             [`A_FQID] cdp_nexthop;
    output                      cdp_ack;


    wire            [N-1:0] rt_error;
    wire            [N-1:0] rt_quiescent;
    wire            [N-1:0] rt_can_increment;

    wire             [15:0] rt_config_in [N:0];
    wire              [N:0] rt_config_in_valid;
    wire             [15:0] rt_ram_config_in [N:0];
    wire              [N:0] rt_ram_config_in_valid;
    wire             [15:0] rtable_ram_config_in [NTBL:0];
    wire           [NTBL:0] rtable_ram_config_in_valid;

    wire             [15:0] rt_stats_in [N:0];

    wire            [N-1:0] rt_flit_ack;
    wire            [N-1:0] rt_credit_ack;

    wire  [`ADDR_WIDTH-1:0] rtable_dest [N-1:0];
    wire   [LOG_NPORTS-1:0] rtable_oport [N-1:0];
    
    assign error = |rt_error;
    assign is_quiescent = &rt_quiescent;
    assign can_increment = &rt_can_increment;
    
    assign config_out_valid = rt_config_in_valid[N];
    assign config_out = rt_config_in[N];
    assign ram_config_out_valid = rtable_ram_config_in_valid[NTBL];
    assign ram_config_out = rtable_ram_config_in[NTBL];

    assign stats_out = rt_stats_in[N];
    
    assign fdp_ack = |rt_flit_ack;
    assign cdp_ack = |rt_credit_ack;
    
    
    assign rt_config_in_valid[0] = config_in_valid;
    assign rt_config_in[0] = config_in;
    assign rt_ram_config_in_valid[0] = ram_config_in_valid;
    assign rt_ram_config_in[0] = ram_config_in;

    assign rt_stats_in[0] = stats_in;
    
    
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1)
        begin : node
            wire [`FLIT_WIDTH-1:0] w_flit_out;
            wire [`CREDIT_WIDTH-1:0] w_credit_out;
            wire [`TS_WIDTH-1:0] w_flit_ts;
            wire [`TS_WIDTH-1:0] w_credit_ts;

            assign w_flit_ts = flit_ts (w_flit_out);
            assign fsp_vec_data[(i+1)*`FLIT_WIDTH-1:i*`FLIT_WIDTH] = w_flit_out;
            assign fsp_vec_valid_urgent[i] = (w_flit_ts[2:0] == sim_time[2:0]) ? fsp_vec_valid[i] : 1'b0;

            assign w_credit_ts = credit_ts (w_credit_out);
            assign csp_vec_data[(i+1)*`CREDIT_WIDTH-1:i*`CREDIT_WIDTH] = w_credit_out;
            assign csp_vec_valid_urgent[i] = (w_credit_ts[2:0] == sim_time[2:0]) ? csp_vec_valid[i] : 1'b0;

            Node #(.HADDR({DPID, 4'h0}|i), .NPORTS(NPORTS)) n (
                .clock (clock),
                .reset (reset),
                .enable (enable),
                .stop_injection (stop_injection),
                .measure (measure),
                .sim_time (sim_time),
                .sim_time_tick (sim_time_tick),
                .error (rt_error[i]),
                .is_quiescent (rt_quiescent[i]),
                .can_increment (rt_can_increment[i]),
                .config_in_valid (rt_config_in_valid[i]),
                .config_in (rt_config_in[i]),
                .config_out_valid (rt_config_in_valid[i+1]),
                .config_out (rt_config_in[i+1]),
                .ram_config_in_valid (rt_ram_config_in_valid[i]),
                .ram_config_in (rt_ram_config_in[i]),
                .ram_config_out_valid (rt_ram_config_in_valid[i+1]),
                .ram_config_out (rt_ram_config_in[i+1]),
                .stats_shift (stats_shift),
                .stats_in (rt_stats_in[i]),
                .stats_out (rt_stats_in[i+1]),

                // DestPart interface
                .flit_in_valid (fdp_valid),
                .flit_in (fdp_data),
                .nexthop_in (fdp_nexthop),
                .flit_ack (rt_flit_ack[i]),

                .credit_in_valid (cdp_valid),
                .credit_in (cdp_data),
                .credit_in_nexthop (cdp_nexthop),
                .credit_ack (rt_credit_ack[i]),

                // SourcePart interface
                .flit_out_valid (fsp_vec_valid[i]),
                .flit_out (w_flit_out),
                .nexthop_out (fsp_vec_nexthop[(i+1)*`A_WIDTH-1:i*`A_WIDTH]),
                .dequeue (fsp_vec_dequeue[i]),
                
                .credit_out_valid (csp_vec_valid[i]),
                .credit_out (w_credit_out),
                .credit_out_nexthop (csp_vec_nexthop[(i+1)*`A_WIDTH-1:i*`A_WIDTH]),
                .credit_dequeue (csp_vec_dequeue[i]),

                // RoutingTable interface
                .rtable_dest (rtable_dest[i]),
                .rtable_oport (rtable_oport[i]));
        end
    endgenerate

    // Every two nodes share a RoutingTable.
    // Multi-context nodes can use multi-context routing tables (not implemented now TODO)
    assign rtable_ram_config_in[0] = rt_ram_config_in[N];
    assign rtable_ram_config_in_valid[0] = rt_ram_config_in_valid[N];

    generate
        for (i = 0; i < N; i = i + 2)
        begin : rtable
            wire [5:0] w_temp_a;
            wire [5:0] w_temp_b;

            if (i + 1 < N)
            begin
            RoutingTable_single rt (
                .clock (clock),
                .reset (reset),
                .enable (enable | rtable_ram_config_in_valid[i/2]),
                .ram_config_in (rtable_ram_config_in[i/2]),
                .ram_config_in_valid (rtable_ram_config_in_valid[i/2]),
                .ram_config_out_valid (rtable_ram_config_in_valid[i/2+1]),
                .ram_config_out (rtable_ram_config_in[i/2+1]),
                .dest_ina (rtable_dest[i]),
                .nexthop_outa ({w_temp_a, rtable_oport[i]}),
                .dest_inb (rtable_dest[i+1]),
                .nexthop_outb ({w_temp_b, rtable_oport[i+1]}));
            end
            else
            begin
            RoutingTable_single rt (
                .clock (clock),
                .reset (reset),
                .enable (enable | rtable_ram_config_in_valid[i/2]),
                .ram_config_in (rtable_ram_config_in[i/2]),
                .ram_config_in_valid (rtable_ram_config_in_valid[i/2]),
                .ram_config_out_valid (rtable_ram_config_in_valid[i/2+1]),
                .ram_config_out (rtable_ram_config_in[i/2+1]),
                .dest_ina (rtable_dest[i]),
                .nexthop_outa ({w_temp_a, rtable_oport[i]}),
                .dest_inb ({(`ADDR_WIDTH){1'b0}}),
                .nexthop_outb ());
            end
        end
    endgenerate
endmodule

