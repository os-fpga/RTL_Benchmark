/*
 *-----------------------------------------------------------------------------
 *     Copyright (C) 2016 by Dolphin Technology
 *     All right reserved.
 *
 *     Copyright Notification
 *     No part may be reproduced except as authorized by written permission.
 *
 *     Module/Class: dti_cdc_data_sync
 *     Project     : trunk
 *     Author      : toan
 *     Created     : 2016-10-13 10:37:37
 *     Description :
 *
 *     @Last Modified by:   tung
 *     @Last Modified time: 2021/02/25 10:16:33
 *-----------------------------------------------------------------------------
 */

module dti_cdc_data_sync_one #(
    parameter DATA_WIDTH = 4, // width dimension of data buses
    parameter SRC_SYNC   = 1  // 1: add 1 FF to capture on source clock domain. 0: no source FFs
//    parameter STAGE_NUM  = 2  // the number of synchronizing flip flop stages on dest. clock domain
)
(
    input                    clk_src,      // source clock signal
    input                    clk_dest,     // destination clock signal
    input                    reset_n,      // asynchronous active-low reset

    input   [DATA_WIDTH-1:0] din_src,  // synchronized output bus, synchronized by 'clk_src' clock domain
    output  [DATA_WIDTH-1:0] dout_dest   // 1-changing-bit input bus form the opposite clock domain
);

//--------------------------------------------------------------------------
// Internal signals definitions
//--------------------------------------------------------------------------
reg [DATA_WIDTH-1:0] ff_chain_reg0;
reg [DATA_WIDTH-1:0] ff_chain_reg1;
reg [DATA_WIDTH-1:0] din_src_ff   ;

//--------------------------------------------------------------------------
// Processes
//--------------------------------------------------------------------------
generate
  if(SRC_SYNC) begin: SRC_SYNC_GEN
    always @(posedge clk_src or negedge reset_n) begin: DIN_SRC_FF
      if (!reset_n)
        din_src_ff <= 1'b1;
      else
        din_src_ff <= din_src;
    end /*DIN_SRC_FF*/
  end
  else begin
    always @* begin 
      din_src_ff = din_src;
    end
  end
endgenerate

always @(posedge clk_dest or negedge reset_n) begin: FIRST_STAGE_PROC
  if (!reset_n) begin
    ff_chain_reg0 <= 1'b1;
    ff_chain_reg1 <= 1'b1;
  end
  else begin
    ff_chain_reg0 <= din_src_ff;
    ff_chain_reg1 <= ff_chain_reg0;
  end
end


assign dout_dest = ff_chain_reg1;


endmodule /*dti_cdc_data_sync*/

