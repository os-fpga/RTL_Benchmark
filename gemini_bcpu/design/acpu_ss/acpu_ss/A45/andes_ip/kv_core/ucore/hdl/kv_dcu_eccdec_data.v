// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_eccdec_data (
    check_en,
    data0_codeword,
    data1_codeword,
    data2_codeword,
    data3_codeword,
    data0_corrdata,
    data1_corrdata,
    data2_corrdata,
    data3_corrdata,
    data0_error,
    data1_error,
    data2_error,
    data3_error
);
parameter DATA_RAM_CW = 32;
input check_en;
input [DATA_RAM_CW - 1:0] data0_codeword;
input [DATA_RAM_CW - 1:0] data1_codeword;
input [DATA_RAM_CW - 1:0] data2_codeword;
input [DATA_RAM_CW - 1:0] data3_codeword;
output [31:0] data0_corrdata;
output [31:0] data1_corrdata;
output [31:0] data2_corrdata;
output [31:0] data3_corrdata;
output [1:0] data0_error;
output [1:0] data1_error;
output [1:0] data2_error;
output [1:0] data3_error;


wire [6:0] nds_unused_0_parout;
wire nds_unused_0_error;
wire nds_unused_0_replay;
wire nds_unused_0_invalidate;
wire nds_unused_0_xcpt;
kv_eccdec32 u_eccdec0(
    .data(data0_codeword[31:0]),
    .parin(data0_codeword[38:32]),
    .check_en(check_en),
    .correct_1bit(1'b0),
    .report_1bit(1'b0),
    .report_2bit(1'b1),
    .dataout(data0_corrdata),
    .parout(nds_unused_0_parout),
    .sec(data0_error[0]),
    .ded(data0_error[1]),
    .error(nds_unused_0_error),
    .invalidate(nds_unused_0_invalidate),
    .replay(nds_unused_0_replay),
    .xcpt(nds_unused_0_xcpt)
);
wire [6:0] nds_unused_1_parout;
wire nds_unused_1_error;
wire nds_unused_1_replay;
wire nds_unused_1_invalidate;
wire nds_unused_1_xcpt;
kv_eccdec32 u_eccdec1(
    .data(data1_codeword[31:0]),
    .parin(data1_codeword[38:32]),
    .check_en(check_en),
    .correct_1bit(1'b0),
    .report_1bit(1'b0),
    .report_2bit(1'b1),
    .dataout(data1_corrdata),
    .parout(nds_unused_1_parout),
    .sec(data1_error[0]),
    .ded(data1_error[1]),
    .error(nds_unused_1_error),
    .invalidate(nds_unused_1_invalidate),
    .replay(nds_unused_1_replay),
    .xcpt(nds_unused_1_xcpt)
);
wire [6:0] nds_unused_2_parout;
wire nds_unused_2_error;
wire nds_unused_2_replay;
wire nds_unused_2_invalidate;
wire nds_unused_2_xcpt;
kv_eccdec32 u_eccdec2(
    .data(data2_codeword[31:0]),
    .parin(data2_codeword[38:32]),
    .check_en(check_en),
    .correct_1bit(1'b0),
    .report_1bit(1'b0),
    .report_2bit(1'b1),
    .dataout(data2_corrdata),
    .parout(nds_unused_2_parout),
    .sec(data2_error[0]),
    .ded(data2_error[1]),
    .error(nds_unused_2_error),
    .invalidate(nds_unused_2_invalidate),
    .replay(nds_unused_2_replay),
    .xcpt(nds_unused_2_xcpt)
);
wire [6:0] nds_unused_3_parout;
wire nds_unused_3_error;
wire nds_unused_3_replay;
wire nds_unused_3_invalidate;
wire nds_unused_3_xcpt;
kv_eccdec32 u_eccdec3(
    .data(data3_codeword[31:0]),
    .parin(data3_codeword[38:32]),
    .check_en(check_en),
    .correct_1bit(1'b0),
    .report_1bit(1'b0),
    .report_2bit(1'b1),
    .dataout(data3_corrdata),
    .parout(nds_unused_3_parout),
    .sec(data3_error[0]),
    .ded(data3_error[1]),
    .error(nds_unused_3_error),
    .invalidate(nds_unused_3_invalidate),
    .replay(nds_unused_3_replay),
    .xcpt(nds_unused_3_xcpt)
);
endmodule

