// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_rr (
    dcu_clk,
    dcu_reset_n,
    lru_cmt_valid,
    lru_ack_rdata
);
parameter DCACHE_WAY = 2;
input dcu_clk;
input dcu_reset_n;
input lru_cmt_valid;
output [2:0] lru_ack_rdata;


reg [2:0] s0;
wire [2:0] s1;
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        s0 <= 3'b000;
    end
    else if (lru_cmt_valid) begin
        s0 <= s1;
    end
end

assign lru_ack_rdata = s0;
generate
    if (DCACHE_WAY == 4) begin:gen_rr_way4
        assign s1[0] = ~s0[2] ^ s0[0];
        assign s1[1] = s0[2] ^ s0[1];
        assign s1[2] = s0[2] ^ (|s0[1:0]);
    end
    else if (DCACHE_WAY == 2) begin:gen_rr_way2
        assign s1[0] = ~s0[0];
        assign s1[2:1] = 2'b00;
    end
    else begin:gen_rr_way1
        assign s1 = 3'b000;
    end
endgenerate
endmodule

