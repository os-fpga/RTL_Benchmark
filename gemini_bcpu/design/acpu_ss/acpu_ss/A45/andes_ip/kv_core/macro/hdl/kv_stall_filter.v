// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_stall_filter (
    clk,
    reset_n,
    valid_pre,
    stall,
    valid
);
input clk;
input reset_n;
input valid_pre;
input stall;
output valid;


reg s0;
wire s1;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        s0 <= 1'b0;
    end
    else begin
        s0 <= s1;
    end
end

assign s1 = stall & (s0 | valid);
assign valid = valid_pre & ~s0;
endmodule

