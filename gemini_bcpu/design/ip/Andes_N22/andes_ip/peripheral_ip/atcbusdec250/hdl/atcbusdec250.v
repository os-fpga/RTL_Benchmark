// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary


module atcbusdec250(
	  ds0_hreadyout,
	  ds0_hresp,
	  ds0_hrdata,
	  ds0_hready,
	  ds0_hsel,
	  ds0_haddr,
	  ds0_hwdata,
	  ds0_hburst,
	  ds0_hwrite,
	  ds0_hprot,
	  ds0_hsize,
	  ds0_htrans,
	  ds1_hreadyout,
	  ds1_hresp,
	  ds1_hrdata,
	  ds1_hready,
	  ds1_hsel,
	  ds1_haddr,
	  ds1_hwdata,
	  ds1_hburst,
	  ds1_hwrite,
	  ds1_hprot,
	  ds1_hsize,
	  ds1_htrans,
	  ds2_hreadyout,
	  ds2_hresp,
	  ds2_hrdata,
	  ds2_hready,
	  ds2_hsel,
	  ds2_haddr,
	  ds2_hwdata,
	  ds2_hburst,
	  ds2_hwrite,
	  ds2_hprot,
	  ds2_hsize,
	  ds2_htrans,
	  ds3_hreadyout,
	  ds3_hresp,
	  ds3_hrdata,
	  ds3_hready,
	  ds3_hsel,
	  ds3_haddr,
	  ds3_hwdata,
	  ds3_hburst,
	  ds3_hwrite,
	  ds3_hprot,
	  ds3_hsize,
	  ds3_htrans,
	  ds4_hreadyout,
	  ds4_hresp,
	  ds4_hrdata,
	  ds4_hready,
	  ds4_hsel,
	  ds4_haddr,
	  ds4_hwdata,
	  ds4_hburst,
	  ds4_hwrite,
	  ds4_hprot,
	  ds4_hsize,
	  ds4_htrans,
	  ds5_hreadyout,
	  ds5_hresp,
	  ds5_hrdata,
	  ds5_hready,
	  ds5_hsel,
	  ds5_haddr,
	  ds5_hwdata,
	  ds5_hburst,
	  ds5_hwrite,
	  ds5_hprot,
	  ds5_hsize,
	  ds5_htrans,
	  ds6_hreadyout,
	  ds6_hresp,
	  ds6_hrdata,
	  ds6_hready,
	  ds6_hsel,
	  ds6_haddr,
	  ds6_hwdata,
	  ds6_hburst,
	  ds6_hwrite,
	  ds6_hprot,
	  ds6_hsize,
	  ds6_htrans,
	  ds7_hreadyout,
	  ds7_hresp,
	  ds7_hrdata,
	  ds7_hready,
	  ds7_hsel,
	  ds7_haddr,
	  ds7_hwdata,
	  ds7_hburst,
	  ds7_hwrite,
	  ds7_hprot,
	  ds7_hsize,
	  ds7_htrans,
	  hclk,
	  hresetn,
	  us_hreadyout,
	  us_hresp,
	  us_hrdata,
	  us_hsel,
	  us_hready,
	  us_haddr,
	  us_hwdata,
	  us_hburst,
	  us_hwrite,
	  us_hprot,
	  us_hsize,
	  us_htrans
);

parameter HADDR_WIDTH = 32;
parameter HDATA_WIDTH = 32;
parameter US_IS_MASTER = 1;
parameter DS1_BASE = {HADDR_WIDTH{1'b1}};
parameter DS1_MASK = {HADDR_WIDTH{1'b0}};
parameter DS2_BASE = {HADDR_WIDTH{1'b1}};
parameter DS2_MASK = {HADDR_WIDTH{1'b0}};
parameter DS3_BASE = {HADDR_WIDTH{1'b1}};
parameter DS3_MASK = {HADDR_WIDTH{1'b0}};
parameter DS4_BASE = {HADDR_WIDTH{1'b1}};
parameter DS4_MASK = {HADDR_WIDTH{1'b0}};
parameter DS5_BASE = {HADDR_WIDTH{1'b1}};
parameter DS5_MASK = {HADDR_WIDTH{1'b0}};
parameter DS6_BASE = {HADDR_WIDTH{1'b1}};
parameter DS6_MASK = {HADDR_WIDTH{1'b0}};
parameter DS7_BASE = {HADDR_WIDTH{1'b1}};
parameter DS7_MASK = {HADDR_WIDTH{1'b0}};
parameter DS0_IS_SLAVE = 0;
parameter DS1_IS_SLAVE = 1;
parameter DS2_IS_SLAVE = 1;
parameter DS3_IS_SLAVE = 1;
parameter DS4_IS_SLAVE = 1;
parameter DS5_IS_SLAVE = 1;
parameter DS6_IS_SLAVE = 1;
parameter DS7_IS_SLAVE = 1;


localparam DSNUM = 8;
localparam HTRANS_IDLE   = 2'b00;
localparam HTRANS_BUSY   = 2'b01;
localparam HTRANS_NONSEQ = 2'b10;

localparam HBURST_SINGLE = 3'b000;


input                       ds0_hreadyout;
input                 [1:0] ds0_hresp;
input     [HDATA_WIDTH-1:0] ds0_hrdata;
output                      ds0_hready;
output                      ds0_hsel;
output    [HADDR_WIDTH-1:0] ds0_haddr;
output    [HDATA_WIDTH-1:0] ds0_hwdata;
output                [2:0] ds0_hburst;
output                      ds0_hwrite;
output                [3:0] ds0_hprot;
output                [2:0] ds0_hsize;
output                [1:0] ds0_htrans;

input                       ds1_hreadyout;
input                 [1:0] ds1_hresp;
input     [HDATA_WIDTH-1:0] ds1_hrdata;
output                      ds1_hready;
output                      ds1_hsel;
output    [HADDR_WIDTH-1:0] ds1_haddr;
output    [HDATA_WIDTH-1:0] ds1_hwdata;
output                [2:0] ds1_hburst;
output                      ds1_hwrite;
output                [3:0] ds1_hprot;
output                [2:0] ds1_hsize;
output                [1:0] ds1_htrans;

input                       ds2_hreadyout;
input                 [1:0] ds2_hresp;
input     [HDATA_WIDTH-1:0] ds2_hrdata;
output                      ds2_hready;
output                      ds2_hsel;
output    [HADDR_WIDTH-1:0] ds2_haddr;
output    [HDATA_WIDTH-1:0] ds2_hwdata;
output                [2:0] ds2_hburst;
output                      ds2_hwrite;
output                [3:0] ds2_hprot;
output                [2:0] ds2_hsize;
output                [1:0] ds2_htrans;

input                       ds3_hreadyout;
input                 [1:0] ds3_hresp;
input     [HDATA_WIDTH-1:0] ds3_hrdata;
output                      ds3_hready;
output                      ds3_hsel;
output    [HADDR_WIDTH-1:0] ds3_haddr;
output    [HDATA_WIDTH-1:0] ds3_hwdata;
output                [2:0] ds3_hburst;
output                      ds3_hwrite;
output                [3:0] ds3_hprot;
output                [2:0] ds3_hsize;
output                [1:0] ds3_htrans;

input                       ds4_hreadyout;
input                 [1:0] ds4_hresp;
input     [HDATA_WIDTH-1:0] ds4_hrdata;
output                      ds4_hready;
output                      ds4_hsel;
output    [HADDR_WIDTH-1:0] ds4_haddr;
output    [HDATA_WIDTH-1:0] ds4_hwdata;
output                [2:0] ds4_hburst;
output                      ds4_hwrite;
output                [3:0] ds4_hprot;
output                [2:0] ds4_hsize;
output                [1:0] ds4_htrans;

input                       ds5_hreadyout;
input                 [1:0] ds5_hresp;
input     [HDATA_WIDTH-1:0] ds5_hrdata;
output                      ds5_hready;
output                      ds5_hsel;
output    [HADDR_WIDTH-1:0] ds5_haddr;
output    [HDATA_WIDTH-1:0] ds5_hwdata;
output                [2:0] ds5_hburst;
output                      ds5_hwrite;
output                [3:0] ds5_hprot;
output                [2:0] ds5_hsize;
output                [1:0] ds5_htrans;

input                       ds6_hreadyout;
input                 [1:0] ds6_hresp;
input     [HDATA_WIDTH-1:0] ds6_hrdata;
output                      ds6_hready;
output                      ds6_hsel;
output    [HADDR_WIDTH-1:0] ds6_haddr;
output    [HDATA_WIDTH-1:0] ds6_hwdata;
output                [2:0] ds6_hburst;
output                      ds6_hwrite;
output                [3:0] ds6_hprot;
output                [2:0] ds6_hsize;
output                [1:0] ds6_htrans;

input                       ds7_hreadyout;
input                 [1:0] ds7_hresp;
input     [HDATA_WIDTH-1:0] ds7_hrdata;
output                      ds7_hready;
output                      ds7_hsel;
output    [HADDR_WIDTH-1:0] ds7_haddr;
output    [HDATA_WIDTH-1:0] ds7_hwdata;
output                [2:0] ds7_hburst;
output                      ds7_hwrite;
output                [3:0] ds7_hprot;
output                [2:0] ds7_hsize;
output                [1:0] ds7_htrans;

input                       hclk;
input                       hresetn;

output                      us_hreadyout;
output                [1:0] us_hresp;
output    [HDATA_WIDTH-1:0] us_hrdata;
input                       us_hsel;
input                       us_hready;
input     [HADDR_WIDTH-1:0] us_haddr;
input     [HDATA_WIDTH-1:0] us_hwdata;
input                 [2:0] us_hburst;
input                       us_hwrite;
input                 [3:0] us_hprot;
input                 [2:0] us_hsize;
input                 [1:0] us_htrans;


wire   [DSNUM-1:0] s0;
wire   [DSNUM-1:0] s1;
reg    [DSNUM-1:0] s2;

assign s0[0] = 1'b1;
assign s0[1] = (us_haddr & DS1_MASK[HADDR_WIDTH-1:0]) == DS1_BASE[HADDR_WIDTH-1:0];
assign s0[2] = (us_haddr & DS2_MASK[HADDR_WIDTH-1:0]) == DS2_BASE[HADDR_WIDTH-1:0];
assign s0[3] = (us_haddr & DS3_MASK[HADDR_WIDTH-1:0]) == DS3_BASE[HADDR_WIDTH-1:0];
assign s0[4] = (us_haddr & DS4_MASK[HADDR_WIDTH-1:0]) == DS4_BASE[HADDR_WIDTH-1:0];
assign s0[5] = (us_haddr & DS5_MASK[HADDR_WIDTH-1:0]) == DS5_BASE[HADDR_WIDTH-1:0];
assign s0[6] = (us_haddr & DS6_MASK[HADDR_WIDTH-1:0]) == DS6_BASE[HADDR_WIDTH-1:0];
assign s0[7] = (us_haddr & DS7_MASK[HADDR_WIDTH-1:0]) == DS7_BASE[HADDR_WIDTH-1:0];

assign s1[0] = s0[0] & ~|s0[7:1];
assign s1[1] = s0[1] & ~|s0[7:2];
assign s1[2] = s0[2] & ~|s0[7:3];
assign s1[3] = s0[3] & ~|s0[7:4];
assign s1[4] = s0[4] & ~|s0[7:5];
assign s1[5] = s0[5] & ~|s0[7:6];
assign s1[6] = s0[6] & ~|s0[7:7];
assign s1[7] = s0[7];


assign ds0_haddr  = us_haddr;
assign ds0_hwrite = us_hwrite;
assign ds0_hwdata = us_hwdata;
assign ds0_hprot  = us_hprot;
assign ds0_hsize  = us_hsize;

assign ds1_haddr  = us_haddr;
assign ds1_hwrite = us_hwrite;
assign ds1_hwdata = us_hwdata;
assign ds1_hprot  = us_hprot;
assign ds1_hsize  = us_hsize;

assign ds2_haddr  = us_haddr;
assign ds2_hwrite = us_hwrite;
assign ds2_hwdata = us_hwdata;
assign ds2_hprot  = us_hprot;
assign ds2_hsize  = us_hsize;

assign ds3_haddr  = us_haddr;
assign ds3_hwrite = us_hwrite;
assign ds3_hwdata = us_hwdata;
assign ds3_hprot  = us_hprot;
assign ds3_hsize  = us_hsize;

assign ds4_haddr  = us_haddr;
assign ds4_hwrite = us_hwrite;
assign ds4_hwdata = us_hwdata;
assign ds4_hprot  = us_hprot;
assign ds4_hsize  = us_hsize;

assign ds5_haddr  = us_haddr;
assign ds5_hwrite = us_hwrite;
assign ds5_hwdata = us_hwdata;
assign ds5_hprot  = us_hprot;
assign ds5_hsize  = us_hsize;

assign ds6_haddr  = us_haddr;
assign ds6_hwrite = us_hwrite;
assign ds6_hwdata = us_hwdata;
assign ds6_hprot  = us_hprot;
assign ds6_hsize  = us_hsize;

assign ds7_haddr  = us_haddr;
assign ds7_hwrite = us_hwrite;
assign ds7_hwdata = us_hwdata;
assign ds7_hprot  = us_hprot;
assign ds7_hsize  = us_hsize;


wire s3 = (US_IS_MASTER == 1) ? us_hreadyout : us_hready;
wire s4   = (US_IS_MASTER == 1) ? 1'b1 : us_hsel;


wire s5 = us_hsel & us_htrans[1] & s3;

always @(posedge hclk or negedge hresetn) begin
	if (!hresetn)
		s2 <= {DSNUM{1'b0}};
	else if (s5)
		s2 <= s1;
end



wire [HDATA_WIDTH-1:0] s6;
wire [HDATA_WIDTH-1:0] s7;
wire [HDATA_WIDTH-1:0] s8;
wire [HDATA_WIDTH-1:0] s9;
wire [HDATA_WIDTH-1:0] s10;
wire [HDATA_WIDTH-1:0] s11;
wire [HDATA_WIDTH-1:0] s12;
wire [HDATA_WIDTH-1:0] s13;
wire             [1:0] s14;
wire             [1:0] s15;
wire             [1:0] s16;
wire             [1:0] s17;
wire             [1:0] s18;
wire             [1:0] s19;
wire             [1:0] s20;
wire             [1:0] s21;
wire                   s22;
wire                   s23;
wire                   s24;
wire                   s25;
wire                   s26;
wire                   s27;
wire                   s28;
wire                   s29;
wire                   s30;
wire                   s31;
wire                   s32;
wire                   s33;
wire                   s34;
wire                   s35;
wire                   s36;
wire                   s37;
wire             [1:0] s38;
wire             [1:0] s39;
wire             [1:0] s40;
wire             [1:0] s41;
wire             [1:0] s42;
wire             [1:0] s43;
wire             [1:0] s44;
wire             [1:0] s45;

assign us_hrdata = ({HDATA_WIDTH{s2[0]}} & s6)
                 | ({HDATA_WIDTH{s2[1]}} & s7)
                 | ({HDATA_WIDTH{s2[2]}} & s8)
                 | ({HDATA_WIDTH{s2[3]}} & s9)
                 | ({HDATA_WIDTH{s2[4]}} & s10)
                 | ({HDATA_WIDTH{s2[5]}} & s11)
                 | ({HDATA_WIDTH{s2[6]}} & s12)
                 | ({HDATA_WIDTH{s2[7]}} & s13)
                 ;
assign us_hresp  = ({2{s2[0]}} & s14)
                 | ({2{s2[1]}} & s15)
                 | ({2{s2[2]}} & s16)
                 | ({2{s2[3]}} & s17)
                 | ({2{s2[4]}} & s18)
                 | ({2{s2[5]}} & s19)
                 | ({2{s2[6]}} & s20)
                 | ({2{s2[7]}} & s21)
                 ;
assign us_hreadyout = (~s2[0] | s22)
                    & (~s2[1] | s24)
                    & (~s2[2] | s26)
                    & (~s2[3] | s28)
                    & (~s2[4] | s30)
                    & (~s2[5] | s32)
                    & (~s2[6] | s34)
                    & (~s2[7] | s36)
                    ;

assign s23 = (~s2[1] | s24)
                    & (~s2[2] | s26)
                    & (~s2[3] | s28)
                    & (~s2[4] | s30)
                    & (~s2[5] | s32)
                    & (~s2[6] | s34)
                    & (~s2[7] | s36)
                    ;
assign s25 = (~s2[0] | s22)
                    & (~s2[2] | s26)
                    & (~s2[3] | s28)
                    & (~s2[4] | s30)
                    & (~s2[5] | s32)
                    & (~s2[6] | s34)
                    & (~s2[7] | s36)
                    ;
assign s27 = (~s2[0] | s22)
                    & (~s2[1] | s24)
                    & (~s2[3] | s28)
                    & (~s2[4] | s30)
                    & (~s2[5] | s32)
                    & (~s2[6] | s34)
                    & (~s2[7] | s36)
                    ;
assign s29 = (~s2[0] | s22)
                    & (~s2[1] | s24)
                    & (~s2[2] | s26)
                    & (~s2[4] | s30)
                    & (~s2[5] | s32)
                    & (~s2[6] | s34)
                    & (~s2[7] | s36)
                    ;
assign s31 = (~s2[0] | s22)
                    & (~s2[1] | s24)
                    & (~s2[2] | s26)
                    & (~s2[3] | s28)
                    & (~s2[5] | s32)
                    & (~s2[6] | s34)
                    & (~s2[7] | s36)
                    ;
assign s33 = (~s2[0] | s22)
                    & (~s2[1] | s24)
                    & (~s2[2] | s26)
                    & (~s2[3] | s28)
                    & (~s2[4] | s30)
                    & (~s2[6] | s34)
                    & (~s2[7] | s36)
                    ;
assign s35 = (~s2[0] | s22)
                    & (~s2[1] | s24)
                    & (~s2[2] | s26)
                    & (~s2[3] | s28)
                    & (~s2[4] | s30)
                    & (~s2[5] | s32)
                    & (~s2[7] | s36)
                    ;
assign s37 = (~s2[0] | s22)
                    & (~s2[1] | s24)
                    & (~s2[2] | s26)
                    & (~s2[3] | s28)
                    & (~s2[4] | s30)
                    & (~s2[5] | s32)
                    & (~s2[6] | s34)
                    ;

assign ds0_hsel         = (DS0_IS_SLAVE==0) | (s4 & s1[0]);
assign ds1_hsel         = (DS1_IS_SLAVE==0) | (s4 & s1[1]);
assign ds2_hsel         = (DS2_IS_SLAVE==0) | (s4 & s1[2]);
assign ds3_hsel         = (DS3_IS_SLAVE==0) | (s4 & s1[3]);
assign ds4_hsel         = (DS4_IS_SLAVE==0) | (s4 & s1[4]);
assign ds5_hsel         = (DS5_IS_SLAVE==0) | (s4 & s1[5]);
assign ds6_hsel         = (DS6_IS_SLAVE==0) | (s4 & s1[6]);
assign ds7_hsel         = (DS7_IS_SLAVE==0) | (s4 & s1[7]);

assign ds0_htrans       = ((DS0_IS_SLAVE==1) | (s4 & s1[0] & s23)) ? s38 : HTRANS_IDLE;
assign ds1_htrans       = ((DS1_IS_SLAVE==1) | (s4 & s1[1] & s25)) ? s39 : HTRANS_IDLE;
assign ds2_htrans       = ((DS2_IS_SLAVE==1) | (s4 & s1[2] & s27)) ? s40 : HTRANS_IDLE;
assign ds3_htrans       = ((DS3_IS_SLAVE==1) | (s4 & s1[3] & s29)) ? s41 : HTRANS_IDLE;
assign ds4_htrans       = ((DS4_IS_SLAVE==1) | (s4 & s1[4] & s31)) ? s42 : HTRANS_IDLE;
assign ds5_htrans       = ((DS5_IS_SLAVE==1) | (s4 & s1[5] & s33)) ? s43 : HTRANS_IDLE;
assign ds6_htrans       = ((DS6_IS_SLAVE==1) | (s4 & s1[6] & s35)) ? s44 : HTRANS_IDLE;
assign ds7_htrans       = ((DS7_IS_SLAVE==1) | (s4 & s1[7] & s37)) ? s45 : HTRANS_IDLE;

assign s6    = ds0_hrdata;
assign s22 = ds0_hreadyout;
assign s14     = ds0_hresp;
assign s38   = us_htrans;
assign ds0_hburst       = us_hburst;
assign ds0_hready       = s3;

assign s7    = ds1_hrdata;
assign s24 = ds1_hreadyout;
assign s15     = ds1_hresp;
assign s39   = us_htrans;
assign ds1_hburst       = us_hburst;
assign ds1_hready       = s3;

assign s8    = ds2_hrdata;
assign s26 = ds2_hreadyout;
assign s16     = ds2_hresp;
assign s40   = us_htrans;
assign ds2_hburst       = us_hburst;
assign ds2_hready       = s3;

assign s9    = ds3_hrdata;
assign s28 = ds3_hreadyout;
assign s17     = ds3_hresp;
assign s41   = us_htrans;
assign ds3_hburst       = us_hburst;
assign ds3_hready       = s3;

assign s10    = ds4_hrdata;
assign s30 = ds4_hreadyout;
assign s18     = ds4_hresp;
assign s42   = us_htrans;
assign ds4_hburst       = us_hburst;
assign ds4_hready       = s3;

assign s11    = ds5_hrdata;
assign s32 = ds5_hreadyout;
assign s19     = ds5_hresp;
assign s43   = us_htrans;
assign ds5_hburst       = us_hburst;
assign ds5_hready       = s3;

assign s12    = ds6_hrdata;
assign s34 = ds6_hreadyout;
assign s20     = ds6_hresp;
assign s44   = us_htrans;
assign ds6_hburst       = us_hburst;
assign ds6_hready       = s3;

assign s13    = ds7_hrdata;
assign s36 = ds7_hreadyout;
assign s21     = ds7_hresp;
assign s45   = us_htrans;
assign ds7_hburst       = us_hburst;
assign ds7_hready       = s3;


endmodule
