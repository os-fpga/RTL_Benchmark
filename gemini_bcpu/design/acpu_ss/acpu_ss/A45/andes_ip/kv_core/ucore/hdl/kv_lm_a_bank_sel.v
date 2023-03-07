// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lm_a_bank_sel (
    core_clk,
    core_reset_n,
    us_bank_sel,
    us_a_valid,
    us_a_stall,
    us_a_ready,
    us_a_addr,
    us_a_func,
    us_a_user,
    ds0_a_valid,
    ds0_a_ready,
    ds0_a_addr,
    ds0_a_func,
    ds0_a_user,
    ds0_a_stall,
    ds1_a_valid,
    ds1_a_ready,
    ds1_a_addr,
    ds1_a_func,
    ds1_a_user,
    ds1_a_stall,
    ds2_a_valid,
    ds2_a_ready,
    ds2_a_addr,
    ds2_a_func,
    ds2_a_user,
    ds2_a_stall,
    ds3_a_valid,
    ds3_a_ready,
    ds3_a_addr,
    ds3_a_func,
    ds3_a_user,
    ds3_a_stall
);
parameter BANKS = 1;
parameter AW = 12;
parameter DW = 32;
parameter UW = 3;
input core_clk;
input core_reset_n;
input [1:0] us_bank_sel;
input us_a_valid;
input us_a_stall;
output us_a_ready;
input [2:0] us_a_func;
input [AW - 1:0] us_a_addr;
input [UW - 1:0] us_a_user;
output ds0_a_valid;
input ds0_a_ready;
output [2:0] ds0_a_func;
output [AW - 1:0] ds0_a_addr;
output [UW - 1:0] ds0_a_user;
output ds0_a_stall;
output ds1_a_valid;
input ds1_a_ready;
output [2:0] ds1_a_func;
output [AW - 1:0] ds1_a_addr;
output [UW - 1:0] ds1_a_user;
output ds1_a_stall;
output ds2_a_valid;
input ds2_a_ready;
output [2:0] ds2_a_func;
output [AW - 1:0] ds2_a_addr;
output [UW - 1:0] ds2_a_user;
output ds2_a_stall;
output ds3_a_valid;
input ds3_a_ready;
output [2:0] ds3_a_func;
output [AW - 1:0] ds3_a_addr;
output [UW - 1:0] ds3_a_user;
output ds3_a_stall;


generate
    if (BANKS == 1) begin:gen_one_bank_sel
        assign us_a_ready = ds0_a_ready;
        assign ds0_a_valid = us_a_valid;
        assign ds0_a_func = us_a_func;
        assign ds0_a_addr = us_a_addr;
        assign ds0_a_user = us_a_user;
        assign ds0_a_stall = us_a_stall;
        assign ds1_a_valid = 1'b0;
        assign ds1_a_func = {3{1'b0}};
        assign ds1_a_addr = {AW{1'b0}};
        assign ds1_a_user = {UW{1'b0}};
        assign ds1_a_stall = 1'b0;
        assign ds2_a_valid = 1'b0;
        assign ds2_a_func = {3{1'b0}};
        assign ds2_a_addr = {AW{1'b0}};
        assign ds2_a_user = {UW{1'b0}};
        assign ds2_a_stall = 1'b0;
        assign ds3_a_valid = 1'b0;
        assign ds3_a_func = {3{1'b0}};
        assign ds3_a_addr = {AW{1'b0}};
        assign ds3_a_user = {UW{1'b0}};
        assign ds3_a_stall = 1'b0;
    end
    else begin:gen_multi_bank_sel
        reg s0;
        wire s1;
        wire s2;
        wire s3;
        reg [AW - 1:0] s4;
        reg [UW - 1:0] s5;
        reg [2:0] s6;
        reg s7;
        reg [1:0] s8;
        wire s9 = (s8 == 2'b00);
        wire s10 = (s8 == 2'b01);
        wire s11 = (s8 == 2'b10);
        wire s12 = (s8 == 2'b11);
        assign s1 = (us_a_valid & ~us_a_stall & (us_bank_sel == 2'b00) & ~ds0_a_ready & ~s0) | (us_a_valid & ~us_a_stall & (us_bank_sel == 2'b01) & ~ds1_a_ready & ~s0) | (us_a_valid & ~us_a_stall & (us_bank_sel == 2'b10) & ~ds2_a_ready & ~s0) | (us_a_valid & ~us_a_stall & (us_bank_sel == 2'b11) & ~ds3_a_ready & ~s0);
        assign s2 = ((s8 == 2'b00) & s0 & ds0_a_ready) | ((s8 == 2'b01) & s0 & ds1_a_ready) | ((s8 == 2'b10) & s0 & ds2_a_ready) | ((s8 == 2'b11) & s0 & ds3_a_ready);
        assign s3 = (s0 | s1) & ~s2;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s0 <= 1'b0;
            end
            else begin
                s0 <= s3;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s4 <= {AW{1'b0}};
                s5 <= {UW{1'b0}};
                s6 <= {3{1'b0}};
                s7 <= 1'b0;
                s8 <= 2'b0;
            end
            else if (s1) begin
                s4 <= us_a_addr;
                s5 <= us_a_user;
                s6 <= us_a_func;
                s7 <= us_a_stall;
                s8 <= us_bank_sel;
            end
        end

        assign us_a_ready = ~s0;
        assign ds0_a_valid = s0 ? s9 : us_a_valid;
        assign ds1_a_valid = s0 ? s10 : us_a_valid;
        assign ds2_a_valid = (BANKS == 2) ? 1'b0 : s0 ? s11 : us_a_valid;
        assign ds3_a_valid = (BANKS == 2) ? 1'b0 : s0 ? s12 : us_a_valid;
        assign ds0_a_stall = s0 ? s7 : ((us_bank_sel != 2'b00) | us_a_stall);
        assign ds1_a_stall = s0 ? s7 : ((us_bank_sel != 2'b01) | us_a_stall);
        assign ds2_a_stall = (BANKS == 2) ? 1'b0 : s0 ? s7 : ((us_bank_sel != 2'b10) | us_a_stall);
        assign ds3_a_stall = (BANKS == 2) ? 1'b0 : s0 ? s7 : ((us_bank_sel != 2'b11) | us_a_stall);
        assign ds0_a_addr = s0 ? s4 : us_a_addr;
        assign ds1_a_addr = s0 ? s4 : us_a_addr;
        assign ds2_a_addr = (BANKS == 2) ? {AW{1'b0}} : s0 ? s4 : us_a_addr;
        assign ds3_a_addr = (BANKS == 2) ? {AW{1'b0}} : s0 ? s4 : us_a_addr;
        assign ds0_a_user = s0 ? s5 : us_a_user;
        assign ds1_a_user = s0 ? s5 : us_a_user;
        assign ds2_a_user = (BANKS == 2) ? {UW{1'b0}} : s0 ? s5 : us_a_user;
        assign ds3_a_user = (BANKS == 2) ? {UW{1'b0}} : s0 ? s5 : us_a_user;
        assign ds0_a_func = s0 ? s6 : us_a_func;
        assign ds1_a_func = s0 ? s6 : us_a_func;
        assign ds2_a_func = (BANKS == 2) ? {3{1'b0}} : s0 ? s6 : us_a_func;
        assign ds3_a_func = (BANKS == 2) ? {3{1'b0}} : s0 ? s6 : us_a_func;
    end
endgenerate
endmodule

