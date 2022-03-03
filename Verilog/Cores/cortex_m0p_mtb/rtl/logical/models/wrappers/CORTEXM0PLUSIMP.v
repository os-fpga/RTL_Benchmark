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
//   Checked In : $Date: 2012-01-18 16:23:07 +0000 (Wed, 18 Jan 2012) $
//   Revision   : $Revision: 198612 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ IMPLEMENTATION AND CONFIGURATION LEVEL
// ----------------------------------------------------------------------------
// This is an example wrapper level to allow you to configure your
// instantiation of CORTEX-M0+ and add any specific I/O that you need for
// your implementation. The example provided here is for an SRPG implementation
// and assumes a particular set of power-control signals. You can change these
// to meet the requirements of your particular library and flow
//-----------------------------------------------------------------------------

module CORTEXM0PLUSIMP
  #(// ------------------------------------------------------------------------
    // Configurability
    // ------------------------------------------------------------------------
    // Modify this section to configure CORTEX-M0+
    // ------------------------------------------------------------------------
    parameter  ACG      =  1,      // Architectural clock gating:
                                   //   0 = absent
                                   //   1 = present
    // ------------------------------------------------------------------------
    parameter  AHBSLV   =  1,      // SLV port AHB-Lite compliance:
                                   //   0 = non-compliant
                                   //   1 = more-compliant
    // ------------------------------------------------------------------------
    parameter  BE       =  0,      // Data transfer endianess:
                                   //   0 = little-endian
                                   //   1 = byte-invariant big-endian
    // ------------------------------------------------------------------------
    parameter  BKPT     =  4,      // Number of breakpoint comparators:
                                   //   0 = none
                                   //   1 = one
                                   //   2 = two
                                   //   3 = three
                                   //   4 = four
    // ------------------------------------------------------------------------
    parameter  DBG      =  1,      // Debug configuration:
                                   //   0 = no debug support
                                   //   1 = implement debug support
    // ------------------------------------------------------------------------
    parameter  HWF      =  0,      // Half-word fetch only:
                                   //   0 = Favor 32-bit word fetching
                                   //   1 = Only fetch 16-bits per cycle
    // ------------------------------------------------------------------------
    parameter  IOP      =  0,      // I/O port interface:
                                   //   0 = no I/O support
                                   //   1 = I/O port interface
    // ------------------------------------------------------------------------
    parameter  IRQDIS   =  32'h 00000000,
                                   // IRQ disable support each bit denotes an
                                   // interrupt where:
                                   //   0 = not supported, IRQ always enabled
                                   //   1 = supported, IRQDIS disables IRQs
    // ------------------------------------------------------------------------
    parameter  MPU      =  0,      // MPU implemented regions:
                                   //   0 = none, no MPU implemented
                                   //   8 = eight MPU regions implemented
    // ------------------------------------------------------------------------
    parameter  NUMIRQ   = 32,      // Functional IRQ lines:
                                   //   1 = IRQ[0]
                                   //   2 = IRQ[1:0]
                                   //   . . ...
                                   //  32 = IRQ[31:0]
    // ------------------------------------------------------------------------
    parameter  RAR      =  0,      // Reset-all-register option:
                                   //   0 = standard, architectural reset
                                   //   1 = extended, all register reset
    // ------------------------------------------------------------------------
    parameter  SMUL     =  0,      // Multiplier configuration:
                                   //   0 = MULS is single cycle (fast)
                                   //   1 = MULS takes 32-cycles (small)
    // ------------------------------------------------------------------------
    parameter  SYST     =  1,      // SysTick timer option:
                                   //   0 = SysTick not present
                                   //   1 = SysTick present
    // ------------------------------------------------------------------------
    parameter  USER     =  0,      // User/privilege support:
                                   //   0 = absent - Privilege mode only
                                   //   1 = present
    // ------------------------------------------------------------------------
    parameter  VTOR     =  0,      // Vector Table Offset Register:
                                   //   0 = absent
                                   //   1 = present
    // ------------------------------------------------------------------------
    parameter  WIC      =  1,      // Wake-up interrupt controller support:
                                   //   0 = no support
                                   //   1 = WIC deep-sleep supported
    // ------------------------------------------------------------------------
    parameter  WICLINES = 34,      // Supported WIC lines:
                                   //   2 = NMI and RXEV
                                   //   3 = NMI, RXEV and IRQ[0]
                                   //   4 = NMI, RXEV and IRQ[1:0]
                                   //   . . ...
                                   //  34 = NMI, RXEV and IRQ[31:0]
    // ------------------------------------------------------------------------
    parameter  WPT      =  2)      // Number of DWT comparators:
                                   //   0 = none
                                   //   1 = one
                                   //   2 = two
   // -------------------------------------------------------------------------

  (
   // CLOCK AND RESETS --------------------------------------------------------
   input  wire        SCLK,          // System clock
   input  wire        HCLK,          // AHB clock
   input  wire        DCLK,          // Debug clock
   input  wire        DBGRESETn,     // Debug logic asynchronous reset
   input  wire        HRESETn,       // System logic asynchronous reset

   // AHB-LITE MASTER PORT ----------------------------------------------------
   output wire [31:0] HADDR,         // AHB transaction address
   output wire [ 2:0] HBURST,        // AHB burst, tied to single
   output wire        HMASTLOCK,     // AHB locked transfer (always zero)
   output wire [ 3:0] HPROT,         // AHB protection, priv-data or priv-inst
   output wire [ 2:0] HSIZE,         // AHB size, only byte, half-word or word
   output wire [ 1:0] HTRANS,        // AHB transfer, non-sequential only
   output wire [31:0] HWDATA,        // AHB write-data
   output wire        HWRITE,        // AHB write control
   input  wire [31:0] HRDATA,        // AHB read-data
   input  wire        HREADY,        // AHB stall signal
   input  wire        HRESP,         // AHB error response

   output wire        HMASTER,       // AHB master, 0 = core, 1 = debug/slave
   output wire        SHAREABLE,     // AHB transaction is shareable

   // AHB-LITE SUB-SET DEBUG SLAVE PORT ---------------------------------------
   input  wire [31:0] SLVADDR,       // Slave transaction address
   input  wire [ 1:0] SLVSIZE,       // Slave transaction size
   input  wire        SLVSTALL,      // Slave interface stalled request
   input  wire [ 1:0] SLVTRANS,      // Slave transaction request ([0] unused)
   input  wire [ 3:0] SLVPROT,       // Slave transaction protection
   input  wire [31:0] SLVWDATA,      // Slave write-data
   input  wire        SLVWRITE,      // Slave write control
   output wire [31:0] SLVRDATA,      // Slave read-data
   output wire        SLVREADY,      // Slave stall signal
   output wire        SLVRESP,       // Slave error response

   // DEBUG -------------------------------------------------------------------
   input  wire        DBGRESTART,    // CoreSight exit-debug request
   output wire        DBGRESTARTED,  // CoreSight have-left debug acknowledge
   input  wire        EDBGRQ,        // External debug request
   output wire        HALTED,        // Core is halted
   input  wire        NIDEN,         // Non-intrusive debug enable
   input  wire        DBGEN,         // Debug enable

   // MISCELLANEOUS -----------------------------------------------------------
   input  wire        NMI,           // Non-maskable interrupt input
   input  wire [31:0] IRQ,           // 32 interrupt request inputs
   output wire        TXEV,          // Event transmit
   input  wire        RXEV,          // Event receive
   output wire        LOCKUP,        // Core is locked-up
   output wire        SYSRESETREQ,   // System reset request
   input  wire [25:0] STCALIB,       // SysTick calibration register value
   input  wire        STCLKEN,       // SysTick SCLK clock enable
   input  wire [ 7:0] IRQLATENCY,    // Interrupt latency value
   input  wire [19:0] ECOREVNUM,     // Engineering-change-order revision bits
   input  wire        CPUWAIT,       // Wait out of reset

   // CODE SEQUENTIALITY AND SPECULATION --------------------------------------
   output wire        CODENSEQ,      // Code fetch is non-sequential to last
   output wire [ 3:0] CODEHINT,      // Code fetch hints
   output wire        SPECHTRANS,    // Speculative HTRANS[1]

   // DATA ACCESS HINTS -------------------------------------------------------
   output wire [ 1:0] DATAHINT,      // Data access hints

   // POWER MANAGEMENT --------------------------------------------------------
   output wire        SLEEPING,      // Core sleeping (HCLK may be gated)
   output wire        SLEEPDEEP,     // Core is in deep-sleep
   input  wire        SLEEPHOLDREQn, // Sleep extension request
   output wire        SLEEPHOLDACKn, // Sleep extension acknowledge
   input  wire        WICDSREQn,     // Operate in WIC based deep-sleep mode
   output wire        WICDSACKn,     // Acknowledge using WIC based deep-sleep
   output wire [31:0] WICMASKISR,    // WIC interrupt sensitivity mask
   output wire        WICMASKNMI,    // WIC NMI sensitivity mask
   output wire        WICMASKRXEV,   // WIC event sensitivity mask
   output wire        WICLOAD,       // WIC should reload using current masks
   output wire        WICCLEAR,      // WIC should clear its mask

   // IO PORT Interface -------------------------------------------------------
   input wire         IOMATCH,       // Indicates IOCHECK within I/O region
   input wire  [31:0] IORDATA,       // IO port read-data
   output wire        IOTRANS,       // IO transaction
   output wire        IOWRITE,       // IO write not read
   output wire [31:0] IOCHECK,       // IO address query
   output wire [31:0] IOADDR,        // IO transaction address
   output wire [ 1:0] IOSIZE,        // IO transaction size
   output wire        IOMASTER,      // IO initiator (0=Core, 1=Debugger)
   output wire        IOPRIV,        // IO transaction privilege
   output wire [31:0] IOWDATA,       // IO write-data

   // MTB TRACE Interface -----------------------------------------------------
   output wire        IAEXSEQ,       // Instruction address sequential
   output wire        IAEXEN,        // Instruction address being updated
   output wire [30:0] IAEX,          // Current instruciton address
   output wire        ATOMIC,        // Processor in special state

   // SCAN/TEST IO ------------------------------------------------------------
   input  wire        DFTSE,         // Scan-enable (not used by RTL)

   // SRPG IO (no RTL-level function) -----------------------------------------
   input  wire        SYSRETAINn,    // Power related only
   input  wire        SYSISOLATEn,   // ...
   input  wire        SYSPWRDOWN,    // ...
   output wire        SYSPWRDOWNACK, // ...
   input  wire        DBGISOLATEn,   // ...
   input  wire        DBGPWRDOWN,    // ...
   output wire        DBGPWRDOWNACK);// ...

   CORTEXM0PLUS
     #(.ACG(ACG), .AHBSLV(AHBSLV), .BE(BE), .BKPT(BKPT), .DBG(DBG), .HWF(HWF),
       .IOP(IOP), .IRQDIS(IRQDIS), .MPU(MPU), .NUMIRQ(NUMIRQ), .RAR(RAR),
       .SMUL(SMUL), .SYST(SYST), .USER(USER), .VTOR(VTOR), .WIC(WIC),
       .WICLINES(WICLINES), .WPT(WPT))
   u_cortexm0plus
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
      .SLVRDATA                       (SLVRDATA[31:0]),
      .SLVREADY                       (SLVREADY),
      .SLVRESP                        (SLVRESP),
      .DBGRESTARTED                   (DBGRESTARTED),
      .HALTED                         (HALTED),
      .TXEV                           (TXEV),
      .LOCKUP                         (LOCKUP),
      .SYSRESETREQ                    (SYSRESETREQ),
      .CODENSEQ                       (CODENSEQ),
      .CODEHINT                       (CODEHINT[3:0]),
      .DATAHINT                       (DATAHINT[1:0]),
      .SPECHTRANS                     (SPECHTRANS),
      .SLEEPING                       (SLEEPING),
      .SLEEPDEEP                      (SLEEPDEEP),
      .SLEEPHOLDACKn                  (SLEEPHOLDACKn),
      .WICDSACKn                      (WICDSACKn),
      .WICMASKISR                     (WICMASKISR[31:0]),
      .WICMASKNMI                     (WICMASKNMI),
      .WICMASKRXEV                    (WICMASKRXEV),
      .WICLOAD                        (WICLOAD),
      .WICCLEAR                       (WICCLEAR),
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
      .SLVADDR                        (SLVADDR[31:0]),
      .SLVSIZE                        (SLVSIZE[1:0]),
      .SLVSTALL                       (SLVSTALL),
      .SLVTRANS                       (SLVTRANS[1:0]),
      .SLVPROT                        (SLVPROT),
      .SLVWDATA                       (SLVWDATA[31:0]),
      .SLVWRITE                       (SLVWRITE),
      .DBGRESTART                     (DBGRESTART),
      .EDBGRQ                         (EDBGRQ),
      .NIDEN                          (NIDEN),
      .DBGEN                          (DBGEN),
      .NMI                            (NMI),
      .IRQ                            (IRQ[31:0]),
      .RXEV                           (RXEV),
      .STCALIB                        (STCALIB[25:0]),
      .STCLKEN                        (STCLKEN),
      .IRQLATENCY                     (IRQLATENCY[7:0]),
      .ECOREVNUM                      (ECOREVNUM[19:0]),
      .CPUWAIT                        (CPUWAIT),
      .SLEEPHOLDREQn                  (SLEEPHOLDREQn),
      .WICDSREQn                      (WICDSREQn),
      .IOMATCH                        (IOMATCH),
      .IORDATA                        (IORDATA),
      .DFTSE                          (DFTSE));

   //--------------------------------------------------------------------------
   // Reduce lint warnings
   //--------------------------------------------------------------------------

   wire [4:0] unused = { SYSRETAINn, SYSISOLATEn, SYSPWRDOWN, DBGISOLATEn,
                         DBGPWRDOWN };

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
