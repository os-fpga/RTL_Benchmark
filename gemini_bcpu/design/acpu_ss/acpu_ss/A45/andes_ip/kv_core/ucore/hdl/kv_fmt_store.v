// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fmt_store (
    addr,
    offset,
    cmt_wdata,
    fmt_wdata
);
parameter FLEN = 64;
input [2:0] addr;
input [2:0] offset;
input [63:0] cmt_wdata;
output [31:0] fmt_wdata;


generate
    if (FLEN == 64) begin:gen_xlen32_flen64
        wire [7:0] s0;
        assign s0[0] = ((addr[1:0] == 2'd0) & (offset[2:0] == 3'd0));
        assign s0[1] = ((addr[1:0] == 2'd0) & (offset[2:0] == 3'd1)) | ((addr[1:0] == 2'd2) & (offset[2:0] == 3'd3));
        assign s0[2] = ((addr[1:0] == 2'd0) & (offset[2:0] == 3'd2));
        assign s0[3] = ((addr[1:0] == 2'd0) & (offset[2:0] == 3'd3));
        assign s0[4] = ((addr[1:0] == 2'd0) & (offset[2:0] == 3'd4));
        assign s0[5] = ((addr[1:0] == 2'd0) & (offset[2:0] == 3'd5)) | ((addr[1:0] == 2'd2) & (offset[2:0] == 3'd7)) | ((addr[1:0] == 2'd3) & (offset[2:0] == 3'd0));
        assign s0[6] = ((addr[1:0] == 2'd0) & (offset[2:0] == 3'd6)) | ((addr[1:0] == 2'd2) & (offset[2:0] == 3'd0));
        assign s0[7] = ((addr[1:0] == 2'd0) & (offset[2:0] == 3'd7)) | ((addr[1:0] == 2'd1) & (offset[2:0] == 3'd0)) | ((addr[1:0] == 2'd2) & (offset[2:0] == 3'd1));
        assign fmt_wdata = ({32{s0[0]}} & {cmt_wdata[0 +:32]}) | ({32{s0[1]}} & {cmt_wdata[8 +:32]}) | ({32{s0[2]}} & {cmt_wdata[16 +:32]}) | ({32{s0[3]}} & {cmt_wdata[24 +:32]}) | ({32{s0[4]}} & {cmt_wdata[32 +:32]}) | ({32{s0[5]}} & {cmt_wdata[0 +:8],cmt_wdata[40 +:24]}) | ({32{s0[6]}} & {cmt_wdata[0 +:16],cmt_wdata[48 +:16]}) | ({32{s0[7]}} & {cmt_wdata[0 +:24],cmt_wdata[56 +:8]});
    end
    else begin:gen_xlen32_flen32
        wire [2:0] s1 = addr[2:0] - offset[2:0];
        wire [3:0] s0;
        assign s0[0] = (s1[1:0] == 2'd0);
        assign s0[1] = (s1[1:0] == 2'd1);
        assign s0[2] = (s1[1:0] == 2'd2);
        assign s0[3] = (s1[1:0] == 2'd3);
        assign fmt_wdata = ({32{s0[0]}} & {cmt_wdata[0 +:32]}) | ({32{s0[1]}} & {cmt_wdata[0 +:24],cmt_wdata[24 +:8]}) | ({32{s0[2]}} & {cmt_wdata[0 +:16],cmt_wdata[16 +:16]}) | ({32{s0[3]}} & {cmt_wdata[0 +:8],cmt_wdata[8 +:24]});
    end
endgenerate
endmodule

