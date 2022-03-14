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
//   Checked In : $Date: 2012-01-10 12:23:46 +0000 (Tue, 10 Jan 2012) $
//   Revision   : $Revision: 197289 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ DEBUG SUB-MODULE INTERCONNECT LEVEL
//-----------------------------------------------------------------------------

module cm0p_top_dbg
  #(parameter CBAW   = 0,
    parameter AHBSLV = 1,
    parameter BKPT   = 4,
    parameter IOP    = 0,
    parameter MPU    = 0,
    parameter RAR    = 0,
    parameter WPT    = 2)

   (input  wire        dclk,                // Debug clock
    input  wire        dbg_reset_n,         // Debug reset

    output wire        dbg_restarted_o,     // Restarted from halt
    output wire        halted_o,            // Core halted for debug
    output wire [31:0] slv_rdata_o,         // SLV port read-data
    output wire        slv_ready_o,         // SLV port ready
    output wire        slv_resp_o,          // SLV port error response

    input  wire        niden_i,             // Non-invasive debug enable
    input  wire        dbgen_i,             // Debug enable
    input  wire        dbg_restart_i,       // Core restart request
    input  wire        dbg_ext_req_i,       // External debug request
    input  wire [15:0] eco_rev_num_19to4_i, // Revision number ECO bits
    input  wire [31:0] slv_addr_i,          // SLV address
    input  wire [ 3:0] slv_prot_i,          // SLV transaction protection
    input  wire [ 1:0] slv_size_i,          // SLV size
    input  wire        slv_stall_i,         // SLV stall
    input  wire [ 1:0] slv_trans_i,         // SLV transaction
    input  wire [31:0] slv_wdata_i,         // SLV write-data
    input  wire        slv_write_i,         // SLV write not read

    output wire [82:0] dbg_to_sys_o,        // Channel to system domain
    input wire [145:0] sys_to_dbg_i);       // Channel from system domain

   // -------------------------------------------------------------------------
   // Local wires
   // -------------------------------------------------------------------------

   wire [31:0] bpu_hrdata;       // Read data from breakpoint unit
   wire [31:0] dbg_hrdata;       // Read data from debug control
   wire        dbg_dwt_en;       // Watchpoint unit enable
   wire        dwt_event;        // Watchpoint unit triggered flag
   wire [31:0] dsl_hrdata;       // Read data from CoreSight IDs
   wire [ 7:0] dsl_dwt_sels;     // Register selects for DWT
   wire [ 4:0] dsl_bpu_sels;     // Register selects for BPU
   wire [ 3:0] dsl_dbg_sels;     // Register selects for debug CTL
   wire        dsl_ppb_write;    // Debugger register write
   wire        dsl_ppb_usr_err;  // Debugger user PPB access error
   wire [31:0] dwt_hrdata;       // Read data from watchpoint unit
   wire        dbg_inv_en;       // Invasive debug enabled

   // -------------------------------------------------------------------------
   // Debug to system domain output bundling
   // -------------------------------------------------------------------------

   wire [ 1:0] bpu_match_o;           // Breakpoint hit on top/bottom 16-bits
   wire        dbg_c_debugen_o;       // Debug is enabled
   wire        dbg_c_maskints_o;      // NVIC should ignore prioritizable IRQs
   wire        dbg_halt_req_o;        // Halt request to core
   wire        dbg_op_run_o;          // Debug register read/write request
   wire [31:0] dif_addr_o;            // Debugger address to matrix
   wire [ 1:0] dif_size_o;            // Debugger transaction size for matrix
   wire        dif_spec_trans_o;      // Debugger speculative transaction
   wire        dif_aphase_o;          // Debugger in address-phase
   wire [ 1:0] dif_cb_o;              // Debugger transaction cacheability
   wire        dif_priv_o;            // Debugger transaction privileged
   wire        dsl_acc_ok_o;          // Debugger PPB transaction allowed
   wire [31:0] dif_wdata_o;           // Debugger write-data
   wire        dif_write_o;           // Debugger write request
   wire        dif_cpu_force_idle_o;  // Debugger force core idle
   wire [ 1:0] dsl_cid_sels_o;        // Debugger selects for core IDs
   wire        dsl_ppb_active_o;      // Debugger active on PPB

   assign      dbg_to_sys_o = { bpu_match_o[1:0],
                                dbg_c_debugen_o,
                                dbg_c_maskints_o,
                                dbg_halt_req_o,
                                dbg_op_run_o,
                                dif_addr_o[31:0],
                                dif_size_o[1:0],
                                dif_spec_trans_o,
                                dif_aphase_o,
                                dif_cb_o[1:0],
                                dif_priv_o,
                                dsl_acc_ok_o,
                                dif_wdata_o[31:0],
                                dif_write_o,
                                dif_cpu_force_idle_o,
                                dsl_cid_sels_o[1:0],
                                dsl_ppb_active_o };

   // -------------------------------------------------------------------------
   // System to debug domain input un-bundling
   // -------------------------------------------------------------------------

   wire        cpu_dwt_trans_i;      // Core transaction valid for watchpoints
   wire [31:0] cpu_addr_a_i;         // Core AHB/PPB address for watchpoints
   wire [29:0] cpu_haddr_31to2_i;    // Core AHB/PPB address for breakpoints
   wire        cpu_ex_idle_i;        // Core sleeping / idle
   wire        cpu_bpu_event_i;      // Core executed BKPT or breakpoint
   wire        cpu_dbg_ex_last_i;    // Core is retiring an instruction
   wire        cpu_dbg_ex_reset_i;   // Core is in reset state
   wire        cpu_dbg_lockup_i;     // Core is in LOCKUP
   wire        cpu_dwt_ia_ok_i;      // IAEX valid for PC match
   wire        cpu_halt_ack_i;       // Core has halted
   wire        cpu_write_a_i;        // Core HWRITE for watchpoints
   wire [ 1:0] cpu_ls_size_i;        // Core data-transaction size
   wire        cpu_int_return_i;     // Core returning from interrupt
   wire        cpu_int_taken_i;      // Core taking interrupt
   wire [31:0] mtx_dif_rdata_i;      // Debug interface NVIC/AHB read-data
   wire        mtx_dif_resp_i;       // Debug interface AHB error response
   wire        mtx_dif_slot_i;       // Debug transaction request acceptable
   wire [30:0] cpu_dwt_iaex_i;       // Instruction address for WPT PCSR
   wire        cpu_pipefull_i;       // Core pipeline is full
   wire        cpu_dbg_hardfault_i;  // Core running in/entering HardFault
   wire        iaex_en_i;            // Instruction address in exe enable
   wire        hready_i;             // AHB ready / core advance
   wire        mtx_dif_io_hit_i;     // Debug interface data ready
   wire        cpu_wphase_i;         // Core in AHB write-data-phase

   assign      { cpu_dwt_trans_i,
                 cpu_addr_a_i[31:0],
                 cpu_haddr_31to2_i[29:0],
                 cpu_ex_idle_i,
                 cpu_bpu_event_i,
                 cpu_dbg_ex_last_i,
                 cpu_dbg_ex_reset_i,
                 cpu_dbg_lockup_i,
                 cpu_dwt_ia_ok_i,
                 cpu_halt_ack_i,
                 cpu_write_a_i,
                 cpu_ls_size_i[1:0],
                 cpu_int_return_i,
                 cpu_int_taken_i,
                 mtx_dif_rdata_i[31:0],
                 mtx_dif_resp_i,
                 mtx_dif_slot_i,
                 cpu_dwt_iaex_i[30:0],
                 cpu_pipefull_i,
                 cpu_dbg_hardfault_i,
                 iaex_en_i,
                 hready_i,
                 mtx_dif_io_hit_i,
                 cpu_wphase_i } = sys_to_dbg_i;

   // -------------------------------------------------------------------------
   // Debug control logic instantiation
   // -------------------------------------------------------------------------

   cm0p_dbg_ctl
     #(.CBAW(CBAW), .RAR(RAR))
   u_ctl
     (.dclk                 (dclk),
      .dbg_reset_n          (dbg_reset_n),

      .halted_o             (halted_o),
      .dbg_restarted_o      (dbg_restarted_o),

      .dbg_c_debugen_o      (dbg_c_debugen_o),
      .dbg_c_maskints_o     (dbg_c_maskints_o),
      .dbg_dwt_en_o         (dbg_dwt_en),
      .dbg_halt_req_o       (dbg_halt_req_o),
      .dbg_hrdata_o         (dbg_hrdata[31:0]),
      .dbg_op_run_o         (dbg_op_run_o),
      .dbg_inv_en_o         (dbg_inv_en),

      .dbgen_i              (dbgen_i),
      .dbg_restart_i        (dbg_restart_i),
      .dbg_ext_req_i        (dbg_ext_req_i),
      .hready_i             (hready_i),

      .cpu_bpu_event_i      (cpu_bpu_event_i),
      .cpu_dbg_ex_last_i    (cpu_dbg_ex_last_i),
      .cpu_dbg_ex_reset_i   (cpu_dbg_ex_reset_i),
      .cpu_dbg_lockup_i     (cpu_dbg_lockup_i),
      .cpu_ex_idle_i        (cpu_ex_idle_i),
      .cpu_halt_ack_i       (cpu_halt_ack_i),
      .cpu_int_return_i     (cpu_int_return_i),
      .cpu_int_taken_i      (cpu_int_taken_i),
      .dwt_event_i          (dwt_event),
      .dsl_dbg_sels_i       (dsl_dbg_sels[3:0]),
      .dsl_ppb_write_i      (dsl_ppb_write),
      .cpu_dbg_hardfault_i  (cpu_dbg_hardfault_i),
      .slv_wdata_i          (slv_wdata_i[31:0]));

   // -------------------------------------------------------------------------
   // Breakpoint unit (BPU) instantiation
   // -------------------------------------------------------------------------

   // If the number of breakpoint comparators is greater than zero, then
   // instantiate the BPU, otherwise just tie the outputs to zero.

   generate
      if((CBAW != 0) || (BKPT != 0)) begin: gen_bpu1

         cm0p_dbg_bpu
           #(.CBAW(CBAW), .BKPT(BKPT), .RAR(RAR))
         u_bpu
           (.dclk               (dclk),
            .dbg_reset_n        (dbg_reset_n),

            .bpu_hrdata_o       (bpu_hrdata[31:0]),
            .bpu_match_o        (bpu_match_o[1:0]),

            .hready_i           (hready_i),

            .cpu_haddr_31to2_i  (cpu_haddr_31to2_i[29:0]),
            .dbg_c_debugen_i    (dbg_c_debugen_o),
            .dsl_bpu_sels_i     (dsl_bpu_sels[4:0]),
            .dsl_ppb_write_i    (dsl_ppb_write),
            .slv_wdata_i        (slv_wdata_i[31:0]));

      end else begin: gen_bpu0

         assign { bpu_hrdata[31:0], bpu_match_o[1:0] }  = 34'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Watchpoint unit (DWT) instantiation
   // -------------------------------------------------------------------------

   // If the number of watchpoint comparators is greater than zero, then
   // instantiate the DWT, otherwise just tie the outputs to zero.

   generate
      if ((CBAW != 0) || (WPT != 0)) begin: gen_dwt1

         cm0p_dbg_dwt
           #(.CBAW(CBAW), .RAR(RAR), .WPT(WPT))
         u_dwt
           (.dclk             (dclk),
            .dbg_reset_n      (dbg_reset_n),

            .dwt_event_o      (dwt_event),
            .dwt_hrdata_o     (dwt_hrdata[31:0]),

            .hready_i         (hready_i),

            .cpu_addr_a_i     (cpu_addr_a_i[31:0]),
            .cpu_dwt_trans_i  (cpu_dwt_trans_i),
            .cpu_write_a_i    (cpu_write_a_i),
            .cpu_ls_size_i    (cpu_ls_size_i[1:0]),
            .cpu_dwt_ia_ok_i  (cpu_dwt_ia_ok_i),
            .halted_i         (halted_o),
            .dbg_dwt_en_i     (dbg_dwt_en),
            .dsl_dwt_sels_i   (dsl_dwt_sels[7:0]),
            .dsl_ppb_write_i  (dsl_ppb_write),
            .cpu_dwt_iaex_i   (cpu_dwt_iaex_i[30:0]),
            .cpu_pipefull_i   (cpu_pipefull_i),
            .slv_wdata_i      (slv_wdata_i[31:0]));

   end else begin: gen_dwt0

      assign { dwt_event, dwt_hrdata[31:0] } = 33'b0;

   end endgenerate

   // -------------------------------------------------------------------------
   // Debug bus interface unit instantiation
   // -------------------------------------------------------------------------

   cm0p_dbg_if
     #(.CBAW(CBAW), .AHBSLV(AHBSLV), .IOP(IOP), .MPU(MPU), .RAR(RAR))
   u_if
     (.dclk                  (dclk),
      .dbg_reset_n           (dbg_reset_n),

      .slv_rdata_o           (slv_rdata_o[31:0]),
      .slv_ready_o           (slv_ready_o),
      .slv_resp_o            (slv_resp_o),

      .dif_addr_o            (dif_addr_o[31:0]),
      .dif_size_o            (dif_size_o[1:0]),
      .dif_spec_trans_o      (dif_spec_trans_o),
      .dif_aphase_o          (dif_aphase_o),
      .dif_cb_o              (dif_cb_o[1:0]),
      .dif_priv_o            (dif_priv_o),
      .dif_wdata_o           (dif_wdata_o[31:0]),
      .dif_write_o           (dif_write_o),
      .dif_cpu_force_idle_o  (dif_cpu_force_idle_o),

      .hready_i              (hready_i),
      .slv_addr_i            (slv_addr_i[31:0]),
      .slv_prot_i            (slv_prot_i[3:0]),
      .slv_size_i            (slv_size_i[1:0]),
      .slv_stall_i           (slv_stall_i),
      .slv_trans_i           (slv_trans_i[1:0]),
      .slv_wdata_i           (slv_wdata_i[31:0]),
      .slv_write_i           (slv_write_i),

      .cpu_wphase_i          (cpu_wphase_i),
      .dsl_hrdata_i          (dsl_hrdata[31:0]),
      .dwt_hrdata_i          (dwt_hrdata[31:0]),
      .bpu_hrdata_i          (bpu_hrdata[31:0]),
      .dbg_hrdata_i          (dbg_hrdata[31:0]),
      .mtx_dif_rdata_i       (mtx_dif_rdata_i[31:0]),
      .mtx_dif_resp_i        (mtx_dif_resp_i),
      .mtx_dif_slot_i        (mtx_dif_slot_i),
      .mtx_dif_io_hit_i      (mtx_dif_io_hit_i),
      .iaex_en_i             (iaex_en_i),
      .dsl_ppb_usr_err_i     (dsl_ppb_usr_err));

   // -------------------------------------------------------------------------
   // Debug PPB space address decoder instantiation
   // -------------------------------------------------------------------------

   cm0p_dbg_sel
     #(.CBAW(CBAW), .BKPT(BKPT), .WPT(WPT))
   u_sel
     (.dclk                 (dclk),
      .dbg_reset_n          (dbg_reset_n),

      .dsl_cid_sels_o       (dsl_cid_sels_o[1:0]),
      .dsl_dbg_sels_o       (dsl_dbg_sels[3:0]),
      .dsl_bpu_sels_o       (dsl_bpu_sels[4:0]),
      .dsl_dwt_sels_o       (dsl_dwt_sels[7:0]),
      .dsl_hrdata_o         (dsl_hrdata[31:0]),
      .dsl_ppb_write_o      (dsl_ppb_write),
      .dsl_ppb_active_o     (dsl_ppb_active_o),
      .dsl_ppb_usr_err_o    (dsl_ppb_usr_err),
      .dsl_acc_ok_o         (dsl_acc_ok_o),

      .niden_i              (niden_i),
      .dbg_inv_en_i         (dbg_inv_en),
      .hready_i             (hready_i),
      .eco_rev_num_19to4_i  (eco_rev_num_19to4_i[15:0]),
      .dif_aphase_i         (dif_aphase_o),
      .dif_size_bit1_i      (dif_size_o[1]),
      .dif_addr_i           (dif_addr_o[31:0]),
      .dif_write_i          (dif_write_o),
      .dif_priv_i           (dif_priv_o));

   // -------------------------------------------------------------------------

`ifdef ARM_ASSERT_ON
   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------
 `include "std_ovl_defines.h"

   // --------
   // There must be no watchpoint hit when debug is disabled.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("There must be no watchpoint hit when debug is disabled"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_no_dbg_no_dwt
     (.clock(dclk),
      .reset(dbg_reset_n),
      .enable(1'b1),
      .antecedent_expr(~dbg_c_debugen_o),
      .consequent_expr(~dwt_event),
      .fire());

   // --------
   // Errors are only generated within the SCS select logic for unprivileged
   // accesses by the debugger.

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ("Only the debugger generates SCS select faults"),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_scs_sel_err_dif_dphase
     (.clock            (dclk),
      .reset            (dbg_reset_n),
      .enable           (1'b1),
      .antecedent_expr  (u_sel.scs_sel_q == u_sel.scs_err),
      .consequent_expr  (u_if.slv_trans_q & u_if.dphase_q),
      .fire());

   // --------
   // Only the debugger can perform debug PPB accesses.

  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (`OVL_ASSERT),
    .msg              ("Valid debug PPB only during debug access data phase"),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
   u_asrt_scs_sel_dif_dphase
     ( .clock            (dclk),
       .reset            (dbg_reset_n),
       .enable           (1'b1),
       .antecedent_expr  (|u_sel.scs_sel_q),
       .consequent_expr  (// SLV interface active
                          u_if.slv_trans_q & u_if.dphase_q &
                          (u_if.slv_ready | dsl_ppb_usr_err) &
                          // scs_sel must have become 0 for error response
                          ~u_if.stall_q &
                          // Must be a PPB address
                          dif_addr_o[31:28] == 4'hE &
                          // Can't be accessing AHB so no error from there
                          ~mtx_dif_resp_i),
       .fire());

   // --------
   // Transactions to PPB must not appear on AHB.

   wire a_scs_sel_dif_dphase =
        ( ~(|u_sel.scs_sel_q) |
          (u_if.slv_trans_q & u_if.dphase_q &    // SLV interface active
           (u_if.slv_ready | dsl_ppb_usr_err) &  //
           ~u_if.stall_q &  // scs_sel must have become 0 for error response
           dif_addr_o[31:28] == 4'hE &          // Must be a PPB address
           ~mtx_dif_resp_i) );

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ("Debugger PPB access must leave AHB bus alone"),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_scs_sel_hready
     ( .clock            (dclk),
       .reset            (dbg_reset_n),
       .enable           (1'b1),
       .antecedent_expr  (|u_sel.scs_sel_q & u_if.dphase_q & ~u_if.stall_q),
       .consequent_expr  (hready_i),
       .fire());

   // --------
   // Both the SCS select and debug interface must agree when we are in a
   // data-phase.

   wire a_scs_sel_hready_ok  = ( ~(|u_sel.scs_sel_q & u_if.dphase_q &
                                   ~u_if.stall_q) | hready_i );

   wire a_scs_sel_if_ok = a_scs_sel_dif_dphase & a_scs_sel_hready_ok;

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ("Debug PPB write state must be consistent"),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_ppb_write
     ( .clock            (dclk),
       .reset            (dbg_reset_n),
       .enable           (1'b1),
       .antecedent_expr  (u_sel.ppb_write_q),
       .consequent_expr  (u_if.slv_trans_q & u_if.dphase_q & dif_write_o),
       .fire());

   // --------
   // If DBGEN has never been set it should be impossible for certain debug
   // events to occur.

   reg  a_stk_dbgen_q;

   always @(posedge dclk)
     if (dbgen_i)
       a_stk_dbgen_q <= 1'b1;
     else if (~dbg_reset_n & ~a_stk_dbgen_q)
       a_stk_dbgen_q <= 1'b0;
     else if (~dbg_reset_n & a_stk_dbgen_q)
       a_stk_dbgen_q <= 1'b1;

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ({"When DBGEN has never been set BPU events should ",
                           "be impossible"}),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_dbgen_bpu_match
     ( .clock            (dclk),
       .reset            (dbg_reset_n),
       .enable           (1'b1),
       .antecedent_expr  (~a_stk_dbgen_q),
       .consequent_expr  (bpu_match_o[1:0] == 2'b00),
       .fire());

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ({"When DBGEN has never been set there should be ",
                           "no watchpoint events"}),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_dbgen_dwt_event
     ( .clock            (dclk),
       .reset            (dbg_reset_n),
       .enable           (1'b1),
       .antecedent_expr  (~a_stk_dbgen_q),
       .consequent_expr  (~dwt_event),
       .fire());

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ({"When DBGEN has never been set there should be ",
                           "no debugger core halt requests"}),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_dbgen_dbg_halt
     ( .clock            (dclk),
       .reset            (dbg_reset_n),
       .enable           (1'b1),
       .antecedent_expr  (~a_stk_dbgen_q),
       .consequent_expr  (~dbg_halt_req_o),
       .fire());

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ({"When DBGEN has never been set it should not be ",
                           "possible for debug to run code"}),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_dbgen_dbg_op_run
     ( .clock            (dclk),
       .reset            (dbg_reset_n),
       .enable           (1'b1),
       .antecedent_expr  (~a_stk_dbgen_q),
       .consequent_expr  (~dbg_op_run_o),
       .fire());

   reg  a_pmt_dbg_tx_q;

   wire a_pmt_dbg_tx_set = (slv_trans_i[1] & slv_ready_o | hready_i) &
                           (dbgen_i | cpu_halt_ack_i);
   wire a_pmt_dbg_tx_clr = u_if.dphase_q & slv_ready_o & ~dbgen_i;

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       a_pmt_dbg_tx_q <= 1'b0;
     else if (a_pmt_dbg_tx_set | a_pmt_dbg_tx_clr)
       a_pmt_dbg_tx_q <= a_pmt_dbg_tx_set;

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ({"Debugger PPB writes initiated when DBGEN is low ",
                           "should elicit an ERROR response"}),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_dbg_wr_err_when_dbgen_low
     ( .clock            (dclk),
       .reset            (dbg_reset_n),
       .enable           (1'b1),
       .antecedent_expr  (u_if.dphase_q &
                          (dif_addr_o[31:28] == 4'hE & dif_write_o) &
                          slv_ready_o & ~a_pmt_dbg_tx_q),
       .consequent_expr  (slv_resp_o),
       .fire());

   //--------------------------------------------------------------------------

`endif

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
