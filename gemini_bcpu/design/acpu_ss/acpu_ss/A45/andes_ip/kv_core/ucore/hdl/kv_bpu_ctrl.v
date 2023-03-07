// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_bpu_ctrl (
    core_clk,
    core_reset_n,
    resume,
    redirect,
    redirect_pc,
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
    ras_push,
    ras_pop,
    ras_push_addr,
    ras_pred_target,
    ras_pred_valid,
    bht_dir_rd_addr,
    bht_sel_rd_addr,
    bht_taken_rdata,
    bht_ntaken_rdata,
    bht_sel_rdata,
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
localparam BTB_TAG_WIDTH = VALEN - 1 - BTB_RAM_ADDR_WIDTH;
localparam BTB_TARGET_WIDTH = 16;
localparam BTB_BLK_OFFSET_WIDTH = 10;
localparam BTB_MMODE = 0;
localparam BTB_RET_BIT = 1;
localparam BTB_CALL_BIT = 2;
localparam BTB_UCOND_BIT = 3;
localparam BTB_OFFSET_LSB = 4;
localparam BTB_OFFSET_MSB = BTB_OFFSET_LSB + BTB_BLK_OFFSET_WIDTH - 1;
localparam BTB_TARGET_LSB = BTB_OFFSET_MSB + 1;
localparam BTB_TARGET_MSB = BTB_TARGET_LSB + BTB_TARGET_WIDTH - 1;
localparam BTB_TAG_LSB = BTB_TARGET_MSB + 1;
localparam BTB_TAG_MSB = BTB_TAG_LSB + BTB_TAG_WIDTH - 1;
localparam BTB_WAY_MERGE_BIT = BTB_TAG_MSB + 1;
localparam BTB_VALID_BIT = BTB_WAY_MERGE_BIT + 1;
localparam UNUSED_PC_BIT_NUM = 1;
localparam PRIVILEGE_MACHINE = 2'b11;
localparam TARGET_HIGH_PART_WIDTH = VALEN - BTB_TARGET_WIDTH - UNUSED_PC_BIT_NUM;
localparam TARGET_HIGH_PART_MSB = BTB_TAG_MSB;
localparam TARGET_HIGH_PART_LSB = BTB_TAG_MSB + 1 - TARGET_HIGH_PART_WIDTH;
input core_clk;
input core_reset_n;
input resume;
input redirect;
input [EXTVALEN - 1:0] redirect_pc;
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
output ras_push;
output ras_pop;
output [VALEN - 1:0] ras_push_addr;
input [VALEN - 1:0] ras_pred_target;
input ras_pred_valid;
output [7:0] bht_dir_rd_addr;
output [7:0] bht_sel_rd_addr;
input [1:0] bht_taken_rdata;
input [1:0] bht_ntaken_rdata;
input [1:0] bht_sel_rdata;


wire s0 = bpu_rd_valid & bpu_rd_ready;
wire s1 = 1'b1;
wire s2 = redirect | resume;
wire s3;
wire s4;
wire s5;
wire [9:0] s6;
wire s7;
wire s8;
wire s9;
wire [VALEN - 1:0] s10;
assign s3 = 1'b0;
assign s4 = 1'b0;
assign s5 = 1'b0;
assign s6 = 10'd0;
assign s7 = 1'b0;
assign s8 = 1'b0;
assign s9 = 1'b0;
assign s10 = {VALEN{1'b0}};
generate
    if (BTB_SIZE != 0) begin:gen_btb_pred_yes
        reg [5:1] s11;
        wire [5:1] s12;
        wire [5:1] s13;
        wire [5:1] s14;
        wire s15;
        wire [1:0] s16;
        wire s17;
        wire s18;
        reg s19;
        wire s20;
        reg s21;
        wire s22;
        reg s23;
        wire s24;
        wire s25;
        wire s26;
        reg [VALEN - 1:0] s27;
        reg [VALEN - 1:0] s28;
        wire [BTB_RAM_DATA_WIDTH - 1:0] s29;
        reg [BTB_RAM_DATA_WIDTH - 1:0] s30;
        wire [BTB_RAM_DATA_WIDTH - 1:0] s31;
        wire [BTB_RAM_DATA_WIDTH - 1:0] s32;
        reg [BTB_RAM_DATA_WIDTH - 1:0] s33;
        wire [BTB_RAM_DATA_WIDTH - 1:0] s34;
        wire [BTB_RAM_DATA_WIDTH - 1:0] s35;
        wire s36;
        wire s37;
        wire [VALEN - 1:0] s38;
        wire [VALEN - 1:0] s39;
        wire s40;
        reg s41;
        reg s42;
        reg s43;
        wire s44;
        reg s45;
        reg s46;
        reg s47;
        reg [VALEN - 1:0] s48;
        reg [9:0] s49;
        wire s50;
        wire [9:0] s51;
        reg [VALEN - 1:0] s52;
        wire [VALEN - 1:0] s53;
        reg s54;
        reg s55;
        wire s56;
        wire s57;
        wire s58;
        reg s59;
        reg s60;
        reg s61;
        wire s62;
        reg s63;
        reg s64;
        reg s65;
        reg [VALEN - 1:0] s66;
        reg [9:0] s67;
        reg [VALEN - 1:0] s68;
        reg s69;
        reg s70;
        wire s71;
        wire s72;
        wire [VALEN - 1:0] s73;
        reg s74;
        reg s75;
        wire [13:0] s76;
        wire [VALEN - 1:0] s77;
        wire [9:0] s78;
        wire s79;
        wire s80;
        wire s81;
        wire s82;
        wire s83;
        wire s84;
        wire s85;
        wire s86;
        wire s87;
        wire s88;
        reg s89;
        wire s90;
        wire s91;
        wire s92;
        wire [BTB_BLK_OFFSET_WIDTH - 1:0] s93;
        wire s94;
        wire s95;
        wire s96;
        wire s97;
        wire s98;
        wire s99;
        wire [TARGET_HIGH_PART_MSB:TARGET_HIGH_PART_LSB] s100;
        wire [BTB_TARGET_MSB:BTB_TARGET_LSB] s101;
        wire s102;
        wire s103;
        wire s104;
        wire s105;
        wire s106;
        wire [7:0] s107;
        wire [7:0] s108;
        reg [7:0] s109;
        wire [7:0] s110;
        wire [VALEN - 1:0] s111;
        reg [1:0] s112;
        reg [1:0] s113;
        reg [1:0] s114;
        wire [1:0] s115;
        wire s116;
        wire [VALEN - 1:0] s117;
        wire s118;
        wire s119;
        wire s120;
        wire s121;
        wire [VALEN - 1:0] s122;
        wire [3:0] s123;
        wire nds_unused_btb_pred_yes = s42 | s60;
        wire s124;
        wire s125;
        wire s126;
        wire s127;
        wire s128;
        wire s129;
        wire s130;
        wire s131;
        reg s132;
        wire s133;
        assign s126 = s41 & s96;
        assign s127 = s59 & s97;
        assign s128 = (s127 & ~s41) | (s127 & ~s96);
        assign s130 = s41 & ~s96 & ~s127 & ~btb_update_p0_hold;
        assign s131 = s59 & ~s97 & ~s41 & ~btb_update_p1_hold;
        assign s129 = (s126 | s130);
        assign s40 = s126 | (s130 & ~s2);
        assign s58 = s128 | (s131 & ~s2);
        assign s124 = (s41 & s2 & s42) | (s59 & s2 & s60);
        assign s125 = (btb_update_p0 & btb_update_p0_alloc & ~resume) | (btb_update_p1 & btb_update_p1_alloc & ~resume);
        assign s15 = s124 & s125;
        assign s79 = s124 | s125;
        assign s12 = s15 ? s11 : s125 ? s13 : s14;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s11 <= 5'b00001;
            end
            else if (s79) begin
                s11 <= s12;
            end
        end

        assign s13[1] = s11[5];
        assign s13[2] = s11[1];
        assign s13[3] = s11[2] ^ s11[5];
        assign s13[4] = s11[3];
        assign s13[5] = s11[4];
        assign s14[1] = s11[2];
        assign s14[2] = s11[3] ^ s11[1];
        assign s14[3] = s11[4];
        assign s14[4] = s11[5];
        assign s14[5] = s11[1];
        assign s16[0] = (s40 & ~s43) | (s40 & s54) | (s40 & s55) | (s58 & ~s61) | (s58 & s69) | (s58 & s70);
        assign s16[1] = (s40 & s43) | (s40 & s54) | (s40 & s55) | (s58 & s61) | (s58 & s69) | (s58 & s70);
        assign btb0_we = s16[0] | s89;
        assign btb1_we = s16[1] | s89;
        assign btb0_cs = btb0_we | s0;
        assign btb1_cs = btb1_we | s0;
        assign s76 = s0 ? s1 ? {s122[14:1]} : {s122[15:2]} : s129 ? s1 ? {s52[14:1]} : {s52[15:2]} : s1 ? {s68[14:1]} : {s68[15:2]};
        function  [6:0] gf_hash_67;
        input [13:0] addr;
        begin
            gf_hash_67[6] = addr[6] ^ addr[9] ^ addr[10] ^ addr[11] ^ addr[12] ^ addr[13];
            gf_hash_67[5] = addr[5] ^ addr[8] ^ addr[9] ^ addr[10] ^ addr[11] ^ addr[12] ^ addr[13];
            gf_hash_67[4] = addr[4] ^ addr[7] ^ addr[8] ^ addr[9] ^ addr[10] ^ addr[11] ^ addr[12] ^ addr[13];
            gf_hash_67[3] = addr[3] ^ addr[7] ^ addr[8] ^ addr[13];
            gf_hash_67[2] = addr[2] ^ addr[7] ^ addr[9] ^ addr[10] ^ addr[11];
            gf_hash_67[1] = addr[1] ^ addr[8] ^ addr[11] ^ addr[12] ^ addr[13];
            gf_hash_67[0] = addr[0] ^ addr[7] ^ addr[10] ^ addr[11] ^ addr[12] ^ addr[13];
        end
        endfunction
        wire [7:0] s134 = {s76[7],gf_hash_67(s76[13:0])};
        assign btb0_addr = s89 ? s49[BTB_RAM_ADDR_WIDTH - 1:0] : s134[BTB_RAM_ADDR_WIDTH - 1:0];
        assign btb1_addr = btb0_addr;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s27 <= {VALEN{1'b0}};
            end
            else if (s0) begin
                s27 <= s122;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s19 <= 1'b0;
                s21 <= 1'b0;
                s23 <= 1'b0;
            end
            else begin
                s19 <= s20;
                s21 <= s22;
                s23 <= s24;
            end
        end

        assign s20 = (s17 & ~s25 & ~s26 & ~redirect) | (s25 & ~s43 & ~redirect) | (s26 & ~s61 & ~redirect);
        assign s22 = (s18 & ~s25 & ~s26 & ~redirect) | (s25 & s43 & ~redirect) | (s26 & s61 & ~redirect);
        wire s135;
        assign s135 = s17 & btb0_rdata[BTB_WAY_MERGE_BIT] & btb1_rdata[BTB_VALID_BIT] & btb1_rdata[BTB_WAY_MERGE_BIT];
        assign s24 = (s135 & ~s25 & ~s26 & ~redirect) | (s25 & s54 & ~s55 & ~redirect) | (s26 & s69 & ~s70 & ~redirect);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s30 <= {BTB_RAM_DATA_WIDTH{1'b0}};
                s33 <= {BTB_RAM_DATA_WIDTH{1'b0}};
                s28 <= {VALEN{1'b0}};
            end
            else if (s74) begin
                s30 <= s31;
                s33 <= s34;
                s28 <= s27;
            end
        end

        wire s136;
        wire s137;
        wire s138;
        wire s139;
        assign s136 = s54 & s25;
        assign s137 = s69 & s26;
        assign s138 = s25 & ~s54;
        assign s139 = s26 & ~s69;
        assign s31 = ({BTB_RAM_DATA_WIDTH{s136}} & s32) | ({BTB_RAM_DATA_WIDTH{s137}} & s32) | ({BTB_RAM_DATA_WIDTH{s138 & ~s43}} & s32) | ({BTB_RAM_DATA_WIDTH{s139 & ~s61}} & s35) | ({BTB_RAM_DATA_WIDTH{~s26 & ~s25}} & btb0_rdata);
        assign s34 = ({BTB_RAM_DATA_WIDTH{s136}} & s35) | ({BTB_RAM_DATA_WIDTH{s137}} & s35) | ({BTB_RAM_DATA_WIDTH{s138 & s43}} & s32) | ({BTB_RAM_DATA_WIDTH{s139 & s61}} & s35) | ({BTB_RAM_DATA_WIDTH{~s26 & ~s25}} & btb1_rdata);
        assign s32[BTB_TAG_MSB:BTB_TAG_LSB] = s41 ? s52[VALEN - 1:VALEN - BTB_TAG_WIDTH] : s68[VALEN - 1:VALEN - BTB_TAG_WIDTH];
        assign s32[BTB_RET_BIT] = s41 ? s45 : s63;
        assign s32[BTB_CALL_BIT] = s41 ? s46 : s64;
        assign s32[BTB_UCOND_BIT] = s41 ? s47 : s65;
        assign s32[BTB_OFFSET_MSB:BTB_OFFSET_LSB] = s41 ? s49 : s67;
        assign s32[BTB_TARGET_MSB:BTB_TARGET_LSB] = s41 ? s1 ? s48[BTB_TARGET_WIDTH:1] : s48[BTB_TARGET_WIDTH + 1:2] : s1 ? s66[BTB_TARGET_WIDTH:1] : s66[BTB_TARGET_WIDTH + 1:2];
        assign s32[BTB_MMODE] = 1'b0;
        assign s32[BTB_WAY_MERGE_BIT] = 1'b0;
        assign s32[BTB_VALID_BIT] = 1'b0;
        assign s35[BTB_TAG_MSB:BTB_TAG_LSB] = (s41 & s54) ? s48[VALEN - 1:VALEN - BTB_TAG_WIDTH] : (s59 & s69) ? s66[VALEN - 1:VALEN - BTB_TAG_WIDTH] : s68[VALEN - 1:VALEN - BTB_TAG_WIDTH];
        assign s35[BTB_RET_BIT] = s63;
        assign s35[BTB_CALL_BIT] = s64;
        assign s35[BTB_UCOND_BIT] = s65;
        assign s35[BTB_OFFSET_MSB:BTB_OFFSET_LSB] = s67;
        assign s35[BTB_TARGET_MSB:BTB_TARGET_LSB] = s1 ? s66[BTB_TARGET_WIDTH:1] : s66[BTB_TARGET_WIDTH + 1:2];
        assign s35[BTB_MMODE] = 1'b0;
        assign s35[BTB_WAY_MERGE_BIT] = 1'b0;
        assign s35[BTB_VALID_BIT] = 1'b0;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s74 <= 1'b0;
                s75 <= 1'b0;
            end
            else begin
                s74 <= s0 & ~resume;
                s75 <= s74 & ~s2;
            end
        end

        wire s140;
        wire s141;
        wire s142;
        wire s143;
        assign s140 = (btb0_rdata[BTB_TAG_MSB:BTB_TAG_LSB] == {s27[VALEN - 1:VALEN - BTB_TAG_WIDTH]});
        assign s142 = ~((csr_cur_privilege == PRIVILEGE_MACHINE) ^ btb0_rdata[BTB_MMODE]);
        assign s141 = (btb1_rdata[BTB_TAG_MSB:BTB_TAG_LSB] == {s27[VALEN - 1:VALEN - BTB_TAG_WIDTH]});
        assign s143 = ~((csr_cur_privilege == PRIVILEGE_MACHINE) ^ btb1_rdata[BTB_MMODE]);
        assign s17 = btb0_rdata[BTB_VALID_BIT] & ~(btb0_rdata[BTB_WAY_MERGE_BIT] & ~btb1_rdata[BTB_WAY_MERGE_BIT]) & s140 & ~s2 & s142 & s74;
        assign s18 = btb1_rdata[BTB_VALID_BIT] & ~btb1_rdata[BTB_WAY_MERGE_BIT] & s141 & ~s2 & s143 & s74;
        assign s25 = (s27 == s52) & ~s96 & s41 & s74;
        assign s26 = (s27 == s68) & ~s97 & s59 & s74;
        assign s121 = (s19 | s21 | s23) & csr_mmisc_ctl_brpe & ~csr_halt_mode & ~s89;
        assign s29 = ({BTB_RAM_DATA_WIDTH{s19 | s23}} & s30) | ({BTB_RAM_DATA_WIDTH{s21 & ~s23}} & s33);
        assign s100 = s23 ? s33[TARGET_HIGH_PART_MSB:TARGET_HIGH_PART_LSB] : s28[VALEN - 1:BTB_TARGET_WIDTH + UNUSED_PC_BIT_NUM];
        assign s101 = s29[BTB_TARGET_MSB:BTB_TARGET_LSB];
        assign s104 = s29[BTB_CALL_BIT] & ~s29[BTB_UCOND_BIT];
        assign s119 = s29[BTB_CALL_BIT] & s118;
        assign s118 = s29[BTB_UCOND_BIT];
        assign s120 = s29[BTB_RET_BIT];
        assign s77 = {s100,s101,{UNUSED_PC_BIT_NUM{1'b0}}};
        assign s78 = s29[BTB_OFFSET_MSB:BTB_OFFSET_LSB];
        assign s81 = (btb_update_p0 & ~resume);
        assign s82 = s40 | resume | redirect | s133;
        assign s83 = (s41 & ~s82) | s81;
        assign s84 = s81 | s82;
        assign s98 = btb_update_p0_ret & btb_update_p0_call & ~btb_update_p0_ucond;
        assign s102 = s3 | (s1 ? btb_update_p0_start_pc[VALEN - 1:BTB_TARGET_WIDTH + 1] != btb_update_p0_target_pc[VALEN - 1:BTB_TARGET_WIDTH + 1] : btb_update_p0_start_pc[VALEN - 1:BTB_TARGET_WIDTH + 2] != btb_update_p0_target_pc[VALEN - 1:BTB_TARGET_WIDTH + 2]);
        assign s103 = s3 | (s1 ? btb_update_p1_start_pc[VALEN - 1:BTB_TARGET_WIDTH + 1] != btb_update_p1_target_pc[VALEN - 1:BTB_TARGET_WIDTH + 1] : btb_update_p1_start_pc[VALEN - 1:BTB_TARGET_WIDTH + 2] != btb_update_p1_target_pc[VALEN - 1:BTB_TARGET_WIDTH + 2]);
        assign s57 = (s98 & (&btb_update_p0_way)) | (s102 & ~btb_update_p0_ret);
        assign s56 = ~s57 & ~btb_update_p0_alloc & (&btb_update_p0_way);
        assign s85 = (btb_update_p1 & ~resume);
        assign s86 = s58 | resume | redirect | s133;
        assign s87 = (s59 & ~s86) | s85;
        assign s88 = s85 | s86;
        assign s99 = btb_update_p1_ret & btb_update_p1_call & ~btb_update_p1_ucond;
        assign s72 = (s99 & (&btb_update_p1_way)) | (s103 & ~btb_update_p1_ret);
        assign s71 = ~s72 & ~btb_update_p1_alloc & (&btb_update_p1_way);
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s41 <= 1'b0;
            end
            else if (s84) begin
                s41 <= s83;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s59 <= 1'b0;
            end
            else if (s88) begin
                s59 <= s87;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s45 <= 1'b0;
                s46 <= 1'b0;
                s47 <= 1'b0;
                s48 <= {VALEN{1'b0}};
                s42 <= 1'b0;
                s43 <= 1'b0;
                s54 <= 1'b0;
                s55 <= 1'b0;
            end
            else if (s81) begin
                s45 <= btb_update_p0_ret;
                s46 <= btb_update_p0_call;
                s47 <= btb_update_p0_ucond;
                s48 <= btb_update_p0_target_pc;
                s42 <= btb_update_p0_alloc;
                s43 <= s44;
                s54 <= s57;
                s55 <= s56;
            end
        end

        assign s94 = s81;
        assign s53 = btb_update_p0_start_pc;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s52 <= {VALEN{1'b0}};
            end
            else if (s94) begin
                s52 <= s53;
            end
        end

        assign s50 = s81 | s89 | s133;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s49 <= {BTB_BLK_OFFSET_WIDTH{1'b0}};
            end
            else if (s50) begin
                s49 <= s51;
            end
        end

        assign s51 = s133 ? {BTB_BLK_OFFSET_WIDTH{1'b0}} : s81 ? btb_update_p0_blk_offset : s49 + s93;
        kv_zero_ext #(
            .OW(BTB_BLK_OFFSET_WIDTH),
            .IW(1)
        ) u_btb_int_incr1_zext (
            .out(s93),
            .in(1'b1)
        );
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s63 <= 1'b0;
                s64 <= 1'b0;
                s65 <= 1'b0;
                s66 <= {VALEN{1'b0}};
                s67 <= {BTB_BLK_OFFSET_WIDTH{1'b0}};
                s60 <= 1'b0;
                s61 <= 1'b0;
                s69 <= 1'b0;
                s70 <= 1'b0;
            end
            else if (s85) begin
                s63 <= btb_update_p1_ret;
                s64 <= btb_update_p1_call;
                s65 <= btb_update_p1_ucond;
                s66 <= btb_update_p1_target_pc;
                s67 <= btb_update_p1_blk_offset;
                s60 <= btb_update_p1_alloc;
                s61 <= s62;
                s69 <= s72;
                s70 <= s71;
            end
        end

        assign s95 = s85;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s68 <= {VALEN{1'b0}};
            end
            else if (s95) begin
                s68 <= btb_update_p1_start_pc;
            end
        end

        assign s44 = btb_update_p0_alloc ? s11[5] : btb_update_p0_way[1];
        assign s62 = btb_update_p1_alloc ? s11[5] : btb_update_p1_way[1];
        assign s96 = s45 & s46 & ~s47;
        assign s97 = s63 & s64 & ~s65;
        assign btb0_wdata[BTB_MMODE] = (csr_cur_privilege == PRIVILEGE_MACHINE);
        assign btb0_wdata[BTB_RET_BIT] = s129 ? s45 : s63;
        assign btb0_wdata[BTB_CALL_BIT] = s129 ? s46 : s64;
        assign btb0_wdata[BTB_UCOND_BIT] = s129 ? s47 : s65;
        assign btb0_wdata[BTB_TARGET_MSB:BTB_TARGET_LSB] = s129 ? s1 ? s48[BTB_TARGET_WIDTH:1] : s48[BTB_TARGET_WIDTH + 1:2] : s1 ? s66[BTB_TARGET_WIDTH:1] : s66[BTB_TARGET_WIDTH + 1:2];
        assign btb0_wdata[BTB_OFFSET_MSB:BTB_OFFSET_LSB] = s129 ? s49 : s67;
        assign btb0_wdata[BTB_TAG_MSB:BTB_TAG_LSB] = s129 ? {s52[VALEN - 1:VALEN - BTB_TAG_WIDTH]} : {s68[VALEN - 1:VALEN - BTB_TAG_WIDTH]};
        assign btb0_wdata[BTB_WAY_MERGE_BIT] = s129 ? s54 : s69;
        assign btb0_wdata[BTB_VALID_BIT] = ~s89 & ~s126 & ~s128 & ~(s130 & s43 & s55) & ~(s131 & s61 & s70);
        assign btb1_wdata[BTB_MMODE] = btb0_wdata[BTB_MMODE];
        assign btb1_wdata[BTB_RET_BIT] = btb0_wdata[BTB_RET_BIT];
        assign btb1_wdata[BTB_CALL_BIT] = btb0_wdata[BTB_CALL_BIT];
        assign btb1_wdata[BTB_UCOND_BIT] = btb0_wdata[BTB_UCOND_BIT];
        assign btb1_wdata[BTB_TARGET_MSB:BTB_TARGET_LSB] = btb0_wdata[BTB_TARGET_MSB:BTB_TARGET_LSB];
        assign btb1_wdata[BTB_OFFSET_MSB:BTB_OFFSET_LSB] = btb0_wdata[BTB_OFFSET_MSB:BTB_OFFSET_LSB];
        assign btb1_wdata[BTB_TAG_MSB:BTB_TAG_LSB] = btb0_wdata[BTB_WAY_MERGE_BIT] ? s41 ? s48[VALEN - 1:VALEN - BTB_TAG_WIDTH] : s66[VALEN - 1:VALEN - BTB_TAG_WIDTH] : btb0_wdata[BTB_TAG_MSB:BTB_TAG_LSB];
        assign btb1_wdata[BTB_WAY_MERGE_BIT] = btb0_wdata[BTB_WAY_MERGE_BIT];
        assign btb1_wdata[BTB_VALID_BIT] = ~s89 & ~s126 & ~s128 & ~(s130 & ~s43 & s55) & ~(s131 & ~s61 & s70);
        assign s36 = (s121 & s118 & ~s120) | (s121 & ~s118 & s116);
        assign s80 = s36 | (s121 & s120);
        assign s38 = {{(VALEN - 10 - UNUSED_PC_BIT_NUM){1'b0}},{s78[9:0]},{UNUSED_PC_BIT_NUM{1'b0}}};
        assign s117 = s28 + s38;
        assign s39 = s77;
        assign s37 = ~s80;
        assign s73 = ({VALEN{(s121 & s120 & ras_pred_valid)}} & ras_pred_target) | ({VALEN{(s121 & s120 & ~ras_pred_valid)}} & s117) | ({VALEN{s36}} & (s39));
        reg [VALEN - 1:0] s144;
        wire s145;
        wire [VALEN - 1:0] s146;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s144 <= {VALEN{1'b0}};
            end
            else if (s145) begin
                s144 <= s146;
            end
        end

        assign s145 = redirect | s121;
        assign s146 = redirect ? redirect_pc[VALEN - 1:0] : bpu_info_target[VALEN - 1:0];
        assign s122 = redirect ? redirect_pc[VALEN - 1:0] : s121 ? bpu_info_target : s144;
        assign bpu_info_target = s73 | ({VALEN{~s5 & s37}} & (s117) | {VALEN{s5 & s37}} & s10);
        assign bpu_info_offset = {10{~s5}} & s78 | {10{s5}} & s6;
        assign bpu_info_way = {s21 | s23,s19 | s23};
        assign bpu_info_pred_taken = s80;
        assign bpu_rd_ack = s75;
        assign bpu_rd_ready = ~btb0_we & ~btb1_we;
        assign bpu_info_start_pc = s28;
        assign bpu_info_pred_cnt = s123;
        assign bpu_info_fall_thru_pc = s117;
        assign bpu_info_ucond = ~s5 & s118 | s5 & s8;
        assign bpu_info_hit = s121;
        assign bpu_info_ret = ~s5 & s120 | s5 & s9;
        assign s92 = (&s49[BTB_RAM_ADDR_WIDTH - 1:0]) & s89;
        assign s91 = s92 | s133 | (btb_flush_valid & resume);
        assign s90 = (s92 | (btb_flush_valid & resume)) ? 1'b0 : 1'b1;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s89 <= 1'b1;
            end
            else if (s91) begin
                s89 <= s90;
            end
        end

        assign btb_init_done = ~s89;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s109 <= 8'b0;
            end
            else if (s105) begin
                s109 <= s107;
            end
        end

        assign s110 = s109;
        assign s106 = ~csr_halt_mode & csr_mmisc_ctl_brpe & bhr_recover;
        assign s105 = s106 | (s121 & ~s118);
        assign s107 = s106 ? bhr_recover_data[7:0] : (s121 & ~s118) ? s108 : s109;
        assign s108 = {s116,s109[7:1]};
        assign s111 = s27;
        assign bht_dir_rd_addr[7:0] = s1 ? (s111[8:1] ^ s110) : (s111[9:2] ^ s110);
        assign bht_sel_rd_addr[7:0] = s1 ? s111[8:1] : s111[9:2];
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s112 <= 2'b0;
                s113 <= 2'b0;
                s114 <= 2'b0;
            end
            else if (s74) begin
                s112 <= bht_taken_rdata;
                s113 <= bht_ntaken_rdata;
                s114 <= bht_sel_rdata;
            end
        end

        assign s115 = (s114[1] == 1'b1) ? s112 : s113;
        assign s123 = {s114,s115};
        assign s116 = (s104 ? ~(s115[1:0] == 2'b0) : s115[1]) & ~s4;
        assign ras_push_addr = s117;
        assign ras_push = s121 & s119;
        assign ras_pop = s121 & s120;
        reg s147;
        wire s148;
        wire s149;
        assign s149 = s147 | (s92 & s132);
        assign s148 = ~s147;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s147 <= 1'b0;
            end
            else if (s149) begin
                s147 <= s148;
            end
        end

        assign s133 = btb_flush_valid & ~s132;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s132 <= 1'b0;
            end
            else begin
                s132 <= btb_flush_valid;
            end
        end

        assign btb_flush_ready = s147;
    end
    else begin:gen_btb_pred_no
        assign ras_push_addr = {VALEN{1'b0}};
        assign ras_push = 1'b0;
        assign ras_pop = 1'b0;
        assign bpu_info_way = 1'b0;
        assign btb0_we = 1'b0;
        assign btb0_cs = 1'b0;
        assign btb0_addr = {(BTB_RAM_ADDR_WIDTH){1'b0}};
        assign btb0_wdata = {BTB_RAM_DATA_WIDTH{1'b0}};
        assign btb1_we = 1'b0;
        assign btb1_cs = 1'b0;
        assign btb1_addr = {(BTB_RAM_ADDR_WIDTH){1'b0}};
        assign btb1_wdata = {BTB_RAM_DATA_WIDTH{1'b0}};
        assign bpu_info_target = {VALEN{1'b0}};
        assign bpu_info_start_pc = {VALEN{1'b0}};
        assign bpu_info_offset = 10'b0;
        assign bpu_info_pred_taken = 1'b0;
        assign bpu_info_pred_cnt = 4'b0;
        assign bpu_info_fall_thru_pc = {VALEN{1'b0}};
        assign bpu_info_ucond = 1'b0;
        assign bpu_info_hit = 1'b0;
        assign bpu_info_ret = 1'b0;
        assign bpu_rd_ack = 1'b0;
        assign bpu_rd_ready = 1'b1;
        assign btb_init_done = 1'b1;
        assign btb_flush_ready = btb_flush_valid;
        assign bht_dir_rd_addr = 8'b0;
        assign bht_sel_rd_addr = 8'b0;
    end
endgenerate
endmodule

