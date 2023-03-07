// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_ilm_ram (
    clk,
    dti_sp_rwm,
    dti_sp_dly,
    ilm_cs,
    ilm_we,
    ilm_addr,
    ilm_byte_we,
    ilm_wdata,
    ilm_rdata,
    ilm_ctrl_in,
    ilm_ctrl_out);

    parameter ILM_RAM_AW= 11;
    parameter ILM_RAM_DW= 64;
    parameter ILM_RAM_BWEW= 8;
    parameter ILM_RAM_CTRL_IN_WIDTH= 1;
    parameter ILM_RAM_CTRL_OUT_WIDTH= 1;
    input clk;
    input [2:0] dti_sp_rwm;
    input [2:0] dti_sp_dly;
    input ilm_cs;
    input ilm_we;
    input [(ILM_RAM_AW-1):0] ilm_addr ;
    input [(ILM_RAM_BWEW-1):0] ilm_byte_we ;
    input [(ILM_RAM_DW-1):0] ilm_wdata ;
    output [(ILM_RAM_DW-1):0] ilm_rdata ;
    input [(ILM_RAM_CTRL_IN_WIDTH-1):0] ilm_ctrl_in ;
    output [(ILM_RAM_CTRL_OUT_WIDTH-1):0] ilm_ctrl_out ;


wire [(ILM_RAM_CTRL_IN_WIDTH-1):0] nds_unused_ilm_ctrl_in = ilm_ctrl_in;
assign ilm_ctrl_out = {((ILM_RAM_CTRL_OUT_WIDTH-1)+1){1'b0}};

wire                        dti_ce_n   ;
wire                        dti_gwe_n  ;
wire [ILM_RAM_BWEW - 1 : 0] dti_bywe_n ;

assign dti_ce_n   = ~ilm_cs;
assign dti_gwe_n  = ~ilm_we;
assign dti_bywe_n = ~ilm_byte_we;

dti_sp_tm16ffcll_8192x32_16byw2x_m_shd kv_ilm_ram_u (
    .DO     ( ilm_rdata  ), 
    .A      ( ilm_addr   ), 
    .DI     ( ilm_wdata  ), 
    .CE_N   ( dti_ce_n   ), 
    .GWE_N  ( dti_gwe_n  ), 
    .BYWE_N ( dti_bywe_n ), 
    .T_RWM  ( dti_sp_rwm ),     // TO BE REVIEWED AND ADJUSTED !!!!!
    .T_DLY  ( dti_sp_dly ),     // TO BE REVIEWED AND ADJUSTED !!!!!
    .CLK    ( clk        )
);



endmodule 