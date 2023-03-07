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
//   Filename:           edma_gen_fifo.v
//   Module Name:        edma_gen_fifo
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


module edma_gen_fifo
#(parameter FIFO_WIDTH = 16,
            FIFO_DEPTH = 8,
            FIFO_ADDR_WIDTH = 4'd3)
 (
  //=============================== Outputs ====================================
  output wire  [FIFO_WIDTH-1:0]  qout,   // currently pointed word
  output reg                     qempty, // FIFO empty flag
  output reg                     qfull , // FIFO full flag
  output wire  [FIFO_ADDR_WIDTH:0]
                                 qlevel, // current amount of data


  //=============================== Clocks/resets ==============================

  input                          clk_pcie,
  input                          rst_n,

  //=============================== Inputs =====================================

  input        [FIFO_WIDTH-1:0]  din,     // input word
  input                          push,    // write strobe for the above word
  input                          flush,   // Re-align read and write ptr
  input                          pop      // Increment FIFO read ptr
);

 // House keeping
 integer         j;            // temporary variable

  //
  //------------------------ SIGNALS DECLARATION -------------------------------
  //

  reg   [FIFO_WIDTH-1:0]         cmd_fifo [0:FIFO_DEPTH-1];// FIFO for cmd

  reg   [FIFO_ADDR_WIDTH-1:0]    wr_ptr;         // WR ptr to VC7 fifo inc by 8051
  wire  [FIFO_ADDR_WIDTH-1:0]    wr_ptr_inc;     // Incrementer for wr_ptr
  wire  [FIFO_ADDR_WIDTH-1:0]    wr_ptr_dec;     // Incrementer for rd_ptr

  wire                           fifo_next_empty;// fifo will be empty after next read
  wire                           fifo_next_full; // fifo will be full after next write

  reg   [FIFO_ADDR_WIDTH:0]      fifo_level;     // Inc every write / Dec every read

  wire                           valid_pop;      // Read command with FIFO not empty
  wire                           valid_push;     // Write command with FIFO not full
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
       cmd_fifo[j]  <= {FIFO_WIDTH{1'b0}};
     end
   end
   else
   begin
     if (valid_push)
     begin
       if (valid_pop)
       begin
         for (i=0;i<(FIFO_DEPTH-1);i=i+1)
         begin
           if (i == {{(32-FIFO_ADDR_WIDTH){1'b0}},wr_ptr_dec})
             cmd_fifo[i] <= din;
           else
             cmd_fifo[i] <= cmd_fifo[i+1];
         end
       end
       else
         cmd_fifo[wr_ptr] <= din;
     end
     else if (valid_pop)
     begin
       for (i=0;i<(FIFO_DEPTH-1);i=i+1)
         cmd_fifo[i] <= cmd_fifo[i+1];
      end
   end
 end

 assign qout            = cmd_fifo[0];

//------------------------------------------------------------------------------
// CMD FIFO pointers
//------------------------------------------------------------------------------
// Incrementing the wr_ptr for each push unless the FIFO is full.

 always @(posedge clk_pcie or negedge rst_n)
 begin
   if (~rst_n)
   begin
    wr_ptr <= {FIFO_ADDR_WIDTH{1'b0}};
   end
   else
   begin
     if (flush)
       wr_ptr <= {FIFO_ADDR_WIDTH{1'b0}};
     else if (valid_push & ~valid_pop)
       wr_ptr <= wr_ptr_inc;
     else if (valid_pop & ~valid_push)
       wr_ptr <= wr_ptr_dec;
   end
 end


generate if (FIFO_ADDR_WIDTH == 4'd1) begin : gen_fifo_addr_eq1
    assign wr_ptr_inc = wr_ptr + 1'h1;
    assign wr_ptr_dec = wr_ptr - 1'h1;
  end else begin : gen_fifo_addr_neq1
    assign wr_ptr_inc = wr_ptr + {{FIFO_ADDR_WIDTH-1{1'b0}},1'h1};
    assign wr_ptr_dec = wr_ptr - {{FIFO_ADDR_WIDTH-1{1'b0}},1'h1};
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

 assign fifo_next_empty     = (wr_ptr_dec == {FIFO_ADDR_WIDTH{1'b0}}) ? 1'b1 : 1'b0;

 always @(posedge clk_pcie or negedge rst_n)
 begin
   if (~rst_n)
   begin
     qempty <= 1'b1;
   end
   else
   begin
     if (flush)
       qempty <= 1'b1;
     else if (qempty && push)
       qempty <= 1'b0;
     else if (fifo_next_empty && pop && ~push)
       qempty <= 1'b1;
   end
 end

 assign fifo_next_full = (wr_ptr_inc == {FIFO_ADDR_WIDTH{1'b0}} ) ? 1'b1 : 1'b0;

 always @(posedge clk_pcie or negedge rst_n)
 begin
   if (~rst_n)
   begin
     qfull <= 1'b0;
   end
   else
   begin
     if (flush)
       qfull <= 1'b0;
     else if (qfull && pop)
       qfull <= 1'b0;
     else if (fifo_next_full && push && ~pop)
       qfull <= 1'b1;
   end
 end

 assign valid_push = push & ~qfull;
 assign valid_pop  = pop  & ~qempty;

 // This register contains the level of the fifo.
 // It is incremented each time a valid push occurs
 // and decremented each time a valid pop occurs.
 always @(posedge clk_pcie or negedge rst_n)
 begin
   if (~rst_n)
   begin
     fifo_level <= {(FIFO_ADDR_WIDTH+1){1'b0}};
   end
   else if (flush)
   begin
     fifo_level <= {(FIFO_ADDR_WIDTH+1){1'b0}};
   end
   else
   begin
     case ({valid_push,valid_pop})
     2'b01:
       fifo_level <= fifo_level -1;
     2'b10:
       fifo_level <= fifo_level +1;
     default:
       fifo_level <= fifo_level;
     endcase
   end
 end

 assign qlevel = fifo_level;

endmodule
