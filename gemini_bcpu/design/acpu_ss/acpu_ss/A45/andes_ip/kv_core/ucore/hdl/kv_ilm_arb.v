// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_ilm_arb (
    lm_clk,
    lm_reset_n,
    lsu_ilm_a_valid,
    lsu_ilm_a_stall,
    lsu_ilm_a_addr,
    lsu_ilm_a_func,
    lsu_ilm_a_user,
    lsu_ilm_a_ready,
    lsu_ilm_w_valid,
    lsu_ilm_w_data,
    lsu_ilm_w_mask,
    lsu_ilm_w_ready,
    lsu_ilm_w_status,
    lsu_ilm_d_valid,
    lsu_ilm_d_data,
    lsu_ilm_d_status,
    lsu_ilm_d_user,
    ifu_ilm_a_valid,
    ifu_ilm_a_stall,
    ifu_ilm_a_addr,
    ifu_ilm_a_func,
    ifu_ilm_a_user,
    ifu_ilm_a_ready,
    ifu_ilm_d_valid,
    ifu_ilm_d_data,
    ifu_ilm_d_status,
    ifu_ilm_d_user,
    slv_ilm_a_valid,
    slv_ilm_a_stall,
    slv_ilm_a_addr,
    slv_ilm_a_mask,
    slv_ilm_a_func,
    slv_ilm_a_user,
    slv_ilm_a_ready,
    slv_ilm_w_valid,
    slv_ilm_w_data,
    slv_ilm_w_mask,
    slv_ilm_w_ready,
    slv_ilm_d_valid,
    slv_ilm_d_data,
    slv_ilm_d_status,
    slv_ilm_d_user,
    ilm0_a_valid,
    ilm0_a_stall,
    ilm0_a_addr,
    ilm0_a_mask,
    ilm0_a_func,
    ilm0_a_user,
    ilm0_a_source,
    ilm0_a_ready,
    ilm0_w_valid,
    ilm0_w_data,
    ilm0_w_mask,
    ilm0_w_ready,
    ilm0_d_valid,
    ilm0_d_data,
    ilm0_d_status,
    ilm0_d_user
);
parameter BLOCKS = 1;
parameter ECC_TYPE_INT = 0;
parameter UW = 3;
parameter SOURCE_BITS = 4;
parameter ILM_SIZE_KB = 0;
parameter ILM_RAM_AW = 11;
parameter ILM_RAM_BWEW = 8;
parameter ILM_RAM_DW = 72;
parameter ILM_AMSB = ILM_RAM_AW + 2;
parameter ILM_ALSB = 3;
localparam ARB_SLV = 0;
localparam ARB_LSU = 1;
localparam ARB_IFU = 2;
localparam ARB_BITS = 3;
input lm_clk;
input lm_reset_n;
input lsu_ilm_a_valid;
input lsu_ilm_a_stall;
input [ILM_AMSB:0] lsu_ilm_a_addr;
input [2:0] lsu_ilm_a_func;
input [UW - 1:0] lsu_ilm_a_user;
output lsu_ilm_a_ready;
input lsu_ilm_w_valid;
input [63:0] lsu_ilm_w_data;
input [7:0] lsu_ilm_w_mask;
output lsu_ilm_w_ready;
output lsu_ilm_w_status;
output lsu_ilm_d_valid;
output [63:0] lsu_ilm_d_data;
output [13:0] lsu_ilm_d_status;
output [UW - 1:0] lsu_ilm_d_user;
input ifu_ilm_a_valid;
input ifu_ilm_a_stall;
input [ILM_AMSB:0] ifu_ilm_a_addr;
input [2:0] ifu_ilm_a_func;
input [UW - 1:0] ifu_ilm_a_user;
output ifu_ilm_a_ready;
output ifu_ilm_d_valid;
output [63:0] ifu_ilm_d_data;
output [13:0] ifu_ilm_d_status;
output [UW - 1:0] ifu_ilm_d_user;
input slv_ilm_a_valid;
input slv_ilm_a_stall;
input [ILM_AMSB:0] slv_ilm_a_addr;
input [BLOCKS - 1:0] slv_ilm_a_mask;
input [2:0] slv_ilm_a_func;
input [UW - 1:0] slv_ilm_a_user;
output slv_ilm_a_ready;
input slv_ilm_w_valid;
input [63:0] slv_ilm_w_data;
input [7:0] slv_ilm_w_mask;
output slv_ilm_w_ready;
output slv_ilm_d_valid;
output [63:0] slv_ilm_d_data;
output [13:0] slv_ilm_d_status;
output [UW - 1:0] slv_ilm_d_user;
output ilm0_a_valid;
output ilm0_a_stall;
output [ILM_RAM_AW - 1:0] ilm0_a_addr;
output [BLOCKS - 1:0] ilm0_a_mask;
output [2:0] ilm0_a_func;
output [UW + 2:0] ilm0_a_user;
output [SOURCE_BITS - 1:0] ilm0_a_source;
input ilm0_a_ready;
output ilm0_w_valid;
output [63:0] ilm0_w_data;
output [7:0] ilm0_w_mask;
input ilm0_w_ready;
input ilm0_d_valid;
input [63:0] ilm0_d_data;
input [13:0] ilm0_d_status;
input [UW + 2:0] ilm0_d_user;


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
wire [ILM_RAM_AW - 1:0] s10;
wire [2:0] s11;
wire [UW - 1:0] s12;
wire [BLOCKS - 1:0] s13;
wire s14;
wire [ILM_RAM_AW - 1:0] s15;
wire [2:0] s16;
wire [UW - 1:0] s17;
wire [BLOCKS - 1:0] s18;
wire s19;
wire [ILM_RAM_AW - 1:0] s20;
wire [2:0] s21;
wire [UW - 1:0] s22;
wire [BLOCKS - 1:0] s23;
wire s24;
wire nds_unused_ilm0_a_wready;
reg s25;
wire s26;
wire s27;
wire s28;
wire s29;
wire s30;
wire [1:0] s31;
wire [63:0] s32;
wire [7:0] s33;
wire [63:0] s34;
wire [7:0] s35;
wire [63:0] s36 = 64'd0;
wire [7:0] s37 = 8'd0;
wire [1:0] s38;
wire s39;
wire s40;
wire s41;
kv_cnt_johnson #(
    .N(2)
) u_slv_ilm_inflight (
    .clk(lm_clk),
    .rst_n(lm_reset_n),
    .up(s30),
    .dn(slv_ilm_d_valid),
    .cnt(s31)
);
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        s25 <= 1'b0;
    end
    else if (s26) begin
        s25 <= s27;
    end
end

assign s30 = slv_ilm_a_valid & slv_ilm_a_ready & ~slv_ilm_a_stall;
assign s26 = s28 | s29;
assign s28 = (s5 & s3[ARB_LSU] & ~lsu_ilm_w_valid) & (slv_ilm_a_valid & ~slv_ilm_a_stall | s31[0]);
assign s29 = slv_ilm_d_valid;
assign s27 = ~s29 & (s25 | s28);
assign s0[ARB_LSU] = lsu_ilm_a_valid & ~s38[0];
assign s0[ARB_SLV] = slv_ilm_a_valid;
assign s0[ARB_IFU] = ifu_ilm_a_valid;
kv_arb_fp #(
    .N(ARB_BITS)
) u_arb0_a (
    .valid(s0),
    .ready(s1),
    .grant(s2)
);
kv_mux_onehot #(
    .N(ARB_BITS),
    .W(1 + ILM_RAM_AW + 3 + BLOCKS + UW)
) u_ilm0_a (
    .out({ilm0_a_stall,ilm0_a_addr,ilm0_a_func,ilm0_a_mask,ilm0_a_user[UW - 1:0]}),
    .in({s14,s15,s16,s18,s17,s9,s10,s11,s13,s12,s19,s20,s21,s23,s22}),
    .sel(s2)
);
assign s9 = lsu_ilm_a_stall;
assign s10 = lsu_ilm_a_addr[ILM_AMSB:3];
assign s11 = lsu_ilm_a_func;
assign s12 = lsu_ilm_a_user;
generate
    if (BLOCKS == 1) begin:gen_lsu0_a_mask_1bank
        assign s13 = {BLOCKS{1'b1}};
    end
    else begin:gen_lsu0_a_mask_2bank
        assign s13[0] = ~lsu_ilm_a_addr[2];
        assign s13[1] = lsu_ilm_a_addr[2];
    end
endgenerate
assign s14 = ifu_ilm_a_stall;
assign s15 = ifu_ilm_a_addr[ILM_AMSB:3];
assign s16 = ifu_ilm_a_func;
assign s17 = ifu_ilm_a_user;
generate
    if (BLOCKS == 1) begin:gen_ifu0_a_mask_1bank
        assign s18 = {BLOCKS{1'b1}};
    end
    else begin:gen_ifu0_a_mask_2bank
        assign s18[0] = ~ifu_ilm_a_addr[2];
        assign s18[1] = 1'b1;
    end
endgenerate
assign s19 = slv_ilm_a_stall;
assign s20 = slv_ilm_a_addr[ILM_AMSB:3];
assign s21 = slv_ilm_a_func;
assign s22 = slv_ilm_a_user;
assign s23 = slv_ilm_a_mask[BLOCKS - 1:0];
assign lsu_ilm_a_ready = s1[ARB_LSU] & ilm0_a_ready & ~s38[0];
assign slv_ilm_a_ready = s1[ARB_SLV] & ilm0_a_ready;
assign ifu_ilm_a_ready = s1[ARB_IFU] & ilm0_a_ready;
assign ilm0_a_valid = |s0;
assign ilm0_a_user[UW +:ARB_BITS] = s2;
assign ilm0_a_source = ({2{s2[ARB_SLV] & s22[0]}} & 2'b11) | ({2{s2[ARB_SLV] & ~s22[0]}} & 2'b10) | ({2{s2[ARB_IFU]}} & 2'b01) | ({2{s2[ARB_LSU]}} & 2'b00);
kv_fifo #(
    .DEPTH(2),
    .WIDTH(ARB_BITS)
) u_m1_arb (
    .clk(lm_clk),
    .reset_n(lm_reset_n),
    .flush(1'b0),
    .wdata(s2),
    .wvalid(s24),
    .wready(nds_unused_ilm0_a_wready),
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
    .rready(s41)
);
assign s24 = ilm0_a_valid & ilm0_a_ready & ilm0_a_func[1] & ~ilm0_a_stall;
assign s41 = ilm0_w_valid & ilm0_w_ready;
kv_mux_onehot #(
    .N(ARB_BITS),
    .W(72)
) u_ilm0_w (
    .out({ilm0_w_data,ilm0_w_mask}),
    .in({s36,s37,s32,s33,s34,s35}),
    .sel(s3)
);
assign s33 = lsu_ilm_w_mask & {8{~s25}};
assign s32 = lsu_ilm_w_data;
assign s35 = slv_ilm_w_mask;
assign s34 = slv_ilm_w_data;
assign slv_ilm_w_ready = s5 & s3[ARB_SLV] & ilm0_w_ready;
assign ilm0_w_valid = (s5 & s3[ARB_LSU] & lsu_ilm_w_valid & ~lsu_ilm_w_status) | (s5 & s3[ARB_LSU] & s25) | (s5 & s3[ARB_SLV] & slv_ilm_w_valid);
kv_cnt_johnson #(
    .N(2)
) u_lsu_w_preempted_cnt (
    .clk(lm_clk),
    .rst_n(lm_reset_n),
    .up(s39),
    .dn(s40),
    .cnt(s38)
);
assign s39 = s41 & s3[ARB_LSU] & s25;
assign s40 = lsu_ilm_w_valid & lsu_ilm_w_ready & lsu_ilm_w_status;
assign lsu_ilm_w_ready = (s5 & s3[ARB_LSU] & ilm0_w_ready) | s38[0];
assign lsu_ilm_w_status = s25 | s38[0];
assign s4 = ilm0_d_user[UW +:ARB_BITS];
assign slv_ilm_d_valid = ilm0_d_valid & s4[ARB_SLV];
assign lsu_ilm_d_valid = ilm0_d_valid & s4[ARB_LSU];
assign ifu_ilm_d_valid = ilm0_d_valid & s4[ARB_IFU];
assign lsu_ilm_d_data = ilm0_d_data;
assign lsu_ilm_d_status = ilm0_d_status;
assign lsu_ilm_d_user = ilm0_d_user[UW - 1:0];
assign ifu_ilm_d_data = ilm0_d_data;
assign ifu_ilm_d_status = ilm0_d_status;
assign ifu_ilm_d_user = ilm0_d_user[UW - 1:0];
assign slv_ilm_d_data = ilm0_d_data;
assign slv_ilm_d_status = ilm0_d_status;
assign slv_ilm_d_user = ilm0_d_user[UW - 1:0];
endmodule

