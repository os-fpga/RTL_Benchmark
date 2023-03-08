/*********************************************************************************/
/*    Copyright 1998 - 2022 Dolphin Technology, Inc.                             */
/*    This memory compiler and any data created by it are proprietary and        */
/*    confidential information of Dolphin Technology, Inc. and can only          */
/*    be used or viewed with written permission from Dolphin Technology, Inc.    */
/*    TSMC 16nmll, Version 1p3p32                                                */
/*********************************************************************************/

/*The default setting corresponds to T_RM == "011".*/

`timescale 1ns/1ps

module dti_rom_tm16ffcll_16384x32_t321xoe_m_a (
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

input  [13:0] A;        // Address
input  [13:0] T_A;       // Bist Address
input  T_BE_N;            // Bist Enable --- Active Low
input  CLK;            // Clock
input  CE_N;            // Chip Select Enable  --- Active Low
input  T_CE_N;            // Bist Chip Select Enable  --- Active Low
input  OE_N;             // Output Enable --- Active Low
input  T_OE_N;            // Bist Output Enable --- Active Low
input  [2:0] T_RM;            // Adjustment for Sense Amp delay

sp_rom dti_rom_tm16ffcll_16384x32_t321xoe_m_a_fpga_inst (
  .clk(CLK),    // input wire clka
  .en(~CE_N),      // input wire ena
  .addr(A),  // input wire [11 : 0] addra
  .dout(DO)  // output wire [31 : 0] douta
);
endmodule

