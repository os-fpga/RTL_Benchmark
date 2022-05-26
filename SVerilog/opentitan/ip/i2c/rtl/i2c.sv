// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description: I2C top level wrapper file

module i2c
  import i2c_reg_pkg::*;
#(
  parameter logic [NumAlerts-1:0] AlertAsyncOn = {NumAlerts{1'b1}}
) (
  input                     clk_i,
  input                     rst_ni,

  // Bus Interface
  input  tlul_pkg::tl_h2d_t tl_i,
  output tlul_pkg::tl_d2h_t tl_o,

  // Alerts
  input  prim_alert_pkg::alert_rx_t [NumAlerts-1:0] alert_rx_i,
  output prim_alert_pkg::alert_tx_t [NumAlerts-1:0] alert_tx_o,

  // Generic IO
  input                     cio_scl_i,
  output logic              cio_scl_o,
  output logic              cio_scl_en_o,
  input                     cio_sda_i,
  output logic              cio_sda_o,
  output logic              cio_sda_en_o,

  // Interrupts
  output logic              intr_fmt_watermark_o,
  output logic              intr_rx_watermark_o,
  output logic              intr_fmt_overflow_o,
  output logic              intr_rx_overflow_o,
  output logic              intr_nak_o,
  output logic              intr_scl_interference_o,
  output logic              intr_sda_interference_o,
  output logic              intr_stretch_timeout_o,
  output logic              intr_sda_unstable_o,
  output logic              intr_trans_complete_o,
  output logic              intr_tx_empty_o,
  output logic              intr_tx_nonempty_o,
  output logic              intr_tx_overflow_o,
  output logic              intr_acq_overflow_o,
  output logic              intr_ack_stop_o,
  output logic              intr_host_timeout_o
);

  i2c_reg2hw_t reg2hw;
  i2c_hw2reg_t hw2reg;

  logic [NumAlerts-1:0] alert_test, alerts;

  i2c_reg_top u_reg (
    .clk_i,
    .rst_ni,
    .tl_i,
    .tl_o,
    .reg2hw,
    .hw2reg,
    // SEC_CM: BUS.INTEGRITY
    .intg_err_o(alerts[0]),
    .devmode_i(1'b1)
  );

  assign cio_sda_o = '0;
  assign cio_sda_en_o = '0;
  assign cio_scl_o = '0;
  assign cio_scl_en_o = '0;

  assign alert_test = {
    reg2hw.alert_test.q &
    reg2hw.alert_test.qe
  };

  for (genvar i = 0; i < NumAlerts; i++) begin : gen_alert_tx
    prim_alert_sender #(
      .AsyncOn(AlertAsyncOn[i]),
      .IsFatal(1'b1)
    ) u_prim_alert_sender (
      .clk_i,
      .rst_ni,
      .alert_req_i   ( alerts[0]     ),
      .alert_ack_o   (               ),
      .alert_rx_i    ( alert_rx_i[i] ),
      .alert_tx_o    ( alert_tx_o[i] )
    );
  end

  logic scl_int;
  logic sda_int;

  i2c_core i2c_core (
    .clk_i,
    .rst_ni,
    .reg2hw,
    .hw2reg,

    .scl_i(cio_scl_i),
    .scl_o(scl_int),
    .sda_i(cio_sda_i),
    .sda_o(sda_int),

    .intr_fmt_watermark_o,
    .intr_rx_watermark_o,
    .intr_fmt_overflow_o,
    .intr_rx_overflow_o,
    .intr_nak_o,
    .intr_scl_interference_o,
    .intr_sda_interference_o,
    .intr_stretch_timeout_o,
    .intr_sda_unstable_o,
    .intr_trans_complete_o,
    .intr_tx_empty_o,
    .intr_tx_nonempty_o,
    .intr_tx_overflow_o,
    .intr_acq_overflow_o,
    .intr_ack_stop_o,
    .intr_host_timeout_o
  );

endmodule
