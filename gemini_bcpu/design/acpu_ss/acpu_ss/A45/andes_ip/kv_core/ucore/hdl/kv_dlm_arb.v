// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dlm_arb (
    lm_clk,
    lm_reset_n,
    lsu_dlm_a_valid,
    lsu_dlm_a_stall,
    lsu_dlm_a_addr,
    lsu_dlm_a_func,
    lsu_dlm_a_user,
    lsu_dlm_a_ready,
    lsu_dlm_w_valid,
    lsu_dlm_w_data,
    lsu_dlm_w_mask,
    lsu_dlm_w_status,
    lsu_dlm_w_ready,
    lsu_dlm_d_valid,
    lsu_dlm_d_data,
    lsu_dlm_d_status,
    lsu_dlm_d_user,
    slv_dlm_a_valid,
    slv_dlm_a_stall,
    slv_dlm_a_addr,
    slv_dlm_a_func,
    slv_dlm_a_user,
    slv_dlm_a_ready,
    slv_dlm_w_valid,
    slv_dlm_w_data,
    slv_dlm_w_mask,
    slv_dlm_w_ready,
    slv_dlm_d_valid,
    slv_dlm_d_data,
    slv_dlm_d_status,
    slv_dlm_d_user,
    dlm0_a_valid,
    dlm0_a_stall,
    dlm0_a_addr,
    dlm0_a_func,
    dlm0_a_user,
    dlm0_a_source,
    dlm0_a_ready,
    dlm0_w_valid,
    dlm0_w_data,
    dlm0_w_mask,
    dlm0_w_ready,
    dlm0_d_valid,
    dlm0_d_data,
    dlm0_d_status,
    dlm0_d_user
);
parameter RAM_DW = 32;
parameter ECC_TYPE_INT = 0;
parameter UW = 1;
parameter DLM_BANKS = 1;
parameter DLM_SIZE_KB = 0;
parameter DLM_RAM_AW = 11;
parameter DLM_RAM_BWEW = 8;
parameter DLM_RAM_DW = 72;
parameter DLM_AMSB = DLM_RAM_AW + 1;
parameter DLM_ALSB = (DLM_BANKS == 1) ? 2 : (DLM_BANKS == 2) ? 3 : 4;
parameter SOURCE_BITS = 4;
localparam ARB_SLV = 0;
localparam ARB_LSU = 1;
localparam ARB_BITS = 2;
input lm_clk;
input lm_reset_n;
input lsu_dlm_a_valid;
input lsu_dlm_a_stall;
input [DLM_AMSB:0] lsu_dlm_a_addr;
input [2:0] lsu_dlm_a_func;
input [UW - 1:0] lsu_dlm_a_user;
output lsu_dlm_a_ready;
input lsu_dlm_w_valid;
input [31:0] lsu_dlm_w_data;
input [3:0] lsu_dlm_w_mask;
output lsu_dlm_w_status;
output lsu_dlm_w_ready;
output lsu_dlm_d_valid;
output [31:0] lsu_dlm_d_data;
output [13:0] lsu_dlm_d_status;
output [UW - 1:0] lsu_dlm_d_user;
input slv_dlm_a_valid;
input slv_dlm_a_stall;
input [DLM_AMSB:0] slv_dlm_a_addr;
input [2:0] slv_dlm_a_func;
input [UW - 1:0] slv_dlm_a_user;
output slv_dlm_a_ready;
input slv_dlm_w_valid;
input [31:0] slv_dlm_w_data;
input [3:0] slv_dlm_w_mask;
output slv_dlm_w_ready;
output slv_dlm_d_valid;
output [31:0] slv_dlm_d_data;
output [13:0] slv_dlm_d_status;
output [UW - 1:0] slv_dlm_d_user;
output dlm0_a_valid;
output dlm0_a_stall;
output [DLM_RAM_AW - 1:0] dlm0_a_addr;
output [2:0] dlm0_a_func;
output [UW + 1:0] dlm0_a_user;
output [SOURCE_BITS - 1:0] dlm0_a_source;
input dlm0_a_ready;
output dlm0_w_valid;
output [31:0] dlm0_w_data;
output [3:0] dlm0_w_mask;
input dlm0_w_ready;
input dlm0_d_valid;
input [31:0] dlm0_d_data;
input [13:0] dlm0_d_status;
input [UW + 1:0] dlm0_d_user;


wire [ARB_BITS - 1:0] s0;
wire [ARB_BITS - 1:0] s1;
wire [ARB_BITS - 1:0] s2;
wire [ARB_BITS - 1:0] s3;
wire [ARB_BITS - 1:0] s4;
wire s5;
wire [ARB_BITS - 1:0] s6;
wire s7;
wire s8;
wire s9;
wire [DLM_RAM_AW - 1:0] s10;
wire [2:0] s11;
wire [UW - 1:0] s12;
wire s13;
wire [DLM_RAM_AW - 1:0] s14;
wire [2:0] s15;
wire [UW - 1:0] s16;
wire s17;
wire nds_unused_dlm0_a_wready;
wire [31:0] s18;
wire [3:0] s19;
wire [31:0] s20;
wire [3:0] s21;
wire s22;
reg s23;
wire s24;
wire s25;
wire s26;
wire s27;
wire s28;
wire [1:0] s29;
wire [1:0] s30;
wire s31;
wire s32;
kv_cnt_johnson #(
    .N(2)
) u_slv_ilm_inflight (
    .clk(lm_clk),
    .rst_n(lm_reset_n),
    .up(s28),
    .dn(slv_dlm_d_valid),
    .cnt(s29)
);
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        s23 <= 1'b0;
    end
    else if (s24) begin
        s23 <= s25;
    end
end

assign s28 = slv_dlm_a_valid & slv_dlm_a_ready & ~slv_dlm_a_stall;
assign s24 = s26 | s27;
assign s26 = (s5 & s3[ARB_LSU] & ~lsu_dlm_w_valid) & (slv_dlm_a_valid & ~slv_dlm_a_stall | s29[0]);
assign s27 = slv_dlm_d_valid;
assign s25 = ~s27 & (s23 | s26);
assign s0[ARB_LSU] = lsu_dlm_a_valid & ~s30[0];
assign s0[ARB_SLV] = slv_dlm_a_valid;
kv_arb_fp #(
    .N(ARB_BITS)
) u_arb0_a (
    .valid(s0),
    .ready(s1),
    .grant(s2)
);
kv_mux_onehot #(
    .N(ARB_BITS),
    .W(1 + DLM_RAM_AW + 3 + UW)
) u_dlm0_a (
    .out({dlm0_a_stall,dlm0_a_addr,dlm0_a_func,dlm0_a_user[UW - 1:0]}),
    .in({s9,s10,s11,s12,s13,s14,s15,s16}),
    .sel(s2)
);
assign s9 = lsu_dlm_a_stall;
assign s10 = lsu_dlm_a_addr[DLM_AMSB:DLM_ALSB];
assign s11 = lsu_dlm_a_func;
assign s12 = lsu_dlm_a_user;
assign s13 = slv_dlm_a_stall;
assign s14 = slv_dlm_a_addr[DLM_AMSB:DLM_ALSB];
assign s15 = slv_dlm_a_func;
assign s16 = slv_dlm_a_user;
assign lsu_dlm_a_ready = s1[ARB_LSU] & dlm0_a_ready & ~s30[0];
assign slv_dlm_a_ready = s1[ARB_SLV] & dlm0_a_ready;
assign dlm0_a_valid = |s0;
assign dlm0_a_user[UW + 1:UW] = s2;
assign dlm0_a_source = ({2{s2[ARB_SLV] & s16[0]}} & 2'b11) | ({2{s2[ARB_SLV] & ~s16[0]}} & 2'b10) | ({2{s2[ARB_LSU]}} & 2'b00);
kv_fifo #(
    .DEPTH(2),
    .WIDTH(ARB_BITS)
) u_m1_arb (
    .clk(lm_clk),
    .reset_n(lm_reset_n),
    .flush(1'b0),
    .wdata(s2),
    .wvalid(s17),
    .wready(nds_unused_dlm0_a_wready),
    .rdata(s6),
    .rvalid(s7),
    .rready(s8)
);
kv_fifo #(
    .DEPTH(2),
    .WIDTH(ARB_BITS)
) u_w_arb (
    .clk(lm_clk),
    .reset_n(lm_reset_n),
    .flush(1'b0),
    .wdata(s6),
    .wvalid(s7),
    .wready(s8),
    .rdata(s3),
    .rvalid(s5),
    .rready(s22)
);
assign s17 = dlm0_a_valid & dlm0_a_ready & dlm0_a_func[1] & ~dlm0_a_stall;
assign s22 = dlm0_w_valid & dlm0_w_ready;
kv_mux_onehot #(
    .N(2),
    .W(36)
) u_dlm0_w (
    .out({dlm0_w_data,dlm0_w_mask}),
    .in({s18,s19,s20,s21}),
    .sel(s3)
);
assign s19 = lsu_dlm_w_mask & {4{~s23}};
assign s18 = lsu_dlm_w_data;
assign s20 = slv_dlm_w_data;
assign s21 = slv_dlm_w_mask;
assign slv_dlm_w_ready = s5 & s3[ARB_SLV] & dlm0_w_ready;
assign dlm0_w_valid = (s5 & s3[ARB_LSU] & lsu_dlm_w_valid & ~lsu_dlm_w_status) | (s5 & s3[ARB_LSU] & s23) | (s5 & s3[ARB_SLV] & slv_dlm_w_valid);
kv_cnt_johnson #(
    .N(2)
) u_lsu_w_preempted_cnt (
    .clk(lm_clk),
    .rst_n(lm_reset_n),
    .up(s31),
    .dn(s32),
    .cnt(s30)
);
assign s31 = s22 & s3[ARB_LSU] & s23;
assign s32 = lsu_dlm_w_valid & lsu_dlm_w_ready & lsu_dlm_w_status;
assign lsu_dlm_w_ready = (s5 & s3[ARB_LSU] & dlm0_w_ready) | s30[0];
assign lsu_dlm_w_status = s23 | s30[0];
assign s4 = dlm0_d_user[UW + 1:UW];
assign slv_dlm_d_valid = dlm0_d_valid & s4[ARB_SLV];
assign lsu_dlm_d_valid = dlm0_d_valid & s4[ARB_LSU];
assign lsu_dlm_d_data = dlm0_d_data;
assign lsu_dlm_d_status = dlm0_d_status;
assign lsu_dlm_d_user = dlm0_d_user[UW - 1:0];
assign slv_dlm_d_data = dlm0_d_data;
assign slv_dlm_d_status = dlm0_d_status;
assign slv_dlm_d_user = dlm0_d_user[UW - 1:0];
endmodule

