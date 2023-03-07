// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_mshr_ent (
    dcu_clk,
    dcu_reset_n,
    cmp_addr,
    cmp_func,
    cmp_hit,
    cmp_sameidx,
    cmp_changing,
    cmp_tagw,
    cmp_mesi,
    enq_valid,
    enq_mrg,
    enq_spec,
    enq_id,
    enq_addr,
    enq_state,
    enq_way,
    enq_func,
    enq_l2_ways,
    cmt_select,
    cmt_valid,
    cmt_addr,
    cmt_kill,
    cmt_attr,
    cmt_wdata,
    cmt_wmask,
    prb_valid,
    prb_mesi,
    wbf_a1_valid,
    wbf_flush,
    wbf_index,
    wbf_a_valid,
    wbf_a_index,
    wbf_a_ready,
    wbf_w_valid,
    wbf_w_ready,
    wbf_w_addr,
    wbf_w_data,
    wbf_w_mask,
    wbf_r_valid,
    wbf_r_ready,
    wbf_r_addr,
    wbf_r_data,
    wbf_r_mask,
    wbf_d_valid,
    valid,
    way,
    id,
    write_error,
    ent_speculative,
    ent_killed,
    ent_wt,
    ent_na,
    ent_na_mrg,
    ent_wbf,
    ent_wbf_cft,
    ent_write,
    ent_write_mrg,
    ent_wna_pending,
    a_valid,
    a_ready,
    a_last,
    a_param,
    a_opcode,
    a_user,
    a_addr,
    a_size,
    a_data,
    a_mask,
    d_grant,
    d_opcode,
    d_error,
    d_sink,
    d_last,
    d_param,
    d_offset,
    d_data,
    d_payload,
    d_fault,
    d_crit,
    d_fmt,
    d_l2_way,
    e_valid,
    e_sink,
    e_ready,
    fil_int_valid,
    fil_int_ready,
    fil_addr,
    fil_mesi,
    fil_fault,
    fil_lock,
    fil_last,
    fil_reserve,
    fil_exclusive,
    fil_l2_ways,
    cri_addr,
    cri_nbload,
    cri_prefetch,
    cri_rd,
    event_miss_cnt,
    event_miss_latency
);
parameter PALEN = 32;
parameter DCU_DATA_WIDTH = 32;
parameter DCACHE_SIZE_KB = 0;
parameter DCACHE_WAY = 2;
parameter SINK_WIDTH = 2;
parameter A_UW = 12;
parameter WBF_DEPTH = 2;
parameter WRITE_AROUND_SUPPORT_INT = 0;
parameter DCACHE_ECC_TYPE_INT = 0;
localparam IDX_LSB = 6;
localparam IDX_WIDTH = $unsigned($clog2(DCACHE_SIZE_KB * 1024 / DCACHE_WAY / 64));
localparam IDX_MSB = IDX_LSB + IDX_WIDTH - 1;
localparam GRN_MSB = 5;
localparam GRN_LSB = 2;
localparam GRN_SIZE = 3'd2;
localparam ID_WIDTH = 1;
localparam XW_RATIO = DCU_DATA_WIDTH / 32;
localparam XW_RATIO_LOG2 = $clog2(XW_RATIO);
localparam LW_RATIO = 512 / DCU_DATA_WIDTH;
localparam LW_RATIO_LOG2 = $clog2(LW_RATIO);
localparam FUNC_R = 0;
localparam FUNC_W = 1;
localparam S_BIT = 0;
localparam E_BIT = 1;
localparam M_BIT = 2;
localparam L_BIT = 3;
localparam INVALID = 0;
localparam SPECULATIVE = 1;
localparam COMMITTED = 2;
localparam WBFWRITE = 3;
localparam WBFFLUSH = 4;
localparam INFLIGHT = 5;
localparam GRANTACK = 6;
localparam TAGW = 7;
localparam KILLED = 8;
localparam FSM_BITS = 9;
localparam A_SEL_READ = 0;
localparam A_SEL_LOCK = 1;
localparam A_SEL_WT = 2;
localparam A_SEL_WBA = 3;
localparam A_SEL_WBN = 4;
input dcu_clk;
input dcu_reset_n;
input [PALEN - 1:0] cmp_addr;
input [1:0] cmp_func;
output cmp_hit;
output cmp_sameidx;
output cmp_changing;
output [3:0] cmp_tagw;
output [2:0] cmp_mesi;
input enq_valid;
input enq_mrg;
input enq_spec;
input [ID_WIDTH - 1:0] enq_id;
input [PALEN - 1:0] enq_addr;
input [3:0] enq_state;
input [3:0] enq_way;
input [18:0] enq_func;
input [7:0] enq_l2_ways;
input cmt_select;
input cmt_valid;
input [PALEN - 1:0] cmt_addr;
input cmt_kill;
input [5:0] cmt_attr;
input [31:0] cmt_wdata;
input [3:0] cmt_wmask;
input prb_valid;
input [2:0] prb_mesi;
input wbf_a1_valid;
input wbf_flush;
output [WBF_DEPTH - 1:0] wbf_index;
output wbf_a_valid;
input [WBF_DEPTH - 1:0] wbf_a_index;
input wbf_a_ready;
output wbf_w_valid;
input wbf_w_ready;
output [5:4] wbf_w_addr;
output [127:0] wbf_w_data;
output [15:0] wbf_w_mask;
output wbf_r_valid;
input wbf_r_ready;
output [5:3] wbf_r_addr;
input [DCU_DATA_WIDTH - 1:0] wbf_r_data;
input [(DCU_DATA_WIDTH / 8) - 1:0] wbf_r_mask;
output [WBF_DEPTH - 1:0] wbf_d_valid;
output valid;
output [3:0] way;
output [ID_WIDTH - 1:0] id;
output write_error;
output ent_speculative;
output ent_killed;
output ent_wt;
output ent_na;
output ent_na_mrg;
output ent_wbf;
output ent_wbf_cft;
output ent_write;
output ent_write_mrg;
output ent_wna_pending;
output a_valid;
input a_ready;
output a_last;
output [2:0] a_param;
output [2:0] a_opcode;
output [A_UW - 1:0] a_user;
output [PALEN - 1:0] a_addr;
output [2:0] a_size;
output [DCU_DATA_WIDTH - 1:0] a_data;
output [(DCU_DATA_WIDTH / 8) - 1:0] a_mask;
input d_grant;
input [2:0] d_opcode;
input d_error;
input [SINK_WIDTH - 1:0] d_sink;
input d_last;
input [1:0] d_param;
input [5:3] d_offset;
input [DCU_DATA_WIDTH - 1:0] d_data;
input d_payload;
output d_fault;
output d_crit;
output [2:0] d_fmt;
input [3:0] d_l2_way;
output e_valid;
output [SINK_WIDTH - 1:0] e_sink;
input e_ready;
output fil_int_valid;
input fil_int_ready;
output [PALEN - 1:0] fil_addr;
output [2:0] fil_mesi;
output fil_fault;
output fil_lock;
output fil_last;
output fil_reserve;
output fil_exclusive;
output [7:0] fil_l2_ways;
output [PALEN - 1:0] cri_addr;
output cri_nbload;
output cri_prefetch;
output [4:0] cri_rd;
output event_miss_cnt;
output event_miss_latency;


wire xlen64 = 1'b0;
wire l2dw128 = (DCU_DATA_WIDTH >= 128);
wire l2dw256 = (DCU_DATA_WIDTH >= 256);
wire wa_support = (WRITE_AROUND_SUPPORT_INT == 1);
wire ecccfg = (DCACHE_ECC_TYPE_INT == 2);
reg [FSM_BITS - 1:0] fsm_cs;
reg [FSM_BITS - 1:0] fsm_ns;
reg fsm_en;
wire fsm_invalid = fsm_cs[INVALID];
wire fsm_speculative = fsm_cs[SPECULATIVE];
wire fsm_committed = fsm_cs[COMMITTED];
wire fsm_wbfw = fsm_cs[WBFWRITE] & wa_support;
wire fsm_wbff = fsm_cs[WBFFLUSH] & wa_support;
wire fsm_inflight = fsm_cs[INFLIGHT];
wire fsm_grantack = fsm_cs[GRANTACK];
wire fsm_killed = fsm_cs[KILLED];
wire [3:0] grantack_fsm;
wire grantack_fsm_en;
wire grantack_fsm_rst;
wire grantack_pending;
wire grantack_received;
wire enq_valid_spec = enq_valid & enq_spec;
reg [PALEN - 1:0] addr;
wire [IDX_LSB - 1:0] addr_nx;
reg [ID_WIDTH - 1:0] id;
wire addr_lo_en;
reg [18:0] func;
wire func_write = func[1];
wire func_read = func[0];
wire func_exclusive = func[13];
wire func_lr = func[14];
wire func_nbload = func[4];
wire func_prefetch = func[12];
wire [4:0] func_rd = func[5 +:5];
wire [1:0] size = func[2 +:2];
wire [2:0] fmt = func[15 +:3];
wire func_lock = func[10];
wire func_unlock = func[11];
wire func_wbf = ~func[18] & wa_support;
wire func_null = ~func_read & ~func_write & ~func_lock & ~func_unlock;
wire cmp_func_write = cmp_func[FUNC_W];
wire cmp_func_read = cmp_func[FUNC_R];
reg [3:0] state;
wire [3:0] state_nx;
wire state_en;
reg pending_fault;
wire pending_fault_nx;
wire pending_fault_en;
reg [3:0] way;
wire attr_en;
reg [5:0] attr;
wire [3:0] l2_way;
reg [7:0] l2_ways;
wire [7:0] l2_ways_nx;
wire l2_ways_en;
wire [1:0] l2_ways_sel;
wire [7:0] l2_ways_mask;
wire attr_na = attr[0];
wire attr_wt = attr[1];
wire [3:0] attr_pma = attr[2 +:4];
wire [2:0] attr_prot;
wire [3:0] arcache;
wire [3:0] awcache;
wire ini_valid = enq_valid & ~enq_mrg;
wire cmt_na = cmt_attr[0];
wire cmt_wt = cmt_attr[1];
wire partial_filled;
wire d_opcode_grant = (d_opcode == 3'd4);
wire d_opcode_grantdata = (d_opcode == 3'd5);
wire d_opcode_grants = d_opcode_grant | d_opcode_grantdata;
wire wbf_a_grant;
wire wbf_w_grant = wbf_w_valid & wbf_w_ready;
wire [(DCU_DATA_WIDTH / 8) - 1:0] wbf_r_mask;
wire wdata_en;
reg [31:0] wdata;
reg [3:0] wmask;
wire [3:0] wmask_nx;
wire wmask_en;
wire [XW_RATIO - 1:0] grn_onehot;
wire [(DCU_DATA_WIDTH / 8) - 1:0] a_byte_lane;
wire cmp_tag_match;
wire cmp_idx_match;
wire same_line;
wire same_index;
wire [4:0] a_sel;
wire a_grant = a_valid & a_ready;
wire a_last;
wire a_op_acquireblock = (a_opcode == 3'd6);
wire e_grant;
wire read_a_valid;
wire [2:0] read_a_param;
wire [2:0] read_a_opcode;
wire [PALEN - 1:0] read_a_addr;
wire [2:0] read_a_size;
wire [(DCU_DATA_WIDTH) - 1:0] read_a_data;
wire [(DCU_DATA_WIDTH / 8) - 1:0] read_a_mask;
wire [A_UW - 1:0] read_a_user;
wire lock_a_valid;
wire [2:0] lock_a_param;
wire [2:0] lock_a_opcode;
wire [PALEN - 1:0] lock_a_addr;
wire [2:0] lock_a_size;
wire [(DCU_DATA_WIDTH) - 1:0] lock_a_data;
wire [(DCU_DATA_WIDTH / 8) - 1:0] lock_a_mask;
wire [A_UW - 1:0] lock_a_user;
wire wt_a_valid;
wire [2:0] wt_a_param;
wire [2:0] wt_a_opcode;
wire [PALEN - 1:0] wt_a_addr;
wire [2:0] wt_a_size;
wire [(DCU_DATA_WIDTH) - 1:0] wt_a_data;
wire [(DCU_DATA_WIDTH / 8) - 1:0] wt_a_mask;
wire [A_UW - 1:0] wt_a_user;
wire wba_a_valid;
wire [2:0] wba_a_param;
wire [2:0] wba_a_opcode;
wire [PALEN - 1:0] wba_a_addr;
wire [2:0] wba_a_size;
wire [(DCU_DATA_WIDTH) - 1:0] wba_a_data;
wire [(DCU_DATA_WIDTH / 8) - 1:0] wba_a_mask;
wire [A_UW - 1:0] wba_a_user;
wire wbn_a_valid;
wire [2:0] wbn_a_param;
wire [2:0] wbn_a_opcode;
wire [PALEN - 1:0] wbn_a_addr;
wire [2:0] wbn_a_size;
wire [(DCU_DATA_WIDTH) - 1:0] wbn_a_data;
wire [(DCU_DATA_WIDTH / 8) - 1:0] wbn_a_mask;
wire [A_UW - 1:0] wbn_a_user;
wire d_answered;
wire d_answered_en;
wire d_answered_nx;
wire notify_sb;
wire d_crit_grn;
wire [2:0] d_mesi;
reg [SINK_WIDTH - 1:0] e_sink;
wire e_sink_en;
wire wbf_miss;
wire unlock_ns_tagw = state[S_BIT] & state[L_BIT];
wire unlock_ns_invalid = ~unlock_ns_tagw;
wire lock_ns_invalid = state[S_BIT] & state[L_BIT];
wire lock_ns_tagw = state[S_BIT] & ~state[L_BIT];
wire lock_ns_inflight = ~state[S_BIT];
wire read_ns_invalid = state[S_BIT] & ~enq_valid_spec;
wire read_ns_speculative = state[S_BIT] & enq_valid_spec;
wire read_ns_inflight = ~state[S_BIT];
wire write_ns_invalid = (~attr_wt & state[M_BIT]) & ~enq_valid_spec;
wire write_ns_speculative = (~attr_wt & state[M_BIT]) & enq_valid_spec;
wire write_ns_tagw = ~attr_wt & ~state[M_BIT] & state[E_BIT];
wire write_ns_wbfw = ~attr_wt & attr_na & ~state[S_BIT] & func_wbf;
wire write_ns_inflight = ~write_ns_invalid & ~write_ns_speculative & ~write_ns_tagw & ~write_ns_wbfw;
wire cmt_valid_select = cmt_valid & cmt_select;
reg wait_for_cmt;
wire wait_for_cmt_en;
wire wait_for_cmt_nx;
wire wait_for_cmt_set;
wire wait_for_cmt_clr;
wire pending_wna;
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        fsm_cs <= {{(FSM_BITS - 1){1'b0}},1'b1};
    end
    else if (fsm_en) begin
        fsm_cs <= fsm_ns;
    end
end

always @(posedge dcu_clk) begin
    if (ini_valid) begin
        addr[PALEN - 1:IDX_LSB] <= enq_addr[PALEN - 1:IDX_LSB];
        id <= enq_id;
        way <= enq_way;
        func <= enq_func;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        wait_for_cmt <= 1'b0;
    end
    else if (wait_for_cmt_en) begin
        wait_for_cmt <= wait_for_cmt_nx;
    end
end

always @(posedge dcu_clk) begin
    if (addr_lo_en) begin
        addr[IDX_LSB - 1:0] <= addr_nx[IDX_LSB - 1:0];
    end
end

always @(posedge dcu_clk) begin
    if (state_en) begin
        state <= state_nx;
    end
end

always @(posedge dcu_clk) begin
    if (pending_fault_en) begin
        pending_fault <= pending_fault_nx;
    end
end

always @(posedge dcu_clk) begin
    if (attr_en) begin
        attr <= cmt_attr;
    end
end

always @(posedge dcu_clk) begin
    if (wdata_en) begin
        wdata <= cmt_wdata;
    end
end

always @(posedge dcu_clk) begin
    if (wmask_en) begin
        wmask <= wmask_nx;
    end
end

kv_dff_gen #(
    .EXPRESSION(DCACHE_ECC_TYPE_INT == 2),
    .W(1)
) u_d_answered (
    .clk(dcu_clk),
    .en(d_answered_en),
    .d(d_answered_nx),
    .q(d_answered)
);
always @* begin
    fsm_ns = {FSM_BITS{1'b0}};
    case (1'b1)
        fsm_cs[INVALID]: begin
            if (enq_spec) begin
                fsm_ns[SPECULATIVE] = 1'b1;
            end
            else begin
                fsm_ns[KILLED] = cmt_kill;
                fsm_ns[COMMITTED] = ~cmt_kill;
            end
            fsm_en = enq_valid;
        end
        fsm_cs[SPECULATIVE]: begin
            fsm_ns[KILLED] = cmt_kill;
            fsm_ns[COMMITTED] = ~cmt_kill;
            fsm_en = cmt_valid_select;
        end
        fsm_cs[KILLED]: begin
            if (enq_valid) begin
                if (enq_spec) begin
                    fsm_ns[SPECULATIVE] = 1'b1;
                end
                else begin
                    fsm_ns[KILLED] = cmt_kill;
                    fsm_ns[COMMITTED] = ~cmt_kill;
                end
            end
            else begin
                fsm_ns[INVALID] = 1'b1;
            end
            fsm_en = 1'b1;
        end
        fsm_cs[COMMITTED]: begin
            fsm_ns[TAGW] = (func_unlock & unlock_ns_tagw) | (func_lock & lock_ns_tagw) | (func_write & write_ns_tagw);
            fsm_ns[INVALID] = (func_unlock & unlock_ns_invalid) | (func_lock & lock_ns_invalid) | (func_read & read_ns_invalid) | (func_write & write_ns_invalid) | func_null;
            fsm_ns[SPECULATIVE] = (func_write & write_ns_speculative) | (func_read & read_ns_speculative);
            fsm_ns[INFLIGHT] = (func_lock & lock_ns_inflight) | (func_read & read_ns_inflight) | (func_write & write_ns_inflight);
            fsm_ns[WBFWRITE] = (func_write & write_ns_wbfw);
            fsm_en = func_unlock | (func_lock & lock_ns_tagw & fil_int_ready) | (func_lock & lock_ns_inflight & a_ready) | (func_lock & lock_ns_invalid) | (func_read & read_ns_inflight & a_ready) | (func_read & read_ns_invalid) | (func_read & read_ns_speculative) | (func_write & write_ns_invalid) | (func_write & write_ns_speculative) | (func_write & write_ns_tagw & fil_int_ready) | (func_write & write_ns_inflight & a_ready) | (func_write & write_ns_wbfw & wbf_a_ready) | func_null;
        end
        fsm_cs[WBFWRITE]: begin
            fsm_ns[WBFFLUSH] = 1'b1;
            fsm_en = wbf_flush;
        end
        fsm_cs[WBFFLUSH]: begin
            fsm_ns[INFLIGHT] = 1'b1;
            fsm_en = a_grant & a_last;
        end
        fsm_cs[INFLIGHT]: begin
            fsm_ns[GRANTACK] = 1'b1;
            fsm_en = d_grant & d_last;
        end
        fsm_cs[GRANTACK]: begin
            if (wait_for_cmt) begin
                fsm_ns[SPECULATIVE] = ~cmt_valid_select;
                fsm_ns[KILLED] = cmt_valid_select & cmt_kill;
                fsm_ns[COMMITTED] = cmt_valid_select & ~cmt_kill;
            end
            else if (enq_valid_spec) begin
                fsm_ns[SPECULATIVE] = 1'b1;
            end
            else if (wbf_miss && |wmask) begin
                fsm_ns[COMMITTED] = 1'b1;
            end
            else begin
                fsm_ns[INVALID] = 1'b1;
            end
            fsm_en = ~grantack_pending;
        end
        fsm_cs[TAGW]: begin
            if (enq_valid) begin
                if (enq_spec) begin
                    fsm_ns[SPECULATIVE] = 1'b1;
                end
                else begin
                    fsm_ns[KILLED] = cmt_kill;
                    fsm_ns[COMMITTED] = ~cmt_kill;
                end
            end
            else if (wait_for_cmt) begin
                fsm_ns[SPECULATIVE] = ~cmt_valid_select;
                fsm_ns[KILLED] = cmt_valid_select & cmt_kill;
                fsm_ns[COMMITTED] = cmt_valid_select & ~cmt_kill;
            end
            else begin
                fsm_ns[INVALID] = 1'b1;
            end
            fsm_en = 1'b1;
        end
        default: begin
            fsm_ns = {FSM_BITS{1'b0}};
            fsm_en = 1'b0;
        end
    endcase
end

assign valid = ~fsm_invalid;
assign cmp_mesi = ((fsm_inflight & d_grant & d_last & notify_sb) | fsm_grantack) ? {func[FUNC_W],2'b11} : state[2:0];
assign attr_en = cmt_valid_select & (fsm_invalid | fsm_speculative);
assign wdata_en = cmt_valid_select & ~cmt_kill & (cmt_na | cmt_wt);
assign wmask_en = wdata_en | wbf_w_grant;
assign wmask_nx = {4{cmt_valid_select & ~cmt_kill}} & cmt_wmask;
generate
    if (XW_RATIO_LOG2 != 0) begin:gen_a_byte_lane
        kv_bin2onehot #(
            .N(XW_RATIO)
        ) u_grn_onehot (
            .out(grn_onehot),
            .in(addr[GRN_LSB +:XW_RATIO_LOG2])
        );
        kv_bit_expand #(
            .N(XW_RATIO),
            .M(4)
        ) u_a_byte_lane (
            .out(a_byte_lane),
            .in(grn_onehot)
        );
    end
    else begin:gen_a_byte_lane_stub
        assign grn_onehot = 1'b1;
        assign a_byte_lane = {(DCU_DATA_WIDTH / 8){grn_onehot}};
    end
endgenerate
assign addr_lo_en = ini_valid | (cmt_valid_select & ~cmt_kill & cmt_na);
assign addr_nx = fsm_invalid ? enq_addr[IDX_LSB - 1:0] : cmt_addr[IDX_LSB - 1:0];
assign state_en = ini_valid | prb_valid | (d_grant & d_last & d_opcode_grants);
assign state_nx[S_BIT] = fsm_invalid ? enq_state[S_BIT] : prb_valid ? state[S_BIT] & prb_mesi[S_BIT] : d_mesi[S_BIT];
assign state_nx[E_BIT] = fsm_invalid ? enq_state[E_BIT] : prb_valid ? state[E_BIT] & prb_mesi[E_BIT] : d_mesi[E_BIT];
assign state_nx[M_BIT] = fsm_invalid ? enq_state[M_BIT] : prb_valid ? state[M_BIT] & prb_mesi[M_BIT] : d_mesi[M_BIT];
assign state_nx[L_BIT] = fsm_invalid ? enq_state[L_BIT] : prb_valid ? state[L_BIT] : (state[L_BIT] | func_lock) & ~d_fault;
assign pending_fault_en = ini_valid | d_grant;
assign pending_fault_nx = d_fault;
assign d_fault = d_grant & (d_error | pending_fault);
assign d_answered_nx = ~a_grant & (d_answered | d_grant);
assign d_answered_en = a_grant | d_grant;
assign wait_for_cmt_en = wait_for_cmt_set ^ wait_for_cmt_clr;
assign wait_for_cmt_nx = wait_for_cmt_set & ~wait_for_cmt_clr;
assign wait_for_cmt_set = enq_valid;
assign wait_for_cmt_clr = cmt_valid & cmt_select;
always @(posedge dcu_clk) begin
    if (l2_ways_en) begin
        l2_ways <= l2_ways_nx;
    end
end

assign l2_ways_en = ini_valid | (d_grant & d_last & d_opcode_grantdata);
assign l2_ways_nx = fsm_invalid ? enq_l2_ways : (l2_ways & ~l2_ways_mask | {2{d_l2_way}} & l2_ways_mask);
kv_bin2onehot #(
    .N(2)
) u_l2_ways_sel (
    .out(l2_ways_sel),
    .in(addr[IDX_LSB])
);
kv_bit_expand #(
    .N(2),
    .M(4)
) u_l2_ways_mask (
    .out(l2_ways_mask),
    .in(l2_ways_sel)
);
kv_mux_onehot #(
    .N(2),
    .W(4)
) u_l2_way (
    .out(l2_way),
    .sel(l2_ways_sel),
    .in(l2_ways)
);
assign fil_l2_ways = l2_ways_nx;
generate
    if (WRITE_AROUND_SUPPORT_INT == 1) begin:gen_wbf
        reg [WBF_DEPTH - 1:0] reg_wbf_index;
        reg [5:3] reg_wbf_r_addr;
        wire [5:3] reg_wbf_r_addr_nx;
        wire reg_wbf_r_addr_en;
        always @(posedge dcu_clk) begin
            if (wbf_a_grant) begin
                reg_wbf_index <= wbf_a_index;
            end
        end

        always @(posedge dcu_clk) begin
            if (reg_wbf_r_addr_en) begin
                reg_wbf_r_addr <= reg_wbf_r_addr_nx;
            end
        end

        assign reg_wbf_r_addr_en = (fsm_wbfw & wbf_flush) | (fsm_wbff & a_grant);
        assign reg_wbf_r_addr_nx = (fsm_wbfw & wbf_flush) ? 3'd0 : reg_wbf_r_addr + DCU_DATA_WIDTH[8:6];
        assign wbf_index = reg_wbf_index;
        assign wbf_a_valid = fsm_committed & wbf_miss;
        assign wbf_a_grant = wbf_a_valid & wbf_a_ready;
        assign wbf_r_valid = fsm_wbff;
        assign wbf_r_addr = reg_wbf_r_addr;
        assign wbf_w_valid = fsm_wbfw & |wmask;
        assign wbf_w_data = {4{wdata}};
        assign wbf_w_addr = addr[5:4];
        assign wbf_w_mask[0 +:4] = (addr[GRN_LSB +:2] == 2'd0) ? wmask : {4{1'b0}};
        assign wbf_w_mask[4 +:4] = (addr[GRN_LSB +:2] == 2'd1) ? wmask : {4{1'b0}};
        assign wbf_w_mask[8 +:4] = (addr[GRN_LSB +:2] == 2'd2) ? wmask : {4{1'b0}};
        assign wbf_w_mask[12 +:4] = (addr[GRN_LSB +:2] == 2'd3) ? wmask : {4{1'b0}};
        assign wbf_d_valid = {WBF_DEPTH{fsm_wbff & a_grant & a_last}} & wbf_index;
    end
    else begin:gen_wbf_stub
        assign wbf_index = {WBF_DEPTH{1'b0}};
        assign wbf_a_valid = 1'b0;
        assign wbf_a_grant = 1'b0;
        assign wbf_r_valid = 1'b0;
        assign wbf_r_addr = 3'd0;
        assign wbf_w_valid = 1'b0;
        assign wbf_w_data = {128{1'b0}};
        assign wbf_w_addr = 2'd0;
        assign wbf_w_mask = {16{1'b0}};
        assign wbf_d_valid = {WBF_DEPTH{1'b0}};
    end
endgenerate
assign wbf_miss = func_write & ~attr_wt & attr_na & ~state[S_BIT] & func_wbf;
kv_pma2axcache u_axcache(
    .c2nc(1'b0),
    .pma_mtype(attr_pma),
    .arcache(arcache),
    .awcache(awcache)
);
kv_mux_onehot #(
    .N(5),
    .W(3 + A_UW + 3 + 3 + PALEN + (DCU_DATA_WIDTH) + (DCU_DATA_WIDTH / 8))
) u_a_msg (
    .out({a_opcode,a_user,a_param,a_size,a_addr,a_data,a_mask}),
    .sel(a_sel),
    .in({wbn_a_opcode,wbn_a_user,wbn_a_param,wbn_a_size,wbn_a_addr,wbn_a_data,wbn_a_mask,wba_a_opcode,wba_a_user,wba_a_param,wba_a_size,wba_a_addr,wba_a_data,wba_a_mask,wt_a_opcode,wt_a_user,wt_a_param,wt_a_size,wt_a_addr,wt_a_data,wt_a_mask,lock_a_opcode,lock_a_user,lock_a_param,lock_a_size,lock_a_addr,lock_a_data,lock_a_mask,read_a_opcode,read_a_user,read_a_param,read_a_size,read_a_addr,read_a_data,read_a_mask})
);
assign attr_prot[0] = 1'b1;
assign attr_prot[1] = 1'b0;
assign attr_prot[2] = 1'b0;
assign lock_a_valid = fsm_committed & ~state[S_BIT];
assign lock_a_opcode = 3'd6;
assign lock_a_param = 3'd0;
assign lock_a_size = 3'd6;
assign lock_a_addr = {addr[PALEN - 1:6],6'd0};
assign lock_a_data = {DCU_DATA_WIDTH{1'b0}};
assign lock_a_mask = {(DCU_DATA_WIDTH / 8){1'b1}};
assign lock_a_user[0 +:3] = attr_prot;
assign lock_a_user[3 +:4] = arcache;
assign lock_a_user[7] = 1'b0;
assign lock_a_user[8 +:4] = l2_way;
assign read_a_valid = fsm_committed & ~state[S_BIT];
assign read_a_opcode = attr_na ? 3'd4 : 3'd6;
assign read_a_param = attr_na ? 3'd0 : state[S_BIT] ? 3'd2 : 3'd0;
assign read_a_size = attr_na ? {1'b0,1'b1,xlen64} : 3'd6;
assign read_a_addr = attr_na ? {addr[PALEN - 1:GRN_LSB],{GRN_LSB{1'b0}}} : {addr[PALEN - 1:6],6'd0};
assign read_a_data = {(DCU_DATA_WIDTH){1'b0}};
assign read_a_mask = attr_na ? a_byte_lane : {(DCU_DATA_WIDTH / 8){1'b1}};
assign read_a_user[0 +:3] = attr_prot;
assign read_a_user[3 +:4] = arcache;
assign read_a_user[7] = 1'b0;
assign read_a_user[8 +:4] = l2_way;
assign wt_a_valid = fsm_committed;
assign wt_a_opcode = 3'd1;
assign wt_a_param = 3'd0;
assign wt_a_size = {1'b0,size[1:0]};
assign wt_a_addr = addr[PALEN - 1:0];
assign wt_a_data = {XW_RATIO{wdata}};
assign wt_a_mask = {XW_RATIO{wmask}} & a_byte_lane;
assign wt_a_user[0 +:3] = attr_prot;
assign wt_a_user[3 +:4] = awcache;
assign wt_a_user[7] = 1'b0;
assign wt_a_user[8 +:4] = l2_way;
assign wba_a_valid = (fsm_committed & ~state[E_BIT]);
assign wba_a_opcode = 3'd6;
assign wba_a_param = state[S_BIT] ? 3'd2 : 3'd1;
assign wba_a_size = 3'd6;
assign wba_a_addr = {addr[PALEN - 1:6],6'd0};
assign wba_a_data = {(DCU_DATA_WIDTH){1'b0}};
assign wba_a_mask = {(DCU_DATA_WIDTH / 8){1'b1}};
assign wba_a_user[0 +:3] = attr_prot;
assign wba_a_user[3 +:4] = arcache;
assign wba_a_user[7] = 1'b0;
assign wba_a_user[8 +:4] = l2_way;
assign wbn_a_valid = (fsm_committed & state[S_BIT] & ~state[E_BIT]) | (fsm_committed & ~state[S_BIT] & ~func_wbf) | (fsm_wbff & wbf_r_ready);
assign wbn_a_opcode = state[S_BIT] ? 3'd6 : 3'd1;
assign wbn_a_param = state[S_BIT] ? 3'd2 : 3'd0;
assign wbn_a_size = state[S_BIT] ? 3'd6 : func_wbf ? 3'd6 : {1'b0,size[1:0]};
assign wbn_a_addr = state[S_BIT] ? {addr[PALEN - 1:6],6'd0} : func_wbf ? {addr[PALEN - 1:6],6'd0} : addr[PALEN - 1:0];
assign wbn_a_data = state[S_BIT] ? {(DCU_DATA_WIDTH){1'b0}} : func_wbf ? wbf_r_data : {XW_RATIO{wdata}};
assign wbn_a_mask = state[S_BIT] ? {(DCU_DATA_WIDTH / 8){1'b1}} : func_wbf ? wbf_r_mask : {XW_RATIO{wmask}} & a_byte_lane;
assign wbn_a_user[0 +:3] = attr_prot;
assign wbn_a_user[3 +:4] = state[S_BIT] ? arcache : awcache;
assign wbn_a_user[7] = 1'b0;
assign wbn_a_user[8 +:4] = l2_way;
assign a_last = fsm_committed | (fsm_wbff & wbf_r_addr[5] & (wbf_r_addr[4] | l2dw256) & (wbf_r_addr[3] | l2dw128));
assign a_sel[A_SEL_READ] = func_read;
assign a_sel[A_SEL_LOCK] = func_lock;
assign a_sel[A_SEL_WT] = func_write & attr_wt;
assign a_sel[A_SEL_WBA] = func_write & ~attr_wt & ~attr_na;
assign a_sel[A_SEL_WBN] = func_write & ~attr_wt & attr_na;
assign a_valid = (a_sel[A_SEL_READ] & read_a_valid) | (a_sel[A_SEL_LOCK] & lock_a_valid) | (a_sel[A_SEL_WT] & wt_a_valid) | (a_sel[A_SEL_WBA] & wba_a_valid) | (a_sel[A_SEL_WBN] & wbn_a_valid);
wire notify_sb_wt = 1'b1;
wire notify_sb_wba = 1'b1;
wire notify_sb_wbn = state[S_BIT];
assign notify_sb = (a_sel[A_SEL_WT] & notify_sb_wt) | (a_sel[A_SEL_WBA] & notify_sb_wba) | (a_sel[A_SEL_WBN] & notify_sb_wbn);
assign d_crit_grn = (d_offset[5] == addr[5]) & ((d_offset[4] == addr[4]) | l2dw256) & ((d_offset[3] == addr[3]) | l2dw128);
assign d_crit = func_read & (d_crit_grn | attr_na);
assign d_fmt = fmt;
assign d_mesi[M_BIT] = ~d_fault & func_write & ~func_exclusive;
assign d_mesi[E_BIT] = ~d_fault & ((func_write & ~func_exclusive) | (d_param == 2'd0));
assign d_mesi[S_BIT] = ~d_fault;
assign cmp_idx_match = (cmp_addr[IDX_MSB:IDX_LSB] == addr[IDX_MSB:IDX_LSB]);
assign cmp_tag_match = (cmp_addr[PALEN - 1:IDX_MSB + 1] == addr[PALEN - 1:IDX_MSB + 1]);
assign same_line = cmp_idx_match & cmp_tag_match;
assign same_index = cmp_idx_match & ~cmp_tag_match;
assign cmp_hit = valid & same_line & ~(fsm_en & fsm_ns[INVALID]);
assign cmp_sameidx = valid & same_index & ~(fsm_en & fsm_ns[INVALID]);
assign cmp_changing = fil_int_valid | (fsm_inflight & grantack_received) | (fsm_speculative & cmt_valid_select);
assign cmp_tagw = {4{fil_int_valid & cmp_idx_match}} & way;
assign pending_wna = (wait_for_cmt | (|wmask)) & (fsm_wbff | fsm_inflight | fsm_grantack);
assign write_error = fsm_grantack & func_write & pending_fault;
assign ent_speculative = fsm_speculative;
assign ent_killed = fsm_killed;
assign ent_wt = valid & ~fsm_speculative & attr_wt;
assign ent_na = valid & ~fsm_speculative & attr_na;
assign ent_na_mrg = fsm_wbfw;
assign ent_wbf = valid & wbf_miss;
assign ent_wbf_cft = valid & wbf_miss & (fsm_committed | fsm_wbfw | pending_wna);
assign ent_write = valid & ~fsm_speculative;
assign ent_write_mrg = (fsm_committed & state[M_BIT]) | (func_write & ~func_exclusive & ~partial_filled);
assign partial_filled = ecccfg & ((fsm_inflight & d_answered) | fsm_grantack);
assign ent_wna_pending = (fsm_wbff | fsm_inflight) & wbf_miss;
kv_cnt_onehot #(
    .N(4)
) u_grantack_fsm (
    .clk(dcu_clk),
    .rst_n(dcu_reset_n),
    .en(grantack_fsm_en),
    .up_dn(1'b1),
    .load(grantack_fsm_rst),
    .data(4'd1),
    .cnt(grantack_fsm)
);
always @(posedge dcu_clk) begin
    if (e_sink_en) begin
        e_sink <= d_sink;
    end
end

assign e_valid = grantack_fsm[2];
assign e_grant = e_valid & e_ready;
assign e_sink_en = grantack_fsm[1] & d_grant;
assign grantack_pending = grantack_fsm[1] | grantack_fsm[2];
assign grantack_received = grantack_fsm[3];
assign grantack_fsm_en = grantack_fsm_rst | (a_grant & a_op_acquireblock) | (d_grant & grantack_fsm[1]) | e_grant;
assign grantack_fsm_rst = ini_valid | (fsm_grantack & ~grantack_pending);
assign fil_int_valid = (fsm_committed & func_unlock & unlock_ns_tagw) | (fsm_committed & func_lock & lock_ns_tagw) | (fsm_committed & func_write & write_ns_tagw);
assign fil_mesi = ({3{fsm_inflight}} & d_mesi) | ({3{fsm_committed & func_lock}} & state[2:0]) | ({3{fsm_committed & func_unlock}} & state[2:0]) | ({3{fsm_committed & func_write}} & {1'b1,state[1:0]});
assign fil_fault = fsm_inflight & d_fault;
assign fil_lock = func_lock | (state[L_BIT] & ~func_unlock);
assign fil_addr[PALEN - 1:6] = addr[PALEN - 1:6];
assign fil_addr[5:4] = d_offset[5:4] & {2{fsm_inflight}};
assign fil_addr[3:0] = 4'd0;
assign fil_last = (fsm_inflight & d_last) | fsm_committed;
assign fil_reserve = func_lr & d_crit;
assign fil_exclusive = func_exclusive;
assign cri_addr = addr[PALEN - 1:0];
assign cri_nbload = func_nbload;
assign cri_prefetch = func_prefetch;
assign cri_rd = func_rd;
assign event_miss_latency = fsm_inflight;
assign event_miss_cnt = a_grant;
wire nds_unused_signals = |{wbf_a_index};
endmodule

