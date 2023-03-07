// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_eccdec64 (
    check_en,
    correct_1bit,
    data,
    dataout,
    ded,
    error,
    invalidate,
    parin,
    parout,
    replay,
    report_1bit,
    report_2bit,
    sec,
    xcpt
);
input check_en;
input correct_1bit;
input [63:0] data;
output [63:0] dataout;
output ded;
output error;
output invalidate;
input [7:0] parin;
output [7:0] parout;
output replay;
input report_1bit;
input report_2bit;
output sec;
output xcpt;


reg s0;
reg s1;
reg s2;
reg s3;
reg s4;
reg [7:0] s5;
reg [63:0] s6;
wire [7:0] s7;
assign s7[0] = parin[0] ^ data[63] ^ data[61] ^ data[59] ^ data[57] ^ data[56] ^ data[54] ^ data[52] ^ data[50] ^ data[48] ^ data[46] ^ data[44] ^ data[42] ^ data[40] ^ data[38] ^ data[36] ^ data[34] ^ data[32] ^ data[30] ^ data[28] ^ data[26] ^ data[25] ^ data[23] ^ data[21] ^ data[19] ^ data[17] ^ data[15] ^ data[13] ^ data[11] ^ data[10] ^ data[8] ^ data[6] ^ data[4] ^ data[3] ^ data[1] ^ data[0];
assign s7[1] = parin[1] ^ data[63] ^ data[62] ^ data[59] ^ data[58] ^ data[56] ^ data[55] ^ data[52] ^ data[51] ^ data[48] ^ data[47] ^ data[44] ^ data[43] ^ data[40] ^ data[39] ^ data[36] ^ data[35] ^ data[32] ^ data[31] ^ data[28] ^ data[27] ^ data[25] ^ data[24] ^ data[21] ^ data[20] ^ data[17] ^ data[16] ^ data[13] ^ data[12] ^ data[10] ^ data[9] ^ data[6] ^ data[5] ^ data[3] ^ data[2] ^ data[0];
assign s7[2] = parin[2] ^ data[63] ^ data[62] ^ data[61] ^ data[60] ^ data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[48] ^ data[47] ^ data[46] ^ data[45] ^ data[40] ^ data[39] ^ data[38] ^ data[37] ^ data[32] ^ data[31] ^ data[30] ^ data[29] ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[17] ^ data[16] ^ data[15] ^ data[14] ^ data[10] ^ data[9] ^ data[8] ^ data[7] ^ data[3] ^ data[2] ^ data[1];
assign s7[3] = parin[3] ^ data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[52] ^ data[51] ^ data[50] ^ data[49] ^ data[40] ^ data[39] ^ data[38] ^ data[37] ^ data[36] ^ data[35] ^ data[34] ^ data[33] ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[10] ^ data[9] ^ data[8] ^ data[7] ^ data[6] ^ data[5] ^ data[4];
assign s7[4] = parin[4] ^ data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[52] ^ data[51] ^ data[50] ^ data[49] ^ data[48] ^ data[47] ^ data[46] ^ data[45] ^ data[44] ^ data[43] ^ data[42] ^ data[41] ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[17] ^ data[16] ^ data[15] ^ data[14] ^ data[13] ^ data[12] ^ data[11];
assign s7[5] = parin[5] ^ data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[52] ^ data[51] ^ data[50] ^ data[49] ^ data[48] ^ data[47] ^ data[46] ^ data[45] ^ data[44] ^ data[43] ^ data[42] ^ data[41] ^ data[40] ^ data[39] ^ data[38] ^ data[37] ^ data[36] ^ data[35] ^ data[34] ^ data[33] ^ data[32] ^ data[31] ^ data[30] ^ data[29] ^ data[28] ^ data[27] ^ data[26];
assign s7[6] = parin[6] ^ data[63] ^ data[62] ^ data[61] ^ data[60] ^ data[59] ^ data[58] ^ data[57];
assign s7[7] = parin[7] ^ data[63] ^ data[60] ^ data[58] ^ data[57] ^ data[56] ^ data[53] ^ data[51] ^ data[50] ^ data[47] ^ data[46] ^ data[44] ^ data[41] ^ data[39] ^ data[38] ^ data[36] ^ data[33] ^ data[32] ^ data[29] ^ data[27] ^ data[26] ^ data[24] ^ data[23] ^ data[21] ^ data[18] ^ data[17] ^ data[14] ^ data[12] ^ data[11] ^ data[10] ^ data[7] ^ data[5] ^ data[4] ^ data[2] ^ data[1] ^ data[0];
assign error = |s7 & check_en;
always @* begin
    s5[7:0] = 8'b0;
    s6[63:0] = 64'b0;
    s4 = 1'b0;
    s2 = 1'b0;
    s0 = 1'b0;
    s3 = 1'b0;
    s1 = 1'b0;
    case (s7)
        8'b00000000: ;
        8'b00000001: begin
            s5[0] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00000010: begin
            s5[1] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00000100: begin
            s5[2] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00001000: begin
            s5[3] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00010000: begin
            s5[4] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00100000: begin
            s5[5] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b01000000: begin
            s5[6] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10000000: begin
            s5[7] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10000011: begin
            s6[0] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10000101: begin
            s6[1] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10000110: begin
            s6[2] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00000111: begin
            s6[3] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10001001: begin
            s6[4] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10001010: begin
            s6[5] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00001011: begin
            s6[6] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10001100: begin
            s6[7] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00001101: begin
            s6[8] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00001110: begin
            s6[9] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10001111: begin
            s6[10] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10010001: begin
            s6[11] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10010010: begin
            s6[12] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00010011: begin
            s6[13] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10010100: begin
            s6[14] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00010101: begin
            s6[15] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00010110: begin
            s6[16] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10010111: begin
            s6[17] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10011000: begin
            s6[18] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00011001: begin
            s6[19] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00011010: begin
            s6[20] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10011011: begin
            s6[21] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00011100: begin
            s6[22] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10011101: begin
            s6[23] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10011110: begin
            s6[24] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00011111: begin
            s6[25] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10100001: begin
            s6[26] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10100010: begin
            s6[27] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00100011: begin
            s6[28] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10100100: begin
            s6[29] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00100101: begin
            s6[30] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00100110: begin
            s6[31] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10100111: begin
            s6[32] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10101000: begin
            s6[33] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00101001: begin
            s6[34] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00101010: begin
            s6[35] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10101011: begin
            s6[36] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00101100: begin
            s6[37] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10101101: begin
            s6[38] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10101110: begin
            s6[39] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00101111: begin
            s6[40] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10110000: begin
            s6[41] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00110001: begin
            s6[42] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00110010: begin
            s6[43] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10110011: begin
            s6[44] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00110100: begin
            s6[45] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10110101: begin
            s6[46] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10110110: begin
            s6[47] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00110111: begin
            s6[48] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00111000: begin
            s6[49] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10111001: begin
            s6[50] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10111010: begin
            s6[51] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00111011: begin
            s6[52] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10111100: begin
            s6[53] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00111101: begin
            s6[54] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b00111110: begin
            s6[55] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b10111111: begin
            s6[56] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b11000001: begin
            s6[57] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b11000010: begin
            s6[58] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b01000011: begin
            s6[59] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b11000100: begin
            s6[60] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b01000101: begin
            s6[61] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b01000110: begin
            s6[62] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        8'b11000111: begin
            s6[63] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        default: begin
            s4 = check_en & (report_1bit | report_2bit);
            s0 = check_en & report_2bit;
            s2 = check_en & ~(report_1bit | report_2bit);
            s3 = check_en & ~report_2bit;
            s1 = check_en & ~report_2bit;
        end
    endcase
end

assign dataout = data ^ s6;
assign parout = parin ^ s5;
assign sec = s3;
assign ded = s0;
assign invalidate = s1;
assign xcpt = s4;
assign replay = s2;
endmodule

