// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbusdec200_config.vh"
`include "atcbusdec200_const.vh"

module atcbusdec200(
`ifdef ATCBUSDEC200_SLV1_SUPPORT
	  ds1_hsel,
	  ds1_hrdata,
	  ds1_hreadyout,
	  ds1_hresp,
`endif
`ifdef ATCBUSDEC200_SLV2_SUPPORT
	  ds2_hsel,
	  ds2_hrdata,
	  ds2_hreadyout,
	  ds2_hresp,
`endif
`ifdef ATCBUSDEC200_SLV3_SUPPORT
	  ds3_hsel,
	  ds3_hrdata,
	  ds3_hreadyout,
	  ds3_hresp,
`endif
`ifdef ATCBUSDEC200_SLV4_SUPPORT
	  ds4_hsel,
	  ds4_hrdata,
	  ds4_hreadyout,
	  ds4_hresp,
`endif
`ifdef ATCBUSDEC200_SLV5_SUPPORT
	  ds5_hsel,
	  ds5_hrdata,
	  ds5_hreadyout,
	  ds5_hresp,
`endif
`ifdef ATCBUSDEC200_SLV6_SUPPORT
	  ds6_hsel,
	  ds6_hrdata,
	  ds6_hreadyout,
	  ds6_hresp,
`endif
`ifdef ATCBUSDEC200_SLV7_SUPPORT
	  ds7_hsel,
	  ds7_hrdata,
	  ds7_hreadyout,
	  ds7_hresp,
`endif
`ifdef ATCBUSDEC200_SLV8_SUPPORT
	  ds8_hsel,
	  ds8_hrdata,
	  ds8_hreadyout,
	  ds8_hresp,
`endif
`ifdef ATCBUSDEC200_SLV9_SUPPORT
	  ds9_hsel,
	  ds9_hrdata,
	  ds9_hreadyout,
	  ds9_hresp,
`endif
`ifdef ATCBUSDEC200_SLV10_SUPPORT
	  ds10_hsel,
	  ds10_hrdata,
	  ds10_hreadyout,
	  ds10_hresp,
`endif
`ifdef ATCBUSDEC200_SLV11_SUPPORT
	  ds11_hsel,
	  ds11_hrdata,
	  ds11_hreadyout,
	  ds11_hresp,
`endif
`ifdef ATCBUSDEC200_SLV12_SUPPORT
	  ds12_hsel,
	  ds12_hrdata,
	  ds12_hreadyout,
	  ds12_hresp,
`endif
`ifdef ATCBUSDEC200_SLV13_SUPPORT
	  ds13_hsel,
	  ds13_hrdata,
	  ds13_hreadyout,
	  ds13_hresp,
`endif
`ifdef ATCBUSDEC200_SLV14_SUPPORT
	  ds14_hsel,
	  ds14_hrdata,
	  ds14_hreadyout,
	  ds14_hresp,
`endif
`ifdef ATCBUSDEC200_SLV15_SUPPORT
	  ds15_hsel,
	  ds15_hrdata,
	  ds15_hreadyout,
	  ds15_hresp,
`endif
`ifdef ATCBUSDEC200_SLV16_SUPPORT
	  ds16_hsel,
	  ds16_hrdata,
	  ds16_hreadyout,
	  ds16_hresp,
`endif
`ifdef ATCBUSDEC200_SLV17_SUPPORT
	  ds17_hsel,
	  ds17_hrdata,
	  ds17_hreadyout,
	  ds17_hresp,
`endif
`ifdef ATCBUSDEC200_SLV18_SUPPORT
	  ds18_hsel,
	  ds18_hrdata,
	  ds18_hreadyout,
	  ds18_hresp,
`endif
`ifdef ATCBUSDEC200_SLV19_SUPPORT
	  ds19_hsel,
	  ds19_hrdata,
	  ds19_hreadyout,
	  ds19_hresp,
`endif
`ifdef ATCBUSDEC200_SLV20_SUPPORT
	  ds20_hsel,
	  ds20_hrdata,
	  ds20_hreadyout,
	  ds20_hresp,
`endif
`ifdef ATCBUSDEC200_SLV21_SUPPORT
	  ds21_hsel,
	  ds21_hrdata,
	  ds21_hreadyout,
	  ds21_hresp,
`endif
`ifdef ATCBUSDEC200_SLV22_SUPPORT
	  ds22_hsel,
	  ds22_hrdata,
	  ds22_hreadyout,
	  ds22_hresp,
`endif
`ifdef ATCBUSDEC200_SLV23_SUPPORT
	  ds23_hsel,
	  ds23_hrdata,
	  ds23_hreadyout,
	  ds23_hresp,
`endif
`ifdef ATCBUSDEC200_SLV24_SUPPORT
	  ds24_hsel,
	  ds24_hrdata,
	  ds24_hreadyout,
	  ds24_hresp,
`endif
`ifdef ATCBUSDEC200_SLV25_SUPPORT
	  ds25_hsel,
	  ds25_hrdata,
	  ds25_hreadyout,
	  ds25_hresp,
`endif
`ifdef ATCBUSDEC200_SLV26_SUPPORT
	  ds26_hsel,
	  ds26_hrdata,
	  ds26_hreadyout,
	  ds26_hresp,
`endif
`ifdef ATCBUSDEC200_SLV27_SUPPORT
	  ds27_hsel,
	  ds27_hrdata,
	  ds27_hreadyout,
	  ds27_hresp,
`endif
`ifdef ATCBUSDEC200_SLV28_SUPPORT
	  ds28_hsel,
	  ds28_hrdata,
	  ds28_hreadyout,
	  ds28_hresp,
`endif
`ifdef ATCBUSDEC200_SLV29_SUPPORT
	  ds29_hsel,
	  ds29_hrdata,
	  ds29_hreadyout,
	  ds29_hresp,
`endif
`ifdef ATCBUSDEC200_SLV30_SUPPORT
	  ds30_hsel,
	  ds30_hrdata,
	  ds30_hreadyout,
	  ds30_hresp,
`endif
`ifdef ATCBUSDEC200_SLV31_SUPPORT
	  ds31_hsel,
	  ds31_hrdata,
	  ds31_hreadyout,
	  ds31_hresp,
`endif
	  hclk,
	  hresetn,
	  us_haddr,
	  us_hsel,
	  us_htrans,
	  us_hrdata,
	  us_hready,
	  us_hreadyout,
	  us_hresp,
	  ds_hready
);

parameter ADDR_WIDTH = `ATCBUSDEC200_ADDR_WIDTH;

parameter DATA_WIDTH = `ATCBUSDEC200_DATA_WIDTH;

parameter ADDR_DECODE_WIDTH = `ATCBUSDEC200_ADDR_DECODE_WIDTH;


`ifdef ATCBUSDEC200_SLV0_SUPPORT
parameter SLV0_OFFSET = `ATCBUSDEC200_SLV0_OFFSET;
parameter SLV0_SIZE = `ATCBUSDEC200_SLV0_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV1_SUPPORT
parameter SLV1_OFFSET = `ATCBUSDEC200_SLV1_OFFSET;
parameter SLV1_SIZE = `ATCBUSDEC200_SLV1_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV2_SUPPORT
parameter SLV2_OFFSET = `ATCBUSDEC200_SLV2_OFFSET;
parameter SLV2_SIZE = `ATCBUSDEC200_SLV2_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV3_SUPPORT
parameter SLV3_OFFSET = `ATCBUSDEC200_SLV3_OFFSET;
parameter SLV3_SIZE = `ATCBUSDEC200_SLV3_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV4_SUPPORT
parameter SLV4_OFFSET = `ATCBUSDEC200_SLV4_OFFSET;
parameter SLV4_SIZE = `ATCBUSDEC200_SLV4_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV5_SUPPORT
parameter SLV5_OFFSET = `ATCBUSDEC200_SLV5_OFFSET;
parameter SLV5_SIZE = `ATCBUSDEC200_SLV5_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV6_SUPPORT
parameter SLV6_OFFSET = `ATCBUSDEC200_SLV6_OFFSET;
parameter SLV6_SIZE = `ATCBUSDEC200_SLV6_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV7_SUPPORT
parameter SLV7_OFFSET = `ATCBUSDEC200_SLV7_OFFSET;
parameter SLV7_SIZE = `ATCBUSDEC200_SLV7_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV8_SUPPORT
parameter SLV8_OFFSET = `ATCBUSDEC200_SLV8_OFFSET;
parameter SLV8_SIZE = `ATCBUSDEC200_SLV8_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV9_SUPPORT
parameter SLV9_OFFSET = `ATCBUSDEC200_SLV9_OFFSET;
parameter SLV9_SIZE = `ATCBUSDEC200_SLV9_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV10_SUPPORT
parameter SLV10_OFFSET = `ATCBUSDEC200_SLV10_OFFSET;
parameter SLV10_SIZE = `ATCBUSDEC200_SLV10_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV11_SUPPORT
parameter SLV11_OFFSET = `ATCBUSDEC200_SLV11_OFFSET;
parameter SLV11_SIZE = `ATCBUSDEC200_SLV11_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV12_SUPPORT
parameter SLV12_OFFSET = `ATCBUSDEC200_SLV12_OFFSET;
parameter SLV12_SIZE = `ATCBUSDEC200_SLV12_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV13_SUPPORT
parameter SLV13_OFFSET = `ATCBUSDEC200_SLV13_OFFSET;
parameter SLV13_SIZE = `ATCBUSDEC200_SLV13_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV14_SUPPORT
parameter SLV14_OFFSET = `ATCBUSDEC200_SLV14_OFFSET;
parameter SLV14_SIZE = `ATCBUSDEC200_SLV14_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV15_SUPPORT
parameter SLV15_OFFSET = `ATCBUSDEC200_SLV15_OFFSET;
parameter SLV15_SIZE = `ATCBUSDEC200_SLV15_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV16_SUPPORT
parameter SLV16_OFFSET = `ATCBUSDEC200_SLV16_OFFSET;
parameter SLV16_SIZE = `ATCBUSDEC200_SLV16_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV17_SUPPORT
parameter SLV17_OFFSET = `ATCBUSDEC200_SLV17_OFFSET;
parameter SLV17_SIZE = `ATCBUSDEC200_SLV17_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV18_SUPPORT
parameter SLV18_OFFSET = `ATCBUSDEC200_SLV18_OFFSET;
parameter SLV18_SIZE = `ATCBUSDEC200_SLV18_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV19_SUPPORT
parameter SLV19_OFFSET = `ATCBUSDEC200_SLV19_OFFSET;
parameter SLV19_SIZE = `ATCBUSDEC200_SLV19_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV20_SUPPORT
parameter SLV20_OFFSET = `ATCBUSDEC200_SLV20_OFFSET;
parameter SLV20_SIZE = `ATCBUSDEC200_SLV20_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV21_SUPPORT
parameter SLV21_OFFSET = `ATCBUSDEC200_SLV21_OFFSET;
parameter SLV21_SIZE = `ATCBUSDEC200_SLV21_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV22_SUPPORT
parameter SLV22_OFFSET = `ATCBUSDEC200_SLV22_OFFSET;
parameter SLV22_SIZE = `ATCBUSDEC200_SLV22_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV23_SUPPORT
parameter SLV23_OFFSET = `ATCBUSDEC200_SLV23_OFFSET;
parameter SLV23_SIZE = `ATCBUSDEC200_SLV23_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV24_SUPPORT
parameter SLV24_OFFSET = `ATCBUSDEC200_SLV24_OFFSET;
parameter SLV24_SIZE = `ATCBUSDEC200_SLV24_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV25_SUPPORT
parameter SLV25_OFFSET = `ATCBUSDEC200_SLV25_OFFSET;
parameter SLV25_SIZE = `ATCBUSDEC200_SLV25_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV26_SUPPORT
parameter SLV26_OFFSET = `ATCBUSDEC200_SLV26_OFFSET;
parameter SLV26_SIZE = `ATCBUSDEC200_SLV26_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV27_SUPPORT
parameter SLV27_OFFSET = `ATCBUSDEC200_SLV27_OFFSET;
parameter SLV27_SIZE = `ATCBUSDEC200_SLV27_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV28_SUPPORT
parameter SLV28_OFFSET = `ATCBUSDEC200_SLV28_OFFSET;
parameter SLV28_SIZE = `ATCBUSDEC200_SLV28_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV29_SUPPORT
parameter SLV29_OFFSET = `ATCBUSDEC200_SLV29_OFFSET;
parameter SLV29_SIZE = `ATCBUSDEC200_SLV29_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV30_SUPPORT
parameter SLV30_OFFSET = `ATCBUSDEC200_SLV30_OFFSET;
parameter SLV30_SIZE = `ATCBUSDEC200_SLV30_SIZE;
`endif
`ifdef ATCBUSDEC200_SLV31_SUPPORT
parameter SLV31_OFFSET = `ATCBUSDEC200_SLV31_OFFSET;
parameter SLV31_SIZE = `ATCBUSDEC200_SLV31_SIZE;
`endif
localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam DATA_ADDR_LSB    = (DATA_WIDTH == 256) ? 5 :
			      (DATA_WIDTH == 128) ? 4 :
			      (DATA_WIDTH == 64)  ? 3 : 2;

localparam SLV_SIZE_UNIT = (ADDR_WIDTH == 24) ? 10 : 20;
localparam DECODE_OFFSET_MSB = ADDR_DECODE_WIDTH - 1;

`ifdef ATCBUSDEC200_SLV1_SUPPORT
output		ds1_hsel;
input [DATA_MSB:0]	ds1_hrdata;
input		ds1_hreadyout;
input		ds1_hresp;
`endif
`ifdef ATCBUSDEC200_SLV2_SUPPORT
output		ds2_hsel;
input [DATA_MSB:0]	ds2_hrdata;
input		ds2_hreadyout;
input		ds2_hresp;
`endif
`ifdef ATCBUSDEC200_SLV3_SUPPORT
output		ds3_hsel;
input [DATA_MSB:0]	ds3_hrdata;
input		ds3_hreadyout;
input		ds3_hresp;
`endif
`ifdef ATCBUSDEC200_SLV4_SUPPORT
output		ds4_hsel;
input [DATA_MSB:0]	ds4_hrdata;
input		ds4_hreadyout;
input		ds4_hresp;
`endif
`ifdef ATCBUSDEC200_SLV5_SUPPORT
output		ds5_hsel;
input [DATA_MSB:0]	ds5_hrdata;
input		ds5_hreadyout;
input		ds5_hresp;
`endif
`ifdef ATCBUSDEC200_SLV6_SUPPORT
output		ds6_hsel;
input [DATA_MSB:0]	ds6_hrdata;
input		ds6_hreadyout;
input		ds6_hresp;
`endif
`ifdef ATCBUSDEC200_SLV7_SUPPORT
output		ds7_hsel;
input [DATA_MSB:0]	ds7_hrdata;
input		ds7_hreadyout;
input		ds7_hresp;
`endif
`ifdef ATCBUSDEC200_SLV8_SUPPORT
output		ds8_hsel;
input [DATA_MSB:0]	ds8_hrdata;
input		ds8_hreadyout;
input		ds8_hresp;
`endif
`ifdef ATCBUSDEC200_SLV9_SUPPORT
output		ds9_hsel;
input [DATA_MSB:0]	ds9_hrdata;
input		ds9_hreadyout;
input		ds9_hresp;
`endif
`ifdef ATCBUSDEC200_SLV10_SUPPORT
output		ds10_hsel;
input [DATA_MSB:0]	ds10_hrdata;
input		ds10_hreadyout;
input		ds10_hresp;
`endif
`ifdef ATCBUSDEC200_SLV11_SUPPORT
output		ds11_hsel;
input [DATA_MSB:0]	ds11_hrdata;
input		ds11_hreadyout;
input		ds11_hresp;
`endif
`ifdef ATCBUSDEC200_SLV12_SUPPORT
output		ds12_hsel;
input [DATA_MSB:0]	ds12_hrdata;
input		ds12_hreadyout;
input		ds12_hresp;
`endif
`ifdef ATCBUSDEC200_SLV13_SUPPORT
output		ds13_hsel;
input [DATA_MSB:0]	ds13_hrdata;
input		ds13_hreadyout;
input		ds13_hresp;
`endif
`ifdef ATCBUSDEC200_SLV14_SUPPORT
output		ds14_hsel;
input [DATA_MSB:0]	ds14_hrdata;
input		ds14_hreadyout;
input		ds14_hresp;
`endif
`ifdef ATCBUSDEC200_SLV15_SUPPORT
output		ds15_hsel;
input [DATA_MSB:0]	ds15_hrdata;
input		ds15_hreadyout;
input		ds15_hresp;
`endif
`ifdef ATCBUSDEC200_SLV16_SUPPORT
output		ds16_hsel;
input [DATA_MSB:0]	ds16_hrdata;
input		ds16_hreadyout;
input		ds16_hresp;
`endif
`ifdef ATCBUSDEC200_SLV17_SUPPORT
output		ds17_hsel;
input [DATA_MSB:0]	ds17_hrdata;
input		ds17_hreadyout;
input		ds17_hresp;
`endif
`ifdef ATCBUSDEC200_SLV18_SUPPORT
output		ds18_hsel;
input [DATA_MSB:0]	ds18_hrdata;
input		ds18_hreadyout;
input		ds18_hresp;
`endif
`ifdef ATCBUSDEC200_SLV19_SUPPORT
output		ds19_hsel;
input [DATA_MSB:0]	ds19_hrdata;
input		ds19_hreadyout;
input		ds19_hresp;
`endif
`ifdef ATCBUSDEC200_SLV20_SUPPORT
output		ds20_hsel;
input [DATA_MSB:0]	ds20_hrdata;
input		ds20_hreadyout;
input		ds20_hresp;
`endif
`ifdef ATCBUSDEC200_SLV21_SUPPORT
output		ds21_hsel;
input [DATA_MSB:0]	ds21_hrdata;
input		ds21_hreadyout;
input		ds21_hresp;
`endif
`ifdef ATCBUSDEC200_SLV22_SUPPORT
output		ds22_hsel;
input [DATA_MSB:0]	ds22_hrdata;
input		ds22_hreadyout;
input		ds22_hresp;
`endif
`ifdef ATCBUSDEC200_SLV23_SUPPORT
output		ds23_hsel;
input [DATA_MSB:0]	ds23_hrdata;
input		ds23_hreadyout;
input		ds23_hresp;
`endif
`ifdef ATCBUSDEC200_SLV24_SUPPORT
output		ds24_hsel;
input [DATA_MSB:0]	ds24_hrdata;
input		ds24_hreadyout;
input		ds24_hresp;
`endif
`ifdef ATCBUSDEC200_SLV25_SUPPORT
output		ds25_hsel;
input [DATA_MSB:0]	ds25_hrdata;
input		ds25_hreadyout;
input		ds25_hresp;
`endif
`ifdef ATCBUSDEC200_SLV26_SUPPORT
output		ds26_hsel;
input [DATA_MSB:0]	ds26_hrdata;
input		ds26_hreadyout;
input		ds26_hresp;
`endif
`ifdef ATCBUSDEC200_SLV27_SUPPORT
output		ds27_hsel;
input [DATA_MSB:0]	ds27_hrdata;
input		ds27_hreadyout;
input		ds27_hresp;
`endif
`ifdef ATCBUSDEC200_SLV28_SUPPORT
output		ds28_hsel;
input [DATA_MSB:0]	ds28_hrdata;
input		ds28_hreadyout;
input		ds28_hresp;
`endif
`ifdef ATCBUSDEC200_SLV29_SUPPORT
output		ds29_hsel;
input [DATA_MSB:0]	ds29_hrdata;
input		ds29_hreadyout;
input		ds29_hresp;
`endif
`ifdef ATCBUSDEC200_SLV30_SUPPORT
output		ds30_hsel;
input [DATA_MSB:0]	ds30_hrdata;
input		ds30_hreadyout;
input		ds30_hresp;
`endif
`ifdef ATCBUSDEC200_SLV31_SUPPORT
output		ds31_hsel;
input [DATA_MSB:0]	ds31_hrdata;
input		ds31_hreadyout;
input		ds31_hresp;
`endif


input					hclk;
input					hresetn;
input [ADDR_MSB:0]			us_haddr;
input					us_hsel;
input [1:0]				us_htrans;
output [DATA_MSB:0]			us_hrdata;
input					us_hready;
output					us_hreadyout;
output					us_hresp;
output					ds_hready;

wire					hready;

`ifdef ATCBUSDEC200_SLV0_SUPPORT
reg [ADDR_MSB:0]				us_haddr_d1;
wire					ds0_hsel;
wire [DATA_MSB:0]				ds0_hrdata;
wire					ds0_hreadyout;
wire					ds0_hresp;
wire					is_not_reg;
`endif
wire					default_hsel;
wire [DATA_MSB:0]			default_hrdata;
wire					default_hsel_d1;
`ifndef ATCBUSDEC200_OOR_ERR_EN
wire 					default_hreadyout;
wire					default_hresp;
`else
reg 					default_hreadyout;
reg					default_hresp;
`endif


`ifdef ATCBUSDEC200_SLV0_SUPPORT
reg	ds0_hsel_d1;
wire	ds0_hsel_nxt;
assign	ds0_hsel_nxt = (hready) ? ds0_hsel : ds0_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV1_SUPPORT
reg	ds1_hsel_d1;
wire	ds1_hsel_nxt;
assign	ds1_hsel_nxt = (hready) ? ds1_hsel : ds1_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV2_SUPPORT
reg	ds2_hsel_d1;
wire	ds2_hsel_nxt;
assign	ds2_hsel_nxt = (hready) ? ds2_hsel : ds2_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV3_SUPPORT
reg	ds3_hsel_d1;
wire	ds3_hsel_nxt;
assign	ds3_hsel_nxt = (hready) ? ds3_hsel : ds3_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV4_SUPPORT
reg	ds4_hsel_d1;
wire	ds4_hsel_nxt;
assign	ds4_hsel_nxt = (hready) ? ds4_hsel : ds4_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV5_SUPPORT
reg	ds5_hsel_d1;
wire	ds5_hsel_nxt;
assign	ds5_hsel_nxt = (hready) ? ds5_hsel : ds5_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV6_SUPPORT
reg	ds6_hsel_d1;
wire	ds6_hsel_nxt;
assign	ds6_hsel_nxt = (hready) ? ds6_hsel : ds6_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV7_SUPPORT
reg	ds7_hsel_d1;
wire	ds7_hsel_nxt;
assign	ds7_hsel_nxt = (hready) ? ds7_hsel : ds7_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV8_SUPPORT
reg	ds8_hsel_d1;
wire	ds8_hsel_nxt;
assign	ds8_hsel_nxt = (hready) ? ds8_hsel : ds8_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV9_SUPPORT
reg	ds9_hsel_d1;
wire	ds9_hsel_nxt;
assign	ds9_hsel_nxt = (hready) ? ds9_hsel : ds9_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV10_SUPPORT
reg	ds10_hsel_d1;
wire	ds10_hsel_nxt;
assign	ds10_hsel_nxt = (hready) ? ds10_hsel : ds10_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV11_SUPPORT
reg	ds11_hsel_d1;
wire	ds11_hsel_nxt;
assign	ds11_hsel_nxt = (hready) ? ds11_hsel : ds11_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV12_SUPPORT
reg	ds12_hsel_d1;
wire	ds12_hsel_nxt;
assign	ds12_hsel_nxt = (hready) ? ds12_hsel : ds12_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV13_SUPPORT
reg	ds13_hsel_d1;
wire	ds13_hsel_nxt;
assign	ds13_hsel_nxt = (hready) ? ds13_hsel : ds13_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV14_SUPPORT
reg	ds14_hsel_d1;
wire	ds14_hsel_nxt;
assign	ds14_hsel_nxt = (hready) ? ds14_hsel : ds14_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV15_SUPPORT
reg	ds15_hsel_d1;
wire	ds15_hsel_nxt;
assign	ds15_hsel_nxt = (hready) ? ds15_hsel : ds15_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV16_SUPPORT
reg	ds16_hsel_d1;
wire	ds16_hsel_nxt;
assign	ds16_hsel_nxt = (hready) ? ds16_hsel : ds16_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV17_SUPPORT
reg	ds17_hsel_d1;
wire	ds17_hsel_nxt;
assign	ds17_hsel_nxt = (hready) ? ds17_hsel : ds17_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV18_SUPPORT
reg	ds18_hsel_d1;
wire	ds18_hsel_nxt;
assign	ds18_hsel_nxt = (hready) ? ds18_hsel : ds18_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV19_SUPPORT
reg	ds19_hsel_d1;
wire	ds19_hsel_nxt;
assign	ds19_hsel_nxt = (hready) ? ds19_hsel : ds19_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV20_SUPPORT
reg	ds20_hsel_d1;
wire	ds20_hsel_nxt;
assign	ds20_hsel_nxt = (hready) ? ds20_hsel : ds20_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV21_SUPPORT
reg	ds21_hsel_d1;
wire	ds21_hsel_nxt;
assign	ds21_hsel_nxt = (hready) ? ds21_hsel : ds21_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV22_SUPPORT
reg	ds22_hsel_d1;
wire	ds22_hsel_nxt;
assign	ds22_hsel_nxt = (hready) ? ds22_hsel : ds22_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV23_SUPPORT
reg	ds23_hsel_d1;
wire	ds23_hsel_nxt;
assign	ds23_hsel_nxt = (hready) ? ds23_hsel : ds23_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV24_SUPPORT
reg	ds24_hsel_d1;
wire	ds24_hsel_nxt;
assign	ds24_hsel_nxt = (hready) ? ds24_hsel : ds24_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV25_SUPPORT
reg	ds25_hsel_d1;
wire	ds25_hsel_nxt;
assign	ds25_hsel_nxt = (hready) ? ds25_hsel : ds25_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV26_SUPPORT
reg	ds26_hsel_d1;
wire	ds26_hsel_nxt;
assign	ds26_hsel_nxt = (hready) ? ds26_hsel : ds26_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV27_SUPPORT
reg	ds27_hsel_d1;
wire	ds27_hsel_nxt;
assign	ds27_hsel_nxt = (hready) ? ds27_hsel : ds27_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV28_SUPPORT
reg	ds28_hsel_d1;
wire	ds28_hsel_nxt;
assign	ds28_hsel_nxt = (hready) ? ds28_hsel : ds28_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV29_SUPPORT
reg	ds29_hsel_d1;
wire	ds29_hsel_nxt;
assign	ds29_hsel_nxt = (hready) ? ds29_hsel : ds29_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV30_SUPPORT
reg	ds30_hsel_d1;
wire	ds30_hsel_nxt;
assign	ds30_hsel_nxt = (hready) ? ds30_hsel : ds30_hsel_d1;

`endif
`ifdef ATCBUSDEC200_SLV31_SUPPORT
reg	ds31_hsel_d1;
wire	ds31_hsel_nxt;
assign	ds31_hsel_nxt = (hready) ? ds31_hsel : ds31_hsel_d1;

`endif


always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
	`ifdef ATCBUSDEC200_SLV0_SUPPORT
		 ds0_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV1_SUPPORT
		 ds1_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV2_SUPPORT
		 ds2_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV3_SUPPORT
		 ds3_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV4_SUPPORT
		 ds4_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV5_SUPPORT
		 ds5_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV6_SUPPORT
		 ds6_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV7_SUPPORT
		 ds7_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV8_SUPPORT
		 ds8_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV9_SUPPORT
		 ds9_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV10_SUPPORT
		 ds10_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV11_SUPPORT
		 ds11_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV12_SUPPORT
		 ds12_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV13_SUPPORT
		 ds13_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV14_SUPPORT
		 ds14_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV15_SUPPORT
		 ds15_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV16_SUPPORT
		 ds16_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV17_SUPPORT
		 ds17_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV18_SUPPORT
		 ds18_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV19_SUPPORT
		 ds19_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV20_SUPPORT
		 ds20_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV21_SUPPORT
		 ds21_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV22_SUPPORT
		 ds22_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV23_SUPPORT
		 ds23_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV24_SUPPORT
		 ds24_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV25_SUPPORT
		 ds25_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV26_SUPPORT
		 ds26_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV27_SUPPORT
		 ds27_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV28_SUPPORT
		 ds28_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV29_SUPPORT
		 ds29_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV30_SUPPORT
		 ds30_hsel_d1 <= 1'b0;
	`endif
	`ifdef ATCBUSDEC200_SLV31_SUPPORT
		 ds31_hsel_d1 <= 1'b0;
	`endif
	end
	else begin
	`ifdef ATCBUSDEC200_SLV0_SUPPORT
		ds0_hsel_d1 <= ds0_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV1_SUPPORT
		ds1_hsel_d1 <= ds1_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV2_SUPPORT
		ds2_hsel_d1 <= ds2_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV3_SUPPORT
		ds3_hsel_d1 <= ds3_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV4_SUPPORT
		ds4_hsel_d1 <= ds4_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV5_SUPPORT
		ds5_hsel_d1 <= ds5_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV6_SUPPORT
		ds6_hsel_d1 <= ds6_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV7_SUPPORT
		ds7_hsel_d1 <= ds7_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV8_SUPPORT
		ds8_hsel_d1 <= ds8_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV9_SUPPORT
		ds9_hsel_d1 <= ds9_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV10_SUPPORT
		ds10_hsel_d1 <= ds10_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV11_SUPPORT
		ds11_hsel_d1 <= ds11_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV12_SUPPORT
		ds12_hsel_d1 <= ds12_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV13_SUPPORT
		ds13_hsel_d1 <= ds13_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV14_SUPPORT
		ds14_hsel_d1 <= ds14_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV15_SUPPORT
		ds15_hsel_d1 <= ds15_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV16_SUPPORT
		ds16_hsel_d1 <= ds16_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV17_SUPPORT
		ds17_hsel_d1 <= ds17_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV18_SUPPORT
		ds18_hsel_d1 <= ds18_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV19_SUPPORT
		ds19_hsel_d1 <= ds19_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV20_SUPPORT
		ds20_hsel_d1 <= ds20_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV21_SUPPORT
		ds21_hsel_d1 <= ds21_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV22_SUPPORT
		ds22_hsel_d1 <= ds22_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV23_SUPPORT
		ds23_hsel_d1 <= ds23_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV24_SUPPORT
		ds24_hsel_d1 <= ds24_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV25_SUPPORT
		ds25_hsel_d1 <= ds25_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV26_SUPPORT
		ds26_hsel_d1 <= ds26_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV27_SUPPORT
		ds27_hsel_d1 <= ds27_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV28_SUPPORT
		ds28_hsel_d1 <= ds28_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV29_SUPPORT
		ds29_hsel_d1 <= ds29_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV30_SUPPORT
		ds30_hsel_d1 <= ds30_hsel_nxt;
	`endif
	`ifdef ATCBUSDEC200_SLV31_SUPPORT
		ds31_hsel_d1 <= ds31_hsel_nxt;
	`endif
	end
end

assign	us_hreadyout = hready;
assign	ds_hready = hready;

assign	default_hrdata = {DATA_WIDTH{1'b1}};
`ifndef ATCBUSDEC200_OOR_ERR_EN
assign	default_hresp = 1'b0;
assign	default_hreadyout = 1'b1;
`else
always @( posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		default_hreadyout <= 1'b1;
		default_hresp <= 1'b0;
	end
	else if (us_htrans[1] && default_hsel && hready) begin
		default_hreadyout <= 1'b0;
		default_hresp <= 1'b1;
	end
	else if (us_hresp && ~hready && default_hsel_d1) begin
		default_hreadyout <= 1'b1;
		default_hresp <= 1'b1;
	end
	else begin
		default_hreadyout <= 1'b1;
		default_hresp <= 1'b0;
	end
end
`endif



assign	default_hsel_d1 = ~(
	`ifdef ATCBUSDEC200_SLV0_SUPPORT
		ds0_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV1_SUPPORT
		| ds1_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV2_SUPPORT
		| ds2_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV3_SUPPORT
		| ds3_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV4_SUPPORT
		| ds4_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV5_SUPPORT
		| ds5_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV6_SUPPORT
		| ds6_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV7_SUPPORT
		| ds7_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV8_SUPPORT
		| ds8_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV9_SUPPORT
		| ds9_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV10_SUPPORT
		| ds10_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV11_SUPPORT
		| ds11_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV12_SUPPORT
		| ds12_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV13_SUPPORT
		| ds13_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV14_SUPPORT
		| ds14_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV15_SUPPORT
		| ds15_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV16_SUPPORT
		| ds16_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV17_SUPPORT
		| ds17_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV18_SUPPORT
		| ds18_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV19_SUPPORT
		| ds19_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV20_SUPPORT
		| ds20_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV21_SUPPORT
		| ds21_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV22_SUPPORT
		| ds22_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV23_SUPPORT
		| ds23_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV24_SUPPORT
		| ds24_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV25_SUPPORT
		| ds25_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV26_SUPPORT
		| ds26_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV27_SUPPORT
		| ds27_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV28_SUPPORT
		| ds28_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV29_SUPPORT
		| ds29_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV30_SUPPORT
		| ds30_hsel_d1
	`endif
	`ifdef ATCBUSDEC200_SLV31_SUPPORT
		| ds31_hsel_d1
	`endif
	);



`ifdef ATCBUSDEC200_SLV0_SUPPORT
localparam SLV0_OFFSET_LSB = (SLV_SIZE_UNIT + SLV0_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV1_SUPPORT
localparam SLV1_OFFSET_LSB = (SLV_SIZE_UNIT + SLV1_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV2_SUPPORT
localparam SLV2_OFFSET_LSB = (SLV_SIZE_UNIT + SLV2_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV3_SUPPORT
localparam SLV3_OFFSET_LSB = (SLV_SIZE_UNIT + SLV3_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV4_SUPPORT
localparam SLV4_OFFSET_LSB = (SLV_SIZE_UNIT + SLV4_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV5_SUPPORT
localparam SLV5_OFFSET_LSB = (SLV_SIZE_UNIT + SLV5_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV6_SUPPORT
localparam SLV6_OFFSET_LSB = (SLV_SIZE_UNIT + SLV6_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV7_SUPPORT
localparam SLV7_OFFSET_LSB = (SLV_SIZE_UNIT + SLV7_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV8_SUPPORT
localparam SLV8_OFFSET_LSB = (SLV_SIZE_UNIT + SLV8_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV9_SUPPORT
localparam SLV9_OFFSET_LSB = (SLV_SIZE_UNIT + SLV9_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV10_SUPPORT
localparam SLV10_OFFSET_LSB = (SLV_SIZE_UNIT + SLV10_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV11_SUPPORT
localparam SLV11_OFFSET_LSB = (SLV_SIZE_UNIT + SLV11_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV12_SUPPORT
localparam SLV12_OFFSET_LSB = (SLV_SIZE_UNIT + SLV12_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV13_SUPPORT
localparam SLV13_OFFSET_LSB = (SLV_SIZE_UNIT + SLV13_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV14_SUPPORT
localparam SLV14_OFFSET_LSB = (SLV_SIZE_UNIT + SLV14_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV15_SUPPORT
localparam SLV15_OFFSET_LSB = (SLV_SIZE_UNIT + SLV15_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV16_SUPPORT
localparam SLV16_OFFSET_LSB = (SLV_SIZE_UNIT + SLV16_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV17_SUPPORT
localparam SLV17_OFFSET_LSB = (SLV_SIZE_UNIT + SLV17_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV18_SUPPORT
localparam SLV18_OFFSET_LSB = (SLV_SIZE_UNIT + SLV18_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV19_SUPPORT
localparam SLV19_OFFSET_LSB = (SLV_SIZE_UNIT + SLV19_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV20_SUPPORT
localparam SLV20_OFFSET_LSB = (SLV_SIZE_UNIT + SLV20_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV21_SUPPORT
localparam SLV21_OFFSET_LSB = (SLV_SIZE_UNIT + SLV21_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV22_SUPPORT
localparam SLV22_OFFSET_LSB = (SLV_SIZE_UNIT + SLV22_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV23_SUPPORT
localparam SLV23_OFFSET_LSB = (SLV_SIZE_UNIT + SLV23_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV24_SUPPORT
localparam SLV24_OFFSET_LSB = (SLV_SIZE_UNIT + SLV24_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV25_SUPPORT
localparam SLV25_OFFSET_LSB = (SLV_SIZE_UNIT + SLV25_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV26_SUPPORT
localparam SLV26_OFFSET_LSB = (SLV_SIZE_UNIT + SLV26_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV27_SUPPORT
localparam SLV27_OFFSET_LSB = (SLV_SIZE_UNIT + SLV27_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV28_SUPPORT
localparam SLV28_OFFSET_LSB = (SLV_SIZE_UNIT + SLV28_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV29_SUPPORT
localparam SLV29_OFFSET_LSB = (SLV_SIZE_UNIT + SLV29_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV30_SUPPORT
localparam SLV30_OFFSET_LSB = (SLV_SIZE_UNIT + SLV30_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV31_SUPPORT
localparam SLV31_OFFSET_LSB = (SLV_SIZE_UNIT + SLV31_SIZE - 1);
`endif
`ifdef ATCBUSDEC200_SLV0_SUPPORT
localparam REG_ADDR_MSB = 8;
assign	ds0_hresp = 1'b0;
assign	ds0_hreadyout = 1'b1;

assign	is_not_reg = |us_haddr_d1[SLV0_OFFSET_LSB-1:REG_ADDR_MSB+1];
`ifdef ATCBUSDEC200_SLV1_SUPPORT
wire	[32:0] slv1_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV1_OFFSET}  | {1'b0,SLV1_SIZE};
`else
wire	[32:0] slv1_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV2_SUPPORT
wire	[32:0] slv2_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV2_OFFSET}  | {1'b0,SLV2_SIZE};
`else
wire	[32:0] slv2_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV3_SUPPORT
wire	[32:0] slv3_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV3_OFFSET}  | {1'b0,SLV3_SIZE};
`else
wire	[32:0] slv3_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV4_SUPPORT
wire	[32:0] slv4_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV4_OFFSET}  | {1'b0,SLV4_SIZE};
`else
wire	[32:0] slv4_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV5_SUPPORT
wire	[32:0] slv5_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV5_OFFSET}  | {1'b0,SLV5_SIZE};
`else
wire	[32:0] slv5_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV6_SUPPORT
wire	[32:0] slv6_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV6_OFFSET}  | {1'b0,SLV6_SIZE};
`else
wire	[32:0] slv6_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV7_SUPPORT
wire	[32:0] slv7_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV7_OFFSET}  | {1'b0,SLV7_SIZE};
`else
wire	[32:0] slv7_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV8_SUPPORT
wire	[32:0] slv8_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV8_OFFSET}  | {1'b0,SLV8_SIZE};
`else
wire	[32:0] slv8_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV9_SUPPORT
wire	[32:0] slv9_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV9_OFFSET}  | {1'b0,SLV9_SIZE};
`else
wire	[32:0] slv9_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV10_SUPPORT
wire	[32:0] slv10_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV10_OFFSET}  | {1'b0,SLV10_SIZE};
`else
wire	[32:0] slv10_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV11_SUPPORT
wire	[32:0] slv11_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV11_OFFSET}  | {1'b0,SLV11_SIZE};
`else
wire	[32:0] slv11_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV12_SUPPORT
wire	[32:0] slv12_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV12_OFFSET}  | {1'b0,SLV12_SIZE};
`else
wire	[32:0] slv12_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV13_SUPPORT
wire	[32:0] slv13_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV13_OFFSET}  | {1'b0,SLV13_SIZE};
`else
wire	[32:0] slv13_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV14_SUPPORT
wire	[32:0] slv14_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV14_OFFSET}  | {1'b0,SLV14_SIZE};
`else
wire	[32:0] slv14_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV15_SUPPORT
wire	[32:0] slv15_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV15_OFFSET}  | {1'b0,SLV15_SIZE};
`else
wire	[32:0] slv15_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV16_SUPPORT
wire	[32:0] slv16_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV16_OFFSET}  | {1'b0,SLV16_SIZE};
`else
wire	[32:0] slv16_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV17_SUPPORT
wire	[32:0] slv17_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV17_OFFSET}  | {1'b0,SLV17_SIZE};
`else
wire	[32:0] slv17_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV18_SUPPORT
wire	[32:0] slv18_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV18_OFFSET}  | {1'b0,SLV18_SIZE};
`else
wire	[32:0] slv18_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV19_SUPPORT
wire	[32:0] slv19_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV19_OFFSET}  | {1'b0,SLV19_SIZE};
`else
wire	[32:0] slv19_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV20_SUPPORT
wire	[32:0] slv20_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV20_OFFSET}  | {1'b0,SLV20_SIZE};
`else
wire	[32:0] slv20_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV21_SUPPORT
wire	[32:0] slv21_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV21_OFFSET}  | {1'b0,SLV21_SIZE};
`else
wire	[32:0] slv21_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV22_SUPPORT
wire	[32:0] slv22_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV22_OFFSET}  | {1'b0,SLV22_SIZE};
`else
wire	[32:0] slv22_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV23_SUPPORT
wire	[32:0] slv23_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV23_OFFSET}  | {1'b0,SLV23_SIZE};
`else
wire	[32:0] slv23_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV24_SUPPORT
wire	[32:0] slv24_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV24_OFFSET}  | {1'b0,SLV24_SIZE};
`else
wire	[32:0] slv24_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV25_SUPPORT
wire	[32:0] slv25_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV25_OFFSET}  | {1'b0,SLV25_SIZE};
`else
wire	[32:0] slv25_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV26_SUPPORT
wire	[32:0] slv26_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV26_OFFSET}  | {1'b0,SLV26_SIZE};
`else
wire	[32:0] slv26_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV27_SUPPORT
wire	[32:0] slv27_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV27_OFFSET}  | {1'b0,SLV27_SIZE};
`else
wire	[32:0] slv27_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV28_SUPPORT
wire	[32:0] slv28_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV28_OFFSET}  | {1'b0,SLV28_SIZE};
`else
wire	[32:0] slv28_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV29_SUPPORT
wire	[32:0] slv29_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV29_OFFSET}  | {1'b0,SLV29_SIZE};
`else
wire	[32:0] slv29_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV30_SUPPORT
wire	[32:0] slv30_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV30_OFFSET}  | {1'b0,SLV30_SIZE};
`else
wire	[32:0] slv30_cfg_reg = 33'd0;
`endif
`ifdef ATCBUSDEC200_SLV31_SUPPORT
wire	[32:0] slv31_cfg_reg = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV31_OFFSET}  | {1'b0,SLV31_SIZE};
`else
wire	[32:0] slv31_cfg_reg = 33'd0;
`endif
generate
if (DATA_WIDTH == 32) begin: gen_data_width_32
	assign ds0_hrdata = (~ds0_hsel_d1 | is_not_reg) ? {DATA_WIDTH{1'b0}} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h0) ? `ATCBUSDEC200_PRODUCT_ID :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h8) ? slv1_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h9) ? slv2_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'ha) ? slv3_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'hb) ? slv4_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'hc) ? slv5_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'hd) ? slv6_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'he) ? slv7_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'hf) ? slv8_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h10) ? slv9_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h11) ? slv10_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h12) ? slv11_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h13) ? slv12_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h14) ? slv13_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h15) ? slv14_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h16) ? slv15_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h17) ? slv16_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h18) ? slv17_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h19) ? slv18_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h1a) ? slv19_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h1b) ? slv20_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h1c) ? slv21_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h1d) ? slv22_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h1e) ? slv23_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h1f) ? slv24_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h20) ? slv25_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h21) ? slv26_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h22) ? slv27_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h23) ? slv28_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h24) ? slv29_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h25) ? slv30_cfg_reg[31:0] :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 7'h26) ? slv31_cfg_reg[31:0] :
                  {DATA_WIDTH{1'b0}};
end
endgenerate

generate
if (DATA_WIDTH == 64) begin: gen_data_width_64
	assign ds0_hrdata = (~ds0_hsel_d1 | is_not_reg) ? {DATA_WIDTH{1'b0}} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'h0) ? {32'd0, `ATCBUSDEC200_PRODUCT_ID} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'h4) ? {slv2_cfg_reg[31:0], slv1_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'h5) ? {slv4_cfg_reg[31:0], slv3_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'h6) ? {slv6_cfg_reg[31:0], slv5_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'h7) ? {slv8_cfg_reg[31:0], slv7_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'h8) ? {slv10_cfg_reg[31:0], slv9_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'h9) ? {slv12_cfg_reg[31:0], slv11_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'ha) ? {slv14_cfg_reg[31:0], slv13_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'hb) ? {slv16_cfg_reg[31:0], slv15_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'hc) ? {slv18_cfg_reg[31:0], slv17_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'hd) ? {slv20_cfg_reg[31:0], slv19_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'he) ? {slv22_cfg_reg[31:0], slv21_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'hf) ? {slv24_cfg_reg[31:0], slv23_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'h10) ? {slv26_cfg_reg[31:0], slv25_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'h11) ? {slv28_cfg_reg[31:0], slv27_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'h12) ? {slv30_cfg_reg[31:0], slv29_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 6'h13) ? {32'd0, slv31_cfg_reg[31:0]} :
                  {DATA_WIDTH{1'b0}};
end
endgenerate

generate
if (DATA_WIDTH == 128) begin: gen_data_width_128
	assign ds0_hrdata = (~ds0_hsel_d1 | is_not_reg) ? {DATA_WIDTH{1'b0}} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 5'h0) ? {96'd0, `ATCBUSDEC200_PRODUCT_ID} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 5'h2) ? {slv4_cfg_reg[31:0], slv3_cfg_reg[31:0], slv2_cfg_reg[31:0], slv1_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 5'h3) ? {slv8_cfg_reg[31:0], slv7_cfg_reg[31:0], slv6_cfg_reg[31:0], slv5_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 5'h4) ? {slv12_cfg_reg[31:0], slv11_cfg_reg[31:0], slv10_cfg_reg[31:0], slv9_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 5'h5) ? {slv16_cfg_reg[31:0], slv15_cfg_reg[31:0], slv14_cfg_reg[31:0], slv13_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 5'h6) ? {slv20_cfg_reg[31:0], slv19_cfg_reg[31:0], slv18_cfg_reg[31:0], slv17_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 5'h7) ? {slv24_cfg_reg[31:0], slv23_cfg_reg[31:0], slv22_cfg_reg[31:0], slv21_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 5'h8) ? {slv28_cfg_reg[31:0], slv27_cfg_reg[31:0], slv26_cfg_reg[31:0], slv25_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 5'h9) ? {32'd0, slv31_cfg_reg[31:0], slv30_cfg_reg[31:0], slv29_cfg_reg[31:0]} :
                  {DATA_WIDTH{1'b0}};
end
endgenerate

generate
if (DATA_WIDTH == 256) begin: gen_data_width_256
	assign ds0_hrdata = (~ds0_hsel_d1 | is_not_reg) ? {DATA_WIDTH{1'b0}} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 4'h0) ? {224'd0, `ATCBUSDEC200_PRODUCT_ID} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 4'h1) ? {slv8_cfg_reg[31:0], slv7_cfg_reg[31:0], slv6_cfg_reg[31:0], slv5_cfg_reg[31:0], slv4_cfg_reg[31:0], slv3_cfg_reg[31:0], slv2_cfg_reg[31:0], slv1_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 4'h2) ? {slv16_cfg_reg[31:0], slv15_cfg_reg[31:0], slv14_cfg_reg[31:0], slv13_cfg_reg[31:0], slv12_cfg_reg[31:0], slv11_cfg_reg[31:0], slv10_cfg_reg[31:0], slv9_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 4'h3) ? {slv24_cfg_reg[31:0], slv23_cfg_reg[31:0], slv22_cfg_reg[31:0], slv21_cfg_reg[31:0], slv20_cfg_reg[31:0], slv19_cfg_reg[31:0], slv18_cfg_reg[31:0], slv17_cfg_reg[31:0]} :
		  (us_haddr_d1[REG_ADDR_MSB:DATA_ADDR_LSB] == 4'h4) ? {32'd0, slv31_cfg_reg[31:0], slv30_cfg_reg[31:0], slv29_cfg_reg[31:0], slv28_cfg_reg[31:0], slv27_cfg_reg[31:0], slv26_cfg_reg[31:0], slv25_cfg_reg[31:0]} :
                  {DATA_WIDTH{1'b0}};
end
endgenerate


always @( posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		us_haddr_d1 <= {ADDR_WIDTH{1'b0}};
	end
	else if (ds0_hsel) begin
		us_haddr_d1 <= us_haddr;
	end
end
`endif


	`ifdef ATCBUSDEC200_SLV0_SUPPORT
	 assign	ds0_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV0_OFFSET_LSB], {SLV0_OFFSET_LSB{1'b0}}} == SLV0_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV1_SUPPORT
	 assign	ds1_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV1_OFFSET_LSB], {SLV1_OFFSET_LSB{1'b0}}} == SLV1_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV2_SUPPORT
	 assign	ds2_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV2_OFFSET_LSB], {SLV2_OFFSET_LSB{1'b0}}} == SLV2_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV3_SUPPORT
	 assign	ds3_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV3_OFFSET_LSB], {SLV3_OFFSET_LSB{1'b0}}} == SLV3_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV4_SUPPORT
	 assign	ds4_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV4_OFFSET_LSB], {SLV4_OFFSET_LSB{1'b0}}} == SLV4_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV5_SUPPORT
	 assign	ds5_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV5_OFFSET_LSB], {SLV5_OFFSET_LSB{1'b0}}} == SLV5_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV6_SUPPORT
	 assign	ds6_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV6_OFFSET_LSB], {SLV6_OFFSET_LSB{1'b0}}} == SLV6_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV7_SUPPORT
	 assign	ds7_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV7_OFFSET_LSB], {SLV7_OFFSET_LSB{1'b0}}} == SLV7_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV8_SUPPORT
	 assign	ds8_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV8_OFFSET_LSB], {SLV8_OFFSET_LSB{1'b0}}} == SLV8_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV9_SUPPORT
	 assign	ds9_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV9_OFFSET_LSB], {SLV9_OFFSET_LSB{1'b0}}} == SLV9_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV10_SUPPORT
	 assign	ds10_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV10_OFFSET_LSB], {SLV10_OFFSET_LSB{1'b0}}} == SLV10_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV11_SUPPORT
	 assign	ds11_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV11_OFFSET_LSB], {SLV11_OFFSET_LSB{1'b0}}} == SLV11_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV12_SUPPORT
	 assign	ds12_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV12_OFFSET_LSB], {SLV12_OFFSET_LSB{1'b0}}} == SLV12_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV13_SUPPORT
	 assign	ds13_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV13_OFFSET_LSB], {SLV13_OFFSET_LSB{1'b0}}} == SLV13_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV14_SUPPORT
	 assign	ds14_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV14_OFFSET_LSB], {SLV14_OFFSET_LSB{1'b0}}} == SLV14_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV15_SUPPORT
	 assign	ds15_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV15_OFFSET_LSB], {SLV15_OFFSET_LSB{1'b0}}} == SLV15_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV16_SUPPORT
	 assign	ds16_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV16_OFFSET_LSB], {SLV16_OFFSET_LSB{1'b0}}} == SLV16_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV17_SUPPORT
	 assign	ds17_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV17_OFFSET_LSB], {SLV17_OFFSET_LSB{1'b0}}} == SLV17_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV18_SUPPORT
	 assign	ds18_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV18_OFFSET_LSB], {SLV18_OFFSET_LSB{1'b0}}} == SLV18_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV19_SUPPORT
	 assign	ds19_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV19_OFFSET_LSB], {SLV19_OFFSET_LSB{1'b0}}} == SLV19_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV20_SUPPORT
	 assign	ds20_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV20_OFFSET_LSB], {SLV20_OFFSET_LSB{1'b0}}} == SLV20_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV21_SUPPORT
	 assign	ds21_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV21_OFFSET_LSB], {SLV21_OFFSET_LSB{1'b0}}} == SLV21_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV22_SUPPORT
	 assign	ds22_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV22_OFFSET_LSB], {SLV22_OFFSET_LSB{1'b0}}} == SLV22_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV23_SUPPORT
	 assign	ds23_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV23_OFFSET_LSB], {SLV23_OFFSET_LSB{1'b0}}} == SLV23_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV24_SUPPORT
	 assign	ds24_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV24_OFFSET_LSB], {SLV24_OFFSET_LSB{1'b0}}} == SLV24_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV25_SUPPORT
	 assign	ds25_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV25_OFFSET_LSB], {SLV25_OFFSET_LSB{1'b0}}} == SLV25_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV26_SUPPORT
	 assign	ds26_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV26_OFFSET_LSB], {SLV26_OFFSET_LSB{1'b0}}} == SLV26_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV27_SUPPORT
	 assign	ds27_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV27_OFFSET_LSB], {SLV27_OFFSET_LSB{1'b0}}} == SLV27_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV28_SUPPORT
	 assign	ds28_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV28_OFFSET_LSB], {SLV28_OFFSET_LSB{1'b0}}} == SLV28_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV29_SUPPORT
	 assign	ds29_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV29_OFFSET_LSB], {SLV29_OFFSET_LSB{1'b0}}} == SLV29_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV30_SUPPORT
	 assign	ds30_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV30_OFFSET_LSB], {SLV30_OFFSET_LSB{1'b0}}} == SLV30_OFFSET));
	`endif
	`ifdef ATCBUSDEC200_SLV31_SUPPORT
	 assign	ds31_hsel = us_hready & us_hsel & ((us_htrans == 2'b0) ? 1'b0 : ({us_haddr[DECODE_OFFSET_MSB:SLV31_OFFSET_LSB], {SLV31_OFFSET_LSB{1'b0}}} == SLV31_OFFSET));
	`endif


	assign	default_hsel = us_hready & us_hsel & ~(
	`ifdef ATCBUSDEC200_SLV0_SUPPORT
		ds0_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV1_SUPPORT
		| ds1_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV2_SUPPORT
		| ds2_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV3_SUPPORT
		| ds3_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV4_SUPPORT
		| ds4_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV5_SUPPORT
		| ds5_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV6_SUPPORT
		| ds6_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV7_SUPPORT
		| ds7_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV8_SUPPORT
		| ds8_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV9_SUPPORT
		| ds9_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV10_SUPPORT
		| ds10_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV11_SUPPORT
		| ds11_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV12_SUPPORT
		| ds12_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV13_SUPPORT
		| ds13_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV14_SUPPORT
		| ds14_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV15_SUPPORT
		| ds15_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV16_SUPPORT
		| ds16_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV17_SUPPORT
		| ds17_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV18_SUPPORT
		| ds18_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV19_SUPPORT
		| ds19_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV20_SUPPORT
		| ds20_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV21_SUPPORT
		| ds21_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV22_SUPPORT
		| ds22_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV23_SUPPORT
		| ds23_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV24_SUPPORT
		| ds24_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV25_SUPPORT
		| ds25_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV26_SUPPORT
		| ds26_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV27_SUPPORT
		| ds27_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV28_SUPPORT
		| ds28_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV29_SUPPORT
		| ds29_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV30_SUPPORT
		| ds30_hsel
	`endif
	`ifdef ATCBUSDEC200_SLV31_SUPPORT
		| ds31_hsel
	`endif
	);



	assign	hready		= (default_hsel_d1 & default_hreadyout)
	`ifdef ATCBUSDEC200_SLV0_SUPPORT
		| (ds0_hsel_d1 & ds0_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV1_SUPPORT
		| (ds1_hsel_d1 & ds1_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV2_SUPPORT
		| (ds2_hsel_d1 & ds2_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV3_SUPPORT
		| (ds3_hsel_d1 & ds3_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV4_SUPPORT
		| (ds4_hsel_d1 & ds4_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV5_SUPPORT
		| (ds5_hsel_d1 & ds5_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV6_SUPPORT
		| (ds6_hsel_d1 & ds6_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV7_SUPPORT
		| (ds7_hsel_d1 & ds7_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV8_SUPPORT
		| (ds8_hsel_d1 & ds8_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV9_SUPPORT
		| (ds9_hsel_d1 & ds9_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV10_SUPPORT
		| (ds10_hsel_d1 & ds10_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV11_SUPPORT
		| (ds11_hsel_d1 & ds11_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV12_SUPPORT
		| (ds12_hsel_d1 & ds12_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV13_SUPPORT
		| (ds13_hsel_d1 & ds13_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV14_SUPPORT
		| (ds14_hsel_d1 & ds14_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV15_SUPPORT
		| (ds15_hsel_d1 & ds15_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV16_SUPPORT
		| (ds16_hsel_d1 & ds16_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV17_SUPPORT
		| (ds17_hsel_d1 & ds17_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV18_SUPPORT
		| (ds18_hsel_d1 & ds18_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV19_SUPPORT
		| (ds19_hsel_d1 & ds19_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV20_SUPPORT
		| (ds20_hsel_d1 & ds20_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV21_SUPPORT
		| (ds21_hsel_d1 & ds21_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV22_SUPPORT
		| (ds22_hsel_d1 & ds22_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV23_SUPPORT
		| (ds23_hsel_d1 & ds23_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV24_SUPPORT
		| (ds24_hsel_d1 & ds24_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV25_SUPPORT
		| (ds25_hsel_d1 & ds25_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV26_SUPPORT
		| (ds26_hsel_d1 & ds26_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV27_SUPPORT
		| (ds27_hsel_d1 & ds27_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV28_SUPPORT
		| (ds28_hsel_d1 & ds28_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV29_SUPPORT
		| (ds29_hsel_d1 & ds29_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV30_SUPPORT
		| (ds30_hsel_d1 & ds30_hreadyout)
	`endif
	`ifdef ATCBUSDEC200_SLV31_SUPPORT
		| (ds31_hsel_d1 & ds31_hreadyout)
	`endif
	;

	assign	us_hresp	= (default_hsel_d1 & default_hresp)
	`ifdef ATCBUSDEC200_SLV0_SUPPORT
		| (ds0_hsel_d1 & ds0_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV1_SUPPORT
		| (ds1_hsel_d1 & ds1_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV2_SUPPORT
		| (ds2_hsel_d1 & ds2_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV3_SUPPORT
		| (ds3_hsel_d1 & ds3_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV4_SUPPORT
		| (ds4_hsel_d1 & ds4_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV5_SUPPORT
		| (ds5_hsel_d1 & ds5_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV6_SUPPORT
		| (ds6_hsel_d1 & ds6_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV7_SUPPORT
		| (ds7_hsel_d1 & ds7_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV8_SUPPORT
		| (ds8_hsel_d1 & ds8_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV9_SUPPORT
		| (ds9_hsel_d1 & ds9_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV10_SUPPORT
		| (ds10_hsel_d1 & ds10_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV11_SUPPORT
		| (ds11_hsel_d1 & ds11_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV12_SUPPORT
		| (ds12_hsel_d1 & ds12_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV13_SUPPORT
		| (ds13_hsel_d1 & ds13_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV14_SUPPORT
		| (ds14_hsel_d1 & ds14_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV15_SUPPORT
		| (ds15_hsel_d1 & ds15_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV16_SUPPORT
		| (ds16_hsel_d1 & ds16_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV17_SUPPORT
		| (ds17_hsel_d1 & ds17_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV18_SUPPORT
		| (ds18_hsel_d1 & ds18_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV19_SUPPORT
		| (ds19_hsel_d1 & ds19_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV20_SUPPORT
		| (ds20_hsel_d1 & ds20_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV21_SUPPORT
		| (ds21_hsel_d1 & ds21_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV22_SUPPORT
		| (ds22_hsel_d1 & ds22_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV23_SUPPORT
		| (ds23_hsel_d1 & ds23_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV24_SUPPORT
		| (ds24_hsel_d1 & ds24_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV25_SUPPORT
		| (ds25_hsel_d1 & ds25_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV26_SUPPORT
		| (ds26_hsel_d1 & ds26_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV27_SUPPORT
		| (ds27_hsel_d1 & ds27_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV28_SUPPORT
		| (ds28_hsel_d1 & ds28_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV29_SUPPORT
		| (ds29_hsel_d1 & ds29_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV30_SUPPORT
		| (ds30_hsel_d1 & ds30_hresp)
	`endif
	`ifdef ATCBUSDEC200_SLV31_SUPPORT
		| (ds31_hsel_d1 & ds31_hresp)
	`endif
	;

	assign	us_hrdata	= ({DATA_WIDTH{default_hsel_d1}} & default_hrdata)
	`ifdef ATCBUSDEC200_SLV0_SUPPORT
		| ({DATA_WIDTH{ds0_hsel_d1}} & ds0_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV1_SUPPORT
		| ({DATA_WIDTH{ds1_hsel_d1}} & ds1_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV2_SUPPORT
		| ({DATA_WIDTH{ds2_hsel_d1}} & ds2_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV3_SUPPORT
		| ({DATA_WIDTH{ds3_hsel_d1}} & ds3_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV4_SUPPORT
		| ({DATA_WIDTH{ds4_hsel_d1}} & ds4_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV5_SUPPORT
		| ({DATA_WIDTH{ds5_hsel_d1}} & ds5_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV6_SUPPORT
		| ({DATA_WIDTH{ds6_hsel_d1}} & ds6_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV7_SUPPORT
		| ({DATA_WIDTH{ds7_hsel_d1}} & ds7_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV8_SUPPORT
		| ({DATA_WIDTH{ds8_hsel_d1}} & ds8_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV9_SUPPORT
		| ({DATA_WIDTH{ds9_hsel_d1}} & ds9_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV10_SUPPORT
		| ({DATA_WIDTH{ds10_hsel_d1}} & ds10_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV11_SUPPORT
		| ({DATA_WIDTH{ds11_hsel_d1}} & ds11_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV12_SUPPORT
		| ({DATA_WIDTH{ds12_hsel_d1}} & ds12_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV13_SUPPORT
		| ({DATA_WIDTH{ds13_hsel_d1}} & ds13_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV14_SUPPORT
		| ({DATA_WIDTH{ds14_hsel_d1}} & ds14_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV15_SUPPORT
		| ({DATA_WIDTH{ds15_hsel_d1}} & ds15_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV16_SUPPORT
		| ({DATA_WIDTH{ds16_hsel_d1}} & ds16_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV17_SUPPORT
		| ({DATA_WIDTH{ds17_hsel_d1}} & ds17_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV18_SUPPORT
		| ({DATA_WIDTH{ds18_hsel_d1}} & ds18_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV19_SUPPORT
		| ({DATA_WIDTH{ds19_hsel_d1}} & ds19_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV20_SUPPORT
		| ({DATA_WIDTH{ds20_hsel_d1}} & ds20_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV21_SUPPORT
		| ({DATA_WIDTH{ds21_hsel_d1}} & ds21_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV22_SUPPORT
		| ({DATA_WIDTH{ds22_hsel_d1}} & ds22_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV23_SUPPORT
		| ({DATA_WIDTH{ds23_hsel_d1}} & ds23_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV24_SUPPORT
		| ({DATA_WIDTH{ds24_hsel_d1}} & ds24_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV25_SUPPORT
		| ({DATA_WIDTH{ds25_hsel_d1}} & ds25_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV26_SUPPORT
		| ({DATA_WIDTH{ds26_hsel_d1}} & ds26_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV27_SUPPORT
		| ({DATA_WIDTH{ds27_hsel_d1}} & ds27_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV28_SUPPORT
		| ({DATA_WIDTH{ds28_hsel_d1}} & ds28_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV29_SUPPORT
		| ({DATA_WIDTH{ds29_hsel_d1}} & ds29_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV30_SUPPORT
		| ({DATA_WIDTH{ds30_hsel_d1}} & ds30_hrdata)
	`endif
	`ifdef ATCBUSDEC200_SLV31_SUPPORT
		| ({DATA_WIDTH{ds31_hsel_d1}} & ds31_hrdata)
	`endif
	;


endmodule
