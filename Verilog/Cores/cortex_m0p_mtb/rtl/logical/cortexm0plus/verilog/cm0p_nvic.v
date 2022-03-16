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
//   Checked In : $Date: 2012-11-21 17:55:57 +0000 (Wed, 21 Nov 2012) $
//   Revision   : $Revision: 229239 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ NESTED VECTORED INTERRUPT CONTROLLER
//-----------------------------------------------------------------------------

module cm0p_nvic
  #(parameter CBAW     = 0,
    parameter BE       = 0,
    parameter DBG      = 1,
    parameter IRQDIS   = 0,
    parameter NUMIRQ   = 32,
    parameter RAR      = 0,
    parameter SYST     = 1,
    parameter VTOR     = 1,
    parameter WIC      = 1,
    parameter WICLINES = 34)

   (input wire         sclk,                // System clock
    input wire         hclk,                // Gated AHB clock
    input wire         pclk,                // Gated PPB write clock
    input wire         hreset_n,            // AHB reset

    output wire        sleeping_o,          // Core sleeping indicator
    output wire        sleep_deep_o,        // Deep sleeping indicator
    output wire        sys_reset_req_o,     // Request for system reset

    output wire        wic_ds_ack_n_o,      // Acknowledge for WIC-deep sleep
    output wire [31:0] wic_mask_isr_o,      // WIC mask for IRQs
    output wire        wic_mask_nmi_o,      // WIC mask for NMI
    output wire        wic_mask_rxev_o,     // WIC mask for RXEV

    output wire [31:0] nvm_hrdata_o,        // PPB read-data bus
    output wire        nvm_int_pend_o,      // Exception pending from NVIC
    output wire [ 5:0] nvm_int_pend_num_o,  // IPSR of pending exception
    output wire        nvm_svc_escalate_o,  // Escalate SVC to HardFault
    output wire        nvm_vect_clr_actv_o, // Clear active state request
    output wire        nvm_sleep_on_exit_o, // SLEEPONEXIT in SCR
    output wire        nvm_wfi_advance_o,   // Core should retire WFI
    output wire        nvm_wfe_advance_o,   // Core should retire WFE
    output wire [23:0] nvm_vtor_31to8_o,    // Vector table offset value
    input  wire        hready_i,            // AHB ready / core advance
    input  wire        st_clk_en_i,         // SysTick reference clock enable
    input  wire [25:0] st_calib_i,          // SysTick calibration value
    input  wire [31:0] irq_i,               // External interrupt inputs
    input  wire        nmi_i,               // Non-maskable interrupt input
    input  wire        rxev_i,              // External event request
    input  wire        wic_ds_req_n_i,      // Request for WIC-deep sleep

    input  wire        txev_i,              // Core generated event
    input  wire        cpu_int_ready_i,     // Core has registered interrupt
    input  wire        cpu_ex_idle_i,       // Core is idle/sleeping
    input  wire        cpu_event_clear_i,   // Core event clear request
    input  wire        cpu_wfi_execute_i,   // Core executing WFI
    input  wire        cpu_wfe_execute_i,   // Core executing WFE
    input  wire        cpu_hdf_pend_i,      // Hardfault pend requested by core
    input  wire        cpu_hdf_request_i,   // Fault detected by core
    input  wire        cpu_int_taken_i,     // Core has entered ISR
    input  wire        cpu_int_return_i,    // Core is returning from ISR
    input  wire        cpu_svc_request_i,   // Core executing SVC
    input  wire [ 5:0] cpu_ipsr_i,          // Core current exception
    input  wire        cpu_nmi_active_i,    // Core is running NMI
    input  wire        cpu_hdf_active_i,    // Core is running HardFault
    input  wire        cpu_n_or_h_active_i, // Core running NMI or HardFault
    input  wire        cpu_primask_i,       // PRIMASK value
    input  wire        cpu_primask_ex_i,    // Forwarded version of PRIMASK
    input  wire        dbg_s_halt_i,        // Core halted in debug state
    input  wire        dbg_c_maskints_i,    // Mask interrupts to core
    input  wire        dbg_halt_req_i,      // Debug halt request
    input  wire        dsl_ppb_active_i,    // PPB debug not core access
    input  wire [31:0] mtx_ppb_wdata_i,     // PPB write-data bus
    input  wire [23:0] msl_nvic_sels_i,     // PPB NVIC register selects
    input  wire        mtx_ppb_write_i);    // PPB write enable

   // -------------------------------------------------------------------------
   // Local register state
   // -------------------------------------------------------------------------

   reg         deep_sleep_q;     // Architectural SLEEPDEEP
   reg         sev_on_pend_q;    // Architectural SEVONPEND
   reg         sleep_on_exit_q;  // Architectural SLEEPONEXIT
   reg         sleeping_raw_q;   // Registered raw sleeping
   reg         sys_reset_req_q;  // Architectural SYSRESETREQ
   reg [31:0]  mask_irq_q;       // IRQ level mode mask
   reg         mask_nmi_q;       // NMI level mode mask
   reg [31:0]  irq_en_q;         // IRQ enables
   reg [31:0]  pend_irq_q;       // IRQ pending bits
   reg         pend_svc_q;       // SVCall pending bit
   reg         pend_psv_q;       // PendSV pending bit
   reg         pend_tck_q;       // SysTick pending bit
   reg         pend_hdf_q;       // HardFault pending bit
   reg         pend_nmi_q;       // NMI pending bit
   reg [1:0]   psv_lvl_q;        // PendSV priority level
   reg [1:0]   svc_lvl_q;        // SVCall priority level
   reg [63:0]  irq_lvl_q;        // IRQ priority levels
   reg [1:0]   tck_lvl_q;        // SysTick priority level
   reg         tck_enable_q;     // SysTick ENABLE control
   reg         tck_tickint_q;    // SysTick TICKIRQ control
   reg         tck_clk_src_q;    // SysTick CLKSOURCE control
   reg         tck_flag_q;       // SysTick COUNTFLAG control
   reg [23:0]  tck_rvr_q;        // SysTick Reload Value
   reg [23:0]  tck_cvr_q;        // SysTick Current Value
   reg         event_q;          // Architectural event register
   reg         wic_ds_ack_q;     // WICDSACK sleep-mode select
   reg [23:0]  vtor_q;           // Architectural vector table offset register

   // -------------------------------------------------------------------------
   // Local constants
   // -------------------------------------------------------------------------

   // Generate constants for each of the system-exception vector numbers, and
   // the base for the IRQ vector numbers.

   localparam [5:0] const_nmi_vec  = 6'h02; // NMI
   localparam [5:0] const_hdf_vec  = 6'h03; // HardFault
   localparam [5:0] const_svc_vec  = 6'h0B; // SVCall
   localparam [5:0] const_psv_vec  = 6'h0E; // PendSV
   localparam [5:0] const_tck_vec  = 6'h0F; // SysTick
   localparam [5:0] const_irq0_vec = 6'h10; // IRQ[0] (IRQ[1] is 6'h11, etc.)

   // -------------------------------------------------------------------------
   // Configurability
   // -------------------------------------------------------------------------

   // The number of interrupts in the interrupt controller is configurable;
   // generate a number of masks to facilitate logic optimization.

   wire        cfg_syst, cfg_be, cfg_dbg, cfg_wic, cfg_rar, cfg_vtor;
   wire [31:0] cfg_numirq;
   wire [33:0] cfg_wiclines;

   generate
      if(CBAW == 0) begin : gen_cbaw

         assign cfg_syst         = (SYST != 0);
         assign cfg_be           = (BE   != 0);
         assign cfg_dbg          = (DBG  != 0);
         assign cfg_vtor         = (VTOR != 0);
         assign cfg_wic          = (WIC  != 0);
         assign cfg_rar          = (RAR  != 0);

         wire [31:0] irq_dis = IRQDIS[31:0];

         wire [31:0] numirq_m = { (NUMIRQ > 31), (NUMIRQ > 30),
                                  (NUMIRQ > 29), (NUMIRQ > 28),
                                  (NUMIRQ > 27), (NUMIRQ > 26),
                                  (NUMIRQ > 25), (NUMIRQ > 24),
                                  (NUMIRQ > 23), (NUMIRQ > 22),
                                  (NUMIRQ > 21), (NUMIRQ > 20),
                                  (NUMIRQ > 19), (NUMIRQ > 18),
                                  (NUMIRQ > 17), (NUMIRQ > 16),
                                  (NUMIRQ > 15), (NUMIRQ > 14),
                                  (NUMIRQ > 13), (NUMIRQ > 12),
                                  (NUMIRQ > 11), (NUMIRQ > 10),
                                  (NUMIRQ >  9), (NUMIRQ >  8),
                                  (NUMIRQ >  7), (NUMIRQ >  6),
                                  (NUMIRQ >  5), (NUMIRQ >  4),
                                  (NUMIRQ >  3), (NUMIRQ >  2),
                                  (NUMIRQ >  1), (NUMIRQ >  0) };

         assign cfg_numirq[31:0] = numirq_m & ~irq_dis;

         wire [33:0] wiclines_m = { (WICLINES > 33), (WICLINES > 32),
                                    (WICLINES > 31), (WICLINES > 30),
                                    (WICLINES > 29), (WICLINES > 28),
                                    (WICLINES > 27), (WICLINES > 26),
                                    (WICLINES > 25), (WICLINES > 24),
                                    (WICLINES > 23), (WICLINES > 22),
                                    (WICLINES > 21), (WICLINES > 20),
                                    (WICLINES > 19), (WICLINES > 18),
                                    (WICLINES > 17), (WICLINES > 16),
                                    (WICLINES > 15), (WICLINES > 14),
                                    (WICLINES > 13), (WICLINES > 12),
                                    (WICLINES > 11), (WICLINES > 10),
                                    (WICLINES >  9), (WICLINES >  8),
                                    (WICLINES >  7), (WICLINES >  6),
                                    (WICLINES >  5), (WICLINES >  4),
                                    (WICLINES >  3), (WICLINES >  2),
                                    (WICLINES >  1), (WICLINES >  0) };

         assign cfg_wiclines = wiclines_m & ~{irq_dis, 2'b0};

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Mask input values based on configuration
   // -------------------------------------------------------------------------

   // Mask unused interrupt input lines. Interrupt lines are not used if they
   // are higher than NUMIRQ, or are individually disabled via IRQDIS.

   wire [31:0] irq;
   genvar      g0;

   generate
      if(CBAW != 0) begin : gen_irq_0a

         assign irq = cfg_numirq[31:0] & irq_i[31:0];

      end else begin : gen_irq_0b
         for(g0 = 0; g0 < 32; g0 = g0 + 1) begin : gen_irq_0c
            if((NUMIRQ > g0) & !IRQDIS[g0]) begin : gen_irq_0d

               assign irq[g0] = irq_i[g0];

            end else begin : gen_irq_0e

               wire unused = irq_i[g0];
               assign irq[g0] = 1'b0;

            end
         end
      end
   endgenerate

   // --------
   // Mask debugger inputs if no debug is present.

   wire        s_halt, ppb_master;

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_0a

         assign s_halt     = cfg_dbg & dbg_s_halt_i;
         assign ppb_master = cfg_dbg & dsl_ppb_active_i;

      end else begin : gen_dbg_0b

         wire [1:0] unused = {dbg_s_halt_i, dsl_ppb_active_i};
         assign {s_halt, ppb_master} = 2'b0;

      end
   endgenerate

   // --------
   // Mask out WIC deep-sleep request input if no WIC support is present.

   wire        wic_ds_req_n;

   generate
      if((CBAW != 0) || (WIC != 0)) begin : gen_wic_0a

         assign wic_ds_req_n = cfg_wic ? wic_ds_req_n_i : 1'b1;

      end else begin : gen_wic_0b

         wire unused = wic_ds_req_n_i;
         assign wic_ds_req_n = 1'b1;

      end
   endgenerate

   // --------
   // Mask SysTick inputs and configuration if SysTick is not implemented.

   wire        tck_no_ref, st_clk_en;
   wire [25:0] st_calib;

   generate
      if((CBAW != 0) || (SYST != 0)) begin : gen_syst_0a

         assign tck_no_ref = cfg_syst & st_calib_i[25];
         assign st_clk_en  = cfg_syst & st_clk_en_i;
         assign st_calib   = cfg_syst ? st_calib_i[25:0] : 26'b0;

      end else begin : gen_syst_0b

         wire [26:0] unused = { st_calib_i[25:0], st_clk_en_i };
         assign { tck_no_ref, st_clk_en, st_calib[25:0] } = 28'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Mask configurable width registers
   // -------------------------------------------------------------------------

   // Mask interrupt priority level registers.

   reg [63:0]  irq_lvl;

   always @*
     begin : p_irq_lvl
       integer i0;
       for (i0=0;i0<32;i0=i0+1) begin
         irq_lvl[(2*i0)+0] = cfg_numirq[i0] ? irq_lvl_q[(2*i0)+0] : 1'b0;
         irq_lvl[(2*i0)+1] = cfg_numirq[i0] ? irq_lvl_q[(2*i0)+1] : 1'b0;
       end
     end

   // Mask interrupt registers to number of implemented IRQs required to ensure
   // CBAW and generated version behavor are consistent.

   wire [31:0] mask_irq   = cfg_numirq & mask_irq_q;
   wire [31:0] pend_irq   = cfg_numirq & pend_irq_q;
   wire [31:0] irq_en     = cfg_numirq & irq_en_q;

   // Mask optional SysTick registers.

   wire [23:0] tck_rvr    = cfg_syst ? tck_rvr_q : 24'b0;
   wire [23:0] tck_cvr    = cfg_syst ? tck_cvr_q : 24'b0;

   // Mask optional WIC interface register.

   wire        wic_ds_ack = cfg_wic & wic_ds_ack_q;

   // -------------------------------------------------------------------------
   // PPB register decode logic
   // -------------------------------------------------------------------------

   wire        ppb_syst_csr_rd = msl_nvic_sels_i[22] & ~mtx_ppb_write_i;

   wire        ppb_syst_csr_wr = msl_nvic_sels_i[22] & mtx_ppb_write_i;
   wire        ppb_syst_rvr_wr = msl_nvic_sels_i[21] & mtx_ppb_write_i;
   wire        ppb_syst_cvr_wr = msl_nvic_sels_i[20] & mtx_ppb_write_i;
   wire        ppb_iser_wr     = msl_nvic_sels_i[18] & mtx_ppb_write_i;
   wire        ppb_icer_wr     = msl_nvic_sels_i[17] & mtx_ppb_write_i;
   wire        ppb_ispr_wr     = msl_nvic_sels_i[16] & mtx_ppb_write_i;
   wire        ppb_icpr_wr     = msl_nvic_sels_i[15] & mtx_ppb_write_i;

   wire [ 7:0] ppb_ipr_wr      = { msl_nvic_sels_i[ 7] & mtx_ppb_write_i,
                                   msl_nvic_sels_i[ 8] & mtx_ppb_write_i,
                                   msl_nvic_sels_i[ 9] & mtx_ppb_write_i,
                                   msl_nvic_sels_i[10] & mtx_ppb_write_i,
                                   msl_nvic_sels_i[11] & mtx_ppb_write_i,
                                   msl_nvic_sels_i[12] & mtx_ppb_write_i,
                                   msl_nvic_sels_i[13] & mtx_ppb_write_i,
                                   msl_nvic_sels_i[14] & mtx_ppb_write_i };

   wire        ppb_icsr_wr     = msl_nvic_sels_i[ 6] & mtx_ppb_write_i;
   wire        ppb_aircr_wr    = msl_nvic_sels_i[ 5] & mtx_ppb_write_i;
   wire        ppb_scr_wr      = msl_nvic_sels_i[ 4] & mtx_ppb_write_i;
   wire        ppb_shpr2_wr    = msl_nvic_sels_i[ 2] & mtx_ppb_write_i;
   wire        ppb_shpr3_wr    = msl_nvic_sels_i[ 1] & mtx_ppb_write_i;
   wire        ppb_shcsr_wr    = msl_nvic_sels_i[ 0] & mtx_ppb_write_i;

   // Abbreviate write-data signal name.

   wire [31:0] ppb_wdata       = mtx_ppb_wdata_i;

   // -------------------------------------------------------------------------
   // System reset request and vect-clear-active
   // -------------------------------------------------------------------------

   // SYSRESETREQ is driven by a register that is reset back to zero, it is set
   // by a write to the AIRCR; VECTCLRACTIVE clears all active and pending
   // state in the core and NVIC, and is only settable by the debugger whilst
   // the core is halted.

   // Both fields are protected by a key in the upper half-word of the write
   // data.

   wire       aircr_key_ok     = ppb_wdata[31:16] == 16'h05FA;
   wire       legal_aircr_wr   = ppb_aircr_wr & aircr_key_ok;

   wire       sys_reset_req_en = legal_aircr_wr & ppb_wdata[2];

   wire       vect_clr_raw     = legal_aircr_wr & ppb_wdata[1];
   wire       vect_clr_actv    = vect_clr_raw & s_halt & ppb_master;

   // -------------------------------------------------------------------------
   // Find active interrupt / handler
   // -------------------------------------------------------------------------

   // Determine which ISR is active (if any), the core has already decoded NMI
   // and HardFault, so simply import these.

   wire        nmi_actv   = cpu_nmi_active_i;
   wire        hdf_actv   = cpu_hdf_active_i;
   wire        svc_actv   = (cpu_ipsr_i[5:0] == const_svc_vec);
   wire        psv_actv   = (cpu_ipsr_i[5:0] == const_psv_vec);

   wire        tck_actv;

   generate
      if((CBAW != 0) || (SYST != 0)) begin : gen_syst_1a

         wire    tck_in_ipsr = (cpu_ipsr_i[5:0] == const_tck_vec);
         assign  tck_actv = cfg_syst & tck_in_ipsr;

      end else begin : gen_syst_1b

         assign tck_actv = 1'b0;

      end
   endgenerate

   // --------
   // Determine if any of the configurable priority interrupts is currently
   // active.

   wire [31:0] irq_actv_bit_r =
               { cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h1F),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h1E),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h1D),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h1C),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h1B),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h1A),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h19),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h18),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h17),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h16),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h15),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h14),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h13),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h12),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h11),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h10),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h0F),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h0E),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h0D),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h0C),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h0B),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h0A),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h09),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h08),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h07),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h06),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h05),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h04),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h03),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h02),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h01),
                 cpu_ipsr_i[5:0] == (const_irq0_vec + 6'h00) };

   wire [31:0] irq_actv_bit = cfg_numirq & irq_actv_bit_r;

   // -------------------------------------------------------------------------
   // Determine priority of active IRQ
   // -------------------------------------------------------------------------

   // Apply the IRQ active mask to each of the IRQ priority bits, then
   // reductive-OR these to produce the MSB and LSB of the current active IRQ
   // priority.

   reg [31:0]  irq_lvl_hi;
   reg [31:0]  irq_lvl_lo;

   always @*
     begin : p_irq_lvl_hi_lo
       integer i1;
       for (i1=0;i1<32;i1=i1+1) begin
         irq_lvl_hi[i1] = irq_actv_bit[i1] & irq_lvl[(2*i1)+1];
         irq_lvl_lo[i1] = irq_actv_bit[i1] & irq_lvl[(2*i1)+0];
       end
     end

   wire [ 1:0] irq_actv_lvl = { |irq_lvl_hi, |irq_lvl_lo };

   // -------------------------------------------------------------------------
   // Resolve whether anything actually is active and its priority
   // -------------------------------------------------------------------------

   // Determine whether any prioritizable exception or interrupt is active.

   wire        irq_actv = |irq_actv_bit;
   wire        int_actv = irq_actv | tck_actv | psv_actv | svc_actv;

   // Extract the priority of the currently active exception; irq_actv_lvl
   // doesn't need masking with irq_actv as the 32:1 muxing will result in zero
   // if no IRQ is active.

   wire [1:0]  int_actv_lvl = ( irq_actv_lvl |
                                {2{tck_actv}} & tck_lvl_q |
                                {2{psv_actv}} & psv_lvl_q |
                                {2{svc_actv}} & svc_lvl_q );

   // Generate one-hot active exception list for use in nvm_reg.

   wire [36:0] actv_bit = { irq_actv_bit[31:0],
                            tck_actv,
                            psv_actv,
                            svc_actv,
                            hdf_actv,
                            nmi_actv };

   // -------------------------------------------------------------------------
   // IRQ and NMI pend logic
   // -------------------------------------------------------------------------

   // Software may manually set or clear the pending bits for configurable
   // priority IRQs, but may only set the pending bit for NMI.

   wire [31:0] irq_pend_set = ppb_wdata[31:0] & {32{ppb_ispr_wr}};
   wire [31:0] irq_pend_clr = ppb_wdata[31:0] & {32{ppb_icpr_wr}};

   wire        nmi_pend_set = ppb_icsr_wr & ppb_wdata[31];

   // The NVIC automatically clears the pend bit of the relevant exception on
   // entry to its handler, signaled by the core int_taken signal.

   wire [36:0] entry_pend_clr = actv_bit & {37{cpu_int_taken_i}};

   // Interrupt pend bits are set either as a result of the external pin being
   // high when mask isn't set, or via software pend when not being cleared;
   // ARMv6-M also requires the NMI pend bit to be cleared by VECTCLRACTIVE;
   // entering the exception always clears the internal pend bit.

   wire [31:0] external_irq = irq & ~(mask_irq | entry_pend_clr[36:5]);

   wire [31:0] internal_irq = ( irq_pend_set |
                                pend_irq & ~irq_pend_clr );

   wire [31:0] pend_irq_nxt = ( external_irq |
                                internal_irq & ~entry_pend_clr[36:5]);

   // NMI functions similarly to the interrupts, however ARMv6-M also requires
   // the NMI pend bit to be cleared by VECTCLRACTIVE.

   wire        external_nmi = nmi_i & ~(mask_nmi_q | entry_pend_clr[0]);

   wire        internal_nmi = ( nmi_pend_set |
                                pend_nmi_q & ~vect_clr_actv );

   wire        pend_nmi_nxt = ( external_nmi |
                                internal_nmi & ~entry_pend_clr[0] );

   // -------------------------------------------------------------------------
   // Generate level-sensitive masking
   // -------------------------------------------------------------------------

   // Mask bits are used to track when the NVIC should treat interrupt pins as
   // pulse-sensitive only; this is required when an exception handler has been
   // taken but the interrupt pin has not returned to zero yet, or before a
   // return from the same exception has occurred.

   // Mask bits need clearing on return from an exception.

   wire [31:0] exit_irq_mask_clr = actv_bit[36:5] & {32{cpu_int_return_i}};
   wire        exit_nmi_mask_clr = actv_bit[0] & cpu_int_return_i;

   // Mask is used to store the sensitivity operating mode:
   //
   //    0 = Level sensitive mode.
   //    1 = Edge sensitive mode.
   //
   // The mask is set on entry to a specific interrupt handler, the mask is
   // cleared if:
   //
   //    - The interrupt line goes low.
   //    - The interrupt handler is returned from.
   //    - VECTCLRACTIVE is operated.
   //    - Software performs a manual pend of the interrupt.

   wire [31:0] mask_irq_nxt = ( irq &
                                ~exit_irq_mask_clr &
                                {32{~vect_clr_actv}} &
                                ~irq_pend_set &
                                (entry_pend_clr[36:5] | mask_irq));

   wire        mask_nmi_nxt = ( nmi_i &
                                ~exit_nmi_mask_clr &
                                ~vect_clr_actv &
                                ~nmi_pend_set &
                                (entry_pend_clr[0] | mask_nmi_q));

   // To enable the inference of a common clock-gate cell for the mask
   // registers, the registers are enabled only when an interrupt is taken,
   // or whilst any mask bit is set.

   wire        mask_en = |{mask_irq, mask_nmi_q, cpu_int_taken_i};

   // -------------------------------------------------------------------------
   // SysTick timer logic
   // -------------------------------------------------------------------------

   // the ARMv6-M optional SysTick timer implements a 24-bit towards-zero
   // counter implemented from a 24-bit current count value, tck_cvr[23:0]
   // which gets repopulated when zero using the 24-bit reload value
   // tck_rvr[23:0]; on transitioning from 1-to-0 an event is triggered which,
   // based upon configuration, may cause the SysTick interrupt handler to be
   // pended.

   // The various parts of the SYST_CSR configuration register can only be
   // updated via a PPB write; the actual value of CLKSOURCE is overridden if
   // the SYST_CALIB register indicates that no external reference is provided.

   wire        tck_control_en  = ppb_syst_csr_wr;

   wire        tck_enable_nxt  = cfg_syst ? ppb_wdata[0] : 1'b0;
   wire        tck_tickint_nxt = cfg_syst ? ppb_wdata[1] : 1'b0;
   wire        tck_clk_src_nxt = cfg_syst ? ppb_wdata[2] : 1'b0;

   wire        tck_use_sclk    = tck_no_ref | tck_clk_src_q;

   // The tck_rvr reload value can only be modified by a PPB write access.

   wire        tck_rvr_en  = ppb_syst_rvr_wr;
   wire [23:0] tck_rvr_nxt = cfg_syst ? ppb_wdata[23:0] : 24'b0;

   // The tck_cvr current value decrements either on each SCLK edge, or an edge
   // where st_clk_en is provided if configured for an external reference
   // clock; tck_cvr is cleared only by a PPB write to itself, and is frozen
   // whilst the core is in debug halt.

   wire        tck_clk_en    = tck_use_sclk | st_clk_en;

   wire        tck_cvr_clr   = ppb_syst_cvr_wr;
   wire        tck_cvr_adv   = tck_enable_q & tck_clk_en & ~s_halt;
   wire        tck_cvr_en    = tck_cvr_clr | tck_cvr_adv;

   wire        tck_cvr_top_z = ~|tck_cvr[23:1];
   wire        tck_cvr_zero  = tck_cvr_top_z & ~tck_cvr[0];

   wire        tck_sel_dec   = ~tck_cvr_zero & ~tck_cvr_clr;
   wire        tck_sel_rvr   =  tck_cvr_zero & ~tck_cvr_clr;

   wire [23:0] tck_cvr_dec   = tck_cvr[23:0] - 1'b1;

   wire [23:0] tck_cvr_nxt   = ( {24{tck_sel_dec}} & tck_cvr_dec |
                                 {24{tck_sel_rvr}} & tck_rvr     );

   // ARMv6-M specifies that the event point is a transition from 1-to-0, so
   // detect this event - note that this logic treats a write in parallel with
   // a transition to zero as an event.

   wire        tck_to_zero = tck_cvr_adv & tck_cvr_top_z & tck_cvr[0];

   // When enabled, the count from 1-to-0 sets both the COUNTFLAG and
   // optionally triggers a pend of the SysTick interrupt; the COUNTFLAG is
   // cleared either by reading the flag, or by a write to the current value
   // register (SYST_CVR); set takes precedence over clear so that a read in
   // parallel with the SysTick underflow doesn't cause the COUNTFLAG to be
   // lost.

   // Debug is prevented from performing read-clear, and can only perform a
   // write-clear in order to prevent memory window reads dead-locking a
   // COUNTFLAG poll loop.

   wire        tck_flag_set = tck_to_zero;
   wire        tck_flag_clr = ( ppb_syst_csr_rd & ~ppb_master |
                                ppb_syst_cvr_wr );

   wire        tck_flag_en  = tck_flag_set | tck_flag_clr;
   wire        tck_flag_nxt = tck_flag_set;

   // the SysTick interrupt is only pended if enabled

   wire        tck_irq      = tck_tickint_q & tck_to_zero;

   // -------------------------------------------------------------------------
   // IRQ enable register logic
   // -------------------------------------------------------------------------

   // Individual IRQs may be enabled or disabled by writing to the PPB ISER and
   // ICER respectively, a "1" on the write data indicates that the IRQ enable
   // should be set/cleared, thus 32 distinct enable terms are generated.

   wire        irq_en_set = ppb_iser_wr;
   wire        irq_en_clr = ppb_icer_wr;

   wire        irq_en_any = irq_en_set | irq_en_clr;
   wire [31:0] irq_en_en  = {32{irq_en_any}} & ppb_wdata[31:0];
   wire        irq_en_nxt = irq_en_set;

   // -------------------------------------------------------------------------
   // Priority level register logic
   // -------------------------------------------------------------------------

   // The interrupt priority of the SVCall, SysTick, PendSV and IRQ handlers
   // are only updated as a result of a PPB write to either the SHPR2, SHPR3 or
   // IPR[7:0] registers.

   wire        svc_lvl_en  = ppb_shpr2_wr;
   wire        tck_lvl_en  = ppb_shpr3_wr;
   wire        psv_lvl_en  = ppb_shpr3_wr;
   wire [ 7:0] irq_lvl_en  = ppb_ipr_wr;

   wire [ 1:0] svc_lvl_nxt = ppb_wdata[31:30];
   wire [ 1:0] tck_lvl_nxt = ppb_wdata[31:30];
   wire [ 1:0] psv_lvl_nxt = ppb_wdata[23:22];

   wire [ 7:0] irq_lvl_nxt = { ppb_wdata[31:30],
                               ppb_wdata[23:22],
                               ppb_wdata[15:14],
                               ppb_wdata[ 7: 6] };

   // -------------------------------------------------------------------------
   // System handler pend logic
   // -------------------------------------------------------------------------

   // HardFault can only be pending via a request from the core, and cleared by
   // either entry to the HardFault handler or use of VECTCLRACTIVE.

   wire        pend_hdf_set = cpu_hdf_request_i | cpu_hdf_pend_i;
   wire        pend_hdf_clr = vect_clr_actv | entry_pend_clr[1];

   wire        pend_hdf_en  = pend_hdf_set | pend_hdf_clr;
   wire        pend_hdf_nxt = pend_hdf_set;

   // SVCall can be pended either by a request from an SVC instruction in the
   // core, or via a debugger set, and cleared by entry to SVCall, or via a
   // debugger clear; ppb_shcsr_wr is masked by matrix_sel to only be valid for
   // debug accesses.

   wire        dbg_svc_pend_set = ppb_shcsr_wr &  ppb_wdata[15];
   wire        dbg_svc_pend_clr = ppb_shcsr_wr & ~ppb_wdata[15];

   wire        pend_svc_set = cpu_svc_request_i | dbg_svc_pend_set;
   wire        pend_svc_clr = dbg_svc_pend_clr | entry_pend_clr[2];

   wire        pend_svc_en  = pend_svc_set | pend_svc_clr;
   wire        pend_svc_nxt = pend_svc_set;

   // PendSV has a memory mapped set and clear, and is automatically cleared on
   // entry to PendSV.

   wire        pend_psv_set = ppb_icsr_wr & ppb_wdata[28];
   wire        pend_psv_clr = ppb_icsr_wr & ppb_wdata[27] | entry_pend_clr[3];

   wire        pend_psv_en  = pend_psv_set | pend_psv_clr;
   wire        pend_psv_nxt = pend_psv_set;

   // SysTick can be pended manually, or as the result of a timer derived
   // interrupt, and can be either manually cleared or is cleared automatically
   // on entry to SysTick.

   wire        pend_tck_set = ppb_icsr_wr & ppb_wdata[26] | tck_irq;
   wire        pend_tck_clr = ppb_icsr_wr & ppb_wdata[25] | entry_pend_clr[4];

   wire        pend_tck_en  = pend_tck_set | pend_tck_clr;
   wire        pend_tck_nxt = pend_tck_set;

   // -------------------------------------------------------------------------
   // System control register
   // -------------------------------------------------------------------------

   // The SCR is only updated by a PPB write, and contains the SEVONPEND,
   // DEEPSLEEP and SLEEPONEXIT bits

   wire        scr_en            = ppb_scr_wr;

   wire        sev_on_pend_nxt   = ppb_wdata[4];
   wire        deep_sleep_nxt    = ppb_wdata[2];
   wire        sleep_on_exit_nxt = ppb_wdata[1];

   // -------------------------------------------------------------------------
   // Event register logic
   // -------------------------------------------------------------------------

   // ARMv6-M defines an event register for use with the WFE (wait-for-event)
   // instruction; this register gets set either via the RXEV input pin, the
   // core executing an SEV instruction, entering or returning from an
   // interrupt, if SEVONPEND is set as a result of a new interrupt becoming
   // pended, or as a result of entering debug.

   // Detect whether a new interrupt has just become pended by comparing the
   // next/set signals with the current pend registers, and qualify with
   // SEVONPEND.

   wire        irq_new_pend = |(cfg_numirq & pend_irq_nxt & ~pend_irq);

   wire        pend_change  = ( pend_nmi_nxt & ~pend_nmi_q |
                                pend_psv_set & ~pend_psv_q |
                                pend_tck_set & ~pend_tck_q |
                                irq_new_pend );

   wire        sev_new_pend = sev_on_pend_q & pend_change;

   // Merge SEVONPEND with all the other possible event setting inputs; the
   // event register is cleared by the core having a WFE instruction in execute
   // whilst *not* asleep.

   wire        event_new = ( rxev_i           |  // RXEV input pin
                             txev_i           |  // SEV executed by core
                             sev_new_pend     |  // SEVONPEND and new pend
                             cpu_int_taken_i  |  // interrupt entry
                             cpu_int_return_i |  // interrupt return
                             s_halt );           // debug entry/exit

   wire        event_en  = event_new | cpu_event_clear_i;
   wire        event_nxt = event_new;

   // -------------------------------------------------------------------------
   // Generate escalation signals for core
   // -------------------------------------------------------------------------

   // The architecture requires any fault at or above HardFault priority to
   // Lockup, and any SVC instruction at or above SVCall priority (including
   // PRIMASK) to be treated as UNDEFINED; generate hdf_escalate and
   // svc_escalate signals for core.

   wire        svc_ge_actv  = svc_lvl_q >= int_actv_lvl;

   wire        svc_escalate = svc_ge_actv & int_actv;

   // -------------------------------------------------------------------------
   // Define NVIC pend tree selection function
   // -------------------------------------------------------------------------

   // The function takes two 9-bit vectors, each defining an interrupt vector
   // number, its priority and whether it is enabled and pending; the function
   // returns which ever of the two vectors is the highest priority enabled
   // one, favoring "first" over "second"; the function must always be called
   // with "first" having a lower vector number than "second" as "first" is the
   // favored choice and the architecture requires the lowest vector to win
   // when all other things are equal.

   function [8:0] winner (input [8:0] first, input [8:0] second);

      reg [1:0] i_lvl_1st;
      reg       i_enp_1st;
      reg [1:0] i_lvl_2nd;
      reg       i_enp_2nd;
      reg       i_2nd_lt_1st;
      reg       i_sel_2nd;

      begin
        i_lvl_1st = first[7:6];  // Unpack first priority level.
        i_enp_1st = first[8];    // Unpack first enabled+pending.
        i_lvl_2nd = second[7:6]; // Unpack second priority level.
        i_enp_2nd = second[8];   // Unpack second enabled+pending.

        // Second should win if it is higher priority (lower value) than first
        // and it is enabled; alternatively if first is not enabled then
        // automatically choose second.

        i_2nd_lt_1st = i_lvl_2nd < i_lvl_1st;
        i_sel_2nd    = i_enp_2nd & i_2nd_lt_1st | ~i_enp_1st;
        winner       = i_sel_2nd ? second : first;
      end
   endfunction

   // -------------------------------------------------------------------------
   // Generate vectors ready for pend tree
   // -------------------------------------------------------------------------

   // Create the pending+enable terms for all IRQs and system interrupts; for
   // system interrupts, which are applied late in the tree, also factor in
   // debugs C_MASKINTS which prevents prioritizable interrupts being taken;
   // for IRQs, C_MASKINTS is applied at the later on to minimize timing and
   // area impact; SVCall must not be masked otherwise deadlock will occur
   // should the core execute an SVC instruction.

   wire [31:0] en_pend_irq = pend_irq & irq_en;

   wire [ 2:0] en_pend_sys = { pend_tck_q & ~dbg_c_maskints_i,
                               pend_psv_q & ~dbg_c_maskints_i,
                               pend_svc_q | cpu_svc_request_i };

   // Generate all of the pend tree input vectors for IRQs.

   genvar       g1;
   wire  [ 8:0] ptree_in [31:0];

   generate
      for(g1 = 0; g1 < 32; g1 = g1 + 1) begin : gen_ptree_in

         wire [5:0] ptree_num = const_irq0_vec+g1[5:0];

         assign ptree_in[g1]  = { en_pend_irq[g1],
                                  irq_lvl[((2*g1)+1)-:2],
                                  ptree_num };
      end
   endgenerate

   // -------------------------------------------------------------------------
   // Construct IRQ pending tree
   // -------------------------------------------------------------------------

   // First level of IRQ pend tree compressing 32-to-16.

   wire [ 8:0] ptree_0_0 = winner(ptree_in[ 0], ptree_in[ 1]);
   wire [ 8:0] ptree_0_1 = winner(ptree_in[ 2], ptree_in[ 3]);
   wire [ 8:0] ptree_0_2 = winner(ptree_in[ 4], ptree_in[ 5]);
   wire [ 8:0] ptree_0_3 = winner(ptree_in[ 6], ptree_in[ 7]);
   wire [ 8:0] ptree_0_4 = winner(ptree_in[ 8], ptree_in[ 9]);
   wire [ 8:0] ptree_0_5 = winner(ptree_in[10], ptree_in[11]);
   wire [ 8:0] ptree_0_6 = winner(ptree_in[12], ptree_in[13]);
   wire [ 8:0] ptree_0_7 = winner(ptree_in[14], ptree_in[15]);
   wire [ 8:0] ptree_0_8 = winner(ptree_in[16], ptree_in[17]);
   wire [ 8:0] ptree_0_9 = winner(ptree_in[18], ptree_in[19]);
   wire [ 8:0] ptree_0_a = winner(ptree_in[20], ptree_in[21]);
   wire [ 8:0] ptree_0_b = winner(ptree_in[22], ptree_in[23]);
   wire [ 8:0] ptree_0_c = winner(ptree_in[24], ptree_in[25]);
   wire [ 8:0] ptree_0_d = winner(ptree_in[26], ptree_in[27]);
   wire [ 8:0] ptree_0_e = winner(ptree_in[28], ptree_in[29]);
   wire [ 8:0] ptree_0_f = winner(ptree_in[30], ptree_in[31]);

   // Second level of IRQ pend tree compressing 16-to-8.

   wire [ 8:0] ptree_1_0 = winner(ptree_0_0, ptree_0_1);
   wire [ 8:0] ptree_1_1 = winner(ptree_0_2, ptree_0_3);
   wire [ 8:0] ptree_1_2 = winner(ptree_0_4, ptree_0_5);
   wire [ 8:0] ptree_1_3 = winner(ptree_0_6, ptree_0_7);
   wire [ 8:0] ptree_1_4 = winner(ptree_0_8, ptree_0_9);
   wire [ 8:0] ptree_1_5 = winner(ptree_0_a, ptree_0_b);
   wire [ 8:0] ptree_1_6 = winner(ptree_0_c, ptree_0_d);
   wire [ 8:0] ptree_1_7 = winner(ptree_0_e, ptree_0_f);

   // Third level of IRQ pend tree compressing 8-to-4.

   wire [ 8:0] ptree_2_0 = winner(ptree_1_0, ptree_1_1);
   wire [ 8:0] ptree_2_1 = winner(ptree_1_2, ptree_1_3);
   wire [ 8:0] ptree_2_2 = winner(ptree_1_4, ptree_1_5);
   wire [ 8:0] ptree_2_3 = winner(ptree_1_6, ptree_1_7);

   // Fourth level of IRQ pend tree compressing 4-to-2.

   wire [ 8:0] ptree_3_0 = winner(ptree_2_0, ptree_2_1);
   wire [ 8:0] ptree_3_1 = winner(ptree_2_2, ptree_2_3);

   // Fifth level of IRQ pend tree compressing 2-to-1 yielding the winner of
   // the IRQ pending tournament.

   wire [ 8:0] ptree_4_0 = winner(ptree_3_0, ptree_3_1);

   // -------------------------------------------------------------------------
   // Generate vectors for system handlers and final IRQ vector
   // -------------------------------------------------------------------------

   // Construct SVCall, PendSV and SysTick vectors.

   wire [ 8:0] ptree_svc = {en_pend_sys[0], svc_lvl_q, const_svc_vec};
   wire [ 8:0] ptree_psv = {en_pend_sys[1], psv_lvl_q, const_psv_vec};
   wire [ 8:0] ptree_tck = {en_pend_sys[2], tck_lvl_q, const_tck_vec};

   // Produce final IRQ vector and apply C_MASKINTS.

   wire [ 8:0] ptree_irq = { ptree_4_0[8] & ~dbg_c_maskints_i,
                             ptree_4_0[7:0]};

   // -------------------------------------------------------------------------
   // Extend pending tournament to include system handler
   // -------------------------------------------------------------------------

   // First level of SYS+IRQ pending tree compressing 4-to-2.

   wire [ 8:0] ptree_5_0 = winner(ptree_svc, ptree_psv);
   wire [ 8:0] ptree_5_1 = winner(ptree_tck, ptree_irq);

   // Second level of SYS+IRQ pending tree compressing 2-to-1 producing result
   // of all configurable exceptions, leaving just NMI and HardFault to factor
   // in.

   wire [8:0]  ptree_6_0 = winner(ptree_5_0, ptree_5_1);

   // -------------------------------------------------------------------------
   // Derive control values from pend tree result
   // -------------------------------------------------------------------------

   // Bit[8] of the output vector indicates that the tree has at least one
   // interrupt/exception that is both pending and enabled, bits[7:6] contain
   // the priority level of the interrupt/exception whilst bits[5:0] contain
   // the number/vector of the interrupt; for use in the architect-ed VECTPEND
   // fields, this value needs forcing to zero if no interrupt is pending.

   wire        pend_tree     = ptree_6_0[8];
   wire [ 1:0] pend_tree_lvl = ptree_6_0[7:6];
   wire [ 5:0] pend_tree_num = ptree_6_0[5:0] & {6{pend_tree}};

   // -------------------------------------------------------------------------
   // Derive final prioritization results
   // -------------------------------------------------------------------------

   // Determine whether an NMI or HardFault should attempt to preempt current
   // execution; NMI always preempts if it isn't already active; HardFault
   // always preempts if neither it or NMI is active.

   wire        hdf_pending = pend_hdf_q & ~cpu_n_or_h_active_i;
   wire        hdf_preempt = hdf_pending | cpu_hdf_request_i;
   wire        nmi_preempt = pend_nmi_q & ~nmi_actv;

   // Determine whether an IRQ or system exception is pending which is higher
   // priority than the current active level ignoring PRIMASK; this is
   // required as if an exception is only masked by PRIMASK it still causes a
   // WFI instruction to retire.

   wire        int_lvl_ok  = (pend_tree_lvl < int_actv_lvl) | ~int_actv;
   wire        int_pending = int_lvl_ok & pend_tree & ~cpu_n_or_h_active_i;

   // Generate WFI advance and interrupt preempt signals for core.

   wire        wfi_advance = int_pending | nmi_preempt | hdf_pending;

   wire        primask_set = cpu_primask_ex_i;
   wire        int_pend    = ( int_pending & ~primask_set |
                               nmi_preempt |
                               hdf_preempt );

   // Derive vector number from highest pending.

   wire        int_pend_hdf = pend_hdf_q | cpu_hdf_request_i;

   wire [ 5:0] int_pend_low = int_pend_hdf   ? const_hdf_vec : pend_tree_num;
   wire [ 5:0] int_pend_num =     pend_nmi_q ? const_nmi_vec : int_pend_low;


   // -------------------------------------------------------------------------
   // SLEEPING and SLEEPDEEP generation
   // -------------------------------------------------------------------------

   // If core has registered an interrupt then override sleeping; this can only
   // occur through unpredictable use of the debugger in conjunction with
   // SLEEPHOLDREQn usage.

   wire        sleeping = sleeping_raw_q & ~cpu_int_ready_i;

   // Determine whether the core will wake up or not; wake conditions are:
   //
   //   - Event register set whilst core executing WFE.
   //   - PRIMASK'ed interrupt whilst core executing WFI.
   //   - Non-masked pending interrupt that should preempt.
   //   - Debug halt request.

   wire        wake_up = ( cpu_wfe_execute_i & event_q |
                           cpu_wfi_execute_i & wfi_advance |
                           int_pend |
                           dbg_halt_req_i );

   // Determine whether the core will remain sleeping in the next cycle; core
   // can only advance on HREADY, so factor this into sleeping enable term.

   wire        sleeping_nxt = cpu_ex_idle_i & ~wake_up;

   // SLEEPDEEP output is simply the logical-AND of SLEEPING and the DEEPSLEEP
   // register.

   wire        sleep_deep   = sleeping & deep_sleep_q;

   // -------------------------------------------------------------------------
   // Wake-up Interrupt Controller interface
   // -------------------------------------------------------------------------

   // WICDSACKn handshakes with WICDSREQn to indicate that the NVIC is ready to
   // operate in WIC based deep-sleep mode; WIC sleep mode can only be changed
   // whilst the core is not already sleeping.

   wire        wic_ds_ack_set = ( ~wic_ds_req_n &
                                  ~wic_ds_ack &
                                  ~sleeping &
                                  ~sleeping_nxt );

   wire        wic_ds_ack_clr = ( wic_ds_req_n &
                                  wic_ds_ack &
                                  ~sleeping );

   wire        wic_ds_ack_en  = wic_ds_ack_set | wic_ds_ack_clr;
   wire        wic_ds_ack_nxt = wic_ds_ack_set;

   // -------------------------------------------------------------------------
   // Expand register fields to architectural layouts
   // -------------------------------------------------------------------------

   // Vector table offset register

   wire [31:0] vtor_val = { vtor_q[23:0],
                            8'b0 };

   // SysTick control and status register.

   wire [31:0] syst_csr_val = { {15{1'b0}},
                                tck_flag_q,
                                {13{1'b0}},
                                tck_use_sclk,
                                tck_tickint_q,
                                tck_enable_q };

   // SysTick reload register.

   wire [31:0] syst_rvr_val = {8'h00, tck_rvr[23:0]};

   // SysTick current value register.

   wire [31:0] syst_cvr_val = {8'h00, tck_cvr[23:0]};

   // SysTick calibration register.

   wire [31:0] syst_cal_val = { st_calib[25],     //    31 NOREF
                                st_calib[24],     //    30 SKEW
                                {6{1'b0}},        // 29:24 Reserved
                                st_calib[23:0] }; // 23: 0 TENMS

   // Application interrupt and reset control register.

   wire [31:0] aircr_val    = { 16'hfa05,
                                cfg_be,
                                {15{1'b0}} };

   // System control register.

   wire [31:0] scr_val      = { {27{1'b0}},
                                sev_on_pend_q,
                                1'b0,
                                deep_sleep_q,
                                sleep_on_exit_q,
                                1'b0 };

   // Configuration control register.

   wire [31:0] ccr_val      = { {22{1'b0}},
                                1'b1,
                                {5{1'b0}},
                                1'b1,
                                {3{1'b0}} };

   // System handler priority register 2.

   wire [31:0] shpr2_val    = { svc_lvl_q,
                                {30{1'b0}} };

   // System handler priority register 3.

   wire [31:0] shpr3_val    = { tck_lvl_q,
                                {6{1'b0}},
                                psv_lvl_q,
                                {22{1'b0}} };

   // System handler control and status register; the PPB select for SHCSR is
   // already masked for debug access only.

   wire [31:0] shcsr_val    = { {16{1'b0}},
                                pend_svc_q,
                                {15{1'b0}} };

   // Interrupt control and status register.

   wire [31:0] icsr_val     = { pend_nmi_q,
                                {2{1'b0}},
                                pend_psv_q,
                                1'b0,
                                pend_tck_q,
                                {2{1'b0}},
                                cfg_dbg ? int_pend : 1'b0,
                                cfg_dbg ? (|pend_irq) : 1'b0,
                                {4{1'b0}},
                                int_pend_num,
                                {6{1'b0}},
                                cfg_dbg ? cpu_ipsr_i : {6{1'b0}} };

   // Interrupt priority level registers, these require the 64-bits of IRQ
   // priority to be unpacked with 2-bits in every 8-bits aligned to the most-
   // significant bits.

   reg [255:0] ipr_array;
   integer     i2;

   always @*
     begin
       ipr_array = {256{1'b0}};
       for (i2=0;i2<32;i2=i2+1)
         if (cfg_numirq[i2]) begin
           ipr_array[(i2*8)+6] = irq_lvl[(i2*2)+0];
           ipr_array[(i2*8)+7] = irq_lvl[(i2*2)+1];
         end
     end

   wire [31:0] ipr0_val = ipr_array[(0*32)+31:(0*32)];
   wire [31:0] ipr1_val = ipr_array[(1*32)+31:(1*32)];
   wire [31:0] ipr2_val = ipr_array[(2*32)+31:(2*32)];
   wire [31:0] ipr3_val = ipr_array[(3*32)+31:(3*32)];
   wire [31:0] ipr4_val = ipr_array[(4*32)+31:(4*32)];
   wire [31:0] ipr5_val = ipr_array[(5*32)+31:(5*32)];
   wire [31:0] ipr6_val = ipr_array[(6*32)+31:(6*32)];
   wire [31:0] ipr7_val = ipr_array[(7*32)+31:(7*32)];

   // -------------------------------------------------------------------------
   // NVIC PPB read-data mux
   // -------------------------------------------------------------------------

   wire [31:0] nvm_hrdata =
               ( {32{msl_nvic_sels_i[23] & cfg_vtor}} & vtor_val     |
                 {32{msl_nvic_sels_i[22] & cfg_syst}} & syst_csr_val |
                 {32{msl_nvic_sels_i[21] & cfg_syst}} & syst_rvr_val |
                 {32{msl_nvic_sels_i[20] & cfg_syst}} & syst_cvr_val |
                 {32{msl_nvic_sels_i[19] & cfg_syst}} & syst_cal_val |
                 {32{msl_nvic_sels_i[18]}}            & irq_en       |
                 {32{msl_nvic_sels_i[17]}}            & irq_en       |
                 {32{msl_nvic_sels_i[16]}}            & pend_irq     |
                 {32{msl_nvic_sels_i[15]}}            & pend_irq     |
                 {32{msl_nvic_sels_i[14]}}            & ipr0_val     |
                 {32{msl_nvic_sels_i[13]}}            & ipr1_val     |
                 {32{msl_nvic_sels_i[12]}}            & ipr2_val     |
                 {32{msl_nvic_sels_i[11]}}            & ipr3_val     |
                 {32{msl_nvic_sels_i[10]}}            & ipr4_val     |
                 {32{msl_nvic_sels_i[ 9]}}            & ipr5_val     |
                 {32{msl_nvic_sels_i[ 8]}}            & ipr6_val     |
                 {32{msl_nvic_sels_i[ 7]}}            & ipr7_val     |
                 {32{msl_nvic_sels_i[ 6]}}            & icsr_val     |
                 {32{msl_nvic_sels_i[ 5]}}            & aircr_val    |
                 {32{msl_nvic_sels_i[ 4]}}            & scr_val      |
                 {32{msl_nvic_sels_i[ 3]}}            & ccr_val      |
                 {32{msl_nvic_sels_i[ 2]}}            & shpr2_val    |
                 {32{msl_nvic_sels_i[ 1]}}            & shpr3_val    |
                 {32{msl_nvic_sels_i[ 0] & cfg_dbg}}  & shcsr_val    );

   // -------------------------------------------------------------------------
   // WIC mask generation
   // -------------------------------------------------------------------------

   // For RXEV, the mask simply reflects that the core went to sleep on a WFE
   // rather than a WFI.

   wire        wic_mask_rxev = cpu_wfe_execute_i;

   // For NMI, the mask reflects either that we are not in NMI, and are
   // therefore capable of taking an NMI interrupt, or it reflects that we are
   // sleeping on a WFE and have SEVONPEND set and the NMI pend bit is
   // currently clear.

   wire        wfe_s_on_p   = sev_on_pend_q & cpu_wfe_execute_i;

   wire        wic_mask_nmi = ( ~nmi_actv |
                                wfe_s_on_p & ~pend_nmi_q);

   // For IRQs, the mask reflects that the priority of the IRQ is higher than
   // the current active priority (irrespective of PRIMASK, as a PRIMASK'ed
   // interrupt will wake WFI even if it doesn't preempt) and that it is
   // enabled; for WFE with SEVONPEND, that the interrupt is not currently
   // pending or WFE will be preempted.

   integer     i3;
   reg  [31:0] irq_lvl_ok;

   always @*
     for(i3=0;i3<32;i3=i3+1)
       irq_lvl_ok[i3] = {irq_lvl[(2*i3)+1],irq_lvl[2*i3]} < int_actv_lvl;

   // Use the WFI mask even if executing a WFE, as long as PRIMASK is not
   // set i.e. an IRQ would preempt the WFE.

   wire        use_wfi_mask = cpu_wfi_execute_i | ~cpu_primask_i;

   wire [31:0] wfi_mask     = ( irq_en &
                                {32{~cpu_n_or_h_active_i}} &
                                (irq_lvl_ok | {32{~int_actv}}) &
                                {32{use_wfi_mask}} );

   wire [31:0] wfe_mask     = {32{wfe_s_on_p}} & ~pend_irq;

   wire [31:0] wic_mask_isr = wfi_mask | wfe_mask;

   // -------------------------------------------------------------------------
   // Vector table offset register logic
   // -------------------------------------------------------------------------

   wire [23:0] vtor_nxt;
   wire        vtor_en;

   generate
      if((CBAW != 0) || (VTOR != 0)) begin : gen_vtor_0a

         assign vtor_en  = msl_nvic_sels_i[23] & mtx_ppb_write_i;
         assign vtor_nxt = ppb_wdata[31:8];

      end else begin : gen_vtor_0b

         assign { vtor_en, vtor_nxt } = 25'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Sequential update logic for PPB modifiable only registers
   // -------------------------------------------------------------------------

   // Use pclk which is only driven during a PPB write to minimize dynamic
   // power consumption.

   // SYSRESETREQ is only set logically, and is subsequently cleared by the
   // resulting reset.

   always @(posedge pclk or negedge hreset_n)
     if (~hreset_n)
       sys_reset_req_q <= 1'b0;
     else if (sys_reset_req_en)
       sys_reset_req_q <= 1'b1;

   // --------
   // The SysTick timer is optional. The ARMv6-M architecture does not require
   // it to be reset, so only implement reset flops if RAR is set.

   generate
      if((CBAW != 0) || ((SYST != 0) && (RAR != 0))) begin : gen_syst_2a

         wire rar_reset_n = ~cfg_rar | hreset_n;

         always @(posedge pclk or negedge rar_reset_n)
           if(~rar_reset_n)
             tck_rvr_q <= {24{1'b1}};
           else if (cfg_syst ? tck_rvr_en : 1'b0)
             tck_rvr_q <= tck_rvr_nxt;

      end else if(SYST != 0) begin : gen_syst_2b

         always @(posedge pclk)
           if (tck_rvr_en)
             tck_rvr_q <= tck_rvr_nxt;

      end else begin : gen_syst_2c

         wire [24:0] unused = { tck_rvr_nxt[23:0], tck_rvr_en };
         wire        zero = 1'b0;
         always @* tck_rvr_q = {24{zero}};

      end
   endgenerate

   // --------

   generate
      if((CBAW != 0) || (SYST != 0)) begin : gen_syst_3a

         always @(posedge pclk or negedge hreset_n)
           if (~hreset_n) begin
              tck_enable_q  <= 1'b0;
              tck_tickint_q <= 1'b0;
              tck_clk_src_q <= 1'b0;
           end else if (cfg_syst ? tck_control_en : 1'b0) begin
              tck_enable_q  <= tck_enable_nxt;
              tck_tickint_q <= tck_tickint_nxt;
              tck_clk_src_q <= tck_clk_src_nxt;
           end

         always @(posedge pclk or negedge hreset_n)
           if (~hreset_n)
             tck_lvl_q <= {2{1'b0}};
           else if(cfg_syst ? tck_lvl_en : 1'b0)
             tck_lvl_q <= tck_lvl_nxt;

      end else begin : gen_syst_3b

         wire [6:0] unused = { tck_control_en, tck_enable_nxt, tck_tickint_nxt,
                               tck_clk_src_nxt, tck_lvl_en, tck_lvl_nxt[1:0] };

         wire       zero = 1'b0;

         always @* { tck_enable_q, tck_tickint_q, tck_clk_src_q,
                     tck_lvl_q[1:0] } = {5{zero}};

      end
   endgenerate

   // --------
   // PendSV and SVCall priorities and sleep control are always present, and
   // can only be updated by a PPB write using pclk.

   always @(posedge pclk or negedge hreset_n)
     if (~hreset_n)
       psv_lvl_q <= {2{1'b0}};
     else if (psv_lvl_en)
       psv_lvl_q <= psv_lvl_nxt;

   always @(posedge pclk or negedge hreset_n)
     if (~hreset_n)
       svc_lvl_q <= {2{1'b0}};
     else if (svc_lvl_en)
       svc_lvl_q <= svc_lvl_nxt;

   always @(posedge pclk or negedge hreset_n)
     if (~hreset_n) begin
       sev_on_pend_q   <= 1'b0;
       deep_sleep_q    <= 1'b0;
       sleep_on_exit_q <= 1'b0;
     end else if (scr_en) begin
       sev_on_pend_q   <= sev_on_pend_nxt;
       deep_sleep_q    <= deep_sleep_nxt;
       sleep_on_exit_q <= sleep_on_exit_nxt;
     end

   // --------
   // The number of interrupt enable and mask flops is a function of how many
   // are implemented and/or masked. Generate only those which are required to
   // be present.

   genvar   g2;

   generate
      if(CBAW != 0) begin : gen_numirq_0a

         integer j1;

         always @(posedge pclk or negedge hreset_n)
           if (~hreset_n)
             irq_en_q[31:0] <= {32{1'b0}};
           else
             for (j1=0;j1<32;j1=j1+1)
               if (cfg_numirq[j1] ? irq_en_en[j1] : 1'b0)
                 irq_en_q[j1] <= irq_en_nxt;

      end else begin : gen_numirq_0b
         for(g2 = 0; g2 < 32; g2 = g2 + 1) begin : gen_numirq_0c
            if((NUMIRQ > g2) && (!IRQDIS[g2])) begin : gen_numirq_0d

               always @(posedge pclk or negedge hreset_n)
                 if(~hreset_n)
                   irq_en_q[g2] <= 1'b0;
                 else if(irq_en_en[g2])
                   irq_en_q[g2] <= irq_en_nxt;

            end else begin : gen_numirq_0e

               wire [1:0] unused = { irq_en_en[g2], irq_en_nxt };
               wire zero = 1'b0;
               always @* irq_en_q[g2] = zero;

            end
         end
      end
   endgenerate

   // --------
   // There are two interrupt priority level registers per interrupt and
   // interrupts are grouped such that four pairs may be updated by a single
   // 32-bit word write. Only the flops for functional interrupts are generated
   // with all others reading as zero with writes ignored.

   genvar   g3, g4;

   generate
      if(CBAW != 0) begin : gen_numirq_1a

         integer j2, j3, j4;

         always @(posedge pclk or negedge hreset_n)
           if (~hreset_n)
             irq_lvl_q[63:0] <= {64{1'b0}};
           else
             for (j2=0;j2<8;j2=j2+1) // for each IPR[0..7]
               if (irq_lvl_en[j2])      // if IPR enabled
                 for (j3=0;j3<4;j3=j3+1)   // for each IRQ[0..3]
                   if (cfg_numirq[(j2*4)+j3]) // if IRQ implemented
                     for (j4=0;j4<2;j4=j4+1)     // for each priority bit
                       irq_lvl_q[(j2*8)+(j3*2)+j4] <= irq_lvl_nxt[(j3*2)+j4];

      end else begin : gen_numirq_1b

         for(g3 = 0; g3 < 8; g3 = g3 + 1) begin : gen_numirq_1c
            for(g4 = 0; g4 < 4; g4 = g4 + 1) begin : gen_numirq_1d

               if((NUMIRQ > ((4*g3)+g4)) && (!IRQDIS[(4*g3)+g4]))
                  begin : gen_numirq_1d

                     always @(posedge pclk or negedge hreset_n)
                       if(~hreset_n) begin
                          irq_lvl_q[(8*g3)+(2*g4)+0] <= 1'b0;
                          irq_lvl_q[(8*g3)+(2*g4)+1] <= 1'b0;
                       end else if(irq_lvl_en[g3]) begin
                          irq_lvl_q[(8*g3)+(2*g4)+0] <= irq_lvl_nxt[(2*g4)+0];
                          irq_lvl_q[(8*g3)+(2*g4)+1] <= irq_lvl_nxt[(2*g4)+1];
                       end

                  end else begin : gen_numirq_1e

                     wire [2:0] unused = { irq_lvl_en[g3],
                                           irq_lvl_nxt[(2*g4)+0],
                                           irq_lvl_nxt[(2*g4)+1] };

                     wire zero = 1'b0;
                     always @* irq_lvl_q[(8*g3)+(2*g4)+0] = zero;
                     always @* irq_lvl_q[(8*g3)+(2*g4)+1] = zero;

                  end
            end
         end
      end
   endgenerate

   // --------
   // The vector table offset register is optional. If it is present it always
   // resets to zero. Otherwise it always reads as zero.

   generate
      if((CBAW != 0) || (VTOR != 0)) begin : gen_vtor_1a

         always @(posedge pclk or negedge hreset_n)
           if(~hreset_n)
             vtor_q <= 24'b0;
           else if(cfg_vtor & vtor_en)
             vtor_q <= vtor_nxt;

      end else begin : gen_vtor_1b

         wire [24:0] unused = { vtor_en, vtor_nxt[23:0] };
         wire zero = 1'b0;
         always @* vtor_q = {24{zero}};

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Sequential update logic for system-clock registers
   // -------------------------------------------------------------------------

   // Interrupt detection and the current SysTick timer value (if present),
   // need to be able to update when there is no PPB write. All of these flops
   // are therefore clocked off SCLK.

   // Like the reload value, the SysTick current value register is both
   // optional, and additionally optionally reset.

   generate
      if((CBAW != 0) || ((SYST != 0) && (RAR != 0))) begin : gen_syst_4a

         wire rar_reset_n = ~cfg_rar | hreset_n;

         always @(posedge sclk or negedge rar_reset_n)
           if(~rar_reset_n)
             tck_cvr_q <= {24{1'b1}};
           else if (cfg_syst ? tck_cvr_en : 1'b0)
             tck_cvr_q <= tck_cvr_nxt;

      end else if(SYST != 0) begin : gen_syst_4b

         always @(posedge sclk)
           if (tck_cvr_en)
             tck_cvr_q <= tck_cvr_nxt;

      end else begin : gen_syst_4c

         wire [24:0] unused = { tck_cvr_nxt[23:0], tck_cvr_en };
         wire        zero = 1'b0;
         always @* tck_cvr_q = {24{zero}};

      end
   endgenerate

   // --------

   generate
      if((CBAW != 0) || (SYST != 0)) begin : gen_syst_5a

         always @(posedge sclk or negedge hreset_n)
           if (~hreset_n)
             tck_flag_q  <= 1'b0;
           else if (cfg_syst ? tck_flag_en : 1'b0)
             tck_flag_q <= tck_flag_nxt;

         always @(posedge sclk or negedge hreset_n)
           if (~hreset_n)
             pend_tck_q <= 1'b0;
           else if (cfg_syst ? pend_tck_en : 1'b0)
             pend_tck_q <= pend_tck_nxt;

      end else begin : gen_syst_5b

         wire [3:0] unused = { pend_tck_en, pend_tck_nxt, tck_flag_en,
                               tck_flag_nxt };

         wire       zero = 1'b0;
         always @* { tck_flag_q, pend_tck_q } = {2{zero}};

      end
   endgenerate

   // --------
   // The SEV/WFE event register is always present, as is the sleeping control
   // register.

   always @(posedge sclk or negedge hreset_n)
     if (~hreset_n)
       event_q <= 1'b0;
     else if (event_en)
       event_q <= event_nxt;

   always @(posedge sclk or negedge hreset_n)
     if (~hreset_n)
       sleeping_raw_q <= 1'b0;
     else if(hready_i)
       sleeping_raw_q <= sleeping_nxt;

   // --------
   // WIC deep-sleep acknowledge is only generated if WIC mode is implemented.

   generate
      if((CBAW != 0) || (WIC != 0)) begin : gen_wic_1a

         always @(posedge sclk or negedge hreset_n)
           if (~hreset_n)
             wic_ds_ack_q <= 1'b0;
           else if (cfg_wic ? wic_ds_ack_en : 1'b0)
             wic_ds_ack_q <= wic_ds_ack_nxt;

      end else begin : gen_wic_1b

         wire [1:0] unused = {wic_ds_ack_en, wic_ds_ack_nxt};
         wire zero = 1'b0;
         always @* wic_ds_ack_q = zero;

      end
   endgenerate

   // --------
   // The set of interrupt mask and pend registers generated is the minimal
   // needed.

   genvar     g5;

   generate
      if(CBAW != 0) begin : gen_numirq_2a

         integer i4;

         always @(posedge sclk or negedge hreset_n)
           if (~hreset_n)
             pend_irq_q[31:0] <= {32{1'b0}};
           else
             for (i4=0;i4<32;i4=i4+1)
               if (cfg_numirq[i4])
                 pend_irq_q[i4] <= pend_irq_nxt[i4];

         integer i5;

         always @(posedge sclk or negedge hreset_n)
           if (~hreset_n)
             mask_irq_q[31:0] <= {32{1'b0}};
           else
             for (i5=0;i5<32;i5=i5+1)
               if (cfg_numirq[i5] ? mask_en : 1'b0)
                 mask_irq_q[i5] <= mask_irq_nxt[i5];

      end else begin : gen_numirq_2b
         for(g5 = 0; g5 < 32; g5 = g5 + 1) begin : gen_numirq_2c

            if((NUMIRQ > g5) && (!IRQDIS[g5])) begin : gen_numirq_2d

               always @(posedge sclk or negedge hreset_n)
                 if(~hreset_n)
                   pend_irq_q[g5] <= 1'b0;
                 else
                   pend_irq_q[g5] <= pend_irq_nxt[g5];

               always @(posedge sclk or negedge hreset_n)
                 if(~hreset_n)
                   mask_irq_q[g5] <= 1'b0;
                 else if(mask_en)
                   mask_irq_q[g5] <= mask_irq_nxt[g5];

            end else begin : gen_numirq_2e

               wire unused = mask_irq_nxt[g5];
               wire zero = 1'b0;
               always @* {mask_irq_q[g5], pend_irq_q[g5]} = {2{zero}};

            end

         end
      end
   endgenerate

   // --------
   // NMI is always present.

   always @(posedge sclk or negedge hreset_n)
     if (~hreset_n)
       pend_nmi_q <= 1'b0;
     else
       pend_nmi_q <= pend_nmi_nxt;

   always @(posedge sclk or negedge hreset_n)
     if (~hreset_n)
       mask_nmi_q <= 1'b0;
     else if (mask_en)
       mask_nmi_q <= mask_nmi_nxt;

   // -------------------------------------------------------------------------
   // Sequential update logic for core-clocked registers
   // -------------------------------------------------------------------------

   // The processor can request HardFault and SVC whilst executing, and PendSV
   // via a write to the PPB. These registers are only cleared when the CPU is
   // also executing, thus HCLK can be used.

   always @(posedge hclk or negedge hreset_n)
     if (~hreset_n)
       pend_hdf_q <= 1'b0;
     else if (pend_hdf_en)
       pend_hdf_q <= pend_hdf_nxt;

   always @(posedge hclk or negedge hreset_n)
     if (~hreset_n)
       pend_svc_q <= 1'b0;
     else if (pend_svc_en)
       pend_svc_q <= pend_svc_nxt;

   always @(posedge hclk or negedge hreset_n)
     if (~hreset_n)
       pend_psv_q <= 1'b0;
     else if (pend_psv_en)
       pend_psv_q <= pend_psv_nxt;

   // -------------------------------------------------------------------------
   // Output assignments
   // -------------------------------------------------------------------------

   assign      nvm_sleep_on_exit_o = sleep_on_exit_q;
   assign      sleeping_o          = sleeping;
   assign      sleep_deep_o        = sleep_deep;
   assign      wic_ds_ack_n_o      = ~wic_ds_ack;
   assign      sys_reset_req_o     = sys_reset_req_q;
   assign      nvm_wfe_advance_o   = event_q;
   assign      nvm_svc_escalate_o  = svc_escalate;
   assign      nvm_hrdata_o        = nvm_hrdata;
   assign      nvm_wfi_advance_o   = wfi_advance;
   assign      nvm_int_pend_o      = int_pend;
   assign      nvm_int_pend_num_o  = int_pend_num;
   assign      nvm_vtor_31to8_o    = vtor_q;

   // --------
   // Only drive VECTCLRACTIVE if debug is implemented.

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_1a

         assign nvm_vect_clr_actv_o = cfg_dbg ? vect_clr_actv : 1'b0;

      end else begin : gen_dbg_1b

         assign nvm_vect_clr_actv_o = 1'b0;

      end
   endgenerate

   // --------
   // Generate outputs for WIC interface. The number of functional WIC outputs
   // is configured via the WIC and WICLINES parameters. WICLINES values of 1
   // and 2 enable RXEV and NMI, with values up to 34 enabling the configurable
   // interrupt lines.

   genvar     g6;

   generate
      if(CBAW != 0) begin : gen_wic_2a

         assign wic_mask_isr_o  = ( wic_mask_isr & cfg_wiclines[33:2] &
                                    {32{cfg_wic}} );

         assign wic_mask_nmi_o  = wic_mask_nmi & cfg_wiclines[1] & cfg_wic;
         assign wic_mask_rxev_o = wic_mask_rxev & cfg_wiclines[0] & cfg_wic;

      end else if(WIC != 0) begin : gen_wic_2b

         wire [33:0] unused = cfg_wiclines[33:0];

         if(WICLINES > 0) begin : gen_wic_2c
            assign wic_mask_rxev_o = wic_mask_rxev;
         end else begin : gen_wic_2d
            wire unused = wic_mask_rxev;
            assign wic_mask_rxev_o = 1'b0;
         end

         if(WICLINES > 1) begin : gen_wic_2e
            assign wic_mask_nmi_o = wic_mask_nmi;
         end else begin : gen_wic_2f
            wire unused = wic_mask_nmi;
            assign wic_mask_nmi_o = 1'b0;
         end

         for(g6 = 0; g6 < 32; g6 = g6 + 1) begin : gen_wic_2g
            if(WICLINES > (g6 + 2)) begin : gen_wic_2h
               assign wic_mask_isr_o[g6] = wic_mask_isr[g6];
            end else begin : gen_wic_2i
               wire unused = wic_mask_isr[g6];
               assign wic_mask_isr_o[g6] = 1'b0;
            end
         end

      end else begin : gen_wic_2j

         wire [67:0] unused = { cfg_wiclines[33:0], wic_mask_rxev,
                                wic_mask_nmi, wic_mask_isr[31:0] };

         assign wic_mask_isr_o[31:0] = 32'b0;
         assign wic_mask_nmi_o = 1'b0;
         assign wic_mask_rxev_o = 1'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------


`ifdef ARM_ASSERT_ON
   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------

 `include "std_ovl_defines.h"

   // --------
   // Register enable X check.

   ovl_never_unknown
     #(.severity_level (`OVL_FATAL),
       .width          (54),
       .property_type  (`OVL_ASSERT),
       .msg            ("Register enables must never be X"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_reg_en_x
     (.clock     (sclk),
      .reset     (hreset_n),
      .enable    (1'b1),
      .qualifier (1'b1),
      .test_expr ({ sys_reset_req_en,
                    tck_control_en,
                    tck_lvl_en,
                    psv_lvl_en,
                    svc_lvl_en,
                    scr_en,
                    irq_en_en[31:0],
                    irq_lvl_en[7:0],
                    pend_tck_en,
                    event_en,
                    hready_i,
                    wic_ds_ack_en,
                    mask_en,
                    pend_hdf_en,
                    pend_svc_en,
                    pend_psv_en }),
      .fire      ());

   // --------
   // Core can never make a pend requests if halted.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("Core must never request pend whilst halted"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_svc_valid_halt
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (cpu_svc_request_i | cpu_hdf_request_i),
      .consequent_expr (~dbg_s_halt_i),
      .fire            ());

   // --------
   // Build delayed version of interrupt pending signals for use in assertions.

   reg  [31:0] a_irq_q;
   reg  [31:0] a_irq_pend_set_pulse_q;
   reg  [31:0] a_irq_pend_remain_untaken_q;
   reg  [31:0] a_irq_pend_remain_q;
   reg  [31:0] a_irq_pend_remain_clr_q;

   wire [31:0] a_irq_taken = irq_actv_bit & {32{cpu_int_taken_i}};
   wire [31:0] a_irq_pend_set_pulse_nxt = irq & ~a_irq_q & ~a_irq_taken;
   wire [31:0] a_irq_pend_remain_untaken_nxt = pend_irq & irq & ~a_irq_taken;
   wire [31:0] a_irq_pend_remain_nxt = pend_irq & ~(a_irq_taken | irq_pend_clr);
   wire [31:0] a_irq_pend_remain_clr_nxt = ~pend_irq & (~(irq | irq_pend_set));

   always @(posedge sclk or negedge hreset_n)
     if (~hreset_n) begin
       a_irq_q                     <= {32{1'b0}};
       a_irq_pend_set_pulse_q      <= {32{1'b0}};
       a_irq_pend_remain_untaken_q <= {32{1'b0}};
       a_irq_pend_remain_q         <= {32{1'b0}};
       a_irq_pend_remain_clr_q     <= {32{1'b0}};
     end else begin
       a_irq_q                     <= irq;
       a_irq_pend_set_pulse_q      <= a_irq_pend_set_pulse_nxt;
       a_irq_pend_remain_untaken_q <= a_irq_pend_remain_untaken_nxt;
       a_irq_pend_remain_q         <= a_irq_pend_remain_nxt;
       a_irq_pend_remain_clr_q     <= a_irq_pend_remain_clr_nxt;
     end

   // --------
   // Check that interrupt pend bits behave well.

   ovl_always
     #(.severity_level (`OVL_ERROR),
       .property_type  (`OVL_ASSERT),
       .msg            ("IRQ dropping must clear IRQ mask"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_irq_drop_clears_mask
     (.clock     (sclk),
      .reset     (hreset_n),
      .enable    (1'b1),
      .test_expr (&((a_irq_q) | ~mask_irq)),
      .fire      ());

   // --------
   // These assertions are effectively ovl_implication on each
   // bit but since the number of bits is greater than one, they have
   // been written as ovl_always with "a => b" as "(~a) | b"

   ovl_always
     #(.severity_level(`OVL_ERROR),
       .property_type(`OVL_ASSERT),
       .msg("IRQ must pend if line pulsed and not simultaneously taken"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_irq_pend_set_pulse
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr(&((~a_irq_pend_set_pulse_q) | pend_irq)),
      .fire());

   ovl_always
     #(.severity_level(`OVL_ERROR),
       .property_type(`OVL_ASSERT),
       .msg("IRQ pend must remain set unless taken"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_irq_pend_remain_untaken
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr(&((~a_irq_pend_remain_untaken_q) | pend_irq)),
      .fire());

   ovl_always
     #(.severity_level(`OVL_ERROR),
       .property_type(`OVL_ASSERT),
       .msg("IRQ pend must remain set unless taken or cleared by software"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_irq_pend_remain
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr(&((~a_irq_pend_remain_q) | pend_irq)),
      .fire());

   ovl_always
     #(.severity_level(`OVL_ERROR),
       .property_type(`OVL_ASSERT),
       .msg("IRQ pend must remain clear unless stimulated or set by software"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_irq_pend_remain_clr
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr(&((~a_irq_pend_remain_clr_q) | (~pend_irq))),
      .fire());

   // --------
   // Software clear of level-sensitive IRQ pend bits must not lose the
   // interrupt request so clearing when the IRQ pin is asserted and not active
   // has defined behavior (must not leave the pend bit set - encapsulated in
   // the asserts above); however, clearing when the IRQ pin is asserted and
   // active need not leave the pend bit set since it would become set
   // immediately after exception return if the IRQ was still asserted. So we
   // warn about software exercising this behavior since it may differ from
   // other ARMv6-M or ARMv7-M implementations.

   ovl_never
     #(.severity_level(`OVL_INFO),
       .property_type(`OVL_ASSERT),
       .msg("Software clear of IRQ pend while stimulated and active is IMPDEF"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_info_irq_pend_clear_impdef
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr(|(irq_pend_clr & irq & irq_actv_bit)),
      .fire());

   // --------
   // Replicate IRQ logic for NMI equivalents.

   reg    a_nmi_q;
   reg    a_nmi_pend_set_pulse_q;
   reg    a_nmi_pend_remain_untaken_q;
   reg    a_nmi_pend_remain_q;
   reg    a_nmi_pend_remain_clr_q;

   wire   a_nmi_taken = nmi_actv & cpu_int_taken_i;
   wire   a_nmi_pend_set_pulse_nxt = nmi_i & ~a_nmi_q & ~a_nmi_taken;
   wire   a_nmi_pend_remain_untaken_nxt = pend_nmi_q & nmi_i & ~a_nmi_taken;

   wire   a_nmi_pend_remain_nxt = pend_nmi_q & ~(a_nmi_taken |
                                                 nvm_vect_clr_actv_o);

   wire   a_nmi_pend_remain_clr_nxt = ~pend_nmi_q & (~(nmi_i | nmi_pend_set));

   always @(posedge sclk or negedge hreset_n)
     if (~hreset_n) begin
       a_nmi_q                     <= 1'b0;
       a_nmi_pend_set_pulse_q      <= 1'b0;
       a_nmi_pend_remain_untaken_q <= 1'b0;
       a_nmi_pend_remain_q         <= 1'b0;
       a_nmi_pend_remain_clr_q     <= 1'b0;
     end else begin
       a_nmi_q                     <= nmi_i;
       a_nmi_pend_set_pulse_q      <= a_nmi_pend_set_pulse_nxt;
       a_nmi_pend_remain_untaken_q <= a_nmi_pend_remain_untaken_nxt;
       a_nmi_pend_remain_q         <= a_nmi_pend_remain_nxt;
       a_nmi_pend_remain_clr_q     <= a_nmi_pend_remain_clr_nxt;
     end


   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("NMI dropping must clear NMI mask"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_nmi_drop_clears_mask
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(~a_nmi_q),
      .consequent_expr(~mask_nmi_q),
      .fire());

   // --------
   // These assertions could have been written more directly using ovl_next
   // but have been written this way to match the IRQ asserts above for
   // consistency.

   ovl_always
     #(.severity_level(`OVL_ERROR),
       .property_type(`OVL_ASSERT),
       .msg("NMI pend must be set if line pulsed and not taken"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_nmi_pend_set_pulse
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr((~a_nmi_pend_set_pulse_q) | pend_nmi_q),
      .fire());

   ovl_always
     #(.severity_level(`OVL_ERROR),
       .property_type(`OVL_ASSERT),
       .msg("NMI pend must remain set unless taken"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_nmi_pend_remain_untaken
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr((~a_nmi_pend_remain_untaken_q) | pend_nmi_q),
      .fire());

   ovl_always
     #(.severity_level(`OVL_ERROR),
       .property_type(`OVL_ASSERT),
       .msg("NMI pend must remain unless taken or cleared by VECTCLRACTIVE"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_nmi_pend_remain
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr((~a_nmi_pend_remain_q) | pend_nmi_q),
      .fire());

   ovl_always
     #(.severity_level(`OVL_ERROR),
       .property_type(`OVL_ASSERT),
       .msg("NMI pend must remain clear unless stimulated or set by software"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_nmi_pend_remain_clr
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr((~a_nmi_pend_remain_clr_q) | (~pend_nmi_q)),
      .fire());

   // --------
   // SysTick timer usage assertions.

   reg a_tck_cvr_valid_q;
   reg a_tck_rvr_valid_q;

   always @(posedge sclk or negedge hreset_n)
     if(~hreset_n) begin
       a_tck_cvr_valid_q <= 1'b0;
       a_tck_rvr_valid_q <= 1'b0;
     end else begin
       a_tck_cvr_valid_q <= a_tck_cvr_valid_q | a_tck_rvr_valid_q & tck_cvr_clr;
       a_tck_rvr_valid_q <= a_tck_rvr_valid_q | tck_rvr_en;
     end

   ovl_never
     #(.severity_level(`OVL_INFO),
       .property_type(`OVL_ASSERT),
       .msg({"Software should configure SYST_RVR before clearing SYST_CVR ",
             "(SYST_CVR loaded with UNKNOWN value)"}),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_info_syst_cvr_order
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr(~a_tck_rvr_valid_q & tck_cvr_clr),
      .fire());

   ovl_never
     #(.severity_level(`OVL_INFO),
       .property_type(`OVL_ASSERT),
       .msg({"Software should reset SYST_CVR before setting SYST_CSR.ENABLE ",
             "(TICKINT and COUNTFLAG are UNKNOWN)"}),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_info_syst_csr_order
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr(~a_tck_cvr_valid_q & tck_control_en & tck_enable_nxt),
      .fire());

   // --------
   // Determine highest implemented prioritizable interrupt number.

   wire [5:0] a_num_irqs = ( cfg_numirq[31] ? 6'd32 :
                             cfg_numirq[30] ? 6'd31 :
                             cfg_numirq[29] ? 6'd30 :
                             cfg_numirq[28] ? 6'd29 :
                             cfg_numirq[27] ? 6'd28 :
                             cfg_numirq[26] ? 6'd27 :
                             cfg_numirq[25] ? 6'd26 :
                             cfg_numirq[24] ? 6'd25 :
                             cfg_numirq[23] ? 6'd24 :
                             cfg_numirq[22] ? 6'd23 :
                             cfg_numirq[21] ? 6'd22 :
                             cfg_numirq[20] ? 6'd21 :
                             cfg_numirq[19] ? 6'd20 :
                             cfg_numirq[18] ? 6'd19 :
                             cfg_numirq[17] ? 6'd18 :
                             cfg_numirq[16] ? 6'd17 :
                             cfg_numirq[15] ? 6'd16 :
                             cfg_numirq[14] ? 6'd15 :
                             cfg_numirq[13] ? 6'd14 :
                             cfg_numirq[12] ? 6'd13 :
                             cfg_numirq[11] ? 6'd12 :
                             cfg_numirq[10] ? 6'd11 :
                             cfg_numirq[ 9] ? 6'd10 :
                             cfg_numirq[ 8] ?  6'd9 :
                             cfg_numirq[ 7] ?  6'd8 :
                             cfg_numirq[ 6] ?  6'd7 :
                             cfg_numirq[ 5] ?  6'd6 :
                             cfg_numirq[ 4] ?  6'd5 :
                             cfg_numirq[ 3] ?  6'd4 :
                             cfg_numirq[ 2] ?  6'd3 :
                             cfg_numirq[ 1] ?  6'd2 :
                             cfg_numirq[ 0] ?  6'd1 : 6'd0 );

   // --------
   // Check this is a valid implementation.

   ovl_always
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("CORTEXM0+ NVIC only supports 0-to-32 IRQs"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_num_irq
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr((a_num_irqs >=  0) & (a_num_irqs <= 32)),
      .fire());

   // --------
   // Catch UNPREDICTABLE software usage.

   ovl_always
     #(.severity_level(`OVL_INFO),
       .property_type(`OVL_ASSERT),
       .msg("IPSR must be implemented value unless software is UNPREDICTABLE"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_info_int_curr_num_unpred
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr((cpu_ipsr_i == {6{1'b0}}) | // thread
                 (cpu_ipsr_i == {6{1'b1}}) | // faulted xPSR load
                 (cpu_ipsr_i == const_nmi_vec) |
                 (cpu_ipsr_i == const_hdf_vec) |
                 ( ((cpu_ipsr_i == const_svc_vec) |
                    (cpu_ipsr_i == const_psv_vec) |
                    (cfg_syst & (cpu_ipsr_i == const_tck_vec)) )) |
                 ((cpu_ipsr_i >= const_irq0_vec) &
                  (cpu_ipsr_i < (const_irq0_vec + a_num_irqs))) ),
      .fire());

   // --------
   // C_MASKINTS only exists when debug is present.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("C_MASKINTS must not be asserted without Debug"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_c_maskints_i_no_dbg
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(cfg_dbg==0),
      .consequent_expr(~dbg_c_maskints_i),
      .fire());

   // --------
   // If the NVIC reports and interrupt is pending, it must provide a
   // valid pending interrupt number.

   ovl_implication
     #(.severity_level(`OVL_ERROR),
       .property_type(`OVL_ASSERT),
       .msg("nvm_int_pend_num_o must be valid when nvm_int_pend_o asserted"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_nvm_int_pend_num_o_valid
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(nvm_int_pend_o),
      .consequent_expr((nvm_int_pend_num_o == const_nmi_vec) |
                       (nvm_int_pend_num_o == const_hdf_vec) |
                       ( ((nvm_int_pend_num_o == const_svc_vec) |
                          (nvm_int_pend_num_o == const_psv_vec) |
                          (cfg_syst &
                           (nvm_int_pend_num_o == const_tck_vec))) ) |
                       ((nvm_int_pend_num_o >= const_irq0_vec) &
                        (nvm_int_pend_num_o < (const_irq0_vec + a_num_irqs)))),
      .fire());

   // --------
   // If an interrupt is active, it must be a valid one.

    ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Interrupt active decode from cpu_ipsr_i"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_nvm_int_actv
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(int_actv),
      .consequent_expr((((cpu_ipsr_i == const_svc_vec) |
                         (cpu_ipsr_i == const_psv_vec) |
                         (cfg_syst & (cpu_ipsr_i == const_tck_vec)))) |
                       ((cpu_ipsr_i >= const_irq0_vec) &
                        (cpu_ipsr_i < (const_irq0_vec + a_num_irqs)))),
      .fire());

   reg  [ 5:0] a_int_curr_num_q;
   reg  [ 1:0] a_int_actv_lvl_q;

   always @(posedge sclk or negedge hreset_n)
     if (~hreset_n)
       begin
          a_int_curr_num_q    <= {6{1'b0}};
          a_int_actv_lvl_q    <= {2{1'b0}};
       end
     else
       begin
          a_int_curr_num_q    <= cpu_ipsr_i;
          a_int_actv_lvl_q    <= int_actv_lvl;
       end

   // --------
   // Determine a change to the priority of the currently active exception.

   wire a_unpredictable_actv_lvl_chg = ((int_actv_lvl != a_int_actv_lvl_q) &
                                        (cpu_ipsr_i == a_int_curr_num_q));

   // --------
   // Identify software/debugger based UNPREDICTABLE priority changes.

   ovl_never
     #(.severity_level(`OVL_INFO),
       .property_type(`OVL_ASSERT),
       .msg("Dynamic re-prioritization - UNPREDICTABLE"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_info_unpredictable_actv_lvl_chg
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr(a_unpredictable_actv_lvl_chg),
      .fire());

   // --------
   // Simulation interrupt pend tree result never X check.

   ovl_never_unknown
     #(.severity_level(`OVL_FATAL),
       .width(1),
       .property_type(`OVL_ASSERT),
       .msg("pend_tree must be known"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_pend_tree_unknown
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .qualifier(1'b1),
      .test_expr(pend_tree),
      .fire());

   // --------
   // If the pending tree reports and interrupt, it must be a valid value.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("pend_tree_num should be valid when pending"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_pend_num_valid
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(pend_tree),
      .consequent_expr((pend_tree_num  == const_svc_vec) |
                       (pend_tree_num  == const_psv_vec) |
                       (pend_tree_num  == const_tck_vec) |
                       ((pend_tree_num >= const_irq0_vec) &
                        (pend_tree_num < (const_irq0_vec + a_num_irqs)))),
      .fire());

   // --------
   // If the pend tree isn't valid, it must return an exception of zero.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("pend_tree_num should be 0 when not pending"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_pend_num_not_pend
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(~pend_tree),
      .consequent_expr(pend_tree_num == {6{1'b0}}),
      .fire());

   // --------
   // Only one exception can be the currently executing one.

   ovl_zero_one_hot
     #(.severity_level(`OVL_FATAL),
       .width(37),
       .property_type(`OVL_ASSERT),
       .msg("At most one decoded active exception"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_actv_bit
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr(actv_bit),
      .fire());

   // --------
   // Report UNPREDICTABLE software entry to unimplemented exceptions.

   ovl_one_hot
     #(.severity_level(`OVL_INFO),
       .width(39),
       .property_type(`OVL_ASSERT),
       .msg("IPSR must indicate Thread, fault, or an implemented exception"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_info_psr_ipsr_inactive
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .test_expr({cpu_ipsr_i == {6{1'b0}},
                  {cpu_ipsr_i == {6{1'b1}}},
                  actv_bit}),
      .fire());

   // -------
   // If a prioritizable interrupt is active, it must be a valid IRQ.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("irq_actv must be correct decode of cpu_ipsr_i"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_irq_actv
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(irq_actv),
      .consequent_expr((cpu_ipsr_i >= const_irq0_vec) &
                       (cpu_ipsr_i < (const_irq0_vec + a_num_irqs))),
      .fire());

   // --------
   // SysTick handler can never be pending if it is not implemented.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("SysTick exception must not be pending without SYST configuration"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_pend_state_no_os
     (.clock(sclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(cfg_syst==0),
      .consequent_expr(~pend_tck_q),
      .fire());

   // -------------------------------------------------------------------------

`endif

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
