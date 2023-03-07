// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_dcache_tag_ram (
    clk,
    dti_1pr_rwm,
    dcache_tag_cs,
    dcache_tag_we,
    dcache_tag_addr,
    dcache_tag_wdata,
    dcache_tag_rdata,
    dcache_tag_ctrl_in,
    dcache_tag_ctrl_out);

    parameter DCACHE_TAG_RAM_DW= 19;
    parameter DCACHE_TAG_RAM_AW= 9;
    parameter DCACHE_TAG_RAM_CTRL_IN_WIDTH= 1;
    parameter DCACHE_TAG_RAM_CTRL_OUT_WIDTH= 1;
    localparam OUT_DELAY= 0.1;
    input clk;
    input [2:0] dti_1pr_rwm;
    input dcache_tag_cs;
    input dcache_tag_we;
    input [(DCACHE_TAG_RAM_AW-1):0] dcache_tag_addr ;
    input [(DCACHE_TAG_RAM_DW-1):0] dcache_tag_wdata ;
    output [(DCACHE_TAG_RAM_DW-1):0] dcache_tag_rdata ;
    input [(DCACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] dcache_tag_ctrl_in ;
    output [(DCACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] dcache_tag_ctrl_out ;

wire [(DCACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] nds_unused_dcache_tag_ctrl_in = dcache_tag_ctrl_in;
assign dcache_tag_ctrl_out = {((DCACHE_TAG_RAM_CTRL_OUT_WIDTH-1)+1){1'b0}};

wire  dti_ce_n  ;
wire  dti_gwe_n ;

assign dti_ce_n   = ~dcache_tag_cs; 
assign dti_gwe_n  = ~dcache_tag_we;

dti_1pr_tm16ffcll_128x23_4ww2x_m_shc kv_dcache_tag_ram_u (
    .DO     ( dcache_tag_rdata  ), 
    .A      ( dcache_tag_addr   ), 
    .DI     ( dcache_tag_wdata  ), 
    .CE_N   ( dti_ce_n          ), 
    .GWE_N  ( dti_gwe_n         ), 
    .T_RWM  ( dti_1pr_rwm       ),      // TO BE REVIEWED AND ADJUSTED !!!!!
    .CLK    ( clk               )
);

endmodule
