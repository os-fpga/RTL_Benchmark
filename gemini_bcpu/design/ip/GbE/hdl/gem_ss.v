//------------------------------------------------------------------------------
// Copyright (c) 2016-2022 Cadence Design Systems, Inc.
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
//   Filename:           gem_ss.v
//   Module Name:        gem_ss
//
//   Release Revision:   r1p12f7
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
//   Description :             Top level Gigabit Ethernet Mac block that
//                             instances the following modules:
//                             (2x) gem_top.v, edma_axi_arbiter.v
//                             gem_mmsl_apb_switch.v, gem_mmsl.v
//                             and gem_mii_bridge.v
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_ss (

  // system interface (resets)
  n_txreset,
  n_rxreset,

  // Internal loopback signals
  n_ntxreset,
  n_tx_clk,
  loopback_local,

  // gmii / mii ethernet interface.
  tx_clk,
  tx_er,
  txd,
  tx_en,
  rx_clk,
  rxd,
  rx_er,
  rx_dv,

  // other ethernet signals.
  col,
  crs,
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
  trigger_dma_tx_start,

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
  gem_tsu_inc_ctrl,
  gem_tsu_ms,
  tsu_timer_cnt,
  tsu_timer_cnt_par,
  tsu_timer_cmp_val,

  // tsu clock
  tsu_clk,
  n_tsureset,

  ext_tsu_timer,
  ext_tsu_timer_par,

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
  paddr_par,
  prdata,
  prdata_par,
  pwdata,
  pwdata_par,
  pwrite,
  penable,
  psel,
  perr,

  // AHB and/or Exposed FIFO interface is available
  // external fifo interface.
  // pmac connections
  tx_r_data,
  tx_r_mod,
  tx_r_sop,
  tx_r_eop,
  tx_r_err,
  tx_r_valid,
  tx_r_data_rdy,
  tx_r_underflow,
  tx_r_rd,
  tx_r_queue,
  tx_r_flushed,
  tx_r_control,
  tx_r_status,
  tx_r_frame_size_vld,
  tx_r_frame_size,
  tx_r_timestamp,

  dma_tx_status_tog,
  dma_tx_end_tog,

  rx_w_wr,
  rx_w_data,
  rx_w_mod,
  rx_w_sop,
  rx_w_eop,
  rx_w_err,
  rx_w_flush,
  rx_w_status,
  rx_w_queue,
  rx_w_overflow,
  rx_w_timestamp,

  add_match_vec,

  // AHB and/or Exposed FIFO interface is available
  // external fifo interface.
  // emac connections
  emac_tx_r_data,
  emac_tx_r_mod,
  emac_tx_r_sop,
  emac_tx_r_eop,
  emac_tx_r_err,
  emac_tx_r_valid,
  emac_tx_r_data_rdy,
  emac_tx_r_underflow,
  emac_tx_r_rd,
  emac_tx_r_queue,
  emac_tx_r_flushed,
  emac_tx_r_control,
  emac_tx_r_status,
  emac_tx_r_frame_size_vld,
  emac_tx_r_frame_size,
  emac_tx_r_timestamp,

  emac_dma_tx_status_tog,
  emac_dma_tx_end_tog,

  emac_rx_w_wr,
  emac_rx_w_data,
  emac_rx_w_mod,
  emac_rx_w_sop,
  emac_rx_w_eop,
  emac_rx_w_err,
  emac_rx_w_flush,
  emac_rx_w_status,
  emac_rx_w_queue,
  emac_rx_w_overflow,
  emac_rx_w_timestamp,

  emac_add_match_vec,


  // AXI interface signals
  aclk,
  n_areset,

  // Write Address Channel
  awid,
  awaddr,
  awaddr_par,
  awlen,
  awsize,
  awburst,
  awlock,
  awcache,
  awprot,
  awvalid,
  awqos,
  awready,
  // Write Data Channel
  wdata,
  wdata_par,
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
  araddr_par,
  arlen,
  arsize,
  arburst,
  arlock,
  arcache,
  arprot,
  arvalid,
  arqos,
  arready,
  // Read Data Channel
  rdata,
  rdata_par,
  rresp,
  rlast,
  rvalid,
  rready,
  rid,

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

  // DMA bus width indication to external controller or FIFO
  dma_bus_width,

  // SRAM interface ..
  tx_sram_wea,
  tx_sram_ena,
  tx_sram_addra,
  tx_sram_dia,
  tx_sram_doa,
  tx_sram_web,
  tx_sram_enb,
  tx_sram_addrb,
  tx_sram_dob,

  rx_sram_wea,
  rx_sram_ena,
  rx_sram_addra,
  rx_sram_dia,
  rx_sram_doa,
  rx_sram_web,
  rx_sram_enb,
  rx_sram_addrb,
  rx_sram_dob,

  // eMAC SRAM interface ..
  emac_tx_sram_wea,
  emac_tx_sram_ena,
  emac_tx_sram_addra,
  emac_tx_sram_dia,
  emac_tx_sram_doa,
  emac_tx_sram_web,
  emac_tx_sram_enb,
  emac_tx_sram_addrb,
  emac_tx_sram_dob,

  emac_rx_sram_wea,
  emac_rx_sram_ena,
  emac_rx_sram_addra,
  emac_rx_sram_dia,
  emac_rx_sram_doa,
  emac_rx_sram_web,
  emac_rx_sram_enb,
  emac_rx_sram_addrb,
  emac_rx_sram_dob,

  // User I/O interface
  user_out,
  user_in,

  // Specific outputs to support Priority Queues
  rx_databuf_wr_q,
  ethernet_int_bus,
  emac_ethernet_int,

  // 10/100 MII select - low for RMII
  mii_select,

  // Specific outputs to support half duplex flow control
  halfduplex_flow_control_en,

  // rgmii interface signals
  tx_clk_sig,
  n_nrxreset,
  n_rx_clk,
  rgmii_txd,
  rgmii_tx_ctl,
  rgmii_rxd,
  rgmii_rx_ctl,
  rgmii_link_status, // rgmii extracted link status
  rgmii_speed,       // rgmii extracted speed status
  rgmii_duplex_out,  // rgmii extracted duplex status

  // rmii interface signals.
  n_ref_reset,       // RMII reset for ref clock
  ref_clk,           // RMII ref clock
  rmii_rx_clk,       // clock generated by RMII for RX Path
  rmii_tx_clk,       // clock generated by RMII for TX Path
  rmii_txd,          // transmit data to the phy.
  rmii_tx_en,        // transmit enable signal to the phy.
  rmii_rxd,          // receive data from the phy.
  rmii_rx_er,        // receive error signal from the phy.
  rmii_crs_dv,       // receive data valid signal from the phy.

  // PCS interface signals
  gtx_clk,           // Gigabit tx clock.
  n_gtxreset,        // Reset in tx domain.
  gtx20_clk,         // Gigabit tx clock divided by 2.
  n_gtx20reset,      // Reset in tx domain.
  rbc0,              // receive clock 0 from phy.
  rbc1,              // receive clock 1 from phy.
  n_rbc0reset,       // rbc0 domain reset
  n_rbc1reset,       // rbc1 domain reset
  pcs_rx_clk,        // PCS 62.5MHz receive clock
  n_pcs_rxreset,     // Asynchronous reset
  pcs_cal_bypass,    // Bypass comma alignment
  pcs_cgalign_bypass,// Bypass codegroup alignment
  pcs_rx10_clk,      // PCS 125MHz receive clock
  n_pcs_rx10reset,   // Asynchronous reset
  tx_group,          // 8b/10b encoded transmit data to the phy.
  rx_group,          // 8b/10b encoded receive data from the phy
  ewrap,             // initiate loop back of phy.
  en_cdet,           // Enable comma alignment in PMA.
  signal_detect,     // Valid link detected from PMD.

  // 8Bit FIFO interface signals
  enable_transmit,
  enable_receive,

  // ASF comman output error indications
  asf_sram_corr_err,
  asf_sram_uncorr_err,
  asf_dap_err,
  asf_csr_err,
  asf_trans_to_err,
  asf_protocol_err,
  asf_integrity_err,

  // ASF and fatal and non-fatal interrupts
  asf_int_nonfatal,
  asf_int_fatal,

   // ASF comman output error indications
  emac_asf_sram_corr_err,
  emac_asf_sram_uncorr_err,
  emac_asf_dap_err,
  emac_asf_csr_err,
  emac_asf_trans_to_err,
  emac_asf_protocol_err,
  emac_asf_integrity_err,
  // ASF and fatal and non-fatal interrupts
  emac_asf_int_nonfatal,
  emac_asf_int_fatal,

  // MMSL interrupt
  mmsl_int

);

//------------------------------------------------------------------------------
// Declare inputs and outputs
//------------------------------------------------------------------------------

  parameter [1363:0] grouped_params = {1364{1'b0}};


  `include "ungroup_params.v"

  // If 802.3 BR functionality is added, the EMAC has a cutdown capability
  // from the PMAC
  parameter emac_grouped_params = {grouped_params[1363:1174],
                                   (grouped_params[1157] ? 8'd2 : 8'd1),   // Fix p_gem_num_cb_streams to 2 if CB has been enabled (p_gem_has_cb is in bit 1157)
                                   grouped_params[1165:1156],
                                   32'd1,                                  // Fix p_edma_queues to 1
                                   grouped_params[1123:1060],
                                   p_edma_emac_tx_pbuf_addr,               // Overwrite p_edma_tx_pbuf_addr with p_edma_tx_pbuf_addr
                                   p_edma_emac_rx_pbuf_addr,               // Overwrite p_edma_rx_pbuf_addr with p_edma_rx_pbuf_addr
                                   grouped_params[995:190],
                                   1'b1,                                   // ensure p_edma_ext_tsu_timer is set so eMAC can use pMAC's TSU
                                   grouped_params[188:187],
                                   1'b0,                                   // Disable p_edma_rsc
                                   grouped_params[185:178],
                                   1'b0,                                   // Disable user_io
                                   32'd1,                                  // set user_in_width to 1
                                   32'd1,                                  // set user_out_width to 1
                                   grouped_params[112:32],
                                   (grouped_params[1157] ? 8'd1 : 8'd0),   // No Type 1 screeners required as only 1 queue. Need to set to 1 though to avoid comp error
                                   (grouped_params[1157] ? 8'd2 : 8'd0),   // Fix to two Type 2 screeners for 802.1CB support (max 2 streams)
                                   (grouped_params[1157] ? 8'd6 : 8'd0),   // Fix to 6 compare regs for 802.1CB support (stream ID identification requires 3 comp regs per stream)
                                   8'd0                                    // No Ethtype regs required
                                  };

  parameter p_edma_emac_tx_pbuf_reduncy = p_edma_tx_pbuf_reduncy;
  parameter p_edma_emac_rx_pbuf_reduncy = p_edma_rx_pbuf_reduncy;

  parameter p_tx_sram_width = p_edma_tx_pbuf_reduncy + p_edma_tx_pbuf_data;
  parameter p_rx_sram_width = p_edma_rx_pbuf_reduncy + p_edma_rx_pbuf_data;
  parameter p_emac_tx_sram_width = p_edma_emac_tx_pbuf_reduncy + p_edma_tx_pbuf_data;
  parameter p_emac_rx_sram_width = p_edma_emac_rx_pbuf_reduncy + p_edma_rx_pbuf_data;

  // system interface (resets)
  input          n_txreset;         // tx_clk domain reset
  input          n_rxreset;         // rx_clk domain reset

  // Internal loopback signals
  input          n_ntxreset;        // n_tx_clk domain reset
  input          n_tx_clk;          // inverted tx_clk_in used for loopback.
  output         loopback_local;    // Indicates MAC is in local loopback.

  // gmii / mii ethernet interface.
  input          tx_clk;            // transmit clock from the phy.
  output         tx_er;             // transmit error signal to the phy.
  output   [7:0] txd;               // transmit data to the phy.
  output         tx_en;             // transmit enable signal to the phy.
  input          rx_clk;            // receive clock from the phy.
  input    [7:0] rxd;               // receive data from the phy.
  input          rx_er;             // receive error signal from the phy.
  input          rx_dv;             // receive data valid signal from the phy.

  // Other ethernet signals.
  input          col;               // collision detect signal from the phy.
  input          crs;               // carrier sense signal from the phy.
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
  output   [7:0] rx_pfc_paused;     // each bit is set when PFC frame has
                                    // been received and the associated
                                    // PFC counter != 0
  output         wol;               // Wake-on-LAN output

  input          trigger_dma_tx_start;// Async input used to trigger tx_start

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
  input          gem_tsu_ms;        // timer master/slave
  input    [1:0] gem_tsu_inc_ctrl;  // timer increment control
  output  [93:0] tsu_timer_cnt;     // TSU timer count value
  output  [11:0] tsu_timer_cnt_par; // Parity
  output         tsu_timer_cmp_val; // TSU timer comparison valid

  // tsu clock signals
  input          tsu_clk;           // TSU timer clock (10 to 50MHz)
  input          n_tsureset;        // Reset in tsu_clk domain
  input   [93:0] ext_tsu_timer;     // external TSU timer value
  input   [11:0] ext_tsu_timer_par;

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
  input          pclk;              // amba apb clock.
  input          n_preset;          // amba apb reset.
  input   [15:0] paddr;             // address bus of selected master.
  input   [1:0]  paddr_par;         // Parity for paddr
  output  [31:0] prdata;            // read data.
  output  [3:0]  prdata_par;        // Parity for prdata
  input   [31:0] pwdata;            // write data.
  input   [3:0]  pwdata_par;        // Parity for pwdata
  input          pwrite;            // peripheral write strobe.
  input          penable;           // peripheral enable.
  input          psel;              // peripheral select for gpio.
  output         perr;              // not a standard apb signal, driven high
                                    // when psel is asserted if address is not
                                    // known.

  // low latency tx interface uses external fifo tx port
  // pmac connections
  input     [p_emac_bus_width-1:0] tx_r_data;           // output data from the transmit fifo to the tx module.
  input                      [3:0] tx_r_mod;            // tx number of valid bytes in last
                                                        // transfer of the frame.
                                                        // 0000 - tx_r_data[127:0] valid,
                                                        // 0001 - tx_r_data[7:0] valid,
                                                        // 0010 - tx_r_data[15:0] valid, until
                                                        // 1111 - tx_r_data[119:0] valid.
  input                            tx_r_sop;            // start of packet indicator.
  input                            tx_r_eop;            // end of packet indicator.
  input                            tx_r_err;            // packet in error indicator.
  output       [p_edma_queues-1:0] tx_r_rd;             // request new data from fifo.
  output                     [3:0] tx_r_queue;          // Queue ID, timed with tx_r_rd
  input                            tx_r_valid;          // new tx data available from fifo.
  input        [p_edma_queues-1:0] tx_r_data_rdy;       // indicates either a complete packet
                                                        // is present in the fifo or a certain
                                                        // threshold of data has been crossed,
                                                        // the mac uses this input to trigger
                                                        // a frame transfer.
  input                            tx_r_underflow;      // signals tx fifo underrun condition.
  input                            tx_r_flushed;        // tx fifo has been flushed.
  input                            tx_r_control;        // tx control from in-line FIFO word
  input        [p_edma_queues-1:0] tx_r_frame_size_vld; // We have the frame size.
  input   [(p_edma_queues*14)-1:0] tx_r_frame_size;     // Frame Length, 1 per queue
  output                     [3:0] tx_r_status;         // tx status written to in-line FIFO word
  output                    [77:0] tx_r_timestamp;      // asserted high at the end of frame

  input                            dma_tx_status_tog;   // toggle acknowledge for tx_r_status.
  output                           dma_tx_end_tog;      // toggled when tx_r_status is valid.

  // external fifo interface.
  output                            rx_w_wr;            // rx write output to the receive fifo
  output     [p_emac_bus_width-1:0] rx_w_data;          // output data to the receive fifo.
  output                      [3:0] rx_w_mod;           // rx number of valid bytes in last.
                                                        // transfer of the frame.
  output                            rx_w_sop;           // rx start of packet indicator.
  output                            rx_w_eop;           // rx end of packet indicator.
  output                            rx_w_err;           // rx packet in error indicator.
  output                            rx_w_flush;         // rx fifo flush from the mac.
  output                     [44:0] rx_w_status;        // rx status written to in-line FIFO word.
  output                     [77:0] rx_w_timestamp;     // valid on rx_w_eop
  output [p_num_spec_add_filters:0] add_match_vec;      // indicates specific address match status 3 to 0 are returned by rx_w_status
  output                      [3:0] rx_w_queue;         // RX Priority queue number
  input                             rx_w_overflow;      // Overrun in RX FIFO indication.

  // low latency tx interface uses external fifo tx port
  // emac connections
  input     [p_emac_bus_width-1:0] emac_tx_r_data;           // output data from the transmit fifo to the tx module.
  input                      [3:0] emac_tx_r_mod;            // tx number of valid bytes in last
                                                             // transfer of the frame.
                                                             // 0000 - tx_r_data[127:0] valid,
                                                             // 0001 - tx_r_data[7:0] valid,
                                                             // 0010 - tx_r_data[15:0] valid, until
                                                             // 1111 - tx_r_data[119:0] valid.
  input                            emac_tx_r_sop;            // start of packet indicator.
  input                            emac_tx_r_eop;            // end of packet indicator.
  input                            emac_tx_r_err;            // packet in error indicator.
  output                           emac_tx_r_rd;             // request new data from fifo.
  output                     [3:0] emac_tx_r_queue;          // Queue ID, timed with tx_r_rd
  input                            emac_tx_r_valid;          // new tx data available from fifo.
  input                            emac_tx_r_data_rdy;       // indicates either a complete packet
                                                             // is present in the fifo or a certain
                                                             // threshold of data has been crossed,
                                                             // the mac uses this input to trigger
                                                             // a frame transfer.
  input                            emac_tx_r_underflow;      // signals tx fifo underrun condition.
  input                            emac_tx_r_flushed;        // tx fifo has been flushed.
  input                            emac_tx_r_control;        // tx control from in-line FIFO word
  input                            emac_tx_r_frame_size_vld; // We have the frame size.
  input                     [13:0] emac_tx_r_frame_size;     // Frame Length, 1 per queue
  output                     [3:0] emac_tx_r_status;         // tx status written to in-line FIFO word
  output                    [77:0] emac_tx_r_timestamp;      // asserted high at the end of frame

  input                            emac_dma_tx_status_tog;   // toggle acknowledge for tx_r_status.
  output                           emac_dma_tx_end_tog;      // toggled when tx_r_status is valid.

  // external fifo interface.
  output                            emac_rx_w_wr;            // rx write output to the receive fifo
  output     [p_emac_bus_width-1:0] emac_rx_w_data;          // output data to the receive fifo.
  output                      [3:0] emac_rx_w_mod;           // rx number of valid bytes in last.
                                                             // transfer of the frame.
  output                            emac_rx_w_sop;           // rx start of packet indicator.
  output                            emac_rx_w_eop;           // rx end of packet indicator.
  output                            emac_rx_w_err;           // rx packet in error indicator.
  output                            emac_rx_w_flush;         // rx fifo flush from the mac.
  output                     [44:0] emac_rx_w_status;        // rx status written to in-line FIFO word.
  output                     [77:0] emac_rx_w_timestamp;     // valid on rx_w_eop
  output [p_num_spec_add_filters:0] emac_add_match_vec;      // indicates specific address match status 3 to 0 are returned by rx_w_status
  output                      [3:0] emac_rx_w_queue;         // RX Priority queue number
  input                             emac_rx_w_overflow;      // Overrun in RX FIFO indication.

  // AXI interface signals.
  input          aclk;
  input          n_areset;

  // Write Address Channel
  output                      [3:0] awid;
  output    [p_edma_addr_width-1:0] awaddr;
  output    [p_edma_addr_pwid-1:0]  awaddr_par;
  output                      [7:0] awlen;
  output                      [2:0] awsize;
  output                      [1:0] awburst;
  output                      [1:0] awlock;
  output                      [3:0] awcache;
  output                      [2:0] awprot;
  output                            awvalid;
  output                      [3:0] awqos;
  input                             awready;

  // Write Data Channel
  output     [p_edma_bus_width-1:0] wdata;
  output     [p_edma_bus_pwid-1:0]  wdata_par;
  output [(p_edma_bus_width/8)-1:0] wstrb;
  output                            wlast;
  output                      [3:0] wid;
  input                             wready;
  output                            wvalid;

  // Response Channel
  input   [3:0] bid;
  input   [1:0] bresp;
  input         bvalid;
  output        bready;

  // Read Address Channel
  output                      [3:0] arid;
  output    [p_edma_addr_width-1:0] araddr;
  output    [p_edma_addr_pwid-1:0]  araddr_par;
  output                      [7:0] arlen;
  output                      [2:0] arsize;
  output                      [1:0] arburst;
  output                      [1:0] arlock;
  output                      [3:0] arcache;
  output                      [2:0] arprot;
  output                            arvalid;
  output                      [3:0] arqos;
  input                             arready;

  // Read Data Channel
  input      [p_edma_bus_width-1:0] rdata;
  input      [p_edma_bus_pwid-1:0]  rdata_par;
  input                       [1:0] rresp;
  input                             rlast;
  input                             rvalid;
  input                       [3:0] rid;
  output                            rready;

  // AHB interface signals.
  input                             hclk;     // AHB clock.
  input                             n_hreset; // AHB reset.
  input                             hgrant;   // AHB arbiter control grant.
  input                             hready;   // AHB Slave ready.
  input                       [1:0] hresp;    // AHB Slave response (OK, error, retry or split).
  input      [p_edma_bus_width-1:0] hrdata;   // AHB input data.
  output                            hbusreq;  // AHB bus request.
  output                            hlock;    // lock the bus - always asserted with
  output    [p_edma_addr_width-1:0] haddr;    // hbusreq address to be accessed.
  output                      [1:0] htrans;   // bus transfer type (nonseq, seq, idle or busy)
  output                            hwrite;   // AHB write signal (active high).
  output                      [2:0] hsize;    // transfer size -
                                              // set to 3'b010 for 32 bit words.
                                              // set to 3'b011 for 64 bit words.
                                              // set to 3'b100 for 128 bit words.
  output                      [2:0] hburst;   // burst type (single, incrementing etc).
  output                      [3:0] hprot;    // Protection type - unused tied low.
  output     [p_edma_bus_width-1:0] hwdata;   // AHB Write data.


  // DMA bus width indication to external controller or FIFO
  output   [1:0] dma_bus_width;     // encoding for dma bus width.

  // Packet buffer external SRAM connections
  output         tx_sram_wea;        // Port A is always used for write
  output         tx_sram_ena;
  output [p_edma_tx_pbuf_addr-1:0]
                 tx_sram_addra;
  output [p_tx_sram_width-1:0]
                 tx_sram_dia;
  input  [p_tx_sram_width-1:0]       // With optional read when SPRAM
                 tx_sram_doa;
  output         tx_sram_web;        // Port B is always read only
  output         tx_sram_enb;
  output [p_edma_tx_pbuf_addr-1:0]
                 tx_sram_addrb;
  input  [p_tx_sram_width-1:0]
                 tx_sram_dob;

  output         rx_sram_wea;        // Port A is always used for write
  output         rx_sram_ena;
  output [p_edma_rx_pbuf_addr-1:0]
                 rx_sram_addra;
  output [p_rx_sram_width-1:0]
                 rx_sram_dia;
  input  [p_rx_sram_width-1:0]       // With optional read when SPRAM
                 rx_sram_doa;
  output         rx_sram_web;        // Port B is always read only
  output         rx_sram_enb;
  output [p_edma_rx_pbuf_addr-1:0]
                 rx_sram_addrb;
  input  [p_rx_sram_width-1:0]
                 rx_sram_dob;

  // Packet buffer external SRAM connections
  output         emac_tx_sram_wea;        // Port A is always used for write
  output         emac_tx_sram_ena;
  output [p_edma_emac_tx_pbuf_addr-1:0]
                 emac_tx_sram_addra;
  output [p_emac_tx_sram_width-1:0]
                 emac_tx_sram_dia;
  input  [p_emac_tx_sram_width-1:0]       // With optional read when SPRAM
                 emac_tx_sram_doa;
  output         emac_tx_sram_web;        // Port B is always read only
  output         emac_tx_sram_enb;
  output [p_edma_emac_tx_pbuf_addr-1:0]
                 emac_tx_sram_addrb;
  input  [p_emac_tx_sram_width-1:0]
                 emac_tx_sram_dob;

  output         emac_rx_sram_wea;        // Port A is always used for write
  output         emac_rx_sram_ena;
  output [p_edma_emac_rx_pbuf_addr-1:0]
                 emac_rx_sram_addra;
  output [p_emac_rx_sram_width-1:0]
                 emac_rx_sram_dia;
  input  [p_emac_rx_sram_width-1:0]       // With optional read when SPRAM
                 emac_rx_sram_doa;
  output         emac_rx_sram_web;        // Port B is always read only
  output         emac_rx_sram_enb;
  output [p_edma_emac_rx_pbuf_addr-1:0]
                 emac_rx_sram_addrb;
  input  [p_emac_rx_sram_width-1:0]
                 emac_rx_sram_dob;


  // User I/O interface.
  output  [(p_gem_user_out_width - 1):0] user_out; // programmable user outputs to top level
  input    [(p_gem_user_in_width - 1):0] user_in;  // programmable user inputs from top level



  // Specific outputs to support Priority Queues
  output             [p_edma_queues-1:0] rx_databuf_wr_q;

  // Specific outputs to support half duplex flow control
  input          halfduplex_flow_control_en;  // Flow control enable

  // Interrupt controller interface.
  output [15:0]  ethernet_int_bus;  // ethernet mac interrupt bus signal.
  output         emac_ethernet_int; // ethernet mac interrupt bus signal.
  input          mii_select;        // 10/100 MII select - low for RMII

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

  // ten bit interface signals.
  input          gtx_clk;           // Gigabit tx clock.
  input          n_gtxreset;        // Reset in tx domain.
  input          gtx20_clk;         // Gigabit tx clock divided by 2.
  input          n_gtx20reset;      // Reset in tx domain.
  input          rbc0;              // receive clock 0 from phy.
  input          rbc1;              // receive clock 1 from phy.
  input          n_rbc0reset;       // rbc0 domain reset
  input          n_rbc1reset;       // rbc1 domain reset
  input          pcs_rx_clk;        // PCS 62.5MHz receive clock
  input          n_pcs_rxreset;     // Asynchronous reset
  input          pcs_cal_bypass;    // Bypass comma alignment
  input          pcs_cgalign_bypass;// Bypass codegroup alignment
  input          pcs_rx10_clk;      // PCS 125MHz receive clock
  input          n_pcs_rx10reset;   // Asynchronous reset
  output [19:0]  tx_group;          // 8b/10b encoded transmit data to the phy.
  input  [19:0]  rx_group;          // 8b/10b encoded receive data from the phy
  output         ewrap;             // initiate loop back of phy.
  output         en_cdet;           // Enable comma alignment in PMA.
  input          signal_detect;     // Valid link detected from PMD.

  // 8bit FIFO interface signals
  output         enable_transmit;   // Coming from gem_top
  output         enable_receive;    // Coming from gem_top

  // ASF comman output error indications
  output         asf_sram_corr_err;             // SRAM correctable error indication
  output         asf_sram_uncorr_err;           // SRAM uncorrectable error indication
  output         asf_dap_err;                   // Data and Address Paths error indication
  output         asf_csr_err;                   // Configuration and Status Registers error indication
  output         asf_trans_to_err;              // Transaction Timeouts indication
  output         asf_protocol_err;              // Protocol error indication
  output         asf_integrity_err;             // Integrity error indication
  // ASF and fatal and non-fatal interrupts
  output         asf_int_nonfatal;              // ASF non-fatal interrupt
  output         asf_int_fatal;                 // ASF fatal interrupt

  // ASF comman output error indications for emac
  output         emac_asf_sram_corr_err;        // SRAM correctable error indication
  output         emac_asf_sram_uncorr_err;      // SRAM uncorrectable error indication
  output         emac_asf_dap_err;              // Data and Address Paths error indication
  output         emac_asf_csr_err;              // Configuration and Status Registers error indication
  output         emac_asf_trans_to_err;         // Transaction Timeouts indication
  output         emac_asf_protocol_err;         // Protocol error indication
  output         emac_asf_integrity_err;        // Integrity error indication
  // ASF and fatal and non-fatal interrupts for emac
  output         emac_asf_int_nonfatal;         // ASF non-fatal interrupt
  output         emac_asf_int_fatal;            // ASF fatal interrupt

  // MMSL interrupt
  output         mmsl_int;                     // MMSL interrupt

//------------------------------------------------------------------------------
// Declare wires
//------------------------------------------------------------------------------

  // Parity for AXI
  wire [p_edma_bus_pwid-1:0]   rdata_par_int;
  wire [3:0]                   pwdata_par_int;

  // Parity for FIFO interface
  wire [p_emac_bus_pwid-1:0]   tx_r_data_par;
  wire [p_emac_bus_pwid-1:0]   emac_tx_r_data_par;

  // APB Ports
  wire        pmac_psel;
  wire        pmac_penable;
  wire [11:2] pmac_paddr;
  wire        pmac_pwrite;
  wire [31:0] pmac_pwdata;
  wire [3:0]  pmac_pwdata_par;
  wire [31:0] pmac_prdata;
  wire [3:0]  pmac_prdata_par;
  wire [31:0] pmac_prdata_with_mii;
  wire [3:0]  pmac_prdata_par_with_mii;
  wire        pmac_perr;
  wire        pmac_perr_with_mii;
  // AXI Ports
  // AW
  //wire   [3:0]              pmac_awid;
  wire   [p_edma_addr_width-1:0] pmac_awaddr;
  wire    [p_edma_addr_pwid-1:0] pmac_awaddr_par;
  wire                     [7:0] pmac_awlen;
  wire                     [2:0] pmac_awsize;
  wire                     [1:0] pmac_awburst;
  wire                     [3:0] pmac_awcache;
  wire                     [2:0] pmac_awprot;
  wire                           pmac_awvalid;
  wire                     [3:0] pmac_awqos;

  // W
  //wire   [3:0]              pmac_wid;
  wire    [p_edma_bus_width-1:0] pmac_wdata;
  wire     [p_edma_bus_pwid-1:0] pmac_wdata_par;
  wire  [p_edma_bus_width/8-1:0] pmac_wstrb;
  wire                           pmac_wlast;
  wire                           pmac_wvalid;
  wire                           pmac_wready;

  // B
  wire                     [1:0] pmac_bresp;
  wire                           pmac_bvalid;
  wire                           pmac_bready;

  // AR
  //wire   [3:0]              pmac_arid;
  wire   [p_edma_addr_width-1:0] pmac_araddr;
  wire    [p_edma_addr_pwid-1:0] pmac_araddr_par;
  wire                     [7:0] pmac_arlen;
  wire                     [2:0] pmac_arsize;
  wire                     [1:0] pmac_arburst;
  wire                     [3:0] pmac_arcache;
  wire                     [2:0] pmac_arprot;
  wire                           pmac_arvalid;
  wire                           pmac_arready;
  wire                     [3:0] pmac_arqos;

  // R
  //wire   [3:0]              pmac_rid;
  wire    [p_edma_bus_width-1:0] pmac_rdata;
  wire     [p_edma_bus_pwid-1:0] pmac_rdata_par;
  wire                     [1:0] pmac_rresp;
  wire                           pmac_rlast;
  wire                           pmac_rvalid;
  wire                           pmac_rready;

  wire        emac_tx_en;
  wire        emac_tx_er;
  wire  [7:0] emac_txd;
  wire        emac_txd_par;
  wire        emac_tx_rdy;
  wire        emac_tx_er_pcs;         // transmit error signal to the PCS.
  wire  [7:0] emac_txd_pcs;           // transmit data to the PCS.
  wire        emac_txd_par_pcs;
  wire        emac_tx_en_pcs;         // transmit enable signal to the PCS.
  wire        emac_pmux_rx_dv;
  wire        emac_pmux_rx_er;
  wire  [7:0] emac_pmux_rxd;
  wire        emac_pmux_rxd_par;
  wire  [1:0] emac_pmux_rx_dv_pcs;
  wire  [1:0] emac_pmux_rx_er_pcs;
  wire [15:0] emac_pmux_rxd_pcs;
  wire [1:0]  emac_pmux_rxd_par_pcs;

  wire        pmac_tx_en;
  wire        pmac_tx_er;
  wire  [7:0] pmac_txd;
  wire        pmac_txd_par;
  wire [13:0] pmac_tx_frame_len;
  wire        pmac_tx_rdy;
  wire        pmac_tx_er_pcs;         // transmit error signal to the PCS.
  wire  [7:0] pmac_txd_pcs;           // transmit data to the PCS.
  wire        pmac_txd_par_pcs;
  wire        pmac_tx_en_pcs;         // transmit enable signal to the PCS.
  wire        pmac_pmux_rx_dv;
  wire        pmac_pmux_rx_er;
  wire  [7:0] pmac_pmux_rxd;
  wire        pmac_pmux_rxd_par;
  wire  [1:0] pmac_pmux_rx_dv_pcs;
  wire  [1:0] pmac_pmux_rx_er_pcs;
  wire [15:0] pmac_pmux_rxd_pcs;
  wire  [1:0] pmac_pmux_rxd_par_pcs;
  wire        pmac_pmux_rx_halt;
  reg         pmac_rx_halt;
  reg         pmac_rx_dv;
  reg         pmac_rx_er;
  reg   [7:0] pmac_rxd;
  reg         pmac_rxd_par;
  reg   [1:0] pmac_rx_dv_pcs;
  reg   [1:0] pmac_rx_er_pcs;
  reg  [15:0] pmac_rxd_pcs;
  reg   [1:0] pmac_rxd_par_pcs;

  wire        rx_dv_from_bridge;
  wire        rx_er_from_bridge;
  wire  [7:0] rxd_from_bridge;
  wire        rxd_par_from_bridge;
  wire        col_from_bridge;
  wire        crs_from_bridge;
  wire  [1:0] rx_dv_pcs_from_bridge;
  wire  [1:0] rx_er_pcs_from_bridge;
  wire [15:0] rxd_pcs_from_bridge;
  wire  [1:0] rxd_par_pcs_from_bridge;
  wire        col_pcs_from_bridge;
  wire        crs_pcs_from_bridge;
  reg         tx_en_to_bridge;
  reg         tx_er_to_bridge;
  reg   [7:0] txd_to_bridge;
  reg         tx_en_pcs_to_bridge;
  reg         tx_er_pcs_to_bridge;
  reg   [7:0] txd_pcs_to_bridge;
  reg         txd_par_pcs_to_bridge;

  wire        pmac_tx_enable;
  wire        pmac_rx_enable;

  wire        hold;
  wire  [3:0] speed_mode;
  wire        tx_lpi_en;

  wire  [1:0] add_frag_size;
  wire  [3:0] min_ifg;  // minimum transmit IFG divided by four

  // ASF fault signalling
  wire         asf_csr_mmsl_err;     // Registers fault in MMSL
  wire         asf_csr_pcs_err;      // Registers fault in PCS
  wire         asf_dap_paddr_err;    // Fault in APB host address
  wire         asf_dap_prdata_err;   // Fault in APB read data
  wire         asf_dap_rdata_err;    // Fault in AXI read data
  wire         asf_dap_pcs_tx_err;   // Fault in PCS TX datapath
  wire         asf_dap_pcs_rx_err;   // Fault in PCS RX datapath
  wire         asf_dap_mmsl_rx_err;  // Fault in MMSL RX datapath
  wire         asf_dap_mmsl_tx_err;  // Fault in MMSL TX datapath

  wire         link_fault_signal_en; // 802.3cb link fault signalling enabled
  wire  [1:0]  link_fault_status;    // Link fault Signalling ..

  // Lockup detect signalling feedback from the bridge
  wire         lu_det_e_pip;         // eMAC packet in progress
  wire         lu_det_p_pip;         // pMAC packet in progress
  wire         lu_det_p_eop_gate;    // Gate for eop detect
  wire         emac_tx_eop_pulse;    // Pulse to indicate EOP due to eMAC frame
  wire         pmac_tx_eop_pulse;    // Pulse to indicate EOP due to pMAC frame

  // ASF transaction timeout control
  wire         asf_trans_to_en;
  wire  [15:0] asf_trans_to_time;
  wire         asf_host_trans_to_err;

  wire         sel_mii_on_rgmii;
  wire         mac_full_duplex;
  wire         mac_pause_rx_en;
  wire         mac_pause_tx_en;
  wire         np_data_int;
  wire         pcs_an_complete;
  wire         pcs_link_state;
  wire         full_duplex;
  wire         retry_test;
  wire         uni_direct_en;
  wire         sgmii_mode;
  wire         alt_sgmii_mode;
  wire         pmac_awready;

  // Generate parity for host ports if the host is not supplying them.
  generate if (p_edma_asf_host_par == 1'b1) begin : gen_host_par
    assign rdata_par_int  = rdata_par;
    assign pwdata_par_int = pwdata_par;

    // Parity check of paddr here since further down the hierarchy only
    // 12-bits are used so the parity would not match.
    cdnsdru_asf_parity_check_v1 #(
      .p_data_width (16)
    ) i_chk_paddr (
      .odd_par    (1'b0),
      .data_in    (paddr[15:0]),
      .parity_in  (paddr_par[1:0]),
      .parity_err (asf_dap_paddr_err)
    );

    // Check prdata that we are sending to the host
    cdnsdru_asf_parity_check_v1 #(
      .p_data_width (32)
    ) i_chk_prdata (
      .odd_par    (1'b0),
      .data_in    (prdata),
      .parity_in  (prdata_par),
      .parity_err (asf_dap_prdata_err)
    );

    if (p_edma_axi == 1) begin : gen_axi_check
      wire  [128:0] rdata_pad;
      wire  [16:0]  rdata_par_pad;
      wire  [95:0]  rdata_mask;
      wire  [11:0]  rdata_par_mask;
      wire  [127:0] rdata_int;
      wire  [15:0]  rdata_par_int;
      wire          asf_dap_rdata_err_int;
      reg           asf_dap_rdata_err_r;

      assign rdata_par_pad  = {{(17-p_edma_bus_pwid){1'b0}},rdata_par};
      assign rdata_pad      = {{(129-p_edma_bus_width){1'b0}},rdata};

      // Mask out relevant parts of the rdata and parity buses if the full DMA
      // width is not being used. The mask is for 12 bytes as bottom 4 bytes are
      // always used.
      assign rdata_par_mask[3:0]  = dma_bus_width[0]  ? 4'hf        : 4'h0;
      assign rdata_par_mask[11:4] = dma_bus_width[1]  ? 8'hff       : 8'h00;
      assign rdata_mask[31:0]     = dma_bus_width[0]  ? {32{1'b1}}  : {32{1'b0}};
      assign rdata_mask[95:32]    = dma_bus_width[1]  ? {64{1'b1}}  : {64{1'b0}};

      assign rdata_par_int  = rdata_par_pad[15:0] & {rdata_par_mask,4'hf};
      assign rdata_int      = rdata_pad[127:0]    & {rdata_mask,{32{1'b1}}};

      cdnsdru_asf_parity_check_v1 #(
        .p_data_width (128)
      ) i_chk_rdata (
        .odd_par    (1'b0),
        .data_in    (rdata_int),
        .parity_in  (rdata_par_int),
        .parity_err (asf_dap_rdata_err_int)
      );

      // Register based on rvalid.
      always@(posedge aclk or negedge n_areset)
      begin
        if (~n_areset)
          asf_dap_rdata_err_r <= 1'b0;
        else
          asf_dap_rdata_err_r <= asf_dap_rdata_err_int & rvalid;
      end

      assign asf_dap_rdata_err  = asf_dap_rdata_err_r;
    end else begin : gen_no_axi_check
      assign asf_dap_rdata_err  = 1'b0;
    end
  end
  else begin : gen_no_host_par

    if (p_edma_asf_dap_prot) begin : gen_par
      // Generate parity for pwdata
      cdnsdru_asf_parity_gen_v1 #(.p_data_width(32)) i_gen_pwdata_par (
        .odd_par    (1'b0),
        .data_in    (pwdata),
        .data_out   (),
        .parity_out (pwdata_par_int)
      );

      if (p_edma_axi == 1) begin : gen_axi
        cdnsdru_asf_parity_gen_v1 #(.p_data_width(p_edma_bus_width)) i_gen_par (
          .odd_par    (1'b0),
          .data_in    (rdata),
          .data_out   (),
          .parity_out (rdata_par_int)
        );
      end else begin : gen_no_axi
        assign rdata_par_int  = rdata_par;  // Tied already on instantiation.
      end
    end else begin : gen_no_par
      assign pwdata_par_int = 4'h0;
      assign rdata_par_int  = rdata_par;
    end

    assign asf_dap_paddr_err  = 1'b0; // Nothing to check
    assign asf_dap_prdata_err = 1'b0;
    assign asf_dap_rdata_err  = 1'b0;
  end
  endgenerate

  // Parity for FIFO interface is currently generated internally TOIMPRV
  generate if (p_edma_asf_dap_prot == 1) begin : gen_fifo_par
    cdnsdru_asf_parity_gen_v1 #(.p_data_width(2*p_emac_bus_width)) i_gen_par (
      .odd_par    (1'b0),
      .data_in    ({emac_tx_r_data,tx_r_data}),
      .data_out   (),
      .parity_out ({emac_tx_r_data_par,tx_r_data_par})
    );
  end else begin : gen_no_fifo_par
    assign emac_tx_r_data_par = {p_emac_bus_pwid{1'b0}};
    assign tx_r_data_par      = {p_emac_bus_pwid{1'b0}};
  end
  endgenerate

  // Instantiate the MII bridge
  gem_mii_bridge # (.grouped_params(grouped_params))

  i_gem_mii_bridge (

    // Clocks and resets
    .pclk               (pclk),
    .n_preset           (n_preset),
    .gtx_clk            (gtx_clk),
    .n_gtxreset         (n_gtxreset),
    .gtx20_clk          (gtx20_clk),
    .n_gtx20reset       (n_gtx20reset),
    .rbc0               (rbc0),
    .rbc1               (rbc1),
    .n_rbc0reset        (n_rbc0reset),
    .n_rbc1reset        (n_rbc1reset),
    .pcs_rx_clk         (pcs_rx_clk),
    .n_pcs_rxreset      (n_pcs_rxreset),
    .pcs_rx10_clk       (pcs_rx10_clk),
    .n_pcs_rx10reset    (n_pcs_rx10reset),
    .tx_clk             (tx_clk),
    .n_txreset          (n_txreset),
    .rx_clk             (rx_clk),
    .n_rxreset          (n_rxreset),
    .n_tx_clk           (n_tx_clk),
    .n_ntxreset         (n_ntxreset),
    .tx_clk_sig         (tx_clk_sig),
    .n_rx_clk           (n_rx_clk),
    .n_nrxreset         (n_nrxreset),
    .n_ref_reset        (n_ref_reset),
    .ref_clk            (ref_clk),
    .rmii_rx_clk        (rmii_rx_clk),
    .rmii_tx_clk        (rmii_tx_clk),

    // APB Interface signals
    .paddr              (pmac_paddr),
    .prdata             (pmac_prdata_with_mii),
    .prdata_par         (pmac_prdata_par_with_mii),
    .pwdata             (pmac_pwdata),
    .pwdata_par         (pmac_pwdata_par),
    .pwrite             (pmac_pwrite),
    .penable            (pmac_penable),
    .psel               (pmac_psel),
    .perr               (pmac_perr_with_mii),
    .prdata_mac         (pmac_prdata),
    .prdata_par_mac     (pmac_prdata_par),
    .perr_mac           (pmac_perr),

    // PCS dedicated interface signals
    .tx_er_pcs          (tx_er_pcs_to_bridge),
    .txd_pcs            (txd_pcs_to_bridge),
    .txd_par_pcs        (txd_par_pcs_to_bridge),
    .tx_en_pcs          (tx_en_pcs_to_bridge),
    .rxd_pcs            (rxd_pcs_from_bridge),
    .rxd_par_pcs        (rxd_par_pcs_from_bridge),
    .rx_er_pcs          (rx_er_pcs_from_bridge),
    .rx_dv_pcs          (rx_dv_pcs_from_bridge),
    .col_pcs            (col_pcs_from_bridge),
    .crs_pcs            (crs_pcs_from_bridge),
    .alt_sgmii_mode     (alt_sgmii_mode),
    .sgmii_mode         (sgmii_mode),
    .uni_direct_en      (uni_direct_en),
    .retry_test         (retry_test),
    .speed_mode         (speed_mode),
    .tx_lpi_en          (tx_lpi_en),
    .full_duplex        (full_duplex),
    .pcs_link_state     (pcs_link_state),
    .pcs_an_complete    (pcs_an_complete),
    .np_data_int        (np_data_int),
    .mac_pause_tx_en    (mac_pause_tx_en),
    .mac_pause_rx_en    (mac_pause_rx_en),
    .mac_full_duplex    (mac_full_duplex),
    .pcs_cal_bypass     (pcs_cal_bypass),
    .pcs_cgalign_bypass (pcs_cgalign_bypass),
    .tx_group           (tx_group),
    .rx_group           (rx_group),
    .ewrap              (ewrap),
    .en_cdet            (en_cdet),
    .signal_detect      (signal_detect),
    .asf_csr_pcs_err    (asf_csr_pcs_err),
    .asf_dap_pcs_tx_err (asf_dap_pcs_tx_err),
    .asf_dap_pcs_rx_err (asf_dap_pcs_rx_err),
    .link_fault_signal_en(link_fault_signal_en),
    .link_fault_status  (link_fault_status),

    // RGMII interface signals
    .rgmii_txd          (rgmii_txd),
    .rgmii_tx_ctl       (rgmii_tx_ctl),
    .rgmii_rxd          (rgmii_rxd),
    .rgmii_rx_ctl       (rgmii_rx_ctl),
    .rgmii_link_status  (rgmii_link_status),
    .rgmii_speed        (rgmii_speed),
    .rgmii_duplex_out   (rgmii_duplex_out),
    .half_duplex        (half_duplex),

    // GMII/MII interface signals
    .txd                (txd),
    .tx_en              (tx_en),
    .tx_er              (tx_er),
    .rxd                (rxd),
    .rx_dv              (rx_dv),
    .rx_er              (rx_er),
    .col                (col),
    .crs                (crs),
    .mii_select         (mii_select),
    .sel_mii_on_rgmii   (sel_mii_on_rgmii),

    // RMII interface signals
    .rmii_txd           (rmii_txd),
    .rmii_tx_en         (rmii_tx_en),
    .rmii_rxd           (rmii_rxd),
    .rmii_rx_er         (rmii_rx_er),
    .rmii_crs_dv        (rmii_crs_dv),

    // Signals going and coming from/to MMSL
    .rxd_to_mac         (rxd_from_bridge),
    .rxd_par_to_mac     (rxd_par_from_bridge),
    .rx_dv_to_mac       (rx_dv_from_bridge),
    .rx_er_to_mac       (rx_er_from_bridge),
    .col_to_mac         (col_from_bridge),
    .crs_to_mac         (crs_from_bridge),
    .txd_from_mac       (txd_to_bridge),
    //.txd_par_from_mac (txd_par_to_bridge), Commented and not deleted for future enhancements
    .tx_en_from_mac     (tx_en_to_bridge),
    .tx_er_from_mac     (tx_er_to_bridge),

    // Lockup detect signalling
    .lu_det_e_pip       (lu_det_e_pip),
    .lu_det_p_pip       (lu_det_p_pip),
    //.lu_det_p_sop_gate(lu_det_p_sop_gate), Commented and not deleted for future enhancements
    .lu_det_p_eop_gate  (lu_det_p_eop_gate),
    //.emac_tx_sop_pulse(emac_tx_sop_pulse), Commented and not deleted for future enhancements
    .emac_tx_eop_pulse  (emac_tx_eop_pulse),
    //.pmac_tx_sop_pulse(pmac_tx_sop_pulse), Commented and not deleted for future enhancements
    .pmac_tx_eop_pulse  (pmac_tx_eop_pulse)

  );



  // Instantiate the main MAC - when 802.3br functionality is added
  // this is the PMAC
  gem_top #(.grouped_params(grouped_params),
            .p_tx_sram_width(p_tx_sram_width),
            .p_rx_sram_width(p_rx_sram_width))

  i_gem_top (

    .n_txreset                   (n_txreset),
    .tx_clk                      (tx_clk),
    .n_rxreset                   (n_rxreset),
    .rx_clk                      (rx_clk),
    .n_ntxreset                  (n_ntxreset),
    .n_tx_clk                    (n_tx_clk),
    .loopback_local              (loopback_local),
    .rx_br_halt                  (pmac_rx_halt),
    .txd                         (pmac_txd),
    .txd_par                     (pmac_txd_par),
    .tx_en                       (pmac_tx_en),
    .tx_er                       (pmac_tx_er),
    .rxd                         (pmac_rxd),
    .rxd_par                     (pmac_rxd_par),
    .rx_er                       (pmac_rx_er),
    .rx_dv                       (pmac_rx_dv),
    .col                         (col_from_bridge),
    .crs                         (crs_from_bridge),
    .tx_er_pcs                   (pmac_tx_er_pcs),
    .txd_pcs                     (pmac_txd_pcs),
    .txd_par_pcs                 (pmac_txd_par_pcs),
    .tx_en_pcs                   (pmac_tx_en_pcs),
    .rxd_pcs                     (pmac_rxd_pcs),
    .rxd_par_pcs                 (pmac_rxd_par_pcs),
    .rx_er_pcs                   (pmac_rx_er_pcs),
    .rx_dv_pcs                   (pmac_rx_dv_pcs),
    .col_pcs                     (col_pcs_from_bridge),
    .crs_pcs                     (crs_pcs_from_bridge),
    .alt_sgmii_mode              (alt_sgmii_mode),
    .sgmii_mode                  (sgmii_mode),
    .uni_direct_en               (uni_direct_en),
    .pcs_link_state              (pcs_link_state),
    .pcs_an_complete             (pcs_an_complete),
    .np_data_int                 (np_data_int),
    .mac_pause_tx_en             (mac_pause_tx_en),
    .mac_pause_rx_en             (mac_pause_rx_en),
    .mac_full_duplex             (mac_full_duplex),
    .half_duplex                 (half_duplex),
    .speed_mode                  (speed_mode),
    .tx_lpi_en                   (tx_lpi_en),
    .retry_test                  (retry_test),
    .full_duplex                 (full_duplex),
    .sel_mii_on_rgmii            (sel_mii_on_rgmii),
    .add_frag_size               (add_frag_size),
    .txd_frame_size              (pmac_tx_frame_len),
    .txd_rdy                     (pmac_tx_rdy),
    .min_ifg                     (),  // not connected for pMAC
    .mdc                         (mdc),
    .mdio_in                     (mdio_in),
    .mdio_out                    (mdio_out),
    .mdio_en                     (mdio_en),
    .loopback                    (loopback),
    .ext_interrupt_in            (ext_interrupt_in),
    .tx_pause                    (tx_pause),
    .tx_pause_zero               (tx_pause_zero),
    .tx_pfc_sel                  (tx_pfc_sel),
    .tx_pfc_pause                (tx_pfc_pause),
    .tx_pfc_pause_zero           (tx_pfc_pause_zero),
    .pfc_negotiate               (pfc_negotiate),
    .rx_pfc_paused               (rx_pfc_paused),
    .wol                         (wol),
    .trigger_dma_tx_start        (trigger_dma_tx_start),
    .ext_match1                  (ext_match1),
    .ext_match2                  (ext_match2),
    .ext_match3                  (ext_match3),
    .ext_match4                  (ext_match4),
    .ext_da                      (ext_da),
    .ext_da_stb                  (ext_da_stb),
    .ext_sa                      (ext_sa),
    .ext_sa_stb                  (ext_sa_stb),
    .ext_type                    (ext_type),
    .ext_type_stb                (ext_type_stb),
    .ext_ip_sa                   (ext_ip_sa),
    .ext_ip_sa_stb               (ext_ip_sa_stb),
    .ext_ip_da                   (ext_ip_da),
    .ext_ip_da_stb               (ext_ip_da_stb),
    .ext_source_port             (ext_source_port),
    .ext_sp_stb                  (ext_sp_stb),
    .ext_dest_port               (ext_dest_port),
    .ext_dp_stb                  (ext_dp_stb),
    .ext_ipv6                    (ext_ipv6),
    .ext_vlan_tag1               (ext_vlan_tag1),
    .ext_vlan_tag1_stb           (ext_vlan_tag1_stb),
    .ext_vlan_tag2               (ext_vlan_tag2),
    .ext_vlan_tag2_stb           (ext_vlan_tag2_stb),
    .gem_tsu_ms                  (gem_tsu_ms),
    .gem_tsu_inc_ctrl            (gem_tsu_inc_ctrl),
    .tsu_timer_cnt               (tsu_timer_cnt),
    .tsu_timer_cnt_par           (tsu_timer_cnt_par),
    .tsu_timer_cmp_val           (tsu_timer_cmp_val),
    .tsu_clk                     (tsu_clk),
    .n_tsureset                  (n_tsureset),
    .ext_tsu_timer               (ext_tsu_timer),
    .ext_tsu_timer_par           (ext_tsu_timer_par),
    .sof_tx                      (sof_tx),
    .sync_frame_tx               (sync_frame_tx),
    .delay_req_tx                (delay_req_tx),
    .pdelay_req_tx               (pdelay_req_tx),
    .pdelay_resp_tx              (pdelay_resp_tx),
    .sof_rx                      (sof_rx),
    .sync_frame_rx               (sync_frame_rx),
    .delay_req_rx                (delay_req_rx),
    .pdelay_req_rx               (pdelay_req_rx),
    .pdelay_resp_rx              (pdelay_resp_rx),
    .pclk                        (pclk),
    .n_preset                    (n_preset),
    .paddr                       (pmac_paddr),
    .prdata                      (pmac_prdata),
    .prdata_par                  (pmac_prdata_par),
    .pwdata                      (pmac_pwdata),
    .pwdata_par                  (pmac_pwdata_par),
    .pwrite                      (pmac_pwrite),
    .penable                     (pmac_penable),
    .psel                        (pmac_psel),
    .perr                        (pmac_perr),
    .link_fault_signal_en        (link_fault_signal_en),
    .link_fault_status           (link_fault_status),
    .asf_dap_paddr_err           (asf_dap_paddr_err),
    .asf_dap_prdata_err          (asf_dap_prdata_err),
    .asf_dap_rdata_err           (asf_dap_rdata_err),
    .asf_csr_pcs_err             (asf_csr_pcs_err),
    .asf_csr_mmsl_err            (asf_csr_mmsl_err),
    .asf_dap_pcs_tx_err          (asf_dap_pcs_tx_err),
    .asf_dap_pcs_rx_err          (asf_dap_pcs_rx_err),
    .asf_dap_mmsl_tx_err         (asf_dap_mmsl_tx_err),
    .asf_dap_mmsl_rx_err         (asf_dap_mmsl_rx_err),
    .tx_r_data                   (tx_r_data),
    .tx_r_data_par               (tx_r_data_par),
    .tx_r_mod                    (tx_r_mod),
    .tx_r_sop                    (tx_r_sop),
    .tx_r_eop                    (tx_r_eop),
    .tx_r_err                    (tx_r_err),
    .tx_r_rd                     (tx_r_rd),
    .tx_r_queue                  (tx_r_queue),
    .tx_r_valid                  (tx_r_valid),
    .tx_r_data_rdy               (tx_r_data_rdy),
    .tx_r_underflow              (tx_r_underflow),
    .tx_r_flushed                (tx_r_flushed),
    .tx_r_control                (tx_r_control),
    .tx_r_frame_size_vld         (tx_r_frame_size_vld),
    .tx_r_frame_size             (tx_r_frame_size),
    .tx_r_status                 (tx_r_status),
    .tx_r_timestamp              (tx_r_timestamp),
    .dma_tx_status_tog           (dma_tx_status_tog),
    .dma_tx_end_tog              (dma_tx_end_tog),
    .rx_w_wr                     (rx_w_wr),
    .rx_w_data                   (rx_w_data),
    .rx_w_data_par               (),
    .rx_w_mod                    (rx_w_mod),
    .rx_w_sop                    (rx_w_sop),
    .rx_w_eop                    (rx_w_eop),
    .rx_w_err                    (rx_w_err),
    .rx_w_flush                  (rx_w_flush),
    .rx_w_status                 (rx_w_status),
    .rx_w_timestamp              (rx_w_timestamp),
    .add_match_vec               (add_match_vec),
    .rx_w_queue                  (rx_w_queue),
    .rx_w_overflow               (rx_w_overflow),
    .aclk                        (aclk),
    .n_areset                    (n_areset),
    .awid                        (),
    .awaddr                      (pmac_awaddr),
    .awaddr_par                  (pmac_awaddr_par),
    .awlen                       (pmac_awlen),
    .awsize                      (pmac_awsize),
    .awburst                     (pmac_awburst),
    .awlock                      (),
    .awcache                     (pmac_awcache),
    .awprot                      (pmac_awprot),
    .awqos                       (pmac_awqos),
    .awvalid                     (pmac_awvalid),
    .awready                     (pmac_awready),
    .wdata                       (pmac_wdata),
    .wdata_par                   (pmac_wdata_par),
    .wstrb                       (pmac_wstrb),
    .wlast                       (pmac_wlast),
    .wready                      (pmac_wready),
    .wvalid                      (pmac_wvalid),
    .bresp                       (pmac_bresp),
    .bvalid                      (pmac_bvalid),
    .bready                      (pmac_bready),
    .arid                        (),
    .araddr                      (pmac_araddr),
    .araddr_par                  (pmac_araddr_par),
    .arlen                       (pmac_arlen),
    .arsize                      (pmac_arsize),
    .arburst                     (pmac_arburst),
    .arlock                      (),
    .arcache                     (pmac_arcache),
    .arprot                      (pmac_arprot),
    .arqos                       (pmac_arqos),
    .arvalid                     (pmac_arvalid),
    .arready                     (pmac_arready),
    .rdata                       (pmac_rdata),
    .rdata_par                   (pmac_rdata_par),
    .rresp                       (pmac_rresp),
    .rlast                       (pmac_rlast),
    .rvalid                      (pmac_rvalid),
    .rready                      (pmac_rready),
    .hclk                        (hclk),
    .n_hreset                    (n_hreset),
    .hgrant                      (hgrant),
    .hready                      (hready),
    .hresp                       (hresp),
    .hrdata                      (hrdata),
    .hbusreq                     (hbusreq),
    .hlock                       (hlock),
    .haddr                       (haddr),
    .htrans                      (htrans),
    .hwrite                      (hwrite),
    .hsize                       (hsize),
    .hburst                      (hburst),
    .hprot                       (hprot),
    .hwdata                      (hwdata),
    .dma_bus_width               (dma_bus_width),
    .tx_sram_wea                 (tx_sram_wea),
    .tx_sram_ena                 (tx_sram_ena),
    .tx_sram_addra               (tx_sram_addra),
    .tx_sram_dia                 (tx_sram_dia),
    .tx_sram_doa                 (tx_sram_doa),
    .tx_sram_web                 (tx_sram_web),
    .tx_sram_enb                 (tx_sram_enb),
    .tx_sram_addrb               (tx_sram_addrb),
    .tx_sram_dob                 (tx_sram_dob),
    .rx_sram_wea                 (rx_sram_wea),
    .rx_sram_ena                 (rx_sram_ena),
    .rx_sram_addra               (rx_sram_addra),
    .rx_sram_dia                 (rx_sram_dia),
    .rx_sram_doa                 (rx_sram_doa),
    .rx_sram_web                 (rx_sram_web),
    .rx_sram_enb                 (rx_sram_enb),
    .rx_sram_addrb               (rx_sram_addrb),
    .rx_sram_dob                 (rx_sram_dob),
    .user_out                    (user_out),
    .user_in                     (user_in),
    .rx_databuf_wr_q             (rx_databuf_wr_q),
    .halfduplex_flow_control_en  (halfduplex_flow_control_en),
    .ethernet_int_bus            (ethernet_int_bus),
    .enable_transmit             (pmac_tx_enable),
    .enable_receive              (pmac_rx_enable),
    .hold                        (),                  // only the eMAC hold signal is used by MMSL
    //.lu_det_tx_sop_pulse       (pmac_tx_sop_pulse), Commented and not deleted for future enhancements
    .lu_det_tx_eop_pulse         (pmac_tx_eop_pulse),
    .asf_trans_to_en             (asf_trans_to_en),
    .asf_trans_to_time           (asf_trans_to_time),
    .asf_host_trans_to_err       (asf_host_trans_to_err),
    .asf_sram_corr_err           (asf_sram_corr_err),
    .asf_sram_uncorr_err         (asf_sram_uncorr_err),
    .asf_dap_err                 (asf_dap_err),
    .asf_csr_err                 (asf_csr_err),
    .asf_trans_to_err            (asf_trans_to_err),
    .asf_protocol_err            (asf_protocol_err),
    .asf_integrity_err           (asf_integrity_err),
    .asf_int_nonfatal            (asf_int_nonfatal),
    .asf_int_fatal               (asf_int_fatal)

  );

  // If DMA is configured and ASF transaction timeout monitoring
  // enabled, then instantiate the AHB/AXI transaction monitor.
  generate if ((p_edma_tx_pkt_buffer == 1) &&
                (p_edma_asf_trans_to_prot == 1)) begin : gen_trans_to_prot
    wire  amba_clk, amba_rst_n;
    if (p_edma_axi == 1) begin : gen_axi_clk
      assign amba_clk   = aclk;
      assign amba_rst_n = n_areset;
    end else begin : gen_ahb_clk
      assign amba_clk   = hclk;
      assign amba_rst_n = n_hreset;
    end

    edma_amba_trans_to #(
      .p_edma_axi (p_edma_axi),
      .p_axi_id   (4'h0)
    ) i_trans_to (
      .amba_clk         (amba_clk),
      .amba_rst_n       (amba_rst_n),
      .trans_to_en      (asf_trans_to_en),
      .trans_to_timeval (asf_trans_to_time),
      .htrans           (htrans),
      .hready           (hready),
      .awid             (awid),
      .awvalid          (awvalid),
      .awready          (awready),
      .bid              (bid),
      .bvalid           (bvalid),
      .bready           (bready),
      .arid             (arid),
      .arvalid          (arvalid),
      .arready          (arready),
      .rid              (rid),
      .rvalid           (rvalid),
      .rlast            (rlast),
      .rready           (rready),
      .asf_host_trans_to(asf_host_trans_to_err)
    );

  end else begin : gen_no_trans_to_prot
    assign asf_host_trans_to_err  = 1'b0;
  end
  endgenerate

  // 802.3 BR functionality
  generate if (p_edma_has_br == 1'b1) begin : gen_has_802p3_br

    // ASF transaction timeout control
    wire         emac_asf_trans_to_en;
    wire  [15:0] emac_asf_trans_to_time;
    wire         emac_asf_host_trans_to_err;

    // APB Ports
    wire        mmsl_psel;
    wire        mmsl_penable;
    wire  [7:2] mmsl_paddr;
    wire        mmsl_pwrite;
    wire [31:0] mmsl_pwdata;
    wire  [3:0] mmsl_pwdata_par;
    wire [31:0] mmsl_prdata;
    wire  [3:0] mmsl_prdata_par;
    wire        mmsl_perr;

    wire        emac_psel;
    wire        emac_penable;
    wire [11:2] emac_paddr;
    wire        emac_pwrite;
    wire [31:0] emac_pwdata;
    wire  [3:0] emac_pwdata_par;
    wire [31:0] emac_prdata;
    wire  [3:0] emac_prdata_par;
    wire        emac_perr;

    // AXI Ports
    // AW
    //wire   [3:0]              emac_awid;
    wire  [p_edma_addr_width-1:0] emac_awaddr;
    wire   [p_edma_addr_pwid-1:0] emac_awaddr_par;
    wire                    [7:0] emac_awlen;
    wire                    [2:0] emac_awsize;
    wire                    [1:0] emac_awburst;
    wire                    [3:0] emac_awcache;
    wire                    [2:0] emac_awprot;
    wire                    [3:0] emac_awqos;
    wire                          emac_awvalid;
    wire                          emac_awready;
    // W
    //wire   [3:0]              emac_wid;
    wire   [p_edma_bus_width-1:0] emac_wdata;
    wire    [p_edma_bus_pwid-1:0] emac_wdata_par;
    wire [p_edma_bus_width/8-1:0] emac_wstrb;
    wire                          emac_wlast;
    wire                          emac_wvalid;
    wire                          emac_wready;
    // B
    wire                    [1:0] emac_bresp;
    wire                          emac_bvalid;
    wire                          emac_bready;
    // AR
    //wire   [3:0]              emac_arid;
    wire [p_edma_addr_width-1:0] emac_araddr;
    wire  [p_edma_addr_pwid-1:0] emac_araddr_par;
    wire                   [7:0] emac_arlen;
    wire                   [2:0] emac_arsize;
    wire                   [1:0] emac_arburst;
    wire                   [3:0] emac_arcache;
    wire                   [2:0] emac_arprot;
    wire                   [3:0] emac_arqos;
    wire                         emac_arvalid;
    wire                         emac_arready;
    // R
    //wire   [3:0]              emac_rid;
    wire [p_edma_bus_width-1:0] emac_rdata;
    wire  [p_edma_bus_pwid-1:0] emac_rdata_par;
    wire                  [1:0] emac_rresp;
    wire                        emac_rlast;
    wire                        emac_rvalid;
    wire                        emac_rready;
    reg                         emac_tx_en_muxed;
    reg                         emac_tx_er_muxed;
    reg                   [7:0] emac_txd_muxed;
    reg                         emac_txd_par_muxed;
    reg                         pmac_tx_en_muxed;
    reg                         pmac_tx_er_muxed;
    reg                   [7:0] pmac_txd_muxed;
    reg                         pmac_txd_par_muxed;
    wire                  [7:0] txd_to_demux;
    wire                        txd_par_to_demux;
    wire                        tx_en_to_demux;
    wire                        tx_er_to_demux;
    wire                        emac_tx_enable;
    wire                        emac_rx_enable;
    wire                 [15:0] emac_ethernet_int_pad;
    wire                        switch_rx_pmac_emac;
    wire                        rx_dv_extended_to_mmsl;
    wire                  [1:0] rx_dv_pcs_extended_to_mmsl;
    wire                        emac_tx_en_extended_to_mmsl;
    wire                        pmac_tx_en_extended_to_mmsl;
    reg                         emac_rx_dv;
    reg                         emac_rx_er;
    reg                   [7:0] emac_rxd;
    reg                         emac_rxd_par;
    reg                   [1:0] emac_rx_dv_pcs;
    reg                   [1:0] emac_rx_er_pcs;
    reg                  [15:0] emac_rxd_pcs;
    reg                   [1:0] emac_rxd_par_pcs;

    assign enable_transmit = emac_tx_enable || pmac_tx_enable;
    assign enable_receive  = emac_rx_enable || pmac_rx_enable;

    // MMSL TX input mux:
    // We need to assign the MMSL inputs for the TX side according to
    // the PCS mode or GMII mode. Either ways it's a 8 bit signal so the
    // MMSL treat them exactly the same.
    always @ *
    begin
      if(speed_mode[2])
        begin
          emac_tx_en_muxed   = emac_tx_en_pcs;
          emac_tx_er_muxed   = emac_tx_er_pcs;
          emac_txd_muxed     = emac_txd_pcs;
          emac_txd_par_muxed = emac_txd_par_pcs;

          pmac_tx_en_muxed   = pmac_tx_en_pcs;
          pmac_tx_er_muxed   = pmac_tx_er_pcs;
          pmac_txd_muxed     = pmac_txd_pcs;
          pmac_txd_par_muxed = pmac_txd_par_pcs;
        end
      else
        begin
          emac_tx_en_muxed   = emac_tx_en;
          emac_tx_er_muxed   = emac_tx_er;
          emac_txd_muxed     = emac_txd;
          emac_txd_par_muxed = emac_txd_par;

          pmac_tx_en_muxed   = pmac_tx_en;
          pmac_tx_er_muxed   = pmac_tx_er;
          pmac_txd_muxed     = pmac_txd;
          pmac_txd_par_muxed = pmac_txd_par;
        end
    end

    // if half_duplex is enabled then we want to pass through also the signaling for the carrier extension and we will do so
    // tricking the MMSL to think that the data_valid signal is actually extended to the end of this signaling and does not
    // go low when rx_dv_from_bridge goes low. Actually this signal will be passed to the MMSL along the regular rx_dv
    // because we need to use the extended versions only in some cases for a correct behaviour.
    // This signaling will only be received directly after a frame, and they can't be received alone otherwise this will cause
    // problems in the MMSL if this signaling is received between a preemptible start and a preemptible continuation frame.
    // RX:
    assign rx_dv_extended_to_mmsl        = rx_dv_from_bridge        || (half_duplex && rx_er_from_bridge        && ((rxd_from_bridge           == 8'h0f) || (rxd_from_bridge           == 8'h1f)));
    assign rx_dv_pcs_extended_to_mmsl[1] = rx_dv_pcs_from_bridge[1] || (half_duplex && rx_er_pcs_from_bridge[1] && ((rxd_pcs_from_bridge[15:8] == 8'h0f) || (rxd_pcs_from_bridge[15:8] == 8'h1f)));
    assign rx_dv_pcs_extended_to_mmsl[0] = rx_dv_pcs_from_bridge[0] || (half_duplex && rx_er_pcs_from_bridge[0] && ((rxd_pcs_from_bridge[7:0]  == 8'h0f) || (rxd_pcs_from_bridge[7:0]  == 8'h1f)));

    // TX: Similar concept to the RX.
    assign emac_tx_en_extended_to_mmsl = emac_tx_en_muxed || (half_duplex && emac_tx_er_muxed && ((emac_txd_muxed == 8'h0f)||(emac_txd_muxed == 8'h1f)));
    assign pmac_tx_en_extended_to_mmsl = pmac_tx_en_muxed || (half_duplex && pmac_tx_er_muxed && ((pmac_txd_muxed == 8'h0f)||(pmac_txd_muxed == 8'h1f)));

    // Instantiate gem_mmsl
    gem_mmsl #(
      .p_edma_asf_dap_prot   (p_edma_asf_dap_prot),
      .p_edma_asf_csr_prot   (p_edma_asf_csr_prot),
      .p_edma_asf_host_par   (p_edma_asf_host_par),
      .p_edma_irq_read_clear (p_edma_irq_read_clear)
    ) i_gem_mmsl (

      .pclk                (pclk),
      .tx_clk              (tx_clk),
      .rx_clk              (rx_clk),
      .n_preset            (n_preset),
      .n_txreset           (n_txreset),
      .n_rxreset           (n_rxreset),

      .psel                (mmsl_psel),
      .penable             (mmsl_penable),
      .paddr               (mmsl_paddr),
      .pwrite              (mmsl_pwrite),
      .pwdata              (mmsl_pwdata),
      .pwdata_par          (mmsl_pwdata_par),
      .prdata              (mmsl_prdata),
      .prdata_par          (mmsl_prdata_par),
      .pslverr             (mmsl_perr),

      .tx_enable           (enable_transmit),
      .rx_enable           (enable_receive),
      .emac_tx_en          (emac_tx_en_muxed),
      .emac_tx_en_extended (emac_tx_en_extended_to_mmsl),
      .emac_tx_er          (emac_tx_er_muxed),
      .emac_txd            (emac_txd_muxed),
      .emac_txd_par        (emac_txd_par_muxed),
      .emac_tx_rdy         (emac_tx_rdy),
      .emac_rx_dv          (emac_pmux_rx_dv),
      .emac_rx_er          (emac_pmux_rx_er),
      .emac_rxd            (emac_pmux_rxd),
      .emac_rxd_par        (emac_pmux_rxd_par),
      .emac_rx_dv_pcs      (emac_pmux_rx_dv_pcs),
      .emac_rx_er_pcs      (emac_pmux_rx_er_pcs),
      .emac_rxd_pcs        (emac_pmux_rxd_pcs),
      .emac_rxd_par_pcs    (emac_pmux_rxd_par_pcs),

      .pmac_tx_en          (pmac_tx_en_muxed),
      .pmac_tx_en_extended (pmac_tx_en_extended_to_mmsl),
      .pmac_tx_er          (pmac_tx_er_muxed),
      .pmac_txd            (pmac_txd_muxed),
      .pmac_txd_par        (pmac_txd_par_muxed),
      .pmac_tx_frame_len   (pmac_tx_frame_len),
      .pmac_tx_rdy         (pmac_tx_rdy),
      .pmac_rx_halt        (pmac_pmux_rx_halt),
      .pmac_rx_dv          (pmac_pmux_rx_dv),
      .pmac_rx_er          (pmac_pmux_rx_er),
      .pmac_rxd            (pmac_pmux_rxd),
      .pmac_rxd_par        (pmac_pmux_rxd_par),
      .pmac_rx_dv_pcs      (pmac_pmux_rx_dv_pcs),
      .pmac_rx_er_pcs      (pmac_pmux_rx_er_pcs),
      .pmac_rxd_pcs        (pmac_pmux_rxd_pcs),
      .pmac_rxd_par_pcs    (pmac_pmux_rxd_par_pcs),

      .rx_dv               (rx_dv_from_bridge),
      .rx_dv_extended      (rx_dv_extended_to_mmsl),
      .rx_er               (rx_er_from_bridge),
      .rxd                 (rxd_from_bridge),
      .rxd_par             (rxd_par_from_bridge),
      .rx_dv_pcs           (rx_dv_pcs_from_bridge),
      .rx_dv_pcs_extended  (rx_dv_pcs_extended_to_mmsl),
      .rx_er_pcs           (rx_er_pcs_from_bridge),
      .rxd_pcs             (rxd_pcs_from_bridge),
      .rxd_par_pcs         (rxd_par_pcs_from_bridge),

      .tx_en               (tx_en_to_demux),
      .tx_er               (tx_er_to_demux),
      .txd                 (txd_to_demux),
      .txd_par             (txd_par_to_demux),

      .hold                (hold),
      .speed_mode          (speed_mode),
      .min_ifg             (min_ifg),   // use min_ifg from the eMAC stretch ratio register at 0x10bc to control the IPG in the MMSL
      .add_frag_size       (add_frag_size),
      .mmsl_int            (mmsl_int),
      .switch_rx_pmac_emac (switch_rx_pmac_emac),
      .asf_csr_mmsl_err    (asf_csr_mmsl_err),
      .asf_dap_mmsl_tx_err (asf_dap_mmsl_tx_err),
      .asf_dap_mmsl_rx_err (asf_dap_mmsl_rx_err),
      .e_pip               (lu_det_e_pip),
      .p_pip               (lu_det_p_pip),
      .p_sop_gate          (), // this MMSL output is left unconnected but it
                               // will be used for possible future enhancements
      .p_eop_gate          (lu_det_p_eop_gate)

    );

    // MMSL TX output demux:
    // The MMSL Output for the TX side could be
    // addressed to the PCS interface or the GMII interface
    // depending on the PCS mode (speed_mode[2])
    // txd_par_to_bridge is commented but not deleted because
    // it could be used for future enhancements
    always @ *
    begin
      if(speed_mode[2])
        begin
          txd_to_bridge         = 8'h00;
          //txd_par_to_bridge   = 1'b0;
          tx_en_to_bridge       = 1'b0;
          tx_er_to_bridge       = 1'b0;

          txd_pcs_to_bridge     = txd_to_demux;
          txd_par_pcs_to_bridge = txd_par_to_demux;
          tx_en_pcs_to_bridge   = tx_en_to_demux;
          tx_er_pcs_to_bridge   = tx_er_to_demux;
        end
      else
        begin
          txd_to_bridge         = txd_to_demux;
          //txd_par_to_bridge   = txd_par_to_demux;
          tx_en_to_bridge       = tx_en_to_demux;
          tx_er_to_bridge       = tx_er_to_demux;

          txd_pcs_to_bridge     = 8'h00;
          txd_par_pcs_to_bridge = 1'b0;
          tx_en_pcs_to_bridge   = 1'b0;
          tx_er_pcs_to_bridge   = 1'b0;
        end
    end

    // Until we see the first frame with an SMD other than d5, route all receive frames
    // to PMAC. We need to do this to ensure we support receive frames with queue support
    // until the link partner has successfully started transmitted frames with 802.3br enabled
    always @ *
    begin
      if(switch_rx_pmac_emac)
        begin
          pmac_rx_halt     = 1'b0;
          pmac_rx_dv       = emac_pmux_rx_dv;
          pmac_rx_er       = emac_pmux_rx_er;
          pmac_rxd         = emac_pmux_rxd;
          pmac_rxd_par     = emac_pmux_rxd_par;
          pmac_rx_dv_pcs   = emac_pmux_rx_dv_pcs;
          pmac_rx_er_pcs   = emac_pmux_rx_er_pcs;
          pmac_rxd_pcs     = emac_pmux_rxd_pcs;
          pmac_rxd_par_pcs = emac_pmux_rxd_par_pcs;
          emac_rx_dv       = 1'b0;
          emac_rx_er       = 1'b0;
          emac_rxd         = 8'h00;
          emac_rxd_par     = 1'b0;
          emac_rx_dv_pcs   = 2'b00;
          emac_rx_er_pcs   = 2'b00;
          emac_rxd_pcs     = 16'h0000;
          emac_rxd_par_pcs = 2'b00;
        end
      else
        begin
          pmac_rx_halt     = pmac_pmux_rx_halt;
          pmac_rx_dv       = pmac_pmux_rx_dv;
          pmac_rx_er       = pmac_pmux_rx_er;
          pmac_rxd         = pmac_pmux_rxd;
          pmac_rxd_par     = pmac_pmux_rxd_par;
          pmac_rx_dv_pcs   = pmac_pmux_rx_dv_pcs;
          pmac_rx_er_pcs   = pmac_pmux_rx_er_pcs;
          pmac_rxd_pcs     = pmac_pmux_rxd_pcs;
          pmac_rxd_par_pcs = pmac_pmux_rxd_par_pcs;
          emac_rx_dv       = emac_pmux_rx_dv;
          emac_rx_er       = emac_pmux_rx_er;
          emac_rxd         = emac_pmux_rxd;
          emac_rxd_par     = emac_pmux_rxd_par;
          emac_rx_dv_pcs   = emac_pmux_rx_dv_pcs;
          emac_rx_er_pcs   = emac_pmux_rx_er_pcs;
          emac_rxd_pcs     = emac_pmux_rxd_pcs;
          emac_rxd_par_pcs = emac_pmux_rxd_par_pcs;
        end
    end

    // Instantiate gem_mmsl_apb_switch
    gem_mmsl_apb_switch i_gem_mmsl_apb_switch (

      .psel           (psel),
      .penable        (penable),
      .paddr          (paddr[12:2]),
      .pwrite         (pwrite),
      .pwdata         (pwdata),
      .pwdata_par     (pwdata_par_int),
      .pslverr        (perr),
      .prdata         (prdata),
      .prdata_par     (prdata_par),

      .mmsl_psel      (mmsl_psel),
      .mmsl_penable   (mmsl_penable),
      .mmsl_paddr     (mmsl_paddr),
      .mmsl_pwrite    (mmsl_pwrite),
      .mmsl_pwdata    (mmsl_pwdata),
      .mmsl_pwdata_par(mmsl_pwdata_par),
      .mmsl_pslverr   (mmsl_perr),
      .mmsl_prdata    (mmsl_prdata),
      .mmsl_prdata_par(mmsl_prdata_par),

      .pmac_psel      (pmac_psel),
      .pmac_penable   (pmac_penable),
      .pmac_paddr     (pmac_paddr),
      .pmac_pwrite    (pmac_pwrite),
      .pmac_pwdata    (pmac_pwdata),
      .pmac_pwdata_par(pmac_pwdata_par),
      .pmac_pslverr   (pmac_perr_with_mii),
      .pmac_prdata    (pmac_prdata_with_mii),
      .pmac_prdata_par(pmac_prdata_par_with_mii),

      .emac_psel      (emac_psel),
      .emac_penable   (emac_penable),
      .emac_paddr     (emac_paddr),
      .emac_pwrite    (emac_pwrite),
      .emac_pwdata    (emac_pwdata),
      .emac_pwdata_par(emac_pwdata_par),
      .emac_pslverr   (emac_perr),
      .emac_prdata    (emac_prdata),
      .emac_prdata_par(emac_prdata_par)

    );

    // Instantiate edma_axi_arbiter
    if(p_edma_ext_fifo_interface == 0 && p_edma_axi == 1) begin: gen_axi_arbiter
    edma_axi_arbiter #(
       .AW             (p_edma_addr_width),
       .DW             (p_edma_bus_width),
       .IW             (3),  // Assume the PMAC and EMAC only have 3 ID's for now. This will create 4 at toplevel.
       .AXI4           (1),
       .AXI_WIC        (2**p_edma_axi_access_pipeline_bits),
       .AXI_WIC_WIDTH  (p_edma_axi_access_pipeline_bits),
       .AXI_RIC        (2**p_edma_axi_access_pipeline_bits),
       .AXI_RIC_WIDTH  (p_edma_axi_access_pipeline_bits)
     ) i_edma_axi_arbiter (

      .aclk           (aclk),
      .n_areset       (n_areset),

      .emac_awid      (3'h0),
      .emac_awaddr    (emac_awaddr),
      .emac_awaddr_par(emac_awaddr_par),
      .emac_awlen     (emac_awlen),
      .emac_awsize    (emac_awsize),
      .emac_awburst   (emac_awburst),
      .emac_awlock    (1'b0),
      .emac_awcache   (emac_awcache),
      .emac_awprot    (emac_awprot),
      .emac_awqos     (emac_awqos),
      .emac_awregion  (4'h0),
      .emac_awvalid   (emac_awvalid),
      .emac_awready   (emac_awready),

      .emac_wid       (3'h0),
      .emac_wdata     (emac_wdata),
      .emac_wdata_par (emac_wdata_par),
      .emac_wstrb     (emac_wstrb),
      .emac_wlast     (emac_wlast),
      .emac_wvalid    (emac_wvalid),
      .emac_wready    (emac_wready),

      .emac_bid       (),
      .emac_bresp     (emac_bresp),
      .emac_bvalid    (emac_bvalid),

      .emac_arid      (3'h0),
      .emac_araddr    (emac_araddr),
      .emac_araddr_par(emac_araddr_par),
      .emac_arlen     (emac_arlen),
      .emac_arsize    (emac_arsize),
      .emac_arburst   (emac_arburst),
      .emac_arlock    (1'b0),
      .emac_arcache   (emac_arcache),
      .emac_arprot    (emac_arprot),
      .emac_arqos     (emac_arqos),
      .emac_arregion  (4'h0),
      .emac_arvalid   (emac_arvalid),
      .emac_arready   (emac_arready),

      .emac_rid       (),
      .emac_rdata     (emac_rdata),
      .emac_rdata_par (emac_rdata_par),
      .emac_rresp     (emac_rresp),
      .emac_rlast     (emac_rlast),
      .emac_rvalid    (emac_rvalid),
      .emac_rready    (emac_rready),


      .pmac_awid      (3'h0),
      .pmac_awaddr    (pmac_awaddr),
      .pmac_awaddr_par(pmac_awaddr_par),
      .pmac_awlen     (pmac_awlen),
      .pmac_awsize    (pmac_awsize),
      .pmac_awburst   (pmac_awburst),
      .pmac_awlock    (1'b0),
      .pmac_awcache   (pmac_awcache),
      .pmac_awprot    (pmac_awprot),
      .pmac_awqos     (pmac_awqos),
      .pmac_awregion  (4'h0),
      .pmac_awvalid   (pmac_awvalid),
      .pmac_awready   (pmac_awready),

      .pmac_wid       (3'h0),
      .pmac_wdata     (pmac_wdata),
      .pmac_wdata_par (pmac_wdata_par),
      .pmac_wstrb     (pmac_wstrb),
      .pmac_wlast     (pmac_wlast),
      .pmac_wvalid    (pmac_wvalid),
      .pmac_wready    (pmac_wready),

      .pmac_bid       (),
      .pmac_bresp     (pmac_bresp),
      .pmac_bvalid    (pmac_bvalid),

      .pmac_arid      (3'h0),
      .pmac_araddr    (pmac_araddr),
      .pmac_araddr_par(pmac_araddr_par),
      .pmac_arlen     (pmac_arlen),
      .pmac_arsize    (pmac_arsize),
      .pmac_arburst   (pmac_arburst),
      .pmac_arlock    (1'b0),
      .pmac_arcache   (pmac_arcache),
      .pmac_arprot    (pmac_arprot),
      .pmac_arqos     (pmac_arqos),
      .pmac_arregion  (4'h0),
      .pmac_arvalid   (pmac_arvalid),
      .pmac_arready   (pmac_arready),


      .pmac_rid       (),
      .pmac_rdata     (pmac_rdata),
      .pmac_rdata_par (pmac_rdata_par),
      .pmac_rresp     (pmac_rresp),
      .pmac_rlast     (pmac_rlast),
      .pmac_rvalid    (pmac_rvalid),
      .pmac_rready    (pmac_rready),

      .awid           (awid),
      .awaddr         (awaddr),
      .awaddr_par     (awaddr_par),
      .awlen          (awlen),
      .awsize         (awsize),
      .awburst        (awburst),
      .awlock         (),
      .awcache        (awcache),
      .awprot         (awprot),
      .awregion       (),
      .awqos          (awqos),
      .awvalid        (awvalid),
      .awready        (awready),

      .wid            (wid),
      .wdata          (wdata),
      .wdata_par      (wdata_par),
      .wstrb          (wstrb),
      .wlast          (wlast),
      .wvalid         (wvalid),
      .wready         (wready),

      .bid            (bid),
      .bresp          (bresp),
      .bvalid         (bvalid),
      .bready         (bready),

      .arid           (arid),
      .araddr         (araddr),
      .araddr_par     (araddr_par),
      .arlen          (arlen),
      .arsize         (arsize),
      .arburst        (arburst),
      .arlock         (),
      .arcache        (arcache),
      .arprot         (arprot),
      .arregion       (),
      .arqos          (arqos),
      .arvalid        (arvalid),
      .arready        (arready),

      .rid            (rid),
      .rdata          (rdata),
      .rdata_par      (rdata_par_int),
      .rresp          (rresp),
      .rlast          (rlast),
      .rvalid         (rvalid),
      .rready         (rready)

    );
    end else begin: gen_no_axi_arbiter

      assign emac_awready  = 1'b0;
      assign emac_wready   = 1'b0;
      assign emac_bresp    = 2'b00;
      assign emac_bvalid   = 1'b0;
      assign emac_arready  = 1'b0;
      assign emac_rdata    = {p_edma_bus_width{1'b0}};
      assign emac_rdata_par= {p_edma_bus_pwid{1'b0}};
      assign emac_rresp    = 2'b00;
      assign emac_rlast    = 1'b0;
      assign emac_rvalid   = 1'b0;

      assign pmac_awready  = 1'b0;
      assign pmac_wready   = 1'b0;
      assign pmac_bresp    = 2'b00;
      assign pmac_bvalid   = 1'b0;
      assign pmac_arready  = 1'b0;
      assign pmac_rdata    = {p_edma_bus_width{1'b0}};
      assign pmac_rdata_par= {p_edma_bus_pwid{1'b0}};
      assign pmac_rresp    = 2'b00;
      assign pmac_rlast    = 1'b0;
      assign pmac_rvalid   = 1'b0;

      assign awid          = 4'h0;
      assign awaddr        = {p_edma_addr_width{1'b0}};
      assign awaddr_par    = {p_edma_addr_pwid{1'b0}};
      assign awlen         = 8'h00;
      assign awsize        = 3'd0;
      assign awburst       = 2'd0;
      assign awcache       = 4'd0;
      assign awprot        = 3'd0;
      assign awvalid       = 1'b0;
      assign awqos         = 4'd0;
      assign wdata         = {p_edma_bus_width{1'b0}};
      assign wdata_par     = {p_edma_bus_pwid{1'b0}};
      assign wstrb         = {(p_edma_bus_width/8){1'b0}};
      assign wlast         = 1'b0;
      assign wid           = 4'h0;
      assign wvalid        = 1'b0;
      assign bready        = 1'b0;
      assign arid          = 4'd0;
      assign araddr        = {p_edma_addr_width{1'b0}};
      assign araddr_par    = {p_edma_addr_pwid{1'b0}};
      assign arlen         = 8'h00;
      assign arsize        = 3'd0;
      assign arburst       = 2'd0;
      assign arcache       = 4'h0;
      assign arprot        = 3'd0;
      assign arvalid       = 1'b0;
      assign arqos         = 4'd0;
      assign rready        = 1'b0;
    end

    // Instantiate EMAC
    gem_top #(.grouped_params(emac_grouped_params),
             .p_tx_sram_width(p_emac_tx_sram_width),
             .p_rx_sram_width(p_emac_rx_sram_width))

    i_gem_top (

      .n_txreset                   (n_txreset),
      .tx_clk                      (tx_clk),
      .n_rxreset                   (n_rxreset),
      .rx_clk                      (rx_clk),
      .n_ntxreset                  (n_ntxreset),
      .n_tx_clk                    (n_tx_clk),
      .loopback_local              (),
      .rx_br_halt                  (1'b0),
      .txd                         (emac_txd),         // Going to the MUX and then to mmsl
      .txd_par                     (emac_txd_par),
      .tx_en                       (emac_tx_en),       // Going to the MUX and then to mmsl
      .tx_er                       (emac_tx_er),       // Going to the MUX and then to mmsl
      .rxd                         (emac_rxd),         // Coming from mmsl
      .rxd_par                     (emac_rxd_par),
      .rx_er                       (emac_rx_er),       // Coming from mmsl
      .rx_dv                       (emac_rx_dv),       // Coming from mmsl
      .col                         (1'b0),
      .crs                         (1'b0),
      .tx_er_pcs                   (emac_tx_er_pcs),   // Going to MUX, then to mmsl
      .txd_pcs                     (emac_txd_pcs),     // Going to MUX, then to mmsl
      .txd_par_pcs                 (emac_txd_par_pcs),
      .tx_en_pcs                   (emac_tx_en_pcs),   // Going to MUX, then to mmsl
      .rxd_pcs                     (emac_rxd_pcs),     // Coming from mmsl
      .rxd_par_pcs                 (emac_rxd_par_pcs),
      .rx_er_pcs                   (emac_rx_er_pcs),   // Coming from mmsl
      .rx_dv_pcs                   (emac_rx_dv_pcs),   // Coming from mmsl
      .col_pcs                     (1'b0),
      .crs_pcs                     (1'b0),
      .alt_sgmii_mode              (),                 // Going to gem_mii_bridge
      .sgmii_mode                  (),                 // Going to gem_mii_bridge
      .uni_direct_en               (),                 // Going to gem_mii_bridge
      .pcs_link_state              (pcs_link_state),   // Coming from gem_mii_bridge
      .pcs_an_complete             (pcs_an_complete),  // Coming from gem_mii_bridge
      .np_data_int                 (np_data_int),      // Coming from gem_mii_bridge
      .mac_pause_tx_en             (mac_pause_tx_en),  // Coming from gem_mii_bridge
      .mac_pause_rx_en             (mac_pause_rx_en),  // Coming from gem_mii_bridge
      .mac_full_duplex             (mac_full_duplex),  // Coming from gem_mii_bridge
      .half_duplex                 (),
      .speed_mode                  (),
      .tx_lpi_en                   (),
      .retry_test                  (),
      .full_duplex                 (),
      .add_frag_size               (add_frag_size),
      .txd_frame_size              (),
      .txd_rdy                     (emac_tx_rdy),
      .min_ifg                     (min_ifg),   // use min_ifg from the eMAC stretch ratio register at 0x10bc to control the IPG in the MMSL
      .sel_mii_on_rgmii            (),

      .mdc                         (),
      .mdio_in                     (1'b0),
      .mdio_out                    (),
      .mdio_en                     (),

      .loopback                    (),
      .ext_interrupt_in            (1'b0),
      .tx_pause                    (1'b0),
      .tx_pause_zero               (1'b0),
      .tx_pfc_sel                  (1'b0),
      .tx_pfc_pause                (8'h00),
      .tx_pfc_pause_zero           (8'h00),
      .pfc_negotiate               (),
      .rx_pfc_paused               (),
      .wol                         (),
      .trigger_dma_tx_start        (trigger_dma_tx_start),

      .ext_match1                  (1'b0),
      .ext_match2                  (1'b0),
      .ext_match3                  (1'b0),
      .ext_match4                  (1'b0),

      .ext_da                      (),
      .ext_da_stb                  (),
      .ext_sa                      (),
      .ext_sa_stb                  (),
      .ext_type                    (),
      .ext_type_stb                (),
      .ext_ip_sa                   (),
      .ext_ip_sa_stb               (),
      .ext_ip_da                   (),
      .ext_ip_da_stb               (),
      .ext_source_port             (),
      .ext_sp_stb                  (),
      .ext_dest_port               (),
      .ext_dp_stb                  (),
      .ext_ipv6                    (),
      .ext_vlan_tag1               (),
      .ext_vlan_tag1_stb           (),
      .ext_vlan_tag2               (),
      .ext_vlan_tag2_stb           (),

      .gem_tsu_ms                  (1'b0),
      .gem_tsu_inc_ctrl            (2'b00),
      .tsu_timer_cnt               (),
      .tsu_timer_cnt_par           (),
      .tsu_timer_cmp_val           (),
      .tsu_clk                     (tsu_clk),
      .n_tsureset                  (n_tsureset),
      .ext_tsu_timer               (tsu_timer_cnt),
      .ext_tsu_timer_par           (tsu_timer_cnt_par),
      .sof_tx                      (),
      .sync_frame_tx               (),
      .delay_req_tx                (),
      .pdelay_req_tx               (),
      .pdelay_resp_tx              (),
      .sof_rx                      (),
      .sync_frame_rx               (),
      .delay_req_rx                (),
      .pdelay_req_rx               (),
      .pdelay_resp_rx              (),
      .pclk                        (pclk),
      .n_preset                    (n_preset),
      .paddr                       (emac_paddr),
      .prdata                      (emac_prdata),
      .prdata_par                  (emac_prdata_par),
      .pwdata                      (emac_pwdata),
      .pwdata_par                  (emac_pwdata_par),
      .pwrite                      (emac_pwrite),
      .penable                     (emac_penable),
      .psel                        (emac_psel),
      .perr                        (emac_perr),
      .link_fault_signal_en        (link_fault_signal_en),
      .link_fault_status           (link_fault_status),
      .asf_dap_paddr_err           (asf_dap_paddr_err),
      .asf_dap_prdata_err          (asf_dap_prdata_err),
      .asf_dap_rdata_err           (asf_dap_rdata_err),
      .asf_csr_pcs_err             (asf_csr_pcs_err),
      .asf_csr_mmsl_err            (asf_csr_mmsl_err),
      .asf_dap_pcs_tx_err          (asf_dap_pcs_tx_err),
      .asf_dap_pcs_rx_err          (asf_dap_pcs_rx_err),
      .asf_dap_mmsl_tx_err         (asf_dap_mmsl_tx_err),
      .asf_dap_mmsl_rx_err         (asf_dap_mmsl_rx_err),
      .tx_r_data                   (emac_tx_r_data),
      .tx_r_data_par               (emac_tx_r_data_par),
      .tx_r_mod                    (emac_tx_r_mod),
      .tx_r_sop                    (emac_tx_r_sop),
      .tx_r_eop                    (emac_tx_r_eop),
      .tx_r_err                    (emac_tx_r_err),
      .tx_r_valid                  (emac_tx_r_valid),
      .tx_r_data_rdy               (emac_tx_r_data_rdy),
      .tx_r_underflow              (emac_tx_r_underflow),
      .tx_r_rd                     (emac_tx_r_rd),
      .tx_r_queue                  (emac_tx_r_queue),
      .tx_r_flushed                (emac_tx_r_flushed),
      .tx_r_control                (emac_tx_r_control),
      .tx_r_status                 (emac_tx_r_status),
      .tx_r_frame_size_vld         (emac_tx_r_frame_size_vld),
      .tx_r_frame_size             (emac_tx_r_frame_size),
      .tx_r_timestamp              (emac_tx_r_timestamp),
      .dma_tx_status_tog           (emac_dma_tx_status_tog),
      .dma_tx_end_tog              (emac_dma_tx_end_tog),
      .rx_w_wr                     (emac_rx_w_wr),
      .rx_w_data                   (emac_rx_w_data),
      .rx_w_data_par               (),
      .rx_w_mod                    (emac_rx_w_mod),
      .rx_w_sop                    (emac_rx_w_sop),
      .rx_w_eop                    (emac_rx_w_eop),
      .rx_w_err                    (emac_rx_w_err),
      .rx_w_flush                  (emac_rx_w_flush),
      .rx_w_status                 (emac_rx_w_status),
      .rx_w_timestamp              (emac_rx_w_timestamp),
      .add_match_vec               (emac_add_match_vec),
      .rx_w_queue                  (emac_rx_w_queue),
      .rx_w_overflow               (emac_rx_w_overflow),
      .aclk                        (aclk),
      .n_areset                    (n_areset),
      .awid                        (),
      .awaddr                      (emac_awaddr),
      .awaddr_par                  (emac_awaddr_par),
      .awlen                       (emac_awlen),
      .awsize                      (emac_awsize),
      .awburst                     (emac_awburst),
      .awlock                      (),
      .awcache                     (emac_awcache),
      .awprot                      (emac_awprot),
      .awvalid                     (emac_awvalid),
      .awqos                       (emac_awqos),
      .awready                     (emac_awready),
      .wdata                       (emac_wdata),
      .wdata_par                   (emac_wdata_par),
      .wstrb                       (emac_wstrb),
      .wlast                       (emac_wlast),
      .wready                      (emac_wready),
      .wvalid                      (emac_wvalid),
      .bresp                       (emac_bresp),
      .bvalid                      (emac_bvalid),
      .bready                      (emac_bready),
      .arid                        (),
      .araddr                      (emac_araddr),
      .araddr_par                  (emac_araddr_par),
      .arlen                       (emac_arlen),
      .arsize                      (emac_arsize),
      .arburst                     (emac_arburst),
      .arlock                      (),
      .arcache                     (emac_arcache),
      .arprot                      (emac_arprot),
      .arqos                       (emac_arqos),
      .arvalid                     (emac_arvalid),
      .arready                     (emac_arready),
      .rdata                       (emac_rdata),
      .rdata_par                   (emac_rdata_par),
      .rresp                       (emac_rresp),
      .rlast                       (emac_rlast),
      .rvalid                      (emac_rvalid),
      .rready                      (emac_rready),
      .hclk                        (1'b0),
      .n_hreset                    (1'b0),
      .hgrant                      (1'b0),
      .hready                      (1'b0),
      .hresp                       (2'b00),
      .hrdata                      ({p_edma_bus_width{1'b0}}),
      .hbusreq                     (),
      .hlock                       (),
      .haddr                       (),
      .htrans                      (),
      .hwrite                      (),
      .hsize                       (),
      .hburst                      (),
      .hprot                       (),
      .hwdata                      (),
      .dma_bus_width               (),
      .tx_sram_wea                 (emac_tx_sram_wea),
      .tx_sram_ena                 (emac_tx_sram_ena),
      .tx_sram_addra               (emac_tx_sram_addra),
      .tx_sram_dia                 (emac_tx_sram_dia),
      .tx_sram_doa                 (emac_tx_sram_doa),
      .tx_sram_web                 (emac_tx_sram_web),
      .tx_sram_enb                 (emac_tx_sram_enb),
      .tx_sram_addrb               (emac_tx_sram_addrb),
      .tx_sram_dob                 (emac_tx_sram_dob),
      .rx_sram_wea                 (emac_rx_sram_wea),
      .rx_sram_ena                 (emac_rx_sram_ena),
      .rx_sram_addra               (emac_rx_sram_addra),
      .rx_sram_dia                 (emac_rx_sram_dia),
      .rx_sram_doa                 (emac_rx_sram_doa),
      .rx_sram_web                 (emac_rx_sram_web),
      .rx_sram_enb                 (emac_rx_sram_enb),
      .rx_sram_addrb               (emac_rx_sram_addrb),
      .rx_sram_dob                 (emac_rx_sram_dob),
      .user_out                    (),
      .user_in                     (1'b0),
      .rx_databuf_wr_q             (),
      .halfduplex_flow_control_en  (halfduplex_flow_control_en),
      .ethernet_int_bus            (emac_ethernet_int_pad),
      .enable_transmit             (emac_tx_enable),
      .enable_receive              (emac_rx_enable),
      .hold                        (hold),
      //.lu_det_tx_sop_pulse       (emac_tx_sop_pulse), Commented and not deleted for future enhancements
      .lu_det_tx_eop_pulse         (emac_tx_eop_pulse),
      .asf_trans_to_en             (emac_asf_trans_to_en),
      .asf_trans_to_time           (emac_asf_trans_to_time),
      .asf_host_trans_to_err       (emac_asf_host_trans_to_err),
      .asf_sram_corr_err           (emac_asf_sram_corr_err),
      .asf_sram_uncorr_err         (emac_asf_sram_uncorr_err),
      .asf_dap_err                 (emac_asf_dap_err),
      .asf_csr_err                 (emac_asf_csr_err),
      .asf_trans_to_err            (emac_asf_trans_to_err),
      .asf_protocol_err            (emac_asf_protocol_err),
      .asf_integrity_err           (emac_asf_integrity_err),
      .asf_int_nonfatal            (emac_asf_int_nonfatal),
      .asf_int_fatal               (emac_asf_int_fatal)

    );
    assign emac_ethernet_int = emac_ethernet_int_pad[0];

    // If DMA is configured and ASF transaction timeout monitoring
    // enabled, then instantiate the AHB/AXI transaction monitor.
    if ((p_edma_tx_pkt_buffer == 1) &&
        (p_edma_asf_trans_to_prot == 1)) begin : gen_trans_to_prot
      wire  amba_clk, amba_rst_n;
      if (p_edma_axi == 1) begin : gen_axi_clk
        assign amba_clk   = aclk;
        assign amba_rst_n = n_areset;
      end else begin : gen_ahb_clk
        assign amba_clk   = hclk;
        assign amba_rst_n = n_hreset;
      end

      edma_amba_trans_to #(
        .p_edma_axi (p_edma_axi),
        .p_axi_id   (4'h1)
      ) i_trans_to (
        .amba_clk         (amba_clk),
        .amba_rst_n       (amba_rst_n),
        .trans_to_en      (emac_asf_trans_to_en),
        .trans_to_timeval (emac_asf_trans_to_time),
        .htrans           (htrans),
        .hready           (hready),
        .awid             (awid),
        .awvalid          (awvalid),
        .awready          (awready),
        .bid              (bid),
        .bvalid           (bvalid),
        .bready           (bready),
        .arid             (arid),
        .arvalid          (arvalid),
        .arready          (arready),
        .rid              (rid),
        .rvalid           (rvalid),
        .rlast            (rlast),
        .rready           (rready),
        .asf_host_trans_to(emac_asf_host_trans_to_err)
      );

    end else begin : gen_no_trans_to_prot
      assign emac_asf_host_trans_to_err = 1'b0;
    end

  end else begin : gen_no_802p3_br

    // Tie APB busses to PMAC ...
    assign pmac_psel        = psel;
    assign pmac_penable     = penable;
    assign pmac_paddr       = paddr[11:2];
    assign pmac_pwrite      = pwrite;
    assign pmac_pwdata      = pwdata;
    assign pmac_pwdata_par  = pwdata_par_int;
    assign perr             = pmac_perr_with_mii;
    assign prdata           = pmac_prdata_with_mii;
    assign prdata_par       = pmac_prdata_par_with_mii;

    // Tie AXI busses to PMAC ...
    assign awid         = 4'h0;
    assign awaddr       = pmac_awaddr;
    assign awaddr_par   = pmac_awaddr_par;
    assign awlen        = pmac_awlen;
    assign awsize       = pmac_awsize;
    assign awburst      = pmac_awburst;
    assign awcache      = pmac_awcache;
    assign awprot       = pmac_awprot;
    assign awvalid      = pmac_awvalid;
    assign awqos        = pmac_awqos;
    assign pmac_awready = awready;
    assign wdata        = pmac_wdata;
    assign wdata_par    = pmac_wdata_par;
    assign wstrb        = pmac_wstrb;
    assign wlast        = pmac_wlast;
    assign wid          = 4'h0;
    assign wvalid       = pmac_wvalid;
    assign pmac_wready  = wready;
    assign pmac_bresp   = bresp;
    assign pmac_bvalid  = bvalid;
    assign bready       = pmac_bready;
    assign arid         = 4'h0;
    assign araddr       = pmac_araddr;
    assign araddr_par   = pmac_araddr_par;
    assign arlen        = pmac_arlen   ;
    assign arsize       = pmac_arsize  ;
    assign arburst      = pmac_arburst ;
    assign arcache      = pmac_arcache ;
    assign arprot       = pmac_arprot  ;
    assign arvalid      = pmac_arvalid ;
    assign arqos        = pmac_arqos;
    assign pmac_arready = arready ;
    assign pmac_rdata   = rdata;
    assign pmac_rdata_par = rdata_par_int;
    assign pmac_rresp   = rresp;
    assign pmac_rlast   = rlast;
    assign pmac_rvalid  = rvalid;
    assign rready       = pmac_rready;

    assign add_frag_size = 2'b00;

    always@(*)
    begin
      pmac_rx_halt          = 1'b0;
      pmac_rx_dv            = rx_dv_from_bridge;
      pmac_rx_er            = rx_er_from_bridge;
      pmac_rxd              = rxd_from_bridge;
      pmac_rxd_par          = rxd_par_from_bridge;
      pmac_rx_dv_pcs        = rx_dv_pcs_from_bridge;
      pmac_rx_er_pcs        = rx_er_pcs_from_bridge;
      pmac_rxd_pcs          = rxd_pcs_from_bridge;
      pmac_rxd_par_pcs      = rxd_par_pcs_from_bridge;
      txd_to_bridge         = pmac_txd;
      //txd_par_to_bridge   = pmac_txd_par;
      tx_en_to_bridge       = pmac_tx_en;
      tx_er_to_bridge       = pmac_tx_er;
      txd_pcs_to_bridge     = pmac_txd_pcs;
      txd_par_pcs_to_bridge = pmac_txd_par_pcs;
      tx_en_pcs_to_bridge   = pmac_tx_en_pcs;
      tx_er_pcs_to_bridge   = pmac_tx_er_pcs;
    end

    assign pmac_tx_rdy          = 1'b1; // Always drive TX RDY high when no BR

    assign enable_transmit = pmac_tx_enable;
    assign enable_receive  = pmac_rx_enable;

    assign emac_ethernet_int  = 1'b0;
    assign emac_tx_sram_wea   = 1'b0;
    assign emac_tx_sram_ena   = 1'b0;
    assign emac_tx_sram_addra = {p_edma_emac_tx_pbuf_addr{1'b0}};
    assign emac_tx_sram_dia   = {p_emac_tx_sram_width{1'b0}};
    assign emac_tx_sram_web   = 1'b0;
    assign emac_tx_sram_enb   = 1'b0;
    assign emac_tx_sram_addrb = {p_edma_emac_tx_pbuf_addr{1'b0}};
    assign emac_rx_sram_wea   = 1'b0;
    assign emac_rx_sram_ena   = 1'b0;
    assign emac_rx_sram_addra = {p_edma_emac_rx_pbuf_addr{1'b0}};
    assign emac_rx_sram_dia   = {p_emac_rx_sram_width{1'b0}};
    assign emac_rx_sram_web   = 1'b0;
    assign emac_rx_sram_enb   = 1'b0;
    assign emac_rx_sram_addrb = {p_edma_emac_rx_pbuf_addr{1'b0}};

    // tie to zero the emac FIFO interface
    assign emac_tx_r_rd        = 1'b0;
    assign emac_tx_r_queue     = 4'h0;
    assign emac_tx_r_status    = 4'h0;
    assign emac_tx_r_timestamp = 78'd0;
    assign emac_dma_tx_end_tog = 1'b0;
    assign emac_rx_w_wr        = 1'b0;
    assign emac_rx_w_data      = {p_emac_bus_width{1'b0}};
    assign emac_rx_w_mod       = 4'h0;
    assign emac_rx_w_sop       = 1'b0;
    assign emac_rx_w_eop       = 1'b0;
    assign emac_rx_w_err       = 1'b0;
    assign emac_rx_w_flush     = 1'b0;
    assign emac_rx_w_status    = 45'd0;
    assign emac_rx_w_queue     = 4'h0;
    assign emac_rx_w_timestamp = 78'd0;
    assign emac_add_match_vec  = {p_num_spec_add_filters{1'b0}};

    // No interrupt
    assign mmsl_int                 = 1'b0;

    // Tie off ASF signals going to pmac and emac
    assign asf_csr_mmsl_err     = 1'b0;
    assign asf_dap_mmsl_tx_err  = 1'b0;
    assign asf_dap_mmsl_rx_err  = 1'b0;
    assign lu_det_e_pip         = 1'b0;
    assign lu_det_p_pip         = 1'b1;
    //assign lu_det_p_sop_gate  = 1'b1; Commented and not deleted for future enhancements
    assign lu_det_p_eop_gate    = 1'b1;

    // Tie to zero top level emac ASF outputs
    assign emac_asf_int_fatal       = 1'b0;
    assign emac_asf_int_nonfatal    = 1'b0;
    assign emac_asf_sram_corr_err   = 1'b0;
    assign emac_asf_sram_uncorr_err = 1'b0;
    assign emac_asf_dap_err         = 1'b0;
    assign emac_asf_csr_err         = 1'b0;
    assign emac_asf_trans_to_err    = 1'b0;
    assign emac_asf_protocol_err    = 1'b0;
    assign emac_asf_integrity_err   = 1'b0;

  end

  endgenerate
  assign arlock = 2'h0;
  assign awlock = 2'h0;

endmodule
