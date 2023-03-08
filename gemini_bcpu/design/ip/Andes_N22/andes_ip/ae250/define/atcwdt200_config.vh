
`ifdef ATCWDT200_CONFIG_VH
`else // ATCWDT200_CONFIG_VH
`define ATCWDT200_CONFIG_VH

//-------------------------------------------------------
// Magic Number of Write Protection (16-bit width)
//-------------------------------------------------------
`define ATCWDT200_WP_NUM	16'h5aa5

//-------------------------------------------------------
// Magic Number of Restart Watchdog Timer (16-bit width)
//-------------------------------------------------------
`define ATCWDT200_RESTART_NUM	16'hcafe

`endif // ATCWDT200_CONFIG_VH

