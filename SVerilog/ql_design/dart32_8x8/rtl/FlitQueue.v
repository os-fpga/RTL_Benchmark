`timescale 1ns / 1ps
/* Flit Queue
 * FlitQueue.v
 *
 * Models a single input unit of a Router
 *
 * Configuration path
 *      config_in -> FlitQueue_NC -> config_out
 */
`include "const.v"

module FlitQueue(
    clock,
    reset,
    enable,
    sim_time,
    error,
    is_quiescent,
    config_in,
    config_in_valid,
    config_out,
    config_out_valid,
    flit_full,
    flit_in_valid,
    flit_in,
    nexthop_in,
    flit_ack,
    flit_out,
    flit_out_valid,
    dequeue,
    credit_full,
    credit_in_valid,
    credit_in,
    credit_in_nexthop,
    credit_ack,
    credit_out,
    credit_out_valid,
    credit_dequeue
);
`include "util.v"

	parameter [`A_WIDTH-1:0] HADDR = 1; // 8-bit global node ID + 3-bit port ID
    parameter LOG_NVCS = 1;
    localparam NVCS = 1 << LOG_NVCS;
    
    input                           clock;
    input                           reset;
    input                           enable;
    input           [`TS_WIDTH-1:0] sim_time;
    output                          error;
    output                          is_quiescent;

    // Config interface
    input                   [15: 0] config_in;
    input                           config_in_valid;
    output                  [15: 0] config_out;
    output                          config_out_valid;
    
    // Flit interface (1 in, NVCS out)
    output              [NVCS-1: 0] flit_full;
    input                           flit_in_valid;
    input         [`FLIT_WIDTH-1:0] flit_in;
    input                 [`A_FQID] nexthop_in;
    output                          flit_ack;

    output   [NVCS*`FLIT_WIDTH-1:0] flit_out;           // One out interface per VC
    output              [NVCS-1: 0] flit_out_valid;
    input               [NVCS-1: 0] dequeue;
    
    // Credit interface (1 in, 1 out)
    output                          credit_full;
    input                           credit_in_valid;
    input      [`CREDIT_WIDTH-1: 0] credit_in;
    input                 [`A_FQID] credit_in_nexthop;
    output                          credit_ack;
    
    output     [`CREDIT_WIDTH-1: 0] credit_out;        // Two output interfaces for the two VCs
    output                          credit_out_valid;
    input                           credit_dequeue;


    // Wires
    wire                        w_flit_error;
    wire       [`LAT_WIDTH-1:0] w_latency;
    wire            [NVCS-1: 0] w_flit_full;
    wire                        w_flit_is_quiescent;
    wire            [NVCS-1: 0] w_flit_dequeue;

    wire        [`TS_WIDTH-1:0] w_credit_in_ts;
    wire        [`TS_WIDTH-1:0] w_credit_new_ts;
    wire        [`TS_WIDTH-1:0] w_credit_out_ts;
    wire    [`CREDIT_WIDTH-1:0] w_credit_to_enqueue;
    wire    [`CREDIT_WIDTH-1:0] w_credit_out;
    wire                        w_credit_enqueue;
    wire                        w_credit_full;
    wire                        w_credit_empty;
    wire                        w_credit_error;
    wire                        w_credit_has_data;

    // Output
    assign error = w_credit_error | w_flit_error;
    assign is_quiescent = w_flit_is_quiescent & w_credit_empty;
    assign flit_full = w_flit_full;

    assign credit_full = w_credit_full;
    assign credit_out = w_credit_out;
    assign credit_ack = w_credit_enqueue;

    // For now only supports 2 VCs (1 LSB in nexthop)
    // psl ERROR_unsupported_NVCS: assert always {NVCS == 2};
    
    // Simulation stuff
`ifdef SIMULATION
    always @(posedge clock)
    begin
        if (credit_dequeue)
            $display ("T %x  FQ (%x) sends credit %x port 0", sim_time, HADDR, credit_out);
    end
`endif

    // Flit Queue
    FlitQueue_NC #(.HADDR(HADDR), .LOG_NVCS(LOG_NVCS)) fq (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .sim_time (sim_time),
        .error (w_flit_error),
        .is_quiescent (w_flit_is_quiescent),
        .latency (w_latency),
        .config_in (config_in),
        .config_in_valid (config_in_valid),
        .config_out (config_out),
        .config_out_valid (config_out_valid),
        .flit_full (w_flit_full),
        .flit_in_valid (flit_in_valid),
        .flit_in (flit_in),
        .nexthop_in (nexthop_in),
        .flit_ack (flit_ack),
        .flit_out (flit_out),
        .flit_out_valid (flit_out_valid),
        .dequeue (w_flit_dequeue));


    // Credit FIFO (32 deep)
    assign w_credit_in_ts = credit_ts (credit_in);
    assign w_credit_to_enqueue = update_credit_ts (credit_in, w_credit_new_ts);
    assign w_credit_enqueue = (credit_in_nexthop == HADDR[`A_FQID]) ? (enable & credit_in_valid & ~w_credit_full) : 1'b0;
    assign w_credit_error = (credit_in_valid & w_credit_full) | (credit_dequeue & w_credit_empty);
    assign w_credit_new_ts = w_credit_in_ts + w_latency;

    //srl_fifo #(.WIDTH(`CREDIT_WIDTH), .LOG_LEN(5)) cq (
    RAMFIFO_single_slow #(.WIDTH(`CREDIT_WIDTH), .LOG_DEP(5)) cq (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .data_in (w_credit_to_enqueue),
        .data_out (w_credit_out),
        .write (w_credit_enqueue),
        .read (credit_dequeue),
        .full (w_credit_full),
        .empty (w_credit_empty),
        .has_data (w_credit_has_data));

    // Credit out interface
    assign w_credit_out_ts = credit_ts (w_credit_out);
    flit_out_inf cout_inf (
        .clock (clock),
        .reset (reset),
        .dequeue (credit_dequeue),
        .flit_valid (w_credit_has_data),
        .flit_timestamp (w_credit_out_ts),
        .sim_time (sim_time),
        .ready (credit_out_valid));
    
    // Generate dequeue signals
    assign w_flit_dequeue = dequeue;

endmodule

