//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//   Checked In : $Date: 2012-12-18 11:03:15 +0000 (Tue, 18 Dec 2012) $
//   Revision   : $Revision: 231972 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Cortex-M0+ CoreSight Processor Integration Level
// ================================================
// This module provides a working example integration of:
//  - Cortex-M0+ processor
//  - Cortex-M0+ Wake-Up Interrupt Controller (WIC)
//  - CoreSight MTB-M0+ Micro Trace Buffer (MTB)
//  - Cortex-M0+ Cross Trigger Interface (CTI)
//  - CoreSight ROM Table
// It is designed to be a ready-to-use level of hierarchy to facilitate easy
// deployment of the Cortex-M0+ processor as a subsystem in a large SoC design
// using the ARM CoreSight SoC product.
// You can modify this module to suit your particular system requirements.
//-----------------------------------------------------------------------------

module CORTEXM0PLUSINTEGRATIONCS
  #(
    // ------------------------------------------------------------------------
    // Cortex-M0+ Processor Parameterization
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
    parameter NUMIRQ   =  32,     // Functional IRQ lines:
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
    // Cortex-M0+ CTI Parameterization
    // ------------------------------------------------------------------------
    parameter CTI      =  1,      // Cross Trigger Interface option:
                                  //   0 = absent
                                  //   1 = present
    // ------------------------------------------------------------------------
    // CoreSight MTB-M0+ Parameterization
    // ------------------------------------------------------------------------
    parameter AWIDTH   =  32,     // Micro Trace Buffer SRAM address width:
                                  //   5 to 32
    // ------------------------------------------------------------------------
    parameter MTB      =  0)      // Micro Trace Buffer option:
                                  //   0 = absent
                                  //   1 = present
    // ------------------------------------------------------------------------

    (// CLOCK AND RESETS
     input  wire        FCLK,           // Free running clock for WIC
     input  wire        SCLK,           // System clock - gated FCLK
     input  wire        HCLK,           // AHB clock    - gated SCLK
     input  wire        DCLK,           // Debug clock  - gated HCLK
     input  wire        DBGRESETn,      // Debug logic reset
     input  wire        HRESETn,        // AHB reset

     // AHB-LITE EXTERNAL DEBUG SLAVE PORT (From DAP)
     input  wire [31:0] HADDREDS,       // AHB address to EDS
     input  wire [ 2:0] HBURSTEDS,      // AHB burst type to EDS (unused)
     input  wire        HMASTLOCKEDS,   // AHB locked status to EDS (unused)
     input  wire [ 3:0] HPROTEDS,       // AHB protection control to EDS
     input  wire [ 2:0] HSIZEEDS,       // AHB transfer size to EDS
     input  wire [ 1:0] HTRANSEDS,      // AHB transfer type to EDS
     input  wire [31:0] HWDATAEDS,      // AHB write-data to EDS
     input  wire        HWRITEEDS,      // AHB write/not read to EDS
     output wire [31:0] HRDATAEDS,      // AHB read-data from EDS
     output wire        HREADYEDS,      // AHB ready/advance from EDS
     output wire        HRESPEDS,       // AHB error response from EDS

     // AHB-LITE MASTER PORT
     output wire [31:0] HADDR,          // AHB address
     output wire [ 2:0] HBURST,         // AHB burst type (always SINGLE)
     output wire        HMASTLOCK,      // AHB locked status (always ZERO)
     output wire [ 3:0] HPROT,          // AHB protection control
     output wire [ 2:0] HSIZE,          // AHB transfer size
     output wire [ 1:0] HTRANS,         // AHB transfer type (IDLE/NSEQ only)
     output wire [31:0] HWDATA,         // AHB write-data
     output wire        HWRITE,         // AHB write/not read
     input  wire [31:0] HRDATA,         // AHB read-data
     input  wire        HREADY,         // AHB ready/advance
     input  wire        HRESP,          // AHB error response
     output wire        HMASTER,        // AHB master (0=Core, 1=Debugger)
     output wire        SHAREABLE,      // AHB transaction is shareable

     // AHB-LITE DEBUG COMPONENT SLAVE PORT
     input  wire [31:0] HADDRDCS,       // AHB address to DCS
     input  wire [ 2:0] HBURSTDCS,      // AHB burst type to DCS
     input  wire        HMASTLOCKDCS,   // AHB locked status to DCS
     input  wire [ 3:0] HPROTDCS,       // AHB protection control to DCS
     input  wire [ 2:0] HSIZEDCS,       // AHB transfer size to DCS
     input  wire [ 1:0] HTRANSDCS,      // AHB transfer type to DCS
     input  wire [31:0] HWDATADCS,      // AHB write-data to DCS
     input  wire        HWRITEDCS,      // AHB write/not read to DCS
     output wire [31:0] HRDATADCS,      // AHB read-data from DCS
     input  wire        HREADYDCS,      // AHB ready/advance to DCS
     output wire        HRESPDCS,       // AHB error response from DCS
     output wire        HREADYOUTDCS,   // AHB ready/advance from DCS
     input  wire        HSELDCS,        // AHB select to DCS

     // CROSS TRIGGER INTERFACE
     input  wire [ 3:0] CTICHIN,        // CTI Channel In
     output wire [ 3:0] CTICHOUT,       // CTI Channel Out
     output wire [ 1:0] CTIIRQ,         // CTI IRQ Request

     // MTB SRAM BASE
     input  wire [31:0] MTBSRAMBASE,    // MTB RAM Base address in AHB

     // EMBEDDED SRAM (MTB) INTERFACE
     output wire        RAMHCLK,        // MTB RAM clock, optionally gated
     input  wire [31:0] RAMRD,          // MTB connected RAM read-data
     output wire [AWIDTH-3:0] RAMAD,    // MTB connected RAM address
     output wire [31:0] RAMWD,          // MTB connected RAM write-data
     output wire        RAMCS,          // MTB connected RAM chip select
     output wire [ 3:0] RAMWE,          // MTB RAM byte lane write enables

     // MTB TRACE CONTROL INTERFACE
     input  wire        TSTART,         // MTB trace start
     input  wire        TSTOP,          // MTB trace stop

     // CODE SEQUENTIALITY AND SPECULATION
     output wire        CODENSEQ,       // Fetch sequential to last
     output wire [ 3:0] CODEHINT,       // Code hints
     output wire        SPECHTRANS,     // Speculative HTRANS[1]

     // DATA ACCESS HINTS
     output wire [ 1:0] DATAHINT,       // Data hints

     // DEBUG
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
     input  wire [31:0] ECOREVNUM,      // ARM ECO bits
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

     // SCAN IO
     input  wire        DFTSE,          // DFT scan enable

     // SRPG IO (no RTL-level function)
     input  wire        SYSRETAINn,     // Power specific controls
     input  wire        SYSISOLATEn,    // ...
     input  wire        SYSPWRDOWN,     // ...
     output wire        SYSPWRDOWNACK,  // ...
     input  wire        DBGISOLATEn,    // ...
     input  wire        DBGPWRDOWN,     // ...
     output wire        DBGPWRDOWNACK); // ...


   // -------------------------------------------------------------------------
   // Local Parameters - Defined by PIL Spec, must not be changed
   // -------------------------------------------------------------------------

   localparam ROMTABLEBASE = 32'hF0000000; // PIL ROM Table Base Address
   localparam CTIBASE      = 32'hF0001000; // CTI Base Address
   localparam MTBSFRBASE   = 32'hF0002000; // MTB Special Function Register Base Address


   // -------------------------------------------------------------------------
   // Define sub-module interconnect wires
   // -------------------------------------------------------------------------

   // Core
   wire        edbgrq_core;  // Core edbgrq signal from external, CTI and MTB
   wire        iaexseq;      // Core -> MTB Instruction address sequential
   wire        iaexen;       // Core -> MTB Instruction address being enabled
   wire [30:0] iaex;         // Core -> MTB Current instruction address
   wire        atomic;       // Core -> MTB Processor in non-instruction execution state
   wire        dbgrestart;
   wire        dbgrestarted;

   // WIC
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

   // MTB
   wire        idle_mtb;     // MTB ready for clock gating
   wire        dclk_mtb;     // Gated clock for MTB
   wire        edbgrq_mtb;
   wire        tstart_mtb;
   wire        tstop_mtb;

   wire [31:0] hrdata_mtb;
   wire        hresp_mtb;
   wire        hreadyout_mtb;
   wire        hsel_mtb_sfr;
   wire        hsel_mtb_sram;

   // ROM Table
   wire [31:0] hrdata_rom_table;
   wire        hresp_rom_table;
   wire        hreadyout_rom_table;
   wire        hsel_rom_table;

   // CTI
   wire        edbgrq_cti;  // EDBGRQ generated by CTI
   wire        tstart_cti;  // MTB Trace Start generated by CTI
   wire        tstop_cti;   // MTB Trace Stop generated by CTI

   wire [31:0] hrdata_cti;
   wire        hresp_cti;
   wire        hreadyout_cti;
   wire        hsel_cti;


   // -------------------------------------------------------------------------
   // Tie off unused signals to facilitate linting.
   // -------------------------------------------------------------------------

   wire [12:0] unused = { HBURSTEDS[2:0], HMASTLOCKEDS, HPROTEDS[3:0],
                          HSIZEEDS[2], HTRANS[0], HSIZE[2], HPROT[3:2] };


   // -------------------------------------------------------------------------
   // Cortex-M0+ processor instantiation
   // -------------------------------------------------------------------------

   CORTEXM0PLUSIMP
     #(.ACG      (ACG),
       .AHBSLV   (1),
       .BE       (BE),
       .BKPT     (BKPT),
       .DBG      (1),
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
      .SLVRDATA                       (HRDATAEDS[31:0]),
      .SLVREADY                       (HREADYEDS),
      .SLVRESP                        (HRESPEDS),
      .DBGRESTARTED                   (dbgrestarted),
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
      .IAEXEN                         (iaexen),
      .IAEXSEQ                        (iaexseq),
      .IAEX                           (iaex),
      .ATOMIC                         (atomic),

      // Inputs
      .SCLK                           (SCLK),
      .HCLK                           (HCLK),
      .DCLK                           (DCLK),
      .DBGRESETn                      (DBGRESETn),
      .HRESETn                        (HRESETn),
      .HRDATA                         (HRDATA[31:0]),
      .HREADY                         (HREADY),
      .HRESP                          (HRESP),
      .SLVADDR                        (HADDREDS[31:0]),
      .SLVPROT                        (HPROTEDS[3:0]),
      .SLVSIZE                        (HSIZEEDS[1:0]),
      .SLVSTALL                       (SLVSTALL),
      .SLVTRANS                       (HTRANSEDS[1:0]),
      .SLVWDATA                       (HWDATAEDS[31:0]),
      .SLVWRITE                       (HWRITEEDS),
      .DBGRESTART                     (dbgrestart),
      .EDBGRQ                         (edbgrq_core),
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


   assign GATEHCLK    = (SLEEPING | ~SLEEPHOLDACKn);
   assign edbgrq_core = EDBGRQ | edbgrq_mtb | edbgrq_cti;


   // -------------------------------------------------------------------------
   // Cortex-M0+ wake-up interrupt controller instantiation
   // -------------------------------------------------------------------------

   generate
      if (WIC != 0) begin: gen_wic1

         cm0p_wic
           #(.IRQDIS (IRQDIS), .WICLINES(WICLINES))
         u_wic
           (// Outputs
            .WAKEUP                         (WAKEUP),
            .WICSENSE                       (WICSENSE[33:0]),
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
         assign WICSENSE     = {34{1'b0}};
         assign irq_pend     = IRQ;
         assign nmi_pend     = NMI;
         assign rxev_pend    = RXEV;
         assign wic_ds_req_n = 1'b1;
         assign WICENACK     = 1'b0;

         wire [ 3:0] unused_wic0 = { wic_ds_ack_n, wic_load, wic_clear,
                                     WICENREQ };

      end
   endgenerate


   // -------------------------------------------------------------------------
   // Cortex-M0+ Micro Trace Buffer instantiation
   // -------------------------------------------------------------------------

   generate
      if (MTB != 0) begin: gen_mtb1

         // --------
         // Optionally instantiate a clock gate for the MTB:

         if (ACG != 0) begin: gen_mtb_acg1

            wire mtb_clock_enable = ~idle_mtb;

            cm0p_acg u_mtb_acg (.CLKIN  (DCLK),
                                .ENABLE (mtb_clock_enable),
                                .DFTSE  (DFTSE),
                                .CLKOUT (dclk_mtb));

         end else begin: gen_mtb_acg0

            assign dclk_mtb = DCLK;

         end

         // --------
         // Assign RAM clock from MTB clock:

         assign RAMHCLK = dclk_mtb;

         // -------------------------------------------------------------------
         // Optionally instantiate Micro Trace Buffer
         // -------------------------------------------------------------------

         CM0PMTB
           #(.RAR(RAR), .AWIDTH(AWIDTH), .USER(USER))
         u_cm0pmtb
           (// Outputs
            .HRDATA                         (hrdata_mtb[31:0]),
            .HREADYOUT                      (hreadyout_mtb),
            .HRESP                          (hresp_mtb),
            .RAMAD                          (RAMAD[AWIDTH-3:0]),
            .RAMWD                          (RAMWD[31:0]),
            .RAMCS                          (RAMCS),
            .RAMWE                          (RAMWE[3:0]),
            .EDBGRQ                         (edbgrq_mtb),
            .IDLE                           (idle_mtb),

            // Inputs
            .HCLK                           (dclk_mtb),
            .RESETn                         (HRESETn & DBGRESETn),
            .HADDR                          (HADDRDCS[31:0]),
            .HBURST                         (HBURSTDCS[2:0]),
            .HMASTLOCK                      (HMASTLOCKDCS),
            .HPROT                          (HPROTDCS),
            .HSIZE                          (HSIZEDCS[2:0]),
            .HTRANS                         (HTRANSDCS[1:0]),
            .HWDATA                         (HWDATADCS[31:0]),
            .HWRITE                         (HWRITEDCS),
            .HSELRAM                        (hsel_mtb_sram),
            .HSELSFR                        (hsel_mtb_sfr),
            .HREADY                         (HREADYDCS),

            .RAMRD                          (RAMRD[31:0]),
            .IAEXEN                         (iaexen),
            .IAEXSEQ                        (iaexseq),
            .IAEX                           (iaex[30:0]),
            .ATOMIC                         (atomic),
            .TSTART                         (tstart_mtb),
            .TSTOP                          (tstop_mtb),
            .NIDEN                          (NIDEN),
            .DBGEN                          (DBGEN),
            .SRAMBASEADDR                   (MTBSRAMBASE[31:0]),
            .ECOREVNUM                      (ECOREVNUM[31:28]));

      end else begin: gen_mtb0

         assign edbgrq_mtb    = 1'b0;
         assign hrdata_mtb    = {32{1'b0}};
         assign hreadyout_mtb = 1'b0;
         assign hresp_mtb     = 1'b0;
         assign RAMAD         = {(AWIDTH-2){1'b0}};
         assign RAMWD         = {32{1'b0}};
         assign RAMCS         = 1'b0;
         assign RAMWE         = {4{1'b0}};
         assign idle_mtb      = 1'b1;

      end
   endgenerate

   assign tstart_mtb = TSTART | tstart_cti;
   assign tstop_mtb  = TSTOP  | tstop_cti;


   // -------------------------------------------------------------------------
   // CoreSight ROM Table for the Integration Level
   // -------------------------------------------------------------------------

   cm0p_ahb_cs_rom_table
     #(
       // ROM Base
       .BASE            (ROMTABLEBASE),

       // ARM Cortex-M0+ CoreSight Integration Level IDs
       // DO NOT EDIT
       .JEPID           (7'h3B),   // ARM
       .JEPCONTINUATION (4'h4),    // ARM
       .PARTNUMBER      (12'h4C1), // Cortex-M0+ PIL
       .REVISION        (4'h0),    // Revision 0

       // Entry 0 = Processor
       .ENTRY0BASEADDR  (32'hE00FF000),
       .ENTRY0PRESENT   (1'b1),

       // Entry 1 = CTI (optional)
       .ENTRY1BASEADDR  (CTIBASE),
       .ENTRY1PRESENT   (CTI),

       // Entry 2 = MTB (optional)
       .ENTRY2BASEADDR  (MTBSFRBASE),
       .ENTRY2PRESENT   (MTB),

       // Entry 3 = Unused
       .ENTRY3BASEADDR  (32'h00000000),
       .ENTRY3PRESENT   (1'b0)
       )
   u_rom_table
     (
      // Outputs
      .HRDATA                           (hrdata_rom_table[31:0]),
      .HRESP                            (hresp_rom_table),
      .HREADYOUT                        (hreadyout_rom_table),
      // Inputs
      .HCLK                             (HCLK),
      .HSEL                             (hsel_rom_table),
      .HADDR                            (HADDRDCS),
      .HBURST                           (HBURSTDCS),
      .HMASTLOCK                        (HMASTLOCKDCS),
      .HPROT                            (HPROTDCS),
      .HSIZE                            (HSIZEDCS),
      .HTRANS                           (HTRANSDCS),
      .HWDATA                           (HWDATADCS),
      .HWRITE                           (HWRITEDCS),
      .HREADY                           (HREADYDCS),
      .ECOREVNUM                        (ECOREVNUM[23:20]));


   generate
      if (CTI != 0) begin: gen_cti1

         CM0PCTI u_cti
           (
            // Outputs
            .EDBGRQ                         (edbgrq_cti),
            .DBGRESTART                     (dbgrestart),
            .CTIIRQ                         (CTIIRQ[1:0]),
            .TSTART                         (tstart_cti),
            .TSTOP                          (tstop_cti),
            .CTICHOUT                       (CTICHOUT[3:0]),
            .HRESP                          (hresp_cti),
            .HREADYOUT                      (hreadyout_cti),
            .HRDATA                         (hrdata_cti[31:0]),

            // Inputs
            .HCLK                           (DCLK),
            .HRESETn                        (HRESETn),
            .CTIRESETn                      (DBGRESETn),
            .DBGRESTARTED                   (dbgrestarted),
            .HALTED                         (HALTED),
            .CTICHIN                        (CTICHIN[3:0]),
            .HSEL                           (hsel_cti),
            .HADDR                          (HADDRDCS),
            .HWRITE                         (HWRITEDCS),
            .HSIZE                          (HSIZEDCS[2:0]),
            .HBURST                         (HBURSTDCS[2:0]),
            .HPROT                          (HPROTDCS[3:0]),
            .HTRANS                         (HTRANSDCS[1:0]),
            .HMASTLOCK                      (HMASTLOCKDCS),
            .HREADY                         (HREADYDCS),
            .HWDATA                         (HWDATADCS[31:0]),
            .DBGEN                          (DBGEN),
            .NIDEN                          (NIDEN),
            .ECOREVNUM                      (ECOREVNUM[27:24]));

      end else begin: gen_cti0

         assign CTICHOUT    = 4'h0;
         assign CTIIRQ[1:0] = 2'b00;
         assign dbgrestart  = 1'b0;
         assign edbgrq_cti  = 1'b0;
         assign tstart_cti  = 1'b0;
         assign tstop_cti   = 1'b0;

      end
   endgenerate


   // -------------------------------------------------------------------------
   // AHB-LITE Debug Component Slave Port Decoding and MUXing
   // -------------------------------------------------------------------------

   cm0p_csi_ahb_interconnect
     #(.ROMTABLEBASE         (ROMTABLEBASE),
       .CTI                  (CTI),
       .CTIBASE              (CTIBASE),
       .MTB                  (MTB),
       .MTBAWIDTH            (AWIDTH),
       .MTBSFRBASE           (MTBSFRBASE)
       )
   u_interconnect
     (// Outputs
      .hreadyouts                     (HREADYOUTDCS),
      .hresps                         (HRESPDCS),
      .hrdatas                        (HRDATADCS),
      .hsel_rom_table                 (hsel_rom_table),
      .hsel_cti                       (hsel_cti),
      .hsel_mtb_sfr                   (hsel_mtb_sfr),
      .hsel_mtb_sram                  (hsel_mtb_sram),

      // Inputs
      .hclk                           (DCLK),
      .hreset_n                       (DBGRESETn),
      .hsel                           (HSELDCS),
      .hreadys                        (HREADYDCS),
      .haddrs                         (HADDRDCS),
      .hreadyout_rom_table            (hreadyout_rom_table),
      .hrdata_rom_table               (hrdata_rom_table),
      .hresp_rom_table                (hresp_rom_table),
      .hreadyout_cti                  (hreadyout_cti),
      .hrdata_cti                     (hrdata_cti),
      .hresp_cti                      (hresp_cti),
      .hreadyout_mtb                  (hreadyout_mtb),
      .hrdata_mtb                     (hrdata_mtb),
      .hresp_mtb                      (hresp_mtb),
      .mtb_sram_base                  (MTBSRAMBASE)
      );


endmodule

// ----------------------------------------------------------------------------
// EOF
// ----------------------------------------------------------------------------
