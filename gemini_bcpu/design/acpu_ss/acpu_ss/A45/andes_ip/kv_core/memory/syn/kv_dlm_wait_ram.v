// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_dlm_wait_ram (
    lm_clk,
    lm_reset_n,
    dlm_a_addr,
    dlm_a_data,
    dlm_a_mask,
    dlm_a_opcode,
    dlm_a_size,
    dlm_a_user,
    dlm_a_valid,
    dlm_a_parity,
    dlm_a_ready,
    dlm_d_data,
    dlm_d_denied,
    dlm_d_ready,
    dlm_d_parity,
    dlm_d_valid);

    parameter DLM_RAM_AMSB= 11;
    parameter DLM_RAM_DW= 64;
    parameter DLM_RAM_BWEW= 8;
    parameter XLEN= 64;
    localparam DLM_RAM_ALSB= (XLEN==64)? 3: (XLEN==32)? 2: 1;
    localparam DLM_RAM_AW= DLM_RAM_AMSB-DLM_RAM_ALSB+1;
    localparam OUT_DELAY= 0.1;
    input lm_clk;
    input lm_reset_n;
    input [DLM_RAM_AMSB:DLM_RAM_ALSB] dlm_a_addr ;
    input [XLEN-1:0] dlm_a_data ;
    input [DLM_RAM_BWEW-1:0] dlm_a_mask ;
    input [2:0] dlm_a_opcode ;
    input [2:0] dlm_a_size ;
    input [1:0] dlm_a_user ;
    input dlm_a_valid;
    input [7:0] dlm_a_parity ;
    output dlm_a_ready;
    output [XLEN-1:0] dlm_d_data ;
    output dlm_d_denied;
    input dlm_d_ready;
    output [7:0] dlm_d_parity ;
    output dlm_d_valid;
wire nds_unused_lm_clk = lm_clk;
wire nds_unused_lm_reset_n = lm_reset_n;
wire [DLM_RAM_AMSB:DLM_RAM_ALSB] nds_unused_dlm_a_addr = dlm_a_addr;
wire [XLEN-1:0] nds_unused_dlm_a_data = dlm_a_data;
wire [DLM_RAM_BWEW-1:0] nds_unused_dlm_a_mask = dlm_a_mask;
wire [2:0] nds_unused_dlm_a_opcode = dlm_a_opcode;
wire [2:0] nds_unused_dlm_a_size = dlm_a_size;
wire [1:0] nds_unused_dlm_a_user = dlm_a_user;
wire nds_unused_dlm_a_valid = dlm_a_valid;
wire [7:0] nds_unused_dlm_a_parity = dlm_a_parity;
assign dlm_a_ready = 1'b0;
assign dlm_d_data = {XLEN{1'b0}};
assign dlm_d_denied = 1'b0;
wire nds_unused_dlm_d_ready = dlm_d_ready;
assign dlm_d_parity = 8'b0;
assign dlm_d_valid = 1'b0;

endmodule 