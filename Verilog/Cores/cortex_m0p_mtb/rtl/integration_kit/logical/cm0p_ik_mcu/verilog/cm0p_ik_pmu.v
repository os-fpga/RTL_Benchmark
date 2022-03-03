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
//   Checked In : $Date: 2012-09-28 16:19:42 +0100 (Fri, 28 Sep 2012) $
//   Revision   : $Revision: 224098 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ EXAMPLE PMU
// This module provides an example Power Managment Unit (PMU) digital component
// that can be used to deploy the CORTEX-M0+ processor with a three power domain
// structure
// 1 - Always on domain (not under the control of this module)
// 2 - A system (SYS) domain
// 3 - A debug (DBG) domain
// State retention is supported for the SYS domain assuming the implementation
// of retention flip-flops.
// No retention is supported for the DBG domain - instead, a reset is forced
// on debug-domain power-up.
// Clock-gating control for all the processor clocks is also supported
// You can modify this module to suit your particular requirements.
// ----------------------------------------------------------------------------

module cm0p_ik_pmu
  (
  // --------------------------------------------------------------------------
  // Inputs/Outputs
  // --------------------------------------------------------------------------

  input  wire    FCLK,
  input  wire    PORESETn,
  input  wire    HRESETREQ,

  input  wire    PMUENABLE,
  input  wire    CDBGPWRUPREQ,
  input  wire    WICENACK,
  input  wire    WAKEUP,
  input  wire    SLEEPDEEP,
  input  wire    SLEEPHOLDACKn,
  input  wire    GATEHCLK,
  input  wire    SYSPWRDOWNACK,
  input  wire    DBGPWRDOWNACK,
  input  wire    DFTSE,

  output wire    HCLK,         // AHB clock
  output wire    DCLK,         // Processor debug clock
  output wire    SCLK,         // Processor system clock
  output reg     WICENREQ,
  output wire    CDBGPWRUPACK, // synchronous to FCLK
  output wire    SLEEPHOLDREQn,
  output wire    SYSISOLATEn,
  output wire    SYSRETAINn,
  output wire    SYSPWRDOWN,
  output wire    DBGISOLATEn,
  output wire    DBGPWRDOWN,
  output wire    PMUDBGRESETREQ,
  output wire    PMUHRESETREQ);

  localparam [1:0] ARM_POWERED_UP    =  2'b00;
  localparam [1:0] ARM_POWERING_DOWN =  2'b01;
  localparam [1:0] ARM_POWERED_DOWN  =  2'b10;
  localparam [1:0] ARM_POWERING_UP   =  2'b11;
  localparam [1:0] ARM_POWER_UNDEF   =  2'bxx;

  reg [1:0] dbg_st;
  reg       dbg_st_en;
  reg [1:0] sys_st;
  reg       sys_st_en;
  reg [1:0] nxt_dbg_st;
  reg [1:0] nxt_sys_st;

  wire      sleepholdack_n_s;
  wire      wicenack_s;
  wire      wakeup_s;
  wire      sleepdeep_s;
  wire      cdbgpwrupreq_s;
  wire      syspwrdownack_s;
  wire      dbgpwrdownack_s;

  // --------------------------------------------------------------------------
  // Synchronizers for inputs
  // --------------------------------------------------------------------------

  // Add synchronizer to SLEEPHOLDACKn since this signal can be reset from
  // HRESETn which can cause metastability issues for the PMU logic which will
  // not be reset since uses only PORESETn.
  // Note: SLEEPHOLDACKn active LOW so reset HIGH.
  cm0p_pmu_sync_set
    u_dbg_holdackn_sync
      (.SYNCSETn (PORESETn),
       .SYNCCLK  (FCLK),
       .SYNCDI   (SLEEPHOLDACKn),
       .SYNCDO   (sleepholdack_n_s));

  // Add synchronizer to WICENACK since this signal is from the WIC which can
  // be run asynchronously from FCLK.
  cm0p_pmu_sync_reset
    u_dbg_wicenack_sync
      (.SYNCRSTn (PORESETn),
       .SYNCCLK  (FCLK),
       .SYNCDI   (WICENACK),
       .SYNCDO   (wicenack_s));

  // Add synchronizer to WAKEUP since this signal is from the WIC which can
  // be run asynchronously from FCLK.
  cm0p_pmu_sync_reset
    u_dbg_wakeup_sync
      (.SYNCRSTn (PORESETn),
       .SYNCCLK  (FCLK),
       .SYNCDI   (WAKEUP),
       .SYNCDO   (wakeup_s));

  // Add synchronizer to SLEEPDEEP since this signal can be reset from HRESETn
  // which can cause metastability issues for the PMU logic which will not be
  // reset since uses only PORESETn.
  cm0p_pmu_sync_reset
    u_dbg_sleepdeep_sync
      (.SYNCRSTn (PORESETn),
       .SYNCCLK  (FCLK),
       .SYNCDI   (SLEEPDEEP),
       .SYNCDO   (sleepdeep_s));

  // Add synchronizer to CDBGPWRUPREQ since this signal is from the DAP which is
  // run in a different clock domain, SWCLKTCK.
  cm0p_pmu_sync_reset
    u_dbg_pupreq_sync
      (.SYNCRSTn (PORESETn),
       .SYNCCLK  (FCLK),
       .SYNCDI   (CDBGPWRUPREQ),
       .SYNCDO   (cdbgpwrupreq_s));

  // SYSPWRDOWNACK is a SRPG signal and logic is added post-synthesis and are
  // synchronized to FCLK since asynchronous in nature.
  cm0p_pmu_sync_set
    u_sys_pdack_sync
      (.SYNCSETn (PORESETn),
       .SYNCCLK  (FCLK),
       .SYNCDI   (SYSPWRDOWNACK),
       .SYNCDO   (syspwrdownack_s));

  // DBGPWRDOWNACK is a SRPG signal and logic is added post-synthesis and are
  // synchronized to FCLK since asynchronous in nature.
  cm0p_pmu_sync_reset
    u_dbg_pdack_sync
      (.SYNCRSTn (PORESETn),
       .SYNCCLK  (FCLK),
       .SYNCDI   (DBGPWRDOWNACK),
       .SYNCDO   (dbgpwrdownack_s));

  // --------------------------------------------------------------------------
  // WIC mode request logic
  // --------------------------------------------------------------------------
  // Set when PMUENABLE is set.
  // Cleared when PMUENABLE is cleared and the SYS domain is powered-up and
  // not in a state of flux.
  wire     set_wicreq  = PMUENABLE;
  wire     clr_wicreq  = ~PMUENABLE & ~sys_st_en & (sys_st == ARM_POWERED_UP);

  always @(posedge FCLK or negedge PORESETn)
    if (!PORESETn)
      WICENREQ <= 1'b0;
    else if (set_wicreq | clr_wicreq)
      WICENREQ <= set_wicreq;

  wire     wic_ds_mode = WICENREQ & wicenack_s;
  wire     in_wic_ds   = wic_ds_mode & sleepdeep_s;

  // Safe to power down SYS domain if we are in WIC-based deepsleep mode
  // and the processor has commited to remaining in sleep mode till we are
  // able to power up again. Also, no power down is allowed if the debugger
  // has requested either domain to be powered-up.
  // Safe to power down DBG domain if the debugger has not requested either
  // domain to be powered-up
  wire     wake_up_dbg = cdbgpwrupreq_s | ~PMUENABLE;
  wire     wake_up_sys = wake_up_dbg | (dbg_st == ARM_POWERING_UP) | wakeup_s | HRESETREQ;
  wire     can_pdw_sys = ~wake_up_sys & in_wic_ds & ~SLEEPHOLDREQn & ~sleepholdack_n_s;
  wire     can_pdw_dbg = ~wake_up_dbg;

  // --------------------------------------------------------------------------
  // Sleep extension logic (only applies to SYS domain)
  // --------------------------------------------------------------------------
  // Assert SLEEPHOLDREQn when a WIC-based sleepdeep_s is seen and hold it
  // until the core is about to be powered-up safely. Note the extra
  // logic required to clear SLEEPHOLDREQn if
  // 1) The processor sleeps but wakes up before sleepholdack_n_s can be
  // asserted (in this case, do not power-down)
  reg      sleepholdreq;
  wire     set_sleepholdreq = ~sleepholdreq & in_wic_ds & ~wake_up_sys;
  wire     clr_sleepholdreq =  sleepholdreq & ~in_wic_ds &
                               ( // SYS domain powered up
                                 (sys_st == ARM_POWERED_UP) |
                                 // sleepdeep_s deasserted before ACK but after REQ
                                 sleepholdack_n_s
                               );

  always @(posedge FCLK or negedge PORESETn)
    if (!PORESETn)
      sleepholdreq <= 1'b0;
    else if (set_sleepholdreq | clr_sleepholdreq)
      sleepholdreq <= set_sleepholdreq;

  // No synchronizer for SLEEPHOLDREQn since run in the FCLK domain.
  //
  assign   SLEEPHOLDREQn    = ~sleepholdreq;

  // --------------------------------------------------------------------------
  // SYS power domain control
  // --------------------------------------------------------------------------
  // ISOLATEn, RETAINn and PWRDOWN are all launched from CDC-safe flops
  // to ensure no glitches

  wire   up_sys_iso  = ( ( sys_st == ARM_POWERING_DOWN) |
                         ((sys_st == ARM_POWERING_UP) & SYSRETAINn) );

  wire   nxt_sys_iso = (sys_st == ARM_POWERING_UP);

  // SYSISOLATEn is a SRPG signal and synchronized to FCLK since asynchronous in
  // nature.
  cm0p_pmu_cdc_send_reset
    u_sysisolaten
      (.REGCLK     (FCLK),
       .REGRESETn  (PORESETn),
       .REGEN      (up_sys_iso),
       .REGDI      (nxt_sys_iso),
       .REGDO      (SYSISOLATEn));

  wire   up_sys_rtn  = ( ((sys_st == ARM_POWERING_DOWN) & ~SYSISOLATEn) |
                         ((sys_st == ARM_POWERING_UP)   & ~SYSPWRDOWN & ~syspwrdownack_s) );

  wire   nxt_sys_rtn = (sys_st == ARM_POWERING_UP);

  // SYSRETAINn is a SRPG signal and synchronized to FCLK since asynchronous in
  // nature.
  cm0p_pmu_cdc_send_reset
    u_sysretainn
      (.REGCLK     (FCLK),
       .REGRESETn  (PORESETn),
       .REGEN      (up_sys_rtn),
       .REGDI      (nxt_sys_rtn),
       .REGDO      (SYSRETAINn));

  wire   up_sys_pdn  = ( ((sys_st == ARM_POWERING_DOWN) & ~SYSRETAINn) |
                         ( sys_st == ARM_POWERING_UP) );

  wire   nxt_sys_pdn = (sys_st == ARM_POWERING_DOWN);

  // SYSPWRDOWN is a SRPG signal and synchronized to FCLK since asynchronous in
  // nature.
  cm0p_pmu_cdc_send_reset
    u_syspwrdown
      (.REGCLK     (FCLK),
       .REGRESETn  (PORESETn),
       .REGEN      (up_sys_pdn),
       .REGDI      (nxt_sys_pdn),
       .REGDO      (SYSPWRDOWN));

  wire   sys_pdw_done = SYSPWRDOWN & syspwrdownack_s;
  wire   sys_pup_done = up_sys_iso & nxt_sys_iso;
  wire   pmu_sclk_en  = (sys_st == ARM_POWERED_UP);

  always @(can_pdw_sys or sys_pdw_done or sys_pup_done
           or sys_st or wake_up_sys)
    case (sys_st)
      ARM_POWERED_UP:
        begin
          sys_st_en  = can_pdw_sys;
          nxt_sys_st = ARM_POWERING_DOWN;
        end
      ARM_POWERING_DOWN:
        begin
          sys_st_en  = sys_pdw_done;
          nxt_sys_st = ARM_POWERED_DOWN;
        end
      ARM_POWERED_DOWN:
        begin
          sys_st_en  = wake_up_sys;
          nxt_sys_st = ARM_POWERING_UP;
        end
      ARM_POWERING_UP:
        begin
          sys_st_en  = sys_pup_done;
          nxt_sys_st = ARM_POWERED_UP;
          end
      default:
        begin
          sys_st_en  = 1'bx;
          nxt_sys_st = ARM_POWER_UNDEF;
        end
    endcase // case(sys_st)

  always @(posedge FCLK or negedge PORESETn)
    if (!PORESETn)
      sys_st <= ARM_POWERING_UP;
    else if (sys_st_en)
      sys_st <= nxt_sys_st;

  // SYS Domain Reset is extended by PMU when it occurs
  // while the domain is powered down
  assign PMUHRESETREQ = HRESETREQ & (sys_st != ARM_POWERED_UP);

  // --------------------------------------------------------------------------
  // DBG power domain state machine
  // --------------------------------------------------------------------------
  // ISOLATEn and PWRDOWN are all launched from CDC-safe flops
  // to ensure no glitches
  // Note: no RETAINn for DBG power domain - reset forced on each power-up

  wire   up_dbg_iso  = ( ( dbg_st == ARM_POWERING_DOWN) |
                         ((dbg_st == ARM_POWERING_UP) & ~DBGPWRDOWN & ~dbgpwrdownack_s &
                          // Delay debug domain power up until system domain up
                          (sys_pup_done | (sys_st == ARM_POWERED_UP))) );

  wire   nxt_dbg_iso = (dbg_st == ARM_POWERING_UP);

  // DBGISOLATEn is a SRPG signal and synchronized to FCLK since asynchronous in
  // nature.
  cm0p_pmu_cdc_send_reset
    u_dbgisolaten
      (.REGCLK     (FCLK),
       .REGRESETn  (PORESETn),
       .REGEN      (up_dbg_iso),
       .REGDI      (nxt_dbg_iso),
       .REGDO      (DBGISOLATEn));

  wire   up_dbg_pdn  = ( ((dbg_st == ARM_POWERING_DOWN) & ~DBGISOLATEn) |
                         ( dbg_st == ARM_POWERING_UP) );

  wire   nxt_dbg_pdn = (dbg_st == ARM_POWERING_DOWN);

  // DBGPWRDOWN is a SRPG signal and synchronized to FCLK since asynchronous in
  // nature.
  cm0p_pmu_cdc_send_set
    u_dbgpwrdown
      (.REGCLK     (FCLK),
       .REGSETn    (PORESETn),
       .REGEN      (up_dbg_pdn),
       .REGDI      (nxt_dbg_pdn),
       .REGDO      (DBGPWRDOWN));

  assign PMUDBGRESETREQ = (dbg_st == ARM_POWERED_DOWN) | (dbg_st == ARM_POWERING_UP);

  wire   dbg_pdw_done      = DBGPWRDOWN & dbgpwrdownack_s;
  wire   dbg_pup_done      = up_dbg_iso & nxt_dbg_iso;
  wire   pmu_dclk_en       = (dbg_st == ARM_POWERED_UP);

  // CDBGPWRUPACK indicates debug domain power state when requested by CDBGPWRUPREQ
  // Note: the 4-phase handshake must be maintained even when the PMU is disabled
  // and power-down does not occur

  wire   nxt_cdbgpwrupack  = (cdbgpwrupreq_s &
                              (dbg_st_en
                               ? (nxt_dbg_st == ARM_POWERED_UP)
                               : (dbg_st     == ARM_POWERED_UP)));

  wire   up_cdbgpwrupack   = ((cdbgpwrupreq_s   ^ CDBGPWRUPACK) &
                              (nxt_cdbgpwrupack ^ CDBGPWRUPACK));

  // The CDBGPWRUPACK signal is synchronized to FCLK.
  cm0p_pmu_cdc_send_reset
    u_cdbgpwrupack
      (.REGCLK     (FCLK),
       .REGRESETn  (PORESETn),
       .REGEN      (up_cdbgpwrupack),
       .REGDI      (nxt_cdbgpwrupack),
       .REGDO      (CDBGPWRUPACK));

  always @(can_pdw_dbg or dbg_pdw_done or dbg_pup_done
           or dbg_st or wake_up_dbg)
    case (dbg_st)
      ARM_POWERED_UP:
        begin
          dbg_st_en  = can_pdw_dbg;
          nxt_dbg_st = ARM_POWERING_DOWN;
        end
      ARM_POWERING_DOWN:
        begin
          dbg_st_en  = dbg_pdw_done;
          nxt_dbg_st = ARM_POWERED_DOWN;
        end
      ARM_POWERED_DOWN:
        begin
          dbg_st_en  = wake_up_dbg;
          nxt_dbg_st = ARM_POWERING_UP;
        end
      ARM_POWERING_UP:
        begin
          dbg_st_en  = dbg_pup_done;
          nxt_dbg_st = ARM_POWERED_UP;
          end
      default:
        begin
          dbg_st_en  = 1'bx;
          nxt_dbg_st = ARM_POWER_UNDEF;
        end
    endcase // case(dbg_st)

  // Note: DBG power domain is OFF out of PORESETn
  always @(posedge FCLK or negedge PORESETn)
    if (!PORESETn)
      dbg_st <= ARM_POWERING_DOWN;
    else if (dbg_st_en)
      dbg_st <= nxt_dbg_st;

  // --------------------------------------------------------------------------
  // Clock gates
  // --------------------------------------------------------------------------
  // Note: the following clock gates can be used even in a single
  // power-domain system

  // The CDBGPWRUPACK term prevents the clock from being gated if there is an
  // active debugger session
  wire hclk_en = pmu_sclk_en & ~(GATEHCLK & ~CDBGPWRUPACK);
  cm0p_pmu_acg  u_hclk
      (.CLKIN  (FCLK),
       .ENABLE (hclk_en),
       .DFTSE  (DFTSE),
       .CLKOUT (HCLK));

  wire dclk_en = pmu_dclk_en;
  cm0p_pmu_acg  u_dclk
      (.CLKIN  (FCLK),
       .ENABLE (dclk_en),
       .DFTSE  (DFTSE),
       .CLKOUT (DCLK));

  wire sclk_en = pmu_sclk_en;
  cm0p_pmu_acg  u_fclk
      (.CLKIN  (FCLK),
       .ENABLE (sclk_en),
       .DFTSE  (DFTSE),
       .CLKOUT (SCLK));

  // --------------------------------------------------------------------------

`ifdef ARM_ASSERT_ON

`include "std_ovl_defines.h"

  // Input assumptions
  ovl_next
    #(.severity_level(`OVL_FATAL),
      .num_cks(1),
      .check_overlapping(1),
      .check_missing_start(0),
      .property_type(`OVL_ASSUME),
      .msg("SYSPWRDOWNACK asserted while SYSPWRDOWN held low"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_syspwrdownack_low
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .start_event((~SYSPWRDOWN) & (~SYSPWRDOWNACK)),
      .test_expr  (( SYSPWRDOWN) | (~SYSPWRDOWNACK)),
      .fire());

  ovl_next
    #(.severity_level(`OVL_FATAL),
      .num_cks(1),
      .check_overlapping(1),
      .check_missing_start(0),
      .property_type(`OVL_ASSUME),
      .msg("SYSPWRDOWNACK deasserted while SYSPWRDOWN held high"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_syspwrdownack_high
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .start_event(( SYSPWRDOWN) & ( SYSPWRDOWNACK)),
      .test_expr  ((~SYSPWRDOWN) | ( SYSPWRDOWNACK)),
      .fire());

  ovl_next
    #(.severity_level(`OVL_FATAL),
      .num_cks(1),
      .check_overlapping(1),
      .check_missing_start(0),
      .property_type(`OVL_ASSUME),
      .msg("DBGPWRDOWNACK asserted while DBGPWRDOWN held low"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_dbgpwrdownack_low
     (.clock(FCLK),
      .reset(PORESETn),
        .enable(1'b1),
      .start_event((~DBGPWRDOWN) & (~DBGPWRDOWNACK)),
      .test_expr  (( DBGPWRDOWN) | (~DBGPWRDOWNACK)),
      .fire());

  ovl_next
    #(.severity_level(`OVL_FATAL),
      .num_cks(1),
      .check_overlapping(1),
      .check_missing_start(0),
      .property_type(`OVL_ASSUME),
      .msg("DBGPWRDOWNACK deasserted while DBGPWRDOWN held high"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_dbgpwrdownack_high
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .start_event(( DBGPWRDOWN) & ( DBGPWRDOWNACK)),
      .test_expr  ((~DBGPWRDOWN) | ( DBGPWRDOWNACK)),
      .fire());

  // State  machines and power-control interface coherence
  ovl_implication
    #(.severity_level(`OVL_FATAL),
      .property_type(`OVL_ASSERT),
      .msg("SYS domain incorrectly powered down"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_sys_pdw_ok
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .antecedent_expr(sys_st == ARM_POWERED_DOWN),
      .consequent_expr(~SYSISOLATEn & ~SYSRETAINn & SYSPWRDOWN & syspwrdownack_s),
      .fire());

  ovl_implication
    #(.severity_level(`OVL_FATAL),
      .property_type(`OVL_ASSERT),
      .msg("SYS domain incorrectly powered up"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_sys_pup_ok
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .antecedent_expr(sys_st == ARM_POWERED_UP),
      .consequent_expr(SYSISOLATEn & SYSRETAINn & ~SYSPWRDOWN & ~syspwrdownack_s),
      .fire());

  ovl_implication
    #(.severity_level(`OVL_FATAL),
      .property_type(`OVL_ASSERT),
      .msg("DBG domain incorrectly powered down"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_dbg_pdw_ok
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .antecedent_expr(dbg_st == ARM_POWERED_DOWN),
      .consequent_expr(~DBGISOLATEn & DBGPWRDOWN & dbgpwrdownack_s),
      .fire());

  ovl_implication
    #(.severity_level(`OVL_FATAL),
      .property_type(`OVL_ASSERT),
      .msg("DBG domain incorrectly powered up"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_dbg_pup_ok
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .antecedent_expr(dbg_st == ARM_POWERED_UP),
      .consequent_expr(DBGISOLATEn & ~DBGPWRDOWN & ~dbgpwrdownack_s & ~PMUDBGRESETREQ),
      .fire());

  ovl_always
    #(.severity_level(`OVL_ERROR),
      .property_type(`OVL_ASSERT),
      .msg("SCLK gating inconsistent with SYS domain power status"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_sclk_pwr
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .test_expr(sclk_en == (sys_st == ARM_POWERED_UP)),
      .fire());

  ovl_implication
    #(.severity_level(`OVL_FATAL),
      .property_type(`OVL_ASSERT),
      .msg("HCLK running when SCLK gated"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_hclk_sclk
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .antecedent_expr(hclk_en),
      .consequent_expr(sclk_en),
      .fire());

  ovl_always
    #(.severity_level(`OVL_FATAL),
      .property_type(`OVL_ASSERT),
      .msg("DCLK gating inconsistent with DBG domain power status"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_dclk_pwr
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .test_expr(dclk_en == (dbg_st == ARM_POWERED_UP)),
      .fire());

  ovl_implication
    #(.severity_level(`OVL_FATAL),
      .property_type(`OVL_ASSERT),
      .msg("SYS domain not powered up when DBG domain is powered up"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_dbg_sys_pwr
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .antecedent_expr(dbg_st == ARM_POWERED_UP),
      .consequent_expr(sys_st == ARM_POWERED_UP),
      .fire());

  ovl_implication
    #(.severity_level(`OVL_FATAL),
      .property_type(`OVL_ASSERT),
      .msg("Power state or clock enables inconsistent with CDBGPWRUPACK"),
      .coverage_level(`OVL_COVER_DEFAULT),
      .clock_edge(`OVL_POSEDGE),
      .reset_polarity(`OVL_ACTIVE_LOW),
      .gating_type(`OVL_GATE_NONE))
   u_cdbgpwrupack_pwr_clks
     (.clock(FCLK),
      .reset(PORESETn),
      .enable(1'b1),
      .antecedent_expr(CDBGPWRUPACK),
      .consequent_expr((sys_st == ARM_POWERED_UP) & (dbg_st == ARM_POWERED_UP) &
                       sclk_en & hclk_en & dclk_en),
      .fire());

`endif

endmodule // cm0p_ik_pmu


