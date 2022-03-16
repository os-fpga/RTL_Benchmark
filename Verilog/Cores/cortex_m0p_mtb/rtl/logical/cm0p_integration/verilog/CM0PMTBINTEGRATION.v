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
//   Checked In : $Date: 2012-04-10 15:05:16 +0100 (Tue, 10 Apr 2012) $
//   Revision   : $Revision: 206803 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ MTB INTEGRATION EXAMPLE LEVEL
// ========================================
// This module provides a working example integration of the CORTEX-M0+
// processor, a MTB, the CORTEX-M0+ DAP and the CORTEX-M0+ profile WIC. It is
// designed to be a ready-to-use level of hierarchy to facilitate easy
// deployment of the CORTEX-M0+ processor. You can modify this module to suit
// your particular system requirements.
//-----------------------------------------------------------------------------

module CM0PMTBINTEGRATION
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
                                  // and multi-drop:
                                  //   0 = none
                                  //   1 = Serial Wire protocol 2
    // ------------------------------------------------------------------------
    parameter TARGETID =  32'h00000001,
                                  // 31:28=TREVISION 27:12=TPARTNO
                                  // 11:1=TDESIGNER 0=1
    // ------------------------------------------------------------------------
    // The following parameters are for the MTB
    // ------------------------------------------------------------------------
    parameter AWIDTH   =  32,     // Micro Trace Buffer SRAM address width:
                                  //   5 to 32
    // ------------------------------------------------------------------------
    parameter MTB      =  1)      // Micro Trace Buffer option:
                                  //   0 = absent
                                  //   1 = present
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

     // AHB-LITE TRACE (MTB) PORT
     input  wire [31:0] SRAMBASEADDR,   // Location of MTB RAM in memory map
     input  wire [31:0] HADDRMTB,       // AHB address into MTB
     input  wire [ 3:0] HPROTMTB,       // AHB properties into MTB
     input  wire [ 2:0] HSIZEMTB,       // AHB transaction size into MTB
     input  wire [ 1:0] HTRANSMTB,      // AHB transaction to MTB
     input  wire [31:0] HWDATAMTB,      // AHB write-data for MTB
     input  wire        HSELRAM,        // AHB selects MTB RAM
     input  wire        HSELSFR,        // AHB selects MTB control registers
     input  wire        HWRITEMTB,      // AHB write to MTB
     input  wire        HREADYMTB,      // AHB ready for MTB
     output wire [31:0] HRDATAMTB,      // AHB read-data from MTB
     output wire        HREADYOUTMTB,   // AHB ready out of MTB
     output wire        HRESPMTB,       // AHB error response from MTB

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
   // Declare local signals
   // -------------------------------------------------------------------------

   wire        IAEXSEQ;    // Instruction address sequential
   wire        IAEXEN;     // Instruction address being enabled
   wire [30:0] IAEX;       // Current instruction address
   wire        ATOMIC;     // Processor in non-instruction execution state

   wire        EDBGRQMTB;  // MTB -> Core debug entry request
   wire        IDLEMTB;    // MTB ready for clock gating
   wire        HCLKMTB;    // Gated clock for MTB

   // --------
   // Combine the external debug request with MTB generated version.

   wire        EDBGRQIN = EDBGRQMTB | EDBGRQ;

   // -------------------------------------------------------------------------
   // Core integration level instantiation
   // -------------------------------------------------------------------------

   CM0PINTEGRATION
     #(.ACG(ACG), .BE(BE), .BKPT(BKPT), .DBG(DBG), .HALTEV(HALTEV),
       .HWF(HWF), .IOP(IOP), .IRQDIS(IRQDIS), .MPU(MPU), .NUMIRQ(NUMIRQ),
       .RAR(RAR), .SMUL(SMUL), .SYST(SYST), .USER(USER), .VTOR(VTOR),
       .WIC(WIC), .WICLINES(WICLINES), .WPT(WPT), .BASEADDR(BASEADDR),
       .JTAGnSW(JTAGnSW), .SWMD(SWMD), .TARGETID(TARGETID))
   u_cm0pintegration
     (.FCLK                           (FCLK),
      .SCLK                           (SCLK),
      .HCLK                           (HCLK),
      .DCLK                           (DCLK),
      .PORESETn                       (PORESETn),
      .DBGRESETn                      (DBGRESETn),
      .HRESETn                        (HRESETn),
      .SWCLKTCK                       (SWCLKTCK),
      .nTRST                          (nTRST),
      .HADDR                          (HADDR[31:0]),
      .HBURST                         (HBURST[2:0]),
      .HMASTLOCK                      (HMASTLOCK),
      .HPROT                          (HPROT[3:0]),
      .HSIZE                          (HSIZE[2:0]),
      .HTRANS                         (HTRANS[1:0]),
      .HWDATA                         (HWDATA[31:0]),
      .HWRITE                         (HWRITE),
      .HRDATA                         (HRDATA[31:0]),
      .HREADY                         (HREADY),
      .HRESP                          (HRESP),
      .HMASTER                        (HMASTER),
      .SHAREABLE                      (SHAREABLE),
      .CODENSEQ                       (CODENSEQ),
      .CODEHINT                       (CODEHINT[3:0]),
      .SPECHTRANS                     (SPECHTRANS),
      .DATAHINT                       (DATAHINT[1:0]),
      .SWDITMS                        (SWDITMS),
      .TDI                            (TDI),
      .SWDO                           (SWDO),
      .SWDOEN                         (SWDOEN),
      .SWDETECT                       (SWDETECT),
      .TDO                            (TDO),
      .nTDOEN                         (nTDOEN),
      .DBGRESTART                     (DBGRESTART),
      .DBGRESTARTED                   (DBGRESTARTED),
      .EDBGRQ                         (EDBGRQIN),
      .HALTED                         (HALTED),
      .NIDEN                          (NIDEN),
      .DBGEN                          (DBGEN),
      .NMI                            (NMI),
      .IRQ                            (IRQ[31:0]),
      .TXEV                           (TXEV),
      .RXEV                           (RXEV),
      .LOCKUP                         (LOCKUP),
      .SYSRESETREQ                    (SYSRESETREQ),
      .STCALIB                        (STCALIB[25:0]),
      .STCLKEN                        (STCLKEN),
      .IRQLATENCY                     (IRQLATENCY[7:0]),
      .INSTANCEID                     (INSTANCEID),
      .ECOREVNUM                      (ECOREVNUM[27:0]),
      .CPUWAIT                        (CPUWAIT),
      .SLVSTALL                       (SLVSTALL),
      .GATEHCLK                       (GATEHCLK),
      .SLEEPING                       (SLEEPING),
      .SLEEPDEEP                      (SLEEPDEEP),
      .WAKEUP                         (WAKEUP),
      .WICSENSE                       (WICSENSE[33:0]),
      .SLEEPHOLDREQn                  (SLEEPHOLDREQn),
      .SLEEPHOLDACKn                  (SLEEPHOLDACKn),
      .WICENREQ                       (WICENREQ),
      .WICENACK                       (WICENACK),
      .CDBGPWRUPREQ                   (CDBGPWRUPREQ),
      .CDBGPWRUPACK                   (CDBGPWRUPACK),
      .IOMATCH                        (IOMATCH),
      .IORDATA                        (IORDATA),
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
      .DFTSE                          (DFTSE),
      .DFTRSTDISABLE                  (DFTRSTDISABLE),
      .SYSRETAINn                     (SYSRETAINn),
      .SYSISOLATEn                    (SYSISOLATEn),
      .SYSPWRDOWN                     (SYSPWRDOWN),
      .SYSPWRDOWNACK                  (SYSPWRDOWNACK),
      .DBGISOLATEn                    (DBGISOLATEn),
      .DBGPWRDOWN                     (DBGPWRDOWN),
      .DBGPWRDOWNACK                  (DBGPWRDOWNACK));

   // -------------------------------------------------------------------------
   // CORTEX-M0+ Micro Trace Buffer instantiation
   // -------------------------------------------------------------------------

   generate
      if (MTB != 0) begin: gen_cm0pmtb

         // --------
         // Optionally instantiate a clock gate for the MTB:

         if (ACG != 0) begin: gen_mtb_acg

            wire mtb_clock_enable = ~IDLEMTB;

            cm0p_acg u_mtb_acg (.CLKIN  (FCLK),
                                .ENABLE (mtb_clock_enable),
                                .DFTSE  (DFTSE),
                                .CLKOUT (HCLKMTB));

         end else begin: gen_no_mtb_acg

            assign HCLKMTB = FCLK;

         end

         // --------
         // Assign RAM clock from MTB clock:

         assign RAMHCLK = HCLKMTB;

         // -------------------------------------------------------------------
         // Optionally instantiate Micro Trace Buffer
         // -------------------------------------------------------------------

         CM0PMTB
           #(.RAR(RAR), .AWIDTH(AWIDTH), .USER(USER))
         u_cm0pmtb
           (// Outputs
            .HRDATA                         (HRDATAMTB),
            .HREADYOUT                      (HREADYOUTMTB),
            .HRESP                          (HRESPMTB),
            .RAMAD                          (RAMAD[AWIDTH-3:0]),
            .RAMWD                          (RAMWD[31:0]),
            .RAMCS                          (RAMCS),
            .RAMWE                          (RAMWE[3:0]),
            .EDBGRQ                         (EDBGRQMTB),
            .IDLE                           (IDLEMTB),

            // Inputs
            .HCLK                           (HCLKMTB),
            .RESETn                         (PORESETn),
            .HADDR                          (HADDRMTB[31:0]),
            .HBURST                         (3'b000),
            .HMASTLOCK                      (1'b0),
            .HPROT                          (HPROTMTB),
            .HSIZE                          (HSIZEMTB[2:0]),
            .HTRANS                         (HTRANSMTB[1:0]),
            .HWDATA                         (HWDATAMTB[31:0]),
            .HWRITE                         (HWRITEMTB),
            .HSELRAM                        (HSELRAM),
            .HSELSFR                        (HSELSFR),
            .HREADY                         (HREADYMTB),

            .RAMRD                          (RAMRD),
            .IAEXEN                         (IAEXEN),
            .IAEXSEQ                        (IAEXSEQ),
            .IAEX                           (IAEX),
            .ATOMIC                         (ATOMIC),
            .TSTART                         (TSTART),
            .TSTOP                          (TSTOP),
            .NIDEN                          (NIDEN),
            .DBGEN                          (DBGEN),
            .SRAMBASEADDR                   (SRAMBASEADDR),
            .ECOREVNUM                      (ECOREVNUM[31:28]));

      end else begin: gen_no_cm0pmtb

         assign EDBGRQMTB    = 1'b0;
         assign HRDATAMTB    = {32{1'b0}};
         assign HREADYOUTMTB = 1'b0;
         assign HRESPMTB     = 1'b0;
         assign RAMAD        = {(AWIDTH-2){1'b0}};
         assign RAMWD        = {32{1'b0}};
         assign RAMCS        = 1'b0;
         assign RAMWE        = {4{1'b0}};
         assign IDLEMTB      = 1'b1;

      end
   endgenerate

   // -------------------------------------------------------------------------

endmodule

// ----------------------------------------------------------------------------
// EOF
// ----------------------------------------------------------------------------
