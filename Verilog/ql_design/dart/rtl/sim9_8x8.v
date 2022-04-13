module sim9_8x8 (
    input clock,
    input reset,
    input enable,
    input stop_injection,
    input measure,
    output reg [9:0] sim_time,
    output sim_time_tick,
    output error,
    output [7:0] fdp_error,
    output [7:0] cdp_error,
    output [7:0] part_error,
    output quiescent,
    input [15:0] config_in,
    input config_in_valid,
    output [15:0] config_out,
    output config_out_valid,
    output [15:0] stats_out,
    input stats_shift
);

    // Internal states
    reg tick_counter;

    wire [0:0] can_increment;
    wire [0:0] can_tick;
    //wire [7:0] part_error;
    wire [7:0] part_quiescent;
    wire [7:0] part_can_increment;
    wire [15:0] part_config_in [8:0];
    wire [8:0] part_config_in_valid;
    wire [15:0] part_ram_config_in [8:0];
    wire [8:0] part_ram_config_in_valid;
    wire [15:0] part_stats_in [8:0];
    //wire [7:0] fdp_error;
    wire [7:0] fdp_select [7:0];
    //wire [7:0] cdp_error;
    wire [7:0] cdp_select [7:0];
    wire [7:0] fsp_select [7:0];
    wire [7:0] fsp_can_increment;
    wire [7:0] csp_select [7:0];
    wire [7:0] csp_can_increment;
    wire [63:0] fsp_s1_nexthop;
    wire [7:0] fsp_s1_valid;
    wire [7:0] fsp_s1_valid_urgent;
    wire [287:0] fsp_s2_data;
    wire [63:0] fsp_s2_nexthop;
    wire [63:0] csp_s1_nexthop;
    wire [7:0] csp_s1_valid;
    wire [7:0] csp_s1_valid_urgent;
    wire [87:0] csp_s2_data;
    wire [63:0] csp_s2_nexthop;

    assign sim_time_tick = enable & can_increment & can_tick;
    assign error = (|part_error) | (|fdp_error) | (|cdp_error);
    assign quiescent = &part_quiescent;
    assign can_increment = (&part_can_increment) & (&fsp_can_increment) & (&csp_can_increment);
    assign config_out = part_config_in[8];
    assign config_out_valid = part_config_in_valid[8];
    assign stats_out = part_stats_in[8];

    assign part_config_in_valid[0] = config_in_valid;
    assign part_config_in[0] = config_in;
    assign part_ram_config_in_valid[0] = config_in_valid;
    assign part_ram_config_in[0] = config_in;
    assign part_stats_in[0] = 16'h0000;
    

    wire [15:0] stats_in;
    assign stats_in = 16'h0000;
    
    always @(posedge clock)
    begin
        if (reset)
            sim_time <= 16'h0;
        else if (sim_time_tick)
            sim_time <= sim_time + 1;
    end
    always @(posedge clock)
    begin
        if (reset)
            tick_counter <= 1'b0;
        else if (enable)
        begin
            if (sim_time_tick)
                tick_counter <= 1'b0;
            else if (~tick_counter)
                tick_counter <= tick_counter + 1'b1;
        end
    end
    assign can_tick = tick_counter;


    wire [1:0] fsp_0_vec_valid;
    wire [1:0] fsp_0_vec_valid_urgent;
    wire [71:0] fsp_0_vec_data;
    wire [15:0] fsp_0_vec_nexthop;
    wire [1:0] fsp_0_vec_dequeue;
    wire [1:0] csp_0_vec_valid;
    wire [1:0] csp_0_vec_valid_urgent;
    wire [21:0] csp_0_vec_data;
    wire [15:0] csp_0_vec_nexthop;
    wire [1:0] csp_0_vec_dequeue;
    wire [0:0] fdp_0_valid;
    wire [35:0] fdp_0_data;
    wire [4:0] fdp_0_nexthop;
    wire [0:0] fdp_0_ack;
    wire [0:0] cdp_0_valid;
    wire [10:0] cdp_0_data;
    wire [4:0] cdp_0_nexthop;
    wire [0:0] cdp_0_ack;

    Partition #(.DPID(0), .N(2)) part_0 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .stop_injection (stop_injection),
        .measure (measure),
        .sim_time (sim_time),
        .sim_time_tick (sim_time_tick),
        .error (part_error[0]),
        .is_quiescent (part_quiescent[0]),
        .can_increment (part_can_increment[0]),
        .config_in_valid (part_config_in_valid[0]),
        .config_in (part_config_in[0]),
        .config_out_valid (part_config_in_valid[1]),
        .config_out (part_config_in[1]),
        .ram_config_in_valid (part_ram_config_in_valid[0]),
        .ram_config_in (part_ram_config_in[0]),
        .ram_config_out_valid (part_ram_config_in_valid[1]),
        .ram_config_out (part_ram_config_in[1]),
        .stats_shift (stats_shift),
        .stats_in (part_stats_in[0]),
        .stats_out (part_stats_in[1]),
        .fsp_vec_valid (fsp_0_vec_valid),
        .fsp_vec_valid_urgent (fsp_0_vec_valid_urgent),
        .fsp_vec_data (fsp_0_vec_data),
        .fsp_vec_nexthop (fsp_0_vec_nexthop),
        .fsp_vec_dequeue (fsp_0_vec_dequeue),
        .csp_vec_valid (csp_0_vec_valid),
        .csp_vec_valid_urgent (csp_0_vec_valid_urgent),
        .csp_vec_data (csp_0_vec_data),
        .csp_vec_nexthop (csp_0_vec_nexthop),
        .csp_vec_dequeue (csp_0_vec_dequeue),
        .fdp_valid (fdp_0_valid),
        .fdp_data (fdp_0_data),
        .fdp_nexthop (fdp_0_nexthop),
        .fdp_ack (fdp_0_ack),
        .cdp_valid (cdp_0_valid),
        .cdp_data (cdp_0_data),
        .cdp_nexthop (cdp_0_nexthop),
        .cdp_ack (cdp_0_ack)
    );

    ICDestPart #(.PID(0), .NSP(8), .WIDTH(36)) fdp_0 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (fdp_error[0]),
        .src_s1_valid (fsp_s1_valid),
        .src_s1_valid_urgent (fsp_s1_valid_urgent),
        .src_s1_nexthop_in (fsp_s1_nexthop),
        .src_s1_part_sel (fdp_select[0]),
        .src_s2_data_in (fsp_s2_data),
        .src_s2_nexthop_in (fsp_s2_nexthop),
        .dequeue (fdp_0_ack),
        .s3_data_out (fdp_0_data),
        .s3_nexthop_out (fdp_0_nexthop),
        .s3_data_valid (fdp_0_valid)
    );

    ICDestPart #(.PID(0), .NSP(8), .WIDTH(11)) cdp_0 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (cdp_error[0]),
        .src_s1_valid (csp_s1_valid),
        .src_s1_valid_urgent (csp_s1_valid_urgent),
        .src_s1_nexthop_in (csp_s1_nexthop),
        .src_s1_part_sel (cdp_select[0]),
        .src_s2_data_in (csp_s2_data),
        .src_s2_nexthop_in (csp_s2_nexthop),
        .dequeue (cdp_0_ack),
        .s3_data_out (cdp_0_data),
        .s3_nexthop_out (cdp_0_nexthop),
        .s3_data_valid (cdp_0_valid)
    );

    ICSourcePart #(.N(2), .WIDTH(36)) fsp_0 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|fsp_select[0]),
        .can_increment (fsp_can_increment[0]),
        .src_data_valid (fsp_0_vec_valid[1:0]),
        .src_data_valid_urgent (fsp_0_vec_valid_urgent[1:0]),
        .src_data_in (fsp_0_vec_data[71:0]),
        .src_nexthop_in (fsp_0_vec_nexthop[15:0]),
        .src_dequeue (fsp_0_vec_dequeue[1:0]),
        .s1_nexthop_out (fsp_s1_nexthop[7:0]),
        .s1_valid (fsp_s1_valid[0]),
        .s1_valid_urgent (fsp_s1_valid_urgent[0]),
        .s2_data_out (fsp_s2_data[35:0]),
        .s2_nexthop_out (fsp_s2_nexthop[7:0])
    );

    ICSourcePart #(.N(2), .WIDTH(11)) csp_0 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|csp_select[0]),
        .can_increment (csp_can_increment[0]),
        .src_data_valid (csp_0_vec_valid[1:0]),
        .src_data_valid_urgent (csp_0_vec_valid_urgent[1:0]),
        .src_data_in (csp_0_vec_data[21:0]),
        .src_nexthop_in (csp_0_vec_nexthop[15:0]),
        .src_dequeue (csp_0_vec_dequeue[1:0]),
        .s1_nexthop_out (csp_s1_nexthop[7:0]),
        .s1_valid (csp_s1_valid[0]),
        .s1_valid_urgent (csp_s1_valid_urgent[0]),
        .s2_data_out (csp_s2_data[10:0]),
        .s2_nexthop_out (csp_s2_nexthop[7:0])
    );

    wire [0:0] fsp_1_vec_valid;
    wire [0:0] fsp_1_vec_valid_urgent;
    wire [35:0] fsp_1_vec_data;
    wire [7:0] fsp_1_vec_nexthop;
    wire [0:0] fsp_1_vec_dequeue;
    wire [0:0] csp_1_vec_valid;
    wire [0:0] csp_1_vec_valid_urgent;
    wire [10:0] csp_1_vec_data;
    wire [7:0] csp_1_vec_nexthop;
    wire [0:0] csp_1_vec_dequeue;
    wire [0:0] fdp_1_valid;
    wire [35:0] fdp_1_data;
    wire [4:0] fdp_1_nexthop;
    wire [0:0] fdp_1_ack;
    wire [0:0] cdp_1_valid;
    wire [10:0] cdp_1_data;
    wire [4:0] cdp_1_nexthop;
    wire [0:0] cdp_1_ack;

    Partition #(.DPID(1), .N(1)) part_1 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .stop_injection (stop_injection),
        .measure (measure),
        .sim_time (sim_time),
        .sim_time_tick (sim_time_tick),
        .error (part_error[1]),
        .is_quiescent (part_quiescent[1]),
        .can_increment (part_can_increment[1]),
        .config_in_valid (part_config_in_valid[1]),
        .config_in (part_config_in[1]),
        .config_out_valid (part_config_in_valid[2]),
        .config_out (part_config_in[2]),
        .ram_config_in_valid (part_ram_config_in_valid[1]),
        .ram_config_in (part_ram_config_in[1]),
        .ram_config_out_valid (part_ram_config_in_valid[2]),
        .ram_config_out (part_ram_config_in[2]),
        .stats_shift (stats_shift),
        .stats_in (part_stats_in[1]),
        .stats_out (part_stats_in[2]),
        .fsp_vec_valid (fsp_1_vec_valid),
        .fsp_vec_valid_urgent (fsp_1_vec_valid_urgent),
        .fsp_vec_data (fsp_1_vec_data),
        .fsp_vec_nexthop (fsp_1_vec_nexthop),
        .fsp_vec_dequeue (fsp_1_vec_dequeue),
        .csp_vec_valid (csp_1_vec_valid),
        .csp_vec_valid_urgent (csp_1_vec_valid_urgent),
        .csp_vec_data (csp_1_vec_data),
        .csp_vec_nexthop (csp_1_vec_nexthop),
        .csp_vec_dequeue (csp_1_vec_dequeue),
        .fdp_valid (fdp_1_valid),
        .fdp_data (fdp_1_data),
        .fdp_nexthop (fdp_1_nexthop),
        .fdp_ack (fdp_1_ack),
        .cdp_valid (cdp_1_valid),
        .cdp_data (cdp_1_data),
        .cdp_nexthop (cdp_1_nexthop),
        .cdp_ack (cdp_1_ack)
    );

    ICDestPart #(.PID(1), .NSP(8), .WIDTH(36)) fdp_1 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (fdp_error[1]),
        .src_s1_valid (fsp_s1_valid),
        .src_s1_valid_urgent (fsp_s1_valid_urgent),
        .src_s1_nexthop_in (fsp_s1_nexthop),
        .src_s1_part_sel (fdp_select[1]),
        .src_s2_data_in (fsp_s2_data),
        .src_s2_nexthop_in (fsp_s2_nexthop),
        .dequeue (fdp_1_ack),
        .s3_data_out (fdp_1_data),
        .s3_nexthop_out (fdp_1_nexthop),
        .s3_data_valid (fdp_1_valid)
    );

    ICDestPart #(.PID(1), .NSP(8), .WIDTH(11)) cdp_1 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (cdp_error[1]),
        .src_s1_valid (csp_s1_valid),
        .src_s1_valid_urgent (csp_s1_valid_urgent),
        .src_s1_nexthop_in (csp_s1_nexthop),
        .src_s1_part_sel (cdp_select[1]),
        .src_s2_data_in (csp_s2_data),
        .src_s2_nexthop_in (csp_s2_nexthop),
        .dequeue (cdp_1_ack),
        .s3_data_out (cdp_1_data),
        .s3_nexthop_out (cdp_1_nexthop),
        .s3_data_valid (cdp_1_valid)
    );

    ICSourcePart #(.N(1), .WIDTH(36)) fsp_1 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|fsp_select[1]),
        .can_increment (fsp_can_increment[1]),
        .src_data_valid (fsp_1_vec_valid[0:0]),
        .src_data_valid_urgent (fsp_1_vec_valid_urgent[0:0]),
        .src_data_in (fsp_1_vec_data[35:0]),
        .src_nexthop_in (fsp_1_vec_nexthop[7:0]),
        .src_dequeue (fsp_1_vec_dequeue[0:0]),
        .s1_nexthop_out (fsp_s1_nexthop[15:8]),
        .s1_valid (fsp_s1_valid[1]),
        .s1_valid_urgent (fsp_s1_valid_urgent[1]),
        .s2_data_out (fsp_s2_data[71:36]),
        .s2_nexthop_out (fsp_s2_nexthop[15:8])
    );

    ICSourcePart #(.N(1), .WIDTH(11)) csp_1 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|csp_select[1]),
        .can_increment (csp_can_increment[1]),
        .src_data_valid (csp_1_vec_valid[0:0]),
        .src_data_valid_urgent (csp_1_vec_valid_urgent[0:0]),
        .src_data_in (csp_1_vec_data[10:0]),
        .src_nexthop_in (csp_1_vec_nexthop[7:0]),
        .src_dequeue (csp_1_vec_dequeue[0:0]),
        .s1_nexthop_out (csp_s1_nexthop[15:8]),
        .s1_valid (csp_s1_valid[1]),
        .s1_valid_urgent (csp_s1_valid_urgent[1]),
        .s2_data_out (csp_s2_data[21:11]),
        .s2_nexthop_out (csp_s2_nexthop[15:8])
    );

    wire [0:0] fsp_2_vec_valid;
    wire [0:0] fsp_2_vec_valid_urgent;
    wire [35:0] fsp_2_vec_data;
    wire [7:0] fsp_2_vec_nexthop;
    wire [0:0] fsp_2_vec_dequeue;
    wire [0:0] csp_2_vec_valid;
    wire [0:0] csp_2_vec_valid_urgent;
    wire [10:0] csp_2_vec_data;
    wire [7:0] csp_2_vec_nexthop;
    wire [0:0] csp_2_vec_dequeue;
    wire [0:0] fdp_2_valid;
    wire [35:0] fdp_2_data;
    wire [4:0] fdp_2_nexthop;
    wire [0:0] fdp_2_ack;
    wire [0:0] cdp_2_valid;
    wire [10:0] cdp_2_data;
    wire [4:0] cdp_2_nexthop;
    wire [0:0] cdp_2_ack;

    Partition #(.DPID(2), .N(1)) part_2 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .stop_injection (stop_injection),
        .measure (measure),
        .sim_time (sim_time),
        .sim_time_tick (sim_time_tick),
        .error (part_error[2]),
        .is_quiescent (part_quiescent[2]),
        .can_increment (part_can_increment[2]),
        .config_in_valid (part_config_in_valid[2]),
        .config_in (part_config_in[2]),
        .config_out_valid (part_config_in_valid[3]),
        .config_out (part_config_in[3]),
        .ram_config_in_valid (part_ram_config_in_valid[2]),
        .ram_config_in (part_ram_config_in[2]),
        .ram_config_out_valid (part_ram_config_in_valid[3]),
        .ram_config_out (part_ram_config_in[3]),
        .stats_shift (stats_shift),
        .stats_in (part_stats_in[2]),
        .stats_out (part_stats_in[3]),
        .fsp_vec_valid (fsp_2_vec_valid),
        .fsp_vec_valid_urgent (fsp_2_vec_valid_urgent),
        .fsp_vec_data (fsp_2_vec_data),
        .fsp_vec_nexthop (fsp_2_vec_nexthop),
        .fsp_vec_dequeue (fsp_2_vec_dequeue),
        .csp_vec_valid (csp_2_vec_valid),
        .csp_vec_valid_urgent (csp_2_vec_valid_urgent),
        .csp_vec_data (csp_2_vec_data),
        .csp_vec_nexthop (csp_2_vec_nexthop),
        .csp_vec_dequeue (csp_2_vec_dequeue),
        .fdp_valid (fdp_2_valid),
        .fdp_data (fdp_2_data),
        .fdp_nexthop (fdp_2_nexthop),
        .fdp_ack (fdp_2_ack),
        .cdp_valid (cdp_2_valid),
        .cdp_data (cdp_2_data),
        .cdp_nexthop (cdp_2_nexthop),
        .cdp_ack (cdp_2_ack)
    );

    ICDestPart #(.PID(2), .NSP(8), .WIDTH(36)) fdp_2 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (fdp_error[2]),
        .src_s1_valid (fsp_s1_valid),
        .src_s1_valid_urgent (fsp_s1_valid_urgent),
        .src_s1_nexthop_in (fsp_s1_nexthop),
        .src_s1_part_sel (fdp_select[2]),
        .src_s2_data_in (fsp_s2_data),
        .src_s2_nexthop_in (fsp_s2_nexthop),
        .dequeue (fdp_2_ack),
        .s3_data_out (fdp_2_data),
        .s3_nexthop_out (fdp_2_nexthop),
        .s3_data_valid (fdp_2_valid)
    );

    ICDestPart #(.PID(2), .NSP(8), .WIDTH(11)) cdp_2 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (cdp_error[2]),
        .src_s1_valid (csp_s1_valid),
        .src_s1_valid_urgent (csp_s1_valid_urgent),
        .src_s1_nexthop_in (csp_s1_nexthop),
        .src_s1_part_sel (cdp_select[2]),
        .src_s2_data_in (csp_s2_data),
        .src_s2_nexthop_in (csp_s2_nexthop),
        .dequeue (cdp_2_ack),
        .s3_data_out (cdp_2_data),
        .s3_nexthop_out (cdp_2_nexthop),
        .s3_data_valid (cdp_2_valid)
    );

    ICSourcePart #(.N(1), .WIDTH(36)) fsp_2 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|fsp_select[2]),
        .can_increment (fsp_can_increment[2]),
        .src_data_valid (fsp_2_vec_valid[0:0]),
        .src_data_valid_urgent (fsp_2_vec_valid_urgent[0:0]),
        .src_data_in (fsp_2_vec_data[35:0]),
        .src_nexthop_in (fsp_2_vec_nexthop[7:0]),
        .src_dequeue (fsp_2_vec_dequeue[0:0]),
        .s1_nexthop_out (fsp_s1_nexthop[23:16]),
        .s1_valid (fsp_s1_valid[2]),
        .s1_valid_urgent (fsp_s1_valid_urgent[2]),
        .s2_data_out (fsp_s2_data[107:72]),
        .s2_nexthop_out (fsp_s2_nexthop[23:16])
    );

    ICSourcePart #(.N(1), .WIDTH(11)) csp_2 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|csp_select[2]),
        .can_increment (csp_can_increment[2]),
        .src_data_valid (csp_2_vec_valid[0:0]),
        .src_data_valid_urgent (csp_2_vec_valid_urgent[0:0]),
        .src_data_in (csp_2_vec_data[10:0]),
        .src_nexthop_in (csp_2_vec_nexthop[7:0]),
        .src_dequeue (csp_2_vec_dequeue[0:0]),
        .s1_nexthop_out (csp_s1_nexthop[23:16]),
        .s1_valid (csp_s1_valid[2]),
        .s1_valid_urgent (csp_s1_valid_urgent[2]),
        .s2_data_out (csp_s2_data[32:22]),
        .s2_nexthop_out (csp_s2_nexthop[23:16])
    );

    wire [0:0] fsp_3_vec_valid;
    wire [0:0] fsp_3_vec_valid_urgent;
    wire [35:0] fsp_3_vec_data;
    wire [7:0] fsp_3_vec_nexthop;
    wire [0:0] fsp_3_vec_dequeue;
    wire [0:0] csp_3_vec_valid;
    wire [0:0] csp_3_vec_valid_urgent;
    wire [10:0] csp_3_vec_data;
    wire [7:0] csp_3_vec_nexthop;
    wire [0:0] csp_3_vec_dequeue;
    wire [0:0] fdp_3_valid;
    wire [35:0] fdp_3_data;
    wire [4:0] fdp_3_nexthop;
    wire [0:0] fdp_3_ack;
    wire [0:0] cdp_3_valid;
    wire [10:0] cdp_3_data;
    wire [4:0] cdp_3_nexthop;
    wire [0:0] cdp_3_ack;

    Partition #(.DPID(3), .N(1)) part_3 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .stop_injection (stop_injection),
        .measure (measure),
        .sim_time (sim_time),
        .sim_time_tick (sim_time_tick),
        .error (part_error[3]),
        .is_quiescent (part_quiescent[3]),
        .can_increment (part_can_increment[3]),
        .config_in_valid (part_config_in_valid[3]),
        .config_in (part_config_in[3]),
        .config_out_valid (part_config_in_valid[4]),
        .config_out (part_config_in[4]),
        .ram_config_in_valid (part_ram_config_in_valid[3]),
        .ram_config_in (part_ram_config_in[3]),
        .ram_config_out_valid (part_ram_config_in_valid[4]),
        .ram_config_out (part_ram_config_in[4]),
        .stats_shift (stats_shift),
        .stats_in (part_stats_in[3]),
        .stats_out (part_stats_in[4]),
        .fsp_vec_valid (fsp_3_vec_valid),
        .fsp_vec_valid_urgent (fsp_3_vec_valid_urgent),
        .fsp_vec_data (fsp_3_vec_data),
        .fsp_vec_nexthop (fsp_3_vec_nexthop),
        .fsp_vec_dequeue (fsp_3_vec_dequeue),
        .csp_vec_valid (csp_3_vec_valid),
        .csp_vec_valid_urgent (csp_3_vec_valid_urgent),
        .csp_vec_data (csp_3_vec_data),
        .csp_vec_nexthop (csp_3_vec_nexthop),
        .csp_vec_dequeue (csp_3_vec_dequeue),
        .fdp_valid (fdp_3_valid),
        .fdp_data (fdp_3_data),
        .fdp_nexthop (fdp_3_nexthop),
        .fdp_ack (fdp_3_ack),
        .cdp_valid (cdp_3_valid),
        .cdp_data (cdp_3_data),
        .cdp_nexthop (cdp_3_nexthop),
        .cdp_ack (cdp_3_ack)
    );

    ICDestPart #(.PID(3), .NSP(8), .WIDTH(36)) fdp_3 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (fdp_error[3]),
        .src_s1_valid (fsp_s1_valid),
        .src_s1_valid_urgent (fsp_s1_valid_urgent),
        .src_s1_nexthop_in (fsp_s1_nexthop),
        .src_s1_part_sel (fdp_select[3]),
        .src_s2_data_in (fsp_s2_data),
        .src_s2_nexthop_in (fsp_s2_nexthop),
        .dequeue (fdp_3_ack),
        .s3_data_out (fdp_3_data),
        .s3_nexthop_out (fdp_3_nexthop),
        .s3_data_valid (fdp_3_valid)
    );

    ICDestPart #(.PID(3), .NSP(8), .WIDTH(11)) cdp_3 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (cdp_error[3]),
        .src_s1_valid (csp_s1_valid),
        .src_s1_valid_urgent (csp_s1_valid_urgent),
        .src_s1_nexthop_in (csp_s1_nexthop),
        .src_s1_part_sel (cdp_select[3]),
        .src_s2_data_in (csp_s2_data),
        .src_s2_nexthop_in (csp_s2_nexthop),
        .dequeue (cdp_3_ack),
        .s3_data_out (cdp_3_data),
        .s3_nexthop_out (cdp_3_nexthop),
        .s3_data_valid (cdp_3_valid)
    );

    ICSourcePart #(.N(1), .WIDTH(36)) fsp_3 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|fsp_select[3]),
        .can_increment (fsp_can_increment[3]),
        .src_data_valid (fsp_3_vec_valid[0:0]),
        .src_data_valid_urgent (fsp_3_vec_valid_urgent[0:0]),
        .src_data_in (fsp_3_vec_data[35:0]),
        .src_nexthop_in (fsp_3_vec_nexthop[7:0]),
        .src_dequeue (fsp_3_vec_dequeue[0:0]),
        .s1_nexthop_out (fsp_s1_nexthop[31:24]),
        .s1_valid (fsp_s1_valid[3]),
        .s1_valid_urgent (fsp_s1_valid_urgent[3]),
        .s2_data_out (fsp_s2_data[143:108]),
        .s2_nexthop_out (fsp_s2_nexthop[31:24])
    );

    ICSourcePart #(.N(1), .WIDTH(11)) csp_3 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|csp_select[3]),
        .can_increment (csp_can_increment[3]),
        .src_data_valid (csp_3_vec_valid[0:0]),
        .src_data_valid_urgent (csp_3_vec_valid_urgent[0:0]),
        .src_data_in (csp_3_vec_data[10:0]),
        .src_nexthop_in (csp_3_vec_nexthop[7:0]),
        .src_dequeue (csp_3_vec_dequeue[0:0]),
        .s1_nexthop_out (csp_s1_nexthop[31:24]),
        .s1_valid (csp_s1_valid[3]),
        .s1_valid_urgent (csp_s1_valid_urgent[3]),
        .s2_data_out (csp_s2_data[43:33]),
        .s2_nexthop_out (csp_s2_nexthop[31:24])
    );

    wire [0:0] fsp_4_vec_valid;
    wire [0:0] fsp_4_vec_valid_urgent;
    wire [35:0] fsp_4_vec_data;
    wire [7:0] fsp_4_vec_nexthop;
    wire [0:0] fsp_4_vec_dequeue;
    wire [0:0] csp_4_vec_valid;
    wire [0:0] csp_4_vec_valid_urgent;
    wire [10:0] csp_4_vec_data;
    wire [7:0] csp_4_vec_nexthop;
    wire [0:0] csp_4_vec_dequeue;
    wire [0:0] fdp_4_valid;
    wire [35:0] fdp_4_data;
    wire [4:0] fdp_4_nexthop;
    wire [0:0] fdp_4_ack;
    wire [0:0] cdp_4_valid;
    wire [10:0] cdp_4_data;
    wire [4:0] cdp_4_nexthop;
    wire [0:0] cdp_4_ack;

    Partition #(.DPID(4), .N(1)) part_4 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .stop_injection (stop_injection),
        .measure (measure),
        .sim_time (sim_time),
        .sim_time_tick (sim_time_tick),
        .error (part_error[4]),
        .is_quiescent (part_quiescent[4]),
        .can_increment (part_can_increment[4]),
        .config_in_valid (part_config_in_valid[4]),
        .config_in (part_config_in[4]),
        .config_out_valid (part_config_in_valid[5]),
        .config_out (part_config_in[5]),
        .ram_config_in_valid (part_ram_config_in_valid[4]),
        .ram_config_in (part_ram_config_in[4]),
        .ram_config_out_valid (part_ram_config_in_valid[5]),
        .ram_config_out (part_ram_config_in[5]),
        .stats_shift (stats_shift),
        .stats_in (part_stats_in[4]),
        .stats_out (part_stats_in[5]),
        .fsp_vec_valid (fsp_4_vec_valid),
        .fsp_vec_valid_urgent (fsp_4_vec_valid_urgent),
        .fsp_vec_data (fsp_4_vec_data),
        .fsp_vec_nexthop (fsp_4_vec_nexthop),
        .fsp_vec_dequeue (fsp_4_vec_dequeue),
        .csp_vec_valid (csp_4_vec_valid),
        .csp_vec_valid_urgent (csp_4_vec_valid_urgent),
        .csp_vec_data (csp_4_vec_data),
        .csp_vec_nexthop (csp_4_vec_nexthop),
        .csp_vec_dequeue (csp_4_vec_dequeue),
        .fdp_valid (fdp_4_valid),
        .fdp_data (fdp_4_data),
        .fdp_nexthop (fdp_4_nexthop),
        .fdp_ack (fdp_4_ack),
        .cdp_valid (cdp_4_valid),
        .cdp_data (cdp_4_data),
        .cdp_nexthop (cdp_4_nexthop),
        .cdp_ack (cdp_4_ack)
    );

    ICDestPart #(.PID(4), .NSP(8), .WIDTH(36)) fdp_4 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (fdp_error[4]),
        .src_s1_valid (fsp_s1_valid),
        .src_s1_valid_urgent (fsp_s1_valid_urgent),
        .src_s1_nexthop_in (fsp_s1_nexthop),
        .src_s1_part_sel (fdp_select[4]),
        .src_s2_data_in (fsp_s2_data),
        .src_s2_nexthop_in (fsp_s2_nexthop),
        .dequeue (fdp_4_ack),
        .s3_data_out (fdp_4_data),
        .s3_nexthop_out (fdp_4_nexthop),
        .s3_data_valid (fdp_4_valid)
    );

    ICDestPart #(.PID(4), .NSP(8), .WIDTH(11)) cdp_4 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (cdp_error[4]),
        .src_s1_valid (csp_s1_valid),
        .src_s1_valid_urgent (csp_s1_valid_urgent),
        .src_s1_nexthop_in (csp_s1_nexthop),
        .src_s1_part_sel (cdp_select[4]),
        .src_s2_data_in (csp_s2_data),
        .src_s2_nexthop_in (csp_s2_nexthop),
        .dequeue (cdp_4_ack),
        .s3_data_out (cdp_4_data),
        .s3_nexthop_out (cdp_4_nexthop),
        .s3_data_valid (cdp_4_valid)
    );

    ICSourcePart #(.N(1), .WIDTH(36)) fsp_4 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|fsp_select[4]),
        .can_increment (fsp_can_increment[4]),
        .src_data_valid (fsp_4_vec_valid[0:0]),
        .src_data_valid_urgent (fsp_4_vec_valid_urgent[0:0]),
        .src_data_in (fsp_4_vec_data[35:0]),
        .src_nexthop_in (fsp_4_vec_nexthop[7:0]),
        .src_dequeue (fsp_4_vec_dequeue[0:0]),
        .s1_nexthop_out (fsp_s1_nexthop[39:32]),
        .s1_valid (fsp_s1_valid[4]),
        .s1_valid_urgent (fsp_s1_valid_urgent[4]),
        .s2_data_out (fsp_s2_data[179:144]),
        .s2_nexthop_out (fsp_s2_nexthop[39:32])
    );

    ICSourcePart #(.N(1), .WIDTH(11)) csp_4 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|csp_select[4]),
        .can_increment (csp_can_increment[4]),
        .src_data_valid (csp_4_vec_valid[0:0]),
        .src_data_valid_urgent (csp_4_vec_valid_urgent[0:0]),
        .src_data_in (csp_4_vec_data[10:0]),
        .src_nexthop_in (csp_4_vec_nexthop[7:0]),
        .src_dequeue (csp_4_vec_dequeue[0:0]),
        .s1_nexthop_out (csp_s1_nexthop[39:32]),
        .s1_valid (csp_s1_valid[4]),
        .s1_valid_urgent (csp_s1_valid_urgent[4]),
        .s2_data_out (csp_s2_data[54:44]),
        .s2_nexthop_out (csp_s2_nexthop[39:32])
    );

    wire [0:0] fsp_5_vec_valid;
    wire [0:0] fsp_5_vec_valid_urgent;
    wire [35:0] fsp_5_vec_data;
    wire [7:0] fsp_5_vec_nexthop;
    wire [0:0] fsp_5_vec_dequeue;
    wire [0:0] csp_5_vec_valid;
    wire [0:0] csp_5_vec_valid_urgent;
    wire [10:0] csp_5_vec_data;
    wire [7:0] csp_5_vec_nexthop;
    wire [0:0] csp_5_vec_dequeue;
    wire [0:0] fdp_5_valid;
    wire [35:0] fdp_5_data;
    wire [4:0] fdp_5_nexthop;
    wire [0:0] fdp_5_ack;
    wire [0:0] cdp_5_valid;
    wire [10:0] cdp_5_data;
    wire [4:0] cdp_5_nexthop;
    wire [0:0] cdp_5_ack;

    Partition #(.DPID(5), .N(1)) part_5 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .stop_injection (stop_injection),
        .measure (measure),
        .sim_time (sim_time),
        .sim_time_tick (sim_time_tick),
        .error (part_error[5]),
        .is_quiescent (part_quiescent[5]),
        .can_increment (part_can_increment[5]),
        .config_in_valid (part_config_in_valid[5]),
        .config_in (part_config_in[5]),
        .config_out_valid (part_config_in_valid[6]),
        .config_out (part_config_in[6]),
        .ram_config_in_valid (part_ram_config_in_valid[5]),
        .ram_config_in (part_ram_config_in[5]),
        .ram_config_out_valid (part_ram_config_in_valid[6]),
        .ram_config_out (part_ram_config_in[6]),
        .stats_shift (stats_shift),
        .stats_in (part_stats_in[5]),
        .stats_out (part_stats_in[6]),
        .fsp_vec_valid (fsp_5_vec_valid),
        .fsp_vec_valid_urgent (fsp_5_vec_valid_urgent),
        .fsp_vec_data (fsp_5_vec_data),
        .fsp_vec_nexthop (fsp_5_vec_nexthop),
        .fsp_vec_dequeue (fsp_5_vec_dequeue),
        .csp_vec_valid (csp_5_vec_valid),
        .csp_vec_valid_urgent (csp_5_vec_valid_urgent),
        .csp_vec_data (csp_5_vec_data),
        .csp_vec_nexthop (csp_5_vec_nexthop),
        .csp_vec_dequeue (csp_5_vec_dequeue),
        .fdp_valid (fdp_5_valid),
        .fdp_data (fdp_5_data),
        .fdp_nexthop (fdp_5_nexthop),
        .fdp_ack (fdp_5_ack),
        .cdp_valid (cdp_5_valid),
        .cdp_data (cdp_5_data),
        .cdp_nexthop (cdp_5_nexthop),
        .cdp_ack (cdp_5_ack)
    );

    ICDestPart #(.PID(5), .NSP(8), .WIDTH(36)) fdp_5 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (fdp_error[5]),
        .src_s1_valid (fsp_s1_valid),
        .src_s1_valid_urgent (fsp_s1_valid_urgent),
        .src_s1_nexthop_in (fsp_s1_nexthop),
        .src_s1_part_sel (fdp_select[5]),
        .src_s2_data_in (fsp_s2_data),
        .src_s2_nexthop_in (fsp_s2_nexthop),
        .dequeue (fdp_5_ack),
        .s3_data_out (fdp_5_data),
        .s3_nexthop_out (fdp_5_nexthop),
        .s3_data_valid (fdp_5_valid)
    );

    ICDestPart #(.PID(5), .NSP(8), .WIDTH(11)) cdp_5 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (cdp_error[5]),
        .src_s1_valid (csp_s1_valid),
        .src_s1_valid_urgent (csp_s1_valid_urgent),
        .src_s1_nexthop_in (csp_s1_nexthop),
        .src_s1_part_sel (cdp_select[5]),
        .src_s2_data_in (csp_s2_data),
        .src_s2_nexthop_in (csp_s2_nexthop),
        .dequeue (cdp_5_ack),
        .s3_data_out (cdp_5_data),
        .s3_nexthop_out (cdp_5_nexthop),
        .s3_data_valid (cdp_5_valid)
    );

    ICSourcePart #(.N(1), .WIDTH(36)) fsp_5 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|fsp_select[5]),
        .can_increment (fsp_can_increment[5]),
        .src_data_valid (fsp_5_vec_valid[0:0]),
        .src_data_valid_urgent (fsp_5_vec_valid_urgent[0:0]),
        .src_data_in (fsp_5_vec_data[35:0]),
        .src_nexthop_in (fsp_5_vec_nexthop[7:0]),
        .src_dequeue (fsp_5_vec_dequeue[0:0]),
        .s1_nexthop_out (fsp_s1_nexthop[47:40]),
        .s1_valid (fsp_s1_valid[5]),
        .s1_valid_urgent (fsp_s1_valid_urgent[5]),
        .s2_data_out (fsp_s2_data[215:180]),
        .s2_nexthop_out (fsp_s2_nexthop[47:40])
    );

    ICSourcePart #(.N(1), .WIDTH(11)) csp_5 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|csp_select[5]),
        .can_increment (csp_can_increment[5]),
        .src_data_valid (csp_5_vec_valid[0:0]),
        .src_data_valid_urgent (csp_5_vec_valid_urgent[0:0]),
        .src_data_in (csp_5_vec_data[10:0]),
        .src_nexthop_in (csp_5_vec_nexthop[7:0]),
        .src_dequeue (csp_5_vec_dequeue[0:0]),
        .s1_nexthop_out (csp_s1_nexthop[47:40]),
        .s1_valid (csp_s1_valid[5]),
        .s1_valid_urgent (csp_s1_valid_urgent[5]),
        .s2_data_out (csp_s2_data[65:55]),
        .s2_nexthop_out (csp_s2_nexthop[47:40])
    );

    wire [0:0] fsp_6_vec_valid;
    wire [0:0] fsp_6_vec_valid_urgent;
    wire [35:0] fsp_6_vec_data;
    wire [7:0] fsp_6_vec_nexthop;
    wire [0:0] fsp_6_vec_dequeue;
    wire [0:0] csp_6_vec_valid;
    wire [0:0] csp_6_vec_valid_urgent;
    wire [10:0] csp_6_vec_data;
    wire [7:0] csp_6_vec_nexthop;
    wire [0:0] csp_6_vec_dequeue;
    wire [0:0] fdp_6_valid;
    wire [35:0] fdp_6_data;
    wire [4:0] fdp_6_nexthop;
    wire [0:0] fdp_6_ack;
    wire [0:0] cdp_6_valid;
    wire [10:0] cdp_6_data;
    wire [4:0] cdp_6_nexthop;
    wire [0:0] cdp_6_ack;

    Partition #(.DPID(6), .N(1)) part_6 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .stop_injection (stop_injection),
        .measure (measure),
        .sim_time (sim_time),
        .sim_time_tick (sim_time_tick),
        .error (part_error[6]),
        .is_quiescent (part_quiescent[6]),
        .can_increment (part_can_increment[6]),
        .config_in_valid (part_config_in_valid[6]),
        .config_in (part_config_in[6]),
        .config_out_valid (part_config_in_valid[7]),
        .config_out (part_config_in[7]),
        .ram_config_in_valid (part_ram_config_in_valid[6]),
        .ram_config_in (part_ram_config_in[6]),
        .ram_config_out_valid (part_ram_config_in_valid[7]),
        .ram_config_out (part_ram_config_in[7]),
        .stats_shift (stats_shift),
        .stats_in (part_stats_in[6]),
        .stats_out (part_stats_in[7]),
        .fsp_vec_valid (fsp_6_vec_valid),
        .fsp_vec_valid_urgent (fsp_6_vec_valid_urgent),
        .fsp_vec_data (fsp_6_vec_data),
        .fsp_vec_nexthop (fsp_6_vec_nexthop),
        .fsp_vec_dequeue (fsp_6_vec_dequeue),
        .csp_vec_valid (csp_6_vec_valid),
        .csp_vec_valid_urgent (csp_6_vec_valid_urgent),
        .csp_vec_data (csp_6_vec_data),
        .csp_vec_nexthop (csp_6_vec_nexthop),
        .csp_vec_dequeue (csp_6_vec_dequeue),
        .fdp_valid (fdp_6_valid),
        .fdp_data (fdp_6_data),
        .fdp_nexthop (fdp_6_nexthop),
        .fdp_ack (fdp_6_ack),
        .cdp_valid (cdp_6_valid),
        .cdp_data (cdp_6_data),
        .cdp_nexthop (cdp_6_nexthop),
        .cdp_ack (cdp_6_ack)
    );

    ICDestPart #(.PID(6), .NSP(8), .WIDTH(36)) fdp_6 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (fdp_error[6]),
        .src_s1_valid (fsp_s1_valid),
        .src_s1_valid_urgent (fsp_s1_valid_urgent),
        .src_s1_nexthop_in (fsp_s1_nexthop),
        .src_s1_part_sel (fdp_select[6]),
        .src_s2_data_in (fsp_s2_data),
        .src_s2_nexthop_in (fsp_s2_nexthop),
        .dequeue (fdp_6_ack),
        .s3_data_out (fdp_6_data),
        .s3_nexthop_out (fdp_6_nexthop),
        .s3_data_valid (fdp_6_valid)
    );

    ICDestPart #(.PID(6), .NSP(8), .WIDTH(11)) cdp_6 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (cdp_error[6]),
        .src_s1_valid (csp_s1_valid),
        .src_s1_valid_urgent (csp_s1_valid_urgent),
        .src_s1_nexthop_in (csp_s1_nexthop),
        .src_s1_part_sel (cdp_select[6]),
        .src_s2_data_in (csp_s2_data),
        .src_s2_nexthop_in (csp_s2_nexthop),
        .dequeue (cdp_6_ack),
        .s3_data_out (cdp_6_data),
        .s3_nexthop_out (cdp_6_nexthop),
        .s3_data_valid (cdp_6_valid)
    );

    ICSourcePart #(.N(1), .WIDTH(36)) fsp_6 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|fsp_select[6]),
        .can_increment (fsp_can_increment[6]),
        .src_data_valid (fsp_6_vec_valid[0:0]),
        .src_data_valid_urgent (fsp_6_vec_valid_urgent[0:0]),
        .src_data_in (fsp_6_vec_data[35:0]),
        .src_nexthop_in (fsp_6_vec_nexthop[7:0]),
        .src_dequeue (fsp_6_vec_dequeue[0:0]),
        .s1_nexthop_out (fsp_s1_nexthop[55:48]),
        .s1_valid (fsp_s1_valid[6]),
        .s1_valid_urgent (fsp_s1_valid_urgent[6]),
        .s2_data_out (fsp_s2_data[251:216]),
        .s2_nexthop_out (fsp_s2_nexthop[55:48])
    );

    ICSourcePart #(.N(1), .WIDTH(11)) csp_6 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|csp_select[6]),
        .can_increment (csp_can_increment[6]),
        .src_data_valid (csp_6_vec_valid[0:0]),
        .src_data_valid_urgent (csp_6_vec_valid_urgent[0:0]),
        .src_data_in (csp_6_vec_data[10:0]),
        .src_nexthop_in (csp_6_vec_nexthop[7:0]),
        .src_dequeue (csp_6_vec_dequeue[0:0]),
        .s1_nexthop_out (csp_s1_nexthop[55:48]),
        .s1_valid (csp_s1_valid[6]),
        .s1_valid_urgent (csp_s1_valid_urgent[6]),
        .s2_data_out (csp_s2_data[76:66]),
        .s2_nexthop_out (csp_s2_nexthop[55:48])
    );

    wire [0:0] fsp_7_vec_valid;
    wire [0:0] fsp_7_vec_valid_urgent;
    wire [35:0] fsp_7_vec_data;
    wire [7:0] fsp_7_vec_nexthop;
    wire [0:0] fsp_7_vec_dequeue;
    wire [0:0] csp_7_vec_valid;
    wire [0:0] csp_7_vec_valid_urgent;
    wire [10:0] csp_7_vec_data;
    wire [7:0] csp_7_vec_nexthop;
    wire [0:0] csp_7_vec_dequeue;
    wire [0:0] fdp_7_valid;
    wire [35:0] fdp_7_data;
    wire [4:0] fdp_7_nexthop;
    wire [0:0] fdp_7_ack;
    wire [0:0] cdp_7_valid;
    wire [10:0] cdp_7_data;
    wire [4:0] cdp_7_nexthop;
    wire [0:0] cdp_7_ack;

    Partition #(.DPID(7), .N(1)) part_7 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .stop_injection (stop_injection),
        .measure (measure),
        .sim_time (sim_time),
        .sim_time_tick (sim_time_tick),
        .error (part_error[7]),
        .is_quiescent (part_quiescent[7]),
        .can_increment (part_can_increment[7]),
        .config_in_valid (part_config_in_valid[7]),
        .config_in (part_config_in[7]),
        .config_out_valid (part_config_in_valid[8]),
        .config_out (part_config_in[8]),
        .ram_config_in_valid (part_ram_config_in_valid[7]),
        .ram_config_in (part_ram_config_in[7]),
        .ram_config_out_valid (part_ram_config_in_valid[8]),
        .ram_config_out (part_ram_config_in[8]),
        .stats_shift (stats_shift),
        .stats_in (part_stats_in[7]),
        .stats_out (part_stats_in[8]),
        .fsp_vec_valid (fsp_7_vec_valid),
        .fsp_vec_valid_urgent (fsp_7_vec_valid_urgent),
        .fsp_vec_data (fsp_7_vec_data),
        .fsp_vec_nexthop (fsp_7_vec_nexthop),
        .fsp_vec_dequeue (fsp_7_vec_dequeue),
        .csp_vec_valid (csp_7_vec_valid),
        .csp_vec_valid_urgent (csp_7_vec_valid_urgent),
        .csp_vec_data (csp_7_vec_data),
        .csp_vec_nexthop (csp_7_vec_nexthop),
        .csp_vec_dequeue (csp_7_vec_dequeue),
        .fdp_valid (fdp_7_valid),
        .fdp_data (fdp_7_data),
        .fdp_nexthop (fdp_7_nexthop),
        .fdp_ack (fdp_7_ack),
        .cdp_valid (cdp_7_valid),
        .cdp_data (cdp_7_data),
        .cdp_nexthop (cdp_7_nexthop),
        .cdp_ack (cdp_7_ack)
    );

    ICDestPart #(.PID(7), .NSP(8), .WIDTH(36)) fdp_7 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (fdp_error[7]),
        .src_s1_valid (fsp_s1_valid),
        .src_s1_valid_urgent (fsp_s1_valid_urgent),
        .src_s1_nexthop_in (fsp_s1_nexthop),
        .src_s1_part_sel (fdp_select[7]),
        .src_s2_data_in (fsp_s2_data),
        .src_s2_nexthop_in (fsp_s2_nexthop),
        .dequeue (fdp_7_ack),
        .s3_data_out (fdp_7_data),
        .s3_nexthop_out (fdp_7_nexthop),
        .s3_data_valid (fdp_7_valid)
    );

    ICDestPart #(.PID(7), .NSP(8), .WIDTH(11)) cdp_7 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (cdp_error[7]),
        .src_s1_valid (csp_s1_valid),
        .src_s1_valid_urgent (csp_s1_valid_urgent),
        .src_s1_nexthop_in (csp_s1_nexthop),
        .src_s1_part_sel (cdp_select[7]),
        .src_s2_data_in (csp_s2_data),
        .src_s2_nexthop_in (csp_s2_nexthop),
        .dequeue (cdp_7_ack),
        .s3_data_out (cdp_7_data),
        .s3_nexthop_out (cdp_7_nexthop),
        .s3_data_valid (cdp_7_valid)
    );

    ICSourcePart #(.N(1), .WIDTH(36)) fsp_7 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|fsp_select[7]),
        .can_increment (fsp_can_increment[7]),
        .src_data_valid (fsp_7_vec_valid[0:0]),
        .src_data_valid_urgent (fsp_7_vec_valid_urgent[0:0]),
        .src_data_in (fsp_7_vec_data[35:0]),
        .src_nexthop_in (fsp_7_vec_nexthop[7:0]),
        .src_dequeue (fsp_7_vec_dequeue[0:0]),
        .s1_nexthop_out (fsp_s1_nexthop[63:56]),
        .s1_valid (fsp_s1_valid[7]),
        .s1_valid_urgent (fsp_s1_valid_urgent[7]),
        .s2_data_out (fsp_s2_data[287:252]),
        .s2_nexthop_out (fsp_s2_nexthop[63:56])
    );

    ICSourcePart #(.N(1), .WIDTH(11)) csp_7 (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .select (|csp_select[7]),
        .can_increment (csp_can_increment[7]),
        .src_data_valid (csp_7_vec_valid[0:0]),
        .src_data_valid_urgent (csp_7_vec_valid_urgent[0:0]),
        .src_data_in (csp_7_vec_data[10:0]),
        .src_nexthop_in (csp_7_vec_nexthop[7:0]),
        .src_dequeue (csp_7_vec_dequeue[0:0]),
        .s1_nexthop_out (csp_s1_nexthop[63:56]),
        .s1_valid (csp_s1_valid[7]),
        .s1_valid_urgent (csp_s1_valid_urgent[7]),
        .s2_data_out (csp_s2_data[87:77]),
        .s2_nexthop_out (csp_s2_nexthop[63:56])
    );

    genvar i, j;
    generate
        for (j = 0; j < 8; j = j + 1)
        begin : dp_sp_sel
            for (i = 0; i < 8; i = i + 1)
            begin: dp
                assign fsp_select[j][i] = fdp_select[i][j];
                assign csp_select[j][i] = cdp_select[i][j];
            end
        end
    endgenerate

endmodule

