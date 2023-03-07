// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pmp (
    ifu_pmp_req_pa,
    pmp_ifu_resp_fault,
    csr_dcsr_mprven,
    csr_halt_mode,
    csr_mstatus_mprv,
    csr_mstatus_mpp,
    core_clk,
    core_reset_n,
    csr_cur_privilege,
    lsu_pmp_req_pa,
    lsu_pmp_req_store,
    pmp_lsu_resp_fault,
    vpu_pmp_req_pa,
    vpu_pmp_resp_permission,
    csr_pmp_raddr0,
    csr_pmp_raddr1,
    csr_pmp_waddr,
    csr_pmp_wdata,
    csr_pmp_we,
    pmp_csr_hit0,
    pmp_csr_hit1,
    pmp_csr_rdata0,
    pmp_csr_rdata1
);
parameter PALEN = 56;
parameter PMP_ENTRIES = 1;
parameter PMP_GRANULARITY = 8;
parameter DEBUG_VEC = 64'h0000_0000;
input [(PALEN - 1):0] ifu_pmp_req_pa;
output pmp_ifu_resp_fault;
input csr_dcsr_mprven;
input csr_halt_mode;
input csr_mstatus_mprv;
input [1:0] csr_mstatus_mpp;
input core_clk;
input core_reset_n;
input [1:0] csr_cur_privilege;
input [(PALEN - 1):0] lsu_pmp_req_pa;
input lsu_pmp_req_store;
output pmp_lsu_resp_fault;
input [PALEN - 1:0] vpu_pmp_req_pa;
output [3:0] vpu_pmp_resp_permission;
input [11:0] csr_pmp_raddr0;
input [11:0] csr_pmp_raddr1;
input [11:0] csr_pmp_waddr;
input [31:0] csr_pmp_wdata;
input csr_pmp_we;
output pmp_csr_hit0;
output pmp_csr_hit1;
output [31:0] pmp_csr_rdata0;
output [31:0] pmp_csr_rdata1;


wire [3:0] nds_unused_pmp_ifu_resp_permission;
wire [3:0] nds_unused_pmp_lsu_resp_permission;
wire nds_unused_vpu_pmp_resp_fault;
wire [(PALEN - 1):2] csr_pmp0addr;
wire [7:0] csr_pmp0cfg;
wire [(PALEN - 1):2] csr_pmp10addr;
wire [7:0] csr_pmp10cfg;
wire [(PALEN - 1):2] csr_pmp11addr;
wire [7:0] csr_pmp11cfg;
wire [(PALEN - 1):2] csr_pmp12addr;
wire [7:0] csr_pmp12cfg;
wire [(PALEN - 1):2] csr_pmp13addr;
wire [7:0] csr_pmp13cfg;
wire [(PALEN - 1):2] csr_pmp14addr;
wire [7:0] csr_pmp14cfg;
wire [(PALEN - 1):2] csr_pmp15addr;
wire [7:0] csr_pmp15cfg;
wire [(PALEN - 1):2] csr_pmp16addr;
wire [7:0] csr_pmp16cfg;
wire [(PALEN - 1):2] csr_pmp17addr;
wire [7:0] csr_pmp17cfg;
wire [(PALEN - 1):2] csr_pmp18addr;
wire [7:0] csr_pmp18cfg;
wire [(PALEN - 1):2] csr_pmp19addr;
wire [7:0] csr_pmp19cfg;
wire [(PALEN - 1):2] csr_pmp1addr;
wire [7:0] csr_pmp1cfg;
wire [(PALEN - 1):2] csr_pmp20addr;
wire [7:0] csr_pmp20cfg;
wire [(PALEN - 1):2] csr_pmp21addr;
wire [7:0] csr_pmp21cfg;
wire [(PALEN - 1):2] csr_pmp22addr;
wire [7:0] csr_pmp22cfg;
wire [(PALEN - 1):2] csr_pmp23addr;
wire [7:0] csr_pmp23cfg;
wire [(PALEN - 1):2] csr_pmp24addr;
wire [7:0] csr_pmp24cfg;
wire [(PALEN - 1):2] csr_pmp25addr;
wire [7:0] csr_pmp25cfg;
wire [(PALEN - 1):2] csr_pmp26addr;
wire [7:0] csr_pmp26cfg;
wire [(PALEN - 1):2] csr_pmp27addr;
wire [7:0] csr_pmp27cfg;
wire [(PALEN - 1):2] csr_pmp28addr;
wire [7:0] csr_pmp28cfg;
wire [(PALEN - 1):2] csr_pmp29addr;
wire [7:0] csr_pmp29cfg;
wire [(PALEN - 1):2] csr_pmp2addr;
wire [7:0] csr_pmp2cfg;
wire [(PALEN - 1):2] csr_pmp30addr;
wire [7:0] csr_pmp30cfg;
wire [(PALEN - 1):2] csr_pmp31addr;
wire [7:0] csr_pmp31cfg;
wire [(PALEN - 1):2] csr_pmp3addr;
wire [7:0] csr_pmp3cfg;
wire [(PALEN - 1):2] csr_pmp4addr;
wire [7:0] csr_pmp4cfg;
wire [(PALEN - 1):2] csr_pmp5addr;
wire [7:0] csr_pmp5cfg;
wire [(PALEN - 1):2] csr_pmp6addr;
wire [7:0] csr_pmp6cfg;
wire [(PALEN - 1):2] csr_pmp7addr;
wire [7:0] csr_pmp7cfg;
wire [(PALEN - 1):2] csr_pmp8addr;
wire [7:0] csr_pmp8cfg;
wire [(PALEN - 1):2] csr_pmp9addr;
wire [7:0] csr_pmp9cfg;
wire reg_pmp_we;
generate
    if (PMP_ENTRIES == 0) begin:gen_no_pmp
        assign pmp_ifu_resp_fault = 1'b0;
        assign pmp_lsu_resp_fault = 1'b0;
        assign nds_unused_pmp_ifu_resp_permission = 4'b0;
        assign nds_unused_pmp_lsu_resp_permission = 4'b0;
        wire [(PALEN - 1):0] s0 = ifu_pmp_req_pa;
        wire nds_unused_csr_dcsr_mprven = csr_dcsr_mprven;
        wire nds_unused_csr_halt_mode = csr_halt_mode;
        wire [1:0] nds_unused_csr_mstatus_mpp = csr_mstatus_mpp;
        wire nds_unused_csr_mstatus_mprv = csr_mstatus_mprv;
        wire nds_unused_core_clk = core_clk;
        wire nds_unused_core_reset_n = core_reset_n;
        wire [1:0] nds_unused_csr_cur_privilege = csr_cur_privilege;
        wire [(PALEN - 1):0] s1 = lsu_pmp_req_pa;
        wire nds_unused_lsu_pmp_req_store = lsu_pmp_req_store;
        wire [11:0] nds_unused_csr_pmp_raddr0 = csr_pmp_raddr0;
        wire [11:0] nds_unused_csr_pmp_raddr1 = csr_pmp_raddr1;
        wire [11:0] nds_unused_csr_pmp_waddr = csr_pmp_waddr;
        wire [31:0] nds_unused_csr_pmp_wdata = csr_pmp_wdata;
        wire nds_unused_csr_pmp_we = csr_pmp_we;
        wire [(PALEN - 1):2] s2 = csr_pmp0addr;
        wire [7:0] nds_unused_csr_pmp0cfg = csr_pmp0cfg;
        wire [(PALEN - 1):2] s3 = csr_pmp1addr;
        wire [7:0] nds_unused_csr_pmp1cfg = csr_pmp1cfg;
        wire [(PALEN - 1):2] s4 = csr_pmp2addr;
        wire [7:0] nds_unused_csr_pmp2cfg = csr_pmp2cfg;
        wire [(PALEN - 1):2] s5 = csr_pmp3addr;
        wire [7:0] nds_unused_csr_pmp3cfg = csr_pmp3cfg;
        wire [(PALEN - 1):2] s6 = csr_pmp4addr;
        wire [7:0] nds_unused_csr_pmp4cfg = csr_pmp4cfg;
        wire [(PALEN - 1):2] s7 = csr_pmp5addr;
        wire [7:0] nds_unused_csr_pmp5cfg = csr_pmp5cfg;
        wire [(PALEN - 1):2] s8 = csr_pmp6addr;
        wire [7:0] nds_unused_csr_pmp6cfg = csr_pmp6cfg;
        wire [(PALEN - 1):2] s9 = csr_pmp7addr;
        wire [7:0] nds_unused_csr_pmp7cfg = csr_pmp7cfg;
        wire [(PALEN - 1):2] s10 = csr_pmp8addr;
        wire [7:0] nds_unused_csr_pmp8cfg = csr_pmp8cfg;
        wire [(PALEN - 1):2] s11 = csr_pmp9addr;
        wire [7:0] nds_unused_csr_pmp9cfg = csr_pmp9cfg;
        wire [(PALEN - 1):2] s12 = csr_pmp10addr;
        wire [7:0] nds_unused_csr_pmp10cfg = csr_pmp10cfg;
        wire [(PALEN - 1):2] s13 = csr_pmp11addr;
        wire [7:0] nds_unused_csr_pmp11cfg = csr_pmp11cfg;
        wire [(PALEN - 1):2] s14 = csr_pmp12addr;
        wire [7:0] nds_unused_csr_pmp12cfg = csr_pmp12cfg;
        wire [(PALEN - 1):2] s15 = csr_pmp13addr;
        wire [7:0] nds_unused_csr_pmp13cfg = csr_pmp13cfg;
        wire [(PALEN - 1):2] s16 = csr_pmp14addr;
        wire [7:0] nds_unused_csr_pmp14cfg = csr_pmp14cfg;
        wire [(PALEN - 1):2] s17 = csr_pmp15addr;
        wire [7:0] nds_unused_csr_pmp15cfg = csr_pmp15cfg;
        wire [(PALEN - 1):2] s18 = csr_pmp16addr;
        wire [7:0] nds_unused_csr_pmp16cfg = csr_pmp16cfg;
        wire [(PALEN - 1):2] s19 = csr_pmp17addr;
        wire [7:0] nds_unused_csr_pmp17cfg = csr_pmp17cfg;
        wire [(PALEN - 1):2] s20 = csr_pmp18addr;
        wire [7:0] nds_unused_csr_pmp18cfg = csr_pmp18cfg;
        wire [(PALEN - 1):2] s21 = csr_pmp19addr;
        wire [7:0] nds_unused_csr_pmp19cfg = csr_pmp19cfg;
        wire [(PALEN - 1):2] s22 = csr_pmp20addr;
        wire [7:0] nds_unused_csr_pmp20cfg = csr_pmp20cfg;
        wire [(PALEN - 1):2] s23 = csr_pmp21addr;
        wire [7:0] nds_unused_csr_pmp21cfg = csr_pmp21cfg;
        wire [(PALEN - 1):2] s24 = csr_pmp22addr;
        wire [7:0] nds_unused_csr_pmp22cfg = csr_pmp22cfg;
        wire [(PALEN - 1):2] s25 = csr_pmp23addr;
        wire [7:0] nds_unused_csr_pmp23cfg = csr_pmp23cfg;
        wire [(PALEN - 1):2] s26 = csr_pmp24addr;
        wire [7:0] nds_unused_csr_pmp24cfg = csr_pmp24cfg;
        wire [(PALEN - 1):2] s27 = csr_pmp25addr;
        wire [7:0] nds_unused_csr_pmp25cfg = csr_pmp25cfg;
        wire [(PALEN - 1):2] s28 = csr_pmp26addr;
        wire [7:0] nds_unused_csr_pmp26cfg = csr_pmp26cfg;
        wire [(PALEN - 1):2] s29 = csr_pmp27addr;
        wire [7:0] nds_unused_csr_pmp27cfg = csr_pmp27cfg;
        wire [(PALEN - 1):2] s30 = csr_pmp28addr;
        wire [7:0] nds_unused_csr_pmp28cfg = csr_pmp28cfg;
        wire [(PALEN - 1):2] s31 = csr_pmp29addr;
        wire [7:0] nds_unused_csr_pmp29cfg = csr_pmp29cfg;
        wire [(PALEN - 1):2] s32 = csr_pmp30addr;
        wire [7:0] nds_unused_csr_pmp30cfg = csr_pmp30cfg;
        wire [(PALEN - 1):2] s33 = csr_pmp31addr;
        wire [7:0] nds_unused_csr_pmp31cfg = csr_pmp31cfg;
        wire nds_unused_reg_pmp_we = reg_pmp_we;
    end
endgenerate
assign nds_unused_vpu_pmp_resp_fault = 1'b0;
assign vpu_pmp_resp_permission = 4'b0;
wire [PALEN - 1:0] s34 = vpu_pmp_req_pa;
kv_pmp_csr #(
    .PALEN(PALEN),
    .PMP_ENTRIES(PMP_ENTRIES),
    .PMP_GRANULARITY(PMP_GRANULARITY)
) u_pmp_csr (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_cur_privilege(csr_cur_privilege),
    .csr_pmp_we(csr_pmp_we),
    .csr_pmp_waddr(csr_pmp_waddr),
    .csr_pmp_raddr0(csr_pmp_raddr0),
    .csr_pmp_raddr1(csr_pmp_raddr1),
    .csr_pmp_wdata(csr_pmp_wdata),
    .pmp_csr_hit0(pmp_csr_hit0),
    .pmp_csr_hit1(pmp_csr_hit1),
    .pmp_csr_rdata0(pmp_csr_rdata0),
    .pmp_csr_rdata1(pmp_csr_rdata1),
    .csr_pmp0cfg(csr_pmp0cfg),
    .csr_pmp1cfg(csr_pmp1cfg),
    .csr_pmp2cfg(csr_pmp2cfg),
    .csr_pmp3cfg(csr_pmp3cfg),
    .csr_pmp4cfg(csr_pmp4cfg),
    .csr_pmp5cfg(csr_pmp5cfg),
    .csr_pmp6cfg(csr_pmp6cfg),
    .csr_pmp7cfg(csr_pmp7cfg),
    .csr_pmp8cfg(csr_pmp8cfg),
    .csr_pmp9cfg(csr_pmp9cfg),
    .csr_pmp10cfg(csr_pmp10cfg),
    .csr_pmp11cfg(csr_pmp11cfg),
    .csr_pmp12cfg(csr_pmp12cfg),
    .csr_pmp13cfg(csr_pmp13cfg),
    .csr_pmp14cfg(csr_pmp14cfg),
    .csr_pmp15cfg(csr_pmp15cfg),
    .csr_pmp16cfg(csr_pmp16cfg),
    .csr_pmp17cfg(csr_pmp17cfg),
    .csr_pmp18cfg(csr_pmp18cfg),
    .csr_pmp19cfg(csr_pmp19cfg),
    .csr_pmp20cfg(csr_pmp20cfg),
    .csr_pmp21cfg(csr_pmp21cfg),
    .csr_pmp22cfg(csr_pmp22cfg),
    .csr_pmp23cfg(csr_pmp23cfg),
    .csr_pmp24cfg(csr_pmp24cfg),
    .csr_pmp25cfg(csr_pmp25cfg),
    .csr_pmp26cfg(csr_pmp26cfg),
    .csr_pmp27cfg(csr_pmp27cfg),
    .csr_pmp28cfg(csr_pmp28cfg),
    .csr_pmp29cfg(csr_pmp29cfg),
    .csr_pmp30cfg(csr_pmp30cfg),
    .csr_pmp31cfg(csr_pmp31cfg),
    .csr_pmp0addr(csr_pmp0addr),
    .csr_pmp1addr(csr_pmp1addr),
    .csr_pmp2addr(csr_pmp2addr),
    .csr_pmp3addr(csr_pmp3addr),
    .csr_pmp4addr(csr_pmp4addr),
    .csr_pmp5addr(csr_pmp5addr),
    .csr_pmp6addr(csr_pmp6addr),
    .csr_pmp7addr(csr_pmp7addr),
    .csr_pmp8addr(csr_pmp8addr),
    .csr_pmp9addr(csr_pmp9addr),
    .csr_pmp10addr(csr_pmp10addr),
    .csr_pmp11addr(csr_pmp11addr),
    .csr_pmp12addr(csr_pmp12addr),
    .csr_pmp13addr(csr_pmp13addr),
    .csr_pmp14addr(csr_pmp14addr),
    .csr_pmp15addr(csr_pmp15addr),
    .csr_pmp16addr(csr_pmp16addr),
    .csr_pmp17addr(csr_pmp17addr),
    .csr_pmp18addr(csr_pmp18addr),
    .csr_pmp19addr(csr_pmp19addr),
    .csr_pmp20addr(csr_pmp20addr),
    .csr_pmp21addr(csr_pmp21addr),
    .csr_pmp22addr(csr_pmp22addr),
    .csr_pmp23addr(csr_pmp23addr),
    .csr_pmp24addr(csr_pmp24addr),
    .csr_pmp25addr(csr_pmp25addr),
    .csr_pmp26addr(csr_pmp26addr),
    .csr_pmp27addr(csr_pmp27addr),
    .csr_pmp28addr(csr_pmp28addr),
    .csr_pmp29addr(csr_pmp29addr),
    .csr_pmp30addr(csr_pmp30addr),
    .csr_pmp31addr(csr_pmp31addr),
    .reg_pmp_we(reg_pmp_we)
);
generate
    if (PMP_ENTRIES != 0) begin:gen_pmp
        kv_pmp_cfg #(
            .DEBUG_VEC(DEBUG_VEC),
            .PALEN(PALEN),
            .PMP_ENTRIES(PMP_ENTRIES),
            .PMP_GRANULARITY(PMP_GRANULARITY),
            .PMP_TYPE_INT(1)
        ) u_pmp_cfg_ifu (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .reg_pmp_we(reg_pmp_we),
            .csr_pmp0cfg(csr_pmp0cfg),
            .csr_pmp1cfg(csr_pmp1cfg),
            .csr_pmp2cfg(csr_pmp2cfg),
            .csr_pmp3cfg(csr_pmp3cfg),
            .csr_pmp4cfg(csr_pmp4cfg),
            .csr_pmp5cfg(csr_pmp5cfg),
            .csr_pmp6cfg(csr_pmp6cfg),
            .csr_pmp7cfg(csr_pmp7cfg),
            .csr_pmp8cfg(csr_pmp8cfg),
            .csr_pmp9cfg(csr_pmp9cfg),
            .csr_pmp10cfg(csr_pmp10cfg),
            .csr_pmp11cfg(csr_pmp11cfg),
            .csr_pmp12cfg(csr_pmp12cfg),
            .csr_pmp13cfg(csr_pmp13cfg),
            .csr_pmp14cfg(csr_pmp14cfg),
            .csr_pmp15cfg(csr_pmp15cfg),
            .csr_pmp16cfg(csr_pmp16cfg),
            .csr_pmp17cfg(csr_pmp17cfg),
            .csr_pmp18cfg(csr_pmp18cfg),
            .csr_pmp19cfg(csr_pmp19cfg),
            .csr_pmp20cfg(csr_pmp20cfg),
            .csr_pmp21cfg(csr_pmp21cfg),
            .csr_pmp22cfg(csr_pmp22cfg),
            .csr_pmp23cfg(csr_pmp23cfg),
            .csr_pmp24cfg(csr_pmp24cfg),
            .csr_pmp25cfg(csr_pmp25cfg),
            .csr_pmp26cfg(csr_pmp26cfg),
            .csr_pmp27cfg(csr_pmp27cfg),
            .csr_pmp28cfg(csr_pmp28cfg),
            .csr_pmp29cfg(csr_pmp29cfg),
            .csr_pmp30cfg(csr_pmp30cfg),
            .csr_pmp31cfg(csr_pmp31cfg),
            .csr_pmp0addr(csr_pmp0addr),
            .csr_pmp1addr(csr_pmp1addr),
            .csr_pmp2addr(csr_pmp2addr),
            .csr_pmp3addr(csr_pmp3addr),
            .csr_pmp4addr(csr_pmp4addr),
            .csr_pmp5addr(csr_pmp5addr),
            .csr_pmp6addr(csr_pmp6addr),
            .csr_pmp7addr(csr_pmp7addr),
            .csr_pmp8addr(csr_pmp8addr),
            .csr_pmp9addr(csr_pmp9addr),
            .csr_pmp10addr(csr_pmp10addr),
            .csr_pmp11addr(csr_pmp11addr),
            .csr_pmp12addr(csr_pmp12addr),
            .csr_pmp13addr(csr_pmp13addr),
            .csr_pmp14addr(csr_pmp14addr),
            .csr_pmp15addr(csr_pmp15addr),
            .csr_pmp16addr(csr_pmp16addr),
            .csr_pmp17addr(csr_pmp17addr),
            .csr_pmp18addr(csr_pmp18addr),
            .csr_pmp19addr(csr_pmp19addr),
            .csr_pmp20addr(csr_pmp20addr),
            .csr_pmp21addr(csr_pmp21addr),
            .csr_pmp22addr(csr_pmp22addr),
            .csr_pmp23addr(csr_pmp23addr),
            .csr_pmp24addr(csr_pmp24addr),
            .csr_pmp25addr(csr_pmp25addr),
            .csr_pmp26addr(csr_pmp26addr),
            .csr_pmp27addr(csr_pmp27addr),
            .csr_pmp28addr(csr_pmp28addr),
            .csr_pmp29addr(csr_pmp29addr),
            .csr_pmp30addr(csr_pmp30addr),
            .csr_pmp31addr(csr_pmp31addr),
            .csr_cur_privilege(csr_cur_privilege),
            .csr_mstatus_mpp(csr_mstatus_mpp),
            .csr_mstatus_mprv(csr_mstatus_mprv),
            .csr_dcsr_mprven(csr_dcsr_mprven),
            .csr_halt_mode(csr_halt_mode),
            .pmp_req_pa(ifu_pmp_req_pa),
            .pmp_req_up_pa({PALEN{1'b0}}),
            .pmp_req_exec(1'b1),
            .pmp_req_store(1'b0),
            .pmp_req_vector_access(1'b0),
            .pmp_resp_fault(pmp_ifu_resp_fault),
            .pmp_resp_permission(nds_unused_pmp_ifu_resp_permission)
        );
        kv_pmp_cfg #(
            .DEBUG_VEC(DEBUG_VEC),
            .PALEN(PALEN),
            .PMP_ENTRIES(PMP_ENTRIES),
            .PMP_GRANULARITY(PMP_GRANULARITY),
            .PMP_TYPE_INT(0)
        ) u_pmp_cfg_lsu (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .reg_pmp_we(reg_pmp_we),
            .csr_pmp0cfg(csr_pmp0cfg),
            .csr_pmp1cfg(csr_pmp1cfg),
            .csr_pmp2cfg(csr_pmp2cfg),
            .csr_pmp3cfg(csr_pmp3cfg),
            .csr_pmp4cfg(csr_pmp4cfg),
            .csr_pmp5cfg(csr_pmp5cfg),
            .csr_pmp6cfg(csr_pmp6cfg),
            .csr_pmp7cfg(csr_pmp7cfg),
            .csr_pmp8cfg(csr_pmp8cfg),
            .csr_pmp9cfg(csr_pmp9cfg),
            .csr_pmp10cfg(csr_pmp10cfg),
            .csr_pmp11cfg(csr_pmp11cfg),
            .csr_pmp12cfg(csr_pmp12cfg),
            .csr_pmp13cfg(csr_pmp13cfg),
            .csr_pmp14cfg(csr_pmp14cfg),
            .csr_pmp15cfg(csr_pmp15cfg),
            .csr_pmp16cfg(csr_pmp16cfg),
            .csr_pmp17cfg(csr_pmp17cfg),
            .csr_pmp18cfg(csr_pmp18cfg),
            .csr_pmp19cfg(csr_pmp19cfg),
            .csr_pmp20cfg(csr_pmp20cfg),
            .csr_pmp21cfg(csr_pmp21cfg),
            .csr_pmp22cfg(csr_pmp22cfg),
            .csr_pmp23cfg(csr_pmp23cfg),
            .csr_pmp24cfg(csr_pmp24cfg),
            .csr_pmp25cfg(csr_pmp25cfg),
            .csr_pmp26cfg(csr_pmp26cfg),
            .csr_pmp27cfg(csr_pmp27cfg),
            .csr_pmp28cfg(csr_pmp28cfg),
            .csr_pmp29cfg(csr_pmp29cfg),
            .csr_pmp30cfg(csr_pmp30cfg),
            .csr_pmp31cfg(csr_pmp31cfg),
            .csr_pmp0addr(csr_pmp0addr),
            .csr_pmp1addr(csr_pmp1addr),
            .csr_pmp2addr(csr_pmp2addr),
            .csr_pmp3addr(csr_pmp3addr),
            .csr_pmp4addr(csr_pmp4addr),
            .csr_pmp5addr(csr_pmp5addr),
            .csr_pmp6addr(csr_pmp6addr),
            .csr_pmp7addr(csr_pmp7addr),
            .csr_pmp8addr(csr_pmp8addr),
            .csr_pmp9addr(csr_pmp9addr),
            .csr_pmp10addr(csr_pmp10addr),
            .csr_pmp11addr(csr_pmp11addr),
            .csr_pmp12addr(csr_pmp12addr),
            .csr_pmp13addr(csr_pmp13addr),
            .csr_pmp14addr(csr_pmp14addr),
            .csr_pmp15addr(csr_pmp15addr),
            .csr_pmp16addr(csr_pmp16addr),
            .csr_pmp17addr(csr_pmp17addr),
            .csr_pmp18addr(csr_pmp18addr),
            .csr_pmp19addr(csr_pmp19addr),
            .csr_pmp20addr(csr_pmp20addr),
            .csr_pmp21addr(csr_pmp21addr),
            .csr_pmp22addr(csr_pmp22addr),
            .csr_pmp23addr(csr_pmp23addr),
            .csr_pmp24addr(csr_pmp24addr),
            .csr_pmp25addr(csr_pmp25addr),
            .csr_pmp26addr(csr_pmp26addr),
            .csr_pmp27addr(csr_pmp27addr),
            .csr_pmp28addr(csr_pmp28addr),
            .csr_pmp29addr(csr_pmp29addr),
            .csr_pmp30addr(csr_pmp30addr),
            .csr_pmp31addr(csr_pmp31addr),
            .csr_cur_privilege(csr_cur_privilege),
            .csr_mstatus_mpp(csr_mstatus_mpp),
            .csr_mstatus_mprv(csr_mstatus_mprv),
            .csr_dcsr_mprven(csr_dcsr_mprven),
            .csr_halt_mode(csr_halt_mode),
            .pmp_req_pa(lsu_pmp_req_pa),
            .pmp_req_up_pa({PALEN{1'b0}}),
            .pmp_req_exec(1'b0),
            .pmp_req_store(lsu_pmp_req_store),
            .pmp_req_vector_access(1'b0),
            .pmp_resp_fault(pmp_lsu_resp_fault),
            .pmp_resp_permission(nds_unused_pmp_lsu_resp_permission)
        );
    end
endgenerate
endmodule

