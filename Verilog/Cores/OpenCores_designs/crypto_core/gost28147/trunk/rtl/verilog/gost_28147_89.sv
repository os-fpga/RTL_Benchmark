// $Id:  $ From Russia with love

/////////////////////////////////////////////////////////////////////
//   This file is part of the GOST 28147-89 CryptoCore project     //
//                                                                 //
//   Copyright (c) 2014 Dmitry Murzinov (kakstattakim@gmail.com)   //
///////////////////////////////////////////////////////////////////// 


`define GOST_R_3411_TESTPARAM
`define GOST_R_3411_CRYPTOPRO
`define GOST_R_3411_BOTH 

`ifdef GOST_R_3411_TESTPARAM
// Using the GOST R 34.11-94 TestParameter S-boxes
  const logic [3:0] S1 [0:15] = {  4, 10,  9,  2, 13,  8,  0, 14,  6, 11,  1, 12,  7, 15,  5,  3};
  const logic [3:0] S2 [0:15] = { 14, 11,  4, 12,  6, 13, 15, 10,  2,  3,  8,  1,  0,  7,  5,  9};
  const logic [3:0] S3 [0:15] = {  5,  8,  1, 13, 10,  3,  4,  2, 14, 15, 12,  7,  6,  0,  9, 11};
  const logic [3:0] S4 [0:15] = {  7, 13, 10,  1,  0,  8,  9, 15, 14,  4,  6, 12, 11,  2,  5,  3};
  const logic [3:0] S5 [0:15] = {  6, 12,  7,  1,  5, 15, 13,  8,  4, 10,  9, 14,  0,  3, 11,  2};
  const logic [3:0] S6 [0:15] = {  4, 11, 10,  0,  7,  2,  1, 13,  3,  6,  8,  5,  9, 12, 15, 14};
  const logic [3:0] S7 [0:15] = { 13, 11,  4,  1,  3, 15,  5,  9,  0, 10, 14,  7,  6,  8,  2, 12};
  const logic [3:0] S8 [0:15] = {  1, 15, 13,  0,  5,  7, 10,  4,  9,  2,  3, 14,  6, 11,  8, 12};
`endif
`ifdef GOST_R_3411_CRYPTOPRO
// Using the CryptoPro S-boxes
  const logic [3:0] S1 [0:15] = { 10,  4,  5,  6,  8,  1,  3,  7, 13, 12, 14,  0,  9,  2, 11, 15};
  const logic [3:0] S2 [0:15] = {  5, 15,  4,  0,  2, 13, 11,  9,  1,  7,  6,  3, 12, 14, 10,  8};
  const logic [3:0] S3 [0:15] = {  7, 15, 12, 14,  9,  4,  1,  0,  3, 11,  5,  2,  6, 10,  8, 13};
  const logic [3:0] S4 [0:15] = {  4, 10,  7, 12,  0, 15,  2,  8, 14,  1,  6,  5, 13, 11,  9,  3};
  const logic [3:0] S5 [0:15] = {  7,  6,  4, 11,  9, 12,  2, 10,  1,  8,  0, 14, 15, 13,  3,  5};
  const logic [3:0] S6 [0:15] = {  7,  6,  2,  4, 13,  9, 15,  0, 10,  1,  5, 11,  8, 14, 12,  3};
  const logic [3:0] S7 [0:15] = { 13, 14,  4,  1,  7,  0,  5, 10,  3, 12,  8, 15,  6,  2,  9, 11};
  const logic [3:0] S8 [0:15] = {  1,  3, 10,  9,  5, 11,  4, 15,  8,  6,  7, 14, 13,  0,  2, 12};
`endif
`ifdef GOST_R_3411_BOTH
// Using both parameter's Set S-Boxes: GOST R 34.11-94 TestParameter and CryptoPro
  // GOST R 34.11-94 TestParameter S-boxes
  const logic [3:0] S1_TESTPARAM [0:15] = {  4, 10,  9,  2, 13,  8,  0, 14,  6, 11,  1, 12,  7, 15,  5,  3};
  const logic [3:0] S2_TESTPARAM [0:15] = { 14, 11,  4, 12,  6, 13, 15, 10,  2,  3,  8,  1,  0,  7,  5,  9};
  const logic [3:0] S3_TESTPARAM [0:15] = {  5,  8,  1, 13, 10,  3,  4,  2, 14, 15, 12,  7,  6,  0,  9, 11};
  const logic [3:0] S4_TESTPARAM [0:15] = {  7, 13, 10,  1,  0,  8,  9, 15, 14,  4,  6, 12, 11,  2,  5,  3};
  const logic [3:0] S5_TESTPARAM [0:15] = {  6, 12,  7,  1,  5, 15, 13,  8,  4, 10,  9, 14,  0,  3, 11,  2};
  const logic [3:0] S6_TESTPARAM [0:15] = {  4, 11, 10,  0,  7,  2,  1, 13,  3,  6,  8,  5,  9, 12, 15, 14};
  const logic [3:0] S7_TESTPARAM [0:15] = { 13, 11,  4,  1,  3, 15,  5,  9,  0, 10, 14,  7,  6,  8,  2, 12};
  const logic [3:0] S8_TESTPARAM [0:15] = {  1, 15, 13,  0,  5,  7, 10,  4,  9,  2,  3, 14,  6, 11,  8, 12};
  // CryptoPro S-boxes
  const logic [3:0] S1_CRYPTOPRO [0:15] = { 10,  4,  5,  6,  8,  1,  3,  7, 13, 12, 14,  0,  9,  2, 11, 15};
  const logic [3:0] S2_CRYPTOPRO [0:15] = {  5, 15,  4,  0,  2, 13, 11,  9,  1,  7,  6,  3, 12, 14, 10,  8};
  const logic [3:0] S3_CRYPTOPRO [0:15] = {  7, 15, 12, 14,  9,  4,  1,  0,  3, 11,  5,  2,  6, 10,  8, 13};
  const logic [3:0] S4_CRYPTOPRO [0:15] = {  4, 10,  7, 12,  0, 15,  2,  8, 14,  1,  6,  5, 13, 11,  9,  3};
  const logic [3:0] S5_CRYPTOPRO [0:15] = {  7,  6,  4, 11,  9, 12,  2, 10,  1,  8,  0, 14, 15, 13,  3,  5};
  const logic [3:0] S6_CRYPTOPRO [0:15] = {  7,  6,  2,  4, 13,  9, 15,  0, 10,  1,  5, 11,  8, 14, 12,  3};
  const logic [3:0] S7_CRYPTOPRO [0:15] = { 13, 14,  4,  1,  7,  0,  5, 10,  3, 12,  8, 15,  6,  2,  9, 11};
  const logic [3:0] S8_CRYPTOPRO [0:15] = {  1,  3, 10,  9,  5, 11,  4, 15,  8,  6,  7, 14, 13,  0,  2, 12};
  // define Sbox() function
`define Sbox(x,sel) ( sel ? {S8_CRYPTOPRO[x[31:28]],S7_CRYPTOPRO[x[27:24]],S6_CRYPTOPRO[x[23:20]],S5_CRYPTOPRO[x[19:16]], \
                             S4_CRYPTOPRO[x[15:12]],S3_CRYPTOPRO[x[11:8]],S2_CRYPTOPRO[x[7:4]],S1_CRYPTOPRO[x[3:0]]} : \
                            {S8_TESTPARAM[x[31:28]],S7_TESTPARAM[x[27:24]],S6_TESTPARAM[x[23:20]],S5_TESTPARAM[x[19:16]], \
                             S4_TESTPARAM[x[15:12]],S3_TESTPARAM[x[11:8]],S2_TESTPARAM[x[7:4]],S1_TESTPARAM[x[3:0]]})
`endif
`ifndef GOST_R_3411_BOTH
// define Sbox() function
`define Sbox(x,sel) {S8[x[31:28]],S7[x[27:24]],S6[x[23:20]],S5[x[19:16]],S4[x[15:12]],S3[x[11:8]],S2[x[7:4]],S1[x[3:0]]}
`endif





module gost_28147_89 (clk, rst, mode, select, load, done, kload, key, pdata, cdata);
  input  clk;    // Input clock signal for synchronous design
  input  rst;    // Syncronous Reset input
  input  mode;   // 0 - encrypt, 1 - decrypt
  input  select; // if GOST_R_3411_BOTH defined: 0 - Using the GOST R 34.11-94 TestParameter S-boxes; 1 - Using the CryptoPro S-boxes
  input  load;   // load plain text and start cipher cycles 
  output done;   // cipher text ready for output read
  input  kload;  // load cipher key 
  input [255:0] key;   // cipher key input
  input  [63:0] pdata; //  plain text input 
  output [63:0] cdata; // cipher text output 


reg [4:0] i; // cipher cycles counter: 0..31;

always_ff @(posedge clk)
  if(rst || load)
    i <= 5'h0;
  else //if(~&i)
    i <= i + 1;

//reg run; //running cipher cycles flag    
    
wire [2:0] enc_index = (&i[4:3]) ? ~i[2:0] : i[2:0]; //  cipher key index for encrypt
wire [2:0] dec_index = (|i[4:3]) ? ~i[2:0] : i[2:0]; //  cipher key index for decrypt
wire [2:0] kindex    = mode ? dec_index : enc_index; //  cipher key index    

reg [31:0] K [0:7]; // cipher key storage

always_ff @(posedge clk) 
  if(rst)    
    {K[0],K[1],K[2],K[3],K[4],K[5],K[6],K[7]} <= {256{1'b0}};
  else if(kload)     
    {K[0],K[1],K[2],K[3],K[4],K[5],K[6],K[7]} <= key; 

  
reg   [31:0] b, a; // MSB, LSB of input data
wire  [31:0] state_addmod32 = a + K[kindex];  // Adding by module 32
wire  [31:0] state_sbox     = `Sbox(state_addmod32,select); // S-box replacing
wire  [31:0] state_shift11  = {state_sbox[20:0],state_sbox[31:21]}; // <<11

always_ff @(posedge clk) 
  if(rst)    
    {b,a} <= {64{1'b0}};
  else if(load) 
    {b,a} <= pdata;  
  else /*if(~&i)*/ begin        
    a <= b ^ state_shift11;
    b <= a;
  end
    
reg r_done;
always_ff @(posedge clk)
  if(rst)    
    r_done <= 1'b0;
  else  
    r_done <= &i;

assign done  = r_done;  //ready flag for output data
assign cdata = {a,b}; 

endmodule

