// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_iiq (
    core_clk,
    core_reset_n,
    flush,
    w_valid,
    w_ready,
    w_data0,
    w_data1,
    r_valid,
    r_ready,
    r_data0,
    r_data1
);
parameter DW = 32;
localparam DEPTH = 4;
input core_clk;
input core_reset_n;
input flush;
input [1:0] w_valid;
output [1:0] w_ready;
input [DW - 1:0] w_data0;
input [DW - 1:0] w_data1;
output [1:0] r_valid;
input [1:0] r_ready;
output [DW - 1:0] r_data0;
output [DW - 1:0] r_data1;


reg [DEPTH - 1:0] s0;
wire [DEPTH - 1:0] s1;
wire s2;
reg [DEPTH - 1:0] s3;
reg [DEPTH - 1:0] s4;
wire [DEPTH - 1:0] s5;
wire [DEPTH - 1:0] s6;
wire s7;
wire s8;
wire [DEPTH - 1:0] s9;
wire [DEPTH - 1:0] s10;
wire [DEPTH - 1:0] s11;
reg [DW - 1:0] s12;
wire [DW - 1:0] s13;
reg [DW - 1:0] s14;
wire [DW - 1:0] s15;
reg [DW - 1:0] s16;
wire [DW - 1:0] s17;
reg [DW - 1:0] s18;
wire [DW - 1:0] s19;
assign s8 = (w_valid[0] & w_ready[0]) | (w_valid[1] & w_ready[1]) | flush;
assign s7 = (r_valid[0] & r_ready[0]) | (r_valid[1] & r_ready[1]) | flush;
assign s5 = flush ? {{(DEPTH - 1){1'b0}},1'b1} : (r_valid[1] & r_ready[1]) ? {s3[DEPTH - 3:0],s3[DEPTH - 1 -:2]} : {s3[DEPTH - 2:0],s3[DEPTH - 1]};
assign s6 = flush ? {{(DEPTH - 1){1'b0}},1'b1} : (w_valid[1] & w_ready[1]) ? {s4[DEPTH - 3:0],s4[DEPTH - 1 -:2]} : {s4[DEPTH - 2:0],s4[DEPTH - 1]};
assign r_valid[0] = |(s0 & s3);
assign r_valid[1] = |(s0 & {s3[DEPTH - 2:0],s3[DEPTH - 1]});
assign w_ready[0] = |(~s0 & s4);
assign w_ready[1] = |(~s0 & {s4[DEPTH - 2:0],s4[DEPTH - 1]});
assign s2 = flush | s8 | s7;
assign s1 = (s0 | s9 | s10) & ~s11 & ~{DEPTH{flush}};
assign s9 = ({DEPTH{w_valid[0] & w_ready[0]}} & s4);
assign s10 = ({DEPTH{w_valid[1] & w_ready[1]}} & {s4[DEPTH - 2:0],s4[DEPTH - 1]});
assign s11 = ({DEPTH{r_valid[0] & r_ready[0]}} & s3) | ({DEPTH{r_valid[1] & r_ready[1]}} & {s3[DEPTH - 2:0],s3[DEPTH - 1]});
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s0 <= {DEPTH{1'b0}};
    end
    else if (s2) begin
        s0 <= s1;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s4 <= {{(DEPTH - 1){1'b0}},1'b1};
    end
    else if (s8) begin
        s4 <= s6;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s3 <= {{(DEPTH - 1){1'b0}},1'b1};
    end
    else if (s7) begin
        s3 <= s5;
    end
end

assign s13 = ({DW{s9[0]}} & w_data0) | ({DW{s10[0]}} & w_data1);
assign s15 = ({DW{s9[1]}} & w_data0) | ({DW{s10[1]}} & w_data1);
assign s17 = ({DW{s9[2]}} & w_data0) | ({DW{s10[2]}} & w_data1);
assign s19 = ({DW{s9[3]}} & w_data0) | ({DW{s10[3]}} & w_data1);
always @(posedge core_clk) begin
    if (s9[0] | s10[0]) begin
        s12 <= s13;
    end
end

always @(posedge core_clk) begin
    if (s9[1] | s10[1]) begin
        s14 <= s15;
    end
end

always @(posedge core_clk) begin
    if (s9[2] | s10[2]) begin
        s16 <= s17;
    end
end

always @(posedge core_clk) begin
    if (s9[3] | s10[3]) begin
        s18 <= s19;
    end
end

assign r_data0 = ({DW{s3[0]}} & s12) | ({DW{s3[1]}} & s14) | ({DW{s3[2]}} & s16) | ({DW{s3[3]}} & s18);
assign r_data1 = ({DW{s3[0]}} & s14) | ({DW{s3[1]}} & s16) | ({DW{s3[2]}} & s18) | ({DW{s3[3]}} & s12);
endmodule

