// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_uins_dec (
    id_instr,
    instr_csrwi,
    uins_instr,
    id_dec_ctrl,
    instr_index
);
input [31:0] id_instr;
input [43:0] id_dec_ctrl;
output instr_csrwi;
output uins_instr;
output [7:0] instr_index;
localparam OP_SYSTEM = 7'b1110011;
localparam CSR12_MCCTLCOMMAND = 12'h7cc;
localparam CSR12_UCCTLCOMMAND = 12'h80c;
localparam PP16_SUPPORT = 1'b0;
localparam PP32_SUPPORT = 1'b0;


wire s0 = id_dec_ctrl[5] & ~(&id_instr[1:0]);
wire s1;
wire [11:0] s2;
wire s3;
wire s4;
wire s5;
assign s2 = id_instr[31:20];
assign s3 = (id_instr[6:0] == OP_SYSTEM) & (id_instr[14:12] == 3'b001);
assign instr_csrwi = (id_instr[6:0] == OP_SYSTEM) & (id_instr[14:12] == 3'b101);
assign s5 = (s3 | instr_csrwi) & s4;
assign s4 = (s2[11:0] == CSR12_MCCTLCOMMAND) | (s2[11:0] == CSR12_UCCTLCOMMAND);
assign s1 = id_dec_ctrl[43] & ~s5;
wire s6;
assign s6 = (id_instr[15:13] == 3'b100) & (id_instr[12:10] == 3'b100) & (id_instr[6:5] != 2'b11) & (id_instr[1:0] == 2'b00) & PP16_SUPPORT;
assign uins_instr = |instr_index;
assign instr_index = {s5,(s1 & ~s0 & ~s6),(s6 & ~s0),1'b0,1'b0,1'b0,1'b0,1'b0};
endmodule

