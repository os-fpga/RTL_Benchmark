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
//   Filename:           gem_pulse_tsync.v
//   Module Name:        gem_pulse_tsync
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
//   Description    : Generate a pulse in destination clock domain when input
//                    source is high. Toggles are used for CDC and while a
//                    transfer is in progress, any subsequent inputs are ignored
//                    until the transfer is complete.
//
//------------------------------------------------------------------------------


module gem_pulse_tsync (

  input       src_clk,      // Clock in source domain
  input       src_rst_n,    // Async reset
  input       dest_clk,     // Clock in destination domain
  input       dest_rst_n,   // Async reset
  input       src_in,       // Input data, if high generate pulse in destination
  output      dest_pulse    // Pulse in destination domain
);

  reg     tog_src2dest;     // Toggle from source to destination domain
  wire    tog_sync_src2dest;// Synchronised to destination domain
  wire    tog_sync_dest2src;// Sync back to source domain
  wire    xfer_in_prg;      // Transfer in progress

  // Transfer in progress when toggles do not match
  assign xfer_in_prg  = tog_src2dest ^ tog_sync_dest2src;

  // Generate toggle in source clock domain if src_in is high and transfer
  // not in progress.
  always@(posedge src_clk or negedge src_rst_n)
  begin
    if (~src_rst_n)
      tog_src2dest  <= 1'b0;
    else
      if (~xfer_in_prg & src_in)
        tog_src2dest  <= ~tog_src2dest;
  end

  // Synchronise across to destination clock domain
  cdnsdru_datasync_v1 #(
    .CDNSDRU_DATASYNC_RESET_STATE (1'b0),
    .CDNSDRU_DATASYNC_NUM_FLOPS   (32'd2),
    .CDNSDRU_DATASYNC_DIN_W       (32'd1)
  ) i_sync_tog_src_dest (
    .clk    (dest_clk),
    .reset_n(dest_rst_n),
    .din    (tog_src2dest),
    .dout   (tog_sync_src2dest)
  );

  // Re-sync back to source domain
  cdnsdru_datasync_v1 #(
    .CDNSDRU_DATASYNC_RESET_STATE (1'b0),
    .CDNSDRU_DATASYNC_NUM_FLOPS   (32'd2),
    .CDNSDRU_DATASYNC_DIN_W       (32'd1)
  ) i_sync_tog_dest_src (
    .clk    (src_clk),
    .reset_n(src_rst_n),
    .din    (tog_sync_src2dest),
    .dout   (tog_sync_dest2src)
  );

  // Edge detect tog_sync_src2dest and generate pulse on any edge
  edma_toggle_detect # (
    .RESET_STATE(1'b0),
    .DIN_W      (1)
  ) i_tog_det_dest (
    .clk      (dest_clk),
    .reset_n  (dest_rst_n),
    .din      (tog_sync_src2dest),
    .rise_edge(),
    .fall_edge(),
    .any_edge (dest_pulse)
  );


endmodule
