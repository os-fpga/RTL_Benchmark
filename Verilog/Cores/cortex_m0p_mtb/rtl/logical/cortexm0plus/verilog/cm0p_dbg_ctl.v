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
//   Checked In : $Date: 2012-01-12 19:27:00 +0000 (Thu, 12 Jan 2012) $
//   Revision   : $Revision: 197858 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ DEBUG CONTROL AND STATUS REGISTER LOGIC
//-----------------------------------------------------------------------------

module cm0p_dbg_ctl
  #(parameter CBAW = 0,
    parameter RAR  = 0)

   (input  wire        dclk,                // debug clock
    input  wire        dbg_reset_n,         // debug reset

    output wire        dbg_restarted_o,     // core has exited halt
    output wire        halted_o,            // core is halted for debug

    output wire        dbg_c_debugen_o,     // debug enabled
    output wire        dbg_c_maskints_o,    // NVIC should mask IRQs
    output wire        dbg_dwt_en_o,        // watchpoint enabled
    output wire        dbg_halt_req_o,      // request to halt core
    output wire [31:0] dbg_hrdata_o,        // debug control read-data
    output wire        dbg_op_run_o,        // clock DCRSR opcode in core
    output wire        dbg_inv_en_o,        // invasive debug enable

    input  wire        dbgen_i,             // debug enable
    input  wire        dbg_restart_i,       // external unhalt core request
    input  wire        dbg_ext_req_i,       // external halt core request
    input  wire        hready_i,            // AHB ready / core advance

    input  wire        cpu_bpu_event_i,     // breakpoint has hit
    input  wire        cpu_dbg_ex_last_i,   // core retiring an instruction
    input  wire        cpu_dbg_ex_reset_i,  // core in reset state
    input  wire        cpu_dbg_lockup_i,    // core is in LOCKUP
    input  wire        cpu_ex_idle_i,       // core is sleeping / idle
    input  wire        cpu_halt_ack_i,      // core is halted
    input  wire        cpu_int_return_i,    // core returning from interrupt
    input  wire        cpu_int_taken_i,     // core taking interrupt
    input  wire        dwt_event_i,         // watchpoint has hit
    input  wire [ 3:0] dsl_dbg_sels_i,      // debug control register selects
    input  wire        dsl_ppb_write_i,     // register select is for write
    input  wire        cpu_dbg_hardfault_i, // core running in HardFault
    input  wire [31:0] slv_wdata_i);         // register write-data

   // -------------------------------------------------------------------------
   // Configurability
   // -------------------------------------------------------------------------

   wire        cfg_dbg, cfg_rar;

   generate
      if(CBAW == 0) begin : gen_cbaw

         assign cfg_dbg = 1'b1;
         assign cfg_rar = (RAR != 0);

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Debug control state
   // -------------------------------------------------------------------------

   // DHCSR : Debug Halting Control and Status Register.

   reg         c_debugen_q;     // Enable halting debug
   reg         c_halt_q;        // Halt the core
   reg         c_step_q;        // Step the core
   reg         c_maskints_q;    // Mask PendSV, SysTick and IRQs
   reg         s_reset_st_q;    // Sticky core has reset flag
   reg         s_retire_st_q;   // Sticky instruction retired flag

   // DCRSR : Debug Core Register Selector Register.

   reg         dbg_op_run_q;    // Provoke core register read/write

   // DFSR : Debug Fault Status Register.

   reg         dfsr_ext_q;      // EDBGRQ caused halt
   reg         dfsr_vc_q;       // Vector catch caused halt
   reg         dfsr_dwt_q;      // Watchpoint match caused halt
   reg         dfsr_bkpt_q;     // BKPT/breakpoint caused halt
   reg         dfsr_halt_q;     // C_HALT or C_STEP caused halt

   // DEMCR : Debug Exception and Monitor Control Register.

   reg         dwt_ena_q;       // Global watchpoint unit enable
   reg         vc_flt_q;        // Vector catch on faults
   reg         vc_rst_q;        // Vector catch on reset

   // ARM CoreSight debug halt/restart handshake register.

   reg         dbg_restarted_q; // Acknowledge flag

   // --------
   // Mark unused write data bus bits.

   wire [ 9:0] unused = { slv_wdata_i[15:11], slv_wdata_i[9:5] };

   // -------------------------------------------------------------------------
   // Debug authentication
   // -------------------------------------------------------------------------

   // Enable invasive debug when core in debug state so that core can be taken
   // out of debug state even after DBGEN deasserted.

   wire        dbg_inv_en = dbgen_i | cpu_halt_ack_i;

   // -------------------------------------------------------------------------
   // Decode debug control PPB bus reads and writes
   // -------------------------------------------------------------------------

   // Architecture requires that DHCSR only accept writes when the write-data
   // also contains the magic key.

   wire        key_ok       = slv_wdata_i[31:16] == 16'hA05F;

   wire        ppb_dfsr_wr  = dsl_dbg_sels_i[3] &  dsl_ppb_write_i;
   wire        ppb_dhcsr_wr = dsl_dbg_sels_i[2] &  dsl_ppb_write_i & key_ok;
   wire        ppb_dcrsr_wr = dsl_dbg_sels_i[1] &  dsl_ppb_write_i;
   wire        ppb_demcr_wr = dsl_dbg_sels_i[0] &  dsl_ppb_write_i;

   wire        ppb_dhcsr_rd = dsl_dbg_sels_i[2] & ~dsl_ppb_write_i;

   // -------------------------------------------------------------------------
   // Mask step, halt and maskints with c_debugen
   // -------------------------------------------------------------------------

   wire        c_debugen  = dbg_inv_en & c_debugen_q;

   wire        c_halt     = c_debugen & c_halt_q;
   wire        c_step     = c_debugen & c_step_q;
   wire        c_maskints = c_debugen & c_maskints_q;

   // -------------------------------------------------------------------------
   // Define halted flag based on halt request and acknowledge
   // -------------------------------------------------------------------------

   // Factor in C_HALT into S_HALT to ensure that S_HALT is never set if C_HALT
   // is cleared before the core enters halt mode.

   wire        s_halt = cpu_halt_ack_i & c_halt;

   // -------------------------------------------------------------------------
   // Mask DWTENA with C_DEBUGEN before use
   // -------------------------------------------------------------------------

   wire        dwt_en = c_debugen & dwt_ena_q;

   // -------------------------------------------------------------------------
   // Debug core register read/write control
   // -------------------------------------------------------------------------

   // Drive request into core to activate register read/write.

   wire        dbg_op_run_nxt = s_halt & ppb_dcrsr_wr;

   always @(posedge dclk or negedge dbg_reset_n)
      if (~dbg_reset_n)
         dbg_op_run_q <= 1'b0;
      else if (hready_i)
         dbg_op_run_q <= dbg_op_run_nxt;

   // S_REGRDY is always set when the core is halted; register accesses are
   // guaranteed to resolve in a single AHB ready cycle, resulting in the DCRDR
   // already being valid by the time S_REGREADY could be read.

   wire        s_regrdy = s_halt;

   // -------------------------------------------------------------------------
   // CoreSight DBGRESTART/DBGRESTARTED handshake logic
   // -------------------------------------------------------------------------

   wire        set_dbg_restarted = ~dbg_restart_i & ~dbg_restarted_q;
   wire        clr_dbg_restarted = dbg_restart_i & s_halt;

   wire        up_dbg_restarted  = ( hready_i &
                                     (set_dbg_restarted | clr_dbg_restarted) );

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       dbg_restarted_q <= 1'b1;
     else if (up_dbg_restarted)
       dbg_restarted_q <= set_dbg_restarted;

   // -------------------------------------------------------------------------
   // Derive core instruction retirement and step advance
   // -------------------------------------------------------------------------

   // Only real instructions that nominally complete or lockup are marked as
   // being retired.

   wire        i_ret = cpu_dbg_ex_last_i | cpu_dbg_lockup_i;

   // When stepping, an event is generate for instructions completing,
   // exception events and lockup.

   wire        i_adv = cpu_dbg_ex_last_i |  // instruction retirement
                       cpu_int_taken_i   |  // interrupt entry
                       cpu_int_return_i  |  // interrupt exit
                       cpu_dbg_lockup_i;    // lockup

   // -------------------------------------------------------------------------
   // Detect Reset and HardFault vector events
   // -------------------------------------------------------------------------

   wire        vc_flt_trig = vc_flt_q & cpu_int_taken_i & cpu_dbg_hardfault_i;
   wire        vc_rst_trig = vc_rst_q & cpu_dbg_ex_reset_i;
   wire        vc_event    = c_debugen & (vc_flt_trig | vc_rst_trig);

   // -------------------------------------------------------------------------
   // Detect step, halt and external request events
   // -------------------------------------------------------------------------

   // Single stepping will set the C_HALT bit when a valid instruction is in De
   // and is about to be committed to Ex, an interrupt entry or exit occurs, or
   // LOCKUP is encountered.

   wire        step_event   = c_step & ~c_halt & i_adv & hready_i;

   // External events register only if not currently halted.

   wire        ext_event    = c_debugen & dbg_ext_req_i & ~s_halt;

   // C_HALT can only be set when written with C_DEBUGEN.

   wire        wr_halt      = slv_wdata_i[1] & slv_wdata_i[0];
   wire        wr_unhalt    = ppb_dhcsr_wr & ~wr_halt;
   wire        halted_event = (ppb_dhcsr_wr & wr_halt) | step_event;

   // -------------------------------------------------------------------------
   // DHCSR : Debug halt control and status registers
   // -------------------------------------------------------------------------

   wire        set_c_halt = ( halted_event    |  // C_HALT or STEP
                              cpu_bpu_event_i |  // BKPT or BPU match
                              dwt_event_i     |  // Watchpoint hit
                              vc_event        |  // Vector catch
                              ext_event );       // External request

   wire        clr_c_halt = ( wr_unhalt         |    // C_HALT clear
                              set_dbg_restarted |    // CoreSight
                              cpu_dbg_ex_reset_i );  // Core in reset

   wire        up_c_halt = hready_i & (set_c_halt | clr_c_halt);

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       c_halt_q <= 1'b0;
     else if (up_c_halt)
       c_halt_q <= set_c_halt;

   // --------
   // Master debug enable register.

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       c_debugen_q <= 1'b0;
     else if (ppb_dhcsr_wr)
       c_debugen_q <= slv_wdata_i[0];

   generate
      if(CBAW != 0) begin: gen_cbaw0

         // --------
         // CBAW mode.

         wire rar_reset_n = cfg_rar ? dbg_reset_n : 1'b1;

         always @(posedge dclk or negedge rar_reset_n)
           if (~rar_reset_n)
             c_step_q <= 1'b1;
           else if (ppb_dhcsr_wr)
             c_step_q <= slv_wdata_i[2];

         always @(posedge dclk or negedge rar_reset_n)
           if (~rar_reset_n)
             c_maskints_q <= 1'b1;
           else if(ppb_dhcsr_wr)
             c_maskints_q <= slv_wdata_i[3];

      end else if(RAR != 0) begin: gen_rar1

         // --------
         // Reset all register mode.

         wire unused = cfg_rar;

         always @(posedge dclk or negedge dbg_reset_n)
           if (~dbg_reset_n)
             c_step_q <= 1'b1;
           else if (ppb_dhcsr_wr)
             c_step_q <= slv_wdata_i[2];

         always @(posedge dclk or negedge dbg_reset_n)
           if (~dbg_reset_n)
             c_maskints_q <= 1'b1;
           else if(ppb_dhcsr_wr)
             c_maskints_q <= slv_wdata_i[3];

      end else begin: gen_rar0

         // --------
         // Standard non-reset register mode.

         wire unused = cfg_rar;

         always @(posedge dclk)
           if (ppb_dhcsr_wr)
             c_step_q <= slv_wdata_i[2];

         always @(posedge dclk)
           if(ppb_dhcsr_wr)
             c_maskints_q <= slv_wdata_i[3];

      end
   endgenerate

   // --------
   // Sticky reset tracking register.

   wire        up_s_reset_st = ppb_dhcsr_rd | cpu_dbg_ex_reset_i;

   always @(posedge dclk or negedge dbg_reset_n)
      if (~dbg_reset_n)
         s_reset_st_q <= 1'b1;
      else if (up_s_reset_st)
         s_reset_st_q <= cpu_dbg_ex_reset_i;

   // --------
   // Sticky instruction part retire register.

   wire        up_s_retire_st = up_s_reset_st | i_ret;

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       s_retire_st_q <= 1'b0;
     else if (up_s_retire_st)
       s_retire_st_q <= i_ret;

   // -------------------------------------------------------------------------
   // DFSR : Debug fault status register control
   // -------------------------------------------------------------------------

   wire        rdy_dwt_event = hready_i & dwt_event_i;

   wire        up_dfsr_ext  =     ext_event   | (ppb_dfsr_wr & slv_wdata_i[4]);
   wire        up_dfsr_vc   =      vc_event   | (ppb_dfsr_wr & slv_wdata_i[3]);
   wire        up_dfsr_dwt  = rdy_dwt_event   | (ppb_dfsr_wr & slv_wdata_i[2]);
   wire        up_dfsr_bkpt = cpu_bpu_event_i | (ppb_dfsr_wr & slv_wdata_i[1]);
   wire        up_dfsr_halt =  halted_event   | (ppb_dfsr_wr & slv_wdata_i[0]);

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       dfsr_ext_q <= 1'b0;
     else if (up_dfsr_ext)
       dfsr_ext_q <= ext_event;

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       dfsr_vc_q <= 1'b0;
     else if (up_dfsr_vc)
       dfsr_vc_q <= vc_event;

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       dfsr_dwt_q <= 1'b0;
      else if (up_dfsr_dwt)
        dfsr_dwt_q <= dwt_event_i;

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       dfsr_bkpt_q <= 1'b0;
     else if (up_dfsr_bkpt)
       dfsr_bkpt_q <= cpu_bpu_event_i;

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       dfsr_halt_q <= 1'b0;
     else if (up_dfsr_halt)
       dfsr_halt_q <= halted_event;

   // -------------------------------------------------------------------------
   // DEMCR : PPB write logic for exception and monitor control
   // -------------------------------------------------------------------------

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n) begin
        dwt_ena_q <= 1'b0;
        vc_flt_q  <= 1'b0;
        vc_rst_q  <= 1'b0;
     end else if (ppb_demcr_wr) begin
        dwt_ena_q <= slv_wdata_i[24];
        vc_flt_q  <= slv_wdata_i[10];
        vc_rst_q  <= slv_wdata_i[ 0];
     end

   // -------------------------------------------------------------------------
   // Construct architectural registers and PPB read-data
   // -------------------------------------------------------------------------

   // DFSR : Debug Fault Status Register

   wire [31:0] dfsr   = { {27{1'b0}},    // 31: 5 Reserved
                          dfsr_ext_q,    //     4 EXTERNAL
                          dfsr_vc_q,     //     3 VCATCH
                          dfsr_dwt_q,    //     2 DWTTRAP
                          dfsr_bkpt_q,   //     1 BKPT
                          dfsr_halt_q }; //     0 HALTED

   // --------
   // DHCSR : Debug Halting Control and Status Register

   wire [31:0] dhcsr  = { {6{1'b0}},        // 31:26 Reserved
                          s_reset_st_q,     //    25 S_RESET_ST
                          s_retire_st_q,    //    24 S_RETIRE_ST
                          {4{1'b0}},        // 23:20 Reserved
                          cpu_dbg_lockup_i, //    19 S_LOCKUP
                          cpu_ex_idle_i,    //    18 S_SLEEP
                          s_halt,           //    17 S_HALT
                          s_regrdy,         //    16 S_REGRDY
                          {12{1'b0}},       // 15: 4 Reserved
                          c_maskints,       //     3 C_MASKINTS
                          c_step,           //     2 C_STEP
                          c_halt,           //     1 C_HALT
                          c_debugen };      //     0 C_DEBUGEN

   // --------
   // DEMCR : Debug Exception and Monitor Control Register

   wire [31:0] demcr  = { {7{1'b0}},  // 31:25 Reserved
                          dwt_ena_q,  //    24 DWTENA
                          {13{1'b0}}, // 23:11 Reserved
                          vc_flt_q,   //    10 VC_HARDERR
                          {9{1'b0}},  //  9: 1 Reserved
                          vc_rst_q }; //     0 VC_CORERESET

   // --------
   // Debug control PPB read-data mux

   wire [31:0] hrdata = ( {32{dsl_dbg_sels_i[3]}} & dfsr  |
                          {32{dsl_dbg_sels_i[2]}} & dhcsr |
                          {32{dsl_dbg_sels_i[0]}} & demcr );

   // -------------------------------------------------------------------------
   // Output assignments
   // -------------------------------------------------------------------------

   assign     dbg_halt_req_o   = cfg_dbg ? c_halt          :  1'b0;
   assign     dbg_op_run_o     = cfg_dbg ? dbg_op_run_q    :  1'b0;
   assign     dbg_c_debugen_o  = cfg_dbg ? c_debugen       :  1'b0;
   assign     dbg_c_maskints_o = cfg_dbg ? c_maskints      :  1'b0;
   assign     dbg_dwt_en_o     = cfg_dbg ? dwt_en          :  1'b0;
   assign     dbg_hrdata_o     = cfg_dbg ? hrdata          : 32'b0;
   assign     dbg_restarted_o  = cfg_dbg ? dbg_restarted_q :  1'b0;
   assign     halted_o         = cfg_dbg ? s_halt          :  1'b0;
   assign     dbg_inv_en_o     = cfg_dbg ? dbg_inv_en      :  1'b0;

   // -------------------------------------------------------------------------

`ifdef ARM_ASSERT_ON
   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------

 `include "std_ovl_defines.h"

   // --------
   // Register enable X check.

   ovl_never_unknown
     #(.severity_level(`OVL_FATAL),
       .width(12),
       .property_type(`OVL_ASSERT),
       .msg("Register enables must never be X"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_reg_en_x
     (.clock     (dclk),
      .reset     (dbg_reset_n),
      .enable    (1'b1),
      .qualifier (1'b1),
      .test_expr ({ hready_i,
                    up_dbg_restarted,
                    up_c_halt,
                    ppb_dhcsr_wr,
                    up_s_retire_st,
                    up_s_reset_st,
                    up_dfsr_halt,
                    up_dfsr_bkpt,
                    up_dfsr_dwt,
                    up_dfsr_vc,
                    up_dfsr_ext,
                    ppb_demcr_wr }),
      .fire      ());

   // --------
   // Only one register select can be active.

   ovl_zero_one_hot
     #(.severity_level(`OVL_FATAL),
       .width(4),
       .property_type(`OVL_ASSERT),
       .msg("Only one debug register select may be active"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_dsl_dbg_sels_i
     (.clock(dclk),
      .reset(dbg_reset_n),
      .enable(1'b1),
      .test_expr(dsl_dbg_sels_i),
      .fire());

   // --------
   // Parameterisable configuration check.

   ovl_never_unknown
     #(.severity_level(`OVL_FATAL),
       .width(1),
       .property_type(`OVL_ASSERT),
       .msg("DBG config unknown"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_cfg_dbg
     ( .clock(dclk),
       .reset(1'b1),
       .enable(1'b1),
       .qualifier(1'b1),
       .test_expr(cfg_dbg),
       .fire());

`endif

   //--------------------------------------------------------------------------

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
