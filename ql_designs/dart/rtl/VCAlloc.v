`timescale 1ns / 1ps
/* VC Allocator
 * VCAlloc.v
 *
 * Simple first-available VC allocator
 */

module VCAlloc (
    clock,
    reset,
    enable,
    mask,
    oport,
    allocate,
    free,
    free_vc,
    next_vc,
    next_vc_valid
);
`include "math.v"

    parameter NPORTS = 5;
    parameter NVCS = 2;
    localparam LOG_NPORTS = CLogB2(NPORTS-1);
    localparam LOG_NVCS = CLogB2(NVCS-1);
    localparam NINPUTS = NPORTS * NVCS;

    input                   clock;
    input                   reset;
    input                   enable;
    input    [NINPUTS-1: 0] mask;
    input [LOG_NPORTS-1: 0] oport;
    input                   allocate;
    input                   free;
    input   [LOG_NVCS-1: 0] free_vc;
    output  [LOG_NVCS-1: 0] next_vc;
    output                  next_vc_valid;

    // Internal states
    reg      [NINPUTS-1: 0] r_available;    // Bit vector for available VCs (NVCS x NPORTS)

    // Wires
    wire        [NVCS-1: 0] w_available_vcs;
    wire        [NVCS-1: 0] w_vc_select;
    wire     [NINPUTS-1: 0] w_available;
    wire        [NVCS-1: 0] w_vc_free_decoded;
    
    wire      [NPORTS-1: 0] w_oport_decoded;

    
    // Select first available
    mux_Nto1 #(.WIDTH(NVCS), .SIZE(NPORTS)) vc_avail_mux (
        .in (r_available & mask),
        .sel (oport),
        .out (w_available_vcs));
        
    // Use the static arbiter to choose a free VC
    arbiter_static #(.SIZE(NVCS)) vc_select (
        .requests (w_available_vcs),
        .grants (w_vc_select),
        .grant_valid (next_vc_valid));

    encoder_N #(.SIZE(NVCS)) encode (
        .decoded (w_vc_select),
        .encoded (next_vc),
        .valid ());

    decoder_N #(.SIZE(NVCS)) decode (
        .encoded (free_vc),
        .decoded (w_vc_free_decoded));
        
    decoder_N #(.SIZE(NPORTS)) oport_decode (
        .encoded (oport),
        .decoded (w_oport_decoded));

    // Available vectors
    always @(posedge clock)
    begin
        if (reset)
            r_available <= {(NINPUTS){1'b1}};
        else if (enable)
            r_available <= w_available;
    end

    genvar i, j;
    generate
        for (i = 0; i < NPORTS; i = i + 1)
        begin : port
            for (j = 0; j < NVCS; j = j + 1)
            begin : vc
                assign w_clear = w_oport_decoded[i] & allocate & w_vc_select[j];
                assign w_set = w_oport_decoded[i] & free & w_vc_free_decoded[j];
                assign w_available[i*NVCS+j] = (r_available[i*NVCS+j] | w_set) & ~w_clear;
            end
        end
    endgenerate
endmodule

