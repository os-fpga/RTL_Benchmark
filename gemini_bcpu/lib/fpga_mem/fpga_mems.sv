//
// FPGA memories 
//

module dti_sp_tm16fcll_122x32_4ww2xoe_m_shd (VDD, VSS, DO, A, DI, CE_N, GWE_N, OE_N, T_RWM, T_DLY, CLK);

input         VDD  ; // NOT USED IN FPGA
input         VSS  ; // NOT USED IN FPGA
output [31:0] DO   ; // Data Output
input  [ 6:0] A    ; // Address
input  [31:0] DI   ; // Data Input
input         CE_N ; // Chip Select Enable --- Active Low
input         GWE_N; // Global Write Enable --- Active Low
input         OE_N ; // NOT USED IN FPGA
input  [ 2:0] T_RWM; // NOT USED IN FPGA
input  [ 2:0] T_DLY; // NOT USED IN FPGA
input         CLK  ; // Clock


fpga_sp_ram #(
    .A_WIDTH  (7  ),
    .D_WIDTH  (32 ),
    .RAM_DEPTH(122)
) fpga_sp_ram_u (
    .clk (CLK   ),
    .we  (~GWE_N),
    .en  (~CE_N ),
    .addr(A     ),
    .di  (DI    ),
    .dout(DO    )
);

endmodule // dti_sp_tm16fcll_122x32_4ww2xoe_m_shd


//========================================================
//========================================================

module dti_1pr_tm16fcll_128x56_4ww2x_m_shd (VDD, VSS, DO, A, DI, CE_N, GWE_N, T_RWM, T_DLY, CLK);

input         VDD  ; // NOT USED IN FPGA
input         VSS  ; // NOT USED IN FPGA
output [55:0] DO   ; // Data Output
input  [ 6:0] A    ; // Address
input  [55:0] DI   ; // Data Input
input         CE_N ; // Chip Select Enable --- Active Low
input         GWE_N; // Global Write Enable --- Active Low
input  [ 2:0] T_RWM; // // NOT USED IN FPGA
input  [ 2:0] T_DLY; // NOT USED IN FPGA
input         CLK  ; // Clock


fpga_sp_ram #(
    .A_WIDTH  (7  ),
    .D_WIDTH  (56 ),
    .RAM_DEPTH(128)
) fpga_sp_ram_u (
    .clk (CLK   ),
    .we  (~GWE_N),
    .en  (~CE_N ),
    .addr(A     ),
    .di  (DI    ),
    .dout(DO    )
);


endmodule // dti_1pr_tm16fcll_128x56_4ww2x_m_shd


//========================================================
//========================================================


module dti_dp_tm16fcll_512x32_4ww2xoe_m_hc (VDD, VSS, DO_A, DO_B, A_A, A_B, DI_A, DI_B, CE_N_A, CE_N_B, GWE_N_A, GWE_N_B, OE_N_A, OE_N_B, T_RWM_A, T_RWM_B, CLK_A, CLK_B);

input         VDD    ; // NOT USED IN FPGA
input         VSS    ; // NOT USED IN FPGA
output [31:0] DO_A   ; // NOT USED IN FPGA
output [31:0] DO_B   ; // Port B Data Output
input  [ 8:0] A_A    ; // Port A Address
input  [ 8:0] A_B    ; // Port B Address
input  [31:0] DI_A   ; // Port A Data Input
input  [31:0] DI_B   ; // NOT USED IN FPGA
input         CE_N_A ; // Port A Chip Select Enable --- Active Low
input         CE_N_B ; // Port B Chip Select Enable --- Active Low
input         GWE_N_A; // Port A Global Write Enable --- Active Low
input         GWE_N_B; // NOT USED IN FPGA
input         OE_N_A ; // NOT USED IN FPGA
input         OE_N_B ; // NOT USED IN FPGA
input  [ 2:0] T_RWM_A; // NOT USED IN FPGA
input  [ 2:0] T_RWM_B; // NOT USED IN FPGA
input         CLK_A  ; // Port A Clock
input         CLK_B  ; // Port B Clock



fpga_dp_ram #(
    .A_WIDTH  (9  ),
    .D_WIDTH  (32 ),
    .RAM_DEPTH(512)
) fpga_dp_ram_u (
    .clka (CLK_A   ),
    .clkb (CLK_B   ),
    .ena  (~CE_N_A ),
    .enb  (~CE_N_B ),
    .wea  (~GWE_N_A),
    .addra(A_A     ),
    .addrb(A_B     ),
    .dia  (DI_A    ),
    .dob  (DO_B    )
);


endmodule // dti_dp_tm16fcll_512x32_4ww2xoe_m_hc


//========================================================
//========================================================


module dti_sp_tm16fcll_576x32_4ww2xoe_m_shd (VDD, VSS, DO, A, DI, CE_N, GWE_N, OE_N, T_RWM, T_DLY, CLK);

input         VDD  ; // NOT USED IN FPGA
input         VSS  ; // NOT USED IN FPGA
output [31:0] DO   ; // Data Output
input  [ 9:0] A    ; // Address
input  [31:0] DI   ; // Data Input
input         CE_N ; // Chip Select Enable --- Active Low
input         GWE_N; // Global Write Enable --- Active Low
input         OE_N ; // NOT USED IN FPGA
input  [ 2:0] T_RWM; // NOT USED IN FPGA
input  [ 2:0] T_DLY; // NOT USED IN FPGA
input         CLK  ; // Clock

fpga_sp_ram #(
    .A_WIDTH  (10  ),
    .D_WIDTH  (32  ),
    .RAM_DEPTH(576 )
) fpga_sp_ram_u (
    .clk (CLK   ),
    .we  (~GWE_N),
    .en  (~CE_N ),
    .addr(A     ),
    .di  (DI    ),
    .dout(DO    )
);

endmodule // dti_sp_tm16fcll_576x32_4ww2xoe_m_shd


//========================================================
//========================================================

module dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd (VDD, VSS, DO, A, DI, CE_N, GWE_N, OE_N, T_RWM, T_DLY, CLK);

input         VDD  ; // NOT USED IN FPGA
input         VSS  ; // NOT USED IN FPGA
output [31:0] DO   ; // Data Output
input  [10:0] A    ; // Address
input  [31:0] DI   ; // Data Input
input         CE_N ; // Chip Select Enable --- Active Low
input         GWE_N; // Global Write Enable --- Active Low
input         OE_N ; // NOT USED IN FPGA
input  [ 2:0] T_RWM; // NOT USED IN FPGA
input  [ 2:0] T_DLY; // NOT USED IN FPGA
input         CLK  ; // Clock


fpga_sp_ram #(
    .A_WIDTH  (11  ),
    .D_WIDTH  (32  ),
    .RAM_DEPTH(1432)
) fpga_sp_ram_u (
    .clk (CLK   ),
    .we  (~GWE_N),
    .en  (~CE_N ),
    .addr(A     ),
    .di  (DI    ),
    .dout(DO    )
);

endmodule // dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd


//========================================================
//========================================================


module dti_sp_tm16fcll_8192x32_16byw2x_m_shd (VDD, VSS, DO, A, DI, CE_N, GWE_N, BYWE_N, T_RWM, T_DLY, CLK);

input         VDD   ; // NOT USED IN FPGA
input         VSS   ; // NOT USED IN FPGA
output [31:0] DO    ; // Data Output
input  [12:0] A     ; // Address
input  [31:0] DI    ; // Data Input
input         CE_N  ; // Chip Select Enable --- Active Low
input         GWE_N ; // Global Write Enable --- Active Low
input  [ 3:0] BYWE_N; // Byte Write Enable --- Active Low
input  [ 2:0] T_RWM ; // NOT USED IN FPGA
input  [ 2:0] T_DLY ; // NOT USED IN FPGA
input         CLK   ; // Clock

fpga_sp_ram #(
    .A_WIDTH  (13  ),
    .D_WIDTH  (32  ),
    .RAM_DEPTH(8192)
) fpga_sp_ram_u (
    .clk (CLK   ),
    .we  (~GWE_N),
    .en  (~CE_N ),
    .addr(A     ),
    .di  (DI    ),
    .dout(DO    )
);

endmodule // dti_sp_tm16fcll_8192x32_16byw2x_m_shd
