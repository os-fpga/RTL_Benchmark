//------------------------------------------------------------------------------
// Copyright (c) 2001-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_pcs_registers.v
//   Module Name:        gem_pcs_registers
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
//   Description    :   The register block for the PCS module comprising the
//                      registers defined by the IEEE 802.3 specifications
//                      clause 22 and an APB interface.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_pcs_registers(

   // System Input ports
   pclk,
   n_preset,

   // Inputs from gem_pcs_an
   mr_page_rx,          // Registered, double synced toggle signal.
   mr_np_loaded_clr,    // Registered, double synced toggle signal.
   pcs_link_state,      // Registered long double synced signal.
   mr_an_complete,      // Registered long double synced signal.
   mr_lp_adv_ability,   // Registered slow double synced bus,
   mr_lp_np_rx,         // Registered slow double synced bus,
   mr_base_rf_clear,    // Slow async signal, double synced.
   an_restarted,        // Slow async signal, double synced.

   // Inputs from top level registers control, same domain, no protection.
   tbi,
   sgmii_mode,
   full_duplex,

   // Reset detected inputs
   sync_reset_rx,       // Synchronous reset detected in various domains.
   sync_reset_txclk,

   // Output ports to gem_pcs_an
   mr_an_enable,        // Slow signal, registered and double synced to pcs_an
   mr_an_restart,       // Handshake signal, registered, double synced to pcs_an
   mr_adv_ability,      // Assume stable bus, registered, double synced
   mr_adv_ability_par,
   mr_np_tx,            // Assume stable bus, registered, double synced
   mr_np_tx_par,
   mr_np_loaded,        // Handshake signal, registered, double synced to pcs_an
   mr_lp_np_read,       // Handshake signal, registered, double synced to pcs_an

   // Output to receive process for sync.
   mr_loopback,         // Stable/slow signal, registered and double synced.

   // Output to transmit process
   mr_col_test,         // Stable/slow signal, registered and double synced.

   // Control and status outputs
   ewrap,               // Registered top level signal to PMA

   pcs_an_complete,     // Registered control to top level registers, same clk.
   np_data_int,         // Registered control to top level registers, same clk.

   sync_reset_pclk,     // pclk synced reset signal to other pcs blocks.

   // APB interface signals
   paddr,               // All these signals are synchronous to pclk.
   prdata,
   prdata_par,
   pwdata,
   pwdata_par,
   pwrite,
   penable,
   psel,
   perr,

   // ASF Parity check of registers
   asf_csr_pcs_err

   );

   // Port declarations

   // Input ports

   input          pclk;             // APB clock.
   input          n_preset;         // APB asynchronous reset.

   input          mr_page_rx;       // Page received. (toggle)
   input          mr_np_loaded_clr; // Clear next page loaded. (toggle)
   input          pcs_link_state;   // current link state of PCS (pclk timed)
   input          mr_an_complete;   // Auto negotiation complete.
   input [15:0]   mr_lp_adv_ability;// Link partner's abilities.
   input [15:0]   mr_lp_np_rx;      // Link partner next page.

   input          mr_base_rf_clear; // Clear base RF registers
   input          an_restarted;     // Signal to indicate auto neg started.

   input          tbi;              // PCS TBI enable indication.
   input          sgmii_mode;       // PCS is configured for SGMII
   input          full_duplex;      // duplex signal from the network config reg

   input          sync_reset_rx;    // sync reset detected in rx clock domain
   input          sync_reset_txclk; // sync reset detected in tx_clk clk domain

   // Output ports

   output         mr_an_enable;     // Enable auto negotiation.
   output         mr_an_restart;    // Restart auto negotiation.
   output [7:0]   mr_adv_ability;   // Local device advertised abilities.
   output         mr_adv_ability_par;
   output [15:0]  mr_np_tx;         // Local device next page.
   output [1:0]   mr_np_tx_par;
   output         mr_np_loaded;     // Next page loaded.
   output         mr_lp_np_read;    // Link partner's np has been read.

   output         mr_loopback;      // Loopback PCS indication.
   output         mr_col_test;      // Collision test.

   output         ewrap;            // PMA loopback.

   output         pcs_an_complete;  // PCS autonegotiation complete
   output         np_data_int;      // Interrupt to request more np data.

   output         sync_reset_pclk;  // Synchronous reset to rest of PCS.

   // APB interface signals
   input  [11:2]  paddr;            // address bus of selected master
   output [15:0]  prdata;           // read data
   output [1:0]   prdata_par;       // Parity for read data
   input  [15:0]  pwdata;           // write data
   input  [1:0]   pwdata_par;       // Parity for write data
   input          pwrite;           // peripheral write strobe
   input          penable;          // peripheral enable
   input          psel;             // peripheral select for GPIO
   output         perr;             // peripheral address decode error
   output         asf_csr_pcs_err;  // Parity error

   parameter p_edma_asf_host_par  = 1'b0;
   parameter p_edma_asf_csr_prot  = 1'b0;

   // Reg and wire declarations.
   wire [15:0]    control;          // PCS control register.
   reg  [6:0]     an_base;          // Auto neg base page.
   reg            an_base_par;
   reg  [7:0]     an_base_value;    // Auto neg base page value used in design
   reg            an_base_value_par;
   wire [15:0]    lp_base;          // Link partner base page.
   wire [15:0]    lp_base_value;    // Link partner base page used in design
   wire [1:0]     an_exp;           // Auto neg expansion register.
   reg  [15:0]    an_np;            // Auto neg next page transmit.
   reg  [1:0]     an_np_par;
   wire [15:0]    an_np_lp;         // Link partner next page.

   reg            mr_an_complete_del;// delayed mr_an_complete from gem_pcs_an

   reg            mr_np_loaded;     // Next page loaded.
   reg            np_ld_clr_save;   // Saved version of mr_np_loaded_clr.

   reg [15:0]     prdata_i;         // read data
   reg [15:0]     prdata;           // Registered output
   reg            perr;             // not a standard apb signal, driven
                                    // high when psel is asserted if
                                    // address is not recognized.
   reg            soft_reset;       // Software reset.
   wire           sync_reset;       // reset for control register.

   reg            r_fault;          // Remote fault occurred.
   reg            r_fault_save;     // Used for edge detect.
   wire           lp_r_fault;       // Remote fault indication from partner.

   reg            status_read_link; // Status register has been read, link
   reg            status_read_fault;// Status register has been read, rfault
   reg            pcs_link_state_hold; // Sticky version of link status.
   reg            pcs_link_state_save; // For edge detection.

   reg            mr_page_rx_del;   // For generating interrupt for data rx.

   reg            control14;        // Control reg bit 14
   reg            control12;        // Control reg bit 12
   reg            control9;         // Control reg bit 9
   reg            control7;         // Control reg bit 7

   reg            mr_lp_np_read;    // Link partner's np has been read

   wire           write_registers;  // Active when performing register writes.
   wire           read_registers;   // Active when performing register reads.

   wire           write_soft_reset; // Soft reset getting written.


   assign write_registers = pwrite & ~penable & psel;

   assign sync_reset = sync_reset_rx & sync_reset_txclk;

   assign write_soft_reset  = write_registers & pwdata[15] &
                                ({paddr[11:2],2'b00} == `gem_pcs_control);

   // Bit 8 is hardwired to MAC's duplex state. It makes no sense to try
   // and control the PCS duplex state through this register. The PCS is
   // capable of both full and half-duplex operation. It is for the MAC to
   // determine the MAC's duplex state.
   assign control = {sync_reset,control14,1'b0,control12,2'b00,control9,
                    full_duplex, control7,7'b1000000};

   // read_registers indicates register read.
   // For AMBA 2.0 read_registers will be active at the end of a cycle
   assign read_registers = ~pwrite & ~penable & psel;

   // Handle next page handshaking and some status
   always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
      begin
         status_read_link <= 1'b1;
         status_read_fault <= 1'b1;
         mr_lp_np_read <= 1'b1;
      end
      else
      begin
         // Toggle detect for when new page received, reset read value on new...
         if ((read_registers) & ({paddr[11:2],2'b00} == `gem_pcs_an_lp_np))
            mr_lp_np_read <= 1'b1;
         else if (mr_page_rx ^ mr_page_rx_del)
            mr_lp_np_read <= 1'b0;
         else
            mr_lp_np_read <= mr_lp_np_read;

         // Status signals are sticky until good status returned.
         if (pcs_link_state_save & ~pcs_link_state)
            status_read_link <= 1'b0;
         else if ((read_registers) & ({paddr[11:2],2'b00} == `gem_pcs_status))
            status_read_link <= 1'b1;

         if (~r_fault_save & lp_r_fault)
            status_read_fault <= 1'b0;
         else if ((read_registers) & ({paddr[11:2],2'b00} == `gem_pcs_status))
            status_read_fault <= 1'b1;
      end
    end

   //---------------------------------------------------------------------------
   // APB register reads
   //---------------------------------------------------------------------------

   always @(*)
    begin
      if (read_registers)
         case ({paddr[11:2],2'b00})
            `gem_pcs_control:
                  prdata_i = control;
            `gem_pcs_status:
                  prdata_i = {8'h01,
                               2'b00,
                               mr_an_complete,
                               r_fault,
                               control12,
                               pcs_link_state_hold,
                               2'b01};
            `gem_pcs_phy_top_id:
                  prdata_i = `gem_phy_id_top;
            `gem_pcs_phy_bot_id:
                  prdata_i = `gem_phy_id_bot;
            `gem_pcs_an_adv:
                  prdata_i = {an_base_value[7],
                               1'b0,an_base_value[6:5],
                               3'b000,an_base_value[4:1],
                               4'b0000,an_base_value[0]};
            `gem_pcs_an_lp_base:
                  prdata_i = lp_base_value;
            `gem_pcs_an_exp:
                  prdata_i = {13'h0000,
                               1'b1,
                               an_exp};
            `gem_pcs_an_np_tx:
                  prdata_i = an_np[15:0];
            `gem_pcs_an_lp_np:
                  prdata_i = an_np_lp;
            `gem_pcs_an_ext_status:
                  prdata_i = 16'h8000;
            default:
                  prdata_i = 16'h0000;
         endcase // case(paddr)
      else
         prdata_i = 16'h0000;
    end

   // Register the output
   always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
         prdata <= 16'h0000;
      else
         prdata <= prdata_i;
    end


   //---------------------------------------------------------------------------
   // APB register writes
   //---------------------------------------------------------------------------

   always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
         begin
            control14   <= 1'b0;
            control12   <= 1'b1;
            control9    <= 1'b0;
            control7    <= 1'b0;
            an_base      <= 7'h01;
            an_base_par  <= 1'b1;
            an_np        <= 16'h0000;
            an_np_par    <= 2'b00;
            mr_np_loaded <= 1'b0;
            soft_reset   <= 1'b0;
            np_ld_clr_save <= 1'b0;
         end

      // keep everything in default whilst software reset is active
      else if (soft_reset | write_soft_reset)
         begin
            control14   <= 1'b0;
            control12   <= 1'b1;
            control9    <= 1'b0;
            control7    <= 1'b0;
            an_base      <= 7'h01;
            an_base_par  <= 1'b1;
            an_np        <= 16'h0000;
            an_np_par    <= 2'b00;
            np_ld_clr_save <= 1'b0;
            mr_np_loaded <= 1'b0;

            // clear software reset once all domains have detected it
            if ((sync_reset_rx & sync_reset_txclk) & ~write_soft_reset)
               soft_reset <= 1'b0;
            else
               soft_reset <= 1'b1;

         end

      // software reset has finished
      else
         begin

            np_ld_clr_save <= mr_np_loaded_clr;

            // clear next page loaded status on toggle or soft reset
            if (mr_np_loaded_clr ^ np_ld_clr_save)
               mr_np_loaded <= 1'b0;
            else if (write_registers &
                      ({paddr[11:2],2'b00} == `gem_pcs_an_np_tx))
               mr_np_loaded <= 1'b1;

            // force control bit [9] to zero if an_restarted or aneg disabled.
            // or soft reset
            if (an_restarted | ~mr_an_enable)
               control9 <= 1'b0;
            else if (write_registers &
                      ({paddr[11:2],2'b00} == `gem_pcs_control))
               control9 <= pwdata[9] & pwdata[12];


            // if writing to apb interface decode which register is accessed
            if (write_registers)
               case ({paddr[11:2],2'b00})

                  `gem_pcs_control:
                     begin
                        control14 <= pwdata[14];
                        control12 <= pwdata[12];
                        control7 <= pwdata[7];
                     end

                  `gem_pcs_an_adv:
                     begin
                        an_base     <= {pwdata[15],pwdata[13:12],
                                        pwdata[8:5]};
                        an_base_par <= ^{pwdata[15],pwdata[13:12],
                                        pwdata[8:5]};
                     end

                  `gem_pcs_an_np_tx:
                     begin
                        an_np     <= pwdata[15:0] & 16'hb7ff;
                        an_np_par <= pwdata_par[1:0] ^ {pwdata[14]^pwdata[11],1'b0};
                     end

                  default:
                     begin
                        an_np <= an_np;
                     end

               endcase

            else
            begin
               // Clear the RF encodings in the base page register when in
               // DET_IDLE of autonegotiation
               if (mr_base_rf_clear)
               begin
                  an_base     <= {an_base[6],2'b00,an_base[3:0]};
                  an_base_par <= ^{an_base[6],an_base[3:0]};
               end
               else
               begin
                  an_base <= an_base;
               end
            end
         end
    end


   // Handle the control register..
   assign ewrap = control14;
   assign mr_an_enable = control12;
   assign mr_col_test = control7;
   assign mr_loopback = control14;
   assign mr_an_restart = control9;


   // Detect status changes on bit[5] for generating an interrupt
   // to the MAC
   always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
         begin
            mr_an_complete_del <= 1'b0;
         end
      else
         begin
            mr_an_complete_del <= mr_an_complete;
         end
    end

   // leading edge detect autonegotiation complete
   assign pcs_an_complete = mr_an_complete & ~mr_an_complete_del;


   // Handle the local advertisement and next page registers..

   // for SGMII configuration all bits are currently reserved, with
   // bit[0] set to 1'b1.
   always@(*)
   begin
     if (sgmii_mode)
     begin
       an_base_value[7:0]  = 8'h01;
       an_base_value_par   = 1'b1;
     end
     else
     begin
       an_base_value[7:0]  = {an_base[6:0],1'b0};
       an_base_value_par   = an_base_par;
     end
   end

   assign mr_adv_ability      = an_base_value;
   assign mr_adv_ability_par  = an_base_value_par;
   assign mr_np_tx      = an_np;
   assign mr_np_tx_par  = an_np_par;



   // Now the link partner registers..
   assign lp_base_value[15:0] =
            (sgmii_mode) ? {lp_base[15:14],1'b0,lp_base[12:10],10'b0000000001} :
                           {lp_base[15:12],3'b000,lp_base[8:5],5'b00000};

   assign lp_base = mr_lp_adv_ability;
   assign an_np_lp = mr_lp_np_rx;

   // Expansion register..

   assign an_exp = {~mr_lp_np_read,1'b0};

   // handle synchronous reset indication
   // hold reset of PCS in reset when either the interface is not selected
   // or the software reset is active and is yet to be detected in all
   // clock domains
   assign sync_reset_pclk = soft_reset | ~tbi;


   // Generate interrupt for next page on toggle of mr_page_rx
   always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
         begin
            mr_page_rx_del <= 1'b0;
         end
      else
         begin
            mr_page_rx_del <= mr_page_rx;
         end
    end

   // toggle detect for interrupt..
   assign np_data_int = mr_page_rx ^ mr_page_rx_del;



//------------------------------------------------------------------------------
// drive perr when address not recognised.
//------------------------------------------------------------------------------

   // perr output is driven when paddr does not match any know address
   // This is a non-standard APB signal.
   always @(posedge pclk or negedge n_preset)
   begin
      if (~n_preset)
         perr <= 1'b0;
      else if (psel)
         case ({paddr[11:2],2'b00})
            `gem_pcs_control       : perr <= 1'b0;
            `gem_pcs_status        : perr <= 1'b0;
            `gem_pcs_phy_top_id    : perr <= 1'b0;
            `gem_pcs_phy_bot_id    : perr <= 1'b0;
            `gem_pcs_an_adv        : perr <= 1'b0;
            `gem_pcs_an_lp_base    : perr <= 1'b0;
            `gem_pcs_an_exp        : perr <= 1'b0;
            `gem_pcs_an_np_tx      : perr <= 1'b0;
            `gem_pcs_an_lp_np      : perr <= 1'b0;
            `gem_pcs_an_ext_status : perr <= 1'b0;
            default                : perr <= 1'b1;
         endcase
      else
         perr <= 1'b0;
   end


//------------------------------------------------------------------------------
// Handle remote fault and link status changes, bits need to be sticky.
//------------------------------------------------------------------------------


   // In SGMII configuration, link partner remote fault not supported
   assign lp_r_fault = ~sgmii_mode & (lp_base[13:12] != 2'b00);


   // Detect edges for remote fault and link status and stick until read.

   always@(posedge pclk or negedge n_preset)
   begin
      if (~n_preset)
      begin
         r_fault_save <= 1'b0;
         r_fault <= 1'b0;
         pcs_link_state_save <= 1'b0;
         pcs_link_state_hold <= 1'b0;
      end
      else if (soft_reset)
      begin
         r_fault_save <= 1'b0;
         r_fault <= 1'b0;
         pcs_link_state_save <= 1'b0;
         pcs_link_state_hold <= 1'b0;
      end
      else
      begin
         r_fault_save <= lp_r_fault;
         pcs_link_state_save <= pcs_link_state;
         if (~r_fault_save & lp_r_fault)
         begin
            r_fault <= 1'b1;
         end
         else if (status_read_fault)
         begin
            r_fault <= lp_r_fault;
         end
         else
         begin
            r_fault <= r_fault;
         end

         if (pcs_link_state_save & ~pcs_link_state)
         begin
            pcs_link_state_hold <= 1'b0;
         end
         else if (status_read_link)
         begin
            pcs_link_state_hold <= pcs_link_state;
         end
         else
         begin
            pcs_link_state_hold <= pcs_link_state_hold;
         end

      end
   end

  generate if (p_edma_asf_host_par == 1'b1) begin : gen_host_par
    wire  [1:0] prdata_par_i;
    reg   [1:0] prdata_par_r;

    cdnsdru_asf_parity_gen_v1 #(.p_data_width(16)) i_gen_par (
      .odd_par(1'b0),
      .data_in(prdata_i),
      .data_out(),
      .parity_out(prdata_par_i)
    );
    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        prdata_par_r  <= 2'b00;
      else
        prdata_par_r  <= prdata_par_i;
    end
    assign prdata_par = prdata_par_r;
  end else begin : gen_no_host_par
    assign prdata_par       = 2'b00;
  end
  endgenerate

  generate if (p_edma_asf_csr_prot == 1) begin : gen_par_chk
    cdnsdru_asf_parity_check_v1 #(.p_data_width(23)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    ({an_base,
                    an_np}),
      .parity_in  ({an_base_par,
                    an_np_par}),
      .parity_err (asf_csr_pcs_err)
    );
  end else begin : gen_no_par_chk
    assign asf_csr_pcs_err  = 1'b0;
  end
  endgenerate

endmodule
