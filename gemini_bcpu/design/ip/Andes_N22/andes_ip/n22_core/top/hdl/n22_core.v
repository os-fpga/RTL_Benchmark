// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module n22_core (
    dmactive,
    jtag_tck,
    jtag_tms,
    jtag_tdi,
    jtag_tdo,
    jtag_tdo_en,
    disable_ext_debugger,
    dbg_srst_req,
    hart_halted,
    core_clk_aon,
    core_clk,
    core_reset_n,
    por_reset_n,
    reset_bypass,
    clkgate_bypass,
    nmi,
    meip,
    mtime_toggle_a,
    clic_irq,
    ilm_cs,
    ilm_addr,
    ilm_byte_we,
    ilm_wdata,
    ilm_rdata,
    clk_ilm_ram,
    dlm_cs,
    dlm_addr,
    dlm_byte_we,
    dlm_wdata,
    dlm_rdata,
    clk_dlm_ram,
    htrans,
    hwrite,
    haddr,
    hsize,
    hburst,
    hmastlock,
    hwdata,
    hprot,
    master,
    hrdata,
    hresp,
    hready,
    tx_evt,
    rx_evt,
    hart_id,
    reset_vector,
    core_wfi_mode,
    core_sleep_value
);
output dmactive;
input jtag_tck;
input jtag_tms;
input jtag_tdi;
output jtag_tdo;
output jtag_tdo_en;
input disable_ext_debugger;
output dbg_srst_req;
output hart_halted;
input core_clk_aon;
input core_clk;
input core_reset_n;
input por_reset_n;
input reset_bypass;
input clkgate_bypass;
input nmi;
input meip;
input mtime_toggle_a;
input [32 - 1:0] clic_irq;
output ilm_cs;
output [(15 - 2) - 1:0] ilm_addr;
output [4 - 1:0] ilm_byte_we;
output [32 - 1:0] ilm_wdata;
input [32 - 1:0] ilm_rdata;
output clk_ilm_ram;
output dlm_cs;
output [(15 - 2) - 1:0] dlm_addr;
output [4 - 1:0] dlm_byte_we;
output [32 - 1:0] dlm_wdata;
input [32 - 1:0] dlm_rdata;
output clk_dlm_ram;
output [1:0] htrans;
output hwrite;
output [32 - 1:0] haddr;
output [2:0] hsize;
output [2:0] hburst;
output hmastlock;
output [32 - 1:0] hwdata;
output [3:0] hprot;
output [1:0] master;
input [32 - 1:0] hrdata;
input [1:0] hresp;
input hready;
output tx_evt;
input rx_evt;
input [32 - 1:0] hart_id;
input [32 - 1:0] reset_vector;
output core_wfi_mode;
output core_sleep_value;


parameter N22_DLM_BASE_ADDR = 32'hfffD0000;
parameter N22_ILM_BASE_ADDR = 32'hFFFB0000;
parameter N22_PPI_BASE_ADDR = {(32){1'b0}};
parameter N22_FIO_BASE_ADDR = {(32){1'b0}};
parameter N22_DEVICE_REGION0_BASE = {(32){1'b0}};
parameter N22_DEVICE_REGION1_BASE = {(32){1'b0}};
parameter N22_DEVICE_REGION2_BASE = {(32){1'b0}};
parameter N22_DEVICE_REGION3_BASE = {(32){1'b0}};
parameter N22_DEVICE_REGION4_BASE = {(32){1'b0}};
parameter N22_DEVICE_REGION5_BASE = {(32){1'b0}};
parameter N22_DEVICE_REGION6_BASE = {(32){1'b0}};
parameter N22_DEVICE_REGION7_BASE = {(32){1'b0}};
parameter N22_TMR_BASE_ADDR = 32'he6000000;
parameter N22_CLIC_BASE_ADDR = 32'he2000000;
parameter N22_DEBUG_BASE_ADDR = 32'he6800000;
localparam CLIC_IRQ_NUM = (32 + 19);
parameter DEBUG_INTERFACE = "jtag";
parameter PROGBUF_SIZE = 8;
wire msip_all;
wire mtip;
wire msip;
assign msip_all = 1'b0 | msip;
wire rx_evt_req;
wire rx_evt_ack;
wire nmi_irq_r;
wire nmi_irq_taken;
wire ext_irq_r;
wire sft_irq_r;
wire tmr_irq_r;
wire rst_aon;
wire clic_int_mode;
wire meip_real = (~clic_int_mode) & meip;
wire msip_real = (~clic_int_mode) & msip_all;
wire mtip_real = (~clic_int_mode) & mtip;
n22_irq_sync u_n22_irq_sync(
    .clk_aon(core_clk_aon),
    .rst_n(rst_aon),
    .rx_evt(rx_evt),
    .nmi_irq(nmi),
    .ext_irq(meip_real),
    .sft_irq(msip_real),
    .tmr_irq(mtip_real),
    .nmi_irq_taken(nmi_irq_taken),
    .nmi_irq_r(nmi_irq_r),
    .ext_irq_r(ext_irq_r),
    .sft_irq_r(sft_irq_r),
    .tmr_irq_r(tmr_irq_r),
    .rx_evt_req(rx_evt_req),
    .rx_evt_ack(rx_evt_ack)
);
wire core_cgstop = 1'b0;
wire tcm_cgstop = 1'b0;
wire clk_csr;
wire rst_csr;
wire rst_core;
wire clk_ifu;
wire clk_exu;
wire clk_lsu;
wire clk_biu;
wire clk_lbiu;
wire csr_wfe_bit;
wire core_sleep_value_raw;
assign core_sleep_value = core_wfi_mode & core_sleep_value_raw;
wire ifu_active;
wire exu_active;
wire lsu_active;
wire biu_active;
wire lbiu_active;
assign clk_csr = clk_exu;
assign rst_csr = rst_core;
wire clk_ilm;
wire ilm_active;
wire clk_dlm;
wire dlm_active;
wire hart_unavail;
wire hart_under_reset;
n22_rst_ctrl u_n22_rst_ctrl(
    .hart_under_reset(hart_under_reset),
    .clk_aon(core_clk_aon),
    .por_reset_n(por_reset_n),
    .core_reset_n(core_reset_n),
    .reset_bypass(reset_bypass),
    .rst_core(rst_core),
    .rst_aon(rst_aon)
);
wire pft_active;
wire clk_pft;
wire tmr_active;
wire clk_tmr;
wire clic_active;
wire clk_clic;
n22_clk_ctrl u_n22_clk_ctrl(
    .clk_aon(core_clk_aon),
    .clk(core_clk),
    .rst_n(rst_aon),
    .clkgate_bypass(clkgate_bypass),
    .core_cgstop(core_cgstop),
    .tmr_active(tmr_active),
    .clk_tmr(clk_tmr),
    .clic_active(clic_active),
    .clk_clic(clk_clic),
    .pft_active(pft_active),
    .clk_pft(clk_pft),
    .clk_ifu(clk_ifu),
    .clk_exu(clk_exu),
    .clk_lsu(clk_lsu),
    .clk_ilm(clk_ilm),
    .ilm_active(ilm_active),
    .ilm_ls(),
    .clk_dlm(clk_dlm),
    .dlm_active(dlm_active),
    .dlm_ls(),
    .ifu_active(ifu_active),
    .exu_active(exu_active),
    .lsu_active(lsu_active),
    .lbiu_active(lbiu_active),
    .clk_lbiu(clk_lbiu),
    .biu_active(biu_active),
    .clk_biu(clk_biu)
);
wire dbg_csr_ena;
wire dbg_csr_wr_en;
wire dbg_csr_rd_en;
wire [12 - 1:0] dbg_csr_idx;
wire dbg_wbck_csr_wen;
wire [32 - 1:0] dbg_wbck_csr_dat;
wire [32 - 1:0] dbg_read_csr_dat;
wire dbg_csr_addr_legal;
wire dbg_csr_prv_ilgl;
wire [32 - 1:0] cmt_dpc;
wire cmt_dpc_ena;
wire [3 - 1:0] cmt_dcause;
wire cmt_dcause_ena;
wire cmt_dprv_ena;
wire [2 - 1:0] cmt_dprv;
wire [2 - 1:0] dbg_prv_r;
wire [32 - 1:0] csr_dpc_r;
wire [32 - 1:0] dbg_dexc2dbg_r;
wire [32 - 1:0] cmt_ddcause;
wire cmt_ddcause_ena;
wire dbg_resethaltreq;
wire dbg_halt;
wire dbg_step_r;
wire dbg_ebreakm_r;
wire dbg_stopcount;
wire dbg_ebreaku_r;
wire dbg_stepie;
wire dbg_mprven;
wire [32 * 4 - 1:0] dbg_tdata1;
wire [32 * 4 - 1:0] dbg_tdata2;
wire icount_taken_ena;
wire dbg_sleep;
wire dm_ahbl_active;
wire [1:0] dm_ahbl_htrans;
wire dm_ahbl_hwrite;
wire [32 - 1:0] dm_ahbl_haddr;
wire [2:0] dm_ahbl_hsize;
wire [2:0] dm_ahbl_hburst;
wire [3:0] dm_ahbl_hprot;
wire [32 - 1:0] dm_ahbl_hwdata;
wire [32 - 1:0] dm_ahbl_hrdata;
wire [1:0] dm_ahbl_hresp;
wire dm_ahbl_hready;
wire resethaltreq;
assign dbg_resethaltreq = resethaltreq;
wire dbg_stoptime;
wire tap_dmi_active;
wire dbg_active;
wire jtag_tdi_in;
wire jtag_tdi_out;
wire jtag_tdi_out_en;
wire jtag_tdo_in;
wire jtag_tdo_out;
wire jtag_tdo_out_en;
wire jtag_tms_in;
wire jtag_tms_out;
wire jtag_tms_out_en;
wire jtag_trst_in;
wire jtag_trst_out;
wire jtag_trst_out_en;
wire jtag_tck_in;
assign jtag_tck_in = jtag_tck;
assign jtag_tms_in = jtag_tms;
assign jtag_tdi_in = jtag_tdi;
assign jtag_tdo_in = 1'b0;
assign jtag_trst_in = 1'b0;
assign jtag_tdo = jtag_tdo_out;
assign jtag_tdo_en = jtag_tdo_out_en;
n22_dbg_top #(
    .DEBUG_INTERFACE(DEBUG_INTERFACE),
    .PROGBUF_SIZE(PROGBUF_SIZE)
) u_n22_dbg_top (
    .core_clk_dbg(core_clk_aon),
    .dbg_active(dbg_active),
    .tap_dmi_active(tap_dmi_active),
    .dbg_sleep(dbg_sleep),
    .dmactive(dmactive),
    .hart_unavail(hart_unavail),
    .hart_under_reset(hart_under_reset),
    .jtag_tdi_in(jtag_tdi_in),
    .jtag_tdi_out(jtag_tdi_out),
    .jtag_tdi_out_en(jtag_tdi_out_en),
    .jtag_tdo_in(jtag_tdo_in),
    .jtag_tdo_out(jtag_tdo_out),
    .jtag_tdo_out_en(jtag_tdo_out_en),
    .jtag_tms_in(jtag_tms_in),
    .jtag_tms_out(jtag_tms_out),
    .jtag_tms_out_en(jtag_tms_out_en),
    .jtag_trst_in(jtag_trst_in),
    .jtag_trst_out(jtag_trst_out),
    .jtag_trst_out_en(jtag_trst_out_en),
    .jtag_tck(jtag_tck_in),
    .por_reset_n(por_reset_n),
    .reset_bypass(reset_bypass),
    .clkgate_bypass(clkgate_bypass),
    .disable_ext_debugger(disable_ext_debugger),
    .resethaltreq(resethaltreq),
    .dbg_srst_req(dbg_srst_req),
    .csr_ena(dbg_csr_ena),
    .csr_wr_en(dbg_csr_wr_en),
    .csr_rd_en(dbg_csr_rd_en),
    .wbck_csr_wen(dbg_wbck_csr_wen),
    .csr_idx(dbg_csr_idx),
    .read_csr_dat(dbg_read_csr_dat),
    .wbck_csr_dat(dbg_wbck_csr_dat),
    .csr_addr_legal(dbg_csr_addr_legal),
    .csr_prv_ilgl(dbg_csr_prv_ilgl),
    .cmt_dpc(cmt_dpc),
    .cmt_dpc_ena(cmt_dpc_ena),
    .cmt_dcause(cmt_dcause),
    .cmt_dcause_ena(cmt_dcause_ena),
    .dbg_dexc2dbg_r(dbg_dexc2dbg_r),
    .cmt_ddcause(cmt_ddcause),
    .cmt_ddcause_ena(cmt_ddcause_ena),
    .cmt_dprv_ena(cmt_dprv_ena),
    .cmt_dprv(cmt_dprv),
    .dbg_prv_r(dbg_prv_r),
    .csr_dpc_r(csr_dpc_r),
    .dbg_tdata1(dbg_tdata1),
    .dbg_tdata2(dbg_tdata2),
    .icount_taken_ena(icount_taken_ena),
    .dbg_mode(hart_halted),
    .dbg_step_r(dbg_step_r),
    .dbg_ebreakm_r(dbg_ebreakm_r),
    .dbg_stopcount(dbg_stopcount),
    .dbg_stoptime(dbg_stoptime),
    .dbg_halt(dbg_halt),
    .dbg_ebreaku_r(dbg_ebreaku_r),
    .dbg_stepie(dbg_stepie),
    .dbg_mprven(dbg_mprven),
    .nmi_irq_r(nmi_irq_r),
    .dm_ahbl_active(dm_ahbl_active),
    .dm_ahbl_htrans(dm_ahbl_htrans),
    .dm_ahbl_hwrite(dm_ahbl_hwrite),
    .dm_ahbl_haddr(dm_ahbl_haddr),
    .dm_ahbl_hsize(dm_ahbl_hsize),
    .dm_ahbl_hburst(dm_ahbl_hburst),
    .dm_ahbl_hwdata(dm_ahbl_hwdata),
    .dm_ahbl_hprot(dm_ahbl_hprot),
    .dm_ahbl_hrdata(dm_ahbl_hrdata),
    .dm_ahbl_hready(dm_ahbl_hready),
    .dm_ahbl_hresp(dm_ahbl_hresp),
    .clk_csr(clk_csr),
    .rst_csr(rst_csr)
);
wire tmr_icb_cmd_valid;
wire tmr_icb_cmd_ready;
wire [32 - 1:0] tmr_icb_cmd_addr;
wire tmr_icb_cmd_read;
wire tmr_icb_cmd_mmode;
wire tmr_icb_cmd_dmode;
wire [32 - 1:0] tmr_icb_cmd_wdata;
wire [4 - 1:0] tmr_icb_cmd_wmask;
wire tmr_icb_rsp_valid;
wire tmr_icb_rsp_ready;
wire tmr_icb_rsp_err;
wire [32 - 1:0] tmr_icb_rsp_rdata;
wire clic_icb_cmd_valid;
wire clic_icb_cmd_ready;
wire [32 - 1:0] clic_icb_cmd_addr;
wire clic_icb_cmd_mmode;
wire clic_icb_cmd_dmode;
wire clic_icb_cmd_read;
wire [32 - 1:0] clic_icb_cmd_wdata;
wire [4 - 1:0] clic_icb_cmd_wmask;
wire clic_icb_rsp_valid;
wire clic_icb_rsp_ready;
wire clic_icb_rsp_err;
wire [32 - 1:0] clic_icb_rsp_rdata;
wire clic_irq_taken;
wire core_in_int;
wire mnxti_valid_taken;
wire mip_bwei;
wire mip_pmovi;
wire mip_imecci;
wire clic_irq_r;
wire [9:0] clic_irq_id;
wire clic_irq_shv;
wire [7:0] mintstatus_mil_r;
wire [7:0] clic_irq_lvl;
wire clic_prio_gt_thod;
wire lsu2ilm_icb_cmd_sel;
wire lsu2ilm_icb_cmd_valid;
wire lsu2ilm_icb_cmd_ready;
wire [15 - 1:0] lsu2ilm_icb_cmd_addr;
wire lsu2ilm_icb_cmd_mmode;
wire lsu2ilm_icb_cmd_dmode;
wire lsu2ilm_icb_cmd_read;
wire [32 - 1:0] lsu2ilm_icb_cmd_wdata;
wire [4 - 1:0] lsu2ilm_icb_cmd_wmask;
wire lsu2ilm_icb_cmd_lock;
wire lsu2ilm_icb_cmd_excl;
wire [1:0] lsu2ilm_icb_cmd_size;
wire lsu2ilm_icb_rsp_valid;
wire lsu2ilm_icb_rsp_ready;
wire lsu2ilm_icb_rsp_err;
wire lsu2ilm_icb_rsp_excl_ok;
wire [32 - 1:0] lsu2ilm_icb_rsp_rdata;
wire ifu2ilm_icb_cmd_valid;
wire ifu2ilm_icb_cmd_ready;
wire [15 - 1:0] ifu2ilm_icb_cmd_addr;
wire ifu2ilm_icb_cmd_mmode;
wire ifu2ilm_icb_cmd_dmode;
wire ifu2ilm_icb_cmd_vmode;
wire ifu2ilm_icb_rsp_valid;
wire ifu2ilm_icb_rsp_err;
wire [32 - 1:0] ifu2ilm_icb_rsp_rdata;
wire lsu2dlm_icb_cmd_sel;
wire lsu2dlm_icb_cmd_valid;
wire lsu2dlm_icb_cmd_ready;
wire [15 - 1:0] lsu2dlm_icb_cmd_addr;
wire lsu2dlm_icb_cmd_mmode;
wire lsu2dlm_icb_cmd_dmode;
wire lsu2dlm_icb_cmd_read;
wire [32 - 1:0] lsu2dlm_icb_cmd_wdata;
wire [4 - 1:0] lsu2dlm_icb_cmd_wmask;
wire lsu2dlm_icb_cmd_lock;
wire lsu2dlm_icb_cmd_excl;
wire [1:0] lsu2dlm_icb_cmd_size;
wire lsu2dlm_icb_rsp_valid;
wire lsu2dlm_icb_rsp_ready;
wire lsu2dlm_icb_rsp_err;
wire lsu2dlm_icb_rsp_excl_ok;
wire [32 - 1:0] lsu2dlm_icb_rsp_rdata;
n22_ucore #(
    .N22_DLM_BASE_ADDR(N22_DLM_BASE_ADDR),
    .N22_ILM_BASE_ADDR(N22_ILM_BASE_ADDR),
    .N22_PPI_BASE_ADDR(N22_PPI_BASE_ADDR),
    .N22_FIO_BASE_ADDR(N22_FIO_BASE_ADDR),
    .N22_DEVICE_REGION0_BASE(N22_DEVICE_REGION0_BASE),
    .N22_DEVICE_REGION1_BASE(N22_DEVICE_REGION1_BASE),
    .N22_DEVICE_REGION2_BASE(N22_DEVICE_REGION2_BASE),
    .N22_DEVICE_REGION3_BASE(N22_DEVICE_REGION3_BASE),
    .N22_DEVICE_REGION4_BASE(N22_DEVICE_REGION4_BASE),
    .N22_DEVICE_REGION5_BASE(N22_DEVICE_REGION5_BASE),
    .N22_DEVICE_REGION6_BASE(N22_DEVICE_REGION6_BASE),
    .N22_DEVICE_REGION7_BASE(N22_DEVICE_REGION7_BASE),
    .N22_TMR_BASE_ADDR(N22_TMR_BASE_ADDR),
    .N22_CLIC_BASE_ADDR(N22_CLIC_BASE_ADDR),
    .N22_DEBUG_BASE_ADDR(N22_DEBUG_BASE_ADDR)
) u_n22_ucore (
    .trace_ivalid(),
    .trace_iexception(),
    .trace_interrupt(),
    .trace_cause(),
    .trace_tval(),
    .trace_iaddr(),
    .trace_instr(),
    .trace_priv(),
    .hart_under_reset(hart_under_reset),
    .hart_unavail(hart_unavail),
    .resethaltreq(resethaltreq),
    .tap_dmi_active(tap_dmi_active),
    .pc_rtvec(reset_vector),
    .core_wfi(core_wfi_mode),
    .dbg_sleep(dbg_sleep),
    .csr_wfe_bit(csr_wfe_bit),
    .rx_evt_req(rx_evt_req),
    .rx_evt_ack(rx_evt_ack),
    .sleep_value(core_sleep_value_raw),
    .tx_evt(tx_evt),
    .dbg_csr_ena(dbg_csr_ena),
    .dbg_csr_wr_en(dbg_csr_wr_en),
    .dbg_csr_rd_en(dbg_csr_rd_en),
    .dbg_wbck_csr_wen(dbg_wbck_csr_wen),
    .dbg_csr_idx(dbg_csr_idx),
    .dbg_read_csr_dat(dbg_read_csr_dat),
    .dbg_wbck_csr_dat(dbg_wbck_csr_dat),
    .dbg_csr_addr_legal(dbg_csr_addr_legal),
    .dbg_csr_prv_ilgl(dbg_csr_prv_ilgl),
    .cmt_dpc(cmt_dpc),
    .cmt_dpc_ena(cmt_dpc_ena),
    .cmt_dcause(cmt_dcause),
    .cmt_dcause_ena(cmt_dcause_ena),
    .dbg_dexc2dbg_r(dbg_dexc2dbg_r),
    .cmt_ddcause(cmt_ddcause),
    .cmt_ddcause_ena(cmt_ddcause_ena),
    .cmt_dprv_ena(cmt_dprv_ena),
    .cmt_dprv(cmt_dprv),
    .dbg_prv_r(dbg_prv_r),
    .csr_dpc_r(csr_dpc_r),
    .dbg_tdata1(dbg_tdata1),
    .dbg_tdata2(dbg_tdata2),
    .icount_taken_ena(icount_taken_ena),
    .dbg_mode(hart_halted),
    .dbg_step_r(dbg_step_r),
    .dbg_ebreakm_r(dbg_ebreakm_r),
    .dbg_stopcount(dbg_stopcount),
    .dbg_halt(dbg_halt),
    .dbg_resethaltreq(dbg_resethaltreq),
    .dbg_ebreaku_r(dbg_ebreaku_r),
    .dbg_stepie(dbg_stepie),
    .dbg_mprven(dbg_mprven),
    .core_mhartid(hart_id),
    .clic_irq(clic_irq_r),
    .mintstatus_mil_r(mintstatus_mil_r),
    .clic_irq_id(clic_irq_id),
    .clic_irq_lvl(clic_irq_lvl),
    .clic_irq_shv(clic_irq_shv),
    .clic_prio_gt_thod(clic_prio_gt_thod),
    .mnxti_valid_taken(mnxti_valid_taken),
    .mip_bwei(mip_bwei),
    .mip_pmovi(mip_pmovi),
    .mip_imecci(mip_imecci),
    .core_in_int(core_in_int),
    .clic_irq_taken(clic_irq_taken),
    .clic_int_mode(clic_int_mode),
    .nmi_irq_taken(nmi_irq_taken),
    .nmi_irq_r(nmi_irq_r),
    .ext_irq_r(ext_irq_r),
    .sft_irq_r(sft_irq_r),
    .tmr_irq_r(tmr_irq_r),
    .biu_active(biu_active),
    .clk_biu(clk_biu),
    .lbiu_active(lbiu_active),
    .clk_lbiu(clk_lbiu),
    .lsu2ilm_icb_cmd_sel(lsu2ilm_icb_cmd_sel),
    .lsu2ilm_icb_cmd_valid(lsu2ilm_icb_cmd_valid),
    .lsu2ilm_icb_cmd_ready(lsu2ilm_icb_cmd_ready),
    .lsu2ilm_icb_cmd_addr(lsu2ilm_icb_cmd_addr),
    .lsu2ilm_icb_cmd_mmode(lsu2ilm_icb_cmd_mmode),
    .lsu2ilm_icb_cmd_dmode(lsu2ilm_icb_cmd_dmode),
    .lsu2ilm_icb_cmd_read(lsu2ilm_icb_cmd_read),
    .lsu2ilm_icb_cmd_wdata(lsu2ilm_icb_cmd_wdata),
    .lsu2ilm_icb_cmd_wmask(lsu2ilm_icb_cmd_wmask),
    .lsu2ilm_icb_cmd_lock(lsu2ilm_icb_cmd_lock),
    .lsu2ilm_icb_cmd_excl(lsu2ilm_icb_cmd_excl),
    .lsu2ilm_icb_cmd_size(lsu2ilm_icb_cmd_size),
    .lsu2ilm_icb_rsp_valid(lsu2ilm_icb_rsp_valid),
    .lsu2ilm_icb_rsp_ready(lsu2ilm_icb_rsp_ready),
    .lsu2ilm_icb_rsp_err(lsu2ilm_icb_rsp_err),
    .lsu2ilm_icb_rsp_excl_ok(lsu2ilm_icb_rsp_excl_ok),
    .lsu2ilm_icb_rsp_rdata(lsu2ilm_icb_rsp_rdata),
    .ifu2ilm_icb_cmd_valid(ifu2ilm_icb_cmd_valid),
    .ifu2ilm_icb_cmd_ready(ifu2ilm_icb_cmd_ready),
    .ifu2ilm_icb_cmd_addr(ifu2ilm_icb_cmd_addr),
    .ifu2ilm_icb_cmd_mmode(ifu2ilm_icb_cmd_mmode),
    .ifu2ilm_icb_cmd_dmode(ifu2ilm_icb_cmd_dmode),
    .ifu2ilm_icb_cmd_vmode(ifu2ilm_icb_cmd_vmode),
    .ifu2ilm_icb_rsp_valid(ifu2ilm_icb_rsp_valid),
    .ifu2ilm_icb_rsp_err(ifu2ilm_icb_rsp_err),
    .ifu2ilm_icb_rsp_rdata(ifu2ilm_icb_rsp_rdata),
    .lsu2dlm_icb_cmd_sel(lsu2dlm_icb_cmd_sel),
    .lsu2dlm_icb_cmd_valid(lsu2dlm_icb_cmd_valid),
    .lsu2dlm_icb_cmd_ready(lsu2dlm_icb_cmd_ready),
    .lsu2dlm_icb_cmd_addr(lsu2dlm_icb_cmd_addr),
    .lsu2dlm_icb_cmd_mmode(lsu2dlm_icb_cmd_mmode),
    .lsu2dlm_icb_cmd_dmode(lsu2dlm_icb_cmd_dmode),
    .lsu2dlm_icb_cmd_read(lsu2dlm_icb_cmd_read),
    .lsu2dlm_icb_cmd_wdata(lsu2dlm_icb_cmd_wdata),
    .lsu2dlm_icb_cmd_wmask(lsu2dlm_icb_cmd_wmask),
    .lsu2dlm_icb_cmd_lock(lsu2dlm_icb_cmd_lock),
    .lsu2dlm_icb_cmd_excl(lsu2dlm_icb_cmd_excl),
    .lsu2dlm_icb_cmd_size(lsu2dlm_icb_cmd_size),
    .lsu2dlm_icb_rsp_valid(lsu2dlm_icb_rsp_valid),
    .lsu2dlm_icb_rsp_ready(lsu2dlm_icb_rsp_ready),
    .lsu2dlm_icb_rsp_err(lsu2dlm_icb_rsp_err),
    .lsu2dlm_icb_rsp_excl_ok(lsu2dlm_icb_rsp_excl_ok),
    .lsu2dlm_icb_rsp_rdata(lsu2dlm_icb_rsp_rdata),
    .clic_icb_cmd_valid(clic_icb_cmd_valid),
    .clic_icb_cmd_ready(clic_icb_cmd_ready),
    .clic_icb_cmd_addr(clic_icb_cmd_addr),
    .clic_icb_cmd_mmode(clic_icb_cmd_mmode),
    .clic_icb_cmd_dmode(clic_icb_cmd_dmode),
    .clic_icb_cmd_read(clic_icb_cmd_read),
    .clic_icb_cmd_wdata(clic_icb_cmd_wdata),
    .clic_icb_cmd_wmask(clic_icb_cmd_wmask),
    .clic_icb_rsp_valid(clic_icb_rsp_valid),
    .clic_icb_rsp_ready(clic_icb_rsp_ready),
    .clic_icb_rsp_err(clic_icb_rsp_err),
    .clic_icb_rsp_rdata(clic_icb_rsp_rdata),
    .tmr_icb_cmd_valid(tmr_icb_cmd_valid),
    .tmr_icb_cmd_ready(tmr_icb_cmd_ready),
    .tmr_icb_cmd_addr(tmr_icb_cmd_addr),
    .tmr_icb_cmd_mmode(tmr_icb_cmd_mmode),
    .tmr_icb_cmd_dmode(tmr_icb_cmd_dmode),
    .tmr_icb_cmd_read(tmr_icb_cmd_read),
    .tmr_icb_cmd_wdata(tmr_icb_cmd_wdata),
    .tmr_icb_cmd_wmask(tmr_icb_cmd_wmask),
    .tmr_icb_rsp_valid(tmr_icb_rsp_valid),
    .tmr_icb_rsp_ready(tmr_icb_rsp_ready),
    .tmr_icb_rsp_err(tmr_icb_rsp_err),
    .tmr_icb_rsp_rdata(tmr_icb_rsp_rdata),
    .bus_clk_en(1'b1),
    .htrans(htrans),
    .hwrite(hwrite),
    .haddr(haddr),
    .hsize(hsize),
    .hburst(hburst),
    .hwdata(hwdata),
    .hprot(hprot),
    .hattri(),
    .master(master),
    .hrdata(hrdata),
    .hresp(hresp),
    .hready(hready),
    .hlock(hmastlock),
    .dm_ahbl_active(dm_ahbl_active),
    .dm_ahbl_htrans(dm_ahbl_htrans),
    .dm_ahbl_hwrite(dm_ahbl_hwrite),
    .dm_ahbl_haddr(dm_ahbl_haddr),
    .dm_ahbl_hsize(dm_ahbl_hsize),
    .dm_ahbl_hburst(dm_ahbl_hburst),
    .dm_ahbl_hwdata(dm_ahbl_hwdata),
    .dm_ahbl_hprot(dm_ahbl_hprot),
    .dm_ahbl_hrdata(dm_ahbl_hrdata),
    .dm_ahbl_hready(dm_ahbl_hready),
    .dm_ahbl_hresp(dm_ahbl_hresp),
    .clkgate_bypass(clkgate_bypass),
    .pft_active(pft_active),
    .clk_pft(clk_pft),
    .exu_active(exu_active),
    .ifu_active(ifu_active),
    .lsu_active(lsu_active),
    .clk_ifu(clk_ifu),
    .clk_exu(clk_exu),
    .clk_lsu(clk_lsu),
    .clk_aon(core_clk_aon),
    .rst_n(rst_core)
);
n22_ilm_ctrl #(
    .AW(15),
    .DW(32),
    .MW(4),
    .RAM_AW((15 - 2)),
    .RAM_DW(32),
    .RAM_MW(4),
    .RAM_ECC_DW(7),
    .RAM_ECC_MW(1)
) u_n22_ilm_ctrl (
    .ilm_active(ilm_active),
    .tcm_cgstop(tcm_cgstop),
    .lsu2dlm_icb_cmd_sel(lsu2dlm_icb_cmd_sel),
    .lsu2ilm_icb_cmd_sel(lsu2ilm_icb_cmd_sel),
    .lsu2ilm_icb_cmd_valid(lsu2ilm_icb_cmd_valid),
    .lsu2ilm_icb_cmd_ready(lsu2ilm_icb_cmd_ready),
    .lsu2ilm_icb_cmd_addr(lsu2ilm_icb_cmd_addr),
    .lsu2ilm_icb_cmd_read(lsu2ilm_icb_cmd_read),
    .lsu2ilm_icb_cmd_wdata(lsu2ilm_icb_cmd_wdata),
    .lsu2ilm_icb_cmd_wmask(lsu2ilm_icb_cmd_wmask),
    .lsu2ilm_icb_cmd_lock(lsu2ilm_icb_cmd_lock),
    .lsu2ilm_icb_cmd_excl(lsu2ilm_icb_cmd_excl),
    .lsu2ilm_icb_cmd_size(lsu2ilm_icb_cmd_size),
    .lsu2ilm_icb_cmd_dmode(lsu2ilm_icb_cmd_dmode),
    .lsu2ilm_icb_cmd_mmode(lsu2ilm_icb_cmd_mmode),
    .lsu2ilm_icb_rsp_valid(lsu2ilm_icb_rsp_valid),
    .lsu2ilm_icb_rsp_ready(lsu2ilm_icb_rsp_ready),
    .lsu2ilm_icb_rsp_err(lsu2ilm_icb_rsp_err),
    .lsu2ilm_icb_rsp_excl_ok(lsu2ilm_icb_rsp_excl_ok),
    .lsu2ilm_icb_rsp_rdata(lsu2ilm_icb_rsp_rdata),
    .ifu_icb_cmd_valid(ifu2ilm_icb_cmd_valid),
    .ifu_icb_cmd_ready(ifu2ilm_icb_cmd_ready),
    .ifu_icb_cmd_addr(ifu2ilm_icb_cmd_addr[15 - 1:0]),
    .ifu_icb_cmd_mmode(ifu2ilm_icb_cmd_mmode),
    .ifu_icb_cmd_dmode(ifu2ilm_icb_cmd_dmode),
    .ifu_icb_cmd_vmode(ifu2ilm_icb_cmd_vmode),
    .ifu_icb_rsp_valid(ifu2ilm_icb_rsp_valid),
    .ifu_icb_rsp_err(ifu2ilm_icb_rsp_err),
    .ifu_icb_rsp_rdata(ifu2ilm_icb_rsp_rdata),
    .ram_cs(ilm_cs),
    .ram_addr(ilm_addr),
    .ram_wem(ilm_byte_we),
    .ram_din(ilm_wdata),
    .ram_dout(ilm_rdata),
    .clk_ram(clk_ilm_ram),
    .clkgate_bypass(clkgate_bypass),
    .clk(clk_ilm),
    .rst_n(rst_aon)
);
n22_dlm_ctrl #(
    .AW(15),
    .DW(32),
    .MW(4),
    .RAM_AW((15 - 2)),
    .RAM_DW(32),
    .RAM_MW(4),
    .RAM_ECC_DW(7),
    .RAM_ECC_MW(1)
) u_n22_dlm_ctrl (
    .dlm_active(dlm_active),
    .tcm_cgstop(tcm_cgstop),
    .icb_cmd_valid(lsu2dlm_icb_cmd_valid),
    .icb_cmd_ready(lsu2dlm_icb_cmd_ready),
    .icb_cmd_addr(lsu2dlm_icb_cmd_addr),
    .icb_cmd_read(lsu2dlm_icb_cmd_read),
    .icb_cmd_wdata(lsu2dlm_icb_cmd_wdata),
    .icb_cmd_wmask(lsu2dlm_icb_cmd_wmask),
    .icb_cmd_size(lsu2dlm_icb_cmd_size),
    .icb_cmd_mmode(lsu2dlm_icb_cmd_mmode),
    .icb_cmd_dmode(lsu2dlm_icb_cmd_dmode),
    .icb_rsp_valid(lsu2dlm_icb_rsp_valid),
    .icb_rsp_ready(lsu2dlm_icb_rsp_ready),
    .icb_rsp_err(lsu2dlm_icb_rsp_err),
    .icb_rsp_excl_ok(lsu2dlm_icb_rsp_excl_ok),
    .icb_rsp_rdata(lsu2dlm_icb_rsp_rdata),
    .ram_cs(dlm_cs),
    .ram_addr(dlm_addr),
    .ram_wem(dlm_byte_we),
    .ram_din(dlm_wdata),
    .ram_dout(dlm_rdata),
    .clk_ram(clk_dlm_ram),
    .clkgate_bypass(clkgate_bypass),
    .clk(clk_dlm),
    .rst_n(rst_aon)
);
n22_clic_top #(
    .CLIC_IRQ_NUM(CLIC_IRQ_NUM),
    .CLICINTCTLBITS(2)
) u_n22_clic_top (
    .clk_aon(core_clk_aon),
    .clk(clk_clic),
    .rst_n(rst_aon),
    .msip(msip_all),
    .mtip(mtip),
    .meip(meip),
    .mip_imecci(mip_imecci),
    .mip_bwei(mip_bwei),
    .mip_pmovi(mip_pmovi),
    .clic_irq(clic_irq),
    .icb_cmd_valid(clic_icb_cmd_valid),
    .icb_cmd_ready(clic_icb_cmd_ready),
    .icb_cmd_addr(clic_icb_cmd_addr[15:0]),
    .icb_cmd_wmask(clic_icb_cmd_wmask),
    .icb_cmd_read(clic_icb_cmd_read),
    .icb_cmd_wdata(clic_icb_cmd_wdata),
    .icb_rsp_valid(clic_icb_rsp_valid),
    .icb_rsp_ready(clic_icb_rsp_ready),
    .icb_rsp_rdata(clic_icb_rsp_rdata),
    .icb_rsp_err(clic_icb_rsp_err),
    .clic_irq_taken(clic_irq_taken),
    .core_in_int(core_in_int),
    .clic_int_mode(clic_int_mode),
    .mnxti_valid_taken(mnxti_valid_taken),
    .clic_active(clic_active),
    .clic_irq_o(clic_irq_r),
    .clic_irq_id(clic_irq_id),
    .clic_irq_shv(clic_irq_shv),
    .mintstatus_mil_r(mintstatus_mil_r),
    .clic_irq_lvl(clic_irq_lvl),
    .clic_prio_gt_thod(clic_prio_gt_thod)
);
n22_tmr_top u_n22_tmr_top(
    .i_icb_cmd_valid(tmr_icb_cmd_valid),
    .i_icb_cmd_ready(tmr_icb_cmd_ready),
    .i_icb_cmd_addr(tmr_icb_cmd_addr),
    .i_icb_cmd_read(tmr_icb_cmd_read),
    .i_icb_cmd_wdata(tmr_icb_cmd_wdata),
    .i_icb_cmd_wmask(tmr_icb_cmd_wmask),
    .i_icb_cmd_mmode(tmr_icb_cmd_mmode),
    .i_icb_cmd_dmode(tmr_icb_cmd_dmode),
    .i_icb_rsp_valid(tmr_icb_rsp_valid),
    .i_icb_rsp_ready(tmr_icb_rsp_ready),
    .i_icb_rsp_err(tmr_icb_rsp_err),
    .i_icb_rsp_rdata(tmr_icb_rsp_rdata),
    .tmr_irq(mtip),
    .sft_irq(msip),
    .rtc_toggle_a(mtime_toggle_a),
    .dbg_stoptime(dbg_stoptime),
    .tmr_active(tmr_active),
    .clk(clk_tmr),
    .clk_aon(core_clk_aon),
    .rst_n(rst_aon)
);
endmodule

