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
//   Checked In : $Date: 2012-11-21 17:55:38 +0000 (Wed, 21 Nov 2012) $
//   Revision   : $Revision: 229238 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ PROCESSOR CORE
//-----------------------------------------------------------------------------

module cm0p_core
  #(// PROCESSOR CORE PARAMETERIZATION
    // -------------------------------
    parameter CBAW = 0,  // DSM configuration mode if non-zero
    parameter ACG  = 1,  // Clock gates are present if non-zero
    parameter BE   = 0,  // Byte-invariant big-endian mode if non-zero
    parameter DBG  = 0,  // Halting debug enabled if non-zero
    parameter HWF  = 0,  // Only fetch half-words if non-zero
    parameter IOP  = 0,  // IO-port functional if non-zero
    parameter MPU  = 0,  // MPU is present if non-zero
    parameter RAR  = 0,  // Reset all registers if non-zero
    parameter SMUL = 0,  // Implement iterative small multiplier if non-zero
    parameter USER = 0,  // Implement non-privileged mode if non-zero
    parameter VTOR = 0,  // Support vector table offset register if non-zero
    parameter WIC  = 0)  // WIC support is implemented if non-zero

   // -------------------------------------------------------------------------

   (// PROCESSOR CORE SIGNAL PORT LIST
    // -------------------------------

    // CLOCK, RESET AND CLOCK CONTROL
    input  wire        rclk1,                 // Upper register file clock
    input  wire        rclk0,                 // Lower register file clock
    input  wire        hclk,                  // AHB clock
    input  wire        sclk,                  // System clock
    input  wire        hreset_n,              // Active low reset

    output wire        cpu_rclk0_en_o,        // Lower reg-bank clock enable
    output wire        cpu_rclk1_en_o,        // Upper reg-bank clock enable

    // MISCELLANEOUS TRANSACTION INFORMATION
    output wire [ 3:0] code_hint_o,           // Fetch hint signals
    output wire        code_nseq_o,           // Fetch non-sequential to last
    output wire        cpu_spec_htrans_o,     // Speculative transaction
    output wire [ 1:0] data_hint_o,           // Data access hints

    // IO PORT INTERFACE
    output wire [31:0] cpu_io_addr_o,         // IO address
    output wire [31:0] cpu_io_check_o,        // IO address decoder query
    output wire        cpu_io_priv_o,         // IO is privileged
    output wire [ 1:0] cpu_io_size_o,         // IO size
    output wire        cpu_io_trans_o,        // IO valid
    output wire [31:0] cpu_io_wdata_o,        // IO write-data
    output wire        cpu_io_write_o,        // IO write control

    input  wire        io_match_i,            // IO address decoder response
    input  wire [31:0] io_rdata_i,            // IO read data

    // MEMORY PROTECTION UNIT INTERFACE
    output wire [31:0] cpu_addr_a_o,          // Primary address for MPU + DWT
    output wire [26:0] cpu_addr_b_31to5_o,    // 2nd-ary address for MPU lookup
    output wire        cpu_dni_a_o,           // Primary is data access
    output wire        cpu_hfnmi_o,           // HardFault or NMI active
    output wire        cpu_write_a_o,         // Primary is write access

    input  wire        mpu_fault_a_i,         // Primary MPU fault input
    input  wire        mpu_fault_b_i,         // 2nd-ary MPU fault input
    input  wire [ 2:0] mpu_scb_a_i,           // Primary access attributes
    input  wire [ 2:0] mpu_scb_b_i,           // 2nd-ary access attributes

    // AHB/PPB BUS MATRIX INTERFACE
    output wire        cpu_dni_o,             // Bus access data not instruction
    output wire [31:0] cpu_haddr_o,           // Bus address
    output wire [ 1:0] cpu_hsize_o,           // Bus access size
    output wire [31:0] cpu_hwdata_o,          // Bus write-data
    output wire        cpu_hwrite_o,          // Bus access write not read
    output wire        cpu_priv_o,            // Bus access is privileged
    output wire [ 2:0] cpu_scb_o,             // Bus access attributes
    output wire        cpu_trans_o,           // Bus access to PPB or AHB
    output wire        cpu_wphase_o,          // Bus write-data active

    input  wire [31:0] hrdata_i,              // Bus read-data
    input  wire        hready_i,              // Bus ready / core advance

    input  wire        mtx_cpu_resp_i,        // Bus error response
    input  wire        mtx_ppb_active_i,      // PPB space data-phase active
    input  wire [31:0] mtx_ppb_hrdata_i,      // PPB space read-data

    // DEBUG INTERFACE
    output wire        cpu_bpu_event_o,       // BPU hit / BKPT in execute
    output wire        cpu_dbg_ex_last_o,     // Core is retiring, for debug
    output wire        cpu_dbg_ex_reset_o,    // Core is in reset, for debug
    output wire        cpu_dbg_stall_o,       // Inhibit debug transactions
    output wire [31:0] cpu_dcrdr_data_o,      // Debugger read data
    output wire        cpu_dwt_ia_ok_o,       // IAEX valid, for debug
    output wire [30:0] cpu_dwt_iaex_o,        // PC value for watchpoint PCSR
    output wire        cpu_dwt_trans_o,       // Perform watchpoint checks
    output wire        cpu_halt_ack_o,        // Core has halted
    output wire [ 1:0] cpu_ls_size_o,         // Access size for watchpoints
    output wire        cpu_pipefull_o,        // Pipeline full indicator

    input  wire [ 1:0] bpu_match_i,           // Per halfword breakpoint match
    input  wire        dbg_c_debugen_i,       // Global master debug enable
    input  wire        dbg_halt_req_i,        // Debug halt request
    input  wire        dbg_op_run_i,          // Debug DCRSR action request
    input  wire        dif_cpu_force_idle_i,  // Debug I/F forced access (QoS)
    input  wire [31:0] dif_wdata_i,           // Debug DCRSR/DCRDR value
    input  wire        msl_dbg_aux_en_i,      // Debug DCRDR load to AUX
    input  wire        msl_dbg_op_en_i,       // Debug DCRSR load to decoder

    // PROGRAM FLOW MONITORING INTERFACE
    output wire [30:0] iaex_o,                // Instruction address
    output wire        iaex_en_o,             // Instruction address enabled
    output wire        iaex_seq_o,            // Instruction address sequential
    output wire        atomic_o,              // Execution mode is atomic

    // INTERRUPT AND SLEEP CONTROL
    output wire        lockup_o,              // Core is in Lockup state
    output wire        sleep_hold_ack_n_o,    // Sleep extension acknowledge
    output wire        txev_o,                // Event output (SEV executed)
    output wire        wic_clear_o,           // WIC should clear
    output wire        wic_load_o,            // WIC should load

    input  wire        cpu_wait_i,            // Wait out of reset
    input  wire [ 7:0] irq_latency_i,         // Interrupt latency
    input  wire        sleep_hold_req_n_i,    // Sleep extension request

    output wire        cpu_event_clear_o,     // Clear event register
    output wire        cpu_ex_idle_o,         // Core is sleeping/inactive
    output wire        cpu_hdf_active_o,      // IPSR is HardFault
    output wire        cpu_hdf_pend_o,        // Hardfault pend request
    output wire        cpu_hdf_request_o,     // Hardfault request
    output wire        cpu_int_ready_o,       // Interrupt registered
    output wire        cpu_int_return_o,      // Current IPSR interrupt return
    output wire        cpu_int_taken_o,       // Current IPSR interrupt taken
    output wire [ 5:0] cpu_ipsr_o,            // Current IPSR value
    output wire        cpu_n_or_h_active_o,   // IPSR is NMI or HardFault
    output wire        cpu_nmi_active_o,      // IPSR is NMI
    output wire        cpu_primask_ex_o,      // Forwarded PRIMASK value
    output wire        cpu_primask_o,         // Registered PRIMASK value
    output wire        cpu_svc_request_o,     // SVCall pend request
    output wire        cpu_wfe_execute_o,     // Executing WFE
    output wire        cpu_wfi_execute_o,     // Executing WFI or sleep-on-exit

    input  wire        nvm_int_pend_i,        // Interrupt pending
    input  wire [ 5:0] nvm_int_pend_num_i,    // Pending interrupt number
    input  wire        nvm_sleep_on_exit_i,   // Return to Thread should WFI
    input  wire        nvm_svc_escalate_i,    // Priority exceeds SVCall
    input  wire        nvm_vect_clr_active_i, // Clear all exceptions
    input  wire [23:0] nvm_vtor_31to8_i,      // Vector table offset input
    input  wire        nvm_wfe_advance_i,     // Any WFE should retire
    input  wire        nvm_wfi_advance_i);    // Any WFI should retire

   // -------------------------------------------------------------------------
   // Configuration
   // -------------------------------------------------------------------------

   // This code translates each of the parameters into a signal suitable for
   // use in later logic. For normal operation, CBAW must be zero; non-zero
   // values are reserved for use by ARM Limited in generating configurable
   // simulation models.

   wire        cfg_acg, cfg_be, cfg_dbg, cfg_hwf, cfg_iop, cfg_mpu, cfg_rar;
   wire        cfg_smul, cfg_user, cfg_vtor, cfg_wic;

   generate
      if(CBAW == 0) begin : gen_cbaw
         assign cfg_acg  = (ACG  != 0);
         assign cfg_be   = (BE   != 0);
         assign cfg_dbg  = (DBG  != 0);
         assign cfg_hwf  = (HWF  != 0);
         assign cfg_iop  = (IOP  != 0);
         assign cfg_mpu  = (MPU  != 0);
         assign cfg_rar  = (RAR  != 0);
         assign cfg_smul = (SMUL != 0);
         assign cfg_user = (USER != 0);
         assign cfg_vtor = (VTOR != 0);
         assign cfg_wic  = (WIC  != 0);
      end
   endgenerate

   // -------------------------------------------------------------------------
   // Halting debug support
   // -------------------------------------------------------------------------

   // If halting debug support is not present then mask out appropriate inputs
   // from the debug modules.

   wire [ 1:0] bpu_match;
   wire        dbg_halt_req, dbg_op_run, debug_en, msl_dbg_op_en;
   wire        msl_dbg_aux_en;
   wire [31:0] dif_wdata;
   wire        dif_cpu_force_idle;
   wire        vect_clr_active;

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_0a

         assign bpu_match          = {2{cfg_dbg}} & bpu_match_i[1:0];
         assign dbg_halt_req       = cfg_dbg & dbg_halt_req_i;
         assign dbg_op_run         = cfg_dbg & dbg_op_run_i;
         assign debug_en           = cfg_dbg & dbg_c_debugen_i;
         assign dif_wdata          = {32{cfg_dbg}} & dif_wdata_i[31:0];
         assign dif_cpu_force_idle = cfg_dbg & dif_cpu_force_idle_i;
         assign msl_dbg_op_en      = cfg_dbg & msl_dbg_op_en_i;
         assign msl_dbg_aux_en     = cfg_dbg & msl_dbg_aux_en_i;
         assign vect_clr_active    = cfg_dbg & nvm_vect_clr_active_i;

      end else begin : gen_dbg_0b

         wire [40:0] unused = { bpu_match_i[1:0], dbg_halt_req_i, dbg_op_run_i,
                                dbg_c_debugen_i, dif_wdata_i[31:0],
                                msl_dbg_op_en_i, msl_dbg_aux_en_i,
                                dif_cpu_force_idle_i, nvm_vect_clr_active_i };

         assign { bpu_match[1:0], dbg_halt_req, dbg_op_run, debug_en,
                  dif_wdata[31:0], msl_dbg_op_en, msl_dbg_aux_en,
                  dif_cpu_force_idle, vect_clr_active } = 41'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // IO port support
   // -------------------------------------------------------------------------

   // The io_match signal indicates that the current load/store address is to
   // the IO port. If the IO port is not implemented, then remove io_match_i
   // influence over AHB signal timing.

   wire io_match;

   generate
      if((CBAW != 0) || (IOP != 0)) begin : gen_iop_0a

         assign io_match = cfg_iop & io_match_i;

      end else begin : gen_iop_0b

         wire unused = io_match_i;
         assign io_match = 1'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Vector table offset support
   // -------------------------------------------------------------------------

   // If supported, the vector table offset register provides the ability for
   // software to configure the upper 24-bits of the address used for vector
   // table accesses.

   wire [23:0] vtor_31to8;

   generate
      if((CBAW != 0) || (VTOR != 0)) begin : gen_vtor_0a

         assign vtor_31to8 = {24{cfg_vtor}} & nvm_vtor_31to8_i;

      end else begin : gen_vtor_0b

         wire [24:0] unused = { cfg_vtor, nvm_vtor_31to8_i[23:0] };
         assign vtor_31to8 = 24'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Definition of constant values for various states
   // -------------------------------------------------------------------------

   localparam [3:0] st_exe = 4'b0000;  // First / single-cycle execute
   localparam [3:0] st_pfu = 4'b0001;  // Fetch / pipeline refill machine
   localparam [3:0] st_ldr = 4'b0010;  // Load data-phase
   localparam [3:0] st_mul = 4'b0011;  // Multi-cycle MULS machine state
   localparam [3:0] st_stm = 4'b0100;  // STM / PUSH data-phase
   localparam [3:0] st_ldm = 4'b0101;  // LDM / POP data-phase
   localparam [3:0] st_hlt = 4'b0110;  // Halting debug state
   localparam [3:0] st_wfx = 4'b0111;  // Wait for event state
   localparam [3:0] st_str = 4'b1000;  // Store data-phase
   localparam [3:0] st_t32 = 4'b1001;  // 32-bit opcode second cycle
   localparam [3:0] st_u_a = 4'b1010;  // Reserved state 0xA
   localparam [3:0] st_u_b = 4'b1011;  // Reserved state 0xB
   localparam [3:0] st_irq = 4'b1100;  // Interrupt exception machine
   localparam [3:0] st_rfe = 4'b1101;  // Return from exception machine
   localparam [3:0] st_lck = 4'b1110;  // Architectural lockup state
   localparam [3:0] st_rst = 4'b1111;  // Reset state machine

   // -------------------------------------------------------------------------
   // Define register state
   // -------------------------------------------------------------------------

   // Approximately 700 bits of state are used by the processor core, of which
   // ~80% is purely architectural.

   reg  [ 3:0] apsr_q;       // Application processor status registers
   reg         atomic_q;     // Interrupt and debug mode operation
   reg  [31:0] aux_q;        // Auxiliary register
   reg  [ 2:0] base_q;       // Size and address for load/store data phase
   reg         extend_q;     // Sign extend load reused as extend fetch phase
   reg         fault_q;      // Registered AHB data-phase fault
   reg         hdf_lock_q;   // Lockup on Hardfault vector fetch
   reg         hdf_pushed_q; // HardFault is stacked active
   reg  [30:0] iaex_q;       // Instruction address in execute
   reg         int_ready_q;  // Registered interrupt request
   reg         io_buf_a_q;   // IO buffer contains valid address
   reg         io_buf_d_q;   // IO buffer contains valid read-data
   reg  [31:0] io_buf_q;     // IO port read-data and address buffer
   reg  [ 2:0] io_rp_addr_q; // IO port read-port pointer
   reg         io_rsel_q;    // IO port selected for read-data
   reg  [ 5:0] ipsr_q;       // Architectural exception number
   reg  [15:0] iq_q;         // Instruction queue entry
   reg         iq_s_q;       // Instruction queue entry is special type
   reg         iq_branch_q;  // Instruction queue contains a branch operation
   reg  [ 7:0] list_q;       // Register list for LDM/STM/PUSH/POP
   reg  [29:0] msp_q;        // Architectural Main Stack Pointer
   reg         nmi_lock_q;   // Lockup on NMI vector fetch
   reg         npriv_q;      // Architectural CONTROL.nPRIV register
   reg  [ 3:0] offset_q;     // Offset of LDM/STM and state sub-cycle number
   reg  [15:0] op_q;         // Decode instruction opcode
   reg         op_s_q;       // Decode instruction opcode is special type
   reg         primask_q;    // Architectural PRIMASK register
   reg  [29:0] psp_q;        // Architectural Process Stack Pointer
   reg  [31:0] r00_q;        // Architectural general purpose register R0
   reg  [31:0] r01_q;        // Architectural general purpose register R1
   reg  [31:0] r02_q;        // Architectural general purpose register R2
   reg  [31:0] r03_q;        // Architectural general purpose register R3
   reg  [31:0] r04_q;        // Architectural general purpose register R4
   reg  [31:0] r05_q;        // Architectural general purpose register R5
   reg  [31:0] r06_q;        // Architectural general purpose register R6
   reg  [31:0] r07_q;        // Architectural general purpose register R7
   reg  [31:0] r08_q;        // Architectural general purpose register R8
   reg  [31:0] r09_q;        // Architectural general purpose register R9
   reg  [31:0] r10_q;        // Architectural general purpose register R10
   reg  [31:0] r11_q;        // Architectural general purpose register R11
   reg  [31:0] r12_q;        // Architectural general purpose register R12
   reg  [31:0] r14_q;        // Architectural general purpose register R14/LR
   reg  [ 3:0] ra_addr_q;    // Read-port A pointer
   reg  [ 3:0] rb_addr_q;    // Read-port B pointer
   reg         sleep_lock_q; // Sleep extension acknowledgement
   reg         spsel_q;      // Architectural CONTROL.SPSEL register
   reg  [ 3:0] state_q;      // Execution state of machine
   reg         tbit_q;       // Architectural Thumb-bit

   // -------------------------------------------------------------------------
   // Correct endianess of IO port and AHB bus data for reads
   // -------------------------------------------------------------------------

   // Both the AHB and IO port support byte-invariant big-endian data formats.
   // If required, perform a hard byte swap so as to make the data correct for
   // big-endian word-sized reads. Sub-word reads are handled within the byte-
   // permute matrix.

   wire [31:0] ahb_rdata;
   wire [31:0] iop_rdata;

   function [31:0] f_byte_swap(input [31:0] val_i);
      f_byte_swap = { val_i[7:0], val_i[15:8], val_i[23:16], val_i[31:24] };
   endfunction

   // --------

   generate
      if(CBAW != 0) begin : gen_be_0a

         wire [31:0] ahb_data_be = f_byte_swap(hrdata_i[31:0]);
         wire [31:0] iop_data_be = f_byte_swap(io_rdata_i[31:0]);

         assign ahb_rdata = cfg_be ? ahb_data_be : hrdata_i;
         assign iop_rdata = cfg_be ? iop_data_be : io_rdata_i;

      end else if(BE != 0) begin : gen_be_0b

         assign ahb_rdata = f_byte_swap(hrdata_i[31:0]);
         assign iop_rdata = f_byte_swap(io_rdata_i[31:0]);

      end else begin : gen_be_0c

         assign ahb_rdata = hrdata_i;
         assign iop_rdata = io_rdata_i;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Preselect between AHB, IO port, IO buffer and PPB read-data
   // -------------------------------------------------------------------------

   wire [31:0] bus_rdata;

   generate
      if((CBAW != 0) || (IOP != 0)) begin : gen_iop_1a

         wire bus_sel_iop = io_rsel_q & ~io_buf_d_q;
         wire bus_sel_buf = io_buf_d_q;
         wire bus_sel_ppb =  mtx_ppb_active_i & ~io_rsel_q;
         wire bus_sel_ahb = ~mtx_ppb_active_i & ~io_rsel_q;

         assign bus_rdata = ( {32{bus_sel_iop}} & iop_rdata |
                              {32{bus_sel_buf}} & io_buf_q |
                              {32{bus_sel_ppb}} & mtx_ppb_hrdata_i |
                              {32{bus_sel_ahb}} & ahb_rdata );

      end else begin : gen_iop_1b

         wire [65:0] unused = { io_buf_d_q, io_buf_q[31:0], io_rsel_q,
                                iop_rdata[31:0] };

         assign bus_rdata = ( {32{ mtx_ppb_active_i}} & mtx_ppb_hrdata_i |
                              {32{~mtx_ppb_active_i}} & ahb_rdata );

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Determine whether load/store-multiple list is empty
   // -------------------------------------------------------------------------

   // The list is stored as one-bit per register to be loaded/stored, minus R0,
   // i.e. the list is formed of {PC/LR, R7, R6...R1}. For exception entry and
   // return, R4 is treated as being R12 to meet the stacking requirements.

   wire        list_empty = list_q == 8'b0;

   // -------------------------------------------------------------------------
   // Breakout APSR flags to simplify later expressions
   // -------------------------------------------------------------------------

   // The four APSR bits stored correspond to APSR[31:28], which are  the arch-
   // itectural N, Z, C and V flags respectively.

   wire        nflag = apsr_q[3];  // Result negative flag - from any operation
   wire        zflag = apsr_q[2];  // Result zero flag - from any operation
   wire        cflag = apsr_q[1];  // Carry out flag - from add/subtract/shift
   wire        vflag = apsr_q[0];  // Sign overflow flag - from add/subtract

   // -------------------------------------------------------------------------
   // Analyze IPSR field
   // -------------------------------------------------------------------------

   // The IPSR encodes the current exception number. Zero indicates Thread
   // mode, which is both the lowest priority, and the only exception number
   // permitted to execute as Unprivileged and use the process stack pointer.

   // Non-zero values indicate execution in a Privileged Handler mode, with
   // values of 2 and 3 represent NMI and HardFault respectively. The NVIC
   // handles these two modes and the use of PRIMASK separately, thus deter-
   // mining whether we are at or above SVCall priority, and as such that SVC
   // is UNDEFINED, requires factoring in here.

   wire        top_set       = ipsr_q[5:2] != 4'b0;

   wire        nmi_active    = ~top_set & (ipsr_q[1:0] == 2'b10);
   wire        hdf_active    = ~top_set & (ipsr_q[1:0] == 2'b11);
   wire        handler       =  top_set | (ipsr_q[1:0] != 2'b00);

   wire        n_or_h_active = nmi_active | hdf_active;
   wire        svc_is_undef  = primask_q | nvm_svc_escalate_i;

   // -------------------------------------------------------------------------
   // Determine whether current execution is Privileged or Unprivileged
   // -------------------------------------------------------------------------

   // Execution is Privileged if Unprivileged mode is not supported, or if
   // executing in Thread-Mode with CONTROL.nPRIV clear, or if executing in
   // Handler-Mode.

   wire        priv;

   generate
      if((CBAW != 0) || (USER != 0)) begin : gen_user_0a

         assign priv = ~cfg_user | ~npriv_q | handler;

      end else begin : gen_user_0b

         wire unused = cfg_user;
         assign priv = 1'b1;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Auxiliary decode of PC in register specifiers
   // -------------------------------------------------------------------------

   // Special cases exist for MOV/CPY, CMP and ADD5 with PC as a source or
   // destination register. Perform a check against the opcode to determine
   // whether any of the operands are the PC (encoded as R15):

   wire       ra_hi_pc = {op_q[7],op_q[2:0]} == 4'hF;
   wire       rb_hi_pc = op_q[6:3] == 4'hF;

   // -------------------------------------------------------------------------
   // Condition code pass/fail computation for B(1)
   // -------------------------------------------------------------------------

   // The B1 conditional branch instruction has a four-bit condition code which
   // specifies whether the branch should be taken or not based upon the
   // current values of the APSR N, Z, C and V flags. Regardless of the actual
   // instruction being executed, compute the condition-code-pass result based
   // on the condition-code encoded in opcode bits[11:8].

   wire        cc_n_eq_v = nflag == vflag;

   wire [ 7:0] cc_mux    = { 1'b0,                // Reserved
                             ~zflag & cc_n_eq_v,  // GT or LE
                             cc_n_eq_v,           // GE or LT
                             cflag & ~zflag,      // HI or LS
                             vflag,               // VS or VC
                             nflag,               // MI or PL
                             cflag,               // CS or CC
                             zflag };             // EQ or NE

   wire        cc_pass   = cc_mux[op_q[11:9]] ^ op_q[8];

   // -------------------------------------------------------------------------
   // Interrupt jitter suppression logic
   // -------------------------------------------------------------------------

   // Interrupts are recognized on any SCLK and recorded directly into the IQ
   // buffer which tracks both the exception number and a separate counter
   // which counts down until such time as the exception vector fetch should be
   // performed.

   // Whilst not in an atomic state, the fact that IQ holds an interrupt rather
   // than an instruction is recorded by IQ special being set and IQ[15:14]
   // both being one.

   wire        iq_is_irq    = iq_s_q & (iq_q[15:14] == 2'b11);
   wire        delay_mode   = nvm_int_pend_i | iq_is_irq | atomic_q;
   wire [ 7:0] int_count    = {8{delay_mode}} & iq_q[13:6];
   wire        count_active = int_count != 8'b0;
   wire        irq_hold     = count_active;

   // -------------------------------------------------------------------------
   // Map and implement both register-file read-ports
   // -------------------------------------------------------------------------

   // The value read for SP depends on the current mode of operation, which is
   // determined architecturally via CONTROL.SPSEL, held in the design as
   // spsel_q. The least two significant bits of SP are always zero and are not
   // held in registers, so extend the result up to 32-bits by shifting left.

   wire [31:0] sp_main    = { msp_q, 2'b00 };  // MSP for MRS instruction
   wire [31:0] sp_process = { psp_q, 2'b00 };  // PSP for MRS instruction

   wire [31:0] sp_value   = { {30{spsel_q}} & psp_q |  // R13 is Process SP
                              {30{~spsel_q}} & msp_q,  // R13 is Main SP
                              2'b00 };                 // SP[1:0] are RAZ/WI

   // The read-ports present R0-R12 and R14 at the expected places and insert
   // the preselected stack-pointer as R13. For timing reasons, accesses to
   // the PC are not performed via R15 in the read-ports, instead this value
   // is used to provide access to the auxiliary register. Register values are
   // mapped to register numbers here.

   wire [31:0] readport [15:0];  // Define 32-bit x 16 entry wire array

   assign      readport[4'h0] = r00_q;     // 4'h0 --> R0
   assign      readport[4'h1] = r01_q;     // 4'h1 --> R1
   assign      readport[4'h2] = r02_q;     // 4'h2 --> R2
   assign      readport[4'h3] = r03_q;     // 4'h3 --> R3
   assign      readport[4'h4] = r04_q;     // 4'h4 --> R4
   assign      readport[4'h5] = r05_q;     // 4'h5 --> R5
   assign      readport[4'h6] = r06_q;     // 4'h6 --> R6
   assign      readport[4'h7] = r07_q;     // 4'h7 --> R7
   assign      readport[4'h8] = r08_q;     // 4'h8 --> R8
   assign      readport[4'h9] = r09_q;     // 4'h9 --> R9
   assign      readport[4'hA] = r10_q;     // 4'hA --> R10
   assign      readport[4'hB] = r11_q;     // 4'hB --> R11
   assign      readport[4'hC] = r12_q;     // 4'hC --> R12
   assign      readport[4'hD] = sp_value;  // 4'hD --> SP (MSP or PSP)
   assign      readport[4'hE] = r14_q;     // 4'hE --> R14
   assign      readport[4'hF] = aux_q;     // 4'hF --> Auxiliary register

   // Implement each of the two read-ports as a simple mux into the mapped
   // array of values using the associated preregistered pointer values.

   wire [31:0] ra_value = readport[ra_addr_q];  // 32x 16:1 multiplex
   wire [31:0] rb_value = readport[rb_addr_q];  // 32x 16:1 multiplex

   // -------------------------------------------------------------------------
   // Instruction decoders
   // -------------------------------------------------------------------------

   // Each of the following sections generates control signals specific to
   // the behavior of each instruction class.

   // -------------------------------------------------------------------------
   // 16-bit branch format 1 decoder: B1
   // -------------------------------------------------------------------------

   // Branches to self are special cased in order to both reduce power
   // consumption and to provide idle AHB cycles for the debugger to gain
   // access. The branch operation completes even if interrupted.

   wire        fmt_br1 = {op_q[15:12],&op_q[11:9]} == 5'b1101_0;

   // Note:    br1_isn_b1 = 1'b1;  // Bcc to PC + (simm8 << 1)

   // --------

   wire        br1_to_self = op_q[7:0] == 8'b11111110;
   wire        br1_delayed = cc_pass & br1_to_self;

   // --------

   wire        br1_fe_use_add    = cc_pass;
   wire        br1_fetch_force   = cc_pass & ~br1_to_self;
   wire        br1_fetch_stall   = br1_delayed;
   wire        br1_iaex_nsel_inc = cc_pass;
   wire        br1_iaex_sel_add  = cc_pass;
   wire        br1_op_hold       = cc_pass;
   wire        br1_opa_nsel_ra   = 1'b1;
   wire        br1_opa_sel_pc    = 1'b1;
   wire        br1_opb_sel_simm8 = 1'b1;
   wire        br1_pdec_sel_old  = br1_delayed;
   wire        br1_ra_addr_hold  = cc_pass;
   wire        br1_rb_addr_hold  = cc_pass;
   wire        br1_extend_en     = 1'b1;
   wire        br1_extend_nxt    = br1_delayed;
   wire        br1_state_en_std  = cc_pass;
   wire        br1_state_sel_pfu = 1'b1;

   // -------------------------------------------------------------------------
   // 16-bit branch format 2 decoder: B2
   // -------------------------------------------------------------------------

   // Branches to self are again optimized for power reduction and to yield the
   // AHB interface for debugger accesses. The branch operation completes even
   // if interrupted.

   wire        fmt_br2 = op_q[15:11] == 5'b11100;

   // Note:    br2_isn_b2 = 1'b1;  // B to PC + (simm11 << 1)

   // --------

   wire        br2_to_self = br1_to_self & (op_q[10:8] == 3'b111);

   // --------

   wire        br2_fe_use_add     = 1'b1;
   wire        br2_fetch_force    = ~br2_to_self;
   wire        br2_fetch_stall    = br2_to_self;
   wire        br2_iaex_nsel_inc  = 1'b1;
   wire        br2_iaex_sel_add   = 1'b1;
   wire        br2_op_hold        = 1'b1;
   wire        br2_opa_nsel_ra    = 1'b1;
   wire        br2_opa_sel_pc     = 1'b1;
   wire        br2_opb_sel_simm11 = 1'b1;
   wire        br2_pdec_sel_old   = 1'b1;
   wire        br2_ra_addr_hold   = 1'b1;
   wire        br2_rb_addr_hold   = 1'b1;
   wire        br2_extend_en      = 1'b1;
   wire        br2_extend_nxt     = br2_to_self;
   wire        br2_state_en_std   = 1'b1;
   wire        br2_state_sel_pfu  = 1'b1;

   // -------------------------------------------------------------------------
   // 16-bit branch format 3 decoder: BLX and BX
   // -------------------------------------------------------------------------

   // BX and BLX provide indirect, register based, branches; in addition to
   // this, BX branches to addresses prefixed with 0xF result in an exception
   // return if we are currently in Handler mode.

   // BX/BLX to PC is architecturally UNPREDICTABLE, and if allowed to execute
   // as normal would cause potentially uninitialized state to determine
   // whether a return was to be performed due to PC not factoring into the
   // rb_value read-port. To address this, BX/BLX are treated as UNDEFINED, see
   // u16_3.

   // The indirect branch operations always complete, even if interrupted, with
   // the exception of those producing an exception return. Exception return BX
   // types are abandoned, and the current PC preserved.

   wire        pre_br3 = op_q[15:8] == 8'b01000111;
   wire        fmt_br3 = pre_br3 & ~rb_hi_pc;  // BX/BLX PC is UNPREDICTABLE

   wire        br3_isn_bx  = op_q[7] == 1'b0;  // B to Rm (or exception return)
   wire        br3_isn_blx = op_q[7] == 1'b1;  // BLX to Rm

   // --------

   wire        br3_exc_return = rb_value[31:28] == 4'hF;
   wire        br3_bx_rfe     = handler & br3_isn_bx & br3_exc_return;

   // --------

   wire        br3_alu_res_sel_add   = 1'b1;
   wire        br3_atomic_en         = br3_bx_rfe;
   wire        br3_extend_en         = 1'b1;
   wire        br3_extend_nxt        = 1'b0;
   wire        br3_fe_use_rb         = 1'b1;
   wire        br3_fetch_force       = ~br3_bx_rfe;
   wire        br3_fetch_stall       = br3_bx_rfe;
   wire        br3_iaex_hold         = br3_bx_rfe & int_ready_q;
   wire        br3_iaex_nsel_inc     = 1'b1;
   wire        br3_iaex_sel_rb       = 1'b1;
   wire        br3_offset_en         = br3_bx_rfe;
   wire        br3_offset_nsel_one   = 1'b1;
   wire        br3_op_hold           = 1'b1;
   wire        br3_opa_nsel_ra       = 1'b1;
   wire        br3_opa_sel_pc        = 1'b1;
   wire        br3_opb_inv           = 1'b1;
   wire        br3_ra_addr_hold      = ~br3_bx_rfe;
   wire        br3_ra_addr_nsel_pdec = 1'b1;
   wire        br3_ra_addr_sel_r13   = 1'b1;
   wire        br3_rb_addr_hold      = 1'b1;
   wire        br3_spsel_en          = br3_bx_rfe & ~int_ready_q;
   wire        br3_spsel_sel_rb2     = 1'b1;
   wire        br3_state_en_std      = 1'b1;
   wire        br3_state_sel_pfu     = ~br3_bx_rfe;
   wire        br3_state_sel_rfe     = br3_bx_rfe;
   wire        br3_tbit_en           = ~br3_bx_rfe;
   wire        br3_wr_addr_sel_r14   = 1'b1;
   wire        br3_wr_data_sel_alu   = 1'b1;
   wire        br3_wr_en_std         = br3_isn_blx;

   // -------------------------------------------------------------------------
   // 16-bit data-processing format 1 decoder: ADD3 and SUB3
   // -------------------------------------------------------------------------

   wire        fmt_dp1 = op_q[15:10] == 6'b000110;

   // Note:    dp1_isn_add3 = op_q[9] == 1'b0;  // Rd = Rn + Rm
   wire        dp1_isn_sub3 = op_q[9] == 1'b1;  // Rd = Rn - Rm

   // --------

   wire        dp1_alu_res_sel_add = 1'b1;
   wire        dp1_apsr_en         = 1'b1;
   wire        dp1_apsr_sel_add    = 1'b1;
   wire        dp1_opb_inv         = dp1_isn_sub3;
   wire        dp1_opc_sel_one     = dp1_isn_sub3;
   wire        dp1_opb_sel_rb      = 1'b1;
   wire        dp1_wr_addr_sel_z20 = 1'b1;
   wire        dp1_wr_data_sel_alu = 1'b1;
   wire        dp1_wr_en_std       = 1'b1;

   // -------------------------------------------------------------------------
   // 16-bit data-processing format 2 decoder: ADD1 and SUB1
   // -------------------------------------------------------------------------

   wire        fmt_dp2 = op_q[15:10] == 6'b000111;

   // Note:    dp2_isn_add1 = op_q[9] == 1'b0;  // Rd = Rn + imm3
   wire        dp2_isn_sub1 = op_q[9] == 1'b1;  // Rd = Rn - imm3

   // --------

   wire        dp2_alu_res_sel_add = 1'b1;
   wire        dp2_apsr_en         = 1'b1;
   wire        dp2_apsr_sel_add    = 1'b1;
   wire        dp2_opb_inv         = dp2_isn_sub1;
   wire        dp2_opb_sel_imm3    = 1'b1;
   wire        dp2_opc_sel_one     = dp2_isn_sub1;
   wire        dp2_wr_addr_sel_z20 = 1'b1;
   wire        dp2_wr_data_sel_alu = 1'b1;
   wire        dp2_wr_en_std       = 1'b1;

   // -------------------------------------------------------------------------
   // 16-bit data-processing format 3 decoder: ADD2 CMP1 MOV1 and SUB2
   // -------------------------------------------------------------------------

   wire        fmt_dp3 = op_q[15:13] == 3'b001;

   wire        dp3_isn_mov1 = op_q[12:11] == 2'b00;  // Rd = imm8
   wire        dp3_isn_cmp1 = op_q[12:11] == 2'b01;  // Rn - imm8
   // Note:    dp3_isn_add2 = op_q[12:11] == 2'b10;  // Rd = Rd + imm8
   wire        dp3_isn_sub2 = op_q[12:11] == 2'b11;  // Rd = Rd - imm8

   // --------

   wire        dp3_alu_res_sel_add = 1'b1;
   wire        dp3_apsr_en         = 1'b1;
   wire        dp3_apsr_sel_add    = ~dp3_isn_mov1;
   wire        dp3_apsr_sel_bit    = dp3_isn_mov1;
   wire        dp3_opa_nsel_ra     = dp3_isn_mov1;
   wire        dp3_opb_inv         = dp3_isn_cmp1 | dp3_isn_sub2;
   wire        dp3_opb_sel_imm8    = 1'b1;
   wire        dp3_opc_sel_one     = dp3_opb_inv;
   wire        dp3_wr_data_sel_alu = 1'b1;
   wire        dp3_wr_en_std       = ~dp3_isn_cmp1;

   // -------------------------------------------------------------------------
   // 16-bit data-processing format 4 decoder: ASR1 LSL1 and LSR1
   // -------------------------------------------------------------------------

   wire        fmt_dp4 = {op_q[15:13],&op_q[12:11]} == 4'b000_0;

   wire        dp4_isn_lsl1 = op_q[12:11] == 2'b00;  // Rd = Rm << imm5
   // Note:    dp4_isn_lsr1 = op_q[12:11] == 2'b01;  // Rd = Rm >> imm5
   wire        dp4_isn_asr1 = op_q[12:11] == 2'b10;  // Rd = s(Rm) >>> imm5

   // --------

   wire        dp4_apsr_en           = 1'b1;
   wire        dp4_apsr_sel_rot      = 1'b1;
   wire        dp4_c_gt_32_sel_nf    = dp4_isn_asr1;
   wire        dp4_c_le_32_sel_00    = dp4_isn_lsl1;
   wire        dp4_c_le_32_sel_31    = ~dp4_isn_lsl1;
   wire        dp4_mtx_ctl_sel_rot   = 1'b1;
   wire        dp4_mtx_in_sel_rot    = 1'b1;
   wire        dp4_rot_amt_sel_imm   = 1'b1;
   wire        dp4_ror_amt_sel_left  = dp4_isn_lsl1;
   wire        dp4_ror_amt_sel_right = ~dp4_isn_lsl1;
   wire        dp4_rot_sign_sel_ra31 = dp4_isn_asr1;
   wire        dp4_shf_left          = dp4_isn_lsl1;
   wire        dp4_wr_addr_sel_z20   = 1'b1;
   wire        dp4_wr_data_sel_spu   = 1'b1;
   wire        dp4_wr_en_std         = 1'b1;

   // -------------------------------------------------------------------------
   // 16-bit data-processing format 5 decoder: ADC AND ASR2 BIC CMN CMP2 EOR
   //                                          LSL2 LSR2 MUL MVN NEG ORR ROR
   //                                          SBC and TST
   // -------------------------------------------------------------------------

   wire        fmt_dp5 = op_q[15:10] == 6'b010000;

   wire        dp5_isn_and  = op_q[9:6] == 4'b0000;  // Rd = Rd & Rm
   wire        dp5_isn_eor  = op_q[9:6] == 4'b0001;  // Rd = Rd ^ Rm
   wire        dp5_isn_lsl2 = op_q[9:6] == 4'b0010;  // Rd = Rd << Rm
   wire        dp5_isn_lsr2 = op_q[9:6] == 4'b0011;  // Rd = Rd >> Rm
   wire        dp5_isn_asr2 = op_q[9:6] == 4'b0100;  // Rd = s(Rd) >>> Rm
   wire        dp5_isn_adc  = op_q[9:6] == 4'b0101;  // Rd = Rd + Rm + C
   wire        dp5_isn_sbc  = op_q[9:6] == 4'b0110;  // Rd = Rd - Rm - !C
   wire        dp5_isn_ror  = op_q[9:6] == 4'b0111;  // Rd = {Rd,Rd} >> Rm
   wire        dp5_isn_tst  = op_q[9:6] == 4'b1000;  // Rd & Rm
   wire        dp5_isn_neg  = op_q[9:6] == 4'b1001;  // Rd = 0 - Rm
   wire        dp5_isn_cmp2 = op_q[9:6] == 4'b1010;  // Rd - Rm
   wire        dp5_isn_cmn  = op_q[9:6] == 4'b1011;  // Rd + Rm
   wire        dp5_isn_orr  = op_q[9:6] == 4'b1100;  // Rd = Rd | Rm
   wire        dp5_isn_mul  = op_q[9:6] == 4'b1101;  // Rd = Rd * Rm
   wire        dp5_isn_bic  = op_q[9:6] == 4'b1110;  // Rd = Rd & ~Rm
   wire        dp5_isn_mvn  = op_q[9:6] == 4'b1111;  // Rd = ~Rm

   // --------
   // The processor supports both a single-cycle and a 32-cycle iterative
   // multiplier implementation. The single-cycle multiplier operates like any
   // other single-cycle arithmetic operation, while the iterative version
   // utilizes the ST_MUL state for execution. Determine whether we are
   // executing a multiplier, and if so, whether it is single-cycle or
   // iterative.

   wire        dp5_mul_small, dp5_mul_fast;

   generate
      if(CBAW != 0) begin : gen_smul_0a

         assign dp5_mul_small = cfg_smul & dp5_isn_mul;
         assign dp5_mul_fast  = ~cfg_smul & dp5_isn_mul;

      end else if(SMUL != 0) begin : gen_smul_0b

         assign dp5_mul_small = dp5_isn_mul;
         assign dp5_mul_fast  = 1'b0;

      end else begin : gen_smul_0c

         assign dp5_mul_small = 1'b0;
         assign dp5_mul_fast  = dp5_isn_mul;

      end
   endgenerate

   // --------

   wire        dp5_add_like = ( dp5_isn_adc | dp5_isn_cmn | dp5_isn_cmp2 |
                                dp5_isn_neg | dp5_isn_sbc );

   wire        dp5_shift_op = ( dp5_isn_asr2 | dp5_isn_lsl2 | dp5_isn_lsr2 |
                                dp5_isn_ror );

   // --------

   wire        dp5_alu_res_sel_add   = dp5_add_like;

   wire        dp5_alu_res_sel_and   = ( dp5_isn_and | dp5_isn_bic |
                                         dp5_isn_tst | dp5_isn_orr );

   wire        dp5_alu_res_sel_eor   = dp5_isn_eor | dp5_isn_orr | dp5_isn_mvn;
   wire        dp5_apsr_en           = ~dp5_mul_small;
   wire        dp5_apsr_sel_add      = dp5_add_like;
   wire        dp5_apsr_sel_bit      = ~dp5_shift_op & ~dp5_add_like;
   wire        dp5_apsr_sel_rot      = dp5_shift_op;
   wire        dp5_aux_en            = dp5_mul_small;
   wire        dp5_aux_sel_mul       = cfg_smul;
   wire        dp5_c_gt_32_sel_nf    = dp5_isn_asr2;
   wire        dp5_c_gt_32_sel_31    = dp5_isn_ror;
   wire        dp5_c_le_32_sel_00    = dp5_isn_lsl2;
   wire        dp5_c_le_32_sel_31    = ~dp5_isn_lsl2;
   wire        dp5_fetch_stall       = dp5_mul_small;
   wire        dp5_iaex_hold         = dp5_mul_small;
   wire        dp5_list_en           = dp5_mul_small;
   wire        dp5_list_sel_irq      = cfg_smul;
   wire        dp5_mtx_ctl_sel_rot   = dp5_shift_op;
   wire        dp5_mtx_in_sel_rot    = dp5_shift_op;
   wire        dp5_mul_en            = dp5_mul_fast;
   wire        dp5_offset_en         = dp5_mul_small;
   wire        dp5_opa_nsel_ra       = dp5_isn_neg | dp5_isn_mvn;

   wire        dp5_opb_inv           = ( dp5_isn_bic | dp5_isn_cmp2 |
                                         dp5_isn_mvn | dp5_isn_neg |
                                         dp5_isn_sbc);

   wire        dp5_opb_sel_rb        = 1'b1;
   wire        dp5_opc_sel_apsr      = dp5_isn_adc | dp5_isn_sbc;
   wire        dp5_opc_sel_one       = dp5_isn_cmp2 | dp5_isn_neg;
   wire        dp5_ra_addr_hold      = dp5_mul_small;
   wire        dp5_rb_addr_hold      = dp5_mul_small;
   wire        dp5_ror_amt_sel_left  = dp5_isn_lsl2;
   wire        dp5_ror_amt_sel_right = ~dp5_isn_lsl2;
   wire        dp5_ror_force_msk     = dp5_isn_ror;
   wire        dp5_rot_amt_sel_rb    = 1'b1;
   wire        dp5_rot_sign_sel_ra31 = dp5_isn_asr2;
   wire        dp5_shf_left          = dp5_isn_lsl2;
   wire        dp5_shf_ror           = dp5_isn_ror;
   wire        dp5_state_en_std      = dp5_mul_small;
   wire        dp5_state_sel_mul     = cfg_smul;
   wire        dp5_wr_data_sel_alu   = ~dp5_shift_op;
   wire        dp5_wr_data_sel_spu   = dp5_shift_op;

   wire        dp5_wr_en_std         = ( ~dp5_isn_cmn & ~dp5_isn_cmp2 &
                                         ~dp5_mul_small & ~dp5_isn_tst );

   // -------------------------------------------------------------------------
   // 16-bit data-processing format 6 and 7 decoder: ADD5 ADD6 ADD7 and SUB4
   // -------------------------------------------------------------------------

   wire        pre_dp6 = op_q[15:12] == 4'b1010;
   wire        pre_dp7 = op_q[15:8] == 8'b10110000;
   wire        fmt_dp6 = pre_dp6 | pre_dp7;

   wire        dp6_isn_add5 = op_q[11] == 1'b0;  // Rd = PC + (imm8 << 2)
   // Note:    dp6_isn_add6 = op_q[11] == 1'b1;  // Rd = SP + (imm8 << 2)
   // Note:    dp7_isn_add7 = op_q[7] == 1'b0;   // SP = SP + (imm7 << 2)
   wire        dp7_isn_sub4 = op_q[7] == 1'b1;   // SP = SP - (imm7 << 2)

   // --------

   wire        dp6_not_dp7 = ~op_q[12];
   wire        dp6_pc_op   = dp6_not_dp7 & dp6_isn_add5;
   wire        dp7_sub_op  = ~dp6_not_dp7 & dp7_isn_sub4;

   // --------

   wire        dp6_alu_res_sel_add = 1'b1;
   wire        dp6_opa_mask_pc     = 1'b1;
   wire        dp6_opa_nsel_ra     = dp6_pc_op;
   wire        dp6_opa_sel_pc      = dp6_pc_op;
   wire        dp6_opb_inv         = dp7_sub_op;
   wire        dp6_opb_sel_imm7_2  = ~dp6_not_dp7;
   wire        dp6_opb_sel_imm8_2  = dp6_not_dp7;
   wire        dp6_opc_sel_one     = dp7_sub_op;
   wire        dp6_wr_addr_sel_108 = dp6_not_dp7;
   wire        dp6_wr_data_sel_alu = 1'b1;
   wire        dp6_wr_en_std       = 1'b1;

   // -------------------------------------------------------------------------
   // 16-bit data-processing format 8 decoder: ADD4 CMP3 and CPY
   // -------------------------------------------------------------------------

   wire        fmt_dp8 = {op_q[15:10],&op_q[9:8]} == 7'b010001_0;

   // Note:    dp8_isn_add4 = op_q[9:8] == 2'b00;  // Rd = Rd + Rm
   wire        dp8_isn_cmp3 = op_q[9:8] == 2'b01;  // Rd - Rm
   wire        dp8_isn_cpy  = op_q[9:8] == 2'b10;  // Rd = Rm

   // --------

   wire        dp8_branch = ~dp8_isn_cmp3 & ra_hi_pc;

   // --------

   wire        dp8_alu_res_sel_add = 1'b1;
   wire        dp8_apsr_en         = dp8_isn_cmp3;
   wire        dp8_apsr_sel_add    = 1'b1;
   wire        dp8_iaex_nsel_inc   = dp8_branch;
   wire        dp8_iaex_sel_add    = dp8_branch;
   wire        dp8_extend_en       = dp8_branch;
   wire        dp8_extend_nxt      = 1'b0;
   wire        dp8_fe_use_add      = dp8_branch;
   wire        dp8_fetch_force     = dp8_branch;
   wire        dp8_op_hold         = dp8_branch;
   wire        dp8_opa_nsel_ra     = dp8_isn_cpy | ra_hi_pc;
   wire        dp8_opa_sel_pc      = ~dp8_isn_cpy & ra_hi_pc;
   wire        dp8_opb_inv         = dp8_isn_cmp3;
   wire        dp8_opb_sel_pc      = rb_hi_pc;
   wire        dp8_opb_sel_rb      = ~rb_hi_pc;
   wire        dp8_opc_sel_one     = dp8_isn_cmp3;
   wire        dp8_ra_addr_hold    = dp8_branch;
   wire        dp8_rb_addr_hold    = dp8_branch;
   wire        dp8_state_en_std    = dp8_branch;
   wire        dp8_state_sel_pfu   = 1'b1;
   wire        dp8_wr_data_sel_alu = 1'b1;
   wire        dp8_wr_en_std       = ~dp8_isn_cmp3;

   // -------------------------------------------------------------------------
   // 16-bit data-processing format 9 decoder: REV REV16 REVSH SXTB SXTH UXTB
   //                                          and UXTH
   // -------------------------------------------------------------------------

   wire        fmt_dp9 = {op_q[15:12],op_q[10:8]} == 7'b1011_010;
   wire [ 2:0] dp9_op  = {op_q[11],op_q[7:6]};

   wire        dp9_isn_sxth  = dp9_op == 3'b0_00;  // Rd = s(Rn[15:0])
   wire        dp9_isn_sxtb  = dp9_op == 3'b0_01;  // Rd = s(Rn[7:0])
   wire        dp9_isn_uxth  = dp9_op == 3'b0_10;  // Rd = Rn[15:0]
   wire        dp9_isn_uxtb  = dp9_op == 3'b0_11;  // Rd = Rn[7:0]
   wire        dp9_isn_rev   = dp9_op == 3'b1_00;  // Rd = Rn[7:0]..Rn[31:28]
   wire        dp9_isn_rev16 = dp9_op == 3'b1_01;  // Rd = Rn[27:16]..Rn[15:8]
   wire        dp9_isn_undef = dp9_op == 3'b1_10;  // UNDEFINED
   wire        dp9_isn_revsh = dp9_op == 3'b1_11;  // Rd = s(Rn[7:0],Rn[15:0])

   // --------

   wire        dp9_extend = ( dp9_isn_sxtb | dp9_isn_sxth | dp9_isn_uxtb |
                              dp9_isn_uxth );

   // --------

   wire        dp9_mtx_in_sel_rot  = 1'b1;
   wire        dp9_perm_mtx_revb   = dp9_isn_rev;
   wire        dp9_perm_mtx_revh   = dp9_isn_revsh | dp9_isn_rev16;
   wire        dp9_perm_mtx_sgn_32 = dp9_extend | dp9_isn_revsh;
   wire        dp9_perm_mtx_sgn_1  = dp9_isn_sxtb | dp9_isn_uxtb;
   wire        dp9_perm_mtx_xt     = dp9_extend;
   wire        dp9_perm_sgn_sel_15 = dp9_isn_sxth;
   wire        dp9_perm_sgn_sel_7  = dp9_isn_sxtb | dp9_isn_revsh;
   wire        dp9_wr_addr_sel_z20 = 1'b1;
   wire        dp9_wr_data_sel_spu = 1'b1;
   wire        dp9_wr_en_std       = ~dp9_isn_undef;

   // -------------------------------------------------------------------------
   // 16-bit system instruction format 1 decoder: SVC
   // -------------------------------------------------------------------------

   // The SVC instruction executed outside of NMI or Hardfault will result in
   // an exception being generated; a fault will be generated it the current
   // execution priority is equal-to or greater-than that of SVCall, else an
   // SVCall will be generated. If executed in NMI or Hardfault handlers, a
   // Lockup condition will be generated, i.e. PC will be set to ~0.

   wire        fmt_sy1 = op_q[15:8] == 8'b11011111;

   // Note:    sy1_isn_svc = 1'b1;  // SVC #supervisor_call

   // --------

   wire        sy1_hardfault = svc_is_undef & ~n_or_h_active;
   wire        sy1_lockup    = n_or_h_active;

   // --------

   wire        sy1_fetch_stall   = 1'b1;
   wire        sy1_hdf_req       = sy1_hardfault;
   wire        sy1_iaex_sel_add  = sy1_lockup;
   wire        sy1_op_hold       = 1'b1;
   wire        sy1_opa_nsel_ra   = 1'b1;
   wire        sy1_opb_inv       = 1'b1;
   wire        sy1_preempt_force = ~sy1_lockup;
   wire        sy1_state_en_std  = 1'b1;
   wire        sy1_state_sel_lck = sy1_lockup;
   wire        sy1_svc_req       = ~svc_is_undef & ~n_or_h_active;

   // -------------------------------------------------------------------------
   // 16-bit system instruction format 2 decoder: BKPT
   // -------------------------------------------------------------------------

   // BKPT instructions are predecoded based on whether debug is currently
   // enabled. If debug is not enabled, the encoding is modified to be an
   // UNDEFINED one, so as to generate a fault. Only BKPT that will result in
   // the processor halting, rather than faulting, are handled here.

   wire        fmt_sy2 = op_q[15:8] == 8'b10111110;

   // Note:    sy2_isn_bkpt = 1'b1;  // BKPT #breakpoint

   // --------

   wire        sy2_bpu_event     = 1'b1;
   wire        sy2_fetch_stall   = 1'b1;
   wire        sy2_iaex_hold     = 1'b1;
   wire        sy2_op_hold       = 1'b1;
   wire        sy2_state_en_std  = 1'b1;
   wire        sy2_state_sel_hlt = 1'b1;
   wire        sy2_atomic_en     = 1'b1;

   // -------------------------------------------------------------------------
   // 16-bit system instruction format 3 decoder: CPS
   // -------------------------------------------------------------------------

   // The only functional variant of CPS in ARMv6-M is that which updates the
   // value of PRIMASK. PRIMASK has the effect of masking all interrupts except
   // NMI and HardFault. In order to make this appear synchronous with respect
   // to interrupts being taken, the next-state value of PRIMASK is forwarded
   // to the NVIC, thus ensuring that an attempt to set PRIMASK will not result
   // in int_ready_q being clear on the next cycle whilst IQ has an interrupt
   // recorded.

   // If preempted, then CPS avoids updating both the PC and PRIMASK, thus
   // ensuring giving the illusion that the CPS was never executed.

   wire        fmt_sy3 = op_q[15:8] == 8'b10110110;

   wire        sy3_isn_cps   = op_q[7:5] == 3'b011;  // CPSID/CPSIE
   // Note:    sy3_isn_undef = op_q[7:5] != 3'b011;  // Undefined, see u16_m

   // --------

   wire        sy3_iaex_hold  = int_ready_q;
   wire        sy3_primask_en = sy3_isn_cps & priv & ~int_ready_q;

   // -------------------------------------------------------------------------
   // 16-bit system instruction format 4 decoder: NOP SEV WFE and WFI
   // -------------------------------------------------------------------------

   // NOP hint space includes SEV, WFE and WFI. In addition to this, on ARMv7-M
   // it includes IT. IT is not supported and instead is treated as UNDEFINED,
   // see u16_m. SEV and NOP execute in a single cycle. WFE and WFI require
   // information from the NVIC which is too timing critical to be acted upon
   // in this cycle, as a result, they always take a minimum of two cycles, the
   // second of which is spend in the WFX state.

   wire        fmt_sy4 = {op_q[15:8],op_q[3:0]} == 12'b10111111_0000;

   // Note:    sy4_isn_nop = op_q[7:4] == 4'b0000;  // NOP
   wire        sy4_isn_sev = op_q[7:4] == 4'b0100;  // SEV send-event
   wire        sy4_isn_wfe = op_q[7:4] == 4'b0010;  // WFE wait-for-event
   wire        sy4_isn_wfi = op_q[7:4] == 4'b0011;  // WFI wait-for-interrupt

   // --------

   wire        sy4_go_wait  = sy4_isn_wfe | sy4_isn_wfi;
   wire        sy4_i_not_e = op_q[4];

   wire        sy4_no_wait  = ( sy4_isn_wfi & nvm_wfi_advance_i |
                                sy4_isn_wfe & nvm_wfe_advance_i );

   // --------

   wire        sy4_fetch_stall      = sy4_go_wait;
   wire        sy4_iaex_hold        = sy4_go_wait & ~int_ready_q;
   wire        sy4_event_set        = sy4_isn_sev;
   wire        sy4_state_en_std     = sy4_go_wait;
   wire        sy4_state_sel_wfx    = 1'b1;
   wire        sy4_offset_en        = 1'b1;
   wire        sy4_offset_nsel_one  = sy4_no_wait;
   wire        sy4_extend_en        = 1'b1;
   wire        sy4_extend_nxt       = sy4_i_not_e;
   wire        sy4_wfe_execute      = sy4_isn_wfe;
   wire        sy4_wfi_execute      = sy4_isn_wfi;
   wire        sy4_wic_load         = sy4_go_wait;

   // -------------------------------------------------------------------------
   // 16-bit system instruction format 5 decoder: 32-bit prefix
   // -------------------------------------------------------------------------

   // Prefix for all supported 32-bit instructions is detected here. The prefix
   // is ambiguous, in that the instruction class cannot be fully identified
   // until we examine the second half of the opcode.

   // The subset of the space encoding MSR or BL is treated specially, as we
   // require a register read for the MSR.

   wire        fmt_sy5 = op_q[15:11] == 5'b11110;

   // --------

   wire        sy5_msr_prefix = op_q[10:5] == 6'b011100;

   // --------

   wire        sy5_extend_en         = 1'b1;
   wire        sy5_extend_nxt        = 1'b0;
   wire        sy5_fetch_stall       = 1'b1;
   wire        sy5_iaex_hold         = 1'b1;
   wire        sy5_iq_use_nxt        = 1'b1;
   wire        sy5_op_hold           = 1'b1;
   wire        sy5_ra_addr_hold      = 1'b1;
   wire        sy5_rb_addr_nsel_pdec = 1'b1;
   wire        sy5_rb_addr_sel_30    = 1'b1;
   wire        sy5_rb_addr_hold      = ~sy5_msr_prefix;
   wire        sy5_state_en_std      = 1'b1;
   wire        sy5_state_sel_t32     = 1'b1;
   wire        sy5_dbg_no_trans      = 1'b1;

   // -------------------------------------------------------------------------
   // 16-bit load-store format 0 (1a) decoder: LDR1 LDRB1 STR1 and STRB1
   // -------------------------------------------------------------------------

   wire        fmt_ls0 = op_q[15:13] == 3'b011;

   wire        ls0_isn_str1  = op_q[12:11] == 2'b00;  // Rt -> [Rn,#imm5<<2]
   // Note:    ls0_isn_ldr1  = op_q[12:11] == 2'b01;  // Rt <- [Rn,#imm5<<2]
   wire        ls0_isn_strb1 = op_q[12:11] == 2'b10;  // Rt -> [Rn,#imm5]
   wire        ls0_isn_ldrb1 = op_q[12:11] == 2'b11;  // Rt <- [Rn,#imm5]

   // --------

   wire        ls0_byte  = ls0_isn_strb1 | ls0_isn_ldrb1;
   wire        ls0_word  = ~ls0_byte;
   wire        ls0_store = ls0_isn_str1 | ls0_isn_strb1;

   // --------

   wire        ls0_align_half        = ls0_word;
   wire        ls0_align_word        = ls0_word;
   wire        ls0_base_en           = 1'b1;
   wire        ls0_base_sel_byte     = ls0_byte;
   wire        ls0_base_sel_word     = ls0_word;
   wire        ls0_extend_en         = ~ls0_store;
   wire        ls0_iaex_en_io        = cfg_iop;
   wire        ls0_iaex_hold         = 1'b1;
   wire        ls0_ls_fwd_io         = cfg_iop;
   wire        ls0_ls_trans          = 1'b1;
   wire        ls0_ls_write          = ls0_store;
   wire        ls0_mtx_in_sel_bus    = cfg_iop;
   wire        ls0_opb_sel_imm5_0    = ls0_byte;
   wire        ls0_opb_sel_imm5_2    = ls0_word;
   wire        ls0_ra_addr_hold      = ~io_match;
   wire        ls0_rb_addr_sel_z20   = ~io_match;
   wire        ls0_rb_addr_nsel_pdec = ~io_match;
   wire        ls0_state_sel_str     = ls0_store;
   wire        ls0_state_sel_ldr     = ~ls0_store;
   wire        ls0_state_en_std      = ~io_match;
   wire        ls0_wr_addr_sel_z20   = cfg_iop;
   wire        ls0_wr_data_sel_spu   = cfg_iop;
   wire        ls0_wr_en_io          = cfg_iop & ~ls0_store;

   // -------------------------------------------------------------------------
   // 16-bit load-store format 1 (1b) decoder: LDRH1 STRH1
   // -------------------------------------------------------------------------

   wire        fmt_ls1 = op_q[15:12] == 4'b1000;

   wire        ls1_isn_strh1 = op_q[11] == 1'b0;  // Rt -> [Rn,#imm5<<1]
   wire        ls1_isn_ldrh1 = op_q[11] == 1'b1;  // Rt <- [Rn,#imm5<<1]

   // --------

   wire        ls1_align_half        = 1'b1;
   wire        ls1_base_en           = 1'b1;
   wire        ls1_base_sel_half     = 1'b1;
   wire        ls1_iaex_en_io        = cfg_iop;
   wire        ls1_iaex_hold         = 1'b1;
   wire        ls1_extend_en         = ls1_isn_ldrh1;
   wire        ls1_ls_fwd_io         = cfg_iop;
   wire        ls1_ls_trans          = 1'b1;
   wire        ls1_ls_write          = ls1_isn_strh1;
   wire        ls1_mtx_in_sel_bus    = cfg_iop;
   wire        ls1_opb_sel_imm5_1    = 1'b1;
   wire        ls1_ra_addr_hold      = ~io_match;
   wire        ls1_rb_addr_sel_z20   = ~io_match;
   wire        ls1_rb_addr_nsel_pdec = ~io_match;
   wire        ls1_state_en_std      = ~io_match;
   wire        ls1_state_sel_str     = ls1_isn_strh1;
   wire        ls1_state_sel_ldr     = ls1_isn_ldrh1;
   wire        ls1_wr_addr_sel_z20   = cfg_iop;
   wire        ls1_wr_data_sel_spu   = cfg_iop;
   wire        ls1_wr_en_io          = cfg_iop & ls1_isn_ldrh1;

   // -------------------------------------------------------------------------
   // 16-bit load-store format 2 decoder: LDR2 LDRB2 LDRH2 LDRSB LDRSH STR2
   //                                     STRB2 and STRH2
   // -------------------------------------------------------------------------

   wire        fmt_ls2 = op_q[15:12] == 4'b0101;

   wire        ls2_isn_str2  = op_q[11:9] == 3'b000;  // Rt -> [Rn+Rm]
   wire        ls2_isn_strh2 = op_q[11:9] == 3'b001;  // Rt -> [Rn+Rm]
   wire        ls2_isn_strb2 = op_q[11:9] == 3'b010;  // Rt -> [Rn+Rm]
   wire        ls2_isn_ldrsb = op_q[11:9] == 3'b011;  // Rt <- sext([Rn+Rm])
   wire        ls2_isn_ldr2  = op_q[11:9] == 3'b100;  // Rt <- [Rn+Rm]
   wire        ls2_isn_ldrh2 = op_q[11:9] == 3'b101;  // Rt <- [Rn+Rm]
   wire        ls2_isn_ldrb2 = op_q[11:9] == 3'b110;  // Rt <- [Rn+Rm]
   wire        ls2_isn_ldrsh = op_q[11:9] == 3'b111;  // Rt <- sext([Rn+Rm])

   // --------

   wire        ls2_byte  = ls2_isn_strb2 | ls2_isn_ldrsb | ls2_isn_ldrb2;
   wire        ls2_half  = ls2_isn_strh2 | ls2_isn_ldrh2 | ls2_isn_ldrsh;
   wire        ls2_word  = ls2_isn_str2 | ls2_isn_ldr2;
   wire        ls2_store = ls2_isn_str2 | ls2_isn_strh2 | ls2_isn_strb2;

   // --------

   wire        ls2_align_half        = ~ls2_byte;
   wire        ls2_align_word        = ls2_word;
   wire        ls2_base_en           = 1'b1;
   wire        ls2_base_sel_byte     = ls2_byte;
   wire        ls2_base_sel_half     = ls2_half;
   wire        ls2_base_sel_word     = ls2_word;
   wire        ls2_extend_en         = 1'b1;
   wire        ls2_extend_nxt        = ls2_isn_ldrsb | ls2_isn_ldrsh;
   wire        ls2_iaex_en_io        = cfg_iop;
   wire        ls2_iaex_hold         = 1'b1;
   wire        ls2_ls_fwd_io         = cfg_iop;
   wire        ls2_ls_trans          = 1'b1;
   wire        ls2_ls_write          = ls2_store;
   wire        ls2_mtx_in_sel_bus    = cfg_iop;
   wire        ls2_opb_sel_rb        = 1'b1;
   wire        ls2_ra_addr_hold      = ~io_match;
   wire        ls2_rb_addr_sel_z20   = ~io_match;
   wire        ls2_rb_addr_nsel_pdec = ~io_match;
   wire        ls2_state_en_std      = ~io_match;
   wire        ls2_state_sel_str     = ls2_store;
   wire        ls2_state_sel_ldr     = ~ls2_store;
   wire        ls2_wr_addr_sel_z20   = cfg_iop;
   wire        ls2_wr_data_sel_spu   = cfg_iop;
   wire        ls2_wr_en_io          = cfg_iop & ~ls2_store;

   // -------------------------------------------------------------------------
   // 16-bit load-store format 3 decoder: LDR3
   // -------------------------------------------------------------------------

   wire        fmt_ls3 = op_q[15:11] == 5'b01001;

   // Note:    ls3_isn_ldr3 = 1'b1;  // Rt <- [PC,#imm]

   // --------

   wire        ls3_base_en           = 1'b1;
   wire        ls3_base_sel_word     = 1'b1;
   wire        ls3_iaex_en_io        = cfg_iop;
   wire        ls3_iaex_hold         = 1'b1;
   wire        ls3_ls_fwd_io         = cfg_iop;
   wire        ls3_ls_trans          = 1'b1;
   wire        ls3_mtx_in_sel_bus    = cfg_iop;
   wire        ls3_opa_mask_pc       = 1'b1;
   wire        ls3_opa_nsel_ra       = 1'b1;
   wire        ls3_opa_sel_pc        = 1'b1;
   wire        ls3_opb_sel_imm8_2    = 1'b1;
   wire        ls3_pc_rel            = 1'b1;
   wire        ls3_ra_addr_hold      = ~io_match;
   wire        ls3_rb_addr_sel_108   = ~io_match;
   wire        ls3_rb_addr_nsel_pdec = ~io_match;
   wire        ls3_state_sel_ldr     = 1'b1;
   wire        ls3_state_en_std      = ~io_match;
   wire        ls3_wr_addr_sel_108   = cfg_iop;
   wire        ls3_wr_data_sel_spu   = cfg_iop;
   wire        ls3_wr_en_io          = cfg_iop;

   // -------------------------------------------------------------------------
   // 16-bit load-store format 4 decoder: LDR4 and STR3
   // -------------------------------------------------------------------------

   wire        fmt_ls4 = op_q[15:12] == 4'b1001;

   wire        ls4_isn_str3 = op_q[11] == 1'b0;  // Rt -> [SP + #imm]
   wire        ls4_isn_ldr4 = op_q[11] == 1'b1;  // Rt <- [SP + #imm]

   // --------

   wire        ls4_base_en           = 1'b1;
   wire        ls4_base_sel_word     = 1'b1;
   wire        ls4_iaex_en_io        = cfg_iop;
   wire        ls4_iaex_hold         = 1'b1;
   wire        ls4_ls_fwd_io         = cfg_iop;
   wire        ls4_ls_trans          = 1'b1;
   wire        ls4_ls_write          = ls4_isn_str3;
   wire        ls4_mtx_in_sel_bus    = cfg_iop;
   wire        ls4_opb_sel_imm8_2    = 1'b1;
   wire        ls4_ra_addr_hold      = ~io_match;
   wire        ls4_rb_addr_sel_108   = ~io_match;
   wire        ls4_rb_addr_nsel_pdec = ~io_match;
   wire        ls4_state_sel_str     = ls4_isn_str3;
   wire        ls4_state_sel_ldr     = ls4_isn_ldr4;
   wire        ls4_state_en_std      = ~io_match;
   wire        ls4_wr_addr_sel_108   = cfg_iop;
   wire        ls4_wr_data_sel_spu   = cfg_iop;
   wire        ls4_wr_en_io          = cfg_iop & ls4_isn_ldr4;

   // -------------------------------------------------------------------------
   // 16-bit load-store-multiple format 1 decoder: LDM and STM
   // -------------------------------------------------------------------------

   wire        fmt_lm1 = op_q[15:12] == 4'b1100;

   wire        lm1_isn_stm = op_q[11] == 1'b0;  // {...} -> [Rn++]
   wire        lm1_isn_ldm = op_q[11] == 1'b1;  // {...} <- [Rn++]

   // --------

   wire        lm1_align_half        = 1'b1;
   wire        lm1_align_word        = 1'b1;
   wire        lm1_alu_res_sel_add   = 1'b1;
   wire        lm1_aux_en            = 1'b1;
   wire        lm1_aux_sel_ra        = 1'b1;
   wire        lm1_iaex_hold         = 1'b1;
   wire        lm1_list_en           = 1'b1;
   wire        lm1_list_sel_op       = 1'b1;
   wire        lm1_ls_multi          = 1'b1;
   wire        lm1_ls_trans          = 1'b1;
   wire        lm1_ls_use_ra         = lm1_isn_ldm;
   wire        lm1_ls_write          = lm1_isn_stm;
   wire        lm1_offset_en         = 1'b1;
   wire        lm1_opb_sel_list      = lm1_isn_ldm;
   wire        lm1_ra_addr_hold      = 1'b1;
   wire        lm1_rb_addr_nsel_pdec = 1'b1;
   wire        lm1_rb_addr_sel_list  = 1'b1;
   wire        lm1_base_en           = 1'b1;
   wire        lm1_base_sel_word     = 1'b1;
   wire        lm1_state_en_std      = 1'b1;
   wire        lm1_state_sel_ldm     = lm1_isn_ldm;
   wire        lm1_state_sel_stm     = lm1_isn_stm;
   wire        lm1_wr_data_sel_alu   = 1'b1;
   wire        lm1_wr_addr_sel_108   = 1'b1;
   wire        lm1_wr_en_std         = lm1_isn_ldm & ~int_ready_q;

   // -------------------------------------------------------------------------
   // 16-bit load-store-multiple format 2 decoder: PUSH and POP
   // -------------------------------------------------------------------------

   wire        fmt_lm2 = {op_q[15:12],op_q[10:9]} == 6'b1011_10;

   wire        lm2_isn_push = op_q[11] == 1'b0;  // {...} -> [--SP]
   wire        lm2_isn_pop  = op_q[11] == 1'b1;  // {...} -> [SP++]

   // --------

   wire        lm2_pc_bit = op_q[8];

   // --------

   wire        lm2_alu_res_sel_add   = 1'b1;
   wire        lm2_aux_en            = 1'b1;
   wire        lm2_aux_sel_add       = lm2_isn_push;
   wire        lm2_aux_sel_ra        = lm2_isn_pop;
   wire        lm2_base_en           = 1'b1;
   wire        lm2_base_sel_word     = 1'b1;
   wire        lm2_iaex_hold         = 1'b1;
   wire        lm2_list_en           = 1'b1;
   wire        lm2_list_sel_op       = 1'b1;
   wire        lm2_ls_multi          = 1'b1;
   wire        lm2_ls_trans          = 1'b1;
   wire        lm2_ls_use_ra         = lm2_isn_pop;
   wire        lm2_ls_write          = lm2_isn_push;
   wire        lm2_offset_en         = 1'b1;
   wire        lm2_op_hold           = lm2_isn_pop & lm2_pc_bit;
   wire        lm2_opb_inv           = lm2_isn_push;
   wire        lm2_opb_sel_list      = 1'b1;
   wire        lm2_opc_sel_one       = lm2_isn_push;
   wire        lm2_ra_addr_hold      = 1'b1;
   wire        lm2_rb_addr_nsel_pdec = 1'b1;
   wire        lm2_rb_addr_sel_list  = 1'b1;
   wire        lm2_state_en_std      = 1'b1;
   wire        lm2_state_sel_ldm     = lm2_isn_pop;
   wire        lm2_state_sel_stm     = lm2_isn_push;
   wire        lm2_wr_data_sel_alu   = 1'b1;
   wire        lm2_wr_en_std         = lm2_isn_pop & ~int_ready_q;

   // -------------------------------------------------------------------------
   // 16-bit undefined instruction decoder
   // -------------------------------------------------------------------------

   // Set 0 contains specific UNDEFINED from the Miscellaneous and Hint
   // instruction space. Set 1 contains permanently UNDEFINED (UDF). Set 2
   // contains all UNDEFINED 32-bit Thumb encodings that can be detected from
   // just their first 16-bits. The third covers BX/BLX PC, which is
   // UNPREDICTABLE, but implemented as UNDEFINED to aid validation.

   wire        u16_m = ( (op_q[11:8] == 4'b0001) |
                         (op_q[11:8] == 4'b0011) |
                         ((op_q[11:9] == 3'b011) & (op_q[8:5] != 4'b0011)) |
                         (op_q[11:9] == 3'b100) |
                         (op_q[11:6] == 6'b101010) |
                         (op_q[11:8] == 4'b1011) |
                         ({op_q[11:8], |op_q[3:0]} == 5'b1111_1) );

   wire        u16_0 = (op_q[15:12] == 4'b1011) & u16_m;
   wire        u16_1 = op_q[15:8] == 8'b1101_1110;
   wire        u16_2 = {op_q[15:13], op_q[11]} == 4'b111_1;
   wire        u16_3 = pre_br3 & rb_hi_pc;

   // --------
   // Combine all three sets into a single UNDEFINED instruction signal.

   wire        fmt_u16 = u16_0 | u16_1 | u16_2 | u16_3;

   // --------
   // UNDEFINED instructions generate Hardfaults unless we are already in the
   // Hardfault or NMI handler, at which point they must Lockup.

   wire        u16_hardfault = ~n_or_h_active;

   // --------

   wire        u16_fetch_stall   = 1'b1;
   wire        u16_hdf_req       = u16_hardfault;
   wire        u16_iaex_hold     = u16_hardfault;
   wire        u16_iaex_sel_add  = 1'b1;
   wire        u16_op_hold       = 1'b1;
   wire        u16_opa_nsel_ra   = 1'b1;
   wire        u16_opb_inv       = 1'b1;
   wire        u16_preempt_force = u16_hardfault;
   wire        u16_state_en_std  = 1'b1;
   wire        u16_state_sel_lck = 1'b1;

   // -------------------------------------------------------------------------
   // Execute state consolidation
   // -------------------------------------------------------------------------

   // Combine all of the individual instruction decode based control signals
   // into a single speculative set of approximately one-hundred control terms,
   // to be used if the core is currently in execute state and not being
   // interrupted.

   wire        exe_aux_sel_mul0, exe_list_sel_irq, exe_state_sel_mul;
   wire        fmt_dp5_aux_en, fmt_dp5_fetch_stall, fmt_dp5_iaex_hold;
   wire        fmt_dp5_list_en, fmt_dp5_offset_en, fmt_dp5_state_en_std;
   wire        fmt_dp5_ra_addr_hold, fmt_dp5_rb_addr_hold, exe_mul_en;

   generate
      if((CBAW != 0) || (SMUL != 0)) begin : gen_smul_1a

         wire is_dp5 = cfg_smul & fmt_dp5;

         assign exe_aux_sel_mul0     = is_dp5 & dp5_aux_sel_mul;
         assign exe_list_sel_irq     = is_dp5 & dp5_list_sel_irq;
         assign exe_state_sel_mul    = is_dp5 & dp5_state_sel_mul;
         assign fmt_dp5_aux_en       = is_dp5 & dp5_aux_en;
         assign fmt_dp5_fetch_stall  = is_dp5 & dp5_fetch_stall;
         assign fmt_dp5_iaex_hold    = is_dp5 & dp5_iaex_hold;
         assign fmt_dp5_list_en      = is_dp5 & dp5_list_en;
         assign fmt_dp5_offset_en    = is_dp5 & dp5_offset_en;
         assign fmt_dp5_ra_addr_hold = is_dp5 & dp5_ra_addr_hold;
         assign fmt_dp5_rb_addr_hold = is_dp5 & dp5_rb_addr_hold;
         assign fmt_dp5_state_en_std = is_dp5 & dp5_state_en_std;

         assign exe_mul_en           = ~cfg_smul & fmt_dp5 & dp5_mul_en;

      end else begin : gen_smul_1b

         wire [10:0] unused = { dp5_aux_en, dp5_aux_sel_mul, dp5_fetch_stall,
                                dp5_iaex_hold, dp5_list_en, dp5_list_sel_irq,
                                dp5_offset_en, dp5_ra_addr_hold,
                                dp5_rb_addr_hold, dp5_state_en_std,
                                dp5_state_sel_mul };

         assign { exe_aux_sel_mul0, exe_list_sel_irq, exe_state_sel_mul,
                  fmt_dp5_aux_en, fmt_dp5_fetch_stall, fmt_dp5_iaex_hold,
                  fmt_dp5_list_en, fmt_dp5_offset_en, fmt_dp5_state_en_std,
                  fmt_dp5_ra_addr_hold, fmt_dp5_rb_addr_hold } = 11'b0;

         assign exe_mul_en = fmt_dp5 & dp5_mul_en;

      end
   endgenerate

   // --------

   wire        exe_iaex_en_io, exe_ls_fwd_io, exe_mtx_in_sel_bus, exe_wr_en_io;
   wire        iop_wr_addr_sel_108, iop_wr_addr_sel_z20, iop_wr_data_sel_spu;

   generate
      if((CBAW != 0) || (IOP != 0)) begin : gen_iop_2a

         assign exe_iaex_en_io       = ( fmt_ls0 & ls0_iaex_en_io |
                                         fmt_ls1 & ls1_iaex_en_io |
                                         fmt_ls2 & ls2_iaex_en_io |
                                         fmt_ls3 & ls3_iaex_en_io |
                                         fmt_ls4 & ls4_iaex_en_io );

         assign exe_ls_fwd_io        = ( fmt_ls0 & ls0_ls_fwd_io |
                                         fmt_ls1 & ls1_ls_fwd_io |
                                         fmt_ls2 & ls2_ls_fwd_io |
                                         fmt_ls3 & ls3_ls_fwd_io |
                                         fmt_ls4 & ls4_ls_fwd_io );

         assign exe_mtx_in_sel_bus   = ( fmt_ls0 & ls0_mtx_in_sel_bus |
                                         fmt_ls1 & ls1_mtx_in_sel_bus |
                                         fmt_ls2 & ls2_mtx_in_sel_bus |
                                         fmt_ls3 & ls3_mtx_in_sel_bus |
                                         fmt_ls4 & ls4_mtx_in_sel_bus );

         assign exe_wr_en_io         = ( fmt_ls0 & ls0_wr_en_io |
                                         fmt_ls1 & ls1_wr_en_io |
                                         fmt_ls2 & ls2_wr_en_io |
                                         fmt_ls3 & ls3_wr_en_io |
                                         fmt_ls4 & ls4_wr_en_io );

         assign iop_wr_addr_sel_108  = ( fmt_ls3 & ls3_wr_addr_sel_108 |
                                         fmt_ls4 & ls4_wr_addr_sel_108 );

         assign iop_wr_data_sel_spu  = ( fmt_ls0 & ls0_wr_data_sel_spu |
                                         fmt_ls1 & ls1_wr_data_sel_spu |
                                         fmt_ls2 & ls2_wr_data_sel_spu |
                                         fmt_ls3 & ls3_wr_data_sel_spu |
                                         fmt_ls4 & ls4_wr_data_sel_spu );

         assign iop_wr_addr_sel_z20  = ( fmt_ls0 & ls0_wr_addr_sel_z20 |
                                         fmt_ls1 & ls1_wr_addr_sel_z20 |
                                         fmt_ls2 & ls2_wr_addr_sel_z20 );

      end else begin : gen_iop_2b

         wire [29:0] unused = { ls0_iaex_en_io, ls1_iaex_en_io, ls2_iaex_en_io,
                                ls3_iaex_en_io, ls4_iaex_en_io, ls0_ls_fwd_io,
                                ls1_ls_fwd_io, ls2_ls_fwd_io, ls3_ls_fwd_io,
                                ls4_ls_fwd_io, ls0_mtx_in_sel_bus,
                                ls1_mtx_in_sel_bus, ls2_mtx_in_sel_bus,
                                ls3_mtx_in_sel_bus, ls4_mtx_in_sel_bus,
                                ls3_wr_addr_sel_108, ls4_wr_addr_sel_108,
                                ls0_wr_data_sel_spu, ls1_wr_data_sel_spu,
                                ls2_wr_data_sel_spu, ls3_wr_data_sel_spu,
                                ls4_wr_data_sel_spu, ls0_wr_addr_sel_z20,
                                ls1_wr_addr_sel_z20, ls2_wr_addr_sel_z20,
                                ls0_wr_en_io, ls1_wr_en_io, ls2_wr_en_io,
                                ls3_wr_en_io, ls4_wr_en_io };

         assign { exe_iaex_en_io, exe_ls_fwd_io, exe_mtx_in_sel_bus,
                  exe_wr_en_io, iop_wr_addr_sel_108, iop_wr_data_sel_spu,
                  iop_wr_addr_sel_z20 } = 7'b0;

      end
   endgenerate

   wire        exe_mtx_sel_use_load = exe_ls_fwd_io;

   // --------

   wire        exe_dbg_no_trans;

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_1a

         assign exe_dbg_no_trans = cfg_dbg & fmt_sy5 & sy5_dbg_no_trans;

      end else begin : gen_dbg_1b

         wire unused = sy5_dbg_no_trans;
         assign exe_dbg_no_trans = 1'b0;

      end
   endgenerate

   // --------

   wire        exe_align_half        = ( fmt_lm1 & lm1_align_half |
                                         fmt_ls0 & ls0_align_half |
                                         fmt_ls1 & ls1_align_half |
                                         fmt_ls2 & ls2_align_half );

   wire        exe_align_word        = ( fmt_lm1 & lm1_align_word |
                                         fmt_ls0 & ls0_align_word |
                                         fmt_ls2 & ls2_align_word );

   wire        exe_alu_res_sel_add   = ( fmt_br3 & br3_alu_res_sel_add |
                                         fmt_dp1 & dp1_alu_res_sel_add |
                                         fmt_dp2 & dp2_alu_res_sel_add |
                                         fmt_dp3 & dp3_alu_res_sel_add |
                                         fmt_dp5 & dp5_alu_res_sel_add |
                                         fmt_dp6 & dp6_alu_res_sel_add |
                                         fmt_dp8 & dp8_alu_res_sel_add |
                                         fmt_lm1 & lm1_alu_res_sel_add |
                                         fmt_lm2 & lm2_alu_res_sel_add );

   wire        exe_alu_res_sel_and   = ( fmt_dp5 & dp5_alu_res_sel_and );
   wire        exe_alu_res_sel_eor   = ( fmt_dp5 & dp5_alu_res_sel_eor );

   wire        exe_apsr_en           = ( fmt_dp1 & dp1_apsr_en |
                                         fmt_dp2 & dp2_apsr_en |
                                         fmt_dp3 & dp3_apsr_en |
                                         fmt_dp4 & dp4_apsr_en |
                                         fmt_dp5 & dp5_apsr_en |
                                         fmt_dp8 & dp8_apsr_en );

   wire        exe_apsr_sel_add      = ( fmt_dp1 & dp1_apsr_sel_add |
                                         fmt_dp2 & dp2_apsr_sel_add |
                                         fmt_dp3 & dp3_apsr_sel_add |
                                         fmt_dp5 & dp5_apsr_sel_add |
                                         fmt_dp8 & dp8_apsr_sel_add );

   wire        exe_apsr_sel_bit      = ( fmt_dp3 & dp3_apsr_sel_bit |
                                         fmt_dp5 & dp5_apsr_sel_bit );

   wire        exe_apsr_sel_rot      = ( fmt_dp4 & dp4_apsr_sel_rot |
                                         fmt_dp5 & dp5_apsr_sel_rot );

   wire        exe_atomic_en         = ( fmt_br3 & br3_atomic_en |
                                         fmt_sy2 & sy2_atomic_en );

   wire        exe_atomic_nxt        = 1'b1;

   wire        exe_aux_en            = ( fmt_dp5_aux_en |
                                         fmt_lm1 & lm1_aux_en |
                                         fmt_lm2 & lm2_aux_en );

   wire        exe_aux_sel_add       = ( fmt_lm2 & lm2_aux_sel_add );

   wire        exe_aux_sel_ra        = ( fmt_lm1 & lm1_aux_sel_ra |
                                         fmt_lm2 & lm2_aux_sel_ra );

   wire        exe_base_en           = ( fmt_lm1 & lm1_base_en |
                                         fmt_lm2 & lm2_base_en |
                                         fmt_ls0 & ls0_base_en |
                                         fmt_ls1 & ls1_base_en |
                                         fmt_ls2 & ls2_base_en |
                                         fmt_ls3 & ls3_base_en |
                                         fmt_ls4 & ls4_base_en );

   wire        exe_base_sel_byte     = ( fmt_ls0 & ls0_base_sel_byte |
                                         fmt_ls2 & ls2_base_sel_byte );

   wire        exe_base_sel_half     = ( fmt_ls1 & ls1_base_sel_half |
                                         fmt_ls2 & ls2_base_sel_half );

   wire        exe_base_sel_word     = ( fmt_lm1 & lm1_base_sel_word |
                                         fmt_lm2 & lm2_base_sel_word |
                                         fmt_ls0 & ls0_base_sel_word |
                                         fmt_ls2 & ls2_base_sel_word |
                                         fmt_ls3 & ls3_base_sel_word |
                                         fmt_ls4 & ls4_base_sel_word );

   wire        exe_bpu_event         = ( fmt_sy2 & sy2_bpu_event);

   wire        exe_c_gt_32_sel_nf    = ( fmt_dp4 & dp4_c_gt_32_sel_nf |
                                         fmt_dp5 & dp5_c_gt_32_sel_nf );

   wire        exe_c_gt_32_sel_31    = ( fmt_dp5 & dp5_c_gt_32_sel_31 );

   wire        exe_c_le_32_sel_00    = ( fmt_dp4 & dp4_c_le_32_sel_00 |
                                         fmt_dp5 & dp5_c_le_32_sel_00 );

   wire        exe_c_le_32_sel_31    = ( fmt_dp4 & dp4_c_le_32_sel_31 |
                                         fmt_dp5 & dp5_c_le_32_sel_31 );

   wire        exe_extend_en         = ( fmt_br1 & br1_extend_en |
                                         fmt_br2 & br2_extend_en |
                                         fmt_br3 & br3_extend_en |
                                         fmt_dp8 & dp8_extend_en |
                                         fmt_ls0 & ls0_extend_en |
                                         fmt_ls1 & ls1_extend_en |
                                         fmt_ls2 & ls2_extend_en |
                                         fmt_sy4 & sy4_extend_en |
                                         fmt_sy5 & sy5_extend_en );

   wire        exe_extend_nxt        = ( fmt_br1 & br1_extend_nxt |
                                         fmt_br2 & br2_extend_nxt |
                                         fmt_br3 & br3_extend_nxt |
                                         fmt_dp8 & dp8_extend_nxt |
                                         fmt_ls2 & ls2_extend_nxt |
                                         fmt_sy4 & sy4_extend_nxt |
                                         fmt_sy5 & sy5_extend_nxt );

   wire        exe_fe_use_add        = ( fmt_br1 & br1_fe_use_add |
                                         fmt_br2 & br2_fe_use_add |
                                         fmt_dp8 & dp8_fe_use_add );

   wire        exe_fe_use_rb         = ( fmt_br3 & br3_fe_use_rb);

   wire        exe_fetch_force       = ( fmt_br1 & br1_fetch_force |
                                         fmt_br2 & br2_fetch_force |
                                         fmt_br3 & br3_fetch_force |
                                         fmt_dp8 & dp8_fetch_force );

   wire        exe_fetch_stall       = ( fmt_br1 & br1_fetch_stall |
                                         fmt_br2 & br2_fetch_stall |
                                         fmt_br3 & br3_fetch_stall |
                                         fmt_dp5_fetch_stall |
                                         fmt_sy1 & sy1_fetch_stall |
                                         fmt_sy2 & sy2_fetch_stall |
                                         fmt_sy4 & sy4_fetch_stall |
                                         fmt_sy5 & sy5_fetch_stall |
                                         fmt_u16 & u16_fetch_stall );

   wire        exe_hdf_req           = ( fmt_sy1 & sy1_hdf_req |
                                         fmt_u16 & u16_hdf_req );

   wire        exe_iaex_hold         = ( fmt_br3 & br3_iaex_hold |
                                         fmt_dp5_iaex_hold |
                                         fmt_lm1 & lm1_iaex_hold |
                                         fmt_lm2 & lm2_iaex_hold |
                                         fmt_ls0 & ls0_iaex_hold |
                                         fmt_ls1 & ls1_iaex_hold |
                                         fmt_ls2 & ls2_iaex_hold |
                                         fmt_ls3 & ls3_iaex_hold |
                                         fmt_ls4 & ls4_iaex_hold |
                                         fmt_sy2 & sy2_iaex_hold |
                                         fmt_sy3 & sy3_iaex_hold |
                                         fmt_sy4 & sy4_iaex_hold |
                                         fmt_sy5 & sy5_iaex_hold |
                                         fmt_u16 & u16_iaex_hold );

   wire        exe_iaex_nsel_inc     = ( fmt_br1 & br1_iaex_nsel_inc |
                                         fmt_br2 & br2_iaex_nsel_inc |
                                         fmt_br3 & br3_iaex_nsel_inc |
                                         fmt_dp8 & dp8_iaex_nsel_inc );

   wire        exe_iaex_sel_add      = ( fmt_br1 & br1_iaex_sel_add |
                                         fmt_br2 & br2_iaex_sel_add |
                                         fmt_dp8 & dp8_iaex_sel_add |
                                         fmt_sy1 & sy1_iaex_sel_add |
                                         fmt_u16 & u16_iaex_sel_add );

   wire        exe_iaex_sel_rb       = ( fmt_br3 & br3_iaex_sel_rb );

   wire        exe_iq_use_nxt        = ( fmt_sy5 & sy5_iq_use_nxt );

   wire        exe_list_en           = ( fmt_dp5_list_en |
                                         fmt_lm1 & lm1_list_en |
                                         fmt_lm2 & lm2_list_en );

   wire        exe_list_sel_op       = ( fmt_lm1 & lm1_list_sel_op |
                                         fmt_lm2 & lm2_list_sel_op );

   wire        exe_pc_rel            = ( fmt_ls3 & ls3_pc_rel );

   wire        exe_ls_multi          = ( fmt_lm1 & lm1_ls_multi |
                                         fmt_lm2 & lm2_ls_multi );

   wire        exe_ls_trans          = ( fmt_lm1 & lm1_ls_trans |
                                         fmt_lm2 & lm2_ls_trans |
                                         fmt_ls0 & ls0_ls_trans |
                                         fmt_ls1 & ls1_ls_trans |
                                         fmt_ls2 & ls2_ls_trans |
                                         fmt_ls3 & ls3_ls_trans |
                                         fmt_ls4 & ls4_ls_trans );

   wire        exe_ls_use_ra         = ( fmt_lm1 & lm1_ls_use_ra |
                                         fmt_lm2 & lm2_ls_use_ra );

   wire        exe_ls_write          = ( fmt_lm1 & lm1_ls_write |
                                         fmt_lm2 & lm2_ls_write |
                                         fmt_ls0 & ls0_ls_write |
                                         fmt_ls1 & ls1_ls_write |
                                         fmt_ls2 & ls2_ls_write |
                                         fmt_ls4 & ls4_ls_write );

   wire        exe_mtx_ctl_sel_rot   = ( fmt_dp4 & dp4_mtx_ctl_sel_rot |
                                         fmt_dp5 & dp5_mtx_ctl_sel_rot );

   wire        exe_mtx_in_sel_rot    = ( fmt_dp4 & dp4_mtx_in_sel_rot |
                                         fmt_dp5 & dp5_mtx_in_sel_rot |
                                         fmt_dp9 & dp9_mtx_in_sel_rot );

   wire        exe_offset_en         = ( fmt_br3 & br3_offset_en |
                                         fmt_dp5_offset_en |
                                         fmt_lm1 & lm1_offset_en |
                                         fmt_lm2 & lm2_offset_en |
                                         fmt_sy4 & sy4_offset_en );

   wire        exe_offset_nsel_one   = ( fmt_br3 & br3_offset_nsel_one |
                                         fmt_sy4 & sy4_offset_nsel_one );

   wire        exe_offset_sel_one    = ~exe_offset_nsel_one;

   wire        exe_op_hold           = ( fmt_br1 & br1_op_hold |
                                         fmt_br2 & br2_op_hold |
                                         fmt_br3 & br3_op_hold |
                                         fmt_dp8 & dp8_op_hold |
                                         fmt_lm2 & lm2_op_hold |
                                         fmt_sy1 & sy1_op_hold |
                                         fmt_sy2 & sy2_op_hold |
                                         fmt_sy5 & sy5_op_hold |
                                         fmt_u16 & u16_op_hold );

   wire        exe_opa_mask_pc       = ( fmt_dp6 & dp6_opa_mask_pc |
                                         fmt_ls3 & ls3_opa_mask_pc );

   wire        exe_opa_sel_pc        = ( fmt_br1 & br1_opa_sel_pc |
                                         fmt_br2 & br2_opa_sel_pc |
                                         fmt_br3 & br3_opa_sel_pc |
                                         fmt_dp6 & dp6_opa_sel_pc |
                                         fmt_dp8 & dp8_opa_sel_pc |
                                         fmt_ls3 & ls3_opa_sel_pc );

   wire        exe_opa_nsel_ra        = ( fmt_br1 & br1_opa_nsel_ra |
                                          fmt_br2 & br2_opa_nsel_ra |
                                          fmt_br3 & br3_opa_nsel_ra |
                                          fmt_dp3 & dp3_opa_nsel_ra |
                                          fmt_dp5 & dp5_opa_nsel_ra |
                                          fmt_dp6 & dp6_opa_nsel_ra |
                                          fmt_dp8 & dp8_opa_nsel_ra |
                                          fmt_ls3 & ls3_opa_nsel_ra |
                                          fmt_sy1 & sy1_opa_nsel_ra |
                                          fmt_u16 & u16_opa_nsel_ra );

   wire        exe_opa_sel_ra         = ~exe_opa_nsel_ra;

   wire        exe_opb_inv           = ( fmt_br3 & br3_opb_inv |
                                         fmt_dp1 & dp1_opb_inv |
                                         fmt_dp2 & dp2_opb_inv |
                                         fmt_dp3 & dp3_opb_inv |
                                         fmt_dp5 & dp5_opb_inv |
                                         fmt_dp6 & dp6_opb_inv |
                                         fmt_dp8 & dp8_opb_inv |
                                         fmt_lm2 & lm2_opb_inv |
                                         fmt_sy1 & sy1_opb_inv |
                                         fmt_u16 & u16_opb_inv );

   wire        exe_opb_sel_imm3      = ( fmt_dp2 & dp2_opb_sel_imm3 );
   wire        exe_opb_sel_imm5_0    = ( fmt_ls0 & ls0_opb_sel_imm5_0 );
   wire        exe_opb_sel_imm5_1    = ( fmt_ls1 & ls1_opb_sel_imm5_1 );
   wire        exe_opb_sel_imm5_2    = ( fmt_ls0 & ls0_opb_sel_imm5_2 );
   wire        exe_opb_sel_imm7_2    = ( fmt_dp6 & dp6_opb_sel_imm7_2 );
   wire        exe_opb_sel_imm8      = ( fmt_dp3 & dp3_opb_sel_imm8 );

   wire        exe_opb_sel_imm8_2    = ( fmt_dp6 & dp6_opb_sel_imm8_2 |
                                         fmt_ls3 & ls3_opb_sel_imm8_2 |
                                         fmt_ls4 & ls4_opb_sel_imm8_2 );

   wire        exe_opb_sel_simm11    = ( fmt_br2 & br2_opb_sel_simm11 );
   wire        exe_opb_sel_simm8     = ( fmt_br1 & br1_opb_sel_simm8 );

   wire        exe_opb_sel_list      = ( fmt_lm1 & lm1_opb_sel_list |
                                         fmt_lm2 & lm2_opb_sel_list );

   wire        exe_opb_sel_pc        = ( fmt_dp8 & dp8_opb_sel_pc );

   wire        exe_opb_sel_rb        = ( fmt_dp1 & dp1_opb_sel_rb |
                                         fmt_dp5 & dp5_opb_sel_rb |
                                         fmt_dp8 & dp8_opb_sel_rb |
                                         fmt_ls2 & ls2_opb_sel_rb );

   wire        exe_opc_sel_apsr      = ( fmt_dp5 & dp5_opc_sel_apsr );

   wire        exe_opc_sel_one       = ( fmt_dp1 & dp1_opc_sel_one |
                                         fmt_dp2 & dp2_opc_sel_one |
                                         fmt_dp3 & dp3_opc_sel_one |
                                         fmt_dp5 & dp5_opc_sel_one |
                                         fmt_dp6 & dp6_opc_sel_one |
                                         fmt_dp8 & dp8_opc_sel_one |
                                         fmt_lm2 & lm2_opc_sel_one );

   wire        exe_pdec_sel_old      = ( fmt_br1 & br1_pdec_sel_old |
                                         fmt_br2 & br2_pdec_sel_old );

   wire        exe_perm_mtx_revb     = ( fmt_dp9 & dp9_perm_mtx_revb );
   wire        exe_perm_mtx_revh     = ( fmt_dp9 & dp9_perm_mtx_revh );
   wire        exe_perm_mtx_sgn_1    = ( fmt_dp9 & dp9_perm_mtx_sgn_1 );
   wire        exe_perm_mtx_sgn_32   = ( fmt_dp9 & dp9_perm_mtx_sgn_32 );
   wire        exe_perm_mtx_xt       = ( fmt_dp9 & dp9_perm_mtx_xt );
   wire        exe_perm_sgn_sel_15   = ( fmt_dp9 & dp9_perm_sgn_sel_15 );
   wire        exe_perm_sgn_sel_7    = ( fmt_dp9 & dp9_perm_sgn_sel_7 );

   wire        exe_preempt_force     = ( fmt_sy1 & sy1_preempt_force |
                                         fmt_u16 & u16_preempt_force );

   wire        exe_primask_en        = ( fmt_sy3 & sy3_primask_en );
   wire        exe_primask_sel_op    = 1'b1;

   wire        exe_ra_addr_hold      = ( fmt_br1 & br1_ra_addr_hold |
                                         fmt_br2 & br2_ra_addr_hold |
                                         fmt_br3 & br3_ra_addr_hold |
                                         fmt_dp5_ra_addr_hold |
                                         fmt_dp8 & dp8_ra_addr_hold |
                                         fmt_sy5 & sy5_ra_addr_hold |
                                         fmt_lm1 & lm1_ra_addr_hold |
                                         fmt_lm2 & lm2_ra_addr_hold |
                                         fmt_ls0 & ls0_ra_addr_hold |
                                         fmt_ls1 & ls1_ra_addr_hold |
                                         fmt_ls2 & ls2_ra_addr_hold |
                                         fmt_ls3 & ls3_ra_addr_hold |
                                         fmt_ls4 & ls4_ra_addr_hold );

   wire        exe_ra_addr_nsel_pdec = ( fmt_br3 & br3_ra_addr_nsel_pdec );
   wire        exe_ra_addr_sel_r13   = ( fmt_br3 & br3_ra_addr_sel_r13 );

   wire        exe_rb_addr_hold      = ( fmt_br1 & br1_rb_addr_hold |
                                         fmt_br2 & br2_rb_addr_hold |
                                         fmt_br3 & br3_rb_addr_hold |
                                         fmt_dp5_rb_addr_hold |
                                         fmt_dp8 & dp8_rb_addr_hold |
                                         fmt_sy5 & sy5_rb_addr_hold );

   wire        exe_rb_addr_nsel_pdec = ( fmt_ls0 & ls0_rb_addr_nsel_pdec |
                                         fmt_ls1 & ls1_rb_addr_nsel_pdec |
                                         fmt_ls2 & ls2_rb_addr_nsel_pdec |
                                         fmt_ls3 & ls3_rb_addr_nsel_pdec |
                                         fmt_ls4 & ls4_rb_addr_nsel_pdec |
                                         fmt_lm1 & lm1_rb_addr_nsel_pdec |
                                         fmt_lm2 & lm2_rb_addr_nsel_pdec |
                                         fmt_sy5 & sy5_rb_addr_nsel_pdec );

   wire        exe_rb_addr_sel_108   = ( fmt_ls3 & ls3_rb_addr_sel_108 |
                                         fmt_ls4 & ls4_rb_addr_sel_108 );

   wire        exe_rb_addr_sel_30    = ( fmt_sy5 & sy5_rb_addr_sel_30 );

   wire        exe_rb_addr_sel_list  = ( fmt_lm1 & lm1_rb_addr_sel_list |
                                         fmt_lm2 & lm2_rb_addr_sel_list );

   wire        exe_rb_addr_sel_z20   = ( fmt_ls0 & ls0_rb_addr_sel_z20 |
                                         fmt_ls1 & ls1_rb_addr_sel_z20 |
                                         fmt_ls2 & ls2_rb_addr_sel_z20 );

   wire        exe_ror_amt_sel_left  = ( fmt_dp4 & dp4_ror_amt_sel_left |
                                         fmt_dp5 & dp5_ror_amt_sel_left );

   wire        exe_ror_amt_sel_right = ( fmt_dp4 & dp4_ror_amt_sel_right |
                                         fmt_dp5 & dp5_ror_amt_sel_right );

   wire        exe_ror_force_msk     = ( fmt_dp5 & dp5_ror_force_msk);

   wire        exe_rot_sign_sel_ra31 = ( fmt_dp4 & dp4_rot_sign_sel_ra31 |
                                         fmt_dp5 & dp5_rot_sign_sel_ra31 );

   wire        exe_rot_amt_sel_rb    = ( fmt_dp5 & dp5_rot_amt_sel_rb );
   wire        exe_rot_amt_sel_imm   = ( fmt_dp4 & dp4_rot_amt_sel_imm );
   wire        exe_event_set         = ( fmt_sy4 & sy4_event_set );

   wire        exe_shf_left          = ( fmt_dp4 & dp4_shf_left |
                                         fmt_dp5 & dp5_shf_left );

   wire        exe_shf_ror           = ( fmt_dp5 & dp5_shf_ror );
   wire        exe_spsel_en          = ( fmt_br3 & br3_spsel_en );
   wire        exe_spsel_sel_rb2     = ( fmt_br3 & br3_spsel_sel_rb2 );

   wire        exe_state_en_std      = ( fmt_br1 & br1_state_en_std |
                                         fmt_br2 & br2_state_en_std |
                                         fmt_br3 & br3_state_en_std |
                                         fmt_dp5_state_en_std |
                                         fmt_dp8 & dp8_state_en_std |
                                         fmt_lm1 & lm1_state_en_std |
                                         fmt_lm2 & lm2_state_en_std |
                                         fmt_ls0 & ls0_state_en_std |
                                         fmt_ls1 & ls1_state_en_std |
                                         fmt_ls2 & ls2_state_en_std |
                                         fmt_ls3 & ls3_state_en_std |
                                         fmt_ls4 & ls4_state_en_std |
                                         fmt_sy1 & sy1_state_en_std |
                                         fmt_sy2 & sy2_state_en_std |
                                         fmt_sy4 & sy4_state_en_std |
                                         fmt_sy5 & sy5_state_en_std |
                                         fmt_u16 & u16_state_en_std );

   wire        exe_state_sel_hlt     = ( fmt_sy2 & sy2_state_sel_hlt );

   wire        exe_state_sel_lck     = ( fmt_sy1 & sy1_state_sel_lck |
                                         fmt_u16 & u16_state_sel_lck );

   wire        exe_state_sel_ldm     = ( fmt_lm1 & lm1_state_sel_ldm |
                                         fmt_lm2 & lm2_state_sel_ldm );

   wire        exe_state_sel_ldr     = ( fmt_ls0 & ls0_state_sel_ldr |
                                         fmt_ls1 & ls1_state_sel_ldr |
                                         fmt_ls2 & ls2_state_sel_ldr |
                                         fmt_ls3 & ls3_state_sel_ldr |
                                         fmt_ls4 & ls4_state_sel_ldr );

   wire        exe_state_sel_pfu     = ( fmt_br1 & br1_state_sel_pfu |
                                         fmt_br2 & br2_state_sel_pfu |
                                         fmt_br3 & br3_state_sel_pfu |
                                         fmt_dp8 & dp8_state_sel_pfu );

   wire        exe_state_sel_rfe     = ( fmt_br3 & br3_state_sel_rfe);
   wire        exe_state_sel_t32     = ( fmt_sy5 & sy5_state_sel_t32);

   wire        exe_state_sel_stm     = ( fmt_lm1 & lm1_state_sel_stm |
                                         fmt_lm2 & lm2_state_sel_stm );

   wire        exe_state_sel_str     = ( fmt_ls0 & ls0_state_sel_str |
                                         fmt_ls1 & ls1_state_sel_str |
                                         fmt_ls2 & ls2_state_sel_str |
                                         fmt_ls4 & ls4_state_sel_str );

   wire        exe_state_sel_wfx     = ( fmt_sy4 & sy4_state_sel_wfx );

   wire        exe_svc_req           = ( fmt_sy1 & sy1_svc_req );
   wire        exe_tbit_en           = ( fmt_br3 & br3_tbit_en );
   wire        exe_tbit_sel_rb       = 1'b1;
   wire        exe_wfe_execute       = ( fmt_sy4 & sy4_wfe_execute );
   wire        exe_wfi_execute       = ( fmt_sy4 & sy4_wfi_execute );
   wire        exe_wic_load          = ( fmt_sy4 & sy4_wic_load );

   wire        exe_wr_addr_sel_108   = ( fmt_dp6 & dp6_wr_addr_sel_108 |
                                         fmt_lm1 & lm1_wr_addr_sel_108 |
                                         iop_wr_addr_sel_108 );

   wire        exe_wr_addr_sel_r14   = ( fmt_br3 & br3_wr_addr_sel_r14 );

   wire        exe_wr_addr_sel_z20   = ( fmt_dp1 & dp1_wr_addr_sel_z20 |
                                         fmt_dp2 & dp2_wr_addr_sel_z20 |
                                         fmt_dp4 & dp4_wr_addr_sel_z20 |
                                         fmt_dp9 & dp9_wr_addr_sel_z20 |
                                         iop_wr_addr_sel_z20 );

   wire        exe_wr_data_sel_alu   = ( fmt_br3 & br3_wr_data_sel_alu |
                                         fmt_dp1 & dp1_wr_data_sel_alu |
                                         fmt_dp2 & dp2_wr_data_sel_alu |
                                         fmt_dp3 & dp3_wr_data_sel_alu |
                                         fmt_dp5 & dp5_wr_data_sel_alu |
                                         fmt_dp6 & dp6_wr_data_sel_alu |
                                         fmt_dp8 & dp8_wr_data_sel_alu |
                                         fmt_lm1 & lm1_wr_data_sel_alu |
                                         fmt_lm2 & lm2_wr_data_sel_alu );

   wire        exe_wr_data_sel_spu   = ( fmt_dp4 & dp4_wr_data_sel_spu |
                                         fmt_dp5 & dp5_wr_data_sel_spu |
                                         fmt_dp9 & dp9_wr_data_sel_spu |
                                         iop_wr_data_sel_spu );

   wire        exe_wr_en_std         = ( fmt_br3 & br3_wr_en_std |
                                         fmt_dp1 & dp1_wr_en_std |
                                         fmt_dp2 & dp2_wr_en_std |
                                         fmt_dp3 & dp3_wr_en_std |
                                         fmt_dp4 & dp4_wr_en_std |
                                         fmt_dp5 & dp5_wr_en_std |
                                         fmt_dp6 & dp6_wr_en_std |
                                         fmt_dp8 & dp8_wr_en_std |
                                         fmt_dp9 & dp9_wr_en_std |
                                         fmt_lm1 & lm1_wr_en_std |
                                         fmt_lm2 & lm2_wr_en_std );

   // -------------------------------------------------------------------------
   // Decode 32-bit instructions
   // -------------------------------------------------------------------------

   // Breakout architectural half-words (HW1 and HW2) from opcode buffer and
   // instruction queue buffer. Half-word 1 is always held in op_q[15:0] and
   // half-word 2 is always held in iq_q[15:0].

   wire [15:0] hw1 = op_q;
   wire [15:0] hw2 = iq_q;

   // -------------------------------------------------------------------------
   // 32-bit undefined instruction decoder
   // -------------------------------------------------------------------------

   // The implementation guarantees that there can never be a wait-state whilst
   // in this state by ensuring that there was no address phase in the previous
   // cycle.

   // An interrupt recognized during the second cycle of a T32 will result in
   // it becoming special (i.e. iq_s_q will be set), thus interrupts always
   // take priority.

   wire        u32_0x0 = {hw2[15:14],hw2[12]} == 3'b10_0;
   wire        u32_1x1 = {hw2[15:14],hw2[12]} == 3'b11_1;
   wire        u32_bad = hw2[7] | ~hw2[6] | (hw2[5:4] == 2'b11);

   wire        u32_defined = ( u32_0x0 & (hw1[10:5] == 6'b011100) |
                               u32_0x0 & (hw1[10:4] == 7'b0111011) & ~u32_bad |
                               u32_0x0 & (hw1[10:5] == 6'b011111) |
                               u32_1x1 );

   wire        fmt_u32 = ~u32_defined;

   // --------
   // UNDEFINED instructions generate Hardfaults unless we are already in the
   // Hardfault or NMI handler, at which point they must Lockup.

   wire        u32_hardfault = ~n_or_h_active;

   // --------
   // The inclusion of int_ready_q is for comprehension only, as iq_s_q will
   // also be set these values will not be used in the case of int_ready_q
   // being set.

   wire        u32_fe_nuse_add   = 1'b1;
   wire        u32_fetch_stall   = 1'b1;
   wire        u32_hdf_req       = u32_hardfault & ~int_ready_q;
   wire        u32_iaex_hold     = u32_hardfault | int_ready_q;
   wire        u32_preempt_force = u32_hardfault;
   wire        u32_opa_nsel_pc   = 1'b1;
   wire        u32_opb_inv       = 1'b1;
   wire        u32_state_sel_lck = 1'b1;

   // -------------------------------------------------------------------------
   // 32-bit instruction format 1 decoder: BL
   // -------------------------------------------------------------------------

   wire        fmt_tt1 = {hw2[15:14],hw2[12]} == 3'b11_1;

   // Note:    tt1_isn_bl = 1'b1;

   // --------

   wire        tt1_opb_sel_bl       = 1'b1;
   wire        tt1_wr_data_sel_link = 1'b1;
   wire        tt1_wr_addr_sel_r14  = 1'b1;
   wire        tt1_wr_en_std        = 1'b1;
   wire        tt1_state_sel_pfu    = 1'b1;
   wire        tt1_fetch_force      = 1'b1;

   // -------------------------------------------------------------------------
   // 32-bit instruction format 2 decoder: DMB DSB and ISB
   // -------------------------------------------------------------------------

   // DSB, DMB and ISB are all handled in a similar manner to branch-with-link,
   // resulting in the pipeline being flushed and the PC being advanced by 4.
   // The update to the PC is only flagged on the program flow trace interface
   // for ISB; DSB and DMB are masked.

   wire        fmt_tt2 = ( (hw1[10:4] == 7'b0_111_01_1) &
                           ({hw2[15:14],hw2[12]} == 3'b10_0) &
                           (hw2[5:4] != 2'b11) &
                           (hw2[7:6] == 2'b01) );

   // Note:    tt2_isn_dsb = hw2[5:4] == 2'b00;
   // Note:    tt2_isn_dmb = hw2[5:4] == 2'b01;
   wire        tt2_isn_isb = hw2[5:4] == 2'b10;

   // --------

   wire        tt2_fetch_force   = 1'b1;
   wire        tt2_iaex_is_seq   = ~tt2_isn_isb;
   wire        tt2_state_sel_pfu = 1'b1;

   // -------------------------------------------------------------------------
   // 32-bit instruction format 3 decoder: MRS and MSR
   // -------------------------------------------------------------------------

   // MRS and MSR access various state within the processor based on the
   // current privilege level and whether we are currently in Handler or
   // Thread mode.

   // As the instructions are 32-bits, fetch is re-initiated via a branch to
   // the next instruction, but is masked from the program flow trace
   // interface.

   wire        fmt_tt3 = ( (hw1[10:7] == 4'b0111) &
                           (hw1[6] == hw1[5]) &
                           ({hw2[15:14],hw2[12]} == 3'b10_0) );

   wire        tt3_isn_msr = hw1[5] == 1'b0;
   wire        tt3_isn_mrs = hw1[5] == 1'b1;

   // --------

   wire        tt3_765_nz  = hw2[7:5] != 3'b000;

   wire [4:0]  tt3_mrs_op0 = {tt3_isn_mrs,tt3_765_nz,hw2[4:3],hw2[0]};
   wire [4:0]  tt3_mrs_op2 = {tt3_isn_mrs,tt3_765_nz,hw2[4:3],hw2[2]};
   wire [4:0]  tt3_msr_op0 = {tt3_isn_msr,tt3_765_nz,hw2[4:3],hw2[0]};
   wire [4:0]  tt3_msr_op2 = {tt3_isn_msr,tt3_765_nz,hw2[4:3],hw2[2]};

   wire        tt3_msr_ctl = (tt3_msr_op2 == 5'b1_0_10_1) & priv;

   // --------

   wire        tt3_apsr_en             = tt3_msr_op2 == 5'b1_0_00_0;
   wire        tt3_fetch_force         = 1'b1;
   wire        tt3_iaex_is_seq         = 1'b1;
   wire        tt3_npriv_en            = tt3_msr_ctl;
   wire        tt3_primask_en          = (tt3_msr_op2 == 5'b1_0_10_0) & priv;
   wire        tt3_sp_main_en          = (tt3_msr_op0 == 5'b1_0_01_0) & priv;
   wire        tt3_sp_process_en       = (tt3_msr_op0 == 5'b1_0_01_1) & priv;
   wire        tt3_spsel_en            = tt3_msr_ctl & ~handler;
   wire        tt3_state_sel_pfu       = 1'b1;
   wire        tt3_wr_addr_sel_hw2     = 1'b1;
   wire        tt3_wr_data_sel_apsr    = (tt3_mrs_op2 == 5'b1_0_00_0);
   wire        tt3_wr_data_sel_control = (tt3_mrs_op2 == 5'b1_0_10_1);
   wire        tt3_wr_data_sel_ipsr    = (tt3_mrs_op0 == 5'b1_0_00_1) & priv;
   wire        tt3_wr_data_sel_msp     = (tt3_mrs_op0 == 5'b1_0_01_0) & priv;
   wire        tt3_wr_data_sel_psp     = (tt3_mrs_op0 == 5'b1_0_01_1) & priv;
   wire        tt3_wr_data_sel_primask = (tt3_mrs_op2 == 5'b1_0_10_0) & priv;
   wire        tt3_wr_data_sel_rb      = tt3_isn_msr;
   wire        tt3_wr_en_std           = tt3_isn_mrs;

   // -------------------------------------------------------------------------
   // 32-bit instruction control consolidation
   // -------------------------------------------------------------------------

   // Consolidate all of the control signals for the 32-bit instructions. As
   // a large number of control signals are common (in particular the need to
   // generate a branch to next instruction), the static value of these control
   // signals are generated here.

   wire        t32_alu_res_sel_add     = 1'b1;
   wire        t32_apsr_en             = (fmt_tt3 & tt3_apsr_en);
   wire        t32_apsr_sel_rb         = 1'b1;
   wire        t32_fe_nuse_add         = (fmt_u32 & u32_fe_nuse_add);
   wire        t32_fe_use_add          = ~t32_fe_nuse_add;

   wire        t32_fetch_force         = (fmt_tt1 & tt1_fetch_force |
                                          fmt_tt2 & tt2_fetch_force |
                                          fmt_tt3 & tt3_fetch_force );

   wire        t32_fetch_stall         = (fmt_u32 & u32_fetch_stall);
   wire        t32_hdf_req             = (fmt_u32 & u32_hdf_req);
   wire        t32_iaex_hold           = (fmt_u32 & u32_iaex_hold);
   wire        t32_iaex_nsel_inc       = 1'b1;
   wire        t32_iaex_sel_add        = 1'b1;

   wire        t32_iaex_is_seq         = (fmt_tt2 & tt2_iaex_is_seq |
                                          fmt_tt3 & tt3_iaex_is_seq );

   wire        t32_npriv_en            = (fmt_tt3 & tt3_npriv_en);
   wire        t32_npriv_sel_rb        = 1'b1;
   wire        t32_op_hold             = 1'b1;
   wire        t32_opa_nsel_pc         = (fmt_u32 & u32_opa_nsel_pc);
   wire        t32_opa_sel_pc          = ~t32_opa_nsel_pc;
   wire        t32_opb_inv             = (fmt_u32 & u32_opb_inv);
   wire        t32_opb_sel_bl          = (fmt_tt1 & tt1_opb_sel_bl);
   wire        t32_preempt_force       = (fmt_u32 & u32_preempt_force);
   wire        t32_primask_en          = (fmt_tt3 & tt3_primask_en);
   wire        t32_primask_sel_rb      = 1'b1;
   wire        t32_ra_addr_hold        = 1'b1;
   wire        t32_rb_addr_hold        = 1'b1;
   wire        t32_sp_main_en          = (fmt_tt3 & tt3_sp_main_en);
   wire        t32_sp_process_en       = (fmt_tt3 & tt3_sp_process_en);
   wire        t32_spsel_en            = (fmt_tt3 & tt3_spsel_en);
   wire        t32_spsel_sel_rb1       = 1'b1;
   wire        t32_state_en_std        = 1'b1;
   wire        t32_state_sel_lck       = (fmt_u32 & u32_state_sel_lck);

   wire        t32_state_sel_pfu       = (fmt_tt1 & tt1_state_sel_pfu |
                                          fmt_tt2 & tt2_state_sel_pfu |
                                          fmt_tt3 & tt3_state_sel_pfu );

   wire        t32_wr_addr_sel_hw2     = (fmt_tt3 & tt3_wr_addr_sel_hw2);
   wire        t32_wr_addr_sel_r14     = (fmt_tt1 & tt1_wr_addr_sel_r14);
   wire        t32_wr_data_sel_apsr    = (fmt_tt3 & tt3_wr_data_sel_apsr);
   wire        t32_wr_data_sel_control = (fmt_tt3 & tt3_wr_data_sel_control);
   wire        t32_wr_data_sel_ipsr    = (fmt_tt3 & tt3_wr_data_sel_ipsr);
   wire        t32_wr_data_sel_link    = (fmt_tt1 & tt1_wr_data_sel_link);
   wire        t32_wr_data_sel_msp     = (fmt_tt3 & tt3_wr_data_sel_msp);
   wire        t32_wr_data_sel_primask = (fmt_tt3 & tt3_wr_data_sel_primask);
   wire        t32_wr_data_sel_psp     = (fmt_tt3 & tt3_wr_data_sel_psp);
   wire        t32_wr_data_sel_rb      = (fmt_tt3 & tt3_wr_data_sel_rb);

   wire        t32_wr_en_std           = (fmt_tt1 & tt1_wr_en_std |
                                          fmt_tt3 & tt3_wr_en_std );

   // -------------------------------------------------------------------------
   // Reset sequencer
   // -------------------------------------------------------------------------

   // The reset sequence operates over four cycles:
   // - Cycle 1 : Idle (held until CPUWAIT is released).
   // - Cycle 2 : Read address 0x0.
   // - Cycle 3 : Read address 0x4, store data to MSP.
   // - Cycle 4 : Store data to PC, transfer to fetch state.
   // Cycle selection is controlled by the offset register, which has a reset
   // value of 4'b1111.

   // In case of a fault reading the MSP value or PC value, a Lockup condition
   // is implemented by forcing iaex_q to ~0, and entering the Lockup state;
   // the reset value of IPSR being Hardfault ensures that this Lockup occurs
   // at Hardfault. If no fault occurs, IPSR is set to Thread mode (0).

   wire        rst_cyc_1 = offset_q[1:0] == 2'b11; // offset reset to 15
   wire        rst_cyc_2 = offset_q[1:0] == 2'b00; // offset of 0
   wire        rst_cyc_3 = offset_q[1:0] == 2'b01; // offset of 1
   wire        rst_cyc_4 = offset_q[1:0] == 2'b10; // offset of 2

   // --------
   // The reset state is complete once cycle 4 finishes, or if there is a
   // fault in cycle 3 (or 4).

   wire        rst_cyc_last = rst_cyc_4 | rst_cyc_3 & fault_q;

   // --------

   wire        rst_atomic_en        = rst_cyc_last;
   wire        rst_fetch_stall      = 1'b1;
   wire        rst_iaex_hold        = ~rst_cyc_last;
   wire        rst_iaex_nsel_inc    = 1'b1;
   wire        rst_iaex_sel_bus     = 1'b1;
   wire        rst_iaex_sel_add     = fault_q;
   wire        rst_int_mask         = 1'b1;
   wire        rst_ipsr_en          = rst_cyc_4 & ~fault_q;
   wire        rst_ls_multi         = ~rst_cyc_1;
   wire        rst_ls_trans         = rst_cyc_2 | rst_cyc_3 & ~fault_q;
   wire        rst_ls_use_vec       = 1'b1;
   wire        rst_mtx_in_sel_bus   = rst_cyc_3;
   wire        rst_mtx_sel_use_load = rst_cyc_3;
   wire        rst_offset_sel_inc   = 1'b1;
   wire        rst_offset_en        = ~(rst_cyc_1 & cpu_wait_i);
   wire        rst_op_hold          = 1'b1;
   wire        rst_opb_inv          = fault_q;
   wire        rst_opb_sel_offset   = ~fault_q;
   wire        rst_ra_addr_hold     = 1'b1;
   wire        rst_rb_addr_hold     = 1'b1;
   wire        rst_base_en          = rst_cyc_2;
   wire        rst_base_sel_word    = 1'b1;
   wire        rst_sp_main_en       = rst_cyc_3;
   wire        rst_extend_en        = 1'b1;
   wire        rst_extend_nxt       = 1'b1;
   wire        rst_state_en_std     = rst_cyc_last;
   wire        rst_state_sel_pfu    = 1'b1;
   wire        rst_tbit_en          = rst_cyc_4;
   wire        rst_tbit_sel_bus     = ~fault_q;
   wire        rst_vtable           = 1'b1;
   wire        rst_wic_clear        = 1'b1;
   wire        rst_wr_data_sel_spu  = ~fault_q;

   // -------------------------------------------------------------------------
   // Fetch sequencer
   // -------------------------------------------------------------------------

   // The fetch sequencer operates over either one or two cycles. If the
   // address for the fetch was issued in the previous state, for example a
   // branch, then only one cycle is required to move the read data into the
   // opcode buffer. If the address for the fetch was not issued in the
   // previous state, for example POP {PC} or exception entry/return, then
   // the fetch sequencer uses an addition cycle to first perform the required
   // address phase.

   // If a fault_q is set in the PFU state, then either the fetch before
   // entering PFU state faulted, or a fetch issued by PFU state faulted, in
   // either case suppress any further fetches

   wire        pfu_cyc_1 = extend_q == 1'b1;
   wire        pfu_cyc_2 = extend_q == 1'b0;

   // --------

   wire        pfu_suppress = ~iaex_q[0] & ~cfg_hwf | fault_q | ~tbit_q;

   // --------

   wire        pfu_extend_en     = pfu_cyc_1;
   wire        pfu_fe_use_iaex   = pfu_cyc_1;
   wire        pfu_fetch_force   = pfu_cyc_1 | ~pfu_suppress;
   wire        pfu_fetch_stall   = pfu_suppress;
   wire        pfu_fault_keep    = pfu_cyc_1 & ~int_ready_q;
   wire        pfu_iaex_hold     = 1'b1;
   wire        pfu_op_hold       = pfu_cyc_1;
   wire        pfu_op_nuse_auto  = 1'b1;
   wire        pfu_op_use_fetch  = 1'b1;
   wire        pfu_ra_addr_hold  = pfu_cyc_1;
   wire        pfu_rb_addr_hold  = pfu_cyc_1;
   wire        pfu_state_sel_exe = 1'b1;
   wire        pfu_state_en_std  = pfu_cyc_2;

   // -------------------------------------------------------------------------
   // Load state management
   // -------------------------------------------------------------------------

   // The load state is a simple, single cycle state that either moves the
   // read data into the appropriate register, or setups up a fault scenario.
   // This state is not used by single cycle loads utilizing the IO-port
   // (unless alignment faulting), or by load-multiple instructions.

   // Faults outside of NMI or Hardfault will produce a Hardfault exception,
   // those inside NMI or Hardfault will result in a Lockup.

   // The PC will advance unless there is a Hardfault generating exception,
   // at which point it will be held. If not held, the PC advances unless
   // there is a Lockup condition, at which point it loads the PC with ~0.

   wire        ldr_hardfault = fault_q & ~n_or_h_active;

   // --------

   wire        ldr_hdf_req          = ldr_hardfault;
   wire        ldr_iaex_hold        = ldr_hardfault;
   wire        ldr_iaex_sel_add     = fault_q;
   wire        ldr_mtx_in_sel_bus   = 1'b1;
   wire        ldr_mtx_sel_use_load = 1'b1;
   wire        ldr_op_hold          = 1'b1;
   wire        ldr_opb_inv          = fault_q;
   wire        ldr_pdec_sel_old     = 1'b1;
   wire        ldr_preempt_force    = ldr_hardfault;
   wire        ldr_state_en_std     = 1'b1;
   wire        ldr_state_sel_exe    = ~fault_q;
   wire        ldr_state_sel_lck    = fault_q;
   wire        ldr_wr_addr_sel_rb   = 1'b1;
   wire        ldr_wr_data_sel_spu  = 1'b1;
   wire        ldr_wr_en_std        = ~fault_q;

   // -------------------------------------------------------------------------
   // Store state management
   // -------------------------------------------------------------------------

   // The store state is a simple, single cycle state that waits whilst the
   // bus utilizes the register value. If the bus reports an error, it will
   // additionally setup up a fault scenario. This state is not used by single
   // cycle stores utilizing the IO-port (unless alignment faulting), or by
   // store-multiple instructions.

   // Fault / PC handling are as per the LDR state.

   wire        str_hardfault = ldr_hardfault;

   // --------

   wire        str_preempt_force = str_hardfault;
   wire        str_hdf_req       = str_hardfault;
   wire        str_iaex_hold     = str_hardfault;
   wire        str_iaex_sel_add  = fault_q;
   wire        str_op_hold       = 1'b1;
   wire        str_opb_inv       = fault_q;
   wire        str_pdec_sel_old  = 1'b1;
   wire        str_state_en_std  = 1'b1;
   wire        str_state_sel_exe = ~fault_q;
   wire        str_state_sel_lck = fault_q;

   // -------------------------------------------------------------------------
   // Load-multiple state management
   // -------------------------------------------------------------------------

   // The load-multiple state is responsible for managing all parts of LDM with
   // the exception of the first "address-only" cycle, which is performed as
   // part of instruction decode.

   // POP {...,PC} where the most-significant nibble of the loaded data is 0xF
   // is defined as being an exception return. Use of LDM forms with an empty
   // list is UNPREDICTABLE. To prevent this from causing an exception return
   // using an incorrect base pointer, bit[3] of the base register is checked
   // to ensure that a return can only be made using the stack-pointer.

   wire        ldm_advance = ~fault_q & ~int_ready_q;
   wire        ldm_chain   = atomic_q & (fault_q | int_ready_q);
   wire        ldm_eret    = (bus_rdata[31:28] == 4'hF) & handler;
   wire        ldm_fault   = ~atomic_q & fault_q;
   wire        ldm_pop_pc  = (rb_addr_q == 4'hE);
   wire        ldm_restore = ~atomic_q & ~ldm_advance;
   wire        ldm_branch  = ~atomic_q & ldm_pop_pc & ~fault_q;
   wire        ldm_ret_ok  = ldm_eret & ra_addr_q[3];
   wire        ldm_return  = ldm_branch & ldm_ret_ok;

   // --------

   wire        ldm_atomic_en         = ldm_return;
   wire        ldm_atomic_nxt        = 1'b1;
   wire        ldm_extend_en         = ~atomic_q & ldm_pop_pc;
   wire        ldm_extend_nxt        = 1'b1;
   wire        ldm_fetch_stall       = ldm_pop_pc;
   wire        ldm_hdf_req           = fault_q & (~n_or_h_active | atomic_q);

   wire        ldm_iaex_en           = ( ~atomic_q & list_empty & ldm_advance |
                                         ldm_fault & n_or_h_active );

   wire        ldm_iaex_hold         = ~ldm_iaex_en;
   wire        ldm_iaex_nsel_inc     = ldm_pop_pc;
   wire        ldm_iaex_sel_bus      = ldm_pop_pc;
   wire        ldm_iaex_sel_add      = fault_q;
   wire        ldm_list_en           = ~list_empty;
   wire        ldm_list_sel_list     = 1'b1;
   wire        ldm_ls_multi          = 1'b1;

   wire        ldm_ls_trans          = ( atomic_q |
                                         ~list_empty & ldm_advance );

   wire        ldm_mtx_in_sel_bus    = 1'b1;
   wire        ldm_mtx_sel_use_load  = 1'b1;
   wire        ldm_offset_sel_eight  = ldm_chain;

   wire        ldm_offset_sel_inc    = ( atomic_q & ~ldm_chain |
                                         ~ldm_pop_pc & ~ldm_chain );

   wire        ldm_offset_en         = atomic_q | ~list_empty | ldm_pop_pc;
   wire        ldm_op_hold           = 1'b1;
   wire        ldm_opa_sel_aux       = atomic_q | ~fault_q;
   wire        ldm_opb_sel_offset    = atomic_q | ~fault_q;
   wire        ldm_opb_inv           = ldm_fault;
   wire        ldm_pdec_sel_old      = 1'b1;
   wire        ldm_preempt_force     = ldm_fault & ~n_or_h_active;

   wire        ldm_ra_addr_hold      = ( atomic_q | ~list_empty | fault_q |
                                         ldm_pop_pc );

   wire        ldm_rb_addr_sel_list  = atomic_q | ~list_empty;
   wire        ldm_rb_addr_nsel_pdec = atomic_q | ~list_empty;
   wire        ldm_spsel_en          = ldm_return & ldm_advance;
   wire        ldm_spsel_sel_bus     = 1'b1;
   wire        ldm_state_en_std      = list_empty | ldm_fault | ldm_chain;
   wire        ldm_state_sel_exe     = ~atomic_q & ~fault_q & ~ldm_pop_pc;
   wire        ldm_state_sel_lck     = ldm_fault & n_or_h_active;
   wire        ldm_state_sel_pfu     = ldm_branch & ~ldm_ret_ok;
   wire        ldm_state_sel_rfe     = atomic_q | ldm_return;
   wire        ldm_tbit_en           = ldm_branch & ~int_ready_q;
   wire        ldm_tbit_sel_bus      = 1'b1;
   wire        ldm_hdf_lock_en       = atomic_q & fault_q & n_or_h_active;
   wire        ldm_hdf_lock_nxt      = 1'b1;
   wire        ldm_wr_addr_sel_r14   = ldm_chain;
   wire        ldm_wr_addr_sel_rb    = ldm_advance;
   wire        ldm_wr_data_sel_aux   = ldm_restore;
   wire        ldm_wr_data_sel_ret   = ldm_chain;
   wire        ldm_wr_data_sel_spu   = ldm_advance;

   wire        ldm_wr_en_std         = ( atomic_q |
                                         ~atomic_q & ~ldm_pop_pc |
                                         ldm_fault |
                                         ~atomic_q & int_ready_q );

   // -------------------------------------------------------------------------
   // Store-multiple state management
   // -------------------------------------------------------------------------

   // The STM state is used for the combined data/address and final data phases
   // of STM, PUSH and exception entry. PUSH always uses R13 as the base,
   // while STM can only use R0-R7 as base; the most-significant bit of the
   // RA pointer is used to differentiate between the two. Exception entry
   // usage is identified by atomic_q being set.

   wire        stm_lockup          = ~atomic_q & n_or_h_active & fault_q;
   wire        stm_hardfault       = ~n_or_h_active & fault_q;
   wire        stm_nlast_or_atomic = atomic_q | ~list_empty;

   // --------

   wire        stm_alu_res_sel_add   = 1'b1;
   wire        stm_aux_en            = list_empty & atomic_q;
   wire        stm_aux_sel_iaex      = 1'b1;
   wire        stm_hdf_req           = stm_hardfault;

   wire        stm_iaex_hold         = ( stm_hardfault |
                                         atomic_q |
                                         ~list_empty & ~stm_lockup );

   wire        stm_iaex_sel_add      = stm_lockup;
   wire        stm_list_en           = ~list_empty;
   wire        stm_list_sel_list     = 1'b1;
   wire        stm_ls_multi          = 1'b1;
   wire        stm_ls_trans          = (~list_empty & ~fault_q) | atomic_q;
   wire        stm_ls_write          = 1'b1;
   wire        stm_offset_en         = stm_nlast_or_atomic;
   wire        stm_offset_sel_inc    = 1'b1;
   wire        stm_op_hold           = 1'b1;
   wire        stm_opa_sel_aux       = ~stm_lockup;
   wire        stm_opb_inv           = stm_lockup;
   wire        stm_opb_sel_offset    = ~stm_lockup;
   wire        stm_nmi_lock_en       = fault_q & atomic_q & n_or_h_active;
   wire        stm_nmi_lock_nxt      = 1'b1;
   wire        stm_pdec_sel_old      = 1'b1;
   wire        stm_preempt_force     = ~atomic_q & stm_hardfault;
   wire        stm_ra_addr_hold      = stm_nlast_or_atomic;
   wire        stm_rb_addr_nsel_pdec = stm_nlast_or_atomic;
   wire        stm_rb_addr_sel_aux   = list_empty & atomic_q;
   wire        stm_rb_addr_sel_list  = ~list_empty;
   wire        stm_state_sel_exe     = ~fault_q & ~atomic_q;
   wire        stm_state_sel_irq     = atomic_q;
   wire        stm_state_sel_lck     = stm_lockup;
   wire        stm_state_en_std      = list_empty | fault_q & ~atomic_q;
   wire        stm_wr_addr_sel_r14   = atomic_q;
   wire        stm_wr_data_sel_aux   = ra_addr_q[3] & ~atomic_q;
   wire        stm_wr_data_sel_alu   = ~ra_addr_q[3];
   wire        stm_wr_data_sel_ret   = atomic_q;
   wire        stm_wr_en_std         = list_empty & (~fault_q | atomic_q);

   // -------------------------------------------------------------------------
   // Exception entry sequencing
   // -------------------------------------------------------------------------

   // Cycle 1 occurs before using the STM state to perform the required state
   // preservation, and is used to setup the address for the stack-push.
   // Cycles 2, 3 and 4 occur after the STM has run and are used to perform
   // the final writes of PC and XPSR as well as performing the vector fetch
   // before handing off to the fetch state.

   wire [2:0]  offset_3_10 = {offset_q[3], offset_q[1:0]};

   wire        irq_cyc_1 = offset_3_10 == 3'b0_01; // offset of 1 : R0 addr

   // 1...6 executed in the STM state to perform PUSH {r1-r3,r12,lr,retaddr}

   wire        irq_cyc_2 = offset_3_10 == 3'b0_11; // offset of 7 : xPSR addr
   wire        irq_cyc_3 = offset_3_10 == 3'b1_00; // offset of 8 : Vec addr
   wire        irq_cyc_4 = offset_3_10 == 3'b1_01; // offset of 9 : Vec data

   // --------

   // Request a HardFault if a fault occurs and not NMI or HDF.
   // Cycle 3 of the IRQ handling is the final data-phase of the xPSR write,
   // and must therefore use the old value of the IPSR, which is currently
   // in the aux_q register being stored.

   wire        irq_lockup_vector = ( fault_q |
                                     hdf_lock_q & hdf_active |
                                     nmi_lock_q & nmi_active );

   wire        irq_finished      = ( ~int_ready_q & ~fault_q |
                                     ~int_ready_q & n_or_h_active );

   wire        aux_is_hdf        = aux_q[5:0] == 6'b000011;

   wire        irq_set_lock      = ( irq_cyc_2 & n_or_h_active |
                                     irq_cyc_3 & aux_is_hdf |
                                     irq_cyc_4 & n_or_h_active );

   // --------

   wire        irq_align_dword       = irq_cyc_1;
   wire        irq_alu_res_sel_add   = 1'b1;
   wire        irq_atomic_en         = irq_cyc_4 & irq_finished;
   wire        irq_aux_en            = irq_cyc_1 | irq_cyc_2;
   wire        irq_aux_sel_add       = irq_cyc_1;
   wire        irq_aux_sel_epsr      = irq_cyc_2;
   wire        irq_aux_sel_misc      = irq_cyc_2;
   wire        irq_base_en           = irq_cyc_1;
   wire        irq_base_sel_word     = 1'b1;
   wire        irq_extend_en         = irq_cyc_4 | irq_cyc_1;
   wire        irq_extend_nxt        = irq_cyc_4 | sp_value[2];
   wire        irq_fetch_stall       = 1'b1;

   wire        irq_hdf_lock_en       = ( fault_q & irq_set_lock |
                                         irq_cyc_1 );

   wire        irq_hdf_lock_nxt      = ~irq_cyc_1;
   wire        irq_hdf_pend          = fault_q & irq_cyc_3 & ~aux_is_hdf;

   wire        irq_hdf_req           = ( fault_q & ~irq_set_lock &
                                         ~n_or_h_active );

   wire        irq_iaex_hold         = ~(irq_finished & irq_cyc_4);
   wire        irq_iaex_nsel_inc     = 1'b1;
   wire        irq_iaex_sel_add      = irq_lockup_vector;
   wire        irq_iaex_sel_bus      = ~irq_lockup_vector;
   wire        irq_int_resample      = irq_cyc_3;
   wire        irq_ipsr_en           = irq_cyc_2 | irq_cyc_4 & ~irq_finished;
   wire        irq_ipsr_free_en      = irq_cyc_3 & ~iq_s_q;
   wire        irq_ipsr_sel_vector   = 1'b1;

   wire        irq_iq_s_sel_one      = ( irq_cyc_2 & ~irq_hold & hready_i |
                                         irq_cyc_3 & ~irq_hold |
                                         irq_cyc_3 & iq_s_q & ~hready_i );

   wire        irq_irq_ack           = irq_finished & irq_cyc_4;
   wire        irq_list_en           = irq_cyc_1;
   wire        irq_list_sel_irq      = irq_cyc_1;
   wire        irq_ls_multi          = 1'b1;
   wire        irq_ls_trans          = ~irq_cyc_4 & ~(irq_cyc_3 & ~iq_s_q);
   wire        irq_ls_use_iq         = irq_cyc_3;
   wire        irq_ls_use_vec        = irq_cyc_3;
   wire        irq_ls_write          = ~irq_cyc_3;

   wire        irq_nmi_lock_en       = ( fault_q & irq_cyc_2 & n_or_h_active |
                                         fault_q & irq_cyc_3 & aux_is_hdf |
                                         irq_cyc_1 );

   wire        irq_nmi_lock_nxt      = ~irq_cyc_1;
   wire        irq_offset_en         = ~irq_cyc_1 & ~(irq_cyc_3 & ~iq_s_q);
   wire        irq_offset_sel_eight  = irq_cyc_4;
   wire        irq_offset_sel_inc    = ~irq_cyc_4;
   wire        irq_op_hold           = 1'b1;
   wire        irq_opa_sel_pc        = irq_cyc_3;
   wire        irq_opa_sel_ra        = ~irq_cyc_3 & ~irq_cyc_4;
   wire        irq_opb_inv           = ~irq_cyc_2;
   wire        irq_opb_sel_32        = irq_cyc_1;
   wire        irq_opb_sel_four      = irq_cyc_3;
   wire        irq_opb_sel_offset    = irq_cyc_2;
   wire        irq_opc_sel_one       = ~irq_cyc_2 & ~irq_cyc_4;
   wire        irq_ra_addr_hold      = 1'b1;
   wire        irq_rb_addr_nsel_pdec = 1'b1;
   wire        irq_rb_addr_sel_aux   = irq_cyc_2 | irq_cyc_3;
   wire        irq_spsel_en          = irq_cyc_4;
   wire        irq_state_en_std      = irq_cyc_1 | (irq_cyc_4 & irq_finished);
   wire        irq_state_sel_pfu     = ~irq_cyc_1;
   wire        irq_state_sel_stm     = irq_cyc_1;
   wire        irq_tbit_en           = irq_finished & irq_cyc_4 & ~fault_q;
   wire        irq_tbit_sel_bus      = 1'b1;
   wire        irq_vtable            = irq_cyc_3;
   wire        irq_wic_clear         = irq_cyc_1;
   wire        irq_wr_data_sel_alu   = 1'b1;
   wire        irq_wr_data_sel_apsr  = irq_cyc_2;
   wire        irq_wr_data_sel_ipsr  = irq_cyc_2;
   wire        irq_wr_en_std         = irq_cyc_1;

   // -------------------------------------------------------------------------
   // Exception return sequencing
   // -------------------------------------------------------------------------

   // Cycle 1 is the first cycle of the exception return immediately following
   // the last cycle of a POP {PC} or a BX utilizing an EXC_RETURN value.
   // To permit earlier identification of SLEEP_ON_EXIT or tail-chain cases,
   // the first item loaded from the exception frame is the xPSR containing
   // the IPSR exception number.

   wire        rfe_cyc_1 = {offset_q[3], offset_q[1:0]} == 3'b0_00; // offset 0
   wire        rfe_cyc_2 = offset_q[1:0] == 2'b01; // offset of 1 : xPSR data
   wire        rfe_cyc_3 = offset_q[1:0] == 2'b10; // offset of 2 : R0 addr

   // 1...6 executed in LDM

   wire        rfe_cyc_4 = offset_q[1:0] == 2'b11; // offset of 7 : PC addr
   wire        rfe_cyc_5 = offset_q[3];            // offset of 8 : PC data

   // -------
   // Tail-chaining occurs if a fault or an interrupt are seen whilst the
   // exception return is being performed. Sleep occurs if SLEEPONEXIT is set
   // if the PSR indicates Thread mode in cycle 3.

   wire        rfe_chain = ( ~rfe_cyc_1 & int_ready_q |
                             ~rfe_cyc_1 & fault_q  );

   wire        rfe_sleep = ( nvm_sleep_on_exit_i & iaex_q[2] &
                             ~int_ready_q & ~fault_q );

   // -------

   wire        rfe_alu_res_sel_add   = 1'b1;
   wire        rfe_apsr_en           = rfe_cyc_2 & ~fault_q;
   wire        rfe_apsr_sel_rfe      = 1'b1;
   wire        rfe_atomic_en         = rfe_cyc_4 & ~rfe_chain;
   wire        rfe_aux_en            = rfe_cyc_2 | rfe_chain;
   wire        rfe_aux_sel_add       = 1'b1;
   wire        rfe_base_en           = rfe_cyc_1;
   wire        rfe_base_sel_word     = 1'b1;

   wire        rfe_extend_en         = ( rfe_cyc_2 & ~fault_q |
                                         rfe_cyc_4 );

   wire        rfe_extend_nxt        = rfe_cyc_4 | bus_rdata[9];
   wire        rfe_fetch_stall       = 1'b1;
   wire        rfe_force_user        = iaex_q[2] & npriv_q;

   wire        rfe_hdf_lock_en       = ( rfe_cyc_1 |
                                         fault_q & rfe_cyc_2 & ~spsel_q |
                                         fault_q & rfe_cyc_4 & n_or_h_active );

   wire        rfe_hdf_lock_nxt      = ~rfe_cyc_1;
   wire        rfe_hdf_req           = fault_q;
   wire        rfe_iaex_hold         = ~rfe_cyc_4 | rfe_chain;
   wire        rfe_iaex_nsel_inc     = 1'b1;
   wire        rfe_iaex_sel_bus      = ~fault_q;
   wire        rfe_iaex_sel_add      = fault_q;
   wire        rfe_ipsr_en           = rfe_cyc_2 | rfe_cyc_5;
   wire        rfe_ipsr_sel_bus      = ~iaex_q[2] & ~rfe_cyc_5;
   wire        rfe_ipsr_sel_vector   = rfe_cyc_5;
   wire        rfe_list_en           = rfe_cyc_3;
   wire        rfe_list_sel_irq      = 1'b1;
   wire        rfe_ls_multi          = 1'b1;
   wire        rfe_ls_trans          = ~rfe_cyc_4 & ~rfe_cyc_2 & ~rfe_chain;
   wire        rfe_nmi_lock_en       = rfe_cyc_1;
   wire        rfe_offset_en         = (~rfe_cyc_4 | rfe_chain) & ~rfe_cyc_5;
   wire        rfe_offset_sel_one    = rfe_cyc_3 & ~rfe_chain;
   wire        rfe_offset_sel_eight  = rfe_chain;

   wire        rfe_offset_sel_inc    = (( rfe_cyc_1 |
                                          rfe_cyc_2 & ~rfe_sleep ) &
                                        ~rfe_chain );

   wire        rfe_op_hold           = 1'b1;
   wire        rfe_opa_sel_ra        = 1'b1;
   wire        rfe_opb_sel_28        = rfe_cyc_1;
   wire        rfe_opb_sel_32        = rfe_cyc_4 & ~rfe_chain;
   wire        rfe_ra_addr_hold      = 1'b1;
   wire        rfe_rb_addr_nsel_pdec = 1'b1;
   wire        rfe_rfe_ack           = rfe_cyc_1;

   wire        rfe_state_en_std      = ( ( rfe_cyc_2 & rfe_sleep |
                                           rfe_cyc_3 |
                                           rfe_cyc_4 ) & ~rfe_chain |
                                         rfe_cyc_5 );

   wire        rfe_state_sel_irq     = rfe_cyc_5;
   wire        rfe_state_sel_ldm     = rfe_cyc_3 & ~rfe_chain;
   wire        rfe_state_sel_pfu     = rfe_cyc_4 & ~rfe_chain;
   wire        rfe_state_sel_wfx     = rfe_cyc_2 & ~rfe_chain;
   wire        rfe_tbit_en           = rfe_cyc_2 & ~fault_q;
   wire        rfe_tbit_sel_rfe      = 1'b1;
   wire        rfe_unalign_dword     = 1'b1;
   wire        rfe_wic_clear         = rfe_cyc_3;
   wire        rfe_wr_addr_sel_r14   = rfe_chain;
   wire        rfe_wr_data_sel_ret   = rfe_chain;
   wire        rfe_wr_data_sel_alu   = ~rfe_chain;
   wire        rfe_wr_en_std         = rfe_cyc_4 | rfe_chain;

   // -------------------------------------------------------------------------
   // Wait for interrupt / event state sequencer
   // -------------------------------------------------------------------------

   // The WFX state manages all sleeping activity within the processor.
   // The extend_q register indicates whether the instruction was a WFE vs a
   // WFI, with atomic_q being set indicating that this is a SLEEPONEXIT.
   // Cycle 4 is entered directly from a WFI/WFE instruction for which no
   // sleeping is required (i.e. an interrupt is already set and masked, or an
   // event is already registered). All other cycles result in the SLEEPING
   // output potentially becoming set and provide interaction with the
   // SLEEPHOLDREQn input.

   wire        wfx_cyc_1 = offset_q[1:0] == 2'b00;  // offset_q == 0
   wire        wfx_cyc_2 = offset_q[1:0] == 2'b01;  // offset_q == 1
   // Note:    wfx_cyc_3 = offset_q[1:0] == 2'b10;  // offset_q == 2
   wire        wfx_cyc_4 = offset_q[1:0] == 2'b11;  // offset_q == 3

   // --------

   wire        wfx_i_not_e = atomic_q | extend_q;

   wire        wfx_wake_up = ( nvm_wfi_advance_i & wfx_i_not_e |
                               nvm_wfe_advance_i & ~wfx_i_not_e |
                               dbg_halt_req |
                               int_ready_q );

   wire        wfx_lock   = wfx_cyc_2 & ~sleep_hold_req_n_i & ~wfx_wake_up;
   wire        wfx_unlock = sleep_lock_q & sleep_hold_req_n_i;
   wire        wfx_finish = wfx_wake_up & ~sleep_lock_q;

   wire        wfx_exit   = ( wfx_cyc_4 |
                              wfx_cyc_1 & (~atomic_q | wfx_wake_up) );

   // --------

   wire        wfx_event_clear    = ~wfx_i_not_e & (wfx_cyc_4 | wfx_cyc_1);
   wire        wfx_ex_idle        = wfx_cyc_2;
   wire        wfx_fetch_stall    = ~wfx_cyc_4 & ~wfx_cyc_1 | atomic_q;

   wire        wfx_iaex_hold      = ( ~( wfx_cyc_1 |
                                         wfx_cyc_4 |
                                         ~sleep_lock_q & int_ready_q ) |
                                      atomic_q );

   wire        wfx_offset_en      = ~wfx_cyc_2 | wfx_finish;
   wire        wfx_offset_sel_inc = ~wfx_exit;
   wire        wfx_offset_sel_two = wfx_exit;
   wire        wfx_op_hold        = 1'b1;
   wire        wfx_pdec_sel_old   = 1'b1;
   wire        wfx_ra_addr_hold   = 1'b1;
   wire        wfx_rb_addr_hold   = 1'b1;
   wire        wfx_sleep_lock_en  = wfx_lock | wfx_unlock;
   wire        wfx_sleep_lock_nxt = wfx_lock;
   wire        wfx_state_en_std   = wfx_exit;
   wire        wfx_state_sel_exe  = ~atomic_q;
   wire        wfx_state_sel_rfe  = atomic_q;
   wire        wfx_wfe_execute    = ~wfx_i_not_e;
   wire        wfx_wfi_execute    = wfx_i_not_e;
   wire        wfx_wic_clear      = wfx_cyc_4 | wfx_cyc_1 & ~atomic_q;
   wire        wfx_wic_load       = wfx_cyc_1 & atomic_q;

   // -------------------------------------------------------------------------
   // Multi-cycle iterative multiplier state
   // -------------------------------------------------------------------------

   // The MUL state is only used by the iterative multiplier implementation.
   // The iteration is controlled by the combination of offset_q (which counts
   // to 16 twice) and list_q.

   wire        mul_cyc_16, mul_cyc_32, mul_cyc_n32;

   generate
      if((CBAW != 0) || (SMUL != 0)) begin : gen_smul_2a

         wire   offset_max  = offset_q == 4'b1111;
         assign mul_cyc_16  = cfg_smul & offset_max & list_q[0];
         assign mul_cyc_32  = cfg_smul & offset_max & ~list_q[0];
         assign mul_cyc_n32 = cfg_smul & ~mul_cyc_32;

      end else begin : gen_smul_2b

         assign { mul_cyc_16, mul_cyc_32, mul_cyc_n32 } = 3'b0;

      end
   endgenerate

   // --------

   wire        mul_alu_res_sel_mul  = cfg_smul;
   wire        mul_apsr_en          = mul_cyc_32;
   wire        mul_apsr_sel_bit     = cfg_smul;
   wire        mul_aux_en           = mul_cyc_n32;
   wire        mul_aux_sel_mul1     = cfg_smul;
   wire        mul_fetch_stall      = mul_cyc_n32;
   wire        mul_iaex_hold        = mul_cyc_n32;
   wire        mul_list_en          = mul_cyc_16;
   wire        mul_offset_en        = mul_cyc_n32;
   wire        mul_offset_sel_inc   = cfg_smul;
   wire        mul_op_hold          = cfg_smul;
   wire        mul_opa_sel_aux      = cfg_smul;
   wire        mul_opb_sel_rb       = cfg_smul;
   wire        mul_pdec_sel_old     = cfg_smul;
   wire        mul_ra_addr_hold     = mul_cyc_n32;
   wire        mul_rb_addr_hold     = mul_cyc_n32;
   wire        mul_ror_amt_sel_left = cfg_smul;
   wire        mul_rot_amt_sel_mul  = cfg_smul;
   wire        mul_shf_left         = cfg_smul;
   wire        mul_state_en_std     = mul_cyc_32;
   wire        mul_state_sel_exe    = cfg_smul;
   wire        mul_wr_en_std        = mul_cyc_32;
   wire        mul_wr_data_sel_alu  = mul_cyc_32;

   // -------------------------------------------------------------------------
   // Lockup state
   // -------------------------------------------------------------------------

   // The architecture defines a Lockup mechanism that appears to continuously
   // fetch from 0xFFFFFFFF. This address is guaranteed to always pre-fetch
   // fault, so instead the core just quiesces to reduce power consumption and
   // to ensure that bus access speculation doesn't interfere with debugger
   // accesses.

   // Lockup state is exited if a halt request is made, or, in the case of a
   // Lockup at HardFault priority, if an NMI becomes pended; the NMI case is
   // handled via the generic preemption scheme.

   // Exiting to halt is performed by issuing a re-fetch of the current
   // instruction, which will enter halted state if the halt request is still
   // active by the time the fetch completes, or will simply re-enter Lockup
   // as a result of the fetch from 0xFFFFFFFF faulting in the case where the
   // halt request somehow vanishes before being acted upon.

   wire        lck_extend_en     = dbg_halt_req;
   wire        lck_extend_nxt    = 1'b1;
   wire        lck_fetch_stall   = 1'b1;
   wire        lck_iaex_hold     = 1'b1;
   wire        lck_op_hold       = 1'b1;
   wire        lck_ra_addr_hold  = 1'b1;
   wire        lck_rb_addr_hold  = 1'b1;
   wire        lck_state_en_std  = dbg_halt_req;
   wire        lck_state_sel_pfu = 1'b1;

   // -------------------------------------------------------------------------
   // Alternative ISA execution decode
   // -------------------------------------------------------------------------

   // The processor fundamentally handles three instruction sets. The first is
   // the ARMv6-M Thumb ISA; the second is a compact encoding for various
   // exceptions, such as prefetch faults, T-bit errors and breakpoints; and
   // the third is for managing debug requests for register reads and writes.

   // The second (ALT state) instruction set uses the top four bits of the
   // opcode in various arrangements.

   // -------------------------------------------------------------------------
   // Fetch data massaging
   // -------------------------------------------------------------------------

   // At fetch time, alternative opcodes relating to T-bit not being set, all
   // prefetch faults and breakpointed instructions are generated. Prefetch
   // faults take priority over breakpoints, and breakpoints take priority
   // over T-bit errors. Alternative encodings are identified by the special
   // bit (op_s_q / iq_s_q) being set to one. Bits[13:12] are forced to zero
   // as these are used by later stages to implement "Idle" and "Halt" type
   // requests.

   //                SPECIAL  OPCODE
   //   Instruction  0        <opcode>   - Opcode as per ARMv6-M ARM ARM
   //   Breakpoint   1        1000....0
   //   Fault        1        0100....0
   //   T-bit error  1        0000....0

   wire        debug_hi = bpu_match[1];
   wire        debug_lo = bpu_match[0];

   wire        special_hi = fault_q | debug_hi | ~tbit_q;
   wire        special_lo = fault_q | debug_lo | ~tbit_q;

   wire [16:0] fe_data_hi = { special_hi,
                              ( hrdata_i[31:28] & {4{~special_hi}} |
                                {debug_hi & ~fault_q, fault_q, 2'b0} ),
                              hrdata_i[27:16] & {12{~fault_q}} };

   wire [16:0] fe_data_lo = { special_lo,
                              ( hrdata_i[15:12] & {4{~special_lo}} |
                                {debug_lo & ~fault_q, fault_q, 2'b0} ),
                              hrdata_i[11:0] & {12{~fault_q}} };

   // -------------------------------------------------------------------------
   // Alternative opcode decoding
   // -------------------------------------------------------------------------

   // Instruction pre-fetch-faults, breakpoint unit hits, debug halt requests
   // and idle cycle insertions are all handled via the execution of special
   // instructions.

   // For 32-bit instructions, if op_s_q isn't set, then the special opcode is
   // held in iq_q rather than in op_q. The format of the opcode, irrespective
   // of which buffer it is held in, is "BFIH_xxxx_xxxx_xxxx" where:

   //  B - indicates that the fetch for this half-word hit in the BPU,
   //  F - indicates that the fetch for this half-word faulted,
   //  I - indicates that this instruction should be forced idle and re-issued,
   //  H - indicates a pending request to halt.

   // The idle type exists purely to permit the debugger to be able to perform
   // a transaction if it has been waiting for a long time. The debugger is
   // not permitted to perform a transaction if an AHB error is currently
   // being generated, so remain in this state whilst fault_q is set.

   // The iq_q register is also used as the interrupt jitter timer.
   // The interrupt jitter timer can be momentarily copied from iq_q into op_q
   // during the interrupt entry sequence if a waited debugger access causes
   // iq_q (free running) to be updated before op_q (hready) is updated.
   // When iq_q or op_q holds the interrupt jitter timer, both B and F are set.

   wire [3:0]  alt_bfih  = op_s_q ? op_q[15:12] : {iq_q[15:14], 2'b0};

   wire        alt_irq   = alt_bfih[3:2] == 2'b11;
   wire        alt_break = alt_bfih[3:0] == 4'b1000;
   wire        alt_idle  = alt_bfih[1:0] == 2'b10;
   wire        alt_halt  = alt_bfih[0];

   wire        alt_fault = ~(alt_break | alt_idle | alt_halt | alt_irq);

   // -----------

   wire        alt_lockup    = alt_fault & n_or_h_active;
   wire        alt_hardfault = alt_fault & ~n_or_h_active;
   wire        alt_do_halt   = alt_break | alt_halt;

   // -----------

   wire        alt_atomic_en     = alt_do_halt;
   wire        alt_atomic_nxt    = 1'b1;
   wire        alt_bpu_event     = alt_break & ~int_ready_q;
   wire        alt_extend_en     = 1'b1;
   wire        alt_extend_nxt    = 1'b1;
   wire        alt_fetch_stall   = 1'b1;
   wire        alt_hdf_req       = alt_hardfault & ~int_ready_q;
   wire        alt_iaex_hold     = ~alt_lockup;
   wire        alt_iaex_is_seq   = alt_idle;
   wire        alt_iaex_sel_add  = alt_lockup;
   wire        alt_op_hold       = 1'b1;
   wire        alt_opb_inv       = 1'b1;
   wire        alt_preempt_force = alt_hardfault;
   wire        alt_ra_addr_hold  = 1'b1;
   wire        alt_rb_addr_hold  = 1'b1;
   wire        alt_state_en_std  = ~alt_idle | ~fault_q;
   wire        alt_state_sel_hlt = alt_do_halt;
   wire        alt_state_sel_pfu = alt_idle;
   wire        alt_state_sel_lck = alt_lockup;

   // -------------------------------------------------------------------------
   // Debug state control
   // -------------------------------------------------------------------------

   // Debug state is entered as the result of a halt request, or due to
   // execution of a BKPT or breakpointed instruction. The processor remains
   // in this state until the C_HALT bit is cleared. Whilst in HLT state,
   // writes by the debugger to the DCRSR, result in special debug opcodes
   // being pushed into op_q, and subsequently executed for the purpose of
   // reading/writing register to/from the auxiliary register, which in turn
   // appears as the DCRDR to the debugger.

   wire [15:0] dbg_opcode;
   wire        hlt_apsr_en, hlt_atomic_en, hlt_aux_en, hlt_aux_sel_control;
   wire        hlt_aux_sel_epsr, hlt_aux_sel_iaex, hlt_aux_sel_misc;
   wire        hlt_aux_sel_ra, hlt_extend_en, hlt_extend_nxt, hlt_fetch_stall;
   wire        hlt_hlt_ack, hlt_iaex_hold, hlt_iaex_nsel_inc, hlt_iaex_sel_rb;
   wire        hlt_int_mask, hlt_ipsr_en, hlt_npriv_en, hlt_op_hold;
   wire        hlt_op_nuse_auto, hlt_op_sel_dbg, hlt_primask_en;
   wire        hlt_ra_addr_hold, hlt_rb_addr_hold, hlt_rb_addr_nsel_pdec;
   wire        hlt_rb_addr_sel_aux, hlt_sp_main_en, hlt_sp_process_en;
   wire        hlt_spsel_en, hlt_state_en_std, hlt_state_sel_pfu, hlt_tbit_en;
   wire        hlt_wr_data_sel_apsr, hlt_wr_data_sel_aux, hlt_wr_data_sel_ipsr;
   wire        hlt_wr_data_sel_msp, hlt_wr_data_sel_primask;
   wire        hlt_wr_data_sel_psp, hlt_wr_en_std;

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_2a

         // --------
         // Map DCRSR fields to future opcode bits:

         assign dbg_opcode =  { 4'b0100,          // 15:12
                                dif_wdata[16],    // 11    = REGWnR
                                2'b10,            // 10:9
                                dif_wdata[4:3],   // 8:7   = REGSEL<4:3>
                                4'b0000,          // 6:3
                                dif_wdata[2:0] }; // 2:0   = REGSEL<2:0>

         // --------
         // Subsequently extract DCRSR requested behavior from op_q, when
         // requested to do so by the debug domain via dbg_op_run.

         wire        hlt_rd  = ~op_q[11] & dbg_op_run; // Debugger read
         wire        hlt_wr  = op_q[11] & dbg_op_run;  // Debugger write
         wire [4:0]  hlt_rs  = {op_q[8:7], op_q[2:0]}; // REGSEL <4:0>

         wire        hlt_pc  = hlt_rs[3:0] == 4'b1111;
         wire        hlt_psr = hlt_rs[2:0] == 3'b000;

         wire        hlt_rd_psr = hlt_rd & hlt_rs[4] & hlt_psr;
         wire        hlt_wr_psr = hlt_wr & hlt_rs[4] & hlt_psr;
         wire        hlt_wr_ctl = hlt_wr & hlt_rs[4] & hlt_rs[2];
         wire        hlt_rd_ctl = hlt_rd & hlt_rs[4] & hlt_rs[2];

         // --------

         assign hlt_apsr_en             = hlt_wr_psr;
         assign hlt_atomic_en           = ~dbg_halt_req;
         assign hlt_aux_en              = hlt_rd | msl_dbg_aux_en;
         assign hlt_aux_sel_control     = hlt_rd_ctl;
         assign hlt_aux_sel_epsr        = hlt_rd_psr;
         assign hlt_aux_sel_iaex        = hlt_rd & ~hlt_rs[4] & hlt_pc;
         assign hlt_aux_sel_misc        = hlt_rd & hlt_rs[4];
         assign hlt_aux_sel_ra          = hlt_rd & ~hlt_rs[4] & ~hlt_pc;
         assign hlt_fetch_stall         = 1'b1;
         assign hlt_extend_en           = ~dbg_halt_req;
         assign hlt_extend_nxt          = 1'b1;
         assign hlt_hlt_ack             = 1'b1;
         assign hlt_iaex_hold           = ~(hlt_wr & ~hlt_rs[4] & hlt_pc);
         assign hlt_iaex_nsel_inc       = 1'b1;
         assign hlt_iaex_sel_rb         = 1'b1;
         assign hlt_int_mask            = 1'b1;
         assign hlt_ipsr_en             = vect_clr_active;
         assign hlt_npriv_en            = hlt_wr_ctl;
         assign hlt_primask_en          = hlt_wr_ctl;
         assign hlt_op_hold             = ~msl_dbg_op_en;
         assign hlt_op_nuse_auto        = 1'b1;
         assign hlt_op_sel_dbg          = 1'b1;
         assign hlt_ra_addr_hold        = ~msl_dbg_op_en;
         assign hlt_rb_addr_hold        = ~msl_dbg_op_en;
         assign hlt_rb_addr_nsel_pdec   = 1'b1;
         assign hlt_rb_addr_sel_aux     = 1'b1;
         assign hlt_sp_main_en          = hlt_wr & hlt_rs[4] & hlt_rs[0];
         assign hlt_sp_process_en       = hlt_wr & hlt_rs[4] & hlt_rs[1];
         assign hlt_spsel_en            = hlt_wr_ctl & ~handler;
         assign hlt_state_en_std        = ~dbg_halt_req;
         assign hlt_state_sel_pfu       = 1'b1;
         assign hlt_tbit_en             = hlt_wr_psr;
         assign hlt_wr_data_sel_aux     = 1'b1;
         assign hlt_wr_data_sel_apsr    = hlt_rd_psr;
         assign hlt_wr_data_sel_ipsr    = hlt_rd_psr;
         assign hlt_wr_data_sel_msp     = hlt_rd & hlt_rs[0];
         assign hlt_wr_data_sel_primask = hlt_rd_ctl;
         assign hlt_wr_data_sel_psp     = hlt_rd & hlt_rs[1];
         assign hlt_wr_en_std           = hlt_wr & ~hlt_rs[4];

      end else begin : gen_dbg_2b

         wire [36:0] unused = { dbg_halt_req, dbg_op_run, dif_wdata[31:0],
                                msl_dbg_aux_en, msl_dbg_op_en,
                                vect_clr_active };

         assign { dbg_opcode[15:0], hlt_apsr_en, hlt_atomic_en, hlt_aux_en,
                  hlt_aux_sel_control, hlt_aux_sel_epsr, hlt_aux_sel_iaex,
                  hlt_aux_sel_misc, hlt_aux_sel_ra, hlt_extend_en,
                  hlt_extend_nxt, hlt_fetch_stall, hlt_hlt_ack, hlt_iaex_hold,
                  hlt_iaex_nsel_inc, hlt_iaex_sel_rb, hlt_int_mask,
                  hlt_ipsr_en, hlt_npriv_en, hlt_op_hold, hlt_op_nuse_auto,
                  hlt_op_sel_dbg, hlt_primask_en, hlt_ra_addr_hold,
                  hlt_rb_addr_hold, hlt_rb_addr_nsel_pdec, hlt_rb_addr_sel_aux,
                  hlt_sp_main_en, hlt_sp_process_en, hlt_spsel_en,
                  hlt_state_en_std, hlt_state_sel_pfu, hlt_tbit_en,
                  hlt_wr_data_sel_apsr, hlt_wr_data_sel_aux,
                  hlt_wr_data_sel_ipsr, hlt_wr_data_sel_msp,
                  hlt_wr_data_sel_primask, hlt_wr_data_sel_psp,
                  hlt_wr_en_std } = 55'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Determine current state of the processor
   // -------------------------------------------------------------------------

   // The current state of the processor is determined by state_q, aux_q and
   // the respective values of the op_s_q and iq_s_q bits. In addition, for
   // implementations without debug or the iterative multiplier, neither the
   // HLT or SMUL states are reachable (respectively).

   wire        run_hlt;  // always false if debug is not implemented

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_3a
         assign run_hlt  = cfg_dbg & (state_q == st_hlt);
      end else begin : gen_dbg_3b
         assign run_hlt = 1'b0;
      end
   endgenerate

   // --------

   wire        run_mul;  // always false if without iterative multiplier

   generate
      if((CBAW != 0) || (SMUL != 0)) begin : gen_smul_3a
         assign run_mul = cfg_smul & (state_q == st_mul);
      end else begin : gen_smul_3b
         assign run_mul = 1'b0;
      end
   endgenerate

   // --------
   // Decode states that are always present in the processor regardless of
   // implementation configuration.

   wire        run_alt = ( (state_q == st_exe) & op_s_q |  // Alternative ..
                           (state_q == st_t32) & iq_s_q ); // .. execution

   wire        run_exe = (state_q == st_exe) & ~op_s_q;  // Normal execution
   wire        run_irq = state_q == st_irq;              // Interrupt handling
   wire        run_lck = state_q == st_lck;              // Lockup
   wire        run_ldm = state_q == st_ldm;              // Load-multiple
   wire        run_ldr = state_q == st_ldr;              // Load-single
   wire        run_pfu = state_q == st_pfu;              // Pipeline refill
   wire        run_rfe = state_q == st_rfe;              // Exception return
   wire        run_rst = state_q == st_rst;              // Reset start-up
   wire        run_str = state_q == st_str;              // Store-single
   wire        run_stm = state_q == st_stm;              // Store-multiple
   wire        run_t32 = (state_q == st_t32) & ~iq_s_q;  // Post-fix execution
   wire        run_wfx = state_q == st_wfx;              // Wait for stimulus

   // -------------------------------------------------------------------------
   // Determine whether interrupt based preemption should occur
   // -------------------------------------------------------------------------

   // Preemption into interrupt state can be forced via a request from the
   // decoder for the currently executing state, or generate as the result of
   // an interrupt becoming pending outside of an atomic or sleep-locked state.

   wire        preempt_force = ( run_ldr & ldr_preempt_force |
                                 run_str & str_preempt_force |
                                 run_exe & exe_preempt_force |
                                 run_t32 & t32_preempt_force |
                                 run_ldm & ldm_preempt_force |
                                 run_stm & stm_preempt_force |
                                 run_alt & alt_preempt_force );

   wire        preempt = ( int_ready_q & ~atomic_q & ~sleep_lock_q |
                           preempt_force );

   // -------------------------------------------------------------------------
   // Construct intermediate consolidated control for configurable multiplier
   // -------------------------------------------------------------------------

   // Large amounts of control are redundant if the iterative multiplier is not
   // implemented. Control relating to the first EXE state cycle and subsequent
   // MUL state iterative cycles is generated only if required.

   wire        aux_sel_mul0, aux_sel_mul1, rot_amt_sel_mul;
   wire        run_exe_list_sel_irq, run_exe_mul_en, run_exe_state_sel_mul;
   wire        run_mul_alu_res_sel_mul, run_mul_apsr_en, run_mul_apsr_sel_bit;
   wire        run_mul_aux_en, run_mul_fetch_stall, run_mul_iaex_hold;
   wire        run_mul_list_en, run_mul_offset_en, run_mul_offset_sel_inc;
   wire        run_mul_op_hold, run_mul_opa_sel_aux, run_mul_opb_sel_rb;
   wire        run_mul_pdec_sel_old, run_mul_ra_addr_hold;
   wire        run_mul_rb_addr_hold, run_mul_ror_amt_sel_left;
   wire        run_mul_shf_left, run_mul_state_en_std, run_mul_state_sel_exe;
   wire        run_mul_wr_data_sel_alu, run_mul_wr_en_std;

   generate
      if((CBAW != 0) || (SMUL != 0)) begin : gen_smul_4a

         wire is_exe = cfg_smul & run_exe;
         wire is_mul = cfg_smul & run_mul;

         assign aux_sel_mul0             = is_exe & exe_aux_sel_mul0;
         assign aux_sel_mul1             = is_mul & mul_aux_sel_mul1;
         assign rot_amt_sel_mul          = is_mul & mul_rot_amt_sel_mul;
         assign run_exe_list_sel_irq     = is_exe & exe_list_sel_irq;
         assign run_exe_state_sel_mul    = is_exe & exe_state_sel_mul;
         assign run_mul_alu_res_sel_mul  = is_mul & mul_alu_res_sel_mul;
         assign run_mul_apsr_en          = is_mul & mul_apsr_en;
         assign run_mul_apsr_sel_bit     = is_mul & mul_apsr_sel_bit;
         assign run_mul_aux_en           = is_mul & mul_aux_en;
         assign run_mul_fetch_stall      = is_mul & mul_fetch_stall;
         assign run_mul_iaex_hold        = is_mul & mul_iaex_hold;
         assign run_mul_list_en          = is_mul & mul_list_en;
         assign run_mul_offset_en        = is_mul & mul_offset_en;
         assign run_mul_offset_sel_inc   = is_mul & mul_offset_sel_inc;
         assign run_mul_op_hold          = is_mul & mul_op_hold;
         assign run_mul_opa_sel_aux      = is_mul & mul_opa_sel_aux;
         assign run_mul_opb_sel_rb       = is_mul & mul_opb_sel_rb;
         assign run_mul_pdec_sel_old     = is_mul & mul_pdec_sel_old;
         assign run_mul_ra_addr_hold     = is_mul & mul_ra_addr_hold;
         assign run_mul_rb_addr_hold     = is_mul & mul_rb_addr_hold;
         assign run_mul_ror_amt_sel_left = is_mul & mul_ror_amt_sel_left;
         assign run_mul_shf_left         = is_mul & mul_shf_left;
         assign run_mul_state_en_std     = is_mul & mul_state_en_std;
         assign run_mul_state_sel_exe    = is_mul & mul_state_sel_exe;
         assign run_mul_wr_data_sel_alu  = is_mul & mul_wr_data_sel_alu;
         assign run_mul_wr_en_std        = is_mul & mul_wr_en_std;

         assign run_exe_mul_en           = ~cfg_smul & run_exe & exe_mul_en;

      end else begin : gen_smul_4b

         wire [26:0] unused = { exe_aux_sel_mul0, exe_list_sel_irq,
                                exe_state_sel_mul, mul_apsr_en,
                                mul_apsr_sel_bit, mul_alu_res_sel_mul,
                                mul_aux_en, mul_aux_sel_mul1, mul_fetch_stall,
                                mul_iaex_hold, mul_list_en, mul_offset_sel_inc,
                                mul_offset_en, mul_op_hold, mul_opa_sel_aux,
                                mul_opb_sel_rb, mul_pdec_sel_old,
                                mul_ra_addr_hold, mul_rb_addr_hold,
                                mul_ror_amt_sel_left, mul_rot_amt_sel_mul,
                                mul_shf_left, mul_state_en_std,
                                mul_state_sel_exe, mul_wr_data_sel_alu,
                                mul_wr_en_std, run_mul };

         assign { aux_sel_mul0, aux_sel_mul1, rot_amt_sel_mul,
                  run_exe_list_sel_irq, run_exe_state_sel_mul,
                  run_mul_alu_res_sel_mul, run_mul_apsr_en,
                  run_mul_apsr_sel_bit, run_mul_aux_en, run_mul_fetch_stall,
                  run_mul_iaex_hold, run_mul_list_en, run_mul_offset_en,
                  run_mul_offset_sel_inc, run_mul_op_hold, run_mul_opa_sel_aux,
                  run_mul_opb_sel_rb, run_mul_pdec_sel_old,
                  run_mul_ra_addr_hold, run_mul_rb_addr_hold,
                  run_mul_ror_amt_sel_left, run_mul_shf_left,
                  run_mul_state_en_std, run_mul_state_sel_exe,
                  run_mul_wr_data_sel_alu, run_mul_wr_en_std } = 26'b0;

         assign run_exe_mul_en = run_exe & exe_mul_en;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Consolidate control signals from all states
   // -------------------------------------------------------------------------

   // All of the remaining control signals are consolidated from the product
   // of the current state and each states local version of each control
   // signal. In the presence of a preemption, the control signals are
   // coerced to ensure that no new load/store transaction is issued to the
   // bus, and that the register pointers and offset registers are correctly
   // set for the first cycle of IRQ state. Control signals relating to single
   // cycle data-processing instructions are left unaltered so as to allow
   // these instructions to complete before taking the interrupt.

   wire        align_dword         = ( run_irq & irq_align_dword );
   wire        align_half          = ( run_exe & exe_align_half );
   wire        align_word          = ( run_exe & exe_align_word );

   wire        alu_res_sel_add     = ( run_exe & exe_alu_res_sel_add |
                                       run_irq & irq_alu_res_sel_add |
                                       run_rfe & rfe_alu_res_sel_add |
                                       run_stm & stm_alu_res_sel_add |
                                       run_t32 & t32_alu_res_sel_add );

   wire        alu_res_sel_and     = ( run_exe & exe_alu_res_sel_and );
   wire        alu_res_sel_eor     = ( run_exe & exe_alu_res_sel_eor );
   wire        alu_res_sel_mul     = run_mul_alu_res_sel_mul;

   wire        apsr_en             = ( run_exe & exe_apsr_en |
                                       run_hlt & hlt_apsr_en |
                                       run_mul_apsr_en |
                                       run_rfe & rfe_apsr_en |
                                       run_t32 & t32_apsr_en );

   wire        apsr_sel_add        = ( run_exe & exe_apsr_sel_add );

   wire        apsr_sel_bit        = ( run_exe & exe_apsr_sel_bit |
                                       run_mul_apsr_sel_bit );

   wire        apsr_sel_rb         = ( run_t32 & t32_apsr_sel_rb );
   wire        apsr_sel_rfe        = ( run_rfe & rfe_apsr_sel_rfe );
   wire        apsr_sel_rot        = ( run_exe & exe_apsr_sel_rot );

   wire        atomic_en           = ( run_alt & alt_atomic_en |
                                       run_exe & exe_atomic_en |
                                       run_hlt & hlt_atomic_en |
                                       run_irq & irq_atomic_en |
                                       run_ldm & ldm_atomic_en |
                                       run_rfe & rfe_atomic_en |
                                       run_rst & rst_atomic_en |
                                       preempt );

   wire        atomic_nxt          = ( run_alt & alt_atomic_nxt |
                                       run_exe & exe_atomic_nxt |
                                       run_ldm & ldm_atomic_nxt |
                                       preempt );

   wire        aux_en              = ( run_exe & exe_aux_en |
                                       run_hlt & hlt_aux_en |
                                       run_irq & irq_aux_en |
                                       run_mul_aux_en |
                                       run_rfe & rfe_aux_en |
                                       run_stm & stm_aux_en );

   wire        aux_sel_add         = ( run_exe & exe_aux_sel_add |
                                       run_irq & irq_aux_sel_add |
                                       run_rfe & rfe_aux_sel_add );

   wire        aux_sel_control     = ( run_hlt & hlt_aux_sel_control );

   wire        aux_sel_epsr        = ( run_hlt & hlt_aux_sel_epsr |
                                       run_irq & irq_aux_sel_epsr );

   wire        aux_sel_iaex        = ( run_hlt & hlt_aux_sel_iaex |
                                       run_stm & stm_aux_sel_iaex );

   wire        aux_sel_misc        = ( run_hlt & hlt_aux_sel_misc |
                                       run_irq & irq_aux_sel_misc );

   wire        aux_sel_ra          = ( run_exe & exe_aux_sel_ra |
                                       run_hlt & hlt_aux_sel_ra );

   wire        base_en             = ( run_exe & exe_base_en |
                                       run_irq & irq_base_en |
                                       run_rfe & rfe_base_en |
                                       run_rst & rst_base_en );

   wire        base_sel_byte       = ( run_exe & exe_base_sel_byte );
   wire        base_sel_half       = ( run_exe & exe_base_sel_half );

   wire        base_sel_word       = ( run_exe & exe_base_sel_word |
                                       run_irq & irq_base_sel_word |
                                       run_rfe & rfe_base_sel_word |
                                       run_rst & rst_base_sel_word );

   wire        bpu_event           = ((run_alt & alt_bpu_event |
                                       run_exe & exe_bpu_event ) &
                                      ~preempt);

   wire        c_gt_32_sel_nf      = ( run_exe & exe_c_gt_32_sel_nf );
   wire        c_gt_32_sel_31      = ( run_exe & exe_c_gt_32_sel_31 );
   wire        c_le_32_sel_00      = ( run_exe & exe_c_le_32_sel_00 );
   wire        c_le_32_sel_31      = ( run_exe & exe_c_le_32_sel_31 );
   wire        dbg_no_trans        = ( run_exe & exe_dbg_no_trans );
   wire        ex_idle             = ( run_wfx & wfx_ex_idle );

   wire        extend_en           = ( run_alt & alt_extend_en |
                                       run_exe & exe_extend_en |
                                       run_hlt & hlt_extend_en |
                                       run_irq & irq_extend_en |
                                       run_lck & lck_extend_en |
                                       run_ldm & ldm_extend_en |
                                       run_pfu & pfu_extend_en |
                                       run_rfe & rfe_extend_en |
                                       run_rst & rst_extend_en );

   wire        extend_nxt          = ( run_alt & alt_extend_nxt |
                                       run_exe & exe_extend_nxt |
                                       run_hlt & hlt_extend_nxt |
                                       run_irq & irq_extend_nxt |
                                       run_lck & lck_extend_nxt |
                                       run_ldm & ldm_extend_nxt |
                                       run_rfe & rfe_extend_nxt |
                                       run_rst & rst_extend_nxt );

   wire        fe_use_add          = ((run_exe & exe_fe_use_add |
                                       run_t32 & t32_fe_use_add ) &
                                      ~preempt);

   wire        fe_use_iaex         = ( run_pfu & pfu_fe_use_iaex );
   wire        fe_use_rb           = ( run_exe & exe_fe_use_rb );

   wire        fetch_force         = ((run_exe & exe_fetch_force |
                                       run_pfu & pfu_fetch_force |
                                       run_t32 & t32_fetch_force ) &
                                      ~preempt);

   wire        fetch_stall         = ( run_alt & alt_fetch_stall |
                                       run_exe & exe_fetch_stall |
                                       run_hlt & hlt_fetch_stall |
                                       run_irq & irq_fetch_stall |
                                       run_lck & lck_fetch_stall |
                                       run_ldm & ldm_fetch_stall |
                                       run_mul_fetch_stall |
                                       run_pfu & pfu_fetch_stall |
                                       run_rfe & rfe_fetch_stall |
                                       run_rst & rst_fetch_stall |
                                       run_t32 & t32_fetch_stall |
                                       run_wfx & wfx_fetch_stall |
                                       preempt );

   wire        force_user          = ( run_rfe & rfe_force_user );
   wire        hdf_pend            = ( run_irq & irq_hdf_pend );

   wire        hdf_req             = ( run_alt & alt_hdf_req |
                                       run_exe & exe_hdf_req |
                                       run_irq & irq_hdf_req |
                                       run_ldm & ldm_hdf_req |
                                       run_ldr & ldr_hdf_req |
                                       run_rfe & rfe_hdf_req |
                                       run_stm & stm_hdf_req |
                                       run_str & str_hdf_req |
                                       run_t32 & t32_hdf_req );

   wire        hlt_ack             = ( run_hlt & hlt_hlt_ack );
   wire        fault_keep          = ( run_pfu & pfu_fault_keep );
   wire        iaex_en_io          = ( run_exe & exe_iaex_en_io );

   wire        iaex_hold           = ( run_alt & alt_iaex_hold |
                                       run_exe & exe_iaex_hold |
                                       run_hlt & hlt_iaex_hold |
                                       run_irq & irq_iaex_hold |
                                       run_lck & lck_iaex_hold |
                                       run_ldm & ldm_iaex_hold |
                                       run_ldr & ldr_iaex_hold |
                                       run_mul_iaex_hold |
                                       run_pfu & pfu_iaex_hold |
                                       run_rfe & rfe_iaex_hold |
                                       run_rst & rst_iaex_hold |
                                       run_stm & stm_iaex_hold |
                                       run_str & str_iaex_hold |
                                       run_t32 & t32_iaex_hold |
                                       run_wfx & wfx_iaex_hold );

   wire        iaex_is_seq         = ( run_alt & alt_iaex_is_seq |
                                       run_t32 & t32_iaex_is_seq );

   wire        iaex_nsel_inc       = ( run_exe & exe_iaex_nsel_inc |
                                       run_hlt & hlt_iaex_nsel_inc |
                                       run_irq & irq_iaex_nsel_inc |
                                       run_ldm & ldm_iaex_nsel_inc |
                                       run_rfe & rfe_iaex_nsel_inc |
                                       run_rst & rst_iaex_nsel_inc |
                                       run_t32 & t32_iaex_nsel_inc );

   wire        iaex_sel_add        = ( run_alt & alt_iaex_sel_add |
                                       run_exe & exe_iaex_sel_add |
                                       run_irq & irq_iaex_sel_add |
                                       run_ldm & ldm_iaex_sel_add |
                                       run_ldr & ldr_iaex_sel_add |
                                       run_rfe & rfe_iaex_sel_add |
                                       run_rst & rst_iaex_sel_add |
                                       run_stm & stm_iaex_sel_add |
                                       run_str & str_iaex_sel_add |
                                       run_t32 & t32_iaex_sel_add );

   wire        iaex_sel_bus        = ( run_irq & irq_iaex_sel_bus |
                                       run_ldm & ldm_iaex_sel_bus |
                                       run_rfe & rfe_iaex_sel_bus |
                                       run_rst & rst_iaex_sel_bus );

   wire        iaex_sel_rb         = ( run_exe & exe_iaex_sel_rb |
                                       run_hlt & hlt_iaex_sel_rb );

   wire        int_mask            = ( run_hlt & hlt_int_mask |
                                       run_rst & rst_int_mask );

   wire        int_resample        = ( run_irq & irq_int_resample );

   wire        ipsr_en             = ( run_rst & rst_ipsr_en |
                                       run_rfe & rfe_ipsr_en |
                                       run_hlt & hlt_ipsr_en |
                                       run_irq & irq_ipsr_en );

   wire        ipsr_free_en        = ( run_irq & irq_ipsr_free_en );
   wire        ipsr_sel_bus        = ( run_rfe & rfe_ipsr_sel_bus );

   wire        ipsr_sel_vector     = ( run_irq & irq_ipsr_sel_vector |
                                       run_rfe & rfe_ipsr_sel_vector );

   wire        iq_s_sel_one        = ( run_irq & irq_iq_s_sel_one );
   wire        iq_use_nxt          = ( run_exe & exe_iq_use_nxt );
   wire        irq_ack             = ( run_irq & irq_irq_ack );

   wire        list_en             = ( run_exe & exe_list_en |
                                       run_irq & irq_list_en |
                                       run_ldm & ldm_list_en |
                                       run_mul_list_en |
                                       run_stm & stm_list_en |
                                       run_rfe & rfe_list_en );

   wire        list_sel_op         = ( run_exe & exe_list_sel_op );

   wire        list_sel_irq        = ( run_exe_list_sel_irq |
                                       run_irq & irq_list_sel_irq |
                                       run_rfe & rfe_list_sel_irq );

   wire        list_sel_list       = ( run_ldm & ldm_list_sel_list |
                                       run_stm & stm_list_sel_list );

   wire        ls_fwd_io           = ( run_exe & exe_ls_fwd_io );

   wire        ls_multi            = ( run_exe & exe_ls_multi |
                                       run_irq & irq_ls_multi |
                                       run_ldm & ldm_ls_multi |
                                       run_rfe & rfe_ls_multi |
                                       run_rst & rst_ls_multi |
                                       run_stm & stm_ls_multi );

   wire        ls_trans            = ((run_exe & exe_ls_trans |
                                       run_irq & irq_ls_trans |
                                       run_ldm & ldm_ls_trans |
                                       run_rfe & rfe_ls_trans |
                                       run_rst & rst_ls_trans |
                                       run_stm & stm_ls_trans ) &
                                      ~preempt);

   wire        ls_use_iq           = ( run_irq & irq_ls_use_iq );
   wire        ls_use_ra           = ( run_exe & exe_ls_use_ra);

   wire        ls_use_vec          = ( run_irq & irq_ls_use_vec |
                                       run_rst & rst_ls_use_vec );

   wire        ls_write            = ( run_exe & exe_ls_write |
                                       run_irq & irq_ls_write |
                                       run_stm & stm_ls_write );

   wire        mtx_ctl_sel_rot     = ( run_exe & exe_mtx_ctl_sel_rot);

   wire        mtx_in_sel_bus      = ( run_exe & exe_mtx_in_sel_bus |
                                       run_ldm & ldm_mtx_in_sel_bus |
                                       run_ldr & ldr_mtx_in_sel_bus |
                                       run_rst & rst_mtx_in_sel_bus );

   wire        mtx_in_sel_rot      = ( run_exe & exe_mtx_in_sel_rot );

   wire        mtx_sel_use_load    = ( run_exe & exe_mtx_sel_use_load |
                                       run_ldm & ldm_mtx_sel_use_load |
                                       run_ldr & ldr_mtx_sel_use_load |
                                       run_rst & rst_mtx_sel_use_load );

   wire        mul_en              = run_exe_mul_en;

   wire        npriv_en            = ( run_hlt & hlt_npriv_en |
                                       run_t32 & t32_npriv_en );

   wire        npriv_sel_rb        = ( run_t32 & t32_npriv_sel_rb );

   wire        offset_en           = ( run_exe & exe_offset_en |
                                       run_irq & irq_offset_en |
                                       run_ldm & ldm_offset_en |
                                       run_mul_offset_en |
                                       run_rfe & rfe_offset_en |
                                       run_rst & rst_offset_en |
                                       run_stm & stm_offset_en |
                                       run_wfx & wfx_offset_en |
                                       preempt );

   wire        offset_sel_eight    = ((run_irq & irq_offset_sel_eight |
                                       run_ldm & ldm_offset_sel_eight |
                                       run_rfe & rfe_offset_sel_eight ) &
                                      ~preempt);

   wire        offset_sel_inc      = ((run_irq & irq_offset_sel_inc |
                                       run_ldm & ldm_offset_sel_inc |
                                       run_mul_offset_sel_inc |
                                       run_rfe & rfe_offset_sel_inc |
                                       run_rst & rst_offset_sel_inc |
                                       run_stm & stm_offset_sel_inc |
                                       run_wfx & wfx_offset_sel_inc ) &
                                      ~preempt);

   wire        offset_sel_one      = ( run_exe & exe_offset_sel_one |
                                       run_rfe & rfe_offset_sel_one |
                                       preempt );

   wire        offset_sel_two      = ((run_wfx & wfx_offset_sel_two ) &
                                      ~preempt);

   wire        op_hold             = ( run_alt & alt_op_hold |
                                       run_exe & exe_op_hold |
                                       run_hlt & hlt_op_hold |
                                       run_irq & irq_op_hold |
                                       run_lck & lck_op_hold |
                                       run_ldm & ldm_op_hold |
                                       run_ldr & ldr_op_hold |
                                       run_mul_op_hold |
                                       run_pfu & pfu_op_hold |
                                       run_rfe & rfe_op_hold |
                                       run_rst & rst_op_hold |
                                       run_stm & stm_op_hold |
                                       run_str & str_op_hold |
                                       run_t32 & t32_op_hold |
                                       run_wfx & wfx_op_hold |
                                       preempt );

   wire        op_nuse_auto        = ( run_pfu & pfu_op_nuse_auto |
                                       run_hlt & hlt_op_nuse_auto );

   wire        op_sel_dbg          = ( run_hlt & hlt_op_sel_dbg );
   wire        op_use_fetch        = ( run_pfu & pfu_op_use_fetch );
   wire        opa_mask_pc         = ( run_exe & exe_opa_mask_pc );

   wire        opa_sel_aux         = ( run_ldm & ldm_opa_sel_aux |
                                       run_mul_opa_sel_aux |
                                       run_stm & stm_opa_sel_aux );

   wire        opa_sel_pc          = ( run_exe & exe_opa_sel_pc |
                                       run_t32 & t32_opa_sel_pc |
                                       run_irq & irq_opa_sel_pc );

   wire        opa_sel_ra          = ( run_exe & exe_opa_sel_ra |
                                       run_irq & irq_opa_sel_ra |
                                       run_rfe & rfe_opa_sel_ra );

   wire        opb_inv             = ( run_exe & exe_opb_inv |
                                       run_rst & rst_opb_inv |
                                       run_ldr & ldr_opb_inv |
                                       run_str & str_opb_inv |
                                       run_irq & irq_opb_inv |
                                       run_stm & stm_opb_inv |
                                       run_ldm & ldm_opb_inv |
                                       run_t32 & t32_opb_inv |
                                       run_alt & alt_opb_inv );

   wire        opb_sel_28          = ( run_rfe & rfe_opb_sel_28 );

   wire        opb_sel_32          = ( run_irq & irq_opb_sel_32 |
                                       run_rfe & rfe_opb_sel_32 );

   wire        opb_sel_bl          = ( run_t32 & t32_opb_sel_bl );
   wire        opb_sel_four        = ( run_irq & irq_opb_sel_four );
   wire        opb_sel_imm3        = ( run_exe & exe_opb_sel_imm3 );
   wire        opb_sel_imm5_0      = ( run_exe & exe_opb_sel_imm5_0 );
   wire        opb_sel_imm5_1      = ( run_exe & exe_opb_sel_imm5_1 );
   wire        opb_sel_imm5_2      = ( run_exe & exe_opb_sel_imm5_2 );
   wire        opb_sel_imm7_2      = ( run_exe & exe_opb_sel_imm7_2 );
   wire        opb_sel_imm8        = ( run_exe & exe_opb_sel_imm8 );
   wire        opb_sel_imm8_2      = ( run_exe & exe_opb_sel_imm8_2 );
   wire        opb_sel_list        = ( run_exe & exe_opb_sel_list );

   wire        opb_sel_offset      = ( run_rst & rst_opb_sel_offset |
                                       run_ldm & ldm_opb_sel_offset |
                                       run_stm & stm_opb_sel_offset |
                                       run_irq & irq_opb_sel_offset );

   wire        opb_sel_pc          = ( run_exe & exe_opb_sel_pc );

   wire        opb_sel_rb          = ( run_exe & exe_opb_sel_rb |
                                       run_mul_opb_sel_rb );

   wire        opb_sel_simm11      = ( run_exe & exe_opb_sel_simm11 );
   wire        opb_sel_simm8       = ( run_exe & exe_opb_sel_simm8 );
   wire        opc_sel_apsr        = ( run_exe & exe_opc_sel_apsr );

   wire        opc_sel_one         = ( run_exe & exe_opc_sel_one |
                                       run_irq & irq_opc_sel_one );

   wire        perm_mtx_revb       = ( run_exe & exe_perm_mtx_revb );
   wire        perm_mtx_revh       = ( run_exe & exe_perm_mtx_revh );
   wire        perm_sgn_sel_7      = ( run_exe & exe_perm_sgn_sel_7 );
   wire        perm_sgn_sel_15     = ( run_exe & exe_perm_sgn_sel_15 );
   wire        perm_mtx_sgn_1      = ( run_exe & exe_perm_mtx_sgn_1 );
   wire        perm_mtx_sgn_32     = ( run_exe & exe_perm_mtx_sgn_32 );
   wire        perm_mtx_xt         = ( run_exe & exe_perm_mtx_xt );
   wire        pc_rel              = ( run_exe & exe_pc_rel );

   wire        pdec_sel_old        = ( run_exe & exe_pdec_sel_old |
                                       run_ldm & ldm_pdec_sel_old |
                                       run_ldr & ldr_pdec_sel_old |
                                       run_mul_pdec_sel_old |
                                       run_stm & stm_pdec_sel_old |
                                       run_str & str_pdec_sel_old |
                                       run_wfx & wfx_pdec_sel_old );

   wire        primask_en          = ( run_exe & exe_primask_en |
                                       run_hlt & hlt_primask_en |
                                       run_t32 & t32_primask_en );

   wire        primask_sel_op      = ( run_exe & exe_primask_sel_op );
   wire        primask_sel_rb      = ( run_t32 & t32_primask_sel_rb );

   wire        ra_addr_hold        = ((run_alt & alt_ra_addr_hold |
                                       run_exe & exe_ra_addr_hold |
                                       run_hlt & hlt_ra_addr_hold |
                                       run_irq & irq_ra_addr_hold |
                                       run_lck & lck_ra_addr_hold |
                                       run_ldm & ldm_ra_addr_hold |
                                       run_mul_ra_addr_hold |
                                       run_pfu & pfu_ra_addr_hold |
                                       run_rfe & rfe_ra_addr_hold |
                                       run_rst & rst_ra_addr_hold |
                                       run_stm & stm_ra_addr_hold |
                                       run_t32 & t32_ra_addr_hold |
                                       run_wfx & wfx_ra_addr_hold ) &
                                      ~preempt);

   wire        ra_addr_nsel_pdec   = ( run_exe & exe_ra_addr_nsel_pdec |
                                       preempt );

   wire        ra_addr_sel_r13     = ( run_exe & exe_ra_addr_sel_r13 |
                                       preempt );

   wire        rb_addr_hold        = ( run_alt & alt_rb_addr_hold |
                                       run_exe & exe_rb_addr_hold |
                                       run_hlt & hlt_rb_addr_hold |
                                       run_lck & lck_rb_addr_hold |
                                       run_mul_rb_addr_hold |
                                       run_pfu & pfu_rb_addr_hold |
                                       run_rst & rst_rb_addr_hold |
                                       run_t32 & t32_rb_addr_hold |
                                       run_wfx & wfx_rb_addr_hold |
                                       preempt );

   wire        rb_addr_nsel_pdec   = ( run_exe & exe_rb_addr_nsel_pdec |
                                       run_hlt & hlt_rb_addr_nsel_pdec |
                                       run_irq & irq_rb_addr_nsel_pdec |
                                       run_ldm & ldm_rb_addr_nsel_pdec |
                                       run_rfe & rfe_rb_addr_nsel_pdec |
                                       run_stm & stm_rb_addr_nsel_pdec );

   wire        rb_addr_sel_108     = ( run_exe & exe_rb_addr_sel_108 );
   wire        rb_addr_sel_30      = ( run_exe & exe_rb_addr_sel_30 );

   wire        rb_addr_sel_list    = ( run_exe & exe_rb_addr_sel_list |
                                       run_ldm & ldm_rb_addr_sel_list |
                                       run_stm & stm_rb_addr_sel_list );

   wire        rb_addr_sel_aux     = ( run_irq & irq_rb_addr_sel_aux |
                                       run_hlt & hlt_rb_addr_sel_aux |
                                       run_stm & stm_rb_addr_sel_aux );

   wire        rb_addr_sel_z20     = ( run_exe & exe_rb_addr_sel_z20 );
   wire        rfe_ack             = ( run_rfe & rfe_rfe_ack );

   wire        ror_amt_sel_left    = ( run_exe & exe_ror_amt_sel_left |
                                       run_mul_ror_amt_sel_left );

   wire        ror_amt_sel_right   = ( run_exe & exe_ror_amt_sel_right );
   wire        ror_force_msk       = ( run_exe & exe_ror_force_msk );
   wire        rot_amt_sel_rb      = ( run_exe & exe_rot_amt_sel_rb );
   wire        rot_amt_sel_imm     = ( run_exe & exe_rot_amt_sel_imm );
   wire        rot_sign_sel_ra31   = ( run_exe & exe_rot_sign_sel_ra31 );
   wire        event_set           = ( run_exe & exe_event_set );

   wire        shf_left            = ( run_exe & exe_shf_left |
                                       run_mul_shf_left );

   wire        shf_ror             = ( run_exe & exe_shf_ror );
   wire        sleep_lock_en       = ( run_wfx & wfx_sleep_lock_en );
   wire        sleep_lock_nxt      = ( run_wfx & wfx_sleep_lock_nxt );

   wire        sp_main_en          = ( run_hlt & hlt_sp_main_en |
                                       run_rst & rst_sp_main_en |
                                       run_t32 & t32_sp_main_en );

   wire        sp_process_en       = ( run_hlt & hlt_sp_process_en |
                                       run_t32 & t32_sp_process_en );

   wire        spsel_en            = ( run_exe & exe_spsel_en |
                                       run_hlt & hlt_spsel_en |
                                       run_irq & irq_spsel_en |
                                       run_ldm & ldm_spsel_en |
                                       run_t32 & t32_spsel_en );

   wire        spsel_sel_bus       = ( run_ldm & ldm_spsel_sel_bus );
   wire        spsel_sel_rb1       = ( run_t32 & t32_spsel_sel_rb1 );
   wire        spsel_sel_rb2       = ( run_exe & exe_spsel_sel_rb2 );

   wire        state_en_std        = ( run_alt & alt_state_en_std |
                                       run_exe & exe_state_en_std |
                                       run_hlt & hlt_state_en_std |
                                       run_irq & irq_state_en_std |
                                       run_lck & lck_state_en_std |
                                       run_ldm & ldm_state_en_std |
                                       run_ldr & ldr_state_en_std |
                                       run_mul_state_en_std |
                                       run_pfu & pfu_state_en_std |
                                       run_rfe & rfe_state_en_std |
                                       run_rst & rst_state_en_std |
                                       run_stm & stm_state_en_std |
                                       run_str & str_state_en_std |
                                       run_t32 & t32_state_en_std |
                                       run_wfx & wfx_state_en_std |
                                       preempt );

   wire        state_sel_exe       = ((run_pfu & pfu_state_sel_exe |
                                       run_wfx & wfx_state_sel_exe |
                                       run_ldr & ldr_state_sel_exe |
                                       run_str & str_state_sel_exe |
                                       run_mul_state_sel_exe |
                                       run_ldm & ldm_state_sel_exe |
                                       run_stm & stm_state_sel_exe ) &
                                      ~preempt);

   wire        state_sel_hlt       = ((run_alt & alt_state_sel_hlt |
                                       run_exe & exe_state_sel_hlt ) &
                                      ~preempt);

   wire        state_sel_irq       = ( run_rfe & rfe_state_sel_irq |
                                       run_stm & stm_state_sel_irq |
                                       preempt );

   wire        state_sel_lck       = ((run_ldr & ldr_state_sel_lck |
                                       run_str & str_state_sel_lck |
                                       run_exe & exe_state_sel_lck |
                                       run_t32 & t32_state_sel_lck |
                                       run_stm & stm_state_sel_lck |
                                       run_ldm & ldm_state_sel_lck |
                                       run_alt & alt_state_sel_lck ) &
                                      ~preempt);

   wire        state_sel_ldm       = ((run_exe & exe_state_sel_ldm |
                                       run_rfe & rfe_state_sel_ldm ) &
                                      ~preempt);

   wire        state_sel_ldr       = ((run_exe & exe_state_sel_ldr) &
                                      ~preempt);

   wire        state_sel_mul       = ((run_exe_state_sel_mul) &
                                      ~preempt);

   wire        state_sel_pfu       = ((run_alt & alt_state_sel_pfu |
                                       run_exe & exe_state_sel_pfu |
                                       run_hlt & hlt_state_sel_pfu |
                                       run_irq & irq_state_sel_pfu |
                                       run_lck & lck_state_sel_pfu |
                                       run_ldm & ldm_state_sel_pfu |
                                       run_rfe & rfe_state_sel_pfu |
                                       run_rst & rst_state_sel_pfu |
                                       run_t32 & t32_state_sel_pfu ) &
                                      ~preempt);

   wire        state_sel_rfe       = ((run_ldm & ldm_state_sel_rfe |
                                       run_exe & exe_state_sel_rfe |
                                       run_wfx & wfx_state_sel_rfe ) &
                                      ~preempt);

   wire        state_sel_stm       = ((run_exe & exe_state_sel_stm |
                                       run_irq & irq_state_sel_stm ) &
                                      ~preempt);

   wire        state_sel_str       = ((run_exe & exe_state_sel_str) &
                                      ~preempt);

   wire        state_sel_t32       = ((run_exe & exe_state_sel_t32) &
                                      ~preempt);

   wire        state_sel_wfx       = ((run_exe & exe_state_sel_wfx |
                                       run_rfe & rfe_state_sel_wfx ) &
                                      ~preempt);

   wire        svc_req             = ( run_exe & exe_svc_req );

   wire        tbit_en             = ( run_exe & exe_tbit_en |
                                       run_hlt & hlt_tbit_en |
                                       run_irq & irq_tbit_en |
                                       run_ldm & ldm_tbit_en |
                                       run_rfe & rfe_tbit_en |
                                       run_rst & rst_tbit_en );

   wire        tbit_sel_bus        = ( run_irq & irq_tbit_sel_bus |
                                       run_ldm & ldm_tbit_sel_bus |
                                       run_rst & rst_tbit_sel_bus );

   wire        tbit_sel_rb         = ( run_exe & exe_tbit_sel_rb );
   wire        tbit_sel_rfe        = ( run_rfe & rfe_tbit_sel_rfe );
   wire        unalign_dword       = ( run_rfe & rfe_unalign_dword );

   wire        hdf_lock_en         = ( run_irq & irq_hdf_lock_en |
                                       run_ldm & ldm_hdf_lock_en |
                                       run_rfe & rfe_hdf_lock_en );

   wire        nmi_lock_en         = ( run_irq & irq_nmi_lock_en |
                                       run_rfe & rfe_nmi_lock_en |
                                       run_stm & stm_nmi_lock_en );

   wire        hdf_lock_nxt        = ( run_irq & irq_hdf_lock_nxt |
                                       run_ldm & ldm_hdf_lock_nxt |
                                       run_rfe & rfe_hdf_lock_nxt );

   wire        nmi_lock_nxt        = ( run_irq & irq_nmi_lock_nxt |
                                       run_stm & stm_nmi_lock_nxt );

   wire        vtable              = ( run_irq & irq_vtable |
                                       run_rst & rst_vtable );

   wire        event_clear         = ( run_wfx & wfx_event_clear );

   wire        wfe_execute         = ( run_wfx & wfx_wfe_execute |
                                       run_exe & exe_wfe_execute );

   wire        wfi_execute         = ( run_wfx & wfx_wfi_execute |
                                       run_exe & exe_wfi_execute );

   wire        wic_clear           = ( run_irq & irq_wic_clear |
                                       run_rfe & rfe_wic_clear |
                                       run_rst & rst_wic_clear |
                                       run_wfx & wfx_wic_clear );

   wire        wic_load            = ( run_exe & exe_wic_load |
                                       run_wfx & wfx_wic_load);

   wire        wr_addr_sel_108     = ( run_exe & exe_wr_addr_sel_108 );
   wire        wr_addr_sel_hw2     = ( run_t32 & t32_wr_addr_sel_hw2);

   wire        wr_addr_sel_r14     = ( run_exe & exe_wr_addr_sel_r14 |
                                       run_ldm & ldm_wr_addr_sel_r14 |
                                       run_rfe & rfe_wr_addr_sel_r14 |
                                       run_stm & stm_wr_addr_sel_r14 |
                                       run_t32 & t32_wr_addr_sel_r14 );

   wire        wr_addr_sel_rb      = ( run_ldr & ldr_wr_addr_sel_rb |
                                       run_ldm & ldm_wr_addr_sel_rb );

   wire        wr_addr_sel_z20     = ( run_exe & exe_wr_addr_sel_z20 );

   wire        wr_data_sel_alu     = ( run_exe & exe_wr_data_sel_alu |
                                       run_stm & stm_wr_data_sel_alu |
                                       run_mul_wr_data_sel_alu |
                                       run_rfe & rfe_wr_data_sel_alu |
                                       run_irq & irq_wr_data_sel_alu );

   wire        wr_data_sel_apsr    = ( run_t32 & t32_wr_data_sel_apsr |
                                       run_hlt & hlt_wr_data_sel_apsr |
                                       run_irq & irq_wr_data_sel_apsr );

   wire        wr_data_sel_aux     = ( run_stm & stm_wr_data_sel_aux |
                                       run_ldm & ldm_wr_data_sel_aux |
                                       run_hlt & hlt_wr_data_sel_aux );

   wire        wr_data_sel_control = ( run_t32 & t32_wr_data_sel_control );

   wire        wr_data_sel_ret     = ( run_ldm & ldm_wr_data_sel_ret |
                                       run_rfe & rfe_wr_data_sel_ret |
                                       run_stm & stm_wr_data_sel_ret );

   wire        wr_data_sel_ipsr    = ( run_t32 & t32_wr_data_sel_ipsr |
                                       run_hlt & hlt_wr_data_sel_ipsr |
                                       run_irq & irq_wr_data_sel_ipsr );

   wire        wr_data_sel_link    = ( run_t32 & t32_wr_data_sel_link );

   wire        wr_data_sel_msp     = ( run_t32 & t32_wr_data_sel_msp |
                                       run_hlt & hlt_wr_data_sel_msp );

   wire        wr_data_sel_primask = ( run_t32 & t32_wr_data_sel_primask |
                                       run_hlt & hlt_wr_data_sel_primask );

   wire        wr_data_sel_psp     = ( run_t32 & t32_wr_data_sel_psp |
                                       run_hlt & hlt_wr_data_sel_psp );

   wire        wr_data_sel_rb      = ( run_t32 & t32_wr_data_sel_rb );

   wire        wr_data_sel_spu     = ( run_rst & rst_wr_data_sel_spu |
                                       run_exe & exe_wr_data_sel_spu |
                                       run_ldr & ldr_wr_data_sel_spu |
                                       run_ldm & ldm_wr_data_sel_spu );

   wire        wr_en_io            = ( run_exe & exe_wr_en_io );

   wire        wr_en_std           = ( run_exe & exe_wr_en_std |
                                       run_hlt & hlt_wr_en_std |
                                       run_irq & irq_wr_en_std |
                                       run_ldm & ldm_wr_en_std |
                                       run_ldr & ldr_wr_en_std |
                                       run_mul_wr_en_std |
                                       run_rfe & rfe_wr_en_std |
                                       run_stm & stm_wr_en_std |
                                       run_t32 & t32_wr_en_std );

   // -------------------------------------------------------------------------
   // Construct specialized select signals for debug state
   // -------------------------------------------------------------------------

   // Halted debug state can read and write the architectural control registers
   // from a number of non-standard places. Whilst halted, always implicitly
   // select these sources and destinations.

   wire        spsel_sel_dbg, npriv_sel_dbg, primask_sel_dbg, tbit_sel_dbg;
   wire        apsr_sel_dbg;

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_4a

         assign { spsel_sel_dbg, npriv_sel_dbg, primask_sel_dbg, tbit_sel_dbg,
                  apsr_sel_dbg } = {5{run_hlt}};

      end else begin : gen_dbg_4b

         assign { spsel_sel_dbg, npriv_sel_dbg, primask_sel_dbg, tbit_sel_dbg,
                  apsr_sel_dbg } = 5'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Select next state value
   // -------------------------------------------------------------------------

   // Next-state is selected by mapping the requested state onto their
   // respective encodings. As MUL and DBG states are unreachable under certain
   // implementation configurations, these values are pre-optimized.

   wire [3:0]  state_nxt_mul;

   generate
      if((CBAW != 0) || (SMUL !=0)) begin : gen_smul_5a

         assign state_nxt_mul = {4{state_sel_mul & cfg_smul}} & st_mul;

      end else begin : gen_smul_5b

         wire unused = state_sel_mul;
         assign state_nxt_mul = 4'b0;

      end
   endgenerate

   // --------

   wire [3:0] state_nxt_hlt;

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_5a

         assign state_nxt_hlt = {4{state_sel_hlt & cfg_dbg}} & st_hlt;

      end else begin : gen_dbg_5b

         wire unused = state_sel_hlt;
         assign state_nxt_hlt = 4'b0;

      end
   endgenerate

   // --------
   // Generate final version of four-bit next-state value.

   wire [3:0]  state_nxt = ( {4{state_sel_exe}} & st_exe |
                             state_nxt_hlt |
                             {4{state_sel_irq}} & st_irq |
                             {4{state_sel_lck}} & st_lck |
                             {4{state_sel_ldm}} & st_ldm |
                             {4{state_sel_ldr}} & st_ldr |
                             state_nxt_mul |
                             {4{state_sel_pfu}} & st_pfu |
                             {4{state_sel_rfe}} & st_rfe |
                             {4{state_sel_stm}} & st_stm |
                             {4{state_sel_str}} & st_str |
                             {4{state_sel_t32}} & st_t32 |
                             {4{state_sel_wfx}} & st_wfx );

   // -------------------------------------------------------------------------
   // Create AHB write data value
   // -------------------------------------------------------------------------

   // Loads and stores are encoded into base_q with address suppressed for
   // stores, as follows:
   // - byte load/store are encoded as AA1S
   // - half load/store are encoded as A10S
   // - word load/store are encoded as 1000
   // For loads, AA contains bits[1:0] of the address, for stores AA are both
   // zero.

   // Write-data is held as zero when not performing a store so as to minimize
   // system power.

   wire        str_valid = run_str | run_stm | run_irq & ~irq_cyc_1;
   wire [31:0] rb_val_m  = {32{str_valid}} & rb_value;

   wire [31:0] wr_b_value = {4{rb_val_m[7:0]}};
   wire [31:0] wr_h_value = {2{rb_val_m[15:0]}};
   wire [31:0] wr_w_value = rb_val_m;

   wire [31:0] wdata_le = {32{base_q[0]}} & wr_b_value |
                          {32{base_q[1]}} & wr_h_value |
                          {32{base_q[2]}} & wr_w_value;

   wire [31:0] ahb_wdata;

   generate
      if((CBAW != 0) || (BE != 0)) begin : gen_be_1a

         wire [31:0] wdata_be = f_byte_swap(wdata_le[31:0]);

         assign ahb_wdata = (cfg_be & ~mtx_ppb_active_i) ? wdata_be : wdata_le;

      end else begin : gen_be_1b

         assign ahb_wdata = wdata_le;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Compute list length, register name and next-list for multiples
   // -------------------------------------------------------------------------

   // List management is required for LDM, STM, PUSH, POP and exception entry/
   // return. LDM and STM only support loading/storing R0-R7; POP and PUSH also
   // support loading of the PC and storing of R14 respectively.

   // The length of the list is computeted simply by summing the number of set
   // bits, whilst the next-list value is computed by clearing the least-
   // significant set bit. For instruction use, each bit encodes R0-R7 then
   // PC/R14; for exception processing (when atomic_q is set) R4 is replaced
   // with R12 to support the architecturally stored list of {R0-R3,R12,LR,PC}
   // and xPSR.

   // The first register is always consumed before the list is ever loaded into
   // list_q. As such it wouldn't be possible for R0 to be present in list_q,
   // and thus list_q[0] corresponds to R1.

   wire        list_rbit = op_q[12] & op_q[8]; // PUSH/POP R14/PC is in list

   wire [ 8:0] list_src  = ( {9{list_sel_op}} & {list_rbit, op_q[7:0]} |
                             {9{list_sel_list}} & {list_q[7:0], 1'b0} |
                             {9{list_sel_irq}} & 9'h11F );

   wire [ 8:0] list_mask = { |list_src[7:0],
                             |list_src[6:0],
                             |list_src[5:0],
                             |list_src[4:0],
                             |list_src[3:0],
                             |list_src[2:0],
                             |list_src[1:0],
                             list_src[0],
                             1'b0 };

   wire [ 7:0] list_nxt  = list_src[8:1] & list_mask[8:1];

   wire [ 8:0] list_rsel = {1'b1, list_mask[8:1]} & ~list_mask;

   wire [ 3:0] list_reg  = ( {4{list_rsel[0]}} & 4'h0 |
                             {4{list_rsel[1]}} & 4'h1 |
                             {4{list_rsel[2]}} & 4'h2 |
                             {4{list_rsel[3]}} & 4'h3 |
                             {4{list_rsel[4]}} & {atomic_q,3'b100} |
                             {4{list_rsel[5]}} & 4'h5 |
                             {4{list_rsel[6]}} & 4'h6 |
                             {4{list_rsel[7]}} & 4'h7 |
                             {4{list_rsel[8]}} & 4'hE );

   wire [ 3:0] list_len  = ( op_q[0] + op_q[1] + op_q[2] + op_q[3] + op_q[4] +
                             op_q[5] + op_q[6] + op_q[7] + list_rbit );

   // -------------------------------------------------------------------------
   // Generate offset increment for load/store multiples
   // -------------------------------------------------------------------------

   // The offset_q registers are used to track both the cycle in multi-cycle
   // operations, and also the address offset (in words) for load/store-
   // multiples. The default behavior for offset_q is to increment by one,
   // however, it may also be preloaded with certain values.

   wire [3:0]  offset_inc = offset_q + 1'b1;

   wire [3:0]  offset_nxt = ( {4{offset_sel_inc}} & offset_inc |
                              {offset_sel_eight, 1'b0,
                               offset_sel_two, offset_sel_one} );

   // -------------------------------------------------------------------------
   // Compute next PC value
   // -------------------------------------------------------------------------

   // The value stored in iaex_q is the address of the current instruction in
   // execute. The architectural value of PC used by various instructions is
   // this value plus four. This value is computed explicitly here along with
   // the next incremental iaex_q half-word value

   wire [31:0] pc_value  = { iaex_q[30:1] + 1'b1, iaex_q[0], 1'b0 };
   wire [30:0] iaex_inc  = iaex_q[30:0] + 1'b1;

   // The fetch address is derived from the instruction address in execute
   // plus either two or four depending on where the processor is wrt. the
   // pipeline being full.

   wire        fe_delta  = run_pfu;
   wire [ 2:0] fe_add_lo = iaex_q[1:0] + {~fe_delta, fe_delta};
   wire [28:0] fe_add_hi = iaex_q[30:2] + fe_add_lo[2];

   wire [30:0] fe_addr   = { fe_add_hi[28:0],
                             fe_add_lo[1],
                             fe_add_lo[0] & (fe_delta | cfg_hwf) };

   // -------------------------------------------------------------------------
   // Arithmetic-logic and multiplier data-paths:
   // ALU primary operand selection
   // -------------------------------------------------------------------------

   // The main ALU adder takes three operands. The first operand is always
   // selected from either the PC, the value from the primary read-port, or
   // (in the case of load/store-multiples and the iterative multiplier) from
   // the auxiliary register.

   wire [31:0] alu_pc_value = { pc_value[31:2],
                                pc_value[1] & ~opa_mask_pc,
                                1'b0 };

   wire [31:0] alu_opa      = ( {32{opa_sel_ra}} & ra_value |
                                {32{opa_sel_pc}} & alu_pc_value |
                                {32{opa_sel_aux}} & aux_q );

   // -------------------------------------------------------------------------
   // ALU secondary operand selection
   // -------------------------------------------------------------------------

   // The second ALU operand is either an immediate value, the value from the
   // offset_q register, the computed list length, the PC value, or the value
   // from the secondary read-port.

   // --------
   // Generate immediate value for Thumb 32-bit BL instruction. The top ten
   // bits, bits[31:22], require exclusive OR-ing with hw1[10]. This is
   // performed separately in the standard operand-B inversion logic to reduce
   // gate count.

   wire [31:0] alu_bl_imm = { 8'b0,      //  ^ {8{hw1[10]}} using opb_inv_hi
                              ~hw2[13],  //  ^ hw1[10]     ...
                              ~hw2[11],  //  ^ hw1[10]     ...
                              hw1[9:0],
                              hw2[10:0],
                              1'b0 };

   // Like the BL immediate, the 8 and 11-bit signed immediate also have their
   // top ten bits created via the operand-B inversion logic; bits below this
   // have to be explicitly sign extended here.

   wire [31:0] alu_s11_imm = {10'b0, {10{op_q[10]}}, op_q[10:0], 1'b0};
   wire [31:0] alu_s8_imm  = {10'b0, {14{op_q[7]}}, op_q[6:0], 1'b0};

   // Construct operand-B inversion control based upon an explicit request to
   // invert the operand, or when a sign extended operand is being used and
   // its sign bit is set. The lower part of the operand is only ever inverted
   // explicitly.

   wire        opb_inv_hi = ( opb_inv |                    // Explicit invert
                              opb_sel_simm8 & op_q[7] |    // Backwards Bcc
                              opb_sel_simm11 & op_q[10] |  // Backwards B
                              opb_sel_bl & hw1[10] );      // Backwards BL

   // Select ALU secondary operand from appropriate register or immediate
   // source:

   wire [31:0] opb_list = {26'b0, list_len[3:0], 2'b0};

   wire [31:0] alu_opbi = ( {32{opb_sel_28}}     & 32'd28 |
                            {32{opb_sel_32}}     & 32'd32 |
                            {32{opb_sel_four}}   & 32'd4 |
                            {32{opb_sel_pc}}     & pc_value |
                            {32{opb_sel_imm8_2}} & {22'b0, op_q[7:0], 2'b00} |
                            {32{opb_sel_imm7_2}} & {23'b0, op_q[6:0], 2'b00} |
                            {32{opb_sel_simm11}} & alu_s11_imm |
                            {32{opb_sel_imm8}}   & {24'b0, op_q[7:0]} |
                            {32{opb_sel_simm8}}  & alu_s8_imm |
                            {32{opb_sel_bl}}     & alu_bl_imm |
                            {32{opb_sel_imm3}}   & {29'b0, op_q[8:6]} |
                            {32{opb_sel_imm5_0}} & {27'b0, op_q[10:6]} |
                            {32{opb_sel_imm5_1}} & {26'b0, op_q[10:6], 1'b0} |
                            {32{opb_sel_imm5_2}} & {25'b0, op_q[10:6], 2'b00} |
                            {32{opb_sel_offset}} & {26'b0, offset_q, 2'b0} |
                            {32{opb_sel_list}}   & opb_list[31:0] );

   // The read-port operand arrives relatively late, so factor in to the ALU
   // source operand as late as possible.

   wire [31:0] alu_opb = ( {32{opb_sel_rb}} & rb_value |
                           alu_opbi );

   // -------------------------------------------------------------------------
   // Main arithmetic and logic-operations
   // -------------------------------------------------------------------------

   // The following constructs all of the main ALU logic. The third operand in
   // to the ALU is a single bit optionally selected from the carry-flag.

   // Dedicated operations exist for AND and EOR, however, ORR is implemented
   // using the final result mux.

   wire        add_opc   = opc_sel_one | opc_sel_apsr & cflag;
   wire [31:0] alu_invb  = alu_opb ^ {{10{opb_inv_hi}},{22{opb_inv}}};
   wire [31:0] and_res   = alu_opa & alu_invb;
   wire [31:0] eor_res   = alu_opa ^ alu_invb;
   wire [32:0] add_full  = alu_opa + alu_invb + add_opc;
   wire [31:0] add_res   = add_full[31:0];
   wire        add_cflag = add_full[32];

   wire        add_vflag = ( (alu_opa[31] == alu_invb[31]) &
                             (alu_opa[31] != add_full[31]) );

   // -------------------------------------------------------------------------
   // Load/store control
   // -------------------------------------------------------------------------

   // Encode load/store address, type and sign for use in the load/store data-
   // phase for lane extraction and replication:
   // - byte load/store are encoded as AA1S
   // - half load/store are encoded as A10S
   // - word load/store are encoded as 1000
   // Note that add_res is not always the transaction address, however, it is
   // guaranteed to have the same byte alignment.

   wire [ 1:0] base_addr = {2{~ls_write}} & add_res[1:0];

   wire [ 2:0] base_nxt  = { base_addr[1] | base_sel_word,
                             (base_addr[0] | base_sel_half) & ~base_sel_word,
                             base_sel_byte };

   // Select this or next value of base if this is a single cycle IO port read.

   wire [ 3:0] load_ctl;

   generate
      if((CBAW != 0) || (IOP != 0)) begin : gen_iop_3a

         wire [3:0] std_ctl = { base_q, extend_q };
         wire [3:0] fwd_ctl = { base_nxt, extend_nxt };

         assign load_ctl = ls_fwd_io ? fwd_ctl : std_ctl;

      end else begin : gen_iop_3b

         wire unused = ls_fwd_io;

         assign load_ctl = { base_q, extend_q };

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Shift and permute data-path
   // -------------------------------------------------------------------------

   // -------------------------------------------------------------------------
   // Compute shift amount for iterative multiplier bit extraction
   // -------------------------------------------------------------------------

   wire [ 7:0] rot_amt_mul;

   generate
      if((CBAW != 0) || (SMUL != 0)) begin : gen_smul_6a

         assign rot_amt_mul = ( {8{cfg_smul & rot_amt_sel_mul}} &
                                {3'b0, ~list_q[0], offset_q[3:0]} );

      end else begin : gen_smul_6b

         wire unused = rot_amt_sel_mul;
         assign rot_amt_mul = 8'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Select shift amount source and perform initial rotate
   // -------------------------------------------------------------------------

   // Convert immediate shift by zero into a shift by 32

   wire [7:0]  rot_imm = {2'b0, |op_q[12:11] & ~|op_q[10:6], op_q[10:6]};

   wire [7:0]  rot_amt = ( {8{rot_amt_sel_imm}} & rot_imm |
                           rot_amt_mul |
                           {8{rot_amt_sel_rb}} & rb_value[7:0] );

   // The 0 to 7 bit rotation muxes can only perform a rotate right, therefore
   // any left shifts must be converted into their rotate-right equivalents.

   wire [ 4:0] shl_amt = -rot_amt[4:0];  // left rotation amount
   wire [ 4:0] shr_amt = +rot_amt[4:0];  // right rotation amount

   wire [ 4:0] ror_amt = ( {5{ror_amt_sel_left}} & shl_amt |
                           {5{ror_amt_sel_right}} & shr_amt );

   wire        ror_zero = ~|ror_amt;

   // -------------------------------------------------------------------------
   // Perform 0 to 7-bit barrel shift
   // -------------------------------------------------------------------------

   // Rotate the entire 32-bit input operand right by the computed amount, in
   // the range 0 to 7. This preconditions the value such that all possible
   // shifts can subsequently be achieved via byte level permutation.

   wire        ror_amt_0 = ror_amt[1:0] == 2'b00;
   wire        ror_amt_1 = ror_amt[1:0] == 2'b01;
   wire        ror_amt_2 = ror_amt[1:0] == 2'b10;
   wire        ror_amt_3 = ror_amt[1:0] == 2'b11;

   wire [31:0] ror_in    = ra_value;

   wire [31:0] ror_val_0 = ( {32{ror_amt_0}} & ror_in[31:0] |
                             {32{ror_amt_1}} & {ror_in[  0], ror_in[31:1]} |
                             {32{ror_amt_2}} & {ror_in[1:0], ror_in[31:2]} |
                             {32{ror_amt_3}} & {ror_in[2:0], ror_in[31:3]} );

   wire [31:0] ror_val   = ( ror_amt[2] ?
                             {ror_val_0[3:0], ror_val_0[31:4]} :
                             ror_val_0 );

   // -------------------------------------------------------------------------
   // Generate mask for shifts
   // -------------------------------------------------------------------------

   // Unlike rotations, shifts require masking to be applied to the rotated
   // value; due to only 0-7 bits of rotation having been applied, only the
   // eight most-significant-bits need masking.

   wire        inv_msk   = |ror_amt & shf_left;

   wire [ 2:0] ror_msk_0 = ( {3{ror_amt_0}}          |
                             {1'b0, {2{ror_amt_1}}}  |
                             {2'b00, {1{ror_amt_2}}} );

   wire [ 3:0] ror_msk_1 = {ror_msk_0, 1'b1};

   wire [ 7:0] ror_msk_2 = { {4{~ror_amt[2]}} & ror_msk_1,
                             {4{~ror_amt[2]}} | ror_msk_1 };

   wire [ 7:0] shf_msk   = {8{inv_msk}} ^ ror_msk_2;

   wire [ 7:0] ror_msk   = {8{ror_force_msk}} | shf_msk;

   // -------------------------------------------------------------------------
   // Apply sign to rotate output
   // -------------------------------------------------------------------------

   // Arithmetic shifts require sign insertion into the masked bits; the bottom
   // 24-bits are passed into the permutation matrix unmodified.

   wire        rot_sign = rot_sign_sel_ra31 & ra_value[31];

   wire [ 7:0] rot_top  = ( ror_val[31:24] & ror_msk |
                            {8{rot_sign}}  & ~ror_msk);

   wire [31:0] rot_out  = {rot_top, ror_val[23:0]};

   // -------------------------------------------------------------------------
   // Derive dynamic matrix selects for shifter operations
   // -------------------------------------------------------------------------

   // Unlike all other operations making use of the 4x4-byte permutation
   // matrix, the shift operation cross-bar connections are derived dynamically
   // based on a function of the shift amount and the type of operation being
   // performed.

   wire        rot_lsl_ror = shf_ror | shf_left;

   wire        ror_00      = ror_amt[4:3] == 2'b00;
   wire        ror_08      = ror_amt[4:3] == 2'b01;
   wire        ror_16      = ror_amt[4:3] == 2'b10;
   wire        ror_24      = ror_amt[4:3] == 2'b11;

   wire [ 3:0] ror_sel_0   = {ror_24, ror_16, ror_08, ror_00};
   wire [ 3:0] ror_sel_1   = {ror_16, ror_08, ror_00, ror_24};
   wire [ 3:0] ror_sel_2   = {ror_08, ror_00, ror_24, ror_16};
   wire [ 3:0] ror_sel_3   = {ror_00, ror_24, ror_16, ror_08};

   wire [ 3:0] rot_msk_0   = {4{ror_24 | ~shf_left | ror_zero}};

   wire [ 3:0] rot_msk_1   = ( {3'b111, rot_lsl_ror} &
                               {4{ror_24 | ror_16 |
                                  ~shf_left | ror_zero}} );

   wire [ 3:0] rot_msk_2   = ( {2'b11, {2{rot_lsl_ror}} } &
                               {4{ror_24 | ror_16 | ror_08 |
                                  ~shf_left | ror_zero}});

   wire [ 3:0] rot_msk_3   = {1'b1, {3{rot_lsl_ror}} };

   wire        rot_ge_32   = |rot_amt[7:5] & ~shf_ror;

   wire [ 3:0] rot_lt_32   = {4{~rot_ge_32}};

   wire [ 3:0] rot_sel_0   = ror_sel_0 & rot_msk_0 & rot_lt_32;
   wire [ 3:0] rot_sel_1   = ror_sel_1 & rot_msk_1 & rot_lt_32;
   wire [ 3:0] rot_sel_2   = ror_sel_2 & rot_msk_2 & rot_lt_32;
   wire [ 3:0] rot_sel_3   = ror_sel_3 & rot_msk_3 & rot_lt_32;

   wire        rot_sgn_0   = ~|rot_sel_0;
   wire        rot_sgn_1   = ~|rot_sel_1;
   wire        rot_sgn_2   = ~|rot_sel_2;
   wire        rot_sgn_3   = ~|rot_sel_3;

   // -------------------------------------------------------------------------
   // Shifter zero-result detection
   // -------------------------------------------------------------------------

   // Zero detection is performed on the intermediate shift value as only these
   // instructions can set the Z-flag; this effectively removes a false timing
   // path on the AHB read data path through the permutation matrix.

   // The final result is known to be zero if all of the individual used bytes
   // are zero and no sign bits are going to be injected.

   wire [ 3:0] rot_used  = ( rot_sel_0 | rot_sel_1 |
                             rot_sel_2 | rot_sel_3 );

   wire [ 3:0] rot_set   = { |rot_out[31:24],
                             |rot_out[23:16],
                             |rot_out[15: 8],
                             |rot_out[ 7: 0] };

   wire        rot_zflag = ~( |(rot_set & rot_used) |
                              rot_sgn_1 & rot_sign  |
                              rot_sgn_2 & rot_sign  |
                              rot_sgn_3 & rot_sign  );

   // -------------------------------------------------------------------------
   // Shifter negative-result detection
   // -------------------------------------------------------------------------

   // Likewise, N-flag value is computed earlier based upon which bit will end
   // up in position 31, or the sign-bit if sign extension is performed.

   // The shift unit's N flag is also used if the small iterative multiplier is
   // implemented in order to extract the current bit of the multiplicand which
   // is then used by the arithmetic units output selection mux to either
   // return the pre or post accumulated result.

   wire        rot_nflag = ( rot_sel_3[3] & rot_out[31] |
                             rot_sel_3[2] & rot_out[23] |
                             rot_sel_3[1] & rot_out[15] |
                             rot_sel_3[0] & rot_out[ 7] |
                             rot_sgn_3 & rot_sign );

   // -------------------------------------------------------------------------
   // Shift carry detection
   // -------------------------------------------------------------------------

   // The carry flag is either, the incoming C-flag value, or the bit either in
   // position -1 or position 32; because we have only performed a rotation so
   // far, these bit positions correspond to bits 31 and 0 respectively.

   wire       shift_00  = ( ror_sel_0[3] & ror_val[24] |
                            ror_sel_0[2] & ror_val[16] |
                            ror_sel_0[1] & ror_val[ 8] |
                            ror_sel_0[0] & ror_val[ 0] );

   wire       shift_31  = ( ror_sel_3[3] & ror_val[31] |
                            ror_sel_3[2] & ror_val[23] |
                            ror_sel_3[1] & ror_val[15] |
                            ror_sel_3[0] & ror_val[ 7] );

   wire       rot_eq_00 = ~|rot_amt[7:0];
   wire       rot_gt_32 = |rot_amt[7:6] | (rot_amt[5] & |rot_amt[4:0]);

   wire       c_gt_32   = ( c_gt_32_sel_nf & rot_nflag |
                            c_gt_32_sel_31 & shift_31 );

   wire       c_le_32   = ( c_le_32_sel_00 & shift_00 |
                            c_le_32_sel_31 & shift_31 );

   wire       c_select  = rot_gt_32 ? c_gt_32 : c_le_32;

   wire       rot_cflag = rot_eq_00 ? cflag : c_select;

   // -------------------------------------------------------------------------
   // Extract permutation matrix control for load data-phase
   // -------------------------------------------------------------------------

   // For loads, the byte-permutation performed varies depending on whether the
   // implementation is using big or little-endian data.

   wire       load_word   = load_ctl[2:1] == 2'b00;
   wire       load_byte   = load_ctl[1];

   wire       load_byte_0, load_byte_1, load_byte_2, load_byte_3;
   wire       load_half_0, load_half_2;

   generate
      if((CBAW != 0) || (BE != 0)) begin : gen_be_2a

         assign load_byte_0 = load_ctl[3:1] == ( cfg_be ? 3'b111 : 3'b001 );
         assign load_half_0 = load_ctl[3:1] == ( cfg_be ? 3'b110 : 3'b010 );
         assign load_byte_1 = load_ctl[3:1] == ( cfg_be ? 3'b101 : 3'b011 );
         assign load_byte_2 = load_ctl[3:1] == ( cfg_be ? 3'b011 : 3'b101 );
         assign load_half_2 = load_ctl[3:1] == ( cfg_be ? 3'b010 : 3'b110 );
         assign load_byte_3 = load_ctl[3:1] == ( cfg_be ? 3'b001 : 3'b111 );

      end else begin : gen_be_2b

         assign load_byte_0 = load_ctl[3:1] == 3'b001;
         assign load_half_0 = load_ctl[3:1] == 3'b010;
         assign load_byte_1 = load_ctl[3:1] == 3'b011;
         assign load_byte_2 = load_ctl[3:1] == 3'b101;
         assign load_half_2 = load_ctl[3:1] == 3'b110;
         assign load_byte_3 = load_ctl[3:1] == 3'b111;

      end
   endgenerate

   // --------

   wire [3:0] load_mtx_sel_3 = { load_word, 3'b0 };
   wire [3:0] load_mtx_sel_2 = { 1'b0, load_word, 2'b0 };

   wire [3:0] load_mtx_sel_1 = { load_half_2, 1'b0,
                                 load_half_0 | load_word, 1'b0 };

   wire [3:0] load_mtx_sel_0 = { load_byte_3,
                                 load_byte_2 | load_half_2, load_byte_1,
                                 load_byte_0 | load_half_0 | load_word };

   wire [3:0] perm_mtx_sel_3 = { 1'b0, perm_mtx_revh & ~perm_mtx_sgn_32,
                                 1'b0, perm_mtx_revb & ~perm_mtx_sgn_32 };

   wire [3:0] perm_mtx_sel_2 = { perm_mtx_revh & ~perm_mtx_sgn_32, 1'b0,
                                 perm_mtx_revb & ~perm_mtx_sgn_32, 1'b0 };

   wire [3:0] perm_mtx_sel_1 = { 1'b0, perm_mtx_revb,
                                 perm_mtx_xt & ~perm_mtx_sgn_1,
                                 perm_mtx_revh };

   wire [3:0] perm_mtx_sel_0 = { perm_mtx_revb, 1'b0,
                                 perm_mtx_revh, perm_mtx_xt };

   // -------------------------------------------------------------------------

   wire       nrot_mtx_sgn_32 = ( mtx_sel_use_load & load_ctl[0] & ~load_word |
                                  perm_mtx_sgn_32 );

   wire       nrot_mtx_sgn_1  = ( mtx_sel_use_load & load_ctl[0] & load_byte |
                                  perm_mtx_sgn_1 );

   // -------------------------------------------------------------------------
   // Little endian read-data sign bit selection for loads
   // -------------------------------------------------------------------------

   wire       mtx_ls_sgn_31_le = load_ctl[3:2] == 2'b11;  // Byte 3 / Half 1
   wire       mtx_ls_sgn_23_le = load_ctl[3:1] == 3'b101; // Byte 2
   wire       mtx_ls_sgn_15_le = load_ctl[3:2] == 2'b01;  // Byte 1 / Half 0
   wire       mtx_ls_sgn_07_le = load_ctl[3:2] == 2'b00;  // Byte 0

   // -------------------------------------------------------------------------
   // Big endian read-data sign bit selection for loads
   // -------------------------------------------------------------------------

   // The incoming data has already been fully byte reversed, so each of the
   // actual byte selects needs exchanging also.

   wire       mtx_ls_sgn_07_be = ( load_ctl[3:1] == 3'b111 );  // Byte 3

   wire       mtx_ls_sgn_15_be = ( (load_ctl[3:1] == 3'b101) |  // Byte 2
                                   (load_ctl[3:1] == 3'b110) ); // Half 1

   wire       mtx_ls_sgn_23_be = ( load_ctl[3:1] == 3'b011 );   // Byte 1

   wire       mtx_ls_sgn_31_be = ( (load_ctl[3:1] == 3'b001) |  // Byte 0
                                   (load_ctl[3:1] == 3'b010) ); // Half 0

   // -------------------------------------------------------------------------
   // Select appropriate endianess and generate matrix sign selection
   // -------------------------------------------------------------------------

   wire       mtx_ls_sgn_31, mtx_ls_sgn_23, mtx_ls_sgn_15, mtx_ls_sgn_07;

   generate
      if(CBAW != 0) begin : gen_be_3a

         assign mtx_ls_sgn_31 = cfg_be ? mtx_ls_sgn_31_be : mtx_ls_sgn_31_le;
         assign mtx_ls_sgn_23 = cfg_be ? mtx_ls_sgn_23_be : mtx_ls_sgn_23_le;
         assign mtx_ls_sgn_15 = cfg_be ? mtx_ls_sgn_15_be : mtx_ls_sgn_15_le;
         assign mtx_ls_sgn_07 = cfg_be ? mtx_ls_sgn_07_be : mtx_ls_sgn_07_le;

      end else if(BE != 0) begin : gen_be_3b

         wire [3:0] unused = { mtx_ls_sgn_31_le, mtx_ls_sgn_23_le,
                               mtx_ls_sgn_15_le, mtx_ls_sgn_07_le };

         assign mtx_ls_sgn_31 = mtx_ls_sgn_31_be;
         assign mtx_ls_sgn_23 = mtx_ls_sgn_23_be;
         assign mtx_ls_sgn_15 = mtx_ls_sgn_15_be;
         assign mtx_ls_sgn_07 = mtx_ls_sgn_07_be;

      end else begin : gen_be_3c

         wire [3:0] unused = { mtx_ls_sgn_31_be, mtx_ls_sgn_23_be,
                               mtx_ls_sgn_15_be, mtx_ls_sgn_07_be };

         assign mtx_ls_sgn_31 = mtx_ls_sgn_31_le;
         assign mtx_ls_sgn_23 = mtx_ls_sgn_23_le;
         assign mtx_ls_sgn_15 = mtx_ls_sgn_15_le;
         assign mtx_ls_sgn_07 = mtx_ls_sgn_07_le;

      end
   endgenerate

   // --------

   wire       mtx_sgn_sel_31 = mtx_sel_use_load & mtx_ls_sgn_31;
   wire       mtx_sgn_sel_23 = mtx_sel_use_load & mtx_ls_sgn_23;

   wire       mtx_sgn_sel_15 = ( mtx_sel_use_load & mtx_ls_sgn_15 |
                                 perm_sgn_sel_15 );

   wire       mtx_sgn_sel_7  = ( mtx_sel_use_load & mtx_ls_sgn_07 |
                                 perm_sgn_sel_7 );

   // -------------------------------------------------------------------------
   // Select multiplexer control for permutation matrix
   // -------------------------------------------------------------------------

   wire [3:0] mtx_sel_3 = ( {4{mtx_sel_use_load}} & load_mtx_sel_3 |
                            {4{mtx_ctl_sel_rot}} & rot_sel_3 |
                            perm_mtx_sel_3 );

   wire [3:0] mtx_sel_2 = ( {4{mtx_sel_use_load}} & load_mtx_sel_2 |
                            {4{mtx_ctl_sel_rot}} & rot_sel_2 |
                            perm_mtx_sel_2 );

   wire [3:0] mtx_sel_1 = ( {4{mtx_sel_use_load}} & load_mtx_sel_1 |
                            {4{mtx_ctl_sel_rot}} & rot_sel_1 |
                            perm_mtx_sel_1 );

   wire [3:0] mtx_sel_0 = ( {4{mtx_sel_use_load}} & load_mtx_sel_0 |
                            {4{mtx_ctl_sel_rot}} & rot_sel_0 |
                            perm_mtx_sel_0 );

   wire       mtx_sgn_3 = mtx_ctl_sel_rot & rot_sgn_3 | nrot_mtx_sgn_32;
   wire       mtx_sgn_2 = mtx_ctl_sel_rot & rot_sgn_2 | nrot_mtx_sgn_32;
   wire       mtx_sgn_1 = mtx_ctl_sel_rot & rot_sgn_1 | nrot_mtx_sgn_1;
   wire       mtx_sgn_0 = mtx_ctl_sel_rot & rot_sgn_0;

   // Select matrix data source.

   wire [31:0] mtx_in = ( {32{mtx_in_sel_bus}} & bus_rdata |
                          {32{mtx_in_sel_rot}} & rot_out );

   // Multiplex between the potential sources of sign bit.

   wire        mtx_sgn = ( mtx_in[31] & mtx_sgn_sel_31 |
                           mtx_in[23] & mtx_sgn_sel_23 |
                           mtx_in[15] & mtx_sgn_sel_15 |
                           mtx_in[7] & mtx_sgn_sel_7 |
                           rot_sign );

   // For each byte lane, select either zero or one incoming byte lane, and
   // optionally overwrite with the sign bit.

   wire [ 7:0] lane_3 = ( {8{mtx_sel_3[0]}} & mtx_in[ 7: 0] |
                          {8{mtx_sel_3[1]}} & mtx_in[15: 8] |
                          {8{mtx_sel_3[2]}} & mtx_in[23:16] |
                          {8{mtx_sel_3[3]}} & mtx_in[31:24] |
                          {8{mtx_sgn_3 & mtx_sgn}} );

   wire [ 7:0] lane_2 = ( {8{mtx_sel_2[0]}} & mtx_in[ 7: 0] |
                          {8{mtx_sel_2[1]}} & mtx_in[15: 8] |
                          {8{mtx_sel_2[2]}} & mtx_in[23:16] |
                          {8{mtx_sel_2[3]}} & mtx_in[31:24] |
                          {8{mtx_sgn_2 & mtx_sgn}} );

   wire [ 7:0] lane_1 = ( {8{mtx_sel_1[0]}} & mtx_in[ 7: 0] |
                          {8{mtx_sel_1[1]}} & mtx_in[15: 8] |
                          {8{mtx_sel_1[2]}} & mtx_in[23:16] |
                          {8{mtx_sel_1[3]}} & mtx_in[31:24] |
                          {8{mtx_sgn_1 & mtx_sgn}} );

   wire [ 7:0] lane_0 = ( {8{mtx_sel_0[0]}} & mtx_in[ 7: 0] |
                          {8{mtx_sel_0[1]}} & mtx_in[15: 8] |
                          {8{mtx_sel_0[2]}} & mtx_in[23:16] |
                          {8{mtx_sel_0[3]}} & mtx_in[31:24] |
                          {8{mtx_sgn_0 & mtx_sgn}} );

   // Concatenate the four byte lanes into the final value.

   wire [31:0] spu_res = {lane_3, lane_2, lane_1, lane_0};

   // -------------------------------------------------------------------------

   // -------------------------------------------------------------------------
   // Logic for fast and small multiplier variants
   // -------------------------------------------------------------------------

   wire [31:0]       alu_res_add_res;
   wire [31:0]       alu_res_mul_res;

   generate
      if(CBAW != 0) begin : gen_smul_7a

         wire [31:0] mul_opa    = {32{mul_en}} & ra_value;
         wire [31:0] mul_opb    = {32{mul_en}} & rb_value;

         wire [31:0] mul_res    = mul_opa * mul_opb;

         wire   alu_res_sel_mad = (alu_res_sel_add |
                                   cfg_smul & alu_res_sel_mul & rot_nflag);

         wire   alu_res_sel_opa = cfg_smul & alu_res_sel_mul & ~rot_nflag;

         assign alu_res_add_res = {32{alu_res_sel_mad}} & add_res;

         assign alu_res_mul_res = (cfg_smul ? ({32{alu_res_sel_opa}} & alu_opa)
                                   : mul_res );

      end else if(SMUL != 0) begin : gen_smul_7b

         wire   unused          = mul_en;

         wire   alu_res_sel_mad = (alu_res_sel_add |
                                   alu_res_sel_mul & rot_nflag);

         wire   alu_res_sel_opa = alu_res_sel_mul & ~rot_nflag;

         assign alu_res_add_res = {32{alu_res_sel_mad}} & add_res;
         assign alu_res_mul_res = {32{alu_res_sel_opa}} & alu_opa;

      end else begin : gen_smul_7c

         wire unused = alu_res_sel_mul;

         wire [31:0] mul_opa    = {32{mul_en}} & ra_value;
         wire [31:0] mul_opb    = {32{mul_en}} & rb_value;

         assign alu_res_add_res = {32{alu_res_sel_add}} & add_res;
         assign alu_res_mul_res = mul_opa * mul_opb;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // ALU result selection
   // -------------------------------------------------------------------------

   // Select the final ALU result from the appropriate source. If the operation
   // is ORR, then both the add result and EOR results are selected, resulting
   // in ORR.

   wire [31:0] alu_res = ( alu_res_add_res |
                           alu_res_mul_res |
                           {32{alu_res_sel_eor}} & eor_res |
                           {32{alu_res_sel_and}} & and_res );

   // -------------------------------------------------------------------------
   // Zero and negative flag generation for ALU
   // -------------------------------------------------------------------------

   // Generate the negative and zero flags for ALU and multiply type operations
   // via analysis of the final ALU output result. Results from the shift and
   // rotation type operations are handled elsewhere.

   wire        alu_nflag = alu_res[31];
   wire        alu_zflag = alu_res == 32'b0;

   // -------------------------------------------------------------------------
   // PRIMASK register control
   // -------------------------------------------------------------------------

   // PRIMASK<0> can be updated via CPS via opcode<4>, and via MSR from
   // register bit<0>, and via debug from DCRDR<0>

   wire        primask_nxt = ( primask_sel_op  & op_q[4] |
                               primask_sel_rb  & rb_value[0] |
                               primask_sel_dbg & aux_q[0] );

   wire        primask_ex  = primask_en ? primask_nxt : primask_q;

   // -------------------------------------------------------------------------
   // Opcode selection logic
   // -------------------------------------------------------------------------

   // The opcode is registered from one of three sources. The first two sources
   // are the upper and lower 16-bit halves of the AHB bus, the third is the
   // instruction queue buffer. In normal sequential operation the opcode
   // buffer is alternatively from the lower half of the AHB bus and then the
   // instruction queue buffer. The upper half of the AHB bus is only used for
   // branches / other flow changes to half-word aligned instruction addresses.

   // The opcode buffer is complemented by its own "special" bit (op_s_q).
   // This is utilized to indicate that the value loaded into the opcode
   // buffer is not a standard opcode; this occurs for faults, breakpoints,
   // and when execution is attempted whilst the Thumb state bit (T-bit) is
   // clear.

   wire        op_sel_lo    = ( ~op_nuse_auto & iaex_q[0] |
                                op_use_fetch & ~iaex_q[0] );

   wire        op_sel_hi    = ( op_use_fetch & iaex_q[0] |
                                cfg_hwf & ~op_nuse_auto & ~iaex_q[0] );

   wire        op_sel_iq    = ~cfg_hwf & ~op_nuse_auto & ~iaex_q[0];

   wire [15:0] op_std_nxt   = ( {16{op_sel_lo}} & fe_data_lo[15:0] |
                                {16{op_sel_hi}} & fe_data_hi[15:0] |
                                {16{op_sel_iq}} & iq_q[15:0] |
                                {16{op_sel_dbg}} & dbg_opcode[15:0] );

   wire        op_s_std_nxt = ( op_sel_lo & fe_data_lo[16] |
                                op_sel_hi & fe_data_hi[16] |
                                op_sel_iq & iq_s_q );

   // --------
   // If the opcode currently isn't special, then further manipulate it if
   // we have a halt/idle request, or a BKPT instruction that should generate
   // a fault.

   wire        halt_op     = dbg_halt_req & ~run_hlt;
   wire        idle_op     = ~op_s_std_nxt & ~halt_op & dif_cpu_force_idle;

   wire        op_s_force  = halt_op | idle_op;
   wire        op_s_nxt    = op_s_std_nxt | op_s_force;
   wire        op_std_bkpt = {op_std_nxt[15], op_std_nxt[13:8]} == 7'b1_111110;
   wire        op_bkpt_udf = op_std_bkpt & ~debug_en & ~op_s_nxt;

   wire [15:0] op_nxt      = { op_std_nxt[15],
                               op_std_nxt[14] | op_bkpt_udf,
                               op_std_nxt[13] & ~op_s_force | idle_op,
                               op_std_nxt[12] & ~op_s_force | halt_op,
                               op_std_nxt[11:0] };

   // -------------------------------------------------------------------------
   // Instruction queue selection logic
   // -------------------------------------------------------------------------

   // The IQ holds the next instruction to be executed unless an interrupt is
   // pending. When an interrupt is pending the IQ holds both the exception
   // number of the pending interrupt and the interrupt jitter suppression
   // counter. The counter is reset to the value currently on the IRQLATENCY
   // pins whenever a new interrupt is detected, or if the pending interrupt
   // changes.

   // Interrupts are masked whenever we are in debug state to permit a clean
   // transition between C_MASKINT states, and also during reset.

   wire [ 5:0] int_num       = {6{delay_mode}} & iq_q[5:0];
   wire        int_pend      = nvm_int_pend_i & ~int_mask;
   wire        int_num_diff  = nvm_int_pend_num_i != int_num;

   wire        int_allow_new = ( int_pend & ~atomic_q & ~iq_is_irq |
                                 int_pend & atomic_q & ~iq_q[15] |
                                 int_num_diff );

   wire        reset_count   = int_pend & int_allow_new;

   wire [ 8:0] int_count_sub = {int_count[7:0], ~count_active} - 1'b1;
   wire [ 7:0] int_count_dec = int_count_sub[8:1];
   wire [ 7:0] int_count_nxt = reset_count ? irq_latency_i : int_count_dec;
   wire        going_atomic  = atomic_en & atomic_nxt;
   wire        iq_flush      = ~atomic_q & going_atomic & hready_i;

   // --------
   // Construct the 16-bit entry to be stored in the IQ when an interrupt is
   // pending, and determine when it should be used. Under normal code
   // execution, IQ is only enabled when HREADY is high; when operating as the
   // jitter counter, the IQ must be freely enabled.

   wire [15:0] irq_data   = { (iq_flush ? iq_is_irq : ~atomic_q) | int_pend,
                              1'b1,
                              int_count_nxt[7:0],
                              int_pend ? nvm_int_pend_num_i : iq_q[5:0] };

   wire        iq_use_irq = reset_count | delay_mode | iq_flush;
   wire        iq_free_en = iq_use_irq;

   // --------

   // The instruction queue consists of one 16-bit entry, typically used to
   // hold the upper half of the AHB bus data on a fetch. The entry can also
   // take data from the lower-half of the AHB bus, which is only used in the
   // case of a half-word aligned 32-bit instruction, where the first half
   // (HW1) is held static in the opcode buffer, whilst the second half (HW2)
   // is loaded into the queue buffer.

   // Like the opcode buffer, the queue buffer also has a special bit (iq_s_q)
   // used to track faults, breakpoints and execution outside of Thumb state.

   wire        iq_sel_hi      = ( ~op_nuse_auto & ~op_hold |
                                  cfg_hwf & iq_use_nxt & op_sel_hi |
                                  op_use_fetch & ~op_hold ) & ~iq_use_irq;

   wire        iq_sel_lo      = iq_use_nxt & op_sel_lo & ~iq_use_irq;

   wire [15:0] iq_nxt         = ( {16{iq_sel_hi}} & fe_data_hi[15:0] |
                                  {16{iq_sel_lo}} & fe_data_lo[15:0] |
                                  {16{iq_use_irq}} & irq_data[15:0] );

   wire        atomic_exit    = atomic_q & atomic_en & ~atomic_nxt;

   wire        iq_s_force_one = ( iq_use_irq & ~atomic_q |
                                  atomic_exit & int_pend );

   wire        iq_s_nxt       = ( iq_sel_hi & fe_data_hi[16] |
                                  iq_sel_lo & fe_data_lo[16] |
                                  iq_s_sel_one | iq_s_force_one );

   wire        iq_en_auto     = ~cfg_hwf & ~op_nuse_auto & iaex_q[0] & ~op_hold;
   wire        iq_en_fetch    = ~cfg_hwf & op_use_fetch & ~iaex_q[0] & ~op_hold;

   wire        iq_en          = ( iq_en_auto | iq_en_fetch |
                                  iq_use_nxt & ~op_sel_iq | iq_s_force_one );

   // -------------------------------------------------------------------------
   // Pre-decode whether IQ will be a branch like instruction
   // -------------------------------------------------------------------------

   // If the IQ contains a branch like instruction, then sequential prefetch is
   // disabled so as to reduce power consumption. As the IQ is also utilized to
   // implement the interrupt jitter counter, this requires a separate register
   // in order to record whether the original IQ instruction was a branch if it
   // is subsequently replaced with the jitter count.

   // Implement small decoder to detect "ADD PC,Rn", "B <label>", "BX/BLX Rn",
   // "CPY/MOV PC,Rn", and "POP {...,PC}" residing in the queue entry.

   wire        iq_rd_nxt_pc  = {iq_nxt[7],iq_nxt[2:0]} == 4'b1_111;

   wire        iq_nxt_add_pc = (iq_nxt[15:8] == 8'b01000100) & iq_rd_nxt_pc;
   wire        iq_nxt_branch = iq_nxt[15:11] == 5'b11100;
   wire        iq_nxt_bx_blx = iq_nxt[15:8] == 8'b01000111;
   wire        iq_nxt_cpy_pc = (iq_nxt[15:8] == 8'b01000110) & iq_rd_nxt_pc;
   wire        iq_nxt_pop_pc = iq_nxt[15:8] == 8'b10111101;

   wire        iq_branch_nxt = ( iq_nxt_add_pc | iq_nxt_branch |
                                 iq_nxt_bx_blx | iq_nxt_cpy_pc |
                                 iq_nxt_pop_pc );

   // -------------------------------------------------------------------------
   // Register read-port pre-decoder source selection
   // -------------------------------------------------------------------------

   // The bulk of register pointer addresses are determined during the fetch-
   // phase for the next opcode to appear in decode. For instructions following
   // multi-cycle operations, this requires using the opcode currently in
   // decode as the register pre-decode source. Note that not all bits of the
   // pd_op are used, but the full 16-bits are generated to facilitate
   // comprehension.

   wire [15:0] pd_op = ( {16{~pdec_sel_old}} & op_std_nxt |
                         {16{ pdec_sel_old}} & op_q );

   // -------------------------------------------------------------------------
   // Read-port A control
   // -------------------------------------------------------------------------

   // Pre-decode the register pointer from the pre-decode source opcode.
   // Note that only five possible source positions are supported, and all
   // other operations must be multi-cycle:

   wire [3:0]  pd_op_15_13_11_9 = {pd_op[15],pd_op[13],pd_op[11],pd_op[9]};
   wire [3:0]  pd_op_15_13_12_9 = {pd_op[15],pd_op[13],pd_op[12],pd_op[9]};

   wire        ra_sel_720   = {pd_op[15:12],pd_op[10]} == 5'b0100_1;

   wire        ra_sel_z20   = pd_op[15:12] == 4'b0100;

   wire        ra_sel_108   = ( (pd_op[15:14] == 2'b11) |
                                (pd_op[15:13] == 3'b001) );

   wire        ra_sel_z53   = ( (pd_op_15_13_11_9 == 4'b1_1_0_1) |
                                ({pd_op[15],pd_op[13:12]} == 3'b0_01) |
                                (pd_op[14:13] == 2'b11) |
                                (pd_op[14:12] == 3'b000) |
                                (pd_op_15_13_12_9 == 4'b1_11_1) );

   wire        ra_sel_r13   = ( ({pd_op[15],pd_op[12],pd_op[9]} == 3'b1_1_0) |
                                ({pd_op[15],pd_op[13:11]} == 4'b1_101) |
                                ({pd_op[15],pd_op[13:12]} == 3'b1_01) );

   wire [3:0]  ra_addr_pdec = { ra_sel_720 & pd_op[7] | ra_sel_r13,
                                {3{ra_sel_z20}} & pd_op[2:0] |
                                {3{ra_sel_108}} & pd_op[10:8] |
                                {3{ra_sel_z53}} & pd_op[5:3] |
                                {3{ra_sel_r13}} & 3'b101 };

   wire [3:0]  ra_addr_nxt  = ( {4{~ra_addr_nsel_pdec}} & ra_addr_pdec |
                                {4{ra_addr_sel_r13}} & 4'd13 );

   // Reduce power by loading the register pointer only when required.
   // For the pre-decode this is relatively straight forward to deduce:

   wire        ra_addr_en_pdec = {pd_op[15:14],|pd_op[13:12]} != 3'b11_1;

   wire        ra_addr_en = ((ra_addr_nsel_pdec | ra_addr_en_pdec) &
                             ~ra_addr_hold );

   // -------------------------------------------------------------------------
   // Read-port B control
   // -------------------------------------------------------------------------

   // Pre-decode the register pointer from the pre-decode source opcode.
   // Note that only three possible source positions are supported, and all
   // other operations must be multi-cycle.

   wire        rb_sel_653 = {pd_op[12],pd_op[10]} == 2'b0_1;
   wire        rb_sel_z53 = pd_op[12] == 1'b0;
   wire        rb_sel_z86 = pd_op[12] == 1'b1;

   wire [3:0]  rb_addr_pdec = { rb_sel_653 & pd_op[6],
                                {3{rb_sel_z53}} & pd_op[5:3] |
                                {3{rb_sel_z86}} & pd_op[8:6] };

   wire [3:0]  rb_addr_nxt = ( {4{~rb_addr_nsel_pdec}} & rb_addr_pdec |
                               {4{rb_addr_sel_30}}   & op_q[3:0] |
                               {4{rb_addr_sel_z20}}  & {1'b0, op_q[2:0]} |
                               {4{rb_addr_sel_108}}  & {1'b0, op_q[10:8]} |
                               {4{rb_addr_sel_list}} & list_reg |
                               {4{rb_addr_sel_aux}}  & 4'hF );

   // Reduce power by only loading the register pointer when required.

   wire        rb_addr_en_pdec = ( ({pd_op[15:13],pd_op[11]} == 4'b010_0) |
                                   ({pd_op[15],pd_op[13:10]} == 5'b0_0110) |
                                   (pd_op[15:12] == 4'b0101) );

   wire        rb_addr_en = (( rb_addr_nsel_pdec | rb_addr_en_pdec ) &
                             ~rb_addr_hold );

   // -------------------------------------------------------------------------
   // Instruction fetch logic
   // -------------------------------------------------------------------------

   // The natural stride is to perform a fetch every other cycle to sustain
   // 16-bits per cycle throughput; this is regulated via fetching when the
   // least-significant bit of IAEX is clear. Flow changes introduced via
   // branches, exceptions and reset require additional forced fetching.
   // Without the IO port, loads and stores take priority over fetching and
   // consume multiple execute cycles to ensure that the instruction queue is
   // never starved. When the single-cycle IO port is present, the normal
   // fetch rate must be sustained.

   // When executing in 16-bit fetch only mode, the opcode is never loaded from
   // the instruction queue, and is always fetched directly from AHB into the
   // opcode buffer. If the opcode buffer has been loaded with an instruction
   // that will definitely branch, then the following fetch can be suppressed.
   // For 32-bit fetch operation, this is handled by the instruction queue
   // buffer iq_branch_q being used.

   wire        fetch_skip;

   generate
      if((CBAW != 0) || (HWF != 0)) begin : gen_hwf_0a

         wire state_multi = ( run_ldm | run_stm | run_mul | run_ldr | run_str |
                              run_wfx );

         wire op_will_fe  = ( exe_fetch_force & ~fmt_br1 | // Will branch
                              fmt_br2 | pre_br3 |          // Must branch/fault
                              fmt_lm2 & lm2_op_hold );     // POP {...,PC}

         assign fetch_skip = cfg_hwf & state_multi & op_will_fe;

      end else begin : gen_hwf_0b

         assign fetch_skip = 1'b0;

      end
   endgenerate

   // --------
   // For 32-bit fetching, a fetch is required every other instruction. This is
   // achieved by fetching when executing a half-word aligned instruction. For
   // 16-bit fetching, a fetch is required for every instruction executed.

   wire        fetch_needed;

   generate
      if(CBAW != 0) begin : gen_hwf_1a

         assign fetch_needed = cfg_hwf | ~iaex_q[0];

      end else if(HWF != 0) begin : gen_hwf_1b

         assign fetch_needed = 1'b1;

      end else begin : gen_hwf_1c

         assign fetch_needed = ~iaex_q[0];

      end
   endgenerate


   // --------
   // Fetching is stalled whenever explicitly requested, or when a load/store
   // is being executed that does not make use of the IO port.

   wire        ls_fetch_stall = ls_trans & (~io_match | ls_multi);

   wire        fetch_seq  = ( fetch_needed & ~fetch_stall & ~iq_branch_q &
                              ~op_s_q & ~fetch_skip );

   wire        fetch      = ( fetch_seq & ~ls_fetch_stall & ~fault_q |
                              fetch_force );

   wire        spec_trans = ls_trans | fetch_seq | fetch_force;

   // -------------------------------------------------------------------------
   // AHB address selection
   // -------------------------------------------------------------------------

   // AHB address can come from one of five sources depending on the current
   // execution state and instruction. The default position is to always issue
   // an instruction fetch as this guarantees some consistency between neigh-
   // boring cycles which aids in reducing power consumption.

   // The single cycle IO port introduces the requirement for a fetch to be
   // issued in parallel with the access to prevent instruction queue starva-
   // tion. This requires examination of the load/store address, and an IO port
   // match to be reported via "io_match" in order to determine whether AHB
   // should use the load/store address or the fetch address.

   // When no IO port is present, the selection of load/store vs fetch address
   // can be made independently from the address calculation based on current
   // state and instruction opcode.

   wire [31:0] addr_vec     = { vtor_31to8, 8'b0 };
   wire [31:0] addr_iq      = { 24'b0, ipsr_q[5:0], 2'b0 };
   wire        ls_sel_add   = ls_trans & ~ls_use_ra & ~ls_use_iq | fe_use_add;

   wire [31:0] addr_a       = ({32{ls_use_ra}}  & ra_value[31:0] |
                               {32{ls_sel_add}} & add_res |
                               {32{ls_use_vec}} & addr_vec[31:0] |
                               {32{ls_use_iq}}  & addr_iq[31:0] );

   wire        mask_a0      = align_half | fetch_force;

   wire [31:0] addr_aligned = {addr_a[31:3],
                               addr_a[2] & ~align_dword,
                               addr_a[1] & ~align_word,
                               addr_a[0] & ~mask_a0 };

   // --------

   wire        fe_sel_seq   = ~(fe_use_iaex | fe_use_rb);

   wire [31:0] addr_b       = ({32{fe_use_iaex}} & {iaex_q,1'b0} |
                               {32{fe_sel_seq}} & {fe_addr, 1'b0} |
                               {32{fe_use_rb}} & {rb_value[31:1],1'b0} );

   // --------

   wire        ahb_sel_a    = ls_trans & ~io_match | fe_use_add;

   wire [31:0] ahb_addr     = ahb_sel_a ? addr_aligned : addr_b;

   // -------------------------------------------------------------------------
   // Determine AHB sideband properties
   // -------------------------------------------------------------------------

   // Discard MPU generated attributes if MPU is not present. Real attributes
   // will be generated inside the matrix for both processor and debugger.

   wire [ 2:0] mpu_scb_a;
   wire [ 2:0] mpu_scb_b;

   generate
      if((CBAW != 0) || (MPU != 0)) begin : gen_mpu_0a

         assign mpu_scb_a = {3{cfg_mpu}} & mpu_scb_a_i[2:0];
         assign mpu_scb_b = {3{cfg_mpu}} & mpu_scb_b_i[2:0];

      end else begin : gen_mpu_0b

         wire [5:0] unused = { mpu_scb_a_i[2:0], mpu_scb_b_i[2:0] };
         assign { mpu_scb_a[2:0], mpu_scb_b[2:0] } = 6'b0;

      end
   endgenerate

   // --------

   wire [ 2:0] ahb_scb;

   generate
      if((CBAW != 0) || (IOP != 0)) begin : gen_iop_4a

         assign ahb_scb = (~cfg_iop | ahb_sel_a) ? mpu_scb_a : mpu_scb_b;

      end else begin : gen_iop_4b

         wire [2:0] unused = mpu_scb_b[2:0];
         assign ahb_scb = mpu_scb_a[2:0];

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Alignment and MPU fault generation
   // -------------------------------------------------------------------------

   // ARMv6-M requires that unaligned load and store attempts generate faults.
   // In addition, fetches from XN regions, and transactions prohibited by the
   // MPU must also generate appropriate faults.

   // If no MPU is present, then it is not possible for an IO port transaction
   // to generate any fault other than an alignment one.

   wire        align_fault = ( addr_a[1] & align_word |
                               addr_a[0] & align_half );

   wire        check_fault_a = ls_trans | fe_use_add;
   wire        check_fault_b = fetch & ~fe_use_add;

   wire        kill_iop, kill_ahb;

   generate
      if(CBAW != 0) begin : gen_iop_5a

         wire kill_ahb_iop = ( check_fault_a & mpu_fault_a_i |
                               check_fault_b & mpu_fault_b_i );

         wire kill_ahb_std = spec_trans & mpu_fault_a_i;
         wire killable_iop = cfg_iop & cfg_mpu;

         assign kill_iop = killable_iop & ls_trans & io_match & mpu_fault_a_i;
         assign kill_ahb = cfg_iop ? kill_ahb_iop : kill_ahb_std;

      end else if((IOP != 0) && (MPU != 0)) begin : gen_iop_5b

         assign kill_iop = ls_trans & io_match & mpu_fault_a_i;

         assign kill_ahb = ( check_fault_a & mpu_fault_a_i |
                             check_fault_b & mpu_fault_b_i );

      end else if(IOP != 0) begin : gen_iop_5c

         assign kill_iop = 1'b0;

         assign kill_ahb = ( check_fault_a & mpu_fault_a_i |
                             check_fault_b & mpu_fault_b_i );

      end else begin : gen_iop_5d

         wire [1:0] unused = { check_fault_a, check_fault_b };
         assign kill_iop = 1'b0;
         assign kill_ahb = spec_trans & mpu_fault_a_i;

      end
   endgenerate

   wire       fault_gen = ~preempt & (kill_iop | kill_ahb | align_fault);

   // -------------------------------------------------------------------------
   // Load/store data-phase fault detection
   // -------------------------------------------------------------------------

   // AHB faults are two cycle; register the fault from the first cycle to
   // improve timing in the second cycle:

   wire       fault_msk = ( run_rst & rst_cyc_2 |
                            run_irq & irq_cyc_1 |
                            run_rfe & rfe_cyc_1 );

   wire       fault_ext = mtx_cpu_resp_i & ~fault_msk;
   wire       fault_nxt = ~hready_i & fault_ext | hready_i & fault_gen;
   wire       fault_en  = fault_nxt | fault_q & hready_i & ~fault_keep;

   // -------------------------------------------------------------------------
   // Generate IAEX enable and OP enable terms
   // -------------------------------------------------------------------------

   wire        op_en            = ~op_hold;
   wire        iaex_io_suppress = align_fault | kill_iop | int_ready_q;

   wire        iaex_en          = ( iaex_en_io & io_match & ~iaex_io_suppress |
                                    ~iaex_hold );

   // -------------------------------------------------------------------------
   // Factor address phase faults into state enable
   // -------------------------------------------------------------------------

   wire       state_en_fault = run_exe & (align_fault | kill_iop);
   wire       state_en       = state_en_std | state_en_fault;

   // -------------------------------------------------------------------------
   // AHB control selection
   // -------------------------------------------------------------------------

   wire        ahb_attempt   = fetch | (ls_trans & ~io_match);
   wire        ahb_trans     = ahb_attempt & ~kill_ahb & ~align_fault;
   wire        ahb_instr     = ~(ls_trans & ~io_match);
   wire        ahb_priv      = priv & ~force_user;
   wire        ahb_write     = ls_trans & ls_write & ~io_match;

   wire        ahb_auto_half = cfg_hwf & ahb_instr;
   wire [ 1:0] ahb_addr_size = {~ahb_addr[1], ahb_addr[1]};
   wire [ 1:0] ahb_auto_size = ahb_auto_half ? 2'b01 : ahb_addr_size;
   wire        ahb_sel_auto  = ahb_instr | ~(base_sel_byte | base_sel_half);
   wire        ahb_sel_half  = ~ahb_instr & base_sel_half;

   wire [ 1:0] ahb_size      = ( {2{ahb_sel_auto}} & ahb_auto_size |
                                 {2{ahb_sel_half}} & 2'b01 );

   // -------------------------------------------------------------------------
   // Register file write-port data and address selection
   // -------------------------------------------------------------------------

   wire [31:0] ipsr_ext       = {26'b0, ipsr_q[5:0]};
   wire [31:0] apsr_ext       = {apsr_q[3:0], 28'b0};
   wire [31:0] control_ext    = {30'b0, spsel_q, npriv_q};
   wire [31:0] primask_ext    = {31'b0, primask_q};
   wire [31:0] link_value     = {pc_value[31:1], 1'b1};
   wire        exc_use_tail   = ~run_stm;
   wire [ 1:0] exc_ret_tail   = { iaex_q[2], iaex_q[2:1] == 2'b11 };
   wire [ 1:0] exc_ret_norm   = { ~handler, spsel_q & ~handler };

   // --------

   wire [31:0] exc_return     = { {28{1'b1}},
                                  exc_use_tail ? exc_ret_tail : exc_ret_norm,
                                  2'b01 };

   wire [31:0] wr_data_misc   = ( {32{wr_data_sel_msp}}     & sp_main |
                                  {32{wr_data_sel_psp}}     & sp_process |
                                  {32{wr_data_sel_primask}} & primask_ext |
                                  {32{wr_data_sel_ipsr}}    & ipsr_ext |
                                  {32{wr_data_sel_apsr}}    & apsr_ext );

   wire [31:0] wr_data        = ( wr_data_misc |
                                  {32{wr_data_sel_alu}}     & alu_res |
                                  {32{wr_data_sel_spu}}     & spu_res |
                                  {32{wr_data_sel_aux}}     & aux_q |
                                  {32{wr_data_sel_control}} & control_ext |
                                  {32{wr_data_sel_link}}    & link_value |
                                  {32{wr_data_sel_rb}}      & rb_value |
                                  {32{wr_data_sel_ret}}     & exc_return );

   // --------

   wire        wr_addr_sel_ra = ~( wr_addr_sel_z20 | wr_addr_sel_108 |
                                   wr_addr_sel_r14 | wr_addr_sel_rb |
                                   wr_addr_sel_hw2 );

   wire [3:0]  wr_addr        = ( {4{wr_addr_sel_z20}} & {1'b0,op_q[2:0]} |
                                  {4{wr_addr_sel_108}} & {1'b0,op_q[10:8]} |
                                  {4{wr_addr_sel_ra}}  & ra_addr_q |
                                  {4{wr_addr_sel_r14}} & 4'd14 |
                                  {4{wr_addr_sel_rb}}  & rb_addr_q |
                                  {4{wr_addr_sel_hw2}} & hw2[11:8] );

   // -------------------------------------------------------------------------
   // Generate standard flag result sets
   // -------------------------------------------------------------------------

   wire [3:0]  std_add_flags = {alu_nflag, alu_zflag, add_cflag, add_vflag};
   wire [3:0]  std_bit_flags = {alu_nflag, alu_zflag, cflag, vflag};
   wire [3:0]  std_rot_flags = {rot_nflag, rot_zflag, rot_cflag, vflag};

   // -------------------------------------------------------------------------
   // Update logic for APSR N,Z,C and V flags
   // -------------------------------------------------------------------------

   wire [3:0]  apsr_nxt = ( {4{apsr_sel_add}} & std_add_flags |
                            {4{apsr_sel_bit}} & std_bit_flags |
                            {4{apsr_sel_rot}} & std_rot_flags |
                            {4{apsr_sel_rb}}  & rb_value[31:28] |
                            {4{apsr_sel_dbg}} & aux_q[31:28] |
                            {4{apsr_sel_rfe}} & bus_rdata[31:28] );

   // -------------------------------------------------------------------------
   // IPSR next state computation
   // -------------------------------------------------------------------------

   wire [ 5:0] ipsr_bus    = {6{fault_q}} | bus_rdata[5:0];

   wire        ipsr_sel_iq = ipsr_sel_vector;
   wire        ipsr_sel_rd = ipsr_sel_bus;

   wire [ 5:0] ipsr_nxt    = ( {6{ipsr_sel_iq}} & iq_q[5:0] |
                               {6{ipsr_sel_rd}} & ipsr_bus[5:0] );

   // -------------------------------------------------------------------------
   // Instruction address selection logic
   // -------------------------------------------------------------------------

   wire [30:0] iaex_nxt = ( {31{~iaex_nsel_inc}} & iaex_inc |
                            {31{iaex_sel_add}}   & add_res[31:1] |
                            {31{iaex_sel_rb}}    & rb_value[31:1] |
                            {31{iaex_sel_bus}}   & bus_rdata[31:1] );

   // -------------------------------------------------------------------------
   // Auxiliary buffer control
   // -------------------------------------------------------------------------

   // The auxiliary buffer is used for four purposes. Firstly it acts as an
   // address/base-register copy for LDM, STM, PUSH and POP instructions to
   // enable base-restore in case of an exception or early termination in case
   // of an interrupt. Secondly, it is available as a read-port source, and
   // as such a bus write-data source; this is utilized to enable storing of
   // the XPSR and PC for exception entry. Thirdly, if debug is present, it
   // acts as the DCRDR, acting as a proxy for all state read and writes.
   // Finally, for implementations with the iterative multiplier, it acts as
   // the product accumulator, allowing the source registers to retain their
   // initial values such that an interrupt can be taken mid-way through.

   wire [31:0] aux_nxt_mul;

   generate
      if((CBAW != 0) || (SMUL != 0)) begin : gen_smul_8a

         wire [31:0] smul_init = {30'b0, ra_value[31] & rb_value[0], 1'b0};
         wire [31:0] smul_step = {alu_res[30:0], 1'b0};
         assign aux_nxt_mul    = ( {32{cfg_smul & aux_sel_mul0}} & smul_init |
                                   {32{cfg_smul & aux_sel_mul1}} & smul_step );

      end else begin : gen_smul_8b

         wire [1:0] unused = {aux_sel_mul0, aux_sel_mul1};
         assign aux_nxt_mul = 32'b0;

      end
   endgenerate

   // --------

   wire [31:0] aux_nxt_dbg;

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_6a

         wire [31:0] control     = { 6'b0, spsel_q, npriv_q, 24'b0 };
         wire        aux_sel_dif = run_hlt & msl_dbg_aux_en;

         assign aux_nxt_dbg  = ( {32{aux_sel_dif}} & dif_wdata |
                                 {32{aux_sel_control}} & control );

      end else begin : gen_dbg_6b

         wire unused = aux_sel_control;
         assign aux_nxt_dbg = 32'b0;

      end
   endgenerate

   // --------

   wire [31:0] epsr    = {7'b0, tbit_q, 14'b0, extend_q & run_irq, 9'b0};

   wire [31:0] aux_add = { add_res[31:3],
                           add_res[2] & ~align_dword,
                           add_res[1:0]} ;

   wire [31:0] aux_nxt = ( {32{aux_sel_add}} & aux_add |
                           {32{aux_sel_ra}} & ra_value |
                           {32{aux_sel_iaex}} & {iaex_q, 1'b0} |
                           {32{aux_sel_misc}} & wr_data_misc |
                           {32{aux_sel_epsr}} & epsr |
                           aux_nxt_mul |
                           aux_nxt_dbg );

   // -------------------------------------------------------------------------
   // CONTROL register control
   // -------------------------------------------------------------------------

   // CONTROL<1> is set based on EXC_RETURN<2> obtained from AHB for a
   // POP {PC}, or from register for BX. Additionally it may be set via
   // MSR from register bit<1>, or debug from DCRDR<25>

   // EXC_RETURN driven stack-pointer selection is overridden by whether a
   // return is to Thread or Handler mode such that any return to Handler
   // always uses the MSP.

   wire spsel_nxt = ( spsel_sel_bus & bus_rdata[2] & bus_rdata[3] |
                      spsel_sel_rb1 & rb_value[1] |
                      spsel_sel_rb2 & rb_value[2] & rb_value[3] |
                      spsel_sel_dbg & aux_q[25] );

   wire npriv_nxt;

   generate
      if((CBAW != 0) || (USER != 0)) begin : gen_user_1a

         assign npriv_nxt = ( cfg_user & npriv_sel_rb & rb_value[0] |
                              cfg_user & npriv_sel_dbg & aux_q[24] );

      end else begin : gen_user_1b

         wire [1:0] unused = { npriv_sel_rb, npriv_sel_dbg };
         assign npriv_nxt = 1'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // T-bit register control
   // -------------------------------------------------------------------------

   // The Thumb state bit (T-bit) is updated by the BX and BLX instructions
   // based on the LSB of the register value, and by POP {PC} from the
   // LSB of the loaded-PC value, and from XPSR[24] pulled from the stack
   // on an exception return, or from XPSR[24] from a debug write:

   wire        tbit_nxt = ( tbit_sel_rb  & rb_value[0] |
                            tbit_sel_bus & bus_rdata[0] |
                            tbit_sel_rfe & bus_rdata[24] |
                            tbit_sel_dbg & aux_q[24] );

   // -------------------------------------------------------------------------
   // Combined standard and IO port register write enable
   // -------------------------------------------------------------------------

   // The register file is enabled for writes when a standard write-enable is
   // requested, or when an IO port write-enable is requested and the current
   // data transaction is an IO port match and is not faulted or interrupted.

   wire        wr_io_suppress = align_fault | mpu_fault_a_i | int_ready_q;

   wire        wr_en          = ( wr_en_std |
                                  wr_en_io & io_match & ~wr_io_suppress );

   // -------------------------------------------------------------------------
   // Compress register write-enable
   // -------------------------------------------------------------------------

   // R15 is never written directly via the wr_addr, so force wr_addr to
   // all ones whenever no register write is being performed:

   wire [ 3:0] wr_addr_en = {4{~hready_i | ~wr_en}} | wr_addr;

   // -------------------------------------------------------------------------
   // Specialized register enables for stack-pointers
   // -------------------------------------------------------------------------

   // The main and process stack-pointers can be written indirectly via
   // use of R13, or directly via their respective enables:

   wire        sp_en  = wr_addr_en == 4'hD;

   wire        msp_en = sp_main_en    | (~spsel_q & sp_en);
   wire        psp_en = sp_process_en | ( spsel_q & sp_en);

   // -------------------------------------------------------------------------
   // Clock gate control for register file
   // -------------------------------------------------------------------------

   // Statistically, most register file writes will be to r0 through r4. Use
   // this to produce two separate clock enables to aid in power reduction.

   wire        wr_en_early = (wr_en_std | wr_en_io) & hready_i;

   wire        wr_addr_r0_to_r4 = wr_addr < 4'h5;

   wire        rclk0_en = wr_en_early &  wr_addr_r0_to_r4;
   wire        rclk1_en = wr_en_early & ~wr_addr_r0_to_r4;

   // -------------------------------------------------------------------------
   // Data gate control for register file
   // -------------------------------------------------------------------------

   // The upper register file entries are rarely written, reduce power by
   // reducing toggling of fan-out to these registers. Note that the
   // stack-pointers have alternative enable means, so this masked value
   // is not used by MSP or PSP.

   wire        wr_data_mask = ~wr_en | wr_addr_r0_to_r4;

   wire [31:0] wr_data_opt  = {32{~wr_data_mask}} & wr_data;

   // -------------------------------------------------------------------------
   // Stack pointer write data
   // -------------------------------------------------------------------------

   // The stack pointers have specialized write data, firstly to narrow the
   // write data width down to 30-bits, and secondly to factor in the double
   // word (64-bit) aligned write that occurs on exceptions.

   wire [29:0] wr_data_sp = { wr_data[31:3],
                              wr_data[2] & ~align_dword |
                              extend_q & unalign_dword };

   // -------------------------------------------------------------------------
   // Interrupt sampling control
   // -------------------------------------------------------------------------

   // Interrupts are sticky and are cleared only when an explicit re-sample is
   // performed as part of exception return occurs when there is no pending
   // interrupt from the NVIC. A pending interrupt from the NVIC always causes
   // the int_ready register to become set.

   // Execution in halted debug state causes any pending interrupt to be
   // flushed until debug state is exited.

   wire        int_queued    = iq_is_irq & ~atomic_q;
   wire        int_ready_nxt = (nvm_int_pend_i | int_queued) & ~int_mask;
   wire        int_ready_en  = int_ready_nxt | int_resample | int_mask;

   // -------------------------------------------------------------------------
   // Generate sequential indicator for program counter / instruction trace
   // -------------------------------------------------------------------------

   // Instruction fetch is sequential if selected from the incrementer, except
   // when being force for Lockup (via iaex_sel_add), or when being masked for
   // MSR, MRS, DSB or DMB explicitly.

   wire        iaex_seq = ( ~iaex_nsel_inc & ~iaex_sel_add |
                            iaex_is_seq );

   // -------------------------------------------------------------------------
   // Generate code hint signals
   // -------------------------------------------------------------------------

   // Determine whether next instruction to be executed is a branch, branch-
   // like, or whether the processor cannot possible continue sequential fetch.
   // This logic runs a stage before the main decoder, so has to perform its
   // own decoding of any queued instruction plus incoming opcodes from HRDATA.

   wire        hint_mask    = ( run_pfu & pfu_cyc_1 |
                                fetch_force & ~(run_pfu & pfu_cyc_2) );

   wire        hint_pdec_ok = ( (pdec_sel_old | hready_i & ~mtx_cpu_resp_i) &
                                ~hint_mask );

   wire        pd_rd_is_pc  = {pd_op[7],pd_op[2:0]} == 4'b1_111;

   wire        pd_is_add_pc = (pd_op[15:8] == 8'b01000100) & pd_rd_is_pc;
   wire        pd_is_branch = pd_op[15:11] == 5'b11100;
   wire        pd_is_bx_blx = pd_op[15:8] == 8'b01000111;
   wire        pd_is_cpy_pc = (pd_op[15:8] == 8'b01000110) & pd_rd_is_pc;
   wire        pd_is_pop_pc = pd_op[15:8] == 8'b10111101;
   wire        pd_special   = pdec_sel_old ? op_s_q : op_s_nxt;

   wire        t32_in_exe   = fmt_sy5 & run_exe;

   wire        poppc_active = ( fmt_lm2 & lm2_pc_bit & lm2_isn_pop & ~run_pfu |
                                run_ldm & ldm_pop_pc );

   wire        pd_br_simple = ( pd_special | pd_is_add_pc | pd_is_branch |
                                pd_is_bx_blx | pd_is_cpy_pc );

   wire        pd_br_type   = (pd_br_simple | pd_is_pop_pc) & hint_pdec_ok;

   wire        nonseq_type  = ( t32_in_exe |     // Executing 32-bit prefix
                                ~tbit_q |        // T-bit is clear
                                int_ready_q |    // Interrupt to be taken
                                run_alt |        // Running fault / idle
                                state_sel_lck |  // Going into Lockup state
                                run_lck |        // In Lockup state
                                going_atomic |   // Going into atomic
                                atomic_q );      // Inside atomic

   wire        hint_branch  = ( nonseq_type |
                                pd_br_type |     // Branch type in predecode
                                poppc_active );  // Executing POP {...PC}

   // --------
   // Perform pre-decode of conditional backwards and forwards branch. The
   // direction of the branch can be extracted from the sign bit (bit[7]).

   wire        pd_is_b_cond = {pd_op[15:12], &pd_op[11:9]} == 5'b1101_0;

   wire        hint_bcc_fw  = pd_is_b_cond & ~pd_op[7] & hint_pdec_ok;
   wire        hint_bcc_bk  = pd_is_b_cond &  pd_op[7] & hint_pdec_ok;

   // --------
   // Determine whether the next AHB address cycle could possibly be a
   // processor data-access. This is optimistic, in that it may erroneously
   // flag non-data transactions, but is guaranteed to occur before any data-
   // access.

   // Pre-decode all load/store instructions:

   wire        pd_is_ls0    = pd_op[15:13] == 3'b011;
   wire        pd_is_ls1    = pd_op[15:12] == 4'b1000;
   wire        pd_is_ls2    = pd_op[15:12] == 4'b0101;
   wire        pd_is_ls3    = pd_op[15:11] == 5'b01001;
   wire        pd_is_ls4    = pd_op[15:12] == 4'b1001;
   wire        pd_is_lm0    = pd_op[15:12] == 4'b1100;
   wire        pd_is_lm1    = {pd_op[15:12],pd_op[10:9]} == 6'b1011_10;

   wire        pd_is_ls     = ( pd_is_ls0 | pd_is_ls1 | pd_is_ls2 | pd_is_ls3 |
                                pd_is_ls4 | pd_is_lm0 | pd_is_lm1 );

   // Establish cycles which will not move onto the pre-decoded instruction:

   wire        exe_is_multi = ( ( run_exe & state_en &
                                  (exe_state_sel_ldr | exe_state_sel_str |
                                   exe_state_sel_t32 | exe_state_sel_ldm |
                                   exe_state_sel_stm ) ) |
                                (run_ldm | run_stm) & ~list_empty );

   wire        pd_ls_ignore = ( pd_br_simple & hint_pdec_ok |
                                nonseq_type );

   // Derive cases where a load/store address phase could occur next cycle:

   wire        list_nxt_empty = list_nxt == 8'b0;

   wire        dl_from_atomic = atomic_q & ~(state_en & state_sel_pfu);

   wire        dl_from_multi  = ( (run_ldm | run_stm) &
                                  ~list_empty & ~list_nxt_empty );

   wire        dl_from_exe    = ( run_exe & (fmt_lm1 | fmt_lm2) &
                                  ~list_nxt_empty );

   wire        dl_from_pdec   = ( ~atomic_q & hint_pdec_ok & ~exe_is_multi &
                                  pd_is_ls & ~pd_ls_ignore );

   wire        dl_from_excret = ldm_branch & run_ldm;

   wire        hint_data_next = ( dl_from_atomic | // Atomic but not fetch
                                  dl_from_multi |  // LDM et al not finishing
                                  dl_from_exe |    // Starting LDM/STM/PUSH/POP
                                  dl_from_pdec |   // Load/store next
                                  dl_from_excret | // POP {PC} might be RFE
                                  going_atomic );  // Going to atomic

   // -------------------------------------------------------------------------
   // Build final CODEHINT and CODENSEQ signals
   // -------------------------------------------------------------------------

   // Code hint simply requires back and forward conditional branches to be
   // masked by the presence of an overriding un-conditional branch scenario.

   // Bit[0]: If ONE, indicates that the next cycle AHB will either be IDLE,
   //         or, depending on CODENSEQ, a sequential fetch, or a fetch to a
   //         location the same as, or ahead of the previous instruction fetch.

   // Bit[1]: If ONE, indicates that the next cycle AHB will either be IDLE,
   //         or, depending on CODENSEQ, a sequential fetch, or a fetch to a
   //         location the same as, or behind the previous instruction fetch.

   // Bit[2]: If ZERO, indicates that if the next cycle AHB is a fetch, then it
   //         will be to the word following the previous instruction fetch. If
   //         ONE, it indicates that the next cycle AHB that is a fetch will
   //         not be sequential to the previous, i.e. CODENSEQ will be set.

   // Bit[3]: If ZERO, indicates that the next AHB cycle will not be a data
   //         transaction on behalf of the core, i.e. it will either be a
   //         fetch, IDLE or debugger transaction. If ONE, any access may
   //         appear in the next AHB cycle.

   wire [3:0]  code_hint    = { hint_data_next,
                                hint_branch,
                                hint_bcc_bk & ~hint_branch,
                                hint_bcc_fw & ~hint_branch  };

   // Non-sequential fetches always require a forced fetch to occur. The only
   // other time a forced fetch occurs is during the second PFU cycle, which
   // can simply be masked out as this is always guaranteed to be sequential.

   wire        code_nseq    = fetch_force & ~(run_pfu & pfu_cyc_2);

   // -------------------------------------------------------------------------
   // IO register file read-port
   // -------------------------------------------------------------------------

   wire [31:0] io_wdata_le;
   wire        io_rp_addr_en;
   wire [ 2:0] io_rp_addr_nxt;

   generate
      if((CBAW != 0) || (IOP != 0)) begin : gen_iop_6a

         // -------------------------------------------------------------------
         // Pre-decode register pointer for extra read-port
         // -------------------------------------------------------------------
         // The following identifies all store-single instructions; it also
         // activates on LDRSB, included to reduce decode complexity.

         assign io_rp_addr_en  = (( (op_nxt[15:11] == 5'b01100) |   // fmt_ls0
                                    (op_nxt[15:11] == 5'b01110) |   // fmt_ls0
                                    (op_nxt[15:11] == 5'b10000) |   // fmt_ls1
                                    (op_nxt[15:11] == 5'b01010) |   // fmt_ls2
                                    (op_nxt[15:11] == 5'b10010) ) & // fmt_ls4
                                  op_en );

         wire   io_rp_sel_z20  = ~op_nxt[15] | ~op_nxt[12];    // not fmt_ls4

         assign io_rp_addr_nxt = io_rp_sel_z20 ? op_nxt[2:0] : op_nxt[10:8];

         // -------------------------------------------------------------------
         // Implement 1/2 read-port to support simultaneous address and data
         // -------------------------------------------------------------------

         wire [31:0] io_readport [0:7];

         assign io_readport[4'h0] = r00_q;
         assign io_readport[4'h1] = r01_q;
         assign io_readport[4'h2] = r02_q;
         assign io_readport[4'h3] = r03_q;
         assign io_readport[4'h4] = r04_q;
         assign io_readport[4'h5] = r05_q;
         assign io_readport[4'h6] = r06_q;
         assign io_readport[4'h7] = r07_q;

         wire [31:0] io_rp_value = io_readport[io_rp_addr_q[2:0]];

         // -------------------------------------------------------------------
         // IO port write data
         // -------------------------------------------------------------------

         wire        io_wd_single   = ls_write & ~ls_multi;

         wire        io_wd_sel_byte = io_wd_single & base_sel_byte;
         wire        io_wd_sel_half = io_wd_single & base_sel_half;
         wire        io_wd_sel_word = io_wd_single & base_sel_word;

         wire [31:0] io_wd_b_value  = {4{io_rp_value[7:0]}};
         wire [31:0] io_wd_h_value  = {2{io_rp_value[15:0]}};
         wire [31:0] io_wd_w_value  = io_rp_value[31:0];

         wire [31:0] io_wdata_mux   = ( {32{io_buf_a_q}} & wdata_le |
                                        {32{io_wd_sel_byte}} & io_wd_b_value |
                                        {32{io_wd_sel_half}} & io_wd_h_value |
                                        {32{io_wd_sel_word}} & io_wd_w_value );

         assign io_wdata_le = {32{cfg_iop}} & io_wdata_mux;

      end else begin : gen_iop_6b

         wire [3:0] unused = { io_buf_a_q, io_rp_addr_q[2:0] };
         assign { io_rp_addr_en, io_rp_addr_nxt[2:0], io_wdata_le } = 36'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Endianess correction for IO port write-data
   // -------------------------------------------------------------------------

   wire [31:0] io_wdata;

   generate
      if(CBAW != 0) begin : gen_be_4a

         wire [31:0] io_wdata_be = f_byte_swap(io_wdata_le[31:0]);
         assign io_wdata = cfg_be ? io_wdata_be : io_wdata_le;

      end else if(BE != 0) begin : gen_be_4b

         assign io_wdata = f_byte_swap(io_wdata_le[31:0]);

      end else begin : gen_be_4c

         assign io_wdata = io_wdata_le;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // IO port buffer control
   // -------------------------------------------------------------------------

   // The IO port buffer operates in two modes. Firstly it acts as a read-data
   // buffer for single-cycle loads that occur in parallel with a fetch that
   // gets waited on the AHB interface. Secondly it acts as an address buffer
   // for load/store multiple transactions, in order to align the address and
   // data-phases.

   wire [31:0] io_buf_nxt;
   wire        io_buf_a_en, io_buf_a_nxt, io_buf_d_en, io_buf_d_nxt, io_buf_en;
   wire        io_rsel_nxt;

   generate
      if((CBAW != 0) || (IOP != 0)) begin : gen_iop_7a

         wire io_buf_data  = ( io_match & ~hready_i & ls_trans & ~ls_multi &
                               ~io_buf_d_q );

         wire io_buf_addr  = ( io_match &  hready_i & ls_trans &  ls_multi &
                               ~mpu_fault_a_i & ~align_fault );

         wire io_buf_d_set = io_buf_data | io_buf_addr & ls_write;

         assign io_buf_a_en  = io_buf_addr | io_buf_a_q;
         assign io_buf_a_nxt = io_buf_addr;
         assign io_buf_d_en  = io_buf_d_set | (hready_i & io_buf_d_q);
         assign io_buf_d_nxt = io_buf_d_set;
         assign io_buf_en    = io_buf_addr | io_buf_data & ~ls_write;

         assign io_buf_nxt   = ( {32{~hready_i}} & iop_rdata[31:0] |
                                 {32{hready_i}} & addr_aligned[31:0] );

         assign io_rsel_nxt  = (cfg_iop & ~ls_trans) | io_match;

      end else begin : gen_iop_7b

         assign { io_buf_a_en, io_buf_a_nxt, io_buf_d_en, io_buf_d_nxt,
                  io_buf_en, io_buf_nxt[31:0], io_rsel_nxt } = 38'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // HardFault or NMI active tracking for MPU
   // -------------------------------------------------------------------------

   // The MPU supports a mode where NMI and HardFault transactions can bypass
   // region lookup and instead always use the default memory map. A corner
   // case exists during an exception return from NMI to HardFault, where we
   // cannot know whether the xPSR fetch will return HardFault or a different
   // exception. To overcome this, we track NMI interrupting HardFault, and
   // combine this with the fact that we are returning to Handler to make the
   // MPU permit bypass for this one transaction.

   // VECTCLRACTIVE requested by the debugger must also clear this information.

   wire hdf_pushed_en, hdf_pushed_nxt, hfnmi;

   generate
      if((CBAW != 0) || (MPU != 0)) begin : gen_mpu_1a

         wire   hdf_stack_op    = hdf_pushed_q & ~iaex_q[2];
         wire   hfnmi_use_stack = run_rfe & (rfe_cyc_1 | rfe_cyc_2);

         wire   hdf_pushed_set  = run_irq & irq_cyc_1 & hdf_active;

         wire   hdf_pushed_clr  = ( irq_ack & ~nmi_active |
                                    run_rfe & rfe_state_sel_pfu |
                                    vect_clr_active );

         assign hdf_pushed_en   = hdf_pushed_clr | hdf_pushed_set;
         assign hdf_pushed_nxt  = hdf_pushed_set;

         assign hfnmi           = cfg_mpu & ( hfnmi_use_stack ?
                                              hdf_stack_op :
                                              n_or_h_active );

      end else begin : gen_mpu_1b

         wire unused = hdf_pushed_q;
         assign { hdf_pushed_en, hdf_pushed_nxt, hfnmi } = 3'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Register definitions
   // -------------------------------------------------------------------------

   // Only implement npriv_q if Unprivileged support is implemented. Out of
   // reset all execution is Privileged, so the register resets to zero. When
   // no Unprivileged support is required, npriv_q is hardwired to zero.

   generate
      if((CBAW != 0) || (USER != 0)) begin : gen_user_2a

         always @(posedge hclk or negedge hreset_n)
           if(~hreset_n)
             npriv_q <= 1'b0;
           else if(hready_i & npriv_en)
             npriv_q <= npriv_nxt;

      end else begin : gen_user_2b

         wire [1:0] unused = { npriv_en, npriv_nxt };

         wire zero = 1'b0;
         always @* npriv_q = zero;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Lower register file implementation
   // -------------------------------------------------------------------------

   // Generate either non-reset or reset D-type registers based upon the value
   // of the Reset-All-Registers parameter. Implementing "set" rather than
   // "reset" flops typically results in smaller area and lower power for most
   // generic cell libraries.

   generate
      if((CBAW != 0) || (RAR != 0)) begin : gen_rar_0a

         // Use HRESETn as a reset signal if requested.

         wire rar_reset_n = ~cfg_rar | hreset_n;

         // R0-to-R4 inclusive are the most frequently accessed ARM registers,
         // so implement these using their own clock.

         always @(posedge rclk0 or negedge rar_reset_n)
           if(~rar_reset_n) begin
              r00_q <= {32{1'b1}};
              r01_q <= {32{1'b1}};
              r02_q <= {32{1'b1}};
              r03_q <= {32{1'b1}};
              r04_q <= {32{1'b1}};
           end else begin
              if(wr_addr_en == 4'h0) r00_q <= wr_data[31:0];
              if(wr_addr_en == 4'h1) r01_q <= wr_data[31:0];
              if(wr_addr_en == 4'h2) r02_q <= wr_data[31:0];
              if(wr_addr_en == 4'h3) r03_q <= wr_data[31:0];
              if(wr_addr_en == 4'h4) r04_q <= wr_data[31:0];
           end

      end else begin : gen_rar_0b

         // Standard non-reset construction of R0-to-R4 using gated clock.

         always @(posedge rclk0)
           begin
              if(wr_addr_en == 4'h0) r00_q <= wr_data[31:0];
              if(wr_addr_en == 4'h1) r01_q <= wr_data[31:0];
              if(wr_addr_en == 4'h2) r02_q <= wr_data[31:0];
              if(wr_addr_en == 4'h3) r03_q <= wr_data[31:0];
              if(wr_addr_en == 4'h4) r04_q <= wr_data[31:0];
           end
      end

   endgenerate

   // -------------------------------------------------------------------------
   // Upper register file implementation
   // -------------------------------------------------------------------------

   // Generate either non-reset or reset D-type registers based upon the value
   // of the Reset-All-Registers parameter. Implementing "set" rather than
   // "reset" flops typically results in smaller area and lower power for most
   // generic cell libraries.

   generate
      if((CBAW != 0) || (RAR != 0)) begin : gen_rar_1a

         // Use HRESETn as a reset signal if requested.

         wire rar_reset_n = ~cfg_rar | hreset_n;

         // R5-to-R12 and LR are less frequently used, and are clocked from
         // their own clock-gating cell (if implemented). In addition, the
         // write-data used is also gated to reduce power consumed by toggling
         // of the register data-inputs.

         always @(posedge rclk1 or negedge rar_reset_n)
           if(~rar_reset_n) begin
              r05_q <= {32{1'b1}};
              r06_q <= {32{1'b1}};
              r07_q <= {32{1'b1}};
              r08_q <= {32{1'b1}};
              r09_q <= {32{1'b1}};
              r10_q <= {32{1'b1}};
              r11_q <= {32{1'b1}};
              r12_q <= {32{1'b1}};
              r14_q <= {32{1'b1}};
           end else begin
              if(wr_addr_en == 4'h5) r05_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'h6) r06_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'h7) r07_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'h8) r08_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'h9) r09_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'hA) r10_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'hB) r11_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'hC) r12_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'hE) r14_q <= wr_data_opt[31:0];
           end

      end else begin : gen_rar_1b

         // Standard non-reset construction of R0-to-R12 and R14 using optional
         // gated clock and data.

         always @(posedge rclk1)
           begin
              if(wr_addr_en == 4'h5) r05_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'h6) r06_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'h7) r07_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'h8) r08_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'h9) r09_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'hA) r10_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'hB) r11_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'hC) r12_q <= wr_data_opt[31:0];
              if(wr_addr_en == 4'hE) r14_q <= wr_data_opt[31:0];
           end

      end
   endgenerate

   // -------------------------------------------------------------------------
   // AHB clocked control registers
   // -------------------------------------------------------------------------

   // Generate either non-reset or reset D-type registers based upon the value
   // of the Reset-All-Registers parameter. Implementing "set" rather than
   // "reset" flops typically results in smaller area and lower power for most
   // generic cell libraries.

   generate
      if((CBAW != 0) || (RAR != 0)) begin : gen_rar_2a

         // Use HRESETn as a reset signal if requested.

         wire rar_reset_n = ~cfg_rar | hreset_n;

         // The following registers are enabled on HREADY when the appropriate
         // sub-enable is also active.

         always @(posedge hclk or negedge rar_reset_n)
           if(~rar_reset_n) begin
              apsr_q    <= {4{1'b1}};
              aux_q     <= {32{1'b1}};
              base_q    <= {3{1'b1}};
              extend_q  <= 1'b1;
              list_q    <= {8{1'b1}};
              msp_q     <= {30{1'b1}};
              psp_q     <= {30{1'b1}};
              ra_addr_q <= {4{1'b1}};
              rb_addr_q <= {4{1'b1}};
              tbit_q    <= 1'b1;
           end else if(hready_i) begin
              if(apsr_en)    apsr_q    <= apsr_nxt[3:0];
              if(aux_en)     aux_q     <= aux_nxt[31:0];
              if(base_en)    base_q    <= base_nxt[2:0];
              if(extend_en)  extend_q  <= extend_nxt;
              if(list_en)    list_q    <= list_nxt[7:0];
              if(msp_en)     msp_q     <= wr_data_sp[29:0];
              if(psp_en)     psp_q     <= wr_data_sp[29:0];
              if(ra_addr_en) ra_addr_q <= ra_addr_nxt[3:0];
              if(rb_addr_en) rb_addr_q <= rb_addr_nxt[3:0];
              if(tbit_en)    tbit_q    <= tbit_nxt;
           end

      end else begin : gen_rar_2b

         // Standard non-reset construction of HREADY enabled registers.

         always @(posedge hclk)
           if(hready_i) begin
              if(apsr_en)    apsr_q    <= apsr_nxt[3:0];
              if(aux_en)     aux_q     <= aux_nxt[31:0];
              if(base_en)    base_q    <= base_nxt[2:0];
              if(extend_en)  extend_q  <= extend_nxt;
              if(list_en)    list_q    <= list_nxt[7:0];
              if(msp_en)     msp_q     <= wr_data_sp[29:0];
              if(psp_en)     psp_q     <= wr_data_sp[29:0];
              if(ra_addr_en) ra_addr_q <= ra_addr_nxt[3:0];
              if(rb_addr_en) rb_addr_q <= rb_addr_nxt[3:0];
              if(tbit_en)    tbit_q    <= tbit_nxt;
           end

      end
   endgenerate

   // --------
   // Specialized registers clock by SCLK, used for interrupt handling.

   always @(posedge sclk or negedge hreset_n)
     if(~hreset_n) begin
        iq_q   <= {16{1'b1}};
        iq_s_q <= 1'b0;
     end else if(iq_en & hready_i | iq_free_en) begin
        iq_q   <= iq_nxt[15:0];
        iq_s_q <= iq_s_nxt;
     end

   always @(posedge sclk or negedge hreset_n)
     if(~hreset_n)          sleep_lock_q <= 1'b0;
     else if(sleep_lock_en) sleep_lock_q <= sleep_lock_nxt;

   // --------
   // For correct operation, the following registers must be set on HRESET.

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n) begin
        atomic_q    <= 1'b1;
        iaex_q      <= {31{1'b1}};
        offset_q    <= {4{1'b1}};
        op_q        <= {16{1'b1}};
        state_q     <= st_rst;
     end else if(hready_i) begin
        if(atomic_en) atomic_q <= atomic_nxt;
        if(iaex_en)   iaex_q   <= iaex_nxt[30:0];
        if(offset_en) offset_q <= offset_nxt[3:0];
        if(op_en)     op_q     <= op_nxt[15:0];
        if(state_en)  state_q  <= state_nxt[3:0];
     end

   // --------
   // For correct operation, the following registers must be reset on HRESET.

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n) begin
        int_ready_q <= 1'b0;
        op_s_q      <= 1'b0;
        primask_q   <= 1'b0;
        spsel_q     <= 1'b0;
     end else if(hready_i) begin
        if(int_ready_en) int_ready_q <= int_ready_nxt;
        if(op_en)        op_s_q      <= op_s_nxt;
        if(primask_en)   primask_q   <= primask_nxt;
        if(spsel_en)     spsel_q     <= spsel_nxt;
     end

   // --------
   // The architecture requires any fault during the reset sequence to result
   // in a Lockup at HardFault priority. To assist in crafting this scenario,
   // the IPSR value is reset to that of HardFault, and cleared to zero by the
   // reset state machine if a clear reset is achieved.

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n)
       ipsr_q <= 6'd3;
     else if(hready_i & ipsr_en | ipsr_free_en)
       ipsr_q <= ipsr_nxt[5:0];

   // --------
   // Single register used to record that a fault has been detected in the
   // previous cycle. This is used to reduce fan-out/timing on HRESP and also
   // to arrange for all bus, MPU or alignment faults to appear to arrive in
   // a load/store data-phase such that they can be handled by common logic.

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n)
       fault_q <= 1'b0;
     else if(fault_en)
       fault_q <= fault_nxt;

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n)
       hdf_lock_q <= 1'b0;
     else if(hready_i & hdf_lock_en)
       hdf_lock_q <= hdf_lock_nxt;

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n)
       nmi_lock_q <= 1'b0;
     else if(hready_i & nmi_lock_en)
       nmi_lock_q <= nmi_lock_nxt;

   // -------------------------------------------------------------------------
   // Track instruction queue content
   // -------------------------------------------------------------------------

   // Track whether, when loaded from memory, the instruction queue buffer
   // contains a branch type instruction or not. If configured in 16-bit fetch
   // mode, then the instruction queue is not used for instructions, and thus
   // can never contain a branch.

   generate
      if((CBAW != 0) || (HWF == 0)) begin : gen_hwf_2a

         always @(posedge hclk or negedge hreset_n)
           if(~hreset_n)
             iq_branch_q <= 1'b0;
           else if(hready_i & iq_en & ~cfg_hwf)
             iq_branch_q <= iq_branch_nxt;

      end else begin : gen_hwf_2b

         wire unused = iq_branch_nxt;
         wire zero = 1'b0;
         always @* iq_branch_q = zero;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // IO port buffer
   // -------------------------------------------------------------------------

   localparam IOP_AND_RAR = (IOP != 0) && (RAR != 0); // EDA tool workaround

   generate
      if((CBAW != 0) || IOP_AND_RAR) begin : gen_iop_8a

         wire rar_reset_n = ~cfg_rar | hreset_n;

         always @(posedge hclk or negedge rar_reset_n)
           if(~rar_reset_n)
             io_buf_q <= {32{1'b1}};
           else if(io_buf_en)
             io_buf_q <= io_buf_nxt[31:0];

         always @(posedge hclk or negedge rar_reset_n)
           if(~rar_reset_n)
             io_rp_addr_q <= {3{1'b1}};
           else if(hready_i & io_rp_addr_en)
             io_rp_addr_q <= io_rp_addr_nxt[2:0];

      end else if(IOP != 0) begin : gen_iop_8b

         always @(posedge hclk)
           if(io_buf_en)
             io_buf_q <= io_buf_nxt[31:0];

         always @(posedge hclk)
           if(hready_i & io_rp_addr_en)
             io_rp_addr_q <= io_rp_addr_nxt[2:0];

      end else begin : gen_iop_8c

         wire [36:0] unused = { io_buf_en, io_buf_nxt[31:0], io_rp_addr_en,
                                io_rp_addr_nxt[2:0]};

         wire zero = 1'b0;
         always @* { io_buf_q, io_rp_addr_q[2:0] } = {35{zero}};

      end
   endgenerate

   // --------

   generate
      if((CBAW != 0) || (IOP != 0)) begin : gen_iop_9a

         always @(posedge hclk or negedge hreset_n)
           if(~hreset_n)
             io_buf_a_q <= 1'b0;
           else if(io_buf_a_en)
             io_buf_a_q <= io_buf_a_nxt;

         always @(posedge hclk or negedge hreset_n)
           if(~hreset_n)
             io_buf_d_q <= 1'b0;
           else if(io_buf_d_en)
             io_buf_d_q <= io_buf_d_nxt;

         always @(posedge hclk or negedge hreset_n)
           if(~hreset_n)
             io_rsel_q <= 1'b1;
           else if(hready_i)
             io_rsel_q <= io_rsel_nxt;

      end else begin : gen_iop_9b

         wire [4:0] unused = { io_buf_a_en, io_buf_a_nxt, io_buf_d_en,
                               io_buf_d_nxt, io_rsel_nxt };

         wire zero = 1'b0;
         always @* { io_buf_a_q, io_buf_d_q, io_rsel_q } = {3{zero}};

      end
   endgenerate

   // -------------------------------------------------------------------------
   // HardFault stacked tracking for MPU
   // -------------------------------------------------------------------------

   // The MPU supports using the default attributes whenever in Hardfault or
   // NMI. On an exception return, the processor does not normally know where
   // it is returning to until it has loaded the xPSR from the stack. If the
   // return is from NMI to Hardfault, then the xPSR load itself should be
   // performed as though it were NMI or Hardfault; in order to make this work,
   // the processor records whenever a Hardfault is preempted by an NMI, and
   // speculates that the return will be to the Hardfault handler until such
   // time as this assumption is proven incorrect.

   generate
      if((CBAW != 0) || (MPU != 0)) begin : gen_mpu_2a

         always @(posedge hclk or negedge hreset_n)
           if(~hreset_n)
             hdf_pushed_q <= 1'b0;
           else if(cfg_mpu & hready_i & hdf_pushed_en)
             hdf_pushed_q <= hdf_pushed_nxt;

      end else begin : gen_mpu_2b

         wire [1:0] unused = { hdf_pushed_en, hdf_pushed_nxt };

         wire zero = 1'b0;
         always @* hdf_pushed_q = zero;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Assign outputs
   // -------------------------------------------------------------------------

   // Inter-module outputs.

   assign        cpu_dni_o           = ~ahb_instr;
   assign        cpu_dni_a_o         = ls_trans;
   assign        cpu_event_clear_o   = event_clear;
   assign        cpu_ex_idle_o       = ex_idle;
   assign        cpu_haddr_o         = ahb_addr[31:0];
   assign        cpu_hdf_active_o    = hdf_active;
   assign        cpu_hdf_request_o   = hdf_req;
   assign        cpu_hdf_pend_o      = hdf_pend;
   assign        cpu_hsize_o         = ahb_size;
   assign        cpu_hwdata_o        = ahb_wdata[31:0];
   assign        cpu_hwrite_o        = ahb_write;
   assign        cpu_int_ready_o     = int_ready_q;
   assign        cpu_int_return_o    = rfe_ack & hready_i;
   assign        cpu_int_taken_o     = irq_ack & hready_i;
   assign        cpu_ipsr_o          = ipsr_q[5:0];
   assign        cpu_hfnmi_o         = hfnmi;
   assign        cpu_n_or_h_active_o = n_or_h_active;
   assign        cpu_nmi_active_o    = nmi_active;
   assign        cpu_primask_ex_o    = primask_ex;
   assign        cpu_primask_o       = primask_q;
   assign        cpu_priv_o          = ahb_priv;
   assign        cpu_scb_o           = ahb_scb;
   assign        cpu_spec_htrans_o   = spec_trans;
   assign        cpu_svc_request_o   = svc_req;
   assign        cpu_trans_o         = ahb_trans;
   assign        cpu_wfe_execute_o   = wfe_execute;
   assign        cpu_wfi_execute_o   = wfi_execute;
   assign        cpu_write_a_o       = ls_write;

   // --------
   // Primary outputs.

   assign        atomic_o            = atomic_q;
   assign        code_hint_o         = code_hint[3:0];
   assign        code_nseq_o         = code_nseq;
   assign        data_hint_o         = { pc_rel, vtable };
   assign        iaex_o              = iaex_q[30:0];
   assign        iaex_en_o           = iaex_en & hready_i;
   assign        iaex_seq_o          = iaex_seq;
   assign        lockup_o            = run_lck;
   assign        sleep_hold_ack_n_o  = ~sleep_lock_q;
   assign        txev_o              = event_set;

   // -------------------------------------------------------------------------
   // Assign clock gating outputs
   // -------------------------------------------------------------------------

   // If not present, hard-wire clock enable output terms to ONE.

   generate
      if(CBAW != 0) begin : gen_acg_0a

         assign cpu_rclk0_en_o = ~cfg_acg | rclk0_en;
         assign cpu_rclk1_en_o = ~cfg_acg | rclk1_en;

      end else if(ACG != 0) begin : gen_acg_0b

         wire unused = cfg_acg;
         assign cpu_rclk0_en_o = rclk0_en;
         assign cpu_rclk1_en_o = rclk1_en;

      end else begin : gen_acg_0c

         wire [2:0] unused = { cfg_acg, rclk0_en, rclk1_en };
         assign cpu_rclk0_en_o = 1'b1;
         assign cpu_rclk1_en_o = 1'b1;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Assign debug specific outputs
   // -------------------------------------------------------------------------

   // If not present, the debug outputs are tied off and logic optimized away.

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_7a

         wire cpu_dbg_stall = ( dbg_no_trans |
                                ls_multi |
                                atomic_q & ~(run_hlt | run_rst | run_wfx) );

         wire cpu_dwt_trans = ( ls_trans & ~align_fault & ~mpu_fault_a_i);

         wire [1:0] ls_size = { ~(base_sel_half | base_sel_byte),
                                base_sel_half };

         assign cpu_bpu_event_o     = bpu_event;
         assign cpu_dbg_ex_last_o   = op_en;
         assign cpu_dbg_ex_reset_o  = run_rst & rst_cyc_1;
         assign cpu_dbg_stall_o     = cpu_dbg_stall;
         assign cpu_dwt_trans_o     = cpu_dwt_trans;
         assign cpu_dcrdr_data_o    = aux_q[31:0];
         assign cpu_dwt_ia_ok_o     = ~atomic_q & ~run_alt;
         assign cpu_dwt_iaex_o      = iaex_q[30:0];
         assign cpu_halt_ack_o      = hlt_ack;
         assign cpu_ls_size_o       = ls_size[1:0];
         assign cpu_pipefull_o      = run_exe;
         assign cpu_wphase_o        = str_valid;

      end else begin : gen_dbg_7b

         wire [2:0] unused = { bpu_event, hlt_ack, dbg_no_trans };

         assign { cpu_bpu_event_o, cpu_dbg_ex_last_o, cpu_dbg_ex_reset_o,
                  cpu_dbg_stall_o, cpu_dwt_trans_o, cpu_dcrdr_data_o[31:0],
                  cpu_dwt_ia_ok_o, cpu_dwt_iaex_o[30:0], cpu_halt_ack_o,
                  cpu_ls_size_o[1:0], cpu_pipefull_o, cpu_wphase_o } = 74'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Assign IO port specific outputs
   // -------------------------------------------------------------------------

   // If not present, IO port outputs are tied off and logic optimized away.

   generate
      if((CBAW != 0) || (IOP != 0)) begin : gen_iop_10a

         wire [1:0]  io_size  = { base_sel_word | io_buf_a_q, base_sel_half };
         wire        io_exe   = ls_trans & ~ls_multi;
         wire        io_quash = kill_iop | align_fault | io_buf_d_q;

         wire        io_trans = ( io_match & io_exe & ~io_quash |
                                  io_buf_a_q );

         wire [31:0] io_addr  = ( {32{io_buf_a_q}} & io_buf_q[31:0] |
                                  {32{~io_buf_a_q}} & addr_aligned[31:0] );

         wire        io_write = ( ~io_buf_a_q & ls_write |
                                  io_buf_a_q & io_buf_d_q );

         assign cpu_io_addr_o   = {32{cfg_iop}} & io_addr[31:0];
         assign cpu_io_wdata_o  = {32{cfg_iop}} & io_wdata[31:0];
         assign cpu_io_check_o  = {32{cfg_iop}} & addr_aligned[31:0];
         assign cpu_io_trans_o  = cfg_iop & io_trans;
         assign cpu_io_write_o  = cfg_iop & io_write;
         assign cpu_io_priv_o   = cfg_iop & priv;
         assign cpu_io_size_o   = {2{cfg_iop}} & io_size[1:0];

      end else begin : gen_iop_10b

         wire [31:0] unused = io_wdata;

         assign { cpu_io_addr_o, cpu_io_wdata_o, cpu_io_check_o,
                  cpu_io_trans_o, cpu_io_size_o, cpu_io_write_o,
                  cpu_io_priv_o } = 101'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Assign MPU specific outputs
   // -------------------------------------------------------------------------

   // The number of active MPU requests is determined based on both whether the
   // IO port is present. If the IO port is present, then the processor can
   // simultaneously issue both an instruction fetch to AHB and a data load or
   // store to the IO port. Both of these transactions need checking by the
   // MPU in parallel.

   generate
      if(CBAW != 0) begin : gen_iop_11a

         assign cpu_addr_a_o       = ( {32{cfg_iop}} & addr_aligned[31:0] |
                                       {32{~cfg_iop}} & ahb_addr[31:0] );

         assign cpu_addr_b_31to5_o = {27{cfg_iop}} & addr_b[31:5];

      end else if(IOP != 0) begin : gen_iop_11b

         assign cpu_addr_a_o       = addr_aligned[31:0];
         assign cpu_addr_b_31to5_o = addr_b[31:5];

      end else begin : gen_iop_11c

         wire unused = mpu_fault_b_i;

         assign cpu_addr_a_o       = ahb_addr[31:0];
         assign cpu_addr_b_31to5_o = 27'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Assign WIC specific outputs
   // -------------------------------------------------------------------------

   // If no WIC is present, then disable the WIC outputs and optimize away the
   // driving logic.

   generate
      if((CBAW != 0) || (WIC != 0)) begin : gen_wic_0a

         assign wic_clear_o = cfg_wic ? wic_clear : 1'b0;
         assign wic_load_o  = cfg_wic ? wic_load  : 1'b0;

      end else begin : gen_wic_0b

         wire [1:0] unused = { wic_clear, wic_load };
         assign { wic_clear_o, wic_load_o } = 2'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // END OF SYNTHESIZABLE LOGIC
   // -------------------------------------------------------------------------

   // The following code contains assertions and monitors only.

   // -------------------------------------------------------------------------


`ifdef ARM_ASSERT_ON
   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------

`include "std_ovl_defines.h"

   // --------
   // Check that configuration wires are never X in simulation.

   ovl_never_unknown
     #(.severity_level (`OVL_FATAL),
       .width          (11),
       .property_type  (`OVL_ASSERT),
       .msg            ("Configuration wires must never be unknown"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_config_x
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .qualifier       (1'b1),
      .test_expr       ({cfg_acg, cfg_be, cfg_dbg, cfg_hwf, cfg_iop, cfg_mpu,
                         cfg_rar, cfg_smul, cfg_user, cfg_vtor, cfg_wic}),
      .fire            ());

   // --------
   // Check that none of the register enables ever goes X in simulation.

   ovl_never_unknown
     #(.severity_level (`OVL_FATAL),
       .width          (36),
       .property_type  (`OVL_ASSERT),
       .msg            ("Register enables must never be unknown"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_reg_en_x
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .qualifier       (1'b1),
      .test_expr       ({ fault_en,
                          hready_i,
                          hready_i & apsr_en,
                          hready_i & atomic_en,
                          hready_i & aux_en,
                          hready_i & base_en,
                          hready_i & extend_en,
                          hready_i & hdf_lock_en,
                          hready_i & iaex_en,
                          hready_i & int_ready_en,
                          hready_i & ipsr_en,
                          hready_i & iq_en,
                          hready_i & io_rp_addr_en,
                          hready_i & list_en,
                          hready_i & npriv_en,
                          hready_i & msp_en,
                          hready_i & nmi_lock_en,
                          hready_i & primask_en,
                          hready_i & offset_en,
                          hready_i & op_en,
                          hready_i & psp_en,
                          hready_i & ra_addr_en,
                          hready_i & rb_addr_en,
                          hready_i & spsel_en,
                          hready_i & state_en,
                          hready_i & tbit_en,
                          ipsr_free_en,
                          iq_free_en,
                          sleep_lock_en,
                          io_buf_en,
                          io_buf_a_en,
                          io_buf_d_en,
                          wr_addr_en[3:0] }),
      .fire            ());

   // --------
   // Exception handling relies on the ra_addr_q pointer already being 13.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("RA addr must be SP for exception entry/exit"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_ra_exc_is_sp
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_irq |
                        (run_stm & atomic_q) |
                        (run_ldm & atomic_q) |
                        run_rfe),
      .consequent_expr (ra_addr_q == 4'd13),
      .fire            ());

   // --------
   // Check subset of instructions that require predecoder to have run.

   ovl_implication
     #(.severity_level  (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Op requires {RA,RB} addr must be op{[2:0],[5:3]}"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_ra_rb_are_op_20_53
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_exe & ((op_q[15:6] == 10'b0100000101) |  // ADC
                                   (op_q[15:6] == 10'b0100000000) |  // AND
                                   (op_q[15:6] == 10'b0100000100) |  // ASR2
                                   (op_q[15:6] == 10'b0100001110) |  // BIC
                                   (op_q[15:6] == 10'b0100001011) |  // CMN
                                   (op_q[15:6] == 10'b0100001010) |  // CMP2
                                   (op_q[15:6] == 10'b0100000001) |  // EOR
                                   (op_q[15:6] == 10'b0100000010) |  // LSL2
                                   (op_q[15:6] == 10'b0100000011) |  // LSR2
                                   (op_q[15:6] == 10'b0100001101) |  // MUL
                                   (op_q[15:6] == 10'b0100001100) |  // ORR
                                   (op_q[15:6] == 10'b0100000111) |  // ROR
                                   (op_q[15:6] == 10'b0100000110) |  // SBC
                                   (op_q[15:6] == 10'b0100001000))), // TST
      .consequent_expr ((ra_addr_q == {1'b0, op_q[2:0]}) &
                        (rb_addr_q == {1'b0, op_q[5:3]}) ),
      .fire            ());

   // --------
   // Check another subset of instructions relying on predecoding.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Op requires RA addr must be opcode[5:3]"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_ra_is_op_53
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_exe & ((op_q[15:9] == 7'b0001110) |      // ADD1
                                   (op_q[15:11] == 5'b00010) |       // ASR1
                                   (op_q[15:11] == 5'b01101) |       // LDR1
                                   (op_q[15:11] == 5'b01111) |       // LDRB1
                                   (op_q[15:11] == 5'b10001) |       // LDRH1
                                   (op_q[15:11] == 5'b00000) |       // LSL1
                                   (op_q[15:11] == 5'b00001) |       // LSR1
                                   (op_q[15:6] == 10'b1011101000) |  // REV
                                   (op_q[15:6] == 10'b1011101001) |  // REV16
                                   (op_q[15:6] == 10'b1011101011) |  // REVSH
                                   (op_q[15:11] == 5'b01100) |       // STR1
                                   (op_q[15:11] == 5'b01110) |       // STRB1
                                   (op_q[15:11] == 5'b10000) |       // STRH1
                                   (op_q[15:9] == 7'b0001111) |      // SUB1
                                   (op_q[15:6] == 10'b1011001001) |  // SXTB
                                   (op_q[15:6] == 10'b1011001000) |  // SXTH
                                   (op_q[15:6] == 10'b1011001011) |  // UXTB
                                   (op_q[15:6] == 10'b1011001010))), // UXTH
      .consequent_expr (ra_addr_q == {1'b0, op_q[5:3]}),
      .fire            ());

   // --------
   // Check that main state variable always holds one of the legal states.

   ovl_always
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("State must always be valid"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_state_valid
     (.clock     (sclk),
      .reset     (hreset_n),
      .enable    (1'b1),
      .test_expr ( (state_q == st_rst) |
                   (state_q == st_exe) |
                   (state_q == st_pfu) |
                   (state_q == st_t32) |
                   (state_q == st_ldr) |
                   (state_q == st_str) |
                   (state_q == st_ldm) |
                   (state_q == st_stm) |
                   (state_q == st_rfe) |
                   (state_q == st_irq) |
                   (state_q == st_lck) |
                   (state_q == st_wfx) |
                   cfg_smul & (state_q == st_mul) |
                   cfg_dbg & (state_q == st_hlt) ),
      .fire      ());

   // --------
   // Check that the current state and atomic settings match.

   ovl_always
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("State must be consistent with atomic"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_state_atomic_consistent
     (.clock     (sclk),
      .reset     (hreset_n),
      .enable    (1'b1),
      .test_expr ( (atomic_q & ( (state_q == st_rst) |
                                 (state_q == st_ldm) |
                                 (state_q == st_stm) |
                                 (state_q == st_rfe) |
                                 (state_q == st_irq) |
                                 (state_q == st_hlt) |
                                 (state_q == st_wfx) ) ) |
                   (~atomic_q & ((state_q == st_exe) |
                                 (state_q == st_ldm) |
                                 (state_q == st_stm) |
                                 (state_q == st_pfu) |
                                 (state_q == st_t32) |
                                 (state_q == st_ldr) |
                                 (state_q == st_str) |
                                 (state_q == st_wfx) |
                                 (state_q == st_lck) |
                                 (state_q == st_mul) ) ) ),
      .fire      ());

   // --------
   // Check that special causes run_exe to be replaced with run_alt.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Must not run a 16-bit special as EXE"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_no_special_in_exe
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_exe),
      .consequent_expr (~op_s_q),
      .fire            ());

   // --------
   // Check that special causes run_t32 to be replaced with run_alt.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Must not run a 32-bit special as T32"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_no_special_in_t32
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_t32),
      .consequent_expr (~op_s_q & ~iq_s_q),
      .fire            ());

   // --------
   // Check that int_ready_q causes run_t32 to be replaced with run_alt.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Must not run a valid T32 whilst IRQ ready"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_no_int_ready_t32
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_t32 & u32_defined),
      .consequent_expr (~int_ready_q),
      .fire            ());

   // --------
   // IQ which can change when HREADY is low, so ensure T32 can't see this.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("T32 second execute cycle must never be waited"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_t32_never_waited
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_t32),
      .consequent_expr (hready_i),
      .fire            ());

   // --------
   // When configured with the single-cycle multiplier, MUL state is redundant.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Fast MUL can never be in small MUL state"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_fmul_not_smul
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (~cfg_smul),
      .consequent_expr (state_q != st_mul),
      .fire            ());

   // --------
   // A subset of the fmt_dp9 set is UNDEFINED, ensure this is detected.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("DP9 undef must also trigger U16"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_dp9_undef_is_u16
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (fmt_dp9 & dp9_isn_undef),
      .consequent_expr (fmt_u16),
      .fire            ());

   // --------
   // A subset of fmt_sy3 set is UNDEFINED, ensure this is detected.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("SY3 undef must also trigger U16"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_sy3_undef_is_u16
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (fmt_sy3 & ~sy3_isn_cps),
      .consequent_expr (fmt_u16),
      .fire            ());

   // --------
   // There are only four defined cycles in the IRQ state.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("IRQ state must be in an IRQ cycle"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_run_irq_cyc
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_irq),
      .consequent_expr (irq_cyc_1 | irq_cyc_2 | irq_cyc_3 | irq_cyc_4),
      .fire            ());

   // --------
   // There are only five defined cycles in the RFE state.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("RFE state must be in an RFE cycle"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_run_rfe_cyc
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_rfe),
      .consequent_expr (rfe_cyc_1 | rfe_cyc_2 | rfe_cyc_3 | rfe_cyc_4 |
                        rfe_cyc_5),
      .fire            ());

   // --------
   // There are only four defined cycles in the RST state.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("RST state must be in an RST cycle"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_run_rst_cyc
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_rst),
      .consequent_expr (rst_cyc_1 | rst_cyc_2 | rst_cyc_3 | rst_cyc_4),
      .fire            ());

   // --------
   // There are only four defined cycles in the WFX state.

   wire        a_wfx_cyc_3 = offset_q[1:0] == 2'b10;

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("WFX state must be in an WFX cycle"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_run_wfx_cyc
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_wfx),
      .consequent_expr (wfx_cyc_1 | wfx_cyc_2 | a_wfx_cyc_3 | wfx_cyc_4),
      .fire            ());

   // --------
   // If PRIMASK is set, then only NMI or HardFault can interrupt.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Prioritizable IRQ can not preempt PRIMASK"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_no_irq_primask
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (int_ready_q & (int_num > 3'h3)),
      .consequent_expr (~primask_q),
      .fire            ());

   // --------
   // In EXE, if int_ready_q is set and HREADY is high, we must goto IRQ state.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Ready interrupt must be taken"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_irq_must_be_taken
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (int_ready_q & hready_i & (run_exe | run_t32)),
      .test_expr   (run_irq & irq_cyc_1),
      .fire        ());

   // --------
   // Non-atomic, non-sleep-hold-ack cycles must take an interrupt if one is
   // pending.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Ready interrupt while not atomic must be taken"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_non_atomic_irq_must_be_taken
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (int_ready_q & hready_i & ~atomic_q & ~sleep_lock_q),
      .test_expr   (run_irq & irq_cyc_1),
      .fire        ());

   // --------
   // The core should branch or maintain any definite branch hint.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("CODEHINT[2]/CODENSEQ should follow CODEHINT[2]"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_code_hint_2
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (code_hint_o[2]),
      .test_expr   (code_hint_o[2] & ~(cpu_trans_o & ~cpu_dni_o) | code_nseq_o),
      .fire        ());

   // --------
   // Non sequential fetch can only follow a branch hint.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("CODENSEQ must be preceded by a CODEHINT"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_code_nseq
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (~(|{code_hint_o[2:0], code_nseq_o})),
      .test_expr   (~code_nseq_o),
      .fire        ());

   // --------
   // CODEHINT[3] indicates that the next AHB address cycle could be for data.
   // The signal is optimistic such that a data address cycle will never occur
   // without a preceding CODEHINT[3].

   ovl_next
     #(.severity_level(`OVL_FATAL),
       .num_cks(1),
       .check_overlapping(1),
       .check_missing_start(0),
       .property_type(`OVL_ASSERT),
       .msg("CODEHINT[3] must precede non-fetch (data) load/store cycles"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_code_hint_bit3_must_preceed_data
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .start_event     (~code_hint_o[3] & hready_i),
      .test_expr       (~cpu_trans_o | ~cpu_dni_o),
      .fire            ());

   // --------
   // Suppress noisy OVL_INFO unless explicitly added.

`ifdef ARM_CM0P_EXTRA_ASSERT_ON

   // --------
   // As CODEHINT[3] is optimistic, it can sometimes flag the cycle before an
   // instruction fetch. This is undesirable, so flag any occurrences.

   ovl_next
     #(.severity_level(`OVL_INFO),
       .num_cks(1),
       .check_overlapping(1),
       .check_missing_start(0),
       .property_type(`OVL_ASSERT),
       .msg("CODEHINT[3] pessimistically mismatched with fetch cycle"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_info_code_hint_bit3_may_mismatch_fetches
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .start_event     (code_hint_o[3] & hready_i),
      .test_expr       (~cpu_trans_o | cpu_dni_o),
      .fire            ());

`endif

   // --------
   // The state machine has no transition to RST other than reset.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Transition to reset state not permitted"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_no_soft_reset
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (~run_rst),
      .test_expr   (~run_rst),
      .fire        ());

   // --------
   // Only one next-state can ever be selected.

   ovl_one_hot
     #(.severity_level (`OVL_FATAL),
       .width          (14),
       .property_type  (`OVL_ASSERT),
       .msg            ("Only one next-state is permitted to be selected"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_next_state_unique
     (.clock     (hclk),
      .reset     (hreset_n),
      .enable    (1'b1),
      .test_expr ({~(state_en & hready_i),
                   {13{state_en & hready_i}} &
                   {state_sel_exe,
                    state_nxt_mul != 4'b0,
                    state_sel_wfx,
                    state_sel_pfu,
                    state_sel_ldr,
                    state_sel_str,
                    state_sel_ldm,
                    state_sel_stm,
                    state_sel_irq,
                    state_sel_hlt,
                    state_sel_rfe,
                    state_sel_lck,
                    state_sel_t32}}),
      .fire());

   // --------
   // First cycle of interrupt processing is atomic and read-pointer is 13.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("First IRQ must be consistent with state"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_irq1_consistent
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_irq & irq_cyc_1),
      .consequent_expr ((ra_addr_q == 4'd13) & atomic_q),
      .fire            ());

   // --------
   // IO buffer is used as an address only by multiples, thus addr is aligned.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("IO buffer addresses are always word aligned"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_io_addr_word
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (io_buf_a_q),
      .consequent_expr (io_buf_q[1:0] == 2'b00),
      .fire            ());

   // --------
   // No fetch/SLV accesses during multiples, thus HREADY high for IO by these.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("IO buffer holds address only when HREADY is high"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_iop_tx_always_ready
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (io_buf_a_q),
      .consequent_expr (hready_i),
      .fire            ());

   // --------
   // If we are in IRQ cycle 2, then an interrupt must be pending.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("An interrupt must be pending in IRQ cycle 2"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_irq2_pending
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_irq & irq_cyc_2),
      .consequent_expr (int_ready_q),
      .fire            ());

   // --------
   // SVC and faults always Lockup in Hardfault and NMI.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("SVCall and HardFault never pend in HardFault or NMI"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_no_pend_req_in_n_or_h
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (cpu_svc_request_o | cpu_hdf_request_o),
      .consequent_expr (atomic_q | ~n_or_h_active),
      .fire            ());

   // --------
   // IRQ prevents fetches and load/store address in cycle before IRQ state.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("No fault possible in IRQ cycle 1"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_irq1_no_fault
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_irq & irq_cyc_1),
      .consequent_expr (~fault_q),
      .fire            ());

   // --------
   // There will be no address phase in cycle before exception return.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("No fault possible in RFE cycle 1"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_rfe1_no_fault
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_rfe & rfe_cyc_1),
      .consequent_expr (~fault_q),
      .fire            ());

   // --------
   // LR must contain a legal exception return value on exception entry.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("R14 must be an EXC_RETURN on exception entry"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_lr_excreturn
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (irq_ack),
      .consequent_expr ((r14_q[31:28] == 4'hF) &
                        ((r14_q[3:0] == 4'h1) |
                         (r14_q[3:0] == 4'h9) |
                         (r14_q[3:0] == 4'hD) )),
      .fire            ());

   // --------
   // The active stack-pointer must always be MSP inside a Handler.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Code in Handler must always use MSP"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_handler_use_msp
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (handler & (run_exe | ~atomic_q)),
      .consequent_expr (spsel_q == 1'b0),
      .fire            ());

   // --------
   // If core is in Lockup, then PC must be 0xFFFFFFFF.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("PC must be 0xFFFFFFFF in Lockup"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_lockup_pc
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (run_lck),
      .consequent_expr (iaex_q == 31'h7FFFFFFF),
      .fire            ());

   // --------
   // IO port address is always aligned to transaction size.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("IO port address and size must be consistent"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_iop_addr
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (cpu_io_trans_o),
      .consequent_expr ((cpu_io_size_o == 2'b00) |
                        (cpu_io_size_o == 2'b01) & (cpu_io_addr_o[0] == 1'b0) |
                        ( (cpu_io_size_o == 2'b10) &
                          (cpu_io_addr_o[1:0] == 2'b00) ) ),
      .fire            ());

   // --------
   // IO port write-data is replicated to the size of transaction.
   // Note that as implemented, the consequent is always true.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("IO port write data must be size replicated"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_iop_wdata
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (cpu_io_trans_o & cpu_io_write_o),
      .consequent_expr (( (cpu_io_size_o == 2'b00) &
                          (cpu_io_wdata_o == {4{cpu_io_wdata_o[7:0]}}) ) |
                        ( (cpu_io_size_o == 2'b01) &
                          (cpu_io_wdata_o == {2{cpu_io_wdata_o[15:0]}}) ) |
                        (cpu_io_size_o == 2'b10) ),
      .fire            ());

   // --------
   // Vector zero is used at reset only and never used for an interrupt.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("IRQ entry can never fetch vector 0"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_irq_never_zero
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (ls_trans & run_irq & vtable),
      .consequent_expr (addr_a[7:2] != 6'b0),
      .fire            ());

   // --------
   // LDR/STR can only generate one IO trans per instruction.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Only one cycle of IOTRANS per LDR/STR"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_io_single_cyc
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (cpu_io_trans_o & ~(iaex_en & hready_i)),
      .test_expr   (~cpu_io_trans_o | ls_multi),
      .fire        ());

   // --------
   // A taken breakpoint must be taken if HREADY is high.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Breakpoint signaled as taken must halt"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_taken_bkpt_must_halt
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (cpu_bpu_event_o & hready_i),
      .test_expr   (cpu_halt_ack_o),
      .fire        ());

   // --------
   // If a fault occurs on an NMI or Hardfault vector, PC gets set to Lockup.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Faulting HardFault or NMI entry must Lockup"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_n_or_h_entry_lockup
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (run_irq & irq_cyc_4 & fault_q & n_or_h_active &
                    ~int_ready_q),
      .test_expr   (iaex_q == {31{1'b1}}),
      .fire        ());

   // --------
   // IQ interrupt state never becomes an opcode unless int_ready_q gets set.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("IRQ counter never enters opcode without IRQ"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_no_irq_in_op_without_ready
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (iq_use_irq),
      .test_expr   (~hready_i | ~op_en | int_ready_nxt | ~op_sel_iq),
      .fire        ());

   // --------
   // Store-multiples to IO port must appear as word sized writes.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("STM with IOMATCH must appears as an IO write"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_stm_to_io
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (ls_trans & ls_multi & io_match & ls_write & ~fault_gen &
                    hready_i),
      .test_expr   (cpu_io_trans_o & cpu_io_write_o & io_buf_a_q &
                    (cpu_io_size_o==2'b10)),
      .fire        ());

   // --------
   // Load-multiples to IO port must appear as word sized reads

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("LDM with IOMATCH must appears as an IO read"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_ldm_from_io
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (ls_trans & ls_multi & io_match & ~ls_write & ~fault_gen &
                    hready_i),
      .test_expr   (cpu_io_trans_o & ~cpu_io_write_o & io_buf_a_q &
                    (cpu_io_size_o==2'b10)),
      .fire        ());

   // --------
   // If EXE state has issued a fetch, then only one PFU cycle is need.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Branches must only have one PFU cycle"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_branch_single_pfu
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (run_exe & fetch_force & hready_i),
      .test_expr   (~run_pfu | ~extend_q),
      .fire        ());

   // --------
   // The register-A pointer must be written before it is used.

   // The RA pointer is going to be used in the following list of core states
   // and most instructions (excluding those explicitly listed):

   wire        a_ra_addr_used = ( (atomic_q & ~(run_rst |
                                                (run_hlt & ~hlt_aux_sel_ra &
                                                 ~(wr_en & wr_addr_sel_ra)))) |
                                  run_str | run_ldr | run_ldm | run_stm |
                                  run_wfx |
                                  (run_exe & ~(fmt_br1 | fmt_br2 | fmt_u16 |
                                               fmt_sy1 | fmt_sy5)) );

   reg         a_ra_addr_valid_q;

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n)
       a_ra_addr_valid_q <= 1'b0;
     else if(hready_i & ra_addr_en)
       a_ra_addr_valid_q <= 1'b1;

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Core must write RA pointer before using it"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_ra_addr_used_before_init
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (a_ra_addr_used),
      .consequent_expr (a_ra_addr_valid_q),
      .fire            ());

   // --------
   // The register-B pointer must be written before it is used.

   // The RB pointer is going to be used in the following list of core states
   // and most instructions (excluding those explicitly listed):

   wire        a_rb_addr_used = ( (atomic_q & ~(run_rst |
                                                (run_irq & irq_cyc_1) |
                                                (run_hlt & hlt_iaex_hold &
                                                 ~(wr_en & wr_addr_sel_rb)))) |
                                  run_ldm | run_stm |
                                  (run_ldr & ~fault_q) | (run_str & ~fault_q) |
                                  (run_t32 & ~(fmt_u32 | fmt_tt1 | fmt_tt2 |
                                               (fmt_tt3 & tt3_isn_mrs))) |
                                  (run_exe & (fmt_dp1 | fmt_dp5 | fmt_dp8 |
                                              fmt_ls2 | fmt_br3)) |
                                  (run_wfx & ~op_s_q & (fmt_dp1 | fmt_dp5 |
                                                        fmt_dp8 | fmt_ls2 |
                                                        fmt_br3)) );

   reg         a_rb_addr_valid_q;

   always @(posedge hclk or negedge hreset_n)
     if (~hreset_n)
       a_rb_addr_valid_q <= 1'b0;
     else if (hready_i & rb_addr_en)
       a_rb_addr_valid_q <= 1'b1;

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Core must write RB pointer before using it"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_rb_addr_used_before_init
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (a_rb_addr_used),
      .consequent_expr (a_rb_addr_valid_q),
      .fire());

   // --------
   // Half-word aligned specials following multi-cycles must appear in the OP.

   wire        a_multi_cyc_instr = ( (run_ldm & ~(list_q[7] | ldm_pop_pc)) |
                                     run_stm | run_mul | run_ldr | run_str |
                                     run_wfx );

   wire        a_iq_non_irq_special = iq_s_q & (iq_q[15:14] != 2'b11);

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Special multi-cycle instructions must be indicated"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_multi_cyc_special_ok
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (~atomic_q & a_multi_cyc_instr & ~iaex_q[0] &
                        a_iq_non_irq_special),
      .consequent_expr (op_s_q),
      .fire            ());

   // --------
   // Non-special and BKPT opcodes must be passed unmodified from IQ to OP.

   wire        a_op_q_bkpt_or_udf = {op_q[15], op_q[13:8]} == 7'b1_111110;

   ovl_implication
    #(.severity_level (`OVL_FATAL),
      .property_type  (`OVL_ASSERT),
      .msg            ("Non-special IQ to OP unmodified under multi-cycle"),
      .coverage_level (`OVL_COVER_DEFAULT),
      .clock_edge     (`OVL_POSEDGE),
      .reset_polarity (`OVL_ACTIVE_LOW),
      .gating_type    (`OVL_GATE_NONE))
    u_asrt_multi_cyc_nonspecial
    (.clock           (hclk),
     .reset           (hreset_n),
     .enable          (1'b1),
     .antecedent_expr (~atomic_q & a_multi_cyc_instr & ~iaex_q[0] & ~iq_s_q &
                       ~op_s_q & ~nvm_int_pend_i & ~int_ready_q & ~cfg_hwf),
     .consequent_expr (run_wfx | (op_q[15:0] == iq_q[15:0]) |
                       a_op_q_bkpt_or_udf),
     .fire            ());

   // --------
   // Invariant support for why R13 must be MSP in Handler Mode.

   wire a_when_spsel_is_zero = ( (ipsr_q[5:0] != 6'b0) &
                                 (~atomic_q |
                                  run_rst | run_hlt | run_ldm |
                                  (run_rfe & rfe_cyc_4) |
                                  (run_rfe & rfe_cyc_2 & ~iaex_q[2])) );

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("R13 must be MSP in handler and return to Handler"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_spsel_zero
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (a_when_spsel_is_zero),
      .consequent_expr (~spsel_q),
      .fire            ());

   // --------
   // Core can not see an AHB bus fault if it is not in a data-phase

   reg         a_cpu_dphase_q;

   always @(posedge hclk or negedge hreset_n)
     if (~hreset_n)
       a_cpu_dphase_q <= 1'b0;
     else if (hready_i)
       a_cpu_dphase_q <= ahb_trans;

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Core cannot have bus error if not in a data phase"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_core_no_dphase_no_resp
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (~a_cpu_dphase_q),
      .consequent_expr (~mtx_cpu_resp_i),
      .fire            ());

   // --------
   // Invariant that states a super-set of the core's reachable state space.

   // The IO port control flops may only take the stated combinations of values
   // in the stated core states.

   wire       a_iop_ctl_ok =
                // Buffer never valid when there is no IOP
              ( (~io_buf_d_q & ~io_buf_a_q) |
                ( cfg_iop &
                    // IO Buffer is address for LDM
                  ( (~io_buf_d_q & io_buf_a_q & io_rsel_q &
                      (run_ldm | atomic_q & ~run_wfx) & cpu_io_trans_o) |
                    // IO Buffer is data for single cycle LDR/STR
                    ( io_buf_d_q & ~io_buf_a_q & io_rsel_q &
                      run_exe) |
                    // IO Buffer is address for STM (D flag indicates STM)
                    ( io_buf_d_q &  io_buf_a_q & io_rsel_q &
                      (run_stm | atomic_q & ~run_wfx)) ) ) );

   // Core is in particular states while executing WFI/WFE

   wire       a_wfx_op_ok = ~(fmt_ls4 & ~op_s_q & ~atomic_q &
                              (run_wfx | run_exe)) | ra_addr_q == 4'd13;

   wire [3:0] a_list_pcnt = ( list_q[0] + list_q[1] + list_q[2] + list_q[3] +
                              list_q[4] + list_q[5] + list_q[6] + list_q[7] );

   wire       a_sleep_lock_ok = ~sleep_lock_q | (run_wfx & wfx_cyc_2);

   wire       a_insts_ok = (( cfg_dbg | op_s_q | op_q[15:8] != 8'b10111110 ) &
                            ( cfg_dbg | ~iq_s_q | (run_wfx & iq_use_irq) |
                              ~iq_q[15] & ~iq_q[12] | iq_q[14] &
                              (iq_q[15] | atomic_q) ) &
                            ( cfg_dbg | ~op_s_q | ~op_q[15] & ~op_q[12] |
                              (op_q[15:14] == 2'b11)) &
                            ( cfg_dbg | ~(op_s_q & op_q[12]) ) );

   wire       a_irq_ok    = ( ( ( ~int_ready_q | ((iq_s_q | atomic_q) &
                                                  (iq_q[14]) &
                                                  (iq_q[15] | atomic_q) &
                                                  (iq_q[5:0] != 6'b0)) ) &
                                ( atomic_q | (spsel_q == 1'b0) |
                                  (ipsr_q == 6'b0)) &
                                ( ~(iq_s_q & (iq_q[15:14] == 2'b11)) |
                                  (iq_q[5:0] != 6'b0)) ) );

   wire       a_mul_ok = ( ( ~(run_mul |
                               ((run_exe | run_wfx & ~atomic_q) & fmt_dp5)) |
                             (ra_addr_q[3] == 1'b0) & (rb_addr_q[3] == 1'b0) ) &
                           ( ~run_mul |
                             (list_q[7:0] == 8'h8F) |
                             (list_q[7:0] == 8'h00) ) );

   wire       a_lr_is_exc = ( (r14_q[31:28] == 4'hF) &
                              ((r14_q[3:0] == 4'h1) |
                               (r14_q[3:0] == 4'h9) |
                               (r14_q[3:0] == 4'hD) ) );

   wire       a_vstate_ok =
              (  (~atomic_q & (state_q == st_exe) &
                  ( (cfg_hwf | iaex_q[0] | ~(a_cpu_dphase_q | fault_q)) ) &
                  (~cfg_iop | io_rsel_q) &
                  ( op_s_q | op_q[15:12] != 4'b1100 | ra_addr_q[3] == 1'b0 ) &
                  ( op_s_q | {op_q[15:12],op_q[10:9]} != 6'b1011_10 |
                    ra_addr_q[3:0] == 4'd13 ) ) |

                 (~atomic_q & (state_q == st_pfu) &
                  (extend_q | a_cpu_dphase_q | fault_q)) |

                 (~atomic_q & (state_q == st_ldr) &
                  ((rb_addr_q[3] == 1'b0 & a_cpu_dphase_q) | fault_q) ) |

                 (cfg_smul & ~atomic_q & ~fault_q & ~a_cpu_dphase_q &
                  (state_q == st_mul) ) |

                 (~atomic_q & (state_q == st_stm) &
                  ( (aux_q[1:0] == 2'b0) & (a_cpu_dphase_q ^
                      (cfg_iop & cpu_io_trans_o & cpu_io_write_o)) |
                    fault_q ) &
                  ( base_q[2:0] == 3'b100 ) &
                  ( ra_addr_q[3] == 1'b0 |
                    ra_addr_q[3:0] == 4'd13 ) &
                  ( rb_addr_q[3] == 1'b0 |
                    rb_addr_q[3:0] == 4'hE & list_q[7:0] == 8'h0 ) &
                  ( offset_q[3:0] < (4'hA - a_list_pcnt[3:0]) ) ) |

                 (atomic_q & (state_q == st_stm) & int_ready_q &
                  ( a_cpu_dphase_q ^ (cfg_iop & cpu_io_trans_o &
                                      cpu_io_write_o) |
                     fault_q ) &
                  ( base_q[2:0] == 3'b100 ) &
                  ( aux_q[1:0] == 2'b0 ) &
                  ( ra_addr_q[3:0] == 4'd13 ) &
                  ( {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h1_8F_0 |
                    {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h2_8E_1 |
                    {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h3_8C_2 |
                    {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h4_88_3 |
                    {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h5_80_C |
                    {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h6_00_E )
                  ) |

                 (~atomic_q & (state_q == st_ldm) &
                  ( a_cpu_dphase_q | fault_q |
                    (cfg_iop & cpu_io_trans_o & ~cpu_io_write_o) ) &
                  ( (aux_q[1:0] == 2'b0) | fault_q ) &
                  ( ra_addr_q[3] == 1'b0 |
                    ra_addr_q[3:0] == 4'd13 ) &
                  ( rb_addr_q[3:0] != 4'hE | list_q[7:0] == 8'h00) &
                  ( rb_addr_q[3] == 1'b0 |
                    rb_addr_q[3:0] == 4'hE )  &
                  ( offset_q[3:0] < (4'hA - a_list_pcnt[3:0]) ) ) |

                 (atomic_q & (state_q == st_ldm) &
                  ( a_cpu_dphase_q | fault_q |
                    (cfg_iop & cpu_io_trans_o & ~cpu_io_write_o) ) &
                  ((spsel_q == 1'b0) | (ipsr_q == 6'b0)) &
                  ( ra_addr_q[3:0] == 4'd13 ) &
                  ( aux_q[1:0] == 2'b0) &
                  ( {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h1_8F_0 |
                    {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h2_8E_1 |
                    {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h3_8C_2 |
                    {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h4_88_3 |
                    {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h5_80_C |
                    {offset_q[3:0], list_q[7:0], rb_addr_q[3:0]} == 16'h6_00_E )
                  ) |

                 (cfg_dbg & atomic_q & (state_q == st_hlt) &
                  ((spsel_q == 1'b0) | (ipsr_q == 6'b0)) ) |

                 (~atomic_q & ~fault_q & ~a_cpu_dphase_q & (state_q == st_wfx) &
                  ( op_s_q | op_q[15:12] != 4'b1100 | ra_addr_q[3] == 1'b0 ) &
                  ( op_s_q | {op_q[15:12],op_q[10:9]} != 6'b1011_10 |
                    ra_addr_q[3:0] == 4'd13 ) &
                  ( offset_q == 4'h0 |
                    offset_q == 4'h1 |
                    offset_q == 4'h2 |
                    offset_q == 4'h3 ) ) |

                 ( atomic_q & (state_q == st_wfx) &
                   ((spsel_q == 1'b0) | (ipsr_q == 6'b0)) &
                   ( ra_addr_q[3:0] == 4'd13 ) &
                   ( aux_q[1:0] == 2'b0 ) &
                   ( offset_q == 4'h0 |
                     offset_q == 4'h1 |
                     offset_q == 4'h2 |
                     offset_q == 4'h3 ) &
                   ( ra_addr_q[3:0] == 4'd13 ) ) |

                 (~atomic_q & (state_q == st_str) &
                  ( base_q[2:0] == 3'b100 |
                    base_q[2:0] == 3'b010 |
                    base_q[2:0] == 3'b001 ) &
                  ( (rb_addr_q[3] == 1'b0 & a_cpu_dphase_q) | fault_q ) ) |

                 (~atomic_q & (state_q == st_t32) & ~extend_q & hready_i &
                  ~a_cpu_dphase_q &
                  ( ~(iq_s_q & (iq_q[15:14] == 2'b11)) | int_ready_q ) ) |

                 ( atomic_q & (state_q == st_irq) & (iq_q[5:0] != 6'b0) &
                   ( (offset_q[3:0] == 4'h1) & int_ready_q |
                     (offset_q[3:0] == 4'h7) & a_lr_is_exc |
                     (offset_q[3:0] == 4'h8) & a_lr_is_exc |
                     (offset_q[3:0] == 4'h9) & a_lr_is_exc) &
                   ( ra_addr_q[3:0] == 4'd13 ) ) |

                 ( atomic_q & (state_q == st_rfe) &
                   ( ra_addr_q[3:0] == 4'd13 ) &
                   ( (offset_q[3:0] == 4'h0) &
                     ((spsel_q == 1'b0) | (iaex_q[2] == 1'b1)) |
                     (offset_q[3:0] == 4'h1) &
                     ((spsel_q == 1'b0) | (iaex_q[2] == 1'b1)) |
                     (offset_q[3:0] == 4'h2) &
                     (aux_q[1:0] == 2'b0) &
                     ((spsel_q == 1'b0) | (ipsr_q == 6'b0)) |
                     (offset_q[3:0] == 4'h7) & (aux_q[1:0] == 2'b0) &
                     ((spsel_q == 1'b0) | (ipsr_q == 6'b0)) |
                     (offset_q[3:0] == 4'h8) & int_ready_q  &
                     ((spsel_q == 1'b0) | (ipsr_q == 6'b0)) ) ) |

                 (~atomic_q & (state_q == st_lck) &
                  ( (&iaex_q[30:0]) &
                    (spsel_q == 1'b0) ) &
                  ( ipsr_q[5:0] == 6'd2 |
                    ipsr_q[5:0] == 6'd3 ) ) |

                 (atomic_q & (state_q == st_rst) &
                  ( spsel_q == 1'b0 ) &
                  ( (offset_q[3:0] == 4'hF & ~a_cpu_dphase_q & ~fault_q) |
                    (offset_q[3:0] == 4'h0 & ~a_cpu_dphase_q & ~fault_q) |
                    offset_q[3:0] == 4'h1 |
                    offset_q[3:0] == 4'h2 ) )

                 );

   wire       a_core_state_ok = ( a_vstate_ok & a_insts_ok & a_sleep_lock_ok &
                                  a_irq_ok & a_wfx_op_ok & a_iop_ctl_ok &
                                  a_mul_ok );

   // --------
   // Dependent on a property linking the *dphase_q flops in the core, the
   // matrix and the debug interface being consistent.

   ovl_always
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Machine state must always be valid"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_vstate
     (.clock     (sclk),
      .reset     (hreset_n),
      .enable    (1'b1),
      .test_expr (a_core_state_ok),
      .fire      ());

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Machine state must remain valid"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_vstate_next
     (.clock       (sclk),
      .reset       (hreset_n),
      .enable      (1'b1),
      .start_event (a_core_state_ok),
      .test_expr   (a_core_state_ok),
      .fire        ());

   // --------
   // IAEX may only be loaded from one source.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Next IAEX value precisely match at least one source"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_iaex_next_ok
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (hready_i & iaex_en),
      .consequent_expr (iaex_nxt == iaex_inc |
                        iaex_nxt == add_res[31:1] |
                        iaex_nxt == rb_value[31:1] |
                        iaex_nxt == bus_rdata[31:1] ),
      .fire            ());

   // --------
   // When the core is held in WFE the offset register must always be 1

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Offset must be 1 when holding sleep in WFE"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_wfe_sleep_lock
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr ((~extend_q & ~atomic_q) &
                        sleep_lock_q &
                        state_q == st_wfx),
      .consequent_expr (offset_q == 4'b0001),
      .fire            ());

   // --------
   // When the core is held asleep in WFE the offset register must always be 1

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Offset must be 1 when holding sleep in WFE"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_wfx_nonatomic_sleep_lock
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (~atomic_q &
                        sleep_lock_q &
                        state_q == st_wfx),
      .consequent_expr (offset_q == 4'b0001),
      .fire            ());

   // --------
   // The sleep lock fulfilling a SLEEPHOLDREQ may only apply once the core
   // has entered sleep.

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ("Sleep Lock only possible in WFI/E"),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_sleep_lock_only_in_wfx
     (.clock            (sclk),
      .reset            (hreset_n),
      .enable           (1'b1),
      .antecedent_expr  (sleep_lock_q),
      .consequent_expr  (state_q == st_wfx & wfx_cyc_2),
      .fire             ());

   // --------
   // The core should be in an exception handler when signaling a return from
   // exception.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("A return can only be signaled from Handler Mode"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_handler_return_only
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (cpu_int_return_o),
      .consequent_expr (handler),
      .fire            ());

   // --------
   // When the fast multiplier is not being used, its output should be zero.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Fast multiplier output must be 0 if not enabled"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_multiply_output_zero
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (~cfg_smul & ~mul_en),
      .consequent_expr (alu_res_mul_res[31:0] == 32'h00000000),
      .fire            ());

   // --------
   // Core must be in a data phase when the HRDATA value is to become a branch
   // target.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("HRDATA to IAEX, must be a dphase or going to Lockup"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_iaex_ahb_data
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (hready_i & iaex_en & iaex_sel_bus & ~io_rsel_q),
      .consequent_expr (a_cpu_dphase_q | &iaex_nxt[30:0]),
      .fire            ());

   // --------
   // IOP read data should be valid when used as a branch target.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("IORDATA to IAEX, must be valid or about to Lockup"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_iaex_iop_data
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (hready_i & iaex_en & iaex_sel_bus & ~mtx_ppb_active_i &
                        io_rsel_q),
      .consequent_expr (io_buf_a_q | io_buf_d_q | &iaex_nxt[30:0]),
      .fire            ());

   // --------
   // There must be an AHB data phase when HRDATA is to be used as opcodes.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Data phase required if loading instruction from bus"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_fetch_ahb_data
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr ( hready_i & ~fault_q &
                         ((op_en & (op_sel_hi | op_sel_lo)) |
                          (iq_en & (iq_sel_hi | iq_sel_lo))) ),
      .consequent_expr (a_cpu_dphase_q),
      .fire            ());

   // --------
   // IOP data must be valid when it is going to be used, under these
   // explicitly stated conditions.

   wire       a_asrt_using_bus_data =
              ( (tbit_en & (tbit_sel_bus | tbit_sel_rfe)) |
                (extend_en & (run_rfe & (rfe_cyc_2 | rfe_cyc_4))) |
                (msp_en & (run_rst & (rst_cyc_3 | rst_cyc_4))) |
                run_ldr |
                run_ldm );

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("IOP read data must when used be valid"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_iop_data
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (a_asrt_using_bus_data & ~fault_q & hready_i &
                        io_rsel_q),
      .consequent_expr (io_buf_a_q | io_buf_d_q),
      .fire            ());

   // --------
   // Core's AHB master must be in a data phase when using the AHB data, under
   // the stated conditions.

   wire       a_asrt_data_from_bus = hready_i & ~io_rsel_q & ~fault_q;

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Processor must be in data phase when using bus data"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_ahb_data
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (a_asrt_using_bus_data & a_asrt_data_from_bus),
      .consequent_expr (a_cpu_dphase_q),
      .fire            ());

   // --------
   // The instruction queue must contain a branch opcode when the branch
   // indicator is set, except when it has been overwritten due to a pending
   // interrupt.

   wire       a_iq_rd_pc  = {iq_q[7],iq_q[2:0]} == 4'b1_111;
   wire       a_iq_add_pc = (iq_q[15:8] == 8'b01000100) & a_iq_rd_pc;
   wire       a_iq_branch = iq_q[15:11] == 5'b11100;
   wire       a_iq_bx_blx = iq_q[15:8] == 8'b01000111;
   wire       a_iq_cpy_pc = (iq_q[15:8] == 8'b01000110) & a_iq_rd_pc;
   wire       a_iq_pop_pc = iq_q[15:8] == 8'b1011_1101;

   wire       a_iq_is_branch = ( a_iq_add_pc | a_iq_branch |
                                 a_iq_bx_blx | a_iq_cpy_pc |
                                 a_iq_pop_pc );

   wire       a_op_rd_pc  = {op_q[7],op_q[2:0]} == 4'b1_111;
   wire       a_op_add_pc = (op_q[15:8] == 8'b01000100) & a_op_rd_pc;
   wire       a_op_branch = fmt_br2 | fmt_br3;
   wire       a_op_bx_blx = op_q[15:8] == 8'b01000111;
   wire       a_op_cpy_pc = (op_q[15:8] == 8'b01000110) & a_op_rd_pc;
   wire       a_op_pop_pc = op_q[15:8] == 8'b1011_1101;

   wire       a_op_is_branch = ( a_op_add_pc | a_op_branch |
                                 a_op_bx_blx | a_op_cpy_pc |
                                 a_op_pop_pc );

   // --------
   // Under these conditions it is possible that the IQ's content is not an
   // instruction.
   wire a_iq_not_isn = atomic_q | iq_s_q | run_pfu | int_ready_q;

   reg        a_iq_not_isn_q;

   wire       a_iq_not_isn_set = iq_free_en;
   wire       a_iq_not_isn_clr = iq_en & hready_i;

   always @(posedge sclk or negedge hreset_n)
     if (~hreset_n)
       a_iq_not_isn_q <= 1'b1;
     else if (a_iq_not_isn_set | a_iq_not_isn_clr)
       a_iq_not_isn_q <= a_iq_not_isn_set;

   reg        a_op_not_isn_q;

   wire       a_op_not_isn_set = op_en & op_sel_iq & hready_i & a_iq_not_isn_q;
   wire       a_op_not_isn_clr = op_en & hready_i & ~a_op_not_isn_set;

   always @(posedge sclk or negedge hreset_n)
     if (~hreset_n)
       a_op_not_isn_q <= 1'b0;
     else if (a_op_not_isn_set | a_op_not_isn_clr)
       a_op_not_isn_q <= a_op_not_isn_set;

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("IQ must be a branch or non-instr when iq_branch_q"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_iq_branch_state_ok
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (iq_branch_q),
       .consequent_expr (a_iq_is_branch | a_iq_not_isn_q),
       .fire            ());

   // --------
   // If the instruction queue is to be used as the next opcode, the contents
   // should be consistent with the branch indication.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("iq_branch implies IQ is branch on transfer to OP"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_iq_branch_into_op
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (iq_branch_q & ~iq_s_q & op_en & op_sel_iq & hready_i),
       .consequent_expr (a_iq_is_branch),
       .fire            ());

   // --------
   // The instruction queue holds the second halfword for T32 instructions,
   // therefore there should never be a T32 execution state when it is used as
   // a jitter counter.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("IQ must contain an opcode halfword in T32 state."),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_iq_isn_t32
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (a_iq_not_isn),
       .consequent_expr (~run_t32),
       .fire            ());

   // --------
   // Provides a message when unpredictable T16 instructions are executed.

   wire       a_bad_add  = op_q[15:0] == 16'b0100010011111111;

   wire       a_bad_blx  = ((op_q[15:7] == 9'b010001111) &
                            ((op_q[6:3] == 4'b1111) | (op_q[2:0] != 3'b000)));

   wire       a_bad_bx   = ((op_q[15:7] == 9'b010001110) &
                            ((op_q[6:3] == 4'b1111) | (op_q[2:0] != 3'b000)));

   wire       a_bad_cmp  = ((op_q[15:8] == 9'b01000101) &
                            (({op_q[7],op_q[6]} == 2'b00) |
                             ({op_q[7],op_q[2:0]} == 4'b1111) |
                             (op_q[6:3] == 4'b1111) ));

   wire       a_bad_ldm  = {op_q[15:11],op_q[7:0]} == 13'b11001_00000000;
   wire       a_bad_stm  = {op_q[15:11],op_q[7:0]} == 13'b11000_00000000;
   wire       a_bad_push = op_q[15:0] == 16'b1011110_000000000;
   wire       a_bad_pop  = op_q[15:0] == 16'b1011010_000000000;

   wire       a_bad_cps  = ( (op_q[15:5] == 11'b10110110011) &
                             (op_q[3:0] != 4'b0010) );

   ovl_implication
     #(.severity_level (`OVL_INFO),
       .property_type  (`OVL_ASSERT),
       .msg            ("Warning, UNPREDICTABLE 16-bit instruction executed"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_info_unpredictable_t16
     ( .clock           (hclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (run_exe & ~op_s_q),
       .consequent_expr ( !(a_bad_ldm | a_bad_stm | a_bad_push |
                            a_bad_pop | a_bad_cps | a_bad_add |
                            a_bad_blx | a_bad_cmp | a_bad_bx ) ),
       .fire            ());

  // --------
  // Provides a message in simulation when an LDM or STM is done to Device or
  // Strongly Ordered memory regions.

   wire       a_ldstm_start = run_exe & (fmt_lm1 | fmt_lm2) & hready_i;
   wire       a_ldm_going   = run_ldm & ~atomic_q & ~list_empty & hready_i;
   wire       a_stm_going   = run_stm & ~atomic_q & ~list_empty & hready_i;

   wire [3:0] a_ldstm_addr_31to28 = ( {4{a_ldstm_start}} & ra_value[31:28] |
                                      {4{a_ldm_going}}   & ahb_addr[31:28] |
                                      {4{a_stm_going}}   & ahb_addr[31:28] );

   // For default memory map, follow mappings in ARM ARM
   wire       a_ldstm_addr_devso_nompu = ( (a_ldstm_addr_31to28 == 4'h4) |
                                           (a_ldstm_addr_31to28 == 4'h5) |
                                           (a_ldstm_addr_31to28 >= 4'hA) );

   // Values for SCB for the MPU case obtained from Table B3-30 in ARM ARM
   wire       a_ldstm_addr_devso_mpu = ( (ahb_scb[2:0] == 3'b100) |
                                         (ahb_scb[2:0] == 3'b101) );

   wire       a_ldstm_addr_devso = (  cfg_mpu & a_ldstm_addr_devso_mpu |
                                     ~cfg_mpu & a_ldstm_addr_devso_nompu );

   ovl_implication
     #(.severity_level (`OVL_INFO),
       .property_type  (`OVL_ASSERT),
       .msg            ("LDM/STM into DEV/SO region, unsafe if interrupted"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_info_ldstm_devso
     (.clock            (hclk),
      .reset            (hreset_n),
      .enable           (1'b1),
      .antecedent_expr  (a_ldstm_start | a_ldm_going | a_stm_going),
      .consequent_expr  (~a_ldstm_addr_devso),
      .fire             ());

   // --------
   // The processor will replay all load/store multiples that get interrupted.
   // This may result in system issues for access-sensitive peripherals which
   // normally reside in Device or Strongly Ordered memory regions - this
   // assertion provides simulation messages when it happens.

   ovl_implication
     #(.severity_level (`OVL_INFO),
       .property_type  (`OVL_ASSERT),
       .msg            ("LDM/STM into DEV/SO region interrupted"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_info_ldstm_devso_int
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr ((a_ldm_going | a_stm_going) & a_ldstm_addr_devso),
      .consequent_expr (~preempt),
      .fire            ());

   // --------
   // On completion of interrupt entry, the last vector fetched must
   // correspond to what we are now running.

   reg [5:0] a_vec_num_q;

   wire      a_irq_done = run_irq & state_en & state_sel_pfu;

   always @(posedge hclk)
     if(vtable & hready_i)
       a_vec_num_q <= addr_aligned[7:2];

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Last vector fetch must be for active exception"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_ipsr_vector_consistent
     ( .clock           (hclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (a_irq_done),
       .consequent_expr (a_vec_num_q == ipsr_q),
       .fire            ());

   // --------
   // There can only be one attempt at a Hardfault vector fetch in a single
   // interrupt entry sequence.

   reg       a_hf_vec_seen_q;
   wire      a_hf_vec_seen = ls_trans & vtable & (addr_aligned[7:2] == 6'd3);
   wire      a_hf_vec_en = hready_i & (a_irq_done | a_hf_vec_seen);

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n)
       a_hf_vec_seen_q <= 1'b0;
     else if(a_hf_vec_en)
       a_hf_vec_seen_q <= a_hf_vec_seen;

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Maximum one Hardfault vector fetch per exception"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_one_hdf_vect_per_exception
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (a_hf_vec_seen),
      .consequent_expr (~a_hf_vec_seen_q),
      .fire            ());

   // --------
   // The architecture requires that SPSEL be impossible to modify when in
   // Handler mode.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("CONTROL.SPSEL must be immutable except when allowed"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_spsel_update
     ( .clock           (hclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (~( (run_t32 & fmt_tt3 & ~handler) |  // MSR
                            (run_exe & br3_bx_rfe) |        // BX return
                            (run_ldm & ldm_return) |        // POP return
                            (run_irq) |                     // Interrupt entry
                            (run_hlt & ~handler) )),        // Debug update
       .consequent_expr ( ~(spsel_en & hready_i) ),
       .fire            ());

   // --------

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Faulted Hardfault vector without NMI must Lockup"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_hardfault_lockup
     ( .clock           (hclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (run_irq & irq_cyc_4 & fault_q & (ipsr_q == 6'd3)),
       .consequent_expr ( (state_sel_pfu & state_en & iaex_sel_add &
                           ~iaex_hold & ~int_ready_q) |
                          (iq_q[5:0] == 6'd2) & int_ready_q ),
       .fire            ());

   // --------
   // The architecture defines the valid EXC_RETURN values.

   reg [3:0] a_exc_ret_3to1_q;

   always @(posedge hclk)
     if(preempt)
       casez({handler,spsel_q})
         2'b00 : a_exc_ret_3to1_q <= 4'h9;
         2'b01 : a_exc_ret_3to1_q <= 4'hD;
         2'b1? : a_exc_ret_3to1_q <= 4'h1;
       endcase // case ({handler,spsel_q})
     else if(~atomic_q & state_en & state_sel_rfe)
       casez(run_ldm ? bus_rdata[3:0] : rb_value[3:0])
         4'b0??? : a_exc_ret_3to1_q <= 4'h1;
         4'b10?? : a_exc_ret_3to1_q <= 4'h9;
         4'b11?? : a_exc_ret_3to1_q <= 4'hD;
       endcase

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ("EXC_RETURN value must be consistent with origin"),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_exc_return_match_origin
     (.clock            (hclk),
      .reset            (hreset_n),
      .enable           (1'b1),
      .antecedent_expr  (run_irq & state_sel_pfu & state_en),
      .consequent_expr  (r14_q[3:0] == a_exc_ret_3to1_q),
      .fire             ());

  // --------
  // Exception entry.

  wire [29:0] a_stack_pointer = spsel_q ? psp_q[29:0] : msp_q[29:0];

  reg  a_excent_q;
  wire a_excent_end    = a_excent_q & run_pfu;
  wire a_excent_start  = preempt | (run_rfe & rfe_chain);
  wire a_excent_en     = hready_i & (a_excent_start | a_excent_end);

  always @(posedge sclk or negedge hreset_n)
    if (~hreset_n)
      a_excent_q <= 1'b0;
    else if (a_excent_en)
      a_excent_q <= a_excent_start;

  wire a_hen_state = state_q == st_pfu |              // Exit condition
                     (state_q == st_stm & atomic_q) | // Stacking
                      state_q == st_rfe |             // RFE (Tail Chain)
                      state_q == st_irq;              // Interrupt entry

  // Look for:
  // Tail chain case   --> xSP should stay the same
  // Late arrival case --> xSP stays the same
  // Normal case (IRQ) --> xSP should get bigger, due to stacking
  // Normal case (SVC) --> xSP should get bigger, due to stacking
  // IPSR should never be 0
  // MSP always selected

  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (`OVL_ASSERT),
    .msg              ({"Core may only be in PFU, STM, RFE or IRQ states ",
                        "during exception entry"}),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
  u_asrt_exception_entry_corestate
  ( .clock            (sclk),
    .reset            (hreset_n),
    .enable           (1'b1),
    .antecedent_expr  (a_excent_q),
    .consequent_expr  (a_hen_state),
    .fire             ());

   // --------
   // Exceptions always result in entry to Handler mode, and Handler mode
   // IPSR values are always non-zero.

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ({"IPSR must be non-zero once exception entry is ",
                           "completed"}),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_exception_entry_ipsr
     ( .clock            (sclk),
       .reset            (hreset_n),
       .enable           (1'b1),
       .antecedent_expr  (a_excent_q & a_excent_end),
       .consequent_expr  (|ipsr_q[5:0]),
       .fire             ());

   // --------
   // Handler mode always uses the main stack pointer.

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ({"MSP must be selected once exception entry is ",
                           "completed"}),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_exception_entry_spsel
     ( .clock            (sclk),
       .reset            (hreset_n),
       .enable           (1'b1),
       .antecedent_expr  (a_excent_q & a_excent_end),
       .consequent_expr  (~spsel_q),
       .fire             ());

   // --------
   reg [30:0] a_pc_to_stack_q;

   wire a_pc_to_stack_en = a_excent_start;

   wire a_pc_to_change = ~iaex_hold & ~(run_alt & (&op_q[15:14]));

   wire [30:0] a_pc_to_stack_nxt = (a_pc_to_change) ? iaex_nxt[30:0] : iaex_q[30:0];

   always @(posedge sclk or negedge hreset_n)
     if (~hreset_n)
       a_pc_to_stack_q[30:0] <= {31{1'b1}};
     else if (a_pc_to_stack_en)
       a_pc_to_stack_q[30:0] <= a_pc_to_stack_nxt[30:0];

   wire a_stacking_pc = run_irq & irq_cyc_2;

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("The stacked PC value should always be correct."),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_exception_entry_stack_correct_pc
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (a_stacking_pc),
       .consequent_expr (wdata_le[31:1] == a_pc_to_stack_q[30:0]),
       .fire            ());
  // --------
  // Exception Exit:

  // Start and end conditions
  wire a_bx_in_eh           = run_exe & fmt_br3 & br3_bx_rfe & ~preempt;
  wire a_poppc_in_eh        = run_ldm & ldm_return & ~atomic_q & ~preempt;
  wire a_bx_or_poppc_in_eh  = a_bx_in_eh | a_poppc_in_eh;

  // Start conditions
  wire a_tpsp = a_bx_in_eh    & (rb_value[31:0]  == 32'hFFFFFFFD) |
                a_poppc_in_eh & (bus_rdata[31:0] == 32'hFFFFFFFD);
  wire a_tmsp = a_bx_in_eh    & (rb_value[31:0]  == 32'hFFFFFFF9) |
                a_poppc_in_eh & (bus_rdata[31:0] == 32'hFFFFFFF9);
  wire a_hmsp = a_bx_in_eh    & (rb_value[31:0]  == 32'hFFFFFFF1) |
                a_poppc_in_eh & (bus_rdata[31:0] == 32'hFFFFFFF1);

  reg a_excexit_q;

  wire a_excexit_start = a_tpsp | a_tmsp | a_hmsp;
  wire a_excexit_end = a_excexit_q & run_pfu;

  wire a_excexit_en = a_excexit_start | a_excexit_end;

  always @(posedge sclk or negedge hreset_n)
    if (~hreset_n) a_excexit_q <= 1'b0;
    else if (hready_i & a_excexit_en) a_excexit_q <= a_excexit_start;

  // Valid core states for handler exit
  wire a_hex_state = state_q == st_pfu |                      // Exit condition
                     state_q == st_rfe |                      // RFE start
                     (state_q == st_ldm & atomic_q) |         // Unstacking
                     (state_q == st_irq & offset_q != 4'h1) | // Tail Chain
                     (state_q == st_wfx & atomic_q);          // SleepOnExit-WFI

  reg [ 5:0]  a_exp_ipsr_q;
  reg         a_exp_lockup_q;
  reg         a_exp_spsel_q;

  reg a_nmi_q;
  reg a_irq_q;
  reg [5:0] a_irq_num_q;

  // IRQ, NMI
  // When we are about to tail chain into another exception a new interrupt is
  // not taken until the handler is entered, therefore do not register that new
  // interrupt
  wire a_nvm_nmi_pending = nvm_int_pend_i & nvm_int_pend_num_i == 6'd2;
  wire a_nmi_nxt = a_excexit_q & a_nvm_nmi_pending;
  wire a_irq_nxt = nvm_int_pend_i & ~a_nvm_nmi_pending &
                   (~run_wfx | ~primask_q) &
                   (a_excexit_start |
                    (a_excexit_q &
                     a_exp_ipsr_q[5:0] != 6'd3 &
                     a_exp_ipsr_q[5:0] != 6'd2 &
                     ~fault_q));

  always @(posedge sclk or negedge hreset_n)
    if (~hreset_n) begin
      a_nmi_q <= 1'b0;
      a_irq_q <= 1'b0;
      a_irq_num_q <= 6'b000000;
    end else if (hready_i) begin
      a_nmi_q <= a_nmi_nxt;
      a_irq_q <= a_irq_nxt;
      a_irq_num_q <= nvm_int_pend_num_i;
    end

  // xPSR load faults
  wire a_psrf = a_excexit_q & run_rfe & rfe_cyc_2 & fault_q & ~spsel_q;

  // HardFault vector fetch fault
  wire a_hvf = a_excexit_q & run_irq & irq_cyc_3 & fault_q &
               a_exp_ipsr_q == 6'd3 & ~a_psrf;

  // NMI vector fetch fault
  wire a_nvf = a_excexit_q & run_irq & irq_cyc_3 & fault_q &
               a_exp_ipsr_q == 6'd2 & ~a_psrf;

  // Fault not during NMI or HardFault vector fetch
  wire a_hdf = a_excexit_q & fault_q &
               ~a_nmi_q & a_exp_ipsr_q != 6'd2 &
               a_exp_ipsr_q != 6'd3 &
               ~a_psrf;

  // HardFault and xPSR load faults need to mask out the interrupts
  wire a_irq_noft = a_irq_q & ~fault_q & a_excexit_q;

  // Qualify registered NMI to only show when it is going to be used
  wire a_nmi_qual = a_nmi_q & a_excexit_q;

  wire a_ipsr_bus = a_exp_ipsr_q == 6'd4 &
                    run_rfe & rfe_cyc_2 & ~fault_q &
                    bus_rdata[5:0] != 6'd2;

  wire a_exp_ipsr_en = a_tpsp | a_tmsp | a_hmsp |                  // Start
                       (a_excexit_q & (a_hdf | a_psrf | a_nmi_qual |
                                       a_irq_noft | a_ipsr_bus)) | // Change
                       a_excexit_end;                              // End

  wire [5:0] a_exp_ipsr_nxt = {6{a_tpsp}}   & 6'd0  |// Thread
                              {6{a_tmsp}}   & 6'd0  |// Thread
                              {6{a_hmsp}}   & 6'd4  |// Handler
                              {6{a_hdf}}    & 6'd3  |// HardFault
                              {6{a_psrf}}   & 6'd3  |// HardFault
                              {6{a_nmi_qual}}  & 6'd2  |// NMI
                              {6{a_irq_noft}}  & a_irq_num_q[5:0] |// IRQ
                              {6{a_ipsr_bus}}  & bus_rdata[5:0];// handler

  wire a_exp_lockup_nxt = a_hvf | a_psrf | a_nvf;
  wire a_exp_lockup_en = a_excexit_start | a_exp_lockup_nxt | a_excexit_end |
                         a_nmi_q;

  wire a_exp_spsel_nxt = a_tpsp;
  wire a_exp_spsel_en = a_tpsp | a_tmsp | a_hmsp |     // Start conditions
                        (a_excexit_q & (a_hdf | a_psrf | a_nmi_q | a_irq_q |
                                        a_ipsr_bus)) | // Change conditions
                        a_excexit_end;

  always @(posedge sclk or negedge hreset_n)
    if (~hreset_n) begin
      a_exp_ipsr_q[5:0]  <= 6'b000000;
      a_exp_lockup_q     <= 1'b0;
      a_exp_spsel_q      <= 1'b0;
    end else if (hready_i) begin
      if (a_exp_ipsr_en)   a_exp_ipsr_q   <= a_exp_ipsr_nxt;
      if (a_exp_lockup_en) a_exp_lockup_q <= a_exp_lockup_nxt;
      if (a_exp_spsel_en)  a_exp_spsel_q  <= a_exp_spsel_nxt;
    end

  wire a_hex_model_state = (a_exp_spsel_q & ~a_exp_lockup_q &
                            a_exp_ipsr_q[5:0] == 6'd0) |
                           (~a_exp_spsel_q &
                            (( a_exp_lockup_q & ~a_irq_q &
                              (a_exp_ipsr_q[5:0] == 6'd2 |
                               a_exp_ipsr_q[5:0] == 6'd3)) |
                              (~a_exp_lockup_q &
                               (~a_irq_q | (a_exp_ipsr_q[5:0] != 6'd2 |
                                            a_exp_ipsr_q[5:0] != 6'd3)))));

  wire a_hex_model_core_consistent = (spsel_q | ~a_exp_spsel_q) &
                                     (~run_irq | ~a_exp_spsel_q) &
                                     (~run_irq | (|a_exp_ipsr_q[5:0])) &
                                     (~a_exp_lockup_q | hdf_lock_q |
                                      nmi_lock_q);

  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (`OVL_ASSERT),
    .msg              ({"Core can only be in certain states during exception ",
                        "exit"}),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
  u_asrt_exception_exit_corestate
  ( .clock            (sclk),
    .reset            (hreset_n),
    .enable           (1'b1),
    .antecedent_expr  (a_excexit_q),
    .consequent_expr  (a_hex_state),
    .fire             ());

  // --------
  // The IPSR value after tail-chaining into HardFault, NMI or reset handlers
  // should be correct.

  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (`OVL_ASSERT),
    .msg              ({"Exception Exit to non-IRQ-handler Completed - IPSR ",
                        "Mismatch"}),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
  u_asrt_exception_exit_ipsr_nonirq
  ( .clock            (sclk),
    .reset            (hreset_n),
    .enable           (1'b1),
    .antecedent_expr  (a_excexit_q & a_excexit_end & a_exp_ipsr_q < 6'd4),
    .consequent_expr  (ipsr_q[5:0] == a_exp_ipsr_q[5:0]),
    .fire             ());

  // --------
  // The IPSR value after tail-chaining into an IRQ handler has been completed
  // should be consistent with being in an IRQ handler.

  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (`OVL_ASSERT),
    .msg              ({"Exception Exit to IRQ Handler Completed - IPSR ",
                        "Mismatch"}),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
  u_asrt_exception_exit_ipsr_irq
  ( .clock            (sclk),
    .reset            (hreset_n),
    .enable           (1'b1),
    .antecedent_expr  (a_excexit_q & a_excexit_end & a_exp_ipsr_q > 6'd4),
    .consequent_expr  (ipsr_q[5:0] >= 6'd4),  // Include SysTick
    .fire             ());

  // --------
  // The core should enter Lockup post exception exit only if its requisite
  // conditions are met.

  ovl_implication
  #(.severity_level   (`OVL_FATAL),
    .property_type    (`OVL_ASSERT),
    .msg              ("Exception Exit Completed - Lockup Mismatch"),
    .coverage_level   (`OVL_COVER_DEFAULT),
    .clock_edge       (`OVL_POSEDGE),
    .reset_polarity   (`OVL_ACTIVE_LOW),
    .gating_type      (`OVL_GATE_NONE))
  u_asrt_exception_exit_lockup
  ( .clock            (sclk),
    .reset            (hreset_n),
    .enable           (1'b1),
    .antecedent_expr  (a_excexit_q & a_excexit_end & a_exp_lockup_q),
    .consequent_expr  (&iaex_q[30:0]),
    .fire             ());

  // --------
  // Stack pointer must be correct once exception exit is completed.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Exception Exit Completed - Stack Pointer Mismatch"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_exception_exit_sp
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (a_excexit_q & a_excexit_end),
       .consequent_expr (spsel_q == a_exp_spsel_q),
       .fire            ());

   // --------
   // Stack pointer model must match reality at exception exit.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Exception Exit - Model SP and model IPSR mismatch"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_exception_exit_sp_value_during_check
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (a_excexit_q & a_exp_ipsr_q[5:0] != 6'd0),
       .consequent_expr (~a_exp_spsel_q),
       .fire            ());

   // --------
   // Auxiliary logic must be in known state during exception exit.
   // Note that as implemented, the consequent is always true.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Aux logic must be valid during exception exit"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_exception_exit_modelstate
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (a_excexit_q),
       .consequent_expr (a_hex_model_state),
       .fire            ());

   // --------
   // Auxiliary logic must be in known state during exception exit.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Aux logic must be consistent at exception exit"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_exception_exit_model_core_consistent
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (a_excexit_q),
       .consequent_expr (a_hex_model_core_consistent),
       .fire            ());

   // --------
   // Completion of exception handling must result in a fetch.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Exception exit can only end with a fetch"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_exception_exit_one_end
     ( .clock       (sclk),
       .reset       (hreset_n),
       .enable      (1'b1),
       .start_event (a_excexit_q & ~a_excexit_end),
       .test_expr   (a_excexit_q),
       .fire        ());

   // --------
   // NMI can never be preempted (except debug or reset).

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Nothing can interrupt the NMI handler"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_nmi_handler_never_preempt
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (ipsr_q[5:0] == 6'd2),
       .consequent_expr (~preempt),
       .fire            ());

   // --------
   // Ensure that only an NMI can preempt Hardfault.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Only NMI may interrupt the HardFault handler"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_only_nmi_preempts_hdf
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (ipsr_q[5:0] == 6'd3),
       .consequent_expr (~preempt | a_nvm_nmi_pending),
       .fire            ());

   // --------
   // Software execution of WFI in NMI is only recoverable by the debugger.

   ovl_implication
     #(.severity_level (`OVL_INFO),
       .property_type  (`OVL_ASSERT),
       .msg            ("WFI in NMI is only recoverable via debug or reset"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_info_wfi_in_nmi_handler
     ( .clock           (hclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (ipsr_q[5:0] == 6'd2),
       .consequent_expr (~(run_exe & fmt_sy4 & sy4_isn_wfi)),
       .fire            ());

   // --------
   // IO port load data must be swizzled if the core is big-endian.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Bigendian word IO loads must be swizzled"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_io_bigend_word_ldr
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr ((cfg_iop != 0) & (cfg_be != 0) & io_match_i &
                         cpu_io_trans_o & ~cpu_io_write_o & cpu_io_size_o[1] &
                         run_exe),
       .consequent_expr ( (io_rdata_i[31:24] == wr_data[7:0]) &
                          (io_rdata_i[23:16] == wr_data[15:8]) &
                          (io_rdata_i[15:8] == wr_data[23:16]) &
                          (io_rdata_i[7:0] == wr_data[31:24]) ),
       .fire            ());

   // --------
   // IO port store data should be swizzled if the core is big-endian.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Bigendian word IO stores must be swizzled"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_io_bigend_word_str
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr ((cfg_iop != 0) & (cfg_be != 0) & io_match_i &
                         cpu_io_trans_o & cpu_io_write_o & cpu_io_size_o[1] &
                         run_exe),
       .consequent_expr ( (cpu_io_wdata_o[31:24] == io_wdata_le[7:0]) &
                          (cpu_io_wdata_o[23:16] == io_wdata_le[15:8]) &
                          (cpu_io_wdata_o[15:8] == io_wdata_le[23:16]) &
                          (cpu_io_wdata_o[7:0] == io_wdata_le[31:24]) ),
       .fire            ());

   // --------
   // The core relies on the MPU always marking the address 0xFFFFFFFF as XN.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Fetches from Lockup address must always fault"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_lockup_fetch_must_fault
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (cpu_addr_b_31to5_o[26:23] == 4'hF),
       .consequent_expr (mpu_fault_b_i),
       .fire            ());

   // --------
   // Architecture requires software to treat R13 bits [1:0] as SBZP.

   ovl_implication
     #(.severity_level (`OVL_INFO),
       .property_type  (`OVL_ASSERT),
       .msg            ("Software should treat SP[1:0] as SBZP"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_info_sp_1_to_0_sbzp
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (hready_i & (msp_en | psp_en)),
       .consequent_expr (wr_data[1:0] == 2'b00),
       .fire            ());

   // --------
   // Without an MPU, a number of regions are always execute-never.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("No MPU must ensure default XN"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_default_xn
     ( .clock           (sclk),
       .reset           (hreset_n),
       .enable          (1'b1),
       .antecedent_expr (~cfg_mpu & hready_i & cpu_trans_o & ~cpu_dni_o),
       .consequent_expr ( (cpu_haddr_o[31:28] != 4'hF) &
                          (cpu_haddr_o[31:28] != 4'hE) &
                          (cpu_haddr_o[31:28] != 4'hD) &
                          (cpu_haddr_o[31:28] != 4'hC) &
                          (cpu_haddr_o[31:28] != 4'hB) &
                          (cpu_haddr_o[31:28] != 4'hA) &
                          (cpu_haddr_o[31:28] != 4'h5) &
                          (cpu_haddr_o[31:28] != 4'h4) ),
       .fire            ());

   // --------
   // Instruction fetches can never be marked as writes.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Instruction fetches can not be writes"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_no_instr_write
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (hready_i & cpu_trans_o & ~cpu_dni_o),
      .consequent_expr (~cpu_hwrite_o),
      .fire            ());

   // --------
   // A registered interrupt must enter atomic next unless holding sleep.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Registered interrupt must go atomic unless locked"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_int_must_go_atomic
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (int_ready_q),
      .consequent_expr (going_atomic | atomic_q | sleep_lock_q),
      .fire            ());

   // --------
   // A Lockup must be preceded by a non-sequential update to 0xFFFFFFFF.

   reg        a_last_iaex_to_lockup_q;
   wire       a_last_iaex_to_lockup_nxt = ( ~iaex_seq_o &
                                            (iaex_nxt[30:0] == 31'h7FFFFFFF) );

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n)
       a_last_iaex_to_lockup_q <= 1'b0;
     else if(iaex_en_o)
       a_last_iaex_to_lockup_q <= a_last_iaex_to_lockup_nxt;

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Trace must report Lockup address before Lockup"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_iaex_before_lockup
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (lockup_o),
      .consequent_expr (a_last_iaex_to_lockup_q),
      .fire            ());

   // --------
   // RCLK0 must be enabled when writing to lower registers.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("RCLK0 must be present for R0-R4 update"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_rclk0_ok
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (hready_i & ((wr_addr_en == 4'h0) |
                                    (wr_addr_en == 4'h1) |
                                    (wr_addr_en == 4'h2) |
                                    (wr_addr_en == 4'h3) |
                                    (wr_addr_en == 4'h4) )),
      .consequent_expr (cpu_rclk0_en_o),
      .fire            ());

   // --------
   // RCLK1 must be enabled when writing to lower registers.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("RCLK1 must be present for R5-R12, R14 update"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_rclk1_ok
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (hready_i & ((wr_addr_en == 4'h5) |
                                    (wr_addr_en == 4'h6) |
                                    (wr_addr_en == 4'h7) |
                                    (wr_addr_en == 4'h8) |
                                    (wr_addr_en == 4'h9) |
                                    (wr_addr_en == 4'hA) |
                                    (wr_addr_en == 4'hB) |
                                    (wr_addr_en == 4'hC) |
                                    (wr_addr_en == 4'hE) )),
      .consequent_expr (cpu_rclk1_en_o),
      .fire            ());

   // --------
   // Specification requires int_ready_q be stable when HREADY is low.

   reg        a_int_ready_last_q;
   reg        a_hready_last_q;

   always @(posedge sclk or negedge hreset_n)
     if(~hreset_n) begin
        a_hready_last_q <= 1'b0;
        a_int_ready_last_q <= 1'b0;
     end else begin
       a_hready_last_q <= hready_i;
       a_int_ready_last_q <= int_ready_q;
     end

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("int_ready_q must be stable unless HREADY is HIGH"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_stable_int_ready
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (~a_hready_last_q),
      .consequent_expr (a_int_ready_last_q == int_ready_q),
      .fire            ());

   // --------
   // IQ can never contain a branch in 16-bit fetch only mode.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("IQ can never be a branch in half-word fetch configs"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_no_iq_branch_in_fe_hw
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (cfg_hwf),
      .consequent_expr (~iq_branch_q),
      .fire            ());

   // --------
   // Fetches must only be 16-bit in size in 16-bit mode.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Fetches must be half-word in 16-bit mode"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_hwf1_fe_half
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (cfg_hwf & cpu_trans_o & ~cpu_dni_o),
      .consequent_expr (cpu_hsize_o[1:0] == 2'b01),
      .fire            ());

   // --------
   // Aligned fetches are 32-bit in size in 32-bit mode.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Aligned fetch are word sized outside of 16-bit mode"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_hwf0_fe_word
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (~cfg_hwf & cpu_trans_o & ~cpu_dni_o & ~cpu_haddr_o[1]),
      .consequent_expr (cpu_hsize_o[1:0] == 2'b10),
      .fire            ());

   // --------
   // WIC should never be active during normal execution.

   reg        a_wic_active_q;

   always @(posedge sclk or negedge hreset_n)
     if(~hreset_n)
       a_wic_active_q <= 1'b1;
     else if(wic_load_o)
       a_wic_active_q <= 1'b1;
     else if(wic_clear_o)
       a_wic_active_q <= 1'b0;

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("WIC should not be active during normal execution"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_wic_inactive_during_exe
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (cfg_wic & run_exe & ~wic_load_o),
      .consequent_expr (~a_wic_active_q),
      .fire            ());

   // --------
   // WIC must be active if reporting idle.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("WIC must be active during idle"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_wic_active_during_idle
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (cfg_wic & cpu_ex_idle_o),
      .consequent_expr (a_wic_active_q),
      .fire            ());

   // --------
   // Opcode cannot become "take-IRQ" if IQ is not the jitter counter.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Opcode next must not IRQ unless IQ is jitter count"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_op_not_irq_without_iq
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (iq_s_q & (iq_q[15:14] != 2'b11) & op_en & op_sel_iq),
      .consequent_expr (op_nxt[15:14] != 2'b11),
      .fire            ());

   // --------
   // Opcode being "take-IRQ" requires int_ready_q be set, or the debug logic
   // is requesting that the core halt or become idle (on an opcode that had
   // those bits set).

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Opcode IRQ requires int-req or halt-req or idle-req"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_op_irq_int_halt_idle
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (op_s_q & (op_q[15:14] == 2'b11) & ~run_pfu & ~atomic_q),
      .consequent_expr (int_ready_q | alt_halt | alt_idle),
      .fire            ());

   // --------
   // HDF pushed must be clear during normal execution of something other than
   // NMI.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("HDF cannot be pushed outside of NMI"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_no_hdf_pushed_outside_nmi
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (~cfg_mpu |
                        (run_exe & (ipsr_q != 6'd2))),
      .consequent_expr (~hdf_pushed_q),
      .fire            ());

   // --------
   // If the Opcode contains the jitter counter then it is not being executed
   // or it is being interrupted and the stacked ReturnAddress will be correct.
   //
   // Split into two properties:
   // (1) If the Opcode contains the jitter counter,
   //     then it is not being executed or
   //     it is being interrupted
   // (2) In the above interrupted case, the stacked ReturnAddress is correct

   // (1)

   reg  a_op_jit_q;

   always @(posedge sclk or negedge hreset_n)
     if(~hreset_n)
        a_op_jit_q <= 1'b0;
     else if(op_en & hready_i)
        a_op_jit_q <= op_sel_iq & iq_s_q & (iq_q[15:14] == 2'b11);

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ({"If op_q contains jitter counter, either it is not",
                         " executed or it is interrupted"}),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_op_jit_nexe_or_int
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (a_op_jit_q),
      .consequent_expr ((state_q != st_exe) |
                        state_en & (state_nxt == st_irq)),
      .fire            ());

   // (2)

   reg  a_op_jit_stk_q;

   wire a_op_jit_stk_set = a_op_jit_q &
                           (state_q == st_exe) &
                           state_en & (state_nxt == st_irq);
   wire a_op_jit_stk_clr = a_op_jit_stk_q &
                           (state_q == st_irq) & irq_cyc_2;

   reg  [30:0] a_op_jit_stk_cor_ret_adr_q;
   wire [30:0] a_op_jit_stk_cor_ret_adr_nxt = iaex_q;

   always @(posedge sclk or negedge hreset_n)
     if(~hreset_n)
        a_op_jit_stk_q <= 1'b0;
     else if(a_op_jit_stk_set | a_op_jit_stk_clr)
        a_op_jit_stk_q <= a_op_jit_stk_set;

   always @(posedge sclk)
     if(a_op_jit_stk_set)
        a_op_jit_stk_cor_ret_adr_q <= a_op_jit_stk_cor_ret_adr_nxt;

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ({"ReturnAddress stacked after interrupted jitter op_q",
                         " must be correct"}),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_int_op_jit_ret_adr_ok
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (a_op_jit_stk_clr),
      .consequent_expr (wdata_le[31:1] == a_op_jit_stk_cor_ret_adr_q),
      .fire            ());

   // -------------------------------------------------------------------------

`endif // `ifdef ARM_ASSERT_ON

`ifdef ARM_CM0P_VAL_MONITOR
   // -------------------------------------------------------------------------
   // MONITOR LOGIC FOR DEBUG PURPOSES ONLY
   // -------------------------------------------------------------------------

   // -------------------------------------------------------------------------
   // Current instruction name
   // -------------------------------------------------------------------------

   // Use the UALDIS to provide the assembly code version of the current opcode
   // in execute.

`include "cm0p_ualdis.v"

   reg [ual_str_len:0] mon_inst_name;

   always @(run_exe or op_q or iaex_q or run_t32 or hw1 or hw2 or iaex_q)
     begin
        if(run_exe & (op_q[15:11] != 5'b11110))
          mon_inst_name <= ual_dec_t16(op_q,{iaex_q,1'b0});
        else if(run_exe)
          mon_inst_name <= {{ual_str_len-(5*8)+1{1'b0}},"{T32}"};
        else if(run_t32)
          mon_inst_name <= ual_dec_t32({hw1,hw2},{iaex_q,1'b0});
     end

   // -------------------------------------------------------------------------
   // Current state name
   // -------------------------------------------------------------------------

   // Map current state value to name to aid debugging.

   reg [8*3-1:0] mon_state_name;

   always @*
     case(state_q)
       st_rst  : mon_state_name = "RST";
       st_exe  : mon_state_name = op_s_q ? "ALT" : "EXE";
       st_pfu  : mon_state_name = "PFU";
       st_t32  : mon_state_name = iq_s_q ? "ALT" : "T32";
       st_ldr  : mon_state_name = "LDR";
       st_str  : mon_state_name = "STR";
       st_ldm  : mon_state_name = "LDM";
       st_stm  : mon_state_name = "STM";
       st_rfe  : mon_state_name = "RFE";
       st_irq  : mon_state_name = "IRQ";
       st_lck  : mon_state_name = "LCK";
       st_mul  : mon_state_name = cfg_smul ? "MUL" : "M??";
       st_hlt  : mon_state_name = cfg_dbg ? "HLT" : "H??";
       st_wfx  : mon_state_name = "WFX";
       default : mon_state_name = "???";
     endcase

   // -------------------------------------------------------------------------

`endif

endmodule

// ----------------------------------------------------------------------------
// EOF
// ----------------------------------------------------------------------------
