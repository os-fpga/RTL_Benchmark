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
//   Filename:           gem_bus_sync.v
//   Module Name:        gem_bus_sync
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
//   Description    : Module to synchronise a bus from one clock domain to
//                    another using internal handshaking.
//                    The input data is sampled and stored and a toggle is
//                    generated to notify the receiving clock domain. The toggle
//                    is synchronised and edge detected by which time the data
//                    is guaranteed to be stable for sampling in the destination
//                    clock domain.
//                    Status signals are also generated to notify source and
//                    destination domains of readiness/new data.
//
//                    This module makes use of the following components:
//                      - cdnsdru_datasync_v1
//                      - edma_toggle_detect
//
//------------------------------------------------------------------------------
//
//   Limitations    : This is NOT a FIFO, hence any new bus values presented at
//                    the source data input will not be captured if a transfer
//                    is already taking place. The src_rdy output serves as an
//                    indication of when new data will be captured.
//
//------------------------------------------------------------------------------

module gem_bus_sync # (
  parameter p_dwidth  = 32,   // Width of bus to transfer
  parameter p_reg_out = 0     // Decide whether or not to register output
) (
  input                   src_clk,        // Clock of source domain
  input                   src_rst_n,      // Asynchronous reset
  input                   dest_clk,       // clock of destination domain
  input                   dest_rst_n,     // Asynchronous reset
  input   [p_dwidth-1:0]  src_data,       // Data to be synchronised
  input                   src_xfer_en,    // Signal to enable transfer
  output  [p_dwidth-1:0]  src_data_last,  // Last captured data
  output                  src_rdy,        // Ready to accept new data
  output  [p_dwidth-1:0]  dest_data,      // Data in destination clock domain
  output                  dest_val        // Pulse to indicate new data avail

);

  // Internals
  reg   [p_dwidth-1:0]    data_store;     // Sample of src_data
  reg                     tog_src;        // Toggle in source domain
  wire                    tog_src_dest;   // Toggle in destination domain
  wire                    tog_src_dest_d; // Optional delay
  wire                    tog_dest_src;   // Resync back to source domain
  wire                    new_data_dest;  // New data to destination domain


  // Allow update of store only if the re-synchronised toggle matches the
  // current local source value.
  assign src_rdy  = ~(tog_src ^ tog_dest_src);

  // The transferred data value is also output on the source interface for
  // potential further processing. e.g. User may wish to activate src_xfer_en
  // only if src_data is not the same as src_data_last.
  assign src_data_last  = data_store;

  // Update data_store if enabled to do so and generate new toggle.
  // The input src_xfer_en can be used to stop this update from happening to
  // reduce power depending on application.
  always@(posedge src_clk or negedge src_rst_n)
  begin
    if (~src_rst_n)
    begin
      data_store  <= {p_dwidth{1'b0}};
      tog_src     <= 1'b0;
    end
    else
      if (src_rdy & src_xfer_en)
      begin
        data_store  <= src_data;
        tog_src     <= ~tog_src;
      end
  end

  // Synchronise tog_src to the destination clock domain
  cdnsdru_datasync_v1 #(
    .CDNSDRU_DATASYNC_RESET_STATE (1'b0),
    .CDNSDRU_DATASYNC_NUM_FLOPS   (2),
    .CDNSDRU_DATASYNC_DIN_W       (1)
  ) i_sync_tog_src_dest (
    .clk    (dest_clk),
    .reset_n(dest_rst_n),
    .din    (tog_src),
    .dout   (tog_src_dest)
  );

  // In the destination clock domain we edge detect the toggle to know that a
  // new value is available.
  edma_toggle_detect # (
    .RESET_STATE(1'b0),
    .DIN_W      (1)
  ) i_tog_det_dest (
    .clk      (dest_clk),
    .reset_n  (dest_rst_n),
    .din      (tog_src_dest),
    .rise_edge(),
    .fall_edge(),
    .any_edge (new_data_dest)
  );

  // Optionally register the outputs.
  // If not registered, then the output data must be sampled/used on dest_val
  // externally.
  generate if (p_reg_out == 0) begin : gen_no_reg_op
    assign dest_data      = data_store;
    assign dest_val       = new_data_dest;
    assign tog_src_dest_d = tog_src_dest;
  end else begin : gen_reg_op
    reg [p_dwidth-1:0]  dest_data_r;
    reg                 dest_val_r;
    reg                 tog_src_dest_r;

    always@(posedge dest_clk or negedge dest_rst_n)
    begin
      if (~dest_rst_n)
      begin
        dest_data_r     <= {p_dwidth{1'b0}};
        dest_val_r      <= 1'b0;
        tog_src_dest_r  <= 1'b0;
      end
      else
      begin
        tog_src_dest_r  <= tog_src_dest;
        if (new_data_dest)
        begin
          dest_data_r <= data_store;
          dest_val_r  <= 1'b1;
        end
        else
          dest_val_r  <= 1'b0;
      end
    end

    assign dest_data      = dest_data_r;
    assign dest_val       = dest_val_r;
    assign tog_src_dest_d = tog_src_dest_r;
  end
  endgenerate

  // Re-synchronise tog_src_dest back to src_clk to allow change
  cdnsdru_datasync_v1 #(
    .CDNSDRU_DATASYNC_RESET_STATE(1'b0),
    .CDNSDRU_DATASYNC_NUM_FLOPS(2),
    .CDNSDRU_DATASYNC_DIN_W(1)
  ) i_sync_tog_dest_src (
    .clk    (src_clk),
    .reset_n(src_rst_n),
    .din    (tog_src_dest_d),
    .dout   (tog_dest_src)
  );


endmodule
