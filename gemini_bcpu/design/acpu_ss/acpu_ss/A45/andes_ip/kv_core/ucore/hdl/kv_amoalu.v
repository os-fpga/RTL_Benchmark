// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_amoalu (
    op0,
    op1,
    func3,
    func5,
    result
);
input [31:0] op0;
input [31:0] op1;
input [2:0] func3;
input [4:0] func5;
output [31:0] result;


wire s0 = func5 == 5'b00000;
wire s1 = func5 == 5'b00001;
wire s2 = func5 == 5'b00100;
wire s3 = func5 == 5'b01100;
wire s4 = func5 == 5'b01000;
wire s5 = func5[4];
wire s6 = func5[2];
wire s7 = ~func5[3];
wire [31:0] s8 = op0 + op1;
wire [31:0] s9 = op1;
wire [31:0] s10 = op0 ^ op1;
wire [31:0] s11 = op0 & op1;
wire [31:0] s12 = op0 | op1;
wire [31:0] s13;
wire [31:0] s14;
wire [31:0] s15;
assign s14[31:0] = op0[31:0];
assign s15[31:0] = op1[31:0];
wire [2:0] nds_unused_func3 = func3;
kv_minmax #(
    .WIDTH(32)
) u_minmax_result (
    .a(s14),
    .b(s15),
    .tc(s7),
    .min_max(s6),
    .result(s13)
);
assign result = ({32{s0}} & s8) | ({32{s1}} & s9) | ({32{s2}} & s10) | ({32{s3}} & s11) | ({32{s4}} & s12) | ({32{s5}} & s13);
endmodule

