// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary




module atcsizedn500_mux_onehot (
        	  out,
        	  sel,
        	  in
);
parameter N = 2;
parameter W = 8;
output          [W-1:0] out;
input           [N-1:0] sel;
input       [(N*W)-1:0] in;

wire        [(N*W)-1:0] s0;

assign s0[W-1:0] = {W{sel[0]}} & in[W-1:0];

generate
genvar i;
for (i=1; i<N; i=i+1) begin : gen_tmp
	assign s0[i*W+:W] = s0[(i-1)*W+:W] | ({W{sel[i]}} & in[i*W+:W]);
end
endgenerate

assign out = s0[(N-1)*W+:W];


endmodule

