// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atctlc2axi500_elastic_buffer_i (
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

reg     [DW-1:0] s0;
wire    [DW-1:0] s1;
wire             s2;

reg              s3;
wire             s4;
wire             s5;
wire             s6;

reg              s7;
wire             s8;

reg     [DW-1:0] s9;
wire    [DW-1:0] s10;
wire             s11;

reg              s12;
wire             s13;
wire             s14;
wire             s15;

assign s5 = i_valid & i_ready & clk_en;
assign s6 = ~s12 | o_ready;
assign s4 = (s3 & ~s6) | s5;
always @(posedge clk or negedge resetn)begin
    if(!resetn)begin
        s3 <= 1'b0;
    end
    else begin
        s3 <= s4;
    end
end

assign s8 = clk_en ? (~s4 | ~s13) : s7;
always @(posedge clk or negedge resetn)begin
    if(!resetn)begin
        s7 <= 1'b1;
    end
    else begin
        s7 <= s8;
    end
end

assign s2 = i_valid & i_ready & clk_en;
assign s1 = din;
always @(posedge clk)begin
    if(s2)begin
        s0 <= s1;
    end
end

assign s14 = s3;
assign s15 = (s3 ^ s12) & o_ready;
assign s13 = (s12 | s14) & ~s15;
always @(posedge clk or negedge resetn)begin
    if(!resetn)begin
        s12 <= 1'b0;
    end
    else begin
        s12 <= s13;
    end
end

assign s11 = s3 & ~s12 & ~o_ready
             | s3 &  s12 &  o_ready
             ;
assign s10 = s0;
always @(posedge clk)begin
    if(s11)begin
        s9 <= s10;
    end
end

assign o_valid = s12 | s3;
assign i_ready = s7;
assign dout = s12 ? s9 : s0;



endmodule

