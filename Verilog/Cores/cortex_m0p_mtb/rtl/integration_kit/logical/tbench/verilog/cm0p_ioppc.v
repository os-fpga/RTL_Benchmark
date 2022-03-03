//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2011-2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//   Checked In : $Date: 2012-01-11 17:09:21 +0000 (Wed, 11 Jan 2012) $
//   Revision   : $Revision: 197598 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ IO PORT PROTOCOL CHECKER
//-----------------------------------------------------------------------------

module cm0p_ioppc
#(
  parameter DRIVEMASTER = 0,       // default to slave mode
  parameter DRIVESLAVE  = 1
)
(
  input wire        IOCLK,          // connect to clock for IO bus
  input wire        IORESETn,       // connect to reset for IO bus

  input wire [31:0] IOCHECK,        // Master output  // Slave input
  input wire        IOMATCH,        // Master input   // Slave output

  input wire        IOTRANS,
  input wire [31:0] IOADDR,
  input wire [ 1:0] IOSIZE,
  input wire        IOWRITE,
  input wire        IOPRIV,
  input wire        IOMASTER,

  input wire [31:0] IORDATA,
  input wire [31:0] IOWDATA
);

`ifdef ARM_ASSERT_ON
  `include "std_ovl_defines.h"

  localparam L_MASTER_ASSERT  = DRIVEMASTER == 0 ? `OVL_ASSERT : `OVL_ASSUME;
  localparam L_SLAVE_ASSERT   = DRIVESLAVE == 0  ? `OVL_ASSERT : `OVL_ASSUME;

  reg [31:0]  iocheck_last;
  reg         iomatch_last;
  reg         iotrans_last;
  reg [31:0]  ioaddr_last;
  reg [ 1:0]  iosize_last;
  reg         iowrite_last;
  reg [31:0]  iowdata_last;

  always @(posedge IOCLK)
  begin
    iocheck_last[31:0]  <= IOCHECK[31:0];
    iomatch_last        <= IOMATCH;
    iotrans_last        <= IOTRANS;
    ioaddr_last[31:0]   <= IOADDR[31:0];
    iosize_last[1:0]    <= IOSIZE[1:0];
    iowrite_last        <= IOWRITE;
    iowdata_last[31:0]  <= IOWDATA[31:0];
  end

  // ---------------------------------------------------------------------------
  // Non X-Prop properties
  // ---------------------------------------------------------------------------
  // IOMATCH should not be changing if IOCHECK is maintained
  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (L_SLAVE_ASSERT),
    .msg              ("IOMATCH should be stable when IOCHECK is stable"),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
  u_asrt_s_iocheckmat_consistent
  ( .clock            (IOCLK),
    .reset            (IORESETn),
    .enable           (1'b1),
    .antecedent_expr  (IOCHECK[31:0] == iocheck_last[31:0]),
    .consequent_expr  (IOMATCH == iomatch_last),
    .fire             ());

  // IOMATCH is always low in V6M System space
  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (L_SLAVE_ASSERT),
    .msg              ("IOMATCH must not hit in System region"),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
  u_asrt_s_iomatch_not_in_system
  ( .clock            (IOCLK),
    .reset            (1'b1),
    .enable           (1'b1),
    .antecedent_expr  (IOCHECK[31:28] == 4'hE),
    .consequent_expr  (!IOMATCH),
    .fire             ());

  // When IOSIZE is less than full size of bus, there is lane replication for
  // writes
  wire iowdata_ok_hw = IOWDATA[31:16] == IOWDATA[15:0];
  wire iowdata_ok_by = (IOWDATA[31:24] == IOWDATA[7:0]) &
                       (IOWDATA[23:16] == IOWDATA[7:0]) &
                       (IOWDATA[15:8]  == IOWDATA[7:0]);
  wire iowdata_ok = ((IOSIZE[1:0] == 2'b00) & iowdata_ok_by) |
                    ((IOSIZE[1:0] == 2'b01) & iowdata_ok_hw) |
                    (IOSIZE[1:0] == 2'b10);

  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (L_MASTER_ASSERT),
    .msg              ("IOWDATA should be replicated when doing writes less than full bus width"),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
  u_asrt_m_wdata_repl
  ( .clock            (IOCLK),
    .reset            (IORESETn),
    .enable           (1'b1),
    .antecedent_expr  (IOTRANS & IOWRITE),
    .consequent_expr  (iowdata_ok),
    .fire             ());

  // IOSIZE can never be 2'b11 because CM0P IOP is 32-bit
  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (L_MASTER_ASSERT),
    .msg              ("IOSIZE cannot be 2'b11, which is UNUSED"),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
  u_asrt_m_iosize_reserved
  ( .clock            (IOCLK),
    .reset            (IORESETn),
    .enable           (1'b1),
    .antecedent_expr  (IOTRANS),
    .consequent_expr  (IOSIZE != 2'b11),
    .fire             ());

  // IOADDR must always be aligned to the transfer size
  wire ioaddr_ok = (IOADDR[2:0] & ~(3'b111 << IOSIZE)) == 3'b000;

  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (L_MASTER_ASSERT),
    .msg              ("IOADDR needs to be aligned according to IOSIZE"),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
  u_asrt_m_ioaddr_align
  ( .clock            (IOCLK),
    .reset            (IORESETn),
    .enable           (1'b1),
    .antecedent_expr  (IOTRANS),
    .consequent_expr  (ioaddr_ok),
    .fire             ());

  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (L_MASTER_ASSERT),
    .msg              ("IOTRANS must be low during reset"),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
  u_asrt_m_iotrans_reset
  ( .clock            (IOCLK),
    .reset            (1'b1),
    .enable           (1'b1),
    .antecedent_expr  (~IORESETn),
    .consequent_expr  (~IOTRANS),
    .fire             ());

  // ---------------------------------------------------------------------------
  // Invariant on IOP-PC state
  // ---------------------------------------------------------------------------
  wire ioppc_state_ok = ~IORESETn |
  (
    (iocheck_last[31:28] != 4'hE | ~iomatch_last) &
    (~iotrans_last |
      iosize_last == 2'b00 |
      iosize_last == 2'b01 & ioaddr_last[0] == 1'b0 |
      iosize_last == 2'b10 & ioaddr_last[1:0] == 2'b00 |
      iosize_last != 2'b11) &
    (~iotrans_last | (~iowrite_last | ((
      (iosize_last == 2'b00) &
        iowdata_last[31:24] == iowdata_last[7:0] &
        iowdata_last[23:16] == iowdata_last[7:0] &
        iowdata_last[15:8] == iowdata_last[7:0]) |
      ((iosize_last == 2'b01) &
        iowdata_last[31:16] == iowdata_last[15:0]) |
      (iosize_last == 2'b10))))
  );

  ovl_always
  #(.severity_level (`OVL_FATAL),
    .property_type  (`OVL_ASSERT),
    .msg            ("IOP-PC internal state must always be valid."),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_ioppc_state_ok
  ( .clock          (IOCLK),
    .reset          (IORESETn),
    .enable         (1'b1),
    .test_expr      (ioppc_state_ok),
    .fire           ());

  ovl_next
  #(.severity_level       (`OVL_FATAL),
    .property_type        (`OVL_ASSERT),
    .num_cks              (1),
    .check_overlapping    (1),
    .check_missing_start  (0),
    .msg                  ("IOP-PC internal state must remain valid once valid."),
    .coverage_level       (`OVL_COVER_DEFAULT),
    .clock_edge           (`OVL_POSEDGE),
    .reset_polarity       (`OVL_ACTIVE_LOW),
    .gating_type          (`OVL_GATE_NONE))
  u_asrt_ioppc_state_ok_inductive
  ( .clock                (IOCLK),
    .reset                (IORESETn),
    .enable               (1'b1),
    .start_event          (ioppc_state_ok),
    .test_expr            (ioppc_state_ok),
    .fire                 ());

  // ---------------------------------------------------------------------------
  // X-Prop properties
  // ---------------------------------------------------------------------------
  // IOCHECK is never X
  ovl_never_unknown
  #(.severity_level (`OVL_FATAL),
    .width          (32),
    .property_type  (L_MASTER_ASSERT),
    .msg            ("IOCHECK must never be unknown"),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_m_xcheck
  ( .clock          (IOCLK),
    .reset          (IORESETn),
    .enable         (1'b1),
    .qualifier      (1'b1),
    .test_expr      (IOCHECK[31:0]),
    .fire           ());

  // IOMATCH is never X
  ovl_never_unknown
  #(.severity_level (`OVL_FATAL),
    .width          (1),
    .property_type  (L_SLAVE_ASSERT),
    .msg            ("IOMATCH must never be unknown"),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_s_xmatch
  ( .clock          (IOCLK),
    .reset          (IORESETn),
    .enable         (1'b1),
    .qualifier      (1'b1),
    .test_expr      (IOMATCH),
    .fire           ());

  // IOTRANS is never X
  ovl_never_unknown
  #(.severity_level (`OVL_FATAL),
    .width          (1),
    .property_type  (L_MASTER_ASSERT),
    .msg            ("IOTRANS must never be unknown"),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_m_xtrans
  ( .clock          (IOCLK),
    .reset          (IORESETn),
    .enable         (1'b1),
    .qualifier      (1'b1),
    .test_expr      (IOTRANS),
    .fire           ());

  // IOADDR is never X during an access
  ovl_never_unknown
  #(.severity_level (`OVL_FATAL),
    .width          (32),
    .property_type  (L_MASTER_ASSERT),
    .msg            ("IOADDR must never be unknown during an access"),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_m_xaddr
  ( .clock          (IOCLK),
    .reset          (IORESETn),
    .enable         (1'b1),
    .qualifier      (IOTRANS),
    .test_expr      (IOADDR[31:0]),
    .fire           ());

  // IOSIZE is never X during an access
  ovl_never_unknown
  #(.severity_level (`OVL_FATAL),
    .width          (2),
    .property_type  (L_MASTER_ASSERT),
    .msg            ("IOSIZE must never be unknown during an access"),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_m_xsize
  ( .clock          (IOCLK),
    .reset          (IORESETn),
    .enable         (1'b1),
    .qualifier      (IOTRANS),
    .test_expr      (IOSIZE[1:0]),
    .fire           ());

  // IOWRITE is never X during an access
  ovl_never_unknown
  #(.severity_level (`OVL_FATAL),
    .width          (1),
    .property_type  (L_MASTER_ASSERT),
    .msg            ("IOWRITE must not be unknown during an access"),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_m_xwrite
  ( .clock          (IOCLK),
    .reset          (IORESETn),
    .enable         (1'b1),
    .qualifier      (IOTRANS),
    .test_expr      (IOWRITE),
    .fire           ());

  // IOMASTER is never X during an access
  ovl_never_unknown
  #(.severity_level (`OVL_FATAL),
    .width          (1),
    .property_type  (L_MASTER_ASSERT),
    .msg            ("IOMASTER must not be unknown during an access"),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_m_xmaster
  ( .clock          (IOCLK),
    .reset          (IORESETn),
    .enable         (1'b1),
    .qualifier      (IOTRANS),
    .test_expr      (IOMASTER),
    .fire           ());

 // IOPRIV is never X during an access
  ovl_never_unknown
  #(.severity_level (`OVL_FATAL),
    .width          (1),
    .property_type  (L_MASTER_ASSERT),
    .msg            ("IOPRIV must not be unknown during an access"),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_m_xpriv
  ( .clock          (IOCLK),
    .reset          (IORESETn),
    .enable         (1'b1),
    .qualifier      (IOTRANS),
    .test_expr      (IOPRIV),
    .fire           ());

  // IORDATA is never X during reads
  ovl_never_unknown
  #(.severity_level (`OVL_FATAL),
    .width          (32),
    .property_type  (L_SLAVE_ASSERT),
    .msg            ("IORDATA must not be unknown during a read"),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_s_xrdata
  ( .clock          (IOCLK),
    .reset          (IORESETn),
    .enable         (1'b1),
    .qualifier      (IOTRANS & ~IOWRITE),
    .test_expr      (IORDATA[31:0]),
    .fire           ());

  // IOWDATA is never X during writes
  ovl_never_unknown
  #(.severity_level (`OVL_FATAL),
    .width          (32),
    .property_type  (L_MASTER_ASSERT),
    .msg            ("IOWDATA must not be unknown during a write"),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_m_xwdata
  ( .clock          (IOCLK),
    .reset          (IORESETn),
    .enable         (1'b1),
    .qualifier      (IOTRANS & IOWRITE),
    .test_expr      (IOWDATA[31:0]),
    .fire           ());

`endif
endmodule
