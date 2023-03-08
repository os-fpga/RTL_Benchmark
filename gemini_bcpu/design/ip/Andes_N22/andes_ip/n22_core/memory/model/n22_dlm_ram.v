// Copyright (C) 2019, Andes Technology Corp. Confidential Proprietary

module n22_dlm_ram(
		  core_clk,
		  dlm_cs,
		  dlm_byte_we,
		  dlm_addr,
		  dlm_wdata,
		  dlm_rdata
);
parameter DLM_RAM_AW   = 11;
parameter DLM_RAM_DW   = 64;
parameter DLM_RAM_BWEW = 8;
parameter DLM_ECC_TYPE = "none";

input                       core_clk;
input                       dlm_cs;
input    [DLM_RAM_BWEW-1:0] dlm_byte_we;
input      [DLM_RAM_AW-1:0] dlm_addr;
input      [DLM_RAM_DW-1:0] dlm_wdata;
output     [DLM_RAM_DW-1:0] dlm_rdata;

wire                        dti_vdd_w  ;
wire                        dti_vss_w  ;
wire                        dti_ce_n   ;
wire                        dti_gwe_n  ;
wire [DLM_RAM_BWEW - 1 : 0] dti_bywe_n ;

assign dti_ce_n   = ~dlm_cs; 
assign dti_gwe_n  = ~(|dlm_byte_we);
assign dti_bywe_n = ~dlm_byte_we;

dti_sp_tm16fcll_8192x32_16byw2x_m_shd n22_dlm_ram_u (
	.VDD   (dti_vdd_w ),
	.VSS   (dti_vss_w ),
	.DO    (dlm_rdata ),
	.A     (dlm_addr  ),
	.DI    (dlm_wdata ),
	.CE_N  (dti_ce_n  ),
	.GWE_N (dti_gwe_n ),
	.BYWE_N(dti_bywe_n),
	.T_RWM (3'b011    ), // TO BE REVIEWED AND ADJUSTED !!!!!
	.T_DLY (3'b000    ), // TO BE REVIEWED AND ADJUSTED !!!!!
	.CLK   (core_clk  )
);


endmodule

