`timescale 1ns / 1ps
/* TGPacketFSM
 * FSM for trace-based flit injection
 */
`include "const.v"
module TGPacketFSM #(
    parameter [`ADDR_WIDTH-1:0] HADDR = 0,
    parameter NVCS = 2
)
(
    input                       clock,
    input                       reset,
    input                       enable,
    input   [`TS_WIDTH-1:0]     sim_time,

    input   [31:0]              packet_in,
    input                       packet_in_valid,
    output                      packet_request,

    input   [NVCS-1:0]          obuf_full,
    output  [`FLIT_WIDTH-1:0]   flit_out,
    output                      flit_out_valid
);
    `include "math.v"
    localparam logNVCS = CLogB2(NVCS-1);

    localparam IDLE = 0,
               LOAD_PACKET = 1,
               INJECT_HEAD = 2,
               INJECT_BODY = 3,
               INJECT_TAIL = 4;

    reg               [3:0] state;
    reg               [3:0] next_state;

    reg              [31:0] r_packet;
    reg [`P_SIZE_WIDTH-1:0] r_injected_flits;

    reg                     inject_head;
    reg                     inject_body;
    reg                     inject_tail;

    wire              [1:0] vc;
    wire  [`ADDR_WIDTH-1:0] w_dest;
    wire                    vc_obuf_full;
    wire              [9:0] w_src_or_inj;

    // Output
    assign packet_request = (state == IDLE) ? 1'b1 : 1'b0;      // Can receive new packet only in IDLE state
    assign flit_out[`F_FLAGS] = {inject_head, inject_tail, r_packet[`P_MEASURE]};
    assign flit_out[`F_TS] = r_packet[`P_INJ];
    assign flit_out[`F_DEST] = w_dest;
    assign flit_out[`F_SRC_INJ] = w_src_or_inj;
    assign flit_out[`F_OPORT] = 3'b000;
    assign flit_out[`F_OVC] = vc;
    assign flit_out_valid = inject_head | inject_body | inject_tail;


    assign vc = r_packet[`P_VC];
    assign w_dest = r_packet[`P_DEST];  // Dest node address (need to append 3'b000 port address before use)
    assign w_src_or_inj = (inject_head) ? {2'b00, HADDR} : r_packet[`P_INJ];


    // Buffer packet
    always @(posedge clock)
    begin
        if (reset)
            r_packet <= 0;
        else if (state == LOAD_PACKET)
            r_packet <= packet_in;
    end

    always @(posedge clock)
    begin
        if (reset)
            r_injected_flits <= 0;
        else if (state == LOAD_PACKET)
            r_injected_flits <= 1<<packet_in[`P_SIZE];
        else if (inject_head | inject_body | inject_tail)
            r_injected_flits <= r_injected_flits - 1;
    end

    mux_Nto1 #(.WIDTH(1), .SIZE(NVCS)) obuf_full_mux (
        .in (obuf_full),
        .sel (vc[logNVCS-1:0]),
        .out (vc_obuf_full));

    wire [9:0] time_diff;
    assign time_diff = r_packet[`P_INJ] - sim_time;
    
    // FSM
    always @(*)
    begin
        next_state = state;
        inject_head = 1'b0;
        inject_body = 1'b0;
        inject_tail = 1'b0;

        case (state)
            IDLE:
            begin
                if (enable & packet_in_valid)
                    next_state = LOAD_PACKET;
            end

            LOAD_PACKET:
            begin
                next_state = INJECT_HEAD;
            end

            INJECT_HEAD:
            begin
                if (time_diff <= 0 && vc_obuf_full == 1'b0)
                begin
                    inject_head = 1'b1;

                    if (r_injected_flits == 2)
                        next_state = INJECT_TAIL;   // This is the second last flit
                    else
                        next_state = INJECT_BODY;
                end
            end

            INJECT_BODY:
            begin
                if (~vc_obuf_full)
                begin
                    inject_body = 1'b1;

                    if (r_injected_flits == 2)
                        next_state = INJECT_TAIL;
                    else
                        next_state = INJECT_BODY;
                end
            end

            INJECT_TAIL:
            begin
                if (~vc_obuf_full)
                begin
                    inject_tail = 1'b1;
                    next_state = IDLE;
                end
            end
        endcase
    end

    always @(posedge clock)
    begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
endmodule

