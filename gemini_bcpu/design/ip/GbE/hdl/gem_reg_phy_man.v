//------------------------------------------------------------------------------
// Copyright (c) 2017 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           gem_reg_phy_man.v
//   Module Name:        gem_reg_phy_man
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP7014
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      SIP-Ethernet-MAC+DMA+1588+TSN+PCS-10M/100M/1G-IP7014
//
//------------------------------------------------------------------------------
//   Description    : Contains PHY management related registers logic.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_phy_man (

  input               pclk,                 // APB clock
  input               n_preset,             // Active low reset
  input   [11:0]      i_paddr,              // Full APB address
  input               psel,                 // APB select
  input               write_registers,      // write to apb registers.
  input               read_registers,       // read from apb registers.
  input   [31:0]      pwdata,               // APB write data
  input               man_port_en,          // management port enable
  input   [2:0]       mdc_clock_div,        // clock division for MDC from PCLK
  input               mdio_in,              // status of MDIO pin.
  output  reg         mdio_en,              // enable signal for MDIO pin.
  output              mdio_out,             // MDIO pin output.
  output              mdc,                  // management data clock.
  output              man_done,             // Phy management transfer complete, a
                                            // bit in the network status register.
  output  reg [31:0]  prdata_phy_man,       // APB read data
  output  reg         perr_phy_man          // Perr signal
);


  // Internal signals
  reg   [31:0]    manage_reg;           // Phy maintenance register.
  wire            write_phy_management; // apb write to phy manage registers.
  reg   [7:0]     man_cnt_top;          // counter for driving the phy
                                        // maintenance register.
  reg   [6:0]     man_cnt_bot;          // counter for dividing down pclk for
                                        // generating mdc.
  reg             reset_count;          // Reset man_cnt_bot.
  reg             inc_man_cnt_top;      // signal for incrementing man_cnt_top
  reg             mdio_in_store;        // mdio_in registered on the rising
                                        // edge of mdc.
  reg             management_read;      // set when the management operation
                                        // is a read.


  // Decode APB address to determine write to PHY management register
  assign write_phy_management = write_registers &
                                (i_paddr == `gem_phy_management);


  // phy maintenance logic follows.
  // main control of this is with an eight bit register called man_cnt_top.
  // the msb of this register man_cnt_top[7] resets to 1 which indicates
  // the management function is idle. When man_cnt_top[7] is low a mangement
  // frame is being processed. When man_cnt_top[6] is low management
  // preamble is being sent. The management clock mdc is driven by
  // man_cnt_top[0] as this toggles so does mdc.


  // man_cnt_bot is used to divide down pclk
  // count when msb of man_cnt_top is not set or when extending idle.
  always@(posedge pclk or negedge n_preset)
  begin
    if(~n_preset)
      man_cnt_bot <= 7'b0000000;
    else if(~(man_cnt_top[7] & man_cnt_top[1]) & ~reset_count)
      man_cnt_bot <= man_cnt_bot + 7'h01;
    else
      man_cnt_bot <= 7'b0000000;
  end


  // assert inc_man_cnt_top after a programmable number of clock cycles
  // MDC is driven by LSB of man_cnt_top so there is a further divide by two.
  always@(*)
  begin
    reset_count = 1'b0;
    case (mdc_clock_div[2:0])

      // assert every 4 pclk's, total divide by 8 pclk's
      3'b000: inc_man_cnt_top = (man_cnt_bot[1:0] == 2'b11);

      // assert every 8 pclk's, total divide by 16 pclk's
      3'b001: inc_man_cnt_top = (man_cnt_bot[2:0] == 3'b111);

      // assert every 16 pclk's, total divide by 32 pclk's
      3'b010: inc_man_cnt_top = (man_cnt_bot[3:0] == 4'b1111);

      // assert every 24 pclk's, total divide by 48 pclk's
      3'b011:  // pulse inc_man_cnt_top if man_cnt_bot equals 24
        if(man_cnt_bot[6:0] == 7'b0010111)
        begin
          inc_man_cnt_top = 1'b1;
          reset_count = 1'b1;
        end
        else
        begin
          inc_man_cnt_top = 1'b0;
          reset_count = 1'b0;
        end

      // assert every 32 pclk's, total divide by 64 pclk's.
      3'b100: inc_man_cnt_top = (man_cnt_bot[4:0] == 5'b11111);

      // assert every 48 pclk's, total divide by 96 pclk's.
      3'b101:
      if(man_cnt_bot[6:0] == 7'b0101111)
      begin
        inc_man_cnt_top = 1'b1;
        reset_count = 1'b1;
      end
      else
      begin
        inc_man_cnt_top = 1'b0;
        reset_count = 1'b0;
      end

      // assert every 64 pclk's, total divide by 128 pclk's.
      3'b110: inc_man_cnt_top = (man_cnt_bot[5:0] == 6'b111111);

      // assert every 112 pclk's, total divide by 224 pclk's
      default: // 3'b111:
      if(man_cnt_bot[6:0] == 7'b1101111)
      begin
        inc_man_cnt_top = 1'b1;
        reset_count = 1'b1;
      end
      else
      begin
        inc_man_cnt_top = 1'b0;
        reset_count = 1'b0;
      end
    endcase
  end


  // start counting on a write to the phy maintenance register by
  // resetting to zero, man_cnt_top then counts to 8'h82 and stops.
  // man_cnt_top[7]&[1] high indicates management idle (need 1*MDC in idle)
  // man_cnt_top[6] low indicates preamble state
  // man_cnt_top[0] drives mdc
  always@(posedge pclk or negedge n_preset)
  begin
    if(~n_preset)
      man_cnt_top <= 8'h82;
    else if (man_port_en & write_phy_management)
      man_cnt_top <= 8'h00;
    else if(~(man_cnt_top[7] & man_cnt_top[1]) & inc_man_cnt_top)
      man_cnt_top <= man_cnt_top + 8'h01;
    else
      man_cnt_top <= man_cnt_top;
  end


  // store mdio_in on the rising edge of MDC.
  always@(posedge pclk or negedge n_preset)
  begin
    if(~n_preset)
      mdio_in_store <= 1'b0;
    else if (inc_man_cnt_top & ~mdc)
      mdio_in_store <= mdio_in;
    else
      mdio_in_store <= mdio_in_store;
  end


  // start shifting once the man_cnt_top reaches 8'h40 (end of preamble)
  // and then shift mdio_in in once every MDC cycle until man_done
  // (man_cnt_top[7])
  always@(posedge pclk or negedge n_preset)
  begin
    if(~n_preset)
      manage_reg <= 32'h00000000;
    else if (write_phy_management)
      manage_reg <= pwdata;
    else if(~man_cnt_top[7] & man_cnt_top[6] & mdc & inc_man_cnt_top)
      manage_reg <= {manage_reg[30:0], mdio_in_store};
    else
      manage_reg <= manage_reg;
  end


  // set management_read to 1 if the management operation is a read
  // mdio_in in once every MDC cycle.
  always@(posedge pclk or negedge n_preset)
  begin
    if(~n_preset)
      management_read <= 1'b0;
    else if (write_phy_management)
      management_read <= (pwdata[29:28] == 2'b10) |
                         (pwdata[31:28] == 4'b0011);
    else
      management_read <= management_read;
  end


  // enable MDIO on write to PHY maintenance register and keep
  // enable for different times depending on whether it is a read
  // or write cycle.
  always@(posedge pclk or negedge n_preset)
  begin
    if(~n_preset)
      mdio_en <= 1'b0;
    // only enable if this is set in network control register
    else if (man_port_en)
    begin
      // if already enabled for write then disable when
      // man_cnt_top[7] (man_done) count decode is reached
      if (mdio_en & man_cnt_top[7])
        mdio_en <= 1'b0;

      // if already enabled for read then disable when
      // man_cnt_top decode indicates end of address cycle
      else if (mdio_en & management_read & inc_man_cnt_top &
               (man_cnt_top[6:0] == 7'b1011011))
        mdio_en <= 1'b0;

      // only enable when phy maintanence register written to
      else if (write_phy_management)
        mdio_en <= 1'b1;

      // Else maitain value
      else
        mdio_en <= mdio_en;
    end
    // if port disabled in network config reg then reset
    else
      mdio_en <= 1'b0;
  end

  // management idle when msb of man_cnt_top is set and we have completed
  // one more complete MDC clocks in idle state.
  assign man_done = man_cnt_top[7] & man_cnt_top[1];

  // mdc toggles with man_cnt_top[0]. Only toggles when management
  // is not idle
  assign mdc      = man_cnt_top[0];

  // drive mdio_out high during pre-amble state (ie when man_cnt_top[6] low)
  // drive with msb of manage_reg otherwise
  assign mdio_out = manage_reg[31] | ~man_cnt_top[6];

  // APB read of PHY management registers.
  // The prdata_phy_man should be registered externally.
  always @(*)
  begin
    if (read_registers & (i_paddr == `gem_phy_management))
      prdata_phy_man  = manage_reg;
    else
      prdata_phy_man  = 32'h00000000;
  end

  // Perr generation for any access.
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      perr_phy_man  <= 1'b0;
    else if (psel)
      perr_phy_man  <= (i_paddr != `gem_phy_management);
    else
      perr_phy_man  <= 1'b0;
  end

endmodule
