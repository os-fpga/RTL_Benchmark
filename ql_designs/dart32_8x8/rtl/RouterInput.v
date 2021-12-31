`timescale 1ns / 1ps
/* RouterInput
 * RouterInput.v
 *
 * Input module of a Router (connects to all NPORTS x NVCS input FQs)
 *
 */
`include "const.v"
module RouterInput (
    clock,
    reset,
    enable,
    sim_time_tick,
    flit_in,
    flit_in_valid,
    s2_flit_routed,
    s2_flit_valid,
    s2_flit_iport_decoded,
    s1_flit,
    s1_flit_valid,
    flit_ack,
    can_increment
);
`include "math.v"
`include "util.v"

    parameter NPORTS = 5;
    parameter NVCS = 2;
    localparam NINPUTS = NPORTS * NVCS;
    localparam LOG_NPORTS = CLogB2(NPORTS-1);
    localparam LOG_NVCS = CLogB2(NVCS-1);
    localparam LOG_NINPUTS = LOG_NPORTS + LOG_NVCS;

    input                               clock;
    input                               reset;
    input                               enable;
    input                               sim_time_tick;
    input    [NINPUTS*`FLIT_WIDTH-1: 0] flit_in;
    input                [NINPUTS-1: 0] flit_in_valid;
    input                               s2_flit_routed; // Stage 2 flit is routed
    input                               s2_flit_valid;

    output               [NINPUTS-1: 0] s2_flit_iport_decoded;
    output           [`FLIT_WIDTH-1: 0] s1_flit;        // Unregistered selected flit
    output                              s1_flit_valid;
    output               [NINPUTS-1: 0] flit_ack;
    output                              can_increment;

    // Internal states
    reg                  [NINPUTS-1: 0] r_inspected;
    reg                  [NINPUTS-1: 0] r_input_sel;    // Registered input select

    // Wires
    wire                                w_ack_input;    // Only ack input of last flit was routed
    wire                                w_iport_info_reset;
    wire                 [NINPUTS-1: 0] w_valid_uninspected_ports;
    wire                 [NINPUTS-1: 0] w_input_sel;    // Decoded select for inputs
    wire             [LOG_NINPUTS-1: 0] w_input_sel_encoded;
    wire             [`FLIT_WIDTH-1: 0] w_input_flit;
    wire                                w_input_flit_valid;

    // Output
    assign s2_flit_iport_decoded = r_input_sel;
    assign s1_flit = {w_input_flit[35:5], w_input_sel_encoded[3:1], 1'b0, w_input_sel_encoded[0]};
    assign s1_flit_valid = w_input_flit_valid;
    assign flit_ack = w_ack_input ? r_input_sel : {(NINPUTS){1'b0}};
    
    assign w_valid_uninspected_ports = (~r_inspected) & flit_in_valid;
    assign w_ack_input = s2_flit_valid & s2_flit_routed;

   
    // Can increment logic: increment when no ready ports is left and there is
    // no valid flit in the pipeline
    assign can_increment = (w_valid_uninspected_ports == 0) ? ~s2_flit_valid : 1'b0;     

    
    // Select first ready port
    arbiter_static #(.SIZE(NINPUTS)) in_select (
        .requests (w_valid_uninspected_ports),
        .grants (w_input_sel),
        .grant_valid (w_input_flit_valid));
    
    encoder_N #(.SIZE(NINPUTS)) input_sel_encoder (
        .decoded (w_input_sel),
        .encoded (w_input_sel_encoded),
        .valid ());

    // Input port MUX
    mux_Nto1 #(.WIDTH(`FLIT_WIDTH), .SIZE(NINPUTS)) flit_in_mux (
        .in (flit_in),
        .sel (w_input_sel_encoded),
        .out (w_input_flit));

        
    // Input select pipeline register
    always @(posedge clock)
    begin
        if (reset)
            r_input_sel <= {(NINPUTS){1'b0}};
        else if (enable)
            r_input_sel <= w_input_sel;
    end


    // Input port info (sync reset here because glitches in sim_time_tick causes r_inspected
    // to reset in simulation)
    assign w_iport_info_reset = reset | sim_time_tick;
    always @(posedge clock)
    begin
        if (w_iport_info_reset)
            r_inspected <= {(NINPUTS){1'b0}};
        else if (enable)
            r_inspected <= r_inspected | w_input_sel;
    end
endmodule

