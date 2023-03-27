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
//   Filename:           gem_reg_nwc.v
//   Module Name:        gem_reg_nwc
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
//   Description    : Contains register bits for network control register.
//                    This register takes special handling as it can also be
//                    hardware modified so for ASF protection, easiest method
//                    is to duplicate this register set.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_nwc (
  input               pclk,                 // APB clock
  input               n_preset,             // Active low reset
  input     [11:0]    i_paddr,              // Full APB address
  input               write_registers,      // write to apb registers.
  input     [31:0]    pwdata,               // APB write data
  input               disable_rx_pclk,      // disable RX due to major error
  input               disable_tx_pclk,      // disable TX due to major error
  input               tx_lockup_detected,     // TX lockup detection
  input               rx_lockup_detected,     // RX lockup detection
  input               dma_tx_lockup_detected, // TX lockup detection
  input               dma_rx_lockup_detected, // RX lockup detection
  input               lockup_recovery_en,   // Enable automatic lockup shutdown
  input               tx_buff_ex_mid_pclk,  // pclk pulse when tx buffers are
                                            // exhausted mid frame.
  output    [31:0]    network_control       // Network control register
);

  parameter p_edma_pfc_multi_quantum  = 1'b0;
  parameter p_edma_axi                = 1'b1;
  parameter p_edma_tsu                = 1'b1;
  parameter p_edma_ext_tsu_timer      = 1'b1;
  parameter p_edma_rx_pkt_buffer      = 1'b1;
  parameter p_edma_no_stats           = 1'b0;
  parameter p_edma_no_snapshot        = 1'b0;

  // Internal signals
  reg         loopback;             // external loopback signal to the PHY
  reg         loopback_local;       // internal loopback signal.
  reg         enable_receive;       // receive enable signal from network
                                    // control register.
  reg         enable_transmit;      // transmit enable signal from network
                                    // control register.
  reg         man_port_en;          // management port enable
  wire        clear_all_stats_regs; // Statistics control
  wire        inc_all_stats_regs;
  wire        stats_write_en;
  reg         back_pressure;        // goes to tx block to force
                                    // collisions on all incoming frames
  reg         tx_start_pclk;        // asserted when bit 9 of network
                                    // control register is written.
  reg         tx_halt_pclk;         // asserted when bit 10 of network
                                    // control register is written.
  reg         tx_pause_frame_req;   // toggles for transmission of a
                                    // non-zero 802.3 pause frame
  reg         tx_pause_frame_zero;  // toggles for transmission of a
                                    // zero 802.3 pause frame
  wire        stats_take_snap;      // Snapshot statistics control
  wire        stats_read_snap;
  wire        store_rx_ts;          // TSU control
  reg         pfc_enable;           // PFC pause frame receive enable
  reg         tx_pfc_frame_req;     // toggles for transmission of PFC
                                    // pause frame
  wire        flush_rx_pkt_pclk;    // Packet buffer control
  reg         tx_lpi_en;            // enables transmission of LPI

  reg         ptp_unicast_ena;      // enable PTPv2 IPv4 unicast IP DA
                                    // detection
  reg         alt_sgmii_mode;       // alternative tx config for SGMII
  reg         store_udp_offset;     // store tcp/udp offset to memory
  wire        ext_tsu_timer_en;     // TSU control
  wire        one_step_sync_mode;   //
  wire        pfc_ctrl;             // PFC Control
  reg         ext_rxq_sel_en;       // enable external receive queue selection
  wire        oss_correction_field; // TSU control
  reg         sel_mii_on_rgmii;     // reconfigures RGMII interface for MII operation
  reg         two_pt_five_gig;      // indicates 2.5G operation
  reg         ifg_eats_qav_credit;  // modifies CBS algorithm so IFG/IPG uses Qav credit

  wire        dma_tx_err_rst_req;   // DMA related error requires TX reset.
  wire        tx_lockup_comb;       // DMA or MAC TX lockup detected.
  wire        dma_rx_err_rst_req;   // DMA related error requires RX reset.
  wire        rx_lockup_comb;       // DMA or MAC RX lockup detected.

  // RRESP?BRESP or if single frame is too large for configured packet buffer memory size in FSF mode.
  assign dma_tx_err_rst_req = (disable_tx_pclk | tx_buff_ex_mid_pclk) && (p_edma_axi == 1);
  assign tx_lockup_comb     = (dma_tx_lockup_detected | tx_lockup_detected);

  assign dma_rx_err_rst_req = disable_rx_pclk && (p_edma_axi == 1);
  assign rx_lockup_comb     = (dma_rx_lockup_detected | rx_lockup_detected);

  // Write to the standard control register bits
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
    begin
      loopback              <= 1'b0;
      loopback_local        <= 1'b0;
      enable_receive        <= 1'b0;
      enable_transmit       <= 1'b0;
      man_port_en           <= 1'b0;
      back_pressure         <= 1'b0;
      tx_start_pclk         <= 1'b0;
      tx_halt_pclk          <= 1'b0;
      tx_pause_frame_req    <= 1'b0;
      tx_pause_frame_zero   <= 1'b0;
      pfc_enable            <= 1'b0;
      tx_pfc_frame_req      <= 1'b0;
      tx_lpi_en             <= 1'b0;
      ptp_unicast_ena       <= 1'b0;
      alt_sgmii_mode        <= 1'b0;
      store_udp_offset      <= 1'b0;
      ext_rxq_sel_en        <= 1'b0;
      sel_mii_on_rgmii      <= 1'b0;
      two_pt_five_gig       <= 1'b0;
      ifg_eats_qav_credit   <= 1'b0;
    end
    else
      if (write_registers & i_paddr == `gem_network_control)
      begin
        loopback            <= pwdata[0];
        loopback_local      <= pwdata[1];
        enable_receive      <= pwdata[2];
        enable_transmit     <= pwdata[3];
        man_port_en         <= pwdata[4];
        back_pressure       <= pwdata[8];
        tx_start_pclk       <= pwdata[9] ? ~tx_start_pclk : tx_start_pclk;
        tx_halt_pclk        <= pwdata[10] ? ~tx_halt_pclk : tx_halt_pclk;
        tx_pause_frame_req  <= tx_pause_frame_req ^ pwdata[11];
        tx_pause_frame_zero <= tx_pause_frame_zero ^ pwdata[12];
        pfc_enable          <= pwdata[16];
        tx_pfc_frame_req    <= tx_pfc_frame_req ^ pwdata[17];
        tx_lpi_en           <= pwdata[19];
        ptp_unicast_ena     <= pwdata[20];
        alt_sgmii_mode      <= pwdata[21];
        store_udp_offset    <= pwdata[22];
        ext_rxq_sel_en      <= pwdata[26];
        sel_mii_on_rgmii    <= pwdata[28];
        two_pt_five_gig     <= pwdata[29];
        ifg_eats_qav_credit <= pwdata[30];
      end
      else
      begin
        if (dma_rx_err_rst_req | (rx_lockup_comb & lockup_recovery_en))
          enable_receive  <= 1'b0;
        if (dma_tx_err_rst_req | (tx_lockup_comb & lockup_recovery_en))
          enable_transmit <= 1'b0;
      end
  end


  // Statistics specific control registers
  generate if (p_edma_no_stats == 0) begin : gen_stats_reg
    reg   clear_all_stats_regs_r;
    reg   inc_all_stats_regs_r;
    reg   stats_write_en_r;
    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
      begin
        clear_all_stats_regs_r  <= 1'b0;
        inc_all_stats_regs_r    <= 1'b0;
        stats_write_en_r        <= 1'b0;
      end
      else
      begin
        if (write_registers)
        begin
          if (i_paddr == `gem_network_control)
          begin
            clear_all_stats_regs_r <= pwdata[5];
            inc_all_stats_regs_r   <= pwdata[6];
            stats_write_en_r       <= pwdata[7];
          end
        end
        else
        begin
          // reset signals used as pulse indications
          clear_all_stats_regs_r <= 1'b0;
          inc_all_stats_regs_r   <= 1'b0;
        end
      end
    end
    assign clear_all_stats_regs = clear_all_stats_regs_r;
    assign inc_all_stats_regs   = inc_all_stats_regs_r;
    assign stats_write_en       = stats_write_en_r;

    // Snapshot registers if configured
    if (p_edma_no_snapshot == 0) begin : gen_snapshot_regs
      reg   stats_take_snap_r;
      reg   stats_read_snap_r;
      always@(posedge pclk or negedge n_preset)
      begin
        if(~n_preset)
        begin
          stats_take_snap_r <= 1'b0;
          stats_read_snap_r <= 1'b0;
        end
        else
        begin
          if (write_registers)
          begin
            if (i_paddr == `gem_network_control)
            begin
              stats_take_snap_r    <= pwdata[13];
              stats_read_snap_r    <= pwdata[14];
            end
          end
          else
            // reset signals used as pulse indications
            stats_take_snap_r    <= 1'b0;
        end
      end
      assign stats_take_snap = stats_take_snap_r;
      assign stats_read_snap = stats_read_snap_r;
    end
    else
    begin : gen_no_snapshot_regs
      assign stats_take_snap = 1'b0;
      assign stats_read_snap = 1'b0;
    end
  end
  else
  begin : gen_no_stats_reg
    assign clear_all_stats_regs = 1'b0;
    assign inc_all_stats_regs   = 1'b0;
    assign stats_write_en       = 1'b0;
    assign stats_take_snap      = 1'b0;
    assign stats_read_snap      = 1'b0;
  end
  endgenerate


  // PFC specific control registers
  generate if (p_edma_pfc_multi_quantum == 1) begin : gen_pfc_multi_regs
    reg          pfc_ctrl_r;
    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
        pfc_ctrl_r  <= 1'b0;
      else
        if (write_registers  & (i_paddr == `gem_network_control))
          pfc_ctrl_r  <= pwdata[25];
    end
    assign  pfc_ctrl = pfc_ctrl_r;
  end
  else
  begin : gen_no_pfc_multi
    assign  pfc_ctrl = 1'b0;
  end
  endgenerate


  // RX Packet buffer control registers
  generate if (p_edma_rx_pkt_buffer == 1) begin : gen_rx_pbuf_reg
    reg     flush_rx_pkt_pclk_r;
    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
        flush_rx_pkt_pclk_r <= 1'b0;
      else
        if (write_registers  & (i_paddr == `gem_network_control))
          flush_rx_pkt_pclk_r <= pwdata[18] ? ~flush_rx_pkt_pclk : flush_rx_pkt_pclk;
    end
    assign flush_rx_pkt_pclk  = flush_rx_pkt_pclk_r;
  end
  else
  begin : gen_no_rx_pbuf_reg
    assign flush_rx_pkt_pclk  = 1'b0;
  end
  endgenerate


  // TSU specific control registers
  generate if (p_edma_tsu == 1) begin : gen_tsu_reg
    reg   store_rx_ts_r;
    reg   one_step_sync_mode_r;
    reg   oss_correction_field_r;
    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
      begin
        store_rx_ts_r           <= 1'b0;
        one_step_sync_mode_r    <= 1'b0;
        oss_correction_field_r  <= 1'b0;
      end
      else
        if (write_registers  & (i_paddr == `gem_network_control))
        begin
          store_rx_ts_r           <= pwdata[15];
          one_step_sync_mode_r    <= pwdata[24];
          oss_correction_field_r  <= pwdata[27];
        end
    end

    assign store_rx_ts          = store_rx_ts_r;
    assign one_step_sync_mode   = one_step_sync_mode_r;
    assign oss_correction_field = oss_correction_field_r;

    if (p_edma_ext_tsu_timer == 1) begin : gen_ext_tsu_timer
      reg   ext_tsu_timer_en_r;
      always@(posedge pclk or negedge n_preset)
      begin
        if(~n_preset)
          ext_tsu_timer_en_r <= 1'b0;
        else if (write_registers  & (i_paddr == `gem_network_control))
          ext_tsu_timer_en_r <= pwdata[23];
      end
      assign ext_tsu_timer_en = ext_tsu_timer_en_r;
    end
    else
    begin : gen_no_ext_tsu_timer
      assign ext_tsu_timer_en = 1'b0;
    end

  end
  else
  begin : gen_no_tsu_reg
    assign store_rx_ts          = 1'b0;
    assign ext_tsu_timer_en     = 1'b0;
    assign one_step_sync_mode   = 1'b0;
    assign oss_correction_field = 1'b0;
  end
  endgenerate

  // Assign to network control bus
  assign network_control  = {1'b0,
                              ifg_eats_qav_credit,
                              two_pt_five_gig,
                              sel_mii_on_rgmii,
                              oss_correction_field,
                              ext_rxq_sel_en,
                              pfc_ctrl,
                              one_step_sync_mode,
                              ext_tsu_timer_en,
                              store_udp_offset,
                              alt_sgmii_mode,
                              ptp_unicast_ena,
                              tx_lpi_en,
                              flush_rx_pkt_pclk,
                              tx_pfc_frame_req,
                              pfc_enable,
                              store_rx_ts,
                              stats_read_snap,
                              stats_take_snap,
                              tx_pause_frame_zero,
                              tx_pause_frame_req,
                              tx_halt_pclk,
                              tx_start_pclk,
                              back_pressure,
                              stats_write_en,
                              inc_all_stats_regs,
                              clear_all_stats_regs,
                              man_port_en,
                              enable_transmit,
                              enable_receive,
                              loopback_local,
                              loopback};

endmodule
