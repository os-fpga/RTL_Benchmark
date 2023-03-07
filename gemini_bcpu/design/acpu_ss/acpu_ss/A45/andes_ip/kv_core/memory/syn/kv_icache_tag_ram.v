// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_icache_tag_ram (
    clk,
    dti_1pr_rwm,
    icache_tag_cs,
    icache_tag_addr,
    icache_tag_rdata,
    icache_tag_wdata,
    icache_tag_we,
    icache_tag_ctrl_in,
    icache_tag_ctrl_out);

    parameter ICACHE_TAG_RAM_DW= 19;
    parameter ICACHE_TAG_RAM_AW= 9;
    parameter ICACHE_TAG_RAM_CTRL_IN_WIDTH= 1;
    parameter ICACHE_TAG_RAM_CTRL_OUT_WIDTH= 1;
    input clk;
    input [2:0] dti_1pr_rwm;
    input icache_tag_cs;
    input [(ICACHE_TAG_RAM_AW-1):0] icache_tag_addr ;
    output [(ICACHE_TAG_RAM_DW-1):0] icache_tag_rdata ;
    input [(ICACHE_TAG_RAM_DW-1):0] icache_tag_wdata ;
    input icache_tag_we;
    input [(ICACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] icache_tag_ctrl_in ;
    output [(ICACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] icache_tag_ctrl_out ;


wire [(ICACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] nds_unused_icache_tag_ctrl_in = icache_tag_ctrl_in;
assign icache_tag_ctrl_out = {((ICACHE_TAG_RAM_CTRL_OUT_WIDTH-1)+1){1'b0}};

wire  dti_ce_n  ;
wire  dti_gwe_n ;

assign dti_ce_n   = ~icache_tag_cs; 
assign dti_gwe_n  = ~icache_tag_we;

dti_1pr_tm16ffcll_128x23_4ww2x_m_shc kv_icache_tag_ram_u (
    .DO     ( icache_tag_rdata  ), 
    .A      ( icache_tag_addr   ), 
    .DI     ( icache_tag_wdata  ), 
    .CE_N   ( dti_ce_n          ), 
    .GWE_N  ( dti_gwe_n         ), 
    .T_RWM  ( dti_1pr_rwm       ),      // TO BE REVIEWED AND ADJUSTED !!!!!
    .CLK    ( clk               )
);

endmodule 