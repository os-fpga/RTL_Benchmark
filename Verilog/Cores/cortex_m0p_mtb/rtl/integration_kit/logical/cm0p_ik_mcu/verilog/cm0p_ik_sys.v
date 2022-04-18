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
//      SVN Information
//
//      Checked In          : $Date: 2012-12-17 19:03:25 +0000 (Mon, 17 Dec 2012) $
//
//      Revision            : $Revision: 231929 $
//
//      Release Information : Cortex-M0+ AT590-r0p1-00rel0
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//     Cortex-M0+ Integration Kit Level
//-----------------------------------------------------------------------------
//
// This level instantiates the following
//  o u_cm0pmtbintegration       - CORTEX-M0+ MTB INTEGRATION
//  o u_ahb2rom                  - AHB to ROM Bridge
//  o u_rom                      - ROM Memory
//  o u_ahb2sram                 - AHB to SRAM Bridge
//  o u_ram                      - RAM Memory
//  o u_system_rom_table         - System ROM Table
//  o u_mtbram                   - MTB RAM Memory (optional)
//  o u_ahb_interconnect         - AHB Bus Interconnect
//  o u_iop_interconnect         - IOP Bus Interconnect (optional)
//  o u_ahb_def_slv              - AHB Default Slave
//  o u_misc_logic               - Miscellaneous Logic Block
//  o u_stclken                  - STCLK Double Synchronized Edge Detection
//  o u_gpio_0                   - GPIO 0
//  o u_gpio_1                   - GPIO 1
//  o u_gpio_2                   - GPIO 2
//-----------------------------------------------------------------------------
//`include "cm0p_ik_defs.v"

module cm0p_ik_sys
   (//Inputs
    input wire         FCLK,          // Free Running Clock
    input wire         SCLK,          // System Clock
    input wire         HCLK,          // AHB Clock
    input wire         DCLK,          // Debug Clock
    input wire         STCLK,         // Systick Reference Clock
    input wire         PORESETn,      // Power-on Reset
    input wire         HRESETn,       // System Reset
    input wire         DBGRESETn,     // Debug Reset
    input wire         nTRST,         // JTAG Test Reset
    input wire         SWCLKTCK,      // JTAG and/or SW Clock
    input wire         SWDITMS,       // JTAG mode select/SW Data In
    input wire         TDI,           // JTAG Data In
    input wire         WICENREQ,      // WIC mode handshaking Request
    input wire         CDBGPWRUPACK,  // System Power Up & Reset Acknowledge
    input wire         SLEEPHOLDREQn, // PMU requesting sleep extension
    input wire         SYSISOLATEn,   // System Power Isolate Control
    input wire         SYSRETAINn,    // System Power Retain Control
    input wire         SYSPWRDOWN,    // System Power Down
    input wire         DBGISOLATEn,   // Debug Power Isolate control
    input wire         DBGPWRDOWN,    // Debug Power Down
    input wire [31:0]  EXTGPIOIN,     // External GPIO Inputs
    //Outputs
    output wire        HREADY,        // CORTEX-M0+ HREADY
    output wire        CDBGPWRUPREQ,  // System Power Up & Reset Request
    output wire        TDO,           // JTAG Data Out
    output wire        nTDOEN,        // JTAG Data Out Enable
    output wire        SWDO,          // SW Data Out
    output wire        SWDOEN,        // SW Data Enable
    output wire        WICENACK,      // WIC mode handshaking Acknowledge
    output wire        WAKEUP,        // Wakeup request from WIC
    output wire        SLEEPDEEP,     // Processor in sleep
    output wire        SLEEPHOLDACKn, // Extension sleep Acknowledge
    output wire        GATEHCLK,      // Gate System Clock
    output wire        SYSRESETREQ,   // System Reset Request
    output wire        SYSPWRDOWNACK, // SRPG - System Power Down Acknowledge
    output wire        DBGPWRDOWNACK, // SRPG - Debug Power Down Acknowledge
    output wire [31:0] EXTGPIOOUT,    // External GPIO Outputs
    output wire [31:0] EXTGPIOEN);    // External GPIO Pin Enables

    localparam BASEADDR_ROM         = 32'h0000_0000;
    localparam BASEADDR_SRAM        = 32'h2000_0000;
    localparam BASEADDR_GPIO0       = 32'h4000_0000;
    localparam BASEADDR_GPIO1       = 32'h4000_0800;
    localparam BASEADDR_GPIO2       = 32'h4000_1000;
    localparam BASEADDR_MTB         = 32'hF000_2000;
    localparam BASEADDR_MTBSRAM     = 32'hF000_3000;
    localparam BASEADDR_SYSROMTABLE = 32'hF010_0000;

//-----------------------------------------------------------------------------
// Signal declarations
//-----------------------------------------------------------------------------

  wire [31:0]               sys_irq;
  wire [30:0]               sys_irq_misc;
  wire                      sys_nmi;
  wire                      sys_nmi_gpio;
  wire                      sys_rxev;
  wire                      sys_txev;
  wire                      sys_loopin_gpio, sys_loopout_gpio;
  wire [30:0]               sys_irq_gpio;
  wire                      sys_irq0_gpio;
  wire                      sys_rxev_gpio;
  wire                      sys_delayed_rxev;
  wire [31:0]               sys_haddr_cortexm0plus;
  wire [2:0]                sys_hburst_cortexm0plus;
  wire                      sys_hmastlock_cortexm0plus;
  wire [3:0]                sys_hprot_cortexm0plus;
  wire [2:0]                sys_hsize_cortexm0plus;
  wire [1:0]                sys_htrans_cortexm0plus;
  wire [31:0]               sys_hwdata_cortexm0plus;
  wire                      sys_hwrite_cortexm0plus;
  wire                      sys_iotrans_cortexm0plus;
  wire                      sys_iowrite_cortexm0plus;
  wire [ 1:0]               sys_iosize_cortexm0plus;
  wire [31:0]               sys_iocheck_cortexm0plus;
  wire [31:0]               sys_ioaddr_cortexm0plus;
  wire [31:0]               sys_iowdata_cortexm0plus;
  wire                      sys_iomaster_cortexm0plus;
  wire                      sys_iopriv_cortexm0plus;
  wire [31:0]               sys_hrdata_mux, sys_hrdata_rom, sys_hrdata_ram,
                            sys_hrdata_system_rom_table, sys_hrdata_def_slv;
  wire [31:0]               sys_hrdata_gpio0, sys_hrdata_gpio1, sys_hrdata_gpio2;
  wire                      sys_hresp_mux, sys_hresp_rom, sys_hresp_ram,
                            sys_hresp_system_rom_table, sys_hresp_def_slv;
  wire                      sys_hresp_gpio0, sys_hresp_gpio1, sys_hresp_gpio2;
  wire                      sys_hready_mux, sys_hreadyout_rom, sys_hreadyout_ram,
                            sys_hreadyout_system_rom_table, sys_hreadyout_def_slv;
  wire                      sys_hreadyout_gpio0, sys_hreadyout_gpio1, sys_hreadyout_gpio2;
  wire                      sys_hsel_rom, sys_hsel_ram, sys_hsel_system_rom_table,
                            sys_hsel_def_slv, sys_hsel_gpio0, sys_hsel_gpio1, sys_hsel_gpio2,
                            sys_hsel_mtb, sys_hsel_mtbram, sys_hsel_mtbsfr;
  wire                      sys_iomatch_mux;
  wire [31:0]               sys_iordata_mux;
  wire                      sys_iosel_gpio0, sys_iosel_gpio1, sys_iosel_gpio2;
  wire                      sys_iomatch_gpio0, sys_iomatch_gpio1, sys_iomatch_gpio2;
  wire [31:0]               sys_iordata_gpio0, sys_iordata_gpio1, sys_iordata_gpio2;
  wire [31:0]               sys_gpio0out, sys_gpio1out, sys_gpio2out;
  wire [31:0]               sys_gpio0in, sys_gpio1in, sys_gpio2in;
  wire [31:0]               sys_gpio0en;
  wire                      sys_gpio0int, sys_gpio1int, sys_gpio2int;
  wire                      sys_stclken;
  wire                      sys_lockup;
  wire                      sys_halted;
  wire                      sys_edbgrq;
  wire                      sys_sleeping;
  wire                      sys_dbgrestart, sys_dbgrestarted;
  wire                      sys_tstart, sys_tstop;
  wire [31:0]               sys_rdata_rom;
  wire [31:0]               sys_rdata_sram, sys_wdata_sram;
  wire [17:0]               sys_addr_rom;
  wire [17:0]               sys_addr_sram;
  wire                      sys_cs_rom;
  wire                      sys_cs_sram;
  wire [3:0]                sys_we_sram;
  wire                      sys_hreadyout_mtb;
  wire [31:0]               sys_hrdata_mtb;
  wire                      sys_hresp_mtb;
  wire [31:0]               sys_rdata_mtbsram, sys_wdata_mtbsram;
  wire [`ARM_CM0PIK_MTBAWIDTH-3:0] sys_addr_mtbsram;
  wire                      sys_cs_mtbsram;
  wire [ 3:0]               sys_we_mtbsram;
  wire                      sys_clk_mtbsram;
  wire                      sys_iop_present;
  wire                      sys_iop_clr;
  wire [31:0]               ECOREVNUM;
  wire [ 3:0] 		    rom_table_ecorevnum;
  wire [31:0]               baseaddr_mtbsram = BASEADDR_MTBSRAM;

  // ----------------------------------------------------------------------
  // Cortex-M0+ MTB Integration level instantiation
  // ----------------------------------------------------------------------

  CM0PMTBINTEGRATION
   #(
     //.ACG                            (),
     .BE                             (`ARM_CM0PIK_BE),
     //.BKPT                           (),
     //.DBG                            (),
     //.HWF                            (),
     .IOP                            (`ARM_CM0PIK_IOP),
     //.IRQDIS                         (),
     //.MPU                            (),
     //.NUMIRQ                         (),
     //.RAR                            (),
     //.SMUL                           (),
     //.SYST                           (),
     //.USER                           (),
     //.VTOR                           (),
     //.WIC                            (),
     //.WICLINES                       (),
     //.WPT                            (),
     .BASEADDR                       (`ARM_CM0PIK_BASEADDR),
     //.HALTEV                         (),
     //.JTAGnSW                        (),
     //.SWMD                           (),
     //.TARGETID                       (),
     .AWIDTH                         (`ARM_CM0PIK_MTBAWIDTH),
     .MTB                            (`ARM_CM0PIK_MTB))
      u_cm0pmtbintegration
    (
     .FCLK                           (FCLK),
     .SCLK                           (SCLK),
     .HCLK                           (HCLK),
     .DCLK                           (DCLK),
     .PORESETn                       (PORESETn),
     .DBGRESETn                      (DBGRESETn),
     .HRESETn                        (HRESETn),
     .SWCLKTCK                       (SWCLKTCK),
     .nTRST                          (nTRST),
     .HADDR                          (sys_haddr_cortexm0plus[31:0]),
     .HBURST                         (sys_hburst_cortexm0plus[2:0]),
     .HMASTLOCK                      (sys_hmastlock_cortexm0plus),
     .HPROT                          (sys_hprot_cortexm0plus[3:0]),
     .HSIZE                          (sys_hsize_cortexm0plus[2:0]),
     .HTRANS                         (sys_htrans_cortexm0plus[1:0]),
     .HWDATA                         (sys_hwdata_cortexm0plus[31:0]),
     .HWRITE                         (sys_hwrite_cortexm0plus),
     .HRDATA                         (sys_hrdata_mux[31:0]),
     .HREADY                         (sys_hready_mux),
     .HRESP                          (sys_hresp_mux),
     .HMASTER                        (),
     .SHAREABLE                      (),
     .SRAMBASEADDR                   (baseaddr_mtbsram[31:0]),
     .HADDRMTB                       (sys_haddr_cortexm0plus[31:0]),
     .HPROTMTB                       (sys_hprot_cortexm0plus[3:0]),
     .HSIZEMTB                       (sys_hsize_cortexm0plus[2:0]),
     .HTRANSMTB                      (sys_htrans_cortexm0plus[1:0]),
     .HWDATAMTB                      (sys_hwdata_cortexm0plus[31:0]),
     .HSELRAM                        (sys_hsel_mtbram),
     .HSELSFR                        (sys_hsel_mtbsfr),
     .HWRITEMTB                      (sys_hwrite_cortexm0plus),
     .HREADYMTB                      (sys_hready_mux),
     .HRDATAMTB                      (sys_hrdata_mtb[31:0]),
     .HREADYOUTMTB                   (sys_hreadyout_mtb),
     .HRESPMTB                       (sys_hresp_mtb),
     .RAMHCLK                        (sys_clk_mtbsram),
     .RAMRD                          (sys_rdata_mtbsram[31:0]),
     .RAMAD                          (sys_addr_mtbsram[`ARM_CM0PIK_MTBAWIDTH-3:0]),
     .RAMWD                          (sys_wdata_mtbsram[31:0]),
     .RAMCS                          (sys_cs_mtbsram),
     .RAMWE                          (sys_we_mtbsram[3:0]),
     .TSTART                         (sys_tstart),
     .TSTOP                          (sys_tstop),
     .CODENSEQ                       (),
     .CODEHINT                       (),
     .SPECHTRANS                     (),
     .DATAHINT                       (),
     .SWDITMS                        (SWDITMS),
     .TDI                            (TDI),
     .SWDO                           (SWDO),
     .SWDOEN                         (SWDOEN),
     .SWDETECT                       (),
     .TDO                            (TDO),
     .nTDOEN                         (nTDOEN),
     .DBGRESTART                     (sys_dbgrestart),
     .DBGRESTARTED                   (sys_dbgrestarted),
     .EDBGRQ                         (sys_edbgrq),
     .HALTED                         (sys_halted),
     .NIDEN                          (1'b1),
     .DBGEN                          (1'b1),
     .NMI                            (sys_nmi),
     .IRQ                            (sys_irq[31:0]),
     .TXEV                           (sys_txev),
     .RXEV                           (sys_rxev),
     .LOCKUP                         (sys_lockup),
     .SYSRESETREQ                    (SYSRESETREQ),
     .STCALIB                        (`ARM_CM0PIK_STCALIB),
     .STCLKEN                        (sys_stclken),
     .IRQLATENCY                     (`ARM_CM0PIK_IRQLATENCY),
     .INSTANCEID                     (`ARM_CM0PIK_INSTANCEID),
     .ECOREVNUM                      (ECOREVNUM),
     .CPUWAIT                        (1'b0),
     .SLVSTALL                       (1'b0),
     .GATEHCLK                       (GATEHCLK),
     .SLEEPING                       (sys_sleeping),
     .SLEEPDEEP                      (SLEEPDEEP),
     .WAKEUP                         (WAKEUP),
     .WICSENSE                       (),
     .SLEEPHOLDREQn                  (SLEEPHOLDREQn),
     .SLEEPHOLDACKn                  (SLEEPHOLDACKn),
     .WICENREQ                       (WICENREQ),
     .WICENACK                       (WICENACK),
     .CDBGPWRUPREQ                   (CDBGPWRUPREQ),
     .CDBGPWRUPACK                   (CDBGPWRUPACK),
     .IOMATCH                        (sys_iomatch_mux),
     .IORDATA                        (sys_iordata_mux[31:0]),
     .IOTRANS                        (sys_iotrans_cortexm0plus),
     .IOWRITE                        (sys_iowrite_cortexm0plus),
     .IOCHECK                        (sys_iocheck_cortexm0plus[31:0]),
     .IOADDR                         (sys_ioaddr_cortexm0plus[31:0]),
     .IOSIZE                         (sys_iosize_cortexm0plus[1:0]),
     .IOMASTER                       (sys_iomaster_cortexm0plus),
     .IOPRIV                         (sys_iopriv_cortexm0plus),
     .IOWDATA                        (sys_iowdata_cortexm0plus[31:0]),
     .DFTSE                          (1'b0),
     .DFTRSTDISABLE                  (1'b0),
     .SYSRETAINn                     (SYSRETAINn),
     .SYSISOLATEn                    (SYSISOLATEn),
     .SYSPWRDOWN                     (SYSPWRDOWN),
     .SYSPWRDOWNACK                  (SYSPWRDOWNACK),
     .DBGISOLATEn                    (DBGISOLATEn),
     .DBGPWRDOWN                     (DBGPWRDOWN),
     .DBGPWRDOWNACK                  (DBGPWRDOWNACK)
     );

  // For use by the reset controller when asserting HRESETn
  assign HREADY = sys_hready_mux;

//-----------------------------------------------------------------------------
// AHB to ROM Bridge
//-----------------------------------------------------------------------------

  cm0p_ik_ahb_rom_bridge
   #(.AWIDTH                            (20))
    u_ahb2rom
    (//Outputs
    .ROMAD                              (sys_addr_rom[17:0]),
    .ROMCS                              (sys_cs_rom),
    .HRDATA                             (sys_hrdata_rom[31:0]),
    .HREADYOUT                          (sys_hreadyout_rom),
    .HRESP                              (sys_hresp_rom),
    //Inputs
    .HCLK                               (HCLK),
    .HADDR                              (sys_haddr_cortexm0plus[31:0]),
    .HTRANS                             (sys_htrans_cortexm0plus[1:0]),
    .HSEL                               (sys_hsel_rom),
    .HREADY                             (sys_hready_mux),
    .ROMRD                              (sys_rdata_rom[31:0]));

//-----------------------------------------------------------------------------
// ROM Memory
//-----------------------------------------------------------------------------

`ifdef ARM_SRPG_ON
localparam POWERDOWNROM = 1;
`else
localparam POWERDOWNROM = 0;
`endif

  cm0p_ik_rom
   #(.MEMNAME                           ("ROM"),
     .MEMFILE                           ("image.bin"),
     .DATAWIDTH                         (32),
     .ADDRWIDTH                         (18),
     .MEMBASE                           (BASEADDR_ROM),
     .POWERDOWN                         (POWERDOWNROM))
    u_rom
    (//Output
     .RDATA                             (sys_rdata_rom[31:0]),
     //Inputs
     .CLK                               (HCLK),
     .ADDRESS                           (sys_addr_rom[17:0]),
     .CS                                (sys_cs_rom));

//-----------------------------------------------------------------------------
// AHB to SRAM Bridge
//-----------------------------------------------------------------------------

  cm0p_ik_ahb_sram_bridge
   #(.AWIDTH                            (20))
    u_ahb2sram
    (//Outputs
    .RAMAD                              (sys_addr_sram[17:0]),
    .RAMWD                              (sys_wdata_sram[31:0]),
    .RAMCS                              (sys_cs_sram),
    .RAMWE                              (sys_we_sram[3:0]),
    .HRDATA                             (sys_hrdata_ram[31:0]),
    .HREADYOUT                          (sys_hreadyout_ram),
    .HRESP                              (sys_hresp_ram),
    //Inputs
    .HCLK                               (HCLK),
    .HRESETn                            (HRESETn),
    .HADDR                              (sys_haddr_cortexm0plus[31:0]),
    .HBURST                             (sys_hburst_cortexm0plus[2:0]),
    .HMASTLOCK                          (1'b0),
    .HPROT                              (sys_hprot_cortexm0plus[3:0]),
    .HSIZE                              (sys_hsize_cortexm0plus[2:0]),
    .HTRANS                             (sys_htrans_cortexm0plus[1:0]),
    .HWDATA                             (sys_hwdata_cortexm0plus[31:0]),
    .HWRITE                             (sys_hwrite_cortexm0plus),
    .HSEL                               (sys_hsel_ram),
    .HREADY                             (sys_hready_mux),
    .RAMRD                              (sys_rdata_sram[31:0]));

//-----------------------------------------------------------------------------
// SRAM Memory
//-----------------------------------------------------------------------------

  cm0p_ik_sram
   #(.MEMNAME                           ("SRAM"),
     .DATAWIDTH                         (32),
     .ADDRWIDTH                         (18),
     .MEMBASE                           (BASEADDR_SRAM))
    u_ram
    (//Output
     .RDATA                             (sys_rdata_sram[31:0]),
     //Inputs
     .CLK                               (HCLK),
     .ADDRESS                           (sys_addr_sram[17:0]),
     .CS                                (sys_cs_sram),
     .WE                                (sys_we_sram[3:0]),
     .WDATA                             (sys_wdata_sram[31:0]));

//-----------------------------------------------------------------------------
// System ROM Table
//-----------------------------------------------------------------------------

  cm0p_ahb_cs_rom_table
   #(//.JEPID                             (),
     //.JEPCONTINUATION                   (),
     //.PARTNUMBER                        (),
     //.REVISION                          (),
     .BASE                              (BASEADDR_SYSROMTABLE),
     // Entry 0 = Cortex-M0+ Processor
     .ENTRY0BASEADDR    (32'hE00FF000),
     .ENTRY0PRESENT     (1'b1),
     // Entry 1 = CoreSight MTB-M0+
     .ENTRY1BASEADDR    (BASEADDR_MTB),
     .ENTRY1PRESENT     (`ARM_CM0PIK_MTB))
    u_system_rom_table
    (//Outputs
     .HRDATA                            (sys_hrdata_system_rom_table[31:0]),
     .HREADYOUT                         (sys_hreadyout_system_rom_table),
     .HRESP                             (sys_hresp_system_rom_table),
     //Inputs
     .HCLK                              (HCLK),
     .HSEL                              (sys_hsel_system_rom_table),
     .HADDR                             (sys_haddr_cortexm0plus[31:0]),
     .HBURST                            (sys_hburst_cortexm0plus[2:0]),
     .HMASTLOCK                         (sys_hmastlock_cortexm0plus),
     .HPROT                             (sys_hprot_cortexm0plus[3:0]),
     .HSIZE                             (sys_hsize_cortexm0plus[2:0]),
     .HTRANS                            (sys_htrans_cortexm0plus[1:0]),
     .HWDATA                            (sys_hwdata_cortexm0plus[31:0]),
     .HWRITE                            (sys_hwrite_cortexm0plus),
     .HREADY                            (sys_hready_mux),
     .ECOREVNUM                         (rom_table_ecorevnum));

//-----------------------------------------------------------------------------
// MTB SRAM Memory
//-----------------------------------------------------------------------------

generate if (`ARM_CM0PIK_MTB != 0) begin : gen_mtb_sram

  cm0p_ik_sram
   #(.MEMNAME                           ("MTB SRAM"),
     .DATAWIDTH                         (32),
     .ADDRWIDTH                         (`ARM_CM0PIK_MTBAWIDTH-2),
     .MEMBASE                           (BASEADDR_MTBSRAM))
    u_mtbram
    (//Output
     .RDATA                             (sys_rdata_mtbsram[31:0]),
     //Inputs
     .CLK                               (sys_clk_mtbsram),
     .ADDRESS                           (sys_addr_mtbsram[`ARM_CM0PIK_MTBAWIDTH-3:0]),
     .CS                                (sys_cs_mtbsram),
     .WE                                (sys_we_mtbsram[3:0]),
     .WDATA                             (sys_wdata_mtbsram[31:0]));

end else begin : gen_no_mtb_sram

    assign sys_rdata_mtbsram = {32{1'b0}};

end endgenerate

//-----------------------------------------------------------------------------
// AHB Interconnect
//-----------------------------------------------------------------------------

 cm0p_ik_ahb_interconnect
   #(
     .base_m1                           (BASEADDR_ROM),
     .width_m1                          (20),
     .base_m2                           (BASEADDR_SRAM),
     .width_m2                          (20),
     .base_m3                           (BASEADDR_GPIO0),
     .width_m3                          (11),
     .base_m4                           (BASEADDR_GPIO1),
     .width_m4                          (11),
     .base_m5                           (BASEADDR_GPIO2),
     .width_m5                          (11),
     .base_m6                           (BASEADDR_SYSROMTABLE),
     .width_m6                          (12),
     .base_m7                           (BASEADDR_MTB),
     .width_m7                          (13),
     .enable_m7                         (`ARM_CM0PIK_MTB)
     )
   u_ahb_interconnect
   (// Outputs
    .HREADYS                            (sys_hready_mux),
    .HRESPS                             (sys_hresp_mux),
    .HRDATAS                            (sys_hrdata_mux[31:0]),
    .HSELM0                             (sys_hsel_def_slv),
    .HSELM1                             (sys_hsel_rom),
    .HSELM2                             (sys_hsel_ram),
    .HSELM3                             (sys_hsel_gpio0),
    .HSELM4                             (sys_hsel_gpio1),
    .HSELM5                             (sys_hsel_gpio2),
    .HSELM6                             (sys_hsel_system_rom_table),
    .HSELM7                             (sys_hsel_mtb),
    // Inputs
    .HCLK                               (HCLK),
    .HRESETn                            (HRESETn),
    .HADDRS                             (sys_haddr_cortexm0plus[31:0]),
    .HRDATAM0                           (sys_hrdata_def_slv[31:0]),
    .HRDATAM1                           (sys_hrdata_rom[31:0]),
    .HRDATAM2                           (sys_hrdata_ram[31:0]),
    .HRDATAM3                           (sys_hrdata_gpio0[31:0]),
    .HRDATAM4                           (sys_hrdata_gpio1[31:0]),
    .HRDATAM5                           (sys_hrdata_gpio2[31:0]),
    .HRDATAM6                           (sys_hrdata_system_rom_table[31:0]),
    .HRDATAM7                           (sys_hrdata_mtb[31:0]),
    .HREADYOUTM0                        (sys_hreadyout_def_slv),
    .HREADYOUTM1                        (sys_hreadyout_rom),
    .HREADYOUTM2                        (sys_hreadyout_ram),
    .HREADYOUTM3                        (sys_hreadyout_gpio0),
    .HREADYOUTM4                        (sys_hreadyout_gpio1),
    .HREADYOUTM5                        (sys_hreadyout_gpio2),
    .HREADYOUTM6                        (sys_hreadyout_system_rom_table),
    .HREADYOUTM7                        (sys_hreadyout_mtb),
    .HRESPM0                            (sys_hresp_def_slv),
    .HRESPM1                            (sys_hresp_rom),
    .HRESPM2                            (sys_hresp_ram),
    .HRESPM3                            (sys_hresp_gpio0),
    .HRESPM4                            (sys_hresp_gpio1),
    .HRESPM5                            (sys_hresp_gpio2),
    .HRESPM6                            (sys_hresp_system_rom_table),
    .HRESPM7                            (sys_hresp_mtb));


     // Create separate HSELs for MTB SRAM and SFRs
     //  within the region decoded for the MTB.
     assign sys_hsel_mtbram = sys_hsel_mtb & (sys_haddr_cortexm0plus[12] == 1'b1);
     assign sys_hsel_mtbsfr = sys_hsel_mtb & (sys_haddr_cortexm0plus[12] == 1'b0);

//-----------------------------------------------------------------------------
// IOP Interconnect
//-----------------------------------------------------------------------------

generate if (`ARM_CM0PIK_IOP != 0) begin : gen_iop_interconnect

  cm0p_ik_iop_interconnect
   #(.BASEADDR_GPIO0                  (BASEADDR_GPIO0),
     .BASEADDR_GPIO1                  (BASEADDR_GPIO1),
     .BASEADDR_GPIO2                  (BASEADDR_GPIO2))
    u_iop_interconnect
    (//Outpus
     .IOSEL0                          (sys_iosel_gpio0),
     .IOSEL1                          (sys_iosel_gpio1),
     .IOSEL2                          (sys_iosel_gpio2),
     .IOMATCHS                        (sys_iomatch_mux),
     .IORDATAS                        (sys_iordata_mux[31:0]),
     //Inputs
     .IOADDRS                         (sys_ioaddr_cortexm0plus[31:0]),
     .IOCHECKS                        (sys_iocheck_cortexm0plus[31:0]),
     .IORDATAM0                       (sys_iordata_gpio0[31:0]),
     .IORDATAM1                       (sys_iordata_gpio1[31:0]),
     .IORDATAM2                       (sys_iordata_gpio2[31:0]));

end else begin : gen_no_iop_interconnect

    assign sys_iomatch_mux = 1'b0;

    assign sys_iordata_mux = {32{1'b0}};

end endgenerate

//-----------------------------------------------------------------------------
// AHB Default Slave
//-----------------------------------------------------------------------------

  cm0p_ik_ahb_def_slv u_ahb_def_slv
    (// Outputs
     .HREADYOUT                         (sys_hreadyout_def_slv),
     .HRDATA                            (sys_hrdata_def_slv[31:0]),
     .HRESP                             (sys_hresp_def_slv),
     // Inputs
     .HCLK                              (HCLK),
     .HRESETn                           (HRESETn),
     .HSEL                              (sys_hsel_def_slv),
     .HTRANS                            (sys_htrans_cortexm0plus),
     .HREADY                            (sys_hready_mux));

//-----------------------------------------------------------------------------
// Miscellaneous Logic Block
//-----------------------------------------------------------------------------

  cm0p_ik_misc u_misc_logic
   (
    // Outputs
    .loopin_gpio                       (sys_loopin_gpio),
    .delayed_rxev                      (sys_delayed_rxev),
    .rxev                              (sys_rxev),
    .irq                               (sys_irq_misc),
    .nmi                               (sys_nmi),
    .iop_sticky                        (sys_iop_present),
    .iop_sticky_clr                    (sys_iop_clr),
    // Inputs
    .fclk                              (FCLK),
    .hresetn                           (HRESETn),
    .iotrans                           (sys_iotrans_cortexm0plus),
    .loopout_gpio                      (sys_loopout_gpio),
    .rxev_gpio                         (sys_rxev_gpio),
    .irq_gpio                          (sys_irq_gpio),
    .nmi_gpio                          (sys_nmi_gpio));

//-----------------------------------------------------------------------------
// STCLKEN Generation
//-----------------------------------------------------------------------------
  cm0p_ik_stclken_gen  u_stclken
    (//Outputs
     .STCLKEN                           (sys_stclken),
     //Inputs
     .SCLK                              (SCLK),
     .HRESETn                           (HRESETn),
     .STCLK                             (STCLK));

//-----------------------------------------------------------------------------
// GPIO 0
//-----------------------------------------------------------------------------

generate if (`ARM_CM0PIK_IOP != 0) begin : gen_iop_gpio_0

  cm0p_ik_iop_gpio
    u_gpio_0
    (// Outputs
     .IORDATA                           (sys_iordata_gpio0[31:0]),
     .GPIOOUT                           (sys_gpio0out[31:0]),
     .GPIOEN                            (sys_gpio0en[31:0]),
     .GPIOINT                           (sys_gpio0int),
     // Inputs
     .FCLK                              (FCLK),
     .HCLK                              (HCLK),
     .HRESETn                           (HRESETn),
     .IOSEL                             (sys_iosel_gpio0),
     .IOADDR                            (sys_ioaddr_cortexm0plus[31:0]),
     .IOWRITE                           (sys_iowrite_cortexm0plus),
     .IOSIZE                            (sys_iosize_cortexm0plus[1:0]),
     .IOTRANS                           (sys_iotrans_cortexm0plus),
     .IOWDATA                           (sys_iowdata_cortexm0plus[31:0]),
     .GPIOIN                            (sys_gpio0in[31:0]));

  assign sys_hreadyout_gpio0 = 1'b1;
  assign sys_hresp_gpio0     = 1'b0;
  assign sys_hrdata_gpio0    = {32{1'b0}};

end
else
begin : gen_ahb_gpio_0

  cm0p_ik_ahb_gpio u_gpio_0
    (// Outputs
     .HREADYOUT                         (sys_hreadyout_gpio0),
     .HRESP                             (sys_hresp_gpio0),
     .HRDATA                            (sys_hrdata_gpio0[31:0]),
     .GPIOOUT                           (sys_gpio0out[31:0]),
     .GPIOEN                            (sys_gpio0en[31:0]),
     .GPIOINT                           (sys_gpio0int),
     // Inputs
     .FCLK                              (FCLK),
     .HCLK                              (HCLK),
     .HRESETn                           (HRESETn),
     .HSEL                              (sys_hsel_gpio0),
     .HREADY                            (sys_hready_mux),
     .HADDR                             (sys_haddr_cortexm0plus[10:0]),
     .HWRITE                            (sys_hwrite_cortexm0plus),
     .HTRANS                            (sys_htrans_cortexm0plus[1:0]),
     .HSIZE                             (sys_hsize_cortexm0plus[2:0]),
     .HWDATA                            (sys_hwdata_cortexm0plus[31:0]),
     .GPIOIN                            (sys_gpio0in[31:0]));

end endgenerate

//-----------------------------------------------------------------------------
// GPIO 1
//-----------------------------------------------------------------------------

generate if (`ARM_CM0PIK_IOP != 0) begin : gen_iop_gpio_1

  cm0p_ik_iop_gpio
    u_gpio_1
    (// Outputs
     .IORDATA                           (sys_iordata_gpio1[31:0]),
     .GPIOOUT                           (sys_gpio1out[31:0]),
     .GPIOEN                            (),
     .GPIOINT                           (sys_gpio1int),
     // Inputs
     .FCLK                              (FCLK),
     .HCLK                              (HCLK),
     .HRESETn                           (HRESETn),
     .IOSEL                             (sys_iosel_gpio1),
     .IOADDR                            (sys_ioaddr_cortexm0plus[31:0]),
     .IOWRITE                           (sys_iowrite_cortexm0plus),
     .IOSIZE                            (sys_iosize_cortexm0plus[1:0]),
     .IOTRANS                           (sys_iotrans_cortexm0plus),
     .IOWDATA                           (sys_iowdata_cortexm0plus[31:0]),
     .GPIOIN                            (sys_gpio1in[31:0]));

  assign sys_hreadyout_gpio1 = 1'b1;
  assign sys_hresp_gpio1     = 1'b0;
  assign sys_hrdata_gpio1    = {32{1'b0}};

end
else
begin : gen_ahb_gpio_1

  cm0p_ik_ahb_gpio u_gpio_1
    (// Outputs
     .HREADYOUT                         (sys_hreadyout_gpio1),
     .HRESP                             (sys_hresp_gpio1),
     .HRDATA                            (sys_hrdata_gpio1[31:0]),
     .GPIOOUT                           (sys_gpio1out[31:0]),
     .GPIOEN                            (),
     .GPIOINT                           (sys_gpio1int),
     // Inputs
     .FCLK                              (FCLK),
     .HCLK                              (HCLK),
     .HRESETn                           (HRESETn),
     .HSEL                              (sys_hsel_gpio1),
     .HREADY                            (sys_hready_mux),
     .HADDR                             (sys_haddr_cortexm0plus[10:0]),
     .HWRITE                            (sys_hwrite_cortexm0plus),
     .HTRANS                            (sys_htrans_cortexm0plus[1:0]),
     .HSIZE                             (sys_hsize_cortexm0plus[2:0]),
     .HWDATA                            (sys_hwdata_cortexm0plus[31:0]),
     .GPIOIN                            (sys_gpio1in[31:0]));

end endgenerate

//-----------------------------------------------------------------------------
// GPIO 2
//-----------------------------------------------------------------------------

generate if (`ARM_CM0PIK_IOP != 0) begin : gen_iop_gpio_2

  cm0p_ik_iop_gpio
    u_gpio_2
    (// Outputs
     .IORDATA                           (sys_iordata_gpio2[31:0]),
     .GPIOOUT                           (sys_gpio2out[31:0]),
     .GPIOEN                            (),
     .GPIOINT                           (sys_gpio2int),
     // Inputs
     .FCLK                              (FCLK),
     .HCLK                              (HCLK),
     .HRESETn                           (HRESETn),
     .IOSEL                             (sys_iosel_gpio2),
     .IOADDR                            (sys_ioaddr_cortexm0plus[31:0]),
     .IOWRITE                           (sys_iowrite_cortexm0plus),
     .IOSIZE                            (sys_iosize_cortexm0plus[1:0]),
     .IOTRANS                           (sys_iotrans_cortexm0plus),
     .IOWDATA                           (sys_iowdata_cortexm0plus[31:0]),
     .GPIOIN                            (sys_gpio2in[31:0]));

  assign sys_hreadyout_gpio2 = 1'b1;
  assign sys_hresp_gpio2     = 1'b0;
  assign sys_hrdata_gpio2    = {32{1'b0}};

end
else
begin : gen_ahb_gpio_2

  cm0p_ik_ahb_gpio u_gpio_2
    (// Outputs
     .HREADYOUT                         (sys_hreadyout_gpio2),
     .HRESP                             (sys_hresp_gpio2),
     .HRDATA                            (sys_hrdata_gpio2[31:0]),
     .GPIOOUT                           (sys_gpio2out[31:0]),
     .GPIOEN                            (),
     .GPIOINT                           (sys_gpio2int),
     // Inputs
     .FCLK                              (FCLK),
     .HCLK                              (HCLK),
     .HRESETn                           (HRESETn),
     .HSEL                              (sys_hsel_gpio2),
     .HREADY                            (sys_hready_mux),
     .HADDR                             (sys_haddr_cortexm0plus[10:0]),
     .HWRITE                            (sys_hwrite_cortexm0plus),
     .HTRANS                            (sys_htrans_cortexm0plus[1:0]),
     .HSIZE                             (sys_hsize_cortexm0plus[2:0]),
     .HWDATA                            (sys_hwdata_cortexm0plus[31:0]),
     .GPIOIN                            (sys_gpio2in[31:0]));

end endgenerate

//-----------------------------------------------------------------------------
// GPIO signal assignments
//-----------------------------------------------------------------------------
//
// Internal GPIO 0 signal mappings
//
// Interrupt:
//       GPIO0INT               - Drives IRQ0
// Outputs:
//       GPIO0OUT[31:30]        - Not Used
//       GPIO0OUT[29]           - Drives EXTGPIOOUT[29]     (Debug Driver Function Strobe)
//       GPIO0OUT[28]           - Drives EXTGPIOOUT[28] \
//       GPIO0OUT[27]           - Drives EXTGPIOOUT[27]  \
//       GPIO0OUT[26]           - Drives EXTGPIOOUT[26]   > (Debug Driver Function Select)
//       GPIO0OUT[25]           - Drives EXTGPIOOUT[25]  /
//       GPIO0OUT[24]           - Drives EXTGPIOOUT[24] /
//       GPIO0OUT[23:16]        - Not Used
//       GPIO0OUT[15]           - Drives EXTGPIOOUT[15]     (charstrobe)
//       GPIO0OUT[14:8]         - Drives EXTGPIOOUT[14:8]   (chardata)
//       GPIO0OUT[7:2]          - Not Used
//       GPIO0OUT[1]            - Drives EXTGPIOOUT[1]      (TESTPASS)
//       GPIO0OUT[0]            - Drives EXTGPIOOUT[0]      (TESTCOMPLETE)
// Inputs:
//       GPIO0IN[31]            - Reads EXTGPIOIN[31]       (Debug Driver Running)
//       GPIO0IN[30]            - Reads EXTGPIOIN[30]       (Debug Driver Error)
//       GPIO0IN[29:0]          - Not Used
// Enables:
//       GPIO0EN[31:0]          - Drives EXTGPIOEN[31:0]
//
// Internal GPIO 1 signal mappings
//
// Interrupt:
//       GPIO1INT               - Drives IRQ0
// Outputs:
//       GPIO1OUT[31]           - Drives sys_nmi_gpio
//       GPIO1OUT[30]           - Drives sys_loopout_gpio
//       GPIO1OUT[29:27]        - Not Used
//       GPIO1OUT[26]           - Drives DBGRESTART
//       GPIO1OUT[25]           - Not Used
//       GPIO1OUT[24]           - Drives EDBGRQ
//       GPIO1OUT[23:15]        - Not Used
//       GPIO1OUT[14]           - Drives sys_rxev_gpio
//       GPIO1OUT[13:8]         - Not Used
//       GPIO1OUT[7]            - Drives TSTART
//       GPIO1OUT[6]            - Drives TSTOP
//       GPIO1OUT[5:3]          - Not Used
//       GPIO1OUT[2]            - Drives sys_iop_clr
//       GPIO1OUT[1:0]          - Not Used
// Inputs:
//       GPIO1IN[31:30]         - Reads GPIO1OUT[31:30]
//       GPIO1IN[29]            - Reads sys_loopin_gpio
//       GPIO1IN[28:26]         - Reads GPIO1OUT[28:26]
//       GPIO1IN[25]            - Reads DBGRESTARTED
//       GPIO1IN[24:22]         - Reads GPIO1OUT[24:22]
//       GPIO1IN[21]            - Reads HALTED
//       GPIO1IN[20]            - Reads LOCKUP
//       GPIO1IN[19]            - Reads SLEEPDEEP
//       GPIO1IN[18]            - Reads SLEEPING
//       GPIO1IN[17:16]         - Reads GPIO1OUT[17:16]
//       GPIO1IN[15]            - Reads TXEV
//       GPIO1IN[14]            - Reads GPIO1OUT[14]
//       GPIO1IN[13]            - Reads sys_delayed_rxev
//       GPIO1IN[12:2]          - Reads GPIO1OUT[12:2]
//       GPIO1IN[1]             - Reads sys_iop_present
//       GPIO1IN[0]             - Reads GPIO1OUT[0]
//
// Enables:
//       GPIO1EN[31:0]          - Not Used
//
// Internal GPIO 2 signal mappings
//
// Interrupt:
//       GPIO2INT               - Drives IRQ0
// Outputs:
//       GPIO2OUT[31]           - Drives IRQ31
//       GPIO2OUT[30]           - Drives IRQ30
//       GPIO2OUT[29]           - Drives IRQ29
//       GPIO2OUT[28]           - Drives IRQ28
//       GPIO2OUT[27]           - Drives IRQ27
//       GPIO2OUT[26]           - Drives IRQ26
//       GPIO2OUT[25]           - Drives IRQ25
//       GPIO2OUT[24]           - Drives IRQ24
//       GPIO2OUT[23]           - Drives IRQ23
//       GPIO2OUT[22]           - Drives IRQ22
//       GPIO2OUT[21]           - Drives IRQ21
//       GPIO2OUT[20]           - Drives IRQ20
//       GPIO2OUT[19]           - Drives IRQ19
//       GPIO2OUT[18]           - Drives IRQ18
//       GPIO2OUT[17]           - Drives IRQ17
//       GPIO2OUT[16]           - Drives IRQ16
//       GPIO2OUT[15]           - Drives IRQ15
//       GPIO2OUT[14]           - Drives IRQ14
//       GPIO2OUT[13]           - Drives IRQ13
//       GPIO2OUT[12]           - Drives IRQ12
//       GPIO2OUT[11]           - Drives IRQ11
//       GPIO2OUT[10]           - Drives IRQ10
//       GPIO2OUT[9]            - Drives IRQ9
//       GPIO2OUT[8]            - Drives IRQ8
//       GPIO2OUT[7]            - Drives IRQ7
//       GPIO2OUT[6]            - Drives IRQ6
//       GPIO2OUT[5]            - Drives IRQ5
//       GPIO2OUT[4]            - Drives IRQ4
//       GPIO2OUT[3]            - Drives IRQ3
//       GPIO2OUT[2]            - Drives IRQ2
//       GPIO2OUT[1]            - Drives IRQ1
//       GPIO2OUT[0]            - Not Used
// Inputs:
//       GPIO2IN[31:0]          - Reads GPIO2OUT[31:0]
// Enables:
//       GPIO2EN[31:0]          - Not Used
//

  assign sys_irq_gpio          = sys_gpio2out[31:1];

  assign sys_irq0_gpio         = sys_gpio0int | sys_gpio1int | sys_gpio2int;

  assign sys_irq               = {sys_irq_misc[30:0] , sys_irq0_gpio};

  assign sys_gpio0in           = EXTGPIOIN;

  assign EXTGPIOOUT            = sys_gpio0out;

  assign EXTGPIOEN             = sys_gpio0en;

  assign sys_nmi_gpio          = sys_gpio1out[31];
  assign sys_gpio1in[31]       = sys_gpio1out[31];

  assign sys_loopout_gpio      = sys_gpio1out[30];
  assign sys_gpio1in[30]       = sys_gpio1out[30];

  assign sys_gpio1in[29]       = sys_loopin_gpio;

  assign sys_gpio1in[28:27]    = sys_gpio1out[28:27];

  assign sys_dbgrestart        = sys_gpio1out[26];
  assign sys_gpio1in[26]       = sys_gpio1out[26];

  assign sys_gpio1in[25]       = sys_dbgrestarted;

  assign sys_edbgrq            = sys_gpio1out[24];
  assign sys_gpio1in[24]       = sys_gpio1out[24];

  assign sys_gpio1in[23:22]    = sys_gpio1out[23:22];

  assign sys_gpio1in[21]       = sys_halted;

  assign sys_gpio1in[20]       = sys_lockup;

  assign sys_gpio1in[19]       = SLEEPDEEP;

  assign sys_gpio1in[18]       = sys_sleeping;

  assign sys_gpio1in[17:16]    = sys_gpio1out[17:16];

  assign sys_gpio1in[15]       = sys_txev;

  assign sys_rxev_gpio         = sys_gpio1out[14];
  assign sys_gpio1in[14]       = sys_gpio1out[14];

  assign sys_gpio1in[13]       = sys_delayed_rxev;

  assign sys_gpio1in[12:8]     = sys_gpio1out[12:8];

  assign sys_tstart            = sys_gpio1out[7];
  assign sys_gpio1in[7]        = sys_gpio1out[7];

  assign sys_tstop             = sys_gpio1out[6];
  assign sys_gpio1in[6]        = sys_gpio1out[6];

  assign sys_gpio1in[5:3]      = sys_gpio1out[5:3];

  assign sys_iop_clr           = sys_gpio1out[2];
  assign sys_gpio1in[2]        = sys_gpio1out[2];

  assign sys_gpio1in[1]        = sys_iop_present;

  assign sys_gpio1in[0]        = sys_gpio1out[0];

  assign sys_gpio2in           = sys_gpio2out;


//-----------------------------------------------------------------------------
// Tie Offs
//-----------------------------------------------------------------------------

  buf keep_tie_cell_00 (ECOREVNUM[ 0],1'b0);
  buf keep_tie_cell_01 (ECOREVNUM[ 1],1'b0);
  buf keep_tie_cell_02 (ECOREVNUM[ 2],1'b0);
  buf keep_tie_cell_03 (ECOREVNUM[ 3],1'b0);
  buf keep_tie_cell_04 (ECOREVNUM[ 4],1'b0);
  buf keep_tie_cell_05 (ECOREVNUM[ 5],1'b0);
  buf keep_tie_cell_06 (ECOREVNUM[ 6],1'b0);
  buf keep_tie_cell_07 (ECOREVNUM[ 7],1'b0);
  buf keep_tie_cell_08 (ECOREVNUM[ 8],1'b0);
  buf keep_tie_cell_09 (ECOREVNUM[ 9],1'b0);
  buf keep_tie_cell_10 (ECOREVNUM[10],1'b0);
  buf keep_tie_cell_11 (ECOREVNUM[11],1'b0);
  buf keep_tie_cell_12 (ECOREVNUM[12],1'b0);
  buf keep_tie_cell_13 (ECOREVNUM[13],1'b0);
  buf keep_tie_cell_14 (ECOREVNUM[14],1'b0);
  buf keep_tie_cell_15 (ECOREVNUM[15],1'b0);
  buf keep_tie_cell_16 (ECOREVNUM[16],1'b0);
  buf keep_tie_cell_17 (ECOREVNUM[17],1'b0);
  buf keep_tie_cell_18 (ECOREVNUM[18],1'b0);
  buf keep_tie_cell_19 (ECOREVNUM[19],1'b0);
  buf keep_tie_cell_20 (ECOREVNUM[20],1'b0);
  buf keep_tie_cell_21 (ECOREVNUM[21],1'b0);
  buf keep_tie_cell_22 (ECOREVNUM[22],1'b0);
  buf keep_tie_cell_23 (ECOREVNUM[23],1'b0);
  buf keep_tie_cell_24 (ECOREVNUM[24],1'b0);
  buf keep_tie_cell_25 (ECOREVNUM[25],1'b0);
  buf keep_tie_cell_26 (ECOREVNUM[26],1'b0);
  buf keep_tie_cell_27 (ECOREVNUM[27],1'b0);
  buf keep_tie_cell_28 (ECOREVNUM[28],1'b0);
  buf keep_tie_cell_29 (ECOREVNUM[29],1'b0);
  buf keep_tie_cell_30 (ECOREVNUM[30],1'b0);
  buf keep_tie_cell_31 (ECOREVNUM[31],1'b0);

  buf keep_tie_cell_32 (rom_table_ecorevnum[0],1'b0);
  buf keep_tie_cell_33 (rom_table_ecorevnum[1],1'b0);
  buf keep_tie_cell_34 (rom_table_ecorevnum[2],1'b0);
  buf keep_tie_cell_35 (rom_table_ecorevnum[3],1'b0);

//-----------------------------------------------------------------------------
// AHB Protocol Checker
//-----------------------------------------------------------------------------

`ifdef ARM_CM0PIK_AHBLitePC_ON
  // Checker for Cortex-M0+'s AHB Master port
  AhbLitePC
   #(.ADDR_WIDTH                           (32),
     .DATA_WIDTH                           (32),
     .BIG_ENDIAN                           ( 0),
     .MASTER_TO_INTERCONNECT               ( 1),
     .EARLY_BURST_TERMINATION              ( 0),
     // Property type (0=assert, 1=assume, 2=ignore)
     .MASTER_REQUIREMENT_PROPTYPE          ( 0),
     .MASTER_RECOMMENDATION_PROPTYPE       ( 0),
     .MASTER_XCHECK_PROPTYPE               ( 0),
     .SLAVE_REQUIREMENT_PROPTYPE           ( 0),
     .SLAVE_RECOMMENDATION_PROPTYPE        ( 0),
     .SLAVE_XCHECK_PROPTYPE                ( 0),
     .INTERCONNECT_REQUIREMENT_PROPTYPE    ( 0),
     .INTERCONNECT_RECOMMENDATION_PROPTYPE ( 0),
     .INTERCONNECT_XCHECK_PROPTYPE         ( 0))
      u_ahblite_pc_cortexm0plus
  (
   .HCLK                                (FCLK),
   .HRESETn                             (PORESETn),
   .HSELx                               (1'bx),
   .HADDR                               (sys_haddr_cortexm0plus[31:0]),
   .HTRANS                              (sys_htrans_cortexm0plus[1:0]),
   .HWRITE                              (sys_hwrite_cortexm0plus),
   .HSIZE                               (sys_hsize_cortexm0plus[2:0]),
   .HBURST                              (sys_hburst_cortexm0plus[2:0]),
   .HPROT                               (sys_hprot_cortexm0plus[3:0]),
   .HWDATA                              (sys_hwdata_cortexm0plus[31:0]),
   .HRDATA                              (sys_hrdata_mux[31:0]),
   .HREADY                              (sys_hready_mux),
   .HREADYOUT                           (1'bx),
   .HRESP                               (sys_hresp_mux),
   .HMASTLOCK                           (sys_hmastlock_cortexm0plus)
  );
`endif // ARM_CM0PIK_AHBLitePC_ON

//-----------------------------------------------------------------------------
// I/O Port Protocol Checker
//-----------------------------------------------------------------------------

`ifdef ARM_CM0PIK_IOPPC_ON
  cm0p_ioppc
   #(.DRIVEMASTER        (1'b0),
     .DRIVESLAVE         (1'b0))
     u_cm0p_ioppc
  (
   // Inputs
   .IOCLK                               (HCLK),
   .IORESETn                            (HRESETn),
   .IOCHECK                             (sys_iocheck_cortexm0plus[31:0]),
   .IOMATCH                             (sys_iomatch_mux),
   .IOTRANS                             (sys_iotrans_cortexm0plus),
   .IOADDR                              (sys_ioaddr_cortexm0plus[31:0]),
   .IOSIZE                              (sys_iosize_cortexm0plus[1:0]),
   .IOWRITE                             (sys_iowrite_cortexm0plus),
   .IOPRIV                              (sys_iopriv_cortexm0plus),
   .IOMASTER                            (sys_iomaster_cortexm0plus),
   .IORDATA                             (sys_iordata_mux[31:0]),
   .IOWDATA                             (sys_iowdata_cortexm0plus[31:0]));
`endif // ARM_CM0PIK_IOPPC_ON

//-----------------------------------------------------------------------------
// Slave Port Protocol Checker
//-----------------------------------------------------------------------------

`ifdef ARM_CM0PIK_SLVPC_ON

`define ARM_CM0PIK_SLV_PATH u_cm0pmtbintegration.u_cm0pintegration.u_imp.u_cortexm0plus

  cm0p_slvpc
   #(.AHBSLV          (0),
     .DRIVEMASTER     (0),
     .DRIVESLAVE      (0))
     u_slvpc
     ( .DCLK       (`ARM_CM0PIK_SLV_PATH.DCLK),
       .DBGRESETn  (`ARM_CM0PIK_SLV_PATH.DBGRESETn),
       .SLVADDR    (`ARM_CM0PIK_SLV_PATH.SLVADDR[31:0]),
       .SLVSIZE    (`ARM_CM0PIK_SLV_PATH.SLVSIZE[1:0]),
       .SLVPROT    (`ARM_CM0PIK_SLV_PATH.SLVPROT[3:0]),
       .SLVTRANS   (`ARM_CM0PIK_SLV_PATH.SLVTRANS[1:0]),
       .SLVWDATA   (`ARM_CM0PIK_SLV_PATH.SLVWDATA[31:0]),
       .SLVWRITE   (`ARM_CM0PIK_SLV_PATH.SLVWRITE),
       .SLVRDATA   (`ARM_CM0PIK_SLV_PATH.SLVRDATA[31:0]),
       .SLVREADY   (`ARM_CM0PIK_SLV_PATH.SLVREADY),
       .SLVRESP    (`ARM_CM0PIK_SLV_PATH.SLVRESP));
`endif // ARM_CM0PIK_SLVPC_ON

endmodule
