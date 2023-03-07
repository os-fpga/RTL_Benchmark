// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcbmc200_config.vh"
`include "atcbmc200_const.vh"


module atcbmc200_mst_commander (
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
`ifdef ATCBMC200_AHB_SLV0
	  hs0_hrdata,
	  hs0_hready,
	  hs0_hresp,
	  slv0_grant,
	  slv0_base,
	  slv0_sel,
	  slv0_size,
`endif
`ifdef ATCBMC200_AHB_SLV1
	  hs1_hrdata,
	  hs1_hready,
	  hs1_hresp,
	  slv1_grant,
	  slv1_base,
	  slv1_sel,
	  slv1_size,
`endif
`ifdef ATCBMC200_AHB_SLV2
	  hs2_hrdata,
	  hs2_hready,
	  hs2_hresp,
	  slv2_grant,
	  slv2_base,
	  slv2_sel,
	  slv2_size,
`endif
`ifdef ATCBMC200_AHB_SLV3
	  hs3_hrdata,
	  hs3_hready,
	  hs3_hresp,
	  slv3_grant,
	  slv3_base,
	  slv3_sel,
	  slv3_size,
`endif
`ifdef ATCBMC200_AHB_SLV4
	  hs4_hrdata,
	  hs4_hready,
	  hs4_hresp,
	  slv4_grant,
	  slv4_base,
	  slv4_sel,
	  slv4_size,
`endif
`ifdef ATCBMC200_AHB_SLV5
	  hs5_hrdata,
	  hs5_hready,
	  hs5_hresp,
	  slv5_grant,
	  slv5_base,
	  slv5_sel,
	  slv5_size,
`endif
`ifdef ATCBMC200_AHB_SLV6
	  hs6_hrdata,
	  hs6_hready,
	  hs6_hresp,
	  slv6_grant,
	  slv6_base,
	  slv6_sel,
	  slv6_size,
`endif
`ifdef ATCBMC200_AHB_SLV7
	  hs7_hrdata,
	  hs7_hready,
	  hs7_hresp,
	  slv7_grant,
	  slv7_base,
	  slv7_sel,
	  slv7_size,
`endif
`ifdef ATCBMC200_AHB_SLV8
	  hs8_hrdata,
	  hs8_hready,
	  hs8_hresp,
	  slv8_grant,
	  slv8_base,
	  slv8_sel,
	  slv8_size,
`endif
`ifdef ATCBMC200_AHB_SLV9
	  hs9_hrdata,
	  hs9_hready,
	  hs9_hresp,
	  slv9_grant,
	  slv9_base,
	  slv9_sel,
	  slv9_size,
`endif
`ifdef ATCBMC200_AHB_SLV10
	  hs10_hrdata,
	  hs10_hready,
	  hs10_hresp,
	  slv10_grant,
	  slv10_base,
	  slv10_sel,
	  slv10_size,
`endif
`ifdef ATCBMC200_AHB_SLV11
	  hs11_hrdata,
	  hs11_hready,
	  hs11_hresp,
	  slv11_grant,
	  slv11_base,
	  slv11_sel,
	  slv11_size,
`endif
`ifdef ATCBMC200_AHB_SLV12
	  hs12_hrdata,
	  hs12_hready,
	  hs12_hresp,
	  slv12_grant,
	  slv12_base,
	  slv12_sel,
	  slv12_size,
`endif
`ifdef ATCBMC200_AHB_SLV13
	  hs13_hrdata,
	  hs13_hready,
	  hs13_hresp,
	  slv13_grant,
	  slv13_base,
	  slv13_sel,
	  slv13_size,
`endif
`ifdef ATCBMC200_AHB_SLV14
	  hs14_hrdata,
	  hs14_hready,
	  hs14_hresp,
	  slv14_grant,
	  slv14_base,
	  slv14_sel,
	  slv14_size,
`endif
`ifdef ATCBMC200_AHB_SLV15
	  hs15_hrdata,
	  hs15_hready,
	  hs15_hresp,
	  slv15_grant,
	  slv15_base,
	  slv15_sel,
	  slv15_size,
`endif
	  ctrl_wen,
	  hclk,
	  hm_haddr,
	  hm_hburst,
	  hm_hprot,
	  hm_hrdata,
	  hm_hready,
	  hm_hresp,
	  hm_hsize,
	  hm_htrans,
	  hm_hwrite,
	  hresetn,
	  mst_haddr,
	  mst_hburst,
	  mst_hprot,
	  mst_hsize,
	  mst_htrans,
	  mst_hwrite,
	  resp_mode,
	  slv_sel_err
);

parameter ADDR_WIDTH = `ATCBMC200_ADDR_MSB + 1;
parameter DATA_WIDTH = `ATCBMC200_DATA_WIDTH;
parameter BASE_ADDR_LSB = (ADDR_WIDTH == 24) ? 10 : 20;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;

`ifdef ATCBMC200_EXT_ENABLE
input                                ahb_slv10_en;
input                                ahb_slv1_en;
input                                ahb_slv2_en;
input                                ahb_slv3_en;
input                                ahb_slv4_en;
input                                ahb_slv5_en;
input                                ahb_slv6_en;
input                                ahb_slv7_en;
input                                ahb_slv8_en;
input                                ahb_slv9_en;
`endif
`ifdef ATCBMC200_AHB_SLV0
input                   [DATA_MSB:0] hs0_hrdata;
input                                hs0_hready;
input                          [1:0] hs0_hresp;
input                                slv0_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv0_base;
output                               slv0_sel;
input                          [3:0] slv0_size;
`endif
`ifdef ATCBMC200_AHB_SLV1
input                   [DATA_MSB:0] hs1_hrdata;
input                                hs1_hready;
input                          [1:0] hs1_hresp;
input                                slv1_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv1_base;
output                               slv1_sel;
input                          [3:0] slv1_size;
`endif
`ifdef ATCBMC200_AHB_SLV2
input                   [DATA_MSB:0] hs2_hrdata;
input                                hs2_hready;
input                          [1:0] hs2_hresp;
input                                slv2_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv2_base;
output                               slv2_sel;
input                          [3:0] slv2_size;
`endif
`ifdef ATCBMC200_AHB_SLV3
input                   [DATA_MSB:0] hs3_hrdata;
input                                hs3_hready;
input                          [1:0] hs3_hresp;
input                                slv3_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv3_base;
output                               slv3_sel;
input                          [3:0] slv3_size;
`endif
`ifdef ATCBMC200_AHB_SLV4
input                   [DATA_MSB:0] hs4_hrdata;
input                                hs4_hready;
input                          [1:0] hs4_hresp;
input                                slv4_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv4_base;
output                               slv4_sel;
input                          [3:0] slv4_size;
`endif
`ifdef ATCBMC200_AHB_SLV5
input                   [DATA_MSB:0] hs5_hrdata;
input                                hs5_hready;
input                          [1:0] hs5_hresp;
input                                slv5_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv5_base;
output                               slv5_sel;
input                          [3:0] slv5_size;
`endif
`ifdef ATCBMC200_AHB_SLV6
input                   [DATA_MSB:0] hs6_hrdata;
input                                hs6_hready;
input                          [1:0] hs6_hresp;
input                                slv6_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv6_base;
output                               slv6_sel;
input                          [3:0] slv6_size;
`endif
`ifdef ATCBMC200_AHB_SLV7
input                   [DATA_MSB:0] hs7_hrdata;
input                                hs7_hready;
input                          [1:0] hs7_hresp;
input                                slv7_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv7_base;
output                               slv7_sel;
input                          [3:0] slv7_size;
`endif
`ifdef ATCBMC200_AHB_SLV8
input                   [DATA_MSB:0] hs8_hrdata;
input                                hs8_hready;
input                          [1:0] hs8_hresp;
input                                slv8_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv8_base;
output                               slv8_sel;
input                          [3:0] slv8_size;
`endif
`ifdef ATCBMC200_AHB_SLV9
input                   [DATA_MSB:0] hs9_hrdata;
input                                hs9_hready;
input                          [1:0] hs9_hresp;
input                                slv9_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv9_base;
output                               slv9_sel;
input                          [3:0] slv9_size;
`endif
`ifdef ATCBMC200_AHB_SLV10
input                   [DATA_MSB:0] hs10_hrdata;
input                                hs10_hready;
input                          [1:0] hs10_hresp;
input                                slv10_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv10_base;
output                               slv10_sel;
input                          [3:0] slv10_size;
`endif
`ifdef ATCBMC200_AHB_SLV11
input                   [DATA_MSB:0] hs11_hrdata;
input                                hs11_hready;
input                          [1:0] hs11_hresp;
input                                slv11_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv11_base;
output                               slv11_sel;
input                          [3:0] slv11_size;
`endif
`ifdef ATCBMC200_AHB_SLV12
input                   [DATA_MSB:0] hs12_hrdata;
input                                hs12_hready;
input                          [1:0] hs12_hresp;
input                                slv12_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv12_base;
output                               slv12_sel;
input                          [3:0] slv12_size;
`endif
`ifdef ATCBMC200_AHB_SLV13
input                   [DATA_MSB:0] hs13_hrdata;
input                                hs13_hready;
input                          [1:0] hs13_hresp;
input                                slv13_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv13_base;
output                               slv13_sel;
input                          [3:0] slv13_size;
`endif
`ifdef ATCBMC200_AHB_SLV14
input                   [DATA_MSB:0] hs14_hrdata;
input                                hs14_hready;
input                          [1:0] hs14_hresp;
input                                slv14_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv14_base;
output                               slv14_sel;
input                          [3:0] slv14_size;
`endif
`ifdef ATCBMC200_AHB_SLV15
input                   [DATA_MSB:0] hs15_hrdata;
input                                hs15_hready;
input                          [1:0] hs15_hresp;
input                                slv15_grant;
input       [ADDR_MSB:BASE_ADDR_LSB] slv15_base;
output                               slv15_sel;
input                          [3:0] slv15_size;
`endif
input                                ctrl_wen;
input                                hclk;
input                   [ADDR_MSB:0] hm_haddr;
input                          [2:0] hm_hburst;
input                          [3:0] hm_hprot;
output                  [DATA_MSB:0] hm_hrdata;
output                               hm_hready;
output                         [1:0] hm_hresp;
input                          [2:0] hm_hsize;
input                          [1:0] hm_htrans;
input                                hm_hwrite;
input                                hresetn;
output                  [ADDR_MSB:0] mst_haddr;
output                         [2:0] mst_hburst;
output                         [3:0] mst_hprot;
output                         [2:0] mst_hsize;
output                         [1:0] mst_htrans;
output                               mst_hwrite;
input                                resp_mode;
output                               slv_sel_err;

wire                                 dec_en;


atcbmc200_mst_decoder #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.BASE_ADDR_LSB   (BASE_ADDR_LSB   )
) u_mst_decoder (
`ifdef ATCBMC200_EXT_ENABLE
	.ahb_slv10_en(ahb_slv10_en),
	.ahb_slv1_en (ahb_slv1_en ),
	.ahb_slv2_en (ahb_slv2_en ),
	.ahb_slv3_en (ahb_slv3_en ),
	.ahb_slv4_en (ahb_slv4_en ),
	.ahb_slv5_en (ahb_slv5_en ),
	.ahb_slv6_en (ahb_slv6_en ),
	.ahb_slv7_en (ahb_slv7_en ),
	.ahb_slv8_en (ahb_slv8_en ),
	.ahb_slv9_en (ahb_slv9_en ),
`endif
`ifdef ATCBMC200_AHB_SLV0
	.slv0_sel    (slv0_sel    ),
	.slv0_base   (slv0_base   ),
	.slv0_size   (slv0_size   ),
`endif
`ifdef ATCBMC200_AHB_SLV1
	.slv1_sel    (slv1_sel    ),
	.slv1_base   (slv1_base   ),
	.slv1_size   (slv1_size   ),
`endif
`ifdef ATCBMC200_AHB_SLV2
	.slv2_sel    (slv2_sel    ),
	.slv2_base   (slv2_base   ),
	.slv2_size   (slv2_size   ),
`endif
`ifdef ATCBMC200_AHB_SLV3
	.slv3_sel    (slv3_sel    ),
	.slv3_base   (slv3_base   ),
	.slv3_size   (slv3_size   ),
`endif
`ifdef ATCBMC200_AHB_SLV4
	.slv4_sel    (slv4_sel    ),
	.slv4_base   (slv4_base   ),
	.slv4_size   (slv4_size   ),
`endif
`ifdef ATCBMC200_AHB_SLV5
	.slv5_sel    (slv5_sel    ),
	.slv5_base   (slv5_base   ),
	.slv5_size   (slv5_size   ),
`endif
`ifdef ATCBMC200_AHB_SLV6
	.slv6_sel    (slv6_sel    ),
	.slv6_base   (slv6_base   ),
	.slv6_size   (slv6_size   ),
`endif
`ifdef ATCBMC200_AHB_SLV7
	.slv7_sel    (slv7_sel    ),
	.slv7_base   (slv7_base   ),
	.slv7_size   (slv7_size   ),
`endif
`ifdef ATCBMC200_AHB_SLV8
	.slv8_sel    (slv8_sel    ),
	.slv8_base   (slv8_base   ),
	.slv8_size   (slv8_size   ),
`endif
`ifdef ATCBMC200_AHB_SLV9
	.slv9_sel    (slv9_sel    ),
	.slv9_base   (slv9_base   ),
	.slv9_size   (slv9_size   ),
`endif
`ifdef ATCBMC200_AHB_SLV10
	.slv10_sel   (slv10_sel   ),
	.slv10_base  (slv10_base  ),
	.slv10_size  (slv10_size  ),
`endif
`ifdef ATCBMC200_AHB_SLV11
	.slv11_sel   (slv11_sel   ),
	.slv11_base  (slv11_base  ),
	.slv11_size  (slv11_size  ),
`endif
`ifdef ATCBMC200_AHB_SLV12
	.slv12_sel   (slv12_sel   ),
	.slv12_base  (slv12_base  ),
	.slv12_size  (slv12_size  ),
`endif
`ifdef ATCBMC200_AHB_SLV13
	.slv13_sel   (slv13_sel   ),
	.slv13_base  (slv13_base  ),
	.slv13_size  (slv13_size  ),
`endif
`ifdef ATCBMC200_AHB_SLV14
	.slv14_sel   (slv14_sel   ),
	.slv14_base  (slv14_base  ),
	.slv14_size  (slv14_size  ),
`endif
`ifdef ATCBMC200_AHB_SLV15
	.slv15_sel   (slv15_sel   ),
	.slv15_base  (slv15_base  ),
	.slv15_size  (slv15_size  ),
`endif
	.dec_en      (dec_en      ),
	.slv_sel_err (slv_sel_err ),
	.addr        (mst_haddr   )
);

atcbmc200_mst_ctrl #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) u_mst_ctrl (
`ifdef ATCBMC200_AHB_SLV0
	.slv0_grant (slv0_grant ),
	.slv0_sel   (slv0_sel   ),
	.hs0_hready (hs0_hready ),
	.hs0_hrdata (hs0_hrdata ),
	.hs0_hresp  (hs0_hresp  ),
`endif
`ifdef ATCBMC200_AHB_SLV1
	.slv1_grant (slv1_grant ),
	.slv1_sel   (slv1_sel   ),
	.hs1_hready (hs1_hready ),
	.hs1_hrdata (hs1_hrdata ),
	.hs1_hresp  (hs1_hresp  ),
`endif
`ifdef ATCBMC200_AHB_SLV2
	.slv2_grant (slv2_grant ),
	.slv2_sel   (slv2_sel   ),
	.hs2_hready (hs2_hready ),
	.hs2_hrdata (hs2_hrdata ),
	.hs2_hresp  (hs2_hresp  ),
`endif
`ifdef ATCBMC200_AHB_SLV3
	.slv3_grant (slv3_grant ),
	.slv3_sel   (slv3_sel   ),
	.hs3_hready (hs3_hready ),
	.hs3_hrdata (hs3_hrdata ),
	.hs3_hresp  (hs3_hresp  ),
`endif
`ifdef ATCBMC200_AHB_SLV4
	.slv4_grant (slv4_grant ),
	.slv4_sel   (slv4_sel   ),
	.hs4_hready (hs4_hready ),
	.hs4_hrdata (hs4_hrdata ),
	.hs4_hresp  (hs4_hresp  ),
`endif
`ifdef ATCBMC200_AHB_SLV5
	.slv5_grant (slv5_grant ),
	.slv5_sel   (slv5_sel   ),
	.hs5_hready (hs5_hready ),
	.hs5_hrdata (hs5_hrdata ),
	.hs5_hresp  (hs5_hresp  ),
`endif
`ifdef ATCBMC200_AHB_SLV6
	.slv6_grant (slv6_grant ),
	.slv6_sel   (slv6_sel   ),
	.hs6_hready (hs6_hready ),
	.hs6_hrdata (hs6_hrdata ),
	.hs6_hresp  (hs6_hresp  ),
`endif
`ifdef ATCBMC200_AHB_SLV7
	.slv7_grant (slv7_grant ),
	.slv7_sel   (slv7_sel   ),
	.hs7_hready (hs7_hready ),
	.hs7_hrdata (hs7_hrdata ),
	.hs7_hresp  (hs7_hresp  ),
`endif
`ifdef ATCBMC200_AHB_SLV8
	.slv8_grant (slv8_grant ),
	.slv8_sel   (slv8_sel   ),
	.hs8_hready (hs8_hready ),
	.hs8_hrdata (hs8_hrdata ),
	.hs8_hresp  (hs8_hresp  ),
`endif
`ifdef ATCBMC200_AHB_SLV9
	.slv9_grant (slv9_grant ),
	.slv9_sel   (slv9_sel   ),
	.hs9_hready (hs9_hready ),
	.hs9_hrdata (hs9_hrdata ),
	.hs9_hresp  (hs9_hresp  ),
`endif
`ifdef ATCBMC200_AHB_SLV10
	.slv10_grant(slv10_grant),
	.slv10_sel  (slv10_sel  ),
	.hs10_hready(hs10_hready),
	.hs10_hrdata(hs10_hrdata),
	.hs10_hresp (hs10_hresp ),
`endif
`ifdef ATCBMC200_AHB_SLV11
	.slv11_grant(slv11_grant),
	.slv11_sel  (slv11_sel  ),
	.hs11_hready(hs11_hready),
	.hs11_hrdata(hs11_hrdata),
	.hs11_hresp (hs11_hresp ),
`endif
`ifdef ATCBMC200_AHB_SLV12
	.slv12_grant(slv12_grant),
	.slv12_sel  (slv12_sel  ),
	.hs12_hready(hs12_hready),
	.hs12_hrdata(hs12_hrdata),
	.hs12_hresp (hs12_hresp ),
`endif
`ifdef ATCBMC200_AHB_SLV13
	.slv13_grant(slv13_grant),
	.slv13_sel  (slv13_sel  ),
	.hs13_hready(hs13_hready),
	.hs13_hrdata(hs13_hrdata),
	.hs13_hresp (hs13_hresp ),
`endif
`ifdef ATCBMC200_AHB_SLV14
	.slv14_grant(slv14_grant),
	.slv14_sel  (slv14_sel  ),
	.hs14_hready(hs14_hready),
	.hs14_hrdata(hs14_hrdata),
	.hs14_hresp (hs14_hresp ),
`endif
`ifdef ATCBMC200_AHB_SLV15
	.slv15_grant(slv15_grant),
	.slv15_sel  (slv15_sel  ),
	.hs15_hready(hs15_hready),
	.hs15_hrdata(hs15_hrdata),
	.hs15_hresp (hs15_hresp ),
`endif
	.hclk       (hclk       ),
	.hresetn    (hresetn    ),
	.hm_htrans  (hm_htrans  ),
	.hm_haddr   (hm_haddr   ),
	.hm_hburst  (hm_hburst  ),
	.hm_hprot   (hm_hprot   ),
	.hm_hsize   (hm_hsize   ),
	.hm_hwrite  (hm_hwrite  ),
	.hm_hrdata  (hm_hrdata  ),
	.hm_hready  (hm_hready  ),
	.hm_hresp   (hm_hresp   ),
	.ctrl_wen   (ctrl_wen   ),
	.resp_mode  (resp_mode  ),
	.slv_sel_err(slv_sel_err),
	.dec_en     (dec_en     ),
	.mst_haddr  (mst_haddr  ),
	.mst_hburst (mst_hburst ),
	.mst_hprot  (mst_hprot  ),
	.mst_hsize  (mst_hsize  ),
	.mst_hwrite (mst_hwrite ),
	.mst_htrans (mst_htrans )
);

endmodule
