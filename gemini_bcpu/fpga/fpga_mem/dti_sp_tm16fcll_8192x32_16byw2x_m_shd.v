module dti_sp_tm16fcll_8192x32_16byw2x_m_shd (VDD, VSS, DO, A, DI, CE_N, GWE_N, BYWE_N, T_RWM, 
       T_DLY, CLK);
input         VDD  ; // NOT USED IN FPGA
input         VSS  ; // NOT USED IN FPGA
output [31:0] DO   ; // Data Output
input  [ 12:0] A   ; // Address
input  [31:0] DI   ; // Data Input
input         CE_N ; // Chip Select Enable --- Active Low
input         GWE_N;
input [3:0] BYWE_N ; // Global Write Enable --- Active Low
input  [ 2:0] T_RWM; // // NOT USED IN FPGA
input  [ 2:0] T_DLY; // NOT USED IN FPGA
input         CLK  ; // Clock


//bytewrite_sp_ram_wf   #(.NUM_COL(4), .COL_WIDTH(8), .ADDR_WIDTH(13), .DATA_WIDTH(32)) dti_sp_tm16fcll_8192x32_16byw2x_m_shd_fpga (
//  .clk(CLK),    // input wire clka
//  .ena(~CE_N),      // input wire ena
//  .we( {4{~GWE_N}} & ~BYWE_N),      // input wire [3 : 0] wea
//  .addr(A),  // input wire [12 : 0] addra
//  .din(DI),    // input wire [31 : 0] dina
//  .dout(DO)  // output wire [31 : 0] douta
//
//);


bytewrite_sp_ram_wf_new   #(.NB_COL(4), .COL_WIDTH(8), .RAM_DEPTH(8192), .ADDR_WIDTH(13)) dti_sp_tm16fcll_8192x32_16byw2x_m_shd_fpga (
  .clka(CLK),    // input wire clka
  .ena(~CE_N),      // input wire ena
  .wea( {4{~GWE_N}} & ~BYWE_N),      // input wire [3 : 0] wea
  .addra(A),  // input wire [12 : 0] addra
  .dina(DI),    // input wire [31 : 0] dina
  .douta(DO)  // output wire [31 : 0] douta

);


endmodule 
