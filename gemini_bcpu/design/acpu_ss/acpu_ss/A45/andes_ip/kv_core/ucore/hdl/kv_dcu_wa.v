// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_wa (
    dcu_clk,
    dcu_reset_n,
    csr_mcache_ctl_dc_waround,
    wa_cmt_valid,
    wa_cmt_kill,
    wa_cmt_addr,
    wa_cmt_wmask,
    wa_cmt_func,
    wna_mode
);
parameter PALEN = 32;
parameter CACHE_LINE_SIZE = 64;
parameter WRITE_AROUND_SUPPORT_INT = 0;
localparam IDLE = 0;
localparam DETECT = 1;
localparam WA = 2;
localparam FSM_BITS = 3;
localparam FSM_RESET = 3'd1;
localparam GRN_LSB = 2;
localparam IDX_LSB = 6;
input dcu_clk;
input dcu_reset_n;
input [1:0] csr_mcache_ctl_dc_waround;
input wa_cmt_valid;
input wa_cmt_kill;
input [PALEN - 1:0] wa_cmt_addr;
input [3:0] wa_cmt_wmask;
input [2:0] wa_cmt_func;
output wna_mode;


wire s0 = (WRITE_AROUND_SUPPORT_INT == 1);
reg [FSM_BITS - 1:0] s1;
reg [FSM_BITS - 1:0] s2;
reg s3;
wire s4 = (csr_mcache_ctl_dc_waround != 2'd0) & s0;
wire s5;
wire s6;
wire s7;
wire s8;
wire s9;
wire s10;
wire s11 = wa_cmt_func[0];
wire s12 = wa_cmt_func[2];
wire s13 = wa_cmt_func[1];
wire s14 = s12 & s11;
wire s15 = s13 & s11;
wire s16 = wa_cmt_kill | (~|wa_cmt_wmask);
wire s17 = wa_cmt_valid & ~s16;
wire s18 = 1'b0;
generate
    if (WRITE_AROUND_SUPPORT_INT == 1) begin:gen_wa_reg
        wire [CACHE_LINE_SIZE - 1:0] s19;
        wire [CACHE_LINE_SIZE - 1:0] s20;
        wire s21 = s1[IDLE];
        wire s22 = s1[DETECT] & s0;
        wire s23 = s1[WA] & s0;
        wire s24 = ~s21;
        reg [PALEN - 1:0] s25;
        wire [PALEN - 1:0] s26;
        wire s27;
        reg [CACHE_LINE_SIZE - 1:0] s28;
        wire [CACHE_LINE_SIZE - 1:0] s29;
        wire s30;
        wire [6:0] s31;
        wire s32;
        wire s33;
        wire s34;
        wire [6:0] s35;
        reg [1:0] s36;
        wire nds_unused_line_tercnt;
        kv_cnt_scnto #(
            .W(7),
            .COUNT_TO(7'h7f)
        ) u_line_cnt (
            .clk(dcu_clk),
            .rst_n(dcu_reset_n),
            .en(s32),
            .up_dn(1'b1),
            .load(s33),
            .data(7'd0),
            .cnt(s31),
            .tercnt(nds_unused_line_tercnt)
        );
        kv_zero_ext #(
            .OW(CACHE_LINE_SIZE),
            .IW(4)
        ) u_wa_cmt_wmask_ze (
            .out(s19),
            .in(wa_cmt_wmask)
        );
        assign s20 = s19 << {wa_cmt_addr[IDX_LSB - 1:GRN_LSB],{GRN_LSB{1'b0}}};
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                s25 <= {PALEN{1'b0}};
            end
            else if (s27) begin
                s25 <= s26;
            end
        end

        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                s28 <= {CACHE_LINE_SIZE{1'b0}};
            end
            else if (s30) begin
                s28 <= s29;
            end
        end

        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                s36 <= 2'd0;
            end
            else if (s7) begin
                s36 <= csr_mcache_ctl_dc_waround;
            end
        end

        assign s26 = {wa_cmt_addr[PALEN - 1:IDX_LSB],{IDX_LSB{1'b0}}};
        assign s27 = (s21 & s4) | (s24 & s17 & s14);
        assign s30 = (s21 & s4) | (s24 & s17 & s12 & (s11 | s10));
        assign s29 = ({CACHE_LINE_SIZE{s10 & s24}} & s28) | s20;
        assign s5 = &s28;
        assign s33 = (s24 & s9) | (s21 & s4);
        assign s34 = s24 & s17 & s14 & s5 & ~s10 & ~s6;
        assign s32 = s33 | s34;
        assign s35 = (s36 == 2'b01) ? 7'd3 : (s36 == 2'b10) ? 7'd63 : 7'd127;
        assign s6 = s31 == s35;
        assign s10 = wa_cmt_addr[PALEN - 1:IDX_LSB] == s25[PALEN - 1:IDX_LSB];
        assign s7 = s36 != csr_mcache_ctl_dc_waround;
        assign wna_mode = (s23 & s10) | (s23 & s5) | (s22 & s8) | s18;
    end
    else begin:gen_wa_stub
        assign wna_mode = s18;
        assign s6 = 1'd0;
        assign s10 = 1'b0;
        assign s5 = 1'b0;
        assign s7 = 1'b0;
        wire [PALEN - 1:0] s37 = wa_cmt_addr;
    end
endgenerate
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        s1 <= FSM_RESET;
    end
    else if (s3) begin
        s1 <= s2;
    end
end

always @* begin
    s2 = {FSM_BITS{1'b0}};
    case (1'b1)
        s1[IDLE]: begin
            s2[DETECT] = 1'b1;
            s3 = s4;
        end
        s1[DETECT]: begin
            if (s7) begin
                s2[IDLE] = 1'b1;
                s3 = 1'b1;
            end
            else begin
                s2[WA] = 1'b1;
                s3 = s8;
            end
        end
        s1[WA]: begin
            if (s7) begin
                s2[IDLE] = 1'b1;
                s3 = 1'b1;
            end
            else begin
                s2[DETECT] = 1'b1;
                s3 = s9;
            end
        end
        default: begin
            s2 = {FSM_BITS{1'b0}};
            s3 = 1'b0;
        end
    endcase
end

assign s9 = (s17 & s14 & ~s10 & ~s5) | (s17 & s15 & s10) | s7;
assign s8 = s5 & s6;
endmodule

