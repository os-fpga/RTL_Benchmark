module dti_rom_tm16ffcll_4096x32_t81xoe_m_a (
VDD, 
VSS, 
DO, 
A, 
T_A, 
T_BE_N, 
CE_N, 
T_CE_N, 
T_OE_N, 
OE_N, 
T_RM, 
CLK
);

input  VDD; 
input  VSS; 
output [31:0] DO;      // Data Output

input  [11:0] A;        // Address
input  [11:0] T_A;       // Bist Address
input  T_BE_N;            // Bist Enable --- Active Low
input  CLK;            // Clock
input  CE_N;            // Chip Select Enable  --- Active Low
input  T_CE_N;            // Bist Chip Select Enable  --- Active Low
input  OE_N;             // Output Enable --- Active Low
input  T_OE_N;            // Bist Output Enable --- Active Low
input  [2:0] T_RM;            // Adjustment for Sense Amp delay


dti_rom_tm16ffcll_4096x32_t81xoe_m_a_fpga dti_rom_tm16ffcll_4096x32_t81xoe_m_a_inst (
  .clka(CLK),    // input wire clka
  .ena(~CE_N),      // input wire ena
  .addra(A),  // input wire [11 : 0] addra
  .douta(DO)  // output wire [31 : 0] douta
);
endmodule
