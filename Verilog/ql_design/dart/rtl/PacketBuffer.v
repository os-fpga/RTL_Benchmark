`timescale 1ns / 1ps
/* Packet Buffer
 *
 * Buffer for packet descriptors before they are injected to the corresponding
 * PacketPlayer unit. Packets are stored in FIFO order for each PP. The buffer
 * address spaces is divided statically between the PPs.
 *
 * Parameter:
 *      PID         Partition ID for this buffer (for now set to 3 bits)
 *      N           Number of PPs that share this buffer
 *      WIDTH       Width of the packet descriptor
 *      K           Number of packet buffer space per PP (should be a power of 2)
 *
 * Interface:
 *      in_valid                I   Host-facing
 *      in_packet   [W-1:0]     I
 *      in_ack                  O
 *
 *      rd_select   [N-1:0]     I   PP/DART-facing
 *      rd_packet   [W-1:0]     O
 *      rd_ready    [N-1:0]     O
 */
`include "const.v"
module PacketBuffer (
    clock,
    reset,
    enable,

    // Host-facing interface
    in_valid,
    in_packet,
    in_ack,

    // PP/DART-facing
    rd_select,
    rd_packet,
    rd_ready
);
    `include "math.v"

    parameter [2:0] PID = 0;
    parameter N = 4;                    // # of TGs in this partition
    parameter WIDTH = 32;
    parameter K = 128;                  // # of entries per TG
    parameter logPBPARTS = 3;           // log(# of PlaybackBuffer Partitions globally)

    localparam logN = CLogB2(N-1);
    localparam logK = CLogB2(K-1);
    localparam logBUF = logN + logK;

    input               clock;
    input               reset;
    input               enable;

    input               in_valid;
    input   [WIDTH-1:0] in_packet;
    output              in_ack;

    input   [N-1:0]     rd_select;
    output  [WIDTH-1:0] rd_packet;
    output  [N-1:0]     rd_ready;

    
    // FIFO controls
    wire    [logK-1:0]      w_fifo_waddr;
    wire    [logK-1:0]      w_fifo_raddr;
    wire                    w_fifo_wen;

    wire    [N*logK-1:0]    w_fifo_waddr_all;
    wire    [N*logK-1:0]    w_fifo_raddr_all;
    wire    [N-1:0]         w_fifo_empty_all;
    wire    [N-1:0]         w_fifo_wen_all;

    wire    [logN-1:0]      w_fifo_wid;
    wire    [logN-1:0]      w_fifo_rid;
    wire    [N-1:0]         w_fifo_wid_decoded;
    wire    [N-1:0]         w_fifo_rid_decoded;

    // Big buffer for the packets
    wire                    w_ram_wen;
    wire    [logBUF-1:0]    w_ram_waddr;
    wire    [logBUF-1:0]    w_ram_raddr;
    wire    [WIDTH-1:0]     w_ram_dout;
    wire    [7:0]           w_in_packet_src;


    // Output
    assign in_ack = w_fifo_wen;
    assign rd_packet = w_ram_dout;
    assign rd_ready = ~w_fifo_empty_all;


    assign w_in_packet_src = in_packet[`P_SRC];
    assign w_ram_wen = ((w_in_packet_src[logN+logPBPARTS:logN] == PID) && (enable == 1'b1) && (in_valid == 1'b1)) ? 1'b1 : 1'b0;

    // Context-selection logic
    assign w_fifo_wid = w_in_packet_src[logN-1:0];  // Incoming packet's Node ID selects write context
    decoder_N #(.SIZE(N)) wid_decode (
        .encoded (w_fifo_wid),
        .decoded (w_fifo_wid_decoded));

    // Controller read Node ID selects read context
    encoder_N #(.SIZE(N)) rid_encode (
        .decoded (rd_select),
        .encoded (w_fifo_rid),
        .valid ());

    assign w_fifo_rid_decoded = rd_select;


    // FIFO controllers
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1)
        begin : ctrl
            RAMFIFO_ctrl_lfsr #(.LOG_DEP(logK)) candy (
                .clock (clock),
                .reset (reset),
                .enable (enable),
                .write (w_fifo_wid_decoded[i] & w_ram_wen),
                .read (w_fifo_rid_decoded),
                .full (),
                .empty (w_fifo_empty_all[i]),
                .ram_wen (w_fifo_wen_all[i]), // FIFO control indicate if really should write
                .ram_waddr (w_fifo_waddr_all[(i+1)*logK-1:i*logK]),
                .ram_raddr (w_fifo_raddr_all[(i+1)*logK-1:i*logK]),
                .ram_raddr_next ());
        end
    endgenerate

    mux_Nto1 #(.WIDTH(logK), .SIZE(N)) fifo_waddr_mux (
        .in (w_fifo_waddr_all),
        .sel (w_fifo_wid),
        .out (w_fifo_waddr));

    mux_Nto1 #(.WIDTH(logK), .SIZE(N)) fifo_raddr_mux (
        .in (w_fifo_raddr_all),
        .sel (w_fifo_rid),
        .out (w_fifo_raddr));

    assign w_fifo_wen = |w_fifo_wen_all;    // By design only 1 of the FIFO will allow write at a time

    // Big buffer
    assign w_ram_waddr = {w_fifo_wid, w_fifo_waddr};
    assign w_ram_raddr = {w_fifo_rid, w_fifo_raddr};

    DualBRAM #(.WIDTH(WIDTH), .LOG_DEP(logBUF)) buffer (
        .clock (clock),
        .wen (w_fifo_wen),
        .waddr (w_ram_waddr),
        .raddr (w_ram_raddr),
        .din (in_packet),
        .dout (w_ram_dout),
        .wdout ());
endmodule

