`timescale 1 ns/100 ps  // time unit = 1ns; precision = 1/10 ns
/* Node = Router + (NPORTS-1) * FQs + TG
 * A single network node with the host switch.
 * 1 input interface (broadcast to all nodes) and 1 output interface (from the Router)
 *
 * Configuration chain:
 *      in -> Router -> TG -> (NPORTS-1) x FQ -> out
 *
 * RAM config chain:
 *      ram_config_in -> Router -> ram_config_out
 *
 * Stats chain:
 *      in -> TG -> out
 */
 
`include "const.v"
module Node (
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

    // Flit interface
    flit_in_valid,
    flit_in,
    nexthop_in,
    flit_ack,

    flit_out_valid,
    flit_out,
    nexthop_out,
    dequeue,

    // Credit interface
    credit_in_valid,
    credit_in,
    credit_in_nexthop,
    credit_ack,

    credit_out_valid,
    credit_out,
    credit_out_nexthop,
    credit_dequeue,

    rtable_dest,
    rtable_oport
);
    `include "math.v"
    `include "util.v"

    parameter [`ADDR_WIDTH-1:0] HADDR = 0;  // 8-bit global node ID
    parameter NPORTS = 5;                   // Number of ports on the Router
    parameter NVCS = 2;
    localparam NINPUTS = NPORTS * NVCS;
    localparam LOG_NPORTS = CLogB2(NPORTS-1);
    localparam LOG_NVCS = CLogB2(NVCS-1);
    
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
    
    // Flit interface
    input                       flit_in_valid;
    input     [`FLIT_WIDTH-1:0] flit_in;
    input             [`A_FQID] nexthop_in;
    output                      flit_ack;

    output                      flit_out_valid;
    output    [`FLIT_WIDTH-1:0] flit_out;
    output       [`A_WIDTH-1:0] nexthop_out;
    input                       dequeue;

    // Credit interface
    input                       credit_in_valid;
    input   [`CREDIT_WIDTH-1:0] credit_in;
    input             [`A_FQID] credit_in_nexthop;
    output                      credit_ack;

    output                      credit_out_valid;
    output  [`CREDIT_WIDTH-1:0] credit_out;
    output       [`A_WIDTH-1:0] credit_out_nexthop;
    input                       credit_dequeue;

    output    [`ADDR_WIDTH-1:0] rtable_dest;
    input      [LOG_NPORTS-1:0] rtable_oport;


    wire w_rt_error;
    wire w_rt_quiescent;
    wire w_rt_can_increment;

    wire [NPORTS-1:0] w_port_error;
    wire [NPORTS-1:0] w_port_quiescent;
    wire [NPORTS-1:0] w_port_flit_ack;
    wire [NPORTS-1:0] w_port_credit_ack;

    wire [15: 0] w_port_config_in[NPORTS:0];
    wire [NPORTS:0] w_port_config_in_valid;

    // FQ/TG -> Router interface
    wire [NINPUTS*`FLIT_WIDTH-1:0] w_rt_flit_in;
    wire [NINPUTS-1:0] w_rt_flit_in_valid;
    wire [NINPUTS-1:0] w_rt_flit_ack;

    wire [NPORTS*`CREDIT_WIDTH-1:0] w_rt_credit_in;
    wire [NPORTS-1:0] w_rt_credit_in_valid;
    wire [NPORTS-1:0] w_rt_credit_ack;


    // Output
    assign error = w_rt_error | (|w_port_error);
    assign is_quiescent = w_rt_quiescent & (&w_port_quiescent);
    assign can_increment = w_rt_can_increment;
    
    assign config_out_valid = w_port_config_in_valid[NPORTS];
    assign config_out = w_port_config_in[NPORTS];

    assign flit_ack = |w_port_flit_ack;
    assign credit_ack = |w_port_credit_ack;

    Router #(.HADDR(HADDR), .NPORTS(NPORTS)) rt (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .sim_time (sim_time),
        .sim_time_tick (sim_time_tick),
        .error (w_rt_error),
        .is_quiescent (w_rt_quiescent),
        .can_increment (w_rt_can_increment),
        .ram_config_in (ram_config_in),
        .ram_config_in_valid (ram_config_in_valid),
        .ram_config_out (ram_config_out),
        .ram_config_out_valid (ram_config_out_valid),
        .config_in (config_in),
        .config_in_valid (config_in_valid),
        .config_out (w_port_config_in[0]),
        .config_out_valid (w_port_config_in_valid[0]),
        .flit_in (w_rt_flit_in),
        .flit_in_valid (w_rt_flit_in_valid),
        .flit_ack (w_rt_flit_ack),
        .flit_out (flit_out),
        .flit_out_valid (flit_out_valid),
        .nexthop_out (nexthop_out),
        .dequeue (dequeue),
        .credit_in (w_rt_credit_in),
        .credit_in_valid (w_rt_credit_in_valid),
        .credit_ack (w_rt_credit_ack),
        .credit_out (credit_out),
        .credit_out_valid (credit_out_valid),
        .credit_out_nexthop (credit_out_nexthop),
        .credit_dequeue (credit_dequeue),
        .rtable_dest (rtable_dest),
        .rtable_oport (rtable_oport));
        
    // Host TG is on Port 0 (no credit interface for now)
    assign w_port_credit_ack[0] = 1'b1;         // TG always acks Router's credit
    TrafficGen #(.HADDR({HADDR, 3'b000}), .LOG_NVCS(LOG_NVCS)) tg (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .stop_injection (stop_injection),
        .sim_time (sim_time),
        .error (w_port_error[0]),
        .measure (measure),
        .is_quiescent (w_port_quiescent[0]),
        .config_in (w_port_config_in[0]),
        .config_in_valid (w_port_config_in_valid[0]),
        .config_out (w_port_config_in[1]),
        .config_out_valid (w_port_config_in_valid[1]),
        .stats_shift (stats_shift),
        .stats_in (stats_in),
        .stats_out (stats_out),

        // From DestPart
        .flit_in (flit_in),
        .flit_in_valid (flit_in_valid),
        .nexthop_in (nexthop_in),
        .flit_ack (w_port_flit_ack[0]),
        .flit_full (),

        // To Router
        .flit_out (w_rt_flit_in[NVCS*`FLIT_WIDTH-1:0]),
        .flit_out_valid (w_rt_flit_in_valid[NVCS-1:0]),
        .dequeue (w_rt_flit_ack[NVCS-1:0]),
        .credit_out (w_rt_credit_in[`CREDIT_WIDTH-1:0]),
        .credit_out_valid (w_rt_credit_in_valid[0]));

    // Port 1..N
    genvar i;
    generate
        for (i = 1; i < NPORTS; i = i + 1)
        begin : port

            FlitQueue #(.HADDR({HADDR, 3'b000}|i), .LOG_NVCS(LOG_NVCS)) fq (
                .clock (clock),
                .reset (reset),
                .enable (enable),
                .sim_time (sim_time),
                .error (w_port_error[i]),
                .is_quiescent (w_port_quiescent[i]),
                .config_in (w_port_config_in[i]),
                .config_in_valid (w_port_config_in_valid[i]),
                .config_out (w_port_config_in[i+1]),
                .config_out_valid (w_port_config_in_valid[i+1]),

                // DestPart facing interface
                .flit_full (),
                .flit_in (flit_in),
                .flit_in_valid (flit_in_valid),
                .nexthop_in (nexthop_in),
                .flit_ack (w_port_flit_ack[i]),

                .credit_full (),
                .credit_in (credit_in),
                .credit_in_valid (credit_in_valid),
                .credit_in_nexthop (credit_in_nexthop),
                .credit_ack (w_port_credit_ack[i]),
                    
                // Router Port j interface
                .flit_out (w_rt_flit_in[(i+1)*NVCS*`FLIT_WIDTH-1:i*NVCS*`FLIT_WIDTH]),
                .flit_out_valid (w_rt_flit_in_valid[(i+1)*NVCS-1:i*NVCS]),
                .dequeue (w_rt_flit_ack[(i+1)*NVCS-1:i*NVCS]),

                .credit_out (w_rt_credit_in[(i+1)*`CREDIT_WIDTH-1:i*`CREDIT_WIDTH]),
                .credit_out_valid (w_rt_credit_in_valid[i]),
                .credit_dequeue (w_rt_credit_ack[i]));
        end
    endgenerate
endmodule

