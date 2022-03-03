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
//   Checked In : $Date: 2012-12-06 15:27:55 +0000 (Thu, 06 Dec 2012) $
//   Revision   : $Revision: 230817 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ CORE, NVIC, MPU AND MATRIX INTERCONNECT LEVEL
//-----------------------------------------------------------------------------

module cm0p_top_sys
  #(parameter CBAW     =  0,
    parameter ACG      =  1,
    parameter AHBSLV   =  1,
    parameter BE       =  0,
    parameter BKPT     =  4,
    parameter DBG      =  1,
    parameter HWF      =  0,
    parameter IOP      =  0,
    parameter IRQDIS   =  0,
    parameter MPU      =  0,
    parameter NUMIRQ   = 32,
    parameter RAR      =  0,
    parameter SMUL     =  0,
    parameter SYST     =  1,
    parameter USER     =  0,
    parameter VTOR     =  0,
    parameter WIC      =  1,
    parameter WICLINES = 34,
    parameter WPT      =  2)

   (// CLOCK AND RESETS
    input  wire        sclk,                // System clock
    input  wire        hclk,                // Gated AHB clock
    input  wire        rclk0,               // Gated lower reg-file clock
    input  wire        rclk1,               // Gated upper reg-file clock
    input  wire        pclk,                // Gated PPB space clock
    input  wire        hreset_n,            // System reset

    // DEBUG-CORE DOMAIN INTERCONNECT
    input  wire [82:0] dbg_to_sys_i,        // dbg-to-sys interconnect
    output wire [145:0] sys_to_dbg_o,       // sys-to-dbg interconnect

    // AHB-LITE MASTER PORT
    output wire [31:0] haddr_o,             // AHB address
    output wire [ 2:0] hburst_o,            // AHB burst (always 0)
    output wire        hmastlock_o,         // AHB locked transfer (always 0)
    output wire [ 3:0] hprot_o,             // AHB properties
    output wire [ 2:0] hsize_o,             // AHB size
    output wire [ 1:0] htrans_o,            // AHB transfer
    output wire [31:0] hwdata_o,            // AHB write data
    output wire        hwrite_o,            // AHB write not read
    input  wire [31:0] hrdata_i,            // AHB read data
    input  wire        hready_i,            // AHB ready and core advance
    input  wire        hresp_i,             // AHB error response

    output wire        shareable_o,         // AHB transaction shareable

    output wire        hmaster_o,           // Bus master (0=core, 1=debug)
    output wire        spec_htrans_o,       // Speculative HTRANS[1]

    // IO INTERFACE
    output wire [31:0] io_check_o,          // IO address decoder query
    input  wire        io_match_i,          // IO address decoder response
    output wire [31:0] io_addr_o,           // IO address
    output wire        io_trans_o,          // IO valid
    output wire        io_write_o,          // IO write control
    output wire [31:0] io_wdata_o,          // IO write data
    output wire [ 1:0] io_size_o,           // IO size
    output wire        io_priv_o,           // IO is privileged
    output wire        io_master_o,         // IO master 0 = core, 1 = debug
    input  wire [31:0] io_rdata_i,          // IO read data

    // INSTRUCTION TRACE
    output wire        iaex_en_o,           // Instruction address enable
    output wire        iaex_seq_o,          // Instruction address is sequential
    output wire [30:0] iaex_o,              // Instruction address in execute
    output wire        atomic_o,            // Instruction address is special

    // MISC
    input  wire        nmi_i,               // Non-maskable interrupt
    input  wire [31:0] irq_i,               // Prioritizable interrupts
    output wire        txev_o,              // Event output (SEV executed)
    input  wire        rxev_i,              // Event input
    output wire        lockup_o,            // Core is in LOCKUP
    output wire        sys_reset_req_o,     // System reset request
    input  wire [25:0] st_calib_i,          // SysTick calibration value
    input  wire        st_clk_en_i,         // SysTick SCLK count enable
    input  wire [ 7:0] irq_latency_i,       // Interrupt latency
    input  wire [ 3:0] eco_rev_num_3to0_i,  // Change-order revision patch
    input  wire        cpu_wait_i,          // Wait out of reset

    // POWER MANAGEMENT
    output wire        sleeping_o,          // Core and NVIC sleeping
    output wire        sleep_deep_o,        // Sleep is deep
    input  wire        sleep_hold_req_n_i,  // Sleep extension request
    output wire        sleep_hold_ack_n_o,  // Sleep extension acknowledge
    input wire         wic_ds_req_n_i,      // WIC mode operation request
    output wire        wic_ds_ack_n_o,      // WIC mode operation acknowledge
    output wire [31:0] wic_mask_isr_o,      // WIC IRQ sensitivity
    output wire        wic_mask_nmi_o,      // WIC NMI sensitivity
    output wire        wic_mask_rxev_o,     // WIC RXEV sensitivity
    output wire        wic_load_o,          // NVIC to WIC upload
    output wire        wic_clear_o,         // NVIC to WIC clear request

    // CODE SEQUENTIALITY INFO
    output wire        code_nseq_o,         // Fetch is non-sequential
    output wire [ 3:0] code_hint_o,         // Fetch hints

    // DATA HINTS
    output wire [ 1:0] data_hint_o,         // Data access hints

    // CLOCK-GATE ENABLE TERMS
    output wire        cpu_rclk0_en_o,      // Lower reg-bank clock enable
    output wire        cpu_rclk1_en_o,      // Upper reg-bank clock enable
    output wire        msl_pclk_en_o);      // PPB space clock enable

   // -------------------------------------------------------------------------
   // Local inter-module connection wires
   // -------------------------------------------------------------------------

   wire        cpu_dbg_stall;       // Core requests no transaction from debug
   wire        cpu_trans;           // Core AHB or PPB transaction
   wire [ 2:0] cpu_scb;             // Core transaction sideband
   wire [ 1:0] cpu_hsize;           // Core AHB size
   wire        cpu_spec_htrans;     // Core speculative transaction
   wire        cpu_event_clear;     // Core request to clear event register
   wire        cpu_int_ready;       // Core has registered interrupt
   wire        cpu_hfnmi;           // Core in HardFault or NMI for MPU use
   wire        cpu_hdf_pend;        // Core HardFault pend request
   wire        cpu_hdf_request;     // Core HardFault request
   wire        cpu_wfe_execute;     // Core executing WFE
   wire        cpu_wfi_execute;     // Core executing WFI
   wire        cpu_svc_request;     // Core SVCall request (from SVC)
   wire [31:0] cpu_dcrdr_data;      // Core debug-register-read-data
   wire [31:0] cpu_hwdata;          // Core AHB write data
   wire        msl_dbg_aux_en;      // Debug DCRDR write
   wire        msl_dbg_op_en;       // Debug DCRSR write
   wire [23:0] msl_nvic_sels;       // Matrix selects for NVIC registers
   wire [ 4:0] msl_mpu_sels;        // Matrix selects for MPU registers
   wire        mtx_cpu_resp;        // Matrix HRESP to core
   wire        mtx_ppb_active;      // PPB transaction data-phase
   wire        mtx_ppb_write;       // PPB data-phase is for a write
   wire [31:0] mtx_ppb_hrdata;      // Combined PPB read-data
   wire [31:0] mtx_ppb_wdata;       // PPB write-data
   wire [31:0] nvm_hrdata;          // NVIC PPB read-data
   wire [31:0] mpu_rdata;           // MPU PPB read data
   wire        nvm_int_pend;        // Interrupt is pending in NVIC
   wire [ 5:0] nvm_int_pend_num;    // Number of pending interrupt
   wire        nvm_svc_escalate;    // SVC instruction should HardFault
   wire        nvm_wfi_advance;     // WFI instruction should retire
   wire        nvm_wfe_advance;     // WFE instruction should retire
   wire        nvm_sleep_on_exit;   // Core should WFI on return to Thread
   wire        nvm_vect_clr_active; // Debug clear active request
   wire [23:0] nvm_vtor_31to8;      // Vector table offset register
   wire        cpu_hdf_active_o;    // IPSR is HardFault (3)
   wire [ 5:0] cpu_ipsr;            // Current IPSR value
   wire        cpu_n_or_h_active;   // IPSR is HardFault or NMI
   wire        cpu_nmi_active;      // IPSR is NMI (2)
   wire        cpu_primask_ex;      // Forwarded PRIMASK value
   wire        cpu_primask;         // Registered PRIMASK value
   wire [31:0] cpu_addr_a;          // First address to look up
   wire [26:0] cpu_addr_b_31to5;    // Second address to look up
   wire        mpu_fault_a;         // First look up generates MPU fault
   wire        mpu_fault_b;         // Second look up generates MPU fault
   wire [ 2:0] mpu_scb_a;           // First shareable, cacheable, bufferable
   wire [ 2:0] mpu_scb_b;           // Second shareable, cacheable, bufferable

   // -------------------------------------------------------------------------
   // System to debug domain output bundling
   // -------------------------------------------------------------------------

   // To facilitate power domain implementation, all signals between the debug
   // and system domains are bundled to form a single bus here.

   wire        cpu_dwt_trans_o;     // Consider transaction for watchpoints
   wire [31:0] cpu_haddr_o;         // Core instruction address
   wire        cpu_ex_idle_o;       // Core is sleeping / inactive
   wire        cpu_bpu_event_o;     // Breakpoint or BKPT instruction hit
   wire        cpu_dbg_ex_last_o;   // Core instruction / sequence retired
   wire        cpu_dbg_ex_reset_o;  // Core in FSM in reset state
   wire        cpu_dwt_ia_ok_o;     // IAEX valid for debug PC purposes
   wire        cpu_halt_ack_o;      // Core halted
   wire [31:0] cpu_io_addr;         // Core IO port address
   wire [31:0] cpu_io_check;        // Core IO decode address
   wire        cpu_io_priv;         // Core IO access privileged
   wire [ 1:0] cpu_io_size;         // Core IO port size
   wire        cpu_io_trans;        // Core IO transaction valid
   wire [31:0] cpu_io_wdata;        // Core IO port write-data
   wire        cpu_io_write;        // Core IO write
   wire        cpu_dni;             // Core data not instruction transaction
   wire        cpu_dni_a;           // Core address 0 for load/store
   wire        cpu_priv;            // Core transaction is privileged
   wire        cpu_hwrite;          // Core read not write transaction
   wire [ 1:0] cpu_ls_size_o;       // Core AHB read/write data-size
   wire        cpu_int_return_o;    // Core returning from interrupt
   wire        cpu_int_taken_o;     // Core interrupt taken
   wire [31:0] mtx_dif_rdata_o;     // Debugger read data from NVIC/AHB
   wire        mtx_dif_resp_o;      // Debugger error response from NVIC/AHB
   wire        mtx_dif_slot_o;      // Core concedes bus to debugger
   wire [30:0] cpu_dwt_iaex_o;      // PC value for watchpoint units PCSR
   wire        cpu_pipefull_o;      // Core pipeline populated
   wire        hready_o = hready_i; // AHB ready / core advance
   wire        mtx_dif_io_hit_o;    // Debugger data ready
   wire        cpu_wphase_o;        // Core in AHB write-data-phase
   wire        cpu_write_a_o;       // First address is for a write

   // --------
   // If debug is not implemented, simply tie off the bus.

   generate
      if((CBAW !=0) || (DBG != 0)) begin : gen_dbg_0a

         assign sys_to_dbg_o    = { cpu_dwt_trans_o,
                                    cpu_addr_a[31:0],
                                    cpu_haddr_o[31:2],
                                    cpu_ex_idle_o,
                                    cpu_bpu_event_o,
                                    cpu_dbg_ex_last_o,
                                    cpu_dbg_ex_reset_o,
                                    lockup_o,
                                    cpu_dwt_ia_ok_o,
                                    cpu_halt_ack_o,
                                    cpu_write_a_o,
                                    cpu_ls_size_o[1:0],
                                    cpu_int_return_o,
                                    cpu_int_taken_o,
                                    mtx_dif_rdata_o[31:0],
                                    mtx_dif_resp_o,
                                    mtx_dif_slot_o,
                                    cpu_dwt_iaex_o[30:0],
                                    cpu_pipefull_o,
                                    cpu_hdf_active_o,
                                    iaex_en_o,
                                    hready_o,
                                    mtx_dif_io_hit_o,
                                    cpu_wphase_o };

      end else begin : gen_dbg_0b

         wire [76:0] unused = { cpu_dwt_trans_o, cpu_bpu_event_o,
                                cpu_dbg_ex_last_o, cpu_dbg_ex_reset_o,
                                cpu_dwt_ia_ok_o, cpu_halt_ack_o,
                                cpu_ls_size_o[1:0], mtx_dif_rdata_o[31:0],
                                mtx_dif_resp_o, mtx_dif_slot_o,
                                cpu_dwt_iaex_o[30:0], cpu_pipefull_o, hready_o,
                                mtx_dif_io_hit_o, cpu_wphase_o };

         assign sys_to_dbg_o = 146'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Debug to system domain input un-bundling
   // -------------------------------------------------------------------------

   // Inputs from the debug domain are via a single bus which is unbundled
   // here.

   wire [ 1:0] bpu_match_i;          // Breakpoint hit on top/bottom 16-bits
   wire        dbg_c_debugen_i;      // Debug is enabled
   wire        dbg_c_maskints_i;     // NVIC should ignore prioritizable IRQs
   wire        dbg_halt_req_i;       // Halt request from debug to core
   wire        dbg_op_run_i;         // Perform DCRSR operation request
   wire [31:0] dif_addr_i;           // Debugger address for AHB/NVIC
   wire [ 1:0] dif_size_i;           // Debugger transaction size
   wire        dif_spec_trans_i;     // Debugger speculative transaction
   wire        dif_aphase_i;         // Debugger transaction request
   wire [ 1:0] dif_cb_i;             // Debugger transaction cacheability
   wire        dif_priv_i;           // Debugger transaction privilege
   wire        dsl_acc_ok_i;         // Debugger PPB transaction allowed
   wire [31:0] dif_wdata_i;          // Debugger write-data
   wire        dif_write_i;          // Debugger write not read transaction
   wire        dif_cpu_force_idle_i; // Debugger force core idle
   wire [ 1:0] dsl_cid_sels_i;       // Debug read selects for CPUID and ACTLR
   wire        dsl_ppb_active_i;     // Debugger access to debug PPB

   // --------
   // If debug is not implemented, discard input bus and assume all values are
   // zero.

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_1a

         assign { bpu_match_i[1:0],
                  dbg_c_debugen_i,
                  dbg_c_maskints_i,
                  dbg_halt_req_i,
                  dbg_op_run_i,
                  dif_addr_i[31:0],
                  dif_size_i[1:0],
                  dif_spec_trans_i,
                  dif_aphase_i,
                  dif_cb_i[1:0],
                  dif_priv_i,
                  dsl_acc_ok_i,
                  dif_wdata_i[31:0],
                  dif_write_i,
                  dif_cpu_force_idle_i,
                  dsl_cid_sels_i[1:0],
                  dsl_ppb_active_i } = dbg_to_sys_i;

      end else begin : gen_dbg_1b

         wire [82:0] unused = dbg_to_sys_i;

         assign { bpu_match_i[1:0], dbg_c_debugen_i, dbg_c_maskints_i,
                  dbg_halt_req_i, dbg_op_run_i, dif_addr_i[31:0],
                  dif_size_i[1:0], dif_spec_trans_i, dif_aphase_i,
                  dif_cb_i[1:0], dif_priv_i, dsl_acc_ok_i, dif_wdata_i[31:0],
                  dif_write_i, dif_cpu_force_idle_i, dsl_cid_sels_i[1:0],
                  dsl_ppb_active_i } = 83'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Processor core instantiation
   // -------------------------------------------------------------------------

   cm0p_core
     #(.CBAW(CBAW), .ACG(ACG), .BE(BE), .DBG(DBG), .HWF(HWF), .IOP(IOP),
       .MPU(MPU), .RAR(RAR), .SMUL(SMUL), .USER(USER), .VTOR(VTOR), .WIC(WIC))
   u_core
     (.sclk                   (sclk),
      .hclk                   (hclk),
      .rclk0                  (rclk0),
      .rclk1                  (rclk1),
      .hreset_n               (hreset_n),

      .cpu_io_check_o         (cpu_io_check[31:0]),
      .cpu_io_addr_o          (cpu_io_addr[31:0]),
      .cpu_io_trans_o         (cpu_io_trans),
      .cpu_io_write_o         (cpu_io_write),
      .cpu_io_size_o          (cpu_io_size[1:0]),
      .cpu_io_wdata_o         (cpu_io_wdata[31:0]),
      .cpu_io_priv_o          (cpu_io_priv),
      .code_hint_o            (code_hint_o[3:0]),
      .code_nseq_o            (code_nseq_o),
      .data_hint_o            (data_hint_o[1:0]),
      .lockup_o               (lockup_o),
      .sleep_hold_ack_n_o     (sleep_hold_ack_n_o),
      .txev_o                 (txev_o),
      .iaex_en_o              (iaex_en_o),
      .iaex_seq_o             (iaex_seq_o),
      .iaex_o                 (iaex_o[30:0]),
      .atomic_o               (atomic_o),
      .wic_clear_o            (wic_clear_o),
      .wic_load_o             (wic_load_o),

      .cpu_spec_htrans_o      (cpu_spec_htrans),
      .cpu_haddr_o            (cpu_haddr_o[31:0]),
      .cpu_hsize_o            (cpu_hsize[1:0]),
      .cpu_trans_o            (cpu_trans),
      .cpu_scb_o              (cpu_scb[2:0]),
      .cpu_dwt_trans_o        (cpu_dwt_trans_o),
      .cpu_wphase_o           (cpu_wphase_o),
      .cpu_rclk0_en_o         (cpu_rclk0_en_o),
      .cpu_rclk1_en_o         (cpu_rclk1_en_o),
      .cpu_dni_a_o            (cpu_dni_a),
      .cpu_dni_o              (cpu_dni),
      .cpu_priv_o             (cpu_priv),
      .cpu_hwrite_o           (cpu_hwrite),
      .cpu_ls_size_o          (cpu_ls_size_o[1:0]),
      .cpu_ex_idle_o          (cpu_ex_idle_o),
      .cpu_int_ready_o        (cpu_int_ready),
      .cpu_event_clear_o      (cpu_event_clear),
      .cpu_wfe_execute_o      (cpu_wfe_execute),
      .cpu_wfi_execute_o      (cpu_wfi_execute),
      .cpu_hdf_pend_o         (cpu_hdf_pend),
      .cpu_hdf_request_o      (cpu_hdf_request),
      .cpu_halt_ack_o         (cpu_halt_ack_o),
      .cpu_dwt_ia_ok_o        (cpu_dwt_ia_ok_o),
      .cpu_dbg_ex_last_o      (cpu_dbg_ex_last_o),
      .cpu_dbg_ex_reset_o     (cpu_dbg_ex_reset_o),
      .cpu_bpu_event_o        (cpu_bpu_event_o),
      .cpu_svc_request_o      (cpu_svc_request),
      .cpu_int_taken_o        (cpu_int_taken_o),
      .cpu_int_return_o       (cpu_int_return_o),

      .cpu_addr_a_o           (cpu_addr_a[31:0]),
      .cpu_addr_b_31to5_o     (cpu_addr_b_31to5[26:0]),
      .cpu_write_a_o          (cpu_write_a_o),
      .mpu_fault_a_i          (mpu_fault_a),
      .mpu_fault_b_i          (mpu_fault_b),
      .mpu_scb_a_i            (mpu_scb_a[2:0]),
      .mpu_scb_b_i            (mpu_scb_b[2:0]),

      .cpu_hwdata_o           (cpu_hwdata[31:0]),
      .cpu_dcrdr_data_o       (cpu_dcrdr_data[31:0]),
      .cpu_dwt_iaex_o         (cpu_dwt_iaex_o[30:0]),
      .cpu_pipefull_o         (cpu_pipefull_o),
      .cpu_ipsr_o             (cpu_ipsr[5:0]),
      .cpu_primask_ex_o       (cpu_primask_ex),
      .cpu_primask_o          (cpu_primask),
      .cpu_nmi_active_o       (cpu_nmi_active),
      .cpu_hdf_active_o       (cpu_hdf_active_o),
      .cpu_hfnmi_o            (cpu_hfnmi),
      .cpu_n_or_h_active_o    (cpu_n_or_h_active),
      .cpu_dbg_stall_o        (cpu_dbg_stall),

      .hrdata_i               (hrdata_i[31:0]),
      .hready_i               (hready_i),
      .io_match_i             (io_match_i),
      .io_rdata_i             (io_rdata_i[31:0]),
      .sleep_hold_req_n_i     (sleep_hold_req_n_i),
      .irq_latency_i          (irq_latency_i[7:0]),

      .bpu_match_i            (bpu_match_i[1:0]),
      .dbg_halt_req_i         (dbg_halt_req_i),
      .dbg_op_run_i           (dbg_op_run_i),
      .dbg_c_debugen_i        (dbg_c_debugen_i),
      .dif_wdata_i            (dif_wdata_i[31:0]),
      .msl_dbg_op_en_i        (msl_dbg_op_en),
      .msl_dbg_aux_en_i       (msl_dbg_aux_en),
      .dif_cpu_force_idle_i   (dif_cpu_force_idle_i),
      .mtx_cpu_resp_i         (mtx_cpu_resp),
      .mtx_ppb_hrdata_i       (mtx_ppb_hrdata[31:0]),
      .mtx_ppb_active_i       (mtx_ppb_active),
      .nvm_int_pend_i         (nvm_int_pend),
      .nvm_int_pend_num_i     (nvm_int_pend_num[5:0]),
      .nvm_svc_escalate_i     (nvm_svc_escalate),
      .nvm_wfe_advance_i      (nvm_wfe_advance),
      .nvm_wfi_advance_i      (nvm_wfi_advance),
      .nvm_sleep_on_exit_i    (nvm_sleep_on_exit),
      .nvm_vect_clr_active_i  (nvm_vect_clr_active),
      .nvm_vtor_31to8_i       (nvm_vtor_31to8[23:0]),
      .cpu_wait_i             (cpu_wait_i));

   // -------------------------------------------------------------------------
   // Memory protecton unit (MPU) instantiation
   // -------------------------------------------------------------------------

   cm0p_mpu
     #(.CBAW(CBAW), .IOP(IOP), .MPU(MPU), .RAR(RAR))
   u_mpu
     (.pclk                (pclk),
      .reset_n             (hreset_n),
      .cpu_addr_a_31to5_i  (cpu_addr_a[31:5]),
      .cpu_addr_b_31to5_i  (cpu_addr_b_31to5[26:0]),
      .cpu_dni_a_i         (cpu_dni_a),
      .cpu_write_a_i       (cpu_write_a_o),
      .cpu_vectread_a_i    (data_hint_o[0]),
      .cpu_priv_i          (cpu_priv),
      .cpu_hfnmi_i         (cpu_hfnmi),
      .mpu_fault_a_o       (mpu_fault_a),
      .mpu_fault_b_o       (mpu_fault_b),
      .mpu_scb_a_o         (mpu_scb_a[2:0]),
      .mpu_scb_b_o         (mpu_scb_b[2:0]),
      .acc_sel_i           (msl_mpu_sels[4:0]),
      .acc_write_i         (mtx_ppb_write),
      .acc_wdata_i         (mtx_ppb_wdata[31:0]),
      .acc_rdata_o         (mpu_rdata[31:0]));

   // -------------------------------------------------------------------------
   // Nested-vectored interrupt controller (NVIC) instantiation
   // -------------------------------------------------------------------------

   cm0p_nvic
     #(.CBAW(CBAW), .BE(BE), .DBG(DBG), .IRQDIS(IRQDIS), .NUMIRQ(NUMIRQ),
       .RAR(RAR), .SYST(SYST), .VTOR(VTOR), .WIC(WIC), .WICLINES(WICLINES))
   u_nvic
     (.sclk                 (sclk),
      .hclk                 (hclk),
      .pclk                 (pclk),
      .hreset_n             (hreset_n),

      .sleeping_o           (sleeping_o),
      .sleep_deep_o         (sleep_deep_o),
      .sys_reset_req_o      (sys_reset_req_o),
      .wic_ds_ack_n_o       (wic_ds_ack_n_o),
      .wic_mask_isr_o       (wic_mask_isr_o[31:0]),
      .wic_mask_nmi_o       (wic_mask_nmi_o),
      .wic_mask_rxev_o      (wic_mask_rxev_o),

      .nvm_hrdata_o         (nvm_hrdata[31:0]),
      .nvm_int_pend_o       (nvm_int_pend),
      .nvm_int_pend_num_o   (nvm_int_pend_num[5:0]),
      .nvm_svc_escalate_o   (nvm_svc_escalate),
      .nvm_wfi_advance_o    (nvm_wfi_advance),
      .nvm_wfe_advance_o    (nvm_wfe_advance),
      .nvm_sleep_on_exit_o  (nvm_sleep_on_exit),
      .nvm_vect_clr_actv_o  (nvm_vect_clr_active),
      .nvm_vtor_31to8_o     (nvm_vtor_31to8[23:0]),

      .hready_i             (hready_i),
      .irq_i                (irq_i[31:0]),
      .nmi_i                (nmi_i),
      .rxev_i               (rxev_i),
      .st_calib_i           (st_calib_i[25:0]),
      .st_clk_en_i          (st_clk_en_i),
      .wic_ds_req_n_i       (wic_ds_req_n_i),
      .txev_i               (txev_o),

      .cpu_int_ready_i      (cpu_int_ready),
      .cpu_ex_idle_i        (cpu_ex_idle_o),
      .cpu_event_clear_i    (cpu_event_clear),
      .cpu_wfi_execute_i    (cpu_wfi_execute),
      .cpu_wfe_execute_i    (cpu_wfe_execute),
      .cpu_hdf_pend_i       (cpu_hdf_pend),
      .cpu_hdf_request_i    (cpu_hdf_request),
      .cpu_svc_request_i    (cpu_svc_request),
      .cpu_int_taken_i      (cpu_int_taken_o),
      .cpu_int_return_i     (cpu_int_return_o),
      .dbg_halt_req_i       (dbg_halt_req_i),
      .dbg_s_halt_i         (cpu_halt_ack_o),
      .dbg_c_maskints_i     (dbg_c_maskints_i),
      .dsl_ppb_active_i     (dsl_ppb_active_i),
      .msl_nvic_sels_i      (msl_nvic_sels[23:0]),
      .mtx_ppb_write_i      (mtx_ppb_write),
      .mtx_ppb_wdata_i      (mtx_ppb_wdata[31:0]),
      .cpu_ipsr_i           (cpu_ipsr),
      .cpu_primask_ex_i     (cpu_primask_ex),
      .cpu_primask_i        (cpu_primask),
      .cpu_nmi_active_i     (cpu_nmi_active),
      .cpu_hdf_active_i     (cpu_hdf_active_o),
      .cpu_n_or_h_active_i  (cpu_n_or_h_active));

   // -------------------------------------------------------------------------
   // Bus matrix instantiation
   // -------------------------------------------------------------------------

   cm0p_matrix
     #(.CBAW(CBAW), .DBG(DBG), .IOP(IOP), .SYST(SYST), .MPU(MPU))
   u_matrix
     (.hclk                (hclk),
      .hreset_n            (hreset_n),

      .haddr_o             (haddr_o[31:0]),
      .hburst_o            (hburst_o[2:0]),
      .hmaster_o           (hmaster_o),
      .hmastlock_o         (hmastlock_o),
      .hprot_o             (hprot_o[3:0]),
      .hsize_o             (hsize_o[2:0]),
      .htrans_o            (htrans_o[1:0]),
      .hwdata_o            (hwdata_o[31:0]),
      .hwrite_o            (hwrite_o),
      .spec_htrans_o       (spec_htrans_o),
      .shareable_o         (shareable_o),

      .io_addr_o           (io_addr_o[31:0]),
      .io_check_o          (io_check_o[31:0]),
      .io_master_o         (io_master_o),
      .io_priv_o           (io_priv_o),
      .io_size_o           (io_size_o[1:0]),
      .io_trans_o          (io_trans_o),
      .io_wdata_o          (io_wdata_o[31:0]),
      .io_write_o          (io_write_o),

      .io_match_i          (io_match_i),
      .io_rdata_i          (io_rdata_i[31:0]),

      .cpu_io_addr_i       (cpu_io_addr[31:0]),
      .cpu_io_check_i      (cpu_io_check[31:0]),
      .cpu_io_priv_i       (cpu_io_priv),
      .cpu_io_size_i       (cpu_io_size[1:0]),
      .cpu_io_trans_i      (cpu_io_trans),
      .cpu_io_wdata_i      (cpu_io_wdata[31:0]),
      .cpu_io_write_i      (cpu_io_write),

      .msl_dbg_aux_en_o    (msl_dbg_aux_en),
      .msl_dbg_op_en_o     (msl_dbg_op_en),
      .msl_nvic_sels_o     (msl_nvic_sels[23:0]),
      .msl_mpu_sels_o      (msl_mpu_sels[4:0]),
      .msl_pclk_en_o       (msl_pclk_en_o),
      .mtx_cpu_resp_o      (mtx_cpu_resp),
      .mtx_dif_rdata_o     (mtx_dif_rdata_o[31:0]),
      .mtx_dif_resp_o      (mtx_dif_resp_o),
      .mtx_dif_slot_o      (mtx_dif_slot_o),
      .mtx_dif_io_hit_o    (mtx_dif_io_hit_o),
      .mtx_ppb_hrdata_o    (mtx_ppb_hrdata[31:0]),
      .mtx_ppb_write_o     (mtx_ppb_write),
      .mtx_ppb_active_o    (mtx_ppb_active),
      .mtx_ppb_wdata_o     (mtx_ppb_wdata[31:0]),

      .hrdata_i            (hrdata_i[31:0]),
      .hready_i            (hready_i),
      .hresp_i             (hresp_i),
      .eco_rev_num_3to0_i  (eco_rev_num_3to0_i[3:0]),

      .cpu_dbg_stall_i     (cpu_dbg_stall),
      .cpu_haddr_i         (cpu_haddr_o[31:0]),
      .cpu_hsize_i         (cpu_hsize[1:0]),
      .cpu_trans_i         (cpu_trans),
      .cpu_spec_htrans_i   (cpu_spec_htrans),
      .cpu_dni_i           (cpu_dni),
      .cpu_priv_i          (cpu_priv),
      .cpu_hwrite_i        (cpu_hwrite),
      .cpu_scb_i           (cpu_scb[2:0]),
      .dbg_halt_req_i      (dbg_halt_req_i),
      .dif_addr_i          (dif_addr_i[31:0]),
      .dif_size_i          (dif_size_i[1:0]),
      .dif_spec_trans_i    (dif_spec_trans_i),
      .dif_aphase_i        (dif_aphase_i),
      .dif_wdata_i         (dif_wdata_i[31:0]),
      .dif_write_i         (dif_write_i),
      .dif_cb_i            (dif_cb_i[1:0]),
      .dif_priv_i          (dif_priv_i),
      .dsl_acc_ok_i        (dsl_acc_ok_i),
      .dsl_cid_sels_i      (dsl_cid_sels_i[1:0]),
      .dsl_ppb_active_i    (dsl_ppb_active_i),
      .cpu_hwdata_i        (cpu_hwdata[31:0]),
      .cpu_dcrdr_data_i    (cpu_dcrdr_data[31:0]),
      .nvm_hrdata_i        (nvm_hrdata[31:0]),
      .mpu_rdata_i         (mpu_rdata[31:0]));

   // -------------------------------------------------------------------------

`ifdef ARM_ASSERT_ON
   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------

`include "std_ovl_defines.h"

   // --------
   // Core should not perform transactions when sleeping.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Core should not address AHB whilst sleeping"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_sleep_noaddr
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(sleeping_o),
      .consequent_expr(~cpu_trans),
      .fire());

   // --------
   // Core should not perform transactions when sleeping.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Core should not read/write AHB whilst sleeping"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_sleep_nodata
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(sleeping_o),
      .consequent_expr(~u_core.a_cpu_dphase_q),
      .fire());

   // --------
   // Assertion data-phase must match reality.

   wire        a_cpu_dphase_consistent =
               ( u_matrix.cfg_dbg &
                 (u_matrix.cpu_dphase_q == u_core.a_cpu_dphase_q) |
                 ~u_matrix.cfg_dbg & (u_core.a_cpu_dphase_q | hready_i) );

   ovl_always
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("CPU data phase indications must be consistent"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_cpu_dphase_consistent
     (.clock    (hclk),
      .reset    (hreset_n),
      .enable   (1'b1),
      .test_expr(a_cpu_dphase_consistent),
      .fire());

   // --------
   // Check combined core ad sleep state are valid.

   wire        a_sleep_inv = ~sleeping_o | u_core.run_wfx & u_core.wfx_cyc_2;
   wire        a_sys_inv   = u_core.a_core_state_ok & a_sleep_inv;

   ovl_always
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("System must be in a valid state at all times"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_sys_invariant
     (.clock    (sclk),
      .reset    (hreset_n),
      .enable   (1'b1),
       .test_expr(u_core.a_core_state_ok & a_sleep_inv),
      .fire());

   // --------
   // Processor invariant.


   reg [31:0]  a_code_addr_last;
   wire        a_code_fetch = htrans_o[1] & ~hprot_o[0] & hready_i;

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n)
       a_code_addr_last <= 32'hF1234567;
     else if(a_code_fetch)
       a_code_addr_last <= haddr_o[31:0];

   wire [31:0] a_code_addr_last_plus_four = a_code_addr_last[31:0] + 32'd4;

   wire        a_code_nseq_ok = ( {haddr_o[31:2],2'b0} ==
                                  {(a_code_addr_last +
                                    (u_core.cfg_hwf ? 32'h2 : 32'h4)) &
                                   32'hFFFFFFFC} );

   wire [29:0] a_core_iaex_plus_two = u_core.iaex_q[30:1] + u_core.iaex_q[0];

   wire        a_code_addr_last_invariant =
               (u_core.atomic_q |
                u_core.fault_q |
                (~u_core.run_pfu & u_core.op_s_q) |
                (u_core.run_pfu & u_core.pfu_cyc_1) |
                u_core.run_alt |
                u_core.run_lck |
                u_core.run_t32 |
                (u_core.run_ldm & (u_core.list_q[7] | u_core.ldm_pop_pc)) |
                (u_core.run_exe & u_core.fmt_br3 & u_core.br3_bx_rfe) |
                (u_core.run_exe & u_core.fmt_br2 & u_core.br2_to_self) |
                (u_core.run_exe & u_core.fmt_br1 & u_core.br1_delayed) |
                (u_core.run_exe & u_core.fmt_lm2 & u_core.lm2_isn_pop &
                 u_core.lm2_pc_bit) |
                (u_core.run_exe & u_core.fmt_u16) |
                (u_core.run_exe & u_core.fmt_sy2) |
                (u_core.run_exe & u_core.fmt_sy1) |
                u_core.preempt |
                code_nseq_o) |
               (~(u_core.run_pfu & u_core.pfu_cyc_2) &
                a_code_addr_last[31:2] == a_core_iaex_plus_two[29:0]) |
               ((u_core.run_pfu & u_core.pfu_cyc_2) &
                a_code_addr_last[31:2] == u_core.iaex_q[30:1]);

   ovl_always
     #(.severity_level  (`OVL_FATAL),
       .property_type   (`OVL_ASSERT),
       .msg             ("Fetch is largely sequential"),
       .coverage_level  (`OVL_COVER_DEFAULT),
       .clock_edge      (`OVL_POSEDGE),
       .reset_polarity  (`OVL_ACTIVE_LOW),
       .gating_type     (`OVL_GATE_NONE))
   u_asrt_codeaddr_inv
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .test_expr       (a_code_addr_last_invariant),
       .fire());

   // --------
   // Code must be sequential if not marked otherwise.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Instruction flow branched but no CODENSEQ"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_codeaddr
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(a_code_fetch & ~code_nseq_o),
      .consequent_expr(a_code_nseq_ok),
      .fire());

   // --------
   // Check CODEHINT[0] results in no-branch or a forwards branch begin
   // observed.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("CODEHINT[0] should preceed forward branch"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_codehint0
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (code_hint_o[0] & hready_i),
      .test_expr   (~a_code_fetch |
                    a_code_fetch & ~code_nseq_o |
                    a_code_fetch &  code_nseq_o &
                    (haddr_o[31:0] > a_code_addr_last[31:0])),
      .fire        ());

   // --------
   // Check CODEHINT[1] results in no-branch or a backwards branch being
   // observed.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("CODEHINT[1] should preceed backward branch"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_codehint1
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (code_hint_o[1] & hready_i),
      .test_expr   (~a_code_fetch |
                    a_code_fetch & ~code_nseq_o |
                    a_code_fetch &  code_nseq_o &
                    (haddr_o[31:0] <= a_code_addr_last_plus_four[31:0])),
      .fire        ());

   // --------
   // Check AHB behavior.

   reg  [31:0] a_haddr_q;
   reg         a_hmaster_q;
   reg         a_hprot_bit0_q;
   reg         a_hready_q;
   reg         a_htrans_bit1_q;
   reg         a_code_hint_2or1_q;
   reg         a_hwrite_q;
   reg         a_data_hint_bit0_q;
   reg         a_code_nseq_q;

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n) begin
        a_haddr_q <= 32'b0;
        a_hmaster_q <= 1'b1;
        a_hprot_bit0_q <= 1'b0;
        a_htrans_bit1_q <= 1'b0;
        a_code_hint_2or1_q <= 1'b0;
        a_hwrite_q <= 1'b0;
        a_data_hint_bit0_q <= 1'b0;
        a_code_nseq_q <= 1'b0;
     end else if(hready_i) begin
        a_haddr_q <= haddr_o[31:0];
        a_hmaster_q <= hmaster_o;
        a_hprot_bit0_q <= hprot_o[0];
        a_htrans_bit1_q <= htrans_o[1];
        a_code_hint_2or1_q <= |code_hint_o[2:1];
        a_hwrite_q <= hwrite_o;
        a_data_hint_bit0_q <= data_hint_o[0];
        a_code_nseq_q <= code_nseq_o;
     end

   always @(posedge hclk)
     a_hready_q <= hready_i;

   // --------
   // Processor never repeats a transaction to the same address.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Core never repeats fetches except on Bcc to same word"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_no_twin_transactions
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(a_hready_q & htrans_o[1] &
                       ~(hprot_o[1] & code_nseq_o & a_code_hint_2or1_q) ),
      .consequent_expr((a_haddr_q != haddr_o) |
                       (a_hmaster_q != hmaster_o) |
                       (a_hprot_bit0_q != hprot_o[0]) |
                       (~a_htrans_bit1_q) |
                       (~hprot_o[1] & ~a_code_nseq_q & code_nseq_o) |
                       (hprot_o[1] & data_hint_o[0] & ~a_data_hint_bit0_q) ),
      .fire());

   // --------
   // Branch hint signals must be zero or one-hot.

   ovl_zero_one_hot
     #(.severity_level(`OVL_FATAL),
       .width(3),
       .property_type(`OVL_ASSERT),
       .msg("Only one of CODEHINT[2:0] is allowed at a time"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_codehint
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr(code_hint_o[2:0]),
      .fire());

   // --------
   // Sleeping must have a reason, either WFE or WFI.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Core sleeping must be due to WFE, WFI or SLEEPONEXIT"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_sleep_reason
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(cpu_ex_idle_o),
      .consequent_expr(cpu_wfe_execute | cpu_wfi_execute),
      .fire());

   // --------
   // If doing a PPB write we must never be in a data phase on the bus,
   // therefore HREADY must be high.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Bus master should not be in dphase during PPB write"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_ppb_write_always_ready
     (.clock            (hclk),
      .reset            (hreset_n),
      .enable           (1'b1),
      .antecedent_expr  (u_matrix.u_sel.ppb_write_q),
      .consequent_expr  (hready_i),
      .fire());

   // --------
   // Core PPB accesses are handled by the MPU, thus the PPB never enters a
   // data-phase.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Faulting core PPB access never has a data phase"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_ppb_acc_no_dphase_fault
     (.clock            (hclk),
      .reset            (hreset_n),
      .enable           (1'b1),
      .antecedent_expr  ((u_core.run_str | u_core.run_ldr) &
                         u_matrix.u_sel.scs_active &
                         (~u_matrix.cfg_dbg | u_matrix.cpu_dphase_q)),
      .consequent_expr  (~u_core.fault_q & u_core.a_cpu_dphase_q),
      .fire());

   // --------
   // Core PPB writes that reach the PPB never fault.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Core PPB write data-phase never faults"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_core_ppb_wr_nvr_flt_in_mtx
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (u_matrix.ppb_trans & u_matrix.ahb_write &
                    ~u_matrix.dif_slot & hready_i),
      .test_expr   (~u_core.fault_q & u_matrix.cpu_dphase_q &
                    u_core.a_cpu_dphase_q),
      .fire        ());

   // --------
   // Core PPB accesses registered in the SCS sel never fault.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Core PPB valid SCS writes never fault"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_core_scs_wr_nvr_flt_in_mtx
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (u_matrix.u_sel.scs_trans & u_matrix.ahb_write &
                    ~u_matrix.dif_slot & hready_i),
      .test_expr   (u_matrix.u_sel.ppb_write_q & ~u_core.fault_q &
                    u_matrix.cpu_dphase_q & u_core.a_cpu_dphase_q),
      .fire        ());

   // --------
   // Core load/store state corresponds to a matrix data-phase unless the
   // transaction is faulted.

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ("Core LDR/STR state requires data-phase or fault"),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
      .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_core_ldrstr_dphase
     ( .clock            (hclk),
       .reset            (hreset_n),
       .enable           (1'b1),
       .antecedent_expr  (u_core.run_ldr | u_core.run_str),
       .consequent_expr  (u_matrix.cpu_dphase_q | u_core.fault_q),
       .fire());

   // --------
   // WIC load and clear are mutually exclusive.

   ovl_zero_one_hot
     #(.severity_level(`OVL_ERROR),
       .width(2),
       .property_type(`OVL_ASSERT),
       .msg("WICLOAD and WICCLEAR must never be coincident"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_wicload_wicclear
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr({wic_load_o,wic_clear_o}),
      .fire());

   // --------
   // WIC deep-sleep mode is never acknowledged if WIC mode is not configured.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("If no WIC is configured, DeepSleep ACK must never be issued"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_nowic_noack
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(~u_nvic.cfg_wic),
      .consequent_expr(wic_ds_ack_n_o),
      .fire());

   reg [31:0] a_loaded_wic_mask_isr_q;
   reg        a_loaded_wic_mask_nmi_q;
   reg        a_loaded_wic_mask_rxev_q;
   reg        a_loaded_wic_q;

   always @(posedge sclk or negedge hreset_n)
     if (~hreset_n) begin
        a_loaded_wic_mask_isr_q[31:0]  <= {32{1'b0}};
        a_loaded_wic_mask_nmi_q        <= 1'b0;
        a_loaded_wic_mask_rxev_q       <= 1'b0;
        a_loaded_wic_q                 <= 1'b0;
     end else if (wic_load_o) begin
        a_loaded_wic_mask_isr_q[31:0]  <= wic_mask_isr_o[31:0];
        a_loaded_wic_mask_nmi_q        <= wic_mask_nmi_o;
        a_loaded_wic_mask_rxev_q       <= wic_mask_rxev_o;
        a_loaded_wic_q                 <= wic_load_o;
     end else if (wic_clear_o) begin
        a_loaded_wic_mask_isr_q[31:0]  <= {32{1'b0}};
        a_loaded_wic_mask_nmi_q        <= 1'b0;
        a_loaded_wic_mask_rxev_q       <= 1'b0;
        a_loaded_wic_q                 <= 1'b0;
     end

   wire [33:0] a_loaded_wic_masks = {a_loaded_wic_mask_rxev_q,
                                     a_loaded_wic_mask_nmi_q,
                                     a_loaded_wic_mask_isr_q[31:0]};

   wire [33:0] a_nvic_wic_masks = {wic_mask_rxev_o, wic_mask_nmi_o,
                                   wic_mask_isr_o[31:0]};

   reg         a_in_wic_ds_mode_at_load_q;

   always @(posedge sclk or negedge hreset_n)
     if      (~hreset_n)                    a_in_wic_ds_mode_at_load_q <= 1'b0;
     else if (~wic_ds_ack_n_o & wic_load_o) a_in_wic_ds_mode_at_load_q <= 1'b1;
     else if ( wic_ds_ack_n_o)              a_in_wic_ds_mode_at_load_q <= 1'b0;

   // --------
   // WIC will be loaded before going into deep sleep state.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("WIC must be loaded before WIC mode deep sleep"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_wic_load_before_deepsleep
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (u_nvic.cfg_wic & sleep_deep_o & ~u_nvic.wake_up &
                        ~wic_ds_ack_n_o),
      .consequent_expr (a_loaded_wic_q),
      .fire            ());

   // --------
   // The WICMASK output should be constant from the point where the WIC is
   // loaded until the processor actually goes to sleep.

   ovl_implication
     #(.severity_level (`OVL_INFO),
       .property_type  (`OVL_ASSERT),
       .msg            ("WICMASK must not change between load and sleep"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_info_wic_masks_when_deepsleeping
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (u_nvic.cfg_wic & sleep_deep_o & ~wic_ds_ack_n_o &
                        ~u_nvic.wake_up & a_in_wic_ds_mode_at_load_q),
      .consequent_expr (a_loaded_wic_masks[33:0] == a_nvic_wic_masks[33:0]),
      .fire            ());

   // --------
   // The debugger is capable of modifying the interrupt priorites such that
   // it may become impossible to wake up. Flag this as information.

   ovl_implication
     #(.severity_level (`OVL_INFO),
       .property_type  (`OVL_ASSERT),
       .msg            ("Debugger NVIC update may prevent wakeup"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_info_dbg_ppb_write_in_wic_ds_sleep
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (u_nvic.cfg_wic & ~u_nvic.wake_up &
                        (cpu_wfi_execute | cpu_wfe_execute) &
                        a_in_wic_ds_mode_at_load_q),
      .consequent_expr (~(mtx_ppb_write & dsl_ppb_active_i)),
      .fire            ());

   // --------
   // The WIC should always be cleared before being reloaded.

   reg         a_wic_log_q;

   always @(posedge sclk or negedge hreset_n)
     if(~hreset_n)
       a_wic_log_q <= 1'b1;
     else if(hready_i & (wic_load_o | wic_clear_o))
       a_wic_log_q <= wic_load_o;

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("WIC must be cleared before being reloaded"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_wic_balanced
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(wic_load_o & hready_i),
      .consequent_expr(~a_wic_log_q),
      .fire());

   // --------
   // Accesses to Strongly Ordered or Device memory are always Shareable.

   wire a_mpu_present_and_enabled;
   wire a_priv_use_default_memmap;
   wire a_hfnmi_use_default_memmap;
   wire a_cpu_hit_in_mpu;

   generate if ((CBAW != 0) || (MPU != 0)) begin : gen_ovl_mpu_present
      assign a_mpu_present_and_enabled = u_mpu.cfg_mpu &
                                         u_mpu.gen_mpu.genable_q;
      assign a_priv_use_default_memmap = u_mpu.cfg_mpu &
                                         u_mpu.gen_mpu.privdefena_q &
                                         hprot_o[1] &
                                         ~a_cpu_hit_in_mpu;
      assign a_hfnmi_use_default_memmap = u_mpu.cfg_mpu &
                                          ~u_mpu.gen_mpu.hfnmiena_q &
                                          cpu_hfnmi;

      wire reg_hit_en_a = u_mpu.gen_mpu.gen_numaddr[0].gen_present.reg_hit_en;
      wire reg_hit_en_b;
      if ((CBAW != 0) || (IOP != 0)) begin: gen_iop1
         assign reg_hit_en_b = u_mpu.gen_mpu.gen_numaddr[1].gen_present.reg_hit_en;
      end else begin: gen_iop0
         assign reg_hit_en_b = 1'b0;
      end

      assign a_cpu_hit_in_mpu = (~u_core.cfg_iop | u_core.ahb_sel_a) ?
                           reg_hit_en_a :
                           reg_hit_en_b;
   end else begin : gen_ovl_mpu_absent
      assign a_mpu_present_and_enabled = 1'b0;
      assign a_priv_use_default_memmap = 1'b0;
      assign a_hfnmi_use_default_memmap= 1'b0;
      assign a_cpu_hit_in_mpu          = 1'b0;
   end endgenerate

   wire a_use_default_memory_map = ~a_mpu_present_and_enabled |
                                   a_priv_use_default_memmap  |
                                   a_hfnmi_use_default_memmap |
                                   u_core.vtable;

   wire [1:0] a_bus_attrs = {hprot_o[3], shareable_o};

   wire a_bus_attrs_correct =
           a_use_default_memory_map & (
            ((haddr_o[31:29] == 3'b000)  & (a_bus_attrs[1:0] == 2'b10)) |
            ((haddr_o[31:29] == 3'b001)  & (a_bus_attrs[1:0] == 2'b10)) |
            ((haddr_o[31:29] == 3'b010)  & (a_bus_attrs[1:0] == 2'b00)) |
            ((haddr_o[31:29] == 3'b011)  & (a_bus_attrs[1:0] == 2'b10)) |
            ((haddr_o[31:29] == 3'b100)  & (a_bus_attrs[1:0] == 2'b10)) |
            ((haddr_o[31:29] == 3'b101)  & (a_bus_attrs[1:0] == 2'b01)) |
            ((haddr_o[31:29] == 3'b110)  & (a_bus_attrs[1:0] == 2'b00)) |
            ((haddr_o[31:20] == 12'hE00) & (a_bus_attrs[1:0] == 2'b01)) |
            ((haddr_o[31:29] == 3'b111)  & (|haddr_o[28:20]) &
                                           (a_bus_attrs[1:0] == 2'b00)) ) |
          ~a_use_default_memory_map & (
            (a_bus_attrs[1]) |
            (a_bus_attrs[1:0] == 2'b01) );

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Memory attributes presented on HPROT for SO/DEV accesses must be consistent with SHAREABLE."),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_sodev_scb_consistent
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(htrans_o[1] & ~hmaster_o),
      .consequent_expr(a_bus_attrs_correct),
      .fire());

   // -------------------------------------------------------------------------

`endif

`ifdef ARM_CM0P_DETERMINISM_CHECKS
   // -------------------------------------------------------------------------
   // Determinism checks
   // -------------------------------------------------------------------------
`include "cm0p_top_determinism.v"
`endif

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
