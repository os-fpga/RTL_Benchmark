// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pma (
    ifu_pma_req_pa,
    pma_ifu_resp_fault,
    pma_ifu_resp_mtype,
    core_clk,
    core_reset_n,
    lsu_pma_req_pa,
    pma_lsu_resp_fault,
    pma_lsu_resp_mtype,
    pma_lsu_resp_namo,
    vpu_pma_req_pa,
    vpu_pma_resp_fault,
    vpu_pma_resp_mtype,
    csr_cur_privilege,
    csr_pma_raddr0,
    csr_pma_raddr1,
    csr_pma_waddr,
    csr_pma_wdata,
    csr_pma_we,
    pma_csr_hit0,
    pma_csr_hit1,
    pma_csr_rdata0,
    pma_csr_rdata1
);
parameter PALEN = 56;
parameter PMA_ENTRIES = 0;
parameter CLUSTER_SUPPORT_INT = 0;
parameter DEVICE_REGION0_BASE = 64'h00000000_80000000;
parameter DEVICE_REGION0_MASK = 64'h00000000_80000000;
parameter DEVICE_REGION1_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION1_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION2_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION2_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION3_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION3_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION4_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION4_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION5_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION5_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION6_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION6_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION7_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION7_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION0_BASE = 64'h00000000_40000000;
parameter WRITETHROUGH_REGION0_MASK = 64'h00000000_c0000000;
parameter WRITETHROUGH_REGION1_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION1_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION2_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION2_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION3_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION3_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION4_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION4_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION5_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION5_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION6_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION6_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION7_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION7_MASK = 64'h00000000_00000000;
input [(PALEN - 1):0] ifu_pma_req_pa;
output pma_ifu_resp_fault;
output [3:0] pma_ifu_resp_mtype;
input core_clk;
input core_reset_n;
input [(PALEN - 1):0] lsu_pma_req_pa;
output pma_lsu_resp_fault;
output [3:0] pma_lsu_resp_mtype;
output pma_lsu_resp_namo;
input [PALEN - 1:0] vpu_pma_req_pa;
output vpu_pma_resp_fault;
output [3:0] vpu_pma_resp_mtype;
input [1:0] csr_cur_privilege;
input [11:0] csr_pma_raddr0;
input [11:0] csr_pma_raddr1;
input [11:0] csr_pma_waddr;
input [31:0] csr_pma_wdata;
input csr_pma_we;
output pma_csr_hit0;
output pma_csr_hit1;
output [31:0] pma_csr_rdata0;
output [31:0] pma_csr_rdata1;


wire nds_unused_pma_ifu_resp_namo;
wire nds_unused_vpu_pma_resp_namo;
wire [(PALEN - 1):2] csr_pma0addr;
wire [7:0] csr_pma0cfg;
wire [(PALEN - 1):2] csr_pma10addr;
wire [7:0] csr_pma10cfg;
wire [(PALEN - 1):2] csr_pma11addr;
wire [7:0] csr_pma11cfg;
wire [(PALEN - 1):2] csr_pma12addr;
wire [7:0] csr_pma12cfg;
wire [(PALEN - 1):2] csr_pma13addr;
wire [7:0] csr_pma13cfg;
wire [(PALEN - 1):2] csr_pma14addr;
wire [7:0] csr_pma14cfg;
wire [(PALEN - 1):2] csr_pma15addr;
wire [7:0] csr_pma15cfg;
wire [(PALEN - 1):2] csr_pma1addr;
wire [7:0] csr_pma1cfg;
wire [(PALEN - 1):2] csr_pma2addr;
wire [7:0] csr_pma2cfg;
wire [(PALEN - 1):2] csr_pma3addr;
wire [7:0] csr_pma3cfg;
wire [(PALEN - 1):2] csr_pma4addr;
wire [7:0] csr_pma4cfg;
wire [(PALEN - 1):2] csr_pma5addr;
wire [7:0] csr_pma5cfg;
wire [(PALEN - 1):2] csr_pma6addr;
wire [7:0] csr_pma6cfg;
wire [(PALEN - 1):2] csr_pma7addr;
wire [7:0] csr_pma7cfg;
wire [(PALEN - 1):2] csr_pma8addr;
wire [7:0] csr_pma8cfg;
wire [(PALEN - 1):2] csr_pma9addr;
wire [7:0] csr_pma9cfg;
wire reg_pma_we;
assign vpu_pma_resp_fault = 1'b0;
assign vpu_pma_resp_mtype = 4'b0;
assign nds_unused_vpu_pma_resp_namo = 1'b0;
wire [(PALEN - 1):0] s0 = vpu_pma_req_pa;
kv_pma_csr #(
    .CLUSTER_SUPPORT_INT(CLUSTER_SUPPORT_INT),
    .PALEN(PALEN),
    .PMA_ENTRIES(PMA_ENTRIES)
) u_pma_csr (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_cur_privilege(csr_cur_privilege),
    .csr_pma_we(csr_pma_we),
    .csr_pma_waddr(csr_pma_waddr),
    .csr_pma_raddr0(csr_pma_raddr0),
    .csr_pma_raddr1(csr_pma_raddr1),
    .csr_pma_wdata(csr_pma_wdata),
    .pma_csr_hit0(pma_csr_hit0),
    .pma_csr_hit1(pma_csr_hit1),
    .pma_csr_rdata0(pma_csr_rdata0),
    .pma_csr_rdata1(pma_csr_rdata1),
    .csr_pma0cfg(csr_pma0cfg),
    .csr_pma1cfg(csr_pma1cfg),
    .csr_pma2cfg(csr_pma2cfg),
    .csr_pma3cfg(csr_pma3cfg),
    .csr_pma4cfg(csr_pma4cfg),
    .csr_pma5cfg(csr_pma5cfg),
    .csr_pma6cfg(csr_pma6cfg),
    .csr_pma7cfg(csr_pma7cfg),
    .csr_pma8cfg(csr_pma8cfg),
    .csr_pma9cfg(csr_pma9cfg),
    .csr_pma10cfg(csr_pma10cfg),
    .csr_pma11cfg(csr_pma11cfg),
    .csr_pma12cfg(csr_pma12cfg),
    .csr_pma13cfg(csr_pma13cfg),
    .csr_pma14cfg(csr_pma14cfg),
    .csr_pma15cfg(csr_pma15cfg),
    .csr_pma0addr(csr_pma0addr),
    .csr_pma1addr(csr_pma1addr),
    .csr_pma2addr(csr_pma2addr),
    .csr_pma3addr(csr_pma3addr),
    .csr_pma4addr(csr_pma4addr),
    .csr_pma5addr(csr_pma5addr),
    .csr_pma6addr(csr_pma6addr),
    .csr_pma7addr(csr_pma7addr),
    .csr_pma8addr(csr_pma8addr),
    .csr_pma9addr(csr_pma9addr),
    .csr_pma10addr(csr_pma10addr),
    .csr_pma11addr(csr_pma11addr),
    .csr_pma12addr(csr_pma12addr),
    .csr_pma13addr(csr_pma13addr),
    .csr_pma14addr(csr_pma14addr),
    .csr_pma15addr(csr_pma15addr),
    .reg_pma_we(reg_pma_we)
);
kv_pma_cfg #(
    .CLUSTER_SUPPORT_INT(CLUSTER_SUPPORT_INT),
    .DEVICE_REGION0_BASE(DEVICE_REGION0_BASE),
    .DEVICE_REGION0_MASK(DEVICE_REGION0_MASK),
    .DEVICE_REGION1_BASE(DEVICE_REGION1_BASE),
    .DEVICE_REGION1_MASK(DEVICE_REGION1_MASK),
    .DEVICE_REGION2_BASE(DEVICE_REGION2_BASE),
    .DEVICE_REGION2_MASK(DEVICE_REGION2_MASK),
    .DEVICE_REGION3_BASE(DEVICE_REGION3_BASE),
    .DEVICE_REGION3_MASK(DEVICE_REGION3_MASK),
    .DEVICE_REGION4_BASE(DEVICE_REGION4_BASE),
    .DEVICE_REGION4_MASK(DEVICE_REGION4_MASK),
    .DEVICE_REGION5_BASE(DEVICE_REGION5_BASE),
    .DEVICE_REGION5_MASK(DEVICE_REGION5_MASK),
    .DEVICE_REGION6_BASE(DEVICE_REGION6_BASE),
    .DEVICE_REGION6_MASK(DEVICE_REGION6_MASK),
    .DEVICE_REGION7_BASE(DEVICE_REGION7_BASE),
    .DEVICE_REGION7_MASK(DEVICE_REGION7_MASK),
    .PALEN(PALEN),
    .PMA_ENTRIES(PMA_ENTRIES),
    .WRITETHROUGH_REGION0_BASE(WRITETHROUGH_REGION0_BASE),
    .WRITETHROUGH_REGION0_MASK(WRITETHROUGH_REGION0_MASK),
    .WRITETHROUGH_REGION1_BASE(WRITETHROUGH_REGION1_BASE),
    .WRITETHROUGH_REGION1_MASK(WRITETHROUGH_REGION1_MASK),
    .WRITETHROUGH_REGION2_BASE(WRITETHROUGH_REGION2_BASE),
    .WRITETHROUGH_REGION2_MASK(WRITETHROUGH_REGION2_MASK),
    .WRITETHROUGH_REGION3_BASE(WRITETHROUGH_REGION3_BASE),
    .WRITETHROUGH_REGION3_MASK(WRITETHROUGH_REGION3_MASK),
    .WRITETHROUGH_REGION4_BASE(WRITETHROUGH_REGION4_BASE),
    .WRITETHROUGH_REGION4_MASK(WRITETHROUGH_REGION4_MASK),
    .WRITETHROUGH_REGION5_BASE(WRITETHROUGH_REGION5_BASE),
    .WRITETHROUGH_REGION5_MASK(WRITETHROUGH_REGION5_MASK),
    .WRITETHROUGH_REGION6_BASE(WRITETHROUGH_REGION6_BASE),
    .WRITETHROUGH_REGION6_MASK(WRITETHROUGH_REGION6_MASK),
    .WRITETHROUGH_REGION7_BASE(WRITETHROUGH_REGION7_BASE),
    .WRITETHROUGH_REGION7_MASK(WRITETHROUGH_REGION7_MASK)
) u_pma_cfg_ifu (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .pma_req_pa(ifu_pma_req_pa),
    .reg_pma_we(reg_pma_we),
    .csr_pma0cfg(csr_pma0cfg),
    .csr_pma1cfg(csr_pma1cfg),
    .csr_pma2cfg(csr_pma2cfg),
    .csr_pma3cfg(csr_pma3cfg),
    .csr_pma4cfg(csr_pma4cfg),
    .csr_pma5cfg(csr_pma5cfg),
    .csr_pma6cfg(csr_pma6cfg),
    .csr_pma7cfg(csr_pma7cfg),
    .csr_pma8cfg(csr_pma8cfg),
    .csr_pma9cfg(csr_pma9cfg),
    .csr_pma10cfg(csr_pma10cfg),
    .csr_pma11cfg(csr_pma11cfg),
    .csr_pma12cfg(csr_pma12cfg),
    .csr_pma13cfg(csr_pma13cfg),
    .csr_pma14cfg(csr_pma14cfg),
    .csr_pma15cfg(csr_pma15cfg),
    .csr_pma0addr(csr_pma0addr),
    .csr_pma1addr(csr_pma1addr),
    .csr_pma2addr(csr_pma2addr),
    .csr_pma3addr(csr_pma3addr),
    .csr_pma4addr(csr_pma4addr),
    .csr_pma5addr(csr_pma5addr),
    .csr_pma6addr(csr_pma6addr),
    .csr_pma7addr(csr_pma7addr),
    .csr_pma8addr(csr_pma8addr),
    .csr_pma9addr(csr_pma9addr),
    .csr_pma10addr(csr_pma10addr),
    .csr_pma11addr(csr_pma11addr),
    .csr_pma12addr(csr_pma12addr),
    .csr_pma13addr(csr_pma13addr),
    .csr_pma14addr(csr_pma14addr),
    .csr_pma15addr(csr_pma15addr),
    .pma_resp_fault(pma_ifu_resp_fault),
    .pma_resp_mtype(pma_ifu_resp_mtype),
    .pma_resp_namo(nds_unused_pma_ifu_resp_namo)
);
kv_pma_cfg #(
    .CLUSTER_SUPPORT_INT(CLUSTER_SUPPORT_INT),
    .DEVICE_REGION0_BASE(DEVICE_REGION0_BASE),
    .DEVICE_REGION0_MASK(DEVICE_REGION0_MASK),
    .DEVICE_REGION1_BASE(DEVICE_REGION1_BASE),
    .DEVICE_REGION1_MASK(DEVICE_REGION1_MASK),
    .DEVICE_REGION2_BASE(DEVICE_REGION2_BASE),
    .DEVICE_REGION2_MASK(DEVICE_REGION2_MASK),
    .DEVICE_REGION3_BASE(DEVICE_REGION3_BASE),
    .DEVICE_REGION3_MASK(DEVICE_REGION3_MASK),
    .DEVICE_REGION4_BASE(DEVICE_REGION4_BASE),
    .DEVICE_REGION4_MASK(DEVICE_REGION4_MASK),
    .DEVICE_REGION5_BASE(DEVICE_REGION5_BASE),
    .DEVICE_REGION5_MASK(DEVICE_REGION5_MASK),
    .DEVICE_REGION6_BASE(DEVICE_REGION6_BASE),
    .DEVICE_REGION6_MASK(DEVICE_REGION6_MASK),
    .DEVICE_REGION7_BASE(DEVICE_REGION7_BASE),
    .DEVICE_REGION7_MASK(DEVICE_REGION7_MASK),
    .PALEN(PALEN),
    .PMA_ENTRIES(PMA_ENTRIES),
    .WRITETHROUGH_REGION0_BASE(WRITETHROUGH_REGION0_BASE),
    .WRITETHROUGH_REGION0_MASK(WRITETHROUGH_REGION0_MASK),
    .WRITETHROUGH_REGION1_BASE(WRITETHROUGH_REGION1_BASE),
    .WRITETHROUGH_REGION1_MASK(WRITETHROUGH_REGION1_MASK),
    .WRITETHROUGH_REGION2_BASE(WRITETHROUGH_REGION2_BASE),
    .WRITETHROUGH_REGION2_MASK(WRITETHROUGH_REGION2_MASK),
    .WRITETHROUGH_REGION3_BASE(WRITETHROUGH_REGION3_BASE),
    .WRITETHROUGH_REGION3_MASK(WRITETHROUGH_REGION3_MASK),
    .WRITETHROUGH_REGION4_BASE(WRITETHROUGH_REGION4_BASE),
    .WRITETHROUGH_REGION4_MASK(WRITETHROUGH_REGION4_MASK),
    .WRITETHROUGH_REGION5_BASE(WRITETHROUGH_REGION5_BASE),
    .WRITETHROUGH_REGION5_MASK(WRITETHROUGH_REGION5_MASK),
    .WRITETHROUGH_REGION6_BASE(WRITETHROUGH_REGION6_BASE),
    .WRITETHROUGH_REGION6_MASK(WRITETHROUGH_REGION6_MASK),
    .WRITETHROUGH_REGION7_BASE(WRITETHROUGH_REGION7_BASE),
    .WRITETHROUGH_REGION7_MASK(WRITETHROUGH_REGION7_MASK)
) u_pma_cfg_lsu (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .pma_req_pa(lsu_pma_req_pa),
    .reg_pma_we(reg_pma_we),
    .csr_pma0cfg(csr_pma0cfg),
    .csr_pma1cfg(csr_pma1cfg),
    .csr_pma2cfg(csr_pma2cfg),
    .csr_pma3cfg(csr_pma3cfg),
    .csr_pma4cfg(csr_pma4cfg),
    .csr_pma5cfg(csr_pma5cfg),
    .csr_pma6cfg(csr_pma6cfg),
    .csr_pma7cfg(csr_pma7cfg),
    .csr_pma8cfg(csr_pma8cfg),
    .csr_pma9cfg(csr_pma9cfg),
    .csr_pma10cfg(csr_pma10cfg),
    .csr_pma11cfg(csr_pma11cfg),
    .csr_pma12cfg(csr_pma12cfg),
    .csr_pma13cfg(csr_pma13cfg),
    .csr_pma14cfg(csr_pma14cfg),
    .csr_pma15cfg(csr_pma15cfg),
    .csr_pma0addr(csr_pma0addr),
    .csr_pma1addr(csr_pma1addr),
    .csr_pma2addr(csr_pma2addr),
    .csr_pma3addr(csr_pma3addr),
    .csr_pma4addr(csr_pma4addr),
    .csr_pma5addr(csr_pma5addr),
    .csr_pma6addr(csr_pma6addr),
    .csr_pma7addr(csr_pma7addr),
    .csr_pma8addr(csr_pma8addr),
    .csr_pma9addr(csr_pma9addr),
    .csr_pma10addr(csr_pma10addr),
    .csr_pma11addr(csr_pma11addr),
    .csr_pma12addr(csr_pma12addr),
    .csr_pma13addr(csr_pma13addr),
    .csr_pma14addr(csr_pma14addr),
    .csr_pma15addr(csr_pma15addr),
    .pma_resp_fault(pma_lsu_resp_fault),
    .pma_resp_mtype(pma_lsu_resp_mtype),
    .pma_resp_namo(pma_lsu_resp_namo)
);
endmodule

