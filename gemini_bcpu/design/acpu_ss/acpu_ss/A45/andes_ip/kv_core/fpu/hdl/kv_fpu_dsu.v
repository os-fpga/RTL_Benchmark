// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fpu_dsu (
    ds_result0,
    ds_result1,
    ds_busy,
    ds_gen_sticky,
    ds_calc_done,
    ds_din0,
    ds_din1,
    ds_invalidate,
    ds_type,
    div_enable,
    sqrt_enable,
    f3_stall,
    core_clk,
    core_reset_n
);
parameter FLEN = 32;
localparam DS_COUNT_WIDTH = (FLEN == 64) ? 5 : (FLEN == 32) ? 4 : 3;
localparam FRACTION_WIDTH = (FLEN == 64) ? 53 : (FLEN == 32) ? 24 : 11;
localparam DS_COUNT_MSB = DS_COUNT_WIDTH - 1;
localparam DS_DIN_WIDTH = FRACTION_WIDTH + 1;
localparam DS_DIN_MSB = DS_DIN_WIDTH - 1;
localparam DS_DOUT_WIDTH = FRACTION_WIDTH + 5;
localparam DS_DOUT_MSB = DS_DOUT_WIDTH - 1;
localparam DS_QR_WIDTH = FRACTION_WIDTH + 2;
localparam DS_QR_MSB = DS_QR_WIDTH - 1;
localparam DS_SQRT_OP_WIDTH = FRACTION_WIDTH + 3;
localparam DS_SQRT_OP_MSB = DS_SQRT_OP_WIDTH - 1;
output [DS_DOUT_MSB:0] ds_result0;
output [DS_DOUT_MSB:0] ds_result1;
output ds_busy;
output ds_gen_sticky;
output ds_calc_done;
input [DS_DIN_MSB:0] ds_din0;
input [DS_DIN_MSB:1] ds_din1;
input ds_invalidate;
input [1:0] ds_type;
input div_enable;
input sqrt_enable;
input f3_stall;
input core_clk;
input core_reset_n;
parameter DS_ST_IDLE = 2'b00;
parameter DS_ST_INIT = 2'b01;
parameter DS_ST_CALC = 2'b10;
parameter DS_ST_DONE = 2'b11;


reg [DS_DIN_MSB:1] s0;
wire [53:1] s1;
reg [DS_QR_MSB:0] s2;
reg [DS_QR_MSB:0] s3;
wire [54:0] s4;
wire [54:0] s5;
reg [1:0] s6;
reg [1:0] s7;
reg [54:0] s8;
reg [54:0] s9;
wire s10;
wire s11;
wire [DS_QR_MSB:0] s12;
wire [DS_QR_MSB:0] s13;
wire s14;
wire s15;
reg [2:0] s16;
reg [2:0] s17;
wire [2:0] s18;
wire [2:0] s19;
wire [2:0] s20;
wire [6:0] s21;
wire s22;
wire [6:0] s23;
wire [6:0] s24;
reg [DS_DOUT_MSB:1] s25;
reg [DS_DOUT_MSB:3] s26;
wire [57:1] s27;
wire [57:3] s28;
reg [55:0] s29;
reg [55:0] s30;
wire [DS_SQRT_OP_MSB:0] s31;
wire [DS_SQRT_OP_MSB:0] s32;
reg [DS_DOUT_MSB:0] s33;
reg [DS_DOUT_MSB:0] s34;
wire s35;
wire [DS_DOUT_MSB:1] s36;
wire [DS_DOUT_MSB:3] s37;
wire [DS_DOUT_MSB:0] s38;
wire [DS_DOUT_MSB:0] s39;
wire [DS_DOUT_MSB:0] s40;
wire [DS_DOUT_MSB:0] s41;
wire [DS_DOUT_MSB:0] s42;
reg [1:0] s43;
reg [1:0] s44;
reg ds_busy;
reg s45;
reg [1:0] s46;
reg [DS_COUNT_MSB:0] s47;
wire [4:0] s48;
wire s49;
wire s50;
wire s51;
wire s52;
wire s53;
wire s54;
wire s55;
wire s56;
wire [DS_COUNT_MSB:0] s57;
wire s58;
wire s59;
wire s60;
wire s61;
assign s54 = div_enable | sqrt_enable;
wire s62 = (s43 != DS_ST_IDLE) | s54 | ds_invalidate;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s43 <= DS_ST_IDLE;
    end
    else if (s62) begin
        s43 <= s44;
    end
end

always @* begin
    case (s43)
        DS_ST_INIT: begin
            if (ds_invalidate) begin
                s44 = DS_ST_IDLE;
            end
            else begin
                s44 = DS_ST_CALC;
            end
        end
        DS_ST_CALC: begin
            if (ds_invalidate) begin
                s44 = DS_ST_IDLE;
            end
            else if (s60 & !f3_stall) begin
                s44 = DS_ST_DONE;
            end
            else begin
                s44 = DS_ST_CALC;
            end
        end
        DS_ST_DONE: begin
            if (ds_invalidate) begin
                s44 = DS_ST_IDLE;
            end
            else begin
                s44 = DS_ST_IDLE;
            end
        end
        DS_ST_IDLE: begin
            if (ds_invalidate) begin
                s44 = DS_ST_IDLE;
            end
            else if (div_enable) begin
                s44 = DS_ST_CALC;
            end
            else if (sqrt_enable) begin
                s44 = DS_ST_CALC;
            end
            else begin
                s44 = DS_ST_IDLE;
            end
        end
        default: s44 = 2'b0;
    endcase
end

assign s50 = (s43 == DS_ST_IDLE);
assign s52 = (s43 == DS_ST_INIT);
assign s51 = (s43 == DS_ST_CALC);
assign s53 = (s43 == DS_ST_DONE);
assign s55 = s54 & (s50 | s53);
assign s10 = div_enable & (s50 | s53);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s0 <= {(DS_DIN_WIDTH - 1){1'b0}};
    end
    else if (s10) begin
        s0 <= ds_din1[DS_DIN_MSB:1];
    end
end

assign s56 = s55;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s45 <= 1'b0;
        s46 <= 2'b0;
    end
    else if (s56) begin
        s45 <= sqrt_enable;
        s46 <= ds_type;
    end
end

assign s59 = s60 & s51;
assign s60 = (s46 == 2'b10) ? (s48 == 5'd6) : (s46 == 2'b01) ? (s48 == 5'd13) : (s48 == 5'd27);
assign s58 = s55 | (!s60 & s51);
assign s57 = s51 ? s47 + {{DS_COUNT_MSB{1'b0}},1'b1} : {{(DS_COUNT_WIDTH - 1){1'b0}},sqrt_enable};
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s47 <= {DS_COUNT_WIDTH{1'b0}};
    end
    else if (s58) begin
        s47 <= s57;
    end
end

assign s23 = s27[57:51];
assign s24 = s28[57:51];
assign s22 = s27[50] & s28[50];
assign s21 = s23 + s24 + {6'd0,s22};
assign s61 = (s48 == 5'd1);
assign s18 = s61 ? 3'b101 : s4[54] ? 3'b111 : s4[52:50];
assign s20 = s45 ? s18 : s1[52:50];
always @* begin
    case (s21)
        7'b0000_000: begin
            s16 = 3'b000;
        end
        7'b0000_001: begin
            s16 = 3'b000;
        end
        7'b0000_010: begin
            s16 = 3'b000;
        end
        7'b0000_011: begin
            s16 = 3'b000;
        end
        7'b0000_100: begin
            case (s20)
                3'b000: s16 = 3'b001;
                3'b001: s16 = 3'b001;
                3'b010: s16 = 3'b001;
                3'b011: s16 = 3'b001;
                default: begin
                    s16 = 3'b000;
                end
            endcase
        end
        7'b0000_101: begin
            case (s20)
                3'b000: s16 = 3'b001;
                3'b001: s16 = 3'b001;
                3'b010: s16 = 3'b001;
                3'b011: s16 = 3'b001;
                default: begin
                    s16 = 3'b000;
                end
            endcase
        end
        7'b0000_110: begin
            s16 = 3'b001;
        end
        7'b0000_111: begin
            s16 = 3'b001;
        end
        7'b0001_000: begin
            s16 = 3'b001;
        end
        7'b0001_001: begin
            s16 = 3'b001;
        end
        7'b0001_010: begin
            s16 = 3'b001;
        end
        7'b0001_011: begin
            s16 = 3'b001;
        end
        7'b0001_100: begin
            case (s20)
                3'b000: s16 = 3'b010;
                default: s16 = 3'b001;
            endcase
        end
        7'b0001_101: begin
            case (s20)
                3'b000: s16 = 3'b010;
                default: s16 = 3'b001;
            endcase
        end
        7'b0001_110: begin
            case (s20)
                3'b000: s16 = 3'b010;
                3'b001: s16 = 3'b010;
                default: s16 = 3'b001;
            endcase
        end
        7'b0001_111: begin
            case (s20)
                3'b000: s16 = 3'b010;
                3'b001: s16 = 3'b010;
                default: s16 = 3'b001;
            endcase
        end
        7'b0010_000: begin
            case (s20)
                3'b000: s16 = 3'b010;
                3'b001: s16 = 3'b010;
                3'b010: s16 = 3'b010;
                3'b011: s16 = 3'b010;
                default: s16 = 3'b001;
            endcase
        end
        7'b0010_001: begin
            case (s20)
                3'b000: s16 = 3'b010;
                3'b001: s16 = 3'b010;
                3'b010: s16 = 3'b010;
                3'b011: s16 = 3'b010;
                default: s16 = 3'b001;
            endcase
        end
        7'b0010_010: begin
            case (s20)
                3'b000: s16 = 3'b010;
                3'b001: s16 = 3'b010;
                3'b010: s16 = 3'b010;
                3'b011: s16 = 3'b010;
                default: s16 = 3'b001;
            endcase
        end
        7'b0010_011: begin
            case (s20)
                3'b000: s16 = 3'b010;
                3'b001: s16 = 3'b010;
                3'b010: s16 = 3'b010;
                3'b011: s16 = 3'b010;
                3'b100: s16 = 3'b010;
                default: s16 = 3'b001;
            endcase
        end
        7'b0010_100: begin
            case (s20)
                3'b110: s16 = 3'b001;
                3'b111: s16 = 3'b001;
                default: s16 = 3'b010;
            endcase
        end
        7'b0010_101: begin
            case (s20)
                3'b110: s16 = 3'b001;
                3'b111: s16 = 3'b001;
                default: s16 = 3'b010;
            endcase
        end
        7'b1111_111: begin
            s16 = 3'b000;
        end
        7'b1111_110: begin
            s16 = 3'b000;
        end
        7'b1111_101: begin
            s16 = 3'b000;
        end
        7'b1111_100: begin
            s16 = 3'b000;
        end
        7'b1111_011: begin
            case (s20)
                3'b000: s16 = 3'b111;
                3'b001: s16 = 3'b111;
                default: s16 = 3'b000;
            endcase
        end
        7'b1111_010: begin
            case (s20)
                3'b000: s16 = 3'b111;
                3'b001: s16 = 3'b111;
                default: s16 = 3'b000;
            endcase
        end
        7'b1111_001: begin
            s16 = 3'b111;
        end
        7'b1111_000: begin
            s16 = 3'b111;
        end
        7'b1110_111: begin
            s16 = 3'b111;
        end
        7'b1110_110: begin
            s16 = 3'b111;
        end
        7'b1110_101: begin
            s16 = 3'b111;
        end
        7'b1110_100: begin
            s16 = 3'b111;
        end
        7'b1110_011: begin
            s16 = 3'b111;
        end
        7'b1110_010: begin
            case (s20)
                3'b000: s16 = 3'b110;
                default: s16 = 3'b111;
            endcase
        end
        7'b1110_001: begin
            case (s20)
                3'b000: s16 = 3'b110;
                3'b001: s16 = 3'b110;
                default: s16 = 3'b111;
            endcase
        end
        7'b1110_000: begin
            case (s20)
                3'b000: s16 = 3'b110;
                3'b001: s16 = 3'b110;
                default: s16 = 3'b111;
            endcase
        end
        7'b1101_111: begin
            case (s20)
                3'b000: s16 = 3'b110;
                3'b001: s16 = 3'b110;
                3'b010: s16 = 3'b110;
                default: s16 = 3'b111;
            endcase
        end
        7'b1101_110: begin
            case (s20)
                3'b000: s16 = 3'b110;
                3'b001: s16 = 3'b110;
                3'b010: s16 = 3'b110;
                3'b011: s16 = 3'b110;
                default: s16 = 3'b111;
            endcase
        end
        7'b1101_101: begin
            case (s20)
                3'b000: s16 = 3'b110;
                3'b001: s16 = 3'b110;
                3'b010: s16 = 3'b110;
                3'b011: s16 = 3'b110;
                default: s16 = 3'b111;
            endcase
        end
        7'b1101_100: begin
            case (s20)
                3'b000: s16 = 3'b110;
                3'b001: s16 = 3'b110;
                3'b010: s16 = 3'b110;
                3'b011: s16 = 3'b110;
                default: s16 = 3'b111;
            endcase
        end
        7'b1101_011: begin
            case (s20)
                3'b110: s16 = 3'b111;
                3'b111: s16 = 3'b111;
                default: s16 = 3'b110;
            endcase
        end
        7'b1101_010: begin
            case (s20)
                3'b110: s16 = 3'b111;
                3'b111: s16 = 3'b111;
                default: s16 = 3'b110;
            endcase
        end
        default: begin
            s16 = {s21[6],2'b10};
        end
    endcase
end

always @* begin
    case ({s21})
        7'b0000_000: begin
            s17 = 3'b000;
        end
        7'b0000_001: begin
            s17 = 3'b000;
        end
        7'b0000_010: begin
            s17 = 3'b000;
        end
        7'b0000_011: begin
            s17 = 3'b000;
        end
        7'b0000_100: begin
            case (s20)
                3'b000: s17 = 3'b001;
                3'b001: s17 = 3'b001;
                3'b010: s17 = 3'b001;
                3'b011: s17 = 3'b001;
                default: s17 = 3'b000;
            endcase
        end
        7'b0000_101: begin
            case (s20)
                3'b000: s17 = 3'b001;
                3'b001: s17 = 3'b001;
                3'b010: s17 = 3'b001;
                3'b011: s17 = 3'b001;
                default: s17 = 3'b000;
            endcase
        end
        7'b0000_110: begin
            case (s20)
                3'b110: s17 = 3'b000;
                3'b111: s17 = 3'b000;
                default: s17 = 3'b001;
            endcase
        end
        7'b0000_111: begin
            case (s20)
                3'b110: s17 = 3'b000;
                3'b111: s17 = 3'b000;
                default: s17 = 3'b001;
            endcase
        end
        7'b0001_000: begin
            s17 = 3'b001;
        end
        7'b0001_001: begin
            s17 = 3'b001;
        end
        7'b0001_010: begin
            s17 = 3'b001;
        end
        7'b0001_011: begin
            s17 = 3'b001;
        end
        7'b0001_100: begin
            case (s20)
                3'b000: s17 = 3'b010;
                default: s17 = 3'b001;
            endcase
        end
        7'b0001_101: begin
            case (s20)
                3'b000: s17 = 3'b010;
                default: s17 = 3'b001;
            endcase
        end
        7'b0001_110: begin
            case (s20)
                3'b000: s17 = 3'b010;
                3'b001: s17 = 3'b010;
                default: s17 = 3'b001;
            endcase
        end
        7'b0001_111: begin
            case (s20)
                3'b000: s17 = 3'b010;
                3'b001: s17 = 3'b010;
                default: s17 = 3'b001;
            endcase
        end
        7'b0010_000: begin
            case (s20)
                3'b000: s17 = 3'b010;
                3'b001: s17 = 3'b010;
                3'b010: s17 = 3'b010;
                3'b011: s17 = 3'b010;
                default: s17 = 3'b001;
            endcase
        end
        7'b0010_001: begin
            case (s20)
                3'b000: s17 = 3'b010;
                3'b001: s17 = 3'b010;
                3'b010: s17 = 3'b010;
                3'b011: s17 = 3'b010;
                default: s17 = 3'b001;
            endcase
        end
        7'b0010_010: begin
            case (s20)
                3'b000: s17 = 3'b010;
                3'b001: s17 = 3'b010;
                3'b010: s17 = 3'b010;
                3'b011: s17 = 3'b010;
                3'b100: s17 = 3'b010;
                default: s17 = 3'b001;
            endcase
        end
        7'b0010_011: begin
            case (s20)
                3'b000: s17 = 3'b010;
                3'b001: s17 = 3'b010;
                3'b010: s17 = 3'b010;
                3'b011: s17 = 3'b010;
                3'b100: s17 = 3'b010;
                default: s17 = 3'b001;
            endcase
        end
        7'b0010_100: begin
            case (s20)
                3'b111: s17 = 3'b001;
                default: s17 = 3'b010;
            endcase
        end
        7'b0010_101: begin
            case (s20)
                3'b111: s17 = 3'b001;
                default: s17 = 3'b010;
            endcase
        end
        7'b0010_110: begin
            s17 = 3'b010;
        end
        7'b0010_111: begin
            s17 = 3'b010;
        end
        7'b0011_000: begin
            s17 = 3'b010;
        end
        7'b0011_001: begin
            s17 = 3'b010;
        end
        7'b0011_010: begin
            s17 = 3'b010;
        end
        7'b0011_011: begin
            s17 = 3'b010;
        end
        7'b0011_100: begin
            s17 = 3'b010;
        end
        7'b0011_101: begin
            s17 = 3'b010;
        end
        7'b0011_110: begin
            s17 = 3'b010;
        end
        7'b0011_111: begin
            s17 = 3'b010;
        end
        7'b1100_000: begin
            s17 = 3'b110;
        end
        7'b1100_001: begin
            s17 = 3'b110;
        end
        7'b1100_010: begin
            s17 = 3'b110;
        end
        7'b1100_011: begin
            s17 = 3'b110;
        end
        7'b1100_100: begin
            s17 = 3'b110;
        end
        7'b1100_101: begin
            s17 = 3'b110;
        end
        7'b1100_110: begin
            s17 = 3'b110;
        end
        7'b1100_111: begin
            s17 = 3'b110;
        end
        7'b1101_000: begin
            s17 = 3'b110;
        end
        7'b1101_001: begin
            case (s20)
                3'b111: s17 = 3'b111;
                default: s17 = 3'b110;
            endcase
        end
        7'b1101_010: begin
            case (s20)
                3'b110: s17 = 3'b111;
                3'b111: s17 = 3'b111;
                default: s17 = 3'b110;
            endcase
        end
        7'b1101_011: begin
            case (s20)
                3'b110: s17 = 3'b111;
                3'b111: s17 = 3'b111;
                default: s17 = 3'b110;
            endcase
        end
        7'b1101_100: begin
            case (s20)
                3'b101: s17 = 3'b111;
                3'b110: s17 = 3'b111;
                3'b111: s17 = 3'b111;
                default: s17 = 3'b110;
            endcase
        end
        7'b1101_101: begin
            case (s20)
                3'b101: s17 = 3'b111;
                3'b110: s17 = 3'b111;
                3'b111: s17 = 3'b111;
                default: s17 = 3'b110;
            endcase
        end
        7'b1101_110: begin
            case (s20)
                3'b100: s17 = 3'b111;
                3'b101: s17 = 3'b111;
                3'b110: s17 = 3'b111;
                3'b111: s17 = 3'b111;
                default: s17 = 3'b110;
            endcase
        end
        7'b1101_111: begin
            case (s20)
                3'b011: s17 = 3'b111;
                3'b100: s17 = 3'b111;
                3'b101: s17 = 3'b111;
                3'b110: s17 = 3'b111;
                3'b111: s17 = 3'b111;
                default: s17 = 3'b110;
            endcase
        end
        7'b1110_000: begin
            case (s20)
                3'b000: s17 = 3'b110;
                3'b001: s17 = 3'b110;
                default: s17 = 3'b111;
            endcase
        end
        7'b1110_001: begin
            case (s20)
                3'b000: s17 = 3'b110;
                3'b001: s17 = 3'b110;
                default: s17 = 3'b111;
            endcase
        end
        7'b1110_010: begin
            case (s20)
                3'b000: s17 = 3'b110;
                default: s17 = 3'b111;
            endcase
        end
        7'b1110_011: begin
            s17 = 3'b111;
        end
        7'b1110_100: begin
            s17 = 3'b111;
        end
        7'b1110_101: begin
            s17 = 3'b111;
        end
        7'b1110_110: begin
            s17 = 3'b111;
        end
        7'b1110_111: begin
            s17 = 3'b111;
        end
        7'b1111_000: begin
            case (s20)
                3'b101: s17 = 3'b000;
                3'b110: s17 = 3'b000;
                3'b111: s17 = 3'b000;
                default: s17 = 3'b111;
            endcase
        end
        7'b1111_001: begin
            case (s20)
                3'b101: s17 = 3'b000;
                3'b110: s17 = 3'b000;
                3'b111: s17 = 3'b000;
                default: s17 = 3'b111;
            endcase
        end
        7'b1111_010: begin
            case (s20)
                3'b000: s17 = 3'b111;
                3'b001: s17 = 3'b111;
                default: s17 = 3'b000;
            endcase
        end
        7'b1111_011: begin
            case (s20)
                3'b000: s17 = 3'b111;
                default: s17 = 3'b000;
            endcase
        end
        7'b1111_100: begin
            s17 = 3'b000;
        end
        7'b1111_101: begin
            s17 = 3'b000;
        end
        7'b1111_110: begin
            s17 = 3'b000;
        end
        7'b1111_111: begin
            s17 = 3'b000;
        end
        default: s17 = {s21[6],2'b10};
    endcase
end

assign s19 = s45 ? s17 : s16;
always @* begin
    case (s19)
        3'b001: begin
            s6 = 2'b01;
            s7 = 2'b00;
        end
        3'b010: begin
            s6 = 2'b10;
            s7 = 2'b01;
        end
        3'b110: begin
            s6 = 2'b10;
            s7 = 2'b01;
        end
        3'b111: begin
            s6 = 2'b11;
            s7 = 2'b10;
        end
        default: begin
            s6 = 2'b00;
            s7 = 2'b11;
        end
    endcase
end

assign s14 = !s19[2];
assign s15 = !s19[2] & |s19[1:0];
always @* begin
    case (s48)
        5'd0: begin
            s8 = {s6[0],54'd0};
            s9 = {s7[0],54'd0};
        end
        5'd1: begin
            s8 = s14 ? {s4[54],s6,52'd0} : {s5[54],s6,52'd0};
            s9 = s15 ? {s4[54],s7,52'd0} : {s5[54],s7,52'd0};
        end
        5'd2: begin
            s8 = s14 ? {s4[54:52],s6,50'd0} : {s5[54:52],s6,50'd0};
            s9 = s15 ? {s4[54:52],s7,50'd0} : {s5[54:52],s7,50'd0};
        end
        5'd3: begin
            s8 = s14 ? {s4[54:50],s6,48'd0} : {s5[54:50],s6,48'd0};
            s9 = s15 ? {s4[54:50],s7,48'd0} : {s5[54:50],s7,48'd0};
        end
        5'd4: begin
            s8 = s14 ? {s4[54:48],s6,46'd0} : {s5[54:48],s6,46'd0};
            s9 = s15 ? {s4[54:48],s7,46'd0} : {s5[54:48],s7,46'd0};
        end
        5'd5: begin
            s8 = s14 ? {s4[54:46],s6,44'd0} : {s5[54:46],s6,44'd0};
            s9 = s15 ? {s4[54:46],s7,44'd0} : {s5[54:46],s7,44'd0};
        end
        5'd6: begin
            s8 = s14 ? {s4[54:44],s6,42'd0} : {s5[54:44],s6,42'd0};
            s9 = s15 ? {s4[54:44],s7,42'd0} : {s5[54:44],s7,42'd0};
        end
        5'd7: begin
            s8 = s14 ? {s4[54:42],s6,40'd0} : {s5[54:42],s6,40'd0};
            s9 = s15 ? {s4[54:42],s7,40'd0} : {s5[54:42],s7,40'd0};
        end
        5'd8: begin
            s8 = s14 ? {s4[54:40],s6,38'd0} : {s5[54:40],s6,38'd0};
            s9 = s15 ? {s4[54:40],s7,38'd0} : {s5[54:40],s7,38'd0};
        end
        5'd9: begin
            s8 = s14 ? {s4[54:38],s6,36'd0} : {s5[54:38],s6,36'd0};
            s9 = s15 ? {s4[54:38],s7,36'd0} : {s5[54:38],s7,36'd0};
        end
        5'd10: begin
            s8 = s14 ? {s4[54:36],s6,34'd0} : {s5[54:36],s6,34'd0};
            s9 = s15 ? {s4[54:36],s7,34'd0} : {s5[54:36],s7,34'd0};
        end
        5'd11: begin
            s8 = s14 ? {s4[54:34],s6,32'd0} : {s5[54:34],s6,32'd0};
            s9 = s15 ? {s4[54:34],s7,32'd0} : {s5[54:34],s7,32'd0};
        end
        5'd12: begin
            s8 = s14 ? {s4[54:32],s6,30'd0} : {s5[54:32],s6,30'd0};
            s9 = s15 ? {s4[54:32],s7,30'd0} : {s5[54:32],s7,30'd0};
        end
        5'd13: begin
            s8 = s14 ? {s4[54:30],s6,28'd0} : {s5[54:30],s6,28'd0};
            s9 = s15 ? {s4[54:30],s7,28'd0} : {s5[54:30],s7,28'd0};
        end
        5'd14: begin
            s8 = s14 ? {s4[54:28],s6,26'd0} : {s5[54:28],s6,26'd0};
            s9 = s15 ? {s4[54:28],s7,26'd0} : {s5[54:28],s7,26'd0};
        end
        5'd15: begin
            s8 = s14 ? {s4[54:26],s6,24'd0} : {s5[54:26],s6,24'd0};
            s9 = s15 ? {s4[54:26],s7,24'd0} : {s5[54:26],s7,24'd0};
        end
        5'd16: begin
            s8 = s14 ? {s4[54:24],s6,22'd0} : {s5[54:24],s6,22'd0};
            s9 = s15 ? {s4[54:24],s7,22'd0} : {s5[54:24],s7,22'd0};
        end
        5'd17: begin
            s8 = s14 ? {s4[54:22],s6,20'd0} : {s5[54:22],s6,20'd0};
            s9 = s15 ? {s4[54:22],s7,20'd0} : {s5[54:22],s7,20'd0};
        end
        5'd18: begin
            s8 = s14 ? {s4[54:20],s6,18'd0} : {s5[54:20],s6,18'd0};
            s9 = s15 ? {s4[54:20],s7,18'd0} : {s5[54:20],s7,18'd0};
        end
        5'd19: begin
            s8 = s14 ? {s4[54:18],s6,16'd0} : {s5[54:18],s6,16'd0};
            s9 = s15 ? {s4[54:18],s7,16'd0} : {s5[54:18],s7,16'd0};
        end
        5'd20: begin
            s8 = s14 ? {s4[54:16],s6,14'd0} : {s5[54:16],s6,14'd0};
            s9 = s15 ? {s4[54:16],s7,14'd0} : {s5[54:16],s7,14'd0};
        end
        5'd21: begin
            s8 = s14 ? {s4[54:14],s6,12'd0} : {s5[54:14],s6,12'd0};
            s9 = s15 ? {s4[54:14],s7,12'd0} : {s5[54:14],s7,12'd0};
        end
        5'd22: begin
            s8 = s14 ? {s4[54:12],s6,10'd0} : {s5[54:12],s6,10'd0};
            s9 = s15 ? {s4[54:12],s7,10'd0} : {s5[54:12],s7,10'd0};
        end
        5'd23: begin
            s8 = s14 ? {s4[54:10],s6,8'd0} : {s5[54:10],s6,8'd0};
            s9 = s15 ? {s4[54:10],s7,8'd0} : {s5[54:10],s7,8'd0};
        end
        5'd24: begin
            s8 = s14 ? {s4[54:8],s6,6'd0} : {s5[54:8],s6,6'd0};
            s9 = s15 ? {s4[54:8],s7,6'd0} : {s5[54:8],s7,6'd0};
        end
        5'd25: begin
            s8 = s14 ? {s4[54:6],s6,4'd0} : {s5[54:6],s6,4'd0};
            s9 = s15 ? {s4[54:6],s7,4'd0} : {s5[54:6],s7,4'd0};
        end
        5'd26: begin
            s8 = s14 ? {s4[54:4],s6,2'd0} : {s5[54:4],s6,2'd0};
            s9 = s15 ? {s4[54:4],s7,2'd0} : {s5[54:4],s7,2'd0};
        end
        default: begin
            s8 = s14 ? {s4[54:2],s6} : {s5[54:2],s6};
            s9 = s15 ? {s4[54:2],s7} : {s5[54:2],s7};
        end
    endcase
end

assign s12 = s51 ? s8[54:54 - DS_QR_MSB] : {sqrt_enable,{(DS_QR_WIDTH - 1){1'b0}}};
assign s11 = s55 | s51 & (!s60 | !f3_stall);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s2 <= {DS_QR_WIDTH{1'b0}};
    end
    else if (s11) begin
        s2 <= s12;
    end
end

assign s13 = s51 ? s9[54:54 - DS_QR_MSB] : {DS_QR_WIDTH{1'b0}};
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s3 <= {DS_QR_WIDTH{1'b0}};
    end
    else if (s11) begin
        s3 <= s13;
    end
end

always @* begin
    case (s48)
        5'd1: begin
            s29 = {s4[54],s17,52'd0};
            s30 = {s5[54],s17,52'd0};
        end
        5'd2: begin
            s29 = {s4[54:52],s17,50'd0};
            s30 = {s5[54:52],s17,50'd0};
        end
        5'd3: begin
            s29 = {s4[54:50],s17,48'd0};
            s30 = {s5[54:50],s17,48'd0};
        end
        5'd4: begin
            s29 = {s4[54:48],s17,46'd0};
            s30 = {s5[54:48],s17,46'd0};
        end
        5'd5: begin
            s29 = {s4[54:46],s17,44'd0};
            s30 = {s5[54:46],s17,44'd0};
        end
        5'd6: begin
            s29 = {s4[54:44],s17,42'd0};
            s30 = {s5[54:44],s17,42'd0};
        end
        5'd7: begin
            s29 = {s4[54:42],s17,40'd0};
            s30 = {s5[54:42],s17,40'd0};
        end
        5'd8: begin
            s29 = {s4[54:40],s17,38'd0};
            s30 = {s5[54:40],s17,38'd0};
        end
        5'd9: begin
            s29 = {s4[54:38],s17,36'd0};
            s30 = {s5[54:38],s17,36'd0};
        end
        5'd10: begin
            s29 = {s4[54:36],s17,34'd0};
            s30 = {s5[54:36],s17,34'd0};
        end
        5'd11: begin
            s29 = {s4[54:34],s17,32'd0};
            s30 = {s5[54:34],s17,32'd0};
        end
        5'd12: begin
            s29 = {s4[54:32],s17,30'd0};
            s30 = {s5[54:32],s17,30'd0};
        end
        5'd13: begin
            s29 = {s4[54:30],s17,28'd0};
            s30 = {s5[54:30],s17,28'd0};
        end
        5'd14: begin
            s29 = {s4[54:28],s17,26'd0};
            s30 = {s5[54:28],s17,26'd0};
        end
        5'd15: begin
            s29 = {s4[54:26],s17,24'd0};
            s30 = {s5[54:26],s17,24'd0};
        end
        5'd16: begin
            s29 = {s4[54:24],s17,22'd0};
            s30 = {s5[54:24],s17,22'd0};
        end
        5'd17: begin
            s29 = {s4[54:22],s17,20'd0};
            s30 = {s5[54:22],s17,20'd0};
        end
        5'd18: begin
            s29 = {s4[54:20],s17,18'd0};
            s30 = {s5[54:20],s17,18'd0};
        end
        5'd19: begin
            s29 = {s4[54:18],s17,16'd0};
            s30 = {s5[54:18],s17,16'd0};
        end
        5'd20: begin
            s29 = {s4[54:16],s17,14'd0};
            s30 = {s5[54:16],s17,14'd0};
        end
        5'd21: begin
            s29 = {s4[54:14],s17,12'd0};
            s30 = {s5[54:14],s17,12'd0};
        end
        5'd22: begin
            s29 = {s4[54:12],s17,10'd0};
            s30 = {s5[54:12],s17,10'd0};
        end
        5'd23: begin
            s29 = {s4[54:10],s17,8'd0};
            s30 = {s5[54:10],s17,8'd0};
        end
        5'd24: begin
            s29 = {s4[54:8],s17,6'd0};
            s30 = {s5[54:8],s17,6'd0};
        end
        5'd25: begin
            s29 = {s4[54:6],s17,4'd0};
            s30 = {s5[54:6],s17,4'd0};
        end
        5'd26: begin
            s29 = {s4[54:4],s17,2'd0};
            s30 = {s5[54:4],s17,2'd0};
        end
        5'd27: begin
            s29 = {s4[54:2],s17};
            s30 = {s5[54:2],s17};
        end
        default: begin
            s29 = 56'd0;
            s30 = 56'd0;
        end
    endcase
end

always @* begin
    case (s17)
        3'b000: s33 = {DS_DOUT_WIDTH{1'b0}};
        3'b001: s33 = ~{2'd0,s31};
        3'b010: s33 = ~{1'd0,s31,1'b0};
        3'b110: s33 = {1'd0,s32,1'b0};
        3'b111: s33 = {2'd0,s32};
        default: s33 = {DS_DOUT_WIDTH{1'b0}};
    endcase
end

always @* begin
    case (s16)
        3'b000: s34 = {DS_DOUT_WIDTH{1'b0}};
        3'b001: s34 = ~{3'd0,s0,2'd0};
        3'b010: s34 = ~{2'd0,s0,3'd0};
        3'b110: s34 = {2'd0,s0,3'd0};
        3'b111: s34 = {3'd0,s0,2'd0};
        default: s34 = {DS_DOUT_WIDTH{1'b0}};
    endcase
end

assign s35 = s55 | s51 & !s60;
assign s36[DS_DOUT_MSB:1] = {DS_DOUT_MSB{sqrt_enable}} & {2'b11,ds_din0[DS_DIN_MSB:0],1'b0} | {DS_DOUT_MSB{div_enable}} & {3'd0,ds_din0[DS_DIN_MSB:0]} | {DS_DOUT_MSB{s51}} & {s41[DS_DOUT_MSB - 2:0],1'b0};
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s25[DS_DOUT_MSB:1] <= {(DS_DOUT_WIDTH - 1){1'b0}};
    end
    else if (s35) begin
        s25[DS_DOUT_MSB:1] <= s36[DS_DOUT_MSB:1];
    end
end

assign s37[DS_DOUT_MSB:3] = s51 ? s42[DS_DOUT_MSB - 3:0] : {(DS_DOUT_WIDTH - 3){1'b0}};
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s26[DS_DOUT_MSB:3] <= {(DS_DOUT_WIDTH - 3){1'b0}};
    end
    else if (s35) begin
        s26[DS_DOUT_MSB:3] <= s37[DS_DOUT_MSB:3];
    end
end

assign s38 = {s25[DS_DOUT_MSB:1],1'b0};
assign s39 = s45 ? s33 : s34;
assign s40 = {s26[DS_DOUT_MSB:3],2'd0,s15};
kv_csa3_2 #(
    .CSA_WIDTH(DS_DOUT_WIDTH)
) u_dsu_csa (
    .in0(s38),
    .in1(s39),
    .cin(s40),
    .sum(s41),
    .cout(s42)
);
assign ds_gen_sticky = s53;
assign ds_calc_done = s59;
assign s49 = (s44 == DS_ST_INIT) | (s44 == DS_ST_CALC);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        ds_busy <= 1'b0;
    end
    else begin
        ds_busy <= s49;
    end
end

wire s63 = |(s1) | (|s27) | (|s28) | (|s42);
generate
    if (FLEN == 16) begin:gen_fpu_dsu_hp
        assign s48 = {2'b0,s47};
        assign s27 = {s25[15:1],42'b0};
        assign s28 = {s26[15:3],42'b0};
        assign s1 = {s0[11:1],42'b0};
        assign s4 = {s2,42'b0};
        assign s5 = {s3,42'b0};
        assign s31 = s29[55:42];
        assign s32 = s30[55:42];
        assign ds_result0 = s59 ? s41[DS_DOUT_MSB:0] : !s53 ? {DS_DOUT_WIDTH{1'b0}} : {2'd0,s4[54:42],1'b0};
        assign ds_result1 = s59 ? {s42[(DS_DOUT_MSB - 1):0],1'b0} : !s53 ? {DS_DOUT_WIDTH{1'b0}} : {2'd0,s5[54:42],1'b0};
    end
    else if (FLEN == 32) begin:gen_fpu_dsu_sp
        assign s48 = {1'b0,s47};
        assign s27 = {s25[28:1],29'b0};
        assign s28 = {s26[28:3],29'b0};
        assign s1 = {s0[24:1],29'b0};
        assign s4 = {s2,29'b0};
        assign s5 = {s3,29'b0};
        assign s31 = s29[55:29];
        assign s32 = s30[55:29];
        assign ds_result0 = s59 ? s41[DS_DOUT_MSB:0] : !s53 ? {DS_DOUT_WIDTH{1'b0}} : (s46 == 2'b10) ? {15'd0,s4[54:42],1'b0} : {2'd0,s4[54:29],1'b0};
        assign ds_result1 = s59 ? {s42[(DS_DOUT_MSB - 1):0],1'b0} : !s53 ? {DS_DOUT_WIDTH{1'b0}} : (s46 == 2'b10) ? {15'd0,s5[54:42],1'b0} : {2'd0,s5[54:29],1'b0};
    end
    else begin:gen_fpu_dsu_dp
        assign s48 = s47;
        assign s27 = s25[57:1];
        assign s28 = s26[57:3];
        assign s1 = s0[53:1];
        assign s4 = s2;
        assign s5 = s3;
        assign s31 = s29;
        assign s32 = s30;
        assign ds_result0 = s59 ? s41[DS_DOUT_MSB:0] : !s53 ? {DS_DOUT_WIDTH{1'b0}} : (s46 == 2'b10) ? {44'd0,s4[54:42],1'b0} : (s46 == 2'b01) ? {31'd0,s4[54:29],1'b0} : {2'd0,s4[54:0],1'b0};
        assign ds_result1 = s59 ? {s42[(DS_DOUT_MSB - 1):0],1'b0} : !s53 ? {DS_DOUT_WIDTH{1'b0}} : (s46 == 2'b10) ? {44'd0,s5[54:42],1'b0} : (s46 == 2'b01) ? {31'd0,s5[54:29],1'b0} : {2'd0,s5[54:0],1'b0};
    end
endgenerate
endmodule

