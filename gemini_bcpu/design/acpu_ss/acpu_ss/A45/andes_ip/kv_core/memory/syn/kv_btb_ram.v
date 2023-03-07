// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_btb_ram (
    clk,
    dti_1pr_rwm,
    btb_addr,
    btb_cs,
    btb_we,
    btb_wdata,
    btb_rdata,
    btb_ctrl_in,
    btb_ctrl_out);

    parameter BTB_RAM_ADDR_WIDTH= 7;
    parameter BTB_RAM_DATA_WIDTH= 38;
    parameter BTB_RAM_CTRL_IN_WIDTH= 1;
    parameter BTB_RAM_CTRL_OUT_WIDTH= 1;
    input clk;
    input [2:0] dti_1pr_rwm;
    input [(BTB_RAM_ADDR_WIDTH-1):0] btb_addr ;
    input btb_cs;
    input btb_we;
    input [(BTB_RAM_DATA_WIDTH-1):0] btb_wdata ;
    output [(BTB_RAM_DATA_WIDTH-1):0] btb_rdata ;
    input [(BTB_RAM_CTRL_IN_WIDTH-1):0] btb_ctrl_in ;
    output [(BTB_RAM_CTRL_OUT_WIDTH-1):0] btb_ctrl_out ;

wire [(BTB_RAM_CTRL_IN_WIDTH-1):0] nds_unused_btb_ctrl_in = btb_ctrl_in;
assign btb_ctrl_out = {((BTB_RAM_CTRL_OUT_WIDTH-1)+1){1'b0}};

wire  dti_ce_n  ;
wire  dti_gwe_n ;

assign dti_ce_n   = ~btb_cs; 
assign dti_gwe_n  = ~btb_we;

dti_1pr_tm16ffcll_128x56_4ww2x_m_shc kv_btb_ram_u (
    .DO     ( btb_rdata  ), 
    .A      ( btb_addr   ), 
    .DI     ( btb_wdata  ), 
    .CE_N   ( dti_ce_n   ), 
    .GWE_N  ( dti_gwe_n  ), 
    .T_RWM  ( dti_1pr_rwm),     // TO BE REVIEWED AND ADJUSTED !!!!!
    .CLK    ( clk        )
);

endmodule 