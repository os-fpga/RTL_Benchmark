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
//      Checked In          : $Date: 2012-12-12 17:05:57 +0000 (Wed, 12 Dec 2012) $
//
//      Revision            : $Revision: 231420 $
//
//      Release Information : Cortex-M0+ AT590-r0p1-00rel0
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//      Debug Driver
//-----------------------------------------------------------------------------
//
// This block is used to control the DAP in the MCU by driving the JTAG/SW
// signals appropriately.
// The most significant 8 bits of EXTGPIO from the MCU are used to program the
// "debug driver" system which instantiates the CORTEX-M0+INTEGRATION
// integration level, memory and GPIO. This arrangement enables the JTAG/SW
// signals to be controlled even when the processor (in the MCU) is sleeping.
//
// This block instantiates the following:
//  o u_cm0pmtbintegration        - CORTEX-M0+MTBINTEGRATION
//  o u_ahb2rom                   - AHB to ROM Bridge
//  o u_rom                       - ROM Memory
//  o u_ahb2sram                  - AHB to SRAM Bridge
//  o u_ram                       - RAM Memory
//  o u_ahb_interconnect          - AHB Bus Interconnect Block
//  o u_ahb_def_slv               - AHB Default Slave
//  o u_gpio                      - AHB or IOP GPIO
//-----------------------------------------------------------------------------
`include "cm0p_ik_defs.v"

module cm0p_ik_debug_driver
  (input  wire       CLK,
   input  wire       PORESETn,
   input  wire       FUNCTIONSTROBE,
   input  wire [4:0] FUNCTIONSELECT,
   input  wire      TDO,
   output wire      RUNNING,
   output wire      ERROR,
   output wire      nTRST,
   output wire      SWCLKTCK,
   output wire      TDI,
   inout  wire      SWDIOTMS);

   localparam BASEADDR_ROM      = 32'h0000_0000;
   localparam BASEADDR_SRAM     = 32'h2000_0000;
   localparam BASEADDR_GPIO     = 32'h4000_0000;

//-----------------------------------------------------------------------------
// Signal declarations
//-----------------------------------------------------------------------------

  wire [31:0]           haddr;
  wire [ 2:0]           hburst;
  wire [ 3:0]           hprot;
  wire [ 2:0]           hsize;
  wire [ 1:0]           htrans;
  wire [31:0]           hwdata;
  wire                  hwrite;
  wire                  iomatch;
  wire                  iotrans;
  wire                  iowrite;
  wire [ 1:0]           iosize;
  wire [31:0]           iocheck;
  wire [31:0]           ioaddr;
  wire [31:0]           iordata, iordata_mux;
  wire [31:0]           iowdata;
  wire [31:0]           hrdata_mux, hrdata_rom, hrdata_ram,
                        hrdata_gpio, hrdata_def_slv;
  wire                  hresp_mux, hresp_rom, hresp_ram,
                        hresp_gpio, hresp_def_slv;
  wire                  hready_mux, hready_out_rom, hready_out_ram,
                        hready_out_gpio, hready_out_def_slv;
  wire                  hsel_rom, hsel_ram, hsel_gpio, hsel_def_slv;
  wire [31:0]           GPIOOUT;
  wire [31:0]           GPIOIN;
  wire [31:0]           GPIOEN;
  wire [31:0]           extgpio;
  wire [31:0]           rom_rdata;
  wire [17:0]           rom_addr;
  wire                  rom_cs;
  wire [31:0]           sram_rdata, sram_wdata;
  wire [17:0]           sram_addr;
  wire                  sram_cs;
  wire [ 3:0]           sram_we;

  // ----------------------------------------------------------------------
  // Cortex-M0+ MTB Integration level instantiation
  // ----------------------------------------------------------------------

`ifdef ARM_CM0PIK_DSM
defparam u_cm0pmtbintegration.u_cm0pintegration.u_imp.u_cortexm0plus.ID = 7;
`endif // ARM_CM0PIK_DSM

  CM0PMTBINTEGRATION
   #(.BE                             (`ARM_CM0PIK_BE),
     .IOP                            (`ARM_CM0PIK_IOP),
     .MTB                            (0))
      u_cm0pmtbintegration
    (
     .FCLK                           (CLK),
     .SCLK                           (CLK),
     .HCLK                           (CLK),
     .DCLK                           (CLK),
     .PORESETn                       (PORESETn),
     .DBGRESETn                      (PORESETn),
     .HRESETn                        (PORESETn),
     .SWCLKTCK                       (1'b0),
     .nTRST                          (1'b1),
     .HADDR                          (haddr[31:0]),
     .HBURST                         (hburst[2:0]),
     .HMASTLOCK                      (),
     .HPROT                          (hprot[3:0]),
     .HSIZE                          (hsize[2:0]),
     .HTRANS                         (htrans[1:0]),
     .HWDATA                         (hwdata[31:0]),
     .HWRITE                         (hwrite),
     .HRDATA                         (hrdata_mux[31:0]),
     .HREADY                         (hready_mux),
     .HRESP                          (hresp_mux),
     .HMASTER                        (),
     .SHAREABLE                      (),
     .SRAMBASEADDR                   ({32{1'b0}}),
     .HADDRMTB                       ({32{1'b0}}),
     .HPROTMTB                       ({4{1'b0}}),
     .HSIZEMTB                       ({3{1'b0}}),
     .HTRANSMTB                      ({2{1'b0}}),
     .HWDATAMTB                      ({32{1'b0}}),
     .HSELRAM                        (1'b0),
     .HSELSFR                        (1'b0),
     .HWRITEMTB                      (1'b0),
     .HREADYMTB                      (1'b0),
     .HRDATAMTB                      (),
     .HREADYOUTMTB                   (),
     .HRESPMTB                       (),
     .RAMHCLK                        (),
     .RAMRD                          ({32{1'b0}}),
     .RAMAD                          (),
     .RAMWD                          (),
     .RAMCS                          (),
     .RAMWE                          (),
     .TSTART                         (1'b0),
     .TSTOP                          (1'b0),
     .CODENSEQ                       (),
     .CODEHINT                       (),
     .SPECHTRANS                     (),
     .DATAHINT                       (),
     .SWDITMS                        (1'b0),
     .TDI                            (1'b0),
     .SWDO                           (),
     .SWDOEN                         (),
     .SWDETECT                       (),
     .TDO                            (),
     .nTDOEN                         (),
     .DBGRESTART                     (1'b0),
     .DBGRESTARTED                   (),
     .EDBGRQ                         (1'b0),
     .HALTED                         (),
     .NIDEN                          (1'b1),
     .DBGEN                          (1'b1),
     .NMI                            (1'b0),
     .IRQ                            ({32{1'b0}}),
     .TXEV                           (),
     .RXEV                           (1'b0),
     .LOCKUP                         (),
     .SYSRESETREQ                    (),
     .STCALIB                        (`ARM_CM0PIK_STCALIB),
     .STCLKEN                        (1'b0),
     .IRQLATENCY                     (`ARM_CM0PIK_IRQLATENCY),
     .INSTANCEID                     (`ARM_CM0PIK_INSTANCEID),
     .ECOREVNUM                      ({32{1'b0}}),
     .CPUWAIT                        (1'b0),
     .SLVSTALL                       (1'b0),
     .GATEHCLK                       (),
     .SLEEPING                       (),
     .SLEEPDEEP                      (),
     .WAKEUP                         (),
     .WICSENSE                       (),
     .SLEEPHOLDREQn                  (1'b1),
     .SLEEPHOLDACKn                  (),
     .WICENREQ                       (1'b0),
     .WICENACK                       (),
     .CDBGPWRUPREQ                   (),
     .CDBGPWRUPACK                   (1'b1),
     .IOMATCH                        (iomatch),
     .IORDATA                        (iordata[31:0]),
     .IOTRANS                        (iotrans),
     .IOWRITE                        (iowrite),
     .IOCHECK                        (iocheck[31:0]),
     .IOADDR                         (ioaddr[31:0]),
     .IOSIZE                         (iosize[1:0]),
     .IOMASTER                       (),
     .IOPRIV                         (),
     .IOWDATA                        (iowdata[31:0]),
     .DFTSE                          (1'b0),
     .DFTRSTDISABLE                  (1'b0),
     .SYSRETAINn                     (1'b1),
     .SYSISOLATEn                    (1'b1),
     .SYSPWRDOWN                     (1'b0),
     .SYSPWRDOWNACK                  (),
     .DBGISOLATEn                    (1'b1),
     .DBGPWRDOWN                     (1'b0),
     .DBGPWRDOWNACK                  ()
     );

//-----------------------------------------------------------------------------
// AHB to ROM Bridge
//-----------------------------------------------------------------------------

  cm0p_ik_ahb_rom_bridge
   #(.AWIDTH                            (20))
    u_ahb2rom
    (//Outputs
    .ROMAD                              (rom_addr[17:0]),
    .ROMCS                              (rom_cs),
    .HRDATA                             (hrdata_rom[31:0]),
    .HREADYOUT                          (hready_out_rom),
    .HRESP                              (hresp_rom),
    //Inputs
    .HCLK                               (CLK),
    .HADDR                              (haddr[31:0]),
    .HTRANS                             (htrans[1:0]),
    .HSEL                               (hsel_rom),
    .HREADY                             (hready_mux),
    .ROMRD                              (rom_rdata[31:0]));

//-----------------------------------------------------------------------------
// ROM Memory
//-----------------------------------------------------------------------------

  cm0p_ik_rom
   #(.MEMNAME                           ("DEBUG DRIVER ROM"),
     .MEMFILE                           ("debugdriver.bin"),
     .DATAWIDTH                         (32),
     .ADDRWIDTH                         (18),
     .MEMBASE                           (BASEADDR_ROM),
     .POWERDOWN                         (0))
    u_rom
    (//Output
     .RDATA                             (rom_rdata[31:0]),
     //Inputs
     .CLK                               (CLK),
     .ADDRESS                           (rom_addr[17:0]),
     .CS                                (rom_cs));

//-----------------------------------------------------------------------------
// AHB to SRAM Bridge
//-----------------------------------------------------------------------------

  cm0p_ik_ahb_sram_bridge
   #(.AWIDTH                            (20))
    u_ahb2sram
    (//Outputs
    .RAMAD                              (sram_addr),
    .RAMWD                              (sram_wdata),
    .RAMCS                              (sram_cs),
    .RAMWE                              (sram_we),
    .HRDATA                             (hrdata_ram[31:0]),
    .HREADYOUT                          (hready_out_ram),
    .HRESP                              (hresp_ram),
    //Inputs
    .HCLK                               (CLK),
    .HRESETn                            (PORESETn),
    .HADDR                              (haddr[31:0]),
    .HBURST                             (hburst[2:0]),
    .HMASTLOCK                          (1'b0),
    .HPROT                              (hprot[3:0]),
    .HSIZE                              (hsize[2:0]),
    .HTRANS                             (htrans[1:0]),
    .HWDATA                             (hwdata[31:0]),
    .HWRITE                             (hwrite),
    .HSEL                               (hsel_ram),
    .HREADY                             (hready_mux),
    .RAMRD                              (sram_rdata));

//-----------------------------------------------------------------------------
// SRAM Memory
//-----------------------------------------------------------------------------

  cm0p_ik_sram
   #(.MEMNAME                           ("DEBUG DRIVER SRAM"),
     .DATAWIDTH                         (32),
     .ADDRWIDTH                         (18),
     .MEMBASE                           (BASEADDR_SRAM))
    u_ram
    (//Output
     .RDATA                             (sram_rdata),
     //Inputs
     .CLK                               (CLK),
     .ADDRESS                           (sram_addr),
     .CS                                (sram_cs),
     .WE                                (sram_we),
     .WDATA                             (sram_wdata));

//-----------------------------------------------------------------------------
// AHB Interconnect
//-----------------------------------------------------------------------------

 cm0p_ik_ahb_interconnect
   #(
     .base_m1                           (BASEADDR_ROM),
     .width_m1                          (20),
     .base_m2                           (BASEADDR_SRAM),
     .width_m2                          (20),
     .base_m3                           (BASEADDR_GPIO),
     .width_m3                          (11),
     .enable_m4                         (0),
     .enable_m5                         (0),
     .enable_m6                         (0),
     .enable_m7                         (0)
     )
   u_ahb_interconnect
   (// Outputs
    .HREADYS                            (hready_mux),
    .HRESPS                             (hresp_mux),
    .HRDATAS                            (hrdata_mux[31:0]),
    .HSELM0                             (hsel_def_slv),
    .HSELM1                             (hsel_rom),
    .HSELM2                             (hsel_ram),
    .HSELM3                             (hsel_gpio),
    .HSELM4                             (),
    .HSELM5                             (),
    .HSELM6                             (),
    .HSELM7                             (),
    // Inputs
    .HCLK                               (CLK),
    .HRESETn                            (PORESETn),
    .HADDRS                             (haddr[31:0]),
    .HRDATAM0                           (hrdata_def_slv[31:0]),
    .HRDATAM1                           (hrdata_rom[31:0]),
    .HRDATAM2                           (hrdata_ram[31:0]),
    .HRDATAM3                           (hrdata_gpio[31:0]),
    .HRDATAM4                           (32'h0000_0000),
    .HRDATAM5                           (32'h0000_0000),
    .HRDATAM6                           (32'h0000_0000),
    .HRDATAM7                           (32'h0000_0000),
    .HREADYOUTM0                        (hready_out_def_slv),
    .HREADYOUTM1                        (hready_out_rom),
    .HREADYOUTM2                        (hready_out_ram),
    .HREADYOUTM3                        (hready_out_gpio),
    .HREADYOUTM4                        (1'b1),
    .HREADYOUTM5                        (1'b1),
    .HREADYOUTM6                        (1'b1),
    .HREADYOUTM7                        (1'b1),
    .HRESPM0                            (hresp_def_slv),
    .HRESPM1                            (hresp_rom),
    .HRESPM2                            (hresp_ram),
    .HRESPM3                            (hresp_gpio),
    .HRESPM4                            (1'b0),
    .HRESPM5                            (1'b0),
    .HRESPM6                            (1'b0),
    .HRESPM7                            (1'b0));

//-----------------------------------------------------------------------------
// AHB Default Slave
//-----------------------------------------------------------------------------

  cm0p_ik_ahb_def_slv u_ahb_def_slv
    (// Outputs
     .HREADYOUT                         (hready_out_def_slv),
     .HRDATA                            (hrdata_def_slv[31:0]),
     .HRESP                             (hresp_def_slv),
     // Inputs
     .HCLK                              (CLK),
     .HRESETn                           (PORESETn),
     .HSEL                              (hsel_def_slv),
     .HTRANS                            (htrans),
     .HREADY                            (hready_mux));

//-----------------------------------------------------------------------------
// GPIO
//-----------------------------------------------------------------------------

generate if (`ARM_CM0PIK_IOP != 0) begin : gen_iop_gpio

  cm0p_ik_iop_interconnect
   #(.BASEADDR_GPIO0 (BASEADDR_GPIO),
     .BASEADDR_GPIO1 (BASEADDR_GPIO),
     .BASEADDR_GPIO2 (BASEADDR_GPIO))
    u_iop_interconnect
    (//Outputs
     .IOSEL0                            (iosel),
     .IOSEL1                            (),
     .IOSEL2                            (),
     .IOMATCHS                          (iomatch),
     .IORDATAS                          (iordata[31:0]),
     //Inputs
     .IOADDRS                           (ioaddr[31:0]),
     .IOCHECKS                          (iocheck[31:0]),
     .IORDATAM0                         (iordata_mux[31:0]),
     .IORDATAM1                         ({32{1'b0}}),
     .IORDATAM2                         ({32{1'b0}}));

  cm0p_ik_iop_gpio u_gpio_0
    (// Outputs
     .IORDATA                           (iordata_mux[31:0]),
     .GPIOOUT                           (GPIOOUT[31:0]),
     .GPIOEN                            (GPIOEN[31:0]),
     .GPIOINT                           (),
     // Inputs
     .FCLK                              (CLK),
     .HCLK                              (CLK),
     .HRESETn                           (PORESETn),
     .IOSEL                             (iosel),
     .IOADDR                            (ioaddr[31:0]),
     .IOWRITE                           (iowrite),
     .IOSIZE                            (iosize[1:0]),
     .IOTRANS                           (iotrans),
     .IOWDATA                           (iowdata[31:0]),
     .GPIOIN                            (GPIOIN[31:0]));

  assign hready_out_gpio = 1'b1;
  assign hresp_gpio      = 1'b0;
  assign hrdata_gpio     = {32{1'b0}};

end
else
begin : gen_ahb_gpio

  cm0p_ik_ahb_gpio u_gpio
    (// Outputs
     .HREADYOUT                         (hready_out_gpio),
     .HRESP                             (hresp_gpio),
     .HRDATA                            (hrdata_gpio[31:0]),
     .GPIOOUT                           (GPIOOUT[31:0]),
     .GPIOEN                            (GPIOEN[31:0]),
     .GPIOINT                           (),
     // Inputs
     .FCLK                              (CLK),
     .HCLK                              (CLK),
     .HRESETn                           (PORESETn),
     .HSEL                              (hsel_gpio),
     .HREADY                            (hready_mux),
     .HADDR                             (haddr[10:0]),
     .HWRITE                            (hwrite),
     .HTRANS                            (htrans[1:0]),
     .HSIZE                             (hsize[2:0]),
     .HWDATA                            (hwdata[31:0]),
     .GPIOIN                            (GPIOIN[31:0]));

  assign iomatch = 1'b0;
  assign iordata = {32{1'b0}};

end endgenerate

//-----------------------------------------------------------------------------
// GPIO connections
//-----------------------------------------------------------------------------
//
// Internal GPIO signal mappings
//
// Interrupt:
//        GPIOINT               - Not Used
// Outputs:
//        GPIOOUT[31]           - Drives RUNNING
//        GPIOOUT[30]           - Drives ERROR
//        GPIOOUT[29:23]        - Not Used
//        GPIOOUT[22]           - Drives SWDIOTMS enable
//        GPIOOUT[21]           - Drives SWDIOTMS
//        GPIOOUT[20:19]        - Not Used
//        GPIOOUT[18]           - Drives TDI
//        GPIOOUT[17]           - Drives SWCLKTCK
//        GPIOOUT[16]           - Drives nTRST
//        GPIOOUT[15:0]         - Not Used
// Inputs:
//        GPIOIN[31:30]         - Not Used
//        GPIOIN[29]            - Reads FUNCTIONSTROBE
//        GPIOIN[28:24]         - Reads FUNCTIONSELECT[4:0]
//        GPIOIN[23:21]         - Not Used
//        GPIOIN[20]            - Reads SWDIOTMS
//        GPIOIN[19]            - Reads TDO
//        GPIOIN[18:0]          - Not Used
// Enables:
//        GPIOEN[31:0]          - Drives bufif1's

  //
  // Pull down inputs from ARMIKMCU to avoid capturing X at start of simulation
  //

  pulldown (FUNCTIONSTROBE);
  pulldown (FUNCTIONSELECT[4]);
  pulldown (FUNCTIONSELECT[3]);
  pulldown (FUNCTIONSELECT[2]);
  pulldown (FUNCTIONSELECT[1]);
  pulldown (FUNCTIONSELECT[0]);

  bufif1 (extgpio[ 0], GPIOOUT[ 0], GPIOEN[ 0]);
  bufif1 (extgpio[ 1], GPIOOUT[ 1], GPIOEN[ 1]);
  bufif1 (extgpio[ 2], GPIOOUT[ 2], GPIOEN[ 2]);
  bufif1 (extgpio[ 3], GPIOOUT[ 3], GPIOEN[ 3]);
  bufif1 (extgpio[ 4], GPIOOUT[ 4], GPIOEN[ 4]);
  bufif1 (extgpio[ 5], GPIOOUT[ 5], GPIOEN[ 5]);
  bufif1 (extgpio[ 6], GPIOOUT[ 6], GPIOEN[ 6]);
  bufif1 (extgpio[ 7], GPIOOUT[ 7], GPIOEN[ 7]);
  bufif1 (extgpio[ 8], GPIOOUT[ 8], GPIOEN[ 8]);
  bufif1 (extgpio[ 9], GPIOOUT[ 9], GPIOEN[ 9]);
  bufif1 (extgpio[10], GPIOOUT[10], GPIOEN[10]);
  bufif1 (extgpio[11], GPIOOUT[11], GPIOEN[11]);
  bufif1 (extgpio[12], GPIOOUT[12], GPIOEN[12]);
  bufif1 (extgpio[13], GPIOOUT[13], GPIOEN[13]);
  bufif1 (extgpio[14], GPIOOUT[14], GPIOEN[14]);
  bufif1 (extgpio[15], GPIOOUT[15], GPIOEN[15]);
  bufif1 (extgpio[16], GPIOOUT[16], GPIOEN[16]);
  bufif1 (extgpio[17], GPIOOUT[17], GPIOEN[17]);
  bufif1 (extgpio[18], GPIOOUT[18], GPIOEN[18]);
  bufif1 (extgpio[19], GPIOOUT[19], GPIOEN[19]);
  bufif1 (extgpio[20], GPIOOUT[20], GPIOEN[20]);
  bufif1 (extgpio[21], GPIOOUT[21], GPIOEN[21]);
  bufif1 (extgpio[22], GPIOOUT[22], GPIOEN[22]);
  bufif1 (extgpio[23], GPIOOUT[23], GPIOEN[23]);
  bufif1 (extgpio[24], GPIOOUT[24], GPIOEN[24]);
  bufif1 (extgpio[25], GPIOOUT[25], GPIOEN[25]);
  bufif1 (extgpio[26], GPIOOUT[26], GPIOEN[26]);
  bufif1 (extgpio[27], GPIOOUT[27], GPIOEN[27]);
  bufif1 (extgpio[28], GPIOOUT[28], GPIOEN[28]);
  bufif1 (extgpio[29], GPIOOUT[29], GPIOEN[29]);
  bufif1 (extgpio[30], GPIOOUT[30], GPIOEN[30]);
  bufif1 (extgpio[31], GPIOOUT[31], GPIOEN[31]);

  assign  RUNNING       = extgpio[31];
  assign  GPIOIN[31]    = extgpio[31];

  assign  ERROR         = extgpio[30];
  assign  GPIOIN[30]    = extgpio[30];

  assign  GPIOIN[29]    = FUNCTIONSTROBE;

  assign  GPIOIN[28:24] = FUNCTIONSELECT;

  assign  GPIOIN[23]   = 1'b0;

  bufif1 (SWDIOTMS, extgpio[21], extgpio[22]);
  assign  GPIOIN[22]   = extgpio[22];
  assign  GPIOIN[21]   = extgpio[21];

  assign  GPIOIN[20]   = SWDIOTMS;

  assign  GPIOIN[19]   = TDO;

  assign  TDI          = extgpio[18];
  assign  GPIOIN[18]   = extgpio[18];

  assign  SWCLKTCK     = extgpio[17];
  assign  GPIOIN[17]   = extgpio[17];

  assign  nTRST        = extgpio[16];
  assign  GPIOIN[16]   = extgpio[16];

  assign  GPIOIN[15:0] = {16{1'b0}};

//-----------------------------------------------------------------------------
// Tarmac for Core in Debug Driver
//-----------------------------------------------------------------------------

`ifdef ARM_CM0PIK_TARMAC

`define ARM_CM0PIK_DBGDRV_PATH u_cm0pmtbintegration.u_cm0pintegration.u_imp.u_cortexm0plus

 cm0p_tarmac
   u_tarmac
     (.en_i           (1'b1),
      .echo_i         (1'b0),
      .id_i           (32'h1),
      .use_time_i     (1'b1),
      .tube_i         (32'h40400000),
      .halted_i       (`ARM_CM0PIK_DBGDRV_PATH.HALTED),
      .lockup_i       (`ARM_CM0PIK_DBGDRV_PATH.LOCKUP),
      .hclk           (`ARM_CM0PIK_DBGDRV_PATH.HCLK),
      .hready_i       (`ARM_CM0PIK_DBGDRV_PATH.HREADY),
      .haddr_i        (`ARM_CM0PIK_DBGDRV_PATH.HADDR[31:0]),
      .hprot_i        (`ARM_CM0PIK_DBGDRV_PATH.HPROT[3:0]),
      .hsize_i        (`ARM_CM0PIK_DBGDRV_PATH.HSIZE[2:0]),
      .hwrite_i       (`ARM_CM0PIK_DBGDRV_PATH.HWRITE),
      .htrans_i       (`ARM_CM0PIK_DBGDRV_PATH.HTRANS[1:0]),
      .hresetn_i      (`ARM_CM0PIK_DBGDRV_PATH.HRESETn),
      .hresp_i        (`ARM_CM0PIK_DBGDRV_PATH.HRESP),
      .hrdata_i       (`ARM_CM0PIK_DBGDRV_PATH.HRDATA[31:0]),
      .hwdata_i       (`ARM_CM0PIK_DBGDRV_PATH.HWDATA[31:0]),
      .ppb_trans_i    (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_matrix.ppb_trans),
      .scs_rdata_i    (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_matrix.scs_rdata),
      .ahb_trans_i    (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.ahb_trans),
      .ipsr_i         (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.ipsr_q[5:0]),
      .tbit_i         (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.tbit_q),
      .fault_i        (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.fault_q),
      .cc_pass_i      (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.cc_pass),
      .spsel_i        (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.spsel_q),
      .npriv_i        (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.npriv_q),
      .primask_i      (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.primask_q),
      .apsr_i         (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.apsr_q[3:0]),
      .state_i        (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.state_q[3:0]),
      .op_i           (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.op_q[15:0]),
      .op_s_i         (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.op_s_q),
      .iq_i           (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.iq_q[15:0]),
      .iq_s_i         (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.iq_s_q),
      .psp_en_i       (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.psp_en),
      .msp_en_i       (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.msp_en),
      .wr_data_i      (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.wr_data[31:0]),
      .wr_data_sp_i   (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.wr_data_sp[29:0]),
      .wr_addr_en_i   (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.wr_addr_en[3:0]),
      .iaex_i         (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.iaex_q[30:0]),
      .preempt_i      (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.preempt),
      .int_ready_i    (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.int_ready_q),
      .irq_ack_i      (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.irq_ack),
      .rfe_ack_i      (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.rfe_ack),
      .int_pend_num_i (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.nvm_int_pend_num_i[5:0]),
      .atomic_i       (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.atomic_q),
      .hardfault_i    (`ARM_CM0PIK_DBGDRV_PATH.u_top.u_sys.u_core.hdf_req),
      .iotrans_i      (`ARM_CM0PIK_DBGDRV_PATH.IOTRANS),
      .iowrite_i      (`ARM_CM0PIK_DBGDRV_PATH.IOWRITE),
      .iosize_i       (`ARM_CM0PIK_DBGDRV_PATH.IOSIZE[1:0]),
      .ioaddr_i       (`ARM_CM0PIK_DBGDRV_PATH.IOADDR[31:0]),
      .iordata_i      (`ARM_CM0PIK_DBGDRV_PATH.IORDATA[31:0]),
      .iowdata_i      (`ARM_CM0PIK_DBGDRV_PATH.IOWDATA[31:0]),
      .slvtrans_i     (`ARM_CM0PIK_DBGDRV_PATH.SLVTRANS[1:0]),
      .slvwrite_i     (`ARM_CM0PIK_DBGDRV_PATH.SLVWRITE),
      .slvsize_i      (`ARM_CM0PIK_DBGDRV_PATH.SLVSIZE[1:0]),
      .slvaddr_i      (`ARM_CM0PIK_DBGDRV_PATH.SLVADDR[31:0]),
      .slvrdata_i     (`ARM_CM0PIK_DBGDRV_PATH.SLVRDATA[31:0]),
      .slvwdata_i     (`ARM_CM0PIK_DBGDRV_PATH.SLVWDATA[31:0]),
      .slvready_i     (`ARM_CM0PIK_DBGDRV_PATH.SLVREADY),
      .slvresp_i      (`ARM_CM0PIK_DBGDRV_PATH.SLVRESP)
  );

`endif // ARM_CM0PIK_TARMAC

endmodule
