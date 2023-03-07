// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fmt_load (
    addr_onehot,
    offset_onehot,
    mem_rdata,
    result_sel,
    bresult_sel,
    result,
    result2,
    bresult
);
input [7:0] addr_onehot;
input [7:1] offset_onehot;
input [31:0] mem_rdata;
input [5:0] result_sel;
input [4:0] bresult_sel;
output [31:0] result;
output [63:0] result2;
output [31:0] bresult;


wire s0 = 1'b0;
wire [31:0] s1;
wire [63:0] s2;
assign s1 = ({32{addr_onehot[0]}} & {mem_rdata[0 +:32]}) | ({32{addr_onehot[1]}} & {8'd0,mem_rdata[8 +:24]}) | ({32{addr_onehot[2]}} & {16'd0,mem_rdata[16 +:16]}) | ({32{addr_onehot[3]}} & {24'd0,mem_rdata[24 +:8]});
assign bresult = mem_rdata;
assign result[7:0] = s1[7:0];
assign result[15:8] = ({8{result_sel[0]}} & s1[15:8]) | ({8{result_sel[3]}} & {8{s1[7]}});
assign result[31:16] = ({16{result_sel[1]}} & s1[31:16]) | ({16{result_sel[3]}} & {16{s1[7]}}) | ({16{result_sel[4]}} & {16{s1[15]}});
assign s2 = ({64{offset_onehot[1]}} & {24'd0,mem_rdata[31:0],8'd0}) | ({64{offset_onehot[2]}} & {16'd0,mem_rdata[31:0],16'd0}) | ({64{offset_onehot[3]}} & {8'd0,mem_rdata[31:0],24'd0}) | ({64{offset_onehot[4]}} & {mem_rdata[31:0],32'd0}) | ({64{offset_onehot[5]}} & {mem_rdata[23:0],40'd0}) | ({64{offset_onehot[6]}} & {mem_rdata[15:0],48'd0}) | ({64{offset_onehot[7]}} & {mem_rdata[7:0],56'd0});
assign result2[7:0] = 8'd0;
assign result2[15:8] = s2[15:8];
assign result2[31:16] = ({16{result_sel[1]}} & s2[31:16]) | ({16{result_sel[4]}} & {16{s2[15]}});
assign result2[63:32] = ({32{result_sel[2]}} & s2[63:32]);
endmodule

