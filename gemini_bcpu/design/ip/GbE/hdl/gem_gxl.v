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
//   Filename:           gem.v
//   Module Name:        gem
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
//   Description :   Top level Gigabit Ethernet Mac block that instances gem_ss
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_gxl (

  // system interface (resets)
  n_txreset,
  n_rxreset,

  // Internal loopback signals
  `ifdef gem_int_loopback
    n_ntxreset,
    n_tx_clk,
    loopback_local,
  `else
    `ifdef gem_use_rgmii
      n_ntxreset,
      n_tx_clk,
    `endif // gem_use_rgmii
  `endif // gem_int_loopback

  tx_clk,
  rx_clk,
  `ifdef gem_use_rgmii
    tx_clk_sig,
    n_nrxreset,
    n_rx_clk,
    rgmii_txd,
    rgmii_tx_ctl,
    rgmii_rxd,
    rgmii_rx_ctl,
    rgmii_link_status,
    rgmii_speed,
    rgmii_duplex_out,
  `else
    // gmii / mii ethernet interface.
    txd,
    tx_en,
    rxd,
    rx_dv,
  `endif // gem_use_rgmii
  tx_er,
  rx_er,
  col,
  crs,

  `ifdef gem_include_rmii
    // 10/100 MII select
    mii_select,

    // rmii interface signals.
    n_ref_reset,
    ref_clk,
    rmii_rx_clk,
    rmii_tx_clk,
    rmii_txd,
    rmii_tx_en,
    rmii_rxd,
    rmii_rx_er,
    rmii_crs_dv,
  `endif // gem_include_rmii

  // ten bit interface signals.
  `ifdef gem_no_pcs
  `else // if not gem_no_pcs
    gtx_clk,
    n_gtxreset,
    `ifdef gem_pcs_20b_if
      gtx20_clk,
      n_gtx20reset,
    `endif // gem_pcs_20b_if
  
    `ifdef gem_pcs_legacy_if
      rbc0,
      rbc1,
      n_rbc0reset,
      n_rbc1reset,
    `else
      pcs_rx_clk,
      n_pcs_rxreset,
      pcs_cal_bypass,
      pcs_cgalign_bypass,
    `endif // gem_pcs_legacy_if
  
    `ifdef gem_pcs_10b_if
      pcs_rx10_clk,
      n_pcs_rx10reset,
    `endif // gem_pcs_10b_if
    tx_group,
    rx_group,
    ewrap,
    en_cdet,
    signal_detect,

  `endif // gem_no_pcs

  // other ethernet signals.
  mdc,
  mdio_in,
  mdio_out,
  mdio_en,
  loopback,
  half_duplex,
  speed_mode,
  ext_interrupt_in,
  tx_pause,
  tx_pause_zero,
  tx_pfc_sel,
  tx_pfc_pause,
  tx_pfc_pause_zero,
  pfc_negotiate,
  rx_pfc_paused,
  wol,

  // external filter interface
  ext_match1,
  ext_match2,
  ext_match3,
  ext_match4,
  ext_da,
  ext_da_stb,
  ext_sa,
  ext_sa_stb,
  ext_type,
  ext_type_stb,
  ext_ip_sa,
  ext_ip_sa_stb,
  ext_ip_da,
  ext_ip_da_stb,
  ext_source_port,
  ext_sp_stb,
  ext_dest_port,
  ext_dp_stb,
  ext_ipv6,

  // Stacked VLAN tag support
  ext_vlan_tag1,
  ext_vlan_tag1_stb,
  ext_vlan_tag2,
  ext_vlan_tag2_stb,

  // TSU timer
  `ifdef gem_tsu
    gem_tsu_inc_ctrl,
    gem_tsu_ms,
    tsu_timer_cnt,
    tsu_timer_cmp_val,

    // tsu clock
    `ifdef gem_tsu_clk
      tsu_clk,
      n_tsureset,
    `endif // gem_tsu_clk

    `ifdef gem_ext_tsu_timer
      ext_tsu_timer,
    `endif // gem_ext_tsu_timer
  `endif // gem_tsu

  // precision time protocol signals for IEEE 1588 support
  sof_tx,
  sync_frame_tx,
  delay_req_tx,
  pdelay_req_tx,
  pdelay_resp_tx,
  sof_rx,
  sync_frame_rx,
  delay_req_rx,
  pdelay_req_rx,
  pdelay_resp_rx,

  // amba apb interface signals.
  pclk,
  n_preset,
  paddr,
  prdata,
  pwdata,
  pwrite,
  penable,
  psel,
  perr,

  // AHB and/or Exposed FIFO interface is available
  // pmac connections
  `ifdef gem_add_tx_external_fifo_if
    // low latency tx interface uses external fifo tx port
    tx_r_data,
    `ifdef gem_fifo_8b_if
    `else
      tx_r_mod,
    `endif // gem_fifo_8b_if
    tx_r_sop,
    tx_r_eop,
    tx_r_err,
    tx_r_valid,
    tx_r_data_rdy,
    tx_r_underflow,
    tx_r_rd,
    `ifdef dma_priority_queue1
      tx_r_queue,
    `endif
    tx_r_flushed,
    tx_r_control,
    tx_r_status,
    tx_r_frame_size_vld,
    tx_r_frame_size,
    `ifdef gem_fifo_8b_if
      tx_r_fixed_lat,
    `endif
    `ifdef gem_tsu
      tx_r_timestamp,
    `endif

    dma_tx_status_tog,
    dma_tx_end_tog,
  `endif // gem_add_tx_external_fifo_if

  `ifdef gem_add_rx_external_fifo_if
    rx_w_wr,
    rx_w_data,
    rx_w_sop,
    rx_w_eop,
    rx_w_err,
    rx_w_flush,
    rx_w_status,
    rx_w_overflow,
    `ifdef dma_priority_queue1
      rx_w_queue,
    `endif
    `ifndef gem_fifo_8b_if
      rx_w_mod,
    `else
      `ifdef gem_no_pcs
      `else // if not gem_no_pcs
        rx_clk_from_phy,
      `endif
    `endif // gem_fifo_8b_if

    `ifdef num_spec_add_filters
      add_match_vec,
    `endif
    `ifdef gem_tsu
      rx_w_timestamp,
    `endif
  `endif //gem_add_rx_external_fifo_if

  // AHB and/or Exposed FIFO interface is available
  // emac connections
  `ifdef gem_has_802p3_br
    `ifdef gem_add_tx_external_fifo_if
      // low latency tx interface uses external fifo tx port
      emac_tx_r_data,
      `ifdef gem_fifo_8b_if
      `else
        emac_tx_r_mod,
      `endif // gem_fifo_8b_if
      emac_tx_r_sop,
      emac_tx_r_eop,
      emac_tx_r_err,
      emac_tx_r_valid,
      emac_tx_r_data_rdy,
      emac_tx_r_underflow,
      emac_tx_r_rd,
      `ifdef dma_priority_queue1
        emac_tx_r_queue,
      `endif
      emac_tx_r_flushed,
      emac_tx_r_control,
      emac_tx_r_status,
      emac_tx_r_frame_size_vld,
      emac_tx_r_frame_size,
      `ifdef gem_fifo_8b_if
        emac_tx_r_fixed_lat,
      `endif
      `ifdef gem_tsu
        emac_tx_r_timestamp,
      `endif

      emac_dma_tx_status_tog,
      emac_dma_tx_end_tog,
    `endif // gem_add_tx_external_fifo_if

    `ifdef gem_add_rx_external_fifo_if
      emac_rx_w_wr,
      emac_rx_w_data,
      emac_rx_w_sop,
      emac_rx_w_eop,
      emac_rx_w_err,
      emac_rx_w_flush,
      emac_rx_w_status,
      emac_rx_w_overflow,
      `ifdef dma_priority_queue1
        emac_rx_w_queue,
      `endif
      `ifndef gem_fifo_8b_if
        emac_rx_w_mod,
      `else
      `endif

      `ifdef num_spec_add_filters
        emac_add_match_vec,
      `endif
      `ifdef gem_tsu
        emac_rx_w_timestamp,
      `endif
    `endif // gem_add_rx_external_fifo_if
  `endif //gem_has_802p3_br

  // DMA bus width indication to external controller or FIFO
  dma_bus_width,

  `ifdef gem_ext_fifo_interface
  `else
    `ifdef gem_tx_pkt_buffer
      trigger_dma_tx_start,
    `endif

    `ifdef gem_axi
      // AXI interface signals
      aclk,
      n_areset,

      // Write Address Channel
      awid,
      awaddr,
      awlen,
      awsize,
      awburst,
      awlock,
      awcache,
      awprot,
      awqos,
      awvalid,
      awready,
      // Write Data Channel
      wdata,
      wstrb,
      wlast,
      wid,
      wready,
      wvalid,

      // Response Channel
      bid,
      bresp,
      bvalid,
      bready,

      // Read Address Channel
      arid,
      araddr,
      arlen,
      arsize,
      arburst,
      arlock,
      arcache,
      arprot,
      arqos,
      arvalid,
      arready,
      // Read Data Channel
      rid,
      rdata,
      rresp,
      rlast,
      rvalid,
      rready,


    `else 
      // AHB interface signals.
      hclk,
      n_hreset,
      hgrant,
      hready,
      hresp,
      hrdata,
      hbusreq,
      hlock,
      haddr,
      htrans,
      hwrite,
      hsize,
      hburst,
      hprot,
      hwdata,
    `endif // gem_axi

    // Packet buffer external DPSRAM connections
    `ifdef gem_rx_pkt_buffer
      `ifdef gem_spram
        rxspram_we,
        rxspram_en,
        rxspram_addr,
        rxspram_di,
        rxspram_do,
        `ifdef gem_has_802p3_br
          emac_rxspram_we,
          emac_rxspram_en,
          emac_rxspram_addr,
          emac_rxspram_di,
          emac_rxspram_do,
        `endif
      `else
        rxdpram_wea,
        rxdpram_ena,
        rxdpram_addra,
        rxdpram_dia,
        rxdpram_web,
        rxdpram_enb,
        rxdpram_addrb,
        rxdpram_dob,
        `ifdef gem_has_802p3_br
          emac_rxdpram_wea,
          emac_rxdpram_ena,
          emac_rxdpram_addra,
          emac_rxdpram_dia,
          emac_rxdpram_web,
          emac_rxdpram_enb,
          emac_rxdpram_addrb,
          emac_rxdpram_dob,
        `endif // gem_has_802p3_br
      `endif // gem_spram
    `endif // gem_rx_pkt_buffer

    `ifdef gem_tx_pkt_buffer
      `ifdef gem_spram
        txspram_we,
        txspram_en,
        txspram_addr,
        txspram_di,
        txspram_do,
        `ifdef gem_has_802p3_br
          emac_txspram_we,
          emac_txspram_en,
          emac_txspram_addr,
          emac_txspram_di,
          emac_txspram_do,
        `endif
      `else
        txdpram_wea,
        txdpram_ena,
        txdpram_addra,
        txdpram_dia,
        txdpram_web,
        txdpram_enb,
        txdpram_addrb,
        txdpram_dob,
        `ifdef gem_has_802p3_br
          emac_txdpram_wea,
          emac_txdpram_ena,
          emac_txdpram_addra,
          emac_txdpram_dia,
          emac_txdpram_web,
          emac_txdpram_enb,
          emac_txdpram_addrb,
          emac_txdpram_dob,
        `endif // gem_has_802p3_br
      `endif // gem_spram
    `endif // gem_tx_pkt_buffer

  `endif //gem_ext_fifo_interface

  // User I/O interface
  `ifdef gem_user_io
    user_out,
    user_in,
  `endif // gem_user_io

  // Specific outputs to support Priority Queues
  `ifdef gem_ext_fifo_interface
  `else
    rx_databuf_wr_q0,
    `ifdef dma_priority_queue1
      rx_databuf_wr_q1,
    `endif
    `ifdef dma_priority_queue2
      rx_databuf_wr_q2,
    `endif
    `ifdef dma_priority_queue3
      rx_databuf_wr_q3,
    `endif
    `ifdef dma_priority_queue4
      rx_databuf_wr_q4,
    `endif
    `ifdef dma_priority_queue5
      rx_databuf_wr_q5,
    `endif
    `ifdef dma_priority_queue6
      rx_databuf_wr_q6,
    `endif
    `ifdef dma_priority_queue7
      rx_databuf_wr_q7,
    `endif
    `ifdef dma_priority_queue8
      rx_databuf_wr_q8,
    `endif
    `ifdef dma_priority_queue9
      rx_databuf_wr_q9,
    `endif
    `ifdef dma_priority_queue10
      rx_databuf_wr_q10,
    `endif
    `ifdef dma_priority_queue11
      rx_databuf_wr_q11,
    `endif
    `ifdef dma_priority_queue12
      rx_databuf_wr_q12,
    `endif
    `ifdef dma_priority_queue13
      rx_databuf_wr_q13,
    `endif
    `ifdef dma_priority_queue14
      rx_databuf_wr_q14,
    `endif
    `ifdef dma_priority_queue15
      rx_databuf_wr_q15,
    `endif
  `endif // gem_ext_fifo_interface

  // Specific outputs to support half duplex flow control
  halfduplex_flow_control_en,

  // Interrupt controller interface
  `ifdef gem_ext_fifo_interface
  `else
    `ifdef dma_priority_queue15
      ethernet_int_q15,
    `endif
    `ifdef dma_priority_queue14
      ethernet_int_q14,
    `endif
    `ifdef dma_priority_queue13
      ethernet_int_q13,
    `endif
    `ifdef dma_priority_queue12
      ethernet_int_q12,
    `endif
    `ifdef dma_priority_queue11
      ethernet_int_q11,
    `endif
    `ifdef dma_priority_queue10
      ethernet_int_q10,
    `endif
    `ifdef dma_priority_queue9
      ethernet_int_q9,
    `endif
    `ifdef dma_priority_queue8
      ethernet_int_q8,
    `endif
    `ifdef dma_priority_queue7
      ethernet_int_q7,
    `endif
    `ifdef dma_priority_queue6
      ethernet_int_q6,
    `endif
    `ifdef dma_priority_queue5
      ethernet_int_q5,
    `endif
    `ifdef dma_priority_queue4
      ethernet_int_q4,
    `endif
    `ifdef dma_priority_queue3
      ethernet_int_q3,
    `endif
    `ifdef dma_priority_queue2
      ethernet_int_q2,
    `endif
    `ifdef dma_priority_queue1
      ethernet_int_q1,
    `endif
  `endif // gem_ext_fifo_interface

  // ASF comman output error indications
  `ifndef gem_ext_fifo_interface
    `ifdef gem_tx_pkt_buffer
    `endif // gem_tx_pkt_buffer
  `endif // gem_ext_fifo_interface
  
  asf_protocol_err,
  asf_trans_to_err,
  // ASF and fatal and non-fatal interrupts
  asf_int_nonfatal,
  asf_int_fatal,

  `ifdef gem_has_802p3_br
    // ASF comman output error indications for emac
    `ifndef gem_ext_fifo_interface
      `ifdef gem_tx_pkt_buffer
      `endif // gem_tx_pkt_buffer
    `endif // gem_ext_fifo_interface
  
    emac_asf_trans_to_err,
    emac_asf_protocol_err,
    // ASF and fatal and non-fatal interrupts for emac
    emac_asf_int_nonfatal,
    emac_asf_int_fatal,
  `endif // gem_has_802p3_br

  `ifdef gem_has_802p3_br
    emac_ethernet_int,
    mmsl_int,
  `endif
  ethernet_int
);


//------------------------------------------------------------------------------
// Declare inputs and outputs
//------------------------------------------------------------------------------

  `include "edma_params.v"

  // system interface (resets)
  input          n_txreset;         // tx_clk domain reset
  input          n_rxreset;         // rx_clk domain reset

  // Internal loopback signals
  `ifdef gem_int_loopback
    input          n_ntxreset;      // n_tx_clk domain reset
    input          n_tx_clk;        // inverted tx_clk_in used for loopback.
    output         loopback_local;  // Indicates MAC is in local loopback.
  `else
    `ifdef gem_use_rgmii
      input          n_ntxreset;
      input          n_tx_clk;
    `endif
  `endif // gem_int_loopback

  input          tx_clk;            // transmit clock from the phy.
  input          rx_clk;            // receive clock from the phy.

  `ifdef gem_use_rgmii
    // rgmii interface signals
    input          tx_clk_sig;
    input          n_nrxreset;
    input          n_rx_clk;
    output   [3:0] rgmii_txd;
    output         rgmii_tx_ctl;
    input    [3:0] rgmii_rxd;
    input          rgmii_rx_ctl;
    output         rgmii_link_status; // rgmii extracted link status
    output   [1:0] rgmii_speed;       // rgmii extracted speed status
    output         rgmii_duplex_out;  // rgmii extracted duplex status
  `else
    // gmii / mii ethernet interface.
    output   [7:0] txd;               // transmit data to the phy.
    output         tx_en;             // transmit enable signal to the phy.
    input    [7:0] rxd;               // receive data from the phy.
    input          rx_dv;             // receive data valid signal from the phy.
  `endif // gem_use_rgmii

  output         tx_er;               // transmit error signal to the phy.
  input          rx_er;               // receive error signal from the phy.
  input          col;                 // collision detect signal from the phy.
  input          crs;                 // carrier sense signal from the phy.

  `ifdef gem_include_rmii
    input          mii_select;        // 10/100 MII select - low for RMII

    // rmii interface signals.
    input          n_ref_reset;       // RMII reset for ref clock
    input          ref_clk;           // RMII ref clock
    output         rmii_rx_clk;       // clock generated by RMII for RX Path
    output         rmii_tx_clk;       // clock generated by RMII for TX Path
    output   [1:0] rmii_txd;          // transmit data to the phy.
    output         rmii_tx_en;        // transmit enable signal to the phy.
    input    [1:0] rmii_rxd;          // receive data from the phy.
    input          rmii_rx_er;        // receive error signal from the phy.
    input          rmii_crs_dv;       // receive data valid signal from the phy.
  `endif // gem_include_rmii

  // ten bit interface signals.
  `ifdef gem_no_pcs
  `else // if not gem_no_pcs
    input          gtx_clk;           // Gigabit tx clock.
    input          n_gtxreset;        // Reset in tx domain.
    `ifdef gem_pcs_20b_if
      input          gtx20_clk;         // Gigabit tx clock divided by 2.
      input          n_gtx20reset;      // Reset in tx domain.
    `endif // gem_pcs_20b_if
    `ifdef gem_pcs_legacy_if
      input          rbc0;              // receive clock 0 from phy.
      input          rbc1;              // receive clock 1 from phy.
      input          n_rbc0reset;       // rbc0 domain reset
      input          n_rbc1reset;       // rbc1 domain reset
    `else
      input          pcs_rx_clk;        // PCS 62.5MHz receive clock
      input          n_pcs_rxreset;     // Asynchronous reset
      input          pcs_cal_bypass;    // Bypass comma alignment
      input          pcs_cgalign_bypass;// Bypass codegroup alignment
    `endif // gem_pcs_legacy_if
    `ifdef gem_pcs_10b_if
      input          pcs_rx10_clk;      // PCS 125MHz receive clock
      input          n_pcs_rx10reset;   // Asynchronous reset
    `endif
    `ifdef gem_pcs_20b_if
      output [19:0]  tx_group;          // 8b/10b encoded transmit data to the phy.
      input  [19:0]  rx_group;          // 8b/10b encoded receive data from the phy
    `else
      output [9:0]   tx_group;          // 8b/10b encoded transmit data to the phy.
      input  [9:0]   rx_group;          // 8b/10b encoded receive data from the phy
    `endif // gem_pcs_20b_if
    output         ewrap;             // initiate loop back of phy.
    output         en_cdet;           // Enable comma alignment in PMA.
    input          signal_detect;     // Valid link detected from PMD.
  `endif // gem_no_pcs

  // Other ethernet signals.
  output         mdc;               // management data clock.
  input          mdio_in;           // management data input.
  output         mdio_out;          // management data output.
  output         mdio_en;           // management data output enable.
  output         loopback;          // loopback signal to the phy.
  output         half_duplex;       // half duplex signal to the phy.
  output   [3:0] speed_mode;        // Indicate speed and interface selected.
  input          ext_interrupt_in;  // external interrupt input.
  input          tx_pause;          // toggling this input causes a
                                    // pause frame to be transmitted with
                                    // the pause quantum value taken from
                                    // the transmit pause quantum
                                    // register.
  input          tx_pause_zero;     // toggling this input causes a pause
                                    // frame to be transmitted with zero
                                    // pause quantum.
  input          tx_pfc_sel;        // When set to 0, transmit 802.3
                                    // pause frame
                                    // When set to 1, transmit PFC
                                    // pause frame

  input    [7:0] tx_pfc_pause;      // priority enable vector of the
                                    // PFC pause frame
  input    [7:0] tx_pfc_pause_zero; // When set to 1, PFC pause frame
                                    // has zero pause quantum
                                    // When set to 0, PFC pause frame
                                    // has the value of transmit pause
  output         pfc_negotiate;     // indicates a received PFC
                                    // pause frame

                                    // quantum register
  output [7:0]   rx_pfc_paused;     // each bit is set when PFC frame has
                                    // been received and the associated
                                    // PFC counter != 0
  output         wol;               // Wake-on-LAN output

  // external filter interface
  input          ext_match1;        // external match (frame will be copied).
  input          ext_match2;        // external match (frame will be copied).
  input          ext_match3;        // external match (frame will be copied).
  input          ext_match4;        // external match (frame will be copied).
  output  [47:0] ext_da;            // destination address from the rx frame
  output         ext_da_stb;        // set when destination address valid
  output  [47:0] ext_sa;            // source address from the receive data
  output         ext_sa_stb;        // set when source address valid
  output  [15:0] ext_type;          // length/TypeID field from the rx frame
  output         ext_type_stb;      // length/TypeID field valid
  output [127:0] ext_ip_sa;         // IP source address
  output         ext_ip_sa_stb;     // IP source address valid strobe
  output [127:0] ext_ip_da;         // IP destination address
  output         ext_ip_da_stb;     // IP destination address valid strobe
  output  [15:0] ext_source_port;   // source port number
  output         ext_sp_stb;        // validates source port number
  output  [15:0] ext_dest_port;     // destination port number
  output         ext_dp_stb;        // validates destination port number
  output         ext_ipv6;          // high for ipv6

  output [31:0]  ext_vlan_tag1;     // VLAN tag 1
  output         ext_vlan_tag1_stb; // VLAN tag 1 strobe
  output [31:0]  ext_vlan_tag2;     // VLAN tag 2
  output         ext_vlan_tag2_stb; // VLAN tag 2 strobe

  // TSU timer control signals
  `ifdef gem_tsu
    input          gem_tsu_ms;        // timer master/slave
    input    [1:0] gem_tsu_inc_ctrl;  // timer increment control
    output  [93:0] tsu_timer_cnt;     // TSU timer count value
    output         tsu_timer_cmp_val; // TSU timer comparison valid

    // tsu clock signals
    `ifdef gem_tsu_clk
      input          tsu_clk;             // TSU timer clock (10 to 50MHz)
      input          n_tsureset;          // Reset in tsu_clk domain
    `endif // gem_tsu_clk
    `ifdef gem_ext_tsu_timer
      input   [93:0] ext_tsu_timer;       // external TSU timer value
    `endif // gem_ext_tsu_timer
  `endif // gem_tsu
  // precision time protocol signals for IEEE 1588 support
  output         sof_tx;            // asserted on SFD deasserted at EOF
  output         sync_frame_tx;     // asserted if PTP sync frame is detected
  output         delay_req_tx;      // asserted if PTP delay_req is detected
  output         pdelay_req_tx;     // asserted if PTP pdelay_req is detected
  output         pdelay_resp_tx;    // asserted if PTP pdelay_resp is detected
  output         sof_rx;            // asserted on SFD deasserted at EOF
  output         sync_frame_rx;     // asserted if PTP sync frame is detected
  output         delay_req_rx;      // asserted if PTP delay_req is detected
  output         pdelay_req_rx;     // asserted if PTP pdelay_req is detected
  output         pdelay_resp_rx;    // asserted if PTP pdelay_resp is detected

  // APB interface signals.
  input          pclk;                // amba apb clock.
  input          n_preset;            // amba apb reset.
    `ifdef gem_has_802p3_br
      input   [12:2] paddr;           // address bus of selected master.
    `else
      input   [11:2] paddr;           // address bus of selected master.
    `endif
  output  [31:0] prdata;            // read data.
  input   [31:0] pwdata;            // write data.
  input          pwrite;            // peripheral write strobe.
  input          penable;           // peripheral enable.
  input          psel;              // peripheral select for gpio.
  output         perr;              // not a standard apb signal, driven high
                                    // when psel is asserted if address is not
                                    // known.
  `ifdef gem_add_tx_external_fifo_if
    `ifdef gem_fifo_8b_if
      input                      [7:0] tx_r_data;
      output                           tx_r_fixed_lat;  // latency has become fixed
    `else
      input  [`gem_emac_bus_width-1:0] tx_r_data;       // output data from the transmit fifo to the module
      input                      [3:0] tx_r_mod;        // tx number of valid bytes in last
                                                        // transfer of the frame.
                                                        // 0000 - tx_r_data[127:0] valid,
                                                        // 0001 - tx_r_data[7:0] valid,
                                                        // 0010 - tx_r_data[15:0] valid, until
                                                        // 1111 - tx_r_data[119:0] valid.
    `endif // gem_fifo_8b_if
    input                            tx_r_sop;          // start of packet indicator.
    input                            tx_r_eop;          // end of packet indicator.
    input                            tx_r_err;          // packet in error indicator.
    output       [`edma_queues-1:0]  tx_r_rd;           // request new data from fifo.
    `ifdef dma_priority_queue1
      output                     [3:0] tx_r_queue;      // Queue ID, timed with tx_r_rd
    `endif
    input                            tx_r_valid;        // new tx data available from fifo.
    input         [`edma_queues-1:0] tx_r_data_rdy;     // indicates either a complete packet
                                                        // is present in the fifo or a certain
                                                        // threshold of data has been crossed,
                                                        // the mac uses this input to trigger
                                                        // a frame transfer.
    input                            tx_r_underflow;      // signals tx fifo underrun condition.
    input                            tx_r_flushed;        // tx fifo has been flushed.
    input                            tx_r_control;        // tx control from in-line FIFO word
    output                     [3:0] tx_r_status;         // tx status written to in-line FIFO word
    input        [p_edma_queues-1:0] tx_r_frame_size_vld; // We have the frame size.
    input   [(p_edma_queues*14)-1:0] tx_r_frame_size;     // Frame Length, 1 per queue
    `ifdef gem_tsu
      output                    [77:0] tx_r_timestamp;    // asserted high at the end of frame
    `endif
    input                            dma_tx_status_tog;   // toggle acknowledge for tx_r_status.
    output                           dma_tx_end_tog;      // toggled when tx_r_status is valid.
  `endif // gem_add_tx_external_fifo_if

  `ifdef gem_add_rx_external_fifo_if
    `ifdef gem_tsu
      output                       [77:0] rx_w_timestamp;  // valid on rx_w_eop
    `endif
    output                              rx_w_wr;           // rx write output to the receive fifo
    `ifdef gem_fifo_8b_if
      `ifdef gem_no_pcs
      `else // if not gem_no_pcs
        input                               rx_clk_from_phy; // extra clock needed when rx_clk is only 62.5Mhz.  This clock is
                                                             // frequency locked and aligned to rx_clk
      `endif // gem_no_pcs
      output                        [7:0] rx_w_data;         // output data to the receive fifo.
    `else
      output    [`gem_emac_bus_width-1:0] rx_w_data;         // output data to the receive fifo.
      output                        [3:0] rx_w_mod;          // rx number of valid bytes in last.
                                                             // transfer of the frame.
    `endif // gem_fifo_8b_if
    output                              rx_w_sop;        // rx start of packet indicator.
    output                              rx_w_eop;        // rx end of packet indicator.
    output                              rx_w_err;        // rx packet in error indicator.
    output                              rx_w_flush;      // rx fifo flush from the mac.
    output                       [44:0] rx_w_status;     // rx status written to in-line FIFO word.
    `ifdef dma_priority_queue1
      output                        [3:0] rx_w_queue;    // rx queue valid on EOP
    `endif
    `ifdef num_spec_add_filters
      output  [`num_spec_add_filters-1:0] add_match_vec; // indicates specific address match status
                                                         // 3 to 0 are returned by rx_w_status
    `endif
    input                               rx_w_overflow;   // Overrun in RX FIFO indication.
  `endif  // gem_add_rx_external_fifo_if

  `ifdef gem_has_802p3_br
    `ifdef gem_add_tx_external_fifo_if
      `ifdef gem_fifo_8b_if
        input                      [7:0] emac_tx_r_data;
        output                           emac_tx_r_fixed_lat;  // latency has become fixed
      `else
        input  [`gem_emac_bus_width-1:0] emac_tx_r_data;       // output data from the transmit fifo to the module
        input                      [3:0] emac_tx_r_mod;        // tx number of valid bytes in last
                                                               // transfer of the frame.
                                                               // 0000 - tx_r_data[127:0] valid,
                                                               // 0001 - tx_r_data[7:0] valid,
                                                               // 0010 - tx_r_data[15:0] valid, until
                                                               // 1111 - tx_r_data[119:0] valid.
      `endif // gem_fifo_8b_if
      input                            emac_tx_r_sop;          // start of packet indicator.
      input                            emac_tx_r_eop;          // end of packet indicator.
      input                            emac_tx_r_err;          // packet in error indicator.
      output                           emac_tx_r_rd;           // request new data from fifo.
      `ifdef dma_priority_queue1
        output                     [3:0] emac_tx_r_queue;      // Queue ID, timed with tx_r_rd
      `endif
      input                            emac_tx_r_valid;        // new tx data available from fifo.
      input                            emac_tx_r_data_rdy;     // indicates either a complete packet
                                                               // is present in the fifo or a certain
                                                               // threshold of data has been crossed,
                                                               // the mac uses this input to trigger
                                                               // a frame transfer.
      input                            emac_tx_r_underflow;      // signals tx fifo underrun condition.
      input                            emac_tx_r_flushed;        // tx fifo has been flushed.
      input                            emac_tx_r_control;        // tx control from in-line FIFO word
      output                     [3:0] emac_tx_r_status;         // tx status written to in-line FIFO word
      input                            emac_tx_r_frame_size_vld; // We have the frame size.
      input                     [13:0] emac_tx_r_frame_size;     // Frame Length, 1 per queue
      `ifdef gem_tsu
        output                    [77:0] emac_tx_r_timestamp;    // asserted high at the end of frame
      `endif
      input                            emac_dma_tx_status_tog;   // toggle acknowledge for tx_r_status.
      output                           emac_dma_tx_end_tog;      // toggled when tx_r_status is valid.
    `endif // gem_add_tx_external_fifo_if

    `ifdef gem_add_rx_external_fifo_if
      `ifdef gem_tsu
        output                       [77:0] emac_rx_w_timestamp; // valid on rx_w_eop
      `endif
      output                              emac_rx_w_wr;          // rx write output to the receive fifo
      `ifdef gem_fifo_8b_if
        output                        [7:0] emac_rx_w_data;      // output data to the receive fifo.
      `else
        output    [`gem_emac_bus_width-1:0] emac_rx_w_data;      // output data to the receive fifo.
        output                        [3:0] emac_rx_w_mod;       // rx number of valid bytes in last.
                                                                 // transfer of the frame.
      `endif
      output                              emac_rx_w_sop;         // rx start of packet indicator.
      output                              emac_rx_w_eop;         // rx end of packet indicator.
      output                              emac_rx_w_err;         // rx packet in error indicator.
      output                              emac_rx_w_flush;       // rx fifo flush from the mac.
      output                       [44:0] emac_rx_w_status;      // rx status written to in-line FIFO word.
      `ifdef dma_priority_queue1
        output                        [3:0] emac_rx_w_queue;     // rx queue valid on EOP
      `endif
      `ifdef num_spec_add_filters
        output  [`num_spec_add_filters-1:0] emac_add_match_vec;  // indicates specific address match status
                                                                 // 3 to 0 are returned by rx_w_status
      `endif
      input                               emac_rx_w_overflow;    // Overrun in RX FIFO indication.
    `endif  // gem_add_rx_external_fifo_if
  `endif // gem_has_802p3_br

  // DMA bus width indication to external controller or FIFO
  output   [1:0] dma_bus_width;     // encoding for dma bus width.


  `ifdef gem_ext_fifo_interface
  `else
    `ifdef gem_tx_pkt_buffer
      input          trigger_dma_tx_start;// Async input used to trigger tx_start
    `endif

    `ifdef gem_axi
      // AXI interface signals.
      input          aclk;
      input          n_areset;

      // Write Address Channel
      output                         [3:0]  awid;
      output        [`edma_addr_width-1:0] awaddr;
      output                         [7:0] awlen;
      output                         [2:0] awsize;
      output                         [1:0] awburst;
      output                         [1:0] awlock;
      output                         [3:0] awcache;
      output                         [2:0] awprot;
      output                               awvalid;
      output                         [3:0] awqos;
      input                                awready;
      // Write Data Channel
      output      [`gem_dma_bus_width-1:0] wdata;
      output  [(`gem_dma_bus_width/8)-1:0] wstrb;
      output                               wlast;
      output                         [3:0] wid;
      input                                wready;
      output                               wvalid;
 
      // Response Channel
      input                    [3:0] bid;
      input                    [1:0] bresp;
      input                          bvalid;
      output                         bready;

      // Read Address Channel
      output                   [3:0] arid;
      output  [`edma_addr_width-1:0] araddr;
      output                   [7:0] arlen;
      output                   [2:0] arsize;
      output                   [1:0] arburst;
      output                   [1:0] arlock;
      output                   [3:0] arcache;
      output                   [2:0] arprot;
      output                         arvalid;
      output                   [3:0] arqos;
      input                          arready;
      // Read Data Channel
      input                    [3:0] rid;
      input [`gem_dma_bus_width-1:0] rdata;
      input                    [1:0] rresp;
      input                          rlast;
      input                          rvalid;
      output                         rready;


    `else
      // AHB interface signals.
      input                            hclk;     // AHB clock.
      input                            n_hreset; // AHB reset.
      input                            hgrant;   // AHB arbiter control grant.
      input                            hready;   // AHB Slave ready.
      input                      [1:0] hresp;    // AHB Slave response (OK, error, retry // or split).
      input   [`gem_dma_bus_width-1:0] hrdata;   // AHB input data.

      output                           hbusreq;  // AHB bus request.
      output                           hlock;    // lock the bus - always asserted with
      output [`gem_dma_addr_width-1:0] haddr;    // hbusreq address to be accessed.
      output                     [1:0] htrans;   // bus transfer type (nonseq, seq, idle
                                                 // or busy.
      output                           hwrite;   // AHB write signal (active high).
      output                     [2:0] hsize;    // transfer size -
                                                 // set to 3'b010 for 32 bit words.
                                                 // set to 3'b011 for 64 bit words.
                                                 // set to 3'b100 for 128 bit words.
      output                     [2:0] hburst;   // burst type (single, incrementing etc).
      output                     [3:0] hprot;    // Protection type - unused tied low.
      output  [`gem_dma_bus_width-1:0] hwdata;   // AHB Write data.
    `endif // gem_axi

    // Packet buffer external DPRAM/SPRAM connections
    `ifdef gem_rx_pkt_buffer
      `ifdef gem_spram
        output                                                rxspram_we;   // RX SPRAM write enable
        output                                                rxspram_en;   // RX SPRAM chip enable
        output                        [`gem_rx_pbuf_addr-1:0] rxspram_addr; // RX SPRAM address bus
        output [p_edma_rx_pbuf_reduncy+`gem_rx_pbuf_data-1:0] rxspram_di;   // RX SPRAM write data bus and the redundancy (ECC or parity)
        input  [p_edma_rx_pbuf_reduncy+`gem_rx_pbuf_data-1:0] rxspram_do;   // RX SPRAM read data bus and the redundancy (ECC or parity)

        `ifdef gem_has_802p3_br
          output                                                emac_rxspram_we;      // RX SPRAM write enable
          output                                                emac_rxspram_en;      // RX SPRAM chip enable
          output                   [`gem_emac_rx_pbuf_addr-1:0] emac_rxspram_addr;    // RX SPRAM address bus
          output [p_edma_emac_rx_pbuf_reduncy+`gem_rx_pbuf_data-1:0] emac_rxspram_di; // RX SPRAM write data bus and the redundancy (ECC or parity)
          input  [p_edma_emac_rx_pbuf_reduncy+`gem_rx_pbuf_data-1:0] emac_rxspram_do; // RX SPRAM read data bus and the redundancy (ECC or parity)
        `endif
      `else
        output                                                rxdpram_wea;   // RX DPSRAM port A write enable.
        output                                                rxdpram_ena;   // RX DPSRAM port A chip enable.
        output                        [`gem_rx_pbuf_addr-1:0] rxdpram_addra; // RX DPSRAM port A address bus.

        output [p_edma_rx_pbuf_reduncy+`gem_rx_pbuf_data-1:0] rxdpram_dia;   // RX DPSRAM port A write data bus and the redundancy (ECC or parity)
        output                                                rxdpram_web;   // RX DPSRAM port B write enable
        output                                                rxdpram_enb;   // RX DPSRAM port B chip enable.
        output                        [`gem_rx_pbuf_addr-1:0] rxdpram_addrb; // RX DPSRAM port B address bus.
        input  [p_edma_rx_pbuf_reduncy+`gem_rx_pbuf_data-1:0] rxdpram_dob;   // RX DPSRAM port B read data bus and the redundancy (ECC or parity)
        `ifdef gem_has_802p3_br
          output                                                emac_rxdpram_wea;      // RX DPSRAM port A write enable.
          output                                                emac_rxdpram_ena;      // RX DPSRAM port A chip enable.
          output                   [`gem_emac_rx_pbuf_addr-1:0] emac_rxdpram_addra;    // RX DPSRAM port A address bus.
          output [p_edma_emac_rx_pbuf_reduncy+`gem_rx_pbuf_data-1:0] emac_rxdpram_dia; // RX DPSRAM port A write data bus and the redundancy (ECC or parity)
          output                                                emac_rxdpram_web;      // RX DPSRAM port B write enable.
          output                                                emac_rxdpram_enb;      // RX DPSRAM port B chip enable.
          output                   [`gem_emac_rx_pbuf_addr-1:0] emac_rxdpram_addrb;    // RX DPSRAM port B address bus.
          input  [p_edma_emac_rx_pbuf_reduncy+`gem_rx_pbuf_data-1:0] emac_rxdpram_dob; // RX DPSRAM port B read data bus and the redundancy (ECC or parity)
        `endif // gem_has_802p3_br
      `endif // gem_spram
    `endif // gem_rx_pkt_buffer

    `ifdef gem_tx_pkt_buffer
      `ifdef gem_spram
        output                                                txspram_we;   // TX SPRAM write enable
        output                                                txspram_en;   // TX SPRAM chip enable
        output                        [`gem_tx_pbuf_addr-1:0] txspram_addr; // TX SPRAM address bus
        output [p_edma_tx_pbuf_reduncy+`gem_tx_pbuf_data-1:0] txspram_di;   // TX SPRAM write data bus and the redundancy (ECC or parity)
        input  [p_edma_tx_pbuf_reduncy+`gem_tx_pbuf_data-1:0] txspram_do;   // TX SPRAM read data bus and the redundancy (ECC or parity)
        `ifdef gem_has_802p3_br
          output                                                emac_txspram_we;      // TX SPRAM write enable
          output                                                emac_txspram_en;      // TX SPRAM chip enable
          output                   [`gem_emac_tx_pbuf_addr-1:0] emac_txspram_addr;    // TX SPRAM address bus
          output [p_edma_emac_tx_pbuf_reduncy+`gem_tx_pbuf_data-1:0] emac_txspram_di; // TX SPRAM write data bus and the redundancy (ECC or parity)
          input  [p_edma_emac_tx_pbuf_reduncy+`gem_tx_pbuf_data-1:0] emac_txspram_do; // TX SPRAM read data bus and the redundancy (ECC or parity)
        `endif // gem_has_802p3_br
      `else // gem_spram
        output                                                txdpram_wea;   // TX DPSRAM port A write enable.
        output                                                txdpram_ena;   // TX DPSRAM port A chip enable.
        output                        [`gem_tx_pbuf_addr-1:0] txdpram_addra; // TX DPSRAM port A address bus
        output [p_edma_tx_pbuf_reduncy+`gem_tx_pbuf_data-1:0] txdpram_dia;   // TX DPSRAM port A write data bus and the redundancy (ECC or parity)
        output                                                txdpram_web;   // TX DPSRAM port B write enable.
        output                                                txdpram_enb;   // TX DPSRAM port B chip enable.
        output                        [`gem_tx_pbuf_addr-1:0] txdpram_addrb; // TX DPSRAM port B address bus.
        input  [p_edma_tx_pbuf_reduncy+`gem_tx_pbuf_data-1:0] txdpram_dob;   // TX DPSRAM port B read data bus and the redundancy (ECC or parity)
        `ifdef gem_has_802p3_br
          output                                                emac_txdpram_wea;      // TX DPSRAM port A write enable.
          output                                                emac_txdpram_ena;      // TX DPSRAM port A chip enable.
          output                   [`gem_emac_tx_pbuf_addr-1:0] emac_txdpram_addra;    // TX DPSRAM port A address bus.
          output [p_edma_emac_tx_pbuf_reduncy+`gem_tx_pbuf_data-1:0] emac_txdpram_dia; // TX DPSRAM port A write data bus and the redundancy (ECC or parity)
          output                                                emac_txdpram_web;      // TX DPSRAM port B write enable.
          output                                                emac_txdpram_enb;      // TX DPSRAM port B chip enable.
          output                   [`gem_emac_tx_pbuf_addr-1:0] emac_txdpram_addrb;    // TX DPSRAM port B address bus.
          input  [p_edma_emac_tx_pbuf_reduncy+`gem_tx_pbuf_data-1:0] emac_txdpram_dob; // TX DPSRAM port B read data bus and the redundancy (ECC or parity)
        `endif // gem_has_802p3_br
      `endif // gem_spram
    `endif // gem_tx_pkt_buffer
  `endif //gem_ext_fifo_interface

  // User I/O interface.
  `ifdef gem_user_io
    output  [(`gem_user_out_width - 1):0] // programmable user outputs
                   user_out;              // to top level
    input   [(`gem_user_in_width - 1):0]  // programmable user inputs
                   user_in;               // from top level
  `endif // gem_user_io

  // Specific outputs to support Priority Queues
  `ifdef gem_ext_fifo_interface
  `else
    output              rx_databuf_wr_q0;  // Flow Control queue 0
    `ifdef dma_priority_queue1
      output              rx_databuf_wr_q1;  // Flow Control queue 1
    `endif
    `ifdef dma_priority_queue2
      output              rx_databuf_wr_q2;  // Flow Control queue 2
    `endif
    `ifdef dma_priority_queue3
      output              rx_databuf_wr_q3;  // Flow Control queue 3
    `endif
    `ifdef dma_priority_queue4
      output              rx_databuf_wr_q4;  // Flow Control queue 4
    `endif
    `ifdef dma_priority_queue5
      output              rx_databuf_wr_q5;  // Flow Control queue 5
    `endif
    `ifdef dma_priority_queue6
      output              rx_databuf_wr_q6;  // Flow Control queue 6
    `endif
    `ifdef dma_priority_queue7
      output              rx_databuf_wr_q7;  // Flow Control queue 7
    `endif
    `ifdef dma_priority_queue8
      output              rx_databuf_wr_q8;  // Flow Control queue 8
    `endif
    `ifdef dma_priority_queue9
      output              rx_databuf_wr_q9;  // Flow Control queue 9
    `endif
    `ifdef dma_priority_queue10
      output              rx_databuf_wr_q10;  // Flow Control queue 10
    `endif
    `ifdef dma_priority_queue11
      output              rx_databuf_wr_q11;  // Flow Control queue 11
    `endif
    `ifdef dma_priority_queue12
      output              rx_databuf_wr_q12;  // Flow Control queue 12
    `endif
    `ifdef dma_priority_queue13
      output              rx_databuf_wr_q13;  // Flow Control queue 13
    `endif
    `ifdef dma_priority_queue14
      output              rx_databuf_wr_q14;  // Flow Control queue 14
    `endif
    `ifdef dma_priority_queue15
      output              rx_databuf_wr_q15;  // Flow Control queue 15
    `endif
  `endif // gem_ext_fifo_interface

  // Specific outputs to support half duplex flow control
  input halfduplex_flow_control_en;    // Flow control enable

  // ASF comman output error indications
  `ifndef gem_ext_fifo_interface
    `ifdef gem_tx_pkt_buffer
    `endif
  `endif // gem_ext_fifo_interface

  output         asf_trans_to_err;          // Transaction Timeouts indication
  output         asf_protocol_err;          // Protocol error indication
  // ASF and fatal and non-fatal interrupts
  output         asf_int_nonfatal;          // ASF non-fatal interrupt
  output         asf_int_fatal;             // ASF fatal interrupt

  `ifdef gem_has_802p3_br
    // ASF comman output error indications for emac
    `ifndef gem_ext_fifo_interface
      `ifdef gem_tx_pkt_buffer
      `endif // gem_tx_pkt_buffer
    `endif // gem_ext_fifo_interface
    output         emac_asf_trans_to_err;         // Transaction Timeouts indication
    output         emac_asf_protocol_err;         // Protocol error indication
    // ASF and fatal and non-fatal interrupts for emac
    output         emac_asf_int_nonfatal;         // ASF non-fatal interrupt
    output         emac_asf_int_fatal;            // ASF fatal interrupt
  `endif // gem_has_802p3_br

  // Interrupt controller interface.
  output         ethernet_int;       // ethernet mac interrupt signal.
  `ifdef gem_ext_fifo_interface
  `else
    `ifdef dma_priority_queue15
      output        ethernet_int_q15;   // interrupt for queue 15 events
    `endif
    `ifdef dma_priority_queue14
      output        ethernet_int_q14;   // interrupt for queue 14 events
    `endif
    `ifdef dma_priority_queue13
      output        ethernet_int_q13;   // interrupt for queue 13 events
    `endif
    `ifdef dma_priority_queue12
      output        ethernet_int_q12;   // interrupt for queue 12 events
    `endif
    `ifdef dma_priority_queue11
      output        ethernet_int_q11;   // interrupt for queue 11 events
    `endif
    `ifdef dma_priority_queue10
      output        ethernet_int_q10;   // interrupt for queue 10 events
    `endif
    `ifdef dma_priority_queue9
      output        ethernet_int_q9;    // interrupt for queue 9 events
    `endif
    `ifdef dma_priority_queue8
      output        ethernet_int_q8;    // interrupt for queue 8 events
    `endif
    `ifdef dma_priority_queue7
      output        ethernet_int_q7;    // interrupt for queue 7 events
    `endif
    `ifdef dma_priority_queue6
      output        ethernet_int_q6;    // interrupt for queue 6 events
    `endif
    `ifdef dma_priority_queue5
      output        ethernet_int_q5;    // interrupt for queue 5 events
    `endif
    `ifdef dma_priority_queue4
      output        ethernet_int_q4;    // interrupt for queue 4 events
    `endif
    `ifdef dma_priority_queue3
      output        ethernet_int_q3;    // interrupt for queue 3 events
    `endif
    `ifdef dma_priority_queue2
      output        ethernet_int_q2;    // interrupt for queue 2 events
    `endif
    `ifdef dma_priority_queue1
      output        ethernet_int_q1;    // interrupt for queue 1 events
    `endif
  `endif // gem_ext_fifo_interface

  `ifdef gem_has_802p3_br
    output         emac_ethernet_int;  // ethernet mac interrupt signal.
    output         mmsl_int;           // MMSL interrupt pin
  `endif

  `ifdef gem_add_tx_external_fifo_if
   wire   [`gem_emac_bus_width-1:0] tx_r_data_mac;      // output data from the transmit fifo
   wire                             tx_r_sop_mac;       // start of packet indicator.
   wire                             tx_r_eop_mac;       // end of packet indicator.
   wire                       [3:0] tx_r_mod_mac;       // mod indicator
   wire                             tx_r_err_mac;       // packet in error indicator.
   wire                       [3:0] tx_r_queue_mac;     // Queue ID, timed with tx_r_rd
   wire          [`edma_queues-1:0] tx_r_rd_mac;        // request new data from fifo.
   wire                             tx_r_valid_mac;     // new tx data available from fifo.
   wire          [`edma_queues-1:0] tx_r_data_rdy_mac;  // indicates sufficient data
   wire                             tx_r_underflow_mac; // signals tx fifo underrun condition.
   wire                             tx_r_control_mac;   // tx control from in-line FIFO word
  `elsif use_gem_fifo_8b_if
   wire   [`gem_emac_bus_width-1:0] tx_r_data_mac;      // output data from the transmit fifo
   wire                             tx_r_sop_mac;       // start of packet indicator.
   wire                             tx_r_eop_mac;       // end of packet indicator.
   wire                       [3:0] tx_r_mod_mac;       // mod indicator
   wire                             tx_r_err_mac;       // packet in error indicator.
   wire          [`edma_queues-1:0] tx_r_rd_mac;        // request new data from fifo.
   wire                       [3:0] tx_r_queue_mac;     // Queue ID, timed with tx_r_rd
   wire                             tx_r_valid_mac;     // new tx data available from fifo.
   wire          [`edma_queues-1:0] tx_r_data_rdy_mac;  // indicates sufficeint data
   wire                             tx_r_underflow_mac; // signals tx fifo underrun condition.
   wire                             tx_r_control_mac;   // tx control from in-line FIFO word
  `endif


  `ifdef gem_add_rx_external_fifo_if
  `ifdef gem_tsu
   wire                      [77:0] rx_w_timestamp_mac; // valid on rx_w_eop
  `endif
   wire                             rx_w_wr_mac;        // rx write output to the receive fifo.
   wire   [`gem_emac_bus_width-1:0] rx_w_data_mac;      // output data to the receive fifo.

   wire                             rx_w_sop_mac;       // rx start of packet indicator.
   wire                             rx_w_eop_mac;       // rx end of packet indicator.
   wire                       [3:0] rx_w_mod_mac;       // mod indicator
   wire                             rx_w_err_mac;       // rx packet in error indicator.
   wire                      [44:0] rx_w_status_mac;    // rx status written to in-line FIFO word.
   wire                       [3:0] rx_w_queue_mac;     // RX queue valid on EOP
  `endif

  `ifdef gem_has_802p3_br
    `ifdef gem_add_tx_external_fifo_if
      wire   [`gem_emac_bus_width-1:0] emac_tx_r_data_mac;      // output data from the transmit fifo
      wire                             emac_tx_r_sop_mac;       // start of packet indicator.
      wire                             emac_tx_r_eop_mac;       // end of packet indicator.
      wire                       [3:0] emac_tx_r_mod_mac;       // mod indicator
      wire                             emac_tx_r_err_mac;       // packet in error indicator.
      wire                       [3:0] emac_tx_r_queue_mac;     // Queue ID, timed with tx_r_rd
      wire                             emac_tx_r_rd_mac;        // request new data from fifo.
      wire                             emac_tx_r_valid_mac;     // new tx data available from fifo.
      wire                             emac_tx_r_data_rdy_mac;  // indicates sufficient data
      wire                             emac_tx_r_underflow_mac; // signals tx fifo underrun condition.
      wire                             emac_tx_r_control_mac;   // tx control from in-line FIFO word
    `elsif use_gem_fifo_8b_if
      wire   [`gem_emac_bus_width-1:0] emac_tx_r_data_mac;      // output data from the transmit fifo
      wire                             emac_tx_r_sop_mac;       // start of packet indicator.
      wire                             emac_tx_r_eop_mac;       // end of packet indicator.
      wire                       [3:0] emac_tx_r_mod_mac;       // mod indicator
      wire                             emac_tx_r_err_mac;       // packet in error indicator.
      wire                             emac_tx_r_rd_mac;        // request new data from fifo.
      wire                       [3:0] emac_tx_r_queue_mac;     // Queue ID, timed with tx_r_rd
      wire                             emac_tx_r_valid_mac;     // new tx data available from fifo.
      wire                             emac_tx_r_data_rdy_mac;  // indicates sufficeint data
      wire                             emac_tx_r_underflow_mac; // signals tx fifo underrun condition.
      wire                             emac_tx_r_control_mac;   // tx control from in-line FIFO word
    `endif

    `ifdef gem_add_rx_external_fifo_if
      `ifdef gem_tsu
        wire                      [77:0] emac_rx_w_timestamp_mac; // valid on rx_w_eop
      `endif
      wire                             emac_rx_w_wr_mac;        // rx write output to the receive fifo.
      wire   [`gem_emac_bus_width-1:0] emac_rx_w_data_mac;      // output data to the receive fifo.

      wire                             emac_rx_w_sop_mac;       // rx start of packet indicator.
      wire                             emac_rx_w_eop_mac;       // rx end of packet indicator.
      wire                       [3:0] emac_rx_w_mod_mac;       // mod indicator
      wire                             emac_rx_w_err_mac;       // rx packet in error indicator.
      wire                      [44:0] emac_rx_w_status_mac;    // rx status written to in-line FIFO word.
      wire                       [3:0] emac_rx_w_queue_mac;     // RX queue valid on EOP
    `endif // gem_add_rx_external_fifo_if
  `endif //gem_has_802p3_br


   `ifndef gem_no_pcs
     // Optional PCS signals tie-offs
     wire  [19:0]    tx_group_from_pcs;
     wire  [19:0]    rx_group_to_pcs;
   `endif

   `ifdef gem_add_rx_external_fifo_if
     `ifdef num_spec_add_filters
       wire    [`num_spec_add_filters:0] add_match_vec_pad; // indicates specific address match status
       assign  add_match_vec = add_match_vec_pad[`num_spec_add_filters:1];
     `endif
   `endif

   `ifdef gem_add_rx_external_fifo_if
     `ifdef gem_has_802p3_br
       `ifdef num_spec_add_filters
         wire    [`num_spec_add_filters:0] emac_add_match_vec_pad; // indicates specific address match status
         assign  emac_add_match_vec = emac_add_match_vec_pad[`num_spec_add_filters:1];
       `endif
     `endif
   `endif

   wire [15:0]  ethernet_int_bus;      // ethernet mac interrupt signal.
   wire [p_edma_queues-1:0]  rx_databuf_wr_q;

   wire [15:0] paddr_pad;
   `ifdef use_gem_fifo_8b_if
     wire        enable_transmit;
     wire        enable_receive;
     wire  [3:0] rx_w_queue;
   `endif
   
   wire loopback_local;
   
  gem_ss #(
    .grouped_params(grouped_params),
    .p_edma_emac_tx_pbuf_reduncy(p_edma_emac_tx_pbuf_reduncy),
    .p_edma_emac_rx_pbuf_reduncy(p_edma_emac_rx_pbuf_reduncy)
  ) i_gem_ss (

   // system interface (resets)
   .n_txreset (n_txreset),
   .n_rxreset (n_rxreset),

   // Internal loopback signals
   .loopback_local (loopback_local),
   `ifdef gem_int_loopback
     .n_ntxreset   (n_ntxreset),
     .n_tx_clk     (n_tx_clk),
   `else
     `ifdef gem_use_rgmii
       .n_tx_clk   (n_tx_clk),
       .n_ntxreset (n_ntxreset),
     `else
       .n_ntxreset (1'b0),
       .n_tx_clk   (1'b0),
     `endif // gem_use_rgmii
   `endif // gem_int_loopback

   .tx_clk (tx_clk),
   .rx_clk (rx_clk),

   `ifdef gem_use_rgmii
     .tx_clk_sig       (tx_clk_sig),
     .n_nrxreset       (n_nrxreset),
     .n_rx_clk         (n_rx_clk),
     .rgmii_txd        (rgmii_txd),
     .rgmii_tx_ctl     (rgmii_tx_ctl),
     .rgmii_rxd        (rgmii_rxd),
     .rgmii_rx_ctl     (rgmii_rx_ctl),
     .rgmii_link_status(rgmii_link_status),
     .rgmii_speed      (rgmii_speed),
     .rgmii_duplex_out (rgmii_duplex_out),
     .txd              (),
     .tx_en            (),
     .rxd              (8'h00),
     .rx_dv            (1'b0),
   `else
     .tx_clk_sig       (1'b0),
     .n_nrxreset       (1'b0),
     .n_rx_clk         (1'b0),
     .rgmii_txd        (),
     .rgmii_tx_ctl     (),
     .rgmii_rxd        (4'h0),
     .rgmii_rx_ctl     (1'b0),
     .rgmii_link_status(),
     .rgmii_speed      (),
     .rgmii_duplex_out (),
     .txd              (txd),
     .tx_en            (tx_en),
     .rxd              (rxd),
     .rx_dv            (rx_dv),
   `endif //gem_use_rgmii
   
   .tx_er              (tx_er),
   .rx_er              (rx_er),
   
   `ifdef gem_include_rmii
     // 10/100 MII select
     .mii_select       (mii_select),
     // rmii interface signals
     .n_ref_reset      (n_ref_reset),
     .ref_clk          (ref_clk),
     .rmii_rx_clk      (rmii_rx_clk),
     .rmii_tx_clk      (rmii_tx_clk),
     .rmii_txd         (rmii_txd),
     .rmii_tx_en       (rmii_tx_en),
     .rmii_rxd         (rmii_rxd),
     .rmii_rx_er       (rmii_rx_er),
     .rmii_crs_dv      (rmii_crs_dv),
   `else
     // 10/100 MII select
     .mii_select       (1'b0),
     // rmii interface signals
     .n_ref_reset      (1'b0),
     .ref_clk          (1'b0),
     .rmii_rx_clk      (),
     .rmii_tx_clk      (),
     .rmii_txd         (),
     .rmii_tx_en       (),
     .rmii_rxd         (2'b00),
     .rmii_rx_er       (1'b0),
     .rmii_crs_dv      (1'b0),
   `endif //gem_include_rmii

   // ten bit interface signals

   `ifdef gem_no_pcs
     .gtx_clk           (1'b0),
     .n_gtxreset        (1'b0),
     .gtx20_clk         (1'b0),
     .n_gtx20reset      (1'b0),
     .rbc0              (1'b0),
     .rbc1              (1'b0),
     .n_rbc0reset       (1'b0),
     .n_rbc1reset       (1'b0),
     .pcs_rx_clk        (1'b0),
     .n_pcs_rxreset     (1'b0),
     .pcs_cal_bypass    (1'b0),
     .pcs_cgalign_bypass(1'b0),
     .pcs_rx10_clk      (1'b0),
     .n_pcs_rx10reset   (1'b0),
     .tx_group          (),
     .rx_group          (20'd0),
     .ewrap             (),
     .en_cdet           (),
     .signal_detect     (1'b0),
   `else // if not gem_no_pcs
     .gtx_clk           (gtx_clk),
     .n_gtxreset        (n_gtxreset),
     `ifdef gem_pcs_20b_if
       .gtx20_clk         (gtx20_clk),
       .n_gtx20reset      (n_gtx20reset),
     `else
       .gtx20_clk         (1'b0),
       .n_gtx20reset      (1'b0),
     `endif //gem_pcs_20b_if
     
     `ifdef gem_pcs_legacy_if
       .rbc0              (rbc0),
       .rbc1              (rbc1),
       .n_rbc0reset       (n_rbc0reset),
       .n_rbc1reset       (n_rbc1reset),
       .pcs_rx_clk        (rbc1),
       .n_pcs_rxreset     (n_rbc1reset),
       .pcs_cal_bypass    (1'b0),
       .pcs_cgalign_bypass(1'b0),
     `else 
       .rbc0              (1'b0),
       .rbc1              (1'b0),
       .n_rbc0reset       (1'b0),
       .n_rbc1reset       (1'b0),
       .pcs_rx_clk        (pcs_rx_clk),
       .n_pcs_rxreset     (n_pcs_rxreset),
       .pcs_cal_bypass    (pcs_cal_bypass),
       .pcs_cgalign_bypass(pcs_cgalign_bypass),
     `endif //gem_pcs_legacy_if
     
     `ifdef gem_pcs_10b_if
       .pcs_rx10_clk      (pcs_rx10_clk),
       .n_pcs_rx10reset   (n_pcs_rx10reset),
     `else
       .pcs_rx10_clk      (1'b0),
       .n_pcs_rx10reset   (1'b0),
     `endif //gem_pcs_10b_if
     .tx_group          (tx_group_from_pcs),
     .rx_group          (rx_group_to_pcs),
     .ewrap             (ewrap),
     .en_cdet           (en_cdet),
     .signal_detect     (signal_detect),
   `endif // gem_no_pcs

   // other ethernet signals.
   .col               (col),
   .crs               (crs),
   .mdc               (mdc),
   .mdio_in           (mdio_in),
   .mdio_out          (mdio_out),
   .mdio_en           (mdio_en),
   .loopback          (loopback),
   .half_duplex       (half_duplex),
   .speed_mode        (speed_mode),
   .ext_interrupt_in  (ext_interrupt_in),
   .tx_pause          (tx_pause),
   .tx_pause_zero     (tx_pause_zero),
   .tx_pfc_sel        (tx_pfc_sel),
   .tx_pfc_pause      (tx_pfc_pause),
   .tx_pfc_pause_zero (tx_pfc_pause_zero),
   .pfc_negotiate     (pfc_negotiate),
   .rx_pfc_paused     (rx_pfc_paused),
   .wol               (wol),

   // external filter interface
   .ext_match1        (ext_match1),
   .ext_match2        (ext_match2),
   .ext_match3        (ext_match3),
   .ext_match4        (ext_match4),
   .ext_da            (ext_da),
   .ext_da_stb        (ext_da_stb),
   .ext_sa            (ext_sa),
   .ext_sa_stb        (ext_sa_stb),
   .ext_type          (ext_type),
   .ext_type_stb      (ext_type_stb),
   .ext_ip_sa         (ext_ip_sa),
   .ext_ip_sa_stb     (ext_ip_sa_stb),
   .ext_ip_da         (ext_ip_da),
   .ext_ip_da_stb     (ext_ip_da_stb),
   .ext_source_port   (ext_source_port),
   .ext_sp_stb        (ext_sp_stb),
   .ext_dest_port     (ext_dest_port),
   .ext_dp_stb        (ext_dp_stb),
   .ext_ipv6          (ext_ipv6),

   // Stacked VLAN tag support
   .ext_vlan_tag1     (ext_vlan_tag1),
   .ext_vlan_tag1_stb (ext_vlan_tag1_stb),
   .ext_vlan_tag2     (ext_vlan_tag2),
   .ext_vlan_tag2_stb (ext_vlan_tag2_stb),

   // TSU timer
   `ifdef gem_tsu
     // tsu clock
     `ifdef gem_tsu_clk
       .tsu_clk        (tsu_clk),
       .n_tsureset     (n_tsureset),
     `else
       .tsu_clk        (pclk),
       .n_tsureset     (n_preset),
     `endif // gem_tsu_clk

     .gem_tsu_inc_ctrl (gem_tsu_inc_ctrl),
     .gem_tsu_ms       (gem_tsu_ms),
     .tsu_timer_cnt    (tsu_timer_cnt),
    
       .tsu_timer_cnt_par(),
     .tsu_timer_cmp_val(tsu_timer_cmp_val),
     
     `ifdef gem_ext_tsu_timer
       .ext_tsu_timer       (ext_tsu_timer),
         .ext_tsu_timer_par (12'h000),
     `else
      .ext_tsu_timer        ({94{1'b0}}),
      .ext_tsu_timer_par    (12'h000),
    `endif //gem_ext_tsu_timer
    
   `else
     .tsu_clk          (pclk),     // Not used
     .n_tsureset       (n_preset),
     .gem_tsu_inc_ctrl (2'b00),
     .gem_tsu_ms       (1'b0),
     .tsu_timer_cnt    (),
     .tsu_timer_cnt_par(),
     .tsu_timer_cmp_val(),
     .ext_tsu_timer    ({94{1'b0}}),
     .ext_tsu_timer_par(12'h000),
   `endif //gem_tsu

   // precision time protocol signals for IEEE 1588 support
   .sof_tx            (sof_tx),
   .sync_frame_tx     (sync_frame_tx),
   .delay_req_tx      (delay_req_tx),
   .pdelay_req_tx     (pdelay_req_tx),
   .pdelay_resp_tx    (pdelay_resp_tx),
   .sof_rx            (sof_rx),
   .sync_frame_rx     (sync_frame_rx),
   .delay_req_rx      (delay_req_rx),
   .pdelay_req_rx     (pdelay_req_rx),
   .pdelay_resp_rx    (pdelay_resp_rx),

   // amba apb interface signals.
   .pclk              (pclk),
   .n_preset          (n_preset),
   .paddr             (paddr_pad),
   .prdata            (prdata),
   .pwdata            (pwdata),
   .pwrite            (pwrite),
   .penable           (penable),
   .psel              (psel),
   .perr              (perr),

     .paddr_par       (2'h0),
     .prdata_par      (),
     .pwdata_par      (4'h0),

   // AHB and/or Exposed FIFO interface is available

   `ifdef gem_add_tx_external_fifo_if
     // low latency tx interface uses external fifo tx port
     // pmac connections (default when no br)
     .tx_r_data           (tx_r_data_mac),
     .tx_r_mod            (tx_r_mod_mac),
     .tx_r_sop            (tx_r_sop_mac),
     .tx_r_eop            (tx_r_eop_mac),
     .tx_r_err            (tx_r_err_mac),
     .tx_r_valid          (tx_r_valid_mac),
     .tx_r_data_rdy       (tx_r_data_rdy_mac),
     .tx_r_underflow      (tx_r_underflow_mac),
     .tx_r_rd             (tx_r_rd_mac),
     .tx_r_queue          (tx_r_queue_mac),
     .tx_r_flushed        (tx_r_flushed),
     .tx_r_control        (tx_r_control_mac),
     .tx_r_status         (tx_r_status),
     .tx_r_frame_size_vld (tx_r_frame_size_vld),
     .tx_r_frame_size     (tx_r_frame_size),
     `ifdef gem_tsu
       .tx_r_timestamp    (tx_r_timestamp),
     `else
       .tx_r_timestamp    (),
     `endif //gem_tsu
     .dma_tx_status_tog   (dma_tx_status_tog),
     .dma_tx_end_tog      (dma_tx_end_tog),
   `else
     // low latency tx interface uses external fifo tx port
     .tx_r_data           ({`gem_emac_bus_width{1'b0}}),
     .tx_r_mod            (4'h0),
     .tx_r_sop            (1'b0),
     .tx_r_eop            (1'b0),
     .tx_r_err            (1'b0),
     .tx_r_valid          (1'b0),
     .tx_r_data_rdy       ({`edma_queues{1'b0}}),
     .tx_r_underflow      (1'b0),
     .tx_r_rd             (),
     .tx_r_queue          (),
     .tx_r_flushed        (1'b0),
     .tx_r_control        (1'b0),
     .tx_r_status         (),
     .tx_r_frame_size_vld ({`edma_queues{1'b1}}),
     .tx_r_frame_size     ({`edma_queues*14{1'b0}}),
     .tx_r_timestamp      (),
     .dma_tx_status_tog   (1'b0),
     .dma_tx_end_tog      (),
   `endif //gem_add_tx_external_fifo_if

   // external fifo interface.
   `ifdef gem_add_rx_external_fifo_if
     .rx_w_wr        (rx_w_wr_mac),
     .rx_w_data      (rx_w_data_mac),
     .rx_w_mod       (rx_w_mod_mac),
     .rx_w_sop       (rx_w_sop_mac),
     .rx_w_eop       (rx_w_eop_mac),
     .rx_w_err       (rx_w_err_mac),
     .rx_w_flush     (rx_w_flush),
     .rx_w_status    (rx_w_status_mac),
     .rx_w_queue     (rx_w_queue_mac),
     .rx_w_overflow  (rx_w_overflow),
     `ifdef num_spec_add_filters
       .add_match_vec (add_match_vec_pad),
     `else
       .add_match_vec (),
     `endif //num_spec_add_filters

     `ifdef gem_tsu
       .rx_w_timestamp (rx_w_timestamp_mac),
     `else
       .rx_w_timestamp (),
     `endif //gem_tsu
   `else
     .rx_w_wr         (),
     .rx_w_data       (),
     .rx_w_mod        (),
     .rx_w_sop        (),
     .rx_w_eop        (),
     .rx_w_err        (),
     .rx_w_flush      (),
     .rx_w_status     (),
     .rx_w_queue      (),
     .add_match_vec   (),
     .rx_w_overflow   (1'b0),
     .rx_w_timestamp  (),
   `endif // gem_add_rx_external_fifo_if

   `ifdef gem_has_802p3_br
     `ifdef gem_add_tx_external_fifo_if
       // low latency tx interface uses external fifo tx port
       // emac connections
       .emac_tx_r_data           (emac_tx_r_data_mac),
       .emac_tx_r_mod            (emac_tx_r_mod_mac),
       .emac_tx_r_sop            (emac_tx_r_sop_mac),
       .emac_tx_r_eop            (emac_tx_r_eop_mac),
       .emac_tx_r_err            (emac_tx_r_err_mac),
       .emac_tx_r_valid          (emac_tx_r_valid_mac),
       .emac_tx_r_data_rdy       (emac_tx_r_data_rdy_mac),
       .emac_tx_r_underflow      (emac_tx_r_underflow_mac),
       .emac_tx_r_rd             (emac_tx_r_rd_mac),
       .emac_tx_r_queue          (emac_tx_r_queue_mac),
       .emac_tx_r_flushed        (emac_tx_r_flushed),
       .emac_tx_r_control        (emac_tx_r_control_mac),
       .emac_tx_r_status         (emac_tx_r_status),
       .emac_tx_r_frame_size_vld (emac_tx_r_frame_size_vld),
       .emac_tx_r_frame_size     (emac_tx_r_frame_size),
       `ifdef gem_tsu
         .emac_tx_r_timestamp    (emac_tx_r_timestamp),
       `else
         .emac_tx_r_timestamp    (),
       `endif //gem_tsu
       .emac_dma_tx_status_tog   (emac_dma_tx_status_tog),
       .emac_dma_tx_end_tog      (emac_dma_tx_end_tog),
     `else
       // low latency tx interface uses external fifo tx port
       .emac_tx_r_data           ({`gem_emac_bus_width{1'b0}}),
       .emac_tx_r_mod            (4'h0),
       .emac_tx_r_sop            (1'b0),
       .emac_tx_r_eop            (1'b0),
       .emac_tx_r_err            (1'b0),
       .emac_tx_r_valid          (1'b0),
       .emac_tx_r_data_rdy       (1'b0),
       .emac_tx_r_underflow      (1'b0),
       .emac_tx_r_rd             (),
       .emac_tx_r_queue          (),
       .emac_tx_r_flushed        (1'b0),
       .emac_tx_r_control        (1'b0),
       .emac_tx_r_status         (),
       .emac_tx_r_frame_size_vld (1'b1),
       .emac_tx_r_frame_size     (14'd0),
       .emac_tx_r_timestamp      (),
       .emac_dma_tx_status_tog   (1'b0),
       .emac_dma_tx_end_tog      (),
     `endif //gem_add_tx_external_fifo_if

     `ifdef gem_add_rx_external_fifo_if
       // external fifo interface.
       // emac connections
       .emac_rx_w_wr        (emac_rx_w_wr_mac),
       .emac_rx_w_data      (emac_rx_w_data_mac),
       .emac_rx_w_mod       (emac_rx_w_mod_mac),
       .emac_rx_w_sop       (emac_rx_w_sop_mac),
       .emac_rx_w_eop       (emac_rx_w_eop_mac),
       .emac_rx_w_err       (emac_rx_w_err_mac),
       .emac_rx_w_flush     (emac_rx_w_flush),
       .emac_rx_w_status    (emac_rx_w_status_mac),
       .emac_rx_w_queue     (emac_rx_w_queue_mac),
       .emac_rx_w_overflow  (emac_rx_w_overflow),
       `ifdef num_spec_add_filters
         .emac_add_match_vec (emac_add_match_vec_pad),
       `else
         .emac_add_match_vec (),
       `endif //num_spec_add_filters

       `ifdef gem_tsu
         .emac_rx_w_timestamp (emac_rx_w_timestamp_mac),
       `else
         .emac_rx_w_timestamp (),
       `endif // gem_tsu
     `else
       .emac_rx_w_wr         (),
       .emac_rx_w_data       (),
       .emac_rx_w_mod        (),
       .emac_rx_w_sop        (),
       .emac_rx_w_eop        (),
       .emac_rx_w_err        (),
       .emac_rx_w_flush      (),
       .emac_rx_w_status     (),
       .emac_rx_w_queue      (),
       .emac_add_match_vec   (),
       .emac_rx_w_overflow   (1'b0),
       .emac_rx_w_timestamp  (),
     `endif   // gem_add_rx_external_fifo_if
   `else
     .emac_tx_r_data           ({`gem_emac_bus_width{1'b0}}),
     .emac_tx_r_mod            (4'h0),
     .emac_tx_r_sop            (1'b0),
     .emac_tx_r_eop            (1'b0),
     .emac_tx_r_err            (1'b0),
     .emac_tx_r_valid          (1'b0),
     .emac_tx_r_data_rdy       (1'b0),
     .emac_tx_r_underflow      (1'b0),
     .emac_tx_r_rd             (),
     .emac_tx_r_queue          (),
     .emac_tx_r_flushed        (1'b0),
     .emac_tx_r_control        (1'b0),
     .emac_tx_r_status         (),
     .emac_tx_r_frame_size_vld (1'b1),
     .emac_tx_r_frame_size     (14'd0),
     .emac_tx_r_timestamp      (),
     .emac_dma_tx_status_tog   (1'b0),
     .emac_dma_tx_end_tog      (),
     .emac_rx_w_wr             (),
     .emac_rx_w_data           (),
     .emac_rx_w_mod            (),
     .emac_rx_w_sop            (),
     .emac_rx_w_eop            (),
     .emac_rx_w_err            (),
     .emac_rx_w_flush          (),
     .emac_rx_w_status         (),
     .emac_rx_w_queue          (),
     .emac_add_match_vec       (),
     .emac_rx_w_overflow       (1'b0),
     .emac_rx_w_timestamp      (),
   `endif //gem_has_802p3_br

   `ifdef  gem_ext_fifo_interface
     // AXI interface signals
     .aclk     (1'b0),
     .n_areset (1'b0),
     // Write Address Channel
     .awid     (),
     .awaddr   (),
     .awaddr_par(),
     .awlen    (),
     .awsize   (),
     .awburst  (),
     .awlock   (),
     .awcache  (),
     .awprot   (),
     .awvalid  (),
     .awqos    (),
     .awready  (1'b0),
     // Write Data Channel
     .wdata    (),
     .wdata_par(),
     .wstrb    (),
     .wlast    (),
     .wid      (),
     .wready   (1'b0),
     .wvalid   (),
     // Response Channel
     .bresp    (2'b00),
     .bid      (4'h0),
     .bvalid   (1'b0),
     .bready   (),
     // Read Address Channel
     .arid     (),
     .araddr   (),
     .araddr_par(),
     .arlen    (),
     .arsize   (),
     .arburst  (),
     .arlock   (),
     .arcache  (),
     .arprot   (),
     .arvalid  (),
     .arqos    (),
     .arready  (1'b0),
     // Read Data Channel
     .rdata    ({`edma_bus_width{1'b0}}),
     .rdata_par({(`edma_bus_width/8){1'b0}}),
     .rresp    (2'b00),
     .rlast    (1'b0),
     .rvalid   (1'b0),
     .rready   (),
     .rid      (4'h0),

     // AHB interface signals.
     .hclk                 (1'b0),
     .n_hreset             (1'b0),
     .hgrant               (1'b0),
     .hready               (1'b0),
     .hresp                (2'b00),
     .hrdata               ({`edma_bus_width{1'b0}}),
     .hbusreq              (),
     .hlock                (),
     .haddr                (),
     .htrans               (),
     .hwrite               (),
     .hsize                (),
     .hburst               (),
     .hprot                (),
     .hwdata               (),
     .trigger_dma_tx_start (1'b0),

     .tx_sram_wea          (),
     .tx_sram_ena          (),
     .tx_sram_addra        (),
     .tx_sram_dia          (),
     .tx_sram_doa          ({p_edma_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
     .tx_sram_web          (),
     .tx_sram_enb          (),
     .tx_sram_addrb        (),
     .tx_sram_dob          ({p_edma_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
     .rx_sram_wea          (),
     .rx_sram_ena          (),
     .rx_sram_addra        (),
     .rx_sram_dia          (),
     .rx_sram_doa          ({p_edma_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),
     .rx_sram_web          (),
     .rx_sram_enb          (),
     .rx_sram_addrb        (),
     .rx_sram_dob          ({p_edma_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),

     .emac_tx_sram_wea     (),
     .emac_tx_sram_ena     (),
     .emac_tx_sram_addra   (),
     .emac_tx_sram_dia     (),
     .emac_tx_sram_doa     ({p_edma_emac_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
     .emac_tx_sram_web     (),
     .emac_tx_sram_enb     (),
     .emac_tx_sram_addrb   (),
     .emac_tx_sram_dob     ({p_edma_emac_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
     .emac_rx_sram_wea     (),
     .emac_rx_sram_ena     (),
     .emac_rx_sram_addra   (),
     .emac_rx_sram_dia     (),
     .emac_rx_sram_doa     ({p_edma_emac_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),
     .emac_rx_sram_web     (),
     .emac_rx_sram_enb     (),
     .emac_rx_sram_addrb   (),
     .emac_rx_sram_dob     ({p_edma_emac_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),


   `else
     `ifdef gem_tx_pkt_buffer
       .trigger_dma_tx_start (trigger_dma_tx_start),
     `else
       .trigger_dma_tx_start (1'b0),
     `endif

     `ifdef gem_axi
       // AXI interface signals
       .aclk    (aclk),
       .n_areset(n_areset),
       // Write Address Channel
       .awid    (awid),
       .awaddr  (awaddr),
       .awlen   (awlen),
       .awsize  (awsize),
       .awburst (awburst),
       .awlock  (awlock),
       .awcache (awcache),
       .awprot  (awprot),
       .awvalid (awvalid),
       .awqos   (awqos),
       .awready (awready),
       // Write Data Channel
       .wdata   (wdata),
       .wstrb   (wstrb),
       .wlast   (wlast),
       .wid     (wid),
       .wready  (wready),
       .wvalid  (wvalid),
       // Response Channel
       .bid     (bid),
       .bresp   (bresp),
       .bvalid  (bvalid),
       .bready  (bready),
       // Read Address Channel
       .arid    (arid),
       .araddr  (araddr),
       .arlen   (arlen),
       .arsize  (arsize),
       .arburst (arburst),
       .arlock  (arlock),
       .arcache (arcache),
       .arprot  (arprot),
       .arvalid (arvalid),
       .arqos   (arqos),
       .arready (arready),
       // Read Data Channel
       .rdata   (rdata),
       .rresp   (rresp),
       .rlast   (rlast),
       .rvalid  (rvalid),
       .rready  (rready),
       .rid     (rid),
         .awaddr_par  (),
         .wdata_par   (),
         .araddr_par  (),
         .rdata_par   ({(`edma_bus_width/8){1'b0}}),
       // AHB interface signals.
       .hclk    (1'b0),
       .n_hreset(1'b0),
       .hgrant  (1'b0),
       .hready  (1'b0),
       .hresp   (2'b00),
       .hrdata  ({`edma_bus_width{1'b0}}),
       .hbusreq (),
       .hlock   (),
       .haddr   (),
       .htrans  (),
       .hwrite  (),
       .hsize   (),
       .hburst  (),
       .hprot   (),
       .hwdata  (),
     `else
       // AXI interface signals
       .aclk    (1'b0),
       .n_areset(1'b0),
       // Write Address Channel
       .awid    (),
       .awaddr  (),
       .awaddr_par(),
       .awlen   (),
       .awsize  (),
       .awburst (),
       .awlock  (),
       .awcache (),
       .awprot  (),
       .awvalid (),
       .awqos   (),
       .awready (1'b0),
       // Write Data Channel
       .wdata   (),
       .wdata_par   (),
       .wstrb   (),
       .wlast   (),
       .wid     (),
       .wready  (1'b0),
       .wvalid  (),
       // Response Channel
       .bid     (4'b0000),
       .bresp   (2'b00),
       .bvalid  (1'b0),
       .bready  (),
       // Read Address Channel
       .arid    (),
       .araddr  (),
       .araddr_par(),
       .arlen   (),
       .arsize  (),
       .arburst (),
       .arlock  (),
       .arcache (),
       .arprot  (),
       .arvalid (),
       .arqos   (),
       .arready (1'b0),
       // Read Data Channel
       .rdata    ({`edma_bus_width{1'b0}}),
       .rdata_par({(`edma_bus_width/8){1'b0}}),
       .rresp   (2'b00),
       .rlast   (1'b0),
       .rvalid  (1'b0),
       .rready  (),
       .rid     (4'h0),

       // AHB interface signals.
       .hclk    (hclk),
       .n_hreset(n_hreset),
       .hgrant  (hgrant),
       .hready  (hready),
       .hresp   (hresp),
       .hrdata  (hrdata),
       .hbusreq (hbusreq),
       .hlock   (hlock),
       .haddr   (haddr),
       .htrans  (htrans),
       .hwrite  (hwrite),
       .hsize   (hsize),
       .hburst  (hburst),
       .hprot   (hprot),
       .hwdata  (hwdata),
     `endif // gem_axi

     // Tie-off SRAM connections if not packet buffer
     `ifndef gem_tx_pkt_buffer
       .tx_sram_wea        (),
       .tx_sram_ena        (),
       .tx_sram_addra      (),
       .tx_sram_dia        (),
       .tx_sram_doa        ({p_edma_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
       .tx_sram_web        (),
       .tx_sram_enb        (),
       .tx_sram_addrb      (),
       .tx_sram_dob        ({p_edma_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
       .rx_sram_wea        (),
       .rx_sram_ena        (),
       .rx_sram_addra      (),
       .rx_sram_dia        (),
       .rx_sram_doa        ({p_edma_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),
       .rx_sram_web        (),
       .rx_sram_enb        (),
       .rx_sram_addrb      (),
       .rx_sram_dob        ({p_edma_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),
       .emac_tx_sram_wea   (),
       .emac_tx_sram_ena   (),
       .emac_tx_sram_addra (),
       .emac_tx_sram_dia   (),
       .emac_tx_sram_doa   ({p_edma_emac_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
       .emac_tx_sram_web   (),
       .emac_tx_sram_enb   (),
       .emac_tx_sram_addrb (),
       .emac_tx_sram_dob   ({p_edma_emac_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
       .emac_rx_sram_wea   (),
       .emac_rx_sram_ena   (),
       .emac_rx_sram_addra (),
       .emac_rx_sram_dia   (),
       .emac_rx_sram_doa   ({p_edma_emac_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),
       .emac_rx_sram_web   (),
       .emac_rx_sram_enb   (),
       .emac_rx_sram_addrb (),
       .emac_rx_sram_dob   ({p_edma_emac_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),
     `else
       `ifdef gem_spram
         // Port A is used as a R/W port
         .tx_sram_wea   (txspram_we),
         .tx_sram_ena   (txspram_en),
         .tx_sram_addra (txspram_addr),
         .tx_sram_dia   (txspram_di),
         .tx_sram_doa   (txspram_do),
         .rx_sram_wea   (rxspram_we),
         .rx_sram_ena   (rxspram_en),
         .rx_sram_addra (rxspram_addr),
         .rx_sram_dia   (rxspram_di),
         .rx_sram_doa   (rxspram_do),

         // Port B outputs not used but mirror the read data
         .tx_sram_web   (),
         .tx_sram_enb   (),
         .tx_sram_addrb (),
         .tx_sram_dob   (txspram_do),
         .rx_sram_web   (),
         .rx_sram_enb   (),
         .rx_sram_addrb (),
         .rx_sram_dob   (rxspram_do),
       `else
         // Port A is used as a write port
         .tx_sram_wea   (txdpram_wea),
         .tx_sram_ena   (txdpram_ena),
         .tx_sram_addra (txdpram_addra),
         .tx_sram_dia   (txdpram_dia),
         .tx_sram_doa   ({p_edma_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
         .rx_sram_wea   (rxdpram_wea),
         .rx_sram_ena   (rxdpram_ena),
         .rx_sram_addra (rxdpram_addra),
         .rx_sram_dia   (rxdpram_dia),
         .rx_sram_doa   ({p_edma_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),

         // Port B is used as a read port
         .tx_sram_web   (txdpram_web),
         .tx_sram_enb   (txdpram_enb),
         .tx_sram_addrb (txdpram_addrb),
         .tx_sram_dob   (txdpram_dob),
         .rx_sram_web   (rxdpram_web),
         .rx_sram_enb   (rxdpram_enb),
         .rx_sram_addrb (rxdpram_addrb),
         .rx_sram_dob   (rxdpram_dob),
       `endif // gem_spram

       // Similarly for eMAC
       `ifdef gem_has_802p3_br
         `ifdef gem_spram
           // Port A is used as a R/W port
           .emac_tx_sram_wea   (emac_txspram_we),
           .emac_tx_sram_ena   (emac_txspram_en),
           .emac_tx_sram_addra (emac_txspram_addr),
           .emac_tx_sram_dia   (emac_txspram_di),
           .emac_tx_sram_doa   (emac_txspram_do),
           .emac_rx_sram_wea   (emac_rxspram_we),
           .emac_rx_sram_ena   (emac_rxspram_en),
           .emac_rx_sram_addra (emac_rxspram_addr),
           .emac_rx_sram_dia   (emac_rxspram_di),
           .emac_rx_sram_doa   (emac_rxspram_do),

           // Port B is unused.
           .emac_tx_sram_web   (),
           .emac_tx_sram_enb   (),
           .emac_tx_sram_addrb (),
           .emac_tx_sram_dob   (emac_txspram_do),
           .emac_rx_sram_web   (),
           .emac_rx_sram_enb   (),
           .emac_rx_sram_addrb (),
           .emac_rx_sram_dob   (emac_rxspram_do),
         `else
           // Port A is used as a write port
           .emac_tx_sram_wea   (emac_txdpram_wea),
           .emac_tx_sram_ena   (emac_txdpram_ena),
           .emac_tx_sram_addra (emac_txdpram_addra),
           .emac_tx_sram_dia   (emac_txdpram_dia),
           .emac_tx_sram_doa   ({p_edma_emac_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
           .emac_rx_sram_wea   (emac_rxdpram_wea),
           .emac_rx_sram_ena   (emac_rxdpram_ena),
           .emac_rx_sram_addra (emac_rxdpram_addra),
           .emac_rx_sram_dia   (emac_rxdpram_dia),
           .emac_rx_sram_doa   ({p_edma_emac_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),

           // Port B is used as a read port
           .emac_tx_sram_web   (emac_txdpram_web),
           .emac_tx_sram_enb   (emac_txdpram_enb),
           .emac_tx_sram_addrb (emac_txdpram_addrb),
           .emac_tx_sram_dob   (emac_txdpram_dob),
           .emac_rx_sram_web   (emac_rxdpram_web),
           .emac_rx_sram_enb   (emac_rxdpram_enb),
           .emac_rx_sram_addrb (emac_rxdpram_addrb),
           .emac_rx_sram_dob   (emac_rxdpram_dob),
         `endif // gem_spram
       `else
         .emac_tx_sram_wea     (),
         .emac_tx_sram_ena     (),
         .emac_tx_sram_addra   (),
         .emac_tx_sram_dia     (),
         .emac_tx_sram_doa     ({p_edma_emac_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
         .emac_tx_sram_web     (),
         .emac_tx_sram_enb     (),
         .emac_tx_sram_addrb   (),
         .emac_tx_sram_dob     ({p_edma_emac_tx_pbuf_reduncy+`gem_tx_pbuf_data{1'b0}}),
         .emac_rx_sram_wea     (),
         .emac_rx_sram_ena     (),
         .emac_rx_sram_addra   (),
         .emac_rx_sram_dia     (),
         .emac_rx_sram_doa     ({p_edma_emac_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),
         .emac_rx_sram_web     (),
         .emac_rx_sram_enb     (),
         .emac_rx_sram_addrb   (),
         .emac_rx_sram_dob     ({p_edma_emac_rx_pbuf_reduncy+`gem_rx_pbuf_data{1'b0}}),
       `endif //gem_has_802p3_br
     `endif // gem_tx_pkt_buffer
   `endif //gem_ext_fifo_interface

   // DMA bus width indication to external controller or FIFO
   .dma_bus_width   (dma_bus_width),
   `ifdef use_gem_fifo_8b_if
     .enable_transmit (enable_transmit),
     .enable_receive  (enable_receive),
   `else
     .enable_transmit (),
     .enable_receive  (),
   `endif

   // User I/O interface
   `ifdef gem_user_io
     .user_out (user_out),
     .user_in  (user_in),
   `else
     .user_out (),
     .user_in  (1'b0),
   `endif // gem_user_io

   // Specific outputs to support Priority Queues
   .rx_databuf_wr_q    (rx_databuf_wr_q),
   .ethernet_int_bus   (ethernet_int_bus),

   `ifdef gem_has_802p3_br
     .emac_ethernet_int  (emac_ethernet_int),
     .mmsl_int           (mmsl_int),
   `else
     .emac_ethernet_int  (),
     .mmsl_int           (),
   `endif

   `ifdef edma_tx_pkt_buffer
       .asf_sram_corr_err  (),
     
       .asf_sram_uncorr_err(),
   `else
     .asf_sram_corr_err  (),
     .asf_sram_uncorr_err(),
   `endif
   
     .asf_dap_err        (),
   
     .asf_csr_err        (),
   
     .asf_integrity_err  (),
   
   .asf_trans_to_err   (asf_trans_to_err),
   .asf_protocol_err   (asf_protocol_err),
   .asf_int_nonfatal   (asf_int_nonfatal),
   .asf_int_fatal      (asf_int_fatal),

   `ifdef gem_has_802p3_br
     `ifdef edma_tx_pkt_buffer
         .emac_asf_sram_corr_err   (),
       
         .emac_asf_sram_uncorr_err (),
     `else
       .emac_asf_sram_corr_err   (),
       .emac_asf_sram_uncorr_err (),
     `endif // gem_tx_pkt_buffer
     
       .emac_asf_dap_err         (),
     
       .emac_asf_csr_err         (),
     
       .emac_asf_integrity_err   (),
     .emac_asf_trans_to_err    (emac_asf_trans_to_err),
     .emac_asf_protocol_err    (emac_asf_protocol_err),
     .emac_asf_int_nonfatal    (emac_asf_int_nonfatal),
     .emac_asf_int_fatal       (emac_asf_int_fatal),
   `else
     .emac_asf_sram_corr_err   (),
     .emac_asf_sram_uncorr_err (),
     .emac_asf_dap_err         (),
     .emac_asf_csr_err         (),
     .emac_asf_trans_to_err    (),
     .emac_asf_protocol_err    (),
     .emac_asf_integrity_err   (),
     .emac_asf_int_nonfatal    (),
     .emac_asf_int_fatal       (),
   `endif // gem_has_802p3_br

   // Specific outputs to support half duplex flow control
   .halfduplex_flow_control_en (halfduplex_flow_control_en)

   );

  // Instantiation of the fifo 8b interface for the default mac
  `ifdef use_gem_fifo_8b_if
    wire [31:0] tx_r_data_32;
    wire        tx_r_rd_8b;
    wire        tx_r_data_rdy_8b;
    assign      rx_w_queue = 4'h0; // currently queues are not compatible with 8b FIFO interface. Restriction

    gem_fifo_8b_if i_gem_fifo_8b_if (
      .tx_clk               (tx_clk),
      .tx_rst_n             (n_txreset),
      .rx_rst_n             (n_rxreset),
      `ifdef gem_no_pcs
        .rx_clk             (rx_clk),
      `else // if not gem_no_pcs
        .rx_clk             (rx_clk_from_phy),
        .rx_clk_from_phy    (rx_clk_from_phy),
      `endif
      .tbi_selected         (speed_mode[2]),
      .enable_transmit      (enable_transmit),
      .enable_receive       (enable_receive),
      .tx_r_data_8b         (tx_r_data),
      .tx_r_sop_8b          (tx_r_sop),
      .tx_r_eop_8b          (tx_r_eop),
      .tx_r_err_8b          (tx_r_err),
      .tx_r_valid_8b        (tx_r_valid),
      .tx_r_data_rdy_8b     (tx_r_data_rdy[0]),
      .tx_r_underflow_8b    (tx_r_underflow),
      .tx_r_rd_8b           (tx_r_rd_8b),
      .tx_r_control_8b      (tx_r_control),
      .tx_r_fixed_lat_8b    (tx_r_fixed_lat),
      .tx_r_flushed_8b      (tx_r_flushed),
      .rx_w_wr_8b           (rx_w_wr),
      .rx_w_data_8b         (rx_w_data),
      .rx_w_sop_8b          (rx_w_sop),
      .rx_w_eop_8b          (rx_w_eop),
      .rx_w_err_8b          (rx_w_err),
      .rx_w_status_8b       (rx_w_status),
      `ifdef gem_tsu
        .rx_w_timestamp_8b  (rx_w_timestamp),
      `endif
      .tx_r_data_mac        (tx_r_data_32),
      .tx_r_mod_mac         (tx_r_mod_mac),
      .tx_r_sop_mac         (tx_r_sop_mac),
      .tx_r_eop_mac         (tx_r_eop_mac),
      .tx_r_err_mac         (tx_r_err_mac),
      .tx_r_valid_mac       (tx_r_valid_mac),
      .tx_r_data_rdy_mac    (tx_r_data_rdy_8b),
      .tx_r_underflow_mac   (tx_r_underflow_mac),
      .tx_r_rd_mac          (tx_r_rd_mac[0]),
      .tx_r_control_mac     (tx_r_control_mac),
      .rx_w_wr_mac          (rx_w_wr_mac),
      .rx_w_data_mac        (rx_w_data_mac[31:0]),
      .rx_w_mod_mac         (rx_w_mod_mac),
      .rx_w_sop_mac         (rx_w_sop_mac),
      .rx_w_eop_mac         (rx_w_eop_mac),
      .rx_w_err_mac         (rx_w_err_mac),
      `ifdef gem_tsu
        .rx_w_timestamp_mac (rx_w_timestamp_mac),
      `endif
      .rx_w_status_mac      (rx_w_status_mac)
    );

    wire [`gem_emac_bus_width:0] tx_r_data_pad;
    assign tx_r_data_pad        = {{(`gem_emac_bus_width-31){1'b0}},tx_r_data_32};
    assign tx_r_data_mac        = tx_r_data_pad[`gem_emac_bus_width-1:0];
    assign tx_r_data_rdy_mac[0] = tx_r_data_rdy_8b;
    genvar g1;
    generate for (g1=0; g1<`edma_queues; g1=g1+1) begin : gen_8b_fifo_only1q
      if (g1 == 0) begin : gen_q0
        assign tx_r_data_rdy_mac[g1] = tx_r_data_rdy_8b;
        assign tx_r_rd[g1]           = tx_r_rd_8b;
      end else begin : gen_others
        assign tx_r_data_rdy_mac[g1] = 1'b0;
        assign tx_r_rd[g1]           = 1'b0;
      end
    end
    endgenerate

    `else
      `ifdef gem_add_tx_external_fifo_if
        assign tx_r_data_mac       = tx_r_data;
        assign tx_r_mod_mac        = tx_r_mod;
        assign tx_r_sop_mac        = tx_r_sop;
        assign tx_r_eop_mac        = tx_r_eop;
        assign tx_r_err_mac        = tx_r_err;
        assign tx_r_valid_mac      = tx_r_valid;
        assign tx_r_data_rdy_mac   = tx_r_data_rdy;
        assign tx_r_underflow_mac  = tx_r_underflow;
        assign tx_r_rd             = tx_r_rd_mac;
        `ifdef dma_priority_queue1
          assign tx_r_queue          = tx_r_queue_mac;
        `endif
        assign tx_r_control_mac    = tx_r_control;
      `endif // gem_add_tx_external_fifo_if
      
      `ifdef gem_add_rx_external_fifo_if
        assign rx_w_wr             = rx_w_wr_mac;
        assign rx_w_data           = rx_w_data_mac;
        assign rx_w_mod            = rx_w_mod_mac;
        assign rx_w_sop            = rx_w_sop_mac;
        assign rx_w_eop            = rx_w_eop_mac;
        assign rx_w_err            = rx_w_err_mac;
        assign rx_w_status         = rx_w_status_mac;
        `ifdef dma_priority_queue1
          assign rx_w_queue          = rx_w_queue_mac;
        `endif
        `ifdef gem_tsu
          assign rx_w_timestamp      = rx_w_timestamp_mac;
        `endif // gem_tsu
      `endif // gem_add_rx_external_fifo_if
  `endif // use_gem_fifo_8b_if

  // Instantiation of the fifo 8b interface for the express mac if
  // 802.3br feature is defined
  `ifdef gem_has_802p3_br
    `ifdef use_gem_fifo_8b_if
      wire [31:0] emac_tx_r_data_32;
      wire        emac_tx_r_rd_8b;
      wire        emac_tx_r_data_rdy_8b;
      assign      emac_rx_w_queue = 4'h0; // currently queues are not compatible with 8b FIFO interface. Restriction
      gem_fifo_8b_if i_gem_fifo_8b_if_emac (
        .tx_clk               (tx_clk),
        .tx_rst_n             (n_txreset),
        .rx_rst_n             (n_rxreset),
        `ifdef gem_no_pcs
          .rx_clk             (rx_clk),
        `else // if not gem_no_pcs
          .rx_clk             (rx_clk_from_phy), // should be the same for both? yes - to fix
          .rx_clk_from_phy    (rx_clk_from_phy), // should be the same for both? yes - to fix
        `endif
        .tbi_selected         (speed_mode[2]),
        .enable_transmit      (enable_transmit),
        .enable_receive       (enable_receive),
        .tx_r_data_8b         (emac_tx_r_data),
        .tx_r_sop_8b          (emac_tx_r_sop),
        .tx_r_eop_8b          (emac_tx_r_eop),
        .tx_r_err_8b          (emac_tx_r_err),
        .tx_r_valid_8b        (emac_tx_r_valid),
        .tx_r_data_rdy_8b     (emac_tx_r_data_rdy[0]),
        .tx_r_underflow_8b    (emac_tx_r_underflow),
        .tx_r_rd_8b           (emac_tx_r_rd_8b),
        .tx_r_control_8b      (emac_tx_r_control),
        .tx_r_fixed_lat_8b    (emac_tx_r_fixed_lat),
        .tx_r_flushed_8b      (emac_tx_r_flushed),
        .rx_w_wr_8b           (emac_rx_w_wr),
        .rx_w_data_8b         (emac_rx_w_data),
        .rx_w_sop_8b          (emac_rx_w_sop),
        .rx_w_eop_8b          (emac_rx_w_eop),
        .rx_w_err_8b          (emac_rx_w_err),
        .rx_w_status_8b       (emac_rx_w_status),
        `ifdef gem_tsu
          .rx_w_timestamp_8b  (emac_rx_w_timestamp),
        `endif
        .tx_r_data_mac        (emac_tx_r_data_32),
        .tx_r_mod_mac         (emac_tx_r_mod_mac),
        .tx_r_sop_mac         (emac_tx_r_sop_mac),
        .tx_r_eop_mac         (emac_tx_r_eop_mac),
        .tx_r_err_mac         (emac_tx_r_err_mac),
        .tx_r_valid_mac       (emac_tx_r_valid_mac),
        .tx_r_data_rdy_mac    (emac_tx_r_data_rdy_8b),
        .tx_r_underflow_mac   (emac_tx_r_underflow_mac),
        .tx_r_rd_mac          (emac_tx_r_rd_mac[0]),
        .tx_r_control_mac     (emac_tx_r_control_mac),
        .rx_w_wr_mac          (emac_rx_w_wr_mac),
        .rx_w_data_mac        (emac_rx_w_data_mac[31:0]),
        .rx_w_mod_mac         (emac_rx_w_mod_mac),
        .rx_w_sop_mac         (emac_rx_w_sop_mac),
        .rx_w_eop_mac         (emac_rx_w_eop_mac),
        .rx_w_err_mac         (emac_rx_w_err_mac),
        `ifdef gem_tsu
          .rx_w_timestamp_mac (emac_rx_w_timestamp_mac),
        `endif
        .rx_w_status_mac      (emac_rx_w_status_mac)
      );

      wire [`gem_emac_bus_width:0] emac_tx_r_data_pad;
      assign emac_tx_r_data_pad        = {{(`gem_emac_bus_width-31){1'b0}},emac_tx_r_data_32};
      assign emac_tx_r_data_mac        = emac_tx_r_data_pad[`gem_emac_bus_width-1:0];
      assign emac_tx_r_data_rdy_mac[0] = emac_tx_r_data_rdy_8b;
      genvar g2;
      generate for (g2=0; g2<`edma_queues; g2=g2+1) begin : gen_8b_fifo_only1q_emac
        if (g2 == 0) begin : gen_q0
          assign emac_tx_r_data_rdy_mac[g2] = emac_tx_r_data_rdy_8b;
          assign emac_tx_r_rd[g2]           = emac_tx_r_rd_8b;
        end else begin : gen_others
          assign emac_tx_r_data_rdy_mac[g2] = 1'b0;
          assign emac_tx_r_rd[g2]           = 1'b0;
        end
      end
      endgenerate

    `else
      `ifdef gem_add_tx_external_fifo_if
        assign emac_tx_r_data_mac       = emac_tx_r_data;
        assign emac_tx_r_mod_mac        = emac_tx_r_mod;
        assign emac_tx_r_sop_mac        = emac_tx_r_sop;
        assign emac_tx_r_eop_mac        = emac_tx_r_eop;
        assign emac_tx_r_err_mac        = emac_tx_r_err;
        assign emac_tx_r_valid_mac      = emac_tx_r_valid;
        assign emac_tx_r_data_rdy_mac   = emac_tx_r_data_rdy;
        assign emac_tx_r_underflow_mac  = emac_tx_r_underflow;
        assign emac_tx_r_rd             = emac_tx_r_rd_mac;
        `ifdef dma_priority_queue1
          assign emac_tx_r_queue          = emac_tx_r_queue_mac;
        `endif
        assign emac_tx_r_control_mac    = emac_tx_r_control;
      `endif // gem_add_tx_external_fifo_if
      
      `ifdef gem_add_rx_external_fifo_if
        assign emac_rx_w_wr             = emac_rx_w_wr_mac;
        assign emac_rx_w_data           = emac_rx_w_data_mac;
        assign emac_rx_w_mod            = emac_rx_w_mod_mac;
        assign emac_rx_w_sop            = emac_rx_w_sop_mac;
        assign emac_rx_w_eop            = emac_rx_w_eop_mac;
        assign emac_rx_w_err            = emac_rx_w_err_mac;
        assign emac_rx_w_status         = emac_rx_w_status_mac;
        `ifdef dma_priority_queue1
          assign emac_rx_w_queue          = emac_rx_w_queue_mac;
        `endif
        `ifdef gem_tsu
          assign emac_rx_w_timestamp      = emac_rx_w_timestamp_mac;
        `endif
      `endif // gem_add_rx_external_fifo_if
    `endif
  `endif //gem_has_802p3_br

  `ifndef gem_no_pcs
    `ifndef gem_pcs_20b_if
      assign tx_group         = tx_group_from_pcs[9:0];
      assign rx_group_to_pcs  = {10'h000,rx_group[9:0]};
    `else
      assign tx_group         = tx_group_from_pcs;
      assign rx_group_to_pcs  = rx_group;
    `endif
  `endif

  assign     ethernet_int = ethernet_int_bus[0];       // ethernet mac interrupt signal.
  `ifdef gem_ext_fifo_interface
  `else
    assign     rx_databuf_wr_q0  = rx_databuf_wr_q[0];
    `ifdef dma_priority_queue15
      assign    ethernet_int_q15  = ethernet_int_bus[15];  // interrupt for queue 15 events
      assign    rx_databuf_wr_q15 = rx_databuf_wr_q[15];
    `endif
    `ifdef dma_priority_queue14
      assign    ethernet_int_q14  = ethernet_int_bus[14];  // interrupt for queue 14 events
      assign    rx_databuf_wr_q14 = rx_databuf_wr_q[14];
    `endif
    `ifdef dma_priority_queue13
      assign    ethernet_int_q13  = ethernet_int_bus[13];  // interrupt for queue 13 events
      assign    rx_databuf_wr_q13 = rx_databuf_wr_q[13];
    `endif
    `ifdef dma_priority_queue12
      assign    ethernet_int_q12  = ethernet_int_bus[12];  // interrupt for queue 12 events
      assign    rx_databuf_wr_q12 = rx_databuf_wr_q[12];
    `endif
    `ifdef dma_priority_queue11
      assign    ethernet_int_q11  = ethernet_int_bus[11];  // interrupt for queue 11 events
      assign    rx_databuf_wr_q11 = rx_databuf_wr_q[11];
    `endif
    `ifdef dma_priority_queue10
      assign    ethernet_int_q10  = ethernet_int_bus[10];  // interrupt for queue 10 events
      assign    rx_databuf_wr_q10 = rx_databuf_wr_q[10];
    `endif
    `ifdef dma_priority_queue9
      assign    ethernet_int_q9   = ethernet_int_bus[9];   // interrupt for queue 9 events
      assign    rx_databuf_wr_q9  = rx_databuf_wr_q[9];
    `endif
    `ifdef dma_priority_queue8
      assign    ethernet_int_q8   = ethernet_int_bus[8];   // interrupt for queue 8 events
      assign    rx_databuf_wr_q8  = rx_databuf_wr_q[8];
    `endif
    `ifdef dma_priority_queue7
      assign    ethernet_int_q7   = ethernet_int_bus[7];   // interrupt for queue 7 events
      assign    rx_databuf_wr_q7  = rx_databuf_wr_q[7];
    `endif
    `ifdef dma_priority_queue6
      assign    ethernet_int_q6   = ethernet_int_bus[6];   // interrupt for queue 6 events
      assign    rx_databuf_wr_q6  = rx_databuf_wr_q[6];
    `endif
    `ifdef dma_priority_queue5
      assign    ethernet_int_q5   = ethernet_int_bus[5];   // interrupt for queue 5 events
      assign    rx_databuf_wr_q5  = rx_databuf_wr_q[5];
    `endif
    `ifdef dma_priority_queue4
      assign    ethernet_int_q4   = ethernet_int_bus[4];   // interrupt for queue 4 events
      assign    rx_databuf_wr_q4  = rx_databuf_wr_q[4];
    `endif
    `ifdef dma_priority_queue3
      assign    ethernet_int_q3   = ethernet_int_bus[3];   // interrupt for queue 3 events
      assign    rx_databuf_wr_q3  = rx_databuf_wr_q[3];
    `endif
    `ifdef dma_priority_queue2
      assign    ethernet_int_q2   = ethernet_int_bus[2];   // interrupt for queue 2 events
      assign    rx_databuf_wr_q2  = rx_databuf_wr_q[2];
    `endif
    `ifdef dma_priority_queue1
      assign    ethernet_int_q1   = ethernet_int_bus[1];   // interrupt for queue 1 events
      assign    rx_databuf_wr_q1  = rx_databuf_wr_q[1];
    `endif
  `endif // gem_ext_fifo_interface

    `ifdef gem_has_802p3_br
      assign paddr_pad = {3'h0,paddr,2'b00};
    `else
      assign paddr_pad = {4'h0,paddr,2'b00};
    `endif

endmodule
