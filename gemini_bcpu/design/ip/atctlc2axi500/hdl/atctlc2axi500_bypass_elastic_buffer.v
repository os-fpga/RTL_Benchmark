// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atctlc2axi500_bypass_elastic_buffer (
    	  clk,
    	  resetn,
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
input            i_valid;
output           i_ready;
input   [DW-1:0] din;
output           o_valid;
input            o_ready;
output  [DW-1:0] dout;

reg     [DW-1:0] s0;
wire             s1;
wire    [DW-1:0] s2;

reg              s3;
wire             s4;

assign o_valid = s3 | i_valid;
assign i_ready = ~s3;
assign dout    = s3 ? s0 : din;

assign s4 = (s3 | i_valid) & ~o_ready;
always @(posedge clk or negedge resetn)begin
    if(!resetn)begin
        s3 <= 1'b0;
    end
    else begin
        s3 <= s4;
    end
end

assign s1 = i_valid & i_ready & ~o_ready;
assign s2 = din;
always @(posedge clk) begin
    if(s1) begin
        s0 <= s2;
    end
end

endmodule

