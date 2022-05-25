// $Id: x7_top.v 900 2015-04-23 03:09:36Z nxp20190 $
//
// @brief Sango X7 Main top.
//
// @Author Roger Williams <roger.williams@nxp.com>
//
// (c) 2015 NXP Semiconductors. All rights reserved.
//
// PROPRIETARY INFORMATION
//
// The information contained in this file is the property of NXP Semiconductors.
// Except as specifically authorized in writing by NXP, the holder of this file:
// (1) shall keep all information contained herein confidential and shall protect
// same in whole or in part from disclosure and dissemination to all third parties
// and (2) shall use same for operation and maintenance purposes only.
// -----------------------------------------------------------------------------
// 0.01.0  2015-04-16 (RAW) Initial entry
// 0.02.0  2015-04-18 (RAW) System clock, IO_UPDATE
// 0.03.0  2015-05-14 (RAW) Incorporated xdig HDL
// 0.04.0  2016-02-27 (JEC) Updated pin names to match Sango X7 schematic
//                          Added DDR3 and MMC interface pins
//-------------------------------------------------------------------------------

`include "version.v"
`include "timescale.v"
`include "registers_def.v"


module x7_main
  (
   // 100MHz clock from synthesiser
   input  wire FPGA_CLKP_i,
   input  wire FPGA_CLKN_i,
   // Asynchronous reset
   input  wire RESETN_i,
   // signals between MCU and FPGA
   output reg  MISO_o,
   input  wire MOSI_i,
   input  wire SCLK_i,
   input  wire SPI_SSN_i,
   input  wire FLASH_SEL_i,
   input  wire MCU_CLK_i, // currently unused
   // SPI to synthesiser
   input  wire SYN_MISO_i,
   output wire SYN_MOSI_o,
   output wire SYN_SCLK_o,
   output wire DDS_SSN_o,
   output wire RSYN_SSN_o,
   output wire FR_SSN_o,
   output wire MSYN_SSN_o,
   output wire MBW_SSN_o,
   // DDS interface
   output wire DDS_IORST_o,
   output reg  DDS_IOUP_o,
   input  wire DDS_SYNC_i,
   output wire [2:0] DDS_PS_o,
   // output module SPI interfaces
   input  wire [4:1] CH_MISO_i,
   output wire [4:1] CH_MOSI_o,
   output wire [4:1] CH_SCLK_o,
   output wire [4:1] CH_SSN_o,
   output wire [4:1] CH_GATE_o,
   output wire [4:1] BIASON_o,
   inout  wire [4:1] CH_CTRL1_io, // currently unused
   inout  wire [4:1] CH_CTRL0_io, // currently unused
   // interlocks, front panel
   input  wire EXT_UNLOCK_i,
   output wire RF_LED_GRN_o,
   output wire RF_LED_RED_o,
   // 667kHz switching regulator sync clock
   output wire PSYNC_o,
   // 24MHz clock output to USB hub XIN
   output wire USB_CLK_o, // currently unused
   // RF on signals
   output wire RF_IS_ON_o,
   input  wire RF_ON_i,
   // external interfaces
   input  wire SYNCINX_i, // Currently unused
   output reg  SYNCOUTX_o,
   // PA interfaces
   output wire [4:1] CONV_o,
   output wire [4:1] SCK_F_o,
   output wire [4:1] SCK_R_o,
   input  wire [4:1] SDO_F_i,
   input  wire [4:1] SDO_R_i,
   output wire [4:1] VBUS_EN_o,
   input  wire [4:1] TRIGX_i,
   // DDR3 interface
   output wire [14:0] A_o,
   output wire [2:0]  BA_o,
   inout  wire [15:0] DQ_i,
   output wire [1:0]  DM_o,
   output wire [1:0]  DQS_o,
   output wire [1:0]  DQSN_o,
   output wire        CSN_o,
   output wire        WEN_o,
   output wire        CASN_o,
   output wire        RASN_o,
   output wire        CK_o,
   output wire        CKN_o,
   output wire        CKE_o,
   output wire        ODT_o,
   // MMC interface (FPGA acts as MMC slave)
   inout  wire [7:0]  MMC_DAT_io,
   inout  wire        MMC_CMD_io,
   input  wire        MMC_CLK_i,
   output wire        MMC_IRQN_o
   );

   //------------------------------------------------------------------------------
   // FPGA_RST signal
   wire FPGA_RST;
   assign FPGA_RST = ~RESETN_i;

   //------------------------------------------------------------------------------
   // Drive values onto unused signals
   assign USB_CLK_o = 1'b0;
   assign MMC_IRQN_o = 1'b1;
   assign CONV_o = 0;
   assign VBUS_EN_o = 4'b1;

   assign A_o    =  15'b0;
   assign BA_o   =  3'b0;
   assign DQ_i   = 16'bZ;
   assign DM_o   =  2'b0;
   assign DQS_o  =  2'b0;
   assign DQSN_o =  2'b1;
   assign CSN_o  =  1'b1;
   assign WEN_o  =  1'b1;
   assign CASN_o =  1'b1;
   assign RASN_o =  1'b1;
   assign CK_o   =  1'b0;
   assign CKN_o  =  1'b1;
   assign CKE_o  =  1'b0;
   assign ODT_o  =  1'b0;

   //------------------------------------------------------------------------------
   // system clock generation
   wire    clkfb, clkin;
   (* keep = "true" *) wire   clk;   // 100MHz system clock
   (* keep = "true" *) wire   clk200; // 200MHz system clock
   (* keep = "true" *) wire  clk10;  // 10MHz clock
   IBUFGDS IBUFGDS_sysclk (.O(clkin),.I(FPGA_CLKP_i),.IB(FPGA_CLKN_i));
   MMCME2_BASE #(.CLKIN1_PERIOD(10.000),.CLKOUT0_DIVIDE_F(8.0),.CLKOUT1_DIVIDE(4.0),
     .CLKOUT4_DIVIDE(15),.CLKFBOUT_MULT_F(8),.CLKOUT6_DIVIDE(80),
     .CLKOUT4_CASCADE("TRUE"))
   MMCME2_BASE_sysclk (.CLKOUT0(clk),.CLKOUT1(clk200),.CLKOUT4(PSYNC_o),.CLKOUT6(clk10),
           .CLKFBOUT(clkfb),.CLKIN1(clkin),.CLKFBIN(clkfb));
   
   //------------------------------------------------------------------------------
   // simple interlock LED logic
   assign RF_IS_ON_o = RF_ON_i & ~EXT_UNLOCK_i;
   assign RF_LED_GRN_o = RF_IS_ON_o;
   assign RF_LED_RED_o = ~RF_IS_ON_o;

   //------------------------------------------------------------------------------
   // simple MCU to external SPI interface
   reg [5:0]   spi_addr = 6'b0;
   reg [3:0]   spi_count = 4'b0;
   reg         spi_data_valid = 1'b0;
   wire        fpga_miso;
   wire        spi_addr_valid = (spi_count >= 6);
   wire        spi_addr_done = (spi_count >= 8);
   wire        spi_sel = (FLASH_SEL_i & ~SPI_SSN_i);
   wire        fpga_ss;
   always @(posedge SCLK_i or negedge spi_sel) begin
      if (~spi_sel) begin
        spi_count <= 0;
        spi_addr <= 0;
      end
      else begin
        if (~spi_addr_done)
          spi_count <= spi_count + 1;
        if (~spi_addr_valid)
          spi_addr[5:0] <= {spi_addr[4:0], MOSI_i};
      end
   end
   always @(negedge SCLK_i or negedge spi_sel)
      if (~spi_sel)
        spi_data_valid <= 0;
      else if (spi_addr_done)
        spi_data_valid <= 1;
   // multiplex MCU SPI lines
   assign DDS_SSN_o = ~(spi_data_valid & (spi_addr == 6'h00));
   assign RSYN_SSN_o = ~(spi_data_valid & (spi_addr == 6'h01));
   assign FR_SSN_o = ~(spi_data_valid & (spi_addr == 6'h02));
   assign MSYN_SSN_o = ~(spi_data_valid & (spi_addr == 6'h03));
   assign MBW_SSN_o = ~(spi_data_valid & (spi_addr == 6'h04));
   assign fpga_ss = spi_data_valid & (spi_addr == 6'h10);
   assign CH_SSN_o[1] = ~(spi_data_valid & (spi_addr[5:3] == 3'b100));
   assign CH_SSN_o[2] = ~(spi_data_valid & (spi_addr[5:3] == 3'b101));
   assign CH_SSN_o[3] = ~(spi_data_valid & (spi_addr[5:3] == 3'b110));
   assign CH_SSN_o[4] = ~(spi_data_valid & (spi_addr[5:3] == 3'b111));
   assign SYN_MOSI_o = spi_data_valid & MOSI_i & (spi_addr[5:3] == 3'b000);
   assign CH_MOSI_o[1] = spi_data_valid & MOSI_i & (spi_addr[5:3] == 3'b100);
   assign CH_MOSI_o[2] = spi_data_valid & MOSI_i & (spi_addr[5:3] == 3'b101);
   assign CH_MOSI_o[3] = spi_data_valid & MOSI_i & (spi_addr[5:3] == 3'b110);
   assign CH_MOSI_o[4] = spi_data_valid & MOSI_i & (spi_addr[5:3] == 3'b111);
   assign SYN_SCLK_o = spi_data_valid & SCLK_i & (spi_addr[5:3] == 3'b000);
   assign CH_SCLK_o[1] = spi_data_valid & SCLK_i & (spi_addr[5:3] == 3'b100);
   assign CH_SCLK_o[2] = spi_data_valid & SCLK_i & (spi_addr[5:3] == 3'b101);
   assign CH_SCLK_o[3] = spi_data_valid & SCLK_i & (spi_addr[5:3] == 3'b110);
   assign CH_SCLK_o[4] = spi_data_valid & SCLK_i & (spi_addr[5:3] == 3'b111);
   always @*
      casex (spi_addr)
        6'b010000: MISO_o = spi_data_valid & fpga_miso;
        6'b000xxx: MISO_o = spi_data_valid & SYN_MISO_i;
        6'b100xxx: MISO_o = spi_data_valid & CH_MISO_i[1];
        6'b101xxx: MISO_o = spi_data_valid & CH_MISO_i[2];
        6'b110xxx: MISO_o = spi_data_valid & CH_MISO_i[3];
        6'b111xxx: MISO_o = spi_data_valid & CH_MISO_i[4];
        default: MISO_o = 1'b0;
      endcase

   // generate 2xDDS_SYNC_i tick I/O_UPDATE strobe at end of DDS SPI write
   reg    dds_ssn_dly = 1'b1;
   reg    dds_ssn_dly2 = 1'b1;
   reg     dds_ioup_dly = 1'b0;
   always @(posedge DDS_SYNC_i or posedge FPGA_RST) begin
     if (FPGA_RST) begin
       dds_ssn_dly <= 1'b0;
       dds_ssn_dly2 <= 1'b0;
       dds_ioup_dly <= 1'b0;
       DDS_IOUP_o <= 1'b0;
     end
     else begin
       dds_ssn_dly <= DDS_SSN_o;
       dds_ssn_dly2 <= dds_ssn_dly;
       dds_ioup_dly <= DDS_IOUP_o;
       if (dds_ssn_dly & ~dds_ssn_dly2)
         DDS_IOUP_o <= 1;
       else if (dds_ioup_dly)
         DDS_IOUP_o <= 0;
       end
     end

   // tie DDS interface to defaults for now
   assign DDS_IORST_o = 1'b0;
   assign DDS_PS_o = 3'b000;

   //------------------------------------------------------------------------------
   // SPI-to-register interface
   reg [3:0]   fpga_spacount = 3'b0;
   reg [3:0]   fpga_spdcount = 4'b0;
   reg [6:0]   fpga_spaddr = 7'b0;
   reg [15:0]   fpga_spdin = 16'b0;
   reg     fpga_spdin_valid = 1'b0;
   reg     fpga_sprw = 1'b0;
   reg [15:0]   fpga_spdout = 16'b0;
   reg     fpga_spdout_load = 1'b0;
   assign   fpga_miso = fpga_spdout[15];
   wire   fpga_spadone = (fpga_spacount >= 8);
   wire   fpga_spdin_last = (fpga_spdcount == 15);
   wire   fpga_spdout_first = fpga_spadone & (fpga_spdcount == 0);
   reg [15:0]   dat_o = 16'b0;

   // SPI MOSI_i in -> register write
   // MCU shifts MOSI_i on falling edge of SCLK_i, so sample it on rising edge
   always @(posedge SCLK_i or negedge fpga_ss) begin
      if (~fpga_ss) begin
        fpga_spacount <= 0;
        fpga_spdcount <= 0;
        fpga_spaddr <= 0;
        fpga_sprw <= 0;
        fpga_spdin_valid <= 0;
      end
      else begin
        if (fpga_spadone) begin
          // in data phase, generate write strobe for incoming data every 16th bit
          fpga_spdin_valid <= fpga_spdin_last;
          fpga_spdin[15:0] <= {fpga_spdin[14:0], MOSI_i};
          fpga_spdcount <= fpga_spdcount + 1;
        end
        else begin
          // still in address phase
          fpga_spacount <= fpga_spacount + 1;
          fpga_sprw <= fpga_spaddr[6];
          fpga_spaddr[6:0] <= {fpga_spaddr[5:0], MOSI_i};
        end
      end
   end

   // register read -> SPI MISO_o out
   // MCU samples MISO_o on rising edge of SCLK_i, so shift it on falling edge
   always @(negedge SCLK_i or posedge fpga_spdout_load)
      if (fpga_spdout_load)
   fpga_spdout <= dat_o;
      else if (fpga_spadone)
   fpga_spdout[15:0] <= {fpga_spdout[14:0], 1'b0};

   // reclock in 100MHz domain
   reg     we = 1'b0;
   reg     cs = 1'b0;
   reg     oe = 1'b0;     
   reg [6:0]  adr = 7'b0;
   reg [15:0] dat = 16'b0;
   reg     fpga_spdin_valid_dly = 1'b0;
   reg     fpga_spdout_first_dly = 1'b0;
   reg     fpga_spdout_rd_dly = 1'b0;
   always @(posedge clk) begin
      cs <= fpga_spadone;
      adr <= fpga_spaddr;
      fpga_spdin_valid_dly <= fpga_spdin_valid;
      we <= fpga_spdin_valid & ~fpga_spdin_valid_dly;
      dat <= fpga_spdin;
      // generate 1-tick read strobe before next SCLK_i rising edge
      fpga_spdout_first_dly <= fpga_spdout_first;
      oe <= fpga_sprw & fpga_spdout_first & ~fpga_spdout_first_dly;
      fpga_spdout_load <= oe;
   end

   //------------------------------------------------------------------------------
   // code from xdig
   wire [`REG_BITS_R]   reg_r;
   wire [`REG_BITS_W]   reg_w;
   assign reg_r[`VERSION_INDEX] = `VERSION;
   wire [15:0]     stat;
   assign reg_r[`STAT_INDEX] = stat;
   wire [15:0]     irq;
   assign reg_r[`IRQ_INDEX] = irq;

   // reclock strobes in 100MHz domain
   reg [15:0]     ctrl = 16'b0;
   wire      ctrl_RST = ctrl[15];    // reset everything
   wire      ctrl_ABT = ctrl[14];    // abort bursts, clear arm
   wire      ctrl_TRIG = ctrl[8];    // manually trigger specified channels
   wire      ctrl_ARM = ctrl[0];    // arm specified channels for triggering
   always @(posedge clk) begin
     ctrl <= reg_w[`CTRL_INDEX];
   end

   reg [15:0]     irq_clr = 16'b0;
   always @(posedge clk)
     irq_clr <= reg_w[`IRQ_CLR_INDEX];

   // bit field assignments for CONF register
   wire [15:0]    conf = reg_w[`CONF_INDEX];
   wire     conf_MEAS_EN = conf[12];  // enable Zmon measurements on specified channels
   wire     conf_SRC_EN = conf[8];    // enable RF outputs on specified channels
   wire     conf_CONT = conf[4];    // enable continuous retriggering on specified channels
   wire     conf_TG_EN = conf[0];    // enable timing generators on specified channels

   // bit field assignments for TRIG_SRC register
   // 0 = off (manual only), 1-4 = specified TRIG input
   wire [15:0]    trig_src = reg_w[`TRIG_SRC_INDEX];

   // bit field assignments for IRQ_MASK register
   wire [15:0]    irq_mask = reg_w[`IRQ_MASK_INDEX];

   // bit field assignments for SYNC register
   // 0=MCU, 1=GEN, 4-7=TRIG1-4, 8-11=TDONE1-4, 12-15=MDONE1-4, 16-19=CONV[1:4], 20-23=GATE[1:4]
   wire [15:0]    sync = reg_w[`SYNC_INDEX];
   wire [7:0]     sync_GEN = sync[15:8];
   wire [4:0]     sync_SRC = sync[4:0];

   // bit field assignments for FILTER register
   wire [15:0]    filter_len = reg_w[`FILTER_INDEX];

   // assign RF channel bias enables
   assign VBUS1_EN_o = conf_TG_EN;

   // pulse generator
   reg [13:0]     gprescale = 14'b0;
   reg [7:0]     gcount = 8'b0;
   reg       gen = 1'b0;
   wire     gtick1ms = (gprescale == 14'b0);
   
   always @(posedge clk10)
     if (gtick1ms)
       gprescale <= 9999;
     else
       gprescale <= gprescale - 1;

   always @(posedge clk10)
     if (gtick1ms) begin
       if (gcount == 5)
         gen <= 1;
       else if (gcount == 0)
         gen <= 0;
       if (gcount == 0) begin
         if (sync_GEN > 4)
           gcount <= sync_GEN;
       end
     else
       gcount <= gcount - 1;
     end

   // input trigger filters
   wire [2:1]     trigflt;
   reg [2:1]     trigflt_dly = 2'b0;
   wire [2:1]     trig_rising = trigflt & ~trigflt_dly;
   wire [2:1]     trig_falling = ~trigflt & trigflt_dly;
   trig_filter filter1 (.I(TRIG1X_i), .O(trigflt[1]), .C(clk10), .N(filter_len));
   assign trigflt[2] = gen;

   // latch decoded trigger at valid rising edge
   always @(posedge clk) begin
      trigflt_dly <= trigflt;
   end
   
   // demux signals to timing generators
   reg      trig_mux;
   always @* begin
     case (trig_src[1*4-1 -: 4])
       4'd1: trig_mux = trig_falling[1];
       4'd5: trig_mux = trig_falling[2];
       default: trig_mux = 1'b0;
     endcase
   end

   reg      trig = 1'b0;
   always @(posedge clk)
      trig <= ctrl_TRIG | trig_mux;

   // demux signals for clearing MCU_TRIGIN
   reg      rising_mux;
   always @* begin
     case (trig_src[1*4-1 -: 4])
       4'd1: rising_mux = trig_rising[1];
       4'd5: rising_mux = trig_rising[2];
       default: rising_mux = 1'b0;
     endcase
   end

   // register block decodes
   reg         reg_sel;
   reg  [4:1]  tg_sel;
   wire [15:0] tg_dat[4:1];
   wire [15:0] reg_dat_o;

   always @* begin
      reg_sel = 0;
      tg_sel = 0;
      dat_o = 16'b0;
      if (adr[6] == 0) begin
        reg_sel = cs;
        dat_o = reg_dat_o;
      end
      else begin
        case (adr[5:4])
          2'd0: begin
            tg_sel[1] = cs;
            dat_o = tg_dat[1];
          end
          2'd1: begin
            tg_sel[2] = cs;
            dat_o = tg_dat[2];
          end
          2'd2: begin
            tg_sel[3] = cs;
            dat_o = tg_dat[3];
          end
          2'd3: begin
            tg_sel[4] = cs;
            dat_o = tg_dat[4];
          end
        endcase
      end
   end

   localparam WC = 8, WS = 8;

   wire [1*WC:1]  control;
   wire [1*WS-1:0]   status;
   wire [15:0]    irq_in;

   assign control[1*WC -: WC] = {ctrl_RST, ctrl_ABT, ctrl_ARM, trig, conf_MEAS_EN,
         conf_SRC_EN, conf_CONT, conf_TG_EN};
   assign stat[1*4-1 -: 4] = status[1*WS-5 -: 4];  // state machine value for each channel
   assign irq_in[1*4-1 -: 4] = status[1*WS-1 -: 4];  // interrupts from each channel

   // 0=MCU, 1=GEN, 4-7=TRIG1-4, 8-11=TDONE1-4, 12-15=MDONE1-4, 16-19=CONV[1:4], 20-23=GATE[1:4]
   always @*
     case (sync_SRC)
       5'd1:  SYNCOUTX_o = gen;          // GEN
       5'd4:  SYNCOUTX_o = trig;         // TRIG
       5'd8:  SYNCOUTX_o = irq_in[0];    // TDONE
       5'd12: SYNCOUTX_o = irq_in[12];   // MDONE
       5'd16: SYNCOUTX_o = CONV_o[1];    // CONV
       5'd20: SYNCOUTX_o = CH_GATE_o[1]; // RF_GATE
       default: SYNCOUTX_o = 1'b0;
     endcase

   wire [4:1] adc_sck;
   assign SCK_F_o = adc_sck;
   assign SCK_R_o = adc_sck;

   rs irq_latch[15:0] (.Q(irq), .S(irq_mask & irq_in), .R({16{ctrl_RST}} | irq_clr), .C(clk));
   // assign FPGA_IRQN = ~|(irq_mask & irq_in);    // IRQ pulse for each event
   assign MMC_IRQN_o = ~|irq;        // latched IRQ

   // Apply default values to unused signals
   assign CH_GATE_o[2] = 1'bZ;
   assign CH_GATE_o[3] = 1'bZ;
   assign CH_GATE_o[4] = 1'bZ;
   assign BIASON_o[1]  = 1'bZ;
   assign BIASON_o[2]  = 1'bZ;
   assign BIASON_o[3]  = 1'bZ;
   assign BIASON_o[4]  = 1'bZ;
   assign CH_CTRL1_io[1] = 1'bZ;
   assign CH_CTRL1_io[2] = 1'bZ;
   assign CH_CTRL1_io[3] = 1'bZ;
   assign CH_CTRL1_io[4] = 1'bZ;
   assign CH_CTRL0_io[1] = 1'bZ;
   assign CH_CTRL0_io[2] = 1'bZ;
   assign CH_CTRL0_io[3] = 1'bZ;
   assign CH_CTRL0_io[4] = 1'bZ;

//  genvar i;
//  for (i=1; i<=4; i=i+1) begin
//    tg tg1 (
//      .clk(clk),
//      .rst_i(fpga_rst),
//      .clk200(clk200),
//      .adr_i(adr[3:0]),
//      .dat_i(dat),
//      .we_i(we),
//      .oe_i(oe),
//      .cs_i(tg_sel[1]),
//      .dat_o(tg_dat[1]),
//      .control(control),
//      .status(status),
//      .rf_gate(CH_GATE_o[1]),
//      .adc_sck_o(adc_sck[1]),
//      .conv_o(CONV_o[1]),
//      .adcr_sdo_i(SDO_R_i[1]),
//      .adcf_sdo_i(SDO_F_i[1])
//    );
//  end

  registers reggie (
    .clk_i(clk200),
    .rst_i(fpga_rst),
    .adr_i(adr[5:0]),
    .dat_i(dat),
    .we_i(we),
    .oe_i(oe),
    .cs_i(reg_sel),
    .dat_o(reg_dat_o),
    .reg_w(reg_w),
    .reg_r(reg_r)
  );

  // MMC card command receiver
  wire  [47:0] mmc_cmd_raw;
  wire         mmc_cmd_done;
  wire         mmc_cmd_crc_err;
  wire         mmc_cmd_dir_err;
  wire         mmc_cmd_stop_err;

  sd_card_cmd_rx mmc_rx1
  (
    // Asynchronous reset
    .sys_rst_n(RESETN_i),
    // SD/MMC card command signals
    .sd_clk_i(MMC_CLK_i),
    .sd_cmd_i(MMC_CMD_io),
    // Command outputs
    .cmd_raw_o(mmc_cmd_raw),
    .cmd_index_o(),
    .cmd_arg_o(),
    .cmd_done_o(mmc_cmd_done),
    .crc_err_o(mmc_cmd_crc_err),
    .dir_err_o(mmc_cmd_dir_err),
    .stop_err_o(mmc_cmd_stop_err)
  );

  // MMC card emulator
  wire         mmc_cmd;
  wire         mmc_cmd_drv;
  wire         mmc_cmd_zzz;
  wire         mmc_cmd_choice;
  wire   [7:0] mmc_dat;
  wire   [7:0] mmc_dat_zzz;
  wire   [7:0] mmc_dat_choice1;
  wire   [7:0] mmc_dat_choice2;
  reg    [7:0] mmc_dat_choice3;
  wire         mmc_od_mode;
  wire         mmc_dat_drv;
  wire   [1:0] mmc_dat_siz;

  wire  [31:0] card_fifo_adr;
  wire   [7:0] card_fifo_dat_wr;
  wire         card_fifo_we;
  wire   [7:0] card_fifo_dat_rd;
  wire         card_fifo_rd;


  // Implement MMC card tri-state drivers at the top level
  assign mmc_cmd_zzz    = mmc_cmd?1'bZ:1'b0;
  assign mmc_cmd_choice = mmc_od_mode?mmc_cmd_zzz:mmc_cmd;
  assign MMC_CMD_io     = mmc_cmd_drv?mmc_cmd_choice:1'bZ;
    // Create "open drain" data vector
  genvar j;
  for(j=0;j<8;j=j+1) begin
    assign mmc_dat_zzz[j] = mmc_dat[j]?1'bZ:1'b0;
  end
    // Select which data vector to use
  assign mmc_dat_choice1 = mmc_od_mode?mmc_dat_zzz:mmc_dat;
  assign mmc_dat_choice2 = mmc_dat_drv?mmc_dat_choice1:8'bZ;
    // Use always block for readability
  always @(mmc_dat_siz, mmc_dat_choice2)
         if (mmc_dat_siz==0) mmc_dat_choice3 <= {7'bZ,mmc_dat_choice2[0]};
    else if (mmc_dat_siz==1) mmc_dat_choice3 <= {4'bZ,mmc_dat_choice2[3:0]};
    else                     mmc_dat_choice3 <= mmc_dat_choice2;

  assign MMC_DAT_io = mmc_dat_choice3;

  sd_card_emulator #(
    .USE_R4_RESPONSE      (1),    // Fast I/O read/write (app specific)
    .USE_R5_RESPONSE      (0),    // Interrupt Request Mode
    .EXT_CSD_INIT_FILE    ("ext_csd_init.txt"), // Initial contents of EXT_CSD
    .OCR_USE_DUAL_VOLTAGE (1),
    .OCR_USE_SECTOR_MODE  (0),
    .CID_MID              (),     // Manufacturer ID
    .CID_OID              (),     // OEM ID
    .CID_CBX              (),     // 0=Card, 1=BGA, 2=Package On Package
    .CID_PNM              (),     // Product Name, 6 ASCII chars
    .CID_PRV              (),     // Product Rev (2 BCD digits, e.g. 6.2=0x62)
    .CID_PSN              (),     // Product serial number
    .CID_MDT              (),     // Manufacture Date (Jan=1, 1997=0, e.g. Apr. 2000=0x43)
    .DEF_STAT             (),     // Read Write, R_0
    .CSD_WORD_3           (),     // Read only
    .CSD_WORD_2           (),     // Read only
    .CSD_WORD_1           (),     // Read only
    .CSD_WORD_0           (),     // (31:16) is read only, (15:0) is R_1 default (R/W)
    .DEF_R_Z              ()      // Value returned for nonexistent registers
  ) mmc_card_0 (

    // Asynchronous reset
    .sys_rst_n(RESETN_i),
    .sys_clk(clk200),

    // Bus interface
    .adr_i(4'b0),
    .sel_i(1'b0),
    .we_i(1'b0),
    .dat_i(32'b0),
    .dat_o(),
    .ack_o(),

    // SD/MMC card command signals
    .sd_clk_i     (MMC_CLK_i),
    .sd_cmd_i     (MMC_CMD_io),
    .sd_cmd_o     (mmc_cmd),
    .sd_cmd_drv_o (mmc_cmd_drv),
    .sd_od_mode_o (mmc_od_mode),  // open drain mode, applies to sd_cmd_o and sd_dat_o
    .sd_dat_i     (MMC_DAT_io),
    .sd_dat_o     (mmc_dat),
    .sd_dat_drv_o (mmc_dat_drv),
    .sd_dat_siz_o (mmc_dat_siz),

    // Data FIFO interface
    .buf_adr_o    (card_fifo_adr),
    .buf_dat_o    (card_fifo_dat_wr),
    .buf_dat_we_o (card_fifo_we),
    .buf_dat_i    (card_fifo_dat_rd),
    .buf_dat_rd_o (card_fifo_rd),
    // Card busy indicator
    .busy_i       (1'b0)
  );


endmodule

module rs
  (
   input wire  S, R, C,
   output reg  Q = 1'b0
   );

   always @(posedge C)
     if (R)
       Q <= 0;
     else if (S)
       Q <= 1;
   
endmodule
