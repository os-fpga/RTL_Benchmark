// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_bpu (
    core_clk,
    core_reset_n,
    reset_vector,
    resume,
    redirect,
    redirect_pc,
    redirect_ras_ptr,
    btb_init_done,
    btb_flush_valid,
    btb_flush_ready,
    btb_update_p0,
    btb_update_p0_alloc,
    btb_update_p0_start_pc,
    btb_update_p0_target_pc,
    btb_update_p0_blk_offset,
    btb_update_p0_ucond,
    btb_update_p0_call,
    btb_update_p0_ret,
    btb_update_p0_way,
    btb_update_p0_hold,
    btb_update_p1,
    btb_update_p1_alloc,
    btb_update_p1_start_pc,
    btb_update_p1_target_pc,
    btb_update_p1_blk_offset,
    btb_update_p1_ucond,
    btb_update_p1_call,
    btb_update_p1_ret,
    btb_update_p1_way,
    btb_update_p1_hold,
    bhr_recover,
    bhr_recover_data,
    bht_update_p0,
    bht_update_p0_dir_addr,
    bht_update_p0_sel_addr,
    bht_update_p0_sel_data,
    bht_update_p0_dir_data,
    bht_update_p1,
    bht_update_p1_dir_addr,
    bht_update_p1_sel_addr,
    bht_update_p1_sel_data,
    bht_update_p1_dir_data,
    btb0_addr,
    btb0_cs,
    btb0_we,
    btb0_rdata,
    btb0_wdata,
    btb1_addr,
    btb1_cs,
    btb1_we,
    btb1_rdata,
    btb1_wdata,
    csr_mmisc_ctl_brpe,
    csr_cur_privilege,
    csr_halt_mode,
    bpu_rd_valid,
    bpu_rd_ack,
    bpu_info_hit,
    bpu_info_fall_thru_pc,
    bpu_info_target,
    bpu_info_start_pc,
    bpu_info_offset,
    bpu_info_way,
    bpu_info_ucond,
    bpu_info_ret,
    bpu_info_pred_taken,
    bpu_info_pred_cnt,
    bpu_rd_ready
);
parameter VALEN = 32;
parameter EXTVALEN = 32;
parameter BTB_SIZE = 0;
parameter BTB_RAM_ADDR_WIDTH = 7;
parameter BTB_RAM_DATA_WIDTH = 38;
parameter DEBUG_VEC = 64'h0000_0000;
localparam RAS_DEPTH = 4;
localparam RAS_PTR_MSB = 1;
localparam RAS_WRAP_NUM = 2'd3;
localparam PRIVILEGE_MACHINE = 2'b11;
input core_clk;
input core_reset_n;
input [VALEN - 1:0] reset_vector;
input resume;
input redirect;
input [EXTVALEN - 1:0] redirect_pc;
input [RAS_PTR_MSB:0] redirect_ras_ptr;
output btb_init_done;
input btb_flush_valid;
output btb_flush_ready;
input btb_update_p0;
input btb_update_p0_alloc;
input [VALEN - 1:0] btb_update_p0_start_pc;
input [VALEN - 1:0] btb_update_p0_target_pc;
input [9:0] btb_update_p0_blk_offset;
input btb_update_p0_ucond;
input btb_update_p0_call;
input btb_update_p0_ret;
input [1:0] btb_update_p0_way;
input btb_update_p0_hold;
input btb_update_p1;
input btb_update_p1_alloc;
input [VALEN - 1:0] btb_update_p1_start_pc;
input [VALEN - 1:0] btb_update_p1_target_pc;
input [9:0] btb_update_p1_blk_offset;
input btb_update_p1_ucond;
input btb_update_p1_call;
input btb_update_p1_ret;
input [1:0] btb_update_p1_way;
input btb_update_p1_hold;
input bhr_recover;
input [7:0] bhr_recover_data;
input bht_update_p0;
input [7:0] bht_update_p0_dir_addr;
input [7:0] bht_update_p0_sel_addr;
input [1:0] bht_update_p0_sel_data;
input [1:0] bht_update_p0_dir_data;
input bht_update_p1;
input [7:0] bht_update_p1_dir_addr;
input [7:0] bht_update_p1_sel_addr;
input [1:0] bht_update_p1_sel_data;
input [1:0] bht_update_p1_dir_data;
output [BTB_RAM_ADDR_WIDTH - 1:0] btb0_addr;
output btb0_cs;
output btb0_we;
input [BTB_RAM_DATA_WIDTH - 1:0] btb0_rdata;
output [BTB_RAM_DATA_WIDTH - 1:0] btb0_wdata;
output [BTB_RAM_ADDR_WIDTH - 1:0] btb1_addr;
output btb1_cs;
output btb1_we;
input [BTB_RAM_DATA_WIDTH - 1:0] btb1_rdata;
output [BTB_RAM_DATA_WIDTH - 1:0] btb1_wdata;
input csr_mmisc_ctl_brpe;
input [1:0] csr_cur_privilege;
input csr_halt_mode;
input bpu_rd_valid;
output bpu_rd_ack;
output bpu_info_hit;
output [VALEN - 1:0] bpu_info_fall_thru_pc;
output [VALEN - 1:0] bpu_info_target;
output [VALEN - 1:0] bpu_info_start_pc;
output [9:0] bpu_info_offset;
output [1:0] bpu_info_way;
output bpu_info_ucond;
output bpu_info_ret;
output bpu_info_pred_taken;
output [3:0] bpu_info_pred_cnt;
output bpu_rd_ready;


wire ras_push;
wire ras_push_priv;
wire ras_pop;
wire [VALEN - 1:0] ras_push_addr;
wire [VALEN - 1:0] ras_pred_target;
wire ras_pred_valid;
wire [7:0] bht_dir_rd_addr;
wire [7:0] bht_sel_rd_addr;
wire [1:0] bht_taken_rdata;
wire [1:0] bht_ntaken_rdata;
wire [1:0] bht_sel_rdata;
kv_bpu_ras #(
    .BTB_SIZE(BTB_SIZE),
    .VALEN(VALEN),
    .DEBUG_VEC(DEBUG_VEC),
    .RAS_DEPTH(RAS_DEPTH),
    .RAS_PTR_MSB(RAS_PTR_MSB),
    .RAS_WRAP_NUM(RAS_WRAP_NUM)
) u_kv_bpu_ras (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .reset_vector(reset_vector),
    .redirect(redirect),
    .redirect_ras_ptr(redirect_ras_ptr),
    .csr_mmisc_ctl_brpe(csr_mmisc_ctl_brpe),
    .csr_halt_mode(csr_halt_mode),
    .ras_push(ras_push),
    .ras_push_priv(ras_push_priv),
    .ras_push_addr(ras_push_addr),
    .ras_pop(ras_pop),
    .ras_pred_target(ras_pred_target),
    .ras_pred_valid(ras_pred_valid)
);
assign ras_push_priv = (csr_cur_privilege == PRIVILEGE_MACHINE);
kv_bpu_bht #(
    .BTB_SIZE(BTB_SIZE)
) u_kv_bpu_bht (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .bht_update_p0(bht_update_p0),
    .bht_update_p0_dir_addr(bht_update_p0_dir_addr),
    .bht_update_p0_sel_addr(bht_update_p0_sel_addr),
    .bht_update_p0_sel_data(bht_update_p0_sel_data),
    .bht_update_p0_dir_data(bht_update_p0_dir_data),
    .bht_update_p1(bht_update_p1),
    .bht_update_p1_dir_addr(bht_update_p1_dir_addr),
    .bht_update_p1_sel_addr(bht_update_p1_sel_addr),
    .bht_update_p1_sel_data(bht_update_p1_sel_data),
    .bht_update_p1_dir_data(bht_update_p1_dir_data),
    .bht_dir_rd_addr(bht_dir_rd_addr),
    .bht_sel_rd_addr(bht_sel_rd_addr),
    .bht_taken_rdata(bht_taken_rdata),
    .bht_ntaken_rdata(bht_ntaken_rdata),
    .bht_sel_rdata(bht_sel_rdata)
);
kv_bpu_ctrl #(
    .VALEN(VALEN),
    .EXTVALEN(EXTVALEN),
    .BTB_SIZE(BTB_SIZE),
    .BTB_RAM_ADDR_WIDTH(BTB_RAM_ADDR_WIDTH),
    .BTB_RAM_DATA_WIDTH(BTB_RAM_DATA_WIDTH)
) u_kv_bpu_ctrl (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .resume(resume),
    .redirect(redirect),
    .redirect_pc(redirect_pc),
    .btb_init_done(btb_init_done),
    .btb_flush_valid(btb_flush_valid),
    .btb_flush_ready(btb_flush_ready),
    .btb_update_p0(btb_update_p0),
    .btb_update_p0_alloc(btb_update_p0_alloc),
    .btb_update_p0_start_pc(btb_update_p0_start_pc),
    .btb_update_p0_target_pc(btb_update_p0_target_pc),
    .btb_update_p0_blk_offset(btb_update_p0_blk_offset),
    .btb_update_p0_ucond(btb_update_p0_ucond),
    .btb_update_p0_call(btb_update_p0_call),
    .btb_update_p0_ret(btb_update_p0_ret),
    .btb_update_p0_way(btb_update_p0_way),
    .btb_update_p0_hold(btb_update_p0_hold),
    .btb_update_p1(btb_update_p1),
    .btb_update_p1_alloc(btb_update_p1_alloc),
    .btb_update_p1_start_pc(btb_update_p1_start_pc),
    .btb_update_p1_target_pc(btb_update_p1_target_pc),
    .btb_update_p1_blk_offset(btb_update_p1_blk_offset),
    .btb_update_p1_ucond(btb_update_p1_ucond),
    .btb_update_p1_call(btb_update_p1_call),
    .btb_update_p1_ret(btb_update_p1_ret),
    .btb_update_p1_way(btb_update_p1_way),
    .btb_update_p1_hold(btb_update_p1_hold),
    .bhr_recover(bhr_recover),
    .bhr_recover_data(bhr_recover_data),
    .btb0_addr(btb0_addr),
    .btb0_cs(btb0_cs),
    .btb0_we(btb0_we),
    .btb0_rdata(btb0_rdata),
    .btb0_wdata(btb0_wdata),
    .btb1_addr(btb1_addr),
    .btb1_cs(btb1_cs),
    .btb1_we(btb1_we),
    .btb1_rdata(btb1_rdata),
    .btb1_wdata(btb1_wdata),
    .csr_mmisc_ctl_brpe(csr_mmisc_ctl_brpe),
    .csr_cur_privilege(csr_cur_privilege),
    .csr_halt_mode(csr_halt_mode),
    .bpu_rd_valid(bpu_rd_valid),
    .bpu_rd_ack(bpu_rd_ack),
    .bpu_info_hit(bpu_info_hit),
    .bpu_info_fall_thru_pc(bpu_info_fall_thru_pc),
    .bpu_info_target(bpu_info_target),
    .bpu_info_start_pc(bpu_info_start_pc),
    .bpu_info_offset(bpu_info_offset),
    .bpu_info_way(bpu_info_way),
    .bpu_info_ucond(bpu_info_ucond),
    .bpu_info_ret(bpu_info_ret),
    .bpu_info_pred_taken(bpu_info_pred_taken),
    .bpu_info_pred_cnt(bpu_info_pred_cnt),
    .bpu_rd_ready(bpu_rd_ready),
    .ras_push(ras_push),
    .ras_pop(ras_pop),
    .ras_push_addr(ras_push_addr),
    .ras_pred_target(ras_pred_target),
    .ras_pred_valid(ras_pred_valid),
    .bht_dir_rd_addr(bht_dir_rd_addr),
    .bht_sel_rd_addr(bht_sel_rd_addr),
    .bht_taken_rdata(bht_taken_rdata),
    .bht_ntaken_rdata(bht_ntaken_rdata),
    .bht_sel_rdata(bht_sel_rdata)
);
endmodule

