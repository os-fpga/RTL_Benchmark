// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsdec (
    base,
    offset,
    store,
    load,
    fmt,
    size,
    last,
    multi,
    una,
    offset_nx
);
parameter FLEN = 64;
input [2:0] base;
input [2:0] offset;
input store;
input load;
input [2:0] fmt;
output [1:0] size;
output last;
output multi;
output una;
output [2:0] offset_nx;


wire s0 = 1'b0;
wire [2:0] s1;
wire s2;
wire s3;
wire [1:0] s4;
wire [1:0] s5;
wire [2:0] s6;
wire s7;
wire s8;
wire s9;
wire s10 = |offset;
assign size[1:0] = ({2{load}} & s4) | ({2{store}} & s5);
assign last = ~s9;
assign s9 = (load & ~s2) | (store & ~s7);
assign multi = (load & s3) | (store & s8);
assign offset_nx = ({3{load}} & s1) | ({3{store}} & s6);
assign s8 = ((fmt[1:0] == 2'd1) & base[0]) | ((fmt[1:0] == 2'd2) & (base[1:0] != 2'd0)) | ((fmt[1:0] == 2'd3) & (base[2:0] != 3'd0)) | ((fmt[1:0] == 2'd3) && ~s0);
assign una = ((fmt[1:0] == 2'd1) & (base[0] != 1'd0)) | ((fmt[1:0] == 2'd2) & (base[1:0] != 2'd0)) | ((fmt[1:0] == 2'd3) & (base[2:0] != 3'd0));
wire [2:0] s11;
wire [2:0] s12;
wire [2:0] s13;
wire [1:0] s14;
wire [1:0] s15;
wire [1:0] s16;
wire [2:0] s17;
wire [2:0] s18;
wire [2:0] s19;
wire [1:0] s20;
wire [1:0] s21;
wire [1:0] s22;
wire s23;
wire s24;
wire s25;
wire s26 = FLEN == 64;
assign s2 = (fmt[1:0] == 2'd0) | ((fmt[1:0] == 2'd1) && (base[1:0] != 2'h3)) | ((fmt[1:0] == 2'd1) && (offset[0] == 1'h1)) | ((fmt[1:0] == 2'd2) && (base[1:0] == 2'd0)) | ((fmt[1:0] == 2'd2) && (offset[1:0] != 2'd0)) | ((fmt[1:0] == 2'd3) && (base[1:0] == 2'd0) && (offset[2:0] == 3'd4)) | ((fmt[1:0] == 2'd3) && (base[1:0] == 2'd1) && (offset[2:0] == 3'd7)) | ((fmt[1:0] == 2'd3) && (base[1:0] == 2'd2) && (offset[2:0] == 3'd6)) | ((fmt[1:0] == 2'd3) && (base[1:0] == 2'd3) && (offset[2:0] == 3'd5));
assign s14 = ({2{(base[0] == 1'd0)}} & 2'd1) | ({2{(base[1:0] == 2'd1)}} & 2'd2) | ({2{(base[1:0] == 2'd3)}} & 2'd0);
assign s11 = ({3{(base[0] == 1'd0)}} & 3'd0) | ({3{(base[1:0] == 2'd1)}} & 3'd0) | ({3{(base[1:0] == 2'd3)}} & 3'd1);
assign s15 = ({2{(base[1:0] == 2'd0)}} & 2'd2) | ({2{(base[1:0] == 2'd1) && (offset[1:0] == 2'd0)}} & 2'd2) | ({2{(base[1:0] == 2'd1) && (offset[1:0] == 2'd3)}} & 2'd0) | ({2{(base[1:0] == 2'd2)}} & 2'd1) | ({2{(base[1:0] == 2'd3) && (offset[1:0] == 2'd0)}} & 2'd0) | ({2{(base[1:0] == 2'd3) && (offset[1:0] == 2'd1)}} & 2'd2);
assign s12 = ({3{(base[1:0] == 2'd0)}} & 3'd0) | ({3{(base[1:0] == 2'd1)}} & 3'd3) | ({3{(base[1:0] == 2'd2)}} & 3'd2) | ({3{(base[1:0] == 2'd3)}} & 3'd1);
assign s16 = ({2{(base[1:0] == 2'd0)}} & 2'd2) | ({2{(base[1:0] == 2'd1) && (offset[2:0] == 3'd0)}} & 2'd2) | ({2{(base[1:0] == 2'd1) && (offset[2:0] == 3'd3)}} & 2'd2) | ({2{(base[1:0] == 2'd1) && (offset[2:0] == 3'd7)}} & 2'd0) | ({2{(base[1:0] == 2'd2) && (offset[2:0] == 3'd0)}} & 2'd1) | ({2{(base[1:0] == 2'd2) && (offset[2:0] == 3'd2)}} & 2'd2) | ({2{(base[1:0] == 2'd2) && (offset[2:0] == 3'd6)}} & 2'd1) | ({2{(base[1:0] == 2'd3) && (offset[2:0] == 3'd0)}} & 2'd0) | ({2{(base[1:0] == 2'd3) && (offset[2:0] == 3'd1)}} & 2'd2) | ({2{(base[1:0] == 2'd3) && (offset[2:0] == 3'd5)}} & 2'd2);
assign s13 = ({3{((base[1:0] == 2'd0) && (offset[2:0] == 3'd0))}} & 3'd4) | ({3{((base[1:0] == 2'd1) && (offset[2:0] == 3'd0))}} & 3'd3) | ({3{((base[1:0] == 2'd1) && (offset[2:0] == 3'd3))}} & 3'd7) | ({3{((base[1:0] == 2'd2) && (offset[2:0] == 3'd0))}} & 3'd2) | ({3{((base[1:0] == 2'd2) && (offset[2:0] == 3'd2))}} & 3'd6) | ({3{((base[1:0] == 2'd3) && (offset[2:0] == 3'd0))}} & 3'd1) | ({3{((base[1:0] == 2'd3) && (offset[2:0] == 3'd1))}} & 3'd5);
assign s4 = ({2{(fmt[1:0] == 2'd1)}} & s14) | ({2{(fmt[1:0] == 2'd2)}} & s15) | ({2{(fmt[1:0] == 2'd3) & s26}} & s16);
assign s1 = ({3{(fmt[1:0] == 2'd1)}} & s11) | ({3{(fmt[1:0] == 2'd2)}} & s12) | ({3{(fmt[1:0] == 2'd3) & s26}} & s13);
assign s3 = ((fmt[1:0] == 2'd1) & (base[1:0] == 2'd3)) | ((fmt[1:0] == 2'd2) & (base[1:0] != 2'd0)) | ((fmt[1:0] == 2'd3) & s26);
assign s17 = ({3{(base[0] == 1'd0)}} & 3'd0) | ({3{(base[0] == 1'd1)}} & 3'd1);
assign s20 = ({2{(base[0] == 1'd0)}} & 2'd1) | ({2{(base[0] == 1'd1)}} & 2'd0);
assign s23 = ((base[0] == 1'd0)) | ((base[0] == 1'd1) && (offset[0] == 1'd1));
assign s18 = ({3{(base[1:0] == 2'd0)}} & 3'd0) | ({3{(base[0] == 1'd1) && (offset[1:0] == 2'd0)}} & 3'd1) | ({3{(base[0] == 1'd1) && (offset[1:0] == 2'd1)}} & 3'd3) | ({3{(base[1:0] == 2'd2) && (offset[1:0] == 2'd0)}} & 3'd2);
assign s21 = ({2{(base[1:0] == 2'd0)}} & 2'd2) | ({2{(base[0] == 1'd1) && (offset[1:0] == 2'd0)}} & 2'd0) | ({2{(base[0] == 1'd1) && (offset[1:0] == 2'd1)}} & 2'd1) | ({2{(base[0] == 1'd1) && (offset[1:0] == 2'd3)}} & 2'd0) | ({2{(base[1:0] == 2'd2)}} & 2'd1);
assign s24 = ((base[1:0] == 2'd0)) | ((base[0] == 1'd1) && (offset[1:0] == 2'd3)) | ((base[1:0] == 2'd2) && (offset[1:0] == 2'd2));
assign s19 = ({3{(base[1:0] == 2'd0) && (offset[2:0] == 3'd0)}} & 3'd4) | ({3{(base[1:0] == 2'd1) && (offset[2:0] == 3'd0)}} & 3'd1) | ({3{(base[1:0] == 2'd1) && (offset[2:0] == 3'd1)}} & 3'd3) | ({3{(base[1:0] == 2'd1) && (offset[2:0] == 3'd3)}} & 3'd7) | ({3{(base[1:0] == 2'd2) && (offset[2:0] == 3'd0)}} & 3'd2) | ({3{(base[1:0] == 2'd2) && (offset[2:0] == 3'd2)}} & 3'd6) | ({3{(base[1:0] == 2'd3) && (offset[2:0] == 3'd0)}} & 3'd1) | ({3{(base[1:0] == 2'd3) && (offset[2:0] == 3'd1)}} & 3'd5) | ({3{(base[1:0] == 2'd3) && (offset[2:0] == 3'd5)}} & 3'd7);
assign s22 = ({2{(base[1:0] == 2'd0)}} & 2'd2) | ({2{(base[1:0] == 2'd1) && (offset[2:0] == 3'd0)}} & 2'd0) | ({2{(base[1:0] == 2'd1) && (offset[2:0] == 3'd1)}} & 2'd1) | ({2{(base[1:0] == 2'd1) && (offset[2:0] == 3'd3)}} & 2'd2) | ({2{(base[1:0] == 2'd1) && (offset[2:0] == 3'd7)}} & 2'd0) | ({2{(base[1:0] == 2'd2) && (offset[2:0] == 3'd0)}} & 2'd1) | ({2{(base[1:0] == 2'd2) && (offset[2:0] == 3'd2)}} & 2'd2) | ({2{(base[1:0] == 2'd2) && (offset[2:0] == 3'd6)}} & 2'd1) | ({2{(base[1:0] == 2'd3) && (offset[2:0] == 3'd0)}} & 2'd0) | ({2{(base[1:0] == 2'd3) && (offset[2:0] == 3'd1)}} & 2'd2) | ({2{(base[1:0] == 2'd3) && (offset[2:0] == 3'd5)}} & 2'd1) | ({2{(base[1:0] == 2'd3) && (offset[2:0] == 3'd7)}} & 2'd0);
assign s25 = ((base[1:0] == 2'd0) && (offset[2:0] == 3'd4)) | ((base[1:0] == 2'd1) && (offset[2:0] == 3'd7)) | ((base[1:0] == 2'd2) && (offset[2:0] == 3'd6)) | ((base[1:0] == 2'd3) && (offset[2:0] == 3'd7));
assign s6 = ({3{(fmt[1:0] == 2'd1)}} & s17) | ({3{(fmt[1:0] == 2'd2)}} & s18) | ({3{(fmt[1:0] == 2'd3) & s26}} & s19);
assign s5 = ({2{(fmt[1:0] == 2'd1)}} & s20) | ({2{(fmt[1:0] == 2'd2)}} & s21) | ({2{(fmt[1:0] == 2'd3) & s26}} & s22);
assign s7 = ((fmt[1:0] == 2'd0)) | ((fmt[1:0] == 2'd1) & s23) | ((fmt[1:0] == 2'd2) & s24) | ((fmt[1:0] == 2'd3) & s26 & s25);
endmodule

