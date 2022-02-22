`timescale 1 ns/100 ps  // time unit = 1ns; precision = 1/10 ns
/* Interconnect Source Partition
 * ICSourcePart.v
 *
 * Connects Routers to FQ/TGs. Does not stall the simulator.
 */
`include "const.v"
module ICSourcePart #(
    parameter N = 2,        // Number of nodes connected to this partition
    parameter WIDTH = `FLIT_WIDTH
)
(
    // Global interface
    input   clock,
    input   reset,
	input   enable,

    // Partition control
    input   select,         // This source partition is selected for stage 2
    output  can_increment,

    // Source node interface
    input [N-1:0]               src_data_valid,
    input [N-1:0]               src_data_valid_urgent,
    input [N*WIDTH-1:0]         src_data_in,
    input [N*`ADDR_WIDTH-1:0]   src_nexthop_in,
    output [N-1:0]              src_dequeue,

    // Stage 1 output
    output [`ADDR_WIDTH-1:0]    s1_nexthop_out,
    output                      s1_valid,
    output                      s1_valid_urgent,

    // Stage 2 output
    output [WIDTH-1:0]          s2_data_out,
    output [`ADDR_WIDTH-1:0]    s2_nexthop_out
);
    `include "math.v"
    
    // Internal stages
    reg  [WIDTH-1:0]                    r_pipe_data;
    reg  [`ADDR_WIDTH-1:0]              r_pipe_nexthop;
    
    // Wires
    wire [WIDTH-1:0]                    w_s1_data;
    wire [`ADDR_WIDTH-1:0]              w_s1_nexthop;


    wire [N-1:0]    w_s1_sel;
    wire            w_s1_valid;
    wire            w_s1_valid_urgent;

    // Output
    assign can_increment = ~w_s1_valid_urgent;
    assign src_dequeue = (select & w_s1_valid) ? w_s1_sel : {(N){1'b0}};
    
    assign s1_nexthop_out = w_s1_nexthop;
    assign s1_valid = w_s1_valid;
    assign s1_valid_urgent = w_s1_valid_urgent;
    
    assign s2_data_out = r_pipe_data;
    assign s2_nexthop_out = r_pipe_nexthop;
    
    genvar i;
    generate
        // Only one node is connected to this SourcePart
        if (N == 1)
        begin
            assign w_s1_sel = 1'b1;
            assign w_s1_valid = src_data_valid;
            assign w_s1_valid_urgent = src_data_valid_urgent;
            assign w_s1_data = src_data_in;
            assign w_s1_nexthop = src_nexthop_in;
        end
        // More than one node is connected to this SourcePart
        else
        begin
            wire [N*(WIDTH+`ADDR_WIDTH)-1:0]    w_source_mux_in;
            
            // Scramble the input bits to generate the MUX in signals
            for (i = 0; i < N; i = i + 1)
            begin : in
                wire [WIDTH-1: 0] data;
                wire [`ADDR_WIDTH-1: 0] nexthop;
            
                assign data = src_data_in[(i+1)*WIDTH-1:i*WIDTH];
                assign nexthop = src_nexthop_in[(i+1)*`ADDR_WIDTH-1:i*`ADDR_WIDTH];
                assign w_source_mux_in[(i+1)*(WIDTH+`ADDR_WIDTH)-1:i*(WIDTH+`ADDR_WIDTH)] = {data, nexthop};
            end

            // Source partition arbiter
            select_ready #(.N(N)) arb_input (
                .ready (src_data_valid),
                .ready_urgent (src_data_valid_urgent),
                .sel (w_s1_sel),
                .sel_valid (w_s1_valid),
                .sel_valid_urgent (w_s1_valid_urgent));

            // Source partition MUX
            mux_Nto1_decoded #(.WIDTH(WIDTH + `ADDR_WIDTH), .SIZE(N)) source_mux (
                .in(w_source_mux_in),
                .sel (w_s1_sel),
                .out ({w_s1_data, w_s1_nexthop}));
        end
    endgenerate

    // Pipeline registers for this partition
    always @(posedge clock)
    begin
        if (reset)
        begin
            r_pipe_data     <= {(WIDTH){1'b0}};
            r_pipe_nexthop  <= {(`ADDR_WIDTH){1'b0}};
        end
        else if (enable)
        begin
            r_pipe_data     <= w_s1_data;
            r_pipe_nexthop  <= w_s1_nexthop;
        end
    end
endmodule

