// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atcexmon300_lfsr (
		  resetn,
		  clk,
		  update,
        	  grant
);
parameter N = 8;
localparam W = $unsigned($clog2(N));

input		 resetn;
input		 clk;
input		 update;
output   [N-1:0] grant;

wire  	   [7:0] lfsr_cnt_nx;
reg 	   [7:0] lfsr_cnt;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		lfsr_cnt <= 8'h01;
	else if (update)
		lfsr_cnt <= lfsr_cnt_nx;
end

assign lfsr_cnt_nx[0] = lfsr_cnt[7] ^ lfsr_cnt[5] ^ lfsr_cnt[4] ^ lfsr_cnt[3];
assign lfsr_cnt_nx[1] = lfsr_cnt[0];
assign lfsr_cnt_nx[2] = lfsr_cnt[1];
assign lfsr_cnt_nx[3] = lfsr_cnt[2];
assign lfsr_cnt_nx[4] = lfsr_cnt[3];
assign lfsr_cnt_nx[5] = lfsr_cnt[4];
assign lfsr_cnt_nx[6] = lfsr_cnt[5];
assign lfsr_cnt_nx[7] = lfsr_cnt[6];

generate
if (N == 1) begin : gen_arb_one_bit
	assign grant = 1'b1;
end
else begin : gen_arb_multi_bit
	assign grant = ({{(N-1){1'b0}}, {1'b1}}) << lfsr_cnt[W-1:0];
end
endgenerate

endmodule


