// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_rf (
    core_clk,
    core_reset_n,
    rf_init,
    rf_sdw_recover,
    rf_raddr1,
    rf_rdata1,
    rf_raddr2,
    rf_rdata2,
    rf_raddr3,
    rf_rdata3,
    rf_raddr4,
    rf_rdata4,
    rf_raddr5,
    rf_rdata5,
    rf_we1,
    rf_waddr1,
    rf_wdata1,
    rf_wstatus1,
    rf_we2,
    rf_waddr2,
    rf_wdata2,
    rf_wstatus2,
    rf_we3,
    rf_waddr3,
    rf_wdata3,
    rf_wstatus3
);
localparam SDW_GPRNUM = 4;
input core_clk;
input core_reset_n;
input rf_init;
input rf_sdw_recover;
input [4:0] rf_raddr1;
output [31:0] rf_rdata1;
input [4:0] rf_raddr2;
output [31:0] rf_rdata2;
input [4:0] rf_raddr3;
output [31:0] rf_rdata3;
input [4:0] rf_raddr4;
output [31:0] rf_rdata4;
input [4:0] rf_raddr5;
output [31:0] rf_rdata5;
input rf_we1;
input [4:0] rf_waddr1;
input [31:0] rf_wdata1;
input [1:0] rf_wstatus1;
input rf_we2;
input [4:0] rf_waddr2;
input [31:0] rf_wdata2;
input [1:0] rf_wstatus2;
input rf_we3;
input [4:0] rf_waddr3;
input [31:0] rf_wdata3;
input rf_wstatus3;


wire [31:1] rf_we_onehot;
wire [SDW_GPRNUM + 4:5] rf_sdw_en;
wire [SDW_GPRNUM + 4:5] rf_sdw_valid_set;
wire [SDW_GPRNUM + 4:5] rf_sdw_valid_nx;
reg [SDW_GPRNUM + 4:5] rf_sdw_valid;
wire [31:1] rf_we1_onehot;
wire [31:1] rf_we2_onehot;
wire [31:1] rf_we3_onehot;
wire [31:1] rf_sdw_recover_we;
assign rf_sdw_recover_we[1] = 1'b0;
assign rf_we1_onehot[1] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd1);
assign rf_we2_onehot[1] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd1);
assign rf_we3_onehot[1] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd1);
assign rf_sdw_recover_we[2] = 1'b0;
assign rf_we1_onehot[2] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd2);
assign rf_we2_onehot[2] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd2);
assign rf_we3_onehot[2] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd2);
assign rf_sdw_recover_we[3] = 1'b0;
assign rf_we1_onehot[3] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd3);
assign rf_we2_onehot[3] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd3);
assign rf_we3_onehot[3] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd3);
assign rf_sdw_recover_we[4] = 1'b0;
assign rf_we1_onehot[4] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd4);
assign rf_we2_onehot[4] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd4);
assign rf_we3_onehot[4] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd4);
assign rf_sdw_valid_set[5] = rf_wstatus1[1] & (rf_waddr1 == 5'd5) & rf_we1 | rf_wstatus2[1] & (rf_waddr2 == 5'd5) & rf_we2;
assign rf_sdw_valid_nx[5] = rf_sdw_recover ? 1'b0 : rf_sdw_valid_set[5] ? 1'b1 : (rf_sdw_valid[5]);
assign rf_sdw_en[5] = rf_sdw_valid_set[5] & ~rf_sdw_valid[5];
assign rf_sdw_recover_we[5] = rf_sdw_recover & rf_sdw_valid[5];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        rf_sdw_valid[5] <= 1'b0;
    end
    else begin
        rf_sdw_valid[5] <= rf_sdw_valid_nx[5];
    end
end

assign rf_we1_onehot[5] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd5);
assign rf_we2_onehot[5] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd5);
assign rf_we3_onehot[5] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd5);
assign rf_sdw_valid_set[6] = rf_wstatus1[1] & (rf_waddr1 == 5'd6) & rf_we1 | rf_wstatus2[1] & (rf_waddr2 == 5'd6) & rf_we2;
assign rf_sdw_valid_nx[6] = rf_sdw_recover ? 1'b0 : rf_sdw_valid_set[6] ? 1'b1 : (rf_sdw_valid[6]);
assign rf_sdw_en[6] = rf_sdw_valid_set[6] & ~rf_sdw_valid[6];
assign rf_sdw_recover_we[6] = rf_sdw_recover & rf_sdw_valid[6];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        rf_sdw_valid[6] <= 1'b0;
    end
    else begin
        rf_sdw_valid[6] <= rf_sdw_valid_nx[6];
    end
end

assign rf_we1_onehot[6] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd6);
assign rf_we2_onehot[6] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd6);
assign rf_we3_onehot[6] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd6);
assign rf_sdw_valid_set[7] = rf_wstatus1[1] & (rf_waddr1 == 5'd7) & rf_we1 | rf_wstatus2[1] & (rf_waddr2 == 5'd7) & rf_we2;
assign rf_sdw_valid_nx[7] = rf_sdw_recover ? 1'b0 : rf_sdw_valid_set[7] ? 1'b1 : (rf_sdw_valid[7]);
assign rf_sdw_en[7] = rf_sdw_valid_set[7] & ~rf_sdw_valid[7];
assign rf_sdw_recover_we[7] = rf_sdw_recover & rf_sdw_valid[7];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        rf_sdw_valid[7] <= 1'b0;
    end
    else begin
        rf_sdw_valid[7] <= rf_sdw_valid_nx[7];
    end
end

assign rf_we1_onehot[7] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd7);
assign rf_we2_onehot[7] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd7);
assign rf_we3_onehot[7] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd7);
assign rf_sdw_valid_set[8] = rf_wstatus1[1] & (rf_waddr1 == 5'd8) & rf_we1 | rf_wstatus2[1] & (rf_waddr2 == 5'd8) & rf_we2;
assign rf_sdw_valid_nx[8] = rf_sdw_recover ? 1'b0 : rf_sdw_valid_set[8] ? 1'b1 : (rf_sdw_valid[8]);
assign rf_sdw_en[8] = rf_sdw_valid_set[8] & ~rf_sdw_valid[8];
assign rf_sdw_recover_we[8] = rf_sdw_recover & rf_sdw_valid[8];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        rf_sdw_valid[8] <= 1'b0;
    end
    else begin
        rf_sdw_valid[8] <= rf_sdw_valid_nx[8];
    end
end

assign rf_we1_onehot[8] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd8);
assign rf_we2_onehot[8] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd8);
assign rf_we3_onehot[8] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd8);
assign rf_sdw_recover_we[9] = 1'b0;
assign rf_we1_onehot[9] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd9);
assign rf_we2_onehot[9] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd9);
assign rf_we3_onehot[9] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd9);
assign rf_sdw_recover_we[10] = 1'b0;
assign rf_we1_onehot[10] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd10);
assign rf_we2_onehot[10] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd10);
assign rf_we3_onehot[10] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd10);
assign rf_sdw_recover_we[11] = 1'b0;
assign rf_we1_onehot[11] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd11);
assign rf_we2_onehot[11] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd11);
assign rf_we3_onehot[11] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd11);
assign rf_sdw_recover_we[12] = 1'b0;
assign rf_we1_onehot[12] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd12);
assign rf_we2_onehot[12] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd12);
assign rf_we3_onehot[12] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd12);
assign rf_sdw_recover_we[13] = 1'b0;
assign rf_we1_onehot[13] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd13);
assign rf_we2_onehot[13] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd13);
assign rf_we3_onehot[13] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd13);
assign rf_sdw_recover_we[14] = 1'b0;
assign rf_we1_onehot[14] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd14);
assign rf_we2_onehot[14] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd14);
assign rf_we3_onehot[14] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd14);
assign rf_sdw_recover_we[15] = 1'b0;
assign rf_we1_onehot[15] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd15);
assign rf_we2_onehot[15] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd15);
assign rf_we3_onehot[15] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd15);
assign rf_sdw_recover_we[16] = 1'b0;
assign rf_we1_onehot[16] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd16);
assign rf_we2_onehot[16] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd16);
assign rf_we3_onehot[16] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd16);
assign rf_sdw_recover_we[17] = 1'b0;
assign rf_we1_onehot[17] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd17);
assign rf_we2_onehot[17] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd17);
assign rf_we3_onehot[17] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd17);
assign rf_sdw_recover_we[18] = 1'b0;
assign rf_we1_onehot[18] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd18);
assign rf_we2_onehot[18] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd18);
assign rf_we3_onehot[18] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd18);
assign rf_sdw_recover_we[19] = 1'b0;
assign rf_we1_onehot[19] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd19);
assign rf_we2_onehot[19] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd19);
assign rf_we3_onehot[19] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd19);
assign rf_sdw_recover_we[20] = 1'b0;
assign rf_we1_onehot[20] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd20);
assign rf_we2_onehot[20] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd20);
assign rf_we3_onehot[20] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd20);
assign rf_sdw_recover_we[21] = 1'b0;
assign rf_we1_onehot[21] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd21);
assign rf_we2_onehot[21] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd21);
assign rf_we3_onehot[21] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd21);
assign rf_sdw_recover_we[22] = 1'b0;
assign rf_we1_onehot[22] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd22);
assign rf_we2_onehot[22] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd22);
assign rf_we3_onehot[22] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd22);
assign rf_sdw_recover_we[23] = 1'b0;
assign rf_we1_onehot[23] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd23);
assign rf_we2_onehot[23] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd23);
assign rf_we3_onehot[23] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd23);
assign rf_sdw_recover_we[24] = 1'b0;
assign rf_we1_onehot[24] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd24);
assign rf_we2_onehot[24] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd24);
assign rf_we3_onehot[24] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd24);
assign rf_sdw_recover_we[25] = 1'b0;
assign rf_we1_onehot[25] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd25);
assign rf_we2_onehot[25] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd25);
assign rf_we3_onehot[25] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd25);
assign rf_sdw_recover_we[26] = 1'b0;
assign rf_we1_onehot[26] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd26);
assign rf_we2_onehot[26] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd26);
assign rf_we3_onehot[26] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd26);
assign rf_sdw_recover_we[27] = 1'b0;
assign rf_we1_onehot[27] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd27);
assign rf_we2_onehot[27] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd27);
assign rf_we3_onehot[27] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd27);
assign rf_sdw_recover_we[28] = 1'b0;
assign rf_we1_onehot[28] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd28);
assign rf_we2_onehot[28] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd28);
assign rf_we3_onehot[28] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd28);
assign rf_sdw_recover_we[29] = 1'b0;
assign rf_we1_onehot[29] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd29);
assign rf_we2_onehot[29] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd29);
assign rf_we3_onehot[29] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd29);
assign rf_sdw_recover_we[30] = 1'b0;
assign rf_we1_onehot[30] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd30);
assign rf_we2_onehot[30] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd30);
assign rf_we3_onehot[30] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd30);
assign rf_sdw_recover_we[31] = 1'b0;
assign rf_we1_onehot[31] = rf_we1 & ~rf_wstatus1[0] & (rf_waddr1 == 5'd31);
assign rf_we2_onehot[31] = rf_we2 & ~rf_wstatus2[0] & (rf_waddr2 == 5'd31);
assign rf_we3_onehot[31] = rf_we3 & ~rf_wstatus3 & (rf_waddr3 == 5'd31);
wire [31:0] gpr_x01_ra;
wire [31:0] gpr_x02_sp;
wire [31:0] gpr_x03_gp;
wire [31:0] gpr_x04_tp;
wire [31:0] gpr_x05_t0;
wire [31:0] gpr_x06_t1;
wire [31:0] gpr_x07_t2;
wire [31:0] gpr_x08_s0;
wire [31:0] gpr_x09_s1;
wire [31:0] gpr_x10_a0;
wire [31:0] gpr_x11_a1;
wire [31:0] gpr_x12_a2;
wire [31:0] gpr_x13_a3;
wire [31:0] gpr_x14_a4;
wire [31:0] gpr_x15_a5;
wire [31:0] gpr_x16_a6;
wire [31:0] gpr_x17_a7;
wire [31:0] gpr_x18_s2;
wire [31:0] gpr_x19_s3;
wire [31:0] gpr_x20_s4;
wire [31:0] gpr_x21_s5;
wire [31:0] gpr_x22_s6;
wire [31:0] gpr_x23_s7;
wire [31:0] gpr_x24_s8;
wire [31:0] gpr_x25_s9;
wire [31:0] gpr_x26_s10;
wire [31:0] gpr_x27_s11;
wire [31:0] gpr_x28_t3;
wire [31:0] gpr_x29_t4;
wire [31:0] gpr_x30_t5;
wire [31:0] gpr_x31_t6;
reg [31:0] x01;
wire [31:0] x01_nx = ({32{rf_we1_onehot[1]}} & rf_wdata1) | ({32{rf_we2_onehot[1]}} & rf_wdata2) | ({32{rf_we3_onehot[1]}} & rf_wdata3);
always @(posedge core_clk) begin
    if (rf_we_onehot[1]) begin
        x01 <= x01_nx;
    end
end

assign gpr_x01_ra = x01;
reg [31:0] x02;
wire [31:0] x02_nx = ({32{rf_we1_onehot[2]}} & rf_wdata1) | ({32{rf_we2_onehot[2]}} & rf_wdata2) | ({32{rf_we3_onehot[2]}} & rf_wdata3);
always @(posedge core_clk) begin
    if (rf_we_onehot[2]) begin
        x02 <= x02_nx;
    end
end

assign gpr_x02_sp = x02;
reg [31:0] x03;
wire [31:0] x03_nx = ({32{rf_we1_onehot[3]}} & rf_wdata1) | ({32{rf_we2_onehot[3]}} & rf_wdata2) | ({32{rf_we3_onehot[3]}} & rf_wdata3);
always @(posedge core_clk) begin
    if (rf_we_onehot[3]) begin
        x03 <= x03_nx;
    end
end

assign gpr_x03_gp = x03;
reg [31:0] x04;
wire [31:0] x04_nx = ({32{rf_we1_onehot[4]}} & rf_wdata1) | ({32{rf_we2_onehot[4]}} & rf_wdata2) | ({32{rf_we3_onehot[4]}} & rf_wdata3);
always @(posedge core_clk) begin
    if (rf_we_onehot[4]) begin
        x04 <= x04_nx;
    end
end

assign gpr_x04_tp = x04;
reg [31:0] sdw_x05;
reg [31:0] x05;
wire [31:0] x05_nx = ({32{rf_we1_onehot[5]}} & rf_wdata1) | ({32{rf_we2_onehot[5]}} & rf_wdata2) | ({32{rf_we3_onehot[5]}} & rf_wdata3) | ({32{rf_sdw_recover_we[5]}} & sdw_x05);
always @(posedge core_clk) begin
    if (rf_sdw_en[5]) begin
        sdw_x05 <= x05;
    end
end

always @(posedge core_clk) begin
    if (rf_we_onehot[5]) begin
        x05 <= x05_nx;
    end
end

assign gpr_x05_t0 = x05;
reg [31:0] sdw_x06;
reg [31:0] x06;
wire [31:0] x06_nx = ({32{rf_we1_onehot[6]}} & rf_wdata1) | ({32{rf_we2_onehot[6]}} & rf_wdata2) | ({32{rf_we3_onehot[6]}} & rf_wdata3) | ({32{rf_sdw_recover_we[6]}} & sdw_x06);
always @(posedge core_clk) begin
    if (rf_sdw_en[6]) begin
        sdw_x06 <= x06;
    end
end

always @(posedge core_clk) begin
    if (rf_we_onehot[6]) begin
        x06 <= x06_nx;
    end
end

assign gpr_x06_t1 = x06;
reg [31:0] sdw_x07;
reg [31:0] x07;
wire [31:0] x07_nx = ({32{rf_we1_onehot[7]}} & rf_wdata1) | ({32{rf_we2_onehot[7]}} & rf_wdata2) | ({32{rf_we3_onehot[7]}} & rf_wdata3) | ({32{rf_sdw_recover_we[7]}} & sdw_x07);
always @(posedge core_clk) begin
    if (rf_sdw_en[7]) begin
        sdw_x07 <= x07;
    end
end

always @(posedge core_clk) begin
    if (rf_we_onehot[7]) begin
        x07 <= x07_nx;
    end
end

assign gpr_x07_t2 = x07;
reg [31:0] sdw_x08;
reg [31:0] x08;
wire [31:0] x08_nx = ({32{rf_we1_onehot[8]}} & rf_wdata1) | ({32{rf_we2_onehot[8]}} & rf_wdata2) | ({32{rf_we3_onehot[8]}} & rf_wdata3) | ({32{rf_sdw_recover_we[8]}} & sdw_x08);
always @(posedge core_clk) begin
    if (rf_sdw_en[8]) begin
        sdw_x08 <= x08;
    end
end

always @(posedge core_clk) begin
    if (rf_we_onehot[8]) begin
        x08 <= x08_nx;
    end
end

assign gpr_x08_s0 = x08;
reg [31:0] x09;
wire [31:0] x09_nx = ({32{rf_we1_onehot[9]}} & rf_wdata1) | ({32{rf_we2_onehot[9]}} & rf_wdata2) | ({32{rf_we3_onehot[9]}} & rf_wdata3);
always @(posedge core_clk) begin
    if (rf_we_onehot[9]) begin
        x09 <= x09_nx;
    end
end

assign gpr_x09_s1 = x09;
reg [31:0] x10;
wire [31:0] x10_nx = ({32{rf_we1_onehot[10]}} & rf_wdata1) | ({32{rf_we2_onehot[10]}} & rf_wdata2) | ({32{rf_we3_onehot[10]}} & rf_wdata3);
always @(posedge core_clk) begin
    if (rf_we_onehot[10]) begin
        x10 <= x10_nx;
    end
end

assign gpr_x10_a0 = x10;
reg [31:0] x11;
wire [31:0] x11_nx = ({32{rf_we1_onehot[11]}} & rf_wdata1) | ({32{rf_we2_onehot[11]}} & rf_wdata2) | ({32{rf_we3_onehot[11]}} & rf_wdata3);
always @(posedge core_clk) begin
    if (rf_we_onehot[11]) begin
        x11 <= x11_nx;
    end
end

assign gpr_x11_a1 = x11;
reg [31:0] x12;
wire [31:0] x12_nx = ({32{rf_we1_onehot[12]}} & rf_wdata1) | ({32{rf_we2_onehot[12]}} & rf_wdata2) | ({32{rf_we3_onehot[12]}} & rf_wdata3);
always @(posedge core_clk) begin
    if (rf_we_onehot[12]) begin
        x12 <= x12_nx;
    end
end

assign gpr_x12_a2 = x12;
reg [31:0] x13;
wire [31:0] x13_nx = ({32{rf_we1_onehot[13]}} & rf_wdata1) | ({32{rf_we2_onehot[13]}} & rf_wdata2) | ({32{rf_we3_onehot[13]}} & rf_wdata3);
always @(posedge core_clk) begin
    if (rf_we_onehot[13]) begin
        x13 <= x13_nx;
    end
end

assign gpr_x13_a3 = x13;
reg [31:0] x14;
wire [31:0] x14_nx = ({32{rf_we1_onehot[14]}} & rf_wdata1) | ({32{rf_we2_onehot[14]}} & rf_wdata2) | ({32{rf_we3_onehot[14]}} & rf_wdata3);
always @(posedge core_clk) begin
    if (rf_we_onehot[14]) begin
        x14 <= x14_nx;
    end
end

assign gpr_x14_a4 = x14;
reg [31:0] x15;
wire [31:0] x15_nx = ({32{rf_we1_onehot[15]}} & rf_wdata1) | ({32{rf_we2_onehot[15]}} & rf_wdata2) | ({32{rf_we3_onehot[15]}} & rf_wdata3);
always @(posedge core_clk) begin
    if (rf_we_onehot[15]) begin
        x15 <= x15_nx;
    end
end

assign gpr_x15_a5 = x15;
generate
    reg [31:0] x16;
    wire [31:0] x16_nx = ({32{rf_we1_onehot[16]}} & rf_wdata1) | ({32{rf_we2_onehot[16]}} & rf_wdata2) | ({32{rf_we3_onehot[16]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[16]) begin
            x16 <= x16_nx;
        end
    end

    assign gpr_x16_a6 = x16;
    reg [31:0] x17;
    wire [31:0] x17_nx = ({32{rf_we1_onehot[17]}} & rf_wdata1) | ({32{rf_we2_onehot[17]}} & rf_wdata2) | ({32{rf_we3_onehot[17]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[17]) begin
            x17 <= x17_nx;
        end
    end

    assign gpr_x17_a7 = x17;
    reg [31:0] x18;
    wire [31:0] x18_nx = ({32{rf_we1_onehot[18]}} & rf_wdata1) | ({32{rf_we2_onehot[18]}} & rf_wdata2) | ({32{rf_we3_onehot[18]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[18]) begin
            x18 <= x18_nx;
        end
    end

    assign gpr_x18_s2 = x18;
    reg [31:0] x19;
    wire [31:0] x19_nx = ({32{rf_we1_onehot[19]}} & rf_wdata1) | ({32{rf_we2_onehot[19]}} & rf_wdata2) | ({32{rf_we3_onehot[19]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[19]) begin
            x19 <= x19_nx;
        end
    end

    assign gpr_x19_s3 = x19;
    reg [31:0] x20;
    wire [31:0] x20_nx = ({32{rf_we1_onehot[20]}} & rf_wdata1) | ({32{rf_we2_onehot[20]}} & rf_wdata2) | ({32{rf_we3_onehot[20]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[20]) begin
            x20 <= x20_nx;
        end
    end

    assign gpr_x20_s4 = x20;
    reg [31:0] x21;
    wire [31:0] x21_nx = ({32{rf_we1_onehot[21]}} & rf_wdata1) | ({32{rf_we2_onehot[21]}} & rf_wdata2) | ({32{rf_we3_onehot[21]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[21]) begin
            x21 <= x21_nx;
        end
    end

    assign gpr_x21_s5 = x21;
    reg [31:0] x22;
    wire [31:0] x22_nx = ({32{rf_we1_onehot[22]}} & rf_wdata1) | ({32{rf_we2_onehot[22]}} & rf_wdata2) | ({32{rf_we3_onehot[22]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[22]) begin
            x22 <= x22_nx;
        end
    end

    assign gpr_x22_s6 = x22;
    reg [31:0] x23;
    wire [31:0] x23_nx = ({32{rf_we1_onehot[23]}} & rf_wdata1) | ({32{rf_we2_onehot[23]}} & rf_wdata2) | ({32{rf_we3_onehot[23]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[23]) begin
            x23 <= x23_nx;
        end
    end

    assign gpr_x23_s7 = x23;
    reg [31:0] x24;
    wire [31:0] x24_nx = ({32{rf_we1_onehot[24]}} & rf_wdata1) | ({32{rf_we2_onehot[24]}} & rf_wdata2) | ({32{rf_we3_onehot[24]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[24]) begin
            x24 <= x24_nx;
        end
    end

    assign gpr_x24_s8 = x24;
    reg [31:0] x25;
    wire [31:0] x25_nx = ({32{rf_we1_onehot[25]}} & rf_wdata1) | ({32{rf_we2_onehot[25]}} & rf_wdata2) | ({32{rf_we3_onehot[25]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[25]) begin
            x25 <= x25_nx;
        end
    end

    assign gpr_x25_s9 = x25;
    reg [31:0] x26;
    wire [31:0] x26_nx = ({32{rf_we1_onehot[26]}} & rf_wdata1) | ({32{rf_we2_onehot[26]}} & rf_wdata2) | ({32{rf_we3_onehot[26]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[26]) begin
            x26 <= x26_nx;
        end
    end

    assign gpr_x26_s10 = x26;
    reg [31:0] x27;
    wire [31:0] x27_nx = ({32{rf_we1_onehot[27]}} & rf_wdata1) | ({32{rf_we2_onehot[27]}} & rf_wdata2) | ({32{rf_we3_onehot[27]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[27]) begin
            x27 <= x27_nx;
        end
    end

    assign gpr_x27_s11 = x27;
    reg [31:0] x28;
    wire [31:0] x28_nx = ({32{rf_we1_onehot[28]}} & rf_wdata1) | ({32{rf_we2_onehot[28]}} & rf_wdata2) | ({32{rf_we3_onehot[28]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[28]) begin
            x28 <= x28_nx;
        end
    end

    assign gpr_x28_t3 = x28;
    reg [31:0] x29;
    wire [31:0] x29_nx = ({32{rf_we1_onehot[29]}} & rf_wdata1) | ({32{rf_we2_onehot[29]}} & rf_wdata2) | ({32{rf_we3_onehot[29]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[29]) begin
            x29 <= x29_nx;
        end
    end

    assign gpr_x29_t4 = x29;
    reg [31:0] x30;
    wire [31:0] x30_nx = ({32{rf_we1_onehot[30]}} & rf_wdata1) | ({32{rf_we2_onehot[30]}} & rf_wdata2) | ({32{rf_we3_onehot[30]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[30]) begin
            x30 <= x30_nx;
        end
    end

    assign gpr_x30_t5 = x30;
    reg [31:0] x31;
    wire [31:0] x31_nx = ({32{rf_we1_onehot[31]}} & rf_wdata1) | ({32{rf_we2_onehot[31]}} & rf_wdata2) | ({32{rf_we3_onehot[31]}} & rf_wdata3);
    always @(posedge core_clk) begin
        if (rf_we_onehot[31]) begin
            x31 <= x31_nx;
        end
    end

    assign gpr_x31_t6 = x31;
endgenerate
reg [31:0] rf_rdata1;
reg [31:0] rf_rdata2;
reg [31:0] rf_rdata3;
reg [31:0] rf_rdata4;
reg [31:0] rf_rdata5;
always @* begin
    case (rf_raddr1)
        5'd0: rf_rdata1 = {32{1'b0}};
        5'd01: rf_rdata1 = gpr_x01_ra;
        5'd02: rf_rdata1 = gpr_x02_sp;
        5'd03: rf_rdata1 = gpr_x03_gp;
        5'd04: rf_rdata1 = gpr_x04_tp;
        5'd05: rf_rdata1 = gpr_x05_t0;
        5'd06: rf_rdata1 = gpr_x06_t1;
        5'd07: rf_rdata1 = gpr_x07_t2;
        5'd08: rf_rdata1 = gpr_x08_s0;
        5'd09: rf_rdata1 = gpr_x09_s1;
        5'd10: rf_rdata1 = gpr_x10_a0;
        5'd11: rf_rdata1 = gpr_x11_a1;
        5'd12: rf_rdata1 = gpr_x12_a2;
        5'd13: rf_rdata1 = gpr_x13_a3;
        5'd14: rf_rdata1 = gpr_x14_a4;
        5'd15: rf_rdata1 = gpr_x15_a5;
        5'd16: rf_rdata1 = gpr_x16_a6;
        5'd17: rf_rdata1 = gpr_x17_a7;
        5'd18: rf_rdata1 = gpr_x18_s2;
        5'd19: rf_rdata1 = gpr_x19_s3;
        5'd20: rf_rdata1 = gpr_x20_s4;
        5'd21: rf_rdata1 = gpr_x21_s5;
        5'd22: rf_rdata1 = gpr_x22_s6;
        5'd23: rf_rdata1 = gpr_x23_s7;
        5'd24: rf_rdata1 = gpr_x24_s8;
        5'd25: rf_rdata1 = gpr_x25_s9;
        5'd26: rf_rdata1 = gpr_x26_s10;
        5'd27: rf_rdata1 = gpr_x27_s11;
        5'd28: rf_rdata1 = gpr_x28_t3;
        5'd29: rf_rdata1 = gpr_x29_t4;
        5'd30: rf_rdata1 = gpr_x30_t5;
        5'd31: rf_rdata1 = gpr_x31_t6;
        default: rf_rdata1 = {32{1'b0}};
    endcase
end

always @* begin
    case (rf_raddr2)
        5'd0: rf_rdata2 = {32{1'b0}};
        5'd01: rf_rdata2 = gpr_x01_ra;
        5'd02: rf_rdata2 = gpr_x02_sp;
        5'd03: rf_rdata2 = gpr_x03_gp;
        5'd04: rf_rdata2 = gpr_x04_tp;
        5'd05: rf_rdata2 = gpr_x05_t0;
        5'd06: rf_rdata2 = gpr_x06_t1;
        5'd07: rf_rdata2 = gpr_x07_t2;
        5'd08: rf_rdata2 = gpr_x08_s0;
        5'd09: rf_rdata2 = gpr_x09_s1;
        5'd10: rf_rdata2 = gpr_x10_a0;
        5'd11: rf_rdata2 = gpr_x11_a1;
        5'd12: rf_rdata2 = gpr_x12_a2;
        5'd13: rf_rdata2 = gpr_x13_a3;
        5'd14: rf_rdata2 = gpr_x14_a4;
        5'd15: rf_rdata2 = gpr_x15_a5;
        5'd16: rf_rdata2 = gpr_x16_a6;
        5'd17: rf_rdata2 = gpr_x17_a7;
        5'd18: rf_rdata2 = gpr_x18_s2;
        5'd19: rf_rdata2 = gpr_x19_s3;
        5'd20: rf_rdata2 = gpr_x20_s4;
        5'd21: rf_rdata2 = gpr_x21_s5;
        5'd22: rf_rdata2 = gpr_x22_s6;
        5'd23: rf_rdata2 = gpr_x23_s7;
        5'd24: rf_rdata2 = gpr_x24_s8;
        5'd25: rf_rdata2 = gpr_x25_s9;
        5'd26: rf_rdata2 = gpr_x26_s10;
        5'd27: rf_rdata2 = gpr_x27_s11;
        5'd28: rf_rdata2 = gpr_x28_t3;
        5'd29: rf_rdata2 = gpr_x29_t4;
        5'd30: rf_rdata2 = gpr_x30_t5;
        5'd31: rf_rdata2 = gpr_x31_t6;
        default: rf_rdata2 = {32{1'b0}};
    endcase
end

always @* begin
    case (rf_raddr3)
        5'd0: rf_rdata3 = {32{1'b0}};
        5'd01: rf_rdata3 = gpr_x01_ra;
        5'd02: rf_rdata3 = gpr_x02_sp;
        5'd03: rf_rdata3 = gpr_x03_gp;
        5'd04: rf_rdata3 = gpr_x04_tp;
        5'd05: rf_rdata3 = gpr_x05_t0;
        5'd06: rf_rdata3 = gpr_x06_t1;
        5'd07: rf_rdata3 = gpr_x07_t2;
        5'd08: rf_rdata3 = gpr_x08_s0;
        5'd09: rf_rdata3 = gpr_x09_s1;
        5'd10: rf_rdata3 = gpr_x10_a0;
        5'd11: rf_rdata3 = gpr_x11_a1;
        5'd12: rf_rdata3 = gpr_x12_a2;
        5'd13: rf_rdata3 = gpr_x13_a3;
        5'd14: rf_rdata3 = gpr_x14_a4;
        5'd15: rf_rdata3 = gpr_x15_a5;
        5'd16: rf_rdata3 = gpr_x16_a6;
        5'd17: rf_rdata3 = gpr_x17_a7;
        5'd18: rf_rdata3 = gpr_x18_s2;
        5'd19: rf_rdata3 = gpr_x19_s3;
        5'd20: rf_rdata3 = gpr_x20_s4;
        5'd21: rf_rdata3 = gpr_x21_s5;
        5'd22: rf_rdata3 = gpr_x22_s6;
        5'd23: rf_rdata3 = gpr_x23_s7;
        5'd24: rf_rdata3 = gpr_x24_s8;
        5'd25: rf_rdata3 = gpr_x25_s9;
        5'd26: rf_rdata3 = gpr_x26_s10;
        5'd27: rf_rdata3 = gpr_x27_s11;
        5'd28: rf_rdata3 = gpr_x28_t3;
        5'd29: rf_rdata3 = gpr_x29_t4;
        5'd30: rf_rdata3 = gpr_x30_t5;
        5'd31: rf_rdata3 = gpr_x31_t6;
        default: rf_rdata3 = {32{1'b0}};
    endcase
end

always @* begin
    case (rf_raddr4)
        5'd0: rf_rdata4 = {32{1'b0}};
        5'd01: rf_rdata4 = gpr_x01_ra;
        5'd02: rf_rdata4 = gpr_x02_sp;
        5'd03: rf_rdata4 = gpr_x03_gp;
        5'd04: rf_rdata4 = gpr_x04_tp;
        5'd05: rf_rdata4 = gpr_x05_t0;
        5'd06: rf_rdata4 = gpr_x06_t1;
        5'd07: rf_rdata4 = gpr_x07_t2;
        5'd08: rf_rdata4 = gpr_x08_s0;
        5'd09: rf_rdata4 = gpr_x09_s1;
        5'd10: rf_rdata4 = gpr_x10_a0;
        5'd11: rf_rdata4 = gpr_x11_a1;
        5'd12: rf_rdata4 = gpr_x12_a2;
        5'd13: rf_rdata4 = gpr_x13_a3;
        5'd14: rf_rdata4 = gpr_x14_a4;
        5'd15: rf_rdata4 = gpr_x15_a5;
        5'd16: rf_rdata4 = gpr_x16_a6;
        5'd17: rf_rdata4 = gpr_x17_a7;
        5'd18: rf_rdata4 = gpr_x18_s2;
        5'd19: rf_rdata4 = gpr_x19_s3;
        5'd20: rf_rdata4 = gpr_x20_s4;
        5'd21: rf_rdata4 = gpr_x21_s5;
        5'd22: rf_rdata4 = gpr_x22_s6;
        5'd23: rf_rdata4 = gpr_x23_s7;
        5'd24: rf_rdata4 = gpr_x24_s8;
        5'd25: rf_rdata4 = gpr_x25_s9;
        5'd26: rf_rdata4 = gpr_x26_s10;
        5'd27: rf_rdata4 = gpr_x27_s11;
        5'd28: rf_rdata4 = gpr_x28_t3;
        5'd29: rf_rdata4 = gpr_x29_t4;
        5'd30: rf_rdata4 = gpr_x30_t5;
        5'd31: rf_rdata4 = gpr_x31_t6;
        default: rf_rdata4 = {32{1'b0}};
    endcase
end

always @* begin
    case (rf_raddr5)
        5'd0: rf_rdata5 = {32{1'b0}};
        5'd01: rf_rdata5 = gpr_x01_ra;
        5'd02: rf_rdata5 = gpr_x02_sp;
        5'd03: rf_rdata5 = gpr_x03_gp;
        5'd04: rf_rdata5 = gpr_x04_tp;
        5'd05: rf_rdata5 = gpr_x05_t0;
        5'd06: rf_rdata5 = gpr_x06_t1;
        5'd07: rf_rdata5 = gpr_x07_t2;
        5'd08: rf_rdata5 = gpr_x08_s0;
        5'd09: rf_rdata5 = gpr_x09_s1;
        5'd10: rf_rdata5 = gpr_x10_a0;
        5'd11: rf_rdata5 = gpr_x11_a1;
        5'd12: rf_rdata5 = gpr_x12_a2;
        5'd13: rf_rdata5 = gpr_x13_a3;
        5'd14: rf_rdata5 = gpr_x14_a4;
        5'd15: rf_rdata5 = gpr_x15_a5;
        5'd16: rf_rdata5 = gpr_x16_a6;
        5'd17: rf_rdata5 = gpr_x17_a7;
        5'd18: rf_rdata5 = gpr_x18_s2;
        5'd19: rf_rdata5 = gpr_x19_s3;
        5'd20: rf_rdata5 = gpr_x20_s4;
        5'd21: rf_rdata5 = gpr_x21_s5;
        5'd22: rf_rdata5 = gpr_x22_s6;
        5'd23: rf_rdata5 = gpr_x23_s7;
        5'd24: rf_rdata5 = gpr_x24_s8;
        5'd25: rf_rdata5 = gpr_x25_s9;
        5'd26: rf_rdata5 = gpr_x26_s10;
        5'd27: rf_rdata5 = gpr_x27_s11;
        5'd28: rf_rdata5 = gpr_x28_t3;
        5'd29: rf_rdata5 = gpr_x29_t4;
        5'd30: rf_rdata5 = gpr_x30_t5;
        5'd31: rf_rdata5 = gpr_x31_t6;
        default: rf_rdata5 = {32{1'b0}};
    endcase
end

assign rf_we_onehot = rf_we1_onehot | rf_we2_onehot | rf_we3_onehot | rf_sdw_recover_we | {31{rf_init}};
endmodule

