/********************************************************************/
/*  Copyright 1998 - 2022 Dolphin Technology, Inc.                  */
/*  This memory compiler and any data created by it are proprietary */
/*  and confidential information of Dolphin Technology, Inc. and    */
/*  can only be used or viewed with written permission from         */
/*  Dolphin Technology, Inc.                                        */
/*  tsmc16nmffcll, version 1p1p59 Rev_1.3                           */
/********************************************************************/

/*The default setting corresponds to T_RWM_R and T_RWM_W == "011".*/

`timescale 1ns/1ps

`undef  ISOLATION
`undef  CLKINV
`define BIT_WRITE
`undef  OUTPUT_ENABLE
`undef  ASYNCHRONOUS_WRITE
`undef  LOW_LEAK1
`undef  LOW_LEAK2
`undef  PWR_GATE1
`undef  PWR_GATE2
`undef  WRITE_ASSIST
`undef  COL_RED
`define BIST_TEST
`define SDFVERSION_2
`undef  SDFVERSION_3
//`define SDFVERSION_3
//`undef  SDFVERSION_2
//****** Please choose the SDF Version to be used . Default is set to  SDFVERSION_2 (Version 2.0) which defines $setup and $hold seperately. Select SDFVERSION_3 for $setuphold ******

`define COLLISION
`celldefine

module dti_2pr_tm16ffcll_576x72_t4bw2x_m_hc (VDD, VSS, DO, A_R, A_W, T_A_R, T_A_W, DI, T_DI, 
       T_BE_N, CE_N_R, CE_N_W, T_CE_N_R, T_CE_N_W, BWE_N, T_BWE_N, T_RWM_R, T_RWM_W, CLK_R, CLK_W);
inout  VDD;
inout  VSS;
output [71:0] DO;               // Data Output
input  [9:0] A_R;               // Read Address
input  [9:0] A_W;               // Write Address
input  [9:0] T_A_R;             // Bist Read Address
input  [9:0] T_A_W;             // Bist Write Address
input  [71:0] DI;               // Data Input
input  [71:0] T_DI;             // Bist Data Input
input  T_BE_N;                  // Bist Enable --- Active Low
input  CE_N_R;                  // Read Chip Select Enable --- Active Low
input  CE_N_W;                  // Write Chip Select Enable --- Active Low
input  T_CE_N_R;                // Read Bist Chip Select Enable --- Active Low
input  T_CE_N_W;                // Write Bist Chip Select Enable --- Active Low
input  [71:0] BWE_N;            // Bit Write Enable --- Active Low
input  [71:0] T_BWE_N;          // Bist Bit Write Enable --- Active Low
input  [2:0] T_RWM_R;           // Read Adjustment for Sense Amp delay
input  [2:0] T_RWM_W;           // Write Adjustment for Sense Amp delay
input  CLK_R;                   // Read Clock
input  CLK_W;                   // Write Clock

wire CLK_R_INT;                     // Read Inverted Clock Enable --- Active Low
wire CLK_W_INT;                     // Write Inverted Clock Enable --- Active Low
wire CE_N_R_INT;                    // Read Chip Select Enable --- Active Low
wire CE_N_W_INT;                    // Write Chip Select Enable --- Active Low
wire [9:0] A_R_INT;                // Read Address
wire [9:0] A_W_INT;                // Write Address
wire [71:0] DI_INT;                 // Data Input
wire [71:0] BWE_N_INT;            // Bit Write Enable --- Active Low
wire [71:0] BYWE_N_INT;           // Byte Write Enable --- Active Low
wire OE_N_INT;                    // Bist Output Enable --- Active Low
wire T_AWT_N_INT;                   // Asynchronous Test Write Through --- Active Low
wire [2:0] T_RWM_R_INT;             // Read Adjustment for Sense Amp delay
wire [2:0] T_RWM_W_INT;             // Write Adjustment for Sense Amp delay
wire [2:0] T_DLY_INT;               // Adjustment for Write Assist delay
wire [1:0] DS_INT;                  // Adjustment for Memory Supply Voltage when deep sleep mode
wire LOLEAK_N_INT;                  // Low Leak Enable for Logic --- Active Low
wire LKRB_N_INT;                    // Low Leak Enable for Memory Array --- Active Low
wire COREPWS_N_INT;                 // Power Down Enable for Memory Array --- Active Low
wire P_PWS_N_INT;                   // Power Down Enable for Logic --- Active Low
wire T_BE_N_INT;                  // Bist Enable --- Active Low
wire T_CE_N_R_INT;                  // Read Bist Chip Select Enable --- Active Low
wire T_CE_N_W_INT;                  // Write Bist Chip Select Enable --- Active Low
wire [9:0] T_A_R_INT;              // Bist Address
wire [9:0] T_A_W_INT;              // Bist Address
wire [71:0] T_DI_INT;               // Bist Data Input
wire [71:0] T_BWE_N_INT;            // Bist Bit Write Enable --- Active Low
wire T_OE_N_INT;                    // Output Enable --- Active Low

wire  cntrl;
wire condition_pwr0;            // Light sleep
wire condition_pwr1;            // Deep sleep
wire condition_pwr2;            // PG retention
wire condition_pwr3;            // Shutdown

reg  [71:0] Dout;
wire [71:0] Dout_R_INT;
wire  [71:0] DO_temp;
reg   [71:0] DataIn_R_W;
reg   [9:0] Address_R_R;
reg   [9:0] Address_R_W;
reg   CE_N_R_R;
reg   CE_N_R_W;
reg   [71:0] memArray [575:0];
integer  j;
integer  k;
integer  i;
reg   [71:0] tmpDataIn_R;
reg   [71:0] We_R;
reg   coll_sig;
reg   read_flag;
reg   inWrite;
reg   inRead;
integer  ok_wr;
integer  ok_read;
integer  m;
reg   active_pulse_w;
reg   active_pulse_r;

  // Initializing Memory Array to x 
initial begin 
  for (m=0; m<576; m=m+1) begin 
    memArray[m] = 72'bx; 
  end 
end 

initial begin
  ok_read = 1;
  ok_wr = 1;
end 


// Isolation block
`ifdef ISOLATION
  `ifdef CLKINV
    assign CLK_R_INT           = (ISOL_N===1'b0) ? 1'b0 : ( (ISOL_N===1'b1) ? ((condition_pwr2 || condition_pwr3) ? 0: ~CLK_R) : 'bx );
    assign CLK_W_INT           = (ISOL_N===1'b0) ? 1'b0 : ( (ISOL_N===1'b1) ? ((condition_pwr2 || condition_pwr3) ? 0: ~CLK_W) : 'bx );
  `else
    assign CLK_R_INT           = (ISOL_N===1'b0) ? 1'b0 : ( (ISOL_N===1'b1) ? ((condition_pwr2 || condition_pwr3) ? 0: CLK_R) : 'bx );
    assign CLK_W_INT           = (ISOL_N===1'b0) ? 1'b0 : ( (ISOL_N===1'b1) ? ((condition_pwr2 || condition_pwr3) ? 0: CLK_W) : 'bx );
  `endif
  assign CE_N_R_INT          = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? CE_N_R         : 'bx );
  assign CE_N_W_INT          = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? CE_N_W         : 'bx );
  assign A_R_INT             = (ISOL_N===1'b0) ? {9{1'b0}}  : ( (ISOL_N===1'b1) ? A_R            : 'bx );
  assign A_W_INT             = (ISOL_N===1'b0) ? {9{1'b0}}  : ( (ISOL_N===1'b1) ? A_W            : 'bx );
  assign DI_INT            = (ISOL_N===1'b0) ? {72{1'b0}}  : ( (ISOL_N===1'b1) ? DI           : 'bx );
  `ifdef BIT_WRITE
    assign BWE_N_INT       = (ISOL_N===1'b0) ? {72{1'b1}}  : ( (ISOL_N===1'b1) ? BWE_N        : 'bx );
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
      assign BWE_N_INT[32]  =  BYWE_N[4] ;
      assign BWE_N_INT[33]  =  BYWE_N[4] ;
      assign BWE_N_INT[34]  =  BYWE_N[4] ;
      assign BWE_N_INT[35]  =  BYWE_N[4] ;
      assign BWE_N_INT[36]  =  BYWE_N[4] ;
      assign BWE_N_INT[37]  =  BYWE_N[4] ;
      assign BWE_N_INT[38]  =  BYWE_N[4] ;
      assign BWE_N_INT[39]  =  BYWE_N[4] ;
      assign BWE_N_INT[40]  =  BYWE_N[5] ;
      assign BWE_N_INT[41]  =  BYWE_N[5] ;
      assign BWE_N_INT[42]  =  BYWE_N[5] ;
      assign BWE_N_INT[43]  =  BYWE_N[5] ;
      assign BWE_N_INT[44]  =  BYWE_N[5] ;
      assign BWE_N_INT[45]  =  BYWE_N[5] ;
      assign BWE_N_INT[46]  =  BYWE_N[5] ;
      assign BWE_N_INT[47]  =  BYWE_N[5] ;
      assign BWE_N_INT[48]  =  BYWE_N[6] ;
      assign BWE_N_INT[49]  =  BYWE_N[6] ;
      assign BWE_N_INT[50]  =  BYWE_N[6] ;
      assign BWE_N_INT[51]  =  BYWE_N[6] ;
      assign BWE_N_INT[52]  =  BYWE_N[6] ;
      assign BWE_N_INT[53]  =  BYWE_N[6] ;
      assign BWE_N_INT[54]  =  BYWE_N[6] ;
      assign BWE_N_INT[55]  =  BYWE_N[6] ;
      assign BWE_N_INT[56]  =  BYWE_N[7] ;
      assign BWE_N_INT[57]  =  BYWE_N[7] ;
      assign BWE_N_INT[58]  =  BYWE_N[7] ;
      assign BWE_N_INT[59]  =  BYWE_N[7] ;
      assign BWE_N_INT[60]  =  BYWE_N[7] ;
      assign BWE_N_INT[61]  =  BYWE_N[7] ;
      assign BWE_N_INT[62]  =  BYWE_N[7] ;
      assign BWE_N_INT[63]  =  BYWE_N[7] ;
      assign BWE_N_INT[64]  =  BYWE_N[8] ;
      assign BWE_N_INT[65]  =  BYWE_N[8] ;
      assign BWE_N_INT[66]  =  BYWE_N[8] ;
      assign BWE_N_INT[67]  =  BYWE_N[8] ;
      assign BWE_N_INT[68]  =  BYWE_N[8] ;
      assign BWE_N_INT[69]  =  BYWE_N[8] ;
      assign BWE_N_INT[70]  =  BYWE_N[8] ;
      assign BWE_N_INT[71]  =  BYWE_N[8] ;
    `else
      assign BWE_N_INT       = (ISOL_N===1'b0) ? {72{1'b1}}  : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
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
   assign T_RWM_R_INT       = (ISOL_N===1'b0) ? 3'b011      : ( (ISOL_N===1'b1) ? T_RWM_R        : 'bx );
   assign T_RWM_W_INT       = (ISOL_N===1'b0) ? 3'b011      : ( (ISOL_N===1'b1) ? T_RWM_W        : 'bx );
  `ifdef WRITE_ASSIST
    assign T_DLY_INT       = (ISOL_N===1'b0) ? {3{1'b0}}   : ( (ISOL_N===1'b1) ? T_DLY        : 'bx );
  `else
    assign T_DLY_INT       = (ISOL_N===1'b0) ? {3{1'b0}}   : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
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
  `ifdef COL_RED
    assign CRAL_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? CRAL         : 'bx );
    assign CRAR_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? CRAR         : 'bx );
  `else
    assign CRAL_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign CRAR_INT        = (ISOL_N===1'b0) ? {1'b0}      : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
  `endif
  `ifdef BIST_TEST
    assign T_BE_N_INT      = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? T_BE_N       : 'bx );
    assign T_CE_N_R_INT      = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? T_CE_N_R       : 'bx );
    assign T_CE_N_W_INT      = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? T_CE_N_W       : 'bx );
    assign T_A_R_INT         = (ISOL_N===1'b0) ? {9{1'b0}}  : ( (ISOL_N===1'b1) ? T_A_R          : 'bx );
    assign T_A_W_INT         = (ISOL_N===1'b0) ? {9{1'b0}}  : ( (ISOL_N===1'b1) ? T_A_W          : 'bx );
    assign T_DI_INT        = (ISOL_N===1'b0) ? {72{1'b0}}  : ( (ISOL_N===1'b1) ? T_DI         : 'bx );
    `ifdef BIT_WRITE
      assign T_BWE_N_INT     = (ISOL_N===1'b0) ? {72{1'b1}}  : ( (ISOL_N===1'b1) ? T_BWE_N        : 'bx );
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
        assign T_BWE_N_INT[32]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[33]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[34]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[35]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[36]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[37]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[38]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[39]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[40]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[41]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[42]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[43]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[44]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[45]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[46]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[47]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[48]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[49]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[50]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[51]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[52]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[53]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[54]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[55]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[56]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[57]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[58]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[59]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[60]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[61]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[62]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[63]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[64]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[65]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[66]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[67]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[68]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[69]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[70]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[71]  =  T_BYWE_N[8] ;
      `else
        assign T_BWE_N_INT       = (ISOL_N===1'b0) ? {72{1'b1}}  : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
      `endif
    `endif
    `ifdef OUTPUT_ENABLE
      assign T_OE_N_INT    = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? T_OE_N       : 'bx );
    `else
      assign T_OE_N_INT    = 'b0;
    `endif
  `else
    assign T_BE_N_INT      = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? 'b1       : 'bx );
    assign T_CE_N_R_INT      = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? 'b1       : 'bx );
    assign T_CE_N_W_INT      = (ISOL_N===1'b0) ? 1'b1        : ( (ISOL_N===1'b1) ? 'b1       : 'bx );
    assign T_A_R_INT         = (ISOL_N===1'b0) ? {9{1'b0}}  : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign T_A_W_INT         = (ISOL_N===1'b0) ? {9{1'b0}}  : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign T_DI_INT        = (ISOL_N===1'b0) ? {72{1'b0}}  : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign T_BWE_N_INT     = (ISOL_N===1'b0) ? 'b1         : ( (ISOL_N===1'b1) ? 'b0          : 'bx );
    assign T_OE_N_INT      = 'b0;
  `endif
`else
  `ifdef CLKINV
    assign CLK_R_INT           = (condition_pwr2 || condition_pwr3) ? 0: ~CLK_R;
    assign CLK_W_INT           = (condition_pwr2 || condition_pwr3) ? 0: ~CLK_W;
  `else
    assign CLK_R_INT           = (condition_pwr2 || condition_pwr3) ? 0: CLK_R;
    assign CLK_W_INT           = (condition_pwr2 || condition_pwr3) ? 0: CLK_W;
  `endif
  assign CE_N_R_INT          = CE_N_R;
  assign CE_N_W_INT          = CE_N_W;
  assign A_R_INT             = A_R;
  assign A_W_INT             = A_W;
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
      assign BWE_N_INT[32]  =  BYWE_N[4] ;
      assign BWE_N_INT[33]  =  BYWE_N[4] ;
      assign BWE_N_INT[34]  =  BYWE_N[4] ;
      assign BWE_N_INT[35]  =  BYWE_N[4] ;
      assign BWE_N_INT[36]  =  BYWE_N[4] ;
      assign BWE_N_INT[37]  =  BYWE_N[4] ;
      assign BWE_N_INT[38]  =  BYWE_N[4] ;
      assign BWE_N_INT[39]  =  BYWE_N[4] ;
      assign BWE_N_INT[40]  =  BYWE_N[5] ;
      assign BWE_N_INT[41]  =  BYWE_N[5] ;
      assign BWE_N_INT[42]  =  BYWE_N[5] ;
      assign BWE_N_INT[43]  =  BYWE_N[5] ;
      assign BWE_N_INT[44]  =  BYWE_N[5] ;
      assign BWE_N_INT[45]  =  BYWE_N[5] ;
      assign BWE_N_INT[46]  =  BYWE_N[5] ;
      assign BWE_N_INT[47]  =  BYWE_N[5] ;
      assign BWE_N_INT[48]  =  BYWE_N[6] ;
      assign BWE_N_INT[49]  =  BYWE_N[6] ;
      assign BWE_N_INT[50]  =  BYWE_N[6] ;
      assign BWE_N_INT[51]  =  BYWE_N[6] ;
      assign BWE_N_INT[52]  =  BYWE_N[6] ;
      assign BWE_N_INT[53]  =  BYWE_N[6] ;
      assign BWE_N_INT[54]  =  BYWE_N[6] ;
      assign BWE_N_INT[55]  =  BYWE_N[6] ;
      assign BWE_N_INT[56]  =  BYWE_N[7] ;
      assign BWE_N_INT[57]  =  BYWE_N[7] ;
      assign BWE_N_INT[58]  =  BYWE_N[7] ;
      assign BWE_N_INT[59]  =  BYWE_N[7] ;
      assign BWE_N_INT[60]  =  BYWE_N[7] ;
      assign BWE_N_INT[61]  =  BYWE_N[7] ;
      assign BWE_N_INT[62]  =  BYWE_N[7] ;
      assign BWE_N_INT[63]  =  BYWE_N[7] ;
      assign BWE_N_INT[64]  =  BYWE_N[8] ;
      assign BWE_N_INT[65]  =  BYWE_N[8] ;
      assign BWE_N_INT[66]  =  BYWE_N[8] ;
      assign BWE_N_INT[67]  =  BYWE_N[8] ;
      assign BWE_N_INT[68]  =  BYWE_N[8] ;
      assign BWE_N_INT[69]  =  BYWE_N[8] ;
      assign BWE_N_INT[70]  =  BYWE_N[8] ;
      assign BWE_N_INT[71]  =  BYWE_N[8] ;
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
   assign T_RWM_R_INT       = T_RWM_R;
   assign T_RWM_W_INT       = T_RWM_W;
  `ifdef WRITE_ASSIST
    assign T_DLY_INT       = T_DLY;
  `else
    assign T_DLY_INT       = 'b0;
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
  `ifdef COL_RED
    assign CRAL_INT        = CRAL;
    assign CRAR_INT        = CRAR;
  `else
    assign CRAL_INT        = 'b0;
    assign CRAR_INT        = 'b0;
  `endif
  `ifdef BIST_TEST
    assign T_BE_N_INT      = T_BE_N;
    assign T_CE_N_R_INT      = T_CE_N_R;
    assign T_CE_N_W_INT      = T_CE_N_W;
    assign T_A_R_INT         = T_A_R;
    assign T_A_W_INT         = T_A_W;
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
        assign T_BWE_N_INT[32]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[33]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[34]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[35]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[36]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[37]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[38]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[39]  =  T_BYWE_N[4] ;
        assign T_BWE_N_INT[40]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[41]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[42]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[43]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[44]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[45]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[46]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[47]  =  T_BYWE_N[5] ;
        assign T_BWE_N_INT[48]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[49]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[50]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[51]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[52]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[53]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[54]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[55]  =  T_BYWE_N[6] ;
        assign T_BWE_N_INT[56]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[57]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[58]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[59]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[60]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[61]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[62]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[63]  =  T_BYWE_N[7] ;
        assign T_BWE_N_INT[64]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[65]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[66]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[67]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[68]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[69]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[70]  =  T_BYWE_N[8] ;
        assign T_BWE_N_INT[71]  =  T_BYWE_N[8] ;
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
    assign T_CE_N_R_INT      =  'b1;
    assign T_CE_N_W_INT      = 1'b1;
    assign T_A_R_INT         =  'b0;
    assign T_A_W_INT         =  'b0;
    assign T_DI_INT        = 'b0;
    assign T_BWE_N_INT     = 'b0;
    assign T_BYWE_N_INT    = 'b0;
    assign T_OE_N_INT      = 'b0;
  `endif
`endif
// Isolation block

always @(CLK_R_INT)
  begin 
    if((T_RWM_R_INT[0] == 0 && T_RWM_R_INT[1] == 0 && T_RWM_R_INT[2] == 0))  begin 
      $display("The Read Margin is set to %b%b%b which is NOT RECOMMENDED. This may cause Functional and Speed problems - Please Verify your settings", T_RWM_R[2], T_RWM_R[1], T_RWM_R[0]);
      $display("The DEFAULT and RECOMMENDED SETTING for Read Margin is 011");
    end 
    if((T_RWM_R_INT[0] == 1 && T_RWM_R_INT[1] == 0 && T_RWM_R_INT[2] == 0))  begin 
      $display("The Read Margin is set to %b%b%b which is NOT RECOMMENDED. This may cause Functional and Speed problems - Please Verify your settings", T_RWM_R[2], T_RWM_R[1], T_RWM_R[0]);
      $display("The DEFAULT and RECOMMENDED SETTING for Read Margin is 011");
    end 
    if((T_RWM_R_INT[0] == 0 && T_RWM_R_INT[1] == 1 && T_RWM_R_INT[2] == 0))  begin 
      $display("The Read Margin is set to %b%b%b which is NOT RECOMMENDED. This may cause Functional and Speed problems - Please Verify your settings", T_RWM_R[2], T_RWM_R[1], T_RWM_R[0]);
      $display("The DEFAULT and RECOMMENDED SETTING for Read Margin is 011");
    end 
 end 

always @(CLK_W_INT)
  begin 
    if((T_RWM_W_INT[0] == 0 && T_RWM_W_INT[1] == 0 && T_RWM_W_INT[2] == 0))  begin 
      $display("The Write Margin is set to %b%b%b which is NOT RECOMMENDED. This may cause Functional and Speed problems - Please Verify your settings", T_RWM_W[2], T_RWM_W[1], T_RWM_W[0]);
      $display("The DEFAULT and RECOMMENDED SETTING for Write Margin is 011");
    end 
    if((T_RWM_W_INT[0] == 1 && T_RWM_W_INT[1] == 0 && T_RWM_W_INT[2] == 0))  begin 
      $display("The Write Margin is set to %b%b%b which is NOT RECOMMENDED. This may cause Functional and Speed problems - Please Verify your settings", T_RWM_W[2], T_RWM_W[1], T_RWM_W[0]);
      $display("The DEFAULT and RECOMMENDED SETTING for Write Margin is 011");
    end 
    if((T_RWM_W_INT[0] == 0 && T_RWM_W_INT[1] == 1 && T_RWM_W_INT[2] == 0))  begin 
      $display("The Write Margin is set to %b%b%b which is NOT RECOMMENDED. This may cause Functional and Speed problems - Please Verify your settings", T_RWM_W[2], T_RWM_W[1], T_RWM_W[0]);
      $display("The DEFAULT and RECOMMENDED SETTING for Write Margin is 011");
    end 
end 
assign condition_pwr0 = !LOLEAK_N_INT &&  LKRB_N_INT &&  P_PWS_N_INT &&  COREPWS_N_INT;
assign condition_pwr1 = !LOLEAK_N_INT && !LKRB_N_INT &&  P_PWS_N_INT &&  COREPWS_N_INT;
assign condition_pwr2 = !LOLEAK_N_INT && !LKRB_N_INT && !P_PWS_N_INT &&  COREPWS_N_INT;
assign condition_pwr3 = !LOLEAK_N_INT && !LKRB_N_INT && !P_PWS_N_INT && !COREPWS_N_INT;
always @(posedge CLK_R_INT) 
  begin
    if(ok_read) begin
    `ifdef COLLISION
      begin
        inRead <= T_BE_N_INT ? (!CE_N_R_INT) : (!T_CE_N_R_INT);
        #0.4111 inRead <= 1'd0;
      end
    `else
      inRead <= 1'b1;
    `endif
   end
  end
always @(posedge CLK_W_INT) 
  begin
    if(ok_wr) begin
    `ifdef COLLISION
      begin
        inWrite <= T_BE_N_INT ? (!CE_N_W_INT) : (!T_CE_N_W_INT);
        #0.4111 inWrite <= 1'd0;
      end
    `else
      inWrite <= 1'b1;
    `endif
   end
  end

always @(posedge CLK_R_INT) begin
  read_flag <= 1'b1;
end

always @(posedge CLK_R_INT) begin 
  if(COREPWS_N_INT && P_PWS_N_INT) begin
    CE_N_R_R <= T_BE_N_INT ? CE_N_R_INT : T_CE_N_R_INT;
    Address_R_R <= (condition_pwr0 || condition_pwr1) ? 11'bx : T_BE_N_INT ? A_R_INT : T_A_R_INT;
    if(!(T_BE_N_INT ? CE_N_R_INT : T_CE_N_R_INT)) begin
      if((T_BE_N_INT ? A_R_INT : T_A_R_INT) >= 576)
        $display("%m Read Address:%h  is out of bounds",(T_BE_N_INT ? A_R_INT : T_A_R_INT));
     end
  end
end

always @(posedge CLK_W_INT) begin 
  if(COREPWS_N_INT && P_PWS_N_INT) begin
    CE_N_R_W <= T_BE_N_INT ? CE_N_W_INT : T_CE_N_W_INT;
    Address_R_W <= (condition_pwr0 || condition_pwr1) ? 11'bx : T_BE_N_INT ? A_W_INT : T_A_W_INT;
    We_R      <= T_BE_N_INT ? ~BWE_N_INT : ~T_BWE_N_INT;
    if(!(T_BE_N_INT ? CE_N_W_INT : T_CE_N_W_INT)) begin
      if((T_BE_N_INT ? A_W_INT : T_A_W_INT) >= 576)
        $display("%m Write Address:%h  is out of bounds",(T_BE_N_INT ? A_W_INT : T_A_W_INT));
    end
    DataIn_R_W  <= #0.001 T_BE_N_INT ? DI_INT : T_DI_INT;
  end
end

always @(Address_R_W or CE_N_R_W or DataIn_R_W or We_R or COREPWS_N_INT or P_PWS_N_INT) begin 
if(COREPWS_N_INT && P_PWS_N_INT) begin
 if(ok_wr) begin
  if(^Address_R_W === 1'bx || ^We_R === 1'bx || CE_N_R_W === 1'bx) begin
    if(!CE_N_R_W || CE_N_R_W === 1'bx) begin
      if(^Address_R_W === 1'bx) begin
        for(j=0; j<576; j=j+1) begin
          tmpDataIn_R = memArray[j];
          for(i=0; i<72; i=i+1) begin
            if(We_R[i] === 1'bx || We_R[i])
              tmpDataIn_R[i] = 1'bx;
          end
          memArray[j] = tmpDataIn_R;
        end
      end
      else begin
        if(CE_N_R_W === 1'bx) begin
          tmpDataIn_R = memArray[Address_R_W];
          for(i=0; i<72; i=i+1) begin
            if(We_R[i] === 1'bx || We_R[i])
              tmpDataIn_R[i] = 1'bx;
          end
          memArray[Address_R_W] = tmpDataIn_R;
        end
      end
    end
  end
  else begin
    if(!CE_N_R_W) begin
      tmpDataIn_R = memArray[Address_R_W];
      for(i=0; i<72; i=i+1) begin
        if(We_R[i])
          tmpDataIn_R[i] = DataIn_R_W[i];
      end
      memArray[Address_R_W] = tmpDataIn_R;
    end
  end
 end
end 
else 
     if(!COREPWS_N_INT) begin
 // Initializing Memory Array to x 
         for (m=0; m<576; m=m+1) begin 
         memArray[m] = 72'bx; 
        end 
   end 

end

always @(Address_R_R or CE_N_R_R or Address_R_W or CE_N_R_W or posedge inRead or posedge inWrite or posedge read_flag or COREPWS_N_INT or P_PWS_N_INT) begin
  if(COREPWS_N_INT && P_PWS_N_INT) begin
    if(ok_read) begin 
      coll_sig = inWrite & inRead;
      if((!CE_N_R_R && (^Address_R_R === 1'bx)) || (CE_N_R_R === 1'bx)) begin 
        Dout = 72'bx;
      end
      else if(!CE_N_R_R && (!CE_N_R_W || (CE_N_R_W === 1'bx)) && (((Address_R_W == Address_R_R) && coll_sig) || (^Address_R_W === 1'bx)))  begin
        Dout = (COREPWS_N_INT && P_PWS_N_INT) ? memArray[Address_R_R]: 72'bx;
        for(k=0; k<72; k=k+1) begin
          if((We_R[k]) || (We_R[k] === 1'bx))
            Dout[k] = 1'bx;
        end
      end
      else if(!CE_N_R_R && (CE_N_R_W || !((Address_R_W == Address_R_R) && coll_sig)) && read_flag) begin 
        Dout = (COREPWS_N_INT && P_PWS_N_INT) ? memArray[Address_R_R]: 72'bx;
      end
      read_flag = 1'b0;
    end
  end
end
assign Dout_R_INT = ((COREPWS_N_INT===1'bx) || (P_PWS_N_INT===1'bx)) ? 72'bx : (((COREPWS_N_INT===1'b0) || (P_PWS_N_INT===1'b0)) ? 72'b0 : Dout);
assign DO_temp = T_AWT_N_INT ?  Dout_R_INT : (T_BE_N_INT ? DI_INT : T_DI_INT);
assign cntrl = (T_BE_N_INT ? OE_N_INT : T_OE_N_INT) ? 1'b1 : 1'b0;
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
bufif0(DO[32], DO_temp[32], cntrl);
bufif0(DO[33], DO_temp[33], cntrl);
bufif0(DO[34], DO_temp[34], cntrl);
bufif0(DO[35], DO_temp[35], cntrl);
bufif0(DO[36], DO_temp[36], cntrl);
bufif0(DO[37], DO_temp[37], cntrl);
bufif0(DO[38], DO_temp[38], cntrl);
bufif0(DO[39], DO_temp[39], cntrl);
bufif0(DO[40], DO_temp[40], cntrl);
bufif0(DO[41], DO_temp[41], cntrl);
bufif0(DO[42], DO_temp[42], cntrl);
bufif0(DO[43], DO_temp[43], cntrl);
bufif0(DO[44], DO_temp[44], cntrl);
bufif0(DO[45], DO_temp[45], cntrl);
bufif0(DO[46], DO_temp[46], cntrl);
bufif0(DO[47], DO_temp[47], cntrl);
bufif0(DO[48], DO_temp[48], cntrl);
bufif0(DO[49], DO_temp[49], cntrl);
bufif0(DO[50], DO_temp[50], cntrl);
bufif0(DO[51], DO_temp[51], cntrl);
bufif0(DO[52], DO_temp[52], cntrl);
bufif0(DO[53], DO_temp[53], cntrl);
bufif0(DO[54], DO_temp[54], cntrl);
bufif0(DO[55], DO_temp[55], cntrl);
bufif0(DO[56], DO_temp[56], cntrl);
bufif0(DO[57], DO_temp[57], cntrl);
bufif0(DO[58], DO_temp[58], cntrl);
bufif0(DO[59], DO_temp[59], cntrl);
bufif0(DO[60], DO_temp[60], cntrl);
bufif0(DO[61], DO_temp[61], cntrl);
bufif0(DO[62], DO_temp[62], cntrl);
bufif0(DO[63], DO_temp[63], cntrl);
bufif0(DO[64], DO_temp[64], cntrl);
bufif0(DO[65], DO_temp[65], cntrl);
bufif0(DO[66], DO_temp[66], cntrl);
bufif0(DO[67], DO_temp[67], cntrl);
bufif0(DO[68], DO_temp[68], cntrl);
bufif0(DO[69], DO_temp[69], cntrl);
bufif0(DO[70], DO_temp[70], cntrl);
bufif0(DO[71], DO_temp[71], cntrl);


wire condition11 ;
wire condition12 ;
wire condition13 ;
wire condition14 ;
wire condition15 ;
wire condition1 ;
wire condition2 ;
wire condition3 ;
wire condition4 ;
wire condition5 ;
wire condition6 ;
wire condition7 ;
wire condition8 ;
wire condition9 ;
wire condition10 ;
assign condition1 = ((!CE_N_R && T_BE_N) || (!T_CE_N_R && !T_BE_N)) ;
assign condition2 = (!T_CE_N_R && !T_BE_N) ;
assign condition3 = (!CE_N_R && T_BE_N) ;
assign condition4 = ((!CE_N_W && T_BE_N) || (!T_CE_N_W && !T_BE_N)) ;
assign condition5 = (!T_CE_N_W && !T_BE_N) ;
assign condition6 = (!CE_N_W && T_BE_N) ;
assign condition7 = (T_BE_N) ;
assign condition8 = (!T_BE_N) ;
assign condition9 = (T_BE_N) ;
assign condition10 = (!T_BE_N) ;

assign condition11 = (CE_N_R) ;
assign condition12 = (!CE_N_R) ;
assign condition13 = (CE_N_W) ;
assign condition14 = (!CE_N_W) ;
assign condition15 = ((Address_R_W == Address_R_R) && coll_sig) && (^Address_R_W != 1'bx);
wire timing_condition_margin_r_0;
wire timing_condition_margin_w_0;
wire timing_condition_margin_r_1;
wire timing_condition_margin_w_1;
wire timing_condition_margin_r_2;
wire timing_condition_margin_w_2;
wire timing_condition_margin_r_3;
wire timing_condition_margin_w_3;
wire timing_condition_margin_r_4;
wire timing_condition_margin_w_4;
wire timing_condition_margin_r_5;
wire timing_condition_margin_w_5;
wire timing_condition_margin_r_6;
wire timing_condition_margin_w_6;
wire timing_condition_margin_r_7;
wire timing_condition_margin_w_7;
assign timing_condition_margin_r_0 = (T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0) ;
assign timing_condition_margin_w_0 = (T_RWM_W[0] == 0 && T_RWM_W[1] == 0 && T_RWM_W[2] == 0) ;
assign timing_condition_margin_r_1 = (T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0) ;
assign timing_condition_margin_w_1 = (T_RWM_W[0] == 1 && T_RWM_W[1] == 0 && T_RWM_W[2] == 0) ;
assign timing_condition_margin_r_2 = (T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0) ;
assign timing_condition_margin_w_2 = (T_RWM_W[0] == 0 && T_RWM_W[1] == 1 && T_RWM_W[2] == 0) ;
assign timing_condition_margin_r_3 = (T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0) ;
assign timing_condition_margin_w_3 = (T_RWM_W[0] == 1 && T_RWM_W[1] == 1 && T_RWM_W[2] == 0) ;
assign timing_condition_margin_r_4 = (T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1) ;
assign timing_condition_margin_w_4 = (T_RWM_W[0] == 0 && T_RWM_W[1] == 0 && T_RWM_W[2] == 1) ;
assign timing_condition_margin_r_5 = (T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1) ;
assign timing_condition_margin_w_5 = (T_RWM_W[0] == 1 && T_RWM_W[1] == 0 && T_RWM_W[2] == 1) ;
assign timing_condition_margin_r_6 = (T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1) ;
assign timing_condition_margin_w_6 = (T_RWM_W[0] == 0 && T_RWM_W[1] == 1 && T_RWM_W[2] == 1) ;
assign timing_condition_margin_r_7 = (T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1) ;
assign timing_condition_margin_w_7 = (T_RWM_W[0] == 1 && T_RWM_W[1] == 1 && T_RWM_W[2] == 1) ;

specify
 specparam
  period_param_0 = 0.3523,
  period_param_1 = 0.3712,
  period_param_2 = 0.3921,
  period_param_3 = 0.4111,
  period_param_4 = 0.4515,
  period_param_5 = 0.4701,
  period_param_6 = 0.4914,
  period_param_7 = 0.5104,
  trise_CLK_R_DO_worst = 0.3448, 
  tfall_CLK_R_DO_worst = 0.3437, 
  trise_CLK_R_DO_worst_0 = 0.2860, 
  tfall_CLK_R_DO_worst_0 = 0.2848, 
  trise_CLK_R_DO_worst_1 = 0.3049, 
  tfall_CLK_R_DO_worst_1 = 0.3037, 
  trise_CLK_R_DO_worst_2 = 0.3258, 
  tfall_CLK_R_DO_worst_2 = 0.3246, 
  trise_CLK_R_DO_worst_3 = 0.3448, 
  tfall_CLK_R_DO_worst_3 = 0.3437, 
  trise_CLK_R_DO_worst_4 = 0.3852, 
  tfall_CLK_R_DO_worst_4 = 0.3840, 
  trise_CLK_R_DO_worst_5 = 0.4037, 
  tfall_CLK_R_DO_worst_5 = 0.4026, 
  trise_CLK_R_DO_worst_6 = 0.4251, 
  tfall_CLK_R_DO_worst_6 = 0.4239, 
  trise_CLK_R_DO_worst_7 = 0.4440, 
  tfall_CLK_R_DO_worst_7 = 0.4429, 
  t_T_RWM_R_setup_worst = 0.0930,
  t_T_RWM_W_setup_worst = 0.0930,
  t_T_RWM_R_hold_worst  = 0.4111,
  t_T_RWM_W_hold_worst  = 0.4111,
  t_A_R_setup_worst = 0.1093,
  t_A_W_setup_worst = 0.1093,
  t_A_R_hold_worst  = 0.0341,
  t_A_W_hold_worst  = 0.0341,
  t_DI_setup_worst = 0.0194,
  t_DI_hold_worst  = 0.1653,
  t_BWE_N_setup_worst = 0.0194,
  t_BWE_N_hold_worst  = 0.1653,
  t_T_BE_N_setup_worst = 2.0680,
  t_T_BE_N_hold_worst  = 0.4111,
  t_T_A_R_setup_worst = 0.1457,
  t_T_A_W_setup_worst = 0.1457,
  t_T_A_R_hold_worst  = 0.0093,
  t_T_A_W_hold_worst  = 0.0093,
  t_T_DI_setup_worst = 0.0271,
  t_T_DI_hold_worst  = 0.1585,
  t_T_CE_N_R_setup_worst = 0.1717,
  t_T_CE_N_W_setup_worst = 0.1717,
  t_T_CE_N_R_hold_worst  = 0.0425,
  t_T_CE_N_W_hold_worst  = 0.0425,
  t_T_BWE_N_setup_worst = 0.0271,
  t_T_BWE_N_hold_worst  = 0.1585,
  t_CE_N_R_setup_worst = 0.1273,
  t_CE_N_W_setup_worst = 0.1273,
  t_CE_N_R_hold_worst  = 0.0520,
  t_CE_N_W_hold_worst  = 0.0520;
  $period(posedge CLK_R &&& timing_condition_margin_r_0, period_param_0);
  $period(posedge CLK_R &&& timing_condition_margin_r_1, period_param_1);
  $period(posedge CLK_R &&& timing_condition_margin_r_2, period_param_2);
  $period(posedge CLK_R &&& timing_condition_margin_r_3, period_param_3);
  $period(posedge CLK_R &&& timing_condition_margin_r_4, period_param_4);
  $period(posedge CLK_R &&& timing_condition_margin_r_5, period_param_5);
  $period(posedge CLK_R &&& timing_condition_margin_r_6, period_param_6);
  $period(posedge CLK_R &&& timing_condition_margin_r_7, period_param_7);
  $period(posedge CLK_W &&& timing_condition_margin_w_0, period_param_0);
  $period(posedge CLK_W &&& timing_condition_margin_w_1, period_param_1);
  $period(posedge CLK_W &&& timing_condition_margin_w_2, period_param_2);
  $period(posedge CLK_W &&& timing_condition_margin_w_3, period_param_3);
  $period(posedge CLK_W &&& timing_condition_margin_w_4, period_param_4);
  $period(posedge CLK_W &&& timing_condition_margin_w_5, period_param_5);
  $period(posedge CLK_W &&& timing_condition_margin_w_6, period_param_6);
  $period(posedge CLK_W &&& timing_condition_margin_w_7, period_param_7);
  $width(posedge CLK_R, 0.08522);
  $width(negedge CLK_R, 0.18656);
  $width(posedge CLK_W, 0.08522);
  $width(negedge CLK_W, 0.18656);
  /*Specify timing in collision case*/
  $recrem ( posedge CLK_R,posedge CLK_W  &&& condition15, period_param_3, 0,,,,,);
  $recrem ( posedge CLK_W,posedge CLK_R  &&& condition15, period_param_3, 0,,,,,);
  /*The default setting corresponds to T_RWM == 3'd3*/
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[0] +: DI[0])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[1] +: DI[1])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[2] +: DI[2])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[3] +: DI[3])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[4] +: DI[4])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[5] +: DI[5])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[6] +: DI[6])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[7] +: DI[7])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[8] +: DI[8])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[9] +: DI[9])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[10] +: DI[10])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[11] +: DI[11])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[12] +: DI[12])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[13] +: DI[13])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[14] +: DI[14])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[15] +: DI[15])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[16] +: DI[16])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[17] +: DI[17])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[18] +: DI[18])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[19] +: DI[19])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[20] +: DI[20])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[21] +: DI[21])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[22] +: DI[22])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[23] +: DI[23])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[24] +: DI[24])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[25] +: DI[25])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[26] +: DI[26])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[27] +: DI[27])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[28] +: DI[28])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[29] +: DI[29])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[30] +: DI[30])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[31] +: DI[31])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[32] +: DI[32])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[33] +: DI[33])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[34] +: DI[34])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[35] +: DI[35])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[36] +: DI[36])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[37] +: DI[37])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[38] +: DI[38])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[39] +: DI[39])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[40] +: DI[40])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[41] +: DI[41])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[42] +: DI[42])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[43] +: DI[43])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[44] +: DI[44])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[45] +: DI[45])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[46] +: DI[46])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[47] +: DI[47])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[48] +: DI[48])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[49] +: DI[49])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[50] +: DI[50])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[51] +: DI[51])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[52] +: DI[52])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[53] +: DI[53])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[54] +: DI[54])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[55] +: DI[55])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[56] +: DI[56])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[57] +: DI[57])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[58] +: DI[58])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[59] +: DI[59])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[60] +: DI[60])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[61] +: DI[61])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[62] +: DI[62])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[63] +: DI[63])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[64] +: DI[64])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[65] +: DI[65])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[66] +: DI[66])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[67] +: DI[67])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[68] +: DI[68])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[69] +: DI[69])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[70] +: DI[70])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[71] +: DI[71])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[0] +: DI[0])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[1] +: DI[1])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[2] +: DI[2])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[3] +: DI[3])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[4] +: DI[4])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[5] +: DI[5])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[6] +: DI[6])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[7] +: DI[7])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[8] +: DI[8])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[9] +: DI[9])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[10] +: DI[10])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[11] +: DI[11])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[12] +: DI[12])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[13] +: DI[13])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[14] +: DI[14])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[15] +: DI[15])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[16] +: DI[16])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[17] +: DI[17])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[18] +: DI[18])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[19] +: DI[19])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[20] +: DI[20])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[21] +: DI[21])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[22] +: DI[22])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[23] +: DI[23])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[24] +: DI[24])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[25] +: DI[25])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[26] +: DI[26])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[27] +: DI[27])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[28] +: DI[28])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[29] +: DI[29])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[30] +: DI[30])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[31] +: DI[31])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[32] +: DI[32])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[33] +: DI[33])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[34] +: DI[34])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[35] +: DI[35])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[36] +: DI[36])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[37] +: DI[37])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[38] +: DI[38])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[39] +: DI[39])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[40] +: DI[40])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[41] +: DI[41])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[42] +: DI[42])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[43] +: DI[43])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[44] +: DI[44])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[45] +: DI[45])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[46] +: DI[46])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[47] +: DI[47])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[48] +: DI[48])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[49] +: DI[49])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[50] +: DI[50])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[51] +: DI[51])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[52] +: DI[52])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[53] +: DI[53])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[54] +: DI[54])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[55] +: DI[55])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[56] +: DI[56])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[57] +: DI[57])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[58] +: DI[58])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[59] +: DI[59])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[60] +: DI[60])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[61] +: DI[61])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[62] +: DI[62])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[63] +: DI[63])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[64] +: DI[64])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[65] +: DI[65])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[66] +: DI[66])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[67] +: DI[67])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[68] +: DI[68])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[69] +: DI[69])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[70] +: DI[70])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[71] +: DI[71])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[0] +: DI[0])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[1] +: DI[1])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[2] +: DI[2])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[3] +: DI[3])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[4] +: DI[4])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[5] +: DI[5])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[6] +: DI[6])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[7] +: DI[7])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[8] +: DI[8])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[9] +: DI[9])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[10] +: DI[10])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[11] +: DI[11])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[12] +: DI[12])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[13] +: DI[13])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[14] +: DI[14])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[15] +: DI[15])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[16] +: DI[16])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[17] +: DI[17])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[18] +: DI[18])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[19] +: DI[19])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[20] +: DI[20])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[21] +: DI[21])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[22] +: DI[22])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[23] +: DI[23])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[24] +: DI[24])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[25] +: DI[25])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[26] +: DI[26])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[27] +: DI[27])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[28] +: DI[28])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[29] +: DI[29])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[30] +: DI[30])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[31] +: DI[31])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[32] +: DI[32])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[33] +: DI[33])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[34] +: DI[34])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[35] +: DI[35])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[36] +: DI[36])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[37] +: DI[37])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[38] +: DI[38])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[39] +: DI[39])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[40] +: DI[40])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[41] +: DI[41])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[42] +: DI[42])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[43] +: DI[43])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[44] +: DI[44])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[45] +: DI[45])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[46] +: DI[46])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[47] +: DI[47])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[48] +: DI[48])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[49] +: DI[49])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[50] +: DI[50])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[51] +: DI[51])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[52] +: DI[52])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[53] +: DI[53])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[54] +: DI[54])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[55] +: DI[55])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[56] +: DI[56])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[57] +: DI[57])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[58] +: DI[58])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[59] +: DI[59])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[60] +: DI[60])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[61] +: DI[61])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[62] +: DI[62])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[63] +: DI[63])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[64] +: DI[64])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[65] +: DI[65])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[66] +: DI[66])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[67] +: DI[67])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[68] +: DI[68])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[69] +: DI[69])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[70] +: DI[70])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[71] +: DI[71])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[0] +: DI[0])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[1] +: DI[1])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[2] +: DI[2])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[3] +: DI[3])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[4] +: DI[4])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[5] +: DI[5])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[6] +: DI[6])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[7] +: DI[7])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[8] +: DI[8])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[9] +: DI[9])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[10] +: DI[10])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[11] +: DI[11])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[12] +: DI[12])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[13] +: DI[13])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[14] +: DI[14])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[15] +: DI[15])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[16] +: DI[16])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[17] +: DI[17])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[18] +: DI[18])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[19] +: DI[19])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[20] +: DI[20])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[21] +: DI[21])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[22] +: DI[22])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[23] +: DI[23])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[24] +: DI[24])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[25] +: DI[25])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[26] +: DI[26])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[27] +: DI[27])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[28] +: DI[28])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[29] +: DI[29])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[30] +: DI[30])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[31] +: DI[31])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[32] +: DI[32])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[33] +: DI[33])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[34] +: DI[34])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[35] +: DI[35])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[36] +: DI[36])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[37] +: DI[37])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[38] +: DI[38])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[39] +: DI[39])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[40] +: DI[40])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[41] +: DI[41])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[42] +: DI[42])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[43] +: DI[43])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[44] +: DI[44])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[45] +: DI[45])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[46] +: DI[46])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[47] +: DI[47])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[48] +: DI[48])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[49] +: DI[49])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[50] +: DI[50])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[51] +: DI[51])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[52] +: DI[52])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[53] +: DI[53])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[54] +: DI[54])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[55] +: DI[55])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[56] +: DI[56])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[57] +: DI[57])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[58] +: DI[58])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[59] +: DI[59])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[60] +: DI[60])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[61] +: DI[61])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[62] +: DI[62])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[63] +: DI[63])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[64] +: DI[64])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[65] +: DI[65])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[66] +: DI[66])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[67] +: DI[67])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[68] +: DI[68])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[69] +: DI[69])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[70] +: DI[70])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 1) 
  (posedge CLK_R => (DO[71] +: DI[71])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[0] +: DI[0])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[1] +: DI[1])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[2] +: DI[2])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[3] +: DI[3])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[4] +: DI[4])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[5] +: DI[5])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[6] +: DI[6])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[7] +: DI[7])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[8] +: DI[8])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[9] +: DI[9])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[10] +: DI[10])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[11] +: DI[11])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[12] +: DI[12])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[13] +: DI[13])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[14] +: DI[14])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[15] +: DI[15])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[16] +: DI[16])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[17] +: DI[17])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[18] +: DI[18])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[19] +: DI[19])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[20] +: DI[20])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[21] +: DI[21])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[22] +: DI[22])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[23] +: DI[23])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[24] +: DI[24])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[25] +: DI[25])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[26] +: DI[26])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[27] +: DI[27])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[28] +: DI[28])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[29] +: DI[29])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[30] +: DI[30])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[31] +: DI[31])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[32] +: DI[32])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[33] +: DI[33])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[34] +: DI[34])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[35] +: DI[35])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[36] +: DI[36])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[37] +: DI[37])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[38] +: DI[38])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[39] +: DI[39])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[40] +: DI[40])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[41] +: DI[41])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[42] +: DI[42])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[43] +: DI[43])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[44] +: DI[44])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[45] +: DI[45])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[46] +: DI[46])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[47] +: DI[47])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[48] +: DI[48])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[49] +: DI[49])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[50] +: DI[50])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[51] +: DI[51])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[52] +: DI[52])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[53] +: DI[53])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[54] +: DI[54])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[55] +: DI[55])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[56] +: DI[56])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[57] +: DI[57])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[58] +: DI[58])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[59] +: DI[59])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[60] +: DI[60])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[61] +: DI[61])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[62] +: DI[62])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[63] +: DI[63])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[64] +: DI[64])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[65] +: DI[65])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[66] +: DI[66])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[67] +: DI[67])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[68] +: DI[68])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[69] +: DI[69])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[70] +: DI[70])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[71] +: DI[71])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[0] +: DI[0])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[1] +: DI[1])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[2] +: DI[2])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[3] +: DI[3])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[4] +: DI[4])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[5] +: DI[5])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[6] +: DI[6])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[7] +: DI[7])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[8] +: DI[8])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[9] +: DI[9])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[10] +: DI[10])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[11] +: DI[11])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[12] +: DI[12])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[13] +: DI[13])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[14] +: DI[14])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[15] +: DI[15])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[16] +: DI[16])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[17] +: DI[17])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[18] +: DI[18])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[19] +: DI[19])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[20] +: DI[20])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[21] +: DI[21])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[22] +: DI[22])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[23] +: DI[23])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[24] +: DI[24])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[25] +: DI[25])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[26] +: DI[26])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[27] +: DI[27])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[28] +: DI[28])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[29] +: DI[29])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[30] +: DI[30])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[31] +: DI[31])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[32] +: DI[32])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[33] +: DI[33])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[34] +: DI[34])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[35] +: DI[35])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[36] +: DI[36])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[37] +: DI[37])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[38] +: DI[38])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[39] +: DI[39])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[40] +: DI[40])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[41] +: DI[41])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[42] +: DI[42])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[43] +: DI[43])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[44] +: DI[44])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[45] +: DI[45])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[46] +: DI[46])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[47] +: DI[47])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[48] +: DI[48])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[49] +: DI[49])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[50] +: DI[50])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[51] +: DI[51])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[52] +: DI[52])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[53] +: DI[53])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[54] +: DI[54])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[55] +: DI[55])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[56] +: DI[56])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[57] +: DI[57])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[58] +: DI[58])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[59] +: DI[59])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[60] +: DI[60])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[61] +: DI[61])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[62] +: DI[62])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[63] +: DI[63])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[64] +: DI[64])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[65] +: DI[65])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[66] +: DI[66])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[67] +: DI[67])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[68] +: DI[68])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[69] +: DI[69])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[70] +: DI[70])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[71] +: DI[71])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[0] +: DI[0])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[1] +: DI[1])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[2] +: DI[2])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[3] +: DI[3])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[4] +: DI[4])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[5] +: DI[5])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[6] +: DI[6])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[7] +: DI[7])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[8] +: DI[8])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[9] +: DI[9])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[10] +: DI[10])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[11] +: DI[11])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[12] +: DI[12])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[13] +: DI[13])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[14] +: DI[14])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[15] +: DI[15])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[16] +: DI[16])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[17] +: DI[17])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[18] +: DI[18])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[19] +: DI[19])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[20] +: DI[20])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[21] +: DI[21])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[22] +: DI[22])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[23] +: DI[23])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[24] +: DI[24])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[25] +: DI[25])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[26] +: DI[26])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[27] +: DI[27])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[28] +: DI[28])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[29] +: DI[29])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[30] +: DI[30])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[31] +: DI[31])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[32] +: DI[32])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[33] +: DI[33])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[34] +: DI[34])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[35] +: DI[35])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[36] +: DI[36])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[37] +: DI[37])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[38] +: DI[38])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[39] +: DI[39])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[40] +: DI[40])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[41] +: DI[41])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[42] +: DI[42])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[43] +: DI[43])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[44] +: DI[44])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[45] +: DI[45])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[46] +: DI[46])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[47] +: DI[47])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[48] +: DI[48])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[49] +: DI[49])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[50] +: DI[50])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[51] +: DI[51])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[52] +: DI[52])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[53] +: DI[53])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[54] +: DI[54])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[55] +: DI[55])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[56] +: DI[56])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[57] +: DI[57])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[58] +: DI[58])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[59] +: DI[59])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[60] +: DI[60])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[61] +: DI[61])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[62] +: DI[62])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[63] +: DI[63])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[64] +: DI[64])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[65] +: DI[65])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[66] +: DI[66])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[67] +: DI[67])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[68] +: DI[68])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[69] +: DI[69])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[70] +: DI[70])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[71] +: DI[71])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[0] +: DI[0])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[1] +: DI[1])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[2] +: DI[2])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[3] +: DI[3])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[4] +: DI[4])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[5] +: DI[5])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[6] +: DI[6])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[7] +: DI[7])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[8] +: DI[8])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[9] +: DI[9])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[10] +: DI[10])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[11] +: DI[11])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[12] +: DI[12])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[13] +: DI[13])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[14] +: DI[14])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[15] +: DI[15])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[16] +: DI[16])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[17] +: DI[17])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[18] +: DI[18])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[19] +: DI[19])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[20] +: DI[20])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[21] +: DI[21])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[22] +: DI[22])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[23] +: DI[23])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[24] +: DI[24])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[25] +: DI[25])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[26] +: DI[26])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[27] +: DI[27])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[28] +: DI[28])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[29] +: DI[29])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[30] +: DI[30])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[31] +: DI[31])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[32] +: DI[32])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[33] +: DI[33])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[34] +: DI[34])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[35] +: DI[35])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[36] +: DI[36])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[37] +: DI[37])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[38] +: DI[38])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[39] +: DI[39])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[40] +: DI[40])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[41] +: DI[41])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[42] +: DI[42])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[43] +: DI[43])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[44] +: DI[44])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[45] +: DI[45])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[46] +: DI[46])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[47] +: DI[47])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[48] +: DI[48])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[49] +: DI[49])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[50] +: DI[50])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[51] +: DI[51])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[52] +: DI[52])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[53] +: DI[53])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[54] +: DI[54])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[55] +: DI[55])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[56] +: DI[56])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[57] +: DI[57])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[58] +: DI[58])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[59] +: DI[59])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[60] +: DI[60])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[61] +: DI[61])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[62] +: DI[62])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[63] +: DI[63])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[64] +: DI[64])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[65] +: DI[65])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[66] +: DI[66])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[67] +: DI[67])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[68] +: DI[68])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[69] +: DI[69])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[70] +: DI[70])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 1) 
  (posedge CLK_R => (DO[71] +: DI[71])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[0] +: T_DI[0])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[1] +: T_DI[1])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[2] +: T_DI[2])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[3] +: T_DI[3])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[4] +: T_DI[4])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[5] +: T_DI[5])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[6] +: T_DI[6])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[7] +: T_DI[7])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[8] +: T_DI[8])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[9] +: T_DI[9])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[10] +: T_DI[10])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[11] +: T_DI[11])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[12] +: T_DI[12])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[13] +: T_DI[13])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[14] +: T_DI[14])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[15] +: T_DI[15])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[16] +: T_DI[16])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[17] +: T_DI[17])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[18] +: T_DI[18])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[19] +: T_DI[19])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[20] +: T_DI[20])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[21] +: T_DI[21])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[22] +: T_DI[22])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[23] +: T_DI[23])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[24] +: T_DI[24])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[25] +: T_DI[25])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[26] +: T_DI[26])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[27] +: T_DI[27])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[28] +: T_DI[28])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[29] +: T_DI[29])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[30] +: T_DI[30])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[31] +: T_DI[31])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[32] +: T_DI[32])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[33] +: T_DI[33])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[34] +: T_DI[34])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[35] +: T_DI[35])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[36] +: T_DI[36])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[37] +: T_DI[37])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[38] +: T_DI[38])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[39] +: T_DI[39])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[40] +: T_DI[40])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[41] +: T_DI[41])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[42] +: T_DI[42])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[43] +: T_DI[43])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[44] +: T_DI[44])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[45] +: T_DI[45])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[46] +: T_DI[46])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[47] +: T_DI[47])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[48] +: T_DI[48])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[49] +: T_DI[49])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[50] +: T_DI[50])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[51] +: T_DI[51])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[52] +: T_DI[52])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[53] +: T_DI[53])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[54] +: T_DI[54])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[55] +: T_DI[55])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[56] +: T_DI[56])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[57] +: T_DI[57])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[58] +: T_DI[58])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[59] +: T_DI[59])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[60] +: T_DI[60])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[61] +: T_DI[61])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[62] +: T_DI[62])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[63] +: T_DI[63])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[64] +: T_DI[64])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[65] +: T_DI[65])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[66] +: T_DI[66])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[67] +: T_DI[67])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[68] +: T_DI[68])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[69] +: T_DI[69])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[70] +: T_DI[70])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[71] +: T_DI[71])) = (trise_CLK_R_DO_worst_0, tfall_CLK_R_DO_worst_0);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[0] +: T_DI[0])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[1] +: T_DI[1])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[2] +: T_DI[2])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[3] +: T_DI[3])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[4] +: T_DI[4])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[5] +: T_DI[5])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[6] +: T_DI[6])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[7] +: T_DI[7])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[8] +: T_DI[8])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[9] +: T_DI[9])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[10] +: T_DI[10])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[11] +: T_DI[11])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[12] +: T_DI[12])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[13] +: T_DI[13])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[14] +: T_DI[14])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[15] +: T_DI[15])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[16] +: T_DI[16])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[17] +: T_DI[17])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[18] +: T_DI[18])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[19] +: T_DI[19])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[20] +: T_DI[20])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[21] +: T_DI[21])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[22] +: T_DI[22])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[23] +: T_DI[23])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[24] +: T_DI[24])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[25] +: T_DI[25])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[26] +: T_DI[26])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[27] +: T_DI[27])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[28] +: T_DI[28])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[29] +: T_DI[29])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[30] +: T_DI[30])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[31] +: T_DI[31])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[32] +: T_DI[32])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[33] +: T_DI[33])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[34] +: T_DI[34])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[35] +: T_DI[35])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[36] +: T_DI[36])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[37] +: T_DI[37])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[38] +: T_DI[38])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[39] +: T_DI[39])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[40] +: T_DI[40])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[41] +: T_DI[41])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[42] +: T_DI[42])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[43] +: T_DI[43])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[44] +: T_DI[44])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[45] +: T_DI[45])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[46] +: T_DI[46])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[47] +: T_DI[47])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[48] +: T_DI[48])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[49] +: T_DI[49])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[50] +: T_DI[50])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[51] +: T_DI[51])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[52] +: T_DI[52])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[53] +: T_DI[53])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[54] +: T_DI[54])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[55] +: T_DI[55])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[56] +: T_DI[56])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[57] +: T_DI[57])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[58] +: T_DI[58])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[59] +: T_DI[59])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[60] +: T_DI[60])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[61] +: T_DI[61])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[62] +: T_DI[62])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[63] +: T_DI[63])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[64] +: T_DI[64])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[65] +: T_DI[65])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[66] +: T_DI[66])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[67] +: T_DI[67])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[68] +: T_DI[68])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[69] +: T_DI[69])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[70] +: T_DI[70])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[71] +: T_DI[71])) = (trise_CLK_R_DO_worst_1, tfall_CLK_R_DO_worst_1);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[0] +: T_DI[0])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[1] +: T_DI[1])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[2] +: T_DI[2])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[3] +: T_DI[3])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[4] +: T_DI[4])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[5] +: T_DI[5])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[6] +: T_DI[6])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[7] +: T_DI[7])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[8] +: T_DI[8])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[9] +: T_DI[9])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[10] +: T_DI[10])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[11] +: T_DI[11])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[12] +: T_DI[12])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[13] +: T_DI[13])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[14] +: T_DI[14])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[15] +: T_DI[15])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[16] +: T_DI[16])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[17] +: T_DI[17])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[18] +: T_DI[18])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[19] +: T_DI[19])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[20] +: T_DI[20])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[21] +: T_DI[21])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[22] +: T_DI[22])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[23] +: T_DI[23])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[24] +: T_DI[24])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[25] +: T_DI[25])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[26] +: T_DI[26])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[27] +: T_DI[27])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[28] +: T_DI[28])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[29] +: T_DI[29])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[30] +: T_DI[30])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[31] +: T_DI[31])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[32] +: T_DI[32])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[33] +: T_DI[33])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[34] +: T_DI[34])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[35] +: T_DI[35])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[36] +: T_DI[36])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[37] +: T_DI[37])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[38] +: T_DI[38])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[39] +: T_DI[39])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[40] +: T_DI[40])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[41] +: T_DI[41])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[42] +: T_DI[42])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[43] +: T_DI[43])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[44] +: T_DI[44])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[45] +: T_DI[45])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[46] +: T_DI[46])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[47] +: T_DI[47])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[48] +: T_DI[48])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[49] +: T_DI[49])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[50] +: T_DI[50])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[51] +: T_DI[51])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[52] +: T_DI[52])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[53] +: T_DI[53])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[54] +: T_DI[54])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[55] +: T_DI[55])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[56] +: T_DI[56])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[57] +: T_DI[57])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[58] +: T_DI[58])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[59] +: T_DI[59])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[60] +: T_DI[60])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[61] +: T_DI[61])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[62] +: T_DI[62])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[63] +: T_DI[63])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[64] +: T_DI[64])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[65] +: T_DI[65])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[66] +: T_DI[66])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[67] +: T_DI[67])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[68] +: T_DI[68])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[69] +: T_DI[69])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[70] +: T_DI[70])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[71] +: T_DI[71])) = (trise_CLK_R_DO_worst_2, tfall_CLK_R_DO_worst_2);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[0] +: T_DI[0])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[1] +: T_DI[1])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[2] +: T_DI[2])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[3] +: T_DI[3])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[4] +: T_DI[4])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[5] +: T_DI[5])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[6] +: T_DI[6])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[7] +: T_DI[7])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[8] +: T_DI[8])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[9] +: T_DI[9])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[10] +: T_DI[10])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[11] +: T_DI[11])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[12] +: T_DI[12])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[13] +: T_DI[13])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[14] +: T_DI[14])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[15] +: T_DI[15])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[16] +: T_DI[16])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[17] +: T_DI[17])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[18] +: T_DI[18])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[19] +: T_DI[19])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[20] +: T_DI[20])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[21] +: T_DI[21])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[22] +: T_DI[22])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[23] +: T_DI[23])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[24] +: T_DI[24])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[25] +: T_DI[25])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[26] +: T_DI[26])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[27] +: T_DI[27])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[28] +: T_DI[28])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[29] +: T_DI[29])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[30] +: T_DI[30])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[31] +: T_DI[31])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[32] +: T_DI[32])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[33] +: T_DI[33])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[34] +: T_DI[34])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[35] +: T_DI[35])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[36] +: T_DI[36])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[37] +: T_DI[37])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[38] +: T_DI[38])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[39] +: T_DI[39])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[40] +: T_DI[40])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[41] +: T_DI[41])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[42] +: T_DI[42])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[43] +: T_DI[43])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[44] +: T_DI[44])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[45] +: T_DI[45])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[46] +: T_DI[46])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[47] +: T_DI[47])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[48] +: T_DI[48])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[49] +: T_DI[49])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[50] +: T_DI[50])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[51] +: T_DI[51])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[52] +: T_DI[52])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[53] +: T_DI[53])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[54] +: T_DI[54])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[55] +: T_DI[55])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[56] +: T_DI[56])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[57] +: T_DI[57])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[58] +: T_DI[58])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[59] +: T_DI[59])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[60] +: T_DI[60])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[61] +: T_DI[61])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[62] +: T_DI[62])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[63] +: T_DI[63])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[64] +: T_DI[64])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[65] +: T_DI[65])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[66] +: T_DI[66])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[67] +: T_DI[67])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[68] +: T_DI[68])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[69] +: T_DI[69])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[70] +: T_DI[70])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 0 && T_BE_N == 0) 
  (posedge CLK_R => (DO[71] +: T_DI[71])) = (trise_CLK_R_DO_worst_3, tfall_CLK_R_DO_worst_3);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[0] +: T_DI[0])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[1] +: T_DI[1])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[2] +: T_DI[2])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[3] +: T_DI[3])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[4] +: T_DI[4])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[5] +: T_DI[5])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[6] +: T_DI[6])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[7] +: T_DI[7])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[8] +: T_DI[8])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[9] +: T_DI[9])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[10] +: T_DI[10])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[11] +: T_DI[11])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[12] +: T_DI[12])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[13] +: T_DI[13])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[14] +: T_DI[14])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[15] +: T_DI[15])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[16] +: T_DI[16])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[17] +: T_DI[17])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[18] +: T_DI[18])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[19] +: T_DI[19])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[20] +: T_DI[20])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[21] +: T_DI[21])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[22] +: T_DI[22])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[23] +: T_DI[23])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[24] +: T_DI[24])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[25] +: T_DI[25])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[26] +: T_DI[26])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[27] +: T_DI[27])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[28] +: T_DI[28])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[29] +: T_DI[29])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[30] +: T_DI[30])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[31] +: T_DI[31])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[32] +: T_DI[32])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[33] +: T_DI[33])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[34] +: T_DI[34])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[35] +: T_DI[35])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[36] +: T_DI[36])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[37] +: T_DI[37])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[38] +: T_DI[38])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[39] +: T_DI[39])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[40] +: T_DI[40])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[41] +: T_DI[41])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[42] +: T_DI[42])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[43] +: T_DI[43])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[44] +: T_DI[44])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[45] +: T_DI[45])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[46] +: T_DI[46])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[47] +: T_DI[47])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[48] +: T_DI[48])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[49] +: T_DI[49])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[50] +: T_DI[50])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[51] +: T_DI[51])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[52] +: T_DI[52])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[53] +: T_DI[53])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[54] +: T_DI[54])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[55] +: T_DI[55])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[56] +: T_DI[56])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[57] +: T_DI[57])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[58] +: T_DI[58])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[59] +: T_DI[59])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[60] +: T_DI[60])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[61] +: T_DI[61])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[62] +: T_DI[62])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[63] +: T_DI[63])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[64] +: T_DI[64])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[65] +: T_DI[65])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[66] +: T_DI[66])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[67] +: T_DI[67])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[68] +: T_DI[68])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[69] +: T_DI[69])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[70] +: T_DI[70])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[71] +: T_DI[71])) = (trise_CLK_R_DO_worst_4, tfall_CLK_R_DO_worst_4);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[0] +: T_DI[0])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[1] +: T_DI[1])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[2] +: T_DI[2])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[3] +: T_DI[3])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[4] +: T_DI[4])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[5] +: T_DI[5])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[6] +: T_DI[6])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[7] +: T_DI[7])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[8] +: T_DI[8])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[9] +: T_DI[9])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[10] +: T_DI[10])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[11] +: T_DI[11])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[12] +: T_DI[12])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[13] +: T_DI[13])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[14] +: T_DI[14])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[15] +: T_DI[15])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[16] +: T_DI[16])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[17] +: T_DI[17])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[18] +: T_DI[18])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[19] +: T_DI[19])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[20] +: T_DI[20])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[21] +: T_DI[21])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[22] +: T_DI[22])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[23] +: T_DI[23])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[24] +: T_DI[24])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[25] +: T_DI[25])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[26] +: T_DI[26])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[27] +: T_DI[27])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[28] +: T_DI[28])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[29] +: T_DI[29])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[30] +: T_DI[30])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[31] +: T_DI[31])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[32] +: T_DI[32])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[33] +: T_DI[33])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[34] +: T_DI[34])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[35] +: T_DI[35])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[36] +: T_DI[36])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[37] +: T_DI[37])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[38] +: T_DI[38])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[39] +: T_DI[39])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[40] +: T_DI[40])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[41] +: T_DI[41])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[42] +: T_DI[42])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[43] +: T_DI[43])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[44] +: T_DI[44])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[45] +: T_DI[45])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[46] +: T_DI[46])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[47] +: T_DI[47])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[48] +: T_DI[48])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[49] +: T_DI[49])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[50] +: T_DI[50])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[51] +: T_DI[51])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[52] +: T_DI[52])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[53] +: T_DI[53])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[54] +: T_DI[54])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[55] +: T_DI[55])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[56] +: T_DI[56])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[57] +: T_DI[57])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[58] +: T_DI[58])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[59] +: T_DI[59])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[60] +: T_DI[60])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[61] +: T_DI[61])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[62] +: T_DI[62])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[63] +: T_DI[63])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[64] +: T_DI[64])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[65] +: T_DI[65])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[66] +: T_DI[66])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[67] +: T_DI[67])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[68] +: T_DI[68])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[69] +: T_DI[69])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[70] +: T_DI[70])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 0 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[71] +: T_DI[71])) = (trise_CLK_R_DO_worst_5, tfall_CLK_R_DO_worst_5);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[0] +: T_DI[0])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[1] +: T_DI[1])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[2] +: T_DI[2])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[3] +: T_DI[3])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[4] +: T_DI[4])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[5] +: T_DI[5])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[6] +: T_DI[6])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[7] +: T_DI[7])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[8] +: T_DI[8])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[9] +: T_DI[9])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[10] +: T_DI[10])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[11] +: T_DI[11])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[12] +: T_DI[12])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[13] +: T_DI[13])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[14] +: T_DI[14])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[15] +: T_DI[15])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[16] +: T_DI[16])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[17] +: T_DI[17])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[18] +: T_DI[18])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[19] +: T_DI[19])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[20] +: T_DI[20])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[21] +: T_DI[21])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[22] +: T_DI[22])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[23] +: T_DI[23])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[24] +: T_DI[24])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[25] +: T_DI[25])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[26] +: T_DI[26])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[27] +: T_DI[27])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[28] +: T_DI[28])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[29] +: T_DI[29])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[30] +: T_DI[30])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[31] +: T_DI[31])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[32] +: T_DI[32])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[33] +: T_DI[33])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[34] +: T_DI[34])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[35] +: T_DI[35])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[36] +: T_DI[36])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[37] +: T_DI[37])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[38] +: T_DI[38])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[39] +: T_DI[39])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[40] +: T_DI[40])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[41] +: T_DI[41])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[42] +: T_DI[42])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[43] +: T_DI[43])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[44] +: T_DI[44])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[45] +: T_DI[45])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[46] +: T_DI[46])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[47] +: T_DI[47])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[48] +: T_DI[48])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[49] +: T_DI[49])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[50] +: T_DI[50])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[51] +: T_DI[51])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[52] +: T_DI[52])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[53] +: T_DI[53])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[54] +: T_DI[54])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[55] +: T_DI[55])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[56] +: T_DI[56])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[57] +: T_DI[57])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[58] +: T_DI[58])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[59] +: T_DI[59])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[60] +: T_DI[60])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[61] +: T_DI[61])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[62] +: T_DI[62])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[63] +: T_DI[63])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[64] +: T_DI[64])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[65] +: T_DI[65])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[66] +: T_DI[66])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[67] +: T_DI[67])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[68] +: T_DI[68])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[69] +: T_DI[69])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[70] +: T_DI[70])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 0 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[71] +: T_DI[71])) = (trise_CLK_R_DO_worst_6, tfall_CLK_R_DO_worst_6);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[0] +: T_DI[0])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[1] +: T_DI[1])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[2] +: T_DI[2])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[3] +: T_DI[3])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[4] +: T_DI[4])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[5] +: T_DI[5])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[6] +: T_DI[6])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[7] +: T_DI[7])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[8] +: T_DI[8])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[9] +: T_DI[9])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[10] +: T_DI[10])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[11] +: T_DI[11])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[12] +: T_DI[12])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[13] +: T_DI[13])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[14] +: T_DI[14])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[15] +: T_DI[15])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[16] +: T_DI[16])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[17] +: T_DI[17])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[18] +: T_DI[18])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[19] +: T_DI[19])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[20] +: T_DI[20])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[21] +: T_DI[21])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[22] +: T_DI[22])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[23] +: T_DI[23])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[24] +: T_DI[24])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[25] +: T_DI[25])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[26] +: T_DI[26])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[27] +: T_DI[27])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[28] +: T_DI[28])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[29] +: T_DI[29])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[30] +: T_DI[30])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[31] +: T_DI[31])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[32] +: T_DI[32])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[33] +: T_DI[33])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[34] +: T_DI[34])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[35] +: T_DI[35])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[36] +: T_DI[36])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[37] +: T_DI[37])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[38] +: T_DI[38])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[39] +: T_DI[39])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[40] +: T_DI[40])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[41] +: T_DI[41])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[42] +: T_DI[42])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[43] +: T_DI[43])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[44] +: T_DI[44])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[45] +: T_DI[45])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[46] +: T_DI[46])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[47] +: T_DI[47])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[48] +: T_DI[48])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[49] +: T_DI[49])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[50] +: T_DI[50])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[51] +: T_DI[51])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[52] +: T_DI[52])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[53] +: T_DI[53])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[54] +: T_DI[54])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[55] +: T_DI[55])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[56] +: T_DI[56])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[57] +: T_DI[57])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[58] +: T_DI[58])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[59] +: T_DI[59])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[60] +: T_DI[60])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[61] +: T_DI[61])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[62] +: T_DI[62])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[63] +: T_DI[63])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[64] +: T_DI[64])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[65] +: T_DI[65])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[66] +: T_DI[66])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[67] +: T_DI[67])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[68] +: T_DI[68])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[69] +: T_DI[69])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[70] +: T_DI[70])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 if(T_RWM_R[0] == 1 && T_RWM_R[1] == 1 && T_RWM_R[2] == 1 && T_BE_N == 0) 
  (posedge CLK_R => (DO[71] +: T_DI[71])) = (trise_CLK_R_DO_worst_7, tfall_CLK_R_DO_worst_7);
 `ifdef SDFVERSION_2
  $setup(posedge T_RWM_R[0], posedge CLK_R &&& condition1, t_T_RWM_R_setup_worst);
  $setup(negedge T_RWM_R[0], posedge CLK_R &&& condition1, t_T_RWM_R_setup_worst);
  $hold(posedge CLK_R &&& condition1, posedge T_RWM_R[0], t_T_RWM_R_hold_worst);
  $hold(posedge CLK_R &&& condition1, negedge T_RWM_R[0], t_T_RWM_R_hold_worst);
  $setup(posedge T_RWM_R[1], posedge CLK_R &&& condition1, t_T_RWM_R_setup_worst);
  $setup(negedge T_RWM_R[1], posedge CLK_R &&& condition1, t_T_RWM_R_setup_worst);
  $hold(posedge CLK_R &&& condition1, posedge T_RWM_R[1], t_T_RWM_R_hold_worst);
  $hold(posedge CLK_R &&& condition1, negedge T_RWM_R[1], t_T_RWM_R_hold_worst);
  $setup(posedge T_RWM_R[2], posedge CLK_R &&& condition1, t_T_RWM_R_setup_worst);
  $setup(negedge T_RWM_R[2], posedge CLK_R &&& condition1, t_T_RWM_R_setup_worst);
  $hold(posedge CLK_R &&& condition1, posedge T_RWM_R[2], t_T_RWM_R_hold_worst);
  $hold(posedge CLK_R &&& condition1, negedge T_RWM_R[2], t_T_RWM_R_hold_worst);
  $setup(posedge T_RWM_W[0], posedge CLK_W &&& condition4, t_T_RWM_W_setup_worst);
  $setup(negedge T_RWM_W[0], posedge CLK_W &&& condition4, t_T_RWM_W_setup_worst);
  $hold(posedge CLK_W &&& condition4, posedge T_RWM_W[0], t_T_RWM_W_hold_worst);
  $hold(posedge CLK_W &&& condition4, negedge T_RWM_W[0], t_T_RWM_W_hold_worst);
  $setup(posedge T_RWM_W[1], posedge CLK_W &&& condition4, t_T_RWM_W_setup_worst);
  $setup(negedge T_RWM_W[1], posedge CLK_W &&& condition4, t_T_RWM_W_setup_worst);
  $hold(posedge CLK_W &&& condition4, posedge T_RWM_W[1], t_T_RWM_W_hold_worst);
  $hold(posedge CLK_W &&& condition4, negedge T_RWM_W[1], t_T_RWM_W_hold_worst);
  $setup(posedge T_RWM_W[2], posedge CLK_W &&& condition4, t_T_RWM_W_setup_worst);
  $setup(negedge T_RWM_W[2], posedge CLK_W &&& condition4, t_T_RWM_W_setup_worst);
  $hold(posedge CLK_W &&& condition4, posedge T_RWM_W[2], t_T_RWM_W_hold_worst);
  $hold(posedge CLK_W &&& condition4, negedge T_RWM_W[2], t_T_RWM_W_hold_worst);
  $setup(posedge DI[0], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[0], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[0], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[0], t_DI_hold_worst);
  $setup(posedge DI[1], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[1], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[1], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[1], t_DI_hold_worst);
  $setup(posedge DI[2], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[2], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[2], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[2], t_DI_hold_worst);
  $setup(posedge DI[3], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[3], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[3], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[3], t_DI_hold_worst);
  $setup(posedge DI[4], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[4], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[4], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[4], t_DI_hold_worst);
  $setup(posedge DI[5], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[5], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[5], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[5], t_DI_hold_worst);
  $setup(posedge DI[6], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[6], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[6], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[6], t_DI_hold_worst);
  $setup(posedge DI[7], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[7], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[7], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[7], t_DI_hold_worst);
  $setup(posedge DI[8], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[8], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[8], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[8], t_DI_hold_worst);
  $setup(posedge DI[9], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[9], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[9], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[9], t_DI_hold_worst);
  $setup(posedge DI[10], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[10], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[10], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[10], t_DI_hold_worst);
  $setup(posedge DI[11], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[11], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[11], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[11], t_DI_hold_worst);
  $setup(posedge DI[12], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[12], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[12], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[12], t_DI_hold_worst);
  $setup(posedge DI[13], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[13], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[13], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[13], t_DI_hold_worst);
  $setup(posedge DI[14], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[14], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[14], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[14], t_DI_hold_worst);
  $setup(posedge DI[15], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[15], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[15], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[15], t_DI_hold_worst);
  $setup(posedge DI[16], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[16], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[16], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[16], t_DI_hold_worst);
  $setup(posedge DI[17], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[17], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[17], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[17], t_DI_hold_worst);
  $setup(posedge DI[18], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[18], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[18], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[18], t_DI_hold_worst);
  $setup(posedge DI[19], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[19], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[19], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[19], t_DI_hold_worst);
  $setup(posedge DI[20], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[20], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[20], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[20], t_DI_hold_worst);
  $setup(posedge DI[21], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[21], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[21], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[21], t_DI_hold_worst);
  $setup(posedge DI[22], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[22], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[22], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[22], t_DI_hold_worst);
  $setup(posedge DI[23], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[23], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[23], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[23], t_DI_hold_worst);
  $setup(posedge DI[24], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[24], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[24], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[24], t_DI_hold_worst);
  $setup(posedge DI[25], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[25], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[25], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[25], t_DI_hold_worst);
  $setup(posedge DI[26], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[26], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[26], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[26], t_DI_hold_worst);
  $setup(posedge DI[27], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[27], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[27], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[27], t_DI_hold_worst);
  $setup(posedge DI[28], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[28], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[28], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[28], t_DI_hold_worst);
  $setup(posedge DI[29], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[29], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[29], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[29], t_DI_hold_worst);
  $setup(posedge DI[30], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[30], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[30], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[30], t_DI_hold_worst);
  $setup(posedge DI[31], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[31], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[31], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[31], t_DI_hold_worst);
  $setup(posedge DI[32], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[32], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[32], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[32], t_DI_hold_worst);
  $setup(posedge DI[33], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[33], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[33], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[33], t_DI_hold_worst);
  $setup(posedge DI[34], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[34], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[34], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[34], t_DI_hold_worst);
  $setup(posedge DI[35], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[35], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[35], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[35], t_DI_hold_worst);
  $setup(posedge DI[36], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[36], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[36], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[36], t_DI_hold_worst);
  $setup(posedge DI[37], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[37], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[37], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[37], t_DI_hold_worst);
  $setup(posedge DI[38], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[38], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[38], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[38], t_DI_hold_worst);
  $setup(posedge DI[39], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[39], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[39], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[39], t_DI_hold_worst);
  $setup(posedge DI[40], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[40], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[40], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[40], t_DI_hold_worst);
  $setup(posedge DI[41], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[41], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[41], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[41], t_DI_hold_worst);
  $setup(posedge DI[42], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[42], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[42], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[42], t_DI_hold_worst);
  $setup(posedge DI[43], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[43], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[43], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[43], t_DI_hold_worst);
  $setup(posedge DI[44], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[44], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[44], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[44], t_DI_hold_worst);
  $setup(posedge DI[45], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[45], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[45], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[45], t_DI_hold_worst);
  $setup(posedge DI[46], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[46], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[46], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[46], t_DI_hold_worst);
  $setup(posedge DI[47], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[47], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[47], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[47], t_DI_hold_worst);
  $setup(posedge DI[48], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[48], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[48], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[48], t_DI_hold_worst);
  $setup(posedge DI[49], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[49], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[49], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[49], t_DI_hold_worst);
  $setup(posedge DI[50], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[50], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[50], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[50], t_DI_hold_worst);
  $setup(posedge DI[51], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[51], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[51], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[51], t_DI_hold_worst);
  $setup(posedge DI[52], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[52], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[52], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[52], t_DI_hold_worst);
  $setup(posedge DI[53], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[53], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[53], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[53], t_DI_hold_worst);
  $setup(posedge DI[54], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[54], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[54], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[54], t_DI_hold_worst);
  $setup(posedge DI[55], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[55], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[55], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[55], t_DI_hold_worst);
  $setup(posedge DI[56], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[56], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[56], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[56], t_DI_hold_worst);
  $setup(posedge DI[57], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[57], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[57], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[57], t_DI_hold_worst);
  $setup(posedge DI[58], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[58], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[58], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[58], t_DI_hold_worst);
  $setup(posedge DI[59], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[59], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[59], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[59], t_DI_hold_worst);
  $setup(posedge DI[60], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[60], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[60], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[60], t_DI_hold_worst);
  $setup(posedge DI[61], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[61], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[61], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[61], t_DI_hold_worst);
  $setup(posedge DI[62], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[62], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[62], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[62], t_DI_hold_worst);
  $setup(posedge DI[63], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[63], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[63], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[63], t_DI_hold_worst);
  $setup(posedge DI[64], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[64], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[64], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[64], t_DI_hold_worst);
  $setup(posedge DI[65], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[65], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[65], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[65], t_DI_hold_worst);
  $setup(posedge DI[66], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[66], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[66], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[66], t_DI_hold_worst);
  $setup(posedge DI[67], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[67], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[67], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[67], t_DI_hold_worst);
  $setup(posedge DI[68], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[68], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[68], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[68], t_DI_hold_worst);
  $setup(posedge DI[69], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[69], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[69], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[69], t_DI_hold_worst);
  $setup(posedge DI[70], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[70], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[70], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[70], t_DI_hold_worst);
  $setup(posedge DI[71], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $setup(negedge DI[71], posedge CLK_W &&& condition6, t_DI_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge DI[71], t_DI_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge DI[71], t_DI_hold_worst);
  $setup(posedge A_R[0], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $setup(negedge A_R[0], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition3, posedge A_R[0], t_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition3, negedge A_R[0], t_A_R_hold_worst);
  $setup(posedge A_R[1], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $setup(negedge A_R[1], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition3, posedge A_R[1], t_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition3, negedge A_R[1], t_A_R_hold_worst);
  $setup(posedge A_R[2], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $setup(negedge A_R[2], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition3, posedge A_R[2], t_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition3, negedge A_R[2], t_A_R_hold_worst);
  $setup(posedge A_R[3], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $setup(negedge A_R[3], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition3, posedge A_R[3], t_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition3, negedge A_R[3], t_A_R_hold_worst);
  $setup(posedge A_R[4], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $setup(negedge A_R[4], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition3, posedge A_R[4], t_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition3, negedge A_R[4], t_A_R_hold_worst);
  $setup(posedge A_R[5], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $setup(negedge A_R[5], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition3, posedge A_R[5], t_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition3, negedge A_R[5], t_A_R_hold_worst);
  $setup(posedge A_R[6], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $setup(negedge A_R[6], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition3, posedge A_R[6], t_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition3, negedge A_R[6], t_A_R_hold_worst);
  $setup(posedge A_R[7], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $setup(negedge A_R[7], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition3, posedge A_R[7], t_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition3, negedge A_R[7], t_A_R_hold_worst);
  $setup(posedge A_R[8], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $setup(negedge A_R[8], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition3, posedge A_R[8], t_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition3, negedge A_R[8], t_A_R_hold_worst);
  $setup(posedge A_R[9], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $setup(negedge A_R[9], posedge CLK_R &&& condition3, t_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition3, posedge A_R[9], t_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition3, negedge A_R[9], t_A_R_hold_worst);
  $setup(posedge CE_N_R, posedge CLK_R &&& condition9, t_CE_N_R_setup_worst);
  $setup(negedge CE_N_R, posedge CLK_R &&& condition9, t_CE_N_R_setup_worst);
  $hold(posedge CLK_R &&& condition9, posedge CE_N_R, t_CE_N_R_hold_worst);
  $hold(posedge CLK_R &&& condition9, negedge CE_N_R, t_CE_N_R_hold_worst);
  $setup(posedge CE_N_W, posedge CLK_W &&& condition7, t_CE_N_W_setup_worst);
  $setup(negedge CE_N_W, posedge CLK_W &&& condition7, t_CE_N_W_setup_worst);
  $hold(posedge CLK_W &&& condition7, posedge CE_N_W, t_CE_N_W_hold_worst);
  $hold(posedge CLK_W &&& condition7, negedge CE_N_W, t_CE_N_W_hold_worst);
  $setup(posedge A_W[0], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $setup(negedge A_W[0], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge A_W[0], t_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge A_W[0], t_A_W_hold_worst);
  $setup(posedge A_W[1], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $setup(negedge A_W[1], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge A_W[1], t_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge A_W[1], t_A_W_hold_worst);
  $setup(posedge A_W[2], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $setup(negedge A_W[2], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge A_W[2], t_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge A_W[2], t_A_W_hold_worst);
  $setup(posedge A_W[3], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $setup(negedge A_W[3], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge A_W[3], t_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge A_W[3], t_A_W_hold_worst);
  $setup(posedge A_W[4], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $setup(negedge A_W[4], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge A_W[4], t_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge A_W[4], t_A_W_hold_worst);
  $setup(posedge A_W[5], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $setup(negedge A_W[5], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge A_W[5], t_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge A_W[5], t_A_W_hold_worst);
  $setup(posedge A_W[6], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $setup(negedge A_W[6], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge A_W[6], t_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge A_W[6], t_A_W_hold_worst);
  $setup(posedge A_W[7], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $setup(negedge A_W[7], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge A_W[7], t_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge A_W[7], t_A_W_hold_worst);
  $setup(posedge A_W[8], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $setup(negedge A_W[8], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge A_W[8], t_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge A_W[8], t_A_W_hold_worst);
  $setup(posedge A_W[9], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $setup(negedge A_W[9], posedge CLK_W &&& condition6, t_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge A_W[9], t_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge A_W[9], t_A_W_hold_worst);
  $setup(posedge T_BE_N, posedge CLK_R, t_T_BE_N_setup_worst);
  $setup(negedge T_BE_N, posedge CLK_R, t_T_BE_N_setup_worst);
  $hold(posedge CLK_R, posedge T_BE_N, t_T_BE_N_hold_worst);
  $hold(posedge CLK_R, negedge T_BE_N, t_T_BE_N_hold_worst);
  $setup(posedge T_BE_N, posedge CLK_W, t_T_BE_N_setup_worst);
  $setup(negedge T_BE_N, posedge CLK_W, t_T_BE_N_setup_worst);
  $hold(posedge CLK_W, posedge T_BE_N, t_T_BE_N_hold_worst);
  $hold(posedge CLK_W, negedge T_BE_N, t_T_BE_N_hold_worst);
  $setup(posedge T_DI[0], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[0], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[0], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[0], t_T_DI_hold_worst);
  $setup(posedge T_DI[1], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[1], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[1], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[1], t_T_DI_hold_worst);
  $setup(posedge T_DI[2], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[2], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[2], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[2], t_T_DI_hold_worst);
  $setup(posedge T_DI[3], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[3], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[3], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[3], t_T_DI_hold_worst);
  $setup(posedge T_DI[4], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[4], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[4], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[4], t_T_DI_hold_worst);
  $setup(posedge T_DI[5], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[5], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[5], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[5], t_T_DI_hold_worst);
  $setup(posedge T_DI[6], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[6], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[6], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[6], t_T_DI_hold_worst);
  $setup(posedge T_DI[7], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[7], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[7], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[7], t_T_DI_hold_worst);
  $setup(posedge T_DI[8], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[8], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[8], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[8], t_T_DI_hold_worst);
  $setup(posedge T_DI[9], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[9], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[9], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[9], t_T_DI_hold_worst);
  $setup(posedge T_DI[10], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[10], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[10], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[10], t_T_DI_hold_worst);
  $setup(posedge T_DI[11], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[11], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[11], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[11], t_T_DI_hold_worst);
  $setup(posedge T_DI[12], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[12], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[12], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[12], t_T_DI_hold_worst);
  $setup(posedge T_DI[13], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[13], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[13], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[13], t_T_DI_hold_worst);
  $setup(posedge T_DI[14], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[14], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[14], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[14], t_T_DI_hold_worst);
  $setup(posedge T_DI[15], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[15], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[15], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[15], t_T_DI_hold_worst);
  $setup(posedge T_DI[16], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[16], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[16], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[16], t_T_DI_hold_worst);
  $setup(posedge T_DI[17], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[17], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[17], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[17], t_T_DI_hold_worst);
  $setup(posedge T_DI[18], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[18], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[18], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[18], t_T_DI_hold_worst);
  $setup(posedge T_DI[19], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[19], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[19], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[19], t_T_DI_hold_worst);
  $setup(posedge T_DI[20], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[20], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[20], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[20], t_T_DI_hold_worst);
  $setup(posedge T_DI[21], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[21], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[21], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[21], t_T_DI_hold_worst);
  $setup(posedge T_DI[22], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[22], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[22], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[22], t_T_DI_hold_worst);
  $setup(posedge T_DI[23], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[23], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[23], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[23], t_T_DI_hold_worst);
  $setup(posedge T_DI[24], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[24], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[24], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[24], t_T_DI_hold_worst);
  $setup(posedge T_DI[25], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[25], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[25], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[25], t_T_DI_hold_worst);
  $setup(posedge T_DI[26], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[26], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[26], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[26], t_T_DI_hold_worst);
  $setup(posedge T_DI[27], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[27], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[27], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[27], t_T_DI_hold_worst);
  $setup(posedge T_DI[28], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[28], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[28], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[28], t_T_DI_hold_worst);
  $setup(posedge T_DI[29], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[29], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[29], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[29], t_T_DI_hold_worst);
  $setup(posedge T_DI[30], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[30], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[30], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[30], t_T_DI_hold_worst);
  $setup(posedge T_DI[31], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[31], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[31], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[31], t_T_DI_hold_worst);
  $setup(posedge T_DI[32], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[32], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[32], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[32], t_T_DI_hold_worst);
  $setup(posedge T_DI[33], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[33], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[33], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[33], t_T_DI_hold_worst);
  $setup(posedge T_DI[34], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[34], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[34], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[34], t_T_DI_hold_worst);
  $setup(posedge T_DI[35], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[35], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[35], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[35], t_T_DI_hold_worst);
  $setup(posedge T_DI[36], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[36], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[36], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[36], t_T_DI_hold_worst);
  $setup(posedge T_DI[37], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[37], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[37], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[37], t_T_DI_hold_worst);
  $setup(posedge T_DI[38], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[38], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[38], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[38], t_T_DI_hold_worst);
  $setup(posedge T_DI[39], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[39], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[39], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[39], t_T_DI_hold_worst);
  $setup(posedge T_DI[40], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[40], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[40], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[40], t_T_DI_hold_worst);
  $setup(posedge T_DI[41], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[41], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[41], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[41], t_T_DI_hold_worst);
  $setup(posedge T_DI[42], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[42], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[42], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[42], t_T_DI_hold_worst);
  $setup(posedge T_DI[43], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[43], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[43], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[43], t_T_DI_hold_worst);
  $setup(posedge T_DI[44], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[44], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[44], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[44], t_T_DI_hold_worst);
  $setup(posedge T_DI[45], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[45], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[45], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[45], t_T_DI_hold_worst);
  $setup(posedge T_DI[46], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[46], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[46], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[46], t_T_DI_hold_worst);
  $setup(posedge T_DI[47], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[47], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[47], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[47], t_T_DI_hold_worst);
  $setup(posedge T_DI[48], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[48], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[48], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[48], t_T_DI_hold_worst);
  $setup(posedge T_DI[49], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[49], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[49], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[49], t_T_DI_hold_worst);
  $setup(posedge T_DI[50], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[50], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[50], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[50], t_T_DI_hold_worst);
  $setup(posedge T_DI[51], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[51], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[51], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[51], t_T_DI_hold_worst);
  $setup(posedge T_DI[52], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[52], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[52], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[52], t_T_DI_hold_worst);
  $setup(posedge T_DI[53], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[53], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[53], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[53], t_T_DI_hold_worst);
  $setup(posedge T_DI[54], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[54], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[54], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[54], t_T_DI_hold_worst);
  $setup(posedge T_DI[55], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[55], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[55], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[55], t_T_DI_hold_worst);
  $setup(posedge T_DI[56], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[56], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[56], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[56], t_T_DI_hold_worst);
  $setup(posedge T_DI[57], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[57], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[57], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[57], t_T_DI_hold_worst);
  $setup(posedge T_DI[58], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[58], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[58], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[58], t_T_DI_hold_worst);
  $setup(posedge T_DI[59], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[59], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[59], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[59], t_T_DI_hold_worst);
  $setup(posedge T_DI[60], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[60], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[60], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[60], t_T_DI_hold_worst);
  $setup(posedge T_DI[61], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[61], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[61], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[61], t_T_DI_hold_worst);
  $setup(posedge T_DI[62], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[62], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[62], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[62], t_T_DI_hold_worst);
  $setup(posedge T_DI[63], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[63], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[63], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[63], t_T_DI_hold_worst);
  $setup(posedge T_DI[64], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[64], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[64], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[64], t_T_DI_hold_worst);
  $setup(posedge T_DI[65], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[65], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[65], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[65], t_T_DI_hold_worst);
  $setup(posedge T_DI[66], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[66], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[66], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[66], t_T_DI_hold_worst);
  $setup(posedge T_DI[67], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[67], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[67], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[67], t_T_DI_hold_worst);
  $setup(posedge T_DI[68], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[68], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[68], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[68], t_T_DI_hold_worst);
  $setup(posedge T_DI[69], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[69], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[69], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[69], t_T_DI_hold_worst);
  $setup(posedge T_DI[70], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[70], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[70], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[70], t_T_DI_hold_worst);
  $setup(posedge T_DI[71], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $setup(negedge T_DI[71], posedge CLK_W &&& condition5, t_T_DI_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_DI[71], t_T_DI_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_DI[71], t_T_DI_hold_worst);
  $setup(posedge T_A_R[0], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $setup(negedge T_A_R[0], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition2, posedge T_A_R[0], t_T_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition2, negedge T_A_R[0], t_T_A_R_hold_worst);
  $setup(posedge T_A_R[1], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $setup(negedge T_A_R[1], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition2, posedge T_A_R[1], t_T_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition2, negedge T_A_R[1], t_T_A_R_hold_worst);
  $setup(posedge T_A_R[2], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $setup(negedge T_A_R[2], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition2, posedge T_A_R[2], t_T_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition2, negedge T_A_R[2], t_T_A_R_hold_worst);
  $setup(posedge T_A_R[3], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $setup(negedge T_A_R[3], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition2, posedge T_A_R[3], t_T_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition2, negedge T_A_R[3], t_T_A_R_hold_worst);
  $setup(posedge T_A_R[4], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $setup(negedge T_A_R[4], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition2, posedge T_A_R[4], t_T_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition2, negedge T_A_R[4], t_T_A_R_hold_worst);
  $setup(posedge T_A_R[5], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $setup(negedge T_A_R[5], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition2, posedge T_A_R[5], t_T_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition2, negedge T_A_R[5], t_T_A_R_hold_worst);
  $setup(posedge T_A_R[6], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $setup(negedge T_A_R[6], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition2, posedge T_A_R[6], t_T_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition2, negedge T_A_R[6], t_T_A_R_hold_worst);
  $setup(posedge T_A_R[7], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $setup(negedge T_A_R[7], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition2, posedge T_A_R[7], t_T_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition2, negedge T_A_R[7], t_T_A_R_hold_worst);
  $setup(posedge T_A_R[8], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $setup(negedge T_A_R[8], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition2, posedge T_A_R[8], t_T_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition2, negedge T_A_R[8], t_T_A_R_hold_worst);
  $setup(posedge T_A_R[9], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $setup(negedge T_A_R[9], posedge CLK_R &&& condition2, t_T_A_R_setup_worst);
  $hold(posedge CLK_R &&& condition2, posedge T_A_R[9], t_T_A_R_hold_worst);
  $hold(posedge CLK_R &&& condition2, negedge T_A_R[9], t_T_A_R_hold_worst);
  $setup(posedge T_A_W[0], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $setup(negedge T_A_W[0], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_A_W[0], t_T_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_A_W[0], t_T_A_W_hold_worst);
  $setup(posedge T_A_W[1], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $setup(negedge T_A_W[1], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_A_W[1], t_T_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_A_W[1], t_T_A_W_hold_worst);
  $setup(posedge T_A_W[2], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $setup(negedge T_A_W[2], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_A_W[2], t_T_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_A_W[2], t_T_A_W_hold_worst);
  $setup(posedge T_A_W[3], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $setup(negedge T_A_W[3], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_A_W[3], t_T_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_A_W[3], t_T_A_W_hold_worst);
  $setup(posedge T_A_W[4], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $setup(negedge T_A_W[4], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_A_W[4], t_T_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_A_W[4], t_T_A_W_hold_worst);
  $setup(posedge T_A_W[5], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $setup(negedge T_A_W[5], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_A_W[5], t_T_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_A_W[5], t_T_A_W_hold_worst);
  $setup(posedge T_A_W[6], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $setup(negedge T_A_W[6], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_A_W[6], t_T_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_A_W[6], t_T_A_W_hold_worst);
  $setup(posedge T_A_W[7], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $setup(negedge T_A_W[7], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_A_W[7], t_T_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_A_W[7], t_T_A_W_hold_worst);
  $setup(posedge T_A_W[8], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $setup(negedge T_A_W[8], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_A_W[8], t_T_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_A_W[8], t_T_A_W_hold_worst);
  $setup(posedge T_A_W[9], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $setup(negedge T_A_W[9], posedge CLK_W &&& condition5, t_T_A_W_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_A_W[9], t_T_A_W_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_A_W[9], t_T_A_W_hold_worst);
  $setup(posedge T_CE_N_R, posedge CLK_R &&& condition10, t_T_CE_N_R_setup_worst);
  $setup(negedge T_CE_N_R, posedge CLK_R &&& condition10, t_T_CE_N_R_setup_worst);
  $hold(posedge CLK_R &&& condition10, posedge T_CE_N_R, t_T_CE_N_R_hold_worst);
  $hold(posedge CLK_R &&& condition10, negedge T_CE_N_R, t_T_CE_N_R_hold_worst);
  $setup(posedge T_CE_N_W, posedge CLK_W &&& condition8, t_T_CE_N_W_setup_worst);
  $setup(negedge T_CE_N_W, posedge CLK_W &&& condition8, t_T_CE_N_W_setup_worst);
  $hold(posedge CLK_W &&& condition8, posedge T_CE_N_W, t_T_CE_N_W_hold_worst);
  $hold(posedge CLK_W &&& condition8, negedge T_CE_N_W, t_T_CE_N_W_hold_worst);
  $setup(posedge BWE_N[0], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[0], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[0], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[0], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[1], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[1], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[1], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[1], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[2], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[2], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[2], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[2], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[3], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[3], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[3], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[3], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[4], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[4], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[4], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[4], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[5], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[5], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[5], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[5], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[6], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[6], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[6], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[6], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[7], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[7], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[7], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[7], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[8], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[8], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[8], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[8], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[9], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[9], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[9], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[9], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[10], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[10], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[10], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[10], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[11], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[11], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[11], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[11], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[12], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[12], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[12], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[12], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[13], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[13], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[13], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[13], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[14], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[14], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[14], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[14], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[15], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[15], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[15], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[15], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[16], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[16], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[16], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[16], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[17], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[17], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[17], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[17], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[18], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[18], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[18], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[18], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[19], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[19], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[19], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[19], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[20], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[20], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[20], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[20], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[21], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[21], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[21], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[21], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[22], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[22], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[22], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[22], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[23], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[23], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[23], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[23], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[24], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[24], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[24], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[24], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[25], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[25], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[25], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[25], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[26], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[26], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[26], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[26], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[27], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[27], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[27], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[27], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[28], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[28], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[28], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[28], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[29], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[29], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[29], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[29], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[30], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[30], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[30], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[30], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[31], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[31], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[31], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[31], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[32], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[32], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[32], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[32], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[33], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[33], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[33], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[33], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[34], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[34], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[34], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[34], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[35], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[35], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[35], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[35], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[36], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[36], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[36], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[36], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[37], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[37], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[37], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[37], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[38], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[38], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[38], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[38], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[39], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[39], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[39], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[39], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[40], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[40], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[40], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[40], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[41], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[41], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[41], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[41], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[42], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[42], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[42], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[42], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[43], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[43], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[43], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[43], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[44], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[44], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[44], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[44], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[45], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[45], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[45], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[45], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[46], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[46], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[46], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[46], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[47], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[47], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[47], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[47], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[48], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[48], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[48], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[48], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[49], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[49], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[49], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[49], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[50], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[50], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[50], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[50], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[51], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[51], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[51], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[51], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[52], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[52], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[52], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[52], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[53], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[53], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[53], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[53], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[54], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[54], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[54], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[54], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[55], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[55], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[55], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[55], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[56], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[56], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[56], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[56], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[57], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[57], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[57], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[57], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[58], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[58], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[58], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[58], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[59], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[59], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[59], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[59], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[60], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[60], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[60], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[60], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[61], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[61], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[61], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[61], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[62], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[62], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[62], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[62], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[63], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[63], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[63], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[63], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[64], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[64], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[64], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[64], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[65], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[65], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[65], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[65], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[66], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[66], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[66], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[66], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[67], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[67], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[67], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[67], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[68], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[68], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[68], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[68], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[69], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[69], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[69], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[69], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[70], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[70], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[70], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[70], t_BWE_N_hold_worst);
  $setup(posedge BWE_N[71], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $setup(negedge BWE_N[71], posedge CLK_W &&& condition6, t_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition6, posedge BWE_N[71], t_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition6, negedge BWE_N[71], t_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[0], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[0], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[0], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[0], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[1], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[1], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[1], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[1], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[2], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[2], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[2], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[2], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[3], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[3], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[3], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[3], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[4], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[4], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[4], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[4], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[5], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[5], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[5], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[5], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[6], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[6], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[6], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[6], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[7], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[7], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[7], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[7], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[8], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[8], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[8], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[8], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[9], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[9], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[9], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[9], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[10], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[10], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[10], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[10], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[11], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[11], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[11], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[11], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[12], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[12], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[12], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[12], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[13], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[13], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[13], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[13], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[14], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[14], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[14], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[14], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[15], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[15], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[15], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[15], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[16], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[16], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[16], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[16], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[17], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[17], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[17], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[17], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[18], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[18], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[18], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[18], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[19], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[19], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[19], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[19], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[20], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[20], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[20], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[20], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[21], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[21], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[21], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[21], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[22], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[22], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[22], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[22], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[23], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[23], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[23], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[23], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[24], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[24], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[24], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[24], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[25], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[25], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[25], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[25], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[26], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[26], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[26], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[26], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[27], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[27], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[27], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[27], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[28], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[28], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[28], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[28], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[29], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[29], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[29], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[29], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[30], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[30], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[30], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[30], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[31], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[31], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[31], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[31], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[32], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[32], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[32], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[32], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[33], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[33], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[33], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[33], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[34], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[34], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[34], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[34], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[35], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[35], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[35], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[35], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[36], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[36], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[36], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[36], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[37], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[37], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[37], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[37], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[38], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[38], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[38], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[38], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[39], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[39], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[39], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[39], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[40], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[40], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[40], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[40], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[41], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[41], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[41], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[41], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[42], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[42], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[42], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[42], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[43], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[43], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[43], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[43], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[44], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[44], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[44], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[44], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[45], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[45], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[45], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[45], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[46], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[46], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[46], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[46], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[47], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[47], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[47], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[47], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[48], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[48], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[48], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[48], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[49], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[49], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[49], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[49], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[50], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[50], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[50], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[50], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[51], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[51], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[51], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[51], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[52], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[52], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[52], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[52], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[53], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[53], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[53], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[53], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[54], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[54], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[54], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[54], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[55], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[55], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[55], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[55], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[56], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[56], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[56], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[56], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[57], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[57], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[57], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[57], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[58], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[58], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[58], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[58], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[59], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[59], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[59], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[59], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[60], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[60], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[60], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[60], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[61], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[61], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[61], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[61], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[62], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[62], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[62], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[62], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[63], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[63], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[63], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[63], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[64], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[64], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[64], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[64], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[65], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[65], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[65], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[65], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[66], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[66], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[66], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[66], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[67], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[67], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[67], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[67], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[68], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[68], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[68], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[68], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[69], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[69], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[69], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[69], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[70], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[70], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[70], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[70], t_T_BWE_N_hold_worst);
  $setup(posedge T_BWE_N[71], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $setup(negedge T_BWE_N[71], posedge CLK_W &&& condition5, t_T_BWE_N_setup_worst);
  $hold(posedge CLK_W &&& condition5, posedge T_BWE_N[71], t_T_BWE_N_hold_worst);
  $hold(posedge CLK_W &&& condition5, negedge T_BWE_N[71], t_T_BWE_N_hold_worst);
 `endif
 `ifdef SDFVERSION_3
  $setuphold(posedge CLK_R &&& condition1, posedge T_RWM_R[0], t_T_RWM_R_setup_worst, t_T_RWM_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition1, negedge T_RWM_R[0], t_T_RWM_R_setup_worst, t_T_RWM_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition1, posedge T_RWM_R[1], t_T_RWM_R_setup_worst, t_T_RWM_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition1, negedge T_RWM_R[1], t_T_RWM_R_setup_worst, t_T_RWM_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition1, posedge T_RWM_R[2], t_T_RWM_R_setup_worst, t_T_RWM_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition1, negedge T_RWM_R[2], t_T_RWM_R_setup_worst, t_T_RWM_R_hold_worst);
  $setuphold(posedge CLK_W &&& condition4, posedge T_RWM_W[0], t_T_RWM_W_setup_worst, t_T_RWM_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition4, negedge T_RWM_W[0], t_T_RWM_W_setup_worst, t_T_RWM_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition4, posedge T_RWM_W[1], t_T_RWM_W_setup_worst, t_T_RWM_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition4, negedge T_RWM_W[1], t_T_RWM_W_setup_worst, t_T_RWM_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition4, posedge T_RWM_W[2], t_T_RWM_W_setup_worst, t_T_RWM_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition4, negedge T_RWM_W[2], t_T_RWM_W_setup_worst, t_T_RWM_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[0], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[0], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[1], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[1], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[2], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[2], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[3], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[3], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[4], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[4], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[5], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[5], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[6], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[6], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[7], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[7], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[8], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[8], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[9], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[9], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[10], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[10], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[11], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[11], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[12], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[12], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[13], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[13], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[14], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[14], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[15], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[15], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[16], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[16], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[17], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[17], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[18], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[18], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[19], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[19], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[20], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[20], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[21], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[21], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[22], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[22], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[23], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[23], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[24], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[24], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[25], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[25], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[26], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[26], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[27], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[27], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[28], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[28], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[29], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[29], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[30], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[30], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[31], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[31], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[32], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[32], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[33], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[33], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[34], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[34], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[35], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[35], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[36], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[36], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[37], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[37], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[38], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[38], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[39], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[39], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[40], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[40], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[41], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[41], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[42], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[42], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[43], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[43], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[44], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[44], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[45], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[45], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[46], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[46], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[47], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[47], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[48], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[48], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[49], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[49], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[50], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[50], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[51], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[51], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[52], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[52], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[53], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[53], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[54], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[54], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[55], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[55], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[56], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[56], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[57], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[57], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[58], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[58], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[59], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[59], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[60], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[60], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[61], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[61], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[62], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[62], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[63], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[63], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[64], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[64], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[65], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[65], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[66], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[66], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[67], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[67], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[68], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[68], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[69], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[69], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[70], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[70], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge DI[71], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge DI[71], t_DI_setup_worst, t_DI_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, posedge A_R[0], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, negedge A_R[0], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, posedge A_R[1], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, negedge A_R[1], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, posedge A_R[2], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, negedge A_R[2], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, posedge A_R[3], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, negedge A_R[3], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, posedge A_R[4], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, negedge A_R[4], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, posedge A_R[5], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, negedge A_R[5], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, posedge A_R[6], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, negedge A_R[6], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, posedge A_R[7], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, negedge A_R[7], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, posedge A_R[8], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, negedge A_R[8], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, posedge A_R[9], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition3, negedge A_R[9], t_A_R_setup_worst, t_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition9, posedge CE_N_R, t_CE_N_R_setup_worst, t_CE_N_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition9, negedge CE_N_R, t_CE_N_R_setup_worst, t_CE_N_R_hold_worst);
  $setuphold(posedge CLK_W &&& condition7, posedge CE_N_W, t_CE_N_W_setup_worst, t_CE_N_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition7, negedge CE_N_W, t_CE_N_W_setup_worst, t_CE_N_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge A_W[0], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge A_W[0], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge A_W[1], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge A_W[1], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge A_W[2], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge A_W[2], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge A_W[3], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge A_W[3], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge A_W[4], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge A_W[4], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge A_W[5], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge A_W[5], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge A_W[6], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge A_W[6], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge A_W[7], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge A_W[7], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge A_W[8], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge A_W[8], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge A_W[9], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge A_W[9], t_A_W_setup_worst, t_A_W_hold_worst);
  $setuphold(posedge CLK_R, posedge T_BE_N, t_T_BE_N_setup_worst, t_T_BE_N_hold_worst);
  $setuphold(posedge CLK_R, negedge T_BE_N, t_T_BE_N_setup_worst, t_T_BE_N_hold_worst);
  $setuphold(posedge CLK_W, posedge T_BE_N, t_T_BE_N_setup_worst, t_T_BE_N_hold_worst);
  $setuphold(posedge CLK_W, negedge T_BE_N, t_T_BE_N_setup_worst, t_T_BE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[0], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[0], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[1], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[1], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[2], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[2], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[3], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[3], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[4], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[4], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[5], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[5], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[6], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[6], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[7], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[7], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[8], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[8], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[9], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[9], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[10], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[10], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[11], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[11], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[12], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[12], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[13], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[13], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[14], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[14], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[15], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[15], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[16], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[16], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[17], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[17], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[18], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[18], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[19], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[19], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[20], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[20], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[21], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[21], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[22], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[22], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[23], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[23], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[24], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[24], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[25], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[25], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[26], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[26], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[27], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[27], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[28], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[28], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[29], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[29], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[30], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[30], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[31], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[31], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[32], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[32], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[33], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[33], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[34], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[34], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[35], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[35], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[36], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[36], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[37], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[37], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[38], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[38], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[39], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[39], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[40], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[40], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[41], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[41], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[42], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[42], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[43], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[43], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[44], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[44], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[45], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[45], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[46], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[46], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[47], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[47], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[48], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[48], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[49], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[49], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[50], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[50], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[51], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[51], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[52], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[52], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[53], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[53], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[54], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[54], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[55], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[55], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[56], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[56], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[57], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[57], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[58], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[58], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[59], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[59], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[60], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[60], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[61], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[61], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[62], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[62], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[63], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[63], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[64], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[64], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[65], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[65], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[66], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[66], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[67], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[67], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[68], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[68], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[69], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[69], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[70], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[70], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_DI[71], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_DI[71], t_T_DI_setup_worst, t_T_DI_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, posedge T_A_R[0], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, negedge T_A_R[0], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, posedge T_A_R[1], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, negedge T_A_R[1], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, posedge T_A_R[2], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, negedge T_A_R[2], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, posedge T_A_R[3], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, negedge T_A_R[3], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, posedge T_A_R[4], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, negedge T_A_R[4], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, posedge T_A_R[5], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, negedge T_A_R[5], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, posedge T_A_R[6], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, negedge T_A_R[6], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, posedge T_A_R[7], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, negedge T_A_R[7], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, posedge T_A_R[8], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, negedge T_A_R[8], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, posedge T_A_R[9], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition2, negedge T_A_R[9], t_T_A_R_setup_worst, t_T_A_R_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_A_W[0], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_A_W[0], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_A_W[1], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_A_W[1], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_A_W[2], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_A_W[2], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_A_W[3], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_A_W[3], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_A_W[4], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_A_W[4], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_A_W[5], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_A_W[5], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_A_W[6], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_A_W[6], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_A_W[7], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_A_W[7], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_A_W[8], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_A_W[8], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_A_W[9], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_A_W[9], t_T_A_W_setup_worst, t_T_A_W_hold_worst);
  $setuphold(posedge CLK_R &&& condition10, posedge T_CE_N_R, t_T_CE_N_R_setup_worst, t_T_CE_N_R_hold_worst);
  $setuphold(posedge CLK_R &&& condition10, negedge T_CE_N_R, t_T_CE_N_R_setup_worst, t_T_CE_N_R_hold_worst);
  $setuphold(posedge CLK_W &&& condition8, posedge T_CE_N_W, t_T_CE_N_W_setup_worst, t_T_CE_N_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition8, negedge T_CE_N_W, t_T_CE_N_W_setup_worst, t_T_CE_N_W_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[0], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[0], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[1], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[1], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[2], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[2], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[3], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[3], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[4], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[4], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[5], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[5], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[6], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[6], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[7], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[7], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[8], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[8], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[9], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[9], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[10], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[10], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[11], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[11], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[12], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[12], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[13], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[13], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[14], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[14], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[15], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[15], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[16], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[16], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[17], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[17], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[18], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[18], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[19], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[19], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[20], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[20], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[21], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[21], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[22], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[22], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[23], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[23], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[24], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[24], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[25], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[25], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[26], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[26], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[27], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[27], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[28], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[28], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[29], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[29], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[30], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[30], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[31], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[31], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[32], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[32], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[33], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[33], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[34], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[34], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[35], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[35], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[36], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[36], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[37], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[37], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[38], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[38], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[39], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[39], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[40], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[40], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[41], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[41], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[42], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[42], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[43], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[43], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[44], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[44], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[45], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[45], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[46], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[46], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[47], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[47], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[48], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[48], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[49], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[49], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[50], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[50], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[51], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[51], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[52], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[52], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[53], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[53], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[54], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[54], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[55], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[55], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[56], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[56], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[57], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[57], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[58], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[58], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[59], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[59], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[60], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[60], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[61], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[61], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[62], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[62], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[63], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[63], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[64], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[64], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[65], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[65], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[66], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[66], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[67], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[67], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[68], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[68], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[69], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[69], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[70], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[70], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, posedge BWE_N[71], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition6, negedge BWE_N[71], t_BWE_N_setup_worst, t_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[0], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[0], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[1], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[1], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[2], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[2], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[3], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[3], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[4], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[4], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[5], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[5], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[6], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[6], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[7], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[7], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[8], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[8], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[9], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[9], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[10], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[10], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[11], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[11], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[12], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[12], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[13], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[13], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[14], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[14], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[15], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[15], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[16], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[16], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[17], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[17], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[18], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[18], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[19], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[19], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[20], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[20], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[21], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[21], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[22], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[22], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[23], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[23], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[24], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[24], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[25], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[25], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[26], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[26], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[27], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[27], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[28], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[28], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[29], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[29], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[30], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[30], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[31], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[31], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[32], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[32], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[33], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[33], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[34], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[34], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[35], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[35], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[36], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[36], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[37], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[37], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[38], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[38], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[39], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[39], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[40], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[40], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[41], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[41], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[42], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[42], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[43], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[43], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[44], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[44], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[45], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[45], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[46], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[46], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[47], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[47], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[48], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[48], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[49], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[49], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[50], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[50], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[51], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[51], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[52], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[52], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[53], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[53], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[54], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[54], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[55], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[55], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[56], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[56], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[57], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[57], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[58], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[58], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[59], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[59], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[60], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[60], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[61], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[61], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[62], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[62], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[63], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[63], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[64], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[64], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[65], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[65], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[66], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[66], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[67], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[67], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[68], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[68], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[69], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[69], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[70], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[70], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, posedge T_BWE_N[71], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
  $setuphold(posedge CLK_W &&& condition5, negedge T_BWE_N[71], t_T_BWE_N_setup_worst, t_T_BWE_N_hold_worst);
 `endif
endspecify

endmodule

`endcelldefine
