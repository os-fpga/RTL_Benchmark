
`include "global.inc"

module n22_device_range_chk #(
 parameter N22_DLM_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_ILM_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_PPI_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_FIO_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION0_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION1_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION2_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION3_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION4_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION5_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION6_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION7_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_TMR_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_CLIC_BASE_ADDR       = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEBUG_BASE_ADDR      = {(`N22_ADDR_SIZE){1'b0}}
)(
  input  [`N22_ADDR_SIZE-1:0]   i_addr,
  output o_device
  );

    `ifdef N22_TMR_PRIVATE
  wire [`N22_ADDR_SIZE-1:0] s0 = N22_TMR_BASE_ADDR;
  wire s1 = (i_addr[`N22_TMR_BASE_REGION] ==  s0[`N22_TMR_BASE_REGION]);
    `endif

    `ifdef N22_HAS_CLIC
  wire [`N22_ADDR_SIZE-1:0] s2 = N22_CLIC_BASE_ADDR;
  wire s3 = (i_addr[`N22_CLIC_BASE_REGION] ==  s2[`N22_CLIC_BASE_REGION]);
    `endif

  `ifdef N22_HAS_FIO
  wire [`N22_ADDR_SIZE-1:0] s4 = N22_FIO_BASE_ADDR;
  wire s5 = (i_addr[`N22_FIO_BASE_REGION] ==  s4[`N22_FIO_BASE_REGION]);
  `endif

  `ifdef N22_HAS_PPI
  wire [`N22_ADDR_SIZE-1:0] s6 = N22_PPI_BASE_ADDR;
  wire s7 = (i_addr[`N22_PPI_BASE_REGION] ==  s6[`N22_PPI_BASE_REGION]);
  `endif

  `ifdef N22_HAS_DEVICE
  wire s8 = ((i_addr & `N22_DEVICE_REGION0_MASK) ==  (N22_DEVICE_REGION0_BASE));
  wire s9 = ((i_addr & `N22_DEVICE_REGION1_MASK) ==  (N22_DEVICE_REGION1_BASE));
  wire s10 = ((i_addr & `N22_DEVICE_REGION2_MASK) ==  (N22_DEVICE_REGION2_BASE));
  wire s11 = ((i_addr & `N22_DEVICE_REGION3_MASK) ==  (N22_DEVICE_REGION3_BASE));
  wire s12 = ((i_addr & `N22_DEVICE_REGION4_MASK) ==  (N22_DEVICE_REGION4_BASE));
  wire s13 = ((i_addr & `N22_DEVICE_REGION5_MASK) ==  (N22_DEVICE_REGION5_BASE));
  wire s14 = ((i_addr & `N22_DEVICE_REGION6_MASK) ==  (N22_DEVICE_REGION6_BASE));
  wire s15 = ((i_addr & `N22_DEVICE_REGION7_MASK) ==  (N22_DEVICE_REGION7_BASE));
  `endif

  assign o_device = ( 1'b0
                       `ifdef N22_TMR_PRIVATE
                          | s1
                       `endif
                       `ifdef N22_HAS_CLIC
                          | s3
                       `endif
                       `ifdef N22_HAS_PPI
                          | s7
                       `endif
                       `ifdef N22_HAS_FIO
                          | s5
                       `endif
                       `ifdef N22_HAS_DEVICE
                          | s8
                          | s9
                          | s10
                          | s11
                          | s12
                          | s13
                          | s14
                          | s15
                       `endif
                          );


endmodule
