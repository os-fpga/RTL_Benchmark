//------------------------------------------------------------------------------
// Copyright (c) 2019 Cadence Design Systems, Inc.
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
//   Filename:           cdnsusbhs_common_gen_fifo.v
//   Module Name:        cdnsusbhs_common_gen_fifo
//
//   Release Revision:   R128_F015
//   Release SVN Tag:    USBHS_DUS1301_R128_F015_H03X32T08A32
//
//   IP Name:            USBHS-OTG
//   IP Part Number:     IP4010E
//
//   Product Type:       Configurable
//   IP Type:            Soft IP
//   IP Family:          USB
//   Technology:         N/A
//   Protocol:           USB2
//   Architecture:       OTGCTL
//   Licensable IP:      N/A
//
//------------------------------------------------------------------------------
//   Description:
//   This is the description of a generic FIFO. The memory element is described
//   as an array of flops. FIFO_WIDTH defines the size of the single memory
//   element whereas FIFO_DEPTH defines the number of elements in the queue.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_common_gen_fifo
#(parameter FIFO_WIDTH = 32'd16,
            FIFO_DEPTH = 32'd8,
            FIFO_ADDR_WIDTH=32'd3)
 (

  output wire  [FIFO_WIDTH-1:0]  qout,
  output reg                     qempty,
  output reg                     qfull ,
  output wire  [FIFO_ADDR_WIDTH:0]
                                 qlevel,



  input                          clk,
  input                          rst_n,



  input        [FIFO_WIDTH-1:0]  din,
  input                          push,

  input                          pop
);


 integer         j;





  reg   [FIFO_WIDTH-1:0]         cmd_fifo [0:FIFO_DEPTH-1];

  reg   [FIFO_ADDR_WIDTH-1:0]    rd_ptr;
  reg   [FIFO_ADDR_WIDTH-1:0]    wr_ptr;
  wire  [FIFO_ADDR_WIDTH-1:0]    wr_ptr_inc;
  wire  [FIFO_ADDR_WIDTH-1:0]    rd_ptr_inc;

  wire                           fifo_next_empty;
  wire                           fifo_next_full;

  reg   [FIFO_ADDR_WIDTH:0]      fifo_level;

  wire                           valid_pop;
  wire                           valid_push;




  localparam [FIFO_ADDR_WIDTH-1:0] ONE = 1;
  localparam [FIFO_ADDR_WIDTH-1:0] ZERO = 0;
  localparam [FIFO_ADDR_WIDTH-1:0] MAX_FIFO_ADDRESS = FIFO_DEPTH[FIFO_ADDR_WIDTH-1:0] - ONE;








`CDNSUSBHS_ALWAYS(clk,rst_n)
 begin
   if `CDNSUSBHS_RESET(rst_n)
   begin
     for (j=0; j<FIFO_DEPTH ; j= j+1)
     begin
       cmd_fifo[j]      <= {FIFO_WIDTH{1'b0}};
     end
   end
   else
   begin
     if (valid_push)
     begin
       cmd_fifo[wr_ptr] <= din;
     end
   end
 end

 assign qout            = cmd_fifo[rd_ptr];







`CDNSUSBHS_ALWAYS(clk,rst_n)
 begin
   if `CDNSUSBHS_RESET(rst_n)
   begin
     rd_ptr <= {FIFO_ADDR_WIDTH{1'b0}};
   end
   else
   begin
     if (valid_pop)
       rd_ptr <= rd_ptr_inc;
   end
 end

 assign rd_ptr_inc = rd_ptr == MAX_FIFO_ADDRESS ? ZERO : rd_ptr + ONE;

`CDNSUSBHS_ALWAYS(clk,rst_n)
 begin
   if `CDNSUSBHS_RESET(rst_n)
   begin
    wr_ptr <= {FIFO_ADDR_WIDTH{1'b0}};
   end
   else
   begin



     if (valid_push)
       wr_ptr <= wr_ptr_inc;
   end
 end

 assign wr_ptr_inc = wr_ptr == MAX_FIFO_ADDRESS ? ZERO : wr_ptr + ONE;










 assign fifo_next_empty     = (rd_ptr_inc == wr_ptr) ? 1'b1 : 1'b0;

`CDNSUSBHS_ALWAYS(clk,rst_n)
 begin
   if `CDNSUSBHS_RESET(rst_n)
   begin
     qempty <= 1'b1;
   end
   else
   begin



     if (qempty && push)
       qempty <= 1'b0;
     else if (fifo_next_empty && pop && ~push)
       qempty <= 1'b1;
   end
 end

 assign fifo_next_full = (wr_ptr_inc == rd_ptr ) ? 1'b1 : 1'b0;

`CDNSUSBHS_ALWAYS(clk,rst_n)
 begin
   if `CDNSUSBHS_RESET(rst_n)
   begin
     qfull <= 1'b0;
   end
   else
   begin



     if (qfull && pop)
       qfull <= 1'b0;
     else if (fifo_next_full && push && ~pop)
       qfull <= 1'b1;
   end
 end

 assign valid_push = push & ~qfull;
 assign valid_pop  = pop  & ~qempty;




`CDNSUSBHS_ALWAYS(clk,rst_n)
 begin
   if `CDNSUSBHS_RESET(rst_n)
   begin
     fifo_level <= {FIFO_ADDR_WIDTH + 1 { 1'b0 } };
   end




   else
   begin
     case ({valid_push,valid_pop})
     2'b01:
       fifo_level <= fifo_level - { 1'b0, ONE };
     2'b10:
       fifo_level <= fifo_level + { 1'b0, ONE };
     2'b00,
     2'b11:
       fifo_level <= fifo_level;
     endcase
   end
 end

 assign qlevel  = fifo_level;

endmodule
