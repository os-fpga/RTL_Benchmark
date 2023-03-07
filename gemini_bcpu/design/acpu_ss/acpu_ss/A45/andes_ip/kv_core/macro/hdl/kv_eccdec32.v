// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_eccdec32 (
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
input [31:0] data;
output [31:0] dataout;
output ded;
output error;
output invalidate;
input [6:0] parin;
output [6:0] parout;
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
reg [6:0] s5;
reg [31:0] s6;
wire [6:0] s7;
assign s7[0] = parin[0] ^ data[30] ^ data[28] ^ data[26] ^ data[25] ^ data[23] ^ data[21] ^ data[19] ^ data[17] ^ data[15] ^ data[13] ^ data[11] ^ data[10] ^ data[8] ^ data[6] ^ data[4] ^ data[3] ^ data[1] ^ data[0];
assign s7[1] = parin[1] ^ data[31] ^ data[28] ^ data[27] ^ data[25] ^ data[24] ^ data[21] ^ data[20] ^ data[17] ^ data[16] ^ data[13] ^ data[12] ^ data[10] ^ data[9] ^ data[6] ^ data[5] ^ data[3] ^ data[2] ^ data[0];
assign s7[2] = parin[2] ^ data[31] ^ data[30] ^ data[29] ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[17] ^ data[16] ^ data[15] ^ data[14] ^ data[10] ^ data[9] ^ data[8] ^ data[7] ^ data[3] ^ data[2] ^ data[1];
assign s7[3] = parin[3] ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[10] ^ data[9] ^ data[8] ^ data[7] ^ data[6] ^ data[5] ^ data[4];
assign s7[4] = parin[4] ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[17] ^ data[16] ^ data[15] ^ data[14] ^ data[13] ^ data[12] ^ data[11];
assign s7[5] = parin[5] ^ data[31] ^ data[30] ^ data[29] ^ data[28] ^ data[27] ^ data[26];
assign s7[6] = parin[6] ^ data[29] ^ data[27] ^ data[26] ^ data[24] ^ data[23] ^ data[21] ^ data[18] ^ data[17] ^ data[14] ^ data[12] ^ data[11] ^ data[10] ^ data[7] ^ data[5] ^ data[4] ^ data[2] ^ data[1] ^ data[0];
assign error = |s7 & check_en;
always @* begin
    s5[6:0] = 7'b0;
    s6[31:0] = 32'b0;
    s4 = 1'b0;
    s2 = 1'b0;
    s0 = 1'b0;
    s3 = 1'b0;
    s1 = 1'b0;
    case (s7)
        7'b0000000: ;
        7'b0000001: begin
            s5[0] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0000010: begin
            s5[1] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0000100: begin
            s5[2] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0001000: begin
            s5[3] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0010000: begin
            s5[4] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0100000: begin
            s5[5] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1000000: begin
            s5[6] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1000011: begin
            s6[0] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1000101: begin
            s6[1] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1000110: begin
            s6[2] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0000111: begin
            s6[3] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1001001: begin
            s6[4] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1001010: begin
            s6[5] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0001011: begin
            s6[6] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1001100: begin
            s6[7] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0001101: begin
            s6[8] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0001110: begin
            s6[9] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1001111: begin
            s6[10] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1010001: begin
            s6[11] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1010010: begin
            s6[12] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0010011: begin
            s6[13] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1010100: begin
            s6[14] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0010101: begin
            s6[15] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0010110: begin
            s6[16] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1010111: begin
            s6[17] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1011000: begin
            s6[18] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0011001: begin
            s6[19] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0011010: begin
            s6[20] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1011011: begin
            s6[21] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0011100: begin
            s6[22] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1011101: begin
            s6[23] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1011110: begin
            s6[24] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0011111: begin
            s6[25] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1100001: begin
            s6[26] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1100010: begin
            s6[27] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0100011: begin
            s6[28] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b1100100: begin
            s6[29] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0100101: begin
            s6[30] = check_en;
            s3 = check_en;
            s4 = report_1bit;
            s2 = correct_1bit;
        end
        7'b0100110: begin
            s6[31] = check_en;
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

