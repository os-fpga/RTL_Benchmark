// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcbmc200_config.vh"
`include "atcbmc200_const.vh"


module atcbmc200 (
`ifdef ATCBMC200_AHB_MST0
	  hm0_haddr,
	  hm0_hburst,
	  hm0_hprot,
	  hm0_hrdata,
	  hm0_hready,
	  hm0_hresp,
	  hm0_hsize,
	  hm0_htrans,
	  hm0_hwrite,
	  hm0_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST1
	  hm1_haddr,
	  hm1_hburst,
	  hm1_hprot,
	  hm1_hrdata,
	  hm1_hready,
	  hm1_hresp,
	  hm1_hsize,
	  hm1_htrans,
	  hm1_hwrite,
	  hm1_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST2
	  hm2_haddr,
	  hm2_hburst,
	  hm2_hprot,
	  hm2_hrdata,
	  hm2_hready,
	  hm2_hresp,
	  hm2_hsize,
	  hm2_htrans,
	  hm2_hwrite,
	  hm2_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST3
	  hm3_haddr,
	  hm3_hburst,
	  hm3_hprot,
	  hm3_hrdata,
	  hm3_hready,
	  hm3_hresp,
	  hm3_hsize,
	  hm3_htrans,
	  hm3_hwrite,
	  hm3_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST4
	  hm4_haddr,
	  hm4_hburst,
	  hm4_hprot,
	  hm4_hrdata,
	  hm4_hready,
	  hm4_hresp,
	  hm4_hsize,
	  hm4_htrans,
	  hm4_hwrite,
	  hm4_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST5
	  hm5_haddr,
	  hm5_hburst,
	  hm5_hprot,
	  hm5_hrdata,
	  hm5_hready,
	  hm5_hresp,
	  hm5_hsize,
	  hm5_htrans,
	  hm5_hwrite,
	  hm5_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST6
	  hm6_haddr,
	  hm6_hburst,
	  hm6_hprot,
	  hm6_hrdata,
	  hm6_hready,
	  hm6_hresp,
	  hm6_hsize,
	  hm6_htrans,
	  hm6_hwrite,
	  hm6_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST7
	  hm7_haddr,
	  hm7_hburst,
	  hm7_hprot,
	  hm7_hrdata,
	  hm7_hready,
	  hm7_hresp,
	  hm7_hsize,
	  hm7_htrans,
	  hm7_hwrite,
	  hm7_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST8
	  hm8_haddr,
	  hm8_hburst,
	  hm8_hprot,
	  hm8_hrdata,
	  hm8_hready,
	  hm8_hresp,
	  hm8_hsize,
	  hm8_htrans,
	  hm8_hwrite,
	  hm8_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST9
	  hm9_haddr,
	  hm9_hburst,
	  hm9_hprot,
	  hm9_hrdata,
	  hm9_hready,
	  hm9_hresp,
	  hm9_hsize,
	  hm9_htrans,
	  hm9_hwrite,
	  hm9_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST10
	  hm10_haddr,
	  hm10_hburst,
	  hm10_hprot,
	  hm10_hrdata,
	  hm10_hready,
	  hm10_hresp,
	  hm10_hsize,
	  hm10_htrans,
	  hm10_hwrite,
	  hm10_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST11
	  hm11_haddr,
	  hm11_hburst,
	  hm11_hprot,
	  hm11_hrdata,
	  hm11_hready,
	  hm11_hresp,
	  hm11_hsize,
	  hm11_htrans,
	  hm11_hwrite,
	  hm11_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST12
	  hm12_haddr,
	  hm12_hburst,
	  hm12_hprot,
	  hm12_hrdata,
	  hm12_hready,
	  hm12_hresp,
	  hm12_hsize,
	  hm12_htrans,
	  hm12_hwrite,
	  hm12_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST13
	  hm13_haddr,
	  hm13_hburst,
	  hm13_hprot,
	  hm13_hrdata,
	  hm13_hready,
	  hm13_hresp,
	  hm13_hsize,
	  hm13_htrans,
	  hm13_hwrite,
	  hm13_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST14
	  hm14_haddr,
	  hm14_hburst,
	  hm14_hprot,
	  hm14_hrdata,
	  hm14_hready,
	  hm14_hresp,
	  hm14_hsize,
	  hm14_htrans,
	  hm14_hwrite,
	  hm14_hwdata,
`endif
`ifdef ATCBMC200_AHB_MST15
	  hm15_haddr,
	  hm15_hburst,
	  hm15_hprot,
	  hm15_hrdata,
	  hm15_hready,
	  hm15_hresp,
	  hm15_hsize,
	  hm15_htrans,
	  hm15_hwrite,
	  hm15_hwdata,
`endif
`ifdef ATCBMC200_AHB_SLV1
	  hs1_hrdata,
	  hs1_bmc_hready,
	  hs1_hresp,
	  bmc_hs1_hready,
	  hs1_haddr,
	  hs1_hburst,
	  hs1_hprot,
	  hs1_hsel,
	  hs1_hsize,
	  hs1_htrans,
	  hs1_hwdata,
	  hs1_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV2
	  hs2_hrdata,
	  hs2_bmc_hready,
	  hs2_hresp,
	  bmc_hs2_hready,
	  hs2_haddr,
	  hs2_hburst,
	  hs2_hprot,
	  hs2_hsel,
	  hs2_hsize,
	  hs2_htrans,
	  hs2_hwdata,
	  hs2_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV3
	  hs3_hrdata,
	  hs3_bmc_hready,
	  hs3_hresp,
	  bmc_hs3_hready,
	  hs3_haddr,
	  hs3_hburst,
	  hs3_hprot,
	  hs3_hsel,
	  hs3_hsize,
	  hs3_htrans,
	  hs3_hwdata,
	  hs3_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV4
	  hs4_hrdata,
	  hs4_bmc_hready,
	  hs4_hresp,
	  bmc_hs4_hready,
	  hs4_haddr,
	  hs4_hburst,
	  hs4_hprot,
	  hs4_hsel,
	  hs4_hsize,
	  hs4_htrans,
	  hs4_hwdata,
	  hs4_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV5
	  hs5_hrdata,
	  hs5_bmc_hready,
	  hs5_hresp,
	  bmc_hs5_hready,
	  hs5_haddr,
	  hs5_hburst,
	  hs5_hprot,
	  hs5_hsel,
	  hs5_hsize,
	  hs5_htrans,
	  hs5_hwdata,
	  hs5_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV6
	  hs6_hrdata,
	  hs6_bmc_hready,
	  hs6_hresp,
	  bmc_hs6_hready,
	  hs6_haddr,
	  hs6_hburst,
	  hs6_hprot,
	  hs6_hsel,
	  hs6_hsize,
	  hs6_htrans,
	  hs6_hwdata,
	  hs6_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV7
	  hs7_hrdata,
	  hs7_bmc_hready,
	  hs7_hresp,
	  bmc_hs7_hready,
	  hs7_haddr,
	  hs7_hburst,
	  hs7_hprot,
	  hs7_hsel,
	  hs7_hsize,
	  hs7_htrans,
	  hs7_hwdata,
	  hs7_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV8
	  hs8_hrdata,
	  hs8_bmc_hready,
	  hs8_hresp,
	  bmc_hs8_hready,
	  hs8_haddr,
	  hs8_hburst,
	  hs8_hprot,
	  hs8_hsel,
	  hs8_hsize,
	  hs8_htrans,
	  hs8_hwdata,
	  hs8_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV9
	  hs9_hrdata,
	  hs9_bmc_hready,
	  hs9_hresp,
	  bmc_hs9_hready,
	  hs9_haddr,
	  hs9_hburst,
	  hs9_hprot,
	  hs9_hsel,
	  hs9_hsize,
	  hs9_htrans,
	  hs9_hwdata,
	  hs9_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV10
	  hs10_hrdata,
	  hs10_bmc_hready,
	  hs10_hresp,
	  bmc_hs10_hready,
	  hs10_haddr,
	  hs10_hburst,
	  hs10_hprot,
	  hs10_hsel,
	  hs10_hsize,
	  hs10_htrans,
	  hs10_hwdata,
	  hs10_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV11
	  hs11_hrdata,
	  hs11_bmc_hready,
	  hs11_hresp,
	  bmc_hs11_hready,
	  hs11_haddr,
	  hs11_hburst,
	  hs11_hprot,
	  hs11_hsel,
	  hs11_hsize,
	  hs11_htrans,
	  hs11_hwdata,
	  hs11_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV12
	  hs12_hrdata,
	  hs12_bmc_hready,
	  hs12_hresp,
	  bmc_hs12_hready,
	  hs12_haddr,
	  hs12_hburst,
	  hs12_hprot,
	  hs12_hsel,
	  hs12_hsize,
	  hs12_htrans,
	  hs12_hwdata,
	  hs12_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV13
	  hs13_hrdata,
	  hs13_bmc_hready,
	  hs13_hresp,
	  bmc_hs13_hready,
	  hs13_haddr,
	  hs13_hburst,
	  hs13_hprot,
	  hs13_hsel,
	  hs13_hsize,
	  hs13_htrans,
	  hs13_hwdata,
	  hs13_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV14
	  hs14_hrdata,
	  hs14_bmc_hready,
	  hs14_hresp,
	  bmc_hs14_hready,
	  hs14_haddr,
	  hs14_hburst,
	  hs14_hprot,
	  hs14_hsel,
	  hs14_hsize,
	  hs14_htrans,
	  hs14_hwdata,
	  hs14_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV15
	  hs15_hrdata,
	  hs15_bmc_hready,
	  hs15_hresp,
	  bmc_hs15_hready,
	  hs15_haddr,
	  hs15_hburst,
	  hs15_hprot,
	  hs15_hsel,
	  hs15_hsize,
	  hs15_htrans,
	  hs15_hwdata,
	  hs15_hwrite,
`endif
`ifdef ATCBMC200_EXT_ENABLE
	  ahb_slv10_en,
	  ahb_slv1_en,
	  ahb_slv2_en,
	  ahb_slv3_en,
	  ahb_slv4_en,
	  ahb_slv5_en,
	  ahb_slv6_en,
	  ahb_slv7_en,
	  ahb_slv8_en,
	  ahb_slv9_en,
`endif
	  hclk,
	  hresetn,
	  bmc_intr
);

`ifdef ATCBMC200_ADDR_MSB
parameter ADDR_WIDTH = `ATCBMC200_ADDR_MSB + 1;
`else
parameter ADDR_WIDTH = 32;
`endif
`ifdef ATCBMC200_DATA_WIDTH
parameter DATA_WIDTH = `ATCBMC200_DATA_WIDTH;
`else
parameter DATA_WIDTH = 64;
`endif

localparam BASE_ADDR_LSB = (ADDR_WIDTH == 24) ? 10 : 20;
localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;

`ifdef ATCBMC200_AHB_MST0
input       [ADDR_MSB:0] hm0_haddr;
input              [2:0] hm0_hburst;
input              [3:0] hm0_hprot;
output      [DATA_MSB:0] hm0_hrdata;
output                   hm0_hready;
output             [1:0] hm0_hresp;
input              [2:0] hm0_hsize;
input              [1:0] hm0_htrans;
input                    hm0_hwrite;
input       [DATA_MSB:0] hm0_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST1
input       [ADDR_MSB:0] hm1_haddr;
input              [2:0] hm1_hburst;
input              [3:0] hm1_hprot;
output      [DATA_MSB:0] hm1_hrdata;
output                   hm1_hready;
output             [1:0] hm1_hresp;
input              [2:0] hm1_hsize;
input              [1:0] hm1_htrans;
input                    hm1_hwrite;
input       [DATA_MSB:0] hm1_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST2
input       [ADDR_MSB:0] hm2_haddr;
input              [2:0] hm2_hburst;
input              [3:0] hm2_hprot;
output      [DATA_MSB:0] hm2_hrdata;
output                   hm2_hready;
output             [1:0] hm2_hresp;
input              [2:0] hm2_hsize;
input              [1:0] hm2_htrans;
input                    hm2_hwrite;
input       [DATA_MSB:0] hm2_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST3
input       [ADDR_MSB:0] hm3_haddr;
input              [2:0] hm3_hburst;
input              [3:0] hm3_hprot;
output      [DATA_MSB:0] hm3_hrdata;
output                   hm3_hready;
output             [1:0] hm3_hresp;
input              [2:0] hm3_hsize;
input              [1:0] hm3_htrans;
input                    hm3_hwrite;
input       [DATA_MSB:0] hm3_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST4
input       [ADDR_MSB:0] hm4_haddr;
input              [2:0] hm4_hburst;
input              [3:0] hm4_hprot;
output      [DATA_MSB:0] hm4_hrdata;
output                   hm4_hready;
output             [1:0] hm4_hresp;
input              [2:0] hm4_hsize;
input              [1:0] hm4_htrans;
input                    hm4_hwrite;
input       [DATA_MSB:0] hm4_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST5
input       [ADDR_MSB:0] hm5_haddr;
input              [2:0] hm5_hburst;
input              [3:0] hm5_hprot;
output      [DATA_MSB:0] hm5_hrdata;
output                   hm5_hready;
output             [1:0] hm5_hresp;
input              [2:0] hm5_hsize;
input              [1:0] hm5_htrans;
input                    hm5_hwrite;
input       [DATA_MSB:0] hm5_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST6
input       [ADDR_MSB:0] hm6_haddr;
input              [2:0] hm6_hburst;
input              [3:0] hm6_hprot;
output      [DATA_MSB:0] hm6_hrdata;
output                   hm6_hready;
output             [1:0] hm6_hresp;
input              [2:0] hm6_hsize;
input              [1:0] hm6_htrans;
input                    hm6_hwrite;
input       [DATA_MSB:0] hm6_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST7
input       [ADDR_MSB:0] hm7_haddr;
input              [2:0] hm7_hburst;
input              [3:0] hm7_hprot;
output      [DATA_MSB:0] hm7_hrdata;
output                   hm7_hready;
output             [1:0] hm7_hresp;
input              [2:0] hm7_hsize;
input              [1:0] hm7_htrans;
input                    hm7_hwrite;
input       [DATA_MSB:0] hm7_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST8
input       [ADDR_MSB:0] hm8_haddr;
input              [2:0] hm8_hburst;
input              [3:0] hm8_hprot;
output      [DATA_MSB:0] hm8_hrdata;
output                   hm8_hready;
output             [1:0] hm8_hresp;
input              [2:0] hm8_hsize;
input              [1:0] hm8_htrans;
input                    hm8_hwrite;
input       [DATA_MSB:0] hm8_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST9
input       [ADDR_MSB:0] hm9_haddr;
input              [2:0] hm9_hburst;
input              [3:0] hm9_hprot;
output      [DATA_MSB:0] hm9_hrdata;
output                   hm9_hready;
output             [1:0] hm9_hresp;
input              [2:0] hm9_hsize;
input              [1:0] hm9_htrans;
input                    hm9_hwrite;
input       [DATA_MSB:0] hm9_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST10
input       [ADDR_MSB:0] hm10_haddr;
input              [2:0] hm10_hburst;
input              [3:0] hm10_hprot;
output      [DATA_MSB:0] hm10_hrdata;
output                   hm10_hready;
output             [1:0] hm10_hresp;
input              [2:0] hm10_hsize;
input              [1:0] hm10_htrans;
input                    hm10_hwrite;
input       [DATA_MSB:0] hm10_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST11
input       [ADDR_MSB:0] hm11_haddr;
input              [2:0] hm11_hburst;
input              [3:0] hm11_hprot;
output      [DATA_MSB:0] hm11_hrdata;
output                   hm11_hready;
output             [1:0] hm11_hresp;
input              [2:0] hm11_hsize;
input              [1:0] hm11_htrans;
input                    hm11_hwrite;
input       [DATA_MSB:0] hm11_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST12
input       [ADDR_MSB:0] hm12_haddr;
input              [2:0] hm12_hburst;
input              [3:0] hm12_hprot;
output      [DATA_MSB:0] hm12_hrdata;
output                   hm12_hready;
output             [1:0] hm12_hresp;
input              [2:0] hm12_hsize;
input              [1:0] hm12_htrans;
input                    hm12_hwrite;
input       [DATA_MSB:0] hm12_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST13
input       [ADDR_MSB:0] hm13_haddr;
input              [2:0] hm13_hburst;
input              [3:0] hm13_hprot;
output      [DATA_MSB:0] hm13_hrdata;
output                   hm13_hready;
output             [1:0] hm13_hresp;
input              [2:0] hm13_hsize;
input              [1:0] hm13_htrans;
input                    hm13_hwrite;
input       [DATA_MSB:0] hm13_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST14
input       [ADDR_MSB:0] hm14_haddr;
input              [2:0] hm14_hburst;
input              [3:0] hm14_hprot;
output      [DATA_MSB:0] hm14_hrdata;
output                   hm14_hready;
output             [1:0] hm14_hresp;
input              [2:0] hm14_hsize;
input              [1:0] hm14_htrans;
input                    hm14_hwrite;
input       [DATA_MSB:0] hm14_hwdata;
`endif
`ifdef ATCBMC200_AHB_MST15
input       [ADDR_MSB:0] hm15_haddr;
input              [2:0] hm15_hburst;
input              [3:0] hm15_hprot;
output      [DATA_MSB:0] hm15_hrdata;
output                   hm15_hready;
output             [1:0] hm15_hresp;
input              [2:0] hm15_hsize;
input              [1:0] hm15_htrans;
input                    hm15_hwrite;
input       [DATA_MSB:0] hm15_hwdata;
`endif
`ifdef ATCBMC200_AHB_SLV1
input       [DATA_MSB:0] hs1_hrdata;
input                    hs1_bmc_hready;
input              [1:0] hs1_hresp;
output                   bmc_hs1_hready;
output      [ADDR_MSB:0] hs1_haddr;
output             [2:0] hs1_hburst;
output             [3:0] hs1_hprot;
output                   hs1_hsel;
output             [2:0] hs1_hsize;
output             [1:0] hs1_htrans;
output      [DATA_MSB:0] hs1_hwdata;
output                   hs1_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV2
input       [DATA_MSB:0] hs2_hrdata;
input                    hs2_bmc_hready;
input              [1:0] hs2_hresp;
output                   bmc_hs2_hready;
output      [ADDR_MSB:0] hs2_haddr;
output             [2:0] hs2_hburst;
output             [3:0] hs2_hprot;
output                   hs2_hsel;
output             [2:0] hs2_hsize;
output             [1:0] hs2_htrans;
output      [DATA_MSB:0] hs2_hwdata;
output                   hs2_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV3
input       [DATA_MSB:0] hs3_hrdata;
input                    hs3_bmc_hready;
input              [1:0] hs3_hresp;
output                   bmc_hs3_hready;
output      [ADDR_MSB:0] hs3_haddr;
output             [2:0] hs3_hburst;
output             [3:0] hs3_hprot;
output                   hs3_hsel;
output             [2:0] hs3_hsize;
output             [1:0] hs3_htrans;
output      [DATA_MSB:0] hs3_hwdata;
output                   hs3_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV4
input       [DATA_MSB:0] hs4_hrdata;
input                    hs4_bmc_hready;
input              [1:0] hs4_hresp;
output                   bmc_hs4_hready;
output      [ADDR_MSB:0] hs4_haddr;
output             [2:0] hs4_hburst;
output             [3:0] hs4_hprot;
output                   hs4_hsel;
output             [2:0] hs4_hsize;
output             [1:0] hs4_htrans;
output      [DATA_MSB:0] hs4_hwdata;
output                   hs4_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV5
input       [DATA_MSB:0] hs5_hrdata;
input                    hs5_bmc_hready;
input              [1:0] hs5_hresp;
output                   bmc_hs5_hready;
output      [ADDR_MSB:0] hs5_haddr;
output             [2:0] hs5_hburst;
output             [3:0] hs5_hprot;
output                   hs5_hsel;
output             [2:0] hs5_hsize;
output             [1:0] hs5_htrans;
output      [DATA_MSB:0] hs5_hwdata;
output                   hs5_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV6
input       [DATA_MSB:0] hs6_hrdata;
input                    hs6_bmc_hready;
input              [1:0] hs6_hresp;
output                   bmc_hs6_hready;
output      [ADDR_MSB:0] hs6_haddr;
output             [2:0] hs6_hburst;
output             [3:0] hs6_hprot;
output                   hs6_hsel;
output             [2:0] hs6_hsize;
output             [1:0] hs6_htrans;
output      [DATA_MSB:0] hs6_hwdata;
output                   hs6_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV7
input       [DATA_MSB:0] hs7_hrdata;
input                    hs7_bmc_hready;
input              [1:0] hs7_hresp;
output                   bmc_hs7_hready;
output      [ADDR_MSB:0] hs7_haddr;
output             [2:0] hs7_hburst;
output             [3:0] hs7_hprot;
output                   hs7_hsel;
output             [2:0] hs7_hsize;
output             [1:0] hs7_htrans;
output      [DATA_MSB:0] hs7_hwdata;
output                   hs7_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV8
input       [DATA_MSB:0] hs8_hrdata;
input                    hs8_bmc_hready;
input              [1:0] hs8_hresp;
output                   bmc_hs8_hready;
output      [ADDR_MSB:0] hs8_haddr;
output             [2:0] hs8_hburst;
output             [3:0] hs8_hprot;
output                   hs8_hsel;
output             [2:0] hs8_hsize;
output             [1:0] hs8_htrans;
output      [DATA_MSB:0] hs8_hwdata;
output                   hs8_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV9
input       [DATA_MSB:0] hs9_hrdata;
input                    hs9_bmc_hready;
input              [1:0] hs9_hresp;
output                   bmc_hs9_hready;
output      [ADDR_MSB:0] hs9_haddr;
output             [2:0] hs9_hburst;
output             [3:0] hs9_hprot;
output                   hs9_hsel;
output             [2:0] hs9_hsize;
output             [1:0] hs9_htrans;
output      [DATA_MSB:0] hs9_hwdata;
output                   hs9_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV10
input       [DATA_MSB:0] hs10_hrdata;
input                    hs10_bmc_hready;
input              [1:0] hs10_hresp;
output                   bmc_hs10_hready;
output      [ADDR_MSB:0] hs10_haddr;
output             [2:0] hs10_hburst;
output             [3:0] hs10_hprot;
output                   hs10_hsel;
output             [2:0] hs10_hsize;
output             [1:0] hs10_htrans;
output      [DATA_MSB:0] hs10_hwdata;
output                   hs10_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV11
input       [DATA_MSB:0] hs11_hrdata;
input                    hs11_bmc_hready;
input              [1:0] hs11_hresp;
output                   bmc_hs11_hready;
output      [ADDR_MSB:0] hs11_haddr;
output             [2:0] hs11_hburst;
output             [3:0] hs11_hprot;
output                   hs11_hsel;
output             [2:0] hs11_hsize;
output             [1:0] hs11_htrans;
output      [DATA_MSB:0] hs11_hwdata;
output                   hs11_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV12
input       [DATA_MSB:0] hs12_hrdata;
input                    hs12_bmc_hready;
input              [1:0] hs12_hresp;
output                   bmc_hs12_hready;
output      [ADDR_MSB:0] hs12_haddr;
output             [2:0] hs12_hburst;
output             [3:0] hs12_hprot;
output                   hs12_hsel;
output             [2:0] hs12_hsize;
output             [1:0] hs12_htrans;
output      [DATA_MSB:0] hs12_hwdata;
output                   hs12_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV13
input       [DATA_MSB:0] hs13_hrdata;
input                    hs13_bmc_hready;
input              [1:0] hs13_hresp;
output                   bmc_hs13_hready;
output      [ADDR_MSB:0] hs13_haddr;
output             [2:0] hs13_hburst;
output             [3:0] hs13_hprot;
output                   hs13_hsel;
output             [2:0] hs13_hsize;
output             [1:0] hs13_htrans;
output      [DATA_MSB:0] hs13_hwdata;
output                   hs13_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV14
input       [DATA_MSB:0] hs14_hrdata;
input                    hs14_bmc_hready;
input              [1:0] hs14_hresp;
output                   bmc_hs14_hready;
output      [ADDR_MSB:0] hs14_haddr;
output             [2:0] hs14_hburst;
output             [3:0] hs14_hprot;
output                   hs14_hsel;
output             [2:0] hs14_hsize;
output             [1:0] hs14_htrans;
output      [DATA_MSB:0] hs14_hwdata;
output                   hs14_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV15
input       [DATA_MSB:0] hs15_hrdata;
input                    hs15_bmc_hready;
input              [1:0] hs15_hresp;
output                   bmc_hs15_hready;
output      [ADDR_MSB:0] hs15_haddr;
output             [2:0] hs15_hburst;
output             [3:0] hs15_hprot;
output                   hs15_hsel;
output             [2:0] hs15_hsize;
output             [1:0] hs15_htrans;
output      [DATA_MSB:0] hs15_hwdata;
output                   hs15_hwrite;
`endif
`ifdef ATCBMC200_EXT_ENABLE
input                    ahb_slv10_en;
input                    ahb_slv1_en;
input                    ahb_slv2_en;
input                    ahb_slv3_en;
input                    ahb_slv4_en;
input                    ahb_slv5_en;
input                    ahb_slv6_en;
input                    ahb_slv7_en;
input                    ahb_slv8_en;
input                    ahb_slv9_en;
`endif
input                    hclk;
input                    hresetn;
output                   bmc_intr;

`ifdef ATCBMC200_AHB_MST0
wire                    [ADDR_MSB:0] mst0_haddr;
wire                           [2:0] mst0_hburst;
wire                           [3:0] mst0_hprot;
wire                           [2:0] mst0_hsize;
wire                           [1:0] mst0_htrans;
wire                                 mst0_hwrite;
wire                                 mst0_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST1
wire                    [ADDR_MSB:0] mst1_haddr;
wire                           [2:0] mst1_hburst;
wire                           [3:0] mst1_hprot;
wire                           [2:0] mst1_hsize;
wire                           [1:0] mst1_htrans;
wire                                 mst1_hwrite;
wire                                 mst1_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST2
wire                    [ADDR_MSB:0] mst2_haddr;
wire                           [2:0] mst2_hburst;
wire                           [3:0] mst2_hprot;
wire                           [2:0] mst2_hsize;
wire                           [1:0] mst2_htrans;
wire                                 mst2_hwrite;
wire                                 mst2_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST3
wire                    [ADDR_MSB:0] mst3_haddr;
wire                           [2:0] mst3_hburst;
wire                           [3:0] mst3_hprot;
wire                           [2:0] mst3_hsize;
wire                           [1:0] mst3_htrans;
wire                                 mst3_hwrite;
wire                                 mst3_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST4
wire                    [ADDR_MSB:0] mst4_haddr;
wire                           [2:0] mst4_hburst;
wire                           [3:0] mst4_hprot;
wire                           [2:0] mst4_hsize;
wire                           [1:0] mst4_htrans;
wire                                 mst4_hwrite;
wire                                 mst4_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST5
wire                    [ADDR_MSB:0] mst5_haddr;
wire                           [2:0] mst5_hburst;
wire                           [3:0] mst5_hprot;
wire                           [2:0] mst5_hsize;
wire                           [1:0] mst5_htrans;
wire                                 mst5_hwrite;
wire                                 mst5_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST6
wire                    [ADDR_MSB:0] mst6_haddr;
wire                           [2:0] mst6_hburst;
wire                           [3:0] mst6_hprot;
wire                           [2:0] mst6_hsize;
wire                           [1:0] mst6_htrans;
wire                                 mst6_hwrite;
wire                                 mst6_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST7
wire                    [ADDR_MSB:0] mst7_haddr;
wire                           [2:0] mst7_hburst;
wire                           [3:0] mst7_hprot;
wire                           [2:0] mst7_hsize;
wire                           [1:0] mst7_htrans;
wire                                 mst7_hwrite;
wire                                 mst7_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST8
wire                    [ADDR_MSB:0] mst8_haddr;
wire                           [2:0] mst8_hburst;
wire                           [3:0] mst8_hprot;
wire                           [2:0] mst8_hsize;
wire                           [1:0] mst8_htrans;
wire                                 mst8_hwrite;
wire                                 mst8_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST9
wire                    [ADDR_MSB:0] mst9_haddr;
wire                           [2:0] mst9_hburst;
wire                           [3:0] mst9_hprot;
wire                           [2:0] mst9_hsize;
wire                           [1:0] mst9_htrans;
wire                                 mst9_hwrite;
wire                                 mst9_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST10
wire                    [ADDR_MSB:0] mst10_haddr;
wire                           [2:0] mst10_hburst;
wire                           [3:0] mst10_hprot;
wire                           [2:0] mst10_hsize;
wire                           [1:0] mst10_htrans;
wire                                 mst10_hwrite;
wire                                 mst10_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST11
wire                    [ADDR_MSB:0] mst11_haddr;
wire                           [2:0] mst11_hburst;
wire                           [3:0] mst11_hprot;
wire                           [2:0] mst11_hsize;
wire                           [1:0] mst11_htrans;
wire                                 mst11_hwrite;
wire                                 mst11_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST12
wire                    [ADDR_MSB:0] mst12_haddr;
wire                           [2:0] mst12_hburst;
wire                           [3:0] mst12_hprot;
wire                           [2:0] mst12_hsize;
wire                           [1:0] mst12_htrans;
wire                                 mst12_hwrite;
wire                                 mst12_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST13
wire                    [ADDR_MSB:0] mst13_haddr;
wire                           [2:0] mst13_hburst;
wire                           [3:0] mst13_hprot;
wire                           [2:0] mst13_hsize;
wire                           [1:0] mst13_htrans;
wire                                 mst13_hwrite;
wire                                 mst13_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST14
wire                    [ADDR_MSB:0] mst14_haddr;
wire                           [2:0] mst14_hburst;
wire                           [3:0] mst14_hprot;
wire                           [2:0] mst14_hsize;
wire                           [1:0] mst14_htrans;
wire                                 mst14_hwrite;
wire                                 mst14_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST15
wire                    [ADDR_MSB:0] mst15_haddr;
wire                           [2:0] mst15_hburst;
wire                           [3:0] mst15_hprot;
wire                           [2:0] mst15_hsize;
wire                           [1:0] mst15_htrans;
wire                                 mst15_hwrite;
wire                                 mst15_sel_err;
`endif
`ifdef ATCBMC200_AHB_SLV1
wire        [ADDR_MSB:BASE_ADDR_LSB] slv1_base;
wire                           [3:0] slv1_size;
`endif
`ifdef ATCBMC200_AHB_SLV2
wire        [ADDR_MSB:BASE_ADDR_LSB] slv2_base;
wire                           [3:0] slv2_size;
`endif
`ifdef ATCBMC200_AHB_SLV3
wire        [ADDR_MSB:BASE_ADDR_LSB] slv3_base;
wire                           [3:0] slv3_size;
`endif
`ifdef ATCBMC200_AHB_SLV4
wire        [ADDR_MSB:BASE_ADDR_LSB] slv4_base;
wire                           [3:0] slv4_size;
`endif
`ifdef ATCBMC200_AHB_SLV5
wire        [ADDR_MSB:BASE_ADDR_LSB] slv5_base;
wire                           [3:0] slv5_size;
`endif
`ifdef ATCBMC200_AHB_SLV6
wire        [ADDR_MSB:BASE_ADDR_LSB] slv6_base;
wire                           [3:0] slv6_size;
`endif
`ifdef ATCBMC200_AHB_SLV7
wire        [ADDR_MSB:BASE_ADDR_LSB] slv7_base;
wire                           [3:0] slv7_size;
`endif
`ifdef ATCBMC200_AHB_SLV8
wire        [ADDR_MSB:BASE_ADDR_LSB] slv8_base;
wire                           [3:0] slv8_size;
`endif
`ifdef ATCBMC200_AHB_SLV9
wire        [ADDR_MSB:BASE_ADDR_LSB] slv9_base;
wire                           [3:0] slv9_size;
`endif
`ifdef ATCBMC200_AHB_SLV10
wire        [ADDR_MSB:BASE_ADDR_LSB] slv10_base;
wire                           [3:0] slv10_size;
`endif
`ifdef ATCBMC200_AHB_SLV11
wire        [ADDR_MSB:BASE_ADDR_LSB] slv11_base;
wire                           [3:0] slv11_size;
`endif
`ifdef ATCBMC200_AHB_SLV12
wire        [ADDR_MSB:BASE_ADDR_LSB] slv12_base;
wire                           [3:0] slv12_size;
`endif
`ifdef ATCBMC200_AHB_SLV13
wire        [ADDR_MSB:BASE_ADDR_LSB] slv13_base;
wire                           [3:0] slv13_size;
`endif
`ifdef ATCBMC200_AHB_SLV14
wire        [ADDR_MSB:BASE_ADDR_LSB] slv14_base;
wire                           [3:0] slv14_size;
`endif
`ifdef ATCBMC200_AHB_SLV15
wire        [ADDR_MSB:BASE_ADDR_LSB] slv15_base;
wire                           [3:0] slv15_size;
`endif
`ifdef ATCBMC200_AHB_MST0
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst0_slv1_sel;
wire                    [DATA_MSB:0] hm0_slv1_hwdata;
wire                    [DATA_MSB:0] mst0_hs1_hrdata;
wire                                 mst0_hs1_hready;
wire                           [1:0] mst0_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv1_base;
wire                                 mst0_slv1_grant;
wire                    [ADDR_MSB:0] mst0_slv1_haddr;
wire                           [2:0] mst0_slv1_hburst;
wire                           [3:0] mst0_slv1_hprot;
wire                           [2:0] mst0_slv1_hsize;
wire                           [1:0] mst0_slv1_htrans;
wire                                 mst0_slv1_hwrite;
wire                                 mst0_slv1_req;
wire                           [3:0] mst0_slv1_size;
wire                                 mst0_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst0_slv2_sel;
wire                    [DATA_MSB:0] hm0_slv2_hwdata;
wire                    [DATA_MSB:0] mst0_hs2_hrdata;
wire                                 mst0_hs2_hready;
wire                           [1:0] mst0_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv2_base;
wire                                 mst0_slv2_grant;
wire                    [ADDR_MSB:0] mst0_slv2_haddr;
wire                           [2:0] mst0_slv2_hburst;
wire                           [3:0] mst0_slv2_hprot;
wire                           [2:0] mst0_slv2_hsize;
wire                           [1:0] mst0_slv2_htrans;
wire                                 mst0_slv2_hwrite;
wire                                 mst0_slv2_req;
wire                           [3:0] mst0_slv2_size;
wire                                 mst0_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst0_slv3_sel;
wire                    [DATA_MSB:0] hm0_slv3_hwdata;
wire                    [DATA_MSB:0] mst0_hs3_hrdata;
wire                                 mst0_hs3_hready;
wire                           [1:0] mst0_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv3_base;
wire                                 mst0_slv3_grant;
wire                    [ADDR_MSB:0] mst0_slv3_haddr;
wire                           [2:0] mst0_slv3_hburst;
wire                           [3:0] mst0_slv3_hprot;
wire                           [2:0] mst0_slv3_hsize;
wire                           [1:0] mst0_slv3_htrans;
wire                                 mst0_slv3_hwrite;
wire                                 mst0_slv3_req;
wire                           [3:0] mst0_slv3_size;
wire                                 mst0_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst0_slv4_sel;
wire                    [DATA_MSB:0] hm0_slv4_hwdata;
wire                    [DATA_MSB:0] mst0_hs4_hrdata;
wire                                 mst0_hs4_hready;
wire                           [1:0] mst0_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv4_base;
wire                                 mst0_slv4_grant;
wire                    [ADDR_MSB:0] mst0_slv4_haddr;
wire                           [2:0] mst0_slv4_hburst;
wire                           [3:0] mst0_slv4_hprot;
wire                           [2:0] mst0_slv4_hsize;
wire                           [1:0] mst0_slv4_htrans;
wire                                 mst0_slv4_hwrite;
wire                                 mst0_slv4_req;
wire                           [3:0] mst0_slv4_size;
wire                                 mst0_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst0_slv5_sel;
wire                    [DATA_MSB:0] hm0_slv5_hwdata;
wire                    [DATA_MSB:0] mst0_hs5_hrdata;
wire                                 mst0_hs5_hready;
wire                           [1:0] mst0_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv5_base;
wire                                 mst0_slv5_grant;
wire                    [ADDR_MSB:0] mst0_slv5_haddr;
wire                           [2:0] mst0_slv5_hburst;
wire                           [3:0] mst0_slv5_hprot;
wire                           [2:0] mst0_slv5_hsize;
wire                           [1:0] mst0_slv5_htrans;
wire                                 mst0_slv5_hwrite;
wire                                 mst0_slv5_req;
wire                           [3:0] mst0_slv5_size;
wire                                 mst0_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst0_slv6_sel;
wire                    [DATA_MSB:0] hm0_slv6_hwdata;
wire                    [DATA_MSB:0] mst0_hs6_hrdata;
wire                                 mst0_hs6_hready;
wire                           [1:0] mst0_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv6_base;
wire                                 mst0_slv6_grant;
wire                    [ADDR_MSB:0] mst0_slv6_haddr;
wire                           [2:0] mst0_slv6_hburst;
wire                           [3:0] mst0_slv6_hprot;
wire                           [2:0] mst0_slv6_hsize;
wire                           [1:0] mst0_slv6_htrans;
wire                                 mst0_slv6_hwrite;
wire                                 mst0_slv6_req;
wire                           [3:0] mst0_slv6_size;
wire                                 mst0_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst0_slv7_sel;
wire                    [DATA_MSB:0] hm0_slv7_hwdata;
wire                    [DATA_MSB:0] mst0_hs7_hrdata;
wire                                 mst0_hs7_hready;
wire                           [1:0] mst0_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv7_base;
wire                                 mst0_slv7_grant;
wire                    [ADDR_MSB:0] mst0_slv7_haddr;
wire                           [2:0] mst0_slv7_hburst;
wire                           [3:0] mst0_slv7_hprot;
wire                           [2:0] mst0_slv7_hsize;
wire                           [1:0] mst0_slv7_htrans;
wire                                 mst0_slv7_hwrite;
wire                                 mst0_slv7_req;
wire                           [3:0] mst0_slv7_size;
wire                                 mst0_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst0_slv8_sel;
wire                    [DATA_MSB:0] hm0_slv8_hwdata;
wire                    [DATA_MSB:0] mst0_hs8_hrdata;
wire                                 mst0_hs8_hready;
wire                           [1:0] mst0_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv8_base;
wire                                 mst0_slv8_grant;
wire                    [ADDR_MSB:0] mst0_slv8_haddr;
wire                           [2:0] mst0_slv8_hburst;
wire                           [3:0] mst0_slv8_hprot;
wire                           [2:0] mst0_slv8_hsize;
wire                           [1:0] mst0_slv8_htrans;
wire                                 mst0_slv8_hwrite;
wire                                 mst0_slv8_req;
wire                           [3:0] mst0_slv8_size;
wire                                 mst0_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst0_slv9_sel;
wire                    [DATA_MSB:0] hm0_slv9_hwdata;
wire                    [DATA_MSB:0] mst0_hs9_hrdata;
wire                                 mst0_hs9_hready;
wire                           [1:0] mst0_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv9_base;
wire                                 mst0_slv9_grant;
wire                    [ADDR_MSB:0] mst0_slv9_haddr;
wire                           [2:0] mst0_slv9_hburst;
wire                           [3:0] mst0_slv9_hprot;
wire                           [2:0] mst0_slv9_hsize;
wire                           [1:0] mst0_slv9_htrans;
wire                                 mst0_slv9_hwrite;
wire                                 mst0_slv9_req;
wire                           [3:0] mst0_slv9_size;
wire                                 mst0_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst0_slv10_sel;
wire                    [DATA_MSB:0] hm0_slv10_hwdata;
wire                    [DATA_MSB:0] mst0_hs10_hrdata;
wire                                 mst0_hs10_hready;
wire                           [1:0] mst0_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv10_base;
wire                                 mst0_slv10_grant;
wire                    [ADDR_MSB:0] mst0_slv10_haddr;
wire                           [2:0] mst0_slv10_hburst;
wire                           [3:0] mst0_slv10_hprot;
wire                           [2:0] mst0_slv10_hsize;
wire                           [1:0] mst0_slv10_htrans;
wire                                 mst0_slv10_hwrite;
wire                                 mst0_slv10_req;
wire                           [3:0] mst0_slv10_size;
wire                                 mst0_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst0_slv11_sel;
wire                    [DATA_MSB:0] hm0_slv11_hwdata;
wire                    [DATA_MSB:0] mst0_hs11_hrdata;
wire                                 mst0_hs11_hready;
wire                           [1:0] mst0_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv11_base;
wire                                 mst0_slv11_grant;
wire                    [ADDR_MSB:0] mst0_slv11_haddr;
wire                           [2:0] mst0_slv11_hburst;
wire                           [3:0] mst0_slv11_hprot;
wire                           [2:0] mst0_slv11_hsize;
wire                           [1:0] mst0_slv11_htrans;
wire                                 mst0_slv11_hwrite;
wire                                 mst0_slv11_req;
wire                           [3:0] mst0_slv11_size;
wire                                 mst0_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst0_slv12_sel;
wire                    [DATA_MSB:0] hm0_slv12_hwdata;
wire                    [DATA_MSB:0] mst0_hs12_hrdata;
wire                                 mst0_hs12_hready;
wire                           [1:0] mst0_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv12_base;
wire                                 mst0_slv12_grant;
wire                    [ADDR_MSB:0] mst0_slv12_haddr;
wire                           [2:0] mst0_slv12_hburst;
wire                           [3:0] mst0_slv12_hprot;
wire                           [2:0] mst0_slv12_hsize;
wire                           [1:0] mst0_slv12_htrans;
wire                                 mst0_slv12_hwrite;
wire                                 mst0_slv12_req;
wire                           [3:0] mst0_slv12_size;
wire                                 mst0_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst0_slv13_sel;
wire                    [DATA_MSB:0] hm0_slv13_hwdata;
wire                    [DATA_MSB:0] mst0_hs13_hrdata;
wire                                 mst0_hs13_hready;
wire                           [1:0] mst0_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv13_base;
wire                                 mst0_slv13_grant;
wire                    [ADDR_MSB:0] mst0_slv13_haddr;
wire                           [2:0] mst0_slv13_hburst;
wire                           [3:0] mst0_slv13_hprot;
wire                           [2:0] mst0_slv13_hsize;
wire                           [1:0] mst0_slv13_htrans;
wire                                 mst0_slv13_hwrite;
wire                                 mst0_slv13_req;
wire                           [3:0] mst0_slv13_size;
wire                                 mst0_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst0_slv14_sel;
wire                    [DATA_MSB:0] hm0_slv14_hwdata;
wire                    [DATA_MSB:0] mst0_hs14_hrdata;
wire                                 mst0_hs14_hready;
wire                           [1:0] mst0_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv14_base;
wire                                 mst0_slv14_grant;
wire                    [ADDR_MSB:0] mst0_slv14_haddr;
wire                           [2:0] mst0_slv14_hburst;
wire                           [3:0] mst0_slv14_hprot;
wire                           [2:0] mst0_slv14_hsize;
wire                           [1:0] mst0_slv14_htrans;
wire                                 mst0_slv14_hwrite;
wire                                 mst0_slv14_req;
wire                           [3:0] mst0_slv14_size;
wire                                 mst0_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst0_slv15_sel;
wire                    [DATA_MSB:0] hm0_slv15_hwdata;
wire                    [DATA_MSB:0] mst0_hs15_hrdata;
wire                                 mst0_hs15_hready;
wire                           [1:0] mst0_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv15_base;
wire                                 mst0_slv15_grant;
wire                    [ADDR_MSB:0] mst0_slv15_haddr;
wire                           [2:0] mst0_slv15_hburst;
wire                           [3:0] mst0_slv15_hprot;
wire                           [2:0] mst0_slv15_hsize;
wire                           [1:0] mst0_slv15_htrans;
wire                                 mst0_slv15_hwrite;
wire                                 mst0_slv15_req;
wire                           [3:0] mst0_slv15_size;
wire                                 mst0_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst0_slv0_sel;
wire                    [DATA_MSB:0] hm0_slv0_hwdata;
wire                    [DATA_MSB:0] mst0_hs0_hrdata;
wire                                 mst0_hs0_hready;
wire                           [1:0] mst0_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst0_slv0_base;
wire                                 mst0_slv0_grant;
wire                    [ADDR_MSB:0] mst0_slv0_haddr;
wire                           [2:0] mst0_slv0_hburst;
wire                           [3:0] mst0_slv0_hprot;
wire                           [2:0] mst0_slv0_hsize;
wire                           [1:0] mst0_slv0_htrans;
wire                                 mst0_slv0_hwrite;
wire                                 mst0_slv0_req;
wire                           [3:0] mst0_slv0_size;
wire                                 mst0_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST1
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst1_slv1_sel;
wire                    [DATA_MSB:0] hm1_slv1_hwdata;
wire                    [DATA_MSB:0] mst1_hs1_hrdata;
wire                                 mst1_hs1_hready;
wire                           [1:0] mst1_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv1_base;
wire                                 mst1_slv1_grant;
wire                    [ADDR_MSB:0] mst1_slv1_haddr;
wire                           [2:0] mst1_slv1_hburst;
wire                           [3:0] mst1_slv1_hprot;
wire                           [2:0] mst1_slv1_hsize;
wire                           [1:0] mst1_slv1_htrans;
wire                                 mst1_slv1_hwrite;
wire                                 mst1_slv1_req;
wire                           [3:0] mst1_slv1_size;
wire                                 mst1_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst1_slv2_sel;
wire                    [DATA_MSB:0] hm1_slv2_hwdata;
wire                    [DATA_MSB:0] mst1_hs2_hrdata;
wire                                 mst1_hs2_hready;
wire                           [1:0] mst1_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv2_base;
wire                                 mst1_slv2_grant;
wire                    [ADDR_MSB:0] mst1_slv2_haddr;
wire                           [2:0] mst1_slv2_hburst;
wire                           [3:0] mst1_slv2_hprot;
wire                           [2:0] mst1_slv2_hsize;
wire                           [1:0] mst1_slv2_htrans;
wire                                 mst1_slv2_hwrite;
wire                                 mst1_slv2_req;
wire                           [3:0] mst1_slv2_size;
wire                                 mst1_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst1_slv3_sel;
wire                    [DATA_MSB:0] hm1_slv3_hwdata;
wire                    [DATA_MSB:0] mst1_hs3_hrdata;
wire                                 mst1_hs3_hready;
wire                           [1:0] mst1_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv3_base;
wire                                 mst1_slv3_grant;
wire                    [ADDR_MSB:0] mst1_slv3_haddr;
wire                           [2:0] mst1_slv3_hburst;
wire                           [3:0] mst1_slv3_hprot;
wire                           [2:0] mst1_slv3_hsize;
wire                           [1:0] mst1_slv3_htrans;
wire                                 mst1_slv3_hwrite;
wire                                 mst1_slv3_req;
wire                           [3:0] mst1_slv3_size;
wire                                 mst1_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst1_slv4_sel;
wire                    [DATA_MSB:0] hm1_slv4_hwdata;
wire                    [DATA_MSB:0] mst1_hs4_hrdata;
wire                                 mst1_hs4_hready;
wire                           [1:0] mst1_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv4_base;
wire                                 mst1_slv4_grant;
wire                    [ADDR_MSB:0] mst1_slv4_haddr;
wire                           [2:0] mst1_slv4_hburst;
wire                           [3:0] mst1_slv4_hprot;
wire                           [2:0] mst1_slv4_hsize;
wire                           [1:0] mst1_slv4_htrans;
wire                                 mst1_slv4_hwrite;
wire                                 mst1_slv4_req;
wire                           [3:0] mst1_slv4_size;
wire                                 mst1_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst1_slv5_sel;
wire                    [DATA_MSB:0] hm1_slv5_hwdata;
wire                    [DATA_MSB:0] mst1_hs5_hrdata;
wire                                 mst1_hs5_hready;
wire                           [1:0] mst1_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv5_base;
wire                                 mst1_slv5_grant;
wire                    [ADDR_MSB:0] mst1_slv5_haddr;
wire                           [2:0] mst1_slv5_hburst;
wire                           [3:0] mst1_slv5_hprot;
wire                           [2:0] mst1_slv5_hsize;
wire                           [1:0] mst1_slv5_htrans;
wire                                 mst1_slv5_hwrite;
wire                                 mst1_slv5_req;
wire                           [3:0] mst1_slv5_size;
wire                                 mst1_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst1_slv6_sel;
wire                    [DATA_MSB:0] hm1_slv6_hwdata;
wire                    [DATA_MSB:0] mst1_hs6_hrdata;
wire                                 mst1_hs6_hready;
wire                           [1:0] mst1_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv6_base;
wire                                 mst1_slv6_grant;
wire                    [ADDR_MSB:0] mst1_slv6_haddr;
wire                           [2:0] mst1_slv6_hburst;
wire                           [3:0] mst1_slv6_hprot;
wire                           [2:0] mst1_slv6_hsize;
wire                           [1:0] mst1_slv6_htrans;
wire                                 mst1_slv6_hwrite;
wire                                 mst1_slv6_req;
wire                           [3:0] mst1_slv6_size;
wire                                 mst1_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst1_slv7_sel;
wire                    [DATA_MSB:0] hm1_slv7_hwdata;
wire                    [DATA_MSB:0] mst1_hs7_hrdata;
wire                                 mst1_hs7_hready;
wire                           [1:0] mst1_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv7_base;
wire                                 mst1_slv7_grant;
wire                    [ADDR_MSB:0] mst1_slv7_haddr;
wire                           [2:0] mst1_slv7_hburst;
wire                           [3:0] mst1_slv7_hprot;
wire                           [2:0] mst1_slv7_hsize;
wire                           [1:0] mst1_slv7_htrans;
wire                                 mst1_slv7_hwrite;
wire                                 mst1_slv7_req;
wire                           [3:0] mst1_slv7_size;
wire                                 mst1_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst1_slv8_sel;
wire                    [DATA_MSB:0] hm1_slv8_hwdata;
wire                    [DATA_MSB:0] mst1_hs8_hrdata;
wire                                 mst1_hs8_hready;
wire                           [1:0] mst1_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv8_base;
wire                                 mst1_slv8_grant;
wire                    [ADDR_MSB:0] mst1_slv8_haddr;
wire                           [2:0] mst1_slv8_hburst;
wire                           [3:0] mst1_slv8_hprot;
wire                           [2:0] mst1_slv8_hsize;
wire                           [1:0] mst1_slv8_htrans;
wire                                 mst1_slv8_hwrite;
wire                                 mst1_slv8_req;
wire                           [3:0] mst1_slv8_size;
wire                                 mst1_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst1_slv9_sel;
wire                    [DATA_MSB:0] hm1_slv9_hwdata;
wire                    [DATA_MSB:0] mst1_hs9_hrdata;
wire                                 mst1_hs9_hready;
wire                           [1:0] mst1_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv9_base;
wire                                 mst1_slv9_grant;
wire                    [ADDR_MSB:0] mst1_slv9_haddr;
wire                           [2:0] mst1_slv9_hburst;
wire                           [3:0] mst1_slv9_hprot;
wire                           [2:0] mst1_slv9_hsize;
wire                           [1:0] mst1_slv9_htrans;
wire                                 mst1_slv9_hwrite;
wire                                 mst1_slv9_req;
wire                           [3:0] mst1_slv9_size;
wire                                 mst1_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst1_slv10_sel;
wire                    [DATA_MSB:0] hm1_slv10_hwdata;
wire                    [DATA_MSB:0] mst1_hs10_hrdata;
wire                                 mst1_hs10_hready;
wire                           [1:0] mst1_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv10_base;
wire                                 mst1_slv10_grant;
wire                    [ADDR_MSB:0] mst1_slv10_haddr;
wire                           [2:0] mst1_slv10_hburst;
wire                           [3:0] mst1_slv10_hprot;
wire                           [2:0] mst1_slv10_hsize;
wire                           [1:0] mst1_slv10_htrans;
wire                                 mst1_slv10_hwrite;
wire                                 mst1_slv10_req;
wire                           [3:0] mst1_slv10_size;
wire                                 mst1_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst1_slv11_sel;
wire                    [DATA_MSB:0] hm1_slv11_hwdata;
wire                    [DATA_MSB:0] mst1_hs11_hrdata;
wire                                 mst1_hs11_hready;
wire                           [1:0] mst1_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv11_base;
wire                                 mst1_slv11_grant;
wire                    [ADDR_MSB:0] mst1_slv11_haddr;
wire                           [2:0] mst1_slv11_hburst;
wire                           [3:0] mst1_slv11_hprot;
wire                           [2:0] mst1_slv11_hsize;
wire                           [1:0] mst1_slv11_htrans;
wire                                 mst1_slv11_hwrite;
wire                                 mst1_slv11_req;
wire                           [3:0] mst1_slv11_size;
wire                                 mst1_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst1_slv12_sel;
wire                    [DATA_MSB:0] hm1_slv12_hwdata;
wire                    [DATA_MSB:0] mst1_hs12_hrdata;
wire                                 mst1_hs12_hready;
wire                           [1:0] mst1_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv12_base;
wire                                 mst1_slv12_grant;
wire                    [ADDR_MSB:0] mst1_slv12_haddr;
wire                           [2:0] mst1_slv12_hburst;
wire                           [3:0] mst1_slv12_hprot;
wire                           [2:0] mst1_slv12_hsize;
wire                           [1:0] mst1_slv12_htrans;
wire                                 mst1_slv12_hwrite;
wire                                 mst1_slv12_req;
wire                           [3:0] mst1_slv12_size;
wire                                 mst1_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst1_slv13_sel;
wire                    [DATA_MSB:0] hm1_slv13_hwdata;
wire                    [DATA_MSB:0] mst1_hs13_hrdata;
wire                                 mst1_hs13_hready;
wire                           [1:0] mst1_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv13_base;
wire                                 mst1_slv13_grant;
wire                    [ADDR_MSB:0] mst1_slv13_haddr;
wire                           [2:0] mst1_slv13_hburst;
wire                           [3:0] mst1_slv13_hprot;
wire                           [2:0] mst1_slv13_hsize;
wire                           [1:0] mst1_slv13_htrans;
wire                                 mst1_slv13_hwrite;
wire                                 mst1_slv13_req;
wire                           [3:0] mst1_slv13_size;
wire                                 mst1_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst1_slv14_sel;
wire                    [DATA_MSB:0] hm1_slv14_hwdata;
wire                    [DATA_MSB:0] mst1_hs14_hrdata;
wire                                 mst1_hs14_hready;
wire                           [1:0] mst1_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv14_base;
wire                                 mst1_slv14_grant;
wire                    [ADDR_MSB:0] mst1_slv14_haddr;
wire                           [2:0] mst1_slv14_hburst;
wire                           [3:0] mst1_slv14_hprot;
wire                           [2:0] mst1_slv14_hsize;
wire                           [1:0] mst1_slv14_htrans;
wire                                 mst1_slv14_hwrite;
wire                                 mst1_slv14_req;
wire                           [3:0] mst1_slv14_size;
wire                                 mst1_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst1_slv15_sel;
wire                    [DATA_MSB:0] hm1_slv15_hwdata;
wire                    [DATA_MSB:0] mst1_hs15_hrdata;
wire                                 mst1_hs15_hready;
wire                           [1:0] mst1_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv15_base;
wire                                 mst1_slv15_grant;
wire                    [ADDR_MSB:0] mst1_slv15_haddr;
wire                           [2:0] mst1_slv15_hburst;
wire                           [3:0] mst1_slv15_hprot;
wire                           [2:0] mst1_slv15_hsize;
wire                           [1:0] mst1_slv15_htrans;
wire                                 mst1_slv15_hwrite;
wire                                 mst1_slv15_req;
wire                           [3:0] mst1_slv15_size;
wire                                 mst1_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst1_slv0_sel;
wire                    [DATA_MSB:0] hm1_slv0_hwdata;
wire                    [DATA_MSB:0] mst1_hs0_hrdata;
wire                                 mst1_hs0_hready;
wire                           [1:0] mst1_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst1_slv0_base;
wire                                 mst1_slv0_grant;
wire                    [ADDR_MSB:0] mst1_slv0_haddr;
wire                           [2:0] mst1_slv0_hburst;
wire                           [3:0] mst1_slv0_hprot;
wire                           [2:0] mst1_slv0_hsize;
wire                           [1:0] mst1_slv0_htrans;
wire                                 mst1_slv0_hwrite;
wire                                 mst1_slv0_req;
wire                           [3:0] mst1_slv0_size;
wire                                 mst1_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST2
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst2_slv1_sel;
wire                    [DATA_MSB:0] hm2_slv1_hwdata;
wire                    [DATA_MSB:0] mst2_hs1_hrdata;
wire                                 mst2_hs1_hready;
wire                           [1:0] mst2_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv1_base;
wire                                 mst2_slv1_grant;
wire                    [ADDR_MSB:0] mst2_slv1_haddr;
wire                           [2:0] mst2_slv1_hburst;
wire                           [3:0] mst2_slv1_hprot;
wire                           [2:0] mst2_slv1_hsize;
wire                           [1:0] mst2_slv1_htrans;
wire                                 mst2_slv1_hwrite;
wire                                 mst2_slv1_req;
wire                           [3:0] mst2_slv1_size;
wire                                 mst2_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst2_slv2_sel;
wire                    [DATA_MSB:0] hm2_slv2_hwdata;
wire                    [DATA_MSB:0] mst2_hs2_hrdata;
wire                                 mst2_hs2_hready;
wire                           [1:0] mst2_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv2_base;
wire                                 mst2_slv2_grant;
wire                    [ADDR_MSB:0] mst2_slv2_haddr;
wire                           [2:0] mst2_slv2_hburst;
wire                           [3:0] mst2_slv2_hprot;
wire                           [2:0] mst2_slv2_hsize;
wire                           [1:0] mst2_slv2_htrans;
wire                                 mst2_slv2_hwrite;
wire                                 mst2_slv2_req;
wire                           [3:0] mst2_slv2_size;
wire                                 mst2_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst2_slv3_sel;
wire                    [DATA_MSB:0] hm2_slv3_hwdata;
wire                    [DATA_MSB:0] mst2_hs3_hrdata;
wire                                 mst2_hs3_hready;
wire                           [1:0] mst2_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv3_base;
wire                                 mst2_slv3_grant;
wire                    [ADDR_MSB:0] mst2_slv3_haddr;
wire                           [2:0] mst2_slv3_hburst;
wire                           [3:0] mst2_slv3_hprot;
wire                           [2:0] mst2_slv3_hsize;
wire                           [1:0] mst2_slv3_htrans;
wire                                 mst2_slv3_hwrite;
wire                                 mst2_slv3_req;
wire                           [3:0] mst2_slv3_size;
wire                                 mst2_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst2_slv4_sel;
wire                    [DATA_MSB:0] hm2_slv4_hwdata;
wire                    [DATA_MSB:0] mst2_hs4_hrdata;
wire                                 mst2_hs4_hready;
wire                           [1:0] mst2_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv4_base;
wire                                 mst2_slv4_grant;
wire                    [ADDR_MSB:0] mst2_slv4_haddr;
wire                           [2:0] mst2_slv4_hburst;
wire                           [3:0] mst2_slv4_hprot;
wire                           [2:0] mst2_slv4_hsize;
wire                           [1:0] mst2_slv4_htrans;
wire                                 mst2_slv4_hwrite;
wire                                 mst2_slv4_req;
wire                           [3:0] mst2_slv4_size;
wire                                 mst2_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst2_slv5_sel;
wire                    [DATA_MSB:0] hm2_slv5_hwdata;
wire                    [DATA_MSB:0] mst2_hs5_hrdata;
wire                                 mst2_hs5_hready;
wire                           [1:0] mst2_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv5_base;
wire                                 mst2_slv5_grant;
wire                    [ADDR_MSB:0] mst2_slv5_haddr;
wire                           [2:0] mst2_slv5_hburst;
wire                           [3:0] mst2_slv5_hprot;
wire                           [2:0] mst2_slv5_hsize;
wire                           [1:0] mst2_slv5_htrans;
wire                                 mst2_slv5_hwrite;
wire                                 mst2_slv5_req;
wire                           [3:0] mst2_slv5_size;
wire                                 mst2_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst2_slv6_sel;
wire                    [DATA_MSB:0] hm2_slv6_hwdata;
wire                    [DATA_MSB:0] mst2_hs6_hrdata;
wire                                 mst2_hs6_hready;
wire                           [1:0] mst2_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv6_base;
wire                                 mst2_slv6_grant;
wire                    [ADDR_MSB:0] mst2_slv6_haddr;
wire                           [2:0] mst2_slv6_hburst;
wire                           [3:0] mst2_slv6_hprot;
wire                           [2:0] mst2_slv6_hsize;
wire                           [1:0] mst2_slv6_htrans;
wire                                 mst2_slv6_hwrite;
wire                                 mst2_slv6_req;
wire                           [3:0] mst2_slv6_size;
wire                                 mst2_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst2_slv7_sel;
wire                    [DATA_MSB:0] hm2_slv7_hwdata;
wire                    [DATA_MSB:0] mst2_hs7_hrdata;
wire                                 mst2_hs7_hready;
wire                           [1:0] mst2_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv7_base;
wire                                 mst2_slv7_grant;
wire                    [ADDR_MSB:0] mst2_slv7_haddr;
wire                           [2:0] mst2_slv7_hburst;
wire                           [3:0] mst2_slv7_hprot;
wire                           [2:0] mst2_slv7_hsize;
wire                           [1:0] mst2_slv7_htrans;
wire                                 mst2_slv7_hwrite;
wire                                 mst2_slv7_req;
wire                           [3:0] mst2_slv7_size;
wire                                 mst2_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst2_slv8_sel;
wire                    [DATA_MSB:0] hm2_slv8_hwdata;
wire                    [DATA_MSB:0] mst2_hs8_hrdata;
wire                                 mst2_hs8_hready;
wire                           [1:0] mst2_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv8_base;
wire                                 mst2_slv8_grant;
wire                    [ADDR_MSB:0] mst2_slv8_haddr;
wire                           [2:0] mst2_slv8_hburst;
wire                           [3:0] mst2_slv8_hprot;
wire                           [2:0] mst2_slv8_hsize;
wire                           [1:0] mst2_slv8_htrans;
wire                                 mst2_slv8_hwrite;
wire                                 mst2_slv8_req;
wire                           [3:0] mst2_slv8_size;
wire                                 mst2_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst2_slv9_sel;
wire                    [DATA_MSB:0] hm2_slv9_hwdata;
wire                    [DATA_MSB:0] mst2_hs9_hrdata;
wire                                 mst2_hs9_hready;
wire                           [1:0] mst2_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv9_base;
wire                                 mst2_slv9_grant;
wire                    [ADDR_MSB:0] mst2_slv9_haddr;
wire                           [2:0] mst2_slv9_hburst;
wire                           [3:0] mst2_slv9_hprot;
wire                           [2:0] mst2_slv9_hsize;
wire                           [1:0] mst2_slv9_htrans;
wire                                 mst2_slv9_hwrite;
wire                                 mst2_slv9_req;
wire                           [3:0] mst2_slv9_size;
wire                                 mst2_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst2_slv10_sel;
wire                    [DATA_MSB:0] hm2_slv10_hwdata;
wire                    [DATA_MSB:0] mst2_hs10_hrdata;
wire                                 mst2_hs10_hready;
wire                           [1:0] mst2_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv10_base;
wire                                 mst2_slv10_grant;
wire                    [ADDR_MSB:0] mst2_slv10_haddr;
wire                           [2:0] mst2_slv10_hburst;
wire                           [3:0] mst2_slv10_hprot;
wire                           [2:0] mst2_slv10_hsize;
wire                           [1:0] mst2_slv10_htrans;
wire                                 mst2_slv10_hwrite;
wire                                 mst2_slv10_req;
wire                           [3:0] mst2_slv10_size;
wire                                 mst2_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst2_slv11_sel;
wire                    [DATA_MSB:0] hm2_slv11_hwdata;
wire                    [DATA_MSB:0] mst2_hs11_hrdata;
wire                                 mst2_hs11_hready;
wire                           [1:0] mst2_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv11_base;
wire                                 mst2_slv11_grant;
wire                    [ADDR_MSB:0] mst2_slv11_haddr;
wire                           [2:0] mst2_slv11_hburst;
wire                           [3:0] mst2_slv11_hprot;
wire                           [2:0] mst2_slv11_hsize;
wire                           [1:0] mst2_slv11_htrans;
wire                                 mst2_slv11_hwrite;
wire                                 mst2_slv11_req;
wire                           [3:0] mst2_slv11_size;
wire                                 mst2_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst2_slv12_sel;
wire                    [DATA_MSB:0] hm2_slv12_hwdata;
wire                    [DATA_MSB:0] mst2_hs12_hrdata;
wire                                 mst2_hs12_hready;
wire                           [1:0] mst2_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv12_base;
wire                                 mst2_slv12_grant;
wire                    [ADDR_MSB:0] mst2_slv12_haddr;
wire                           [2:0] mst2_slv12_hburst;
wire                           [3:0] mst2_slv12_hprot;
wire                           [2:0] mst2_slv12_hsize;
wire                           [1:0] mst2_slv12_htrans;
wire                                 mst2_slv12_hwrite;
wire                                 mst2_slv12_req;
wire                           [3:0] mst2_slv12_size;
wire                                 mst2_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst2_slv13_sel;
wire                    [DATA_MSB:0] hm2_slv13_hwdata;
wire                    [DATA_MSB:0] mst2_hs13_hrdata;
wire                                 mst2_hs13_hready;
wire                           [1:0] mst2_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv13_base;
wire                                 mst2_slv13_grant;
wire                    [ADDR_MSB:0] mst2_slv13_haddr;
wire                           [2:0] mst2_slv13_hburst;
wire                           [3:0] mst2_slv13_hprot;
wire                           [2:0] mst2_slv13_hsize;
wire                           [1:0] mst2_slv13_htrans;
wire                                 mst2_slv13_hwrite;
wire                                 mst2_slv13_req;
wire                           [3:0] mst2_slv13_size;
wire                                 mst2_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst2_slv14_sel;
wire                    [DATA_MSB:0] hm2_slv14_hwdata;
wire                    [DATA_MSB:0] mst2_hs14_hrdata;
wire                                 mst2_hs14_hready;
wire                           [1:0] mst2_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv14_base;
wire                                 mst2_slv14_grant;
wire                    [ADDR_MSB:0] mst2_slv14_haddr;
wire                           [2:0] mst2_slv14_hburst;
wire                           [3:0] mst2_slv14_hprot;
wire                           [2:0] mst2_slv14_hsize;
wire                           [1:0] mst2_slv14_htrans;
wire                                 mst2_slv14_hwrite;
wire                                 mst2_slv14_req;
wire                           [3:0] mst2_slv14_size;
wire                                 mst2_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst2_slv15_sel;
wire                    [DATA_MSB:0] hm2_slv15_hwdata;
wire                    [DATA_MSB:0] mst2_hs15_hrdata;
wire                                 mst2_hs15_hready;
wire                           [1:0] mst2_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv15_base;
wire                                 mst2_slv15_grant;
wire                    [ADDR_MSB:0] mst2_slv15_haddr;
wire                           [2:0] mst2_slv15_hburst;
wire                           [3:0] mst2_slv15_hprot;
wire                           [2:0] mst2_slv15_hsize;
wire                           [1:0] mst2_slv15_htrans;
wire                                 mst2_slv15_hwrite;
wire                                 mst2_slv15_req;
wire                           [3:0] mst2_slv15_size;
wire                                 mst2_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst2_slv0_sel;
wire                    [DATA_MSB:0] hm2_slv0_hwdata;
wire                    [DATA_MSB:0] mst2_hs0_hrdata;
wire                                 mst2_hs0_hready;
wire                           [1:0] mst2_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst2_slv0_base;
wire                                 mst2_slv0_grant;
wire                    [ADDR_MSB:0] mst2_slv0_haddr;
wire                           [2:0] mst2_slv0_hburst;
wire                           [3:0] mst2_slv0_hprot;
wire                           [2:0] mst2_slv0_hsize;
wire                           [1:0] mst2_slv0_htrans;
wire                                 mst2_slv0_hwrite;
wire                                 mst2_slv0_req;
wire                           [3:0] mst2_slv0_size;
wire                                 mst2_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST3
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst3_slv1_sel;
wire                    [DATA_MSB:0] hm3_slv1_hwdata;
wire                    [DATA_MSB:0] mst3_hs1_hrdata;
wire                                 mst3_hs1_hready;
wire                           [1:0] mst3_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv1_base;
wire                                 mst3_slv1_grant;
wire                    [ADDR_MSB:0] mst3_slv1_haddr;
wire                           [2:0] mst3_slv1_hburst;
wire                           [3:0] mst3_slv1_hprot;
wire                           [2:0] mst3_slv1_hsize;
wire                           [1:0] mst3_slv1_htrans;
wire                                 mst3_slv1_hwrite;
wire                                 mst3_slv1_req;
wire                           [3:0] mst3_slv1_size;
wire                                 mst3_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst3_slv2_sel;
wire                    [DATA_MSB:0] hm3_slv2_hwdata;
wire                    [DATA_MSB:0] mst3_hs2_hrdata;
wire                                 mst3_hs2_hready;
wire                           [1:0] mst3_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv2_base;
wire                                 mst3_slv2_grant;
wire                    [ADDR_MSB:0] mst3_slv2_haddr;
wire                           [2:0] mst3_slv2_hburst;
wire                           [3:0] mst3_slv2_hprot;
wire                           [2:0] mst3_slv2_hsize;
wire                           [1:0] mst3_slv2_htrans;
wire                                 mst3_slv2_hwrite;
wire                                 mst3_slv2_req;
wire                           [3:0] mst3_slv2_size;
wire                                 mst3_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst3_slv3_sel;
wire                    [DATA_MSB:0] hm3_slv3_hwdata;
wire                    [DATA_MSB:0] mst3_hs3_hrdata;
wire                                 mst3_hs3_hready;
wire                           [1:0] mst3_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv3_base;
wire                                 mst3_slv3_grant;
wire                    [ADDR_MSB:0] mst3_slv3_haddr;
wire                           [2:0] mst3_slv3_hburst;
wire                           [3:0] mst3_slv3_hprot;
wire                           [2:0] mst3_slv3_hsize;
wire                           [1:0] mst3_slv3_htrans;
wire                                 mst3_slv3_hwrite;
wire                                 mst3_slv3_req;
wire                           [3:0] mst3_slv3_size;
wire                                 mst3_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst3_slv4_sel;
wire                    [DATA_MSB:0] hm3_slv4_hwdata;
wire                    [DATA_MSB:0] mst3_hs4_hrdata;
wire                                 mst3_hs4_hready;
wire                           [1:0] mst3_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv4_base;
wire                                 mst3_slv4_grant;
wire                    [ADDR_MSB:0] mst3_slv4_haddr;
wire                           [2:0] mst3_slv4_hburst;
wire                           [3:0] mst3_slv4_hprot;
wire                           [2:0] mst3_slv4_hsize;
wire                           [1:0] mst3_slv4_htrans;
wire                                 mst3_slv4_hwrite;
wire                                 mst3_slv4_req;
wire                           [3:0] mst3_slv4_size;
wire                                 mst3_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst3_slv5_sel;
wire                    [DATA_MSB:0] hm3_slv5_hwdata;
wire                    [DATA_MSB:0] mst3_hs5_hrdata;
wire                                 mst3_hs5_hready;
wire                           [1:0] mst3_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv5_base;
wire                                 mst3_slv5_grant;
wire                    [ADDR_MSB:0] mst3_slv5_haddr;
wire                           [2:0] mst3_slv5_hburst;
wire                           [3:0] mst3_slv5_hprot;
wire                           [2:0] mst3_slv5_hsize;
wire                           [1:0] mst3_slv5_htrans;
wire                                 mst3_slv5_hwrite;
wire                                 mst3_slv5_req;
wire                           [3:0] mst3_slv5_size;
wire                                 mst3_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst3_slv6_sel;
wire                    [DATA_MSB:0] hm3_slv6_hwdata;
wire                    [DATA_MSB:0] mst3_hs6_hrdata;
wire                                 mst3_hs6_hready;
wire                           [1:0] mst3_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv6_base;
wire                                 mst3_slv6_grant;
wire                    [ADDR_MSB:0] mst3_slv6_haddr;
wire                           [2:0] mst3_slv6_hburst;
wire                           [3:0] mst3_slv6_hprot;
wire                           [2:0] mst3_slv6_hsize;
wire                           [1:0] mst3_slv6_htrans;
wire                                 mst3_slv6_hwrite;
wire                                 mst3_slv6_req;
wire                           [3:0] mst3_slv6_size;
wire                                 mst3_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst3_slv7_sel;
wire                    [DATA_MSB:0] hm3_slv7_hwdata;
wire                    [DATA_MSB:0] mst3_hs7_hrdata;
wire                                 mst3_hs7_hready;
wire                           [1:0] mst3_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv7_base;
wire                                 mst3_slv7_grant;
wire                    [ADDR_MSB:0] mst3_slv7_haddr;
wire                           [2:0] mst3_slv7_hburst;
wire                           [3:0] mst3_slv7_hprot;
wire                           [2:0] mst3_slv7_hsize;
wire                           [1:0] mst3_slv7_htrans;
wire                                 mst3_slv7_hwrite;
wire                                 mst3_slv7_req;
wire                           [3:0] mst3_slv7_size;
wire                                 mst3_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst3_slv8_sel;
wire                    [DATA_MSB:0] hm3_slv8_hwdata;
wire                    [DATA_MSB:0] mst3_hs8_hrdata;
wire                                 mst3_hs8_hready;
wire                           [1:0] mst3_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv8_base;
wire                                 mst3_slv8_grant;
wire                    [ADDR_MSB:0] mst3_slv8_haddr;
wire                           [2:0] mst3_slv8_hburst;
wire                           [3:0] mst3_slv8_hprot;
wire                           [2:0] mst3_slv8_hsize;
wire                           [1:0] mst3_slv8_htrans;
wire                                 mst3_slv8_hwrite;
wire                                 mst3_slv8_req;
wire                           [3:0] mst3_slv8_size;
wire                                 mst3_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst3_slv9_sel;
wire                    [DATA_MSB:0] hm3_slv9_hwdata;
wire                    [DATA_MSB:0] mst3_hs9_hrdata;
wire                                 mst3_hs9_hready;
wire                           [1:0] mst3_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv9_base;
wire                                 mst3_slv9_grant;
wire                    [ADDR_MSB:0] mst3_slv9_haddr;
wire                           [2:0] mst3_slv9_hburst;
wire                           [3:0] mst3_slv9_hprot;
wire                           [2:0] mst3_slv9_hsize;
wire                           [1:0] mst3_slv9_htrans;
wire                                 mst3_slv9_hwrite;
wire                                 mst3_slv9_req;
wire                           [3:0] mst3_slv9_size;
wire                                 mst3_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst3_slv10_sel;
wire                    [DATA_MSB:0] hm3_slv10_hwdata;
wire                    [DATA_MSB:0] mst3_hs10_hrdata;
wire                                 mst3_hs10_hready;
wire                           [1:0] mst3_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv10_base;
wire                                 mst3_slv10_grant;
wire                    [ADDR_MSB:0] mst3_slv10_haddr;
wire                           [2:0] mst3_slv10_hburst;
wire                           [3:0] mst3_slv10_hprot;
wire                           [2:0] mst3_slv10_hsize;
wire                           [1:0] mst3_slv10_htrans;
wire                                 mst3_slv10_hwrite;
wire                                 mst3_slv10_req;
wire                           [3:0] mst3_slv10_size;
wire                                 mst3_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst3_slv11_sel;
wire                    [DATA_MSB:0] hm3_slv11_hwdata;
wire                    [DATA_MSB:0] mst3_hs11_hrdata;
wire                                 mst3_hs11_hready;
wire                           [1:0] mst3_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv11_base;
wire                                 mst3_slv11_grant;
wire                    [ADDR_MSB:0] mst3_slv11_haddr;
wire                           [2:0] mst3_slv11_hburst;
wire                           [3:0] mst3_slv11_hprot;
wire                           [2:0] mst3_slv11_hsize;
wire                           [1:0] mst3_slv11_htrans;
wire                                 mst3_slv11_hwrite;
wire                                 mst3_slv11_req;
wire                           [3:0] mst3_slv11_size;
wire                                 mst3_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst3_slv12_sel;
wire                    [DATA_MSB:0] hm3_slv12_hwdata;
wire                    [DATA_MSB:0] mst3_hs12_hrdata;
wire                                 mst3_hs12_hready;
wire                           [1:0] mst3_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv12_base;
wire                                 mst3_slv12_grant;
wire                    [ADDR_MSB:0] mst3_slv12_haddr;
wire                           [2:0] mst3_slv12_hburst;
wire                           [3:0] mst3_slv12_hprot;
wire                           [2:0] mst3_slv12_hsize;
wire                           [1:0] mst3_slv12_htrans;
wire                                 mst3_slv12_hwrite;
wire                                 mst3_slv12_req;
wire                           [3:0] mst3_slv12_size;
wire                                 mst3_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst3_slv13_sel;
wire                    [DATA_MSB:0] hm3_slv13_hwdata;
wire                    [DATA_MSB:0] mst3_hs13_hrdata;
wire                                 mst3_hs13_hready;
wire                           [1:0] mst3_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv13_base;
wire                                 mst3_slv13_grant;
wire                    [ADDR_MSB:0] mst3_slv13_haddr;
wire                           [2:0] mst3_slv13_hburst;
wire                           [3:0] mst3_slv13_hprot;
wire                           [2:0] mst3_slv13_hsize;
wire                           [1:0] mst3_slv13_htrans;
wire                                 mst3_slv13_hwrite;
wire                                 mst3_slv13_req;
wire                           [3:0] mst3_slv13_size;
wire                                 mst3_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst3_slv14_sel;
wire                    [DATA_MSB:0] hm3_slv14_hwdata;
wire                    [DATA_MSB:0] mst3_hs14_hrdata;
wire                                 mst3_hs14_hready;
wire                           [1:0] mst3_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv14_base;
wire                                 mst3_slv14_grant;
wire                    [ADDR_MSB:0] mst3_slv14_haddr;
wire                           [2:0] mst3_slv14_hburst;
wire                           [3:0] mst3_slv14_hprot;
wire                           [2:0] mst3_slv14_hsize;
wire                           [1:0] mst3_slv14_htrans;
wire                                 mst3_slv14_hwrite;
wire                                 mst3_slv14_req;
wire                           [3:0] mst3_slv14_size;
wire                                 mst3_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst3_slv15_sel;
wire                    [DATA_MSB:0] hm3_slv15_hwdata;
wire                    [DATA_MSB:0] mst3_hs15_hrdata;
wire                                 mst3_hs15_hready;
wire                           [1:0] mst3_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv15_base;
wire                                 mst3_slv15_grant;
wire                    [ADDR_MSB:0] mst3_slv15_haddr;
wire                           [2:0] mst3_slv15_hburst;
wire                           [3:0] mst3_slv15_hprot;
wire                           [2:0] mst3_slv15_hsize;
wire                           [1:0] mst3_slv15_htrans;
wire                                 mst3_slv15_hwrite;
wire                                 mst3_slv15_req;
wire                           [3:0] mst3_slv15_size;
wire                                 mst3_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst3_slv0_sel;
wire                    [DATA_MSB:0] hm3_slv0_hwdata;
wire                    [DATA_MSB:0] mst3_hs0_hrdata;
wire                                 mst3_hs0_hready;
wire                           [1:0] mst3_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst3_slv0_base;
wire                                 mst3_slv0_grant;
wire                    [ADDR_MSB:0] mst3_slv0_haddr;
wire                           [2:0] mst3_slv0_hburst;
wire                           [3:0] mst3_slv0_hprot;
wire                           [2:0] mst3_slv0_hsize;
wire                           [1:0] mst3_slv0_htrans;
wire                                 mst3_slv0_hwrite;
wire                                 mst3_slv0_req;
wire                           [3:0] mst3_slv0_size;
wire                                 mst3_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST4
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst4_slv1_sel;
wire                    [DATA_MSB:0] hm4_slv1_hwdata;
wire                    [DATA_MSB:0] mst4_hs1_hrdata;
wire                                 mst4_hs1_hready;
wire                           [1:0] mst4_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv1_base;
wire                                 mst4_slv1_grant;
wire                    [ADDR_MSB:0] mst4_slv1_haddr;
wire                           [2:0] mst4_slv1_hburst;
wire                           [3:0] mst4_slv1_hprot;
wire                           [2:0] mst4_slv1_hsize;
wire                           [1:0] mst4_slv1_htrans;
wire                                 mst4_slv1_hwrite;
wire                                 mst4_slv1_req;
wire                           [3:0] mst4_slv1_size;
wire                                 mst4_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst4_slv2_sel;
wire                    [DATA_MSB:0] hm4_slv2_hwdata;
wire                    [DATA_MSB:0] mst4_hs2_hrdata;
wire                                 mst4_hs2_hready;
wire                           [1:0] mst4_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv2_base;
wire                                 mst4_slv2_grant;
wire                    [ADDR_MSB:0] mst4_slv2_haddr;
wire                           [2:0] mst4_slv2_hburst;
wire                           [3:0] mst4_slv2_hprot;
wire                           [2:0] mst4_slv2_hsize;
wire                           [1:0] mst4_slv2_htrans;
wire                                 mst4_slv2_hwrite;
wire                                 mst4_slv2_req;
wire                           [3:0] mst4_slv2_size;
wire                                 mst4_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst4_slv3_sel;
wire                    [DATA_MSB:0] hm4_slv3_hwdata;
wire                    [DATA_MSB:0] mst4_hs3_hrdata;
wire                                 mst4_hs3_hready;
wire                           [1:0] mst4_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv3_base;
wire                                 mst4_slv3_grant;
wire                    [ADDR_MSB:0] mst4_slv3_haddr;
wire                           [2:0] mst4_slv3_hburst;
wire                           [3:0] mst4_slv3_hprot;
wire                           [2:0] mst4_slv3_hsize;
wire                           [1:0] mst4_slv3_htrans;
wire                                 mst4_slv3_hwrite;
wire                                 mst4_slv3_req;
wire                           [3:0] mst4_slv3_size;
wire                                 mst4_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst4_slv4_sel;
wire                    [DATA_MSB:0] hm4_slv4_hwdata;
wire                    [DATA_MSB:0] mst4_hs4_hrdata;
wire                                 mst4_hs4_hready;
wire                           [1:0] mst4_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv4_base;
wire                                 mst4_slv4_grant;
wire                    [ADDR_MSB:0] mst4_slv4_haddr;
wire                           [2:0] mst4_slv4_hburst;
wire                           [3:0] mst4_slv4_hprot;
wire                           [2:0] mst4_slv4_hsize;
wire                           [1:0] mst4_slv4_htrans;
wire                                 mst4_slv4_hwrite;
wire                                 mst4_slv4_req;
wire                           [3:0] mst4_slv4_size;
wire                                 mst4_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst4_slv5_sel;
wire                    [DATA_MSB:0] hm4_slv5_hwdata;
wire                    [DATA_MSB:0] mst4_hs5_hrdata;
wire                                 mst4_hs5_hready;
wire                           [1:0] mst4_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv5_base;
wire                                 mst4_slv5_grant;
wire                    [ADDR_MSB:0] mst4_slv5_haddr;
wire                           [2:0] mst4_slv5_hburst;
wire                           [3:0] mst4_slv5_hprot;
wire                           [2:0] mst4_slv5_hsize;
wire                           [1:0] mst4_slv5_htrans;
wire                                 mst4_slv5_hwrite;
wire                                 mst4_slv5_req;
wire                           [3:0] mst4_slv5_size;
wire                                 mst4_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst4_slv6_sel;
wire                    [DATA_MSB:0] hm4_slv6_hwdata;
wire                    [DATA_MSB:0] mst4_hs6_hrdata;
wire                                 mst4_hs6_hready;
wire                           [1:0] mst4_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv6_base;
wire                                 mst4_slv6_grant;
wire                    [ADDR_MSB:0] mst4_slv6_haddr;
wire                           [2:0] mst4_slv6_hburst;
wire                           [3:0] mst4_slv6_hprot;
wire                           [2:0] mst4_slv6_hsize;
wire                           [1:0] mst4_slv6_htrans;
wire                                 mst4_slv6_hwrite;
wire                                 mst4_slv6_req;
wire                           [3:0] mst4_slv6_size;
wire                                 mst4_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst4_slv7_sel;
wire                    [DATA_MSB:0] hm4_slv7_hwdata;
wire                    [DATA_MSB:0] mst4_hs7_hrdata;
wire                                 mst4_hs7_hready;
wire                           [1:0] mst4_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv7_base;
wire                                 mst4_slv7_grant;
wire                    [ADDR_MSB:0] mst4_slv7_haddr;
wire                           [2:0] mst4_slv7_hburst;
wire                           [3:0] mst4_slv7_hprot;
wire                           [2:0] mst4_slv7_hsize;
wire                           [1:0] mst4_slv7_htrans;
wire                                 mst4_slv7_hwrite;
wire                                 mst4_slv7_req;
wire                           [3:0] mst4_slv7_size;
wire                                 mst4_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst4_slv8_sel;
wire                    [DATA_MSB:0] hm4_slv8_hwdata;
wire                    [DATA_MSB:0] mst4_hs8_hrdata;
wire                                 mst4_hs8_hready;
wire                           [1:0] mst4_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv8_base;
wire                                 mst4_slv8_grant;
wire                    [ADDR_MSB:0] mst4_slv8_haddr;
wire                           [2:0] mst4_slv8_hburst;
wire                           [3:0] mst4_slv8_hprot;
wire                           [2:0] mst4_slv8_hsize;
wire                           [1:0] mst4_slv8_htrans;
wire                                 mst4_slv8_hwrite;
wire                                 mst4_slv8_req;
wire                           [3:0] mst4_slv8_size;
wire                                 mst4_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst4_slv9_sel;
wire                    [DATA_MSB:0] hm4_slv9_hwdata;
wire                    [DATA_MSB:0] mst4_hs9_hrdata;
wire                                 mst4_hs9_hready;
wire                           [1:0] mst4_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv9_base;
wire                                 mst4_slv9_grant;
wire                    [ADDR_MSB:0] mst4_slv9_haddr;
wire                           [2:0] mst4_slv9_hburst;
wire                           [3:0] mst4_slv9_hprot;
wire                           [2:0] mst4_slv9_hsize;
wire                           [1:0] mst4_slv9_htrans;
wire                                 mst4_slv9_hwrite;
wire                                 mst4_slv9_req;
wire                           [3:0] mst4_slv9_size;
wire                                 mst4_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst4_slv10_sel;
wire                    [DATA_MSB:0] hm4_slv10_hwdata;
wire                    [DATA_MSB:0] mst4_hs10_hrdata;
wire                                 mst4_hs10_hready;
wire                           [1:0] mst4_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv10_base;
wire                                 mst4_slv10_grant;
wire                    [ADDR_MSB:0] mst4_slv10_haddr;
wire                           [2:0] mst4_slv10_hburst;
wire                           [3:0] mst4_slv10_hprot;
wire                           [2:0] mst4_slv10_hsize;
wire                           [1:0] mst4_slv10_htrans;
wire                                 mst4_slv10_hwrite;
wire                                 mst4_slv10_req;
wire                           [3:0] mst4_slv10_size;
wire                                 mst4_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst4_slv11_sel;
wire                    [DATA_MSB:0] hm4_slv11_hwdata;
wire                    [DATA_MSB:0] mst4_hs11_hrdata;
wire                                 mst4_hs11_hready;
wire                           [1:0] mst4_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv11_base;
wire                                 mst4_slv11_grant;
wire                    [ADDR_MSB:0] mst4_slv11_haddr;
wire                           [2:0] mst4_slv11_hburst;
wire                           [3:0] mst4_slv11_hprot;
wire                           [2:0] mst4_slv11_hsize;
wire                           [1:0] mst4_slv11_htrans;
wire                                 mst4_slv11_hwrite;
wire                                 mst4_slv11_req;
wire                           [3:0] mst4_slv11_size;
wire                                 mst4_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst4_slv12_sel;
wire                    [DATA_MSB:0] hm4_slv12_hwdata;
wire                    [DATA_MSB:0] mst4_hs12_hrdata;
wire                                 mst4_hs12_hready;
wire                           [1:0] mst4_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv12_base;
wire                                 mst4_slv12_grant;
wire                    [ADDR_MSB:0] mst4_slv12_haddr;
wire                           [2:0] mst4_slv12_hburst;
wire                           [3:0] mst4_slv12_hprot;
wire                           [2:0] mst4_slv12_hsize;
wire                           [1:0] mst4_slv12_htrans;
wire                                 mst4_slv12_hwrite;
wire                                 mst4_slv12_req;
wire                           [3:0] mst4_slv12_size;
wire                                 mst4_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst4_slv13_sel;
wire                    [DATA_MSB:0] hm4_slv13_hwdata;
wire                    [DATA_MSB:0] mst4_hs13_hrdata;
wire                                 mst4_hs13_hready;
wire                           [1:0] mst4_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv13_base;
wire                                 mst4_slv13_grant;
wire                    [ADDR_MSB:0] mst4_slv13_haddr;
wire                           [2:0] mst4_slv13_hburst;
wire                           [3:0] mst4_slv13_hprot;
wire                           [2:0] mst4_slv13_hsize;
wire                           [1:0] mst4_slv13_htrans;
wire                                 mst4_slv13_hwrite;
wire                                 mst4_slv13_req;
wire                           [3:0] mst4_slv13_size;
wire                                 mst4_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst4_slv14_sel;
wire                    [DATA_MSB:0] hm4_slv14_hwdata;
wire                    [DATA_MSB:0] mst4_hs14_hrdata;
wire                                 mst4_hs14_hready;
wire                           [1:0] mst4_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv14_base;
wire                                 mst4_slv14_grant;
wire                    [ADDR_MSB:0] mst4_slv14_haddr;
wire                           [2:0] mst4_slv14_hburst;
wire                           [3:0] mst4_slv14_hprot;
wire                           [2:0] mst4_slv14_hsize;
wire                           [1:0] mst4_slv14_htrans;
wire                                 mst4_slv14_hwrite;
wire                                 mst4_slv14_req;
wire                           [3:0] mst4_slv14_size;
wire                                 mst4_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst4_slv15_sel;
wire                    [DATA_MSB:0] hm4_slv15_hwdata;
wire                    [DATA_MSB:0] mst4_hs15_hrdata;
wire                                 mst4_hs15_hready;
wire                           [1:0] mst4_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv15_base;
wire                                 mst4_slv15_grant;
wire                    [ADDR_MSB:0] mst4_slv15_haddr;
wire                           [2:0] mst4_slv15_hburst;
wire                           [3:0] mst4_slv15_hprot;
wire                           [2:0] mst4_slv15_hsize;
wire                           [1:0] mst4_slv15_htrans;
wire                                 mst4_slv15_hwrite;
wire                                 mst4_slv15_req;
wire                           [3:0] mst4_slv15_size;
wire                                 mst4_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst4_slv0_sel;
wire                    [DATA_MSB:0] hm4_slv0_hwdata;
wire                    [DATA_MSB:0] mst4_hs0_hrdata;
wire                                 mst4_hs0_hready;
wire                           [1:0] mst4_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst4_slv0_base;
wire                                 mst4_slv0_grant;
wire                    [ADDR_MSB:0] mst4_slv0_haddr;
wire                           [2:0] mst4_slv0_hburst;
wire                           [3:0] mst4_slv0_hprot;
wire                           [2:0] mst4_slv0_hsize;
wire                           [1:0] mst4_slv0_htrans;
wire                                 mst4_slv0_hwrite;
wire                                 mst4_slv0_req;
wire                           [3:0] mst4_slv0_size;
wire                                 mst4_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST5
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst5_slv1_sel;
wire                    [DATA_MSB:0] hm5_slv1_hwdata;
wire                    [DATA_MSB:0] mst5_hs1_hrdata;
wire                                 mst5_hs1_hready;
wire                           [1:0] mst5_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv1_base;
wire                                 mst5_slv1_grant;
wire                    [ADDR_MSB:0] mst5_slv1_haddr;
wire                           [2:0] mst5_slv1_hburst;
wire                           [3:0] mst5_slv1_hprot;
wire                           [2:0] mst5_slv1_hsize;
wire                           [1:0] mst5_slv1_htrans;
wire                                 mst5_slv1_hwrite;
wire                                 mst5_slv1_req;
wire                           [3:0] mst5_slv1_size;
wire                                 mst5_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst5_slv2_sel;
wire                    [DATA_MSB:0] hm5_slv2_hwdata;
wire                    [DATA_MSB:0] mst5_hs2_hrdata;
wire                                 mst5_hs2_hready;
wire                           [1:0] mst5_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv2_base;
wire                                 mst5_slv2_grant;
wire                    [ADDR_MSB:0] mst5_slv2_haddr;
wire                           [2:0] mst5_slv2_hburst;
wire                           [3:0] mst5_slv2_hprot;
wire                           [2:0] mst5_slv2_hsize;
wire                           [1:0] mst5_slv2_htrans;
wire                                 mst5_slv2_hwrite;
wire                                 mst5_slv2_req;
wire                           [3:0] mst5_slv2_size;
wire                                 mst5_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst5_slv3_sel;
wire                    [DATA_MSB:0] hm5_slv3_hwdata;
wire                    [DATA_MSB:0] mst5_hs3_hrdata;
wire                                 mst5_hs3_hready;
wire                           [1:0] mst5_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv3_base;
wire                                 mst5_slv3_grant;
wire                    [ADDR_MSB:0] mst5_slv3_haddr;
wire                           [2:0] mst5_slv3_hburst;
wire                           [3:0] mst5_slv3_hprot;
wire                           [2:0] mst5_slv3_hsize;
wire                           [1:0] mst5_slv3_htrans;
wire                                 mst5_slv3_hwrite;
wire                                 mst5_slv3_req;
wire                           [3:0] mst5_slv3_size;
wire                                 mst5_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst5_slv4_sel;
wire                    [DATA_MSB:0] hm5_slv4_hwdata;
wire                    [DATA_MSB:0] mst5_hs4_hrdata;
wire                                 mst5_hs4_hready;
wire                           [1:0] mst5_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv4_base;
wire                                 mst5_slv4_grant;
wire                    [ADDR_MSB:0] mst5_slv4_haddr;
wire                           [2:0] mst5_slv4_hburst;
wire                           [3:0] mst5_slv4_hprot;
wire                           [2:0] mst5_slv4_hsize;
wire                           [1:0] mst5_slv4_htrans;
wire                                 mst5_slv4_hwrite;
wire                                 mst5_slv4_req;
wire                           [3:0] mst5_slv4_size;
wire                                 mst5_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst5_slv5_sel;
wire                    [DATA_MSB:0] hm5_slv5_hwdata;
wire                    [DATA_MSB:0] mst5_hs5_hrdata;
wire                                 mst5_hs5_hready;
wire                           [1:0] mst5_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv5_base;
wire                                 mst5_slv5_grant;
wire                    [ADDR_MSB:0] mst5_slv5_haddr;
wire                           [2:0] mst5_slv5_hburst;
wire                           [3:0] mst5_slv5_hprot;
wire                           [2:0] mst5_slv5_hsize;
wire                           [1:0] mst5_slv5_htrans;
wire                                 mst5_slv5_hwrite;
wire                                 mst5_slv5_req;
wire                           [3:0] mst5_slv5_size;
wire                                 mst5_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst5_slv6_sel;
wire                    [DATA_MSB:0] hm5_slv6_hwdata;
wire                    [DATA_MSB:0] mst5_hs6_hrdata;
wire                                 mst5_hs6_hready;
wire                           [1:0] mst5_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv6_base;
wire                                 mst5_slv6_grant;
wire                    [ADDR_MSB:0] mst5_slv6_haddr;
wire                           [2:0] mst5_slv6_hburst;
wire                           [3:0] mst5_slv6_hprot;
wire                           [2:0] mst5_slv6_hsize;
wire                           [1:0] mst5_slv6_htrans;
wire                                 mst5_slv6_hwrite;
wire                                 mst5_slv6_req;
wire                           [3:0] mst5_slv6_size;
wire                                 mst5_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst5_slv7_sel;
wire                    [DATA_MSB:0] hm5_slv7_hwdata;
wire                    [DATA_MSB:0] mst5_hs7_hrdata;
wire                                 mst5_hs7_hready;
wire                           [1:0] mst5_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv7_base;
wire                                 mst5_slv7_grant;
wire                    [ADDR_MSB:0] mst5_slv7_haddr;
wire                           [2:0] mst5_slv7_hburst;
wire                           [3:0] mst5_slv7_hprot;
wire                           [2:0] mst5_slv7_hsize;
wire                           [1:0] mst5_slv7_htrans;
wire                                 mst5_slv7_hwrite;
wire                                 mst5_slv7_req;
wire                           [3:0] mst5_slv7_size;
wire                                 mst5_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst5_slv8_sel;
wire                    [DATA_MSB:0] hm5_slv8_hwdata;
wire                    [DATA_MSB:0] mst5_hs8_hrdata;
wire                                 mst5_hs8_hready;
wire                           [1:0] mst5_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv8_base;
wire                                 mst5_slv8_grant;
wire                    [ADDR_MSB:0] mst5_slv8_haddr;
wire                           [2:0] mst5_slv8_hburst;
wire                           [3:0] mst5_slv8_hprot;
wire                           [2:0] mst5_slv8_hsize;
wire                           [1:0] mst5_slv8_htrans;
wire                                 mst5_slv8_hwrite;
wire                                 mst5_slv8_req;
wire                           [3:0] mst5_slv8_size;
wire                                 mst5_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst5_slv9_sel;
wire                    [DATA_MSB:0] hm5_slv9_hwdata;
wire                    [DATA_MSB:0] mst5_hs9_hrdata;
wire                                 mst5_hs9_hready;
wire                           [1:0] mst5_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv9_base;
wire                                 mst5_slv9_grant;
wire                    [ADDR_MSB:0] mst5_slv9_haddr;
wire                           [2:0] mst5_slv9_hburst;
wire                           [3:0] mst5_slv9_hprot;
wire                           [2:0] mst5_slv9_hsize;
wire                           [1:0] mst5_slv9_htrans;
wire                                 mst5_slv9_hwrite;
wire                                 mst5_slv9_req;
wire                           [3:0] mst5_slv9_size;
wire                                 mst5_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst5_slv10_sel;
wire                    [DATA_MSB:0] hm5_slv10_hwdata;
wire                    [DATA_MSB:0] mst5_hs10_hrdata;
wire                                 mst5_hs10_hready;
wire                           [1:0] mst5_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv10_base;
wire                                 mst5_slv10_grant;
wire                    [ADDR_MSB:0] mst5_slv10_haddr;
wire                           [2:0] mst5_slv10_hburst;
wire                           [3:0] mst5_slv10_hprot;
wire                           [2:0] mst5_slv10_hsize;
wire                           [1:0] mst5_slv10_htrans;
wire                                 mst5_slv10_hwrite;
wire                                 mst5_slv10_req;
wire                           [3:0] mst5_slv10_size;
wire                                 mst5_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst5_slv11_sel;
wire                    [DATA_MSB:0] hm5_slv11_hwdata;
wire                    [DATA_MSB:0] mst5_hs11_hrdata;
wire                                 mst5_hs11_hready;
wire                           [1:0] mst5_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv11_base;
wire                                 mst5_slv11_grant;
wire                    [ADDR_MSB:0] mst5_slv11_haddr;
wire                           [2:0] mst5_slv11_hburst;
wire                           [3:0] mst5_slv11_hprot;
wire                           [2:0] mst5_slv11_hsize;
wire                           [1:0] mst5_slv11_htrans;
wire                                 mst5_slv11_hwrite;
wire                                 mst5_slv11_req;
wire                           [3:0] mst5_slv11_size;
wire                                 mst5_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst5_slv12_sel;
wire                    [DATA_MSB:0] hm5_slv12_hwdata;
wire                    [DATA_MSB:0] mst5_hs12_hrdata;
wire                                 mst5_hs12_hready;
wire                           [1:0] mst5_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv12_base;
wire                                 mst5_slv12_grant;
wire                    [ADDR_MSB:0] mst5_slv12_haddr;
wire                           [2:0] mst5_slv12_hburst;
wire                           [3:0] mst5_slv12_hprot;
wire                           [2:0] mst5_slv12_hsize;
wire                           [1:0] mst5_slv12_htrans;
wire                                 mst5_slv12_hwrite;
wire                                 mst5_slv12_req;
wire                           [3:0] mst5_slv12_size;
wire                                 mst5_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst5_slv13_sel;
wire                    [DATA_MSB:0] hm5_slv13_hwdata;
wire                    [DATA_MSB:0] mst5_hs13_hrdata;
wire                                 mst5_hs13_hready;
wire                           [1:0] mst5_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv13_base;
wire                                 mst5_slv13_grant;
wire                    [ADDR_MSB:0] mst5_slv13_haddr;
wire                           [2:0] mst5_slv13_hburst;
wire                           [3:0] mst5_slv13_hprot;
wire                           [2:0] mst5_slv13_hsize;
wire                           [1:0] mst5_slv13_htrans;
wire                                 mst5_slv13_hwrite;
wire                                 mst5_slv13_req;
wire                           [3:0] mst5_slv13_size;
wire                                 mst5_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst5_slv14_sel;
wire                    [DATA_MSB:0] hm5_slv14_hwdata;
wire                    [DATA_MSB:0] mst5_hs14_hrdata;
wire                                 mst5_hs14_hready;
wire                           [1:0] mst5_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv14_base;
wire                                 mst5_slv14_grant;
wire                    [ADDR_MSB:0] mst5_slv14_haddr;
wire                           [2:0] mst5_slv14_hburst;
wire                           [3:0] mst5_slv14_hprot;
wire                           [2:0] mst5_slv14_hsize;
wire                           [1:0] mst5_slv14_htrans;
wire                                 mst5_slv14_hwrite;
wire                                 mst5_slv14_req;
wire                           [3:0] mst5_slv14_size;
wire                                 mst5_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst5_slv15_sel;
wire                    [DATA_MSB:0] hm5_slv15_hwdata;
wire                    [DATA_MSB:0] mst5_hs15_hrdata;
wire                                 mst5_hs15_hready;
wire                           [1:0] mst5_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv15_base;
wire                                 mst5_slv15_grant;
wire                    [ADDR_MSB:0] mst5_slv15_haddr;
wire                           [2:0] mst5_slv15_hburst;
wire                           [3:0] mst5_slv15_hprot;
wire                           [2:0] mst5_slv15_hsize;
wire                           [1:0] mst5_slv15_htrans;
wire                                 mst5_slv15_hwrite;
wire                                 mst5_slv15_req;
wire                           [3:0] mst5_slv15_size;
wire                                 mst5_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst5_slv0_sel;
wire                    [DATA_MSB:0] hm5_slv0_hwdata;
wire                    [DATA_MSB:0] mst5_hs0_hrdata;
wire                                 mst5_hs0_hready;
wire                           [1:0] mst5_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst5_slv0_base;
wire                                 mst5_slv0_grant;
wire                    [ADDR_MSB:0] mst5_slv0_haddr;
wire                           [2:0] mst5_slv0_hburst;
wire                           [3:0] mst5_slv0_hprot;
wire                           [2:0] mst5_slv0_hsize;
wire                           [1:0] mst5_slv0_htrans;
wire                                 mst5_slv0_hwrite;
wire                                 mst5_slv0_req;
wire                           [3:0] mst5_slv0_size;
wire                                 mst5_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST6
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst6_slv1_sel;
wire                    [DATA_MSB:0] hm6_slv1_hwdata;
wire                    [DATA_MSB:0] mst6_hs1_hrdata;
wire                                 mst6_hs1_hready;
wire                           [1:0] mst6_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv1_base;
wire                                 mst6_slv1_grant;
wire                    [ADDR_MSB:0] mst6_slv1_haddr;
wire                           [2:0] mst6_slv1_hburst;
wire                           [3:0] mst6_slv1_hprot;
wire                           [2:0] mst6_slv1_hsize;
wire                           [1:0] mst6_slv1_htrans;
wire                                 mst6_slv1_hwrite;
wire                                 mst6_slv1_req;
wire                           [3:0] mst6_slv1_size;
wire                                 mst6_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst6_slv2_sel;
wire                    [DATA_MSB:0] hm6_slv2_hwdata;
wire                    [DATA_MSB:0] mst6_hs2_hrdata;
wire                                 mst6_hs2_hready;
wire                           [1:0] mst6_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv2_base;
wire                                 mst6_slv2_grant;
wire                    [ADDR_MSB:0] mst6_slv2_haddr;
wire                           [2:0] mst6_slv2_hburst;
wire                           [3:0] mst6_slv2_hprot;
wire                           [2:0] mst6_slv2_hsize;
wire                           [1:0] mst6_slv2_htrans;
wire                                 mst6_slv2_hwrite;
wire                                 mst6_slv2_req;
wire                           [3:0] mst6_slv2_size;
wire                                 mst6_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst6_slv3_sel;
wire                    [DATA_MSB:0] hm6_slv3_hwdata;
wire                    [DATA_MSB:0] mst6_hs3_hrdata;
wire                                 mst6_hs3_hready;
wire                           [1:0] mst6_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv3_base;
wire                                 mst6_slv3_grant;
wire                    [ADDR_MSB:0] mst6_slv3_haddr;
wire                           [2:0] mst6_slv3_hburst;
wire                           [3:0] mst6_slv3_hprot;
wire                           [2:0] mst6_slv3_hsize;
wire                           [1:0] mst6_slv3_htrans;
wire                                 mst6_slv3_hwrite;
wire                                 mst6_slv3_req;
wire                           [3:0] mst6_slv3_size;
wire                                 mst6_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst6_slv4_sel;
wire                    [DATA_MSB:0] hm6_slv4_hwdata;
wire                    [DATA_MSB:0] mst6_hs4_hrdata;
wire                                 mst6_hs4_hready;
wire                           [1:0] mst6_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv4_base;
wire                                 mst6_slv4_grant;
wire                    [ADDR_MSB:0] mst6_slv4_haddr;
wire                           [2:0] mst6_slv4_hburst;
wire                           [3:0] mst6_slv4_hprot;
wire                           [2:0] mst6_slv4_hsize;
wire                           [1:0] mst6_slv4_htrans;
wire                                 mst6_slv4_hwrite;
wire                                 mst6_slv4_req;
wire                           [3:0] mst6_slv4_size;
wire                                 mst6_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst6_slv5_sel;
wire                    [DATA_MSB:0] hm6_slv5_hwdata;
wire                    [DATA_MSB:0] mst6_hs5_hrdata;
wire                                 mst6_hs5_hready;
wire                           [1:0] mst6_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv5_base;
wire                                 mst6_slv5_grant;
wire                    [ADDR_MSB:0] mst6_slv5_haddr;
wire                           [2:0] mst6_slv5_hburst;
wire                           [3:0] mst6_slv5_hprot;
wire                           [2:0] mst6_slv5_hsize;
wire                           [1:0] mst6_slv5_htrans;
wire                                 mst6_slv5_hwrite;
wire                                 mst6_slv5_req;
wire                           [3:0] mst6_slv5_size;
wire                                 mst6_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst6_slv6_sel;
wire                    [DATA_MSB:0] hm6_slv6_hwdata;
wire                    [DATA_MSB:0] mst6_hs6_hrdata;
wire                                 mst6_hs6_hready;
wire                           [1:0] mst6_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv6_base;
wire                                 mst6_slv6_grant;
wire                    [ADDR_MSB:0] mst6_slv6_haddr;
wire                           [2:0] mst6_slv6_hburst;
wire                           [3:0] mst6_slv6_hprot;
wire                           [2:0] mst6_slv6_hsize;
wire                           [1:0] mst6_slv6_htrans;
wire                                 mst6_slv6_hwrite;
wire                                 mst6_slv6_req;
wire                           [3:0] mst6_slv6_size;
wire                                 mst6_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst6_slv7_sel;
wire                    [DATA_MSB:0] hm6_slv7_hwdata;
wire                    [DATA_MSB:0] mst6_hs7_hrdata;
wire                                 mst6_hs7_hready;
wire                           [1:0] mst6_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv7_base;
wire                                 mst6_slv7_grant;
wire                    [ADDR_MSB:0] mst6_slv7_haddr;
wire                           [2:0] mst6_slv7_hburst;
wire                           [3:0] mst6_slv7_hprot;
wire                           [2:0] mst6_slv7_hsize;
wire                           [1:0] mst6_slv7_htrans;
wire                                 mst6_slv7_hwrite;
wire                                 mst6_slv7_req;
wire                           [3:0] mst6_slv7_size;
wire                                 mst6_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst6_slv8_sel;
wire                    [DATA_MSB:0] hm6_slv8_hwdata;
wire                    [DATA_MSB:0] mst6_hs8_hrdata;
wire                                 mst6_hs8_hready;
wire                           [1:0] mst6_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv8_base;
wire                                 mst6_slv8_grant;
wire                    [ADDR_MSB:0] mst6_slv8_haddr;
wire                           [2:0] mst6_slv8_hburst;
wire                           [3:0] mst6_slv8_hprot;
wire                           [2:0] mst6_slv8_hsize;
wire                           [1:0] mst6_slv8_htrans;
wire                                 mst6_slv8_hwrite;
wire                                 mst6_slv8_req;
wire                           [3:0] mst6_slv8_size;
wire                                 mst6_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst6_slv9_sel;
wire                    [DATA_MSB:0] hm6_slv9_hwdata;
wire                    [DATA_MSB:0] mst6_hs9_hrdata;
wire                                 mst6_hs9_hready;
wire                           [1:0] mst6_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv9_base;
wire                                 mst6_slv9_grant;
wire                    [ADDR_MSB:0] mst6_slv9_haddr;
wire                           [2:0] mst6_slv9_hburst;
wire                           [3:0] mst6_slv9_hprot;
wire                           [2:0] mst6_slv9_hsize;
wire                           [1:0] mst6_slv9_htrans;
wire                                 mst6_slv9_hwrite;
wire                                 mst6_slv9_req;
wire                           [3:0] mst6_slv9_size;
wire                                 mst6_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst6_slv10_sel;
wire                    [DATA_MSB:0] hm6_slv10_hwdata;
wire                    [DATA_MSB:0] mst6_hs10_hrdata;
wire                                 mst6_hs10_hready;
wire                           [1:0] mst6_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv10_base;
wire                                 mst6_slv10_grant;
wire                    [ADDR_MSB:0] mst6_slv10_haddr;
wire                           [2:0] mst6_slv10_hburst;
wire                           [3:0] mst6_slv10_hprot;
wire                           [2:0] mst6_slv10_hsize;
wire                           [1:0] mst6_slv10_htrans;
wire                                 mst6_slv10_hwrite;
wire                                 mst6_slv10_req;
wire                           [3:0] mst6_slv10_size;
wire                                 mst6_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst6_slv11_sel;
wire                    [DATA_MSB:0] hm6_slv11_hwdata;
wire                    [DATA_MSB:0] mst6_hs11_hrdata;
wire                                 mst6_hs11_hready;
wire                           [1:0] mst6_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv11_base;
wire                                 mst6_slv11_grant;
wire                    [ADDR_MSB:0] mst6_slv11_haddr;
wire                           [2:0] mst6_slv11_hburst;
wire                           [3:0] mst6_slv11_hprot;
wire                           [2:0] mst6_slv11_hsize;
wire                           [1:0] mst6_slv11_htrans;
wire                                 mst6_slv11_hwrite;
wire                                 mst6_slv11_req;
wire                           [3:0] mst6_slv11_size;
wire                                 mst6_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst6_slv12_sel;
wire                    [DATA_MSB:0] hm6_slv12_hwdata;
wire                    [DATA_MSB:0] mst6_hs12_hrdata;
wire                                 mst6_hs12_hready;
wire                           [1:0] mst6_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv12_base;
wire                                 mst6_slv12_grant;
wire                    [ADDR_MSB:0] mst6_slv12_haddr;
wire                           [2:0] mst6_slv12_hburst;
wire                           [3:0] mst6_slv12_hprot;
wire                           [2:0] mst6_slv12_hsize;
wire                           [1:0] mst6_slv12_htrans;
wire                                 mst6_slv12_hwrite;
wire                                 mst6_slv12_req;
wire                           [3:0] mst6_slv12_size;
wire                                 mst6_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst6_slv13_sel;
wire                    [DATA_MSB:0] hm6_slv13_hwdata;
wire                    [DATA_MSB:0] mst6_hs13_hrdata;
wire                                 mst6_hs13_hready;
wire                           [1:0] mst6_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv13_base;
wire                                 mst6_slv13_grant;
wire                    [ADDR_MSB:0] mst6_slv13_haddr;
wire                           [2:0] mst6_slv13_hburst;
wire                           [3:0] mst6_slv13_hprot;
wire                           [2:0] mst6_slv13_hsize;
wire                           [1:0] mst6_slv13_htrans;
wire                                 mst6_slv13_hwrite;
wire                                 mst6_slv13_req;
wire                           [3:0] mst6_slv13_size;
wire                                 mst6_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst6_slv14_sel;
wire                    [DATA_MSB:0] hm6_slv14_hwdata;
wire                    [DATA_MSB:0] mst6_hs14_hrdata;
wire                                 mst6_hs14_hready;
wire                           [1:0] mst6_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv14_base;
wire                                 mst6_slv14_grant;
wire                    [ADDR_MSB:0] mst6_slv14_haddr;
wire                           [2:0] mst6_slv14_hburst;
wire                           [3:0] mst6_slv14_hprot;
wire                           [2:0] mst6_slv14_hsize;
wire                           [1:0] mst6_slv14_htrans;
wire                                 mst6_slv14_hwrite;
wire                                 mst6_slv14_req;
wire                           [3:0] mst6_slv14_size;
wire                                 mst6_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst6_slv15_sel;
wire                    [DATA_MSB:0] hm6_slv15_hwdata;
wire                    [DATA_MSB:0] mst6_hs15_hrdata;
wire                                 mst6_hs15_hready;
wire                           [1:0] mst6_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv15_base;
wire                                 mst6_slv15_grant;
wire                    [ADDR_MSB:0] mst6_slv15_haddr;
wire                           [2:0] mst6_slv15_hburst;
wire                           [3:0] mst6_slv15_hprot;
wire                           [2:0] mst6_slv15_hsize;
wire                           [1:0] mst6_slv15_htrans;
wire                                 mst6_slv15_hwrite;
wire                                 mst6_slv15_req;
wire                           [3:0] mst6_slv15_size;
wire                                 mst6_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst6_slv0_sel;
wire                    [DATA_MSB:0] hm6_slv0_hwdata;
wire                    [DATA_MSB:0] mst6_hs0_hrdata;
wire                                 mst6_hs0_hready;
wire                           [1:0] mst6_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst6_slv0_base;
wire                                 mst6_slv0_grant;
wire                    [ADDR_MSB:0] mst6_slv0_haddr;
wire                           [2:0] mst6_slv0_hburst;
wire                           [3:0] mst6_slv0_hprot;
wire                           [2:0] mst6_slv0_hsize;
wire                           [1:0] mst6_slv0_htrans;
wire                                 mst6_slv0_hwrite;
wire                                 mst6_slv0_req;
wire                           [3:0] mst6_slv0_size;
wire                                 mst6_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST7
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst7_slv1_sel;
wire                    [DATA_MSB:0] hm7_slv1_hwdata;
wire                    [DATA_MSB:0] mst7_hs1_hrdata;
wire                                 mst7_hs1_hready;
wire                           [1:0] mst7_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv1_base;
wire                                 mst7_slv1_grant;
wire                    [ADDR_MSB:0] mst7_slv1_haddr;
wire                           [2:0] mst7_slv1_hburst;
wire                           [3:0] mst7_slv1_hprot;
wire                           [2:0] mst7_slv1_hsize;
wire                           [1:0] mst7_slv1_htrans;
wire                                 mst7_slv1_hwrite;
wire                                 mst7_slv1_req;
wire                           [3:0] mst7_slv1_size;
wire                                 mst7_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst7_slv2_sel;
wire                    [DATA_MSB:0] hm7_slv2_hwdata;
wire                    [DATA_MSB:0] mst7_hs2_hrdata;
wire                                 mst7_hs2_hready;
wire                           [1:0] mst7_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv2_base;
wire                                 mst7_slv2_grant;
wire                    [ADDR_MSB:0] mst7_slv2_haddr;
wire                           [2:0] mst7_slv2_hburst;
wire                           [3:0] mst7_slv2_hprot;
wire                           [2:0] mst7_slv2_hsize;
wire                           [1:0] mst7_slv2_htrans;
wire                                 mst7_slv2_hwrite;
wire                                 mst7_slv2_req;
wire                           [3:0] mst7_slv2_size;
wire                                 mst7_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst7_slv3_sel;
wire                    [DATA_MSB:0] hm7_slv3_hwdata;
wire                    [DATA_MSB:0] mst7_hs3_hrdata;
wire                                 mst7_hs3_hready;
wire                           [1:0] mst7_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv3_base;
wire                                 mst7_slv3_grant;
wire                    [ADDR_MSB:0] mst7_slv3_haddr;
wire                           [2:0] mst7_slv3_hburst;
wire                           [3:0] mst7_slv3_hprot;
wire                           [2:0] mst7_slv3_hsize;
wire                           [1:0] mst7_slv3_htrans;
wire                                 mst7_slv3_hwrite;
wire                                 mst7_slv3_req;
wire                           [3:0] mst7_slv3_size;
wire                                 mst7_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst7_slv4_sel;
wire                    [DATA_MSB:0] hm7_slv4_hwdata;
wire                    [DATA_MSB:0] mst7_hs4_hrdata;
wire                                 mst7_hs4_hready;
wire                           [1:0] mst7_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv4_base;
wire                                 mst7_slv4_grant;
wire                    [ADDR_MSB:0] mst7_slv4_haddr;
wire                           [2:0] mst7_slv4_hburst;
wire                           [3:0] mst7_slv4_hprot;
wire                           [2:0] mst7_slv4_hsize;
wire                           [1:0] mst7_slv4_htrans;
wire                                 mst7_slv4_hwrite;
wire                                 mst7_slv4_req;
wire                           [3:0] mst7_slv4_size;
wire                                 mst7_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst7_slv5_sel;
wire                    [DATA_MSB:0] hm7_slv5_hwdata;
wire                    [DATA_MSB:0] mst7_hs5_hrdata;
wire                                 mst7_hs5_hready;
wire                           [1:0] mst7_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv5_base;
wire                                 mst7_slv5_grant;
wire                    [ADDR_MSB:0] mst7_slv5_haddr;
wire                           [2:0] mst7_slv5_hburst;
wire                           [3:0] mst7_slv5_hprot;
wire                           [2:0] mst7_slv5_hsize;
wire                           [1:0] mst7_slv5_htrans;
wire                                 mst7_slv5_hwrite;
wire                                 mst7_slv5_req;
wire                           [3:0] mst7_slv5_size;
wire                                 mst7_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst7_slv6_sel;
wire                    [DATA_MSB:0] hm7_slv6_hwdata;
wire                    [DATA_MSB:0] mst7_hs6_hrdata;
wire                                 mst7_hs6_hready;
wire                           [1:0] mst7_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv6_base;
wire                                 mst7_slv6_grant;
wire                    [ADDR_MSB:0] mst7_slv6_haddr;
wire                           [2:0] mst7_slv6_hburst;
wire                           [3:0] mst7_slv6_hprot;
wire                           [2:0] mst7_slv6_hsize;
wire                           [1:0] mst7_slv6_htrans;
wire                                 mst7_slv6_hwrite;
wire                                 mst7_slv6_req;
wire                           [3:0] mst7_slv6_size;
wire                                 mst7_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst7_slv7_sel;
wire                    [DATA_MSB:0] hm7_slv7_hwdata;
wire                    [DATA_MSB:0] mst7_hs7_hrdata;
wire                                 mst7_hs7_hready;
wire                           [1:0] mst7_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv7_base;
wire                                 mst7_slv7_grant;
wire                    [ADDR_MSB:0] mst7_slv7_haddr;
wire                           [2:0] mst7_slv7_hburst;
wire                           [3:0] mst7_slv7_hprot;
wire                           [2:0] mst7_slv7_hsize;
wire                           [1:0] mst7_slv7_htrans;
wire                                 mst7_slv7_hwrite;
wire                                 mst7_slv7_req;
wire                           [3:0] mst7_slv7_size;
wire                                 mst7_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst7_slv8_sel;
wire                    [DATA_MSB:0] hm7_slv8_hwdata;
wire                    [DATA_MSB:0] mst7_hs8_hrdata;
wire                                 mst7_hs8_hready;
wire                           [1:0] mst7_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv8_base;
wire                                 mst7_slv8_grant;
wire                    [ADDR_MSB:0] mst7_slv8_haddr;
wire                           [2:0] mst7_slv8_hburst;
wire                           [3:0] mst7_slv8_hprot;
wire                           [2:0] mst7_slv8_hsize;
wire                           [1:0] mst7_slv8_htrans;
wire                                 mst7_slv8_hwrite;
wire                                 mst7_slv8_req;
wire                           [3:0] mst7_slv8_size;
wire                                 mst7_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst7_slv9_sel;
wire                    [DATA_MSB:0] hm7_slv9_hwdata;
wire                    [DATA_MSB:0] mst7_hs9_hrdata;
wire                                 mst7_hs9_hready;
wire                           [1:0] mst7_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv9_base;
wire                                 mst7_slv9_grant;
wire                    [ADDR_MSB:0] mst7_slv9_haddr;
wire                           [2:0] mst7_slv9_hburst;
wire                           [3:0] mst7_slv9_hprot;
wire                           [2:0] mst7_slv9_hsize;
wire                           [1:0] mst7_slv9_htrans;
wire                                 mst7_slv9_hwrite;
wire                                 mst7_slv9_req;
wire                           [3:0] mst7_slv9_size;
wire                                 mst7_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst7_slv10_sel;
wire                    [DATA_MSB:0] hm7_slv10_hwdata;
wire                    [DATA_MSB:0] mst7_hs10_hrdata;
wire                                 mst7_hs10_hready;
wire                           [1:0] mst7_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv10_base;
wire                                 mst7_slv10_grant;
wire                    [ADDR_MSB:0] mst7_slv10_haddr;
wire                           [2:0] mst7_slv10_hburst;
wire                           [3:0] mst7_slv10_hprot;
wire                           [2:0] mst7_slv10_hsize;
wire                           [1:0] mst7_slv10_htrans;
wire                                 mst7_slv10_hwrite;
wire                                 mst7_slv10_req;
wire                           [3:0] mst7_slv10_size;
wire                                 mst7_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst7_slv11_sel;
wire                    [DATA_MSB:0] hm7_slv11_hwdata;
wire                    [DATA_MSB:0] mst7_hs11_hrdata;
wire                                 mst7_hs11_hready;
wire                           [1:0] mst7_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv11_base;
wire                                 mst7_slv11_grant;
wire                    [ADDR_MSB:0] mst7_slv11_haddr;
wire                           [2:0] mst7_slv11_hburst;
wire                           [3:0] mst7_slv11_hprot;
wire                           [2:0] mst7_slv11_hsize;
wire                           [1:0] mst7_slv11_htrans;
wire                                 mst7_slv11_hwrite;
wire                                 mst7_slv11_req;
wire                           [3:0] mst7_slv11_size;
wire                                 mst7_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst7_slv12_sel;
wire                    [DATA_MSB:0] hm7_slv12_hwdata;
wire                    [DATA_MSB:0] mst7_hs12_hrdata;
wire                                 mst7_hs12_hready;
wire                           [1:0] mst7_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv12_base;
wire                                 mst7_slv12_grant;
wire                    [ADDR_MSB:0] mst7_slv12_haddr;
wire                           [2:0] mst7_slv12_hburst;
wire                           [3:0] mst7_slv12_hprot;
wire                           [2:0] mst7_slv12_hsize;
wire                           [1:0] mst7_slv12_htrans;
wire                                 mst7_slv12_hwrite;
wire                                 mst7_slv12_req;
wire                           [3:0] mst7_slv12_size;
wire                                 mst7_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst7_slv13_sel;
wire                    [DATA_MSB:0] hm7_slv13_hwdata;
wire                    [DATA_MSB:0] mst7_hs13_hrdata;
wire                                 mst7_hs13_hready;
wire                           [1:0] mst7_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv13_base;
wire                                 mst7_slv13_grant;
wire                    [ADDR_MSB:0] mst7_slv13_haddr;
wire                           [2:0] mst7_slv13_hburst;
wire                           [3:0] mst7_slv13_hprot;
wire                           [2:0] mst7_slv13_hsize;
wire                           [1:0] mst7_slv13_htrans;
wire                                 mst7_slv13_hwrite;
wire                                 mst7_slv13_req;
wire                           [3:0] mst7_slv13_size;
wire                                 mst7_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst7_slv14_sel;
wire                    [DATA_MSB:0] hm7_slv14_hwdata;
wire                    [DATA_MSB:0] mst7_hs14_hrdata;
wire                                 mst7_hs14_hready;
wire                           [1:0] mst7_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv14_base;
wire                                 mst7_slv14_grant;
wire                    [ADDR_MSB:0] mst7_slv14_haddr;
wire                           [2:0] mst7_slv14_hburst;
wire                           [3:0] mst7_slv14_hprot;
wire                           [2:0] mst7_slv14_hsize;
wire                           [1:0] mst7_slv14_htrans;
wire                                 mst7_slv14_hwrite;
wire                                 mst7_slv14_req;
wire                           [3:0] mst7_slv14_size;
wire                                 mst7_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst7_slv15_sel;
wire                    [DATA_MSB:0] hm7_slv15_hwdata;
wire                    [DATA_MSB:0] mst7_hs15_hrdata;
wire                                 mst7_hs15_hready;
wire                           [1:0] mst7_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv15_base;
wire                                 mst7_slv15_grant;
wire                    [ADDR_MSB:0] mst7_slv15_haddr;
wire                           [2:0] mst7_slv15_hburst;
wire                           [3:0] mst7_slv15_hprot;
wire                           [2:0] mst7_slv15_hsize;
wire                           [1:0] mst7_slv15_htrans;
wire                                 mst7_slv15_hwrite;
wire                                 mst7_slv15_req;
wire                           [3:0] mst7_slv15_size;
wire                                 mst7_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst7_slv0_sel;
wire                    [DATA_MSB:0] hm7_slv0_hwdata;
wire                    [DATA_MSB:0] mst7_hs0_hrdata;
wire                                 mst7_hs0_hready;
wire                           [1:0] mst7_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst7_slv0_base;
wire                                 mst7_slv0_grant;
wire                    [ADDR_MSB:0] mst7_slv0_haddr;
wire                           [2:0] mst7_slv0_hburst;
wire                           [3:0] mst7_slv0_hprot;
wire                           [2:0] mst7_slv0_hsize;
wire                           [1:0] mst7_slv0_htrans;
wire                                 mst7_slv0_hwrite;
wire                                 mst7_slv0_req;
wire                           [3:0] mst7_slv0_size;
wire                                 mst7_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST8
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst8_slv1_sel;
wire                    [DATA_MSB:0] hm8_slv1_hwdata;
wire                    [DATA_MSB:0] mst8_hs1_hrdata;
wire                                 mst8_hs1_hready;
wire                           [1:0] mst8_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv1_base;
wire                                 mst8_slv1_grant;
wire                    [ADDR_MSB:0] mst8_slv1_haddr;
wire                           [2:0] mst8_slv1_hburst;
wire                           [3:0] mst8_slv1_hprot;
wire                           [2:0] mst8_slv1_hsize;
wire                           [1:0] mst8_slv1_htrans;
wire                                 mst8_slv1_hwrite;
wire                                 mst8_slv1_req;
wire                           [3:0] mst8_slv1_size;
wire                                 mst8_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst8_slv2_sel;
wire                    [DATA_MSB:0] hm8_slv2_hwdata;
wire                    [DATA_MSB:0] mst8_hs2_hrdata;
wire                                 mst8_hs2_hready;
wire                           [1:0] mst8_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv2_base;
wire                                 mst8_slv2_grant;
wire                    [ADDR_MSB:0] mst8_slv2_haddr;
wire                           [2:0] mst8_slv2_hburst;
wire                           [3:0] mst8_slv2_hprot;
wire                           [2:0] mst8_slv2_hsize;
wire                           [1:0] mst8_slv2_htrans;
wire                                 mst8_slv2_hwrite;
wire                                 mst8_slv2_req;
wire                           [3:0] mst8_slv2_size;
wire                                 mst8_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst8_slv3_sel;
wire                    [DATA_MSB:0] hm8_slv3_hwdata;
wire                    [DATA_MSB:0] mst8_hs3_hrdata;
wire                                 mst8_hs3_hready;
wire                           [1:0] mst8_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv3_base;
wire                                 mst8_slv3_grant;
wire                    [ADDR_MSB:0] mst8_slv3_haddr;
wire                           [2:0] mst8_slv3_hburst;
wire                           [3:0] mst8_slv3_hprot;
wire                           [2:0] mst8_slv3_hsize;
wire                           [1:0] mst8_slv3_htrans;
wire                                 mst8_slv3_hwrite;
wire                                 mst8_slv3_req;
wire                           [3:0] mst8_slv3_size;
wire                                 mst8_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst8_slv4_sel;
wire                    [DATA_MSB:0] hm8_slv4_hwdata;
wire                    [DATA_MSB:0] mst8_hs4_hrdata;
wire                                 mst8_hs4_hready;
wire                           [1:0] mst8_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv4_base;
wire                                 mst8_slv4_grant;
wire                    [ADDR_MSB:0] mst8_slv4_haddr;
wire                           [2:0] mst8_slv4_hburst;
wire                           [3:0] mst8_slv4_hprot;
wire                           [2:0] mst8_slv4_hsize;
wire                           [1:0] mst8_slv4_htrans;
wire                                 mst8_slv4_hwrite;
wire                                 mst8_slv4_req;
wire                           [3:0] mst8_slv4_size;
wire                                 mst8_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst8_slv5_sel;
wire                    [DATA_MSB:0] hm8_slv5_hwdata;
wire                    [DATA_MSB:0] mst8_hs5_hrdata;
wire                                 mst8_hs5_hready;
wire                           [1:0] mst8_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv5_base;
wire                                 mst8_slv5_grant;
wire                    [ADDR_MSB:0] mst8_slv5_haddr;
wire                           [2:0] mst8_slv5_hburst;
wire                           [3:0] mst8_slv5_hprot;
wire                           [2:0] mst8_slv5_hsize;
wire                           [1:0] mst8_slv5_htrans;
wire                                 mst8_slv5_hwrite;
wire                                 mst8_slv5_req;
wire                           [3:0] mst8_slv5_size;
wire                                 mst8_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst8_slv6_sel;
wire                    [DATA_MSB:0] hm8_slv6_hwdata;
wire                    [DATA_MSB:0] mst8_hs6_hrdata;
wire                                 mst8_hs6_hready;
wire                           [1:0] mst8_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv6_base;
wire                                 mst8_slv6_grant;
wire                    [ADDR_MSB:0] mst8_slv6_haddr;
wire                           [2:0] mst8_slv6_hburst;
wire                           [3:0] mst8_slv6_hprot;
wire                           [2:0] mst8_slv6_hsize;
wire                           [1:0] mst8_slv6_htrans;
wire                                 mst8_slv6_hwrite;
wire                                 mst8_slv6_req;
wire                           [3:0] mst8_slv6_size;
wire                                 mst8_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst8_slv7_sel;
wire                    [DATA_MSB:0] hm8_slv7_hwdata;
wire                    [DATA_MSB:0] mst8_hs7_hrdata;
wire                                 mst8_hs7_hready;
wire                           [1:0] mst8_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv7_base;
wire                                 mst8_slv7_grant;
wire                    [ADDR_MSB:0] mst8_slv7_haddr;
wire                           [2:0] mst8_slv7_hburst;
wire                           [3:0] mst8_slv7_hprot;
wire                           [2:0] mst8_slv7_hsize;
wire                           [1:0] mst8_slv7_htrans;
wire                                 mst8_slv7_hwrite;
wire                                 mst8_slv7_req;
wire                           [3:0] mst8_slv7_size;
wire                                 mst8_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst8_slv8_sel;
wire                    [DATA_MSB:0] hm8_slv8_hwdata;
wire                    [DATA_MSB:0] mst8_hs8_hrdata;
wire                                 mst8_hs8_hready;
wire                           [1:0] mst8_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv8_base;
wire                                 mst8_slv8_grant;
wire                    [ADDR_MSB:0] mst8_slv8_haddr;
wire                           [2:0] mst8_slv8_hburst;
wire                           [3:0] mst8_slv8_hprot;
wire                           [2:0] mst8_slv8_hsize;
wire                           [1:0] mst8_slv8_htrans;
wire                                 mst8_slv8_hwrite;
wire                                 mst8_slv8_req;
wire                           [3:0] mst8_slv8_size;
wire                                 mst8_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst8_slv9_sel;
wire                    [DATA_MSB:0] hm8_slv9_hwdata;
wire                    [DATA_MSB:0] mst8_hs9_hrdata;
wire                                 mst8_hs9_hready;
wire                           [1:0] mst8_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv9_base;
wire                                 mst8_slv9_grant;
wire                    [ADDR_MSB:0] mst8_slv9_haddr;
wire                           [2:0] mst8_slv9_hburst;
wire                           [3:0] mst8_slv9_hprot;
wire                           [2:0] mst8_slv9_hsize;
wire                           [1:0] mst8_slv9_htrans;
wire                                 mst8_slv9_hwrite;
wire                                 mst8_slv9_req;
wire                           [3:0] mst8_slv9_size;
wire                                 mst8_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst8_slv10_sel;
wire                    [DATA_MSB:0] hm8_slv10_hwdata;
wire                    [DATA_MSB:0] mst8_hs10_hrdata;
wire                                 mst8_hs10_hready;
wire                           [1:0] mst8_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv10_base;
wire                                 mst8_slv10_grant;
wire                    [ADDR_MSB:0] mst8_slv10_haddr;
wire                           [2:0] mst8_slv10_hburst;
wire                           [3:0] mst8_slv10_hprot;
wire                           [2:0] mst8_slv10_hsize;
wire                           [1:0] mst8_slv10_htrans;
wire                                 mst8_slv10_hwrite;
wire                                 mst8_slv10_req;
wire                           [3:0] mst8_slv10_size;
wire                                 mst8_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst8_slv11_sel;
wire                    [DATA_MSB:0] hm8_slv11_hwdata;
wire                    [DATA_MSB:0] mst8_hs11_hrdata;
wire                                 mst8_hs11_hready;
wire                           [1:0] mst8_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv11_base;
wire                                 mst8_slv11_grant;
wire                    [ADDR_MSB:0] mst8_slv11_haddr;
wire                           [2:0] mst8_slv11_hburst;
wire                           [3:0] mst8_slv11_hprot;
wire                           [2:0] mst8_slv11_hsize;
wire                           [1:0] mst8_slv11_htrans;
wire                                 mst8_slv11_hwrite;
wire                                 mst8_slv11_req;
wire                           [3:0] mst8_slv11_size;
wire                                 mst8_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst8_slv12_sel;
wire                    [DATA_MSB:0] hm8_slv12_hwdata;
wire                    [DATA_MSB:0] mst8_hs12_hrdata;
wire                                 mst8_hs12_hready;
wire                           [1:0] mst8_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv12_base;
wire                                 mst8_slv12_grant;
wire                    [ADDR_MSB:0] mst8_slv12_haddr;
wire                           [2:0] mst8_slv12_hburst;
wire                           [3:0] mst8_slv12_hprot;
wire                           [2:0] mst8_slv12_hsize;
wire                           [1:0] mst8_slv12_htrans;
wire                                 mst8_slv12_hwrite;
wire                                 mst8_slv12_req;
wire                           [3:0] mst8_slv12_size;
wire                                 mst8_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst8_slv13_sel;
wire                    [DATA_MSB:0] hm8_slv13_hwdata;
wire                    [DATA_MSB:0] mst8_hs13_hrdata;
wire                                 mst8_hs13_hready;
wire                           [1:0] mst8_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv13_base;
wire                                 mst8_slv13_grant;
wire                    [ADDR_MSB:0] mst8_slv13_haddr;
wire                           [2:0] mst8_slv13_hburst;
wire                           [3:0] mst8_slv13_hprot;
wire                           [2:0] mst8_slv13_hsize;
wire                           [1:0] mst8_slv13_htrans;
wire                                 mst8_slv13_hwrite;
wire                                 mst8_slv13_req;
wire                           [3:0] mst8_slv13_size;
wire                                 mst8_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst8_slv14_sel;
wire                    [DATA_MSB:0] hm8_slv14_hwdata;
wire                    [DATA_MSB:0] mst8_hs14_hrdata;
wire                                 mst8_hs14_hready;
wire                           [1:0] mst8_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv14_base;
wire                                 mst8_slv14_grant;
wire                    [ADDR_MSB:0] mst8_slv14_haddr;
wire                           [2:0] mst8_slv14_hburst;
wire                           [3:0] mst8_slv14_hprot;
wire                           [2:0] mst8_slv14_hsize;
wire                           [1:0] mst8_slv14_htrans;
wire                                 mst8_slv14_hwrite;
wire                                 mst8_slv14_req;
wire                           [3:0] mst8_slv14_size;
wire                                 mst8_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst8_slv15_sel;
wire                    [DATA_MSB:0] hm8_slv15_hwdata;
wire                    [DATA_MSB:0] mst8_hs15_hrdata;
wire                                 mst8_hs15_hready;
wire                           [1:0] mst8_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv15_base;
wire                                 mst8_slv15_grant;
wire                    [ADDR_MSB:0] mst8_slv15_haddr;
wire                           [2:0] mst8_slv15_hburst;
wire                           [3:0] mst8_slv15_hprot;
wire                           [2:0] mst8_slv15_hsize;
wire                           [1:0] mst8_slv15_htrans;
wire                                 mst8_slv15_hwrite;
wire                                 mst8_slv15_req;
wire                           [3:0] mst8_slv15_size;
wire                                 mst8_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst8_slv0_sel;
wire                    [DATA_MSB:0] hm8_slv0_hwdata;
wire                    [DATA_MSB:0] mst8_hs0_hrdata;
wire                                 mst8_hs0_hready;
wire                           [1:0] mst8_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst8_slv0_base;
wire                                 mst8_slv0_grant;
wire                    [ADDR_MSB:0] mst8_slv0_haddr;
wire                           [2:0] mst8_slv0_hburst;
wire                           [3:0] mst8_slv0_hprot;
wire                           [2:0] mst8_slv0_hsize;
wire                           [1:0] mst8_slv0_htrans;
wire                                 mst8_slv0_hwrite;
wire                                 mst8_slv0_req;
wire                           [3:0] mst8_slv0_size;
wire                                 mst8_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST9
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst9_slv1_sel;
wire                    [DATA_MSB:0] hm9_slv1_hwdata;
wire                    [DATA_MSB:0] mst9_hs1_hrdata;
wire                                 mst9_hs1_hready;
wire                           [1:0] mst9_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv1_base;
wire                                 mst9_slv1_grant;
wire                    [ADDR_MSB:0] mst9_slv1_haddr;
wire                           [2:0] mst9_slv1_hburst;
wire                           [3:0] mst9_slv1_hprot;
wire                           [2:0] mst9_slv1_hsize;
wire                           [1:0] mst9_slv1_htrans;
wire                                 mst9_slv1_hwrite;
wire                                 mst9_slv1_req;
wire                           [3:0] mst9_slv1_size;
wire                                 mst9_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst9_slv2_sel;
wire                    [DATA_MSB:0] hm9_slv2_hwdata;
wire                    [DATA_MSB:0] mst9_hs2_hrdata;
wire                                 mst9_hs2_hready;
wire                           [1:0] mst9_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv2_base;
wire                                 mst9_slv2_grant;
wire                    [ADDR_MSB:0] mst9_slv2_haddr;
wire                           [2:0] mst9_slv2_hburst;
wire                           [3:0] mst9_slv2_hprot;
wire                           [2:0] mst9_slv2_hsize;
wire                           [1:0] mst9_slv2_htrans;
wire                                 mst9_slv2_hwrite;
wire                                 mst9_slv2_req;
wire                           [3:0] mst9_slv2_size;
wire                                 mst9_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst9_slv3_sel;
wire                    [DATA_MSB:0] hm9_slv3_hwdata;
wire                    [DATA_MSB:0] mst9_hs3_hrdata;
wire                                 mst9_hs3_hready;
wire                           [1:0] mst9_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv3_base;
wire                                 mst9_slv3_grant;
wire                    [ADDR_MSB:0] mst9_slv3_haddr;
wire                           [2:0] mst9_slv3_hburst;
wire                           [3:0] mst9_slv3_hprot;
wire                           [2:0] mst9_slv3_hsize;
wire                           [1:0] mst9_slv3_htrans;
wire                                 mst9_slv3_hwrite;
wire                                 mst9_slv3_req;
wire                           [3:0] mst9_slv3_size;
wire                                 mst9_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst9_slv4_sel;
wire                    [DATA_MSB:0] hm9_slv4_hwdata;
wire                    [DATA_MSB:0] mst9_hs4_hrdata;
wire                                 mst9_hs4_hready;
wire                           [1:0] mst9_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv4_base;
wire                                 mst9_slv4_grant;
wire                    [ADDR_MSB:0] mst9_slv4_haddr;
wire                           [2:0] mst9_slv4_hburst;
wire                           [3:0] mst9_slv4_hprot;
wire                           [2:0] mst9_slv4_hsize;
wire                           [1:0] mst9_slv4_htrans;
wire                                 mst9_slv4_hwrite;
wire                                 mst9_slv4_req;
wire                           [3:0] mst9_slv4_size;
wire                                 mst9_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst9_slv5_sel;
wire                    [DATA_MSB:0] hm9_slv5_hwdata;
wire                    [DATA_MSB:0] mst9_hs5_hrdata;
wire                                 mst9_hs5_hready;
wire                           [1:0] mst9_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv5_base;
wire                                 mst9_slv5_grant;
wire                    [ADDR_MSB:0] mst9_slv5_haddr;
wire                           [2:0] mst9_slv5_hburst;
wire                           [3:0] mst9_slv5_hprot;
wire                           [2:0] mst9_slv5_hsize;
wire                           [1:0] mst9_slv5_htrans;
wire                                 mst9_slv5_hwrite;
wire                                 mst9_slv5_req;
wire                           [3:0] mst9_slv5_size;
wire                                 mst9_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst9_slv6_sel;
wire                    [DATA_MSB:0] hm9_slv6_hwdata;
wire                    [DATA_MSB:0] mst9_hs6_hrdata;
wire                                 mst9_hs6_hready;
wire                           [1:0] mst9_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv6_base;
wire                                 mst9_slv6_grant;
wire                    [ADDR_MSB:0] mst9_slv6_haddr;
wire                           [2:0] mst9_slv6_hburst;
wire                           [3:0] mst9_slv6_hprot;
wire                           [2:0] mst9_slv6_hsize;
wire                           [1:0] mst9_slv6_htrans;
wire                                 mst9_slv6_hwrite;
wire                                 mst9_slv6_req;
wire                           [3:0] mst9_slv6_size;
wire                                 mst9_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst9_slv7_sel;
wire                    [DATA_MSB:0] hm9_slv7_hwdata;
wire                    [DATA_MSB:0] mst9_hs7_hrdata;
wire                                 mst9_hs7_hready;
wire                           [1:0] mst9_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv7_base;
wire                                 mst9_slv7_grant;
wire                    [ADDR_MSB:0] mst9_slv7_haddr;
wire                           [2:0] mst9_slv7_hburst;
wire                           [3:0] mst9_slv7_hprot;
wire                           [2:0] mst9_slv7_hsize;
wire                           [1:0] mst9_slv7_htrans;
wire                                 mst9_slv7_hwrite;
wire                                 mst9_slv7_req;
wire                           [3:0] mst9_slv7_size;
wire                                 mst9_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst9_slv8_sel;
wire                    [DATA_MSB:0] hm9_slv8_hwdata;
wire                    [DATA_MSB:0] mst9_hs8_hrdata;
wire                                 mst9_hs8_hready;
wire                           [1:0] mst9_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv8_base;
wire                                 mst9_slv8_grant;
wire                    [ADDR_MSB:0] mst9_slv8_haddr;
wire                           [2:0] mst9_slv8_hburst;
wire                           [3:0] mst9_slv8_hprot;
wire                           [2:0] mst9_slv8_hsize;
wire                           [1:0] mst9_slv8_htrans;
wire                                 mst9_slv8_hwrite;
wire                                 mst9_slv8_req;
wire                           [3:0] mst9_slv8_size;
wire                                 mst9_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst9_slv9_sel;
wire                    [DATA_MSB:0] hm9_slv9_hwdata;
wire                    [DATA_MSB:0] mst9_hs9_hrdata;
wire                                 mst9_hs9_hready;
wire                           [1:0] mst9_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv9_base;
wire                                 mst9_slv9_grant;
wire                    [ADDR_MSB:0] mst9_slv9_haddr;
wire                           [2:0] mst9_slv9_hburst;
wire                           [3:0] mst9_slv9_hprot;
wire                           [2:0] mst9_slv9_hsize;
wire                           [1:0] mst9_slv9_htrans;
wire                                 mst9_slv9_hwrite;
wire                                 mst9_slv9_req;
wire                           [3:0] mst9_slv9_size;
wire                                 mst9_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst9_slv10_sel;
wire                    [DATA_MSB:0] hm9_slv10_hwdata;
wire                    [DATA_MSB:0] mst9_hs10_hrdata;
wire                                 mst9_hs10_hready;
wire                           [1:0] mst9_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv10_base;
wire                                 mst9_slv10_grant;
wire                    [ADDR_MSB:0] mst9_slv10_haddr;
wire                           [2:0] mst9_slv10_hburst;
wire                           [3:0] mst9_slv10_hprot;
wire                           [2:0] mst9_slv10_hsize;
wire                           [1:0] mst9_slv10_htrans;
wire                                 mst9_slv10_hwrite;
wire                                 mst9_slv10_req;
wire                           [3:0] mst9_slv10_size;
wire                                 mst9_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst9_slv11_sel;
wire                    [DATA_MSB:0] hm9_slv11_hwdata;
wire                    [DATA_MSB:0] mst9_hs11_hrdata;
wire                                 mst9_hs11_hready;
wire                           [1:0] mst9_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv11_base;
wire                                 mst9_slv11_grant;
wire                    [ADDR_MSB:0] mst9_slv11_haddr;
wire                           [2:0] mst9_slv11_hburst;
wire                           [3:0] mst9_slv11_hprot;
wire                           [2:0] mst9_slv11_hsize;
wire                           [1:0] mst9_slv11_htrans;
wire                                 mst9_slv11_hwrite;
wire                                 mst9_slv11_req;
wire                           [3:0] mst9_slv11_size;
wire                                 mst9_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst9_slv12_sel;
wire                    [DATA_MSB:0] hm9_slv12_hwdata;
wire                    [DATA_MSB:0] mst9_hs12_hrdata;
wire                                 mst9_hs12_hready;
wire                           [1:0] mst9_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv12_base;
wire                                 mst9_slv12_grant;
wire                    [ADDR_MSB:0] mst9_slv12_haddr;
wire                           [2:0] mst9_slv12_hburst;
wire                           [3:0] mst9_slv12_hprot;
wire                           [2:0] mst9_slv12_hsize;
wire                           [1:0] mst9_slv12_htrans;
wire                                 mst9_slv12_hwrite;
wire                                 mst9_slv12_req;
wire                           [3:0] mst9_slv12_size;
wire                                 mst9_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst9_slv13_sel;
wire                    [DATA_MSB:0] hm9_slv13_hwdata;
wire                    [DATA_MSB:0] mst9_hs13_hrdata;
wire                                 mst9_hs13_hready;
wire                           [1:0] mst9_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv13_base;
wire                                 mst9_slv13_grant;
wire                    [ADDR_MSB:0] mst9_slv13_haddr;
wire                           [2:0] mst9_slv13_hburst;
wire                           [3:0] mst9_slv13_hprot;
wire                           [2:0] mst9_slv13_hsize;
wire                           [1:0] mst9_slv13_htrans;
wire                                 mst9_slv13_hwrite;
wire                                 mst9_slv13_req;
wire                           [3:0] mst9_slv13_size;
wire                                 mst9_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst9_slv14_sel;
wire                    [DATA_MSB:0] hm9_slv14_hwdata;
wire                    [DATA_MSB:0] mst9_hs14_hrdata;
wire                                 mst9_hs14_hready;
wire                           [1:0] mst9_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv14_base;
wire                                 mst9_slv14_grant;
wire                    [ADDR_MSB:0] mst9_slv14_haddr;
wire                           [2:0] mst9_slv14_hburst;
wire                           [3:0] mst9_slv14_hprot;
wire                           [2:0] mst9_slv14_hsize;
wire                           [1:0] mst9_slv14_htrans;
wire                                 mst9_slv14_hwrite;
wire                                 mst9_slv14_req;
wire                           [3:0] mst9_slv14_size;
wire                                 mst9_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst9_slv15_sel;
wire                    [DATA_MSB:0] hm9_slv15_hwdata;
wire                    [DATA_MSB:0] mst9_hs15_hrdata;
wire                                 mst9_hs15_hready;
wire                           [1:0] mst9_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv15_base;
wire                                 mst9_slv15_grant;
wire                    [ADDR_MSB:0] mst9_slv15_haddr;
wire                           [2:0] mst9_slv15_hburst;
wire                           [3:0] mst9_slv15_hprot;
wire                           [2:0] mst9_slv15_hsize;
wire                           [1:0] mst9_slv15_htrans;
wire                                 mst9_slv15_hwrite;
wire                                 mst9_slv15_req;
wire                           [3:0] mst9_slv15_size;
wire                                 mst9_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst9_slv0_sel;
wire                    [DATA_MSB:0] hm9_slv0_hwdata;
wire                    [DATA_MSB:0] mst9_hs0_hrdata;
wire                                 mst9_hs0_hready;
wire                           [1:0] mst9_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst9_slv0_base;
wire                                 mst9_slv0_grant;
wire                    [ADDR_MSB:0] mst9_slv0_haddr;
wire                           [2:0] mst9_slv0_hburst;
wire                           [3:0] mst9_slv0_hprot;
wire                           [2:0] mst9_slv0_hsize;
wire                           [1:0] mst9_slv0_htrans;
wire                                 mst9_slv0_hwrite;
wire                                 mst9_slv0_req;
wire                           [3:0] mst9_slv0_size;
wire                                 mst9_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST10
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst10_slv1_sel;
wire                    [DATA_MSB:0] hm10_slv1_hwdata;
wire                    [DATA_MSB:0] mst10_hs1_hrdata;
wire                                 mst10_hs1_hready;
wire                           [1:0] mst10_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv1_base;
wire                                 mst10_slv1_grant;
wire                    [ADDR_MSB:0] mst10_slv1_haddr;
wire                           [2:0] mst10_slv1_hburst;
wire                           [3:0] mst10_slv1_hprot;
wire                           [2:0] mst10_slv1_hsize;
wire                           [1:0] mst10_slv1_htrans;
wire                                 mst10_slv1_hwrite;
wire                                 mst10_slv1_req;
wire                           [3:0] mst10_slv1_size;
wire                                 mst10_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst10_slv2_sel;
wire                    [DATA_MSB:0] hm10_slv2_hwdata;
wire                    [DATA_MSB:0] mst10_hs2_hrdata;
wire                                 mst10_hs2_hready;
wire                           [1:0] mst10_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv2_base;
wire                                 mst10_slv2_grant;
wire                    [ADDR_MSB:0] mst10_slv2_haddr;
wire                           [2:0] mst10_slv2_hburst;
wire                           [3:0] mst10_slv2_hprot;
wire                           [2:0] mst10_slv2_hsize;
wire                           [1:0] mst10_slv2_htrans;
wire                                 mst10_slv2_hwrite;
wire                                 mst10_slv2_req;
wire                           [3:0] mst10_slv2_size;
wire                                 mst10_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst10_slv3_sel;
wire                    [DATA_MSB:0] hm10_slv3_hwdata;
wire                    [DATA_MSB:0] mst10_hs3_hrdata;
wire                                 mst10_hs3_hready;
wire                           [1:0] mst10_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv3_base;
wire                                 mst10_slv3_grant;
wire                    [ADDR_MSB:0] mst10_slv3_haddr;
wire                           [2:0] mst10_slv3_hburst;
wire                           [3:0] mst10_slv3_hprot;
wire                           [2:0] mst10_slv3_hsize;
wire                           [1:0] mst10_slv3_htrans;
wire                                 mst10_slv3_hwrite;
wire                                 mst10_slv3_req;
wire                           [3:0] mst10_slv3_size;
wire                                 mst10_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst10_slv4_sel;
wire                    [DATA_MSB:0] hm10_slv4_hwdata;
wire                    [DATA_MSB:0] mst10_hs4_hrdata;
wire                                 mst10_hs4_hready;
wire                           [1:0] mst10_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv4_base;
wire                                 mst10_slv4_grant;
wire                    [ADDR_MSB:0] mst10_slv4_haddr;
wire                           [2:0] mst10_slv4_hburst;
wire                           [3:0] mst10_slv4_hprot;
wire                           [2:0] mst10_slv4_hsize;
wire                           [1:0] mst10_slv4_htrans;
wire                                 mst10_slv4_hwrite;
wire                                 mst10_slv4_req;
wire                           [3:0] mst10_slv4_size;
wire                                 mst10_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst10_slv5_sel;
wire                    [DATA_MSB:0] hm10_slv5_hwdata;
wire                    [DATA_MSB:0] mst10_hs5_hrdata;
wire                                 mst10_hs5_hready;
wire                           [1:0] mst10_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv5_base;
wire                                 mst10_slv5_grant;
wire                    [ADDR_MSB:0] mst10_slv5_haddr;
wire                           [2:0] mst10_slv5_hburst;
wire                           [3:0] mst10_slv5_hprot;
wire                           [2:0] mst10_slv5_hsize;
wire                           [1:0] mst10_slv5_htrans;
wire                                 mst10_slv5_hwrite;
wire                                 mst10_slv5_req;
wire                           [3:0] mst10_slv5_size;
wire                                 mst10_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst10_slv6_sel;
wire                    [DATA_MSB:0] hm10_slv6_hwdata;
wire                    [DATA_MSB:0] mst10_hs6_hrdata;
wire                                 mst10_hs6_hready;
wire                           [1:0] mst10_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv6_base;
wire                                 mst10_slv6_grant;
wire                    [ADDR_MSB:0] mst10_slv6_haddr;
wire                           [2:0] mst10_slv6_hburst;
wire                           [3:0] mst10_slv6_hprot;
wire                           [2:0] mst10_slv6_hsize;
wire                           [1:0] mst10_slv6_htrans;
wire                                 mst10_slv6_hwrite;
wire                                 mst10_slv6_req;
wire                           [3:0] mst10_slv6_size;
wire                                 mst10_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst10_slv7_sel;
wire                    [DATA_MSB:0] hm10_slv7_hwdata;
wire                    [DATA_MSB:0] mst10_hs7_hrdata;
wire                                 mst10_hs7_hready;
wire                           [1:0] mst10_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv7_base;
wire                                 mst10_slv7_grant;
wire                    [ADDR_MSB:0] mst10_slv7_haddr;
wire                           [2:0] mst10_slv7_hburst;
wire                           [3:0] mst10_slv7_hprot;
wire                           [2:0] mst10_slv7_hsize;
wire                           [1:0] mst10_slv7_htrans;
wire                                 mst10_slv7_hwrite;
wire                                 mst10_slv7_req;
wire                           [3:0] mst10_slv7_size;
wire                                 mst10_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst10_slv8_sel;
wire                    [DATA_MSB:0] hm10_slv8_hwdata;
wire                    [DATA_MSB:0] mst10_hs8_hrdata;
wire                                 mst10_hs8_hready;
wire                           [1:0] mst10_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv8_base;
wire                                 mst10_slv8_grant;
wire                    [ADDR_MSB:0] mst10_slv8_haddr;
wire                           [2:0] mst10_slv8_hburst;
wire                           [3:0] mst10_slv8_hprot;
wire                           [2:0] mst10_slv8_hsize;
wire                           [1:0] mst10_slv8_htrans;
wire                                 mst10_slv8_hwrite;
wire                                 mst10_slv8_req;
wire                           [3:0] mst10_slv8_size;
wire                                 mst10_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst10_slv9_sel;
wire                    [DATA_MSB:0] hm10_slv9_hwdata;
wire                    [DATA_MSB:0] mst10_hs9_hrdata;
wire                                 mst10_hs9_hready;
wire                           [1:0] mst10_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv9_base;
wire                                 mst10_slv9_grant;
wire                    [ADDR_MSB:0] mst10_slv9_haddr;
wire                           [2:0] mst10_slv9_hburst;
wire                           [3:0] mst10_slv9_hprot;
wire                           [2:0] mst10_slv9_hsize;
wire                           [1:0] mst10_slv9_htrans;
wire                                 mst10_slv9_hwrite;
wire                                 mst10_slv9_req;
wire                           [3:0] mst10_slv9_size;
wire                                 mst10_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst10_slv10_sel;
wire                    [DATA_MSB:0] hm10_slv10_hwdata;
wire                    [DATA_MSB:0] mst10_hs10_hrdata;
wire                                 mst10_hs10_hready;
wire                           [1:0] mst10_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv10_base;
wire                                 mst10_slv10_grant;
wire                    [ADDR_MSB:0] mst10_slv10_haddr;
wire                           [2:0] mst10_slv10_hburst;
wire                           [3:0] mst10_slv10_hprot;
wire                           [2:0] mst10_slv10_hsize;
wire                           [1:0] mst10_slv10_htrans;
wire                                 mst10_slv10_hwrite;
wire                                 mst10_slv10_req;
wire                           [3:0] mst10_slv10_size;
wire                                 mst10_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst10_slv11_sel;
wire                    [DATA_MSB:0] hm10_slv11_hwdata;
wire                    [DATA_MSB:0] mst10_hs11_hrdata;
wire                                 mst10_hs11_hready;
wire                           [1:0] mst10_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv11_base;
wire                                 mst10_slv11_grant;
wire                    [ADDR_MSB:0] mst10_slv11_haddr;
wire                           [2:0] mst10_slv11_hburst;
wire                           [3:0] mst10_slv11_hprot;
wire                           [2:0] mst10_slv11_hsize;
wire                           [1:0] mst10_slv11_htrans;
wire                                 mst10_slv11_hwrite;
wire                                 mst10_slv11_req;
wire                           [3:0] mst10_slv11_size;
wire                                 mst10_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst10_slv12_sel;
wire                    [DATA_MSB:0] hm10_slv12_hwdata;
wire                    [DATA_MSB:0] mst10_hs12_hrdata;
wire                                 mst10_hs12_hready;
wire                           [1:0] mst10_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv12_base;
wire                                 mst10_slv12_grant;
wire                    [ADDR_MSB:0] mst10_slv12_haddr;
wire                           [2:0] mst10_slv12_hburst;
wire                           [3:0] mst10_slv12_hprot;
wire                           [2:0] mst10_slv12_hsize;
wire                           [1:0] mst10_slv12_htrans;
wire                                 mst10_slv12_hwrite;
wire                                 mst10_slv12_req;
wire                           [3:0] mst10_slv12_size;
wire                                 mst10_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst10_slv13_sel;
wire                    [DATA_MSB:0] hm10_slv13_hwdata;
wire                    [DATA_MSB:0] mst10_hs13_hrdata;
wire                                 mst10_hs13_hready;
wire                           [1:0] mst10_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv13_base;
wire                                 mst10_slv13_grant;
wire                    [ADDR_MSB:0] mst10_slv13_haddr;
wire                           [2:0] mst10_slv13_hburst;
wire                           [3:0] mst10_slv13_hprot;
wire                           [2:0] mst10_slv13_hsize;
wire                           [1:0] mst10_slv13_htrans;
wire                                 mst10_slv13_hwrite;
wire                                 mst10_slv13_req;
wire                           [3:0] mst10_slv13_size;
wire                                 mst10_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst10_slv14_sel;
wire                    [DATA_MSB:0] hm10_slv14_hwdata;
wire                    [DATA_MSB:0] mst10_hs14_hrdata;
wire                                 mst10_hs14_hready;
wire                           [1:0] mst10_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv14_base;
wire                                 mst10_slv14_grant;
wire                    [ADDR_MSB:0] mst10_slv14_haddr;
wire                           [2:0] mst10_slv14_hburst;
wire                           [3:0] mst10_slv14_hprot;
wire                           [2:0] mst10_slv14_hsize;
wire                           [1:0] mst10_slv14_htrans;
wire                                 mst10_slv14_hwrite;
wire                                 mst10_slv14_req;
wire                           [3:0] mst10_slv14_size;
wire                                 mst10_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst10_slv15_sel;
wire                    [DATA_MSB:0] hm10_slv15_hwdata;
wire                    [DATA_MSB:0] mst10_hs15_hrdata;
wire                                 mst10_hs15_hready;
wire                           [1:0] mst10_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv15_base;
wire                                 mst10_slv15_grant;
wire                    [ADDR_MSB:0] mst10_slv15_haddr;
wire                           [2:0] mst10_slv15_hburst;
wire                           [3:0] mst10_slv15_hprot;
wire                           [2:0] mst10_slv15_hsize;
wire                           [1:0] mst10_slv15_htrans;
wire                                 mst10_slv15_hwrite;
wire                                 mst10_slv15_req;
wire                           [3:0] mst10_slv15_size;
wire                                 mst10_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst10_slv0_sel;
wire                    [DATA_MSB:0] hm10_slv0_hwdata;
wire                    [DATA_MSB:0] mst10_hs0_hrdata;
wire                                 mst10_hs0_hready;
wire                           [1:0] mst10_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst10_slv0_base;
wire                                 mst10_slv0_grant;
wire                    [ADDR_MSB:0] mst10_slv0_haddr;
wire                           [2:0] mst10_slv0_hburst;
wire                           [3:0] mst10_slv0_hprot;
wire                           [2:0] mst10_slv0_hsize;
wire                           [1:0] mst10_slv0_htrans;
wire                                 mst10_slv0_hwrite;
wire                                 mst10_slv0_req;
wire                           [3:0] mst10_slv0_size;
wire                                 mst10_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST11
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst11_slv1_sel;
wire                    [DATA_MSB:0] hm11_slv1_hwdata;
wire                    [DATA_MSB:0] mst11_hs1_hrdata;
wire                                 mst11_hs1_hready;
wire                           [1:0] mst11_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv1_base;
wire                                 mst11_slv1_grant;
wire                    [ADDR_MSB:0] mst11_slv1_haddr;
wire                           [2:0] mst11_slv1_hburst;
wire                           [3:0] mst11_slv1_hprot;
wire                           [2:0] mst11_slv1_hsize;
wire                           [1:0] mst11_slv1_htrans;
wire                                 mst11_slv1_hwrite;
wire                                 mst11_slv1_req;
wire                           [3:0] mst11_slv1_size;
wire                                 mst11_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst11_slv2_sel;
wire                    [DATA_MSB:0] hm11_slv2_hwdata;
wire                    [DATA_MSB:0] mst11_hs2_hrdata;
wire                                 mst11_hs2_hready;
wire                           [1:0] mst11_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv2_base;
wire                                 mst11_slv2_grant;
wire                    [ADDR_MSB:0] mst11_slv2_haddr;
wire                           [2:0] mst11_slv2_hburst;
wire                           [3:0] mst11_slv2_hprot;
wire                           [2:0] mst11_slv2_hsize;
wire                           [1:0] mst11_slv2_htrans;
wire                                 mst11_slv2_hwrite;
wire                                 mst11_slv2_req;
wire                           [3:0] mst11_slv2_size;
wire                                 mst11_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst11_slv3_sel;
wire                    [DATA_MSB:0] hm11_slv3_hwdata;
wire                    [DATA_MSB:0] mst11_hs3_hrdata;
wire                                 mst11_hs3_hready;
wire                           [1:0] mst11_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv3_base;
wire                                 mst11_slv3_grant;
wire                    [ADDR_MSB:0] mst11_slv3_haddr;
wire                           [2:0] mst11_slv3_hburst;
wire                           [3:0] mst11_slv3_hprot;
wire                           [2:0] mst11_slv3_hsize;
wire                           [1:0] mst11_slv3_htrans;
wire                                 mst11_slv3_hwrite;
wire                                 mst11_slv3_req;
wire                           [3:0] mst11_slv3_size;
wire                                 mst11_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst11_slv4_sel;
wire                    [DATA_MSB:0] hm11_slv4_hwdata;
wire                    [DATA_MSB:0] mst11_hs4_hrdata;
wire                                 mst11_hs4_hready;
wire                           [1:0] mst11_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv4_base;
wire                                 mst11_slv4_grant;
wire                    [ADDR_MSB:0] mst11_slv4_haddr;
wire                           [2:0] mst11_slv4_hburst;
wire                           [3:0] mst11_slv4_hprot;
wire                           [2:0] mst11_slv4_hsize;
wire                           [1:0] mst11_slv4_htrans;
wire                                 mst11_slv4_hwrite;
wire                                 mst11_slv4_req;
wire                           [3:0] mst11_slv4_size;
wire                                 mst11_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst11_slv5_sel;
wire                    [DATA_MSB:0] hm11_slv5_hwdata;
wire                    [DATA_MSB:0] mst11_hs5_hrdata;
wire                                 mst11_hs5_hready;
wire                           [1:0] mst11_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv5_base;
wire                                 mst11_slv5_grant;
wire                    [ADDR_MSB:0] mst11_slv5_haddr;
wire                           [2:0] mst11_slv5_hburst;
wire                           [3:0] mst11_slv5_hprot;
wire                           [2:0] mst11_slv5_hsize;
wire                           [1:0] mst11_slv5_htrans;
wire                                 mst11_slv5_hwrite;
wire                                 mst11_slv5_req;
wire                           [3:0] mst11_slv5_size;
wire                                 mst11_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst11_slv6_sel;
wire                    [DATA_MSB:0] hm11_slv6_hwdata;
wire                    [DATA_MSB:0] mst11_hs6_hrdata;
wire                                 mst11_hs6_hready;
wire                           [1:0] mst11_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv6_base;
wire                                 mst11_slv6_grant;
wire                    [ADDR_MSB:0] mst11_slv6_haddr;
wire                           [2:0] mst11_slv6_hburst;
wire                           [3:0] mst11_slv6_hprot;
wire                           [2:0] mst11_slv6_hsize;
wire                           [1:0] mst11_slv6_htrans;
wire                                 mst11_slv6_hwrite;
wire                                 mst11_slv6_req;
wire                           [3:0] mst11_slv6_size;
wire                                 mst11_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst11_slv7_sel;
wire                    [DATA_MSB:0] hm11_slv7_hwdata;
wire                    [DATA_MSB:0] mst11_hs7_hrdata;
wire                                 mst11_hs7_hready;
wire                           [1:0] mst11_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv7_base;
wire                                 mst11_slv7_grant;
wire                    [ADDR_MSB:0] mst11_slv7_haddr;
wire                           [2:0] mst11_slv7_hburst;
wire                           [3:0] mst11_slv7_hprot;
wire                           [2:0] mst11_slv7_hsize;
wire                           [1:0] mst11_slv7_htrans;
wire                                 mst11_slv7_hwrite;
wire                                 mst11_slv7_req;
wire                           [3:0] mst11_slv7_size;
wire                                 mst11_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst11_slv8_sel;
wire                    [DATA_MSB:0] hm11_slv8_hwdata;
wire                    [DATA_MSB:0] mst11_hs8_hrdata;
wire                                 mst11_hs8_hready;
wire                           [1:0] mst11_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv8_base;
wire                                 mst11_slv8_grant;
wire                    [ADDR_MSB:0] mst11_slv8_haddr;
wire                           [2:0] mst11_slv8_hburst;
wire                           [3:0] mst11_slv8_hprot;
wire                           [2:0] mst11_slv8_hsize;
wire                           [1:0] mst11_slv8_htrans;
wire                                 mst11_slv8_hwrite;
wire                                 mst11_slv8_req;
wire                           [3:0] mst11_slv8_size;
wire                                 mst11_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst11_slv9_sel;
wire                    [DATA_MSB:0] hm11_slv9_hwdata;
wire                    [DATA_MSB:0] mst11_hs9_hrdata;
wire                                 mst11_hs9_hready;
wire                           [1:0] mst11_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv9_base;
wire                                 mst11_slv9_grant;
wire                    [ADDR_MSB:0] mst11_slv9_haddr;
wire                           [2:0] mst11_slv9_hburst;
wire                           [3:0] mst11_slv9_hprot;
wire                           [2:0] mst11_slv9_hsize;
wire                           [1:0] mst11_slv9_htrans;
wire                                 mst11_slv9_hwrite;
wire                                 mst11_slv9_req;
wire                           [3:0] mst11_slv9_size;
wire                                 mst11_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst11_slv10_sel;
wire                    [DATA_MSB:0] hm11_slv10_hwdata;
wire                    [DATA_MSB:0] mst11_hs10_hrdata;
wire                                 mst11_hs10_hready;
wire                           [1:0] mst11_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv10_base;
wire                                 mst11_slv10_grant;
wire                    [ADDR_MSB:0] mst11_slv10_haddr;
wire                           [2:0] mst11_slv10_hburst;
wire                           [3:0] mst11_slv10_hprot;
wire                           [2:0] mst11_slv10_hsize;
wire                           [1:0] mst11_slv10_htrans;
wire                                 mst11_slv10_hwrite;
wire                                 mst11_slv10_req;
wire                           [3:0] mst11_slv10_size;
wire                                 mst11_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst11_slv11_sel;
wire                    [DATA_MSB:0] hm11_slv11_hwdata;
wire                    [DATA_MSB:0] mst11_hs11_hrdata;
wire                                 mst11_hs11_hready;
wire                           [1:0] mst11_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv11_base;
wire                                 mst11_slv11_grant;
wire                    [ADDR_MSB:0] mst11_slv11_haddr;
wire                           [2:0] mst11_slv11_hburst;
wire                           [3:0] mst11_slv11_hprot;
wire                           [2:0] mst11_slv11_hsize;
wire                           [1:0] mst11_slv11_htrans;
wire                                 mst11_slv11_hwrite;
wire                                 mst11_slv11_req;
wire                           [3:0] mst11_slv11_size;
wire                                 mst11_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst11_slv12_sel;
wire                    [DATA_MSB:0] hm11_slv12_hwdata;
wire                    [DATA_MSB:0] mst11_hs12_hrdata;
wire                                 mst11_hs12_hready;
wire                           [1:0] mst11_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv12_base;
wire                                 mst11_slv12_grant;
wire                    [ADDR_MSB:0] mst11_slv12_haddr;
wire                           [2:0] mst11_slv12_hburst;
wire                           [3:0] mst11_slv12_hprot;
wire                           [2:0] mst11_slv12_hsize;
wire                           [1:0] mst11_slv12_htrans;
wire                                 mst11_slv12_hwrite;
wire                                 mst11_slv12_req;
wire                           [3:0] mst11_slv12_size;
wire                                 mst11_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst11_slv13_sel;
wire                    [DATA_MSB:0] hm11_slv13_hwdata;
wire                    [DATA_MSB:0] mst11_hs13_hrdata;
wire                                 mst11_hs13_hready;
wire                           [1:0] mst11_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv13_base;
wire                                 mst11_slv13_grant;
wire                    [ADDR_MSB:0] mst11_slv13_haddr;
wire                           [2:0] mst11_slv13_hburst;
wire                           [3:0] mst11_slv13_hprot;
wire                           [2:0] mst11_slv13_hsize;
wire                           [1:0] mst11_slv13_htrans;
wire                                 mst11_slv13_hwrite;
wire                                 mst11_slv13_req;
wire                           [3:0] mst11_slv13_size;
wire                                 mst11_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst11_slv14_sel;
wire                    [DATA_MSB:0] hm11_slv14_hwdata;
wire                    [DATA_MSB:0] mst11_hs14_hrdata;
wire                                 mst11_hs14_hready;
wire                           [1:0] mst11_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv14_base;
wire                                 mst11_slv14_grant;
wire                    [ADDR_MSB:0] mst11_slv14_haddr;
wire                           [2:0] mst11_slv14_hburst;
wire                           [3:0] mst11_slv14_hprot;
wire                           [2:0] mst11_slv14_hsize;
wire                           [1:0] mst11_slv14_htrans;
wire                                 mst11_slv14_hwrite;
wire                                 mst11_slv14_req;
wire                           [3:0] mst11_slv14_size;
wire                                 mst11_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst11_slv15_sel;
wire                    [DATA_MSB:0] hm11_slv15_hwdata;
wire                    [DATA_MSB:0] mst11_hs15_hrdata;
wire                                 mst11_hs15_hready;
wire                           [1:0] mst11_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv15_base;
wire                                 mst11_slv15_grant;
wire                    [ADDR_MSB:0] mst11_slv15_haddr;
wire                           [2:0] mst11_slv15_hburst;
wire                           [3:0] mst11_slv15_hprot;
wire                           [2:0] mst11_slv15_hsize;
wire                           [1:0] mst11_slv15_htrans;
wire                                 mst11_slv15_hwrite;
wire                                 mst11_slv15_req;
wire                           [3:0] mst11_slv15_size;
wire                                 mst11_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst11_slv0_sel;
wire                    [DATA_MSB:0] hm11_slv0_hwdata;
wire                    [DATA_MSB:0] mst11_hs0_hrdata;
wire                                 mst11_hs0_hready;
wire                           [1:0] mst11_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst11_slv0_base;
wire                                 mst11_slv0_grant;
wire                    [ADDR_MSB:0] mst11_slv0_haddr;
wire                           [2:0] mst11_slv0_hburst;
wire                           [3:0] mst11_slv0_hprot;
wire                           [2:0] mst11_slv0_hsize;
wire                           [1:0] mst11_slv0_htrans;
wire                                 mst11_slv0_hwrite;
wire                                 mst11_slv0_req;
wire                           [3:0] mst11_slv0_size;
wire                                 mst11_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST12
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst12_slv1_sel;
wire                    [DATA_MSB:0] hm12_slv1_hwdata;
wire                    [DATA_MSB:0] mst12_hs1_hrdata;
wire                                 mst12_hs1_hready;
wire                           [1:0] mst12_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv1_base;
wire                                 mst12_slv1_grant;
wire                    [ADDR_MSB:0] mst12_slv1_haddr;
wire                           [2:0] mst12_slv1_hburst;
wire                           [3:0] mst12_slv1_hprot;
wire                           [2:0] mst12_slv1_hsize;
wire                           [1:0] mst12_slv1_htrans;
wire                                 mst12_slv1_hwrite;
wire                                 mst12_slv1_req;
wire                           [3:0] mst12_slv1_size;
wire                                 mst12_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst12_slv2_sel;
wire                    [DATA_MSB:0] hm12_slv2_hwdata;
wire                    [DATA_MSB:0] mst12_hs2_hrdata;
wire                                 mst12_hs2_hready;
wire                           [1:0] mst12_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv2_base;
wire                                 mst12_slv2_grant;
wire                    [ADDR_MSB:0] mst12_slv2_haddr;
wire                           [2:0] mst12_slv2_hburst;
wire                           [3:0] mst12_slv2_hprot;
wire                           [2:0] mst12_slv2_hsize;
wire                           [1:0] mst12_slv2_htrans;
wire                                 mst12_slv2_hwrite;
wire                                 mst12_slv2_req;
wire                           [3:0] mst12_slv2_size;
wire                                 mst12_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst12_slv3_sel;
wire                    [DATA_MSB:0] hm12_slv3_hwdata;
wire                    [DATA_MSB:0] mst12_hs3_hrdata;
wire                                 mst12_hs3_hready;
wire                           [1:0] mst12_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv3_base;
wire                                 mst12_slv3_grant;
wire                    [ADDR_MSB:0] mst12_slv3_haddr;
wire                           [2:0] mst12_slv3_hburst;
wire                           [3:0] mst12_slv3_hprot;
wire                           [2:0] mst12_slv3_hsize;
wire                           [1:0] mst12_slv3_htrans;
wire                                 mst12_slv3_hwrite;
wire                                 mst12_slv3_req;
wire                           [3:0] mst12_slv3_size;
wire                                 mst12_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst12_slv4_sel;
wire                    [DATA_MSB:0] hm12_slv4_hwdata;
wire                    [DATA_MSB:0] mst12_hs4_hrdata;
wire                                 mst12_hs4_hready;
wire                           [1:0] mst12_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv4_base;
wire                                 mst12_slv4_grant;
wire                    [ADDR_MSB:0] mst12_slv4_haddr;
wire                           [2:0] mst12_slv4_hburst;
wire                           [3:0] mst12_slv4_hprot;
wire                           [2:0] mst12_slv4_hsize;
wire                           [1:0] mst12_slv4_htrans;
wire                                 mst12_slv4_hwrite;
wire                                 mst12_slv4_req;
wire                           [3:0] mst12_slv4_size;
wire                                 mst12_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst12_slv5_sel;
wire                    [DATA_MSB:0] hm12_slv5_hwdata;
wire                    [DATA_MSB:0] mst12_hs5_hrdata;
wire                                 mst12_hs5_hready;
wire                           [1:0] mst12_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv5_base;
wire                                 mst12_slv5_grant;
wire                    [ADDR_MSB:0] mst12_slv5_haddr;
wire                           [2:0] mst12_slv5_hburst;
wire                           [3:0] mst12_slv5_hprot;
wire                           [2:0] mst12_slv5_hsize;
wire                           [1:0] mst12_slv5_htrans;
wire                                 mst12_slv5_hwrite;
wire                                 mst12_slv5_req;
wire                           [3:0] mst12_slv5_size;
wire                                 mst12_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst12_slv6_sel;
wire                    [DATA_MSB:0] hm12_slv6_hwdata;
wire                    [DATA_MSB:0] mst12_hs6_hrdata;
wire                                 mst12_hs6_hready;
wire                           [1:0] mst12_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv6_base;
wire                                 mst12_slv6_grant;
wire                    [ADDR_MSB:0] mst12_slv6_haddr;
wire                           [2:0] mst12_slv6_hburst;
wire                           [3:0] mst12_slv6_hprot;
wire                           [2:0] mst12_slv6_hsize;
wire                           [1:0] mst12_slv6_htrans;
wire                                 mst12_slv6_hwrite;
wire                                 mst12_slv6_req;
wire                           [3:0] mst12_slv6_size;
wire                                 mst12_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst12_slv7_sel;
wire                    [DATA_MSB:0] hm12_slv7_hwdata;
wire                    [DATA_MSB:0] mst12_hs7_hrdata;
wire                                 mst12_hs7_hready;
wire                           [1:0] mst12_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv7_base;
wire                                 mst12_slv7_grant;
wire                    [ADDR_MSB:0] mst12_slv7_haddr;
wire                           [2:0] mst12_slv7_hburst;
wire                           [3:0] mst12_slv7_hprot;
wire                           [2:0] mst12_slv7_hsize;
wire                           [1:0] mst12_slv7_htrans;
wire                                 mst12_slv7_hwrite;
wire                                 mst12_slv7_req;
wire                           [3:0] mst12_slv7_size;
wire                                 mst12_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst12_slv8_sel;
wire                    [DATA_MSB:0] hm12_slv8_hwdata;
wire                    [DATA_MSB:0] mst12_hs8_hrdata;
wire                                 mst12_hs8_hready;
wire                           [1:0] mst12_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv8_base;
wire                                 mst12_slv8_grant;
wire                    [ADDR_MSB:0] mst12_slv8_haddr;
wire                           [2:0] mst12_slv8_hburst;
wire                           [3:0] mst12_slv8_hprot;
wire                           [2:0] mst12_slv8_hsize;
wire                           [1:0] mst12_slv8_htrans;
wire                                 mst12_slv8_hwrite;
wire                                 mst12_slv8_req;
wire                           [3:0] mst12_slv8_size;
wire                                 mst12_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst12_slv9_sel;
wire                    [DATA_MSB:0] hm12_slv9_hwdata;
wire                    [DATA_MSB:0] mst12_hs9_hrdata;
wire                                 mst12_hs9_hready;
wire                           [1:0] mst12_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv9_base;
wire                                 mst12_slv9_grant;
wire                    [ADDR_MSB:0] mst12_slv9_haddr;
wire                           [2:0] mst12_slv9_hburst;
wire                           [3:0] mst12_slv9_hprot;
wire                           [2:0] mst12_slv9_hsize;
wire                           [1:0] mst12_slv9_htrans;
wire                                 mst12_slv9_hwrite;
wire                                 mst12_slv9_req;
wire                           [3:0] mst12_slv9_size;
wire                                 mst12_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst12_slv10_sel;
wire                    [DATA_MSB:0] hm12_slv10_hwdata;
wire                    [DATA_MSB:0] mst12_hs10_hrdata;
wire                                 mst12_hs10_hready;
wire                           [1:0] mst12_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv10_base;
wire                                 mst12_slv10_grant;
wire                    [ADDR_MSB:0] mst12_slv10_haddr;
wire                           [2:0] mst12_slv10_hburst;
wire                           [3:0] mst12_slv10_hprot;
wire                           [2:0] mst12_slv10_hsize;
wire                           [1:0] mst12_slv10_htrans;
wire                                 mst12_slv10_hwrite;
wire                                 mst12_slv10_req;
wire                           [3:0] mst12_slv10_size;
wire                                 mst12_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst12_slv11_sel;
wire                    [DATA_MSB:0] hm12_slv11_hwdata;
wire                    [DATA_MSB:0] mst12_hs11_hrdata;
wire                                 mst12_hs11_hready;
wire                           [1:0] mst12_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv11_base;
wire                                 mst12_slv11_grant;
wire                    [ADDR_MSB:0] mst12_slv11_haddr;
wire                           [2:0] mst12_slv11_hburst;
wire                           [3:0] mst12_slv11_hprot;
wire                           [2:0] mst12_slv11_hsize;
wire                           [1:0] mst12_slv11_htrans;
wire                                 mst12_slv11_hwrite;
wire                                 mst12_slv11_req;
wire                           [3:0] mst12_slv11_size;
wire                                 mst12_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst12_slv12_sel;
wire                    [DATA_MSB:0] hm12_slv12_hwdata;
wire                    [DATA_MSB:0] mst12_hs12_hrdata;
wire                                 mst12_hs12_hready;
wire                           [1:0] mst12_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv12_base;
wire                                 mst12_slv12_grant;
wire                    [ADDR_MSB:0] mst12_slv12_haddr;
wire                           [2:0] mst12_slv12_hburst;
wire                           [3:0] mst12_slv12_hprot;
wire                           [2:0] mst12_slv12_hsize;
wire                           [1:0] mst12_slv12_htrans;
wire                                 mst12_slv12_hwrite;
wire                                 mst12_slv12_req;
wire                           [3:0] mst12_slv12_size;
wire                                 mst12_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst12_slv13_sel;
wire                    [DATA_MSB:0] hm12_slv13_hwdata;
wire                    [DATA_MSB:0] mst12_hs13_hrdata;
wire                                 mst12_hs13_hready;
wire                           [1:0] mst12_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv13_base;
wire                                 mst12_slv13_grant;
wire                    [ADDR_MSB:0] mst12_slv13_haddr;
wire                           [2:0] mst12_slv13_hburst;
wire                           [3:0] mst12_slv13_hprot;
wire                           [2:0] mst12_slv13_hsize;
wire                           [1:0] mst12_slv13_htrans;
wire                                 mst12_slv13_hwrite;
wire                                 mst12_slv13_req;
wire                           [3:0] mst12_slv13_size;
wire                                 mst12_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst12_slv14_sel;
wire                    [DATA_MSB:0] hm12_slv14_hwdata;
wire                    [DATA_MSB:0] mst12_hs14_hrdata;
wire                                 mst12_hs14_hready;
wire                           [1:0] mst12_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv14_base;
wire                                 mst12_slv14_grant;
wire                    [ADDR_MSB:0] mst12_slv14_haddr;
wire                           [2:0] mst12_slv14_hburst;
wire                           [3:0] mst12_slv14_hprot;
wire                           [2:0] mst12_slv14_hsize;
wire                           [1:0] mst12_slv14_htrans;
wire                                 mst12_slv14_hwrite;
wire                                 mst12_slv14_req;
wire                           [3:0] mst12_slv14_size;
wire                                 mst12_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst12_slv15_sel;
wire                    [DATA_MSB:0] hm12_slv15_hwdata;
wire                    [DATA_MSB:0] mst12_hs15_hrdata;
wire                                 mst12_hs15_hready;
wire                           [1:0] mst12_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv15_base;
wire                                 mst12_slv15_grant;
wire                    [ADDR_MSB:0] mst12_slv15_haddr;
wire                           [2:0] mst12_slv15_hburst;
wire                           [3:0] mst12_slv15_hprot;
wire                           [2:0] mst12_slv15_hsize;
wire                           [1:0] mst12_slv15_htrans;
wire                                 mst12_slv15_hwrite;
wire                                 mst12_slv15_req;
wire                           [3:0] mst12_slv15_size;
wire                                 mst12_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst12_slv0_sel;
wire                    [DATA_MSB:0] hm12_slv0_hwdata;
wire                    [DATA_MSB:0] mst12_hs0_hrdata;
wire                                 mst12_hs0_hready;
wire                           [1:0] mst12_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst12_slv0_base;
wire                                 mst12_slv0_grant;
wire                    [ADDR_MSB:0] mst12_slv0_haddr;
wire                           [2:0] mst12_slv0_hburst;
wire                           [3:0] mst12_slv0_hprot;
wire                           [2:0] mst12_slv0_hsize;
wire                           [1:0] mst12_slv0_htrans;
wire                                 mst12_slv0_hwrite;
wire                                 mst12_slv0_req;
wire                           [3:0] mst12_slv0_size;
wire                                 mst12_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST13
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst13_slv1_sel;
wire                    [DATA_MSB:0] hm13_slv1_hwdata;
wire                    [DATA_MSB:0] mst13_hs1_hrdata;
wire                                 mst13_hs1_hready;
wire                           [1:0] mst13_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv1_base;
wire                                 mst13_slv1_grant;
wire                    [ADDR_MSB:0] mst13_slv1_haddr;
wire                           [2:0] mst13_slv1_hburst;
wire                           [3:0] mst13_slv1_hprot;
wire                           [2:0] mst13_slv1_hsize;
wire                           [1:0] mst13_slv1_htrans;
wire                                 mst13_slv1_hwrite;
wire                                 mst13_slv1_req;
wire                           [3:0] mst13_slv1_size;
wire                                 mst13_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst13_slv2_sel;
wire                    [DATA_MSB:0] hm13_slv2_hwdata;
wire                    [DATA_MSB:0] mst13_hs2_hrdata;
wire                                 mst13_hs2_hready;
wire                           [1:0] mst13_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv2_base;
wire                                 mst13_slv2_grant;
wire                    [ADDR_MSB:0] mst13_slv2_haddr;
wire                           [2:0] mst13_slv2_hburst;
wire                           [3:0] mst13_slv2_hprot;
wire                           [2:0] mst13_slv2_hsize;
wire                           [1:0] mst13_slv2_htrans;
wire                                 mst13_slv2_hwrite;
wire                                 mst13_slv2_req;
wire                           [3:0] mst13_slv2_size;
wire                                 mst13_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst13_slv3_sel;
wire                    [DATA_MSB:0] hm13_slv3_hwdata;
wire                    [DATA_MSB:0] mst13_hs3_hrdata;
wire                                 mst13_hs3_hready;
wire                           [1:0] mst13_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv3_base;
wire                                 mst13_slv3_grant;
wire                    [ADDR_MSB:0] mst13_slv3_haddr;
wire                           [2:0] mst13_slv3_hburst;
wire                           [3:0] mst13_slv3_hprot;
wire                           [2:0] mst13_slv3_hsize;
wire                           [1:0] mst13_slv3_htrans;
wire                                 mst13_slv3_hwrite;
wire                                 mst13_slv3_req;
wire                           [3:0] mst13_slv3_size;
wire                                 mst13_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst13_slv4_sel;
wire                    [DATA_MSB:0] hm13_slv4_hwdata;
wire                    [DATA_MSB:0] mst13_hs4_hrdata;
wire                                 mst13_hs4_hready;
wire                           [1:0] mst13_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv4_base;
wire                                 mst13_slv4_grant;
wire                    [ADDR_MSB:0] mst13_slv4_haddr;
wire                           [2:0] mst13_slv4_hburst;
wire                           [3:0] mst13_slv4_hprot;
wire                           [2:0] mst13_slv4_hsize;
wire                           [1:0] mst13_slv4_htrans;
wire                                 mst13_slv4_hwrite;
wire                                 mst13_slv4_req;
wire                           [3:0] mst13_slv4_size;
wire                                 mst13_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst13_slv5_sel;
wire                    [DATA_MSB:0] hm13_slv5_hwdata;
wire                    [DATA_MSB:0] mst13_hs5_hrdata;
wire                                 mst13_hs5_hready;
wire                           [1:0] mst13_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv5_base;
wire                                 mst13_slv5_grant;
wire                    [ADDR_MSB:0] mst13_slv5_haddr;
wire                           [2:0] mst13_slv5_hburst;
wire                           [3:0] mst13_slv5_hprot;
wire                           [2:0] mst13_slv5_hsize;
wire                           [1:0] mst13_slv5_htrans;
wire                                 mst13_slv5_hwrite;
wire                                 mst13_slv5_req;
wire                           [3:0] mst13_slv5_size;
wire                                 mst13_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst13_slv6_sel;
wire                    [DATA_MSB:0] hm13_slv6_hwdata;
wire                    [DATA_MSB:0] mst13_hs6_hrdata;
wire                                 mst13_hs6_hready;
wire                           [1:0] mst13_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv6_base;
wire                                 mst13_slv6_grant;
wire                    [ADDR_MSB:0] mst13_slv6_haddr;
wire                           [2:0] mst13_slv6_hburst;
wire                           [3:0] mst13_slv6_hprot;
wire                           [2:0] mst13_slv6_hsize;
wire                           [1:0] mst13_slv6_htrans;
wire                                 mst13_slv6_hwrite;
wire                                 mst13_slv6_req;
wire                           [3:0] mst13_slv6_size;
wire                                 mst13_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst13_slv7_sel;
wire                    [DATA_MSB:0] hm13_slv7_hwdata;
wire                    [DATA_MSB:0] mst13_hs7_hrdata;
wire                                 mst13_hs7_hready;
wire                           [1:0] mst13_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv7_base;
wire                                 mst13_slv7_grant;
wire                    [ADDR_MSB:0] mst13_slv7_haddr;
wire                           [2:0] mst13_slv7_hburst;
wire                           [3:0] mst13_slv7_hprot;
wire                           [2:0] mst13_slv7_hsize;
wire                           [1:0] mst13_slv7_htrans;
wire                                 mst13_slv7_hwrite;
wire                                 mst13_slv7_req;
wire                           [3:0] mst13_slv7_size;
wire                                 mst13_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst13_slv8_sel;
wire                    [DATA_MSB:0] hm13_slv8_hwdata;
wire                    [DATA_MSB:0] mst13_hs8_hrdata;
wire                                 mst13_hs8_hready;
wire                           [1:0] mst13_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv8_base;
wire                                 mst13_slv8_grant;
wire                    [ADDR_MSB:0] mst13_slv8_haddr;
wire                           [2:0] mst13_slv8_hburst;
wire                           [3:0] mst13_slv8_hprot;
wire                           [2:0] mst13_slv8_hsize;
wire                           [1:0] mst13_slv8_htrans;
wire                                 mst13_slv8_hwrite;
wire                                 mst13_slv8_req;
wire                           [3:0] mst13_slv8_size;
wire                                 mst13_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst13_slv9_sel;
wire                    [DATA_MSB:0] hm13_slv9_hwdata;
wire                    [DATA_MSB:0] mst13_hs9_hrdata;
wire                                 mst13_hs9_hready;
wire                           [1:0] mst13_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv9_base;
wire                                 mst13_slv9_grant;
wire                    [ADDR_MSB:0] mst13_slv9_haddr;
wire                           [2:0] mst13_slv9_hburst;
wire                           [3:0] mst13_slv9_hprot;
wire                           [2:0] mst13_slv9_hsize;
wire                           [1:0] mst13_slv9_htrans;
wire                                 mst13_slv9_hwrite;
wire                                 mst13_slv9_req;
wire                           [3:0] mst13_slv9_size;
wire                                 mst13_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst13_slv10_sel;
wire                    [DATA_MSB:0] hm13_slv10_hwdata;
wire                    [DATA_MSB:0] mst13_hs10_hrdata;
wire                                 mst13_hs10_hready;
wire                           [1:0] mst13_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv10_base;
wire                                 mst13_slv10_grant;
wire                    [ADDR_MSB:0] mst13_slv10_haddr;
wire                           [2:0] mst13_slv10_hburst;
wire                           [3:0] mst13_slv10_hprot;
wire                           [2:0] mst13_slv10_hsize;
wire                           [1:0] mst13_slv10_htrans;
wire                                 mst13_slv10_hwrite;
wire                                 mst13_slv10_req;
wire                           [3:0] mst13_slv10_size;
wire                                 mst13_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst13_slv11_sel;
wire                    [DATA_MSB:0] hm13_slv11_hwdata;
wire                    [DATA_MSB:0] mst13_hs11_hrdata;
wire                                 mst13_hs11_hready;
wire                           [1:0] mst13_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv11_base;
wire                                 mst13_slv11_grant;
wire                    [ADDR_MSB:0] mst13_slv11_haddr;
wire                           [2:0] mst13_slv11_hburst;
wire                           [3:0] mst13_slv11_hprot;
wire                           [2:0] mst13_slv11_hsize;
wire                           [1:0] mst13_slv11_htrans;
wire                                 mst13_slv11_hwrite;
wire                                 mst13_slv11_req;
wire                           [3:0] mst13_slv11_size;
wire                                 mst13_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst13_slv12_sel;
wire                    [DATA_MSB:0] hm13_slv12_hwdata;
wire                    [DATA_MSB:0] mst13_hs12_hrdata;
wire                                 mst13_hs12_hready;
wire                           [1:0] mst13_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv12_base;
wire                                 mst13_slv12_grant;
wire                    [ADDR_MSB:0] mst13_slv12_haddr;
wire                           [2:0] mst13_slv12_hburst;
wire                           [3:0] mst13_slv12_hprot;
wire                           [2:0] mst13_slv12_hsize;
wire                           [1:0] mst13_slv12_htrans;
wire                                 mst13_slv12_hwrite;
wire                                 mst13_slv12_req;
wire                           [3:0] mst13_slv12_size;
wire                                 mst13_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst13_slv13_sel;
wire                    [DATA_MSB:0] hm13_slv13_hwdata;
wire                    [DATA_MSB:0] mst13_hs13_hrdata;
wire                                 mst13_hs13_hready;
wire                           [1:0] mst13_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv13_base;
wire                                 mst13_slv13_grant;
wire                    [ADDR_MSB:0] mst13_slv13_haddr;
wire                           [2:0] mst13_slv13_hburst;
wire                           [3:0] mst13_slv13_hprot;
wire                           [2:0] mst13_slv13_hsize;
wire                           [1:0] mst13_slv13_htrans;
wire                                 mst13_slv13_hwrite;
wire                                 mst13_slv13_req;
wire                           [3:0] mst13_slv13_size;
wire                                 mst13_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst13_slv14_sel;
wire                    [DATA_MSB:0] hm13_slv14_hwdata;
wire                    [DATA_MSB:0] mst13_hs14_hrdata;
wire                                 mst13_hs14_hready;
wire                           [1:0] mst13_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv14_base;
wire                                 mst13_slv14_grant;
wire                    [ADDR_MSB:0] mst13_slv14_haddr;
wire                           [2:0] mst13_slv14_hburst;
wire                           [3:0] mst13_slv14_hprot;
wire                           [2:0] mst13_slv14_hsize;
wire                           [1:0] mst13_slv14_htrans;
wire                                 mst13_slv14_hwrite;
wire                                 mst13_slv14_req;
wire                           [3:0] mst13_slv14_size;
wire                                 mst13_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst13_slv15_sel;
wire                    [DATA_MSB:0] hm13_slv15_hwdata;
wire                    [DATA_MSB:0] mst13_hs15_hrdata;
wire                                 mst13_hs15_hready;
wire                           [1:0] mst13_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv15_base;
wire                                 mst13_slv15_grant;
wire                    [ADDR_MSB:0] mst13_slv15_haddr;
wire                           [2:0] mst13_slv15_hburst;
wire                           [3:0] mst13_slv15_hprot;
wire                           [2:0] mst13_slv15_hsize;
wire                           [1:0] mst13_slv15_htrans;
wire                                 mst13_slv15_hwrite;
wire                                 mst13_slv15_req;
wire                           [3:0] mst13_slv15_size;
wire                                 mst13_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst13_slv0_sel;
wire                    [DATA_MSB:0] hm13_slv0_hwdata;
wire                    [DATA_MSB:0] mst13_hs0_hrdata;
wire                                 mst13_hs0_hready;
wire                           [1:0] mst13_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst13_slv0_base;
wire                                 mst13_slv0_grant;
wire                    [ADDR_MSB:0] mst13_slv0_haddr;
wire                           [2:0] mst13_slv0_hburst;
wire                           [3:0] mst13_slv0_hprot;
wire                           [2:0] mst13_slv0_hsize;
wire                           [1:0] mst13_slv0_htrans;
wire                                 mst13_slv0_hwrite;
wire                                 mst13_slv0_req;
wire                           [3:0] mst13_slv0_size;
wire                                 mst13_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST14
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst14_slv1_sel;
wire                    [DATA_MSB:0] hm14_slv1_hwdata;
wire                    [DATA_MSB:0] mst14_hs1_hrdata;
wire                                 mst14_hs1_hready;
wire                           [1:0] mst14_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv1_base;
wire                                 mst14_slv1_grant;
wire                    [ADDR_MSB:0] mst14_slv1_haddr;
wire                           [2:0] mst14_slv1_hburst;
wire                           [3:0] mst14_slv1_hprot;
wire                           [2:0] mst14_slv1_hsize;
wire                           [1:0] mst14_slv1_htrans;
wire                                 mst14_slv1_hwrite;
wire                                 mst14_slv1_req;
wire                           [3:0] mst14_slv1_size;
wire                                 mst14_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst14_slv2_sel;
wire                    [DATA_MSB:0] hm14_slv2_hwdata;
wire                    [DATA_MSB:0] mst14_hs2_hrdata;
wire                                 mst14_hs2_hready;
wire                           [1:0] mst14_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv2_base;
wire                                 mst14_slv2_grant;
wire                    [ADDR_MSB:0] mst14_slv2_haddr;
wire                           [2:0] mst14_slv2_hburst;
wire                           [3:0] mst14_slv2_hprot;
wire                           [2:0] mst14_slv2_hsize;
wire                           [1:0] mst14_slv2_htrans;
wire                                 mst14_slv2_hwrite;
wire                                 mst14_slv2_req;
wire                           [3:0] mst14_slv2_size;
wire                                 mst14_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst14_slv3_sel;
wire                    [DATA_MSB:0] hm14_slv3_hwdata;
wire                    [DATA_MSB:0] mst14_hs3_hrdata;
wire                                 mst14_hs3_hready;
wire                           [1:0] mst14_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv3_base;
wire                                 mst14_slv3_grant;
wire                    [ADDR_MSB:0] mst14_slv3_haddr;
wire                           [2:0] mst14_slv3_hburst;
wire                           [3:0] mst14_slv3_hprot;
wire                           [2:0] mst14_slv3_hsize;
wire                           [1:0] mst14_slv3_htrans;
wire                                 mst14_slv3_hwrite;
wire                                 mst14_slv3_req;
wire                           [3:0] mst14_slv3_size;
wire                                 mst14_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst14_slv4_sel;
wire                    [DATA_MSB:0] hm14_slv4_hwdata;
wire                    [DATA_MSB:0] mst14_hs4_hrdata;
wire                                 mst14_hs4_hready;
wire                           [1:0] mst14_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv4_base;
wire                                 mst14_slv4_grant;
wire                    [ADDR_MSB:0] mst14_slv4_haddr;
wire                           [2:0] mst14_slv4_hburst;
wire                           [3:0] mst14_slv4_hprot;
wire                           [2:0] mst14_slv4_hsize;
wire                           [1:0] mst14_slv4_htrans;
wire                                 mst14_slv4_hwrite;
wire                                 mst14_slv4_req;
wire                           [3:0] mst14_slv4_size;
wire                                 mst14_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst14_slv5_sel;
wire                    [DATA_MSB:0] hm14_slv5_hwdata;
wire                    [DATA_MSB:0] mst14_hs5_hrdata;
wire                                 mst14_hs5_hready;
wire                           [1:0] mst14_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv5_base;
wire                                 mst14_slv5_grant;
wire                    [ADDR_MSB:0] mst14_slv5_haddr;
wire                           [2:0] mst14_slv5_hburst;
wire                           [3:0] mst14_slv5_hprot;
wire                           [2:0] mst14_slv5_hsize;
wire                           [1:0] mst14_slv5_htrans;
wire                                 mst14_slv5_hwrite;
wire                                 mst14_slv5_req;
wire                           [3:0] mst14_slv5_size;
wire                                 mst14_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst14_slv6_sel;
wire                    [DATA_MSB:0] hm14_slv6_hwdata;
wire                    [DATA_MSB:0] mst14_hs6_hrdata;
wire                                 mst14_hs6_hready;
wire                           [1:0] mst14_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv6_base;
wire                                 mst14_slv6_grant;
wire                    [ADDR_MSB:0] mst14_slv6_haddr;
wire                           [2:0] mst14_slv6_hburst;
wire                           [3:0] mst14_slv6_hprot;
wire                           [2:0] mst14_slv6_hsize;
wire                           [1:0] mst14_slv6_htrans;
wire                                 mst14_slv6_hwrite;
wire                                 mst14_slv6_req;
wire                           [3:0] mst14_slv6_size;
wire                                 mst14_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst14_slv7_sel;
wire                    [DATA_MSB:0] hm14_slv7_hwdata;
wire                    [DATA_MSB:0] mst14_hs7_hrdata;
wire                                 mst14_hs7_hready;
wire                           [1:0] mst14_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv7_base;
wire                                 mst14_slv7_grant;
wire                    [ADDR_MSB:0] mst14_slv7_haddr;
wire                           [2:0] mst14_slv7_hburst;
wire                           [3:0] mst14_slv7_hprot;
wire                           [2:0] mst14_slv7_hsize;
wire                           [1:0] mst14_slv7_htrans;
wire                                 mst14_slv7_hwrite;
wire                                 mst14_slv7_req;
wire                           [3:0] mst14_slv7_size;
wire                                 mst14_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst14_slv8_sel;
wire                    [DATA_MSB:0] hm14_slv8_hwdata;
wire                    [DATA_MSB:0] mst14_hs8_hrdata;
wire                                 mst14_hs8_hready;
wire                           [1:0] mst14_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv8_base;
wire                                 mst14_slv8_grant;
wire                    [ADDR_MSB:0] mst14_slv8_haddr;
wire                           [2:0] mst14_slv8_hburst;
wire                           [3:0] mst14_slv8_hprot;
wire                           [2:0] mst14_slv8_hsize;
wire                           [1:0] mst14_slv8_htrans;
wire                                 mst14_slv8_hwrite;
wire                                 mst14_slv8_req;
wire                           [3:0] mst14_slv8_size;
wire                                 mst14_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst14_slv9_sel;
wire                    [DATA_MSB:0] hm14_slv9_hwdata;
wire                    [DATA_MSB:0] mst14_hs9_hrdata;
wire                                 mst14_hs9_hready;
wire                           [1:0] mst14_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv9_base;
wire                                 mst14_slv9_grant;
wire                    [ADDR_MSB:0] mst14_slv9_haddr;
wire                           [2:0] mst14_slv9_hburst;
wire                           [3:0] mst14_slv9_hprot;
wire                           [2:0] mst14_slv9_hsize;
wire                           [1:0] mst14_slv9_htrans;
wire                                 mst14_slv9_hwrite;
wire                                 mst14_slv9_req;
wire                           [3:0] mst14_slv9_size;
wire                                 mst14_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst14_slv10_sel;
wire                    [DATA_MSB:0] hm14_slv10_hwdata;
wire                    [DATA_MSB:0] mst14_hs10_hrdata;
wire                                 mst14_hs10_hready;
wire                           [1:0] mst14_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv10_base;
wire                                 mst14_slv10_grant;
wire                    [ADDR_MSB:0] mst14_slv10_haddr;
wire                           [2:0] mst14_slv10_hburst;
wire                           [3:0] mst14_slv10_hprot;
wire                           [2:0] mst14_slv10_hsize;
wire                           [1:0] mst14_slv10_htrans;
wire                                 mst14_slv10_hwrite;
wire                                 mst14_slv10_req;
wire                           [3:0] mst14_slv10_size;
wire                                 mst14_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst14_slv11_sel;
wire                    [DATA_MSB:0] hm14_slv11_hwdata;
wire                    [DATA_MSB:0] mst14_hs11_hrdata;
wire                                 mst14_hs11_hready;
wire                           [1:0] mst14_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv11_base;
wire                                 mst14_slv11_grant;
wire                    [ADDR_MSB:0] mst14_slv11_haddr;
wire                           [2:0] mst14_slv11_hburst;
wire                           [3:0] mst14_slv11_hprot;
wire                           [2:0] mst14_slv11_hsize;
wire                           [1:0] mst14_slv11_htrans;
wire                                 mst14_slv11_hwrite;
wire                                 mst14_slv11_req;
wire                           [3:0] mst14_slv11_size;
wire                                 mst14_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst14_slv12_sel;
wire                    [DATA_MSB:0] hm14_slv12_hwdata;
wire                    [DATA_MSB:0] mst14_hs12_hrdata;
wire                                 mst14_hs12_hready;
wire                           [1:0] mst14_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv12_base;
wire                                 mst14_slv12_grant;
wire                    [ADDR_MSB:0] mst14_slv12_haddr;
wire                           [2:0] mst14_slv12_hburst;
wire                           [3:0] mst14_slv12_hprot;
wire                           [2:0] mst14_slv12_hsize;
wire                           [1:0] mst14_slv12_htrans;
wire                                 mst14_slv12_hwrite;
wire                                 mst14_slv12_req;
wire                           [3:0] mst14_slv12_size;
wire                                 mst14_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst14_slv13_sel;
wire                    [DATA_MSB:0] hm14_slv13_hwdata;
wire                    [DATA_MSB:0] mst14_hs13_hrdata;
wire                                 mst14_hs13_hready;
wire                           [1:0] mst14_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv13_base;
wire                                 mst14_slv13_grant;
wire                    [ADDR_MSB:0] mst14_slv13_haddr;
wire                           [2:0] mst14_slv13_hburst;
wire                           [3:0] mst14_slv13_hprot;
wire                           [2:0] mst14_slv13_hsize;
wire                           [1:0] mst14_slv13_htrans;
wire                                 mst14_slv13_hwrite;
wire                                 mst14_slv13_req;
wire                           [3:0] mst14_slv13_size;
wire                                 mst14_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst14_slv14_sel;
wire                    [DATA_MSB:0] hm14_slv14_hwdata;
wire                    [DATA_MSB:0] mst14_hs14_hrdata;
wire                                 mst14_hs14_hready;
wire                           [1:0] mst14_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv14_base;
wire                                 mst14_slv14_grant;
wire                    [ADDR_MSB:0] mst14_slv14_haddr;
wire                           [2:0] mst14_slv14_hburst;
wire                           [3:0] mst14_slv14_hprot;
wire                           [2:0] mst14_slv14_hsize;
wire                           [1:0] mst14_slv14_htrans;
wire                                 mst14_slv14_hwrite;
wire                                 mst14_slv14_req;
wire                           [3:0] mst14_slv14_size;
wire                                 mst14_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst14_slv15_sel;
wire                    [DATA_MSB:0] hm14_slv15_hwdata;
wire                    [DATA_MSB:0] mst14_hs15_hrdata;
wire                                 mst14_hs15_hready;
wire                           [1:0] mst14_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv15_base;
wire                                 mst14_slv15_grant;
wire                    [ADDR_MSB:0] mst14_slv15_haddr;
wire                           [2:0] mst14_slv15_hburst;
wire                           [3:0] mst14_slv15_hprot;
wire                           [2:0] mst14_slv15_hsize;
wire                           [1:0] mst14_slv15_htrans;
wire                                 mst14_slv15_hwrite;
wire                                 mst14_slv15_req;
wire                           [3:0] mst14_slv15_size;
wire                                 mst14_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst14_slv0_sel;
wire                    [DATA_MSB:0] hm14_slv0_hwdata;
wire                    [DATA_MSB:0] mst14_hs0_hrdata;
wire                                 mst14_hs0_hready;
wire                           [1:0] mst14_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst14_slv0_base;
wire                                 mst14_slv0_grant;
wire                    [ADDR_MSB:0] mst14_slv0_haddr;
wire                           [2:0] mst14_slv0_hburst;
wire                           [3:0] mst14_slv0_hprot;
wire                           [2:0] mst14_slv0_hsize;
wire                           [1:0] mst14_slv0_htrans;
wire                                 mst14_slv0_hwrite;
wire                                 mst14_slv0_req;
wire                           [3:0] mst14_slv0_size;
wire                                 mst14_slv0_ack;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST15
   `ifdef ATCBMC200_AHB_SLV1
wire                                 mst15_slv1_sel;
wire                    [DATA_MSB:0] hm15_slv1_hwdata;
wire                    [DATA_MSB:0] mst15_hs1_hrdata;
wire                                 mst15_hs1_hready;
wire                           [1:0] mst15_hs1_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv1_base;
wire                                 mst15_slv1_grant;
wire                    [ADDR_MSB:0] mst15_slv1_haddr;
wire                           [2:0] mst15_slv1_hburst;
wire                           [3:0] mst15_slv1_hprot;
wire                           [2:0] mst15_slv1_hsize;
wire                           [1:0] mst15_slv1_htrans;
wire                                 mst15_slv1_hwrite;
wire                                 mst15_slv1_req;
wire                           [3:0] mst15_slv1_size;
wire                                 mst15_slv1_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
wire                                 mst15_slv2_sel;
wire                    [DATA_MSB:0] hm15_slv2_hwdata;
wire                    [DATA_MSB:0] mst15_hs2_hrdata;
wire                                 mst15_hs2_hready;
wire                           [1:0] mst15_hs2_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv2_base;
wire                                 mst15_slv2_grant;
wire                    [ADDR_MSB:0] mst15_slv2_haddr;
wire                           [2:0] mst15_slv2_hburst;
wire                           [3:0] mst15_slv2_hprot;
wire                           [2:0] mst15_slv2_hsize;
wire                           [1:0] mst15_slv2_htrans;
wire                                 mst15_slv2_hwrite;
wire                                 mst15_slv2_req;
wire                           [3:0] mst15_slv2_size;
wire                                 mst15_slv2_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
wire                                 mst15_slv3_sel;
wire                    [DATA_MSB:0] hm15_slv3_hwdata;
wire                    [DATA_MSB:0] mst15_hs3_hrdata;
wire                                 mst15_hs3_hready;
wire                           [1:0] mst15_hs3_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv3_base;
wire                                 mst15_slv3_grant;
wire                    [ADDR_MSB:0] mst15_slv3_haddr;
wire                           [2:0] mst15_slv3_hburst;
wire                           [3:0] mst15_slv3_hprot;
wire                           [2:0] mst15_slv3_hsize;
wire                           [1:0] mst15_slv3_htrans;
wire                                 mst15_slv3_hwrite;
wire                                 mst15_slv3_req;
wire                           [3:0] mst15_slv3_size;
wire                                 mst15_slv3_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
wire                                 mst15_slv4_sel;
wire                    [DATA_MSB:0] hm15_slv4_hwdata;
wire                    [DATA_MSB:0] mst15_hs4_hrdata;
wire                                 mst15_hs4_hready;
wire                           [1:0] mst15_hs4_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv4_base;
wire                                 mst15_slv4_grant;
wire                    [ADDR_MSB:0] mst15_slv4_haddr;
wire                           [2:0] mst15_slv4_hburst;
wire                           [3:0] mst15_slv4_hprot;
wire                           [2:0] mst15_slv4_hsize;
wire                           [1:0] mst15_slv4_htrans;
wire                                 mst15_slv4_hwrite;
wire                                 mst15_slv4_req;
wire                           [3:0] mst15_slv4_size;
wire                                 mst15_slv4_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
wire                                 mst15_slv5_sel;
wire                    [DATA_MSB:0] hm15_slv5_hwdata;
wire                    [DATA_MSB:0] mst15_hs5_hrdata;
wire                                 mst15_hs5_hready;
wire                           [1:0] mst15_hs5_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv5_base;
wire                                 mst15_slv5_grant;
wire                    [ADDR_MSB:0] mst15_slv5_haddr;
wire                           [2:0] mst15_slv5_hburst;
wire                           [3:0] mst15_slv5_hprot;
wire                           [2:0] mst15_slv5_hsize;
wire                           [1:0] mst15_slv5_htrans;
wire                                 mst15_slv5_hwrite;
wire                                 mst15_slv5_req;
wire                           [3:0] mst15_slv5_size;
wire                                 mst15_slv5_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
wire                                 mst15_slv6_sel;
wire                    [DATA_MSB:0] hm15_slv6_hwdata;
wire                    [DATA_MSB:0] mst15_hs6_hrdata;
wire                                 mst15_hs6_hready;
wire                           [1:0] mst15_hs6_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv6_base;
wire                                 mst15_slv6_grant;
wire                    [ADDR_MSB:0] mst15_slv6_haddr;
wire                           [2:0] mst15_slv6_hburst;
wire                           [3:0] mst15_slv6_hprot;
wire                           [2:0] mst15_slv6_hsize;
wire                           [1:0] mst15_slv6_htrans;
wire                                 mst15_slv6_hwrite;
wire                                 mst15_slv6_req;
wire                           [3:0] mst15_slv6_size;
wire                                 mst15_slv6_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
wire                                 mst15_slv7_sel;
wire                    [DATA_MSB:0] hm15_slv7_hwdata;
wire                    [DATA_MSB:0] mst15_hs7_hrdata;
wire                                 mst15_hs7_hready;
wire                           [1:0] mst15_hs7_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv7_base;
wire                                 mst15_slv7_grant;
wire                    [ADDR_MSB:0] mst15_slv7_haddr;
wire                           [2:0] mst15_slv7_hburst;
wire                           [3:0] mst15_slv7_hprot;
wire                           [2:0] mst15_slv7_hsize;
wire                           [1:0] mst15_slv7_htrans;
wire                                 mst15_slv7_hwrite;
wire                                 mst15_slv7_req;
wire                           [3:0] mst15_slv7_size;
wire                                 mst15_slv7_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
wire                                 mst15_slv8_sel;
wire                    [DATA_MSB:0] hm15_slv8_hwdata;
wire                    [DATA_MSB:0] mst15_hs8_hrdata;
wire                                 mst15_hs8_hready;
wire                           [1:0] mst15_hs8_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv8_base;
wire                                 mst15_slv8_grant;
wire                    [ADDR_MSB:0] mst15_slv8_haddr;
wire                           [2:0] mst15_slv8_hburst;
wire                           [3:0] mst15_slv8_hprot;
wire                           [2:0] mst15_slv8_hsize;
wire                           [1:0] mst15_slv8_htrans;
wire                                 mst15_slv8_hwrite;
wire                                 mst15_slv8_req;
wire                           [3:0] mst15_slv8_size;
wire                                 mst15_slv8_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
wire                                 mst15_slv9_sel;
wire                    [DATA_MSB:0] hm15_slv9_hwdata;
wire                    [DATA_MSB:0] mst15_hs9_hrdata;
wire                                 mst15_hs9_hready;
wire                           [1:0] mst15_hs9_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv9_base;
wire                                 mst15_slv9_grant;
wire                    [ADDR_MSB:0] mst15_slv9_haddr;
wire                           [2:0] mst15_slv9_hburst;
wire                           [3:0] mst15_slv9_hprot;
wire                           [2:0] mst15_slv9_hsize;
wire                           [1:0] mst15_slv9_htrans;
wire                                 mst15_slv9_hwrite;
wire                                 mst15_slv9_req;
wire                           [3:0] mst15_slv9_size;
wire                                 mst15_slv9_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
wire                                 mst15_slv10_sel;
wire                    [DATA_MSB:0] hm15_slv10_hwdata;
wire                    [DATA_MSB:0] mst15_hs10_hrdata;
wire                                 mst15_hs10_hready;
wire                           [1:0] mst15_hs10_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv10_base;
wire                                 mst15_slv10_grant;
wire                    [ADDR_MSB:0] mst15_slv10_haddr;
wire                           [2:0] mst15_slv10_hburst;
wire                           [3:0] mst15_slv10_hprot;
wire                           [2:0] mst15_slv10_hsize;
wire                           [1:0] mst15_slv10_htrans;
wire                                 mst15_slv10_hwrite;
wire                                 mst15_slv10_req;
wire                           [3:0] mst15_slv10_size;
wire                                 mst15_slv10_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
wire                                 mst15_slv11_sel;
wire                    [DATA_MSB:0] hm15_slv11_hwdata;
wire                    [DATA_MSB:0] mst15_hs11_hrdata;
wire                                 mst15_hs11_hready;
wire                           [1:0] mst15_hs11_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv11_base;
wire                                 mst15_slv11_grant;
wire                    [ADDR_MSB:0] mst15_slv11_haddr;
wire                           [2:0] mst15_slv11_hburst;
wire                           [3:0] mst15_slv11_hprot;
wire                           [2:0] mst15_slv11_hsize;
wire                           [1:0] mst15_slv11_htrans;
wire                                 mst15_slv11_hwrite;
wire                                 mst15_slv11_req;
wire                           [3:0] mst15_slv11_size;
wire                                 mst15_slv11_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
wire                                 mst15_slv12_sel;
wire                    [DATA_MSB:0] hm15_slv12_hwdata;
wire                    [DATA_MSB:0] mst15_hs12_hrdata;
wire                                 mst15_hs12_hready;
wire                           [1:0] mst15_hs12_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv12_base;
wire                                 mst15_slv12_grant;
wire                    [ADDR_MSB:0] mst15_slv12_haddr;
wire                           [2:0] mst15_slv12_hburst;
wire                           [3:0] mst15_slv12_hprot;
wire                           [2:0] mst15_slv12_hsize;
wire                           [1:0] mst15_slv12_htrans;
wire                                 mst15_slv12_hwrite;
wire                                 mst15_slv12_req;
wire                           [3:0] mst15_slv12_size;
wire                                 mst15_slv12_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
wire                                 mst15_slv13_sel;
wire                    [DATA_MSB:0] hm15_slv13_hwdata;
wire                    [DATA_MSB:0] mst15_hs13_hrdata;
wire                                 mst15_hs13_hready;
wire                           [1:0] mst15_hs13_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv13_base;
wire                                 mst15_slv13_grant;
wire                    [ADDR_MSB:0] mst15_slv13_haddr;
wire                           [2:0] mst15_slv13_hburst;
wire                           [3:0] mst15_slv13_hprot;
wire                           [2:0] mst15_slv13_hsize;
wire                           [1:0] mst15_slv13_htrans;
wire                                 mst15_slv13_hwrite;
wire                                 mst15_slv13_req;
wire                           [3:0] mst15_slv13_size;
wire                                 mst15_slv13_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
wire                                 mst15_slv14_sel;
wire                    [DATA_MSB:0] hm15_slv14_hwdata;
wire                    [DATA_MSB:0] mst15_hs14_hrdata;
wire                                 mst15_hs14_hready;
wire                           [1:0] mst15_hs14_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv14_base;
wire                                 mst15_slv14_grant;
wire                    [ADDR_MSB:0] mst15_slv14_haddr;
wire                           [2:0] mst15_slv14_hburst;
wire                           [3:0] mst15_slv14_hprot;
wire                           [2:0] mst15_slv14_hsize;
wire                           [1:0] mst15_slv14_htrans;
wire                                 mst15_slv14_hwrite;
wire                                 mst15_slv14_req;
wire                           [3:0] mst15_slv14_size;
wire                                 mst15_slv14_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
wire                                 mst15_slv15_sel;
wire                    [DATA_MSB:0] hm15_slv15_hwdata;
wire                    [DATA_MSB:0] mst15_hs15_hrdata;
wire                                 mst15_hs15_hready;
wire                           [1:0] mst15_hs15_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv15_base;
wire                                 mst15_slv15_grant;
wire                    [ADDR_MSB:0] mst15_slv15_haddr;
wire                           [2:0] mst15_slv15_hburst;
wire                           [3:0] mst15_slv15_hprot;
wire                           [2:0] mst15_slv15_hsize;
wire                           [1:0] mst15_slv15_htrans;
wire                                 mst15_slv15_hwrite;
wire                                 mst15_slv15_req;
wire                           [3:0] mst15_slv15_size;
wire                                 mst15_slv15_ack;
   `endif
   `ifdef ATCBMC200_AHB_SLV0
wire                                 mst15_slv0_sel;
wire                    [DATA_MSB:0] hm15_slv0_hwdata;
wire                    [DATA_MSB:0] mst15_hs0_hrdata;
wire                                 mst15_hs0_hready;
wire                           [1:0] mst15_hs0_hresp;
wire        [ADDR_MSB:BASE_ADDR_LSB] mst15_slv0_base;
wire                                 mst15_slv0_grant;
wire                    [ADDR_MSB:0] mst15_slv0_haddr;
wire                           [2:0] mst15_slv0_hburst;
wire                           [3:0] mst15_slv0_hprot;
wire                           [2:0] mst15_slv0_hsize;
wire                           [1:0] mst15_slv0_htrans;
wire                                 mst15_slv0_hwrite;
wire                                 mst15_slv0_req;
wire                           [3:0] mst15_slv0_size;
wire                                 mst15_slv0_ack;
   `endif
`endif
wire                                 ctrl_wen;
wire                                 hs0_bmc_hready;
wire                    [DATA_MSB:0] hs0_hrdata;
wire                           [1:0] hs0_hresp;
wire                          [15:0] init_priority;
wire                                 mst0_highest_en;
wire                                 resp_mode;
wire        [ADDR_MSB:BASE_ADDR_LSB] slv0_base;
wire                           [3:0] slv0_size;
wire                                 bmc_hs0_hready;
wire                    [ADDR_MSB:0] hs0_haddr;
wire                                 hs0_hsel;
wire                           [2:0] hs0_hsize;
wire                           [1:0] hs0_htrans;
wire                    [DATA_MSB:0] hs0_hwdata;
wire                                 hs0_hwrite;

`ifdef ATCBMC200_AHB_SLV0
`else
	assign	hs0_hwrite	=	1'b0;
	assign	hs0_haddr	=	{ADDR_WIDTH{1'b0}};
	assign	hs0_hsize	=	3'd0;
	assign	hs0_htrans	=	2'd0;
	assign	hs0_hsel	=	1'b0;
	assign	hs0_hwdata	=	{DATA_WIDTH{1'b0}};
	assign	bmc_hs0_hready	=	1'b1;
	assign	slv0_base	=	{(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
	assign	slv0_size	=	4'd0;
`endif

atcbmc200_mux #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mux (
`ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata        (hm0_hwdata        ),
	.mst0_haddr        (mst0_haddr        ),
	.mst0_hburst       (mst0_hburst       ),
	.mst0_hprot        (mst0_hprot        ),
	.mst0_hsize        (mst0_hsize        ),
	.mst0_htrans       (mst0_htrans       ),
	.mst0_hwrite       (mst0_hwrite       ),
`endif
`ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata        (hm1_hwdata        ),
	.mst1_haddr        (mst1_haddr        ),
	.mst1_hburst       (mst1_hburst       ),
	.mst1_hprot        (mst1_hprot        ),
	.mst1_hsize        (mst1_hsize        ),
	.mst1_htrans       (mst1_htrans       ),
	.mst1_hwrite       (mst1_hwrite       ),
`endif
`ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata        (hm2_hwdata        ),
	.mst2_haddr        (mst2_haddr        ),
	.mst2_hburst       (mst2_hburst       ),
	.mst2_hprot        (mst2_hprot        ),
	.mst2_hsize        (mst2_hsize        ),
	.mst2_htrans       (mst2_htrans       ),
	.mst2_hwrite       (mst2_hwrite       ),
`endif
`ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata        (hm3_hwdata        ),
	.mst3_haddr        (mst3_haddr        ),
	.mst3_hburst       (mst3_hburst       ),
	.mst3_hprot        (mst3_hprot        ),
	.mst3_hsize        (mst3_hsize        ),
	.mst3_htrans       (mst3_htrans       ),
	.mst3_hwrite       (mst3_hwrite       ),
`endif
`ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata        (hm4_hwdata        ),
	.mst4_haddr        (mst4_haddr        ),
	.mst4_hburst       (mst4_hburst       ),
	.mst4_hprot        (mst4_hprot        ),
	.mst4_hsize        (mst4_hsize        ),
	.mst4_htrans       (mst4_htrans       ),
	.mst4_hwrite       (mst4_hwrite       ),
`endif
`ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata        (hm5_hwdata        ),
	.mst5_haddr        (mst5_haddr        ),
	.mst5_hburst       (mst5_hburst       ),
	.mst5_hprot        (mst5_hprot        ),
	.mst5_hsize        (mst5_hsize        ),
	.mst5_htrans       (mst5_htrans       ),
	.mst5_hwrite       (mst5_hwrite       ),
`endif
`ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata        (hm6_hwdata        ),
	.mst6_haddr        (mst6_haddr        ),
	.mst6_hburst       (mst6_hburst       ),
	.mst6_hprot        (mst6_hprot        ),
	.mst6_hsize        (mst6_hsize        ),
	.mst6_htrans       (mst6_htrans       ),
	.mst6_hwrite       (mst6_hwrite       ),
`endif
`ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata        (hm7_hwdata        ),
	.mst7_haddr        (mst7_haddr        ),
	.mst7_hburst       (mst7_hburst       ),
	.mst7_hprot        (mst7_hprot        ),
	.mst7_hsize        (mst7_hsize        ),
	.mst7_htrans       (mst7_htrans       ),
	.mst7_hwrite       (mst7_hwrite       ),
`endif
`ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata        (hm8_hwdata        ),
	.mst8_haddr        (mst8_haddr        ),
	.mst8_hburst       (mst8_hburst       ),
	.mst8_hprot        (mst8_hprot        ),
	.mst8_hsize        (mst8_hsize        ),
	.mst8_htrans       (mst8_htrans       ),
	.mst8_hwrite       (mst8_hwrite       ),
`endif
`ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata        (hm9_hwdata        ),
	.mst9_haddr        (mst9_haddr        ),
	.mst9_hburst       (mst9_hburst       ),
	.mst9_hprot        (mst9_hprot        ),
	.mst9_hsize        (mst9_hsize        ),
	.mst9_htrans       (mst9_htrans       ),
	.mst9_hwrite       (mst9_hwrite       ),
`endif
`ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata       (hm10_hwdata       ),
	.mst10_haddr       (mst10_haddr       ),
	.mst10_hburst      (mst10_hburst      ),
	.mst10_hprot       (mst10_hprot       ),
	.mst10_hsize       (mst10_hsize       ),
	.mst10_htrans      (mst10_htrans      ),
	.mst10_hwrite      (mst10_hwrite      ),
`endif
`ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata       (hm11_hwdata       ),
	.mst11_haddr       (mst11_haddr       ),
	.mst11_hburst      (mst11_hburst      ),
	.mst11_hprot       (mst11_hprot       ),
	.mst11_hsize       (mst11_hsize       ),
	.mst11_htrans      (mst11_htrans      ),
	.mst11_hwrite      (mst11_hwrite      ),
`endif
`ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata       (hm12_hwdata       ),
	.mst12_haddr       (mst12_haddr       ),
	.mst12_hburst      (mst12_hburst      ),
	.mst12_hprot       (mst12_hprot       ),
	.mst12_hsize       (mst12_hsize       ),
	.mst12_htrans      (mst12_htrans      ),
	.mst12_hwrite      (mst12_hwrite      ),
`endif
`ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata       (hm13_hwdata       ),
	.mst13_haddr       (mst13_haddr       ),
	.mst13_hburst      (mst13_hburst      ),
	.mst13_hprot       (mst13_hprot       ),
	.mst13_hsize       (mst13_hsize       ),
	.mst13_htrans      (mst13_htrans      ),
	.mst13_hwrite      (mst13_hwrite      ),
`endif
`ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata       (hm14_hwdata       ),
	.mst14_haddr       (mst14_haddr       ),
	.mst14_hburst      (mst14_hburst      ),
	.mst14_hprot       (mst14_hprot       ),
	.mst14_hsize       (mst14_hsize       ),
	.mst14_htrans      (mst14_htrans      ),
	.mst14_hwrite      (mst14_hwrite      ),
`endif
`ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata       (hm15_hwdata       ),
	.mst15_haddr       (mst15_haddr       ),
	.mst15_hburst      (mst15_hburst      ),
	.mst15_hprot       (mst15_hprot       ),
	.mst15_hsize       (mst15_hsize       ),
	.mst15_htrans      (mst15_htrans      ),
	.mst15_hwrite      (mst15_hwrite      ),
`endif
`ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata        (hs1_hrdata        ),
	.hs1_hready        (hs1_bmc_hready    ),
	.hs1_hresp         (hs1_hresp         ),
	.slv1_base         (slv1_base         ),
	.slv1_size         (slv1_size         ),
`endif
`ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata        (hs2_hrdata        ),
	.hs2_hready        (hs2_bmc_hready    ),
	.hs2_hresp         (hs2_hresp         ),
	.slv2_base         (slv2_base         ),
	.slv2_size         (slv2_size         ),
`endif
`ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata        (hs3_hrdata        ),
	.hs3_hready        (hs3_bmc_hready    ),
	.hs3_hresp         (hs3_hresp         ),
	.slv3_base         (slv3_base         ),
	.slv3_size         (slv3_size         ),
`endif
`ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata        (hs4_hrdata        ),
	.hs4_hready        (hs4_bmc_hready    ),
	.hs4_hresp         (hs4_hresp         ),
	.slv4_base         (slv4_base         ),
	.slv4_size         (slv4_size         ),
`endif
`ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata        (hs5_hrdata        ),
	.hs5_hready        (hs5_bmc_hready    ),
	.hs5_hresp         (hs5_hresp         ),
	.slv5_base         (slv5_base         ),
	.slv5_size         (slv5_size         ),
`endif
`ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata        (hs6_hrdata        ),
	.hs6_hready        (hs6_bmc_hready    ),
	.hs6_hresp         (hs6_hresp         ),
	.slv6_base         (slv6_base         ),
	.slv6_size         (slv6_size         ),
`endif
`ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata        (hs7_hrdata        ),
	.hs7_hready        (hs7_bmc_hready    ),
	.hs7_hresp         (hs7_hresp         ),
	.slv7_base         (slv7_base         ),
	.slv7_size         (slv7_size         ),
`endif
`ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata        (hs8_hrdata        ),
	.hs8_hready        (hs8_bmc_hready    ),
	.hs8_hresp         (hs8_hresp         ),
	.slv8_base         (slv8_base         ),
	.slv8_size         (slv8_size         ),
`endif
`ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata        (hs9_hrdata        ),
	.hs9_hready        (hs9_bmc_hready    ),
	.hs9_hresp         (hs9_hresp         ),
	.slv9_base         (slv9_base         ),
	.slv9_size         (slv9_size         ),
`endif
`ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata       (hs10_hrdata       ),
	.hs10_hready       (hs10_bmc_hready   ),
	.hs10_hresp        (hs10_hresp        ),
	.slv10_base        (slv10_base        ),
	.slv10_size        (slv10_size        ),
`endif
`ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata       (hs11_hrdata       ),
	.hs11_hready       (hs11_bmc_hready   ),
	.hs11_hresp        (hs11_hresp        ),
	.slv11_base        (slv11_base        ),
	.slv11_size        (slv11_size        ),
`endif
`ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata       (hs12_hrdata       ),
	.hs12_hready       (hs12_bmc_hready   ),
	.hs12_hresp        (hs12_hresp        ),
	.slv12_base        (slv12_base        ),
	.slv12_size        (slv12_size        ),
`endif
`ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata       (hs13_hrdata       ),
	.hs13_hready       (hs13_bmc_hready   ),
	.hs13_hresp        (hs13_hresp        ),
	.slv13_base        (slv13_base        ),
	.slv13_size        (slv13_size        ),
`endif
`ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata       (hs14_hrdata       ),
	.hs14_hready       (hs14_bmc_hready   ),
	.hs14_hresp        (hs14_hresp        ),
	.slv14_base        (slv14_base        ),
	.slv14_size        (slv14_size        ),
`endif
`ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata       (hs15_hrdata       ),
	.hs15_hready       (hs15_bmc_hready   ),
	.hs15_hresp        (hs15_hresp        ),
	.slv15_base        (slv15_base        ),
	.slv15_size        (slv15_size        ),
`endif
`ifdef ATCBMC200_AHB_MST0
   `ifdef ATCBMC200_AHB_SLV0
	.hm0_slv0_hwdata   (hm0_slv0_hwdata   ),
	.mst0_hs0_hrdata   (mst0_hs0_hrdata   ),
	.mst0_hs0_hready   (mst0_hs0_hready   ),
	.mst0_hs0_hresp    (mst0_hs0_hresp    ),
	.mst0_slv0_ack     (mst0_slv0_ack     ),
	.mst0_slv0_base    (mst0_slv0_base    ),
	.mst0_slv0_grant   (mst0_slv0_grant   ),
	.mst0_slv0_haddr   (mst0_slv0_haddr   ),
	.mst0_slv0_hburst  (mst0_slv0_hburst  ),
	.mst0_slv0_hprot   (mst0_slv0_hprot   ),
	.mst0_slv0_hsize   (mst0_slv0_hsize   ),
	.mst0_slv0_htrans  (mst0_slv0_htrans  ),
	.mst0_slv0_hwrite  (mst0_slv0_hwrite  ),
	.mst0_slv0_req     (mst0_slv0_req     ),
	.mst0_slv0_sel     (mst0_slv0_sel     ),
	.mst0_slv0_size    (mst0_slv0_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm0_slv1_hwdata   (hm0_slv1_hwdata   ),
	.mst0_hs1_hrdata   (mst0_hs1_hrdata   ),
	.mst0_hs1_hready   (mst0_hs1_hready   ),
	.mst0_hs1_hresp    (mst0_hs1_hresp    ),
	.mst0_slv1_ack     (mst0_slv1_ack     ),
	.mst0_slv1_base    (mst0_slv1_base    ),
	.mst0_slv1_grant   (mst0_slv1_grant   ),
	.mst0_slv1_haddr   (mst0_slv1_haddr   ),
	.mst0_slv1_hburst  (mst0_slv1_hburst  ),
	.mst0_slv1_hprot   (mst0_slv1_hprot   ),
	.mst0_slv1_hsize   (mst0_slv1_hsize   ),
	.mst0_slv1_htrans  (mst0_slv1_htrans  ),
	.mst0_slv1_hwrite  (mst0_slv1_hwrite  ),
	.mst0_slv1_req     (mst0_slv1_req     ),
	.mst0_slv1_sel     (mst0_slv1_sel     ),
	.mst0_slv1_size    (mst0_slv1_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm0_slv2_hwdata   (hm0_slv2_hwdata   ),
	.mst0_hs2_hrdata   (mst0_hs2_hrdata   ),
	.mst0_hs2_hready   (mst0_hs2_hready   ),
	.mst0_hs2_hresp    (mst0_hs2_hresp    ),
	.mst0_slv2_ack     (mst0_slv2_ack     ),
	.mst0_slv2_base    (mst0_slv2_base    ),
	.mst0_slv2_grant   (mst0_slv2_grant   ),
	.mst0_slv2_haddr   (mst0_slv2_haddr   ),
	.mst0_slv2_hburst  (mst0_slv2_hburst  ),
	.mst0_slv2_hprot   (mst0_slv2_hprot   ),
	.mst0_slv2_hsize   (mst0_slv2_hsize   ),
	.mst0_slv2_htrans  (mst0_slv2_htrans  ),
	.mst0_slv2_hwrite  (mst0_slv2_hwrite  ),
	.mst0_slv2_req     (mst0_slv2_req     ),
	.mst0_slv2_sel     (mst0_slv2_sel     ),
	.mst0_slv2_size    (mst0_slv2_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm0_slv3_hwdata   (hm0_slv3_hwdata   ),
	.mst0_hs3_hrdata   (mst0_hs3_hrdata   ),
	.mst0_hs3_hready   (mst0_hs3_hready   ),
	.mst0_hs3_hresp    (mst0_hs3_hresp    ),
	.mst0_slv3_ack     (mst0_slv3_ack     ),
	.mst0_slv3_base    (mst0_slv3_base    ),
	.mst0_slv3_grant   (mst0_slv3_grant   ),
	.mst0_slv3_haddr   (mst0_slv3_haddr   ),
	.mst0_slv3_hburst  (mst0_slv3_hburst  ),
	.mst0_slv3_hprot   (mst0_slv3_hprot   ),
	.mst0_slv3_hsize   (mst0_slv3_hsize   ),
	.mst0_slv3_htrans  (mst0_slv3_htrans  ),
	.mst0_slv3_hwrite  (mst0_slv3_hwrite  ),
	.mst0_slv3_req     (mst0_slv3_req     ),
	.mst0_slv3_sel     (mst0_slv3_sel     ),
	.mst0_slv3_size    (mst0_slv3_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm0_slv4_hwdata   (hm0_slv4_hwdata   ),
	.mst0_hs4_hrdata   (mst0_hs4_hrdata   ),
	.mst0_hs4_hready   (mst0_hs4_hready   ),
	.mst0_hs4_hresp    (mst0_hs4_hresp    ),
	.mst0_slv4_ack     (mst0_slv4_ack     ),
	.mst0_slv4_base    (mst0_slv4_base    ),
	.mst0_slv4_grant   (mst0_slv4_grant   ),
	.mst0_slv4_haddr   (mst0_slv4_haddr   ),
	.mst0_slv4_hburst  (mst0_slv4_hburst  ),
	.mst0_slv4_hprot   (mst0_slv4_hprot   ),
	.mst0_slv4_hsize   (mst0_slv4_hsize   ),
	.mst0_slv4_htrans  (mst0_slv4_htrans  ),
	.mst0_slv4_hwrite  (mst0_slv4_hwrite  ),
	.mst0_slv4_req     (mst0_slv4_req     ),
	.mst0_slv4_sel     (mst0_slv4_sel     ),
	.mst0_slv4_size    (mst0_slv4_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm0_slv5_hwdata   (hm0_slv5_hwdata   ),
	.mst0_hs5_hrdata   (mst0_hs5_hrdata   ),
	.mst0_hs5_hready   (mst0_hs5_hready   ),
	.mst0_hs5_hresp    (mst0_hs5_hresp    ),
	.mst0_slv5_ack     (mst0_slv5_ack     ),
	.mst0_slv5_base    (mst0_slv5_base    ),
	.mst0_slv5_grant   (mst0_slv5_grant   ),
	.mst0_slv5_haddr   (mst0_slv5_haddr   ),
	.mst0_slv5_hburst  (mst0_slv5_hburst  ),
	.mst0_slv5_hprot   (mst0_slv5_hprot   ),
	.mst0_slv5_hsize   (mst0_slv5_hsize   ),
	.mst0_slv5_htrans  (mst0_slv5_htrans  ),
	.mst0_slv5_hwrite  (mst0_slv5_hwrite  ),
	.mst0_slv5_req     (mst0_slv5_req     ),
	.mst0_slv5_sel     (mst0_slv5_sel     ),
	.mst0_slv5_size    (mst0_slv5_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm0_slv6_hwdata   (hm0_slv6_hwdata   ),
	.mst0_hs6_hrdata   (mst0_hs6_hrdata   ),
	.mst0_hs6_hready   (mst0_hs6_hready   ),
	.mst0_hs6_hresp    (mst0_hs6_hresp    ),
	.mst0_slv6_ack     (mst0_slv6_ack     ),
	.mst0_slv6_base    (mst0_slv6_base    ),
	.mst0_slv6_grant   (mst0_slv6_grant   ),
	.mst0_slv6_haddr   (mst0_slv6_haddr   ),
	.mst0_slv6_hburst  (mst0_slv6_hburst  ),
	.mst0_slv6_hprot   (mst0_slv6_hprot   ),
	.mst0_slv6_hsize   (mst0_slv6_hsize   ),
	.mst0_slv6_htrans  (mst0_slv6_htrans  ),
	.mst0_slv6_hwrite  (mst0_slv6_hwrite  ),
	.mst0_slv6_req     (mst0_slv6_req     ),
	.mst0_slv6_sel     (mst0_slv6_sel     ),
	.mst0_slv6_size    (mst0_slv6_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm0_slv7_hwdata   (hm0_slv7_hwdata   ),
	.mst0_hs7_hrdata   (mst0_hs7_hrdata   ),
	.mst0_hs7_hready   (mst0_hs7_hready   ),
	.mst0_hs7_hresp    (mst0_hs7_hresp    ),
	.mst0_slv7_ack     (mst0_slv7_ack     ),
	.mst0_slv7_base    (mst0_slv7_base    ),
	.mst0_slv7_grant   (mst0_slv7_grant   ),
	.mst0_slv7_haddr   (mst0_slv7_haddr   ),
	.mst0_slv7_hburst  (mst0_slv7_hburst  ),
	.mst0_slv7_hprot   (mst0_slv7_hprot   ),
	.mst0_slv7_hsize   (mst0_slv7_hsize   ),
	.mst0_slv7_htrans  (mst0_slv7_htrans  ),
	.mst0_slv7_hwrite  (mst0_slv7_hwrite  ),
	.mst0_slv7_req     (mst0_slv7_req     ),
	.mst0_slv7_sel     (mst0_slv7_sel     ),
	.mst0_slv7_size    (mst0_slv7_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm0_slv8_hwdata   (hm0_slv8_hwdata   ),
	.mst0_hs8_hrdata   (mst0_hs8_hrdata   ),
	.mst0_hs8_hready   (mst0_hs8_hready   ),
	.mst0_hs8_hresp    (mst0_hs8_hresp    ),
	.mst0_slv8_ack     (mst0_slv8_ack     ),
	.mst0_slv8_base    (mst0_slv8_base    ),
	.mst0_slv8_grant   (mst0_slv8_grant   ),
	.mst0_slv8_haddr   (mst0_slv8_haddr   ),
	.mst0_slv8_hburst  (mst0_slv8_hburst  ),
	.mst0_slv8_hprot   (mst0_slv8_hprot   ),
	.mst0_slv8_hsize   (mst0_slv8_hsize   ),
	.mst0_slv8_htrans  (mst0_slv8_htrans  ),
	.mst0_slv8_hwrite  (mst0_slv8_hwrite  ),
	.mst0_slv8_req     (mst0_slv8_req     ),
	.mst0_slv8_sel     (mst0_slv8_sel     ),
	.mst0_slv8_size    (mst0_slv8_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm0_slv9_hwdata   (hm0_slv9_hwdata   ),
	.mst0_hs9_hrdata   (mst0_hs9_hrdata   ),
	.mst0_hs9_hready   (mst0_hs9_hready   ),
	.mst0_hs9_hresp    (mst0_hs9_hresp    ),
	.mst0_slv9_ack     (mst0_slv9_ack     ),
	.mst0_slv9_base    (mst0_slv9_base    ),
	.mst0_slv9_grant   (mst0_slv9_grant   ),
	.mst0_slv9_haddr   (mst0_slv9_haddr   ),
	.mst0_slv9_hburst  (mst0_slv9_hburst  ),
	.mst0_slv9_hprot   (mst0_slv9_hprot   ),
	.mst0_slv9_hsize   (mst0_slv9_hsize   ),
	.mst0_slv9_htrans  (mst0_slv9_htrans  ),
	.mst0_slv9_hwrite  (mst0_slv9_hwrite  ),
	.mst0_slv9_req     (mst0_slv9_req     ),
	.mst0_slv9_sel     (mst0_slv9_sel     ),
	.mst0_slv9_size    (mst0_slv9_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm0_slv10_hwdata  (hm0_slv10_hwdata  ),
	.mst0_hs10_hrdata  (mst0_hs10_hrdata  ),
	.mst0_hs10_hready  (mst0_hs10_hready  ),
	.mst0_hs10_hresp   (mst0_hs10_hresp   ),
	.mst0_slv10_ack    (mst0_slv10_ack    ),
	.mst0_slv10_base   (mst0_slv10_base   ),
	.mst0_slv10_grant  (mst0_slv10_grant  ),
	.mst0_slv10_haddr  (mst0_slv10_haddr  ),
	.mst0_slv10_hburst (mst0_slv10_hburst ),
	.mst0_slv10_hprot  (mst0_slv10_hprot  ),
	.mst0_slv10_hsize  (mst0_slv10_hsize  ),
	.mst0_slv10_htrans (mst0_slv10_htrans ),
	.mst0_slv10_hwrite (mst0_slv10_hwrite ),
	.mst0_slv10_req    (mst0_slv10_req    ),
	.mst0_slv10_sel    (mst0_slv10_sel    ),
	.mst0_slv10_size   (mst0_slv10_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm0_slv11_hwdata  (hm0_slv11_hwdata  ),
	.mst0_hs11_hrdata  (mst0_hs11_hrdata  ),
	.mst0_hs11_hready  (mst0_hs11_hready  ),
	.mst0_hs11_hresp   (mst0_hs11_hresp   ),
	.mst0_slv11_ack    (mst0_slv11_ack    ),
	.mst0_slv11_base   (mst0_slv11_base   ),
	.mst0_slv11_grant  (mst0_slv11_grant  ),
	.mst0_slv11_haddr  (mst0_slv11_haddr  ),
	.mst0_slv11_hburst (mst0_slv11_hburst ),
	.mst0_slv11_hprot  (mst0_slv11_hprot  ),
	.mst0_slv11_hsize  (mst0_slv11_hsize  ),
	.mst0_slv11_htrans (mst0_slv11_htrans ),
	.mst0_slv11_hwrite (mst0_slv11_hwrite ),
	.mst0_slv11_req    (mst0_slv11_req    ),
	.mst0_slv11_sel    (mst0_slv11_sel    ),
	.mst0_slv11_size   (mst0_slv11_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm0_slv12_hwdata  (hm0_slv12_hwdata  ),
	.mst0_hs12_hrdata  (mst0_hs12_hrdata  ),
	.mst0_hs12_hready  (mst0_hs12_hready  ),
	.mst0_hs12_hresp   (mst0_hs12_hresp   ),
	.mst0_slv12_ack    (mst0_slv12_ack    ),
	.mst0_slv12_base   (mst0_slv12_base   ),
	.mst0_slv12_grant  (mst0_slv12_grant  ),
	.mst0_slv12_haddr  (mst0_slv12_haddr  ),
	.mst0_slv12_hburst (mst0_slv12_hburst ),
	.mst0_slv12_hprot  (mst0_slv12_hprot  ),
	.mst0_slv12_hsize  (mst0_slv12_hsize  ),
	.mst0_slv12_htrans (mst0_slv12_htrans ),
	.mst0_slv12_hwrite (mst0_slv12_hwrite ),
	.mst0_slv12_req    (mst0_slv12_req    ),
	.mst0_slv12_sel    (mst0_slv12_sel    ),
	.mst0_slv12_size   (mst0_slv12_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm0_slv13_hwdata  (hm0_slv13_hwdata  ),
	.mst0_hs13_hrdata  (mst0_hs13_hrdata  ),
	.mst0_hs13_hready  (mst0_hs13_hready  ),
	.mst0_hs13_hresp   (mst0_hs13_hresp   ),
	.mst0_slv13_ack    (mst0_slv13_ack    ),
	.mst0_slv13_base   (mst0_slv13_base   ),
	.mst0_slv13_grant  (mst0_slv13_grant  ),
	.mst0_slv13_haddr  (mst0_slv13_haddr  ),
	.mst0_slv13_hburst (mst0_slv13_hburst ),
	.mst0_slv13_hprot  (mst0_slv13_hprot  ),
	.mst0_slv13_hsize  (mst0_slv13_hsize  ),
	.mst0_slv13_htrans (mst0_slv13_htrans ),
	.mst0_slv13_hwrite (mst0_slv13_hwrite ),
	.mst0_slv13_req    (mst0_slv13_req    ),
	.mst0_slv13_sel    (mst0_slv13_sel    ),
	.mst0_slv13_size   (mst0_slv13_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm0_slv14_hwdata  (hm0_slv14_hwdata  ),
	.mst0_hs14_hrdata  (mst0_hs14_hrdata  ),
	.mst0_hs14_hready  (mst0_hs14_hready  ),
	.mst0_hs14_hresp   (mst0_hs14_hresp   ),
	.mst0_slv14_ack    (mst0_slv14_ack    ),
	.mst0_slv14_base   (mst0_slv14_base   ),
	.mst0_slv14_grant  (mst0_slv14_grant  ),
	.mst0_slv14_haddr  (mst0_slv14_haddr  ),
	.mst0_slv14_hburst (mst0_slv14_hburst ),
	.mst0_slv14_hprot  (mst0_slv14_hprot  ),
	.mst0_slv14_hsize  (mst0_slv14_hsize  ),
	.mst0_slv14_htrans (mst0_slv14_htrans ),
	.mst0_slv14_hwrite (mst0_slv14_hwrite ),
	.mst0_slv14_req    (mst0_slv14_req    ),
	.mst0_slv14_sel    (mst0_slv14_sel    ),
	.mst0_slv14_size   (mst0_slv14_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm0_slv15_hwdata  (hm0_slv15_hwdata  ),
	.mst0_hs15_hrdata  (mst0_hs15_hrdata  ),
	.mst0_hs15_hready  (mst0_hs15_hready  ),
	.mst0_hs15_hresp   (mst0_hs15_hresp   ),
	.mst0_slv15_ack    (mst0_slv15_ack    ),
	.mst0_slv15_base   (mst0_slv15_base   ),
	.mst0_slv15_grant  (mst0_slv15_grant  ),
	.mst0_slv15_haddr  (mst0_slv15_haddr  ),
	.mst0_slv15_hburst (mst0_slv15_hburst ),
	.mst0_slv15_hprot  (mst0_slv15_hprot  ),
	.mst0_slv15_hsize  (mst0_slv15_hsize  ),
	.mst0_slv15_htrans (mst0_slv15_htrans ),
	.mst0_slv15_hwrite (mst0_slv15_hwrite ),
	.mst0_slv15_req    (mst0_slv15_req    ),
	.mst0_slv15_sel    (mst0_slv15_sel    ),
	.mst0_slv15_size   (mst0_slv15_size   ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST1
   `ifdef ATCBMC200_AHB_SLV0
	.hm1_slv0_hwdata   (hm1_slv0_hwdata   ),
	.mst1_hs0_hrdata   (mst1_hs0_hrdata   ),
	.mst1_hs0_hready   (mst1_hs0_hready   ),
	.mst1_hs0_hresp    (mst1_hs0_hresp    ),
	.mst1_slv0_ack     (mst1_slv0_ack     ),
	.mst1_slv0_base    (mst1_slv0_base    ),
	.mst1_slv0_grant   (mst1_slv0_grant   ),
	.mst1_slv0_haddr   (mst1_slv0_haddr   ),
	.mst1_slv0_hburst  (mst1_slv0_hburst  ),
	.mst1_slv0_hprot   (mst1_slv0_hprot   ),
	.mst1_slv0_hsize   (mst1_slv0_hsize   ),
	.mst1_slv0_htrans  (mst1_slv0_htrans  ),
	.mst1_slv0_hwrite  (mst1_slv0_hwrite  ),
	.mst1_slv0_req     (mst1_slv0_req     ),
	.mst1_slv0_sel     (mst1_slv0_sel     ),
	.mst1_slv0_size    (mst1_slv0_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm1_slv1_hwdata   (hm1_slv1_hwdata   ),
	.mst1_hs1_hrdata   (mst1_hs1_hrdata   ),
	.mst1_hs1_hready   (mst1_hs1_hready   ),
	.mst1_hs1_hresp    (mst1_hs1_hresp    ),
	.mst1_slv1_ack     (mst1_slv1_ack     ),
	.mst1_slv1_base    (mst1_slv1_base    ),
	.mst1_slv1_grant   (mst1_slv1_grant   ),
	.mst1_slv1_haddr   (mst1_slv1_haddr   ),
	.mst1_slv1_hburst  (mst1_slv1_hburst  ),
	.mst1_slv1_hprot   (mst1_slv1_hprot   ),
	.mst1_slv1_hsize   (mst1_slv1_hsize   ),
	.mst1_slv1_htrans  (mst1_slv1_htrans  ),
	.mst1_slv1_hwrite  (mst1_slv1_hwrite  ),
	.mst1_slv1_req     (mst1_slv1_req     ),
	.mst1_slv1_sel     (mst1_slv1_sel     ),
	.mst1_slv1_size    (mst1_slv1_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm1_slv2_hwdata   (hm1_slv2_hwdata   ),
	.mst1_hs2_hrdata   (mst1_hs2_hrdata   ),
	.mst1_hs2_hready   (mst1_hs2_hready   ),
	.mst1_hs2_hresp    (mst1_hs2_hresp    ),
	.mst1_slv2_ack     (mst1_slv2_ack     ),
	.mst1_slv2_base    (mst1_slv2_base    ),
	.mst1_slv2_grant   (mst1_slv2_grant   ),
	.mst1_slv2_haddr   (mst1_slv2_haddr   ),
	.mst1_slv2_hburst  (mst1_slv2_hburst  ),
	.mst1_slv2_hprot   (mst1_slv2_hprot   ),
	.mst1_slv2_hsize   (mst1_slv2_hsize   ),
	.mst1_slv2_htrans  (mst1_slv2_htrans  ),
	.mst1_slv2_hwrite  (mst1_slv2_hwrite  ),
	.mst1_slv2_req     (mst1_slv2_req     ),
	.mst1_slv2_sel     (mst1_slv2_sel     ),
	.mst1_slv2_size    (mst1_slv2_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm1_slv3_hwdata   (hm1_slv3_hwdata   ),
	.mst1_hs3_hrdata   (mst1_hs3_hrdata   ),
	.mst1_hs3_hready   (mst1_hs3_hready   ),
	.mst1_hs3_hresp    (mst1_hs3_hresp    ),
	.mst1_slv3_ack     (mst1_slv3_ack     ),
	.mst1_slv3_base    (mst1_slv3_base    ),
	.mst1_slv3_grant   (mst1_slv3_grant   ),
	.mst1_slv3_haddr   (mst1_slv3_haddr   ),
	.mst1_slv3_hburst  (mst1_slv3_hburst  ),
	.mst1_slv3_hprot   (mst1_slv3_hprot   ),
	.mst1_slv3_hsize   (mst1_slv3_hsize   ),
	.mst1_slv3_htrans  (mst1_slv3_htrans  ),
	.mst1_slv3_hwrite  (mst1_slv3_hwrite  ),
	.mst1_slv3_req     (mst1_slv3_req     ),
	.mst1_slv3_sel     (mst1_slv3_sel     ),
	.mst1_slv3_size    (mst1_slv3_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm1_slv4_hwdata   (hm1_slv4_hwdata   ),
	.mst1_hs4_hrdata   (mst1_hs4_hrdata   ),
	.mst1_hs4_hready   (mst1_hs4_hready   ),
	.mst1_hs4_hresp    (mst1_hs4_hresp    ),
	.mst1_slv4_ack     (mst1_slv4_ack     ),
	.mst1_slv4_base    (mst1_slv4_base    ),
	.mst1_slv4_grant   (mst1_slv4_grant   ),
	.mst1_slv4_haddr   (mst1_slv4_haddr   ),
	.mst1_slv4_hburst  (mst1_slv4_hburst  ),
	.mst1_slv4_hprot   (mst1_slv4_hprot   ),
	.mst1_slv4_hsize   (mst1_slv4_hsize   ),
	.mst1_slv4_htrans  (mst1_slv4_htrans  ),
	.mst1_slv4_hwrite  (mst1_slv4_hwrite  ),
	.mst1_slv4_req     (mst1_slv4_req     ),
	.mst1_slv4_sel     (mst1_slv4_sel     ),
	.mst1_slv4_size    (mst1_slv4_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm1_slv5_hwdata   (hm1_slv5_hwdata   ),
	.mst1_hs5_hrdata   (mst1_hs5_hrdata   ),
	.mst1_hs5_hready   (mst1_hs5_hready   ),
	.mst1_hs5_hresp    (mst1_hs5_hresp    ),
	.mst1_slv5_ack     (mst1_slv5_ack     ),
	.mst1_slv5_base    (mst1_slv5_base    ),
	.mst1_slv5_grant   (mst1_slv5_grant   ),
	.mst1_slv5_haddr   (mst1_slv5_haddr   ),
	.mst1_slv5_hburst  (mst1_slv5_hburst  ),
	.mst1_slv5_hprot   (mst1_slv5_hprot   ),
	.mst1_slv5_hsize   (mst1_slv5_hsize   ),
	.mst1_slv5_htrans  (mst1_slv5_htrans  ),
	.mst1_slv5_hwrite  (mst1_slv5_hwrite  ),
	.mst1_slv5_req     (mst1_slv5_req     ),
	.mst1_slv5_sel     (mst1_slv5_sel     ),
	.mst1_slv5_size    (mst1_slv5_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm1_slv6_hwdata   (hm1_slv6_hwdata   ),
	.mst1_hs6_hrdata   (mst1_hs6_hrdata   ),
	.mst1_hs6_hready   (mst1_hs6_hready   ),
	.mst1_hs6_hresp    (mst1_hs6_hresp    ),
	.mst1_slv6_ack     (mst1_slv6_ack     ),
	.mst1_slv6_base    (mst1_slv6_base    ),
	.mst1_slv6_grant   (mst1_slv6_grant   ),
	.mst1_slv6_haddr   (mst1_slv6_haddr   ),
	.mst1_slv6_hburst  (mst1_slv6_hburst  ),
	.mst1_slv6_hprot   (mst1_slv6_hprot   ),
	.mst1_slv6_hsize   (mst1_slv6_hsize   ),
	.mst1_slv6_htrans  (mst1_slv6_htrans  ),
	.mst1_slv6_hwrite  (mst1_slv6_hwrite  ),
	.mst1_slv6_req     (mst1_slv6_req     ),
	.mst1_slv6_sel     (mst1_slv6_sel     ),
	.mst1_slv6_size    (mst1_slv6_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm1_slv7_hwdata   (hm1_slv7_hwdata   ),
	.mst1_hs7_hrdata   (mst1_hs7_hrdata   ),
	.mst1_hs7_hready   (mst1_hs7_hready   ),
	.mst1_hs7_hresp    (mst1_hs7_hresp    ),
	.mst1_slv7_ack     (mst1_slv7_ack     ),
	.mst1_slv7_base    (mst1_slv7_base    ),
	.mst1_slv7_grant   (mst1_slv7_grant   ),
	.mst1_slv7_haddr   (mst1_slv7_haddr   ),
	.mst1_slv7_hburst  (mst1_slv7_hburst  ),
	.mst1_slv7_hprot   (mst1_slv7_hprot   ),
	.mst1_slv7_hsize   (mst1_slv7_hsize   ),
	.mst1_slv7_htrans  (mst1_slv7_htrans  ),
	.mst1_slv7_hwrite  (mst1_slv7_hwrite  ),
	.mst1_slv7_req     (mst1_slv7_req     ),
	.mst1_slv7_sel     (mst1_slv7_sel     ),
	.mst1_slv7_size    (mst1_slv7_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm1_slv8_hwdata   (hm1_slv8_hwdata   ),
	.mst1_hs8_hrdata   (mst1_hs8_hrdata   ),
	.mst1_hs8_hready   (mst1_hs8_hready   ),
	.mst1_hs8_hresp    (mst1_hs8_hresp    ),
	.mst1_slv8_ack     (mst1_slv8_ack     ),
	.mst1_slv8_base    (mst1_slv8_base    ),
	.mst1_slv8_grant   (mst1_slv8_grant   ),
	.mst1_slv8_haddr   (mst1_slv8_haddr   ),
	.mst1_slv8_hburst  (mst1_slv8_hburst  ),
	.mst1_slv8_hprot   (mst1_slv8_hprot   ),
	.mst1_slv8_hsize   (mst1_slv8_hsize   ),
	.mst1_slv8_htrans  (mst1_slv8_htrans  ),
	.mst1_slv8_hwrite  (mst1_slv8_hwrite  ),
	.mst1_slv8_req     (mst1_slv8_req     ),
	.mst1_slv8_sel     (mst1_slv8_sel     ),
	.mst1_slv8_size    (mst1_slv8_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm1_slv9_hwdata   (hm1_slv9_hwdata   ),
	.mst1_hs9_hrdata   (mst1_hs9_hrdata   ),
	.mst1_hs9_hready   (mst1_hs9_hready   ),
	.mst1_hs9_hresp    (mst1_hs9_hresp    ),
	.mst1_slv9_ack     (mst1_slv9_ack     ),
	.mst1_slv9_base    (mst1_slv9_base    ),
	.mst1_slv9_grant   (mst1_slv9_grant   ),
	.mst1_slv9_haddr   (mst1_slv9_haddr   ),
	.mst1_slv9_hburst  (mst1_slv9_hburst  ),
	.mst1_slv9_hprot   (mst1_slv9_hprot   ),
	.mst1_slv9_hsize   (mst1_slv9_hsize   ),
	.mst1_slv9_htrans  (mst1_slv9_htrans  ),
	.mst1_slv9_hwrite  (mst1_slv9_hwrite  ),
	.mst1_slv9_req     (mst1_slv9_req     ),
	.mst1_slv9_sel     (mst1_slv9_sel     ),
	.mst1_slv9_size    (mst1_slv9_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm1_slv10_hwdata  (hm1_slv10_hwdata  ),
	.mst1_hs10_hrdata  (mst1_hs10_hrdata  ),
	.mst1_hs10_hready  (mst1_hs10_hready  ),
	.mst1_hs10_hresp   (mst1_hs10_hresp   ),
	.mst1_slv10_ack    (mst1_slv10_ack    ),
	.mst1_slv10_base   (mst1_slv10_base   ),
	.mst1_slv10_grant  (mst1_slv10_grant  ),
	.mst1_slv10_haddr  (mst1_slv10_haddr  ),
	.mst1_slv10_hburst (mst1_slv10_hburst ),
	.mst1_slv10_hprot  (mst1_slv10_hprot  ),
	.mst1_slv10_hsize  (mst1_slv10_hsize  ),
	.mst1_slv10_htrans (mst1_slv10_htrans ),
	.mst1_slv10_hwrite (mst1_slv10_hwrite ),
	.mst1_slv10_req    (mst1_slv10_req    ),
	.mst1_slv10_sel    (mst1_slv10_sel    ),
	.mst1_slv10_size   (mst1_slv10_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm1_slv11_hwdata  (hm1_slv11_hwdata  ),
	.mst1_hs11_hrdata  (mst1_hs11_hrdata  ),
	.mst1_hs11_hready  (mst1_hs11_hready  ),
	.mst1_hs11_hresp   (mst1_hs11_hresp   ),
	.mst1_slv11_ack    (mst1_slv11_ack    ),
	.mst1_slv11_base   (mst1_slv11_base   ),
	.mst1_slv11_grant  (mst1_slv11_grant  ),
	.mst1_slv11_haddr  (mst1_slv11_haddr  ),
	.mst1_slv11_hburst (mst1_slv11_hburst ),
	.mst1_slv11_hprot  (mst1_slv11_hprot  ),
	.mst1_slv11_hsize  (mst1_slv11_hsize  ),
	.mst1_slv11_htrans (mst1_slv11_htrans ),
	.mst1_slv11_hwrite (mst1_slv11_hwrite ),
	.mst1_slv11_req    (mst1_slv11_req    ),
	.mst1_slv11_sel    (mst1_slv11_sel    ),
	.mst1_slv11_size   (mst1_slv11_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm1_slv12_hwdata  (hm1_slv12_hwdata  ),
	.mst1_hs12_hrdata  (mst1_hs12_hrdata  ),
	.mst1_hs12_hready  (mst1_hs12_hready  ),
	.mst1_hs12_hresp   (mst1_hs12_hresp   ),
	.mst1_slv12_ack    (mst1_slv12_ack    ),
	.mst1_slv12_base   (mst1_slv12_base   ),
	.mst1_slv12_grant  (mst1_slv12_grant  ),
	.mst1_slv12_haddr  (mst1_slv12_haddr  ),
	.mst1_slv12_hburst (mst1_slv12_hburst ),
	.mst1_slv12_hprot  (mst1_slv12_hprot  ),
	.mst1_slv12_hsize  (mst1_slv12_hsize  ),
	.mst1_slv12_htrans (mst1_slv12_htrans ),
	.mst1_slv12_hwrite (mst1_slv12_hwrite ),
	.mst1_slv12_req    (mst1_slv12_req    ),
	.mst1_slv12_sel    (mst1_slv12_sel    ),
	.mst1_slv12_size   (mst1_slv12_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm1_slv13_hwdata  (hm1_slv13_hwdata  ),
	.mst1_hs13_hrdata  (mst1_hs13_hrdata  ),
	.mst1_hs13_hready  (mst1_hs13_hready  ),
	.mst1_hs13_hresp   (mst1_hs13_hresp   ),
	.mst1_slv13_ack    (mst1_slv13_ack    ),
	.mst1_slv13_base   (mst1_slv13_base   ),
	.mst1_slv13_grant  (mst1_slv13_grant  ),
	.mst1_slv13_haddr  (mst1_slv13_haddr  ),
	.mst1_slv13_hburst (mst1_slv13_hburst ),
	.mst1_slv13_hprot  (mst1_slv13_hprot  ),
	.mst1_slv13_hsize  (mst1_slv13_hsize  ),
	.mst1_slv13_htrans (mst1_slv13_htrans ),
	.mst1_slv13_hwrite (mst1_slv13_hwrite ),
	.mst1_slv13_req    (mst1_slv13_req    ),
	.mst1_slv13_sel    (mst1_slv13_sel    ),
	.mst1_slv13_size   (mst1_slv13_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm1_slv14_hwdata  (hm1_slv14_hwdata  ),
	.mst1_hs14_hrdata  (mst1_hs14_hrdata  ),
	.mst1_hs14_hready  (mst1_hs14_hready  ),
	.mst1_hs14_hresp   (mst1_hs14_hresp   ),
	.mst1_slv14_ack    (mst1_slv14_ack    ),
	.mst1_slv14_base   (mst1_slv14_base   ),
	.mst1_slv14_grant  (mst1_slv14_grant  ),
	.mst1_slv14_haddr  (mst1_slv14_haddr  ),
	.mst1_slv14_hburst (mst1_slv14_hburst ),
	.mst1_slv14_hprot  (mst1_slv14_hprot  ),
	.mst1_slv14_hsize  (mst1_slv14_hsize  ),
	.mst1_slv14_htrans (mst1_slv14_htrans ),
	.mst1_slv14_hwrite (mst1_slv14_hwrite ),
	.mst1_slv14_req    (mst1_slv14_req    ),
	.mst1_slv14_sel    (mst1_slv14_sel    ),
	.mst1_slv14_size   (mst1_slv14_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm1_slv15_hwdata  (hm1_slv15_hwdata  ),
	.mst1_hs15_hrdata  (mst1_hs15_hrdata  ),
	.mst1_hs15_hready  (mst1_hs15_hready  ),
	.mst1_hs15_hresp   (mst1_hs15_hresp   ),
	.mst1_slv15_ack    (mst1_slv15_ack    ),
	.mst1_slv15_base   (mst1_slv15_base   ),
	.mst1_slv15_grant  (mst1_slv15_grant  ),
	.mst1_slv15_haddr  (mst1_slv15_haddr  ),
	.mst1_slv15_hburst (mst1_slv15_hburst ),
	.mst1_slv15_hprot  (mst1_slv15_hprot  ),
	.mst1_slv15_hsize  (mst1_slv15_hsize  ),
	.mst1_slv15_htrans (mst1_slv15_htrans ),
	.mst1_slv15_hwrite (mst1_slv15_hwrite ),
	.mst1_slv15_req    (mst1_slv15_req    ),
	.mst1_slv15_sel    (mst1_slv15_sel    ),
	.mst1_slv15_size   (mst1_slv15_size   ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST2
   `ifdef ATCBMC200_AHB_SLV0
	.hm2_slv0_hwdata   (hm2_slv0_hwdata   ),
	.mst2_hs0_hrdata   (mst2_hs0_hrdata   ),
	.mst2_hs0_hready   (mst2_hs0_hready   ),
	.mst2_hs0_hresp    (mst2_hs0_hresp    ),
	.mst2_slv0_ack     (mst2_slv0_ack     ),
	.mst2_slv0_base    (mst2_slv0_base    ),
	.mst2_slv0_grant   (mst2_slv0_grant   ),
	.mst2_slv0_haddr   (mst2_slv0_haddr   ),
	.mst2_slv0_hburst  (mst2_slv0_hburst  ),
	.mst2_slv0_hprot   (mst2_slv0_hprot   ),
	.mst2_slv0_hsize   (mst2_slv0_hsize   ),
	.mst2_slv0_htrans  (mst2_slv0_htrans  ),
	.mst2_slv0_hwrite  (mst2_slv0_hwrite  ),
	.mst2_slv0_req     (mst2_slv0_req     ),
	.mst2_slv0_sel     (mst2_slv0_sel     ),
	.mst2_slv0_size    (mst2_slv0_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm2_slv1_hwdata   (hm2_slv1_hwdata   ),
	.mst2_hs1_hrdata   (mst2_hs1_hrdata   ),
	.mst2_hs1_hready   (mst2_hs1_hready   ),
	.mst2_hs1_hresp    (mst2_hs1_hresp    ),
	.mst2_slv1_ack     (mst2_slv1_ack     ),
	.mst2_slv1_base    (mst2_slv1_base    ),
	.mst2_slv1_grant   (mst2_slv1_grant   ),
	.mst2_slv1_haddr   (mst2_slv1_haddr   ),
	.mst2_slv1_hburst  (mst2_slv1_hburst  ),
	.mst2_slv1_hprot   (mst2_slv1_hprot   ),
	.mst2_slv1_hsize   (mst2_slv1_hsize   ),
	.mst2_slv1_htrans  (mst2_slv1_htrans  ),
	.mst2_slv1_hwrite  (mst2_slv1_hwrite  ),
	.mst2_slv1_req     (mst2_slv1_req     ),
	.mst2_slv1_sel     (mst2_slv1_sel     ),
	.mst2_slv1_size    (mst2_slv1_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm2_slv2_hwdata   (hm2_slv2_hwdata   ),
	.mst2_hs2_hrdata   (mst2_hs2_hrdata   ),
	.mst2_hs2_hready   (mst2_hs2_hready   ),
	.mst2_hs2_hresp    (mst2_hs2_hresp    ),
	.mst2_slv2_ack     (mst2_slv2_ack     ),
	.mst2_slv2_base    (mst2_slv2_base    ),
	.mst2_slv2_grant   (mst2_slv2_grant   ),
	.mst2_slv2_haddr   (mst2_slv2_haddr   ),
	.mst2_slv2_hburst  (mst2_slv2_hburst  ),
	.mst2_slv2_hprot   (mst2_slv2_hprot   ),
	.mst2_slv2_hsize   (mst2_slv2_hsize   ),
	.mst2_slv2_htrans  (mst2_slv2_htrans  ),
	.mst2_slv2_hwrite  (mst2_slv2_hwrite  ),
	.mst2_slv2_req     (mst2_slv2_req     ),
	.mst2_slv2_sel     (mst2_slv2_sel     ),
	.mst2_slv2_size    (mst2_slv2_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm2_slv3_hwdata   (hm2_slv3_hwdata   ),
	.mst2_hs3_hrdata   (mst2_hs3_hrdata   ),
	.mst2_hs3_hready   (mst2_hs3_hready   ),
	.mst2_hs3_hresp    (mst2_hs3_hresp    ),
	.mst2_slv3_ack     (mst2_slv3_ack     ),
	.mst2_slv3_base    (mst2_slv3_base    ),
	.mst2_slv3_grant   (mst2_slv3_grant   ),
	.mst2_slv3_haddr   (mst2_slv3_haddr   ),
	.mst2_slv3_hburst  (mst2_slv3_hburst  ),
	.mst2_slv3_hprot   (mst2_slv3_hprot   ),
	.mst2_slv3_hsize   (mst2_slv3_hsize   ),
	.mst2_slv3_htrans  (mst2_slv3_htrans  ),
	.mst2_slv3_hwrite  (mst2_slv3_hwrite  ),
	.mst2_slv3_req     (mst2_slv3_req     ),
	.mst2_slv3_sel     (mst2_slv3_sel     ),
	.mst2_slv3_size    (mst2_slv3_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm2_slv4_hwdata   (hm2_slv4_hwdata   ),
	.mst2_hs4_hrdata   (mst2_hs4_hrdata   ),
	.mst2_hs4_hready   (mst2_hs4_hready   ),
	.mst2_hs4_hresp    (mst2_hs4_hresp    ),
	.mst2_slv4_ack     (mst2_slv4_ack     ),
	.mst2_slv4_base    (mst2_slv4_base    ),
	.mst2_slv4_grant   (mst2_slv4_grant   ),
	.mst2_slv4_haddr   (mst2_slv4_haddr   ),
	.mst2_slv4_hburst  (mst2_slv4_hburst  ),
	.mst2_slv4_hprot   (mst2_slv4_hprot   ),
	.mst2_slv4_hsize   (mst2_slv4_hsize   ),
	.mst2_slv4_htrans  (mst2_slv4_htrans  ),
	.mst2_slv4_hwrite  (mst2_slv4_hwrite  ),
	.mst2_slv4_req     (mst2_slv4_req     ),
	.mst2_slv4_sel     (mst2_slv4_sel     ),
	.mst2_slv4_size    (mst2_slv4_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm2_slv5_hwdata   (hm2_slv5_hwdata   ),
	.mst2_hs5_hrdata   (mst2_hs5_hrdata   ),
	.mst2_hs5_hready   (mst2_hs5_hready   ),
	.mst2_hs5_hresp    (mst2_hs5_hresp    ),
	.mst2_slv5_ack     (mst2_slv5_ack     ),
	.mst2_slv5_base    (mst2_slv5_base    ),
	.mst2_slv5_grant   (mst2_slv5_grant   ),
	.mst2_slv5_haddr   (mst2_slv5_haddr   ),
	.mst2_slv5_hburst  (mst2_slv5_hburst  ),
	.mst2_slv5_hprot   (mst2_slv5_hprot   ),
	.mst2_slv5_hsize   (mst2_slv5_hsize   ),
	.mst2_slv5_htrans  (mst2_slv5_htrans  ),
	.mst2_slv5_hwrite  (mst2_slv5_hwrite  ),
	.mst2_slv5_req     (mst2_slv5_req     ),
	.mst2_slv5_sel     (mst2_slv5_sel     ),
	.mst2_slv5_size    (mst2_slv5_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm2_slv6_hwdata   (hm2_slv6_hwdata   ),
	.mst2_hs6_hrdata   (mst2_hs6_hrdata   ),
	.mst2_hs6_hready   (mst2_hs6_hready   ),
	.mst2_hs6_hresp    (mst2_hs6_hresp    ),
	.mst2_slv6_ack     (mst2_slv6_ack     ),
	.mst2_slv6_base    (mst2_slv6_base    ),
	.mst2_slv6_grant   (mst2_slv6_grant   ),
	.mst2_slv6_haddr   (mst2_slv6_haddr   ),
	.mst2_slv6_hburst  (mst2_slv6_hburst  ),
	.mst2_slv6_hprot   (mst2_slv6_hprot   ),
	.mst2_slv6_hsize   (mst2_slv6_hsize   ),
	.mst2_slv6_htrans  (mst2_slv6_htrans  ),
	.mst2_slv6_hwrite  (mst2_slv6_hwrite  ),
	.mst2_slv6_req     (mst2_slv6_req     ),
	.mst2_slv6_sel     (mst2_slv6_sel     ),
	.mst2_slv6_size    (mst2_slv6_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm2_slv7_hwdata   (hm2_slv7_hwdata   ),
	.mst2_hs7_hrdata   (mst2_hs7_hrdata   ),
	.mst2_hs7_hready   (mst2_hs7_hready   ),
	.mst2_hs7_hresp    (mst2_hs7_hresp    ),
	.mst2_slv7_ack     (mst2_slv7_ack     ),
	.mst2_slv7_base    (mst2_slv7_base    ),
	.mst2_slv7_grant   (mst2_slv7_grant   ),
	.mst2_slv7_haddr   (mst2_slv7_haddr   ),
	.mst2_slv7_hburst  (mst2_slv7_hburst  ),
	.mst2_slv7_hprot   (mst2_slv7_hprot   ),
	.mst2_slv7_hsize   (mst2_slv7_hsize   ),
	.mst2_slv7_htrans  (mst2_slv7_htrans  ),
	.mst2_slv7_hwrite  (mst2_slv7_hwrite  ),
	.mst2_slv7_req     (mst2_slv7_req     ),
	.mst2_slv7_sel     (mst2_slv7_sel     ),
	.mst2_slv7_size    (mst2_slv7_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm2_slv8_hwdata   (hm2_slv8_hwdata   ),
	.mst2_hs8_hrdata   (mst2_hs8_hrdata   ),
	.mst2_hs8_hready   (mst2_hs8_hready   ),
	.mst2_hs8_hresp    (mst2_hs8_hresp    ),
	.mst2_slv8_ack     (mst2_slv8_ack     ),
	.mst2_slv8_base    (mst2_slv8_base    ),
	.mst2_slv8_grant   (mst2_slv8_grant   ),
	.mst2_slv8_haddr   (mst2_slv8_haddr   ),
	.mst2_slv8_hburst  (mst2_slv8_hburst  ),
	.mst2_slv8_hprot   (mst2_slv8_hprot   ),
	.mst2_slv8_hsize   (mst2_slv8_hsize   ),
	.mst2_slv8_htrans  (mst2_slv8_htrans  ),
	.mst2_slv8_hwrite  (mst2_slv8_hwrite  ),
	.mst2_slv8_req     (mst2_slv8_req     ),
	.mst2_slv8_sel     (mst2_slv8_sel     ),
	.mst2_slv8_size    (mst2_slv8_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm2_slv9_hwdata   (hm2_slv9_hwdata   ),
	.mst2_hs9_hrdata   (mst2_hs9_hrdata   ),
	.mst2_hs9_hready   (mst2_hs9_hready   ),
	.mst2_hs9_hresp    (mst2_hs9_hresp    ),
	.mst2_slv9_ack     (mst2_slv9_ack     ),
	.mst2_slv9_base    (mst2_slv9_base    ),
	.mst2_slv9_grant   (mst2_slv9_grant   ),
	.mst2_slv9_haddr   (mst2_slv9_haddr   ),
	.mst2_slv9_hburst  (mst2_slv9_hburst  ),
	.mst2_slv9_hprot   (mst2_slv9_hprot   ),
	.mst2_slv9_hsize   (mst2_slv9_hsize   ),
	.mst2_slv9_htrans  (mst2_slv9_htrans  ),
	.mst2_slv9_hwrite  (mst2_slv9_hwrite  ),
	.mst2_slv9_req     (mst2_slv9_req     ),
	.mst2_slv9_sel     (mst2_slv9_sel     ),
	.mst2_slv9_size    (mst2_slv9_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm2_slv10_hwdata  (hm2_slv10_hwdata  ),
	.mst2_hs10_hrdata  (mst2_hs10_hrdata  ),
	.mst2_hs10_hready  (mst2_hs10_hready  ),
	.mst2_hs10_hresp   (mst2_hs10_hresp   ),
	.mst2_slv10_ack    (mst2_slv10_ack    ),
	.mst2_slv10_base   (mst2_slv10_base   ),
	.mst2_slv10_grant  (mst2_slv10_grant  ),
	.mst2_slv10_haddr  (mst2_slv10_haddr  ),
	.mst2_slv10_hburst (mst2_slv10_hburst ),
	.mst2_slv10_hprot  (mst2_slv10_hprot  ),
	.mst2_slv10_hsize  (mst2_slv10_hsize  ),
	.mst2_slv10_htrans (mst2_slv10_htrans ),
	.mst2_slv10_hwrite (mst2_slv10_hwrite ),
	.mst2_slv10_req    (mst2_slv10_req    ),
	.mst2_slv10_sel    (mst2_slv10_sel    ),
	.mst2_slv10_size   (mst2_slv10_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm2_slv11_hwdata  (hm2_slv11_hwdata  ),
	.mst2_hs11_hrdata  (mst2_hs11_hrdata  ),
	.mst2_hs11_hready  (mst2_hs11_hready  ),
	.mst2_hs11_hresp   (mst2_hs11_hresp   ),
	.mst2_slv11_ack    (mst2_slv11_ack    ),
	.mst2_slv11_base   (mst2_slv11_base   ),
	.mst2_slv11_grant  (mst2_slv11_grant  ),
	.mst2_slv11_haddr  (mst2_slv11_haddr  ),
	.mst2_slv11_hburst (mst2_slv11_hburst ),
	.mst2_slv11_hprot  (mst2_slv11_hprot  ),
	.mst2_slv11_hsize  (mst2_slv11_hsize  ),
	.mst2_slv11_htrans (mst2_slv11_htrans ),
	.mst2_slv11_hwrite (mst2_slv11_hwrite ),
	.mst2_slv11_req    (mst2_slv11_req    ),
	.mst2_slv11_sel    (mst2_slv11_sel    ),
	.mst2_slv11_size   (mst2_slv11_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm2_slv12_hwdata  (hm2_slv12_hwdata  ),
	.mst2_hs12_hrdata  (mst2_hs12_hrdata  ),
	.mst2_hs12_hready  (mst2_hs12_hready  ),
	.mst2_hs12_hresp   (mst2_hs12_hresp   ),
	.mst2_slv12_ack    (mst2_slv12_ack    ),
	.mst2_slv12_base   (mst2_slv12_base   ),
	.mst2_slv12_grant  (mst2_slv12_grant  ),
	.mst2_slv12_haddr  (mst2_slv12_haddr  ),
	.mst2_slv12_hburst (mst2_slv12_hburst ),
	.mst2_slv12_hprot  (mst2_slv12_hprot  ),
	.mst2_slv12_hsize  (mst2_slv12_hsize  ),
	.mst2_slv12_htrans (mst2_slv12_htrans ),
	.mst2_slv12_hwrite (mst2_slv12_hwrite ),
	.mst2_slv12_req    (mst2_slv12_req    ),
	.mst2_slv12_sel    (mst2_slv12_sel    ),
	.mst2_slv12_size   (mst2_slv12_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm2_slv13_hwdata  (hm2_slv13_hwdata  ),
	.mst2_hs13_hrdata  (mst2_hs13_hrdata  ),
	.mst2_hs13_hready  (mst2_hs13_hready  ),
	.mst2_hs13_hresp   (mst2_hs13_hresp   ),
	.mst2_slv13_ack    (mst2_slv13_ack    ),
	.mst2_slv13_base   (mst2_slv13_base   ),
	.mst2_slv13_grant  (mst2_slv13_grant  ),
	.mst2_slv13_haddr  (mst2_slv13_haddr  ),
	.mst2_slv13_hburst (mst2_slv13_hburst ),
	.mst2_slv13_hprot  (mst2_slv13_hprot  ),
	.mst2_slv13_hsize  (mst2_slv13_hsize  ),
	.mst2_slv13_htrans (mst2_slv13_htrans ),
	.mst2_slv13_hwrite (mst2_slv13_hwrite ),
	.mst2_slv13_req    (mst2_slv13_req    ),
	.mst2_slv13_sel    (mst2_slv13_sel    ),
	.mst2_slv13_size   (mst2_slv13_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm2_slv14_hwdata  (hm2_slv14_hwdata  ),
	.mst2_hs14_hrdata  (mst2_hs14_hrdata  ),
	.mst2_hs14_hready  (mst2_hs14_hready  ),
	.mst2_hs14_hresp   (mst2_hs14_hresp   ),
	.mst2_slv14_ack    (mst2_slv14_ack    ),
	.mst2_slv14_base   (mst2_slv14_base   ),
	.mst2_slv14_grant  (mst2_slv14_grant  ),
	.mst2_slv14_haddr  (mst2_slv14_haddr  ),
	.mst2_slv14_hburst (mst2_slv14_hburst ),
	.mst2_slv14_hprot  (mst2_slv14_hprot  ),
	.mst2_slv14_hsize  (mst2_slv14_hsize  ),
	.mst2_slv14_htrans (mst2_slv14_htrans ),
	.mst2_slv14_hwrite (mst2_slv14_hwrite ),
	.mst2_slv14_req    (mst2_slv14_req    ),
	.mst2_slv14_sel    (mst2_slv14_sel    ),
	.mst2_slv14_size   (mst2_slv14_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm2_slv15_hwdata  (hm2_slv15_hwdata  ),
	.mst2_hs15_hrdata  (mst2_hs15_hrdata  ),
	.mst2_hs15_hready  (mst2_hs15_hready  ),
	.mst2_hs15_hresp   (mst2_hs15_hresp   ),
	.mst2_slv15_ack    (mst2_slv15_ack    ),
	.mst2_slv15_base   (mst2_slv15_base   ),
	.mst2_slv15_grant  (mst2_slv15_grant  ),
	.mst2_slv15_haddr  (mst2_slv15_haddr  ),
	.mst2_slv15_hburst (mst2_slv15_hburst ),
	.mst2_slv15_hprot  (mst2_slv15_hprot  ),
	.mst2_slv15_hsize  (mst2_slv15_hsize  ),
	.mst2_slv15_htrans (mst2_slv15_htrans ),
	.mst2_slv15_hwrite (mst2_slv15_hwrite ),
	.mst2_slv15_req    (mst2_slv15_req    ),
	.mst2_slv15_sel    (mst2_slv15_sel    ),
	.mst2_slv15_size   (mst2_slv15_size   ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST3
   `ifdef ATCBMC200_AHB_SLV0
	.hm3_slv0_hwdata   (hm3_slv0_hwdata   ),
	.mst3_hs0_hrdata   (mst3_hs0_hrdata   ),
	.mst3_hs0_hready   (mst3_hs0_hready   ),
	.mst3_hs0_hresp    (mst3_hs0_hresp    ),
	.mst3_slv0_ack     (mst3_slv0_ack     ),
	.mst3_slv0_base    (mst3_slv0_base    ),
	.mst3_slv0_grant   (mst3_slv0_grant   ),
	.mst3_slv0_haddr   (mst3_slv0_haddr   ),
	.mst3_slv0_hburst  (mst3_slv0_hburst  ),
	.mst3_slv0_hprot   (mst3_slv0_hprot   ),
	.mst3_slv0_hsize   (mst3_slv0_hsize   ),
	.mst3_slv0_htrans  (mst3_slv0_htrans  ),
	.mst3_slv0_hwrite  (mst3_slv0_hwrite  ),
	.mst3_slv0_req     (mst3_slv0_req     ),
	.mst3_slv0_sel     (mst3_slv0_sel     ),
	.mst3_slv0_size    (mst3_slv0_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm3_slv1_hwdata   (hm3_slv1_hwdata   ),
	.mst3_hs1_hrdata   (mst3_hs1_hrdata   ),
	.mst3_hs1_hready   (mst3_hs1_hready   ),
	.mst3_hs1_hresp    (mst3_hs1_hresp    ),
	.mst3_slv1_ack     (mst3_slv1_ack     ),
	.mst3_slv1_base    (mst3_slv1_base    ),
	.mst3_slv1_grant   (mst3_slv1_grant   ),
	.mst3_slv1_haddr   (mst3_slv1_haddr   ),
	.mst3_slv1_hburst  (mst3_slv1_hburst  ),
	.mst3_slv1_hprot   (mst3_slv1_hprot   ),
	.mst3_slv1_hsize   (mst3_slv1_hsize   ),
	.mst3_slv1_htrans  (mst3_slv1_htrans  ),
	.mst3_slv1_hwrite  (mst3_slv1_hwrite  ),
	.mst3_slv1_req     (mst3_slv1_req     ),
	.mst3_slv1_sel     (mst3_slv1_sel     ),
	.mst3_slv1_size    (mst3_slv1_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm3_slv2_hwdata   (hm3_slv2_hwdata   ),
	.mst3_hs2_hrdata   (mst3_hs2_hrdata   ),
	.mst3_hs2_hready   (mst3_hs2_hready   ),
	.mst3_hs2_hresp    (mst3_hs2_hresp    ),
	.mst3_slv2_ack     (mst3_slv2_ack     ),
	.mst3_slv2_base    (mst3_slv2_base    ),
	.mst3_slv2_grant   (mst3_slv2_grant   ),
	.mst3_slv2_haddr   (mst3_slv2_haddr   ),
	.mst3_slv2_hburst  (mst3_slv2_hburst  ),
	.mst3_slv2_hprot   (mst3_slv2_hprot   ),
	.mst3_slv2_hsize   (mst3_slv2_hsize   ),
	.mst3_slv2_htrans  (mst3_slv2_htrans  ),
	.mst3_slv2_hwrite  (mst3_slv2_hwrite  ),
	.mst3_slv2_req     (mst3_slv2_req     ),
	.mst3_slv2_sel     (mst3_slv2_sel     ),
	.mst3_slv2_size    (mst3_slv2_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm3_slv3_hwdata   (hm3_slv3_hwdata   ),
	.mst3_hs3_hrdata   (mst3_hs3_hrdata   ),
	.mst3_hs3_hready   (mst3_hs3_hready   ),
	.mst3_hs3_hresp    (mst3_hs3_hresp    ),
	.mst3_slv3_ack     (mst3_slv3_ack     ),
	.mst3_slv3_base    (mst3_slv3_base    ),
	.mst3_slv3_grant   (mst3_slv3_grant   ),
	.mst3_slv3_haddr   (mst3_slv3_haddr   ),
	.mst3_slv3_hburst  (mst3_slv3_hburst  ),
	.mst3_slv3_hprot   (mst3_slv3_hprot   ),
	.mst3_slv3_hsize   (mst3_slv3_hsize   ),
	.mst3_slv3_htrans  (mst3_slv3_htrans  ),
	.mst3_slv3_hwrite  (mst3_slv3_hwrite  ),
	.mst3_slv3_req     (mst3_slv3_req     ),
	.mst3_slv3_sel     (mst3_slv3_sel     ),
	.mst3_slv3_size    (mst3_slv3_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm3_slv4_hwdata   (hm3_slv4_hwdata   ),
	.mst3_hs4_hrdata   (mst3_hs4_hrdata   ),
	.mst3_hs4_hready   (mst3_hs4_hready   ),
	.mst3_hs4_hresp    (mst3_hs4_hresp    ),
	.mst3_slv4_ack     (mst3_slv4_ack     ),
	.mst3_slv4_base    (mst3_slv4_base    ),
	.mst3_slv4_grant   (mst3_slv4_grant   ),
	.mst3_slv4_haddr   (mst3_slv4_haddr   ),
	.mst3_slv4_hburst  (mst3_slv4_hburst  ),
	.mst3_slv4_hprot   (mst3_slv4_hprot   ),
	.mst3_slv4_hsize   (mst3_slv4_hsize   ),
	.mst3_slv4_htrans  (mst3_slv4_htrans  ),
	.mst3_slv4_hwrite  (mst3_slv4_hwrite  ),
	.mst3_slv4_req     (mst3_slv4_req     ),
	.mst3_slv4_sel     (mst3_slv4_sel     ),
	.mst3_slv4_size    (mst3_slv4_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm3_slv5_hwdata   (hm3_slv5_hwdata   ),
	.mst3_hs5_hrdata   (mst3_hs5_hrdata   ),
	.mst3_hs5_hready   (mst3_hs5_hready   ),
	.mst3_hs5_hresp    (mst3_hs5_hresp    ),
	.mst3_slv5_ack     (mst3_slv5_ack     ),
	.mst3_slv5_base    (mst3_slv5_base    ),
	.mst3_slv5_grant   (mst3_slv5_grant   ),
	.mst3_slv5_haddr   (mst3_slv5_haddr   ),
	.mst3_slv5_hburst  (mst3_slv5_hburst  ),
	.mst3_slv5_hprot   (mst3_slv5_hprot   ),
	.mst3_slv5_hsize   (mst3_slv5_hsize   ),
	.mst3_slv5_htrans  (mst3_slv5_htrans  ),
	.mst3_slv5_hwrite  (mst3_slv5_hwrite  ),
	.mst3_slv5_req     (mst3_slv5_req     ),
	.mst3_slv5_sel     (mst3_slv5_sel     ),
	.mst3_slv5_size    (mst3_slv5_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm3_slv6_hwdata   (hm3_slv6_hwdata   ),
	.mst3_hs6_hrdata   (mst3_hs6_hrdata   ),
	.mst3_hs6_hready   (mst3_hs6_hready   ),
	.mst3_hs6_hresp    (mst3_hs6_hresp    ),
	.mst3_slv6_ack     (mst3_slv6_ack     ),
	.mst3_slv6_base    (mst3_slv6_base    ),
	.mst3_slv6_grant   (mst3_slv6_grant   ),
	.mst3_slv6_haddr   (mst3_slv6_haddr   ),
	.mst3_slv6_hburst  (mst3_slv6_hburst  ),
	.mst3_slv6_hprot   (mst3_slv6_hprot   ),
	.mst3_slv6_hsize   (mst3_slv6_hsize   ),
	.mst3_slv6_htrans  (mst3_slv6_htrans  ),
	.mst3_slv6_hwrite  (mst3_slv6_hwrite  ),
	.mst3_slv6_req     (mst3_slv6_req     ),
	.mst3_slv6_sel     (mst3_slv6_sel     ),
	.mst3_slv6_size    (mst3_slv6_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm3_slv7_hwdata   (hm3_slv7_hwdata   ),
	.mst3_hs7_hrdata   (mst3_hs7_hrdata   ),
	.mst3_hs7_hready   (mst3_hs7_hready   ),
	.mst3_hs7_hresp    (mst3_hs7_hresp    ),
	.mst3_slv7_ack     (mst3_slv7_ack     ),
	.mst3_slv7_base    (mst3_slv7_base    ),
	.mst3_slv7_grant   (mst3_slv7_grant   ),
	.mst3_slv7_haddr   (mst3_slv7_haddr   ),
	.mst3_slv7_hburst  (mst3_slv7_hburst  ),
	.mst3_slv7_hprot   (mst3_slv7_hprot   ),
	.mst3_slv7_hsize   (mst3_slv7_hsize   ),
	.mst3_slv7_htrans  (mst3_slv7_htrans  ),
	.mst3_slv7_hwrite  (mst3_slv7_hwrite  ),
	.mst3_slv7_req     (mst3_slv7_req     ),
	.mst3_slv7_sel     (mst3_slv7_sel     ),
	.mst3_slv7_size    (mst3_slv7_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm3_slv8_hwdata   (hm3_slv8_hwdata   ),
	.mst3_hs8_hrdata   (mst3_hs8_hrdata   ),
	.mst3_hs8_hready   (mst3_hs8_hready   ),
	.mst3_hs8_hresp    (mst3_hs8_hresp    ),
	.mst3_slv8_ack     (mst3_slv8_ack     ),
	.mst3_slv8_base    (mst3_slv8_base    ),
	.mst3_slv8_grant   (mst3_slv8_grant   ),
	.mst3_slv8_haddr   (mst3_slv8_haddr   ),
	.mst3_slv8_hburst  (mst3_slv8_hburst  ),
	.mst3_slv8_hprot   (mst3_slv8_hprot   ),
	.mst3_slv8_hsize   (mst3_slv8_hsize   ),
	.mst3_slv8_htrans  (mst3_slv8_htrans  ),
	.mst3_slv8_hwrite  (mst3_slv8_hwrite  ),
	.mst3_slv8_req     (mst3_slv8_req     ),
	.mst3_slv8_sel     (mst3_slv8_sel     ),
	.mst3_slv8_size    (mst3_slv8_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm3_slv9_hwdata   (hm3_slv9_hwdata   ),
	.mst3_hs9_hrdata   (mst3_hs9_hrdata   ),
	.mst3_hs9_hready   (mst3_hs9_hready   ),
	.mst3_hs9_hresp    (mst3_hs9_hresp    ),
	.mst3_slv9_ack     (mst3_slv9_ack     ),
	.mst3_slv9_base    (mst3_slv9_base    ),
	.mst3_slv9_grant   (mst3_slv9_grant   ),
	.mst3_slv9_haddr   (mst3_slv9_haddr   ),
	.mst3_slv9_hburst  (mst3_slv9_hburst  ),
	.mst3_slv9_hprot   (mst3_slv9_hprot   ),
	.mst3_slv9_hsize   (mst3_slv9_hsize   ),
	.mst3_slv9_htrans  (mst3_slv9_htrans  ),
	.mst3_slv9_hwrite  (mst3_slv9_hwrite  ),
	.mst3_slv9_req     (mst3_slv9_req     ),
	.mst3_slv9_sel     (mst3_slv9_sel     ),
	.mst3_slv9_size    (mst3_slv9_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm3_slv10_hwdata  (hm3_slv10_hwdata  ),
	.mst3_hs10_hrdata  (mst3_hs10_hrdata  ),
	.mst3_hs10_hready  (mst3_hs10_hready  ),
	.mst3_hs10_hresp   (mst3_hs10_hresp   ),
	.mst3_slv10_ack    (mst3_slv10_ack    ),
	.mst3_slv10_base   (mst3_slv10_base   ),
	.mst3_slv10_grant  (mst3_slv10_grant  ),
	.mst3_slv10_haddr  (mst3_slv10_haddr  ),
	.mst3_slv10_hburst (mst3_slv10_hburst ),
	.mst3_slv10_hprot  (mst3_slv10_hprot  ),
	.mst3_slv10_hsize  (mst3_slv10_hsize  ),
	.mst3_slv10_htrans (mst3_slv10_htrans ),
	.mst3_slv10_hwrite (mst3_slv10_hwrite ),
	.mst3_slv10_req    (mst3_slv10_req    ),
	.mst3_slv10_sel    (mst3_slv10_sel    ),
	.mst3_slv10_size   (mst3_slv10_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm3_slv11_hwdata  (hm3_slv11_hwdata  ),
	.mst3_hs11_hrdata  (mst3_hs11_hrdata  ),
	.mst3_hs11_hready  (mst3_hs11_hready  ),
	.mst3_hs11_hresp   (mst3_hs11_hresp   ),
	.mst3_slv11_ack    (mst3_slv11_ack    ),
	.mst3_slv11_base   (mst3_slv11_base   ),
	.mst3_slv11_grant  (mst3_slv11_grant  ),
	.mst3_slv11_haddr  (mst3_slv11_haddr  ),
	.mst3_slv11_hburst (mst3_slv11_hburst ),
	.mst3_slv11_hprot  (mst3_slv11_hprot  ),
	.mst3_slv11_hsize  (mst3_slv11_hsize  ),
	.mst3_slv11_htrans (mst3_slv11_htrans ),
	.mst3_slv11_hwrite (mst3_slv11_hwrite ),
	.mst3_slv11_req    (mst3_slv11_req    ),
	.mst3_slv11_sel    (mst3_slv11_sel    ),
	.mst3_slv11_size   (mst3_slv11_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm3_slv12_hwdata  (hm3_slv12_hwdata  ),
	.mst3_hs12_hrdata  (mst3_hs12_hrdata  ),
	.mst3_hs12_hready  (mst3_hs12_hready  ),
	.mst3_hs12_hresp   (mst3_hs12_hresp   ),
	.mst3_slv12_ack    (mst3_slv12_ack    ),
	.mst3_slv12_base   (mst3_slv12_base   ),
	.mst3_slv12_grant  (mst3_slv12_grant  ),
	.mst3_slv12_haddr  (mst3_slv12_haddr  ),
	.mst3_slv12_hburst (mst3_slv12_hburst ),
	.mst3_slv12_hprot  (mst3_slv12_hprot  ),
	.mst3_slv12_hsize  (mst3_slv12_hsize  ),
	.mst3_slv12_htrans (mst3_slv12_htrans ),
	.mst3_slv12_hwrite (mst3_slv12_hwrite ),
	.mst3_slv12_req    (mst3_slv12_req    ),
	.mst3_slv12_sel    (mst3_slv12_sel    ),
	.mst3_slv12_size   (mst3_slv12_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm3_slv13_hwdata  (hm3_slv13_hwdata  ),
	.mst3_hs13_hrdata  (mst3_hs13_hrdata  ),
	.mst3_hs13_hready  (mst3_hs13_hready  ),
	.mst3_hs13_hresp   (mst3_hs13_hresp   ),
	.mst3_slv13_ack    (mst3_slv13_ack    ),
	.mst3_slv13_base   (mst3_slv13_base   ),
	.mst3_slv13_grant  (mst3_slv13_grant  ),
	.mst3_slv13_haddr  (mst3_slv13_haddr  ),
	.mst3_slv13_hburst (mst3_slv13_hburst ),
	.mst3_slv13_hprot  (mst3_slv13_hprot  ),
	.mst3_slv13_hsize  (mst3_slv13_hsize  ),
	.mst3_slv13_htrans (mst3_slv13_htrans ),
	.mst3_slv13_hwrite (mst3_slv13_hwrite ),
	.mst3_slv13_req    (mst3_slv13_req    ),
	.mst3_slv13_sel    (mst3_slv13_sel    ),
	.mst3_slv13_size   (mst3_slv13_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm3_slv14_hwdata  (hm3_slv14_hwdata  ),
	.mst3_hs14_hrdata  (mst3_hs14_hrdata  ),
	.mst3_hs14_hready  (mst3_hs14_hready  ),
	.mst3_hs14_hresp   (mst3_hs14_hresp   ),
	.mst3_slv14_ack    (mst3_slv14_ack    ),
	.mst3_slv14_base   (mst3_slv14_base   ),
	.mst3_slv14_grant  (mst3_slv14_grant  ),
	.mst3_slv14_haddr  (mst3_slv14_haddr  ),
	.mst3_slv14_hburst (mst3_slv14_hburst ),
	.mst3_slv14_hprot  (mst3_slv14_hprot  ),
	.mst3_slv14_hsize  (mst3_slv14_hsize  ),
	.mst3_slv14_htrans (mst3_slv14_htrans ),
	.mst3_slv14_hwrite (mst3_slv14_hwrite ),
	.mst3_slv14_req    (mst3_slv14_req    ),
	.mst3_slv14_sel    (mst3_slv14_sel    ),
	.mst3_slv14_size   (mst3_slv14_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm3_slv15_hwdata  (hm3_slv15_hwdata  ),
	.mst3_hs15_hrdata  (mst3_hs15_hrdata  ),
	.mst3_hs15_hready  (mst3_hs15_hready  ),
	.mst3_hs15_hresp   (mst3_hs15_hresp   ),
	.mst3_slv15_ack    (mst3_slv15_ack    ),
	.mst3_slv15_base   (mst3_slv15_base   ),
	.mst3_slv15_grant  (mst3_slv15_grant  ),
	.mst3_slv15_haddr  (mst3_slv15_haddr  ),
	.mst3_slv15_hburst (mst3_slv15_hburst ),
	.mst3_slv15_hprot  (mst3_slv15_hprot  ),
	.mst3_slv15_hsize  (mst3_slv15_hsize  ),
	.mst3_slv15_htrans (mst3_slv15_htrans ),
	.mst3_slv15_hwrite (mst3_slv15_hwrite ),
	.mst3_slv15_req    (mst3_slv15_req    ),
	.mst3_slv15_sel    (mst3_slv15_sel    ),
	.mst3_slv15_size   (mst3_slv15_size   ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST4
   `ifdef ATCBMC200_AHB_SLV0
	.hm4_slv0_hwdata   (hm4_slv0_hwdata   ),
	.mst4_hs0_hrdata   (mst4_hs0_hrdata   ),
	.mst4_hs0_hready   (mst4_hs0_hready   ),
	.mst4_hs0_hresp    (mst4_hs0_hresp    ),
	.mst4_slv0_ack     (mst4_slv0_ack     ),
	.mst4_slv0_base    (mst4_slv0_base    ),
	.mst4_slv0_grant   (mst4_slv0_grant   ),
	.mst4_slv0_haddr   (mst4_slv0_haddr   ),
	.mst4_slv0_hburst  (mst4_slv0_hburst  ),
	.mst4_slv0_hprot   (mst4_slv0_hprot   ),
	.mst4_slv0_hsize   (mst4_slv0_hsize   ),
	.mst4_slv0_htrans  (mst4_slv0_htrans  ),
	.mst4_slv0_hwrite  (mst4_slv0_hwrite  ),
	.mst4_slv0_req     (mst4_slv0_req     ),
	.mst4_slv0_sel     (mst4_slv0_sel     ),
	.mst4_slv0_size    (mst4_slv0_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm4_slv1_hwdata   (hm4_slv1_hwdata   ),
	.mst4_hs1_hrdata   (mst4_hs1_hrdata   ),
	.mst4_hs1_hready   (mst4_hs1_hready   ),
	.mst4_hs1_hresp    (mst4_hs1_hresp    ),
	.mst4_slv1_ack     (mst4_slv1_ack     ),
	.mst4_slv1_base    (mst4_slv1_base    ),
	.mst4_slv1_grant   (mst4_slv1_grant   ),
	.mst4_slv1_haddr   (mst4_slv1_haddr   ),
	.mst4_slv1_hburst  (mst4_slv1_hburst  ),
	.mst4_slv1_hprot   (mst4_slv1_hprot   ),
	.mst4_slv1_hsize   (mst4_slv1_hsize   ),
	.mst4_slv1_htrans  (mst4_slv1_htrans  ),
	.mst4_slv1_hwrite  (mst4_slv1_hwrite  ),
	.mst4_slv1_req     (mst4_slv1_req     ),
	.mst4_slv1_sel     (mst4_slv1_sel     ),
	.mst4_slv1_size    (mst4_slv1_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm4_slv2_hwdata   (hm4_slv2_hwdata   ),
	.mst4_hs2_hrdata   (mst4_hs2_hrdata   ),
	.mst4_hs2_hready   (mst4_hs2_hready   ),
	.mst4_hs2_hresp    (mst4_hs2_hresp    ),
	.mst4_slv2_ack     (mst4_slv2_ack     ),
	.mst4_slv2_base    (mst4_slv2_base    ),
	.mst4_slv2_grant   (mst4_slv2_grant   ),
	.mst4_slv2_haddr   (mst4_slv2_haddr   ),
	.mst4_slv2_hburst  (mst4_slv2_hburst  ),
	.mst4_slv2_hprot   (mst4_slv2_hprot   ),
	.mst4_slv2_hsize   (mst4_slv2_hsize   ),
	.mst4_slv2_htrans  (mst4_slv2_htrans  ),
	.mst4_slv2_hwrite  (mst4_slv2_hwrite  ),
	.mst4_slv2_req     (mst4_slv2_req     ),
	.mst4_slv2_sel     (mst4_slv2_sel     ),
	.mst4_slv2_size    (mst4_slv2_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm4_slv3_hwdata   (hm4_slv3_hwdata   ),
	.mst4_hs3_hrdata   (mst4_hs3_hrdata   ),
	.mst4_hs3_hready   (mst4_hs3_hready   ),
	.mst4_hs3_hresp    (mst4_hs3_hresp    ),
	.mst4_slv3_ack     (mst4_slv3_ack     ),
	.mst4_slv3_base    (mst4_slv3_base    ),
	.mst4_slv3_grant   (mst4_slv3_grant   ),
	.mst4_slv3_haddr   (mst4_slv3_haddr   ),
	.mst4_slv3_hburst  (mst4_slv3_hburst  ),
	.mst4_slv3_hprot   (mst4_slv3_hprot   ),
	.mst4_slv3_hsize   (mst4_slv3_hsize   ),
	.mst4_slv3_htrans  (mst4_slv3_htrans  ),
	.mst4_slv3_hwrite  (mst4_slv3_hwrite  ),
	.mst4_slv3_req     (mst4_slv3_req     ),
	.mst4_slv3_sel     (mst4_slv3_sel     ),
	.mst4_slv3_size    (mst4_slv3_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm4_slv4_hwdata   (hm4_slv4_hwdata   ),
	.mst4_hs4_hrdata   (mst4_hs4_hrdata   ),
	.mst4_hs4_hready   (mst4_hs4_hready   ),
	.mst4_hs4_hresp    (mst4_hs4_hresp    ),
	.mst4_slv4_ack     (mst4_slv4_ack     ),
	.mst4_slv4_base    (mst4_slv4_base    ),
	.mst4_slv4_grant   (mst4_slv4_grant   ),
	.mst4_slv4_haddr   (mst4_slv4_haddr   ),
	.mst4_slv4_hburst  (mst4_slv4_hburst  ),
	.mst4_slv4_hprot   (mst4_slv4_hprot   ),
	.mst4_slv4_hsize   (mst4_slv4_hsize   ),
	.mst4_slv4_htrans  (mst4_slv4_htrans  ),
	.mst4_slv4_hwrite  (mst4_slv4_hwrite  ),
	.mst4_slv4_req     (mst4_slv4_req     ),
	.mst4_slv4_sel     (mst4_slv4_sel     ),
	.mst4_slv4_size    (mst4_slv4_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm4_slv5_hwdata   (hm4_slv5_hwdata   ),
	.mst4_hs5_hrdata   (mst4_hs5_hrdata   ),
	.mst4_hs5_hready   (mst4_hs5_hready   ),
	.mst4_hs5_hresp    (mst4_hs5_hresp    ),
	.mst4_slv5_ack     (mst4_slv5_ack     ),
	.mst4_slv5_base    (mst4_slv5_base    ),
	.mst4_slv5_grant   (mst4_slv5_grant   ),
	.mst4_slv5_haddr   (mst4_slv5_haddr   ),
	.mst4_slv5_hburst  (mst4_slv5_hburst  ),
	.mst4_slv5_hprot   (mst4_slv5_hprot   ),
	.mst4_slv5_hsize   (mst4_slv5_hsize   ),
	.mst4_slv5_htrans  (mst4_slv5_htrans  ),
	.mst4_slv5_hwrite  (mst4_slv5_hwrite  ),
	.mst4_slv5_req     (mst4_slv5_req     ),
	.mst4_slv5_sel     (mst4_slv5_sel     ),
	.mst4_slv5_size    (mst4_slv5_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm4_slv6_hwdata   (hm4_slv6_hwdata   ),
	.mst4_hs6_hrdata   (mst4_hs6_hrdata   ),
	.mst4_hs6_hready   (mst4_hs6_hready   ),
	.mst4_hs6_hresp    (mst4_hs6_hresp    ),
	.mst4_slv6_ack     (mst4_slv6_ack     ),
	.mst4_slv6_base    (mst4_slv6_base    ),
	.mst4_slv6_grant   (mst4_slv6_grant   ),
	.mst4_slv6_haddr   (mst4_slv6_haddr   ),
	.mst4_slv6_hburst  (mst4_slv6_hburst  ),
	.mst4_slv6_hprot   (mst4_slv6_hprot   ),
	.mst4_slv6_hsize   (mst4_slv6_hsize   ),
	.mst4_slv6_htrans  (mst4_slv6_htrans  ),
	.mst4_slv6_hwrite  (mst4_slv6_hwrite  ),
	.mst4_slv6_req     (mst4_slv6_req     ),
	.mst4_slv6_sel     (mst4_slv6_sel     ),
	.mst4_slv6_size    (mst4_slv6_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm4_slv7_hwdata   (hm4_slv7_hwdata   ),
	.mst4_hs7_hrdata   (mst4_hs7_hrdata   ),
	.mst4_hs7_hready   (mst4_hs7_hready   ),
	.mst4_hs7_hresp    (mst4_hs7_hresp    ),
	.mst4_slv7_ack     (mst4_slv7_ack     ),
	.mst4_slv7_base    (mst4_slv7_base    ),
	.mst4_slv7_grant   (mst4_slv7_grant   ),
	.mst4_slv7_haddr   (mst4_slv7_haddr   ),
	.mst4_slv7_hburst  (mst4_slv7_hburst  ),
	.mst4_slv7_hprot   (mst4_slv7_hprot   ),
	.mst4_slv7_hsize   (mst4_slv7_hsize   ),
	.mst4_slv7_htrans  (mst4_slv7_htrans  ),
	.mst4_slv7_hwrite  (mst4_slv7_hwrite  ),
	.mst4_slv7_req     (mst4_slv7_req     ),
	.mst4_slv7_sel     (mst4_slv7_sel     ),
	.mst4_slv7_size    (mst4_slv7_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm4_slv8_hwdata   (hm4_slv8_hwdata   ),
	.mst4_hs8_hrdata   (mst4_hs8_hrdata   ),
	.mst4_hs8_hready   (mst4_hs8_hready   ),
	.mst4_hs8_hresp    (mst4_hs8_hresp    ),
	.mst4_slv8_ack     (mst4_slv8_ack     ),
	.mst4_slv8_base    (mst4_slv8_base    ),
	.mst4_slv8_grant   (mst4_slv8_grant   ),
	.mst4_slv8_haddr   (mst4_slv8_haddr   ),
	.mst4_slv8_hburst  (mst4_slv8_hburst  ),
	.mst4_slv8_hprot   (mst4_slv8_hprot   ),
	.mst4_slv8_hsize   (mst4_slv8_hsize   ),
	.mst4_slv8_htrans  (mst4_slv8_htrans  ),
	.mst4_slv8_hwrite  (mst4_slv8_hwrite  ),
	.mst4_slv8_req     (mst4_slv8_req     ),
	.mst4_slv8_sel     (mst4_slv8_sel     ),
	.mst4_slv8_size    (mst4_slv8_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm4_slv9_hwdata   (hm4_slv9_hwdata   ),
	.mst4_hs9_hrdata   (mst4_hs9_hrdata   ),
	.mst4_hs9_hready   (mst4_hs9_hready   ),
	.mst4_hs9_hresp    (mst4_hs9_hresp    ),
	.mst4_slv9_ack     (mst4_slv9_ack     ),
	.mst4_slv9_base    (mst4_slv9_base    ),
	.mst4_slv9_grant   (mst4_slv9_grant   ),
	.mst4_slv9_haddr   (mst4_slv9_haddr   ),
	.mst4_slv9_hburst  (mst4_slv9_hburst  ),
	.mst4_slv9_hprot   (mst4_slv9_hprot   ),
	.mst4_slv9_hsize   (mst4_slv9_hsize   ),
	.mst4_slv9_htrans  (mst4_slv9_htrans  ),
	.mst4_slv9_hwrite  (mst4_slv9_hwrite  ),
	.mst4_slv9_req     (mst4_slv9_req     ),
	.mst4_slv9_sel     (mst4_slv9_sel     ),
	.mst4_slv9_size    (mst4_slv9_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm4_slv10_hwdata  (hm4_slv10_hwdata  ),
	.mst4_hs10_hrdata  (mst4_hs10_hrdata  ),
	.mst4_hs10_hready  (mst4_hs10_hready  ),
	.mst4_hs10_hresp   (mst4_hs10_hresp   ),
	.mst4_slv10_ack    (mst4_slv10_ack    ),
	.mst4_slv10_base   (mst4_slv10_base   ),
	.mst4_slv10_grant  (mst4_slv10_grant  ),
	.mst4_slv10_haddr  (mst4_slv10_haddr  ),
	.mst4_slv10_hburst (mst4_slv10_hburst ),
	.mst4_slv10_hprot  (mst4_slv10_hprot  ),
	.mst4_slv10_hsize  (mst4_slv10_hsize  ),
	.mst4_slv10_htrans (mst4_slv10_htrans ),
	.mst4_slv10_hwrite (mst4_slv10_hwrite ),
	.mst4_slv10_req    (mst4_slv10_req    ),
	.mst4_slv10_sel    (mst4_slv10_sel    ),
	.mst4_slv10_size   (mst4_slv10_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm4_slv11_hwdata  (hm4_slv11_hwdata  ),
	.mst4_hs11_hrdata  (mst4_hs11_hrdata  ),
	.mst4_hs11_hready  (mst4_hs11_hready  ),
	.mst4_hs11_hresp   (mst4_hs11_hresp   ),
	.mst4_slv11_ack    (mst4_slv11_ack    ),
	.mst4_slv11_base   (mst4_slv11_base   ),
	.mst4_slv11_grant  (mst4_slv11_grant  ),
	.mst4_slv11_haddr  (mst4_slv11_haddr  ),
	.mst4_slv11_hburst (mst4_slv11_hburst ),
	.mst4_slv11_hprot  (mst4_slv11_hprot  ),
	.mst4_slv11_hsize  (mst4_slv11_hsize  ),
	.mst4_slv11_htrans (mst4_slv11_htrans ),
	.mst4_slv11_hwrite (mst4_slv11_hwrite ),
	.mst4_slv11_req    (mst4_slv11_req    ),
	.mst4_slv11_sel    (mst4_slv11_sel    ),
	.mst4_slv11_size   (mst4_slv11_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm4_slv12_hwdata  (hm4_slv12_hwdata  ),
	.mst4_hs12_hrdata  (mst4_hs12_hrdata  ),
	.mst4_hs12_hready  (mst4_hs12_hready  ),
	.mst4_hs12_hresp   (mst4_hs12_hresp   ),
	.mst4_slv12_ack    (mst4_slv12_ack    ),
	.mst4_slv12_base   (mst4_slv12_base   ),
	.mst4_slv12_grant  (mst4_slv12_grant  ),
	.mst4_slv12_haddr  (mst4_slv12_haddr  ),
	.mst4_slv12_hburst (mst4_slv12_hburst ),
	.mst4_slv12_hprot  (mst4_slv12_hprot  ),
	.mst4_slv12_hsize  (mst4_slv12_hsize  ),
	.mst4_slv12_htrans (mst4_slv12_htrans ),
	.mst4_slv12_hwrite (mst4_slv12_hwrite ),
	.mst4_slv12_req    (mst4_slv12_req    ),
	.mst4_slv12_sel    (mst4_slv12_sel    ),
	.mst4_slv12_size   (mst4_slv12_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm4_slv13_hwdata  (hm4_slv13_hwdata  ),
	.mst4_hs13_hrdata  (mst4_hs13_hrdata  ),
	.mst4_hs13_hready  (mst4_hs13_hready  ),
	.mst4_hs13_hresp   (mst4_hs13_hresp   ),
	.mst4_slv13_ack    (mst4_slv13_ack    ),
	.mst4_slv13_base   (mst4_slv13_base   ),
	.mst4_slv13_grant  (mst4_slv13_grant  ),
	.mst4_slv13_haddr  (mst4_slv13_haddr  ),
	.mst4_slv13_hburst (mst4_slv13_hburst ),
	.mst4_slv13_hprot  (mst4_slv13_hprot  ),
	.mst4_slv13_hsize  (mst4_slv13_hsize  ),
	.mst4_slv13_htrans (mst4_slv13_htrans ),
	.mst4_slv13_hwrite (mst4_slv13_hwrite ),
	.mst4_slv13_req    (mst4_slv13_req    ),
	.mst4_slv13_sel    (mst4_slv13_sel    ),
	.mst4_slv13_size   (mst4_slv13_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm4_slv14_hwdata  (hm4_slv14_hwdata  ),
	.mst4_hs14_hrdata  (mst4_hs14_hrdata  ),
	.mst4_hs14_hready  (mst4_hs14_hready  ),
	.mst4_hs14_hresp   (mst4_hs14_hresp   ),
	.mst4_slv14_ack    (mst4_slv14_ack    ),
	.mst4_slv14_base   (mst4_slv14_base   ),
	.mst4_slv14_grant  (mst4_slv14_grant  ),
	.mst4_slv14_haddr  (mst4_slv14_haddr  ),
	.mst4_slv14_hburst (mst4_slv14_hburst ),
	.mst4_slv14_hprot  (mst4_slv14_hprot  ),
	.mst4_slv14_hsize  (mst4_slv14_hsize  ),
	.mst4_slv14_htrans (mst4_slv14_htrans ),
	.mst4_slv14_hwrite (mst4_slv14_hwrite ),
	.mst4_slv14_req    (mst4_slv14_req    ),
	.mst4_slv14_sel    (mst4_slv14_sel    ),
	.mst4_slv14_size   (mst4_slv14_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm4_slv15_hwdata  (hm4_slv15_hwdata  ),
	.mst4_hs15_hrdata  (mst4_hs15_hrdata  ),
	.mst4_hs15_hready  (mst4_hs15_hready  ),
	.mst4_hs15_hresp   (mst4_hs15_hresp   ),
	.mst4_slv15_ack    (mst4_slv15_ack    ),
	.mst4_slv15_base   (mst4_slv15_base   ),
	.mst4_slv15_grant  (mst4_slv15_grant  ),
	.mst4_slv15_haddr  (mst4_slv15_haddr  ),
	.mst4_slv15_hburst (mst4_slv15_hburst ),
	.mst4_slv15_hprot  (mst4_slv15_hprot  ),
	.mst4_slv15_hsize  (mst4_slv15_hsize  ),
	.mst4_slv15_htrans (mst4_slv15_htrans ),
	.mst4_slv15_hwrite (mst4_slv15_hwrite ),
	.mst4_slv15_req    (mst4_slv15_req    ),
	.mst4_slv15_sel    (mst4_slv15_sel    ),
	.mst4_slv15_size   (mst4_slv15_size   ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST5
   `ifdef ATCBMC200_AHB_SLV0
	.hm5_slv0_hwdata   (hm5_slv0_hwdata   ),
	.mst5_hs0_hrdata   (mst5_hs0_hrdata   ),
	.mst5_hs0_hready   (mst5_hs0_hready   ),
	.mst5_hs0_hresp    (mst5_hs0_hresp    ),
	.mst5_slv0_ack     (mst5_slv0_ack     ),
	.mst5_slv0_base    (mst5_slv0_base    ),
	.mst5_slv0_grant   (mst5_slv0_grant   ),
	.mst5_slv0_haddr   (mst5_slv0_haddr   ),
	.mst5_slv0_hburst  (mst5_slv0_hburst  ),
	.mst5_slv0_hprot   (mst5_slv0_hprot   ),
	.mst5_slv0_hsize   (mst5_slv0_hsize   ),
	.mst5_slv0_htrans  (mst5_slv0_htrans  ),
	.mst5_slv0_hwrite  (mst5_slv0_hwrite  ),
	.mst5_slv0_req     (mst5_slv0_req     ),
	.mst5_slv0_sel     (mst5_slv0_sel     ),
	.mst5_slv0_size    (mst5_slv0_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm5_slv1_hwdata   (hm5_slv1_hwdata   ),
	.mst5_hs1_hrdata   (mst5_hs1_hrdata   ),
	.mst5_hs1_hready   (mst5_hs1_hready   ),
	.mst5_hs1_hresp    (mst5_hs1_hresp    ),
	.mst5_slv1_ack     (mst5_slv1_ack     ),
	.mst5_slv1_base    (mst5_slv1_base    ),
	.mst5_slv1_grant   (mst5_slv1_grant   ),
	.mst5_slv1_haddr   (mst5_slv1_haddr   ),
	.mst5_slv1_hburst  (mst5_slv1_hburst  ),
	.mst5_slv1_hprot   (mst5_slv1_hprot   ),
	.mst5_slv1_hsize   (mst5_slv1_hsize   ),
	.mst5_slv1_htrans  (mst5_slv1_htrans  ),
	.mst5_slv1_hwrite  (mst5_slv1_hwrite  ),
	.mst5_slv1_req     (mst5_slv1_req     ),
	.mst5_slv1_sel     (mst5_slv1_sel     ),
	.mst5_slv1_size    (mst5_slv1_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm5_slv2_hwdata   (hm5_slv2_hwdata   ),
	.mst5_hs2_hrdata   (mst5_hs2_hrdata   ),
	.mst5_hs2_hready   (mst5_hs2_hready   ),
	.mst5_hs2_hresp    (mst5_hs2_hresp    ),
	.mst5_slv2_ack     (mst5_slv2_ack     ),
	.mst5_slv2_base    (mst5_slv2_base    ),
	.mst5_slv2_grant   (mst5_slv2_grant   ),
	.mst5_slv2_haddr   (mst5_slv2_haddr   ),
	.mst5_slv2_hburst  (mst5_slv2_hburst  ),
	.mst5_slv2_hprot   (mst5_slv2_hprot   ),
	.mst5_slv2_hsize   (mst5_slv2_hsize   ),
	.mst5_slv2_htrans  (mst5_slv2_htrans  ),
	.mst5_slv2_hwrite  (mst5_slv2_hwrite  ),
	.mst5_slv2_req     (mst5_slv2_req     ),
	.mst5_slv2_sel     (mst5_slv2_sel     ),
	.mst5_slv2_size    (mst5_slv2_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm5_slv3_hwdata   (hm5_slv3_hwdata   ),
	.mst5_hs3_hrdata   (mst5_hs3_hrdata   ),
	.mst5_hs3_hready   (mst5_hs3_hready   ),
	.mst5_hs3_hresp    (mst5_hs3_hresp    ),
	.mst5_slv3_ack     (mst5_slv3_ack     ),
	.mst5_slv3_base    (mst5_slv3_base    ),
	.mst5_slv3_grant   (mst5_slv3_grant   ),
	.mst5_slv3_haddr   (mst5_slv3_haddr   ),
	.mst5_slv3_hburst  (mst5_slv3_hburst  ),
	.mst5_slv3_hprot   (mst5_slv3_hprot   ),
	.mst5_slv3_hsize   (mst5_slv3_hsize   ),
	.mst5_slv3_htrans  (mst5_slv3_htrans  ),
	.mst5_slv3_hwrite  (mst5_slv3_hwrite  ),
	.mst5_slv3_req     (mst5_slv3_req     ),
	.mst5_slv3_sel     (mst5_slv3_sel     ),
	.mst5_slv3_size    (mst5_slv3_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm5_slv4_hwdata   (hm5_slv4_hwdata   ),
	.mst5_hs4_hrdata   (mst5_hs4_hrdata   ),
	.mst5_hs4_hready   (mst5_hs4_hready   ),
	.mst5_hs4_hresp    (mst5_hs4_hresp    ),
	.mst5_slv4_ack     (mst5_slv4_ack     ),
	.mst5_slv4_base    (mst5_slv4_base    ),
	.mst5_slv4_grant   (mst5_slv4_grant   ),
	.mst5_slv4_haddr   (mst5_slv4_haddr   ),
	.mst5_slv4_hburst  (mst5_slv4_hburst  ),
	.mst5_slv4_hprot   (mst5_slv4_hprot   ),
	.mst5_slv4_hsize   (mst5_slv4_hsize   ),
	.mst5_slv4_htrans  (mst5_slv4_htrans  ),
	.mst5_slv4_hwrite  (mst5_slv4_hwrite  ),
	.mst5_slv4_req     (mst5_slv4_req     ),
	.mst5_slv4_sel     (mst5_slv4_sel     ),
	.mst5_slv4_size    (mst5_slv4_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm5_slv5_hwdata   (hm5_slv5_hwdata   ),
	.mst5_hs5_hrdata   (mst5_hs5_hrdata   ),
	.mst5_hs5_hready   (mst5_hs5_hready   ),
	.mst5_hs5_hresp    (mst5_hs5_hresp    ),
	.mst5_slv5_ack     (mst5_slv5_ack     ),
	.mst5_slv5_base    (mst5_slv5_base    ),
	.mst5_slv5_grant   (mst5_slv5_grant   ),
	.mst5_slv5_haddr   (mst5_slv5_haddr   ),
	.mst5_slv5_hburst  (mst5_slv5_hburst  ),
	.mst5_slv5_hprot   (mst5_slv5_hprot   ),
	.mst5_slv5_hsize   (mst5_slv5_hsize   ),
	.mst5_slv5_htrans  (mst5_slv5_htrans  ),
	.mst5_slv5_hwrite  (mst5_slv5_hwrite  ),
	.mst5_slv5_req     (mst5_slv5_req     ),
	.mst5_slv5_sel     (mst5_slv5_sel     ),
	.mst5_slv5_size    (mst5_slv5_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm5_slv6_hwdata   (hm5_slv6_hwdata   ),
	.mst5_hs6_hrdata   (mst5_hs6_hrdata   ),
	.mst5_hs6_hready   (mst5_hs6_hready   ),
	.mst5_hs6_hresp    (mst5_hs6_hresp    ),
	.mst5_slv6_ack     (mst5_slv6_ack     ),
	.mst5_slv6_base    (mst5_slv6_base    ),
	.mst5_slv6_grant   (mst5_slv6_grant   ),
	.mst5_slv6_haddr   (mst5_slv6_haddr   ),
	.mst5_slv6_hburst  (mst5_slv6_hburst  ),
	.mst5_slv6_hprot   (mst5_slv6_hprot   ),
	.mst5_slv6_hsize   (mst5_slv6_hsize   ),
	.mst5_slv6_htrans  (mst5_slv6_htrans  ),
	.mst5_slv6_hwrite  (mst5_slv6_hwrite  ),
	.mst5_slv6_req     (mst5_slv6_req     ),
	.mst5_slv6_sel     (mst5_slv6_sel     ),
	.mst5_slv6_size    (mst5_slv6_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm5_slv7_hwdata   (hm5_slv7_hwdata   ),
	.mst5_hs7_hrdata   (mst5_hs7_hrdata   ),
	.mst5_hs7_hready   (mst5_hs7_hready   ),
	.mst5_hs7_hresp    (mst5_hs7_hresp    ),
	.mst5_slv7_ack     (mst5_slv7_ack     ),
	.mst5_slv7_base    (mst5_slv7_base    ),
	.mst5_slv7_grant   (mst5_slv7_grant   ),
	.mst5_slv7_haddr   (mst5_slv7_haddr   ),
	.mst5_slv7_hburst  (mst5_slv7_hburst  ),
	.mst5_slv7_hprot   (mst5_slv7_hprot   ),
	.mst5_slv7_hsize   (mst5_slv7_hsize   ),
	.mst5_slv7_htrans  (mst5_slv7_htrans  ),
	.mst5_slv7_hwrite  (mst5_slv7_hwrite  ),
	.mst5_slv7_req     (mst5_slv7_req     ),
	.mst5_slv7_sel     (mst5_slv7_sel     ),
	.mst5_slv7_size    (mst5_slv7_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm5_slv8_hwdata   (hm5_slv8_hwdata   ),
	.mst5_hs8_hrdata   (mst5_hs8_hrdata   ),
	.mst5_hs8_hready   (mst5_hs8_hready   ),
	.mst5_hs8_hresp    (mst5_hs8_hresp    ),
	.mst5_slv8_ack     (mst5_slv8_ack     ),
	.mst5_slv8_base    (mst5_slv8_base    ),
	.mst5_slv8_grant   (mst5_slv8_grant   ),
	.mst5_slv8_haddr   (mst5_slv8_haddr   ),
	.mst5_slv8_hburst  (mst5_slv8_hburst  ),
	.mst5_slv8_hprot   (mst5_slv8_hprot   ),
	.mst5_slv8_hsize   (mst5_slv8_hsize   ),
	.mst5_slv8_htrans  (mst5_slv8_htrans  ),
	.mst5_slv8_hwrite  (mst5_slv8_hwrite  ),
	.mst5_slv8_req     (mst5_slv8_req     ),
	.mst5_slv8_sel     (mst5_slv8_sel     ),
	.mst5_slv8_size    (mst5_slv8_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm5_slv9_hwdata   (hm5_slv9_hwdata   ),
	.mst5_hs9_hrdata   (mst5_hs9_hrdata   ),
	.mst5_hs9_hready   (mst5_hs9_hready   ),
	.mst5_hs9_hresp    (mst5_hs9_hresp    ),
	.mst5_slv9_ack     (mst5_slv9_ack     ),
	.mst5_slv9_base    (mst5_slv9_base    ),
	.mst5_slv9_grant   (mst5_slv9_grant   ),
	.mst5_slv9_haddr   (mst5_slv9_haddr   ),
	.mst5_slv9_hburst  (mst5_slv9_hburst  ),
	.mst5_slv9_hprot   (mst5_slv9_hprot   ),
	.mst5_slv9_hsize   (mst5_slv9_hsize   ),
	.mst5_slv9_htrans  (mst5_slv9_htrans  ),
	.mst5_slv9_hwrite  (mst5_slv9_hwrite  ),
	.mst5_slv9_req     (mst5_slv9_req     ),
	.mst5_slv9_sel     (mst5_slv9_sel     ),
	.mst5_slv9_size    (mst5_slv9_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm5_slv10_hwdata  (hm5_slv10_hwdata  ),
	.mst5_hs10_hrdata  (mst5_hs10_hrdata  ),
	.mst5_hs10_hready  (mst5_hs10_hready  ),
	.mst5_hs10_hresp   (mst5_hs10_hresp   ),
	.mst5_slv10_ack    (mst5_slv10_ack    ),
	.mst5_slv10_base   (mst5_slv10_base   ),
	.mst5_slv10_grant  (mst5_slv10_grant  ),
	.mst5_slv10_haddr  (mst5_slv10_haddr  ),
	.mst5_slv10_hburst (mst5_slv10_hburst ),
	.mst5_slv10_hprot  (mst5_slv10_hprot  ),
	.mst5_slv10_hsize  (mst5_slv10_hsize  ),
	.mst5_slv10_htrans (mst5_slv10_htrans ),
	.mst5_slv10_hwrite (mst5_slv10_hwrite ),
	.mst5_slv10_req    (mst5_slv10_req    ),
	.mst5_slv10_sel    (mst5_slv10_sel    ),
	.mst5_slv10_size   (mst5_slv10_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm5_slv11_hwdata  (hm5_slv11_hwdata  ),
	.mst5_hs11_hrdata  (mst5_hs11_hrdata  ),
	.mst5_hs11_hready  (mst5_hs11_hready  ),
	.mst5_hs11_hresp   (mst5_hs11_hresp   ),
	.mst5_slv11_ack    (mst5_slv11_ack    ),
	.mst5_slv11_base   (mst5_slv11_base   ),
	.mst5_slv11_grant  (mst5_slv11_grant  ),
	.mst5_slv11_haddr  (mst5_slv11_haddr  ),
	.mst5_slv11_hburst (mst5_slv11_hburst ),
	.mst5_slv11_hprot  (mst5_slv11_hprot  ),
	.mst5_slv11_hsize  (mst5_slv11_hsize  ),
	.mst5_slv11_htrans (mst5_slv11_htrans ),
	.mst5_slv11_hwrite (mst5_slv11_hwrite ),
	.mst5_slv11_req    (mst5_slv11_req    ),
	.mst5_slv11_sel    (mst5_slv11_sel    ),
	.mst5_slv11_size   (mst5_slv11_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm5_slv12_hwdata  (hm5_slv12_hwdata  ),
	.mst5_hs12_hrdata  (mst5_hs12_hrdata  ),
	.mst5_hs12_hready  (mst5_hs12_hready  ),
	.mst5_hs12_hresp   (mst5_hs12_hresp   ),
	.mst5_slv12_ack    (mst5_slv12_ack    ),
	.mst5_slv12_base   (mst5_slv12_base   ),
	.mst5_slv12_grant  (mst5_slv12_grant  ),
	.mst5_slv12_haddr  (mst5_slv12_haddr  ),
	.mst5_slv12_hburst (mst5_slv12_hburst ),
	.mst5_slv12_hprot  (mst5_slv12_hprot  ),
	.mst5_slv12_hsize  (mst5_slv12_hsize  ),
	.mst5_slv12_htrans (mst5_slv12_htrans ),
	.mst5_slv12_hwrite (mst5_slv12_hwrite ),
	.mst5_slv12_req    (mst5_slv12_req    ),
	.mst5_slv12_sel    (mst5_slv12_sel    ),
	.mst5_slv12_size   (mst5_slv12_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm5_slv13_hwdata  (hm5_slv13_hwdata  ),
	.mst5_hs13_hrdata  (mst5_hs13_hrdata  ),
	.mst5_hs13_hready  (mst5_hs13_hready  ),
	.mst5_hs13_hresp   (mst5_hs13_hresp   ),
	.mst5_slv13_ack    (mst5_slv13_ack    ),
	.mst5_slv13_base   (mst5_slv13_base   ),
	.mst5_slv13_grant  (mst5_slv13_grant  ),
	.mst5_slv13_haddr  (mst5_slv13_haddr  ),
	.mst5_slv13_hburst (mst5_slv13_hburst ),
	.mst5_slv13_hprot  (mst5_slv13_hprot  ),
	.mst5_slv13_hsize  (mst5_slv13_hsize  ),
	.mst5_slv13_htrans (mst5_slv13_htrans ),
	.mst5_slv13_hwrite (mst5_slv13_hwrite ),
	.mst5_slv13_req    (mst5_slv13_req    ),
	.mst5_slv13_sel    (mst5_slv13_sel    ),
	.mst5_slv13_size   (mst5_slv13_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm5_slv14_hwdata  (hm5_slv14_hwdata  ),
	.mst5_hs14_hrdata  (mst5_hs14_hrdata  ),
	.mst5_hs14_hready  (mst5_hs14_hready  ),
	.mst5_hs14_hresp   (mst5_hs14_hresp   ),
	.mst5_slv14_ack    (mst5_slv14_ack    ),
	.mst5_slv14_base   (mst5_slv14_base   ),
	.mst5_slv14_grant  (mst5_slv14_grant  ),
	.mst5_slv14_haddr  (mst5_slv14_haddr  ),
	.mst5_slv14_hburst (mst5_slv14_hburst ),
	.mst5_slv14_hprot  (mst5_slv14_hprot  ),
	.mst5_slv14_hsize  (mst5_slv14_hsize  ),
	.mst5_slv14_htrans (mst5_slv14_htrans ),
	.mst5_slv14_hwrite (mst5_slv14_hwrite ),
	.mst5_slv14_req    (mst5_slv14_req    ),
	.mst5_slv14_sel    (mst5_slv14_sel    ),
	.mst5_slv14_size   (mst5_slv14_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm5_slv15_hwdata  (hm5_slv15_hwdata  ),
	.mst5_hs15_hrdata  (mst5_hs15_hrdata  ),
	.mst5_hs15_hready  (mst5_hs15_hready  ),
	.mst5_hs15_hresp   (mst5_hs15_hresp   ),
	.mst5_slv15_ack    (mst5_slv15_ack    ),
	.mst5_slv15_base   (mst5_slv15_base   ),
	.mst5_slv15_grant  (mst5_slv15_grant  ),
	.mst5_slv15_haddr  (mst5_slv15_haddr  ),
	.mst5_slv15_hburst (mst5_slv15_hburst ),
	.mst5_slv15_hprot  (mst5_slv15_hprot  ),
	.mst5_slv15_hsize  (mst5_slv15_hsize  ),
	.mst5_slv15_htrans (mst5_slv15_htrans ),
	.mst5_slv15_hwrite (mst5_slv15_hwrite ),
	.mst5_slv15_req    (mst5_slv15_req    ),
	.mst5_slv15_sel    (mst5_slv15_sel    ),
	.mst5_slv15_size   (mst5_slv15_size   ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST6
   `ifdef ATCBMC200_AHB_SLV0
	.hm6_slv0_hwdata   (hm6_slv0_hwdata   ),
	.mst6_hs0_hrdata   (mst6_hs0_hrdata   ),
	.mst6_hs0_hready   (mst6_hs0_hready   ),
	.mst6_hs0_hresp    (mst6_hs0_hresp    ),
	.mst6_slv0_ack     (mst6_slv0_ack     ),
	.mst6_slv0_base    (mst6_slv0_base    ),
	.mst6_slv0_grant   (mst6_slv0_grant   ),
	.mst6_slv0_haddr   (mst6_slv0_haddr   ),
	.mst6_slv0_hburst  (mst6_slv0_hburst  ),
	.mst6_slv0_hprot   (mst6_slv0_hprot   ),
	.mst6_slv0_hsize   (mst6_slv0_hsize   ),
	.mst6_slv0_htrans  (mst6_slv0_htrans  ),
	.mst6_slv0_hwrite  (mst6_slv0_hwrite  ),
	.mst6_slv0_req     (mst6_slv0_req     ),
	.mst6_slv0_sel     (mst6_slv0_sel     ),
	.mst6_slv0_size    (mst6_slv0_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm6_slv1_hwdata   (hm6_slv1_hwdata   ),
	.mst6_hs1_hrdata   (mst6_hs1_hrdata   ),
	.mst6_hs1_hready   (mst6_hs1_hready   ),
	.mst6_hs1_hresp    (mst6_hs1_hresp    ),
	.mst6_slv1_ack     (mst6_slv1_ack     ),
	.mst6_slv1_base    (mst6_slv1_base    ),
	.mst6_slv1_grant   (mst6_slv1_grant   ),
	.mst6_slv1_haddr   (mst6_slv1_haddr   ),
	.mst6_slv1_hburst  (mst6_slv1_hburst  ),
	.mst6_slv1_hprot   (mst6_slv1_hprot   ),
	.mst6_slv1_hsize   (mst6_slv1_hsize   ),
	.mst6_slv1_htrans  (mst6_slv1_htrans  ),
	.mst6_slv1_hwrite  (mst6_slv1_hwrite  ),
	.mst6_slv1_req     (mst6_slv1_req     ),
	.mst6_slv1_sel     (mst6_slv1_sel     ),
	.mst6_slv1_size    (mst6_slv1_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm6_slv2_hwdata   (hm6_slv2_hwdata   ),
	.mst6_hs2_hrdata   (mst6_hs2_hrdata   ),
	.mst6_hs2_hready   (mst6_hs2_hready   ),
	.mst6_hs2_hresp    (mst6_hs2_hresp    ),
	.mst6_slv2_ack     (mst6_slv2_ack     ),
	.mst6_slv2_base    (mst6_slv2_base    ),
	.mst6_slv2_grant   (mst6_slv2_grant   ),
	.mst6_slv2_haddr   (mst6_slv2_haddr   ),
	.mst6_slv2_hburst  (mst6_slv2_hburst  ),
	.mst6_slv2_hprot   (mst6_slv2_hprot   ),
	.mst6_slv2_hsize   (mst6_slv2_hsize   ),
	.mst6_slv2_htrans  (mst6_slv2_htrans  ),
	.mst6_slv2_hwrite  (mst6_slv2_hwrite  ),
	.mst6_slv2_req     (mst6_slv2_req     ),
	.mst6_slv2_sel     (mst6_slv2_sel     ),
	.mst6_slv2_size    (mst6_slv2_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm6_slv3_hwdata   (hm6_slv3_hwdata   ),
	.mst6_hs3_hrdata   (mst6_hs3_hrdata   ),
	.mst6_hs3_hready   (mst6_hs3_hready   ),
	.mst6_hs3_hresp    (mst6_hs3_hresp    ),
	.mst6_slv3_ack     (mst6_slv3_ack     ),
	.mst6_slv3_base    (mst6_slv3_base    ),
	.mst6_slv3_grant   (mst6_slv3_grant   ),
	.mst6_slv3_haddr   (mst6_slv3_haddr   ),
	.mst6_slv3_hburst  (mst6_slv3_hburst  ),
	.mst6_slv3_hprot   (mst6_slv3_hprot   ),
	.mst6_slv3_hsize   (mst6_slv3_hsize   ),
	.mst6_slv3_htrans  (mst6_slv3_htrans  ),
	.mst6_slv3_hwrite  (mst6_slv3_hwrite  ),
	.mst6_slv3_req     (mst6_slv3_req     ),
	.mst6_slv3_sel     (mst6_slv3_sel     ),
	.mst6_slv3_size    (mst6_slv3_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm6_slv4_hwdata   (hm6_slv4_hwdata   ),
	.mst6_hs4_hrdata   (mst6_hs4_hrdata   ),
	.mst6_hs4_hready   (mst6_hs4_hready   ),
	.mst6_hs4_hresp    (mst6_hs4_hresp    ),
	.mst6_slv4_ack     (mst6_slv4_ack     ),
	.mst6_slv4_base    (mst6_slv4_base    ),
	.mst6_slv4_grant   (mst6_slv4_grant   ),
	.mst6_slv4_haddr   (mst6_slv4_haddr   ),
	.mst6_slv4_hburst  (mst6_slv4_hburst  ),
	.mst6_slv4_hprot   (mst6_slv4_hprot   ),
	.mst6_slv4_hsize   (mst6_slv4_hsize   ),
	.mst6_slv4_htrans  (mst6_slv4_htrans  ),
	.mst6_slv4_hwrite  (mst6_slv4_hwrite  ),
	.mst6_slv4_req     (mst6_slv4_req     ),
	.mst6_slv4_sel     (mst6_slv4_sel     ),
	.mst6_slv4_size    (mst6_slv4_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm6_slv5_hwdata   (hm6_slv5_hwdata   ),
	.mst6_hs5_hrdata   (mst6_hs5_hrdata   ),
	.mst6_hs5_hready   (mst6_hs5_hready   ),
	.mst6_hs5_hresp    (mst6_hs5_hresp    ),
	.mst6_slv5_ack     (mst6_slv5_ack     ),
	.mst6_slv5_base    (mst6_slv5_base    ),
	.mst6_slv5_grant   (mst6_slv5_grant   ),
	.mst6_slv5_haddr   (mst6_slv5_haddr   ),
	.mst6_slv5_hburst  (mst6_slv5_hburst  ),
	.mst6_slv5_hprot   (mst6_slv5_hprot   ),
	.mst6_slv5_hsize   (mst6_slv5_hsize   ),
	.mst6_slv5_htrans  (mst6_slv5_htrans  ),
	.mst6_slv5_hwrite  (mst6_slv5_hwrite  ),
	.mst6_slv5_req     (mst6_slv5_req     ),
	.mst6_slv5_sel     (mst6_slv5_sel     ),
	.mst6_slv5_size    (mst6_slv5_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm6_slv6_hwdata   (hm6_slv6_hwdata   ),
	.mst6_hs6_hrdata   (mst6_hs6_hrdata   ),
	.mst6_hs6_hready   (mst6_hs6_hready   ),
	.mst6_hs6_hresp    (mst6_hs6_hresp    ),
	.mst6_slv6_ack     (mst6_slv6_ack     ),
	.mst6_slv6_base    (mst6_slv6_base    ),
	.mst6_slv6_grant   (mst6_slv6_grant   ),
	.mst6_slv6_haddr   (mst6_slv6_haddr   ),
	.mst6_slv6_hburst  (mst6_slv6_hburst  ),
	.mst6_slv6_hprot   (mst6_slv6_hprot   ),
	.mst6_slv6_hsize   (mst6_slv6_hsize   ),
	.mst6_slv6_htrans  (mst6_slv6_htrans  ),
	.mst6_slv6_hwrite  (mst6_slv6_hwrite  ),
	.mst6_slv6_req     (mst6_slv6_req     ),
	.mst6_slv6_sel     (mst6_slv6_sel     ),
	.mst6_slv6_size    (mst6_slv6_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm6_slv7_hwdata   (hm6_slv7_hwdata   ),
	.mst6_hs7_hrdata   (mst6_hs7_hrdata   ),
	.mst6_hs7_hready   (mst6_hs7_hready   ),
	.mst6_hs7_hresp    (mst6_hs7_hresp    ),
	.mst6_slv7_ack     (mst6_slv7_ack     ),
	.mst6_slv7_base    (mst6_slv7_base    ),
	.mst6_slv7_grant   (mst6_slv7_grant   ),
	.mst6_slv7_haddr   (mst6_slv7_haddr   ),
	.mst6_slv7_hburst  (mst6_slv7_hburst  ),
	.mst6_slv7_hprot   (mst6_slv7_hprot   ),
	.mst6_slv7_hsize   (mst6_slv7_hsize   ),
	.mst6_slv7_htrans  (mst6_slv7_htrans  ),
	.mst6_slv7_hwrite  (mst6_slv7_hwrite  ),
	.mst6_slv7_req     (mst6_slv7_req     ),
	.mst6_slv7_sel     (mst6_slv7_sel     ),
	.mst6_slv7_size    (mst6_slv7_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm6_slv8_hwdata   (hm6_slv8_hwdata   ),
	.mst6_hs8_hrdata   (mst6_hs8_hrdata   ),
	.mst6_hs8_hready   (mst6_hs8_hready   ),
	.mst6_hs8_hresp    (mst6_hs8_hresp    ),
	.mst6_slv8_ack     (mst6_slv8_ack     ),
	.mst6_slv8_base    (mst6_slv8_base    ),
	.mst6_slv8_grant   (mst6_slv8_grant   ),
	.mst6_slv8_haddr   (mst6_slv8_haddr   ),
	.mst6_slv8_hburst  (mst6_slv8_hburst  ),
	.mst6_slv8_hprot   (mst6_slv8_hprot   ),
	.mst6_slv8_hsize   (mst6_slv8_hsize   ),
	.mst6_slv8_htrans  (mst6_slv8_htrans  ),
	.mst6_slv8_hwrite  (mst6_slv8_hwrite  ),
	.mst6_slv8_req     (mst6_slv8_req     ),
	.mst6_slv8_sel     (mst6_slv8_sel     ),
	.mst6_slv8_size    (mst6_slv8_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm6_slv9_hwdata   (hm6_slv9_hwdata   ),
	.mst6_hs9_hrdata   (mst6_hs9_hrdata   ),
	.mst6_hs9_hready   (mst6_hs9_hready   ),
	.mst6_hs9_hresp    (mst6_hs9_hresp    ),
	.mst6_slv9_ack     (mst6_slv9_ack     ),
	.mst6_slv9_base    (mst6_slv9_base    ),
	.mst6_slv9_grant   (mst6_slv9_grant   ),
	.mst6_slv9_haddr   (mst6_slv9_haddr   ),
	.mst6_slv9_hburst  (mst6_slv9_hburst  ),
	.mst6_slv9_hprot   (mst6_slv9_hprot   ),
	.mst6_slv9_hsize   (mst6_slv9_hsize   ),
	.mst6_slv9_htrans  (mst6_slv9_htrans  ),
	.mst6_slv9_hwrite  (mst6_slv9_hwrite  ),
	.mst6_slv9_req     (mst6_slv9_req     ),
	.mst6_slv9_sel     (mst6_slv9_sel     ),
	.mst6_slv9_size    (mst6_slv9_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm6_slv10_hwdata  (hm6_slv10_hwdata  ),
	.mst6_hs10_hrdata  (mst6_hs10_hrdata  ),
	.mst6_hs10_hready  (mst6_hs10_hready  ),
	.mst6_hs10_hresp   (mst6_hs10_hresp   ),
	.mst6_slv10_ack    (mst6_slv10_ack    ),
	.mst6_slv10_base   (mst6_slv10_base   ),
	.mst6_slv10_grant  (mst6_slv10_grant  ),
	.mst6_slv10_haddr  (mst6_slv10_haddr  ),
	.mst6_slv10_hburst (mst6_slv10_hburst ),
	.mst6_slv10_hprot  (mst6_slv10_hprot  ),
	.mst6_slv10_hsize  (mst6_slv10_hsize  ),
	.mst6_slv10_htrans (mst6_slv10_htrans ),
	.mst6_slv10_hwrite (mst6_slv10_hwrite ),
	.mst6_slv10_req    (mst6_slv10_req    ),
	.mst6_slv10_sel    (mst6_slv10_sel    ),
	.mst6_slv10_size   (mst6_slv10_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm6_slv11_hwdata  (hm6_slv11_hwdata  ),
	.mst6_hs11_hrdata  (mst6_hs11_hrdata  ),
	.mst6_hs11_hready  (mst6_hs11_hready  ),
	.mst6_hs11_hresp   (mst6_hs11_hresp   ),
	.mst6_slv11_ack    (mst6_slv11_ack    ),
	.mst6_slv11_base   (mst6_slv11_base   ),
	.mst6_slv11_grant  (mst6_slv11_grant  ),
	.mst6_slv11_haddr  (mst6_slv11_haddr  ),
	.mst6_slv11_hburst (mst6_slv11_hburst ),
	.mst6_slv11_hprot  (mst6_slv11_hprot  ),
	.mst6_slv11_hsize  (mst6_slv11_hsize  ),
	.mst6_slv11_htrans (mst6_slv11_htrans ),
	.mst6_slv11_hwrite (mst6_slv11_hwrite ),
	.mst6_slv11_req    (mst6_slv11_req    ),
	.mst6_slv11_sel    (mst6_slv11_sel    ),
	.mst6_slv11_size   (mst6_slv11_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm6_slv12_hwdata  (hm6_slv12_hwdata  ),
	.mst6_hs12_hrdata  (mst6_hs12_hrdata  ),
	.mst6_hs12_hready  (mst6_hs12_hready  ),
	.mst6_hs12_hresp   (mst6_hs12_hresp   ),
	.mst6_slv12_ack    (mst6_slv12_ack    ),
	.mst6_slv12_base   (mst6_slv12_base   ),
	.mst6_slv12_grant  (mst6_slv12_grant  ),
	.mst6_slv12_haddr  (mst6_slv12_haddr  ),
	.mst6_slv12_hburst (mst6_slv12_hburst ),
	.mst6_slv12_hprot  (mst6_slv12_hprot  ),
	.mst6_slv12_hsize  (mst6_slv12_hsize  ),
	.mst6_slv12_htrans (mst6_slv12_htrans ),
	.mst6_slv12_hwrite (mst6_slv12_hwrite ),
	.mst6_slv12_req    (mst6_slv12_req    ),
	.mst6_slv12_sel    (mst6_slv12_sel    ),
	.mst6_slv12_size   (mst6_slv12_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm6_slv13_hwdata  (hm6_slv13_hwdata  ),
	.mst6_hs13_hrdata  (mst6_hs13_hrdata  ),
	.mst6_hs13_hready  (mst6_hs13_hready  ),
	.mst6_hs13_hresp   (mst6_hs13_hresp   ),
	.mst6_slv13_ack    (mst6_slv13_ack    ),
	.mst6_slv13_base   (mst6_slv13_base   ),
	.mst6_slv13_grant  (mst6_slv13_grant  ),
	.mst6_slv13_haddr  (mst6_slv13_haddr  ),
	.mst6_slv13_hburst (mst6_slv13_hburst ),
	.mst6_slv13_hprot  (mst6_slv13_hprot  ),
	.mst6_slv13_hsize  (mst6_slv13_hsize  ),
	.mst6_slv13_htrans (mst6_slv13_htrans ),
	.mst6_slv13_hwrite (mst6_slv13_hwrite ),
	.mst6_slv13_req    (mst6_slv13_req    ),
	.mst6_slv13_sel    (mst6_slv13_sel    ),
	.mst6_slv13_size   (mst6_slv13_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm6_slv14_hwdata  (hm6_slv14_hwdata  ),
	.mst6_hs14_hrdata  (mst6_hs14_hrdata  ),
	.mst6_hs14_hready  (mst6_hs14_hready  ),
	.mst6_hs14_hresp   (mst6_hs14_hresp   ),
	.mst6_slv14_ack    (mst6_slv14_ack    ),
	.mst6_slv14_base   (mst6_slv14_base   ),
	.mst6_slv14_grant  (mst6_slv14_grant  ),
	.mst6_slv14_haddr  (mst6_slv14_haddr  ),
	.mst6_slv14_hburst (mst6_slv14_hburst ),
	.mst6_slv14_hprot  (mst6_slv14_hprot  ),
	.mst6_slv14_hsize  (mst6_slv14_hsize  ),
	.mst6_slv14_htrans (mst6_slv14_htrans ),
	.mst6_slv14_hwrite (mst6_slv14_hwrite ),
	.mst6_slv14_req    (mst6_slv14_req    ),
	.mst6_slv14_sel    (mst6_slv14_sel    ),
	.mst6_slv14_size   (mst6_slv14_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm6_slv15_hwdata  (hm6_slv15_hwdata  ),
	.mst6_hs15_hrdata  (mst6_hs15_hrdata  ),
	.mst6_hs15_hready  (mst6_hs15_hready  ),
	.mst6_hs15_hresp   (mst6_hs15_hresp   ),
	.mst6_slv15_ack    (mst6_slv15_ack    ),
	.mst6_slv15_base   (mst6_slv15_base   ),
	.mst6_slv15_grant  (mst6_slv15_grant  ),
	.mst6_slv15_haddr  (mst6_slv15_haddr  ),
	.mst6_slv15_hburst (mst6_slv15_hburst ),
	.mst6_slv15_hprot  (mst6_slv15_hprot  ),
	.mst6_slv15_hsize  (mst6_slv15_hsize  ),
	.mst6_slv15_htrans (mst6_slv15_htrans ),
	.mst6_slv15_hwrite (mst6_slv15_hwrite ),
	.mst6_slv15_req    (mst6_slv15_req    ),
	.mst6_slv15_sel    (mst6_slv15_sel    ),
	.mst6_slv15_size   (mst6_slv15_size   ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST7
   `ifdef ATCBMC200_AHB_SLV0
	.hm7_slv0_hwdata   (hm7_slv0_hwdata   ),
	.mst7_hs0_hrdata   (mst7_hs0_hrdata   ),
	.mst7_hs0_hready   (mst7_hs0_hready   ),
	.mst7_hs0_hresp    (mst7_hs0_hresp    ),
	.mst7_slv0_ack     (mst7_slv0_ack     ),
	.mst7_slv0_base    (mst7_slv0_base    ),
	.mst7_slv0_grant   (mst7_slv0_grant   ),
	.mst7_slv0_haddr   (mst7_slv0_haddr   ),
	.mst7_slv0_hburst  (mst7_slv0_hburst  ),
	.mst7_slv0_hprot   (mst7_slv0_hprot   ),
	.mst7_slv0_hsize   (mst7_slv0_hsize   ),
	.mst7_slv0_htrans  (mst7_slv0_htrans  ),
	.mst7_slv0_hwrite  (mst7_slv0_hwrite  ),
	.mst7_slv0_req     (mst7_slv0_req     ),
	.mst7_slv0_sel     (mst7_slv0_sel     ),
	.mst7_slv0_size    (mst7_slv0_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm7_slv1_hwdata   (hm7_slv1_hwdata   ),
	.mst7_hs1_hrdata   (mst7_hs1_hrdata   ),
	.mst7_hs1_hready   (mst7_hs1_hready   ),
	.mst7_hs1_hresp    (mst7_hs1_hresp    ),
	.mst7_slv1_ack     (mst7_slv1_ack     ),
	.mst7_slv1_base    (mst7_slv1_base    ),
	.mst7_slv1_grant   (mst7_slv1_grant   ),
	.mst7_slv1_haddr   (mst7_slv1_haddr   ),
	.mst7_slv1_hburst  (mst7_slv1_hburst  ),
	.mst7_slv1_hprot   (mst7_slv1_hprot   ),
	.mst7_slv1_hsize   (mst7_slv1_hsize   ),
	.mst7_slv1_htrans  (mst7_slv1_htrans  ),
	.mst7_slv1_hwrite  (mst7_slv1_hwrite  ),
	.mst7_slv1_req     (mst7_slv1_req     ),
	.mst7_slv1_sel     (mst7_slv1_sel     ),
	.mst7_slv1_size    (mst7_slv1_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm7_slv2_hwdata   (hm7_slv2_hwdata   ),
	.mst7_hs2_hrdata   (mst7_hs2_hrdata   ),
	.mst7_hs2_hready   (mst7_hs2_hready   ),
	.mst7_hs2_hresp    (mst7_hs2_hresp    ),
	.mst7_slv2_ack     (mst7_slv2_ack     ),
	.mst7_slv2_base    (mst7_slv2_base    ),
	.mst7_slv2_grant   (mst7_slv2_grant   ),
	.mst7_slv2_haddr   (mst7_slv2_haddr   ),
	.mst7_slv2_hburst  (mst7_slv2_hburst  ),
	.mst7_slv2_hprot   (mst7_slv2_hprot   ),
	.mst7_slv2_hsize   (mst7_slv2_hsize   ),
	.mst7_slv2_htrans  (mst7_slv2_htrans  ),
	.mst7_slv2_hwrite  (mst7_slv2_hwrite  ),
	.mst7_slv2_req     (mst7_slv2_req     ),
	.mst7_slv2_sel     (mst7_slv2_sel     ),
	.mst7_slv2_size    (mst7_slv2_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm7_slv3_hwdata   (hm7_slv3_hwdata   ),
	.mst7_hs3_hrdata   (mst7_hs3_hrdata   ),
	.mst7_hs3_hready   (mst7_hs3_hready   ),
	.mst7_hs3_hresp    (mst7_hs3_hresp    ),
	.mst7_slv3_ack     (mst7_slv3_ack     ),
	.mst7_slv3_base    (mst7_slv3_base    ),
	.mst7_slv3_grant   (mst7_slv3_grant   ),
	.mst7_slv3_haddr   (mst7_slv3_haddr   ),
	.mst7_slv3_hburst  (mst7_slv3_hburst  ),
	.mst7_slv3_hprot   (mst7_slv3_hprot   ),
	.mst7_slv3_hsize   (mst7_slv3_hsize   ),
	.mst7_slv3_htrans  (mst7_slv3_htrans  ),
	.mst7_slv3_hwrite  (mst7_slv3_hwrite  ),
	.mst7_slv3_req     (mst7_slv3_req     ),
	.mst7_slv3_sel     (mst7_slv3_sel     ),
	.mst7_slv3_size    (mst7_slv3_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm7_slv4_hwdata   (hm7_slv4_hwdata   ),
	.mst7_hs4_hrdata   (mst7_hs4_hrdata   ),
	.mst7_hs4_hready   (mst7_hs4_hready   ),
	.mst7_hs4_hresp    (mst7_hs4_hresp    ),
	.mst7_slv4_ack     (mst7_slv4_ack     ),
	.mst7_slv4_base    (mst7_slv4_base    ),
	.mst7_slv4_grant   (mst7_slv4_grant   ),
	.mst7_slv4_haddr   (mst7_slv4_haddr   ),
	.mst7_slv4_hburst  (mst7_slv4_hburst  ),
	.mst7_slv4_hprot   (mst7_slv4_hprot   ),
	.mst7_slv4_hsize   (mst7_slv4_hsize   ),
	.mst7_slv4_htrans  (mst7_slv4_htrans  ),
	.mst7_slv4_hwrite  (mst7_slv4_hwrite  ),
	.mst7_slv4_req     (mst7_slv4_req     ),
	.mst7_slv4_sel     (mst7_slv4_sel     ),
	.mst7_slv4_size    (mst7_slv4_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm7_slv5_hwdata   (hm7_slv5_hwdata   ),
	.mst7_hs5_hrdata   (mst7_hs5_hrdata   ),
	.mst7_hs5_hready   (mst7_hs5_hready   ),
	.mst7_hs5_hresp    (mst7_hs5_hresp    ),
	.mst7_slv5_ack     (mst7_slv5_ack     ),
	.mst7_slv5_base    (mst7_slv5_base    ),
	.mst7_slv5_grant   (mst7_slv5_grant   ),
	.mst7_slv5_haddr   (mst7_slv5_haddr   ),
	.mst7_slv5_hburst  (mst7_slv5_hburst  ),
	.mst7_slv5_hprot   (mst7_slv5_hprot   ),
	.mst7_slv5_hsize   (mst7_slv5_hsize   ),
	.mst7_slv5_htrans  (mst7_slv5_htrans  ),
	.mst7_slv5_hwrite  (mst7_slv5_hwrite  ),
	.mst7_slv5_req     (mst7_slv5_req     ),
	.mst7_slv5_sel     (mst7_slv5_sel     ),
	.mst7_slv5_size    (mst7_slv5_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm7_slv6_hwdata   (hm7_slv6_hwdata   ),
	.mst7_hs6_hrdata   (mst7_hs6_hrdata   ),
	.mst7_hs6_hready   (mst7_hs6_hready   ),
	.mst7_hs6_hresp    (mst7_hs6_hresp    ),
	.mst7_slv6_ack     (mst7_slv6_ack     ),
	.mst7_slv6_base    (mst7_slv6_base    ),
	.mst7_slv6_grant   (mst7_slv6_grant   ),
	.mst7_slv6_haddr   (mst7_slv6_haddr   ),
	.mst7_slv6_hburst  (mst7_slv6_hburst  ),
	.mst7_slv6_hprot   (mst7_slv6_hprot   ),
	.mst7_slv6_hsize   (mst7_slv6_hsize   ),
	.mst7_slv6_htrans  (mst7_slv6_htrans  ),
	.mst7_slv6_hwrite  (mst7_slv6_hwrite  ),
	.mst7_slv6_req     (mst7_slv6_req     ),
	.mst7_slv6_sel     (mst7_slv6_sel     ),
	.mst7_slv6_size    (mst7_slv6_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm7_slv7_hwdata   (hm7_slv7_hwdata   ),
	.mst7_hs7_hrdata   (mst7_hs7_hrdata   ),
	.mst7_hs7_hready   (mst7_hs7_hready   ),
	.mst7_hs7_hresp    (mst7_hs7_hresp    ),
	.mst7_slv7_ack     (mst7_slv7_ack     ),
	.mst7_slv7_base    (mst7_slv7_base    ),
	.mst7_slv7_grant   (mst7_slv7_grant   ),
	.mst7_slv7_haddr   (mst7_slv7_haddr   ),
	.mst7_slv7_hburst  (mst7_slv7_hburst  ),
	.mst7_slv7_hprot   (mst7_slv7_hprot   ),
	.mst7_slv7_hsize   (mst7_slv7_hsize   ),
	.mst7_slv7_htrans  (mst7_slv7_htrans  ),
	.mst7_slv7_hwrite  (mst7_slv7_hwrite  ),
	.mst7_slv7_req     (mst7_slv7_req     ),
	.mst7_slv7_sel     (mst7_slv7_sel     ),
	.mst7_slv7_size    (mst7_slv7_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm7_slv8_hwdata   (hm7_slv8_hwdata   ),
	.mst7_hs8_hrdata   (mst7_hs8_hrdata   ),
	.mst7_hs8_hready   (mst7_hs8_hready   ),
	.mst7_hs8_hresp    (mst7_hs8_hresp    ),
	.mst7_slv8_ack     (mst7_slv8_ack     ),
	.mst7_slv8_base    (mst7_slv8_base    ),
	.mst7_slv8_grant   (mst7_slv8_grant   ),
	.mst7_slv8_haddr   (mst7_slv8_haddr   ),
	.mst7_slv8_hburst  (mst7_slv8_hburst  ),
	.mst7_slv8_hprot   (mst7_slv8_hprot   ),
	.mst7_slv8_hsize   (mst7_slv8_hsize   ),
	.mst7_slv8_htrans  (mst7_slv8_htrans  ),
	.mst7_slv8_hwrite  (mst7_slv8_hwrite  ),
	.mst7_slv8_req     (mst7_slv8_req     ),
	.mst7_slv8_sel     (mst7_slv8_sel     ),
	.mst7_slv8_size    (mst7_slv8_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm7_slv9_hwdata   (hm7_slv9_hwdata   ),
	.mst7_hs9_hrdata   (mst7_hs9_hrdata   ),
	.mst7_hs9_hready   (mst7_hs9_hready   ),
	.mst7_hs9_hresp    (mst7_hs9_hresp    ),
	.mst7_slv9_ack     (mst7_slv9_ack     ),
	.mst7_slv9_base    (mst7_slv9_base    ),
	.mst7_slv9_grant   (mst7_slv9_grant   ),
	.mst7_slv9_haddr   (mst7_slv9_haddr   ),
	.mst7_slv9_hburst  (mst7_slv9_hburst  ),
	.mst7_slv9_hprot   (mst7_slv9_hprot   ),
	.mst7_slv9_hsize   (mst7_slv9_hsize   ),
	.mst7_slv9_htrans  (mst7_slv9_htrans  ),
	.mst7_slv9_hwrite  (mst7_slv9_hwrite  ),
	.mst7_slv9_req     (mst7_slv9_req     ),
	.mst7_slv9_sel     (mst7_slv9_sel     ),
	.mst7_slv9_size    (mst7_slv9_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm7_slv10_hwdata  (hm7_slv10_hwdata  ),
	.mst7_hs10_hrdata  (mst7_hs10_hrdata  ),
	.mst7_hs10_hready  (mst7_hs10_hready  ),
	.mst7_hs10_hresp   (mst7_hs10_hresp   ),
	.mst7_slv10_ack    (mst7_slv10_ack    ),
	.mst7_slv10_base   (mst7_slv10_base   ),
	.mst7_slv10_grant  (mst7_slv10_grant  ),
	.mst7_slv10_haddr  (mst7_slv10_haddr  ),
	.mst7_slv10_hburst (mst7_slv10_hburst ),
	.mst7_slv10_hprot  (mst7_slv10_hprot  ),
	.mst7_slv10_hsize  (mst7_slv10_hsize  ),
	.mst7_slv10_htrans (mst7_slv10_htrans ),
	.mst7_slv10_hwrite (mst7_slv10_hwrite ),
	.mst7_slv10_req    (mst7_slv10_req    ),
	.mst7_slv10_sel    (mst7_slv10_sel    ),
	.mst7_slv10_size   (mst7_slv10_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm7_slv11_hwdata  (hm7_slv11_hwdata  ),
	.mst7_hs11_hrdata  (mst7_hs11_hrdata  ),
	.mst7_hs11_hready  (mst7_hs11_hready  ),
	.mst7_hs11_hresp   (mst7_hs11_hresp   ),
	.mst7_slv11_ack    (mst7_slv11_ack    ),
	.mst7_slv11_base   (mst7_slv11_base   ),
	.mst7_slv11_grant  (mst7_slv11_grant  ),
	.mst7_slv11_haddr  (mst7_slv11_haddr  ),
	.mst7_slv11_hburst (mst7_slv11_hburst ),
	.mst7_slv11_hprot  (mst7_slv11_hprot  ),
	.mst7_slv11_hsize  (mst7_slv11_hsize  ),
	.mst7_slv11_htrans (mst7_slv11_htrans ),
	.mst7_slv11_hwrite (mst7_slv11_hwrite ),
	.mst7_slv11_req    (mst7_slv11_req    ),
	.mst7_slv11_sel    (mst7_slv11_sel    ),
	.mst7_slv11_size   (mst7_slv11_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm7_slv12_hwdata  (hm7_slv12_hwdata  ),
	.mst7_hs12_hrdata  (mst7_hs12_hrdata  ),
	.mst7_hs12_hready  (mst7_hs12_hready  ),
	.mst7_hs12_hresp   (mst7_hs12_hresp   ),
	.mst7_slv12_ack    (mst7_slv12_ack    ),
	.mst7_slv12_base   (mst7_slv12_base   ),
	.mst7_slv12_grant  (mst7_slv12_grant  ),
	.mst7_slv12_haddr  (mst7_slv12_haddr  ),
	.mst7_slv12_hburst (mst7_slv12_hburst ),
	.mst7_slv12_hprot  (mst7_slv12_hprot  ),
	.mst7_slv12_hsize  (mst7_slv12_hsize  ),
	.mst7_slv12_htrans (mst7_slv12_htrans ),
	.mst7_slv12_hwrite (mst7_slv12_hwrite ),
	.mst7_slv12_req    (mst7_slv12_req    ),
	.mst7_slv12_sel    (mst7_slv12_sel    ),
	.mst7_slv12_size   (mst7_slv12_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm7_slv13_hwdata  (hm7_slv13_hwdata  ),
	.mst7_hs13_hrdata  (mst7_hs13_hrdata  ),
	.mst7_hs13_hready  (mst7_hs13_hready  ),
	.mst7_hs13_hresp   (mst7_hs13_hresp   ),
	.mst7_slv13_ack    (mst7_slv13_ack    ),
	.mst7_slv13_base   (mst7_slv13_base   ),
	.mst7_slv13_grant  (mst7_slv13_grant  ),
	.mst7_slv13_haddr  (mst7_slv13_haddr  ),
	.mst7_slv13_hburst (mst7_slv13_hburst ),
	.mst7_slv13_hprot  (mst7_slv13_hprot  ),
	.mst7_slv13_hsize  (mst7_slv13_hsize  ),
	.mst7_slv13_htrans (mst7_slv13_htrans ),
	.mst7_slv13_hwrite (mst7_slv13_hwrite ),
	.mst7_slv13_req    (mst7_slv13_req    ),
	.mst7_slv13_sel    (mst7_slv13_sel    ),
	.mst7_slv13_size   (mst7_slv13_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm7_slv14_hwdata  (hm7_slv14_hwdata  ),
	.mst7_hs14_hrdata  (mst7_hs14_hrdata  ),
	.mst7_hs14_hready  (mst7_hs14_hready  ),
	.mst7_hs14_hresp   (mst7_hs14_hresp   ),
	.mst7_slv14_ack    (mst7_slv14_ack    ),
	.mst7_slv14_base   (mst7_slv14_base   ),
	.mst7_slv14_grant  (mst7_slv14_grant  ),
	.mst7_slv14_haddr  (mst7_slv14_haddr  ),
	.mst7_slv14_hburst (mst7_slv14_hburst ),
	.mst7_slv14_hprot  (mst7_slv14_hprot  ),
	.mst7_slv14_hsize  (mst7_slv14_hsize  ),
	.mst7_slv14_htrans (mst7_slv14_htrans ),
	.mst7_slv14_hwrite (mst7_slv14_hwrite ),
	.mst7_slv14_req    (mst7_slv14_req    ),
	.mst7_slv14_sel    (mst7_slv14_sel    ),
	.mst7_slv14_size   (mst7_slv14_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm7_slv15_hwdata  (hm7_slv15_hwdata  ),
	.mst7_hs15_hrdata  (mst7_hs15_hrdata  ),
	.mst7_hs15_hready  (mst7_hs15_hready  ),
	.mst7_hs15_hresp   (mst7_hs15_hresp   ),
	.mst7_slv15_ack    (mst7_slv15_ack    ),
	.mst7_slv15_base   (mst7_slv15_base   ),
	.mst7_slv15_grant  (mst7_slv15_grant  ),
	.mst7_slv15_haddr  (mst7_slv15_haddr  ),
	.mst7_slv15_hburst (mst7_slv15_hburst ),
	.mst7_slv15_hprot  (mst7_slv15_hprot  ),
	.mst7_slv15_hsize  (mst7_slv15_hsize  ),
	.mst7_slv15_htrans (mst7_slv15_htrans ),
	.mst7_slv15_hwrite (mst7_slv15_hwrite ),
	.mst7_slv15_req    (mst7_slv15_req    ),
	.mst7_slv15_sel    (mst7_slv15_sel    ),
	.mst7_slv15_size   (mst7_slv15_size   ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST8
   `ifdef ATCBMC200_AHB_SLV0
	.hm8_slv0_hwdata   (hm8_slv0_hwdata   ),
	.mst8_hs0_hrdata   (mst8_hs0_hrdata   ),
	.mst8_hs0_hready   (mst8_hs0_hready   ),
	.mst8_hs0_hresp    (mst8_hs0_hresp    ),
	.mst8_slv0_ack     (mst8_slv0_ack     ),
	.mst8_slv0_base    (mst8_slv0_base    ),
	.mst8_slv0_grant   (mst8_slv0_grant   ),
	.mst8_slv0_haddr   (mst8_slv0_haddr   ),
	.mst8_slv0_hburst  (mst8_slv0_hburst  ),
	.mst8_slv0_hprot   (mst8_slv0_hprot   ),
	.mst8_slv0_hsize   (mst8_slv0_hsize   ),
	.mst8_slv0_htrans  (mst8_slv0_htrans  ),
	.mst8_slv0_hwrite  (mst8_slv0_hwrite  ),
	.mst8_slv0_req     (mst8_slv0_req     ),
	.mst8_slv0_sel     (mst8_slv0_sel     ),
	.mst8_slv0_size    (mst8_slv0_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm8_slv1_hwdata   (hm8_slv1_hwdata   ),
	.mst8_hs1_hrdata   (mst8_hs1_hrdata   ),
	.mst8_hs1_hready   (mst8_hs1_hready   ),
	.mst8_hs1_hresp    (mst8_hs1_hresp    ),
	.mst8_slv1_ack     (mst8_slv1_ack     ),
	.mst8_slv1_base    (mst8_slv1_base    ),
	.mst8_slv1_grant   (mst8_slv1_grant   ),
	.mst8_slv1_haddr   (mst8_slv1_haddr   ),
	.mst8_slv1_hburst  (mst8_slv1_hburst  ),
	.mst8_slv1_hprot   (mst8_slv1_hprot   ),
	.mst8_slv1_hsize   (mst8_slv1_hsize   ),
	.mst8_slv1_htrans  (mst8_slv1_htrans  ),
	.mst8_slv1_hwrite  (mst8_slv1_hwrite  ),
	.mst8_slv1_req     (mst8_slv1_req     ),
	.mst8_slv1_sel     (mst8_slv1_sel     ),
	.mst8_slv1_size    (mst8_slv1_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm8_slv2_hwdata   (hm8_slv2_hwdata   ),
	.mst8_hs2_hrdata   (mst8_hs2_hrdata   ),
	.mst8_hs2_hready   (mst8_hs2_hready   ),
	.mst8_hs2_hresp    (mst8_hs2_hresp    ),
	.mst8_slv2_ack     (mst8_slv2_ack     ),
	.mst8_slv2_base    (mst8_slv2_base    ),
	.mst8_slv2_grant   (mst8_slv2_grant   ),
	.mst8_slv2_haddr   (mst8_slv2_haddr   ),
	.mst8_slv2_hburst  (mst8_slv2_hburst  ),
	.mst8_slv2_hprot   (mst8_slv2_hprot   ),
	.mst8_slv2_hsize   (mst8_slv2_hsize   ),
	.mst8_slv2_htrans  (mst8_slv2_htrans  ),
	.mst8_slv2_hwrite  (mst8_slv2_hwrite  ),
	.mst8_slv2_req     (mst8_slv2_req     ),
	.mst8_slv2_sel     (mst8_slv2_sel     ),
	.mst8_slv2_size    (mst8_slv2_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm8_slv3_hwdata   (hm8_slv3_hwdata   ),
	.mst8_hs3_hrdata   (mst8_hs3_hrdata   ),
	.mst8_hs3_hready   (mst8_hs3_hready   ),
	.mst8_hs3_hresp    (mst8_hs3_hresp    ),
	.mst8_slv3_ack     (mst8_slv3_ack     ),
	.mst8_slv3_base    (mst8_slv3_base    ),
	.mst8_slv3_grant   (mst8_slv3_grant   ),
	.mst8_slv3_haddr   (mst8_slv3_haddr   ),
	.mst8_slv3_hburst  (mst8_slv3_hburst  ),
	.mst8_slv3_hprot   (mst8_slv3_hprot   ),
	.mst8_slv3_hsize   (mst8_slv3_hsize   ),
	.mst8_slv3_htrans  (mst8_slv3_htrans  ),
	.mst8_slv3_hwrite  (mst8_slv3_hwrite  ),
	.mst8_slv3_req     (mst8_slv3_req     ),
	.mst8_slv3_sel     (mst8_slv3_sel     ),
	.mst8_slv3_size    (mst8_slv3_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm8_slv4_hwdata   (hm8_slv4_hwdata   ),
	.mst8_hs4_hrdata   (mst8_hs4_hrdata   ),
	.mst8_hs4_hready   (mst8_hs4_hready   ),
	.mst8_hs4_hresp    (mst8_hs4_hresp    ),
	.mst8_slv4_ack     (mst8_slv4_ack     ),
	.mst8_slv4_base    (mst8_slv4_base    ),
	.mst8_slv4_grant   (mst8_slv4_grant   ),
	.mst8_slv4_haddr   (mst8_slv4_haddr   ),
	.mst8_slv4_hburst  (mst8_slv4_hburst  ),
	.mst8_slv4_hprot   (mst8_slv4_hprot   ),
	.mst8_slv4_hsize   (mst8_slv4_hsize   ),
	.mst8_slv4_htrans  (mst8_slv4_htrans  ),
	.mst8_slv4_hwrite  (mst8_slv4_hwrite  ),
	.mst8_slv4_req     (mst8_slv4_req     ),
	.mst8_slv4_sel     (mst8_slv4_sel     ),
	.mst8_slv4_size    (mst8_slv4_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm8_slv5_hwdata   (hm8_slv5_hwdata   ),
	.mst8_hs5_hrdata   (mst8_hs5_hrdata   ),
	.mst8_hs5_hready   (mst8_hs5_hready   ),
	.mst8_hs5_hresp    (mst8_hs5_hresp    ),
	.mst8_slv5_ack     (mst8_slv5_ack     ),
	.mst8_slv5_base    (mst8_slv5_base    ),
	.mst8_slv5_grant   (mst8_slv5_grant   ),
	.mst8_slv5_haddr   (mst8_slv5_haddr   ),
	.mst8_slv5_hburst  (mst8_slv5_hburst  ),
	.mst8_slv5_hprot   (mst8_slv5_hprot   ),
	.mst8_slv5_hsize   (mst8_slv5_hsize   ),
	.mst8_slv5_htrans  (mst8_slv5_htrans  ),
	.mst8_slv5_hwrite  (mst8_slv5_hwrite  ),
	.mst8_slv5_req     (mst8_slv5_req     ),
	.mst8_slv5_sel     (mst8_slv5_sel     ),
	.mst8_slv5_size    (mst8_slv5_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm8_slv6_hwdata   (hm8_slv6_hwdata   ),
	.mst8_hs6_hrdata   (mst8_hs6_hrdata   ),
	.mst8_hs6_hready   (mst8_hs6_hready   ),
	.mst8_hs6_hresp    (mst8_hs6_hresp    ),
	.mst8_slv6_ack     (mst8_slv6_ack     ),
	.mst8_slv6_base    (mst8_slv6_base    ),
	.mst8_slv6_grant   (mst8_slv6_grant   ),
	.mst8_slv6_haddr   (mst8_slv6_haddr   ),
	.mst8_slv6_hburst  (mst8_slv6_hburst  ),
	.mst8_slv6_hprot   (mst8_slv6_hprot   ),
	.mst8_slv6_hsize   (mst8_slv6_hsize   ),
	.mst8_slv6_htrans  (mst8_slv6_htrans  ),
	.mst8_slv6_hwrite  (mst8_slv6_hwrite  ),
	.mst8_slv6_req     (mst8_slv6_req     ),
	.mst8_slv6_sel     (mst8_slv6_sel     ),
	.mst8_slv6_size    (mst8_slv6_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm8_slv7_hwdata   (hm8_slv7_hwdata   ),
	.mst8_hs7_hrdata   (mst8_hs7_hrdata   ),
	.mst8_hs7_hready   (mst8_hs7_hready   ),
	.mst8_hs7_hresp    (mst8_hs7_hresp    ),
	.mst8_slv7_ack     (mst8_slv7_ack     ),
	.mst8_slv7_base    (mst8_slv7_base    ),
	.mst8_slv7_grant   (mst8_slv7_grant   ),
	.mst8_slv7_haddr   (mst8_slv7_haddr   ),
	.mst8_slv7_hburst  (mst8_slv7_hburst  ),
	.mst8_slv7_hprot   (mst8_slv7_hprot   ),
	.mst8_slv7_hsize   (mst8_slv7_hsize   ),
	.mst8_slv7_htrans  (mst8_slv7_htrans  ),
	.mst8_slv7_hwrite  (mst8_slv7_hwrite  ),
	.mst8_slv7_req     (mst8_slv7_req     ),
	.mst8_slv7_sel     (mst8_slv7_sel     ),
	.mst8_slv7_size    (mst8_slv7_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm8_slv8_hwdata   (hm8_slv8_hwdata   ),
	.mst8_hs8_hrdata   (mst8_hs8_hrdata   ),
	.mst8_hs8_hready   (mst8_hs8_hready   ),
	.mst8_hs8_hresp    (mst8_hs8_hresp    ),
	.mst8_slv8_ack     (mst8_slv8_ack     ),
	.mst8_slv8_base    (mst8_slv8_base    ),
	.mst8_slv8_grant   (mst8_slv8_grant   ),
	.mst8_slv8_haddr   (mst8_slv8_haddr   ),
	.mst8_slv8_hburst  (mst8_slv8_hburst  ),
	.mst8_slv8_hprot   (mst8_slv8_hprot   ),
	.mst8_slv8_hsize   (mst8_slv8_hsize   ),
	.mst8_slv8_htrans  (mst8_slv8_htrans  ),
	.mst8_slv8_hwrite  (mst8_slv8_hwrite  ),
	.mst8_slv8_req     (mst8_slv8_req     ),
	.mst8_slv8_sel     (mst8_slv8_sel     ),
	.mst8_slv8_size    (mst8_slv8_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm8_slv9_hwdata   (hm8_slv9_hwdata   ),
	.mst8_hs9_hrdata   (mst8_hs9_hrdata   ),
	.mst8_hs9_hready   (mst8_hs9_hready   ),
	.mst8_hs9_hresp    (mst8_hs9_hresp    ),
	.mst8_slv9_ack     (mst8_slv9_ack     ),
	.mst8_slv9_base    (mst8_slv9_base    ),
	.mst8_slv9_grant   (mst8_slv9_grant   ),
	.mst8_slv9_haddr   (mst8_slv9_haddr   ),
	.mst8_slv9_hburst  (mst8_slv9_hburst  ),
	.mst8_slv9_hprot   (mst8_slv9_hprot   ),
	.mst8_slv9_hsize   (mst8_slv9_hsize   ),
	.mst8_slv9_htrans  (mst8_slv9_htrans  ),
	.mst8_slv9_hwrite  (mst8_slv9_hwrite  ),
	.mst8_slv9_req     (mst8_slv9_req     ),
	.mst8_slv9_sel     (mst8_slv9_sel     ),
	.mst8_slv9_size    (mst8_slv9_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm8_slv10_hwdata  (hm8_slv10_hwdata  ),
	.mst8_hs10_hrdata  (mst8_hs10_hrdata  ),
	.mst8_hs10_hready  (mst8_hs10_hready  ),
	.mst8_hs10_hresp   (mst8_hs10_hresp   ),
	.mst8_slv10_ack    (mst8_slv10_ack    ),
	.mst8_slv10_base   (mst8_slv10_base   ),
	.mst8_slv10_grant  (mst8_slv10_grant  ),
	.mst8_slv10_haddr  (mst8_slv10_haddr  ),
	.mst8_slv10_hburst (mst8_slv10_hburst ),
	.mst8_slv10_hprot  (mst8_slv10_hprot  ),
	.mst8_slv10_hsize  (mst8_slv10_hsize  ),
	.mst8_slv10_htrans (mst8_slv10_htrans ),
	.mst8_slv10_hwrite (mst8_slv10_hwrite ),
	.mst8_slv10_req    (mst8_slv10_req    ),
	.mst8_slv10_sel    (mst8_slv10_sel    ),
	.mst8_slv10_size   (mst8_slv10_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm8_slv11_hwdata  (hm8_slv11_hwdata  ),
	.mst8_hs11_hrdata  (mst8_hs11_hrdata  ),
	.mst8_hs11_hready  (mst8_hs11_hready  ),
	.mst8_hs11_hresp   (mst8_hs11_hresp   ),
	.mst8_slv11_ack    (mst8_slv11_ack    ),
	.mst8_slv11_base   (mst8_slv11_base   ),
	.mst8_slv11_grant  (mst8_slv11_grant  ),
	.mst8_slv11_haddr  (mst8_slv11_haddr  ),
	.mst8_slv11_hburst (mst8_slv11_hburst ),
	.mst8_slv11_hprot  (mst8_slv11_hprot  ),
	.mst8_slv11_hsize  (mst8_slv11_hsize  ),
	.mst8_slv11_htrans (mst8_slv11_htrans ),
	.mst8_slv11_hwrite (mst8_slv11_hwrite ),
	.mst8_slv11_req    (mst8_slv11_req    ),
	.mst8_slv11_sel    (mst8_slv11_sel    ),
	.mst8_slv11_size   (mst8_slv11_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm8_slv12_hwdata  (hm8_slv12_hwdata  ),
	.mst8_hs12_hrdata  (mst8_hs12_hrdata  ),
	.mst8_hs12_hready  (mst8_hs12_hready  ),
	.mst8_hs12_hresp   (mst8_hs12_hresp   ),
	.mst8_slv12_ack    (mst8_slv12_ack    ),
	.mst8_slv12_base   (mst8_slv12_base   ),
	.mst8_slv12_grant  (mst8_slv12_grant  ),
	.mst8_slv12_haddr  (mst8_slv12_haddr  ),
	.mst8_slv12_hburst (mst8_slv12_hburst ),
	.mst8_slv12_hprot  (mst8_slv12_hprot  ),
	.mst8_slv12_hsize  (mst8_slv12_hsize  ),
	.mst8_slv12_htrans (mst8_slv12_htrans ),
	.mst8_slv12_hwrite (mst8_slv12_hwrite ),
	.mst8_slv12_req    (mst8_slv12_req    ),
	.mst8_slv12_sel    (mst8_slv12_sel    ),
	.mst8_slv12_size   (mst8_slv12_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm8_slv13_hwdata  (hm8_slv13_hwdata  ),
	.mst8_hs13_hrdata  (mst8_hs13_hrdata  ),
	.mst8_hs13_hready  (mst8_hs13_hready  ),
	.mst8_hs13_hresp   (mst8_hs13_hresp   ),
	.mst8_slv13_ack    (mst8_slv13_ack    ),
	.mst8_slv13_base   (mst8_slv13_base   ),
	.mst8_slv13_grant  (mst8_slv13_grant  ),
	.mst8_slv13_haddr  (mst8_slv13_haddr  ),
	.mst8_slv13_hburst (mst8_slv13_hburst ),
	.mst8_slv13_hprot  (mst8_slv13_hprot  ),
	.mst8_slv13_hsize  (mst8_slv13_hsize  ),
	.mst8_slv13_htrans (mst8_slv13_htrans ),
	.mst8_slv13_hwrite (mst8_slv13_hwrite ),
	.mst8_slv13_req    (mst8_slv13_req    ),
	.mst8_slv13_sel    (mst8_slv13_sel    ),
	.mst8_slv13_size   (mst8_slv13_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm8_slv14_hwdata  (hm8_slv14_hwdata  ),
	.mst8_hs14_hrdata  (mst8_hs14_hrdata  ),
	.mst8_hs14_hready  (mst8_hs14_hready  ),
	.mst8_hs14_hresp   (mst8_hs14_hresp   ),
	.mst8_slv14_ack    (mst8_slv14_ack    ),
	.mst8_slv14_base   (mst8_slv14_base   ),
	.mst8_slv14_grant  (mst8_slv14_grant  ),
	.mst8_slv14_haddr  (mst8_slv14_haddr  ),
	.mst8_slv14_hburst (mst8_slv14_hburst ),
	.mst8_slv14_hprot  (mst8_slv14_hprot  ),
	.mst8_slv14_hsize  (mst8_slv14_hsize  ),
	.mst8_slv14_htrans (mst8_slv14_htrans ),
	.mst8_slv14_hwrite (mst8_slv14_hwrite ),
	.mst8_slv14_req    (mst8_slv14_req    ),
	.mst8_slv14_sel    (mst8_slv14_sel    ),
	.mst8_slv14_size   (mst8_slv14_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm8_slv15_hwdata  (hm8_slv15_hwdata  ),
	.mst8_hs15_hrdata  (mst8_hs15_hrdata  ),
	.mst8_hs15_hready  (mst8_hs15_hready  ),
	.mst8_hs15_hresp   (mst8_hs15_hresp   ),
	.mst8_slv15_ack    (mst8_slv15_ack    ),
	.mst8_slv15_base   (mst8_slv15_base   ),
	.mst8_slv15_grant  (mst8_slv15_grant  ),
	.mst8_slv15_haddr  (mst8_slv15_haddr  ),
	.mst8_slv15_hburst (mst8_slv15_hburst ),
	.mst8_slv15_hprot  (mst8_slv15_hprot  ),
	.mst8_slv15_hsize  (mst8_slv15_hsize  ),
	.mst8_slv15_htrans (mst8_slv15_htrans ),
	.mst8_slv15_hwrite (mst8_slv15_hwrite ),
	.mst8_slv15_req    (mst8_slv15_req    ),
	.mst8_slv15_sel    (mst8_slv15_sel    ),
	.mst8_slv15_size   (mst8_slv15_size   ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST9
   `ifdef ATCBMC200_AHB_SLV0
	.hm9_slv0_hwdata   (hm9_slv0_hwdata   ),
	.mst9_hs0_hrdata   (mst9_hs0_hrdata   ),
	.mst9_hs0_hready   (mst9_hs0_hready   ),
	.mst9_hs0_hresp    (mst9_hs0_hresp    ),
	.mst9_slv0_ack     (mst9_slv0_ack     ),
	.mst9_slv0_base    (mst9_slv0_base    ),
	.mst9_slv0_grant   (mst9_slv0_grant   ),
	.mst9_slv0_haddr   (mst9_slv0_haddr   ),
	.mst9_slv0_hburst  (mst9_slv0_hburst  ),
	.mst9_slv0_hprot   (mst9_slv0_hprot   ),
	.mst9_slv0_hsize   (mst9_slv0_hsize   ),
	.mst9_slv0_htrans  (mst9_slv0_htrans  ),
	.mst9_slv0_hwrite  (mst9_slv0_hwrite  ),
	.mst9_slv0_req     (mst9_slv0_req     ),
	.mst9_slv0_sel     (mst9_slv0_sel     ),
	.mst9_slv0_size    (mst9_slv0_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm9_slv1_hwdata   (hm9_slv1_hwdata   ),
	.mst9_hs1_hrdata   (mst9_hs1_hrdata   ),
	.mst9_hs1_hready   (mst9_hs1_hready   ),
	.mst9_hs1_hresp    (mst9_hs1_hresp    ),
	.mst9_slv1_ack     (mst9_slv1_ack     ),
	.mst9_slv1_base    (mst9_slv1_base    ),
	.mst9_slv1_grant   (mst9_slv1_grant   ),
	.mst9_slv1_haddr   (mst9_slv1_haddr   ),
	.mst9_slv1_hburst  (mst9_slv1_hburst  ),
	.mst9_slv1_hprot   (mst9_slv1_hprot   ),
	.mst9_slv1_hsize   (mst9_slv1_hsize   ),
	.mst9_slv1_htrans  (mst9_slv1_htrans  ),
	.mst9_slv1_hwrite  (mst9_slv1_hwrite  ),
	.mst9_slv1_req     (mst9_slv1_req     ),
	.mst9_slv1_sel     (mst9_slv1_sel     ),
	.mst9_slv1_size    (mst9_slv1_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm9_slv2_hwdata   (hm9_slv2_hwdata   ),
	.mst9_hs2_hrdata   (mst9_hs2_hrdata   ),
	.mst9_hs2_hready   (mst9_hs2_hready   ),
	.mst9_hs2_hresp    (mst9_hs2_hresp    ),
	.mst9_slv2_ack     (mst9_slv2_ack     ),
	.mst9_slv2_base    (mst9_slv2_base    ),
	.mst9_slv2_grant   (mst9_slv2_grant   ),
	.mst9_slv2_haddr   (mst9_slv2_haddr   ),
	.mst9_slv2_hburst  (mst9_slv2_hburst  ),
	.mst9_slv2_hprot   (mst9_slv2_hprot   ),
	.mst9_slv2_hsize   (mst9_slv2_hsize   ),
	.mst9_slv2_htrans  (mst9_slv2_htrans  ),
	.mst9_slv2_hwrite  (mst9_slv2_hwrite  ),
	.mst9_slv2_req     (mst9_slv2_req     ),
	.mst9_slv2_sel     (mst9_slv2_sel     ),
	.mst9_slv2_size    (mst9_slv2_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm9_slv3_hwdata   (hm9_slv3_hwdata   ),
	.mst9_hs3_hrdata   (mst9_hs3_hrdata   ),
	.mst9_hs3_hready   (mst9_hs3_hready   ),
	.mst9_hs3_hresp    (mst9_hs3_hresp    ),
	.mst9_slv3_ack     (mst9_slv3_ack     ),
	.mst9_slv3_base    (mst9_slv3_base    ),
	.mst9_slv3_grant   (mst9_slv3_grant   ),
	.mst9_slv3_haddr   (mst9_slv3_haddr   ),
	.mst9_slv3_hburst  (mst9_slv3_hburst  ),
	.mst9_slv3_hprot   (mst9_slv3_hprot   ),
	.mst9_slv3_hsize   (mst9_slv3_hsize   ),
	.mst9_slv3_htrans  (mst9_slv3_htrans  ),
	.mst9_slv3_hwrite  (mst9_slv3_hwrite  ),
	.mst9_slv3_req     (mst9_slv3_req     ),
	.mst9_slv3_sel     (mst9_slv3_sel     ),
	.mst9_slv3_size    (mst9_slv3_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm9_slv4_hwdata   (hm9_slv4_hwdata   ),
	.mst9_hs4_hrdata   (mst9_hs4_hrdata   ),
	.mst9_hs4_hready   (mst9_hs4_hready   ),
	.mst9_hs4_hresp    (mst9_hs4_hresp    ),
	.mst9_slv4_ack     (mst9_slv4_ack     ),
	.mst9_slv4_base    (mst9_slv4_base    ),
	.mst9_slv4_grant   (mst9_slv4_grant   ),
	.mst9_slv4_haddr   (mst9_slv4_haddr   ),
	.mst9_slv4_hburst  (mst9_slv4_hburst  ),
	.mst9_slv4_hprot   (mst9_slv4_hprot   ),
	.mst9_slv4_hsize   (mst9_slv4_hsize   ),
	.mst9_slv4_htrans  (mst9_slv4_htrans  ),
	.mst9_slv4_hwrite  (mst9_slv4_hwrite  ),
	.mst9_slv4_req     (mst9_slv4_req     ),
	.mst9_slv4_sel     (mst9_slv4_sel     ),
	.mst9_slv4_size    (mst9_slv4_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm9_slv5_hwdata   (hm9_slv5_hwdata   ),
	.mst9_hs5_hrdata   (mst9_hs5_hrdata   ),
	.mst9_hs5_hready   (mst9_hs5_hready   ),
	.mst9_hs5_hresp    (mst9_hs5_hresp    ),
	.mst9_slv5_ack     (mst9_slv5_ack     ),
	.mst9_slv5_base    (mst9_slv5_base    ),
	.mst9_slv5_grant   (mst9_slv5_grant   ),
	.mst9_slv5_haddr   (mst9_slv5_haddr   ),
	.mst9_slv5_hburst  (mst9_slv5_hburst  ),
	.mst9_slv5_hprot   (mst9_slv5_hprot   ),
	.mst9_slv5_hsize   (mst9_slv5_hsize   ),
	.mst9_slv5_htrans  (mst9_slv5_htrans  ),
	.mst9_slv5_hwrite  (mst9_slv5_hwrite  ),
	.mst9_slv5_req     (mst9_slv5_req     ),
	.mst9_slv5_sel     (mst9_slv5_sel     ),
	.mst9_slv5_size    (mst9_slv5_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm9_slv6_hwdata   (hm9_slv6_hwdata   ),
	.mst9_hs6_hrdata   (mst9_hs6_hrdata   ),
	.mst9_hs6_hready   (mst9_hs6_hready   ),
	.mst9_hs6_hresp    (mst9_hs6_hresp    ),
	.mst9_slv6_ack     (mst9_slv6_ack     ),
	.mst9_slv6_base    (mst9_slv6_base    ),
	.mst9_slv6_grant   (mst9_slv6_grant   ),
	.mst9_slv6_haddr   (mst9_slv6_haddr   ),
	.mst9_slv6_hburst  (mst9_slv6_hburst  ),
	.mst9_slv6_hprot   (mst9_slv6_hprot   ),
	.mst9_slv6_hsize   (mst9_slv6_hsize   ),
	.mst9_slv6_htrans  (mst9_slv6_htrans  ),
	.mst9_slv6_hwrite  (mst9_slv6_hwrite  ),
	.mst9_slv6_req     (mst9_slv6_req     ),
	.mst9_slv6_sel     (mst9_slv6_sel     ),
	.mst9_slv6_size    (mst9_slv6_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm9_slv7_hwdata   (hm9_slv7_hwdata   ),
	.mst9_hs7_hrdata   (mst9_hs7_hrdata   ),
	.mst9_hs7_hready   (mst9_hs7_hready   ),
	.mst9_hs7_hresp    (mst9_hs7_hresp    ),
	.mst9_slv7_ack     (mst9_slv7_ack     ),
	.mst9_slv7_base    (mst9_slv7_base    ),
	.mst9_slv7_grant   (mst9_slv7_grant   ),
	.mst9_slv7_haddr   (mst9_slv7_haddr   ),
	.mst9_slv7_hburst  (mst9_slv7_hburst  ),
	.mst9_slv7_hprot   (mst9_slv7_hprot   ),
	.mst9_slv7_hsize   (mst9_slv7_hsize   ),
	.mst9_slv7_htrans  (mst9_slv7_htrans  ),
	.mst9_slv7_hwrite  (mst9_slv7_hwrite  ),
	.mst9_slv7_req     (mst9_slv7_req     ),
	.mst9_slv7_sel     (mst9_slv7_sel     ),
	.mst9_slv7_size    (mst9_slv7_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm9_slv8_hwdata   (hm9_slv8_hwdata   ),
	.mst9_hs8_hrdata   (mst9_hs8_hrdata   ),
	.mst9_hs8_hready   (mst9_hs8_hready   ),
	.mst9_hs8_hresp    (mst9_hs8_hresp    ),
	.mst9_slv8_ack     (mst9_slv8_ack     ),
	.mst9_slv8_base    (mst9_slv8_base    ),
	.mst9_slv8_grant   (mst9_slv8_grant   ),
	.mst9_slv8_haddr   (mst9_slv8_haddr   ),
	.mst9_slv8_hburst  (mst9_slv8_hburst  ),
	.mst9_slv8_hprot   (mst9_slv8_hprot   ),
	.mst9_slv8_hsize   (mst9_slv8_hsize   ),
	.mst9_slv8_htrans  (mst9_slv8_htrans  ),
	.mst9_slv8_hwrite  (mst9_slv8_hwrite  ),
	.mst9_slv8_req     (mst9_slv8_req     ),
	.mst9_slv8_sel     (mst9_slv8_sel     ),
	.mst9_slv8_size    (mst9_slv8_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm9_slv9_hwdata   (hm9_slv9_hwdata   ),
	.mst9_hs9_hrdata   (mst9_hs9_hrdata   ),
	.mst9_hs9_hready   (mst9_hs9_hready   ),
	.mst9_hs9_hresp    (mst9_hs9_hresp    ),
	.mst9_slv9_ack     (mst9_slv9_ack     ),
	.mst9_slv9_base    (mst9_slv9_base    ),
	.mst9_slv9_grant   (mst9_slv9_grant   ),
	.mst9_slv9_haddr   (mst9_slv9_haddr   ),
	.mst9_slv9_hburst  (mst9_slv9_hburst  ),
	.mst9_slv9_hprot   (mst9_slv9_hprot   ),
	.mst9_slv9_hsize   (mst9_slv9_hsize   ),
	.mst9_slv9_htrans  (mst9_slv9_htrans  ),
	.mst9_slv9_hwrite  (mst9_slv9_hwrite  ),
	.mst9_slv9_req     (mst9_slv9_req     ),
	.mst9_slv9_sel     (mst9_slv9_sel     ),
	.mst9_slv9_size    (mst9_slv9_size    ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm9_slv10_hwdata  (hm9_slv10_hwdata  ),
	.mst9_hs10_hrdata  (mst9_hs10_hrdata  ),
	.mst9_hs10_hready  (mst9_hs10_hready  ),
	.mst9_hs10_hresp   (mst9_hs10_hresp   ),
	.mst9_slv10_ack    (mst9_slv10_ack    ),
	.mst9_slv10_base   (mst9_slv10_base   ),
	.mst9_slv10_grant  (mst9_slv10_grant  ),
	.mst9_slv10_haddr  (mst9_slv10_haddr  ),
	.mst9_slv10_hburst (mst9_slv10_hburst ),
	.mst9_slv10_hprot  (mst9_slv10_hprot  ),
	.mst9_slv10_hsize  (mst9_slv10_hsize  ),
	.mst9_slv10_htrans (mst9_slv10_htrans ),
	.mst9_slv10_hwrite (mst9_slv10_hwrite ),
	.mst9_slv10_req    (mst9_slv10_req    ),
	.mst9_slv10_sel    (mst9_slv10_sel    ),
	.mst9_slv10_size   (mst9_slv10_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm9_slv11_hwdata  (hm9_slv11_hwdata  ),
	.mst9_hs11_hrdata  (mst9_hs11_hrdata  ),
	.mst9_hs11_hready  (mst9_hs11_hready  ),
	.mst9_hs11_hresp   (mst9_hs11_hresp   ),
	.mst9_slv11_ack    (mst9_slv11_ack    ),
	.mst9_slv11_base   (mst9_slv11_base   ),
	.mst9_slv11_grant  (mst9_slv11_grant  ),
	.mst9_slv11_haddr  (mst9_slv11_haddr  ),
	.mst9_slv11_hburst (mst9_slv11_hburst ),
	.mst9_slv11_hprot  (mst9_slv11_hprot  ),
	.mst9_slv11_hsize  (mst9_slv11_hsize  ),
	.mst9_slv11_htrans (mst9_slv11_htrans ),
	.mst9_slv11_hwrite (mst9_slv11_hwrite ),
	.mst9_slv11_req    (mst9_slv11_req    ),
	.mst9_slv11_sel    (mst9_slv11_sel    ),
	.mst9_slv11_size   (mst9_slv11_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm9_slv12_hwdata  (hm9_slv12_hwdata  ),
	.mst9_hs12_hrdata  (mst9_hs12_hrdata  ),
	.mst9_hs12_hready  (mst9_hs12_hready  ),
	.mst9_hs12_hresp   (mst9_hs12_hresp   ),
	.mst9_slv12_ack    (mst9_slv12_ack    ),
	.mst9_slv12_base   (mst9_slv12_base   ),
	.mst9_slv12_grant  (mst9_slv12_grant  ),
	.mst9_slv12_haddr  (mst9_slv12_haddr  ),
	.mst9_slv12_hburst (mst9_slv12_hburst ),
	.mst9_slv12_hprot  (mst9_slv12_hprot  ),
	.mst9_slv12_hsize  (mst9_slv12_hsize  ),
	.mst9_slv12_htrans (mst9_slv12_htrans ),
	.mst9_slv12_hwrite (mst9_slv12_hwrite ),
	.mst9_slv12_req    (mst9_slv12_req    ),
	.mst9_slv12_sel    (mst9_slv12_sel    ),
	.mst9_slv12_size   (mst9_slv12_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm9_slv13_hwdata  (hm9_slv13_hwdata  ),
	.mst9_hs13_hrdata  (mst9_hs13_hrdata  ),
	.mst9_hs13_hready  (mst9_hs13_hready  ),
	.mst9_hs13_hresp   (mst9_hs13_hresp   ),
	.mst9_slv13_ack    (mst9_slv13_ack    ),
	.mst9_slv13_base   (mst9_slv13_base   ),
	.mst9_slv13_grant  (mst9_slv13_grant  ),
	.mst9_slv13_haddr  (mst9_slv13_haddr  ),
	.mst9_slv13_hburst (mst9_slv13_hburst ),
	.mst9_slv13_hprot  (mst9_slv13_hprot  ),
	.mst9_slv13_hsize  (mst9_slv13_hsize  ),
	.mst9_slv13_htrans (mst9_slv13_htrans ),
	.mst9_slv13_hwrite (mst9_slv13_hwrite ),
	.mst9_slv13_req    (mst9_slv13_req    ),
	.mst9_slv13_sel    (mst9_slv13_sel    ),
	.mst9_slv13_size   (mst9_slv13_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm9_slv14_hwdata  (hm9_slv14_hwdata  ),
	.mst9_hs14_hrdata  (mst9_hs14_hrdata  ),
	.mst9_hs14_hready  (mst9_hs14_hready  ),
	.mst9_hs14_hresp   (mst9_hs14_hresp   ),
	.mst9_slv14_ack    (mst9_slv14_ack    ),
	.mst9_slv14_base   (mst9_slv14_base   ),
	.mst9_slv14_grant  (mst9_slv14_grant  ),
	.mst9_slv14_haddr  (mst9_slv14_haddr  ),
	.mst9_slv14_hburst (mst9_slv14_hburst ),
	.mst9_slv14_hprot  (mst9_slv14_hprot  ),
	.mst9_slv14_hsize  (mst9_slv14_hsize  ),
	.mst9_slv14_htrans (mst9_slv14_htrans ),
	.mst9_slv14_hwrite (mst9_slv14_hwrite ),
	.mst9_slv14_req    (mst9_slv14_req    ),
	.mst9_slv14_sel    (mst9_slv14_sel    ),
	.mst9_slv14_size   (mst9_slv14_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm9_slv15_hwdata  (hm9_slv15_hwdata  ),
	.mst9_hs15_hrdata  (mst9_hs15_hrdata  ),
	.mst9_hs15_hready  (mst9_hs15_hready  ),
	.mst9_hs15_hresp   (mst9_hs15_hresp   ),
	.mst9_slv15_ack    (mst9_slv15_ack    ),
	.mst9_slv15_base   (mst9_slv15_base   ),
	.mst9_slv15_grant  (mst9_slv15_grant  ),
	.mst9_slv15_haddr  (mst9_slv15_haddr  ),
	.mst9_slv15_hburst (mst9_slv15_hburst ),
	.mst9_slv15_hprot  (mst9_slv15_hprot  ),
	.mst9_slv15_hsize  (mst9_slv15_hsize  ),
	.mst9_slv15_htrans (mst9_slv15_htrans ),
	.mst9_slv15_hwrite (mst9_slv15_hwrite ),
	.mst9_slv15_req    (mst9_slv15_req    ),
	.mst9_slv15_sel    (mst9_slv15_sel    ),
	.mst9_slv15_size   (mst9_slv15_size   ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST10
   `ifdef ATCBMC200_AHB_SLV0
	.hm10_slv0_hwdata  (hm10_slv0_hwdata  ),
	.mst10_hs0_hrdata  (mst10_hs0_hrdata  ),
	.mst10_hs0_hready  (mst10_hs0_hready  ),
	.mst10_hs0_hresp   (mst10_hs0_hresp   ),
	.mst10_slv0_ack    (mst10_slv0_ack    ),
	.mst10_slv0_base   (mst10_slv0_base   ),
	.mst10_slv0_grant  (mst10_slv0_grant  ),
	.mst10_slv0_haddr  (mst10_slv0_haddr  ),
	.mst10_slv0_hburst (mst10_slv0_hburst ),
	.mst10_slv0_hprot  (mst10_slv0_hprot  ),
	.mst10_slv0_hsize  (mst10_slv0_hsize  ),
	.mst10_slv0_htrans (mst10_slv0_htrans ),
	.mst10_slv0_hwrite (mst10_slv0_hwrite ),
	.mst10_slv0_req    (mst10_slv0_req    ),
	.mst10_slv0_sel    (mst10_slv0_sel    ),
	.mst10_slv0_size   (mst10_slv0_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm10_slv1_hwdata  (hm10_slv1_hwdata  ),
	.mst10_hs1_hrdata  (mst10_hs1_hrdata  ),
	.mst10_hs1_hready  (mst10_hs1_hready  ),
	.mst10_hs1_hresp   (mst10_hs1_hresp   ),
	.mst10_slv1_ack    (mst10_slv1_ack    ),
	.mst10_slv1_base   (mst10_slv1_base   ),
	.mst10_slv1_grant  (mst10_slv1_grant  ),
	.mst10_slv1_haddr  (mst10_slv1_haddr  ),
	.mst10_slv1_hburst (mst10_slv1_hburst ),
	.mst10_slv1_hprot  (mst10_slv1_hprot  ),
	.mst10_slv1_hsize  (mst10_slv1_hsize  ),
	.mst10_slv1_htrans (mst10_slv1_htrans ),
	.mst10_slv1_hwrite (mst10_slv1_hwrite ),
	.mst10_slv1_req    (mst10_slv1_req    ),
	.mst10_slv1_sel    (mst10_slv1_sel    ),
	.mst10_slv1_size   (mst10_slv1_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm10_slv2_hwdata  (hm10_slv2_hwdata  ),
	.mst10_hs2_hrdata  (mst10_hs2_hrdata  ),
	.mst10_hs2_hready  (mst10_hs2_hready  ),
	.mst10_hs2_hresp   (mst10_hs2_hresp   ),
	.mst10_slv2_ack    (mst10_slv2_ack    ),
	.mst10_slv2_base   (mst10_slv2_base   ),
	.mst10_slv2_grant  (mst10_slv2_grant  ),
	.mst10_slv2_haddr  (mst10_slv2_haddr  ),
	.mst10_slv2_hburst (mst10_slv2_hburst ),
	.mst10_slv2_hprot  (mst10_slv2_hprot  ),
	.mst10_slv2_hsize  (mst10_slv2_hsize  ),
	.mst10_slv2_htrans (mst10_slv2_htrans ),
	.mst10_slv2_hwrite (mst10_slv2_hwrite ),
	.mst10_slv2_req    (mst10_slv2_req    ),
	.mst10_slv2_sel    (mst10_slv2_sel    ),
	.mst10_slv2_size   (mst10_slv2_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm10_slv3_hwdata  (hm10_slv3_hwdata  ),
	.mst10_hs3_hrdata  (mst10_hs3_hrdata  ),
	.mst10_hs3_hready  (mst10_hs3_hready  ),
	.mst10_hs3_hresp   (mst10_hs3_hresp   ),
	.mst10_slv3_ack    (mst10_slv3_ack    ),
	.mst10_slv3_base   (mst10_slv3_base   ),
	.mst10_slv3_grant  (mst10_slv3_grant  ),
	.mst10_slv3_haddr  (mst10_slv3_haddr  ),
	.mst10_slv3_hburst (mst10_slv3_hburst ),
	.mst10_slv3_hprot  (mst10_slv3_hprot  ),
	.mst10_slv3_hsize  (mst10_slv3_hsize  ),
	.mst10_slv3_htrans (mst10_slv3_htrans ),
	.mst10_slv3_hwrite (mst10_slv3_hwrite ),
	.mst10_slv3_req    (mst10_slv3_req    ),
	.mst10_slv3_sel    (mst10_slv3_sel    ),
	.mst10_slv3_size   (mst10_slv3_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm10_slv4_hwdata  (hm10_slv4_hwdata  ),
	.mst10_hs4_hrdata  (mst10_hs4_hrdata  ),
	.mst10_hs4_hready  (mst10_hs4_hready  ),
	.mst10_hs4_hresp   (mst10_hs4_hresp   ),
	.mst10_slv4_ack    (mst10_slv4_ack    ),
	.mst10_slv4_base   (mst10_slv4_base   ),
	.mst10_slv4_grant  (mst10_slv4_grant  ),
	.mst10_slv4_haddr  (mst10_slv4_haddr  ),
	.mst10_slv4_hburst (mst10_slv4_hburst ),
	.mst10_slv4_hprot  (mst10_slv4_hprot  ),
	.mst10_slv4_hsize  (mst10_slv4_hsize  ),
	.mst10_slv4_htrans (mst10_slv4_htrans ),
	.mst10_slv4_hwrite (mst10_slv4_hwrite ),
	.mst10_slv4_req    (mst10_slv4_req    ),
	.mst10_slv4_sel    (mst10_slv4_sel    ),
	.mst10_slv4_size   (mst10_slv4_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm10_slv5_hwdata  (hm10_slv5_hwdata  ),
	.mst10_hs5_hrdata  (mst10_hs5_hrdata  ),
	.mst10_hs5_hready  (mst10_hs5_hready  ),
	.mst10_hs5_hresp   (mst10_hs5_hresp   ),
	.mst10_slv5_ack    (mst10_slv5_ack    ),
	.mst10_slv5_base   (mst10_slv5_base   ),
	.mst10_slv5_grant  (mst10_slv5_grant  ),
	.mst10_slv5_haddr  (mst10_slv5_haddr  ),
	.mst10_slv5_hburst (mst10_slv5_hburst ),
	.mst10_slv5_hprot  (mst10_slv5_hprot  ),
	.mst10_slv5_hsize  (mst10_slv5_hsize  ),
	.mst10_slv5_htrans (mst10_slv5_htrans ),
	.mst10_slv5_hwrite (mst10_slv5_hwrite ),
	.mst10_slv5_req    (mst10_slv5_req    ),
	.mst10_slv5_sel    (mst10_slv5_sel    ),
	.mst10_slv5_size   (mst10_slv5_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm10_slv6_hwdata  (hm10_slv6_hwdata  ),
	.mst10_hs6_hrdata  (mst10_hs6_hrdata  ),
	.mst10_hs6_hready  (mst10_hs6_hready  ),
	.mst10_hs6_hresp   (mst10_hs6_hresp   ),
	.mst10_slv6_ack    (mst10_slv6_ack    ),
	.mst10_slv6_base   (mst10_slv6_base   ),
	.mst10_slv6_grant  (mst10_slv6_grant  ),
	.mst10_slv6_haddr  (mst10_slv6_haddr  ),
	.mst10_slv6_hburst (mst10_slv6_hburst ),
	.mst10_slv6_hprot  (mst10_slv6_hprot  ),
	.mst10_slv6_hsize  (mst10_slv6_hsize  ),
	.mst10_slv6_htrans (mst10_slv6_htrans ),
	.mst10_slv6_hwrite (mst10_slv6_hwrite ),
	.mst10_slv6_req    (mst10_slv6_req    ),
	.mst10_slv6_sel    (mst10_slv6_sel    ),
	.mst10_slv6_size   (mst10_slv6_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm10_slv7_hwdata  (hm10_slv7_hwdata  ),
	.mst10_hs7_hrdata  (mst10_hs7_hrdata  ),
	.mst10_hs7_hready  (mst10_hs7_hready  ),
	.mst10_hs7_hresp   (mst10_hs7_hresp   ),
	.mst10_slv7_ack    (mst10_slv7_ack    ),
	.mst10_slv7_base   (mst10_slv7_base   ),
	.mst10_slv7_grant  (mst10_slv7_grant  ),
	.mst10_slv7_haddr  (mst10_slv7_haddr  ),
	.mst10_slv7_hburst (mst10_slv7_hburst ),
	.mst10_slv7_hprot  (mst10_slv7_hprot  ),
	.mst10_slv7_hsize  (mst10_slv7_hsize  ),
	.mst10_slv7_htrans (mst10_slv7_htrans ),
	.mst10_slv7_hwrite (mst10_slv7_hwrite ),
	.mst10_slv7_req    (mst10_slv7_req    ),
	.mst10_slv7_sel    (mst10_slv7_sel    ),
	.mst10_slv7_size   (mst10_slv7_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm10_slv8_hwdata  (hm10_slv8_hwdata  ),
	.mst10_hs8_hrdata  (mst10_hs8_hrdata  ),
	.mst10_hs8_hready  (mst10_hs8_hready  ),
	.mst10_hs8_hresp   (mst10_hs8_hresp   ),
	.mst10_slv8_ack    (mst10_slv8_ack    ),
	.mst10_slv8_base   (mst10_slv8_base   ),
	.mst10_slv8_grant  (mst10_slv8_grant  ),
	.mst10_slv8_haddr  (mst10_slv8_haddr  ),
	.mst10_slv8_hburst (mst10_slv8_hburst ),
	.mst10_slv8_hprot  (mst10_slv8_hprot  ),
	.mst10_slv8_hsize  (mst10_slv8_hsize  ),
	.mst10_slv8_htrans (mst10_slv8_htrans ),
	.mst10_slv8_hwrite (mst10_slv8_hwrite ),
	.mst10_slv8_req    (mst10_slv8_req    ),
	.mst10_slv8_sel    (mst10_slv8_sel    ),
	.mst10_slv8_size   (mst10_slv8_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm10_slv9_hwdata  (hm10_slv9_hwdata  ),
	.mst10_hs9_hrdata  (mst10_hs9_hrdata  ),
	.mst10_hs9_hready  (mst10_hs9_hready  ),
	.mst10_hs9_hresp   (mst10_hs9_hresp   ),
	.mst10_slv9_ack    (mst10_slv9_ack    ),
	.mst10_slv9_base   (mst10_slv9_base   ),
	.mst10_slv9_grant  (mst10_slv9_grant  ),
	.mst10_slv9_haddr  (mst10_slv9_haddr  ),
	.mst10_slv9_hburst (mst10_slv9_hburst ),
	.mst10_slv9_hprot  (mst10_slv9_hprot  ),
	.mst10_slv9_hsize  (mst10_slv9_hsize  ),
	.mst10_slv9_htrans (mst10_slv9_htrans ),
	.mst10_slv9_hwrite (mst10_slv9_hwrite ),
	.mst10_slv9_req    (mst10_slv9_req    ),
	.mst10_slv9_sel    (mst10_slv9_sel    ),
	.mst10_slv9_size   (mst10_slv9_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm10_slv10_hwdata (hm10_slv10_hwdata ),
	.mst10_hs10_hrdata (mst10_hs10_hrdata ),
	.mst10_hs10_hready (mst10_hs10_hready ),
	.mst10_hs10_hresp  (mst10_hs10_hresp  ),
	.mst10_slv10_ack   (mst10_slv10_ack   ),
	.mst10_slv10_base  (mst10_slv10_base  ),
	.mst10_slv10_grant (mst10_slv10_grant ),
	.mst10_slv10_haddr (mst10_slv10_haddr ),
	.mst10_slv10_hburst(mst10_slv10_hburst),
	.mst10_slv10_hprot (mst10_slv10_hprot ),
	.mst10_slv10_hsize (mst10_slv10_hsize ),
	.mst10_slv10_htrans(mst10_slv10_htrans),
	.mst10_slv10_hwrite(mst10_slv10_hwrite),
	.mst10_slv10_req   (mst10_slv10_req   ),
	.mst10_slv10_sel   (mst10_slv10_sel   ),
	.mst10_slv10_size  (mst10_slv10_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm10_slv11_hwdata (hm10_slv11_hwdata ),
	.mst10_hs11_hrdata (mst10_hs11_hrdata ),
	.mst10_hs11_hready (mst10_hs11_hready ),
	.mst10_hs11_hresp  (mst10_hs11_hresp  ),
	.mst10_slv11_ack   (mst10_slv11_ack   ),
	.mst10_slv11_base  (mst10_slv11_base  ),
	.mst10_slv11_grant (mst10_slv11_grant ),
	.mst10_slv11_haddr (mst10_slv11_haddr ),
	.mst10_slv11_hburst(mst10_slv11_hburst),
	.mst10_slv11_hprot (mst10_slv11_hprot ),
	.mst10_slv11_hsize (mst10_slv11_hsize ),
	.mst10_slv11_htrans(mst10_slv11_htrans),
	.mst10_slv11_hwrite(mst10_slv11_hwrite),
	.mst10_slv11_req   (mst10_slv11_req   ),
	.mst10_slv11_sel   (mst10_slv11_sel   ),
	.mst10_slv11_size  (mst10_slv11_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm10_slv12_hwdata (hm10_slv12_hwdata ),
	.mst10_hs12_hrdata (mst10_hs12_hrdata ),
	.mst10_hs12_hready (mst10_hs12_hready ),
	.mst10_hs12_hresp  (mst10_hs12_hresp  ),
	.mst10_slv12_ack   (mst10_slv12_ack   ),
	.mst10_slv12_base  (mst10_slv12_base  ),
	.mst10_slv12_grant (mst10_slv12_grant ),
	.mst10_slv12_haddr (mst10_slv12_haddr ),
	.mst10_slv12_hburst(mst10_slv12_hburst),
	.mst10_slv12_hprot (mst10_slv12_hprot ),
	.mst10_slv12_hsize (mst10_slv12_hsize ),
	.mst10_slv12_htrans(mst10_slv12_htrans),
	.mst10_slv12_hwrite(mst10_slv12_hwrite),
	.mst10_slv12_req   (mst10_slv12_req   ),
	.mst10_slv12_sel   (mst10_slv12_sel   ),
	.mst10_slv12_size  (mst10_slv12_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm10_slv13_hwdata (hm10_slv13_hwdata ),
	.mst10_hs13_hrdata (mst10_hs13_hrdata ),
	.mst10_hs13_hready (mst10_hs13_hready ),
	.mst10_hs13_hresp  (mst10_hs13_hresp  ),
	.mst10_slv13_ack   (mst10_slv13_ack   ),
	.mst10_slv13_base  (mst10_slv13_base  ),
	.mst10_slv13_grant (mst10_slv13_grant ),
	.mst10_slv13_haddr (mst10_slv13_haddr ),
	.mst10_slv13_hburst(mst10_slv13_hburst),
	.mst10_slv13_hprot (mst10_slv13_hprot ),
	.mst10_slv13_hsize (mst10_slv13_hsize ),
	.mst10_slv13_htrans(mst10_slv13_htrans),
	.mst10_slv13_hwrite(mst10_slv13_hwrite),
	.mst10_slv13_req   (mst10_slv13_req   ),
	.mst10_slv13_sel   (mst10_slv13_sel   ),
	.mst10_slv13_size  (mst10_slv13_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm10_slv14_hwdata (hm10_slv14_hwdata ),
	.mst10_hs14_hrdata (mst10_hs14_hrdata ),
	.mst10_hs14_hready (mst10_hs14_hready ),
	.mst10_hs14_hresp  (mst10_hs14_hresp  ),
	.mst10_slv14_ack   (mst10_slv14_ack   ),
	.mst10_slv14_base  (mst10_slv14_base  ),
	.mst10_slv14_grant (mst10_slv14_grant ),
	.mst10_slv14_haddr (mst10_slv14_haddr ),
	.mst10_slv14_hburst(mst10_slv14_hburst),
	.mst10_slv14_hprot (mst10_slv14_hprot ),
	.mst10_slv14_hsize (mst10_slv14_hsize ),
	.mst10_slv14_htrans(mst10_slv14_htrans),
	.mst10_slv14_hwrite(mst10_slv14_hwrite),
	.mst10_slv14_req   (mst10_slv14_req   ),
	.mst10_slv14_sel   (mst10_slv14_sel   ),
	.mst10_slv14_size  (mst10_slv14_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm10_slv15_hwdata (hm10_slv15_hwdata ),
	.mst10_hs15_hrdata (mst10_hs15_hrdata ),
	.mst10_hs15_hready (mst10_hs15_hready ),
	.mst10_hs15_hresp  (mst10_hs15_hresp  ),
	.mst10_slv15_ack   (mst10_slv15_ack   ),
	.mst10_slv15_base  (mst10_slv15_base  ),
	.mst10_slv15_grant (mst10_slv15_grant ),
	.mst10_slv15_haddr (mst10_slv15_haddr ),
	.mst10_slv15_hburst(mst10_slv15_hburst),
	.mst10_slv15_hprot (mst10_slv15_hprot ),
	.mst10_slv15_hsize (mst10_slv15_hsize ),
	.mst10_slv15_htrans(mst10_slv15_htrans),
	.mst10_slv15_hwrite(mst10_slv15_hwrite),
	.mst10_slv15_req   (mst10_slv15_req   ),
	.mst10_slv15_sel   (mst10_slv15_sel   ),
	.mst10_slv15_size  (mst10_slv15_size  ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST11
   `ifdef ATCBMC200_AHB_SLV0
	.hm11_slv0_hwdata  (hm11_slv0_hwdata  ),
	.mst11_hs0_hrdata  (mst11_hs0_hrdata  ),
	.mst11_hs0_hready  (mst11_hs0_hready  ),
	.mst11_hs0_hresp   (mst11_hs0_hresp   ),
	.mst11_slv0_ack    (mst11_slv0_ack    ),
	.mst11_slv0_base   (mst11_slv0_base   ),
	.mst11_slv0_grant  (mst11_slv0_grant  ),
	.mst11_slv0_haddr  (mst11_slv0_haddr  ),
	.mst11_slv0_hburst (mst11_slv0_hburst ),
	.mst11_slv0_hprot  (mst11_slv0_hprot  ),
	.mst11_slv0_hsize  (mst11_slv0_hsize  ),
	.mst11_slv0_htrans (mst11_slv0_htrans ),
	.mst11_slv0_hwrite (mst11_slv0_hwrite ),
	.mst11_slv0_req    (mst11_slv0_req    ),
	.mst11_slv0_sel    (mst11_slv0_sel    ),
	.mst11_slv0_size   (mst11_slv0_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm11_slv1_hwdata  (hm11_slv1_hwdata  ),
	.mst11_hs1_hrdata  (mst11_hs1_hrdata  ),
	.mst11_hs1_hready  (mst11_hs1_hready  ),
	.mst11_hs1_hresp   (mst11_hs1_hresp   ),
	.mst11_slv1_ack    (mst11_slv1_ack    ),
	.mst11_slv1_base   (mst11_slv1_base   ),
	.mst11_slv1_grant  (mst11_slv1_grant  ),
	.mst11_slv1_haddr  (mst11_slv1_haddr  ),
	.mst11_slv1_hburst (mst11_slv1_hburst ),
	.mst11_slv1_hprot  (mst11_slv1_hprot  ),
	.mst11_slv1_hsize  (mst11_slv1_hsize  ),
	.mst11_slv1_htrans (mst11_slv1_htrans ),
	.mst11_slv1_hwrite (mst11_slv1_hwrite ),
	.mst11_slv1_req    (mst11_slv1_req    ),
	.mst11_slv1_sel    (mst11_slv1_sel    ),
	.mst11_slv1_size   (mst11_slv1_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm11_slv2_hwdata  (hm11_slv2_hwdata  ),
	.mst11_hs2_hrdata  (mst11_hs2_hrdata  ),
	.mst11_hs2_hready  (mst11_hs2_hready  ),
	.mst11_hs2_hresp   (mst11_hs2_hresp   ),
	.mst11_slv2_ack    (mst11_slv2_ack    ),
	.mst11_slv2_base   (mst11_slv2_base   ),
	.mst11_slv2_grant  (mst11_slv2_grant  ),
	.mst11_slv2_haddr  (mst11_slv2_haddr  ),
	.mst11_slv2_hburst (mst11_slv2_hburst ),
	.mst11_slv2_hprot  (mst11_slv2_hprot  ),
	.mst11_slv2_hsize  (mst11_slv2_hsize  ),
	.mst11_slv2_htrans (mst11_slv2_htrans ),
	.mst11_slv2_hwrite (mst11_slv2_hwrite ),
	.mst11_slv2_req    (mst11_slv2_req    ),
	.mst11_slv2_sel    (mst11_slv2_sel    ),
	.mst11_slv2_size   (mst11_slv2_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm11_slv3_hwdata  (hm11_slv3_hwdata  ),
	.mst11_hs3_hrdata  (mst11_hs3_hrdata  ),
	.mst11_hs3_hready  (mst11_hs3_hready  ),
	.mst11_hs3_hresp   (mst11_hs3_hresp   ),
	.mst11_slv3_ack    (mst11_slv3_ack    ),
	.mst11_slv3_base   (mst11_slv3_base   ),
	.mst11_slv3_grant  (mst11_slv3_grant  ),
	.mst11_slv3_haddr  (mst11_slv3_haddr  ),
	.mst11_slv3_hburst (mst11_slv3_hburst ),
	.mst11_slv3_hprot  (mst11_slv3_hprot  ),
	.mst11_slv3_hsize  (mst11_slv3_hsize  ),
	.mst11_slv3_htrans (mst11_slv3_htrans ),
	.mst11_slv3_hwrite (mst11_slv3_hwrite ),
	.mst11_slv3_req    (mst11_slv3_req    ),
	.mst11_slv3_sel    (mst11_slv3_sel    ),
	.mst11_slv3_size   (mst11_slv3_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm11_slv4_hwdata  (hm11_slv4_hwdata  ),
	.mst11_hs4_hrdata  (mst11_hs4_hrdata  ),
	.mst11_hs4_hready  (mst11_hs4_hready  ),
	.mst11_hs4_hresp   (mst11_hs4_hresp   ),
	.mst11_slv4_ack    (mst11_slv4_ack    ),
	.mst11_slv4_base   (mst11_slv4_base   ),
	.mst11_slv4_grant  (mst11_slv4_grant  ),
	.mst11_slv4_haddr  (mst11_slv4_haddr  ),
	.mst11_slv4_hburst (mst11_slv4_hburst ),
	.mst11_slv4_hprot  (mst11_slv4_hprot  ),
	.mst11_slv4_hsize  (mst11_slv4_hsize  ),
	.mst11_slv4_htrans (mst11_slv4_htrans ),
	.mst11_slv4_hwrite (mst11_slv4_hwrite ),
	.mst11_slv4_req    (mst11_slv4_req    ),
	.mst11_slv4_sel    (mst11_slv4_sel    ),
	.mst11_slv4_size   (mst11_slv4_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm11_slv5_hwdata  (hm11_slv5_hwdata  ),
	.mst11_hs5_hrdata  (mst11_hs5_hrdata  ),
	.mst11_hs5_hready  (mst11_hs5_hready  ),
	.mst11_hs5_hresp   (mst11_hs5_hresp   ),
	.mst11_slv5_ack    (mst11_slv5_ack    ),
	.mst11_slv5_base   (mst11_slv5_base   ),
	.mst11_slv5_grant  (mst11_slv5_grant  ),
	.mst11_slv5_haddr  (mst11_slv5_haddr  ),
	.mst11_slv5_hburst (mst11_slv5_hburst ),
	.mst11_slv5_hprot  (mst11_slv5_hprot  ),
	.mst11_slv5_hsize  (mst11_slv5_hsize  ),
	.mst11_slv5_htrans (mst11_slv5_htrans ),
	.mst11_slv5_hwrite (mst11_slv5_hwrite ),
	.mst11_slv5_req    (mst11_slv5_req    ),
	.mst11_slv5_sel    (mst11_slv5_sel    ),
	.mst11_slv5_size   (mst11_slv5_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm11_slv6_hwdata  (hm11_slv6_hwdata  ),
	.mst11_hs6_hrdata  (mst11_hs6_hrdata  ),
	.mst11_hs6_hready  (mst11_hs6_hready  ),
	.mst11_hs6_hresp   (mst11_hs6_hresp   ),
	.mst11_slv6_ack    (mst11_slv6_ack    ),
	.mst11_slv6_base   (mst11_slv6_base   ),
	.mst11_slv6_grant  (mst11_slv6_grant  ),
	.mst11_slv6_haddr  (mst11_slv6_haddr  ),
	.mst11_slv6_hburst (mst11_slv6_hburst ),
	.mst11_slv6_hprot  (mst11_slv6_hprot  ),
	.mst11_slv6_hsize  (mst11_slv6_hsize  ),
	.mst11_slv6_htrans (mst11_slv6_htrans ),
	.mst11_slv6_hwrite (mst11_slv6_hwrite ),
	.mst11_slv6_req    (mst11_slv6_req    ),
	.mst11_slv6_sel    (mst11_slv6_sel    ),
	.mst11_slv6_size   (mst11_slv6_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm11_slv7_hwdata  (hm11_slv7_hwdata  ),
	.mst11_hs7_hrdata  (mst11_hs7_hrdata  ),
	.mst11_hs7_hready  (mst11_hs7_hready  ),
	.mst11_hs7_hresp   (mst11_hs7_hresp   ),
	.mst11_slv7_ack    (mst11_slv7_ack    ),
	.mst11_slv7_base   (mst11_slv7_base   ),
	.mst11_slv7_grant  (mst11_slv7_grant  ),
	.mst11_slv7_haddr  (mst11_slv7_haddr  ),
	.mst11_slv7_hburst (mst11_slv7_hburst ),
	.mst11_slv7_hprot  (mst11_slv7_hprot  ),
	.mst11_slv7_hsize  (mst11_slv7_hsize  ),
	.mst11_slv7_htrans (mst11_slv7_htrans ),
	.mst11_slv7_hwrite (mst11_slv7_hwrite ),
	.mst11_slv7_req    (mst11_slv7_req    ),
	.mst11_slv7_sel    (mst11_slv7_sel    ),
	.mst11_slv7_size   (mst11_slv7_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm11_slv8_hwdata  (hm11_slv8_hwdata  ),
	.mst11_hs8_hrdata  (mst11_hs8_hrdata  ),
	.mst11_hs8_hready  (mst11_hs8_hready  ),
	.mst11_hs8_hresp   (mst11_hs8_hresp   ),
	.mst11_slv8_ack    (mst11_slv8_ack    ),
	.mst11_slv8_base   (mst11_slv8_base   ),
	.mst11_slv8_grant  (mst11_slv8_grant  ),
	.mst11_slv8_haddr  (mst11_slv8_haddr  ),
	.mst11_slv8_hburst (mst11_slv8_hburst ),
	.mst11_slv8_hprot  (mst11_slv8_hprot  ),
	.mst11_slv8_hsize  (mst11_slv8_hsize  ),
	.mst11_slv8_htrans (mst11_slv8_htrans ),
	.mst11_slv8_hwrite (mst11_slv8_hwrite ),
	.mst11_slv8_req    (mst11_slv8_req    ),
	.mst11_slv8_sel    (mst11_slv8_sel    ),
	.mst11_slv8_size   (mst11_slv8_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm11_slv9_hwdata  (hm11_slv9_hwdata  ),
	.mst11_hs9_hrdata  (mst11_hs9_hrdata  ),
	.mst11_hs9_hready  (mst11_hs9_hready  ),
	.mst11_hs9_hresp   (mst11_hs9_hresp   ),
	.mst11_slv9_ack    (mst11_slv9_ack    ),
	.mst11_slv9_base   (mst11_slv9_base   ),
	.mst11_slv9_grant  (mst11_slv9_grant  ),
	.mst11_slv9_haddr  (mst11_slv9_haddr  ),
	.mst11_slv9_hburst (mst11_slv9_hburst ),
	.mst11_slv9_hprot  (mst11_slv9_hprot  ),
	.mst11_slv9_hsize  (mst11_slv9_hsize  ),
	.mst11_slv9_htrans (mst11_slv9_htrans ),
	.mst11_slv9_hwrite (mst11_slv9_hwrite ),
	.mst11_slv9_req    (mst11_slv9_req    ),
	.mst11_slv9_sel    (mst11_slv9_sel    ),
	.mst11_slv9_size   (mst11_slv9_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm11_slv10_hwdata (hm11_slv10_hwdata ),
	.mst11_hs10_hrdata (mst11_hs10_hrdata ),
	.mst11_hs10_hready (mst11_hs10_hready ),
	.mst11_hs10_hresp  (mst11_hs10_hresp  ),
	.mst11_slv10_ack   (mst11_slv10_ack   ),
	.mst11_slv10_base  (mst11_slv10_base  ),
	.mst11_slv10_grant (mst11_slv10_grant ),
	.mst11_slv10_haddr (mst11_slv10_haddr ),
	.mst11_slv10_hburst(mst11_slv10_hburst),
	.mst11_slv10_hprot (mst11_slv10_hprot ),
	.mst11_slv10_hsize (mst11_slv10_hsize ),
	.mst11_slv10_htrans(mst11_slv10_htrans),
	.mst11_slv10_hwrite(mst11_slv10_hwrite),
	.mst11_slv10_req   (mst11_slv10_req   ),
	.mst11_slv10_sel   (mst11_slv10_sel   ),
	.mst11_slv10_size  (mst11_slv10_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm11_slv11_hwdata (hm11_slv11_hwdata ),
	.mst11_hs11_hrdata (mst11_hs11_hrdata ),
	.mst11_hs11_hready (mst11_hs11_hready ),
	.mst11_hs11_hresp  (mst11_hs11_hresp  ),
	.mst11_slv11_ack   (mst11_slv11_ack   ),
	.mst11_slv11_base  (mst11_slv11_base  ),
	.mst11_slv11_grant (mst11_slv11_grant ),
	.mst11_slv11_haddr (mst11_slv11_haddr ),
	.mst11_slv11_hburst(mst11_slv11_hburst),
	.mst11_slv11_hprot (mst11_slv11_hprot ),
	.mst11_slv11_hsize (mst11_slv11_hsize ),
	.mst11_slv11_htrans(mst11_slv11_htrans),
	.mst11_slv11_hwrite(mst11_slv11_hwrite),
	.mst11_slv11_req   (mst11_slv11_req   ),
	.mst11_slv11_sel   (mst11_slv11_sel   ),
	.mst11_slv11_size  (mst11_slv11_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm11_slv12_hwdata (hm11_slv12_hwdata ),
	.mst11_hs12_hrdata (mst11_hs12_hrdata ),
	.mst11_hs12_hready (mst11_hs12_hready ),
	.mst11_hs12_hresp  (mst11_hs12_hresp  ),
	.mst11_slv12_ack   (mst11_slv12_ack   ),
	.mst11_slv12_base  (mst11_slv12_base  ),
	.mst11_slv12_grant (mst11_slv12_grant ),
	.mst11_slv12_haddr (mst11_slv12_haddr ),
	.mst11_slv12_hburst(mst11_slv12_hburst),
	.mst11_slv12_hprot (mst11_slv12_hprot ),
	.mst11_slv12_hsize (mst11_slv12_hsize ),
	.mst11_slv12_htrans(mst11_slv12_htrans),
	.mst11_slv12_hwrite(mst11_slv12_hwrite),
	.mst11_slv12_req   (mst11_slv12_req   ),
	.mst11_slv12_sel   (mst11_slv12_sel   ),
	.mst11_slv12_size  (mst11_slv12_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm11_slv13_hwdata (hm11_slv13_hwdata ),
	.mst11_hs13_hrdata (mst11_hs13_hrdata ),
	.mst11_hs13_hready (mst11_hs13_hready ),
	.mst11_hs13_hresp  (mst11_hs13_hresp  ),
	.mst11_slv13_ack   (mst11_slv13_ack   ),
	.mst11_slv13_base  (mst11_slv13_base  ),
	.mst11_slv13_grant (mst11_slv13_grant ),
	.mst11_slv13_haddr (mst11_slv13_haddr ),
	.mst11_slv13_hburst(mst11_slv13_hburst),
	.mst11_slv13_hprot (mst11_slv13_hprot ),
	.mst11_slv13_hsize (mst11_slv13_hsize ),
	.mst11_slv13_htrans(mst11_slv13_htrans),
	.mst11_slv13_hwrite(mst11_slv13_hwrite),
	.mst11_slv13_req   (mst11_slv13_req   ),
	.mst11_slv13_sel   (mst11_slv13_sel   ),
	.mst11_slv13_size  (mst11_slv13_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm11_slv14_hwdata (hm11_slv14_hwdata ),
	.mst11_hs14_hrdata (mst11_hs14_hrdata ),
	.mst11_hs14_hready (mst11_hs14_hready ),
	.mst11_hs14_hresp  (mst11_hs14_hresp  ),
	.mst11_slv14_ack   (mst11_slv14_ack   ),
	.mst11_slv14_base  (mst11_slv14_base  ),
	.mst11_slv14_grant (mst11_slv14_grant ),
	.mst11_slv14_haddr (mst11_slv14_haddr ),
	.mst11_slv14_hburst(mst11_slv14_hburst),
	.mst11_slv14_hprot (mst11_slv14_hprot ),
	.mst11_slv14_hsize (mst11_slv14_hsize ),
	.mst11_slv14_htrans(mst11_slv14_htrans),
	.mst11_slv14_hwrite(mst11_slv14_hwrite),
	.mst11_slv14_req   (mst11_slv14_req   ),
	.mst11_slv14_sel   (mst11_slv14_sel   ),
	.mst11_slv14_size  (mst11_slv14_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm11_slv15_hwdata (hm11_slv15_hwdata ),
	.mst11_hs15_hrdata (mst11_hs15_hrdata ),
	.mst11_hs15_hready (mst11_hs15_hready ),
	.mst11_hs15_hresp  (mst11_hs15_hresp  ),
	.mst11_slv15_ack   (mst11_slv15_ack   ),
	.mst11_slv15_base  (mst11_slv15_base  ),
	.mst11_slv15_grant (mst11_slv15_grant ),
	.mst11_slv15_haddr (mst11_slv15_haddr ),
	.mst11_slv15_hburst(mst11_slv15_hburst),
	.mst11_slv15_hprot (mst11_slv15_hprot ),
	.mst11_slv15_hsize (mst11_slv15_hsize ),
	.mst11_slv15_htrans(mst11_slv15_htrans),
	.mst11_slv15_hwrite(mst11_slv15_hwrite),
	.mst11_slv15_req   (mst11_slv15_req   ),
	.mst11_slv15_sel   (mst11_slv15_sel   ),
	.mst11_slv15_size  (mst11_slv15_size  ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST12
   `ifdef ATCBMC200_AHB_SLV0
	.hm12_slv0_hwdata  (hm12_slv0_hwdata  ),
	.mst12_hs0_hrdata  (mst12_hs0_hrdata  ),
	.mst12_hs0_hready  (mst12_hs0_hready  ),
	.mst12_hs0_hresp   (mst12_hs0_hresp   ),
	.mst12_slv0_ack    (mst12_slv0_ack    ),
	.mst12_slv0_base   (mst12_slv0_base   ),
	.mst12_slv0_grant  (mst12_slv0_grant  ),
	.mst12_slv0_haddr  (mst12_slv0_haddr  ),
	.mst12_slv0_hburst (mst12_slv0_hburst ),
	.mst12_slv0_hprot  (mst12_slv0_hprot  ),
	.mst12_slv0_hsize  (mst12_slv0_hsize  ),
	.mst12_slv0_htrans (mst12_slv0_htrans ),
	.mst12_slv0_hwrite (mst12_slv0_hwrite ),
	.mst12_slv0_req    (mst12_slv0_req    ),
	.mst12_slv0_sel    (mst12_slv0_sel    ),
	.mst12_slv0_size   (mst12_slv0_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm12_slv1_hwdata  (hm12_slv1_hwdata  ),
	.mst12_hs1_hrdata  (mst12_hs1_hrdata  ),
	.mst12_hs1_hready  (mst12_hs1_hready  ),
	.mst12_hs1_hresp   (mst12_hs1_hresp   ),
	.mst12_slv1_ack    (mst12_slv1_ack    ),
	.mst12_slv1_base   (mst12_slv1_base   ),
	.mst12_slv1_grant  (mst12_slv1_grant  ),
	.mst12_slv1_haddr  (mst12_slv1_haddr  ),
	.mst12_slv1_hburst (mst12_slv1_hburst ),
	.mst12_slv1_hprot  (mst12_slv1_hprot  ),
	.mst12_slv1_hsize  (mst12_slv1_hsize  ),
	.mst12_slv1_htrans (mst12_slv1_htrans ),
	.mst12_slv1_hwrite (mst12_slv1_hwrite ),
	.mst12_slv1_req    (mst12_slv1_req    ),
	.mst12_slv1_sel    (mst12_slv1_sel    ),
	.mst12_slv1_size   (mst12_slv1_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm12_slv2_hwdata  (hm12_slv2_hwdata  ),
	.mst12_hs2_hrdata  (mst12_hs2_hrdata  ),
	.mst12_hs2_hready  (mst12_hs2_hready  ),
	.mst12_hs2_hresp   (mst12_hs2_hresp   ),
	.mst12_slv2_ack    (mst12_slv2_ack    ),
	.mst12_slv2_base   (mst12_slv2_base   ),
	.mst12_slv2_grant  (mst12_slv2_grant  ),
	.mst12_slv2_haddr  (mst12_slv2_haddr  ),
	.mst12_slv2_hburst (mst12_slv2_hburst ),
	.mst12_slv2_hprot  (mst12_slv2_hprot  ),
	.mst12_slv2_hsize  (mst12_slv2_hsize  ),
	.mst12_slv2_htrans (mst12_slv2_htrans ),
	.mst12_slv2_hwrite (mst12_slv2_hwrite ),
	.mst12_slv2_req    (mst12_slv2_req    ),
	.mst12_slv2_sel    (mst12_slv2_sel    ),
	.mst12_slv2_size   (mst12_slv2_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm12_slv3_hwdata  (hm12_slv3_hwdata  ),
	.mst12_hs3_hrdata  (mst12_hs3_hrdata  ),
	.mst12_hs3_hready  (mst12_hs3_hready  ),
	.mst12_hs3_hresp   (mst12_hs3_hresp   ),
	.mst12_slv3_ack    (mst12_slv3_ack    ),
	.mst12_slv3_base   (mst12_slv3_base   ),
	.mst12_slv3_grant  (mst12_slv3_grant  ),
	.mst12_slv3_haddr  (mst12_slv3_haddr  ),
	.mst12_slv3_hburst (mst12_slv3_hburst ),
	.mst12_slv3_hprot  (mst12_slv3_hprot  ),
	.mst12_slv3_hsize  (mst12_slv3_hsize  ),
	.mst12_slv3_htrans (mst12_slv3_htrans ),
	.mst12_slv3_hwrite (mst12_slv3_hwrite ),
	.mst12_slv3_req    (mst12_slv3_req    ),
	.mst12_slv3_sel    (mst12_slv3_sel    ),
	.mst12_slv3_size   (mst12_slv3_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm12_slv4_hwdata  (hm12_slv4_hwdata  ),
	.mst12_hs4_hrdata  (mst12_hs4_hrdata  ),
	.mst12_hs4_hready  (mst12_hs4_hready  ),
	.mst12_hs4_hresp   (mst12_hs4_hresp   ),
	.mst12_slv4_ack    (mst12_slv4_ack    ),
	.mst12_slv4_base   (mst12_slv4_base   ),
	.mst12_slv4_grant  (mst12_slv4_grant  ),
	.mst12_slv4_haddr  (mst12_slv4_haddr  ),
	.mst12_slv4_hburst (mst12_slv4_hburst ),
	.mst12_slv4_hprot  (mst12_slv4_hprot  ),
	.mst12_slv4_hsize  (mst12_slv4_hsize  ),
	.mst12_slv4_htrans (mst12_slv4_htrans ),
	.mst12_slv4_hwrite (mst12_slv4_hwrite ),
	.mst12_slv4_req    (mst12_slv4_req    ),
	.mst12_slv4_sel    (mst12_slv4_sel    ),
	.mst12_slv4_size   (mst12_slv4_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm12_slv5_hwdata  (hm12_slv5_hwdata  ),
	.mst12_hs5_hrdata  (mst12_hs5_hrdata  ),
	.mst12_hs5_hready  (mst12_hs5_hready  ),
	.mst12_hs5_hresp   (mst12_hs5_hresp   ),
	.mst12_slv5_ack    (mst12_slv5_ack    ),
	.mst12_slv5_base   (mst12_slv5_base   ),
	.mst12_slv5_grant  (mst12_slv5_grant  ),
	.mst12_slv5_haddr  (mst12_slv5_haddr  ),
	.mst12_slv5_hburst (mst12_slv5_hburst ),
	.mst12_slv5_hprot  (mst12_slv5_hprot  ),
	.mst12_slv5_hsize  (mst12_slv5_hsize  ),
	.mst12_slv5_htrans (mst12_slv5_htrans ),
	.mst12_slv5_hwrite (mst12_slv5_hwrite ),
	.mst12_slv5_req    (mst12_slv5_req    ),
	.mst12_slv5_sel    (mst12_slv5_sel    ),
	.mst12_slv5_size   (mst12_slv5_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm12_slv6_hwdata  (hm12_slv6_hwdata  ),
	.mst12_hs6_hrdata  (mst12_hs6_hrdata  ),
	.mst12_hs6_hready  (mst12_hs6_hready  ),
	.mst12_hs6_hresp   (mst12_hs6_hresp   ),
	.mst12_slv6_ack    (mst12_slv6_ack    ),
	.mst12_slv6_base   (mst12_slv6_base   ),
	.mst12_slv6_grant  (mst12_slv6_grant  ),
	.mst12_slv6_haddr  (mst12_slv6_haddr  ),
	.mst12_slv6_hburst (mst12_slv6_hburst ),
	.mst12_slv6_hprot  (mst12_slv6_hprot  ),
	.mst12_slv6_hsize  (mst12_slv6_hsize  ),
	.mst12_slv6_htrans (mst12_slv6_htrans ),
	.mst12_slv6_hwrite (mst12_slv6_hwrite ),
	.mst12_slv6_req    (mst12_slv6_req    ),
	.mst12_slv6_sel    (mst12_slv6_sel    ),
	.mst12_slv6_size   (mst12_slv6_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm12_slv7_hwdata  (hm12_slv7_hwdata  ),
	.mst12_hs7_hrdata  (mst12_hs7_hrdata  ),
	.mst12_hs7_hready  (mst12_hs7_hready  ),
	.mst12_hs7_hresp   (mst12_hs7_hresp   ),
	.mst12_slv7_ack    (mst12_slv7_ack    ),
	.mst12_slv7_base   (mst12_slv7_base   ),
	.mst12_slv7_grant  (mst12_slv7_grant  ),
	.mst12_slv7_haddr  (mst12_slv7_haddr  ),
	.mst12_slv7_hburst (mst12_slv7_hburst ),
	.mst12_slv7_hprot  (mst12_slv7_hprot  ),
	.mst12_slv7_hsize  (mst12_slv7_hsize  ),
	.mst12_slv7_htrans (mst12_slv7_htrans ),
	.mst12_slv7_hwrite (mst12_slv7_hwrite ),
	.mst12_slv7_req    (mst12_slv7_req    ),
	.mst12_slv7_sel    (mst12_slv7_sel    ),
	.mst12_slv7_size   (mst12_slv7_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm12_slv8_hwdata  (hm12_slv8_hwdata  ),
	.mst12_hs8_hrdata  (mst12_hs8_hrdata  ),
	.mst12_hs8_hready  (mst12_hs8_hready  ),
	.mst12_hs8_hresp   (mst12_hs8_hresp   ),
	.mst12_slv8_ack    (mst12_slv8_ack    ),
	.mst12_slv8_base   (mst12_slv8_base   ),
	.mst12_slv8_grant  (mst12_slv8_grant  ),
	.mst12_slv8_haddr  (mst12_slv8_haddr  ),
	.mst12_slv8_hburst (mst12_slv8_hburst ),
	.mst12_slv8_hprot  (mst12_slv8_hprot  ),
	.mst12_slv8_hsize  (mst12_slv8_hsize  ),
	.mst12_slv8_htrans (mst12_slv8_htrans ),
	.mst12_slv8_hwrite (mst12_slv8_hwrite ),
	.mst12_slv8_req    (mst12_slv8_req    ),
	.mst12_slv8_sel    (mst12_slv8_sel    ),
	.mst12_slv8_size   (mst12_slv8_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm12_slv9_hwdata  (hm12_slv9_hwdata  ),
	.mst12_hs9_hrdata  (mst12_hs9_hrdata  ),
	.mst12_hs9_hready  (mst12_hs9_hready  ),
	.mst12_hs9_hresp   (mst12_hs9_hresp   ),
	.mst12_slv9_ack    (mst12_slv9_ack    ),
	.mst12_slv9_base   (mst12_slv9_base   ),
	.mst12_slv9_grant  (mst12_slv9_grant  ),
	.mst12_slv9_haddr  (mst12_slv9_haddr  ),
	.mst12_slv9_hburst (mst12_slv9_hburst ),
	.mst12_slv9_hprot  (mst12_slv9_hprot  ),
	.mst12_slv9_hsize  (mst12_slv9_hsize  ),
	.mst12_slv9_htrans (mst12_slv9_htrans ),
	.mst12_slv9_hwrite (mst12_slv9_hwrite ),
	.mst12_slv9_req    (mst12_slv9_req    ),
	.mst12_slv9_sel    (mst12_slv9_sel    ),
	.mst12_slv9_size   (mst12_slv9_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm12_slv10_hwdata (hm12_slv10_hwdata ),
	.mst12_hs10_hrdata (mst12_hs10_hrdata ),
	.mst12_hs10_hready (mst12_hs10_hready ),
	.mst12_hs10_hresp  (mst12_hs10_hresp  ),
	.mst12_slv10_ack   (mst12_slv10_ack   ),
	.mst12_slv10_base  (mst12_slv10_base  ),
	.mst12_slv10_grant (mst12_slv10_grant ),
	.mst12_slv10_haddr (mst12_slv10_haddr ),
	.mst12_slv10_hburst(mst12_slv10_hburst),
	.mst12_slv10_hprot (mst12_slv10_hprot ),
	.mst12_slv10_hsize (mst12_slv10_hsize ),
	.mst12_slv10_htrans(mst12_slv10_htrans),
	.mst12_slv10_hwrite(mst12_slv10_hwrite),
	.mst12_slv10_req   (mst12_slv10_req   ),
	.mst12_slv10_sel   (mst12_slv10_sel   ),
	.mst12_slv10_size  (mst12_slv10_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm12_slv11_hwdata (hm12_slv11_hwdata ),
	.mst12_hs11_hrdata (mst12_hs11_hrdata ),
	.mst12_hs11_hready (mst12_hs11_hready ),
	.mst12_hs11_hresp  (mst12_hs11_hresp  ),
	.mst12_slv11_ack   (mst12_slv11_ack   ),
	.mst12_slv11_base  (mst12_slv11_base  ),
	.mst12_slv11_grant (mst12_slv11_grant ),
	.mst12_slv11_haddr (mst12_slv11_haddr ),
	.mst12_slv11_hburst(mst12_slv11_hburst),
	.mst12_slv11_hprot (mst12_slv11_hprot ),
	.mst12_slv11_hsize (mst12_slv11_hsize ),
	.mst12_slv11_htrans(mst12_slv11_htrans),
	.mst12_slv11_hwrite(mst12_slv11_hwrite),
	.mst12_slv11_req   (mst12_slv11_req   ),
	.mst12_slv11_sel   (mst12_slv11_sel   ),
	.mst12_slv11_size  (mst12_slv11_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm12_slv12_hwdata (hm12_slv12_hwdata ),
	.mst12_hs12_hrdata (mst12_hs12_hrdata ),
	.mst12_hs12_hready (mst12_hs12_hready ),
	.mst12_hs12_hresp  (mst12_hs12_hresp  ),
	.mst12_slv12_ack   (mst12_slv12_ack   ),
	.mst12_slv12_base  (mst12_slv12_base  ),
	.mst12_slv12_grant (mst12_slv12_grant ),
	.mst12_slv12_haddr (mst12_slv12_haddr ),
	.mst12_slv12_hburst(mst12_slv12_hburst),
	.mst12_slv12_hprot (mst12_slv12_hprot ),
	.mst12_slv12_hsize (mst12_slv12_hsize ),
	.mst12_slv12_htrans(mst12_slv12_htrans),
	.mst12_slv12_hwrite(mst12_slv12_hwrite),
	.mst12_slv12_req   (mst12_slv12_req   ),
	.mst12_slv12_sel   (mst12_slv12_sel   ),
	.mst12_slv12_size  (mst12_slv12_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm12_slv13_hwdata (hm12_slv13_hwdata ),
	.mst12_hs13_hrdata (mst12_hs13_hrdata ),
	.mst12_hs13_hready (mst12_hs13_hready ),
	.mst12_hs13_hresp  (mst12_hs13_hresp  ),
	.mst12_slv13_ack   (mst12_slv13_ack   ),
	.mst12_slv13_base  (mst12_slv13_base  ),
	.mst12_slv13_grant (mst12_slv13_grant ),
	.mst12_slv13_haddr (mst12_slv13_haddr ),
	.mst12_slv13_hburst(mst12_slv13_hburst),
	.mst12_slv13_hprot (mst12_slv13_hprot ),
	.mst12_slv13_hsize (mst12_slv13_hsize ),
	.mst12_slv13_htrans(mst12_slv13_htrans),
	.mst12_slv13_hwrite(mst12_slv13_hwrite),
	.mst12_slv13_req   (mst12_slv13_req   ),
	.mst12_slv13_sel   (mst12_slv13_sel   ),
	.mst12_slv13_size  (mst12_slv13_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm12_slv14_hwdata (hm12_slv14_hwdata ),
	.mst12_hs14_hrdata (mst12_hs14_hrdata ),
	.mst12_hs14_hready (mst12_hs14_hready ),
	.mst12_hs14_hresp  (mst12_hs14_hresp  ),
	.mst12_slv14_ack   (mst12_slv14_ack   ),
	.mst12_slv14_base  (mst12_slv14_base  ),
	.mst12_slv14_grant (mst12_slv14_grant ),
	.mst12_slv14_haddr (mst12_slv14_haddr ),
	.mst12_slv14_hburst(mst12_slv14_hburst),
	.mst12_slv14_hprot (mst12_slv14_hprot ),
	.mst12_slv14_hsize (mst12_slv14_hsize ),
	.mst12_slv14_htrans(mst12_slv14_htrans),
	.mst12_slv14_hwrite(mst12_slv14_hwrite),
	.mst12_slv14_req   (mst12_slv14_req   ),
	.mst12_slv14_sel   (mst12_slv14_sel   ),
	.mst12_slv14_size  (mst12_slv14_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm12_slv15_hwdata (hm12_slv15_hwdata ),
	.mst12_hs15_hrdata (mst12_hs15_hrdata ),
	.mst12_hs15_hready (mst12_hs15_hready ),
	.mst12_hs15_hresp  (mst12_hs15_hresp  ),
	.mst12_slv15_ack   (mst12_slv15_ack   ),
	.mst12_slv15_base  (mst12_slv15_base  ),
	.mst12_slv15_grant (mst12_slv15_grant ),
	.mst12_slv15_haddr (mst12_slv15_haddr ),
	.mst12_slv15_hburst(mst12_slv15_hburst),
	.mst12_slv15_hprot (mst12_slv15_hprot ),
	.mst12_slv15_hsize (mst12_slv15_hsize ),
	.mst12_slv15_htrans(mst12_slv15_htrans),
	.mst12_slv15_hwrite(mst12_slv15_hwrite),
	.mst12_slv15_req   (mst12_slv15_req   ),
	.mst12_slv15_sel   (mst12_slv15_sel   ),
	.mst12_slv15_size  (mst12_slv15_size  ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST13
   `ifdef ATCBMC200_AHB_SLV0
	.hm13_slv0_hwdata  (hm13_slv0_hwdata  ),
	.mst13_hs0_hrdata  (mst13_hs0_hrdata  ),
	.mst13_hs0_hready  (mst13_hs0_hready  ),
	.mst13_hs0_hresp   (mst13_hs0_hresp   ),
	.mst13_slv0_ack    (mst13_slv0_ack    ),
	.mst13_slv0_base   (mst13_slv0_base   ),
	.mst13_slv0_grant  (mst13_slv0_grant  ),
	.mst13_slv0_haddr  (mst13_slv0_haddr  ),
	.mst13_slv0_hburst (mst13_slv0_hburst ),
	.mst13_slv0_hprot  (mst13_slv0_hprot  ),
	.mst13_slv0_hsize  (mst13_slv0_hsize  ),
	.mst13_slv0_htrans (mst13_slv0_htrans ),
	.mst13_slv0_hwrite (mst13_slv0_hwrite ),
	.mst13_slv0_req    (mst13_slv0_req    ),
	.mst13_slv0_sel    (mst13_slv0_sel    ),
	.mst13_slv0_size   (mst13_slv0_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm13_slv1_hwdata  (hm13_slv1_hwdata  ),
	.mst13_hs1_hrdata  (mst13_hs1_hrdata  ),
	.mst13_hs1_hready  (mst13_hs1_hready  ),
	.mst13_hs1_hresp   (mst13_hs1_hresp   ),
	.mst13_slv1_ack    (mst13_slv1_ack    ),
	.mst13_slv1_base   (mst13_slv1_base   ),
	.mst13_slv1_grant  (mst13_slv1_grant  ),
	.mst13_slv1_haddr  (mst13_slv1_haddr  ),
	.mst13_slv1_hburst (mst13_slv1_hburst ),
	.mst13_slv1_hprot  (mst13_slv1_hprot  ),
	.mst13_slv1_hsize  (mst13_slv1_hsize  ),
	.mst13_slv1_htrans (mst13_slv1_htrans ),
	.mst13_slv1_hwrite (mst13_slv1_hwrite ),
	.mst13_slv1_req    (mst13_slv1_req    ),
	.mst13_slv1_sel    (mst13_slv1_sel    ),
	.mst13_slv1_size   (mst13_slv1_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm13_slv2_hwdata  (hm13_slv2_hwdata  ),
	.mst13_hs2_hrdata  (mst13_hs2_hrdata  ),
	.mst13_hs2_hready  (mst13_hs2_hready  ),
	.mst13_hs2_hresp   (mst13_hs2_hresp   ),
	.mst13_slv2_ack    (mst13_slv2_ack    ),
	.mst13_slv2_base   (mst13_slv2_base   ),
	.mst13_slv2_grant  (mst13_slv2_grant  ),
	.mst13_slv2_haddr  (mst13_slv2_haddr  ),
	.mst13_slv2_hburst (mst13_slv2_hburst ),
	.mst13_slv2_hprot  (mst13_slv2_hprot  ),
	.mst13_slv2_hsize  (mst13_slv2_hsize  ),
	.mst13_slv2_htrans (mst13_slv2_htrans ),
	.mst13_slv2_hwrite (mst13_slv2_hwrite ),
	.mst13_slv2_req    (mst13_slv2_req    ),
	.mst13_slv2_sel    (mst13_slv2_sel    ),
	.mst13_slv2_size   (mst13_slv2_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm13_slv3_hwdata  (hm13_slv3_hwdata  ),
	.mst13_hs3_hrdata  (mst13_hs3_hrdata  ),
	.mst13_hs3_hready  (mst13_hs3_hready  ),
	.mst13_hs3_hresp   (mst13_hs3_hresp   ),
	.mst13_slv3_ack    (mst13_slv3_ack    ),
	.mst13_slv3_base   (mst13_slv3_base   ),
	.mst13_slv3_grant  (mst13_slv3_grant  ),
	.mst13_slv3_haddr  (mst13_slv3_haddr  ),
	.mst13_slv3_hburst (mst13_slv3_hburst ),
	.mst13_slv3_hprot  (mst13_slv3_hprot  ),
	.mst13_slv3_hsize  (mst13_slv3_hsize  ),
	.mst13_slv3_htrans (mst13_slv3_htrans ),
	.mst13_slv3_hwrite (mst13_slv3_hwrite ),
	.mst13_slv3_req    (mst13_slv3_req    ),
	.mst13_slv3_sel    (mst13_slv3_sel    ),
	.mst13_slv3_size   (mst13_slv3_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm13_slv4_hwdata  (hm13_slv4_hwdata  ),
	.mst13_hs4_hrdata  (mst13_hs4_hrdata  ),
	.mst13_hs4_hready  (mst13_hs4_hready  ),
	.mst13_hs4_hresp   (mst13_hs4_hresp   ),
	.mst13_slv4_ack    (mst13_slv4_ack    ),
	.mst13_slv4_base   (mst13_slv4_base   ),
	.mst13_slv4_grant  (mst13_slv4_grant  ),
	.mst13_slv4_haddr  (mst13_slv4_haddr  ),
	.mst13_slv4_hburst (mst13_slv4_hburst ),
	.mst13_slv4_hprot  (mst13_slv4_hprot  ),
	.mst13_slv4_hsize  (mst13_slv4_hsize  ),
	.mst13_slv4_htrans (mst13_slv4_htrans ),
	.mst13_slv4_hwrite (mst13_slv4_hwrite ),
	.mst13_slv4_req    (mst13_slv4_req    ),
	.mst13_slv4_sel    (mst13_slv4_sel    ),
	.mst13_slv4_size   (mst13_slv4_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm13_slv5_hwdata  (hm13_slv5_hwdata  ),
	.mst13_hs5_hrdata  (mst13_hs5_hrdata  ),
	.mst13_hs5_hready  (mst13_hs5_hready  ),
	.mst13_hs5_hresp   (mst13_hs5_hresp   ),
	.mst13_slv5_ack    (mst13_slv5_ack    ),
	.mst13_slv5_base   (mst13_slv5_base   ),
	.mst13_slv5_grant  (mst13_slv5_grant  ),
	.mst13_slv5_haddr  (mst13_slv5_haddr  ),
	.mst13_slv5_hburst (mst13_slv5_hburst ),
	.mst13_slv5_hprot  (mst13_slv5_hprot  ),
	.mst13_slv5_hsize  (mst13_slv5_hsize  ),
	.mst13_slv5_htrans (mst13_slv5_htrans ),
	.mst13_slv5_hwrite (mst13_slv5_hwrite ),
	.mst13_slv5_req    (mst13_slv5_req    ),
	.mst13_slv5_sel    (mst13_slv5_sel    ),
	.mst13_slv5_size   (mst13_slv5_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm13_slv6_hwdata  (hm13_slv6_hwdata  ),
	.mst13_hs6_hrdata  (mst13_hs6_hrdata  ),
	.mst13_hs6_hready  (mst13_hs6_hready  ),
	.mst13_hs6_hresp   (mst13_hs6_hresp   ),
	.mst13_slv6_ack    (mst13_slv6_ack    ),
	.mst13_slv6_base   (mst13_slv6_base   ),
	.mst13_slv6_grant  (mst13_slv6_grant  ),
	.mst13_slv6_haddr  (mst13_slv6_haddr  ),
	.mst13_slv6_hburst (mst13_slv6_hburst ),
	.mst13_slv6_hprot  (mst13_slv6_hprot  ),
	.mst13_slv6_hsize  (mst13_slv6_hsize  ),
	.mst13_slv6_htrans (mst13_slv6_htrans ),
	.mst13_slv6_hwrite (mst13_slv6_hwrite ),
	.mst13_slv6_req    (mst13_slv6_req    ),
	.mst13_slv6_sel    (mst13_slv6_sel    ),
	.mst13_slv6_size   (mst13_slv6_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm13_slv7_hwdata  (hm13_slv7_hwdata  ),
	.mst13_hs7_hrdata  (mst13_hs7_hrdata  ),
	.mst13_hs7_hready  (mst13_hs7_hready  ),
	.mst13_hs7_hresp   (mst13_hs7_hresp   ),
	.mst13_slv7_ack    (mst13_slv7_ack    ),
	.mst13_slv7_base   (mst13_slv7_base   ),
	.mst13_slv7_grant  (mst13_slv7_grant  ),
	.mst13_slv7_haddr  (mst13_slv7_haddr  ),
	.mst13_slv7_hburst (mst13_slv7_hburst ),
	.mst13_slv7_hprot  (mst13_slv7_hprot  ),
	.mst13_slv7_hsize  (mst13_slv7_hsize  ),
	.mst13_slv7_htrans (mst13_slv7_htrans ),
	.mst13_slv7_hwrite (mst13_slv7_hwrite ),
	.mst13_slv7_req    (mst13_slv7_req    ),
	.mst13_slv7_sel    (mst13_slv7_sel    ),
	.mst13_slv7_size   (mst13_slv7_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm13_slv8_hwdata  (hm13_slv8_hwdata  ),
	.mst13_hs8_hrdata  (mst13_hs8_hrdata  ),
	.mst13_hs8_hready  (mst13_hs8_hready  ),
	.mst13_hs8_hresp   (mst13_hs8_hresp   ),
	.mst13_slv8_ack    (mst13_slv8_ack    ),
	.mst13_slv8_base   (mst13_slv8_base   ),
	.mst13_slv8_grant  (mst13_slv8_grant  ),
	.mst13_slv8_haddr  (mst13_slv8_haddr  ),
	.mst13_slv8_hburst (mst13_slv8_hburst ),
	.mst13_slv8_hprot  (mst13_slv8_hprot  ),
	.mst13_slv8_hsize  (mst13_slv8_hsize  ),
	.mst13_slv8_htrans (mst13_slv8_htrans ),
	.mst13_slv8_hwrite (mst13_slv8_hwrite ),
	.mst13_slv8_req    (mst13_slv8_req    ),
	.mst13_slv8_sel    (mst13_slv8_sel    ),
	.mst13_slv8_size   (mst13_slv8_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm13_slv9_hwdata  (hm13_slv9_hwdata  ),
	.mst13_hs9_hrdata  (mst13_hs9_hrdata  ),
	.mst13_hs9_hready  (mst13_hs9_hready  ),
	.mst13_hs9_hresp   (mst13_hs9_hresp   ),
	.mst13_slv9_ack    (mst13_slv9_ack    ),
	.mst13_slv9_base   (mst13_slv9_base   ),
	.mst13_slv9_grant  (mst13_slv9_grant  ),
	.mst13_slv9_haddr  (mst13_slv9_haddr  ),
	.mst13_slv9_hburst (mst13_slv9_hburst ),
	.mst13_slv9_hprot  (mst13_slv9_hprot  ),
	.mst13_slv9_hsize  (mst13_slv9_hsize  ),
	.mst13_slv9_htrans (mst13_slv9_htrans ),
	.mst13_slv9_hwrite (mst13_slv9_hwrite ),
	.mst13_slv9_req    (mst13_slv9_req    ),
	.mst13_slv9_sel    (mst13_slv9_sel    ),
	.mst13_slv9_size   (mst13_slv9_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm13_slv10_hwdata (hm13_slv10_hwdata ),
	.mst13_hs10_hrdata (mst13_hs10_hrdata ),
	.mst13_hs10_hready (mst13_hs10_hready ),
	.mst13_hs10_hresp  (mst13_hs10_hresp  ),
	.mst13_slv10_ack   (mst13_slv10_ack   ),
	.mst13_slv10_base  (mst13_slv10_base  ),
	.mst13_slv10_grant (mst13_slv10_grant ),
	.mst13_slv10_haddr (mst13_slv10_haddr ),
	.mst13_slv10_hburst(mst13_slv10_hburst),
	.mst13_slv10_hprot (mst13_slv10_hprot ),
	.mst13_slv10_hsize (mst13_slv10_hsize ),
	.mst13_slv10_htrans(mst13_slv10_htrans),
	.mst13_slv10_hwrite(mst13_slv10_hwrite),
	.mst13_slv10_req   (mst13_slv10_req   ),
	.mst13_slv10_sel   (mst13_slv10_sel   ),
	.mst13_slv10_size  (mst13_slv10_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm13_slv11_hwdata (hm13_slv11_hwdata ),
	.mst13_hs11_hrdata (mst13_hs11_hrdata ),
	.mst13_hs11_hready (mst13_hs11_hready ),
	.mst13_hs11_hresp  (mst13_hs11_hresp  ),
	.mst13_slv11_ack   (mst13_slv11_ack   ),
	.mst13_slv11_base  (mst13_slv11_base  ),
	.mst13_slv11_grant (mst13_slv11_grant ),
	.mst13_slv11_haddr (mst13_slv11_haddr ),
	.mst13_slv11_hburst(mst13_slv11_hburst),
	.mst13_slv11_hprot (mst13_slv11_hprot ),
	.mst13_slv11_hsize (mst13_slv11_hsize ),
	.mst13_slv11_htrans(mst13_slv11_htrans),
	.mst13_slv11_hwrite(mst13_slv11_hwrite),
	.mst13_slv11_req   (mst13_slv11_req   ),
	.mst13_slv11_sel   (mst13_slv11_sel   ),
	.mst13_slv11_size  (mst13_slv11_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm13_slv12_hwdata (hm13_slv12_hwdata ),
	.mst13_hs12_hrdata (mst13_hs12_hrdata ),
	.mst13_hs12_hready (mst13_hs12_hready ),
	.mst13_hs12_hresp  (mst13_hs12_hresp  ),
	.mst13_slv12_ack   (mst13_slv12_ack   ),
	.mst13_slv12_base  (mst13_slv12_base  ),
	.mst13_slv12_grant (mst13_slv12_grant ),
	.mst13_slv12_haddr (mst13_slv12_haddr ),
	.mst13_slv12_hburst(mst13_slv12_hburst),
	.mst13_slv12_hprot (mst13_slv12_hprot ),
	.mst13_slv12_hsize (mst13_slv12_hsize ),
	.mst13_slv12_htrans(mst13_slv12_htrans),
	.mst13_slv12_hwrite(mst13_slv12_hwrite),
	.mst13_slv12_req   (mst13_slv12_req   ),
	.mst13_slv12_sel   (mst13_slv12_sel   ),
	.mst13_slv12_size  (mst13_slv12_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm13_slv13_hwdata (hm13_slv13_hwdata ),
	.mst13_hs13_hrdata (mst13_hs13_hrdata ),
	.mst13_hs13_hready (mst13_hs13_hready ),
	.mst13_hs13_hresp  (mst13_hs13_hresp  ),
	.mst13_slv13_ack   (mst13_slv13_ack   ),
	.mst13_slv13_base  (mst13_slv13_base  ),
	.mst13_slv13_grant (mst13_slv13_grant ),
	.mst13_slv13_haddr (mst13_slv13_haddr ),
	.mst13_slv13_hburst(mst13_slv13_hburst),
	.mst13_slv13_hprot (mst13_slv13_hprot ),
	.mst13_slv13_hsize (mst13_slv13_hsize ),
	.mst13_slv13_htrans(mst13_slv13_htrans),
	.mst13_slv13_hwrite(mst13_slv13_hwrite),
	.mst13_slv13_req   (mst13_slv13_req   ),
	.mst13_slv13_sel   (mst13_slv13_sel   ),
	.mst13_slv13_size  (mst13_slv13_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm13_slv14_hwdata (hm13_slv14_hwdata ),
	.mst13_hs14_hrdata (mst13_hs14_hrdata ),
	.mst13_hs14_hready (mst13_hs14_hready ),
	.mst13_hs14_hresp  (mst13_hs14_hresp  ),
	.mst13_slv14_ack   (mst13_slv14_ack   ),
	.mst13_slv14_base  (mst13_slv14_base  ),
	.mst13_slv14_grant (mst13_slv14_grant ),
	.mst13_slv14_haddr (mst13_slv14_haddr ),
	.mst13_slv14_hburst(mst13_slv14_hburst),
	.mst13_slv14_hprot (mst13_slv14_hprot ),
	.mst13_slv14_hsize (mst13_slv14_hsize ),
	.mst13_slv14_htrans(mst13_slv14_htrans),
	.mst13_slv14_hwrite(mst13_slv14_hwrite),
	.mst13_slv14_req   (mst13_slv14_req   ),
	.mst13_slv14_sel   (mst13_slv14_sel   ),
	.mst13_slv14_size  (mst13_slv14_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm13_slv15_hwdata (hm13_slv15_hwdata ),
	.mst13_hs15_hrdata (mst13_hs15_hrdata ),
	.mst13_hs15_hready (mst13_hs15_hready ),
	.mst13_hs15_hresp  (mst13_hs15_hresp  ),
	.mst13_slv15_ack   (mst13_slv15_ack   ),
	.mst13_slv15_base  (mst13_slv15_base  ),
	.mst13_slv15_grant (mst13_slv15_grant ),
	.mst13_slv15_haddr (mst13_slv15_haddr ),
	.mst13_slv15_hburst(mst13_slv15_hburst),
	.mst13_slv15_hprot (mst13_slv15_hprot ),
	.mst13_slv15_hsize (mst13_slv15_hsize ),
	.mst13_slv15_htrans(mst13_slv15_htrans),
	.mst13_slv15_hwrite(mst13_slv15_hwrite),
	.mst13_slv15_req   (mst13_slv15_req   ),
	.mst13_slv15_sel   (mst13_slv15_sel   ),
	.mst13_slv15_size  (mst13_slv15_size  ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST14
   `ifdef ATCBMC200_AHB_SLV0
	.hm14_slv0_hwdata  (hm14_slv0_hwdata  ),
	.mst14_hs0_hrdata  (mst14_hs0_hrdata  ),
	.mst14_hs0_hready  (mst14_hs0_hready  ),
	.mst14_hs0_hresp   (mst14_hs0_hresp   ),
	.mst14_slv0_ack    (mst14_slv0_ack    ),
	.mst14_slv0_base   (mst14_slv0_base   ),
	.mst14_slv0_grant  (mst14_slv0_grant  ),
	.mst14_slv0_haddr  (mst14_slv0_haddr  ),
	.mst14_slv0_hburst (mst14_slv0_hburst ),
	.mst14_slv0_hprot  (mst14_slv0_hprot  ),
	.mst14_slv0_hsize  (mst14_slv0_hsize  ),
	.mst14_slv0_htrans (mst14_slv0_htrans ),
	.mst14_slv0_hwrite (mst14_slv0_hwrite ),
	.mst14_slv0_req    (mst14_slv0_req    ),
	.mst14_slv0_sel    (mst14_slv0_sel    ),
	.mst14_slv0_size   (mst14_slv0_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm14_slv1_hwdata  (hm14_slv1_hwdata  ),
	.mst14_hs1_hrdata  (mst14_hs1_hrdata  ),
	.mst14_hs1_hready  (mst14_hs1_hready  ),
	.mst14_hs1_hresp   (mst14_hs1_hresp   ),
	.mst14_slv1_ack    (mst14_slv1_ack    ),
	.mst14_slv1_base   (mst14_slv1_base   ),
	.mst14_slv1_grant  (mst14_slv1_grant  ),
	.mst14_slv1_haddr  (mst14_slv1_haddr  ),
	.mst14_slv1_hburst (mst14_slv1_hburst ),
	.mst14_slv1_hprot  (mst14_slv1_hprot  ),
	.mst14_slv1_hsize  (mst14_slv1_hsize  ),
	.mst14_slv1_htrans (mst14_slv1_htrans ),
	.mst14_slv1_hwrite (mst14_slv1_hwrite ),
	.mst14_slv1_req    (mst14_slv1_req    ),
	.mst14_slv1_sel    (mst14_slv1_sel    ),
	.mst14_slv1_size   (mst14_slv1_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm14_slv2_hwdata  (hm14_slv2_hwdata  ),
	.mst14_hs2_hrdata  (mst14_hs2_hrdata  ),
	.mst14_hs2_hready  (mst14_hs2_hready  ),
	.mst14_hs2_hresp   (mst14_hs2_hresp   ),
	.mst14_slv2_ack    (mst14_slv2_ack    ),
	.mst14_slv2_base   (mst14_slv2_base   ),
	.mst14_slv2_grant  (mst14_slv2_grant  ),
	.mst14_slv2_haddr  (mst14_slv2_haddr  ),
	.mst14_slv2_hburst (mst14_slv2_hburst ),
	.mst14_slv2_hprot  (mst14_slv2_hprot  ),
	.mst14_slv2_hsize  (mst14_slv2_hsize  ),
	.mst14_slv2_htrans (mst14_slv2_htrans ),
	.mst14_slv2_hwrite (mst14_slv2_hwrite ),
	.mst14_slv2_req    (mst14_slv2_req    ),
	.mst14_slv2_sel    (mst14_slv2_sel    ),
	.mst14_slv2_size   (mst14_slv2_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm14_slv3_hwdata  (hm14_slv3_hwdata  ),
	.mst14_hs3_hrdata  (mst14_hs3_hrdata  ),
	.mst14_hs3_hready  (mst14_hs3_hready  ),
	.mst14_hs3_hresp   (mst14_hs3_hresp   ),
	.mst14_slv3_ack    (mst14_slv3_ack    ),
	.mst14_slv3_base   (mst14_slv3_base   ),
	.mst14_slv3_grant  (mst14_slv3_grant  ),
	.mst14_slv3_haddr  (mst14_slv3_haddr  ),
	.mst14_slv3_hburst (mst14_slv3_hburst ),
	.mst14_slv3_hprot  (mst14_slv3_hprot  ),
	.mst14_slv3_hsize  (mst14_slv3_hsize  ),
	.mst14_slv3_htrans (mst14_slv3_htrans ),
	.mst14_slv3_hwrite (mst14_slv3_hwrite ),
	.mst14_slv3_req    (mst14_slv3_req    ),
	.mst14_slv3_sel    (mst14_slv3_sel    ),
	.mst14_slv3_size   (mst14_slv3_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm14_slv4_hwdata  (hm14_slv4_hwdata  ),
	.mst14_hs4_hrdata  (mst14_hs4_hrdata  ),
	.mst14_hs4_hready  (mst14_hs4_hready  ),
	.mst14_hs4_hresp   (mst14_hs4_hresp   ),
	.mst14_slv4_ack    (mst14_slv4_ack    ),
	.mst14_slv4_base   (mst14_slv4_base   ),
	.mst14_slv4_grant  (mst14_slv4_grant  ),
	.mst14_slv4_haddr  (mst14_slv4_haddr  ),
	.mst14_slv4_hburst (mst14_slv4_hburst ),
	.mst14_slv4_hprot  (mst14_slv4_hprot  ),
	.mst14_slv4_hsize  (mst14_slv4_hsize  ),
	.mst14_slv4_htrans (mst14_slv4_htrans ),
	.mst14_slv4_hwrite (mst14_slv4_hwrite ),
	.mst14_slv4_req    (mst14_slv4_req    ),
	.mst14_slv4_sel    (mst14_slv4_sel    ),
	.mst14_slv4_size   (mst14_slv4_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm14_slv5_hwdata  (hm14_slv5_hwdata  ),
	.mst14_hs5_hrdata  (mst14_hs5_hrdata  ),
	.mst14_hs5_hready  (mst14_hs5_hready  ),
	.mst14_hs5_hresp   (mst14_hs5_hresp   ),
	.mst14_slv5_ack    (mst14_slv5_ack    ),
	.mst14_slv5_base   (mst14_slv5_base   ),
	.mst14_slv5_grant  (mst14_slv5_grant  ),
	.mst14_slv5_haddr  (mst14_slv5_haddr  ),
	.mst14_slv5_hburst (mst14_slv5_hburst ),
	.mst14_slv5_hprot  (mst14_slv5_hprot  ),
	.mst14_slv5_hsize  (mst14_slv5_hsize  ),
	.mst14_slv5_htrans (mst14_slv5_htrans ),
	.mst14_slv5_hwrite (mst14_slv5_hwrite ),
	.mst14_slv5_req    (mst14_slv5_req    ),
	.mst14_slv5_sel    (mst14_slv5_sel    ),
	.mst14_slv5_size   (mst14_slv5_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm14_slv6_hwdata  (hm14_slv6_hwdata  ),
	.mst14_hs6_hrdata  (mst14_hs6_hrdata  ),
	.mst14_hs6_hready  (mst14_hs6_hready  ),
	.mst14_hs6_hresp   (mst14_hs6_hresp   ),
	.mst14_slv6_ack    (mst14_slv6_ack    ),
	.mst14_slv6_base   (mst14_slv6_base   ),
	.mst14_slv6_grant  (mst14_slv6_grant  ),
	.mst14_slv6_haddr  (mst14_slv6_haddr  ),
	.mst14_slv6_hburst (mst14_slv6_hburst ),
	.mst14_slv6_hprot  (mst14_slv6_hprot  ),
	.mst14_slv6_hsize  (mst14_slv6_hsize  ),
	.mst14_slv6_htrans (mst14_slv6_htrans ),
	.mst14_slv6_hwrite (mst14_slv6_hwrite ),
	.mst14_slv6_req    (mst14_slv6_req    ),
	.mst14_slv6_sel    (mst14_slv6_sel    ),
	.mst14_slv6_size   (mst14_slv6_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm14_slv7_hwdata  (hm14_slv7_hwdata  ),
	.mst14_hs7_hrdata  (mst14_hs7_hrdata  ),
	.mst14_hs7_hready  (mst14_hs7_hready  ),
	.mst14_hs7_hresp   (mst14_hs7_hresp   ),
	.mst14_slv7_ack    (mst14_slv7_ack    ),
	.mst14_slv7_base   (mst14_slv7_base   ),
	.mst14_slv7_grant  (mst14_slv7_grant  ),
	.mst14_slv7_haddr  (mst14_slv7_haddr  ),
	.mst14_slv7_hburst (mst14_slv7_hburst ),
	.mst14_slv7_hprot  (mst14_slv7_hprot  ),
	.mst14_slv7_hsize  (mst14_slv7_hsize  ),
	.mst14_slv7_htrans (mst14_slv7_htrans ),
	.mst14_slv7_hwrite (mst14_slv7_hwrite ),
	.mst14_slv7_req    (mst14_slv7_req    ),
	.mst14_slv7_sel    (mst14_slv7_sel    ),
	.mst14_slv7_size   (mst14_slv7_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm14_slv8_hwdata  (hm14_slv8_hwdata  ),
	.mst14_hs8_hrdata  (mst14_hs8_hrdata  ),
	.mst14_hs8_hready  (mst14_hs8_hready  ),
	.mst14_hs8_hresp   (mst14_hs8_hresp   ),
	.mst14_slv8_ack    (mst14_slv8_ack    ),
	.mst14_slv8_base   (mst14_slv8_base   ),
	.mst14_slv8_grant  (mst14_slv8_grant  ),
	.mst14_slv8_haddr  (mst14_slv8_haddr  ),
	.mst14_slv8_hburst (mst14_slv8_hburst ),
	.mst14_slv8_hprot  (mst14_slv8_hprot  ),
	.mst14_slv8_hsize  (mst14_slv8_hsize  ),
	.mst14_slv8_htrans (mst14_slv8_htrans ),
	.mst14_slv8_hwrite (mst14_slv8_hwrite ),
	.mst14_slv8_req    (mst14_slv8_req    ),
	.mst14_slv8_sel    (mst14_slv8_sel    ),
	.mst14_slv8_size   (mst14_slv8_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm14_slv9_hwdata  (hm14_slv9_hwdata  ),
	.mst14_hs9_hrdata  (mst14_hs9_hrdata  ),
	.mst14_hs9_hready  (mst14_hs9_hready  ),
	.mst14_hs9_hresp   (mst14_hs9_hresp   ),
	.mst14_slv9_ack    (mst14_slv9_ack    ),
	.mst14_slv9_base   (mst14_slv9_base   ),
	.mst14_slv9_grant  (mst14_slv9_grant  ),
	.mst14_slv9_haddr  (mst14_slv9_haddr  ),
	.mst14_slv9_hburst (mst14_slv9_hburst ),
	.mst14_slv9_hprot  (mst14_slv9_hprot  ),
	.mst14_slv9_hsize  (mst14_slv9_hsize  ),
	.mst14_slv9_htrans (mst14_slv9_htrans ),
	.mst14_slv9_hwrite (mst14_slv9_hwrite ),
	.mst14_slv9_req    (mst14_slv9_req    ),
	.mst14_slv9_sel    (mst14_slv9_sel    ),
	.mst14_slv9_size   (mst14_slv9_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm14_slv10_hwdata (hm14_slv10_hwdata ),
	.mst14_hs10_hrdata (mst14_hs10_hrdata ),
	.mst14_hs10_hready (mst14_hs10_hready ),
	.mst14_hs10_hresp  (mst14_hs10_hresp  ),
	.mst14_slv10_ack   (mst14_slv10_ack   ),
	.mst14_slv10_base  (mst14_slv10_base  ),
	.mst14_slv10_grant (mst14_slv10_grant ),
	.mst14_slv10_haddr (mst14_slv10_haddr ),
	.mst14_slv10_hburst(mst14_slv10_hburst),
	.mst14_slv10_hprot (mst14_slv10_hprot ),
	.mst14_slv10_hsize (mst14_slv10_hsize ),
	.mst14_slv10_htrans(mst14_slv10_htrans),
	.mst14_slv10_hwrite(mst14_slv10_hwrite),
	.mst14_slv10_req   (mst14_slv10_req   ),
	.mst14_slv10_sel   (mst14_slv10_sel   ),
	.mst14_slv10_size  (mst14_slv10_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm14_slv11_hwdata (hm14_slv11_hwdata ),
	.mst14_hs11_hrdata (mst14_hs11_hrdata ),
	.mst14_hs11_hready (mst14_hs11_hready ),
	.mst14_hs11_hresp  (mst14_hs11_hresp  ),
	.mst14_slv11_ack   (mst14_slv11_ack   ),
	.mst14_slv11_base  (mst14_slv11_base  ),
	.mst14_slv11_grant (mst14_slv11_grant ),
	.mst14_slv11_haddr (mst14_slv11_haddr ),
	.mst14_slv11_hburst(mst14_slv11_hburst),
	.mst14_slv11_hprot (mst14_slv11_hprot ),
	.mst14_slv11_hsize (mst14_slv11_hsize ),
	.mst14_slv11_htrans(mst14_slv11_htrans),
	.mst14_slv11_hwrite(mst14_slv11_hwrite),
	.mst14_slv11_req   (mst14_slv11_req   ),
	.mst14_slv11_sel   (mst14_slv11_sel   ),
	.mst14_slv11_size  (mst14_slv11_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm14_slv12_hwdata (hm14_slv12_hwdata ),
	.mst14_hs12_hrdata (mst14_hs12_hrdata ),
	.mst14_hs12_hready (mst14_hs12_hready ),
	.mst14_hs12_hresp  (mst14_hs12_hresp  ),
	.mst14_slv12_ack   (mst14_slv12_ack   ),
	.mst14_slv12_base  (mst14_slv12_base  ),
	.mst14_slv12_grant (mst14_slv12_grant ),
	.mst14_slv12_haddr (mst14_slv12_haddr ),
	.mst14_slv12_hburst(mst14_slv12_hburst),
	.mst14_slv12_hprot (mst14_slv12_hprot ),
	.mst14_slv12_hsize (mst14_slv12_hsize ),
	.mst14_slv12_htrans(mst14_slv12_htrans),
	.mst14_slv12_hwrite(mst14_slv12_hwrite),
	.mst14_slv12_req   (mst14_slv12_req   ),
	.mst14_slv12_sel   (mst14_slv12_sel   ),
	.mst14_slv12_size  (mst14_slv12_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm14_slv13_hwdata (hm14_slv13_hwdata ),
	.mst14_hs13_hrdata (mst14_hs13_hrdata ),
	.mst14_hs13_hready (mst14_hs13_hready ),
	.mst14_hs13_hresp  (mst14_hs13_hresp  ),
	.mst14_slv13_ack   (mst14_slv13_ack   ),
	.mst14_slv13_base  (mst14_slv13_base  ),
	.mst14_slv13_grant (mst14_slv13_grant ),
	.mst14_slv13_haddr (mst14_slv13_haddr ),
	.mst14_slv13_hburst(mst14_slv13_hburst),
	.mst14_slv13_hprot (mst14_slv13_hprot ),
	.mst14_slv13_hsize (mst14_slv13_hsize ),
	.mst14_slv13_htrans(mst14_slv13_htrans),
	.mst14_slv13_hwrite(mst14_slv13_hwrite),
	.mst14_slv13_req   (mst14_slv13_req   ),
	.mst14_slv13_sel   (mst14_slv13_sel   ),
	.mst14_slv13_size  (mst14_slv13_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm14_slv14_hwdata (hm14_slv14_hwdata ),
	.mst14_hs14_hrdata (mst14_hs14_hrdata ),
	.mst14_hs14_hready (mst14_hs14_hready ),
	.mst14_hs14_hresp  (mst14_hs14_hresp  ),
	.mst14_slv14_ack   (mst14_slv14_ack   ),
	.mst14_slv14_base  (mst14_slv14_base  ),
	.mst14_slv14_grant (mst14_slv14_grant ),
	.mst14_slv14_haddr (mst14_slv14_haddr ),
	.mst14_slv14_hburst(mst14_slv14_hburst),
	.mst14_slv14_hprot (mst14_slv14_hprot ),
	.mst14_slv14_hsize (mst14_slv14_hsize ),
	.mst14_slv14_htrans(mst14_slv14_htrans),
	.mst14_slv14_hwrite(mst14_slv14_hwrite),
	.mst14_slv14_req   (mst14_slv14_req   ),
	.mst14_slv14_sel   (mst14_slv14_sel   ),
	.mst14_slv14_size  (mst14_slv14_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm14_slv15_hwdata (hm14_slv15_hwdata ),
	.mst14_hs15_hrdata (mst14_hs15_hrdata ),
	.mst14_hs15_hready (mst14_hs15_hready ),
	.mst14_hs15_hresp  (mst14_hs15_hresp  ),
	.mst14_slv15_ack   (mst14_slv15_ack   ),
	.mst14_slv15_base  (mst14_slv15_base  ),
	.mst14_slv15_grant (mst14_slv15_grant ),
	.mst14_slv15_haddr (mst14_slv15_haddr ),
	.mst14_slv15_hburst(mst14_slv15_hburst),
	.mst14_slv15_hprot (mst14_slv15_hprot ),
	.mst14_slv15_hsize (mst14_slv15_hsize ),
	.mst14_slv15_htrans(mst14_slv15_htrans),
	.mst14_slv15_hwrite(mst14_slv15_hwrite),
	.mst14_slv15_req   (mst14_slv15_req   ),
	.mst14_slv15_sel   (mst14_slv15_sel   ),
	.mst14_slv15_size  (mst14_slv15_size  ),
   `endif
`endif
`ifdef ATCBMC200_AHB_MST15
   `ifdef ATCBMC200_AHB_SLV0
	.hm15_slv0_hwdata  (hm15_slv0_hwdata  ),
	.mst15_hs0_hrdata  (mst15_hs0_hrdata  ),
	.mst15_hs0_hready  (mst15_hs0_hready  ),
	.mst15_hs0_hresp   (mst15_hs0_hresp   ),
	.mst15_slv0_ack    (mst15_slv0_ack    ),
	.mst15_slv0_base   (mst15_slv0_base   ),
	.mst15_slv0_grant  (mst15_slv0_grant  ),
	.mst15_slv0_haddr  (mst15_slv0_haddr  ),
	.mst15_slv0_hburst (mst15_slv0_hburst ),
	.mst15_slv0_hprot  (mst15_slv0_hprot  ),
	.mst15_slv0_hsize  (mst15_slv0_hsize  ),
	.mst15_slv0_htrans (mst15_slv0_htrans ),
	.mst15_slv0_hwrite (mst15_slv0_hwrite ),
	.mst15_slv0_req    (mst15_slv0_req    ),
	.mst15_slv0_sel    (mst15_slv0_sel    ),
	.mst15_slv0_size   (mst15_slv0_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hm15_slv1_hwdata  (hm15_slv1_hwdata  ),
	.mst15_hs1_hrdata  (mst15_hs1_hrdata  ),
	.mst15_hs1_hready  (mst15_hs1_hready  ),
	.mst15_hs1_hresp   (mst15_hs1_hresp   ),
	.mst15_slv1_ack    (mst15_slv1_ack    ),
	.mst15_slv1_base   (mst15_slv1_base   ),
	.mst15_slv1_grant  (mst15_slv1_grant  ),
	.mst15_slv1_haddr  (mst15_slv1_haddr  ),
	.mst15_slv1_hburst (mst15_slv1_hburst ),
	.mst15_slv1_hprot  (mst15_slv1_hprot  ),
	.mst15_slv1_hsize  (mst15_slv1_hsize  ),
	.mst15_slv1_htrans (mst15_slv1_htrans ),
	.mst15_slv1_hwrite (mst15_slv1_hwrite ),
	.mst15_slv1_req    (mst15_slv1_req    ),
	.mst15_slv1_sel    (mst15_slv1_sel    ),
	.mst15_slv1_size   (mst15_slv1_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hm15_slv2_hwdata  (hm15_slv2_hwdata  ),
	.mst15_hs2_hrdata  (mst15_hs2_hrdata  ),
	.mst15_hs2_hready  (mst15_hs2_hready  ),
	.mst15_hs2_hresp   (mst15_hs2_hresp   ),
	.mst15_slv2_ack    (mst15_slv2_ack    ),
	.mst15_slv2_base   (mst15_slv2_base   ),
	.mst15_slv2_grant  (mst15_slv2_grant  ),
	.mst15_slv2_haddr  (mst15_slv2_haddr  ),
	.mst15_slv2_hburst (mst15_slv2_hburst ),
	.mst15_slv2_hprot  (mst15_slv2_hprot  ),
	.mst15_slv2_hsize  (mst15_slv2_hsize  ),
	.mst15_slv2_htrans (mst15_slv2_htrans ),
	.mst15_slv2_hwrite (mst15_slv2_hwrite ),
	.mst15_slv2_req    (mst15_slv2_req    ),
	.mst15_slv2_sel    (mst15_slv2_sel    ),
	.mst15_slv2_size   (mst15_slv2_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hm15_slv3_hwdata  (hm15_slv3_hwdata  ),
	.mst15_hs3_hrdata  (mst15_hs3_hrdata  ),
	.mst15_hs3_hready  (mst15_hs3_hready  ),
	.mst15_hs3_hresp   (mst15_hs3_hresp   ),
	.mst15_slv3_ack    (mst15_slv3_ack    ),
	.mst15_slv3_base   (mst15_slv3_base   ),
	.mst15_slv3_grant  (mst15_slv3_grant  ),
	.mst15_slv3_haddr  (mst15_slv3_haddr  ),
	.mst15_slv3_hburst (mst15_slv3_hburst ),
	.mst15_slv3_hprot  (mst15_slv3_hprot  ),
	.mst15_slv3_hsize  (mst15_slv3_hsize  ),
	.mst15_slv3_htrans (mst15_slv3_htrans ),
	.mst15_slv3_hwrite (mst15_slv3_hwrite ),
	.mst15_slv3_req    (mst15_slv3_req    ),
	.mst15_slv3_sel    (mst15_slv3_sel    ),
	.mst15_slv3_size   (mst15_slv3_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hm15_slv4_hwdata  (hm15_slv4_hwdata  ),
	.mst15_hs4_hrdata  (mst15_hs4_hrdata  ),
	.mst15_hs4_hready  (mst15_hs4_hready  ),
	.mst15_hs4_hresp   (mst15_hs4_hresp   ),
	.mst15_slv4_ack    (mst15_slv4_ack    ),
	.mst15_slv4_base   (mst15_slv4_base   ),
	.mst15_slv4_grant  (mst15_slv4_grant  ),
	.mst15_slv4_haddr  (mst15_slv4_haddr  ),
	.mst15_slv4_hburst (mst15_slv4_hburst ),
	.mst15_slv4_hprot  (mst15_slv4_hprot  ),
	.mst15_slv4_hsize  (mst15_slv4_hsize  ),
	.mst15_slv4_htrans (mst15_slv4_htrans ),
	.mst15_slv4_hwrite (mst15_slv4_hwrite ),
	.mst15_slv4_req    (mst15_slv4_req    ),
	.mst15_slv4_sel    (mst15_slv4_sel    ),
	.mst15_slv4_size   (mst15_slv4_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hm15_slv5_hwdata  (hm15_slv5_hwdata  ),
	.mst15_hs5_hrdata  (mst15_hs5_hrdata  ),
	.mst15_hs5_hready  (mst15_hs5_hready  ),
	.mst15_hs5_hresp   (mst15_hs5_hresp   ),
	.mst15_slv5_ack    (mst15_slv5_ack    ),
	.mst15_slv5_base   (mst15_slv5_base   ),
	.mst15_slv5_grant  (mst15_slv5_grant  ),
	.mst15_slv5_haddr  (mst15_slv5_haddr  ),
	.mst15_slv5_hburst (mst15_slv5_hburst ),
	.mst15_slv5_hprot  (mst15_slv5_hprot  ),
	.mst15_slv5_hsize  (mst15_slv5_hsize  ),
	.mst15_slv5_htrans (mst15_slv5_htrans ),
	.mst15_slv5_hwrite (mst15_slv5_hwrite ),
	.mst15_slv5_req    (mst15_slv5_req    ),
	.mst15_slv5_sel    (mst15_slv5_sel    ),
	.mst15_slv5_size   (mst15_slv5_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hm15_slv6_hwdata  (hm15_slv6_hwdata  ),
	.mst15_hs6_hrdata  (mst15_hs6_hrdata  ),
	.mst15_hs6_hready  (mst15_hs6_hready  ),
	.mst15_hs6_hresp   (mst15_hs6_hresp   ),
	.mst15_slv6_ack    (mst15_slv6_ack    ),
	.mst15_slv6_base   (mst15_slv6_base   ),
	.mst15_slv6_grant  (mst15_slv6_grant  ),
	.mst15_slv6_haddr  (mst15_slv6_haddr  ),
	.mst15_slv6_hburst (mst15_slv6_hburst ),
	.mst15_slv6_hprot  (mst15_slv6_hprot  ),
	.mst15_slv6_hsize  (mst15_slv6_hsize  ),
	.mst15_slv6_htrans (mst15_slv6_htrans ),
	.mst15_slv6_hwrite (mst15_slv6_hwrite ),
	.mst15_slv6_req    (mst15_slv6_req    ),
	.mst15_slv6_sel    (mst15_slv6_sel    ),
	.mst15_slv6_size   (mst15_slv6_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hm15_slv7_hwdata  (hm15_slv7_hwdata  ),
	.mst15_hs7_hrdata  (mst15_hs7_hrdata  ),
	.mst15_hs7_hready  (mst15_hs7_hready  ),
	.mst15_hs7_hresp   (mst15_hs7_hresp   ),
	.mst15_slv7_ack    (mst15_slv7_ack    ),
	.mst15_slv7_base   (mst15_slv7_base   ),
	.mst15_slv7_grant  (mst15_slv7_grant  ),
	.mst15_slv7_haddr  (mst15_slv7_haddr  ),
	.mst15_slv7_hburst (mst15_slv7_hburst ),
	.mst15_slv7_hprot  (mst15_slv7_hprot  ),
	.mst15_slv7_hsize  (mst15_slv7_hsize  ),
	.mst15_slv7_htrans (mst15_slv7_htrans ),
	.mst15_slv7_hwrite (mst15_slv7_hwrite ),
	.mst15_slv7_req    (mst15_slv7_req    ),
	.mst15_slv7_sel    (mst15_slv7_sel    ),
	.mst15_slv7_size   (mst15_slv7_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hm15_slv8_hwdata  (hm15_slv8_hwdata  ),
	.mst15_hs8_hrdata  (mst15_hs8_hrdata  ),
	.mst15_hs8_hready  (mst15_hs8_hready  ),
	.mst15_hs8_hresp   (mst15_hs8_hresp   ),
	.mst15_slv8_ack    (mst15_slv8_ack    ),
	.mst15_slv8_base   (mst15_slv8_base   ),
	.mst15_slv8_grant  (mst15_slv8_grant  ),
	.mst15_slv8_haddr  (mst15_slv8_haddr  ),
	.mst15_slv8_hburst (mst15_slv8_hburst ),
	.mst15_slv8_hprot  (mst15_slv8_hprot  ),
	.mst15_slv8_hsize  (mst15_slv8_hsize  ),
	.mst15_slv8_htrans (mst15_slv8_htrans ),
	.mst15_slv8_hwrite (mst15_slv8_hwrite ),
	.mst15_slv8_req    (mst15_slv8_req    ),
	.mst15_slv8_sel    (mst15_slv8_sel    ),
	.mst15_slv8_size   (mst15_slv8_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hm15_slv9_hwdata  (hm15_slv9_hwdata  ),
	.mst15_hs9_hrdata  (mst15_hs9_hrdata  ),
	.mst15_hs9_hready  (mst15_hs9_hready  ),
	.mst15_hs9_hresp   (mst15_hs9_hresp   ),
	.mst15_slv9_ack    (mst15_slv9_ack    ),
	.mst15_slv9_base   (mst15_slv9_base   ),
	.mst15_slv9_grant  (mst15_slv9_grant  ),
	.mst15_slv9_haddr  (mst15_slv9_haddr  ),
	.mst15_slv9_hburst (mst15_slv9_hburst ),
	.mst15_slv9_hprot  (mst15_slv9_hprot  ),
	.mst15_slv9_hsize  (mst15_slv9_hsize  ),
	.mst15_slv9_htrans (mst15_slv9_htrans ),
	.mst15_slv9_hwrite (mst15_slv9_hwrite ),
	.mst15_slv9_req    (mst15_slv9_req    ),
	.mst15_slv9_sel    (mst15_slv9_sel    ),
	.mst15_slv9_size   (mst15_slv9_size   ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hm15_slv10_hwdata (hm15_slv10_hwdata ),
	.mst15_hs10_hrdata (mst15_hs10_hrdata ),
	.mst15_hs10_hready (mst15_hs10_hready ),
	.mst15_hs10_hresp  (mst15_hs10_hresp  ),
	.mst15_slv10_ack   (mst15_slv10_ack   ),
	.mst15_slv10_base  (mst15_slv10_base  ),
	.mst15_slv10_grant (mst15_slv10_grant ),
	.mst15_slv10_haddr (mst15_slv10_haddr ),
	.mst15_slv10_hburst(mst15_slv10_hburst),
	.mst15_slv10_hprot (mst15_slv10_hprot ),
	.mst15_slv10_hsize (mst15_slv10_hsize ),
	.mst15_slv10_htrans(mst15_slv10_htrans),
	.mst15_slv10_hwrite(mst15_slv10_hwrite),
	.mst15_slv10_req   (mst15_slv10_req   ),
	.mst15_slv10_sel   (mst15_slv10_sel   ),
	.mst15_slv10_size  (mst15_slv10_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hm15_slv11_hwdata (hm15_slv11_hwdata ),
	.mst15_hs11_hrdata (mst15_hs11_hrdata ),
	.mst15_hs11_hready (mst15_hs11_hready ),
	.mst15_hs11_hresp  (mst15_hs11_hresp  ),
	.mst15_slv11_ack   (mst15_slv11_ack   ),
	.mst15_slv11_base  (mst15_slv11_base  ),
	.mst15_slv11_grant (mst15_slv11_grant ),
	.mst15_slv11_haddr (mst15_slv11_haddr ),
	.mst15_slv11_hburst(mst15_slv11_hburst),
	.mst15_slv11_hprot (mst15_slv11_hprot ),
	.mst15_slv11_hsize (mst15_slv11_hsize ),
	.mst15_slv11_htrans(mst15_slv11_htrans),
	.mst15_slv11_hwrite(mst15_slv11_hwrite),
	.mst15_slv11_req   (mst15_slv11_req   ),
	.mst15_slv11_sel   (mst15_slv11_sel   ),
	.mst15_slv11_size  (mst15_slv11_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hm15_slv12_hwdata (hm15_slv12_hwdata ),
	.mst15_hs12_hrdata (mst15_hs12_hrdata ),
	.mst15_hs12_hready (mst15_hs12_hready ),
	.mst15_hs12_hresp  (mst15_hs12_hresp  ),
	.mst15_slv12_ack   (mst15_slv12_ack   ),
	.mst15_slv12_base  (mst15_slv12_base  ),
	.mst15_slv12_grant (mst15_slv12_grant ),
	.mst15_slv12_haddr (mst15_slv12_haddr ),
	.mst15_slv12_hburst(mst15_slv12_hburst),
	.mst15_slv12_hprot (mst15_slv12_hprot ),
	.mst15_slv12_hsize (mst15_slv12_hsize ),
	.mst15_slv12_htrans(mst15_slv12_htrans),
	.mst15_slv12_hwrite(mst15_slv12_hwrite),
	.mst15_slv12_req   (mst15_slv12_req   ),
	.mst15_slv12_sel   (mst15_slv12_sel   ),
	.mst15_slv12_size  (mst15_slv12_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hm15_slv13_hwdata (hm15_slv13_hwdata ),
	.mst15_hs13_hrdata (mst15_hs13_hrdata ),
	.mst15_hs13_hready (mst15_hs13_hready ),
	.mst15_hs13_hresp  (mst15_hs13_hresp  ),
	.mst15_slv13_ack   (mst15_slv13_ack   ),
	.mst15_slv13_base  (mst15_slv13_base  ),
	.mst15_slv13_grant (mst15_slv13_grant ),
	.mst15_slv13_haddr (mst15_slv13_haddr ),
	.mst15_slv13_hburst(mst15_slv13_hburst),
	.mst15_slv13_hprot (mst15_slv13_hprot ),
	.mst15_slv13_hsize (mst15_slv13_hsize ),
	.mst15_slv13_htrans(mst15_slv13_htrans),
	.mst15_slv13_hwrite(mst15_slv13_hwrite),
	.mst15_slv13_req   (mst15_slv13_req   ),
	.mst15_slv13_sel   (mst15_slv13_sel   ),
	.mst15_slv13_size  (mst15_slv13_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hm15_slv14_hwdata (hm15_slv14_hwdata ),
	.mst15_hs14_hrdata (mst15_hs14_hrdata ),
	.mst15_hs14_hready (mst15_hs14_hready ),
	.mst15_hs14_hresp  (mst15_hs14_hresp  ),
	.mst15_slv14_ack   (mst15_slv14_ack   ),
	.mst15_slv14_base  (mst15_slv14_base  ),
	.mst15_slv14_grant (mst15_slv14_grant ),
	.mst15_slv14_haddr (mst15_slv14_haddr ),
	.mst15_slv14_hburst(mst15_slv14_hburst),
	.mst15_slv14_hprot (mst15_slv14_hprot ),
	.mst15_slv14_hsize (mst15_slv14_hsize ),
	.mst15_slv14_htrans(mst15_slv14_htrans),
	.mst15_slv14_hwrite(mst15_slv14_hwrite),
	.mst15_slv14_req   (mst15_slv14_req   ),
	.mst15_slv14_sel   (mst15_slv14_sel   ),
	.mst15_slv14_size  (mst15_slv14_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hm15_slv15_hwdata (hm15_slv15_hwdata ),
	.mst15_hs15_hrdata (mst15_hs15_hrdata ),
	.mst15_hs15_hready (mst15_hs15_hready ),
	.mst15_hs15_hresp  (mst15_hs15_hresp  ),
	.mst15_slv15_ack   (mst15_slv15_ack   ),
	.mst15_slv15_base  (mst15_slv15_base  ),
	.mst15_slv15_grant (mst15_slv15_grant ),
	.mst15_slv15_haddr (mst15_slv15_haddr ),
	.mst15_slv15_hburst(mst15_slv15_hburst),
	.mst15_slv15_hprot (mst15_slv15_hprot ),
	.mst15_slv15_hsize (mst15_slv15_hsize ),
	.mst15_slv15_htrans(mst15_slv15_htrans),
	.mst15_slv15_hwrite(mst15_slv15_hwrite),
	.mst15_slv15_req   (mst15_slv15_req   ),
	.mst15_slv15_sel   (mst15_slv15_sel   ),
	.mst15_slv15_size  (mst15_slv15_size  ),
   `endif
`endif
	.hs0_hrdata        (hs0_hrdata        ),
	.hs0_hready        (hs0_bmc_hready    ),
	.hs0_hresp         (hs0_hresp         ),
	.slv0_base         (slv0_base         ),
	.slv0_size         (slv0_size         )
);

atcbmc200_ahbslv_rf #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_rf (
	.hrdata         (hs0_hrdata     ),
	.hready         (hs0_bmc_hready ),
	.hresp          (hs0_hresp      ),
	.hclk           (hclk           ),
	.hresetn        (hresetn        ),
	.hready_in      (bmc_hs0_hready ),
	.haddr          (hs0_haddr      ),
	.hsel           (hs0_hsel       ),
	.hsize          (hs0_hsize      ),
	.htrans         (hs0_htrans     ),
	.hwdata         (hs0_hwdata     ),
	.hwrite         (hs0_hwrite     ),
	.init_priority  (init_priority  ),
`ifdef ATCBMC200_AHB_MST0
	.mst0_sel_err   (mst0_sel_err   ),
`endif
`ifdef ATCBMC200_AHB_MST1
	.mst1_sel_err   (mst1_sel_err   ),
`endif
`ifdef ATCBMC200_AHB_MST2
	.mst2_sel_err   (mst2_sel_err   ),
`endif
`ifdef ATCBMC200_AHB_MST3
	.mst3_sel_err   (mst3_sel_err   ),
`endif
`ifdef ATCBMC200_AHB_MST4
	.mst4_sel_err   (mst4_sel_err   ),
`endif
`ifdef ATCBMC200_AHB_MST5
	.mst5_sel_err   (mst5_sel_err   ),
`endif
`ifdef ATCBMC200_AHB_MST6
	.mst6_sel_err   (mst6_sel_err   ),
`endif
`ifdef ATCBMC200_AHB_MST7
	.mst7_sel_err   (mst7_sel_err   ),
`endif
`ifdef ATCBMC200_AHB_MST8
	.mst8_sel_err   (mst8_sel_err   ),
`endif
`ifdef ATCBMC200_AHB_MST9
	.mst9_sel_err   (mst9_sel_err   ),
`endif
`ifdef ATCBMC200_AHB_MST10
	.mst10_sel_err  (mst10_sel_err  ),
`endif
`ifdef ATCBMC200_AHB_MST11
	.mst11_sel_err  (mst11_sel_err  ),
`endif
`ifdef ATCBMC200_AHB_MST12
	.mst12_sel_err  (mst12_sel_err  ),
`endif
`ifdef ATCBMC200_AHB_MST13
	.mst13_sel_err  (mst13_sel_err  ),
`endif
`ifdef ATCBMC200_AHB_MST14
	.mst14_sel_err  (mst14_sel_err  ),
`endif
`ifdef ATCBMC200_AHB_MST15
	.mst15_sel_err  (mst15_sel_err  ),
`endif
`ifdef ATCBMC200_AHB_SLV0
	.slv0_base      (slv0_base      ),
	.slv0_size      (slv0_size      ),
`endif
`ifdef ATCBMC200_AHB_SLV1
	.slv1_base      (slv1_base      ),
	.slv1_size      (slv1_size      ),
`endif
`ifdef ATCBMC200_AHB_SLV2
	.slv2_base      (slv2_base      ),
	.slv2_size      (slv2_size      ),
`endif
`ifdef ATCBMC200_AHB_SLV3
	.slv3_base      (slv3_base      ),
	.slv3_size      (slv3_size      ),
`endif
`ifdef ATCBMC200_AHB_SLV4
	.slv4_base      (slv4_base      ),
	.slv4_size      (slv4_size      ),
`endif
`ifdef ATCBMC200_AHB_SLV5
	.slv5_base      (slv5_base      ),
	.slv5_size      (slv5_size      ),
`endif
`ifdef ATCBMC200_AHB_SLV6
	.slv6_base      (slv6_base      ),
	.slv6_size      (slv6_size      ),
`endif
`ifdef ATCBMC200_AHB_SLV7
	.slv7_base      (slv7_base      ),
	.slv7_size      (slv7_size      ),
`endif
`ifdef ATCBMC200_AHB_SLV8
	.slv8_base      (slv8_base      ),
	.slv8_size      (slv8_size      ),
`endif
`ifdef ATCBMC200_AHB_SLV9
	.slv9_base      (slv9_base      ),
	.slv9_size      (slv9_size      ),
`endif
`ifdef ATCBMC200_AHB_SLV10
	.slv10_base     (slv10_base     ),
	.slv10_size     (slv10_size     ),
`endif
`ifdef ATCBMC200_AHB_SLV11
	.slv11_base     (slv11_base     ),
	.slv11_size     (slv11_size     ),
`endif
`ifdef ATCBMC200_AHB_SLV12
	.slv12_base     (slv12_base     ),
	.slv12_size     (slv12_size     ),
`endif
`ifdef ATCBMC200_AHB_SLV13
	.slv13_base     (slv13_base     ),
	.slv13_size     (slv13_size     ),
`endif
`ifdef ATCBMC200_AHB_SLV14
	.slv14_base     (slv14_base     ),
	.slv14_size     (slv14_size     ),
`endif
`ifdef ATCBMC200_AHB_SLV15
	.slv15_base     (slv15_base     ),
	.slv15_size     (slv15_size     ),
`endif
	.bmc_intr       (bmc_intr       ),
	.mst0_highest_en(mst0_highest_en),
	.ctrl_wen       (ctrl_wen       ),
	.resp_mode      (resp_mode      )
);

`ifdef ATCBMC200_AHB_MST0
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander0 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en    ),
	.ahb_slv1_en (ahb_slv1_en     ),
	.ahb_slv2_en (ahb_slv2_en     ),
	.ahb_slv3_en (ahb_slv3_en     ),
	.ahb_slv4_en (ahb_slv4_en     ),
	.ahb_slv5_en (ahb_slv5_en     ),
	.ahb_slv6_en (ahb_slv6_en     ),
	.ahb_slv7_en (ahb_slv7_en     ),
	.ahb_slv8_en (ahb_slv8_en     ),
	.ahb_slv9_en (ahb_slv9_en     ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst0_hs0_hrdata ),
	.hs0_hready  (mst0_hs0_hready ),
	.hs0_hresp   (mst0_hs0_hresp  ),
	.slv0_grant  (mst0_slv0_grant ),
	.slv0_base   (mst0_slv0_base  ),
	.slv0_sel    (mst0_slv0_sel   ),
	.slv0_size   (mst0_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst0_hs1_hrdata ),
	.hs1_hready  (mst0_hs1_hready ),
	.hs1_hresp   (mst0_hs1_hresp  ),
	.slv1_grant  (mst0_slv1_grant ),
	.slv1_base   (mst0_slv1_base  ),
	.slv1_sel    (mst0_slv1_sel   ),
	.slv1_size   (mst0_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst0_hs2_hrdata ),
	.hs2_hready  (mst0_hs2_hready ),
	.hs2_hresp   (mst0_hs2_hresp  ),
	.slv2_grant  (mst0_slv2_grant ),
	.slv2_base   (mst0_slv2_base  ),
	.slv2_sel    (mst0_slv2_sel   ),
	.slv2_size   (mst0_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst0_hs3_hrdata ),
	.hs3_hready  (mst0_hs3_hready ),
	.hs3_hresp   (mst0_hs3_hresp  ),
	.slv3_grant  (mst0_slv3_grant ),
	.slv3_base   (mst0_slv3_base  ),
	.slv3_sel    (mst0_slv3_sel   ),
	.slv3_size   (mst0_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst0_hs4_hrdata ),
	.hs4_hready  (mst0_hs4_hready ),
	.hs4_hresp   (mst0_hs4_hresp  ),
	.slv4_grant  (mst0_slv4_grant ),
	.slv4_base   (mst0_slv4_base  ),
	.slv4_sel    (mst0_slv4_sel   ),
	.slv4_size   (mst0_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst0_hs5_hrdata ),
	.hs5_hready  (mst0_hs5_hready ),
	.hs5_hresp   (mst0_hs5_hresp  ),
	.slv5_grant  (mst0_slv5_grant ),
	.slv5_base   (mst0_slv5_base  ),
	.slv5_sel    (mst0_slv5_sel   ),
	.slv5_size   (mst0_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst0_hs6_hrdata ),
	.hs6_hready  (mst0_hs6_hready ),
	.hs6_hresp   (mst0_hs6_hresp  ),
	.slv6_grant  (mst0_slv6_grant ),
	.slv6_base   (mst0_slv6_base  ),
	.slv6_sel    (mst0_slv6_sel   ),
	.slv6_size   (mst0_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst0_hs7_hrdata ),
	.hs7_hready  (mst0_hs7_hready ),
	.hs7_hresp   (mst0_hs7_hresp  ),
	.slv7_grant  (mst0_slv7_grant ),
	.slv7_base   (mst0_slv7_base  ),
	.slv7_sel    (mst0_slv7_sel   ),
	.slv7_size   (mst0_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst0_hs8_hrdata ),
	.hs8_hready  (mst0_hs8_hready ),
	.hs8_hresp   (mst0_hs8_hresp  ),
	.slv8_grant  (mst0_slv8_grant ),
	.slv8_base   (mst0_slv8_base  ),
	.slv8_sel    (mst0_slv8_sel   ),
	.slv8_size   (mst0_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst0_hs9_hrdata ),
	.hs9_hready  (mst0_hs9_hready ),
	.hs9_hresp   (mst0_hs9_hresp  ),
	.slv9_grant  (mst0_slv9_grant ),
	.slv9_base   (mst0_slv9_base  ),
	.slv9_sel    (mst0_slv9_sel   ),
	.slv9_size   (mst0_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst0_hs10_hrdata),
	.hs10_hready (mst0_hs10_hready),
	.hs10_hresp  (mst0_hs10_hresp ),
	.slv10_grant (mst0_slv10_grant),
	.slv10_base  (mst0_slv10_base ),
	.slv10_sel   (mst0_slv10_sel  ),
	.slv10_size  (mst0_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst0_hs11_hrdata),
	.hs11_hready (mst0_hs11_hready),
	.hs11_hresp  (mst0_hs11_hresp ),
	.slv11_grant (mst0_slv11_grant),
	.slv11_base  (mst0_slv11_base ),
	.slv11_sel   (mst0_slv11_sel  ),
	.slv11_size  (mst0_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst0_hs12_hrdata),
	.hs12_hready (mst0_hs12_hready),
	.hs12_hresp  (mst0_hs12_hresp ),
	.slv12_grant (mst0_slv12_grant),
	.slv12_base  (mst0_slv12_base ),
	.slv12_sel   (mst0_slv12_sel  ),
	.slv12_size  (mst0_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst0_hs13_hrdata),
	.hs13_hready (mst0_hs13_hready),
	.hs13_hresp  (mst0_hs13_hresp ),
	.slv13_grant (mst0_slv13_grant),
	.slv13_base  (mst0_slv13_base ),
	.slv13_sel   (mst0_slv13_sel  ),
	.slv13_size  (mst0_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst0_hs14_hrdata),
	.hs14_hready (mst0_hs14_hready),
	.hs14_hresp  (mst0_hs14_hresp ),
	.slv14_grant (mst0_slv14_grant),
	.slv14_base  (mst0_slv14_base ),
	.slv14_sel   (mst0_slv14_sel  ),
	.slv14_size  (mst0_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst0_hs15_hrdata),
	.hs15_hready (mst0_hs15_hready),
	.hs15_hresp  (mst0_hs15_hresp ),
	.slv15_grant (mst0_slv15_grant),
	.slv15_base  (mst0_slv15_base ),
	.slv15_sel   (mst0_slv15_sel  ),
	.slv15_size  (mst0_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen        ),
	.hclk        (hclk            ),
	.hm_haddr    (hm0_haddr       ),
	.hm_hburst   (hm0_hburst      ),
	.hm_hprot    (hm0_hprot       ),
	.hm_hrdata   (hm0_hrdata      ),
	.hm_hready   (hm0_hready      ),
	.hm_hresp    (hm0_hresp       ),
	.hm_hsize    (hm0_hsize       ),
	.hm_htrans   (hm0_htrans      ),
	.hm_hwrite   (hm0_hwrite      ),
	.hresetn     (hresetn         ),
	.mst_haddr   (mst0_haddr      ),
	.mst_hburst  (mst0_hburst     ),
	.mst_hprot   (mst0_hprot      ),
	.mst_hsize   (mst0_hsize      ),
	.mst_htrans  (mst0_htrans     ),
	.mst_hwrite  (mst0_hwrite     ),
	.resp_mode   (resp_mode       ),
	.slv_sel_err (mst0_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST1
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander1 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en    ),
	.ahb_slv1_en (ahb_slv1_en     ),
	.ahb_slv2_en (ahb_slv2_en     ),
	.ahb_slv3_en (ahb_slv3_en     ),
	.ahb_slv4_en (ahb_slv4_en     ),
	.ahb_slv5_en (ahb_slv5_en     ),
	.ahb_slv6_en (ahb_slv6_en     ),
	.ahb_slv7_en (ahb_slv7_en     ),
	.ahb_slv8_en (ahb_slv8_en     ),
	.ahb_slv9_en (ahb_slv9_en     ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst1_hs0_hrdata ),
	.hs0_hready  (mst1_hs0_hready ),
	.hs0_hresp   (mst1_hs0_hresp  ),
	.slv0_grant  (mst1_slv0_grant ),
	.slv0_base   (mst1_slv0_base  ),
	.slv0_sel    (mst1_slv0_sel   ),
	.slv0_size   (mst1_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst1_hs1_hrdata ),
	.hs1_hready  (mst1_hs1_hready ),
	.hs1_hresp   (mst1_hs1_hresp  ),
	.slv1_grant  (mst1_slv1_grant ),
	.slv1_base   (mst1_slv1_base  ),
	.slv1_sel    (mst1_slv1_sel   ),
	.slv1_size   (mst1_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst1_hs2_hrdata ),
	.hs2_hready  (mst1_hs2_hready ),
	.hs2_hresp   (mst1_hs2_hresp  ),
	.slv2_grant  (mst1_slv2_grant ),
	.slv2_base   (mst1_slv2_base  ),
	.slv2_sel    (mst1_slv2_sel   ),
	.slv2_size   (mst1_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst1_hs3_hrdata ),
	.hs3_hready  (mst1_hs3_hready ),
	.hs3_hresp   (mst1_hs3_hresp  ),
	.slv3_grant  (mst1_slv3_grant ),
	.slv3_base   (mst1_slv3_base  ),
	.slv3_sel    (mst1_slv3_sel   ),
	.slv3_size   (mst1_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst1_hs4_hrdata ),
	.hs4_hready  (mst1_hs4_hready ),
	.hs4_hresp   (mst1_hs4_hresp  ),
	.slv4_grant  (mst1_slv4_grant ),
	.slv4_base   (mst1_slv4_base  ),
	.slv4_sel    (mst1_slv4_sel   ),
	.slv4_size   (mst1_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst1_hs5_hrdata ),
	.hs5_hready  (mst1_hs5_hready ),
	.hs5_hresp   (mst1_hs5_hresp  ),
	.slv5_grant  (mst1_slv5_grant ),
	.slv5_base   (mst1_slv5_base  ),
	.slv5_sel    (mst1_slv5_sel   ),
	.slv5_size   (mst1_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst1_hs6_hrdata ),
	.hs6_hready  (mst1_hs6_hready ),
	.hs6_hresp   (mst1_hs6_hresp  ),
	.slv6_grant  (mst1_slv6_grant ),
	.slv6_base   (mst1_slv6_base  ),
	.slv6_sel    (mst1_slv6_sel   ),
	.slv6_size   (mst1_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst1_hs7_hrdata ),
	.hs7_hready  (mst1_hs7_hready ),
	.hs7_hresp   (mst1_hs7_hresp  ),
	.slv7_grant  (mst1_slv7_grant ),
	.slv7_base   (mst1_slv7_base  ),
	.slv7_sel    (mst1_slv7_sel   ),
	.slv7_size   (mst1_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst1_hs8_hrdata ),
	.hs8_hready  (mst1_hs8_hready ),
	.hs8_hresp   (mst1_hs8_hresp  ),
	.slv8_grant  (mst1_slv8_grant ),
	.slv8_base   (mst1_slv8_base  ),
	.slv8_sel    (mst1_slv8_sel   ),
	.slv8_size   (mst1_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst1_hs9_hrdata ),
	.hs9_hready  (mst1_hs9_hready ),
	.hs9_hresp   (mst1_hs9_hresp  ),
	.slv9_grant  (mst1_slv9_grant ),
	.slv9_base   (mst1_slv9_base  ),
	.slv9_sel    (mst1_slv9_sel   ),
	.slv9_size   (mst1_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst1_hs10_hrdata),
	.hs10_hready (mst1_hs10_hready),
	.hs10_hresp  (mst1_hs10_hresp ),
	.slv10_grant (mst1_slv10_grant),
	.slv10_base  (mst1_slv10_base ),
	.slv10_sel   (mst1_slv10_sel  ),
	.slv10_size  (mst1_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst1_hs11_hrdata),
	.hs11_hready (mst1_hs11_hready),
	.hs11_hresp  (mst1_hs11_hresp ),
	.slv11_grant (mst1_slv11_grant),
	.slv11_base  (mst1_slv11_base ),
	.slv11_sel   (mst1_slv11_sel  ),
	.slv11_size  (mst1_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst1_hs12_hrdata),
	.hs12_hready (mst1_hs12_hready),
	.hs12_hresp  (mst1_hs12_hresp ),
	.slv12_grant (mst1_slv12_grant),
	.slv12_base  (mst1_slv12_base ),
	.slv12_sel   (mst1_slv12_sel  ),
	.slv12_size  (mst1_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst1_hs13_hrdata),
	.hs13_hready (mst1_hs13_hready),
	.hs13_hresp  (mst1_hs13_hresp ),
	.slv13_grant (mst1_slv13_grant),
	.slv13_base  (mst1_slv13_base ),
	.slv13_sel   (mst1_slv13_sel  ),
	.slv13_size  (mst1_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst1_hs14_hrdata),
	.hs14_hready (mst1_hs14_hready),
	.hs14_hresp  (mst1_hs14_hresp ),
	.slv14_grant (mst1_slv14_grant),
	.slv14_base  (mst1_slv14_base ),
	.slv14_sel   (mst1_slv14_sel  ),
	.slv14_size  (mst1_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst1_hs15_hrdata),
	.hs15_hready (mst1_hs15_hready),
	.hs15_hresp  (mst1_hs15_hresp ),
	.slv15_grant (mst1_slv15_grant),
	.slv15_base  (mst1_slv15_base ),
	.slv15_sel   (mst1_slv15_sel  ),
	.slv15_size  (mst1_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen        ),
	.hclk        (hclk            ),
	.hm_haddr    (hm1_haddr       ),
	.hm_hburst   (hm1_hburst      ),
	.hm_hprot    (hm1_hprot       ),
	.hm_hrdata   (hm1_hrdata      ),
	.hm_hready   (hm1_hready      ),
	.hm_hresp    (hm1_hresp       ),
	.hm_hsize    (hm1_hsize       ),
	.hm_htrans   (hm1_htrans      ),
	.hm_hwrite   (hm1_hwrite      ),
	.hresetn     (hresetn         ),
	.mst_haddr   (mst1_haddr      ),
	.mst_hburst  (mst1_hburst     ),
	.mst_hprot   (mst1_hprot      ),
	.mst_hsize   (mst1_hsize      ),
	.mst_htrans  (mst1_htrans     ),
	.mst_hwrite  (mst1_hwrite     ),
	.resp_mode   (resp_mode       ),
	.slv_sel_err (mst1_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST2
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander2 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en    ),
	.ahb_slv1_en (ahb_slv1_en     ),
	.ahb_slv2_en (ahb_slv2_en     ),
	.ahb_slv3_en (ahb_slv3_en     ),
	.ahb_slv4_en (ahb_slv4_en     ),
	.ahb_slv5_en (ahb_slv5_en     ),
	.ahb_slv6_en (ahb_slv6_en     ),
	.ahb_slv7_en (ahb_slv7_en     ),
	.ahb_slv8_en (ahb_slv8_en     ),
	.ahb_slv9_en (ahb_slv9_en     ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst2_hs0_hrdata ),
	.hs0_hready  (mst2_hs0_hready ),
	.hs0_hresp   (mst2_hs0_hresp  ),
	.slv0_grant  (mst2_slv0_grant ),
	.slv0_base   (mst2_slv0_base  ),
	.slv0_sel    (mst2_slv0_sel   ),
	.slv0_size   (mst2_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst2_hs1_hrdata ),
	.hs1_hready  (mst2_hs1_hready ),
	.hs1_hresp   (mst2_hs1_hresp  ),
	.slv1_grant  (mst2_slv1_grant ),
	.slv1_base   (mst2_slv1_base  ),
	.slv1_sel    (mst2_slv1_sel   ),
	.slv1_size   (mst2_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst2_hs2_hrdata ),
	.hs2_hready  (mst2_hs2_hready ),
	.hs2_hresp   (mst2_hs2_hresp  ),
	.slv2_grant  (mst2_slv2_grant ),
	.slv2_base   (mst2_slv2_base  ),
	.slv2_sel    (mst2_slv2_sel   ),
	.slv2_size   (mst2_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst2_hs3_hrdata ),
	.hs3_hready  (mst2_hs3_hready ),
	.hs3_hresp   (mst2_hs3_hresp  ),
	.slv3_grant  (mst2_slv3_grant ),
	.slv3_base   (mst2_slv3_base  ),
	.slv3_sel    (mst2_slv3_sel   ),
	.slv3_size   (mst2_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst2_hs4_hrdata ),
	.hs4_hready  (mst2_hs4_hready ),
	.hs4_hresp   (mst2_hs4_hresp  ),
	.slv4_grant  (mst2_slv4_grant ),
	.slv4_base   (mst2_slv4_base  ),
	.slv4_sel    (mst2_slv4_sel   ),
	.slv4_size   (mst2_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst2_hs5_hrdata ),
	.hs5_hready  (mst2_hs5_hready ),
	.hs5_hresp   (mst2_hs5_hresp  ),
	.slv5_grant  (mst2_slv5_grant ),
	.slv5_base   (mst2_slv5_base  ),
	.slv5_sel    (mst2_slv5_sel   ),
	.slv5_size   (mst2_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst2_hs6_hrdata ),
	.hs6_hready  (mst2_hs6_hready ),
	.hs6_hresp   (mst2_hs6_hresp  ),
	.slv6_grant  (mst2_slv6_grant ),
	.slv6_base   (mst2_slv6_base  ),
	.slv6_sel    (mst2_slv6_sel   ),
	.slv6_size   (mst2_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst2_hs7_hrdata ),
	.hs7_hready  (mst2_hs7_hready ),
	.hs7_hresp   (mst2_hs7_hresp  ),
	.slv7_grant  (mst2_slv7_grant ),
	.slv7_base   (mst2_slv7_base  ),
	.slv7_sel    (mst2_slv7_sel   ),
	.slv7_size   (mst2_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst2_hs8_hrdata ),
	.hs8_hready  (mst2_hs8_hready ),
	.hs8_hresp   (mst2_hs8_hresp  ),
	.slv8_grant  (mst2_slv8_grant ),
	.slv8_base   (mst2_slv8_base  ),
	.slv8_sel    (mst2_slv8_sel   ),
	.slv8_size   (mst2_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst2_hs9_hrdata ),
	.hs9_hready  (mst2_hs9_hready ),
	.hs9_hresp   (mst2_hs9_hresp  ),
	.slv9_grant  (mst2_slv9_grant ),
	.slv9_base   (mst2_slv9_base  ),
	.slv9_sel    (mst2_slv9_sel   ),
	.slv9_size   (mst2_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst2_hs10_hrdata),
	.hs10_hready (mst2_hs10_hready),
	.hs10_hresp  (mst2_hs10_hresp ),
	.slv10_grant (mst2_slv10_grant),
	.slv10_base  (mst2_slv10_base ),
	.slv10_sel   (mst2_slv10_sel  ),
	.slv10_size  (mst2_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst2_hs11_hrdata),
	.hs11_hready (mst2_hs11_hready),
	.hs11_hresp  (mst2_hs11_hresp ),
	.slv11_grant (mst2_slv11_grant),
	.slv11_base  (mst2_slv11_base ),
	.slv11_sel   (mst2_slv11_sel  ),
	.slv11_size  (mst2_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst2_hs12_hrdata),
	.hs12_hready (mst2_hs12_hready),
	.hs12_hresp  (mst2_hs12_hresp ),
	.slv12_grant (mst2_slv12_grant),
	.slv12_base  (mst2_slv12_base ),
	.slv12_sel   (mst2_slv12_sel  ),
	.slv12_size  (mst2_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst2_hs13_hrdata),
	.hs13_hready (mst2_hs13_hready),
	.hs13_hresp  (mst2_hs13_hresp ),
	.slv13_grant (mst2_slv13_grant),
	.slv13_base  (mst2_slv13_base ),
	.slv13_sel   (mst2_slv13_sel  ),
	.slv13_size  (mst2_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst2_hs14_hrdata),
	.hs14_hready (mst2_hs14_hready),
	.hs14_hresp  (mst2_hs14_hresp ),
	.slv14_grant (mst2_slv14_grant),
	.slv14_base  (mst2_slv14_base ),
	.slv14_sel   (mst2_slv14_sel  ),
	.slv14_size  (mst2_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst2_hs15_hrdata),
	.hs15_hready (mst2_hs15_hready),
	.hs15_hresp  (mst2_hs15_hresp ),
	.slv15_grant (mst2_slv15_grant),
	.slv15_base  (mst2_slv15_base ),
	.slv15_sel   (mst2_slv15_sel  ),
	.slv15_size  (mst2_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen        ),
	.hclk        (hclk            ),
	.hm_haddr    (hm2_haddr       ),
	.hm_hburst   (hm2_hburst      ),
	.hm_hprot    (hm2_hprot       ),
	.hm_hrdata   (hm2_hrdata      ),
	.hm_hready   (hm2_hready      ),
	.hm_hresp    (hm2_hresp       ),
	.hm_hsize    (hm2_hsize       ),
	.hm_htrans   (hm2_htrans      ),
	.hm_hwrite   (hm2_hwrite      ),
	.hresetn     (hresetn         ),
	.mst_haddr   (mst2_haddr      ),
	.mst_hburst  (mst2_hburst     ),
	.mst_hprot   (mst2_hprot      ),
	.mst_hsize   (mst2_hsize      ),
	.mst_htrans  (mst2_htrans     ),
	.mst_hwrite  (mst2_hwrite     ),
	.resp_mode   (resp_mode       ),
	.slv_sel_err (mst2_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST3
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander3 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en    ),
	.ahb_slv1_en (ahb_slv1_en     ),
	.ahb_slv2_en (ahb_slv2_en     ),
	.ahb_slv3_en (ahb_slv3_en     ),
	.ahb_slv4_en (ahb_slv4_en     ),
	.ahb_slv5_en (ahb_slv5_en     ),
	.ahb_slv6_en (ahb_slv6_en     ),
	.ahb_slv7_en (ahb_slv7_en     ),
	.ahb_slv8_en (ahb_slv8_en     ),
	.ahb_slv9_en (ahb_slv9_en     ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst3_hs0_hrdata ),
	.hs0_hready  (mst3_hs0_hready ),
	.hs0_hresp   (mst3_hs0_hresp  ),
	.slv0_grant  (mst3_slv0_grant ),
	.slv0_base   (mst3_slv0_base  ),
	.slv0_sel    (mst3_slv0_sel   ),
	.slv0_size   (mst3_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst3_hs1_hrdata ),
	.hs1_hready  (mst3_hs1_hready ),
	.hs1_hresp   (mst3_hs1_hresp  ),
	.slv1_grant  (mst3_slv1_grant ),
	.slv1_base   (mst3_slv1_base  ),
	.slv1_sel    (mst3_slv1_sel   ),
	.slv1_size   (mst3_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst3_hs2_hrdata ),
	.hs2_hready  (mst3_hs2_hready ),
	.hs2_hresp   (mst3_hs2_hresp  ),
	.slv2_grant  (mst3_slv2_grant ),
	.slv2_base   (mst3_slv2_base  ),
	.slv2_sel    (mst3_slv2_sel   ),
	.slv2_size   (mst3_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst3_hs3_hrdata ),
	.hs3_hready  (mst3_hs3_hready ),
	.hs3_hresp   (mst3_hs3_hresp  ),
	.slv3_grant  (mst3_slv3_grant ),
	.slv3_base   (mst3_slv3_base  ),
	.slv3_sel    (mst3_slv3_sel   ),
	.slv3_size   (mst3_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst3_hs4_hrdata ),
	.hs4_hready  (mst3_hs4_hready ),
	.hs4_hresp   (mst3_hs4_hresp  ),
	.slv4_grant  (mst3_slv4_grant ),
	.slv4_base   (mst3_slv4_base  ),
	.slv4_sel    (mst3_slv4_sel   ),
	.slv4_size   (mst3_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst3_hs5_hrdata ),
	.hs5_hready  (mst3_hs5_hready ),
	.hs5_hresp   (mst3_hs5_hresp  ),
	.slv5_grant  (mst3_slv5_grant ),
	.slv5_base   (mst3_slv5_base  ),
	.slv5_sel    (mst3_slv5_sel   ),
	.slv5_size   (mst3_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst3_hs6_hrdata ),
	.hs6_hready  (mst3_hs6_hready ),
	.hs6_hresp   (mst3_hs6_hresp  ),
	.slv6_grant  (mst3_slv6_grant ),
	.slv6_base   (mst3_slv6_base  ),
	.slv6_sel    (mst3_slv6_sel   ),
	.slv6_size   (mst3_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst3_hs7_hrdata ),
	.hs7_hready  (mst3_hs7_hready ),
	.hs7_hresp   (mst3_hs7_hresp  ),
	.slv7_grant  (mst3_slv7_grant ),
	.slv7_base   (mst3_slv7_base  ),
	.slv7_sel    (mst3_slv7_sel   ),
	.slv7_size   (mst3_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst3_hs8_hrdata ),
	.hs8_hready  (mst3_hs8_hready ),
	.hs8_hresp   (mst3_hs8_hresp  ),
	.slv8_grant  (mst3_slv8_grant ),
	.slv8_base   (mst3_slv8_base  ),
	.slv8_sel    (mst3_slv8_sel   ),
	.slv8_size   (mst3_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst3_hs9_hrdata ),
	.hs9_hready  (mst3_hs9_hready ),
	.hs9_hresp   (mst3_hs9_hresp  ),
	.slv9_grant  (mst3_slv9_grant ),
	.slv9_base   (mst3_slv9_base  ),
	.slv9_sel    (mst3_slv9_sel   ),
	.slv9_size   (mst3_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst3_hs10_hrdata),
	.hs10_hready (mst3_hs10_hready),
	.hs10_hresp  (mst3_hs10_hresp ),
	.slv10_grant (mst3_slv10_grant),
	.slv10_base  (mst3_slv10_base ),
	.slv10_sel   (mst3_slv10_sel  ),
	.slv10_size  (mst3_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst3_hs11_hrdata),
	.hs11_hready (mst3_hs11_hready),
	.hs11_hresp  (mst3_hs11_hresp ),
	.slv11_grant (mst3_slv11_grant),
	.slv11_base  (mst3_slv11_base ),
	.slv11_sel   (mst3_slv11_sel  ),
	.slv11_size  (mst3_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst3_hs12_hrdata),
	.hs12_hready (mst3_hs12_hready),
	.hs12_hresp  (mst3_hs12_hresp ),
	.slv12_grant (mst3_slv12_grant),
	.slv12_base  (mst3_slv12_base ),
	.slv12_sel   (mst3_slv12_sel  ),
	.slv12_size  (mst3_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst3_hs13_hrdata),
	.hs13_hready (mst3_hs13_hready),
	.hs13_hresp  (mst3_hs13_hresp ),
	.slv13_grant (mst3_slv13_grant),
	.slv13_base  (mst3_slv13_base ),
	.slv13_sel   (mst3_slv13_sel  ),
	.slv13_size  (mst3_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst3_hs14_hrdata),
	.hs14_hready (mst3_hs14_hready),
	.hs14_hresp  (mst3_hs14_hresp ),
	.slv14_grant (mst3_slv14_grant),
	.slv14_base  (mst3_slv14_base ),
	.slv14_sel   (mst3_slv14_sel  ),
	.slv14_size  (mst3_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst3_hs15_hrdata),
	.hs15_hready (mst3_hs15_hready),
	.hs15_hresp  (mst3_hs15_hresp ),
	.slv15_grant (mst3_slv15_grant),
	.slv15_base  (mst3_slv15_base ),
	.slv15_sel   (mst3_slv15_sel  ),
	.slv15_size  (mst3_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen        ),
	.hclk        (hclk            ),
	.hm_haddr    (hm3_haddr       ),
	.hm_hburst   (hm3_hburst      ),
	.hm_hprot    (hm3_hprot       ),
	.hm_hrdata   (hm3_hrdata      ),
	.hm_hready   (hm3_hready      ),
	.hm_hresp    (hm3_hresp       ),
	.hm_hsize    (hm3_hsize       ),
	.hm_htrans   (hm3_htrans      ),
	.hm_hwrite   (hm3_hwrite      ),
	.hresetn     (hresetn         ),
	.mst_haddr   (mst3_haddr      ),
	.mst_hburst  (mst3_hburst     ),
	.mst_hprot   (mst3_hprot      ),
	.mst_hsize   (mst3_hsize      ),
	.mst_htrans  (mst3_htrans     ),
	.mst_hwrite  (mst3_hwrite     ),
	.resp_mode   (resp_mode       ),
	.slv_sel_err (mst3_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST4
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander4 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en    ),
	.ahb_slv1_en (ahb_slv1_en     ),
	.ahb_slv2_en (ahb_slv2_en     ),
	.ahb_slv3_en (ahb_slv3_en     ),
	.ahb_slv4_en (ahb_slv4_en     ),
	.ahb_slv5_en (ahb_slv5_en     ),
	.ahb_slv6_en (ahb_slv6_en     ),
	.ahb_slv7_en (ahb_slv7_en     ),
	.ahb_slv8_en (ahb_slv8_en     ),
	.ahb_slv9_en (ahb_slv9_en     ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst4_hs0_hrdata ),
	.hs0_hready  (mst4_hs0_hready ),
	.hs0_hresp   (mst4_hs0_hresp  ),
	.slv0_grant  (mst4_slv0_grant ),
	.slv0_base   (mst4_slv0_base  ),
	.slv0_sel    (mst4_slv0_sel   ),
	.slv0_size   (mst4_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst4_hs1_hrdata ),
	.hs1_hready  (mst4_hs1_hready ),
	.hs1_hresp   (mst4_hs1_hresp  ),
	.slv1_grant  (mst4_slv1_grant ),
	.slv1_base   (mst4_slv1_base  ),
	.slv1_sel    (mst4_slv1_sel   ),
	.slv1_size   (mst4_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst4_hs2_hrdata ),
	.hs2_hready  (mst4_hs2_hready ),
	.hs2_hresp   (mst4_hs2_hresp  ),
	.slv2_grant  (mst4_slv2_grant ),
	.slv2_base   (mst4_slv2_base  ),
	.slv2_sel    (mst4_slv2_sel   ),
	.slv2_size   (mst4_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst4_hs3_hrdata ),
	.hs3_hready  (mst4_hs3_hready ),
	.hs3_hresp   (mst4_hs3_hresp  ),
	.slv3_grant  (mst4_slv3_grant ),
	.slv3_base   (mst4_slv3_base  ),
	.slv3_sel    (mst4_slv3_sel   ),
	.slv3_size   (mst4_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst4_hs4_hrdata ),
	.hs4_hready  (mst4_hs4_hready ),
	.hs4_hresp   (mst4_hs4_hresp  ),
	.slv4_grant  (mst4_slv4_grant ),
	.slv4_base   (mst4_slv4_base  ),
	.slv4_sel    (mst4_slv4_sel   ),
	.slv4_size   (mst4_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst4_hs5_hrdata ),
	.hs5_hready  (mst4_hs5_hready ),
	.hs5_hresp   (mst4_hs5_hresp  ),
	.slv5_grant  (mst4_slv5_grant ),
	.slv5_base   (mst4_slv5_base  ),
	.slv5_sel    (mst4_slv5_sel   ),
	.slv5_size   (mst4_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst4_hs6_hrdata ),
	.hs6_hready  (mst4_hs6_hready ),
	.hs6_hresp   (mst4_hs6_hresp  ),
	.slv6_grant  (mst4_slv6_grant ),
	.slv6_base   (mst4_slv6_base  ),
	.slv6_sel    (mst4_slv6_sel   ),
	.slv6_size   (mst4_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst4_hs7_hrdata ),
	.hs7_hready  (mst4_hs7_hready ),
	.hs7_hresp   (mst4_hs7_hresp  ),
	.slv7_grant  (mst4_slv7_grant ),
	.slv7_base   (mst4_slv7_base  ),
	.slv7_sel    (mst4_slv7_sel   ),
	.slv7_size   (mst4_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst4_hs8_hrdata ),
	.hs8_hready  (mst4_hs8_hready ),
	.hs8_hresp   (mst4_hs8_hresp  ),
	.slv8_grant  (mst4_slv8_grant ),
	.slv8_base   (mst4_slv8_base  ),
	.slv8_sel    (mst4_slv8_sel   ),
	.slv8_size   (mst4_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst4_hs9_hrdata ),
	.hs9_hready  (mst4_hs9_hready ),
	.hs9_hresp   (mst4_hs9_hresp  ),
	.slv9_grant  (mst4_slv9_grant ),
	.slv9_base   (mst4_slv9_base  ),
	.slv9_sel    (mst4_slv9_sel   ),
	.slv9_size   (mst4_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst4_hs10_hrdata),
	.hs10_hready (mst4_hs10_hready),
	.hs10_hresp  (mst4_hs10_hresp ),
	.slv10_grant (mst4_slv10_grant),
	.slv10_base  (mst4_slv10_base ),
	.slv10_sel   (mst4_slv10_sel  ),
	.slv10_size  (mst4_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst4_hs11_hrdata),
	.hs11_hready (mst4_hs11_hready),
	.hs11_hresp  (mst4_hs11_hresp ),
	.slv11_grant (mst4_slv11_grant),
	.slv11_base  (mst4_slv11_base ),
	.slv11_sel   (mst4_slv11_sel  ),
	.slv11_size  (mst4_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst4_hs12_hrdata),
	.hs12_hready (mst4_hs12_hready),
	.hs12_hresp  (mst4_hs12_hresp ),
	.slv12_grant (mst4_slv12_grant),
	.slv12_base  (mst4_slv12_base ),
	.slv12_sel   (mst4_slv12_sel  ),
	.slv12_size  (mst4_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst4_hs13_hrdata),
	.hs13_hready (mst4_hs13_hready),
	.hs13_hresp  (mst4_hs13_hresp ),
	.slv13_grant (mst4_slv13_grant),
	.slv13_base  (mst4_slv13_base ),
	.slv13_sel   (mst4_slv13_sel  ),
	.slv13_size  (mst4_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst4_hs14_hrdata),
	.hs14_hready (mst4_hs14_hready),
	.hs14_hresp  (mst4_hs14_hresp ),
	.slv14_grant (mst4_slv14_grant),
	.slv14_base  (mst4_slv14_base ),
	.slv14_sel   (mst4_slv14_sel  ),
	.slv14_size  (mst4_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst4_hs15_hrdata),
	.hs15_hready (mst4_hs15_hready),
	.hs15_hresp  (mst4_hs15_hresp ),
	.slv15_grant (mst4_slv15_grant),
	.slv15_base  (mst4_slv15_base ),
	.slv15_sel   (mst4_slv15_sel  ),
	.slv15_size  (mst4_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen        ),
	.hclk        (hclk            ),
	.hm_haddr    (hm4_haddr       ),
	.hm_hburst   (hm4_hburst      ),
	.hm_hprot    (hm4_hprot       ),
	.hm_hrdata   (hm4_hrdata      ),
	.hm_hready   (hm4_hready      ),
	.hm_hresp    (hm4_hresp       ),
	.hm_hsize    (hm4_hsize       ),
	.hm_htrans   (hm4_htrans      ),
	.hm_hwrite   (hm4_hwrite      ),
	.hresetn     (hresetn         ),
	.mst_haddr   (mst4_haddr      ),
	.mst_hburst  (mst4_hburst     ),
	.mst_hprot   (mst4_hprot      ),
	.mst_hsize   (mst4_hsize      ),
	.mst_htrans  (mst4_htrans     ),
	.mst_hwrite  (mst4_hwrite     ),
	.resp_mode   (resp_mode       ),
	.slv_sel_err (mst4_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST5
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander5 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en    ),
	.ahb_slv1_en (ahb_slv1_en     ),
	.ahb_slv2_en (ahb_slv2_en     ),
	.ahb_slv3_en (ahb_slv3_en     ),
	.ahb_slv4_en (ahb_slv4_en     ),
	.ahb_slv5_en (ahb_slv5_en     ),
	.ahb_slv6_en (ahb_slv6_en     ),
	.ahb_slv7_en (ahb_slv7_en     ),
	.ahb_slv8_en (ahb_slv8_en     ),
	.ahb_slv9_en (ahb_slv9_en     ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst5_hs0_hrdata ),
	.hs0_hready  (mst5_hs0_hready ),
	.hs0_hresp   (mst5_hs0_hresp  ),
	.slv0_grant  (mst5_slv0_grant ),
	.slv0_base   (mst5_slv0_base  ),
	.slv0_sel    (mst5_slv0_sel   ),
	.slv0_size   (mst5_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst5_hs1_hrdata ),
	.hs1_hready  (mst5_hs1_hready ),
	.hs1_hresp   (mst5_hs1_hresp  ),
	.slv1_grant  (mst5_slv1_grant ),
	.slv1_base   (mst5_slv1_base  ),
	.slv1_sel    (mst5_slv1_sel   ),
	.slv1_size   (mst5_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst5_hs2_hrdata ),
	.hs2_hready  (mst5_hs2_hready ),
	.hs2_hresp   (mst5_hs2_hresp  ),
	.slv2_grant  (mst5_slv2_grant ),
	.slv2_base   (mst5_slv2_base  ),
	.slv2_sel    (mst5_slv2_sel   ),
	.slv2_size   (mst5_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst5_hs3_hrdata ),
	.hs3_hready  (mst5_hs3_hready ),
	.hs3_hresp   (mst5_hs3_hresp  ),
	.slv3_grant  (mst5_slv3_grant ),
	.slv3_base   (mst5_slv3_base  ),
	.slv3_sel    (mst5_slv3_sel   ),
	.slv3_size   (mst5_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst5_hs4_hrdata ),
	.hs4_hready  (mst5_hs4_hready ),
	.hs4_hresp   (mst5_hs4_hresp  ),
	.slv4_grant  (mst5_slv4_grant ),
	.slv4_base   (mst5_slv4_base  ),
	.slv4_sel    (mst5_slv4_sel   ),
	.slv4_size   (mst5_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst5_hs5_hrdata ),
	.hs5_hready  (mst5_hs5_hready ),
	.hs5_hresp   (mst5_hs5_hresp  ),
	.slv5_grant  (mst5_slv5_grant ),
	.slv5_base   (mst5_slv5_base  ),
	.slv5_sel    (mst5_slv5_sel   ),
	.slv5_size   (mst5_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst5_hs6_hrdata ),
	.hs6_hready  (mst5_hs6_hready ),
	.hs6_hresp   (mst5_hs6_hresp  ),
	.slv6_grant  (mst5_slv6_grant ),
	.slv6_base   (mst5_slv6_base  ),
	.slv6_sel    (mst5_slv6_sel   ),
	.slv6_size   (mst5_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst5_hs7_hrdata ),
	.hs7_hready  (mst5_hs7_hready ),
	.hs7_hresp   (mst5_hs7_hresp  ),
	.slv7_grant  (mst5_slv7_grant ),
	.slv7_base   (mst5_slv7_base  ),
	.slv7_sel    (mst5_slv7_sel   ),
	.slv7_size   (mst5_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst5_hs8_hrdata ),
	.hs8_hready  (mst5_hs8_hready ),
	.hs8_hresp   (mst5_hs8_hresp  ),
	.slv8_grant  (mst5_slv8_grant ),
	.slv8_base   (mst5_slv8_base  ),
	.slv8_sel    (mst5_slv8_sel   ),
	.slv8_size   (mst5_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst5_hs9_hrdata ),
	.hs9_hready  (mst5_hs9_hready ),
	.hs9_hresp   (mst5_hs9_hresp  ),
	.slv9_grant  (mst5_slv9_grant ),
	.slv9_base   (mst5_slv9_base  ),
	.slv9_sel    (mst5_slv9_sel   ),
	.slv9_size   (mst5_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst5_hs10_hrdata),
	.hs10_hready (mst5_hs10_hready),
	.hs10_hresp  (mst5_hs10_hresp ),
	.slv10_grant (mst5_slv10_grant),
	.slv10_base  (mst5_slv10_base ),
	.slv10_sel   (mst5_slv10_sel  ),
	.slv10_size  (mst5_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst5_hs11_hrdata),
	.hs11_hready (mst5_hs11_hready),
	.hs11_hresp  (mst5_hs11_hresp ),
	.slv11_grant (mst5_slv11_grant),
	.slv11_base  (mst5_slv11_base ),
	.slv11_sel   (mst5_slv11_sel  ),
	.slv11_size  (mst5_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst5_hs12_hrdata),
	.hs12_hready (mst5_hs12_hready),
	.hs12_hresp  (mst5_hs12_hresp ),
	.slv12_grant (mst5_slv12_grant),
	.slv12_base  (mst5_slv12_base ),
	.slv12_sel   (mst5_slv12_sel  ),
	.slv12_size  (mst5_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst5_hs13_hrdata),
	.hs13_hready (mst5_hs13_hready),
	.hs13_hresp  (mst5_hs13_hresp ),
	.slv13_grant (mst5_slv13_grant),
	.slv13_base  (mst5_slv13_base ),
	.slv13_sel   (mst5_slv13_sel  ),
	.slv13_size  (mst5_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst5_hs14_hrdata),
	.hs14_hready (mst5_hs14_hready),
	.hs14_hresp  (mst5_hs14_hresp ),
	.slv14_grant (mst5_slv14_grant),
	.slv14_base  (mst5_slv14_base ),
	.slv14_sel   (mst5_slv14_sel  ),
	.slv14_size  (mst5_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst5_hs15_hrdata),
	.hs15_hready (mst5_hs15_hready),
	.hs15_hresp  (mst5_hs15_hresp ),
	.slv15_grant (mst5_slv15_grant),
	.slv15_base  (mst5_slv15_base ),
	.slv15_sel   (mst5_slv15_sel  ),
	.slv15_size  (mst5_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen        ),
	.hclk        (hclk            ),
	.hm_haddr    (hm5_haddr       ),
	.hm_hburst   (hm5_hburst      ),
	.hm_hprot    (hm5_hprot       ),
	.hm_hrdata   (hm5_hrdata      ),
	.hm_hready   (hm5_hready      ),
	.hm_hresp    (hm5_hresp       ),
	.hm_hsize    (hm5_hsize       ),
	.hm_htrans   (hm5_htrans      ),
	.hm_hwrite   (hm5_hwrite      ),
	.hresetn     (hresetn         ),
	.mst_haddr   (mst5_haddr      ),
	.mst_hburst  (mst5_hburst     ),
	.mst_hprot   (mst5_hprot      ),
	.mst_hsize   (mst5_hsize      ),
	.mst_htrans  (mst5_htrans     ),
	.mst_hwrite  (mst5_hwrite     ),
	.resp_mode   (resp_mode       ),
	.slv_sel_err (mst5_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST6
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander6 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en    ),
	.ahb_slv1_en (ahb_slv1_en     ),
	.ahb_slv2_en (ahb_slv2_en     ),
	.ahb_slv3_en (ahb_slv3_en     ),
	.ahb_slv4_en (ahb_slv4_en     ),
	.ahb_slv5_en (ahb_slv5_en     ),
	.ahb_slv6_en (ahb_slv6_en     ),
	.ahb_slv7_en (ahb_slv7_en     ),
	.ahb_slv8_en (ahb_slv8_en     ),
	.ahb_slv9_en (ahb_slv9_en     ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst6_hs0_hrdata ),
	.hs0_hready  (mst6_hs0_hready ),
	.hs0_hresp   (mst6_hs0_hresp  ),
	.slv0_grant  (mst6_slv0_grant ),
	.slv0_base   (mst6_slv0_base  ),
	.slv0_sel    (mst6_slv0_sel   ),
	.slv0_size   (mst6_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst6_hs1_hrdata ),
	.hs1_hready  (mst6_hs1_hready ),
	.hs1_hresp   (mst6_hs1_hresp  ),
	.slv1_grant  (mst6_slv1_grant ),
	.slv1_base   (mst6_slv1_base  ),
	.slv1_sel    (mst6_slv1_sel   ),
	.slv1_size   (mst6_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst6_hs2_hrdata ),
	.hs2_hready  (mst6_hs2_hready ),
	.hs2_hresp   (mst6_hs2_hresp  ),
	.slv2_grant  (mst6_slv2_grant ),
	.slv2_base   (mst6_slv2_base  ),
	.slv2_sel    (mst6_slv2_sel   ),
	.slv2_size   (mst6_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst6_hs3_hrdata ),
	.hs3_hready  (mst6_hs3_hready ),
	.hs3_hresp   (mst6_hs3_hresp  ),
	.slv3_grant  (mst6_slv3_grant ),
	.slv3_base   (mst6_slv3_base  ),
	.slv3_sel    (mst6_slv3_sel   ),
	.slv3_size   (mst6_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst6_hs4_hrdata ),
	.hs4_hready  (mst6_hs4_hready ),
	.hs4_hresp   (mst6_hs4_hresp  ),
	.slv4_grant  (mst6_slv4_grant ),
	.slv4_base   (mst6_slv4_base  ),
	.slv4_sel    (mst6_slv4_sel   ),
	.slv4_size   (mst6_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst6_hs5_hrdata ),
	.hs5_hready  (mst6_hs5_hready ),
	.hs5_hresp   (mst6_hs5_hresp  ),
	.slv5_grant  (mst6_slv5_grant ),
	.slv5_base   (mst6_slv5_base  ),
	.slv5_sel    (mst6_slv5_sel   ),
	.slv5_size   (mst6_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst6_hs6_hrdata ),
	.hs6_hready  (mst6_hs6_hready ),
	.hs6_hresp   (mst6_hs6_hresp  ),
	.slv6_grant  (mst6_slv6_grant ),
	.slv6_base   (mst6_slv6_base  ),
	.slv6_sel    (mst6_slv6_sel   ),
	.slv6_size   (mst6_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst6_hs7_hrdata ),
	.hs7_hready  (mst6_hs7_hready ),
	.hs7_hresp   (mst6_hs7_hresp  ),
	.slv7_grant  (mst6_slv7_grant ),
	.slv7_base   (mst6_slv7_base  ),
	.slv7_sel    (mst6_slv7_sel   ),
	.slv7_size   (mst6_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst6_hs8_hrdata ),
	.hs8_hready  (mst6_hs8_hready ),
	.hs8_hresp   (mst6_hs8_hresp  ),
	.slv8_grant  (mst6_slv8_grant ),
	.slv8_base   (mst6_slv8_base  ),
	.slv8_sel    (mst6_slv8_sel   ),
	.slv8_size   (mst6_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst6_hs9_hrdata ),
	.hs9_hready  (mst6_hs9_hready ),
	.hs9_hresp   (mst6_hs9_hresp  ),
	.slv9_grant  (mst6_slv9_grant ),
	.slv9_base   (mst6_slv9_base  ),
	.slv9_sel    (mst6_slv9_sel   ),
	.slv9_size   (mst6_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst6_hs10_hrdata),
	.hs10_hready (mst6_hs10_hready),
	.hs10_hresp  (mst6_hs10_hresp ),
	.slv10_grant (mst6_slv10_grant),
	.slv10_base  (mst6_slv10_base ),
	.slv10_sel   (mst6_slv10_sel  ),
	.slv10_size  (mst6_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst6_hs11_hrdata),
	.hs11_hready (mst6_hs11_hready),
	.hs11_hresp  (mst6_hs11_hresp ),
	.slv11_grant (mst6_slv11_grant),
	.slv11_base  (mst6_slv11_base ),
	.slv11_sel   (mst6_slv11_sel  ),
	.slv11_size  (mst6_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst6_hs12_hrdata),
	.hs12_hready (mst6_hs12_hready),
	.hs12_hresp  (mst6_hs12_hresp ),
	.slv12_grant (mst6_slv12_grant),
	.slv12_base  (mst6_slv12_base ),
	.slv12_sel   (mst6_slv12_sel  ),
	.slv12_size  (mst6_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst6_hs13_hrdata),
	.hs13_hready (mst6_hs13_hready),
	.hs13_hresp  (mst6_hs13_hresp ),
	.slv13_grant (mst6_slv13_grant),
	.slv13_base  (mst6_slv13_base ),
	.slv13_sel   (mst6_slv13_sel  ),
	.slv13_size  (mst6_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst6_hs14_hrdata),
	.hs14_hready (mst6_hs14_hready),
	.hs14_hresp  (mst6_hs14_hresp ),
	.slv14_grant (mst6_slv14_grant),
	.slv14_base  (mst6_slv14_base ),
	.slv14_sel   (mst6_slv14_sel  ),
	.slv14_size  (mst6_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst6_hs15_hrdata),
	.hs15_hready (mst6_hs15_hready),
	.hs15_hresp  (mst6_hs15_hresp ),
	.slv15_grant (mst6_slv15_grant),
	.slv15_base  (mst6_slv15_base ),
	.slv15_sel   (mst6_slv15_sel  ),
	.slv15_size  (mst6_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen        ),
	.hclk        (hclk            ),
	.hm_haddr    (hm6_haddr       ),
	.hm_hburst   (hm6_hburst      ),
	.hm_hprot    (hm6_hprot       ),
	.hm_hrdata   (hm6_hrdata      ),
	.hm_hready   (hm6_hready      ),
	.hm_hresp    (hm6_hresp       ),
	.hm_hsize    (hm6_hsize       ),
	.hm_htrans   (hm6_htrans      ),
	.hm_hwrite   (hm6_hwrite      ),
	.hresetn     (hresetn         ),
	.mst_haddr   (mst6_haddr      ),
	.mst_hburst  (mst6_hburst     ),
	.mst_hprot   (mst6_hprot      ),
	.mst_hsize   (mst6_hsize      ),
	.mst_htrans  (mst6_htrans     ),
	.mst_hwrite  (mst6_hwrite     ),
	.resp_mode   (resp_mode       ),
	.slv_sel_err (mst6_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST7
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander7 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en    ),
	.ahb_slv1_en (ahb_slv1_en     ),
	.ahb_slv2_en (ahb_slv2_en     ),
	.ahb_slv3_en (ahb_slv3_en     ),
	.ahb_slv4_en (ahb_slv4_en     ),
	.ahb_slv5_en (ahb_slv5_en     ),
	.ahb_slv6_en (ahb_slv6_en     ),
	.ahb_slv7_en (ahb_slv7_en     ),
	.ahb_slv8_en (ahb_slv8_en     ),
	.ahb_slv9_en (ahb_slv9_en     ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst7_hs0_hrdata ),
	.hs0_hready  (mst7_hs0_hready ),
	.hs0_hresp   (mst7_hs0_hresp  ),
	.slv0_grant  (mst7_slv0_grant ),
	.slv0_base   (mst7_slv0_base  ),
	.slv0_sel    (mst7_slv0_sel   ),
	.slv0_size   (mst7_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst7_hs1_hrdata ),
	.hs1_hready  (mst7_hs1_hready ),
	.hs1_hresp   (mst7_hs1_hresp  ),
	.slv1_grant  (mst7_slv1_grant ),
	.slv1_base   (mst7_slv1_base  ),
	.slv1_sel    (mst7_slv1_sel   ),
	.slv1_size   (mst7_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst7_hs2_hrdata ),
	.hs2_hready  (mst7_hs2_hready ),
	.hs2_hresp   (mst7_hs2_hresp  ),
	.slv2_grant  (mst7_slv2_grant ),
	.slv2_base   (mst7_slv2_base  ),
	.slv2_sel    (mst7_slv2_sel   ),
	.slv2_size   (mst7_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst7_hs3_hrdata ),
	.hs3_hready  (mst7_hs3_hready ),
	.hs3_hresp   (mst7_hs3_hresp  ),
	.slv3_grant  (mst7_slv3_grant ),
	.slv3_base   (mst7_slv3_base  ),
	.slv3_sel    (mst7_slv3_sel   ),
	.slv3_size   (mst7_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst7_hs4_hrdata ),
	.hs4_hready  (mst7_hs4_hready ),
	.hs4_hresp   (mst7_hs4_hresp  ),
	.slv4_grant  (mst7_slv4_grant ),
	.slv4_base   (mst7_slv4_base  ),
	.slv4_sel    (mst7_slv4_sel   ),
	.slv4_size   (mst7_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst7_hs5_hrdata ),
	.hs5_hready  (mst7_hs5_hready ),
	.hs5_hresp   (mst7_hs5_hresp  ),
	.slv5_grant  (mst7_slv5_grant ),
	.slv5_base   (mst7_slv5_base  ),
	.slv5_sel    (mst7_slv5_sel   ),
	.slv5_size   (mst7_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst7_hs6_hrdata ),
	.hs6_hready  (mst7_hs6_hready ),
	.hs6_hresp   (mst7_hs6_hresp  ),
	.slv6_grant  (mst7_slv6_grant ),
	.slv6_base   (mst7_slv6_base  ),
	.slv6_sel    (mst7_slv6_sel   ),
	.slv6_size   (mst7_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst7_hs7_hrdata ),
	.hs7_hready  (mst7_hs7_hready ),
	.hs7_hresp   (mst7_hs7_hresp  ),
	.slv7_grant  (mst7_slv7_grant ),
	.slv7_base   (mst7_slv7_base  ),
	.slv7_sel    (mst7_slv7_sel   ),
	.slv7_size   (mst7_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst7_hs8_hrdata ),
	.hs8_hready  (mst7_hs8_hready ),
	.hs8_hresp   (mst7_hs8_hresp  ),
	.slv8_grant  (mst7_slv8_grant ),
	.slv8_base   (mst7_slv8_base  ),
	.slv8_sel    (mst7_slv8_sel   ),
	.slv8_size   (mst7_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst7_hs9_hrdata ),
	.hs9_hready  (mst7_hs9_hready ),
	.hs9_hresp   (mst7_hs9_hresp  ),
	.slv9_grant  (mst7_slv9_grant ),
	.slv9_base   (mst7_slv9_base  ),
	.slv9_sel    (mst7_slv9_sel   ),
	.slv9_size   (mst7_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst7_hs10_hrdata),
	.hs10_hready (mst7_hs10_hready),
	.hs10_hresp  (mst7_hs10_hresp ),
	.slv10_grant (mst7_slv10_grant),
	.slv10_base  (mst7_slv10_base ),
	.slv10_sel   (mst7_slv10_sel  ),
	.slv10_size  (mst7_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst7_hs11_hrdata),
	.hs11_hready (mst7_hs11_hready),
	.hs11_hresp  (mst7_hs11_hresp ),
	.slv11_grant (mst7_slv11_grant),
	.slv11_base  (mst7_slv11_base ),
	.slv11_sel   (mst7_slv11_sel  ),
	.slv11_size  (mst7_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst7_hs12_hrdata),
	.hs12_hready (mst7_hs12_hready),
	.hs12_hresp  (mst7_hs12_hresp ),
	.slv12_grant (mst7_slv12_grant),
	.slv12_base  (mst7_slv12_base ),
	.slv12_sel   (mst7_slv12_sel  ),
	.slv12_size  (mst7_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst7_hs13_hrdata),
	.hs13_hready (mst7_hs13_hready),
	.hs13_hresp  (mst7_hs13_hresp ),
	.slv13_grant (mst7_slv13_grant),
	.slv13_base  (mst7_slv13_base ),
	.slv13_sel   (mst7_slv13_sel  ),
	.slv13_size  (mst7_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst7_hs14_hrdata),
	.hs14_hready (mst7_hs14_hready),
	.hs14_hresp  (mst7_hs14_hresp ),
	.slv14_grant (mst7_slv14_grant),
	.slv14_base  (mst7_slv14_base ),
	.slv14_sel   (mst7_slv14_sel  ),
	.slv14_size  (mst7_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst7_hs15_hrdata),
	.hs15_hready (mst7_hs15_hready),
	.hs15_hresp  (mst7_hs15_hresp ),
	.slv15_grant (mst7_slv15_grant),
	.slv15_base  (mst7_slv15_base ),
	.slv15_sel   (mst7_slv15_sel  ),
	.slv15_size  (mst7_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen        ),
	.hclk        (hclk            ),
	.hm_haddr    (hm7_haddr       ),
	.hm_hburst   (hm7_hburst      ),
	.hm_hprot    (hm7_hprot       ),
	.hm_hrdata   (hm7_hrdata      ),
	.hm_hready   (hm7_hready      ),
	.hm_hresp    (hm7_hresp       ),
	.hm_hsize    (hm7_hsize       ),
	.hm_htrans   (hm7_htrans      ),
	.hm_hwrite   (hm7_hwrite      ),
	.hresetn     (hresetn         ),
	.mst_haddr   (mst7_haddr      ),
	.mst_hburst  (mst7_hburst     ),
	.mst_hprot   (mst7_hprot      ),
	.mst_hsize   (mst7_hsize      ),
	.mst_htrans  (mst7_htrans     ),
	.mst_hwrite  (mst7_hwrite     ),
	.resp_mode   (resp_mode       ),
	.slv_sel_err (mst7_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST8
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander8 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en    ),
	.ahb_slv1_en (ahb_slv1_en     ),
	.ahb_slv2_en (ahb_slv2_en     ),
	.ahb_slv3_en (ahb_slv3_en     ),
	.ahb_slv4_en (ahb_slv4_en     ),
	.ahb_slv5_en (ahb_slv5_en     ),
	.ahb_slv6_en (ahb_slv6_en     ),
	.ahb_slv7_en (ahb_slv7_en     ),
	.ahb_slv8_en (ahb_slv8_en     ),
	.ahb_slv9_en (ahb_slv9_en     ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst8_hs0_hrdata ),
	.hs0_hready  (mst8_hs0_hready ),
	.hs0_hresp   (mst8_hs0_hresp  ),
	.slv0_grant  (mst8_slv0_grant ),
	.slv0_base   (mst8_slv0_base  ),
	.slv0_sel    (mst8_slv0_sel   ),
	.slv0_size   (mst8_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst8_hs1_hrdata ),
	.hs1_hready  (mst8_hs1_hready ),
	.hs1_hresp   (mst8_hs1_hresp  ),
	.slv1_grant  (mst8_slv1_grant ),
	.slv1_base   (mst8_slv1_base  ),
	.slv1_sel    (mst8_slv1_sel   ),
	.slv1_size   (mst8_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst8_hs2_hrdata ),
	.hs2_hready  (mst8_hs2_hready ),
	.hs2_hresp   (mst8_hs2_hresp  ),
	.slv2_grant  (mst8_slv2_grant ),
	.slv2_base   (mst8_slv2_base  ),
	.slv2_sel    (mst8_slv2_sel   ),
	.slv2_size   (mst8_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst8_hs3_hrdata ),
	.hs3_hready  (mst8_hs3_hready ),
	.hs3_hresp   (mst8_hs3_hresp  ),
	.slv3_grant  (mst8_slv3_grant ),
	.slv3_base   (mst8_slv3_base  ),
	.slv3_sel    (mst8_slv3_sel   ),
	.slv3_size   (mst8_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst8_hs4_hrdata ),
	.hs4_hready  (mst8_hs4_hready ),
	.hs4_hresp   (mst8_hs4_hresp  ),
	.slv4_grant  (mst8_slv4_grant ),
	.slv4_base   (mst8_slv4_base  ),
	.slv4_sel    (mst8_slv4_sel   ),
	.slv4_size   (mst8_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst8_hs5_hrdata ),
	.hs5_hready  (mst8_hs5_hready ),
	.hs5_hresp   (mst8_hs5_hresp  ),
	.slv5_grant  (mst8_slv5_grant ),
	.slv5_base   (mst8_slv5_base  ),
	.slv5_sel    (mst8_slv5_sel   ),
	.slv5_size   (mst8_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst8_hs6_hrdata ),
	.hs6_hready  (mst8_hs6_hready ),
	.hs6_hresp   (mst8_hs6_hresp  ),
	.slv6_grant  (mst8_slv6_grant ),
	.slv6_base   (mst8_slv6_base  ),
	.slv6_sel    (mst8_slv6_sel   ),
	.slv6_size   (mst8_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst8_hs7_hrdata ),
	.hs7_hready  (mst8_hs7_hready ),
	.hs7_hresp   (mst8_hs7_hresp  ),
	.slv7_grant  (mst8_slv7_grant ),
	.slv7_base   (mst8_slv7_base  ),
	.slv7_sel    (mst8_slv7_sel   ),
	.slv7_size   (mst8_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst8_hs8_hrdata ),
	.hs8_hready  (mst8_hs8_hready ),
	.hs8_hresp   (mst8_hs8_hresp  ),
	.slv8_grant  (mst8_slv8_grant ),
	.slv8_base   (mst8_slv8_base  ),
	.slv8_sel    (mst8_slv8_sel   ),
	.slv8_size   (mst8_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst8_hs9_hrdata ),
	.hs9_hready  (mst8_hs9_hready ),
	.hs9_hresp   (mst8_hs9_hresp  ),
	.slv9_grant  (mst8_slv9_grant ),
	.slv9_base   (mst8_slv9_base  ),
	.slv9_sel    (mst8_slv9_sel   ),
	.slv9_size   (mst8_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst8_hs10_hrdata),
	.hs10_hready (mst8_hs10_hready),
	.hs10_hresp  (mst8_hs10_hresp ),
	.slv10_grant (mst8_slv10_grant),
	.slv10_base  (mst8_slv10_base ),
	.slv10_sel   (mst8_slv10_sel  ),
	.slv10_size  (mst8_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst8_hs11_hrdata),
	.hs11_hready (mst8_hs11_hready),
	.hs11_hresp  (mst8_hs11_hresp ),
	.slv11_grant (mst8_slv11_grant),
	.slv11_base  (mst8_slv11_base ),
	.slv11_sel   (mst8_slv11_sel  ),
	.slv11_size  (mst8_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst8_hs12_hrdata),
	.hs12_hready (mst8_hs12_hready),
	.hs12_hresp  (mst8_hs12_hresp ),
	.slv12_grant (mst8_slv12_grant),
	.slv12_base  (mst8_slv12_base ),
	.slv12_sel   (mst8_slv12_sel  ),
	.slv12_size  (mst8_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst8_hs13_hrdata),
	.hs13_hready (mst8_hs13_hready),
	.hs13_hresp  (mst8_hs13_hresp ),
	.slv13_grant (mst8_slv13_grant),
	.slv13_base  (mst8_slv13_base ),
	.slv13_sel   (mst8_slv13_sel  ),
	.slv13_size  (mst8_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst8_hs14_hrdata),
	.hs14_hready (mst8_hs14_hready),
	.hs14_hresp  (mst8_hs14_hresp ),
	.slv14_grant (mst8_slv14_grant),
	.slv14_base  (mst8_slv14_base ),
	.slv14_sel   (mst8_slv14_sel  ),
	.slv14_size  (mst8_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst8_hs15_hrdata),
	.hs15_hready (mst8_hs15_hready),
	.hs15_hresp  (mst8_hs15_hresp ),
	.slv15_grant (mst8_slv15_grant),
	.slv15_base  (mst8_slv15_base ),
	.slv15_sel   (mst8_slv15_sel  ),
	.slv15_size  (mst8_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen        ),
	.hclk        (hclk            ),
	.hm_haddr    (hm8_haddr       ),
	.hm_hburst   (hm8_hburst      ),
	.hm_hprot    (hm8_hprot       ),
	.hm_hrdata   (hm8_hrdata      ),
	.hm_hready   (hm8_hready      ),
	.hm_hresp    (hm8_hresp       ),
	.hm_hsize    (hm8_hsize       ),
	.hm_htrans   (hm8_htrans      ),
	.hm_hwrite   (hm8_hwrite      ),
	.hresetn     (hresetn         ),
	.mst_haddr   (mst8_haddr      ),
	.mst_hburst  (mst8_hburst     ),
	.mst_hprot   (mst8_hprot      ),
	.mst_hsize   (mst8_hsize      ),
	.mst_htrans  (mst8_htrans     ),
	.mst_hwrite  (mst8_hwrite     ),
	.resp_mode   (resp_mode       ),
	.slv_sel_err (mst8_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST9
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander9 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en    ),
	.ahb_slv1_en (ahb_slv1_en     ),
	.ahb_slv2_en (ahb_slv2_en     ),
	.ahb_slv3_en (ahb_slv3_en     ),
	.ahb_slv4_en (ahb_slv4_en     ),
	.ahb_slv5_en (ahb_slv5_en     ),
	.ahb_slv6_en (ahb_slv6_en     ),
	.ahb_slv7_en (ahb_slv7_en     ),
	.ahb_slv8_en (ahb_slv8_en     ),
	.ahb_slv9_en (ahb_slv9_en     ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst9_hs0_hrdata ),
	.hs0_hready  (mst9_hs0_hready ),
	.hs0_hresp   (mst9_hs0_hresp  ),
	.slv0_grant  (mst9_slv0_grant ),
	.slv0_base   (mst9_slv0_base  ),
	.slv0_sel    (mst9_slv0_sel   ),
	.slv0_size   (mst9_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst9_hs1_hrdata ),
	.hs1_hready  (mst9_hs1_hready ),
	.hs1_hresp   (mst9_hs1_hresp  ),
	.slv1_grant  (mst9_slv1_grant ),
	.slv1_base   (mst9_slv1_base  ),
	.slv1_sel    (mst9_slv1_sel   ),
	.slv1_size   (mst9_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst9_hs2_hrdata ),
	.hs2_hready  (mst9_hs2_hready ),
	.hs2_hresp   (mst9_hs2_hresp  ),
	.slv2_grant  (mst9_slv2_grant ),
	.slv2_base   (mst9_slv2_base  ),
	.slv2_sel    (mst9_slv2_sel   ),
	.slv2_size   (mst9_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst9_hs3_hrdata ),
	.hs3_hready  (mst9_hs3_hready ),
	.hs3_hresp   (mst9_hs3_hresp  ),
	.slv3_grant  (mst9_slv3_grant ),
	.slv3_base   (mst9_slv3_base  ),
	.slv3_sel    (mst9_slv3_sel   ),
	.slv3_size   (mst9_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst9_hs4_hrdata ),
	.hs4_hready  (mst9_hs4_hready ),
	.hs4_hresp   (mst9_hs4_hresp  ),
	.slv4_grant  (mst9_slv4_grant ),
	.slv4_base   (mst9_slv4_base  ),
	.slv4_sel    (mst9_slv4_sel   ),
	.slv4_size   (mst9_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst9_hs5_hrdata ),
	.hs5_hready  (mst9_hs5_hready ),
	.hs5_hresp   (mst9_hs5_hresp  ),
	.slv5_grant  (mst9_slv5_grant ),
	.slv5_base   (mst9_slv5_base  ),
	.slv5_sel    (mst9_slv5_sel   ),
	.slv5_size   (mst9_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst9_hs6_hrdata ),
	.hs6_hready  (mst9_hs6_hready ),
	.hs6_hresp   (mst9_hs6_hresp  ),
	.slv6_grant  (mst9_slv6_grant ),
	.slv6_base   (mst9_slv6_base  ),
	.slv6_sel    (mst9_slv6_sel   ),
	.slv6_size   (mst9_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst9_hs7_hrdata ),
	.hs7_hready  (mst9_hs7_hready ),
	.hs7_hresp   (mst9_hs7_hresp  ),
	.slv7_grant  (mst9_slv7_grant ),
	.slv7_base   (mst9_slv7_base  ),
	.slv7_sel    (mst9_slv7_sel   ),
	.slv7_size   (mst9_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst9_hs8_hrdata ),
	.hs8_hready  (mst9_hs8_hready ),
	.hs8_hresp   (mst9_hs8_hresp  ),
	.slv8_grant  (mst9_slv8_grant ),
	.slv8_base   (mst9_slv8_base  ),
	.slv8_sel    (mst9_slv8_sel   ),
	.slv8_size   (mst9_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst9_hs9_hrdata ),
	.hs9_hready  (mst9_hs9_hready ),
	.hs9_hresp   (mst9_hs9_hresp  ),
	.slv9_grant  (mst9_slv9_grant ),
	.slv9_base   (mst9_slv9_base  ),
	.slv9_sel    (mst9_slv9_sel   ),
	.slv9_size   (mst9_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst9_hs10_hrdata),
	.hs10_hready (mst9_hs10_hready),
	.hs10_hresp  (mst9_hs10_hresp ),
	.slv10_grant (mst9_slv10_grant),
	.slv10_base  (mst9_slv10_base ),
	.slv10_sel   (mst9_slv10_sel  ),
	.slv10_size  (mst9_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst9_hs11_hrdata),
	.hs11_hready (mst9_hs11_hready),
	.hs11_hresp  (mst9_hs11_hresp ),
	.slv11_grant (mst9_slv11_grant),
	.slv11_base  (mst9_slv11_base ),
	.slv11_sel   (mst9_slv11_sel  ),
	.slv11_size  (mst9_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst9_hs12_hrdata),
	.hs12_hready (mst9_hs12_hready),
	.hs12_hresp  (mst9_hs12_hresp ),
	.slv12_grant (mst9_slv12_grant),
	.slv12_base  (mst9_slv12_base ),
	.slv12_sel   (mst9_slv12_sel  ),
	.slv12_size  (mst9_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst9_hs13_hrdata),
	.hs13_hready (mst9_hs13_hready),
	.hs13_hresp  (mst9_hs13_hresp ),
	.slv13_grant (mst9_slv13_grant),
	.slv13_base  (mst9_slv13_base ),
	.slv13_sel   (mst9_slv13_sel  ),
	.slv13_size  (mst9_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst9_hs14_hrdata),
	.hs14_hready (mst9_hs14_hready),
	.hs14_hresp  (mst9_hs14_hresp ),
	.slv14_grant (mst9_slv14_grant),
	.slv14_base  (mst9_slv14_base ),
	.slv14_sel   (mst9_slv14_sel  ),
	.slv14_size  (mst9_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst9_hs15_hrdata),
	.hs15_hready (mst9_hs15_hready),
	.hs15_hresp  (mst9_hs15_hresp ),
	.slv15_grant (mst9_slv15_grant),
	.slv15_base  (mst9_slv15_base ),
	.slv15_sel   (mst9_slv15_sel  ),
	.slv15_size  (mst9_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen        ),
	.hclk        (hclk            ),
	.hm_haddr    (hm9_haddr       ),
	.hm_hburst   (hm9_hburst      ),
	.hm_hprot    (hm9_hprot       ),
	.hm_hrdata   (hm9_hrdata      ),
	.hm_hready   (hm9_hready      ),
	.hm_hresp    (hm9_hresp       ),
	.hm_hsize    (hm9_hsize       ),
	.hm_htrans   (hm9_htrans      ),
	.hm_hwrite   (hm9_hwrite      ),
	.hresetn     (hresetn         ),
	.mst_haddr   (mst9_haddr      ),
	.mst_hburst  (mst9_hburst     ),
	.mst_hprot   (mst9_hprot      ),
	.mst_hsize   (mst9_hsize      ),
	.mst_htrans  (mst9_htrans     ),
	.mst_hwrite  (mst9_hwrite     ),
	.resp_mode   (resp_mode       ),
	.slv_sel_err (mst9_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST10
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander10 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en     ),
	.ahb_slv1_en (ahb_slv1_en      ),
	.ahb_slv2_en (ahb_slv2_en      ),
	.ahb_slv3_en (ahb_slv3_en      ),
	.ahb_slv4_en (ahb_slv4_en      ),
	.ahb_slv5_en (ahb_slv5_en      ),
	.ahb_slv6_en (ahb_slv6_en      ),
	.ahb_slv7_en (ahb_slv7_en      ),
	.ahb_slv8_en (ahb_slv8_en      ),
	.ahb_slv9_en (ahb_slv9_en      ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst10_hs0_hrdata ),
	.hs0_hready  (mst10_hs0_hready ),
	.hs0_hresp   (mst10_hs0_hresp  ),
	.slv0_grant  (mst10_slv0_grant ),
	.slv0_base   (mst10_slv0_base  ),
	.slv0_sel    (mst10_slv0_sel   ),
	.slv0_size   (mst10_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst10_hs1_hrdata ),
	.hs1_hready  (mst10_hs1_hready ),
	.hs1_hresp   (mst10_hs1_hresp  ),
	.slv1_grant  (mst10_slv1_grant ),
	.slv1_base   (mst10_slv1_base  ),
	.slv1_sel    (mst10_slv1_sel   ),
	.slv1_size   (mst10_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst10_hs2_hrdata ),
	.hs2_hready  (mst10_hs2_hready ),
	.hs2_hresp   (mst10_hs2_hresp  ),
	.slv2_grant  (mst10_slv2_grant ),
	.slv2_base   (mst10_slv2_base  ),
	.slv2_sel    (mst10_slv2_sel   ),
	.slv2_size   (mst10_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst10_hs3_hrdata ),
	.hs3_hready  (mst10_hs3_hready ),
	.hs3_hresp   (mst10_hs3_hresp  ),
	.slv3_grant  (mst10_slv3_grant ),
	.slv3_base   (mst10_slv3_base  ),
	.slv3_sel    (mst10_slv3_sel   ),
	.slv3_size   (mst10_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst10_hs4_hrdata ),
	.hs4_hready  (mst10_hs4_hready ),
	.hs4_hresp   (mst10_hs4_hresp  ),
	.slv4_grant  (mst10_slv4_grant ),
	.slv4_base   (mst10_slv4_base  ),
	.slv4_sel    (mst10_slv4_sel   ),
	.slv4_size   (mst10_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst10_hs5_hrdata ),
	.hs5_hready  (mst10_hs5_hready ),
	.hs5_hresp   (mst10_hs5_hresp  ),
	.slv5_grant  (mst10_slv5_grant ),
	.slv5_base   (mst10_slv5_base  ),
	.slv5_sel    (mst10_slv5_sel   ),
	.slv5_size   (mst10_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst10_hs6_hrdata ),
	.hs6_hready  (mst10_hs6_hready ),
	.hs6_hresp   (mst10_hs6_hresp  ),
	.slv6_grant  (mst10_slv6_grant ),
	.slv6_base   (mst10_slv6_base  ),
	.slv6_sel    (mst10_slv6_sel   ),
	.slv6_size   (mst10_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst10_hs7_hrdata ),
	.hs7_hready  (mst10_hs7_hready ),
	.hs7_hresp   (mst10_hs7_hresp  ),
	.slv7_grant  (mst10_slv7_grant ),
	.slv7_base   (mst10_slv7_base  ),
	.slv7_sel    (mst10_slv7_sel   ),
	.slv7_size   (mst10_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst10_hs8_hrdata ),
	.hs8_hready  (mst10_hs8_hready ),
	.hs8_hresp   (mst10_hs8_hresp  ),
	.slv8_grant  (mst10_slv8_grant ),
	.slv8_base   (mst10_slv8_base  ),
	.slv8_sel    (mst10_slv8_sel   ),
	.slv8_size   (mst10_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst10_hs9_hrdata ),
	.hs9_hready  (mst10_hs9_hready ),
	.hs9_hresp   (mst10_hs9_hresp  ),
	.slv9_grant  (mst10_slv9_grant ),
	.slv9_base   (mst10_slv9_base  ),
	.slv9_sel    (mst10_slv9_sel   ),
	.slv9_size   (mst10_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst10_hs10_hrdata),
	.hs10_hready (mst10_hs10_hready),
	.hs10_hresp  (mst10_hs10_hresp ),
	.slv10_grant (mst10_slv10_grant),
	.slv10_base  (mst10_slv10_base ),
	.slv10_sel   (mst10_slv10_sel  ),
	.slv10_size  (mst10_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst10_hs11_hrdata),
	.hs11_hready (mst10_hs11_hready),
	.hs11_hresp  (mst10_hs11_hresp ),
	.slv11_grant (mst10_slv11_grant),
	.slv11_base  (mst10_slv11_base ),
	.slv11_sel   (mst10_slv11_sel  ),
	.slv11_size  (mst10_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst10_hs12_hrdata),
	.hs12_hready (mst10_hs12_hready),
	.hs12_hresp  (mst10_hs12_hresp ),
	.slv12_grant (mst10_slv12_grant),
	.slv12_base  (mst10_slv12_base ),
	.slv12_sel   (mst10_slv12_sel  ),
	.slv12_size  (mst10_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst10_hs13_hrdata),
	.hs13_hready (mst10_hs13_hready),
	.hs13_hresp  (mst10_hs13_hresp ),
	.slv13_grant (mst10_slv13_grant),
	.slv13_base  (mst10_slv13_base ),
	.slv13_sel   (mst10_slv13_sel  ),
	.slv13_size  (mst10_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst10_hs14_hrdata),
	.hs14_hready (mst10_hs14_hready),
	.hs14_hresp  (mst10_hs14_hresp ),
	.slv14_grant (mst10_slv14_grant),
	.slv14_base  (mst10_slv14_base ),
	.slv14_sel   (mst10_slv14_sel  ),
	.slv14_size  (mst10_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst10_hs15_hrdata),
	.hs15_hready (mst10_hs15_hready),
	.hs15_hresp  (mst10_hs15_hresp ),
	.slv15_grant (mst10_slv15_grant),
	.slv15_base  (mst10_slv15_base ),
	.slv15_sel   (mst10_slv15_sel  ),
	.slv15_size  (mst10_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen         ),
	.hclk        (hclk             ),
	.hm_haddr    (hm10_haddr       ),
	.hm_hburst   (hm10_hburst      ),
	.hm_hprot    (hm10_hprot       ),
	.hm_hrdata   (hm10_hrdata      ),
	.hm_hready   (hm10_hready      ),
	.hm_hresp    (hm10_hresp       ),
	.hm_hsize    (hm10_hsize       ),
	.hm_htrans   (hm10_htrans      ),
	.hm_hwrite   (hm10_hwrite      ),
	.hresetn     (hresetn          ),
	.mst_haddr   (mst10_haddr      ),
	.mst_hburst  (mst10_hburst     ),
	.mst_hprot   (mst10_hprot      ),
	.mst_hsize   (mst10_hsize      ),
	.mst_htrans  (mst10_htrans     ),
	.mst_hwrite  (mst10_hwrite     ),
	.resp_mode   (resp_mode        ),
	.slv_sel_err (mst10_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST11
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander11 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en     ),
	.ahb_slv1_en (ahb_slv1_en      ),
	.ahb_slv2_en (ahb_slv2_en      ),
	.ahb_slv3_en (ahb_slv3_en      ),
	.ahb_slv4_en (ahb_slv4_en      ),
	.ahb_slv5_en (ahb_slv5_en      ),
	.ahb_slv6_en (ahb_slv6_en      ),
	.ahb_slv7_en (ahb_slv7_en      ),
	.ahb_slv8_en (ahb_slv8_en      ),
	.ahb_slv9_en (ahb_slv9_en      ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst11_hs0_hrdata ),
	.hs0_hready  (mst11_hs0_hready ),
	.hs0_hresp   (mst11_hs0_hresp  ),
	.slv0_grant  (mst11_slv0_grant ),
	.slv0_base   (mst11_slv0_base  ),
	.slv0_sel    (mst11_slv0_sel   ),
	.slv0_size   (mst11_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst11_hs1_hrdata ),
	.hs1_hready  (mst11_hs1_hready ),
	.hs1_hresp   (mst11_hs1_hresp  ),
	.slv1_grant  (mst11_slv1_grant ),
	.slv1_base   (mst11_slv1_base  ),
	.slv1_sel    (mst11_slv1_sel   ),
	.slv1_size   (mst11_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst11_hs2_hrdata ),
	.hs2_hready  (mst11_hs2_hready ),
	.hs2_hresp   (mst11_hs2_hresp  ),
	.slv2_grant  (mst11_slv2_grant ),
	.slv2_base   (mst11_slv2_base  ),
	.slv2_sel    (mst11_slv2_sel   ),
	.slv2_size   (mst11_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst11_hs3_hrdata ),
	.hs3_hready  (mst11_hs3_hready ),
	.hs3_hresp   (mst11_hs3_hresp  ),
	.slv3_grant  (mst11_slv3_grant ),
	.slv3_base   (mst11_slv3_base  ),
	.slv3_sel    (mst11_slv3_sel   ),
	.slv3_size   (mst11_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst11_hs4_hrdata ),
	.hs4_hready  (mst11_hs4_hready ),
	.hs4_hresp   (mst11_hs4_hresp  ),
	.slv4_grant  (mst11_slv4_grant ),
	.slv4_base   (mst11_slv4_base  ),
	.slv4_sel    (mst11_slv4_sel   ),
	.slv4_size   (mst11_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst11_hs5_hrdata ),
	.hs5_hready  (mst11_hs5_hready ),
	.hs5_hresp   (mst11_hs5_hresp  ),
	.slv5_grant  (mst11_slv5_grant ),
	.slv5_base   (mst11_slv5_base  ),
	.slv5_sel    (mst11_slv5_sel   ),
	.slv5_size   (mst11_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst11_hs6_hrdata ),
	.hs6_hready  (mst11_hs6_hready ),
	.hs6_hresp   (mst11_hs6_hresp  ),
	.slv6_grant  (mst11_slv6_grant ),
	.slv6_base   (mst11_slv6_base  ),
	.slv6_sel    (mst11_slv6_sel   ),
	.slv6_size   (mst11_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst11_hs7_hrdata ),
	.hs7_hready  (mst11_hs7_hready ),
	.hs7_hresp   (mst11_hs7_hresp  ),
	.slv7_grant  (mst11_slv7_grant ),
	.slv7_base   (mst11_slv7_base  ),
	.slv7_sel    (mst11_slv7_sel   ),
	.slv7_size   (mst11_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst11_hs8_hrdata ),
	.hs8_hready  (mst11_hs8_hready ),
	.hs8_hresp   (mst11_hs8_hresp  ),
	.slv8_grant  (mst11_slv8_grant ),
	.slv8_base   (mst11_slv8_base  ),
	.slv8_sel    (mst11_slv8_sel   ),
	.slv8_size   (mst11_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst11_hs9_hrdata ),
	.hs9_hready  (mst11_hs9_hready ),
	.hs9_hresp   (mst11_hs9_hresp  ),
	.slv9_grant  (mst11_slv9_grant ),
	.slv9_base   (mst11_slv9_base  ),
	.slv9_sel    (mst11_slv9_sel   ),
	.slv9_size   (mst11_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst11_hs10_hrdata),
	.hs10_hready (mst11_hs10_hready),
	.hs10_hresp  (mst11_hs10_hresp ),
	.slv10_grant (mst11_slv10_grant),
	.slv10_base  (mst11_slv10_base ),
	.slv10_sel   (mst11_slv10_sel  ),
	.slv10_size  (mst11_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst11_hs11_hrdata),
	.hs11_hready (mst11_hs11_hready),
	.hs11_hresp  (mst11_hs11_hresp ),
	.slv11_grant (mst11_slv11_grant),
	.slv11_base  (mst11_slv11_base ),
	.slv11_sel   (mst11_slv11_sel  ),
	.slv11_size  (mst11_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst11_hs12_hrdata),
	.hs12_hready (mst11_hs12_hready),
	.hs12_hresp  (mst11_hs12_hresp ),
	.slv12_grant (mst11_slv12_grant),
	.slv12_base  (mst11_slv12_base ),
	.slv12_sel   (mst11_slv12_sel  ),
	.slv12_size  (mst11_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst11_hs13_hrdata),
	.hs13_hready (mst11_hs13_hready),
	.hs13_hresp  (mst11_hs13_hresp ),
	.slv13_grant (mst11_slv13_grant),
	.slv13_base  (mst11_slv13_base ),
	.slv13_sel   (mst11_slv13_sel  ),
	.slv13_size  (mst11_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst11_hs14_hrdata),
	.hs14_hready (mst11_hs14_hready),
	.hs14_hresp  (mst11_hs14_hresp ),
	.slv14_grant (mst11_slv14_grant),
	.slv14_base  (mst11_slv14_base ),
	.slv14_sel   (mst11_slv14_sel  ),
	.slv14_size  (mst11_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst11_hs15_hrdata),
	.hs15_hready (mst11_hs15_hready),
	.hs15_hresp  (mst11_hs15_hresp ),
	.slv15_grant (mst11_slv15_grant),
	.slv15_base  (mst11_slv15_base ),
	.slv15_sel   (mst11_slv15_sel  ),
	.slv15_size  (mst11_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen         ),
	.hclk        (hclk             ),
	.hm_haddr    (hm11_haddr       ),
	.hm_hburst   (hm11_hburst      ),
	.hm_hprot    (hm11_hprot       ),
	.hm_hrdata   (hm11_hrdata      ),
	.hm_hready   (hm11_hready      ),
	.hm_hresp    (hm11_hresp       ),
	.hm_hsize    (hm11_hsize       ),
	.hm_htrans   (hm11_htrans      ),
	.hm_hwrite   (hm11_hwrite      ),
	.hresetn     (hresetn          ),
	.mst_haddr   (mst11_haddr      ),
	.mst_hburst  (mst11_hburst     ),
	.mst_hprot   (mst11_hprot      ),
	.mst_hsize   (mst11_hsize      ),
	.mst_htrans  (mst11_htrans     ),
	.mst_hwrite  (mst11_hwrite     ),
	.resp_mode   (resp_mode        ),
	.slv_sel_err (mst11_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST12
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander12 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en     ),
	.ahb_slv1_en (ahb_slv1_en      ),
	.ahb_slv2_en (ahb_slv2_en      ),
	.ahb_slv3_en (ahb_slv3_en      ),
	.ahb_slv4_en (ahb_slv4_en      ),
	.ahb_slv5_en (ahb_slv5_en      ),
	.ahb_slv6_en (ahb_slv6_en      ),
	.ahb_slv7_en (ahb_slv7_en      ),
	.ahb_slv8_en (ahb_slv8_en      ),
	.ahb_slv9_en (ahb_slv9_en      ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst12_hs0_hrdata ),
	.hs0_hready  (mst12_hs0_hready ),
	.hs0_hresp   (mst12_hs0_hresp  ),
	.slv0_grant  (mst12_slv0_grant ),
	.slv0_base   (mst12_slv0_base  ),
	.slv0_sel    (mst12_slv0_sel   ),
	.slv0_size   (mst12_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst12_hs1_hrdata ),
	.hs1_hready  (mst12_hs1_hready ),
	.hs1_hresp   (mst12_hs1_hresp  ),
	.slv1_grant  (mst12_slv1_grant ),
	.slv1_base   (mst12_slv1_base  ),
	.slv1_sel    (mst12_slv1_sel   ),
	.slv1_size   (mst12_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst12_hs2_hrdata ),
	.hs2_hready  (mst12_hs2_hready ),
	.hs2_hresp   (mst12_hs2_hresp  ),
	.slv2_grant  (mst12_slv2_grant ),
	.slv2_base   (mst12_slv2_base  ),
	.slv2_sel    (mst12_slv2_sel   ),
	.slv2_size   (mst12_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst12_hs3_hrdata ),
	.hs3_hready  (mst12_hs3_hready ),
	.hs3_hresp   (mst12_hs3_hresp  ),
	.slv3_grant  (mst12_slv3_grant ),
	.slv3_base   (mst12_slv3_base  ),
	.slv3_sel    (mst12_slv3_sel   ),
	.slv3_size   (mst12_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst12_hs4_hrdata ),
	.hs4_hready  (mst12_hs4_hready ),
	.hs4_hresp   (mst12_hs4_hresp  ),
	.slv4_grant  (mst12_slv4_grant ),
	.slv4_base   (mst12_slv4_base  ),
	.slv4_sel    (mst12_slv4_sel   ),
	.slv4_size   (mst12_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst12_hs5_hrdata ),
	.hs5_hready  (mst12_hs5_hready ),
	.hs5_hresp   (mst12_hs5_hresp  ),
	.slv5_grant  (mst12_slv5_grant ),
	.slv5_base   (mst12_slv5_base  ),
	.slv5_sel    (mst12_slv5_sel   ),
	.slv5_size   (mst12_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst12_hs6_hrdata ),
	.hs6_hready  (mst12_hs6_hready ),
	.hs6_hresp   (mst12_hs6_hresp  ),
	.slv6_grant  (mst12_slv6_grant ),
	.slv6_base   (mst12_slv6_base  ),
	.slv6_sel    (mst12_slv6_sel   ),
	.slv6_size   (mst12_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst12_hs7_hrdata ),
	.hs7_hready  (mst12_hs7_hready ),
	.hs7_hresp   (mst12_hs7_hresp  ),
	.slv7_grant  (mst12_slv7_grant ),
	.slv7_base   (mst12_slv7_base  ),
	.slv7_sel    (mst12_slv7_sel   ),
	.slv7_size   (mst12_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst12_hs8_hrdata ),
	.hs8_hready  (mst12_hs8_hready ),
	.hs8_hresp   (mst12_hs8_hresp  ),
	.slv8_grant  (mst12_slv8_grant ),
	.slv8_base   (mst12_slv8_base  ),
	.slv8_sel    (mst12_slv8_sel   ),
	.slv8_size   (mst12_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst12_hs9_hrdata ),
	.hs9_hready  (mst12_hs9_hready ),
	.hs9_hresp   (mst12_hs9_hresp  ),
	.slv9_grant  (mst12_slv9_grant ),
	.slv9_base   (mst12_slv9_base  ),
	.slv9_sel    (mst12_slv9_sel   ),
	.slv9_size   (mst12_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst12_hs10_hrdata),
	.hs10_hready (mst12_hs10_hready),
	.hs10_hresp  (mst12_hs10_hresp ),
	.slv10_grant (mst12_slv10_grant),
	.slv10_base  (mst12_slv10_base ),
	.slv10_sel   (mst12_slv10_sel  ),
	.slv10_size  (mst12_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst12_hs11_hrdata),
	.hs11_hready (mst12_hs11_hready),
	.hs11_hresp  (mst12_hs11_hresp ),
	.slv11_grant (mst12_slv11_grant),
	.slv11_base  (mst12_slv11_base ),
	.slv11_sel   (mst12_slv11_sel  ),
	.slv11_size  (mst12_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst12_hs12_hrdata),
	.hs12_hready (mst12_hs12_hready),
	.hs12_hresp  (mst12_hs12_hresp ),
	.slv12_grant (mst12_slv12_grant),
	.slv12_base  (mst12_slv12_base ),
	.slv12_sel   (mst12_slv12_sel  ),
	.slv12_size  (mst12_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst12_hs13_hrdata),
	.hs13_hready (mst12_hs13_hready),
	.hs13_hresp  (mst12_hs13_hresp ),
	.slv13_grant (mst12_slv13_grant),
	.slv13_base  (mst12_slv13_base ),
	.slv13_sel   (mst12_slv13_sel  ),
	.slv13_size  (mst12_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst12_hs14_hrdata),
	.hs14_hready (mst12_hs14_hready),
	.hs14_hresp  (mst12_hs14_hresp ),
	.slv14_grant (mst12_slv14_grant),
	.slv14_base  (mst12_slv14_base ),
	.slv14_sel   (mst12_slv14_sel  ),
	.slv14_size  (mst12_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst12_hs15_hrdata),
	.hs15_hready (mst12_hs15_hready),
	.hs15_hresp  (mst12_hs15_hresp ),
	.slv15_grant (mst12_slv15_grant),
	.slv15_base  (mst12_slv15_base ),
	.slv15_sel   (mst12_slv15_sel  ),
	.slv15_size  (mst12_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen         ),
	.hclk        (hclk             ),
	.hm_haddr    (hm12_haddr       ),
	.hm_hburst   (hm12_hburst      ),
	.hm_hprot    (hm12_hprot       ),
	.hm_hrdata   (hm12_hrdata      ),
	.hm_hready   (hm12_hready      ),
	.hm_hresp    (hm12_hresp       ),
	.hm_hsize    (hm12_hsize       ),
	.hm_htrans   (hm12_htrans      ),
	.hm_hwrite   (hm12_hwrite      ),
	.hresetn     (hresetn          ),
	.mst_haddr   (mst12_haddr      ),
	.mst_hburst  (mst12_hburst     ),
	.mst_hprot   (mst12_hprot      ),
	.mst_hsize   (mst12_hsize      ),
	.mst_htrans  (mst12_htrans     ),
	.mst_hwrite  (mst12_hwrite     ),
	.resp_mode   (resp_mode        ),
	.slv_sel_err (mst12_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST13
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander13 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en     ),
	.ahb_slv1_en (ahb_slv1_en      ),
	.ahb_slv2_en (ahb_slv2_en      ),
	.ahb_slv3_en (ahb_slv3_en      ),
	.ahb_slv4_en (ahb_slv4_en      ),
	.ahb_slv5_en (ahb_slv5_en      ),
	.ahb_slv6_en (ahb_slv6_en      ),
	.ahb_slv7_en (ahb_slv7_en      ),
	.ahb_slv8_en (ahb_slv8_en      ),
	.ahb_slv9_en (ahb_slv9_en      ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst13_hs0_hrdata ),
	.hs0_hready  (mst13_hs0_hready ),
	.hs0_hresp   (mst13_hs0_hresp  ),
	.slv0_grant  (mst13_slv0_grant ),
	.slv0_base   (mst13_slv0_base  ),
	.slv0_sel    (mst13_slv0_sel   ),
	.slv0_size   (mst13_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst13_hs1_hrdata ),
	.hs1_hready  (mst13_hs1_hready ),
	.hs1_hresp   (mst13_hs1_hresp  ),
	.slv1_grant  (mst13_slv1_grant ),
	.slv1_base   (mst13_slv1_base  ),
	.slv1_sel    (mst13_slv1_sel   ),
	.slv1_size   (mst13_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst13_hs2_hrdata ),
	.hs2_hready  (mst13_hs2_hready ),
	.hs2_hresp   (mst13_hs2_hresp  ),
	.slv2_grant  (mst13_slv2_grant ),
	.slv2_base   (mst13_slv2_base  ),
	.slv2_sel    (mst13_slv2_sel   ),
	.slv2_size   (mst13_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst13_hs3_hrdata ),
	.hs3_hready  (mst13_hs3_hready ),
	.hs3_hresp   (mst13_hs3_hresp  ),
	.slv3_grant  (mst13_slv3_grant ),
	.slv3_base   (mst13_slv3_base  ),
	.slv3_sel    (mst13_slv3_sel   ),
	.slv3_size   (mst13_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst13_hs4_hrdata ),
	.hs4_hready  (mst13_hs4_hready ),
	.hs4_hresp   (mst13_hs4_hresp  ),
	.slv4_grant  (mst13_slv4_grant ),
	.slv4_base   (mst13_slv4_base  ),
	.slv4_sel    (mst13_slv4_sel   ),
	.slv4_size   (mst13_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst13_hs5_hrdata ),
	.hs5_hready  (mst13_hs5_hready ),
	.hs5_hresp   (mst13_hs5_hresp  ),
	.slv5_grant  (mst13_slv5_grant ),
	.slv5_base   (mst13_slv5_base  ),
	.slv5_sel    (mst13_slv5_sel   ),
	.slv5_size   (mst13_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst13_hs6_hrdata ),
	.hs6_hready  (mst13_hs6_hready ),
	.hs6_hresp   (mst13_hs6_hresp  ),
	.slv6_grant  (mst13_slv6_grant ),
	.slv6_base   (mst13_slv6_base  ),
	.slv6_sel    (mst13_slv6_sel   ),
	.slv6_size   (mst13_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst13_hs7_hrdata ),
	.hs7_hready  (mst13_hs7_hready ),
	.hs7_hresp   (mst13_hs7_hresp  ),
	.slv7_grant  (mst13_slv7_grant ),
	.slv7_base   (mst13_slv7_base  ),
	.slv7_sel    (mst13_slv7_sel   ),
	.slv7_size   (mst13_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst13_hs8_hrdata ),
	.hs8_hready  (mst13_hs8_hready ),
	.hs8_hresp   (mst13_hs8_hresp  ),
	.slv8_grant  (mst13_slv8_grant ),
	.slv8_base   (mst13_slv8_base  ),
	.slv8_sel    (mst13_slv8_sel   ),
	.slv8_size   (mst13_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst13_hs9_hrdata ),
	.hs9_hready  (mst13_hs9_hready ),
	.hs9_hresp   (mst13_hs9_hresp  ),
	.slv9_grant  (mst13_slv9_grant ),
	.slv9_base   (mst13_slv9_base  ),
	.slv9_sel    (mst13_slv9_sel   ),
	.slv9_size   (mst13_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst13_hs10_hrdata),
	.hs10_hready (mst13_hs10_hready),
	.hs10_hresp  (mst13_hs10_hresp ),
	.slv10_grant (mst13_slv10_grant),
	.slv10_base  (mst13_slv10_base ),
	.slv10_sel   (mst13_slv10_sel  ),
	.slv10_size  (mst13_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst13_hs11_hrdata),
	.hs11_hready (mst13_hs11_hready),
	.hs11_hresp  (mst13_hs11_hresp ),
	.slv11_grant (mst13_slv11_grant),
	.slv11_base  (mst13_slv11_base ),
	.slv11_sel   (mst13_slv11_sel  ),
	.slv11_size  (mst13_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst13_hs12_hrdata),
	.hs12_hready (mst13_hs12_hready),
	.hs12_hresp  (mst13_hs12_hresp ),
	.slv12_grant (mst13_slv12_grant),
	.slv12_base  (mst13_slv12_base ),
	.slv12_sel   (mst13_slv12_sel  ),
	.slv12_size  (mst13_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst13_hs13_hrdata),
	.hs13_hready (mst13_hs13_hready),
	.hs13_hresp  (mst13_hs13_hresp ),
	.slv13_grant (mst13_slv13_grant),
	.slv13_base  (mst13_slv13_base ),
	.slv13_sel   (mst13_slv13_sel  ),
	.slv13_size  (mst13_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst13_hs14_hrdata),
	.hs14_hready (mst13_hs14_hready),
	.hs14_hresp  (mst13_hs14_hresp ),
	.slv14_grant (mst13_slv14_grant),
	.slv14_base  (mst13_slv14_base ),
	.slv14_sel   (mst13_slv14_sel  ),
	.slv14_size  (mst13_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst13_hs15_hrdata),
	.hs15_hready (mst13_hs15_hready),
	.hs15_hresp  (mst13_hs15_hresp ),
	.slv15_grant (mst13_slv15_grant),
	.slv15_base  (mst13_slv15_base ),
	.slv15_sel   (mst13_slv15_sel  ),
	.slv15_size  (mst13_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen         ),
	.hclk        (hclk             ),
	.hm_haddr    (hm13_haddr       ),
	.hm_hburst   (hm13_hburst      ),
	.hm_hprot    (hm13_hprot       ),
	.hm_hrdata   (hm13_hrdata      ),
	.hm_hready   (hm13_hready      ),
	.hm_hresp    (hm13_hresp       ),
	.hm_hsize    (hm13_hsize       ),
	.hm_htrans   (hm13_htrans      ),
	.hm_hwrite   (hm13_hwrite      ),
	.hresetn     (hresetn          ),
	.mst_haddr   (mst13_haddr      ),
	.mst_hburst  (mst13_hburst     ),
	.mst_hprot   (mst13_hprot      ),
	.mst_hsize   (mst13_hsize      ),
	.mst_htrans  (mst13_htrans     ),
	.mst_hwrite  (mst13_hwrite     ),
	.resp_mode   (resp_mode        ),
	.slv_sel_err (mst13_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST14
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander14 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en     ),
	.ahb_slv1_en (ahb_slv1_en      ),
	.ahb_slv2_en (ahb_slv2_en      ),
	.ahb_slv3_en (ahb_slv3_en      ),
	.ahb_slv4_en (ahb_slv4_en      ),
	.ahb_slv5_en (ahb_slv5_en      ),
	.ahb_slv6_en (ahb_slv6_en      ),
	.ahb_slv7_en (ahb_slv7_en      ),
	.ahb_slv8_en (ahb_slv8_en      ),
	.ahb_slv9_en (ahb_slv9_en      ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst14_hs0_hrdata ),
	.hs0_hready  (mst14_hs0_hready ),
	.hs0_hresp   (mst14_hs0_hresp  ),
	.slv0_grant  (mst14_slv0_grant ),
	.slv0_base   (mst14_slv0_base  ),
	.slv0_sel    (mst14_slv0_sel   ),
	.slv0_size   (mst14_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst14_hs1_hrdata ),
	.hs1_hready  (mst14_hs1_hready ),
	.hs1_hresp   (mst14_hs1_hresp  ),
	.slv1_grant  (mst14_slv1_grant ),
	.slv1_base   (mst14_slv1_base  ),
	.slv1_sel    (mst14_slv1_sel   ),
	.slv1_size   (mst14_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst14_hs2_hrdata ),
	.hs2_hready  (mst14_hs2_hready ),
	.hs2_hresp   (mst14_hs2_hresp  ),
	.slv2_grant  (mst14_slv2_grant ),
	.slv2_base   (mst14_slv2_base  ),
	.slv2_sel    (mst14_slv2_sel   ),
	.slv2_size   (mst14_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst14_hs3_hrdata ),
	.hs3_hready  (mst14_hs3_hready ),
	.hs3_hresp   (mst14_hs3_hresp  ),
	.slv3_grant  (mst14_slv3_grant ),
	.slv3_base   (mst14_slv3_base  ),
	.slv3_sel    (mst14_slv3_sel   ),
	.slv3_size   (mst14_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst14_hs4_hrdata ),
	.hs4_hready  (mst14_hs4_hready ),
	.hs4_hresp   (mst14_hs4_hresp  ),
	.slv4_grant  (mst14_slv4_grant ),
	.slv4_base   (mst14_slv4_base  ),
	.slv4_sel    (mst14_slv4_sel   ),
	.slv4_size   (mst14_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst14_hs5_hrdata ),
	.hs5_hready  (mst14_hs5_hready ),
	.hs5_hresp   (mst14_hs5_hresp  ),
	.slv5_grant  (mst14_slv5_grant ),
	.slv5_base   (mst14_slv5_base  ),
	.slv5_sel    (mst14_slv5_sel   ),
	.slv5_size   (mst14_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst14_hs6_hrdata ),
	.hs6_hready  (mst14_hs6_hready ),
	.hs6_hresp   (mst14_hs6_hresp  ),
	.slv6_grant  (mst14_slv6_grant ),
	.slv6_base   (mst14_slv6_base  ),
	.slv6_sel    (mst14_slv6_sel   ),
	.slv6_size   (mst14_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst14_hs7_hrdata ),
	.hs7_hready  (mst14_hs7_hready ),
	.hs7_hresp   (mst14_hs7_hresp  ),
	.slv7_grant  (mst14_slv7_grant ),
	.slv7_base   (mst14_slv7_base  ),
	.slv7_sel    (mst14_slv7_sel   ),
	.slv7_size   (mst14_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst14_hs8_hrdata ),
	.hs8_hready  (mst14_hs8_hready ),
	.hs8_hresp   (mst14_hs8_hresp  ),
	.slv8_grant  (mst14_slv8_grant ),
	.slv8_base   (mst14_slv8_base  ),
	.slv8_sel    (mst14_slv8_sel   ),
	.slv8_size   (mst14_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst14_hs9_hrdata ),
	.hs9_hready  (mst14_hs9_hready ),
	.hs9_hresp   (mst14_hs9_hresp  ),
	.slv9_grant  (mst14_slv9_grant ),
	.slv9_base   (mst14_slv9_base  ),
	.slv9_sel    (mst14_slv9_sel   ),
	.slv9_size   (mst14_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst14_hs10_hrdata),
	.hs10_hready (mst14_hs10_hready),
	.hs10_hresp  (mst14_hs10_hresp ),
	.slv10_grant (mst14_slv10_grant),
	.slv10_base  (mst14_slv10_base ),
	.slv10_sel   (mst14_slv10_sel  ),
	.slv10_size  (mst14_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst14_hs11_hrdata),
	.hs11_hready (mst14_hs11_hready),
	.hs11_hresp  (mst14_hs11_hresp ),
	.slv11_grant (mst14_slv11_grant),
	.slv11_base  (mst14_slv11_base ),
	.slv11_sel   (mst14_slv11_sel  ),
	.slv11_size  (mst14_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst14_hs12_hrdata),
	.hs12_hready (mst14_hs12_hready),
	.hs12_hresp  (mst14_hs12_hresp ),
	.slv12_grant (mst14_slv12_grant),
	.slv12_base  (mst14_slv12_base ),
	.slv12_sel   (mst14_slv12_sel  ),
	.slv12_size  (mst14_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst14_hs13_hrdata),
	.hs13_hready (mst14_hs13_hready),
	.hs13_hresp  (mst14_hs13_hresp ),
	.slv13_grant (mst14_slv13_grant),
	.slv13_base  (mst14_slv13_base ),
	.slv13_sel   (mst14_slv13_sel  ),
	.slv13_size  (mst14_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst14_hs14_hrdata),
	.hs14_hready (mst14_hs14_hready),
	.hs14_hresp  (mst14_hs14_hresp ),
	.slv14_grant (mst14_slv14_grant),
	.slv14_base  (mst14_slv14_base ),
	.slv14_sel   (mst14_slv14_sel  ),
	.slv14_size  (mst14_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst14_hs15_hrdata),
	.hs15_hready (mst14_hs15_hready),
	.hs15_hresp  (mst14_hs15_hresp ),
	.slv15_grant (mst14_slv15_grant),
	.slv15_base  (mst14_slv15_base ),
	.slv15_sel   (mst14_slv15_sel  ),
	.slv15_size  (mst14_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen         ),
	.hclk        (hclk             ),
	.hm_haddr    (hm14_haddr       ),
	.hm_hburst   (hm14_hburst      ),
	.hm_hprot    (hm14_hprot       ),
	.hm_hrdata   (hm14_hrdata      ),
	.hm_hready   (hm14_hready      ),
	.hm_hresp    (hm14_hresp       ),
	.hm_hsize    (hm14_hsize       ),
	.hm_htrans   (hm14_htrans      ),
	.hm_hwrite   (hm14_hwrite      ),
	.hresetn     (hresetn          ),
	.mst_haddr   (mst14_haddr      ),
	.mst_hburst  (mst14_hburst     ),
	.mst_hprot   (mst14_hprot      ),
	.mst_hsize   (mst14_hsize      ),
	.mst_htrans  (mst14_htrans     ),
	.mst_hwrite  (mst14_hwrite     ),
	.resp_mode   (resp_mode        ),
	.slv_sel_err (mst14_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_MST15
atcbmc200_mst_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_commander15 (
   `ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en     ),
	.ahb_slv1_en (ahb_slv1_en      ),
	.ahb_slv2_en (ahb_slv2_en      ),
	.ahb_slv3_en (ahb_slv3_en      ),
	.ahb_slv4_en (ahb_slv4_en      ),
	.ahb_slv5_en (ahb_slv5_en      ),
	.ahb_slv6_en (ahb_slv6_en      ),
	.ahb_slv7_en (ahb_slv7_en      ),
	.ahb_slv8_en (ahb_slv8_en      ),
	.ahb_slv9_en (ahb_slv9_en      ),
   `endif
   `ifdef ATCBMC200_AHB_SLV0
	.hs0_hrdata  (mst15_hs0_hrdata ),
	.hs0_hready  (mst15_hs0_hready ),
	.hs0_hresp   (mst15_hs0_hresp  ),
	.slv0_grant  (mst15_slv0_grant ),
	.slv0_base   (mst15_slv0_base  ),
	.slv0_sel    (mst15_slv0_sel   ),
	.slv0_size   (mst15_slv0_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	.hs1_hrdata  (mst15_hs1_hrdata ),
	.hs1_hready  (mst15_hs1_hready ),
	.hs1_hresp   (mst15_hs1_hresp  ),
	.slv1_grant  (mst15_slv1_grant ),
	.slv1_base   (mst15_slv1_base  ),
	.slv1_sel    (mst15_slv1_sel   ),
	.slv1_size   (mst15_slv1_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	.hs2_hrdata  (mst15_hs2_hrdata ),
	.hs2_hready  (mst15_hs2_hready ),
	.hs2_hresp   (mst15_hs2_hresp  ),
	.slv2_grant  (mst15_slv2_grant ),
	.slv2_base   (mst15_slv2_base  ),
	.slv2_sel    (mst15_slv2_sel   ),
	.slv2_size   (mst15_slv2_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	.hs3_hrdata  (mst15_hs3_hrdata ),
	.hs3_hready  (mst15_hs3_hready ),
	.hs3_hresp   (mst15_hs3_hresp  ),
	.slv3_grant  (mst15_slv3_grant ),
	.slv3_base   (mst15_slv3_base  ),
	.slv3_sel    (mst15_slv3_sel   ),
	.slv3_size   (mst15_slv3_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	.hs4_hrdata  (mst15_hs4_hrdata ),
	.hs4_hready  (mst15_hs4_hready ),
	.hs4_hresp   (mst15_hs4_hresp  ),
	.slv4_grant  (mst15_slv4_grant ),
	.slv4_base   (mst15_slv4_base  ),
	.slv4_sel    (mst15_slv4_sel   ),
	.slv4_size   (mst15_slv4_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	.hs5_hrdata  (mst15_hs5_hrdata ),
	.hs5_hready  (mst15_hs5_hready ),
	.hs5_hresp   (mst15_hs5_hresp  ),
	.slv5_grant  (mst15_slv5_grant ),
	.slv5_base   (mst15_slv5_base  ),
	.slv5_sel    (mst15_slv5_sel   ),
	.slv5_size   (mst15_slv5_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	.hs6_hrdata  (mst15_hs6_hrdata ),
	.hs6_hready  (mst15_hs6_hready ),
	.hs6_hresp   (mst15_hs6_hresp  ),
	.slv6_grant  (mst15_slv6_grant ),
	.slv6_base   (mst15_slv6_base  ),
	.slv6_sel    (mst15_slv6_sel   ),
	.slv6_size   (mst15_slv6_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	.hs7_hrdata  (mst15_hs7_hrdata ),
	.hs7_hready  (mst15_hs7_hready ),
	.hs7_hresp   (mst15_hs7_hresp  ),
	.slv7_grant  (mst15_slv7_grant ),
	.slv7_base   (mst15_slv7_base  ),
	.slv7_sel    (mst15_slv7_sel   ),
	.slv7_size   (mst15_slv7_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	.hs8_hrdata  (mst15_hs8_hrdata ),
	.hs8_hready  (mst15_hs8_hready ),
	.hs8_hresp   (mst15_hs8_hresp  ),
	.slv8_grant  (mst15_slv8_grant ),
	.slv8_base   (mst15_slv8_base  ),
	.slv8_sel    (mst15_slv8_sel   ),
	.slv8_size   (mst15_slv8_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	.hs9_hrdata  (mst15_hs9_hrdata ),
	.hs9_hready  (mst15_hs9_hready ),
	.hs9_hresp   (mst15_hs9_hresp  ),
	.slv9_grant  (mst15_slv9_grant ),
	.slv9_base   (mst15_slv9_base  ),
	.slv9_sel    (mst15_slv9_sel   ),
	.slv9_size   (mst15_slv9_size  ),
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	.hs10_hrdata (mst15_hs10_hrdata),
	.hs10_hready (mst15_hs10_hready),
	.hs10_hresp  (mst15_hs10_hresp ),
	.slv10_grant (mst15_slv10_grant),
	.slv10_base  (mst15_slv10_base ),
	.slv10_sel   (mst15_slv10_sel  ),
	.slv10_size  (mst15_slv10_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	.hs11_hrdata (mst15_hs11_hrdata),
	.hs11_hready (mst15_hs11_hready),
	.hs11_hresp  (mst15_hs11_hresp ),
	.slv11_grant (mst15_slv11_grant),
	.slv11_base  (mst15_slv11_base ),
	.slv11_sel   (mst15_slv11_sel  ),
	.slv11_size  (mst15_slv11_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	.hs12_hrdata (mst15_hs12_hrdata),
	.hs12_hready (mst15_hs12_hready),
	.hs12_hresp  (mst15_hs12_hresp ),
	.slv12_grant (mst15_slv12_grant),
	.slv12_base  (mst15_slv12_base ),
	.slv12_sel   (mst15_slv12_sel  ),
	.slv12_size  (mst15_slv12_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	.hs13_hrdata (mst15_hs13_hrdata),
	.hs13_hready (mst15_hs13_hready),
	.hs13_hresp  (mst15_hs13_hresp ),
	.slv13_grant (mst15_slv13_grant),
	.slv13_base  (mst15_slv13_base ),
	.slv13_sel   (mst15_slv13_sel  ),
	.slv13_size  (mst15_slv13_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	.hs14_hrdata (mst15_hs14_hrdata),
	.hs14_hready (mst15_hs14_hready),
	.hs14_hresp  (mst15_hs14_hresp ),
	.slv14_grant (mst15_slv14_grant),
	.slv14_base  (mst15_slv14_base ),
	.slv14_sel   (mst15_slv14_sel  ),
	.slv14_size  (mst15_slv14_size ),
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	.hs15_hrdata (mst15_hs15_hrdata),
	.hs15_hready (mst15_hs15_hready),
	.hs15_hresp  (mst15_hs15_hresp ),
	.slv15_grant (mst15_slv15_grant),
	.slv15_base  (mst15_slv15_base ),
	.slv15_sel   (mst15_slv15_sel  ),
	.slv15_size  (mst15_slv15_size ),
   `endif
	.ctrl_wen    (ctrl_wen         ),
	.hclk        (hclk             ),
	.hm_haddr    (hm15_haddr       ),
	.hm_hburst   (hm15_hburst      ),
	.hm_hprot    (hm15_hprot       ),
	.hm_hrdata   (hm15_hrdata      ),
	.hm_hready   (hm15_hready      ),
	.hm_hresp    (hm15_hresp       ),
	.hm_hsize    (hm15_hsize       ),
	.hm_htrans   (hm15_htrans      ),
	.hm_hwrite   (hm15_hwrite      ),
	.hresetn     (hresetn          ),
	.mst_haddr   (mst15_haddr      ),
	.mst_hburst  (mst15_hburst     ),
	.mst_hprot   (mst15_hprot      ),
	.mst_hsize   (mst15_hsize      ),
	.mst_htrans  (mst15_htrans     ),
	.mst_hwrite  (mst15_hwrite     ),
	.resp_mode   (resp_mode        ),
	.slv_sel_err (mst15_sel_err    )
);

`endif
`ifdef ATCBMC200_AHB_SLV0
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander0 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv0_hwdata  ),
	.mst0_ack       (mst0_slv0_ack    ),
	.mst0_haddr     (mst0_slv0_haddr  ),
	.mst0_hburst    (mst0_slv0_hburst ),
	.mst0_hprot     (mst0_slv0_hprot  ),
	.mst0_hsize     (mst0_slv0_hsize  ),
	.mst0_htrans    (mst0_slv0_htrans ),
	.mst0_hwrite    (mst0_slv0_hwrite ),
	.mst0_req       (mst0_slv0_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv0_hwdata  ),
	.mst1_ack       (mst1_slv0_ack    ),
	.mst1_haddr     (mst1_slv0_haddr  ),
	.mst1_hburst    (mst1_slv0_hburst ),
	.mst1_hprot     (mst1_slv0_hprot  ),
	.mst1_hsize     (mst1_slv0_hsize  ),
	.mst1_htrans    (mst1_slv0_htrans ),
	.mst1_hwrite    (mst1_slv0_hwrite ),
	.mst1_req       (mst1_slv0_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv0_hwdata  ),
	.mst2_ack       (mst2_slv0_ack    ),
	.mst2_haddr     (mst2_slv0_haddr  ),
	.mst2_hburst    (mst2_slv0_hburst ),
	.mst2_hprot     (mst2_slv0_hprot  ),
	.mst2_hsize     (mst2_slv0_hsize  ),
	.mst2_htrans    (mst2_slv0_htrans ),
	.mst2_hwrite    (mst2_slv0_hwrite ),
	.mst2_req       (mst2_slv0_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv0_hwdata  ),
	.mst3_ack       (mst3_slv0_ack    ),
	.mst3_haddr     (mst3_slv0_haddr  ),
	.mst3_hburst    (mst3_slv0_hburst ),
	.mst3_hprot     (mst3_slv0_hprot  ),
	.mst3_hsize     (mst3_slv0_hsize  ),
	.mst3_htrans    (mst3_slv0_htrans ),
	.mst3_hwrite    (mst3_slv0_hwrite ),
	.mst3_req       (mst3_slv0_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv0_hwdata  ),
	.mst4_ack       (mst4_slv0_ack    ),
	.mst4_haddr     (mst4_slv0_haddr  ),
	.mst4_hburst    (mst4_slv0_hburst ),
	.mst4_hprot     (mst4_slv0_hprot  ),
	.mst4_hsize     (mst4_slv0_hsize  ),
	.mst4_htrans    (mst4_slv0_htrans ),
	.mst4_hwrite    (mst4_slv0_hwrite ),
	.mst4_req       (mst4_slv0_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv0_hwdata  ),
	.mst5_ack       (mst5_slv0_ack    ),
	.mst5_haddr     (mst5_slv0_haddr  ),
	.mst5_hburst    (mst5_slv0_hburst ),
	.mst5_hprot     (mst5_slv0_hprot  ),
	.mst5_hsize     (mst5_slv0_hsize  ),
	.mst5_htrans    (mst5_slv0_htrans ),
	.mst5_hwrite    (mst5_slv0_hwrite ),
	.mst5_req       (mst5_slv0_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv0_hwdata  ),
	.mst6_ack       (mst6_slv0_ack    ),
	.mst6_haddr     (mst6_slv0_haddr  ),
	.mst6_hburst    (mst6_slv0_hburst ),
	.mst6_hprot     (mst6_slv0_hprot  ),
	.mst6_hsize     (mst6_slv0_hsize  ),
	.mst6_htrans    (mst6_slv0_htrans ),
	.mst6_hwrite    (mst6_slv0_hwrite ),
	.mst6_req       (mst6_slv0_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv0_hwdata  ),
	.mst7_ack       (mst7_slv0_ack    ),
	.mst7_haddr     (mst7_slv0_haddr  ),
	.mst7_hburst    (mst7_slv0_hburst ),
	.mst7_hprot     (mst7_slv0_hprot  ),
	.mst7_hsize     (mst7_slv0_hsize  ),
	.mst7_htrans    (mst7_slv0_htrans ),
	.mst7_hwrite    (mst7_slv0_hwrite ),
	.mst7_req       (mst7_slv0_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv0_hwdata  ),
	.mst8_ack       (mst8_slv0_ack    ),
	.mst8_haddr     (mst8_slv0_haddr  ),
	.mst8_hburst    (mst8_slv0_hburst ),
	.mst8_hprot     (mst8_slv0_hprot  ),
	.mst8_hsize     (mst8_slv0_hsize  ),
	.mst8_htrans    (mst8_slv0_htrans ),
	.mst8_hwrite    (mst8_slv0_hwrite ),
	.mst8_req       (mst8_slv0_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv0_hwdata  ),
	.mst9_ack       (mst9_slv0_ack    ),
	.mst9_haddr     (mst9_slv0_haddr  ),
	.mst9_hburst    (mst9_slv0_hburst ),
	.mst9_hprot     (mst9_slv0_hprot  ),
	.mst9_hsize     (mst9_slv0_hsize  ),
	.mst9_htrans    (mst9_slv0_htrans ),
	.mst9_hwrite    (mst9_slv0_hwrite ),
	.mst9_req       (mst9_slv0_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv0_hwdata ),
	.mst10_ack      (mst10_slv0_ack   ),
	.mst10_haddr    (mst10_slv0_haddr ),
	.mst10_hburst   (mst10_slv0_hburst),
	.mst10_hprot    (mst10_slv0_hprot ),
	.mst10_hsize    (mst10_slv0_hsize ),
	.mst10_htrans   (mst10_slv0_htrans),
	.mst10_hwrite   (mst10_slv0_hwrite),
	.mst10_req      (mst10_slv0_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv0_hwdata ),
	.mst11_ack      (mst11_slv0_ack   ),
	.mst11_haddr    (mst11_slv0_haddr ),
	.mst11_hburst   (mst11_slv0_hburst),
	.mst11_hprot    (mst11_slv0_hprot ),
	.mst11_hsize    (mst11_slv0_hsize ),
	.mst11_htrans   (mst11_slv0_htrans),
	.mst11_hwrite   (mst11_slv0_hwrite),
	.mst11_req      (mst11_slv0_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv0_hwdata ),
	.mst12_ack      (mst12_slv0_ack   ),
	.mst12_haddr    (mst12_slv0_haddr ),
	.mst12_hburst   (mst12_slv0_hburst),
	.mst12_hprot    (mst12_slv0_hprot ),
	.mst12_hsize    (mst12_slv0_hsize ),
	.mst12_htrans   (mst12_slv0_htrans),
	.mst12_hwrite   (mst12_slv0_hwrite),
	.mst12_req      (mst12_slv0_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv0_hwdata ),
	.mst13_ack      (mst13_slv0_ack   ),
	.mst13_haddr    (mst13_slv0_haddr ),
	.mst13_hburst   (mst13_slv0_hburst),
	.mst13_hprot    (mst13_slv0_hprot ),
	.mst13_hsize    (mst13_slv0_hsize ),
	.mst13_htrans   (mst13_slv0_htrans),
	.mst13_hwrite   (mst13_slv0_hwrite),
	.mst13_req      (mst13_slv0_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv0_hwdata ),
	.mst14_ack      (mst14_slv0_ack   ),
	.mst14_haddr    (mst14_slv0_haddr ),
	.mst14_hburst   (mst14_slv0_hburst),
	.mst14_hprot    (mst14_slv0_hprot ),
	.mst14_hsize    (mst14_slv0_hsize ),
	.mst14_htrans   (mst14_slv0_htrans),
	.mst14_hwrite   (mst14_slv0_hwrite),
	.mst14_req      (mst14_slv0_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv0_hwdata ),
	.mst15_ack      (mst15_slv0_ack   ),
	.mst15_haddr    (mst15_slv0_haddr ),
	.mst15_hburst   (mst15_slv0_hburst),
	.mst15_hprot    (mst15_slv0_hprot ),
	.mst15_hsize    (mst15_slv0_hsize ),
	.mst15_htrans   (mst15_slv0_htrans),
	.mst15_hwrite   (mst15_slv0_hwrite),
	.mst15_req      (mst15_slv0_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs0_hready   ),
	.hclk           (hclk             ),
	.hresetn        (hresetn          ),
	.hs_bmc_hready  (hs0_bmc_hready   ),
	.hs_haddr       (hs0_haddr        ),
	.hs_hburst      (         ),
	.hs_hprot       (         ),
	.hs_hresp       (hs0_hresp        ),
	.hs_hsel        (hs0_hsel         ),
	.hs_hsize       (hs0_hsize        ),
	.hs_htrans      (hs0_htrans       ),
	.hs_hwdata      (hs0_hwdata       ),
	.hs_hwrite      (hs0_hwrite       ),
	.init_priority  (init_priority    ),
	.mst0_highest_en(mst0_highest_en  )
);

`endif
`ifdef ATCBMC200_AHB_SLV1
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander1 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv1_hwdata  ),
	.mst0_ack       (mst0_slv1_ack    ),
	.mst0_haddr     (mst0_slv1_haddr  ),
	.mst0_hburst    (mst0_slv1_hburst ),
	.mst0_hprot     (mst0_slv1_hprot  ),
	.mst0_hsize     (mst0_slv1_hsize  ),
	.mst0_htrans    (mst0_slv1_htrans ),
	.mst0_hwrite    (mst0_slv1_hwrite ),
	.mst0_req       (mst0_slv1_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv1_hwdata  ),
	.mst1_ack       (mst1_slv1_ack    ),
	.mst1_haddr     (mst1_slv1_haddr  ),
	.mst1_hburst    (mst1_slv1_hburst ),
	.mst1_hprot     (mst1_slv1_hprot  ),
	.mst1_hsize     (mst1_slv1_hsize  ),
	.mst1_htrans    (mst1_slv1_htrans ),
	.mst1_hwrite    (mst1_slv1_hwrite ),
	.mst1_req       (mst1_slv1_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv1_hwdata  ),
	.mst2_ack       (mst2_slv1_ack    ),
	.mst2_haddr     (mst2_slv1_haddr  ),
	.mst2_hburst    (mst2_slv1_hburst ),
	.mst2_hprot     (mst2_slv1_hprot  ),
	.mst2_hsize     (mst2_slv1_hsize  ),
	.mst2_htrans    (mst2_slv1_htrans ),
	.mst2_hwrite    (mst2_slv1_hwrite ),
	.mst2_req       (mst2_slv1_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv1_hwdata  ),
	.mst3_ack       (mst3_slv1_ack    ),
	.mst3_haddr     (mst3_slv1_haddr  ),
	.mst3_hburst    (mst3_slv1_hburst ),
	.mst3_hprot     (mst3_slv1_hprot  ),
	.mst3_hsize     (mst3_slv1_hsize  ),
	.mst3_htrans    (mst3_slv1_htrans ),
	.mst3_hwrite    (mst3_slv1_hwrite ),
	.mst3_req       (mst3_slv1_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv1_hwdata  ),
	.mst4_ack       (mst4_slv1_ack    ),
	.mst4_haddr     (mst4_slv1_haddr  ),
	.mst4_hburst    (mst4_slv1_hburst ),
	.mst4_hprot     (mst4_slv1_hprot  ),
	.mst4_hsize     (mst4_slv1_hsize  ),
	.mst4_htrans    (mst4_slv1_htrans ),
	.mst4_hwrite    (mst4_slv1_hwrite ),
	.mst4_req       (mst4_slv1_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv1_hwdata  ),
	.mst5_ack       (mst5_slv1_ack    ),
	.mst5_haddr     (mst5_slv1_haddr  ),
	.mst5_hburst    (mst5_slv1_hburst ),
	.mst5_hprot     (mst5_slv1_hprot  ),
	.mst5_hsize     (mst5_slv1_hsize  ),
	.mst5_htrans    (mst5_slv1_htrans ),
	.mst5_hwrite    (mst5_slv1_hwrite ),
	.mst5_req       (mst5_slv1_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv1_hwdata  ),
	.mst6_ack       (mst6_slv1_ack    ),
	.mst6_haddr     (mst6_slv1_haddr  ),
	.mst6_hburst    (mst6_slv1_hburst ),
	.mst6_hprot     (mst6_slv1_hprot  ),
	.mst6_hsize     (mst6_slv1_hsize  ),
	.mst6_htrans    (mst6_slv1_htrans ),
	.mst6_hwrite    (mst6_slv1_hwrite ),
	.mst6_req       (mst6_slv1_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv1_hwdata  ),
	.mst7_ack       (mst7_slv1_ack    ),
	.mst7_haddr     (mst7_slv1_haddr  ),
	.mst7_hburst    (mst7_slv1_hburst ),
	.mst7_hprot     (mst7_slv1_hprot  ),
	.mst7_hsize     (mst7_slv1_hsize  ),
	.mst7_htrans    (mst7_slv1_htrans ),
	.mst7_hwrite    (mst7_slv1_hwrite ),
	.mst7_req       (mst7_slv1_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv1_hwdata  ),
	.mst8_ack       (mst8_slv1_ack    ),
	.mst8_haddr     (mst8_slv1_haddr  ),
	.mst8_hburst    (mst8_slv1_hburst ),
	.mst8_hprot     (mst8_slv1_hprot  ),
	.mst8_hsize     (mst8_slv1_hsize  ),
	.mst8_htrans    (mst8_slv1_htrans ),
	.mst8_hwrite    (mst8_slv1_hwrite ),
	.mst8_req       (mst8_slv1_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv1_hwdata  ),
	.mst9_ack       (mst9_slv1_ack    ),
	.mst9_haddr     (mst9_slv1_haddr  ),
	.mst9_hburst    (mst9_slv1_hburst ),
	.mst9_hprot     (mst9_slv1_hprot  ),
	.mst9_hsize     (mst9_slv1_hsize  ),
	.mst9_htrans    (mst9_slv1_htrans ),
	.mst9_hwrite    (mst9_slv1_hwrite ),
	.mst9_req       (mst9_slv1_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv1_hwdata ),
	.mst10_ack      (mst10_slv1_ack   ),
	.mst10_haddr    (mst10_slv1_haddr ),
	.mst10_hburst   (mst10_slv1_hburst),
	.mst10_hprot    (mst10_slv1_hprot ),
	.mst10_hsize    (mst10_slv1_hsize ),
	.mst10_htrans   (mst10_slv1_htrans),
	.mst10_hwrite   (mst10_slv1_hwrite),
	.mst10_req      (mst10_slv1_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv1_hwdata ),
	.mst11_ack      (mst11_slv1_ack   ),
	.mst11_haddr    (mst11_slv1_haddr ),
	.mst11_hburst   (mst11_slv1_hburst),
	.mst11_hprot    (mst11_slv1_hprot ),
	.mst11_hsize    (mst11_slv1_hsize ),
	.mst11_htrans   (mst11_slv1_htrans),
	.mst11_hwrite   (mst11_slv1_hwrite),
	.mst11_req      (mst11_slv1_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv1_hwdata ),
	.mst12_ack      (mst12_slv1_ack   ),
	.mst12_haddr    (mst12_slv1_haddr ),
	.mst12_hburst   (mst12_slv1_hburst),
	.mst12_hprot    (mst12_slv1_hprot ),
	.mst12_hsize    (mst12_slv1_hsize ),
	.mst12_htrans   (mst12_slv1_htrans),
	.mst12_hwrite   (mst12_slv1_hwrite),
	.mst12_req      (mst12_slv1_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv1_hwdata ),
	.mst13_ack      (mst13_slv1_ack   ),
	.mst13_haddr    (mst13_slv1_haddr ),
	.mst13_hburst   (mst13_slv1_hburst),
	.mst13_hprot    (mst13_slv1_hprot ),
	.mst13_hsize    (mst13_slv1_hsize ),
	.mst13_htrans   (mst13_slv1_htrans),
	.mst13_hwrite   (mst13_slv1_hwrite),
	.mst13_req      (mst13_slv1_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv1_hwdata ),
	.mst14_ack      (mst14_slv1_ack   ),
	.mst14_haddr    (mst14_slv1_haddr ),
	.mst14_hburst   (mst14_slv1_hburst),
	.mst14_hprot    (mst14_slv1_hprot ),
	.mst14_hsize    (mst14_slv1_hsize ),
	.mst14_htrans   (mst14_slv1_htrans),
	.mst14_hwrite   (mst14_slv1_hwrite),
	.mst14_req      (mst14_slv1_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv1_hwdata ),
	.mst15_ack      (mst15_slv1_ack   ),
	.mst15_haddr    (mst15_slv1_haddr ),
	.mst15_hburst   (mst15_slv1_hburst),
	.mst15_hprot    (mst15_slv1_hprot ),
	.mst15_hsize    (mst15_slv1_hsize ),
	.mst15_htrans   (mst15_slv1_htrans),
	.mst15_hwrite   (mst15_slv1_hwrite),
	.mst15_req      (mst15_slv1_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs1_hready   ),
	.hclk           (hclk             ),
	.hresetn        (hresetn          ),
	.hs_bmc_hready  (hs1_bmc_hready   ),
	.hs_haddr       (hs1_haddr        ),
	.hs_hburst      (hs1_hburst       ),
	.hs_hprot       (hs1_hprot        ),
	.hs_hresp       (hs1_hresp        ),
	.hs_hsel        (hs1_hsel         ),
	.hs_hsize       (hs1_hsize        ),
	.hs_htrans      (hs1_htrans       ),
	.hs_hwdata      (hs1_hwdata       ),
	.hs_hwrite      (hs1_hwrite       ),
	.init_priority  (init_priority    ),
	.mst0_highest_en(mst0_highest_en  )
);

`endif
`ifdef ATCBMC200_AHB_SLV2
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander2 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv2_hwdata  ),
	.mst0_ack       (mst0_slv2_ack    ),
	.mst0_haddr     (mst0_slv2_haddr  ),
	.mst0_hburst    (mst0_slv2_hburst ),
	.mst0_hprot     (mst0_slv2_hprot  ),
	.mst0_hsize     (mst0_slv2_hsize  ),
	.mst0_htrans    (mst0_slv2_htrans ),
	.mst0_hwrite    (mst0_slv2_hwrite ),
	.mst0_req       (mst0_slv2_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv2_hwdata  ),
	.mst1_ack       (mst1_slv2_ack    ),
	.mst1_haddr     (mst1_slv2_haddr  ),
	.mst1_hburst    (mst1_slv2_hburst ),
	.mst1_hprot     (mst1_slv2_hprot  ),
	.mst1_hsize     (mst1_slv2_hsize  ),
	.mst1_htrans    (mst1_slv2_htrans ),
	.mst1_hwrite    (mst1_slv2_hwrite ),
	.mst1_req       (mst1_slv2_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv2_hwdata  ),
	.mst2_ack       (mst2_slv2_ack    ),
	.mst2_haddr     (mst2_slv2_haddr  ),
	.mst2_hburst    (mst2_slv2_hburst ),
	.mst2_hprot     (mst2_slv2_hprot  ),
	.mst2_hsize     (mst2_slv2_hsize  ),
	.mst2_htrans    (mst2_slv2_htrans ),
	.mst2_hwrite    (mst2_slv2_hwrite ),
	.mst2_req       (mst2_slv2_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv2_hwdata  ),
	.mst3_ack       (mst3_slv2_ack    ),
	.mst3_haddr     (mst3_slv2_haddr  ),
	.mst3_hburst    (mst3_slv2_hburst ),
	.mst3_hprot     (mst3_slv2_hprot  ),
	.mst3_hsize     (mst3_slv2_hsize  ),
	.mst3_htrans    (mst3_slv2_htrans ),
	.mst3_hwrite    (mst3_slv2_hwrite ),
	.mst3_req       (mst3_slv2_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv2_hwdata  ),
	.mst4_ack       (mst4_slv2_ack    ),
	.mst4_haddr     (mst4_slv2_haddr  ),
	.mst4_hburst    (mst4_slv2_hburst ),
	.mst4_hprot     (mst4_slv2_hprot  ),
	.mst4_hsize     (mst4_slv2_hsize  ),
	.mst4_htrans    (mst4_slv2_htrans ),
	.mst4_hwrite    (mst4_slv2_hwrite ),
	.mst4_req       (mst4_slv2_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv2_hwdata  ),
	.mst5_ack       (mst5_slv2_ack    ),
	.mst5_haddr     (mst5_slv2_haddr  ),
	.mst5_hburst    (mst5_slv2_hburst ),
	.mst5_hprot     (mst5_slv2_hprot  ),
	.mst5_hsize     (mst5_slv2_hsize  ),
	.mst5_htrans    (mst5_slv2_htrans ),
	.mst5_hwrite    (mst5_slv2_hwrite ),
	.mst5_req       (mst5_slv2_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv2_hwdata  ),
	.mst6_ack       (mst6_slv2_ack    ),
	.mst6_haddr     (mst6_slv2_haddr  ),
	.mst6_hburst    (mst6_slv2_hburst ),
	.mst6_hprot     (mst6_slv2_hprot  ),
	.mst6_hsize     (mst6_slv2_hsize  ),
	.mst6_htrans    (mst6_slv2_htrans ),
	.mst6_hwrite    (mst6_slv2_hwrite ),
	.mst6_req       (mst6_slv2_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv2_hwdata  ),
	.mst7_ack       (mst7_slv2_ack    ),
	.mst7_haddr     (mst7_slv2_haddr  ),
	.mst7_hburst    (mst7_slv2_hburst ),
	.mst7_hprot     (mst7_slv2_hprot  ),
	.mst7_hsize     (mst7_slv2_hsize  ),
	.mst7_htrans    (mst7_slv2_htrans ),
	.mst7_hwrite    (mst7_slv2_hwrite ),
	.mst7_req       (mst7_slv2_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv2_hwdata  ),
	.mst8_ack       (mst8_slv2_ack    ),
	.mst8_haddr     (mst8_slv2_haddr  ),
	.mst8_hburst    (mst8_slv2_hburst ),
	.mst8_hprot     (mst8_slv2_hprot  ),
	.mst8_hsize     (mst8_slv2_hsize  ),
	.mst8_htrans    (mst8_slv2_htrans ),
	.mst8_hwrite    (mst8_slv2_hwrite ),
	.mst8_req       (mst8_slv2_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv2_hwdata  ),
	.mst9_ack       (mst9_slv2_ack    ),
	.mst9_haddr     (mst9_slv2_haddr  ),
	.mst9_hburst    (mst9_slv2_hburst ),
	.mst9_hprot     (mst9_slv2_hprot  ),
	.mst9_hsize     (mst9_slv2_hsize  ),
	.mst9_htrans    (mst9_slv2_htrans ),
	.mst9_hwrite    (mst9_slv2_hwrite ),
	.mst9_req       (mst9_slv2_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv2_hwdata ),
	.mst10_ack      (mst10_slv2_ack   ),
	.mst10_haddr    (mst10_slv2_haddr ),
	.mst10_hburst   (mst10_slv2_hburst),
	.mst10_hprot    (mst10_slv2_hprot ),
	.mst10_hsize    (mst10_slv2_hsize ),
	.mst10_htrans   (mst10_slv2_htrans),
	.mst10_hwrite   (mst10_slv2_hwrite),
	.mst10_req      (mst10_slv2_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv2_hwdata ),
	.mst11_ack      (mst11_slv2_ack   ),
	.mst11_haddr    (mst11_slv2_haddr ),
	.mst11_hburst   (mst11_slv2_hburst),
	.mst11_hprot    (mst11_slv2_hprot ),
	.mst11_hsize    (mst11_slv2_hsize ),
	.mst11_htrans   (mst11_slv2_htrans),
	.mst11_hwrite   (mst11_slv2_hwrite),
	.mst11_req      (mst11_slv2_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv2_hwdata ),
	.mst12_ack      (mst12_slv2_ack   ),
	.mst12_haddr    (mst12_slv2_haddr ),
	.mst12_hburst   (mst12_slv2_hburst),
	.mst12_hprot    (mst12_slv2_hprot ),
	.mst12_hsize    (mst12_slv2_hsize ),
	.mst12_htrans   (mst12_slv2_htrans),
	.mst12_hwrite   (mst12_slv2_hwrite),
	.mst12_req      (mst12_slv2_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv2_hwdata ),
	.mst13_ack      (mst13_slv2_ack   ),
	.mst13_haddr    (mst13_slv2_haddr ),
	.mst13_hburst   (mst13_slv2_hburst),
	.mst13_hprot    (mst13_slv2_hprot ),
	.mst13_hsize    (mst13_slv2_hsize ),
	.mst13_htrans   (mst13_slv2_htrans),
	.mst13_hwrite   (mst13_slv2_hwrite),
	.mst13_req      (mst13_slv2_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv2_hwdata ),
	.mst14_ack      (mst14_slv2_ack   ),
	.mst14_haddr    (mst14_slv2_haddr ),
	.mst14_hburst   (mst14_slv2_hburst),
	.mst14_hprot    (mst14_slv2_hprot ),
	.mst14_hsize    (mst14_slv2_hsize ),
	.mst14_htrans   (mst14_slv2_htrans),
	.mst14_hwrite   (mst14_slv2_hwrite),
	.mst14_req      (mst14_slv2_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv2_hwdata ),
	.mst15_ack      (mst15_slv2_ack   ),
	.mst15_haddr    (mst15_slv2_haddr ),
	.mst15_hburst   (mst15_slv2_hburst),
	.mst15_hprot    (mst15_slv2_hprot ),
	.mst15_hsize    (mst15_slv2_hsize ),
	.mst15_htrans   (mst15_slv2_htrans),
	.mst15_hwrite   (mst15_slv2_hwrite),
	.mst15_req      (mst15_slv2_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs2_hready   ),
	.hclk           (hclk             ),
	.hresetn        (hresetn          ),
	.hs_bmc_hready  (hs2_bmc_hready   ),
	.hs_haddr       (hs2_haddr        ),
	.hs_hburst      (hs2_hburst       ),
	.hs_hprot       (hs2_hprot        ),
	.hs_hresp       (hs2_hresp        ),
	.hs_hsel        (hs2_hsel         ),
	.hs_hsize       (hs2_hsize        ),
	.hs_htrans      (hs2_htrans       ),
	.hs_hwdata      (hs2_hwdata       ),
	.hs_hwrite      (hs2_hwrite       ),
	.init_priority  (init_priority    ),
	.mst0_highest_en(mst0_highest_en  )
);

`endif
`ifdef ATCBMC200_AHB_SLV3
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander3 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv3_hwdata  ),
	.mst0_ack       (mst0_slv3_ack    ),
	.mst0_haddr     (mst0_slv3_haddr  ),
	.mst0_hburst    (mst0_slv3_hburst ),
	.mst0_hprot     (mst0_slv3_hprot  ),
	.mst0_hsize     (mst0_slv3_hsize  ),
	.mst0_htrans    (mst0_slv3_htrans ),
	.mst0_hwrite    (mst0_slv3_hwrite ),
	.mst0_req       (mst0_slv3_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv3_hwdata  ),
	.mst1_ack       (mst1_slv3_ack    ),
	.mst1_haddr     (mst1_slv3_haddr  ),
	.mst1_hburst    (mst1_slv3_hburst ),
	.mst1_hprot     (mst1_slv3_hprot  ),
	.mst1_hsize     (mst1_slv3_hsize  ),
	.mst1_htrans    (mst1_slv3_htrans ),
	.mst1_hwrite    (mst1_slv3_hwrite ),
	.mst1_req       (mst1_slv3_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv3_hwdata  ),
	.mst2_ack       (mst2_slv3_ack    ),
	.mst2_haddr     (mst2_slv3_haddr  ),
	.mst2_hburst    (mst2_slv3_hburst ),
	.mst2_hprot     (mst2_slv3_hprot  ),
	.mst2_hsize     (mst2_slv3_hsize  ),
	.mst2_htrans    (mst2_slv3_htrans ),
	.mst2_hwrite    (mst2_slv3_hwrite ),
	.mst2_req       (mst2_slv3_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv3_hwdata  ),
	.mst3_ack       (mst3_slv3_ack    ),
	.mst3_haddr     (mst3_slv3_haddr  ),
	.mst3_hburst    (mst3_slv3_hburst ),
	.mst3_hprot     (mst3_slv3_hprot  ),
	.mst3_hsize     (mst3_slv3_hsize  ),
	.mst3_htrans    (mst3_slv3_htrans ),
	.mst3_hwrite    (mst3_slv3_hwrite ),
	.mst3_req       (mst3_slv3_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv3_hwdata  ),
	.mst4_ack       (mst4_slv3_ack    ),
	.mst4_haddr     (mst4_slv3_haddr  ),
	.mst4_hburst    (mst4_slv3_hburst ),
	.mst4_hprot     (mst4_slv3_hprot  ),
	.mst4_hsize     (mst4_slv3_hsize  ),
	.mst4_htrans    (mst4_slv3_htrans ),
	.mst4_hwrite    (mst4_slv3_hwrite ),
	.mst4_req       (mst4_slv3_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv3_hwdata  ),
	.mst5_ack       (mst5_slv3_ack    ),
	.mst5_haddr     (mst5_slv3_haddr  ),
	.mst5_hburst    (mst5_slv3_hburst ),
	.mst5_hprot     (mst5_slv3_hprot  ),
	.mst5_hsize     (mst5_slv3_hsize  ),
	.mst5_htrans    (mst5_slv3_htrans ),
	.mst5_hwrite    (mst5_slv3_hwrite ),
	.mst5_req       (mst5_slv3_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv3_hwdata  ),
	.mst6_ack       (mst6_slv3_ack    ),
	.mst6_haddr     (mst6_slv3_haddr  ),
	.mst6_hburst    (mst6_slv3_hburst ),
	.mst6_hprot     (mst6_slv3_hprot  ),
	.mst6_hsize     (mst6_slv3_hsize  ),
	.mst6_htrans    (mst6_slv3_htrans ),
	.mst6_hwrite    (mst6_slv3_hwrite ),
	.mst6_req       (mst6_slv3_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv3_hwdata  ),
	.mst7_ack       (mst7_slv3_ack    ),
	.mst7_haddr     (mst7_slv3_haddr  ),
	.mst7_hburst    (mst7_slv3_hburst ),
	.mst7_hprot     (mst7_slv3_hprot  ),
	.mst7_hsize     (mst7_slv3_hsize  ),
	.mst7_htrans    (mst7_slv3_htrans ),
	.mst7_hwrite    (mst7_slv3_hwrite ),
	.mst7_req       (mst7_slv3_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv3_hwdata  ),
	.mst8_ack       (mst8_slv3_ack    ),
	.mst8_haddr     (mst8_slv3_haddr  ),
	.mst8_hburst    (mst8_slv3_hburst ),
	.mst8_hprot     (mst8_slv3_hprot  ),
	.mst8_hsize     (mst8_slv3_hsize  ),
	.mst8_htrans    (mst8_slv3_htrans ),
	.mst8_hwrite    (mst8_slv3_hwrite ),
	.mst8_req       (mst8_slv3_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv3_hwdata  ),
	.mst9_ack       (mst9_slv3_ack    ),
	.mst9_haddr     (mst9_slv3_haddr  ),
	.mst9_hburst    (mst9_slv3_hburst ),
	.mst9_hprot     (mst9_slv3_hprot  ),
	.mst9_hsize     (mst9_slv3_hsize  ),
	.mst9_htrans    (mst9_slv3_htrans ),
	.mst9_hwrite    (mst9_slv3_hwrite ),
	.mst9_req       (mst9_slv3_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv3_hwdata ),
	.mst10_ack      (mst10_slv3_ack   ),
	.mst10_haddr    (mst10_slv3_haddr ),
	.mst10_hburst   (mst10_slv3_hburst),
	.mst10_hprot    (mst10_slv3_hprot ),
	.mst10_hsize    (mst10_slv3_hsize ),
	.mst10_htrans   (mst10_slv3_htrans),
	.mst10_hwrite   (mst10_slv3_hwrite),
	.mst10_req      (mst10_slv3_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv3_hwdata ),
	.mst11_ack      (mst11_slv3_ack   ),
	.mst11_haddr    (mst11_slv3_haddr ),
	.mst11_hburst   (mst11_slv3_hburst),
	.mst11_hprot    (mst11_slv3_hprot ),
	.mst11_hsize    (mst11_slv3_hsize ),
	.mst11_htrans   (mst11_slv3_htrans),
	.mst11_hwrite   (mst11_slv3_hwrite),
	.mst11_req      (mst11_slv3_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv3_hwdata ),
	.mst12_ack      (mst12_slv3_ack   ),
	.mst12_haddr    (mst12_slv3_haddr ),
	.mst12_hburst   (mst12_slv3_hburst),
	.mst12_hprot    (mst12_slv3_hprot ),
	.mst12_hsize    (mst12_slv3_hsize ),
	.mst12_htrans   (mst12_slv3_htrans),
	.mst12_hwrite   (mst12_slv3_hwrite),
	.mst12_req      (mst12_slv3_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv3_hwdata ),
	.mst13_ack      (mst13_slv3_ack   ),
	.mst13_haddr    (mst13_slv3_haddr ),
	.mst13_hburst   (mst13_slv3_hburst),
	.mst13_hprot    (mst13_slv3_hprot ),
	.mst13_hsize    (mst13_slv3_hsize ),
	.mst13_htrans   (mst13_slv3_htrans),
	.mst13_hwrite   (mst13_slv3_hwrite),
	.mst13_req      (mst13_slv3_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv3_hwdata ),
	.mst14_ack      (mst14_slv3_ack   ),
	.mst14_haddr    (mst14_slv3_haddr ),
	.mst14_hburst   (mst14_slv3_hburst),
	.mst14_hprot    (mst14_slv3_hprot ),
	.mst14_hsize    (mst14_slv3_hsize ),
	.mst14_htrans   (mst14_slv3_htrans),
	.mst14_hwrite   (mst14_slv3_hwrite),
	.mst14_req      (mst14_slv3_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv3_hwdata ),
	.mst15_ack      (mst15_slv3_ack   ),
	.mst15_haddr    (mst15_slv3_haddr ),
	.mst15_hburst   (mst15_slv3_hburst),
	.mst15_hprot    (mst15_slv3_hprot ),
	.mst15_hsize    (mst15_slv3_hsize ),
	.mst15_htrans   (mst15_slv3_htrans),
	.mst15_hwrite   (mst15_slv3_hwrite),
	.mst15_req      (mst15_slv3_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs3_hready   ),
	.hclk           (hclk             ),
	.hresetn        (hresetn          ),
	.hs_bmc_hready  (hs3_bmc_hready   ),
	.hs_haddr       (hs3_haddr        ),
	.hs_hburst      (hs3_hburst       ),
	.hs_hprot       (hs3_hprot        ),
	.hs_hresp       (hs3_hresp        ),
	.hs_hsel        (hs3_hsel         ),
	.hs_hsize       (hs3_hsize        ),
	.hs_htrans      (hs3_htrans       ),
	.hs_hwdata      (hs3_hwdata       ),
	.hs_hwrite      (hs3_hwrite       ),
	.init_priority  (init_priority    ),
	.mst0_highest_en(mst0_highest_en  )
);

`endif
`ifdef ATCBMC200_AHB_SLV4
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander4 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv4_hwdata  ),
	.mst0_ack       (mst0_slv4_ack    ),
	.mst0_haddr     (mst0_slv4_haddr  ),
	.mst0_hburst    (mst0_slv4_hburst ),
	.mst0_hprot     (mst0_slv4_hprot  ),
	.mst0_hsize     (mst0_slv4_hsize  ),
	.mst0_htrans    (mst0_slv4_htrans ),
	.mst0_hwrite    (mst0_slv4_hwrite ),
	.mst0_req       (mst0_slv4_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv4_hwdata  ),
	.mst1_ack       (mst1_slv4_ack    ),
	.mst1_haddr     (mst1_slv4_haddr  ),
	.mst1_hburst    (mst1_slv4_hburst ),
	.mst1_hprot     (mst1_slv4_hprot  ),
	.mst1_hsize     (mst1_slv4_hsize  ),
	.mst1_htrans    (mst1_slv4_htrans ),
	.mst1_hwrite    (mst1_slv4_hwrite ),
	.mst1_req       (mst1_slv4_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv4_hwdata  ),
	.mst2_ack       (mst2_slv4_ack    ),
	.mst2_haddr     (mst2_slv4_haddr  ),
	.mst2_hburst    (mst2_slv4_hburst ),
	.mst2_hprot     (mst2_slv4_hprot  ),
	.mst2_hsize     (mst2_slv4_hsize  ),
	.mst2_htrans    (mst2_slv4_htrans ),
	.mst2_hwrite    (mst2_slv4_hwrite ),
	.mst2_req       (mst2_slv4_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv4_hwdata  ),
	.mst3_ack       (mst3_slv4_ack    ),
	.mst3_haddr     (mst3_slv4_haddr  ),
	.mst3_hburst    (mst3_slv4_hburst ),
	.mst3_hprot     (mst3_slv4_hprot  ),
	.mst3_hsize     (mst3_slv4_hsize  ),
	.mst3_htrans    (mst3_slv4_htrans ),
	.mst3_hwrite    (mst3_slv4_hwrite ),
	.mst3_req       (mst3_slv4_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv4_hwdata  ),
	.mst4_ack       (mst4_slv4_ack    ),
	.mst4_haddr     (mst4_slv4_haddr  ),
	.mst4_hburst    (mst4_slv4_hburst ),
	.mst4_hprot     (mst4_slv4_hprot  ),
	.mst4_hsize     (mst4_slv4_hsize  ),
	.mst4_htrans    (mst4_slv4_htrans ),
	.mst4_hwrite    (mst4_slv4_hwrite ),
	.mst4_req       (mst4_slv4_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv4_hwdata  ),
	.mst5_ack       (mst5_slv4_ack    ),
	.mst5_haddr     (mst5_slv4_haddr  ),
	.mst5_hburst    (mst5_slv4_hburst ),
	.mst5_hprot     (mst5_slv4_hprot  ),
	.mst5_hsize     (mst5_slv4_hsize  ),
	.mst5_htrans    (mst5_slv4_htrans ),
	.mst5_hwrite    (mst5_slv4_hwrite ),
	.mst5_req       (mst5_slv4_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv4_hwdata  ),
	.mst6_ack       (mst6_slv4_ack    ),
	.mst6_haddr     (mst6_slv4_haddr  ),
	.mst6_hburst    (mst6_slv4_hburst ),
	.mst6_hprot     (mst6_slv4_hprot  ),
	.mst6_hsize     (mst6_slv4_hsize  ),
	.mst6_htrans    (mst6_slv4_htrans ),
	.mst6_hwrite    (mst6_slv4_hwrite ),
	.mst6_req       (mst6_slv4_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv4_hwdata  ),
	.mst7_ack       (mst7_slv4_ack    ),
	.mst7_haddr     (mst7_slv4_haddr  ),
	.mst7_hburst    (mst7_slv4_hburst ),
	.mst7_hprot     (mst7_slv4_hprot  ),
	.mst7_hsize     (mst7_slv4_hsize  ),
	.mst7_htrans    (mst7_slv4_htrans ),
	.mst7_hwrite    (mst7_slv4_hwrite ),
	.mst7_req       (mst7_slv4_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv4_hwdata  ),
	.mst8_ack       (mst8_slv4_ack    ),
	.mst8_haddr     (mst8_slv4_haddr  ),
	.mst8_hburst    (mst8_slv4_hburst ),
	.mst8_hprot     (mst8_slv4_hprot  ),
	.mst8_hsize     (mst8_slv4_hsize  ),
	.mst8_htrans    (mst8_slv4_htrans ),
	.mst8_hwrite    (mst8_slv4_hwrite ),
	.mst8_req       (mst8_slv4_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv4_hwdata  ),
	.mst9_ack       (mst9_slv4_ack    ),
	.mst9_haddr     (mst9_slv4_haddr  ),
	.mst9_hburst    (mst9_slv4_hburst ),
	.mst9_hprot     (mst9_slv4_hprot  ),
	.mst9_hsize     (mst9_slv4_hsize  ),
	.mst9_htrans    (mst9_slv4_htrans ),
	.mst9_hwrite    (mst9_slv4_hwrite ),
	.mst9_req       (mst9_slv4_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv4_hwdata ),
	.mst10_ack      (mst10_slv4_ack   ),
	.mst10_haddr    (mst10_slv4_haddr ),
	.mst10_hburst   (mst10_slv4_hburst),
	.mst10_hprot    (mst10_slv4_hprot ),
	.mst10_hsize    (mst10_slv4_hsize ),
	.mst10_htrans   (mst10_slv4_htrans),
	.mst10_hwrite   (mst10_slv4_hwrite),
	.mst10_req      (mst10_slv4_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv4_hwdata ),
	.mst11_ack      (mst11_slv4_ack   ),
	.mst11_haddr    (mst11_slv4_haddr ),
	.mst11_hburst   (mst11_slv4_hburst),
	.mst11_hprot    (mst11_slv4_hprot ),
	.mst11_hsize    (mst11_slv4_hsize ),
	.mst11_htrans   (mst11_slv4_htrans),
	.mst11_hwrite   (mst11_slv4_hwrite),
	.mst11_req      (mst11_slv4_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv4_hwdata ),
	.mst12_ack      (mst12_slv4_ack   ),
	.mst12_haddr    (mst12_slv4_haddr ),
	.mst12_hburst   (mst12_slv4_hburst),
	.mst12_hprot    (mst12_slv4_hprot ),
	.mst12_hsize    (mst12_slv4_hsize ),
	.mst12_htrans   (mst12_slv4_htrans),
	.mst12_hwrite   (mst12_slv4_hwrite),
	.mst12_req      (mst12_slv4_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv4_hwdata ),
	.mst13_ack      (mst13_slv4_ack   ),
	.mst13_haddr    (mst13_slv4_haddr ),
	.mst13_hburst   (mst13_slv4_hburst),
	.mst13_hprot    (mst13_slv4_hprot ),
	.mst13_hsize    (mst13_slv4_hsize ),
	.mst13_htrans   (mst13_slv4_htrans),
	.mst13_hwrite   (mst13_slv4_hwrite),
	.mst13_req      (mst13_slv4_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv4_hwdata ),
	.mst14_ack      (mst14_slv4_ack   ),
	.mst14_haddr    (mst14_slv4_haddr ),
	.mst14_hburst   (mst14_slv4_hburst),
	.mst14_hprot    (mst14_slv4_hprot ),
	.mst14_hsize    (mst14_slv4_hsize ),
	.mst14_htrans   (mst14_slv4_htrans),
	.mst14_hwrite   (mst14_slv4_hwrite),
	.mst14_req      (mst14_slv4_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv4_hwdata ),
	.mst15_ack      (mst15_slv4_ack   ),
	.mst15_haddr    (mst15_slv4_haddr ),
	.mst15_hburst   (mst15_slv4_hburst),
	.mst15_hprot    (mst15_slv4_hprot ),
	.mst15_hsize    (mst15_slv4_hsize ),
	.mst15_htrans   (mst15_slv4_htrans),
	.mst15_hwrite   (mst15_slv4_hwrite),
	.mst15_req      (mst15_slv4_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs4_hready   ),
	.hclk           (hclk             ),
	.hresetn        (hresetn          ),
	.hs_bmc_hready  (hs4_bmc_hready   ),
	.hs_haddr       (hs4_haddr        ),
	.hs_hburst      (hs4_hburst       ),
	.hs_hprot       (hs4_hprot        ),
	.hs_hresp       (hs4_hresp        ),
	.hs_hsel        (hs4_hsel         ),
	.hs_hsize       (hs4_hsize        ),
	.hs_htrans      (hs4_htrans       ),
	.hs_hwdata      (hs4_hwdata       ),
	.hs_hwrite      (hs4_hwrite       ),
	.init_priority  (init_priority    ),
	.mst0_highest_en(mst0_highest_en  )
);

`endif
`ifdef ATCBMC200_AHB_SLV5
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander5 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv5_hwdata  ),
	.mst0_ack       (mst0_slv5_ack    ),
	.mst0_haddr     (mst0_slv5_haddr  ),
	.mst0_hburst    (mst0_slv5_hburst ),
	.mst0_hprot     (mst0_slv5_hprot  ),
	.mst0_hsize     (mst0_slv5_hsize  ),
	.mst0_htrans    (mst0_slv5_htrans ),
	.mst0_hwrite    (mst0_slv5_hwrite ),
	.mst0_req       (mst0_slv5_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv5_hwdata  ),
	.mst1_ack       (mst1_slv5_ack    ),
	.mst1_haddr     (mst1_slv5_haddr  ),
	.mst1_hburst    (mst1_slv5_hburst ),
	.mst1_hprot     (mst1_slv5_hprot  ),
	.mst1_hsize     (mst1_slv5_hsize  ),
	.mst1_htrans    (mst1_slv5_htrans ),
	.mst1_hwrite    (mst1_slv5_hwrite ),
	.mst1_req       (mst1_slv5_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv5_hwdata  ),
	.mst2_ack       (mst2_slv5_ack    ),
	.mst2_haddr     (mst2_slv5_haddr  ),
	.mst2_hburst    (mst2_slv5_hburst ),
	.mst2_hprot     (mst2_slv5_hprot  ),
	.mst2_hsize     (mst2_slv5_hsize  ),
	.mst2_htrans    (mst2_slv5_htrans ),
	.mst2_hwrite    (mst2_slv5_hwrite ),
	.mst2_req       (mst2_slv5_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv5_hwdata  ),
	.mst3_ack       (mst3_slv5_ack    ),
	.mst3_haddr     (mst3_slv5_haddr  ),
	.mst3_hburst    (mst3_slv5_hburst ),
	.mst3_hprot     (mst3_slv5_hprot  ),
	.mst3_hsize     (mst3_slv5_hsize  ),
	.mst3_htrans    (mst3_slv5_htrans ),
	.mst3_hwrite    (mst3_slv5_hwrite ),
	.mst3_req       (mst3_slv5_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv5_hwdata  ),
	.mst4_ack       (mst4_slv5_ack    ),
	.mst4_haddr     (mst4_slv5_haddr  ),
	.mst4_hburst    (mst4_slv5_hburst ),
	.mst4_hprot     (mst4_slv5_hprot  ),
	.mst4_hsize     (mst4_slv5_hsize  ),
	.mst4_htrans    (mst4_slv5_htrans ),
	.mst4_hwrite    (mst4_slv5_hwrite ),
	.mst4_req       (mst4_slv5_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv5_hwdata  ),
	.mst5_ack       (mst5_slv5_ack    ),
	.mst5_haddr     (mst5_slv5_haddr  ),
	.mst5_hburst    (mst5_slv5_hburst ),
	.mst5_hprot     (mst5_slv5_hprot  ),
	.mst5_hsize     (mst5_slv5_hsize  ),
	.mst5_htrans    (mst5_slv5_htrans ),
	.mst5_hwrite    (mst5_slv5_hwrite ),
	.mst5_req       (mst5_slv5_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv5_hwdata  ),
	.mst6_ack       (mst6_slv5_ack    ),
	.mst6_haddr     (mst6_slv5_haddr  ),
	.mst6_hburst    (mst6_slv5_hburst ),
	.mst6_hprot     (mst6_slv5_hprot  ),
	.mst6_hsize     (mst6_slv5_hsize  ),
	.mst6_htrans    (mst6_slv5_htrans ),
	.mst6_hwrite    (mst6_slv5_hwrite ),
	.mst6_req       (mst6_slv5_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv5_hwdata  ),
	.mst7_ack       (mst7_slv5_ack    ),
	.mst7_haddr     (mst7_slv5_haddr  ),
	.mst7_hburst    (mst7_slv5_hburst ),
	.mst7_hprot     (mst7_slv5_hprot  ),
	.mst7_hsize     (mst7_slv5_hsize  ),
	.mst7_htrans    (mst7_slv5_htrans ),
	.mst7_hwrite    (mst7_slv5_hwrite ),
	.mst7_req       (mst7_slv5_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv5_hwdata  ),
	.mst8_ack       (mst8_slv5_ack    ),
	.mst8_haddr     (mst8_slv5_haddr  ),
	.mst8_hburst    (mst8_slv5_hburst ),
	.mst8_hprot     (mst8_slv5_hprot  ),
	.mst8_hsize     (mst8_slv5_hsize  ),
	.mst8_htrans    (mst8_slv5_htrans ),
	.mst8_hwrite    (mst8_slv5_hwrite ),
	.mst8_req       (mst8_slv5_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv5_hwdata  ),
	.mst9_ack       (mst9_slv5_ack    ),
	.mst9_haddr     (mst9_slv5_haddr  ),
	.mst9_hburst    (mst9_slv5_hburst ),
	.mst9_hprot     (mst9_slv5_hprot  ),
	.mst9_hsize     (mst9_slv5_hsize  ),
	.mst9_htrans    (mst9_slv5_htrans ),
	.mst9_hwrite    (mst9_slv5_hwrite ),
	.mst9_req       (mst9_slv5_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv5_hwdata ),
	.mst10_ack      (mst10_slv5_ack   ),
	.mst10_haddr    (mst10_slv5_haddr ),
	.mst10_hburst   (mst10_slv5_hburst),
	.mst10_hprot    (mst10_slv5_hprot ),
	.mst10_hsize    (mst10_slv5_hsize ),
	.mst10_htrans   (mst10_slv5_htrans),
	.mst10_hwrite   (mst10_slv5_hwrite),
	.mst10_req      (mst10_slv5_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv5_hwdata ),
	.mst11_ack      (mst11_slv5_ack   ),
	.mst11_haddr    (mst11_slv5_haddr ),
	.mst11_hburst   (mst11_slv5_hburst),
	.mst11_hprot    (mst11_slv5_hprot ),
	.mst11_hsize    (mst11_slv5_hsize ),
	.mst11_htrans   (mst11_slv5_htrans),
	.mst11_hwrite   (mst11_slv5_hwrite),
	.mst11_req      (mst11_slv5_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv5_hwdata ),
	.mst12_ack      (mst12_slv5_ack   ),
	.mst12_haddr    (mst12_slv5_haddr ),
	.mst12_hburst   (mst12_slv5_hburst),
	.mst12_hprot    (mst12_slv5_hprot ),
	.mst12_hsize    (mst12_slv5_hsize ),
	.mst12_htrans   (mst12_slv5_htrans),
	.mst12_hwrite   (mst12_slv5_hwrite),
	.mst12_req      (mst12_slv5_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv5_hwdata ),
	.mst13_ack      (mst13_slv5_ack   ),
	.mst13_haddr    (mst13_slv5_haddr ),
	.mst13_hburst   (mst13_slv5_hburst),
	.mst13_hprot    (mst13_slv5_hprot ),
	.mst13_hsize    (mst13_slv5_hsize ),
	.mst13_htrans   (mst13_slv5_htrans),
	.mst13_hwrite   (mst13_slv5_hwrite),
	.mst13_req      (mst13_slv5_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv5_hwdata ),
	.mst14_ack      (mst14_slv5_ack   ),
	.mst14_haddr    (mst14_slv5_haddr ),
	.mst14_hburst   (mst14_slv5_hburst),
	.mst14_hprot    (mst14_slv5_hprot ),
	.mst14_hsize    (mst14_slv5_hsize ),
	.mst14_htrans   (mst14_slv5_htrans),
	.mst14_hwrite   (mst14_slv5_hwrite),
	.mst14_req      (mst14_slv5_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv5_hwdata ),
	.mst15_ack      (mst15_slv5_ack   ),
	.mst15_haddr    (mst15_slv5_haddr ),
	.mst15_hburst   (mst15_slv5_hburst),
	.mst15_hprot    (mst15_slv5_hprot ),
	.mst15_hsize    (mst15_slv5_hsize ),
	.mst15_htrans   (mst15_slv5_htrans),
	.mst15_hwrite   (mst15_slv5_hwrite),
	.mst15_req      (mst15_slv5_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs5_hready   ),
	.hclk           (hclk             ),
	.hresetn        (hresetn          ),
	.hs_bmc_hready  (hs5_bmc_hready   ),
	.hs_haddr       (hs5_haddr        ),
	.hs_hburst      (hs5_hburst       ),
	.hs_hprot       (hs5_hprot        ),
	.hs_hresp       (hs5_hresp        ),
	.hs_hsel        (hs5_hsel         ),
	.hs_hsize       (hs5_hsize        ),
	.hs_htrans      (hs5_htrans       ),
	.hs_hwdata      (hs5_hwdata       ),
	.hs_hwrite      (hs5_hwrite       ),
	.init_priority  (init_priority    ),
	.mst0_highest_en(mst0_highest_en  )
);

`endif
`ifdef ATCBMC200_AHB_SLV6
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander6 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv6_hwdata  ),
	.mst0_ack       (mst0_slv6_ack    ),
	.mst0_haddr     (mst0_slv6_haddr  ),
	.mst0_hburst    (mst0_slv6_hburst ),
	.mst0_hprot     (mst0_slv6_hprot  ),
	.mst0_hsize     (mst0_slv6_hsize  ),
	.mst0_htrans    (mst0_slv6_htrans ),
	.mst0_hwrite    (mst0_slv6_hwrite ),
	.mst0_req       (mst0_slv6_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv6_hwdata  ),
	.mst1_ack       (mst1_slv6_ack    ),
	.mst1_haddr     (mst1_slv6_haddr  ),
	.mst1_hburst    (mst1_slv6_hburst ),
	.mst1_hprot     (mst1_slv6_hprot  ),
	.mst1_hsize     (mst1_slv6_hsize  ),
	.mst1_htrans    (mst1_slv6_htrans ),
	.mst1_hwrite    (mst1_slv6_hwrite ),
	.mst1_req       (mst1_slv6_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv6_hwdata  ),
	.mst2_ack       (mst2_slv6_ack    ),
	.mst2_haddr     (mst2_slv6_haddr  ),
	.mst2_hburst    (mst2_slv6_hburst ),
	.mst2_hprot     (mst2_slv6_hprot  ),
	.mst2_hsize     (mst2_slv6_hsize  ),
	.mst2_htrans    (mst2_slv6_htrans ),
	.mst2_hwrite    (mst2_slv6_hwrite ),
	.mst2_req       (mst2_slv6_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv6_hwdata  ),
	.mst3_ack       (mst3_slv6_ack    ),
	.mst3_haddr     (mst3_slv6_haddr  ),
	.mst3_hburst    (mst3_slv6_hburst ),
	.mst3_hprot     (mst3_slv6_hprot  ),
	.mst3_hsize     (mst3_slv6_hsize  ),
	.mst3_htrans    (mst3_slv6_htrans ),
	.mst3_hwrite    (mst3_slv6_hwrite ),
	.mst3_req       (mst3_slv6_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv6_hwdata  ),
	.mst4_ack       (mst4_slv6_ack    ),
	.mst4_haddr     (mst4_slv6_haddr  ),
	.mst4_hburst    (mst4_slv6_hburst ),
	.mst4_hprot     (mst4_slv6_hprot  ),
	.mst4_hsize     (mst4_slv6_hsize  ),
	.mst4_htrans    (mst4_slv6_htrans ),
	.mst4_hwrite    (mst4_slv6_hwrite ),
	.mst4_req       (mst4_slv6_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv6_hwdata  ),
	.mst5_ack       (mst5_slv6_ack    ),
	.mst5_haddr     (mst5_slv6_haddr  ),
	.mst5_hburst    (mst5_slv6_hburst ),
	.mst5_hprot     (mst5_slv6_hprot  ),
	.mst5_hsize     (mst5_slv6_hsize  ),
	.mst5_htrans    (mst5_slv6_htrans ),
	.mst5_hwrite    (mst5_slv6_hwrite ),
	.mst5_req       (mst5_slv6_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv6_hwdata  ),
	.mst6_ack       (mst6_slv6_ack    ),
	.mst6_haddr     (mst6_slv6_haddr  ),
	.mst6_hburst    (mst6_slv6_hburst ),
	.mst6_hprot     (mst6_slv6_hprot  ),
	.mst6_hsize     (mst6_slv6_hsize  ),
	.mst6_htrans    (mst6_slv6_htrans ),
	.mst6_hwrite    (mst6_slv6_hwrite ),
	.mst6_req       (mst6_slv6_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv6_hwdata  ),
	.mst7_ack       (mst7_slv6_ack    ),
	.mst7_haddr     (mst7_slv6_haddr  ),
	.mst7_hburst    (mst7_slv6_hburst ),
	.mst7_hprot     (mst7_slv6_hprot  ),
	.mst7_hsize     (mst7_slv6_hsize  ),
	.mst7_htrans    (mst7_slv6_htrans ),
	.mst7_hwrite    (mst7_slv6_hwrite ),
	.mst7_req       (mst7_slv6_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv6_hwdata  ),
	.mst8_ack       (mst8_slv6_ack    ),
	.mst8_haddr     (mst8_slv6_haddr  ),
	.mst8_hburst    (mst8_slv6_hburst ),
	.mst8_hprot     (mst8_slv6_hprot  ),
	.mst8_hsize     (mst8_slv6_hsize  ),
	.mst8_htrans    (mst8_slv6_htrans ),
	.mst8_hwrite    (mst8_slv6_hwrite ),
	.mst8_req       (mst8_slv6_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv6_hwdata  ),
	.mst9_ack       (mst9_slv6_ack    ),
	.mst9_haddr     (mst9_slv6_haddr  ),
	.mst9_hburst    (mst9_slv6_hburst ),
	.mst9_hprot     (mst9_slv6_hprot  ),
	.mst9_hsize     (mst9_slv6_hsize  ),
	.mst9_htrans    (mst9_slv6_htrans ),
	.mst9_hwrite    (mst9_slv6_hwrite ),
	.mst9_req       (mst9_slv6_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv6_hwdata ),
	.mst10_ack      (mst10_slv6_ack   ),
	.mst10_haddr    (mst10_slv6_haddr ),
	.mst10_hburst   (mst10_slv6_hburst),
	.mst10_hprot    (mst10_slv6_hprot ),
	.mst10_hsize    (mst10_slv6_hsize ),
	.mst10_htrans   (mst10_slv6_htrans),
	.mst10_hwrite   (mst10_slv6_hwrite),
	.mst10_req      (mst10_slv6_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv6_hwdata ),
	.mst11_ack      (mst11_slv6_ack   ),
	.mst11_haddr    (mst11_slv6_haddr ),
	.mst11_hburst   (mst11_slv6_hburst),
	.mst11_hprot    (mst11_slv6_hprot ),
	.mst11_hsize    (mst11_slv6_hsize ),
	.mst11_htrans   (mst11_slv6_htrans),
	.mst11_hwrite   (mst11_slv6_hwrite),
	.mst11_req      (mst11_slv6_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv6_hwdata ),
	.mst12_ack      (mst12_slv6_ack   ),
	.mst12_haddr    (mst12_slv6_haddr ),
	.mst12_hburst   (mst12_slv6_hburst),
	.mst12_hprot    (mst12_slv6_hprot ),
	.mst12_hsize    (mst12_slv6_hsize ),
	.mst12_htrans   (mst12_slv6_htrans),
	.mst12_hwrite   (mst12_slv6_hwrite),
	.mst12_req      (mst12_slv6_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv6_hwdata ),
	.mst13_ack      (mst13_slv6_ack   ),
	.mst13_haddr    (mst13_slv6_haddr ),
	.mst13_hburst   (mst13_slv6_hburst),
	.mst13_hprot    (mst13_slv6_hprot ),
	.mst13_hsize    (mst13_slv6_hsize ),
	.mst13_htrans   (mst13_slv6_htrans),
	.mst13_hwrite   (mst13_slv6_hwrite),
	.mst13_req      (mst13_slv6_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv6_hwdata ),
	.mst14_ack      (mst14_slv6_ack   ),
	.mst14_haddr    (mst14_slv6_haddr ),
	.mst14_hburst   (mst14_slv6_hburst),
	.mst14_hprot    (mst14_slv6_hprot ),
	.mst14_hsize    (mst14_slv6_hsize ),
	.mst14_htrans   (mst14_slv6_htrans),
	.mst14_hwrite   (mst14_slv6_hwrite),
	.mst14_req      (mst14_slv6_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv6_hwdata ),
	.mst15_ack      (mst15_slv6_ack   ),
	.mst15_haddr    (mst15_slv6_haddr ),
	.mst15_hburst   (mst15_slv6_hburst),
	.mst15_hprot    (mst15_slv6_hprot ),
	.mst15_hsize    (mst15_slv6_hsize ),
	.mst15_htrans   (mst15_slv6_htrans),
	.mst15_hwrite   (mst15_slv6_hwrite),
	.mst15_req      (mst15_slv6_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs6_hready   ),
	.hclk           (hclk             ),
	.hresetn        (hresetn          ),
	.hs_bmc_hready  (hs6_bmc_hready   ),
	.hs_haddr       (hs6_haddr        ),
	.hs_hburst      (hs6_hburst       ),
	.hs_hprot       (hs6_hprot        ),
	.hs_hresp       (hs6_hresp        ),
	.hs_hsel        (hs6_hsel         ),
	.hs_hsize       (hs6_hsize        ),
	.hs_htrans      (hs6_htrans       ),
	.hs_hwdata      (hs6_hwdata       ),
	.hs_hwrite      (hs6_hwrite       ),
	.init_priority  (init_priority    ),
	.mst0_highest_en(mst0_highest_en  )
);

`endif
`ifdef ATCBMC200_AHB_SLV7
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander7 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv7_hwdata  ),
	.mst0_ack       (mst0_slv7_ack    ),
	.mst0_haddr     (mst0_slv7_haddr  ),
	.mst0_hburst    (mst0_slv7_hburst ),
	.mst0_hprot     (mst0_slv7_hprot  ),
	.mst0_hsize     (mst0_slv7_hsize  ),
	.mst0_htrans    (mst0_slv7_htrans ),
	.mst0_hwrite    (mst0_slv7_hwrite ),
	.mst0_req       (mst0_slv7_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv7_hwdata  ),
	.mst1_ack       (mst1_slv7_ack    ),
	.mst1_haddr     (mst1_slv7_haddr  ),
	.mst1_hburst    (mst1_slv7_hburst ),
	.mst1_hprot     (mst1_slv7_hprot  ),
	.mst1_hsize     (mst1_slv7_hsize  ),
	.mst1_htrans    (mst1_slv7_htrans ),
	.mst1_hwrite    (mst1_slv7_hwrite ),
	.mst1_req       (mst1_slv7_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv7_hwdata  ),
	.mst2_ack       (mst2_slv7_ack    ),
	.mst2_haddr     (mst2_slv7_haddr  ),
	.mst2_hburst    (mst2_slv7_hburst ),
	.mst2_hprot     (mst2_slv7_hprot  ),
	.mst2_hsize     (mst2_slv7_hsize  ),
	.mst2_htrans    (mst2_slv7_htrans ),
	.mst2_hwrite    (mst2_slv7_hwrite ),
	.mst2_req       (mst2_slv7_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv7_hwdata  ),
	.mst3_ack       (mst3_slv7_ack    ),
	.mst3_haddr     (mst3_slv7_haddr  ),
	.mst3_hburst    (mst3_slv7_hburst ),
	.mst3_hprot     (mst3_slv7_hprot  ),
	.mst3_hsize     (mst3_slv7_hsize  ),
	.mst3_htrans    (mst3_slv7_htrans ),
	.mst3_hwrite    (mst3_slv7_hwrite ),
	.mst3_req       (mst3_slv7_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv7_hwdata  ),
	.mst4_ack       (mst4_slv7_ack    ),
	.mst4_haddr     (mst4_slv7_haddr  ),
	.mst4_hburst    (mst4_slv7_hburst ),
	.mst4_hprot     (mst4_slv7_hprot  ),
	.mst4_hsize     (mst4_slv7_hsize  ),
	.mst4_htrans    (mst4_slv7_htrans ),
	.mst4_hwrite    (mst4_slv7_hwrite ),
	.mst4_req       (mst4_slv7_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv7_hwdata  ),
	.mst5_ack       (mst5_slv7_ack    ),
	.mst5_haddr     (mst5_slv7_haddr  ),
	.mst5_hburst    (mst5_slv7_hburst ),
	.mst5_hprot     (mst5_slv7_hprot  ),
	.mst5_hsize     (mst5_slv7_hsize  ),
	.mst5_htrans    (mst5_slv7_htrans ),
	.mst5_hwrite    (mst5_slv7_hwrite ),
	.mst5_req       (mst5_slv7_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv7_hwdata  ),
	.mst6_ack       (mst6_slv7_ack    ),
	.mst6_haddr     (mst6_slv7_haddr  ),
	.mst6_hburst    (mst6_slv7_hburst ),
	.mst6_hprot     (mst6_slv7_hprot  ),
	.mst6_hsize     (mst6_slv7_hsize  ),
	.mst6_htrans    (mst6_slv7_htrans ),
	.mst6_hwrite    (mst6_slv7_hwrite ),
	.mst6_req       (mst6_slv7_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv7_hwdata  ),
	.mst7_ack       (mst7_slv7_ack    ),
	.mst7_haddr     (mst7_slv7_haddr  ),
	.mst7_hburst    (mst7_slv7_hburst ),
	.mst7_hprot     (mst7_slv7_hprot  ),
	.mst7_hsize     (mst7_slv7_hsize  ),
	.mst7_htrans    (mst7_slv7_htrans ),
	.mst7_hwrite    (mst7_slv7_hwrite ),
	.mst7_req       (mst7_slv7_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv7_hwdata  ),
	.mst8_ack       (mst8_slv7_ack    ),
	.mst8_haddr     (mst8_slv7_haddr  ),
	.mst8_hburst    (mst8_slv7_hburst ),
	.mst8_hprot     (mst8_slv7_hprot  ),
	.mst8_hsize     (mst8_slv7_hsize  ),
	.mst8_htrans    (mst8_slv7_htrans ),
	.mst8_hwrite    (mst8_slv7_hwrite ),
	.mst8_req       (mst8_slv7_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv7_hwdata  ),
	.mst9_ack       (mst9_slv7_ack    ),
	.mst9_haddr     (mst9_slv7_haddr  ),
	.mst9_hburst    (mst9_slv7_hburst ),
	.mst9_hprot     (mst9_slv7_hprot  ),
	.mst9_hsize     (mst9_slv7_hsize  ),
	.mst9_htrans    (mst9_slv7_htrans ),
	.mst9_hwrite    (mst9_slv7_hwrite ),
	.mst9_req       (mst9_slv7_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv7_hwdata ),
	.mst10_ack      (mst10_slv7_ack   ),
	.mst10_haddr    (mst10_slv7_haddr ),
	.mst10_hburst   (mst10_slv7_hburst),
	.mst10_hprot    (mst10_slv7_hprot ),
	.mst10_hsize    (mst10_slv7_hsize ),
	.mst10_htrans   (mst10_slv7_htrans),
	.mst10_hwrite   (mst10_slv7_hwrite),
	.mst10_req      (mst10_slv7_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv7_hwdata ),
	.mst11_ack      (mst11_slv7_ack   ),
	.mst11_haddr    (mst11_slv7_haddr ),
	.mst11_hburst   (mst11_slv7_hburst),
	.mst11_hprot    (mst11_slv7_hprot ),
	.mst11_hsize    (mst11_slv7_hsize ),
	.mst11_htrans   (mst11_slv7_htrans),
	.mst11_hwrite   (mst11_slv7_hwrite),
	.mst11_req      (mst11_slv7_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv7_hwdata ),
	.mst12_ack      (mst12_slv7_ack   ),
	.mst12_haddr    (mst12_slv7_haddr ),
	.mst12_hburst   (mst12_slv7_hburst),
	.mst12_hprot    (mst12_slv7_hprot ),
	.mst12_hsize    (mst12_slv7_hsize ),
	.mst12_htrans   (mst12_slv7_htrans),
	.mst12_hwrite   (mst12_slv7_hwrite),
	.mst12_req      (mst12_slv7_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv7_hwdata ),
	.mst13_ack      (mst13_slv7_ack   ),
	.mst13_haddr    (mst13_slv7_haddr ),
	.mst13_hburst   (mst13_slv7_hburst),
	.mst13_hprot    (mst13_slv7_hprot ),
	.mst13_hsize    (mst13_slv7_hsize ),
	.mst13_htrans   (mst13_slv7_htrans),
	.mst13_hwrite   (mst13_slv7_hwrite),
	.mst13_req      (mst13_slv7_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv7_hwdata ),
	.mst14_ack      (mst14_slv7_ack   ),
	.mst14_haddr    (mst14_slv7_haddr ),
	.mst14_hburst   (mst14_slv7_hburst),
	.mst14_hprot    (mst14_slv7_hprot ),
	.mst14_hsize    (mst14_slv7_hsize ),
	.mst14_htrans   (mst14_slv7_htrans),
	.mst14_hwrite   (mst14_slv7_hwrite),
	.mst14_req      (mst14_slv7_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv7_hwdata ),
	.mst15_ack      (mst15_slv7_ack   ),
	.mst15_haddr    (mst15_slv7_haddr ),
	.mst15_hburst   (mst15_slv7_hburst),
	.mst15_hprot    (mst15_slv7_hprot ),
	.mst15_hsize    (mst15_slv7_hsize ),
	.mst15_htrans   (mst15_slv7_htrans),
	.mst15_hwrite   (mst15_slv7_hwrite),
	.mst15_req      (mst15_slv7_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs7_hready   ),
	.hclk           (hclk             ),
	.hresetn        (hresetn          ),
	.hs_bmc_hready  (hs7_bmc_hready   ),
	.hs_haddr       (hs7_haddr        ),
	.hs_hburst      (hs7_hburst       ),
	.hs_hprot       (hs7_hprot        ),
	.hs_hresp       (hs7_hresp        ),
	.hs_hsel        (hs7_hsel         ),
	.hs_hsize       (hs7_hsize        ),
	.hs_htrans      (hs7_htrans       ),
	.hs_hwdata      (hs7_hwdata       ),
	.hs_hwrite      (hs7_hwrite       ),
	.init_priority  (init_priority    ),
	.mst0_highest_en(mst0_highest_en  )
);

`endif
`ifdef ATCBMC200_AHB_SLV8
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander8 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv8_hwdata  ),
	.mst0_ack       (mst0_slv8_ack    ),
	.mst0_haddr     (mst0_slv8_haddr  ),
	.mst0_hburst    (mst0_slv8_hburst ),
	.mst0_hprot     (mst0_slv8_hprot  ),
	.mst0_hsize     (mst0_slv8_hsize  ),
	.mst0_htrans    (mst0_slv8_htrans ),
	.mst0_hwrite    (mst0_slv8_hwrite ),
	.mst0_req       (mst0_slv8_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv8_hwdata  ),
	.mst1_ack       (mst1_slv8_ack    ),
	.mst1_haddr     (mst1_slv8_haddr  ),
	.mst1_hburst    (mst1_slv8_hburst ),
	.mst1_hprot     (mst1_slv8_hprot  ),
	.mst1_hsize     (mst1_slv8_hsize  ),
	.mst1_htrans    (mst1_slv8_htrans ),
	.mst1_hwrite    (mst1_slv8_hwrite ),
	.mst1_req       (mst1_slv8_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv8_hwdata  ),
	.mst2_ack       (mst2_slv8_ack    ),
	.mst2_haddr     (mst2_slv8_haddr  ),
	.mst2_hburst    (mst2_slv8_hburst ),
	.mst2_hprot     (mst2_slv8_hprot  ),
	.mst2_hsize     (mst2_slv8_hsize  ),
	.mst2_htrans    (mst2_slv8_htrans ),
	.mst2_hwrite    (mst2_slv8_hwrite ),
	.mst2_req       (mst2_slv8_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv8_hwdata  ),
	.mst3_ack       (mst3_slv8_ack    ),
	.mst3_haddr     (mst3_slv8_haddr  ),
	.mst3_hburst    (mst3_slv8_hburst ),
	.mst3_hprot     (mst3_slv8_hprot  ),
	.mst3_hsize     (mst3_slv8_hsize  ),
	.mst3_htrans    (mst3_slv8_htrans ),
	.mst3_hwrite    (mst3_slv8_hwrite ),
	.mst3_req       (mst3_slv8_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv8_hwdata  ),
	.mst4_ack       (mst4_slv8_ack    ),
	.mst4_haddr     (mst4_slv8_haddr  ),
	.mst4_hburst    (mst4_slv8_hburst ),
	.mst4_hprot     (mst4_slv8_hprot  ),
	.mst4_hsize     (mst4_slv8_hsize  ),
	.mst4_htrans    (mst4_slv8_htrans ),
	.mst4_hwrite    (mst4_slv8_hwrite ),
	.mst4_req       (mst4_slv8_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv8_hwdata  ),
	.mst5_ack       (mst5_slv8_ack    ),
	.mst5_haddr     (mst5_slv8_haddr  ),
	.mst5_hburst    (mst5_slv8_hburst ),
	.mst5_hprot     (mst5_slv8_hprot  ),
	.mst5_hsize     (mst5_slv8_hsize  ),
	.mst5_htrans    (mst5_slv8_htrans ),
	.mst5_hwrite    (mst5_slv8_hwrite ),
	.mst5_req       (mst5_slv8_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv8_hwdata  ),
	.mst6_ack       (mst6_slv8_ack    ),
	.mst6_haddr     (mst6_slv8_haddr  ),
	.mst6_hburst    (mst6_slv8_hburst ),
	.mst6_hprot     (mst6_slv8_hprot  ),
	.mst6_hsize     (mst6_slv8_hsize  ),
	.mst6_htrans    (mst6_slv8_htrans ),
	.mst6_hwrite    (mst6_slv8_hwrite ),
	.mst6_req       (mst6_slv8_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv8_hwdata  ),
	.mst7_ack       (mst7_slv8_ack    ),
	.mst7_haddr     (mst7_slv8_haddr  ),
	.mst7_hburst    (mst7_slv8_hburst ),
	.mst7_hprot     (mst7_slv8_hprot  ),
	.mst7_hsize     (mst7_slv8_hsize  ),
	.mst7_htrans    (mst7_slv8_htrans ),
	.mst7_hwrite    (mst7_slv8_hwrite ),
	.mst7_req       (mst7_slv8_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv8_hwdata  ),
	.mst8_ack       (mst8_slv8_ack    ),
	.mst8_haddr     (mst8_slv8_haddr  ),
	.mst8_hburst    (mst8_slv8_hburst ),
	.mst8_hprot     (mst8_slv8_hprot  ),
	.mst8_hsize     (mst8_slv8_hsize  ),
	.mst8_htrans    (mst8_slv8_htrans ),
	.mst8_hwrite    (mst8_slv8_hwrite ),
	.mst8_req       (mst8_slv8_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv8_hwdata  ),
	.mst9_ack       (mst9_slv8_ack    ),
	.mst9_haddr     (mst9_slv8_haddr  ),
	.mst9_hburst    (mst9_slv8_hburst ),
	.mst9_hprot     (mst9_slv8_hprot  ),
	.mst9_hsize     (mst9_slv8_hsize  ),
	.mst9_htrans    (mst9_slv8_htrans ),
	.mst9_hwrite    (mst9_slv8_hwrite ),
	.mst9_req       (mst9_slv8_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv8_hwdata ),
	.mst10_ack      (mst10_slv8_ack   ),
	.mst10_haddr    (mst10_slv8_haddr ),
	.mst10_hburst   (mst10_slv8_hburst),
	.mst10_hprot    (mst10_slv8_hprot ),
	.mst10_hsize    (mst10_slv8_hsize ),
	.mst10_htrans   (mst10_slv8_htrans),
	.mst10_hwrite   (mst10_slv8_hwrite),
	.mst10_req      (mst10_slv8_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv8_hwdata ),
	.mst11_ack      (mst11_slv8_ack   ),
	.mst11_haddr    (mst11_slv8_haddr ),
	.mst11_hburst   (mst11_slv8_hburst),
	.mst11_hprot    (mst11_slv8_hprot ),
	.mst11_hsize    (mst11_slv8_hsize ),
	.mst11_htrans   (mst11_slv8_htrans),
	.mst11_hwrite   (mst11_slv8_hwrite),
	.mst11_req      (mst11_slv8_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv8_hwdata ),
	.mst12_ack      (mst12_slv8_ack   ),
	.mst12_haddr    (mst12_slv8_haddr ),
	.mst12_hburst   (mst12_slv8_hburst),
	.mst12_hprot    (mst12_slv8_hprot ),
	.mst12_hsize    (mst12_slv8_hsize ),
	.mst12_htrans   (mst12_slv8_htrans),
	.mst12_hwrite   (mst12_slv8_hwrite),
	.mst12_req      (mst12_slv8_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv8_hwdata ),
	.mst13_ack      (mst13_slv8_ack   ),
	.mst13_haddr    (mst13_slv8_haddr ),
	.mst13_hburst   (mst13_slv8_hburst),
	.mst13_hprot    (mst13_slv8_hprot ),
	.mst13_hsize    (mst13_slv8_hsize ),
	.mst13_htrans   (mst13_slv8_htrans),
	.mst13_hwrite   (mst13_slv8_hwrite),
	.mst13_req      (mst13_slv8_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv8_hwdata ),
	.mst14_ack      (mst14_slv8_ack   ),
	.mst14_haddr    (mst14_slv8_haddr ),
	.mst14_hburst   (mst14_slv8_hburst),
	.mst14_hprot    (mst14_slv8_hprot ),
	.mst14_hsize    (mst14_slv8_hsize ),
	.mst14_htrans   (mst14_slv8_htrans),
	.mst14_hwrite   (mst14_slv8_hwrite),
	.mst14_req      (mst14_slv8_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv8_hwdata ),
	.mst15_ack      (mst15_slv8_ack   ),
	.mst15_haddr    (mst15_slv8_haddr ),
	.mst15_hburst   (mst15_slv8_hburst),
	.mst15_hprot    (mst15_slv8_hprot ),
	.mst15_hsize    (mst15_slv8_hsize ),
	.mst15_htrans   (mst15_slv8_htrans),
	.mst15_hwrite   (mst15_slv8_hwrite),
	.mst15_req      (mst15_slv8_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs8_hready   ),
	.hclk           (hclk             ),
	.hresetn        (hresetn          ),
	.hs_bmc_hready  (hs8_bmc_hready   ),
	.hs_haddr       (hs8_haddr        ),
	.hs_hburst      (hs8_hburst       ),
	.hs_hprot       (hs8_hprot        ),
	.hs_hresp       (hs8_hresp        ),
	.hs_hsel        (hs8_hsel         ),
	.hs_hsize       (hs8_hsize        ),
	.hs_htrans      (hs8_htrans       ),
	.hs_hwdata      (hs8_hwdata       ),
	.hs_hwrite      (hs8_hwrite       ),
	.init_priority  (init_priority    ),
	.mst0_highest_en(mst0_highest_en  )
);

`endif
`ifdef ATCBMC200_AHB_SLV9
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander9 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv9_hwdata  ),
	.mst0_ack       (mst0_slv9_ack    ),
	.mst0_haddr     (mst0_slv9_haddr  ),
	.mst0_hburst    (mst0_slv9_hburst ),
	.mst0_hprot     (mst0_slv9_hprot  ),
	.mst0_hsize     (mst0_slv9_hsize  ),
	.mst0_htrans    (mst0_slv9_htrans ),
	.mst0_hwrite    (mst0_slv9_hwrite ),
	.mst0_req       (mst0_slv9_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv9_hwdata  ),
	.mst1_ack       (mst1_slv9_ack    ),
	.mst1_haddr     (mst1_slv9_haddr  ),
	.mst1_hburst    (mst1_slv9_hburst ),
	.mst1_hprot     (mst1_slv9_hprot  ),
	.mst1_hsize     (mst1_slv9_hsize  ),
	.mst1_htrans    (mst1_slv9_htrans ),
	.mst1_hwrite    (mst1_slv9_hwrite ),
	.mst1_req       (mst1_slv9_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv9_hwdata  ),
	.mst2_ack       (mst2_slv9_ack    ),
	.mst2_haddr     (mst2_slv9_haddr  ),
	.mst2_hburst    (mst2_slv9_hburst ),
	.mst2_hprot     (mst2_slv9_hprot  ),
	.mst2_hsize     (mst2_slv9_hsize  ),
	.mst2_htrans    (mst2_slv9_htrans ),
	.mst2_hwrite    (mst2_slv9_hwrite ),
	.mst2_req       (mst2_slv9_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv9_hwdata  ),
	.mst3_ack       (mst3_slv9_ack    ),
	.mst3_haddr     (mst3_slv9_haddr  ),
	.mst3_hburst    (mst3_slv9_hburst ),
	.mst3_hprot     (mst3_slv9_hprot  ),
	.mst3_hsize     (mst3_slv9_hsize  ),
	.mst3_htrans    (mst3_slv9_htrans ),
	.mst3_hwrite    (mst3_slv9_hwrite ),
	.mst3_req       (mst3_slv9_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv9_hwdata  ),
	.mst4_ack       (mst4_slv9_ack    ),
	.mst4_haddr     (mst4_slv9_haddr  ),
	.mst4_hburst    (mst4_slv9_hburst ),
	.mst4_hprot     (mst4_slv9_hprot  ),
	.mst4_hsize     (mst4_slv9_hsize  ),
	.mst4_htrans    (mst4_slv9_htrans ),
	.mst4_hwrite    (mst4_slv9_hwrite ),
	.mst4_req       (mst4_slv9_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv9_hwdata  ),
	.mst5_ack       (mst5_slv9_ack    ),
	.mst5_haddr     (mst5_slv9_haddr  ),
	.mst5_hburst    (mst5_slv9_hburst ),
	.mst5_hprot     (mst5_slv9_hprot  ),
	.mst5_hsize     (mst5_slv9_hsize  ),
	.mst5_htrans    (mst5_slv9_htrans ),
	.mst5_hwrite    (mst5_slv9_hwrite ),
	.mst5_req       (mst5_slv9_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv9_hwdata  ),
	.mst6_ack       (mst6_slv9_ack    ),
	.mst6_haddr     (mst6_slv9_haddr  ),
	.mst6_hburst    (mst6_slv9_hburst ),
	.mst6_hprot     (mst6_slv9_hprot  ),
	.mst6_hsize     (mst6_slv9_hsize  ),
	.mst6_htrans    (mst6_slv9_htrans ),
	.mst6_hwrite    (mst6_slv9_hwrite ),
	.mst6_req       (mst6_slv9_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv9_hwdata  ),
	.mst7_ack       (mst7_slv9_ack    ),
	.mst7_haddr     (mst7_slv9_haddr  ),
	.mst7_hburst    (mst7_slv9_hburst ),
	.mst7_hprot     (mst7_slv9_hprot  ),
	.mst7_hsize     (mst7_slv9_hsize  ),
	.mst7_htrans    (mst7_slv9_htrans ),
	.mst7_hwrite    (mst7_slv9_hwrite ),
	.mst7_req       (mst7_slv9_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv9_hwdata  ),
	.mst8_ack       (mst8_slv9_ack    ),
	.mst8_haddr     (mst8_slv9_haddr  ),
	.mst8_hburst    (mst8_slv9_hburst ),
	.mst8_hprot     (mst8_slv9_hprot  ),
	.mst8_hsize     (mst8_slv9_hsize  ),
	.mst8_htrans    (mst8_slv9_htrans ),
	.mst8_hwrite    (mst8_slv9_hwrite ),
	.mst8_req       (mst8_slv9_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv9_hwdata  ),
	.mst9_ack       (mst9_slv9_ack    ),
	.mst9_haddr     (mst9_slv9_haddr  ),
	.mst9_hburst    (mst9_slv9_hburst ),
	.mst9_hprot     (mst9_slv9_hprot  ),
	.mst9_hsize     (mst9_slv9_hsize  ),
	.mst9_htrans    (mst9_slv9_htrans ),
	.mst9_hwrite    (mst9_slv9_hwrite ),
	.mst9_req       (mst9_slv9_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv9_hwdata ),
	.mst10_ack      (mst10_slv9_ack   ),
	.mst10_haddr    (mst10_slv9_haddr ),
	.mst10_hburst   (mst10_slv9_hburst),
	.mst10_hprot    (mst10_slv9_hprot ),
	.mst10_hsize    (mst10_slv9_hsize ),
	.mst10_htrans   (mst10_slv9_htrans),
	.mst10_hwrite   (mst10_slv9_hwrite),
	.mst10_req      (mst10_slv9_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv9_hwdata ),
	.mst11_ack      (mst11_slv9_ack   ),
	.mst11_haddr    (mst11_slv9_haddr ),
	.mst11_hburst   (mst11_slv9_hburst),
	.mst11_hprot    (mst11_slv9_hprot ),
	.mst11_hsize    (mst11_slv9_hsize ),
	.mst11_htrans   (mst11_slv9_htrans),
	.mst11_hwrite   (mst11_slv9_hwrite),
	.mst11_req      (mst11_slv9_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv9_hwdata ),
	.mst12_ack      (mst12_slv9_ack   ),
	.mst12_haddr    (mst12_slv9_haddr ),
	.mst12_hburst   (mst12_slv9_hburst),
	.mst12_hprot    (mst12_slv9_hprot ),
	.mst12_hsize    (mst12_slv9_hsize ),
	.mst12_htrans   (mst12_slv9_htrans),
	.mst12_hwrite   (mst12_slv9_hwrite),
	.mst12_req      (mst12_slv9_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv9_hwdata ),
	.mst13_ack      (mst13_slv9_ack   ),
	.mst13_haddr    (mst13_slv9_haddr ),
	.mst13_hburst   (mst13_slv9_hburst),
	.mst13_hprot    (mst13_slv9_hprot ),
	.mst13_hsize    (mst13_slv9_hsize ),
	.mst13_htrans   (mst13_slv9_htrans),
	.mst13_hwrite   (mst13_slv9_hwrite),
	.mst13_req      (mst13_slv9_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv9_hwdata ),
	.mst14_ack      (mst14_slv9_ack   ),
	.mst14_haddr    (mst14_slv9_haddr ),
	.mst14_hburst   (mst14_slv9_hburst),
	.mst14_hprot    (mst14_slv9_hprot ),
	.mst14_hsize    (mst14_slv9_hsize ),
	.mst14_htrans   (mst14_slv9_htrans),
	.mst14_hwrite   (mst14_slv9_hwrite),
	.mst14_req      (mst14_slv9_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv9_hwdata ),
	.mst15_ack      (mst15_slv9_ack   ),
	.mst15_haddr    (mst15_slv9_haddr ),
	.mst15_hburst   (mst15_slv9_hburst),
	.mst15_hprot    (mst15_slv9_hprot ),
	.mst15_hsize    (mst15_slv9_hsize ),
	.mst15_htrans   (mst15_slv9_htrans),
	.mst15_hwrite   (mst15_slv9_hwrite),
	.mst15_req      (mst15_slv9_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs9_hready   ),
	.hclk           (hclk             ),
	.hresetn        (hresetn          ),
	.hs_bmc_hready  (hs9_bmc_hready   ),
	.hs_haddr       (hs9_haddr        ),
	.hs_hburst      (hs9_hburst       ),
	.hs_hprot       (hs9_hprot        ),
	.hs_hresp       (hs9_hresp        ),
	.hs_hsel        (hs9_hsel         ),
	.hs_hsize       (hs9_hsize        ),
	.hs_htrans      (hs9_htrans       ),
	.hs_hwdata      (hs9_hwdata       ),
	.hs_hwrite      (hs9_hwrite       ),
	.init_priority  (init_priority    ),
	.mst0_highest_en(mst0_highest_en  )
);

`endif
`ifdef ATCBMC200_AHB_SLV10
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander10 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv10_hwdata  ),
	.mst0_ack       (mst0_slv10_ack    ),
	.mst0_haddr     (mst0_slv10_haddr  ),
	.mst0_hburst    (mst0_slv10_hburst ),
	.mst0_hprot     (mst0_slv10_hprot  ),
	.mst0_hsize     (mst0_slv10_hsize  ),
	.mst0_htrans    (mst0_slv10_htrans ),
	.mst0_hwrite    (mst0_slv10_hwrite ),
	.mst0_req       (mst0_slv10_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv10_hwdata  ),
	.mst1_ack       (mst1_slv10_ack    ),
	.mst1_haddr     (mst1_slv10_haddr  ),
	.mst1_hburst    (mst1_slv10_hburst ),
	.mst1_hprot     (mst1_slv10_hprot  ),
	.mst1_hsize     (mst1_slv10_hsize  ),
	.mst1_htrans    (mst1_slv10_htrans ),
	.mst1_hwrite    (mst1_slv10_hwrite ),
	.mst1_req       (mst1_slv10_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv10_hwdata  ),
	.mst2_ack       (mst2_slv10_ack    ),
	.mst2_haddr     (mst2_slv10_haddr  ),
	.mst2_hburst    (mst2_slv10_hburst ),
	.mst2_hprot     (mst2_slv10_hprot  ),
	.mst2_hsize     (mst2_slv10_hsize  ),
	.mst2_htrans    (mst2_slv10_htrans ),
	.mst2_hwrite    (mst2_slv10_hwrite ),
	.mst2_req       (mst2_slv10_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv10_hwdata  ),
	.mst3_ack       (mst3_slv10_ack    ),
	.mst3_haddr     (mst3_slv10_haddr  ),
	.mst3_hburst    (mst3_slv10_hburst ),
	.mst3_hprot     (mst3_slv10_hprot  ),
	.mst3_hsize     (mst3_slv10_hsize  ),
	.mst3_htrans    (mst3_slv10_htrans ),
	.mst3_hwrite    (mst3_slv10_hwrite ),
	.mst3_req       (mst3_slv10_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv10_hwdata  ),
	.mst4_ack       (mst4_slv10_ack    ),
	.mst4_haddr     (mst4_slv10_haddr  ),
	.mst4_hburst    (mst4_slv10_hburst ),
	.mst4_hprot     (mst4_slv10_hprot  ),
	.mst4_hsize     (mst4_slv10_hsize  ),
	.mst4_htrans    (mst4_slv10_htrans ),
	.mst4_hwrite    (mst4_slv10_hwrite ),
	.mst4_req       (mst4_slv10_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv10_hwdata  ),
	.mst5_ack       (mst5_slv10_ack    ),
	.mst5_haddr     (mst5_slv10_haddr  ),
	.mst5_hburst    (mst5_slv10_hburst ),
	.mst5_hprot     (mst5_slv10_hprot  ),
	.mst5_hsize     (mst5_slv10_hsize  ),
	.mst5_htrans    (mst5_slv10_htrans ),
	.mst5_hwrite    (mst5_slv10_hwrite ),
	.mst5_req       (mst5_slv10_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv10_hwdata  ),
	.mst6_ack       (mst6_slv10_ack    ),
	.mst6_haddr     (mst6_slv10_haddr  ),
	.mst6_hburst    (mst6_slv10_hburst ),
	.mst6_hprot     (mst6_slv10_hprot  ),
	.mst6_hsize     (mst6_slv10_hsize  ),
	.mst6_htrans    (mst6_slv10_htrans ),
	.mst6_hwrite    (mst6_slv10_hwrite ),
	.mst6_req       (mst6_slv10_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv10_hwdata  ),
	.mst7_ack       (mst7_slv10_ack    ),
	.mst7_haddr     (mst7_slv10_haddr  ),
	.mst7_hburst    (mst7_slv10_hburst ),
	.mst7_hprot     (mst7_slv10_hprot  ),
	.mst7_hsize     (mst7_slv10_hsize  ),
	.mst7_htrans    (mst7_slv10_htrans ),
	.mst7_hwrite    (mst7_slv10_hwrite ),
	.mst7_req       (mst7_slv10_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv10_hwdata  ),
	.mst8_ack       (mst8_slv10_ack    ),
	.mst8_haddr     (mst8_slv10_haddr  ),
	.mst8_hburst    (mst8_slv10_hburst ),
	.mst8_hprot     (mst8_slv10_hprot  ),
	.mst8_hsize     (mst8_slv10_hsize  ),
	.mst8_htrans    (mst8_slv10_htrans ),
	.mst8_hwrite    (mst8_slv10_hwrite ),
	.mst8_req       (mst8_slv10_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv10_hwdata  ),
	.mst9_ack       (mst9_slv10_ack    ),
	.mst9_haddr     (mst9_slv10_haddr  ),
	.mst9_hburst    (mst9_slv10_hburst ),
	.mst9_hprot     (mst9_slv10_hprot  ),
	.mst9_hsize     (mst9_slv10_hsize  ),
	.mst9_htrans    (mst9_slv10_htrans ),
	.mst9_hwrite    (mst9_slv10_hwrite ),
	.mst9_req       (mst9_slv10_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv10_hwdata ),
	.mst10_ack      (mst10_slv10_ack   ),
	.mst10_haddr    (mst10_slv10_haddr ),
	.mst10_hburst   (mst10_slv10_hburst),
	.mst10_hprot    (mst10_slv10_hprot ),
	.mst10_hsize    (mst10_slv10_hsize ),
	.mst10_htrans   (mst10_slv10_htrans),
	.mst10_hwrite   (mst10_slv10_hwrite),
	.mst10_req      (mst10_slv10_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv10_hwdata ),
	.mst11_ack      (mst11_slv10_ack   ),
	.mst11_haddr    (mst11_slv10_haddr ),
	.mst11_hburst   (mst11_slv10_hburst),
	.mst11_hprot    (mst11_slv10_hprot ),
	.mst11_hsize    (mst11_slv10_hsize ),
	.mst11_htrans   (mst11_slv10_htrans),
	.mst11_hwrite   (mst11_slv10_hwrite),
	.mst11_req      (mst11_slv10_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv10_hwdata ),
	.mst12_ack      (mst12_slv10_ack   ),
	.mst12_haddr    (mst12_slv10_haddr ),
	.mst12_hburst   (mst12_slv10_hburst),
	.mst12_hprot    (mst12_slv10_hprot ),
	.mst12_hsize    (mst12_slv10_hsize ),
	.mst12_htrans   (mst12_slv10_htrans),
	.mst12_hwrite   (mst12_slv10_hwrite),
	.mst12_req      (mst12_slv10_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv10_hwdata ),
	.mst13_ack      (mst13_slv10_ack   ),
	.mst13_haddr    (mst13_slv10_haddr ),
	.mst13_hburst   (mst13_slv10_hburst),
	.mst13_hprot    (mst13_slv10_hprot ),
	.mst13_hsize    (mst13_slv10_hsize ),
	.mst13_htrans   (mst13_slv10_htrans),
	.mst13_hwrite   (mst13_slv10_hwrite),
	.mst13_req      (mst13_slv10_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv10_hwdata ),
	.mst14_ack      (mst14_slv10_ack   ),
	.mst14_haddr    (mst14_slv10_haddr ),
	.mst14_hburst   (mst14_slv10_hburst),
	.mst14_hprot    (mst14_slv10_hprot ),
	.mst14_hsize    (mst14_slv10_hsize ),
	.mst14_htrans   (mst14_slv10_htrans),
	.mst14_hwrite   (mst14_slv10_hwrite),
	.mst14_req      (mst14_slv10_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv10_hwdata ),
	.mst15_ack      (mst15_slv10_ack   ),
	.mst15_haddr    (mst15_slv10_haddr ),
	.mst15_hburst   (mst15_slv10_hburst),
	.mst15_hprot    (mst15_slv10_hprot ),
	.mst15_hsize    (mst15_slv10_hsize ),
	.mst15_htrans   (mst15_slv10_htrans),
	.mst15_hwrite   (mst15_slv10_hwrite),
	.mst15_req      (mst15_slv10_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs10_hready   ),
	.hclk           (hclk              ),
	.hresetn        (hresetn           ),
	.hs_bmc_hready  (hs10_bmc_hready   ),
	.hs_haddr       (hs10_haddr        ),
	.hs_hburst      (hs10_hburst       ),
	.hs_hprot       (hs10_hprot        ),
	.hs_hresp       (hs10_hresp        ),
	.hs_hsel        (hs10_hsel         ),
	.hs_hsize       (hs10_hsize        ),
	.hs_htrans      (hs10_htrans       ),
	.hs_hwdata      (hs10_hwdata       ),
	.hs_hwrite      (hs10_hwrite       ),
	.init_priority  (init_priority     ),
	.mst0_highest_en(mst0_highest_en   )
);

`endif
`ifdef ATCBMC200_AHB_SLV11
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander11 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv11_hwdata  ),
	.mst0_ack       (mst0_slv11_ack    ),
	.mst0_haddr     (mst0_slv11_haddr  ),
	.mst0_hburst    (mst0_slv11_hburst ),
	.mst0_hprot     (mst0_slv11_hprot  ),
	.mst0_hsize     (mst0_slv11_hsize  ),
	.mst0_htrans    (mst0_slv11_htrans ),
	.mst0_hwrite    (mst0_slv11_hwrite ),
	.mst0_req       (mst0_slv11_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv11_hwdata  ),
	.mst1_ack       (mst1_slv11_ack    ),
	.mst1_haddr     (mst1_slv11_haddr  ),
	.mst1_hburst    (mst1_slv11_hburst ),
	.mst1_hprot     (mst1_slv11_hprot  ),
	.mst1_hsize     (mst1_slv11_hsize  ),
	.mst1_htrans    (mst1_slv11_htrans ),
	.mst1_hwrite    (mst1_slv11_hwrite ),
	.mst1_req       (mst1_slv11_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv11_hwdata  ),
	.mst2_ack       (mst2_slv11_ack    ),
	.mst2_haddr     (mst2_slv11_haddr  ),
	.mst2_hburst    (mst2_slv11_hburst ),
	.mst2_hprot     (mst2_slv11_hprot  ),
	.mst2_hsize     (mst2_slv11_hsize  ),
	.mst2_htrans    (mst2_slv11_htrans ),
	.mst2_hwrite    (mst2_slv11_hwrite ),
	.mst2_req       (mst2_slv11_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv11_hwdata  ),
	.mst3_ack       (mst3_slv11_ack    ),
	.mst3_haddr     (mst3_slv11_haddr  ),
	.mst3_hburst    (mst3_slv11_hburst ),
	.mst3_hprot     (mst3_slv11_hprot  ),
	.mst3_hsize     (mst3_slv11_hsize  ),
	.mst3_htrans    (mst3_slv11_htrans ),
	.mst3_hwrite    (mst3_slv11_hwrite ),
	.mst3_req       (mst3_slv11_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv11_hwdata  ),
	.mst4_ack       (mst4_slv11_ack    ),
	.mst4_haddr     (mst4_slv11_haddr  ),
	.mst4_hburst    (mst4_slv11_hburst ),
	.mst4_hprot     (mst4_slv11_hprot  ),
	.mst4_hsize     (mst4_slv11_hsize  ),
	.mst4_htrans    (mst4_slv11_htrans ),
	.mst4_hwrite    (mst4_slv11_hwrite ),
	.mst4_req       (mst4_slv11_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv11_hwdata  ),
	.mst5_ack       (mst5_slv11_ack    ),
	.mst5_haddr     (mst5_slv11_haddr  ),
	.mst5_hburst    (mst5_slv11_hburst ),
	.mst5_hprot     (mst5_slv11_hprot  ),
	.mst5_hsize     (mst5_slv11_hsize  ),
	.mst5_htrans    (mst5_slv11_htrans ),
	.mst5_hwrite    (mst5_slv11_hwrite ),
	.mst5_req       (mst5_slv11_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv11_hwdata  ),
	.mst6_ack       (mst6_slv11_ack    ),
	.mst6_haddr     (mst6_slv11_haddr  ),
	.mst6_hburst    (mst6_slv11_hburst ),
	.mst6_hprot     (mst6_slv11_hprot  ),
	.mst6_hsize     (mst6_slv11_hsize  ),
	.mst6_htrans    (mst6_slv11_htrans ),
	.mst6_hwrite    (mst6_slv11_hwrite ),
	.mst6_req       (mst6_slv11_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv11_hwdata  ),
	.mst7_ack       (mst7_slv11_ack    ),
	.mst7_haddr     (mst7_slv11_haddr  ),
	.mst7_hburst    (mst7_slv11_hburst ),
	.mst7_hprot     (mst7_slv11_hprot  ),
	.mst7_hsize     (mst7_slv11_hsize  ),
	.mst7_htrans    (mst7_slv11_htrans ),
	.mst7_hwrite    (mst7_slv11_hwrite ),
	.mst7_req       (mst7_slv11_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv11_hwdata  ),
	.mst8_ack       (mst8_slv11_ack    ),
	.mst8_haddr     (mst8_slv11_haddr  ),
	.mst8_hburst    (mst8_slv11_hburst ),
	.mst8_hprot     (mst8_slv11_hprot  ),
	.mst8_hsize     (mst8_slv11_hsize  ),
	.mst8_htrans    (mst8_slv11_htrans ),
	.mst8_hwrite    (mst8_slv11_hwrite ),
	.mst8_req       (mst8_slv11_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv11_hwdata  ),
	.mst9_ack       (mst9_slv11_ack    ),
	.mst9_haddr     (mst9_slv11_haddr  ),
	.mst9_hburst    (mst9_slv11_hburst ),
	.mst9_hprot     (mst9_slv11_hprot  ),
	.mst9_hsize     (mst9_slv11_hsize  ),
	.mst9_htrans    (mst9_slv11_htrans ),
	.mst9_hwrite    (mst9_slv11_hwrite ),
	.mst9_req       (mst9_slv11_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv11_hwdata ),
	.mst10_ack      (mst10_slv11_ack   ),
	.mst10_haddr    (mst10_slv11_haddr ),
	.mst10_hburst   (mst10_slv11_hburst),
	.mst10_hprot    (mst10_slv11_hprot ),
	.mst10_hsize    (mst10_slv11_hsize ),
	.mst10_htrans   (mst10_slv11_htrans),
	.mst10_hwrite   (mst10_slv11_hwrite),
	.mst10_req      (mst10_slv11_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv11_hwdata ),
	.mst11_ack      (mst11_slv11_ack   ),
	.mst11_haddr    (mst11_slv11_haddr ),
	.mst11_hburst   (mst11_slv11_hburst),
	.mst11_hprot    (mst11_slv11_hprot ),
	.mst11_hsize    (mst11_slv11_hsize ),
	.mst11_htrans   (mst11_slv11_htrans),
	.mst11_hwrite   (mst11_slv11_hwrite),
	.mst11_req      (mst11_slv11_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv11_hwdata ),
	.mst12_ack      (mst12_slv11_ack   ),
	.mst12_haddr    (mst12_slv11_haddr ),
	.mst12_hburst   (mst12_slv11_hburst),
	.mst12_hprot    (mst12_slv11_hprot ),
	.mst12_hsize    (mst12_slv11_hsize ),
	.mst12_htrans   (mst12_slv11_htrans),
	.mst12_hwrite   (mst12_slv11_hwrite),
	.mst12_req      (mst12_slv11_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv11_hwdata ),
	.mst13_ack      (mst13_slv11_ack   ),
	.mst13_haddr    (mst13_slv11_haddr ),
	.mst13_hburst   (mst13_slv11_hburst),
	.mst13_hprot    (mst13_slv11_hprot ),
	.mst13_hsize    (mst13_slv11_hsize ),
	.mst13_htrans   (mst13_slv11_htrans),
	.mst13_hwrite   (mst13_slv11_hwrite),
	.mst13_req      (mst13_slv11_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv11_hwdata ),
	.mst14_ack      (mst14_slv11_ack   ),
	.mst14_haddr    (mst14_slv11_haddr ),
	.mst14_hburst   (mst14_slv11_hburst),
	.mst14_hprot    (mst14_slv11_hprot ),
	.mst14_hsize    (mst14_slv11_hsize ),
	.mst14_htrans   (mst14_slv11_htrans),
	.mst14_hwrite   (mst14_slv11_hwrite),
	.mst14_req      (mst14_slv11_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv11_hwdata ),
	.mst15_ack      (mst15_slv11_ack   ),
	.mst15_haddr    (mst15_slv11_haddr ),
	.mst15_hburst   (mst15_slv11_hburst),
	.mst15_hprot    (mst15_slv11_hprot ),
	.mst15_hsize    (mst15_slv11_hsize ),
	.mst15_htrans   (mst15_slv11_htrans),
	.mst15_hwrite   (mst15_slv11_hwrite),
	.mst15_req      (mst15_slv11_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs11_hready   ),
	.hclk           (hclk              ),
	.hresetn        (hresetn           ),
	.hs_bmc_hready  (hs11_bmc_hready   ),
	.hs_haddr       (hs11_haddr        ),
	.hs_hburst      (hs11_hburst       ),
	.hs_hprot       (hs11_hprot        ),
	.hs_hresp       (hs11_hresp        ),
	.hs_hsel        (hs11_hsel         ),
	.hs_hsize       (hs11_hsize        ),
	.hs_htrans      (hs11_htrans       ),
	.hs_hwdata      (hs11_hwdata       ),
	.hs_hwrite      (hs11_hwrite       ),
	.init_priority  (init_priority     ),
	.mst0_highest_en(mst0_highest_en   )
);

`endif
`ifdef ATCBMC200_AHB_SLV12
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander12 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv12_hwdata  ),
	.mst0_ack       (mst0_slv12_ack    ),
	.mst0_haddr     (mst0_slv12_haddr  ),
	.mst0_hburst    (mst0_slv12_hburst ),
	.mst0_hprot     (mst0_slv12_hprot  ),
	.mst0_hsize     (mst0_slv12_hsize  ),
	.mst0_htrans    (mst0_slv12_htrans ),
	.mst0_hwrite    (mst0_slv12_hwrite ),
	.mst0_req       (mst0_slv12_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv12_hwdata  ),
	.mst1_ack       (mst1_slv12_ack    ),
	.mst1_haddr     (mst1_slv12_haddr  ),
	.mst1_hburst    (mst1_slv12_hburst ),
	.mst1_hprot     (mst1_slv12_hprot  ),
	.mst1_hsize     (mst1_slv12_hsize  ),
	.mst1_htrans    (mst1_slv12_htrans ),
	.mst1_hwrite    (mst1_slv12_hwrite ),
	.mst1_req       (mst1_slv12_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv12_hwdata  ),
	.mst2_ack       (mst2_slv12_ack    ),
	.mst2_haddr     (mst2_slv12_haddr  ),
	.mst2_hburst    (mst2_slv12_hburst ),
	.mst2_hprot     (mst2_slv12_hprot  ),
	.mst2_hsize     (mst2_slv12_hsize  ),
	.mst2_htrans    (mst2_slv12_htrans ),
	.mst2_hwrite    (mst2_slv12_hwrite ),
	.mst2_req       (mst2_slv12_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv12_hwdata  ),
	.mst3_ack       (mst3_slv12_ack    ),
	.mst3_haddr     (mst3_slv12_haddr  ),
	.mst3_hburst    (mst3_slv12_hburst ),
	.mst3_hprot     (mst3_slv12_hprot  ),
	.mst3_hsize     (mst3_slv12_hsize  ),
	.mst3_htrans    (mst3_slv12_htrans ),
	.mst3_hwrite    (mst3_slv12_hwrite ),
	.mst3_req       (mst3_slv12_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv12_hwdata  ),
	.mst4_ack       (mst4_slv12_ack    ),
	.mst4_haddr     (mst4_slv12_haddr  ),
	.mst4_hburst    (mst4_slv12_hburst ),
	.mst4_hprot     (mst4_slv12_hprot  ),
	.mst4_hsize     (mst4_slv12_hsize  ),
	.mst4_htrans    (mst4_slv12_htrans ),
	.mst4_hwrite    (mst4_slv12_hwrite ),
	.mst4_req       (mst4_slv12_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv12_hwdata  ),
	.mst5_ack       (mst5_slv12_ack    ),
	.mst5_haddr     (mst5_slv12_haddr  ),
	.mst5_hburst    (mst5_slv12_hburst ),
	.mst5_hprot     (mst5_slv12_hprot  ),
	.mst5_hsize     (mst5_slv12_hsize  ),
	.mst5_htrans    (mst5_slv12_htrans ),
	.mst5_hwrite    (mst5_slv12_hwrite ),
	.mst5_req       (mst5_slv12_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv12_hwdata  ),
	.mst6_ack       (mst6_slv12_ack    ),
	.mst6_haddr     (mst6_slv12_haddr  ),
	.mst6_hburst    (mst6_slv12_hburst ),
	.mst6_hprot     (mst6_slv12_hprot  ),
	.mst6_hsize     (mst6_slv12_hsize  ),
	.mst6_htrans    (mst6_slv12_htrans ),
	.mst6_hwrite    (mst6_slv12_hwrite ),
	.mst6_req       (mst6_slv12_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv12_hwdata  ),
	.mst7_ack       (mst7_slv12_ack    ),
	.mst7_haddr     (mst7_slv12_haddr  ),
	.mst7_hburst    (mst7_slv12_hburst ),
	.mst7_hprot     (mst7_slv12_hprot  ),
	.mst7_hsize     (mst7_slv12_hsize  ),
	.mst7_htrans    (mst7_slv12_htrans ),
	.mst7_hwrite    (mst7_slv12_hwrite ),
	.mst7_req       (mst7_slv12_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv12_hwdata  ),
	.mst8_ack       (mst8_slv12_ack    ),
	.mst8_haddr     (mst8_slv12_haddr  ),
	.mst8_hburst    (mst8_slv12_hburst ),
	.mst8_hprot     (mst8_slv12_hprot  ),
	.mst8_hsize     (mst8_slv12_hsize  ),
	.mst8_htrans    (mst8_slv12_htrans ),
	.mst8_hwrite    (mst8_slv12_hwrite ),
	.mst8_req       (mst8_slv12_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv12_hwdata  ),
	.mst9_ack       (mst9_slv12_ack    ),
	.mst9_haddr     (mst9_slv12_haddr  ),
	.mst9_hburst    (mst9_slv12_hburst ),
	.mst9_hprot     (mst9_slv12_hprot  ),
	.mst9_hsize     (mst9_slv12_hsize  ),
	.mst9_htrans    (mst9_slv12_htrans ),
	.mst9_hwrite    (mst9_slv12_hwrite ),
	.mst9_req       (mst9_slv12_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv12_hwdata ),
	.mst10_ack      (mst10_slv12_ack   ),
	.mst10_haddr    (mst10_slv12_haddr ),
	.mst10_hburst   (mst10_slv12_hburst),
	.mst10_hprot    (mst10_slv12_hprot ),
	.mst10_hsize    (mst10_slv12_hsize ),
	.mst10_htrans   (mst10_slv12_htrans),
	.mst10_hwrite   (mst10_slv12_hwrite),
	.mst10_req      (mst10_slv12_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv12_hwdata ),
	.mst11_ack      (mst11_slv12_ack   ),
	.mst11_haddr    (mst11_slv12_haddr ),
	.mst11_hburst   (mst11_slv12_hburst),
	.mst11_hprot    (mst11_slv12_hprot ),
	.mst11_hsize    (mst11_slv12_hsize ),
	.mst11_htrans   (mst11_slv12_htrans),
	.mst11_hwrite   (mst11_slv12_hwrite),
	.mst11_req      (mst11_slv12_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv12_hwdata ),
	.mst12_ack      (mst12_slv12_ack   ),
	.mst12_haddr    (mst12_slv12_haddr ),
	.mst12_hburst   (mst12_slv12_hburst),
	.mst12_hprot    (mst12_slv12_hprot ),
	.mst12_hsize    (mst12_slv12_hsize ),
	.mst12_htrans   (mst12_slv12_htrans),
	.mst12_hwrite   (mst12_slv12_hwrite),
	.mst12_req      (mst12_slv12_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv12_hwdata ),
	.mst13_ack      (mst13_slv12_ack   ),
	.mst13_haddr    (mst13_slv12_haddr ),
	.mst13_hburst   (mst13_slv12_hburst),
	.mst13_hprot    (mst13_slv12_hprot ),
	.mst13_hsize    (mst13_slv12_hsize ),
	.mst13_htrans   (mst13_slv12_htrans),
	.mst13_hwrite   (mst13_slv12_hwrite),
	.mst13_req      (mst13_slv12_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv12_hwdata ),
	.mst14_ack      (mst14_slv12_ack   ),
	.mst14_haddr    (mst14_slv12_haddr ),
	.mst14_hburst   (mst14_slv12_hburst),
	.mst14_hprot    (mst14_slv12_hprot ),
	.mst14_hsize    (mst14_slv12_hsize ),
	.mst14_htrans   (mst14_slv12_htrans),
	.mst14_hwrite   (mst14_slv12_hwrite),
	.mst14_req      (mst14_slv12_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv12_hwdata ),
	.mst15_ack      (mst15_slv12_ack   ),
	.mst15_haddr    (mst15_slv12_haddr ),
	.mst15_hburst   (mst15_slv12_hburst),
	.mst15_hprot    (mst15_slv12_hprot ),
	.mst15_hsize    (mst15_slv12_hsize ),
	.mst15_htrans   (mst15_slv12_htrans),
	.mst15_hwrite   (mst15_slv12_hwrite),
	.mst15_req      (mst15_slv12_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs12_hready   ),
	.hclk           (hclk              ),
	.hresetn        (hresetn           ),
	.hs_bmc_hready  (hs12_bmc_hready   ),
	.hs_haddr       (hs12_haddr        ),
	.hs_hburst      (hs12_hburst       ),
	.hs_hprot       (hs12_hprot        ),
	.hs_hresp       (hs12_hresp        ),
	.hs_hsel        (hs12_hsel         ),
	.hs_hsize       (hs12_hsize        ),
	.hs_htrans      (hs12_htrans       ),
	.hs_hwdata      (hs12_hwdata       ),
	.hs_hwrite      (hs12_hwrite       ),
	.init_priority  (init_priority     ),
	.mst0_highest_en(mst0_highest_en   )
);

`endif
`ifdef ATCBMC200_AHB_SLV13
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander13 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv13_hwdata  ),
	.mst0_ack       (mst0_slv13_ack    ),
	.mst0_haddr     (mst0_slv13_haddr  ),
	.mst0_hburst    (mst0_slv13_hburst ),
	.mst0_hprot     (mst0_slv13_hprot  ),
	.mst0_hsize     (mst0_slv13_hsize  ),
	.mst0_htrans    (mst0_slv13_htrans ),
	.mst0_hwrite    (mst0_slv13_hwrite ),
	.mst0_req       (mst0_slv13_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv13_hwdata  ),
	.mst1_ack       (mst1_slv13_ack    ),
	.mst1_haddr     (mst1_slv13_haddr  ),
	.mst1_hburst    (mst1_slv13_hburst ),
	.mst1_hprot     (mst1_slv13_hprot  ),
	.mst1_hsize     (mst1_slv13_hsize  ),
	.mst1_htrans    (mst1_slv13_htrans ),
	.mst1_hwrite    (mst1_slv13_hwrite ),
	.mst1_req       (mst1_slv13_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv13_hwdata  ),
	.mst2_ack       (mst2_slv13_ack    ),
	.mst2_haddr     (mst2_slv13_haddr  ),
	.mst2_hburst    (mst2_slv13_hburst ),
	.mst2_hprot     (mst2_slv13_hprot  ),
	.mst2_hsize     (mst2_slv13_hsize  ),
	.mst2_htrans    (mst2_slv13_htrans ),
	.mst2_hwrite    (mst2_slv13_hwrite ),
	.mst2_req       (mst2_slv13_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv13_hwdata  ),
	.mst3_ack       (mst3_slv13_ack    ),
	.mst3_haddr     (mst3_slv13_haddr  ),
	.mst3_hburst    (mst3_slv13_hburst ),
	.mst3_hprot     (mst3_slv13_hprot  ),
	.mst3_hsize     (mst3_slv13_hsize  ),
	.mst3_htrans    (mst3_slv13_htrans ),
	.mst3_hwrite    (mst3_slv13_hwrite ),
	.mst3_req       (mst3_slv13_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv13_hwdata  ),
	.mst4_ack       (mst4_slv13_ack    ),
	.mst4_haddr     (mst4_slv13_haddr  ),
	.mst4_hburst    (mst4_slv13_hburst ),
	.mst4_hprot     (mst4_slv13_hprot  ),
	.mst4_hsize     (mst4_slv13_hsize  ),
	.mst4_htrans    (mst4_slv13_htrans ),
	.mst4_hwrite    (mst4_slv13_hwrite ),
	.mst4_req       (mst4_slv13_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv13_hwdata  ),
	.mst5_ack       (mst5_slv13_ack    ),
	.mst5_haddr     (mst5_slv13_haddr  ),
	.mst5_hburst    (mst5_slv13_hburst ),
	.mst5_hprot     (mst5_slv13_hprot  ),
	.mst5_hsize     (mst5_slv13_hsize  ),
	.mst5_htrans    (mst5_slv13_htrans ),
	.mst5_hwrite    (mst5_slv13_hwrite ),
	.mst5_req       (mst5_slv13_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv13_hwdata  ),
	.mst6_ack       (mst6_slv13_ack    ),
	.mst6_haddr     (mst6_slv13_haddr  ),
	.mst6_hburst    (mst6_slv13_hburst ),
	.mst6_hprot     (mst6_slv13_hprot  ),
	.mst6_hsize     (mst6_slv13_hsize  ),
	.mst6_htrans    (mst6_slv13_htrans ),
	.mst6_hwrite    (mst6_slv13_hwrite ),
	.mst6_req       (mst6_slv13_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv13_hwdata  ),
	.mst7_ack       (mst7_slv13_ack    ),
	.mst7_haddr     (mst7_slv13_haddr  ),
	.mst7_hburst    (mst7_slv13_hburst ),
	.mst7_hprot     (mst7_slv13_hprot  ),
	.mst7_hsize     (mst7_slv13_hsize  ),
	.mst7_htrans    (mst7_slv13_htrans ),
	.mst7_hwrite    (mst7_slv13_hwrite ),
	.mst7_req       (mst7_slv13_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv13_hwdata  ),
	.mst8_ack       (mst8_slv13_ack    ),
	.mst8_haddr     (mst8_slv13_haddr  ),
	.mst8_hburst    (mst8_slv13_hburst ),
	.mst8_hprot     (mst8_slv13_hprot  ),
	.mst8_hsize     (mst8_slv13_hsize  ),
	.mst8_htrans    (mst8_slv13_htrans ),
	.mst8_hwrite    (mst8_slv13_hwrite ),
	.mst8_req       (mst8_slv13_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv13_hwdata  ),
	.mst9_ack       (mst9_slv13_ack    ),
	.mst9_haddr     (mst9_slv13_haddr  ),
	.mst9_hburst    (mst9_slv13_hburst ),
	.mst9_hprot     (mst9_slv13_hprot  ),
	.mst9_hsize     (mst9_slv13_hsize  ),
	.mst9_htrans    (mst9_slv13_htrans ),
	.mst9_hwrite    (mst9_slv13_hwrite ),
	.mst9_req       (mst9_slv13_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv13_hwdata ),
	.mst10_ack      (mst10_slv13_ack   ),
	.mst10_haddr    (mst10_slv13_haddr ),
	.mst10_hburst   (mst10_slv13_hburst),
	.mst10_hprot    (mst10_slv13_hprot ),
	.mst10_hsize    (mst10_slv13_hsize ),
	.mst10_htrans   (mst10_slv13_htrans),
	.mst10_hwrite   (mst10_slv13_hwrite),
	.mst10_req      (mst10_slv13_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv13_hwdata ),
	.mst11_ack      (mst11_slv13_ack   ),
	.mst11_haddr    (mst11_slv13_haddr ),
	.mst11_hburst   (mst11_slv13_hburst),
	.mst11_hprot    (mst11_slv13_hprot ),
	.mst11_hsize    (mst11_slv13_hsize ),
	.mst11_htrans   (mst11_slv13_htrans),
	.mst11_hwrite   (mst11_slv13_hwrite),
	.mst11_req      (mst11_slv13_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv13_hwdata ),
	.mst12_ack      (mst12_slv13_ack   ),
	.mst12_haddr    (mst12_slv13_haddr ),
	.mst12_hburst   (mst12_slv13_hburst),
	.mst12_hprot    (mst12_slv13_hprot ),
	.mst12_hsize    (mst12_slv13_hsize ),
	.mst12_htrans   (mst12_slv13_htrans),
	.mst12_hwrite   (mst12_slv13_hwrite),
	.mst12_req      (mst12_slv13_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv13_hwdata ),
	.mst13_ack      (mst13_slv13_ack   ),
	.mst13_haddr    (mst13_slv13_haddr ),
	.mst13_hburst   (mst13_slv13_hburst),
	.mst13_hprot    (mst13_slv13_hprot ),
	.mst13_hsize    (mst13_slv13_hsize ),
	.mst13_htrans   (mst13_slv13_htrans),
	.mst13_hwrite   (mst13_slv13_hwrite),
	.mst13_req      (mst13_slv13_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv13_hwdata ),
	.mst14_ack      (mst14_slv13_ack   ),
	.mst14_haddr    (mst14_slv13_haddr ),
	.mst14_hburst   (mst14_slv13_hburst),
	.mst14_hprot    (mst14_slv13_hprot ),
	.mst14_hsize    (mst14_slv13_hsize ),
	.mst14_htrans   (mst14_slv13_htrans),
	.mst14_hwrite   (mst14_slv13_hwrite),
	.mst14_req      (mst14_slv13_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv13_hwdata ),
	.mst15_ack      (mst15_slv13_ack   ),
	.mst15_haddr    (mst15_slv13_haddr ),
	.mst15_hburst   (mst15_slv13_hburst),
	.mst15_hprot    (mst15_slv13_hprot ),
	.mst15_hsize    (mst15_slv13_hsize ),
	.mst15_htrans   (mst15_slv13_htrans),
	.mst15_hwrite   (mst15_slv13_hwrite),
	.mst15_req      (mst15_slv13_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs13_hready   ),
	.hclk           (hclk              ),
	.hresetn        (hresetn           ),
	.hs_bmc_hready  (hs13_bmc_hready   ),
	.hs_haddr       (hs13_haddr        ),
	.hs_hburst      (hs13_hburst       ),
	.hs_hprot       (hs13_hprot        ),
	.hs_hresp       (hs13_hresp        ),
	.hs_hsel        (hs13_hsel         ),
	.hs_hsize       (hs13_hsize        ),
	.hs_htrans      (hs13_htrans       ),
	.hs_hwdata      (hs13_hwdata       ),
	.hs_hwrite      (hs13_hwrite       ),
	.init_priority  (init_priority     ),
	.mst0_highest_en(mst0_highest_en   )
);

`endif
`ifdef ATCBMC200_AHB_SLV14
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander14 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv14_hwdata  ),
	.mst0_ack       (mst0_slv14_ack    ),
	.mst0_haddr     (mst0_slv14_haddr  ),
	.mst0_hburst    (mst0_slv14_hburst ),
	.mst0_hprot     (mst0_slv14_hprot  ),
	.mst0_hsize     (mst0_slv14_hsize  ),
	.mst0_htrans    (mst0_slv14_htrans ),
	.mst0_hwrite    (mst0_slv14_hwrite ),
	.mst0_req       (mst0_slv14_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv14_hwdata  ),
	.mst1_ack       (mst1_slv14_ack    ),
	.mst1_haddr     (mst1_slv14_haddr  ),
	.mst1_hburst    (mst1_slv14_hburst ),
	.mst1_hprot     (mst1_slv14_hprot  ),
	.mst1_hsize     (mst1_slv14_hsize  ),
	.mst1_htrans    (mst1_slv14_htrans ),
	.mst1_hwrite    (mst1_slv14_hwrite ),
	.mst1_req       (mst1_slv14_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv14_hwdata  ),
	.mst2_ack       (mst2_slv14_ack    ),
	.mst2_haddr     (mst2_slv14_haddr  ),
	.mst2_hburst    (mst2_slv14_hburst ),
	.mst2_hprot     (mst2_slv14_hprot  ),
	.mst2_hsize     (mst2_slv14_hsize  ),
	.mst2_htrans    (mst2_slv14_htrans ),
	.mst2_hwrite    (mst2_slv14_hwrite ),
	.mst2_req       (mst2_slv14_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv14_hwdata  ),
	.mst3_ack       (mst3_slv14_ack    ),
	.mst3_haddr     (mst3_slv14_haddr  ),
	.mst3_hburst    (mst3_slv14_hburst ),
	.mst3_hprot     (mst3_slv14_hprot  ),
	.mst3_hsize     (mst3_slv14_hsize  ),
	.mst3_htrans    (mst3_slv14_htrans ),
	.mst3_hwrite    (mst3_slv14_hwrite ),
	.mst3_req       (mst3_slv14_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv14_hwdata  ),
	.mst4_ack       (mst4_slv14_ack    ),
	.mst4_haddr     (mst4_slv14_haddr  ),
	.mst4_hburst    (mst4_slv14_hburst ),
	.mst4_hprot     (mst4_slv14_hprot  ),
	.mst4_hsize     (mst4_slv14_hsize  ),
	.mst4_htrans    (mst4_slv14_htrans ),
	.mst4_hwrite    (mst4_slv14_hwrite ),
	.mst4_req       (mst4_slv14_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv14_hwdata  ),
	.mst5_ack       (mst5_slv14_ack    ),
	.mst5_haddr     (mst5_slv14_haddr  ),
	.mst5_hburst    (mst5_slv14_hburst ),
	.mst5_hprot     (mst5_slv14_hprot  ),
	.mst5_hsize     (mst5_slv14_hsize  ),
	.mst5_htrans    (mst5_slv14_htrans ),
	.mst5_hwrite    (mst5_slv14_hwrite ),
	.mst5_req       (mst5_slv14_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv14_hwdata  ),
	.mst6_ack       (mst6_slv14_ack    ),
	.mst6_haddr     (mst6_slv14_haddr  ),
	.mst6_hburst    (mst6_slv14_hburst ),
	.mst6_hprot     (mst6_slv14_hprot  ),
	.mst6_hsize     (mst6_slv14_hsize  ),
	.mst6_htrans    (mst6_slv14_htrans ),
	.mst6_hwrite    (mst6_slv14_hwrite ),
	.mst6_req       (mst6_slv14_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv14_hwdata  ),
	.mst7_ack       (mst7_slv14_ack    ),
	.mst7_haddr     (mst7_slv14_haddr  ),
	.mst7_hburst    (mst7_slv14_hburst ),
	.mst7_hprot     (mst7_slv14_hprot  ),
	.mst7_hsize     (mst7_slv14_hsize  ),
	.mst7_htrans    (mst7_slv14_htrans ),
	.mst7_hwrite    (mst7_slv14_hwrite ),
	.mst7_req       (mst7_slv14_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv14_hwdata  ),
	.mst8_ack       (mst8_slv14_ack    ),
	.mst8_haddr     (mst8_slv14_haddr  ),
	.mst8_hburst    (mst8_slv14_hburst ),
	.mst8_hprot     (mst8_slv14_hprot  ),
	.mst8_hsize     (mst8_slv14_hsize  ),
	.mst8_htrans    (mst8_slv14_htrans ),
	.mst8_hwrite    (mst8_slv14_hwrite ),
	.mst8_req       (mst8_slv14_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv14_hwdata  ),
	.mst9_ack       (mst9_slv14_ack    ),
	.mst9_haddr     (mst9_slv14_haddr  ),
	.mst9_hburst    (mst9_slv14_hburst ),
	.mst9_hprot     (mst9_slv14_hprot  ),
	.mst9_hsize     (mst9_slv14_hsize  ),
	.mst9_htrans    (mst9_slv14_htrans ),
	.mst9_hwrite    (mst9_slv14_hwrite ),
	.mst9_req       (mst9_slv14_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv14_hwdata ),
	.mst10_ack      (mst10_slv14_ack   ),
	.mst10_haddr    (mst10_slv14_haddr ),
	.mst10_hburst   (mst10_slv14_hburst),
	.mst10_hprot    (mst10_slv14_hprot ),
	.mst10_hsize    (mst10_slv14_hsize ),
	.mst10_htrans   (mst10_slv14_htrans),
	.mst10_hwrite   (mst10_slv14_hwrite),
	.mst10_req      (mst10_slv14_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv14_hwdata ),
	.mst11_ack      (mst11_slv14_ack   ),
	.mst11_haddr    (mst11_slv14_haddr ),
	.mst11_hburst   (mst11_slv14_hburst),
	.mst11_hprot    (mst11_slv14_hprot ),
	.mst11_hsize    (mst11_slv14_hsize ),
	.mst11_htrans   (mst11_slv14_htrans),
	.mst11_hwrite   (mst11_slv14_hwrite),
	.mst11_req      (mst11_slv14_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv14_hwdata ),
	.mst12_ack      (mst12_slv14_ack   ),
	.mst12_haddr    (mst12_slv14_haddr ),
	.mst12_hburst   (mst12_slv14_hburst),
	.mst12_hprot    (mst12_slv14_hprot ),
	.mst12_hsize    (mst12_slv14_hsize ),
	.mst12_htrans   (mst12_slv14_htrans),
	.mst12_hwrite   (mst12_slv14_hwrite),
	.mst12_req      (mst12_slv14_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv14_hwdata ),
	.mst13_ack      (mst13_slv14_ack   ),
	.mst13_haddr    (mst13_slv14_haddr ),
	.mst13_hburst   (mst13_slv14_hburst),
	.mst13_hprot    (mst13_slv14_hprot ),
	.mst13_hsize    (mst13_slv14_hsize ),
	.mst13_htrans   (mst13_slv14_htrans),
	.mst13_hwrite   (mst13_slv14_hwrite),
	.mst13_req      (mst13_slv14_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv14_hwdata ),
	.mst14_ack      (mst14_slv14_ack   ),
	.mst14_haddr    (mst14_slv14_haddr ),
	.mst14_hburst   (mst14_slv14_hburst),
	.mst14_hprot    (mst14_slv14_hprot ),
	.mst14_hsize    (mst14_slv14_hsize ),
	.mst14_htrans   (mst14_slv14_htrans),
	.mst14_hwrite   (mst14_slv14_hwrite),
	.mst14_req      (mst14_slv14_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv14_hwdata ),
	.mst15_ack      (mst15_slv14_ack   ),
	.mst15_haddr    (mst15_slv14_haddr ),
	.mst15_hburst   (mst15_slv14_hburst),
	.mst15_hprot    (mst15_slv14_hprot ),
	.mst15_hsize    (mst15_slv14_hsize ),
	.mst15_htrans   (mst15_slv14_htrans),
	.mst15_hwrite   (mst15_slv14_hwrite),
	.mst15_req      (mst15_slv14_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs14_hready   ),
	.hclk           (hclk              ),
	.hresetn        (hresetn           ),
	.hs_bmc_hready  (hs14_bmc_hready   ),
	.hs_haddr       (hs14_haddr        ),
	.hs_hburst      (hs14_hburst       ),
	.hs_hprot       (hs14_hprot        ),
	.hs_hresp       (hs14_hresp        ),
	.hs_hsel        (hs14_hsel         ),
	.hs_hsize       (hs14_hsize        ),
	.hs_htrans      (hs14_htrans       ),
	.hs_hwdata      (hs14_hwdata       ),
	.hs_hwrite      (hs14_hwrite       ),
	.init_priority  (init_priority     ),
	.mst0_highest_en(mst0_highest_en   )
);

`endif
`ifdef ATCBMC200_AHB_SLV15
atcbmc200_slv_commander #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_slv_commander15 (
   `ifdef ATCBMC200_AHB_MST0
	.hm0_hwdata     (hm0_slv15_hwdata  ),
	.mst0_ack       (mst0_slv15_ack    ),
	.mst0_haddr     (mst0_slv15_haddr  ),
	.mst0_hburst    (mst0_slv15_hburst ),
	.mst0_hprot     (mst0_slv15_hprot  ),
	.mst0_hsize     (mst0_slv15_hsize  ),
	.mst0_htrans    (mst0_slv15_htrans ),
	.mst0_hwrite    (mst0_slv15_hwrite ),
	.mst0_req       (mst0_slv15_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST1
	.hm1_hwdata     (hm1_slv15_hwdata  ),
	.mst1_ack       (mst1_slv15_ack    ),
	.mst1_haddr     (mst1_slv15_haddr  ),
	.mst1_hburst    (mst1_slv15_hburst ),
	.mst1_hprot     (mst1_slv15_hprot  ),
	.mst1_hsize     (mst1_slv15_hsize  ),
	.mst1_htrans    (mst1_slv15_htrans ),
	.mst1_hwrite    (mst1_slv15_hwrite ),
	.mst1_req       (mst1_slv15_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST2
	.hm2_hwdata     (hm2_slv15_hwdata  ),
	.mst2_ack       (mst2_slv15_ack    ),
	.mst2_haddr     (mst2_slv15_haddr  ),
	.mst2_hburst    (mst2_slv15_hburst ),
	.mst2_hprot     (mst2_slv15_hprot  ),
	.mst2_hsize     (mst2_slv15_hsize  ),
	.mst2_htrans    (mst2_slv15_htrans ),
	.mst2_hwrite    (mst2_slv15_hwrite ),
	.mst2_req       (mst2_slv15_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST3
	.hm3_hwdata     (hm3_slv15_hwdata  ),
	.mst3_ack       (mst3_slv15_ack    ),
	.mst3_haddr     (mst3_slv15_haddr  ),
	.mst3_hburst    (mst3_slv15_hburst ),
	.mst3_hprot     (mst3_slv15_hprot  ),
	.mst3_hsize     (mst3_slv15_hsize  ),
	.mst3_htrans    (mst3_slv15_htrans ),
	.mst3_hwrite    (mst3_slv15_hwrite ),
	.mst3_req       (mst3_slv15_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST4
	.hm4_hwdata     (hm4_slv15_hwdata  ),
	.mst4_ack       (mst4_slv15_ack    ),
	.mst4_haddr     (mst4_slv15_haddr  ),
	.mst4_hburst    (mst4_slv15_hburst ),
	.mst4_hprot     (mst4_slv15_hprot  ),
	.mst4_hsize     (mst4_slv15_hsize  ),
	.mst4_htrans    (mst4_slv15_htrans ),
	.mst4_hwrite    (mst4_slv15_hwrite ),
	.mst4_req       (mst4_slv15_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST5
	.hm5_hwdata     (hm5_slv15_hwdata  ),
	.mst5_ack       (mst5_slv15_ack    ),
	.mst5_haddr     (mst5_slv15_haddr  ),
	.mst5_hburst    (mst5_slv15_hburst ),
	.mst5_hprot     (mst5_slv15_hprot  ),
	.mst5_hsize     (mst5_slv15_hsize  ),
	.mst5_htrans    (mst5_slv15_htrans ),
	.mst5_hwrite    (mst5_slv15_hwrite ),
	.mst5_req       (mst5_slv15_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST6
	.hm6_hwdata     (hm6_slv15_hwdata  ),
	.mst6_ack       (mst6_slv15_ack    ),
	.mst6_haddr     (mst6_slv15_haddr  ),
	.mst6_hburst    (mst6_slv15_hburst ),
	.mst6_hprot     (mst6_slv15_hprot  ),
	.mst6_hsize     (mst6_slv15_hsize  ),
	.mst6_htrans    (mst6_slv15_htrans ),
	.mst6_hwrite    (mst6_slv15_hwrite ),
	.mst6_req       (mst6_slv15_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST7
	.hm7_hwdata     (hm7_slv15_hwdata  ),
	.mst7_ack       (mst7_slv15_ack    ),
	.mst7_haddr     (mst7_slv15_haddr  ),
	.mst7_hburst    (mst7_slv15_hburst ),
	.mst7_hprot     (mst7_slv15_hprot  ),
	.mst7_hsize     (mst7_slv15_hsize  ),
	.mst7_htrans    (mst7_slv15_htrans ),
	.mst7_hwrite    (mst7_slv15_hwrite ),
	.mst7_req       (mst7_slv15_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST8
	.hm8_hwdata     (hm8_slv15_hwdata  ),
	.mst8_ack       (mst8_slv15_ack    ),
	.mst8_haddr     (mst8_slv15_haddr  ),
	.mst8_hburst    (mst8_slv15_hburst ),
	.mst8_hprot     (mst8_slv15_hprot  ),
	.mst8_hsize     (mst8_slv15_hsize  ),
	.mst8_htrans    (mst8_slv15_htrans ),
	.mst8_hwrite    (mst8_slv15_hwrite ),
	.mst8_req       (mst8_slv15_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST9
	.hm9_hwdata     (hm9_slv15_hwdata  ),
	.mst9_ack       (mst9_slv15_ack    ),
	.mst9_haddr     (mst9_slv15_haddr  ),
	.mst9_hburst    (mst9_slv15_hburst ),
	.mst9_hprot     (mst9_slv15_hprot  ),
	.mst9_hsize     (mst9_slv15_hsize  ),
	.mst9_htrans    (mst9_slv15_htrans ),
	.mst9_hwrite    (mst9_slv15_hwrite ),
	.mst9_req       (mst9_slv15_req    ),
   `endif
   `ifdef ATCBMC200_AHB_MST10
	.hm10_hwdata    (hm10_slv15_hwdata ),
	.mst10_ack      (mst10_slv15_ack   ),
	.mst10_haddr    (mst10_slv15_haddr ),
	.mst10_hburst   (mst10_slv15_hburst),
	.mst10_hprot    (mst10_slv15_hprot ),
	.mst10_hsize    (mst10_slv15_hsize ),
	.mst10_htrans   (mst10_slv15_htrans),
	.mst10_hwrite   (mst10_slv15_hwrite),
	.mst10_req      (mst10_slv15_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST11
	.hm11_hwdata    (hm11_slv15_hwdata ),
	.mst11_ack      (mst11_slv15_ack   ),
	.mst11_haddr    (mst11_slv15_haddr ),
	.mst11_hburst   (mst11_slv15_hburst),
	.mst11_hprot    (mst11_slv15_hprot ),
	.mst11_hsize    (mst11_slv15_hsize ),
	.mst11_htrans   (mst11_slv15_htrans),
	.mst11_hwrite   (mst11_slv15_hwrite),
	.mst11_req      (mst11_slv15_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST12
	.hm12_hwdata    (hm12_slv15_hwdata ),
	.mst12_ack      (mst12_slv15_ack   ),
	.mst12_haddr    (mst12_slv15_haddr ),
	.mst12_hburst   (mst12_slv15_hburst),
	.mst12_hprot    (mst12_slv15_hprot ),
	.mst12_hsize    (mst12_slv15_hsize ),
	.mst12_htrans   (mst12_slv15_htrans),
	.mst12_hwrite   (mst12_slv15_hwrite),
	.mst12_req      (mst12_slv15_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST13
	.hm13_hwdata    (hm13_slv15_hwdata ),
	.mst13_ack      (mst13_slv15_ack   ),
	.mst13_haddr    (mst13_slv15_haddr ),
	.mst13_hburst   (mst13_slv15_hburst),
	.mst13_hprot    (mst13_slv15_hprot ),
	.mst13_hsize    (mst13_slv15_hsize ),
	.mst13_htrans   (mst13_slv15_htrans),
	.mst13_hwrite   (mst13_slv15_hwrite),
	.mst13_req      (mst13_slv15_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST14
	.hm14_hwdata    (hm14_slv15_hwdata ),
	.mst14_ack      (mst14_slv15_ack   ),
	.mst14_haddr    (mst14_slv15_haddr ),
	.mst14_hburst   (mst14_slv15_hburst),
	.mst14_hprot    (mst14_slv15_hprot ),
	.mst14_hsize    (mst14_slv15_hsize ),
	.mst14_htrans   (mst14_slv15_htrans),
	.mst14_hwrite   (mst14_slv15_hwrite),
	.mst14_req      (mst14_slv15_req   ),
   `endif
   `ifdef ATCBMC200_AHB_MST15
	.hm15_hwdata    (hm15_slv15_hwdata ),
	.mst15_ack      (mst15_slv15_ack   ),
	.mst15_haddr    (mst15_slv15_haddr ),
	.mst15_hburst   (mst15_slv15_hburst),
	.mst15_hprot    (mst15_slv15_hprot ),
	.mst15_hsize    (mst15_slv15_hsize ),
	.mst15_htrans   (mst15_slv15_htrans),
	.mst15_hwrite   (mst15_slv15_hwrite),
	.mst15_req      (mst15_slv15_req   ),
   `endif
	.bmc_hs_hready  (bmc_hs15_hready   ),
	.hclk           (hclk              ),
	.hresetn        (hresetn           ),
	.hs_bmc_hready  (hs15_bmc_hready   ),
	.hs_haddr       (hs15_haddr        ),
	.hs_hburst      (hs15_hburst       ),
	.hs_hprot       (hs15_hprot        ),
	.hs_hresp       (hs15_hresp        ),
	.hs_hsel        (hs15_hsel         ),
	.hs_hsize       (hs15_hsize        ),
	.hs_htrans      (hs15_htrans       ),
	.hs_hwdata      (hs15_hwdata       ),
	.hs_hwrite      (hs15_hwrite       ),
	.init_priority  (init_priority     ),
	.mst0_highest_en(mst0_highest_en   )
);

`endif
endmodule
