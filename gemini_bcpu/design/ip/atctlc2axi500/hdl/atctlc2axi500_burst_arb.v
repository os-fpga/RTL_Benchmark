// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atctlc2axi500_burst_arb (
    	  clk,
    	  resetn,
    	  valids,
    	  readys,
    	  lasts,
    	  grants,
    	  valid,
    	  ready
);
parameter N = 2;

input          clk;
input          resetn;
input  [N-1:0] valids;
output [N-1:0] readys;
input  [N-1:0] lasts;
output [N-1:0] grants;
output         valid;
input          ready;

reg  [N-1:0] s0;
reg  [N-1:0] s1;
wire         s2;
wire [N-1:0] s3;
wire [N-1:0] s4;
wire         s5;

integer s6;

assign s5 = |(grants & lasts);
assign grants = s4 & s0;

assign s2 = valid & ready;
assign s3 = grants | {N{s5}};

always @(posedge clk or negedge resetn) begin
    if(!resetn)begin
        s1 <= {N{1'b1}};
    end
    else if(s2)begin
        s1 <= s3;
    end
end

assign s4 = valids & s1;
assign valid  = |s4;

always @* begin
    s0[0] = 1'b1;
    for (s6=1; s6<N; s6=s6+1) begin
        s0[s6] = s0[s6-1] & ~s4[s6-1];
    end
end
assign readys = s0 & {N{ready}} & s1;



endmodule

