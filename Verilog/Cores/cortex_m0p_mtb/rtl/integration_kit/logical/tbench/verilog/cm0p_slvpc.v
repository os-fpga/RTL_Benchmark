//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2008-2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//   Checked In : $Date: 2012-01-12 18:11:06 +0000 (Thu, 12 Jan 2012) $
//   Revision   : $Revision: 197852 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

module cm0p_slvpc
  #(parameter AHBSLV      = 0,
    parameter DRIVEMASTER = 0,
    parameter DRIVESLAVE  = 0,
    parameter CBAW        = 0)
   (input wire        DCLK,      // clock
    input wire        DBGRESETn, // SLV reset
    input wire [31:0] SLVADDR,   // transaction address
    input wire [ 1:0] SLVSIZE,   // transaction size
    input wire [ 3:0] SLVPROT,   // transaction protection
    input wire [ 1:0] SLVTRANS,  // transaction request ([0] unused)
    input wire [31:0] SLVWDATA,  // write-data
    input wire        SLVWRITE,  // write control
    input wire [31:0] SLVRDATA,  // read-data
    input wire        SLVREADY,  // stall signal
    input wire        SLVRESP);  // error response

`ifdef ARM_ASSERT_ON
 `include "std_ovl_defines.h"

  // map whether we should drive the master or slave ports onto
  // assertion / assumption parameters

  localparam MASTERASSERT = (DRIVEMASTER == 0) ? `OVL_ASSERT : `OVL_ASSUME;
  localparam SLAVEASSERT  = (DRIVESLAVE  == 0) ? `OVL_ASSERT : `OVL_ASSUME;

  // Map AHBSLV onto cfg_ahbslv wire and support CBAW

  wire       cfg_ahbslv;

  generate
     if(CBAW == 0) begin : cfg_cbaw
        assign cfg_ahbslv = (AHBSLV != 0);
     end
  endgenerate

  // registers for last state

  reg [31:0] slvaddr_last;
  reg [ 1:0] slvsize_last;
  reg [ 3:0] slvprot_last;
  reg [ 1:0] slvtrans_last;
  reg [31:0] slvwdata_last;
  reg        slvwrite_last;
  reg [31:0] slvrdata_last;
  reg        slvready_last;
  reg        slvresp_last;

  // registers for follower

  reg        tx_active;      // Indicates data phase
  reg        tx_write;       // Indicates data phase for write

  // previous state tracker

  always @(posedge DCLK)
    begin
      slvaddr_last  <= SLVADDR;
      slvsize_last  <= SLVSIZE;
      slvprot_last  <= SLVPROT;
      slvtrans_last <= SLVTRANS;
      slvwdata_last <= SLVWDATA;
      slvwrite_last <= SLVWRITE;
      slvrdata_last <= SLVRDATA;
      slvready_last <= SLVREADY;
      slvresp_last  <= SLVRESP;
    end // always @ (posedge DCLK)

  // transaction follower

  always @(posedge DCLK or negedge DBGRESETn)
    if(~DBGRESETn) begin
      tx_active <= 1'b0;
      tx_write  <= 1'b0;
    end else if(SLVREADY) begin
      tx_active <= SLVTRANS[1];
      tx_write  <= SLVWRITE & SLVTRANS[1];
    end

  // Invariant of valid states for the SLV-PC registers to be in.
  wire slvpc_state_valid =
    (cfg_ahbslv) |
    (
      !cfg_ahbslv &
      ((
        slvtrans_last == 2'b00 &
        (
          (                 ~tx_active & ~tx_write & ~slvresp_last) |   // bus idle
          ( slvready_last & ~tx_active & ~tx_write &  slvresp_last) |   // came off faulting transaction
          (~slvready_last &  tx_active &  tx_write &  slvwrite_last) |  // stalled in data phase of write
          (~slvready_last &  tx_active & ~tx_write & ~slvwrite_last)    // stalled in data phase of read
        )
      ) |
      (
        slvtrans_last == 2'b10 &
        (
          ( slvready_last &  tx_active & ~tx_write & ~slvwrite_last) |  // now in data phase of write
          ( slvready_last &  tx_active &  tx_write &  slvwrite_last) |  // now in data phase of read
          (~slvready_last & ~tx_active & ~tx_write)                     // waited address phase
        )
      ))
    );

  ovl_always
  #(.severity_level (`OVL_FATAL),
    .property_type  (`OVL_ASSERT),
    .msg            ("SLV-PC state must always make sense."),
    .coverage_level (`OVL_COVER_DEFAULT),
    .clock_edge     (`OVL_POSEDGE),
    .reset_polarity (`OVL_ACTIVE_LOW),
    .gating_type    (`OVL_GATE_NONE))
  u_asrt_slvpc_state_valid
  ( .clock      (DCLK),
    .reset      (DBGRESETn),
    .enable     (1'b1),
    .test_expr  (slvpc_state_valid),
    .fire       ());

  ovl_next
  #(.severity_level(`OVL_FATAL),
    .num_cks(1),
    .check_overlapping(1),
    .check_missing_start(0),
    .property_type(`OVL_ASSERT),
    .msg("SLV-PC state must continue to make sense."),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_slvpc_state_valid_inductive
  ( .clock           (DCLK),
    .reset           (DBGRESETn),
    .enable          (1'b1),
    .start_event     (slvpc_state_valid),
    .test_expr       (slvpc_state_valid),
    .fire            ());

  // simple never unknown checks
  ovl_never_unknown
  #(.severity_level(`OVL_FATAL),
    .width(2),
    .property_type(MASTERASSERT),
    .msg("SLVTRANS must never be unknown"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_xtrans
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .qualifier(1'b1),
   .test_expr(SLVTRANS[1:0]),
   .fire());


  ovl_never_unknown
  #(.severity_level(`OVL_FATAL),
    .width(2),
    .property_type(MASTERASSERT),
    .msg("SLVSIZE must never be unknown"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_xsize
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .qualifier(1'b1),
   .test_expr(SLVSIZE[1:0]),
   .fire());

  ovl_never_unknown
  #(.severity_level(`OVL_FATAL),
    .width(4),
    .property_type(MASTERASSERT),
    .msg("SLVPROT must never be unknown"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_xprot
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .qualifier(1'b1),
   .test_expr(SLVPROT[3:0]),
   .fire());

  ovl_never_unknown
  #(.severity_level(`OVL_FATAL),
    .width(2),
    .property_type(MASTERASSERT),
    .msg("When SLVSIZE is half-word or word, certain bits of SLVADDR must not be unknown."),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_xaddr
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .qualifier(1'b1),
   .test_expr({SLVADDR[1] &   (SLVSIZE[1:0] == 2'b10),
               SLVADDR[0] & ( (SLVSIZE[1:0] == 2'b10) |
                              (SLVSIZE[1:0] == 2'b01) )}),
   .fire());

  // check / drive master size to address relationship,
  // these are independent to whether or not we are performing a
  // transaction

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(MASTERASSERT),
    .msg("Half-word transactions must be half-word aligned"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_shalf
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .antecedent_expr(SLVSIZE[1:0] == 2'b01),
   .consequent_expr(SLVADDR[0] == 1'b0),
   .fire());

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(MASTERASSERT),
    .msg("Word transactions must be Word aligned"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_sword
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .antecedent_expr(SLVSIZE[1:0] == 2'b10),
   .consequent_expr(SLVADDR[1:0] == 2'b00),
   .fire());

  ovl_never
  #(.severity_level(`OVL_FATAL),
    .property_type(MASTERASSERT),
    .msg("Double-word transaction are not supported"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_sdouble
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .test_expr(SLVSIZE[1:0] == 2'b11),
   .fire());

  // slave error response must always be two cycle if
  // in AHB mode

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(SLAVEASSERT),
    .msg("AHBSLV: Error response must be two cycle"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_s_2err
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .antecedent_expr(cfg_ahbslv),
   .consequent_expr((SLVRESP & SLVREADY) == (slvresp_last & ~slvready_last)),
   .fire());

  // slave cannot generate an error response outside of
  // a transaction

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(SLAVEASSERT),
    .msg("Error response can only be generated in response to a transaction"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_s_notx_noerr
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .antecedent_expr(~tx_active),
   .consequent_expr(~SLVRESP),
   .fire());

  // master must not generate transactions during reset

  ovl_implication
  #(.severity_level  (`OVL_FATAL),
    .property_type   (MASTERASSERT),
    .msg             ("Master must not generate transactions during reset"),
    .coverage_level  (`OVL_COVER_DEFAULT),
    .clock_edge      (`OVL_POSEDGE),
    .reset_polarity  (`OVL_ACTIVE_LOW),
    .gating_type     (`OVL_GATE_NONE))
  u_asrt_m_reset
  (.clock(DCLK),
   .reset(1'b1),
   .enable(1'b1),
   .antecedent_expr(~DBGRESETn),
   .consequent_expr(SLVTRANS[1:0] == 2'b00),
   .fire());

  // AHB mode slave must not stall bus during reset

  ovl_next
  #(.severity_level      (`OVL_FATAL),
    .num_cks             (1),
    .check_overlapping   (1),
    .check_missing_start (0),
    .property_type       (SLAVEASSERT),
    .msg                 ("Slave in AHB mode must drive SLVREADY high during reset."),
    .coverage_level      (`OVL_COVER_DEFAULT),
    .clock_edge          (`OVL_POSEDGE),
    .reset_polarity      (`OVL_ACTIVE_LOW),
    .gating_type         (`OVL_GATE_NONE))
  u_asrt_s_ahbslv_reset_ready
  ( .clock        (DCLK),
    .reset        (1'b1),
    .enable       (1'b1),
    .start_event  (cfg_ahbslv & ~DBGRESETn),
    .test_expr    (SLVREADY),
    .fire         ());

   // slave must not indicate error during reset

  ovl_next
  #(.severity_level       (`OVL_FATAL),
    .num_cks              (1),
    .check_overlapping    (1),
    .check_missing_start  (0),
    .property_type        (SLAVEASSERT),
    .msg                  ("Slave must not output an ERROR response during reset."),
    .coverage_level       (`OVL_COVER_DEFAULT),
    .clock_edge           (`OVL_POSEDGE),
    .reset_polarity       (`OVL_ACTIVE_LOW),
    .gating_type          (`OVL_GATE_NONE))
  u_asrt_s_ahbslv_reset_resp
  ( .clock        (DCLK),
    .reset        (1'b1),
    .enable       (1'b1),
    .start_event  (~DBGRESETn),
    .test_expr    (~SLVRESP),
    .fire         ());

  // master must not pipeline transactions if not in AHB mode

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(MASTERASSERT),
    .msg("SLV master must not pipeline transactions when not configured into AHB mode."),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_noahb_nopipe
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .antecedent_expr(tx_active & ~cfg_ahbslv),
   .consequent_expr(~SLVTRANS[1]),
   .fire());

  // master must not generate SEQ or BUSY if not in AHB mode

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(MASTERASSERT),
    .msg("Non AHB master must only generate idle or non-sequential transactions"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_noahb_simpletx
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .antecedent_expr(~cfg_ahbslv),
   .consequent_expr(~SLVTRANS[0]),
   .fire());

  // master must hold ADDRESS phase

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(MASTERASSERT),
    .msg("Master must hold address phase stable during non-error wait states."),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_holdaddr_nonerr
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .antecedent_expr(slvtrans_last[1] & ~slvready_last & ~slvresp_last),
   .consequent_expr((SLVADDR  == slvaddr_last) &
                    (SLVSIZE  == slvsize_last) &
                    (SLVPROT  == slvprot_last) &
                    (SLVTRANS == slvtrans_last) &
                    (SLVWRITE == slvwrite_last)),
   .fire());

  // master must either cancel or hold address phase on ERROR

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(MASTERASSERT),
    .msg("Master must hold address phase stable or cancel transfer after an ERROR response."),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_holdaddr_err
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .antecedent_expr(slvtrans_last[1] & ~slvready_last & slvresp_last),
   .consequent_expr(((SLVADDR  == slvaddr_last) &
                     (SLVSIZE  == slvsize_last) &
                     (SLVPROT  == slvprot_last) &
                     (SLVWRITE == slvwrite_last)) |
                    ~SLVTRANS[1]),
   .fire());

  // master must hold control signals (save TRANS) throughout data phase

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(MASTERASSERT),
    .msg("Master must hold control signals stable through data phase"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_holdctrl
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .antecedent_expr(cfg_ahbslv ? 1'b0 : tx_active),
   .consequent_expr((SLVADDR  == slvaddr_last) &
                    (SLVSIZE  == slvsize_last) &
                    (SLVPROT  == slvprot_last) &
                    (SLVWRITE == slvwrite_last)),
   .fire());

  // master must hold WDATA during a write

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(MASTERASSERT),
    .msg("Master must hold write data during a write transaction"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_m_holdwdata
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .antecedent_expr(cfg_ahbslv ? (tx_write & ~slvready_last) : (tx_write | (slvtrans_last[1] & slvwrite_last))),
   .consequent_expr(SLVWDATA[31:0] == slvwdata_last[31:0]),
   .fire());

  // AHB slave may only drop READY whilst a transaction is active

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(SLAVEASSERT),
    .msg("AHBSLV: can only drop ready in response to a transaction"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
  u_asrt_s_ahb_ready
  (.clock(DCLK),
   .reset(DBGRESETn),
   .enable(1'b1),
   .antecedent_expr(cfg_ahbslv & ~SLVREADY),
   .consequent_expr(tx_active),
   .fire());

`endif

endmodule // cm0p_slvpc

