// Copyright (C) 2019, Andes Technology Corp. Confidential Proprietary

module n22_ilm_ram(
		  core_clk,
		  ilm_cs,
		  ilm_addr,
		  ilm_byte_we,
		  ilm_wdata,
		  ilm_rdata
);
parameter ILM_RAM_AW   = 11;
parameter ILM_RAM_DW   = 64;
parameter ILM_RAM_BWEW = 8;
parameter ILM_ECC_TYPE = "none";

input                       core_clk;
input                       ilm_cs;
input      [ILM_RAM_AW-1:0] ilm_addr;
input    [ILM_RAM_BWEW-1:0] ilm_byte_we;
input      [ILM_RAM_DW-1:0] ilm_wdata;
output     [ILM_RAM_DW-1:0] ilm_rdata;

wire                        dti_vdd_w  ;
wire                        dti_vss_w  ;
wire                        dti_ce_n   ;
wire                        dti_gwe_n  ;
wire [ILM_RAM_BWEW - 1 : 0] dti_bywe_n ;

assign dti_ce_n   = ~ilm_cs; 
assign dti_gwe_n  = ~(|ilm_byte_we);
assign dti_bywe_n = ~ilm_byte_we;

dti_sp_tm16fcll_8192x32_16byw2x_m_shd n22_ilm_ram_u (
	.VDD   (dti_vdd_w ),
	.VSS   (dti_vss_w ),
	.DO    (ilm_rdata ),
	.A     (ilm_addr  ),
	.DI    (ilm_wdata ),
	.CE_N  (dti_ce_n  ),
	.GWE_N (dti_gwe_n ),
	.BYWE_N(dti_bywe_n),
	.T_RWM (3'b011    ), // TO BE REVIEWED AND ADJUSTED !!!!!
	.T_DLY (3'b000    ), // TO BE REVIEWED AND ADJUSTED !!!!!
	.CLK   (core_clk  )
);

endmodule

