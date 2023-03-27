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
//   Filename:           cdnsdru_datasync_synth_example.v
//   Module Name:        cdnsdru_datasync_synth_sr / cdnsdru_datasync_synth_ar
//
//   Release Revision:   E
//   Release SVN Tag:    Cadence Digital Reuse Library release
//
//   IP Name:            cdnsdru_datasync_synth
//   IP Part Number:     N/A
//
//   Product Type:       Configurable
//   IP Type:            Soft IP
//   IP Family:          Cadence Digital Reuse Library
//   Technology:         N/A
//   Protocol:           N/A
//   Architecture:       N/A
//   Licensable IP:      N/A
//
//------------------------------------------------------------------------------
// Description:
//
//    This common reuse module is designed to allow a customer to replace with
//    their own technology specific cell.
//
//    This example replaceable submodule is provided with the reuse component
//    to be used as a starting point for creation of such a module.
//
//------------------------------------------------------------------------------

module        cdnsdru_datasync_synth_sr #(

  parameter CDNSDRU_DATASYNC_NUM_FLOPS            = 32'd2

)  (

  input  clk,
  input  d_in,
  output d_out

);

  reg     meta;

  generate

    if (CDNSDRU_DATASYNC_NUM_FLOPS == 32'd2) begin : chain_length_equals_2

      reg chain;

      always @(posedge clk) begin
        meta     <= d_in;
        chain    <= meta;
      end

      assign d_out = chain;

    end
    else begin : chain_length_gr_2

      reg [CDNSDRU_DATASYNC_NUM_FLOPS-1:1] chain;

      always @(posedge clk) begin
        meta     <= d_in;
        chain    <= {chain[CDNSDRU_DATASYNC_NUM_FLOPS-2:1],meta};
      end

      assign d_out = chain[CDNSDRU_DATASYNC_NUM_FLOPS-1];

    end

  endgenerate


endmodule

module  cdnsdru_datasync_synth_ar #(

  parameter CDNSDRU_DATASYNC_RESET_STATE          = 1'b0,
  parameter CDNSDRU_DATASYNC_NUM_FLOPS            = 32'd2

) (

  input  clk,
  input  reset_n,
  input  d_in,
  output d_out

);

  reg      meta;

  generate

    if (CDNSDRU_DATASYNC_NUM_FLOPS == 32'd2) begin : chain_length_equals_2

      reg chain;

      always @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
          meta     <= CDNSDRU_DATASYNC_RESET_STATE[0];
          chain    <= CDNSDRU_DATASYNC_RESET_STATE[0];
        end
        else begin
          meta     <= d_in;
          chain    <= meta;
        end
      end

      assign d_out = chain;

    end
    else begin : chain_length_gr_2

      reg [CDNSDRU_DATASYNC_NUM_FLOPS-1:1] chain;

      always @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
          meta     <= CDNSDRU_DATASYNC_RESET_STATE[0];
          chain    <= {CDNSDRU_DATASYNC_NUM_FLOPS-1{CDNSDRU_DATASYNC_RESET_STATE[0]}};
        end
        else begin
          meta     <= d_in;
          chain    <= {chain[CDNSDRU_DATASYNC_NUM_FLOPS-2:1],meta};
        end
      end

      assign d_out = chain[CDNSDRU_DATASYNC_NUM_FLOPS-1];

    end

  endgenerate

endmodule
