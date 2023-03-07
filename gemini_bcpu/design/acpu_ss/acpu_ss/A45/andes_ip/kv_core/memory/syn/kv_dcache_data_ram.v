// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_dcache_data_ram (
    clk,
    dti_sp_rwm,
    dti_sp_dly,
    dcache_data_rdata,
    dcache_data_wdata,
    dcache_data_cs,
    dcache_data_we,
    dcache_data_byte_we,
    dcache_data_addr,
    dcache_data_ctrl_in,
    dcache_data_ctrl_out);

    parameter DCACHE_DATA_RAM_DW= 64;
    parameter DCACHE_DATA_RAM_AW= 11;
    parameter DCACHE_DATA_RAM_BWEW= 8;
    parameter DCACHE_DATA_RAM_CTRL_IN_WIDTH= 1;
    parameter DCACHE_DATA_RAM_CTRL_OUT_WIDTH= 1;
    localparam OUT_DELAY= 0.1;
    input clk;
    input [2:0] dti_sp_rwm;
    input [2:0] dti_sp_dly;
    output [(DCACHE_DATA_RAM_DW-1):0] dcache_data_rdata ;
    input [(DCACHE_DATA_RAM_DW-1):0] dcache_data_wdata ;
    input dcache_data_cs;
    input dcache_data_we;
    input [(DCACHE_DATA_RAM_BWEW-1):0] dcache_data_byte_we ;
    input [(DCACHE_DATA_RAM_AW-1):0] dcache_data_addr ;
    input [(DCACHE_DATA_RAM_CTRL_IN_WIDTH-1):0] dcache_data_ctrl_in ;
    output [(DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] dcache_data_ctrl_out ;

wire [(DCACHE_DATA_RAM_CTRL_IN_WIDTH-1):0] nds_unused_dcache_data_ctrl_in = dcache_data_ctrl_in;
assign dcache_data_ctrl_out = {((DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1)+1){1'b0}};

wire                        dti_ce_n   ;
wire                        dti_gwe_n  ;
wire [DCACHE_DATA_RAM_BWEW - 1 : 0] dti_bywe_n ;

assign dti_ce_n   = ~dcache_data_cs; 
assign dti_gwe_n  = ~dcache_data_we;
assign dti_bywe_n = ~dcache_data_byte_we;

dti_sp_tm16ffcll_2048x32_4byw2x_m_shd kv_dcache_data_ram_u (
    .DO     ( dcache_data_rdata ), 
    .A      ( dcache_data_addr  ), 
    .DI     ( dcache_data_wdata ), 
    .CE_N   ( dti_ce_n          ), 
    .GWE_N  ( dti_gwe_n         ), 
    .BYWE_N ( dti_bywe_n        ), 
    .T_RWM  ( dti_sp_rwm        ),      // TO BE REVIEWED AND ADJUSTED !!!!!
    .T_DLY  ( dti_sp_dly        ),      // TO BE REVIEWED AND ADJUSTED !!!!!
    .CLK    ( clk               )
);

endmodule 