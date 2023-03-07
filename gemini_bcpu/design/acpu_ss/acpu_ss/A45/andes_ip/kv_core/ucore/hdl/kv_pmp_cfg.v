// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pmp_cfg (
    core_clk,
    core_reset_n,
    reg_pmp_we,
    csr_pmp0cfg,
    csr_pmp1cfg,
    csr_pmp2cfg,
    csr_pmp3cfg,
    csr_pmp4cfg,
    csr_pmp5cfg,
    csr_pmp6cfg,
    csr_pmp7cfg,
    csr_pmp8cfg,
    csr_pmp9cfg,
    csr_pmp10cfg,
    csr_pmp11cfg,
    csr_pmp12cfg,
    csr_pmp13cfg,
    csr_pmp14cfg,
    csr_pmp15cfg,
    csr_pmp16cfg,
    csr_pmp17cfg,
    csr_pmp18cfg,
    csr_pmp19cfg,
    csr_pmp20cfg,
    csr_pmp21cfg,
    csr_pmp22cfg,
    csr_pmp23cfg,
    csr_pmp24cfg,
    csr_pmp25cfg,
    csr_pmp26cfg,
    csr_pmp27cfg,
    csr_pmp28cfg,
    csr_pmp29cfg,
    csr_pmp30cfg,
    csr_pmp31cfg,
    csr_pmp0addr,
    csr_pmp1addr,
    csr_pmp2addr,
    csr_pmp3addr,
    csr_pmp4addr,
    csr_pmp5addr,
    csr_pmp6addr,
    csr_pmp7addr,
    csr_pmp8addr,
    csr_pmp9addr,
    csr_pmp10addr,
    csr_pmp11addr,
    csr_pmp12addr,
    csr_pmp13addr,
    csr_pmp14addr,
    csr_pmp15addr,
    csr_pmp16addr,
    csr_pmp17addr,
    csr_pmp18addr,
    csr_pmp19addr,
    csr_pmp20addr,
    csr_pmp21addr,
    csr_pmp22addr,
    csr_pmp23addr,
    csr_pmp24addr,
    csr_pmp25addr,
    csr_pmp26addr,
    csr_pmp27addr,
    csr_pmp28addr,
    csr_pmp29addr,
    csr_pmp30addr,
    csr_pmp31addr,
    csr_cur_privilege,
    csr_mstatus_mpp,
    csr_mstatus_mprv,
    csr_dcsr_mprven,
    csr_halt_mode,
    pmp_req_pa,
    pmp_req_up_pa,
    pmp_req_exec,
    pmp_req_store,
    pmp_req_vector_access,
    pmp_resp_fault,
    pmp_resp_permission
);
parameter PMP_TYPE_INT = 1;
parameter PMP_ENTRIES = 1;
parameter PMP_GRANULARITY = 8;
parameter PALEN = 56;
parameter DEBUG_VEC = 64'h0000_0000;
localparam DEBUG_VEC_UBOUND = DEBUG_VEC + 64'h200;
localparam PMP_A_OFF = 2'b00;
localparam PMP_A_TOR = 2'b01;
localparam PMP_A_NA4 = 2'b10;
localparam PMP_A_NAPOT = 2'b11;
localparam PMPCFG_L = 7;
localparam PMPCFG_A_MSB = 4;
localparam PMPCFG_A_LSB = 3;
localparam PMPCFG_X = 2;
localparam PMPCFG_W = 1;
localparam PMPCFG_R = 0;
localparam PMPADDR_CHECK_LSB = $unsigned($clog2(PMP_GRANULARITY));
localparam PMP_TOUCH_DETECT_LSB = (PMP_GRANULARITY <= 512) ? 9 : PMPADDR_CHECK_LSB;
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_SUPERVISOR = 2'b01;
localparam PRIVILEGE_MACHINE = 2'b11;
input core_clk;
input core_reset_n;
input reg_pmp_we;
input [7:0] csr_pmp0cfg;
input [7:0] csr_pmp1cfg;
input [7:0] csr_pmp2cfg;
input [7:0] csr_pmp3cfg;
input [7:0] csr_pmp4cfg;
input [7:0] csr_pmp5cfg;
input [7:0] csr_pmp6cfg;
input [7:0] csr_pmp7cfg;
input [7:0] csr_pmp8cfg;
input [7:0] csr_pmp9cfg;
input [7:0] csr_pmp10cfg;
input [7:0] csr_pmp11cfg;
input [7:0] csr_pmp12cfg;
input [7:0] csr_pmp13cfg;
input [7:0] csr_pmp14cfg;
input [7:0] csr_pmp15cfg;
input [7:0] csr_pmp16cfg;
input [7:0] csr_pmp17cfg;
input [7:0] csr_pmp18cfg;
input [7:0] csr_pmp19cfg;
input [7:0] csr_pmp20cfg;
input [7:0] csr_pmp21cfg;
input [7:0] csr_pmp22cfg;
input [7:0] csr_pmp23cfg;
input [7:0] csr_pmp24cfg;
input [7:0] csr_pmp25cfg;
input [7:0] csr_pmp26cfg;
input [7:0] csr_pmp27cfg;
input [7:0] csr_pmp28cfg;
input [7:0] csr_pmp29cfg;
input [7:0] csr_pmp30cfg;
input [7:0] csr_pmp31cfg;
input [PALEN - 1:2] csr_pmp0addr;
input [PALEN - 1:2] csr_pmp1addr;
input [PALEN - 1:2] csr_pmp2addr;
input [PALEN - 1:2] csr_pmp3addr;
input [PALEN - 1:2] csr_pmp4addr;
input [PALEN - 1:2] csr_pmp5addr;
input [PALEN - 1:2] csr_pmp6addr;
input [PALEN - 1:2] csr_pmp7addr;
input [PALEN - 1:2] csr_pmp8addr;
input [PALEN - 1:2] csr_pmp9addr;
input [PALEN - 1:2] csr_pmp10addr;
input [PALEN - 1:2] csr_pmp11addr;
input [PALEN - 1:2] csr_pmp12addr;
input [PALEN - 1:2] csr_pmp13addr;
input [PALEN - 1:2] csr_pmp14addr;
input [PALEN - 1:2] csr_pmp15addr;
input [PALEN - 1:2] csr_pmp16addr;
input [PALEN - 1:2] csr_pmp17addr;
input [PALEN - 1:2] csr_pmp18addr;
input [PALEN - 1:2] csr_pmp19addr;
input [PALEN - 1:2] csr_pmp20addr;
input [PALEN - 1:2] csr_pmp21addr;
input [PALEN - 1:2] csr_pmp22addr;
input [PALEN - 1:2] csr_pmp23addr;
input [PALEN - 1:2] csr_pmp24addr;
input [PALEN - 1:2] csr_pmp25addr;
input [PALEN - 1:2] csr_pmp26addr;
input [PALEN - 1:2] csr_pmp27addr;
input [PALEN - 1:2] csr_pmp28addr;
input [PALEN - 1:2] csr_pmp29addr;
input [PALEN - 1:2] csr_pmp30addr;
input [PALEN - 1:2] csr_pmp31addr;
input [1:0] csr_cur_privilege;
input [1:0] csr_mstatus_mpp;
input csr_mstatus_mprv;
input csr_dcsr_mprven;
input csr_halt_mode;
input [PALEN - 1:0] pmp_req_pa;
input [PALEN - 1:0] pmp_req_up_pa;
input pmp_req_exec;
input pmp_req_store;
input pmp_req_vector_access;
output pmp_resp_fault;
output [3:0] pmp_resp_permission;


wire pmp_mmu_l;
wire pmp_mmu_x;
wire pmp_mmu_w;
wire pmp_mmu_r;
wire pmp_mmu_no_all_match;
wire pmp_mmode_en;
wire pmp_en;
wire [PALEN - 1:PMPADDR_CHECK_LSB - 1] pmp_addr_mask_nx[0:PMP_ENTRIES - 1];
wire [PALEN:PMPADDR_CHECK_LSB - 1] csr_pmp_addr_add1[0:PMP_ENTRIES - 1];
reg [PALEN - 1:PMPADDR_CHECK_LSB - 1] pmp_addr_mask[0:PMP_ENTRIES - 1];
wire [31:0] pmp_entry_valid;
wire [PMP_ENTRIES - 1:0] pmp_napot_valid;
wire [PMP_ENTRIES - 1:0] pmp_tor_valid;
wire pmp_permit_all;
wire pmp_permit_halt_mode;
wire [31:0] pmp_entry_up_valid;
wire [31:0] pmp_touch_512;
wire [31:0] pmp_entry_hit;
wire [31:0] pmp_entry_no_all_match;
wire [1:0] csr_pmp0cfg_a = csr_pmp0cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp1cfg_a = csr_pmp1cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp2cfg_a = csr_pmp2cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp3cfg_a = csr_pmp3cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp4cfg_a = csr_pmp4cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp5cfg_a = csr_pmp5cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp6cfg_a = csr_pmp6cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp7cfg_a = csr_pmp7cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp8cfg_a = csr_pmp8cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp9cfg_a = csr_pmp9cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp10cfg_a = csr_pmp10cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp11cfg_a = csr_pmp11cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp12cfg_a = csr_pmp12cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp13cfg_a = csr_pmp13cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp14cfg_a = csr_pmp14cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp15cfg_a = csr_pmp15cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp16cfg_a = csr_pmp16cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp17cfg_a = csr_pmp17cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp18cfg_a = csr_pmp18cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp19cfg_a = csr_pmp19cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp20cfg_a = csr_pmp20cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp21cfg_a = csr_pmp21cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp22cfg_a = csr_pmp22cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp23cfg_a = csr_pmp23cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp24cfg_a = csr_pmp24cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp25cfg_a = csr_pmp25cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp26cfg_a = csr_pmp26cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp27cfg_a = csr_pmp27cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp28cfg_a = csr_pmp28cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp29cfg_a = csr_pmp29cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp30cfg_a = csr_pmp30cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
wire [1:0] csr_pmp31cfg_a = csr_pmp31cfg[PMPCFG_A_MSB:PMPCFG_A_LSB];
assign pmp_permit_all = (csr_pmp0cfg_a == PMP_A_NAPOT) & (csr_pmp0cfg[PMPCFG_X] == 1'b1) & (csr_pmp0cfg[PMPCFG_W] == 1'b1) & (csr_pmp0cfg[PMPCFG_R] == 1'b1) & (csr_pmp0addr[PALEN - 2:3] == {(PALEN - 4){1'b1}});
generate
    if (PMP_ENTRIES > 0) begin:gen_pmp_mmode_en
        reg pmp_mmode_en_reg;
        wire pmp_mmode_en_nx;
        assign pmp_mmode_en_nx = ~pmp_permit_all & (((csr_pmp0cfg_a != PMP_A_OFF) & csr_pmp0cfg[PMPCFG_L]) | ((csr_pmp1cfg_a != PMP_A_OFF) & csr_pmp1cfg[PMPCFG_L]) | ((csr_pmp2cfg_a != PMP_A_OFF) & csr_pmp2cfg[PMPCFG_L]) | ((csr_pmp3cfg_a != PMP_A_OFF) & csr_pmp3cfg[PMPCFG_L]) | ((csr_pmp4cfg_a != PMP_A_OFF) & csr_pmp4cfg[PMPCFG_L]) | ((csr_pmp5cfg_a != PMP_A_OFF) & csr_pmp5cfg[PMPCFG_L]) | ((csr_pmp6cfg_a != PMP_A_OFF) & csr_pmp6cfg[PMPCFG_L]) | ((csr_pmp7cfg_a != PMP_A_OFF) & csr_pmp7cfg[PMPCFG_L]) | ((csr_pmp8cfg_a != PMP_A_OFF) & csr_pmp8cfg[PMPCFG_L]) | ((csr_pmp9cfg_a != PMP_A_OFF) & csr_pmp9cfg[PMPCFG_L]) | ((csr_pmp10cfg_a != PMP_A_OFF) & csr_pmp10cfg[PMPCFG_L]) | ((csr_pmp11cfg_a != PMP_A_OFF) & csr_pmp11cfg[PMPCFG_L]) | ((csr_pmp12cfg_a != PMP_A_OFF) & csr_pmp12cfg[PMPCFG_L]) | ((csr_pmp13cfg_a != PMP_A_OFF) & csr_pmp13cfg[PMPCFG_L]) | ((csr_pmp14cfg_a != PMP_A_OFF) & csr_pmp14cfg[PMPCFG_L]) | ((csr_pmp15cfg_a != PMP_A_OFF) & csr_pmp15cfg[PMPCFG_L]) | ((csr_pmp16cfg_a != PMP_A_OFF) & csr_pmp16cfg[PMPCFG_L]) | ((csr_pmp17cfg_a != PMP_A_OFF) & csr_pmp17cfg[PMPCFG_L]) | ((csr_pmp18cfg_a != PMP_A_OFF) & csr_pmp18cfg[PMPCFG_L]) | ((csr_pmp19cfg_a != PMP_A_OFF) & csr_pmp19cfg[PMPCFG_L]) | ((csr_pmp20cfg_a != PMP_A_OFF) & csr_pmp20cfg[PMPCFG_L]) | ((csr_pmp21cfg_a != PMP_A_OFF) & csr_pmp21cfg[PMPCFG_L]) | ((csr_pmp22cfg_a != PMP_A_OFF) & csr_pmp22cfg[PMPCFG_L]) | ((csr_pmp23cfg_a != PMP_A_OFF) & csr_pmp23cfg[PMPCFG_L]) | ((csr_pmp24cfg_a != PMP_A_OFF) & csr_pmp24cfg[PMPCFG_L]) | ((csr_pmp25cfg_a != PMP_A_OFF) & csr_pmp25cfg[PMPCFG_L]) | ((csr_pmp26cfg_a != PMP_A_OFF) & csr_pmp26cfg[PMPCFG_L]) | ((csr_pmp27cfg_a != PMP_A_OFF) & csr_pmp27cfg[PMPCFG_L]) | ((csr_pmp28cfg_a != PMP_A_OFF) & csr_pmp28cfg[PMPCFG_L]) | ((csr_pmp29cfg_a != PMP_A_OFF) & csr_pmp29cfg[PMPCFG_L]) | ((csr_pmp30cfg_a != PMP_A_OFF) & csr_pmp30cfg[PMPCFG_L]) | ((csr_pmp31cfg_a != PMP_A_OFF) & csr_pmp31cfg[PMPCFG_L]));
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_mmode_en_reg <= 1'b0;
            end
            else if (reg_pmp_we) begin
                pmp_mmode_en_reg <= pmp_mmode_en_nx;
            end
        end

        assign pmp_mmode_en = pmp_mmode_en_reg;
    end
    else begin:gen_no_pmp_mmode_en
        assign pmp_mmode_en = 1'b0;
    end
endgenerate
generate
    if (PMP_ENTRIES > 0) begin:gen_pmp_smode_en
        reg pmp_en_reg;
        wire pmp_en_nx;
        assign pmp_en_nx = ~pmp_permit_all;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_en_reg <= 1'b1;
            end
            else if (reg_pmp_we) begin
                pmp_en_reg <= pmp_en_nx;
            end
        end

        assign pmp_en = pmp_en_reg;
    end
    else begin:gen_no_pmp_smode_en
        assign pmp_en = 1'b0;
    end
endgenerate
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        pmp_addr_mask[0] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
    end
    else if (reg_pmp_we) begin
        pmp_addr_mask[0] <= pmp_addr_mask_nx[0];
    end
end

assign pmp_tor_valid[0] = csr_pmp0addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB];
assign csr_pmp_addr_add1[0] = ({1'b0,csr_pmp0addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
assign pmp_addr_mask_nx[0] = csr_pmp_addr_add1[0][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp0addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
assign pmp_napot_valid[0] = ~(|(pmp_addr_mask[0][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp0addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
assign pmp_entry_valid[0] = (csr_pmp0cfg_a == PMP_A_TOR) ? pmp_tor_valid[0] : ((csr_pmp0cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[0] : 1'b0);
generate
    if (PMP_ENTRIES >= 2) begin:gen_pmp_entry_1
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[1] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[1] <= pmp_addr_mask_nx[1];
            end
        end

        assign pmp_tor_valid[1] = (csr_pmp1addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp0addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[1] = ({1'b0,csr_pmp1addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[1] = csr_pmp_addr_add1[1][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp1addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[1] = ~(|(pmp_addr_mask[1][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp1addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[1] = (csr_pmp1cfg_a == PMP_A_TOR) ? pmp_tor_valid[1] : ((csr_pmp1cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[1] : 1'b0);
    end
    else begin:gen_no_pmp_entry_1
        assign pmp_entry_valid[1] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp1addr = csr_pmp1addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 3) begin:gen_pmp_entry_2
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[2] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[2] <= pmp_addr_mask_nx[2];
            end
        end

        assign pmp_tor_valid[2] = (csr_pmp2addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp1addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[2] = ({1'b0,csr_pmp2addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[2] = csr_pmp_addr_add1[2][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp2addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[2] = ~(|(pmp_addr_mask[2][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp2addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[2] = (csr_pmp2cfg_a == PMP_A_TOR) ? pmp_tor_valid[2] : ((csr_pmp2cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[2] : 1'b0);
    end
    else begin:gen_no_pmp_entry_2
        assign pmp_entry_valid[2] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp2addr = csr_pmp2addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 4) begin:gen_pmp_entry_3
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[3] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[3] <= pmp_addr_mask_nx[3];
            end
        end

        assign pmp_tor_valid[3] = (csr_pmp3addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp2addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[3] = ({1'b0,csr_pmp3addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[3] = csr_pmp_addr_add1[3][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp3addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[3] = ~(|(pmp_addr_mask[3][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp3addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[3] = (csr_pmp3cfg_a == PMP_A_TOR) ? pmp_tor_valid[3] : ((csr_pmp3cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[3] : 1'b0);
    end
    else begin:gen_no_pmp_entry_3
        assign pmp_entry_valid[3] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp3addr = csr_pmp3addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 5) begin:gen_pmp_entry_4
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[4] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[4] <= pmp_addr_mask_nx[4];
            end
        end

        assign pmp_tor_valid[4] = (csr_pmp4addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp3addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[4] = ({1'b0,csr_pmp4addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[4] = csr_pmp_addr_add1[4][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp4addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[4] = ~(|(pmp_addr_mask[4][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp4addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[4] = (csr_pmp4cfg_a == PMP_A_TOR) ? pmp_tor_valid[4] : ((csr_pmp4cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[4] : 1'b0);
    end
    else begin:gen_no_pmp_entry_4
        assign pmp_entry_valid[4] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp4addr = csr_pmp4addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 6) begin:gen_pmp_entry_5
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[5] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[5] <= pmp_addr_mask_nx[5];
            end
        end

        assign pmp_tor_valid[5] = (csr_pmp5addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp4addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[5] = ({1'b0,csr_pmp5addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[5] = csr_pmp_addr_add1[5][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp5addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[5] = ~(|(pmp_addr_mask[5][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp5addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[5] = (csr_pmp5cfg_a == PMP_A_TOR) ? pmp_tor_valid[5] : ((csr_pmp5cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[5] : 1'b0);
    end
    else begin:gen_no_pmp_entry_5
        assign pmp_entry_valid[5] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp5addr = csr_pmp5addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 7) begin:gen_pmp_entry_6
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[6] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[6] <= pmp_addr_mask_nx[6];
            end
        end

        assign pmp_tor_valid[6] = (csr_pmp6addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp5addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[6] = ({1'b0,csr_pmp6addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[6] = csr_pmp_addr_add1[6][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp6addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[6] = ~(|(pmp_addr_mask[6][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp6addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[6] = (csr_pmp6cfg_a == PMP_A_TOR) ? pmp_tor_valid[6] : ((csr_pmp6cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[6] : 1'b0);
    end
    else begin:gen_no_pmp_entry_6
        assign pmp_entry_valid[6] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp6addr = csr_pmp6addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 8) begin:gen_pmp_entry_7
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[7] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[7] <= pmp_addr_mask_nx[7];
            end
        end

        assign pmp_tor_valid[7] = (csr_pmp7addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp6addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[7] = ({1'b0,csr_pmp7addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[7] = csr_pmp_addr_add1[7][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp7addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[7] = ~(|(pmp_addr_mask[7][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp7addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[7] = (csr_pmp7cfg_a == PMP_A_TOR) ? pmp_tor_valid[7] : ((csr_pmp7cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[7] : 1'b0);
    end
    else begin:gen_no_pmp_entry_7
        assign pmp_entry_valid[7] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp7addr = csr_pmp7addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 9) begin:gen_pmp_entry_8
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[8] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[8] <= pmp_addr_mask_nx[8];
            end
        end

        assign pmp_tor_valid[8] = (csr_pmp8addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp7addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[8] = ({1'b0,csr_pmp8addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[8] = csr_pmp_addr_add1[8][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp8addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[8] = ~(|(pmp_addr_mask[8][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp8addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[8] = (csr_pmp8cfg_a == PMP_A_TOR) ? pmp_tor_valid[8] : ((csr_pmp8cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[8] : 1'b0);
    end
    else begin:gen_no_pmp_entry_8
        assign pmp_entry_valid[8] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp8addr = csr_pmp8addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 10) begin:gen_pmp_entry_9
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[9] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[9] <= pmp_addr_mask_nx[9];
            end
        end

        assign pmp_tor_valid[9] = (csr_pmp9addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp8addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[9] = ({1'b0,csr_pmp9addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[9] = csr_pmp_addr_add1[9][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp9addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[9] = ~(|(pmp_addr_mask[9][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp9addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[9] = (csr_pmp9cfg_a == PMP_A_TOR) ? pmp_tor_valid[9] : ((csr_pmp9cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[9] : 1'b0);
    end
    else begin:gen_no_pmp_entry_9
        assign pmp_entry_valid[9] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp9addr = csr_pmp9addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 11) begin:gen_pmp_entry_10
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[10] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[10] <= pmp_addr_mask_nx[10];
            end
        end

        assign pmp_tor_valid[10] = (csr_pmp10addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp9addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[10] = ({1'b0,csr_pmp10addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[10] = csr_pmp_addr_add1[10][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp10addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[10] = ~(|(pmp_addr_mask[10][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp10addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[10] = (csr_pmp10cfg_a == PMP_A_TOR) ? pmp_tor_valid[10] : ((csr_pmp10cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[10] : 1'b0);
    end
    else begin:gen_no_pmp_entry_10
        assign pmp_entry_valid[10] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp10addr = csr_pmp10addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 12) begin:gen_pmp_entry_11
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[11] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[11] <= pmp_addr_mask_nx[11];
            end
        end

        assign pmp_tor_valid[11] = (csr_pmp11addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp10addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[11] = ({1'b0,csr_pmp11addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[11] = csr_pmp_addr_add1[11][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp11addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[11] = ~(|(pmp_addr_mask[11][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp11addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[11] = (csr_pmp11cfg_a == PMP_A_TOR) ? pmp_tor_valid[11] : ((csr_pmp11cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[11] : 1'b0);
    end
    else begin:gen_no_pmp_entry_11
        assign pmp_entry_valid[11] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp11addr = csr_pmp11addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 13) begin:gen_pmp_entry_12
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[12] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[12] <= pmp_addr_mask_nx[12];
            end
        end

        assign pmp_tor_valid[12] = (csr_pmp12addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp11addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[12] = ({1'b0,csr_pmp12addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[12] = csr_pmp_addr_add1[12][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp12addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[12] = ~(|(pmp_addr_mask[12][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp12addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[12] = (csr_pmp12cfg_a == PMP_A_TOR) ? pmp_tor_valid[12] : ((csr_pmp12cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[12] : 1'b0);
    end
    else begin:gen_no_pmp_entry_12
        assign pmp_entry_valid[12] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp12addr = csr_pmp12addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 14) begin:gen_pmp_entry_13
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[13] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[13] <= pmp_addr_mask_nx[13];
            end
        end

        assign pmp_tor_valid[13] = (csr_pmp13addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp12addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[13] = ({1'b0,csr_pmp13addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[13] = csr_pmp_addr_add1[13][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp13addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[13] = ~(|(pmp_addr_mask[13][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp13addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[13] = (csr_pmp13cfg_a == PMP_A_TOR) ? pmp_tor_valid[13] : ((csr_pmp13cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[13] : 1'b0);
    end
    else begin:gen_no_pmp_entry_13
        assign pmp_entry_valid[13] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp13addr = csr_pmp13addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 15) begin:gen_pmp_entry_14
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[14] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[14] <= pmp_addr_mask_nx[14];
            end
        end

        assign pmp_tor_valid[14] = (csr_pmp14addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp13addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[14] = ({1'b0,csr_pmp14addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[14] = csr_pmp_addr_add1[14][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp14addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[14] = ~(|(pmp_addr_mask[14][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp14addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[14] = (csr_pmp14cfg_a == PMP_A_TOR) ? pmp_tor_valid[14] : ((csr_pmp14cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[14] : 1'b0);
    end
    else begin:gen_no_pmp_entry_14
        assign pmp_entry_valid[14] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp14addr = csr_pmp14addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 16) begin:gen_pmp_entry_15
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[15] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[15] <= pmp_addr_mask_nx[15];
            end
        end

        assign pmp_tor_valid[15] = (csr_pmp15addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp14addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[15] = ({1'b0,csr_pmp15addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[15] = csr_pmp_addr_add1[15][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp15addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[15] = ~(|(pmp_addr_mask[15][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp15addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[15] = (csr_pmp15cfg_a == PMP_A_TOR) ? pmp_tor_valid[15] : ((csr_pmp15cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[15] : 1'b0);
    end
    else begin:gen_no_pmp_entry_15
        assign pmp_entry_valid[15] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp15addr = csr_pmp15addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 17) begin:gen_pmp_entry_16
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[16] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[16] <= pmp_addr_mask_nx[16];
            end
        end

        assign pmp_tor_valid[16] = (csr_pmp16addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp15addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[16] = ({1'b0,csr_pmp16addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[16] = csr_pmp_addr_add1[16][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp16addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[16] = ~(|(pmp_addr_mask[16][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp16addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[16] = (csr_pmp16cfg_a == PMP_A_TOR) ? pmp_tor_valid[16] : ((csr_pmp16cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[16] : 1'b0);
    end
    else begin:gen_no_pmp_entry_16
        assign pmp_entry_valid[16] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp16addr = csr_pmp16addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 18) begin:gen_pmp_entry_17
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[17] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[17] <= pmp_addr_mask_nx[17];
            end
        end

        assign pmp_tor_valid[17] = (csr_pmp17addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp16addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[17] = ({1'b0,csr_pmp17addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[17] = csr_pmp_addr_add1[17][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp17addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[17] = ~(|(pmp_addr_mask[17][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp17addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[17] = (csr_pmp17cfg_a == PMP_A_TOR) ? pmp_tor_valid[17] : ((csr_pmp17cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[17] : 1'b0);
    end
    else begin:gen_no_pmp_entry_17
        assign pmp_entry_valid[17] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp17addr = csr_pmp17addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 19) begin:gen_pmp_entry_18
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[18] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[18] <= pmp_addr_mask_nx[18];
            end
        end

        assign pmp_tor_valid[18] = (csr_pmp18addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp17addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[18] = ({1'b0,csr_pmp18addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[18] = csr_pmp_addr_add1[18][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp18addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[18] = ~(|(pmp_addr_mask[18][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp18addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[18] = (csr_pmp18cfg_a == PMP_A_TOR) ? pmp_tor_valid[18] : ((csr_pmp18cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[18] : 1'b0);
    end
    else begin:gen_no_pmp_entry_18
        assign pmp_entry_valid[18] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp18addr = csr_pmp18addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 20) begin:gen_pmp_entry_19
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[19] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[19] <= pmp_addr_mask_nx[19];
            end
        end

        assign pmp_tor_valid[19] = (csr_pmp19addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp18addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[19] = ({1'b0,csr_pmp19addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[19] = csr_pmp_addr_add1[19][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp19addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[19] = ~(|(pmp_addr_mask[19][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp19addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[19] = (csr_pmp19cfg_a == PMP_A_TOR) ? pmp_tor_valid[19] : ((csr_pmp19cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[19] : 1'b0);
    end
    else begin:gen_no_pmp_entry_19
        assign pmp_entry_valid[19] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp19addr = csr_pmp19addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 21) begin:gen_pmp_entry_20
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[20] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[20] <= pmp_addr_mask_nx[20];
            end
        end

        assign pmp_tor_valid[20] = (csr_pmp20addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp19addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[20] = ({1'b0,csr_pmp20addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[20] = csr_pmp_addr_add1[20][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp20addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[20] = ~(|(pmp_addr_mask[20][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp20addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[20] = (csr_pmp20cfg_a == PMP_A_TOR) ? pmp_tor_valid[20] : ((csr_pmp20cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[20] : 1'b0);
    end
    else begin:gen_no_pmp_entry_20
        assign pmp_entry_valid[20] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp20addr = csr_pmp20addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 22) begin:gen_pmp_entry_21
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[21] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[21] <= pmp_addr_mask_nx[21];
            end
        end

        assign pmp_tor_valid[21] = (csr_pmp21addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp20addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[21] = ({1'b0,csr_pmp21addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[21] = csr_pmp_addr_add1[21][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp21addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[21] = ~(|(pmp_addr_mask[21][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp21addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[21] = (csr_pmp21cfg_a == PMP_A_TOR) ? pmp_tor_valid[21] : ((csr_pmp21cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[21] : 1'b0);
    end
    else begin:gen_no_pmp_entry_21
        assign pmp_entry_valid[21] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp21addr = csr_pmp21addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 23) begin:gen_pmp_entry_22
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[22] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[22] <= pmp_addr_mask_nx[22];
            end
        end

        assign pmp_tor_valid[22] = (csr_pmp22addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp21addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[22] = ({1'b0,csr_pmp22addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[22] = csr_pmp_addr_add1[22][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp22addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[22] = ~(|(pmp_addr_mask[22][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp22addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[22] = (csr_pmp22cfg_a == PMP_A_TOR) ? pmp_tor_valid[22] : ((csr_pmp22cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[22] : 1'b0);
    end
    else begin:gen_no_pmp_entry_22
        assign pmp_entry_valid[22] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp22addr = csr_pmp22addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 24) begin:gen_pmp_entry_23
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[23] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[23] <= pmp_addr_mask_nx[23];
            end
        end

        assign pmp_tor_valid[23] = (csr_pmp23addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp22addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[23] = ({1'b0,csr_pmp23addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[23] = csr_pmp_addr_add1[23][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp23addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[23] = ~(|(pmp_addr_mask[23][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp23addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[23] = (csr_pmp23cfg_a == PMP_A_TOR) ? pmp_tor_valid[23] : ((csr_pmp23cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[23] : 1'b0);
    end
    else begin:gen_no_pmp_entry_23
        assign pmp_entry_valid[23] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp23addr = csr_pmp23addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 25) begin:gen_pmp_entry_24
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[24] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[24] <= pmp_addr_mask_nx[24];
            end
        end

        assign pmp_tor_valid[24] = (csr_pmp24addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp23addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[24] = ({1'b0,csr_pmp24addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[24] = csr_pmp_addr_add1[24][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp24addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[24] = ~(|(pmp_addr_mask[24][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp24addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[24] = (csr_pmp24cfg_a == PMP_A_TOR) ? pmp_tor_valid[24] : ((csr_pmp24cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[24] : 1'b0);
    end
    else begin:gen_no_pmp_entry_24
        assign pmp_entry_valid[24] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp24addr = csr_pmp24addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 26) begin:gen_pmp_entry_25
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[25] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[25] <= pmp_addr_mask_nx[25];
            end
        end

        assign pmp_tor_valid[25] = (csr_pmp25addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp24addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[25] = ({1'b0,csr_pmp25addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[25] = csr_pmp_addr_add1[25][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp25addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[25] = ~(|(pmp_addr_mask[25][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp25addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[25] = (csr_pmp25cfg_a == PMP_A_TOR) ? pmp_tor_valid[25] : ((csr_pmp25cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[25] : 1'b0);
    end
    else begin:gen_no_pmp_entry_25
        assign pmp_entry_valid[25] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp25addr = csr_pmp25addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 27) begin:gen_pmp_entry_26
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[26] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[26] <= pmp_addr_mask_nx[26];
            end
        end

        assign pmp_tor_valid[26] = (csr_pmp26addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp25addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[26] = ({1'b0,csr_pmp26addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[26] = csr_pmp_addr_add1[26][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp26addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[26] = ~(|(pmp_addr_mask[26][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp26addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[26] = (csr_pmp26cfg_a == PMP_A_TOR) ? pmp_tor_valid[26] : ((csr_pmp26cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[26] : 1'b0);
    end
    else begin:gen_no_pmp_entry_26
        assign pmp_entry_valid[26] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp26addr = csr_pmp26addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 28) begin:gen_pmp_entry_27
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[27] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[27] <= pmp_addr_mask_nx[27];
            end
        end

        assign pmp_tor_valid[27] = (csr_pmp27addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp26addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[27] = ({1'b0,csr_pmp27addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[27] = csr_pmp_addr_add1[27][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp27addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[27] = ~(|(pmp_addr_mask[27][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp27addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[27] = (csr_pmp27cfg_a == PMP_A_TOR) ? pmp_tor_valid[27] : ((csr_pmp27cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[27] : 1'b0);
    end
    else begin:gen_no_pmp_entry_27
        assign pmp_entry_valid[27] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp27addr = csr_pmp27addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 29) begin:gen_pmp_entry_28
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[28] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[28] <= pmp_addr_mask_nx[28];
            end
        end

        assign pmp_tor_valid[28] = (csr_pmp28addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp27addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[28] = ({1'b0,csr_pmp28addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[28] = csr_pmp_addr_add1[28][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp28addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[28] = ~(|(pmp_addr_mask[28][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp28addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[28] = (csr_pmp28cfg_a == PMP_A_TOR) ? pmp_tor_valid[28] : ((csr_pmp28cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[28] : 1'b0);
    end
    else begin:gen_no_pmp_entry_28
        assign pmp_entry_valid[28] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp28addr = csr_pmp28addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 30) begin:gen_pmp_entry_29
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[29] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[29] <= pmp_addr_mask_nx[29];
            end
        end

        assign pmp_tor_valid[29] = (csr_pmp29addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp28addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[29] = ({1'b0,csr_pmp29addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[29] = csr_pmp_addr_add1[29][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp29addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[29] = ~(|(pmp_addr_mask[29][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp29addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[29] = (csr_pmp29cfg_a == PMP_A_TOR) ? pmp_tor_valid[29] : ((csr_pmp29cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[29] : 1'b0);
    end
    else begin:gen_no_pmp_entry_29
        assign pmp_entry_valid[29] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp29addr = csr_pmp29addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 31) begin:gen_pmp_entry_30
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[30] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[30] <= pmp_addr_mask_nx[30];
            end
        end

        assign pmp_tor_valid[30] = (csr_pmp30addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp29addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[30] = ({1'b0,csr_pmp30addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[30] = csr_pmp_addr_add1[30][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp30addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[30] = ~(|(pmp_addr_mask[30][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp30addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[30] = (csr_pmp30cfg_a == PMP_A_TOR) ? pmp_tor_valid[30] : ((csr_pmp30cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[30] : 1'b0);
    end
    else begin:gen_no_pmp_entry_30
        assign pmp_entry_valid[30] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp30addr = csr_pmp30addr;
    end
endgenerate
generate
    if (PMP_ENTRIES >= 32) begin:gen_pmp_entry_31
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                pmp_addr_mask[31] <= {(PALEN - PMPADDR_CHECK_LSB + 1){1'b0}};
            end
            else if (reg_pmp_we) begin
                pmp_addr_mask[31] <= pmp_addr_mask_nx[31];
            end
        end

        assign pmp_tor_valid[31] = (csr_pmp31addr[PALEN - 1:PMPADDR_CHECK_LSB] > pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]) & (csr_pmp30addr[PALEN - 1:PMPADDR_CHECK_LSB] <= pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB]);
        assign csr_pmp_addr_add1[31] = ({1'b0,csr_pmp31addr[PALEN - 1:PMPADDR_CHECK_LSB - 1]} + {1'b0,{(PALEN - PMPADDR_CHECK_LSB){1'b0}},1'b1});
        assign pmp_addr_mask_nx[31] = csr_pmp_addr_add1[31][PALEN - 1:PMPADDR_CHECK_LSB - 1] ^~ csr_pmp31addr[PALEN - 1:PMPADDR_CHECK_LSB - 1];
        assign pmp_napot_valid[31] = ~(|(pmp_addr_mask[31][PALEN - 1:PMPADDR_CHECK_LSB] & (csr_pmp31addr[PALEN - 1:PMPADDR_CHECK_LSB] ^ pmp_req_pa[PALEN - 1:PMPADDR_CHECK_LSB])));
        assign pmp_entry_valid[31] = (csr_pmp31cfg_a == PMP_A_TOR) ? pmp_tor_valid[31] : ((csr_pmp31cfg_a == PMP_A_NAPOT) ? pmp_napot_valid[31] : 1'b0);
    end
    else begin:gen_no_pmp_entry_31
        assign pmp_entry_valid[31] = 1'b0;
        wire [PALEN - 1:2] nds_unused_csr_pmp31addr = csr_pmp31addr;
    end
endgenerate
assign pmp_entry_hit[0] = pmp_entry_valid[0] | pmp_entry_up_valid[0] | pmp_touch_512[0];
assign pmp_entry_hit[1] = pmp_entry_valid[1] | pmp_entry_up_valid[1] | pmp_touch_512[1];
assign pmp_entry_hit[2] = pmp_entry_valid[2] | pmp_entry_up_valid[2] | pmp_touch_512[2];
assign pmp_entry_hit[3] = pmp_entry_valid[3] | pmp_entry_up_valid[3] | pmp_touch_512[3];
assign pmp_entry_hit[4] = pmp_entry_valid[4] | pmp_entry_up_valid[4] | pmp_touch_512[4];
assign pmp_entry_hit[5] = pmp_entry_valid[5] | pmp_entry_up_valid[5] | pmp_touch_512[5];
assign pmp_entry_hit[6] = pmp_entry_valid[6] | pmp_entry_up_valid[6] | pmp_touch_512[6];
assign pmp_entry_hit[7] = pmp_entry_valid[7] | pmp_entry_up_valid[7] | pmp_touch_512[7];
assign pmp_entry_hit[8] = pmp_entry_valid[8] | pmp_entry_up_valid[8] | pmp_touch_512[8];
assign pmp_entry_hit[9] = pmp_entry_valid[9] | pmp_entry_up_valid[9] | pmp_touch_512[9];
assign pmp_entry_hit[10] = pmp_entry_valid[10] | pmp_entry_up_valid[10] | pmp_touch_512[10];
assign pmp_entry_hit[11] = pmp_entry_valid[11] | pmp_entry_up_valid[11] | pmp_touch_512[11];
assign pmp_entry_hit[12] = pmp_entry_valid[12] | pmp_entry_up_valid[12] | pmp_touch_512[12];
assign pmp_entry_hit[13] = pmp_entry_valid[13] | pmp_entry_up_valid[13] | pmp_touch_512[13];
assign pmp_entry_hit[14] = pmp_entry_valid[14] | pmp_entry_up_valid[14] | pmp_touch_512[14];
assign pmp_entry_hit[15] = pmp_entry_valid[15] | pmp_entry_up_valid[15] | pmp_touch_512[15];
assign pmp_entry_hit[16] = pmp_entry_valid[16] | pmp_entry_up_valid[16] | pmp_touch_512[16];
assign pmp_entry_hit[17] = pmp_entry_valid[17] | pmp_entry_up_valid[17] | pmp_touch_512[17];
assign pmp_entry_hit[18] = pmp_entry_valid[18] | pmp_entry_up_valid[18] | pmp_touch_512[18];
assign pmp_entry_hit[19] = pmp_entry_valid[19] | pmp_entry_up_valid[19] | pmp_touch_512[19];
assign pmp_entry_hit[20] = pmp_entry_valid[20] | pmp_entry_up_valid[20] | pmp_touch_512[20];
assign pmp_entry_hit[21] = pmp_entry_valid[21] | pmp_entry_up_valid[21] | pmp_touch_512[21];
assign pmp_entry_hit[22] = pmp_entry_valid[22] | pmp_entry_up_valid[22] | pmp_touch_512[22];
assign pmp_entry_hit[23] = pmp_entry_valid[23] | pmp_entry_up_valid[23] | pmp_touch_512[23];
assign pmp_entry_hit[24] = pmp_entry_valid[24] | pmp_entry_up_valid[24] | pmp_touch_512[24];
assign pmp_entry_hit[25] = pmp_entry_valid[25] | pmp_entry_up_valid[25] | pmp_touch_512[25];
assign pmp_entry_hit[26] = pmp_entry_valid[26] | pmp_entry_up_valid[26] | pmp_touch_512[26];
assign pmp_entry_hit[27] = pmp_entry_valid[27] | pmp_entry_up_valid[27] | pmp_touch_512[27];
assign pmp_entry_hit[28] = pmp_entry_valid[28] | pmp_entry_up_valid[28] | pmp_touch_512[28];
assign pmp_entry_hit[29] = pmp_entry_valid[29] | pmp_entry_up_valid[29] | pmp_touch_512[29];
assign pmp_entry_hit[30] = pmp_entry_valid[30] | pmp_entry_up_valid[30] | pmp_touch_512[30];
assign pmp_entry_hit[31] = pmp_entry_valid[31] | pmp_entry_up_valid[31] | pmp_touch_512[31];
assign pmp_entry_no_all_match[0] = (pmp_entry_valid[0] ^ pmp_entry_up_valid[0]) | (pmp_touch_512[0] & ~(pmp_entry_valid[0] | pmp_entry_up_valid[0]));
assign pmp_entry_no_all_match[1] = (pmp_entry_valid[1] ^ pmp_entry_up_valid[1]) | (pmp_touch_512[1] & ~(pmp_entry_valid[1] | pmp_entry_up_valid[1]));
assign pmp_entry_no_all_match[2] = (pmp_entry_valid[2] ^ pmp_entry_up_valid[2]) | (pmp_touch_512[2] & ~(pmp_entry_valid[2] | pmp_entry_up_valid[2]));
assign pmp_entry_no_all_match[3] = (pmp_entry_valid[3] ^ pmp_entry_up_valid[3]) | (pmp_touch_512[3] & ~(pmp_entry_valid[3] | pmp_entry_up_valid[3]));
assign pmp_entry_no_all_match[4] = (pmp_entry_valid[4] ^ pmp_entry_up_valid[4]) | (pmp_touch_512[4] & ~(pmp_entry_valid[4] | pmp_entry_up_valid[4]));
assign pmp_entry_no_all_match[5] = (pmp_entry_valid[5] ^ pmp_entry_up_valid[5]) | (pmp_touch_512[5] & ~(pmp_entry_valid[5] | pmp_entry_up_valid[5]));
assign pmp_entry_no_all_match[6] = (pmp_entry_valid[6] ^ pmp_entry_up_valid[6]) | (pmp_touch_512[6] & ~(pmp_entry_valid[6] | pmp_entry_up_valid[6]));
assign pmp_entry_no_all_match[7] = (pmp_entry_valid[7] ^ pmp_entry_up_valid[7]) | (pmp_touch_512[7] & ~(pmp_entry_valid[7] | pmp_entry_up_valid[7]));
assign pmp_entry_no_all_match[8] = (pmp_entry_valid[8] ^ pmp_entry_up_valid[8]) | (pmp_touch_512[8] & ~(pmp_entry_valid[8] | pmp_entry_up_valid[8]));
assign pmp_entry_no_all_match[9] = (pmp_entry_valid[9] ^ pmp_entry_up_valid[9]) | (pmp_touch_512[9] & ~(pmp_entry_valid[9] | pmp_entry_up_valid[9]));
assign pmp_entry_no_all_match[10] = (pmp_entry_valid[10] ^ pmp_entry_up_valid[10]) | (pmp_touch_512[10] & ~(pmp_entry_valid[10] | pmp_entry_up_valid[10]));
assign pmp_entry_no_all_match[11] = (pmp_entry_valid[11] ^ pmp_entry_up_valid[11]) | (pmp_touch_512[11] & ~(pmp_entry_valid[11] | pmp_entry_up_valid[11]));
assign pmp_entry_no_all_match[12] = (pmp_entry_valid[12] ^ pmp_entry_up_valid[12]) | (pmp_touch_512[12] & ~(pmp_entry_valid[12] | pmp_entry_up_valid[12]));
assign pmp_entry_no_all_match[13] = (pmp_entry_valid[13] ^ pmp_entry_up_valid[13]) | (pmp_touch_512[13] & ~(pmp_entry_valid[13] | pmp_entry_up_valid[13]));
assign pmp_entry_no_all_match[14] = (pmp_entry_valid[14] ^ pmp_entry_up_valid[14]) | (pmp_touch_512[14] & ~(pmp_entry_valid[14] | pmp_entry_up_valid[14]));
assign pmp_entry_no_all_match[15] = (pmp_entry_valid[15] ^ pmp_entry_up_valid[15]) | (pmp_touch_512[15] & ~(pmp_entry_valid[15] | pmp_entry_up_valid[15]));
assign pmp_entry_no_all_match[16] = (pmp_entry_valid[16] ^ pmp_entry_up_valid[16]) | (pmp_touch_512[16] & ~(pmp_entry_valid[16] | pmp_entry_up_valid[16]));
assign pmp_entry_no_all_match[17] = (pmp_entry_valid[17] ^ pmp_entry_up_valid[17]) | (pmp_touch_512[17] & ~(pmp_entry_valid[17] | pmp_entry_up_valid[17]));
assign pmp_entry_no_all_match[18] = (pmp_entry_valid[18] ^ pmp_entry_up_valid[18]) | (pmp_touch_512[18] & ~(pmp_entry_valid[18] | pmp_entry_up_valid[18]));
assign pmp_entry_no_all_match[19] = (pmp_entry_valid[19] ^ pmp_entry_up_valid[19]) | (pmp_touch_512[19] & ~(pmp_entry_valid[19] | pmp_entry_up_valid[19]));
assign pmp_entry_no_all_match[20] = (pmp_entry_valid[20] ^ pmp_entry_up_valid[20]) | (pmp_touch_512[20] & ~(pmp_entry_valid[20] | pmp_entry_up_valid[20]));
assign pmp_entry_no_all_match[21] = (pmp_entry_valid[21] ^ pmp_entry_up_valid[21]) | (pmp_touch_512[21] & ~(pmp_entry_valid[21] | pmp_entry_up_valid[21]));
assign pmp_entry_no_all_match[22] = (pmp_entry_valid[22] ^ pmp_entry_up_valid[22]) | (pmp_touch_512[22] & ~(pmp_entry_valid[22] | pmp_entry_up_valid[22]));
assign pmp_entry_no_all_match[23] = (pmp_entry_valid[23] ^ pmp_entry_up_valid[23]) | (pmp_touch_512[23] & ~(pmp_entry_valid[23] | pmp_entry_up_valid[23]));
assign pmp_entry_no_all_match[24] = (pmp_entry_valid[24] ^ pmp_entry_up_valid[24]) | (pmp_touch_512[24] & ~(pmp_entry_valid[24] | pmp_entry_up_valid[24]));
assign pmp_entry_no_all_match[25] = (pmp_entry_valid[25] ^ pmp_entry_up_valid[25]) | (pmp_touch_512[25] & ~(pmp_entry_valid[25] | pmp_entry_up_valid[25]));
assign pmp_entry_no_all_match[26] = (pmp_entry_valid[26] ^ pmp_entry_up_valid[26]) | (pmp_touch_512[26] & ~(pmp_entry_valid[26] | pmp_entry_up_valid[26]));
assign pmp_entry_no_all_match[27] = (pmp_entry_valid[27] ^ pmp_entry_up_valid[27]) | (pmp_touch_512[27] & ~(pmp_entry_valid[27] | pmp_entry_up_valid[27]));
assign pmp_entry_no_all_match[28] = (pmp_entry_valid[28] ^ pmp_entry_up_valid[28]) | (pmp_touch_512[28] & ~(pmp_entry_valid[28] | pmp_entry_up_valid[28]));
assign pmp_entry_no_all_match[29] = (pmp_entry_valid[29] ^ pmp_entry_up_valid[29]) | (pmp_touch_512[29] & ~(pmp_entry_valid[29] | pmp_entry_up_valid[29]));
assign pmp_entry_no_all_match[30] = (pmp_entry_valid[30] ^ pmp_entry_up_valid[30]) | (pmp_touch_512[30] & ~(pmp_entry_valid[30] | pmp_entry_up_valid[30]));
assign pmp_entry_no_all_match[31] = (pmp_entry_valid[31] ^ pmp_entry_up_valid[31]) | (pmp_touch_512[31] & ~(pmp_entry_valid[31] | pmp_entry_up_valid[31]));
assign {pmp_mmu_l,pmp_mmu_x,pmp_mmu_w,pmp_mmu_r,pmp_mmu_no_all_match} = pmp_entry_hit[0] ? {csr_pmp0cfg[PMPCFG_L],csr_pmp0cfg[PMPCFG_X],csr_pmp0cfg[PMPCFG_W],csr_pmp0cfg[PMPCFG_R],pmp_entry_no_all_match[0]} : pmp_entry_hit[1] ? {csr_pmp1cfg[PMPCFG_L],csr_pmp1cfg[PMPCFG_X],csr_pmp1cfg[PMPCFG_W],csr_pmp1cfg[PMPCFG_R],pmp_entry_no_all_match[1]} : pmp_entry_hit[2] ? {csr_pmp2cfg[PMPCFG_L],csr_pmp2cfg[PMPCFG_X],csr_pmp2cfg[PMPCFG_W],csr_pmp2cfg[PMPCFG_R],pmp_entry_no_all_match[2]} : pmp_entry_hit[3] ? {csr_pmp3cfg[PMPCFG_L],csr_pmp3cfg[PMPCFG_X],csr_pmp3cfg[PMPCFG_W],csr_pmp3cfg[PMPCFG_R],pmp_entry_no_all_match[3]} : pmp_entry_hit[4] ? {csr_pmp4cfg[PMPCFG_L],csr_pmp4cfg[PMPCFG_X],csr_pmp4cfg[PMPCFG_W],csr_pmp4cfg[PMPCFG_R],pmp_entry_no_all_match[4]} : pmp_entry_hit[5] ? {csr_pmp5cfg[PMPCFG_L],csr_pmp5cfg[PMPCFG_X],csr_pmp5cfg[PMPCFG_W],csr_pmp5cfg[PMPCFG_R],pmp_entry_no_all_match[5]} : pmp_entry_hit[6] ? {csr_pmp6cfg[PMPCFG_L],csr_pmp6cfg[PMPCFG_X],csr_pmp6cfg[PMPCFG_W],csr_pmp6cfg[PMPCFG_R],pmp_entry_no_all_match[6]} : pmp_entry_hit[7] ? {csr_pmp7cfg[PMPCFG_L],csr_pmp7cfg[PMPCFG_X],csr_pmp7cfg[PMPCFG_W],csr_pmp7cfg[PMPCFG_R],pmp_entry_no_all_match[7]} : pmp_entry_hit[8] ? {csr_pmp8cfg[PMPCFG_L],csr_pmp8cfg[PMPCFG_X],csr_pmp8cfg[PMPCFG_W],csr_pmp8cfg[PMPCFG_R],pmp_entry_no_all_match[8]} : pmp_entry_hit[9] ? {csr_pmp9cfg[PMPCFG_L],csr_pmp9cfg[PMPCFG_X],csr_pmp9cfg[PMPCFG_W],csr_pmp9cfg[PMPCFG_R],pmp_entry_no_all_match[9]} : pmp_entry_hit[10] ? {csr_pmp10cfg[PMPCFG_L],csr_pmp10cfg[PMPCFG_X],csr_pmp10cfg[PMPCFG_W],csr_pmp10cfg[PMPCFG_R],pmp_entry_no_all_match[10]} : pmp_entry_hit[11] ? {csr_pmp11cfg[PMPCFG_L],csr_pmp11cfg[PMPCFG_X],csr_pmp11cfg[PMPCFG_W],csr_pmp11cfg[PMPCFG_R],pmp_entry_no_all_match[11]} : pmp_entry_hit[12] ? {csr_pmp12cfg[PMPCFG_L],csr_pmp12cfg[PMPCFG_X],csr_pmp12cfg[PMPCFG_W],csr_pmp12cfg[PMPCFG_R],pmp_entry_no_all_match[12]} : pmp_entry_hit[13] ? {csr_pmp13cfg[PMPCFG_L],csr_pmp13cfg[PMPCFG_X],csr_pmp13cfg[PMPCFG_W],csr_pmp13cfg[PMPCFG_R],pmp_entry_no_all_match[13]} : pmp_entry_hit[14] ? {csr_pmp14cfg[PMPCFG_L],csr_pmp14cfg[PMPCFG_X],csr_pmp14cfg[PMPCFG_W],csr_pmp14cfg[PMPCFG_R],pmp_entry_no_all_match[14]} : pmp_entry_hit[15] ? {csr_pmp15cfg[PMPCFG_L],csr_pmp15cfg[PMPCFG_X],csr_pmp15cfg[PMPCFG_W],csr_pmp15cfg[PMPCFG_R],pmp_entry_no_all_match[15]} : pmp_entry_hit[16] ? {csr_pmp16cfg[PMPCFG_L],csr_pmp16cfg[PMPCFG_X],csr_pmp16cfg[PMPCFG_W],csr_pmp16cfg[PMPCFG_R],pmp_entry_no_all_match[16]} : pmp_entry_hit[17] ? {csr_pmp17cfg[PMPCFG_L],csr_pmp17cfg[PMPCFG_X],csr_pmp17cfg[PMPCFG_W],csr_pmp17cfg[PMPCFG_R],pmp_entry_no_all_match[17]} : pmp_entry_hit[18] ? {csr_pmp18cfg[PMPCFG_L],csr_pmp18cfg[PMPCFG_X],csr_pmp18cfg[PMPCFG_W],csr_pmp18cfg[PMPCFG_R],pmp_entry_no_all_match[18]} : pmp_entry_hit[19] ? {csr_pmp19cfg[PMPCFG_L],csr_pmp19cfg[PMPCFG_X],csr_pmp19cfg[PMPCFG_W],csr_pmp19cfg[PMPCFG_R],pmp_entry_no_all_match[19]} : pmp_entry_hit[20] ? {csr_pmp20cfg[PMPCFG_L],csr_pmp20cfg[PMPCFG_X],csr_pmp20cfg[PMPCFG_W],csr_pmp20cfg[PMPCFG_R],pmp_entry_no_all_match[20]} : pmp_entry_hit[21] ? {csr_pmp21cfg[PMPCFG_L],csr_pmp21cfg[PMPCFG_X],csr_pmp21cfg[PMPCFG_W],csr_pmp21cfg[PMPCFG_R],pmp_entry_no_all_match[21]} : pmp_entry_hit[22] ? {csr_pmp22cfg[PMPCFG_L],csr_pmp22cfg[PMPCFG_X],csr_pmp22cfg[PMPCFG_W],csr_pmp22cfg[PMPCFG_R],pmp_entry_no_all_match[22]} : pmp_entry_hit[23] ? {csr_pmp23cfg[PMPCFG_L],csr_pmp23cfg[PMPCFG_X],csr_pmp23cfg[PMPCFG_W],csr_pmp23cfg[PMPCFG_R],pmp_entry_no_all_match[23]} : pmp_entry_hit[24] ? {csr_pmp24cfg[PMPCFG_L],csr_pmp24cfg[PMPCFG_X],csr_pmp24cfg[PMPCFG_W],csr_pmp24cfg[PMPCFG_R],pmp_entry_no_all_match[24]} : pmp_entry_hit[25] ? {csr_pmp25cfg[PMPCFG_L],csr_pmp25cfg[PMPCFG_X],csr_pmp25cfg[PMPCFG_W],csr_pmp25cfg[PMPCFG_R],pmp_entry_no_all_match[25]} : pmp_entry_hit[26] ? {csr_pmp26cfg[PMPCFG_L],csr_pmp26cfg[PMPCFG_X],csr_pmp26cfg[PMPCFG_W],csr_pmp26cfg[PMPCFG_R],pmp_entry_no_all_match[26]} : pmp_entry_hit[27] ? {csr_pmp27cfg[PMPCFG_L],csr_pmp27cfg[PMPCFG_X],csr_pmp27cfg[PMPCFG_W],csr_pmp27cfg[PMPCFG_R],pmp_entry_no_all_match[27]} : pmp_entry_hit[28] ? {csr_pmp28cfg[PMPCFG_L],csr_pmp28cfg[PMPCFG_X],csr_pmp28cfg[PMPCFG_W],csr_pmp28cfg[PMPCFG_R],pmp_entry_no_all_match[28]} : pmp_entry_hit[29] ? {csr_pmp29cfg[PMPCFG_L],csr_pmp29cfg[PMPCFG_X],csr_pmp29cfg[PMPCFG_W],csr_pmp29cfg[PMPCFG_R],pmp_entry_no_all_match[29]} : pmp_entry_hit[30] ? {csr_pmp30cfg[PMPCFG_L],csr_pmp30cfg[PMPCFG_X],csr_pmp30cfg[PMPCFG_W],csr_pmp30cfg[PMPCFG_R],pmp_entry_no_all_match[30]} : pmp_entry_hit[31] ? {csr_pmp31cfg[PMPCFG_L],csr_pmp31cfg[PMPCFG_X],csr_pmp31cfg[PMPCFG_W],csr_pmp31cfg[PMPCFG_R],pmp_entry_no_all_match[31]} : 5'b0;
assign pmp_entry_up_valid[0] = pmp_entry_valid[0];
assign pmp_touch_512[0] = 1'b0;
assign pmp_entry_up_valid[1] = pmp_entry_valid[1];
assign pmp_touch_512[1] = 1'b0;
assign pmp_entry_up_valid[2] = pmp_entry_valid[2];
assign pmp_touch_512[2] = 1'b0;
assign pmp_entry_up_valid[3] = pmp_entry_valid[3];
assign pmp_touch_512[3] = 1'b0;
assign pmp_entry_up_valid[4] = pmp_entry_valid[4];
assign pmp_touch_512[4] = 1'b0;
assign pmp_entry_up_valid[5] = pmp_entry_valid[5];
assign pmp_touch_512[5] = 1'b0;
assign pmp_entry_up_valid[6] = pmp_entry_valid[6];
assign pmp_touch_512[6] = 1'b0;
assign pmp_entry_up_valid[7] = pmp_entry_valid[7];
assign pmp_touch_512[7] = 1'b0;
assign pmp_entry_up_valid[8] = pmp_entry_valid[8];
assign pmp_touch_512[8] = 1'b0;
assign pmp_entry_up_valid[9] = pmp_entry_valid[9];
assign pmp_touch_512[9] = 1'b0;
assign pmp_entry_up_valid[10] = pmp_entry_valid[10];
assign pmp_touch_512[10] = 1'b0;
assign pmp_entry_up_valid[11] = pmp_entry_valid[11];
assign pmp_touch_512[11] = 1'b0;
assign pmp_entry_up_valid[12] = pmp_entry_valid[12];
assign pmp_touch_512[12] = 1'b0;
assign pmp_entry_up_valid[13] = pmp_entry_valid[13];
assign pmp_touch_512[13] = 1'b0;
assign pmp_entry_up_valid[14] = pmp_entry_valid[14];
assign pmp_touch_512[14] = 1'b0;
assign pmp_entry_up_valid[15] = pmp_entry_valid[15];
assign pmp_touch_512[15] = 1'b0;
assign pmp_entry_up_valid[16] = pmp_entry_valid[16];
assign pmp_touch_512[16] = 1'b0;
assign pmp_entry_up_valid[17] = pmp_entry_valid[17];
assign pmp_touch_512[17] = 1'b0;
assign pmp_entry_up_valid[18] = pmp_entry_valid[18];
assign pmp_touch_512[18] = 1'b0;
assign pmp_entry_up_valid[19] = pmp_entry_valid[19];
assign pmp_touch_512[19] = 1'b0;
assign pmp_entry_up_valid[20] = pmp_entry_valid[20];
assign pmp_touch_512[20] = 1'b0;
assign pmp_entry_up_valid[21] = pmp_entry_valid[21];
assign pmp_touch_512[21] = 1'b0;
assign pmp_entry_up_valid[22] = pmp_entry_valid[22];
assign pmp_touch_512[22] = 1'b0;
assign pmp_entry_up_valid[23] = pmp_entry_valid[23];
assign pmp_touch_512[23] = 1'b0;
assign pmp_entry_up_valid[24] = pmp_entry_valid[24];
assign pmp_touch_512[24] = 1'b0;
assign pmp_entry_up_valid[25] = pmp_entry_valid[25];
assign pmp_touch_512[25] = 1'b0;
assign pmp_entry_up_valid[26] = pmp_entry_valid[26];
assign pmp_touch_512[26] = 1'b0;
assign pmp_entry_up_valid[27] = pmp_entry_valid[27];
assign pmp_touch_512[27] = 1'b0;
assign pmp_entry_up_valid[28] = pmp_entry_valid[28];
assign pmp_touch_512[28] = 1'b0;
assign pmp_entry_up_valid[29] = pmp_entry_valid[29];
assign pmp_touch_512[29] = 1'b0;
assign pmp_entry_up_valid[30] = pmp_entry_valid[30];
assign pmp_touch_512[30] = 1'b0;
assign pmp_entry_up_valid[31] = pmp_entry_valid[31];
assign pmp_touch_512[31] = 1'b0;
wire nds_unused_pmp_req_vector_access = pmp_req_vector_access;
wire [PALEN - 1:0] nds_unused_pmp_req_up_pa = pmp_req_up_pa;
assign pmp_permit_halt_mode = csr_halt_mode & (pmp_req_pa[0 +:PALEN] >= DEBUG_VEC[0 +:PALEN]) & (pmp_req_pa[0 +:PALEN] < DEBUG_VEC_UBOUND[0 +:PALEN]);
generate
    if ((PMP_TYPE_INT == 1)) begin:gen_pmp_type_instr
        wire pmp_ien = (csr_cur_privilege == PRIVILEGE_MACHINE) ? pmp_mmode_en : pmp_en;
        assign pmp_resp_fault = ((csr_cur_privilege != PRIVILEGE_MACHINE) | pmp_mmu_l) & ~pmp_mmu_x & pmp_ien & pmp_req_exec & ~pmp_permit_halt_mode;
        wire nds_unused_pmp_mmu_w = pmp_mmu_w;
        wire nds_unused_pmp_mmu_r = pmp_mmu_r;
        wire nds_unused_pmp_mmu_no_all_match = pmp_mmu_no_all_match;
        wire nds_unused_csr_dcsr_mprven = csr_dcsr_mprven;
        wire nds_unused_csr_mstatus_mprv = csr_mstatus_mprv;
        wire [1:0] nds_unused_csr_mstatus_mpp = csr_mstatus_mpp;
        wire nds_unused_pmp_req_store = pmp_req_store;
        assign pmp_resp_permission = 4'b0;
    end
    if ((PMP_TYPE_INT == 0)) begin:gen_pmp_type_data
        wire [1:0] effective_privilege = (csr_mstatus_mprv & (~csr_halt_mode | csr_dcsr_mprven)) ? csr_mstatus_mpp : csr_cur_privilege;
        wire pmp_den = (effective_privilege == PRIVILEGE_MACHINE) ? pmp_mmode_en : pmp_en;
        assign pmp_resp_fault = (((effective_privilege != PRIVILEGE_MACHINE) | pmp_mmu_l) & ((pmp_req_store & ~pmp_mmu_w) | (~pmp_req_store & ~pmp_mmu_r)) | pmp_mmu_no_all_match) & pmp_den & ~pmp_permit_halt_mode;
        wire nds_unused_pmp_mmu_x = pmp_mmu_x;
        wire nds_unused_pmp_req_exec = pmp_req_exec;
        assign pmp_resp_permission[0] = ~(pmp_mmu_l & ((~pmp_mmu_r) | pmp_mmu_no_all_match) & pmp_mmode_en);
        assign pmp_resp_permission[1] = ~(pmp_mmu_l & ((~pmp_mmu_w) | pmp_mmu_no_all_match) & pmp_mmode_en);
        assign pmp_resp_permission[2] = ~(&((~pmp_mmu_r) | pmp_mmu_no_all_match) & pmp_en);
        assign pmp_resp_permission[3] = ~(&((~pmp_mmu_w) | pmp_mmu_no_all_match) & pmp_en);
    end
endgenerate
endmodule

