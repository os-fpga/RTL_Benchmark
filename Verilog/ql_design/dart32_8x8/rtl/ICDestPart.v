`timescale 1 ns/100 ps  // time unit = 1ns; precision = 1/10 ns
/* Interconnect Destination Side Partition
 * ICDestPart.v
 */
`include "const.v"
module ICDestPart #(
    parameter PID = 3'b000,                 // Partition ID
    parameter NSP = 8,                      // Number of source partitions
    parameter WIDTH = `FLIT_WIDTH           // Data width
)
(
    // Global interface
    input clock,
    input reset,
    input enable,
    output error,

    // Stage 1 interface
    input             [NSP-1:0] src_s1_valid,           // Stage 1 ready signals from all partitions
    input             [NSP-1:0] src_s1_valid_urgent,    // Stage 1 urgent ready signals
    input    [NSP*`A_WIDTH-1:0] src_s1_nexthop_in,      // Stage 1 nexthops
    output            [NSP-1:0] src_s1_part_sel,        // Decoded source partition select

    // Stage 2 input
    input       [NSP*WIDTH-1:0] src_s2_data_in,         // Stage 2 data values
    input    [NSP*`A_WIDTH-1:0] src_s2_nexthop_in,      // Stage 2 nexthop values

    // Destination side interface
    input                       dequeue,                // Ack from node
    output          [WIDTH-1:0] s3_data_out,            // Stage 3 data
    output            [`A_FQID] s3_nexthop_out,         // Stage 3 nexthop (Node ID and port ID only)
    output                      s3_data_valid
);
    `include "math.v"

    //localparam PIPE_WIDTH = WIDTH + `A_FQID;            // Data + (local node ID (4) + port ID (3))
    localparam PIPE_WIDTH = WIDTH + 7; 

    // Internal stages
    reg     [CLogB2(NSP-1)-1:0] r_sel;
    reg                         r_sel_valid;            // A valid data was selected
    reg       [PIPE_WIDTH-1: 0] r_dest_bus_out;
    reg                         r_dest_bus_valid;
    reg                         r_error;
    
    // Wires
    wire              [NSP-1:0] w_s1_dest_check;
    wire              [NSP-1:0] w_s1_valid;
    wire              [NSP-1:0] w_s1_valid_urgent;
    wire              [NSP-1:0] w_s1_sel;
    wire                        w_s1_sel_valid;
    wire    [CLogB2(NSP-1)-1:0] w_s1_sel_encoded;

    wire   [NSP*PIPE_WIDTH-1:0] w_s2_mux_in;
    wire       [PIPE_WIDTH-1:0] w_s2_mux_out;
    

    // Output
    assign error = r_error;
   
    assign src_s1_part_sel = (enable) ? w_s1_sel : {(NSP){1'b0}};
    assign {s3_data_out, s3_nexthop_out} = r_dest_bus_out;
    assign s3_data_valid = r_dest_bus_valid;


    // Reorder input signals to connect to the MUX
    genvar i;
    generate
        for (i = 0; i < NSP; i = i + 1)
        begin : src_s2
            wire    [WIDTH-1:0] data;
            wire [`A_WIDTH-1:0] nexthop;    // 4-bit local node ID + 3-bit port ID
            
            assign data = src_s2_data_in[(i+1)*WIDTH-1:i*WIDTH];
            assign nexthop = src_s2_nexthop_in[(i+1)*`A_WIDTH-1:i*`A_WIDTH];
            assign w_s2_mux_in[(i+1)*PIPE_WIDTH-1:i*PIPE_WIDTH] = {data, nexthop[`A_FQID]};
        end
    endgenerate
   

    // Figure out which of the incoming datas are for this destination
    check_dest #(.N(NSP), .PID(PID)) cd (
        .src_nexthop_in (src_s1_nexthop_in),
        .valid (w_s1_dest_check));

    assign w_s1_valid = src_s1_valid & w_s1_dest_check;
    assign w_s1_valid_urgent = src_s1_valid_urgent & w_s1_dest_check;

    // Select a ready source part (pick an urgent one if applicable) among the 8
    select_ready #(.N(NSP)) arb_src (
        .ready (w_s1_valid),
        .ready_urgent (w_s1_valid_urgent),
        .sel (w_s1_sel),
        .sel_valid (w_s1_sel_valid),
        .sel_valid_urgent ());

    encoder_N #(.SIZE(NSP)) src_sel_encode (
        .decoded (w_s1_sel),
        .encoded (w_s1_sel_encoded),
        .valid ());


    // Destination MUX (this is part of stage 2)
    mux_Nto1 #(.WIDTH(PIPE_WIDTH), .SIZE(NSP)) dest_mux (
        .in (w_s2_mux_in),
        .sel (r_sel),
        .out (w_s2_mux_out));


    // Pipeline registers
    always @(posedge clock)
    begin
        if (reset)
        begin
            r_sel       <= 3'b000;
            r_sel_valid <= 1'b0;
        end
        else if (enable)
        begin
            r_sel       <= w_s1_sel_encoded;
            r_sel_valid <= w_s1_sel_valid;
        end
    end
    
    // Stage 2 FIFO registers (note this "FIFO" will never have more than 1 element)
    always @(posedge clock)
    begin
        if (reset)
        begin
            r_dest_bus_valid    <= 1'b0;
            r_dest_bus_out      <= {(72){1'b0}};
        end
        else if (enable)
        begin
            r_dest_bus_valid    <= r_sel_valid;
            r_dest_bus_out      <= w_s2_mux_out;
        end
    end
    
    // Errors
    always @(posedge clock)
    begin
        if (reset)
        begin
            r_error <= 1'b0;
        end
        else if (r_dest_bus_valid & (~dequeue) & enable)
        begin
            r_error <= 1'b1;   // Last data was valid, but not acknowledged
        end
    end

endmodule
