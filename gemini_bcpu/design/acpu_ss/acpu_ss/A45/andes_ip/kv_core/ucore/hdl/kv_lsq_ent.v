// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsq_ent (
    core_clk,
    core_reset_n,
    enq_valid,
    enq_func,
    enq_pc,
    enq_addr,
    enq_ilm,
    enq_dlm,
    cmt_valid,
    cmt_kill,
    replay,
    replay_offset,
    resp_valid,
    resp_abort,
    resp_multi,
    resp_first,
    resp_mtype,
    deq_valid,
    req_grant,
    req_offset_nx,
    valid,
    base,
    offset,
    func,
    pc,
    ilm,
    dlm,
    committed,
    killed,
    abort,
    mtype
);
parameter EXTVALEN = 32;
localparam B_INVALID = 0;
localparam B_SPECULATIVE = 1;
localparam B_COMMITTED = 2;
localparam B_KILLED = 3;
localparam FSM_BITS = 4;
localparam FSM_RESET = 4'd1;
input core_clk;
input core_reset_n;
input enq_valid;
input [26:0] enq_func;
input [11:0] enq_pc;
input [EXTVALEN - 1:0] enq_addr;
input enq_ilm;
input enq_dlm;
input cmt_valid;
input cmt_kill;
input replay;
input [2:0] replay_offset;
input resp_valid;
input resp_abort;
input resp_multi;
input resp_first;
input [3:0] resp_mtype;
input deq_valid;
input req_grant;
input [2:0] req_offset_nx;
output valid;
output [EXTVALEN - 1:0] base;
output [2:0] offset;
output [26:0] func;
output [11:0] pc;
output ilm;
output dlm;
output committed;
output killed;
output abort;
output [3:0] mtype;


reg [FSM_BITS - 1:0] s0;
reg [FSM_BITS - 1:0] s1;
reg s2;
wire s3 = s0[B_INVALID];
wire s4 = s0[B_COMMITTED];
wire s5 = s0[B_KILLED];
reg [EXTVALEN - 1:0] base;
reg [26:0] func;
reg [11:0] pc;
reg ilm;
reg dlm;
wire s6;
reg [2:0] offset;
wire [2:0] s7;
wire [2:0] s8 = func[0 +:3];
reg abort;
wire s9;
wire s10;
wire s11;
wire s12;
reg [3:0] mtype;
wire [3:0] s13;
wire s14;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s0 <= FSM_RESET;
    end
    else if (s2) begin
        s0 <= s1;
    end
end

always @(posedge core_clk) begin
    if (enq_valid) begin
        base <= enq_addr;
        func <= enq_func;
        pc <= enq_pc;
        ilm <= enq_ilm;
        dlm <= enq_dlm;
    end
end

always @(posedge core_clk) begin
    if (s6) begin
        offset <= s7;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        abort <= 1'b0;
    end
    else if (s9) begin
        abort <= s10;
    end
end

always @(posedge core_clk) begin
    if (s14) begin
        mtype <= s13;
    end
end

always @* begin
    s1 = {FSM_BITS{1'b0}};
    case (1'b1)
        s0[B_INVALID]: begin
            s1[B_SPECULATIVE] = 1'b1;
            s2 = enq_valid;
        end
        s0[B_SPECULATIVE]: begin
            if (deq_valid) begin
                s1[B_INVALID] = 1'b1;
            end
            else if (cmt_kill) begin
                s1[B_KILLED] = 1'b1;
            end
            else begin
                s1[B_COMMITTED] = 1'b1;
            end
            s2 = cmt_valid | deq_valid;
        end
        s0[B_COMMITTED]: begin
            s1[B_INVALID] = 1'b1;
            s2 = deq_valid;
        end
        s0[B_KILLED]: begin
            s1[B_INVALID] = 1'b1;
            s2 = deq_valid;
        end
        default: begin
            s1 = {FSM_BITS{1'b0}};
            s2 = 1'b0;
        end
    endcase
end

assign s6 = enq_valid | req_grant | replay;
assign s7 = (valid & replay) ? replay_offset : req_grant ? req_offset_nx : 3'd0;
assign s14 = enq_valid | (resp_valid & resp_multi & resp_first);
assign s13 = s3 ? 4'd0 : resp_mtype;
assign s9 = s12 | s11;
assign s12 = resp_valid & resp_abort;
assign s11 = enq_valid | deq_valid;
assign s10 = ~s11 & (abort | s12);
assign valid = ~s3;
assign killed = s5;
assign committed = s4 | s5;
endmodule

