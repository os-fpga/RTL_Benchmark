// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_sb_cmp (
    cmp_addr,
    ent_addr,
    match_line,
    match_beat,
    match_xlen
);
parameter PALEN = 32;
localparam IDX_LSB = 6;
localparam GRN_LSB = 2;
input [PALEN - 1:0] cmp_addr;
input [PALEN - 1:0] ent_addr;
output match_line;
output match_beat;
output match_xlen;


assign match_line = (cmp_addr[PALEN - 1:IDX_LSB] == ent_addr[PALEN - 1:IDX_LSB]);
assign match_beat = match_line & (cmp_addr[IDX_LSB - 1:GRN_LSB + 2] == ent_addr[IDX_LSB - 1:GRN_LSB + 2]);
assign match_xlen = match_beat & (cmp_addr[GRN_LSB +:2] == ent_addr[GRN_LSB +:2]);
endmodule

