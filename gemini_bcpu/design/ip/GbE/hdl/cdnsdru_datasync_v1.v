//------------------------------------------------------------------------------
// Copyright (c) 2017 Cadence Design Systems, Inc.
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
//   Filename:           cdnsdru_datasync_v1.v
//   Module Name:        cdnsdru_datasync_v1
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            cdnsdru_datasync_v1
//   IP Part Number:     IP7014
//
//   Product Type:       Static
//   IP Type:            N/A
//   IP Family:          Cadence Digital Reuse Library
//   Technology:         N/A
//   Protocol:           N/A
//   Architecture:       N/A
//
//------------------------------------------------------------------------------
// Description:
//
//    Very simple block that includes a metastability filter, with a 
//    configurable depth and reset state.
//
//    NOTE the reset state of the chain can be set to 1'b0 or 1'b1 when using
//    async resets via the CDNSDRU_DATASYNC_RESET_STATE parameter. If the
//    CDNSDRU_DATASYNC_SYNC_RESET is set to 1'b1 the reset will be ignored (sync
//    reset being used in the rest of the system).
//    
//    This common module is designed to allow a customer to replace with 
//    their own technology specific cell.
//    This is achieved by:-
//      1) defining `CDNS_SYNTHESIS before compiling the RTL
//      2) creating a submodule called cdnsdru_datasync_synth_ar or
//         cdnsdru_datasync_synth_sr (depending on CDNSDRU_DATASYNC_SYNC_RESET)
//         and including in compiled filelists
//    For reference the instance of cdnsdru_datasync_synth_* may be seen 
//    in the RTL below.
//    Please refer to the IP user documentation for more information.
// 
//    This module is designed to be used with a separate VUNIT file to 
//    model metastability randomisation, where the delay through the
//    synchronizer can vary between N and N+1 clocks where 
//    N = CDNSDRU_DATASYNC_NUM_FLOPS.. This is not provided with delivery
//    but is used for Cadence internal verification. For internal Cadence 
//    verification, please see the vunit provided with this reusable component.
//
//------------------------------------------------------------------------------

`ifndef CDNSDRU_DATASYNC_V1_DEFINE

  `define CDNSDRU_DATASYNC_V1_DEFINE 

module cdnsdru_datasync_v1 # (

  parameter CDNSDRU_DATASYNC_RESET_STATE          = 1'b0,  // Reset state of the internal metastability registers.
  parameter CDNSDRU_DATASYNC_SYNC_RESET           = 1'b0,  // Use synchronous reset (results in no reset on flops).
  parameter CDNSDRU_DATASYNC_NUM_FLOPS            = 32'd2, // Number of serial flops - should probably never vary from 2
  parameter CDNSDRU_DATASYNC_DIN_W                = 1,     // Width of the input bus
  parameter CDNSDRU_DATASYNC_ENABLE_RANDOMIZATION = 1'b1,  // Only used in conjunction with vunit
  parameter CDNSDRU_DATASYNC_META_WINDOW          = 3      // Define the randomization window before the clock edge (ns)
  
) (

  input  clk,
  input  reset_n,
  input  [CDNSDRU_DATASYNC_DIN_W-1:0] din,
  output [CDNSDRU_DATASYNC_DIN_W-1:0] dout

);

`ifndef CDNS_SYNTHESIS

  //---------------------------------------------------------------------
  // Simulation synchroniser model.
  //---------------------------------------------------------------------

  reg [CDNSDRU_DATASYNC_DIN_W-1:0]     meta;

  genvar i;
  generate
    for (i = 0; i < CDNSDRU_DATASYNC_DIN_W; i = i + 1) begin : gen_sync

      if (CDNSDRU_DATASYNC_NUM_FLOPS == 32'd2) begin : chain_length_equals_2

        reg chain;

        if (CDNSDRU_DATASYNC_SYNC_RESET == 1'b1) begin : gen_sync_reset

          always @(posedge clk) begin
            meta[i]  <= din[i];
            chain    <= meta[i];
          end

        end
        else begin : gen_async_reset

          always @(posedge clk or negedge reset_n) begin
            if (~reset_n) begin
              meta[i]  <= CDNSDRU_DATASYNC_RESET_STATE[0];
              chain    <= CDNSDRU_DATASYNC_RESET_STATE[0];
            end
            else begin
              meta[i]  <= din[i];
              chain    <= meta[i];
            end
          end

        end

        assign dout[i] = chain;

      end
      else begin : chain_length_gr_2

        reg [CDNSDRU_DATASYNC_NUM_FLOPS-1:1] chain;

        if (CDNSDRU_DATASYNC_SYNC_RESET == 1'b1) begin : gen_sync_reset

          always @(posedge clk) begin
            meta[i]  <= din[i];
            chain    <= {chain[CDNSDRU_DATASYNC_NUM_FLOPS-2:1],meta[i]};
          end

        end
        else begin : gen_async_reset

          always @(posedge clk or negedge reset_n) begin
            if (~reset_n) begin
              meta[i]  <= CDNSDRU_DATASYNC_RESET_STATE[0];
              chain    <= {CDNSDRU_DATASYNC_NUM_FLOPS-1{CDNSDRU_DATASYNC_RESET_STATE[0]}};
            end
            else begin
              meta[i]  <= din[i];
              chain    <= {chain[CDNSDRU_DATASYNC_NUM_FLOPS-2:1],meta[i]};
            end
          end

        end

        assign dout[i] = chain[CDNSDRU_DATASYNC_NUM_FLOPS-1];

      end

    end
  endgenerate

`else  // CDNS_SYNTHESIS defined

  //---------------------------------------------------------------------
  // Technology library component containing specific sync flops
  //---------------------------------------------------------------------

  genvar i;
  generate
    for (i = 0; i < CDNSDRU_DATASYNC_DIN_W; i = i + 1) begin : gen_sync

      if (CDNSDRU_DATASYNC_SYNC_RESET == 1'b1) begin : inst_sync_reset
        
        // Synchronising flops with synchronous reset
        cdnsdru_datasync_synth_sr #(

          .CDNSDRU_DATASYNC_NUM_FLOPS   (CDNSDRU_DATASYNC_NUM_FLOPS)

        ) u_cdnsdru_datasync_synth (

          .clk     (clk),
          .d_in    (din[i]),
          .d_out   (dout[i])

        );

      end
      else begin : inst_async_reset

        // Synchronising flops with asynchronous reset
        cdnsdru_datasync_synth_ar #(

          .CDNSDRU_DATASYNC_RESET_STATE (CDNSDRU_DATASYNC_RESET_STATE),
          .CDNSDRU_DATASYNC_NUM_FLOPS   (CDNSDRU_DATASYNC_NUM_FLOPS)

        ) u_cdnsdru_datasync_synth (

          .clk     (clk),
          .reset_n (reset_n),
          .d_in    (din[i]),
          .d_out   (dout[i])

        );

      end

    end
  endgenerate

`endif // CDNS_SYNTHESIS


endmodule

`endif // CDNSDRU_DATASYNC_V1_DEFINE
