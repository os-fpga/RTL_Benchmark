// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_sync_l2l (
    resetn,
    clk,
    d,
    q
);
parameter SYNC_STAGE = 2;
parameter RESET_VALUE = 1'b0;
input resetn;
input clk;
input d;
output q;


reg [SYNC_STAGE - 1:0] s0;
assign q = s0[SYNC_STAGE - 1];
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        s0 <= {SYNC_STAGE{RESET_VALUE}};
    end
    else begin
        s0 <= {s0[SYNC_STAGE - 2:0],d};
    end
end

endmodule

