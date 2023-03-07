// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_icache_data_ram (
    clk,
    dti_1pr_rwm,
    icache_data_rdata,
    icache_data_wdata,
    icache_data_cs,
    icache_data_we,
    icache_data_addr,
    icache_data_ctrl_in,
    icache_data_ctrl_out);

    parameter ICACHE_DATA_RAM_DW= 64;
    parameter ICACHE_DATA_RAM_AW= 11;
    parameter ICACHE_DATA_RAM_CTRL_IN_WIDTH= 1;
    parameter ICACHE_DATA_RAM_CTRL_OUT_WIDTH= 1;
    input clk;
    input [2:0] dti_1pr_rwm;
    output [(ICACHE_DATA_RAM_DW-1):0] icache_data_rdata ;
    input [(ICACHE_DATA_RAM_DW-1):0] icache_data_wdata ;
    input icache_data_cs;
    input icache_data_we;
    input [(ICACHE_DATA_RAM_AW-1):0] icache_data_addr ;
    input [(ICACHE_DATA_RAM_CTRL_IN_WIDTH-1):0] icache_data_ctrl_in ;
    output [(ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] icache_data_ctrl_out ;

wire [(ICACHE_DATA_RAM_CTRL_IN_WIDTH-1):0] nds_unused_icache_data_ctrl_in = icache_data_ctrl_in;
assign icache_data_ctrl_out = {((ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1)+1){1'b0}};

wire  dti_ce_n  ;
wire  dti_gwe_n ;

assign dti_ce_n   = ~icache_data_cs; 
assign dti_gwe_n  = ~icache_data_we;

dti_1pr_tm16ffcll_1024x32_4ww2x_m_shc kv_icache_data_ram_u (
    .DO     ( icache_data_rdata ), 
    .A      ( icache_data_addr  ), 
    .DI     ( icache_data_wdata ), 
    .CE_N   ( dti_ce_n          ), 
    .GWE_N  ( dti_gwe_n         ), 
    .T_RWM  ( dti_1pr_rwm       ),      // TO BE REVIEWED AND ADJUSTED !!!!!
    .CLK    ( clk               )
);

endmodule 