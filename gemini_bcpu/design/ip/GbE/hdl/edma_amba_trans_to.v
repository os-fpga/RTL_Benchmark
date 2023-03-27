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
//   Filename:           edma_amba_trans_to.v
//   Module Name:        edma_amba_trans_to
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
//   Description    : Transaction timeout monitor for the host interface.
//                    The host interface will be either AHB or AXI.
//                    Both variants shall re-use the cdnsdru_asf_trans_timeout
//                    module to implement the actual timer.
//
//                    AHB:
//                    These consists of an address followed by a data phase.
//                    The timer will be set to measure the length of the data
//                    phase since the address phase should always be accepted by
//                    the slave (hready must be high when slave is idle).
//                    For pipelined transfers, the address phase is accepted at
//                    the same time the data phase of the previous transfer
//                    completes (signalled by hready).
//
//                    AXI:
//                    This is slightly more complex due to the independent
//                    channels nature of the AXI protocol.
//                    For a given ID, we will count write and read transactions
//                    in flight. The transaction count will increment on the
//                    slave/fabric accepting the address and decrement each time
//                    a transaction is completed.
//                    For writes, transactions are completed when the bus
//                    response is accepted by the master.
//                    For reads, transactions are completed when the last read
//                    data is accepted by the master.
//                    Since the fabric can potentially accept many addresses
//                    before returning any response and the response time is not
//                    known, then a large timer is used to support as many cases
//                    as possible.
//                    If the fabric response is slower than the maximum count
//                    value then the transaction timeout mechanism should be
//                    disabled.
//
//
//------------------------------------------------------------------------------


module edma_amba_trans_to (
  input                 amba_clk,
  input                 amba_rst_n,

  input                 trans_to_en,
  input         [15:0]  trans_to_timeval,

  // AHB monitoring
  input         [1:0]   htrans,
  input                 hready,

  // AXI monitoring
  // Writes:
  input         [3:0]   awid,
  input                 awvalid,
  input                 awready,
  input         [3:0]   bid,
  input                 bvalid,
  input                 bready,
  // Reads:
  input         [3:0]   arid,
  input                 arvalid,
  input                 arready,
  input         [3:0]   rid,
  input                 rvalid,
  input                 rlast,
  input                 rready,

  output  reg           asf_host_trans_to

);

  // Specify whether AXI or AHB:
  parameter p_edma_axi  = 1'b1;
  parameter p_axi_id    = 4'h0;   // AXI ID to match against.

  // Internal signals
  wire            trans_to_en_s;  // Synchronised enable
  wire            trans_to;       // Transaction timed out


  // Synchronise the enable signal.
  cdnsdru_datasync_v1 #(
    .CDNSDRU_DATASYNC_RESET_STATE (1'b0),
    .CDNSDRU_DATASYNC_NUM_FLOPS   (2),
    .CDNSDRU_DATASYNC_DIN_W       (1)
  ) i_sync_enable (
    .clk    (amba_clk),
    .reset_n(amba_rst_n),
    .din    (trans_to_en),
    .dout   (trans_to_en_s)
  );

  // Separate logic for AXI vs AHB transaction timeout.
  // These can be separated into separate modules if required by currently
  // implemented within this single module so can be instanced easily at the
  // design top level.

  generate if (p_edma_axi == 1'b0) begin : gen_ahb

    reg   xfer_in_prg;
    wire  count_en;   // Enable counter
    wire  count_rst;  // Reset counter

    // A transaction is initiated when htrans indicates a sequential or non-
    // sequential access request. We don't actually care if it is a write or
    // read as the completion mechanism is the same.
    // Register the request (which is the address phase) so that xfer_in_prg
    // is used to count the dataphase.
    always@(posedge amba_clk or negedge amba_rst_n)
    begin
      if (~amba_rst_n)
        xfer_in_prg <= 1'b0;
      else
        if (hready)
          xfer_in_prg <= htrans[1];
    end

    // Count whenever xfer_in_prg and reset each time hready is set. So timer
    // only really counts the cycles where xfer_in_prg is high and hready is
    // low...
    assign count_en   = xfer_in_prg;
    assign count_rst  = hready;

    // Instantiate the re-use module for the timer function
    cdnsdru_asf_trans_timeout_v1 #(.p_count_width(16)) i_to_cnt (
      .clock          (amba_clk),
      .reset_n        (amba_rst_n),
      .timeout_val    (trans_to_timeval),
      .enable         (trans_to_en_s),
      .timer_cnt_en   (1'b1),
      .trans_req      (count_en),
      .trans_resp     (count_rst),
      .trans_timeout  (trans_to)
    );

  end else begin : gen_axi

    wire        winc;
    wire        wdec;
    wire        w_trans_to;
    wire        rinc;
    wire        rdec;
    wire        r_trans_to;

    // For write channel, increment transaction count each time the address is
    // accepted and decrement each time the bus response from the slave is
    // accepted.
    assign winc = (awid == p_axi_id) & awvalid  & awready;
    assign wdec = (bid  == p_axi_id) & bvalid   & bready;

    edma_gen_cnt_to #(
      .p_cnt_wid(5),
      .p_to_wid (16)
    ) i_w_to (
      .clock        (amba_clk),
      .reset_n      (amba_rst_n),
      .timeout_val  (trans_to_timeval),
      .enable       (trans_to_en_s),
      .timer_cnt_en (1'b1),
      .cnt_inc      (winc),
      .cnt_dec      (wdec),
      .count        (),
      .to_err       (w_trans_to)
    );

    // For read channel, increment transaction count each time the address is
    // accepted and decrement each time the last read data is accepted.
    assign rinc = (arid == p_axi_id) & arvalid  & arready;
    assign rdec = (rid  == p_axi_id) & rvalid   & rready & rlast;

    edma_gen_cnt_to #(
      .p_cnt_wid(5),
      .p_to_wid (16)
    ) i_r_to (
      .clock        (amba_clk),
      .reset_n      (amba_rst_n),
      .timeout_val  (trans_to_timeval),
      .enable       (trans_to_en_s),
      .timer_cnt_en (1'b1),
      .cnt_inc      (rinc),
      .cnt_dec      (rdec),
      .count        (),
      .to_err       (r_trans_to)
    );

    // Signal timeout if write or read channel times out...
    assign trans_to = w_trans_to | r_trans_to;

  end
  endgenerate

  // Register the timeout signal
  always@(posedge amba_clk or negedge amba_rst_n)
  begin
    if (~amba_rst_n)
      asf_host_trans_to   <= 1'b0;
    else
      if (trans_to_en_s)
        asf_host_trans_to <= trans_to;
      else
        asf_host_trans_to <= 1'b0;
  end

endmodule
