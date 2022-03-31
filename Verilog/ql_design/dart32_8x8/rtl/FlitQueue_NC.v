`timescale 1ns / 1ps
/* Flit Queue
 * FlitQueue.v
 *
 * Models a single 2-VC FlitQueue without credit channels
 *
 * Configuration path
 *      config_in -> FQCtrl -> config_out
 */
`include "const.v"
module FlitQueue_NC (
    clock,
    reset,
    enable,
    sim_time,
    error,
    is_quiescent,
    latency,                // For FQ to have access to the latency
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
    dequeue
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
    output         [`LAT_WIDTH-1:0] latency;

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


    // Wires
    wire       [`LAT_WIDTH-1:0] w_latency;

    wire                        w_flit_in_valid;
    wire        [`TS_WIDTH-1:0] w_flit_in_ts;
    wire        [`TS_WIDTH-1:0] w_flit_new_ts;
    wire                        w_flit_in_vc;
    wire      [`FLIT_WIDTH-1:0] w_flit_to_enqueue;
    wire [NVCS*`FLIT_WIDTH-1:0] w_flit_out;
    wire                        w_flit_enqueue;
    wire                        w_flit_dequeue;
    wire            [NVCS-1: 0] w_flit_full;
    wire            [NVCS-1: 0] w_flit_empty;
    wire                        w_flit_error;
    wire            [NVCS-1: 0] w_flit_has_data;

    wire                        w_ram_read;
    wire                        w_ram_write;

    genvar i;

    // Output
    assign error = w_flit_error;
    assign is_quiescent = &w_flit_empty;
    assign latency = w_latency;

    assign flit_full = w_flit_full;
    assign flit_ack = w_ram_write;
    assign flit_out = w_flit_out;

    assign w_ram_read = enable & w_flit_dequeue;
    assign w_ram_write = enable & w_flit_enqueue;

    // Simulation stuff
`ifdef SIMULATION
    always @(posedge clock)
    begin
        if (w_ram_write)
            $display ("T %x  FQ (%x) recvs flit %x", sim_time, HADDR, flit_in);
    end
    generate
        for (i = 0; i < NVCS; i = i + 1)
        begin : sim_display
            always @(posedge clock)
            begin
                if (dequeue[i])
                    $display ("T %x  FQ (%x) sends flit %x (VC %d)", sim_time, HADDR, flit_out[(i+1)*`FLIT_WIDTH-1:i*`FLIT_WIDTH], flit_out[i*`FLIT_WIDTH]);
            end
        end
    endgenerate
`endif

  
    // FQ control unit (1 per context)
    assign w_flit_in_valid = (nexthop_in == HADDR[`A_FQID]) ? (enable & flit_in_valid) : 1'b0;
    assign w_flit_in_ts = flit_in[`F_TS];
    
    FQCtrl ctrl (
        .clock (clock),
        .reset (reset),
        .in_ready (w_flit_in_valid),
        .in_timestamp (w_flit_in_ts),
        .out_timestamp (w_flit_new_ts),
        .config_in (config_in),
        .config_in_valid (config_in_valid),
        .config_out (config_out),
        .config_out_valid (config_out_valid),
        .bandwidth (),
        .latency (w_latency));

    // Flit FIFO (64 deep)
    assign w_flit_in_vc = flit_vc (flit_in);
    assign w_flit_to_enqueue = update_flit_ts (flit_in, w_flit_new_ts);

    generate
        if (LOG_NVCS == 0)
        begin
            assign w_flit_enqueue = w_flit_in_valid & ~w_flit_full;
            assign w_flit_dequeue = dequeue;
            assign w_flit_error = 1'b0;
            
            RAMFIFO_single_slow #(.WIDTH(`FLIT_WIDTH), .LOG_DEP(6)) fq (
                .clock (clock),
                .reset (reset),
                .enable (enable),
                .data_in (w_flit_to_enqueue),
                .data_out (w_flit_out),
                .write (w_ram_write),
                .read (w_ram_read),
                .full (w_flit_full),
                .empty (w_flit_empty),
                .has_data (w_flit_has_data));
        end
        else
        begin
            wire        [LOG_NVCS-1: 0] w_flit_dequeue_ccid;
            wire                        w_flit_fifo_full;
            
            assign w_flit_enqueue = w_flit_in_valid & ~w_flit_fifo_full;
            
            mux_Nto1 #(.WIDTH(1), .SIZE(NVCS)) enqueue_mux (
                .in (w_flit_full),
                .sel (w_flit_in_vc),
                .out (w_flit_fifo_full));
            
            //RAMFIFO #(.WIDTH(`FLIT_WIDTH), .LOG_DEP(6), .LOG_CTX(LOG_NVCS)) fq (
            RAMFIFO_slow #(.WIDTH(`FLIT_WIDTH), .LOG_DEP(6), .LOG_CTX(LOG_NVCS)) fq (
                .clock (clock),
                .reset (reset),
                .enable (enable),
                .rcc_id (w_flit_dequeue_ccid),
                .wcc_id (w_flit_in_vc),
                .data_in (w_flit_to_enqueue),
                .data_out (w_flit_out),
                .write (w_ram_write),
                .read (w_ram_read),
                .full (w_flit_full),
                .empty (w_flit_empty),
                .has_data (w_flit_has_data),
                .error (w_flit_error));

            encoder_N #(.SIZE(NVCS)) dequeue_encoder (
                .decoded (dequeue),
                .encoded (w_flit_dequeue_ccid),
                .valid (w_flit_dequeue));
        end
    endgenerate

    // Flit out interface
    generate
        for (i = 0; i < NVCS; i = i + 1)
        begin : fout
            wire [`TS_WIDTH-1:0] w_flit_out_ts;
            assign w_flit_out_ts = flit_ts (w_flit_out[(i+1)*`FLIT_WIDTH-1:i*`FLIT_WIDTH]);
            
            flit_out_inf inf (
                .clock (clock),
                .reset (reset),
                .dequeue (dequeue[i]),
                .flit_valid (w_flit_has_data[i]),
                .flit_timestamp (w_flit_out_ts),
                .sim_time (sim_time),
                .ready (flit_out_valid[i]));
        end
    endgenerate
endmodule

