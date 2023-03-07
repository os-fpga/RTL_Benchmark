// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_st_mask (
    addr,
    size,
    mask
);
output [3:0] mask;
input [2:0] addr;
input [1:0] size;


wire s0 = 1'b0;
wire [7:0] s1;
wire [3:0] s2;
wire [7:0] s3;
wire [7:0] s4;
wire [7:0] s5;
wire [7:0] s6;
wire [7:0] s7;
assign s1[0] = (addr[1:0] == 2'd0) & ~(s0 & addr[2]);
assign s1[1] = (addr[1:0] == 2'd1) & ~(s0 & addr[2]);
assign s1[2] = (addr[1:0] == 2'd2) & ~(s0 & addr[2]);
assign s1[3] = (addr[1:0] == 2'd3) & ~(s0 & addr[2]);
assign s1[4] = (addr[1:0] == 2'd0) & (s0 & addr[2]);
assign s1[5] = (addr[1:0] == 2'd1) & (s0 & addr[2]);
assign s1[6] = (addr[1:0] == 2'd2) & (s0 & addr[2]);
assign s1[7] = (addr[1:0] == 2'd3) & (s0 & addr[2]);
assign s2[0] = (size == 2'd0);
assign s2[1] = (size == 2'd1);
assign s2[2] = (size == 2'd2);
assign s2[3] = (size == 2'd3) & s0;
assign {s6,s5,s4,s3} = ({32{s1[0]}} & {8'hff,8'h0f,8'h03,8'h01}) | ({32{s1[1]}} & {8'hff,8'h1e,8'h06,8'h02}) | ({32{s1[2]}} & {8'hff,8'h3c,8'h0c,8'h04}) | ({32{s1[3]}} & {8'hff,8'h78,8'h18,8'h08}) | ({32{s1[4]}} & {8'hff,8'hf0,8'h30,8'h10}) | ({32{s1[5]}} & {8'hff,8'he1,8'h60,8'h20}) | ({32{s1[6]}} & {8'hff,8'hc3,8'hc0,8'h40}) | ({32{s1[7]}} & {8'hff,8'h87,8'h81,8'h80});
assign s7 = ({8{s2[0]}} & s3) | ({8{s2[1]}} & s4) | ({8{s2[2]}} & s5) | ({8{s2[3]}} & s6);
assign mask = s7[3:0];
endmodule

