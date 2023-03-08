/********************************************************************/
/*  Copyright 1998 - 2022 Dolphin Technology, Inc.                  */
/*  This memory compiler and any data created by it are proprietary */
/*  and confidential information of Dolphin Technology, Inc. and    */
/*  can only be used or viewed with written permission from         */
/*  Dolphin Technology, Inc.                                        */
/*  tsmc16nmffcll, version 1p1p52 Rev_2.6                           */
/********************************************************************/

module dti_sp_tm16fcll_16384x32_32byw2x_m_shd (VDD, VSS, DO, A, DI, CE_N, GWE_N, BYWE_N, T_RWM, 
       T_DLY, CLK);
input  VDD;
input  VSS;
output [31:0] DO;               // Data Output
input  [13:0] A;                // Address
input  [31:0] DI;               // Data Input
input  CE_N;                    // Chip Select Enable --- Active Low
input  GWE_N;                   // Global Write Enable --- Active Low
input  [3:0] BYWE_N;            // Byte Write Enable --- Active Low
input  [2:0] T_RWM;             // Adjustment for Sense Amp delay
input  [2:0] T_DLY;
input  CLK;                     // Clock

wire CLK_INT;                     // Chip Select Enable --- Active Low
wire CE_N_INT;                    // Chip Select Enable --- Active Low
wire GWE_N_INT;                   // Global Write Enable --- Active Low
wire [13:0] A_INT;                // Address
wire [31:0] DI_INT;               // Data Input
wire [31:0] BWE_N_INT;            // Bit Write Enable --- Active Low
wire [3:0] BYWE_N_INT;           // Byte Write Enable --- Active Low
wire OE_N_INT;                    // Bist Output Enable --- Active Low
wire T_AWT_N_INT;                 // Asynchronous Test Write Through --- Active Low
wire [2:0] T_RWM_INT;             // Adjustment for Sense Amp delay
wire [2:0] T_DLY_INT;             // Adjustment for Write Assist delay
wire [1:0] DS_INT;                // Adjustment for Memory Supply Voltage when deep sleep mode
wire LOLEAK_N_INT;                // Low Leak Enable for Logic --- Active Low
wire LKRB_N_INT;                  // Low Leak Enable for Memory Array --- Active Low
wire COREPWS_N_INT;               // Power Down Enable for Memory Array --- Active Low
wire P_PWS_N_INT;                 // Power Down Enable for Logic --- Active Low
wire T_BE_N_INT;                  // Bist Enable --- Active Low
wire T_CE_N_INT;                  // Bist Chip Select Enable --- Active Low
wire T_GWE_N_INT;                 // Bist Global Write Enable --- Active Low
wire [13:0] T_A_INT;              // Bist Address
wire [31:0] T_DI_INT;             // Bist Data Input
wire [31:0] T_BWE_N_INT;          // Bist Bit Write Enable --- Active Low
wire T_OE_N_INT;                  // Output Enable --- Active Low
reg   CE_N_R;                   // Chip Enable internal register
reg   Ce_R;                     // Chip Enable register
reg  GWe_R;                    // Read|Write wire 
reg   [14:0] Address_R_temp;    // Address register 
reg   [14:0] Address_R;         // Address wire 
reg   [31:0] DataIn_R;          // Latch DI
reg   [31:0] tmpDataIn_R;       // DataIn change
reg   [31:0] We_R;              // Latch BI
reg   [31:0] memArray [16383:0];
reg  [31:0] Dout;
reg  [31:0] Dout_R;
wire [31:0] Dout_R_INT;
wire [31:0] DO_temp;
wire  cntrl;
wire condition_pwr0;            // Light sleep
wire condition_pwr1;            // Deep sleep
wire condition_pwr2;            // PG retention
wire condition_pwr3;            // Shutdown

integer  i;
integer  j;
integer  m;
integer  ok;
reg   active_pulse;

initial 
begin 
  // Initializing Memory Array to x 
  for (m=0; m<16384; m=m+1) begin 
    memArray[m] = 32'bx; 
  end 
  ok = 1;
end 

endmodule


