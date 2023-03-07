// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_evb_ent (
    dcu_clk,
    dcu_reset_n,
    valid,
    wbf_index,
    ecc_fault_xcctl,
    ecc_fault_acctl,
    ecc_fault_async,
    ecc_uncorr,
    bus_fault,
    cmp_addr,
    cmp_hit,
    cmp_speculative,
    cmp_cft,
    enq_valid,
    enq_select,
    enq_spec,
    enq_eccen,
    enq_addr,
    enq_way,
    enq_state,
    enq_func,
    enq_wbf,
    enq_source,
    mrg_valid,
    mrg_select,
    probe_func,
    cmt_valid,
    cmt_kill,
    req_valid,
    req_addr,
    req_way,
    req_mesi,
    req_lock,
    req_data,
    req_last,
    req_ready,
    ack_valid,
    ack_rdata,
    ack_error1,
    ack_error2,
    wbf_w_vaid,
    wbf_w_addr,
    wbf_w_data,
    wbf_r_addr,
    wbf_r_data,
    wbf_d_valid,
    c_valid,
    c_opcode,
    c_param,
    c_addr,
    c_data,
    c_source,
    c_last,
    c_ready,
    d_valid,
    d_error,
    d_ready,
    delay_t2b
);
parameter PALEN = 32;
parameter DCU_DATA_WIDTH = 32;
parameter WBF_DEPTH = 3;
parameter DCACHE_SIZE_KB = 32;
parameter DCACHE_WAY = 4;
parameter DCACHE_ECC_TYPE_INT = 0;
parameter SOURCE_WIDTH = 2;
parameter CM_SUPPORT_INT = 0;
localparam GRN_MSB = 5;
localparam IDX_LSB = 6;
localparam IDX_WIDTH = $unsigned($clog2(DCACHE_SIZE_KB * 1024 / DCACHE_WAY / 64));
localparam IDX_MSB = IDX_LSB + IDX_WIDTH - 1;
localparam S_BIT = 0;
localparam E_BIT = 1;
localparam M_BIT = 2;
localparam L_BIT = 3;
localparam INVALID = 0;
localparam SPECULATIVE = 1;
localparam COMMITTED = 2;
localparam WBF = 3;
localparam REL = 4;
localparam INFLIGHT = 5;
localparam KILLED = 6;
localparam FSM_BITS = 7;
input dcu_clk;
input dcu_reset_n;
output valid;
output [WBF_DEPTH - 1:0] wbf_index;
output ecc_fault_xcctl;
output ecc_fault_acctl;
output ecc_fault_async;
output ecc_uncorr;
output bus_fault;
input [PALEN - 1:0] cmp_addr;
output cmp_hit;
output cmp_speculative;
output [3:0] cmp_cft;
input enq_valid;
input enq_select;
input enq_spec;
input [1:0] enq_eccen;
input [PALEN - 1:0] enq_addr;
input [3:0] enq_way;
input [3:0] enq_state;
input [5:0] enq_func;
input [WBF_DEPTH - 1:0] enq_wbf;
input [SOURCE_WIDTH - 1:0] enq_source;
input mrg_valid;
input mrg_select;
input [3:0] probe_func;
input cmt_valid;
input cmt_kill;
output req_valid;
output [PALEN - 1:0] req_addr;
output [3:0] req_way;
output [2:0] req_mesi;
output req_lock;
output req_data;
output req_last;
input req_ready;
input ack_valid;
input [127:0] ack_rdata;
input ack_error1;
input ack_error2;
output wbf_w_vaid;
output [5:4] wbf_w_addr;
output [127:0] wbf_w_data;
output [5:3] wbf_r_addr;
input [DCU_DATA_WIDTH - 1:0] wbf_r_data;
output [WBF_DEPTH - 1:0] wbf_d_valid;
output c_valid;
output [2:0] c_opcode;
output [2:0] c_param;
output [PALEN - 1:0] c_addr;
output [DCU_DATA_WIDTH - 1:0] c_data;
output [SOURCE_WIDTH - 1:0] c_source;
output c_last;
input c_ready;
input d_valid;
input d_error;
output d_ready;
input delay_t2b;


wire way1 = DCACHE_WAY == 1;
wire way2 = DCACHE_WAY == 2;
wire way4 = DCACHE_WAY == 4;
wire rv64 = 1'b0;
wire l2dw128 = (DCU_DATA_WIDTH >= 128);
wire l2dw256 = (DCU_DATA_WIDTH >= 256);
reg [FSM_BITS - 1:0] fsm_cs;
reg [FSM_BITS - 1:0] fsm_ns;
reg fsm_en;
wire fsm_invalid = fsm_cs[INVALID];
wire fsm_committed = fsm_cs[COMMITTED];
wire fsm_speculative = fsm_cs[SPECULATIVE];
wire fsm_release = fsm_cs[REL];
wire fsm_killed = fsm_cs[KILLED];
reg [PALEN - 1:0] addr;
reg [3:0] way;
reg [3:0] state;
reg [5:0] func;
reg [3:0] probefn;
wire [SOURCE_WIDTH - 1:0] source;
wire func_inval = func[2];
wire func_wbinval = func[1];
wire func_wb = func[0];
wire func_cctl = func[3];
wire func_acctl = func[4];
wire func_probe = func[5];
wire probefn_ton = probefn[0];
wire probefn_tob = probefn[1];
wire probefn_tot = probefn[2];
wire probefn_probeblock = probefn[3];
wire state_en;
wire [3:0] state_nx;
wire [2:0] req_mesi_rel;
wire [2:0] req_mesi_probe;
wire [1:0] eccen;
wire eccen2 = (eccen == 2'd2);
wire eccen3 = (eccen == 2'd3);
wire [3:0] cap_state;
wire [2:0] c_opcode_inval;
wire [2:0] c_opcode_wb;
wire [2:0] c_opcode_wbinval;
wire [2:0] c_opcode_probe;
wire [2:0] c_param_inval;
wire [2:0] c_param_wb;
wire [2:0] c_param_wbinval;
wire [2:0] c_param_tot;
wire [2:0] c_param_tob;
wire [2:0] c_param_ton;
wire [2:0] c_param_probe;
reg [WBF_DEPTH - 1:0] wbf_index;
wire req_grant;
reg [GRN_MSB:4] evt_grain;
wire [GRN_MSB:4] evt_grain_nx;
wire evt_grain_en;
reg [5:4] wbf_w_addr;
wire [5:4] wbf_w_addr_nx;
wire wbf_w_addr_en;
reg [5:3] wbf_r_addr;
wire [5:3] wbf_r_addr_nx;
wire wbf_r_addr_en;
wire c_grant;
wire d_grant;
wire deq_valid;
wire enq_valid_select = enq_valid & enq_select;
wire mrg_valid_select = mrg_valid & mrg_select;
wire init_en = enq_valid_select & fsm_invalid;
wire func_en = init_en | (mrg_valid_select & fsm_speculative);
reg bus_fault;
wire bus_fault_nx;
wire same_index;
wire same_tag;
reg wait_for_cmt;
wire wait_for_cmt_en;
wire wait_for_cmt_nx;
wire wait_for_cmt_set;
wire wait_for_cmt_clr;
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        fsm_cs <= {{(FSM_BITS - 1){1'b0}},1'b1};
    end
    else if (fsm_en) begin
        fsm_cs <= fsm_ns;
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

always @* begin
    fsm_ns = {FSM_BITS{1'b0}};
    case (1'b1)
        fsm_cs[INVALID]: begin
            if (enq_spec) begin
                if (~cmt_valid) begin
                    fsm_ns[SPECULATIVE] = 1'b1;
                end
                else if (cmt_kill) begin
                    fsm_ns[KILLED] = 1'b1;
                end
                else begin
                    fsm_ns[COMMITTED] = 1'b1;
                end
            end
            else begin
                fsm_ns[COMMITTED] = 1'b1;
            end
            fsm_en = enq_valid_select;
        end
        fsm_cs[SPECULATIVE]: begin
            if (mrg_valid_select) begin
                fsm_ns[COMMITTED] = 1'b1;
                fsm_en = 1'b1;
            end
            else begin
                if (cmt_kill) begin
                    fsm_ns[KILLED] = 1'b1;
                end
                else begin
                    fsm_ns[KILLED] = ~state[S_BIT];
                    fsm_ns[COMMITTED] = state[S_BIT];
                end
                fsm_en = cmt_valid;
            end
        end
        fsm_cs[COMMITTED]: begin
            if (func_probe & ~probefn_probeblock) begin
                fsm_ns[REL] = 1'b1;
                fsm_en = req_ready;
            end
            else if (func_probe & probefn_probeblock & ~state[M_BIT]) begin
                fsm_ns[REL] = 1'b1;
                fsm_en = req_ready;
            end
            else if (rv64) begin
                fsm_ns[WBF] = 1'b1;
                fsm_en = req_ready & req_last;
            end
            else begin
                fsm_ns[REL] = 1'b1;
                fsm_en = req_ready & req_last;
            end
        end
        fsm_cs[WBF]: begin
            fsm_ns[REL] = 1'b1;
            fsm_en = 1'b1;
        end
        fsm_cs[REL]: begin
            fsm_ns[INFLIGHT] = 1'b1;
            fsm_en = c_grant & c_last;
        end
        fsm_cs[INFLIGHT]: begin
            if (func_probe) begin
                if (wait_for_cmt) begin
                    fsm_ns[KILLED] = cmt_valid;
                    fsm_ns[SPECULATIVE] = ~cmt_valid;
                    fsm_en = 1'b1;
                end
                else begin
                    fsm_ns[INVALID] = 1'b1;
                    fsm_en = ~delay_t2b;
                end
            end
            else begin
                fsm_ns[INVALID] = 1'b1;
                fsm_en = d_grant;
            end
        end
        fsm_cs[KILLED]: begin
            fsm_ns[INVALID] = 1'b1;
            fsm_en = 1'b1;
        end
        default: begin
            fsm_ns = {FSM_BITS{1'b0}};
            fsm_en = 1'b0;
        end
    endcase
end

assign valid = ~fsm_invalid;
assign same_tag = (cmp_addr[PALEN - 1:IDX_MSB + 1] == addr[PALEN - 1:IDX_MSB + 1]);
assign same_index = (cmp_addr[IDX_MSB:IDX_LSB] == addr[IDX_MSB:IDX_LSB]);
assign cmp_hit = valid & same_tag & same_index;
assign cmp_cft = {4{valid & same_index}} & (way | {4{~state[S_BIT]}});
assign cmp_speculative = fsm_speculative;
assign wait_for_cmt_en = wait_for_cmt_set ^ wait_for_cmt_clr;
assign wait_for_cmt_nx = wait_for_cmt_set & ~wait_for_cmt_clr;
assign wait_for_cmt_set = enq_valid_select & enq_spec & fsm_invalid & ~cmt_valid;
assign wait_for_cmt_clr = cmt_valid;
always @(posedge dcu_clk) begin
    if (init_en) begin
        addr <= enq_addr;
        way <= enq_way;
        wbf_index <= enq_wbf;
    end
end

always @(posedge dcu_clk) begin
    if (state_en) begin
        state <= state_nx;
    end
end

always @(posedge dcu_clk) begin
    if (func_en) begin
        func <= enq_func;
        probefn <= probe_func;
    end
end

kv_dff_gen #(
    .EXPRESSION(DCACHE_ECC_TYPE_INT == 2),
    .W(2)
) u_eccen (
    .clk(dcu_clk),
    .en(init_en),
    .d(enq_eccen),
    .q(eccen)
);
kv_dff_gen #(
    .EXPRESSION(CM_SUPPORT_INT),
    .W(SOURCE_WIDTH)
) u_source (
    .clk(dcu_clk),
    .en(func_en),
    .d(enq_source),
    .q(source)
);
assign state_en = func_en | (fsm_release & func_probe & c_grant & c_last);
assign state_nx = fsm_release ? cap_state : enq_state;
assign cap_state[M_BIT] = 1'b0;
assign cap_state[E_BIT] = (state[E_BIT] & probefn_tot);
assign cap_state[S_BIT] = (state[S_BIT] & probefn_tot) | (state[S_BIT] & probefn_tob);
assign cap_state[L_BIT] = state[L_BIT];
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        evt_grain <= 2'd0;
    end
    else if (evt_grain_en) begin
        evt_grain <= evt_grain_nx;
    end
end

assign req_grant = req_valid & req_ready;
assign evt_grain_en = req_grant | init_en;
assign evt_grain_nx = fsm_invalid ? 2'd0 : evt_grain + {rv64,~rv64};
assign req_valid = fsm_committed;
assign req_addr = {addr[PALEN - 1:6],evt_grain[5:4],4'd0};
assign req_mesi = func_probe ? req_mesi_probe : req_mesi_rel;
assign req_mesi_rel[S_BIT] = (func_wb);
assign req_mesi_rel[E_BIT] = (func_wb);
assign req_mesi_rel[M_BIT] = 1'b0;
assign req_mesi_probe[S_BIT] = probefn_tob | probefn_tot;
assign req_mesi_probe[E_BIT] = (probefn_tot & state[E_BIT]);
assign req_mesi_probe[M_BIT] = 1'b0;
assign req_way = way;
assign req_lock = func_probe ? state[L_BIT] & (probefn_tob | probefn_tot) : state[L_BIT] & func_wb;
assign req_last = (evt_grain[5] & (rv64 | evt_grain[4])) | func_inval | ~state[M_BIT] | (func_probe & ~probefn_probeblock);
assign req_data = ~func_inval & state[M_BIT];
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        wbf_w_addr <= 2'd0;
    end
    else if (wbf_w_addr_en) begin
        wbf_w_addr <= wbf_w_addr_nx;
    end
end

assign wbf_w_addr_en = ack_valid | init_en;
assign wbf_w_addr_nx = fsm_invalid ? 2'd0 : wbf_w_addr + {rv64,~rv64};
assign wbf_w_vaid = ack_valid & (state[M_BIT] & ~func_inval);
assign wbf_w_data = ack_rdata;
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        wbf_r_addr <= 3'd0;
    end
    else if (wbf_r_addr_en) begin
        wbf_r_addr <= wbf_r_addr_nx;
    end
end

assign wbf_r_addr_en = init_en | c_grant;
assign wbf_r_addr_nx = fsm_invalid ? 3'd0 : wbf_r_addr + DCU_DATA_WIDTH[8:6];
assign deq_valid = (c_grant & c_last) | fsm_killed;
assign wbf_d_valid = {WBF_DEPTH{deq_valid & state[M_BIT]}} & wbf_index;
generate
    if (DCACHE_ECC_TYPE_INT == 2) begin:gen_ecc_fault
        wire corr_error;
        wire uncorr_error;
        wire ecc_fault;
        reg fault;
        wire fault_nx;
        wire fault_set;
        wire fault_clr;
        reg fault_uncorr;
        wire fault_uncorr_nx;
        wire fault_uncorr_set;
        wire fault_uncorr_clr;
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                fault <= 1'b0;
            end
            else begin
                fault <= fault_nx;
            end
        end

        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                fault_uncorr <= 1'b0;
            end
            else begin
                fault_uncorr <= fault_uncorr_nx;
            end
        end

        assign corr_error = req_data & ack_error1 | (req_data & ack_error2 & ~state[M_BIT]);
        assign uncorr_error = (req_data & ack_error2 & state[M_BIT]);
        assign fault_set = ack_valid & ((eccen2 & uncorr_error) | (eccen3 & (uncorr_error | corr_error)));
        assign fault_clr = init_en | deq_valid;
        assign fault_nx = ~fault_clr & (fault | fault_set);
        assign fault_uncorr_nx = fault_uncorr_set | (fault_uncorr & ~fault_uncorr_clr);
        assign fault_uncorr_clr = init_en;
        assign fault_uncorr_set = ack_valid & uncorr_error;
        assign ecc_fault = fault & deq_valid;
        assign ecc_fault_xcctl = ecc_fault & func_cctl;
        assign ecc_fault_acctl = ecc_fault & func_acctl;
        assign ecc_fault_async = ecc_fault & ~func_cctl & ~func_acctl;
        assign ecc_uncorr = fault_uncorr;
    end
    else begin:gen_ecc_error_stub
        assign ecc_fault_xcctl = 1'b0;
        assign ecc_fault_async = 1'b0;
        assign ecc_fault_acctl = 1'b0;
        assign ecc_uncorr = 1'b0;
    end
endgenerate
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        bus_fault <= 1'b0;
    end
    else begin
        bus_fault <= bus_fault_nx;
    end
end

assign bus_fault_nx = d_grant & d_error;
assign c_opcode_inval = 3'd6;
assign c_opcode_wb = state[M_BIT] ? 3'd7 : 3'd6;
assign c_opcode_wbinval = state[M_BIT] ? 3'd7 : 3'd6;
assign c_opcode_probe = (probefn_probeblock & state[M_BIT]) ? 3'd5 : 3'd4;
assign c_param_inval = state[E_BIT] ? 3'd1 : 3'd2;
assign c_param_wb = 3'd3;
assign c_param_wbinval = state[E_BIT] ? 3'd1 : 3'd2;
assign c_param_tot = state[E_BIT] ? 3'd3 : state[S_BIT] ? 3'd4 : 3'd5;
assign c_param_tob = state[E_BIT] ? 3'd0 : state[S_BIT] ? 3'd4 : 3'd5;
assign c_param_ton = state[E_BIT] ? 3'd1 : state[S_BIT] ? 3'd2 : 3'd5;
assign c_param_probe = ({3{probefn_tot}} & c_param_tot) | ({3{probefn_tob}} & c_param_tob) | ({3{probefn_ton}} & c_param_ton);
assign c_valid = fsm_release;
assign c_addr = {addr[PALEN - 1:6],6'd0};
assign c_opcode = ({3{func_inval}} & c_opcode_inval) | ({3{func_wb}} & c_opcode_wb) | ({3{func_wbinval}} & c_opcode_wbinval) | ({3{func_probe}} & c_opcode_probe);
assign c_param = ({3{func_inval}} & c_param_inval) | ({3{func_wb}} & c_param_wb) | ({3{func_wbinval}} & c_param_wbinval) | ({3{func_probe}} & c_param_probe);
assign c_source = source;
assign c_data = wbf_r_data;
assign c_last = (wbf_r_addr[5] & (l2dw256 | wbf_r_addr[4]) & (l2dw128 | wbf_r_addr[3])) | func[2] | ~state[M_BIT] | (func_probe & ~probefn_probeblock);
assign c_grant = c_valid & c_ready;
assign d_grant = d_valid & d_ready;
assign d_ready = 1'b1;
endmodule

