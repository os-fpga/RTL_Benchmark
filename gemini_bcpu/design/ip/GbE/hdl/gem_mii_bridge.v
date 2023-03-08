//------------------------------------------------------------------------------
// Copyright (c) 2016-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_mii_bridge.v
//   Module Name:        gem_mii_bridge
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
//   Description :      MII bridge
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_mii_bridge (

   // APB interface signals.
   input             pclk,
   input             n_preset,
   input      [11:2] paddr,
   output     [31:0] prdata,
   output     [3:0]  prdata_par,
   input      [31:0] pwdata,
   input      [3:0]  pwdata_par,
   input             pwrite,
   input             penable,
   input             psel,
   output            perr,
   input             perr_mac,
   input      [31:0] prdata_mac,
   input      [3:0]  prdata_par_mac,

   ////////////////// PCS interface ports ///////////////////////////////

   // dedicate pcs interface.
   input             tx_er_pcs,
   input       [7:0] txd_pcs,
   input             txd_par_pcs,
   input             tx_en_pcs,
   output     [15:0] rxd_pcs,
   output      [1:0] rxd_par_pcs,
   output      [1:0] rx_er_pcs,
   output      [1:0] rx_dv_pcs,
   output            col_pcs,
   output            crs_pcs,

   // signals coming from gem_top
   input             alt_sgmii_mode,
   input             sgmii_mode,
   input             uni_direct_en,
   input             retry_test,
   input       [3:0] speed_mode,
   input             tx_lpi_en,
   input             full_duplex,

   // signals going to gem_reg_top
   output            pcs_link_state,
   output            pcs_an_complete,
   output            np_data_int,
   output            mac_pause_tx_en,
   output            mac_pause_rx_en,
   output            mac_full_duplex,
   output            link_fault_signal_en,   // 802.3cb link fault signalling enabled
   output      [1:0] link_fault_status,

   // ten bit interface signals.
   input             gtx_clk,
   input             n_gtxreset,
   input             gtx20_clk,
   input             n_gtx20reset,
   input             rbc0,
   input             rbc1,
   input             n_rbc0reset,
   input             n_rbc1reset,
   input             pcs_rx_clk,
   input             n_pcs_rxreset,
   input             pcs_rx10_clk,
   input             n_pcs_rx10reset,
   input             pcs_cal_bypass,
   input             pcs_cgalign_bypass,
   output     [19:0] tx_group,
   input      [19:0] rx_group,
   output            ewrap,
   output            en_cdet,
   input             signal_detect,

   // ASF fault signalling
   output            asf_csr_pcs_err,
   output            asf_dap_pcs_tx_err,
   output            asf_dap_pcs_rx_err,

   ////////////////// RGMII and RMII interface ports ////////////////////

   // Clocks and resets
   input             tx_clk,
   input             n_txreset,
   input             rx_clk,
   input             n_rxreset,
   input             n_tx_clk,
   input             n_ntxreset,
   input             tx_clk_sig,
   input             n_rx_clk,
   input             n_nrxreset,

   // rgmii interface signals
   output      [3:0] rgmii_txd,
   output            rgmii_tx_ctl,
   input       [3:0] rgmii_rxd,
   input             rgmii_rx_ctl,
   output            rgmii_link_status,
   output      [1:0] rgmii_speed,
   output            rgmii_duplex_out,
   input             half_duplex,

   // gmii interface signals
   output      [7:0] txd,
   output            tx_en,
   output            tx_er,
   input       [7:0] rxd,
   input             rx_dv,
   input             rx_er,
   input             col,
   input             crs,

   // rmii interface signals
   input             mii_select,
   input             sel_mii_on_rgmii,
   input             n_ref_reset,
   input             ref_clk,
   output            rmii_rx_clk,
   output            rmii_tx_clk,
   output      [1:0] rmii_txd,
   output            rmii_tx_en,
   input       [1:0] rmii_rxd,
   input             rmii_rx_er,
   input             rmii_crs_dv,

   // Signals from/to the interface to/from the MAC side
   output      [7:0] rxd_to_mac,
   output            rxd_par_to_mac,
   output            rx_dv_to_mac,
   output            rx_er_to_mac,
   output            col_to_mac,
   output            crs_to_mac,

   input       [7:0] txd_from_mac,
   //input           txd_par_from_mac,  Commented for future use
   input             tx_en_from_mac,
   input             tx_er_from_mac,

   // Lockup detect signalling
   input             lu_det_e_pip,
   input             lu_det_p_pip,
   //input           lu_det_p_sop_gate, Commented for future use
   input             lu_det_p_eop_gate,
   //output          emac_tx_sop_pulse, Commented for future use
   output            emac_tx_eop_pulse,
   //output          pmac_tx_sop_pulse, Commented for future use
   output            pmac_tx_eop_pulse
);


  parameter [1363:0] grouped_params = {1364{1'b0}};

  `include "ungroup_params.v"


//------------------------------------------------------------------------------
// Declare wires and registers
//------------------------------------------------------------------------------

  wire [3:0] txd_to_rmii;
  wire       tx_en_to_rmii;
  wire [3:0] rxd_from_rmii;
  wire       rx_er_from_rmii;
  wire       rx_dv_from_rmii;
  wire       col_from_rmii;
  wire       crs_from_rmii;
  wire       col_from_rgmii;
  wire       crs_from_rgmii;
  wire       rx_er_from_rgmii;
  wire [7:0] rxd_from_rgmii;
  wire       rx_dv_from_rgmii;
  wire [7:0] rxd_int;
  wire       rx_dv_int;
  wire[15:0] prdata_pcs;
  wire [1:0] prdata_par_pcs;
  wire       perr_pcs;
  wire [7:0] gmii_txd;
  wire       gmii_tx_en;
  wire       gmii_tx_er;
  wire       rx_er_del;
  wire       tx_er_del;

//------------------------------------------------------------------------------
// instantiate RGMII and RMII interface.
//------------------------------------------------------------------------------

  generate if (p_edma_using_rgmii)
     begin : gen_rgmii_del_sig
       reg rx_er_d1;
       reg rx_er_d2;
       reg tx_er_d1;
       // delay rx_er indication when MII configured with RGMII.
       always @(posedge rx_clk or negedge n_rxreset)
       begin
         if(~n_rxreset)
          begin
           rx_er_d1 <= 1'b0;
           rx_er_d2 <= 1'b0;
          end
         else
          begin
           rx_er_d1 <= rx_er;
           rx_er_d2 <= rx_er_d1;
          end
       end

       // delay tx_er indication when MII configured with RGMII.
       always @(posedge tx_clk or negedge n_txreset)
       begin
        if(~n_txreset)
           tx_er_d1 <= 1'b0;
        else
           tx_er_d1 <= tx_er_from_mac & sel_mii_on_rgmii;
       end
       assign rx_er_del = rx_er_d2;
       assign tx_er_del = tx_er_d1;
     end else begin : gen_rgmii_nodel_sig
       assign rx_er_del = 1'b0;
       assign tx_er_del = 1'b0;
     end
  endgenerate

  generate if(p_edma_using_rgmii) begin : gen_rgmii

     // Driving tx_er by tx_er_del if using rgmii
     assign tx_er = tx_er_del;

     rgmii i_rgmii(
     // RX clocks and resets
     .n_rgmii_rxreset         (n_rxreset),
     .n_rgmii_rx_n_reset      (n_nrxreset),
     .rgmii_rx_clk            (rx_clk),
     .rgmii_rx_n_clk          (n_rx_clk),

     // TX clocks and resets
     .rgmii_tx_clk_sig        (tx_clk_sig),
     .n_rgmii_txreset         (n_txreset),
     .n_rgmii_tx_n_reset      (n_ntxreset),
     .rgmii_tx_clk            (tx_clk),
     .rgmii_tx_n_clk          (n_tx_clk),

     // RGMII signals
     .rgmii_txd               (rgmii_txd),        // Interface output to PHY
     .rgmii_tx_ctl            (rgmii_tx_ctl),     // Interface output to PHY
     .rgmii_rxd               (rgmii_rxd),        // Interface input from PHY
     .rgmii_rx_ctl            (rgmii_rx_ctl),     // Interface input from PHY

     // gmii / mii ethernet interface.
     .gmii_col                (col_from_rgmii),   // Interface Output used to calculate col_to_mac
     .gmii_crs                (crs_from_rgmii),   // Interface Output used to calculate col_to_mac
     .gmii_tx_er              (gmii_tx_er),       // Interface Input calculated using tx_er_from_mac
     .gmii_txd                (gmii_txd),         // Interface Input calculated using txd_from_mac
     .gmii_tx_en              (gmii_tx_en),       // Interface Input calculated using tx_en_from_mac
     .gmii_rxd                (rxd_from_rgmii),   // Interface Output used to calculate rxd_to_mac
     .gmii_rx_er              (rx_er_from_rgmii), // Interface Output used to calculate rx_er_to_mac
     .gmii_rx_dv              (rx_dv_from_rgmii), // Interface Output used to calculate rx_dv_to_mac
     .gmii_gigabit            (speed_mode[1]),    // Interface input from gem
     .gmii_link_status        (rgmii_link_status),// Interface Output
     .gmii_speed              (rgmii_speed),      // Interface Output
     .gmii_duplex_out         (rgmii_duplex_out), // Interface Output
     .gmii_duplex_in          (!half_duplex)      // Interface Input

     );

     assign rxd_int   = speed_mode[1] ? rxd_from_rgmii : {4'h0,rxd_from_rgmii[3:0]};
     assign rx_dv_int = rx_dv_from_rgmii;
     assign txd       = 8'h00;
     assign tx_en     = 1'b0;

     // Calculating the inputs for the rgmii interface above using the signals coming from the mac
     if(p_edma_include_rmii)
       begin : gen_inc_rmii
         // the mii_select input pin being low enables RMII operation so drive tx inputs to RGMII module low in this case
         // sel_mii_on_rgmii from the control register selects MII operation on the RGMII pins so double up the txd data and
         // drive tx_er low so rgmii_tx_ctl can be used as tx_en
         assign gmii_txd   = (~mii_select)?                    8'h00 :
                        (sel_mii_on_rgmii)?                    {txd_from_mac[3:0], txd_from_mac[3:0]} : txd_from_mac;
         assign gmii_tx_en = (mii_select)?                     tx_en_from_mac : 1'b0;
         assign gmii_tx_er = (mii_select & ~sel_mii_on_rgmii)? tx_er_from_mac : 1'b0;
       end
     else
       begin : gen_no_rmii
         assign gmii_txd   = (sel_mii_on_rgmii)? {txd_from_mac[3:0], txd_from_mac[3:0]} :txd_from_mac;
         assign gmii_tx_en = tx_en_from_mac;
         assign gmii_tx_er = (~sel_mii_on_rgmii)? tx_er_from_mac : 1'b0;
       end

   end
   else // not using rgmii - driving the gmii/mii tx outputs with the
        // signals coming from the mac
        // and driving to zero all the gem_mii_bridge outputs from rgmii
   begin: GEN_NO_RGMII
     if(p_edma_include_rmii)
       begin : gen_inc_rmii
         // the mii_select input pin being low enables RMII operation
         // drive tx_er low so rgmii_tx_ctl can be used as tx_en
         assign tx_er = mii_select ? tx_er_from_mac : 1'b0;
         assign tx_en = mii_select ? tx_en_from_mac : 1'b0;
         assign txd   = mii_select ? txd_from_mac   : 8'h00;
       end
     else
       begin : gen_no_rmii
         assign tx_er             = tx_er_from_mac;
         assign tx_en             = tx_en_from_mac;
         assign txd               = txd_from_mac;
       end
     assign rgmii_duplex_out  = 1'b0;
     assign rgmii_speed       = 2'd0;
     assign rgmii_link_status = 1'b0;
     assign rgmii_txd         = 4'd0;
     assign rgmii_tx_ctl      = 1'b0;
     assign rxd_int           = speed_mode[1] ? rxd : {4'h0,rxd[3:0]};
     assign rx_dv_int         = rx_dv;
     assign col_from_rgmii    = 1'b0;
     assign crs_from_rgmii    = 1'b0;
     assign rx_er_from_rgmii  = 1'b0;
     assign rxd_from_rgmii    = 8'h00;
     assign rx_dv_from_rgmii  = 1'b0;
     assign gmii_txd          = 8'h00;
     assign gmii_tx_en        = 1'b0;
     assign gmii_tx_er        = 1'b0;
   end
 endgenerate


 generate
   if(p_edma_include_rmii)
   begin : GEN_RMII
     rmii_interface i_rmii (
     // system signals
     .n_ref_reset (n_ref_reset),
     .ref_clk     (ref_clk),

     // Control inputs
     .speed       (speed_mode[0]),
     .tx_lpi_en   (tx_lpi_en),

     // Clock outputs to Clock multiplexer (external to RMIIG).
     .rx_clk      (rmii_rx_clk),
     .tx_clk      (rmii_tx_clk),

     // MII signals
     .col         (col_from_rmii),       // Interface Output used to calculate col_to_mac
     .crs         (crs_from_rmii),       // Interface Output used to calculate crs_to_mac
     .txd         (txd_to_rmii),         // Interface Input calculated from txd_from_mac
     .tx_en       (tx_en_to_rmii),       // Interface Input calculated from tx_en_from_mac
     .rxd         (rxd_from_rmii[3:0]),  // Interface Output used to calculate rxd_to_mac
     .rx_er       (rx_er_from_rmii),     // Interface Output used to calculate rx_er_to_mac
     .rx_dv       (rx_dv_from_rmii),     // Interface Output used to calculate rx_dv_to_mac

     // RMII signals
     .txd_rmii    (rmii_txd),            // Interface Output to the PHY
     .tx_en_rmii  (rmii_tx_en),          // Interface Output to the PHY
     .rxd_rmii    (rmii_rxd),            // Interface Input from the PHY
     .rx_er_rmii  (rmii_rx_er),          // Interface Input from the PHY
     .crs_dv      (rmii_crs_dv)          // Interface Input from the PHY
     );

     // MII ethernet signals to GEM
     assign rxd_to_mac[3:0] = (mii_select)? rxd_int[3:0] : rxd_from_rmii;
     assign rxd_to_mac[7:4] = (mii_select)? rxd_int[7:4] : 4'h0;
     assign rx_dv_to_mac    = (mii_select)? rx_dv_int    : rx_dv_from_rmii;

     assign txd_to_rmii     = (mii_select)? 4'h0     : txd_from_mac[3:0];
     assign tx_en_to_rmii   = (mii_select)? 1'b0     : tx_en_from_mac;

     // Calculating the signals to the mac using both outputs from the rmii and rgmii interface
     if(p_edma_using_rgmii)
       begin : gen_rgmii
         // the mii_select input pin being low enables RMII operation so source col, crs and rx_er from RMII block in this case
         // sel_mii_on_rgmii from the control register selects MII operation on the RGMII pins so take col and crs from top
         // level input in this case and delay rx_er input. col and crs do not need to be delayed or retimed as they are asynchronous signals
         assign col_to_mac      = (~mii_select) ?  col_from_rmii :
                                                   (sel_mii_on_rgmii)? col :
                                                   col_from_rgmii;
         assign crs_to_mac      = (~mii_select)?   crs_from_rmii :
                                                   (sel_mii_on_rgmii)? crs :
                                                   crs_from_rgmii;

         assign rx_er_to_mac    = (~mii_select)?   rx_er_from_rmii :
                                                   (sel_mii_on_rgmii)? rx_er_del :
                                                   rx_er_from_rgmii;

       end
     else
       begin : gen_no_rgmii
         assign col_to_mac      = (mii_select)? col      : col_from_rmii;
         assign crs_to_mac      = (mii_select)? crs      : crs_from_rmii;
         assign rx_er_to_mac    = (mii_select)? rx_er    : rx_er_from_rmii;
       end

   end
   else
   begin : GEN_NO_RMII // assigning the signals to mac and setting all the module outputs from rmii to zero
     assign col_from_rmii   = 1'b0;
     assign crs_from_rmii   = 1'b0;
     assign rx_er_from_rmii = 1'b0;
     assign rxd_from_rmii   = 4'h0;
     assign rx_dv_from_rmii = 1'b0;
     assign txd_to_rmii     = 4'h0;
     assign tx_en_to_rmii   = 1'b0;
     assign rmii_txd        = 2'd0;
     assign rmii_tx_en      = 1'd0;
     assign rmii_rx_clk     = 1'd0;
     assign rmii_tx_clk     = 1'd0;

       if(p_edma_using_rgmii)
         begin : gen_rgmii
           assign col_to_mac      = (sel_mii_on_rgmii)? col       : col_from_rgmii;
           assign crs_to_mac      = (sel_mii_on_rgmii)? crs       : crs_from_rgmii;
           assign rxd_to_mac      = rxd_from_rgmii;
           assign rx_er_to_mac    = (sel_mii_on_rgmii)? rx_er_del : rx_er_from_rgmii;
           assign rx_dv_to_mac    = rx_dv_from_rgmii;
         end
       else
         begin : gen_no_rgmii
           assign col_to_mac      = col;
           assign crs_to_mac      = crs;
           assign rxd_to_mac      = rxd;
           assign rx_er_to_mac    = rx_er;
           assign rx_dv_to_mac    = rx_dv;
         end
   end
 endgenerate

 // Parity for rxd_to_mac.
 // This generates a single parity bit for the GMII into the MAC. When operating
 // in gigabit mode, this is 1-bit per byte parity. When operating in 10/100M
 // MII mode this will effectively be 1-bit per nibble parity and will be
 // reconstructed within the MAC.
 // As this parity generation is after the RMII/RGMII wrappers, there is a small
 // amount of logic that is not parity protected.
 // It is assumed errors in these areas can be picked up by configuration of the
 // receive path lockup detection mechanism.
 // Note that for PCS, the parity is already generated within the PCS and
 // passed along rxd_par_pcs
 generate if (p_edma_asf_dap_prot == 1) begin : gen_rxd_mac_par
  cdnsdru_asf_parity_gen_v1 #(.p_data_width(8)) i_par_rxd_to_mac(
    .odd_par    (1'b0),
    .data_in    (rxd_to_mac),
    .data_out   (),
    .parity_out (rxd_par_to_mac)
  );
 end else begin : gen_no_rxd_mac_par
  assign rxd_par_to_mac = 1'b0;
 end
 endgenerate


//------------------------------------------------------------------------------
// instantiate gem_pcs.
//------------------------------------------------------------------------------

  generate
    if (p_edma_has_pcs == 1)
    begin: GEN_PCS

      gem_pcs #(.grouped_params(grouped_params))

      i_gem_pcs (

        // amba apb interface.
        .pclk                    (pclk),
        .n_preset                (n_preset),
        .paddr                   (paddr[11:2]),
        .pwdata                  (pwdata[15:0]),
        .pwdata_par              (pwdata_par[1:0]),
        .pwrite                  (pwrite),
        .penable                 (penable),
        .psel                    (psel),
        .prdata                  (prdata_pcs),
        .prdata_par              (prdata_par_pcs),
        .perr                    (perr_pcs),

        // ethernet interface.
        .gtx_clk                 (gtx_clk),
        .n_gtxreset              (n_gtxreset),
        .txd                     (txd_pcs),
        .txd_par                 (txd_par_pcs),
        .tx_en                   (tx_en_pcs),
        .tx_er                   (tx_er_pcs),
        .col                     (col_pcs),
        .crs                     (crs_pcs),
        .rxd                     (rxd_pcs),
        .rxd_par                 (rxd_par_pcs),
        .rx_er                   (rx_er_pcs),
        .rx_dv                   (rx_dv_pcs),

        .cal_bypass              (pcs_cal_bypass),
        .cgalign_bypass          (pcs_cgalign_bypass),
        .retry_test              (retry_test),
        .alt_sgmii_mode          (alt_sgmii_mode),
        .sgmii_mode              (sgmii_mode),
        .uni_direct_en           (uni_direct_en),
        .tbi                     (speed_mode[2]),
        .full_duplex             (full_duplex),
        .two_pt_five_gig         (speed_mode[3]),
        .pcs_link_state          (pcs_link_state),
        .pcs_an_complete         (pcs_an_complete),
        .np_data_int             (np_data_int),
        .mac_pause_tx_en         (mac_pause_tx_en),
        .mac_pause_rx_en         (mac_pause_rx_en),
        .mac_full_duplex         (mac_full_duplex),

        // tbi signals.
        .gtx20_clk               (gtx20_clk),
        .n_gtx20reset            (n_gtx20reset),
        .rx_clk                  (pcs_rx_clk),
        .n_rxreset               (n_pcs_rxreset),
        .rx10_clk                (pcs_rx10_clk),
        .n_rx10reset             (n_pcs_rx10reset),
        .rbc0                    (rbc0),
        .rbc1                    (rbc1),
        .n_rbc0reset             (n_rbc0reset),
        .n_rbc1reset             (n_rbc1reset),

        .tx_code_group           (tx_group),
        .rx_code_group           (rx_group),
        .ewrap                   (ewrap),
        .en_cdet                 (en_cdet),
        .signal_detect           (signal_detect),

        // Link Fault Signalling
        .link_fault_signal_en    (link_fault_signal_en),
        .link_fault_status       (link_fault_status),

        // ASF fault signalling
        .asf_csr_pcs_err         (asf_csr_pcs_err),
        .asf_dap_pcs_tx_err      (asf_dap_pcs_tx_err),
        .asf_dap_pcs_rx_err      (asf_dap_pcs_rx_err)
      );
    end
    else
    begin: GEN_NO_PCS
      assign prdata_pcs[15:0]   = 16'h0000;
      assign prdata_par_pcs     = 2'h0;
      assign perr_pcs           = 1'b1;
      assign col_pcs            = 1'b0;
      assign crs_pcs            = 1'b0;
      assign rxd_pcs[15:0]      = 16'h0000;
      assign rxd_par_pcs[1:0]   = 2'b00;
      assign rx_er_pcs[1:0]     = 2'b00;
      assign rx_dv_pcs[1:0]     = 2'b00;
      assign pcs_link_state     = 1'b0;
      assign pcs_an_complete    = 1'b0;
      assign np_data_int        = 1'b0;
      assign mac_pause_tx_en    = 1'b0;
      assign mac_pause_rx_en    = 1'b0;
      assign mac_full_duplex    = 1'b0;
      assign en_cdet            = 1'b0;
      assign ewrap              = 1'b0;
      assign tx_group           = 20'd0;
      assign asf_csr_pcs_err    = 1'b0;
      assign asf_dap_pcs_tx_err = 1'b0;
      assign asf_dap_pcs_rx_err = 1'b0;
      assign link_fault_signal_en = 1'b0;
      assign link_fault_status  = 2'b00;
    end
  endgenerate

  // combine pcs and mac apb data for amba read operation.
  assign prdata     = prdata_mac      | {16'h0000,prdata_pcs};
  assign prdata_par = prdata_par_mac  | {2'b00,prdata_par_pcs};

  // combine pcs and mac perr for address decoding error.
  // Both must signal as unrecognised.
  assign perr = perr_mac & perr_pcs;

  // Lockup detect signalling
  // Start of packet indication is via edge detect of tx_en output.
  wire  tx_en_sel;
  wire  tx_en_sel_r;
  wire  tx_en_sel_f;

  // Select tx_en to use depending on whether PCS or not
  assign tx_en_sel  = speed_mode[2] ? tx_en_pcs : tx_en_from_mac;

  // Edge detect
  edma_toggle_detect i_tx_en_edge_det (
    .clk      (tx_clk),
    .reset_n  (n_txreset),
    .din      (tx_en_sel),
    .rise_edge(tx_en_sel_r),
    .fall_edge(tx_en_sel_f),
    .any_edge ()
  );

  // Generate pulses to indicate start/end of packet transitions.
  // These will be used for lockup detection in the eMAC and pMAC.
  //assign emac_tx_sop_pulse= lu_det_e_pip & tx_en_sel_r; Commented for future use
  assign emac_tx_eop_pulse  = lu_det_e_pip & tx_en_sel_f;
  //assign pmac_tx_sop_pulse= lu_det_p_pip & ~lu_det_e_pip & tx_en_sel_r & lu_det_p_sop_gate; Commented for future use
  assign pmac_tx_eop_pulse  = lu_det_p_pip & ~lu_det_e_pip & tx_en_sel_f & lu_det_p_eop_gate;

endmodule
