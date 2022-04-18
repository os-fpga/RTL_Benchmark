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
//   Checked In : $Date: 2011-12-30 10:51:05 +0000 (Fri, 30 Dec 2011) $
//   Revision   : $Revision: 196368 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+DAP DP AND AP INTERCONNECT LEVEL
//-----------------------------------------------------------------------------

module cm0p_dap_top
  #(parameter CBAW    = 0,
    parameter JTAGnSW = 0,       //1 -> JTAG, 0 -> SW
    parameter SWMD    = 0,       //1 -> For Serial Wire multi-drop support
    parameter USER    = 0,       //0 -> SLVPROT user/priv bit is RO
    parameter MPU     = 0,       //0 -> SLVPROT cacheable/bufferable bits RO
    parameter HALTEV  = 0,       //1 -> Debug halt event is supported
    parameter RAR     = 0        //1 -> Resets on all Registers, 0 -> Non-RAR
    )
   (// CLOCK AND RESETS -------------------------------------------------------
    input  wire        swclktck,       // SW/JTAG DP clock
    input  wire        dpreset_n,      // Negative sense power-on reset for DP
    input  wire        dclk,           // AP clock
    input  wire        apreset_n,      // Negative sense power-on reset for AP

    // JTAG-DP ----------------------------------------------------------------
    input  wire        n_trst,         // JTAG test logic reset signal
    input  wire        tdi_i,          // JTAG data in
    output wire        tdo_o,          // JTAG data out
    output wire        ntdoen_o,       // JTAG TDO Output Enable

    // SERIAL WIRE-DP ---------------------------------------------------------
    input  wire        swditms_i,      // SW data in/JTAG TMS
    output wire        swdo_o,         // SW data out
    output wire        swdoen_o,       // SW data out enable
    output wire        swdetect_o,     // SW line reset Detect

    // HALT EVENT -------------------------------------------------------------
    input  wire        halted_i,       // Processor halted

    // POWER MANAGEMENT -------------------------------------------------------
    output wire        cdbgpwrupreq_o, // Debug Power Up Request
    input  wire        cdbgpwrupack_i, // Debug Power Up Acknowledge

    // AP ENABLE --------------------------------------------------------------
    input  wire        deviceen_i,     // Debug enabled by system

    // DEBUG SLAVE PORT -------------------------------------------------------
    output wire [31:0] slvaddr_o,      // Bus address
    output wire [31:0] slvwdata_o,     // Bus write data
    output wire [1:0]  slvtrans_o,     // Bus transfer valid
    output wire [3:0]  slvprot_o,      // Bus transaction protection
    output wire        slvwrite_o,     // Bus write/not read
    output wire [1:0]  slvsize_o,      // Bus Access Size
    input  wire [31:0] slvrdata_i,     // Bus read data
    input  wire        slvready_i,     // Bus Ready from bus
    input  wire        slvresp_i,      // Bus Response from bus

    // CONFIGURATION ----------------------------------------------------------
    input  wire [31:0] baseaddr_i,     // AP ROM Table Base
    input  wire [31:0] targetid_i,     // 31:28=TREVISION 27:12=TPARTNO 11:1=TDESIGNER 0=1
    input  wire [3:0]  instanceid_i,   // DLPIDR[31:28] for Serial Wire protocol 2
    input  wire [7:0]  ecorevnum_i,    // Top 4 bits = DP Revision, Bottom 4 = AP Revision

    // SCAN/TEST IO -----------------------------------------------------------
    input  wire        DFTSE           // Scan enable for DFT
    );

// ----------------------------------------------------------------------------
// Signal declarations
// ----------------------------------------------------------------------------

  // - Internal Signals
  wire [37:0] cm0p_dap_dp_to_ap;      //DP Outputs
  wire [33:0] cm0p_dap_ap_to_dp;      //AP Outputs

  //Split Configuration Bus
  wire [3:0]  dp_ecorevnum = ecorevnum_i[7:4];
  wire [3:0]  ap_ecorevnum = ecorevnum_i[3:0];

//------------------------------------------------------------------------------
// Instantiate DP & AP
//------------------------------------------------------------------------------
  //Instantiate DP
  cm0p_dap_dp
    #(.CBAW       (CBAW),
      .JTAGnSW    (JTAGnSW),
      .SWMD       (SWMD),
      .HALTEV     (HALTEV),
      .RAR        (RAR))
      u_dp (// Top Level IO
            .swclktck               (swclktck),
            .dpreset_n              (dpreset_n),
            .n_trst                 (n_trst),
            .tdo_o                  (tdo_o),
            .n_tdoen_o              (ntdoen_o),
            .tdi_i                  (tdi_i),
            .swditms_i              (swditms_i),
            .swdo_o                 (swdo_o),
            .swdoen_o               (swdoen_o),
            .swdetect_o             (swdetect_o),
            .halted_i               (halted_i),
            .cdbgpwrupreq_o         (cdbgpwrupreq_o),
            .cdbgpwrupack_i         (cdbgpwrupack_i),
            //Internal IO
            .dap_ap_to_dp_i         (cm0p_dap_ap_to_dp),
            .dap_dp_to_ap_o         (cm0p_dap_dp_to_ap),
            //Configuration
            .targetid_i             (targetid_i),
            .instanceid_i           (instanceid_i),
            .ecorevnum_i            (dp_ecorevnum),
            // Scan Enable for DFT
            .DFTSE                  (DFTSE)
            );

  //Instantiate AP
  cm0p_dap_ap
    #(.CBAW       (CBAW),
      .USER       (USER),
      .MPU        (MPU),
      .RAR        (RAR))
      u_ap (
            //Top Level I/O
            .dclk                   (dclk),
            .apreset_n              (apreset_n),
            .deviceen_i             (deviceen_i),
            .slvrdata_i             (slvrdata_i),
            .slvwdata_o             (slvwdata_o),
            .slvaddr_o              (slvaddr_o),
            .slvtrans_o             (slvtrans_o),
            .slvprot_o              (slvprot_o),
            .slvwrite_o             (slvwrite_o),
            .slvready_i             (slvready_i),
            .slvresp_i              (slvresp_i),
            .slvsize_o              (slvsize_o),
            .ap_base_reg_i          (baseaddr_i),
            //Internal IO
            .dap_dp_to_ap_i         (cm0p_dap_dp_to_ap),
            .dap_ap_to_dp_o         (cm0p_dap_ap_to_dp),
            //Configuration
            .ecorevnum_i            (ap_ecorevnum),
            // Scan Enable for DFT
            .DFTSE                  (DFTSE)
            );

// ----------------------------------------------------------------------------
// Assertions
// ----------------------------------------------------------------------------
`ifdef ARM_ASSERT_ON
 `include "std_ovl_defines.h"

 `ifdef CM0P_INVARIANTS_ON
   `include "cm0p_dap_invariants.v"


 `endif

  // The AP base register value is driven from pins, and should be tied to the
  // correct value at the integration level, so it should never be X. This
  // assert firing indicates a problem at integration level.
   ovl_never_unknown
     #(.severity_level      (`OVL_FATAL),
       .width               (32),
       .property_type       (`OVL_ASSERT),
       .msg                 ("AP ROM Table Base Register pins must be driven."),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_xcheck_ap_base_reg
     (
      .clock      (dclk),
      .reset      (apreset_n),
      .enable     (1'b1),
      .qualifier  (1'b1),
      .test_expr  (baseaddr_i),
      .fire       ()
    );

  // The ECOREVNUM pins are directly connected to the DPIDR and APIDR revision
  // fields, and should never be X. The default configuration should be to tie
  // them low.
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
       .width               (8),
       .property_type       (`OVL_ASSERT),
       .msg                 ("ID Register Revision Fields (ecorevnum_i pins) must be driven."),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_xcheck_ecorevnum
     (
      .clock      (swclktck),
      .reset      (dpreset_n),
      .enable     (1'b1),
      .qualifier  (1'b1),
      .test_expr  (ecorevnum_i),
      .fire       ()
      );

  ovl_always
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("baseaddr_i is assumed to be valid"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
   u_asrt_baseaddr_valid
     (
      .clock      (dclk),
      .reset      (apreset_n),
      .enable     (1'b1),
      .test_expr  (baseaddr_i[11:1] == 11'b00000000001),
      .fire       ()
    );

  // CDC Assertions
  // The CDC is split into two blocks, one in the AP and one in the DP, the
  // asserts for them therefore need to be in the top level
  // - Two checks are used, one in each clock domain. This is because enables
  // are allowed to glitch wrt their own clock.
  // - Output Enables
  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP and DP Output Enables Should never be asserted together"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_never_simul_out_enables_apdom
        ( .clock      (dclk),
          .reset      (apreset_n),
          .enable     (1'b1),
          .test_expr  ((u_dp.dp_out_en |
                        u_dp.dp_err_out_en) &
                       u_ap.ap_out_en),
          .fire       ());

  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP and DP Output Enables Should never be asserted together"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_never_simul_out_enables_dpdom
        ( .clock      (swclktck),
          .reset      (dpreset_n),
          .enable     (1'b1),
          .test_expr  ((u_dp.dp_out_en |
                        u_dp.dp_err_out_en) &
                       u_ap.ap_out_en),
          .fire       ());


  // - Write Enables
  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP and DP Write Enables Should never be asserted together"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_never_simul_write_enables_apdom
        (  .clock      (dclk),
           .reset      (apreset_n),
           .enable     (1'b1),
           .test_expr  (u_dp.dp_wr_en &
                        u_ap.ap_wr_en),
           .fire       ());

  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP and DP Write Enables Should never be asserted together"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_never_simul_write_enables_dpdom
        (  .clock      (swclktck),
           .reset      (dpreset_n),
           .enable     (1'b1),
           .test_expr  (u_dp.dp_wr_en &
                        u_ap.ap_wr_en),
           .fire       ());

  //2 Phase Handshake Protocol Checking
  // - Check at least 2 cycles between DP initiating a transaction and seeing
  // that AP has completed (this is minimum delay through synchroniser). Also
  // check that a DP does not deassert its request before seeing the
  // transaction has completed.
  ovl_handshake
    #(.severity_level      (`OVL_FATAL),
      .min_ack_cycle(2),//2 Cycles between DP starting tx and seeing it complete
      .max_ack_cycle(0),//No upper bound on time between starting tx and it completing
      .req_drop(1),//DP must hold its request high until it sees the acknowledge
      .deassert_count(0),//Deassert Count not checked
      .max_ack_length(0),//Max Ack Length not checked
      .property_type       (`OVL_ASSERT),
      .msg                 ("DP/AP Handshaking violated"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_dp_ap_handshake_check
        ( .clock        (swclktck),
          .reset        (dpreset_n),
          .enable       (1'b1),
          .req          (u_dp.dp_req_dp),
          .ack          (u_dp.ap_ack_dp),
          .fire         () );

  // - Perform the same check in the AP domain, with req and ack inverted
  // (the AP's Ack is essentially a Req to the DP for another transaction)
  ovl_handshake
    #(.severity_level      (`OVL_FATAL),
      .min_ack_cycle(2),
      .max_ack_cycle(0),//No upper bound on time between starting tx and it completing
      .req_drop(1),
      .deassert_count(0),//Deassert Count not checked
      .max_ack_length(0),//Max Ack Length not checked
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP/DP Handshaking violated"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_ap_dp_handshake_check
        ( .clock        (dclk),
          .reset        (apreset_n),
          .enable       (1'b1),
          .req          (~u_dp.ap_ack_ap),
          .ack          (u_ap.dp_req_ap),
          .fire         () );

  // - Check that control is only ever given and not taken
  // - In the AP this means that ACK is only ever changed to be the same as REQ,
  // never changed so that it is different
  ovl_always_on_edge
    #(.severity_level      (`OVL_FATAL),
      .edge_type(`OVL_ANYEDGE),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP Can only grant control, not request it"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_ap_handshake_control
        ( .clock            (dclk),
          .reset            (apreset_n),
          .enable           (1'b1),
          .sampling_event   (u_dp.ap_ack_ap),
          .test_expr        (u_dp.ap_ack_ap ==
                             u_ap.dp_req_ap),
          .fire             () );

  // - In the DP this means that ACK is only ever changed to be the opposite to
  // REQ, never changed so that it is the same
  ovl_always_on_edge
    #(.severity_level      (`OVL_FATAL),
      .edge_type(`OVL_ANYEDGE),
      .property_type       (`OVL_ASSERT),
      .msg                 ("DP Can only grant control, not request it"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_dp_handshake_control
        ( .clock            (swclktck),
          .reset            (dpreset_n),
          .enable           (1'b1),
          .sampling_event   (u_dp.dp_req_dp),
          .test_expr        (u_dp.dp_req_dp !=
                             u_dp.ap_ack_dp),
          .fire             () );

  // - Check that AP control outputs to the shared resource are never asserted
  // when the AP does not have control
  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP Signals to shared block can not be asserted when AP not in control"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_ap_shared_control_violation
        ( .clock      (dclk),
          .reset      (apreset_n),
          .enable     (1'b1),
          .test_expr  ( (u_dp.ap_ack_ap ==
                         u_ap.dp_req_ap) &
                        (u_ap.ap_out_en |
                         u_ap.ap_wr_en) ),
          .fire       () );

  // - Check that DP control outputs to the shared resource are never asserted
  // when the DP does not have control
  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("DP Signals to shared block can not be asserted when DP not in control"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_dp_shared_control_violation
        ( .clock            (swclktck),
          .reset            (dpreset_n),
          .enable           (1'b1),
          .test_expr        ( (u_dp.dp_req_dp !=
                               u_dp.ap_ack_dp) &
                              (u_dp.dp_out_en |
                               u_dp.dp_err_out_en |
                               u_dp.dp_wr_en) ),
          .fire             () );

  // Input assumptions

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks(1),
      .check_overlapping(1),
      .check_missing_start(0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("CDBGPWRUP 4-phase handshake: cdbgpwrupack_i must be deasserted out of reset"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
   u_asrt_cdbgpwrupack_reset
     (
      .clock        (swclktck),
      .reset        (1'b1),
      .enable       (1'b1),
      .start_event  ((~dpreset_n)),
      .test_expr    ((~dpreset_n) | (~cdbgpwrupack_i)),
      .fire         ()
      );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks(1),
      .check_overlapping(1),
      .check_missing_start(0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("CDBGPWRUP 4-phase handshake: cdbgpwrupack_i only rises if requested"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_cdbgpwrupack_rising
      (
       .clock        (swclktck),
       .reset        (dpreset_n),
       .enable       (1'b1),
       .start_event  ((~cdbgpwrupreq_o) & (~cdbgpwrupack_i)),
       .test_expr    (( cdbgpwrupreq_o) | (~cdbgpwrupack_i)),
       .fire         ()
       );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks(1),
      .check_overlapping(1),
      .check_missing_start(0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("CDBGPWRUP 4-phase handshake: cdbgpwrupack_i only falls if requested"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
   u_asrt_cdbgpwrupack_falling
     (
      .clock        (swclktck),
      .reset        (dpreset_n),
      .enable       (1'b1),
      .start_event  (( cdbgpwrupreq_o) & ( cdbgpwrupack_i)),
      .test_expr    ((~cdbgpwrupreq_o) | ( cdbgpwrupack_i)),
      .fire         ()
      );

  // Provide an extended version of apreset_n that will be observed at swclktck
  reg apreset_n_swclktck;
  always @(posedge swclktck or negedge apreset_n)
    if (!apreset_n)
      apreset_n_swclktck <= 1'b0;
    else
      apreset_n_swclktck <= 1'b1;

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks(1),
      .check_overlapping(1),
      .check_missing_start(0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("apreset_n must not become asserted whilst powered up"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
   u_asrt_reset_cdbgpwrupack
      (
       .clock        (swclktck),
       .reset        (dpreset_n),
       .enable       (1'b1),
       .start_event  (apreset_n_swclktck & ( (cdbgpwrupreq_o & cdbgpwrupack_i))),
       .test_expr    (apreset_n_swclktck | (~(cdbgpwrupreq_o & cdbgpwrupack_i))),
       .fire         ()
       );



`endif

endmodule
