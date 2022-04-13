`timescale 1ns / 1ps
/* PacketPlayer.v
 * Receives packet descriptor from PacketPBControl and injects flits into the network.
 * Contains the injection and ejection queues.
 */
`include "const.v"
module PacketPlayer #(
    parameter [`A_WIDTH-1:0] HADDR = 0,
    parameter NVCS = 2
)
(
    // Global interface
    input                       clock,
    input                       reset,
    input                       enable,
    input   [`TS_WIDTH-1:0]     sim_time,
    output                      error,
    output                      is_quiescent,

    // Config interface
    input   [15:0]              config_in,
    input                       config_in_valid,
    output  [15:0]              config_out,
    output                      config_out_valid,

    // Stats interface
    input                       stats_shift,
    input   [15:0]              stats_in,
    output  [15:0]              stats_out,

    // PacketPBControl interface
    input   [31:0]              packet_in,
    input                       packet_in_valid,
    output                      packet_request,

    // DestPart interface
    input [`FLIT_WIDTH-1:0] flit_in,
    input                   flit_in_valid,
    input         [`A_FQID] nexthop_in,
    output                  flit_ack,

    // SourcePart interface
    output   [NVCS*`FLIT_WIDTH-1:0] flit_out,
    output               [NVCS-1:0] flit_out_valid,
    input                [NVCS-1:0] dequeue,

    // SourcePart credit interface
    output  [`CREDIT_WIDTH-1:0]     credit_out,
    output                          credit_out_valid
);
    `include "math.v"
    localparam logNVCS = CLogB2(NVCS-1);

    
    // Internal states
    reg                 [15: 0] stats_nreceived;
    reg                 [63: 0] stats_sum_latency;

    reg                         r_error;
    reg             [NVCS-1: 0] r_prio;


    // Wires
    wire                        w_recv_flit;

    wire                        w_iq_error;
    wire                        w_iq_is_quiescent;
    wire                        w_oq_error;
    wire                        w_oq_is_quiescent;

    wire                [15: 0] w_iq_config_out;
    wire                        w_iq_config_out_valid;
    wire                [15: 0] w_oq_config_out;
    wire                        w_oq_config_out_valid;

    wire [NVCS*`FLIT_WIDTH-1:0] w_iq_flit_out;
    wire             [NVCS-1:0] w_iq_flit_out_valid;

    wire [NVCS*`FLIT_WIDTH-1:0] w_oq_flit_out;
    wire             [NVCS-1:0] w_oq_flit_out_valid;
    wire             [NVCS-1:0] w_oq_flit_full;
    wire             [NVCS-1:0] w_oq_flit_dequeue;

    wire      [`FLIT_WIDTH-1:0] w_tg_flit_out;
    wire                        w_tg_flit_out_valid;

    wire            [NVCS-1: 0] w_iq_flit_dequeue;
    wire        [`TS_WIDTH-1:0] w_recv_flit_latency;
    wire      [`FLIT_WIDTH-1:0] w_received_flit;


    // Output
    assign error = r_error;
    assign is_quiescent = w_iq_is_quiescent & w_oq_is_quiescent;

    assign config_out = w_oq_config_out;
    assign config_out_valid = w_oq_config_out_valid;
    assign stats_out = stats_nreceived;

    assign flit_out = w_oq_flit_out;
    assign flit_out_valid = w_oq_flit_out_valid;
    
    assign credit_out = {flit_in[`F_OVC], sim_time};
    assign credit_out_valid = flit_in_valid;

    
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
    always @(posedge clock)
    begin
        if (reset)
            r_error <= 1'b0;
        else if (enable)
            r_error <= w_iq_error | w_oq_error | (w_recv_flit == 1'b1 && w_received_flit[`F_DEST] != HADDR);
    end
    

    // Stats counters
    assign w_recv_flit = |w_iq_flit_dequeue;
    assign w_recv_flit_latency = w_received_flit[`F_TS] - w_received_flit[`F_SRC_INJ];

    always @(posedge clock)
    begin
        if (reset)
        begin
            stats_nreceived     <= 0;
            stats_sum_latency   <= 0;
        end
        else if (stats_shift)
        begin
            stats_sum_latency   <= {stats_in, stats_sum_latency[63:16]};
            stats_nreceived     <= stats_sum_latency[15:0];
        end
        else if (w_recv_flit & w_received_flit[`F_TAIL] & w_received_flit[`F_MEASURE])
        begin
            // Collect stats on tail flit injected during measurement
            stats_nreceived     <= stats_nreceived + 1;
            stats_sum_latency   <= stats_sum_latency + {w_recv_flit_latency[`TS_WIDTH-1], {(64-`TS_WIDTH){1'b0}}, w_recv_flit_latency[`TS_WIDTH-2:0]};
        end
    end



    // Input queues
    //FlitQueue_NC #(.NPID(HADDR[`A_FQID]), .LOG_NVCS(logNVCS)) iq (
    FlitQueue_NC #(.HADDR(HADDR[`A_FQID]), .LOG_NVCS(logNVCS)) iq (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .sim_time (sim_time),
        .error (w_iq_error),
        .is_quiescent (w_iq_is_quiescent),
        .latency (),
        .config_in (config_in),
        .config_in_valid (config_in_valid),
        .config_out (w_iq_config_out),
        .config_out_valid (w_iq_config_out_valid),
        .flit_full (),
        .flit_in_valid (flit_in_valid),
        .flit_in (flit_in),
        .nexthop_in (nexthop_in),
        .flit_ack (flit_ack),
        .flit_out (w_iq_flit_out),
        .flit_out_valid (w_iq_flit_out_valid),
        .dequeue (w_iq_flit_dequeue));

    // Round-robin priority encoder to figure out which input VC to dequeue
    rr_prio #(.N(NVCS)) iq_sel (
        .ready (w_iq_flit_out_valid),
        .prio (r_prio),
        .select (w_iq_flit_dequeue));

    always @(posedge clock)
    begin
        if (reset)
            r_prio <= 1;
        else if (enable)
            r_prio <= {r_prio[NVCS-2:0], r_prio[NVCS-1]};
    end

    // Select received flit
    mux_Nto1_decoded #(.WIDTH(`FLIT_WIDTH), .SIZE(NVCS)) iq_flit_mux (
        .in (w_iq_flit_out),
        .sel (w_iq_flit_dequeue),
        .out (w_received_flit));

 
    // Packet injection process
    TGPacketFSM #(.HADDR(HADDR), .NVCS(NVCS)) tg (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .sim_time (sim_time),
        .packet_in (packet_in),
        .packet_in_valid (packet_in_valid),
        .packet_request (packet_request),
        .obuf_full (w_oq_flit_full),
        .flit_out (w_tg_flit_out),
        .flit_out_valid (w_tg_flit_out_valid));

    wire [NVCS*`FLIT_WIDTH-1:0] w_oq_flit_in;
    wire [NVCS-1:0] w_oq_flit_in_valid;

    assign w_oq_flit_in_valid = (w_tg_flit_out[0] == 1'b1) ? {1'b0, w_tg_flit_out_valid} : {w_tg_flit_out_valid, 1'b0};
    assign w_oq_flit_in = {w_tg_flit_out, w_tg_flit_out};

    // Output queue
    assign w_oq_flit_dequeue = dequeue;

    //FlitQueue_NC #(.NPID(HADDR[`A_FQID]), .LOG_NVCS(logNVCS)) oq (
    FlitQueue_NC #(.HADDR(HADDR[`A_FQID]), .LOG_NVCS(logNVCS)) oq (
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
   
endmodule

