// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcbmc200_config.vh"
`include "atcbmc200_const.vh"


module atcbmc200_mux (
`ifdef ATCBMC200_AHB_MST0
	  hm0_hwdata,
	  mst0_haddr,
	  mst0_hburst,
	  mst0_hprot,
	  mst0_hsize,
	  mst0_htrans,
	  mst0_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST1
	  hm1_hwdata,
	  mst1_haddr,
	  mst1_hburst,
	  mst1_hprot,
	  mst1_hsize,
	  mst1_htrans,
	  mst1_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST2
	  hm2_hwdata,
	  mst2_haddr,
	  mst2_hburst,
	  mst2_hprot,
	  mst2_hsize,
	  mst2_htrans,
	  mst2_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST3
	  hm3_hwdata,
	  mst3_haddr,
	  mst3_hburst,
	  mst3_hprot,
	  mst3_hsize,
	  mst3_htrans,
	  mst3_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST4
	  hm4_hwdata,
	  mst4_haddr,
	  mst4_hburst,
	  mst4_hprot,
	  mst4_hsize,
	  mst4_htrans,
	  mst4_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST5
	  hm5_hwdata,
	  mst5_haddr,
	  mst5_hburst,
	  mst5_hprot,
	  mst5_hsize,
	  mst5_htrans,
	  mst5_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST6
	  hm6_hwdata,
	  mst6_haddr,
	  mst6_hburst,
	  mst6_hprot,
	  mst6_hsize,
	  mst6_htrans,
	  mst6_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST7
	  hm7_hwdata,
	  mst7_haddr,
	  mst7_hburst,
	  mst7_hprot,
	  mst7_hsize,
	  mst7_htrans,
	  mst7_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST8
	  hm8_hwdata,
	  mst8_haddr,
	  mst8_hburst,
	  mst8_hprot,
	  mst8_hsize,
	  mst8_htrans,
	  mst8_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST9
	  hm9_hwdata,
	  mst9_haddr,
	  mst9_hburst,
	  mst9_hprot,
	  mst9_hsize,
	  mst9_htrans,
	  mst9_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST10
	  hm10_hwdata,
	  mst10_haddr,
	  mst10_hburst,
	  mst10_hprot,
	  mst10_hsize,
	  mst10_htrans,
	  mst10_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST11
	  hm11_hwdata,
	  mst11_haddr,
	  mst11_hburst,
	  mst11_hprot,
	  mst11_hsize,
	  mst11_htrans,
	  mst11_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST12
	  hm12_hwdata,
	  mst12_haddr,
	  mst12_hburst,
	  mst12_hprot,
	  mst12_hsize,
	  mst12_htrans,
	  mst12_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST13
	  hm13_hwdata,
	  mst13_haddr,
	  mst13_hburst,
	  mst13_hprot,
	  mst13_hsize,
	  mst13_htrans,
	  mst13_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST14
	  hm14_hwdata,
	  mst14_haddr,
	  mst14_hburst,
	  mst14_hprot,
	  mst14_hsize,
	  mst14_htrans,
	  mst14_hwrite,
`endif
`ifdef ATCBMC200_AHB_MST15
	  hm15_hwdata,
	  mst15_haddr,
	  mst15_hburst,
	  mst15_hprot,
	  mst15_hsize,
	  mst15_htrans,
	  mst15_hwrite,
`endif
`ifdef ATCBMC200_AHB_SLV1
	  hs1_hrdata,
	  hs1_hready,
	  hs1_hresp,
	  slv1_base,
	  slv1_size,
`endif
`ifdef ATCBMC200_AHB_SLV2
	  hs2_hrdata,
	  hs2_hready,
	  hs2_hresp,
	  slv2_base,
	  slv2_size,
`endif
`ifdef ATCBMC200_AHB_SLV3
	  hs3_hrdata,
	  hs3_hready,
	  hs3_hresp,
	  slv3_base,
	  slv3_size,
`endif
`ifdef ATCBMC200_AHB_SLV4
	  hs4_hrdata,
	  hs4_hready,
	  hs4_hresp,
	  slv4_base,
	  slv4_size,
`endif
`ifdef ATCBMC200_AHB_SLV5
	  hs5_hrdata,
	  hs5_hready,
	  hs5_hresp,
	  slv5_base,
	  slv5_size,
`endif
`ifdef ATCBMC200_AHB_SLV6
	  hs6_hrdata,
	  hs6_hready,
	  hs6_hresp,
	  slv6_base,
	  slv6_size,
`endif
`ifdef ATCBMC200_AHB_SLV7
	  hs7_hrdata,
	  hs7_hready,
	  hs7_hresp,
	  slv7_base,
	  slv7_size,
`endif
`ifdef ATCBMC200_AHB_SLV8
	  hs8_hrdata,
	  hs8_hready,
	  hs8_hresp,
	  slv8_base,
	  slv8_size,
`endif
`ifdef ATCBMC200_AHB_SLV9
	  hs9_hrdata,
	  hs9_hready,
	  hs9_hresp,
	  slv9_base,
	  slv9_size,
`endif
`ifdef ATCBMC200_AHB_SLV10
	  hs10_hrdata,
	  hs10_hready,
	  hs10_hresp,
	  slv10_base,
	  slv10_size,
`endif
`ifdef ATCBMC200_AHB_SLV11
	  hs11_hrdata,
	  hs11_hready,
	  hs11_hresp,
	  slv11_base,
	  slv11_size,
`endif
`ifdef ATCBMC200_AHB_SLV12
	  hs12_hrdata,
	  hs12_hready,
	  hs12_hresp,
	  slv12_base,
	  slv12_size,
`endif
`ifdef ATCBMC200_AHB_SLV13
	  hs13_hrdata,
	  hs13_hready,
	  hs13_hresp,
	  slv13_base,
	  slv13_size,
`endif
`ifdef ATCBMC200_AHB_SLV14
	  hs14_hrdata,
	  hs14_hready,
	  hs14_hresp,
	  slv14_base,
	  slv14_size,
`endif
`ifdef ATCBMC200_AHB_SLV15
	  hs15_hrdata,
	  hs15_hready,
	  hs15_hresp,
	  slv15_base,
	  slv15_size,
`endif
`ifdef ATCBMC200_AHB_MST0
   `ifdef ATCBMC200_AHB_SLV0
	  hm0_slv0_hwdata,
	  mst0_hs0_hrdata,
	  mst0_hs0_hready,
	  mst0_hs0_hresp,
	  mst0_slv0_ack,
	  mst0_slv0_base,
	  mst0_slv0_grant,
	  mst0_slv0_haddr,
	  mst0_slv0_hburst,
	  mst0_slv0_hprot,
	  mst0_slv0_hsize,
	  mst0_slv0_htrans,
	  mst0_slv0_hwrite,
	  mst0_slv0_req,
	  mst0_slv0_sel,
	  mst0_slv0_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV1
	  hm0_slv1_hwdata,
	  mst0_hs1_hrdata,
	  mst0_hs1_hready,
	  mst0_hs1_hresp,
	  mst0_slv1_ack,
	  mst0_slv1_base,
	  mst0_slv1_grant,
	  mst0_slv1_haddr,
	  mst0_slv1_hburst,
	  mst0_slv1_hprot,
	  mst0_slv1_hsize,
	  mst0_slv1_htrans,
	  mst0_slv1_hwrite,
	  mst0_slv1_req,
	  mst0_slv1_sel,
	  mst0_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm0_slv2_hwdata,
	  mst0_hs2_hrdata,
	  mst0_hs2_hready,
	  mst0_hs2_hresp,
	  mst0_slv2_ack,
	  mst0_slv2_base,
	  mst0_slv2_grant,
	  mst0_slv2_haddr,
	  mst0_slv2_hburst,
	  mst0_slv2_hprot,
	  mst0_slv2_hsize,
	  mst0_slv2_htrans,
	  mst0_slv2_hwrite,
	  mst0_slv2_req,
	  mst0_slv2_sel,
	  mst0_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm0_slv3_hwdata,
	  mst0_hs3_hrdata,
	  mst0_hs3_hready,
	  mst0_hs3_hresp,
	  mst0_slv3_ack,
	  mst0_slv3_base,
	  mst0_slv3_grant,
	  mst0_slv3_haddr,
	  mst0_slv3_hburst,
	  mst0_slv3_hprot,
	  mst0_slv3_hsize,
	  mst0_slv3_htrans,
	  mst0_slv3_hwrite,
	  mst0_slv3_req,
	  mst0_slv3_sel,
	  mst0_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm0_slv4_hwdata,
	  mst0_hs4_hrdata,
	  mst0_hs4_hready,
	  mst0_hs4_hresp,
	  mst0_slv4_ack,
	  mst0_slv4_base,
	  mst0_slv4_grant,
	  mst0_slv4_haddr,
	  mst0_slv4_hburst,
	  mst0_slv4_hprot,
	  mst0_slv4_hsize,
	  mst0_slv4_htrans,
	  mst0_slv4_hwrite,
	  mst0_slv4_req,
	  mst0_slv4_sel,
	  mst0_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm0_slv5_hwdata,
	  mst0_hs5_hrdata,
	  mst0_hs5_hready,
	  mst0_hs5_hresp,
	  mst0_slv5_ack,
	  mst0_slv5_base,
	  mst0_slv5_grant,
	  mst0_slv5_haddr,
	  mst0_slv5_hburst,
	  mst0_slv5_hprot,
	  mst0_slv5_hsize,
	  mst0_slv5_htrans,
	  mst0_slv5_hwrite,
	  mst0_slv5_req,
	  mst0_slv5_sel,
	  mst0_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm0_slv6_hwdata,
	  mst0_hs6_hrdata,
	  mst0_hs6_hready,
	  mst0_hs6_hresp,
	  mst0_slv6_ack,
	  mst0_slv6_base,
	  mst0_slv6_grant,
	  mst0_slv6_haddr,
	  mst0_slv6_hburst,
	  mst0_slv6_hprot,
	  mst0_slv6_hsize,
	  mst0_slv6_htrans,
	  mst0_slv6_hwrite,
	  mst0_slv6_req,
	  mst0_slv6_sel,
	  mst0_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm0_slv7_hwdata,
	  mst0_hs7_hrdata,
	  mst0_hs7_hready,
	  mst0_hs7_hresp,
	  mst0_slv7_ack,
	  mst0_slv7_base,
	  mst0_slv7_grant,
	  mst0_slv7_haddr,
	  mst0_slv7_hburst,
	  mst0_slv7_hprot,
	  mst0_slv7_hsize,
	  mst0_slv7_htrans,
	  mst0_slv7_hwrite,
	  mst0_slv7_req,
	  mst0_slv7_sel,
	  mst0_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm0_slv8_hwdata,
	  mst0_hs8_hrdata,
	  mst0_hs8_hready,
	  mst0_hs8_hresp,
	  mst0_slv8_ack,
	  mst0_slv8_base,
	  mst0_slv8_grant,
	  mst0_slv8_haddr,
	  mst0_slv8_hburst,
	  mst0_slv8_hprot,
	  mst0_slv8_hsize,
	  mst0_slv8_htrans,
	  mst0_slv8_hwrite,
	  mst0_slv8_req,
	  mst0_slv8_sel,
	  mst0_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm0_slv9_hwdata,
	  mst0_hs9_hrdata,
	  mst0_hs9_hready,
	  mst0_hs9_hresp,
	  mst0_slv9_ack,
	  mst0_slv9_base,
	  mst0_slv9_grant,
	  mst0_slv9_haddr,
	  mst0_slv9_hburst,
	  mst0_slv9_hprot,
	  mst0_slv9_hsize,
	  mst0_slv9_htrans,
	  mst0_slv9_hwrite,
	  mst0_slv9_req,
	  mst0_slv9_sel,
	  mst0_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm0_slv10_hwdata,
	  mst0_hs10_hrdata,
	  mst0_hs10_hready,
	  mst0_hs10_hresp,
	  mst0_slv10_ack,
	  mst0_slv10_base,
	  mst0_slv10_grant,
	  mst0_slv10_haddr,
	  mst0_slv10_hburst,
	  mst0_slv10_hprot,
	  mst0_slv10_hsize,
	  mst0_slv10_htrans,
	  mst0_slv10_hwrite,
	  mst0_slv10_req,
	  mst0_slv10_sel,
	  mst0_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm0_slv11_hwdata,
	  mst0_hs11_hrdata,
	  mst0_hs11_hready,
	  mst0_hs11_hresp,
	  mst0_slv11_ack,
	  mst0_slv11_base,
	  mst0_slv11_grant,
	  mst0_slv11_haddr,
	  mst0_slv11_hburst,
	  mst0_slv11_hprot,
	  mst0_slv11_hsize,
	  mst0_slv11_htrans,
	  mst0_slv11_hwrite,
	  mst0_slv11_req,
	  mst0_slv11_sel,
	  mst0_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm0_slv12_hwdata,
	  mst0_hs12_hrdata,
	  mst0_hs12_hready,
	  mst0_hs12_hresp,
	  mst0_slv12_ack,
	  mst0_slv12_base,
	  mst0_slv12_grant,
	  mst0_slv12_haddr,
	  mst0_slv12_hburst,
	  mst0_slv12_hprot,
	  mst0_slv12_hsize,
	  mst0_slv12_htrans,
	  mst0_slv12_hwrite,
	  mst0_slv12_req,
	  mst0_slv12_sel,
	  mst0_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm0_slv13_hwdata,
	  mst0_hs13_hrdata,
	  mst0_hs13_hready,
	  mst0_hs13_hresp,
	  mst0_slv13_ack,
	  mst0_slv13_base,
	  mst0_slv13_grant,
	  mst0_slv13_haddr,
	  mst0_slv13_hburst,
	  mst0_slv13_hprot,
	  mst0_slv13_hsize,
	  mst0_slv13_htrans,
	  mst0_slv13_hwrite,
	  mst0_slv13_req,
	  mst0_slv13_sel,
	  mst0_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm0_slv14_hwdata,
	  mst0_hs14_hrdata,
	  mst0_hs14_hready,
	  mst0_hs14_hresp,
	  mst0_slv14_ack,
	  mst0_slv14_base,
	  mst0_slv14_grant,
	  mst0_slv14_haddr,
	  mst0_slv14_hburst,
	  mst0_slv14_hprot,
	  mst0_slv14_hsize,
	  mst0_slv14_htrans,
	  mst0_slv14_hwrite,
	  mst0_slv14_req,
	  mst0_slv14_sel,
	  mst0_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm0_slv15_hwdata,
	  mst0_hs15_hrdata,
	  mst0_hs15_hready,
	  mst0_hs15_hresp,
	  mst0_slv15_ack,
	  mst0_slv15_base,
	  mst0_slv15_grant,
	  mst0_slv15_haddr,
	  mst0_slv15_hburst,
	  mst0_slv15_hprot,
	  mst0_slv15_hsize,
	  mst0_slv15_htrans,
	  mst0_slv15_hwrite,
	  mst0_slv15_req,
	  mst0_slv15_sel,
	  mst0_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST1
	  hm1_slv0_hwdata,
	  mst1_hs0_hrdata,
	  mst1_hs0_hready,
	  mst1_hs0_hresp,
	  mst1_slv0_ack,
	  mst1_slv0_base,
	  mst1_slv0_grant,
	  mst1_slv0_haddr,
	  mst1_slv0_hburst,
	  mst1_slv0_hprot,
	  mst1_slv0_hsize,
	  mst1_slv0_htrans,
	  mst1_slv0_hwrite,
	  mst1_slv0_req,
	  mst1_slv0_sel,
	  mst1_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST1
   `ifdef ATCBMC200_AHB_SLV1
	  hm1_slv1_hwdata,
	  mst1_hs1_hrdata,
	  mst1_hs1_hready,
	  mst1_hs1_hresp,
	  mst1_slv1_ack,
	  mst1_slv1_base,
	  mst1_slv1_grant,
	  mst1_slv1_haddr,
	  mst1_slv1_hburst,
	  mst1_slv1_hprot,
	  mst1_slv1_hsize,
	  mst1_slv1_htrans,
	  mst1_slv1_hwrite,
	  mst1_slv1_req,
	  mst1_slv1_sel,
	  mst1_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm1_slv2_hwdata,
	  mst1_hs2_hrdata,
	  mst1_hs2_hready,
	  mst1_hs2_hresp,
	  mst1_slv2_ack,
	  mst1_slv2_base,
	  mst1_slv2_grant,
	  mst1_slv2_haddr,
	  mst1_slv2_hburst,
	  mst1_slv2_hprot,
	  mst1_slv2_hsize,
	  mst1_slv2_htrans,
	  mst1_slv2_hwrite,
	  mst1_slv2_req,
	  mst1_slv2_sel,
	  mst1_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm1_slv3_hwdata,
	  mst1_hs3_hrdata,
	  mst1_hs3_hready,
	  mst1_hs3_hresp,
	  mst1_slv3_ack,
	  mst1_slv3_base,
	  mst1_slv3_grant,
	  mst1_slv3_haddr,
	  mst1_slv3_hburst,
	  mst1_slv3_hprot,
	  mst1_slv3_hsize,
	  mst1_slv3_htrans,
	  mst1_slv3_hwrite,
	  mst1_slv3_req,
	  mst1_slv3_sel,
	  mst1_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm1_slv4_hwdata,
	  mst1_hs4_hrdata,
	  mst1_hs4_hready,
	  mst1_hs4_hresp,
	  mst1_slv4_ack,
	  mst1_slv4_base,
	  mst1_slv4_grant,
	  mst1_slv4_haddr,
	  mst1_slv4_hburst,
	  mst1_slv4_hprot,
	  mst1_slv4_hsize,
	  mst1_slv4_htrans,
	  mst1_slv4_hwrite,
	  mst1_slv4_req,
	  mst1_slv4_sel,
	  mst1_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm1_slv5_hwdata,
	  mst1_hs5_hrdata,
	  mst1_hs5_hready,
	  mst1_hs5_hresp,
	  mst1_slv5_ack,
	  mst1_slv5_base,
	  mst1_slv5_grant,
	  mst1_slv5_haddr,
	  mst1_slv5_hburst,
	  mst1_slv5_hprot,
	  mst1_slv5_hsize,
	  mst1_slv5_htrans,
	  mst1_slv5_hwrite,
	  mst1_slv5_req,
	  mst1_slv5_sel,
	  mst1_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm1_slv6_hwdata,
	  mst1_hs6_hrdata,
	  mst1_hs6_hready,
	  mst1_hs6_hresp,
	  mst1_slv6_ack,
	  mst1_slv6_base,
	  mst1_slv6_grant,
	  mst1_slv6_haddr,
	  mst1_slv6_hburst,
	  mst1_slv6_hprot,
	  mst1_slv6_hsize,
	  mst1_slv6_htrans,
	  mst1_slv6_hwrite,
	  mst1_slv6_req,
	  mst1_slv6_sel,
	  mst1_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm1_slv7_hwdata,
	  mst1_hs7_hrdata,
	  mst1_hs7_hready,
	  mst1_hs7_hresp,
	  mst1_slv7_ack,
	  mst1_slv7_base,
	  mst1_slv7_grant,
	  mst1_slv7_haddr,
	  mst1_slv7_hburst,
	  mst1_slv7_hprot,
	  mst1_slv7_hsize,
	  mst1_slv7_htrans,
	  mst1_slv7_hwrite,
	  mst1_slv7_req,
	  mst1_slv7_sel,
	  mst1_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm1_slv8_hwdata,
	  mst1_hs8_hrdata,
	  mst1_hs8_hready,
	  mst1_hs8_hresp,
	  mst1_slv8_ack,
	  mst1_slv8_base,
	  mst1_slv8_grant,
	  mst1_slv8_haddr,
	  mst1_slv8_hburst,
	  mst1_slv8_hprot,
	  mst1_slv8_hsize,
	  mst1_slv8_htrans,
	  mst1_slv8_hwrite,
	  mst1_slv8_req,
	  mst1_slv8_sel,
	  mst1_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm1_slv9_hwdata,
	  mst1_hs9_hrdata,
	  mst1_hs9_hready,
	  mst1_hs9_hresp,
	  mst1_slv9_ack,
	  mst1_slv9_base,
	  mst1_slv9_grant,
	  mst1_slv9_haddr,
	  mst1_slv9_hburst,
	  mst1_slv9_hprot,
	  mst1_slv9_hsize,
	  mst1_slv9_htrans,
	  mst1_slv9_hwrite,
	  mst1_slv9_req,
	  mst1_slv9_sel,
	  mst1_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm1_slv10_hwdata,
	  mst1_hs10_hrdata,
	  mst1_hs10_hready,
	  mst1_hs10_hresp,
	  mst1_slv10_ack,
	  mst1_slv10_base,
	  mst1_slv10_grant,
	  mst1_slv10_haddr,
	  mst1_slv10_hburst,
	  mst1_slv10_hprot,
	  mst1_slv10_hsize,
	  mst1_slv10_htrans,
	  mst1_slv10_hwrite,
	  mst1_slv10_req,
	  mst1_slv10_sel,
	  mst1_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm1_slv11_hwdata,
	  mst1_hs11_hrdata,
	  mst1_hs11_hready,
	  mst1_hs11_hresp,
	  mst1_slv11_ack,
	  mst1_slv11_base,
	  mst1_slv11_grant,
	  mst1_slv11_haddr,
	  mst1_slv11_hburst,
	  mst1_slv11_hprot,
	  mst1_slv11_hsize,
	  mst1_slv11_htrans,
	  mst1_slv11_hwrite,
	  mst1_slv11_req,
	  mst1_slv11_sel,
	  mst1_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm1_slv12_hwdata,
	  mst1_hs12_hrdata,
	  mst1_hs12_hready,
	  mst1_hs12_hresp,
	  mst1_slv12_ack,
	  mst1_slv12_base,
	  mst1_slv12_grant,
	  mst1_slv12_haddr,
	  mst1_slv12_hburst,
	  mst1_slv12_hprot,
	  mst1_slv12_hsize,
	  mst1_slv12_htrans,
	  mst1_slv12_hwrite,
	  mst1_slv12_req,
	  mst1_slv12_sel,
	  mst1_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm1_slv13_hwdata,
	  mst1_hs13_hrdata,
	  mst1_hs13_hready,
	  mst1_hs13_hresp,
	  mst1_slv13_ack,
	  mst1_slv13_base,
	  mst1_slv13_grant,
	  mst1_slv13_haddr,
	  mst1_slv13_hburst,
	  mst1_slv13_hprot,
	  mst1_slv13_hsize,
	  mst1_slv13_htrans,
	  mst1_slv13_hwrite,
	  mst1_slv13_req,
	  mst1_slv13_sel,
	  mst1_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm1_slv14_hwdata,
	  mst1_hs14_hrdata,
	  mst1_hs14_hready,
	  mst1_hs14_hresp,
	  mst1_slv14_ack,
	  mst1_slv14_base,
	  mst1_slv14_grant,
	  mst1_slv14_haddr,
	  mst1_slv14_hburst,
	  mst1_slv14_hprot,
	  mst1_slv14_hsize,
	  mst1_slv14_htrans,
	  mst1_slv14_hwrite,
	  mst1_slv14_req,
	  mst1_slv14_sel,
	  mst1_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm1_slv15_hwdata,
	  mst1_hs15_hrdata,
	  mst1_hs15_hready,
	  mst1_hs15_hresp,
	  mst1_slv15_ack,
	  mst1_slv15_base,
	  mst1_slv15_grant,
	  mst1_slv15_haddr,
	  mst1_slv15_hburst,
	  mst1_slv15_hprot,
	  mst1_slv15_hsize,
	  mst1_slv15_htrans,
	  mst1_slv15_hwrite,
	  mst1_slv15_req,
	  mst1_slv15_sel,
	  mst1_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST2
	  hm2_slv0_hwdata,
	  mst2_hs0_hrdata,
	  mst2_hs0_hready,
	  mst2_hs0_hresp,
	  mst2_slv0_ack,
	  mst2_slv0_base,
	  mst2_slv0_grant,
	  mst2_slv0_haddr,
	  mst2_slv0_hburst,
	  mst2_slv0_hprot,
	  mst2_slv0_hsize,
	  mst2_slv0_htrans,
	  mst2_slv0_hwrite,
	  mst2_slv0_req,
	  mst2_slv0_sel,
	  mst2_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST2
   `ifdef ATCBMC200_AHB_SLV1
	  hm2_slv1_hwdata,
	  mst2_hs1_hrdata,
	  mst2_hs1_hready,
	  mst2_hs1_hresp,
	  mst2_slv1_ack,
	  mst2_slv1_base,
	  mst2_slv1_grant,
	  mst2_slv1_haddr,
	  mst2_slv1_hburst,
	  mst2_slv1_hprot,
	  mst2_slv1_hsize,
	  mst2_slv1_htrans,
	  mst2_slv1_hwrite,
	  mst2_slv1_req,
	  mst2_slv1_sel,
	  mst2_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm2_slv2_hwdata,
	  mst2_hs2_hrdata,
	  mst2_hs2_hready,
	  mst2_hs2_hresp,
	  mst2_slv2_ack,
	  mst2_slv2_base,
	  mst2_slv2_grant,
	  mst2_slv2_haddr,
	  mst2_slv2_hburst,
	  mst2_slv2_hprot,
	  mst2_slv2_hsize,
	  mst2_slv2_htrans,
	  mst2_slv2_hwrite,
	  mst2_slv2_req,
	  mst2_slv2_sel,
	  mst2_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm2_slv3_hwdata,
	  mst2_hs3_hrdata,
	  mst2_hs3_hready,
	  mst2_hs3_hresp,
	  mst2_slv3_ack,
	  mst2_slv3_base,
	  mst2_slv3_grant,
	  mst2_slv3_haddr,
	  mst2_slv3_hburst,
	  mst2_slv3_hprot,
	  mst2_slv3_hsize,
	  mst2_slv3_htrans,
	  mst2_slv3_hwrite,
	  mst2_slv3_req,
	  mst2_slv3_sel,
	  mst2_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm2_slv4_hwdata,
	  mst2_hs4_hrdata,
	  mst2_hs4_hready,
	  mst2_hs4_hresp,
	  mst2_slv4_ack,
	  mst2_slv4_base,
	  mst2_slv4_grant,
	  mst2_slv4_haddr,
	  mst2_slv4_hburst,
	  mst2_slv4_hprot,
	  mst2_slv4_hsize,
	  mst2_slv4_htrans,
	  mst2_slv4_hwrite,
	  mst2_slv4_req,
	  mst2_slv4_sel,
	  mst2_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm2_slv5_hwdata,
	  mst2_hs5_hrdata,
	  mst2_hs5_hready,
	  mst2_hs5_hresp,
	  mst2_slv5_ack,
	  mst2_slv5_base,
	  mst2_slv5_grant,
	  mst2_slv5_haddr,
	  mst2_slv5_hburst,
	  mst2_slv5_hprot,
	  mst2_slv5_hsize,
	  mst2_slv5_htrans,
	  mst2_slv5_hwrite,
	  mst2_slv5_req,
	  mst2_slv5_sel,
	  mst2_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm2_slv6_hwdata,
	  mst2_hs6_hrdata,
	  mst2_hs6_hready,
	  mst2_hs6_hresp,
	  mst2_slv6_ack,
	  mst2_slv6_base,
	  mst2_slv6_grant,
	  mst2_slv6_haddr,
	  mst2_slv6_hburst,
	  mst2_slv6_hprot,
	  mst2_slv6_hsize,
	  mst2_slv6_htrans,
	  mst2_slv6_hwrite,
	  mst2_slv6_req,
	  mst2_slv6_sel,
	  mst2_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm2_slv7_hwdata,
	  mst2_hs7_hrdata,
	  mst2_hs7_hready,
	  mst2_hs7_hresp,
	  mst2_slv7_ack,
	  mst2_slv7_base,
	  mst2_slv7_grant,
	  mst2_slv7_haddr,
	  mst2_slv7_hburst,
	  mst2_slv7_hprot,
	  mst2_slv7_hsize,
	  mst2_slv7_htrans,
	  mst2_slv7_hwrite,
	  mst2_slv7_req,
	  mst2_slv7_sel,
	  mst2_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm2_slv8_hwdata,
	  mst2_hs8_hrdata,
	  mst2_hs8_hready,
	  mst2_hs8_hresp,
	  mst2_slv8_ack,
	  mst2_slv8_base,
	  mst2_slv8_grant,
	  mst2_slv8_haddr,
	  mst2_slv8_hburst,
	  mst2_slv8_hprot,
	  mst2_slv8_hsize,
	  mst2_slv8_htrans,
	  mst2_slv8_hwrite,
	  mst2_slv8_req,
	  mst2_slv8_sel,
	  mst2_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm2_slv9_hwdata,
	  mst2_hs9_hrdata,
	  mst2_hs9_hready,
	  mst2_hs9_hresp,
	  mst2_slv9_ack,
	  mst2_slv9_base,
	  mst2_slv9_grant,
	  mst2_slv9_haddr,
	  mst2_slv9_hburst,
	  mst2_slv9_hprot,
	  mst2_slv9_hsize,
	  mst2_slv9_htrans,
	  mst2_slv9_hwrite,
	  mst2_slv9_req,
	  mst2_slv9_sel,
	  mst2_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm2_slv10_hwdata,
	  mst2_hs10_hrdata,
	  mst2_hs10_hready,
	  mst2_hs10_hresp,
	  mst2_slv10_ack,
	  mst2_slv10_base,
	  mst2_slv10_grant,
	  mst2_slv10_haddr,
	  mst2_slv10_hburst,
	  mst2_slv10_hprot,
	  mst2_slv10_hsize,
	  mst2_slv10_htrans,
	  mst2_slv10_hwrite,
	  mst2_slv10_req,
	  mst2_slv10_sel,
	  mst2_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm2_slv11_hwdata,
	  mst2_hs11_hrdata,
	  mst2_hs11_hready,
	  mst2_hs11_hresp,
	  mst2_slv11_ack,
	  mst2_slv11_base,
	  mst2_slv11_grant,
	  mst2_slv11_haddr,
	  mst2_slv11_hburst,
	  mst2_slv11_hprot,
	  mst2_slv11_hsize,
	  mst2_slv11_htrans,
	  mst2_slv11_hwrite,
	  mst2_slv11_req,
	  mst2_slv11_sel,
	  mst2_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm2_slv12_hwdata,
	  mst2_hs12_hrdata,
	  mst2_hs12_hready,
	  mst2_hs12_hresp,
	  mst2_slv12_ack,
	  mst2_slv12_base,
	  mst2_slv12_grant,
	  mst2_slv12_haddr,
	  mst2_slv12_hburst,
	  mst2_slv12_hprot,
	  mst2_slv12_hsize,
	  mst2_slv12_htrans,
	  mst2_slv12_hwrite,
	  mst2_slv12_req,
	  mst2_slv12_sel,
	  mst2_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm2_slv13_hwdata,
	  mst2_hs13_hrdata,
	  mst2_hs13_hready,
	  mst2_hs13_hresp,
	  mst2_slv13_ack,
	  mst2_slv13_base,
	  mst2_slv13_grant,
	  mst2_slv13_haddr,
	  mst2_slv13_hburst,
	  mst2_slv13_hprot,
	  mst2_slv13_hsize,
	  mst2_slv13_htrans,
	  mst2_slv13_hwrite,
	  mst2_slv13_req,
	  mst2_slv13_sel,
	  mst2_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm2_slv14_hwdata,
	  mst2_hs14_hrdata,
	  mst2_hs14_hready,
	  mst2_hs14_hresp,
	  mst2_slv14_ack,
	  mst2_slv14_base,
	  mst2_slv14_grant,
	  mst2_slv14_haddr,
	  mst2_slv14_hburst,
	  mst2_slv14_hprot,
	  mst2_slv14_hsize,
	  mst2_slv14_htrans,
	  mst2_slv14_hwrite,
	  mst2_slv14_req,
	  mst2_slv14_sel,
	  mst2_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm2_slv15_hwdata,
	  mst2_hs15_hrdata,
	  mst2_hs15_hready,
	  mst2_hs15_hresp,
	  mst2_slv15_ack,
	  mst2_slv15_base,
	  mst2_slv15_grant,
	  mst2_slv15_haddr,
	  mst2_slv15_hburst,
	  mst2_slv15_hprot,
	  mst2_slv15_hsize,
	  mst2_slv15_htrans,
	  mst2_slv15_hwrite,
	  mst2_slv15_req,
	  mst2_slv15_sel,
	  mst2_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST3
	  hm3_slv0_hwdata,
	  mst3_hs0_hrdata,
	  mst3_hs0_hready,
	  mst3_hs0_hresp,
	  mst3_slv0_ack,
	  mst3_slv0_base,
	  mst3_slv0_grant,
	  mst3_slv0_haddr,
	  mst3_slv0_hburst,
	  mst3_slv0_hprot,
	  mst3_slv0_hsize,
	  mst3_slv0_htrans,
	  mst3_slv0_hwrite,
	  mst3_slv0_req,
	  mst3_slv0_sel,
	  mst3_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST3
   `ifdef ATCBMC200_AHB_SLV1
	  hm3_slv1_hwdata,
	  mst3_hs1_hrdata,
	  mst3_hs1_hready,
	  mst3_hs1_hresp,
	  mst3_slv1_ack,
	  mst3_slv1_base,
	  mst3_slv1_grant,
	  mst3_slv1_haddr,
	  mst3_slv1_hburst,
	  mst3_slv1_hprot,
	  mst3_slv1_hsize,
	  mst3_slv1_htrans,
	  mst3_slv1_hwrite,
	  mst3_slv1_req,
	  mst3_slv1_sel,
	  mst3_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm3_slv2_hwdata,
	  mst3_hs2_hrdata,
	  mst3_hs2_hready,
	  mst3_hs2_hresp,
	  mst3_slv2_ack,
	  mst3_slv2_base,
	  mst3_slv2_grant,
	  mst3_slv2_haddr,
	  mst3_slv2_hburst,
	  mst3_slv2_hprot,
	  mst3_slv2_hsize,
	  mst3_slv2_htrans,
	  mst3_slv2_hwrite,
	  mst3_slv2_req,
	  mst3_slv2_sel,
	  mst3_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm3_slv3_hwdata,
	  mst3_hs3_hrdata,
	  mst3_hs3_hready,
	  mst3_hs3_hresp,
	  mst3_slv3_ack,
	  mst3_slv3_base,
	  mst3_slv3_grant,
	  mst3_slv3_haddr,
	  mst3_slv3_hburst,
	  mst3_slv3_hprot,
	  mst3_slv3_hsize,
	  mst3_slv3_htrans,
	  mst3_slv3_hwrite,
	  mst3_slv3_req,
	  mst3_slv3_sel,
	  mst3_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm3_slv4_hwdata,
	  mst3_hs4_hrdata,
	  mst3_hs4_hready,
	  mst3_hs4_hresp,
	  mst3_slv4_ack,
	  mst3_slv4_base,
	  mst3_slv4_grant,
	  mst3_slv4_haddr,
	  mst3_slv4_hburst,
	  mst3_slv4_hprot,
	  mst3_slv4_hsize,
	  mst3_slv4_htrans,
	  mst3_slv4_hwrite,
	  mst3_slv4_req,
	  mst3_slv4_sel,
	  mst3_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm3_slv5_hwdata,
	  mst3_hs5_hrdata,
	  mst3_hs5_hready,
	  mst3_hs5_hresp,
	  mst3_slv5_ack,
	  mst3_slv5_base,
	  mst3_slv5_grant,
	  mst3_slv5_haddr,
	  mst3_slv5_hburst,
	  mst3_slv5_hprot,
	  mst3_slv5_hsize,
	  mst3_slv5_htrans,
	  mst3_slv5_hwrite,
	  mst3_slv5_req,
	  mst3_slv5_sel,
	  mst3_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm3_slv6_hwdata,
	  mst3_hs6_hrdata,
	  mst3_hs6_hready,
	  mst3_hs6_hresp,
	  mst3_slv6_ack,
	  mst3_slv6_base,
	  mst3_slv6_grant,
	  mst3_slv6_haddr,
	  mst3_slv6_hburst,
	  mst3_slv6_hprot,
	  mst3_slv6_hsize,
	  mst3_slv6_htrans,
	  mst3_slv6_hwrite,
	  mst3_slv6_req,
	  mst3_slv6_sel,
	  mst3_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm3_slv7_hwdata,
	  mst3_hs7_hrdata,
	  mst3_hs7_hready,
	  mst3_hs7_hresp,
	  mst3_slv7_ack,
	  mst3_slv7_base,
	  mst3_slv7_grant,
	  mst3_slv7_haddr,
	  mst3_slv7_hburst,
	  mst3_slv7_hprot,
	  mst3_slv7_hsize,
	  mst3_slv7_htrans,
	  mst3_slv7_hwrite,
	  mst3_slv7_req,
	  mst3_slv7_sel,
	  mst3_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm3_slv8_hwdata,
	  mst3_hs8_hrdata,
	  mst3_hs8_hready,
	  mst3_hs8_hresp,
	  mst3_slv8_ack,
	  mst3_slv8_base,
	  mst3_slv8_grant,
	  mst3_slv8_haddr,
	  mst3_slv8_hburst,
	  mst3_slv8_hprot,
	  mst3_slv8_hsize,
	  mst3_slv8_htrans,
	  mst3_slv8_hwrite,
	  mst3_slv8_req,
	  mst3_slv8_sel,
	  mst3_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm3_slv9_hwdata,
	  mst3_hs9_hrdata,
	  mst3_hs9_hready,
	  mst3_hs9_hresp,
	  mst3_slv9_ack,
	  mst3_slv9_base,
	  mst3_slv9_grant,
	  mst3_slv9_haddr,
	  mst3_slv9_hburst,
	  mst3_slv9_hprot,
	  mst3_slv9_hsize,
	  mst3_slv9_htrans,
	  mst3_slv9_hwrite,
	  mst3_slv9_req,
	  mst3_slv9_sel,
	  mst3_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm3_slv10_hwdata,
	  mst3_hs10_hrdata,
	  mst3_hs10_hready,
	  mst3_hs10_hresp,
	  mst3_slv10_ack,
	  mst3_slv10_base,
	  mst3_slv10_grant,
	  mst3_slv10_haddr,
	  mst3_slv10_hburst,
	  mst3_slv10_hprot,
	  mst3_slv10_hsize,
	  mst3_slv10_htrans,
	  mst3_slv10_hwrite,
	  mst3_slv10_req,
	  mst3_slv10_sel,
	  mst3_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm3_slv11_hwdata,
	  mst3_hs11_hrdata,
	  mst3_hs11_hready,
	  mst3_hs11_hresp,
	  mst3_slv11_ack,
	  mst3_slv11_base,
	  mst3_slv11_grant,
	  mst3_slv11_haddr,
	  mst3_slv11_hburst,
	  mst3_slv11_hprot,
	  mst3_slv11_hsize,
	  mst3_slv11_htrans,
	  mst3_slv11_hwrite,
	  mst3_slv11_req,
	  mst3_slv11_sel,
	  mst3_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm3_slv12_hwdata,
	  mst3_hs12_hrdata,
	  mst3_hs12_hready,
	  mst3_hs12_hresp,
	  mst3_slv12_ack,
	  mst3_slv12_base,
	  mst3_slv12_grant,
	  mst3_slv12_haddr,
	  mst3_slv12_hburst,
	  mst3_slv12_hprot,
	  mst3_slv12_hsize,
	  mst3_slv12_htrans,
	  mst3_slv12_hwrite,
	  mst3_slv12_req,
	  mst3_slv12_sel,
	  mst3_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm3_slv13_hwdata,
	  mst3_hs13_hrdata,
	  mst3_hs13_hready,
	  mst3_hs13_hresp,
	  mst3_slv13_ack,
	  mst3_slv13_base,
	  mst3_slv13_grant,
	  mst3_slv13_haddr,
	  mst3_slv13_hburst,
	  mst3_slv13_hprot,
	  mst3_slv13_hsize,
	  mst3_slv13_htrans,
	  mst3_slv13_hwrite,
	  mst3_slv13_req,
	  mst3_slv13_sel,
	  mst3_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm3_slv14_hwdata,
	  mst3_hs14_hrdata,
	  mst3_hs14_hready,
	  mst3_hs14_hresp,
	  mst3_slv14_ack,
	  mst3_slv14_base,
	  mst3_slv14_grant,
	  mst3_slv14_haddr,
	  mst3_slv14_hburst,
	  mst3_slv14_hprot,
	  mst3_slv14_hsize,
	  mst3_slv14_htrans,
	  mst3_slv14_hwrite,
	  mst3_slv14_req,
	  mst3_slv14_sel,
	  mst3_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm3_slv15_hwdata,
	  mst3_hs15_hrdata,
	  mst3_hs15_hready,
	  mst3_hs15_hresp,
	  mst3_slv15_ack,
	  mst3_slv15_base,
	  mst3_slv15_grant,
	  mst3_slv15_haddr,
	  mst3_slv15_hburst,
	  mst3_slv15_hprot,
	  mst3_slv15_hsize,
	  mst3_slv15_htrans,
	  mst3_slv15_hwrite,
	  mst3_slv15_req,
	  mst3_slv15_sel,
	  mst3_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST4
	  hm4_slv0_hwdata,
	  mst4_hs0_hrdata,
	  mst4_hs0_hready,
	  mst4_hs0_hresp,
	  mst4_slv0_ack,
	  mst4_slv0_base,
	  mst4_slv0_grant,
	  mst4_slv0_haddr,
	  mst4_slv0_hburst,
	  mst4_slv0_hprot,
	  mst4_slv0_hsize,
	  mst4_slv0_htrans,
	  mst4_slv0_hwrite,
	  mst4_slv0_req,
	  mst4_slv0_sel,
	  mst4_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST4
   `ifdef ATCBMC200_AHB_SLV1
	  hm4_slv1_hwdata,
	  mst4_hs1_hrdata,
	  mst4_hs1_hready,
	  mst4_hs1_hresp,
	  mst4_slv1_ack,
	  mst4_slv1_base,
	  mst4_slv1_grant,
	  mst4_slv1_haddr,
	  mst4_slv1_hburst,
	  mst4_slv1_hprot,
	  mst4_slv1_hsize,
	  mst4_slv1_htrans,
	  mst4_slv1_hwrite,
	  mst4_slv1_req,
	  mst4_slv1_sel,
	  mst4_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm4_slv2_hwdata,
	  mst4_hs2_hrdata,
	  mst4_hs2_hready,
	  mst4_hs2_hresp,
	  mst4_slv2_ack,
	  mst4_slv2_base,
	  mst4_slv2_grant,
	  mst4_slv2_haddr,
	  mst4_slv2_hburst,
	  mst4_slv2_hprot,
	  mst4_slv2_hsize,
	  mst4_slv2_htrans,
	  mst4_slv2_hwrite,
	  mst4_slv2_req,
	  mst4_slv2_sel,
	  mst4_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm4_slv3_hwdata,
	  mst4_hs3_hrdata,
	  mst4_hs3_hready,
	  mst4_hs3_hresp,
	  mst4_slv3_ack,
	  mst4_slv3_base,
	  mst4_slv3_grant,
	  mst4_slv3_haddr,
	  mst4_slv3_hburst,
	  mst4_slv3_hprot,
	  mst4_slv3_hsize,
	  mst4_slv3_htrans,
	  mst4_slv3_hwrite,
	  mst4_slv3_req,
	  mst4_slv3_sel,
	  mst4_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm4_slv4_hwdata,
	  mst4_hs4_hrdata,
	  mst4_hs4_hready,
	  mst4_hs4_hresp,
	  mst4_slv4_ack,
	  mst4_slv4_base,
	  mst4_slv4_grant,
	  mst4_slv4_haddr,
	  mst4_slv4_hburst,
	  mst4_slv4_hprot,
	  mst4_slv4_hsize,
	  mst4_slv4_htrans,
	  mst4_slv4_hwrite,
	  mst4_slv4_req,
	  mst4_slv4_sel,
	  mst4_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm4_slv5_hwdata,
	  mst4_hs5_hrdata,
	  mst4_hs5_hready,
	  mst4_hs5_hresp,
	  mst4_slv5_ack,
	  mst4_slv5_base,
	  mst4_slv5_grant,
	  mst4_slv5_haddr,
	  mst4_slv5_hburst,
	  mst4_slv5_hprot,
	  mst4_slv5_hsize,
	  mst4_slv5_htrans,
	  mst4_slv5_hwrite,
	  mst4_slv5_req,
	  mst4_slv5_sel,
	  mst4_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm4_slv6_hwdata,
	  mst4_hs6_hrdata,
	  mst4_hs6_hready,
	  mst4_hs6_hresp,
	  mst4_slv6_ack,
	  mst4_slv6_base,
	  mst4_slv6_grant,
	  mst4_slv6_haddr,
	  mst4_slv6_hburst,
	  mst4_slv6_hprot,
	  mst4_slv6_hsize,
	  mst4_slv6_htrans,
	  mst4_slv6_hwrite,
	  mst4_slv6_req,
	  mst4_slv6_sel,
	  mst4_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm4_slv7_hwdata,
	  mst4_hs7_hrdata,
	  mst4_hs7_hready,
	  mst4_hs7_hresp,
	  mst4_slv7_ack,
	  mst4_slv7_base,
	  mst4_slv7_grant,
	  mst4_slv7_haddr,
	  mst4_slv7_hburst,
	  mst4_slv7_hprot,
	  mst4_slv7_hsize,
	  mst4_slv7_htrans,
	  mst4_slv7_hwrite,
	  mst4_slv7_req,
	  mst4_slv7_sel,
	  mst4_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm4_slv8_hwdata,
	  mst4_hs8_hrdata,
	  mst4_hs8_hready,
	  mst4_hs8_hresp,
	  mst4_slv8_ack,
	  mst4_slv8_base,
	  mst4_slv8_grant,
	  mst4_slv8_haddr,
	  mst4_slv8_hburst,
	  mst4_slv8_hprot,
	  mst4_slv8_hsize,
	  mst4_slv8_htrans,
	  mst4_slv8_hwrite,
	  mst4_slv8_req,
	  mst4_slv8_sel,
	  mst4_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm4_slv9_hwdata,
	  mst4_hs9_hrdata,
	  mst4_hs9_hready,
	  mst4_hs9_hresp,
	  mst4_slv9_ack,
	  mst4_slv9_base,
	  mst4_slv9_grant,
	  mst4_slv9_haddr,
	  mst4_slv9_hburst,
	  mst4_slv9_hprot,
	  mst4_slv9_hsize,
	  mst4_slv9_htrans,
	  mst4_slv9_hwrite,
	  mst4_slv9_req,
	  mst4_slv9_sel,
	  mst4_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm4_slv10_hwdata,
	  mst4_hs10_hrdata,
	  mst4_hs10_hready,
	  mst4_hs10_hresp,
	  mst4_slv10_ack,
	  mst4_slv10_base,
	  mst4_slv10_grant,
	  mst4_slv10_haddr,
	  mst4_slv10_hburst,
	  mst4_slv10_hprot,
	  mst4_slv10_hsize,
	  mst4_slv10_htrans,
	  mst4_slv10_hwrite,
	  mst4_slv10_req,
	  mst4_slv10_sel,
	  mst4_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm4_slv11_hwdata,
	  mst4_hs11_hrdata,
	  mst4_hs11_hready,
	  mst4_hs11_hresp,
	  mst4_slv11_ack,
	  mst4_slv11_base,
	  mst4_slv11_grant,
	  mst4_slv11_haddr,
	  mst4_slv11_hburst,
	  mst4_slv11_hprot,
	  mst4_slv11_hsize,
	  mst4_slv11_htrans,
	  mst4_slv11_hwrite,
	  mst4_slv11_req,
	  mst4_slv11_sel,
	  mst4_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm4_slv12_hwdata,
	  mst4_hs12_hrdata,
	  mst4_hs12_hready,
	  mst4_hs12_hresp,
	  mst4_slv12_ack,
	  mst4_slv12_base,
	  mst4_slv12_grant,
	  mst4_slv12_haddr,
	  mst4_slv12_hburst,
	  mst4_slv12_hprot,
	  mst4_slv12_hsize,
	  mst4_slv12_htrans,
	  mst4_slv12_hwrite,
	  mst4_slv12_req,
	  mst4_slv12_sel,
	  mst4_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm4_slv13_hwdata,
	  mst4_hs13_hrdata,
	  mst4_hs13_hready,
	  mst4_hs13_hresp,
	  mst4_slv13_ack,
	  mst4_slv13_base,
	  mst4_slv13_grant,
	  mst4_slv13_haddr,
	  mst4_slv13_hburst,
	  mst4_slv13_hprot,
	  mst4_slv13_hsize,
	  mst4_slv13_htrans,
	  mst4_slv13_hwrite,
	  mst4_slv13_req,
	  mst4_slv13_sel,
	  mst4_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm4_slv14_hwdata,
	  mst4_hs14_hrdata,
	  mst4_hs14_hready,
	  mst4_hs14_hresp,
	  mst4_slv14_ack,
	  mst4_slv14_base,
	  mst4_slv14_grant,
	  mst4_slv14_haddr,
	  mst4_slv14_hburst,
	  mst4_slv14_hprot,
	  mst4_slv14_hsize,
	  mst4_slv14_htrans,
	  mst4_slv14_hwrite,
	  mst4_slv14_req,
	  mst4_slv14_sel,
	  mst4_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm4_slv15_hwdata,
	  mst4_hs15_hrdata,
	  mst4_hs15_hready,
	  mst4_hs15_hresp,
	  mst4_slv15_ack,
	  mst4_slv15_base,
	  mst4_slv15_grant,
	  mst4_slv15_haddr,
	  mst4_slv15_hburst,
	  mst4_slv15_hprot,
	  mst4_slv15_hsize,
	  mst4_slv15_htrans,
	  mst4_slv15_hwrite,
	  mst4_slv15_req,
	  mst4_slv15_sel,
	  mst4_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST5
	  hm5_slv0_hwdata,
	  mst5_hs0_hrdata,
	  mst5_hs0_hready,
	  mst5_hs0_hresp,
	  mst5_slv0_ack,
	  mst5_slv0_base,
	  mst5_slv0_grant,
	  mst5_slv0_haddr,
	  mst5_slv0_hburst,
	  mst5_slv0_hprot,
	  mst5_slv0_hsize,
	  mst5_slv0_htrans,
	  mst5_slv0_hwrite,
	  mst5_slv0_req,
	  mst5_slv0_sel,
	  mst5_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST5
   `ifdef ATCBMC200_AHB_SLV1
	  hm5_slv1_hwdata,
	  mst5_hs1_hrdata,
	  mst5_hs1_hready,
	  mst5_hs1_hresp,
	  mst5_slv1_ack,
	  mst5_slv1_base,
	  mst5_slv1_grant,
	  mst5_slv1_haddr,
	  mst5_slv1_hburst,
	  mst5_slv1_hprot,
	  mst5_slv1_hsize,
	  mst5_slv1_htrans,
	  mst5_slv1_hwrite,
	  mst5_slv1_req,
	  mst5_slv1_sel,
	  mst5_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm5_slv2_hwdata,
	  mst5_hs2_hrdata,
	  mst5_hs2_hready,
	  mst5_hs2_hresp,
	  mst5_slv2_ack,
	  mst5_slv2_base,
	  mst5_slv2_grant,
	  mst5_slv2_haddr,
	  mst5_slv2_hburst,
	  mst5_slv2_hprot,
	  mst5_slv2_hsize,
	  mst5_slv2_htrans,
	  mst5_slv2_hwrite,
	  mst5_slv2_req,
	  mst5_slv2_sel,
	  mst5_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm5_slv3_hwdata,
	  mst5_hs3_hrdata,
	  mst5_hs3_hready,
	  mst5_hs3_hresp,
	  mst5_slv3_ack,
	  mst5_slv3_base,
	  mst5_slv3_grant,
	  mst5_slv3_haddr,
	  mst5_slv3_hburst,
	  mst5_slv3_hprot,
	  mst5_slv3_hsize,
	  mst5_slv3_htrans,
	  mst5_slv3_hwrite,
	  mst5_slv3_req,
	  mst5_slv3_sel,
	  mst5_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm5_slv4_hwdata,
	  mst5_hs4_hrdata,
	  mst5_hs4_hready,
	  mst5_hs4_hresp,
	  mst5_slv4_ack,
	  mst5_slv4_base,
	  mst5_slv4_grant,
	  mst5_slv4_haddr,
	  mst5_slv4_hburst,
	  mst5_slv4_hprot,
	  mst5_slv4_hsize,
	  mst5_slv4_htrans,
	  mst5_slv4_hwrite,
	  mst5_slv4_req,
	  mst5_slv4_sel,
	  mst5_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm5_slv5_hwdata,
	  mst5_hs5_hrdata,
	  mst5_hs5_hready,
	  mst5_hs5_hresp,
	  mst5_slv5_ack,
	  mst5_slv5_base,
	  mst5_slv5_grant,
	  mst5_slv5_haddr,
	  mst5_slv5_hburst,
	  mst5_slv5_hprot,
	  mst5_slv5_hsize,
	  mst5_slv5_htrans,
	  mst5_slv5_hwrite,
	  mst5_slv5_req,
	  mst5_slv5_sel,
	  mst5_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm5_slv6_hwdata,
	  mst5_hs6_hrdata,
	  mst5_hs6_hready,
	  mst5_hs6_hresp,
	  mst5_slv6_ack,
	  mst5_slv6_base,
	  mst5_slv6_grant,
	  mst5_slv6_haddr,
	  mst5_slv6_hburst,
	  mst5_slv6_hprot,
	  mst5_slv6_hsize,
	  mst5_slv6_htrans,
	  mst5_slv6_hwrite,
	  mst5_slv6_req,
	  mst5_slv6_sel,
	  mst5_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm5_slv7_hwdata,
	  mst5_hs7_hrdata,
	  mst5_hs7_hready,
	  mst5_hs7_hresp,
	  mst5_slv7_ack,
	  mst5_slv7_base,
	  mst5_slv7_grant,
	  mst5_slv7_haddr,
	  mst5_slv7_hburst,
	  mst5_slv7_hprot,
	  mst5_slv7_hsize,
	  mst5_slv7_htrans,
	  mst5_slv7_hwrite,
	  mst5_slv7_req,
	  mst5_slv7_sel,
	  mst5_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm5_slv8_hwdata,
	  mst5_hs8_hrdata,
	  mst5_hs8_hready,
	  mst5_hs8_hresp,
	  mst5_slv8_ack,
	  mst5_slv8_base,
	  mst5_slv8_grant,
	  mst5_slv8_haddr,
	  mst5_slv8_hburst,
	  mst5_slv8_hprot,
	  mst5_slv8_hsize,
	  mst5_slv8_htrans,
	  mst5_slv8_hwrite,
	  mst5_slv8_req,
	  mst5_slv8_sel,
	  mst5_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm5_slv9_hwdata,
	  mst5_hs9_hrdata,
	  mst5_hs9_hready,
	  mst5_hs9_hresp,
	  mst5_slv9_ack,
	  mst5_slv9_base,
	  mst5_slv9_grant,
	  mst5_slv9_haddr,
	  mst5_slv9_hburst,
	  mst5_slv9_hprot,
	  mst5_slv9_hsize,
	  mst5_slv9_htrans,
	  mst5_slv9_hwrite,
	  mst5_slv9_req,
	  mst5_slv9_sel,
	  mst5_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm5_slv10_hwdata,
	  mst5_hs10_hrdata,
	  mst5_hs10_hready,
	  mst5_hs10_hresp,
	  mst5_slv10_ack,
	  mst5_slv10_base,
	  mst5_slv10_grant,
	  mst5_slv10_haddr,
	  mst5_slv10_hburst,
	  mst5_slv10_hprot,
	  mst5_slv10_hsize,
	  mst5_slv10_htrans,
	  mst5_slv10_hwrite,
	  mst5_slv10_req,
	  mst5_slv10_sel,
	  mst5_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm5_slv11_hwdata,
	  mst5_hs11_hrdata,
	  mst5_hs11_hready,
	  mst5_hs11_hresp,
	  mst5_slv11_ack,
	  mst5_slv11_base,
	  mst5_slv11_grant,
	  mst5_slv11_haddr,
	  mst5_slv11_hburst,
	  mst5_slv11_hprot,
	  mst5_slv11_hsize,
	  mst5_slv11_htrans,
	  mst5_slv11_hwrite,
	  mst5_slv11_req,
	  mst5_slv11_sel,
	  mst5_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm5_slv12_hwdata,
	  mst5_hs12_hrdata,
	  mst5_hs12_hready,
	  mst5_hs12_hresp,
	  mst5_slv12_ack,
	  mst5_slv12_base,
	  mst5_slv12_grant,
	  mst5_slv12_haddr,
	  mst5_slv12_hburst,
	  mst5_slv12_hprot,
	  mst5_slv12_hsize,
	  mst5_slv12_htrans,
	  mst5_slv12_hwrite,
	  mst5_slv12_req,
	  mst5_slv12_sel,
	  mst5_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm5_slv13_hwdata,
	  mst5_hs13_hrdata,
	  mst5_hs13_hready,
	  mst5_hs13_hresp,
	  mst5_slv13_ack,
	  mst5_slv13_base,
	  mst5_slv13_grant,
	  mst5_slv13_haddr,
	  mst5_slv13_hburst,
	  mst5_slv13_hprot,
	  mst5_slv13_hsize,
	  mst5_slv13_htrans,
	  mst5_slv13_hwrite,
	  mst5_slv13_req,
	  mst5_slv13_sel,
	  mst5_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm5_slv14_hwdata,
	  mst5_hs14_hrdata,
	  mst5_hs14_hready,
	  mst5_hs14_hresp,
	  mst5_slv14_ack,
	  mst5_slv14_base,
	  mst5_slv14_grant,
	  mst5_slv14_haddr,
	  mst5_slv14_hburst,
	  mst5_slv14_hprot,
	  mst5_slv14_hsize,
	  mst5_slv14_htrans,
	  mst5_slv14_hwrite,
	  mst5_slv14_req,
	  mst5_slv14_sel,
	  mst5_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm5_slv15_hwdata,
	  mst5_hs15_hrdata,
	  mst5_hs15_hready,
	  mst5_hs15_hresp,
	  mst5_slv15_ack,
	  mst5_slv15_base,
	  mst5_slv15_grant,
	  mst5_slv15_haddr,
	  mst5_slv15_hburst,
	  mst5_slv15_hprot,
	  mst5_slv15_hsize,
	  mst5_slv15_htrans,
	  mst5_slv15_hwrite,
	  mst5_slv15_req,
	  mst5_slv15_sel,
	  mst5_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST6
	  hm6_slv0_hwdata,
	  mst6_hs0_hrdata,
	  mst6_hs0_hready,
	  mst6_hs0_hresp,
	  mst6_slv0_ack,
	  mst6_slv0_base,
	  mst6_slv0_grant,
	  mst6_slv0_haddr,
	  mst6_slv0_hburst,
	  mst6_slv0_hprot,
	  mst6_slv0_hsize,
	  mst6_slv0_htrans,
	  mst6_slv0_hwrite,
	  mst6_slv0_req,
	  mst6_slv0_sel,
	  mst6_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST6
   `ifdef ATCBMC200_AHB_SLV1
	  hm6_slv1_hwdata,
	  mst6_hs1_hrdata,
	  mst6_hs1_hready,
	  mst6_hs1_hresp,
	  mst6_slv1_ack,
	  mst6_slv1_base,
	  mst6_slv1_grant,
	  mst6_slv1_haddr,
	  mst6_slv1_hburst,
	  mst6_slv1_hprot,
	  mst6_slv1_hsize,
	  mst6_slv1_htrans,
	  mst6_slv1_hwrite,
	  mst6_slv1_req,
	  mst6_slv1_sel,
	  mst6_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm6_slv2_hwdata,
	  mst6_hs2_hrdata,
	  mst6_hs2_hready,
	  mst6_hs2_hresp,
	  mst6_slv2_ack,
	  mst6_slv2_base,
	  mst6_slv2_grant,
	  mst6_slv2_haddr,
	  mst6_slv2_hburst,
	  mst6_slv2_hprot,
	  mst6_slv2_hsize,
	  mst6_slv2_htrans,
	  mst6_slv2_hwrite,
	  mst6_slv2_req,
	  mst6_slv2_sel,
	  mst6_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm6_slv3_hwdata,
	  mst6_hs3_hrdata,
	  mst6_hs3_hready,
	  mst6_hs3_hresp,
	  mst6_slv3_ack,
	  mst6_slv3_base,
	  mst6_slv3_grant,
	  mst6_slv3_haddr,
	  mst6_slv3_hburst,
	  mst6_slv3_hprot,
	  mst6_slv3_hsize,
	  mst6_slv3_htrans,
	  mst6_slv3_hwrite,
	  mst6_slv3_req,
	  mst6_slv3_sel,
	  mst6_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm6_slv4_hwdata,
	  mst6_hs4_hrdata,
	  mst6_hs4_hready,
	  mst6_hs4_hresp,
	  mst6_slv4_ack,
	  mst6_slv4_base,
	  mst6_slv4_grant,
	  mst6_slv4_haddr,
	  mst6_slv4_hburst,
	  mst6_slv4_hprot,
	  mst6_slv4_hsize,
	  mst6_slv4_htrans,
	  mst6_slv4_hwrite,
	  mst6_slv4_req,
	  mst6_slv4_sel,
	  mst6_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm6_slv5_hwdata,
	  mst6_hs5_hrdata,
	  mst6_hs5_hready,
	  mst6_hs5_hresp,
	  mst6_slv5_ack,
	  mst6_slv5_base,
	  mst6_slv5_grant,
	  mst6_slv5_haddr,
	  mst6_slv5_hburst,
	  mst6_slv5_hprot,
	  mst6_slv5_hsize,
	  mst6_slv5_htrans,
	  mst6_slv5_hwrite,
	  mst6_slv5_req,
	  mst6_slv5_sel,
	  mst6_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm6_slv6_hwdata,
	  mst6_hs6_hrdata,
	  mst6_hs6_hready,
	  mst6_hs6_hresp,
	  mst6_slv6_ack,
	  mst6_slv6_base,
	  mst6_slv6_grant,
	  mst6_slv6_haddr,
	  mst6_slv6_hburst,
	  mst6_slv6_hprot,
	  mst6_slv6_hsize,
	  mst6_slv6_htrans,
	  mst6_slv6_hwrite,
	  mst6_slv6_req,
	  mst6_slv6_sel,
	  mst6_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm6_slv7_hwdata,
	  mst6_hs7_hrdata,
	  mst6_hs7_hready,
	  mst6_hs7_hresp,
	  mst6_slv7_ack,
	  mst6_slv7_base,
	  mst6_slv7_grant,
	  mst6_slv7_haddr,
	  mst6_slv7_hburst,
	  mst6_slv7_hprot,
	  mst6_slv7_hsize,
	  mst6_slv7_htrans,
	  mst6_slv7_hwrite,
	  mst6_slv7_req,
	  mst6_slv7_sel,
	  mst6_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm6_slv8_hwdata,
	  mst6_hs8_hrdata,
	  mst6_hs8_hready,
	  mst6_hs8_hresp,
	  mst6_slv8_ack,
	  mst6_slv8_base,
	  mst6_slv8_grant,
	  mst6_slv8_haddr,
	  mst6_slv8_hburst,
	  mst6_slv8_hprot,
	  mst6_slv8_hsize,
	  mst6_slv8_htrans,
	  mst6_slv8_hwrite,
	  mst6_slv8_req,
	  mst6_slv8_sel,
	  mst6_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm6_slv9_hwdata,
	  mst6_hs9_hrdata,
	  mst6_hs9_hready,
	  mst6_hs9_hresp,
	  mst6_slv9_ack,
	  mst6_slv9_base,
	  mst6_slv9_grant,
	  mst6_slv9_haddr,
	  mst6_slv9_hburst,
	  mst6_slv9_hprot,
	  mst6_slv9_hsize,
	  mst6_slv9_htrans,
	  mst6_slv9_hwrite,
	  mst6_slv9_req,
	  mst6_slv9_sel,
	  mst6_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm6_slv10_hwdata,
	  mst6_hs10_hrdata,
	  mst6_hs10_hready,
	  mst6_hs10_hresp,
	  mst6_slv10_ack,
	  mst6_slv10_base,
	  mst6_slv10_grant,
	  mst6_slv10_haddr,
	  mst6_slv10_hburst,
	  mst6_slv10_hprot,
	  mst6_slv10_hsize,
	  mst6_slv10_htrans,
	  mst6_slv10_hwrite,
	  mst6_slv10_req,
	  mst6_slv10_sel,
	  mst6_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm6_slv11_hwdata,
	  mst6_hs11_hrdata,
	  mst6_hs11_hready,
	  mst6_hs11_hresp,
	  mst6_slv11_ack,
	  mst6_slv11_base,
	  mst6_slv11_grant,
	  mst6_slv11_haddr,
	  mst6_slv11_hburst,
	  mst6_slv11_hprot,
	  mst6_slv11_hsize,
	  mst6_slv11_htrans,
	  mst6_slv11_hwrite,
	  mst6_slv11_req,
	  mst6_slv11_sel,
	  mst6_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm6_slv12_hwdata,
	  mst6_hs12_hrdata,
	  mst6_hs12_hready,
	  mst6_hs12_hresp,
	  mst6_slv12_ack,
	  mst6_slv12_base,
	  mst6_slv12_grant,
	  mst6_slv12_haddr,
	  mst6_slv12_hburst,
	  mst6_slv12_hprot,
	  mst6_slv12_hsize,
	  mst6_slv12_htrans,
	  mst6_slv12_hwrite,
	  mst6_slv12_req,
	  mst6_slv12_sel,
	  mst6_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm6_slv13_hwdata,
	  mst6_hs13_hrdata,
	  mst6_hs13_hready,
	  mst6_hs13_hresp,
	  mst6_slv13_ack,
	  mst6_slv13_base,
	  mst6_slv13_grant,
	  mst6_slv13_haddr,
	  mst6_slv13_hburst,
	  mst6_slv13_hprot,
	  mst6_slv13_hsize,
	  mst6_slv13_htrans,
	  mst6_slv13_hwrite,
	  mst6_slv13_req,
	  mst6_slv13_sel,
	  mst6_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm6_slv14_hwdata,
	  mst6_hs14_hrdata,
	  mst6_hs14_hready,
	  mst6_hs14_hresp,
	  mst6_slv14_ack,
	  mst6_slv14_base,
	  mst6_slv14_grant,
	  mst6_slv14_haddr,
	  mst6_slv14_hburst,
	  mst6_slv14_hprot,
	  mst6_slv14_hsize,
	  mst6_slv14_htrans,
	  mst6_slv14_hwrite,
	  mst6_slv14_req,
	  mst6_slv14_sel,
	  mst6_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm6_slv15_hwdata,
	  mst6_hs15_hrdata,
	  mst6_hs15_hready,
	  mst6_hs15_hresp,
	  mst6_slv15_ack,
	  mst6_slv15_base,
	  mst6_slv15_grant,
	  mst6_slv15_haddr,
	  mst6_slv15_hburst,
	  mst6_slv15_hprot,
	  mst6_slv15_hsize,
	  mst6_slv15_htrans,
	  mst6_slv15_hwrite,
	  mst6_slv15_req,
	  mst6_slv15_sel,
	  mst6_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST7
	  hm7_slv0_hwdata,
	  mst7_hs0_hrdata,
	  mst7_hs0_hready,
	  mst7_hs0_hresp,
	  mst7_slv0_ack,
	  mst7_slv0_base,
	  mst7_slv0_grant,
	  mst7_slv0_haddr,
	  mst7_slv0_hburst,
	  mst7_slv0_hprot,
	  mst7_slv0_hsize,
	  mst7_slv0_htrans,
	  mst7_slv0_hwrite,
	  mst7_slv0_req,
	  mst7_slv0_sel,
	  mst7_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST7
   `ifdef ATCBMC200_AHB_SLV1
	  hm7_slv1_hwdata,
	  mst7_hs1_hrdata,
	  mst7_hs1_hready,
	  mst7_hs1_hresp,
	  mst7_slv1_ack,
	  mst7_slv1_base,
	  mst7_slv1_grant,
	  mst7_slv1_haddr,
	  mst7_slv1_hburst,
	  mst7_slv1_hprot,
	  mst7_slv1_hsize,
	  mst7_slv1_htrans,
	  mst7_slv1_hwrite,
	  mst7_slv1_req,
	  mst7_slv1_sel,
	  mst7_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm7_slv2_hwdata,
	  mst7_hs2_hrdata,
	  mst7_hs2_hready,
	  mst7_hs2_hresp,
	  mst7_slv2_ack,
	  mst7_slv2_base,
	  mst7_slv2_grant,
	  mst7_slv2_haddr,
	  mst7_slv2_hburst,
	  mst7_slv2_hprot,
	  mst7_slv2_hsize,
	  mst7_slv2_htrans,
	  mst7_slv2_hwrite,
	  mst7_slv2_req,
	  mst7_slv2_sel,
	  mst7_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm7_slv3_hwdata,
	  mst7_hs3_hrdata,
	  mst7_hs3_hready,
	  mst7_hs3_hresp,
	  mst7_slv3_ack,
	  mst7_slv3_base,
	  mst7_slv3_grant,
	  mst7_slv3_haddr,
	  mst7_slv3_hburst,
	  mst7_slv3_hprot,
	  mst7_slv3_hsize,
	  mst7_slv3_htrans,
	  mst7_slv3_hwrite,
	  mst7_slv3_req,
	  mst7_slv3_sel,
	  mst7_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm7_slv4_hwdata,
	  mst7_hs4_hrdata,
	  mst7_hs4_hready,
	  mst7_hs4_hresp,
	  mst7_slv4_ack,
	  mst7_slv4_base,
	  mst7_slv4_grant,
	  mst7_slv4_haddr,
	  mst7_slv4_hburst,
	  mst7_slv4_hprot,
	  mst7_slv4_hsize,
	  mst7_slv4_htrans,
	  mst7_slv4_hwrite,
	  mst7_slv4_req,
	  mst7_slv4_sel,
	  mst7_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm7_slv5_hwdata,
	  mst7_hs5_hrdata,
	  mst7_hs5_hready,
	  mst7_hs5_hresp,
	  mst7_slv5_ack,
	  mst7_slv5_base,
	  mst7_slv5_grant,
	  mst7_slv5_haddr,
	  mst7_slv5_hburst,
	  mst7_slv5_hprot,
	  mst7_slv5_hsize,
	  mst7_slv5_htrans,
	  mst7_slv5_hwrite,
	  mst7_slv5_req,
	  mst7_slv5_sel,
	  mst7_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm7_slv6_hwdata,
	  mst7_hs6_hrdata,
	  mst7_hs6_hready,
	  mst7_hs6_hresp,
	  mst7_slv6_ack,
	  mst7_slv6_base,
	  mst7_slv6_grant,
	  mst7_slv6_haddr,
	  mst7_slv6_hburst,
	  mst7_slv6_hprot,
	  mst7_slv6_hsize,
	  mst7_slv6_htrans,
	  mst7_slv6_hwrite,
	  mst7_slv6_req,
	  mst7_slv6_sel,
	  mst7_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm7_slv7_hwdata,
	  mst7_hs7_hrdata,
	  mst7_hs7_hready,
	  mst7_hs7_hresp,
	  mst7_slv7_ack,
	  mst7_slv7_base,
	  mst7_slv7_grant,
	  mst7_slv7_haddr,
	  mst7_slv7_hburst,
	  mst7_slv7_hprot,
	  mst7_slv7_hsize,
	  mst7_slv7_htrans,
	  mst7_slv7_hwrite,
	  mst7_slv7_req,
	  mst7_slv7_sel,
	  mst7_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm7_slv8_hwdata,
	  mst7_hs8_hrdata,
	  mst7_hs8_hready,
	  mst7_hs8_hresp,
	  mst7_slv8_ack,
	  mst7_slv8_base,
	  mst7_slv8_grant,
	  mst7_slv8_haddr,
	  mst7_slv8_hburst,
	  mst7_slv8_hprot,
	  mst7_slv8_hsize,
	  mst7_slv8_htrans,
	  mst7_slv8_hwrite,
	  mst7_slv8_req,
	  mst7_slv8_sel,
	  mst7_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm7_slv9_hwdata,
	  mst7_hs9_hrdata,
	  mst7_hs9_hready,
	  mst7_hs9_hresp,
	  mst7_slv9_ack,
	  mst7_slv9_base,
	  mst7_slv9_grant,
	  mst7_slv9_haddr,
	  mst7_slv9_hburst,
	  mst7_slv9_hprot,
	  mst7_slv9_hsize,
	  mst7_slv9_htrans,
	  mst7_slv9_hwrite,
	  mst7_slv9_req,
	  mst7_slv9_sel,
	  mst7_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm7_slv10_hwdata,
	  mst7_hs10_hrdata,
	  mst7_hs10_hready,
	  mst7_hs10_hresp,
	  mst7_slv10_ack,
	  mst7_slv10_base,
	  mst7_slv10_grant,
	  mst7_slv10_haddr,
	  mst7_slv10_hburst,
	  mst7_slv10_hprot,
	  mst7_slv10_hsize,
	  mst7_slv10_htrans,
	  mst7_slv10_hwrite,
	  mst7_slv10_req,
	  mst7_slv10_sel,
	  mst7_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm7_slv11_hwdata,
	  mst7_hs11_hrdata,
	  mst7_hs11_hready,
	  mst7_hs11_hresp,
	  mst7_slv11_ack,
	  mst7_slv11_base,
	  mst7_slv11_grant,
	  mst7_slv11_haddr,
	  mst7_slv11_hburst,
	  mst7_slv11_hprot,
	  mst7_slv11_hsize,
	  mst7_slv11_htrans,
	  mst7_slv11_hwrite,
	  mst7_slv11_req,
	  mst7_slv11_sel,
	  mst7_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm7_slv12_hwdata,
	  mst7_hs12_hrdata,
	  mst7_hs12_hready,
	  mst7_hs12_hresp,
	  mst7_slv12_ack,
	  mst7_slv12_base,
	  mst7_slv12_grant,
	  mst7_slv12_haddr,
	  mst7_slv12_hburst,
	  mst7_slv12_hprot,
	  mst7_slv12_hsize,
	  mst7_slv12_htrans,
	  mst7_slv12_hwrite,
	  mst7_slv12_req,
	  mst7_slv12_sel,
	  mst7_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm7_slv13_hwdata,
	  mst7_hs13_hrdata,
	  mst7_hs13_hready,
	  mst7_hs13_hresp,
	  mst7_slv13_ack,
	  mst7_slv13_base,
	  mst7_slv13_grant,
	  mst7_slv13_haddr,
	  mst7_slv13_hburst,
	  mst7_slv13_hprot,
	  mst7_slv13_hsize,
	  mst7_slv13_htrans,
	  mst7_slv13_hwrite,
	  mst7_slv13_req,
	  mst7_slv13_sel,
	  mst7_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm7_slv14_hwdata,
	  mst7_hs14_hrdata,
	  mst7_hs14_hready,
	  mst7_hs14_hresp,
	  mst7_slv14_ack,
	  mst7_slv14_base,
	  mst7_slv14_grant,
	  mst7_slv14_haddr,
	  mst7_slv14_hburst,
	  mst7_slv14_hprot,
	  mst7_slv14_hsize,
	  mst7_slv14_htrans,
	  mst7_slv14_hwrite,
	  mst7_slv14_req,
	  mst7_slv14_sel,
	  mst7_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm7_slv15_hwdata,
	  mst7_hs15_hrdata,
	  mst7_hs15_hready,
	  mst7_hs15_hresp,
	  mst7_slv15_ack,
	  mst7_slv15_base,
	  mst7_slv15_grant,
	  mst7_slv15_haddr,
	  mst7_slv15_hburst,
	  mst7_slv15_hprot,
	  mst7_slv15_hsize,
	  mst7_slv15_htrans,
	  mst7_slv15_hwrite,
	  mst7_slv15_req,
	  mst7_slv15_sel,
	  mst7_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST8
	  hm8_slv0_hwdata,
	  mst8_hs0_hrdata,
	  mst8_hs0_hready,
	  mst8_hs0_hresp,
	  mst8_slv0_ack,
	  mst8_slv0_base,
	  mst8_slv0_grant,
	  mst8_slv0_haddr,
	  mst8_slv0_hburst,
	  mst8_slv0_hprot,
	  mst8_slv0_hsize,
	  mst8_slv0_htrans,
	  mst8_slv0_hwrite,
	  mst8_slv0_req,
	  mst8_slv0_sel,
	  mst8_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST8
   `ifdef ATCBMC200_AHB_SLV1
	  hm8_slv1_hwdata,
	  mst8_hs1_hrdata,
	  mst8_hs1_hready,
	  mst8_hs1_hresp,
	  mst8_slv1_ack,
	  mst8_slv1_base,
	  mst8_slv1_grant,
	  mst8_slv1_haddr,
	  mst8_slv1_hburst,
	  mst8_slv1_hprot,
	  mst8_slv1_hsize,
	  mst8_slv1_htrans,
	  mst8_slv1_hwrite,
	  mst8_slv1_req,
	  mst8_slv1_sel,
	  mst8_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm8_slv2_hwdata,
	  mst8_hs2_hrdata,
	  mst8_hs2_hready,
	  mst8_hs2_hresp,
	  mst8_slv2_ack,
	  mst8_slv2_base,
	  mst8_slv2_grant,
	  mst8_slv2_haddr,
	  mst8_slv2_hburst,
	  mst8_slv2_hprot,
	  mst8_slv2_hsize,
	  mst8_slv2_htrans,
	  mst8_slv2_hwrite,
	  mst8_slv2_req,
	  mst8_slv2_sel,
	  mst8_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm8_slv3_hwdata,
	  mst8_hs3_hrdata,
	  mst8_hs3_hready,
	  mst8_hs3_hresp,
	  mst8_slv3_ack,
	  mst8_slv3_base,
	  mst8_slv3_grant,
	  mst8_slv3_haddr,
	  mst8_slv3_hburst,
	  mst8_slv3_hprot,
	  mst8_slv3_hsize,
	  mst8_slv3_htrans,
	  mst8_slv3_hwrite,
	  mst8_slv3_req,
	  mst8_slv3_sel,
	  mst8_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm8_slv4_hwdata,
	  mst8_hs4_hrdata,
	  mst8_hs4_hready,
	  mst8_hs4_hresp,
	  mst8_slv4_ack,
	  mst8_slv4_base,
	  mst8_slv4_grant,
	  mst8_slv4_haddr,
	  mst8_slv4_hburst,
	  mst8_slv4_hprot,
	  mst8_slv4_hsize,
	  mst8_slv4_htrans,
	  mst8_slv4_hwrite,
	  mst8_slv4_req,
	  mst8_slv4_sel,
	  mst8_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm8_slv5_hwdata,
	  mst8_hs5_hrdata,
	  mst8_hs5_hready,
	  mst8_hs5_hresp,
	  mst8_slv5_ack,
	  mst8_slv5_base,
	  mst8_slv5_grant,
	  mst8_slv5_haddr,
	  mst8_slv5_hburst,
	  mst8_slv5_hprot,
	  mst8_slv5_hsize,
	  mst8_slv5_htrans,
	  mst8_slv5_hwrite,
	  mst8_slv5_req,
	  mst8_slv5_sel,
	  mst8_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm8_slv6_hwdata,
	  mst8_hs6_hrdata,
	  mst8_hs6_hready,
	  mst8_hs6_hresp,
	  mst8_slv6_ack,
	  mst8_slv6_base,
	  mst8_slv6_grant,
	  mst8_slv6_haddr,
	  mst8_slv6_hburst,
	  mst8_slv6_hprot,
	  mst8_slv6_hsize,
	  mst8_slv6_htrans,
	  mst8_slv6_hwrite,
	  mst8_slv6_req,
	  mst8_slv6_sel,
	  mst8_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm8_slv7_hwdata,
	  mst8_hs7_hrdata,
	  mst8_hs7_hready,
	  mst8_hs7_hresp,
	  mst8_slv7_ack,
	  mst8_slv7_base,
	  mst8_slv7_grant,
	  mst8_slv7_haddr,
	  mst8_slv7_hburst,
	  mst8_slv7_hprot,
	  mst8_slv7_hsize,
	  mst8_slv7_htrans,
	  mst8_slv7_hwrite,
	  mst8_slv7_req,
	  mst8_slv7_sel,
	  mst8_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm8_slv8_hwdata,
	  mst8_hs8_hrdata,
	  mst8_hs8_hready,
	  mst8_hs8_hresp,
	  mst8_slv8_ack,
	  mst8_slv8_base,
	  mst8_slv8_grant,
	  mst8_slv8_haddr,
	  mst8_slv8_hburst,
	  mst8_slv8_hprot,
	  mst8_slv8_hsize,
	  mst8_slv8_htrans,
	  mst8_slv8_hwrite,
	  mst8_slv8_req,
	  mst8_slv8_sel,
	  mst8_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm8_slv9_hwdata,
	  mst8_hs9_hrdata,
	  mst8_hs9_hready,
	  mst8_hs9_hresp,
	  mst8_slv9_ack,
	  mst8_slv9_base,
	  mst8_slv9_grant,
	  mst8_slv9_haddr,
	  mst8_slv9_hburst,
	  mst8_slv9_hprot,
	  mst8_slv9_hsize,
	  mst8_slv9_htrans,
	  mst8_slv9_hwrite,
	  mst8_slv9_req,
	  mst8_slv9_sel,
	  mst8_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm8_slv10_hwdata,
	  mst8_hs10_hrdata,
	  mst8_hs10_hready,
	  mst8_hs10_hresp,
	  mst8_slv10_ack,
	  mst8_slv10_base,
	  mst8_slv10_grant,
	  mst8_slv10_haddr,
	  mst8_slv10_hburst,
	  mst8_slv10_hprot,
	  mst8_slv10_hsize,
	  mst8_slv10_htrans,
	  mst8_slv10_hwrite,
	  mst8_slv10_req,
	  mst8_slv10_sel,
	  mst8_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm8_slv11_hwdata,
	  mst8_hs11_hrdata,
	  mst8_hs11_hready,
	  mst8_hs11_hresp,
	  mst8_slv11_ack,
	  mst8_slv11_base,
	  mst8_slv11_grant,
	  mst8_slv11_haddr,
	  mst8_slv11_hburst,
	  mst8_slv11_hprot,
	  mst8_slv11_hsize,
	  mst8_slv11_htrans,
	  mst8_slv11_hwrite,
	  mst8_slv11_req,
	  mst8_slv11_sel,
	  mst8_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm8_slv12_hwdata,
	  mst8_hs12_hrdata,
	  mst8_hs12_hready,
	  mst8_hs12_hresp,
	  mst8_slv12_ack,
	  mst8_slv12_base,
	  mst8_slv12_grant,
	  mst8_slv12_haddr,
	  mst8_slv12_hburst,
	  mst8_slv12_hprot,
	  mst8_slv12_hsize,
	  mst8_slv12_htrans,
	  mst8_slv12_hwrite,
	  mst8_slv12_req,
	  mst8_slv12_sel,
	  mst8_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm8_slv13_hwdata,
	  mst8_hs13_hrdata,
	  mst8_hs13_hready,
	  mst8_hs13_hresp,
	  mst8_slv13_ack,
	  mst8_slv13_base,
	  mst8_slv13_grant,
	  mst8_slv13_haddr,
	  mst8_slv13_hburst,
	  mst8_slv13_hprot,
	  mst8_slv13_hsize,
	  mst8_slv13_htrans,
	  mst8_slv13_hwrite,
	  mst8_slv13_req,
	  mst8_slv13_sel,
	  mst8_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm8_slv14_hwdata,
	  mst8_hs14_hrdata,
	  mst8_hs14_hready,
	  mst8_hs14_hresp,
	  mst8_slv14_ack,
	  mst8_slv14_base,
	  mst8_slv14_grant,
	  mst8_slv14_haddr,
	  mst8_slv14_hburst,
	  mst8_slv14_hprot,
	  mst8_slv14_hsize,
	  mst8_slv14_htrans,
	  mst8_slv14_hwrite,
	  mst8_slv14_req,
	  mst8_slv14_sel,
	  mst8_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm8_slv15_hwdata,
	  mst8_hs15_hrdata,
	  mst8_hs15_hready,
	  mst8_hs15_hresp,
	  mst8_slv15_ack,
	  mst8_slv15_base,
	  mst8_slv15_grant,
	  mst8_slv15_haddr,
	  mst8_slv15_hburst,
	  mst8_slv15_hprot,
	  mst8_slv15_hsize,
	  mst8_slv15_htrans,
	  mst8_slv15_hwrite,
	  mst8_slv15_req,
	  mst8_slv15_sel,
	  mst8_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST9
	  hm9_slv0_hwdata,
	  mst9_hs0_hrdata,
	  mst9_hs0_hready,
	  mst9_hs0_hresp,
	  mst9_slv0_ack,
	  mst9_slv0_base,
	  mst9_slv0_grant,
	  mst9_slv0_haddr,
	  mst9_slv0_hburst,
	  mst9_slv0_hprot,
	  mst9_slv0_hsize,
	  mst9_slv0_htrans,
	  mst9_slv0_hwrite,
	  mst9_slv0_req,
	  mst9_slv0_sel,
	  mst9_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST9
   `ifdef ATCBMC200_AHB_SLV1
	  hm9_slv1_hwdata,
	  mst9_hs1_hrdata,
	  mst9_hs1_hready,
	  mst9_hs1_hresp,
	  mst9_slv1_ack,
	  mst9_slv1_base,
	  mst9_slv1_grant,
	  mst9_slv1_haddr,
	  mst9_slv1_hburst,
	  mst9_slv1_hprot,
	  mst9_slv1_hsize,
	  mst9_slv1_htrans,
	  mst9_slv1_hwrite,
	  mst9_slv1_req,
	  mst9_slv1_sel,
	  mst9_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm9_slv2_hwdata,
	  mst9_hs2_hrdata,
	  mst9_hs2_hready,
	  mst9_hs2_hresp,
	  mst9_slv2_ack,
	  mst9_slv2_base,
	  mst9_slv2_grant,
	  mst9_slv2_haddr,
	  mst9_slv2_hburst,
	  mst9_slv2_hprot,
	  mst9_slv2_hsize,
	  mst9_slv2_htrans,
	  mst9_slv2_hwrite,
	  mst9_slv2_req,
	  mst9_slv2_sel,
	  mst9_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm9_slv3_hwdata,
	  mst9_hs3_hrdata,
	  mst9_hs3_hready,
	  mst9_hs3_hresp,
	  mst9_slv3_ack,
	  mst9_slv3_base,
	  mst9_slv3_grant,
	  mst9_slv3_haddr,
	  mst9_slv3_hburst,
	  mst9_slv3_hprot,
	  mst9_slv3_hsize,
	  mst9_slv3_htrans,
	  mst9_slv3_hwrite,
	  mst9_slv3_req,
	  mst9_slv3_sel,
	  mst9_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm9_slv4_hwdata,
	  mst9_hs4_hrdata,
	  mst9_hs4_hready,
	  mst9_hs4_hresp,
	  mst9_slv4_ack,
	  mst9_slv4_base,
	  mst9_slv4_grant,
	  mst9_slv4_haddr,
	  mst9_slv4_hburst,
	  mst9_slv4_hprot,
	  mst9_slv4_hsize,
	  mst9_slv4_htrans,
	  mst9_slv4_hwrite,
	  mst9_slv4_req,
	  mst9_slv4_sel,
	  mst9_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm9_slv5_hwdata,
	  mst9_hs5_hrdata,
	  mst9_hs5_hready,
	  mst9_hs5_hresp,
	  mst9_slv5_ack,
	  mst9_slv5_base,
	  mst9_slv5_grant,
	  mst9_slv5_haddr,
	  mst9_slv5_hburst,
	  mst9_slv5_hprot,
	  mst9_slv5_hsize,
	  mst9_slv5_htrans,
	  mst9_slv5_hwrite,
	  mst9_slv5_req,
	  mst9_slv5_sel,
	  mst9_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm9_slv6_hwdata,
	  mst9_hs6_hrdata,
	  mst9_hs6_hready,
	  mst9_hs6_hresp,
	  mst9_slv6_ack,
	  mst9_slv6_base,
	  mst9_slv6_grant,
	  mst9_slv6_haddr,
	  mst9_slv6_hburst,
	  mst9_slv6_hprot,
	  mst9_slv6_hsize,
	  mst9_slv6_htrans,
	  mst9_slv6_hwrite,
	  mst9_slv6_req,
	  mst9_slv6_sel,
	  mst9_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm9_slv7_hwdata,
	  mst9_hs7_hrdata,
	  mst9_hs7_hready,
	  mst9_hs7_hresp,
	  mst9_slv7_ack,
	  mst9_slv7_base,
	  mst9_slv7_grant,
	  mst9_slv7_haddr,
	  mst9_slv7_hburst,
	  mst9_slv7_hprot,
	  mst9_slv7_hsize,
	  mst9_slv7_htrans,
	  mst9_slv7_hwrite,
	  mst9_slv7_req,
	  mst9_slv7_sel,
	  mst9_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm9_slv8_hwdata,
	  mst9_hs8_hrdata,
	  mst9_hs8_hready,
	  mst9_hs8_hresp,
	  mst9_slv8_ack,
	  mst9_slv8_base,
	  mst9_slv8_grant,
	  mst9_slv8_haddr,
	  mst9_slv8_hburst,
	  mst9_slv8_hprot,
	  mst9_slv8_hsize,
	  mst9_slv8_htrans,
	  mst9_slv8_hwrite,
	  mst9_slv8_req,
	  mst9_slv8_sel,
	  mst9_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm9_slv9_hwdata,
	  mst9_hs9_hrdata,
	  mst9_hs9_hready,
	  mst9_hs9_hresp,
	  mst9_slv9_ack,
	  mst9_slv9_base,
	  mst9_slv9_grant,
	  mst9_slv9_haddr,
	  mst9_slv9_hburst,
	  mst9_slv9_hprot,
	  mst9_slv9_hsize,
	  mst9_slv9_htrans,
	  mst9_slv9_hwrite,
	  mst9_slv9_req,
	  mst9_slv9_sel,
	  mst9_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm9_slv10_hwdata,
	  mst9_hs10_hrdata,
	  mst9_hs10_hready,
	  mst9_hs10_hresp,
	  mst9_slv10_ack,
	  mst9_slv10_base,
	  mst9_slv10_grant,
	  mst9_slv10_haddr,
	  mst9_slv10_hburst,
	  mst9_slv10_hprot,
	  mst9_slv10_hsize,
	  mst9_slv10_htrans,
	  mst9_slv10_hwrite,
	  mst9_slv10_req,
	  mst9_slv10_sel,
	  mst9_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm9_slv11_hwdata,
	  mst9_hs11_hrdata,
	  mst9_hs11_hready,
	  mst9_hs11_hresp,
	  mst9_slv11_ack,
	  mst9_slv11_base,
	  mst9_slv11_grant,
	  mst9_slv11_haddr,
	  mst9_slv11_hburst,
	  mst9_slv11_hprot,
	  mst9_slv11_hsize,
	  mst9_slv11_htrans,
	  mst9_slv11_hwrite,
	  mst9_slv11_req,
	  mst9_slv11_sel,
	  mst9_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm9_slv12_hwdata,
	  mst9_hs12_hrdata,
	  mst9_hs12_hready,
	  mst9_hs12_hresp,
	  mst9_slv12_ack,
	  mst9_slv12_base,
	  mst9_slv12_grant,
	  mst9_slv12_haddr,
	  mst9_slv12_hburst,
	  mst9_slv12_hprot,
	  mst9_slv12_hsize,
	  mst9_slv12_htrans,
	  mst9_slv12_hwrite,
	  mst9_slv12_req,
	  mst9_slv12_sel,
	  mst9_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm9_slv13_hwdata,
	  mst9_hs13_hrdata,
	  mst9_hs13_hready,
	  mst9_hs13_hresp,
	  mst9_slv13_ack,
	  mst9_slv13_base,
	  mst9_slv13_grant,
	  mst9_slv13_haddr,
	  mst9_slv13_hburst,
	  mst9_slv13_hprot,
	  mst9_slv13_hsize,
	  mst9_slv13_htrans,
	  mst9_slv13_hwrite,
	  mst9_slv13_req,
	  mst9_slv13_sel,
	  mst9_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm9_slv14_hwdata,
	  mst9_hs14_hrdata,
	  mst9_hs14_hready,
	  mst9_hs14_hresp,
	  mst9_slv14_ack,
	  mst9_slv14_base,
	  mst9_slv14_grant,
	  mst9_slv14_haddr,
	  mst9_slv14_hburst,
	  mst9_slv14_hprot,
	  mst9_slv14_hsize,
	  mst9_slv14_htrans,
	  mst9_slv14_hwrite,
	  mst9_slv14_req,
	  mst9_slv14_sel,
	  mst9_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm9_slv15_hwdata,
	  mst9_hs15_hrdata,
	  mst9_hs15_hready,
	  mst9_hs15_hresp,
	  mst9_slv15_ack,
	  mst9_slv15_base,
	  mst9_slv15_grant,
	  mst9_slv15_haddr,
	  mst9_slv15_hburst,
	  mst9_slv15_hprot,
	  mst9_slv15_hsize,
	  mst9_slv15_htrans,
	  mst9_slv15_hwrite,
	  mst9_slv15_req,
	  mst9_slv15_sel,
	  mst9_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST10
	  hm10_slv0_hwdata,
	  mst10_hs0_hrdata,
	  mst10_hs0_hready,
	  mst10_hs0_hresp,
	  mst10_slv0_ack,
	  mst10_slv0_base,
	  mst10_slv0_grant,
	  mst10_slv0_haddr,
	  mst10_slv0_hburst,
	  mst10_slv0_hprot,
	  mst10_slv0_hsize,
	  mst10_slv0_htrans,
	  mst10_slv0_hwrite,
	  mst10_slv0_req,
	  mst10_slv0_sel,
	  mst10_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST10
   `ifdef ATCBMC200_AHB_SLV1
	  hm10_slv1_hwdata,
	  mst10_hs1_hrdata,
	  mst10_hs1_hready,
	  mst10_hs1_hresp,
	  mst10_slv1_ack,
	  mst10_slv1_base,
	  mst10_slv1_grant,
	  mst10_slv1_haddr,
	  mst10_slv1_hburst,
	  mst10_slv1_hprot,
	  mst10_slv1_hsize,
	  mst10_slv1_htrans,
	  mst10_slv1_hwrite,
	  mst10_slv1_req,
	  mst10_slv1_sel,
	  mst10_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm10_slv2_hwdata,
	  mst10_hs2_hrdata,
	  mst10_hs2_hready,
	  mst10_hs2_hresp,
	  mst10_slv2_ack,
	  mst10_slv2_base,
	  mst10_slv2_grant,
	  mst10_slv2_haddr,
	  mst10_slv2_hburst,
	  mst10_slv2_hprot,
	  mst10_slv2_hsize,
	  mst10_slv2_htrans,
	  mst10_slv2_hwrite,
	  mst10_slv2_req,
	  mst10_slv2_sel,
	  mst10_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm10_slv3_hwdata,
	  mst10_hs3_hrdata,
	  mst10_hs3_hready,
	  mst10_hs3_hresp,
	  mst10_slv3_ack,
	  mst10_slv3_base,
	  mst10_slv3_grant,
	  mst10_slv3_haddr,
	  mst10_slv3_hburst,
	  mst10_slv3_hprot,
	  mst10_slv3_hsize,
	  mst10_slv3_htrans,
	  mst10_slv3_hwrite,
	  mst10_slv3_req,
	  mst10_slv3_sel,
	  mst10_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm10_slv4_hwdata,
	  mst10_hs4_hrdata,
	  mst10_hs4_hready,
	  mst10_hs4_hresp,
	  mst10_slv4_ack,
	  mst10_slv4_base,
	  mst10_slv4_grant,
	  mst10_slv4_haddr,
	  mst10_slv4_hburst,
	  mst10_slv4_hprot,
	  mst10_slv4_hsize,
	  mst10_slv4_htrans,
	  mst10_slv4_hwrite,
	  mst10_slv4_req,
	  mst10_slv4_sel,
	  mst10_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm10_slv5_hwdata,
	  mst10_hs5_hrdata,
	  mst10_hs5_hready,
	  mst10_hs5_hresp,
	  mst10_slv5_ack,
	  mst10_slv5_base,
	  mst10_slv5_grant,
	  mst10_slv5_haddr,
	  mst10_slv5_hburst,
	  mst10_slv5_hprot,
	  mst10_slv5_hsize,
	  mst10_slv5_htrans,
	  mst10_slv5_hwrite,
	  mst10_slv5_req,
	  mst10_slv5_sel,
	  mst10_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm10_slv6_hwdata,
	  mst10_hs6_hrdata,
	  mst10_hs6_hready,
	  mst10_hs6_hresp,
	  mst10_slv6_ack,
	  mst10_slv6_base,
	  mst10_slv6_grant,
	  mst10_slv6_haddr,
	  mst10_slv6_hburst,
	  mst10_slv6_hprot,
	  mst10_slv6_hsize,
	  mst10_slv6_htrans,
	  mst10_slv6_hwrite,
	  mst10_slv6_req,
	  mst10_slv6_sel,
	  mst10_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm10_slv7_hwdata,
	  mst10_hs7_hrdata,
	  mst10_hs7_hready,
	  mst10_hs7_hresp,
	  mst10_slv7_ack,
	  mst10_slv7_base,
	  mst10_slv7_grant,
	  mst10_slv7_haddr,
	  mst10_slv7_hburst,
	  mst10_slv7_hprot,
	  mst10_slv7_hsize,
	  mst10_slv7_htrans,
	  mst10_slv7_hwrite,
	  mst10_slv7_req,
	  mst10_slv7_sel,
	  mst10_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm10_slv8_hwdata,
	  mst10_hs8_hrdata,
	  mst10_hs8_hready,
	  mst10_hs8_hresp,
	  mst10_slv8_ack,
	  mst10_slv8_base,
	  mst10_slv8_grant,
	  mst10_slv8_haddr,
	  mst10_slv8_hburst,
	  mst10_slv8_hprot,
	  mst10_slv8_hsize,
	  mst10_slv8_htrans,
	  mst10_slv8_hwrite,
	  mst10_slv8_req,
	  mst10_slv8_sel,
	  mst10_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm10_slv9_hwdata,
	  mst10_hs9_hrdata,
	  mst10_hs9_hready,
	  mst10_hs9_hresp,
	  mst10_slv9_ack,
	  mst10_slv9_base,
	  mst10_slv9_grant,
	  mst10_slv9_haddr,
	  mst10_slv9_hburst,
	  mst10_slv9_hprot,
	  mst10_slv9_hsize,
	  mst10_slv9_htrans,
	  mst10_slv9_hwrite,
	  mst10_slv9_req,
	  mst10_slv9_sel,
	  mst10_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm10_slv10_hwdata,
	  mst10_hs10_hrdata,
	  mst10_hs10_hready,
	  mst10_hs10_hresp,
	  mst10_slv10_ack,
	  mst10_slv10_base,
	  mst10_slv10_grant,
	  mst10_slv10_haddr,
	  mst10_slv10_hburst,
	  mst10_slv10_hprot,
	  mst10_slv10_hsize,
	  mst10_slv10_htrans,
	  mst10_slv10_hwrite,
	  mst10_slv10_req,
	  mst10_slv10_sel,
	  mst10_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm10_slv11_hwdata,
	  mst10_hs11_hrdata,
	  mst10_hs11_hready,
	  mst10_hs11_hresp,
	  mst10_slv11_ack,
	  mst10_slv11_base,
	  mst10_slv11_grant,
	  mst10_slv11_haddr,
	  mst10_slv11_hburst,
	  mst10_slv11_hprot,
	  mst10_slv11_hsize,
	  mst10_slv11_htrans,
	  mst10_slv11_hwrite,
	  mst10_slv11_req,
	  mst10_slv11_sel,
	  mst10_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm10_slv12_hwdata,
	  mst10_hs12_hrdata,
	  mst10_hs12_hready,
	  mst10_hs12_hresp,
	  mst10_slv12_ack,
	  mst10_slv12_base,
	  mst10_slv12_grant,
	  mst10_slv12_haddr,
	  mst10_slv12_hburst,
	  mst10_slv12_hprot,
	  mst10_slv12_hsize,
	  mst10_slv12_htrans,
	  mst10_slv12_hwrite,
	  mst10_slv12_req,
	  mst10_slv12_sel,
	  mst10_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm10_slv13_hwdata,
	  mst10_hs13_hrdata,
	  mst10_hs13_hready,
	  mst10_hs13_hresp,
	  mst10_slv13_ack,
	  mst10_slv13_base,
	  mst10_slv13_grant,
	  mst10_slv13_haddr,
	  mst10_slv13_hburst,
	  mst10_slv13_hprot,
	  mst10_slv13_hsize,
	  mst10_slv13_htrans,
	  mst10_slv13_hwrite,
	  mst10_slv13_req,
	  mst10_slv13_sel,
	  mst10_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm10_slv14_hwdata,
	  mst10_hs14_hrdata,
	  mst10_hs14_hready,
	  mst10_hs14_hresp,
	  mst10_slv14_ack,
	  mst10_slv14_base,
	  mst10_slv14_grant,
	  mst10_slv14_haddr,
	  mst10_slv14_hburst,
	  mst10_slv14_hprot,
	  mst10_slv14_hsize,
	  mst10_slv14_htrans,
	  mst10_slv14_hwrite,
	  mst10_slv14_req,
	  mst10_slv14_sel,
	  mst10_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm10_slv15_hwdata,
	  mst10_hs15_hrdata,
	  mst10_hs15_hready,
	  mst10_hs15_hresp,
	  mst10_slv15_ack,
	  mst10_slv15_base,
	  mst10_slv15_grant,
	  mst10_slv15_haddr,
	  mst10_slv15_hburst,
	  mst10_slv15_hprot,
	  mst10_slv15_hsize,
	  mst10_slv15_htrans,
	  mst10_slv15_hwrite,
	  mst10_slv15_req,
	  mst10_slv15_sel,
	  mst10_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST11
	  hm11_slv0_hwdata,
	  mst11_hs0_hrdata,
	  mst11_hs0_hready,
	  mst11_hs0_hresp,
	  mst11_slv0_ack,
	  mst11_slv0_base,
	  mst11_slv0_grant,
	  mst11_slv0_haddr,
	  mst11_slv0_hburst,
	  mst11_slv0_hprot,
	  mst11_slv0_hsize,
	  mst11_slv0_htrans,
	  mst11_slv0_hwrite,
	  mst11_slv0_req,
	  mst11_slv0_sel,
	  mst11_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST11
   `ifdef ATCBMC200_AHB_SLV1
	  hm11_slv1_hwdata,
	  mst11_hs1_hrdata,
	  mst11_hs1_hready,
	  mst11_hs1_hresp,
	  mst11_slv1_ack,
	  mst11_slv1_base,
	  mst11_slv1_grant,
	  mst11_slv1_haddr,
	  mst11_slv1_hburst,
	  mst11_slv1_hprot,
	  mst11_slv1_hsize,
	  mst11_slv1_htrans,
	  mst11_slv1_hwrite,
	  mst11_slv1_req,
	  mst11_slv1_sel,
	  mst11_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm11_slv2_hwdata,
	  mst11_hs2_hrdata,
	  mst11_hs2_hready,
	  mst11_hs2_hresp,
	  mst11_slv2_ack,
	  mst11_slv2_base,
	  mst11_slv2_grant,
	  mst11_slv2_haddr,
	  mst11_slv2_hburst,
	  mst11_slv2_hprot,
	  mst11_slv2_hsize,
	  mst11_slv2_htrans,
	  mst11_slv2_hwrite,
	  mst11_slv2_req,
	  mst11_slv2_sel,
	  mst11_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm11_slv3_hwdata,
	  mst11_hs3_hrdata,
	  mst11_hs3_hready,
	  mst11_hs3_hresp,
	  mst11_slv3_ack,
	  mst11_slv3_base,
	  mst11_slv3_grant,
	  mst11_slv3_haddr,
	  mst11_slv3_hburst,
	  mst11_slv3_hprot,
	  mst11_slv3_hsize,
	  mst11_slv3_htrans,
	  mst11_slv3_hwrite,
	  mst11_slv3_req,
	  mst11_slv3_sel,
	  mst11_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm11_slv4_hwdata,
	  mst11_hs4_hrdata,
	  mst11_hs4_hready,
	  mst11_hs4_hresp,
	  mst11_slv4_ack,
	  mst11_slv4_base,
	  mst11_slv4_grant,
	  mst11_slv4_haddr,
	  mst11_slv4_hburst,
	  mst11_slv4_hprot,
	  mst11_slv4_hsize,
	  mst11_slv4_htrans,
	  mst11_slv4_hwrite,
	  mst11_slv4_req,
	  mst11_slv4_sel,
	  mst11_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm11_slv5_hwdata,
	  mst11_hs5_hrdata,
	  mst11_hs5_hready,
	  mst11_hs5_hresp,
	  mst11_slv5_ack,
	  mst11_slv5_base,
	  mst11_slv5_grant,
	  mst11_slv5_haddr,
	  mst11_slv5_hburst,
	  mst11_slv5_hprot,
	  mst11_slv5_hsize,
	  mst11_slv5_htrans,
	  mst11_slv5_hwrite,
	  mst11_slv5_req,
	  mst11_slv5_sel,
	  mst11_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm11_slv6_hwdata,
	  mst11_hs6_hrdata,
	  mst11_hs6_hready,
	  mst11_hs6_hresp,
	  mst11_slv6_ack,
	  mst11_slv6_base,
	  mst11_slv6_grant,
	  mst11_slv6_haddr,
	  mst11_slv6_hburst,
	  mst11_slv6_hprot,
	  mst11_slv6_hsize,
	  mst11_slv6_htrans,
	  mst11_slv6_hwrite,
	  mst11_slv6_req,
	  mst11_slv6_sel,
	  mst11_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm11_slv7_hwdata,
	  mst11_hs7_hrdata,
	  mst11_hs7_hready,
	  mst11_hs7_hresp,
	  mst11_slv7_ack,
	  mst11_slv7_base,
	  mst11_slv7_grant,
	  mst11_slv7_haddr,
	  mst11_slv7_hburst,
	  mst11_slv7_hprot,
	  mst11_slv7_hsize,
	  mst11_slv7_htrans,
	  mst11_slv7_hwrite,
	  mst11_slv7_req,
	  mst11_slv7_sel,
	  mst11_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm11_slv8_hwdata,
	  mst11_hs8_hrdata,
	  mst11_hs8_hready,
	  mst11_hs8_hresp,
	  mst11_slv8_ack,
	  mst11_slv8_base,
	  mst11_slv8_grant,
	  mst11_slv8_haddr,
	  mst11_slv8_hburst,
	  mst11_slv8_hprot,
	  mst11_slv8_hsize,
	  mst11_slv8_htrans,
	  mst11_slv8_hwrite,
	  mst11_slv8_req,
	  mst11_slv8_sel,
	  mst11_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm11_slv9_hwdata,
	  mst11_hs9_hrdata,
	  mst11_hs9_hready,
	  mst11_hs9_hresp,
	  mst11_slv9_ack,
	  mst11_slv9_base,
	  mst11_slv9_grant,
	  mst11_slv9_haddr,
	  mst11_slv9_hburst,
	  mst11_slv9_hprot,
	  mst11_slv9_hsize,
	  mst11_slv9_htrans,
	  mst11_slv9_hwrite,
	  mst11_slv9_req,
	  mst11_slv9_sel,
	  mst11_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm11_slv10_hwdata,
	  mst11_hs10_hrdata,
	  mst11_hs10_hready,
	  mst11_hs10_hresp,
	  mst11_slv10_ack,
	  mst11_slv10_base,
	  mst11_slv10_grant,
	  mst11_slv10_haddr,
	  mst11_slv10_hburst,
	  mst11_slv10_hprot,
	  mst11_slv10_hsize,
	  mst11_slv10_htrans,
	  mst11_slv10_hwrite,
	  mst11_slv10_req,
	  mst11_slv10_sel,
	  mst11_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm11_slv11_hwdata,
	  mst11_hs11_hrdata,
	  mst11_hs11_hready,
	  mst11_hs11_hresp,
	  mst11_slv11_ack,
	  mst11_slv11_base,
	  mst11_slv11_grant,
	  mst11_slv11_haddr,
	  mst11_slv11_hburst,
	  mst11_slv11_hprot,
	  mst11_slv11_hsize,
	  mst11_slv11_htrans,
	  mst11_slv11_hwrite,
	  mst11_slv11_req,
	  mst11_slv11_sel,
	  mst11_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm11_slv12_hwdata,
	  mst11_hs12_hrdata,
	  mst11_hs12_hready,
	  mst11_hs12_hresp,
	  mst11_slv12_ack,
	  mst11_slv12_base,
	  mst11_slv12_grant,
	  mst11_slv12_haddr,
	  mst11_slv12_hburst,
	  mst11_slv12_hprot,
	  mst11_slv12_hsize,
	  mst11_slv12_htrans,
	  mst11_slv12_hwrite,
	  mst11_slv12_req,
	  mst11_slv12_sel,
	  mst11_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm11_slv13_hwdata,
	  mst11_hs13_hrdata,
	  mst11_hs13_hready,
	  mst11_hs13_hresp,
	  mst11_slv13_ack,
	  mst11_slv13_base,
	  mst11_slv13_grant,
	  mst11_slv13_haddr,
	  mst11_slv13_hburst,
	  mst11_slv13_hprot,
	  mst11_slv13_hsize,
	  mst11_slv13_htrans,
	  mst11_slv13_hwrite,
	  mst11_slv13_req,
	  mst11_slv13_sel,
	  mst11_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm11_slv14_hwdata,
	  mst11_hs14_hrdata,
	  mst11_hs14_hready,
	  mst11_hs14_hresp,
	  mst11_slv14_ack,
	  mst11_slv14_base,
	  mst11_slv14_grant,
	  mst11_slv14_haddr,
	  mst11_slv14_hburst,
	  mst11_slv14_hprot,
	  mst11_slv14_hsize,
	  mst11_slv14_htrans,
	  mst11_slv14_hwrite,
	  mst11_slv14_req,
	  mst11_slv14_sel,
	  mst11_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm11_slv15_hwdata,
	  mst11_hs15_hrdata,
	  mst11_hs15_hready,
	  mst11_hs15_hresp,
	  mst11_slv15_ack,
	  mst11_slv15_base,
	  mst11_slv15_grant,
	  mst11_slv15_haddr,
	  mst11_slv15_hburst,
	  mst11_slv15_hprot,
	  mst11_slv15_hsize,
	  mst11_slv15_htrans,
	  mst11_slv15_hwrite,
	  mst11_slv15_req,
	  mst11_slv15_sel,
	  mst11_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST12
	  hm12_slv0_hwdata,
	  mst12_hs0_hrdata,
	  mst12_hs0_hready,
	  mst12_hs0_hresp,
	  mst12_slv0_ack,
	  mst12_slv0_base,
	  mst12_slv0_grant,
	  mst12_slv0_haddr,
	  mst12_slv0_hburst,
	  mst12_slv0_hprot,
	  mst12_slv0_hsize,
	  mst12_slv0_htrans,
	  mst12_slv0_hwrite,
	  mst12_slv0_req,
	  mst12_slv0_sel,
	  mst12_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST12
   `ifdef ATCBMC200_AHB_SLV1
	  hm12_slv1_hwdata,
	  mst12_hs1_hrdata,
	  mst12_hs1_hready,
	  mst12_hs1_hresp,
	  mst12_slv1_ack,
	  mst12_slv1_base,
	  mst12_slv1_grant,
	  mst12_slv1_haddr,
	  mst12_slv1_hburst,
	  mst12_slv1_hprot,
	  mst12_slv1_hsize,
	  mst12_slv1_htrans,
	  mst12_slv1_hwrite,
	  mst12_slv1_req,
	  mst12_slv1_sel,
	  mst12_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm12_slv2_hwdata,
	  mst12_hs2_hrdata,
	  mst12_hs2_hready,
	  mst12_hs2_hresp,
	  mst12_slv2_ack,
	  mst12_slv2_base,
	  mst12_slv2_grant,
	  mst12_slv2_haddr,
	  mst12_slv2_hburst,
	  mst12_slv2_hprot,
	  mst12_slv2_hsize,
	  mst12_slv2_htrans,
	  mst12_slv2_hwrite,
	  mst12_slv2_req,
	  mst12_slv2_sel,
	  mst12_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm12_slv3_hwdata,
	  mst12_hs3_hrdata,
	  mst12_hs3_hready,
	  mst12_hs3_hresp,
	  mst12_slv3_ack,
	  mst12_slv3_base,
	  mst12_slv3_grant,
	  mst12_slv3_haddr,
	  mst12_slv3_hburst,
	  mst12_slv3_hprot,
	  mst12_slv3_hsize,
	  mst12_slv3_htrans,
	  mst12_slv3_hwrite,
	  mst12_slv3_req,
	  mst12_slv3_sel,
	  mst12_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm12_slv4_hwdata,
	  mst12_hs4_hrdata,
	  mst12_hs4_hready,
	  mst12_hs4_hresp,
	  mst12_slv4_ack,
	  mst12_slv4_base,
	  mst12_slv4_grant,
	  mst12_slv4_haddr,
	  mst12_slv4_hburst,
	  mst12_slv4_hprot,
	  mst12_slv4_hsize,
	  mst12_slv4_htrans,
	  mst12_slv4_hwrite,
	  mst12_slv4_req,
	  mst12_slv4_sel,
	  mst12_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm12_slv5_hwdata,
	  mst12_hs5_hrdata,
	  mst12_hs5_hready,
	  mst12_hs5_hresp,
	  mst12_slv5_ack,
	  mst12_slv5_base,
	  mst12_slv5_grant,
	  mst12_slv5_haddr,
	  mst12_slv5_hburst,
	  mst12_slv5_hprot,
	  mst12_slv5_hsize,
	  mst12_slv5_htrans,
	  mst12_slv5_hwrite,
	  mst12_slv5_req,
	  mst12_slv5_sel,
	  mst12_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm12_slv6_hwdata,
	  mst12_hs6_hrdata,
	  mst12_hs6_hready,
	  mst12_hs6_hresp,
	  mst12_slv6_ack,
	  mst12_slv6_base,
	  mst12_slv6_grant,
	  mst12_slv6_haddr,
	  mst12_slv6_hburst,
	  mst12_slv6_hprot,
	  mst12_slv6_hsize,
	  mst12_slv6_htrans,
	  mst12_slv6_hwrite,
	  mst12_slv6_req,
	  mst12_slv6_sel,
	  mst12_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm12_slv7_hwdata,
	  mst12_hs7_hrdata,
	  mst12_hs7_hready,
	  mst12_hs7_hresp,
	  mst12_slv7_ack,
	  mst12_slv7_base,
	  mst12_slv7_grant,
	  mst12_slv7_haddr,
	  mst12_slv7_hburst,
	  mst12_slv7_hprot,
	  mst12_slv7_hsize,
	  mst12_slv7_htrans,
	  mst12_slv7_hwrite,
	  mst12_slv7_req,
	  mst12_slv7_sel,
	  mst12_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm12_slv8_hwdata,
	  mst12_hs8_hrdata,
	  mst12_hs8_hready,
	  mst12_hs8_hresp,
	  mst12_slv8_ack,
	  mst12_slv8_base,
	  mst12_slv8_grant,
	  mst12_slv8_haddr,
	  mst12_slv8_hburst,
	  mst12_slv8_hprot,
	  mst12_slv8_hsize,
	  mst12_slv8_htrans,
	  mst12_slv8_hwrite,
	  mst12_slv8_req,
	  mst12_slv8_sel,
	  mst12_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm12_slv9_hwdata,
	  mst12_hs9_hrdata,
	  mst12_hs9_hready,
	  mst12_hs9_hresp,
	  mst12_slv9_ack,
	  mst12_slv9_base,
	  mst12_slv9_grant,
	  mst12_slv9_haddr,
	  mst12_slv9_hburst,
	  mst12_slv9_hprot,
	  mst12_slv9_hsize,
	  mst12_slv9_htrans,
	  mst12_slv9_hwrite,
	  mst12_slv9_req,
	  mst12_slv9_sel,
	  mst12_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm12_slv10_hwdata,
	  mst12_hs10_hrdata,
	  mst12_hs10_hready,
	  mst12_hs10_hresp,
	  mst12_slv10_ack,
	  mst12_slv10_base,
	  mst12_slv10_grant,
	  mst12_slv10_haddr,
	  mst12_slv10_hburst,
	  mst12_slv10_hprot,
	  mst12_slv10_hsize,
	  mst12_slv10_htrans,
	  mst12_slv10_hwrite,
	  mst12_slv10_req,
	  mst12_slv10_sel,
	  mst12_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm12_slv11_hwdata,
	  mst12_hs11_hrdata,
	  mst12_hs11_hready,
	  mst12_hs11_hresp,
	  mst12_slv11_ack,
	  mst12_slv11_base,
	  mst12_slv11_grant,
	  mst12_slv11_haddr,
	  mst12_slv11_hburst,
	  mst12_slv11_hprot,
	  mst12_slv11_hsize,
	  mst12_slv11_htrans,
	  mst12_slv11_hwrite,
	  mst12_slv11_req,
	  mst12_slv11_sel,
	  mst12_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm12_slv12_hwdata,
	  mst12_hs12_hrdata,
	  mst12_hs12_hready,
	  mst12_hs12_hresp,
	  mst12_slv12_ack,
	  mst12_slv12_base,
	  mst12_slv12_grant,
	  mst12_slv12_haddr,
	  mst12_slv12_hburst,
	  mst12_slv12_hprot,
	  mst12_slv12_hsize,
	  mst12_slv12_htrans,
	  mst12_slv12_hwrite,
	  mst12_slv12_req,
	  mst12_slv12_sel,
	  mst12_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm12_slv13_hwdata,
	  mst12_hs13_hrdata,
	  mst12_hs13_hready,
	  mst12_hs13_hresp,
	  mst12_slv13_ack,
	  mst12_slv13_base,
	  mst12_slv13_grant,
	  mst12_slv13_haddr,
	  mst12_slv13_hburst,
	  mst12_slv13_hprot,
	  mst12_slv13_hsize,
	  mst12_slv13_htrans,
	  mst12_slv13_hwrite,
	  mst12_slv13_req,
	  mst12_slv13_sel,
	  mst12_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm12_slv14_hwdata,
	  mst12_hs14_hrdata,
	  mst12_hs14_hready,
	  mst12_hs14_hresp,
	  mst12_slv14_ack,
	  mst12_slv14_base,
	  mst12_slv14_grant,
	  mst12_slv14_haddr,
	  mst12_slv14_hburst,
	  mst12_slv14_hprot,
	  mst12_slv14_hsize,
	  mst12_slv14_htrans,
	  mst12_slv14_hwrite,
	  mst12_slv14_req,
	  mst12_slv14_sel,
	  mst12_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm12_slv15_hwdata,
	  mst12_hs15_hrdata,
	  mst12_hs15_hready,
	  mst12_hs15_hresp,
	  mst12_slv15_ack,
	  mst12_slv15_base,
	  mst12_slv15_grant,
	  mst12_slv15_haddr,
	  mst12_slv15_hburst,
	  mst12_slv15_hprot,
	  mst12_slv15_hsize,
	  mst12_slv15_htrans,
	  mst12_slv15_hwrite,
	  mst12_slv15_req,
	  mst12_slv15_sel,
	  mst12_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST13
	  hm13_slv0_hwdata,
	  mst13_hs0_hrdata,
	  mst13_hs0_hready,
	  mst13_hs0_hresp,
	  mst13_slv0_ack,
	  mst13_slv0_base,
	  mst13_slv0_grant,
	  mst13_slv0_haddr,
	  mst13_slv0_hburst,
	  mst13_slv0_hprot,
	  mst13_slv0_hsize,
	  mst13_slv0_htrans,
	  mst13_slv0_hwrite,
	  mst13_slv0_req,
	  mst13_slv0_sel,
	  mst13_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST13
   `ifdef ATCBMC200_AHB_SLV1
	  hm13_slv1_hwdata,
	  mst13_hs1_hrdata,
	  mst13_hs1_hready,
	  mst13_hs1_hresp,
	  mst13_slv1_ack,
	  mst13_slv1_base,
	  mst13_slv1_grant,
	  mst13_slv1_haddr,
	  mst13_slv1_hburst,
	  mst13_slv1_hprot,
	  mst13_slv1_hsize,
	  mst13_slv1_htrans,
	  mst13_slv1_hwrite,
	  mst13_slv1_req,
	  mst13_slv1_sel,
	  mst13_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm13_slv2_hwdata,
	  mst13_hs2_hrdata,
	  mst13_hs2_hready,
	  mst13_hs2_hresp,
	  mst13_slv2_ack,
	  mst13_slv2_base,
	  mst13_slv2_grant,
	  mst13_slv2_haddr,
	  mst13_slv2_hburst,
	  mst13_slv2_hprot,
	  mst13_slv2_hsize,
	  mst13_slv2_htrans,
	  mst13_slv2_hwrite,
	  mst13_slv2_req,
	  mst13_slv2_sel,
	  mst13_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm13_slv3_hwdata,
	  mst13_hs3_hrdata,
	  mst13_hs3_hready,
	  mst13_hs3_hresp,
	  mst13_slv3_ack,
	  mst13_slv3_base,
	  mst13_slv3_grant,
	  mst13_slv3_haddr,
	  mst13_slv3_hburst,
	  mst13_slv3_hprot,
	  mst13_slv3_hsize,
	  mst13_slv3_htrans,
	  mst13_slv3_hwrite,
	  mst13_slv3_req,
	  mst13_slv3_sel,
	  mst13_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm13_slv4_hwdata,
	  mst13_hs4_hrdata,
	  mst13_hs4_hready,
	  mst13_hs4_hresp,
	  mst13_slv4_ack,
	  mst13_slv4_base,
	  mst13_slv4_grant,
	  mst13_slv4_haddr,
	  mst13_slv4_hburst,
	  mst13_slv4_hprot,
	  mst13_slv4_hsize,
	  mst13_slv4_htrans,
	  mst13_slv4_hwrite,
	  mst13_slv4_req,
	  mst13_slv4_sel,
	  mst13_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm13_slv5_hwdata,
	  mst13_hs5_hrdata,
	  mst13_hs5_hready,
	  mst13_hs5_hresp,
	  mst13_slv5_ack,
	  mst13_slv5_base,
	  mst13_slv5_grant,
	  mst13_slv5_haddr,
	  mst13_slv5_hburst,
	  mst13_slv5_hprot,
	  mst13_slv5_hsize,
	  mst13_slv5_htrans,
	  mst13_slv5_hwrite,
	  mst13_slv5_req,
	  mst13_slv5_sel,
	  mst13_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm13_slv6_hwdata,
	  mst13_hs6_hrdata,
	  mst13_hs6_hready,
	  mst13_hs6_hresp,
	  mst13_slv6_ack,
	  mst13_slv6_base,
	  mst13_slv6_grant,
	  mst13_slv6_haddr,
	  mst13_slv6_hburst,
	  mst13_slv6_hprot,
	  mst13_slv6_hsize,
	  mst13_slv6_htrans,
	  mst13_slv6_hwrite,
	  mst13_slv6_req,
	  mst13_slv6_sel,
	  mst13_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm13_slv7_hwdata,
	  mst13_hs7_hrdata,
	  mst13_hs7_hready,
	  mst13_hs7_hresp,
	  mst13_slv7_ack,
	  mst13_slv7_base,
	  mst13_slv7_grant,
	  mst13_slv7_haddr,
	  mst13_slv7_hburst,
	  mst13_slv7_hprot,
	  mst13_slv7_hsize,
	  mst13_slv7_htrans,
	  mst13_slv7_hwrite,
	  mst13_slv7_req,
	  mst13_slv7_sel,
	  mst13_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm13_slv8_hwdata,
	  mst13_hs8_hrdata,
	  mst13_hs8_hready,
	  mst13_hs8_hresp,
	  mst13_slv8_ack,
	  mst13_slv8_base,
	  mst13_slv8_grant,
	  mst13_slv8_haddr,
	  mst13_slv8_hburst,
	  mst13_slv8_hprot,
	  mst13_slv8_hsize,
	  mst13_slv8_htrans,
	  mst13_slv8_hwrite,
	  mst13_slv8_req,
	  mst13_slv8_sel,
	  mst13_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm13_slv9_hwdata,
	  mst13_hs9_hrdata,
	  mst13_hs9_hready,
	  mst13_hs9_hresp,
	  mst13_slv9_ack,
	  mst13_slv9_base,
	  mst13_slv9_grant,
	  mst13_slv9_haddr,
	  mst13_slv9_hburst,
	  mst13_slv9_hprot,
	  mst13_slv9_hsize,
	  mst13_slv9_htrans,
	  mst13_slv9_hwrite,
	  mst13_slv9_req,
	  mst13_slv9_sel,
	  mst13_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm13_slv10_hwdata,
	  mst13_hs10_hrdata,
	  mst13_hs10_hready,
	  mst13_hs10_hresp,
	  mst13_slv10_ack,
	  mst13_slv10_base,
	  mst13_slv10_grant,
	  mst13_slv10_haddr,
	  mst13_slv10_hburst,
	  mst13_slv10_hprot,
	  mst13_slv10_hsize,
	  mst13_slv10_htrans,
	  mst13_slv10_hwrite,
	  mst13_slv10_req,
	  mst13_slv10_sel,
	  mst13_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm13_slv11_hwdata,
	  mst13_hs11_hrdata,
	  mst13_hs11_hready,
	  mst13_hs11_hresp,
	  mst13_slv11_ack,
	  mst13_slv11_base,
	  mst13_slv11_grant,
	  mst13_slv11_haddr,
	  mst13_slv11_hburst,
	  mst13_slv11_hprot,
	  mst13_slv11_hsize,
	  mst13_slv11_htrans,
	  mst13_slv11_hwrite,
	  mst13_slv11_req,
	  mst13_slv11_sel,
	  mst13_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm13_slv12_hwdata,
	  mst13_hs12_hrdata,
	  mst13_hs12_hready,
	  mst13_hs12_hresp,
	  mst13_slv12_ack,
	  mst13_slv12_base,
	  mst13_slv12_grant,
	  mst13_slv12_haddr,
	  mst13_slv12_hburst,
	  mst13_slv12_hprot,
	  mst13_slv12_hsize,
	  mst13_slv12_htrans,
	  mst13_slv12_hwrite,
	  mst13_slv12_req,
	  mst13_slv12_sel,
	  mst13_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm13_slv13_hwdata,
	  mst13_hs13_hrdata,
	  mst13_hs13_hready,
	  mst13_hs13_hresp,
	  mst13_slv13_ack,
	  mst13_slv13_base,
	  mst13_slv13_grant,
	  mst13_slv13_haddr,
	  mst13_slv13_hburst,
	  mst13_slv13_hprot,
	  mst13_slv13_hsize,
	  mst13_slv13_htrans,
	  mst13_slv13_hwrite,
	  mst13_slv13_req,
	  mst13_slv13_sel,
	  mst13_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm13_slv14_hwdata,
	  mst13_hs14_hrdata,
	  mst13_hs14_hready,
	  mst13_hs14_hresp,
	  mst13_slv14_ack,
	  mst13_slv14_base,
	  mst13_slv14_grant,
	  mst13_slv14_haddr,
	  mst13_slv14_hburst,
	  mst13_slv14_hprot,
	  mst13_slv14_hsize,
	  mst13_slv14_htrans,
	  mst13_slv14_hwrite,
	  mst13_slv14_req,
	  mst13_slv14_sel,
	  mst13_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm13_slv15_hwdata,
	  mst13_hs15_hrdata,
	  mst13_hs15_hready,
	  mst13_hs15_hresp,
	  mst13_slv15_ack,
	  mst13_slv15_base,
	  mst13_slv15_grant,
	  mst13_slv15_haddr,
	  mst13_slv15_hburst,
	  mst13_slv15_hprot,
	  mst13_slv15_hsize,
	  mst13_slv15_htrans,
	  mst13_slv15_hwrite,
	  mst13_slv15_req,
	  mst13_slv15_sel,
	  mst13_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST14
	  hm14_slv0_hwdata,
	  mst14_hs0_hrdata,
	  mst14_hs0_hready,
	  mst14_hs0_hresp,
	  mst14_slv0_ack,
	  mst14_slv0_base,
	  mst14_slv0_grant,
	  mst14_slv0_haddr,
	  mst14_slv0_hburst,
	  mst14_slv0_hprot,
	  mst14_slv0_hsize,
	  mst14_slv0_htrans,
	  mst14_slv0_hwrite,
	  mst14_slv0_req,
	  mst14_slv0_sel,
	  mst14_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST14
   `ifdef ATCBMC200_AHB_SLV1
	  hm14_slv1_hwdata,
	  mst14_hs1_hrdata,
	  mst14_hs1_hready,
	  mst14_hs1_hresp,
	  mst14_slv1_ack,
	  mst14_slv1_base,
	  mst14_slv1_grant,
	  mst14_slv1_haddr,
	  mst14_slv1_hburst,
	  mst14_slv1_hprot,
	  mst14_slv1_hsize,
	  mst14_slv1_htrans,
	  mst14_slv1_hwrite,
	  mst14_slv1_req,
	  mst14_slv1_sel,
	  mst14_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm14_slv2_hwdata,
	  mst14_hs2_hrdata,
	  mst14_hs2_hready,
	  mst14_hs2_hresp,
	  mst14_slv2_ack,
	  mst14_slv2_base,
	  mst14_slv2_grant,
	  mst14_slv2_haddr,
	  mst14_slv2_hburst,
	  mst14_slv2_hprot,
	  mst14_slv2_hsize,
	  mst14_slv2_htrans,
	  mst14_slv2_hwrite,
	  mst14_slv2_req,
	  mst14_slv2_sel,
	  mst14_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm14_slv3_hwdata,
	  mst14_hs3_hrdata,
	  mst14_hs3_hready,
	  mst14_hs3_hresp,
	  mst14_slv3_ack,
	  mst14_slv3_base,
	  mst14_slv3_grant,
	  mst14_slv3_haddr,
	  mst14_slv3_hburst,
	  mst14_slv3_hprot,
	  mst14_slv3_hsize,
	  mst14_slv3_htrans,
	  mst14_slv3_hwrite,
	  mst14_slv3_req,
	  mst14_slv3_sel,
	  mst14_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm14_slv4_hwdata,
	  mst14_hs4_hrdata,
	  mst14_hs4_hready,
	  mst14_hs4_hresp,
	  mst14_slv4_ack,
	  mst14_slv4_base,
	  mst14_slv4_grant,
	  mst14_slv4_haddr,
	  mst14_slv4_hburst,
	  mst14_slv4_hprot,
	  mst14_slv4_hsize,
	  mst14_slv4_htrans,
	  mst14_slv4_hwrite,
	  mst14_slv4_req,
	  mst14_slv4_sel,
	  mst14_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm14_slv5_hwdata,
	  mst14_hs5_hrdata,
	  mst14_hs5_hready,
	  mst14_hs5_hresp,
	  mst14_slv5_ack,
	  mst14_slv5_base,
	  mst14_slv5_grant,
	  mst14_slv5_haddr,
	  mst14_slv5_hburst,
	  mst14_slv5_hprot,
	  mst14_slv5_hsize,
	  mst14_slv5_htrans,
	  mst14_slv5_hwrite,
	  mst14_slv5_req,
	  mst14_slv5_sel,
	  mst14_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm14_slv6_hwdata,
	  mst14_hs6_hrdata,
	  mst14_hs6_hready,
	  mst14_hs6_hresp,
	  mst14_slv6_ack,
	  mst14_slv6_base,
	  mst14_slv6_grant,
	  mst14_slv6_haddr,
	  mst14_slv6_hburst,
	  mst14_slv6_hprot,
	  mst14_slv6_hsize,
	  mst14_slv6_htrans,
	  mst14_slv6_hwrite,
	  mst14_slv6_req,
	  mst14_slv6_sel,
	  mst14_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm14_slv7_hwdata,
	  mst14_hs7_hrdata,
	  mst14_hs7_hready,
	  mst14_hs7_hresp,
	  mst14_slv7_ack,
	  mst14_slv7_base,
	  mst14_slv7_grant,
	  mst14_slv7_haddr,
	  mst14_slv7_hburst,
	  mst14_slv7_hprot,
	  mst14_slv7_hsize,
	  mst14_slv7_htrans,
	  mst14_slv7_hwrite,
	  mst14_slv7_req,
	  mst14_slv7_sel,
	  mst14_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm14_slv8_hwdata,
	  mst14_hs8_hrdata,
	  mst14_hs8_hready,
	  mst14_hs8_hresp,
	  mst14_slv8_ack,
	  mst14_slv8_base,
	  mst14_slv8_grant,
	  mst14_slv8_haddr,
	  mst14_slv8_hburst,
	  mst14_slv8_hprot,
	  mst14_slv8_hsize,
	  mst14_slv8_htrans,
	  mst14_slv8_hwrite,
	  mst14_slv8_req,
	  mst14_slv8_sel,
	  mst14_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm14_slv9_hwdata,
	  mst14_hs9_hrdata,
	  mst14_hs9_hready,
	  mst14_hs9_hresp,
	  mst14_slv9_ack,
	  mst14_slv9_base,
	  mst14_slv9_grant,
	  mst14_slv9_haddr,
	  mst14_slv9_hburst,
	  mst14_slv9_hprot,
	  mst14_slv9_hsize,
	  mst14_slv9_htrans,
	  mst14_slv9_hwrite,
	  mst14_slv9_req,
	  mst14_slv9_sel,
	  mst14_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm14_slv10_hwdata,
	  mst14_hs10_hrdata,
	  mst14_hs10_hready,
	  mst14_hs10_hresp,
	  mst14_slv10_ack,
	  mst14_slv10_base,
	  mst14_slv10_grant,
	  mst14_slv10_haddr,
	  mst14_slv10_hburst,
	  mst14_slv10_hprot,
	  mst14_slv10_hsize,
	  mst14_slv10_htrans,
	  mst14_slv10_hwrite,
	  mst14_slv10_req,
	  mst14_slv10_sel,
	  mst14_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm14_slv11_hwdata,
	  mst14_hs11_hrdata,
	  mst14_hs11_hready,
	  mst14_hs11_hresp,
	  mst14_slv11_ack,
	  mst14_slv11_base,
	  mst14_slv11_grant,
	  mst14_slv11_haddr,
	  mst14_slv11_hburst,
	  mst14_slv11_hprot,
	  mst14_slv11_hsize,
	  mst14_slv11_htrans,
	  mst14_slv11_hwrite,
	  mst14_slv11_req,
	  mst14_slv11_sel,
	  mst14_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm14_slv12_hwdata,
	  mst14_hs12_hrdata,
	  mst14_hs12_hready,
	  mst14_hs12_hresp,
	  mst14_slv12_ack,
	  mst14_slv12_base,
	  mst14_slv12_grant,
	  mst14_slv12_haddr,
	  mst14_slv12_hburst,
	  mst14_slv12_hprot,
	  mst14_slv12_hsize,
	  mst14_slv12_htrans,
	  mst14_slv12_hwrite,
	  mst14_slv12_req,
	  mst14_slv12_sel,
	  mst14_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm14_slv13_hwdata,
	  mst14_hs13_hrdata,
	  mst14_hs13_hready,
	  mst14_hs13_hresp,
	  mst14_slv13_ack,
	  mst14_slv13_base,
	  mst14_slv13_grant,
	  mst14_slv13_haddr,
	  mst14_slv13_hburst,
	  mst14_slv13_hprot,
	  mst14_slv13_hsize,
	  mst14_slv13_htrans,
	  mst14_slv13_hwrite,
	  mst14_slv13_req,
	  mst14_slv13_sel,
	  mst14_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm14_slv14_hwdata,
	  mst14_hs14_hrdata,
	  mst14_hs14_hready,
	  mst14_hs14_hresp,
	  mst14_slv14_ack,
	  mst14_slv14_base,
	  mst14_slv14_grant,
	  mst14_slv14_haddr,
	  mst14_slv14_hburst,
	  mst14_slv14_hprot,
	  mst14_slv14_hsize,
	  mst14_slv14_htrans,
	  mst14_slv14_hwrite,
	  mst14_slv14_req,
	  mst14_slv14_sel,
	  mst14_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm14_slv15_hwdata,
	  mst14_hs15_hrdata,
	  mst14_hs15_hready,
	  mst14_hs15_hresp,
	  mst14_slv15_ack,
	  mst14_slv15_base,
	  mst14_slv15_grant,
	  mst14_slv15_haddr,
	  mst14_slv15_hburst,
	  mst14_slv15_hprot,
	  mst14_slv15_hsize,
	  mst14_slv15_htrans,
	  mst14_slv15_hwrite,
	  mst14_slv15_req,
	  mst14_slv15_sel,
	  mst14_slv15_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST15
	  hm15_slv0_hwdata,
	  mst15_hs0_hrdata,
	  mst15_hs0_hready,
	  mst15_hs0_hresp,
	  mst15_slv0_ack,
	  mst15_slv0_base,
	  mst15_slv0_grant,
	  mst15_slv0_haddr,
	  mst15_slv0_hburst,
	  mst15_slv0_hprot,
	  mst15_slv0_hsize,
	  mst15_slv0_htrans,
	  mst15_slv0_hwrite,
	  mst15_slv0_req,
	  mst15_slv0_sel,
	  mst15_slv0_size,
   `endif
`endif
`ifdef ATCBMC200_AHB_MST15
   `ifdef ATCBMC200_AHB_SLV1
	  hm15_slv1_hwdata,
	  mst15_hs1_hrdata,
	  mst15_hs1_hready,
	  mst15_hs1_hresp,
	  mst15_slv1_ack,
	  mst15_slv1_base,
	  mst15_slv1_grant,
	  mst15_slv1_haddr,
	  mst15_slv1_hburst,
	  mst15_slv1_hprot,
	  mst15_slv1_hsize,
	  mst15_slv1_htrans,
	  mst15_slv1_hwrite,
	  mst15_slv1_req,
	  mst15_slv1_sel,
	  mst15_slv1_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV2
	  hm15_slv2_hwdata,
	  mst15_hs2_hrdata,
	  mst15_hs2_hready,
	  mst15_hs2_hresp,
	  mst15_slv2_ack,
	  mst15_slv2_base,
	  mst15_slv2_grant,
	  mst15_slv2_haddr,
	  mst15_slv2_hburst,
	  mst15_slv2_hprot,
	  mst15_slv2_hsize,
	  mst15_slv2_htrans,
	  mst15_slv2_hwrite,
	  mst15_slv2_req,
	  mst15_slv2_sel,
	  mst15_slv2_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV3
	  hm15_slv3_hwdata,
	  mst15_hs3_hrdata,
	  mst15_hs3_hready,
	  mst15_hs3_hresp,
	  mst15_slv3_ack,
	  mst15_slv3_base,
	  mst15_slv3_grant,
	  mst15_slv3_haddr,
	  mst15_slv3_hburst,
	  mst15_slv3_hprot,
	  mst15_slv3_hsize,
	  mst15_slv3_htrans,
	  mst15_slv3_hwrite,
	  mst15_slv3_req,
	  mst15_slv3_sel,
	  mst15_slv3_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV4
	  hm15_slv4_hwdata,
	  mst15_hs4_hrdata,
	  mst15_hs4_hready,
	  mst15_hs4_hresp,
	  mst15_slv4_ack,
	  mst15_slv4_base,
	  mst15_slv4_grant,
	  mst15_slv4_haddr,
	  mst15_slv4_hburst,
	  mst15_slv4_hprot,
	  mst15_slv4_hsize,
	  mst15_slv4_htrans,
	  mst15_slv4_hwrite,
	  mst15_slv4_req,
	  mst15_slv4_sel,
	  mst15_slv4_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV5
	  hm15_slv5_hwdata,
	  mst15_hs5_hrdata,
	  mst15_hs5_hready,
	  mst15_hs5_hresp,
	  mst15_slv5_ack,
	  mst15_slv5_base,
	  mst15_slv5_grant,
	  mst15_slv5_haddr,
	  mst15_slv5_hburst,
	  mst15_slv5_hprot,
	  mst15_slv5_hsize,
	  mst15_slv5_htrans,
	  mst15_slv5_hwrite,
	  mst15_slv5_req,
	  mst15_slv5_sel,
	  mst15_slv5_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV6
	  hm15_slv6_hwdata,
	  mst15_hs6_hrdata,
	  mst15_hs6_hready,
	  mst15_hs6_hresp,
	  mst15_slv6_ack,
	  mst15_slv6_base,
	  mst15_slv6_grant,
	  mst15_slv6_haddr,
	  mst15_slv6_hburst,
	  mst15_slv6_hprot,
	  mst15_slv6_hsize,
	  mst15_slv6_htrans,
	  mst15_slv6_hwrite,
	  mst15_slv6_req,
	  mst15_slv6_sel,
	  mst15_slv6_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV7
	  hm15_slv7_hwdata,
	  mst15_hs7_hrdata,
	  mst15_hs7_hready,
	  mst15_hs7_hresp,
	  mst15_slv7_ack,
	  mst15_slv7_base,
	  mst15_slv7_grant,
	  mst15_slv7_haddr,
	  mst15_slv7_hburst,
	  mst15_slv7_hprot,
	  mst15_slv7_hsize,
	  mst15_slv7_htrans,
	  mst15_slv7_hwrite,
	  mst15_slv7_req,
	  mst15_slv7_sel,
	  mst15_slv7_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV8
	  hm15_slv8_hwdata,
	  mst15_hs8_hrdata,
	  mst15_hs8_hready,
	  mst15_hs8_hresp,
	  mst15_slv8_ack,
	  mst15_slv8_base,
	  mst15_slv8_grant,
	  mst15_slv8_haddr,
	  mst15_slv8_hburst,
	  mst15_slv8_hprot,
	  mst15_slv8_hsize,
	  mst15_slv8_htrans,
	  mst15_slv8_hwrite,
	  mst15_slv8_req,
	  mst15_slv8_sel,
	  mst15_slv8_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV9
	  hm15_slv9_hwdata,
	  mst15_hs9_hrdata,
	  mst15_hs9_hready,
	  mst15_hs9_hresp,
	  mst15_slv9_ack,
	  mst15_slv9_base,
	  mst15_slv9_grant,
	  mst15_slv9_haddr,
	  mst15_slv9_hburst,
	  mst15_slv9_hprot,
	  mst15_slv9_hsize,
	  mst15_slv9_htrans,
	  mst15_slv9_hwrite,
	  mst15_slv9_req,
	  mst15_slv9_sel,
	  mst15_slv9_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV10
	  hm15_slv10_hwdata,
	  mst15_hs10_hrdata,
	  mst15_hs10_hready,
	  mst15_hs10_hresp,
	  mst15_slv10_ack,
	  mst15_slv10_base,
	  mst15_slv10_grant,
	  mst15_slv10_haddr,
	  mst15_slv10_hburst,
	  mst15_slv10_hprot,
	  mst15_slv10_hsize,
	  mst15_slv10_htrans,
	  mst15_slv10_hwrite,
	  mst15_slv10_req,
	  mst15_slv10_sel,
	  mst15_slv10_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV11
	  hm15_slv11_hwdata,
	  mst15_hs11_hrdata,
	  mst15_hs11_hready,
	  mst15_hs11_hresp,
	  mst15_slv11_ack,
	  mst15_slv11_base,
	  mst15_slv11_grant,
	  mst15_slv11_haddr,
	  mst15_slv11_hburst,
	  mst15_slv11_hprot,
	  mst15_slv11_hsize,
	  mst15_slv11_htrans,
	  mst15_slv11_hwrite,
	  mst15_slv11_req,
	  mst15_slv11_sel,
	  mst15_slv11_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV12
	  hm15_slv12_hwdata,
	  mst15_hs12_hrdata,
	  mst15_hs12_hready,
	  mst15_hs12_hresp,
	  mst15_slv12_ack,
	  mst15_slv12_base,
	  mst15_slv12_grant,
	  mst15_slv12_haddr,
	  mst15_slv12_hburst,
	  mst15_slv12_hprot,
	  mst15_slv12_hsize,
	  mst15_slv12_htrans,
	  mst15_slv12_hwrite,
	  mst15_slv12_req,
	  mst15_slv12_sel,
	  mst15_slv12_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV13
	  hm15_slv13_hwdata,
	  mst15_hs13_hrdata,
	  mst15_hs13_hready,
	  mst15_hs13_hresp,
	  mst15_slv13_ack,
	  mst15_slv13_base,
	  mst15_slv13_grant,
	  mst15_slv13_haddr,
	  mst15_slv13_hburst,
	  mst15_slv13_hprot,
	  mst15_slv13_hsize,
	  mst15_slv13_htrans,
	  mst15_slv13_hwrite,
	  mst15_slv13_req,
	  mst15_slv13_sel,
	  mst15_slv13_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV14
	  hm15_slv14_hwdata,
	  mst15_hs14_hrdata,
	  mst15_hs14_hready,
	  mst15_hs14_hresp,
	  mst15_slv14_ack,
	  mst15_slv14_base,
	  mst15_slv14_grant,
	  mst15_slv14_haddr,
	  mst15_slv14_hburst,
	  mst15_slv14_hprot,
	  mst15_slv14_hsize,
	  mst15_slv14_htrans,
	  mst15_slv14_hwrite,
	  mst15_slv14_req,
	  mst15_slv14_sel,
	  mst15_slv14_size,
   `endif
   `ifdef ATCBMC200_AHB_SLV15
	  hm15_slv15_hwdata,
	  mst15_hs15_hrdata,
	  mst15_hs15_hready,
	  mst15_hs15_hresp,
	  mst15_slv15_ack,
	  mst15_slv15_base,
	  mst15_slv15_grant,
	  mst15_slv15_haddr,
	  mst15_slv15_hburst,
	  mst15_slv15_hprot,
	  mst15_slv15_hsize,
	  mst15_slv15_htrans,
	  mst15_slv15_hwrite,
	  mst15_slv15_req,
	  mst15_slv15_sel,
	  mst15_slv15_size,
   `endif
`endif
	  hs0_hrdata,
	  hs0_hready,
	  hs0_hresp,
	  slv0_base,
	  slv0_size
);

parameter ADDR_WIDTH = `ATCBMC200_ADDR_MSB + 1;
parameter DATA_WIDTH = `ATCBMC200_DATA_WIDTH;
parameter BASE_ADDR_LSB = (ADDR_WIDTH == 24) ? 10 : 20;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;

`ifdef ATCBMC200_AHB_MST0
input                   [DATA_MSB:0] hm0_hwdata;
input                   [ADDR_MSB:0] mst0_haddr;
input                          [2:0] mst0_hburst;
input                          [3:0] mst0_hprot;
input                          [2:0] mst0_hsize;
input                          [1:0] mst0_htrans;
input                                mst0_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST1
input                   [DATA_MSB:0] hm1_hwdata;
input                   [ADDR_MSB:0] mst1_haddr;
input                          [2:0] mst1_hburst;
input                          [3:0] mst1_hprot;
input                          [2:0] mst1_hsize;
input                          [1:0] mst1_htrans;
input                                mst1_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST2
input                   [DATA_MSB:0] hm2_hwdata;
input                   [ADDR_MSB:0] mst2_haddr;
input                          [2:0] mst2_hburst;
input                          [3:0] mst2_hprot;
input                          [2:0] mst2_hsize;
input                          [1:0] mst2_htrans;
input                                mst2_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST3
input                   [DATA_MSB:0] hm3_hwdata;
input                   [ADDR_MSB:0] mst3_haddr;
input                          [2:0] mst3_hburst;
input                          [3:0] mst3_hprot;
input                          [2:0] mst3_hsize;
input                          [1:0] mst3_htrans;
input                                mst3_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST4
input                   [DATA_MSB:0] hm4_hwdata;
input                   [ADDR_MSB:0] mst4_haddr;
input                          [2:0] mst4_hburst;
input                          [3:0] mst4_hprot;
input                          [2:0] mst4_hsize;
input                          [1:0] mst4_htrans;
input                                mst4_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST5
input                   [DATA_MSB:0] hm5_hwdata;
input                   [ADDR_MSB:0] mst5_haddr;
input                          [2:0] mst5_hburst;
input                          [3:0] mst5_hprot;
input                          [2:0] mst5_hsize;
input                          [1:0] mst5_htrans;
input                                mst5_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST6
input                   [DATA_MSB:0] hm6_hwdata;
input                   [ADDR_MSB:0] mst6_haddr;
input                          [2:0] mst6_hburst;
input                          [3:0] mst6_hprot;
input                          [2:0] mst6_hsize;
input                          [1:0] mst6_htrans;
input                                mst6_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST7
input                   [DATA_MSB:0] hm7_hwdata;
input                   [ADDR_MSB:0] mst7_haddr;
input                          [2:0] mst7_hburst;
input                          [3:0] mst7_hprot;
input                          [2:0] mst7_hsize;
input                          [1:0] mst7_htrans;
input                                mst7_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST8
input                   [DATA_MSB:0] hm8_hwdata;
input                   [ADDR_MSB:0] mst8_haddr;
input                          [2:0] mst8_hburst;
input                          [3:0] mst8_hprot;
input                          [2:0] mst8_hsize;
input                          [1:0] mst8_htrans;
input                                mst8_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST9
input                   [DATA_MSB:0] hm9_hwdata;
input                   [ADDR_MSB:0] mst9_haddr;
input                          [2:0] mst9_hburst;
input                          [3:0] mst9_hprot;
input                          [2:0] mst9_hsize;
input                          [1:0] mst9_htrans;
input                                mst9_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST10
input                   [DATA_MSB:0] hm10_hwdata;
input                   [ADDR_MSB:0] mst10_haddr;
input                          [2:0] mst10_hburst;
input                          [3:0] mst10_hprot;
input                          [2:0] mst10_hsize;
input                          [1:0] mst10_htrans;
input                                mst10_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST11
input                   [DATA_MSB:0] hm11_hwdata;
input                   [ADDR_MSB:0] mst11_haddr;
input                          [2:0] mst11_hburst;
input                          [3:0] mst11_hprot;
input                          [2:0] mst11_hsize;
input                          [1:0] mst11_htrans;
input                                mst11_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST12
input                   [DATA_MSB:0] hm12_hwdata;
input                   [ADDR_MSB:0] mst12_haddr;
input                          [2:0] mst12_hburst;
input                          [3:0] mst12_hprot;
input                          [2:0] mst12_hsize;
input                          [1:0] mst12_htrans;
input                                mst12_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST13
input                   [DATA_MSB:0] hm13_hwdata;
input                   [ADDR_MSB:0] mst13_haddr;
input                          [2:0] mst13_hburst;
input                          [3:0] mst13_hprot;
input                          [2:0] mst13_hsize;
input                          [1:0] mst13_htrans;
input                                mst13_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST14
input                   [DATA_MSB:0] hm14_hwdata;
input                   [ADDR_MSB:0] mst14_haddr;
input                          [2:0] mst14_hburst;
input                          [3:0] mst14_hprot;
input                          [2:0] mst14_hsize;
input                          [1:0] mst14_htrans;
input                                mst14_hwrite;
`endif
`ifdef ATCBMC200_AHB_MST15
input                   [DATA_MSB:0] hm15_hwdata;
input                   [ADDR_MSB:0] mst15_haddr;
input                          [2:0] mst15_hburst;
input                          [3:0] mst15_hprot;
input                          [2:0] mst15_hsize;
input                          [1:0] mst15_htrans;
input                                mst15_hwrite;
`endif
`ifdef ATCBMC200_AHB_SLV1
input                   [DATA_MSB:0] hs1_hrdata;
input                                hs1_hready;
input                          [1:0] hs1_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv1_base;
input                          [3:0] slv1_size;
`endif
`ifdef ATCBMC200_AHB_SLV2
input                   [DATA_MSB:0] hs2_hrdata;
input                                hs2_hready;
input                          [1:0] hs2_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv2_base;
input                          [3:0] slv2_size;
`endif
`ifdef ATCBMC200_AHB_SLV3
input                   [DATA_MSB:0] hs3_hrdata;
input                                hs3_hready;
input                          [1:0] hs3_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv3_base;
input                          [3:0] slv3_size;
`endif
`ifdef ATCBMC200_AHB_SLV4
input                   [DATA_MSB:0] hs4_hrdata;
input                                hs4_hready;
input                          [1:0] hs4_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv4_base;
input                          [3:0] slv4_size;
`endif
`ifdef ATCBMC200_AHB_SLV5
input                   [DATA_MSB:0] hs5_hrdata;
input                                hs5_hready;
input                          [1:0] hs5_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv5_base;
input                          [3:0] slv5_size;
`endif
`ifdef ATCBMC200_AHB_SLV6
input                   [DATA_MSB:0] hs6_hrdata;
input                                hs6_hready;
input                          [1:0] hs6_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv6_base;
input                          [3:0] slv6_size;
`endif
`ifdef ATCBMC200_AHB_SLV7
input                   [DATA_MSB:0] hs7_hrdata;
input                                hs7_hready;
input                          [1:0] hs7_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv7_base;
input                          [3:0] slv7_size;
`endif
`ifdef ATCBMC200_AHB_SLV8
input                   [DATA_MSB:0] hs8_hrdata;
input                                hs8_hready;
input                          [1:0] hs8_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv8_base;
input                          [3:0] slv8_size;
`endif
`ifdef ATCBMC200_AHB_SLV9
input                   [DATA_MSB:0] hs9_hrdata;
input                                hs9_hready;
input                          [1:0] hs9_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv9_base;
input                          [3:0] slv9_size;
`endif
`ifdef ATCBMC200_AHB_SLV10
input                   [DATA_MSB:0] hs10_hrdata;
input                                hs10_hready;
input                          [1:0] hs10_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv10_base;
input                          [3:0] slv10_size;
`endif
`ifdef ATCBMC200_AHB_SLV11
input                   [DATA_MSB:0] hs11_hrdata;
input                                hs11_hready;
input                          [1:0] hs11_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv11_base;
input                          [3:0] slv11_size;
`endif
`ifdef ATCBMC200_AHB_SLV12
input                   [DATA_MSB:0] hs12_hrdata;
input                                hs12_hready;
input                          [1:0] hs12_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv12_base;
input                          [3:0] slv12_size;
`endif
`ifdef ATCBMC200_AHB_SLV13
input                   [DATA_MSB:0] hs13_hrdata;
input                                hs13_hready;
input                          [1:0] hs13_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv13_base;
input                          [3:0] slv13_size;
`endif
`ifdef ATCBMC200_AHB_SLV14
input                   [DATA_MSB:0] hs14_hrdata;
input                                hs14_hready;
input                          [1:0] hs14_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv14_base;
input                          [3:0] slv14_size;
`endif
`ifdef ATCBMC200_AHB_SLV15
input                   [DATA_MSB:0] hs15_hrdata;
input                                hs15_hready;
input                          [1:0] hs15_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv15_base;
input                          [3:0] slv15_size;
`endif
`ifdef ATCBMC200_AHB_MST0
   `ifdef ATCBMC200_AHB_SLV0
output                  [DATA_MSB:0] hm0_slv0_hwdata;
output                  [DATA_MSB:0] mst0_hs0_hrdata;
output                               mst0_hs0_hready;
output                         [1:0] mst0_hs0_hresp;
input                                mst0_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv0_base;
output                               mst0_slv0_grant;
output                  [ADDR_MSB:0] mst0_slv0_haddr;
output                         [2:0] mst0_slv0_hburst;
output                         [3:0] mst0_slv0_hprot;
output                         [2:0] mst0_slv0_hsize;
output                         [1:0] mst0_slv0_htrans;
output                               mst0_slv0_hwrite;
output                               mst0_slv0_req;
input                                mst0_slv0_sel;
output                         [3:0] mst0_slv0_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm0_slv1_hwdata;
output                  [DATA_MSB:0] mst0_hs1_hrdata;
output                               mst0_hs1_hready;
output                         [1:0] mst0_hs1_hresp;
input                                mst0_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv1_base;
output                               mst0_slv1_grant;
output                  [ADDR_MSB:0] mst0_slv1_haddr;
output                         [2:0] mst0_slv1_hburst;
output                         [3:0] mst0_slv1_hprot;
output                         [2:0] mst0_slv1_hsize;
output                         [1:0] mst0_slv1_htrans;
output                               mst0_slv1_hwrite;
output                               mst0_slv1_req;
input                                mst0_slv1_sel;
output                         [3:0] mst0_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm0_slv2_hwdata;
output                  [DATA_MSB:0] mst0_hs2_hrdata;
output                               mst0_hs2_hready;
output                         [1:0] mst0_hs2_hresp;
input                                mst0_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv2_base;
output                               mst0_slv2_grant;
output                  [ADDR_MSB:0] mst0_slv2_haddr;
output                         [2:0] mst0_slv2_hburst;
output                         [3:0] mst0_slv2_hprot;
output                         [2:0] mst0_slv2_hsize;
output                         [1:0] mst0_slv2_htrans;
output                               mst0_slv2_hwrite;
output                               mst0_slv2_req;
input                                mst0_slv2_sel;
output                         [3:0] mst0_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm0_slv3_hwdata;
output                  [DATA_MSB:0] mst0_hs3_hrdata;
output                               mst0_hs3_hready;
output                         [1:0] mst0_hs3_hresp;
input                                mst0_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv3_base;
output                               mst0_slv3_grant;
output                  [ADDR_MSB:0] mst0_slv3_haddr;
output                         [2:0] mst0_slv3_hburst;
output                         [3:0] mst0_slv3_hprot;
output                         [2:0] mst0_slv3_hsize;
output                         [1:0] mst0_slv3_htrans;
output                               mst0_slv3_hwrite;
output                               mst0_slv3_req;
input                                mst0_slv3_sel;
output                         [3:0] mst0_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm0_slv4_hwdata;
output                  [DATA_MSB:0] mst0_hs4_hrdata;
output                               mst0_hs4_hready;
output                         [1:0] mst0_hs4_hresp;
input                                mst0_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv4_base;
output                               mst0_slv4_grant;
output                  [ADDR_MSB:0] mst0_slv4_haddr;
output                         [2:0] mst0_slv4_hburst;
output                         [3:0] mst0_slv4_hprot;
output                         [2:0] mst0_slv4_hsize;
output                         [1:0] mst0_slv4_htrans;
output                               mst0_slv4_hwrite;
output                               mst0_slv4_req;
input                                mst0_slv4_sel;
output                         [3:0] mst0_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm0_slv5_hwdata;
output                  [DATA_MSB:0] mst0_hs5_hrdata;
output                               mst0_hs5_hready;
output                         [1:0] mst0_hs5_hresp;
input                                mst0_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv5_base;
output                               mst0_slv5_grant;
output                  [ADDR_MSB:0] mst0_slv5_haddr;
output                         [2:0] mst0_slv5_hburst;
output                         [3:0] mst0_slv5_hprot;
output                         [2:0] mst0_slv5_hsize;
output                         [1:0] mst0_slv5_htrans;
output                               mst0_slv5_hwrite;
output                               mst0_slv5_req;
input                                mst0_slv5_sel;
output                         [3:0] mst0_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm0_slv6_hwdata;
output                  [DATA_MSB:0] mst0_hs6_hrdata;
output                               mst0_hs6_hready;
output                         [1:0] mst0_hs6_hresp;
input                                mst0_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv6_base;
output                               mst0_slv6_grant;
output                  [ADDR_MSB:0] mst0_slv6_haddr;
output                         [2:0] mst0_slv6_hburst;
output                         [3:0] mst0_slv6_hprot;
output                         [2:0] mst0_slv6_hsize;
output                         [1:0] mst0_slv6_htrans;
output                               mst0_slv6_hwrite;
output                               mst0_slv6_req;
input                                mst0_slv6_sel;
output                         [3:0] mst0_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm0_slv7_hwdata;
output                  [DATA_MSB:0] mst0_hs7_hrdata;
output                               mst0_hs7_hready;
output                         [1:0] mst0_hs7_hresp;
input                                mst0_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv7_base;
output                               mst0_slv7_grant;
output                  [ADDR_MSB:0] mst0_slv7_haddr;
output                         [2:0] mst0_slv7_hburst;
output                         [3:0] mst0_slv7_hprot;
output                         [2:0] mst0_slv7_hsize;
output                         [1:0] mst0_slv7_htrans;
output                               mst0_slv7_hwrite;
output                               mst0_slv7_req;
input                                mst0_slv7_sel;
output                         [3:0] mst0_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm0_slv8_hwdata;
output                  [DATA_MSB:0] mst0_hs8_hrdata;
output                               mst0_hs8_hready;
output                         [1:0] mst0_hs8_hresp;
input                                mst0_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv8_base;
output                               mst0_slv8_grant;
output                  [ADDR_MSB:0] mst0_slv8_haddr;
output                         [2:0] mst0_slv8_hburst;
output                         [3:0] mst0_slv8_hprot;
output                         [2:0] mst0_slv8_hsize;
output                         [1:0] mst0_slv8_htrans;
output                               mst0_slv8_hwrite;
output                               mst0_slv8_req;
input                                mst0_slv8_sel;
output                         [3:0] mst0_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm0_slv9_hwdata;
output                  [DATA_MSB:0] mst0_hs9_hrdata;
output                               mst0_hs9_hready;
output                         [1:0] mst0_hs9_hresp;
input                                mst0_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv9_base;
output                               mst0_slv9_grant;
output                  [ADDR_MSB:0] mst0_slv9_haddr;
output                         [2:0] mst0_slv9_hburst;
output                         [3:0] mst0_slv9_hprot;
output                         [2:0] mst0_slv9_hsize;
output                         [1:0] mst0_slv9_htrans;
output                               mst0_slv9_hwrite;
output                               mst0_slv9_req;
input                                mst0_slv9_sel;
output                         [3:0] mst0_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm0_slv10_hwdata;
output                  [DATA_MSB:0] mst0_hs10_hrdata;
output                               mst0_hs10_hready;
output                         [1:0] mst0_hs10_hresp;
input                                mst0_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv10_base;
output                               mst0_slv10_grant;
output                  [ADDR_MSB:0] mst0_slv10_haddr;
output                         [2:0] mst0_slv10_hburst;
output                         [3:0] mst0_slv10_hprot;
output                         [2:0] mst0_slv10_hsize;
output                         [1:0] mst0_slv10_htrans;
output                               mst0_slv10_hwrite;
output                               mst0_slv10_req;
input                                mst0_slv10_sel;
output                         [3:0] mst0_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm0_slv11_hwdata;
output                  [DATA_MSB:0] mst0_hs11_hrdata;
output                               mst0_hs11_hready;
output                         [1:0] mst0_hs11_hresp;
input                                mst0_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv11_base;
output                               mst0_slv11_grant;
output                  [ADDR_MSB:0] mst0_slv11_haddr;
output                         [2:0] mst0_slv11_hburst;
output                         [3:0] mst0_slv11_hprot;
output                         [2:0] mst0_slv11_hsize;
output                         [1:0] mst0_slv11_htrans;
output                               mst0_slv11_hwrite;
output                               mst0_slv11_req;
input                                mst0_slv11_sel;
output                         [3:0] mst0_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm0_slv12_hwdata;
output                  [DATA_MSB:0] mst0_hs12_hrdata;
output                               mst0_hs12_hready;
output                         [1:0] mst0_hs12_hresp;
input                                mst0_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv12_base;
output                               mst0_slv12_grant;
output                  [ADDR_MSB:0] mst0_slv12_haddr;
output                         [2:0] mst0_slv12_hburst;
output                         [3:0] mst0_slv12_hprot;
output                         [2:0] mst0_slv12_hsize;
output                         [1:0] mst0_slv12_htrans;
output                               mst0_slv12_hwrite;
output                               mst0_slv12_req;
input                                mst0_slv12_sel;
output                         [3:0] mst0_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm0_slv13_hwdata;
output                  [DATA_MSB:0] mst0_hs13_hrdata;
output                               mst0_hs13_hready;
output                         [1:0] mst0_hs13_hresp;
input                                mst0_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv13_base;
output                               mst0_slv13_grant;
output                  [ADDR_MSB:0] mst0_slv13_haddr;
output                         [2:0] mst0_slv13_hburst;
output                         [3:0] mst0_slv13_hprot;
output                         [2:0] mst0_slv13_hsize;
output                         [1:0] mst0_slv13_htrans;
output                               mst0_slv13_hwrite;
output                               mst0_slv13_req;
input                                mst0_slv13_sel;
output                         [3:0] mst0_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm0_slv14_hwdata;
output                  [DATA_MSB:0] mst0_hs14_hrdata;
output                               mst0_hs14_hready;
output                         [1:0] mst0_hs14_hresp;
input                                mst0_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv14_base;
output                               mst0_slv14_grant;
output                  [ADDR_MSB:0] mst0_slv14_haddr;
output                         [2:0] mst0_slv14_hburst;
output                         [3:0] mst0_slv14_hprot;
output                         [2:0] mst0_slv14_hsize;
output                         [1:0] mst0_slv14_htrans;
output                               mst0_slv14_hwrite;
output                               mst0_slv14_req;
input                                mst0_slv14_sel;
output                         [3:0] mst0_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm0_slv15_hwdata;
output                  [DATA_MSB:0] mst0_hs15_hrdata;
output                               mst0_hs15_hready;
output                         [1:0] mst0_hs15_hresp;
input                                mst0_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst0_slv15_base;
output                               mst0_slv15_grant;
output                  [ADDR_MSB:0] mst0_slv15_haddr;
output                         [2:0] mst0_slv15_hburst;
output                         [3:0] mst0_slv15_hprot;
output                         [2:0] mst0_slv15_hsize;
output                         [1:0] mst0_slv15_htrans;
output                               mst0_slv15_hwrite;
output                               mst0_slv15_req;
input                                mst0_slv15_sel;
output                         [3:0] mst0_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST1
output                  [DATA_MSB:0] hm1_slv0_hwdata;
output                  [DATA_MSB:0] mst1_hs0_hrdata;
output                               mst1_hs0_hready;
output                         [1:0] mst1_hs0_hresp;
input                                mst1_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv0_base;
output                               mst1_slv0_grant;
output                  [ADDR_MSB:0] mst1_slv0_haddr;
output                         [2:0] mst1_slv0_hburst;
output                         [3:0] mst1_slv0_hprot;
output                         [2:0] mst1_slv0_hsize;
output                         [1:0] mst1_slv0_htrans;
output                               mst1_slv0_hwrite;
output                               mst1_slv0_req;
input                                mst1_slv0_sel;
output                         [3:0] mst1_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST1
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm1_slv1_hwdata;
output                  [DATA_MSB:0] mst1_hs1_hrdata;
output                               mst1_hs1_hready;
output                         [1:0] mst1_hs1_hresp;
input                                mst1_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv1_base;
output                               mst1_slv1_grant;
output                  [ADDR_MSB:0] mst1_slv1_haddr;
output                         [2:0] mst1_slv1_hburst;
output                         [3:0] mst1_slv1_hprot;
output                         [2:0] mst1_slv1_hsize;
output                         [1:0] mst1_slv1_htrans;
output                               mst1_slv1_hwrite;
output                               mst1_slv1_req;
input                                mst1_slv1_sel;
output                         [3:0] mst1_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm1_slv2_hwdata;
output                  [DATA_MSB:0] mst1_hs2_hrdata;
output                               mst1_hs2_hready;
output                         [1:0] mst1_hs2_hresp;
input                                mst1_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv2_base;
output                               mst1_slv2_grant;
output                  [ADDR_MSB:0] mst1_slv2_haddr;
output                         [2:0] mst1_slv2_hburst;
output                         [3:0] mst1_slv2_hprot;
output                         [2:0] mst1_slv2_hsize;
output                         [1:0] mst1_slv2_htrans;
output                               mst1_slv2_hwrite;
output                               mst1_slv2_req;
input                                mst1_slv2_sel;
output                         [3:0] mst1_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm1_slv3_hwdata;
output                  [DATA_MSB:0] mst1_hs3_hrdata;
output                               mst1_hs3_hready;
output                         [1:0] mst1_hs3_hresp;
input                                mst1_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv3_base;
output                               mst1_slv3_grant;
output                  [ADDR_MSB:0] mst1_slv3_haddr;
output                         [2:0] mst1_slv3_hburst;
output                         [3:0] mst1_slv3_hprot;
output                         [2:0] mst1_slv3_hsize;
output                         [1:0] mst1_slv3_htrans;
output                               mst1_slv3_hwrite;
output                               mst1_slv3_req;
input                                mst1_slv3_sel;
output                         [3:0] mst1_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm1_slv4_hwdata;
output                  [DATA_MSB:0] mst1_hs4_hrdata;
output                               mst1_hs4_hready;
output                         [1:0] mst1_hs4_hresp;
input                                mst1_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv4_base;
output                               mst1_slv4_grant;
output                  [ADDR_MSB:0] mst1_slv4_haddr;
output                         [2:0] mst1_slv4_hburst;
output                         [3:0] mst1_slv4_hprot;
output                         [2:0] mst1_slv4_hsize;
output                         [1:0] mst1_slv4_htrans;
output                               mst1_slv4_hwrite;
output                               mst1_slv4_req;
input                                mst1_slv4_sel;
output                         [3:0] mst1_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm1_slv5_hwdata;
output                  [DATA_MSB:0] mst1_hs5_hrdata;
output                               mst1_hs5_hready;
output                         [1:0] mst1_hs5_hresp;
input                                mst1_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv5_base;
output                               mst1_slv5_grant;
output                  [ADDR_MSB:0] mst1_slv5_haddr;
output                         [2:0] mst1_slv5_hburst;
output                         [3:0] mst1_slv5_hprot;
output                         [2:0] mst1_slv5_hsize;
output                         [1:0] mst1_slv5_htrans;
output                               mst1_slv5_hwrite;
output                               mst1_slv5_req;
input                                mst1_slv5_sel;
output                         [3:0] mst1_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm1_slv6_hwdata;
output                  [DATA_MSB:0] mst1_hs6_hrdata;
output                               mst1_hs6_hready;
output                         [1:0] mst1_hs6_hresp;
input                                mst1_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv6_base;
output                               mst1_slv6_grant;
output                  [ADDR_MSB:0] mst1_slv6_haddr;
output                         [2:0] mst1_slv6_hburst;
output                         [3:0] mst1_slv6_hprot;
output                         [2:0] mst1_slv6_hsize;
output                         [1:0] mst1_slv6_htrans;
output                               mst1_slv6_hwrite;
output                               mst1_slv6_req;
input                                mst1_slv6_sel;
output                         [3:0] mst1_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm1_slv7_hwdata;
output                  [DATA_MSB:0] mst1_hs7_hrdata;
output                               mst1_hs7_hready;
output                         [1:0] mst1_hs7_hresp;
input                                mst1_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv7_base;
output                               mst1_slv7_grant;
output                  [ADDR_MSB:0] mst1_slv7_haddr;
output                         [2:0] mst1_slv7_hburst;
output                         [3:0] mst1_slv7_hprot;
output                         [2:0] mst1_slv7_hsize;
output                         [1:0] mst1_slv7_htrans;
output                               mst1_slv7_hwrite;
output                               mst1_slv7_req;
input                                mst1_slv7_sel;
output                         [3:0] mst1_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm1_slv8_hwdata;
output                  [DATA_MSB:0] mst1_hs8_hrdata;
output                               mst1_hs8_hready;
output                         [1:0] mst1_hs8_hresp;
input                                mst1_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv8_base;
output                               mst1_slv8_grant;
output                  [ADDR_MSB:0] mst1_slv8_haddr;
output                         [2:0] mst1_slv8_hburst;
output                         [3:0] mst1_slv8_hprot;
output                         [2:0] mst1_slv8_hsize;
output                         [1:0] mst1_slv8_htrans;
output                               mst1_slv8_hwrite;
output                               mst1_slv8_req;
input                                mst1_slv8_sel;
output                         [3:0] mst1_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm1_slv9_hwdata;
output                  [DATA_MSB:0] mst1_hs9_hrdata;
output                               mst1_hs9_hready;
output                         [1:0] mst1_hs9_hresp;
input                                mst1_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv9_base;
output                               mst1_slv9_grant;
output                  [ADDR_MSB:0] mst1_slv9_haddr;
output                         [2:0] mst1_slv9_hburst;
output                         [3:0] mst1_slv9_hprot;
output                         [2:0] mst1_slv9_hsize;
output                         [1:0] mst1_slv9_htrans;
output                               mst1_slv9_hwrite;
output                               mst1_slv9_req;
input                                mst1_slv9_sel;
output                         [3:0] mst1_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm1_slv10_hwdata;
output                  [DATA_MSB:0] mst1_hs10_hrdata;
output                               mst1_hs10_hready;
output                         [1:0] mst1_hs10_hresp;
input                                mst1_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv10_base;
output                               mst1_slv10_grant;
output                  [ADDR_MSB:0] mst1_slv10_haddr;
output                         [2:0] mst1_slv10_hburst;
output                         [3:0] mst1_slv10_hprot;
output                         [2:0] mst1_slv10_hsize;
output                         [1:0] mst1_slv10_htrans;
output                               mst1_slv10_hwrite;
output                               mst1_slv10_req;
input                                mst1_slv10_sel;
output                         [3:0] mst1_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm1_slv11_hwdata;
output                  [DATA_MSB:0] mst1_hs11_hrdata;
output                               mst1_hs11_hready;
output                         [1:0] mst1_hs11_hresp;
input                                mst1_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv11_base;
output                               mst1_slv11_grant;
output                  [ADDR_MSB:0] mst1_slv11_haddr;
output                         [2:0] mst1_slv11_hburst;
output                         [3:0] mst1_slv11_hprot;
output                         [2:0] mst1_slv11_hsize;
output                         [1:0] mst1_slv11_htrans;
output                               mst1_slv11_hwrite;
output                               mst1_slv11_req;
input                                mst1_slv11_sel;
output                         [3:0] mst1_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm1_slv12_hwdata;
output                  [DATA_MSB:0] mst1_hs12_hrdata;
output                               mst1_hs12_hready;
output                         [1:0] mst1_hs12_hresp;
input                                mst1_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv12_base;
output                               mst1_slv12_grant;
output                  [ADDR_MSB:0] mst1_slv12_haddr;
output                         [2:0] mst1_slv12_hburst;
output                         [3:0] mst1_slv12_hprot;
output                         [2:0] mst1_slv12_hsize;
output                         [1:0] mst1_slv12_htrans;
output                               mst1_slv12_hwrite;
output                               mst1_slv12_req;
input                                mst1_slv12_sel;
output                         [3:0] mst1_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm1_slv13_hwdata;
output                  [DATA_MSB:0] mst1_hs13_hrdata;
output                               mst1_hs13_hready;
output                         [1:0] mst1_hs13_hresp;
input                                mst1_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv13_base;
output                               mst1_slv13_grant;
output                  [ADDR_MSB:0] mst1_slv13_haddr;
output                         [2:0] mst1_slv13_hburst;
output                         [3:0] mst1_slv13_hprot;
output                         [2:0] mst1_slv13_hsize;
output                         [1:0] mst1_slv13_htrans;
output                               mst1_slv13_hwrite;
output                               mst1_slv13_req;
input                                mst1_slv13_sel;
output                         [3:0] mst1_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm1_slv14_hwdata;
output                  [DATA_MSB:0] mst1_hs14_hrdata;
output                               mst1_hs14_hready;
output                         [1:0] mst1_hs14_hresp;
input                                mst1_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv14_base;
output                               mst1_slv14_grant;
output                  [ADDR_MSB:0] mst1_slv14_haddr;
output                         [2:0] mst1_slv14_hburst;
output                         [3:0] mst1_slv14_hprot;
output                         [2:0] mst1_slv14_hsize;
output                         [1:0] mst1_slv14_htrans;
output                               mst1_slv14_hwrite;
output                               mst1_slv14_req;
input                                mst1_slv14_sel;
output                         [3:0] mst1_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm1_slv15_hwdata;
output                  [DATA_MSB:0] mst1_hs15_hrdata;
output                               mst1_hs15_hready;
output                         [1:0] mst1_hs15_hresp;
input                                mst1_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst1_slv15_base;
output                               mst1_slv15_grant;
output                  [ADDR_MSB:0] mst1_slv15_haddr;
output                         [2:0] mst1_slv15_hburst;
output                         [3:0] mst1_slv15_hprot;
output                         [2:0] mst1_slv15_hsize;
output                         [1:0] mst1_slv15_htrans;
output                               mst1_slv15_hwrite;
output                               mst1_slv15_req;
input                                mst1_slv15_sel;
output                         [3:0] mst1_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST2
output                  [DATA_MSB:0] hm2_slv0_hwdata;
output                  [DATA_MSB:0] mst2_hs0_hrdata;
output                               mst2_hs0_hready;
output                         [1:0] mst2_hs0_hresp;
input                                mst2_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv0_base;
output                               mst2_slv0_grant;
output                  [ADDR_MSB:0] mst2_slv0_haddr;
output                         [2:0] mst2_slv0_hburst;
output                         [3:0] mst2_slv0_hprot;
output                         [2:0] mst2_slv0_hsize;
output                         [1:0] mst2_slv0_htrans;
output                               mst2_slv0_hwrite;
output                               mst2_slv0_req;
input                                mst2_slv0_sel;
output                         [3:0] mst2_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST2
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm2_slv1_hwdata;
output                  [DATA_MSB:0] mst2_hs1_hrdata;
output                               mst2_hs1_hready;
output                         [1:0] mst2_hs1_hresp;
input                                mst2_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv1_base;
output                               mst2_slv1_grant;
output                  [ADDR_MSB:0] mst2_slv1_haddr;
output                         [2:0] mst2_slv1_hburst;
output                         [3:0] mst2_slv1_hprot;
output                         [2:0] mst2_slv1_hsize;
output                         [1:0] mst2_slv1_htrans;
output                               mst2_slv1_hwrite;
output                               mst2_slv1_req;
input                                mst2_slv1_sel;
output                         [3:0] mst2_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm2_slv2_hwdata;
output                  [DATA_MSB:0] mst2_hs2_hrdata;
output                               mst2_hs2_hready;
output                         [1:0] mst2_hs2_hresp;
input                                mst2_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv2_base;
output                               mst2_slv2_grant;
output                  [ADDR_MSB:0] mst2_slv2_haddr;
output                         [2:0] mst2_slv2_hburst;
output                         [3:0] mst2_slv2_hprot;
output                         [2:0] mst2_slv2_hsize;
output                         [1:0] mst2_slv2_htrans;
output                               mst2_slv2_hwrite;
output                               mst2_slv2_req;
input                                mst2_slv2_sel;
output                         [3:0] mst2_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm2_slv3_hwdata;
output                  [DATA_MSB:0] mst2_hs3_hrdata;
output                               mst2_hs3_hready;
output                         [1:0] mst2_hs3_hresp;
input                                mst2_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv3_base;
output                               mst2_slv3_grant;
output                  [ADDR_MSB:0] mst2_slv3_haddr;
output                         [2:0] mst2_slv3_hburst;
output                         [3:0] mst2_slv3_hprot;
output                         [2:0] mst2_slv3_hsize;
output                         [1:0] mst2_slv3_htrans;
output                               mst2_slv3_hwrite;
output                               mst2_slv3_req;
input                                mst2_slv3_sel;
output                         [3:0] mst2_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm2_slv4_hwdata;
output                  [DATA_MSB:0] mst2_hs4_hrdata;
output                               mst2_hs4_hready;
output                         [1:0] mst2_hs4_hresp;
input                                mst2_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv4_base;
output                               mst2_slv4_grant;
output                  [ADDR_MSB:0] mst2_slv4_haddr;
output                         [2:0] mst2_slv4_hburst;
output                         [3:0] mst2_slv4_hprot;
output                         [2:0] mst2_slv4_hsize;
output                         [1:0] mst2_slv4_htrans;
output                               mst2_slv4_hwrite;
output                               mst2_slv4_req;
input                                mst2_slv4_sel;
output                         [3:0] mst2_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm2_slv5_hwdata;
output                  [DATA_MSB:0] mst2_hs5_hrdata;
output                               mst2_hs5_hready;
output                         [1:0] mst2_hs5_hresp;
input                                mst2_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv5_base;
output                               mst2_slv5_grant;
output                  [ADDR_MSB:0] mst2_slv5_haddr;
output                         [2:0] mst2_slv5_hburst;
output                         [3:0] mst2_slv5_hprot;
output                         [2:0] mst2_slv5_hsize;
output                         [1:0] mst2_slv5_htrans;
output                               mst2_slv5_hwrite;
output                               mst2_slv5_req;
input                                mst2_slv5_sel;
output                         [3:0] mst2_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm2_slv6_hwdata;
output                  [DATA_MSB:0] mst2_hs6_hrdata;
output                               mst2_hs6_hready;
output                         [1:0] mst2_hs6_hresp;
input                                mst2_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv6_base;
output                               mst2_slv6_grant;
output                  [ADDR_MSB:0] mst2_slv6_haddr;
output                         [2:0] mst2_slv6_hburst;
output                         [3:0] mst2_slv6_hprot;
output                         [2:0] mst2_slv6_hsize;
output                         [1:0] mst2_slv6_htrans;
output                               mst2_slv6_hwrite;
output                               mst2_slv6_req;
input                                mst2_slv6_sel;
output                         [3:0] mst2_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm2_slv7_hwdata;
output                  [DATA_MSB:0] mst2_hs7_hrdata;
output                               mst2_hs7_hready;
output                         [1:0] mst2_hs7_hresp;
input                                mst2_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv7_base;
output                               mst2_slv7_grant;
output                  [ADDR_MSB:0] mst2_slv7_haddr;
output                         [2:0] mst2_slv7_hburst;
output                         [3:0] mst2_slv7_hprot;
output                         [2:0] mst2_slv7_hsize;
output                         [1:0] mst2_slv7_htrans;
output                               mst2_slv7_hwrite;
output                               mst2_slv7_req;
input                                mst2_slv7_sel;
output                         [3:0] mst2_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm2_slv8_hwdata;
output                  [DATA_MSB:0] mst2_hs8_hrdata;
output                               mst2_hs8_hready;
output                         [1:0] mst2_hs8_hresp;
input                                mst2_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv8_base;
output                               mst2_slv8_grant;
output                  [ADDR_MSB:0] mst2_slv8_haddr;
output                         [2:0] mst2_slv8_hburst;
output                         [3:0] mst2_slv8_hprot;
output                         [2:0] mst2_slv8_hsize;
output                         [1:0] mst2_slv8_htrans;
output                               mst2_slv8_hwrite;
output                               mst2_slv8_req;
input                                mst2_slv8_sel;
output                         [3:0] mst2_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm2_slv9_hwdata;
output                  [DATA_MSB:0] mst2_hs9_hrdata;
output                               mst2_hs9_hready;
output                         [1:0] mst2_hs9_hresp;
input                                mst2_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv9_base;
output                               mst2_slv9_grant;
output                  [ADDR_MSB:0] mst2_slv9_haddr;
output                         [2:0] mst2_slv9_hburst;
output                         [3:0] mst2_slv9_hprot;
output                         [2:0] mst2_slv9_hsize;
output                         [1:0] mst2_slv9_htrans;
output                               mst2_slv9_hwrite;
output                               mst2_slv9_req;
input                                mst2_slv9_sel;
output                         [3:0] mst2_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm2_slv10_hwdata;
output                  [DATA_MSB:0] mst2_hs10_hrdata;
output                               mst2_hs10_hready;
output                         [1:0] mst2_hs10_hresp;
input                                mst2_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv10_base;
output                               mst2_slv10_grant;
output                  [ADDR_MSB:0] mst2_slv10_haddr;
output                         [2:0] mst2_slv10_hburst;
output                         [3:0] mst2_slv10_hprot;
output                         [2:0] mst2_slv10_hsize;
output                         [1:0] mst2_slv10_htrans;
output                               mst2_slv10_hwrite;
output                               mst2_slv10_req;
input                                mst2_slv10_sel;
output                         [3:0] mst2_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm2_slv11_hwdata;
output                  [DATA_MSB:0] mst2_hs11_hrdata;
output                               mst2_hs11_hready;
output                         [1:0] mst2_hs11_hresp;
input                                mst2_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv11_base;
output                               mst2_slv11_grant;
output                  [ADDR_MSB:0] mst2_slv11_haddr;
output                         [2:0] mst2_slv11_hburst;
output                         [3:0] mst2_slv11_hprot;
output                         [2:0] mst2_slv11_hsize;
output                         [1:0] mst2_slv11_htrans;
output                               mst2_slv11_hwrite;
output                               mst2_slv11_req;
input                                mst2_slv11_sel;
output                         [3:0] mst2_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm2_slv12_hwdata;
output                  [DATA_MSB:0] mst2_hs12_hrdata;
output                               mst2_hs12_hready;
output                         [1:0] mst2_hs12_hresp;
input                                mst2_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv12_base;
output                               mst2_slv12_grant;
output                  [ADDR_MSB:0] mst2_slv12_haddr;
output                         [2:0] mst2_slv12_hburst;
output                         [3:0] mst2_slv12_hprot;
output                         [2:0] mst2_slv12_hsize;
output                         [1:0] mst2_slv12_htrans;
output                               mst2_slv12_hwrite;
output                               mst2_slv12_req;
input                                mst2_slv12_sel;
output                         [3:0] mst2_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm2_slv13_hwdata;
output                  [DATA_MSB:0] mst2_hs13_hrdata;
output                               mst2_hs13_hready;
output                         [1:0] mst2_hs13_hresp;
input                                mst2_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv13_base;
output                               mst2_slv13_grant;
output                  [ADDR_MSB:0] mst2_slv13_haddr;
output                         [2:0] mst2_slv13_hburst;
output                         [3:0] mst2_slv13_hprot;
output                         [2:0] mst2_slv13_hsize;
output                         [1:0] mst2_slv13_htrans;
output                               mst2_slv13_hwrite;
output                               mst2_slv13_req;
input                                mst2_slv13_sel;
output                         [3:0] mst2_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm2_slv14_hwdata;
output                  [DATA_MSB:0] mst2_hs14_hrdata;
output                               mst2_hs14_hready;
output                         [1:0] mst2_hs14_hresp;
input                                mst2_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv14_base;
output                               mst2_slv14_grant;
output                  [ADDR_MSB:0] mst2_slv14_haddr;
output                         [2:0] mst2_slv14_hburst;
output                         [3:0] mst2_slv14_hprot;
output                         [2:0] mst2_slv14_hsize;
output                         [1:0] mst2_slv14_htrans;
output                               mst2_slv14_hwrite;
output                               mst2_slv14_req;
input                                mst2_slv14_sel;
output                         [3:0] mst2_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm2_slv15_hwdata;
output                  [DATA_MSB:0] mst2_hs15_hrdata;
output                               mst2_hs15_hready;
output                         [1:0] mst2_hs15_hresp;
input                                mst2_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst2_slv15_base;
output                               mst2_slv15_grant;
output                  [ADDR_MSB:0] mst2_slv15_haddr;
output                         [2:0] mst2_slv15_hburst;
output                         [3:0] mst2_slv15_hprot;
output                         [2:0] mst2_slv15_hsize;
output                         [1:0] mst2_slv15_htrans;
output                               mst2_slv15_hwrite;
output                               mst2_slv15_req;
input                                mst2_slv15_sel;
output                         [3:0] mst2_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST3
output                  [DATA_MSB:0] hm3_slv0_hwdata;
output                  [DATA_MSB:0] mst3_hs0_hrdata;
output                               mst3_hs0_hready;
output                         [1:0] mst3_hs0_hresp;
input                                mst3_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv0_base;
output                               mst3_slv0_grant;
output                  [ADDR_MSB:0] mst3_slv0_haddr;
output                         [2:0] mst3_slv0_hburst;
output                         [3:0] mst3_slv0_hprot;
output                         [2:0] mst3_slv0_hsize;
output                         [1:0] mst3_slv0_htrans;
output                               mst3_slv0_hwrite;
output                               mst3_slv0_req;
input                                mst3_slv0_sel;
output                         [3:0] mst3_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST3
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm3_slv1_hwdata;
output                  [DATA_MSB:0] mst3_hs1_hrdata;
output                               mst3_hs1_hready;
output                         [1:0] mst3_hs1_hresp;
input                                mst3_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv1_base;
output                               mst3_slv1_grant;
output                  [ADDR_MSB:0] mst3_slv1_haddr;
output                         [2:0] mst3_slv1_hburst;
output                         [3:0] mst3_slv1_hprot;
output                         [2:0] mst3_slv1_hsize;
output                         [1:0] mst3_slv1_htrans;
output                               mst3_slv1_hwrite;
output                               mst3_slv1_req;
input                                mst3_slv1_sel;
output                         [3:0] mst3_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm3_slv2_hwdata;
output                  [DATA_MSB:0] mst3_hs2_hrdata;
output                               mst3_hs2_hready;
output                         [1:0] mst3_hs2_hresp;
input                                mst3_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv2_base;
output                               mst3_slv2_grant;
output                  [ADDR_MSB:0] mst3_slv2_haddr;
output                         [2:0] mst3_slv2_hburst;
output                         [3:0] mst3_slv2_hprot;
output                         [2:0] mst3_slv2_hsize;
output                         [1:0] mst3_slv2_htrans;
output                               mst3_slv2_hwrite;
output                               mst3_slv2_req;
input                                mst3_slv2_sel;
output                         [3:0] mst3_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm3_slv3_hwdata;
output                  [DATA_MSB:0] mst3_hs3_hrdata;
output                               mst3_hs3_hready;
output                         [1:0] mst3_hs3_hresp;
input                                mst3_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv3_base;
output                               mst3_slv3_grant;
output                  [ADDR_MSB:0] mst3_slv3_haddr;
output                         [2:0] mst3_slv3_hburst;
output                         [3:0] mst3_slv3_hprot;
output                         [2:0] mst3_slv3_hsize;
output                         [1:0] mst3_slv3_htrans;
output                               mst3_slv3_hwrite;
output                               mst3_slv3_req;
input                                mst3_slv3_sel;
output                         [3:0] mst3_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm3_slv4_hwdata;
output                  [DATA_MSB:0] mst3_hs4_hrdata;
output                               mst3_hs4_hready;
output                         [1:0] mst3_hs4_hresp;
input                                mst3_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv4_base;
output                               mst3_slv4_grant;
output                  [ADDR_MSB:0] mst3_slv4_haddr;
output                         [2:0] mst3_slv4_hburst;
output                         [3:0] mst3_slv4_hprot;
output                         [2:0] mst3_slv4_hsize;
output                         [1:0] mst3_slv4_htrans;
output                               mst3_slv4_hwrite;
output                               mst3_slv4_req;
input                                mst3_slv4_sel;
output                         [3:0] mst3_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm3_slv5_hwdata;
output                  [DATA_MSB:0] mst3_hs5_hrdata;
output                               mst3_hs5_hready;
output                         [1:0] mst3_hs5_hresp;
input                                mst3_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv5_base;
output                               mst3_slv5_grant;
output                  [ADDR_MSB:0] mst3_slv5_haddr;
output                         [2:0] mst3_slv5_hburst;
output                         [3:0] mst3_slv5_hprot;
output                         [2:0] mst3_slv5_hsize;
output                         [1:0] mst3_slv5_htrans;
output                               mst3_slv5_hwrite;
output                               mst3_slv5_req;
input                                mst3_slv5_sel;
output                         [3:0] mst3_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm3_slv6_hwdata;
output                  [DATA_MSB:0] mst3_hs6_hrdata;
output                               mst3_hs6_hready;
output                         [1:0] mst3_hs6_hresp;
input                                mst3_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv6_base;
output                               mst3_slv6_grant;
output                  [ADDR_MSB:0] mst3_slv6_haddr;
output                         [2:0] mst3_slv6_hburst;
output                         [3:0] mst3_slv6_hprot;
output                         [2:0] mst3_slv6_hsize;
output                         [1:0] mst3_slv6_htrans;
output                               mst3_slv6_hwrite;
output                               mst3_slv6_req;
input                                mst3_slv6_sel;
output                         [3:0] mst3_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm3_slv7_hwdata;
output                  [DATA_MSB:0] mst3_hs7_hrdata;
output                               mst3_hs7_hready;
output                         [1:0] mst3_hs7_hresp;
input                                mst3_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv7_base;
output                               mst3_slv7_grant;
output                  [ADDR_MSB:0] mst3_slv7_haddr;
output                         [2:0] mst3_slv7_hburst;
output                         [3:0] mst3_slv7_hprot;
output                         [2:0] mst3_slv7_hsize;
output                         [1:0] mst3_slv7_htrans;
output                               mst3_slv7_hwrite;
output                               mst3_slv7_req;
input                                mst3_slv7_sel;
output                         [3:0] mst3_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm3_slv8_hwdata;
output                  [DATA_MSB:0] mst3_hs8_hrdata;
output                               mst3_hs8_hready;
output                         [1:0] mst3_hs8_hresp;
input                                mst3_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv8_base;
output                               mst3_slv8_grant;
output                  [ADDR_MSB:0] mst3_slv8_haddr;
output                         [2:0] mst3_slv8_hburst;
output                         [3:0] mst3_slv8_hprot;
output                         [2:0] mst3_slv8_hsize;
output                         [1:0] mst3_slv8_htrans;
output                               mst3_slv8_hwrite;
output                               mst3_slv8_req;
input                                mst3_slv8_sel;
output                         [3:0] mst3_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm3_slv9_hwdata;
output                  [DATA_MSB:0] mst3_hs9_hrdata;
output                               mst3_hs9_hready;
output                         [1:0] mst3_hs9_hresp;
input                                mst3_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv9_base;
output                               mst3_slv9_grant;
output                  [ADDR_MSB:0] mst3_slv9_haddr;
output                         [2:0] mst3_slv9_hburst;
output                         [3:0] mst3_slv9_hprot;
output                         [2:0] mst3_slv9_hsize;
output                         [1:0] mst3_slv9_htrans;
output                               mst3_slv9_hwrite;
output                               mst3_slv9_req;
input                                mst3_slv9_sel;
output                         [3:0] mst3_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm3_slv10_hwdata;
output                  [DATA_MSB:0] mst3_hs10_hrdata;
output                               mst3_hs10_hready;
output                         [1:0] mst3_hs10_hresp;
input                                mst3_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv10_base;
output                               mst3_slv10_grant;
output                  [ADDR_MSB:0] mst3_slv10_haddr;
output                         [2:0] mst3_slv10_hburst;
output                         [3:0] mst3_slv10_hprot;
output                         [2:0] mst3_slv10_hsize;
output                         [1:0] mst3_slv10_htrans;
output                               mst3_slv10_hwrite;
output                               mst3_slv10_req;
input                                mst3_slv10_sel;
output                         [3:0] mst3_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm3_slv11_hwdata;
output                  [DATA_MSB:0] mst3_hs11_hrdata;
output                               mst3_hs11_hready;
output                         [1:0] mst3_hs11_hresp;
input                                mst3_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv11_base;
output                               mst3_slv11_grant;
output                  [ADDR_MSB:0] mst3_slv11_haddr;
output                         [2:0] mst3_slv11_hburst;
output                         [3:0] mst3_slv11_hprot;
output                         [2:0] mst3_slv11_hsize;
output                         [1:0] mst3_slv11_htrans;
output                               mst3_slv11_hwrite;
output                               mst3_slv11_req;
input                                mst3_slv11_sel;
output                         [3:0] mst3_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm3_slv12_hwdata;
output                  [DATA_MSB:0] mst3_hs12_hrdata;
output                               mst3_hs12_hready;
output                         [1:0] mst3_hs12_hresp;
input                                mst3_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv12_base;
output                               mst3_slv12_grant;
output                  [ADDR_MSB:0] mst3_slv12_haddr;
output                         [2:0] mst3_slv12_hburst;
output                         [3:0] mst3_slv12_hprot;
output                         [2:0] mst3_slv12_hsize;
output                         [1:0] mst3_slv12_htrans;
output                               mst3_slv12_hwrite;
output                               mst3_slv12_req;
input                                mst3_slv12_sel;
output                         [3:0] mst3_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm3_slv13_hwdata;
output                  [DATA_MSB:0] mst3_hs13_hrdata;
output                               mst3_hs13_hready;
output                         [1:0] mst3_hs13_hresp;
input                                mst3_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv13_base;
output                               mst3_slv13_grant;
output                  [ADDR_MSB:0] mst3_slv13_haddr;
output                         [2:0] mst3_slv13_hburst;
output                         [3:0] mst3_slv13_hprot;
output                         [2:0] mst3_slv13_hsize;
output                         [1:0] mst3_slv13_htrans;
output                               mst3_slv13_hwrite;
output                               mst3_slv13_req;
input                                mst3_slv13_sel;
output                         [3:0] mst3_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm3_slv14_hwdata;
output                  [DATA_MSB:0] mst3_hs14_hrdata;
output                               mst3_hs14_hready;
output                         [1:0] mst3_hs14_hresp;
input                                mst3_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv14_base;
output                               mst3_slv14_grant;
output                  [ADDR_MSB:0] mst3_slv14_haddr;
output                         [2:0] mst3_slv14_hburst;
output                         [3:0] mst3_slv14_hprot;
output                         [2:0] mst3_slv14_hsize;
output                         [1:0] mst3_slv14_htrans;
output                               mst3_slv14_hwrite;
output                               mst3_slv14_req;
input                                mst3_slv14_sel;
output                         [3:0] mst3_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm3_slv15_hwdata;
output                  [DATA_MSB:0] mst3_hs15_hrdata;
output                               mst3_hs15_hready;
output                         [1:0] mst3_hs15_hresp;
input                                mst3_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst3_slv15_base;
output                               mst3_slv15_grant;
output                  [ADDR_MSB:0] mst3_slv15_haddr;
output                         [2:0] mst3_slv15_hburst;
output                         [3:0] mst3_slv15_hprot;
output                         [2:0] mst3_slv15_hsize;
output                         [1:0] mst3_slv15_htrans;
output                               mst3_slv15_hwrite;
output                               mst3_slv15_req;
input                                mst3_slv15_sel;
output                         [3:0] mst3_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST4
output                  [DATA_MSB:0] hm4_slv0_hwdata;
output                  [DATA_MSB:0] mst4_hs0_hrdata;
output                               mst4_hs0_hready;
output                         [1:0] mst4_hs0_hresp;
input                                mst4_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv0_base;
output                               mst4_slv0_grant;
output                  [ADDR_MSB:0] mst4_slv0_haddr;
output                         [2:0] mst4_slv0_hburst;
output                         [3:0] mst4_slv0_hprot;
output                         [2:0] mst4_slv0_hsize;
output                         [1:0] mst4_slv0_htrans;
output                               mst4_slv0_hwrite;
output                               mst4_slv0_req;
input                                mst4_slv0_sel;
output                         [3:0] mst4_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST4
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm4_slv1_hwdata;
output                  [DATA_MSB:0] mst4_hs1_hrdata;
output                               mst4_hs1_hready;
output                         [1:0] mst4_hs1_hresp;
input                                mst4_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv1_base;
output                               mst4_slv1_grant;
output                  [ADDR_MSB:0] mst4_slv1_haddr;
output                         [2:0] mst4_slv1_hburst;
output                         [3:0] mst4_slv1_hprot;
output                         [2:0] mst4_slv1_hsize;
output                         [1:0] mst4_slv1_htrans;
output                               mst4_slv1_hwrite;
output                               mst4_slv1_req;
input                                mst4_slv1_sel;
output                         [3:0] mst4_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm4_slv2_hwdata;
output                  [DATA_MSB:0] mst4_hs2_hrdata;
output                               mst4_hs2_hready;
output                         [1:0] mst4_hs2_hresp;
input                                mst4_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv2_base;
output                               mst4_slv2_grant;
output                  [ADDR_MSB:0] mst4_slv2_haddr;
output                         [2:0] mst4_slv2_hburst;
output                         [3:0] mst4_slv2_hprot;
output                         [2:0] mst4_slv2_hsize;
output                         [1:0] mst4_slv2_htrans;
output                               mst4_slv2_hwrite;
output                               mst4_slv2_req;
input                                mst4_slv2_sel;
output                         [3:0] mst4_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm4_slv3_hwdata;
output                  [DATA_MSB:0] mst4_hs3_hrdata;
output                               mst4_hs3_hready;
output                         [1:0] mst4_hs3_hresp;
input                                mst4_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv3_base;
output                               mst4_slv3_grant;
output                  [ADDR_MSB:0] mst4_slv3_haddr;
output                         [2:0] mst4_slv3_hburst;
output                         [3:0] mst4_slv3_hprot;
output                         [2:0] mst4_slv3_hsize;
output                         [1:0] mst4_slv3_htrans;
output                               mst4_slv3_hwrite;
output                               mst4_slv3_req;
input                                mst4_slv3_sel;
output                         [3:0] mst4_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm4_slv4_hwdata;
output                  [DATA_MSB:0] mst4_hs4_hrdata;
output                               mst4_hs4_hready;
output                         [1:0] mst4_hs4_hresp;
input                                mst4_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv4_base;
output                               mst4_slv4_grant;
output                  [ADDR_MSB:0] mst4_slv4_haddr;
output                         [2:0] mst4_slv4_hburst;
output                         [3:0] mst4_slv4_hprot;
output                         [2:0] mst4_slv4_hsize;
output                         [1:0] mst4_slv4_htrans;
output                               mst4_slv4_hwrite;
output                               mst4_slv4_req;
input                                mst4_slv4_sel;
output                         [3:0] mst4_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm4_slv5_hwdata;
output                  [DATA_MSB:0] mst4_hs5_hrdata;
output                               mst4_hs5_hready;
output                         [1:0] mst4_hs5_hresp;
input                                mst4_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv5_base;
output                               mst4_slv5_grant;
output                  [ADDR_MSB:0] mst4_slv5_haddr;
output                         [2:0] mst4_slv5_hburst;
output                         [3:0] mst4_slv5_hprot;
output                         [2:0] mst4_slv5_hsize;
output                         [1:0] mst4_slv5_htrans;
output                               mst4_slv5_hwrite;
output                               mst4_slv5_req;
input                                mst4_slv5_sel;
output                         [3:0] mst4_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm4_slv6_hwdata;
output                  [DATA_MSB:0] mst4_hs6_hrdata;
output                               mst4_hs6_hready;
output                         [1:0] mst4_hs6_hresp;
input                                mst4_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv6_base;
output                               mst4_slv6_grant;
output                  [ADDR_MSB:0] mst4_slv6_haddr;
output                         [2:0] mst4_slv6_hburst;
output                         [3:0] mst4_slv6_hprot;
output                         [2:0] mst4_slv6_hsize;
output                         [1:0] mst4_slv6_htrans;
output                               mst4_slv6_hwrite;
output                               mst4_slv6_req;
input                                mst4_slv6_sel;
output                         [3:0] mst4_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm4_slv7_hwdata;
output                  [DATA_MSB:0] mst4_hs7_hrdata;
output                               mst4_hs7_hready;
output                         [1:0] mst4_hs7_hresp;
input                                mst4_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv7_base;
output                               mst4_slv7_grant;
output                  [ADDR_MSB:0] mst4_slv7_haddr;
output                         [2:0] mst4_slv7_hburst;
output                         [3:0] mst4_slv7_hprot;
output                         [2:0] mst4_slv7_hsize;
output                         [1:0] mst4_slv7_htrans;
output                               mst4_slv7_hwrite;
output                               mst4_slv7_req;
input                                mst4_slv7_sel;
output                         [3:0] mst4_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm4_slv8_hwdata;
output                  [DATA_MSB:0] mst4_hs8_hrdata;
output                               mst4_hs8_hready;
output                         [1:0] mst4_hs8_hresp;
input                                mst4_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv8_base;
output                               mst4_slv8_grant;
output                  [ADDR_MSB:0] mst4_slv8_haddr;
output                         [2:0] mst4_slv8_hburst;
output                         [3:0] mst4_slv8_hprot;
output                         [2:0] mst4_slv8_hsize;
output                         [1:0] mst4_slv8_htrans;
output                               mst4_slv8_hwrite;
output                               mst4_slv8_req;
input                                mst4_slv8_sel;
output                         [3:0] mst4_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm4_slv9_hwdata;
output                  [DATA_MSB:0] mst4_hs9_hrdata;
output                               mst4_hs9_hready;
output                         [1:0] mst4_hs9_hresp;
input                                mst4_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv9_base;
output                               mst4_slv9_grant;
output                  [ADDR_MSB:0] mst4_slv9_haddr;
output                         [2:0] mst4_slv9_hburst;
output                         [3:0] mst4_slv9_hprot;
output                         [2:0] mst4_slv9_hsize;
output                         [1:0] mst4_slv9_htrans;
output                               mst4_slv9_hwrite;
output                               mst4_slv9_req;
input                                mst4_slv9_sel;
output                         [3:0] mst4_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm4_slv10_hwdata;
output                  [DATA_MSB:0] mst4_hs10_hrdata;
output                               mst4_hs10_hready;
output                         [1:0] mst4_hs10_hresp;
input                                mst4_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv10_base;
output                               mst4_slv10_grant;
output                  [ADDR_MSB:0] mst4_slv10_haddr;
output                         [2:0] mst4_slv10_hburst;
output                         [3:0] mst4_slv10_hprot;
output                         [2:0] mst4_slv10_hsize;
output                         [1:0] mst4_slv10_htrans;
output                               mst4_slv10_hwrite;
output                               mst4_slv10_req;
input                                mst4_slv10_sel;
output                         [3:0] mst4_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm4_slv11_hwdata;
output                  [DATA_MSB:0] mst4_hs11_hrdata;
output                               mst4_hs11_hready;
output                         [1:0] mst4_hs11_hresp;
input                                mst4_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv11_base;
output                               mst4_slv11_grant;
output                  [ADDR_MSB:0] mst4_slv11_haddr;
output                         [2:0] mst4_slv11_hburst;
output                         [3:0] mst4_slv11_hprot;
output                         [2:0] mst4_slv11_hsize;
output                         [1:0] mst4_slv11_htrans;
output                               mst4_slv11_hwrite;
output                               mst4_slv11_req;
input                                mst4_slv11_sel;
output                         [3:0] mst4_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm4_slv12_hwdata;
output                  [DATA_MSB:0] mst4_hs12_hrdata;
output                               mst4_hs12_hready;
output                         [1:0] mst4_hs12_hresp;
input                                mst4_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv12_base;
output                               mst4_slv12_grant;
output                  [ADDR_MSB:0] mst4_slv12_haddr;
output                         [2:0] mst4_slv12_hburst;
output                         [3:0] mst4_slv12_hprot;
output                         [2:0] mst4_slv12_hsize;
output                         [1:0] mst4_slv12_htrans;
output                               mst4_slv12_hwrite;
output                               mst4_slv12_req;
input                                mst4_slv12_sel;
output                         [3:0] mst4_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm4_slv13_hwdata;
output                  [DATA_MSB:0] mst4_hs13_hrdata;
output                               mst4_hs13_hready;
output                         [1:0] mst4_hs13_hresp;
input                                mst4_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv13_base;
output                               mst4_slv13_grant;
output                  [ADDR_MSB:0] mst4_slv13_haddr;
output                         [2:0] mst4_slv13_hburst;
output                         [3:0] mst4_slv13_hprot;
output                         [2:0] mst4_slv13_hsize;
output                         [1:0] mst4_slv13_htrans;
output                               mst4_slv13_hwrite;
output                               mst4_slv13_req;
input                                mst4_slv13_sel;
output                         [3:0] mst4_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm4_slv14_hwdata;
output                  [DATA_MSB:0] mst4_hs14_hrdata;
output                               mst4_hs14_hready;
output                         [1:0] mst4_hs14_hresp;
input                                mst4_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv14_base;
output                               mst4_slv14_grant;
output                  [ADDR_MSB:0] mst4_slv14_haddr;
output                         [2:0] mst4_slv14_hburst;
output                         [3:0] mst4_slv14_hprot;
output                         [2:0] mst4_slv14_hsize;
output                         [1:0] mst4_slv14_htrans;
output                               mst4_slv14_hwrite;
output                               mst4_slv14_req;
input                                mst4_slv14_sel;
output                         [3:0] mst4_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm4_slv15_hwdata;
output                  [DATA_MSB:0] mst4_hs15_hrdata;
output                               mst4_hs15_hready;
output                         [1:0] mst4_hs15_hresp;
input                                mst4_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst4_slv15_base;
output                               mst4_slv15_grant;
output                  [ADDR_MSB:0] mst4_slv15_haddr;
output                         [2:0] mst4_slv15_hburst;
output                         [3:0] mst4_slv15_hprot;
output                         [2:0] mst4_slv15_hsize;
output                         [1:0] mst4_slv15_htrans;
output                               mst4_slv15_hwrite;
output                               mst4_slv15_req;
input                                mst4_slv15_sel;
output                         [3:0] mst4_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST5
output                  [DATA_MSB:0] hm5_slv0_hwdata;
output                  [DATA_MSB:0] mst5_hs0_hrdata;
output                               mst5_hs0_hready;
output                         [1:0] mst5_hs0_hresp;
input                                mst5_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv0_base;
output                               mst5_slv0_grant;
output                  [ADDR_MSB:0] mst5_slv0_haddr;
output                         [2:0] mst5_slv0_hburst;
output                         [3:0] mst5_slv0_hprot;
output                         [2:0] mst5_slv0_hsize;
output                         [1:0] mst5_slv0_htrans;
output                               mst5_slv0_hwrite;
output                               mst5_slv0_req;
input                                mst5_slv0_sel;
output                         [3:0] mst5_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST5
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm5_slv1_hwdata;
output                  [DATA_MSB:0] mst5_hs1_hrdata;
output                               mst5_hs1_hready;
output                         [1:0] mst5_hs1_hresp;
input                                mst5_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv1_base;
output                               mst5_slv1_grant;
output                  [ADDR_MSB:0] mst5_slv1_haddr;
output                         [2:0] mst5_slv1_hburst;
output                         [3:0] mst5_slv1_hprot;
output                         [2:0] mst5_slv1_hsize;
output                         [1:0] mst5_slv1_htrans;
output                               mst5_slv1_hwrite;
output                               mst5_slv1_req;
input                                mst5_slv1_sel;
output                         [3:0] mst5_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm5_slv2_hwdata;
output                  [DATA_MSB:0] mst5_hs2_hrdata;
output                               mst5_hs2_hready;
output                         [1:0] mst5_hs2_hresp;
input                                mst5_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv2_base;
output                               mst5_slv2_grant;
output                  [ADDR_MSB:0] mst5_slv2_haddr;
output                         [2:0] mst5_slv2_hburst;
output                         [3:0] mst5_slv2_hprot;
output                         [2:0] mst5_slv2_hsize;
output                         [1:0] mst5_slv2_htrans;
output                               mst5_slv2_hwrite;
output                               mst5_slv2_req;
input                                mst5_slv2_sel;
output                         [3:0] mst5_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm5_slv3_hwdata;
output                  [DATA_MSB:0] mst5_hs3_hrdata;
output                               mst5_hs3_hready;
output                         [1:0] mst5_hs3_hresp;
input                                mst5_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv3_base;
output                               mst5_slv3_grant;
output                  [ADDR_MSB:0] mst5_slv3_haddr;
output                         [2:0] mst5_slv3_hburst;
output                         [3:0] mst5_slv3_hprot;
output                         [2:0] mst5_slv3_hsize;
output                         [1:0] mst5_slv3_htrans;
output                               mst5_slv3_hwrite;
output                               mst5_slv3_req;
input                                mst5_slv3_sel;
output                         [3:0] mst5_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm5_slv4_hwdata;
output                  [DATA_MSB:0] mst5_hs4_hrdata;
output                               mst5_hs4_hready;
output                         [1:0] mst5_hs4_hresp;
input                                mst5_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv4_base;
output                               mst5_slv4_grant;
output                  [ADDR_MSB:0] mst5_slv4_haddr;
output                         [2:0] mst5_slv4_hburst;
output                         [3:0] mst5_slv4_hprot;
output                         [2:0] mst5_slv4_hsize;
output                         [1:0] mst5_slv4_htrans;
output                               mst5_slv4_hwrite;
output                               mst5_slv4_req;
input                                mst5_slv4_sel;
output                         [3:0] mst5_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm5_slv5_hwdata;
output                  [DATA_MSB:0] mst5_hs5_hrdata;
output                               mst5_hs5_hready;
output                         [1:0] mst5_hs5_hresp;
input                                mst5_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv5_base;
output                               mst5_slv5_grant;
output                  [ADDR_MSB:0] mst5_slv5_haddr;
output                         [2:0] mst5_slv5_hburst;
output                         [3:0] mst5_slv5_hprot;
output                         [2:0] mst5_slv5_hsize;
output                         [1:0] mst5_slv5_htrans;
output                               mst5_slv5_hwrite;
output                               mst5_slv5_req;
input                                mst5_slv5_sel;
output                         [3:0] mst5_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm5_slv6_hwdata;
output                  [DATA_MSB:0] mst5_hs6_hrdata;
output                               mst5_hs6_hready;
output                         [1:0] mst5_hs6_hresp;
input                                mst5_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv6_base;
output                               mst5_slv6_grant;
output                  [ADDR_MSB:0] mst5_slv6_haddr;
output                         [2:0] mst5_slv6_hburst;
output                         [3:0] mst5_slv6_hprot;
output                         [2:0] mst5_slv6_hsize;
output                         [1:0] mst5_slv6_htrans;
output                               mst5_slv6_hwrite;
output                               mst5_slv6_req;
input                                mst5_slv6_sel;
output                         [3:0] mst5_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm5_slv7_hwdata;
output                  [DATA_MSB:0] mst5_hs7_hrdata;
output                               mst5_hs7_hready;
output                         [1:0] mst5_hs7_hresp;
input                                mst5_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv7_base;
output                               mst5_slv7_grant;
output                  [ADDR_MSB:0] mst5_slv7_haddr;
output                         [2:0] mst5_slv7_hburst;
output                         [3:0] mst5_slv7_hprot;
output                         [2:0] mst5_slv7_hsize;
output                         [1:0] mst5_slv7_htrans;
output                               mst5_slv7_hwrite;
output                               mst5_slv7_req;
input                                mst5_slv7_sel;
output                         [3:0] mst5_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm5_slv8_hwdata;
output                  [DATA_MSB:0] mst5_hs8_hrdata;
output                               mst5_hs8_hready;
output                         [1:0] mst5_hs8_hresp;
input                                mst5_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv8_base;
output                               mst5_slv8_grant;
output                  [ADDR_MSB:0] mst5_slv8_haddr;
output                         [2:0] mst5_slv8_hburst;
output                         [3:0] mst5_slv8_hprot;
output                         [2:0] mst5_slv8_hsize;
output                         [1:0] mst5_slv8_htrans;
output                               mst5_slv8_hwrite;
output                               mst5_slv8_req;
input                                mst5_slv8_sel;
output                         [3:0] mst5_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm5_slv9_hwdata;
output                  [DATA_MSB:0] mst5_hs9_hrdata;
output                               mst5_hs9_hready;
output                         [1:0] mst5_hs9_hresp;
input                                mst5_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv9_base;
output                               mst5_slv9_grant;
output                  [ADDR_MSB:0] mst5_slv9_haddr;
output                         [2:0] mst5_slv9_hburst;
output                         [3:0] mst5_slv9_hprot;
output                         [2:0] mst5_slv9_hsize;
output                         [1:0] mst5_slv9_htrans;
output                               mst5_slv9_hwrite;
output                               mst5_slv9_req;
input                                mst5_slv9_sel;
output                         [3:0] mst5_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm5_slv10_hwdata;
output                  [DATA_MSB:0] mst5_hs10_hrdata;
output                               mst5_hs10_hready;
output                         [1:0] mst5_hs10_hresp;
input                                mst5_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv10_base;
output                               mst5_slv10_grant;
output                  [ADDR_MSB:0] mst5_slv10_haddr;
output                         [2:0] mst5_slv10_hburst;
output                         [3:0] mst5_slv10_hprot;
output                         [2:0] mst5_slv10_hsize;
output                         [1:0] mst5_slv10_htrans;
output                               mst5_slv10_hwrite;
output                               mst5_slv10_req;
input                                mst5_slv10_sel;
output                         [3:0] mst5_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm5_slv11_hwdata;
output                  [DATA_MSB:0] mst5_hs11_hrdata;
output                               mst5_hs11_hready;
output                         [1:0] mst5_hs11_hresp;
input                                mst5_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv11_base;
output                               mst5_slv11_grant;
output                  [ADDR_MSB:0] mst5_slv11_haddr;
output                         [2:0] mst5_slv11_hburst;
output                         [3:0] mst5_slv11_hprot;
output                         [2:0] mst5_slv11_hsize;
output                         [1:0] mst5_slv11_htrans;
output                               mst5_slv11_hwrite;
output                               mst5_slv11_req;
input                                mst5_slv11_sel;
output                         [3:0] mst5_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm5_slv12_hwdata;
output                  [DATA_MSB:0] mst5_hs12_hrdata;
output                               mst5_hs12_hready;
output                         [1:0] mst5_hs12_hresp;
input                                mst5_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv12_base;
output                               mst5_slv12_grant;
output                  [ADDR_MSB:0] mst5_slv12_haddr;
output                         [2:0] mst5_slv12_hburst;
output                         [3:0] mst5_slv12_hprot;
output                         [2:0] mst5_slv12_hsize;
output                         [1:0] mst5_slv12_htrans;
output                               mst5_slv12_hwrite;
output                               mst5_slv12_req;
input                                mst5_slv12_sel;
output                         [3:0] mst5_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm5_slv13_hwdata;
output                  [DATA_MSB:0] mst5_hs13_hrdata;
output                               mst5_hs13_hready;
output                         [1:0] mst5_hs13_hresp;
input                                mst5_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv13_base;
output                               mst5_slv13_grant;
output                  [ADDR_MSB:0] mst5_slv13_haddr;
output                         [2:0] mst5_slv13_hburst;
output                         [3:0] mst5_slv13_hprot;
output                         [2:0] mst5_slv13_hsize;
output                         [1:0] mst5_slv13_htrans;
output                               mst5_slv13_hwrite;
output                               mst5_slv13_req;
input                                mst5_slv13_sel;
output                         [3:0] mst5_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm5_slv14_hwdata;
output                  [DATA_MSB:0] mst5_hs14_hrdata;
output                               mst5_hs14_hready;
output                         [1:0] mst5_hs14_hresp;
input                                mst5_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv14_base;
output                               mst5_slv14_grant;
output                  [ADDR_MSB:0] mst5_slv14_haddr;
output                         [2:0] mst5_slv14_hburst;
output                         [3:0] mst5_slv14_hprot;
output                         [2:0] mst5_slv14_hsize;
output                         [1:0] mst5_slv14_htrans;
output                               mst5_slv14_hwrite;
output                               mst5_slv14_req;
input                                mst5_slv14_sel;
output                         [3:0] mst5_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm5_slv15_hwdata;
output                  [DATA_MSB:0] mst5_hs15_hrdata;
output                               mst5_hs15_hready;
output                         [1:0] mst5_hs15_hresp;
input                                mst5_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst5_slv15_base;
output                               mst5_slv15_grant;
output                  [ADDR_MSB:0] mst5_slv15_haddr;
output                         [2:0] mst5_slv15_hburst;
output                         [3:0] mst5_slv15_hprot;
output                         [2:0] mst5_slv15_hsize;
output                         [1:0] mst5_slv15_htrans;
output                               mst5_slv15_hwrite;
output                               mst5_slv15_req;
input                                mst5_slv15_sel;
output                         [3:0] mst5_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST6
output                  [DATA_MSB:0] hm6_slv0_hwdata;
output                  [DATA_MSB:0] mst6_hs0_hrdata;
output                               mst6_hs0_hready;
output                         [1:0] mst6_hs0_hresp;
input                                mst6_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv0_base;
output                               mst6_slv0_grant;
output                  [ADDR_MSB:0] mst6_slv0_haddr;
output                         [2:0] mst6_slv0_hburst;
output                         [3:0] mst6_slv0_hprot;
output                         [2:0] mst6_slv0_hsize;
output                         [1:0] mst6_slv0_htrans;
output                               mst6_slv0_hwrite;
output                               mst6_slv0_req;
input                                mst6_slv0_sel;
output                         [3:0] mst6_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST6
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm6_slv1_hwdata;
output                  [DATA_MSB:0] mst6_hs1_hrdata;
output                               mst6_hs1_hready;
output                         [1:0] mst6_hs1_hresp;
input                                mst6_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv1_base;
output                               mst6_slv1_grant;
output                  [ADDR_MSB:0] mst6_slv1_haddr;
output                         [2:0] mst6_slv1_hburst;
output                         [3:0] mst6_slv1_hprot;
output                         [2:0] mst6_slv1_hsize;
output                         [1:0] mst6_slv1_htrans;
output                               mst6_slv1_hwrite;
output                               mst6_slv1_req;
input                                mst6_slv1_sel;
output                         [3:0] mst6_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm6_slv2_hwdata;
output                  [DATA_MSB:0] mst6_hs2_hrdata;
output                               mst6_hs2_hready;
output                         [1:0] mst6_hs2_hresp;
input                                mst6_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv2_base;
output                               mst6_slv2_grant;
output                  [ADDR_MSB:0] mst6_slv2_haddr;
output                         [2:0] mst6_slv2_hburst;
output                         [3:0] mst6_slv2_hprot;
output                         [2:0] mst6_slv2_hsize;
output                         [1:0] mst6_slv2_htrans;
output                               mst6_slv2_hwrite;
output                               mst6_slv2_req;
input                                mst6_slv2_sel;
output                         [3:0] mst6_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm6_slv3_hwdata;
output                  [DATA_MSB:0] mst6_hs3_hrdata;
output                               mst6_hs3_hready;
output                         [1:0] mst6_hs3_hresp;
input                                mst6_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv3_base;
output                               mst6_slv3_grant;
output                  [ADDR_MSB:0] mst6_slv3_haddr;
output                         [2:0] mst6_slv3_hburst;
output                         [3:0] mst6_slv3_hprot;
output                         [2:0] mst6_slv3_hsize;
output                         [1:0] mst6_slv3_htrans;
output                               mst6_slv3_hwrite;
output                               mst6_slv3_req;
input                                mst6_slv3_sel;
output                         [3:0] mst6_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm6_slv4_hwdata;
output                  [DATA_MSB:0] mst6_hs4_hrdata;
output                               mst6_hs4_hready;
output                         [1:0] mst6_hs4_hresp;
input                                mst6_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv4_base;
output                               mst6_slv4_grant;
output                  [ADDR_MSB:0] mst6_slv4_haddr;
output                         [2:0] mst6_slv4_hburst;
output                         [3:0] mst6_slv4_hprot;
output                         [2:0] mst6_slv4_hsize;
output                         [1:0] mst6_slv4_htrans;
output                               mst6_slv4_hwrite;
output                               mst6_slv4_req;
input                                mst6_slv4_sel;
output                         [3:0] mst6_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm6_slv5_hwdata;
output                  [DATA_MSB:0] mst6_hs5_hrdata;
output                               mst6_hs5_hready;
output                         [1:0] mst6_hs5_hresp;
input                                mst6_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv5_base;
output                               mst6_slv5_grant;
output                  [ADDR_MSB:0] mst6_slv5_haddr;
output                         [2:0] mst6_slv5_hburst;
output                         [3:0] mst6_slv5_hprot;
output                         [2:0] mst6_slv5_hsize;
output                         [1:0] mst6_slv5_htrans;
output                               mst6_slv5_hwrite;
output                               mst6_slv5_req;
input                                mst6_slv5_sel;
output                         [3:0] mst6_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm6_slv6_hwdata;
output                  [DATA_MSB:0] mst6_hs6_hrdata;
output                               mst6_hs6_hready;
output                         [1:0] mst6_hs6_hresp;
input                                mst6_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv6_base;
output                               mst6_slv6_grant;
output                  [ADDR_MSB:0] mst6_slv6_haddr;
output                         [2:0] mst6_slv6_hburst;
output                         [3:0] mst6_slv6_hprot;
output                         [2:0] mst6_slv6_hsize;
output                         [1:0] mst6_slv6_htrans;
output                               mst6_slv6_hwrite;
output                               mst6_slv6_req;
input                                mst6_slv6_sel;
output                         [3:0] mst6_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm6_slv7_hwdata;
output                  [DATA_MSB:0] mst6_hs7_hrdata;
output                               mst6_hs7_hready;
output                         [1:0] mst6_hs7_hresp;
input                                mst6_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv7_base;
output                               mst6_slv7_grant;
output                  [ADDR_MSB:0] mst6_slv7_haddr;
output                         [2:0] mst6_slv7_hburst;
output                         [3:0] mst6_slv7_hprot;
output                         [2:0] mst6_slv7_hsize;
output                         [1:0] mst6_slv7_htrans;
output                               mst6_slv7_hwrite;
output                               mst6_slv7_req;
input                                mst6_slv7_sel;
output                         [3:0] mst6_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm6_slv8_hwdata;
output                  [DATA_MSB:0] mst6_hs8_hrdata;
output                               mst6_hs8_hready;
output                         [1:0] mst6_hs8_hresp;
input                                mst6_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv8_base;
output                               mst6_slv8_grant;
output                  [ADDR_MSB:0] mst6_slv8_haddr;
output                         [2:0] mst6_slv8_hburst;
output                         [3:0] mst6_slv8_hprot;
output                         [2:0] mst6_slv8_hsize;
output                         [1:0] mst6_slv8_htrans;
output                               mst6_slv8_hwrite;
output                               mst6_slv8_req;
input                                mst6_slv8_sel;
output                         [3:0] mst6_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm6_slv9_hwdata;
output                  [DATA_MSB:0] mst6_hs9_hrdata;
output                               mst6_hs9_hready;
output                         [1:0] mst6_hs9_hresp;
input                                mst6_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv9_base;
output                               mst6_slv9_grant;
output                  [ADDR_MSB:0] mst6_slv9_haddr;
output                         [2:0] mst6_slv9_hburst;
output                         [3:0] mst6_slv9_hprot;
output                         [2:0] mst6_slv9_hsize;
output                         [1:0] mst6_slv9_htrans;
output                               mst6_slv9_hwrite;
output                               mst6_slv9_req;
input                                mst6_slv9_sel;
output                         [3:0] mst6_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm6_slv10_hwdata;
output                  [DATA_MSB:0] mst6_hs10_hrdata;
output                               mst6_hs10_hready;
output                         [1:0] mst6_hs10_hresp;
input                                mst6_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv10_base;
output                               mst6_slv10_grant;
output                  [ADDR_MSB:0] mst6_slv10_haddr;
output                         [2:0] mst6_slv10_hburst;
output                         [3:0] mst6_slv10_hprot;
output                         [2:0] mst6_slv10_hsize;
output                         [1:0] mst6_slv10_htrans;
output                               mst6_slv10_hwrite;
output                               mst6_slv10_req;
input                                mst6_slv10_sel;
output                         [3:0] mst6_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm6_slv11_hwdata;
output                  [DATA_MSB:0] mst6_hs11_hrdata;
output                               mst6_hs11_hready;
output                         [1:0] mst6_hs11_hresp;
input                                mst6_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv11_base;
output                               mst6_slv11_grant;
output                  [ADDR_MSB:0] mst6_slv11_haddr;
output                         [2:0] mst6_slv11_hburst;
output                         [3:0] mst6_slv11_hprot;
output                         [2:0] mst6_slv11_hsize;
output                         [1:0] mst6_slv11_htrans;
output                               mst6_slv11_hwrite;
output                               mst6_slv11_req;
input                                mst6_slv11_sel;
output                         [3:0] mst6_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm6_slv12_hwdata;
output                  [DATA_MSB:0] mst6_hs12_hrdata;
output                               mst6_hs12_hready;
output                         [1:0] mst6_hs12_hresp;
input                                mst6_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv12_base;
output                               mst6_slv12_grant;
output                  [ADDR_MSB:0] mst6_slv12_haddr;
output                         [2:0] mst6_slv12_hburst;
output                         [3:0] mst6_slv12_hprot;
output                         [2:0] mst6_slv12_hsize;
output                         [1:0] mst6_slv12_htrans;
output                               mst6_slv12_hwrite;
output                               mst6_slv12_req;
input                                mst6_slv12_sel;
output                         [3:0] mst6_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm6_slv13_hwdata;
output                  [DATA_MSB:0] mst6_hs13_hrdata;
output                               mst6_hs13_hready;
output                         [1:0] mst6_hs13_hresp;
input                                mst6_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv13_base;
output                               mst6_slv13_grant;
output                  [ADDR_MSB:0] mst6_slv13_haddr;
output                         [2:0] mst6_slv13_hburst;
output                         [3:0] mst6_slv13_hprot;
output                         [2:0] mst6_slv13_hsize;
output                         [1:0] mst6_slv13_htrans;
output                               mst6_slv13_hwrite;
output                               mst6_slv13_req;
input                                mst6_slv13_sel;
output                         [3:0] mst6_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm6_slv14_hwdata;
output                  [DATA_MSB:0] mst6_hs14_hrdata;
output                               mst6_hs14_hready;
output                         [1:0] mst6_hs14_hresp;
input                                mst6_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv14_base;
output                               mst6_slv14_grant;
output                  [ADDR_MSB:0] mst6_slv14_haddr;
output                         [2:0] mst6_slv14_hburst;
output                         [3:0] mst6_slv14_hprot;
output                         [2:0] mst6_slv14_hsize;
output                         [1:0] mst6_slv14_htrans;
output                               mst6_slv14_hwrite;
output                               mst6_slv14_req;
input                                mst6_slv14_sel;
output                         [3:0] mst6_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm6_slv15_hwdata;
output                  [DATA_MSB:0] mst6_hs15_hrdata;
output                               mst6_hs15_hready;
output                         [1:0] mst6_hs15_hresp;
input                                mst6_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst6_slv15_base;
output                               mst6_slv15_grant;
output                  [ADDR_MSB:0] mst6_slv15_haddr;
output                         [2:0] mst6_slv15_hburst;
output                         [3:0] mst6_slv15_hprot;
output                         [2:0] mst6_slv15_hsize;
output                         [1:0] mst6_slv15_htrans;
output                               mst6_slv15_hwrite;
output                               mst6_slv15_req;
input                                mst6_slv15_sel;
output                         [3:0] mst6_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST7
output                  [DATA_MSB:0] hm7_slv0_hwdata;
output                  [DATA_MSB:0] mst7_hs0_hrdata;
output                               mst7_hs0_hready;
output                         [1:0] mst7_hs0_hresp;
input                                mst7_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv0_base;
output                               mst7_slv0_grant;
output                  [ADDR_MSB:0] mst7_slv0_haddr;
output                         [2:0] mst7_slv0_hburst;
output                         [3:0] mst7_slv0_hprot;
output                         [2:0] mst7_slv0_hsize;
output                         [1:0] mst7_slv0_htrans;
output                               mst7_slv0_hwrite;
output                               mst7_slv0_req;
input                                mst7_slv0_sel;
output                         [3:0] mst7_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST7
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm7_slv1_hwdata;
output                  [DATA_MSB:0] mst7_hs1_hrdata;
output                               mst7_hs1_hready;
output                         [1:0] mst7_hs1_hresp;
input                                mst7_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv1_base;
output                               mst7_slv1_grant;
output                  [ADDR_MSB:0] mst7_slv1_haddr;
output                         [2:0] mst7_slv1_hburst;
output                         [3:0] mst7_slv1_hprot;
output                         [2:0] mst7_slv1_hsize;
output                         [1:0] mst7_slv1_htrans;
output                               mst7_slv1_hwrite;
output                               mst7_slv1_req;
input                                mst7_slv1_sel;
output                         [3:0] mst7_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm7_slv2_hwdata;
output                  [DATA_MSB:0] mst7_hs2_hrdata;
output                               mst7_hs2_hready;
output                         [1:0] mst7_hs2_hresp;
input                                mst7_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv2_base;
output                               mst7_slv2_grant;
output                  [ADDR_MSB:0] mst7_slv2_haddr;
output                         [2:0] mst7_slv2_hburst;
output                         [3:0] mst7_slv2_hprot;
output                         [2:0] mst7_slv2_hsize;
output                         [1:0] mst7_slv2_htrans;
output                               mst7_slv2_hwrite;
output                               mst7_slv2_req;
input                                mst7_slv2_sel;
output                         [3:0] mst7_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm7_slv3_hwdata;
output                  [DATA_MSB:0] mst7_hs3_hrdata;
output                               mst7_hs3_hready;
output                         [1:0] mst7_hs3_hresp;
input                                mst7_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv3_base;
output                               mst7_slv3_grant;
output                  [ADDR_MSB:0] mst7_slv3_haddr;
output                         [2:0] mst7_slv3_hburst;
output                         [3:0] mst7_slv3_hprot;
output                         [2:0] mst7_slv3_hsize;
output                         [1:0] mst7_slv3_htrans;
output                               mst7_slv3_hwrite;
output                               mst7_slv3_req;
input                                mst7_slv3_sel;
output                         [3:0] mst7_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm7_slv4_hwdata;
output                  [DATA_MSB:0] mst7_hs4_hrdata;
output                               mst7_hs4_hready;
output                         [1:0] mst7_hs4_hresp;
input                                mst7_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv4_base;
output                               mst7_slv4_grant;
output                  [ADDR_MSB:0] mst7_slv4_haddr;
output                         [2:0] mst7_slv4_hburst;
output                         [3:0] mst7_slv4_hprot;
output                         [2:0] mst7_slv4_hsize;
output                         [1:0] mst7_slv4_htrans;
output                               mst7_slv4_hwrite;
output                               mst7_slv4_req;
input                                mst7_slv4_sel;
output                         [3:0] mst7_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm7_slv5_hwdata;
output                  [DATA_MSB:0] mst7_hs5_hrdata;
output                               mst7_hs5_hready;
output                         [1:0] mst7_hs5_hresp;
input                                mst7_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv5_base;
output                               mst7_slv5_grant;
output                  [ADDR_MSB:0] mst7_slv5_haddr;
output                         [2:0] mst7_slv5_hburst;
output                         [3:0] mst7_slv5_hprot;
output                         [2:0] mst7_slv5_hsize;
output                         [1:0] mst7_slv5_htrans;
output                               mst7_slv5_hwrite;
output                               mst7_slv5_req;
input                                mst7_slv5_sel;
output                         [3:0] mst7_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm7_slv6_hwdata;
output                  [DATA_MSB:0] mst7_hs6_hrdata;
output                               mst7_hs6_hready;
output                         [1:0] mst7_hs6_hresp;
input                                mst7_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv6_base;
output                               mst7_slv6_grant;
output                  [ADDR_MSB:0] mst7_slv6_haddr;
output                         [2:0] mst7_slv6_hburst;
output                         [3:0] mst7_slv6_hprot;
output                         [2:0] mst7_slv6_hsize;
output                         [1:0] mst7_slv6_htrans;
output                               mst7_slv6_hwrite;
output                               mst7_slv6_req;
input                                mst7_slv6_sel;
output                         [3:0] mst7_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm7_slv7_hwdata;
output                  [DATA_MSB:0] mst7_hs7_hrdata;
output                               mst7_hs7_hready;
output                         [1:0] mst7_hs7_hresp;
input                                mst7_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv7_base;
output                               mst7_slv7_grant;
output                  [ADDR_MSB:0] mst7_slv7_haddr;
output                         [2:0] mst7_slv7_hburst;
output                         [3:0] mst7_slv7_hprot;
output                         [2:0] mst7_slv7_hsize;
output                         [1:0] mst7_slv7_htrans;
output                               mst7_slv7_hwrite;
output                               mst7_slv7_req;
input                                mst7_slv7_sel;
output                         [3:0] mst7_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm7_slv8_hwdata;
output                  [DATA_MSB:0] mst7_hs8_hrdata;
output                               mst7_hs8_hready;
output                         [1:0] mst7_hs8_hresp;
input                                mst7_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv8_base;
output                               mst7_slv8_grant;
output                  [ADDR_MSB:0] mst7_slv8_haddr;
output                         [2:0] mst7_slv8_hburst;
output                         [3:0] mst7_slv8_hprot;
output                         [2:0] mst7_slv8_hsize;
output                         [1:0] mst7_slv8_htrans;
output                               mst7_slv8_hwrite;
output                               mst7_slv8_req;
input                                mst7_slv8_sel;
output                         [3:0] mst7_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm7_slv9_hwdata;
output                  [DATA_MSB:0] mst7_hs9_hrdata;
output                               mst7_hs9_hready;
output                         [1:0] mst7_hs9_hresp;
input                                mst7_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv9_base;
output                               mst7_slv9_grant;
output                  [ADDR_MSB:0] mst7_slv9_haddr;
output                         [2:0] mst7_slv9_hburst;
output                         [3:0] mst7_slv9_hprot;
output                         [2:0] mst7_slv9_hsize;
output                         [1:0] mst7_slv9_htrans;
output                               mst7_slv9_hwrite;
output                               mst7_slv9_req;
input                                mst7_slv9_sel;
output                         [3:0] mst7_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm7_slv10_hwdata;
output                  [DATA_MSB:0] mst7_hs10_hrdata;
output                               mst7_hs10_hready;
output                         [1:0] mst7_hs10_hresp;
input                                mst7_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv10_base;
output                               mst7_slv10_grant;
output                  [ADDR_MSB:0] mst7_slv10_haddr;
output                         [2:0] mst7_slv10_hburst;
output                         [3:0] mst7_slv10_hprot;
output                         [2:0] mst7_slv10_hsize;
output                         [1:0] mst7_slv10_htrans;
output                               mst7_slv10_hwrite;
output                               mst7_slv10_req;
input                                mst7_slv10_sel;
output                         [3:0] mst7_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm7_slv11_hwdata;
output                  [DATA_MSB:0] mst7_hs11_hrdata;
output                               mst7_hs11_hready;
output                         [1:0] mst7_hs11_hresp;
input                                mst7_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv11_base;
output                               mst7_slv11_grant;
output                  [ADDR_MSB:0] mst7_slv11_haddr;
output                         [2:0] mst7_slv11_hburst;
output                         [3:0] mst7_slv11_hprot;
output                         [2:0] mst7_slv11_hsize;
output                         [1:0] mst7_slv11_htrans;
output                               mst7_slv11_hwrite;
output                               mst7_slv11_req;
input                                mst7_slv11_sel;
output                         [3:0] mst7_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm7_slv12_hwdata;
output                  [DATA_MSB:0] mst7_hs12_hrdata;
output                               mst7_hs12_hready;
output                         [1:0] mst7_hs12_hresp;
input                                mst7_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv12_base;
output                               mst7_slv12_grant;
output                  [ADDR_MSB:0] mst7_slv12_haddr;
output                         [2:0] mst7_slv12_hburst;
output                         [3:0] mst7_slv12_hprot;
output                         [2:0] mst7_slv12_hsize;
output                         [1:0] mst7_slv12_htrans;
output                               mst7_slv12_hwrite;
output                               mst7_slv12_req;
input                                mst7_slv12_sel;
output                         [3:0] mst7_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm7_slv13_hwdata;
output                  [DATA_MSB:0] mst7_hs13_hrdata;
output                               mst7_hs13_hready;
output                         [1:0] mst7_hs13_hresp;
input                                mst7_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv13_base;
output                               mst7_slv13_grant;
output                  [ADDR_MSB:0] mst7_slv13_haddr;
output                         [2:0] mst7_slv13_hburst;
output                         [3:0] mst7_slv13_hprot;
output                         [2:0] mst7_slv13_hsize;
output                         [1:0] mst7_slv13_htrans;
output                               mst7_slv13_hwrite;
output                               mst7_slv13_req;
input                                mst7_slv13_sel;
output                         [3:0] mst7_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm7_slv14_hwdata;
output                  [DATA_MSB:0] mst7_hs14_hrdata;
output                               mst7_hs14_hready;
output                         [1:0] mst7_hs14_hresp;
input                                mst7_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv14_base;
output                               mst7_slv14_grant;
output                  [ADDR_MSB:0] mst7_slv14_haddr;
output                         [2:0] mst7_slv14_hburst;
output                         [3:0] mst7_slv14_hprot;
output                         [2:0] mst7_slv14_hsize;
output                         [1:0] mst7_slv14_htrans;
output                               mst7_slv14_hwrite;
output                               mst7_slv14_req;
input                                mst7_slv14_sel;
output                         [3:0] mst7_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm7_slv15_hwdata;
output                  [DATA_MSB:0] mst7_hs15_hrdata;
output                               mst7_hs15_hready;
output                         [1:0] mst7_hs15_hresp;
input                                mst7_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst7_slv15_base;
output                               mst7_slv15_grant;
output                  [ADDR_MSB:0] mst7_slv15_haddr;
output                         [2:0] mst7_slv15_hburst;
output                         [3:0] mst7_slv15_hprot;
output                         [2:0] mst7_slv15_hsize;
output                         [1:0] mst7_slv15_htrans;
output                               mst7_slv15_hwrite;
output                               mst7_slv15_req;
input                                mst7_slv15_sel;
output                         [3:0] mst7_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST8
output                  [DATA_MSB:0] hm8_slv0_hwdata;
output                  [DATA_MSB:0] mst8_hs0_hrdata;
output                               mst8_hs0_hready;
output                         [1:0] mst8_hs0_hresp;
input                                mst8_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv0_base;
output                               mst8_slv0_grant;
output                  [ADDR_MSB:0] mst8_slv0_haddr;
output                         [2:0] mst8_slv0_hburst;
output                         [3:0] mst8_slv0_hprot;
output                         [2:0] mst8_slv0_hsize;
output                         [1:0] mst8_slv0_htrans;
output                               mst8_slv0_hwrite;
output                               mst8_slv0_req;
input                                mst8_slv0_sel;
output                         [3:0] mst8_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST8
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm8_slv1_hwdata;
output                  [DATA_MSB:0] mst8_hs1_hrdata;
output                               mst8_hs1_hready;
output                         [1:0] mst8_hs1_hresp;
input                                mst8_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv1_base;
output                               mst8_slv1_grant;
output                  [ADDR_MSB:0] mst8_slv1_haddr;
output                         [2:0] mst8_slv1_hburst;
output                         [3:0] mst8_slv1_hprot;
output                         [2:0] mst8_slv1_hsize;
output                         [1:0] mst8_slv1_htrans;
output                               mst8_slv1_hwrite;
output                               mst8_slv1_req;
input                                mst8_slv1_sel;
output                         [3:0] mst8_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm8_slv2_hwdata;
output                  [DATA_MSB:0] mst8_hs2_hrdata;
output                               mst8_hs2_hready;
output                         [1:0] mst8_hs2_hresp;
input                                mst8_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv2_base;
output                               mst8_slv2_grant;
output                  [ADDR_MSB:0] mst8_slv2_haddr;
output                         [2:0] mst8_slv2_hburst;
output                         [3:0] mst8_slv2_hprot;
output                         [2:0] mst8_slv2_hsize;
output                         [1:0] mst8_slv2_htrans;
output                               mst8_slv2_hwrite;
output                               mst8_slv2_req;
input                                mst8_slv2_sel;
output                         [3:0] mst8_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm8_slv3_hwdata;
output                  [DATA_MSB:0] mst8_hs3_hrdata;
output                               mst8_hs3_hready;
output                         [1:0] mst8_hs3_hresp;
input                                mst8_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv3_base;
output                               mst8_slv3_grant;
output                  [ADDR_MSB:0] mst8_slv3_haddr;
output                         [2:0] mst8_slv3_hburst;
output                         [3:0] mst8_slv3_hprot;
output                         [2:0] mst8_slv3_hsize;
output                         [1:0] mst8_slv3_htrans;
output                               mst8_slv3_hwrite;
output                               mst8_slv3_req;
input                                mst8_slv3_sel;
output                         [3:0] mst8_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm8_slv4_hwdata;
output                  [DATA_MSB:0] mst8_hs4_hrdata;
output                               mst8_hs4_hready;
output                         [1:0] mst8_hs4_hresp;
input                                mst8_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv4_base;
output                               mst8_slv4_grant;
output                  [ADDR_MSB:0] mst8_slv4_haddr;
output                         [2:0] mst8_slv4_hburst;
output                         [3:0] mst8_slv4_hprot;
output                         [2:0] mst8_slv4_hsize;
output                         [1:0] mst8_slv4_htrans;
output                               mst8_slv4_hwrite;
output                               mst8_slv4_req;
input                                mst8_slv4_sel;
output                         [3:0] mst8_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm8_slv5_hwdata;
output                  [DATA_MSB:0] mst8_hs5_hrdata;
output                               mst8_hs5_hready;
output                         [1:0] mst8_hs5_hresp;
input                                mst8_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv5_base;
output                               mst8_slv5_grant;
output                  [ADDR_MSB:0] mst8_slv5_haddr;
output                         [2:0] mst8_slv5_hburst;
output                         [3:0] mst8_slv5_hprot;
output                         [2:0] mst8_slv5_hsize;
output                         [1:0] mst8_slv5_htrans;
output                               mst8_slv5_hwrite;
output                               mst8_slv5_req;
input                                mst8_slv5_sel;
output                         [3:0] mst8_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm8_slv6_hwdata;
output                  [DATA_MSB:0] mst8_hs6_hrdata;
output                               mst8_hs6_hready;
output                         [1:0] mst8_hs6_hresp;
input                                mst8_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv6_base;
output                               mst8_slv6_grant;
output                  [ADDR_MSB:0] mst8_slv6_haddr;
output                         [2:0] mst8_slv6_hburst;
output                         [3:0] mst8_slv6_hprot;
output                         [2:0] mst8_slv6_hsize;
output                         [1:0] mst8_slv6_htrans;
output                               mst8_slv6_hwrite;
output                               mst8_slv6_req;
input                                mst8_slv6_sel;
output                         [3:0] mst8_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm8_slv7_hwdata;
output                  [DATA_MSB:0] mst8_hs7_hrdata;
output                               mst8_hs7_hready;
output                         [1:0] mst8_hs7_hresp;
input                                mst8_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv7_base;
output                               mst8_slv7_grant;
output                  [ADDR_MSB:0] mst8_slv7_haddr;
output                         [2:0] mst8_slv7_hburst;
output                         [3:0] mst8_slv7_hprot;
output                         [2:0] mst8_slv7_hsize;
output                         [1:0] mst8_slv7_htrans;
output                               mst8_slv7_hwrite;
output                               mst8_slv7_req;
input                                mst8_slv7_sel;
output                         [3:0] mst8_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm8_slv8_hwdata;
output                  [DATA_MSB:0] mst8_hs8_hrdata;
output                               mst8_hs8_hready;
output                         [1:0] mst8_hs8_hresp;
input                                mst8_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv8_base;
output                               mst8_slv8_grant;
output                  [ADDR_MSB:0] mst8_slv8_haddr;
output                         [2:0] mst8_slv8_hburst;
output                         [3:0] mst8_slv8_hprot;
output                         [2:0] mst8_slv8_hsize;
output                         [1:0] mst8_slv8_htrans;
output                               mst8_slv8_hwrite;
output                               mst8_slv8_req;
input                                mst8_slv8_sel;
output                         [3:0] mst8_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm8_slv9_hwdata;
output                  [DATA_MSB:0] mst8_hs9_hrdata;
output                               mst8_hs9_hready;
output                         [1:0] mst8_hs9_hresp;
input                                mst8_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv9_base;
output                               mst8_slv9_grant;
output                  [ADDR_MSB:0] mst8_slv9_haddr;
output                         [2:0] mst8_slv9_hburst;
output                         [3:0] mst8_slv9_hprot;
output                         [2:0] mst8_slv9_hsize;
output                         [1:0] mst8_slv9_htrans;
output                               mst8_slv9_hwrite;
output                               mst8_slv9_req;
input                                mst8_slv9_sel;
output                         [3:0] mst8_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm8_slv10_hwdata;
output                  [DATA_MSB:0] mst8_hs10_hrdata;
output                               mst8_hs10_hready;
output                         [1:0] mst8_hs10_hresp;
input                                mst8_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv10_base;
output                               mst8_slv10_grant;
output                  [ADDR_MSB:0] mst8_slv10_haddr;
output                         [2:0] mst8_slv10_hburst;
output                         [3:0] mst8_slv10_hprot;
output                         [2:0] mst8_slv10_hsize;
output                         [1:0] mst8_slv10_htrans;
output                               mst8_slv10_hwrite;
output                               mst8_slv10_req;
input                                mst8_slv10_sel;
output                         [3:0] mst8_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm8_slv11_hwdata;
output                  [DATA_MSB:0] mst8_hs11_hrdata;
output                               mst8_hs11_hready;
output                         [1:0] mst8_hs11_hresp;
input                                mst8_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv11_base;
output                               mst8_slv11_grant;
output                  [ADDR_MSB:0] mst8_slv11_haddr;
output                         [2:0] mst8_slv11_hburst;
output                         [3:0] mst8_slv11_hprot;
output                         [2:0] mst8_slv11_hsize;
output                         [1:0] mst8_slv11_htrans;
output                               mst8_slv11_hwrite;
output                               mst8_slv11_req;
input                                mst8_slv11_sel;
output                         [3:0] mst8_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm8_slv12_hwdata;
output                  [DATA_MSB:0] mst8_hs12_hrdata;
output                               mst8_hs12_hready;
output                         [1:0] mst8_hs12_hresp;
input                                mst8_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv12_base;
output                               mst8_slv12_grant;
output                  [ADDR_MSB:0] mst8_slv12_haddr;
output                         [2:0] mst8_slv12_hburst;
output                         [3:0] mst8_slv12_hprot;
output                         [2:0] mst8_slv12_hsize;
output                         [1:0] mst8_slv12_htrans;
output                               mst8_slv12_hwrite;
output                               mst8_slv12_req;
input                                mst8_slv12_sel;
output                         [3:0] mst8_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm8_slv13_hwdata;
output                  [DATA_MSB:0] mst8_hs13_hrdata;
output                               mst8_hs13_hready;
output                         [1:0] mst8_hs13_hresp;
input                                mst8_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv13_base;
output                               mst8_slv13_grant;
output                  [ADDR_MSB:0] mst8_slv13_haddr;
output                         [2:0] mst8_slv13_hburst;
output                         [3:0] mst8_slv13_hprot;
output                         [2:0] mst8_slv13_hsize;
output                         [1:0] mst8_slv13_htrans;
output                               mst8_slv13_hwrite;
output                               mst8_slv13_req;
input                                mst8_slv13_sel;
output                         [3:0] mst8_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm8_slv14_hwdata;
output                  [DATA_MSB:0] mst8_hs14_hrdata;
output                               mst8_hs14_hready;
output                         [1:0] mst8_hs14_hresp;
input                                mst8_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv14_base;
output                               mst8_slv14_grant;
output                  [ADDR_MSB:0] mst8_slv14_haddr;
output                         [2:0] mst8_slv14_hburst;
output                         [3:0] mst8_slv14_hprot;
output                         [2:0] mst8_slv14_hsize;
output                         [1:0] mst8_slv14_htrans;
output                               mst8_slv14_hwrite;
output                               mst8_slv14_req;
input                                mst8_slv14_sel;
output                         [3:0] mst8_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm8_slv15_hwdata;
output                  [DATA_MSB:0] mst8_hs15_hrdata;
output                               mst8_hs15_hready;
output                         [1:0] mst8_hs15_hresp;
input                                mst8_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst8_slv15_base;
output                               mst8_slv15_grant;
output                  [ADDR_MSB:0] mst8_slv15_haddr;
output                         [2:0] mst8_slv15_hburst;
output                         [3:0] mst8_slv15_hprot;
output                         [2:0] mst8_slv15_hsize;
output                         [1:0] mst8_slv15_htrans;
output                               mst8_slv15_hwrite;
output                               mst8_slv15_req;
input                                mst8_slv15_sel;
output                         [3:0] mst8_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST9
output                  [DATA_MSB:0] hm9_slv0_hwdata;
output                  [DATA_MSB:0] mst9_hs0_hrdata;
output                               mst9_hs0_hready;
output                         [1:0] mst9_hs0_hresp;
input                                mst9_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv0_base;
output                               mst9_slv0_grant;
output                  [ADDR_MSB:0] mst9_slv0_haddr;
output                         [2:0] mst9_slv0_hburst;
output                         [3:0] mst9_slv0_hprot;
output                         [2:0] mst9_slv0_hsize;
output                         [1:0] mst9_slv0_htrans;
output                               mst9_slv0_hwrite;
output                               mst9_slv0_req;
input                                mst9_slv0_sel;
output                         [3:0] mst9_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST9
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm9_slv1_hwdata;
output                  [DATA_MSB:0] mst9_hs1_hrdata;
output                               mst9_hs1_hready;
output                         [1:0] mst9_hs1_hresp;
input                                mst9_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv1_base;
output                               mst9_slv1_grant;
output                  [ADDR_MSB:0] mst9_slv1_haddr;
output                         [2:0] mst9_slv1_hburst;
output                         [3:0] mst9_slv1_hprot;
output                         [2:0] mst9_slv1_hsize;
output                         [1:0] mst9_slv1_htrans;
output                               mst9_slv1_hwrite;
output                               mst9_slv1_req;
input                                mst9_slv1_sel;
output                         [3:0] mst9_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm9_slv2_hwdata;
output                  [DATA_MSB:0] mst9_hs2_hrdata;
output                               mst9_hs2_hready;
output                         [1:0] mst9_hs2_hresp;
input                                mst9_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv2_base;
output                               mst9_slv2_grant;
output                  [ADDR_MSB:0] mst9_slv2_haddr;
output                         [2:0] mst9_slv2_hburst;
output                         [3:0] mst9_slv2_hprot;
output                         [2:0] mst9_slv2_hsize;
output                         [1:0] mst9_slv2_htrans;
output                               mst9_slv2_hwrite;
output                               mst9_slv2_req;
input                                mst9_slv2_sel;
output                         [3:0] mst9_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm9_slv3_hwdata;
output                  [DATA_MSB:0] mst9_hs3_hrdata;
output                               mst9_hs3_hready;
output                         [1:0] mst9_hs3_hresp;
input                                mst9_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv3_base;
output                               mst9_slv3_grant;
output                  [ADDR_MSB:0] mst9_slv3_haddr;
output                         [2:0] mst9_slv3_hburst;
output                         [3:0] mst9_slv3_hprot;
output                         [2:0] mst9_slv3_hsize;
output                         [1:0] mst9_slv3_htrans;
output                               mst9_slv3_hwrite;
output                               mst9_slv3_req;
input                                mst9_slv3_sel;
output                         [3:0] mst9_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm9_slv4_hwdata;
output                  [DATA_MSB:0] mst9_hs4_hrdata;
output                               mst9_hs4_hready;
output                         [1:0] mst9_hs4_hresp;
input                                mst9_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv4_base;
output                               mst9_slv4_grant;
output                  [ADDR_MSB:0] mst9_slv4_haddr;
output                         [2:0] mst9_slv4_hburst;
output                         [3:0] mst9_slv4_hprot;
output                         [2:0] mst9_slv4_hsize;
output                         [1:0] mst9_slv4_htrans;
output                               mst9_slv4_hwrite;
output                               mst9_slv4_req;
input                                mst9_slv4_sel;
output                         [3:0] mst9_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm9_slv5_hwdata;
output                  [DATA_MSB:0] mst9_hs5_hrdata;
output                               mst9_hs5_hready;
output                         [1:0] mst9_hs5_hresp;
input                                mst9_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv5_base;
output                               mst9_slv5_grant;
output                  [ADDR_MSB:0] mst9_slv5_haddr;
output                         [2:0] mst9_slv5_hburst;
output                         [3:0] mst9_slv5_hprot;
output                         [2:0] mst9_slv5_hsize;
output                         [1:0] mst9_slv5_htrans;
output                               mst9_slv5_hwrite;
output                               mst9_slv5_req;
input                                mst9_slv5_sel;
output                         [3:0] mst9_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm9_slv6_hwdata;
output                  [DATA_MSB:0] mst9_hs6_hrdata;
output                               mst9_hs6_hready;
output                         [1:0] mst9_hs6_hresp;
input                                mst9_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv6_base;
output                               mst9_slv6_grant;
output                  [ADDR_MSB:0] mst9_slv6_haddr;
output                         [2:0] mst9_slv6_hburst;
output                         [3:0] mst9_slv6_hprot;
output                         [2:0] mst9_slv6_hsize;
output                         [1:0] mst9_slv6_htrans;
output                               mst9_slv6_hwrite;
output                               mst9_slv6_req;
input                                mst9_slv6_sel;
output                         [3:0] mst9_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm9_slv7_hwdata;
output                  [DATA_MSB:0] mst9_hs7_hrdata;
output                               mst9_hs7_hready;
output                         [1:0] mst9_hs7_hresp;
input                                mst9_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv7_base;
output                               mst9_slv7_grant;
output                  [ADDR_MSB:0] mst9_slv7_haddr;
output                         [2:0] mst9_slv7_hburst;
output                         [3:0] mst9_slv7_hprot;
output                         [2:0] mst9_slv7_hsize;
output                         [1:0] mst9_slv7_htrans;
output                               mst9_slv7_hwrite;
output                               mst9_slv7_req;
input                                mst9_slv7_sel;
output                         [3:0] mst9_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm9_slv8_hwdata;
output                  [DATA_MSB:0] mst9_hs8_hrdata;
output                               mst9_hs8_hready;
output                         [1:0] mst9_hs8_hresp;
input                                mst9_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv8_base;
output                               mst9_slv8_grant;
output                  [ADDR_MSB:0] mst9_slv8_haddr;
output                         [2:0] mst9_slv8_hburst;
output                         [3:0] mst9_slv8_hprot;
output                         [2:0] mst9_slv8_hsize;
output                         [1:0] mst9_slv8_htrans;
output                               mst9_slv8_hwrite;
output                               mst9_slv8_req;
input                                mst9_slv8_sel;
output                         [3:0] mst9_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm9_slv9_hwdata;
output                  [DATA_MSB:0] mst9_hs9_hrdata;
output                               mst9_hs9_hready;
output                         [1:0] mst9_hs9_hresp;
input                                mst9_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv9_base;
output                               mst9_slv9_grant;
output                  [ADDR_MSB:0] mst9_slv9_haddr;
output                         [2:0] mst9_slv9_hburst;
output                         [3:0] mst9_slv9_hprot;
output                         [2:0] mst9_slv9_hsize;
output                         [1:0] mst9_slv9_htrans;
output                               mst9_slv9_hwrite;
output                               mst9_slv9_req;
input                                mst9_slv9_sel;
output                         [3:0] mst9_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm9_slv10_hwdata;
output                  [DATA_MSB:0] mst9_hs10_hrdata;
output                               mst9_hs10_hready;
output                         [1:0] mst9_hs10_hresp;
input                                mst9_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv10_base;
output                               mst9_slv10_grant;
output                  [ADDR_MSB:0] mst9_slv10_haddr;
output                         [2:0] mst9_slv10_hburst;
output                         [3:0] mst9_slv10_hprot;
output                         [2:0] mst9_slv10_hsize;
output                         [1:0] mst9_slv10_htrans;
output                               mst9_slv10_hwrite;
output                               mst9_slv10_req;
input                                mst9_slv10_sel;
output                         [3:0] mst9_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm9_slv11_hwdata;
output                  [DATA_MSB:0] mst9_hs11_hrdata;
output                               mst9_hs11_hready;
output                         [1:0] mst9_hs11_hresp;
input                                mst9_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv11_base;
output                               mst9_slv11_grant;
output                  [ADDR_MSB:0] mst9_slv11_haddr;
output                         [2:0] mst9_slv11_hburst;
output                         [3:0] mst9_slv11_hprot;
output                         [2:0] mst9_slv11_hsize;
output                         [1:0] mst9_slv11_htrans;
output                               mst9_slv11_hwrite;
output                               mst9_slv11_req;
input                                mst9_slv11_sel;
output                         [3:0] mst9_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm9_slv12_hwdata;
output                  [DATA_MSB:0] mst9_hs12_hrdata;
output                               mst9_hs12_hready;
output                         [1:0] mst9_hs12_hresp;
input                                mst9_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv12_base;
output                               mst9_slv12_grant;
output                  [ADDR_MSB:0] mst9_slv12_haddr;
output                         [2:0] mst9_slv12_hburst;
output                         [3:0] mst9_slv12_hprot;
output                         [2:0] mst9_slv12_hsize;
output                         [1:0] mst9_slv12_htrans;
output                               mst9_slv12_hwrite;
output                               mst9_slv12_req;
input                                mst9_slv12_sel;
output                         [3:0] mst9_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm9_slv13_hwdata;
output                  [DATA_MSB:0] mst9_hs13_hrdata;
output                               mst9_hs13_hready;
output                         [1:0] mst9_hs13_hresp;
input                                mst9_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv13_base;
output                               mst9_slv13_grant;
output                  [ADDR_MSB:0] mst9_slv13_haddr;
output                         [2:0] mst9_slv13_hburst;
output                         [3:0] mst9_slv13_hprot;
output                         [2:0] mst9_slv13_hsize;
output                         [1:0] mst9_slv13_htrans;
output                               mst9_slv13_hwrite;
output                               mst9_slv13_req;
input                                mst9_slv13_sel;
output                         [3:0] mst9_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm9_slv14_hwdata;
output                  [DATA_MSB:0] mst9_hs14_hrdata;
output                               mst9_hs14_hready;
output                         [1:0] mst9_hs14_hresp;
input                                mst9_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv14_base;
output                               mst9_slv14_grant;
output                  [ADDR_MSB:0] mst9_slv14_haddr;
output                         [2:0] mst9_slv14_hburst;
output                         [3:0] mst9_slv14_hprot;
output                         [2:0] mst9_slv14_hsize;
output                         [1:0] mst9_slv14_htrans;
output                               mst9_slv14_hwrite;
output                               mst9_slv14_req;
input                                mst9_slv14_sel;
output                         [3:0] mst9_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm9_slv15_hwdata;
output                  [DATA_MSB:0] mst9_hs15_hrdata;
output                               mst9_hs15_hready;
output                         [1:0] mst9_hs15_hresp;
input                                mst9_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst9_slv15_base;
output                               mst9_slv15_grant;
output                  [ADDR_MSB:0] mst9_slv15_haddr;
output                         [2:0] mst9_slv15_hburst;
output                         [3:0] mst9_slv15_hprot;
output                         [2:0] mst9_slv15_hsize;
output                         [1:0] mst9_slv15_htrans;
output                               mst9_slv15_hwrite;
output                               mst9_slv15_req;
input                                mst9_slv15_sel;
output                         [3:0] mst9_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST10
output                  [DATA_MSB:0] hm10_slv0_hwdata;
output                  [DATA_MSB:0] mst10_hs0_hrdata;
output                               mst10_hs0_hready;
output                         [1:0] mst10_hs0_hresp;
input                                mst10_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv0_base;
output                               mst10_slv0_grant;
output                  [ADDR_MSB:0] mst10_slv0_haddr;
output                         [2:0] mst10_slv0_hburst;
output                         [3:0] mst10_slv0_hprot;
output                         [2:0] mst10_slv0_hsize;
output                         [1:0] mst10_slv0_htrans;
output                               mst10_slv0_hwrite;
output                               mst10_slv0_req;
input                                mst10_slv0_sel;
output                         [3:0] mst10_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST10
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm10_slv1_hwdata;
output                  [DATA_MSB:0] mst10_hs1_hrdata;
output                               mst10_hs1_hready;
output                         [1:0] mst10_hs1_hresp;
input                                mst10_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv1_base;
output                               mst10_slv1_grant;
output                  [ADDR_MSB:0] mst10_slv1_haddr;
output                         [2:0] mst10_slv1_hburst;
output                         [3:0] mst10_slv1_hprot;
output                         [2:0] mst10_slv1_hsize;
output                         [1:0] mst10_slv1_htrans;
output                               mst10_slv1_hwrite;
output                               mst10_slv1_req;
input                                mst10_slv1_sel;
output                         [3:0] mst10_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm10_slv2_hwdata;
output                  [DATA_MSB:0] mst10_hs2_hrdata;
output                               mst10_hs2_hready;
output                         [1:0] mst10_hs2_hresp;
input                                mst10_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv2_base;
output                               mst10_slv2_grant;
output                  [ADDR_MSB:0] mst10_slv2_haddr;
output                         [2:0] mst10_slv2_hburst;
output                         [3:0] mst10_slv2_hprot;
output                         [2:0] mst10_slv2_hsize;
output                         [1:0] mst10_slv2_htrans;
output                               mst10_slv2_hwrite;
output                               mst10_slv2_req;
input                                mst10_slv2_sel;
output                         [3:0] mst10_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm10_slv3_hwdata;
output                  [DATA_MSB:0] mst10_hs3_hrdata;
output                               mst10_hs3_hready;
output                         [1:0] mst10_hs3_hresp;
input                                mst10_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv3_base;
output                               mst10_slv3_grant;
output                  [ADDR_MSB:0] mst10_slv3_haddr;
output                         [2:0] mst10_slv3_hburst;
output                         [3:0] mst10_slv3_hprot;
output                         [2:0] mst10_slv3_hsize;
output                         [1:0] mst10_slv3_htrans;
output                               mst10_slv3_hwrite;
output                               mst10_slv3_req;
input                                mst10_slv3_sel;
output                         [3:0] mst10_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm10_slv4_hwdata;
output                  [DATA_MSB:0] mst10_hs4_hrdata;
output                               mst10_hs4_hready;
output                         [1:0] mst10_hs4_hresp;
input                                mst10_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv4_base;
output                               mst10_slv4_grant;
output                  [ADDR_MSB:0] mst10_slv4_haddr;
output                         [2:0] mst10_slv4_hburst;
output                         [3:0] mst10_slv4_hprot;
output                         [2:0] mst10_slv4_hsize;
output                         [1:0] mst10_slv4_htrans;
output                               mst10_slv4_hwrite;
output                               mst10_slv4_req;
input                                mst10_slv4_sel;
output                         [3:0] mst10_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm10_slv5_hwdata;
output                  [DATA_MSB:0] mst10_hs5_hrdata;
output                               mst10_hs5_hready;
output                         [1:0] mst10_hs5_hresp;
input                                mst10_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv5_base;
output                               mst10_slv5_grant;
output                  [ADDR_MSB:0] mst10_slv5_haddr;
output                         [2:0] mst10_slv5_hburst;
output                         [3:0] mst10_slv5_hprot;
output                         [2:0] mst10_slv5_hsize;
output                         [1:0] mst10_slv5_htrans;
output                               mst10_slv5_hwrite;
output                               mst10_slv5_req;
input                                mst10_slv5_sel;
output                         [3:0] mst10_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm10_slv6_hwdata;
output                  [DATA_MSB:0] mst10_hs6_hrdata;
output                               mst10_hs6_hready;
output                         [1:0] mst10_hs6_hresp;
input                                mst10_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv6_base;
output                               mst10_slv6_grant;
output                  [ADDR_MSB:0] mst10_slv6_haddr;
output                         [2:0] mst10_slv6_hburst;
output                         [3:0] mst10_slv6_hprot;
output                         [2:0] mst10_slv6_hsize;
output                         [1:0] mst10_slv6_htrans;
output                               mst10_slv6_hwrite;
output                               mst10_slv6_req;
input                                mst10_slv6_sel;
output                         [3:0] mst10_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm10_slv7_hwdata;
output                  [DATA_MSB:0] mst10_hs7_hrdata;
output                               mst10_hs7_hready;
output                         [1:0] mst10_hs7_hresp;
input                                mst10_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv7_base;
output                               mst10_slv7_grant;
output                  [ADDR_MSB:0] mst10_slv7_haddr;
output                         [2:0] mst10_slv7_hburst;
output                         [3:0] mst10_slv7_hprot;
output                         [2:0] mst10_slv7_hsize;
output                         [1:0] mst10_slv7_htrans;
output                               mst10_slv7_hwrite;
output                               mst10_slv7_req;
input                                mst10_slv7_sel;
output                         [3:0] mst10_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm10_slv8_hwdata;
output                  [DATA_MSB:0] mst10_hs8_hrdata;
output                               mst10_hs8_hready;
output                         [1:0] mst10_hs8_hresp;
input                                mst10_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv8_base;
output                               mst10_slv8_grant;
output                  [ADDR_MSB:0] mst10_slv8_haddr;
output                         [2:0] mst10_slv8_hburst;
output                         [3:0] mst10_slv8_hprot;
output                         [2:0] mst10_slv8_hsize;
output                         [1:0] mst10_slv8_htrans;
output                               mst10_slv8_hwrite;
output                               mst10_slv8_req;
input                                mst10_slv8_sel;
output                         [3:0] mst10_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm10_slv9_hwdata;
output                  [DATA_MSB:0] mst10_hs9_hrdata;
output                               mst10_hs9_hready;
output                         [1:0] mst10_hs9_hresp;
input                                mst10_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv9_base;
output                               mst10_slv9_grant;
output                  [ADDR_MSB:0] mst10_slv9_haddr;
output                         [2:0] mst10_slv9_hburst;
output                         [3:0] mst10_slv9_hprot;
output                         [2:0] mst10_slv9_hsize;
output                         [1:0] mst10_slv9_htrans;
output                               mst10_slv9_hwrite;
output                               mst10_slv9_req;
input                                mst10_slv9_sel;
output                         [3:0] mst10_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm10_slv10_hwdata;
output                  [DATA_MSB:0] mst10_hs10_hrdata;
output                               mst10_hs10_hready;
output                         [1:0] mst10_hs10_hresp;
input                                mst10_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv10_base;
output                               mst10_slv10_grant;
output                  [ADDR_MSB:0] mst10_slv10_haddr;
output                         [2:0] mst10_slv10_hburst;
output                         [3:0] mst10_slv10_hprot;
output                         [2:0] mst10_slv10_hsize;
output                         [1:0] mst10_slv10_htrans;
output                               mst10_slv10_hwrite;
output                               mst10_slv10_req;
input                                mst10_slv10_sel;
output                         [3:0] mst10_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm10_slv11_hwdata;
output                  [DATA_MSB:0] mst10_hs11_hrdata;
output                               mst10_hs11_hready;
output                         [1:0] mst10_hs11_hresp;
input                                mst10_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv11_base;
output                               mst10_slv11_grant;
output                  [ADDR_MSB:0] mst10_slv11_haddr;
output                         [2:0] mst10_slv11_hburst;
output                         [3:0] mst10_slv11_hprot;
output                         [2:0] mst10_slv11_hsize;
output                         [1:0] mst10_slv11_htrans;
output                               mst10_slv11_hwrite;
output                               mst10_slv11_req;
input                                mst10_slv11_sel;
output                         [3:0] mst10_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm10_slv12_hwdata;
output                  [DATA_MSB:0] mst10_hs12_hrdata;
output                               mst10_hs12_hready;
output                         [1:0] mst10_hs12_hresp;
input                                mst10_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv12_base;
output                               mst10_slv12_grant;
output                  [ADDR_MSB:0] mst10_slv12_haddr;
output                         [2:0] mst10_slv12_hburst;
output                         [3:0] mst10_slv12_hprot;
output                         [2:0] mst10_slv12_hsize;
output                         [1:0] mst10_slv12_htrans;
output                               mst10_slv12_hwrite;
output                               mst10_slv12_req;
input                                mst10_slv12_sel;
output                         [3:0] mst10_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm10_slv13_hwdata;
output                  [DATA_MSB:0] mst10_hs13_hrdata;
output                               mst10_hs13_hready;
output                         [1:0] mst10_hs13_hresp;
input                                mst10_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv13_base;
output                               mst10_slv13_grant;
output                  [ADDR_MSB:0] mst10_slv13_haddr;
output                         [2:0] mst10_slv13_hburst;
output                         [3:0] mst10_slv13_hprot;
output                         [2:0] mst10_slv13_hsize;
output                         [1:0] mst10_slv13_htrans;
output                               mst10_slv13_hwrite;
output                               mst10_slv13_req;
input                                mst10_slv13_sel;
output                         [3:0] mst10_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm10_slv14_hwdata;
output                  [DATA_MSB:0] mst10_hs14_hrdata;
output                               mst10_hs14_hready;
output                         [1:0] mst10_hs14_hresp;
input                                mst10_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv14_base;
output                               mst10_slv14_grant;
output                  [ADDR_MSB:0] mst10_slv14_haddr;
output                         [2:0] mst10_slv14_hburst;
output                         [3:0] mst10_slv14_hprot;
output                         [2:0] mst10_slv14_hsize;
output                         [1:0] mst10_slv14_htrans;
output                               mst10_slv14_hwrite;
output                               mst10_slv14_req;
input                                mst10_slv14_sel;
output                         [3:0] mst10_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm10_slv15_hwdata;
output                  [DATA_MSB:0] mst10_hs15_hrdata;
output                               mst10_hs15_hready;
output                         [1:0] mst10_hs15_hresp;
input                                mst10_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst10_slv15_base;
output                               mst10_slv15_grant;
output                  [ADDR_MSB:0] mst10_slv15_haddr;
output                         [2:0] mst10_slv15_hburst;
output                         [3:0] mst10_slv15_hprot;
output                         [2:0] mst10_slv15_hsize;
output                         [1:0] mst10_slv15_htrans;
output                               mst10_slv15_hwrite;
output                               mst10_slv15_req;
input                                mst10_slv15_sel;
output                         [3:0] mst10_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST11
output                  [DATA_MSB:0] hm11_slv0_hwdata;
output                  [DATA_MSB:0] mst11_hs0_hrdata;
output                               mst11_hs0_hready;
output                         [1:0] mst11_hs0_hresp;
input                                mst11_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv0_base;
output                               mst11_slv0_grant;
output                  [ADDR_MSB:0] mst11_slv0_haddr;
output                         [2:0] mst11_slv0_hburst;
output                         [3:0] mst11_slv0_hprot;
output                         [2:0] mst11_slv0_hsize;
output                         [1:0] mst11_slv0_htrans;
output                               mst11_slv0_hwrite;
output                               mst11_slv0_req;
input                                mst11_slv0_sel;
output                         [3:0] mst11_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST11
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm11_slv1_hwdata;
output                  [DATA_MSB:0] mst11_hs1_hrdata;
output                               mst11_hs1_hready;
output                         [1:0] mst11_hs1_hresp;
input                                mst11_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv1_base;
output                               mst11_slv1_grant;
output                  [ADDR_MSB:0] mst11_slv1_haddr;
output                         [2:0] mst11_slv1_hburst;
output                         [3:0] mst11_slv1_hprot;
output                         [2:0] mst11_slv1_hsize;
output                         [1:0] mst11_slv1_htrans;
output                               mst11_slv1_hwrite;
output                               mst11_slv1_req;
input                                mst11_slv1_sel;
output                         [3:0] mst11_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm11_slv2_hwdata;
output                  [DATA_MSB:0] mst11_hs2_hrdata;
output                               mst11_hs2_hready;
output                         [1:0] mst11_hs2_hresp;
input                                mst11_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv2_base;
output                               mst11_slv2_grant;
output                  [ADDR_MSB:0] mst11_slv2_haddr;
output                         [2:0] mst11_slv2_hburst;
output                         [3:0] mst11_slv2_hprot;
output                         [2:0] mst11_slv2_hsize;
output                         [1:0] mst11_slv2_htrans;
output                               mst11_slv2_hwrite;
output                               mst11_slv2_req;
input                                mst11_slv2_sel;
output                         [3:0] mst11_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm11_slv3_hwdata;
output                  [DATA_MSB:0] mst11_hs3_hrdata;
output                               mst11_hs3_hready;
output                         [1:0] mst11_hs3_hresp;
input                                mst11_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv3_base;
output                               mst11_slv3_grant;
output                  [ADDR_MSB:0] mst11_slv3_haddr;
output                         [2:0] mst11_slv3_hburst;
output                         [3:0] mst11_slv3_hprot;
output                         [2:0] mst11_slv3_hsize;
output                         [1:0] mst11_slv3_htrans;
output                               mst11_slv3_hwrite;
output                               mst11_slv3_req;
input                                mst11_slv3_sel;
output                         [3:0] mst11_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm11_slv4_hwdata;
output                  [DATA_MSB:0] mst11_hs4_hrdata;
output                               mst11_hs4_hready;
output                         [1:0] mst11_hs4_hresp;
input                                mst11_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv4_base;
output                               mst11_slv4_grant;
output                  [ADDR_MSB:0] mst11_slv4_haddr;
output                         [2:0] mst11_slv4_hburst;
output                         [3:0] mst11_slv4_hprot;
output                         [2:0] mst11_slv4_hsize;
output                         [1:0] mst11_slv4_htrans;
output                               mst11_slv4_hwrite;
output                               mst11_slv4_req;
input                                mst11_slv4_sel;
output                         [3:0] mst11_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm11_slv5_hwdata;
output                  [DATA_MSB:0] mst11_hs5_hrdata;
output                               mst11_hs5_hready;
output                         [1:0] mst11_hs5_hresp;
input                                mst11_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv5_base;
output                               mst11_slv5_grant;
output                  [ADDR_MSB:0] mst11_slv5_haddr;
output                         [2:0] mst11_slv5_hburst;
output                         [3:0] mst11_slv5_hprot;
output                         [2:0] mst11_slv5_hsize;
output                         [1:0] mst11_slv5_htrans;
output                               mst11_slv5_hwrite;
output                               mst11_slv5_req;
input                                mst11_slv5_sel;
output                         [3:0] mst11_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm11_slv6_hwdata;
output                  [DATA_MSB:0] mst11_hs6_hrdata;
output                               mst11_hs6_hready;
output                         [1:0] mst11_hs6_hresp;
input                                mst11_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv6_base;
output                               mst11_slv6_grant;
output                  [ADDR_MSB:0] mst11_slv6_haddr;
output                         [2:0] mst11_slv6_hburst;
output                         [3:0] mst11_slv6_hprot;
output                         [2:0] mst11_slv6_hsize;
output                         [1:0] mst11_slv6_htrans;
output                               mst11_slv6_hwrite;
output                               mst11_slv6_req;
input                                mst11_slv6_sel;
output                         [3:0] mst11_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm11_slv7_hwdata;
output                  [DATA_MSB:0] mst11_hs7_hrdata;
output                               mst11_hs7_hready;
output                         [1:0] mst11_hs7_hresp;
input                                mst11_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv7_base;
output                               mst11_slv7_grant;
output                  [ADDR_MSB:0] mst11_slv7_haddr;
output                         [2:0] mst11_slv7_hburst;
output                         [3:0] mst11_slv7_hprot;
output                         [2:0] mst11_slv7_hsize;
output                         [1:0] mst11_slv7_htrans;
output                               mst11_slv7_hwrite;
output                               mst11_slv7_req;
input                                mst11_slv7_sel;
output                         [3:0] mst11_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm11_slv8_hwdata;
output                  [DATA_MSB:0] mst11_hs8_hrdata;
output                               mst11_hs8_hready;
output                         [1:0] mst11_hs8_hresp;
input                                mst11_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv8_base;
output                               mst11_slv8_grant;
output                  [ADDR_MSB:0] mst11_slv8_haddr;
output                         [2:0] mst11_slv8_hburst;
output                         [3:0] mst11_slv8_hprot;
output                         [2:0] mst11_slv8_hsize;
output                         [1:0] mst11_slv8_htrans;
output                               mst11_slv8_hwrite;
output                               mst11_slv8_req;
input                                mst11_slv8_sel;
output                         [3:0] mst11_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm11_slv9_hwdata;
output                  [DATA_MSB:0] mst11_hs9_hrdata;
output                               mst11_hs9_hready;
output                         [1:0] mst11_hs9_hresp;
input                                mst11_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv9_base;
output                               mst11_slv9_grant;
output                  [ADDR_MSB:0] mst11_slv9_haddr;
output                         [2:0] mst11_slv9_hburst;
output                         [3:0] mst11_slv9_hprot;
output                         [2:0] mst11_slv9_hsize;
output                         [1:0] mst11_slv9_htrans;
output                               mst11_slv9_hwrite;
output                               mst11_slv9_req;
input                                mst11_slv9_sel;
output                         [3:0] mst11_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm11_slv10_hwdata;
output                  [DATA_MSB:0] mst11_hs10_hrdata;
output                               mst11_hs10_hready;
output                         [1:0] mst11_hs10_hresp;
input                                mst11_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv10_base;
output                               mst11_slv10_grant;
output                  [ADDR_MSB:0] mst11_slv10_haddr;
output                         [2:0] mst11_slv10_hburst;
output                         [3:0] mst11_slv10_hprot;
output                         [2:0] mst11_slv10_hsize;
output                         [1:0] mst11_slv10_htrans;
output                               mst11_slv10_hwrite;
output                               mst11_slv10_req;
input                                mst11_slv10_sel;
output                         [3:0] mst11_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm11_slv11_hwdata;
output                  [DATA_MSB:0] mst11_hs11_hrdata;
output                               mst11_hs11_hready;
output                         [1:0] mst11_hs11_hresp;
input                                mst11_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv11_base;
output                               mst11_slv11_grant;
output                  [ADDR_MSB:0] mst11_slv11_haddr;
output                         [2:0] mst11_slv11_hburst;
output                         [3:0] mst11_slv11_hprot;
output                         [2:0] mst11_slv11_hsize;
output                         [1:0] mst11_slv11_htrans;
output                               mst11_slv11_hwrite;
output                               mst11_slv11_req;
input                                mst11_slv11_sel;
output                         [3:0] mst11_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm11_slv12_hwdata;
output                  [DATA_MSB:0] mst11_hs12_hrdata;
output                               mst11_hs12_hready;
output                         [1:0] mst11_hs12_hresp;
input                                mst11_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv12_base;
output                               mst11_slv12_grant;
output                  [ADDR_MSB:0] mst11_slv12_haddr;
output                         [2:0] mst11_slv12_hburst;
output                         [3:0] mst11_slv12_hprot;
output                         [2:0] mst11_slv12_hsize;
output                         [1:0] mst11_slv12_htrans;
output                               mst11_slv12_hwrite;
output                               mst11_slv12_req;
input                                mst11_slv12_sel;
output                         [3:0] mst11_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm11_slv13_hwdata;
output                  [DATA_MSB:0] mst11_hs13_hrdata;
output                               mst11_hs13_hready;
output                         [1:0] mst11_hs13_hresp;
input                                mst11_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv13_base;
output                               mst11_slv13_grant;
output                  [ADDR_MSB:0] mst11_slv13_haddr;
output                         [2:0] mst11_slv13_hburst;
output                         [3:0] mst11_slv13_hprot;
output                         [2:0] mst11_slv13_hsize;
output                         [1:0] mst11_slv13_htrans;
output                               mst11_slv13_hwrite;
output                               mst11_slv13_req;
input                                mst11_slv13_sel;
output                         [3:0] mst11_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm11_slv14_hwdata;
output                  [DATA_MSB:0] mst11_hs14_hrdata;
output                               mst11_hs14_hready;
output                         [1:0] mst11_hs14_hresp;
input                                mst11_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv14_base;
output                               mst11_slv14_grant;
output                  [ADDR_MSB:0] mst11_slv14_haddr;
output                         [2:0] mst11_slv14_hburst;
output                         [3:0] mst11_slv14_hprot;
output                         [2:0] mst11_slv14_hsize;
output                         [1:0] mst11_slv14_htrans;
output                               mst11_slv14_hwrite;
output                               mst11_slv14_req;
input                                mst11_slv14_sel;
output                         [3:0] mst11_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm11_slv15_hwdata;
output                  [DATA_MSB:0] mst11_hs15_hrdata;
output                               mst11_hs15_hready;
output                         [1:0] mst11_hs15_hresp;
input                                mst11_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst11_slv15_base;
output                               mst11_slv15_grant;
output                  [ADDR_MSB:0] mst11_slv15_haddr;
output                         [2:0] mst11_slv15_hburst;
output                         [3:0] mst11_slv15_hprot;
output                         [2:0] mst11_slv15_hsize;
output                         [1:0] mst11_slv15_htrans;
output                               mst11_slv15_hwrite;
output                               mst11_slv15_req;
input                                mst11_slv15_sel;
output                         [3:0] mst11_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST12
output                  [DATA_MSB:0] hm12_slv0_hwdata;
output                  [DATA_MSB:0] mst12_hs0_hrdata;
output                               mst12_hs0_hready;
output                         [1:0] mst12_hs0_hresp;
input                                mst12_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv0_base;
output                               mst12_slv0_grant;
output                  [ADDR_MSB:0] mst12_slv0_haddr;
output                         [2:0] mst12_slv0_hburst;
output                         [3:0] mst12_slv0_hprot;
output                         [2:0] mst12_slv0_hsize;
output                         [1:0] mst12_slv0_htrans;
output                               mst12_slv0_hwrite;
output                               mst12_slv0_req;
input                                mst12_slv0_sel;
output                         [3:0] mst12_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST12
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm12_slv1_hwdata;
output                  [DATA_MSB:0] mst12_hs1_hrdata;
output                               mst12_hs1_hready;
output                         [1:0] mst12_hs1_hresp;
input                                mst12_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv1_base;
output                               mst12_slv1_grant;
output                  [ADDR_MSB:0] mst12_slv1_haddr;
output                         [2:0] mst12_slv1_hburst;
output                         [3:0] mst12_slv1_hprot;
output                         [2:0] mst12_slv1_hsize;
output                         [1:0] mst12_slv1_htrans;
output                               mst12_slv1_hwrite;
output                               mst12_slv1_req;
input                                mst12_slv1_sel;
output                         [3:0] mst12_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm12_slv2_hwdata;
output                  [DATA_MSB:0] mst12_hs2_hrdata;
output                               mst12_hs2_hready;
output                         [1:0] mst12_hs2_hresp;
input                                mst12_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv2_base;
output                               mst12_slv2_grant;
output                  [ADDR_MSB:0] mst12_slv2_haddr;
output                         [2:0] mst12_slv2_hburst;
output                         [3:0] mst12_slv2_hprot;
output                         [2:0] mst12_slv2_hsize;
output                         [1:0] mst12_slv2_htrans;
output                               mst12_slv2_hwrite;
output                               mst12_slv2_req;
input                                mst12_slv2_sel;
output                         [3:0] mst12_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm12_slv3_hwdata;
output                  [DATA_MSB:0] mst12_hs3_hrdata;
output                               mst12_hs3_hready;
output                         [1:0] mst12_hs3_hresp;
input                                mst12_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv3_base;
output                               mst12_slv3_grant;
output                  [ADDR_MSB:0] mst12_slv3_haddr;
output                         [2:0] mst12_slv3_hburst;
output                         [3:0] mst12_slv3_hprot;
output                         [2:0] mst12_slv3_hsize;
output                         [1:0] mst12_slv3_htrans;
output                               mst12_slv3_hwrite;
output                               mst12_slv3_req;
input                                mst12_slv3_sel;
output                         [3:0] mst12_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm12_slv4_hwdata;
output                  [DATA_MSB:0] mst12_hs4_hrdata;
output                               mst12_hs4_hready;
output                         [1:0] mst12_hs4_hresp;
input                                mst12_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv4_base;
output                               mst12_slv4_grant;
output                  [ADDR_MSB:0] mst12_slv4_haddr;
output                         [2:0] mst12_slv4_hburst;
output                         [3:0] mst12_slv4_hprot;
output                         [2:0] mst12_slv4_hsize;
output                         [1:0] mst12_slv4_htrans;
output                               mst12_slv4_hwrite;
output                               mst12_slv4_req;
input                                mst12_slv4_sel;
output                         [3:0] mst12_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm12_slv5_hwdata;
output                  [DATA_MSB:0] mst12_hs5_hrdata;
output                               mst12_hs5_hready;
output                         [1:0] mst12_hs5_hresp;
input                                mst12_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv5_base;
output                               mst12_slv5_grant;
output                  [ADDR_MSB:0] mst12_slv5_haddr;
output                         [2:0] mst12_slv5_hburst;
output                         [3:0] mst12_slv5_hprot;
output                         [2:0] mst12_slv5_hsize;
output                         [1:0] mst12_slv5_htrans;
output                               mst12_slv5_hwrite;
output                               mst12_slv5_req;
input                                mst12_slv5_sel;
output                         [3:0] mst12_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm12_slv6_hwdata;
output                  [DATA_MSB:0] mst12_hs6_hrdata;
output                               mst12_hs6_hready;
output                         [1:0] mst12_hs6_hresp;
input                                mst12_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv6_base;
output                               mst12_slv6_grant;
output                  [ADDR_MSB:0] mst12_slv6_haddr;
output                         [2:0] mst12_slv6_hburst;
output                         [3:0] mst12_slv6_hprot;
output                         [2:0] mst12_slv6_hsize;
output                         [1:0] mst12_slv6_htrans;
output                               mst12_slv6_hwrite;
output                               mst12_slv6_req;
input                                mst12_slv6_sel;
output                         [3:0] mst12_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm12_slv7_hwdata;
output                  [DATA_MSB:0] mst12_hs7_hrdata;
output                               mst12_hs7_hready;
output                         [1:0] mst12_hs7_hresp;
input                                mst12_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv7_base;
output                               mst12_slv7_grant;
output                  [ADDR_MSB:0] mst12_slv7_haddr;
output                         [2:0] mst12_slv7_hburst;
output                         [3:0] mst12_slv7_hprot;
output                         [2:0] mst12_slv7_hsize;
output                         [1:0] mst12_slv7_htrans;
output                               mst12_slv7_hwrite;
output                               mst12_slv7_req;
input                                mst12_slv7_sel;
output                         [3:0] mst12_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm12_slv8_hwdata;
output                  [DATA_MSB:0] mst12_hs8_hrdata;
output                               mst12_hs8_hready;
output                         [1:0] mst12_hs8_hresp;
input                                mst12_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv8_base;
output                               mst12_slv8_grant;
output                  [ADDR_MSB:0] mst12_slv8_haddr;
output                         [2:0] mst12_slv8_hburst;
output                         [3:0] mst12_slv8_hprot;
output                         [2:0] mst12_slv8_hsize;
output                         [1:0] mst12_slv8_htrans;
output                               mst12_slv8_hwrite;
output                               mst12_slv8_req;
input                                mst12_slv8_sel;
output                         [3:0] mst12_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm12_slv9_hwdata;
output                  [DATA_MSB:0] mst12_hs9_hrdata;
output                               mst12_hs9_hready;
output                         [1:0] mst12_hs9_hresp;
input                                mst12_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv9_base;
output                               mst12_slv9_grant;
output                  [ADDR_MSB:0] mst12_slv9_haddr;
output                         [2:0] mst12_slv9_hburst;
output                         [3:0] mst12_slv9_hprot;
output                         [2:0] mst12_slv9_hsize;
output                         [1:0] mst12_slv9_htrans;
output                               mst12_slv9_hwrite;
output                               mst12_slv9_req;
input                                mst12_slv9_sel;
output                         [3:0] mst12_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm12_slv10_hwdata;
output                  [DATA_MSB:0] mst12_hs10_hrdata;
output                               mst12_hs10_hready;
output                         [1:0] mst12_hs10_hresp;
input                                mst12_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv10_base;
output                               mst12_slv10_grant;
output                  [ADDR_MSB:0] mst12_slv10_haddr;
output                         [2:0] mst12_slv10_hburst;
output                         [3:0] mst12_slv10_hprot;
output                         [2:0] mst12_slv10_hsize;
output                         [1:0] mst12_slv10_htrans;
output                               mst12_slv10_hwrite;
output                               mst12_slv10_req;
input                                mst12_slv10_sel;
output                         [3:0] mst12_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm12_slv11_hwdata;
output                  [DATA_MSB:0] mst12_hs11_hrdata;
output                               mst12_hs11_hready;
output                         [1:0] mst12_hs11_hresp;
input                                mst12_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv11_base;
output                               mst12_slv11_grant;
output                  [ADDR_MSB:0] mst12_slv11_haddr;
output                         [2:0] mst12_slv11_hburst;
output                         [3:0] mst12_slv11_hprot;
output                         [2:0] mst12_slv11_hsize;
output                         [1:0] mst12_slv11_htrans;
output                               mst12_slv11_hwrite;
output                               mst12_slv11_req;
input                                mst12_slv11_sel;
output                         [3:0] mst12_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm12_slv12_hwdata;
output                  [DATA_MSB:0] mst12_hs12_hrdata;
output                               mst12_hs12_hready;
output                         [1:0] mst12_hs12_hresp;
input                                mst12_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv12_base;
output                               mst12_slv12_grant;
output                  [ADDR_MSB:0] mst12_slv12_haddr;
output                         [2:0] mst12_slv12_hburst;
output                         [3:0] mst12_slv12_hprot;
output                         [2:0] mst12_slv12_hsize;
output                         [1:0] mst12_slv12_htrans;
output                               mst12_slv12_hwrite;
output                               mst12_slv12_req;
input                                mst12_slv12_sel;
output                         [3:0] mst12_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm12_slv13_hwdata;
output                  [DATA_MSB:0] mst12_hs13_hrdata;
output                               mst12_hs13_hready;
output                         [1:0] mst12_hs13_hresp;
input                                mst12_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv13_base;
output                               mst12_slv13_grant;
output                  [ADDR_MSB:0] mst12_slv13_haddr;
output                         [2:0] mst12_slv13_hburst;
output                         [3:0] mst12_slv13_hprot;
output                         [2:0] mst12_slv13_hsize;
output                         [1:0] mst12_slv13_htrans;
output                               mst12_slv13_hwrite;
output                               mst12_slv13_req;
input                                mst12_slv13_sel;
output                         [3:0] mst12_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm12_slv14_hwdata;
output                  [DATA_MSB:0] mst12_hs14_hrdata;
output                               mst12_hs14_hready;
output                         [1:0] mst12_hs14_hresp;
input                                mst12_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv14_base;
output                               mst12_slv14_grant;
output                  [ADDR_MSB:0] mst12_slv14_haddr;
output                         [2:0] mst12_slv14_hburst;
output                         [3:0] mst12_slv14_hprot;
output                         [2:0] mst12_slv14_hsize;
output                         [1:0] mst12_slv14_htrans;
output                               mst12_slv14_hwrite;
output                               mst12_slv14_req;
input                                mst12_slv14_sel;
output                         [3:0] mst12_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm12_slv15_hwdata;
output                  [DATA_MSB:0] mst12_hs15_hrdata;
output                               mst12_hs15_hready;
output                         [1:0] mst12_hs15_hresp;
input                                mst12_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst12_slv15_base;
output                               mst12_slv15_grant;
output                  [ADDR_MSB:0] mst12_slv15_haddr;
output                         [2:0] mst12_slv15_hburst;
output                         [3:0] mst12_slv15_hprot;
output                         [2:0] mst12_slv15_hsize;
output                         [1:0] mst12_slv15_htrans;
output                               mst12_slv15_hwrite;
output                               mst12_slv15_req;
input                                mst12_slv15_sel;
output                         [3:0] mst12_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST13
output                  [DATA_MSB:0] hm13_slv0_hwdata;
output                  [DATA_MSB:0] mst13_hs0_hrdata;
output                               mst13_hs0_hready;
output                         [1:0] mst13_hs0_hresp;
input                                mst13_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv0_base;
output                               mst13_slv0_grant;
output                  [ADDR_MSB:0] mst13_slv0_haddr;
output                         [2:0] mst13_slv0_hburst;
output                         [3:0] mst13_slv0_hprot;
output                         [2:0] mst13_slv0_hsize;
output                         [1:0] mst13_slv0_htrans;
output                               mst13_slv0_hwrite;
output                               mst13_slv0_req;
input                                mst13_slv0_sel;
output                         [3:0] mst13_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST13
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm13_slv1_hwdata;
output                  [DATA_MSB:0] mst13_hs1_hrdata;
output                               mst13_hs1_hready;
output                         [1:0] mst13_hs1_hresp;
input                                mst13_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv1_base;
output                               mst13_slv1_grant;
output                  [ADDR_MSB:0] mst13_slv1_haddr;
output                         [2:0] mst13_slv1_hburst;
output                         [3:0] mst13_slv1_hprot;
output                         [2:0] mst13_slv1_hsize;
output                         [1:0] mst13_slv1_htrans;
output                               mst13_slv1_hwrite;
output                               mst13_slv1_req;
input                                mst13_slv1_sel;
output                         [3:0] mst13_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm13_slv2_hwdata;
output                  [DATA_MSB:0] mst13_hs2_hrdata;
output                               mst13_hs2_hready;
output                         [1:0] mst13_hs2_hresp;
input                                mst13_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv2_base;
output                               mst13_slv2_grant;
output                  [ADDR_MSB:0] mst13_slv2_haddr;
output                         [2:0] mst13_slv2_hburst;
output                         [3:0] mst13_slv2_hprot;
output                         [2:0] mst13_slv2_hsize;
output                         [1:0] mst13_slv2_htrans;
output                               mst13_slv2_hwrite;
output                               mst13_slv2_req;
input                                mst13_slv2_sel;
output                         [3:0] mst13_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm13_slv3_hwdata;
output                  [DATA_MSB:0] mst13_hs3_hrdata;
output                               mst13_hs3_hready;
output                         [1:0] mst13_hs3_hresp;
input                                mst13_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv3_base;
output                               mst13_slv3_grant;
output                  [ADDR_MSB:0] mst13_slv3_haddr;
output                         [2:0] mst13_slv3_hburst;
output                         [3:0] mst13_slv3_hprot;
output                         [2:0] mst13_slv3_hsize;
output                         [1:0] mst13_slv3_htrans;
output                               mst13_slv3_hwrite;
output                               mst13_slv3_req;
input                                mst13_slv3_sel;
output                         [3:0] mst13_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm13_slv4_hwdata;
output                  [DATA_MSB:0] mst13_hs4_hrdata;
output                               mst13_hs4_hready;
output                         [1:0] mst13_hs4_hresp;
input                                mst13_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv4_base;
output                               mst13_slv4_grant;
output                  [ADDR_MSB:0] mst13_slv4_haddr;
output                         [2:0] mst13_slv4_hburst;
output                         [3:0] mst13_slv4_hprot;
output                         [2:0] mst13_slv4_hsize;
output                         [1:0] mst13_slv4_htrans;
output                               mst13_slv4_hwrite;
output                               mst13_slv4_req;
input                                mst13_slv4_sel;
output                         [3:0] mst13_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm13_slv5_hwdata;
output                  [DATA_MSB:0] mst13_hs5_hrdata;
output                               mst13_hs5_hready;
output                         [1:0] mst13_hs5_hresp;
input                                mst13_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv5_base;
output                               mst13_slv5_grant;
output                  [ADDR_MSB:0] mst13_slv5_haddr;
output                         [2:0] mst13_slv5_hburst;
output                         [3:0] mst13_slv5_hprot;
output                         [2:0] mst13_slv5_hsize;
output                         [1:0] mst13_slv5_htrans;
output                               mst13_slv5_hwrite;
output                               mst13_slv5_req;
input                                mst13_slv5_sel;
output                         [3:0] mst13_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm13_slv6_hwdata;
output                  [DATA_MSB:0] mst13_hs6_hrdata;
output                               mst13_hs6_hready;
output                         [1:0] mst13_hs6_hresp;
input                                mst13_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv6_base;
output                               mst13_slv6_grant;
output                  [ADDR_MSB:0] mst13_slv6_haddr;
output                         [2:0] mst13_slv6_hburst;
output                         [3:0] mst13_slv6_hprot;
output                         [2:0] mst13_slv6_hsize;
output                         [1:0] mst13_slv6_htrans;
output                               mst13_slv6_hwrite;
output                               mst13_slv6_req;
input                                mst13_slv6_sel;
output                         [3:0] mst13_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm13_slv7_hwdata;
output                  [DATA_MSB:0] mst13_hs7_hrdata;
output                               mst13_hs7_hready;
output                         [1:0] mst13_hs7_hresp;
input                                mst13_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv7_base;
output                               mst13_slv7_grant;
output                  [ADDR_MSB:0] mst13_slv7_haddr;
output                         [2:0] mst13_slv7_hburst;
output                         [3:0] mst13_slv7_hprot;
output                         [2:0] mst13_slv7_hsize;
output                         [1:0] mst13_slv7_htrans;
output                               mst13_slv7_hwrite;
output                               mst13_slv7_req;
input                                mst13_slv7_sel;
output                         [3:0] mst13_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm13_slv8_hwdata;
output                  [DATA_MSB:0] mst13_hs8_hrdata;
output                               mst13_hs8_hready;
output                         [1:0] mst13_hs8_hresp;
input                                mst13_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv8_base;
output                               mst13_slv8_grant;
output                  [ADDR_MSB:0] mst13_slv8_haddr;
output                         [2:0] mst13_slv8_hburst;
output                         [3:0] mst13_slv8_hprot;
output                         [2:0] mst13_slv8_hsize;
output                         [1:0] mst13_slv8_htrans;
output                               mst13_slv8_hwrite;
output                               mst13_slv8_req;
input                                mst13_slv8_sel;
output                         [3:0] mst13_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm13_slv9_hwdata;
output                  [DATA_MSB:0] mst13_hs9_hrdata;
output                               mst13_hs9_hready;
output                         [1:0] mst13_hs9_hresp;
input                                mst13_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv9_base;
output                               mst13_slv9_grant;
output                  [ADDR_MSB:0] mst13_slv9_haddr;
output                         [2:0] mst13_slv9_hburst;
output                         [3:0] mst13_slv9_hprot;
output                         [2:0] mst13_slv9_hsize;
output                         [1:0] mst13_slv9_htrans;
output                               mst13_slv9_hwrite;
output                               mst13_slv9_req;
input                                mst13_slv9_sel;
output                         [3:0] mst13_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm13_slv10_hwdata;
output                  [DATA_MSB:0] mst13_hs10_hrdata;
output                               mst13_hs10_hready;
output                         [1:0] mst13_hs10_hresp;
input                                mst13_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv10_base;
output                               mst13_slv10_grant;
output                  [ADDR_MSB:0] mst13_slv10_haddr;
output                         [2:0] mst13_slv10_hburst;
output                         [3:0] mst13_slv10_hprot;
output                         [2:0] mst13_slv10_hsize;
output                         [1:0] mst13_slv10_htrans;
output                               mst13_slv10_hwrite;
output                               mst13_slv10_req;
input                                mst13_slv10_sel;
output                         [3:0] mst13_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm13_slv11_hwdata;
output                  [DATA_MSB:0] mst13_hs11_hrdata;
output                               mst13_hs11_hready;
output                         [1:0] mst13_hs11_hresp;
input                                mst13_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv11_base;
output                               mst13_slv11_grant;
output                  [ADDR_MSB:0] mst13_slv11_haddr;
output                         [2:0] mst13_slv11_hburst;
output                         [3:0] mst13_slv11_hprot;
output                         [2:0] mst13_slv11_hsize;
output                         [1:0] mst13_slv11_htrans;
output                               mst13_slv11_hwrite;
output                               mst13_slv11_req;
input                                mst13_slv11_sel;
output                         [3:0] mst13_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm13_slv12_hwdata;
output                  [DATA_MSB:0] mst13_hs12_hrdata;
output                               mst13_hs12_hready;
output                         [1:0] mst13_hs12_hresp;
input                                mst13_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv12_base;
output                               mst13_slv12_grant;
output                  [ADDR_MSB:0] mst13_slv12_haddr;
output                         [2:0] mst13_slv12_hburst;
output                         [3:0] mst13_slv12_hprot;
output                         [2:0] mst13_slv12_hsize;
output                         [1:0] mst13_slv12_htrans;
output                               mst13_slv12_hwrite;
output                               mst13_slv12_req;
input                                mst13_slv12_sel;
output                         [3:0] mst13_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm13_slv13_hwdata;
output                  [DATA_MSB:0] mst13_hs13_hrdata;
output                               mst13_hs13_hready;
output                         [1:0] mst13_hs13_hresp;
input                                mst13_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv13_base;
output                               mst13_slv13_grant;
output                  [ADDR_MSB:0] mst13_slv13_haddr;
output                         [2:0] mst13_slv13_hburst;
output                         [3:0] mst13_slv13_hprot;
output                         [2:0] mst13_slv13_hsize;
output                         [1:0] mst13_slv13_htrans;
output                               mst13_slv13_hwrite;
output                               mst13_slv13_req;
input                                mst13_slv13_sel;
output                         [3:0] mst13_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm13_slv14_hwdata;
output                  [DATA_MSB:0] mst13_hs14_hrdata;
output                               mst13_hs14_hready;
output                         [1:0] mst13_hs14_hresp;
input                                mst13_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv14_base;
output                               mst13_slv14_grant;
output                  [ADDR_MSB:0] mst13_slv14_haddr;
output                         [2:0] mst13_slv14_hburst;
output                         [3:0] mst13_slv14_hprot;
output                         [2:0] mst13_slv14_hsize;
output                         [1:0] mst13_slv14_htrans;
output                               mst13_slv14_hwrite;
output                               mst13_slv14_req;
input                                mst13_slv14_sel;
output                         [3:0] mst13_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm13_slv15_hwdata;
output                  [DATA_MSB:0] mst13_hs15_hrdata;
output                               mst13_hs15_hready;
output                         [1:0] mst13_hs15_hresp;
input                                mst13_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst13_slv15_base;
output                               mst13_slv15_grant;
output                  [ADDR_MSB:0] mst13_slv15_haddr;
output                         [2:0] mst13_slv15_hburst;
output                         [3:0] mst13_slv15_hprot;
output                         [2:0] mst13_slv15_hsize;
output                         [1:0] mst13_slv15_htrans;
output                               mst13_slv15_hwrite;
output                               mst13_slv15_req;
input                                mst13_slv15_sel;
output                         [3:0] mst13_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST14
output                  [DATA_MSB:0] hm14_slv0_hwdata;
output                  [DATA_MSB:0] mst14_hs0_hrdata;
output                               mst14_hs0_hready;
output                         [1:0] mst14_hs0_hresp;
input                                mst14_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv0_base;
output                               mst14_slv0_grant;
output                  [ADDR_MSB:0] mst14_slv0_haddr;
output                         [2:0] mst14_slv0_hburst;
output                         [3:0] mst14_slv0_hprot;
output                         [2:0] mst14_slv0_hsize;
output                         [1:0] mst14_slv0_htrans;
output                               mst14_slv0_hwrite;
output                               mst14_slv0_req;
input                                mst14_slv0_sel;
output                         [3:0] mst14_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST14
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm14_slv1_hwdata;
output                  [DATA_MSB:0] mst14_hs1_hrdata;
output                               mst14_hs1_hready;
output                         [1:0] mst14_hs1_hresp;
input                                mst14_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv1_base;
output                               mst14_slv1_grant;
output                  [ADDR_MSB:0] mst14_slv1_haddr;
output                         [2:0] mst14_slv1_hburst;
output                         [3:0] mst14_slv1_hprot;
output                         [2:0] mst14_slv1_hsize;
output                         [1:0] mst14_slv1_htrans;
output                               mst14_slv1_hwrite;
output                               mst14_slv1_req;
input                                mst14_slv1_sel;
output                         [3:0] mst14_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm14_slv2_hwdata;
output                  [DATA_MSB:0] mst14_hs2_hrdata;
output                               mst14_hs2_hready;
output                         [1:0] mst14_hs2_hresp;
input                                mst14_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv2_base;
output                               mst14_slv2_grant;
output                  [ADDR_MSB:0] mst14_slv2_haddr;
output                         [2:0] mst14_slv2_hburst;
output                         [3:0] mst14_slv2_hprot;
output                         [2:0] mst14_slv2_hsize;
output                         [1:0] mst14_slv2_htrans;
output                               mst14_slv2_hwrite;
output                               mst14_slv2_req;
input                                mst14_slv2_sel;
output                         [3:0] mst14_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm14_slv3_hwdata;
output                  [DATA_MSB:0] mst14_hs3_hrdata;
output                               mst14_hs3_hready;
output                         [1:0] mst14_hs3_hresp;
input                                mst14_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv3_base;
output                               mst14_slv3_grant;
output                  [ADDR_MSB:0] mst14_slv3_haddr;
output                         [2:0] mst14_slv3_hburst;
output                         [3:0] mst14_slv3_hprot;
output                         [2:0] mst14_slv3_hsize;
output                         [1:0] mst14_slv3_htrans;
output                               mst14_slv3_hwrite;
output                               mst14_slv3_req;
input                                mst14_slv3_sel;
output                         [3:0] mst14_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm14_slv4_hwdata;
output                  [DATA_MSB:0] mst14_hs4_hrdata;
output                               mst14_hs4_hready;
output                         [1:0] mst14_hs4_hresp;
input                                mst14_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv4_base;
output                               mst14_slv4_grant;
output                  [ADDR_MSB:0] mst14_slv4_haddr;
output                         [2:0] mst14_slv4_hburst;
output                         [3:0] mst14_slv4_hprot;
output                         [2:0] mst14_slv4_hsize;
output                         [1:0] mst14_slv4_htrans;
output                               mst14_slv4_hwrite;
output                               mst14_slv4_req;
input                                mst14_slv4_sel;
output                         [3:0] mst14_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm14_slv5_hwdata;
output                  [DATA_MSB:0] mst14_hs5_hrdata;
output                               mst14_hs5_hready;
output                         [1:0] mst14_hs5_hresp;
input                                mst14_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv5_base;
output                               mst14_slv5_grant;
output                  [ADDR_MSB:0] mst14_slv5_haddr;
output                         [2:0] mst14_slv5_hburst;
output                         [3:0] mst14_slv5_hprot;
output                         [2:0] mst14_slv5_hsize;
output                         [1:0] mst14_slv5_htrans;
output                               mst14_slv5_hwrite;
output                               mst14_slv5_req;
input                                mst14_slv5_sel;
output                         [3:0] mst14_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm14_slv6_hwdata;
output                  [DATA_MSB:0] mst14_hs6_hrdata;
output                               mst14_hs6_hready;
output                         [1:0] mst14_hs6_hresp;
input                                mst14_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv6_base;
output                               mst14_slv6_grant;
output                  [ADDR_MSB:0] mst14_slv6_haddr;
output                         [2:0] mst14_slv6_hburst;
output                         [3:0] mst14_slv6_hprot;
output                         [2:0] mst14_slv6_hsize;
output                         [1:0] mst14_slv6_htrans;
output                               mst14_slv6_hwrite;
output                               mst14_slv6_req;
input                                mst14_slv6_sel;
output                         [3:0] mst14_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm14_slv7_hwdata;
output                  [DATA_MSB:0] mst14_hs7_hrdata;
output                               mst14_hs7_hready;
output                         [1:0] mst14_hs7_hresp;
input                                mst14_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv7_base;
output                               mst14_slv7_grant;
output                  [ADDR_MSB:0] mst14_slv7_haddr;
output                         [2:0] mst14_slv7_hburst;
output                         [3:0] mst14_slv7_hprot;
output                         [2:0] mst14_slv7_hsize;
output                         [1:0] mst14_slv7_htrans;
output                               mst14_slv7_hwrite;
output                               mst14_slv7_req;
input                                mst14_slv7_sel;
output                         [3:0] mst14_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm14_slv8_hwdata;
output                  [DATA_MSB:0] mst14_hs8_hrdata;
output                               mst14_hs8_hready;
output                         [1:0] mst14_hs8_hresp;
input                                mst14_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv8_base;
output                               mst14_slv8_grant;
output                  [ADDR_MSB:0] mst14_slv8_haddr;
output                         [2:0] mst14_slv8_hburst;
output                         [3:0] mst14_slv8_hprot;
output                         [2:0] mst14_slv8_hsize;
output                         [1:0] mst14_slv8_htrans;
output                               mst14_slv8_hwrite;
output                               mst14_slv8_req;
input                                mst14_slv8_sel;
output                         [3:0] mst14_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm14_slv9_hwdata;
output                  [DATA_MSB:0] mst14_hs9_hrdata;
output                               mst14_hs9_hready;
output                         [1:0] mst14_hs9_hresp;
input                                mst14_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv9_base;
output                               mst14_slv9_grant;
output                  [ADDR_MSB:0] mst14_slv9_haddr;
output                         [2:0] mst14_slv9_hburst;
output                         [3:0] mst14_slv9_hprot;
output                         [2:0] mst14_slv9_hsize;
output                         [1:0] mst14_slv9_htrans;
output                               mst14_slv9_hwrite;
output                               mst14_slv9_req;
input                                mst14_slv9_sel;
output                         [3:0] mst14_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm14_slv10_hwdata;
output                  [DATA_MSB:0] mst14_hs10_hrdata;
output                               mst14_hs10_hready;
output                         [1:0] mst14_hs10_hresp;
input                                mst14_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv10_base;
output                               mst14_slv10_grant;
output                  [ADDR_MSB:0] mst14_slv10_haddr;
output                         [2:0] mst14_slv10_hburst;
output                         [3:0] mst14_slv10_hprot;
output                         [2:0] mst14_slv10_hsize;
output                         [1:0] mst14_slv10_htrans;
output                               mst14_slv10_hwrite;
output                               mst14_slv10_req;
input                                mst14_slv10_sel;
output                         [3:0] mst14_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm14_slv11_hwdata;
output                  [DATA_MSB:0] mst14_hs11_hrdata;
output                               mst14_hs11_hready;
output                         [1:0] mst14_hs11_hresp;
input                                mst14_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv11_base;
output                               mst14_slv11_grant;
output                  [ADDR_MSB:0] mst14_slv11_haddr;
output                         [2:0] mst14_slv11_hburst;
output                         [3:0] mst14_slv11_hprot;
output                         [2:0] mst14_slv11_hsize;
output                         [1:0] mst14_slv11_htrans;
output                               mst14_slv11_hwrite;
output                               mst14_slv11_req;
input                                mst14_slv11_sel;
output                         [3:0] mst14_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm14_slv12_hwdata;
output                  [DATA_MSB:0] mst14_hs12_hrdata;
output                               mst14_hs12_hready;
output                         [1:0] mst14_hs12_hresp;
input                                mst14_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv12_base;
output                               mst14_slv12_grant;
output                  [ADDR_MSB:0] mst14_slv12_haddr;
output                         [2:0] mst14_slv12_hburst;
output                         [3:0] mst14_slv12_hprot;
output                         [2:0] mst14_slv12_hsize;
output                         [1:0] mst14_slv12_htrans;
output                               mst14_slv12_hwrite;
output                               mst14_slv12_req;
input                                mst14_slv12_sel;
output                         [3:0] mst14_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm14_slv13_hwdata;
output                  [DATA_MSB:0] mst14_hs13_hrdata;
output                               mst14_hs13_hready;
output                         [1:0] mst14_hs13_hresp;
input                                mst14_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv13_base;
output                               mst14_slv13_grant;
output                  [ADDR_MSB:0] mst14_slv13_haddr;
output                         [2:0] mst14_slv13_hburst;
output                         [3:0] mst14_slv13_hprot;
output                         [2:0] mst14_slv13_hsize;
output                         [1:0] mst14_slv13_htrans;
output                               mst14_slv13_hwrite;
output                               mst14_slv13_req;
input                                mst14_slv13_sel;
output                         [3:0] mst14_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm14_slv14_hwdata;
output                  [DATA_MSB:0] mst14_hs14_hrdata;
output                               mst14_hs14_hready;
output                         [1:0] mst14_hs14_hresp;
input                                mst14_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv14_base;
output                               mst14_slv14_grant;
output                  [ADDR_MSB:0] mst14_slv14_haddr;
output                         [2:0] mst14_slv14_hburst;
output                         [3:0] mst14_slv14_hprot;
output                         [2:0] mst14_slv14_hsize;
output                         [1:0] mst14_slv14_htrans;
output                               mst14_slv14_hwrite;
output                               mst14_slv14_req;
input                                mst14_slv14_sel;
output                         [3:0] mst14_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm14_slv15_hwdata;
output                  [DATA_MSB:0] mst14_hs15_hrdata;
output                               mst14_hs15_hready;
output                         [1:0] mst14_hs15_hresp;
input                                mst14_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst14_slv15_base;
output                               mst14_slv15_grant;
output                  [ADDR_MSB:0] mst14_slv15_haddr;
output                         [2:0] mst14_slv15_hburst;
output                         [3:0] mst14_slv15_hprot;
output                         [2:0] mst14_slv15_hsize;
output                         [1:0] mst14_slv15_htrans;
output                               mst14_slv15_hwrite;
output                               mst14_slv15_req;
input                                mst14_slv15_sel;
output                         [3:0] mst14_slv15_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_SLV0
   `ifdef ATCBMC200_AHB_MST15
output                  [DATA_MSB:0] hm15_slv0_hwdata;
output                  [DATA_MSB:0] mst15_hs0_hrdata;
output                               mst15_hs0_hready;
output                         [1:0] mst15_hs0_hresp;
input                                mst15_slv0_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv0_base;
output                               mst15_slv0_grant;
output                  [ADDR_MSB:0] mst15_slv0_haddr;
output                         [2:0] mst15_slv0_hburst;
output                         [3:0] mst15_slv0_hprot;
output                         [2:0] mst15_slv0_hsize;
output                         [1:0] mst15_slv0_htrans;
output                               mst15_slv0_hwrite;
output                               mst15_slv0_req;
input                                mst15_slv0_sel;
output                         [3:0] mst15_slv0_size;
   `endif
`endif
`ifdef ATCBMC200_AHB_MST15
   `ifdef ATCBMC200_AHB_SLV1
output                  [DATA_MSB:0] hm15_slv1_hwdata;
output                  [DATA_MSB:0] mst15_hs1_hrdata;
output                               mst15_hs1_hready;
output                         [1:0] mst15_hs1_hresp;
input                                mst15_slv1_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv1_base;
output                               mst15_slv1_grant;
output                  [ADDR_MSB:0] mst15_slv1_haddr;
output                         [2:0] mst15_slv1_hburst;
output                         [3:0] mst15_slv1_hprot;
output                         [2:0] mst15_slv1_hsize;
output                         [1:0] mst15_slv1_htrans;
output                               mst15_slv1_hwrite;
output                               mst15_slv1_req;
input                                mst15_slv1_sel;
output                         [3:0] mst15_slv1_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV2
output                  [DATA_MSB:0] hm15_slv2_hwdata;
output                  [DATA_MSB:0] mst15_hs2_hrdata;
output                               mst15_hs2_hready;
output                         [1:0] mst15_hs2_hresp;
input                                mst15_slv2_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv2_base;
output                               mst15_slv2_grant;
output                  [ADDR_MSB:0] mst15_slv2_haddr;
output                         [2:0] mst15_slv2_hburst;
output                         [3:0] mst15_slv2_hprot;
output                         [2:0] mst15_slv2_hsize;
output                         [1:0] mst15_slv2_htrans;
output                               mst15_slv2_hwrite;
output                               mst15_slv2_req;
input                                mst15_slv2_sel;
output                         [3:0] mst15_slv2_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV3
output                  [DATA_MSB:0] hm15_slv3_hwdata;
output                  [DATA_MSB:0] mst15_hs3_hrdata;
output                               mst15_hs3_hready;
output                         [1:0] mst15_hs3_hresp;
input                                mst15_slv3_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv3_base;
output                               mst15_slv3_grant;
output                  [ADDR_MSB:0] mst15_slv3_haddr;
output                         [2:0] mst15_slv3_hburst;
output                         [3:0] mst15_slv3_hprot;
output                         [2:0] mst15_slv3_hsize;
output                         [1:0] mst15_slv3_htrans;
output                               mst15_slv3_hwrite;
output                               mst15_slv3_req;
input                                mst15_slv3_sel;
output                         [3:0] mst15_slv3_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV4
output                  [DATA_MSB:0] hm15_slv4_hwdata;
output                  [DATA_MSB:0] mst15_hs4_hrdata;
output                               mst15_hs4_hready;
output                         [1:0] mst15_hs4_hresp;
input                                mst15_slv4_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv4_base;
output                               mst15_slv4_grant;
output                  [ADDR_MSB:0] mst15_slv4_haddr;
output                         [2:0] mst15_slv4_hburst;
output                         [3:0] mst15_slv4_hprot;
output                         [2:0] mst15_slv4_hsize;
output                         [1:0] mst15_slv4_htrans;
output                               mst15_slv4_hwrite;
output                               mst15_slv4_req;
input                                mst15_slv4_sel;
output                         [3:0] mst15_slv4_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV5
output                  [DATA_MSB:0] hm15_slv5_hwdata;
output                  [DATA_MSB:0] mst15_hs5_hrdata;
output                               mst15_hs5_hready;
output                         [1:0] mst15_hs5_hresp;
input                                mst15_slv5_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv5_base;
output                               mst15_slv5_grant;
output                  [ADDR_MSB:0] mst15_slv5_haddr;
output                         [2:0] mst15_slv5_hburst;
output                         [3:0] mst15_slv5_hprot;
output                         [2:0] mst15_slv5_hsize;
output                         [1:0] mst15_slv5_htrans;
output                               mst15_slv5_hwrite;
output                               mst15_slv5_req;
input                                mst15_slv5_sel;
output                         [3:0] mst15_slv5_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV6
output                  [DATA_MSB:0] hm15_slv6_hwdata;
output                  [DATA_MSB:0] mst15_hs6_hrdata;
output                               mst15_hs6_hready;
output                         [1:0] mst15_hs6_hresp;
input                                mst15_slv6_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv6_base;
output                               mst15_slv6_grant;
output                  [ADDR_MSB:0] mst15_slv6_haddr;
output                         [2:0] mst15_slv6_hburst;
output                         [3:0] mst15_slv6_hprot;
output                         [2:0] mst15_slv6_hsize;
output                         [1:0] mst15_slv6_htrans;
output                               mst15_slv6_hwrite;
output                               mst15_slv6_req;
input                                mst15_slv6_sel;
output                         [3:0] mst15_slv6_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV7
output                  [DATA_MSB:0] hm15_slv7_hwdata;
output                  [DATA_MSB:0] mst15_hs7_hrdata;
output                               mst15_hs7_hready;
output                         [1:0] mst15_hs7_hresp;
input                                mst15_slv7_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv7_base;
output                               mst15_slv7_grant;
output                  [ADDR_MSB:0] mst15_slv7_haddr;
output                         [2:0] mst15_slv7_hburst;
output                         [3:0] mst15_slv7_hprot;
output                         [2:0] mst15_slv7_hsize;
output                         [1:0] mst15_slv7_htrans;
output                               mst15_slv7_hwrite;
output                               mst15_slv7_req;
input                                mst15_slv7_sel;
output                         [3:0] mst15_slv7_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV8
output                  [DATA_MSB:0] hm15_slv8_hwdata;
output                  [DATA_MSB:0] mst15_hs8_hrdata;
output                               mst15_hs8_hready;
output                         [1:0] mst15_hs8_hresp;
input                                mst15_slv8_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv8_base;
output                               mst15_slv8_grant;
output                  [ADDR_MSB:0] mst15_slv8_haddr;
output                         [2:0] mst15_slv8_hburst;
output                         [3:0] mst15_slv8_hprot;
output                         [2:0] mst15_slv8_hsize;
output                         [1:0] mst15_slv8_htrans;
output                               mst15_slv8_hwrite;
output                               mst15_slv8_req;
input                                mst15_slv8_sel;
output                         [3:0] mst15_slv8_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV9
output                  [DATA_MSB:0] hm15_slv9_hwdata;
output                  [DATA_MSB:0] mst15_hs9_hrdata;
output                               mst15_hs9_hready;
output                         [1:0] mst15_hs9_hresp;
input                                mst15_slv9_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv9_base;
output                               mst15_slv9_grant;
output                  [ADDR_MSB:0] mst15_slv9_haddr;
output                         [2:0] mst15_slv9_hburst;
output                         [3:0] mst15_slv9_hprot;
output                         [2:0] mst15_slv9_hsize;
output                         [1:0] mst15_slv9_htrans;
output                               mst15_slv9_hwrite;
output                               mst15_slv9_req;
input                                mst15_slv9_sel;
output                         [3:0] mst15_slv9_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV10
output                  [DATA_MSB:0] hm15_slv10_hwdata;
output                  [DATA_MSB:0] mst15_hs10_hrdata;
output                               mst15_hs10_hready;
output                         [1:0] mst15_hs10_hresp;
input                                mst15_slv10_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv10_base;
output                               mst15_slv10_grant;
output                  [ADDR_MSB:0] mst15_slv10_haddr;
output                         [2:0] mst15_slv10_hburst;
output                         [3:0] mst15_slv10_hprot;
output                         [2:0] mst15_slv10_hsize;
output                         [1:0] mst15_slv10_htrans;
output                               mst15_slv10_hwrite;
output                               mst15_slv10_req;
input                                mst15_slv10_sel;
output                         [3:0] mst15_slv10_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV11
output                  [DATA_MSB:0] hm15_slv11_hwdata;
output                  [DATA_MSB:0] mst15_hs11_hrdata;
output                               mst15_hs11_hready;
output                         [1:0] mst15_hs11_hresp;
input                                mst15_slv11_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv11_base;
output                               mst15_slv11_grant;
output                  [ADDR_MSB:0] mst15_slv11_haddr;
output                         [2:0] mst15_slv11_hburst;
output                         [3:0] mst15_slv11_hprot;
output                         [2:0] mst15_slv11_hsize;
output                         [1:0] mst15_slv11_htrans;
output                               mst15_slv11_hwrite;
output                               mst15_slv11_req;
input                                mst15_slv11_sel;
output                         [3:0] mst15_slv11_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV12
output                  [DATA_MSB:0] hm15_slv12_hwdata;
output                  [DATA_MSB:0] mst15_hs12_hrdata;
output                               mst15_hs12_hready;
output                         [1:0] mst15_hs12_hresp;
input                                mst15_slv12_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv12_base;
output                               mst15_slv12_grant;
output                  [ADDR_MSB:0] mst15_slv12_haddr;
output                         [2:0] mst15_slv12_hburst;
output                         [3:0] mst15_slv12_hprot;
output                         [2:0] mst15_slv12_hsize;
output                         [1:0] mst15_slv12_htrans;
output                               mst15_slv12_hwrite;
output                               mst15_slv12_req;
input                                mst15_slv12_sel;
output                         [3:0] mst15_slv12_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV13
output                  [DATA_MSB:0] hm15_slv13_hwdata;
output                  [DATA_MSB:0] mst15_hs13_hrdata;
output                               mst15_hs13_hready;
output                         [1:0] mst15_hs13_hresp;
input                                mst15_slv13_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv13_base;
output                               mst15_slv13_grant;
output                  [ADDR_MSB:0] mst15_slv13_haddr;
output                         [2:0] mst15_slv13_hburst;
output                         [3:0] mst15_slv13_hprot;
output                         [2:0] mst15_slv13_hsize;
output                         [1:0] mst15_slv13_htrans;
output                               mst15_slv13_hwrite;
output                               mst15_slv13_req;
input                                mst15_slv13_sel;
output                         [3:0] mst15_slv13_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV14
output                  [DATA_MSB:0] hm15_slv14_hwdata;
output                  [DATA_MSB:0] mst15_hs14_hrdata;
output                               mst15_hs14_hready;
output                         [1:0] mst15_hs14_hresp;
input                                mst15_slv14_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv14_base;
output                               mst15_slv14_grant;
output                  [ADDR_MSB:0] mst15_slv14_haddr;
output                         [2:0] mst15_slv14_hburst;
output                         [3:0] mst15_slv14_hprot;
output                         [2:0] mst15_slv14_hsize;
output                         [1:0] mst15_slv14_htrans;
output                               mst15_slv14_hwrite;
output                               mst15_slv14_req;
input                                mst15_slv14_sel;
output                         [3:0] mst15_slv14_size;
   `endif
   `ifdef ATCBMC200_AHB_SLV15
output                  [DATA_MSB:0] hm15_slv15_hwdata;
output                  [DATA_MSB:0] mst15_hs15_hrdata;
output                               mst15_hs15_hready;
output                         [1:0] mst15_hs15_hresp;
input                                mst15_slv15_ack;
output      [ADDR_MSB:BASE_ADDR_LSB] mst15_slv15_base;
output                               mst15_slv15_grant;
output                  [ADDR_MSB:0] mst15_slv15_haddr;
output                         [2:0] mst15_slv15_hburst;
output                         [3:0] mst15_slv15_hprot;
output                         [2:0] mst15_slv15_hsize;
output                         [1:0] mst15_slv15_htrans;
output                               mst15_slv15_hwrite;
output                               mst15_slv15_req;
input                                mst15_slv15_sel;
output                         [3:0] mst15_slv15_size;
   `endif
`endif
input                   [DATA_MSB:0] hs0_hrdata;
input                                hs0_hready;
input                          [1:0] hs0_hresp;
input       [ADDR_MSB:BASE_ADDR_LSB] slv0_base;
input                          [3:0] slv0_size;


`ifdef ATCBMC200_AHB_SLV0
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S0) begin : gen_m0s0
  assign mst0_hs0_hrdata  = hs0_hrdata;
  assign mst0_hs0_hready  = hs0_hready;
  assign mst0_hs0_hresp   = hs0_hresp;
  assign mst0_slv0_base   = slv0_base;
  assign mst0_slv0_size   = slv0_size;
  assign mst0_slv0_grant  = mst0_slv0_ack;
  assign hm0_slv0_hwdata  = hm0_hwdata;
  assign mst0_slv0_haddr  = mst0_haddr;
  assign mst0_slv0_hburst = mst0_hburst;
  assign mst0_slv0_hprot  = mst0_hprot;
  assign mst0_slv0_hsize  = mst0_hsize;
  assign mst0_slv0_htrans = mst0_htrans;
  assign mst0_slv0_hwrite = mst0_hwrite;
  assign mst0_slv0_req    = mst0_slv0_sel;
end
else begin : gen_m0s0_nonexistent
     assign mst0_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs0_hready  = 1'b0;
     assign mst0_hs0_hresp   = 2'h0;
     assign mst0_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv0_size   = 4'h0;
     assign mst0_slv0_grant  = 1'b0;
     assign hm0_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv0_hburst = 3'h0;
     assign mst0_slv0_hprot  = 4'h0;
     assign mst0_slv0_hsize  = 3'h0;
     assign mst0_slv0_htrans = 2'h0;
     assign mst0_slv0_hwrite = 1'b0;
     assign mst0_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S0) begin : gen_m1s0
  assign mst1_hs0_hrdata  = hs0_hrdata;
  assign mst1_hs0_hready  = hs0_hready;
  assign mst1_hs0_hresp   = hs0_hresp;
  assign mst1_slv0_base   = slv0_base;
  assign mst1_slv0_size   = slv0_size;
  assign mst1_slv0_grant  = mst1_slv0_ack;
  assign hm1_slv0_hwdata  = hm1_hwdata;
  assign mst1_slv0_haddr  = mst1_haddr;
  assign mst1_slv0_hburst = mst1_hburst;
  assign mst1_slv0_hprot  = mst1_hprot;
  assign mst1_slv0_hsize  = mst1_hsize;
  assign mst1_slv0_htrans = mst1_htrans;
  assign mst1_slv0_hwrite = mst1_hwrite;
  assign mst1_slv0_req    = mst1_slv0_sel;
end
else begin : gen_m1s0_nonexistent
     assign mst1_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs0_hready  = 1'b0;
     assign mst1_hs0_hresp   = 2'h0;
     assign mst1_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv0_size   = 4'h0;
     assign mst1_slv0_grant  = 1'b0;
     assign hm1_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv0_hburst = 3'h0;
     assign mst1_slv0_hprot  = 4'h0;
     assign mst1_slv0_hsize  = 3'h0;
     assign mst1_slv0_htrans = 2'h0;
     assign mst1_slv0_hwrite = 1'b0;
     assign mst1_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S0) begin : gen_m2s0
  assign mst2_hs0_hrdata  = hs0_hrdata;
  assign mst2_hs0_hready  = hs0_hready;
  assign mst2_hs0_hresp   = hs0_hresp;
  assign mst2_slv0_base   = slv0_base;
  assign mst2_slv0_size   = slv0_size;
  assign mst2_slv0_grant  = mst2_slv0_ack;
  assign hm2_slv0_hwdata  = hm2_hwdata;
  assign mst2_slv0_haddr  = mst2_haddr;
  assign mst2_slv0_hburst = mst2_hburst;
  assign mst2_slv0_hprot  = mst2_hprot;
  assign mst2_slv0_hsize  = mst2_hsize;
  assign mst2_slv0_htrans = mst2_htrans;
  assign mst2_slv0_hwrite = mst2_hwrite;
  assign mst2_slv0_req    = mst2_slv0_sel;
end
else begin : gen_m2s0_nonexistent
     assign mst2_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs0_hready  = 1'b0;
     assign mst2_hs0_hresp   = 2'h0;
     assign mst2_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv0_size   = 4'h0;
     assign mst2_slv0_grant  = 1'b0;
     assign hm2_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv0_hburst = 3'h0;
     assign mst2_slv0_hprot  = 4'h0;
     assign mst2_slv0_hsize  = 3'h0;
     assign mst2_slv0_htrans = 2'h0;
     assign mst2_slv0_hwrite = 1'b0;
     assign mst2_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S0) begin : gen_m3s0
  assign mst3_hs0_hrdata  = hs0_hrdata;
  assign mst3_hs0_hready  = hs0_hready;
  assign mst3_hs0_hresp   = hs0_hresp;
  assign mst3_slv0_base   = slv0_base;
  assign mst3_slv0_size   = slv0_size;
  assign mst3_slv0_grant  = mst3_slv0_ack;
  assign hm3_slv0_hwdata  = hm3_hwdata;
  assign mst3_slv0_haddr  = mst3_haddr;
  assign mst3_slv0_hburst = mst3_hburst;
  assign mst3_slv0_hprot  = mst3_hprot;
  assign mst3_slv0_hsize  = mst3_hsize;
  assign mst3_slv0_htrans = mst3_htrans;
  assign mst3_slv0_hwrite = mst3_hwrite;
  assign mst3_slv0_req    = mst3_slv0_sel;
end
else begin : gen_m3s0_nonexistent
     assign mst3_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs0_hready  = 1'b0;
     assign mst3_hs0_hresp   = 2'h0;
     assign mst3_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv0_size   = 4'h0;
     assign mst3_slv0_grant  = 1'b0;
     assign hm3_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv0_hburst = 3'h0;
     assign mst3_slv0_hprot  = 4'h0;
     assign mst3_slv0_hsize  = 3'h0;
     assign mst3_slv0_htrans = 2'h0;
     assign mst3_slv0_hwrite = 1'b0;
     assign mst3_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S0) begin : gen_m4s0
  assign mst4_hs0_hrdata  = hs0_hrdata;
  assign mst4_hs0_hready  = hs0_hready;
  assign mst4_hs0_hresp   = hs0_hresp;
  assign mst4_slv0_base   = slv0_base;
  assign mst4_slv0_size   = slv0_size;
  assign mst4_slv0_grant  = mst4_slv0_ack;
  assign hm4_slv0_hwdata  = hm4_hwdata;
  assign mst4_slv0_haddr  = mst4_haddr;
  assign mst4_slv0_hburst = mst4_hburst;
  assign mst4_slv0_hprot  = mst4_hprot;
  assign mst4_slv0_hsize  = mst4_hsize;
  assign mst4_slv0_htrans = mst4_htrans;
  assign mst4_slv0_hwrite = mst4_hwrite;
  assign mst4_slv0_req    = mst4_slv0_sel;
end
else begin : gen_m4s0_nonexistent
     assign mst4_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs0_hready  = 1'b0;
     assign mst4_hs0_hresp   = 2'h0;
     assign mst4_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv0_size   = 4'h0;
     assign mst4_slv0_grant  = 1'b0;
     assign hm4_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv0_hburst = 3'h0;
     assign mst4_slv0_hprot  = 4'h0;
     assign mst4_slv0_hsize  = 3'h0;
     assign mst4_slv0_htrans = 2'h0;
     assign mst4_slv0_hwrite = 1'b0;
     assign mst4_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S0) begin : gen_m5s0
  assign mst5_hs0_hrdata  = hs0_hrdata;
  assign mst5_hs0_hready  = hs0_hready;
  assign mst5_hs0_hresp   = hs0_hresp;
  assign mst5_slv0_base   = slv0_base;
  assign mst5_slv0_size   = slv0_size;
  assign mst5_slv0_grant  = mst5_slv0_ack;
  assign hm5_slv0_hwdata  = hm5_hwdata;
  assign mst5_slv0_haddr  = mst5_haddr;
  assign mst5_slv0_hburst = mst5_hburst;
  assign mst5_slv0_hprot  = mst5_hprot;
  assign mst5_slv0_hsize  = mst5_hsize;
  assign mst5_slv0_htrans = mst5_htrans;
  assign mst5_slv0_hwrite = mst5_hwrite;
  assign mst5_slv0_req    = mst5_slv0_sel;
end
else begin : gen_m5s0_nonexistent
     assign mst5_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs0_hready  = 1'b0;
     assign mst5_hs0_hresp   = 2'h0;
     assign mst5_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv0_size   = 4'h0;
     assign mst5_slv0_grant  = 1'b0;
     assign hm5_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv0_hburst = 3'h0;
     assign mst5_slv0_hprot  = 4'h0;
     assign mst5_slv0_hsize  = 3'h0;
     assign mst5_slv0_htrans = 2'h0;
     assign mst5_slv0_hwrite = 1'b0;
     assign mst5_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S0) begin : gen_m6s0
  assign mst6_hs0_hrdata  = hs0_hrdata;
  assign mst6_hs0_hready  = hs0_hready;
  assign mst6_hs0_hresp   = hs0_hresp;
  assign mst6_slv0_base   = slv0_base;
  assign mst6_slv0_size   = slv0_size;
  assign mst6_slv0_grant  = mst6_slv0_ack;
  assign hm6_slv0_hwdata  = hm6_hwdata;
  assign mst6_slv0_haddr  = mst6_haddr;
  assign mst6_slv0_hburst = mst6_hburst;
  assign mst6_slv0_hprot  = mst6_hprot;
  assign mst6_slv0_hsize  = mst6_hsize;
  assign mst6_slv0_htrans = mst6_htrans;
  assign mst6_slv0_hwrite = mst6_hwrite;
  assign mst6_slv0_req    = mst6_slv0_sel;
end
else begin : gen_m6s0_nonexistent
     assign mst6_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs0_hready  = 1'b0;
     assign mst6_hs0_hresp   = 2'h0;
     assign mst6_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv0_size   = 4'h0;
     assign mst6_slv0_grant  = 1'b0;
     assign hm6_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv0_hburst = 3'h0;
     assign mst6_slv0_hprot  = 4'h0;
     assign mst6_slv0_hsize  = 3'h0;
     assign mst6_slv0_htrans = 2'h0;
     assign mst6_slv0_hwrite = 1'b0;
     assign mst6_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S0) begin : gen_m7s0
  assign mst7_hs0_hrdata  = hs0_hrdata;
  assign mst7_hs0_hready  = hs0_hready;
  assign mst7_hs0_hresp   = hs0_hresp;
  assign mst7_slv0_base   = slv0_base;
  assign mst7_slv0_size   = slv0_size;
  assign mst7_slv0_grant  = mst7_slv0_ack;
  assign hm7_slv0_hwdata  = hm7_hwdata;
  assign mst7_slv0_haddr  = mst7_haddr;
  assign mst7_slv0_hburst = mst7_hburst;
  assign mst7_slv0_hprot  = mst7_hprot;
  assign mst7_slv0_hsize  = mst7_hsize;
  assign mst7_slv0_htrans = mst7_htrans;
  assign mst7_slv0_hwrite = mst7_hwrite;
  assign mst7_slv0_req    = mst7_slv0_sel;
end
else begin : gen_m7s0_nonexistent
     assign mst7_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs0_hready  = 1'b0;
     assign mst7_hs0_hresp   = 2'h0;
     assign mst7_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv0_size   = 4'h0;
     assign mst7_slv0_grant  = 1'b0;
     assign hm7_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv0_hburst = 3'h0;
     assign mst7_slv0_hprot  = 4'h0;
     assign mst7_slv0_hsize  = 3'h0;
     assign mst7_slv0_htrans = 2'h0;
     assign mst7_slv0_hwrite = 1'b0;
     assign mst7_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S0) begin : gen_m8s0
  assign mst8_hs0_hrdata  = hs0_hrdata;
  assign mst8_hs0_hready  = hs0_hready;
  assign mst8_hs0_hresp   = hs0_hresp;
  assign mst8_slv0_base   = slv0_base;
  assign mst8_slv0_size   = slv0_size;
  assign mst8_slv0_grant  = mst8_slv0_ack;
  assign hm8_slv0_hwdata  = hm8_hwdata;
  assign mst8_slv0_haddr  = mst8_haddr;
  assign mst8_slv0_hburst = mst8_hburst;
  assign mst8_slv0_hprot  = mst8_hprot;
  assign mst8_slv0_hsize  = mst8_hsize;
  assign mst8_slv0_htrans = mst8_htrans;
  assign mst8_slv0_hwrite = mst8_hwrite;
  assign mst8_slv0_req    = mst8_slv0_sel;
end
else begin : gen_m8s0_nonexistent
     assign mst8_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs0_hready  = 1'b0;
     assign mst8_hs0_hresp   = 2'h0;
     assign mst8_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv0_size   = 4'h0;
     assign mst8_slv0_grant  = 1'b0;
     assign hm8_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv0_hburst = 3'h0;
     assign mst8_slv0_hprot  = 4'h0;
     assign mst8_slv0_hsize  = 3'h0;
     assign mst8_slv0_htrans = 2'h0;
     assign mst8_slv0_hwrite = 1'b0;
     assign mst8_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S0) begin : gen_m9s0
  assign mst9_hs0_hrdata  = hs0_hrdata;
  assign mst9_hs0_hready  = hs0_hready;
  assign mst9_hs0_hresp   = hs0_hresp;
  assign mst9_slv0_base   = slv0_base;
  assign mst9_slv0_size   = slv0_size;
  assign mst9_slv0_grant  = mst9_slv0_ack;
  assign hm9_slv0_hwdata  = hm9_hwdata;
  assign mst9_slv0_haddr  = mst9_haddr;
  assign mst9_slv0_hburst = mst9_hburst;
  assign mst9_slv0_hprot  = mst9_hprot;
  assign mst9_slv0_hsize  = mst9_hsize;
  assign mst9_slv0_htrans = mst9_htrans;
  assign mst9_slv0_hwrite = mst9_hwrite;
  assign mst9_slv0_req    = mst9_slv0_sel;
end
else begin : gen_m9s0_nonexistent
     assign mst9_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs0_hready  = 1'b0;
     assign mst9_hs0_hresp   = 2'h0;
     assign mst9_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv0_size   = 4'h0;
     assign mst9_slv0_grant  = 1'b0;
     assign hm9_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv0_hburst = 3'h0;
     assign mst9_slv0_hprot  = 4'h0;
     assign mst9_slv0_hsize  = 3'h0;
     assign mst9_slv0_htrans = 2'h0;
     assign mst9_slv0_hwrite = 1'b0;
     assign mst9_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S0) begin : gen_m10s0
  assign mst10_hs0_hrdata  = hs0_hrdata;
  assign mst10_hs0_hready  = hs0_hready;
  assign mst10_hs0_hresp   = hs0_hresp;
  assign mst10_slv0_base   = slv0_base;
  assign mst10_slv0_size   = slv0_size;
  assign mst10_slv0_grant  = mst10_slv0_ack;
  assign hm10_slv0_hwdata  = hm10_hwdata;
  assign mst10_slv0_haddr  = mst10_haddr;
  assign mst10_slv0_hburst = mst10_hburst;
  assign mst10_slv0_hprot  = mst10_hprot;
  assign mst10_slv0_hsize  = mst10_hsize;
  assign mst10_slv0_htrans = mst10_htrans;
  assign mst10_slv0_hwrite = mst10_hwrite;
  assign mst10_slv0_req    = mst10_slv0_sel;
end
else begin : gen_m10s0_nonexistent
     assign mst10_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs0_hready  = 1'b0;
     assign mst10_hs0_hresp   = 2'h0;
     assign mst10_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv0_size   = 4'h0;
     assign mst10_slv0_grant  = 1'b0;
     assign hm10_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv0_hburst = 3'h0;
     assign mst10_slv0_hprot  = 4'h0;
     assign mst10_slv0_hsize  = 3'h0;
     assign mst10_slv0_htrans = 2'h0;
     assign mst10_slv0_hwrite = 1'b0;
     assign mst10_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S0) begin : gen_m11s0
  assign mst11_hs0_hrdata  = hs0_hrdata;
  assign mst11_hs0_hready  = hs0_hready;
  assign mst11_hs0_hresp   = hs0_hresp;
  assign mst11_slv0_base   = slv0_base;
  assign mst11_slv0_size   = slv0_size;
  assign mst11_slv0_grant  = mst11_slv0_ack;
  assign hm11_slv0_hwdata  = hm11_hwdata;
  assign mst11_slv0_haddr  = mst11_haddr;
  assign mst11_slv0_hburst = mst11_hburst;
  assign mst11_slv0_hprot  = mst11_hprot;
  assign mst11_slv0_hsize  = mst11_hsize;
  assign mst11_slv0_htrans = mst11_htrans;
  assign mst11_slv0_hwrite = mst11_hwrite;
  assign mst11_slv0_req    = mst11_slv0_sel;
end
else begin : gen_m11s0_nonexistent
     assign mst11_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs0_hready  = 1'b0;
     assign mst11_hs0_hresp   = 2'h0;
     assign mst11_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv0_size   = 4'h0;
     assign mst11_slv0_grant  = 1'b0;
     assign hm11_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv0_hburst = 3'h0;
     assign mst11_slv0_hprot  = 4'h0;
     assign mst11_slv0_hsize  = 3'h0;
     assign mst11_slv0_htrans = 2'h0;
     assign mst11_slv0_hwrite = 1'b0;
     assign mst11_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S0) begin : gen_m12s0
  assign mst12_hs0_hrdata  = hs0_hrdata;
  assign mst12_hs0_hready  = hs0_hready;
  assign mst12_hs0_hresp   = hs0_hresp;
  assign mst12_slv0_base   = slv0_base;
  assign mst12_slv0_size   = slv0_size;
  assign mst12_slv0_grant  = mst12_slv0_ack;
  assign hm12_slv0_hwdata  = hm12_hwdata;
  assign mst12_slv0_haddr  = mst12_haddr;
  assign mst12_slv0_hburst = mst12_hburst;
  assign mst12_slv0_hprot  = mst12_hprot;
  assign mst12_slv0_hsize  = mst12_hsize;
  assign mst12_slv0_htrans = mst12_htrans;
  assign mst12_slv0_hwrite = mst12_hwrite;
  assign mst12_slv0_req    = mst12_slv0_sel;
end
else begin : gen_m12s0_nonexistent
     assign mst12_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs0_hready  = 1'b0;
     assign mst12_hs0_hresp   = 2'h0;
     assign mst12_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv0_size   = 4'h0;
     assign mst12_slv0_grant  = 1'b0;
     assign hm12_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv0_hburst = 3'h0;
     assign mst12_slv0_hprot  = 4'h0;
     assign mst12_slv0_hsize  = 3'h0;
     assign mst12_slv0_htrans = 2'h0;
     assign mst12_slv0_hwrite = 1'b0;
     assign mst12_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S0) begin : gen_m13s0
  assign mst13_hs0_hrdata  = hs0_hrdata;
  assign mst13_hs0_hready  = hs0_hready;
  assign mst13_hs0_hresp   = hs0_hresp;
  assign mst13_slv0_base   = slv0_base;
  assign mst13_slv0_size   = slv0_size;
  assign mst13_slv0_grant  = mst13_slv0_ack;
  assign hm13_slv0_hwdata  = hm13_hwdata;
  assign mst13_slv0_haddr  = mst13_haddr;
  assign mst13_slv0_hburst = mst13_hburst;
  assign mst13_slv0_hprot  = mst13_hprot;
  assign mst13_slv0_hsize  = mst13_hsize;
  assign mst13_slv0_htrans = mst13_htrans;
  assign mst13_slv0_hwrite = mst13_hwrite;
  assign mst13_slv0_req    = mst13_slv0_sel;
end
else begin : gen_m13s0_nonexistent
     assign mst13_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs0_hready  = 1'b0;
     assign mst13_hs0_hresp   = 2'h0;
     assign mst13_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv0_size   = 4'h0;
     assign mst13_slv0_grant  = 1'b0;
     assign hm13_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv0_hburst = 3'h0;
     assign mst13_slv0_hprot  = 4'h0;
     assign mst13_slv0_hsize  = 3'h0;
     assign mst13_slv0_htrans = 2'h0;
     assign mst13_slv0_hwrite = 1'b0;
     assign mst13_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S0) begin : gen_m14s0
  assign mst14_hs0_hrdata  = hs0_hrdata;
  assign mst14_hs0_hready  = hs0_hready;
  assign mst14_hs0_hresp   = hs0_hresp;
  assign mst14_slv0_base   = slv0_base;
  assign mst14_slv0_size   = slv0_size;
  assign mst14_slv0_grant  = mst14_slv0_ack;
  assign hm14_slv0_hwdata  = hm14_hwdata;
  assign mst14_slv0_haddr  = mst14_haddr;
  assign mst14_slv0_hburst = mst14_hburst;
  assign mst14_slv0_hprot  = mst14_hprot;
  assign mst14_slv0_hsize  = mst14_hsize;
  assign mst14_slv0_htrans = mst14_htrans;
  assign mst14_slv0_hwrite = mst14_hwrite;
  assign mst14_slv0_req    = mst14_slv0_sel;
end
else begin : gen_m14s0_nonexistent
     assign mst14_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs0_hready  = 1'b0;
     assign mst14_hs0_hresp   = 2'h0;
     assign mst14_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv0_size   = 4'h0;
     assign mst14_slv0_grant  = 1'b0;
     assign hm14_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv0_hburst = 3'h0;
     assign mst14_slv0_hprot  = 4'h0;
     assign mst14_slv0_hsize  = 3'h0;
     assign mst14_slv0_htrans = 2'h0;
     assign mst14_slv0_hwrite = 1'b0;
     assign mst14_slv0_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S0) begin : gen_m15s0
  assign mst15_hs0_hrdata  = hs0_hrdata;
  assign mst15_hs0_hready  = hs0_hready;
  assign mst15_hs0_hresp   = hs0_hresp;
  assign mst15_slv0_base   = slv0_base;
  assign mst15_slv0_size   = slv0_size;
  assign mst15_slv0_grant  = mst15_slv0_ack;
  assign hm15_slv0_hwdata  = hm15_hwdata;
  assign mst15_slv0_haddr  = mst15_haddr;
  assign mst15_slv0_hburst = mst15_hburst;
  assign mst15_slv0_hprot  = mst15_hprot;
  assign mst15_slv0_hsize  = mst15_hsize;
  assign mst15_slv0_htrans = mst15_htrans;
  assign mst15_slv0_hwrite = mst15_hwrite;
  assign mst15_slv0_req    = mst15_slv0_sel;
end
else begin : gen_m15s0_nonexistent
     assign mst15_hs0_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs0_hready  = 1'b0;
     assign mst15_hs0_hresp   = 2'h0;
     assign mst15_slv0_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv0_size   = 4'h0;
     assign mst15_slv0_grant  = 1'b0;
     assign hm15_slv0_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv0_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv0_hburst = 3'h0;
     assign mst15_slv0_hprot  = 4'h0;
     assign mst15_slv0_hsize  = 3'h0;
     assign mst15_slv0_htrans = 2'h0;
     assign mst15_slv0_hwrite = 1'b0;
     assign mst15_slv0_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV1
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S1) begin : gen_m0s1
  assign mst0_hs1_hrdata  = hs1_hrdata;
  assign mst0_hs1_hready  = hs1_hready;
  assign mst0_hs1_hresp   = hs1_hresp;
  assign mst0_slv1_base   = slv1_base;
  assign mst0_slv1_size   = slv1_size;
  assign mst0_slv1_grant  = mst0_slv1_ack;
  assign hm0_slv1_hwdata  = hm0_hwdata;
  assign mst0_slv1_haddr  = mst0_haddr;
  assign mst0_slv1_hburst = mst0_hburst;
  assign mst0_slv1_hprot  = mst0_hprot;
  assign mst0_slv1_hsize  = mst0_hsize;
  assign mst0_slv1_htrans = mst0_htrans;
  assign mst0_slv1_hwrite = mst0_hwrite;
  assign mst0_slv1_req    = mst0_slv1_sel;
end
else begin : gen_m0s1_nonexistent
     assign mst0_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs1_hready  = 1'b0;
     assign mst0_hs1_hresp   = 2'h0;
     assign mst0_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv1_size   = 4'h0;
     assign mst0_slv1_grant  = 1'b0;
     assign hm0_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv1_hburst = 3'h0;
     assign mst0_slv1_hprot  = 4'h0;
     assign mst0_slv1_hsize  = 3'h0;
     assign mst0_slv1_htrans = 2'h0;
     assign mst0_slv1_hwrite = 1'b0;
     assign mst0_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S1) begin : gen_m1s1
  assign mst1_hs1_hrdata  = hs1_hrdata;
  assign mst1_hs1_hready  = hs1_hready;
  assign mst1_hs1_hresp   = hs1_hresp;
  assign mst1_slv1_base   = slv1_base;
  assign mst1_slv1_size   = slv1_size;
  assign mst1_slv1_grant  = mst1_slv1_ack;
  assign hm1_slv1_hwdata  = hm1_hwdata;
  assign mst1_slv1_haddr  = mst1_haddr;
  assign mst1_slv1_hburst = mst1_hburst;
  assign mst1_slv1_hprot  = mst1_hprot;
  assign mst1_slv1_hsize  = mst1_hsize;
  assign mst1_slv1_htrans = mst1_htrans;
  assign mst1_slv1_hwrite = mst1_hwrite;
  assign mst1_slv1_req    = mst1_slv1_sel;
end
else begin : gen_m1s1_nonexistent
     assign mst1_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs1_hready  = 1'b0;
     assign mst1_hs1_hresp   = 2'h0;
     assign mst1_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv1_size   = 4'h0;
     assign mst1_slv1_grant  = 1'b0;
     assign hm1_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv1_hburst = 3'h0;
     assign mst1_slv1_hprot  = 4'h0;
     assign mst1_slv1_hsize  = 3'h0;
     assign mst1_slv1_htrans = 2'h0;
     assign mst1_slv1_hwrite = 1'b0;
     assign mst1_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S1) begin : gen_m2s1
  assign mst2_hs1_hrdata  = hs1_hrdata;
  assign mst2_hs1_hready  = hs1_hready;
  assign mst2_hs1_hresp   = hs1_hresp;
  assign mst2_slv1_base   = slv1_base;
  assign mst2_slv1_size   = slv1_size;
  assign mst2_slv1_grant  = mst2_slv1_ack;
  assign hm2_slv1_hwdata  = hm2_hwdata;
  assign mst2_slv1_haddr  = mst2_haddr;
  assign mst2_slv1_hburst = mst2_hburst;
  assign mst2_slv1_hprot  = mst2_hprot;
  assign mst2_slv1_hsize  = mst2_hsize;
  assign mst2_slv1_htrans = mst2_htrans;
  assign mst2_slv1_hwrite = mst2_hwrite;
  assign mst2_slv1_req    = mst2_slv1_sel;
end
else begin : gen_m2s1_nonexistent
     assign mst2_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs1_hready  = 1'b0;
     assign mst2_hs1_hresp   = 2'h0;
     assign mst2_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv1_size   = 4'h0;
     assign mst2_slv1_grant  = 1'b0;
     assign hm2_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv1_hburst = 3'h0;
     assign mst2_slv1_hprot  = 4'h0;
     assign mst2_slv1_hsize  = 3'h0;
     assign mst2_slv1_htrans = 2'h0;
     assign mst2_slv1_hwrite = 1'b0;
     assign mst2_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S1) begin : gen_m3s1
  assign mst3_hs1_hrdata  = hs1_hrdata;
  assign mst3_hs1_hready  = hs1_hready;
  assign mst3_hs1_hresp   = hs1_hresp;
  assign mst3_slv1_base   = slv1_base;
  assign mst3_slv1_size   = slv1_size;
  assign mst3_slv1_grant  = mst3_slv1_ack;
  assign hm3_slv1_hwdata  = hm3_hwdata;
  assign mst3_slv1_haddr  = mst3_haddr;
  assign mst3_slv1_hburst = mst3_hburst;
  assign mst3_slv1_hprot  = mst3_hprot;
  assign mst3_slv1_hsize  = mst3_hsize;
  assign mst3_slv1_htrans = mst3_htrans;
  assign mst3_slv1_hwrite = mst3_hwrite;
  assign mst3_slv1_req    = mst3_slv1_sel;
end
else begin : gen_m3s1_nonexistent
     assign mst3_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs1_hready  = 1'b0;
     assign mst3_hs1_hresp   = 2'h0;
     assign mst3_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv1_size   = 4'h0;
     assign mst3_slv1_grant  = 1'b0;
     assign hm3_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv1_hburst = 3'h0;
     assign mst3_slv1_hprot  = 4'h0;
     assign mst3_slv1_hsize  = 3'h0;
     assign mst3_slv1_htrans = 2'h0;
     assign mst3_slv1_hwrite = 1'b0;
     assign mst3_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S1) begin : gen_m4s1
  assign mst4_hs1_hrdata  = hs1_hrdata;
  assign mst4_hs1_hready  = hs1_hready;
  assign mst4_hs1_hresp   = hs1_hresp;
  assign mst4_slv1_base   = slv1_base;
  assign mst4_slv1_size   = slv1_size;
  assign mst4_slv1_grant  = mst4_slv1_ack;
  assign hm4_slv1_hwdata  = hm4_hwdata;
  assign mst4_slv1_haddr  = mst4_haddr;
  assign mst4_slv1_hburst = mst4_hburst;
  assign mst4_slv1_hprot  = mst4_hprot;
  assign mst4_slv1_hsize  = mst4_hsize;
  assign mst4_slv1_htrans = mst4_htrans;
  assign mst4_slv1_hwrite = mst4_hwrite;
  assign mst4_slv1_req    = mst4_slv1_sel;
end
else begin : gen_m4s1_nonexistent
     assign mst4_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs1_hready  = 1'b0;
     assign mst4_hs1_hresp   = 2'h0;
     assign mst4_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv1_size   = 4'h0;
     assign mst4_slv1_grant  = 1'b0;
     assign hm4_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv1_hburst = 3'h0;
     assign mst4_slv1_hprot  = 4'h0;
     assign mst4_slv1_hsize  = 3'h0;
     assign mst4_slv1_htrans = 2'h0;
     assign mst4_slv1_hwrite = 1'b0;
     assign mst4_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S1) begin : gen_m5s1
  assign mst5_hs1_hrdata  = hs1_hrdata;
  assign mst5_hs1_hready  = hs1_hready;
  assign mst5_hs1_hresp   = hs1_hresp;
  assign mst5_slv1_base   = slv1_base;
  assign mst5_slv1_size   = slv1_size;
  assign mst5_slv1_grant  = mst5_slv1_ack;
  assign hm5_slv1_hwdata  = hm5_hwdata;
  assign mst5_slv1_haddr  = mst5_haddr;
  assign mst5_slv1_hburst = mst5_hburst;
  assign mst5_slv1_hprot  = mst5_hprot;
  assign mst5_slv1_hsize  = mst5_hsize;
  assign mst5_slv1_htrans = mst5_htrans;
  assign mst5_slv1_hwrite = mst5_hwrite;
  assign mst5_slv1_req    = mst5_slv1_sel;
end
else begin : gen_m5s1_nonexistent
     assign mst5_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs1_hready  = 1'b0;
     assign mst5_hs1_hresp   = 2'h0;
     assign mst5_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv1_size   = 4'h0;
     assign mst5_slv1_grant  = 1'b0;
     assign hm5_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv1_hburst = 3'h0;
     assign mst5_slv1_hprot  = 4'h0;
     assign mst5_slv1_hsize  = 3'h0;
     assign mst5_slv1_htrans = 2'h0;
     assign mst5_slv1_hwrite = 1'b0;
     assign mst5_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S1) begin : gen_m6s1
  assign mst6_hs1_hrdata  = hs1_hrdata;
  assign mst6_hs1_hready  = hs1_hready;
  assign mst6_hs1_hresp   = hs1_hresp;
  assign mst6_slv1_base   = slv1_base;
  assign mst6_slv1_size   = slv1_size;
  assign mst6_slv1_grant  = mst6_slv1_ack;
  assign hm6_slv1_hwdata  = hm6_hwdata;
  assign mst6_slv1_haddr  = mst6_haddr;
  assign mst6_slv1_hburst = mst6_hburst;
  assign mst6_slv1_hprot  = mst6_hprot;
  assign mst6_slv1_hsize  = mst6_hsize;
  assign mst6_slv1_htrans = mst6_htrans;
  assign mst6_slv1_hwrite = mst6_hwrite;
  assign mst6_slv1_req    = mst6_slv1_sel;
end
else begin : gen_m6s1_nonexistent
     assign mst6_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs1_hready  = 1'b0;
     assign mst6_hs1_hresp   = 2'h0;
     assign mst6_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv1_size   = 4'h0;
     assign mst6_slv1_grant  = 1'b0;
     assign hm6_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv1_hburst = 3'h0;
     assign mst6_slv1_hprot  = 4'h0;
     assign mst6_slv1_hsize  = 3'h0;
     assign mst6_slv1_htrans = 2'h0;
     assign mst6_slv1_hwrite = 1'b0;
     assign mst6_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S1) begin : gen_m7s1
  assign mst7_hs1_hrdata  = hs1_hrdata;
  assign mst7_hs1_hready  = hs1_hready;
  assign mst7_hs1_hresp   = hs1_hresp;
  assign mst7_slv1_base   = slv1_base;
  assign mst7_slv1_size   = slv1_size;
  assign mst7_slv1_grant  = mst7_slv1_ack;
  assign hm7_slv1_hwdata  = hm7_hwdata;
  assign mst7_slv1_haddr  = mst7_haddr;
  assign mst7_slv1_hburst = mst7_hburst;
  assign mst7_slv1_hprot  = mst7_hprot;
  assign mst7_slv1_hsize  = mst7_hsize;
  assign mst7_slv1_htrans = mst7_htrans;
  assign mst7_slv1_hwrite = mst7_hwrite;
  assign mst7_slv1_req    = mst7_slv1_sel;
end
else begin : gen_m7s1_nonexistent
     assign mst7_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs1_hready  = 1'b0;
     assign mst7_hs1_hresp   = 2'h0;
     assign mst7_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv1_size   = 4'h0;
     assign mst7_slv1_grant  = 1'b0;
     assign hm7_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv1_hburst = 3'h0;
     assign mst7_slv1_hprot  = 4'h0;
     assign mst7_slv1_hsize  = 3'h0;
     assign mst7_slv1_htrans = 2'h0;
     assign mst7_slv1_hwrite = 1'b0;
     assign mst7_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S1) begin : gen_m8s1
  assign mst8_hs1_hrdata  = hs1_hrdata;
  assign mst8_hs1_hready  = hs1_hready;
  assign mst8_hs1_hresp   = hs1_hresp;
  assign mst8_slv1_base   = slv1_base;
  assign mst8_slv1_size   = slv1_size;
  assign mst8_slv1_grant  = mst8_slv1_ack;
  assign hm8_slv1_hwdata  = hm8_hwdata;
  assign mst8_slv1_haddr  = mst8_haddr;
  assign mst8_slv1_hburst = mst8_hburst;
  assign mst8_slv1_hprot  = mst8_hprot;
  assign mst8_slv1_hsize  = mst8_hsize;
  assign mst8_slv1_htrans = mst8_htrans;
  assign mst8_slv1_hwrite = mst8_hwrite;
  assign mst8_slv1_req    = mst8_slv1_sel;
end
else begin : gen_m8s1_nonexistent
     assign mst8_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs1_hready  = 1'b0;
     assign mst8_hs1_hresp   = 2'h0;
     assign mst8_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv1_size   = 4'h0;
     assign mst8_slv1_grant  = 1'b0;
     assign hm8_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv1_hburst = 3'h0;
     assign mst8_slv1_hprot  = 4'h0;
     assign mst8_slv1_hsize  = 3'h0;
     assign mst8_slv1_htrans = 2'h0;
     assign mst8_slv1_hwrite = 1'b0;
     assign mst8_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S1) begin : gen_m9s1
  assign mst9_hs1_hrdata  = hs1_hrdata;
  assign mst9_hs1_hready  = hs1_hready;
  assign mst9_hs1_hresp   = hs1_hresp;
  assign mst9_slv1_base   = slv1_base;
  assign mst9_slv1_size   = slv1_size;
  assign mst9_slv1_grant  = mst9_slv1_ack;
  assign hm9_slv1_hwdata  = hm9_hwdata;
  assign mst9_slv1_haddr  = mst9_haddr;
  assign mst9_slv1_hburst = mst9_hburst;
  assign mst9_slv1_hprot  = mst9_hprot;
  assign mst9_slv1_hsize  = mst9_hsize;
  assign mst9_slv1_htrans = mst9_htrans;
  assign mst9_slv1_hwrite = mst9_hwrite;
  assign mst9_slv1_req    = mst9_slv1_sel;
end
else begin : gen_m9s1_nonexistent
     assign mst9_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs1_hready  = 1'b0;
     assign mst9_hs1_hresp   = 2'h0;
     assign mst9_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv1_size   = 4'h0;
     assign mst9_slv1_grant  = 1'b0;
     assign hm9_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv1_hburst = 3'h0;
     assign mst9_slv1_hprot  = 4'h0;
     assign mst9_slv1_hsize  = 3'h0;
     assign mst9_slv1_htrans = 2'h0;
     assign mst9_slv1_hwrite = 1'b0;
     assign mst9_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S1) begin : gen_m10s1
  assign mst10_hs1_hrdata  = hs1_hrdata;
  assign mst10_hs1_hready  = hs1_hready;
  assign mst10_hs1_hresp   = hs1_hresp;
  assign mst10_slv1_base   = slv1_base;
  assign mst10_slv1_size   = slv1_size;
  assign mst10_slv1_grant  = mst10_slv1_ack;
  assign hm10_slv1_hwdata  = hm10_hwdata;
  assign mst10_slv1_haddr  = mst10_haddr;
  assign mst10_slv1_hburst = mst10_hburst;
  assign mst10_slv1_hprot  = mst10_hprot;
  assign mst10_slv1_hsize  = mst10_hsize;
  assign mst10_slv1_htrans = mst10_htrans;
  assign mst10_slv1_hwrite = mst10_hwrite;
  assign mst10_slv1_req    = mst10_slv1_sel;
end
else begin : gen_m10s1_nonexistent
     assign mst10_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs1_hready  = 1'b0;
     assign mst10_hs1_hresp   = 2'h0;
     assign mst10_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv1_size   = 4'h0;
     assign mst10_slv1_grant  = 1'b0;
     assign hm10_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv1_hburst = 3'h0;
     assign mst10_slv1_hprot  = 4'h0;
     assign mst10_slv1_hsize  = 3'h0;
     assign mst10_slv1_htrans = 2'h0;
     assign mst10_slv1_hwrite = 1'b0;
     assign mst10_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S1) begin : gen_m11s1
  assign mst11_hs1_hrdata  = hs1_hrdata;
  assign mst11_hs1_hready  = hs1_hready;
  assign mst11_hs1_hresp   = hs1_hresp;
  assign mst11_slv1_base   = slv1_base;
  assign mst11_slv1_size   = slv1_size;
  assign mst11_slv1_grant  = mst11_slv1_ack;
  assign hm11_slv1_hwdata  = hm11_hwdata;
  assign mst11_slv1_haddr  = mst11_haddr;
  assign mst11_slv1_hburst = mst11_hburst;
  assign mst11_slv1_hprot  = mst11_hprot;
  assign mst11_slv1_hsize  = mst11_hsize;
  assign mst11_slv1_htrans = mst11_htrans;
  assign mst11_slv1_hwrite = mst11_hwrite;
  assign mst11_slv1_req    = mst11_slv1_sel;
end
else begin : gen_m11s1_nonexistent
     assign mst11_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs1_hready  = 1'b0;
     assign mst11_hs1_hresp   = 2'h0;
     assign mst11_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv1_size   = 4'h0;
     assign mst11_slv1_grant  = 1'b0;
     assign hm11_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv1_hburst = 3'h0;
     assign mst11_slv1_hprot  = 4'h0;
     assign mst11_slv1_hsize  = 3'h0;
     assign mst11_slv1_htrans = 2'h0;
     assign mst11_slv1_hwrite = 1'b0;
     assign mst11_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S1) begin : gen_m12s1
  assign mst12_hs1_hrdata  = hs1_hrdata;
  assign mst12_hs1_hready  = hs1_hready;
  assign mst12_hs1_hresp   = hs1_hresp;
  assign mst12_slv1_base   = slv1_base;
  assign mst12_slv1_size   = slv1_size;
  assign mst12_slv1_grant  = mst12_slv1_ack;
  assign hm12_slv1_hwdata  = hm12_hwdata;
  assign mst12_slv1_haddr  = mst12_haddr;
  assign mst12_slv1_hburst = mst12_hburst;
  assign mst12_slv1_hprot  = mst12_hprot;
  assign mst12_slv1_hsize  = mst12_hsize;
  assign mst12_slv1_htrans = mst12_htrans;
  assign mst12_slv1_hwrite = mst12_hwrite;
  assign mst12_slv1_req    = mst12_slv1_sel;
end
else begin : gen_m12s1_nonexistent
     assign mst12_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs1_hready  = 1'b0;
     assign mst12_hs1_hresp   = 2'h0;
     assign mst12_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv1_size   = 4'h0;
     assign mst12_slv1_grant  = 1'b0;
     assign hm12_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv1_hburst = 3'h0;
     assign mst12_slv1_hprot  = 4'h0;
     assign mst12_slv1_hsize  = 3'h0;
     assign mst12_slv1_htrans = 2'h0;
     assign mst12_slv1_hwrite = 1'b0;
     assign mst12_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S1) begin : gen_m13s1
  assign mst13_hs1_hrdata  = hs1_hrdata;
  assign mst13_hs1_hready  = hs1_hready;
  assign mst13_hs1_hresp   = hs1_hresp;
  assign mst13_slv1_base   = slv1_base;
  assign mst13_slv1_size   = slv1_size;
  assign mst13_slv1_grant  = mst13_slv1_ack;
  assign hm13_slv1_hwdata  = hm13_hwdata;
  assign mst13_slv1_haddr  = mst13_haddr;
  assign mst13_slv1_hburst = mst13_hburst;
  assign mst13_slv1_hprot  = mst13_hprot;
  assign mst13_slv1_hsize  = mst13_hsize;
  assign mst13_slv1_htrans = mst13_htrans;
  assign mst13_slv1_hwrite = mst13_hwrite;
  assign mst13_slv1_req    = mst13_slv1_sel;
end
else begin : gen_m13s1_nonexistent
     assign mst13_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs1_hready  = 1'b0;
     assign mst13_hs1_hresp   = 2'h0;
     assign mst13_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv1_size   = 4'h0;
     assign mst13_slv1_grant  = 1'b0;
     assign hm13_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv1_hburst = 3'h0;
     assign mst13_slv1_hprot  = 4'h0;
     assign mst13_slv1_hsize  = 3'h0;
     assign mst13_slv1_htrans = 2'h0;
     assign mst13_slv1_hwrite = 1'b0;
     assign mst13_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S1) begin : gen_m14s1
  assign mst14_hs1_hrdata  = hs1_hrdata;
  assign mst14_hs1_hready  = hs1_hready;
  assign mst14_hs1_hresp   = hs1_hresp;
  assign mst14_slv1_base   = slv1_base;
  assign mst14_slv1_size   = slv1_size;
  assign mst14_slv1_grant  = mst14_slv1_ack;
  assign hm14_slv1_hwdata  = hm14_hwdata;
  assign mst14_slv1_haddr  = mst14_haddr;
  assign mst14_slv1_hburst = mst14_hburst;
  assign mst14_slv1_hprot  = mst14_hprot;
  assign mst14_slv1_hsize  = mst14_hsize;
  assign mst14_slv1_htrans = mst14_htrans;
  assign mst14_slv1_hwrite = mst14_hwrite;
  assign mst14_slv1_req    = mst14_slv1_sel;
end
else begin : gen_m14s1_nonexistent
     assign mst14_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs1_hready  = 1'b0;
     assign mst14_hs1_hresp   = 2'h0;
     assign mst14_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv1_size   = 4'h0;
     assign mst14_slv1_grant  = 1'b0;
     assign hm14_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv1_hburst = 3'h0;
     assign mst14_slv1_hprot  = 4'h0;
     assign mst14_slv1_hsize  = 3'h0;
     assign mst14_slv1_htrans = 2'h0;
     assign mst14_slv1_hwrite = 1'b0;
     assign mst14_slv1_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S1) begin : gen_m15s1
  assign mst15_hs1_hrdata  = hs1_hrdata;
  assign mst15_hs1_hready  = hs1_hready;
  assign mst15_hs1_hresp   = hs1_hresp;
  assign mst15_slv1_base   = slv1_base;
  assign mst15_slv1_size   = slv1_size;
  assign mst15_slv1_grant  = mst15_slv1_ack;
  assign hm15_slv1_hwdata  = hm15_hwdata;
  assign mst15_slv1_haddr  = mst15_haddr;
  assign mst15_slv1_hburst = mst15_hburst;
  assign mst15_slv1_hprot  = mst15_hprot;
  assign mst15_slv1_hsize  = mst15_hsize;
  assign mst15_slv1_htrans = mst15_htrans;
  assign mst15_slv1_hwrite = mst15_hwrite;
  assign mst15_slv1_req    = mst15_slv1_sel;
end
else begin : gen_m15s1_nonexistent
     assign mst15_hs1_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs1_hready  = 1'b0;
     assign mst15_hs1_hresp   = 2'h0;
     assign mst15_slv1_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv1_size   = 4'h0;
     assign mst15_slv1_grant  = 1'b0;
     assign hm15_slv1_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv1_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv1_hburst = 3'h0;
     assign mst15_slv1_hprot  = 4'h0;
     assign mst15_slv1_hsize  = 3'h0;
     assign mst15_slv1_htrans = 2'h0;
     assign mst15_slv1_hwrite = 1'b0;
     assign mst15_slv1_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV2
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S2) begin : gen_m0s2
  assign mst0_hs2_hrdata  = hs2_hrdata;
  assign mst0_hs2_hready  = hs2_hready;
  assign mst0_hs2_hresp   = hs2_hresp;
  assign mst0_slv2_base   = slv2_base;
  assign mst0_slv2_size   = slv2_size;
  assign mst0_slv2_grant  = mst0_slv2_ack;
  assign hm0_slv2_hwdata  = hm0_hwdata;
  assign mst0_slv2_haddr  = mst0_haddr;
  assign mst0_slv2_hburst = mst0_hburst;
  assign mst0_slv2_hprot  = mst0_hprot;
  assign mst0_slv2_hsize  = mst0_hsize;
  assign mst0_slv2_htrans = mst0_htrans;
  assign mst0_slv2_hwrite = mst0_hwrite;
  assign mst0_slv2_req    = mst0_slv2_sel;
end
else begin : gen_m0s2_nonexistent
     assign mst0_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs2_hready  = 1'b0;
     assign mst0_hs2_hresp   = 2'h0;
     assign mst0_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv2_size   = 4'h0;
     assign mst0_slv2_grant  = 1'b0;
     assign hm0_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv2_hburst = 3'h0;
     assign mst0_slv2_hprot  = 4'h0;
     assign mst0_slv2_hsize  = 3'h0;
     assign mst0_slv2_htrans = 2'h0;
     assign mst0_slv2_hwrite = 1'b0;
     assign mst0_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S2) begin : gen_m1s2
  assign mst1_hs2_hrdata  = hs2_hrdata;
  assign mst1_hs2_hready  = hs2_hready;
  assign mst1_hs2_hresp   = hs2_hresp;
  assign mst1_slv2_base   = slv2_base;
  assign mst1_slv2_size   = slv2_size;
  assign mst1_slv2_grant  = mst1_slv2_ack;
  assign hm1_slv2_hwdata  = hm1_hwdata;
  assign mst1_slv2_haddr  = mst1_haddr;
  assign mst1_slv2_hburst = mst1_hburst;
  assign mst1_slv2_hprot  = mst1_hprot;
  assign mst1_slv2_hsize  = mst1_hsize;
  assign mst1_slv2_htrans = mst1_htrans;
  assign mst1_slv2_hwrite = mst1_hwrite;
  assign mst1_slv2_req    = mst1_slv2_sel;
end
else begin : gen_m1s2_nonexistent
     assign mst1_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs2_hready  = 1'b0;
     assign mst1_hs2_hresp   = 2'h0;
     assign mst1_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv2_size   = 4'h0;
     assign mst1_slv2_grant  = 1'b0;
     assign hm1_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv2_hburst = 3'h0;
     assign mst1_slv2_hprot  = 4'h0;
     assign mst1_slv2_hsize  = 3'h0;
     assign mst1_slv2_htrans = 2'h0;
     assign mst1_slv2_hwrite = 1'b0;
     assign mst1_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S2) begin : gen_m2s2
  assign mst2_hs2_hrdata  = hs2_hrdata;
  assign mst2_hs2_hready  = hs2_hready;
  assign mst2_hs2_hresp   = hs2_hresp;
  assign mst2_slv2_base   = slv2_base;
  assign mst2_slv2_size   = slv2_size;
  assign mst2_slv2_grant  = mst2_slv2_ack;
  assign hm2_slv2_hwdata  = hm2_hwdata;
  assign mst2_slv2_haddr  = mst2_haddr;
  assign mst2_slv2_hburst = mst2_hburst;
  assign mst2_slv2_hprot  = mst2_hprot;
  assign mst2_slv2_hsize  = mst2_hsize;
  assign mst2_slv2_htrans = mst2_htrans;
  assign mst2_slv2_hwrite = mst2_hwrite;
  assign mst2_slv2_req    = mst2_slv2_sel;
end
else begin : gen_m2s2_nonexistent
     assign mst2_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs2_hready  = 1'b0;
     assign mst2_hs2_hresp   = 2'h0;
     assign mst2_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv2_size   = 4'h0;
     assign mst2_slv2_grant  = 1'b0;
     assign hm2_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv2_hburst = 3'h0;
     assign mst2_slv2_hprot  = 4'h0;
     assign mst2_slv2_hsize  = 3'h0;
     assign mst2_slv2_htrans = 2'h0;
     assign mst2_slv2_hwrite = 1'b0;
     assign mst2_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S2) begin : gen_m3s2
  assign mst3_hs2_hrdata  = hs2_hrdata;
  assign mst3_hs2_hready  = hs2_hready;
  assign mst3_hs2_hresp   = hs2_hresp;
  assign mst3_slv2_base   = slv2_base;
  assign mst3_slv2_size   = slv2_size;
  assign mst3_slv2_grant  = mst3_slv2_ack;
  assign hm3_slv2_hwdata  = hm3_hwdata;
  assign mst3_slv2_haddr  = mst3_haddr;
  assign mst3_slv2_hburst = mst3_hburst;
  assign mst3_slv2_hprot  = mst3_hprot;
  assign mst3_slv2_hsize  = mst3_hsize;
  assign mst3_slv2_htrans = mst3_htrans;
  assign mst3_slv2_hwrite = mst3_hwrite;
  assign mst3_slv2_req    = mst3_slv2_sel;
end
else begin : gen_m3s2_nonexistent
     assign mst3_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs2_hready  = 1'b0;
     assign mst3_hs2_hresp   = 2'h0;
     assign mst3_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv2_size   = 4'h0;
     assign mst3_slv2_grant  = 1'b0;
     assign hm3_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv2_hburst = 3'h0;
     assign mst3_slv2_hprot  = 4'h0;
     assign mst3_slv2_hsize  = 3'h0;
     assign mst3_slv2_htrans = 2'h0;
     assign mst3_slv2_hwrite = 1'b0;
     assign mst3_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S2) begin : gen_m4s2
  assign mst4_hs2_hrdata  = hs2_hrdata;
  assign mst4_hs2_hready  = hs2_hready;
  assign mst4_hs2_hresp   = hs2_hresp;
  assign mst4_slv2_base   = slv2_base;
  assign mst4_slv2_size   = slv2_size;
  assign mst4_slv2_grant  = mst4_slv2_ack;
  assign hm4_slv2_hwdata  = hm4_hwdata;
  assign mst4_slv2_haddr  = mst4_haddr;
  assign mst4_slv2_hburst = mst4_hburst;
  assign mst4_slv2_hprot  = mst4_hprot;
  assign mst4_slv2_hsize  = mst4_hsize;
  assign mst4_slv2_htrans = mst4_htrans;
  assign mst4_slv2_hwrite = mst4_hwrite;
  assign mst4_slv2_req    = mst4_slv2_sel;
end
else begin : gen_m4s2_nonexistent
     assign mst4_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs2_hready  = 1'b0;
     assign mst4_hs2_hresp   = 2'h0;
     assign mst4_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv2_size   = 4'h0;
     assign mst4_slv2_grant  = 1'b0;
     assign hm4_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv2_hburst = 3'h0;
     assign mst4_slv2_hprot  = 4'h0;
     assign mst4_slv2_hsize  = 3'h0;
     assign mst4_slv2_htrans = 2'h0;
     assign mst4_slv2_hwrite = 1'b0;
     assign mst4_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S2) begin : gen_m5s2
  assign mst5_hs2_hrdata  = hs2_hrdata;
  assign mst5_hs2_hready  = hs2_hready;
  assign mst5_hs2_hresp   = hs2_hresp;
  assign mst5_slv2_base   = slv2_base;
  assign mst5_slv2_size   = slv2_size;
  assign mst5_slv2_grant  = mst5_slv2_ack;
  assign hm5_slv2_hwdata  = hm5_hwdata;
  assign mst5_slv2_haddr  = mst5_haddr;
  assign mst5_slv2_hburst = mst5_hburst;
  assign mst5_slv2_hprot  = mst5_hprot;
  assign mst5_slv2_hsize  = mst5_hsize;
  assign mst5_slv2_htrans = mst5_htrans;
  assign mst5_slv2_hwrite = mst5_hwrite;
  assign mst5_slv2_req    = mst5_slv2_sel;
end
else begin : gen_m5s2_nonexistent
     assign mst5_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs2_hready  = 1'b0;
     assign mst5_hs2_hresp   = 2'h0;
     assign mst5_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv2_size   = 4'h0;
     assign mst5_slv2_grant  = 1'b0;
     assign hm5_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv2_hburst = 3'h0;
     assign mst5_slv2_hprot  = 4'h0;
     assign mst5_slv2_hsize  = 3'h0;
     assign mst5_slv2_htrans = 2'h0;
     assign mst5_slv2_hwrite = 1'b0;
     assign mst5_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S2) begin : gen_m6s2
  assign mst6_hs2_hrdata  = hs2_hrdata;
  assign mst6_hs2_hready  = hs2_hready;
  assign mst6_hs2_hresp   = hs2_hresp;
  assign mst6_slv2_base   = slv2_base;
  assign mst6_slv2_size   = slv2_size;
  assign mst6_slv2_grant  = mst6_slv2_ack;
  assign hm6_slv2_hwdata  = hm6_hwdata;
  assign mst6_slv2_haddr  = mst6_haddr;
  assign mst6_slv2_hburst = mst6_hburst;
  assign mst6_slv2_hprot  = mst6_hprot;
  assign mst6_slv2_hsize  = mst6_hsize;
  assign mst6_slv2_htrans = mst6_htrans;
  assign mst6_slv2_hwrite = mst6_hwrite;
  assign mst6_slv2_req    = mst6_slv2_sel;
end
else begin : gen_m6s2_nonexistent
     assign mst6_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs2_hready  = 1'b0;
     assign mst6_hs2_hresp   = 2'h0;
     assign mst6_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv2_size   = 4'h0;
     assign mst6_slv2_grant  = 1'b0;
     assign hm6_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv2_hburst = 3'h0;
     assign mst6_slv2_hprot  = 4'h0;
     assign mst6_slv2_hsize  = 3'h0;
     assign mst6_slv2_htrans = 2'h0;
     assign mst6_slv2_hwrite = 1'b0;
     assign mst6_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S2) begin : gen_m7s2
  assign mst7_hs2_hrdata  = hs2_hrdata;
  assign mst7_hs2_hready  = hs2_hready;
  assign mst7_hs2_hresp   = hs2_hresp;
  assign mst7_slv2_base   = slv2_base;
  assign mst7_slv2_size   = slv2_size;
  assign mst7_slv2_grant  = mst7_slv2_ack;
  assign hm7_slv2_hwdata  = hm7_hwdata;
  assign mst7_slv2_haddr  = mst7_haddr;
  assign mst7_slv2_hburst = mst7_hburst;
  assign mst7_slv2_hprot  = mst7_hprot;
  assign mst7_slv2_hsize  = mst7_hsize;
  assign mst7_slv2_htrans = mst7_htrans;
  assign mst7_slv2_hwrite = mst7_hwrite;
  assign mst7_slv2_req    = mst7_slv2_sel;
end
else begin : gen_m7s2_nonexistent
     assign mst7_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs2_hready  = 1'b0;
     assign mst7_hs2_hresp   = 2'h0;
     assign mst7_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv2_size   = 4'h0;
     assign mst7_slv2_grant  = 1'b0;
     assign hm7_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv2_hburst = 3'h0;
     assign mst7_slv2_hprot  = 4'h0;
     assign mst7_slv2_hsize  = 3'h0;
     assign mst7_slv2_htrans = 2'h0;
     assign mst7_slv2_hwrite = 1'b0;
     assign mst7_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S2) begin : gen_m8s2
  assign mst8_hs2_hrdata  = hs2_hrdata;
  assign mst8_hs2_hready  = hs2_hready;
  assign mst8_hs2_hresp   = hs2_hresp;
  assign mst8_slv2_base   = slv2_base;
  assign mst8_slv2_size   = slv2_size;
  assign mst8_slv2_grant  = mst8_slv2_ack;
  assign hm8_slv2_hwdata  = hm8_hwdata;
  assign mst8_slv2_haddr  = mst8_haddr;
  assign mst8_slv2_hburst = mst8_hburst;
  assign mst8_slv2_hprot  = mst8_hprot;
  assign mst8_slv2_hsize  = mst8_hsize;
  assign mst8_slv2_htrans = mst8_htrans;
  assign mst8_slv2_hwrite = mst8_hwrite;
  assign mst8_slv2_req    = mst8_slv2_sel;
end
else begin : gen_m8s2_nonexistent
     assign mst8_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs2_hready  = 1'b0;
     assign mst8_hs2_hresp   = 2'h0;
     assign mst8_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv2_size   = 4'h0;
     assign mst8_slv2_grant  = 1'b0;
     assign hm8_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv2_hburst = 3'h0;
     assign mst8_slv2_hprot  = 4'h0;
     assign mst8_slv2_hsize  = 3'h0;
     assign mst8_slv2_htrans = 2'h0;
     assign mst8_slv2_hwrite = 1'b0;
     assign mst8_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S2) begin : gen_m9s2
  assign mst9_hs2_hrdata  = hs2_hrdata;
  assign mst9_hs2_hready  = hs2_hready;
  assign mst9_hs2_hresp   = hs2_hresp;
  assign mst9_slv2_base   = slv2_base;
  assign mst9_slv2_size   = slv2_size;
  assign mst9_slv2_grant  = mst9_slv2_ack;
  assign hm9_slv2_hwdata  = hm9_hwdata;
  assign mst9_slv2_haddr  = mst9_haddr;
  assign mst9_slv2_hburst = mst9_hburst;
  assign mst9_slv2_hprot  = mst9_hprot;
  assign mst9_slv2_hsize  = mst9_hsize;
  assign mst9_slv2_htrans = mst9_htrans;
  assign mst9_slv2_hwrite = mst9_hwrite;
  assign mst9_slv2_req    = mst9_slv2_sel;
end
else begin : gen_m9s2_nonexistent
     assign mst9_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs2_hready  = 1'b0;
     assign mst9_hs2_hresp   = 2'h0;
     assign mst9_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv2_size   = 4'h0;
     assign mst9_slv2_grant  = 1'b0;
     assign hm9_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv2_hburst = 3'h0;
     assign mst9_slv2_hprot  = 4'h0;
     assign mst9_slv2_hsize  = 3'h0;
     assign mst9_slv2_htrans = 2'h0;
     assign mst9_slv2_hwrite = 1'b0;
     assign mst9_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S2) begin : gen_m10s2
  assign mst10_hs2_hrdata  = hs2_hrdata;
  assign mst10_hs2_hready  = hs2_hready;
  assign mst10_hs2_hresp   = hs2_hresp;
  assign mst10_slv2_base   = slv2_base;
  assign mst10_slv2_size   = slv2_size;
  assign mst10_slv2_grant  = mst10_slv2_ack;
  assign hm10_slv2_hwdata  = hm10_hwdata;
  assign mst10_slv2_haddr  = mst10_haddr;
  assign mst10_slv2_hburst = mst10_hburst;
  assign mst10_slv2_hprot  = mst10_hprot;
  assign mst10_slv2_hsize  = mst10_hsize;
  assign mst10_slv2_htrans = mst10_htrans;
  assign mst10_slv2_hwrite = mst10_hwrite;
  assign mst10_slv2_req    = mst10_slv2_sel;
end
else begin : gen_m10s2_nonexistent
     assign mst10_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs2_hready  = 1'b0;
     assign mst10_hs2_hresp   = 2'h0;
     assign mst10_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv2_size   = 4'h0;
     assign mst10_slv2_grant  = 1'b0;
     assign hm10_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv2_hburst = 3'h0;
     assign mst10_slv2_hprot  = 4'h0;
     assign mst10_slv2_hsize  = 3'h0;
     assign mst10_slv2_htrans = 2'h0;
     assign mst10_slv2_hwrite = 1'b0;
     assign mst10_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S2) begin : gen_m11s2
  assign mst11_hs2_hrdata  = hs2_hrdata;
  assign mst11_hs2_hready  = hs2_hready;
  assign mst11_hs2_hresp   = hs2_hresp;
  assign mst11_slv2_base   = slv2_base;
  assign mst11_slv2_size   = slv2_size;
  assign mst11_slv2_grant  = mst11_slv2_ack;
  assign hm11_slv2_hwdata  = hm11_hwdata;
  assign mst11_slv2_haddr  = mst11_haddr;
  assign mst11_slv2_hburst = mst11_hburst;
  assign mst11_slv2_hprot  = mst11_hprot;
  assign mst11_slv2_hsize  = mst11_hsize;
  assign mst11_slv2_htrans = mst11_htrans;
  assign mst11_slv2_hwrite = mst11_hwrite;
  assign mst11_slv2_req    = mst11_slv2_sel;
end
else begin : gen_m11s2_nonexistent
     assign mst11_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs2_hready  = 1'b0;
     assign mst11_hs2_hresp   = 2'h0;
     assign mst11_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv2_size   = 4'h0;
     assign mst11_slv2_grant  = 1'b0;
     assign hm11_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv2_hburst = 3'h0;
     assign mst11_slv2_hprot  = 4'h0;
     assign mst11_slv2_hsize  = 3'h0;
     assign mst11_slv2_htrans = 2'h0;
     assign mst11_slv2_hwrite = 1'b0;
     assign mst11_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S2) begin : gen_m12s2
  assign mst12_hs2_hrdata  = hs2_hrdata;
  assign mst12_hs2_hready  = hs2_hready;
  assign mst12_hs2_hresp   = hs2_hresp;
  assign mst12_slv2_base   = slv2_base;
  assign mst12_slv2_size   = slv2_size;
  assign mst12_slv2_grant  = mst12_slv2_ack;
  assign hm12_slv2_hwdata  = hm12_hwdata;
  assign mst12_slv2_haddr  = mst12_haddr;
  assign mst12_slv2_hburst = mst12_hburst;
  assign mst12_slv2_hprot  = mst12_hprot;
  assign mst12_slv2_hsize  = mst12_hsize;
  assign mst12_slv2_htrans = mst12_htrans;
  assign mst12_slv2_hwrite = mst12_hwrite;
  assign mst12_slv2_req    = mst12_slv2_sel;
end
else begin : gen_m12s2_nonexistent
     assign mst12_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs2_hready  = 1'b0;
     assign mst12_hs2_hresp   = 2'h0;
     assign mst12_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv2_size   = 4'h0;
     assign mst12_slv2_grant  = 1'b0;
     assign hm12_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv2_hburst = 3'h0;
     assign mst12_slv2_hprot  = 4'h0;
     assign mst12_slv2_hsize  = 3'h0;
     assign mst12_slv2_htrans = 2'h0;
     assign mst12_slv2_hwrite = 1'b0;
     assign mst12_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S2) begin : gen_m13s2
  assign mst13_hs2_hrdata  = hs2_hrdata;
  assign mst13_hs2_hready  = hs2_hready;
  assign mst13_hs2_hresp   = hs2_hresp;
  assign mst13_slv2_base   = slv2_base;
  assign mst13_slv2_size   = slv2_size;
  assign mst13_slv2_grant  = mst13_slv2_ack;
  assign hm13_slv2_hwdata  = hm13_hwdata;
  assign mst13_slv2_haddr  = mst13_haddr;
  assign mst13_slv2_hburst = mst13_hburst;
  assign mst13_slv2_hprot  = mst13_hprot;
  assign mst13_slv2_hsize  = mst13_hsize;
  assign mst13_slv2_htrans = mst13_htrans;
  assign mst13_slv2_hwrite = mst13_hwrite;
  assign mst13_slv2_req    = mst13_slv2_sel;
end
else begin : gen_m13s2_nonexistent
     assign mst13_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs2_hready  = 1'b0;
     assign mst13_hs2_hresp   = 2'h0;
     assign mst13_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv2_size   = 4'h0;
     assign mst13_slv2_grant  = 1'b0;
     assign hm13_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv2_hburst = 3'h0;
     assign mst13_slv2_hprot  = 4'h0;
     assign mst13_slv2_hsize  = 3'h0;
     assign mst13_slv2_htrans = 2'h0;
     assign mst13_slv2_hwrite = 1'b0;
     assign mst13_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S2) begin : gen_m14s2
  assign mst14_hs2_hrdata  = hs2_hrdata;
  assign mst14_hs2_hready  = hs2_hready;
  assign mst14_hs2_hresp   = hs2_hresp;
  assign mst14_slv2_base   = slv2_base;
  assign mst14_slv2_size   = slv2_size;
  assign mst14_slv2_grant  = mst14_slv2_ack;
  assign hm14_slv2_hwdata  = hm14_hwdata;
  assign mst14_slv2_haddr  = mst14_haddr;
  assign mst14_slv2_hburst = mst14_hburst;
  assign mst14_slv2_hprot  = mst14_hprot;
  assign mst14_slv2_hsize  = mst14_hsize;
  assign mst14_slv2_htrans = mst14_htrans;
  assign mst14_slv2_hwrite = mst14_hwrite;
  assign mst14_slv2_req    = mst14_slv2_sel;
end
else begin : gen_m14s2_nonexistent
     assign mst14_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs2_hready  = 1'b0;
     assign mst14_hs2_hresp   = 2'h0;
     assign mst14_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv2_size   = 4'h0;
     assign mst14_slv2_grant  = 1'b0;
     assign hm14_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv2_hburst = 3'h0;
     assign mst14_slv2_hprot  = 4'h0;
     assign mst14_slv2_hsize  = 3'h0;
     assign mst14_slv2_htrans = 2'h0;
     assign mst14_slv2_hwrite = 1'b0;
     assign mst14_slv2_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S2) begin : gen_m15s2
  assign mst15_hs2_hrdata  = hs2_hrdata;
  assign mst15_hs2_hready  = hs2_hready;
  assign mst15_hs2_hresp   = hs2_hresp;
  assign mst15_slv2_base   = slv2_base;
  assign mst15_slv2_size   = slv2_size;
  assign mst15_slv2_grant  = mst15_slv2_ack;
  assign hm15_slv2_hwdata  = hm15_hwdata;
  assign mst15_slv2_haddr  = mst15_haddr;
  assign mst15_slv2_hburst = mst15_hburst;
  assign mst15_slv2_hprot  = mst15_hprot;
  assign mst15_slv2_hsize  = mst15_hsize;
  assign mst15_slv2_htrans = mst15_htrans;
  assign mst15_slv2_hwrite = mst15_hwrite;
  assign mst15_slv2_req    = mst15_slv2_sel;
end
else begin : gen_m15s2_nonexistent
     assign mst15_hs2_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs2_hready  = 1'b0;
     assign mst15_hs2_hresp   = 2'h0;
     assign mst15_slv2_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv2_size   = 4'h0;
     assign mst15_slv2_grant  = 1'b0;
     assign hm15_slv2_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv2_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv2_hburst = 3'h0;
     assign mst15_slv2_hprot  = 4'h0;
     assign mst15_slv2_hsize  = 3'h0;
     assign mst15_slv2_htrans = 2'h0;
     assign mst15_slv2_hwrite = 1'b0;
     assign mst15_slv2_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV3
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S3) begin : gen_m0s3
  assign mst0_hs3_hrdata  = hs3_hrdata;
  assign mst0_hs3_hready  = hs3_hready;
  assign mst0_hs3_hresp   = hs3_hresp;
  assign mst0_slv3_base   = slv3_base;
  assign mst0_slv3_size   = slv3_size;
  assign mst0_slv3_grant  = mst0_slv3_ack;
  assign hm0_slv3_hwdata  = hm0_hwdata;
  assign mst0_slv3_haddr  = mst0_haddr;
  assign mst0_slv3_hburst = mst0_hburst;
  assign mst0_slv3_hprot  = mst0_hprot;
  assign mst0_slv3_hsize  = mst0_hsize;
  assign mst0_slv3_htrans = mst0_htrans;
  assign mst0_slv3_hwrite = mst0_hwrite;
  assign mst0_slv3_req    = mst0_slv3_sel;
end
else begin : gen_m0s3_nonexistent
     assign mst0_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs3_hready  = 1'b0;
     assign mst0_hs3_hresp   = 2'h0;
     assign mst0_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv3_size   = 4'h0;
     assign mst0_slv3_grant  = 1'b0;
     assign hm0_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv3_hburst = 3'h0;
     assign mst0_slv3_hprot  = 4'h0;
     assign mst0_slv3_hsize  = 3'h0;
     assign mst0_slv3_htrans = 2'h0;
     assign mst0_slv3_hwrite = 1'b0;
     assign mst0_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S3) begin : gen_m1s3
  assign mst1_hs3_hrdata  = hs3_hrdata;
  assign mst1_hs3_hready  = hs3_hready;
  assign mst1_hs3_hresp   = hs3_hresp;
  assign mst1_slv3_base   = slv3_base;
  assign mst1_slv3_size   = slv3_size;
  assign mst1_slv3_grant  = mst1_slv3_ack;
  assign hm1_slv3_hwdata  = hm1_hwdata;
  assign mst1_slv3_haddr  = mst1_haddr;
  assign mst1_slv3_hburst = mst1_hburst;
  assign mst1_slv3_hprot  = mst1_hprot;
  assign mst1_slv3_hsize  = mst1_hsize;
  assign mst1_slv3_htrans = mst1_htrans;
  assign mst1_slv3_hwrite = mst1_hwrite;
  assign mst1_slv3_req    = mst1_slv3_sel;
end
else begin : gen_m1s3_nonexistent
     assign mst1_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs3_hready  = 1'b0;
     assign mst1_hs3_hresp   = 2'h0;
     assign mst1_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv3_size   = 4'h0;
     assign mst1_slv3_grant  = 1'b0;
     assign hm1_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv3_hburst = 3'h0;
     assign mst1_slv3_hprot  = 4'h0;
     assign mst1_slv3_hsize  = 3'h0;
     assign mst1_slv3_htrans = 2'h0;
     assign mst1_slv3_hwrite = 1'b0;
     assign mst1_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S3) begin : gen_m2s3
  assign mst2_hs3_hrdata  = hs3_hrdata;
  assign mst2_hs3_hready  = hs3_hready;
  assign mst2_hs3_hresp   = hs3_hresp;
  assign mst2_slv3_base   = slv3_base;
  assign mst2_slv3_size   = slv3_size;
  assign mst2_slv3_grant  = mst2_slv3_ack;
  assign hm2_slv3_hwdata  = hm2_hwdata;
  assign mst2_slv3_haddr  = mst2_haddr;
  assign mst2_slv3_hburst = mst2_hburst;
  assign mst2_slv3_hprot  = mst2_hprot;
  assign mst2_slv3_hsize  = mst2_hsize;
  assign mst2_slv3_htrans = mst2_htrans;
  assign mst2_slv3_hwrite = mst2_hwrite;
  assign mst2_slv3_req    = mst2_slv3_sel;
end
else begin : gen_m2s3_nonexistent
     assign mst2_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs3_hready  = 1'b0;
     assign mst2_hs3_hresp   = 2'h0;
     assign mst2_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv3_size   = 4'h0;
     assign mst2_slv3_grant  = 1'b0;
     assign hm2_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv3_hburst = 3'h0;
     assign mst2_slv3_hprot  = 4'h0;
     assign mst2_slv3_hsize  = 3'h0;
     assign mst2_slv3_htrans = 2'h0;
     assign mst2_slv3_hwrite = 1'b0;
     assign mst2_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S3) begin : gen_m3s3
  assign mst3_hs3_hrdata  = hs3_hrdata;
  assign mst3_hs3_hready  = hs3_hready;
  assign mst3_hs3_hresp   = hs3_hresp;
  assign mst3_slv3_base   = slv3_base;
  assign mst3_slv3_size   = slv3_size;
  assign mst3_slv3_grant  = mst3_slv3_ack;
  assign hm3_slv3_hwdata  = hm3_hwdata;
  assign mst3_slv3_haddr  = mst3_haddr;
  assign mst3_slv3_hburst = mst3_hburst;
  assign mst3_slv3_hprot  = mst3_hprot;
  assign mst3_slv3_hsize  = mst3_hsize;
  assign mst3_slv3_htrans = mst3_htrans;
  assign mst3_slv3_hwrite = mst3_hwrite;
  assign mst3_slv3_req    = mst3_slv3_sel;
end
else begin : gen_m3s3_nonexistent
     assign mst3_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs3_hready  = 1'b0;
     assign mst3_hs3_hresp   = 2'h0;
     assign mst3_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv3_size   = 4'h0;
     assign mst3_slv3_grant  = 1'b0;
     assign hm3_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv3_hburst = 3'h0;
     assign mst3_slv3_hprot  = 4'h0;
     assign mst3_slv3_hsize  = 3'h0;
     assign mst3_slv3_htrans = 2'h0;
     assign mst3_slv3_hwrite = 1'b0;
     assign mst3_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S3) begin : gen_m4s3
  assign mst4_hs3_hrdata  = hs3_hrdata;
  assign mst4_hs3_hready  = hs3_hready;
  assign mst4_hs3_hresp   = hs3_hresp;
  assign mst4_slv3_base   = slv3_base;
  assign mst4_slv3_size   = slv3_size;
  assign mst4_slv3_grant  = mst4_slv3_ack;
  assign hm4_slv3_hwdata  = hm4_hwdata;
  assign mst4_slv3_haddr  = mst4_haddr;
  assign mst4_slv3_hburst = mst4_hburst;
  assign mst4_slv3_hprot  = mst4_hprot;
  assign mst4_slv3_hsize  = mst4_hsize;
  assign mst4_slv3_htrans = mst4_htrans;
  assign mst4_slv3_hwrite = mst4_hwrite;
  assign mst4_slv3_req    = mst4_slv3_sel;
end
else begin : gen_m4s3_nonexistent
     assign mst4_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs3_hready  = 1'b0;
     assign mst4_hs3_hresp   = 2'h0;
     assign mst4_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv3_size   = 4'h0;
     assign mst4_slv3_grant  = 1'b0;
     assign hm4_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv3_hburst = 3'h0;
     assign mst4_slv3_hprot  = 4'h0;
     assign mst4_slv3_hsize  = 3'h0;
     assign mst4_slv3_htrans = 2'h0;
     assign mst4_slv3_hwrite = 1'b0;
     assign mst4_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S3) begin : gen_m5s3
  assign mst5_hs3_hrdata  = hs3_hrdata;
  assign mst5_hs3_hready  = hs3_hready;
  assign mst5_hs3_hresp   = hs3_hresp;
  assign mst5_slv3_base   = slv3_base;
  assign mst5_slv3_size   = slv3_size;
  assign mst5_slv3_grant  = mst5_slv3_ack;
  assign hm5_slv3_hwdata  = hm5_hwdata;
  assign mst5_slv3_haddr  = mst5_haddr;
  assign mst5_slv3_hburst = mst5_hburst;
  assign mst5_slv3_hprot  = mst5_hprot;
  assign mst5_slv3_hsize  = mst5_hsize;
  assign mst5_slv3_htrans = mst5_htrans;
  assign mst5_slv3_hwrite = mst5_hwrite;
  assign mst5_slv3_req    = mst5_slv3_sel;
end
else begin : gen_m5s3_nonexistent
     assign mst5_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs3_hready  = 1'b0;
     assign mst5_hs3_hresp   = 2'h0;
     assign mst5_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv3_size   = 4'h0;
     assign mst5_slv3_grant  = 1'b0;
     assign hm5_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv3_hburst = 3'h0;
     assign mst5_slv3_hprot  = 4'h0;
     assign mst5_slv3_hsize  = 3'h0;
     assign mst5_slv3_htrans = 2'h0;
     assign mst5_slv3_hwrite = 1'b0;
     assign mst5_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S3) begin : gen_m6s3
  assign mst6_hs3_hrdata  = hs3_hrdata;
  assign mst6_hs3_hready  = hs3_hready;
  assign mst6_hs3_hresp   = hs3_hresp;
  assign mst6_slv3_base   = slv3_base;
  assign mst6_slv3_size   = slv3_size;
  assign mst6_slv3_grant  = mst6_slv3_ack;
  assign hm6_slv3_hwdata  = hm6_hwdata;
  assign mst6_slv3_haddr  = mst6_haddr;
  assign mst6_slv3_hburst = mst6_hburst;
  assign mst6_slv3_hprot  = mst6_hprot;
  assign mst6_slv3_hsize  = mst6_hsize;
  assign mst6_slv3_htrans = mst6_htrans;
  assign mst6_slv3_hwrite = mst6_hwrite;
  assign mst6_slv3_req    = mst6_slv3_sel;
end
else begin : gen_m6s3_nonexistent
     assign mst6_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs3_hready  = 1'b0;
     assign mst6_hs3_hresp   = 2'h0;
     assign mst6_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv3_size   = 4'h0;
     assign mst6_slv3_grant  = 1'b0;
     assign hm6_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv3_hburst = 3'h0;
     assign mst6_slv3_hprot  = 4'h0;
     assign mst6_slv3_hsize  = 3'h0;
     assign mst6_slv3_htrans = 2'h0;
     assign mst6_slv3_hwrite = 1'b0;
     assign mst6_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S3) begin : gen_m7s3
  assign mst7_hs3_hrdata  = hs3_hrdata;
  assign mst7_hs3_hready  = hs3_hready;
  assign mst7_hs3_hresp   = hs3_hresp;
  assign mst7_slv3_base   = slv3_base;
  assign mst7_slv3_size   = slv3_size;
  assign mst7_slv3_grant  = mst7_slv3_ack;
  assign hm7_slv3_hwdata  = hm7_hwdata;
  assign mst7_slv3_haddr  = mst7_haddr;
  assign mst7_slv3_hburst = mst7_hburst;
  assign mst7_slv3_hprot  = mst7_hprot;
  assign mst7_slv3_hsize  = mst7_hsize;
  assign mst7_slv3_htrans = mst7_htrans;
  assign mst7_slv3_hwrite = mst7_hwrite;
  assign mst7_slv3_req    = mst7_slv3_sel;
end
else begin : gen_m7s3_nonexistent
     assign mst7_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs3_hready  = 1'b0;
     assign mst7_hs3_hresp   = 2'h0;
     assign mst7_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv3_size   = 4'h0;
     assign mst7_slv3_grant  = 1'b0;
     assign hm7_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv3_hburst = 3'h0;
     assign mst7_slv3_hprot  = 4'h0;
     assign mst7_slv3_hsize  = 3'h0;
     assign mst7_slv3_htrans = 2'h0;
     assign mst7_slv3_hwrite = 1'b0;
     assign mst7_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S3) begin : gen_m8s3
  assign mst8_hs3_hrdata  = hs3_hrdata;
  assign mst8_hs3_hready  = hs3_hready;
  assign mst8_hs3_hresp   = hs3_hresp;
  assign mst8_slv3_base   = slv3_base;
  assign mst8_slv3_size   = slv3_size;
  assign mst8_slv3_grant  = mst8_slv3_ack;
  assign hm8_slv3_hwdata  = hm8_hwdata;
  assign mst8_slv3_haddr  = mst8_haddr;
  assign mst8_slv3_hburst = mst8_hburst;
  assign mst8_slv3_hprot  = mst8_hprot;
  assign mst8_slv3_hsize  = mst8_hsize;
  assign mst8_slv3_htrans = mst8_htrans;
  assign mst8_slv3_hwrite = mst8_hwrite;
  assign mst8_slv3_req    = mst8_slv3_sel;
end
else begin : gen_m8s3_nonexistent
     assign mst8_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs3_hready  = 1'b0;
     assign mst8_hs3_hresp   = 2'h0;
     assign mst8_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv3_size   = 4'h0;
     assign mst8_slv3_grant  = 1'b0;
     assign hm8_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv3_hburst = 3'h0;
     assign mst8_slv3_hprot  = 4'h0;
     assign mst8_slv3_hsize  = 3'h0;
     assign mst8_slv3_htrans = 2'h0;
     assign mst8_slv3_hwrite = 1'b0;
     assign mst8_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S3) begin : gen_m9s3
  assign mst9_hs3_hrdata  = hs3_hrdata;
  assign mst9_hs3_hready  = hs3_hready;
  assign mst9_hs3_hresp   = hs3_hresp;
  assign mst9_slv3_base   = slv3_base;
  assign mst9_slv3_size   = slv3_size;
  assign mst9_slv3_grant  = mst9_slv3_ack;
  assign hm9_slv3_hwdata  = hm9_hwdata;
  assign mst9_slv3_haddr  = mst9_haddr;
  assign mst9_slv3_hburst = mst9_hburst;
  assign mst9_slv3_hprot  = mst9_hprot;
  assign mst9_slv3_hsize  = mst9_hsize;
  assign mst9_slv3_htrans = mst9_htrans;
  assign mst9_slv3_hwrite = mst9_hwrite;
  assign mst9_slv3_req    = mst9_slv3_sel;
end
else begin : gen_m9s3_nonexistent
     assign mst9_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs3_hready  = 1'b0;
     assign mst9_hs3_hresp   = 2'h0;
     assign mst9_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv3_size   = 4'h0;
     assign mst9_slv3_grant  = 1'b0;
     assign hm9_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv3_hburst = 3'h0;
     assign mst9_slv3_hprot  = 4'h0;
     assign mst9_slv3_hsize  = 3'h0;
     assign mst9_slv3_htrans = 2'h0;
     assign mst9_slv3_hwrite = 1'b0;
     assign mst9_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S3) begin : gen_m10s3
  assign mst10_hs3_hrdata  = hs3_hrdata;
  assign mst10_hs3_hready  = hs3_hready;
  assign mst10_hs3_hresp   = hs3_hresp;
  assign mst10_slv3_base   = slv3_base;
  assign mst10_slv3_size   = slv3_size;
  assign mst10_slv3_grant  = mst10_slv3_ack;
  assign hm10_slv3_hwdata  = hm10_hwdata;
  assign mst10_slv3_haddr  = mst10_haddr;
  assign mst10_slv3_hburst = mst10_hburst;
  assign mst10_slv3_hprot  = mst10_hprot;
  assign mst10_slv3_hsize  = mst10_hsize;
  assign mst10_slv3_htrans = mst10_htrans;
  assign mst10_slv3_hwrite = mst10_hwrite;
  assign mst10_slv3_req    = mst10_slv3_sel;
end
else begin : gen_m10s3_nonexistent
     assign mst10_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs3_hready  = 1'b0;
     assign mst10_hs3_hresp   = 2'h0;
     assign mst10_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv3_size   = 4'h0;
     assign mst10_slv3_grant  = 1'b0;
     assign hm10_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv3_hburst = 3'h0;
     assign mst10_slv3_hprot  = 4'h0;
     assign mst10_slv3_hsize  = 3'h0;
     assign mst10_slv3_htrans = 2'h0;
     assign mst10_slv3_hwrite = 1'b0;
     assign mst10_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S3) begin : gen_m11s3
  assign mst11_hs3_hrdata  = hs3_hrdata;
  assign mst11_hs3_hready  = hs3_hready;
  assign mst11_hs3_hresp   = hs3_hresp;
  assign mst11_slv3_base   = slv3_base;
  assign mst11_slv3_size   = slv3_size;
  assign mst11_slv3_grant  = mst11_slv3_ack;
  assign hm11_slv3_hwdata  = hm11_hwdata;
  assign mst11_slv3_haddr  = mst11_haddr;
  assign mst11_slv3_hburst = mst11_hburst;
  assign mst11_slv3_hprot  = mst11_hprot;
  assign mst11_slv3_hsize  = mst11_hsize;
  assign mst11_slv3_htrans = mst11_htrans;
  assign mst11_slv3_hwrite = mst11_hwrite;
  assign mst11_slv3_req    = mst11_slv3_sel;
end
else begin : gen_m11s3_nonexistent
     assign mst11_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs3_hready  = 1'b0;
     assign mst11_hs3_hresp   = 2'h0;
     assign mst11_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv3_size   = 4'h0;
     assign mst11_slv3_grant  = 1'b0;
     assign hm11_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv3_hburst = 3'h0;
     assign mst11_slv3_hprot  = 4'h0;
     assign mst11_slv3_hsize  = 3'h0;
     assign mst11_slv3_htrans = 2'h0;
     assign mst11_slv3_hwrite = 1'b0;
     assign mst11_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S3) begin : gen_m12s3
  assign mst12_hs3_hrdata  = hs3_hrdata;
  assign mst12_hs3_hready  = hs3_hready;
  assign mst12_hs3_hresp   = hs3_hresp;
  assign mst12_slv3_base   = slv3_base;
  assign mst12_slv3_size   = slv3_size;
  assign mst12_slv3_grant  = mst12_slv3_ack;
  assign hm12_slv3_hwdata  = hm12_hwdata;
  assign mst12_slv3_haddr  = mst12_haddr;
  assign mst12_slv3_hburst = mst12_hburst;
  assign mst12_slv3_hprot  = mst12_hprot;
  assign mst12_slv3_hsize  = mst12_hsize;
  assign mst12_slv3_htrans = mst12_htrans;
  assign mst12_slv3_hwrite = mst12_hwrite;
  assign mst12_slv3_req    = mst12_slv3_sel;
end
else begin : gen_m12s3_nonexistent
     assign mst12_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs3_hready  = 1'b0;
     assign mst12_hs3_hresp   = 2'h0;
     assign mst12_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv3_size   = 4'h0;
     assign mst12_slv3_grant  = 1'b0;
     assign hm12_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv3_hburst = 3'h0;
     assign mst12_slv3_hprot  = 4'h0;
     assign mst12_slv3_hsize  = 3'h0;
     assign mst12_slv3_htrans = 2'h0;
     assign mst12_slv3_hwrite = 1'b0;
     assign mst12_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S3) begin : gen_m13s3
  assign mst13_hs3_hrdata  = hs3_hrdata;
  assign mst13_hs3_hready  = hs3_hready;
  assign mst13_hs3_hresp   = hs3_hresp;
  assign mst13_slv3_base   = slv3_base;
  assign mst13_slv3_size   = slv3_size;
  assign mst13_slv3_grant  = mst13_slv3_ack;
  assign hm13_slv3_hwdata  = hm13_hwdata;
  assign mst13_slv3_haddr  = mst13_haddr;
  assign mst13_slv3_hburst = mst13_hburst;
  assign mst13_slv3_hprot  = mst13_hprot;
  assign mst13_slv3_hsize  = mst13_hsize;
  assign mst13_slv3_htrans = mst13_htrans;
  assign mst13_slv3_hwrite = mst13_hwrite;
  assign mst13_slv3_req    = mst13_slv3_sel;
end
else begin : gen_m13s3_nonexistent
     assign mst13_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs3_hready  = 1'b0;
     assign mst13_hs3_hresp   = 2'h0;
     assign mst13_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv3_size   = 4'h0;
     assign mst13_slv3_grant  = 1'b0;
     assign hm13_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv3_hburst = 3'h0;
     assign mst13_slv3_hprot  = 4'h0;
     assign mst13_slv3_hsize  = 3'h0;
     assign mst13_slv3_htrans = 2'h0;
     assign mst13_slv3_hwrite = 1'b0;
     assign mst13_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S3) begin : gen_m14s3
  assign mst14_hs3_hrdata  = hs3_hrdata;
  assign mst14_hs3_hready  = hs3_hready;
  assign mst14_hs3_hresp   = hs3_hresp;
  assign mst14_slv3_base   = slv3_base;
  assign mst14_slv3_size   = slv3_size;
  assign mst14_slv3_grant  = mst14_slv3_ack;
  assign hm14_slv3_hwdata  = hm14_hwdata;
  assign mst14_slv3_haddr  = mst14_haddr;
  assign mst14_slv3_hburst = mst14_hburst;
  assign mst14_slv3_hprot  = mst14_hprot;
  assign mst14_slv3_hsize  = mst14_hsize;
  assign mst14_slv3_htrans = mst14_htrans;
  assign mst14_slv3_hwrite = mst14_hwrite;
  assign mst14_slv3_req    = mst14_slv3_sel;
end
else begin : gen_m14s3_nonexistent
     assign mst14_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs3_hready  = 1'b0;
     assign mst14_hs3_hresp   = 2'h0;
     assign mst14_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv3_size   = 4'h0;
     assign mst14_slv3_grant  = 1'b0;
     assign hm14_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv3_hburst = 3'h0;
     assign mst14_slv3_hprot  = 4'h0;
     assign mst14_slv3_hsize  = 3'h0;
     assign mst14_slv3_htrans = 2'h0;
     assign mst14_slv3_hwrite = 1'b0;
     assign mst14_slv3_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S3) begin : gen_m15s3
  assign mst15_hs3_hrdata  = hs3_hrdata;
  assign mst15_hs3_hready  = hs3_hready;
  assign mst15_hs3_hresp   = hs3_hresp;
  assign mst15_slv3_base   = slv3_base;
  assign mst15_slv3_size   = slv3_size;
  assign mst15_slv3_grant  = mst15_slv3_ack;
  assign hm15_slv3_hwdata  = hm15_hwdata;
  assign mst15_slv3_haddr  = mst15_haddr;
  assign mst15_slv3_hburst = mst15_hburst;
  assign mst15_slv3_hprot  = mst15_hprot;
  assign mst15_slv3_hsize  = mst15_hsize;
  assign mst15_slv3_htrans = mst15_htrans;
  assign mst15_slv3_hwrite = mst15_hwrite;
  assign mst15_slv3_req    = mst15_slv3_sel;
end
else begin : gen_m15s3_nonexistent
     assign mst15_hs3_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs3_hready  = 1'b0;
     assign mst15_hs3_hresp   = 2'h0;
     assign mst15_slv3_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv3_size   = 4'h0;
     assign mst15_slv3_grant  = 1'b0;
     assign hm15_slv3_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv3_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv3_hburst = 3'h0;
     assign mst15_slv3_hprot  = 4'h0;
     assign mst15_slv3_hsize  = 3'h0;
     assign mst15_slv3_htrans = 2'h0;
     assign mst15_slv3_hwrite = 1'b0;
     assign mst15_slv3_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV4
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S4) begin : gen_m0s4
  assign mst0_hs4_hrdata  = hs4_hrdata;
  assign mst0_hs4_hready  = hs4_hready;
  assign mst0_hs4_hresp   = hs4_hresp;
  assign mst0_slv4_base   = slv4_base;
  assign mst0_slv4_size   = slv4_size;
  assign mst0_slv4_grant  = mst0_slv4_ack;
  assign hm0_slv4_hwdata  = hm0_hwdata;
  assign mst0_slv4_haddr  = mst0_haddr;
  assign mst0_slv4_hburst = mst0_hburst;
  assign mst0_slv4_hprot  = mst0_hprot;
  assign mst0_slv4_hsize  = mst0_hsize;
  assign mst0_slv4_htrans = mst0_htrans;
  assign mst0_slv4_hwrite = mst0_hwrite;
  assign mst0_slv4_req    = mst0_slv4_sel;
end
else begin : gen_m0s4_nonexistent
     assign mst0_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs4_hready  = 1'b0;
     assign mst0_hs4_hresp   = 2'h0;
     assign mst0_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv4_size   = 4'h0;
     assign mst0_slv4_grant  = 1'b0;
     assign hm0_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv4_hburst = 3'h0;
     assign mst0_slv4_hprot  = 4'h0;
     assign mst0_slv4_hsize  = 3'h0;
     assign mst0_slv4_htrans = 2'h0;
     assign mst0_slv4_hwrite = 1'b0;
     assign mst0_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S4) begin : gen_m1s4
  assign mst1_hs4_hrdata  = hs4_hrdata;
  assign mst1_hs4_hready  = hs4_hready;
  assign mst1_hs4_hresp   = hs4_hresp;
  assign mst1_slv4_base   = slv4_base;
  assign mst1_slv4_size   = slv4_size;
  assign mst1_slv4_grant  = mst1_slv4_ack;
  assign hm1_slv4_hwdata  = hm1_hwdata;
  assign mst1_slv4_haddr  = mst1_haddr;
  assign mst1_slv4_hburst = mst1_hburst;
  assign mst1_slv4_hprot  = mst1_hprot;
  assign mst1_slv4_hsize  = mst1_hsize;
  assign mst1_slv4_htrans = mst1_htrans;
  assign mst1_slv4_hwrite = mst1_hwrite;
  assign mst1_slv4_req    = mst1_slv4_sel;
end
else begin : gen_m1s4_nonexistent
     assign mst1_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs4_hready  = 1'b0;
     assign mst1_hs4_hresp   = 2'h0;
     assign mst1_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv4_size   = 4'h0;
     assign mst1_slv4_grant  = 1'b0;
     assign hm1_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv4_hburst = 3'h0;
     assign mst1_slv4_hprot  = 4'h0;
     assign mst1_slv4_hsize  = 3'h0;
     assign mst1_slv4_htrans = 2'h0;
     assign mst1_slv4_hwrite = 1'b0;
     assign mst1_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S4) begin : gen_m2s4
  assign mst2_hs4_hrdata  = hs4_hrdata;
  assign mst2_hs4_hready  = hs4_hready;
  assign mst2_hs4_hresp   = hs4_hresp;
  assign mst2_slv4_base   = slv4_base;
  assign mst2_slv4_size   = slv4_size;
  assign mst2_slv4_grant  = mst2_slv4_ack;
  assign hm2_slv4_hwdata  = hm2_hwdata;
  assign mst2_slv4_haddr  = mst2_haddr;
  assign mst2_slv4_hburst = mst2_hburst;
  assign mst2_slv4_hprot  = mst2_hprot;
  assign mst2_slv4_hsize  = mst2_hsize;
  assign mst2_slv4_htrans = mst2_htrans;
  assign mst2_slv4_hwrite = mst2_hwrite;
  assign mst2_slv4_req    = mst2_slv4_sel;
end
else begin : gen_m2s4_nonexistent
     assign mst2_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs4_hready  = 1'b0;
     assign mst2_hs4_hresp   = 2'h0;
     assign mst2_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv4_size   = 4'h0;
     assign mst2_slv4_grant  = 1'b0;
     assign hm2_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv4_hburst = 3'h0;
     assign mst2_slv4_hprot  = 4'h0;
     assign mst2_slv4_hsize  = 3'h0;
     assign mst2_slv4_htrans = 2'h0;
     assign mst2_slv4_hwrite = 1'b0;
     assign mst2_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S4) begin : gen_m3s4
  assign mst3_hs4_hrdata  = hs4_hrdata;
  assign mst3_hs4_hready  = hs4_hready;
  assign mst3_hs4_hresp   = hs4_hresp;
  assign mst3_slv4_base   = slv4_base;
  assign mst3_slv4_size   = slv4_size;
  assign mst3_slv4_grant  = mst3_slv4_ack;
  assign hm3_slv4_hwdata  = hm3_hwdata;
  assign mst3_slv4_haddr  = mst3_haddr;
  assign mst3_slv4_hburst = mst3_hburst;
  assign mst3_slv4_hprot  = mst3_hprot;
  assign mst3_slv4_hsize  = mst3_hsize;
  assign mst3_slv4_htrans = mst3_htrans;
  assign mst3_slv4_hwrite = mst3_hwrite;
  assign mst3_slv4_req    = mst3_slv4_sel;
end
else begin : gen_m3s4_nonexistent
     assign mst3_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs4_hready  = 1'b0;
     assign mst3_hs4_hresp   = 2'h0;
     assign mst3_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv4_size   = 4'h0;
     assign mst3_slv4_grant  = 1'b0;
     assign hm3_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv4_hburst = 3'h0;
     assign mst3_slv4_hprot  = 4'h0;
     assign mst3_slv4_hsize  = 3'h0;
     assign mst3_slv4_htrans = 2'h0;
     assign mst3_slv4_hwrite = 1'b0;
     assign mst3_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S4) begin : gen_m4s4
  assign mst4_hs4_hrdata  = hs4_hrdata;
  assign mst4_hs4_hready  = hs4_hready;
  assign mst4_hs4_hresp   = hs4_hresp;
  assign mst4_slv4_base   = slv4_base;
  assign mst4_slv4_size   = slv4_size;
  assign mst4_slv4_grant  = mst4_slv4_ack;
  assign hm4_slv4_hwdata  = hm4_hwdata;
  assign mst4_slv4_haddr  = mst4_haddr;
  assign mst4_slv4_hburst = mst4_hburst;
  assign mst4_slv4_hprot  = mst4_hprot;
  assign mst4_slv4_hsize  = mst4_hsize;
  assign mst4_slv4_htrans = mst4_htrans;
  assign mst4_slv4_hwrite = mst4_hwrite;
  assign mst4_slv4_req    = mst4_slv4_sel;
end
else begin : gen_m4s4_nonexistent
     assign mst4_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs4_hready  = 1'b0;
     assign mst4_hs4_hresp   = 2'h0;
     assign mst4_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv4_size   = 4'h0;
     assign mst4_slv4_grant  = 1'b0;
     assign hm4_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv4_hburst = 3'h0;
     assign mst4_slv4_hprot  = 4'h0;
     assign mst4_slv4_hsize  = 3'h0;
     assign mst4_slv4_htrans = 2'h0;
     assign mst4_slv4_hwrite = 1'b0;
     assign mst4_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S4) begin : gen_m5s4
  assign mst5_hs4_hrdata  = hs4_hrdata;
  assign mst5_hs4_hready  = hs4_hready;
  assign mst5_hs4_hresp   = hs4_hresp;
  assign mst5_slv4_base   = slv4_base;
  assign mst5_slv4_size   = slv4_size;
  assign mst5_slv4_grant  = mst5_slv4_ack;
  assign hm5_slv4_hwdata  = hm5_hwdata;
  assign mst5_slv4_haddr  = mst5_haddr;
  assign mst5_slv4_hburst = mst5_hburst;
  assign mst5_slv4_hprot  = mst5_hprot;
  assign mst5_slv4_hsize  = mst5_hsize;
  assign mst5_slv4_htrans = mst5_htrans;
  assign mst5_slv4_hwrite = mst5_hwrite;
  assign mst5_slv4_req    = mst5_slv4_sel;
end
else begin : gen_m5s4_nonexistent
     assign mst5_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs4_hready  = 1'b0;
     assign mst5_hs4_hresp   = 2'h0;
     assign mst5_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv4_size   = 4'h0;
     assign mst5_slv4_grant  = 1'b0;
     assign hm5_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv4_hburst = 3'h0;
     assign mst5_slv4_hprot  = 4'h0;
     assign mst5_slv4_hsize  = 3'h0;
     assign mst5_slv4_htrans = 2'h0;
     assign mst5_slv4_hwrite = 1'b0;
     assign mst5_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S4) begin : gen_m6s4
  assign mst6_hs4_hrdata  = hs4_hrdata;
  assign mst6_hs4_hready  = hs4_hready;
  assign mst6_hs4_hresp   = hs4_hresp;
  assign mst6_slv4_base   = slv4_base;
  assign mst6_slv4_size   = slv4_size;
  assign mst6_slv4_grant  = mst6_slv4_ack;
  assign hm6_slv4_hwdata  = hm6_hwdata;
  assign mst6_slv4_haddr  = mst6_haddr;
  assign mst6_slv4_hburst = mst6_hburst;
  assign mst6_slv4_hprot  = mst6_hprot;
  assign mst6_slv4_hsize  = mst6_hsize;
  assign mst6_slv4_htrans = mst6_htrans;
  assign mst6_slv4_hwrite = mst6_hwrite;
  assign mst6_slv4_req    = mst6_slv4_sel;
end
else begin : gen_m6s4_nonexistent
     assign mst6_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs4_hready  = 1'b0;
     assign mst6_hs4_hresp   = 2'h0;
     assign mst6_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv4_size   = 4'h0;
     assign mst6_slv4_grant  = 1'b0;
     assign hm6_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv4_hburst = 3'h0;
     assign mst6_slv4_hprot  = 4'h0;
     assign mst6_slv4_hsize  = 3'h0;
     assign mst6_slv4_htrans = 2'h0;
     assign mst6_slv4_hwrite = 1'b0;
     assign mst6_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S4) begin : gen_m7s4
  assign mst7_hs4_hrdata  = hs4_hrdata;
  assign mst7_hs4_hready  = hs4_hready;
  assign mst7_hs4_hresp   = hs4_hresp;
  assign mst7_slv4_base   = slv4_base;
  assign mst7_slv4_size   = slv4_size;
  assign mst7_slv4_grant  = mst7_slv4_ack;
  assign hm7_slv4_hwdata  = hm7_hwdata;
  assign mst7_slv4_haddr  = mst7_haddr;
  assign mst7_slv4_hburst = mst7_hburst;
  assign mst7_slv4_hprot  = mst7_hprot;
  assign mst7_slv4_hsize  = mst7_hsize;
  assign mst7_slv4_htrans = mst7_htrans;
  assign mst7_slv4_hwrite = mst7_hwrite;
  assign mst7_slv4_req    = mst7_slv4_sel;
end
else begin : gen_m7s4_nonexistent
     assign mst7_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs4_hready  = 1'b0;
     assign mst7_hs4_hresp   = 2'h0;
     assign mst7_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv4_size   = 4'h0;
     assign mst7_slv4_grant  = 1'b0;
     assign hm7_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv4_hburst = 3'h0;
     assign mst7_slv4_hprot  = 4'h0;
     assign mst7_slv4_hsize  = 3'h0;
     assign mst7_slv4_htrans = 2'h0;
     assign mst7_slv4_hwrite = 1'b0;
     assign mst7_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S4) begin : gen_m8s4
  assign mst8_hs4_hrdata  = hs4_hrdata;
  assign mst8_hs4_hready  = hs4_hready;
  assign mst8_hs4_hresp   = hs4_hresp;
  assign mst8_slv4_base   = slv4_base;
  assign mst8_slv4_size   = slv4_size;
  assign mst8_slv4_grant  = mst8_slv4_ack;
  assign hm8_slv4_hwdata  = hm8_hwdata;
  assign mst8_slv4_haddr  = mst8_haddr;
  assign mst8_slv4_hburst = mst8_hburst;
  assign mst8_slv4_hprot  = mst8_hprot;
  assign mst8_slv4_hsize  = mst8_hsize;
  assign mst8_slv4_htrans = mst8_htrans;
  assign mst8_slv4_hwrite = mst8_hwrite;
  assign mst8_slv4_req    = mst8_slv4_sel;
end
else begin : gen_m8s4_nonexistent
     assign mst8_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs4_hready  = 1'b0;
     assign mst8_hs4_hresp   = 2'h0;
     assign mst8_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv4_size   = 4'h0;
     assign mst8_slv4_grant  = 1'b0;
     assign hm8_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv4_hburst = 3'h0;
     assign mst8_slv4_hprot  = 4'h0;
     assign mst8_slv4_hsize  = 3'h0;
     assign mst8_slv4_htrans = 2'h0;
     assign mst8_slv4_hwrite = 1'b0;
     assign mst8_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S4) begin : gen_m9s4
  assign mst9_hs4_hrdata  = hs4_hrdata;
  assign mst9_hs4_hready  = hs4_hready;
  assign mst9_hs4_hresp   = hs4_hresp;
  assign mst9_slv4_base   = slv4_base;
  assign mst9_slv4_size   = slv4_size;
  assign mst9_slv4_grant  = mst9_slv4_ack;
  assign hm9_slv4_hwdata  = hm9_hwdata;
  assign mst9_slv4_haddr  = mst9_haddr;
  assign mst9_slv4_hburst = mst9_hburst;
  assign mst9_slv4_hprot  = mst9_hprot;
  assign mst9_slv4_hsize  = mst9_hsize;
  assign mst9_slv4_htrans = mst9_htrans;
  assign mst9_slv4_hwrite = mst9_hwrite;
  assign mst9_slv4_req    = mst9_slv4_sel;
end
else begin : gen_m9s4_nonexistent
     assign mst9_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs4_hready  = 1'b0;
     assign mst9_hs4_hresp   = 2'h0;
     assign mst9_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv4_size   = 4'h0;
     assign mst9_slv4_grant  = 1'b0;
     assign hm9_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv4_hburst = 3'h0;
     assign mst9_slv4_hprot  = 4'h0;
     assign mst9_slv4_hsize  = 3'h0;
     assign mst9_slv4_htrans = 2'h0;
     assign mst9_slv4_hwrite = 1'b0;
     assign mst9_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S4) begin : gen_m10s4
  assign mst10_hs4_hrdata  = hs4_hrdata;
  assign mst10_hs4_hready  = hs4_hready;
  assign mst10_hs4_hresp   = hs4_hresp;
  assign mst10_slv4_base   = slv4_base;
  assign mst10_slv4_size   = slv4_size;
  assign mst10_slv4_grant  = mst10_slv4_ack;
  assign hm10_slv4_hwdata  = hm10_hwdata;
  assign mst10_slv4_haddr  = mst10_haddr;
  assign mst10_slv4_hburst = mst10_hburst;
  assign mst10_slv4_hprot  = mst10_hprot;
  assign mst10_slv4_hsize  = mst10_hsize;
  assign mst10_slv4_htrans = mst10_htrans;
  assign mst10_slv4_hwrite = mst10_hwrite;
  assign mst10_slv4_req    = mst10_slv4_sel;
end
else begin : gen_m10s4_nonexistent
     assign mst10_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs4_hready  = 1'b0;
     assign mst10_hs4_hresp   = 2'h0;
     assign mst10_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv4_size   = 4'h0;
     assign mst10_slv4_grant  = 1'b0;
     assign hm10_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv4_hburst = 3'h0;
     assign mst10_slv4_hprot  = 4'h0;
     assign mst10_slv4_hsize  = 3'h0;
     assign mst10_slv4_htrans = 2'h0;
     assign mst10_slv4_hwrite = 1'b0;
     assign mst10_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S4) begin : gen_m11s4
  assign mst11_hs4_hrdata  = hs4_hrdata;
  assign mst11_hs4_hready  = hs4_hready;
  assign mst11_hs4_hresp   = hs4_hresp;
  assign mst11_slv4_base   = slv4_base;
  assign mst11_slv4_size   = slv4_size;
  assign mst11_slv4_grant  = mst11_slv4_ack;
  assign hm11_slv4_hwdata  = hm11_hwdata;
  assign mst11_slv4_haddr  = mst11_haddr;
  assign mst11_slv4_hburst = mst11_hburst;
  assign mst11_slv4_hprot  = mst11_hprot;
  assign mst11_slv4_hsize  = mst11_hsize;
  assign mst11_slv4_htrans = mst11_htrans;
  assign mst11_slv4_hwrite = mst11_hwrite;
  assign mst11_slv4_req    = mst11_slv4_sel;
end
else begin : gen_m11s4_nonexistent
     assign mst11_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs4_hready  = 1'b0;
     assign mst11_hs4_hresp   = 2'h0;
     assign mst11_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv4_size   = 4'h0;
     assign mst11_slv4_grant  = 1'b0;
     assign hm11_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv4_hburst = 3'h0;
     assign mst11_slv4_hprot  = 4'h0;
     assign mst11_slv4_hsize  = 3'h0;
     assign mst11_slv4_htrans = 2'h0;
     assign mst11_slv4_hwrite = 1'b0;
     assign mst11_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S4) begin : gen_m12s4
  assign mst12_hs4_hrdata  = hs4_hrdata;
  assign mst12_hs4_hready  = hs4_hready;
  assign mst12_hs4_hresp   = hs4_hresp;
  assign mst12_slv4_base   = slv4_base;
  assign mst12_slv4_size   = slv4_size;
  assign mst12_slv4_grant  = mst12_slv4_ack;
  assign hm12_slv4_hwdata  = hm12_hwdata;
  assign mst12_slv4_haddr  = mst12_haddr;
  assign mst12_slv4_hburst = mst12_hburst;
  assign mst12_slv4_hprot  = mst12_hprot;
  assign mst12_slv4_hsize  = mst12_hsize;
  assign mst12_slv4_htrans = mst12_htrans;
  assign mst12_slv4_hwrite = mst12_hwrite;
  assign mst12_slv4_req    = mst12_slv4_sel;
end
else begin : gen_m12s4_nonexistent
     assign mst12_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs4_hready  = 1'b0;
     assign mst12_hs4_hresp   = 2'h0;
     assign mst12_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv4_size   = 4'h0;
     assign mst12_slv4_grant  = 1'b0;
     assign hm12_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv4_hburst = 3'h0;
     assign mst12_slv4_hprot  = 4'h0;
     assign mst12_slv4_hsize  = 3'h0;
     assign mst12_slv4_htrans = 2'h0;
     assign mst12_slv4_hwrite = 1'b0;
     assign mst12_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S4) begin : gen_m13s4
  assign mst13_hs4_hrdata  = hs4_hrdata;
  assign mst13_hs4_hready  = hs4_hready;
  assign mst13_hs4_hresp   = hs4_hresp;
  assign mst13_slv4_base   = slv4_base;
  assign mst13_slv4_size   = slv4_size;
  assign mst13_slv4_grant  = mst13_slv4_ack;
  assign hm13_slv4_hwdata  = hm13_hwdata;
  assign mst13_slv4_haddr  = mst13_haddr;
  assign mst13_slv4_hburst = mst13_hburst;
  assign mst13_slv4_hprot  = mst13_hprot;
  assign mst13_slv4_hsize  = mst13_hsize;
  assign mst13_slv4_htrans = mst13_htrans;
  assign mst13_slv4_hwrite = mst13_hwrite;
  assign mst13_slv4_req    = mst13_slv4_sel;
end
else begin : gen_m13s4_nonexistent
     assign mst13_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs4_hready  = 1'b0;
     assign mst13_hs4_hresp   = 2'h0;
     assign mst13_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv4_size   = 4'h0;
     assign mst13_slv4_grant  = 1'b0;
     assign hm13_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv4_hburst = 3'h0;
     assign mst13_slv4_hprot  = 4'h0;
     assign mst13_slv4_hsize  = 3'h0;
     assign mst13_slv4_htrans = 2'h0;
     assign mst13_slv4_hwrite = 1'b0;
     assign mst13_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S4) begin : gen_m14s4
  assign mst14_hs4_hrdata  = hs4_hrdata;
  assign mst14_hs4_hready  = hs4_hready;
  assign mst14_hs4_hresp   = hs4_hresp;
  assign mst14_slv4_base   = slv4_base;
  assign mst14_slv4_size   = slv4_size;
  assign mst14_slv4_grant  = mst14_slv4_ack;
  assign hm14_slv4_hwdata  = hm14_hwdata;
  assign mst14_slv4_haddr  = mst14_haddr;
  assign mst14_slv4_hburst = mst14_hburst;
  assign mst14_slv4_hprot  = mst14_hprot;
  assign mst14_slv4_hsize  = mst14_hsize;
  assign mst14_slv4_htrans = mst14_htrans;
  assign mst14_slv4_hwrite = mst14_hwrite;
  assign mst14_slv4_req    = mst14_slv4_sel;
end
else begin : gen_m14s4_nonexistent
     assign mst14_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs4_hready  = 1'b0;
     assign mst14_hs4_hresp   = 2'h0;
     assign mst14_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv4_size   = 4'h0;
     assign mst14_slv4_grant  = 1'b0;
     assign hm14_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv4_hburst = 3'h0;
     assign mst14_slv4_hprot  = 4'h0;
     assign mst14_slv4_hsize  = 3'h0;
     assign mst14_slv4_htrans = 2'h0;
     assign mst14_slv4_hwrite = 1'b0;
     assign mst14_slv4_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S4) begin : gen_m15s4
  assign mst15_hs4_hrdata  = hs4_hrdata;
  assign mst15_hs4_hready  = hs4_hready;
  assign mst15_hs4_hresp   = hs4_hresp;
  assign mst15_slv4_base   = slv4_base;
  assign mst15_slv4_size   = slv4_size;
  assign mst15_slv4_grant  = mst15_slv4_ack;
  assign hm15_slv4_hwdata  = hm15_hwdata;
  assign mst15_slv4_haddr  = mst15_haddr;
  assign mst15_slv4_hburst = mst15_hburst;
  assign mst15_slv4_hprot  = mst15_hprot;
  assign mst15_slv4_hsize  = mst15_hsize;
  assign mst15_slv4_htrans = mst15_htrans;
  assign mst15_slv4_hwrite = mst15_hwrite;
  assign mst15_slv4_req    = mst15_slv4_sel;
end
else begin : gen_m15s4_nonexistent
     assign mst15_hs4_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs4_hready  = 1'b0;
     assign mst15_hs4_hresp   = 2'h0;
     assign mst15_slv4_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv4_size   = 4'h0;
     assign mst15_slv4_grant  = 1'b0;
     assign hm15_slv4_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv4_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv4_hburst = 3'h0;
     assign mst15_slv4_hprot  = 4'h0;
     assign mst15_slv4_hsize  = 3'h0;
     assign mst15_slv4_htrans = 2'h0;
     assign mst15_slv4_hwrite = 1'b0;
     assign mst15_slv4_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV5
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S5) begin : gen_m0s5
  assign mst0_hs5_hrdata  = hs5_hrdata;
  assign mst0_hs5_hready  = hs5_hready;
  assign mst0_hs5_hresp   = hs5_hresp;
  assign mst0_slv5_base   = slv5_base;
  assign mst0_slv5_size   = slv5_size;
  assign mst0_slv5_grant  = mst0_slv5_ack;
  assign hm0_slv5_hwdata  = hm0_hwdata;
  assign mst0_slv5_haddr  = mst0_haddr;
  assign mst0_slv5_hburst = mst0_hburst;
  assign mst0_slv5_hprot  = mst0_hprot;
  assign mst0_slv5_hsize  = mst0_hsize;
  assign mst0_slv5_htrans = mst0_htrans;
  assign mst0_slv5_hwrite = mst0_hwrite;
  assign mst0_slv5_req    = mst0_slv5_sel;
end
else begin : gen_m0s5_nonexistent
     assign mst0_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs5_hready  = 1'b0;
     assign mst0_hs5_hresp   = 2'h0;
     assign mst0_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv5_size   = 4'h0;
     assign mst0_slv5_grant  = 1'b0;
     assign hm0_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv5_hburst = 3'h0;
     assign mst0_slv5_hprot  = 4'h0;
     assign mst0_slv5_hsize  = 3'h0;
     assign mst0_slv5_htrans = 2'h0;
     assign mst0_slv5_hwrite = 1'b0;
     assign mst0_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S5) begin : gen_m1s5
  assign mst1_hs5_hrdata  = hs5_hrdata;
  assign mst1_hs5_hready  = hs5_hready;
  assign mst1_hs5_hresp   = hs5_hresp;
  assign mst1_slv5_base   = slv5_base;
  assign mst1_slv5_size   = slv5_size;
  assign mst1_slv5_grant  = mst1_slv5_ack;
  assign hm1_slv5_hwdata  = hm1_hwdata;
  assign mst1_slv5_haddr  = mst1_haddr;
  assign mst1_slv5_hburst = mst1_hburst;
  assign mst1_slv5_hprot  = mst1_hprot;
  assign mst1_slv5_hsize  = mst1_hsize;
  assign mst1_slv5_htrans = mst1_htrans;
  assign mst1_slv5_hwrite = mst1_hwrite;
  assign mst1_slv5_req    = mst1_slv5_sel;
end
else begin : gen_m1s5_nonexistent
     assign mst1_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs5_hready  = 1'b0;
     assign mst1_hs5_hresp   = 2'h0;
     assign mst1_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv5_size   = 4'h0;
     assign mst1_slv5_grant  = 1'b0;
     assign hm1_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv5_hburst = 3'h0;
     assign mst1_slv5_hprot  = 4'h0;
     assign mst1_slv5_hsize  = 3'h0;
     assign mst1_slv5_htrans = 2'h0;
     assign mst1_slv5_hwrite = 1'b0;
     assign mst1_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S5) begin : gen_m2s5
  assign mst2_hs5_hrdata  = hs5_hrdata;
  assign mst2_hs5_hready  = hs5_hready;
  assign mst2_hs5_hresp   = hs5_hresp;
  assign mst2_slv5_base   = slv5_base;
  assign mst2_slv5_size   = slv5_size;
  assign mst2_slv5_grant  = mst2_slv5_ack;
  assign hm2_slv5_hwdata  = hm2_hwdata;
  assign mst2_slv5_haddr  = mst2_haddr;
  assign mst2_slv5_hburst = mst2_hburst;
  assign mst2_slv5_hprot  = mst2_hprot;
  assign mst2_slv5_hsize  = mst2_hsize;
  assign mst2_slv5_htrans = mst2_htrans;
  assign mst2_slv5_hwrite = mst2_hwrite;
  assign mst2_slv5_req    = mst2_slv5_sel;
end
else begin : gen_m2s5_nonexistent
     assign mst2_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs5_hready  = 1'b0;
     assign mst2_hs5_hresp   = 2'h0;
     assign mst2_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv5_size   = 4'h0;
     assign mst2_slv5_grant  = 1'b0;
     assign hm2_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv5_hburst = 3'h0;
     assign mst2_slv5_hprot  = 4'h0;
     assign mst2_slv5_hsize  = 3'h0;
     assign mst2_slv5_htrans = 2'h0;
     assign mst2_slv5_hwrite = 1'b0;
     assign mst2_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S5) begin : gen_m3s5
  assign mst3_hs5_hrdata  = hs5_hrdata;
  assign mst3_hs5_hready  = hs5_hready;
  assign mst3_hs5_hresp   = hs5_hresp;
  assign mst3_slv5_base   = slv5_base;
  assign mst3_slv5_size   = slv5_size;
  assign mst3_slv5_grant  = mst3_slv5_ack;
  assign hm3_slv5_hwdata  = hm3_hwdata;
  assign mst3_slv5_haddr  = mst3_haddr;
  assign mst3_slv5_hburst = mst3_hburst;
  assign mst3_slv5_hprot  = mst3_hprot;
  assign mst3_slv5_hsize  = mst3_hsize;
  assign mst3_slv5_htrans = mst3_htrans;
  assign mst3_slv5_hwrite = mst3_hwrite;
  assign mst3_slv5_req    = mst3_slv5_sel;
end
else begin : gen_m3s5_nonexistent
     assign mst3_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs5_hready  = 1'b0;
     assign mst3_hs5_hresp   = 2'h0;
     assign mst3_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv5_size   = 4'h0;
     assign mst3_slv5_grant  = 1'b0;
     assign hm3_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv5_hburst = 3'h0;
     assign mst3_slv5_hprot  = 4'h0;
     assign mst3_slv5_hsize  = 3'h0;
     assign mst3_slv5_htrans = 2'h0;
     assign mst3_slv5_hwrite = 1'b0;
     assign mst3_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S5) begin : gen_m4s5
  assign mst4_hs5_hrdata  = hs5_hrdata;
  assign mst4_hs5_hready  = hs5_hready;
  assign mst4_hs5_hresp   = hs5_hresp;
  assign mst4_slv5_base   = slv5_base;
  assign mst4_slv5_size   = slv5_size;
  assign mst4_slv5_grant  = mst4_slv5_ack;
  assign hm4_slv5_hwdata  = hm4_hwdata;
  assign mst4_slv5_haddr  = mst4_haddr;
  assign mst4_slv5_hburst = mst4_hburst;
  assign mst4_slv5_hprot  = mst4_hprot;
  assign mst4_slv5_hsize  = mst4_hsize;
  assign mst4_slv5_htrans = mst4_htrans;
  assign mst4_slv5_hwrite = mst4_hwrite;
  assign mst4_slv5_req    = mst4_slv5_sel;
end
else begin : gen_m4s5_nonexistent
     assign mst4_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs5_hready  = 1'b0;
     assign mst4_hs5_hresp   = 2'h0;
     assign mst4_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv5_size   = 4'h0;
     assign mst4_slv5_grant  = 1'b0;
     assign hm4_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv5_hburst = 3'h0;
     assign mst4_slv5_hprot  = 4'h0;
     assign mst4_slv5_hsize  = 3'h0;
     assign mst4_slv5_htrans = 2'h0;
     assign mst4_slv5_hwrite = 1'b0;
     assign mst4_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S5) begin : gen_m5s5
  assign mst5_hs5_hrdata  = hs5_hrdata;
  assign mst5_hs5_hready  = hs5_hready;
  assign mst5_hs5_hresp   = hs5_hresp;
  assign mst5_slv5_base   = slv5_base;
  assign mst5_slv5_size   = slv5_size;
  assign mst5_slv5_grant  = mst5_slv5_ack;
  assign hm5_slv5_hwdata  = hm5_hwdata;
  assign mst5_slv5_haddr  = mst5_haddr;
  assign mst5_slv5_hburst = mst5_hburst;
  assign mst5_slv5_hprot  = mst5_hprot;
  assign mst5_slv5_hsize  = mst5_hsize;
  assign mst5_slv5_htrans = mst5_htrans;
  assign mst5_slv5_hwrite = mst5_hwrite;
  assign mst5_slv5_req    = mst5_slv5_sel;
end
else begin : gen_m5s5_nonexistent
     assign mst5_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs5_hready  = 1'b0;
     assign mst5_hs5_hresp   = 2'h0;
     assign mst5_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv5_size   = 4'h0;
     assign mst5_slv5_grant  = 1'b0;
     assign hm5_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv5_hburst = 3'h0;
     assign mst5_slv5_hprot  = 4'h0;
     assign mst5_slv5_hsize  = 3'h0;
     assign mst5_slv5_htrans = 2'h0;
     assign mst5_slv5_hwrite = 1'b0;
     assign mst5_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S5) begin : gen_m6s5
  assign mst6_hs5_hrdata  = hs5_hrdata;
  assign mst6_hs5_hready  = hs5_hready;
  assign mst6_hs5_hresp   = hs5_hresp;
  assign mst6_slv5_base   = slv5_base;
  assign mst6_slv5_size   = slv5_size;
  assign mst6_slv5_grant  = mst6_slv5_ack;
  assign hm6_slv5_hwdata  = hm6_hwdata;
  assign mst6_slv5_haddr  = mst6_haddr;
  assign mst6_slv5_hburst = mst6_hburst;
  assign mst6_slv5_hprot  = mst6_hprot;
  assign mst6_slv5_hsize  = mst6_hsize;
  assign mst6_slv5_htrans = mst6_htrans;
  assign mst6_slv5_hwrite = mst6_hwrite;
  assign mst6_slv5_req    = mst6_slv5_sel;
end
else begin : gen_m6s5_nonexistent
     assign mst6_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs5_hready  = 1'b0;
     assign mst6_hs5_hresp   = 2'h0;
     assign mst6_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv5_size   = 4'h0;
     assign mst6_slv5_grant  = 1'b0;
     assign hm6_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv5_hburst = 3'h0;
     assign mst6_slv5_hprot  = 4'h0;
     assign mst6_slv5_hsize  = 3'h0;
     assign mst6_slv5_htrans = 2'h0;
     assign mst6_slv5_hwrite = 1'b0;
     assign mst6_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S5) begin : gen_m7s5
  assign mst7_hs5_hrdata  = hs5_hrdata;
  assign mst7_hs5_hready  = hs5_hready;
  assign mst7_hs5_hresp   = hs5_hresp;
  assign mst7_slv5_base   = slv5_base;
  assign mst7_slv5_size   = slv5_size;
  assign mst7_slv5_grant  = mst7_slv5_ack;
  assign hm7_slv5_hwdata  = hm7_hwdata;
  assign mst7_slv5_haddr  = mst7_haddr;
  assign mst7_slv5_hburst = mst7_hburst;
  assign mst7_slv5_hprot  = mst7_hprot;
  assign mst7_slv5_hsize  = mst7_hsize;
  assign mst7_slv5_htrans = mst7_htrans;
  assign mst7_slv5_hwrite = mst7_hwrite;
  assign mst7_slv5_req    = mst7_slv5_sel;
end
else begin : gen_m7s5_nonexistent
     assign mst7_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs5_hready  = 1'b0;
     assign mst7_hs5_hresp   = 2'h0;
     assign mst7_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv5_size   = 4'h0;
     assign mst7_slv5_grant  = 1'b0;
     assign hm7_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv5_hburst = 3'h0;
     assign mst7_slv5_hprot  = 4'h0;
     assign mst7_slv5_hsize  = 3'h0;
     assign mst7_slv5_htrans = 2'h0;
     assign mst7_slv5_hwrite = 1'b0;
     assign mst7_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S5) begin : gen_m8s5
  assign mst8_hs5_hrdata  = hs5_hrdata;
  assign mst8_hs5_hready  = hs5_hready;
  assign mst8_hs5_hresp   = hs5_hresp;
  assign mst8_slv5_base   = slv5_base;
  assign mst8_slv5_size   = slv5_size;
  assign mst8_slv5_grant  = mst8_slv5_ack;
  assign hm8_slv5_hwdata  = hm8_hwdata;
  assign mst8_slv5_haddr  = mst8_haddr;
  assign mst8_slv5_hburst = mst8_hburst;
  assign mst8_slv5_hprot  = mst8_hprot;
  assign mst8_slv5_hsize  = mst8_hsize;
  assign mst8_slv5_htrans = mst8_htrans;
  assign mst8_slv5_hwrite = mst8_hwrite;
  assign mst8_slv5_req    = mst8_slv5_sel;
end
else begin : gen_m8s5_nonexistent
     assign mst8_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs5_hready  = 1'b0;
     assign mst8_hs5_hresp   = 2'h0;
     assign mst8_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv5_size   = 4'h0;
     assign mst8_slv5_grant  = 1'b0;
     assign hm8_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv5_hburst = 3'h0;
     assign mst8_slv5_hprot  = 4'h0;
     assign mst8_slv5_hsize  = 3'h0;
     assign mst8_slv5_htrans = 2'h0;
     assign mst8_slv5_hwrite = 1'b0;
     assign mst8_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S5) begin : gen_m9s5
  assign mst9_hs5_hrdata  = hs5_hrdata;
  assign mst9_hs5_hready  = hs5_hready;
  assign mst9_hs5_hresp   = hs5_hresp;
  assign mst9_slv5_base   = slv5_base;
  assign mst9_slv5_size   = slv5_size;
  assign mst9_slv5_grant  = mst9_slv5_ack;
  assign hm9_slv5_hwdata  = hm9_hwdata;
  assign mst9_slv5_haddr  = mst9_haddr;
  assign mst9_slv5_hburst = mst9_hburst;
  assign mst9_slv5_hprot  = mst9_hprot;
  assign mst9_slv5_hsize  = mst9_hsize;
  assign mst9_slv5_htrans = mst9_htrans;
  assign mst9_slv5_hwrite = mst9_hwrite;
  assign mst9_slv5_req    = mst9_slv5_sel;
end
else begin : gen_m9s5_nonexistent
     assign mst9_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs5_hready  = 1'b0;
     assign mst9_hs5_hresp   = 2'h0;
     assign mst9_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv5_size   = 4'h0;
     assign mst9_slv5_grant  = 1'b0;
     assign hm9_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv5_hburst = 3'h0;
     assign mst9_slv5_hprot  = 4'h0;
     assign mst9_slv5_hsize  = 3'h0;
     assign mst9_slv5_htrans = 2'h0;
     assign mst9_slv5_hwrite = 1'b0;
     assign mst9_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S5) begin : gen_m10s5
  assign mst10_hs5_hrdata  = hs5_hrdata;
  assign mst10_hs5_hready  = hs5_hready;
  assign mst10_hs5_hresp   = hs5_hresp;
  assign mst10_slv5_base   = slv5_base;
  assign mst10_slv5_size   = slv5_size;
  assign mst10_slv5_grant  = mst10_slv5_ack;
  assign hm10_slv5_hwdata  = hm10_hwdata;
  assign mst10_slv5_haddr  = mst10_haddr;
  assign mst10_slv5_hburst = mst10_hburst;
  assign mst10_slv5_hprot  = mst10_hprot;
  assign mst10_slv5_hsize  = mst10_hsize;
  assign mst10_slv5_htrans = mst10_htrans;
  assign mst10_slv5_hwrite = mst10_hwrite;
  assign mst10_slv5_req    = mst10_slv5_sel;
end
else begin : gen_m10s5_nonexistent
     assign mst10_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs5_hready  = 1'b0;
     assign mst10_hs5_hresp   = 2'h0;
     assign mst10_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv5_size   = 4'h0;
     assign mst10_slv5_grant  = 1'b0;
     assign hm10_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv5_hburst = 3'h0;
     assign mst10_slv5_hprot  = 4'h0;
     assign mst10_slv5_hsize  = 3'h0;
     assign mst10_slv5_htrans = 2'h0;
     assign mst10_slv5_hwrite = 1'b0;
     assign mst10_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S5) begin : gen_m11s5
  assign mst11_hs5_hrdata  = hs5_hrdata;
  assign mst11_hs5_hready  = hs5_hready;
  assign mst11_hs5_hresp   = hs5_hresp;
  assign mst11_slv5_base   = slv5_base;
  assign mst11_slv5_size   = slv5_size;
  assign mst11_slv5_grant  = mst11_slv5_ack;
  assign hm11_slv5_hwdata  = hm11_hwdata;
  assign mst11_slv5_haddr  = mst11_haddr;
  assign mst11_slv5_hburst = mst11_hburst;
  assign mst11_slv5_hprot  = mst11_hprot;
  assign mst11_slv5_hsize  = mst11_hsize;
  assign mst11_slv5_htrans = mst11_htrans;
  assign mst11_slv5_hwrite = mst11_hwrite;
  assign mst11_slv5_req    = mst11_slv5_sel;
end
else begin : gen_m11s5_nonexistent
     assign mst11_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs5_hready  = 1'b0;
     assign mst11_hs5_hresp   = 2'h0;
     assign mst11_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv5_size   = 4'h0;
     assign mst11_slv5_grant  = 1'b0;
     assign hm11_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv5_hburst = 3'h0;
     assign mst11_slv5_hprot  = 4'h0;
     assign mst11_slv5_hsize  = 3'h0;
     assign mst11_slv5_htrans = 2'h0;
     assign mst11_slv5_hwrite = 1'b0;
     assign mst11_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S5) begin : gen_m12s5
  assign mst12_hs5_hrdata  = hs5_hrdata;
  assign mst12_hs5_hready  = hs5_hready;
  assign mst12_hs5_hresp   = hs5_hresp;
  assign mst12_slv5_base   = slv5_base;
  assign mst12_slv5_size   = slv5_size;
  assign mst12_slv5_grant  = mst12_slv5_ack;
  assign hm12_slv5_hwdata  = hm12_hwdata;
  assign mst12_slv5_haddr  = mst12_haddr;
  assign mst12_slv5_hburst = mst12_hburst;
  assign mst12_slv5_hprot  = mst12_hprot;
  assign mst12_slv5_hsize  = mst12_hsize;
  assign mst12_slv5_htrans = mst12_htrans;
  assign mst12_slv5_hwrite = mst12_hwrite;
  assign mst12_slv5_req    = mst12_slv5_sel;
end
else begin : gen_m12s5_nonexistent
     assign mst12_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs5_hready  = 1'b0;
     assign mst12_hs5_hresp   = 2'h0;
     assign mst12_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv5_size   = 4'h0;
     assign mst12_slv5_grant  = 1'b0;
     assign hm12_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv5_hburst = 3'h0;
     assign mst12_slv5_hprot  = 4'h0;
     assign mst12_slv5_hsize  = 3'h0;
     assign mst12_slv5_htrans = 2'h0;
     assign mst12_slv5_hwrite = 1'b0;
     assign mst12_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S5) begin : gen_m13s5
  assign mst13_hs5_hrdata  = hs5_hrdata;
  assign mst13_hs5_hready  = hs5_hready;
  assign mst13_hs5_hresp   = hs5_hresp;
  assign mst13_slv5_base   = slv5_base;
  assign mst13_slv5_size   = slv5_size;
  assign mst13_slv5_grant  = mst13_slv5_ack;
  assign hm13_slv5_hwdata  = hm13_hwdata;
  assign mst13_slv5_haddr  = mst13_haddr;
  assign mst13_slv5_hburst = mst13_hburst;
  assign mst13_slv5_hprot  = mst13_hprot;
  assign mst13_slv5_hsize  = mst13_hsize;
  assign mst13_slv5_htrans = mst13_htrans;
  assign mst13_slv5_hwrite = mst13_hwrite;
  assign mst13_slv5_req    = mst13_slv5_sel;
end
else begin : gen_m13s5_nonexistent
     assign mst13_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs5_hready  = 1'b0;
     assign mst13_hs5_hresp   = 2'h0;
     assign mst13_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv5_size   = 4'h0;
     assign mst13_slv5_grant  = 1'b0;
     assign hm13_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv5_hburst = 3'h0;
     assign mst13_slv5_hprot  = 4'h0;
     assign mst13_slv5_hsize  = 3'h0;
     assign mst13_slv5_htrans = 2'h0;
     assign mst13_slv5_hwrite = 1'b0;
     assign mst13_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S5) begin : gen_m14s5
  assign mst14_hs5_hrdata  = hs5_hrdata;
  assign mst14_hs5_hready  = hs5_hready;
  assign mst14_hs5_hresp   = hs5_hresp;
  assign mst14_slv5_base   = slv5_base;
  assign mst14_slv5_size   = slv5_size;
  assign mst14_slv5_grant  = mst14_slv5_ack;
  assign hm14_slv5_hwdata  = hm14_hwdata;
  assign mst14_slv5_haddr  = mst14_haddr;
  assign mst14_slv5_hburst = mst14_hburst;
  assign mst14_slv5_hprot  = mst14_hprot;
  assign mst14_slv5_hsize  = mst14_hsize;
  assign mst14_slv5_htrans = mst14_htrans;
  assign mst14_slv5_hwrite = mst14_hwrite;
  assign mst14_slv5_req    = mst14_slv5_sel;
end
else begin : gen_m14s5_nonexistent
     assign mst14_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs5_hready  = 1'b0;
     assign mst14_hs5_hresp   = 2'h0;
     assign mst14_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv5_size   = 4'h0;
     assign mst14_slv5_grant  = 1'b0;
     assign hm14_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv5_hburst = 3'h0;
     assign mst14_slv5_hprot  = 4'h0;
     assign mst14_slv5_hsize  = 3'h0;
     assign mst14_slv5_htrans = 2'h0;
     assign mst14_slv5_hwrite = 1'b0;
     assign mst14_slv5_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S5) begin : gen_m15s5
  assign mst15_hs5_hrdata  = hs5_hrdata;
  assign mst15_hs5_hready  = hs5_hready;
  assign mst15_hs5_hresp   = hs5_hresp;
  assign mst15_slv5_base   = slv5_base;
  assign mst15_slv5_size   = slv5_size;
  assign mst15_slv5_grant  = mst15_slv5_ack;
  assign hm15_slv5_hwdata  = hm15_hwdata;
  assign mst15_slv5_haddr  = mst15_haddr;
  assign mst15_slv5_hburst = mst15_hburst;
  assign mst15_slv5_hprot  = mst15_hprot;
  assign mst15_slv5_hsize  = mst15_hsize;
  assign mst15_slv5_htrans = mst15_htrans;
  assign mst15_slv5_hwrite = mst15_hwrite;
  assign mst15_slv5_req    = mst15_slv5_sel;
end
else begin : gen_m15s5_nonexistent
     assign mst15_hs5_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs5_hready  = 1'b0;
     assign mst15_hs5_hresp   = 2'h0;
     assign mst15_slv5_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv5_size   = 4'h0;
     assign mst15_slv5_grant  = 1'b0;
     assign hm15_slv5_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv5_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv5_hburst = 3'h0;
     assign mst15_slv5_hprot  = 4'h0;
     assign mst15_slv5_hsize  = 3'h0;
     assign mst15_slv5_htrans = 2'h0;
     assign mst15_slv5_hwrite = 1'b0;
     assign mst15_slv5_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV6
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S6) begin : gen_m0s6
  assign mst0_hs6_hrdata  = hs6_hrdata;
  assign mst0_hs6_hready  = hs6_hready;
  assign mst0_hs6_hresp   = hs6_hresp;
  assign mst0_slv6_base   = slv6_base;
  assign mst0_slv6_size   = slv6_size;
  assign mst0_slv6_grant  = mst0_slv6_ack;
  assign hm0_slv6_hwdata  = hm0_hwdata;
  assign mst0_slv6_haddr  = mst0_haddr;
  assign mst0_slv6_hburst = mst0_hburst;
  assign mst0_slv6_hprot  = mst0_hprot;
  assign mst0_slv6_hsize  = mst0_hsize;
  assign mst0_slv6_htrans = mst0_htrans;
  assign mst0_slv6_hwrite = mst0_hwrite;
  assign mst0_slv6_req    = mst0_slv6_sel;
end
else begin : gen_m0s6_nonexistent
     assign mst0_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs6_hready  = 1'b0;
     assign mst0_hs6_hresp   = 2'h0;
     assign mst0_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv6_size   = 4'h0;
     assign mst0_slv6_grant  = 1'b0;
     assign hm0_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv6_hburst = 3'h0;
     assign mst0_slv6_hprot  = 4'h0;
     assign mst0_slv6_hsize  = 3'h0;
     assign mst0_slv6_htrans = 2'h0;
     assign mst0_slv6_hwrite = 1'b0;
     assign mst0_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S6) begin : gen_m1s6
  assign mst1_hs6_hrdata  = hs6_hrdata;
  assign mst1_hs6_hready  = hs6_hready;
  assign mst1_hs6_hresp   = hs6_hresp;
  assign mst1_slv6_base   = slv6_base;
  assign mst1_slv6_size   = slv6_size;
  assign mst1_slv6_grant  = mst1_slv6_ack;
  assign hm1_slv6_hwdata  = hm1_hwdata;
  assign mst1_slv6_haddr  = mst1_haddr;
  assign mst1_slv6_hburst = mst1_hburst;
  assign mst1_slv6_hprot  = mst1_hprot;
  assign mst1_slv6_hsize  = mst1_hsize;
  assign mst1_slv6_htrans = mst1_htrans;
  assign mst1_slv6_hwrite = mst1_hwrite;
  assign mst1_slv6_req    = mst1_slv6_sel;
end
else begin : gen_m1s6_nonexistent
     assign mst1_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs6_hready  = 1'b0;
     assign mst1_hs6_hresp   = 2'h0;
     assign mst1_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv6_size   = 4'h0;
     assign mst1_slv6_grant  = 1'b0;
     assign hm1_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv6_hburst = 3'h0;
     assign mst1_slv6_hprot  = 4'h0;
     assign mst1_slv6_hsize  = 3'h0;
     assign mst1_slv6_htrans = 2'h0;
     assign mst1_slv6_hwrite = 1'b0;
     assign mst1_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S6) begin : gen_m2s6
  assign mst2_hs6_hrdata  = hs6_hrdata;
  assign mst2_hs6_hready  = hs6_hready;
  assign mst2_hs6_hresp   = hs6_hresp;
  assign mst2_slv6_base   = slv6_base;
  assign mst2_slv6_size   = slv6_size;
  assign mst2_slv6_grant  = mst2_slv6_ack;
  assign hm2_slv6_hwdata  = hm2_hwdata;
  assign mst2_slv6_haddr  = mst2_haddr;
  assign mst2_slv6_hburst = mst2_hburst;
  assign mst2_slv6_hprot  = mst2_hprot;
  assign mst2_slv6_hsize  = mst2_hsize;
  assign mst2_slv6_htrans = mst2_htrans;
  assign mst2_slv6_hwrite = mst2_hwrite;
  assign mst2_slv6_req    = mst2_slv6_sel;
end
else begin : gen_m2s6_nonexistent
     assign mst2_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs6_hready  = 1'b0;
     assign mst2_hs6_hresp   = 2'h0;
     assign mst2_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv6_size   = 4'h0;
     assign mst2_slv6_grant  = 1'b0;
     assign hm2_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv6_hburst = 3'h0;
     assign mst2_slv6_hprot  = 4'h0;
     assign mst2_slv6_hsize  = 3'h0;
     assign mst2_slv6_htrans = 2'h0;
     assign mst2_slv6_hwrite = 1'b0;
     assign mst2_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S6) begin : gen_m3s6
  assign mst3_hs6_hrdata  = hs6_hrdata;
  assign mst3_hs6_hready  = hs6_hready;
  assign mst3_hs6_hresp   = hs6_hresp;
  assign mst3_slv6_base   = slv6_base;
  assign mst3_slv6_size   = slv6_size;
  assign mst3_slv6_grant  = mst3_slv6_ack;
  assign hm3_slv6_hwdata  = hm3_hwdata;
  assign mst3_slv6_haddr  = mst3_haddr;
  assign mst3_slv6_hburst = mst3_hburst;
  assign mst3_slv6_hprot  = mst3_hprot;
  assign mst3_slv6_hsize  = mst3_hsize;
  assign mst3_slv6_htrans = mst3_htrans;
  assign mst3_slv6_hwrite = mst3_hwrite;
  assign mst3_slv6_req    = mst3_slv6_sel;
end
else begin : gen_m3s6_nonexistent
     assign mst3_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs6_hready  = 1'b0;
     assign mst3_hs6_hresp   = 2'h0;
     assign mst3_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv6_size   = 4'h0;
     assign mst3_slv6_grant  = 1'b0;
     assign hm3_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv6_hburst = 3'h0;
     assign mst3_slv6_hprot  = 4'h0;
     assign mst3_slv6_hsize  = 3'h0;
     assign mst3_slv6_htrans = 2'h0;
     assign mst3_slv6_hwrite = 1'b0;
     assign mst3_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S6) begin : gen_m4s6
  assign mst4_hs6_hrdata  = hs6_hrdata;
  assign mst4_hs6_hready  = hs6_hready;
  assign mst4_hs6_hresp   = hs6_hresp;
  assign mst4_slv6_base   = slv6_base;
  assign mst4_slv6_size   = slv6_size;
  assign mst4_slv6_grant  = mst4_slv6_ack;
  assign hm4_slv6_hwdata  = hm4_hwdata;
  assign mst4_slv6_haddr  = mst4_haddr;
  assign mst4_slv6_hburst = mst4_hburst;
  assign mst4_slv6_hprot  = mst4_hprot;
  assign mst4_slv6_hsize  = mst4_hsize;
  assign mst4_slv6_htrans = mst4_htrans;
  assign mst4_slv6_hwrite = mst4_hwrite;
  assign mst4_slv6_req    = mst4_slv6_sel;
end
else begin : gen_m4s6_nonexistent
     assign mst4_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs6_hready  = 1'b0;
     assign mst4_hs6_hresp   = 2'h0;
     assign mst4_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv6_size   = 4'h0;
     assign mst4_slv6_grant  = 1'b0;
     assign hm4_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv6_hburst = 3'h0;
     assign mst4_slv6_hprot  = 4'h0;
     assign mst4_slv6_hsize  = 3'h0;
     assign mst4_slv6_htrans = 2'h0;
     assign mst4_slv6_hwrite = 1'b0;
     assign mst4_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S6) begin : gen_m5s6
  assign mst5_hs6_hrdata  = hs6_hrdata;
  assign mst5_hs6_hready  = hs6_hready;
  assign mst5_hs6_hresp   = hs6_hresp;
  assign mst5_slv6_base   = slv6_base;
  assign mst5_slv6_size   = slv6_size;
  assign mst5_slv6_grant  = mst5_slv6_ack;
  assign hm5_slv6_hwdata  = hm5_hwdata;
  assign mst5_slv6_haddr  = mst5_haddr;
  assign mst5_slv6_hburst = mst5_hburst;
  assign mst5_slv6_hprot  = mst5_hprot;
  assign mst5_slv6_hsize  = mst5_hsize;
  assign mst5_slv6_htrans = mst5_htrans;
  assign mst5_slv6_hwrite = mst5_hwrite;
  assign mst5_slv6_req    = mst5_slv6_sel;
end
else begin : gen_m5s6_nonexistent
     assign mst5_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs6_hready  = 1'b0;
     assign mst5_hs6_hresp   = 2'h0;
     assign mst5_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv6_size   = 4'h0;
     assign mst5_slv6_grant  = 1'b0;
     assign hm5_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv6_hburst = 3'h0;
     assign mst5_slv6_hprot  = 4'h0;
     assign mst5_slv6_hsize  = 3'h0;
     assign mst5_slv6_htrans = 2'h0;
     assign mst5_slv6_hwrite = 1'b0;
     assign mst5_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S6) begin : gen_m6s6
  assign mst6_hs6_hrdata  = hs6_hrdata;
  assign mst6_hs6_hready  = hs6_hready;
  assign mst6_hs6_hresp   = hs6_hresp;
  assign mst6_slv6_base   = slv6_base;
  assign mst6_slv6_size   = slv6_size;
  assign mst6_slv6_grant  = mst6_slv6_ack;
  assign hm6_slv6_hwdata  = hm6_hwdata;
  assign mst6_slv6_haddr  = mst6_haddr;
  assign mst6_slv6_hburst = mst6_hburst;
  assign mst6_slv6_hprot  = mst6_hprot;
  assign mst6_slv6_hsize  = mst6_hsize;
  assign mst6_slv6_htrans = mst6_htrans;
  assign mst6_slv6_hwrite = mst6_hwrite;
  assign mst6_slv6_req    = mst6_slv6_sel;
end
else begin : gen_m6s6_nonexistent
     assign mst6_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs6_hready  = 1'b0;
     assign mst6_hs6_hresp   = 2'h0;
     assign mst6_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv6_size   = 4'h0;
     assign mst6_slv6_grant  = 1'b0;
     assign hm6_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv6_hburst = 3'h0;
     assign mst6_slv6_hprot  = 4'h0;
     assign mst6_slv6_hsize  = 3'h0;
     assign mst6_slv6_htrans = 2'h0;
     assign mst6_slv6_hwrite = 1'b0;
     assign mst6_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S6) begin : gen_m7s6
  assign mst7_hs6_hrdata  = hs6_hrdata;
  assign mst7_hs6_hready  = hs6_hready;
  assign mst7_hs6_hresp   = hs6_hresp;
  assign mst7_slv6_base   = slv6_base;
  assign mst7_slv6_size   = slv6_size;
  assign mst7_slv6_grant  = mst7_slv6_ack;
  assign hm7_slv6_hwdata  = hm7_hwdata;
  assign mst7_slv6_haddr  = mst7_haddr;
  assign mst7_slv6_hburst = mst7_hburst;
  assign mst7_slv6_hprot  = mst7_hprot;
  assign mst7_slv6_hsize  = mst7_hsize;
  assign mst7_slv6_htrans = mst7_htrans;
  assign mst7_slv6_hwrite = mst7_hwrite;
  assign mst7_slv6_req    = mst7_slv6_sel;
end
else begin : gen_m7s6_nonexistent
     assign mst7_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs6_hready  = 1'b0;
     assign mst7_hs6_hresp   = 2'h0;
     assign mst7_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv6_size   = 4'h0;
     assign mst7_slv6_grant  = 1'b0;
     assign hm7_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv6_hburst = 3'h0;
     assign mst7_slv6_hprot  = 4'h0;
     assign mst7_slv6_hsize  = 3'h0;
     assign mst7_slv6_htrans = 2'h0;
     assign mst7_slv6_hwrite = 1'b0;
     assign mst7_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S6) begin : gen_m8s6
  assign mst8_hs6_hrdata  = hs6_hrdata;
  assign mst8_hs6_hready  = hs6_hready;
  assign mst8_hs6_hresp   = hs6_hresp;
  assign mst8_slv6_base   = slv6_base;
  assign mst8_slv6_size   = slv6_size;
  assign mst8_slv6_grant  = mst8_slv6_ack;
  assign hm8_slv6_hwdata  = hm8_hwdata;
  assign mst8_slv6_haddr  = mst8_haddr;
  assign mst8_slv6_hburst = mst8_hburst;
  assign mst8_slv6_hprot  = mst8_hprot;
  assign mst8_slv6_hsize  = mst8_hsize;
  assign mst8_slv6_htrans = mst8_htrans;
  assign mst8_slv6_hwrite = mst8_hwrite;
  assign mst8_slv6_req    = mst8_slv6_sel;
end
else begin : gen_m8s6_nonexistent
     assign mst8_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs6_hready  = 1'b0;
     assign mst8_hs6_hresp   = 2'h0;
     assign mst8_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv6_size   = 4'h0;
     assign mst8_slv6_grant  = 1'b0;
     assign hm8_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv6_hburst = 3'h0;
     assign mst8_slv6_hprot  = 4'h0;
     assign mst8_slv6_hsize  = 3'h0;
     assign mst8_slv6_htrans = 2'h0;
     assign mst8_slv6_hwrite = 1'b0;
     assign mst8_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S6) begin : gen_m9s6
  assign mst9_hs6_hrdata  = hs6_hrdata;
  assign mst9_hs6_hready  = hs6_hready;
  assign mst9_hs6_hresp   = hs6_hresp;
  assign mst9_slv6_base   = slv6_base;
  assign mst9_slv6_size   = slv6_size;
  assign mst9_slv6_grant  = mst9_slv6_ack;
  assign hm9_slv6_hwdata  = hm9_hwdata;
  assign mst9_slv6_haddr  = mst9_haddr;
  assign mst9_slv6_hburst = mst9_hburst;
  assign mst9_slv6_hprot  = mst9_hprot;
  assign mst9_slv6_hsize  = mst9_hsize;
  assign mst9_slv6_htrans = mst9_htrans;
  assign mst9_slv6_hwrite = mst9_hwrite;
  assign mst9_slv6_req    = mst9_slv6_sel;
end
else begin : gen_m9s6_nonexistent
     assign mst9_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs6_hready  = 1'b0;
     assign mst9_hs6_hresp   = 2'h0;
     assign mst9_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv6_size   = 4'h0;
     assign mst9_slv6_grant  = 1'b0;
     assign hm9_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv6_hburst = 3'h0;
     assign mst9_slv6_hprot  = 4'h0;
     assign mst9_slv6_hsize  = 3'h0;
     assign mst9_slv6_htrans = 2'h0;
     assign mst9_slv6_hwrite = 1'b0;
     assign mst9_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S6) begin : gen_m10s6
  assign mst10_hs6_hrdata  = hs6_hrdata;
  assign mst10_hs6_hready  = hs6_hready;
  assign mst10_hs6_hresp   = hs6_hresp;
  assign mst10_slv6_base   = slv6_base;
  assign mst10_slv6_size   = slv6_size;
  assign mst10_slv6_grant  = mst10_slv6_ack;
  assign hm10_slv6_hwdata  = hm10_hwdata;
  assign mst10_slv6_haddr  = mst10_haddr;
  assign mst10_slv6_hburst = mst10_hburst;
  assign mst10_slv6_hprot  = mst10_hprot;
  assign mst10_slv6_hsize  = mst10_hsize;
  assign mst10_slv6_htrans = mst10_htrans;
  assign mst10_slv6_hwrite = mst10_hwrite;
  assign mst10_slv6_req    = mst10_slv6_sel;
end
else begin : gen_m10s6_nonexistent
     assign mst10_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs6_hready  = 1'b0;
     assign mst10_hs6_hresp   = 2'h0;
     assign mst10_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv6_size   = 4'h0;
     assign mst10_slv6_grant  = 1'b0;
     assign hm10_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv6_hburst = 3'h0;
     assign mst10_slv6_hprot  = 4'h0;
     assign mst10_slv6_hsize  = 3'h0;
     assign mst10_slv6_htrans = 2'h0;
     assign mst10_slv6_hwrite = 1'b0;
     assign mst10_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S6) begin : gen_m11s6
  assign mst11_hs6_hrdata  = hs6_hrdata;
  assign mst11_hs6_hready  = hs6_hready;
  assign mst11_hs6_hresp   = hs6_hresp;
  assign mst11_slv6_base   = slv6_base;
  assign mst11_slv6_size   = slv6_size;
  assign mst11_slv6_grant  = mst11_slv6_ack;
  assign hm11_slv6_hwdata  = hm11_hwdata;
  assign mst11_slv6_haddr  = mst11_haddr;
  assign mst11_slv6_hburst = mst11_hburst;
  assign mst11_slv6_hprot  = mst11_hprot;
  assign mst11_slv6_hsize  = mst11_hsize;
  assign mst11_slv6_htrans = mst11_htrans;
  assign mst11_slv6_hwrite = mst11_hwrite;
  assign mst11_slv6_req    = mst11_slv6_sel;
end
else begin : gen_m11s6_nonexistent
     assign mst11_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs6_hready  = 1'b0;
     assign mst11_hs6_hresp   = 2'h0;
     assign mst11_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv6_size   = 4'h0;
     assign mst11_slv6_grant  = 1'b0;
     assign hm11_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv6_hburst = 3'h0;
     assign mst11_slv6_hprot  = 4'h0;
     assign mst11_slv6_hsize  = 3'h0;
     assign mst11_slv6_htrans = 2'h0;
     assign mst11_slv6_hwrite = 1'b0;
     assign mst11_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S6) begin : gen_m12s6
  assign mst12_hs6_hrdata  = hs6_hrdata;
  assign mst12_hs6_hready  = hs6_hready;
  assign mst12_hs6_hresp   = hs6_hresp;
  assign mst12_slv6_base   = slv6_base;
  assign mst12_slv6_size   = slv6_size;
  assign mst12_slv6_grant  = mst12_slv6_ack;
  assign hm12_slv6_hwdata  = hm12_hwdata;
  assign mst12_slv6_haddr  = mst12_haddr;
  assign mst12_slv6_hburst = mst12_hburst;
  assign mst12_slv6_hprot  = mst12_hprot;
  assign mst12_slv6_hsize  = mst12_hsize;
  assign mst12_slv6_htrans = mst12_htrans;
  assign mst12_slv6_hwrite = mst12_hwrite;
  assign mst12_slv6_req    = mst12_slv6_sel;
end
else begin : gen_m12s6_nonexistent
     assign mst12_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs6_hready  = 1'b0;
     assign mst12_hs6_hresp   = 2'h0;
     assign mst12_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv6_size   = 4'h0;
     assign mst12_slv6_grant  = 1'b0;
     assign hm12_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv6_hburst = 3'h0;
     assign mst12_slv6_hprot  = 4'h0;
     assign mst12_slv6_hsize  = 3'h0;
     assign mst12_slv6_htrans = 2'h0;
     assign mst12_slv6_hwrite = 1'b0;
     assign mst12_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S6) begin : gen_m13s6
  assign mst13_hs6_hrdata  = hs6_hrdata;
  assign mst13_hs6_hready  = hs6_hready;
  assign mst13_hs6_hresp   = hs6_hresp;
  assign mst13_slv6_base   = slv6_base;
  assign mst13_slv6_size   = slv6_size;
  assign mst13_slv6_grant  = mst13_slv6_ack;
  assign hm13_slv6_hwdata  = hm13_hwdata;
  assign mst13_slv6_haddr  = mst13_haddr;
  assign mst13_slv6_hburst = mst13_hburst;
  assign mst13_slv6_hprot  = mst13_hprot;
  assign mst13_slv6_hsize  = mst13_hsize;
  assign mst13_slv6_htrans = mst13_htrans;
  assign mst13_slv6_hwrite = mst13_hwrite;
  assign mst13_slv6_req    = mst13_slv6_sel;
end
else begin : gen_m13s6_nonexistent
     assign mst13_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs6_hready  = 1'b0;
     assign mst13_hs6_hresp   = 2'h0;
     assign mst13_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv6_size   = 4'h0;
     assign mst13_slv6_grant  = 1'b0;
     assign hm13_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv6_hburst = 3'h0;
     assign mst13_slv6_hprot  = 4'h0;
     assign mst13_slv6_hsize  = 3'h0;
     assign mst13_slv6_htrans = 2'h0;
     assign mst13_slv6_hwrite = 1'b0;
     assign mst13_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S6) begin : gen_m14s6
  assign mst14_hs6_hrdata  = hs6_hrdata;
  assign mst14_hs6_hready  = hs6_hready;
  assign mst14_hs6_hresp   = hs6_hresp;
  assign mst14_slv6_base   = slv6_base;
  assign mst14_slv6_size   = slv6_size;
  assign mst14_slv6_grant  = mst14_slv6_ack;
  assign hm14_slv6_hwdata  = hm14_hwdata;
  assign mst14_slv6_haddr  = mst14_haddr;
  assign mst14_slv6_hburst = mst14_hburst;
  assign mst14_slv6_hprot  = mst14_hprot;
  assign mst14_slv6_hsize  = mst14_hsize;
  assign mst14_slv6_htrans = mst14_htrans;
  assign mst14_slv6_hwrite = mst14_hwrite;
  assign mst14_slv6_req    = mst14_slv6_sel;
end
else begin : gen_m14s6_nonexistent
     assign mst14_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs6_hready  = 1'b0;
     assign mst14_hs6_hresp   = 2'h0;
     assign mst14_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv6_size   = 4'h0;
     assign mst14_slv6_grant  = 1'b0;
     assign hm14_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv6_hburst = 3'h0;
     assign mst14_slv6_hprot  = 4'h0;
     assign mst14_slv6_hsize  = 3'h0;
     assign mst14_slv6_htrans = 2'h0;
     assign mst14_slv6_hwrite = 1'b0;
     assign mst14_slv6_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S6) begin : gen_m15s6
  assign mst15_hs6_hrdata  = hs6_hrdata;
  assign mst15_hs6_hready  = hs6_hready;
  assign mst15_hs6_hresp   = hs6_hresp;
  assign mst15_slv6_base   = slv6_base;
  assign mst15_slv6_size   = slv6_size;
  assign mst15_slv6_grant  = mst15_slv6_ack;
  assign hm15_slv6_hwdata  = hm15_hwdata;
  assign mst15_slv6_haddr  = mst15_haddr;
  assign mst15_slv6_hburst = mst15_hburst;
  assign mst15_slv6_hprot  = mst15_hprot;
  assign mst15_slv6_hsize  = mst15_hsize;
  assign mst15_slv6_htrans = mst15_htrans;
  assign mst15_slv6_hwrite = mst15_hwrite;
  assign mst15_slv6_req    = mst15_slv6_sel;
end
else begin : gen_m15s6_nonexistent
     assign mst15_hs6_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs6_hready  = 1'b0;
     assign mst15_hs6_hresp   = 2'h0;
     assign mst15_slv6_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv6_size   = 4'h0;
     assign mst15_slv6_grant  = 1'b0;
     assign hm15_slv6_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv6_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv6_hburst = 3'h0;
     assign mst15_slv6_hprot  = 4'h0;
     assign mst15_slv6_hsize  = 3'h0;
     assign mst15_slv6_htrans = 2'h0;
     assign mst15_slv6_hwrite = 1'b0;
     assign mst15_slv6_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV7
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S7) begin : gen_m0s7
  assign mst0_hs7_hrdata  = hs7_hrdata;
  assign mst0_hs7_hready  = hs7_hready;
  assign mst0_hs7_hresp   = hs7_hresp;
  assign mst0_slv7_base   = slv7_base;
  assign mst0_slv7_size   = slv7_size;
  assign mst0_slv7_grant  = mst0_slv7_ack;
  assign hm0_slv7_hwdata  = hm0_hwdata;
  assign mst0_slv7_haddr  = mst0_haddr;
  assign mst0_slv7_hburst = mst0_hburst;
  assign mst0_slv7_hprot  = mst0_hprot;
  assign mst0_slv7_hsize  = mst0_hsize;
  assign mst0_slv7_htrans = mst0_htrans;
  assign mst0_slv7_hwrite = mst0_hwrite;
  assign mst0_slv7_req    = mst0_slv7_sel;
end
else begin : gen_m0s7_nonexistent
     assign mst0_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs7_hready  = 1'b0;
     assign mst0_hs7_hresp   = 2'h0;
     assign mst0_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv7_size   = 4'h0;
     assign mst0_slv7_grant  = 1'b0;
     assign hm0_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv7_hburst = 3'h0;
     assign mst0_slv7_hprot  = 4'h0;
     assign mst0_slv7_hsize  = 3'h0;
     assign mst0_slv7_htrans = 2'h0;
     assign mst0_slv7_hwrite = 1'b0;
     assign mst0_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S7) begin : gen_m1s7
  assign mst1_hs7_hrdata  = hs7_hrdata;
  assign mst1_hs7_hready  = hs7_hready;
  assign mst1_hs7_hresp   = hs7_hresp;
  assign mst1_slv7_base   = slv7_base;
  assign mst1_slv7_size   = slv7_size;
  assign mst1_slv7_grant  = mst1_slv7_ack;
  assign hm1_slv7_hwdata  = hm1_hwdata;
  assign mst1_slv7_haddr  = mst1_haddr;
  assign mst1_slv7_hburst = mst1_hburst;
  assign mst1_slv7_hprot  = mst1_hprot;
  assign mst1_slv7_hsize  = mst1_hsize;
  assign mst1_slv7_htrans = mst1_htrans;
  assign mst1_slv7_hwrite = mst1_hwrite;
  assign mst1_slv7_req    = mst1_slv7_sel;
end
else begin : gen_m1s7_nonexistent
     assign mst1_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs7_hready  = 1'b0;
     assign mst1_hs7_hresp   = 2'h0;
     assign mst1_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv7_size   = 4'h0;
     assign mst1_slv7_grant  = 1'b0;
     assign hm1_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv7_hburst = 3'h0;
     assign mst1_slv7_hprot  = 4'h0;
     assign mst1_slv7_hsize  = 3'h0;
     assign mst1_slv7_htrans = 2'h0;
     assign mst1_slv7_hwrite = 1'b0;
     assign mst1_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S7) begin : gen_m2s7
  assign mst2_hs7_hrdata  = hs7_hrdata;
  assign mst2_hs7_hready  = hs7_hready;
  assign mst2_hs7_hresp   = hs7_hresp;
  assign mst2_slv7_base   = slv7_base;
  assign mst2_slv7_size   = slv7_size;
  assign mst2_slv7_grant  = mst2_slv7_ack;
  assign hm2_slv7_hwdata  = hm2_hwdata;
  assign mst2_slv7_haddr  = mst2_haddr;
  assign mst2_slv7_hburst = mst2_hburst;
  assign mst2_slv7_hprot  = mst2_hprot;
  assign mst2_slv7_hsize  = mst2_hsize;
  assign mst2_slv7_htrans = mst2_htrans;
  assign mst2_slv7_hwrite = mst2_hwrite;
  assign mst2_slv7_req    = mst2_slv7_sel;
end
else begin : gen_m2s7_nonexistent
     assign mst2_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs7_hready  = 1'b0;
     assign mst2_hs7_hresp   = 2'h0;
     assign mst2_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv7_size   = 4'h0;
     assign mst2_slv7_grant  = 1'b0;
     assign hm2_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv7_hburst = 3'h0;
     assign mst2_slv7_hprot  = 4'h0;
     assign mst2_slv7_hsize  = 3'h0;
     assign mst2_slv7_htrans = 2'h0;
     assign mst2_slv7_hwrite = 1'b0;
     assign mst2_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S7) begin : gen_m3s7
  assign mst3_hs7_hrdata  = hs7_hrdata;
  assign mst3_hs7_hready  = hs7_hready;
  assign mst3_hs7_hresp   = hs7_hresp;
  assign mst3_slv7_base   = slv7_base;
  assign mst3_slv7_size   = slv7_size;
  assign mst3_slv7_grant  = mst3_slv7_ack;
  assign hm3_slv7_hwdata  = hm3_hwdata;
  assign mst3_slv7_haddr  = mst3_haddr;
  assign mst3_slv7_hburst = mst3_hburst;
  assign mst3_slv7_hprot  = mst3_hprot;
  assign mst3_slv7_hsize  = mst3_hsize;
  assign mst3_slv7_htrans = mst3_htrans;
  assign mst3_slv7_hwrite = mst3_hwrite;
  assign mst3_slv7_req    = mst3_slv7_sel;
end
else begin : gen_m3s7_nonexistent
     assign mst3_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs7_hready  = 1'b0;
     assign mst3_hs7_hresp   = 2'h0;
     assign mst3_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv7_size   = 4'h0;
     assign mst3_slv7_grant  = 1'b0;
     assign hm3_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv7_hburst = 3'h0;
     assign mst3_slv7_hprot  = 4'h0;
     assign mst3_slv7_hsize  = 3'h0;
     assign mst3_slv7_htrans = 2'h0;
     assign mst3_slv7_hwrite = 1'b0;
     assign mst3_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S7) begin : gen_m4s7
  assign mst4_hs7_hrdata  = hs7_hrdata;
  assign mst4_hs7_hready  = hs7_hready;
  assign mst4_hs7_hresp   = hs7_hresp;
  assign mst4_slv7_base   = slv7_base;
  assign mst4_slv7_size   = slv7_size;
  assign mst4_slv7_grant  = mst4_slv7_ack;
  assign hm4_slv7_hwdata  = hm4_hwdata;
  assign mst4_slv7_haddr  = mst4_haddr;
  assign mst4_slv7_hburst = mst4_hburst;
  assign mst4_slv7_hprot  = mst4_hprot;
  assign mst4_slv7_hsize  = mst4_hsize;
  assign mst4_slv7_htrans = mst4_htrans;
  assign mst4_slv7_hwrite = mst4_hwrite;
  assign mst4_slv7_req    = mst4_slv7_sel;
end
else begin : gen_m4s7_nonexistent
     assign mst4_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs7_hready  = 1'b0;
     assign mst4_hs7_hresp   = 2'h0;
     assign mst4_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv7_size   = 4'h0;
     assign mst4_slv7_grant  = 1'b0;
     assign hm4_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv7_hburst = 3'h0;
     assign mst4_slv7_hprot  = 4'h0;
     assign mst4_slv7_hsize  = 3'h0;
     assign mst4_slv7_htrans = 2'h0;
     assign mst4_slv7_hwrite = 1'b0;
     assign mst4_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S7) begin : gen_m5s7
  assign mst5_hs7_hrdata  = hs7_hrdata;
  assign mst5_hs7_hready  = hs7_hready;
  assign mst5_hs7_hresp   = hs7_hresp;
  assign mst5_slv7_base   = slv7_base;
  assign mst5_slv7_size   = slv7_size;
  assign mst5_slv7_grant  = mst5_slv7_ack;
  assign hm5_slv7_hwdata  = hm5_hwdata;
  assign mst5_slv7_haddr  = mst5_haddr;
  assign mst5_slv7_hburst = mst5_hburst;
  assign mst5_slv7_hprot  = mst5_hprot;
  assign mst5_slv7_hsize  = mst5_hsize;
  assign mst5_slv7_htrans = mst5_htrans;
  assign mst5_slv7_hwrite = mst5_hwrite;
  assign mst5_slv7_req    = mst5_slv7_sel;
end
else begin : gen_m5s7_nonexistent
     assign mst5_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs7_hready  = 1'b0;
     assign mst5_hs7_hresp   = 2'h0;
     assign mst5_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv7_size   = 4'h0;
     assign mst5_slv7_grant  = 1'b0;
     assign hm5_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv7_hburst = 3'h0;
     assign mst5_slv7_hprot  = 4'h0;
     assign mst5_slv7_hsize  = 3'h0;
     assign mst5_slv7_htrans = 2'h0;
     assign mst5_slv7_hwrite = 1'b0;
     assign mst5_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S7) begin : gen_m6s7
  assign mst6_hs7_hrdata  = hs7_hrdata;
  assign mst6_hs7_hready  = hs7_hready;
  assign mst6_hs7_hresp   = hs7_hresp;
  assign mst6_slv7_base   = slv7_base;
  assign mst6_slv7_size   = slv7_size;
  assign mst6_slv7_grant  = mst6_slv7_ack;
  assign hm6_slv7_hwdata  = hm6_hwdata;
  assign mst6_slv7_haddr  = mst6_haddr;
  assign mst6_slv7_hburst = mst6_hburst;
  assign mst6_slv7_hprot  = mst6_hprot;
  assign mst6_slv7_hsize  = mst6_hsize;
  assign mst6_slv7_htrans = mst6_htrans;
  assign mst6_slv7_hwrite = mst6_hwrite;
  assign mst6_slv7_req    = mst6_slv7_sel;
end
else begin : gen_m6s7_nonexistent
     assign mst6_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs7_hready  = 1'b0;
     assign mst6_hs7_hresp   = 2'h0;
     assign mst6_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv7_size   = 4'h0;
     assign mst6_slv7_grant  = 1'b0;
     assign hm6_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv7_hburst = 3'h0;
     assign mst6_slv7_hprot  = 4'h0;
     assign mst6_slv7_hsize  = 3'h0;
     assign mst6_slv7_htrans = 2'h0;
     assign mst6_slv7_hwrite = 1'b0;
     assign mst6_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S7) begin : gen_m7s7
  assign mst7_hs7_hrdata  = hs7_hrdata;
  assign mst7_hs7_hready  = hs7_hready;
  assign mst7_hs7_hresp   = hs7_hresp;
  assign mst7_slv7_base   = slv7_base;
  assign mst7_slv7_size   = slv7_size;
  assign mst7_slv7_grant  = mst7_slv7_ack;
  assign hm7_slv7_hwdata  = hm7_hwdata;
  assign mst7_slv7_haddr  = mst7_haddr;
  assign mst7_slv7_hburst = mst7_hburst;
  assign mst7_slv7_hprot  = mst7_hprot;
  assign mst7_slv7_hsize  = mst7_hsize;
  assign mst7_slv7_htrans = mst7_htrans;
  assign mst7_slv7_hwrite = mst7_hwrite;
  assign mst7_slv7_req    = mst7_slv7_sel;
end
else begin : gen_m7s7_nonexistent
     assign mst7_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs7_hready  = 1'b0;
     assign mst7_hs7_hresp   = 2'h0;
     assign mst7_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv7_size   = 4'h0;
     assign mst7_slv7_grant  = 1'b0;
     assign hm7_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv7_hburst = 3'h0;
     assign mst7_slv7_hprot  = 4'h0;
     assign mst7_slv7_hsize  = 3'h0;
     assign mst7_slv7_htrans = 2'h0;
     assign mst7_slv7_hwrite = 1'b0;
     assign mst7_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S7) begin : gen_m8s7
  assign mst8_hs7_hrdata  = hs7_hrdata;
  assign mst8_hs7_hready  = hs7_hready;
  assign mst8_hs7_hresp   = hs7_hresp;
  assign mst8_slv7_base   = slv7_base;
  assign mst8_slv7_size   = slv7_size;
  assign mst8_slv7_grant  = mst8_slv7_ack;
  assign hm8_slv7_hwdata  = hm8_hwdata;
  assign mst8_slv7_haddr  = mst8_haddr;
  assign mst8_slv7_hburst = mst8_hburst;
  assign mst8_slv7_hprot  = mst8_hprot;
  assign mst8_slv7_hsize  = mst8_hsize;
  assign mst8_slv7_htrans = mst8_htrans;
  assign mst8_slv7_hwrite = mst8_hwrite;
  assign mst8_slv7_req    = mst8_slv7_sel;
end
else begin : gen_m8s7_nonexistent
     assign mst8_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs7_hready  = 1'b0;
     assign mst8_hs7_hresp   = 2'h0;
     assign mst8_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv7_size   = 4'h0;
     assign mst8_slv7_grant  = 1'b0;
     assign hm8_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv7_hburst = 3'h0;
     assign mst8_slv7_hprot  = 4'h0;
     assign mst8_slv7_hsize  = 3'h0;
     assign mst8_slv7_htrans = 2'h0;
     assign mst8_slv7_hwrite = 1'b0;
     assign mst8_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S7) begin : gen_m9s7
  assign mst9_hs7_hrdata  = hs7_hrdata;
  assign mst9_hs7_hready  = hs7_hready;
  assign mst9_hs7_hresp   = hs7_hresp;
  assign mst9_slv7_base   = slv7_base;
  assign mst9_slv7_size   = slv7_size;
  assign mst9_slv7_grant  = mst9_slv7_ack;
  assign hm9_slv7_hwdata  = hm9_hwdata;
  assign mst9_slv7_haddr  = mst9_haddr;
  assign mst9_slv7_hburst = mst9_hburst;
  assign mst9_slv7_hprot  = mst9_hprot;
  assign mst9_slv7_hsize  = mst9_hsize;
  assign mst9_slv7_htrans = mst9_htrans;
  assign mst9_slv7_hwrite = mst9_hwrite;
  assign mst9_slv7_req    = mst9_slv7_sel;
end
else begin : gen_m9s7_nonexistent
     assign mst9_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs7_hready  = 1'b0;
     assign mst9_hs7_hresp   = 2'h0;
     assign mst9_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv7_size   = 4'h0;
     assign mst9_slv7_grant  = 1'b0;
     assign hm9_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv7_hburst = 3'h0;
     assign mst9_slv7_hprot  = 4'h0;
     assign mst9_slv7_hsize  = 3'h0;
     assign mst9_slv7_htrans = 2'h0;
     assign mst9_slv7_hwrite = 1'b0;
     assign mst9_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S7) begin : gen_m10s7
  assign mst10_hs7_hrdata  = hs7_hrdata;
  assign mst10_hs7_hready  = hs7_hready;
  assign mst10_hs7_hresp   = hs7_hresp;
  assign mst10_slv7_base   = slv7_base;
  assign mst10_slv7_size   = slv7_size;
  assign mst10_slv7_grant  = mst10_slv7_ack;
  assign hm10_slv7_hwdata  = hm10_hwdata;
  assign mst10_slv7_haddr  = mst10_haddr;
  assign mst10_slv7_hburst = mst10_hburst;
  assign mst10_slv7_hprot  = mst10_hprot;
  assign mst10_slv7_hsize  = mst10_hsize;
  assign mst10_slv7_htrans = mst10_htrans;
  assign mst10_slv7_hwrite = mst10_hwrite;
  assign mst10_slv7_req    = mst10_slv7_sel;
end
else begin : gen_m10s7_nonexistent
     assign mst10_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs7_hready  = 1'b0;
     assign mst10_hs7_hresp   = 2'h0;
     assign mst10_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv7_size   = 4'h0;
     assign mst10_slv7_grant  = 1'b0;
     assign hm10_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv7_hburst = 3'h0;
     assign mst10_slv7_hprot  = 4'h0;
     assign mst10_slv7_hsize  = 3'h0;
     assign mst10_slv7_htrans = 2'h0;
     assign mst10_slv7_hwrite = 1'b0;
     assign mst10_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S7) begin : gen_m11s7
  assign mst11_hs7_hrdata  = hs7_hrdata;
  assign mst11_hs7_hready  = hs7_hready;
  assign mst11_hs7_hresp   = hs7_hresp;
  assign mst11_slv7_base   = slv7_base;
  assign mst11_slv7_size   = slv7_size;
  assign mst11_slv7_grant  = mst11_slv7_ack;
  assign hm11_slv7_hwdata  = hm11_hwdata;
  assign mst11_slv7_haddr  = mst11_haddr;
  assign mst11_slv7_hburst = mst11_hburst;
  assign mst11_slv7_hprot  = mst11_hprot;
  assign mst11_slv7_hsize  = mst11_hsize;
  assign mst11_slv7_htrans = mst11_htrans;
  assign mst11_slv7_hwrite = mst11_hwrite;
  assign mst11_slv7_req    = mst11_slv7_sel;
end
else begin : gen_m11s7_nonexistent
     assign mst11_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs7_hready  = 1'b0;
     assign mst11_hs7_hresp   = 2'h0;
     assign mst11_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv7_size   = 4'h0;
     assign mst11_slv7_grant  = 1'b0;
     assign hm11_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv7_hburst = 3'h0;
     assign mst11_slv7_hprot  = 4'h0;
     assign mst11_slv7_hsize  = 3'h0;
     assign mst11_slv7_htrans = 2'h0;
     assign mst11_slv7_hwrite = 1'b0;
     assign mst11_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S7) begin : gen_m12s7
  assign mst12_hs7_hrdata  = hs7_hrdata;
  assign mst12_hs7_hready  = hs7_hready;
  assign mst12_hs7_hresp   = hs7_hresp;
  assign mst12_slv7_base   = slv7_base;
  assign mst12_slv7_size   = slv7_size;
  assign mst12_slv7_grant  = mst12_slv7_ack;
  assign hm12_slv7_hwdata  = hm12_hwdata;
  assign mst12_slv7_haddr  = mst12_haddr;
  assign mst12_slv7_hburst = mst12_hburst;
  assign mst12_slv7_hprot  = mst12_hprot;
  assign mst12_slv7_hsize  = mst12_hsize;
  assign mst12_slv7_htrans = mst12_htrans;
  assign mst12_slv7_hwrite = mst12_hwrite;
  assign mst12_slv7_req    = mst12_slv7_sel;
end
else begin : gen_m12s7_nonexistent
     assign mst12_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs7_hready  = 1'b0;
     assign mst12_hs7_hresp   = 2'h0;
     assign mst12_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv7_size   = 4'h0;
     assign mst12_slv7_grant  = 1'b0;
     assign hm12_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv7_hburst = 3'h0;
     assign mst12_slv7_hprot  = 4'h0;
     assign mst12_slv7_hsize  = 3'h0;
     assign mst12_slv7_htrans = 2'h0;
     assign mst12_slv7_hwrite = 1'b0;
     assign mst12_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S7) begin : gen_m13s7
  assign mst13_hs7_hrdata  = hs7_hrdata;
  assign mst13_hs7_hready  = hs7_hready;
  assign mst13_hs7_hresp   = hs7_hresp;
  assign mst13_slv7_base   = slv7_base;
  assign mst13_slv7_size   = slv7_size;
  assign mst13_slv7_grant  = mst13_slv7_ack;
  assign hm13_slv7_hwdata  = hm13_hwdata;
  assign mst13_slv7_haddr  = mst13_haddr;
  assign mst13_slv7_hburst = mst13_hburst;
  assign mst13_slv7_hprot  = mst13_hprot;
  assign mst13_slv7_hsize  = mst13_hsize;
  assign mst13_slv7_htrans = mst13_htrans;
  assign mst13_slv7_hwrite = mst13_hwrite;
  assign mst13_slv7_req    = mst13_slv7_sel;
end
else begin : gen_m13s7_nonexistent
     assign mst13_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs7_hready  = 1'b0;
     assign mst13_hs7_hresp   = 2'h0;
     assign mst13_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv7_size   = 4'h0;
     assign mst13_slv7_grant  = 1'b0;
     assign hm13_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv7_hburst = 3'h0;
     assign mst13_slv7_hprot  = 4'h0;
     assign mst13_slv7_hsize  = 3'h0;
     assign mst13_slv7_htrans = 2'h0;
     assign mst13_slv7_hwrite = 1'b0;
     assign mst13_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S7) begin : gen_m14s7
  assign mst14_hs7_hrdata  = hs7_hrdata;
  assign mst14_hs7_hready  = hs7_hready;
  assign mst14_hs7_hresp   = hs7_hresp;
  assign mst14_slv7_base   = slv7_base;
  assign mst14_slv7_size   = slv7_size;
  assign mst14_slv7_grant  = mst14_slv7_ack;
  assign hm14_slv7_hwdata  = hm14_hwdata;
  assign mst14_slv7_haddr  = mst14_haddr;
  assign mst14_slv7_hburst = mst14_hburst;
  assign mst14_slv7_hprot  = mst14_hprot;
  assign mst14_slv7_hsize  = mst14_hsize;
  assign mst14_slv7_htrans = mst14_htrans;
  assign mst14_slv7_hwrite = mst14_hwrite;
  assign mst14_slv7_req    = mst14_slv7_sel;
end
else begin : gen_m14s7_nonexistent
     assign mst14_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs7_hready  = 1'b0;
     assign mst14_hs7_hresp   = 2'h0;
     assign mst14_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv7_size   = 4'h0;
     assign mst14_slv7_grant  = 1'b0;
     assign hm14_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv7_hburst = 3'h0;
     assign mst14_slv7_hprot  = 4'h0;
     assign mst14_slv7_hsize  = 3'h0;
     assign mst14_slv7_htrans = 2'h0;
     assign mst14_slv7_hwrite = 1'b0;
     assign mst14_slv7_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S7) begin : gen_m15s7
  assign mst15_hs7_hrdata  = hs7_hrdata;
  assign mst15_hs7_hready  = hs7_hready;
  assign mst15_hs7_hresp   = hs7_hresp;
  assign mst15_slv7_base   = slv7_base;
  assign mst15_slv7_size   = slv7_size;
  assign mst15_slv7_grant  = mst15_slv7_ack;
  assign hm15_slv7_hwdata  = hm15_hwdata;
  assign mst15_slv7_haddr  = mst15_haddr;
  assign mst15_slv7_hburst = mst15_hburst;
  assign mst15_slv7_hprot  = mst15_hprot;
  assign mst15_slv7_hsize  = mst15_hsize;
  assign mst15_slv7_htrans = mst15_htrans;
  assign mst15_slv7_hwrite = mst15_hwrite;
  assign mst15_slv7_req    = mst15_slv7_sel;
end
else begin : gen_m15s7_nonexistent
     assign mst15_hs7_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs7_hready  = 1'b0;
     assign mst15_hs7_hresp   = 2'h0;
     assign mst15_slv7_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv7_size   = 4'h0;
     assign mst15_slv7_grant  = 1'b0;
     assign hm15_slv7_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv7_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv7_hburst = 3'h0;
     assign mst15_slv7_hprot  = 4'h0;
     assign mst15_slv7_hsize  = 3'h0;
     assign mst15_slv7_htrans = 2'h0;
     assign mst15_slv7_hwrite = 1'b0;
     assign mst15_slv7_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV8
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S8) begin : gen_m0s8
  assign mst0_hs8_hrdata  = hs8_hrdata;
  assign mst0_hs8_hready  = hs8_hready;
  assign mst0_hs8_hresp   = hs8_hresp;
  assign mst0_slv8_base   = slv8_base;
  assign mst0_slv8_size   = slv8_size;
  assign mst0_slv8_grant  = mst0_slv8_ack;
  assign hm0_slv8_hwdata  = hm0_hwdata;
  assign mst0_slv8_haddr  = mst0_haddr;
  assign mst0_slv8_hburst = mst0_hburst;
  assign mst0_slv8_hprot  = mst0_hprot;
  assign mst0_slv8_hsize  = mst0_hsize;
  assign mst0_slv8_htrans = mst0_htrans;
  assign mst0_slv8_hwrite = mst0_hwrite;
  assign mst0_slv8_req    = mst0_slv8_sel;
end
else begin : gen_m0s8_nonexistent
     assign mst0_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs8_hready  = 1'b0;
     assign mst0_hs8_hresp   = 2'h0;
     assign mst0_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv8_size   = 4'h0;
     assign mst0_slv8_grant  = 1'b0;
     assign hm0_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv8_hburst = 3'h0;
     assign mst0_slv8_hprot  = 4'h0;
     assign mst0_slv8_hsize  = 3'h0;
     assign mst0_slv8_htrans = 2'h0;
     assign mst0_slv8_hwrite = 1'b0;
     assign mst0_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S8) begin : gen_m1s8
  assign mst1_hs8_hrdata  = hs8_hrdata;
  assign mst1_hs8_hready  = hs8_hready;
  assign mst1_hs8_hresp   = hs8_hresp;
  assign mst1_slv8_base   = slv8_base;
  assign mst1_slv8_size   = slv8_size;
  assign mst1_slv8_grant  = mst1_slv8_ack;
  assign hm1_slv8_hwdata  = hm1_hwdata;
  assign mst1_slv8_haddr  = mst1_haddr;
  assign mst1_slv8_hburst = mst1_hburst;
  assign mst1_slv8_hprot  = mst1_hprot;
  assign mst1_slv8_hsize  = mst1_hsize;
  assign mst1_slv8_htrans = mst1_htrans;
  assign mst1_slv8_hwrite = mst1_hwrite;
  assign mst1_slv8_req    = mst1_slv8_sel;
end
else begin : gen_m1s8_nonexistent
     assign mst1_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs8_hready  = 1'b0;
     assign mst1_hs8_hresp   = 2'h0;
     assign mst1_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv8_size   = 4'h0;
     assign mst1_slv8_grant  = 1'b0;
     assign hm1_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv8_hburst = 3'h0;
     assign mst1_slv8_hprot  = 4'h0;
     assign mst1_slv8_hsize  = 3'h0;
     assign mst1_slv8_htrans = 2'h0;
     assign mst1_slv8_hwrite = 1'b0;
     assign mst1_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S8) begin : gen_m2s8
  assign mst2_hs8_hrdata  = hs8_hrdata;
  assign mst2_hs8_hready  = hs8_hready;
  assign mst2_hs8_hresp   = hs8_hresp;
  assign mst2_slv8_base   = slv8_base;
  assign mst2_slv8_size   = slv8_size;
  assign mst2_slv8_grant  = mst2_slv8_ack;
  assign hm2_slv8_hwdata  = hm2_hwdata;
  assign mst2_slv8_haddr  = mst2_haddr;
  assign mst2_slv8_hburst = mst2_hburst;
  assign mst2_slv8_hprot  = mst2_hprot;
  assign mst2_slv8_hsize  = mst2_hsize;
  assign mst2_slv8_htrans = mst2_htrans;
  assign mst2_slv8_hwrite = mst2_hwrite;
  assign mst2_slv8_req    = mst2_slv8_sel;
end
else begin : gen_m2s8_nonexistent
     assign mst2_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs8_hready  = 1'b0;
     assign mst2_hs8_hresp   = 2'h0;
     assign mst2_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv8_size   = 4'h0;
     assign mst2_slv8_grant  = 1'b0;
     assign hm2_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv8_hburst = 3'h0;
     assign mst2_slv8_hprot  = 4'h0;
     assign mst2_slv8_hsize  = 3'h0;
     assign mst2_slv8_htrans = 2'h0;
     assign mst2_slv8_hwrite = 1'b0;
     assign mst2_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S8) begin : gen_m3s8
  assign mst3_hs8_hrdata  = hs8_hrdata;
  assign mst3_hs8_hready  = hs8_hready;
  assign mst3_hs8_hresp   = hs8_hresp;
  assign mst3_slv8_base   = slv8_base;
  assign mst3_slv8_size   = slv8_size;
  assign mst3_slv8_grant  = mst3_slv8_ack;
  assign hm3_slv8_hwdata  = hm3_hwdata;
  assign mst3_slv8_haddr  = mst3_haddr;
  assign mst3_slv8_hburst = mst3_hburst;
  assign mst3_slv8_hprot  = mst3_hprot;
  assign mst3_slv8_hsize  = mst3_hsize;
  assign mst3_slv8_htrans = mst3_htrans;
  assign mst3_slv8_hwrite = mst3_hwrite;
  assign mst3_slv8_req    = mst3_slv8_sel;
end
else begin : gen_m3s8_nonexistent
     assign mst3_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs8_hready  = 1'b0;
     assign mst3_hs8_hresp   = 2'h0;
     assign mst3_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv8_size   = 4'h0;
     assign mst3_slv8_grant  = 1'b0;
     assign hm3_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv8_hburst = 3'h0;
     assign mst3_slv8_hprot  = 4'h0;
     assign mst3_slv8_hsize  = 3'h0;
     assign mst3_slv8_htrans = 2'h0;
     assign mst3_slv8_hwrite = 1'b0;
     assign mst3_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S8) begin : gen_m4s8
  assign mst4_hs8_hrdata  = hs8_hrdata;
  assign mst4_hs8_hready  = hs8_hready;
  assign mst4_hs8_hresp   = hs8_hresp;
  assign mst4_slv8_base   = slv8_base;
  assign mst4_slv8_size   = slv8_size;
  assign mst4_slv8_grant  = mst4_slv8_ack;
  assign hm4_slv8_hwdata  = hm4_hwdata;
  assign mst4_slv8_haddr  = mst4_haddr;
  assign mst4_slv8_hburst = mst4_hburst;
  assign mst4_slv8_hprot  = mst4_hprot;
  assign mst4_slv8_hsize  = mst4_hsize;
  assign mst4_slv8_htrans = mst4_htrans;
  assign mst4_slv8_hwrite = mst4_hwrite;
  assign mst4_slv8_req    = mst4_slv8_sel;
end
else begin : gen_m4s8_nonexistent
     assign mst4_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs8_hready  = 1'b0;
     assign mst4_hs8_hresp   = 2'h0;
     assign mst4_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv8_size   = 4'h0;
     assign mst4_slv8_grant  = 1'b0;
     assign hm4_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv8_hburst = 3'h0;
     assign mst4_slv8_hprot  = 4'h0;
     assign mst4_slv8_hsize  = 3'h0;
     assign mst4_slv8_htrans = 2'h0;
     assign mst4_slv8_hwrite = 1'b0;
     assign mst4_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S8) begin : gen_m5s8
  assign mst5_hs8_hrdata  = hs8_hrdata;
  assign mst5_hs8_hready  = hs8_hready;
  assign mst5_hs8_hresp   = hs8_hresp;
  assign mst5_slv8_base   = slv8_base;
  assign mst5_slv8_size   = slv8_size;
  assign mst5_slv8_grant  = mst5_slv8_ack;
  assign hm5_slv8_hwdata  = hm5_hwdata;
  assign mst5_slv8_haddr  = mst5_haddr;
  assign mst5_slv8_hburst = mst5_hburst;
  assign mst5_slv8_hprot  = mst5_hprot;
  assign mst5_slv8_hsize  = mst5_hsize;
  assign mst5_slv8_htrans = mst5_htrans;
  assign mst5_slv8_hwrite = mst5_hwrite;
  assign mst5_slv8_req    = mst5_slv8_sel;
end
else begin : gen_m5s8_nonexistent
     assign mst5_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs8_hready  = 1'b0;
     assign mst5_hs8_hresp   = 2'h0;
     assign mst5_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv8_size   = 4'h0;
     assign mst5_slv8_grant  = 1'b0;
     assign hm5_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv8_hburst = 3'h0;
     assign mst5_slv8_hprot  = 4'h0;
     assign mst5_slv8_hsize  = 3'h0;
     assign mst5_slv8_htrans = 2'h0;
     assign mst5_slv8_hwrite = 1'b0;
     assign mst5_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S8) begin : gen_m6s8
  assign mst6_hs8_hrdata  = hs8_hrdata;
  assign mst6_hs8_hready  = hs8_hready;
  assign mst6_hs8_hresp   = hs8_hresp;
  assign mst6_slv8_base   = slv8_base;
  assign mst6_slv8_size   = slv8_size;
  assign mst6_slv8_grant  = mst6_slv8_ack;
  assign hm6_slv8_hwdata  = hm6_hwdata;
  assign mst6_slv8_haddr  = mst6_haddr;
  assign mst6_slv8_hburst = mst6_hburst;
  assign mst6_slv8_hprot  = mst6_hprot;
  assign mst6_slv8_hsize  = mst6_hsize;
  assign mst6_slv8_htrans = mst6_htrans;
  assign mst6_slv8_hwrite = mst6_hwrite;
  assign mst6_slv8_req    = mst6_slv8_sel;
end
else begin : gen_m6s8_nonexistent
     assign mst6_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs8_hready  = 1'b0;
     assign mst6_hs8_hresp   = 2'h0;
     assign mst6_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv8_size   = 4'h0;
     assign mst6_slv8_grant  = 1'b0;
     assign hm6_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv8_hburst = 3'h0;
     assign mst6_slv8_hprot  = 4'h0;
     assign mst6_slv8_hsize  = 3'h0;
     assign mst6_slv8_htrans = 2'h0;
     assign mst6_slv8_hwrite = 1'b0;
     assign mst6_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S8) begin : gen_m7s8
  assign mst7_hs8_hrdata  = hs8_hrdata;
  assign mst7_hs8_hready  = hs8_hready;
  assign mst7_hs8_hresp   = hs8_hresp;
  assign mst7_slv8_base   = slv8_base;
  assign mst7_slv8_size   = slv8_size;
  assign mst7_slv8_grant  = mst7_slv8_ack;
  assign hm7_slv8_hwdata  = hm7_hwdata;
  assign mst7_slv8_haddr  = mst7_haddr;
  assign mst7_slv8_hburst = mst7_hburst;
  assign mst7_slv8_hprot  = mst7_hprot;
  assign mst7_slv8_hsize  = mst7_hsize;
  assign mst7_slv8_htrans = mst7_htrans;
  assign mst7_slv8_hwrite = mst7_hwrite;
  assign mst7_slv8_req    = mst7_slv8_sel;
end
else begin : gen_m7s8_nonexistent
     assign mst7_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs8_hready  = 1'b0;
     assign mst7_hs8_hresp   = 2'h0;
     assign mst7_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv8_size   = 4'h0;
     assign mst7_slv8_grant  = 1'b0;
     assign hm7_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv8_hburst = 3'h0;
     assign mst7_slv8_hprot  = 4'h0;
     assign mst7_slv8_hsize  = 3'h0;
     assign mst7_slv8_htrans = 2'h0;
     assign mst7_slv8_hwrite = 1'b0;
     assign mst7_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S8) begin : gen_m8s8
  assign mst8_hs8_hrdata  = hs8_hrdata;
  assign mst8_hs8_hready  = hs8_hready;
  assign mst8_hs8_hresp   = hs8_hresp;
  assign mst8_slv8_base   = slv8_base;
  assign mst8_slv8_size   = slv8_size;
  assign mst8_slv8_grant  = mst8_slv8_ack;
  assign hm8_slv8_hwdata  = hm8_hwdata;
  assign mst8_slv8_haddr  = mst8_haddr;
  assign mst8_slv8_hburst = mst8_hburst;
  assign mst8_slv8_hprot  = mst8_hprot;
  assign mst8_slv8_hsize  = mst8_hsize;
  assign mst8_slv8_htrans = mst8_htrans;
  assign mst8_slv8_hwrite = mst8_hwrite;
  assign mst8_slv8_req    = mst8_slv8_sel;
end
else begin : gen_m8s8_nonexistent
     assign mst8_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs8_hready  = 1'b0;
     assign mst8_hs8_hresp   = 2'h0;
     assign mst8_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv8_size   = 4'h0;
     assign mst8_slv8_grant  = 1'b0;
     assign hm8_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv8_hburst = 3'h0;
     assign mst8_slv8_hprot  = 4'h0;
     assign mst8_slv8_hsize  = 3'h0;
     assign mst8_slv8_htrans = 2'h0;
     assign mst8_slv8_hwrite = 1'b0;
     assign mst8_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S8) begin : gen_m9s8
  assign mst9_hs8_hrdata  = hs8_hrdata;
  assign mst9_hs8_hready  = hs8_hready;
  assign mst9_hs8_hresp   = hs8_hresp;
  assign mst9_slv8_base   = slv8_base;
  assign mst9_slv8_size   = slv8_size;
  assign mst9_slv8_grant  = mst9_slv8_ack;
  assign hm9_slv8_hwdata  = hm9_hwdata;
  assign mst9_slv8_haddr  = mst9_haddr;
  assign mst9_slv8_hburst = mst9_hburst;
  assign mst9_slv8_hprot  = mst9_hprot;
  assign mst9_slv8_hsize  = mst9_hsize;
  assign mst9_slv8_htrans = mst9_htrans;
  assign mst9_slv8_hwrite = mst9_hwrite;
  assign mst9_slv8_req    = mst9_slv8_sel;
end
else begin : gen_m9s8_nonexistent
     assign mst9_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs8_hready  = 1'b0;
     assign mst9_hs8_hresp   = 2'h0;
     assign mst9_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv8_size   = 4'h0;
     assign mst9_slv8_grant  = 1'b0;
     assign hm9_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv8_hburst = 3'h0;
     assign mst9_slv8_hprot  = 4'h0;
     assign mst9_slv8_hsize  = 3'h0;
     assign mst9_slv8_htrans = 2'h0;
     assign mst9_slv8_hwrite = 1'b0;
     assign mst9_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S8) begin : gen_m10s8
  assign mst10_hs8_hrdata  = hs8_hrdata;
  assign mst10_hs8_hready  = hs8_hready;
  assign mst10_hs8_hresp   = hs8_hresp;
  assign mst10_slv8_base   = slv8_base;
  assign mst10_slv8_size   = slv8_size;
  assign mst10_slv8_grant  = mst10_slv8_ack;
  assign hm10_slv8_hwdata  = hm10_hwdata;
  assign mst10_slv8_haddr  = mst10_haddr;
  assign mst10_slv8_hburst = mst10_hburst;
  assign mst10_slv8_hprot  = mst10_hprot;
  assign mst10_slv8_hsize  = mst10_hsize;
  assign mst10_slv8_htrans = mst10_htrans;
  assign mst10_slv8_hwrite = mst10_hwrite;
  assign mst10_slv8_req    = mst10_slv8_sel;
end
else begin : gen_m10s8_nonexistent
     assign mst10_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs8_hready  = 1'b0;
     assign mst10_hs8_hresp   = 2'h0;
     assign mst10_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv8_size   = 4'h0;
     assign mst10_slv8_grant  = 1'b0;
     assign hm10_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv8_hburst = 3'h0;
     assign mst10_slv8_hprot  = 4'h0;
     assign mst10_slv8_hsize  = 3'h0;
     assign mst10_slv8_htrans = 2'h0;
     assign mst10_slv8_hwrite = 1'b0;
     assign mst10_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S8) begin : gen_m11s8
  assign mst11_hs8_hrdata  = hs8_hrdata;
  assign mst11_hs8_hready  = hs8_hready;
  assign mst11_hs8_hresp   = hs8_hresp;
  assign mst11_slv8_base   = slv8_base;
  assign mst11_slv8_size   = slv8_size;
  assign mst11_slv8_grant  = mst11_slv8_ack;
  assign hm11_slv8_hwdata  = hm11_hwdata;
  assign mst11_slv8_haddr  = mst11_haddr;
  assign mst11_slv8_hburst = mst11_hburst;
  assign mst11_slv8_hprot  = mst11_hprot;
  assign mst11_slv8_hsize  = mst11_hsize;
  assign mst11_slv8_htrans = mst11_htrans;
  assign mst11_slv8_hwrite = mst11_hwrite;
  assign mst11_slv8_req    = mst11_slv8_sel;
end
else begin : gen_m11s8_nonexistent
     assign mst11_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs8_hready  = 1'b0;
     assign mst11_hs8_hresp   = 2'h0;
     assign mst11_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv8_size   = 4'h0;
     assign mst11_slv8_grant  = 1'b0;
     assign hm11_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv8_hburst = 3'h0;
     assign mst11_slv8_hprot  = 4'h0;
     assign mst11_slv8_hsize  = 3'h0;
     assign mst11_slv8_htrans = 2'h0;
     assign mst11_slv8_hwrite = 1'b0;
     assign mst11_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S8) begin : gen_m12s8
  assign mst12_hs8_hrdata  = hs8_hrdata;
  assign mst12_hs8_hready  = hs8_hready;
  assign mst12_hs8_hresp   = hs8_hresp;
  assign mst12_slv8_base   = slv8_base;
  assign mst12_slv8_size   = slv8_size;
  assign mst12_slv8_grant  = mst12_slv8_ack;
  assign hm12_slv8_hwdata  = hm12_hwdata;
  assign mst12_slv8_haddr  = mst12_haddr;
  assign mst12_slv8_hburst = mst12_hburst;
  assign mst12_slv8_hprot  = mst12_hprot;
  assign mst12_slv8_hsize  = mst12_hsize;
  assign mst12_slv8_htrans = mst12_htrans;
  assign mst12_slv8_hwrite = mst12_hwrite;
  assign mst12_slv8_req    = mst12_slv8_sel;
end
else begin : gen_m12s8_nonexistent
     assign mst12_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs8_hready  = 1'b0;
     assign mst12_hs8_hresp   = 2'h0;
     assign mst12_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv8_size   = 4'h0;
     assign mst12_slv8_grant  = 1'b0;
     assign hm12_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv8_hburst = 3'h0;
     assign mst12_slv8_hprot  = 4'h0;
     assign mst12_slv8_hsize  = 3'h0;
     assign mst12_slv8_htrans = 2'h0;
     assign mst12_slv8_hwrite = 1'b0;
     assign mst12_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S8) begin : gen_m13s8
  assign mst13_hs8_hrdata  = hs8_hrdata;
  assign mst13_hs8_hready  = hs8_hready;
  assign mst13_hs8_hresp   = hs8_hresp;
  assign mst13_slv8_base   = slv8_base;
  assign mst13_slv8_size   = slv8_size;
  assign mst13_slv8_grant  = mst13_slv8_ack;
  assign hm13_slv8_hwdata  = hm13_hwdata;
  assign mst13_slv8_haddr  = mst13_haddr;
  assign mst13_slv8_hburst = mst13_hburst;
  assign mst13_slv8_hprot  = mst13_hprot;
  assign mst13_slv8_hsize  = mst13_hsize;
  assign mst13_slv8_htrans = mst13_htrans;
  assign mst13_slv8_hwrite = mst13_hwrite;
  assign mst13_slv8_req    = mst13_slv8_sel;
end
else begin : gen_m13s8_nonexistent
     assign mst13_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs8_hready  = 1'b0;
     assign mst13_hs8_hresp   = 2'h0;
     assign mst13_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv8_size   = 4'h0;
     assign mst13_slv8_grant  = 1'b0;
     assign hm13_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv8_hburst = 3'h0;
     assign mst13_slv8_hprot  = 4'h0;
     assign mst13_slv8_hsize  = 3'h0;
     assign mst13_slv8_htrans = 2'h0;
     assign mst13_slv8_hwrite = 1'b0;
     assign mst13_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S8) begin : gen_m14s8
  assign mst14_hs8_hrdata  = hs8_hrdata;
  assign mst14_hs8_hready  = hs8_hready;
  assign mst14_hs8_hresp   = hs8_hresp;
  assign mst14_slv8_base   = slv8_base;
  assign mst14_slv8_size   = slv8_size;
  assign mst14_slv8_grant  = mst14_slv8_ack;
  assign hm14_slv8_hwdata  = hm14_hwdata;
  assign mst14_slv8_haddr  = mst14_haddr;
  assign mst14_slv8_hburst = mst14_hburst;
  assign mst14_slv8_hprot  = mst14_hprot;
  assign mst14_slv8_hsize  = mst14_hsize;
  assign mst14_slv8_htrans = mst14_htrans;
  assign mst14_slv8_hwrite = mst14_hwrite;
  assign mst14_slv8_req    = mst14_slv8_sel;
end
else begin : gen_m14s8_nonexistent
     assign mst14_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs8_hready  = 1'b0;
     assign mst14_hs8_hresp   = 2'h0;
     assign mst14_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv8_size   = 4'h0;
     assign mst14_slv8_grant  = 1'b0;
     assign hm14_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv8_hburst = 3'h0;
     assign mst14_slv8_hprot  = 4'h0;
     assign mst14_slv8_hsize  = 3'h0;
     assign mst14_slv8_htrans = 2'h0;
     assign mst14_slv8_hwrite = 1'b0;
     assign mst14_slv8_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S8) begin : gen_m15s8
  assign mst15_hs8_hrdata  = hs8_hrdata;
  assign mst15_hs8_hready  = hs8_hready;
  assign mst15_hs8_hresp   = hs8_hresp;
  assign mst15_slv8_base   = slv8_base;
  assign mst15_slv8_size   = slv8_size;
  assign mst15_slv8_grant  = mst15_slv8_ack;
  assign hm15_slv8_hwdata  = hm15_hwdata;
  assign mst15_slv8_haddr  = mst15_haddr;
  assign mst15_slv8_hburst = mst15_hburst;
  assign mst15_slv8_hprot  = mst15_hprot;
  assign mst15_slv8_hsize  = mst15_hsize;
  assign mst15_slv8_htrans = mst15_htrans;
  assign mst15_slv8_hwrite = mst15_hwrite;
  assign mst15_slv8_req    = mst15_slv8_sel;
end
else begin : gen_m15s8_nonexistent
     assign mst15_hs8_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs8_hready  = 1'b0;
     assign mst15_hs8_hresp   = 2'h0;
     assign mst15_slv8_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv8_size   = 4'h0;
     assign mst15_slv8_grant  = 1'b0;
     assign hm15_slv8_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv8_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv8_hburst = 3'h0;
     assign mst15_slv8_hprot  = 4'h0;
     assign mst15_slv8_hsize  = 3'h0;
     assign mst15_slv8_htrans = 2'h0;
     assign mst15_slv8_hwrite = 1'b0;
     assign mst15_slv8_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV9
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S9) begin : gen_m0s9
  assign mst0_hs9_hrdata  = hs9_hrdata;
  assign mst0_hs9_hready  = hs9_hready;
  assign mst0_hs9_hresp   = hs9_hresp;
  assign mst0_slv9_base   = slv9_base;
  assign mst0_slv9_size   = slv9_size;
  assign mst0_slv9_grant  = mst0_slv9_ack;
  assign hm0_slv9_hwdata  = hm0_hwdata;
  assign mst0_slv9_haddr  = mst0_haddr;
  assign mst0_slv9_hburst = mst0_hburst;
  assign mst0_slv9_hprot  = mst0_hprot;
  assign mst0_slv9_hsize  = mst0_hsize;
  assign mst0_slv9_htrans = mst0_htrans;
  assign mst0_slv9_hwrite = mst0_hwrite;
  assign mst0_slv9_req    = mst0_slv9_sel;
end
else begin : gen_m0s9_nonexistent
     assign mst0_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs9_hready  = 1'b0;
     assign mst0_hs9_hresp   = 2'h0;
     assign mst0_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv9_size   = 4'h0;
     assign mst0_slv9_grant  = 1'b0;
     assign hm0_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv9_hburst = 3'h0;
     assign mst0_slv9_hprot  = 4'h0;
     assign mst0_slv9_hsize  = 3'h0;
     assign mst0_slv9_htrans = 2'h0;
     assign mst0_slv9_hwrite = 1'b0;
     assign mst0_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S9) begin : gen_m1s9
  assign mst1_hs9_hrdata  = hs9_hrdata;
  assign mst1_hs9_hready  = hs9_hready;
  assign mst1_hs9_hresp   = hs9_hresp;
  assign mst1_slv9_base   = slv9_base;
  assign mst1_slv9_size   = slv9_size;
  assign mst1_slv9_grant  = mst1_slv9_ack;
  assign hm1_slv9_hwdata  = hm1_hwdata;
  assign mst1_slv9_haddr  = mst1_haddr;
  assign mst1_slv9_hburst = mst1_hburst;
  assign mst1_slv9_hprot  = mst1_hprot;
  assign mst1_slv9_hsize  = mst1_hsize;
  assign mst1_slv9_htrans = mst1_htrans;
  assign mst1_slv9_hwrite = mst1_hwrite;
  assign mst1_slv9_req    = mst1_slv9_sel;
end
else begin : gen_m1s9_nonexistent
     assign mst1_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs9_hready  = 1'b0;
     assign mst1_hs9_hresp   = 2'h0;
     assign mst1_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv9_size   = 4'h0;
     assign mst1_slv9_grant  = 1'b0;
     assign hm1_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv9_hburst = 3'h0;
     assign mst1_slv9_hprot  = 4'h0;
     assign mst1_slv9_hsize  = 3'h0;
     assign mst1_slv9_htrans = 2'h0;
     assign mst1_slv9_hwrite = 1'b0;
     assign mst1_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S9) begin : gen_m2s9
  assign mst2_hs9_hrdata  = hs9_hrdata;
  assign mst2_hs9_hready  = hs9_hready;
  assign mst2_hs9_hresp   = hs9_hresp;
  assign mst2_slv9_base   = slv9_base;
  assign mst2_slv9_size   = slv9_size;
  assign mst2_slv9_grant  = mst2_slv9_ack;
  assign hm2_slv9_hwdata  = hm2_hwdata;
  assign mst2_slv9_haddr  = mst2_haddr;
  assign mst2_slv9_hburst = mst2_hburst;
  assign mst2_slv9_hprot  = mst2_hprot;
  assign mst2_slv9_hsize  = mst2_hsize;
  assign mst2_slv9_htrans = mst2_htrans;
  assign mst2_slv9_hwrite = mst2_hwrite;
  assign mst2_slv9_req    = mst2_slv9_sel;
end
else begin : gen_m2s9_nonexistent
     assign mst2_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs9_hready  = 1'b0;
     assign mst2_hs9_hresp   = 2'h0;
     assign mst2_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv9_size   = 4'h0;
     assign mst2_slv9_grant  = 1'b0;
     assign hm2_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv9_hburst = 3'h0;
     assign mst2_slv9_hprot  = 4'h0;
     assign mst2_slv9_hsize  = 3'h0;
     assign mst2_slv9_htrans = 2'h0;
     assign mst2_slv9_hwrite = 1'b0;
     assign mst2_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S9) begin : gen_m3s9
  assign mst3_hs9_hrdata  = hs9_hrdata;
  assign mst3_hs9_hready  = hs9_hready;
  assign mst3_hs9_hresp   = hs9_hresp;
  assign mst3_slv9_base   = slv9_base;
  assign mst3_slv9_size   = slv9_size;
  assign mst3_slv9_grant  = mst3_slv9_ack;
  assign hm3_slv9_hwdata  = hm3_hwdata;
  assign mst3_slv9_haddr  = mst3_haddr;
  assign mst3_slv9_hburst = mst3_hburst;
  assign mst3_slv9_hprot  = mst3_hprot;
  assign mst3_slv9_hsize  = mst3_hsize;
  assign mst3_slv9_htrans = mst3_htrans;
  assign mst3_slv9_hwrite = mst3_hwrite;
  assign mst3_slv9_req    = mst3_slv9_sel;
end
else begin : gen_m3s9_nonexistent
     assign mst3_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs9_hready  = 1'b0;
     assign mst3_hs9_hresp   = 2'h0;
     assign mst3_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv9_size   = 4'h0;
     assign mst3_slv9_grant  = 1'b0;
     assign hm3_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv9_hburst = 3'h0;
     assign mst3_slv9_hprot  = 4'h0;
     assign mst3_slv9_hsize  = 3'h0;
     assign mst3_slv9_htrans = 2'h0;
     assign mst3_slv9_hwrite = 1'b0;
     assign mst3_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S9) begin : gen_m4s9
  assign mst4_hs9_hrdata  = hs9_hrdata;
  assign mst4_hs9_hready  = hs9_hready;
  assign mst4_hs9_hresp   = hs9_hresp;
  assign mst4_slv9_base   = slv9_base;
  assign mst4_slv9_size   = slv9_size;
  assign mst4_slv9_grant  = mst4_slv9_ack;
  assign hm4_slv9_hwdata  = hm4_hwdata;
  assign mst4_slv9_haddr  = mst4_haddr;
  assign mst4_slv9_hburst = mst4_hburst;
  assign mst4_slv9_hprot  = mst4_hprot;
  assign mst4_slv9_hsize  = mst4_hsize;
  assign mst4_slv9_htrans = mst4_htrans;
  assign mst4_slv9_hwrite = mst4_hwrite;
  assign mst4_slv9_req    = mst4_slv9_sel;
end
else begin : gen_m4s9_nonexistent
     assign mst4_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs9_hready  = 1'b0;
     assign mst4_hs9_hresp   = 2'h0;
     assign mst4_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv9_size   = 4'h0;
     assign mst4_slv9_grant  = 1'b0;
     assign hm4_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv9_hburst = 3'h0;
     assign mst4_slv9_hprot  = 4'h0;
     assign mst4_slv9_hsize  = 3'h0;
     assign mst4_slv9_htrans = 2'h0;
     assign mst4_slv9_hwrite = 1'b0;
     assign mst4_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S9) begin : gen_m5s9
  assign mst5_hs9_hrdata  = hs9_hrdata;
  assign mst5_hs9_hready  = hs9_hready;
  assign mst5_hs9_hresp   = hs9_hresp;
  assign mst5_slv9_base   = slv9_base;
  assign mst5_slv9_size   = slv9_size;
  assign mst5_slv9_grant  = mst5_slv9_ack;
  assign hm5_slv9_hwdata  = hm5_hwdata;
  assign mst5_slv9_haddr  = mst5_haddr;
  assign mst5_slv9_hburst = mst5_hburst;
  assign mst5_slv9_hprot  = mst5_hprot;
  assign mst5_slv9_hsize  = mst5_hsize;
  assign mst5_slv9_htrans = mst5_htrans;
  assign mst5_slv9_hwrite = mst5_hwrite;
  assign mst5_slv9_req    = mst5_slv9_sel;
end
else begin : gen_m5s9_nonexistent
     assign mst5_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs9_hready  = 1'b0;
     assign mst5_hs9_hresp   = 2'h0;
     assign mst5_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv9_size   = 4'h0;
     assign mst5_slv9_grant  = 1'b0;
     assign hm5_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv9_hburst = 3'h0;
     assign mst5_slv9_hprot  = 4'h0;
     assign mst5_slv9_hsize  = 3'h0;
     assign mst5_slv9_htrans = 2'h0;
     assign mst5_slv9_hwrite = 1'b0;
     assign mst5_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S9) begin : gen_m6s9
  assign mst6_hs9_hrdata  = hs9_hrdata;
  assign mst6_hs9_hready  = hs9_hready;
  assign mst6_hs9_hresp   = hs9_hresp;
  assign mst6_slv9_base   = slv9_base;
  assign mst6_slv9_size   = slv9_size;
  assign mst6_slv9_grant  = mst6_slv9_ack;
  assign hm6_slv9_hwdata  = hm6_hwdata;
  assign mst6_slv9_haddr  = mst6_haddr;
  assign mst6_slv9_hburst = mst6_hburst;
  assign mst6_slv9_hprot  = mst6_hprot;
  assign mst6_slv9_hsize  = mst6_hsize;
  assign mst6_slv9_htrans = mst6_htrans;
  assign mst6_slv9_hwrite = mst6_hwrite;
  assign mst6_slv9_req    = mst6_slv9_sel;
end
else begin : gen_m6s9_nonexistent
     assign mst6_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs9_hready  = 1'b0;
     assign mst6_hs9_hresp   = 2'h0;
     assign mst6_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv9_size   = 4'h0;
     assign mst6_slv9_grant  = 1'b0;
     assign hm6_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv9_hburst = 3'h0;
     assign mst6_slv9_hprot  = 4'h0;
     assign mst6_slv9_hsize  = 3'h0;
     assign mst6_slv9_htrans = 2'h0;
     assign mst6_slv9_hwrite = 1'b0;
     assign mst6_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S9) begin : gen_m7s9
  assign mst7_hs9_hrdata  = hs9_hrdata;
  assign mst7_hs9_hready  = hs9_hready;
  assign mst7_hs9_hresp   = hs9_hresp;
  assign mst7_slv9_base   = slv9_base;
  assign mst7_slv9_size   = slv9_size;
  assign mst7_slv9_grant  = mst7_slv9_ack;
  assign hm7_slv9_hwdata  = hm7_hwdata;
  assign mst7_slv9_haddr  = mst7_haddr;
  assign mst7_slv9_hburst = mst7_hburst;
  assign mst7_slv9_hprot  = mst7_hprot;
  assign mst7_slv9_hsize  = mst7_hsize;
  assign mst7_slv9_htrans = mst7_htrans;
  assign mst7_slv9_hwrite = mst7_hwrite;
  assign mst7_slv9_req    = mst7_slv9_sel;
end
else begin : gen_m7s9_nonexistent
     assign mst7_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs9_hready  = 1'b0;
     assign mst7_hs9_hresp   = 2'h0;
     assign mst7_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv9_size   = 4'h0;
     assign mst7_slv9_grant  = 1'b0;
     assign hm7_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv9_hburst = 3'h0;
     assign mst7_slv9_hprot  = 4'h0;
     assign mst7_slv9_hsize  = 3'h0;
     assign mst7_slv9_htrans = 2'h0;
     assign mst7_slv9_hwrite = 1'b0;
     assign mst7_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S9) begin : gen_m8s9
  assign mst8_hs9_hrdata  = hs9_hrdata;
  assign mst8_hs9_hready  = hs9_hready;
  assign mst8_hs9_hresp   = hs9_hresp;
  assign mst8_slv9_base   = slv9_base;
  assign mst8_slv9_size   = slv9_size;
  assign mst8_slv9_grant  = mst8_slv9_ack;
  assign hm8_slv9_hwdata  = hm8_hwdata;
  assign mst8_slv9_haddr  = mst8_haddr;
  assign mst8_slv9_hburst = mst8_hburst;
  assign mst8_slv9_hprot  = mst8_hprot;
  assign mst8_slv9_hsize  = mst8_hsize;
  assign mst8_slv9_htrans = mst8_htrans;
  assign mst8_slv9_hwrite = mst8_hwrite;
  assign mst8_slv9_req    = mst8_slv9_sel;
end
else begin : gen_m8s9_nonexistent
     assign mst8_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs9_hready  = 1'b0;
     assign mst8_hs9_hresp   = 2'h0;
     assign mst8_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv9_size   = 4'h0;
     assign mst8_slv9_grant  = 1'b0;
     assign hm8_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv9_hburst = 3'h0;
     assign mst8_slv9_hprot  = 4'h0;
     assign mst8_slv9_hsize  = 3'h0;
     assign mst8_slv9_htrans = 2'h0;
     assign mst8_slv9_hwrite = 1'b0;
     assign mst8_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S9) begin : gen_m9s9
  assign mst9_hs9_hrdata  = hs9_hrdata;
  assign mst9_hs9_hready  = hs9_hready;
  assign mst9_hs9_hresp   = hs9_hresp;
  assign mst9_slv9_base   = slv9_base;
  assign mst9_slv9_size   = slv9_size;
  assign mst9_slv9_grant  = mst9_slv9_ack;
  assign hm9_slv9_hwdata  = hm9_hwdata;
  assign mst9_slv9_haddr  = mst9_haddr;
  assign mst9_slv9_hburst = mst9_hburst;
  assign mst9_slv9_hprot  = mst9_hprot;
  assign mst9_slv9_hsize  = mst9_hsize;
  assign mst9_slv9_htrans = mst9_htrans;
  assign mst9_slv9_hwrite = mst9_hwrite;
  assign mst9_slv9_req    = mst9_slv9_sel;
end
else begin : gen_m9s9_nonexistent
     assign mst9_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs9_hready  = 1'b0;
     assign mst9_hs9_hresp   = 2'h0;
     assign mst9_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv9_size   = 4'h0;
     assign mst9_slv9_grant  = 1'b0;
     assign hm9_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv9_hburst = 3'h0;
     assign mst9_slv9_hprot  = 4'h0;
     assign mst9_slv9_hsize  = 3'h0;
     assign mst9_slv9_htrans = 2'h0;
     assign mst9_slv9_hwrite = 1'b0;
     assign mst9_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S9) begin : gen_m10s9
  assign mst10_hs9_hrdata  = hs9_hrdata;
  assign mst10_hs9_hready  = hs9_hready;
  assign mst10_hs9_hresp   = hs9_hresp;
  assign mst10_slv9_base   = slv9_base;
  assign mst10_slv9_size   = slv9_size;
  assign mst10_slv9_grant  = mst10_slv9_ack;
  assign hm10_slv9_hwdata  = hm10_hwdata;
  assign mst10_slv9_haddr  = mst10_haddr;
  assign mst10_slv9_hburst = mst10_hburst;
  assign mst10_slv9_hprot  = mst10_hprot;
  assign mst10_slv9_hsize  = mst10_hsize;
  assign mst10_slv9_htrans = mst10_htrans;
  assign mst10_slv9_hwrite = mst10_hwrite;
  assign mst10_slv9_req    = mst10_slv9_sel;
end
else begin : gen_m10s9_nonexistent
     assign mst10_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs9_hready  = 1'b0;
     assign mst10_hs9_hresp   = 2'h0;
     assign mst10_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv9_size   = 4'h0;
     assign mst10_slv9_grant  = 1'b0;
     assign hm10_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv9_hburst = 3'h0;
     assign mst10_slv9_hprot  = 4'h0;
     assign mst10_slv9_hsize  = 3'h0;
     assign mst10_slv9_htrans = 2'h0;
     assign mst10_slv9_hwrite = 1'b0;
     assign mst10_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S9) begin : gen_m11s9
  assign mst11_hs9_hrdata  = hs9_hrdata;
  assign mst11_hs9_hready  = hs9_hready;
  assign mst11_hs9_hresp   = hs9_hresp;
  assign mst11_slv9_base   = slv9_base;
  assign mst11_slv9_size   = slv9_size;
  assign mst11_slv9_grant  = mst11_slv9_ack;
  assign hm11_slv9_hwdata  = hm11_hwdata;
  assign mst11_slv9_haddr  = mst11_haddr;
  assign mst11_slv9_hburst = mst11_hburst;
  assign mst11_slv9_hprot  = mst11_hprot;
  assign mst11_slv9_hsize  = mst11_hsize;
  assign mst11_slv9_htrans = mst11_htrans;
  assign mst11_slv9_hwrite = mst11_hwrite;
  assign mst11_slv9_req    = mst11_slv9_sel;
end
else begin : gen_m11s9_nonexistent
     assign mst11_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs9_hready  = 1'b0;
     assign mst11_hs9_hresp   = 2'h0;
     assign mst11_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv9_size   = 4'h0;
     assign mst11_slv9_grant  = 1'b0;
     assign hm11_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv9_hburst = 3'h0;
     assign mst11_slv9_hprot  = 4'h0;
     assign mst11_slv9_hsize  = 3'h0;
     assign mst11_slv9_htrans = 2'h0;
     assign mst11_slv9_hwrite = 1'b0;
     assign mst11_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S9) begin : gen_m12s9
  assign mst12_hs9_hrdata  = hs9_hrdata;
  assign mst12_hs9_hready  = hs9_hready;
  assign mst12_hs9_hresp   = hs9_hresp;
  assign mst12_slv9_base   = slv9_base;
  assign mst12_slv9_size   = slv9_size;
  assign mst12_slv9_grant  = mst12_slv9_ack;
  assign hm12_slv9_hwdata  = hm12_hwdata;
  assign mst12_slv9_haddr  = mst12_haddr;
  assign mst12_slv9_hburst = mst12_hburst;
  assign mst12_slv9_hprot  = mst12_hprot;
  assign mst12_slv9_hsize  = mst12_hsize;
  assign mst12_slv9_htrans = mst12_htrans;
  assign mst12_slv9_hwrite = mst12_hwrite;
  assign mst12_slv9_req    = mst12_slv9_sel;
end
else begin : gen_m12s9_nonexistent
     assign mst12_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs9_hready  = 1'b0;
     assign mst12_hs9_hresp   = 2'h0;
     assign mst12_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv9_size   = 4'h0;
     assign mst12_slv9_grant  = 1'b0;
     assign hm12_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv9_hburst = 3'h0;
     assign mst12_slv9_hprot  = 4'h0;
     assign mst12_slv9_hsize  = 3'h0;
     assign mst12_slv9_htrans = 2'h0;
     assign mst12_slv9_hwrite = 1'b0;
     assign mst12_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S9) begin : gen_m13s9
  assign mst13_hs9_hrdata  = hs9_hrdata;
  assign mst13_hs9_hready  = hs9_hready;
  assign mst13_hs9_hresp   = hs9_hresp;
  assign mst13_slv9_base   = slv9_base;
  assign mst13_slv9_size   = slv9_size;
  assign mst13_slv9_grant  = mst13_slv9_ack;
  assign hm13_slv9_hwdata  = hm13_hwdata;
  assign mst13_slv9_haddr  = mst13_haddr;
  assign mst13_slv9_hburst = mst13_hburst;
  assign mst13_slv9_hprot  = mst13_hprot;
  assign mst13_slv9_hsize  = mst13_hsize;
  assign mst13_slv9_htrans = mst13_htrans;
  assign mst13_slv9_hwrite = mst13_hwrite;
  assign mst13_slv9_req    = mst13_slv9_sel;
end
else begin : gen_m13s9_nonexistent
     assign mst13_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs9_hready  = 1'b0;
     assign mst13_hs9_hresp   = 2'h0;
     assign mst13_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv9_size   = 4'h0;
     assign mst13_slv9_grant  = 1'b0;
     assign hm13_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv9_hburst = 3'h0;
     assign mst13_slv9_hprot  = 4'h0;
     assign mst13_slv9_hsize  = 3'h0;
     assign mst13_slv9_htrans = 2'h0;
     assign mst13_slv9_hwrite = 1'b0;
     assign mst13_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S9) begin : gen_m14s9
  assign mst14_hs9_hrdata  = hs9_hrdata;
  assign mst14_hs9_hready  = hs9_hready;
  assign mst14_hs9_hresp   = hs9_hresp;
  assign mst14_slv9_base   = slv9_base;
  assign mst14_slv9_size   = slv9_size;
  assign mst14_slv9_grant  = mst14_slv9_ack;
  assign hm14_slv9_hwdata  = hm14_hwdata;
  assign mst14_slv9_haddr  = mst14_haddr;
  assign mst14_slv9_hburst = mst14_hburst;
  assign mst14_slv9_hprot  = mst14_hprot;
  assign mst14_slv9_hsize  = mst14_hsize;
  assign mst14_slv9_htrans = mst14_htrans;
  assign mst14_slv9_hwrite = mst14_hwrite;
  assign mst14_slv9_req    = mst14_slv9_sel;
end
else begin : gen_m14s9_nonexistent
     assign mst14_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs9_hready  = 1'b0;
     assign mst14_hs9_hresp   = 2'h0;
     assign mst14_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv9_size   = 4'h0;
     assign mst14_slv9_grant  = 1'b0;
     assign hm14_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv9_hburst = 3'h0;
     assign mst14_slv9_hprot  = 4'h0;
     assign mst14_slv9_hsize  = 3'h0;
     assign mst14_slv9_htrans = 2'h0;
     assign mst14_slv9_hwrite = 1'b0;
     assign mst14_slv9_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S9) begin : gen_m15s9
  assign mst15_hs9_hrdata  = hs9_hrdata;
  assign mst15_hs9_hready  = hs9_hready;
  assign mst15_hs9_hresp   = hs9_hresp;
  assign mst15_slv9_base   = slv9_base;
  assign mst15_slv9_size   = slv9_size;
  assign mst15_slv9_grant  = mst15_slv9_ack;
  assign hm15_slv9_hwdata  = hm15_hwdata;
  assign mst15_slv9_haddr  = mst15_haddr;
  assign mst15_slv9_hburst = mst15_hburst;
  assign mst15_slv9_hprot  = mst15_hprot;
  assign mst15_slv9_hsize  = mst15_hsize;
  assign mst15_slv9_htrans = mst15_htrans;
  assign mst15_slv9_hwrite = mst15_hwrite;
  assign mst15_slv9_req    = mst15_slv9_sel;
end
else begin : gen_m15s9_nonexistent
     assign mst15_hs9_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs9_hready  = 1'b0;
     assign mst15_hs9_hresp   = 2'h0;
     assign mst15_slv9_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv9_size   = 4'h0;
     assign mst15_slv9_grant  = 1'b0;
     assign hm15_slv9_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv9_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv9_hburst = 3'h0;
     assign mst15_slv9_hprot  = 4'h0;
     assign mst15_slv9_hsize  = 3'h0;
     assign mst15_slv9_htrans = 2'h0;
     assign mst15_slv9_hwrite = 1'b0;
     assign mst15_slv9_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV10
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S10) begin : gen_m0s10
  assign mst0_hs10_hrdata  = hs10_hrdata;
  assign mst0_hs10_hready  = hs10_hready;
  assign mst0_hs10_hresp   = hs10_hresp;
  assign mst0_slv10_base   = slv10_base;
  assign mst0_slv10_size   = slv10_size;
  assign mst0_slv10_grant  = mst0_slv10_ack;
  assign hm0_slv10_hwdata  = hm0_hwdata;
  assign mst0_slv10_haddr  = mst0_haddr;
  assign mst0_slv10_hburst = mst0_hburst;
  assign mst0_slv10_hprot  = mst0_hprot;
  assign mst0_slv10_hsize  = mst0_hsize;
  assign mst0_slv10_htrans = mst0_htrans;
  assign mst0_slv10_hwrite = mst0_hwrite;
  assign mst0_slv10_req    = mst0_slv10_sel;
end
else begin : gen_m0s10_nonexistent
     assign mst0_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs10_hready  = 1'b0;
     assign mst0_hs10_hresp   = 2'h0;
     assign mst0_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv10_size   = 4'h0;
     assign mst0_slv10_grant  = 1'b0;
     assign hm0_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv10_hburst = 3'h0;
     assign mst0_slv10_hprot  = 4'h0;
     assign mst0_slv10_hsize  = 3'h0;
     assign mst0_slv10_htrans = 2'h0;
     assign mst0_slv10_hwrite = 1'b0;
     assign mst0_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S10) begin : gen_m1s10
  assign mst1_hs10_hrdata  = hs10_hrdata;
  assign mst1_hs10_hready  = hs10_hready;
  assign mst1_hs10_hresp   = hs10_hresp;
  assign mst1_slv10_base   = slv10_base;
  assign mst1_slv10_size   = slv10_size;
  assign mst1_slv10_grant  = mst1_slv10_ack;
  assign hm1_slv10_hwdata  = hm1_hwdata;
  assign mst1_slv10_haddr  = mst1_haddr;
  assign mst1_slv10_hburst = mst1_hburst;
  assign mst1_slv10_hprot  = mst1_hprot;
  assign mst1_slv10_hsize  = mst1_hsize;
  assign mst1_slv10_htrans = mst1_htrans;
  assign mst1_slv10_hwrite = mst1_hwrite;
  assign mst1_slv10_req    = mst1_slv10_sel;
end
else begin : gen_m1s10_nonexistent
     assign mst1_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs10_hready  = 1'b0;
     assign mst1_hs10_hresp   = 2'h0;
     assign mst1_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv10_size   = 4'h0;
     assign mst1_slv10_grant  = 1'b0;
     assign hm1_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv10_hburst = 3'h0;
     assign mst1_slv10_hprot  = 4'h0;
     assign mst1_slv10_hsize  = 3'h0;
     assign mst1_slv10_htrans = 2'h0;
     assign mst1_slv10_hwrite = 1'b0;
     assign mst1_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S10) begin : gen_m2s10
  assign mst2_hs10_hrdata  = hs10_hrdata;
  assign mst2_hs10_hready  = hs10_hready;
  assign mst2_hs10_hresp   = hs10_hresp;
  assign mst2_slv10_base   = slv10_base;
  assign mst2_slv10_size   = slv10_size;
  assign mst2_slv10_grant  = mst2_slv10_ack;
  assign hm2_slv10_hwdata  = hm2_hwdata;
  assign mst2_slv10_haddr  = mst2_haddr;
  assign mst2_slv10_hburst = mst2_hburst;
  assign mst2_slv10_hprot  = mst2_hprot;
  assign mst2_slv10_hsize  = mst2_hsize;
  assign mst2_slv10_htrans = mst2_htrans;
  assign mst2_slv10_hwrite = mst2_hwrite;
  assign mst2_slv10_req    = mst2_slv10_sel;
end
else begin : gen_m2s10_nonexistent
     assign mst2_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs10_hready  = 1'b0;
     assign mst2_hs10_hresp   = 2'h0;
     assign mst2_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv10_size   = 4'h0;
     assign mst2_slv10_grant  = 1'b0;
     assign hm2_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv10_hburst = 3'h0;
     assign mst2_slv10_hprot  = 4'h0;
     assign mst2_slv10_hsize  = 3'h0;
     assign mst2_slv10_htrans = 2'h0;
     assign mst2_slv10_hwrite = 1'b0;
     assign mst2_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S10) begin : gen_m3s10
  assign mst3_hs10_hrdata  = hs10_hrdata;
  assign mst3_hs10_hready  = hs10_hready;
  assign mst3_hs10_hresp   = hs10_hresp;
  assign mst3_slv10_base   = slv10_base;
  assign mst3_slv10_size   = slv10_size;
  assign mst3_slv10_grant  = mst3_slv10_ack;
  assign hm3_slv10_hwdata  = hm3_hwdata;
  assign mst3_slv10_haddr  = mst3_haddr;
  assign mst3_slv10_hburst = mst3_hburst;
  assign mst3_slv10_hprot  = mst3_hprot;
  assign mst3_slv10_hsize  = mst3_hsize;
  assign mst3_slv10_htrans = mst3_htrans;
  assign mst3_slv10_hwrite = mst3_hwrite;
  assign mst3_slv10_req    = mst3_slv10_sel;
end
else begin : gen_m3s10_nonexistent
     assign mst3_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs10_hready  = 1'b0;
     assign mst3_hs10_hresp   = 2'h0;
     assign mst3_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv10_size   = 4'h0;
     assign mst3_slv10_grant  = 1'b0;
     assign hm3_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv10_hburst = 3'h0;
     assign mst3_slv10_hprot  = 4'h0;
     assign mst3_slv10_hsize  = 3'h0;
     assign mst3_slv10_htrans = 2'h0;
     assign mst3_slv10_hwrite = 1'b0;
     assign mst3_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S10) begin : gen_m4s10
  assign mst4_hs10_hrdata  = hs10_hrdata;
  assign mst4_hs10_hready  = hs10_hready;
  assign mst4_hs10_hresp   = hs10_hresp;
  assign mst4_slv10_base   = slv10_base;
  assign mst4_slv10_size   = slv10_size;
  assign mst4_slv10_grant  = mst4_slv10_ack;
  assign hm4_slv10_hwdata  = hm4_hwdata;
  assign mst4_slv10_haddr  = mst4_haddr;
  assign mst4_slv10_hburst = mst4_hburst;
  assign mst4_slv10_hprot  = mst4_hprot;
  assign mst4_slv10_hsize  = mst4_hsize;
  assign mst4_slv10_htrans = mst4_htrans;
  assign mst4_slv10_hwrite = mst4_hwrite;
  assign mst4_slv10_req    = mst4_slv10_sel;
end
else begin : gen_m4s10_nonexistent
     assign mst4_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs10_hready  = 1'b0;
     assign mst4_hs10_hresp   = 2'h0;
     assign mst4_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv10_size   = 4'h0;
     assign mst4_slv10_grant  = 1'b0;
     assign hm4_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv10_hburst = 3'h0;
     assign mst4_slv10_hprot  = 4'h0;
     assign mst4_slv10_hsize  = 3'h0;
     assign mst4_slv10_htrans = 2'h0;
     assign mst4_slv10_hwrite = 1'b0;
     assign mst4_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S10) begin : gen_m5s10
  assign mst5_hs10_hrdata  = hs10_hrdata;
  assign mst5_hs10_hready  = hs10_hready;
  assign mst5_hs10_hresp   = hs10_hresp;
  assign mst5_slv10_base   = slv10_base;
  assign mst5_slv10_size   = slv10_size;
  assign mst5_slv10_grant  = mst5_slv10_ack;
  assign hm5_slv10_hwdata  = hm5_hwdata;
  assign mst5_slv10_haddr  = mst5_haddr;
  assign mst5_slv10_hburst = mst5_hburst;
  assign mst5_slv10_hprot  = mst5_hprot;
  assign mst5_slv10_hsize  = mst5_hsize;
  assign mst5_slv10_htrans = mst5_htrans;
  assign mst5_slv10_hwrite = mst5_hwrite;
  assign mst5_slv10_req    = mst5_slv10_sel;
end
else begin : gen_m5s10_nonexistent
     assign mst5_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs10_hready  = 1'b0;
     assign mst5_hs10_hresp   = 2'h0;
     assign mst5_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv10_size   = 4'h0;
     assign mst5_slv10_grant  = 1'b0;
     assign hm5_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv10_hburst = 3'h0;
     assign mst5_slv10_hprot  = 4'h0;
     assign mst5_slv10_hsize  = 3'h0;
     assign mst5_slv10_htrans = 2'h0;
     assign mst5_slv10_hwrite = 1'b0;
     assign mst5_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S10) begin : gen_m6s10
  assign mst6_hs10_hrdata  = hs10_hrdata;
  assign mst6_hs10_hready  = hs10_hready;
  assign mst6_hs10_hresp   = hs10_hresp;
  assign mst6_slv10_base   = slv10_base;
  assign mst6_slv10_size   = slv10_size;
  assign mst6_slv10_grant  = mst6_slv10_ack;
  assign hm6_slv10_hwdata  = hm6_hwdata;
  assign mst6_slv10_haddr  = mst6_haddr;
  assign mst6_slv10_hburst = mst6_hburst;
  assign mst6_slv10_hprot  = mst6_hprot;
  assign mst6_slv10_hsize  = mst6_hsize;
  assign mst6_slv10_htrans = mst6_htrans;
  assign mst6_slv10_hwrite = mst6_hwrite;
  assign mst6_slv10_req    = mst6_slv10_sel;
end
else begin : gen_m6s10_nonexistent
     assign mst6_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs10_hready  = 1'b0;
     assign mst6_hs10_hresp   = 2'h0;
     assign mst6_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv10_size   = 4'h0;
     assign mst6_slv10_grant  = 1'b0;
     assign hm6_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv10_hburst = 3'h0;
     assign mst6_slv10_hprot  = 4'h0;
     assign mst6_slv10_hsize  = 3'h0;
     assign mst6_slv10_htrans = 2'h0;
     assign mst6_slv10_hwrite = 1'b0;
     assign mst6_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S10) begin : gen_m7s10
  assign mst7_hs10_hrdata  = hs10_hrdata;
  assign mst7_hs10_hready  = hs10_hready;
  assign mst7_hs10_hresp   = hs10_hresp;
  assign mst7_slv10_base   = slv10_base;
  assign mst7_slv10_size   = slv10_size;
  assign mst7_slv10_grant  = mst7_slv10_ack;
  assign hm7_slv10_hwdata  = hm7_hwdata;
  assign mst7_slv10_haddr  = mst7_haddr;
  assign mst7_slv10_hburst = mst7_hburst;
  assign mst7_slv10_hprot  = mst7_hprot;
  assign mst7_slv10_hsize  = mst7_hsize;
  assign mst7_slv10_htrans = mst7_htrans;
  assign mst7_slv10_hwrite = mst7_hwrite;
  assign mst7_slv10_req    = mst7_slv10_sel;
end
else begin : gen_m7s10_nonexistent
     assign mst7_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs10_hready  = 1'b0;
     assign mst7_hs10_hresp   = 2'h0;
     assign mst7_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv10_size   = 4'h0;
     assign mst7_slv10_grant  = 1'b0;
     assign hm7_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv10_hburst = 3'h0;
     assign mst7_slv10_hprot  = 4'h0;
     assign mst7_slv10_hsize  = 3'h0;
     assign mst7_slv10_htrans = 2'h0;
     assign mst7_slv10_hwrite = 1'b0;
     assign mst7_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S10) begin : gen_m8s10
  assign mst8_hs10_hrdata  = hs10_hrdata;
  assign mst8_hs10_hready  = hs10_hready;
  assign mst8_hs10_hresp   = hs10_hresp;
  assign mst8_slv10_base   = slv10_base;
  assign mst8_slv10_size   = slv10_size;
  assign mst8_slv10_grant  = mst8_slv10_ack;
  assign hm8_slv10_hwdata  = hm8_hwdata;
  assign mst8_slv10_haddr  = mst8_haddr;
  assign mst8_slv10_hburst = mst8_hburst;
  assign mst8_slv10_hprot  = mst8_hprot;
  assign mst8_slv10_hsize  = mst8_hsize;
  assign mst8_slv10_htrans = mst8_htrans;
  assign mst8_slv10_hwrite = mst8_hwrite;
  assign mst8_slv10_req    = mst8_slv10_sel;
end
else begin : gen_m8s10_nonexistent
     assign mst8_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs10_hready  = 1'b0;
     assign mst8_hs10_hresp   = 2'h0;
     assign mst8_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv10_size   = 4'h0;
     assign mst8_slv10_grant  = 1'b0;
     assign hm8_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv10_hburst = 3'h0;
     assign mst8_slv10_hprot  = 4'h0;
     assign mst8_slv10_hsize  = 3'h0;
     assign mst8_slv10_htrans = 2'h0;
     assign mst8_slv10_hwrite = 1'b0;
     assign mst8_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S10) begin : gen_m9s10
  assign mst9_hs10_hrdata  = hs10_hrdata;
  assign mst9_hs10_hready  = hs10_hready;
  assign mst9_hs10_hresp   = hs10_hresp;
  assign mst9_slv10_base   = slv10_base;
  assign mst9_slv10_size   = slv10_size;
  assign mst9_slv10_grant  = mst9_slv10_ack;
  assign hm9_slv10_hwdata  = hm9_hwdata;
  assign mst9_slv10_haddr  = mst9_haddr;
  assign mst9_slv10_hburst = mst9_hburst;
  assign mst9_slv10_hprot  = mst9_hprot;
  assign mst9_slv10_hsize  = mst9_hsize;
  assign mst9_slv10_htrans = mst9_htrans;
  assign mst9_slv10_hwrite = mst9_hwrite;
  assign mst9_slv10_req    = mst9_slv10_sel;
end
else begin : gen_m9s10_nonexistent
     assign mst9_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs10_hready  = 1'b0;
     assign mst9_hs10_hresp   = 2'h0;
     assign mst9_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv10_size   = 4'h0;
     assign mst9_slv10_grant  = 1'b0;
     assign hm9_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv10_hburst = 3'h0;
     assign mst9_slv10_hprot  = 4'h0;
     assign mst9_slv10_hsize  = 3'h0;
     assign mst9_slv10_htrans = 2'h0;
     assign mst9_slv10_hwrite = 1'b0;
     assign mst9_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S10) begin : gen_m10s10
  assign mst10_hs10_hrdata  = hs10_hrdata;
  assign mst10_hs10_hready  = hs10_hready;
  assign mst10_hs10_hresp   = hs10_hresp;
  assign mst10_slv10_base   = slv10_base;
  assign mst10_slv10_size   = slv10_size;
  assign mst10_slv10_grant  = mst10_slv10_ack;
  assign hm10_slv10_hwdata  = hm10_hwdata;
  assign mst10_slv10_haddr  = mst10_haddr;
  assign mst10_slv10_hburst = mst10_hburst;
  assign mst10_slv10_hprot  = mst10_hprot;
  assign mst10_slv10_hsize  = mst10_hsize;
  assign mst10_slv10_htrans = mst10_htrans;
  assign mst10_slv10_hwrite = mst10_hwrite;
  assign mst10_slv10_req    = mst10_slv10_sel;
end
else begin : gen_m10s10_nonexistent
     assign mst10_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs10_hready  = 1'b0;
     assign mst10_hs10_hresp   = 2'h0;
     assign mst10_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv10_size   = 4'h0;
     assign mst10_slv10_grant  = 1'b0;
     assign hm10_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv10_hburst = 3'h0;
     assign mst10_slv10_hprot  = 4'h0;
     assign mst10_slv10_hsize  = 3'h0;
     assign mst10_slv10_htrans = 2'h0;
     assign mst10_slv10_hwrite = 1'b0;
     assign mst10_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S10) begin : gen_m11s10
  assign mst11_hs10_hrdata  = hs10_hrdata;
  assign mst11_hs10_hready  = hs10_hready;
  assign mst11_hs10_hresp   = hs10_hresp;
  assign mst11_slv10_base   = slv10_base;
  assign mst11_slv10_size   = slv10_size;
  assign mst11_slv10_grant  = mst11_slv10_ack;
  assign hm11_slv10_hwdata  = hm11_hwdata;
  assign mst11_slv10_haddr  = mst11_haddr;
  assign mst11_slv10_hburst = mst11_hburst;
  assign mst11_slv10_hprot  = mst11_hprot;
  assign mst11_slv10_hsize  = mst11_hsize;
  assign mst11_slv10_htrans = mst11_htrans;
  assign mst11_slv10_hwrite = mst11_hwrite;
  assign mst11_slv10_req    = mst11_slv10_sel;
end
else begin : gen_m11s10_nonexistent
     assign mst11_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs10_hready  = 1'b0;
     assign mst11_hs10_hresp   = 2'h0;
     assign mst11_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv10_size   = 4'h0;
     assign mst11_slv10_grant  = 1'b0;
     assign hm11_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv10_hburst = 3'h0;
     assign mst11_slv10_hprot  = 4'h0;
     assign mst11_slv10_hsize  = 3'h0;
     assign mst11_slv10_htrans = 2'h0;
     assign mst11_slv10_hwrite = 1'b0;
     assign mst11_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S10) begin : gen_m12s10
  assign mst12_hs10_hrdata  = hs10_hrdata;
  assign mst12_hs10_hready  = hs10_hready;
  assign mst12_hs10_hresp   = hs10_hresp;
  assign mst12_slv10_base   = slv10_base;
  assign mst12_slv10_size   = slv10_size;
  assign mst12_slv10_grant  = mst12_slv10_ack;
  assign hm12_slv10_hwdata  = hm12_hwdata;
  assign mst12_slv10_haddr  = mst12_haddr;
  assign mst12_slv10_hburst = mst12_hburst;
  assign mst12_slv10_hprot  = mst12_hprot;
  assign mst12_slv10_hsize  = mst12_hsize;
  assign mst12_slv10_htrans = mst12_htrans;
  assign mst12_slv10_hwrite = mst12_hwrite;
  assign mst12_slv10_req    = mst12_slv10_sel;
end
else begin : gen_m12s10_nonexistent
     assign mst12_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs10_hready  = 1'b0;
     assign mst12_hs10_hresp   = 2'h0;
     assign mst12_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv10_size   = 4'h0;
     assign mst12_slv10_grant  = 1'b0;
     assign hm12_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv10_hburst = 3'h0;
     assign mst12_slv10_hprot  = 4'h0;
     assign mst12_slv10_hsize  = 3'h0;
     assign mst12_slv10_htrans = 2'h0;
     assign mst12_slv10_hwrite = 1'b0;
     assign mst12_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S10) begin : gen_m13s10
  assign mst13_hs10_hrdata  = hs10_hrdata;
  assign mst13_hs10_hready  = hs10_hready;
  assign mst13_hs10_hresp   = hs10_hresp;
  assign mst13_slv10_base   = slv10_base;
  assign mst13_slv10_size   = slv10_size;
  assign mst13_slv10_grant  = mst13_slv10_ack;
  assign hm13_slv10_hwdata  = hm13_hwdata;
  assign mst13_slv10_haddr  = mst13_haddr;
  assign mst13_slv10_hburst = mst13_hburst;
  assign mst13_slv10_hprot  = mst13_hprot;
  assign mst13_slv10_hsize  = mst13_hsize;
  assign mst13_slv10_htrans = mst13_htrans;
  assign mst13_slv10_hwrite = mst13_hwrite;
  assign mst13_slv10_req    = mst13_slv10_sel;
end
else begin : gen_m13s10_nonexistent
     assign mst13_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs10_hready  = 1'b0;
     assign mst13_hs10_hresp   = 2'h0;
     assign mst13_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv10_size   = 4'h0;
     assign mst13_slv10_grant  = 1'b0;
     assign hm13_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv10_hburst = 3'h0;
     assign mst13_slv10_hprot  = 4'h0;
     assign mst13_slv10_hsize  = 3'h0;
     assign mst13_slv10_htrans = 2'h0;
     assign mst13_slv10_hwrite = 1'b0;
     assign mst13_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S10) begin : gen_m14s10
  assign mst14_hs10_hrdata  = hs10_hrdata;
  assign mst14_hs10_hready  = hs10_hready;
  assign mst14_hs10_hresp   = hs10_hresp;
  assign mst14_slv10_base   = slv10_base;
  assign mst14_slv10_size   = slv10_size;
  assign mst14_slv10_grant  = mst14_slv10_ack;
  assign hm14_slv10_hwdata  = hm14_hwdata;
  assign mst14_slv10_haddr  = mst14_haddr;
  assign mst14_slv10_hburst = mst14_hburst;
  assign mst14_slv10_hprot  = mst14_hprot;
  assign mst14_slv10_hsize  = mst14_hsize;
  assign mst14_slv10_htrans = mst14_htrans;
  assign mst14_slv10_hwrite = mst14_hwrite;
  assign mst14_slv10_req    = mst14_slv10_sel;
end
else begin : gen_m14s10_nonexistent
     assign mst14_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs10_hready  = 1'b0;
     assign mst14_hs10_hresp   = 2'h0;
     assign mst14_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv10_size   = 4'h0;
     assign mst14_slv10_grant  = 1'b0;
     assign hm14_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv10_hburst = 3'h0;
     assign mst14_slv10_hprot  = 4'h0;
     assign mst14_slv10_hsize  = 3'h0;
     assign mst14_slv10_htrans = 2'h0;
     assign mst14_slv10_hwrite = 1'b0;
     assign mst14_slv10_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S10) begin : gen_m15s10
  assign mst15_hs10_hrdata  = hs10_hrdata;
  assign mst15_hs10_hready  = hs10_hready;
  assign mst15_hs10_hresp   = hs10_hresp;
  assign mst15_slv10_base   = slv10_base;
  assign mst15_slv10_size   = slv10_size;
  assign mst15_slv10_grant  = mst15_slv10_ack;
  assign hm15_slv10_hwdata  = hm15_hwdata;
  assign mst15_slv10_haddr  = mst15_haddr;
  assign mst15_slv10_hburst = mst15_hburst;
  assign mst15_slv10_hprot  = mst15_hprot;
  assign mst15_slv10_hsize  = mst15_hsize;
  assign mst15_slv10_htrans = mst15_htrans;
  assign mst15_slv10_hwrite = mst15_hwrite;
  assign mst15_slv10_req    = mst15_slv10_sel;
end
else begin : gen_m15s10_nonexistent
     assign mst15_hs10_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs10_hready  = 1'b0;
     assign mst15_hs10_hresp   = 2'h0;
     assign mst15_slv10_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv10_size   = 4'h0;
     assign mst15_slv10_grant  = 1'b0;
     assign hm15_slv10_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv10_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv10_hburst = 3'h0;
     assign mst15_slv10_hprot  = 4'h0;
     assign mst15_slv10_hsize  = 3'h0;
     assign mst15_slv10_htrans = 2'h0;
     assign mst15_slv10_hwrite = 1'b0;
     assign mst15_slv10_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV11
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S11) begin : gen_m0s11
  assign mst0_hs11_hrdata  = hs11_hrdata;
  assign mst0_hs11_hready  = hs11_hready;
  assign mst0_hs11_hresp   = hs11_hresp;
  assign mst0_slv11_base   = slv11_base;
  assign mst0_slv11_size   = slv11_size;
  assign mst0_slv11_grant  = mst0_slv11_ack;
  assign hm0_slv11_hwdata  = hm0_hwdata;
  assign mst0_slv11_haddr  = mst0_haddr;
  assign mst0_slv11_hburst = mst0_hburst;
  assign mst0_slv11_hprot  = mst0_hprot;
  assign mst0_slv11_hsize  = mst0_hsize;
  assign mst0_slv11_htrans = mst0_htrans;
  assign mst0_slv11_hwrite = mst0_hwrite;
  assign mst0_slv11_req    = mst0_slv11_sel;
end
else begin : gen_m0s11_nonexistent
     assign mst0_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs11_hready  = 1'b0;
     assign mst0_hs11_hresp   = 2'h0;
     assign mst0_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv11_size   = 4'h0;
     assign mst0_slv11_grant  = 1'b0;
     assign hm0_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv11_hburst = 3'h0;
     assign mst0_slv11_hprot  = 4'h0;
     assign mst0_slv11_hsize  = 3'h0;
     assign mst0_slv11_htrans = 2'h0;
     assign mst0_slv11_hwrite = 1'b0;
     assign mst0_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S11) begin : gen_m1s11
  assign mst1_hs11_hrdata  = hs11_hrdata;
  assign mst1_hs11_hready  = hs11_hready;
  assign mst1_hs11_hresp   = hs11_hresp;
  assign mst1_slv11_base   = slv11_base;
  assign mst1_slv11_size   = slv11_size;
  assign mst1_slv11_grant  = mst1_slv11_ack;
  assign hm1_slv11_hwdata  = hm1_hwdata;
  assign mst1_slv11_haddr  = mst1_haddr;
  assign mst1_slv11_hburst = mst1_hburst;
  assign mst1_slv11_hprot  = mst1_hprot;
  assign mst1_slv11_hsize  = mst1_hsize;
  assign mst1_slv11_htrans = mst1_htrans;
  assign mst1_slv11_hwrite = mst1_hwrite;
  assign mst1_slv11_req    = mst1_slv11_sel;
end
else begin : gen_m1s11_nonexistent
     assign mst1_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs11_hready  = 1'b0;
     assign mst1_hs11_hresp   = 2'h0;
     assign mst1_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv11_size   = 4'h0;
     assign mst1_slv11_grant  = 1'b0;
     assign hm1_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv11_hburst = 3'h0;
     assign mst1_slv11_hprot  = 4'h0;
     assign mst1_slv11_hsize  = 3'h0;
     assign mst1_slv11_htrans = 2'h0;
     assign mst1_slv11_hwrite = 1'b0;
     assign mst1_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S11) begin : gen_m2s11
  assign mst2_hs11_hrdata  = hs11_hrdata;
  assign mst2_hs11_hready  = hs11_hready;
  assign mst2_hs11_hresp   = hs11_hresp;
  assign mst2_slv11_base   = slv11_base;
  assign mst2_slv11_size   = slv11_size;
  assign mst2_slv11_grant  = mst2_slv11_ack;
  assign hm2_slv11_hwdata  = hm2_hwdata;
  assign mst2_slv11_haddr  = mst2_haddr;
  assign mst2_slv11_hburst = mst2_hburst;
  assign mst2_slv11_hprot  = mst2_hprot;
  assign mst2_slv11_hsize  = mst2_hsize;
  assign mst2_slv11_htrans = mst2_htrans;
  assign mst2_slv11_hwrite = mst2_hwrite;
  assign mst2_slv11_req    = mst2_slv11_sel;
end
else begin : gen_m2s11_nonexistent
     assign mst2_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs11_hready  = 1'b0;
     assign mst2_hs11_hresp   = 2'h0;
     assign mst2_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv11_size   = 4'h0;
     assign mst2_slv11_grant  = 1'b0;
     assign hm2_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv11_hburst = 3'h0;
     assign mst2_slv11_hprot  = 4'h0;
     assign mst2_slv11_hsize  = 3'h0;
     assign mst2_slv11_htrans = 2'h0;
     assign mst2_slv11_hwrite = 1'b0;
     assign mst2_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S11) begin : gen_m3s11
  assign mst3_hs11_hrdata  = hs11_hrdata;
  assign mst3_hs11_hready  = hs11_hready;
  assign mst3_hs11_hresp   = hs11_hresp;
  assign mst3_slv11_base   = slv11_base;
  assign mst3_slv11_size   = slv11_size;
  assign mst3_slv11_grant  = mst3_slv11_ack;
  assign hm3_slv11_hwdata  = hm3_hwdata;
  assign mst3_slv11_haddr  = mst3_haddr;
  assign mst3_slv11_hburst = mst3_hburst;
  assign mst3_slv11_hprot  = mst3_hprot;
  assign mst3_slv11_hsize  = mst3_hsize;
  assign mst3_slv11_htrans = mst3_htrans;
  assign mst3_slv11_hwrite = mst3_hwrite;
  assign mst3_slv11_req    = mst3_slv11_sel;
end
else begin : gen_m3s11_nonexistent
     assign mst3_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs11_hready  = 1'b0;
     assign mst3_hs11_hresp   = 2'h0;
     assign mst3_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv11_size   = 4'h0;
     assign mst3_slv11_grant  = 1'b0;
     assign hm3_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv11_hburst = 3'h0;
     assign mst3_slv11_hprot  = 4'h0;
     assign mst3_slv11_hsize  = 3'h0;
     assign mst3_slv11_htrans = 2'h0;
     assign mst3_slv11_hwrite = 1'b0;
     assign mst3_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S11) begin : gen_m4s11
  assign mst4_hs11_hrdata  = hs11_hrdata;
  assign mst4_hs11_hready  = hs11_hready;
  assign mst4_hs11_hresp   = hs11_hresp;
  assign mst4_slv11_base   = slv11_base;
  assign mst4_slv11_size   = slv11_size;
  assign mst4_slv11_grant  = mst4_slv11_ack;
  assign hm4_slv11_hwdata  = hm4_hwdata;
  assign mst4_slv11_haddr  = mst4_haddr;
  assign mst4_slv11_hburst = mst4_hburst;
  assign mst4_slv11_hprot  = mst4_hprot;
  assign mst4_slv11_hsize  = mst4_hsize;
  assign mst4_slv11_htrans = mst4_htrans;
  assign mst4_slv11_hwrite = mst4_hwrite;
  assign mst4_slv11_req    = mst4_slv11_sel;
end
else begin : gen_m4s11_nonexistent
     assign mst4_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs11_hready  = 1'b0;
     assign mst4_hs11_hresp   = 2'h0;
     assign mst4_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv11_size   = 4'h0;
     assign mst4_slv11_grant  = 1'b0;
     assign hm4_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv11_hburst = 3'h0;
     assign mst4_slv11_hprot  = 4'h0;
     assign mst4_slv11_hsize  = 3'h0;
     assign mst4_slv11_htrans = 2'h0;
     assign mst4_slv11_hwrite = 1'b0;
     assign mst4_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S11) begin : gen_m5s11
  assign mst5_hs11_hrdata  = hs11_hrdata;
  assign mst5_hs11_hready  = hs11_hready;
  assign mst5_hs11_hresp   = hs11_hresp;
  assign mst5_slv11_base   = slv11_base;
  assign mst5_slv11_size   = slv11_size;
  assign mst5_slv11_grant  = mst5_slv11_ack;
  assign hm5_slv11_hwdata  = hm5_hwdata;
  assign mst5_slv11_haddr  = mst5_haddr;
  assign mst5_slv11_hburst = mst5_hburst;
  assign mst5_slv11_hprot  = mst5_hprot;
  assign mst5_slv11_hsize  = mst5_hsize;
  assign mst5_slv11_htrans = mst5_htrans;
  assign mst5_slv11_hwrite = mst5_hwrite;
  assign mst5_slv11_req    = mst5_slv11_sel;
end
else begin : gen_m5s11_nonexistent
     assign mst5_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs11_hready  = 1'b0;
     assign mst5_hs11_hresp   = 2'h0;
     assign mst5_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv11_size   = 4'h0;
     assign mst5_slv11_grant  = 1'b0;
     assign hm5_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv11_hburst = 3'h0;
     assign mst5_slv11_hprot  = 4'h0;
     assign mst5_slv11_hsize  = 3'h0;
     assign mst5_slv11_htrans = 2'h0;
     assign mst5_slv11_hwrite = 1'b0;
     assign mst5_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S11) begin : gen_m6s11
  assign mst6_hs11_hrdata  = hs11_hrdata;
  assign mst6_hs11_hready  = hs11_hready;
  assign mst6_hs11_hresp   = hs11_hresp;
  assign mst6_slv11_base   = slv11_base;
  assign mst6_slv11_size   = slv11_size;
  assign mst6_slv11_grant  = mst6_slv11_ack;
  assign hm6_slv11_hwdata  = hm6_hwdata;
  assign mst6_slv11_haddr  = mst6_haddr;
  assign mst6_slv11_hburst = mst6_hburst;
  assign mst6_slv11_hprot  = mst6_hprot;
  assign mst6_slv11_hsize  = mst6_hsize;
  assign mst6_slv11_htrans = mst6_htrans;
  assign mst6_slv11_hwrite = mst6_hwrite;
  assign mst6_slv11_req    = mst6_slv11_sel;
end
else begin : gen_m6s11_nonexistent
     assign mst6_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs11_hready  = 1'b0;
     assign mst6_hs11_hresp   = 2'h0;
     assign mst6_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv11_size   = 4'h0;
     assign mst6_slv11_grant  = 1'b0;
     assign hm6_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv11_hburst = 3'h0;
     assign mst6_slv11_hprot  = 4'h0;
     assign mst6_slv11_hsize  = 3'h0;
     assign mst6_slv11_htrans = 2'h0;
     assign mst6_slv11_hwrite = 1'b0;
     assign mst6_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S11) begin : gen_m7s11
  assign mst7_hs11_hrdata  = hs11_hrdata;
  assign mst7_hs11_hready  = hs11_hready;
  assign mst7_hs11_hresp   = hs11_hresp;
  assign mst7_slv11_base   = slv11_base;
  assign mst7_slv11_size   = slv11_size;
  assign mst7_slv11_grant  = mst7_slv11_ack;
  assign hm7_slv11_hwdata  = hm7_hwdata;
  assign mst7_slv11_haddr  = mst7_haddr;
  assign mst7_slv11_hburst = mst7_hburst;
  assign mst7_slv11_hprot  = mst7_hprot;
  assign mst7_slv11_hsize  = mst7_hsize;
  assign mst7_slv11_htrans = mst7_htrans;
  assign mst7_slv11_hwrite = mst7_hwrite;
  assign mst7_slv11_req    = mst7_slv11_sel;
end
else begin : gen_m7s11_nonexistent
     assign mst7_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs11_hready  = 1'b0;
     assign mst7_hs11_hresp   = 2'h0;
     assign mst7_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv11_size   = 4'h0;
     assign mst7_slv11_grant  = 1'b0;
     assign hm7_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv11_hburst = 3'h0;
     assign mst7_slv11_hprot  = 4'h0;
     assign mst7_slv11_hsize  = 3'h0;
     assign mst7_slv11_htrans = 2'h0;
     assign mst7_slv11_hwrite = 1'b0;
     assign mst7_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S11) begin : gen_m8s11
  assign mst8_hs11_hrdata  = hs11_hrdata;
  assign mst8_hs11_hready  = hs11_hready;
  assign mst8_hs11_hresp   = hs11_hresp;
  assign mst8_slv11_base   = slv11_base;
  assign mst8_slv11_size   = slv11_size;
  assign mst8_slv11_grant  = mst8_slv11_ack;
  assign hm8_slv11_hwdata  = hm8_hwdata;
  assign mst8_slv11_haddr  = mst8_haddr;
  assign mst8_slv11_hburst = mst8_hburst;
  assign mst8_slv11_hprot  = mst8_hprot;
  assign mst8_slv11_hsize  = mst8_hsize;
  assign mst8_slv11_htrans = mst8_htrans;
  assign mst8_slv11_hwrite = mst8_hwrite;
  assign mst8_slv11_req    = mst8_slv11_sel;
end
else begin : gen_m8s11_nonexistent
     assign mst8_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs11_hready  = 1'b0;
     assign mst8_hs11_hresp   = 2'h0;
     assign mst8_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv11_size   = 4'h0;
     assign mst8_slv11_grant  = 1'b0;
     assign hm8_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv11_hburst = 3'h0;
     assign mst8_slv11_hprot  = 4'h0;
     assign mst8_slv11_hsize  = 3'h0;
     assign mst8_slv11_htrans = 2'h0;
     assign mst8_slv11_hwrite = 1'b0;
     assign mst8_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S11) begin : gen_m9s11
  assign mst9_hs11_hrdata  = hs11_hrdata;
  assign mst9_hs11_hready  = hs11_hready;
  assign mst9_hs11_hresp   = hs11_hresp;
  assign mst9_slv11_base   = slv11_base;
  assign mst9_slv11_size   = slv11_size;
  assign mst9_slv11_grant  = mst9_slv11_ack;
  assign hm9_slv11_hwdata  = hm9_hwdata;
  assign mst9_slv11_haddr  = mst9_haddr;
  assign mst9_slv11_hburst = mst9_hburst;
  assign mst9_slv11_hprot  = mst9_hprot;
  assign mst9_slv11_hsize  = mst9_hsize;
  assign mst9_slv11_htrans = mst9_htrans;
  assign mst9_slv11_hwrite = mst9_hwrite;
  assign mst9_slv11_req    = mst9_slv11_sel;
end
else begin : gen_m9s11_nonexistent
     assign mst9_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs11_hready  = 1'b0;
     assign mst9_hs11_hresp   = 2'h0;
     assign mst9_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv11_size   = 4'h0;
     assign mst9_slv11_grant  = 1'b0;
     assign hm9_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv11_hburst = 3'h0;
     assign mst9_slv11_hprot  = 4'h0;
     assign mst9_slv11_hsize  = 3'h0;
     assign mst9_slv11_htrans = 2'h0;
     assign mst9_slv11_hwrite = 1'b0;
     assign mst9_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S11) begin : gen_m10s11
  assign mst10_hs11_hrdata  = hs11_hrdata;
  assign mst10_hs11_hready  = hs11_hready;
  assign mst10_hs11_hresp   = hs11_hresp;
  assign mst10_slv11_base   = slv11_base;
  assign mst10_slv11_size   = slv11_size;
  assign mst10_slv11_grant  = mst10_slv11_ack;
  assign hm10_slv11_hwdata  = hm10_hwdata;
  assign mst10_slv11_haddr  = mst10_haddr;
  assign mst10_slv11_hburst = mst10_hburst;
  assign mst10_slv11_hprot  = mst10_hprot;
  assign mst10_slv11_hsize  = mst10_hsize;
  assign mst10_slv11_htrans = mst10_htrans;
  assign mst10_slv11_hwrite = mst10_hwrite;
  assign mst10_slv11_req    = mst10_slv11_sel;
end
else begin : gen_m10s11_nonexistent
     assign mst10_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs11_hready  = 1'b0;
     assign mst10_hs11_hresp   = 2'h0;
     assign mst10_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv11_size   = 4'h0;
     assign mst10_slv11_grant  = 1'b0;
     assign hm10_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv11_hburst = 3'h0;
     assign mst10_slv11_hprot  = 4'h0;
     assign mst10_slv11_hsize  = 3'h0;
     assign mst10_slv11_htrans = 2'h0;
     assign mst10_slv11_hwrite = 1'b0;
     assign mst10_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S11) begin : gen_m11s11
  assign mst11_hs11_hrdata  = hs11_hrdata;
  assign mst11_hs11_hready  = hs11_hready;
  assign mst11_hs11_hresp   = hs11_hresp;
  assign mst11_slv11_base   = slv11_base;
  assign mst11_slv11_size   = slv11_size;
  assign mst11_slv11_grant  = mst11_slv11_ack;
  assign hm11_slv11_hwdata  = hm11_hwdata;
  assign mst11_slv11_haddr  = mst11_haddr;
  assign mst11_slv11_hburst = mst11_hburst;
  assign mst11_slv11_hprot  = mst11_hprot;
  assign mst11_slv11_hsize  = mst11_hsize;
  assign mst11_slv11_htrans = mst11_htrans;
  assign mst11_slv11_hwrite = mst11_hwrite;
  assign mst11_slv11_req    = mst11_slv11_sel;
end
else begin : gen_m11s11_nonexistent
     assign mst11_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs11_hready  = 1'b0;
     assign mst11_hs11_hresp   = 2'h0;
     assign mst11_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv11_size   = 4'h0;
     assign mst11_slv11_grant  = 1'b0;
     assign hm11_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv11_hburst = 3'h0;
     assign mst11_slv11_hprot  = 4'h0;
     assign mst11_slv11_hsize  = 3'h0;
     assign mst11_slv11_htrans = 2'h0;
     assign mst11_slv11_hwrite = 1'b0;
     assign mst11_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S11) begin : gen_m12s11
  assign mst12_hs11_hrdata  = hs11_hrdata;
  assign mst12_hs11_hready  = hs11_hready;
  assign mst12_hs11_hresp   = hs11_hresp;
  assign mst12_slv11_base   = slv11_base;
  assign mst12_slv11_size   = slv11_size;
  assign mst12_slv11_grant  = mst12_slv11_ack;
  assign hm12_slv11_hwdata  = hm12_hwdata;
  assign mst12_slv11_haddr  = mst12_haddr;
  assign mst12_slv11_hburst = mst12_hburst;
  assign mst12_slv11_hprot  = mst12_hprot;
  assign mst12_slv11_hsize  = mst12_hsize;
  assign mst12_slv11_htrans = mst12_htrans;
  assign mst12_slv11_hwrite = mst12_hwrite;
  assign mst12_slv11_req    = mst12_slv11_sel;
end
else begin : gen_m12s11_nonexistent
     assign mst12_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs11_hready  = 1'b0;
     assign mst12_hs11_hresp   = 2'h0;
     assign mst12_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv11_size   = 4'h0;
     assign mst12_slv11_grant  = 1'b0;
     assign hm12_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv11_hburst = 3'h0;
     assign mst12_slv11_hprot  = 4'h0;
     assign mst12_slv11_hsize  = 3'h0;
     assign mst12_slv11_htrans = 2'h0;
     assign mst12_slv11_hwrite = 1'b0;
     assign mst12_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S11) begin : gen_m13s11
  assign mst13_hs11_hrdata  = hs11_hrdata;
  assign mst13_hs11_hready  = hs11_hready;
  assign mst13_hs11_hresp   = hs11_hresp;
  assign mst13_slv11_base   = slv11_base;
  assign mst13_slv11_size   = slv11_size;
  assign mst13_slv11_grant  = mst13_slv11_ack;
  assign hm13_slv11_hwdata  = hm13_hwdata;
  assign mst13_slv11_haddr  = mst13_haddr;
  assign mst13_slv11_hburst = mst13_hburst;
  assign mst13_slv11_hprot  = mst13_hprot;
  assign mst13_slv11_hsize  = mst13_hsize;
  assign mst13_slv11_htrans = mst13_htrans;
  assign mst13_slv11_hwrite = mst13_hwrite;
  assign mst13_slv11_req    = mst13_slv11_sel;
end
else begin : gen_m13s11_nonexistent
     assign mst13_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs11_hready  = 1'b0;
     assign mst13_hs11_hresp   = 2'h0;
     assign mst13_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv11_size   = 4'h0;
     assign mst13_slv11_grant  = 1'b0;
     assign hm13_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv11_hburst = 3'h0;
     assign mst13_slv11_hprot  = 4'h0;
     assign mst13_slv11_hsize  = 3'h0;
     assign mst13_slv11_htrans = 2'h0;
     assign mst13_slv11_hwrite = 1'b0;
     assign mst13_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S11) begin : gen_m14s11
  assign mst14_hs11_hrdata  = hs11_hrdata;
  assign mst14_hs11_hready  = hs11_hready;
  assign mst14_hs11_hresp   = hs11_hresp;
  assign mst14_slv11_base   = slv11_base;
  assign mst14_slv11_size   = slv11_size;
  assign mst14_slv11_grant  = mst14_slv11_ack;
  assign hm14_slv11_hwdata  = hm14_hwdata;
  assign mst14_slv11_haddr  = mst14_haddr;
  assign mst14_slv11_hburst = mst14_hburst;
  assign mst14_slv11_hprot  = mst14_hprot;
  assign mst14_slv11_hsize  = mst14_hsize;
  assign mst14_slv11_htrans = mst14_htrans;
  assign mst14_slv11_hwrite = mst14_hwrite;
  assign mst14_slv11_req    = mst14_slv11_sel;
end
else begin : gen_m14s11_nonexistent
     assign mst14_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs11_hready  = 1'b0;
     assign mst14_hs11_hresp   = 2'h0;
     assign mst14_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv11_size   = 4'h0;
     assign mst14_slv11_grant  = 1'b0;
     assign hm14_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv11_hburst = 3'h0;
     assign mst14_slv11_hprot  = 4'h0;
     assign mst14_slv11_hsize  = 3'h0;
     assign mst14_slv11_htrans = 2'h0;
     assign mst14_slv11_hwrite = 1'b0;
     assign mst14_slv11_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S11) begin : gen_m15s11
  assign mst15_hs11_hrdata  = hs11_hrdata;
  assign mst15_hs11_hready  = hs11_hready;
  assign mst15_hs11_hresp   = hs11_hresp;
  assign mst15_slv11_base   = slv11_base;
  assign mst15_slv11_size   = slv11_size;
  assign mst15_slv11_grant  = mst15_slv11_ack;
  assign hm15_slv11_hwdata  = hm15_hwdata;
  assign mst15_slv11_haddr  = mst15_haddr;
  assign mst15_slv11_hburst = mst15_hburst;
  assign mst15_slv11_hprot  = mst15_hprot;
  assign mst15_slv11_hsize  = mst15_hsize;
  assign mst15_slv11_htrans = mst15_htrans;
  assign mst15_slv11_hwrite = mst15_hwrite;
  assign mst15_slv11_req    = mst15_slv11_sel;
end
else begin : gen_m15s11_nonexistent
     assign mst15_hs11_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs11_hready  = 1'b0;
     assign mst15_hs11_hresp   = 2'h0;
     assign mst15_slv11_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv11_size   = 4'h0;
     assign mst15_slv11_grant  = 1'b0;
     assign hm15_slv11_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv11_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv11_hburst = 3'h0;
     assign mst15_slv11_hprot  = 4'h0;
     assign mst15_slv11_hsize  = 3'h0;
     assign mst15_slv11_htrans = 2'h0;
     assign mst15_slv11_hwrite = 1'b0;
     assign mst15_slv11_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV12
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S12) begin : gen_m0s12
  assign mst0_hs12_hrdata  = hs12_hrdata;
  assign mst0_hs12_hready  = hs12_hready;
  assign mst0_hs12_hresp   = hs12_hresp;
  assign mst0_slv12_base   = slv12_base;
  assign mst0_slv12_size   = slv12_size;
  assign mst0_slv12_grant  = mst0_slv12_ack;
  assign hm0_slv12_hwdata  = hm0_hwdata;
  assign mst0_slv12_haddr  = mst0_haddr;
  assign mst0_slv12_hburst = mst0_hburst;
  assign mst0_slv12_hprot  = mst0_hprot;
  assign mst0_slv12_hsize  = mst0_hsize;
  assign mst0_slv12_htrans = mst0_htrans;
  assign mst0_slv12_hwrite = mst0_hwrite;
  assign mst0_slv12_req    = mst0_slv12_sel;
end
else begin : gen_m0s12_nonexistent
     assign mst0_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs12_hready  = 1'b0;
     assign mst0_hs12_hresp   = 2'h0;
     assign mst0_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv12_size   = 4'h0;
     assign mst0_slv12_grant  = 1'b0;
     assign hm0_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv12_hburst = 3'h0;
     assign mst0_slv12_hprot  = 4'h0;
     assign mst0_slv12_hsize  = 3'h0;
     assign mst0_slv12_htrans = 2'h0;
     assign mst0_slv12_hwrite = 1'b0;
     assign mst0_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S12) begin : gen_m1s12
  assign mst1_hs12_hrdata  = hs12_hrdata;
  assign mst1_hs12_hready  = hs12_hready;
  assign mst1_hs12_hresp   = hs12_hresp;
  assign mst1_slv12_base   = slv12_base;
  assign mst1_slv12_size   = slv12_size;
  assign mst1_slv12_grant  = mst1_slv12_ack;
  assign hm1_slv12_hwdata  = hm1_hwdata;
  assign mst1_slv12_haddr  = mst1_haddr;
  assign mst1_slv12_hburst = mst1_hburst;
  assign mst1_slv12_hprot  = mst1_hprot;
  assign mst1_slv12_hsize  = mst1_hsize;
  assign mst1_slv12_htrans = mst1_htrans;
  assign mst1_slv12_hwrite = mst1_hwrite;
  assign mst1_slv12_req    = mst1_slv12_sel;
end
else begin : gen_m1s12_nonexistent
     assign mst1_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs12_hready  = 1'b0;
     assign mst1_hs12_hresp   = 2'h0;
     assign mst1_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv12_size   = 4'h0;
     assign mst1_slv12_grant  = 1'b0;
     assign hm1_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv12_hburst = 3'h0;
     assign mst1_slv12_hprot  = 4'h0;
     assign mst1_slv12_hsize  = 3'h0;
     assign mst1_slv12_htrans = 2'h0;
     assign mst1_slv12_hwrite = 1'b0;
     assign mst1_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S12) begin : gen_m2s12
  assign mst2_hs12_hrdata  = hs12_hrdata;
  assign mst2_hs12_hready  = hs12_hready;
  assign mst2_hs12_hresp   = hs12_hresp;
  assign mst2_slv12_base   = slv12_base;
  assign mst2_slv12_size   = slv12_size;
  assign mst2_slv12_grant  = mst2_slv12_ack;
  assign hm2_slv12_hwdata  = hm2_hwdata;
  assign mst2_slv12_haddr  = mst2_haddr;
  assign mst2_slv12_hburst = mst2_hburst;
  assign mst2_slv12_hprot  = mst2_hprot;
  assign mst2_slv12_hsize  = mst2_hsize;
  assign mst2_slv12_htrans = mst2_htrans;
  assign mst2_slv12_hwrite = mst2_hwrite;
  assign mst2_slv12_req    = mst2_slv12_sel;
end
else begin : gen_m2s12_nonexistent
     assign mst2_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs12_hready  = 1'b0;
     assign mst2_hs12_hresp   = 2'h0;
     assign mst2_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv12_size   = 4'h0;
     assign mst2_slv12_grant  = 1'b0;
     assign hm2_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv12_hburst = 3'h0;
     assign mst2_slv12_hprot  = 4'h0;
     assign mst2_slv12_hsize  = 3'h0;
     assign mst2_slv12_htrans = 2'h0;
     assign mst2_slv12_hwrite = 1'b0;
     assign mst2_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S12) begin : gen_m3s12
  assign mst3_hs12_hrdata  = hs12_hrdata;
  assign mst3_hs12_hready  = hs12_hready;
  assign mst3_hs12_hresp   = hs12_hresp;
  assign mst3_slv12_base   = slv12_base;
  assign mst3_slv12_size   = slv12_size;
  assign mst3_slv12_grant  = mst3_slv12_ack;
  assign hm3_slv12_hwdata  = hm3_hwdata;
  assign mst3_slv12_haddr  = mst3_haddr;
  assign mst3_slv12_hburst = mst3_hburst;
  assign mst3_slv12_hprot  = mst3_hprot;
  assign mst3_slv12_hsize  = mst3_hsize;
  assign mst3_slv12_htrans = mst3_htrans;
  assign mst3_slv12_hwrite = mst3_hwrite;
  assign mst3_slv12_req    = mst3_slv12_sel;
end
else begin : gen_m3s12_nonexistent
     assign mst3_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs12_hready  = 1'b0;
     assign mst3_hs12_hresp   = 2'h0;
     assign mst3_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv12_size   = 4'h0;
     assign mst3_slv12_grant  = 1'b0;
     assign hm3_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv12_hburst = 3'h0;
     assign mst3_slv12_hprot  = 4'h0;
     assign mst3_slv12_hsize  = 3'h0;
     assign mst3_slv12_htrans = 2'h0;
     assign mst3_slv12_hwrite = 1'b0;
     assign mst3_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S12) begin : gen_m4s12
  assign mst4_hs12_hrdata  = hs12_hrdata;
  assign mst4_hs12_hready  = hs12_hready;
  assign mst4_hs12_hresp   = hs12_hresp;
  assign mst4_slv12_base   = slv12_base;
  assign mst4_slv12_size   = slv12_size;
  assign mst4_slv12_grant  = mst4_slv12_ack;
  assign hm4_slv12_hwdata  = hm4_hwdata;
  assign mst4_slv12_haddr  = mst4_haddr;
  assign mst4_slv12_hburst = mst4_hburst;
  assign mst4_slv12_hprot  = mst4_hprot;
  assign mst4_slv12_hsize  = mst4_hsize;
  assign mst4_slv12_htrans = mst4_htrans;
  assign mst4_slv12_hwrite = mst4_hwrite;
  assign mst4_slv12_req    = mst4_slv12_sel;
end
else begin : gen_m4s12_nonexistent
     assign mst4_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs12_hready  = 1'b0;
     assign mst4_hs12_hresp   = 2'h0;
     assign mst4_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv12_size   = 4'h0;
     assign mst4_slv12_grant  = 1'b0;
     assign hm4_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv12_hburst = 3'h0;
     assign mst4_slv12_hprot  = 4'h0;
     assign mst4_slv12_hsize  = 3'h0;
     assign mst4_slv12_htrans = 2'h0;
     assign mst4_slv12_hwrite = 1'b0;
     assign mst4_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S12) begin : gen_m5s12
  assign mst5_hs12_hrdata  = hs12_hrdata;
  assign mst5_hs12_hready  = hs12_hready;
  assign mst5_hs12_hresp   = hs12_hresp;
  assign mst5_slv12_base   = slv12_base;
  assign mst5_slv12_size   = slv12_size;
  assign mst5_slv12_grant  = mst5_slv12_ack;
  assign hm5_slv12_hwdata  = hm5_hwdata;
  assign mst5_slv12_haddr  = mst5_haddr;
  assign mst5_slv12_hburst = mst5_hburst;
  assign mst5_slv12_hprot  = mst5_hprot;
  assign mst5_slv12_hsize  = mst5_hsize;
  assign mst5_slv12_htrans = mst5_htrans;
  assign mst5_slv12_hwrite = mst5_hwrite;
  assign mst5_slv12_req    = mst5_slv12_sel;
end
else begin : gen_m5s12_nonexistent
     assign mst5_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs12_hready  = 1'b0;
     assign mst5_hs12_hresp   = 2'h0;
     assign mst5_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv12_size   = 4'h0;
     assign mst5_slv12_grant  = 1'b0;
     assign hm5_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv12_hburst = 3'h0;
     assign mst5_slv12_hprot  = 4'h0;
     assign mst5_slv12_hsize  = 3'h0;
     assign mst5_slv12_htrans = 2'h0;
     assign mst5_slv12_hwrite = 1'b0;
     assign mst5_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S12) begin : gen_m6s12
  assign mst6_hs12_hrdata  = hs12_hrdata;
  assign mst6_hs12_hready  = hs12_hready;
  assign mst6_hs12_hresp   = hs12_hresp;
  assign mst6_slv12_base   = slv12_base;
  assign mst6_slv12_size   = slv12_size;
  assign mst6_slv12_grant  = mst6_slv12_ack;
  assign hm6_slv12_hwdata  = hm6_hwdata;
  assign mst6_slv12_haddr  = mst6_haddr;
  assign mst6_slv12_hburst = mst6_hburst;
  assign mst6_slv12_hprot  = mst6_hprot;
  assign mst6_slv12_hsize  = mst6_hsize;
  assign mst6_slv12_htrans = mst6_htrans;
  assign mst6_slv12_hwrite = mst6_hwrite;
  assign mst6_slv12_req    = mst6_slv12_sel;
end
else begin : gen_m6s12_nonexistent
     assign mst6_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs12_hready  = 1'b0;
     assign mst6_hs12_hresp   = 2'h0;
     assign mst6_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv12_size   = 4'h0;
     assign mst6_slv12_grant  = 1'b0;
     assign hm6_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv12_hburst = 3'h0;
     assign mst6_slv12_hprot  = 4'h0;
     assign mst6_slv12_hsize  = 3'h0;
     assign mst6_slv12_htrans = 2'h0;
     assign mst6_slv12_hwrite = 1'b0;
     assign mst6_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S12) begin : gen_m7s12
  assign mst7_hs12_hrdata  = hs12_hrdata;
  assign mst7_hs12_hready  = hs12_hready;
  assign mst7_hs12_hresp   = hs12_hresp;
  assign mst7_slv12_base   = slv12_base;
  assign mst7_slv12_size   = slv12_size;
  assign mst7_slv12_grant  = mst7_slv12_ack;
  assign hm7_slv12_hwdata  = hm7_hwdata;
  assign mst7_slv12_haddr  = mst7_haddr;
  assign mst7_slv12_hburst = mst7_hburst;
  assign mst7_slv12_hprot  = mst7_hprot;
  assign mst7_slv12_hsize  = mst7_hsize;
  assign mst7_slv12_htrans = mst7_htrans;
  assign mst7_slv12_hwrite = mst7_hwrite;
  assign mst7_slv12_req    = mst7_slv12_sel;
end
else begin : gen_m7s12_nonexistent
     assign mst7_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs12_hready  = 1'b0;
     assign mst7_hs12_hresp   = 2'h0;
     assign mst7_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv12_size   = 4'h0;
     assign mst7_slv12_grant  = 1'b0;
     assign hm7_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv12_hburst = 3'h0;
     assign mst7_slv12_hprot  = 4'h0;
     assign mst7_slv12_hsize  = 3'h0;
     assign mst7_slv12_htrans = 2'h0;
     assign mst7_slv12_hwrite = 1'b0;
     assign mst7_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S12) begin : gen_m8s12
  assign mst8_hs12_hrdata  = hs12_hrdata;
  assign mst8_hs12_hready  = hs12_hready;
  assign mst8_hs12_hresp   = hs12_hresp;
  assign mst8_slv12_base   = slv12_base;
  assign mst8_slv12_size   = slv12_size;
  assign mst8_slv12_grant  = mst8_slv12_ack;
  assign hm8_slv12_hwdata  = hm8_hwdata;
  assign mst8_slv12_haddr  = mst8_haddr;
  assign mst8_slv12_hburst = mst8_hburst;
  assign mst8_slv12_hprot  = mst8_hprot;
  assign mst8_slv12_hsize  = mst8_hsize;
  assign mst8_slv12_htrans = mst8_htrans;
  assign mst8_slv12_hwrite = mst8_hwrite;
  assign mst8_slv12_req    = mst8_slv12_sel;
end
else begin : gen_m8s12_nonexistent
     assign mst8_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs12_hready  = 1'b0;
     assign mst8_hs12_hresp   = 2'h0;
     assign mst8_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv12_size   = 4'h0;
     assign mst8_slv12_grant  = 1'b0;
     assign hm8_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv12_hburst = 3'h0;
     assign mst8_slv12_hprot  = 4'h0;
     assign mst8_slv12_hsize  = 3'h0;
     assign mst8_slv12_htrans = 2'h0;
     assign mst8_slv12_hwrite = 1'b0;
     assign mst8_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S12) begin : gen_m9s12
  assign mst9_hs12_hrdata  = hs12_hrdata;
  assign mst9_hs12_hready  = hs12_hready;
  assign mst9_hs12_hresp   = hs12_hresp;
  assign mst9_slv12_base   = slv12_base;
  assign mst9_slv12_size   = slv12_size;
  assign mst9_slv12_grant  = mst9_slv12_ack;
  assign hm9_slv12_hwdata  = hm9_hwdata;
  assign mst9_slv12_haddr  = mst9_haddr;
  assign mst9_slv12_hburst = mst9_hburst;
  assign mst9_slv12_hprot  = mst9_hprot;
  assign mst9_slv12_hsize  = mst9_hsize;
  assign mst9_slv12_htrans = mst9_htrans;
  assign mst9_slv12_hwrite = mst9_hwrite;
  assign mst9_slv12_req    = mst9_slv12_sel;
end
else begin : gen_m9s12_nonexistent
     assign mst9_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs12_hready  = 1'b0;
     assign mst9_hs12_hresp   = 2'h0;
     assign mst9_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv12_size   = 4'h0;
     assign mst9_slv12_grant  = 1'b0;
     assign hm9_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv12_hburst = 3'h0;
     assign mst9_slv12_hprot  = 4'h0;
     assign mst9_slv12_hsize  = 3'h0;
     assign mst9_slv12_htrans = 2'h0;
     assign mst9_slv12_hwrite = 1'b0;
     assign mst9_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S12) begin : gen_m10s12
  assign mst10_hs12_hrdata  = hs12_hrdata;
  assign mst10_hs12_hready  = hs12_hready;
  assign mst10_hs12_hresp   = hs12_hresp;
  assign mst10_slv12_base   = slv12_base;
  assign mst10_slv12_size   = slv12_size;
  assign mst10_slv12_grant  = mst10_slv12_ack;
  assign hm10_slv12_hwdata  = hm10_hwdata;
  assign mst10_slv12_haddr  = mst10_haddr;
  assign mst10_slv12_hburst = mst10_hburst;
  assign mst10_slv12_hprot  = mst10_hprot;
  assign mst10_slv12_hsize  = mst10_hsize;
  assign mst10_slv12_htrans = mst10_htrans;
  assign mst10_slv12_hwrite = mst10_hwrite;
  assign mst10_slv12_req    = mst10_slv12_sel;
end
else begin : gen_m10s12_nonexistent
     assign mst10_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs12_hready  = 1'b0;
     assign mst10_hs12_hresp   = 2'h0;
     assign mst10_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv12_size   = 4'h0;
     assign mst10_slv12_grant  = 1'b0;
     assign hm10_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv12_hburst = 3'h0;
     assign mst10_slv12_hprot  = 4'h0;
     assign mst10_slv12_hsize  = 3'h0;
     assign mst10_slv12_htrans = 2'h0;
     assign mst10_slv12_hwrite = 1'b0;
     assign mst10_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S12) begin : gen_m11s12
  assign mst11_hs12_hrdata  = hs12_hrdata;
  assign mst11_hs12_hready  = hs12_hready;
  assign mst11_hs12_hresp   = hs12_hresp;
  assign mst11_slv12_base   = slv12_base;
  assign mst11_slv12_size   = slv12_size;
  assign mst11_slv12_grant  = mst11_slv12_ack;
  assign hm11_slv12_hwdata  = hm11_hwdata;
  assign mst11_slv12_haddr  = mst11_haddr;
  assign mst11_slv12_hburst = mst11_hburst;
  assign mst11_slv12_hprot  = mst11_hprot;
  assign mst11_slv12_hsize  = mst11_hsize;
  assign mst11_slv12_htrans = mst11_htrans;
  assign mst11_slv12_hwrite = mst11_hwrite;
  assign mst11_slv12_req    = mst11_slv12_sel;
end
else begin : gen_m11s12_nonexistent
     assign mst11_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs12_hready  = 1'b0;
     assign mst11_hs12_hresp   = 2'h0;
     assign mst11_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv12_size   = 4'h0;
     assign mst11_slv12_grant  = 1'b0;
     assign hm11_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv12_hburst = 3'h0;
     assign mst11_slv12_hprot  = 4'h0;
     assign mst11_slv12_hsize  = 3'h0;
     assign mst11_slv12_htrans = 2'h0;
     assign mst11_slv12_hwrite = 1'b0;
     assign mst11_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S12) begin : gen_m12s12
  assign mst12_hs12_hrdata  = hs12_hrdata;
  assign mst12_hs12_hready  = hs12_hready;
  assign mst12_hs12_hresp   = hs12_hresp;
  assign mst12_slv12_base   = slv12_base;
  assign mst12_slv12_size   = slv12_size;
  assign mst12_slv12_grant  = mst12_slv12_ack;
  assign hm12_slv12_hwdata  = hm12_hwdata;
  assign mst12_slv12_haddr  = mst12_haddr;
  assign mst12_slv12_hburst = mst12_hburst;
  assign mst12_slv12_hprot  = mst12_hprot;
  assign mst12_slv12_hsize  = mst12_hsize;
  assign mst12_slv12_htrans = mst12_htrans;
  assign mst12_slv12_hwrite = mst12_hwrite;
  assign mst12_slv12_req    = mst12_slv12_sel;
end
else begin : gen_m12s12_nonexistent
     assign mst12_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs12_hready  = 1'b0;
     assign mst12_hs12_hresp   = 2'h0;
     assign mst12_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv12_size   = 4'h0;
     assign mst12_slv12_grant  = 1'b0;
     assign hm12_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv12_hburst = 3'h0;
     assign mst12_slv12_hprot  = 4'h0;
     assign mst12_slv12_hsize  = 3'h0;
     assign mst12_slv12_htrans = 2'h0;
     assign mst12_slv12_hwrite = 1'b0;
     assign mst12_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S12) begin : gen_m13s12
  assign mst13_hs12_hrdata  = hs12_hrdata;
  assign mst13_hs12_hready  = hs12_hready;
  assign mst13_hs12_hresp   = hs12_hresp;
  assign mst13_slv12_base   = slv12_base;
  assign mst13_slv12_size   = slv12_size;
  assign mst13_slv12_grant  = mst13_slv12_ack;
  assign hm13_slv12_hwdata  = hm13_hwdata;
  assign mst13_slv12_haddr  = mst13_haddr;
  assign mst13_slv12_hburst = mst13_hburst;
  assign mst13_slv12_hprot  = mst13_hprot;
  assign mst13_slv12_hsize  = mst13_hsize;
  assign mst13_slv12_htrans = mst13_htrans;
  assign mst13_slv12_hwrite = mst13_hwrite;
  assign mst13_slv12_req    = mst13_slv12_sel;
end
else begin : gen_m13s12_nonexistent
     assign mst13_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs12_hready  = 1'b0;
     assign mst13_hs12_hresp   = 2'h0;
     assign mst13_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv12_size   = 4'h0;
     assign mst13_slv12_grant  = 1'b0;
     assign hm13_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv12_hburst = 3'h0;
     assign mst13_slv12_hprot  = 4'h0;
     assign mst13_slv12_hsize  = 3'h0;
     assign mst13_slv12_htrans = 2'h0;
     assign mst13_slv12_hwrite = 1'b0;
     assign mst13_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S12) begin : gen_m14s12
  assign mst14_hs12_hrdata  = hs12_hrdata;
  assign mst14_hs12_hready  = hs12_hready;
  assign mst14_hs12_hresp   = hs12_hresp;
  assign mst14_slv12_base   = slv12_base;
  assign mst14_slv12_size   = slv12_size;
  assign mst14_slv12_grant  = mst14_slv12_ack;
  assign hm14_slv12_hwdata  = hm14_hwdata;
  assign mst14_slv12_haddr  = mst14_haddr;
  assign mst14_slv12_hburst = mst14_hburst;
  assign mst14_slv12_hprot  = mst14_hprot;
  assign mst14_slv12_hsize  = mst14_hsize;
  assign mst14_slv12_htrans = mst14_htrans;
  assign mst14_slv12_hwrite = mst14_hwrite;
  assign mst14_slv12_req    = mst14_slv12_sel;
end
else begin : gen_m14s12_nonexistent
     assign mst14_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs12_hready  = 1'b0;
     assign mst14_hs12_hresp   = 2'h0;
     assign mst14_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv12_size   = 4'h0;
     assign mst14_slv12_grant  = 1'b0;
     assign hm14_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv12_hburst = 3'h0;
     assign mst14_slv12_hprot  = 4'h0;
     assign mst14_slv12_hsize  = 3'h0;
     assign mst14_slv12_htrans = 2'h0;
     assign mst14_slv12_hwrite = 1'b0;
     assign mst14_slv12_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S12) begin : gen_m15s12
  assign mst15_hs12_hrdata  = hs12_hrdata;
  assign mst15_hs12_hready  = hs12_hready;
  assign mst15_hs12_hresp   = hs12_hresp;
  assign mst15_slv12_base   = slv12_base;
  assign mst15_slv12_size   = slv12_size;
  assign mst15_slv12_grant  = mst15_slv12_ack;
  assign hm15_slv12_hwdata  = hm15_hwdata;
  assign mst15_slv12_haddr  = mst15_haddr;
  assign mst15_slv12_hburst = mst15_hburst;
  assign mst15_slv12_hprot  = mst15_hprot;
  assign mst15_slv12_hsize  = mst15_hsize;
  assign mst15_slv12_htrans = mst15_htrans;
  assign mst15_slv12_hwrite = mst15_hwrite;
  assign mst15_slv12_req    = mst15_slv12_sel;
end
else begin : gen_m15s12_nonexistent
     assign mst15_hs12_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs12_hready  = 1'b0;
     assign mst15_hs12_hresp   = 2'h0;
     assign mst15_slv12_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv12_size   = 4'h0;
     assign mst15_slv12_grant  = 1'b0;
     assign hm15_slv12_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv12_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv12_hburst = 3'h0;
     assign mst15_slv12_hprot  = 4'h0;
     assign mst15_slv12_hsize  = 3'h0;
     assign mst15_slv12_htrans = 2'h0;
     assign mst15_slv12_hwrite = 1'b0;
     assign mst15_slv12_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV13
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S13) begin : gen_m0s13
  assign mst0_hs13_hrdata  = hs13_hrdata;
  assign mst0_hs13_hready  = hs13_hready;
  assign mst0_hs13_hresp   = hs13_hresp;
  assign mst0_slv13_base   = slv13_base;
  assign mst0_slv13_size   = slv13_size;
  assign mst0_slv13_grant  = mst0_slv13_ack;
  assign hm0_slv13_hwdata  = hm0_hwdata;
  assign mst0_slv13_haddr  = mst0_haddr;
  assign mst0_slv13_hburst = mst0_hburst;
  assign mst0_slv13_hprot  = mst0_hprot;
  assign mst0_slv13_hsize  = mst0_hsize;
  assign mst0_slv13_htrans = mst0_htrans;
  assign mst0_slv13_hwrite = mst0_hwrite;
  assign mst0_slv13_req    = mst0_slv13_sel;
end
else begin : gen_m0s13_nonexistent
     assign mst0_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs13_hready  = 1'b0;
     assign mst0_hs13_hresp   = 2'h0;
     assign mst0_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv13_size   = 4'h0;
     assign mst0_slv13_grant  = 1'b0;
     assign hm0_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv13_hburst = 3'h0;
     assign mst0_slv13_hprot  = 4'h0;
     assign mst0_slv13_hsize  = 3'h0;
     assign mst0_slv13_htrans = 2'h0;
     assign mst0_slv13_hwrite = 1'b0;
     assign mst0_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S13) begin : gen_m1s13
  assign mst1_hs13_hrdata  = hs13_hrdata;
  assign mst1_hs13_hready  = hs13_hready;
  assign mst1_hs13_hresp   = hs13_hresp;
  assign mst1_slv13_base   = slv13_base;
  assign mst1_slv13_size   = slv13_size;
  assign mst1_slv13_grant  = mst1_slv13_ack;
  assign hm1_slv13_hwdata  = hm1_hwdata;
  assign mst1_slv13_haddr  = mst1_haddr;
  assign mst1_slv13_hburst = mst1_hburst;
  assign mst1_slv13_hprot  = mst1_hprot;
  assign mst1_slv13_hsize  = mst1_hsize;
  assign mst1_slv13_htrans = mst1_htrans;
  assign mst1_slv13_hwrite = mst1_hwrite;
  assign mst1_slv13_req    = mst1_slv13_sel;
end
else begin : gen_m1s13_nonexistent
     assign mst1_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs13_hready  = 1'b0;
     assign mst1_hs13_hresp   = 2'h0;
     assign mst1_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv13_size   = 4'h0;
     assign mst1_slv13_grant  = 1'b0;
     assign hm1_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv13_hburst = 3'h0;
     assign mst1_slv13_hprot  = 4'h0;
     assign mst1_slv13_hsize  = 3'h0;
     assign mst1_slv13_htrans = 2'h0;
     assign mst1_slv13_hwrite = 1'b0;
     assign mst1_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S13) begin : gen_m2s13
  assign mst2_hs13_hrdata  = hs13_hrdata;
  assign mst2_hs13_hready  = hs13_hready;
  assign mst2_hs13_hresp   = hs13_hresp;
  assign mst2_slv13_base   = slv13_base;
  assign mst2_slv13_size   = slv13_size;
  assign mst2_slv13_grant  = mst2_slv13_ack;
  assign hm2_slv13_hwdata  = hm2_hwdata;
  assign mst2_slv13_haddr  = mst2_haddr;
  assign mst2_slv13_hburst = mst2_hburst;
  assign mst2_slv13_hprot  = mst2_hprot;
  assign mst2_slv13_hsize  = mst2_hsize;
  assign mst2_slv13_htrans = mst2_htrans;
  assign mst2_slv13_hwrite = mst2_hwrite;
  assign mst2_slv13_req    = mst2_slv13_sel;
end
else begin : gen_m2s13_nonexistent
     assign mst2_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs13_hready  = 1'b0;
     assign mst2_hs13_hresp   = 2'h0;
     assign mst2_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv13_size   = 4'h0;
     assign mst2_slv13_grant  = 1'b0;
     assign hm2_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv13_hburst = 3'h0;
     assign mst2_slv13_hprot  = 4'h0;
     assign mst2_slv13_hsize  = 3'h0;
     assign mst2_slv13_htrans = 2'h0;
     assign mst2_slv13_hwrite = 1'b0;
     assign mst2_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S13) begin : gen_m3s13
  assign mst3_hs13_hrdata  = hs13_hrdata;
  assign mst3_hs13_hready  = hs13_hready;
  assign mst3_hs13_hresp   = hs13_hresp;
  assign mst3_slv13_base   = slv13_base;
  assign mst3_slv13_size   = slv13_size;
  assign mst3_slv13_grant  = mst3_slv13_ack;
  assign hm3_slv13_hwdata  = hm3_hwdata;
  assign mst3_slv13_haddr  = mst3_haddr;
  assign mst3_slv13_hburst = mst3_hburst;
  assign mst3_slv13_hprot  = mst3_hprot;
  assign mst3_slv13_hsize  = mst3_hsize;
  assign mst3_slv13_htrans = mst3_htrans;
  assign mst3_slv13_hwrite = mst3_hwrite;
  assign mst3_slv13_req    = mst3_slv13_sel;
end
else begin : gen_m3s13_nonexistent
     assign mst3_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs13_hready  = 1'b0;
     assign mst3_hs13_hresp   = 2'h0;
     assign mst3_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv13_size   = 4'h0;
     assign mst3_slv13_grant  = 1'b0;
     assign hm3_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv13_hburst = 3'h0;
     assign mst3_slv13_hprot  = 4'h0;
     assign mst3_slv13_hsize  = 3'h0;
     assign mst3_slv13_htrans = 2'h0;
     assign mst3_slv13_hwrite = 1'b0;
     assign mst3_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S13) begin : gen_m4s13
  assign mst4_hs13_hrdata  = hs13_hrdata;
  assign mst4_hs13_hready  = hs13_hready;
  assign mst4_hs13_hresp   = hs13_hresp;
  assign mst4_slv13_base   = slv13_base;
  assign mst4_slv13_size   = slv13_size;
  assign mst4_slv13_grant  = mst4_slv13_ack;
  assign hm4_slv13_hwdata  = hm4_hwdata;
  assign mst4_slv13_haddr  = mst4_haddr;
  assign mst4_slv13_hburst = mst4_hburst;
  assign mst4_slv13_hprot  = mst4_hprot;
  assign mst4_slv13_hsize  = mst4_hsize;
  assign mst4_slv13_htrans = mst4_htrans;
  assign mst4_slv13_hwrite = mst4_hwrite;
  assign mst4_slv13_req    = mst4_slv13_sel;
end
else begin : gen_m4s13_nonexistent
     assign mst4_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs13_hready  = 1'b0;
     assign mst4_hs13_hresp   = 2'h0;
     assign mst4_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv13_size   = 4'h0;
     assign mst4_slv13_grant  = 1'b0;
     assign hm4_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv13_hburst = 3'h0;
     assign mst4_slv13_hprot  = 4'h0;
     assign mst4_slv13_hsize  = 3'h0;
     assign mst4_slv13_htrans = 2'h0;
     assign mst4_slv13_hwrite = 1'b0;
     assign mst4_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S13) begin : gen_m5s13
  assign mst5_hs13_hrdata  = hs13_hrdata;
  assign mst5_hs13_hready  = hs13_hready;
  assign mst5_hs13_hresp   = hs13_hresp;
  assign mst5_slv13_base   = slv13_base;
  assign mst5_slv13_size   = slv13_size;
  assign mst5_slv13_grant  = mst5_slv13_ack;
  assign hm5_slv13_hwdata  = hm5_hwdata;
  assign mst5_slv13_haddr  = mst5_haddr;
  assign mst5_slv13_hburst = mst5_hburst;
  assign mst5_slv13_hprot  = mst5_hprot;
  assign mst5_slv13_hsize  = mst5_hsize;
  assign mst5_slv13_htrans = mst5_htrans;
  assign mst5_slv13_hwrite = mst5_hwrite;
  assign mst5_slv13_req    = mst5_slv13_sel;
end
else begin : gen_m5s13_nonexistent
     assign mst5_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs13_hready  = 1'b0;
     assign mst5_hs13_hresp   = 2'h0;
     assign mst5_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv13_size   = 4'h0;
     assign mst5_slv13_grant  = 1'b0;
     assign hm5_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv13_hburst = 3'h0;
     assign mst5_slv13_hprot  = 4'h0;
     assign mst5_slv13_hsize  = 3'h0;
     assign mst5_slv13_htrans = 2'h0;
     assign mst5_slv13_hwrite = 1'b0;
     assign mst5_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S13) begin : gen_m6s13
  assign mst6_hs13_hrdata  = hs13_hrdata;
  assign mst6_hs13_hready  = hs13_hready;
  assign mst6_hs13_hresp   = hs13_hresp;
  assign mst6_slv13_base   = slv13_base;
  assign mst6_slv13_size   = slv13_size;
  assign mst6_slv13_grant  = mst6_slv13_ack;
  assign hm6_slv13_hwdata  = hm6_hwdata;
  assign mst6_slv13_haddr  = mst6_haddr;
  assign mst6_slv13_hburst = mst6_hburst;
  assign mst6_slv13_hprot  = mst6_hprot;
  assign mst6_slv13_hsize  = mst6_hsize;
  assign mst6_slv13_htrans = mst6_htrans;
  assign mst6_slv13_hwrite = mst6_hwrite;
  assign mst6_slv13_req    = mst6_slv13_sel;
end
else begin : gen_m6s13_nonexistent
     assign mst6_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs13_hready  = 1'b0;
     assign mst6_hs13_hresp   = 2'h0;
     assign mst6_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv13_size   = 4'h0;
     assign mst6_slv13_grant  = 1'b0;
     assign hm6_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv13_hburst = 3'h0;
     assign mst6_slv13_hprot  = 4'h0;
     assign mst6_slv13_hsize  = 3'h0;
     assign mst6_slv13_htrans = 2'h0;
     assign mst6_slv13_hwrite = 1'b0;
     assign mst6_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S13) begin : gen_m7s13
  assign mst7_hs13_hrdata  = hs13_hrdata;
  assign mst7_hs13_hready  = hs13_hready;
  assign mst7_hs13_hresp   = hs13_hresp;
  assign mst7_slv13_base   = slv13_base;
  assign mst7_slv13_size   = slv13_size;
  assign mst7_slv13_grant  = mst7_slv13_ack;
  assign hm7_slv13_hwdata  = hm7_hwdata;
  assign mst7_slv13_haddr  = mst7_haddr;
  assign mst7_slv13_hburst = mst7_hburst;
  assign mst7_slv13_hprot  = mst7_hprot;
  assign mst7_slv13_hsize  = mst7_hsize;
  assign mst7_slv13_htrans = mst7_htrans;
  assign mst7_slv13_hwrite = mst7_hwrite;
  assign mst7_slv13_req    = mst7_slv13_sel;
end
else begin : gen_m7s13_nonexistent
     assign mst7_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs13_hready  = 1'b0;
     assign mst7_hs13_hresp   = 2'h0;
     assign mst7_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv13_size   = 4'h0;
     assign mst7_slv13_grant  = 1'b0;
     assign hm7_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv13_hburst = 3'h0;
     assign mst7_slv13_hprot  = 4'h0;
     assign mst7_slv13_hsize  = 3'h0;
     assign mst7_slv13_htrans = 2'h0;
     assign mst7_slv13_hwrite = 1'b0;
     assign mst7_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S13) begin : gen_m8s13
  assign mst8_hs13_hrdata  = hs13_hrdata;
  assign mst8_hs13_hready  = hs13_hready;
  assign mst8_hs13_hresp   = hs13_hresp;
  assign mst8_slv13_base   = slv13_base;
  assign mst8_slv13_size   = slv13_size;
  assign mst8_slv13_grant  = mst8_slv13_ack;
  assign hm8_slv13_hwdata  = hm8_hwdata;
  assign mst8_slv13_haddr  = mst8_haddr;
  assign mst8_slv13_hburst = mst8_hburst;
  assign mst8_slv13_hprot  = mst8_hprot;
  assign mst8_slv13_hsize  = mst8_hsize;
  assign mst8_slv13_htrans = mst8_htrans;
  assign mst8_slv13_hwrite = mst8_hwrite;
  assign mst8_slv13_req    = mst8_slv13_sel;
end
else begin : gen_m8s13_nonexistent
     assign mst8_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs13_hready  = 1'b0;
     assign mst8_hs13_hresp   = 2'h0;
     assign mst8_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv13_size   = 4'h0;
     assign mst8_slv13_grant  = 1'b0;
     assign hm8_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv13_hburst = 3'h0;
     assign mst8_slv13_hprot  = 4'h0;
     assign mst8_slv13_hsize  = 3'h0;
     assign mst8_slv13_htrans = 2'h0;
     assign mst8_slv13_hwrite = 1'b0;
     assign mst8_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S13) begin : gen_m9s13
  assign mst9_hs13_hrdata  = hs13_hrdata;
  assign mst9_hs13_hready  = hs13_hready;
  assign mst9_hs13_hresp   = hs13_hresp;
  assign mst9_slv13_base   = slv13_base;
  assign mst9_slv13_size   = slv13_size;
  assign mst9_slv13_grant  = mst9_slv13_ack;
  assign hm9_slv13_hwdata  = hm9_hwdata;
  assign mst9_slv13_haddr  = mst9_haddr;
  assign mst9_slv13_hburst = mst9_hburst;
  assign mst9_slv13_hprot  = mst9_hprot;
  assign mst9_slv13_hsize  = mst9_hsize;
  assign mst9_slv13_htrans = mst9_htrans;
  assign mst9_slv13_hwrite = mst9_hwrite;
  assign mst9_slv13_req    = mst9_slv13_sel;
end
else begin : gen_m9s13_nonexistent
     assign mst9_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs13_hready  = 1'b0;
     assign mst9_hs13_hresp   = 2'h0;
     assign mst9_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv13_size   = 4'h0;
     assign mst9_slv13_grant  = 1'b0;
     assign hm9_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv13_hburst = 3'h0;
     assign mst9_slv13_hprot  = 4'h0;
     assign mst9_slv13_hsize  = 3'h0;
     assign mst9_slv13_htrans = 2'h0;
     assign mst9_slv13_hwrite = 1'b0;
     assign mst9_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S13) begin : gen_m10s13
  assign mst10_hs13_hrdata  = hs13_hrdata;
  assign mst10_hs13_hready  = hs13_hready;
  assign mst10_hs13_hresp   = hs13_hresp;
  assign mst10_slv13_base   = slv13_base;
  assign mst10_slv13_size   = slv13_size;
  assign mst10_slv13_grant  = mst10_slv13_ack;
  assign hm10_slv13_hwdata  = hm10_hwdata;
  assign mst10_slv13_haddr  = mst10_haddr;
  assign mst10_slv13_hburst = mst10_hburst;
  assign mst10_slv13_hprot  = mst10_hprot;
  assign mst10_slv13_hsize  = mst10_hsize;
  assign mst10_slv13_htrans = mst10_htrans;
  assign mst10_slv13_hwrite = mst10_hwrite;
  assign mst10_slv13_req    = mst10_slv13_sel;
end
else begin : gen_m10s13_nonexistent
     assign mst10_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs13_hready  = 1'b0;
     assign mst10_hs13_hresp   = 2'h0;
     assign mst10_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv13_size   = 4'h0;
     assign mst10_slv13_grant  = 1'b0;
     assign hm10_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv13_hburst = 3'h0;
     assign mst10_slv13_hprot  = 4'h0;
     assign mst10_slv13_hsize  = 3'h0;
     assign mst10_slv13_htrans = 2'h0;
     assign mst10_slv13_hwrite = 1'b0;
     assign mst10_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S13) begin : gen_m11s13
  assign mst11_hs13_hrdata  = hs13_hrdata;
  assign mst11_hs13_hready  = hs13_hready;
  assign mst11_hs13_hresp   = hs13_hresp;
  assign mst11_slv13_base   = slv13_base;
  assign mst11_slv13_size   = slv13_size;
  assign mst11_slv13_grant  = mst11_slv13_ack;
  assign hm11_slv13_hwdata  = hm11_hwdata;
  assign mst11_slv13_haddr  = mst11_haddr;
  assign mst11_slv13_hburst = mst11_hburst;
  assign mst11_slv13_hprot  = mst11_hprot;
  assign mst11_slv13_hsize  = mst11_hsize;
  assign mst11_slv13_htrans = mst11_htrans;
  assign mst11_slv13_hwrite = mst11_hwrite;
  assign mst11_slv13_req    = mst11_slv13_sel;
end
else begin : gen_m11s13_nonexistent
     assign mst11_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs13_hready  = 1'b0;
     assign mst11_hs13_hresp   = 2'h0;
     assign mst11_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv13_size   = 4'h0;
     assign mst11_slv13_grant  = 1'b0;
     assign hm11_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv13_hburst = 3'h0;
     assign mst11_slv13_hprot  = 4'h0;
     assign mst11_slv13_hsize  = 3'h0;
     assign mst11_slv13_htrans = 2'h0;
     assign mst11_slv13_hwrite = 1'b0;
     assign mst11_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S13) begin : gen_m12s13
  assign mst12_hs13_hrdata  = hs13_hrdata;
  assign mst12_hs13_hready  = hs13_hready;
  assign mst12_hs13_hresp   = hs13_hresp;
  assign mst12_slv13_base   = slv13_base;
  assign mst12_slv13_size   = slv13_size;
  assign mst12_slv13_grant  = mst12_slv13_ack;
  assign hm12_slv13_hwdata  = hm12_hwdata;
  assign mst12_slv13_haddr  = mst12_haddr;
  assign mst12_slv13_hburst = mst12_hburst;
  assign mst12_slv13_hprot  = mst12_hprot;
  assign mst12_slv13_hsize  = mst12_hsize;
  assign mst12_slv13_htrans = mst12_htrans;
  assign mst12_slv13_hwrite = mst12_hwrite;
  assign mst12_slv13_req    = mst12_slv13_sel;
end
else begin : gen_m12s13_nonexistent
     assign mst12_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs13_hready  = 1'b0;
     assign mst12_hs13_hresp   = 2'h0;
     assign mst12_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv13_size   = 4'h0;
     assign mst12_slv13_grant  = 1'b0;
     assign hm12_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv13_hburst = 3'h0;
     assign mst12_slv13_hprot  = 4'h0;
     assign mst12_slv13_hsize  = 3'h0;
     assign mst12_slv13_htrans = 2'h0;
     assign mst12_slv13_hwrite = 1'b0;
     assign mst12_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S13) begin : gen_m13s13
  assign mst13_hs13_hrdata  = hs13_hrdata;
  assign mst13_hs13_hready  = hs13_hready;
  assign mst13_hs13_hresp   = hs13_hresp;
  assign mst13_slv13_base   = slv13_base;
  assign mst13_slv13_size   = slv13_size;
  assign mst13_slv13_grant  = mst13_slv13_ack;
  assign hm13_slv13_hwdata  = hm13_hwdata;
  assign mst13_slv13_haddr  = mst13_haddr;
  assign mst13_slv13_hburst = mst13_hburst;
  assign mst13_slv13_hprot  = mst13_hprot;
  assign mst13_slv13_hsize  = mst13_hsize;
  assign mst13_slv13_htrans = mst13_htrans;
  assign mst13_slv13_hwrite = mst13_hwrite;
  assign mst13_slv13_req    = mst13_slv13_sel;
end
else begin : gen_m13s13_nonexistent
     assign mst13_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs13_hready  = 1'b0;
     assign mst13_hs13_hresp   = 2'h0;
     assign mst13_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv13_size   = 4'h0;
     assign mst13_slv13_grant  = 1'b0;
     assign hm13_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv13_hburst = 3'h0;
     assign mst13_slv13_hprot  = 4'h0;
     assign mst13_slv13_hsize  = 3'h0;
     assign mst13_slv13_htrans = 2'h0;
     assign mst13_slv13_hwrite = 1'b0;
     assign mst13_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S13) begin : gen_m14s13
  assign mst14_hs13_hrdata  = hs13_hrdata;
  assign mst14_hs13_hready  = hs13_hready;
  assign mst14_hs13_hresp   = hs13_hresp;
  assign mst14_slv13_base   = slv13_base;
  assign mst14_slv13_size   = slv13_size;
  assign mst14_slv13_grant  = mst14_slv13_ack;
  assign hm14_slv13_hwdata  = hm14_hwdata;
  assign mst14_slv13_haddr  = mst14_haddr;
  assign mst14_slv13_hburst = mst14_hburst;
  assign mst14_slv13_hprot  = mst14_hprot;
  assign mst14_slv13_hsize  = mst14_hsize;
  assign mst14_slv13_htrans = mst14_htrans;
  assign mst14_slv13_hwrite = mst14_hwrite;
  assign mst14_slv13_req    = mst14_slv13_sel;
end
else begin : gen_m14s13_nonexistent
     assign mst14_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs13_hready  = 1'b0;
     assign mst14_hs13_hresp   = 2'h0;
     assign mst14_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv13_size   = 4'h0;
     assign mst14_slv13_grant  = 1'b0;
     assign hm14_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv13_hburst = 3'h0;
     assign mst14_slv13_hprot  = 4'h0;
     assign mst14_slv13_hsize  = 3'h0;
     assign mst14_slv13_htrans = 2'h0;
     assign mst14_slv13_hwrite = 1'b0;
     assign mst14_slv13_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S13) begin : gen_m15s13
  assign mst15_hs13_hrdata  = hs13_hrdata;
  assign mst15_hs13_hready  = hs13_hready;
  assign mst15_hs13_hresp   = hs13_hresp;
  assign mst15_slv13_base   = slv13_base;
  assign mst15_slv13_size   = slv13_size;
  assign mst15_slv13_grant  = mst15_slv13_ack;
  assign hm15_slv13_hwdata  = hm15_hwdata;
  assign mst15_slv13_haddr  = mst15_haddr;
  assign mst15_slv13_hburst = mst15_hburst;
  assign mst15_slv13_hprot  = mst15_hprot;
  assign mst15_slv13_hsize  = mst15_hsize;
  assign mst15_slv13_htrans = mst15_htrans;
  assign mst15_slv13_hwrite = mst15_hwrite;
  assign mst15_slv13_req    = mst15_slv13_sel;
end
else begin : gen_m15s13_nonexistent
     assign mst15_hs13_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs13_hready  = 1'b0;
     assign mst15_hs13_hresp   = 2'h0;
     assign mst15_slv13_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv13_size   = 4'h0;
     assign mst15_slv13_grant  = 1'b0;
     assign hm15_slv13_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv13_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv13_hburst = 3'h0;
     assign mst15_slv13_hprot  = 4'h0;
     assign mst15_slv13_hsize  = 3'h0;
     assign mst15_slv13_htrans = 2'h0;
     assign mst15_slv13_hwrite = 1'b0;
     assign mst15_slv13_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV14
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S14) begin : gen_m0s14
  assign mst0_hs14_hrdata  = hs14_hrdata;
  assign mst0_hs14_hready  = hs14_hready;
  assign mst0_hs14_hresp   = hs14_hresp;
  assign mst0_slv14_base   = slv14_base;
  assign mst0_slv14_size   = slv14_size;
  assign mst0_slv14_grant  = mst0_slv14_ack;
  assign hm0_slv14_hwdata  = hm0_hwdata;
  assign mst0_slv14_haddr  = mst0_haddr;
  assign mst0_slv14_hburst = mst0_hburst;
  assign mst0_slv14_hprot  = mst0_hprot;
  assign mst0_slv14_hsize  = mst0_hsize;
  assign mst0_slv14_htrans = mst0_htrans;
  assign mst0_slv14_hwrite = mst0_hwrite;
  assign mst0_slv14_req    = mst0_slv14_sel;
end
else begin : gen_m0s14_nonexistent
     assign mst0_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs14_hready  = 1'b0;
     assign mst0_hs14_hresp   = 2'h0;
     assign mst0_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv14_size   = 4'h0;
     assign mst0_slv14_grant  = 1'b0;
     assign hm0_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv14_hburst = 3'h0;
     assign mst0_slv14_hprot  = 4'h0;
     assign mst0_slv14_hsize  = 3'h0;
     assign mst0_slv14_htrans = 2'h0;
     assign mst0_slv14_hwrite = 1'b0;
     assign mst0_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S14) begin : gen_m1s14
  assign mst1_hs14_hrdata  = hs14_hrdata;
  assign mst1_hs14_hready  = hs14_hready;
  assign mst1_hs14_hresp   = hs14_hresp;
  assign mst1_slv14_base   = slv14_base;
  assign mst1_slv14_size   = slv14_size;
  assign mst1_slv14_grant  = mst1_slv14_ack;
  assign hm1_slv14_hwdata  = hm1_hwdata;
  assign mst1_slv14_haddr  = mst1_haddr;
  assign mst1_slv14_hburst = mst1_hburst;
  assign mst1_slv14_hprot  = mst1_hprot;
  assign mst1_slv14_hsize  = mst1_hsize;
  assign mst1_slv14_htrans = mst1_htrans;
  assign mst1_slv14_hwrite = mst1_hwrite;
  assign mst1_slv14_req    = mst1_slv14_sel;
end
else begin : gen_m1s14_nonexistent
     assign mst1_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs14_hready  = 1'b0;
     assign mst1_hs14_hresp   = 2'h0;
     assign mst1_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv14_size   = 4'h0;
     assign mst1_slv14_grant  = 1'b0;
     assign hm1_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv14_hburst = 3'h0;
     assign mst1_slv14_hprot  = 4'h0;
     assign mst1_slv14_hsize  = 3'h0;
     assign mst1_slv14_htrans = 2'h0;
     assign mst1_slv14_hwrite = 1'b0;
     assign mst1_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S14) begin : gen_m2s14
  assign mst2_hs14_hrdata  = hs14_hrdata;
  assign mst2_hs14_hready  = hs14_hready;
  assign mst2_hs14_hresp   = hs14_hresp;
  assign mst2_slv14_base   = slv14_base;
  assign mst2_slv14_size   = slv14_size;
  assign mst2_slv14_grant  = mst2_slv14_ack;
  assign hm2_slv14_hwdata  = hm2_hwdata;
  assign mst2_slv14_haddr  = mst2_haddr;
  assign mst2_slv14_hburst = mst2_hburst;
  assign mst2_slv14_hprot  = mst2_hprot;
  assign mst2_slv14_hsize  = mst2_hsize;
  assign mst2_slv14_htrans = mst2_htrans;
  assign mst2_slv14_hwrite = mst2_hwrite;
  assign mst2_slv14_req    = mst2_slv14_sel;
end
else begin : gen_m2s14_nonexistent
     assign mst2_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs14_hready  = 1'b0;
     assign mst2_hs14_hresp   = 2'h0;
     assign mst2_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv14_size   = 4'h0;
     assign mst2_slv14_grant  = 1'b0;
     assign hm2_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv14_hburst = 3'h0;
     assign mst2_slv14_hprot  = 4'h0;
     assign mst2_slv14_hsize  = 3'h0;
     assign mst2_slv14_htrans = 2'h0;
     assign mst2_slv14_hwrite = 1'b0;
     assign mst2_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S14) begin : gen_m3s14
  assign mst3_hs14_hrdata  = hs14_hrdata;
  assign mst3_hs14_hready  = hs14_hready;
  assign mst3_hs14_hresp   = hs14_hresp;
  assign mst3_slv14_base   = slv14_base;
  assign mst3_slv14_size   = slv14_size;
  assign mst3_slv14_grant  = mst3_slv14_ack;
  assign hm3_slv14_hwdata  = hm3_hwdata;
  assign mst3_slv14_haddr  = mst3_haddr;
  assign mst3_slv14_hburst = mst3_hburst;
  assign mst3_slv14_hprot  = mst3_hprot;
  assign mst3_slv14_hsize  = mst3_hsize;
  assign mst3_slv14_htrans = mst3_htrans;
  assign mst3_slv14_hwrite = mst3_hwrite;
  assign mst3_slv14_req    = mst3_slv14_sel;
end
else begin : gen_m3s14_nonexistent
     assign mst3_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs14_hready  = 1'b0;
     assign mst3_hs14_hresp   = 2'h0;
     assign mst3_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv14_size   = 4'h0;
     assign mst3_slv14_grant  = 1'b0;
     assign hm3_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv14_hburst = 3'h0;
     assign mst3_slv14_hprot  = 4'h0;
     assign mst3_slv14_hsize  = 3'h0;
     assign mst3_slv14_htrans = 2'h0;
     assign mst3_slv14_hwrite = 1'b0;
     assign mst3_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S14) begin : gen_m4s14
  assign mst4_hs14_hrdata  = hs14_hrdata;
  assign mst4_hs14_hready  = hs14_hready;
  assign mst4_hs14_hresp   = hs14_hresp;
  assign mst4_slv14_base   = slv14_base;
  assign mst4_slv14_size   = slv14_size;
  assign mst4_slv14_grant  = mst4_slv14_ack;
  assign hm4_slv14_hwdata  = hm4_hwdata;
  assign mst4_slv14_haddr  = mst4_haddr;
  assign mst4_slv14_hburst = mst4_hburst;
  assign mst4_slv14_hprot  = mst4_hprot;
  assign mst4_slv14_hsize  = mst4_hsize;
  assign mst4_slv14_htrans = mst4_htrans;
  assign mst4_slv14_hwrite = mst4_hwrite;
  assign mst4_slv14_req    = mst4_slv14_sel;
end
else begin : gen_m4s14_nonexistent
     assign mst4_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs14_hready  = 1'b0;
     assign mst4_hs14_hresp   = 2'h0;
     assign mst4_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv14_size   = 4'h0;
     assign mst4_slv14_grant  = 1'b0;
     assign hm4_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv14_hburst = 3'h0;
     assign mst4_slv14_hprot  = 4'h0;
     assign mst4_slv14_hsize  = 3'h0;
     assign mst4_slv14_htrans = 2'h0;
     assign mst4_slv14_hwrite = 1'b0;
     assign mst4_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S14) begin : gen_m5s14
  assign mst5_hs14_hrdata  = hs14_hrdata;
  assign mst5_hs14_hready  = hs14_hready;
  assign mst5_hs14_hresp   = hs14_hresp;
  assign mst5_slv14_base   = slv14_base;
  assign mst5_slv14_size   = slv14_size;
  assign mst5_slv14_grant  = mst5_slv14_ack;
  assign hm5_slv14_hwdata  = hm5_hwdata;
  assign mst5_slv14_haddr  = mst5_haddr;
  assign mst5_slv14_hburst = mst5_hburst;
  assign mst5_slv14_hprot  = mst5_hprot;
  assign mst5_slv14_hsize  = mst5_hsize;
  assign mst5_slv14_htrans = mst5_htrans;
  assign mst5_slv14_hwrite = mst5_hwrite;
  assign mst5_slv14_req    = mst5_slv14_sel;
end
else begin : gen_m5s14_nonexistent
     assign mst5_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs14_hready  = 1'b0;
     assign mst5_hs14_hresp   = 2'h0;
     assign mst5_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv14_size   = 4'h0;
     assign mst5_slv14_grant  = 1'b0;
     assign hm5_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv14_hburst = 3'h0;
     assign mst5_slv14_hprot  = 4'h0;
     assign mst5_slv14_hsize  = 3'h0;
     assign mst5_slv14_htrans = 2'h0;
     assign mst5_slv14_hwrite = 1'b0;
     assign mst5_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S14) begin : gen_m6s14
  assign mst6_hs14_hrdata  = hs14_hrdata;
  assign mst6_hs14_hready  = hs14_hready;
  assign mst6_hs14_hresp   = hs14_hresp;
  assign mst6_slv14_base   = slv14_base;
  assign mst6_slv14_size   = slv14_size;
  assign mst6_slv14_grant  = mst6_slv14_ack;
  assign hm6_slv14_hwdata  = hm6_hwdata;
  assign mst6_slv14_haddr  = mst6_haddr;
  assign mst6_slv14_hburst = mst6_hburst;
  assign mst6_slv14_hprot  = mst6_hprot;
  assign mst6_slv14_hsize  = mst6_hsize;
  assign mst6_slv14_htrans = mst6_htrans;
  assign mst6_slv14_hwrite = mst6_hwrite;
  assign mst6_slv14_req    = mst6_slv14_sel;
end
else begin : gen_m6s14_nonexistent
     assign mst6_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs14_hready  = 1'b0;
     assign mst6_hs14_hresp   = 2'h0;
     assign mst6_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv14_size   = 4'h0;
     assign mst6_slv14_grant  = 1'b0;
     assign hm6_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv14_hburst = 3'h0;
     assign mst6_slv14_hprot  = 4'h0;
     assign mst6_slv14_hsize  = 3'h0;
     assign mst6_slv14_htrans = 2'h0;
     assign mst6_slv14_hwrite = 1'b0;
     assign mst6_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S14) begin : gen_m7s14
  assign mst7_hs14_hrdata  = hs14_hrdata;
  assign mst7_hs14_hready  = hs14_hready;
  assign mst7_hs14_hresp   = hs14_hresp;
  assign mst7_slv14_base   = slv14_base;
  assign mst7_slv14_size   = slv14_size;
  assign mst7_slv14_grant  = mst7_slv14_ack;
  assign hm7_slv14_hwdata  = hm7_hwdata;
  assign mst7_slv14_haddr  = mst7_haddr;
  assign mst7_slv14_hburst = mst7_hburst;
  assign mst7_slv14_hprot  = mst7_hprot;
  assign mst7_slv14_hsize  = mst7_hsize;
  assign mst7_slv14_htrans = mst7_htrans;
  assign mst7_slv14_hwrite = mst7_hwrite;
  assign mst7_slv14_req    = mst7_slv14_sel;
end
else begin : gen_m7s14_nonexistent
     assign mst7_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs14_hready  = 1'b0;
     assign mst7_hs14_hresp   = 2'h0;
     assign mst7_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv14_size   = 4'h0;
     assign mst7_slv14_grant  = 1'b0;
     assign hm7_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv14_hburst = 3'h0;
     assign mst7_slv14_hprot  = 4'h0;
     assign mst7_slv14_hsize  = 3'h0;
     assign mst7_slv14_htrans = 2'h0;
     assign mst7_slv14_hwrite = 1'b0;
     assign mst7_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S14) begin : gen_m8s14
  assign mst8_hs14_hrdata  = hs14_hrdata;
  assign mst8_hs14_hready  = hs14_hready;
  assign mst8_hs14_hresp   = hs14_hresp;
  assign mst8_slv14_base   = slv14_base;
  assign mst8_slv14_size   = slv14_size;
  assign mst8_slv14_grant  = mst8_slv14_ack;
  assign hm8_slv14_hwdata  = hm8_hwdata;
  assign mst8_slv14_haddr  = mst8_haddr;
  assign mst8_slv14_hburst = mst8_hburst;
  assign mst8_slv14_hprot  = mst8_hprot;
  assign mst8_slv14_hsize  = mst8_hsize;
  assign mst8_slv14_htrans = mst8_htrans;
  assign mst8_slv14_hwrite = mst8_hwrite;
  assign mst8_slv14_req    = mst8_slv14_sel;
end
else begin : gen_m8s14_nonexistent
     assign mst8_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs14_hready  = 1'b0;
     assign mst8_hs14_hresp   = 2'h0;
     assign mst8_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv14_size   = 4'h0;
     assign mst8_slv14_grant  = 1'b0;
     assign hm8_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv14_hburst = 3'h0;
     assign mst8_slv14_hprot  = 4'h0;
     assign mst8_slv14_hsize  = 3'h0;
     assign mst8_slv14_htrans = 2'h0;
     assign mst8_slv14_hwrite = 1'b0;
     assign mst8_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S14) begin : gen_m9s14
  assign mst9_hs14_hrdata  = hs14_hrdata;
  assign mst9_hs14_hready  = hs14_hready;
  assign mst9_hs14_hresp   = hs14_hresp;
  assign mst9_slv14_base   = slv14_base;
  assign mst9_slv14_size   = slv14_size;
  assign mst9_slv14_grant  = mst9_slv14_ack;
  assign hm9_slv14_hwdata  = hm9_hwdata;
  assign mst9_slv14_haddr  = mst9_haddr;
  assign mst9_slv14_hburst = mst9_hburst;
  assign mst9_slv14_hprot  = mst9_hprot;
  assign mst9_slv14_hsize  = mst9_hsize;
  assign mst9_slv14_htrans = mst9_htrans;
  assign mst9_slv14_hwrite = mst9_hwrite;
  assign mst9_slv14_req    = mst9_slv14_sel;
end
else begin : gen_m9s14_nonexistent
     assign mst9_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs14_hready  = 1'b0;
     assign mst9_hs14_hresp   = 2'h0;
     assign mst9_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv14_size   = 4'h0;
     assign mst9_slv14_grant  = 1'b0;
     assign hm9_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv14_hburst = 3'h0;
     assign mst9_slv14_hprot  = 4'h0;
     assign mst9_slv14_hsize  = 3'h0;
     assign mst9_slv14_htrans = 2'h0;
     assign mst9_slv14_hwrite = 1'b0;
     assign mst9_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S14) begin : gen_m10s14
  assign mst10_hs14_hrdata  = hs14_hrdata;
  assign mst10_hs14_hready  = hs14_hready;
  assign mst10_hs14_hresp   = hs14_hresp;
  assign mst10_slv14_base   = slv14_base;
  assign mst10_slv14_size   = slv14_size;
  assign mst10_slv14_grant  = mst10_slv14_ack;
  assign hm10_slv14_hwdata  = hm10_hwdata;
  assign mst10_slv14_haddr  = mst10_haddr;
  assign mst10_slv14_hburst = mst10_hburst;
  assign mst10_slv14_hprot  = mst10_hprot;
  assign mst10_slv14_hsize  = mst10_hsize;
  assign mst10_slv14_htrans = mst10_htrans;
  assign mst10_slv14_hwrite = mst10_hwrite;
  assign mst10_slv14_req    = mst10_slv14_sel;
end
else begin : gen_m10s14_nonexistent
     assign mst10_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs14_hready  = 1'b0;
     assign mst10_hs14_hresp   = 2'h0;
     assign mst10_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv14_size   = 4'h0;
     assign mst10_slv14_grant  = 1'b0;
     assign hm10_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv14_hburst = 3'h0;
     assign mst10_slv14_hprot  = 4'h0;
     assign mst10_slv14_hsize  = 3'h0;
     assign mst10_slv14_htrans = 2'h0;
     assign mst10_slv14_hwrite = 1'b0;
     assign mst10_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S14) begin : gen_m11s14
  assign mst11_hs14_hrdata  = hs14_hrdata;
  assign mst11_hs14_hready  = hs14_hready;
  assign mst11_hs14_hresp   = hs14_hresp;
  assign mst11_slv14_base   = slv14_base;
  assign mst11_slv14_size   = slv14_size;
  assign mst11_slv14_grant  = mst11_slv14_ack;
  assign hm11_slv14_hwdata  = hm11_hwdata;
  assign mst11_slv14_haddr  = mst11_haddr;
  assign mst11_slv14_hburst = mst11_hburst;
  assign mst11_slv14_hprot  = mst11_hprot;
  assign mst11_slv14_hsize  = mst11_hsize;
  assign mst11_slv14_htrans = mst11_htrans;
  assign mst11_slv14_hwrite = mst11_hwrite;
  assign mst11_slv14_req    = mst11_slv14_sel;
end
else begin : gen_m11s14_nonexistent
     assign mst11_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs14_hready  = 1'b0;
     assign mst11_hs14_hresp   = 2'h0;
     assign mst11_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv14_size   = 4'h0;
     assign mst11_slv14_grant  = 1'b0;
     assign hm11_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv14_hburst = 3'h0;
     assign mst11_slv14_hprot  = 4'h0;
     assign mst11_slv14_hsize  = 3'h0;
     assign mst11_slv14_htrans = 2'h0;
     assign mst11_slv14_hwrite = 1'b0;
     assign mst11_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S14) begin : gen_m12s14
  assign mst12_hs14_hrdata  = hs14_hrdata;
  assign mst12_hs14_hready  = hs14_hready;
  assign mst12_hs14_hresp   = hs14_hresp;
  assign mst12_slv14_base   = slv14_base;
  assign mst12_slv14_size   = slv14_size;
  assign mst12_slv14_grant  = mst12_slv14_ack;
  assign hm12_slv14_hwdata  = hm12_hwdata;
  assign mst12_slv14_haddr  = mst12_haddr;
  assign mst12_slv14_hburst = mst12_hburst;
  assign mst12_slv14_hprot  = mst12_hprot;
  assign mst12_slv14_hsize  = mst12_hsize;
  assign mst12_slv14_htrans = mst12_htrans;
  assign mst12_slv14_hwrite = mst12_hwrite;
  assign mst12_slv14_req    = mst12_slv14_sel;
end
else begin : gen_m12s14_nonexistent
     assign mst12_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs14_hready  = 1'b0;
     assign mst12_hs14_hresp   = 2'h0;
     assign mst12_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv14_size   = 4'h0;
     assign mst12_slv14_grant  = 1'b0;
     assign hm12_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv14_hburst = 3'h0;
     assign mst12_slv14_hprot  = 4'h0;
     assign mst12_slv14_hsize  = 3'h0;
     assign mst12_slv14_htrans = 2'h0;
     assign mst12_slv14_hwrite = 1'b0;
     assign mst12_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S14) begin : gen_m13s14
  assign mst13_hs14_hrdata  = hs14_hrdata;
  assign mst13_hs14_hready  = hs14_hready;
  assign mst13_hs14_hresp   = hs14_hresp;
  assign mst13_slv14_base   = slv14_base;
  assign mst13_slv14_size   = slv14_size;
  assign mst13_slv14_grant  = mst13_slv14_ack;
  assign hm13_slv14_hwdata  = hm13_hwdata;
  assign mst13_slv14_haddr  = mst13_haddr;
  assign mst13_slv14_hburst = mst13_hburst;
  assign mst13_slv14_hprot  = mst13_hprot;
  assign mst13_slv14_hsize  = mst13_hsize;
  assign mst13_slv14_htrans = mst13_htrans;
  assign mst13_slv14_hwrite = mst13_hwrite;
  assign mst13_slv14_req    = mst13_slv14_sel;
end
else begin : gen_m13s14_nonexistent
     assign mst13_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs14_hready  = 1'b0;
     assign mst13_hs14_hresp   = 2'h0;
     assign mst13_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv14_size   = 4'h0;
     assign mst13_slv14_grant  = 1'b0;
     assign hm13_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv14_hburst = 3'h0;
     assign mst13_slv14_hprot  = 4'h0;
     assign mst13_slv14_hsize  = 3'h0;
     assign mst13_slv14_htrans = 2'h0;
     assign mst13_slv14_hwrite = 1'b0;
     assign mst13_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S14) begin : gen_m14s14
  assign mst14_hs14_hrdata  = hs14_hrdata;
  assign mst14_hs14_hready  = hs14_hready;
  assign mst14_hs14_hresp   = hs14_hresp;
  assign mst14_slv14_base   = slv14_base;
  assign mst14_slv14_size   = slv14_size;
  assign mst14_slv14_grant  = mst14_slv14_ack;
  assign hm14_slv14_hwdata  = hm14_hwdata;
  assign mst14_slv14_haddr  = mst14_haddr;
  assign mst14_slv14_hburst = mst14_hburst;
  assign mst14_slv14_hprot  = mst14_hprot;
  assign mst14_slv14_hsize  = mst14_hsize;
  assign mst14_slv14_htrans = mst14_htrans;
  assign mst14_slv14_hwrite = mst14_hwrite;
  assign mst14_slv14_req    = mst14_slv14_sel;
end
else begin : gen_m14s14_nonexistent
     assign mst14_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs14_hready  = 1'b0;
     assign mst14_hs14_hresp   = 2'h0;
     assign mst14_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv14_size   = 4'h0;
     assign mst14_slv14_grant  = 1'b0;
     assign hm14_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv14_hburst = 3'h0;
     assign mst14_slv14_hprot  = 4'h0;
     assign mst14_slv14_hsize  = 3'h0;
     assign mst14_slv14_htrans = 2'h0;
     assign mst14_slv14_hwrite = 1'b0;
     assign mst14_slv14_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S14) begin : gen_m15s14
  assign mst15_hs14_hrdata  = hs14_hrdata;
  assign mst15_hs14_hready  = hs14_hready;
  assign mst15_hs14_hresp   = hs14_hresp;
  assign mst15_slv14_base   = slv14_base;
  assign mst15_slv14_size   = slv14_size;
  assign mst15_slv14_grant  = mst15_slv14_ack;
  assign hm15_slv14_hwdata  = hm15_hwdata;
  assign mst15_slv14_haddr  = mst15_haddr;
  assign mst15_slv14_hburst = mst15_hburst;
  assign mst15_slv14_hprot  = mst15_hprot;
  assign mst15_slv14_hsize  = mst15_hsize;
  assign mst15_slv14_htrans = mst15_htrans;
  assign mst15_slv14_hwrite = mst15_hwrite;
  assign mst15_slv14_req    = mst15_slv14_sel;
end
else begin : gen_m15s14_nonexistent
     assign mst15_hs14_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs14_hready  = 1'b0;
     assign mst15_hs14_hresp   = 2'h0;
     assign mst15_slv14_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv14_size   = 4'h0;
     assign mst15_slv14_grant  = 1'b0;
     assign hm15_slv14_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv14_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv14_hburst = 3'h0;
     assign mst15_slv14_hprot  = 4'h0;
     assign mst15_slv14_hsize  = 3'h0;
     assign mst15_slv14_htrans = 2'h0;
     assign mst15_slv14_hwrite = 1'b0;
     assign mst15_slv14_req    = 1'b0;
end
endgenerate
  `endif
`endif
`ifdef ATCBMC200_AHB_SLV15
  `ifdef ATCBMC200_AHB_MST0
generate if (`ATCBMC200_M0S15) begin : gen_m0s15
  assign mst0_hs15_hrdata  = hs15_hrdata;
  assign mst0_hs15_hready  = hs15_hready;
  assign mst0_hs15_hresp   = hs15_hresp;
  assign mst0_slv15_base   = slv15_base;
  assign mst0_slv15_size   = slv15_size;
  assign mst0_slv15_grant  = mst0_slv15_ack;
  assign hm0_slv15_hwdata  = hm0_hwdata;
  assign mst0_slv15_haddr  = mst0_haddr;
  assign mst0_slv15_hburst = mst0_hburst;
  assign mst0_slv15_hprot  = mst0_hprot;
  assign mst0_slv15_hsize  = mst0_hsize;
  assign mst0_slv15_htrans = mst0_htrans;
  assign mst0_slv15_hwrite = mst0_hwrite;
  assign mst0_slv15_req    = mst0_slv15_sel;
end
else begin : gen_m0s15_nonexistent
     assign mst0_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst0_hs15_hready  = 1'b0;
     assign mst0_hs15_hresp   = 2'h0;
     assign mst0_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst0_slv15_size   = 4'h0;
     assign mst0_slv15_grant  = 1'b0;
     assign hm0_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst0_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst0_slv15_hburst = 3'h0;
     assign mst0_slv15_hprot  = 4'h0;
     assign mst0_slv15_hsize  = 3'h0;
     assign mst0_slv15_htrans = 2'h0;
     assign mst0_slv15_hwrite = 1'b0;
     assign mst0_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST1
generate if (`ATCBMC200_M1S15) begin : gen_m1s15
  assign mst1_hs15_hrdata  = hs15_hrdata;
  assign mst1_hs15_hready  = hs15_hready;
  assign mst1_hs15_hresp   = hs15_hresp;
  assign mst1_slv15_base   = slv15_base;
  assign mst1_slv15_size   = slv15_size;
  assign mst1_slv15_grant  = mst1_slv15_ack;
  assign hm1_slv15_hwdata  = hm1_hwdata;
  assign mst1_slv15_haddr  = mst1_haddr;
  assign mst1_slv15_hburst = mst1_hburst;
  assign mst1_slv15_hprot  = mst1_hprot;
  assign mst1_slv15_hsize  = mst1_hsize;
  assign mst1_slv15_htrans = mst1_htrans;
  assign mst1_slv15_hwrite = mst1_hwrite;
  assign mst1_slv15_req    = mst1_slv15_sel;
end
else begin : gen_m1s15_nonexistent
     assign mst1_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst1_hs15_hready  = 1'b0;
     assign mst1_hs15_hresp   = 2'h0;
     assign mst1_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst1_slv15_size   = 4'h0;
     assign mst1_slv15_grant  = 1'b0;
     assign hm1_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst1_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst1_slv15_hburst = 3'h0;
     assign mst1_slv15_hprot  = 4'h0;
     assign mst1_slv15_hsize  = 3'h0;
     assign mst1_slv15_htrans = 2'h0;
     assign mst1_slv15_hwrite = 1'b0;
     assign mst1_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST2
generate if (`ATCBMC200_M2S15) begin : gen_m2s15
  assign mst2_hs15_hrdata  = hs15_hrdata;
  assign mst2_hs15_hready  = hs15_hready;
  assign mst2_hs15_hresp   = hs15_hresp;
  assign mst2_slv15_base   = slv15_base;
  assign mst2_slv15_size   = slv15_size;
  assign mst2_slv15_grant  = mst2_slv15_ack;
  assign hm2_slv15_hwdata  = hm2_hwdata;
  assign mst2_slv15_haddr  = mst2_haddr;
  assign mst2_slv15_hburst = mst2_hburst;
  assign mst2_slv15_hprot  = mst2_hprot;
  assign mst2_slv15_hsize  = mst2_hsize;
  assign mst2_slv15_htrans = mst2_htrans;
  assign mst2_slv15_hwrite = mst2_hwrite;
  assign mst2_slv15_req    = mst2_slv15_sel;
end
else begin : gen_m2s15_nonexistent
     assign mst2_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst2_hs15_hready  = 1'b0;
     assign mst2_hs15_hresp   = 2'h0;
     assign mst2_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst2_slv15_size   = 4'h0;
     assign mst2_slv15_grant  = 1'b0;
     assign hm2_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst2_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst2_slv15_hburst = 3'h0;
     assign mst2_slv15_hprot  = 4'h0;
     assign mst2_slv15_hsize  = 3'h0;
     assign mst2_slv15_htrans = 2'h0;
     assign mst2_slv15_hwrite = 1'b0;
     assign mst2_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST3
generate if (`ATCBMC200_M3S15) begin : gen_m3s15
  assign mst3_hs15_hrdata  = hs15_hrdata;
  assign mst3_hs15_hready  = hs15_hready;
  assign mst3_hs15_hresp   = hs15_hresp;
  assign mst3_slv15_base   = slv15_base;
  assign mst3_slv15_size   = slv15_size;
  assign mst3_slv15_grant  = mst3_slv15_ack;
  assign hm3_slv15_hwdata  = hm3_hwdata;
  assign mst3_slv15_haddr  = mst3_haddr;
  assign mst3_slv15_hburst = mst3_hburst;
  assign mst3_slv15_hprot  = mst3_hprot;
  assign mst3_slv15_hsize  = mst3_hsize;
  assign mst3_slv15_htrans = mst3_htrans;
  assign mst3_slv15_hwrite = mst3_hwrite;
  assign mst3_slv15_req    = mst3_slv15_sel;
end
else begin : gen_m3s15_nonexistent
     assign mst3_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst3_hs15_hready  = 1'b0;
     assign mst3_hs15_hresp   = 2'h0;
     assign mst3_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst3_slv15_size   = 4'h0;
     assign mst3_slv15_grant  = 1'b0;
     assign hm3_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst3_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst3_slv15_hburst = 3'h0;
     assign mst3_slv15_hprot  = 4'h0;
     assign mst3_slv15_hsize  = 3'h0;
     assign mst3_slv15_htrans = 2'h0;
     assign mst3_slv15_hwrite = 1'b0;
     assign mst3_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST4
generate if (`ATCBMC200_M4S15) begin : gen_m4s15
  assign mst4_hs15_hrdata  = hs15_hrdata;
  assign mst4_hs15_hready  = hs15_hready;
  assign mst4_hs15_hresp   = hs15_hresp;
  assign mst4_slv15_base   = slv15_base;
  assign mst4_slv15_size   = slv15_size;
  assign mst4_slv15_grant  = mst4_slv15_ack;
  assign hm4_slv15_hwdata  = hm4_hwdata;
  assign mst4_slv15_haddr  = mst4_haddr;
  assign mst4_slv15_hburst = mst4_hburst;
  assign mst4_slv15_hprot  = mst4_hprot;
  assign mst4_slv15_hsize  = mst4_hsize;
  assign mst4_slv15_htrans = mst4_htrans;
  assign mst4_slv15_hwrite = mst4_hwrite;
  assign mst4_slv15_req    = mst4_slv15_sel;
end
else begin : gen_m4s15_nonexistent
     assign mst4_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst4_hs15_hready  = 1'b0;
     assign mst4_hs15_hresp   = 2'h0;
     assign mst4_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst4_slv15_size   = 4'h0;
     assign mst4_slv15_grant  = 1'b0;
     assign hm4_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst4_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst4_slv15_hburst = 3'h0;
     assign mst4_slv15_hprot  = 4'h0;
     assign mst4_slv15_hsize  = 3'h0;
     assign mst4_slv15_htrans = 2'h0;
     assign mst4_slv15_hwrite = 1'b0;
     assign mst4_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST5
generate if (`ATCBMC200_M5S15) begin : gen_m5s15
  assign mst5_hs15_hrdata  = hs15_hrdata;
  assign mst5_hs15_hready  = hs15_hready;
  assign mst5_hs15_hresp   = hs15_hresp;
  assign mst5_slv15_base   = slv15_base;
  assign mst5_slv15_size   = slv15_size;
  assign mst5_slv15_grant  = mst5_slv15_ack;
  assign hm5_slv15_hwdata  = hm5_hwdata;
  assign mst5_slv15_haddr  = mst5_haddr;
  assign mst5_slv15_hburst = mst5_hburst;
  assign mst5_slv15_hprot  = mst5_hprot;
  assign mst5_slv15_hsize  = mst5_hsize;
  assign mst5_slv15_htrans = mst5_htrans;
  assign mst5_slv15_hwrite = mst5_hwrite;
  assign mst5_slv15_req    = mst5_slv15_sel;
end
else begin : gen_m5s15_nonexistent
     assign mst5_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst5_hs15_hready  = 1'b0;
     assign mst5_hs15_hresp   = 2'h0;
     assign mst5_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst5_slv15_size   = 4'h0;
     assign mst5_slv15_grant  = 1'b0;
     assign hm5_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst5_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst5_slv15_hburst = 3'h0;
     assign mst5_slv15_hprot  = 4'h0;
     assign mst5_slv15_hsize  = 3'h0;
     assign mst5_slv15_htrans = 2'h0;
     assign mst5_slv15_hwrite = 1'b0;
     assign mst5_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST6
generate if (`ATCBMC200_M6S15) begin : gen_m6s15
  assign mst6_hs15_hrdata  = hs15_hrdata;
  assign mst6_hs15_hready  = hs15_hready;
  assign mst6_hs15_hresp   = hs15_hresp;
  assign mst6_slv15_base   = slv15_base;
  assign mst6_slv15_size   = slv15_size;
  assign mst6_slv15_grant  = mst6_slv15_ack;
  assign hm6_slv15_hwdata  = hm6_hwdata;
  assign mst6_slv15_haddr  = mst6_haddr;
  assign mst6_slv15_hburst = mst6_hburst;
  assign mst6_slv15_hprot  = mst6_hprot;
  assign mst6_slv15_hsize  = mst6_hsize;
  assign mst6_slv15_htrans = mst6_htrans;
  assign mst6_slv15_hwrite = mst6_hwrite;
  assign mst6_slv15_req    = mst6_slv15_sel;
end
else begin : gen_m6s15_nonexistent
     assign mst6_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst6_hs15_hready  = 1'b0;
     assign mst6_hs15_hresp   = 2'h0;
     assign mst6_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst6_slv15_size   = 4'h0;
     assign mst6_slv15_grant  = 1'b0;
     assign hm6_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst6_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst6_slv15_hburst = 3'h0;
     assign mst6_slv15_hprot  = 4'h0;
     assign mst6_slv15_hsize  = 3'h0;
     assign mst6_slv15_htrans = 2'h0;
     assign mst6_slv15_hwrite = 1'b0;
     assign mst6_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST7
generate if (`ATCBMC200_M7S15) begin : gen_m7s15
  assign mst7_hs15_hrdata  = hs15_hrdata;
  assign mst7_hs15_hready  = hs15_hready;
  assign mst7_hs15_hresp   = hs15_hresp;
  assign mst7_slv15_base   = slv15_base;
  assign mst7_slv15_size   = slv15_size;
  assign mst7_slv15_grant  = mst7_slv15_ack;
  assign hm7_slv15_hwdata  = hm7_hwdata;
  assign mst7_slv15_haddr  = mst7_haddr;
  assign mst7_slv15_hburst = mst7_hburst;
  assign mst7_slv15_hprot  = mst7_hprot;
  assign mst7_slv15_hsize  = mst7_hsize;
  assign mst7_slv15_htrans = mst7_htrans;
  assign mst7_slv15_hwrite = mst7_hwrite;
  assign mst7_slv15_req    = mst7_slv15_sel;
end
else begin : gen_m7s15_nonexistent
     assign mst7_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst7_hs15_hready  = 1'b0;
     assign mst7_hs15_hresp   = 2'h0;
     assign mst7_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst7_slv15_size   = 4'h0;
     assign mst7_slv15_grant  = 1'b0;
     assign hm7_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst7_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst7_slv15_hburst = 3'h0;
     assign mst7_slv15_hprot  = 4'h0;
     assign mst7_slv15_hsize  = 3'h0;
     assign mst7_slv15_htrans = 2'h0;
     assign mst7_slv15_hwrite = 1'b0;
     assign mst7_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST8
generate if (`ATCBMC200_M8S15) begin : gen_m8s15
  assign mst8_hs15_hrdata  = hs15_hrdata;
  assign mst8_hs15_hready  = hs15_hready;
  assign mst8_hs15_hresp   = hs15_hresp;
  assign mst8_slv15_base   = slv15_base;
  assign mst8_slv15_size   = slv15_size;
  assign mst8_slv15_grant  = mst8_slv15_ack;
  assign hm8_slv15_hwdata  = hm8_hwdata;
  assign mst8_slv15_haddr  = mst8_haddr;
  assign mst8_slv15_hburst = mst8_hburst;
  assign mst8_slv15_hprot  = mst8_hprot;
  assign mst8_slv15_hsize  = mst8_hsize;
  assign mst8_slv15_htrans = mst8_htrans;
  assign mst8_slv15_hwrite = mst8_hwrite;
  assign mst8_slv15_req    = mst8_slv15_sel;
end
else begin : gen_m8s15_nonexistent
     assign mst8_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst8_hs15_hready  = 1'b0;
     assign mst8_hs15_hresp   = 2'h0;
     assign mst8_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst8_slv15_size   = 4'h0;
     assign mst8_slv15_grant  = 1'b0;
     assign hm8_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst8_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst8_slv15_hburst = 3'h0;
     assign mst8_slv15_hprot  = 4'h0;
     assign mst8_slv15_hsize  = 3'h0;
     assign mst8_slv15_htrans = 2'h0;
     assign mst8_slv15_hwrite = 1'b0;
     assign mst8_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST9
generate if (`ATCBMC200_M9S15) begin : gen_m9s15
  assign mst9_hs15_hrdata  = hs15_hrdata;
  assign mst9_hs15_hready  = hs15_hready;
  assign mst9_hs15_hresp   = hs15_hresp;
  assign mst9_slv15_base   = slv15_base;
  assign mst9_slv15_size   = slv15_size;
  assign mst9_slv15_grant  = mst9_slv15_ack;
  assign hm9_slv15_hwdata  = hm9_hwdata;
  assign mst9_slv15_haddr  = mst9_haddr;
  assign mst9_slv15_hburst = mst9_hburst;
  assign mst9_slv15_hprot  = mst9_hprot;
  assign mst9_slv15_hsize  = mst9_hsize;
  assign mst9_slv15_htrans = mst9_htrans;
  assign mst9_slv15_hwrite = mst9_hwrite;
  assign mst9_slv15_req    = mst9_slv15_sel;
end
else begin : gen_m9s15_nonexistent
     assign mst9_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst9_hs15_hready  = 1'b0;
     assign mst9_hs15_hresp   = 2'h0;
     assign mst9_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst9_slv15_size   = 4'h0;
     assign mst9_slv15_grant  = 1'b0;
     assign hm9_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst9_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst9_slv15_hburst = 3'h0;
     assign mst9_slv15_hprot  = 4'h0;
     assign mst9_slv15_hsize  = 3'h0;
     assign mst9_slv15_htrans = 2'h0;
     assign mst9_slv15_hwrite = 1'b0;
     assign mst9_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST10
generate if (`ATCBMC200_M10S15) begin : gen_m10s15
  assign mst10_hs15_hrdata  = hs15_hrdata;
  assign mst10_hs15_hready  = hs15_hready;
  assign mst10_hs15_hresp   = hs15_hresp;
  assign mst10_slv15_base   = slv15_base;
  assign mst10_slv15_size   = slv15_size;
  assign mst10_slv15_grant  = mst10_slv15_ack;
  assign hm10_slv15_hwdata  = hm10_hwdata;
  assign mst10_slv15_haddr  = mst10_haddr;
  assign mst10_slv15_hburst = mst10_hburst;
  assign mst10_slv15_hprot  = mst10_hprot;
  assign mst10_slv15_hsize  = mst10_hsize;
  assign mst10_slv15_htrans = mst10_htrans;
  assign mst10_slv15_hwrite = mst10_hwrite;
  assign mst10_slv15_req    = mst10_slv15_sel;
end
else begin : gen_m10s15_nonexistent
     assign mst10_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst10_hs15_hready  = 1'b0;
     assign mst10_hs15_hresp   = 2'h0;
     assign mst10_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst10_slv15_size   = 4'h0;
     assign mst10_slv15_grant  = 1'b0;
     assign hm10_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst10_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst10_slv15_hburst = 3'h0;
     assign mst10_slv15_hprot  = 4'h0;
     assign mst10_slv15_hsize  = 3'h0;
     assign mst10_slv15_htrans = 2'h0;
     assign mst10_slv15_hwrite = 1'b0;
     assign mst10_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST11
generate if (`ATCBMC200_M11S15) begin : gen_m11s15
  assign mst11_hs15_hrdata  = hs15_hrdata;
  assign mst11_hs15_hready  = hs15_hready;
  assign mst11_hs15_hresp   = hs15_hresp;
  assign mst11_slv15_base   = slv15_base;
  assign mst11_slv15_size   = slv15_size;
  assign mst11_slv15_grant  = mst11_slv15_ack;
  assign hm11_slv15_hwdata  = hm11_hwdata;
  assign mst11_slv15_haddr  = mst11_haddr;
  assign mst11_slv15_hburst = mst11_hburst;
  assign mst11_slv15_hprot  = mst11_hprot;
  assign mst11_slv15_hsize  = mst11_hsize;
  assign mst11_slv15_htrans = mst11_htrans;
  assign mst11_slv15_hwrite = mst11_hwrite;
  assign mst11_slv15_req    = mst11_slv15_sel;
end
else begin : gen_m11s15_nonexistent
     assign mst11_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst11_hs15_hready  = 1'b0;
     assign mst11_hs15_hresp   = 2'h0;
     assign mst11_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst11_slv15_size   = 4'h0;
     assign mst11_slv15_grant  = 1'b0;
     assign hm11_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst11_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst11_slv15_hburst = 3'h0;
     assign mst11_slv15_hprot  = 4'h0;
     assign mst11_slv15_hsize  = 3'h0;
     assign mst11_slv15_htrans = 2'h0;
     assign mst11_slv15_hwrite = 1'b0;
     assign mst11_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST12
generate if (`ATCBMC200_M12S15) begin : gen_m12s15
  assign mst12_hs15_hrdata  = hs15_hrdata;
  assign mst12_hs15_hready  = hs15_hready;
  assign mst12_hs15_hresp   = hs15_hresp;
  assign mst12_slv15_base   = slv15_base;
  assign mst12_slv15_size   = slv15_size;
  assign mst12_slv15_grant  = mst12_slv15_ack;
  assign hm12_slv15_hwdata  = hm12_hwdata;
  assign mst12_slv15_haddr  = mst12_haddr;
  assign mst12_slv15_hburst = mst12_hburst;
  assign mst12_slv15_hprot  = mst12_hprot;
  assign mst12_slv15_hsize  = mst12_hsize;
  assign mst12_slv15_htrans = mst12_htrans;
  assign mst12_slv15_hwrite = mst12_hwrite;
  assign mst12_slv15_req    = mst12_slv15_sel;
end
else begin : gen_m12s15_nonexistent
     assign mst12_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst12_hs15_hready  = 1'b0;
     assign mst12_hs15_hresp   = 2'h0;
     assign mst12_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst12_slv15_size   = 4'h0;
     assign mst12_slv15_grant  = 1'b0;
     assign hm12_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst12_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst12_slv15_hburst = 3'h0;
     assign mst12_slv15_hprot  = 4'h0;
     assign mst12_slv15_hsize  = 3'h0;
     assign mst12_slv15_htrans = 2'h0;
     assign mst12_slv15_hwrite = 1'b0;
     assign mst12_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST13
generate if (`ATCBMC200_M13S15) begin : gen_m13s15
  assign mst13_hs15_hrdata  = hs15_hrdata;
  assign mst13_hs15_hready  = hs15_hready;
  assign mst13_hs15_hresp   = hs15_hresp;
  assign mst13_slv15_base   = slv15_base;
  assign mst13_slv15_size   = slv15_size;
  assign mst13_slv15_grant  = mst13_slv15_ack;
  assign hm13_slv15_hwdata  = hm13_hwdata;
  assign mst13_slv15_haddr  = mst13_haddr;
  assign mst13_slv15_hburst = mst13_hburst;
  assign mst13_slv15_hprot  = mst13_hprot;
  assign mst13_slv15_hsize  = mst13_hsize;
  assign mst13_slv15_htrans = mst13_htrans;
  assign mst13_slv15_hwrite = mst13_hwrite;
  assign mst13_slv15_req    = mst13_slv15_sel;
end
else begin : gen_m13s15_nonexistent
     assign mst13_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst13_hs15_hready  = 1'b0;
     assign mst13_hs15_hresp   = 2'h0;
     assign mst13_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst13_slv15_size   = 4'h0;
     assign mst13_slv15_grant  = 1'b0;
     assign hm13_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst13_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst13_slv15_hburst = 3'h0;
     assign mst13_slv15_hprot  = 4'h0;
     assign mst13_slv15_hsize  = 3'h0;
     assign mst13_slv15_htrans = 2'h0;
     assign mst13_slv15_hwrite = 1'b0;
     assign mst13_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST14
generate if (`ATCBMC200_M14S15) begin : gen_m14s15
  assign mst14_hs15_hrdata  = hs15_hrdata;
  assign mst14_hs15_hready  = hs15_hready;
  assign mst14_hs15_hresp   = hs15_hresp;
  assign mst14_slv15_base   = slv15_base;
  assign mst14_slv15_size   = slv15_size;
  assign mst14_slv15_grant  = mst14_slv15_ack;
  assign hm14_slv15_hwdata  = hm14_hwdata;
  assign mst14_slv15_haddr  = mst14_haddr;
  assign mst14_slv15_hburst = mst14_hburst;
  assign mst14_slv15_hprot  = mst14_hprot;
  assign mst14_slv15_hsize  = mst14_hsize;
  assign mst14_slv15_htrans = mst14_htrans;
  assign mst14_slv15_hwrite = mst14_hwrite;
  assign mst14_slv15_req    = mst14_slv15_sel;
end
else begin : gen_m14s15_nonexistent
     assign mst14_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst14_hs15_hready  = 1'b0;
     assign mst14_hs15_hresp   = 2'h0;
     assign mst14_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst14_slv15_size   = 4'h0;
     assign mst14_slv15_grant  = 1'b0;
     assign hm14_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst14_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst14_slv15_hburst = 3'h0;
     assign mst14_slv15_hprot  = 4'h0;
     assign mst14_slv15_hsize  = 3'h0;
     assign mst14_slv15_htrans = 2'h0;
     assign mst14_slv15_hwrite = 1'b0;
     assign mst14_slv15_req    = 1'b0;
end
endgenerate
  `endif
  `ifdef ATCBMC200_AHB_MST15
generate if (`ATCBMC200_M15S15) begin : gen_m15s15
  assign mst15_hs15_hrdata  = hs15_hrdata;
  assign mst15_hs15_hready  = hs15_hready;
  assign mst15_hs15_hresp   = hs15_hresp;
  assign mst15_slv15_base   = slv15_base;
  assign mst15_slv15_size   = slv15_size;
  assign mst15_slv15_grant  = mst15_slv15_ack;
  assign hm15_slv15_hwdata  = hm15_hwdata;
  assign mst15_slv15_haddr  = mst15_haddr;
  assign mst15_slv15_hburst = mst15_hburst;
  assign mst15_slv15_hprot  = mst15_hprot;
  assign mst15_slv15_hsize  = mst15_hsize;
  assign mst15_slv15_htrans = mst15_htrans;
  assign mst15_slv15_hwrite = mst15_hwrite;
  assign mst15_slv15_req    = mst15_slv15_sel;
end
else begin : gen_m15s15_nonexistent
     assign mst15_hs15_hrdata  = {DATA_WIDTH{1'b0}};
     assign mst15_hs15_hready  = 1'b0;
     assign mst15_hs15_hresp   = 2'h0;
     assign mst15_slv15_base   = {(ADDR_WIDTH-BASE_ADDR_LSB){1'b0}};
     assign mst15_slv15_size   = 4'h0;
     assign mst15_slv15_grant  = 1'b0;
     assign hm15_slv15_hwdata  = {DATA_WIDTH{1'b0}};
     assign mst15_slv15_haddr  = {ADDR_WIDTH{1'b0}};
     assign mst15_slv15_hburst = 3'h0;
     assign mst15_slv15_hprot  = 4'h0;
     assign mst15_slv15_hsize  = 3'h0;
     assign mst15_slv15_htrans = 2'h0;
     assign mst15_slv15_hwrite = 1'b0;
     assign mst15_slv15_req    = 1'b0;
end
endgenerate
  `endif
`endif

endmodule
