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
//   Checked In : $Date: 2012-06-27 18:32:53 +0100 (Wed, 27 Jun 2012) $
//   Revision   : $Revision: 213272 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ CORE, NVIC, DEBUG, AND CLOCK-GATE INTERCONNECT LEVEL
//-----------------------------------------------------------------------------

module cm0p_top
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
    input  wire        sclk,                // system clock
    input  wire        hclk,                // gated AHB clock
    input  wire        dclk,                // gated debug clock
    input  wire        hreset_n,            // system reset
    input  wire        dbg_reset_n,         // debug reset
    input  wire        DFTSE,               // scan enable

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
    input  wire        hready_i,            // AHB ready
    input  wire        hresp_i,             // AHB error response

    output wire        shareable_o,         // AHB transaction shareable

    output wire        hmaster_o,           // master signal (0=core, 1=debug)
    output wire        spec_htrans_o,       // speculative AHB HTRANS[1]

    // AHB-LITE SUB-SET SLAVE PORT
    input  wire [31:0] slv_addr_i,          // debug slave address
    input  wire [ 3:0] slv_prot_i,          // debug slave protection
    input  wire [ 1:0] slv_size_i,          // debug slave size
    input  wire        slv_stall_i,         // debug slave stall
    input  wire [ 1:0] slv_trans_i,         // debug slave trans
    input  wire [31:0] slv_wdata_i,         // debug slave write data
    input  wire        slv_write_i,         // debug slave write not read
    output wire [31:0] slv_rdata_o,         // debug slave read data
    output wire        slv_ready_o,         // debug slave port ready
    output wire        slv_resp_o,          // debug slave port error response

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

    // DEBUG
    input  wire        dbg_restart_i,       // cross-trigger unhalt request
    output wire        dbg_restarted_o,     // cross-trigger unhalt acknowledge
    input  wire        dbg_ext_req_i,       // external halt request
    output wire        halted_o,            // core is halted
    input  wire        niden_i,             // non-invasive debug enable
    input  wire        dbgen_i,             // debug enable

    // MISC
    input  wire        nmi_i,               // non-maskable interrupt
    input  wire [31:0] irq_i,               // interrupt request lines
    output wire        txev_o,              // event output (SEV executed)
    input  wire        rxev_i,              // event input
    output wire        lockup_o,            // core is in LOCKUP
    output wire        sys_reset_req_o,     // system reset request
    input  wire [25:0] st_calib_i,          // SysTick calibration value
    input  wire        st_clk_en_i,         // SysTick SCLK count enable
    input  wire [ 7:0] irq_latency_i,       // interrupt request latency
    input  wire [19:0] eco_rev_num_i,       // change-order input fields
    input  wire        cpu_wait_i,          // wait out of reset

    // POWER MANAGEMENT
    output wire        sleeping_o,          // core and NVIC sleeping
    output wire        sleep_deep_o,        // sleep is deep
    input  wire        sleep_hold_req_n_i,  // sleep hold request
    output wire        sleep_hold_ack_n_o,  // sleep hold acknowledge
    input wire         wic_ds_req_n_i,      // WIC mode request
    output wire        wic_ds_ack_n_o,      // WIC mode acknowledge
    output wire [31:0] wic_mask_isr_o,      // WIC IRQ sensitivity
    output wire        wic_mask_nmi_o,      // WIC NMI sensitivity
    output wire        wic_mask_rxev_o,     // WIC RXEV sensitivity
    output wire        wic_load_o,          // NVIC to WIC upload
    output wire        wic_clear_o,         // NVIC to WIC clear request

    // CODE SEQUENTIALITY INFO
    output wire        code_nseq_o,         // fetch is non-sequential
    output wire [ 3:0] code_hint_o,         // fetching hints

    // DATA HINTS
    output wire [ 1:0] data_hint_o);        // data access hints

   // -------------------------------------------------------------------------
   // Local wires
   // -------------------------------------------------------------------------

   // All core-system to debug-system inter-block communication at this level
   // is bundled into the following buses; this provides easier re-partitioning
   // for power domain implementation where increased hierarchical separation
   // may be required.

   wire [145:0] sys_to_dbg;  // System to debug domain channel
   wire [ 82:0] dbg_to_sys;  // Debug to system domain channel

   // --------
   // To allow clock gate cells to be instantiated in an always powered
   // domain, the enable terms and gated clocks also get implemented here; all
   // gated clocks at this level are derived from the HCLK primary input.

   wire         rclk0;         // Core register file r0-r4 gated clock
   wire         rclk1;         // Core register file r5-r14 gated clock
   wire         pclk;          // PPB space (NVIC) register clock

   wire         cpu_rclk0_en;  // rclk0 enable term
   wire         cpu_rclk1_en;  // rclk1 enable term
   wire         msl_pclk_en;   // pclk enable term

   // -------------------------------------------------------------------------
   // Core system instantiation
   // -------------------------------------------------------------------------

   cm0p_top_sys
     #(.CBAW(CBAW), .ACG(ACG), .AHBSLV(AHBSLV), .BE(BE), .BKPT(BKPT),
       .DBG(DBG), .HWF(HWF), .IOP(IOP), .IRQDIS(IRQDIS), .MPU(MPU),
       .NUMIRQ(NUMIRQ), .RAR(RAR), .SMUL(SMUL), .SYST(SYST), .USER(USER),
       .VTOR(VTOR), .WIC(WIC), .WICLINES(WICLINES), .WPT(WPT))
   u_sys
     (// External public interface:

      .sclk                (sclk),                  // SCLK
      .hclk                (hclk),                  // HCLK
      .hreset_n            (hreset_n),              // HRESETn

      .code_nseq_o         (code_nseq_o),           // CODENSEQ
      .code_hint_o         (code_hint_o[3:0]),      // CODEHINT
      .data_hint_o         (data_hint_o[1:0]),      // DATAHINT
      .haddr_o             (haddr_o[31:0]),         // HADDR
      .hburst_o            (hburst_o[2:0]),         // HBURST
      .hmastlock_o         (hmastlock_o),           // HMASTLOCK
      .hmaster_o           (hmaster_o),             // HMASTER
      .hprot_o             (hprot_o[3:0]),          // HPROT
      .hsize_o             (hsize_o[2:0]),          // HSIZE
      .htrans_o            (htrans_o[1:0]),         // HTRANS
      .hwdata_o            (hwdata_o[31:0]),        // HWDATA
      .hwrite_o            (hwrite_o),              // HWRITE
      .shareable_o         (shareable_o),           // SHAREABLE
      .io_check_o          (io_check_o[31:0]),      // IOCHECK
      .io_addr_o           (io_addr_o[31:0]),       // IOADDR
      .io_trans_o          (io_trans_o),            // IOTRANS
      .io_write_o          (io_write_o),            // IOWRITE
      .io_size_o           (io_size_o[1:0]),        // IOSIZE
      .io_wdata_o          (io_wdata_o[31:0]),      // IOWDATA
      .io_priv_o           (io_priv_o),             // IOPRIV
      .io_master_o         (io_master_o),           // IOMASTER
      .lockup_o            (lockup_o),              // LOCKUP
      .sleep_hold_ack_n_o  (sleep_hold_ack_n_o),    // SLEEPHOLDACKn
      .sys_reset_req_o     (sys_reset_req_o),       // SYSRESETREQ
      .txev_o              (txev_o),                // TXEV
      .wic_ds_ack_n_o      (wic_ds_ack_n_o),        // WICDSACKn
      .wic_clear_o         (wic_clear_o),           // WICCLEAR
      .wic_load_o          (wic_load_o),            // WICLOAD
      .wic_mask_isr_o      (wic_mask_isr_o[31:0]),  // WICMASKISR
      .wic_mask_nmi_o      (wic_mask_nmi_o),        // WICMASKNMI
      .wic_mask_rxev_o     (wic_mask_rxev_o),       // WICMASKRXEV
      .iaex_en_o           (iaex_en_o),             // IAEXEN
      .iaex_seq_o          (iaex_seq_o),            // IAEXSEQ
      .iaex_o              (iaex_o[30:0]),          // IAEX
      .atomic_o            (atomic_o),              // ATOMIC

      .eco_rev_num_3to0_i  (eco_rev_num_i[3:0]),    // ECOREVNUM[3:0]
      .cpu_wait_i          (cpu_wait_i),            // CPUWAIT
      .hrdata_i            (hrdata_i[31:0]),        // HRDATA
      .hready_i            (hready_i),              // HREADY
      .hresp_i             (hresp_i),               // HRESP
      .io_match_i          (io_match_i),            // IOMATCH
      .io_rdata_i          (io_rdata_i[31:0]),      // IORDATA
      .irq_i               (irq_i[31:0]),           // IRQ
      .irq_latency_i       (irq_latency_i[7:0]),    // IRQLATENCY
      .nmi_i               (nmi_i),                 // NMI
      .rxev_i              (rxev_i),                // RXEV
      .sleeping_o          (sleeping_o),            // SLEEPING
      .sleep_deep_o        (sleep_deep_o),          // SLEEPDEEP
      .sleep_hold_req_n_i  (sleep_hold_req_n_i),    // SLEEPHOLDREQn
      .spec_htrans_o       (spec_htrans_o),         // SPECHTRANS
      .st_calib_i          (st_calib_i[25:0]),      // STCALIB
      .st_clk_en_i         (st_clk_en_i),           // STCLKEN
      .wic_ds_req_n_i      (wic_ds_req_n_i),        // WICDSREQn

      // Core-sub-system clock gate interfaces:

      .rclk0               (rclk0),         // r0-r4 clock input
      .rclk1               (rclk1),         // r5-r14 clock input
      .pclk                (pclk),          // PPB clock input

      .cpu_rclk0_en_o      (cpu_rclk0_en),  // r0-r4 clock enable
      .cpu_rclk1_en_o      (cpu_rclk1_en),  // r5-r14 clock enable
      .msl_pclk_en_o       (msl_pclk_en),   // PPB clock enable

      // Core-sub-system to debug-sub-system interface

      .sys_to_dbg_o        (sys_to_dbg[145:0]),  // To debug
      .dbg_to_sys_i        (dbg_to_sys[82:0]));  // From debug

   // -------------------------------------------------------------------------
   // Debug system instantiation
   // -------------------------------------------------------------------------

   // Only attempt to generate the debug logic if the implementation is
   // configured to contain debug support. Otherwise just tie off all debug
   // logic generated signals.

   generate
      if((CBAW != 0) || (DBG != 0)) begin: gen_dbg1

         cm0p_top_dbg
           #(.CBAW(CBAW), .AHBSLV(AHBSLV), .BKPT(BKPT), .IOP(IOP), .MPU(MPU),
             .RAR(RAR), .WPT(WPT))
         u_dbg
           (// external public interface
            .dclk                 (dclk),                 // DCLK
            .dbg_reset_n          (dbg_reset_n),          // DBGRESETn

            .dbg_restarted_o      (dbg_restarted_o),      // DBGRESTARTED
            .halted_o             (halted_o),             // HALTED
            .slv_rdata_o          (slv_rdata_o[31:0]),    // SLVRDATA
            .slv_ready_o          (slv_ready_o),          // SLVREADY
            .slv_resp_o           (slv_resp_o),           // SLVRESP

            .niden_i              (niden_i),              // NIDEN
            .dbgen_i              (dbgen_i),              // DBGEN
            .dbg_restart_i        (dbg_restart_i),        // DBGRESTART
            .dbg_ext_req_i        (dbg_ext_req_i),        // EDBGRQ
            .eco_rev_num_19to4_i  (eco_rev_num_i[19:4]),  // ECOREVNUM[19:4]
            .slv_addr_i           (slv_addr_i[31:0]),     // SLVADDR
            .slv_prot_i           (slv_prot_i[3:0]),      // SLVPROT
            .slv_size_i           (slv_size_i[1:0]),      // SLVSIZE
            .slv_stall_i          (slv_stall_i),          // SLVSTALL
            .slv_trans_i          (slv_trans_i[1:0]),     // SLVTRANS
            .slv_wdata_i          (slv_wdata_i[31:0]),    // SLVWDATA
            .slv_write_i          (slv_write_i),          // SLVWRITE

            // debug-sub-system to core-sub-system interface

            .dbg_to_sys_o         (dbg_to_sys[82:0]),    // To core
            .sys_to_dbg_i         (sys_to_dbg[145:0]));  // From core

      end else begin: gen_dbg0

         wire [241:0] unused = { dclk, dbg_reset_n, niden_i, dbgen_i,
                                 dbg_restart_i, dbg_ext_req_i,
                                 eco_rev_num_i[19:4], slv_addr_i[31:0],
                                 slv_size_i[1:0], slv_trans_i[1:0],
                                 slv_stall_i, slv_prot_i[3:0],
                                 slv_wdata_i[31:0], slv_write_i,
                                 sys_to_dbg[145:0] };

         assign { dbg_restarted_o, halted_o, slv_rdata_o[31:0], slv_resp_o,
                  dbg_to_sys[82:0] }  = 118'b0;

         assign slv_ready_o = 1'b1;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Core system clock gate level instantiation
   // -------------------------------------------------------------------------

   cm0p_top_clk
     #(.CBAW(CBAW), .ACG(ACG))
   u_clk
     (.hclk            (hclk),          // HCLK clock source input

      .rclk0           (rclk0),         // r0-r4 clock output
      .rclk1           (rclk1),         // r5-r14 clock output
      .pclk            (pclk),          // PPB space clock output

      .DFTSE           (DFTSE),         // Scan enable

      .cpu_rclk0_en_i  (cpu_rclk0_en),  // r0-r4 clock enable
      .cpu_rclk1_en_i  (cpu_rclk1_en),  // r5-r14 clock enable
      .msl_pclk_en_i   (msl_pclk_en));  // PPB space clock enable

   // -------------------------------------------------------------------------

`ifdef ARM_ASSERT_ON
   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------

 `include "std_ovl_defines.h"

   // --------
   // DATAHINT[1] indicates that core load is fixed <=1020 offset from PC.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Literal loads must be within 1020 bytes of PC"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_literal_load_near_pc
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(hready_i & htrans_o[1] & ~hmaster_o & hprot_o[0] &
                       data_hint_o[1]),
      .consequent_expr(( haddr_o[31:0] > ({iaex_o[30:0],1'b0}) ) &
                       ( haddr_o[31:0] <= ({iaex_o[30:0],1'b0} + 1020 + 4) )),
      .fire());

   // --------
   // Addresses above 0xE0000000 are always execute-never.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Core can never fetch above 0xE0000000"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_e_or_f_always_xn
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(hready_i & htrans_o[1] & ~hmaster_o & ~hprot_o[0]),
      .consequent_expr(haddr_o[31:29] != 3'b111),
      .fire());

   // --------
   // Addresses within 0xE??????? are always handled internally.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Addresses prefixed with 0xE always handled internally"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_e_always_internal
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(hready_i & htrans_o[1]),
      .consequent_expr(haddr_o[31:28] != 4'hE),
      .fire());

   // --------
   // Core vector fetches must always be privileged.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Core vector fetches must always be privileged"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_cpu_vect_priv
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(hready_i & htrans_o[1] & ~hmaster_o & data_hint_o[0]),
      .consequent_expr(hprot_o[1]),
      .fire());

   // --------
   // SYSRESETREQ has no clear term, thus once set it will remain set until
   // reset.

   ovl_next
     #(.severity_level(`OVL_FATAL),
       .num_cks(1),
       .check_overlapping(1),
       .check_missing_start(0),
       .property_type(`OVL_ASSERT),
       .msg("SYSRESETREQ must remain high until reset occurs"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_sys_reset_req_maintain
     (.clock           (sclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .start_event     (sys_reset_req_o),
      .test_expr       (sys_reset_req_o),
      .fire            ());

   // --------
   // To support tracing via the Micro-Trace-Buffer, it must be guaranteed that
   // the PC will not be updated twice in a two-cycle window.

   ovl_next
     #(.severity_level      (`OVL_FATAL),
       .num_cks             (1),
       .check_overlapping   (1),
       .check_missing_start (0),
       .property_type       (`OVL_ASSERT),
       .msg                 ("Can not have two branches in two cycles"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
   u_asrt_mtb_double_nonseq_fetch
     (.clock                (sclk),
      .reset                (hreset_n),
      .enable               (1'b1),
      .start_event          (iaex_en_o & ~iaex_seq_o),
      .test_expr            (~(iaex_en_o & ~iaex_seq_o)),
      .fire                 ());

   // --------
   // PC can never change whilst in Lockup state.

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(`OVL_ASSERT),
    .msg("Execution address cannot change whilst in Lockup"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
   u_asrt_mtb_lockup_no_iaexen
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(lockup_o),
      .consequent_expr(~iaex_en_o),
      .fire());

   // --------
   // To prevent the Micro-Trace-Buffer being flooded, Lockup should not
   // produce multiple non-sequentials to the Lockup address.

  ovl_implication
  #(.severity_level(`OVL_FATAL),
    .property_type(`OVL_ASSERT),
    .msg("Lockup should not repeatedly indicate branch"),
    .coverage_level(`OVL_COVER_DEFAULT),
    .clock_edge(`OVL_POSEDGE),
    .reset_polarity(`OVL_ACTIVE_LOW),
    .gating_type(`OVL_GATE_NONE))
   u_asrt_mtb_lockup_iaex_seq_always
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(lockup_o),
      .consequent_expr(iaex_seq_o),
      .fire());

   // --------
   // Generate assertions relating to debug only if implemented.

   generate
      if ((CBAW != 0) || (DBG != 0)) begin: gen_ovl_dbg1

         // --------
         // Debugger CPUID read must always return correct value.

         ovl_implication
           #(.severity_level(`OVL_FATAL),
             .property_type(`OVL_ASSERT),
             .msg("CPUID must always be readable by debugger"),
             .coverage_level(`OVL_COVER_DEFAULT),
             .clock_edge(`OVL_POSEDGE),
             .reset_polarity(`OVL_ACTIVE_LOW),
             .gating_type(`OVL_GATE_NONE))
         u_asrt_dbg_cpuid
           (.clock(dclk),
            .reset(dbg_reset_n),
            .enable(1'b1),
            .antecedent_expr(gen_dbg1.u_dbg.dsl_cid_sels_o[0]),
            .consequent_expr(slv_rdata_o[31:0] ==
                             u_sys.u_matrix.u_sel.val_cpuid[31:0]),
            .fire());

         // --------
         // Accesses by the CPU and the debugger can never be coincident.

         ovl_implication
           #(.severity_level (`OVL_FATAL),
             .property_type  (`OVL_ASSERT),
             .msg            ("CPU and Debug access never coincident"),
             .coverage_level (`OVL_COVER_DEFAULT),
             .clock_edge     (`OVL_POSEDGE),
             .reset_polarity (`OVL_ACTIVE_LOW),
             .gating_type    (`OVL_GATE_NONE))
         u_asrt_cpu_dbg_dphase_mutex
           (.clock           (dclk),
            .reset           (dbg_reset_n),
            .enable          (1'b1),
            .antecedent_expr (u_sys.u_matrix.cpu_dphase_q),
            .consequent_expr (~gen_dbg1.u_dbg.u_if.dphase_q |
                              gen_dbg1.u_dbg.u_if.slv_resp),
            .fire());

         // --------
         // Accesses by the debugger and the CPU can never be coincident.

         ovl_implication
           #(.severity_level   (`OVL_FATAL),
             .property_type    (`OVL_ASSERT),
             .msg              ("Debug and CPU access never coincident"),
             .coverage_level   (`OVL_COVER_DEFAULT),
             .clock_edge       (`OVL_POSEDGE),
             .reset_polarity   (`OVL_ACTIVE_LOW),
             .gating_type      (`OVL_GATE_NONE))
         u_asrt_dbg_cpu_dphase_mutex
           ( .clock            (dclk),
             .reset            (dbg_reset_n),
             .enable           (1'b1),
             .antecedent_expr  (gen_dbg1.u_dbg.u_if.dphase_q &
                                ~gen_dbg1.u_dbg.u_if.slv_resp),
             .consequent_expr  (~u_sys.u_matrix.cpu_dphase_q),
             .fire());

         // --------
         // If the core is SLEEPING, then the AHB must still be available.

         ovl_implication
           #(.severity_level   (`OVL_FATAL),
             .property_type    (`OVL_ASSERT),
             .msg              ("Sleeping must not stall SLV port"),
             .coverage_level   (`OVL_COVER_DEFAULT),
             .clock_edge       (`OVL_POSEDGE),
             .reset_polarity   (`OVL_ACTIVE_LOW),
             .gating_type      (`OVL_GATE_NONE))
         u_asrt_dbg_cpu_sleep_no_stall
           ( .clock            (dclk),
             .reset            (dbg_reset_n),
             .enable           (1'b1),
             .antecedent_expr  (sleeping_o),
             .consequent_expr  (~u_sys.u_matrix.cpu_spec_htrans_i &
                                ~u_sys.u_matrix.cpu_dbg_stall_i),
             .fire());

      end
   endgenerate

   // --------
   // Generate assertions relating to the IO port only if it is functional.

  generate
     if ((CBAW != 0) || (IOP != 0)) begin: gen_ovl_iop1

        // --------
        // IOMATCH is always low in ARMv6M defined System Control Space.

        ovl_implication
          #(.severity_level (`OVL_FATAL),
            .property_type  (`OVL_ASSERT),
            .msg            ("IOMATCH must not hit in System region"),
            .coverage_level (`OVL_COVER_DEFAULT),
            .clock_edge     (`OVL_POSEDGE),
            .reset_polarity (`OVL_ACTIVE_LOW),
            .gating_type    (`OVL_GATE_NONE))
        u_asrt_iomatch_not_in_system
          ( .clock           (hclk),
            .reset           (1'b1),
            .enable          (1'b1),
            .antecedent_expr (io_check_o[31:28] == 4'hE),
            .consequent_expr (~io_match_i),
            .fire            ());

     end
  endgenerate

   // --------
   // Generate assertions relating to the IO port with debug present.

  generate
     if ((CBAW != 0) || ((IOP != 0) && (DBG != 0))) begin: gen_ovl_iop_dbg

        // --------
        // SLVREADY must go high when a SLV access to IOP completes.

        ovl_implication
          #(.severity_level (`OVL_FATAL),
            .property_type  (`OVL_ASSERT),
            .msg            ({"SLVREADY must go high when a SLV access to IOP",
                              " completes"}),
            .coverage_level (`OVL_COVER_DEFAULT),
            .clock_edge     (`OVL_POSEDGE),
            .reset_polarity (`OVL_ACTIVE_LOW),
            .gating_type    (`OVL_GATE_NONE))
        u_asrt_slv_to_io_slvready
          ( .clock           (hclk),
            .reset           (hreset_n),
            .enable          (1'b1),
            .antecedent_expr (io_trans_o & io_master_o),
            .consequent_expr (slv_ready_o),
            .fire            ());

        // --------
        // IO control must match SLV control for SLV accesses to IOP.
        // Also checks that there is no SLV IOP access if there hasn't been a
        // SLV access.

        reg  [35:0] a_slv_ctl_q; //32+1+2+1=36
        always @(posedge dclk)
           if (slv_ready_o)
              a_slv_ctl_q <= ~slv_trans_i[1] ? {36{1'b1}} : //illegal ctl value
                             {slv_addr_i,slv_write_i,slv_size_i,slv_prot_i[1]};

        wire [35:0] a_io_ctl = {io_addr_o,io_write_o,io_size_o,io_priv_o};

        ovl_implication
          #(.severity_level (`OVL_FATAL),
            .property_type  (`OVL_ASSERT),
            .msg            ("IO ctl must match SLV ctl for SLV IOP accesses"),
            .coverage_level (`OVL_COVER_DEFAULT),
            .clock_edge     (`OVL_POSEDGE),
            .reset_polarity (`OVL_ACTIVE_LOW),
            .gating_type    (`OVL_GATE_NONE))
        u_asrt_slv_to_io_ctl
          ( .clock           (hclk),
            .reset           (hreset_n),
            .enable          (1'b1),
            .antecedent_expr (io_trans_o & io_master_o),
            .consequent_expr (a_io_ctl == a_slv_ctl_q),
            .fire            ());

        // --------
        // IOWDATA must match SLVWDATA for SLV writes to IOP.

        // handle sub-word replication; SLV accesses always little-endian
        wire [ 7:0] a_slv_wdata_b  =
           (io_addr_o[1:0] == 2'd3) ? slv_wdata_i[31:24] :
           (io_addr_o[1:0] == 2'd2) ? slv_wdata_i[23:16] :
           (io_addr_o[1:0] == 2'd1) ? slv_wdata_i[15: 8] :
                                      slv_wdata_i[ 7: 0];
        wire [15:0] a_slv_wdata_hw = io_addr_o[1] ? slv_wdata_i[31:16] :
                                                    slv_wdata_i[15: 0];

        wire a_io_slv_wdata_match = io_wdata_o == (
           (io_size_o == 2'd0) ? {4{a_slv_wdata_b }} :
           (io_size_o == 2'd1) ? {2{a_slv_wdata_hw}} :
                                 slv_wdata_i
        );

        ovl_implication
          #(.severity_level (`OVL_FATAL),
            .property_type  (`OVL_ASSERT),
            .msg            ("IOWDATA must match SLVWDATA for SLV IOP writes"),
            .coverage_level (`OVL_COVER_DEFAULT),
            .clock_edge     (`OVL_POSEDGE),
            .reset_polarity (`OVL_ACTIVE_LOW),
            .gating_type    (`OVL_GATE_NONE))
        u_asrt_slv_to_io_wdata
          ( .clock           (hclk),
            .reset           (hreset_n),
            .enable          (1'b1),
            .antecedent_expr (io_trans_o & io_master_o & io_write_o),
            .consequent_expr (a_io_slv_wdata_match),
            .fire            ());

        // --------
        // SLVRDATA must match IORDATA for SLV reads to IOP.

        ovl_implication
          #(.severity_level (`OVL_FATAL),
            .property_type  (`OVL_ASSERT),
            .msg            ("SLVRDATA must match IORDATA for SLV IOP reads"),
            .coverage_level (`OVL_COVER_DEFAULT),
            .clock_edge     (`OVL_POSEDGE),
            .reset_polarity (`OVL_ACTIVE_LOW),
            .gating_type    (`OVL_GATE_NONE))
        u_asrt_slv_to_io_rdata
          ( .clock           (hclk),
            .reset           (hreset_n),
            .enable          (1'b1),
            .antecedent_expr (io_trans_o & io_master_o & ~io_write_o),
            .consequent_expr (slv_rdata_o == io_rdata_i),
            .fire            ());

     end
  endgenerate

   //--------------------------------------------------------------------------

`endif

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
