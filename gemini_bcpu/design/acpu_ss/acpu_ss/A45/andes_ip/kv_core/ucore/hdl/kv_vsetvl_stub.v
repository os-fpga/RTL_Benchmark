// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_vsetvl_stub (
    op0,
    op1,
    vtype,
    result
);
parameter VLEN = 512;
localparam ELEN = 64;
localparam VSEW_MAX = ($clog2(ELEN / 8));
input [31:0] op0;
input [31:0] op1;
output [8:0] vtype;
output [31:0] result;


wire [31:0] nds_unused_op0 = op0;
wire [31:0] nds_unused_op1 = op1;
assign vtype = 9'b0;
assign result = {32{1'b0}};
endmodule

