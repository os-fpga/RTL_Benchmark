// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//

//`include "entropy_src_pkg.sv"
package edn_pkg;
  ///////////////////////////
  // Peripheral Interfaces //
  ///////////////////////////

  parameter int unsigned   ENDPOINT_BUS_WIDTH = 32;
  parameter int unsigned   FIPS_ENDPOINT_BUS_WIDTH = entropy_src_pkg::FIPS_BUS_WIDTH +
                           ENDPOINT_BUS_WIDTH;

  // EDN request interface
  typedef struct packed {
    logic                                 edn_req;
  } edn_req_t;
  typedef struct packed {
    logic                                 edn_ack;
    logic                                 edn_fips;
    logic [ENDPOINT_BUS_WIDTH-1:0]        edn_bus;
  } edn_rsp_t;

  parameter edn_req_t EDN_REQ_DEFAULT = '0;
  parameter edn_rsp_t EDN_RSP_DEFAULT = '0;

  // Sparse four-value signal type
  parameter int EDN_MODE_WIDTH = 4;
  typedef enum logic [EDN_MODE_WIDTH-1:0] {
    EDN_FIELD_ON = 4'b1010
  } edn_enb_e;

endpackage : edn_pkg
