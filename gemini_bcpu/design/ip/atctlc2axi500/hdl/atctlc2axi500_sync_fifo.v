// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atctlc2axi500_sync_fifo (
        	  clk,
        	  reset_n,
        	  wdata,
        	  wvalid,
        	  wready,
        	  rdata,
        	  rvalid,
        	  rready
);

parameter DEPTH = 4;
parameter WIDTH = 8;
input                       clk;
input                       reset_n;
input           [WIDTH-1:0] wdata;
input                       wvalid;
output                      wready;
output          [WIDTH-1:0] rdata;
output                      rvalid;
input                       rready;

reg             [DEPTH-1:0] s0;
wire            [DEPTH-1:0] s1;
wire                        s2;
reg             [DEPTH-1:0] s3;
reg             [DEPTH-1:0] s4;
wire            [DEPTH-1:0] s5;
wire            [DEPTH-1:0] s6;
wire                        s7;
wire                        s8;

reg             [WIDTH-1:0] s9[0:DEPTH-1];
wire            [DEPTH-1:0] s10;
wire                        s11;
wire                        s12;

reg             [WIDTH-1:0] rdata;
integer                     s13;

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		s0 <= {DEPTH{1'b0}};
	else if (s2)
		s0 <= s1;
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		s4 <= {{(DEPTH-1){1'b0}}, 1'b1};
	else if (s7)
		s4 <= s6;
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		s3 <= {{(DEPTH-1){1'b0}}, 1'b1};
	else if (s8)
		s3 <= s5;
end

assign s11 = rvalid & rready;
assign s12 = wvalid & wready;

assign s2  = s11 ^ s12;
assign s1  = s11 ? {1'b0, s0[DEPTH-1:1]} :
		         {s0[DEPTH-2:0], 1'b1};

assign s7 = s11;
assign s8 = s12;

assign s6 = {s4[DEPTH-2:0], s4[DEPTH-1]};
assign s5 = {s3[DEPTH-2:0], s3[DEPTH-1]};

assign wready = ~s0[DEPTH-1];
assign rvalid =  s0[0];

assign s10 = s3 & {DEPTH{s12}};

generate
genvar i;
for (i=0; i<DEPTH; i=i+1) begin : gen_mem
	always @(posedge clk) begin
		if (s10[i])
			s9[i] <= wdata;
	end
end
endgenerate

always @* begin
	rdata = {WIDTH{1'b0}};
	for (s13=0; s13<DEPTH; s13=s13+1) begin
		rdata = rdata | ({WIDTH{s4[s13]}} & s9[s13]);
	end
end

endmodule
