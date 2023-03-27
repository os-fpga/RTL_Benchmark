/********************************************************************/
/*  Copyright 1998 - 2022 Dolphin Technology, Inc.                  */
/*  This memory compiler and any data created by it are proprietary */
/*  and confidential information of Dolphin Technology, Inc. and    */
/*  can only be used or viewed with written permission from         */
/*  Dolphin Technology, Inc.                                        */
/*  tsmc16nmffcll, version 1p1p52 Rev_2.6                           */
/********************************************************************/

/*The default setting corresponds to T_RWM == "011".*/

`timescale 1ns/1ps

`undef  ISOLATION
`undef  CLKINV
`define BYTE_WRITE
`undef  BIST_TEST
`undef  ASYNCHRONOUS_WRITE
`undef  SYNCHRONOUS_WRITE
`undef  OUTPUT_ENABLE
`undef  LOW_LEAK1
`undef  LOW_LEAK2
`undef  PWR_GATE1
`undef  PWR_GATE2
`define WRITE_ASSIST
`undef  READ_ASSIST
`undef  COL_RED
`undef  ROW_RED

`define SDFVERSION_2
`undef  SDFVERSION_3
`undef BIT_WRITE
//`define SDFVERSION_3
//`undef  SDFVERSION_2
//****** Please choose the SDF Version to be used . Default is set to  SDFVERSION_2 (Version 2.0) which defines $setup and $hold seperately. Select SDFVERSION_3 for $setuphold ******

`celldefine

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

// Isolation block
`ifdef ISOLATION
  `ifdef CLKINV
    assign CLK_INT           = (ISOL_N===1'b0) ? 1'b0 : ( (ISOL_N===1'b1) ? ((condition_pwr2 || condition_pwr3) ? 0: ~CLK) : 'bx );
  `else
    assign CLK_INT           = (ISOL_N===1'b0) ? 1'b0 : ( (ISOL_N===1'b1) ? ((condition_pwr2 || condition_pwr3) ? 0:  CLK) : 'bx );
  `endif
  assign CE_N_INT          = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? CE_N         : 'bx );
  assign GWE_N_INT         = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? GWE_N        : 'bx );
  assign A_INT             = (ISOL_N===1'b0) ? {13{1'b0}}  : ( (ISOL_N===1'b1) ? A            : 'bx );
  assign DI_INT            = (ISOL_N===1'b0) ? {32{1'b0}}  : ( (ISOL_N===1'b1) ? DI           : 'bx );
  `ifdef BIT_WRITE
    assign BWE_N_INT       = (ISOL_N===1'b0) ? {32{1'b1}}  : ( (ISOL_N===1'b1) ? BWE_N        : 'bx );
  `else
    `ifdef BYTE_WRITE
      assign BWE_N_INT[0]  =  BYWE_N[0] ;
      assign BWE_N_INT[1]  =  BYWE_N[0] ;
      assign BWE_N_INT[2]  =  BYWE_N[0] ;
      assign BWE_N_INT[3]  =  BYWE_N[0] ;
      assign BWE_N_INT[4]  =  BYWE_N[0] ;
      assign BWE_N_INT[5]  =  BYWE_N[0] ;
      assign BWE_N_INT[6]  =  BYWE_N[0] ;
      assign BWE_N_INT[7]  =  BYWE_N[0] ;
      assign BWE_N_INT[8]  =  BYWE_N[1] ;
      assign BWE_N_INT[9]  =  BYWE_N[1] ;
      assign BWE_N_INT[10]  =  BYWE_N[1] ;
      assign BWE_N_INT[11]  =  BYWE_N[1] ;
      assign BWE_N_INT[12]  =  BYWE_N[1] ;
      assign BWE_N_INT[13]  =  BYWE_N[1] ;
      assign BWE_N_INT[14]  =  BYWE_N[1] ;
      assign BWE_N_INT[15]  =  BYWE_N[1] ;
      assign BWE_N_INT[16]  =  BYWE_N[2] ;
      assign BWE_N_INT[17]  =  BYWE_N[2] ;
      assign BWE_N_INT[18]  =  BYWE_N[2] ;
      assign BWE_N_INT[19]  =  BYWE_N[2] ;
      assign BWE_N_INT[20]  =  BYWE_N[2] ;
      assign BWE_N_INT[21]  =  BYWE_N[2] ;
      assign BWE_N_INT[22]  =  BYWE_N[2] ;
      assign BWE_N_INT[23]  =  BYWE_N[2] ;
      assign BWE_N_INT[24]  =  BYWE_N[3] ;
      assign BWE_N_INT[25]  =  BYWE_N[3] ;
      assign BWE_N_INT[26]  =  BYWE_N[3] ;
      assign BWE_N_INT[27]  =  BYWE_N[3] ;
      assign BWE_N_INT[28]  =  BYWE_N[3] ;
      assign BWE_N_INT[29]  =  BYWE_N[3] ;
      assign BWE_N_INT[30]  =  BYWE_N[3] ;
      assign BWE_N_INT[31]  =  BYWE_N[3] ;
    `else
      assign BWE_N_INT       = (ISOL_N===1'b0) ? {32{1'b1}}  : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    `endif
  `endif
  `ifdef OUTPUT_ENABLE
    assign OE_N_INT        = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? OE_N         : 'bx );
  `else
    assign OE_N_INT        = 1'b0;
  `endif
  `ifdef ASYNCHRONOUS_WRITE
    assign T_AWT_N_INT     = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? T_AWT_N      : 'bx );
  `else
    assign T_AWT_N_INT     = 1'b1;
  `endif
   assign T_RWM_INT       = (ISOL_N===1'b0) ? 3'b011      : ( (ISOL_N===1'b1) ? T_RWM        : 'bx );
  `ifdef WRITE_ASSIST
    assign T_DLY_INT       = (ISOL_N===1'b0) ? {3{1'b0}}   : ( (ISOL_N===1'b1) ? T_DLY        : 'bx );
  `else
    assign T_DLY_INT       = (ISOL_N===1'b0) ? {3{1'b0}}   : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
  `endif
  `ifdef READ_ASSIST
    assign RAE_N_INT       = (ISOL_N===1'b0) ? 1'b0   : ( (ISOL_N===1'b1) ? RAE_N        : 'bx );
  `else
    assign RAE_N_INT       = (ISOL_N===1'b0) ? 1'b0   : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
  `endif
  `ifdef LOW_LEAK1
    assign LOLEAK_N_INT    = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? LOLEAK_N     : 'bx );
    assign LKRB_N_INT      = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? LKRB_N       : 'bx );
    assign DS_INT[0]        = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? DS[0]       : 'bx );
    assign DS_INT[1]        = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? DS[1]       : 'bx );
  `else
    `ifdef LOW_LEAK2
      assign LOLEAK_N_INT    = (ISOL_N===1'b0) ? 1'b1      : ( (ISOL_N===1'b1) ? LOLEAK_N     : 'bx );
      assign LKRB_N_INT      = (ISOL_N===1'b0) ? 1'b1      : ( (ISOL_N===1'b1) ? 'b1          : 'bx );
      assign DS_INT[0]        = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? DS[0]       : 'bx );
      assign DS_INT[1]        = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? DS[1]       : 'bx );
    `else
      assign LOLEAK_N_INT    = (ISOL_N===1'b0) ? 1'b1      : ( (ISOL_N===1'b1) ? 'b1          : 'bx );
      assign LKRB_N_INT      = (ISOL_N===1'b0) ? 1'b1      : ( (ISOL_N===1'b1) ? 'b1          : 'bx );
    `endif
  `endif
  `ifdef PWR_GATE1
    assign COREPWS_N_INT   = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? COREPWS_N    : 'bx );
    assign P_PWS_N_INT     = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? P_PWS_N      : 'bx );
  `else
    `ifdef PWR_GATE2
      assign COREPWS_N_INT   = (ISOL_N===1'b0) ? 1'b1      : ( (ISOL_N===1'b1) ? 'b1          : 'bx );
      assign P_PWS_N_INT     = (ISOL_N===1'b0) ? 1'b1      : ( (ISOL_N===1'b1) ? P_PWS_N      : 'bx );
    `else
      assign COREPWS_N_INT   = (ISOL_N===1'b0) ? 1'b1      : ( (ISOL_N===1'b1) ? 'b1          : 'bx );
      assign P_PWS_N_INT     = (ISOL_N===1'b0) ? 1'b1      : ( (ISOL_N===1'b1) ? 'b1          : 'bx );
    `endif
  `endif
  `ifdef ROW_RED
    assign RENF_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? RENF         : 'bx );
    assign RENS_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? RENS         : 'bx );
    assign RRAF_INT        = (ISOL_N===1'b0) ? {14{1'b0}}  : ( (ISOL_N===1'b1) ? RRAF         : 'bx );
    assign RRAS_INT        = (ISOL_N===1'b0) ? {14{1'b0}}  : ( (ISOL_N===1'b1) ? RRAS         : 'bx );
  `else
    assign RENF_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign RENS_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign RRAF_INT        = (ISOL_N===1'b0) ? {14{1'b0}}  : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign RRAS_INT        = (ISOL_N===1'b0) ? {14{1'b0}}  : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
  `endif
  `ifdef COL_RED
    assign CRAL_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? CRAL         : 'bx );
    assign CRAR_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? CRAR         : 'bx );
  `else
    assign CRAL_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign CRAR_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
  `endif
  `ifdef BIST_TEST
    assign T_BE_N_INT      = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? T_BE_N       : 'bx );
    assign T_CE_N_INT      = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? T_CE_N       : 'bx );
    assign T_GWE_N_INT     = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? T_GWE_N      : 'bx );
    assign T_A_INT         = (ISOL_N===1'b0) ? {13{1'b0}}  : ( (ISOL_N===1'b1) ? T_A          : 'bx );
    assign T_DI_INT        = (ISOL_N===1'b0) ? {32{1'b0}}  : ( (ISOL_N===1'b1) ? T_DI         : 'bx );
    `ifdef BIT_WRITE
      assign T_BWE_N_INT     = (ISOL_N===1'b0) ? {32{1'b1}}  : ( (ISOL_N===1'b1) ? T_BWE_N        : 'bx );
    `else
      `ifdef BYTE_WRITE
        assign T_BWE_N_INT[0]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[1]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[2]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[3]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[4]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[5]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[6]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[7]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[8]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[9]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[10]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[11]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[12]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[13]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[14]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[15]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[16]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[17]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[18]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[19]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[20]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[21]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[22]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[23]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[24]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[25]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[26]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[27]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[28]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[29]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[30]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[31]  =  T_BYWE_N[3] ;
      `else
        assign T_BWE_N_INT       = (ISOL_N===1'b0) ? {32{1'b1}}  : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
      `endif
    `endif
    `ifdef OUTPUT_ENABLE
      assign T_OE_N_INT    = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? T_OE_N       : 'bx );
    `else
      assign T_OE_N_INT    = 'b0;
    `endif
  `else
    assign T_BE_N_INT      = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? 'b1          : 'bx );
    assign T_CE_N_INT      = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? 'b1          : 'bx );
    assign T_GWE_N_INT     = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? 'b1          : 'bx );
    assign T_A_INT         = (ISOL_N===1'b0) ? {13{1'b0}}  : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign T_DI_INT        = (ISOL_N===1'b0) ? {32{1'b0}}  : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign T_BWE_N_INT     = (ISOL_N===1'b0) ? 'b1         : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign T_OE_N_INT      = 'b0;
  `endif
`else
  `ifdef CLKINV
    assign CLK_INT           = (condition_pwr2 || condition_pwr3) ? 0: ~CLK;
  `else
    assign CLK_INT           = (condition_pwr2 || condition_pwr3) ? 0:  CLK;
  `endif
  assign CE_N_INT          = CE_N;
  assign GWE_N_INT         = GWE_N;
  assign A_INT             = A;
  assign DI_INT            = DI;
  `ifdef BIT_WRITE
    assign BWE_N_INT       = BWE_N;
  `else
    `ifdef BYTE_WRITE
      assign BWE_N_INT[0]  =  BYWE_N[0] ;
      assign BWE_N_INT[1]  =  BYWE_N[0] ;
      assign BWE_N_INT[2]  =  BYWE_N[0] ;
      assign BWE_N_INT[3]  =  BYWE_N[0] ;
      assign BWE_N_INT[4]  =  BYWE_N[0] ;
      assign BWE_N_INT[5]  =  BYWE_N[0] ;
      assign BWE_N_INT[6]  =  BYWE_N[0] ;
      assign BWE_N_INT[7]  =  BYWE_N[0] ;
      assign BWE_N_INT[8]  =  BYWE_N[1] ;
      assign BWE_N_INT[9]  =  BYWE_N[1] ;
      assign BWE_N_INT[10]  =  BYWE_N[1] ;
      assign BWE_N_INT[11]  =  BYWE_N[1] ;
      assign BWE_N_INT[12]  =  BYWE_N[1] ;
      assign BWE_N_INT[13]  =  BYWE_N[1] ;
      assign BWE_N_INT[14]  =  BYWE_N[1] ;
      assign BWE_N_INT[15]  =  BYWE_N[1] ;
      assign BWE_N_INT[16]  =  BYWE_N[2] ;
      assign BWE_N_INT[17]  =  BYWE_N[2] ;
      assign BWE_N_INT[18]  =  BYWE_N[2] ;
      assign BWE_N_INT[19]  =  BYWE_N[2] ;
      assign BWE_N_INT[20]  =  BYWE_N[2] ;
      assign BWE_N_INT[21]  =  BYWE_N[2] ;
      assign BWE_N_INT[22]  =  BYWE_N[2] ;
      assign BWE_N_INT[23]  =  BYWE_N[2] ;
      assign BWE_N_INT[24]  =  BYWE_N[3] ;
      assign BWE_N_INT[25]  =  BYWE_N[3] ;
      assign BWE_N_INT[26]  =  BYWE_N[3] ;
      assign BWE_N_INT[27]  =  BYWE_N[3] ;
      assign BWE_N_INT[28]  =  BYWE_N[3] ;
      assign BWE_N_INT[29]  =  BYWE_N[3] ;
      assign BWE_N_INT[30]  =  BYWE_N[3] ;
      assign BWE_N_INT[31]  =  BYWE_N[3] ;
    `else
      assign BWE_N_INT       = 'b0;
    `endif
  `endif
  `ifdef OUTPUT_ENABLE
    assign OE_N_INT        = OE_N;
  `else
    assign OE_N_INT        = 'b0;
  `endif
  `ifdef ASYNCHRONOUS_WRITE
    assign T_AWT_N_INT     = T_AWT_N;
  `else
    assign T_AWT_N_INT     = 'b1;
  `endif
  assign T_RWM_INT         = T_RWM;
  `ifdef WRITE_ASSIST
    assign T_DLY_INT       = T_DLY;
  `else
    assign T_DLY_INT       = 'b0;
  `endif
  `ifdef READ_ASSIST
    assign RAE_N_INT       = RAE_N;
  `else
    assign RAE_N_INT       = 'b0;
  `endif
  `ifdef LOW_LEAK1
    assign LOLEAK_N_INT    = LOLEAK_N;
    assign LKRB_N_INT      = LKRB_N;
    assign DS_INT[0]       = DS[0];
    assign DS_INT[1]       = DS[1];
  `else
    `ifdef LOW_LEAK2
      assign LOLEAK_N_INT    = LOLEAK_N;
      assign LKRB_N_INT      = 'b1;
      assign DS_INT[0]       = DS[0];
      assign DS_INT[1]       = DS[1];
    `else
      assign LOLEAK_N_INT    = 'b1;
      assign LKRB_N_INT      = 'b1;
    `endif
  `endif
  `ifdef PWR_GATE1
    assign COREPWS_N_INT   = COREPWS_N;
    assign P_PWS_N_INT     = P_PWS_N;
  `else
    `ifdef PWR_GATE2
      assign COREPWS_N_INT   = 'b1;
      assign P_PWS_N_INT     = P_PWS_N;
    `else
      assign COREPWS_N_INT   = 'b1;
      assign P_PWS_N_INT     = 'b1;
    `endif
  `endif
  `ifdef ROW_RED
    assign RENF_INT        = RENF;
    assign RENS_INT        = RENS;
    assign RRAF_INT        = RRAF;
    assign RRAS_INT        = RRAS;
  `else
    assign RENF_INT        = 'b0;
    assign RENS_INT        = 'b0;
    assign RRAF_INT        = 'b0;
    assign RRAS_INT        = 'b0;
  `endif
  `ifdef COL_RED
    assign CRAL_INT        = CRAL;
    assign CRAR_INT        = CRAR;
  `else
    assign CRAL_INT        = 'b0;
    assign CRAR_INT        = 'b0;
  `endif
  `ifdef BIST_TEST
    assign T_BE_N_INT      = T_BE_N;
    assign T_CE_N_INT      = T_CE_N;
    assign T_GWE_N_INT     = T_GWE_N;
    assign T_A_INT         = T_A;
    assign T_DI_INT        = T_DI;
    `ifdef BIT_WRITE
      assign T_BWE_N_INT       = T_BWE_N;
    `else
      `ifdef BYTE_WRITE
        assign T_BWE_N_INT[0]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[1]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[2]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[3]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[4]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[5]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[6]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[7]  =  T_BYWE_N[0] ;
        assign T_BWE_N_INT[8]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[9]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[10]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[11]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[12]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[13]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[14]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[15]  =  T_BYWE_N[1] ;
        assign T_BWE_N_INT[16]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[17]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[18]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[19]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[20]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[21]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[22]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[23]  =  T_BYWE_N[2] ;
        assign T_BWE_N_INT[24]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[25]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[26]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[27]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[28]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[29]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[30]  =  T_BYWE_N[3] ;
        assign T_BWE_N_INT[31]  =  T_BYWE_N[3] ;
      `else
        assign T_BWE_N_INT       = 'b0;
      `endif
    `endif
    `ifdef OUTPUT_ENABLE
      assign T_OE_N_INT    = T_OE_N;
    `else
      assign T_OE_N_INT    = 'b0;
    `endif
  `else
    assign T_BE_N_INT      = 'b1;
    assign T_CE_N_INT      = 'b1;
    assign T_GWE_N_INT     = 'b0;
    assign T_A_INT         = 'b0;
    assign T_DI_INT        = 'b0;
    assign T_BWE_N_INT     = 'b0;
    assign T_BYWE_N_INT    = 'b0;
    assign T_OE_N_INT      = 'b0;
  `endif
`endif
// Isolation block

always @(CLK_INT)
begin 
  if ((T_RWM_INT[0] == 0 && T_RWM_INT[1] == 0 && T_RWM_INT[2] == 0))  begin 
    $display("%m The Read Write Margin is set to %b%b%b which is NOT RECOMMENDED. This may cause Functional and Speed problems - Please Verify your settings", T_RWM[2], T_RWM[1], T_RWM[0]);
    $display("The DEFAULT and RECOMMENDED SETTING for Read Write Margin is 011");
  end 
  if ((T_RWM_INT[0] == 1 && T_RWM_INT[1] == 0 && T_RWM_INT[2] == 0))  begin 
    $display("%m The Read Write Margin is set to %b%b%b which is NOT RECOMMENDED. This may cause Functional and Speed problems - Please Verify your settings", T_RWM[2], T_RWM[1], T_RWM[0]);
    $display("The DEFAULT and RECOMMENDED SETTING for Read Write Margin is 011");
  end 
  if ((T_RWM_INT[0] == 0 && T_RWM_INT[1] == 1 && T_RWM_INT[2] == 0))  begin 
    $display("%m The Read Write Margin is set to %b%b%b which is NOT RECOMMENDED. This may cause Functional and Speed problems - Please Verify your settings", T_RWM[2], T_RWM[1], T_RWM[0]);
    $display("The DEFAULT and RECOMMENDED SETTING for Read Write Margin is 011");
  end 
end 
assign condition_pwr0 = !LOLEAK_N_INT &&  LKRB_N_INT &&  P_PWS_N_INT &&  COREPWS_N_INT;
assign condition_pwr1 = !LOLEAK_N_INT && !LKRB_N_INT &&  P_PWS_N_INT &&  COREPWS_N_INT;
assign condition_pwr2 = !LOLEAK_N_INT && !LKRB_N_INT && !P_PWS_N_INT &&  COREPWS_N_INT;
assign condition_pwr3 = !LOLEAK_N_INT && !LKRB_N_INT && !P_PWS_N_INT && !COREPWS_N_INT;
always @(posedge CLK_INT) begin
    if (ok) begin
      CE_N_R          <=  T_BE_N_INT ? ~CE_N_INT  : ~T_CE_N_INT;
      We_R            <=  T_BE_N_INT ? ~BWE_N_INT : ~T_BWE_N_INT;
      GWe_R           <=  T_BE_N_INT ? ~GWE_N_INT : ~T_GWE_N_INT;
      Address_R      <=   (condition_pwr0 || condition_pwr1) ? 1'bx : (T_BE_N_INT ? A_INT      : T_A_INT);
      if (!(T_BE_N_INT ? CE_N_INT : T_CE_N_INT)) begin
        if (T_BE_N_INT && A_INT >= 16384)
          $display("ERROR %m Address:%h  is out of bounds",A_INT);
        if (!T_BE_N_INT && T_A_INT >= 16384)
          $display("ERROR %m Bist Address:%h  is out of bounds",T_A_INT);
      end
      DataIn_R  <= #0.001 (T_BE_N_INT ? DI_INT : T_DI_INT);
    end
end
  // Generate internal pulse to mark the Read/Write operation region to detect glitch on LOLEAK_N and LKRB_N
always @(CE_N_R) begin
  if (ok) begin
    active_pulse <= CE_N_R;
    #0.6993 active_pulse <= 1'd0;
  end
end
// writing/reading x if there is a glitch on LOLEAK_N LKRB_N during SRAM active cycle
always @(LOLEAK_N_INT or LKRB_N_INT) begin
  if (active_pulse) begin
    memArray[Address_R] =  32'bx;
    if (!GWe_R) begin
      Dout = 32'bx;
    end
  end
end
 // writing x if address or GWe_R is not defined... and writing into memory if We_R is enabled
always @(DataIn_R or Address_R or GWe_R or We_R or CE_N_R or COREPWS_N_INT or P_PWS_N_INT) begin
  if (COREPWS_N_INT && P_PWS_N_INT) begin
    if (GWe_R && CE_N_R) begin
      tmpDataIn_R = memArray[Address_R];
      for (i=0; i<32; i=i+1) begin
        if (We_R[i]) begin
          if (^Address_R === 1'bx) begin
            for(j=0; j<16384; j=j+1) begin
              tmpDataIn_R    = memArray[j];
              tmpDataIn_R[i] = 1'bx;
              memArray[j]    = tmpDataIn_R;
            end
          end
          else begin
            tmpDataIn_R[i]   = DataIn_R[i];
          end
        end
        else begin
          if (^Address_R === 1'bx) begin
            for(j=0; j<16384; j=j+1) begin
              tmpDataIn_R = memArray[j];
              if (We_R[i] === 1'bx) tmpDataIn_R[i] = 1'bx;
              memArray[j] = tmpDataIn_R;
            end
          end
          else begin
            if (We_R[i] === 1'bx) tmpDataIn_R[i] = 1'bx;
          end
        end
      end
    end

    if (GWe_R && CE_N_R) begin
      memArray[Address_R] = tmpDataIn_R;
    end
    else begin
      if (GWe_R === 1'bx && CE_N_R) begin
        if (^Address_R === 1'bx) begin
          for(j=0; j<16384; j=j+1) begin
            memArray[j] = 32'bx;
          end
        end
        else begin
          memArray[Address_R] = 32'bx;
        end
      end
      if (CE_N_R) begin
        Dout = (COREPWS_N_INT && P_PWS_N_INT) ? memArray[Address_R] : 32'bx;
      end
      else if (CE_N_R === 1'bx && GWe_R) begin
        memArray[Address_R] = 32'bx;
        Dout = 32'bx;
      end
      else if (CE_N_R === 1'bx) begin
        Dout = 32'bx;
      end
    end
  end
  else begin
    if (!COREPWS_N_INT) begin
      for (m = 0; m < 16384; m = m + 1) begin
        memArray[m] = 32'bx;
      end
    end
  end
end
always @(posedge COREPWS_N_INT or posedge P_PWS_N_INT) begin
  Dout_R <= 32'bx;
end
assign Dout_R_INT = ((COREPWS_N_INT===1'bx) || (P_PWS_N_INT===1'bx)) ? 32'bx : (((COREPWS_N_INT===1'b0) || (P_PWS_N_INT===1'b0)) ? 32'b0 : Dout);
assign DO_temp = T_AWT_N_INT ? Dout_R_INT : (T_BE_N_INT ? DI_INT : T_DI_INT);
assign #0 cntrl = (T_BE_N_INT ? OE_N_INT : T_OE_N_INT) ? 1'b1 : 1'b0;
bufif0(DO[0], DO_temp[0], cntrl);
bufif0(DO[1], DO_temp[1], cntrl);
bufif0(DO[2], DO_temp[2], cntrl);
bufif0(DO[3], DO_temp[3], cntrl);
bufif0(DO[4], DO_temp[4], cntrl);
bufif0(DO[5], DO_temp[5], cntrl);
bufif0(DO[6], DO_temp[6], cntrl);
bufif0(DO[7], DO_temp[7], cntrl);
bufif0(DO[8], DO_temp[8], cntrl);
bufif0(DO[9], DO_temp[9], cntrl);
bufif0(DO[10], DO_temp[10], cntrl);
bufif0(DO[11], DO_temp[11], cntrl);
bufif0(DO[12], DO_temp[12], cntrl);
bufif0(DO[13], DO_temp[13], cntrl);
bufif0(DO[14], DO_temp[14], cntrl);
bufif0(DO[15], DO_temp[15], cntrl);
bufif0(DO[16], DO_temp[16], cntrl);
bufif0(DO[17], DO_temp[17], cntrl);
bufif0(DO[18], DO_temp[18], cntrl);
bufif0(DO[19], DO_temp[19], cntrl);
bufif0(DO[20], DO_temp[20], cntrl);
bufif0(DO[21], DO_temp[21], cntrl);
bufif0(DO[22], DO_temp[22], cntrl);
bufif0(DO[23], DO_temp[23], cntrl);
bufif0(DO[24], DO_temp[24], cntrl);
bufif0(DO[25], DO_temp[25], cntrl);
bufif0(DO[26], DO_temp[26], cntrl);
bufif0(DO[27], DO_temp[27], cntrl);
bufif0(DO[28], DO_temp[28], cntrl);
bufif0(DO[29], DO_temp[29], cntrl);
bufif0(DO[30], DO_temp[30], cntrl);
bufif0(DO[31], DO_temp[31], cntrl);


wire condition5 ;
assign condition5 = (!CE_N) ;
wire timing_condition_margin_0 ;
wire timing_condition_margin_1 ;
wire timing_condition_margin_2 ;
wire timing_condition_margin_3 ;
wire timing_condition_margin_4 ;
wire timing_condition_margin_5 ;
wire timing_condition_margin_6 ;
wire timing_condition_margin_7 ;
assign timing_condition_margin_0 = (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) ;
assign timing_condition_margin_1 = (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) ;
assign timing_condition_margin_2 = (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) ;
assign timing_condition_margin_3 = (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) ;
assign timing_condition_margin_4 = (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) ;
assign timing_condition_margin_5 = (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) ;
assign timing_condition_margin_6 = (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) ;
assign timing_condition_margin_7 = (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) ;

specify
 specparam
  period_param_0 = 0.6993,
  period_param_1 = 0.6993,
  period_param_2 = 0.6993,
  period_param_3 = 0.6993,
  period_param_4 = 0.6993,
  period_param_5 = 0.6993,
  period_param_6 = 0.6993,
  period_param_7 = 0.6993,
  trise_CLK_DO_worst_0 = 0.6276, 
  tfall_CLK_DO_worst_0 = 0.6179, 
  trise_CLK_DO_worst_1 = 0.6276, 
  tfall_CLK_DO_worst_1 = 0.6179, 
  trise_CLK_DO_worst_2 = 0.6276, 
  tfall_CLK_DO_worst_2 = 0.6179, 
  trise_CLK_DO_worst_3 = 0.6276, 
  tfall_CLK_DO_worst_3 = 0.6179, 
  trise_CLK_DO_worst_4 = 0.6276, 
  tfall_CLK_DO_worst_4 = 0.6179, 
  trise_CLK_DO_worst_5 = 0.6276, 
  tfall_CLK_DO_worst_5 = 0.6179, 
  trise_CLK_DO_worst_6 = 0.6276, 
  tfall_CLK_DO_worst_6 = 0.6179, 
  trise_CLK_DO_worst_7 = 0.6276, 
  tfall_CLK_DO_worst_7 = 0.6179, 
  t_T_RWM_setup_worst = 0.0849,
  t_T_RWM_hold_worst  = 0.6993,
  t_A_setup_worst = 0.1326,
  t_A_hold_worst  = 0.0416,
  t_DI_setup_worst = -0.0011,
  t_DI_hold_worst  = 0.2050,
  t_CE_N_setup_worst = 0.1208,
  t_CE_N_hold_worst  = 0.0528,
  t_BYWE_N_setup_worst = -0.0011,
  t_BYWE_N_hold_worst  = 0.2050,
  t_GWE_N_setup_worst = 0.1371,
  t_GWE_N_hold_worst  = 0.0023;
  $period(posedge CLK &&& timing_condition_margin_0, period_param_0);
  $period(posedge CLK &&& timing_condition_margin_1, period_param_1);
  $period(posedge CLK &&& timing_condition_margin_2, period_param_2);
  $period(posedge CLK &&& timing_condition_margin_3, period_param_3);
  $period(posedge CLK &&& timing_condition_margin_4, period_param_4);
  $period(posedge CLK &&& timing_condition_margin_5, period_param_5);
  $period(posedge CLK &&& timing_condition_margin_6, period_param_6);
  $period(posedge CLK &&& timing_condition_margin_7, period_param_7);
  $width(posedge CLK, 0.072491);
  $width(negedge CLK, 0.198380);
  /*The default setting corresponds to T_RWM == 3'd3*/
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[0] +: DI[0])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[1] +: DI[1])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[2] +: DI[2])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[3] +: DI[3])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[4] +: DI[4])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[5] +: DI[5])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[6] +: DI[6])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[7] +: DI[7])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[8] +: DI[8])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[9] +: DI[9])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[10] +: DI[10])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[11] +: DI[11])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[12] +: DI[12])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[13] +: DI[13])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[14] +: DI[14])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[15] +: DI[15])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[16] +: DI[16])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[17] +: DI[17])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[18] +: DI[18])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[19] +: DI[19])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[20] +: DI[20])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[21] +: DI[21])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[22] +: DI[22])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[23] +: DI[23])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[24] +: DI[24])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[25] +: DI[25])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[26] +: DI[26])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[27] +: DI[27])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[28] +: DI[28])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[29] +: DI[29])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[30] +: DI[30])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[31] +: DI[31])) = (trise_CLK_DO_worst_0, tfall_CLK_DO_worst_0);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[0] +: DI[0])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[1] +: DI[1])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[2] +: DI[2])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[3] +: DI[3])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[4] +: DI[4])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[5] +: DI[5])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[6] +: DI[6])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[7] +: DI[7])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[8] +: DI[8])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[9] +: DI[9])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[10] +: DI[10])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[11] +: DI[11])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[12] +: DI[12])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[13] +: DI[13])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[14] +: DI[14])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[15] +: DI[15])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[16] +: DI[16])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[17] +: DI[17])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[18] +: DI[18])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[19] +: DI[19])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[20] +: DI[20])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[21] +: DI[21])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[22] +: DI[22])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[23] +: DI[23])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[24] +: DI[24])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[25] +: DI[25])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[26] +: DI[26])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[27] +: DI[27])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[28] +: DI[28])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[29] +: DI[29])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[30] +: DI[30])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 0) 
  (posedge CLK => (DO[31] +: DI[31])) = (trise_CLK_DO_worst_1, tfall_CLK_DO_worst_1);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[0] +: DI[0])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[1] +: DI[1])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[2] +: DI[2])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[3] +: DI[3])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[4] +: DI[4])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[5] +: DI[5])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[6] +: DI[6])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[7] +: DI[7])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[8] +: DI[8])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[9] +: DI[9])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[10] +: DI[10])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[11] +: DI[11])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[12] +: DI[12])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[13] +: DI[13])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[14] +: DI[14])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[15] +: DI[15])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[16] +: DI[16])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[17] +: DI[17])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[18] +: DI[18])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[19] +: DI[19])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[20] +: DI[20])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[21] +: DI[21])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[22] +: DI[22])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[23] +: DI[23])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[24] +: DI[24])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[25] +: DI[25])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[26] +: DI[26])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[27] +: DI[27])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[28] +: DI[28])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[29] +: DI[29])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[30] +: DI[30])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[31] +: DI[31])) = (trise_CLK_DO_worst_2, tfall_CLK_DO_worst_2);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[0] +: DI[0])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[1] +: DI[1])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[2] +: DI[2])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[3] +: DI[3])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[4] +: DI[4])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[5] +: DI[5])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[6] +: DI[6])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[7] +: DI[7])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[8] +: DI[8])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[9] +: DI[9])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[10] +: DI[10])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[11] +: DI[11])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[12] +: DI[12])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[13] +: DI[13])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[14] +: DI[14])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[15] +: DI[15])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[16] +: DI[16])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[17] +: DI[17])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[18] +: DI[18])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[19] +: DI[19])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[20] +: DI[20])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[21] +: DI[21])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[22] +: DI[22])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[23] +: DI[23])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[24] +: DI[24])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[25] +: DI[25])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[26] +: DI[26])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[27] +: DI[27])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[28] +: DI[28])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[29] +: DI[29])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[30] +: DI[30])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 0) 
  (posedge CLK => (DO[31] +: DI[31])) = (trise_CLK_DO_worst_3, tfall_CLK_DO_worst_3);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[0] +: DI[0])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[1] +: DI[1])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[2] +: DI[2])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[3] +: DI[3])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[4] +: DI[4])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[5] +: DI[5])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[6] +: DI[6])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[7] +: DI[7])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[8] +: DI[8])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[9] +: DI[9])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[10] +: DI[10])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[11] +: DI[11])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[12] +: DI[12])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[13] +: DI[13])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[14] +: DI[14])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[15] +: DI[15])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[16] +: DI[16])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[17] +: DI[17])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[18] +: DI[18])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[19] +: DI[19])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[20] +: DI[20])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[21] +: DI[21])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[22] +: DI[22])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[23] +: DI[23])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[24] +: DI[24])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[25] +: DI[25])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[26] +: DI[26])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[27] +: DI[27])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[28] +: DI[28])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[29] +: DI[29])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[30] +: DI[30])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 0 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[31] +: DI[31])) = (trise_CLK_DO_worst_4, tfall_CLK_DO_worst_4);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[0] +: DI[0])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[1] +: DI[1])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[2] +: DI[2])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[3] +: DI[3])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[4] +: DI[4])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[5] +: DI[5])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[6] +: DI[6])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[7] +: DI[7])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[8] +: DI[8])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[9] +: DI[9])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[10] +: DI[10])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[11] +: DI[11])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[12] +: DI[12])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[13] +: DI[13])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[14] +: DI[14])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[15] +: DI[15])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[16] +: DI[16])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[17] +: DI[17])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[18] +: DI[18])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[19] +: DI[19])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[20] +: DI[20])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[21] +: DI[21])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[22] +: DI[22])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[23] +: DI[23])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[24] +: DI[24])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[25] +: DI[25])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[26] +: DI[26])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[27] +: DI[27])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[28] +: DI[28])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[29] +: DI[29])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[30] +: DI[30])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 1 && T_RWM[1] == 0 && T_RWM[2] == 1) 
  (posedge CLK => (DO[31] +: DI[31])) = (trise_CLK_DO_worst_5, tfall_CLK_DO_worst_5);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[0] +: DI[0])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[1] +: DI[1])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[2] +: DI[2])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[3] +: DI[3])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[4] +: DI[4])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[5] +: DI[5])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[6] +: DI[6])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[7] +: DI[7])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[8] +: DI[8])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[9] +: DI[9])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[10] +: DI[10])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[11] +: DI[11])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[12] +: DI[12])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[13] +: DI[13])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[14] +: DI[14])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[15] +: DI[15])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[16] +: DI[16])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[17] +: DI[17])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[18] +: DI[18])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[19] +: DI[19])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[20] +: DI[20])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[21] +: DI[21])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[22] +: DI[22])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[23] +: DI[23])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[24] +: DI[24])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[25] +: DI[25])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[26] +: DI[26])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[27] +: DI[27])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[28] +: DI[28])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[29] +: DI[29])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[30] +: DI[30])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 0 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[31] +: DI[31])) = (trise_CLK_DO_worst_6, tfall_CLK_DO_worst_6);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[0] +: DI[0])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[1] +: DI[1])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[2] +: DI[2])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[3] +: DI[3])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[4] +: DI[4])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[5] +: DI[5])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[6] +: DI[6])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[7] +: DI[7])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[8] +: DI[8])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[9] +: DI[9])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[10] +: DI[10])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[11] +: DI[11])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[12] +: DI[12])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[13] +: DI[13])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[14] +: DI[14])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[15] +: DI[15])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[16] +: DI[16])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[17] +: DI[17])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[18] +: DI[18])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[19] +: DI[19])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[20] +: DI[20])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[21] +: DI[21])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[22] +: DI[22])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[23] +: DI[23])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[24] +: DI[24])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[25] +: DI[25])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[26] +: DI[26])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[27] +: DI[27])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[28] +: DI[28])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[29] +: DI[29])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[30] +: DI[30])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 if (T_RWM[0] == 1 && T_RWM[1] == 1 && T_RWM[2] == 1) 
  (posedge CLK => (DO[31] +: DI[31])) = (trise_CLK_DO_worst_7, tfall_CLK_DO_worst_7);
 `ifdef SDFVERSION_2
  $setup(posedge T_RWM[0], posedge CLK &&& condition5, t_T_RWM_setup_worst);
  $setup(negedge T_RWM[0], posedge CLK &&& condition5, t_T_RWM_setup_worst);
  $hold(posedge CLK &&& condition5, posedge T_RWM[0], t_T_RWM_hold_worst);
  $hold(posedge CLK &&& condition5, negedge T_RWM[0], t_T_RWM_hold_worst);
  $setup(posedge T_RWM[1], posedge CLK &&& condition5, t_T_RWM_setup_worst);
  $setup(negedge T_RWM[1], posedge CLK &&& condition5, t_T_RWM_setup_worst);
  $hold(posedge CLK &&& condition5, posedge T_RWM[1], t_T_RWM_hold_worst);
  $hold(posedge CLK &&& condition5, negedge T_RWM[1], t_T_RWM_hold_worst);
  $setup(posedge T_RWM[2], posedge CLK &&& condition5, t_T_RWM_setup_worst);
  $setup(negedge T_RWM[2], posedge CLK &&& condition5, t_T_RWM_setup_worst);
  $hold(posedge CLK &&& condition5, posedge T_RWM[2], t_T_RWM_hold_worst);
  $hold(posedge CLK &&& condition5, negedge T_RWM[2], t_T_RWM_hold_worst);
  $setup(posedge DI[0], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[0], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[0], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[0], t_DI_hold_worst);
  $setup(posedge DI[1], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[1], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[1], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[1], t_DI_hold_worst);
  $setup(posedge DI[2], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[2], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[2], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[2], t_DI_hold_worst);
  $setup(posedge DI[3], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[3], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[3], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[3], t_DI_hold_worst);
  $setup(posedge DI[4], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[4], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[4], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[4], t_DI_hold_worst);
  $setup(posedge DI[5], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[5], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[5], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[5], t_DI_hold_worst);
  $setup(posedge DI[6], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[6], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[6], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[6], t_DI_hold_worst);
  $setup(posedge DI[7], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[7], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[7], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[7], t_DI_hold_worst);
  $setup(posedge DI[8], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[8], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[8], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[8], t_DI_hold_worst);
  $setup(posedge DI[9], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[9], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[9], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[9], t_DI_hold_worst);
  $setup(posedge DI[10], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[10], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[10], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[10], t_DI_hold_worst);
  $setup(posedge DI[11], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[11], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[11], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[11], t_DI_hold_worst);
  $setup(posedge DI[12], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[12], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[12], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[12], t_DI_hold_worst);
  $setup(posedge DI[13], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[13], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[13], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[13], t_DI_hold_worst);
  $setup(posedge DI[14], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[14], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[14], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[14], t_DI_hold_worst);
  $setup(posedge DI[15], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[15], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[15], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[15], t_DI_hold_worst);
  $setup(posedge DI[16], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[16], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[16], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[16], t_DI_hold_worst);
  $setup(posedge DI[17], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[17], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[17], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[17], t_DI_hold_worst);
  $setup(posedge DI[18], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[18], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[18], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[18], t_DI_hold_worst);
  $setup(posedge DI[19], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[19], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[19], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[19], t_DI_hold_worst);
  $setup(posedge DI[20], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[20], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[20], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[20], t_DI_hold_worst);
  $setup(posedge DI[21], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[21], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[21], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[21], t_DI_hold_worst);
  $setup(posedge DI[22], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[22], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[22], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[22], t_DI_hold_worst);
  $setup(posedge DI[23], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[23], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[23], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[23], t_DI_hold_worst);
  $setup(posedge DI[24], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[24], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[24], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[24], t_DI_hold_worst);
  $setup(posedge DI[25], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[25], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[25], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[25], t_DI_hold_worst);
  $setup(posedge DI[26], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[26], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[26], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[26], t_DI_hold_worst);
  $setup(posedge DI[27], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[27], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[27], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[27], t_DI_hold_worst);
  $setup(posedge DI[28], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[28], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[28], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[28], t_DI_hold_worst);
  $setup(posedge DI[29], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[29], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[29], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[29], t_DI_hold_worst);
  $setup(posedge DI[30], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[30], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[30], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[30], t_DI_hold_worst);
  $setup(posedge DI[31], posedge CLK &&& condition5, t_DI_setup_worst);
  $setup(negedge DI[31], posedge CLK &&& condition5, t_DI_setup_worst);
  $hold(posedge CLK &&& condition5, posedge DI[31], t_DI_hold_worst);
  $hold(posedge CLK &&& condition5, negedge DI[31], t_DI_hold_worst);
  $setup(posedge A[0], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[0], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[0], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[0], t_A_hold_worst);
  $setup(posedge A[1], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[1], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[1], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[1], t_A_hold_worst);
  $setup(posedge A[2], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[2], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[2], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[2], t_A_hold_worst);
  $setup(posedge A[3], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[3], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[3], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[3], t_A_hold_worst);
  $setup(posedge A[4], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[4], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[4], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[4], t_A_hold_worst);
  $setup(posedge A[5], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[5], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[5], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[5], t_A_hold_worst);
  $setup(posedge A[6], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[6], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[6], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[6], t_A_hold_worst);
  $setup(posedge A[7], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[7], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[7], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[7], t_A_hold_worst);
  $setup(posedge A[8], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[8], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[8], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[8], t_A_hold_worst);
  $setup(posedge A[9], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[9], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[9], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[9], t_A_hold_worst);
  $setup(posedge A[10], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[10], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[10], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[10], t_A_hold_worst);
  $setup(posedge A[11], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[11], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[11], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[11], t_A_hold_worst);
  $setup(posedge A[12], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[12], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[12], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[12], t_A_hold_worst);
  $setup(posedge A[13], posedge CLK &&& condition5, t_A_setup_worst);
  $setup(negedge A[13], posedge CLK &&& condition5, t_A_setup_worst);
  $hold(posedge CLK &&& condition5, posedge A[13], t_A_hold_worst);
  $hold(posedge CLK &&& condition5, negedge A[13], t_A_hold_worst);
  $setup(posedge CE_N, posedge CLK, t_CE_N_setup_worst);
  $setup(negedge CE_N, posedge CLK, t_CE_N_setup_worst);
  $hold(posedge CLK, posedge CE_N, t_CE_N_hold_worst);
  $hold(posedge CLK, negedge CE_N, t_CE_N_hold_worst);
  $setup(posedge GWE_N, posedge CLK &&& condition5, t_GWE_N_setup_worst);
  $setup(negedge GWE_N, posedge CLK &&& condition5, t_GWE_N_setup_worst);
  $hold(posedge CLK &&& condition5, posedge GWE_N, t_GWE_N_hold_worst);
  $hold(posedge CLK &&& condition5, negedge GWE_N, t_GWE_N_hold_worst);
  $setup(posedge BYWE_N[0], posedge CLK &&& condition5, t_BYWE_N_setup_worst);
  $setup(negedge BYWE_N[0], posedge CLK &&& condition5, t_BYWE_N_setup_worst);
  $hold(posedge CLK &&& condition5, posedge BYWE_N[0], t_BYWE_N_hold_worst);
  $hold(posedge CLK &&& condition5, negedge BYWE_N[0], t_BYWE_N_hold_worst);
  $setup(posedge BYWE_N[1], posedge CLK &&& condition5, t_BYWE_N_setup_worst);
  $setup(negedge BYWE_N[1], posedge CLK &&& condition5, t_BYWE_N_setup_worst);
  $hold(posedge CLK &&& condition5, posedge BYWE_N[1], t_BYWE_N_hold_worst);
  $hold(posedge CLK &&& condition5, negedge BYWE_N[1], t_BYWE_N_hold_worst);
  $setup(posedge BYWE_N[2], posedge CLK &&& condition5, t_BYWE_N_setup_worst);
  $setup(negedge BYWE_N[2], posedge CLK &&& condition5, t_BYWE_N_setup_worst);
  $hold(posedge CLK &&& condition5, posedge BYWE_N[2], t_BYWE_N_hold_worst);
  $hold(posedge CLK &&& condition5, negedge BYWE_N[2], t_BYWE_N_hold_worst);
  $setup(posedge BYWE_N[3], posedge CLK &&& condition5, t_BYWE_N_setup_worst);
  $setup(negedge BYWE_N[3], posedge CLK &&& condition5, t_BYWE_N_setup_worst);
  $hold(posedge CLK &&& condition5, posedge BYWE_N[3], t_BYWE_N_hold_worst);
  $hold(posedge CLK &&& condition5, negedge BYWE_N[3], t_BYWE_N_hold_worst);
 `endif
 `ifdef SDFVERSION_3
  $setuphold(posedge CLK &&& condition5, posedge T_RWM[0], t_T_RWM_setup_worst, t_T_RWM_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge T_RWM[0], t_T_RWM_setup_worst, t_T_RWM_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge T_RWM[1], t_T_RWM_setup_worst, t_T_RWM_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge T_RWM[1], t_T_RWM_setup_worst, t_T_RWM_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge T_RWM[2], t_T_RWM_setup_worst, t_T_RWM_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge T_RWM[2], t_T_RWM_setup_worst, t_T_RWM_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[0], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[0], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[1], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[1], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[2], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[2], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[3], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[3], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[4], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[4], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[5], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[5], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[6], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[6], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[7], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[7], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[8], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[8], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[9], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[9], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[10], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[10], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[11], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[11], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[12], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[12], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[13], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[13], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[14], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[14], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[15], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[15], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[16], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[16], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[17], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[17], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[18], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[18], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[19], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[19], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[20], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[20], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[21], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[21], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[22], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[22], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[23], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[23], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[24], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[24], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[25], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[25], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[26], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[26], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[27], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[27], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[28], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[28], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[29], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[29], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[30], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[30], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge DI[31], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge DI[31], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[0], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[0], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[1], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[1], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[2], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[2], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[3], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[3], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[4], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[4], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[5], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[5], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[6], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[6], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[7], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[7], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[8], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[8], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[9], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[9], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[10], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[10], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[11], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[11], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[12], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[12], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge A[13], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge A[13], t_A_setup_worst, t_A_hold_worst);
  $setuphold(posedge CLK, posedge CE_N, t_CE_N_setup_worst, t_CE_N_hold_worst);
  $setuphold(posedge CLK, negedge CE_N, t_CE_N_setup_worst, t_CE_N_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge GWE_N, t_GWE_N_setup_worst, t_GWE_N_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge GWE_N, t_GWE_N_setup_worst, t_GWE_N_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge BYWE_N[0], t_BYWE_N_setup_worst, t_BYWE_N_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge BYWE_N[0], t_BYWE_N_setup_worst, t_BYWE_N_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge BYWE_N[1], t_BYWE_N_setup_worst, t_BYWE_N_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge BYWE_N[1], t_BYWE_N_setup_worst, t_BYWE_N_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge BYWE_N[2], t_BYWE_N_setup_worst, t_BYWE_N_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge BYWE_N[2], t_BYWE_N_setup_worst, t_BYWE_N_hold_worst);
  $setuphold(posedge CLK &&& condition5, posedge BYWE_N[3], t_BYWE_N_setup_worst, t_BYWE_N_hold_worst);
  $setuphold(posedge CLK &&& condition5, negedge BYWE_N[3], t_BYWE_N_setup_worst, t_BYWE_N_hold_worst);
 `endif
endspecify
endmodule

`endcelldefine

