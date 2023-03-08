// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module atctlc2axi500_arb_fp (
        	  valids,
        	  readys,
        	  grants,
        	  ready,
        	  valid
);
parameter N = 8;
input		[N-1:0]	valids;
output		[N-1:0]	readys;
output		[N-1:0]	grants;
input                   ready;
output                  valid;


integer			s0;
reg		[N-1:0] s1;

always @* begin
	s1[0] = 1'b1;
	for (s0=1; s0<N; s0=s0+1) begin
		s1[s0] = s1[s0-1] & ~valids[s0-1];
	end
end

assign readys = s1 & {N{ready}};
assign grants = valids & s1;
assign valid = |valids;





endmodule

