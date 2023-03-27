// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atctlc2axi500_elastic_buffer_o (
    	  clk,
    	  resetn,
    	  clk_en,
    	  i_valid,
    	  i_ready,
    	  din,
    	  o_valid,
    	  o_ready,
    	  dout
);

parameter DW = 32;

input            clk;
input            resetn;
input            clk_en;
input            i_valid;
output           i_ready;
input   [DW-1:0] din;
output           o_valid;
input            o_ready;
output  [DW-1:0] dout;

wire             s0;
wire             s1;
wire    [DW-1:0] s2;
wire             s3;
wire             s4;
wire    [DW-1:0] s5;
reg     [DW-1:0] s6;
wire             s7;
wire    [DW-1:0] s8;
reg              s9;
wire             s10;
wire             s11;
wire             s12;

wire             s13;
wire             s14;
wire    [DW-1:0] s15;
wire             s16;
wire             s17;
wire    [DW-1:0] s18;
reg     [DW-1:0] s19;
wire             s20;
wire    [DW-1:0] s21;
reg              s22;
wire             s23;

assign s3 = s9;
assign s1 = (~s9 | s4);
assign s5    = s6;

assign s11 = clk_en & s0;
assign s12 = clk_en & s4;
assign s10 = (s9 & ~s12) | s11;
always @(posedge clk or negedge resetn)begin
    if(!resetn)begin
        s9 <= 1'b0;
    end
    else begin
        s9 <= s10;
    end
end

assign s7 = s0 & s1 & clk_en;
assign s8 = s2;
always @(posedge clk) begin
    if(s7) begin
        s6 <= s8;
    end
end

assign s16 = s22 | s13;
assign s14 = ~s22;
assign s18    = s22 ? s19 : s15;

assign s23 = (s22 | s13) & ~s17;
always @(posedge clk or negedge resetn)begin
    if(!resetn)begin
        s22 <= 1'b0;
    end
    else begin
        s22 <= s23;
    end
end

assign s20 = s13 & s14 & ~s17;
assign s21 = s18;
always @(posedge clk) begin
    if(s20) begin
        s19 <= s21;
    end
end

assign s13 = i_valid;
assign i_ready = s14;
assign s15 = din;

assign s0 = s16;
assign s17 = s1 & clk_en;
assign s2 = s18;

assign o_valid = s3;
assign s4 = o_ready;
assign dout = s5;


endmodule

