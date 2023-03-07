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

wire  cntrl;
reg [31:0] Dout;
wire  [31:0] DO_temp;
reg   [31:0] memArray [16383:0];
reg  [13:0] A_temp;
reg  CE_N_temp;
integer  i;
integer  j;
integer  m;
integer  ok;

initial 
        begin 
         ok = 0;
 // first rising edge is reserved for resetting  internal nodes...
        wait (!CLK) 
        begin 
        wait (CLK) 
        begin 
        wait (!CLK) 
        begin 
         ok = 1;
         end 
         end 
         end 
 end 

wire  addr_in_range;

initial
begin
    $readmemb("dti_rom_tm16ffcll_16384x32_t321xoe_m_a.img", memArray, 0, 16383);
end
assign addr_in_range = ((T_BE_N ? A : T_A) > 16383) ? 1'b0 : 1'b1  ;

always @(posedge CLK) begin
 if (ok) begin
  if ((T_BE_N ? CE_N: T_CE_N) !== 1'b1 && addr_in_range !== 1'b0) begin
        A_temp = (T_BE_N ? A : T_A);
        CE_N_temp = (T_BE_N ? CE_N : T_CE_N);
        if (^A_temp !== 1'bx && ^CE_N_temp !== 1'bx)
           Dout <= memArray[T_BE_N ? A : T_A];
       else
          Dout <= 32'bx;
    end
 end
 else
          Dout <= 32'bx;
end

assign DO_temp = ((T_BE_N ? OE_N : T_OE_N) ? 32'bz : Dout) ;
assign cntrl = ((T_BE_N ? OE_N : T_OE_N)  ? 1'b1 : 1'b0);
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

wire condition1 ;
wire condition2 ;
wire condition3 ;
wire condition4 ;
assign condition1 = (!CE_N && T_BE_N) || (!T_CE_N && !T_BE_N) ;
assign condition2 = (!T_CE_N && !T_BE_N) ;
assign condition3 = (!CE_N && T_BE_N) ;
assign condition4 = (!T_BE_N) ;
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
assign timing_condition_margin_0 = (T_RM[0] == 0 && T_RM[1] == 0 && T_RM[2] == 0) ;
assign timing_condition_margin_1 = (T_RM[0] == 1 && T_RM[1] == 0 && T_RM[2] == 0) ;
assign timing_condition_margin_2 = (T_RM[0] == 0 && T_RM[1] == 1 && T_RM[2] == 0) ;
assign timing_condition_margin_3 = (T_RM[0] == 1 && T_RM[1] == 1 && T_RM[2] == 0) ;
assign timing_condition_margin_4 = (T_RM[0] == 0 && T_RM[1] == 0 && T_RM[2] == 1) ;
assign timing_condition_margin_5 = (T_RM[0] == 1 && T_RM[1] == 0 && T_RM[2] == 1) ;
assign timing_condition_margin_6 = (T_RM[0] == 0 && T_RM[1] == 1 && T_RM[2] == 1) ;
assign timing_condition_margin_7 = (T_RM[0] == 1 && T_RM[1] == 1 && T_RM[2] == 1) ;

specify
 specparam
  period_param_0 = 0.6768, 
  period_param_1 = 0.7082, 
  period_param_2 = 0.7394, 
  period_param_3 = 0.7718, 
  period_param_4 = 0.8105, 
  period_param_5 = 0.8423, 
  period_param_6 = 0.8736, 
  period_param_7 = 0.9058, 
  trise_CLK_DO_worst = 0.8453, 
  tfall_CLK_DO_worst = 0.8453, 
  trise_OE_N_DO_worst = 0.3578, 
  tfall_OE_N_DO_worst = 0.3582, 
  trise_T_OE_N_DO_worst = 0.3578, 
  tfall_T_OE_N_DO_worst = 0.3582, 
  t_T_RM_setup_worst = 0.0081, 
  t_T_RM_hold_worst = 0.0000, 
  t_A_setup_worst = 0.0885, 
  t_A_hold_worst = 0.1127, 
  t_CE_N_setup_worst = 0.0917, 
  t_CE_N_hold_worst = 0.0457, 
  t_T_BE_N_setup_worst = 0.4389, 
  t_T_BE_N_hold_worst = 0.0000, 
  t_T_A_setup_worst = 0.0885, 
  t_T_A_hold_worst = 0.1127, 
  t_T_CE_N_setup_worst = 0.0917, 
  t_T_CE_N_hold_worst = 0.0457;
  $period(posedge CLK &&& timing_condition_margin_0, period_param_0);
  $period(posedge CLK &&& timing_condition_margin_1, period_param_1);
  $period(posedge CLK &&& timing_condition_margin_2, period_param_2);
  $period(posedge CLK &&& timing_condition_margin_3, period_param_3);
  $period(posedge CLK &&& timing_condition_margin_4, period_param_4);
  $period(posedge CLK &&& timing_condition_margin_5, period_param_5);
  $period(posedge CLK &&& timing_condition_margin_6, period_param_6);
  $period(posedge CLK &&& timing_condition_margin_7, period_param_7);
  $width(posedge CLK, 0.108630);
  $width(negedge CLK, 0.199910);
  (posedge CLK => (DO[0]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[1]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[2]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[3]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[4]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[5]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[6]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[7]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[8]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[9]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[10]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[11]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[12]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[13]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[14]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[15]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[16]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[17]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[18]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[19]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[20]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[21]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[22]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[23]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[24]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[25]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[26]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[27]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[28]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[29]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[30]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (posedge CLK => (DO[31]:0)) = (trise_CLK_DO_worst, tfall_CLK_DO_worst);
  (OE_N => DO[0]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[0]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[1]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[1]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[2]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[2]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[3]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[3]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[4]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[4]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[5]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[5]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[6]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[6]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[7]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[7]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[8]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[8]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[9]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[9]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[10]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[10]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[11]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[11]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[12]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[12]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[13]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[13]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[14]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[14]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[15]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[15]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[16]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[16]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[17]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[17]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[18]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[18]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[19]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[19]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[20]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[20]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[21]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[21]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[22]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[22]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[23]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[23]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[24]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[24]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[25]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[25]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[26]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[26]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[27]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[27]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[28]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[28]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[29]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[29]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[30]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[30]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  (OE_N => DO[31]) = (trise_OE_N_DO_worst, tfall_OE_N_DO_worst);
  (T_OE_N => DO[31]) = (trise_T_OE_N_DO_worst, tfall_T_OE_N_DO_worst);
  $setup(posedge T_RM, posedge CLK &&& condition1, t_T_RM_setup_worst);
  $setup(negedge T_RM, posedge CLK &&& condition1, t_T_RM_setup_worst);
  $hold(posedge CLK &&& condition1, posedge T_RM, t_T_RM_hold_worst);
  $hold(posedge CLK &&& condition1, negedge T_RM, t_T_RM_hold_worst);
  $setup(posedge A, posedge CLK &&& condition3, t_A_setup_worst);
  $setup(negedge A, posedge CLK &&& condition3, t_A_setup_worst);
  $hold(posedge CLK &&& condition3, posedge A, t_A_hold_worst);
  $hold(posedge CLK &&& condition3, negedge A, t_A_hold_worst);
  $setup(posedge CE_N, posedge CLK &&& T_BE_N, t_CE_N_setup_worst);
  $setup(negedge CE_N, posedge CLK &&& T_BE_N, t_CE_N_setup_worst);
  $hold(posedge CLK &&& T_BE_N, posedge CE_N, t_CE_N_hold_worst);
  $hold(posedge CLK &&& T_BE_N, negedge CE_N, t_CE_N_hold_worst);
  $setup(posedge T_BE_N, posedge CLK, t_T_BE_N_setup_worst);
  $setup(negedge T_BE_N, posedge CLK, t_T_BE_N_setup_worst);
  $hold(posedge CLK, posedge T_BE_N, t_T_BE_N_hold_worst);
  $hold(posedge CLK, negedge T_BE_N, t_T_BE_N_hold_worst);
  $setup(posedge T_A, posedge CLK &&& condition2, t_T_A_setup_worst);
  $setup(negedge T_A, posedge CLK &&& condition2, t_T_A_setup_worst);
  $hold(posedge CLK &&& condition2, posedge T_A, t_T_A_hold_worst);
  $hold(posedge CLK &&& condition2, negedge T_A, t_T_A_hold_worst);
  $setup(posedge T_CE_N, posedge CLK &&& condition4, t_T_CE_N_setup_worst);
  $setup(negedge T_CE_N, posedge CLK &&& condition4, t_T_CE_N_setup_worst);
  $hold(posedge CLK &&& condition4, posedge T_CE_N, t_T_CE_N_hold_worst);
  $hold(posedge CLK &&& condition4, negedge T_CE_N, t_T_CE_N_hold_worst);
endspecify
endmodule

