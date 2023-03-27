// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbusdec200_config.vh"
`include "atcbusdec200_const.vh"





module ae350_ahb_subsystem (
`ifdef ATCBUSDEC200_SLV1_SUPPORT
	  ahb2apb_haddr,
	  ahb2apb_hprot,
	  ahb2apb_hready_in,
	  ahb2apb_hsize,
	  ahb2apb_htrans,
	  ahb2apb_hwdata,
	  ahb2apb_hwrite,
	  ahb2apb_hrdata,
	  ahb2apb_hready,
	  ahb2apb_hresp,
	  ahb2apb_hsel,
`endif
	  hbmc_hprot,
	  hbmc_hresp,
	  hbmc_haddr,
	  hbmc_htrans,
	  hclk,
	  hresetn,
	  hbmc_hwdata,
	  hbmc_hwrite,
	  hbmc_hburst,
	  hbmc_hsize,
	  hbmc_hrdata,
	  hbmc_hready,
	  hbmc_hreadyout,
	  hbmc_hsel,
	  lcd_intr,
	  mac_int
);

parameter ADDR_MSB=`ATCBUSDEC200_ADDR_WIDTH-1;
parameter DATA_MSB=`ATCBUSDEC200_DATA_WIDTH-1;

`ifdef ATCBUSDEC200_SLV1_SUPPORT
output          [`ATCAPBBRG100_ADDR_MSB:0] ahb2apb_haddr;
output                               [3:0] ahb2apb_hprot;
output                                     ahb2apb_hready_in;
output                               [2:0] ahb2apb_hsize;
output                               [1:0] ahb2apb_htrans;
output      [`ATCBUSDEC200_DATA_WIDTH-1:0] ahb2apb_hwdata;
output                                     ahb2apb_hwrite;
input                         [DATA_MSB:0] ahb2apb_hrdata;
input                                      ahb2apb_hready;
input                                [1:0] ahb2apb_hresp;
output                                     ahb2apb_hsel;
`endif
input                                [3:0] hbmc_hprot;
output                               [1:0] hbmc_hresp;
input                         [ADDR_MSB:0] hbmc_haddr;
input                                [1:0] hbmc_htrans;
input                                      hclk;
input                                      hresetn;
input                               [31:0] hbmc_hwdata;
input                                      hbmc_hwrite;
input                                [2:0] hbmc_hburst;
input                                [2:0] hbmc_hsize;
output                        [DATA_MSB:0] hbmc_hrdata;
input                                      hbmc_hready;
output                                     hbmc_hreadyout;
input                                      hbmc_hsel;
output                                     lcd_intr;
output                                     mac_int;

wire                                       ds_hready;
wire                                       hbmc_hresp_1bit;

assign mac_int = 1'b0;

assign lcd_intr = 1'b0;

assign hbmc_hresp = {1'b0, hbmc_hresp_1bit};
`ifdef ATCBUSDEC200_SLV1_SUPPORT
	assign ahb2apb_haddr = hbmc_haddr[`ATCAPBBRG100_ADDR_MSB:0];
	assign ahb2apb_hprot = hbmc_hprot;
	assign ahb2apb_hready_in = ds_hready;
	assign ahb2apb_hsize = hbmc_hsize;
	assign ahb2apb_htrans = hbmc_htrans;
	assign ahb2apb_hwdata = hbmc_hwdata;
	assign ahb2apb_hwrite = hbmc_hwrite;
`endif

atcbusdec200 #(
	.ADDR_WIDTH      (ADDR_MSB+1      )
) u_hbmc (
`ifdef ATCBUSDEC200_SLV1_SUPPORT
	.ds1_hsel      (ahb2apb_hsel        ),
	.ds1_hrdata    (ahb2apb_hrdata      ),
	.ds1_hreadyout (ahb2apb_hready      ),
	.ds1_hresp     (ahb2apb_hresp[0]    ),
`endif
`ifdef ATCBUSDEC200_SLV2_SUPPORT
	.ds2_hsel      (ds2_hsel            ),
	.ds2_hrdata    (ds2_hrdata          ),
	.ds2_hreadyout (ds2_hreadyout       ),
	.ds2_hresp     (ds2_hresp[0]        ),
`endif
`ifdef ATCBUSDEC200_SLV3_SUPPORT
	.ds3_hsel      (ds3_hsel            ),
	.ds3_hrdata    (ds3_hrdata          ),
	.ds3_hreadyout (ds3_hreadyout       ),
	.ds3_hresp     (ds3_hresp[0]        ),
`endif
`ifdef ATCBUSDEC200_SLV4_SUPPORT
	.ds4_hsel      (ds4_hsel            ),
	.ds4_hrdata    (ds4_hrdata          ),
	.ds4_hreadyout (ds4_hreadyout       ),
	.ds4_hresp     (ds4_hresp[0]        ),
`endif
`ifdef ATCBUSDEC200_SLV5_SUPPORT
	.ds5_hsel      (            ),
	.ds5_hrdata    ({(DATA_MSB+1){1'b0}}),
	.ds5_hreadyout (1'b1                ),
	.ds5_hresp     (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV6_SUPPORT
	.ds6_hsel      (            ),
	.ds6_hrdata    ({(DATA_MSB+1){1'b0}}),
	.ds6_hreadyout (1'b1                ),
	.ds6_hresp     (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV7_SUPPORT
	.ds7_hsel      (            ),
	.ds7_hrdata    ({(DATA_MSB+1){1'b0}}),
	.ds7_hreadyout (1'b1                ),
	.ds7_hresp     (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV8_SUPPORT
	.ds8_hsel      (            ),
	.ds8_hrdata    ({(DATA_MSB+1){1'b0}}),
	.ds8_hreadyout (1'b1                ),
	.ds8_hresp     (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV9_SUPPORT
	.ds9_hsel      (            ),
	.ds9_hrdata    ({(DATA_MSB+1){1'b0}}),
	.ds9_hreadyout (1'b1                ),
	.ds9_hresp     (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV10_SUPPORT
	.ds10_hsel     (            ),
	.ds10_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds10_hreadyout(1'b1                ),
	.ds10_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV11_SUPPORT
	.ds11_hsel     (            ),
	.ds11_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds11_hreadyout(1'b1                ),
	.ds11_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV12_SUPPORT
	.ds12_hsel     (            ),
	.ds12_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds12_hreadyout(1'b1                ),
	.ds12_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV13_SUPPORT
	.ds13_hsel     (            ),
	.ds13_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds13_hreadyout(1'b1                ),
	.ds13_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV14_SUPPORT
	.ds14_hsel     (            ),
	.ds14_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds14_hreadyout(1'b1                ),
	.ds14_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV15_SUPPORT
	.ds15_hsel     (            ),
	.ds15_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds15_hreadyout(1'b1                ),
	.ds15_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV16_SUPPORT
	.ds16_hsel     (            ),
	.ds16_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds16_hreadyout(1'b1                ),
	.ds16_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV17_SUPPORT
	.ds17_hsel     (            ),
	.ds17_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds17_hreadyout(1'b1                ),
	.ds17_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV18_SUPPORT
	.ds18_hsel     (            ),
	.ds18_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds18_hreadyout(1'b1                ),
	.ds18_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV19_SUPPORT
	.ds19_hsel     (            ),
	.ds19_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds19_hreadyout(1'b1                ),
	.ds19_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV20_SUPPORT
	.ds20_hsel     (            ),
	.ds20_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds20_hreadyout(1'b1                ),
	.ds20_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV21_SUPPORT
	.ds21_hsel     (            ),
	.ds21_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds21_hreadyout(1'b1                ),
	.ds21_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV22_SUPPORT
	.ds22_hsel     (            ),
	.ds22_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds22_hreadyout(1'b1                ),
	.ds22_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV23_SUPPORT
	.ds23_hsel     (            ),
	.ds23_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds23_hreadyout(1'b1                ),
	.ds23_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV24_SUPPORT
	.ds24_hsel     (            ),
	.ds24_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds24_hreadyout(1'b1                ),
	.ds24_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV25_SUPPORT
	.ds25_hsel     (            ),
	.ds25_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds25_hreadyout(1'b1                ),
	.ds25_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV26_SUPPORT
	.ds26_hsel     (            ),
	.ds26_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds26_hreadyout(1'b1                ),
	.ds26_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV27_SUPPORT
	.ds27_hsel     (            ),
	.ds27_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds27_hreadyout(1'b1                ),
	.ds27_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV28_SUPPORT
	.ds28_hsel     (            ),
	.ds28_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds28_hreadyout(1'b1                ),
	.ds28_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV29_SUPPORT
	.ds29_hsel     (            ),
	.ds29_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds29_hreadyout(1'b1                ),
	.ds29_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV30_SUPPORT
	.ds30_hsel     (            ),
	.ds30_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds30_hreadyout(1'b1                ),
	.ds30_hresp    (1'b0                ),
`endif
`ifdef ATCBUSDEC200_SLV31_SUPPORT
	.ds31_hsel     (            ),
	.ds31_hrdata   ({(DATA_MSB+1){1'b0}}),
	.ds31_hreadyout(1'b1                ),
	.ds31_hresp    (1'b0                ),
`endif
	.hclk          (hclk                ),
	.hresetn       (hresetn             ),
	.us_haddr      (hbmc_haddr          ),
	.us_hsel       (hbmc_hsel           ),
	.us_htrans     (hbmc_htrans         ),
	.us_hrdata     (hbmc_hrdata         ),
	.us_hready     (hbmc_hready         ),
	.us_hreadyout  (hbmc_hreadyout      ),
	.us_hresp      (hbmc_hresp_1bit     ),
	.ds_hready     (ds_hready           )
);




endmodule
