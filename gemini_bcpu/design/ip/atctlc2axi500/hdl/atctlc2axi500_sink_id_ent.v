// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atctlc2axi500_sink_id_ent(
    	  clk,
    	  resetn,
    	  enq_valid,
    	  rsp_valid,
    	  deq_valid,
    	  valid
);

input                   clk;
input                   resetn;
input                   enq_valid;
input                   rsp_valid;
input                   deq_valid;

output                  valid;

reg                 s0;
wire                s1;
wire                s2;

reg                 s3;
wire                s4;
wire                s5;

reg                 valid;
wire                s6;
wire                s7;
wire                s8;
wire                s9;

assign s7  = s8 | s9;
assign s8 = enq_valid;
assign s9 = rsp_valid & valid & s3
                 | deq_valid & valid & s0
                 | rsp_valid & deq_valid
                 ;
assign s6 = (valid | s8) & ~s9;
always @(posedge clk or negedge resetn)begin
    if(!resetn)begin
        valid <= 1'b0;
    end
    else if(s7)begin
        valid <= s6;
    end
end

assign s5 = enq_valid | deq_valid;
assign s4 = (s3 & ~enq_valid) | deq_valid;
always @(posedge clk)begin
    if(s5)begin
        s3 <= s4;
    end
end

assign s2 = enq_valid | rsp_valid;
assign s1 = (s0 & ~enq_valid) | rsp_valid;
always @(posedge clk)begin
    if(s2)begin
        s0 <= s1;
    end
end

endmodule
