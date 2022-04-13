`timescale 1ns/100 ps   // time unit = 1ns; precision = 1/10 ns
/* Router
 * Router.v
 *
 * Single N-port Router. NPORTS x NVCS input ports, 1 output port
 *
 * Configuration path:
 *      config_in -> CreditCounter_0 -> ... -> CreditCounter_N (N = nports * nvc) -> config_out
 *      ram_config_in -> Input RouterPortLookup -> Output RouterPortLookup -> ram_config_out
 */
`include "const.v"
module Router (
    clock,
    reset,
    enable,
    sim_time,
    sim_time_tick,
    error,
    is_quiescent,
    can_increment,
    ram_config_in,
    ram_config_in_valid,
    ram_config_out,
    ram_config_out_valid,
    config_in,
    config_in_valid,
    config_out,
    config_out_valid,
    flit_in,
    flit_in_valid,
    flit_ack,
    flit_out,
    flit_out_valid,
    nexthop_out,
    dequeue,
    credit_in,
    credit_in_valid,
    credit_ack,
    credit_out,
    credit_out_valid,
    credit_out_nexthop,
    credit_dequeue,
    rtable_dest,
    rtable_oport
);
`include "math.v"
`include "util.v"

    parameter [`ADDR_WIDTH-1:0] HADDR = 0;  // 8-bit global node ID
    parameter NPORTS = 5;
    parameter NVCS = 2;

    localparam LOG_NPORTS = CLogB2(NPORTS-1);
    localparam LOG_NVCS = CLogB2(NVCS-1);
    localparam NINPUTS = NPORTS * NVCS;
    localparam CC_WIDTH = 4;  // Max credits = 16

    // Global interface
    input                   clock;
    input                   reset;
    input                   enable;
    input  [`TS_WIDTH-1: 0] sim_time;
    input                   sim_time_tick;
    output                  error;
    output                  is_quiescent;
    output                  can_increment;

    // RAM config interface
    input           [15: 0] ram_config_in;
    input                   ram_config_in_valid;
    output          [15: 0] ram_config_out;
    output                  ram_config_out_valid;

    // Data config interface
    input           [15: 0] config_in;
    input                   config_in_valid;
    output          [15: 0] config_out;
    output                  config_out_valid;

    // Data interface
    input    [`FLIT_WIDTH*NINPUTS-1: 0] flit_in;
    input                [NINPUTS-1: 0] flit_in_valid;
    output               [NINPUTS-1: 0] flit_ack;

    output           [`FLIT_WIDTH-1: 0] flit_out;
    output                              flit_out_valid;
    output              [`A_WIDTH-1: 0] nexthop_out;
    input                               dequeue;

    // Credit interface
    input   [`CREDIT_WIDTH*NPORTS-1: 0] credit_in;
    input                 [NPORTS-1: 0] credit_in_valid;
    output                [NPORTS-1: 0] credit_ack;

    output [`CREDIT_WIDTH-1: 0] credit_out;
    output                      credit_out_valid;
    output      [`A_WIDTH-1: 0] credit_out_nexthop;
    input                       credit_dequeue;

    // Routing table interface
    output   [`ADDR_WIDTH-1: 0] rtable_dest;
    input     [LOG_NPORTS-1: 0] rtable_oport;


    // Internal states
    reg                 [ 7: 0] r_ovc_config_pad;
    reg      [`FLIT_WIDTH-1: 0] r_s2_flit;
    reg                         r_s2_flit_valid;
    reg                         r_error;

    // Wires
    wire                        w_enable_input_select;
    wire          [NINPUTS-1:0] w_s2_flit_iport_sel;
    wire      [`FLIT_WIDTH-1:0] w_s1_flit;              // Input to pipeline registers
    wire                        w_s1_flit_valid;
    wire      [`FLIT_WIDTH-1:0] w_s2_updated_flit;      // Input to obuf
    wire      [`FLIT_WIDTH-1:0] w_s3_flit;              // Output of obuf
    
    wire    [`CREDIT_WIDTH-1:0] w_s2_credit;
    wire    [`CREDIT_WIDTH-1:0] w_s3_credit;
    wire       [LOG_NPORTS-1:0] w_s3_credit_oport;
    
    wire         [LOG_NVCS-1:0] w_last_ovc_for_this_ivc;// Output VC allocated for this input VC
    wire         [LOG_NVCS-1:0] w_vc_alloc_out;         // Allocated VC
    wire                        w_vc_alloc_out_valid;   // Indicate if VC Alloc was successful
    
    wire                        w_obuf_full;
    wire                        w_obuf_empty;
    
    wire                        w_credit_obuf_full;
    wire                        w_credit_obuf_empty;
    
    wire                        w_s2_routed;
    wire                        w_s2_vc_allocate_enable;// Head flit, enable VC allocation
    wire                        w_s2_vc_free_enable;    // Tail flit, free allocated VC
    wire                        w_s2_route_enable;
    wire                        w_s2_vc_valid;          // Either a VC is inherited or VCAlloc was successful
    
    wire         [NINPUTS-1: 0] w_credit_in_valid;
    wire         [NINPUTS-1: 0] w_credit_ack;

    wire       [NINPUTS*4-1: 0] w_ovc_config_in;
    wire         [NINPUTS-1: 0] w_ovc_config_in_valid;
    wire       [NINPUTS*4-1: 0] w_ovc_config_out;
    wire         [NINPUTS-1: 0] w_ovc_config_out_valid;
    wire         [NINPUTS-1: 0] w_ovc_use_credit;
    wire       [NINPUTS*4-1: 0] w_ovc_credit;
    wire        [CC_WIDTH-1: 0] w_oport_credit;
    
    
    wire error1;
    wire error2;


    always @(posedge clock)
    begin
        if (w_s2_routed)
            $display ("T %d flit %x oport %d.%d credit %d", sim_time, w_s2_updated_flit, rtable_oport, w_s2_updated_flit[0], w_oport_credit);
    end

    //
    // Output
    //
    assign error = r_error;
    assign is_quiescent = w_obuf_empty & w_credit_obuf_empty;
    assign config_out = {r_ovc_config_pad, w_ovc_config_out[39:32]};
    assign config_out_valid = w_ovc_config_out_valid[9];
    
    assign flit_out = w_s3_flit;
    assign credit_out = w_s3_credit;
    
    //
    // Input select
    //
    assign w_enable_input_select = enable & ~w_obuf_full;
    
    RouterInput #(.NPORTS(NPORTS), .NVCS(NVCS)) input_unit (
        .clock (clock),
        .reset (reset),
        .enable (w_enable_input_select),
        .sim_time_tick (sim_time_tick),
        .flit_in (flit_in),
        .flit_in_valid (flit_in_valid),
        .s2_flit_routed (w_s2_routed),
        .s2_flit_valid (r_s2_flit_valid),
        .s2_flit_iport_decoded (w_s2_flit_iport_sel),
        .s1_flit (w_s1_flit),
        .s1_flit_valid (w_s1_flit_valid),
        .flit_ack (flit_ack),
        .can_increment (can_increment));
    
    //
    // Connections going to RoutingTable
    //
	assign rtable_dest = w_s1_flit[`F_DEST];
    
    //
    // Pipeline registers
    //
    always @(posedge clock)
    begin
        if (reset)
        begin
            r_s2_flit <= 0;
            r_s2_flit_valid <= 1'b0;
        end
        else if (enable)
        begin
            r_s2_flit <= w_s1_flit;
            r_s2_flit_valid <= w_s1_flit_valid;
        end
    end
    
    //
    // Generate new flit
    //
    rt_update_flit #(.VC_WIDTH(LOG_NVCS), .PORT_WIDTH(LOG_NPORTS)) update_flit (
        .sim_time (sim_time),
        .old_flit (r_s2_flit),
        .old_flit_valid (r_s2_flit_valid),
        .saved_vc (w_last_ovc_for_this_ivc),
        .allocated_vc (w_vc_alloc_out),
        .routed_oport (rtable_oport),
        .updated_flit (w_s2_updated_flit));
    
    //
    // Output flit buffer
    //
    RAMFIFO_single_slow #(.WIDTH(`FLIT_WIDTH), .LOG_DEP(4)) obuf (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .data_in (w_s2_updated_flit),
        .data_out (w_s3_flit),
        .write (w_s2_routed),
        .read (dequeue),
        .full (w_obuf_full),
        .empty (w_obuf_empty),
        .has_data (flit_out_valid));

    //
    // Generate credit (same timestamp as routed flit)
    //
    assign w_s2_credit = {r_s2_flit[0], w_s2_updated_flit[`F_TS]};
    
    //
    // Output credit buffer
    //
    RAMFIFO_single_slow #(.WIDTH(`CREDIT_WIDTH+LOG_NPORTS), .LOG_DEP(4)) credit_obuf (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .data_in ({r_s2_flit[`F_OPORT], w_s2_credit}),
        .data_out ({w_s3_credit_oport, w_s3_credit}),
        .write (w_s2_routed),
        .read (credit_dequeue),
        .full (w_credit_obuf_full),
        .empty (w_credit_obuf_empty),
        .has_data (credit_out_valid));

    //
    // Translate outgoing oport to hardware addresses
    //
    RouterPortLookup #(.NPORTS(NPORTS), .WIDTH(`A_WIDTH)) oport_map (
        .clock (clock),
        .reset (reset),
        .ram_config_in (ram_config_in),
        .ram_config_in_valid (ram_config_in_valid),
        .ram_config_out (ram_config_out),
        .ram_config_out_valid (ram_config_out_valid),
        .port_id_a (w_s3_flit[`F_OPORT]),
        .haddr_a (nexthop_out),
        .port_id_b (w_s3_credit_oport),
        .haddr_b (credit_out_nexthop));
    
    
    //------------------------------------------------------------------------
    
    //
    // VC Allocation
    //
    wire [NINPUTS-1:0] w_vc_alloc_mask;
    genvar i;
    generate
        for (i = 0; i < NINPUTS; i = i + 1)
        begin : vc_mask
            assign w_vc_alloc_mask[i] = (ovc[i].credit_count == 0) ? 1'b0 : 1'b1;
        end
    endgenerate

    assign w_s2_vc_allocate_enable = r_s2_flit_valid & r_s2_flit[`F_HEAD] & w_s2_route_enable;
    assign w_s2_vc_free_enable = r_s2_flit_valid & r_s2_flit[`F_TAIL] & w_s2_route_enable;
    
    VCAlloc #(.NPORTS(NPORTS), .NVCS(NVCS)) vc_alloc (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .mask (w_vc_alloc_mask),
        .oport (rtable_oport),  // Indicate the output port to allocate VC for
        .allocate (w_s2_vc_allocate_enable),
        .next_vc (w_vc_alloc_out),
        .next_vc_valid (w_vc_alloc_out_valid),
        .free (w_s2_vc_free_enable),
        .free_vc (w_last_ovc_for_this_ivc));
    
    //
    // Output VCs allocated to the Input VCs
    //
    InputVCState #(.VC_WIDTH(LOG_NVCS), .NINPUTS(NINPUTS)) ivc_state (
        .clock (clock),
        .reset (reset),
        .allocated_vc (w_vc_alloc_out),
        .allocate_enable (w_s2_vc_allocate_enable),
        .ivc_sel (w_s2_flit_iport_sel),
        .assigned_vc (w_last_ovc_for_this_ivc));

    //
    // Credit Counters (1 for each output VC)
    //
    generate
    
        // Decoded input credits
        for (i = 0; i < NPORTS; i = i + 1)
        begin : iport_credit
            
            wire [NVCS-1:0] w_credit_in_vc_decoded;
            
            decoder_N #(.SIZE(NVCS)) vc_decode (
                .encoded (credit_vc(credit_in[(i+1)*`CREDIT_WIDTH-1:i*`CREDIT_WIDTH])),
                .decoded (w_credit_in_vc_decoded));
                
            assign w_credit_in_valid[(i+1)*NVCS-1:i*NVCS] = w_credit_in_vc_decoded & {(NVCS){credit_in_valid[i]}};
            assign credit_ack[i] = |(w_credit_ack[(i+1)*NVCS-1:i*NVCS]);
        end

        // Credit counters
        for (i = 0; i < NINPUTS; i = i + 1)
        begin : ovc
            wire [CC_WIDTH-1:0] credit_count;
            assign w_ovc_credit[(i+1)*CC_WIDTH-1:i*CC_WIDTH] = credit_count;

            CreditCounter #(.WIDTH(CC_WIDTH)) credit (
                .clock (clock),
                .reset (reset),
                .enable (enable),
                .sim_time_tick (sim_time_tick),
                .config_in (w_ovc_config_in[(i+1)*4-1:i*4]),
                .config_in_valid (w_ovc_config_in_valid[i]),
                .config_out (w_ovc_config_out[(i+1)*4-1:i*4]),
                .config_out_valid (w_ovc_config_out_valid[i]),
                .credit_in_valid (w_credit_in_valid[i]),
                .credit_ack (w_credit_ack[i]),
                .decrement (w_ovc_use_credit[i] & w_s2_routed),
                .count_out (credit_count));
        end
    endgenerate

    mux_Nto1 #(.WIDTH(CC_WIDTH), .SIZE(NINPUTS)) oport_credit_mux (
        .in (w_ovc_credit),
        .sel ({rtable_oport, w_s2_updated_flit[0]}),    // Use routed_vc to select credit
        .out (w_oport_credit));
    
    decoder_N #(.SIZE(NINPUTS)) credit_decode (
        .encoded ({rtable_oport, w_s2_updated_flit[0]}),
        .decoded (w_ovc_use_credit));

    // For now this composition of credit config only works for 10 VCs x 4 bits
    // psl ERROR_unsupported_router_oVCs: assert always {NINPUTS == 10 && CC_WIDTH == 4};

    assign w_ovc_config_in = {w_ovc_config_out[23:0], config_in};
    assign w_ovc_config_in_valid = {w_ovc_config_out_valid[5:0], {(4){config_in_valid}}};

    always @(posedge clock)
    begin
        if (reset)
            r_ovc_config_pad <= 8'h00;
        else if (w_ovc_config_out_valid[6])
            r_ovc_config_pad <= w_ovc_config_out[31:24];
    end
    
    //------------------------------------------------------------------------
    
    //
    // Control Signals
    //
    assign w_s2_vc_valid = r_s2_flit_valid & (~r_s2_flit[`F_HEAD] | w_vc_alloc_out_valid);
    assign w_s2_route_enable = (w_oport_credit != 0) ? 1'b1 : 1'b0;
    assign w_s2_routed = w_s2_route_enable & w_s2_vc_valid;
    
    
    //------------------------------------------------------------------------
    
    //
    // Error
    //
    assign error1 = w_credit_obuf_full;
    assign error2 = (r_s2_flit_valid == 1'b1 && rtable_oport == {(LOG_NPORTS){1'b1}}) ? 1'b1 : 1'b0;
    always @(posedge clock)
    begin
        if (reset)
            r_error <= 1'b0;
        else if (enable & ~r_error)
            r_error <= error1 | error2;
    end

endmodule


