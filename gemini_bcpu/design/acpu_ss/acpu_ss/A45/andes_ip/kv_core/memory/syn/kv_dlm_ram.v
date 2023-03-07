// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_dlm_ram (
    clk,
    dti_sp_rwm,
    dti_sp_dly,
    dlm_cs,
    dlm_we,
    dlm_byte_we,
    dlm_addr,
    dlm_wdata,
    dlm_rdata,
    dlm_ctrl_in,
    dlm_ctrl_out);

    parameter DLM_RAM_AW= 11;
    parameter DLM_RAM_DW= 64;
    parameter DLM_RAM_BWEW= 8;
    parameter DLM_RAM_CTRL_IN_WIDTH= 1;
    parameter DLM_RAM_CTRL_OUT_WIDTH= 1;
    localparam OUT_DELAY= 0.1;
    input clk;
    input [2:0] dti_sp_rwm;
    input [2:0] dti_sp_dly;
    input dlm_cs;
    input dlm_we;
    input [(DLM_RAM_BWEW-1):0] dlm_byte_we ;
    input [(DLM_RAM_AW-1):0] dlm_addr ;
    input [(DLM_RAM_DW-1):0] dlm_wdata ;
    output [(DLM_RAM_DW-1):0] dlm_rdata ;
    input [(DLM_RAM_CTRL_IN_WIDTH-1):0] dlm_ctrl_in ;
    output [(DLM_RAM_CTRL_OUT_WIDTH-1):0] dlm_ctrl_out ;

wire [(DLM_RAM_CTRL_IN_WIDTH-1):0] nds_unused_dlm_ctrl_in = dlm_ctrl_in;
assign dlm_ctrl_out = {((DLM_RAM_CTRL_OUT_WIDTH-1)+1){1'b0}};


wire                    dti_gwe_n  ;
wire [DLM_RAM_BWEW-1:0] dti_bywe_n ;
wire                    ram_mux    ;
wire [  DLM_RAM_DW-1:0] dlm_rdata_l;
wire [  DLM_RAM_DW-1:0] dlm_rdata_h;
wire [            12:0] dlm_addr_l ;
wire [            12:0] dlm_addr_h ;
wire                    dti_ce_l_n ;
wire                    dti_ce_h_n ;

assign dti_ce_l_n = ~(dlm_cs && ~ram_mux); 
assign dti_ce_h_n = ~(dlm_cs &&  ram_mux); 
assign dti_gwe_n  = ~dlm_we;
assign dti_bywe_n = ~dlm_byte_we;

assign ram_mux = (dlm_addr > 'd8191);

assign dlm_rdata  = (ram_mux)? dlm_rdata_h : dlm_rdata_l;

assign dlm_addr_l = dlm_addr[12:0];
assign dlm_addr_h = dlm_addr - 'd8191;

dti_sp_tm16ffcll_8192x32_16byw2x_m_shd kv_dlm_ram_l_u (
    .DO     ( dlm_rdata_l), 
    .A      ( dlm_addr_l ), 
    .DI     ( dlm_wdata  ), 
    .CE_N   ( dti_ce_l_n ), 
    .GWE_N  ( dti_gwe_n  ), 
    .BYWE_N ( dti_bywe_n ), 
    .T_RWM  ( dti_sp_rwm ),     // TO BE REVIEWED AND ADJUSTED !!!!!
    .T_DLY  ( dti_sp_dly ),     // TO BE REVIEWED AND ADJUSTED !!!!!
    .CLK    ( clk        )
);

dti_sp_tm16ffcll_8192x32_16byw2x_m_shd kv_dlm_ram_h_u (
    .DO     ( dlm_rdata_h), 
    .A      ( dlm_addr_h ), 
    .DI     ( dlm_wdata  ), 
    .CE_N   ( dti_ce_h_n ), 
    .GWE_N  ( dti_gwe_n  ), 
    .BYWE_N ( dti_bywe_n ), 
    .T_RWM  ( dti_sp_rwm ),     // TO BE REVIEWED AND ADJUSTED !!!!!
    .T_DLY  ( dti_sp_dly ),     // TO BE REVIEWED AND ADJUSTED !!!!!
    .CLK    ( clk        )
);


endmodule 