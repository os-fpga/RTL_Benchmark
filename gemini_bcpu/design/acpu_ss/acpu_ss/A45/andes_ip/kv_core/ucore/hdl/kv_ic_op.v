// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_ic_op (
    core_clk,
    core_reset_n,
    icache_disable_init,
    ic_self_reset_on,
    resume,
    redirect,
    ifu_cctl_req,
    ifu_cctl_command,
    ifu_cctl_waddr,
    ifu_cctl_wdata,
    ifu_cctl_ack,
    ifu_cctl_status,
    ifu_cctl_ecc_status,
    ifu_cctl_rdata,
    ifu_cctl_raddr,
    icu_ifu_resp_status,
    icu_ifu_resp_rdata,
    f2_itlb_miss,
    f2_itlb_page_fault,
    f2_itlb_bus_error,
    f2_itlb_ecc_xcpt,
    f2_itlb_ecc_corr,
    f2_itlb_ecc_ramid,
    f2_itlb_ecc_code,
    f2_pmp_fault,
    f2_pma_fault,
    f2_fetch_data_ecc_xcpt,
    f2_ecc_replay,
    f2_cctl_cacheability,
    all_mmu_req_done,
    icu_ifu_line_aq_done,
    icu_ifu_line_aq_error,
    fencei_req,
    fencei_done,
    ic_op_req_pulse,
    line_op_done,
    ic_op_valid,
    ic_op_wdata,
    ic_op_addr,
    cache_flush_index
);
parameter ICACHE_SIZE_KB = 0;
parameter ICACHE_TAG_RAM_AW = 0;
parameter TAG_DW = 32;
parameter VALEN = 32;
parameter ICACHE_WAY = 2;
localparam TAG_WR_SET = 5'd17;
localparam TAG_RD_SET = 5'd1;
localparam TAG_RD_ISSUE = 5'd2;
localparam TAG_RD_F1 = 5'd3;
localparam DATA_WR_SET = 5'd4;
localparam DATA_RD_SET = 5'd5;
localparam DATA_RD_ISSUE = 5'd6;
localparam DATA_RD_F1 = 5'd7;
localparam TLB_FILL = 5'd8;
localparam DONE = 5'd9;
localparam PREF_SET = 5'd10;
localparam PREF_ISSUE = 5'd11;
localparam PREF_F1 = 5'd12;
localparam PREF_F2 = 5'd13;
localparam LINE_AQ_SET = 5'd14;
localparam LINE_AQ = 5'd15;
localparam ECC_INV = 5'd16;
localparam IDLE = 5'd0;
localparam CCTL_ST_BIT = 5;
input core_clk;
input core_reset_n;
input icache_disable_init;
input ic_self_reset_on;
input resume;
input redirect;
input [35:0] icu_ifu_resp_status;
input [63:0] icu_ifu_resp_rdata;
input ifu_cctl_req;
input [4:0] ifu_cctl_command;
input [31:0] ifu_cctl_waddr;
input [31:0] ifu_cctl_wdata;
output ifu_cctl_ack;
output [4:0] ifu_cctl_status;
output [11:0] ifu_cctl_ecc_status;
output [31:0] ifu_cctl_rdata;
output [31:0] ifu_cctl_raddr;
input fencei_req;
output fencei_done;
output ic_op_req_pulse;
input line_op_done;
output [8:0] ic_op_valid;
output [VALEN - 1:0] ic_op_addr;
output [71:0] ic_op_wdata;
input [ICACHE_TAG_RAM_AW - 1:0] cache_flush_index;
input f2_itlb_miss;
input f2_itlb_page_fault;
input f2_itlb_bus_error;
input f2_itlb_ecc_xcpt;
input f2_itlb_ecc_corr;
input [2:0] f2_itlb_ecc_ramid;
input [7:0] f2_itlb_ecc_code;
input f2_pmp_fault;
input f2_pma_fault;
input f2_fetch_data_ecc_xcpt;
input f2_ecc_replay;
input f2_cctl_cacheability;
input all_mmu_req_done;
input icu_ifu_line_aq_done;
input icu_ifu_line_aq_error;


wire s0 = (ifu_cctl_command == 5'b11011);
wire s1 = (ifu_cctl_command == 5'b11101);
wire s2 = (ifu_cctl_command == 5'b11100);
wire s3 = (ifu_cctl_command == 5'b11110);
wire s4 = (ifu_cctl_command == 5'b11000);
wire s5 = (ifu_cctl_command == 5'b01000);
wire s6 = (ifu_cctl_command == 5'b01011);
wire s7 = (ifu_cctl_command == 5'b01100);
wire s8 = ifu_cctl_command[4];
generate
    if (ICACHE_SIZE_KB != 0) begin:gen_ic_op_yes
        wire s9;
        wire s10;
        wire s11;
        wire s12;
        reg s13;
        reg s14;
        wire s15;
        wire s16;
        reg [CCTL_ST_BIT - 1:0] s17;
        reg [CCTL_ST_BIT - 1:0] s18;
        wire [31:0] s19;
        wire [31:0] s20;
        wire [3:0] s21;
        wire [1:0] s22;
        wire [3:0] s23;
        wire [ICACHE_TAG_RAM_AW - 1:0] s24;
        wire [TAG_DW - 1:0] s25;
        wire [71:0] s26;
        wire [71:0] s27;
        wire [1:0] s28;
        wire [1:0] s29;
        wire [ICACHE_TAG_RAM_AW - 1:0] s30;
        wire s31;
        wire [3:0] s32;
        wire [ICACHE_TAG_RAM_AW + 7:0] s33;
        wire [ICACHE_TAG_RAM_AW - 1:0] s34;
        wire s35;
        wire s36 = icu_ifu_resp_status[22];
        wire [3:0] s37 = icu_ifu_resp_status[18 +:4];
        wire [3:0] s38 = icu_ifu_resp_status[1 +:4];
        wire [1:0] s39 = icu_ifu_resp_status[5 +:2];
        wire [2:0] s40 = f2_itlb_ecc_xcpt ? {f2_itlb_ecc_ramid[2:0]} : {1'b0,s39[1:0]};
        wire s41 = f2_itlb_ecc_xcpt ? f2_itlb_ecc_corr : icu_ifu_resp_status[15];
        wire [7:0] s42 = f2_itlb_ecc_xcpt ? f2_itlb_ecc_code : icu_ifu_resp_status[7 +:8];
        wire [11:0] s43 = {s41,s40,s42};
        wire s44;
        wire s45;
        reg s46;
        wire s47;
        wire s48;
        wire [31:0] s49;
        wire [ICACHE_TAG_RAM_AW + 9:0] s50;
        wire [VALEN - 1:0] s51;
        wire [VALEN - 1:0] s52;
        reg [4:0] s53;
        wire [4:0] s54;
        wire s55;
        reg [3:0] s56;
        reg [3:0] s57;
        reg [11:0] s58;
        reg [TAG_DW - 4:0] s59;
        wire [TAG_DW - 4:0] s60;
        reg s61;
        assign s55 = (s17 == PREF_F2) | icu_ifu_line_aq_error;
        assign s54[0] = (f2_fetch_data_ecc_xcpt & ~f2_itlb_miss) | f2_itlb_ecc_xcpt;
        assign s54[1] = f2_pmp_fault & ~s54[0];
        assign s54[2] = f2_pma_fault & ~(|s54[1:0]);
        assign s54[3] = (f2_itlb_bus_error | icu_ifu_line_aq_error) & ~(|s54[2:0]);
        assign s54[4] = f2_itlb_page_fault;
        assign s60 = icu_ifu_resp_rdata[TAG_DW - 4:0];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s53 <= 5'b0;
                s56 <= 4'b0;
                s57 <= 4'b0;
                s59 <= {(TAG_DW - 3){1'b0}};
                s58 <= 12'b0;
            end
            else if (s55) begin
                s53 <= s54;
                s56 <= s37;
                s57 <= s38;
                s59 <= s60;
                s58 <= s43;
            end
        end

        assign s35 = f2_itlb_page_fault | f2_itlb_bus_error | f2_itlb_ecc_xcpt | f2_pmp_fault | f2_pma_fault;
        assign s16 = (s17 == IDLE) & ifu_cctl_req & line_op_done;
        assign ifu_cctl_ecc_status = s8 ? s43 : s58;
        always @* begin
            if (resume | redirect) begin
                s18 = IDLE;
            end
            else begin
                case (s17)
                    IDLE: begin
                        if (s16) begin
                            if (s1 | s4) begin
                                s18 = TAG_WR_SET;
                            end
                            else if (s0) begin
                                s18 = TAG_RD_SET;
                            end
                            else if (s2) begin
                                s18 = DATA_RD_SET;
                            end
                            else if (s3) begin
                                s18 = DATA_WR_SET;
                            end
                            else begin
                                s18 = PREF_SET;
                            end
                        end
                        else begin
                            s18 = IDLE;
                        end
                    end
                    PREF_SET: s18 = PREF_ISSUE;
                    PREF_ISSUE: s18 = PREF_F1;
                    PREF_F1: s18 = PREF_F2;
                    PREF_F2: s18 = f2_itlb_miss ? TLB_FILL : f2_fetch_data_ecc_xcpt & ~s41 ? DONE : f2_fetch_data_ecc_xcpt ? ECC_INV : s35 ? DONE : f2_ecc_replay ? ECC_INV : s6 ? s44 ? DONE : s36 ? LINE_AQ_SET : TAG_WR_SET : s36 ? DONE : TAG_WR_SET;
                    LINE_AQ_SET: s18 = LINE_AQ;
                    LINE_AQ: s18 = icu_ifu_line_aq_error ? DONE : icu_ifu_line_aq_done ? IDLE : LINE_AQ;
                    TLB_FILL: s18 = all_mmu_req_done ? PREF_SET : TLB_FILL;
                    TAG_WR_SET: s18 = DONE;
                    TAG_RD_SET: s18 = TAG_RD_ISSUE;
                    TAG_RD_ISSUE: s18 = TAG_RD_F1;
                    TAG_RD_F1: s18 = DONE;
                    DATA_WR_SET: s18 = DONE;
                    DATA_RD_SET: s18 = DATA_RD_ISSUE;
                    DATA_RD_ISSUE: s18 = DATA_RD_F1;
                    DATA_RD_F1: s18 = DONE;
                    ECC_INV: s18 = s53[0] ? DONE : IDLE;
                    DONE: s18 = IDLE;
                    default: begin
                        s18 = {CCTL_ST_BIT{1'b0}};
                    end
                endcase
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s17 <= {CCTL_ST_BIT{1'b0}};
            end
            else begin
                s17 <= s18;
            end
        end

        assign ic_op_req_pulse = ((fencei_req | ifu_cctl_req) & ~s14) | (icu_ifu_line_aq_done & (s17 == LINE_AQ)) | (s17 == ECC_INV);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s14 <= 1'b0;
            end
            else begin
                s14 <= s15;
            end
        end

        assign s15 = fencei_req | ifu_cctl_req;
        assign s9 = (fencei_req & line_op_done) | (ic_self_reset_on & ~s13 & ~icache_disable_init & ~(&cache_flush_index));
        assign s10 = (&cache_flush_index[ICACHE_TAG_RAM_AW - 1:1] & ~cache_flush_index[0] & s61) | resume | redirect;
        assign s11 = (s13 | s9) & ~s10;
        assign s12 = s9 | s10;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s13 <= 1'b0;
            end
            else if (s12) begin
                s13 <= s11;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s61 <= 1'b0;
            end
            else begin
                s61 <= s13;
            end
        end

        assign fencei_done = fencei_req & s14 & (&cache_flush_index) & s61;
        assign ic_op_valid[0] = s13;
        assign ic_op_valid[1] = (s17 == PREF_SET);
        assign ic_op_valid[2] = (s17 == TAG_RD_SET);
        assign ic_op_valid[3] = (s17 == TAG_WR_SET) | (s17 == ECC_INV);
        assign ic_op_valid[4] = (s17 == DATA_RD_SET);
        assign ic_op_valid[5] = (s17 == DATA_WR_SET);
        assign ic_op_valid[6] = (s17 == LINE_AQ_SET);
        assign ic_op_valid[8] = (s17 == ECC_INV);
        assign ic_op_valid[7] = (s17 == PREF_F2) & f2_itlb_miss;
        assign s25 = (s17 == ECC_INV) ? {TAG_DW{1'b0}} : s1 ? {ifu_cctl_wdata[31:29],ifu_cctl_wdata[TAG_DW - 4:0]} : {~s5,~s7,~s7,s59};
        kv_zero_ext #(
            .OW(72),
            .IW(TAG_DW)
        ) u_tag_wr_data_zext (
            .out(s26),
            .in(s25)
        );
        kv_zero_ext #(
            .OW(72),
            .IW(32)
        ) u_data_wr_data_zext (
            .out(s27),
            .in(ifu_cctl_wdata[31:0])
        );
        assign s50 = (s17 == ECC_INV) ? {s57,s24,6'b0} : s8 ? {s21,s24,s23[3:0],2'b0} : {s56,s24,6'b0};
        kv_zero_ext #(
            .OW(VALEN),
            .IW(ICACHE_TAG_RAM_AW + 10)
        ) u_idx_rw_addr_zext (
            .out(s51),
            .in(s50)
        );
        assign s52 = {ifu_cctl_waddr[VALEN - 1:6],6'b100000};
        assign ic_op_addr = ic_op_valid[1] ? s52 : s51;
        assign ic_op_wdata = ~ifu_cctl_req ? {72{1'b0}} : s4 ? {72{1'b0}} : (s1 | ~s8) ? s26 : ifu_cctl_waddr[2] ? {8'b0,s27[31:0],32'b0} : s27;
        assign ifu_cctl_ack = (s17 == DONE);
        assign ifu_cctl_status = s53 & {5{~s8}};
        kv_zero_ext #(
            .OW(32),
            .IW(32)
        ) u_word1_rdata_zext (
            .out(s20),
            .in(icu_ifu_resp_rdata[63:32])
        );
        kv_zero_ext #(
            .OW(32),
            .IW(32)
        ) u_word0_rdata_zext (
            .out(s19),
            .in(icu_ifu_resp_rdata[31:0])
        );
        assign s44 = ~f2_cctl_cacheability;
        assign s48 = s44;
        assign s47 = s6 & (s17 == PREF_F2);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s46 <= 1'b0;
            end
            else if (s47) begin
                s46 <= s48;
            end
        end

        assign s45 = ~s46;
        kv_zero_ext #(
            .OW(32),
            .IW(1)
        ) u_lock_fail_rdata_zext (
            .out(s49),
            .in(s45)
        );
        wire [31:0] s62;
        kv_zero_ext #(
            .OW(32),
            .IW(TAG_DW - 3)
        ) u_resp_rdata_zext (
            .out(s62),
            .in(icu_ifu_resp_rdata[TAG_DW - 4:0])
        );
        assign ifu_cctl_rdata = s6 ? s49 : s0 ? {icu_ifu_resp_rdata[63:61],s62[28:0]} : s23[0] ? s20 : s19;
        assign ifu_cctl_raddr = s8 ? {ifu_cctl_waddr[31:ICACHE_TAG_RAM_AW + 8],s33} : {ifu_cctl_waddr[31:0]} + {{25{1'b0}},7'b1000000};
        assign s23 = ifu_cctl_waddr[5:2];
        assign s24 = ifu_cctl_waddr[ICACHE_TAG_RAM_AW + 5:6];
        assign s22 = ifu_cctl_waddr[ICACHE_TAG_RAM_AW + 7:ICACHE_TAG_RAM_AW + 6];
        assign s21[0] = (s22 == 2'd0);
        assign s21[1] = (s22 == 2'd1);
        assign s21[2] = (s22 == 2'd2);
        assign s21[3] = (s22 == 2'd3);
        kv_zero_ext #(
            .OW(ICACHE_TAG_RAM_AW),
            .IW(1)
        ) u_idx_incr1_zext (
            .out(s34),
            .in(1'b1)
        );
        assign s29 = (ICACHE_WAY == 1) ? s22 : (ICACHE_WAY == 2) ? {s22[1],~s22[0]} : s22 + 2'b1;
        assign s28 = (s0 | s1 | s4) ? s29 : (&s23) ? s29 : s22;
        assign s31 = (ICACHE_WAY == 1) | ((ICACHE_WAY == 2) & (s22[0])) | ((ICACHE_WAY == 4) & (&s22));
        assign s30 = (s0 | s1 | s4) & s31 ? s24 + s34 : (&s23) & s31 ? s24 + s34 : s24;
        assign s32 = (s2 | s3) ? s23 + 4'b1 : s23;
        assign s33 = {s28,s30,s32,2'b0};
    end
    else begin:gen_ic_op_no
        wire nds_unused_ic_op_no;
        assign nds_unused_ic_op_no = core_clk | core_reset_n | resume | (|cache_flush_index) | (|ifu_cctl_waddr) | f2_pmp_fault | f2_ecc_replay | line_op_done | (|icu_ifu_resp_rdata) | f2_itlb_miss | f2_cctl_cacheability | ic_self_reset_on | redirect | f2_itlb_bus_error | f2_itlb_page_fault | f2_itlb_ecc_xcpt | f2_itlb_ecc_corr | (|f2_itlb_ecc_ramid) | (|f2_itlb_ecc_code) | f2_pma_fault | icache_disable_init | all_mmu_req_done | icu_ifu_line_aq_done | f2_fetch_data_ecc_xcpt | (|ifu_cctl_wdata) | icu_ifu_line_aq_error | (|icu_ifu_resp_status) | s5 | s8 | s4 | s7 | s1 | s2 | s3 | ifu_cctl_req | (|s0) | s6;
        assign fencei_done = fencei_req;
        assign ic_op_valid[0] = 1'b0;
        assign ic_op_valid[1] = 1'b0;
        assign ic_op_valid[2] = 1'b0;
        assign ic_op_valid[3] = 1'b0;
        assign ic_op_valid[4] = 1'b0;
        assign ic_op_valid[5] = 1'b0;
        assign ic_op_valid[6] = 1'b0;
        assign ic_op_valid[7] = 1'b0;
        assign ic_op_valid[8] = 1'b0;
        assign ic_op_req_pulse = 1'b0;
        assign ic_op_addr = {VALEN{1'b0}};
        assign ic_op_wdata = {72{1'b0}};
        assign ifu_cctl_ack = 1'b1;
        assign ifu_cctl_status = 5'b0;
        assign ifu_cctl_rdata = {32{1'b0}};
        assign ifu_cctl_raddr = {32{1'b0}};
        assign ifu_cctl_ecc_status = 12'b0;
    end
endgenerate
endmodule

