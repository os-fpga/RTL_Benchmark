// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_uins_pp (
    core_clk,
    core_reset_n,
    instr,
    ucode_exe,
    ucode_idx,
    pp_ucode_ctrl,
    pp_ucode_xcpt,
    pp_ucode_last,
    pp_init_pc_en,
    pp_init_pc,
    pp_offset,
    pp_stackadj,
    pp_ucode_ctrl_ext
);
parameter ABI = 0;
localparam PP16_SUPPORT = 1'b0;
localparam PP32_SUPPORT = 1'b0;
localparam PP_M_VAL = 4;
localparam PP_ALIGN_BYTES = 16;
localparam PP_ALIGN_SHAMT = $clog2(PP_ALIGN_BYTES);
localparam PP_MAX_SPIMM = 7;
localparam PP_MAX_R = 13;
localparam PP_MAX_N = PP_ALIGN_BYTES * (((PP_MAX_R + 1) / 2) + PP_MAX_SPIMM);
localparam PP_SPIMM_WIDTH = $clog2(PP_MAX_SPIMM);
localparam PP_R_WIDTH = $clog2(PP_MAX_R);
localparam PP_N_WIDTH = $clog2(PP_MAX_N) + 1;
localparam PP_ALIGN_R_LSB = $clog2(PP_ALIGN_BYTES / PP_M_VAL);
localparam PP_ALIGN_R_WIDTH = (PP_R_WIDTH - PP_ALIGN_R_LSB) + 1;
localparam PP_R2BYTES_SHAMT = $clog2(PP_M_VAL);
input core_clk;
input core_reset_n;
input [31:0] instr;
input ucode_exe;
input [3:0] ucode_idx;
output [2:0] pp_ucode_ctrl;
output pp_ucode_xcpt;
output pp_ucode_last;
output pp_init_pc_en;
output [3:0] pp_init_pc;
output [11:0] pp_offset;
output [11:0] pp_stackadj;
output [2:0] pp_ucode_ctrl_ext;


wire instr_pp_c_pop;
wire instr_pp_c_popret;
wire instr_pp_c_push;
wire pp_pop;
wire pp_popret;
wire pp_push;
wire pp_valid;
wire pp_ucode_exe;
wire pp_ucode_1st;
wire pp_ucode_last;
wire pp_ucode_load2ra;
wire [2:0] pp_16b_rcount;
wire [2:0] pp_16b_spimm;
wire [(PP_SPIMM_WIDTH - 1):0] pp_spimm;
wire [(PP_R_WIDTH - 1):0] pp_r;
wire [(PP_ALIGN_R_WIDTH - 1):0] pp_aligned_r;
wire [(PP_N_WIDTH - 1):0] pp_N;
wire pp_redirect_en;
wire [3:0] pp_redirect_pc;
wire pp_stackadj_reg_en;
wire [(PP_N_WIDTH - 1):0] pp_stackadj_reg_nx;
reg [(PP_N_WIDTH - 1):0] pp_stackadj_reg;
wire [(PP_N_WIDTH - 1):0] pp_reg_bytes;
wire [(PP_N_WIDTH - 1):0] pp_init_offset;
wire [(PP_N_WIDTH - 1):0] pp_incr_offset;
wire pp_offset_reg_en;
wire [(PP_N_WIDTH - 1):0] pp_offset_reg_nx;
reg [(PP_N_WIDTH - 1):0] pp_offset_reg;
function  [3:0] pp_16b_rcount2r;
input [2:0] rcount;
begin
    pp_16b_rcount2r = ({4{(rcount == 3'd0)}} & 4'd1) | ({4{(rcount == 3'd1)}} & 4'd2) | ({4{(rcount == 3'd2)}} & 4'd3) | ({4{(rcount == 3'd3)}} & 4'd4) | ({4{(rcount == 3'd4)}} & 4'd5) | ({4{(rcount == 3'd5)}} & 4'd7) | ({4{(rcount == 3'd6)}} & 4'd10) | ({4{(rcount == 3'd7)}} & 4'd13);
end
endfunction
assign instr_pp_c_pop = (instr[15:13] == 3'b100) & (instr[12:10] == 3'b100) & (instr[6:5] == 2'b00) & (instr[1:0] == 2'b00) & PP16_SUPPORT;
assign instr_pp_c_popret = (instr[15:13] == 3'b100) & (instr[12:10] == 3'b100) & (instr[6:5] == 2'b01) & (instr[1:0] == 2'b00) & PP16_SUPPORT;
assign instr_pp_c_push = (instr[15:13] == 3'b100) & (instr[12:10] == 3'b100) & (instr[6:5] == 2'b10) & (instr[1:0] == 2'b00) & PP16_SUPPORT;
assign pp_pop = instr_pp_c_pop;
assign pp_popret = instr_pp_c_popret;
assign pp_push = instr_pp_c_push;
assign pp_valid = pp_pop | pp_popret | pp_push;
assign pp_ucode_exe = pp_valid & ucode_exe;
assign pp_ucode_1st = pp_ucode_exe & (ucode_idx == 4'd0);
assign pp_ucode_last = ucode_exe & ((pp_pop & (ucode_idx == 4'd14)) | (pp_popret & (ucode_idx == 4'd15)) | (pp_push & (ucode_idx == 4'd14)));
assign pp_ucode_load2ra = ucode_exe & ((pp_pop & (ucode_idx == 4'd13)) | (pp_popret & (ucode_idx == 4'd13)));
assign pp_16b_rcount = instr[9:7];
assign pp_16b_spimm = instr[4:2];
assign pp_spimm = pp_16b_spimm;
assign pp_r = pp_16b_rcount2r(pp_16b_rcount);
generate
    if (PP_ALIGN_R_LSB == 1) begin:gen_1bit_alignment
        assign pp_aligned_r = {1'b0,pp_r[(PP_R_WIDTH - 1):PP_ALIGN_R_LSB]} + {{(PP_ALIGN_R_WIDTH - 1){1'b0}},pp_r[0]};
    end
    else begin:gen_nbit_alignment
        assign pp_aligned_r = {1'b0,pp_r[(PP_R_WIDTH - 1):PP_ALIGN_R_LSB]} + {{(PP_ALIGN_R_WIDTH - 1){1'b0}},(|pp_r[(PP_ALIGN_R_LSB - 1):0])};
    end
endgenerate
assign pp_N = {{(PP_N_WIDTH - PP_ALIGN_R_WIDTH - PP_ALIGN_SHAMT){1'b0}},pp_aligned_r,{PP_ALIGN_SHAMT{1'b0}}} + {{(PP_N_WIDTH - PP_SPIMM_WIDTH - PP_ALIGN_SHAMT){1'b0}},pp_spimm,{PP_ALIGN_SHAMT{1'b0}}};
assign pp_redirect_en = pp_ucode_1st;
assign pp_redirect_pc = 4'd14 - pp_r[3:0];
assign pp_stackadj_reg_en = pp_ucode_1st;
assign pp_stackadj_reg_nx = (pp_N ^ {PP_N_WIDTH{pp_push}}) + {{(PP_N_WIDTH - 1){1'b0}},pp_push};
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        pp_stackadj_reg <= {PP_N_WIDTH{1'b0}};
    end
    else if (pp_stackadj_reg_en) begin
        pp_stackadj_reg <= pp_stackadj_reg_nx;
    end
end

assign pp_reg_bytes = {{(PP_N_WIDTH - PP_R_WIDTH - PP_R2BYTES_SHAMT){1'b0}},pp_r,{PP_R2BYTES_SHAMT{1'b0}}};
assign pp_init_offset = (pp_N & {PP_N_WIDTH{(~pp_push)}}) + ~pp_reg_bytes + {{(PP_N_WIDTH - 1){1'b0}},1'b1};
assign pp_incr_offset = pp_offset_reg + {{(PP_N_WIDTH - 1 - PP_R2BYTES_SHAMT){1'b0}},1'b1,{PP_R2BYTES_SHAMT{1'b0}}};
assign pp_offset_reg_en = pp_ucode_exe;
assign pp_offset_reg_nx = pp_ucode_1st ? pp_init_offset : pp_incr_offset;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        pp_offset_reg <= {PP_N_WIDTH{1'b0}};
    end
    else if (pp_offset_reg_en) begin
        pp_offset_reg <= pp_offset_reg_nx;
    end
end

assign pp_ucode_ctrl[0] = pp_push;
assign pp_ucode_ctrl[1] = pp_pop | pp_popret;
assign pp_ucode_ctrl[2] = pp_popret;
assign pp_ucode_xcpt = ((instr_pp_c_pop & (|({pp_16b_rcount[2],pp_16b_spimm[2:1]}))));
assign pp_ucode_ctrl_ext[0] = pp_valid;
assign pp_ucode_ctrl_ext[1] = pp_ucode_load2ra;
assign pp_ucode_ctrl_ext[2] = pp_ucode_last;
assign pp_init_pc_en = pp_redirect_en;
assign pp_init_pc = pp_redirect_pc;
assign pp_offset = {{(12 - PP_N_WIDTH){pp_offset_reg[PP_N_WIDTH - 1]}},pp_offset_reg};
assign pp_stackadj = {{(12 - PP_N_WIDTH){pp_stackadj_reg[PP_N_WIDTH - 1]}},pp_stackadj_reg};
endmodule

