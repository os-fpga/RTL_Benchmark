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
//   Checked In : $Date: 2012-10-15 17:49:01 +0100 (Mon, 15 Oct 2012) $
//   Revision   : $Revision: 225463 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ INTEGRATION EXAMPLE LEVEL
// ====================================
// This module provides a working example integration of the CORTEX-M0+
// processor, the CORTEX-M0+ DAP and the CORTEX-M0+ profile WIC. It is designed
// to be a ready-to-use level of hierarchy to facilitate easy deployment of
// the CORTEX-M0+ processor. You can modify this module to suit your particular
// system requirements.
//-----------------------------------------------------------------------------

module CM0PINTEGRATION
  #(
    // ------------------------------------------------------------------------
    // CORTEX-M0+ INTEGRATION PER-INSTANCE PARAMETERIZATION:
    // ------------------------------------------------------------------------
    parameter ACG      =  1,      // Architectural clock gating:
                                  //   0 = absent
                                  //   1 = present
    // ------------------------------------------------------------------------
    parameter BE       =  0,      // Data transfer endianess:
                                  //   0 = little-endian
                                  //   1 = byte-invariant big-endian
    // ------------------------------------------------------------------------
    parameter BKPT     =  4,      // Number of breakpoint comparators:
                                  //   0 = none
                                  //   1 = one
                                  //   2 = two
                                  //   3 = three
                                  //   4 = four
    // ------------------------------------------------------------------------
    parameter DBG      =  1,      // Debug configuration:
                                  //   0 = no debug support
                                  //   1 = implement debug support
    // ------------------------------------------------------------------------
    parameter HWF      =  0,      // Half-word fetch only:
                                  //   0 = Favor 32-bit word fetching
                                  //   1 = Only fetch 16-bits per cycle
    // ------------------------------------------------------------------------
    parameter IOP      =  0,      // I/O port interface:
                                  //   0 = no I/O support
                                  //   1 = I/O port interface
    // ------------------------------------------------------------------------
    parameter IRQDIS   = 32'h00000000,
                                  // IRQ disable support:
                                  //  IRQDIS[i] disables IRQ[i], e.g.
                                  //   32'h00000000 = No IRQ disabled
                                  //          .     . ...
                                  //   32'h0000FFFF = IRQ[15:0] disabled
    // ------------------------------------------------------------------------
    parameter MPU      =  0,      // MPU implemented regions:
                                  //   0 = none, no MPU implemented
                                  //   8 = eight MPU regions implemented
    // ------------------------------------------------------------------------
    parameter NUMIRQ   = 32,      // Functional IRQ lines:
                                  //   0 = none
                                  //   1 = IRQ[0]
                                  //   2 = IRQ[1:0]
                                  //   . . ...
                                  //  32 = IRQ[31:0]
    // ------------------------------------------------------------------------
    parameter RAR      =  0,      // Reset-all-register option:
                                  //   0 = standard, architectural reset
                                  //   1 = extended, all register reset
    // ------------------------------------------------------------------------
    parameter SMUL     =  0,      // Multiplier configuration:
                                  //   0 = MULS is single cycle (fast)
                                  //   1 = MULS takes 32-cycles (small)
    // ------------------------------------------------------------------------
    parameter SYST     =  1,      // SysTick timer option:
                                  //   0 = SysTick not present
                                  //   1 = SysTick present
    // ------------------------------------------------------------------------
    parameter USER     =  0,      // User/privilege support:
                                  //   0 = absent - Privilege mode only
                                  //   1 = present
    // ------------------------------------------------------------------------
    parameter VTOR     =  0,      // Vector Table Offset Register:
                                  //   0 = absent
                                  //   1 = present
    // ------------------------------------------------------------------------
    parameter WIC      =  1,      // Wake-up interrupt controller support:
                                  //   0 = no support
                                  //   1 = WIC deep-sleep supported
    // ------------------------------------------------------------------------
    parameter WICLINES = 34,      // Supported WIC lines:
                                  //   2 = NMI and RXEV
                                  //   3 = NMI, RXEV and IRQ[0]
                                  //   4 = NMI, RXEV and IRQ[1:0]
                                  //   . . ...
                                  //  34 = NMI, RXEV and IRQ[31:0]
    // ------------------------------------------------------------------------
    parameter WPT      =  2,      // Number of DWT comparators:
                                  //   0 = none
                                  //   1 = one
                                  //   2 = two
    // ------------------------------------------------------------------------
    // The following parameters are for the DAP
    // ------------------------------------------------------------------------
    parameter BASEADDR =  32'hE00FF003,
                                  // Allows configuration of the ROM table
                                  // base address which is read from the
                                  // AP during debug sessions. If the default
                                  // configuration is used the value should
                                  // be left at 32'hE00FF003.
    // ------------------------------------------------------------------------
    parameter HALTEV   =  0,      // Debug halt event
                                  //   0 = no halt event support
                                  //   1 = implement halt event support
    // ------------------------------------------------------------------------
    parameter JTAGnSW  =  0,      // Debug port interface:
                                  //   0 = SerialWire interface
                                  //   1 = JTAG interface
    // ------------------------------------------------------------------------
    parameter SWMD     =  0,      // For Serial Wire support protocol 2 and
                                  // and multi-drop
                                  //   0 = none
                                  //   1 = Serial Wire protocol 2
    // ------------------------------------------------------------------------
    parameter TARGETID =  32'h00000001)
                                  // 31:28=TREVISION 27:12=TPARTNO
                                  // 11:1=TDESIGNER 0=1
    // ------------------------------------------------------------------------

    (// CLOCK AND RESETS
     input  wire        FCLK,           // Free running clock for WIC
     input  wire        SCLK,           // System clock - gated FCLK
     input  wire        HCLK,           // AHB clock    - gated SCLK
     input  wire        DCLK,           // Debug clock  - gated HCLK
     input  wire        PORESETn,       // Power-on reset
     input  wire        DBGRESETn,      // Debug logic reset
     input  wire        HRESETn,        // AHB reset
     input  wire        SWCLKTCK,       // Serial-Wire / JTAG clock
     input  wire        nTRST,          // TAP controller reset

     // AHB-LITE MASTER PORT
     output wire [31:0] HADDR,          // AHB Address
     output wire [ 2:0] HBURST,         // AHB burst sideband (always SINGLE)
     output wire        HMASTLOCK,      // AHB locked transaction (always ZERO)
     output wire [ 3:0] HPROT,          // AHB properties
     output wire [ 2:0] HSIZE,          // AHB size
     output wire [ 1:0] HTRANS,         // AHB transaction (IDLE/NSEQ only)
     output wire [31:0] HWDATA,         // AHB write-data
     output wire        HWRITE,         // AHB write not read
     input  wire [31:0] HRDATA,         // AHB read-data
     input  wire        HREADY,         // AHB ready / advance
     input  wire        HRESP,          // AHB error response
     output wire        HMASTER,        // AHB master (0=Core, 1=Debugger)
     output wire        SHAREABLE,      // AHB transaction is shareable

     // CODE SEQUENTIALITY AND SPECULATION
     output wire        CODENSEQ,       // Fetch sequential to last
     output wire [ 3:0] CODEHINT,       // Code hints
     output wire        SPECHTRANS,     // Speculative HTRANS[1]

     // DATA ACCESS HINTS
     output wire [ 1:0] DATAHINT,       // Data hints

     // DEBUG
     input  wire        SWDITMS,        // Serial-Wire data-in / JTAG TMS
     input  wire        TDI,            // JTAG TDI
     output wire        SWDO,           // Serial-Wire data-out
     output wire        SWDOEN,         // Serial-Wire data-enable
     output wire        SWDETECT,       // Serial-Wire detect
     output wire        TDO,            // JTAG TDO
     output wire        nTDOEN,         // JTAG TDO enable
     input  wire        DBGRESTART,     // CoreSight debug-restart
     output wire        DBGRESTARTED,   // CoreSight debug-restarted
     input  wire        EDBGRQ,         // External debug entry request
     output wire        HALTED,         // Core is in halted state
     input  wire        NIDEN,          // Non-intrusive debug enable
     input  wire        DBGEN,          // Debug enable (must be 1 to debug)

     // MISC
     input  wire        NMI,            // Non-maskable interrupt
     input  wire [31:0] IRQ,            // 32 interrupt request lines
     output wire        TXEV,           // Event output (SEV executed)
     input  wire        RXEV,           // Event input
     output wire        LOCKUP,         // Core is in Lockup state
     output wire        SYSRESETREQ,    // System reset request
     input  wire [25:0] STCALIB,        // SysTick calibration register value
     input  wire        STCLKEN,        // SysTick count enable
     input  wire [ 7:0] IRQLATENCY,     // Interrupt latency count
     input  wire [3:0]  INSTANCEID,     // DLPIDR[31:28] for Serial-Wire 2
     input  wire [27:0] ECOREVNUM,      // ARM ECO: [27:20] DAP, [19:0] core
     input  wire        CPUWAIT,        // Extend CPU reset sequence
     input  wire        SLVSTALL,       // Stall debugger accesses

     // POWER MANAGEMENT
     output wire        GATEHCLK,       // Gate HCLK request
     output wire        SLEEPING,       // Core is sleeping
     output wire        SLEEPDEEP,      // Core is sleeping and deep bit set
     output wire        WAKEUP,         // WIC request to wakeup
     output wire [33:0] WICSENSE,       // IRQ, NMI and RXEV sensitivity
     input  wire        SLEEPHOLDREQn,  // Request to hold sleep if entered
     output wire        SLEEPHOLDACKn,  // Acknowledgement that sleep is held
     input  wire        WICENREQ,       // Request to enable WIC
     output wire        WICENACK,       // Acknowledgement that WIC is enabled
     output wire        CDBGPWRUPREQ,   // Debug power up request
     input  wire        CDBGPWRUPACK,   // Debug power up acknowledged

     // I/O Port
     input wire         IOMATCH,        // Indicates IOCHECK within I/O region
     input wire  [31:0] IORDATA,        // IO port read-data
     output wire        IOTRANS,        // IO transaction
     output wire        IOWRITE,        // IO write not read
     output wire [31:0] IOCHECK,        // IO address query
     output wire [31:0] IOADDR,         // IO transaction address
     output wire [ 1:0] IOSIZE,         // IO transaction size
     output wire        IOMASTER,       // IO initiator (0=Core, 1=Debugger)
     output wire        IOPRIV,         // IO transaction privilege
     output wire [31:0] IOWDATA,        // IO write-data

     // MTB Trace
     output wire        IAEXSEQ,        // Instruction address sequential
     output wire        IAEXEN,         // Instruction address being updated
     output wire [30:0] IAEX,           // Current instruciton address
     output wire        ATOMIC,         // Processor in special state

     // SCAN IO
     input  wire        DFTSE,          // DFT scan enable
     input  wire        DFTRSTDISABLE,  // DFT reset disable

     // SRPG IO (no RTL-level function)
     input  wire        SYSRETAINn,     // Power specific controls
     input  wire        SYSISOLATEn,    // ...
     input  wire        SYSPWRDOWN,     // ...
     output wire        SYSPWRDOWNACK,  // ...
     input  wire        DBGISOLATEn,    // ...
     input  wire        DBGPWRDOWN,     // ...
     output wire        DBGPWRDOWNACK); // ...

   // -------------------------------------------------------------------------
   // Define sub-module interconnect wires
   // -------------------------------------------------------------------------

   wire        gate_hclk;           // AHB clock gating permitted

   wire [31:0] slv_rdata;           // Core -> DAP read data
   wire        slv_ready;           // Core -> DAP bus ready
   wire        slv_resp;            // Core -> DAP error response
   wire [31:0] slv_addr;            // DAP -> Core address
   wire [31:0] slv_wdata;           // DAP -> Core write-data
   wire [ 1:0] slv_trans;           // DAP -> Core transaction request
   wire        slv_write;           // DAP -> Core write not read
   wire [ 3:0] slv_prot;            // DAP -> Core sideband
   wire [ 1:0] slv_size;            // DAP -> Core transaction size

   wire        wic_clear;           // NVIC -> WIC clear
   wire        wic_ds_req_n;        // WIC  -> NVIC mode request
   wire        wic_ds_ack_n;        // NVIC -> WIC mode acknowledge
   wire        wic_load;            // NVIC -> WIC load
   wire [31:0] wic_mask_isr;        // NVIC -> WIC IRQs mask
   wire        wic_mask_nmi;        // NVIC -> WIC NMI mask
   wire        wic_mask_rxev;       // NVIC -> WIC RXEV mask

   wire [31:0] irq_pend;            // WIC -> NVIC Interrupt pend lines
   wire        nmi_pend;            // WIC -> NVIC NMI pend lines
   wire        rxev_pend;           // WIC -> NVIC Event pend lines

   wire [33:0] wic_sense;           // WIC sensitivity output

   // -------------------------------------------------------------------------
   // CORTEX-M0+ processor instantiation
   // -------------------------------------------------------------------------

   CORTEXM0PLUSIMP
     #(.ACG      (ACG),
       .AHBSLV   (0),
       .BE       (BE),
       .BKPT     (BKPT),
       .DBG      (DBG),
       .HWF      (HWF),
       .IOP      (IOP),
       .IRQDIS   (IRQDIS),
       .MPU      (MPU),
       .NUMIRQ   (NUMIRQ),
       .RAR      (RAR),
       .SMUL     (SMUL),
       .SYST     (SYST),
       .USER     (USER),
       .VTOR     (VTOR),
       .WIC      (WIC),
       .WICLINES (WICLINES),
       .WPT      (WPT))
   u_imp
     (// Outputs
      .HADDR                          (HADDR[31:0]),
      .HBURST                         (HBURST[2:0]),
      .HMASTLOCK                      (HMASTLOCK),
      .HPROT                          (HPROT[3:0]),
      .HSIZE                          (HSIZE[2:0]),
      .HTRANS                         (HTRANS[1:0]),
      .HWDATA                         (HWDATA[31:0]),
      .HWRITE                         (HWRITE),
      .HMASTER                        (HMASTER),
      .SHAREABLE                      (SHAREABLE),
      .SLVRDATA                       (slv_rdata[31:0]),
      .SLVREADY                       (slv_ready),
      .SLVRESP                        (slv_resp),
      .DBGRESTARTED                   (DBGRESTARTED),
      .HALTED                         (HALTED),
      .TXEV                           (TXEV),
      .LOCKUP                         (LOCKUP),
      .SYSRESETREQ                    (SYSRESETREQ),
      .CODENSEQ                       (CODENSEQ),
      .CODEHINT                       (CODEHINT[3:0]),
      .SPECHTRANS                     (SPECHTRANS),
      .DATAHINT                       (DATAHINT[1:0]),
      .SLEEPING                       (SLEEPING),
      .SLEEPDEEP                      (SLEEPDEEP),
      .SLEEPHOLDACKn                  (SLEEPHOLDACKn),
      .WICDSACKn                      (wic_ds_ack_n),
      .WICMASKISR                     (wic_mask_isr[31:0]),
      .WICMASKNMI                     (wic_mask_nmi),
      .WICMASKRXEV                    (wic_mask_rxev),
      .WICLOAD                        (wic_load),
      .WICCLEAR                       (wic_clear),
      .IOTRANS                        (IOTRANS),
      .IOWRITE                        (IOWRITE),
      .IOCHECK                        (IOCHECK),
      .IOADDR                         (IOADDR),
      .IOSIZE                         (IOSIZE),
      .IOMASTER                       (IOMASTER),
      .IOPRIV                         (IOPRIV),
      .IOWDATA                        (IOWDATA),
      .IAEXEN                         (IAEXEN),
      .IAEXSEQ                        (IAEXSEQ),
      .IAEX                           (IAEX),
      .ATOMIC                         (ATOMIC),

      // Inputs
      .SCLK                           (SCLK),
      .HCLK                           (HCLK),
      .DCLK                           (DCLK),
      .DBGRESETn                      (DBGRESETn),
      .HRESETn                        (HRESETn),
      .HRDATA                         (HRDATA[31:0]),
      .HREADY                         (HREADY),
      .HRESP                          (HRESP),
      .SLVADDR                        (slv_addr[31:0]),
      .SLVPROT                        (slv_prot[3:0]),
      .SLVSIZE                        (slv_size[1:0]),
      .SLVSTALL                       (SLVSTALL),
      .SLVTRANS                       (slv_trans[1:0]),
      .SLVWDATA                       (slv_wdata[31:0]),
      .SLVWRITE                       (slv_write),
      .DBGRESTART                     (DBGRESTART),
      .EDBGRQ                         (EDBGRQ),
      .NIDEN                          (NIDEN),
      .DBGEN                          (DBGEN),
      .NMI                            (nmi_pend),
      .IRQ                            (irq_pend[31:0]),
      .RXEV                           (rxev_pend),
      .STCALIB                        (STCALIB[25:0]),
      .STCLKEN                        (STCLKEN),
      .IRQLATENCY                     (IRQLATENCY[7:0]),
      .ECOREVNUM                      (ECOREVNUM[19:0]),
      .CPUWAIT                        (CPUWAIT),
      .SLEEPHOLDREQn                  (SLEEPHOLDREQn),
      .WICDSREQn                      (wic_ds_req_n),
      .IOMATCH                        (IOMATCH),
      .IORDATA                        (IORDATA),
      .DFTSE                          (DFTSE),
      .SYSRETAINn                     (SYSRETAINn),
      .SYSISOLATEn                    (SYSISOLATEn),
      .SYSPWRDOWN                     (SYSPWRDOWN),
      .SYSPWRDOWNACK                  (SYSPWRDOWNACK),
      .DBGISOLATEn                    (DBGISOLATEn),
      .DBGPWRDOWN                     (DBGPWRDOWN),
      .DBGPWRDOWNACK                  (DBGPWRDOWNACK));

   generate
      if (DBG == 1) begin : gen_dap

         // --------
         // Intermediate wires to avoid assigning parameters directly to ports.

         wire [31:0] base_addr = BASEADDR;
         wire [31:0] target_id = TARGETID;

         // -------------------------------------------------------------------
         // Reset synchronizer for dp_reset
         // -------------------------------------------------------------------

         // Synchronize DAP DP reset:

         wire        dp_reset_n;

         cm0p_dbg_reset_sync
           u_dpreset_sync
             (.RSTIN         (PORESETn),
              .CLK           (SWCLKTCK),
              .DFTSE         (DFTSE),
              .DFTRSTDISABLE (DFTRSTDISABLE),
              .RSTOUT        (dp_reset_n));

         // -------------------------------------------------------------------
         // CORTEX-M0+ debug-access-port instantiation
         // -------------------------------------------------------------------

         CM0PDAP
           #(.JTAGnSW  (JTAGnSW),
             .SWMD     (SWMD),
             .USER     (USER),
             .MPU      (MPU),
             .HALTEV   (HALTEV),
             .RAR      (RAR))
         u_dap
           (// Outputs
            .SWDO                           (SWDO),
            .SWDOEN                         (SWDOEN),
            .SWDETECT                       (SWDETECT),
            .TDO                            (TDO),
            .nTDOEN                         (nTDOEN),
            .CDBGPWRUPREQ                   (CDBGPWRUPREQ),
            .SLVADDR                        (slv_addr[31:0]),
            .SLVWDATA                       (slv_wdata[31:0]),
            .SLVTRANS                       (slv_trans[1:0]),
            .SLVWRITE                       (slv_write),
            .SLVPROT                        (slv_prot[3:0]),
            .SLVSIZE                        (slv_size[1:0]),

            // Inputs
            .SWCLKTCK                       (SWCLKTCK),
            .nTRST                          (nTRST),
            .DPRESETn                       (dp_reset_n),
            .APRESETn                       (DBGRESETn),
            .SWDITMS                        (SWDITMS),
            .TDI                            (TDI),
            .HALTED                         (HALTED),
            .CDBGPWRUPACK                   (CDBGPWRUPACK),
            .DEVICEEN                       (1'b1),
            .DCLK                           (DCLK),
            .SLVRDATA                       (slv_rdata[31:0]),
            .SLVREADY                       (slv_ready),
            .SLVRESP                        (slv_resp),
            .BASEADDR                       (base_addr[31:0]),
            .TARGETID                       (target_id[31:0]),
            .INSTANCEID                     (INSTANCEID),
            .ECOREVNUM                      (ECOREVNUM[27:20]),
            .DFTSE                          (DFTSE));

         // -------------------------------------------------------------------
         // Generate signal that can be used to gate system clock
         // -------------------------------------------------------------------

         // HCLK to core (and system) may be gated if the core is sleeping, and
         // there is no chance of a debug transaction.

         assign gate_hclk = ((SLEEPING | ~SLEEPHOLDACKn) &
                             ~CDBGPWRUPACK );

      end else begin : gen_no_dap

         // -------------------------------------------------------------------
         // Tie off key debug signals if no debug is implemented
         // -------------------------------------------------------------------

         assign slv_addr     = {32{1'b0}};
         assign slv_wdata    = {32{1'b0}};
         assign slv_trans    = {2{1'b0}};
         assign slv_write    = 1'b0;
         assign slv_prot     = {4{1'b0}};
         assign slv_size     = {2{1'b0}};
         assign CDBGPWRUPREQ = 1'b0;
         assign SWDO         = 1'b0;
         assign SWDOEN       = 1'b0;
         assign SWDETECT     = 1'b0;
         assign TDO          = 1'b0;
         assign nTDOEN       = 1'b1;

         wire [33:0] unused = { slv_rdata[31:0], slv_ready, slv_resp };

         // -------------------------------------------------------------------
         // Generate signal that can be used to gate system clock
         // -------------------------------------------------------------------

         // HCLK to core (and system) may be gated if the core is sleeping.

         assign gate_hclk = (SLEEPING | ~SLEEPHOLDACKn);

      end
   endgenerate

   // -------------------------------------------------------------------------
   // CORTEX-M0+ wake-up interrupt controller instantiation
   // -------------------------------------------------------------------------

   generate
      if (WIC != 0) begin: gen_wic1

   // -------------------------------------------------------------------------
         cm0p_wic
           #(.IRQDIS (IRQDIS), .WICLINES(WICLINES))
         u_wic
           (// Outputs
            .WAKEUP                         (WAKEUP),
            .WICSENSE                       (wic_sense[33:0]),
            .WICPENDISR                     (irq_pend),
            .WICPENDNMI                     (nmi_pend),
            .WICPENDRXEV                    (rxev_pend),
            .WICDSREQn                      (wic_ds_req_n),
            .WICENACK                       (WICENACK),
            // Inputs
            .FCLK                           (FCLK),
            .RESETn                         (HRESETn),
            .WICLOAD                        (wic_load),
            .WICCLEAR                       (wic_clear),
            .IRQ                            (IRQ[31:0]),
            .NMI                            (NMI),
            .RXEV                           (RXEV),
            .WICMASKISR                     (wic_mask_isr[31:0]),
            .WICMASKNMI                     (wic_mask_nmi),
            .WICMASKRXEV                    (wic_mask_rxev),
            .WICENREQ                       (WICENREQ),
            .WICDSACKn                      (wic_ds_ack_n));

      end else begin: gen_wic0

         assign WAKEUP       = 1'b0;
         assign wic_sense    = {34{1'b0}};
         assign irq_pend     = IRQ;
         assign nmi_pend     = NMI;
         assign rxev_pend    = RXEV;
         assign wic_ds_req_n = 1'b1;
         assign WICENACK     = 1'b0;

         wire [ 3:0] unused = { wic_ds_ack_n, wic_load, wic_clear, WICENREQ };

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Assign outputs
   // -------------------------------------------------------------------------

   assign      GATEHCLK = gate_hclk;
   assign      WICSENSE = wic_sense[33:0];

endmodule

// ----------------------------------------------------------------------------
// EOF
// ----------------------------------------------------------------------------
