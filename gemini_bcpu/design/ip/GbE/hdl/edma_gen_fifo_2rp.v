//------------------------------------------------------------------------------
// Copyright (c) 2012-2017 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           edma_gen_fifo_2rp.v
//   Module Name:        edma_gen_fifo_2rp
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP7014
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      SIP-Ethernet-MAC+DMA+1588+TSN+PCS-10M/100M/1G-IP7014
//
//------------------------------------------------------------------------------
//   Description :
//   This is the description of a generic FIFO. The memory element is described
//   as an array of flops. FIFO_WIDTH defines the size of the single memory
//   element whereas FIFO_DEPTH defines the number of elements in the queue.
//
//------------------------------------------------------------------------------


module edma_gen_fifo_2rp
#(parameter FIFO_WIDTH      = 32'd16,
            FIFO_DEPTH      = 32'd8,
            FIFO_ADDR_WIDTH = 4'd3)
 (
  //=============================== Outputs for read port 1 ====================================
  output wire  [FIFO_WIDTH-1:0]  qout_1,      // currently pointed word
  output wire  [FIFO_WIDTH-1:0]  qout_nxt_1,  // currently pointed +1 word
  output reg                     qempty_1, // FIFO empty flag
  output reg                     qfull_1 , // FIFO full flag
  output wire  [FIFO_ADDR_WIDTH:0]
                                 qlevel_1, // current amount of data

  //=============================== Outputs for read port 2 ====================================
  output wire  [FIFO_WIDTH-1:0]  qout_2,   // currently pointed word
  output reg                     qempty_2, // FIFO empty flag
  output reg                     qfull_2 , // FIFO full flag
  output wire  [FIFO_ADDR_WIDTH:0]
                                 qlevel_2, // current amount of data


  //=============================== Clocks/resets ==============================

  input                          clk_pcie,
  input                          rst_n,

  //=============================== Inputs =====================================

  input        [FIFO_WIDTH-1:0]  din,     // input word
  input                          push,    // write strobe for the above word
  input                          flush,   // Re-align read and write ptr
  input                          pop_1,   // Increment FIFO read ptr
  input                          pop_2    // Increment FIFO read ptr
);

 // House keeping
 integer         j;            // temporary variable

  //
  //------------------------ SIGNALS DECLARATION -------------------------------
  //

  reg   [FIFO_WIDTH-1:0]         cmd_fifo [0:FIFO_DEPTH-1];// FIFO for cmd

  reg   [FIFO_ADDR_WIDTH-1:0]    wr_ptr;            // WR ptr to VC7 fifo inc by 8051
  reg   [FIFO_ADDR_WIDTH-1:0]    wr_ptr_inc;        // Incrementer for wr_ptr
  reg   [FIFO_ADDR_WIDTH-1:0]    rd_ptr_1;          // WR ptr to VC7 fifo inc by 8051
  reg   [FIFO_ADDR_WIDTH-1:0]    rd_ptr_inc_1;      // Incrementer for rd_ptr
  reg   [FIFO_ADDR_WIDTH-1:0]    rd_ptr_2;          // WR ptr to VC7 fifo inc by 8051
  reg   [FIFO_ADDR_WIDTH-1:0]    rd_ptr_inc_2;      // Incrementer for rd_ptr

  wire                           fifo_next_empty_1; // fifo will be empty after next read
  wire                           fifo_next_empty_2; // fifo will be empty after next read
  wire                           fifo_next_full_1;  // fifo will be full after next read
  wire                           fifo_next_full_2;  // fifo will be full after next read

  reg   [FIFO_ADDR_WIDTH:0]      fifo_level_1;      // Inc every write / Dec every read
  reg   [FIFO_ADDR_WIDTH:0]      fifo_level_2;      // Inc every write / Dec every read

  wire                           valid_pop_1;       // Read command with FIFO not empty
  wire                           valid_pop_2;       // Read command with FIFO not empty
  wire                           valid_push;        // Write command with FIFO not full
  integer i;

  //
  //------------------------ END SIGNALS DECLARATION ---------------------------
  //

// -----------------------------------------------------------------------------
//  FIFO Implementation
// -----------------------------------------------------------------------------
// It's based on array of flops array. Write decoding is based on wr_ptr
// read decoding is based on rd_ptr. When the fifo is full the fifo cannot be
// written so overflow is not allowed.

 always @(posedge clk_pcie or negedge rst_n)
 begin
   if (~rst_n)
   begin
     for (j=0; j<FIFO_DEPTH ; j= j+1)
     begin
       cmd_fifo[j]      <= {FIFO_WIDTH{1'b0}};
     end
   end
   else
   begin
     if (valid_push)
       cmd_fifo[wr_ptr] <= din;
   end
 end

 assign qout_1            = cmd_fifo[rd_ptr_1];
 assign qout_nxt_1        = cmd_fifo[rd_ptr_inc_1];
 assign qout_2            = cmd_fifo[rd_ptr_2];

//------------------------------------------------------------------------------
// CMD FIFO pointers
//------------------------------------------------------------------------------
// Incrementing the wr_ptr for each push unless the FIFO is full.

 always @(posedge clk_pcie or negedge rst_n)
 begin
   if (~rst_n)
   begin
    wr_ptr <= {FIFO_ADDR_WIDTH{1'b0}};
    rd_ptr_1 <= {FIFO_ADDR_WIDTH{1'b0}};
    rd_ptr_2 <= {FIFO_ADDR_WIDTH{1'b0}};
   end
   else
   begin
     if (flush)
       wr_ptr <= {FIFO_ADDR_WIDTH{1'b0}};
     else if (valid_push)
       wr_ptr <= wr_ptr_inc;
     if (flush)
       rd_ptr_1 <= {FIFO_ADDR_WIDTH{1'b0}};
     else if (valid_pop_1)
       rd_ptr_1 <= rd_ptr_inc_1;
     if (flush)
       rd_ptr_2 <= {FIFO_ADDR_WIDTH{1'b0}};
     else if (valid_pop_2)
       rd_ptr_2 <= rd_ptr_inc_2;
   end
 end

generate if (FIFO_ADDR_WIDTH == 4'd1) begin : gen_fifo_addreq1
    always @(*)
    begin
      wr_ptr_inc   = ~wr_ptr;
      rd_ptr_inc_1 = ~rd_ptr_1;
      rd_ptr_inc_2 = ~rd_ptr_2;
    end
  end else begin  : gen_fifo_addrneq1
    always @(*)
    begin
      if ({{(32-FIFO_ADDR_WIDTH){1'b0}},wr_ptr} == FIFO_DEPTH-1)
        wr_ptr_inc   = {FIFO_ADDR_WIDTH{1'b0}};
      else
        wr_ptr_inc   =  wr_ptr + {{FIFO_ADDR_WIDTH-1{1'b0}},1'h1};

      if ({{(32-FIFO_ADDR_WIDTH){1'b0}},rd_ptr_1} == FIFO_DEPTH-1)
        rd_ptr_inc_1 = {FIFO_ADDR_WIDTH{1'b0}};
      else
        rd_ptr_inc_1 = rd_ptr_1  + {{FIFO_ADDR_WIDTH-1{1'b0}},1'h1};

      if ({{(32-FIFO_ADDR_WIDTH){1'b0}},rd_ptr_2} == FIFO_DEPTH-1)
        rd_ptr_inc_2 = {FIFO_ADDR_WIDTH{1'b0}};
      else
        rd_ptr_inc_2 = rd_ptr_2  + {{FIFO_ADDR_WIDTH-1{1'b0}},1'h1};
    end
  end
endgenerate

//------------------------------------------------------------------------------
// FIFO Flags
//------------------------------------------------------------------------------
// The FIFO becomes empty when rd_ptr and wr_ptr point to the same location
// because of a pop command . The FIFO becomes full when rd_ptr and
// wr_ptr point to the same location because of a push command. When the fifo is
// empty pop commands do not have any effects. When a FIFO is full push commands
// do not have any effect.

 assign fifo_next_empty_1     = (rd_ptr_inc_1 == wr_ptr);
 assign fifo_next_empty_2     = (rd_ptr_inc_2 == wr_ptr);
 assign fifo_next_full_1      = (rd_ptr_1 == wr_ptr_inc);
 assign fifo_next_full_2      = (rd_ptr_2 == wr_ptr_inc);

 always @(posedge clk_pcie or negedge rst_n)
 begin
   if (~rst_n)
   begin
     qempty_1 <= 1'b1;
     qempty_2 <= 1'b1;
     qfull_1 <= 1'b0;
     qfull_2 <= 1'b0;
   end
   else
   begin
     if (flush)
       qempty_1 <= 1'b1;
     else if (qempty_1 && push)
       qempty_1 <= 1'b0;
     else if (fifo_next_empty_1 && pop_1 && ~push)
       qempty_1 <= 1'b1;

     if (flush)
       qempty_2 <= 1'b1;
     else if (qempty_2 && push)
       qempty_2 <= 1'b0;
     else if (fifo_next_empty_2 && pop_2 && ~push)
       qempty_2 <= 1'b1;

     if (flush)
       qfull_1 <= 1'b0;
     else if (qfull_1 && pop_1)
       qfull_1 <= 1'b0;
     else if (fifo_next_full_1 && valid_push && ~pop_1)
       qfull_1 <= 1'b1;

     if (flush)
       qfull_2 <= 1'b0;
     else if (qfull_2 && pop_2)
       qfull_2 <= 1'b0;
     else if (fifo_next_full_2 && valid_push && ~pop_2)
       qfull_2 <= 1'b1;
   end
 end

 assign valid_push   = push & ~(qfull_1 | qfull_2);
 assign valid_pop_1  = pop_1  & ~qempty_1;
 assign valid_pop_2  = pop_2  & ~qempty_2;

 always @(*)
 begin
  if (qfull_1)
    fifo_level_1  = {1'b1,{FIFO_ADDR_WIDTH{1'b0}}};
  else if (wr_ptr >= rd_ptr_1)
    // if wr_ptr >= rd_ptr_1 then the result will 
    // never underflow and we need to pad with 1 bit
    // to put the result in fifo_level_1
    fifo_level_1  = {1'b0, (wr_ptr - rd_ptr_1)};
  else
    fifo_level_1  = {1'b1,wr_ptr} - {1'b0,rd_ptr_1};

  if (qfull_2)
    fifo_level_2  = {1'b1,{FIFO_ADDR_WIDTH{1'b0}}};
  else if (wr_ptr >= rd_ptr_2)
    // if wr_ptr >= rd_ptr_2 then the result will 
    // never underflow and we need to pad with 1 bit
    // to put the result in fifo_level_2
    fifo_level_2  = {1'b0, (wr_ptr - rd_ptr_2)};
  else
    fifo_level_2  = {1'b1,wr_ptr} - {1'b0,rd_ptr_2};
 end


 assign qlevel_1 = fifo_level_1;
 assign qlevel_2 = fifo_level_2;

endmodule
