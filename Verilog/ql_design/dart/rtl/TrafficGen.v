`timescale 1 ns/100 ps	// time unit = 1ns; precision = 1/10 ns
/* TrafficGen.v
 *
 * Configuration path
 *      config_in -> RNG -> threshold (32) -> {sendto(8), psize(8)} ->
 *      IQ -> OQ -> config_out
 */
 // TODO:
 // 1. Multicontext
`include "const.v"
module TrafficGen (
    clock,
    reset,
    enable,
    stop_injection,
    sim_time,
    error,
    is_quiescent,
    config_in,
    config_in_valid,
    config_out,
    config_out_valid,
    stats_shift,
    stats_in,
    stats_out,
    flit_in,
    flit_in_valid,
    nexthop_in,
    flit_ack,
    flit_full,
    flit_out,
    flit_out_valid,
    dequeue,
    credit_out,
    credit_out_valid,
    measure
);
    `include "util.v"
    
    parameter [`A_WIDTH-1:0] HADDR = 0; // 8-bit global node ID + 3-bit port ID
    parameter LOG_NVCS = 1;
    localparam NVCS = 1 << LOG_NVCS;
    localparam PSIZE_WIDTH = 8;

    input measure;

    // Global ports
    input                       clock;
    input                       reset;
    input                       enable;
    input                       stop_injection;
    input       [`TS_WIDTH-1:0] sim_time;
    output                      error;
    output                      is_quiescent;
 
    // Configuration ports
    input               [15: 0] config_in;
    input                       config_in_valid;
    output              [15: 0] config_out;
    output                      config_out_valid;
    
    // Stats ports
    input                       stats_shift;
    input               [15: 0] stats_in;
    output              [15: 0] stats_out;
       
    // Data ports
    input     [`FLIT_WIDTH-1:0] flit_in;
    input                       flit_in_valid;
    input             [`A_FQID] nexthop_in;
    output                      flit_ack;
    output           [NVCS-1:0] flit_full;

    input                [NVCS-1:0] dequeue;
    output   [NVCS*`FLIT_WIDTH-1:0] flit_out;
    output               [NVCS-1:0] flit_out_valid;
    
    output  [`CREDIT_WIDTH-1:0] credit_out;
    output                      credit_out_valid;

    
    // Internal states
    reg                 [31: 0] threshold;  // Bernoulli threshold
    reg      [PSIZE_WIDTH-1: 0] psize;
    reg       [`ADDR_WIDTH-1:0] sendto;
    reg                 [15: 0] stats_nreceived;
    reg                 [15: 0] stats_ninjected;
    reg                 [63: 0] stats_sum_latency;
    reg         [LOG_NVCS-1: 0] r_prio;
    
    reg                         r_error;
   
    // Wires
    wire                        w_recv_flit;
    wire                        w_tick_rng;

    wire                [15: 0] w_rng_config_out;
    wire                        w_rng_config_out_valid;
    wire                [31: 0] w_rand_wire;
    wire                        w_rand_below_threshold;
    
    wire                        w_iq_error;
    wire                        w_iq_is_quiescent;
    wire                        w_oq_error;
    wire                        w_oq_is_quiescent;

    wire                [15: 0] w_tg_config_out;
    wire                        w_tg_config_out_valid;
    wire                [15: 0] w_iq_config_out;
    wire                        w_iq_config_out_valid;
    wire                [15: 0] w_oq_config_out;
    wire                        w_oq_config_out_valid;

    wire [NVCS*`FLIT_WIDTH-1:0] w_iq_flit_out;
    wire            [NVCS-1: 0] w_iq_flit_out_valid;
	// TODO: we only use 1 VC in the source queue
    wire [`FLIT_WIDTH-1:0] w_oq_flit_out;
    wire w_oq_flit_out_valid;
    wire w_oq_flit_full;
    wire w_oq_flit_dequeue;
    wire      [`FLIT_WIDTH-1:0] w_tg_flit_out;
    wire                        w_tg_flit_out_valid;

    wire        [`TS_WIDTH-1:0] w_iq_flit_latency;
    wire            [NVCS-1: 0] w_iq_flit_dequeue;
    wire      [`FLIT_WIDTH-1:0] w_received_flit;
    
    wire                        w_error_mismatch;


    // Output
    assign error = r_error;
    assign is_quiescent = w_iq_is_quiescent & w_oq_is_quiescent;

    assign config_out = w_oq_config_out;
    assign config_out_valid = w_oq_config_out_valid;
    assign stats_out = stats_ninjected;

    assign flit_out = w_oq_flit_out;
    assign flit_out_valid = w_oq_flit_out_valid;
    
    assign credit_out = {flit_vc(flit_in), sim_time};
    assign credit_out_valid = (nexthop_in == HADDR[`A_FQID] && flit_in_valid == 1'b1) ? 1'b1 : 1'b0;
    

    assign w_recv_flit = |w_iq_flit_dequeue;
    assign w_tg_config_out = {sendto, psize};
    assign w_tg_config_out_valid = w_rng_config_out_valid;
    
    
    // Simulation stuff
`ifdef SIMULATION
    always @(posedge clock)
    begin
        if (dequeue)
            $display ("T %x  TG (%x) sends flit %x", sim_time, HADDR, flit_out);
        if (w_recv_flit)
            $display ("T %x  TG (%x) recvs flit %x", sim_time, HADDR, w_received_flit);
        if (enable & error)
            $display ("ATTENTION: TG (%x) has an error", HADDR);
    end
`endif
    
    // Error
	assign w_error_mismatch = (w_received_flit[`F_DEST] == HADDR) ? 1'b0 : 1'b1;
    always @(posedge clock)
    begin
        if (reset)
            r_error <= 1'b0;
        else if (enable & ~r_error)
            r_error <= w_iq_error | w_oq_error | (w_recv_flit & w_error_mismatch);
    end
    
    // Configuration chain
    always @(posedge clock)
    begin
        if (reset)
        begin
            threshold   <= {(32){1'b0}};
            psize       <= {(PSIZE_WIDTH){1'b0}};
            sendto      <= {(`ADDR_WIDTH){1'b0}};
        end
        else if (w_rng_config_out_valid)
        begin
            threshold <= {w_rng_config_out, threshold[31:16]};
            {sendto, psize} <= threshold[15:0];
        end
    end

    // Stats counters
    assign w_iq_flit_latency = w_received_flit[`F_TS] - w_received_flit[`F_SRC_INJ];

    always @(posedge clock)
    begin
        if (reset)
        begin
            stats_ninjected     <= 0;
            stats_nreceived     <= 0;
            stats_sum_latency   <= 0;
        end
        else if (stats_shift)
        begin
            stats_sum_latency   <= {stats_in, stats_sum_latency[63:16]};
            stats_nreceived     <= stats_sum_latency[15:0];
            stats_ninjected     <= stats_nreceived;
        end
        else if (enable)
        begin
            if (w_recv_flit & w_received_flit[`F_TAIL] & w_received_flit[`F_MEASURE])
            begin
                // Collect stats on tail flit injected during measurement
                stats_nreceived     <= stats_nreceived + 1;
				stats_sum_latency <= stats_sum_latency + {{(64-`TS_WIDTH){1'b0}}, w_iq_flit_latency};
            end
            
            if (w_tg_flit_out_valid & w_tg_flit_out[`F_HEAD] & w_tg_flit_out[`F_MEASURE])
                stats_ninjected     <= stats_ninjected + 1;
        end
    end


    // Random number generator
    RNG rng (
        .clock (clock),
        .reset (reset),
        .enable (enable & w_tick_rng),
        .rand_out (w_rand_wire),
        .config_in_valid (config_in_valid),
        .config_in (config_in),
        .config_out_valid (w_rng_config_out_valid),
        .config_out (w_rng_config_out));

    // Bernoulli injection process
    assign w_rand_below_threshold = (w_rand_wire < threshold) ? 1'b1 : 1'b0;
    
    TGBernoulliFSM #(.HADDR(HADDR[`A_DNID]), .PSIZE_WIDTH(PSIZE_WIDTH)) tg (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .sim_time (sim_time),
        .measure (measure),
        .stop_injection (stop_injection),
        .psize (psize),
        .sendto (sendto),
        .obuf_full (w_oq_flit_full),                 // Only support 1 output VC now
        .rand_below_threshold (w_rand_below_threshold),
        .flit_out (w_tg_flit_out),
        .ready (w_tg_flit_out_valid),
        .tick_rng (w_tick_rng));


    // Input and output queues
    //FlitQueue_NC #(.NPID(HADDR[`A_FQID]), .LOG_NVCS(LOG_NVCS)) iq (
    FlitQueue_NC #(.HADDR(HADDR[`A_FQID]), .LOG_NVCS(LOG_NVCS)) iq (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .sim_time (sim_time),
        .error (w_iq_error),
        .is_quiescent (w_iq_is_quiescent),
        .latency (),
        .config_in (w_tg_config_out),
        .config_in_valid (w_tg_config_out_valid),
        .config_out (w_iq_config_out),
        .config_out_valid (w_iq_config_out_valid),
        .flit_full (flit_full),
        .flit_in_valid (flit_in_valid),
        .flit_in (flit_in),
        .nexthop_in (nexthop_in),
        .flit_ack (flit_ack),
        .flit_out (w_iq_flit_out),
        .flit_out_valid (w_iq_flit_out_valid),
        .dequeue (w_iq_flit_dequeue));

    // Output queue has only 1 VC
    //FlitQueue_NC #(.NPID(HADDR[`A_FQID]), .LOG_NVCS(0)) oq (
    FlitQueue_NC #(.HADDR(HADDR[`A_FQID]), .LOG_NVCS(0)) oq (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .sim_time (sim_time),
        .error (w_oq_error),
        .is_quiescent (w_oq_is_quiescent),
        .latency (),
        .config_in (w_iq_config_out),
        .config_in_valid (w_iq_config_out_valid),
        .config_out (w_oq_config_out),
        .config_out_valid (w_oq_config_out_valid),
        .flit_full (w_oq_flit_full),
        .flit_in_valid (w_tg_flit_out_valid),
        .flit_in (w_tg_flit_out),
        .nexthop_in (HADDR[`A_FQID]),
        .flit_ack (),
        .flit_out (w_oq_flit_out),
        .flit_out_valid (w_oq_flit_out_valid),
        .dequeue (w_oq_flit_dequeue));
    
    // Make sure dequeue only happens at the second half cycle of clock
    assign w_oq_flit_dequeue = dequeue;
    
    // Rotating priority encoder to figure out which input VC to dequeue
    generate
        if (NVCS == 1)
        begin
            always @(posedge clock)
            begin
                if (reset)
                    r_prio <= 1'b0;
                else if (enable)
                    r_prio <= ~r_prio;
            end
        end
        else
        begin
            always @(posedge clock)
            begin
                if (reset)
                    r_prio  <= {(LOG_NVCS){1'b0}};
                else if (enable)
                    r_prio <= r_prio + 1;
            end
        end
    endgenerate

    rotate_prio #(.SIZE(NVCS)) iq_prio_sel (
        .prio (r_prio),
        .in_valid (w_iq_flit_out_valid),
        .out_sel (w_iq_flit_dequeue));

    mux_Nto1_decoded #(.WIDTH(`FLIT_WIDTH), .SIZE(NVCS)) iq_flit_mux (
        .in (w_iq_flit_out),
        .sel (w_iq_flit_dequeue),
        .out (w_received_flit));
endmodule

