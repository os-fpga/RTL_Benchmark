//------------------------------------------------------------------------------
// Copyright (c) 2001-2022 Cadence Design Systems, Inc.
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
//   Filename:           gem_top.v
//   Module Name:        gem_top
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
//                             gem_mac, edma_top, gem_reg_top & gem_pcs.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_top (

   // system interface (resets)
   n_txreset,
   n_rxreset,

   // Internal loopback signals
   n_ntxreset,
   n_tx_clk,
   loopback_local,

   // 802.3br MMSL interface
   rx_br_halt,

   // gmii / mii ethernet interface.
   tx_clk,
   tx_er,
   txd,
   txd_par,
   tx_en,
   rx_clk,
   rxd,
   rxd_par,
   rx_er,
   rx_dv,

   // dedicated pcs interface.
   tx_er_pcs,
   txd_pcs,
   txd_par_pcs,
   tx_en_pcs,
   rxd_pcs,
   rxd_par_pcs,
   rx_er_pcs,
   rx_dv_pcs,
   col_pcs,
   crs_pcs,

   // signals going to gem_pcs from gem_reg_top
   alt_sgmii_mode,
   sgmii_mode,
   uni_direct_en,

   // signals coming from gem_pcs to gem_reg_top
   pcs_link_state,
   pcs_an_complete,
   np_data_int,
   mac_pause_tx_en,
   mac_pause_rx_en,
   mac_full_duplex,

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
   tx_lpi_en,
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
   tx_r_data,
   tx_r_data_par,
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
   rx_w_data_par,
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
   awqos,
   awvalid,
   awready,
   // Write Data Channel
   wdata,
   wdata_par,
   wstrb,
   wlast,
   wready,
   wvalid,

   // Response Channel
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
   arqos,
   arvalid,
   arready,
   // Read Data Channel
   rdata,
   rdata_par,
   rresp,
   rlast,
   rvalid,
   rready,

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

   // Packet buffer SRAM interface ..
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

   enable_transmit,
   enable_receive,

   // User I/O interface
   user_out,
   user_in,

  // Specific outputs to support Priority Queues
   rx_databuf_wr_q,
   ethernet_int_bus,

   sel_mii_on_rgmii,

   // Specific for MMSL (802.3 br)
   txd_frame_size,
   txd_rdy,
   add_frag_size,
   hold,
   min_ifg,

  // Specific outputs to support half duplex flow control
  halfduplex_flow_control_en,

  // Going to gem_mii_bridge/gem_pcs
  retry_test,
  full_duplex,

  // Lockup detect inputs
  //lu_det_tx_sop_pulse, Commented and not deleted for future enhancements
  lu_det_tx_eop_pulse,

  // Link Fault Signalling
  link_fault_signal_en,
  link_fault_status,

  // ASF external status inputs
  asf_dap_paddr_err,
  asf_dap_prdata_err,
  asf_dap_rdata_err,
  asf_csr_pcs_err,
  asf_csr_mmsl_err,
  asf_dap_pcs_tx_err,
  asf_dap_pcs_rx_err,
  asf_dap_mmsl_tx_err,
  asf_dap_mmsl_rx_err,

  // ASF transaction timeout control and status
  asf_trans_to_en,
  asf_trans_to_time,
  asf_host_trans_to_err,

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
  asf_int_fatal

   );


//------------------------------------------------------------------------------
// Declare inputs and outputs
//------------------------------------------------------------------------------

  parameter [1363:0] grouped_params     = {1364{1'b0}};
  parameter          DRD_PKTDATA        = 2'b10;  // Read TX data from AXI
  parameter          RX_DMA_DATA_STORE  = 3'b011; // Data store
  parameter          p_tx_sram_width    = 64;
  parameter          p_rx_sram_width    = 64;

  `include "ungroup_params.v"


   // system interface (resets)
   input          n_txreset;         // tx_clk domain reset
   input          n_rxreset;         // rx_clk domain reset

   // Internal loopback signals
   input          n_ntxreset;        // n_tx_clk domain reset
   input          n_tx_clk;          // inverted tx_clk_in used for loopback.
   output         loopback_local;    // Indicates MAC is in local loopback.

   // Interface to 802.3br MMSL
   input          rx_br_halt;        // Halt mid-packet

   // gmii / mii ethernet interface.
   input          tx_clk;            // transmit clock from the phy.
   output         tx_er;             // transmit error signal to the phy.
   output   [7:0] txd;               // transmit data to the phy.
   output         txd_par;           // optional parity
   output         tx_en;             // transmit enable signal to the phy.
   input          rx_clk;            // receive clock from the phy.
   input    [7:0] rxd;               // receive data from the phy.
   input          rxd_par;           // Optional parity
   input          rx_er;             // receive error signal from the phy.
   input          rx_dv;             // receive data valid signal from the phy.

   // dedicated pcs interface.
   output         tx_er_pcs;         // transmit error signal to the PCS.
   output   [7:0] txd_pcs;           // transmit data to the PCS.
   output         txd_par_pcs;       // optional parity
   output         tx_en_pcs;         // transmit enable signal to the PCS.
   input   [15:0] rxd_pcs;           // receive data from the PCS.
   input    [1:0] rxd_par_pcs;       // Optional parity
   input    [1:0] rx_er_pcs;         // receive error signal from the PCS.
   input    [1:0] rx_dv_pcs;         // receive data valid signal from PCS.
   input          col_pcs;           // collision detect signal from the PCS.
   input          crs_pcs;           // carrier sense signal from the PCS.

   // signals going to gem_pcs from gem_reg_top
   output         alt_sgmii_mode;    // alternative tx config for SGMII
   output         sgmii_mode;        // PCS is configured for SGMII
   output         uni_direct_en;     // when set PCS transmits data rather

   // signals coming from gem_pcs to gem_reg_top
   input          pcs_link_state;    // current link state of PCS
   input          pcs_an_complete;   // PCS autonegotiation complete
   input          np_data_int;       // More np data required
   input          mac_pause_tx_en;   // negotiated pause tx
   input          mac_pause_rx_en;   // negotiated pause rx
   input          mac_full_duplex;   // negotiated duplex mode
                                     // than idle when rx link is down
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
   output         tx_lpi_en;         // enables transmission of LPI
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
   output  [11:0] tsu_timer_cnt_par; // Parity if selected
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
   input   [11:2] paddr;             // address bus of selected master.
   output  [31:0] prdata;            // read data.
   output  [3:0]  prdata_par;        // Parity for prdata
   input   [31:0] pwdata;            // write data.
   input   [3:0]  pwdata_par;        // Parity for pwdata_par
   input          pwrite;            // peripheral write strobe.
   input          penable;           // peripheral enable.
   input          psel;              // peripheral select for gpio.
   output         perr;              // not a standard apb signal, driven high
                                     // when psel is asserted if address is not
                                     // known.

   // low latency tx interface uses external fifo tx port
   input   [p_emac_bus_width-1:0] tx_r_data;           // output data from the transmit fifo to the tx module.
   input   [p_emac_bus_pwid-1:0]  tx_r_data_par;
   input                    [3:0] tx_r_mod;            // tx number of valid bytes in last
                                                       // transfer of the frame.
                                                       // 0000 - tx_r_data[127:0] valid,
                                                       // 0001 - tx_r_data[7:0] valid,
                                                       // 0010 - tx_r_data[15:0] valid, until
                                                       // 1111 - tx_r_data[119:0] valid.
   input                          tx_r_sop;            // start of packet indicator.
   input                          tx_r_eop;            // end of packet indicator.
   input                          tx_r_err;            // packet in error indicator.
   output     [p_edma_queues-1:0] tx_r_rd;             // request new data from fifo.
   output                   [3:0] tx_r_queue;          // Queue ID, timed with tx_r_rd
   input                          tx_r_valid;          // new tx data available from fifo.
   input      [p_edma_queues-1:0] tx_r_data_rdy;       // indicates either a complete packet
                                                       // is present in the fifo or a certain
                                                       // threshold of data has been crossed,
                                                       // the mac uses this input to trigger
                                                       // a frame transfer.
   input                          tx_r_underflow;      // signals tx fifo underrun condition.
   input                          tx_r_flushed;        // tx fifo has been flushed.
   input                          tx_r_control;        // tx control from in-line FIFO word
   input      [p_edma_queues-1:0] tx_r_frame_size_vld; // We have the frame size.
   input [(p_edma_queues*14)-1:0] tx_r_frame_size;     // Frame Length, 1 per queue
   output                   [3:0] tx_r_status;         // tx status written to in-line FIFO word
   output                  [77:0] tx_r_timestamp;      // asserted high at the end of frame
   input                          dma_tx_status_tog;   // toggle acknowledge for tx_r_status.
   output                         dma_tx_end_tog;      // toggled when tx_r_status is valid.

   // external fifo interface.
   output         rx_w_wr;           // rx write output to the receive
                                     // fifo.
   output [p_emac_bus_width-1:0]     //
                  rx_w_data;         // output data to the receive fifo.
   output [p_emac_bus_pwid-1:0]
                  rx_w_data_par;
   output   [3:0] rx_w_mod;          // rx number of valid bytes in last.
                                     // transfer of the frame.
   output         rx_w_sop;          // rx start of packet indicator.
   output         rx_w_eop;          // rx end of packet indicator.
   output         rx_w_err;          // rx packet in error indicator.
   output         rx_w_flush;        // rx fifo flush from the mac.
   output  [44:0] rx_w_status;       // rx status written to in-line FIFO word.
   output  [77:0] rx_w_timestamp;    // valid on rx_w_eop

   output [p_num_spec_add_filters:0] add_match_vec; // indicates specific address match status
                                                    // 3 to 0 are returned by rx_w_status
   output                      [3:0] rx_w_queue;    // RX Priority queue number
   input                             rx_w_overflow; // Overrun in RX FIFO indication.


   // AXI interface signals.
   input          aclk;
   input          n_areset;

   // Write Address Channel
   output                    [3:0] awid;
   output  [p_edma_addr_width-1:0] awaddr;
   output  [p_edma_addr_pwid-1:0]  awaddr_par;
   output                    [7:0] awlen;
   output                    [2:0] awsize;
   output                    [1:0] awburst;
   output                    [1:0] awlock;
   output                    [3:0] awcache;
   output                    [2:0] awprot;
   output                    [3:0] awqos;
   output                          awvalid;
   input                           awready;
   // Write Data Channel
   output [p_edma_bus_width-1:0]   wdata;
   output [p_edma_bus_pwid-1:0]    wdata_par;
   output [p_edma_bus_pwid-1:0]    wstrb;
   output                          wlast;
   input                           wready;
   output                          wvalid;

   // Response Channel
   input   [1:0] bresp;
   input         bvalid;
   output        bready;

   // Read Address Channel
   output                    [3:0] arid;
   output  [p_edma_addr_width-1:0] araddr;
   output  [p_edma_addr_pwid-1:0]  araddr_par;
   output                    [7:0] arlen;
   output                    [2:0] arsize;
   output                    [1:0] arburst;
   output                    [1:0] arlock;
   output                    [3:0] arcache;
   output                    [2:0] arprot;
   output                    [3:0] arqos;
   output                          arvalid;
   input                           arready;
   // Read Data Channel
   input    [p_edma_bus_width-1:0] rdata;
   input    [p_edma_bus_pwid-1:0]  rdata_par;
   input                     [1:0] rresp;
   input                           rlast;
   input                           rvalid;
   output                          rready;

   // AHB interface signals.
   input          hclk;                 // AHB clock.
   input          n_hreset;             // AHB reset.
   input          hgrant;               // AHB arbiter control grant.
   input          hready;               // AHB Slave ready.
   input    [1:0] hresp;                // AHB Slave response (OK, error, retry
                                        // or split).
   input [p_edma_bus_width-1:0]         //
                  hrdata;               // AHB input data.
   output         hbusreq;              // AHB bus request.
   output         hlock;                // lock the bus - always asserted with
   output [p_edma_addr_width-1:0] haddr;                // hbusreq address to be accessed.
   output   [1:0] htrans;               // bus transfer type (nonseq, seq, idle
                                        // or busy.
   output         hwrite;               // AHB write signal (active high).
   output  [ 2:0] hsize;                // transfer size -
                                        // set to 3'b010 for 32 bit words.
                                        // set to 3'b011 for 64 bit words.
                                        // set to 3'b100 for 128 bit words.
   output   [2:0] hburst;               // burst type (single, incrementing etc).
   output   [3:0] hprot;                // Protection type - unused tied low.
   output[p_edma_bus_width-1:0]         //
                  hwdata;               // AHB Write data.


   // DMA bus width indication to external controller or FIFO
   output   [1:0] dma_bus_width;        // encoding for dma bus width.

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


   // User I/O interface.
   output  [(p_gem_user_out_width - 1):0]// programmable user outputs
                  user_out;              // to top level
   input   [(p_gem_user_in_width - 1):0] // programmable user inputs
                  user_in;               // from top level


   // Specific outputs to support Priority Queues
   output [p_edma_queues-1:0] rx_databuf_wr_q;

   output         sel_mii_on_rgmii;      // reconfigures RGMII interface for MII operation

  // Specific outputs to support half duplex flow control
   input          halfduplex_flow_control_en;    // Flow control enable

   // Interrupt controller interface.
   output [15:0]  ethernet_int_bus;     // ethernet mac interrupt signal
   output         enable_transmit;      // Transmit enable from network control register
   output         enable_receive;       // Receive enable from network control register
   output         retry_test;           // From network config register, 0 for normal operation
   output         full_duplex;          // Full duplex from network configuration register

   // Specific for MMSL (802.3 br)
   input                [1:0] add_frag_size;
   output              [13:0] txd_frame_size;
   input                      txd_rdy;
   output [p_edma_queues-1:0] hold;
   output               [3:0] min_ifg;  // minimum transmit IFG divided by four

   // Lockup detection inputs
   //input        lu_det_tx_sop_pulse; Commented and not deleted for future enhancements
   input          lu_det_tx_eop_pulse;

   // Link Fault Signalling
   input          link_fault_signal_en; // 802.3cb link fault signalling enabled
   input    [1:0] link_fault_status;  // 00 - OK; 01 - local fault; 10 - remote fault; 11 - link interruption

   // ASF external status inputs
   input          asf_dap_paddr_err;  // There was a parity check error on paddr
   input          asf_dap_prdata_err; // There was a parity check error on prdata
   input          asf_dap_rdata_err;  // There was a parity check error on rdata
   input          asf_csr_pcs_err;    // There was a parity error in PCS registers
   input          asf_csr_mmsl_err;   // There was a parity error in MMSL registers
   input          asf_dap_pcs_tx_err; // Fault in PCS TX datapath
   input          asf_dap_pcs_rx_err; // Fault in PCS RX datapath
   input          asf_dap_mmsl_tx_err;// Fault in MMSL TX datapath
   input          asf_dap_mmsl_rx_err;// Fault in MMSL RX datapath

   // ASF transaction timeout configuration and status
   output                     asf_trans_to_en;
   output [15:0]              asf_trans_to_time;
   input                      asf_host_trans_to_err;

   // ASF comman output error indications
   output                                asf_sram_corr_err;             // SRAM correctable error indication
   output                                asf_sram_uncorr_err;           // SRAM uncorrectable error indication
   output                                asf_dap_err;                   // Data and Address Paths error indication
   output                                asf_csr_err;                   // Configuration and Status Registers error indication
   output                                asf_trans_to_err;              // Transaction Timeouts indication
   output                                asf_protocol_err;              // Protocol error indication
   output                                asf_integrity_err;             // Integrity error indication
   // ASF and fatal and non-fatal interrupts
   output                                asf_int_nonfatal;              // ASF non-fatal interrupt
   output                                asf_int_fatal;                 // ASF fatal interrupt

//------------------------------------------------------------------------------
// wire and reg declarations.
//------------------------------------------------------------------------------

   // handshaking signals between gem_mac and gem_reg_top
   wire           tx_status_wr_tog;    // signal for tx handshake of status.
   wire           tx_pause_tog_ack;    // handshake of tx_pause_time_tog
   wire           store_udp_offset;    // store tcp/udp offset to memory

   // precision time protocol signals for IEEE 1588 support
   wire           store_rx_ts;         // store receive time stamp to memory
   wire           sof_tx;              // used to capture timer value
   wire           sync_frame_tx;       // PTP sync frame transmitted
   wire           delay_req_tx;        // PTP delay request transmitted
   wire           pdelay_req_tx;       // PTP pdelay request transmitted
   wire           pdelay_resp_tx;      // PTP pdelay respond transmitted
   wire           sof_rx;              // used to capture timer value
   wire           sync_frame_rx;       // PTP sync frame received
   wire           delay_req_rx;        // PTP delay request received
   wire           pdelay_req_rx;       // PTP pdelay request received
   wire           pdelay_resp_rx;      // PTP pdelay respond received
   wire    [47:0] tsu_timer_sec_cmp;   // TSU timer comparison seconds
   wire    [21:0] tsu_timer_nsec_cmp;  // TSU timer comparison nanoseconds
   wire    [47:0] tsu_timer_sec;       // TSU registered timer value seconds
   wire    [29:0] tsu_timer_nsec;      // TSU registered timer value
   wire           tsu_timer_sec_wr;    // indicates a TSU timer seconds write
   wire           tsu_timer_nsec_wr;   // indicates a TSU timer nseconds write
   wire           tsu_timer_adj_ctrl;  // TSU timer add/subtract adjust
   wire    [29:0] tsu_timer_adj;       // TSU timer adjust
   wire           tsu_timer_adj_wr;    // indicates a TSU timer adjust write
   wire    [31:0] tsu_timer_incr;      // TSU timer increment
   wire           tsu_timer_incr_wr;   // TSU timer incr written
   wire     [7:0] tsu_timer_alt_incr;  // TSU timer alternative increment
   wire     [7:0] tsu_timer_num_incr;  // TSU timer number of increments
                                       // alternative increment value used
   wire           tsu_sec_incr;        // indicates a TSU timer seconds
                                       // increment
   wire           timer_strobe;        // write timer sync strobe registers
   wire           tsu_timer_cmp_val;   // TSU timer comparison valid
   wire           tsu_timer_nsec_cmp_wr; // indicates a comparison ns write

   wire   [77:0]  tsu_ptp_tx_timer_out_mac;  // output from mac to reg block
   wire   [77:0]  tsu_ptp_rx_timer_out_mac;  // output from mac to reg block
   wire   [9:0]   tsu_ptp_tx_timer_prty_out_mac;  // ASF - parity protection for tsu_ptp_tx_timer_out_mac
   wire   [9:0]   tsu_ptp_rx_timer_prty_out_mac;  // ASF - parity protection for tsu_ptp_rx_timer_out_mac

   wire           one_step_sync_mode;   // enable one step sync frame mode
   wire           oss_correction_field; // enable update of correction field in sync frames

   wire           ext_tsu_timer_en;    // use external tsu timer when set to '1'

   // signals from gem_reg_top to gem_mac.
   wire           tx_byte_mode;        // gem_tx transmits bytes not nibbles
   wire           en_half_duplex_rx;   // enable receiving of frames whilst
                                       // transmiting in half duplex.
   wire           jumbo_enable;        // enable jumbo frames.
   wire           force_discard_on_err; // global version
   wire           force_max_ahb_burst_rx; //
   wire           force_max_ahb_burst_tx; //
   wire           pause_enable;        // stops tx when pause time is
                                       // non-zero.
   wire           rx_1536_en;          // goes to rx block to enable
                                       // reception of 1536 byte frames.
   wire           strip_rx_fcs;        // stops rx fcs/crc being copied.
   wire           rx_no_pause_frames;  // Don't copy any pause frames.
   wire           rx_toe_enable;       // Enable RX TCP Offload Engine.
   wire           check_rx_length;     // enables rx length field checking.
   wire    [15:0] tx_pause_quantum;    // tx_pause_quantum for pause tx for priotity 0.
   wire    [1:0]  tx_pause_quantum_par;// Optional parity
   wire    [15:0] tx_pause_quantum_p1; // tx_pause_quantum for pause tx for priotity 1.
   wire    [1:0]  tx_pause_quantum_p1_par;
   wire    [15:0] tx_pause_quantum_p2; // tx_pause_quantum for pause tx for priotity 2.
   wire    [1:0]  tx_pause_quantum_p2_par;
   wire    [15:0] tx_pause_quantum_p3; // tx_pause_quantum for pause tx for priotity 3.
   wire    [1:0]  tx_pause_quantum_p3_par;
   wire    [15:0] tx_pause_quantum_p4; // tx_pause_quantum for pause tx for priotity 4.
   wire    [1:0]  tx_pause_quantum_p4_par;
   wire    [15:0] tx_pause_quantum_p5; // tx_pause_quantum for pause tx for priotity 5.
   wire    [1:0]  tx_pause_quantum_p5_par;
   wire    [15:0] tx_pause_quantum_p6; // tx_pause_quantum for pause tx for priotity 6.
   wire    [1:0]  tx_pause_quantum_p6_par;
   wire    [15:0] tx_pause_quantum_p7; // tx_pause_quantum for pause tx for priotity 7.
   wire    [1:0]  tx_pause_quantum_p7_par;
   wire           tx_pause_frame_req;  // transmit pause frame (prog quantum).
   wire           tx_pause_frame_zero; // use zero quantum in tx pause frame.
   wire           pfc_enable;          // PFC pause frame receive enable
   wire           tx_pfc_frame_req;    // request to transmit PFC pause frame
   wire     [7:0] tx_pfc_frame_pri;    // software controlled for priority
                                       // enable vector of PFC pause frame.
   wire           tx_pfc_frame_pri_par;
   wire     [7:0] tx_pfc_frame_zero;   // software controlled for pause quantum
                                       // field of PFC pause frame.
                                       // When each entry equal to 0,
                                       // the pause quantum field of the
                                       // associated priority is from the
                                       // TX pause quantum register
                                       // When each entry equal to 1,
                                       // the pause quantum field of the
                                       // associated priority is zero
   wire           tx_lpi_en;           // enables transmission of LPI
   wire           ifg_eats_qav_credit; // modifies CBS algorithm so IFG/IPG uses Qav credit
   wire    [15:0] tw_sys_tx_time;      // system wake time after tx LPI stops
   wire     [7:0] rx_pfc_paused;       // each bit is set when PFC frame has
                                       // been received and the associated
                                       // PFC counter != 0
   wire           ptp_unicast_ena;     // enable PTPv2 IPv4 unicast IP DA
                                       // detection
   wire    [31:0] rx_ptp_unicast;      // rx PTPv2 IPv4 unicast IP DA
   wire    [31:0] tx_ptp_unicast;      // tx PTPv2 IPv4 unicast IP DA

   wire           ext_match_en;        // external match enable from
                                       // the network configuration register.
   wire           uni_hash_en;         // unicast hash enable from the
                                       // network configuration register.
   wire           multi_hash_en;       // multicast hash enable signal from
                                       // the network configuration register.
   wire           no_broadcast;        // signal to disable recption of
                                       // broadcast frames from the network
                                       // configuration register.
   wire           copy_all_frames;     // copy all frames signal from the
                                       // network configuration register.
   wire           rm_non_vlan;         // Discard non-VLAN frames
   wire    [63:0] hash;                // hash register for destination
                                       // address filtering.
   wire [55*(p_num_spec_add_filters+1)-1:0] spec_add_filter_regs;   // specific address filters
   wire [p_num_spec_add_filters:0]    spec_add_filter_active;  // specific address filter active
   wire    [47:0] mask_add1;           // specific address 1 mask for
                                       // destination address comparison.
   wire    [47:0] spec_add1_tx;        // Source address for pause tx
   wire    [5:0]  spec_add1_tx_par;    // Optional parity
   wire    [15:0] spec_type1;          // specific type 1 for type comparison
   wire    [15:0] spec_type2;          // specific type 2 for type comparison
   wire    [15:0] spec_type3;          // specific type 3 for type comparison
   wire    [15:0] spec_type4;          // specific type 4 for type comparison
   wire           spec_type1_active;   // spec_type1 can be used for type
                                       // comparison.
   wire           spec_type2_active;   // spec_type2 can be used for type
                                       // comparison.
   wire           spec_type3_active;   // spec_type3 can be used for type
                                       // comparison.
   wire           spec_type4_active;   // spec_type4 can be used for type
                                       // comparison.
   wire    [15:0] wol_ip_addr;         // lower bits of IP address for WoL
   wire     [3:0] wol_mask;            // Wake-onLAN enable mask
   wire    [16:0] stacked_vlantype;    // VLAN tag TPID (bit 16 enables
                                       // stacked VLAN tag
   wire           rx_no_crc_check;     // disables crc checking on receive
   wire           stretch_enable;      // enables IPG stretching
   wire    [15:0] stretch_ratio;       // determines how to stretch the IPG
   wire           rx_bad_preamble;     // enables reception of frames with
                                       // bad preamble
   wire           ign_ipg_rx_er;       // ignore rx_er when rx_dv is low

   // signals from gem_tx to gem_reg_top
   wire           tx_frame_txed_ok;    // asserted at end of transmitted
                                       // frame, if no underrun and not too
                                       // many retries. Cleared when
                                       // tx_status_wr_tog is returned.
   wire   [13:0]  tx_bytes_in_frame;   // number of bytes in tx frame
   wire           tx_broadcast_frame;  // broadcast tx frame
   wire           tx_multicast_frame;  // multicast tx frame
   wire           tx_single_coll_frame;// asserted high at the end of frame
                                       // if a single collision and no
                                       // underrun, cleared when
                                       // tx_status_wr_tog is returned.
   wire           tx_multi_coll_frame; // asserted high at the end of frame
                                       // if a multicollision, no underrun
                                       // and not too many retries, cleared
                                       // when tx_status_wr_tog is returned.
   wire           tx_late_coll_frame;  // asserted high at the end of frame
                                       // if late collision, no underrun and
                                       // not too many retries, cleared
                                       // when tx_status_wr_tog is returned.
   wire           tx_deferred_tx_frame;// asserted high at the end of frame
                                       // if deferred, no collision and no
                                       // underrun, cleared when
                                       // when tx_status_wr_tog is returned.
   wire           tx_crs_error_frame;  // asserted high at the end of frame
                                       // if crs error and no underrun,
                                       // cleared when tx_status_wr_tog is
                                       // returned.
   wire           tx_coll_occured;     // collision occured during transmit,
                                       // cleared when tx_status_wr_tog is
                                       // returned.
   wire           tx_too_many_retries; // set if collision retry limit has
                                       // been reached, cleared when
                                       // tx_status_wr_tog is returned.
   wire           tx_underflow_frame;  // asserted high at the end of frame
                                       // to indicate a fifo underrun,
                                       // cleared when tx_status_wr_tog
                                       // is returned.
   wire   [15:0]  tx_pause_time;       // value of pause time register.
   wire           tx_pause_time_tog;   // indicates that the pause time
                                       // register has decremented.
   wire           tx_pause_frame_txed; // indicates that the pause frame was
                                       // transmitted, cleared when
                                       // tx_status_wr_tog is returned.
   wire           tx_pfc_pause_frame_txed; // indicates that the PFC pause
                                       // frame was transmitted,
                                       // cleared when
                                       // tx_status_wr_tog is returned.
   wire   [9:0]   tx_r_timestamp_par;  // ASF - parity protection for tx_r_timestamp
   wire   [9:0]   rx_w_timestamp_par;  // ASF - parity protection for rx_w_timestamp

   // signals from gem_rx to gem_reg_top
   wire           rx_frame_rxed_ok;    // frame recieved OK by MAC
   wire   [13:0]  rx_bytes_in_frame;   // number of bytes in rx frame
   wire           rx_broadcast_frame;  // broadcast rx frame
   wire           rx_multicast_frame;  // multicast rx frame
   wire           lpi_indicate;        // rx LPI indication has been detected
   wire           rx_align_error;      // misaligned frame (non-integral
                                       // number of bytes and bad crc),
                                       // cleared when rx_status_wr_tog is
                                       // returned.
   wire           rx_crc_error;        // crc errored frame (integral number
                                       // of bytes and bad crc), cleared when
                                       // rx_status_wr_tog is returned.
   wire           rx_short_error;      // short frame (less than 64 bytes and
                                       // good crc), cleared when
                                       // rx_status_wr_tog is returned.
   wire           rx_long_error;       // long frame (greater than 1518 bytes
                                       // and good crc), cleared when
                                       // rx_status_wr_tog is returned.
   wire           rx_jabber_error;     // long frame with bad crc (greater
                                       // than 1518 bytes), cleared when
                                       // rx_status_wr_tog is returned.
   wire           rx_symbol_error;     // signal indicating a rx_er frame,
                                       // cleared when rx_status_wr_tog is
                                       // returned.
   wire           rx_pause_frame;      // indicates a 802.3 pause frame
                                       // has been received, cleared when
                                       // rx_status_wr_tog is returned.
   wire           rx_pause_nonzero;    // indicates a 802.3 pause frame
                                       // has been received with non-zero
                                       // quantum.
                                       // cleared on rx_status_wr_tog.
   wire           rx_pfc_pause_frame;  // indicates a PFC pause frame
                                       // has been received, cleared when
                                       // rx_status_wr_tog is returned.
   wire           rx_pfc_pause_nonzero;// indicates a PFC pause frame
                                       // has been received (pause_enable = 1)
                                       // equivalent to rx_pause_nonzero for
                                       // classic pause frame
   wire           rx_length_error;     // indicates a frame has been received
                                       // where the length field is incorrect,
                                       // cleared when rx_status_wr_tog is
                                       // returned.
   wire           rx_ip_ck_error;      // frame had IP header checksum error
                                       // cleared when rx_status_wr_tog is
                                       // returned.
   wire           rx_tcp_ck_error;     // frame had TCP checksum error
                                       // cleared when rx_status_wr_tog is
                                       // returned.
   wire           rx_udp_ck_error;     // frame had UDP checksum error
                                       // cleared when rx_status_wr_tog is
                                       // returned.
   wire           rx_dma_pkt_flushed;  // frame was dropped due to AHB
                                       // resource error
   wire           rx_overflow;         // asserted when overflow in RX path

   // signals between edma_top and gem_mac (gem_tx).
   // also forms the external tx fifo interface.
   wire           dma_is_busy;

   // signals between edma_top and gem_mac (gem_rx).
   // also forms the external rx fifo interface.
   wire           rx_w_wr_dma;         // rx write output to the receive
                                       // fifo.
   wire   [p_emac_bus_width-1:0]       //
                  rx_w_data_dma;       // output data to the receive fifo.
   wire   [p_emac_bus_pwid-1:0]
                  rx_w_data_par_dma;
   wire     [3:0] rx_w_mod_dma;        // rx number of valid bytes in last
                                       // transfer of the frame.
   wire           rx_w_sop_dma;        // rx start of packet indicator.
   wire           rx_w_eop_dma;        // rx end of packet indicator.
   wire           rx_w_err_dma;        // rx packet in error indicator.
   wire           rx_w_flush_dma;      // rx fifo flush from the mac
   wire           rx_w_overflow_dma;   // rx fifo overflow status.

   wire           rx_w_wr_mac;         // rx write output to the receive
                                       // fifo.
   wire   [127:0] rx_w_data_mac;       // output data to the receive fifo.
   wire   [15:0]  rx_w_data_par_mac;
   wire     [3:0] rx_w_mod_mac;        // rx number of valid bytes in last
                                       // transfer of the frame.
   wire           rx_w_sop_mac;        // rx start of packet indicator.
   wire           rx_w_eop_mac;        // rx end of packet indicator.
   wire           rx_w_err_mac;        // rx packet in error indicator.
   wire           rx_w_flush_mac;      // rx fifo flush from the mac
   wire           rx_w_overflow_mac;   // rx fifo overflow status.


   // signals between edma_top and gem_rx
   wire           dma_rx_end_tog_mac;  // toggled at the end of frame
                                       // reception.
   wire           rx_w_bad_frame;      // end of bad receive frame, rx frame
                                       // bad (rx_er or too long) held until
                                       // end of frame.
   wire    [13:0] rx_w_frame_length;   // records frame length for status
                                       // reporting.
   wire           rx_w_vlan_tagged;    // used for reporting vlan tag.
   wire           rx_w_prty_tagged;    // used for reporting priority tag.
   wire     [3:0] rx_w_tci;            // used for reporting vlan priority.
   wire           rx_w_broadcast_frame;// broadcast frame signal from the
                                       // address checker - rx status
                                       // reporting.
   wire           rx_w_mult_hash_match;// multicast hash matched frame signal
                                       // for rx status reporting.
   wire           rx_w_uni_hash_match; // unicast hash matched frame signal
                                       // for rx status reporting.
   wire           rx_w_ext_match1;     // external matched frame signal
                                       // for rx status reporting.
   wire           rx_w_ext_match2;     // external matched frame signal
                                       // for rx status reporting.
   wire           rx_w_ext_match3;     // external matched frame signal
                                       // for rx status reporting.
   wire           rx_w_ext_match4;     // external matched frame signal
                                       // for rx status reporting.
   wire [p_num_spec_add_filters:0] rx_w_add_match; // specific address register matched
   wire [7:0]     rx_w_add_match_0to7; // first 8

   wire           rx_w_type_match1;    // specific type register 1 matched
                                       // type field.
   wire           rx_w_type_match2;    // specific type register 2 matched
                                       // type field.
   wire           rx_w_type_match3;    // specific type register 3 matched
                                       // type field.
   wire           rx_w_type_match4;    // specific type register 4 matched
                                       // type field.
   wire           rx_w_checksumi_ok;   // IP checksum checked and was OK.
   wire           rx_w_checksumt_ok;   // TCP checksum checked and was OK.
   wire           rx_w_checksumu_ok;   // UDP checksum checked and was OK.
   wire           rx_w_snap_frame;     // Frame was SNAP encapsulated and
                                       // had no VLAN or VLAN with no CFI.
   wire           rx_w_length_error;   // rx_w_status length field error
   wire           rx_w_crc_error;      // rx_w_status crc error
   wire           rx_w_too_short;      // rx_w_status rx length short error
   wire           rx_w_too_long;       // rx_w_status rx length long error
   wire           rx_w_code_error;     // rx_w_status code error
   wire  [11:0]   rx_w_l4_offset;      // TCP/UDP offset in bytes
   wire  [11:0]   rx_w_pld_offset;     // PLD offset in bytes
   wire           rx_w_pld_offset_vld; // pld offset vld

   // In packet buffer mode, we need to store the stats info from the MAC
   // in the pkt buffer, and then pass the stats to the register block
   // only when the packet that the stats refer to is read from the
   // pkt buffer
   wire     [1:0] rx_pbuf_size;        // Programmed size of available RX DPRAM
   wire   [p_edma_rx_pbuf_addr-1:0] rx_cutthru_threshold; // Threshold value
   wire           rx_cutthru;          // Enable for cut-thru operation
   wire           tx_pbuf_size;        // Programmed size of available TX DPRAM
   wire           tx_pbuf_tcp_en;      // TCP TX checksum offload enable
   wire   [p_edma_tx_pbuf_addr-1:0] tx_cutthru_threshold; // Threshold value
   wire           tx_cutthru;          // Enable for cut-thru operation

   // signals between edma_top and gem_tx
   wire           dma_tx_end_tog;      // toggled at the end of frame
                                       // transmission (loads new tx
                                       // address and length).

   // handshaking signals between edma_top and gem_reg_top
   wire           rx_dma_stable_tog;   // status signals not changing, can
                                       // be sampled in pclk domain
   wire           tx_dma_stable_tog;   // status signals not changing, can
                                       // be sampled in pclk domain
   wire           tx_dma_stat_capt_tog;// tx dma status signals sampled in
                                       // pclk domain
   wire           rx_dma_stat_capt_tog;// rx dma status signals sampled in
                                       // pclk domain

   // signals from gem_reg_top to edma_top
   wire           tx_start_pclk;       // asserted when bit 9 of network
                                       // control register is written.
   wire           tx_halt_pclk;        // asserted when bit 10 of network
                                       // control register is written.
   wire           flush_rx_pkt_pclk;   // asserted when bit 18 of network
                                       // control register is written.
   wire           hdr_data_splitting_en;// Header Data Splitting Enable
   wire           infinite_last_dbuf_size_en;     // data buffer pointed to by last descriptor is infinite size
   wire           crc_error_report;    // jumbo length reporting
   wire     [4:0] ahb_burst_length;    // AHB burst length control
   wire     [1:0] endian_swap;         // Endian swap enable
   wire [(p_edma_queues*32)-1:0] tx_dma_descr_base_addr; // base position of the tx buffer
                                       // queue pointer list.
   wire [(p_edma_queues*4)-1:0]  tx_dma_descr_base_par;   // Parity
   wire           new_transmit_q_ptr;  // asserted when tx queue pointer
                                       // is written.
   wire [(p_edma_queues*32)-1:0] rx_dma_descr_base_addr; // buffer queue (descriptor list) base
                                       // address.
   wire [(p_edma_queues*4)-1:0]  rx_dma_descr_base_par;   // Parity
   wire [(p_edma_queues*8)-1:0] rx_dma_buffer_size;      // buffer depth (in x64 bytes)
   wire           new_receive_q_ptr;   // asserted when receive queue pointer
                                       // is written.
   wire     [1:0] rx_dma_buffer_offset;    // offset of the data from buffer
                                       // beginning.

   // signals from edma_top to gem_reg_top
   wire           tx_dma_complete_ok;  // tx_frame_end indication.
   wire           rx_dma_complete_ok;  // asserted when a received frame
                                       // has been transferred to memory.
   wire           tx_dma_complete_ok_dma;  // tx_frame_end indication.
   wire           rx_dma_complete_ok_dma;  // asserted when a received frame
   wire           tx_dma_buffers_ex;   // sets bit in transmit status reg.
   wire           tx_dma_buff_ex_mid;  // sets bit in transmit status reg.
   wire           tx_dma_go;           // sets bit in transmit status reg.
   wire           tx_dma_hresp_notok;  // asserted when hresp is not OK.
   wire           tx_dma_buffers_ex_dma;   // sets bit in transmit status reg.
   wire           tx_dma_buff_ex_mid_dma;  // sets bit in transmit status reg.
   wire           tx_dma_go_dma;           // sets bit in transmit status reg.
   wire           tx_dma_hresp_notok_dma;  // asserted when hresp is not OK.
   wire           tx_dma_descr_ptr_tog_dma;

   wire           tx_dma_stable_tog_dma;
   wire           rx_dma_stable_tog_dma;


   wire           tx_dma_late_col_dma;
   wire           tx_dma_toomanyretry_dma;
   wire           tx_dma_underflow_dma;
   wire           tx_dma_late_col;     // late collision indicator
   wire           tx_dma_toomanyretry; // too many retires indicator
   wire           tx_dma_underflow;    // Underflow indicator
   wire [(p_edma_queues*32)-1:0] tx_dma_descr_ptr;    // Descriptor queue pointer for debug
   wire           tx_dma_descr_ptr_tog;   // handshaking for tx_dma_descr_ptr.
   wire           rx_dma_buff_not_rdy; // signal from the dma block to set
                                       // bit in receive status register.
   wire           rx_dma_resource_err; // indicates discard of a rx frame
                                       // due to no rx buffer available.
   wire           rx_dma_hresp_notok;  // asserted when hresp is not OK.
   wire           rx_buff_not_rdy_pclk;// pclk pulse to the posedge of corresp
                                       // flag

   wire  [(p_edma_queues*32)-1:0] rx_dma_descr_ptr;    // Descriptor queue pointer for debug
   wire           rx_dma_descr_ptr_tog;   // handshaking for rx_dma_descr_ptr.
   wire    [3:0]  tx_dma_int_queue;    // Identifies which queue the interupt
   wire    [3:0]  rx_dma_int_queue;    // is destined

   wire           back_pressure;       // goes to tx block to force
                                       // collisions on all incoming frames

   // the OR mask is used at the head of the DMA to force the
   // address of data buffer accesses only to that of the mask
   // value. The value in the mask register should only be used
   // by the DMA at the start of any packet transfer, so that
   // dynamic changes in the register value only affect full packets
   // (buffers do not end up being split in 2 different areas of memory).
   wire    [8:0]  dma_addr_or_mask;

   wire [(32*p_num_type1_screeners):0] screener_type1_regs; //
   wire [(32*p_num_type2_screeners):0] screener_type2_regs; //
   wire [(43*p_num_scr2_compare_regs):0] scr2_compare_regs;
   wire [(16*p_num_scr2_ethtype_regs):0] scr2_ethtype_regs;

   wire [47:0]              tx_pbuf_segments;
   wire [p_edma_queues-1:0] tx_disable_queue;
   wire [p_edma_queues-1:0] rx_disable_queue;

   // Credit Based Shaping support
   wire    [1:0] cbs_enable;          // Enable for CBS queues
   wire    [3:0] cbs_q_a_id;          // ID for top enabled queue
   wire    [3:0] cbs_q_b_id;          // ID for 2nd highest enabled queue
   wire   [31:0] idleslope_q_a;       // Rate of Change of credit for Queue A
   wire   [31:0] idleslope_q_b;       // Rate of Change of credit for Queue B
   wire   [31:0] port_tx_rate;        // Transmit rate
   wire  [31:0]  dwrr_ets_control;
   wire  [127:0] bw_rate_limit;

   wire    [3:0] dma_top_q_id;        // ID for top enabled queue

   wire   [13:0] jumbo_max_length;    // jumbo frame max length
   wire          ext_rxq_sel_en;      // enable external receive queue selection

   wire          soft_config_fifo_en; // use ext fifo interface

   // _mac indicates connections to MAC.
   // signal definition as previous non _mac signal

   wire                            late_coll_occured_mac;
   wire                            too_many_retries_mac;
   wire                            underflow_frame_mac;
   wire                            collision_occured_mac;
   wire                            dma_tx_end_tog_mac;
   wire                            dma_tx_status_tog_mac;
   wire                            dma_rx_status_tog_mac;
   wire    [p_edma_queues-1:0]     tx_r_rd_mac;
   wire    [p_edma_queues-1:0]     tx_r_rd_int_mac;
   wire    [3:0]                   tx_r_queue_mac;           // Queue ID, timed with tx_r_rd
   wire    [3:0]                   tx_r_queue_int_mac;       // early version, timed with tx_r_rd_int
   wire                            tx_end_tog_mac;
   wire                            rx_end_tog_mac;
   wire                            rx_status_wr_tog_mac;

   wire     [127:0]                tx_r_data_mac;
   wire     [15:0]                 tx_r_data_par_mac;
   wire      [3:0]                 tx_r_mod_mac;
   wire                            tx_r_sop_mac;
   wire                            tx_r_eop_mac;
   wire                            tx_r_err_mac;
   wire                            tx_r_valid_mac;
   wire   [p_edma_queues-1:0]      tx_r_data_rdy_mac;
   wire                            dma_is_busy_mac;
   wire                            tx_r_flushed_mac;
   wire                            tx_r_underflow_mac;
   wire                            tx_r_control_mac;
   wire   [p_edma_queues-1:0]      tx_r_frame_size_vld_mac; // We have the frame size.
   wire   [(p_edma_queues*14)-1:0] tx_r_frame_size_mac;     // Frame Length, 1 per queue
   wire   [p_edma_queues-1:0]      tx_r_launch_time_vld_mac;
   wire   [(p_edma_queues*32)-1:0] tx_r_launch_time_mac;

   // Extracted from MAC for lockup detection (passed SPRAM conversion)
   wire                            tx_r_sop_lockup;
   wire                            tx_r_eop_lockup;
   wire                            tx_r_valid_lockup;

   // _dma indicates connections to DMA.
   // signal definition as previous non _dma signal

   wire     [127:0]                tx_r_data_pad_dma;
   wire     [15:0]                 tx_r_data_par_pad_dma;
   wire [p_emac_bus_width-1:0]     tx_r_data_dma;
   wire [p_emac_bus_pwid-1:0]      tx_r_data_par_dma;
   wire      [3:0]                 tx_r_mod_dma;
   wire                            tx_r_sop_dma;
   wire                            tx_r_eop_dma;
   wire                            tx_r_err_dma;
   wire                            tx_r_valid_dma;
   wire   [p_edma_queues-1:0]      tx_r_data_rdy_dma;
   wire                            tx_r_flushed_dma;
   wire                            tx_r_underflow_dma;
   wire                            tx_r_control_dma;
   wire   [p_edma_queues-1:0]      tx_r_frame_size_vld_dma; // We have the frame size.
   wire   [(p_edma_queues*14)-1:0] tx_r_frame_size_dma;     // Frame Length, 1 per queue
   wire   [p_edma_queues-1:0]      tx_r_launch_time_vld_dma;
   wire   [(p_edma_queues*32)-1:0] tx_r_launch_time_dma;

   wire                            dma_tx_end_tog_dma;
   wire                            dma_tx_status_tog_dma;
   wire    [p_edma_queues-1:0]     tx_r_rd_dma;
   wire    [3:0]                   tx_r_queue_dma;           // Queue ID, timed with tx_r_rd
   wire    [p_edma_queues-1:0]     tx_r_rd_int_dma;
   wire    [3:0]                   tx_r_queue_int_dma;       // early version, timed with tx_r_rd_int

   wire     [127:0]                tx_r_data_pad;
   wire     [15:0]                 tx_r_data_par_pad;

   wire                            late_coll_occured_dma;
   wire                            too_many_retries_dma;
   wire                            underflow_frame_dma;
   wire                            collision_occured_dma;

   wire                            rx_w_bad_frame_dma;
   wire    [13:0]                  rx_w_frame_length_dma;
   wire                            rx_w_vlan_tagged_dma;
   wire                            rx_w_prty_tagged_dma;
   wire    [3:0]                   rx_w_tci_dma;

   wire                            rx_w_broadcast_frame_dma;
   wire                            rx_w_mult_hash_match_dma;
   wire                            rx_w_uni_hash_match_dma;
   wire                            rx_w_ext_match1_dma;
   wire                            rx_w_ext_match2_dma;
   wire                            rx_w_ext_match3_dma;
   wire                            rx_w_ext_match4_dma;
   wire    [7:0]                   rx_w_add_match_dma;
   wire                            rx_w_type_match1_dma;
   wire                            rx_w_type_match2_dma;
   wire                            rx_w_type_match3_dma;
   wire                            rx_w_type_match4_dma;
   wire                            rx_w_checksumi_ok_dma;
   wire                            rx_w_checksumt_ok_dma;
   wire                            rx_w_checksumu_ok_dma;
   wire                            rx_w_snap_frame_dma;
   wire                            rx_w_crc_error_dma;

   wire                            dma_rx_status_tog_dma;

   wire   [(p_edma_queues*32)-1:0] tx_dma_descr_ptr_dma;
   wire   [(p_edma_queues*32)-1:0] rx_dma_descr_ptr_dma;

   wire                            rx_dma_buff_not_rdy_dma;
   wire                            rx_dma_resource_err_dma;
   wire                            rx_dma_hresp_notok_dma;
   wire                            rx_dma_descr_ptr_tog_dma;
   wire     [11:0]                 rx_w_l4_offset_dma;
   wire     [11:0]                 rx_w_pld_offset_dma;
   wire                            dma_rx_end_tog_dma;

   wire                            enable_transmit_dma;
   wire                            enable_receive_dma;

   // _reg indicates connections to REG_TOP.
   // signal definition as previous non _reg signal
   // Stats into reg_top ... (non packet buffer versions)
   wire      [13:0]                rx_bytes_in_frame_reg;
   wire                            rx_broadcast_frame_reg;
   wire                            rx_multicast_frame_reg;
   wire                            rx_frame_rxed_ok_reg;
   wire                            rx_align_error_reg;
   wire                            rx_crc_error_reg;
   wire                            rx_short_error_reg;
   wire                            rx_long_error_reg;
   wire                            rx_jabber_error_reg;
   wire                            rx_symbol_error_reg;
   wire                            rx_pause_frame_reg;
   wire                            rx_pause_nonzero_reg;
   wire                            rx_length_error_reg;
   wire                            rx_ip_ck_error_reg;
   wire                            rx_tcp_ck_error_reg;
   wire                            rx_udp_ck_error_reg;
   wire                            rx_overflow_reg;

   // Stats into the reg_top ... (packet buffer versions)
   wire                            rx_pkt_dbuff_overflow;
   wire                            rx_dma_pkt_flushed_reg;
   wire                            rx_pkt_end_tog_dma;
   wire                            rx_pkt_status_wr_tog_dma;

   wire                            rx_end_tog_reg;
   wire                            rx_status_wr_tog_reg;

   wire                            fifo_enable;    // select ext fifo port


   wire  [7:0]                     max_num_axi_ar2r;
   wire  [7:0]                     max_num_axi_aw2w;
   wire                            use_aw2b_fill;
   wire                            axi_tx_frame_too_large;
   wire                            axi_xaction_out;
   wire                            disable_tx;
   wire                            disable_rx;

   // RSC specific decode
   wire  [14:0]                    rsc_en;
   wire                            rsc_stop;        // Set if any of the SYN/FIN/RST/URG
                                                    // flags are set in the TCP header
   wire                            rsc_push;        // Set if the PSH flas is set
   wire  [31:0]                    tcp_seqnum;      // Identifies the TCP seqnum of the frame
   wire                            tcp_syn;         // Set if the SYN flas is set
   wire  [15:0]                    tcp_payload_len; // Payload Length
   wire  [p_edma_queues-1:0]       rsc_clr_tog;     // Receive Side Coalescing clear

   // 64b addressing and extended BD signals from reg_top
   wire  [31:0]                    upper_tx_q_base_addr;
   wire  [3:0]                     upper_tx_q_base_par;
   wire  [31:0]                    upper_rx_q_base_addr;
   wire  [3:0]                     upper_rx_q_base_par;
   wire                            dma_addr_bus_width;

   wire                            tx_bd_extended_mode_en;
   wire  [1:0]                     tx_bd_ts_mode;

   wire                            rx_bd_extended_mode_en;
   wire  [1:0]                     rx_bd_ts_mode;

   wire        event_frame_tx;
   wire        general_frame_tx;
   wire        general_frame_rx;


   wire [41:0] tx_timestamp_edma;
   wire [41:0] rx_timestamp_edma;
   wire  [5:0] tx_timestamp_prty_edma; // RAS - parity protection for the TX Timestamp[41:0] to DMA Descriptor
   wire  [5:0] rx_timestamp_prty_edma; // RAS - parity protection for the RX Timestamp[41:0] to DMA Descriptor

   wire  [(p_edma_tx_pbuf_addr*p_edma_queues)-1:0] tx_dpram_fill_lvl_dbg;
   wire  [p_edma_rx_pbuf_addr-1:0]                 rx_dpram_fill_lvl_dbg;

   // lockup detection
   wire  [p_edma_queues-1:0]      tx_edma_full_pkt_inc;   // Per queue pulse as full packet written to SRAM
   wire  [p_edma_queues-1:0]      tx_edma_used_bit_vec;   // Per queue pulse when used bit is read
   wire                           tx_edma_lockup_flush;   // Major DMA TX error, clear down lockup detection
   wire                           rx_edma_overflow;       // Overflow on DMA RX write

   wire [p_edma_tx_pbuf_addr-1:0] axi_tx_full_adj_0;
   wire [p_edma_tx_pbuf_addr-1:0] axi_tx_full_adj_1;
   wire [p_edma_tx_pbuf_addr-1:0] axi_tx_full_adj_2;
   wire [p_edma_tx_pbuf_addr-1:0] axi_tx_full_adj_3;
   wire [3:0]                    restart_counter_top;

   // EnST signals
   wire [7:0]   enst_en;      // Disable/Enable Vector for the EnST module
   wire [255:0] start_time;   // start_time of the transmission
   wire [135:0] on_time;      // on time of the transmission
   wire [135:0] off_time;     // off time of the transmission expressed in bytes

   wire asf_dap_mac_rx_err;   // Parity error in MAC RX rx_clk
   wire asf_dap_mac_tx_err;   // Parity error in MAC TX tx_clk
   wire asf_dap_tx_rd_err;    // Parity error in DMA tx read block (tx_clk or a/hclk if spram)
   wire asf_dap_tx_wr_err;    // Parity error in DMA tx write block (a/hclk)
   wire asf_dap_rx_wr_err;    // Parity error in DMA RX write block rx_clk
   wire asf_dap_rx_rd_err;    // Parity error in DMA RX read block a/hclk
   wire asf_dap_mac_tx_ts_err;// Parity error in timestamp output from MAC TX tx_clk
   wire asf_dap_mac_rx_ts_err;// Parity error in timestamp output from MAC RX rx_clk

   wire asf_integrity_dma_err;// Integrity check error in DMA domain
   wire asf_integrity_tsu_err;// Integrity check error in TSU protection
   wire asf_integrity_tx_sched_err;   // Integrity check error in Transmit Scheduling
   wire asf_dap_txclk_err;    // Combined TX clock domain parity errors
   wire asf_dap_rxclk_err;    // Combined RX clock domain parity errors
   wire asf_dap_dma_err;      // Combined DMA clock domain parity errors

   // DAP faults can come from 3 different clock domains:
   // MAC TX clock:
   //   MAC TX (including timestamp capture check)    asf_dap_mac_tx_ts_err
   //   DMA TX RD (if DPRAM mode)                     asf_dap_tx_rd_err
   // MAC RX clock:
   //   MAC RX (including timestamp capture check)    asf_dap_mac_rx_ts_err
   //   DMA RX WR                                     asf_dap_rx_wr_err
   // DMA clock:
   //   AXI TX/RX                                     already combined to asf_dap_tx_wr_err and asf_dap_rx_rd_err
   //   DMA TX WR                                     asf_dap_tx_wr_err
   //   DMA TX RD (if SPRAM mode)                     asf_dap_tx_rd_err
   //   DMA RX RD                                     asf_dap_rx_rd_err
   assign asf_dap_rxclk_err = asf_dap_mac_rx_err | asf_dap_mac_rx_ts_err | asf_dap_rx_wr_err;
   assign asf_dap_txclk_err = (p_edma_spram == 1) ? asf_dap_mac_tx_err | asf_dap_mac_tx_ts_err
                                                  : asf_dap_mac_tx_err | asf_dap_mac_tx_ts_err | asf_dap_tx_rd_err;
   assign asf_dap_dma_err   = (p_edma_spram == 1) ? asf_dap_tx_wr_err | asf_dap_tx_rd_err | asf_dap_rx_rd_err
                                                  : asf_dap_tx_wr_err | asf_dap_rx_rd_err;

   // Integrity faults from:
   // TSU clock:
   //   TSU duplication check
   // Others?

   // ASF - from SRAM protection
   wire                   tx_corr_err;    // Correctable error for TX SRAM
   wire                   tx_uncorr_err;  // Uncorrectable error for TX SRAM
   wire   [p_edma_tx_pbuf_addr-1:0]
                          tx_err_addr;    // Address of TX SRAM error
   wire                   rx_corr_err;    // Correctable error for RX SRAM
   wire                   rx_uncorr_err;  // Uncorrectable error for RX SRAM
   wire   [p_edma_rx_pbuf_addr-1:0]
                          rx_err_addr;    // Address of RX SRAM error

   // signals going to lockup detection
   wire                   dma_tx_lockup_mon_en;
   wire                   dma_rx_lockup_mon_en;
   wire   [p_edma_queues-1:0]
                          dma_tx_lockup_q_en;
   wire                   tx_lockup_mon_en;
   wire                   rx_lockup_mon_en;
   wire   [15:0]          lockup_prescale_val;    // Prescaler reset value
   wire   [10:0]          dma_lockup_time;        // DMA lockup time
   wire   [10:0]          tx_mac_lockup_time;     // MAC TX lockup time
   wire   [15:0]          rx_mac_lockup_time;     // MAC RX lockup time
   wire                   lockup_prescale_tog;    // Toggle based on prescaler

   // signals from lockup detection
   wire                   dma_tx_lockup_detected;
   wire                   dma_rx_lockup_detected;
   wire                   tx_lockup_detected;
   wire                   rx_lockup_detected;

   // Signals for 802.1CB
   wire   [15:0]  frer_to_cnt;          // Count of number of frer_to_cnt_tog
                                        // without passing frames before timeout
   wire   [15:0]  frer_rtag_ethertype;  // Ethertype for redundancy tag detect
   wire           frer_strip_rtag;      // Strip redundancy tags
   wire           frer_6b_tag;          // R-Tag is 6-bytes not 4-bytes
   wire   [p_gem_num_cb_streams-1:0]
                  frer_en_vec_alg;      // Select which algorithm to use.
   wire   [p_gem_num_cb_streams-1:0]
                  frer_use_rtag;        // Set to use RTag or offset for seqnum

   wire   [(p_gem_num_cb_streams*9)-1:0]
                  frer_seqnum_oset;     // Offset into frame for seqnum
   wire   [(p_gem_num_cb_streams*5)-1:0]
                  frer_seqnum_len;      // Number of bits of seqnum to use
   wire   [(p_gem_num_cb_streams*4)-1:0]
                  frer_scr_sel_1;       // Screener match for stream 1
   wire   [(p_gem_num_cb_streams*4)-1:0]
                  frer_scr_sel_2;       // Screener match for stream 2
   wire   [(p_gem_num_cb_streams*6)-1:0]
                  frer_vec_win_sz;      // History depth to use for vec rcv alg

   wire   [p_gem_num_cb_streams-1:0]
                  frer_en_elim;         // Enable 802.1CB elimination function
   wire   [p_gem_num_cb_streams-1:0]
                  frer_en_to;           // Enable 802.1CB timeout function

   wire   [p_gem_num_cb_streams-1:0]
                  frer_to_tog;          // Toggle to indicate timeout occurred

   wire   [p_gem_num_cb_streams-1:0]
                  frer_rogue_tog;       // Toggle to indicate rogue frame rcvd
   wire   [p_gem_num_cb_streams-1:0]
                  frer_ooo_tog;         // Toggle to indicate out of order frame
   wire   [p_gem_num_cb_streams-1:0]
                  frer_err_upd_tog;     // Toggle to enable update latent errors
   wire   [(p_gem_num_cb_streams*7)-1:0]
                  frer_err_upd_val;     // Incrememt value, use with above

   // per queue rx flushing signals
   wire   [(32*p_edma_queues)-1:0] rx_q_flush_pclk;
   wire        [p_edma_queues-1:0] drop_all_frames_rx_clk;
   wire        [p_edma_queues-1:0] force_discard_on_err_q;
   wire        [p_edma_queues-1:0] limit_num_bytes_allowed_ambaclk;
   wire        [p_edma_queues-1:0] fill_lvl_breached;
   wire        [p_edma_queues-1:0] limit_frames_size_rx_clk;
   wire   [(16*p_edma_queues)-1:0] max_val_pclk;

   // per type 2 screener rate limiting algorithm registers
   wire   [(32*p_num_type2_screeners):0] scr2_rate_lim;
   wire        [p_num_type2_screeners:0] scr_excess_rate;
   wire                                  frame_flushed_tog;

   // AXI QoS configuration
   wire   [(8*p_edma_queues)-1:0] axi_qos_q_mapping;

   wire           rx_fill_level_high;
   wire           rx_fill_level_low;
   wire           block_sram_ecc_check;   // For SPRAN configs edma_spram_tx_mac_buffer may generate a redundant
                                          // read from an unitialised memory location. This signal prevents an
                                          // error being reported if SRAM parity protection is enabled

//------------------------------------------------------------------------------
// Beginning of code
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// instantiate the gem_mac (gem_tx, gem_rx, gem_filter & gem_loop).
//------------------------------------------------------------------------------


   // Pad to 128-bits
   generate if (p_emac_bus_width < 32'd128) begin : gen_tx_r_data_pad
     assign tx_r_data_pad     = {{128-p_emac_bus_width{1'b0}},tx_r_data};
     assign tx_r_data_par_pad = {{(16-p_emac_bus_pwid){1'b0}},tx_r_data_par};
   end else begin : gen_no_tx_r_data_pad
     assign tx_r_data_pad     = tx_r_data;
     assign tx_r_data_par_pad = tx_r_data_par;
   end
   endgenerate


  // If the dma bus width is configured to be larger than the theoretical maximum
  // mac bus width then we need to limit the mac bus width to be the correct
  // size
  wire [1:0] emac_bus_width_max = p_emac_bus_width == 32'd32 ? 2'b00 :
                                  p_emac_bus_width == 32'd64 ? 2'b01 :
                                                               2'b10 ;
  wire [1:0] emac_bus_width = (dma_bus_width > emac_bus_width_max) ? emac_bus_width_max : dma_bus_width;


  wire ambaclk;
  wire ambarst_n;
  generate if (p_edma_axi == 1'b1) begin : gen_setaxiclks
    assign ambaclk   = aclk;
    assign ambarst_n = n_areset;
  end else begin : gen_no_setaxiclks
    assign ambaclk   = hclk;
    assign ambarst_n = n_hreset;
  end
  endgenerate


   gem_mac #(.grouped_params(grouped_params))

   i_gem_mac (

      // system signals.
      .n_txreset               (n_txreset),
      .n_rxreset               (n_rxreset),

      // loopback clock
      .n_ntxreset              (n_ntxreset),
      .n_tx_clk                (n_tx_clk),
      .tsu_clk                 (tsu_clk),
      .n_tsureset              (n_tsureset),
      .pclk                    (pclk),
      .n_preset                (n_preset),
      .n_hreset                (ambarst_n),
      .hclk                    (ambaclk),

      .screener_type1_regs     (screener_type1_regs),
      .screener_type2_regs     (screener_type2_regs),
      .scr2_compare_regs       (scr2_compare_regs),
      .scr2_ethtype_regs       (scr2_ethtype_regs),

      .rx_br_halt              (rx_br_halt),

      // gmii/mii signals.
      .tx_clk                  (tx_clk),
      .rx_clk                  (rx_clk),
      .txd_gmii                (txd),
      .txd_par_gmii            (txd_par),
      .tx_en_gmii              (tx_en),
      .tx_er_gmii              (tx_er),
      .rxd_gmii                (rxd),
      .rxd_par_gmii            (rxd_par),
      .rx_er_gmii              (rx_er),
      .rx_dv_gmii              (rx_dv),
      .col                     (col),
      .crs                     (crs),

      // dedicated pcs Interface.
      .tx_er_pcs               (tx_er_pcs),
      .txd_pcs                 (txd_pcs),
      .txd_par_pcs             (txd_par_pcs),
      .tx_en_pcs               (tx_en_pcs),
      .rxd_pcs                 (rxd_pcs),
      .rxd_par_pcs             (rxd_par_pcs),
      .rx_er_pcs               (rx_er_pcs),
      .rx_dv_pcs               (rx_dv_pcs),
      .col_pcs                 (col_pcs),
      .crs_pcs                 (crs_pcs),

      // top level ethernet signals.
      .txd_frame_size          (txd_frame_size),
      .txd_rdy                 (txd_rdy),
      .tx_pause                (tx_pause),
      .tx_pause_zero           (tx_pause_zero),
      .tx_pfc_sel              (tx_pfc_sel),
      .tx_pfc_pause            (tx_pfc_pause),
      .tx_pfc_pause_zero       (tx_pfc_pause_zero),
      .wol                     (wol),

      // external filter interface
      .ext_match1              (ext_match1),
      .ext_match2              (ext_match2),
      .ext_match3              (ext_match3),
      .ext_match4              (ext_match4),
      .ext_da                  (ext_da),
      .ext_da_stb              (ext_da_stb),
      .ext_sa                  (ext_sa),
      .ext_sa_stb              (ext_sa_stb),
      .ext_type                (ext_type),
      .ext_type_stb            (ext_type_stb),
      .ext_ip_sa               (ext_ip_sa),
      .ext_ip_sa_stb           (ext_ip_sa_stb),
      .ext_ip_da               (ext_ip_da),
      .ext_ip_da_stb           (ext_ip_da_stb),
      .ext_source_port         (ext_source_port),
      .ext_sp_stb              (ext_sp_stb),
      .ext_dest_port           (ext_dest_port),
      .ext_dp_stb              (ext_dp_stb),
      .ext_ipv6                (ext_ipv6),

      .stacked_vlantype        (stacked_vlantype),
      .ext_vlan_tag1           (ext_vlan_tag1),
      .ext_vlan_tag1_stb       (ext_vlan_tag1_stb),
      .ext_vlan_tag2           (ext_vlan_tag2),
      .ext_vlan_tag2_stb       (ext_vlan_tag2_stb),

      // precision time protocol signals for IEEE 1588 support
      .sof_tx                  (sof_tx),
      .sync_frame_tx           (sync_frame_tx),
      .delay_req_tx            (delay_req_tx),
      .pdelay_req_tx           (pdelay_req_tx),
      .pdelay_resp_tx          (pdelay_resp_tx),
      .general_frame_tx        (general_frame_tx),
      .event_frame_tx          (event_frame_tx),
      .sof_rx                  (sof_rx),
      .sync_frame_rx           (sync_frame_rx),
      .delay_req_rx            (delay_req_rx),
      .pdelay_req_rx           (pdelay_req_rx),
      .pdelay_resp_rx          (pdelay_resp_rx),
      .general_frame_rx        (general_frame_rx),

      // signals coming from gem_reg_top (gem_registers).
      .full_duplex             (full_duplex),
      .bit_rate                (speed_mode[0]),
      .gigabit                 (speed_mode[1]),
      .tbi                     (speed_mode[2]),
      .two_pt_five_gig         (speed_mode[3]),
      .tx_byte_mode            (tx_byte_mode),
      .dma_bus_width           (emac_bus_width),
      .enable_transmit         (enable_transmit),
      .enable_receive          (enable_receive),
      .jumbo_enable            (jumbo_enable),
      .pause_enable            (pause_enable),
      .retry_test              (retry_test),
      .tx_pause_quantum        (tx_pause_quantum),
      .tx_pause_quantum_par    (tx_pause_quantum_par),
      .tx_pause_quantum_p1     (tx_pause_quantum_p1),
      .tx_pause_quantum_p1_par (tx_pause_quantum_p1_par),
      .tx_pause_quantum_p2     (tx_pause_quantum_p2),
      .tx_pause_quantum_p2_par (tx_pause_quantum_p2_par),
      .tx_pause_quantum_p3     (tx_pause_quantum_p3),
      .tx_pause_quantum_p3_par (tx_pause_quantum_p3_par),
      .tx_pause_quantum_p4     (tx_pause_quantum_p4),
      .tx_pause_quantum_p4_par (tx_pause_quantum_p4_par),
      .tx_pause_quantum_p5     (tx_pause_quantum_p5),
      .tx_pause_quantum_p5_par (tx_pause_quantum_p5_par),
      .tx_pause_quantum_p6     (tx_pause_quantum_p6),
      .tx_pause_quantum_p6_par (tx_pause_quantum_p6_par),
      .tx_pause_quantum_p7     (tx_pause_quantum_p7),
      .tx_pause_quantum_p7_par (tx_pause_quantum_p7_par),
      .tx_pause_frame_req      (tx_pause_frame_req),
      .tx_pause_frame_zero     (tx_pause_frame_zero),
      .tx_pfc_frame_req        (tx_pfc_frame_req),
      .tx_pfc_frame_pri        (tx_pfc_frame_pri),
      .tx_pfc_frame_pri_par    (tx_pfc_frame_pri_par),
      .tx_pfc_frame_zero       (tx_pfc_frame_zero),
      .tx_lpi_en               (tx_lpi_en),
      .ifg_eats_qav_credit     (ifg_eats_qav_credit),
      .tw_sys_tx_time          (tw_sys_tx_time),
      .tx_status_wr_tog        (tx_status_wr_tog),
      .rx_status_wr_tog        (rx_status_wr_tog_mac),
      .rx_no_crc_check         (rx_no_crc_check),
      .tx_pause_tog_ack        (tx_pause_tog_ack),
      .rx_1536_en              (rx_1536_en),
      .strip_rx_fcs            (strip_rx_fcs),
      .rx_no_pause_frames      (rx_no_pause_frames),
      .rx_toe_enable           (rx_toe_enable),
      .pfc_enable              (pfc_enable),
      .ptp_unicast_ena         (ptp_unicast_ena),
      .rx_ptp_unicast          (rx_ptp_unicast),
      .tx_ptp_unicast          (tx_ptp_unicast),
      .rx_fill_level_low       (rx_fill_level_low),
      .rx_fill_level_high      (rx_fill_level_high),
      .check_rx_length         (check_rx_length),
      .loopback_local          (loopback_local),
      .halfduplex_fc_en        (halfduplex_flow_control_en),
      .back_pressure           (back_pressure),
      .en_half_duplex_rx       (en_half_duplex_rx),
      .ext_match_en            (ext_match_en),
      .uni_hash_en             (uni_hash_en),
      .multi_hash_en           (multi_hash_en),
      .no_broadcast            (no_broadcast),
      .copy_all_frames         (copy_all_frames),
      .rm_non_vlan             (rm_non_vlan),
      .hash                    (hash),
      .mask_add1               (mask_add1),
       // Credit Based Shaping and scheduler
      .cbs_enable              (cbs_enable),
      .cbs_q_a_id              (cbs_q_a_id),
      .cbs_q_b_id              (cbs_q_b_id),
      .idleslope_q_a           (idleslope_q_a),
      .idleslope_q_b           (idleslope_q_b),
      .port_tx_rate            (port_tx_rate),
      .dwrr_ets_control        (dwrr_ets_control),
      .bw_rate_limit           (bw_rate_limit),
      .spec_add_filter_regs    (spec_add_filter_regs),
      .spec_add_filter_active  (spec_add_filter_active),
      .spec_add1_tx            (spec_add1_tx),
      .spec_add1_tx_par        (spec_add1_tx_par),
      .spec_type1              (spec_type1),
      .spec_type2              (spec_type2),
      .spec_type3              (spec_type3),
      .spec_type4              (spec_type4),
      .spec_type1_active       (spec_type1_active),
      .spec_type2_active       (spec_type2_active),
      .spec_type3_active       (spec_type3_active),
      .spec_type4_active       (spec_type4_active),
      .wol_ip_addr             (wol_ip_addr),
      .wol_mask                (wol_mask),
      .stretch_enable          (stretch_enable),
      .stretch_ratio           (stretch_ratio),
      .min_ifg                 (min_ifg),
      .rx_bad_preamble         (rx_bad_preamble),
      .ign_ipg_rx_er           (ign_ipg_rx_er),
      .store_udp_offset        (store_udp_offset),

      .store_rx_ts             (store_rx_ts),
      .tsu_ptp_tx_timer_out    (tsu_ptp_tx_timer_out_mac),
      .tsu_ptp_rx_timer_out    (tsu_ptp_rx_timer_out_mac),
      .tsu_ptp_tx_timer_par_out(tsu_ptp_tx_timer_prty_out_mac),  // RAS - Timestamp parity protection
      .tsu_ptp_rx_timer_par_out(tsu_ptp_rx_timer_prty_out_mac),  // RAS - Timestamp parity protection
      .one_step_sync_mode      (one_step_sync_mode),
      .oss_correction_field    (oss_correction_field),
      .tsu_timer_cnt           (tsu_timer_cnt[93:16]),
      .tsu_timer_cnt_par       (tsu_timer_cnt_par[11:2]),

      // signals coming from edma_top.
      // (or external tx fifo interface).
      .tx_r_data               (tx_r_data_mac),
      .tx_r_data_par           (tx_r_data_par_mac),
      .tx_r_mod                (tx_r_mod_mac),
      .tx_r_sop                (tx_r_sop_mac),
      .tx_r_eop                (tx_r_eop_mac),
      .tx_r_err                (tx_r_err_mac),
      .tx_r_valid              (tx_r_valid_mac),
      .tx_r_data_rdy           (tx_r_data_rdy_mac),
      .dma_is_busy             (dma_is_busy_mac),
      .tx_r_flushed            (tx_r_flushed_mac),
      .tx_r_underflow          (tx_r_underflow_mac),
      .tx_r_control            (tx_r_control_mac),
      .tx_r_frame_size_vld     (tx_r_frame_size_vld_mac),
      .tx_r_frame_size         (tx_r_frame_size_mac),
      .tx_r_launch_time_vld    (tx_r_launch_time_vld_mac),
      .tx_r_launch_time        (tx_r_launch_time_mac),

      // signals going to edma_top.
      // (or external tx fifo interface).
      .tx_r_rd                 (tx_r_rd_mac),
      .tx_r_rd_int             (tx_r_rd_int_mac),
      .tx_r_queue              (tx_r_queue_mac),
      .tx_r_queue_int          (tx_r_queue_int_mac),

      // signals going to edma_top.
      // (or external rx fifo interface).
      .rx_w_wr                 (rx_w_wr_mac),
      .rx_w_data               (rx_w_data_mac),
      .rx_w_data_par           (rx_w_data_par_mac),
      .rx_w_mod                (rx_w_mod_mac),
      .rx_w_sop                (rx_w_sop_mac),
      .rx_w_eop                (rx_w_eop_mac),
      .rx_w_err                (rx_w_err_mac),
      .rx_w_flush              (rx_w_flush_mac),

      .tx_r_timestamp          (tx_r_timestamp),
      .rx_w_timestamp          (rx_w_timestamp),
      // ASF - Timestamp parity protection
      .tx_r_timestamp_par      (tx_r_timestamp_par),
      .rx_w_timestamp_par      (rx_w_timestamp_par),

      // signal coming from edma_top or from ext interface
      .rx_w_overflow           (rx_w_overflow_mac),

      // signals going to edma_top.
      .rx_w_bad_frame          (rx_w_bad_frame),
      .rx_w_frame_length       (rx_w_frame_length),
      .rx_w_vlan_tagged        (rx_w_vlan_tagged),
      .rx_w_prty_tagged        (rx_w_prty_tagged),
      .rx_w_tci                (rx_w_tci),
      .rx_w_broadcast_frame    (rx_w_broadcast_frame),
      .rx_w_mult_hash_match    (rx_w_mult_hash_match),
      .rx_w_uni_hash_match     (rx_w_uni_hash_match),
      .rx_w_ext_match1         (rx_w_ext_match1),
      .rx_w_ext_match2         (rx_w_ext_match2),
      .rx_w_ext_match3         (rx_w_ext_match3),
      .rx_w_ext_match4         (rx_w_ext_match4),
      .rx_w_add_match          (rx_w_add_match),
      .rx_w_type_match1        (rx_w_type_match1),
      .rx_w_type_match2        (rx_w_type_match2),
      .rx_w_type_match3        (rx_w_type_match3),
      .rx_w_type_match4        (rx_w_type_match4),
      .rx_w_checksumi_ok       (rx_w_checksumi_ok),
      .rx_w_checksumt_ok       (rx_w_checksumt_ok),
      .rx_w_checksumu_ok       (rx_w_checksumu_ok),
      .rx_w_snap_frame         (rx_w_snap_frame),
      .rx_w_length_error       (rx_w_length_error),
      .rx_w_crc_error          (rx_w_crc_error),
      .rx_w_too_short          (rx_w_too_short),
      .rx_w_too_long           (rx_w_too_long),
      .rx_w_code_error         (rx_w_code_error),
      .rx_w_l4_offset          (rx_w_l4_offset),
      .rx_w_pld_offset         (rx_w_pld_offset),
      .rx_w_pld_offset_vld     (rx_w_pld_offset_vld),

      // status signals going to edma_top (or external tx fifo interface).
      .late_coll_occured       (late_coll_occured_mac),
      .too_many_retries        (too_many_retries_mac),
      .underflow_frame         (underflow_frame_mac),
      .collision_occured       (collision_occured_mac),

      // signals coming from edma_top (or external tx fifo interface).
      .dma_tx_status_tog       (dma_tx_status_tog_mac),
      .dma_rx_status_tog       (dma_rx_status_tog_mac),

      // signals going to edma_top (gem_hclk_syncs).
      .dma_tx_end_tog          (dma_tx_end_tog_mac),
      .dma_rx_end_tog          (dma_rx_end_tog_mac),

      // signals going to the gem_reg_top (gem_pclk_syncs)
      // for statistics register recording.
      .tx_end_tog              (tx_end_tog_mac),
      .rx_end_tog              (rx_end_tog_mac),
      .tx_bytes_in_frame       (tx_bytes_in_frame),
      .rx_bytes_in_frame       (rx_bytes_in_frame),
      .tx_broadcast_frame      (tx_broadcast_frame),
      .tx_multicast_frame      (tx_multicast_frame),
      .rx_broadcast_frame      (rx_broadcast_frame),
      .rx_multicast_frame      (rx_multicast_frame),
      .lpi_indicate            (lpi_indicate),
      .tx_coll_occured         (tx_coll_occured),
      .tx_frame_txed_ok        (tx_frame_txed_ok),
      .tx_single_coll_frame    (tx_single_coll_frame),
      .tx_multi_coll_frame     (tx_multi_coll_frame),
      .tx_deferred_tx_frame    (tx_deferred_tx_frame),
      .tx_late_coll_frame      (tx_late_coll_frame),
      .tx_crs_error_frame      (tx_crs_error_frame),
      .tx_too_many_retries     (tx_too_many_retries),
      .tx_underflow_frame      (tx_underflow_frame),
      .tx_pause_frame_txed     (tx_pause_frame_txed),
      .tx_pfc_pause_frame_txed (tx_pfc_pause_frame_txed),
      .tx_pause_time           (tx_pause_time),
      .tx_pause_time_tog       (tx_pause_time_tog),
      .rx_frame_rxed_ok        (rx_frame_rxed_ok),
      .rx_align_error          (rx_align_error),
      .rx_crc_error            (rx_crc_error),
      .rx_short_error          (rx_short_error),
      .rx_long_error           (rx_long_error),
      .rx_jabber_error         (rx_jabber_error),
      .rx_symbol_error         (rx_symbol_error),
      .rx_pause_frame          (rx_pause_frame),
      .rx_pause_nonzero        (rx_pause_nonzero),
      .rx_pfc_pause_frame      (rx_pfc_pause_frame),
      .rx_pfc_pause_nonzero    (rx_pfc_pause_nonzero),
      .rx_length_error         (rx_length_error),
      .rx_ip_ck_error          (rx_ip_ck_error),
      .rx_tcp_ck_error         (rx_tcp_ck_error),
      .rx_udp_ck_error         (rx_udp_ck_error),
      .rx_overflow             (rx_overflow),

      .queue_ptr_rx            (rx_w_queue),
      // PFC signals
      .pfc_negotiate           (pfc_negotiate),
      .rx_pfc_paused           (rx_pfc_paused),

      .soft_config_fifo_en     (soft_config_fifo_en),

      // RSC specific
      .rsc_stop                (rsc_stop),
      .rsc_push                (rsc_push),
      .tcp_seqnum              (tcp_seqnum),
      .tcp_syn                 (tcp_syn),
      .tcp_payload_len         (tcp_payload_len),

      .jumbo_max_length        (jumbo_max_length),
      .ext_rxq_sel_en          (ext_rxq_sel_en),

      // EnST signals
      .enst_en                 (enst_en),
      .start_time              (start_time),
      .on_time                 (on_time),
      .off_time                (off_time),
      .add_frag_size           (add_frag_size),
      .hold                    (hold),

      // RAS - signals going to gem_reg_top
      .asf_dap_mac_rx_err      (asf_dap_mac_rx_err),
      .asf_dap_mac_tx_err      (asf_dap_mac_tx_err),
      .asf_integrity_tx_sched_err
                               (asf_integrity_tx_sched_err),

      // 802.1CB Control and Status
      .frer_to_cnt             (frer_to_cnt),
      .frer_rtag_ethertype     (frer_rtag_ethertype),
      .frer_strip_rtag         (frer_strip_rtag),
      .frer_6b_tag             (frer_6b_tag),
      .frer_en_vec_alg         (frer_en_vec_alg),
      .frer_use_rtag           (frer_use_rtag),
      .frer_seqnum_oset        (frer_seqnum_oset),
      .frer_seqnum_len         (frer_seqnum_len),
      .frer_scr_sel_1          (frer_scr_sel_1),
      .frer_scr_sel_2          (frer_scr_sel_2),
      .frer_vec_win_sz         (frer_vec_win_sz),
      .frer_en_elim            (frer_en_elim),
      .frer_en_to              (frer_en_to),
      .frer_to_tog             (frer_to_tog),
      .frer_rogue_tog          (frer_rogue_tog),
      .frer_ooo_tog            (frer_ooo_tog),
      .frer_err_upd_tog        (frer_err_upd_tog),
      .frer_err_upd_val        (frer_err_upd_val),

      // Feedback for lockup detection
      .tx_r_sop_lockup         (tx_r_sop_lockup),
      .tx_r_eop_lockup         (tx_r_eop_lockup),
      .tx_r_valid_lockup       (tx_r_valid_lockup),

      // rx_q_flush signals to use by gem_rx_per_queue_flush module
      .max_val_pclk            (max_val_pclk),
      .drop_all_frames_rx_clk  (drop_all_frames_rx_clk),
      .limit_frames_size_rx_clk(limit_frames_size_rx_clk),
      .fill_lvl_breached       (fill_lvl_breached),

      // per type 2 screener rate limiting algorithm registers
      .scr2_rate_lim           (scr2_rate_lim),
      .scr_excess_rate         (scr_excess_rate),

      // toggle to stats, indicating a frame flushed by mode2, 3, or 4
      .frame_flushed_tog       (frame_flushed_tog),

      .block_sram_ecc_check    (block_sram_ecc_check)

   );

  // Populate the match vector based on the number of specific address filters in the design.
  // For non-existent filters, the match bit is set to 0.
  // Note that rx_w_add_match[0] always exists but is not used due to the way the MAC signals
  // are defined, hence the +1 shift.
  genvar spec_add_filters_var;
  generate for (spec_add_filters_var=0; spec_add_filters_var < 32'sd8; spec_add_filters_var=spec_add_filters_var+1)
  begin : gen_spec_flt_assign
    if (p_num_spec_add_filters[31:0] > spec_add_filters_var) begin : gen_exists
      assign rx_w_add_match_0to7[spec_add_filters_var]  = rx_w_add_match[spec_add_filters_var+1]; // Bit 0 is not used so shifted
    end else begin : gen_no_exists
      assign rx_w_add_match_0to7[spec_add_filters_var]  = 1'b0;
    end
  end
  endgenerate


// ------------------------------------------------------------------------------------------
// TX Connections ...
// ------------------------------------------------------------------------------------------
  generate if (p_edma_add_tx_external_fifo_if == 1'b1) begin : gen_txif
  // If we are adding a TX FIFO interface, then it can be done in one of 3 modes ...
  // 1. Without a DMA.  This is the simplest mode where the FIFO i/f is directly connected to the I/O of the GEM
  // 2. With a DMA with a static select - controlled via  gem_host_if_soft_select define, there is a static select between DMA and FIFO
  // 3. With a DMA and arbitration between FIFO and DMA. In this case, the GEM I/O needs to be arbitrated in

   wire           late_coll_occured;   // set if late collision occurs in
                                       // gigabit mode (flushes tx fifo),
                                       // cleared when dma_tx_status_tog
                                       // is returned.
   wire           too_many_retries;    // signals too many retries error
                                       // condition (flushes tx fifo),
                                       // cleared when dma_tx_status_tog
                                       // is returned.
   wire           underflow_frame;     // asserted high at the end of frame
                                       // to indicate a fifo underrun or
                                       // tx_r_err condition, cleared when
                                       // dma_tx_status_tog is returned.
   wire           collision_occured;   // set if collision happens during
                                       // frame transmission, cleared when
                                       // dma_tx_status_tog is returned.

  // First, for the 3rd mode, instantiate the arbitrating mux module ...
    if (p_edma_tx_add_fifo_if == 1) begin : gen_txif_dma_streamfifo // DMA and Ext FIFO TX Operate
      wire ext_fifo_clk;
      wire ext_fifo_rst_n;
      if (p_edma_spram == 1) begin : gen_ext_fifo_clk
        assign ext_fifo_clk = ambaclk;
        assign ext_fifo_rst_n = ambarst_n;
      end else begin : gen_dpram_clk
        assign ext_fifo_clk   = tx_clk;
        assign ext_fifo_rst_n = n_txreset;
      end
      gem_ext_fifo_mux
        #(.p_edma_queues(p_edma_queues))

      i_gem_ext_fifo_mux (

      // system signals.
      .n_txreset                   (ext_fifo_rst_n),

      // gmii/mii signals.
      .tx_clk                      (ext_fifo_clk),

      // signals coming from edma_top.
      .tx_r_data_dma               (tx_r_data_pad_dma),
      .tx_r_data_par_dma           (tx_r_data_par_pad_dma),
      .tx_r_mod_dma                (tx_r_mod_dma),
      .tx_r_sop_dma                (tx_r_sop_dma),
      .tx_r_eop_dma                (tx_r_eop_dma),
      .tx_r_err_dma                (tx_r_err_dma),
      .tx_r_valid_dma              (tx_r_valid_dma),
      .tx_r_data_rdy_dma           (tx_r_data_rdy_dma),
      .tx_r_flushed_dma            (tx_r_flushed_dma),
      .tx_r_underflow_dma          (tx_r_underflow_dma),
      .tx_r_control_dma            (tx_r_control_dma),
      .tx_r_frame_size_vld_dma     (tx_r_frame_size_vld_dma),
      .tx_r_frame_size_dma         (tx_r_frame_size_dma),
      .tx_r_launch_time_vld_dma    (tx_r_launch_time_vld_dma),
      .tx_r_launch_time_dma        (tx_r_launch_time_dma),

      // signals going to edma_top.
      .tx_r_rd_dma                 (tx_r_rd_dma),
      .tx_r_queue_dma              (tx_r_queue_dma),
      .tx_r_rd_int_dma             (tx_r_rd_int_dma),
      .tx_r_queue_int_dma          (tx_r_queue_int_dma),

      // status signals going to edma_top .
      // combined as tx_r_status[3:0] elsewhere
      .late_coll_occured_dma       (late_coll_occured_dma),
      .too_many_retries_dma        (too_many_retries_dma),
      .underflow_frame_dma         (underflow_frame_dma),
      .collision_occured_dma       (collision_occured_dma),

      // signals coming from edma_top .
      .dma_tx_status_tog_dma       (dma_tx_status_tog_dma),

      // signals going to edma_top (gem_hclk_syncs_dma).
      .dma_tx_end_tog_dma          (dma_tx_end_tog_dma),

      // signals coming from external tx fifo interface.
      .tx_r_data_ext               (tx_r_data_pad),
      .tx_r_data_par_ext           (tx_r_data_par_pad),
      .tx_r_mod_ext                (tx_r_mod),
      .tx_r_sop_ext                (tx_r_sop),
      .tx_r_eop_ext                (tx_r_eop),
      .tx_r_err_ext                (tx_r_err),
      .tx_r_valid_ext              (tx_r_valid),
      .tx_r_data_rdy_ext           (tx_r_data_rdy),
      .tx_r_flushed_ext            (tx_r_flushed),
      .tx_r_underflow_ext          (tx_r_underflow),
      .tx_r_control_ext            (tx_r_control),
      .tx_r_frame_size_vld_ext     (tx_r_frame_size_vld),
      .tx_r_frame_size_ext         (tx_r_frame_size),
      .tx_r_launch_time_vld_ext    ({p_edma_queues{1'b0}}),
      .tx_r_launch_time_ext        ({p_edma_queues*32{1'b0}}),

      // signals going to external tx fifo interface.
      .tx_r_rd_ext                 (tx_r_rd),
      .tx_r_queue_ext              (tx_r_queue),

      // status signals going to external tx fifo interface.
      // combined as tx_r_status[3:0] elsewhere
      .late_coll_occured_ext       (late_coll_occured),
      .too_many_retries_ext        (too_many_retries),
      .underflow_frame_ext         (underflow_frame),
      .collision_occured_ext       (collision_occured),

      // signals coming from external tx fifo interface.
      .dma_tx_status_tog_ext       (dma_tx_status_tog),

      // signals going to external tx fifo interface(gem_hclk_syncs).
      .dma_tx_end_tog_ext          (dma_tx_end_tog),


      // CONNECTIONS TO MAC

      // signals coming from edma_top.
      // or external tx fifo interface.
      .tx_r_data_mac               (tx_r_data_mac),
      .tx_r_data_par_mac           (tx_r_data_par_mac),
      .tx_r_mod_mac                (tx_r_mod_mac),
      .tx_r_sop_mac                (tx_r_sop_mac),
      .tx_r_eop_mac                (tx_r_eop_mac),
      .tx_r_err_mac                (tx_r_err_mac),
      .tx_r_valid_mac              (tx_r_valid_mac),
      .tx_r_data_rdy_mac           (tx_r_data_rdy_mac),
      .tx_r_flushed_mac            (tx_r_flushed_mac),
      .tx_r_underflow_mac          (tx_r_underflow_mac),
      .tx_r_control_mac            (tx_r_control_mac),
      .tx_r_frame_size_vld_mac     (tx_r_frame_size_vld_mac),
      .tx_r_frame_size_mac         (tx_r_frame_size_mac),
      .tx_r_launch_time_vld_mac    (tx_r_launch_time_vld_mac),
      .tx_r_launch_time_mac        (tx_r_launch_time_mac),

      // signals going to edma_top.
      .tx_r_rd_mac                 (tx_r_rd_mac),
      .tx_r_queue_mac              (tx_r_queue_mac),
      .tx_r_rd_int_mac             (tx_r_rd_int_mac),
      .tx_r_queue_int_mac          (tx_r_queue_int_mac),

      // status signals going to edma_top (or external tx fifo interface).
      // combined as tx_r_status[3:0] elsewhere
      .late_coll_occured_mac       (late_coll_occured_mac),
      .too_many_retries_mac        (too_many_retries_mac),
      .underflow_frame_mac         (underflow_frame_mac),
      .collision_occured_mac       (collision_occured_mac),

      // signals coming from edma_top (or external tx fifo interface).
      .dma_tx_status_tog_mac       (dma_tx_status_tog_mac),

      // signals going to edma_top (gem_hclk_syncs).
      .dma_tx_end_tog_mac          (dma_tx_end_tog_mac)
      );

      assign tx_dma_buffers_ex    = tx_dma_buffers_ex_dma;
      assign tx_dma_buff_ex_mid   = tx_dma_buff_ex_mid_dma;
      assign tx_dma_hresp_notok   = tx_dma_hresp_notok_dma;
      assign tx_dma_descr_ptr     = tx_dma_descr_ptr_dma;
      assign tx_dma_descr_ptr_tog = tx_dma_descr_ptr_tog_dma;

      // tx_go is set whenever transmit is enabled
      assign tx_dma_go            = tx_dma_go_dma;

      assign tx_dma_late_col      = tx_dma_late_col_dma;
      assign tx_dma_toomanyretry  = tx_dma_toomanyretry_dma;
      assign tx_dma_underflow     = tx_dma_underflow_dma;

      // DMA to registers handshaking diven by MAC to register handshaking
      // Note that dma_tx_status_togis driven by external FIFO status logic
      assign tx_dma_stable_tog    = tx_dma_stable_tog_dma;
      assign tx_dma_complete_ok   = tx_dma_complete_ok_dma;

      assign enable_transmit_dma  = enable_transmit;

      // LOW LATENCY PORT CONNECTIONS (combine signals to bus)
      assign tx_r_status[0]     = too_many_retries;
      assign tx_r_status[1]     = late_coll_occured;
      assign tx_r_status[2]     = collision_occured;
      assign tx_r_status[3]     = underflow_frame;
      assign dma_is_busy_mac    = 1'b0;
      assign fifo_enable        = 1'b0;

    end else if (p_edma_host_if_soft_select == 1) begin : gen_txif_dma_staticfifo

      // For the 2nd mode, drive the MAC signals based on a static select ...
      assign fifo_enable = soft_config_fifo_en;
      // connect MAC inputs to ext_fifo interface when fifo_enable = '1', otherwise connect to DMA
      assign tx_r_data_mac           = fifo_enable ? tx_r_data_pad          : tx_r_data_pad_dma;
      assign tx_r_data_par_mac       = fifo_enable ? tx_r_data_par_pad      : tx_r_data_par_pad_dma;
      assign tx_r_mod_mac            = fifo_enable ? tx_r_mod               : tx_r_mod_dma;
      assign tx_r_sop_mac            = fifo_enable ? tx_r_sop               : tx_r_sop_dma;
      assign tx_r_eop_mac            = fifo_enable ? tx_r_eop               : tx_r_eop_dma;
      assign tx_r_err_mac            = fifo_enable ? tx_r_err               : tx_r_err_dma;
      assign tx_r_valid_mac          = fifo_enable ? tx_r_valid             : tx_r_valid_dma;
      assign tx_r_data_rdy_mac       = fifo_enable ? tx_r_data_rdy          : tx_r_data_rdy_dma;
      assign dma_is_busy_mac         = fifo_enable ? 1'b0                   : dma_is_busy;
      assign tx_r_underflow_mac      = fifo_enable ? tx_r_underflow         : tx_r_underflow_dma;
      assign tx_r_flushed_mac        = fifo_enable ? tx_r_flushed           : tx_r_flushed_dma;
      assign tx_r_control_mac        = fifo_enable ? tx_r_control           : tx_r_control_dma;
      assign tx_r_frame_size_vld_mac = fifo_enable ? tx_r_frame_size_vld    : tx_r_frame_size_vld_dma;
      assign tx_r_frame_size_mac     = fifo_enable ? tx_r_frame_size        : tx_r_frame_size_dma;
      assign tx_r_launch_time_vld_mac= fifo_enable ? {p_edma_queues{1'b0}}  : tx_r_launch_time_vld_dma;
      assign tx_r_launch_time_mac    = fifo_enable ? {p_edma_queues{32'd0}} : tx_r_launch_time_dma;
      assign dma_tx_status_tog_mac   = fifo_enable ? dma_tx_status_tog      : dma_tx_status_tog_dma;

      // connect MAC outputs to ext_fifo interface and disable when not selected
      assign tx_r_rd                = fifo_enable ? tx_r_rd_int_mac       : {p_edma_queues{1'b0}};
      assign tx_r_queue             = fifo_enable ? tx_r_queue_mac        : 4'h0;
      assign late_coll_occured      = fifo_enable ? late_coll_occured_mac : 1'b0;
      assign too_many_retries       = fifo_enable ? too_many_retries_mac  : 1'b0;
      assign underflow_frame        = fifo_enable ? underflow_frame_mac   : 1'b0;
      assign collision_occured      = fifo_enable ? collision_occured_mac : 1'b0;
      assign dma_tx_end_tog         = fifo_enable ? dma_tx_end_tog_mac    : 1'b0;

      // connect MAC outputs to dma interface and disable when not selected
      assign tx_r_rd_dma            = fifo_enable ? {p_edma_queues{1'b0}} : tx_r_rd_mac;
      assign tx_r_queue_dma         = fifo_enable ? 4'h0          : tx_r_queue_mac;
      assign late_coll_occured_dma  = fifo_enable ? 1'b0          : late_coll_occured_mac;
      assign too_many_retries_dma   = fifo_enable ? 1'b0          : too_many_retries_mac;
      assign underflow_frame_dma    = fifo_enable ? 1'b0          : underflow_frame_mac;
      assign collision_occured_dma  = fifo_enable ? 1'b0          : collision_occured_mac;
      assign dma_tx_end_tog_dma     = fifo_enable ? 1'b0          : dma_tx_end_tog_mac;

      // if not using DMA tie off error reporting status outputs
      assign tx_dma_buffers_ex      = fifo_enable ?  1'b0         :  tx_dma_buffers_ex_dma;
      assign tx_dma_buff_ex_mid     = fifo_enable ?  1'b0         :  tx_dma_buff_ex_mid_dma;
      assign tx_dma_hresp_notok     = fifo_enable ?  1'b0         :  tx_dma_hresp_notok_dma;
      assign tx_dma_descr_ptr       = fifo_enable ?  {(p_edma_queues*32){1'b0}} :  tx_dma_descr_ptr_dma;
      assign tx_dma_descr_ptr_tog   = fifo_enable ?  1'b0         :  tx_dma_descr_ptr_tog_dma;

      // tx_go is set whenever transmit is enabled
      assign tx_dma_go              = fifo_enable ?  enable_transmit:  tx_dma_go_dma;

      assign tx_r_rd_int_dma        = fifo_enable ? {p_edma_queues{1'b0}} : tx_r_rd_int_mac;
      assign tx_r_queue_int_dma     = fifo_enable ? 4'h0                  : tx_r_queue_int_mac;
      assign tx_dma_late_col        = fifo_enable ? late_coll_occured_mac : tx_dma_late_col_dma;
      assign tx_dma_toomanyretry    = fifo_enable ? too_many_retries_mac  : tx_dma_toomanyretry_dma;
      assign tx_dma_underflow       = fifo_enable ? underflow_frame_mac   : tx_dma_underflow_dma;

      // DMA to registers handshaking diven by MAC to register handshaking
      // Note that dma_tx_status_tog is driven by external FIFO status logic
      assign tx_dma_stable_tog      = fifo_enable ? tx_end_tog_mac:  tx_dma_stable_tog_dma;
      assign tx_dma_complete_ok     = fifo_enable ? 1'b0 : tx_dma_complete_ok_dma;

      assign enable_transmit_dma    = fifo_enable ? 1'b0 : enable_transmit;

      assign tx_r_status[0]     = fifo_enable ? too_many_retries    : 1'b0;
      assign tx_r_status[1]     = fifo_enable ? late_coll_occured   : 1'b0;
      assign tx_r_status[2]     = fifo_enable ? collision_occured   : 1'b0;
      assign tx_r_status[3]     = fifo_enable ? underflow_frame     : 1'b0;

    end else begin : gen_txif_basicfifo
      // For the 1st mode, drive the MAC signals straight from the GEM IO - there is no DMA here at all
      // connect MAC inputs to dma or ext_fifo interface
      assign tx_r_data_mac           = tx_r_data_pad;
      assign tx_r_data_par_mac       = tx_r_data_par_pad;
      assign tx_r_mod_mac            = tx_r_mod;
      assign tx_r_sop_mac            = tx_r_sop;
      assign tx_r_eop_mac            = tx_r_eop;
      assign tx_r_err_mac            = tx_r_err;
      assign tx_r_valid_mac          = tx_r_valid;
      assign tx_r_data_rdy_mac       = tx_r_data_rdy;
      assign dma_is_busy_mac         = 1'b0;
      assign tx_r_underflow_mac      = tx_r_underflow;
      assign tx_r_flushed_mac        = tx_r_flushed;
      assign tx_r_control_mac        = tx_r_control;
      assign tx_r_frame_size_mac     = tx_r_frame_size;
      assign tx_r_frame_size_vld_mac = tx_r_frame_size_vld;
      assign tx_r_launch_time_mac    = {p_edma_queues{32'd0}};
      assign tx_r_launch_time_vld_mac= {p_edma_queues{1'b0}};
      assign dma_tx_status_tog_mac   = dma_tx_status_tog;

      // connect MAC outputs to ext_fifo interface
      assign tx_r_rd               = tx_r_rd_int_mac;
      assign tx_r_queue            = tx_r_queue_mac;
      assign late_coll_occured     = late_coll_occured_mac;
      assign too_many_retries      = too_many_retries_mac;
      assign underflow_frame       = underflow_frame_mac;
      assign collision_occured     = collision_occured_mac;
      assign dma_tx_end_tog        = dma_tx_end_tog_mac;

      // tie off error reporting status outputs from DMA that doesnt exist ...
      assign tx_dma_buffers_ex    = 1'b0;
      assign tx_dma_buff_ex_mid   = 1'b0;
      assign tx_dma_hresp_notok   = 1'b0;
      assign tx_dma_descr_ptr     = 32'h00000000;
      assign tx_dma_descr_ptr_tog = 1'b0;
      assign tx_dma_underflow     = 1'b0;
      assign tx_dma_complete_ok   = 1'b0;
      assign tx_dma_late_col      = 1'b0;
      assign tx_dma_toomanyretry  = 1'b0;

      // tx_go is set whenever transmit is enabled. tx_dma_go not used for ext_fifo mode
      assign tx_dma_go            = enable_transmit;

      // DMA to registers handshaking driven by MAC to register handshaking
      // Note that dma_tx_status_tog is driven by external FIFO status logic
      assign tx_dma_stable_tog = 1'b0;

      assign enable_transmit_dma =  enable_transmit;

      assign tx_r_rd_int_dma    = {p_edma_queues{1'b0}};
      assign tx_r_queue_int_dma = 4'h0;

      assign tx_r_status[0]     = too_many_retries;
      assign tx_r_status[1]     = late_coll_occured;
      assign tx_r_status[2]     = collision_occured;
      assign tx_r_status[3]     = underflow_frame;
      assign fifo_enable        = 1'b0;
    end
  end else begin : gen_txif_dmanofifo
    // There is no external MAC interface, so there must be a DMA ...
    assign tx_r_data_mac            = tx_r_data_pad_dma;
    assign tx_r_data_par_mac        = tx_r_data_par_pad_dma;
    assign tx_r_mod_mac             = tx_r_mod_dma;
    assign tx_r_sop_mac             = tx_r_sop_dma;
    assign tx_r_eop_mac             = tx_r_eop_dma;
    assign tx_r_err_mac             = tx_r_err_dma;
    assign tx_r_valid_mac           = tx_r_valid_dma;
    assign tx_r_data_rdy_mac        = tx_r_data_rdy_dma;
    assign dma_is_busy_mac          = dma_is_busy;
    assign tx_r_underflow_mac       = tx_r_underflow_dma;
    assign tx_r_flushed_mac         = tx_r_flushed_dma;
    assign tx_r_control_mac         = tx_r_control_dma;
    assign tx_r_frame_size_mac      = tx_r_frame_size_dma;
    assign tx_r_frame_size_vld_mac  = tx_r_frame_size_vld_dma;
    assign tx_r_launch_time_mac     = tx_r_launch_time_dma;
    assign tx_r_launch_time_vld_mac = tx_r_launch_time_vld_dma;

    assign dma_tx_status_tog_mac    = dma_tx_status_tog_dma;

    // connect MAC outputs to dma interface
    assign tx_r_rd_dma            = tx_r_rd_mac;
    assign tx_r_queue_dma         = tx_r_queue_mac;
    assign late_coll_occured_dma  = late_coll_occured_mac;
    assign too_many_retries_dma   = too_many_retries_mac;
    assign underflow_frame_dma    = underflow_frame_mac;
    assign collision_occured_dma  = collision_occured_mac;

    assign dma_tx_end_tog_dma     = dma_tx_end_tog_mac;

    assign tx_dma_buffers_ex      = tx_dma_buffers_ex_dma;
    assign tx_dma_buff_ex_mid     = tx_dma_buff_ex_mid_dma;
    assign tx_dma_hresp_notok     = tx_dma_hresp_notok_dma;
    assign tx_dma_descr_ptr       = tx_dma_descr_ptr_dma;
    assign tx_dma_descr_ptr_tog   = tx_dma_descr_ptr_tog_dma;

    // tx_go is set whenever transmit is enabled
    assign tx_dma_go              = tx_dma_go_dma;

    assign tx_r_rd_int_dma        = tx_r_rd_int_mac;
    assign tx_r_queue_int_dma     = tx_r_queue_int_mac;
    assign tx_dma_late_col        = tx_dma_late_col_dma;
    assign tx_dma_toomanyretry    = tx_dma_toomanyretry_dma;
    assign tx_dma_underflow       = tx_dma_underflow_dma;

    // DMA to registers handshaking diven by MAC to register handshaking
    // Note that dma_tx_status_tog is driven by external FIFO status logic
    assign tx_dma_stable_tog      = tx_dma_stable_tog_dma;
    assign tx_dma_complete_ok     = tx_dma_complete_ok_dma;

    assign enable_transmit_dma    = enable_transmit;

    assign tx_r_rd                = {p_edma_queues{1'b0}};
    assign tx_r_queue             = 4'h0;
    assign tx_r_status[0]         = 1'b0;
    assign tx_r_status[1]         = 1'b0;
    assign tx_r_status[2]         = 1'b0;
    assign tx_r_status[3]         = 1'b0;
    assign dma_tx_end_tog         = 1'b0;
    assign fifo_enable            = 1'b0;
  end
  endgenerate


// ------------------------------------------------------------------------------------------
// RX Connections ...
// ------------------------------------------------------------------------------------------
  generate if (p_edma_add_rx_external_fifo_if == 1'b1) begin : gen_rxif
  // If we are adding a RX FIFO interface, then it can be done in one of 2 modes ...
  // 1. Without a DMA.  This is the simplest mode where the FIFO i/f is directly connected to the I/O of the GEM
  // 2. With a DMA with a static select - controlled via  gem_host_if_soft_select define, there is a static select between DMA and FIFO

  // First, for the 2nd mode, instantiate the arbitrating mux module ...
    if (p_edma_host_if_soft_select == 1) begin : gen_rxif_dma_staticfifo   // DMA and Ext FIFO RX Operate statically

      // connect MAC outputs to ext_fifo interface and disable when not selected
      // connect MAC outputs to dma interface and disable when not selected
      assign rx_w_wr                = fifo_enable ? rx_w_wr_mac : 1'b0;
      assign rx_w_wr_dma            = fifo_enable ? 1'b0        : rx_w_wr_mac ;
      assign rx_w_data              = rx_w_data_mac[p_emac_bus_width-1:0];
      assign rx_w_data_par          = rx_w_data_par_mac[p_emac_bus_pwid-1:0];
      assign rx_w_data_dma          = rx_w_data_mac[p_emac_bus_width-1:0];
      assign rx_w_data_par_dma      = rx_w_data_par_mac[p_emac_bus_pwid-1:0];
      assign rx_w_mod               = rx_w_mod_mac;
      assign rx_w_mod_dma           = rx_w_mod_mac;
      assign rx_w_sop               = rx_w_sop_mac;
      assign rx_w_sop_dma           = rx_w_sop_mac;
      assign rx_w_eop               = rx_w_eop_mac;
      assign rx_w_eop_dma           = rx_w_eop_mac;
      assign rx_w_err               = rx_w_err_mac;
      assign rx_w_err_dma           = rx_w_err_mac;
      assign rx_w_flush             = fifo_enable ? rx_w_flush_mac  : 1'b0;
      assign rx_w_flush_dma         = fifo_enable ? 1'b0            : rx_w_flush_mac;
      assign add_match_vec          = fifo_enable ? rx_w_add_match[p_num_spec_add_filters:0]  : {p_num_spec_add_filters+1{1'b0}};

      // connect MAC inputs from ext_fifo interface when fifo_enable = '1', otherwise connect to DMA
      assign rx_w_overflow_mac      = fifo_enable ? rx_w_overflow   : rx_w_overflow_dma;
      assign dma_rx_end_tog_dma     = fifo_enable ? 1'b0            : dma_rx_end_tog_mac;

      // connections to reg_top (when fifo and DMA connected)
      assign rx_end_tog_reg         = rx_end_tog_mac;
      assign rx_status_wr_tog_mac   = rx_status_wr_tog_reg;

      if(p_edma_rx_pkt_buffer == 1) begin: gen_rx_pkt_status_wr_tog_dma
        assign rx_pkt_status_wr_tog_dma = rx_pkt_end_tog_dma;
      end else begin: gen_no_rx_pkt_status_wr_tog_dma
        assign rx_pkt_status_wr_tog_dma = 1'b0;
      end

      // reg_top connections
      assign rx_dma_pkt_flushed_reg   = fifo_enable ? 1'b0 : rx_dma_pkt_flushed;

      assign rx_frame_rxed_ok_reg     = rx_frame_rxed_ok;
      assign rx_bytes_in_frame_reg    = rx_bytes_in_frame;
      assign rx_broadcast_frame_reg   = rx_broadcast_frame;
      assign rx_multicast_frame_reg   = rx_multicast_frame;
      assign rx_align_error_reg       = rx_align_error;
      assign rx_crc_error_reg         = rx_crc_error;
      assign rx_short_error_reg       = rx_short_error;
      assign rx_long_error_reg        = rx_long_error;
      assign rx_jabber_error_reg      = rx_jabber_error;
      assign rx_symbol_error_reg      = rx_symbol_error;
      assign rx_pause_frame_reg       = (rx_pause_frame|rx_pfc_pause_frame);
      assign rx_pause_nonzero_reg     = (rx_pause_nonzero|rx_pfc_pause_nonzero);
      assign rx_length_error_reg      = rx_length_error;
      assign rx_ip_ck_error_reg       = rx_ip_ck_error;
      assign rx_tcp_ck_error_reg      = rx_tcp_ck_error;
      assign rx_udp_ck_error_reg      = rx_udp_ck_error;
      assign rx_overflow_reg          = rx_overflow;

      // dma connections
      assign rx_w_frame_length_dma    = fifo_enable ? 14'h0000 : rx_w_frame_length;
      assign rx_w_bad_frame_dma       = fifo_enable ? 1'b0     : rx_w_bad_frame;
      assign rx_w_vlan_tagged_dma     = fifo_enable ? 1'b0     : rx_w_vlan_tagged;
      assign rx_w_tci_dma[3:0]        = fifo_enable ? 4'b0000  : rx_w_tci[3:0];
      assign rx_w_prty_tagged_dma     = fifo_enable ? 1'b0     : rx_w_prty_tagged;
      assign rx_w_broadcast_frame_dma = fifo_enable ? 1'b0     : rx_w_broadcast_frame;
      assign rx_w_mult_hash_match_dma = fifo_enable ? 1'b0     : rx_w_mult_hash_match;
      assign rx_w_uni_hash_match_dma  = fifo_enable ? 1'b0     : rx_w_uni_hash_match;
      assign rx_w_ext_match1_dma      = fifo_enable ? 1'b0     : rx_w_ext_match1;
      assign rx_w_ext_match2_dma      = fifo_enable ? 1'b0     : rx_w_ext_match2;
      assign rx_w_ext_match3_dma      = fifo_enable ? 1'b0     : rx_w_ext_match3;
      assign rx_w_ext_match4_dma      = fifo_enable ? 1'b0     : rx_w_ext_match4;
      assign rx_w_add_match_dma       = fifo_enable ? 8'h00    : rx_w_add_match_0to7;
      assign rx_w_type_match1_dma     = fifo_enable ? 1'b0     : rx_w_type_match1;
      assign rx_w_type_match2_dma     = fifo_enable ? 1'b0     : rx_w_type_match2;
      assign rx_w_type_match3_dma     = fifo_enable ? 1'b0     : rx_w_type_match3;
      assign rx_w_type_match4_dma     = fifo_enable ? 1'b0     : rx_w_type_match4;
      assign rx_w_checksumi_ok_dma    = fifo_enable ? 1'b0     : rx_w_checksumi_ok;
      assign rx_w_checksumt_ok_dma    = fifo_enable ? 1'b0     : rx_w_checksumt_ok;
      assign rx_w_checksumu_ok_dma    = fifo_enable ? 1'b0     : rx_w_checksumu_ok;
      assign rx_w_snap_frame_dma      = fifo_enable ? 1'b0     : rx_w_snap_frame;
      assign rx_w_crc_error_dma       = fifo_enable ? 1'b0     : rx_w_crc_error;
      assign rx_w_l4_offset_dma       = fifo_enable ? 12'h000  : rx_w_l4_offset;
      assign rx_w_pld_offset_dma      = fifo_enable ? 12'h000  : rx_w_pld_offset;

      // DMA to registers handshaking diven by MAC to register handshaking
      // Note that dma_tx_status_tog is driven by external FIFO status logic
      assign rx_dma_stable_tog = fifo_enable ?  rx_end_tog_mac:  rx_dma_stable_tog_dma;
      assign rx_dma_complete_ok = fifo_enable ? 1'b0: rx_dma_complete_ok_dma;

      // input to MAC
      assign dma_rx_status_tog_mac = fifo_enable ?  rx_status_wr_tog_reg:  dma_rx_status_tog_dma;

      assign rx_dma_buff_not_rdy  = fifo_enable ? 1'b0:  rx_dma_buff_not_rdy_dma;
      assign rx_dma_resource_err  = fifo_enable ? 1'b0:  rx_dma_resource_err_dma;
      assign rx_dma_hresp_notok   = fifo_enable ? 1'b0:  rx_dma_hresp_notok_dma;
      assign rx_dma_descr_ptr     = fifo_enable ? {(p_edma_queues*32){1'b0}} :  rx_dma_descr_ptr_dma;
      assign rx_dma_descr_ptr_tog = fifo_enable ? 1'b0:  rx_dma_descr_ptr_tog_dma;

      assign enable_receive_dma   = fifo_enable ? 1'b0 : enable_receive;

      assign rx_w_status[13:0]  = fifo_enable ? rx_w_frame_length      : 14'h0000;
      assign rx_w_status[14]    = fifo_enable ? rx_w_bad_frame         : 1'b0;
      assign rx_w_status[15]    = fifo_enable ? rx_w_vlan_tagged       : 1'b0;
      assign rx_w_status[19:16] = fifo_enable ? rx_w_tci[3:0]          : 4'b0000;
      assign rx_w_status[20]    = fifo_enable ? rx_w_prty_tagged       : 1'b0;
      assign rx_w_status[21]    = fifo_enable ? rx_w_broadcast_frame   : 1'b0;
      assign rx_w_status[22]    = fifo_enable ? rx_w_mult_hash_match   : 1'b0;
      assign rx_w_status[23]    = fifo_enable ? rx_w_uni_hash_match    : 1'b0;
      assign rx_w_status[24]    = fifo_enable ? rx_w_ext_match1        : 1'b0;
      assign rx_w_status[25]    = fifo_enable ? rx_w_ext_match2        : 1'b0;
      assign rx_w_status[26]    = fifo_enable ? rx_w_ext_match3        : 1'b0;
      assign rx_w_status[27]    = fifo_enable ? rx_w_ext_match4        : 1'b0;
      assign rx_w_status[28]    = fifo_enable ? rx_w_add_match_0to7[0] : 1'b0;
      assign rx_w_status[29]    = fifo_enable ? rx_w_add_match_0to7[1] : 1'b0;
      assign rx_w_status[30]    = fifo_enable ? rx_w_add_match_0to7[2] : 1'b0;
      assign rx_w_status[31]    = fifo_enable ? rx_w_add_match_0to7[3] : 1'b0;
      assign rx_w_status[32]    = fifo_enable ? rx_w_type_match1       : 1'b0;
      assign rx_w_status[33]    = fifo_enable ? rx_w_type_match2       : 1'b0;
      assign rx_w_status[34]    = fifo_enable ? rx_w_type_match3       : 1'b0;
      assign rx_w_status[35]    = fifo_enable ? rx_w_type_match4       : 1'b0;
      assign rx_w_status[36]    = fifo_enable ? rx_w_checksumi_ok      : 1'b0;
      assign rx_w_status[37]    = fifo_enable ? rx_w_checksumt_ok      : 1'b0;
      assign rx_w_status[38]    = fifo_enable ? rx_w_checksumu_ok      : 1'b0;
      assign rx_w_status[39]    = fifo_enable ? rx_w_snap_frame        : 1'b0;
      assign rx_w_status[40]    = fifo_enable ? rx_w_length_error      : 1'b0;
      assign rx_w_status[41]    = fifo_enable ? rx_w_crc_error         : 1'b0;
      assign rx_w_status[42]    = fifo_enable ? rx_w_too_short         : 1'b0;
      assign rx_w_status[43]    = fifo_enable ? rx_w_too_long          : 1'b0;
      assign rx_w_status[44]    = fifo_enable ? rx_w_code_error        : 1'b0;

    end else begin : gen_rxif_basicfifo

      // There is a FIFO interface, but no DMA, so connect MAC I/O to ext_fifo interface
      assign rx_w_wr                = rx_w_wr_mac;
      assign rx_w_data              = rx_w_data_mac[p_emac_bus_width-1:0];
      assign rx_w_data_par          = rx_w_data_par_mac[p_emac_bus_pwid-1:0];
      assign rx_w_mod               = rx_w_mod_mac;
      assign rx_w_sop               = rx_w_sop_mac;
      assign rx_w_eop               = rx_w_eop_mac;
      assign rx_w_err               = rx_w_err_mac;
      assign rx_w_flush             = rx_w_flush_mac;
      assign add_match_vec          = rx_w_add_match[p_num_spec_add_filters:0];
      assign rx_w_overflow_mac      = rx_w_overflow;

      // connections to reg_top (when only ext fifo connected)
      assign rx_end_tog_reg           = rx_end_tog_mac;
      assign rx_status_wr_tog_mac     = rx_status_wr_tog_reg;

      // reg_top connections
      assign rx_frame_rxed_ok_reg     = rx_frame_rxed_ok;
      assign rx_bytes_in_frame_reg    = rx_bytes_in_frame;
      assign rx_broadcast_frame_reg   = rx_broadcast_frame;
      assign rx_multicast_frame_reg   = rx_multicast_frame;
      assign rx_align_error_reg       = rx_align_error;
      assign rx_crc_error_reg         = rx_crc_error;
      assign rx_short_error_reg       = rx_short_error;
      assign rx_long_error_reg        = rx_long_error;
      assign rx_jabber_error_reg      = rx_jabber_error;
      assign rx_symbol_error_reg      = rx_symbol_error;
      assign rx_pause_frame_reg       = (rx_pause_frame|rx_pfc_pause_frame);
      assign rx_pause_nonzero_reg     = (rx_pause_nonzero|rx_pfc_pause_nonzero);
      assign rx_length_error_reg      = rx_length_error;
      assign rx_ip_ck_error_reg       = rx_ip_ck_error;
      assign rx_tcp_ck_error_reg      = rx_tcp_ck_error;
      assign rx_udp_ck_error_reg      = rx_udp_ck_error;
      assign rx_overflow_reg          = rx_overflow;

      // input to MAC
      assign dma_rx_status_tog_mac  = rx_status_wr_tog_reg;
      assign rx_dma_buff_not_rdy    = 1'b0;
      assign rx_dma_resource_err    = 1'b0;
      assign rx_dma_hresp_notok     = 1'b0;
      assign rx_dma_descr_ptr       = 32'h00000000;
      assign rx_dma_descr_ptr_tog   = 1'b0;
      assign rx_dma_complete_ok     = 1'b0;
      assign rx_dma_pkt_flushed_reg = 1'b0;

      // DMA to registers handshaking driven by MAC to register handshaking
      // Note that dma_tx_status_tog is driven by external FIFO status logic
      assign rx_dma_stable_tog  = 1'b0;
      assign rx_w_status[13:0]  = rx_w_frame_length;
      assign rx_w_status[14]    = rx_w_bad_frame;
      assign rx_w_status[15]    = rx_w_vlan_tagged;
      assign rx_w_status[19:16] = rx_w_tci[3:0];
      assign rx_w_status[20]    = rx_w_prty_tagged;
      assign rx_w_status[21]    = rx_w_broadcast_frame;
      assign rx_w_status[22]    = rx_w_mult_hash_match;
      assign rx_w_status[23]    = rx_w_uni_hash_match;
      assign rx_w_status[24]    = rx_w_ext_match1;
      assign rx_w_status[25]    = rx_w_ext_match2;
      assign rx_w_status[26]    = rx_w_ext_match3;
      assign rx_w_status[27]    = rx_w_ext_match4;
      assign rx_w_status[28]    = rx_w_add_match_0to7[0];
      assign rx_w_status[29]    = rx_w_add_match_0to7[1];
      assign rx_w_status[30]    = rx_w_add_match_0to7[2];
      assign rx_w_status[31]    = rx_w_add_match_0to7[3];
      assign rx_w_status[32]    = rx_w_type_match1;
      assign rx_w_status[33]    = rx_w_type_match2;
      assign rx_w_status[34]    = rx_w_type_match3;
      assign rx_w_status[35]    = rx_w_type_match4;
      assign rx_w_status[36]    = rx_w_checksumi_ok;
      assign rx_w_status[37]    = rx_w_checksumt_ok;
      assign rx_w_status[38]    = rx_w_checksumu_ok;
      assign rx_w_status[39]    = rx_w_snap_frame;
      assign rx_w_status[40]    = rx_w_length_error;
      assign rx_w_status[41]    = rx_w_crc_error;
      assign rx_w_status[42]    = rx_w_too_short;
      assign rx_w_status[43]    = rx_w_too_long;
      assign rx_w_status[44]    = rx_w_code_error;

    end
  end else begin : gen_rxif_dmaonly
    // ie no FIFO interface at top level connected, only DMA
    // Just connect directly to I/O
    assign rx_w_wr_dma            = rx_w_wr_mac;
    assign rx_w_data_dma          = rx_w_data_mac[p_emac_bus_width-1:0];
    assign rx_w_data_par_dma      = rx_w_data_par_mac[p_emac_bus_pwid-1:0];
    assign rx_w_mod_dma           = rx_w_mod_mac;
    assign rx_w_sop_dma           = rx_w_sop_mac ;
    assign rx_w_eop_dma           = rx_w_eop_mac ;
    assign rx_w_err_dma           = rx_w_err_mac ;
    assign rx_w_flush_dma         = rx_w_flush_mac ;
    assign rx_w_overflow_mac      = rx_w_overflow_dma;

    // connections to reg_top (when only DMA connected)

    assign rx_end_tog_reg           = rx_end_tog_mac;
    assign rx_status_wr_tog_mac     = rx_status_wr_tog_reg;

    if (p_edma_rx_pkt_buffer == 1) begin: gen_rx_pkt_status_wr_tog_dma
      assign rx_pkt_status_wr_tog_dma = rx_pkt_end_tog_dma;
    end else begin: no_gen_rx_pkt_status_wr_tog_dma
      assign rx_pkt_status_wr_tog_dma = 1'b0;
    end

    // reg_top connections
    assign rx_dma_pkt_flushed_reg   = rx_dma_pkt_flushed;
    assign rx_frame_rxed_ok_reg     = rx_frame_rxed_ok;
    assign rx_bytes_in_frame_reg    = rx_bytes_in_frame;
    assign rx_broadcast_frame_reg   = rx_broadcast_frame;
    assign rx_multicast_frame_reg   = rx_multicast_frame;
    assign rx_align_error_reg       = rx_align_error;
    assign rx_crc_error_reg         = rx_crc_error;
    assign rx_short_error_reg       = rx_short_error;
    assign rx_long_error_reg        = rx_long_error;
    assign rx_jabber_error_reg      = rx_jabber_error;
    assign rx_symbol_error_reg      = rx_symbol_error;
    assign rx_pause_frame_reg       = (rx_pause_frame|rx_pfc_pause_frame);
    assign rx_pause_nonzero_reg     = (rx_pause_nonzero|rx_pfc_pause_nonzero);  // DMA to registers handshaking diven by MAC to register handshaking
    assign rx_length_error_reg      = rx_length_error;
    assign rx_ip_ck_error_reg       = rx_ip_ck_error;
    assign rx_tcp_ck_error_reg      = rx_tcp_ck_error;
    assign rx_udp_ck_error_reg      = rx_udp_ck_error;
    assign rx_overflow_reg          = rx_overflow;

    // DMA connections
    assign rx_w_frame_length_dma    = rx_w_frame_length;
    assign rx_w_bad_frame_dma       = rx_w_bad_frame;
    assign rx_w_vlan_tagged_dma     = rx_w_vlan_tagged;
    assign rx_w_tci_dma[3:0]        = rx_w_tci[3:0];
    assign rx_w_prty_tagged_dma     = rx_w_prty_tagged;
    assign rx_w_broadcast_frame_dma = rx_w_broadcast_frame;
    assign rx_w_mult_hash_match_dma = rx_w_mult_hash_match;
    assign rx_w_uni_hash_match_dma  = rx_w_uni_hash_match;
    assign rx_w_ext_match1_dma      = rx_w_ext_match1;
    assign rx_w_ext_match2_dma      = rx_w_ext_match2;
    assign rx_w_ext_match3_dma      = rx_w_ext_match3;
    assign rx_w_ext_match4_dma      = rx_w_ext_match4;
    assign rx_w_add_match_dma       = rx_w_add_match_0to7;
    assign rx_w_type_match1_dma     = rx_w_type_match1;
    assign rx_w_type_match2_dma     = rx_w_type_match2;
    assign rx_w_type_match3_dma     = rx_w_type_match3;
    assign rx_w_type_match4_dma     = rx_w_type_match4;
    assign rx_w_checksumi_ok_dma    = rx_w_checksumi_ok;
    assign rx_w_checksumt_ok_dma    = rx_w_checksumt_ok;
    assign rx_w_checksumu_ok_dma    = rx_w_checksumu_ok;
    assign rx_w_snap_frame_dma      = rx_w_snap_frame;
    assign rx_w_crc_error_dma       = rx_w_crc_error;
    assign rx_w_l4_offset_dma       = rx_w_l4_offset;
    assign rx_w_pld_offset_dma      = rx_w_pld_offset;
    assign dma_rx_end_tog_dma       = dma_rx_end_tog_mac;
    assign enable_receive_dma       = enable_receive;

    // DMA to registers handshaking diven by MAC to register handshaking
    // Note that dma_tx_status_tog is driven by external FIFO status logic
    assign rx_dma_stable_tog   = rx_dma_stable_tog_dma;
    assign rx_dma_complete_ok  = rx_dma_complete_ok_dma;

    // Input to MAC
    assign dma_rx_status_tog_mac = dma_rx_status_tog_dma;
    assign rx_dma_buff_not_rdy  = rx_dma_buff_not_rdy_dma;
    assign rx_dma_resource_err  = rx_dma_resource_err_dma;
    assign rx_dma_hresp_notok   = rx_dma_hresp_notok_dma;
    assign rx_dma_descr_ptr     = rx_dma_descr_ptr_dma;
    assign rx_dma_descr_ptr_tog = rx_dma_descr_ptr_tog_dma;
    assign rx_w_status          = {45{1'b0}};
    assign rx_w_wr              = 1'b0;
    assign rx_w_data            = {p_emac_bus_width{1'b0}};
    assign rx_w_data_par        = {p_emac_bus_pwid{1'b0}};
    assign rx_w_mod             = 4'd0;
    assign rx_w_sop             = 1'b0;
    assign rx_w_eop             = 1'b0;
    assign rx_w_err             = 1'b0;
    assign rx_w_flush           = 1'b0;
    assign add_match_vec        = {p_num_spec_add_filters+1{1'b0}};

  end

  // Tie-off AXI/AHB signals if not used in this configuration
  if ((p_edma_ext_fifo_interface == 1) || (p_edma_axi == 0)) begin : gen_axi_tie_off
    assign awid                   = 4'h0;
    assign awaddr                 = {p_edma_addr_width{1'b0}};
    assign awaddr_par             = {p_edma_addr_pwid{1'b0}};
    assign awlen                  = 8'h00;
    assign awsize                 = 3'h0;
    assign awburst                = 2'h0;
    assign awlock                 = 2'h0;
    assign awcache                = 4'h0;
    assign awprot                 = 3'h0;
    assign awqos                  = 4'h0;
    assign awvalid                = 1'h0;
    assign wdata                  = {p_edma_bus_width{1'b0}};
    assign wdata_par              = {p_edma_bus_pwid{1'b0}};
    assign wstrb                  = {(p_edma_bus_width/8){1'b0}};
    assign wlast                  = 1'b0;
    assign wvalid                 = 1'b0;
    assign bready                 = 1'b0;
    assign arid                   = 4'h0;
    assign araddr                 = {p_edma_addr_width{1'b0}};
    assign araddr_par             = {p_edma_addr_pwid{1'b0}};
    assign arlen                  = 8'h00;
    assign arsize                 = 3'h0;
    assign arburst                = 2'h0;
    assign arlock                 = 2'h0;
    assign arcache                = 4'h0;
    assign arprot                 = 3'h0;
    assign arqos                  = 4'h0;
    assign arvalid                = 1'h0;
    assign rready                 = 1'h0;
  end
  if ((p_edma_ext_fifo_interface == 1) || (p_edma_axi == 1)) begin : gen_ahb_tie_off
    assign hbusreq                = 1'h0;
    assign hlock                  = 1'h0;
    assign haddr                  = {p_edma_addr_width{1'b0}};
    assign htrans                 = 2'h0;
    assign hwrite                 = 1'h0;
    assign hsize                  = 3'h0;
    assign hburst                 = 2'h0;
    assign hprot                  = 3'h0;
    assign hwdata                 = {p_edma_addr_width{1'b0}};
  end

  // Tie-off interfaces if no DMA or no packet buffer
  if ((p_edma_ext_fifo_interface == 1) || (p_edma_tx_pkt_buffer == 0)) begin : gen_pbuf_tie_off
    assign tx_sram_wea            = 1'b0;
    assign tx_sram_ena            = 1'b0;
    assign tx_sram_addra          = {p_edma_tx_pbuf_addr{1'b0}};
    assign tx_sram_dia            = {p_tx_sram_width{1'b0}};
    assign tx_sram_web            = 1'b0;
    assign tx_sram_enb            = 1'b0;
    assign tx_sram_addrb          = {p_edma_tx_pbuf_addr{1'b0}};
    assign rx_sram_wea            = 1'b0;
    assign rx_sram_ena            = 1'b0;
    assign rx_sram_addra          = {p_edma_rx_pbuf_addr{1'b0}};
    assign rx_sram_dia            = {p_rx_sram_width{1'b0}};
    assign rx_sram_web            = 1'b0;
    assign rx_sram_enb            = 1'b0;
    assign rx_sram_addrb          = {p_edma_rx_pbuf_addr{1'b0}};
    assign asf_dap_tx_rd_err      = 1'b0;
    assign asf_dap_tx_wr_err      = 1'b0;
    assign asf_dap_rx_wr_err      = 1'b0;
    assign asf_dap_rx_rd_err      = 1'b0;
    assign asf_integrity_dma_err  = 1'b0;
    assign dma_tx_lockup_detected = 1'b0;
    assign dma_rx_lockup_detected = 1'b0;
    assign axi_xaction_out        = 1'b0;
    assign tx_dma_int_queue       = 4'h0;
    assign rx_dma_int_queue       = 4'h0;
    assign rsc_clr_tog            = {p_edma_queues{1'b0}};
    assign tx_r_launch_time_dma     = {p_edma_queues{32'd0}};
    assign tx_r_launch_time_vld_dma = {p_edma_queues{1'd0}};
    assign tx_r_frame_size_dma     = {p_edma_queues{14'd0}};
    assign tx_r_frame_size_vld_dma = {p_edma_queues{1'd0}};

    assign tx_r_data_par_dma     = {p_emac_bus_pwid{1'b0}}; // Parity not supported for Legacy DMA TOIMPRV
    assign rx_databuf_wr_q       = {p_edma_queues{1'b0}};
    assign tx_dpram_fill_lvl_dbg = {(p_edma_tx_pbuf_addr*p_edma_queues){1'b0}};
    assign rx_dpram_fill_lvl_dbg = {p_edma_rx_pbuf_addr{1'b0}};
    assign rx_edma_overflow      = 1'b0;
    assign tx_edma_full_pkt_inc  = {p_edma_queues{1'b0}};
    assign tx_edma_used_bit_vec  = {p_edma_queues{1'b0}};
    assign tx_edma_lockup_flush  = 1'b0;
    assign rx_dma_pkt_flushed    = 1'b0;
    assign rx_pkt_dbuff_overflow = 1'b0;
  end

  endgenerate

//------------------------------------------------------------------------------
// instantiate edma_top if not using external FIFO interface
//------------------------------------------------------------------------------
  generate if (p_edma_ext_fifo_interface == 1'b1) begin  : gen_nodma
    assign tx_r_data_pad_dma        = {128{1'b0}};
    assign tx_r_data_par_pad_dma    = {16{1'b0}};
    assign tx_r_data_rdy_dma        = 1'b0;
    assign disable_rx               = 1'b0;
    assign disable_tx               = 1'b0;
    assign axi_tx_frame_too_large   = 1'b0;
    assign fill_lvl_breached        = {p_edma_queues{1'b0}};
    assign tx_corr_err              = 1'b0;
    assign tx_uncorr_err            = 1'b0;
    assign tx_err_addr              = {p_edma_tx_pbuf_addr{1'b0}};
    assign rx_corr_err              = 1'b0;
    assign rx_uncorr_err            = 1'b0;
    assign rx_err_addr              = {p_edma_rx_pbuf_addr{1'b0}};
  end else begin : gen_dma

    wire  tx_r_clk;   // TX FIFO i/f read clock.
    wire  tx_r_rst_n;
    wire  event_frame_rx;

    // Configure dma_top_q_id depending on whether AXI or AHB.
    // If we are using AXI, then the top Q ID going to the internal AHB DMA
    // is set to the top physical queue to avoid modifying the AXI block. This
    // results in slight inefficiencies as the AHB DMA will still consume cycles
    // fetching descriptor sweeps for all queues from the AXI block but this is
    // internal. Should be fixed at some point in the future.
    // Note this is only inefficient in the case of disabling TX queues.
    if (p_edma_axi == 1) begin : gen_axi_q_id
      assign dma_top_q_id = p_edma_queues -1;
    end else begin : gen_ahb_q_id
      assign dma_top_q_id = cbs_q_a_id;
    end

    // Set the transmit read side clock appropriately.
    // If we are in SPRAM mode, the transmit read side uses the DMA clock.
    if (p_edma_spram == 1) begin : gen_spram_clk
      assign tx_r_clk   = ambaclk;
      assign tx_r_rst_n = ambarst_n;
    end else begin : gen_dpram_clk
      assign tx_r_clk   = tx_clk;
      assign tx_r_rst_n = n_txreset;
    end

    // Pad the FIFO i/f DMA output to 128-bits to go into mux
    if (p_emac_bus_width < 32'd128) begin : gen_pad_tx_r_data_dma
      assign tx_r_data_pad_dma      = {{(128-p_emac_bus_width){1'b0}}, tx_r_data_dma};
      assign tx_r_data_par_pad_dma  = {{(16-p_emac_bus_pwid){1'b0}}, tx_r_data_par_dma};
    end else begin : gen_no_pad_tx_r_data_dma
      assign tx_r_data_pad_dma      = tx_r_data_dma;
      assign tx_r_data_par_pad_dma  = tx_r_data_par_dma;
    end

    // Instantiate legacy FIFO based DMA (no RAMs)
    if (p_edma_tx_pkt_buffer == 0) begin : gen_legacy_dma
    edma_fifo_ahb_top #(.grouped_params(grouped_params)) i_edma_fifo_ahb_top (

      // clock and reset.
      .tx_r_clk                (tx_r_clk),
      .tx_r_rst_n              (tx_r_rst_n),
      .rx_w_clk                (rx_clk),
      .rx_w_rst_n              (n_rxreset),
      .n_hreset                (ambarst_n),
      .hclk                    (ambaclk),

      // Amba AHB interface signals.
      .hgrant                  (hgrant),
      .hready                  (hready),
      .hresp                   (hresp),
      .hrdata                  (hrdata),
      .hbusreq                 (hbusreq),
      .hlock                   (hlock),
      .haddr                   (haddr),
      .htrans                  (htrans),
      .hwrite                  (hwrite),
      .hsize                   (hsize),
      .hburst                  (hburst),
      .hprot                   (hprot),
      .hwdata                  (hwdata),


      // signals coming from gem_mac (rx fifo interface).
      .rx_w_wr                 (rx_w_wr_dma),
      .rx_w_data               (rx_w_data_dma[p_emac_bus_width-1:0]),
      .rx_w_sop                (rx_w_sop_dma),
      .rx_w_eop                (rx_w_eop_dma),
      .rx_w_err                (rx_w_err_dma),
      .rx_w_flush              (rx_w_flush_dma),
      .rx_w_mod                (rx_w_mod_dma),

      // signals coming from gem_mac (gem_tx).
      .dma_tx_end_tog          (dma_tx_end_tog_dma),
      .collision_occured       (collision_occured_dma),
      .late_coll_occured       (late_coll_occured_dma),
      .too_many_retries        (too_many_retries_dma),
      .underflow_frame         (underflow_frame_dma),

      // signals coming from gem_mac (gem_rx).
      .dma_rx_end_tog          (dma_rx_end_tog_dma),
      .rx_w_bad_frame          (rx_w_bad_frame_dma),
      .rx_w_frame_length       (rx_w_frame_length_dma),
      .rx_w_vlan_tagged        (rx_w_vlan_tagged_dma),
      .rx_w_prty_tagged        (rx_w_prty_tagged_dma),
      .rx_w_tci                (rx_w_tci_dma),

      // signals coming from gem_mac (gem_filter).
      .rx_w_broadcast_frame    (rx_w_broadcast_frame_dma),
      .rx_w_mult_hash_match    (rx_w_mult_hash_match_dma),
      .rx_w_uni_hash_match     (rx_w_uni_hash_match_dma),
      .rx_w_ext_match1         (rx_w_ext_match1_dma),
      .rx_w_ext_match2         (rx_w_ext_match2_dma),
      .rx_w_ext_match3         (rx_w_ext_match3_dma),
      .rx_w_ext_match4         (rx_w_ext_match4_dma),
      .rx_w_add_match1         (rx_w_add_match_dma[0]),
      .rx_w_add_match2         (rx_w_add_match_dma[1]),
      .rx_w_add_match3         (rx_w_add_match_dma[2]),
      .rx_w_add_match4         (rx_w_add_match_dma[3]),
      .rx_w_type_match1        (rx_w_type_match1_dma),
      .rx_w_type_match2        (rx_w_type_match2_dma),
      .rx_w_type_match3        (rx_w_type_match3_dma),
      .rx_w_type_match4        (rx_w_type_match4_dma),
      .rx_w_checksumi_ok       (rx_w_checksumi_ok_dma),
      .rx_w_checksumt_ok       (rx_w_checksumt_ok_dma),
      .rx_w_checksumu_ok       (rx_w_checksumu_ok_dma),
      .rx_w_snap_frame         (rx_w_snap_frame_dma),
      .rx_w_crc_error          (rx_w_crc_error_dma),

      // signals coming from gem_reg_top (gem_registers).
      .rx_dma_stat_capt_tog    (rx_dma_stat_capt_tog),
      .tx_dma_stat_capt_tog    (tx_dma_stat_capt_tog),
      .rx_buff_not_rdy_pclk    (rx_buff_not_rdy_pclk),
      .dma_bus_width           (dma_bus_width),
      .rx_toe_enable           (rx_toe_enable),
      .tx_dma_descr_base_addr  (tx_dma_descr_base_addr),
      .enable_transmit         (enable_transmit_dma),
      .enable_receive          (enable_receive_dma),
      .new_receive_q_ptr       (new_receive_q_ptr),
      .new_transmit_q_ptr      (new_transmit_q_ptr),
      .tx_start_pclk           (tx_start_pclk),
      .tx_halt_pclk            (tx_halt_pclk),
      .rx_dma_descr_base_addr  (rx_dma_descr_base_addr),
      .rx_dma_buffer_size      (rx_dma_buffer_size),
      .rx_dma_buffer_offset    (rx_dma_buffer_offset),
      .ahb_burst_length        (ahb_burst_length),
      .rx_no_crc_check         (rx_no_crc_check),
      .jumbo_enable            (jumbo_enable),
      .endian_swap             (endian_swap),

      // signals going to gem_mac (tx fifo interface).
      .tx_r_data               (tx_r_data_dma),
      .tx_r_mod                (tx_r_mod_dma),
      .tx_r_sop                (tx_r_sop_dma),
      .tx_r_eop                (tx_r_eop_dma),
      .tx_r_err                (tx_r_err_dma),
      .tx_r_valid              (tx_r_valid_dma),
      .tx_r_data_rdy           (tx_r_data_rdy_dma),
      .dma_is_busy             (dma_is_busy),
      .tx_r_underflow          (tx_r_underflow_dma),
      .tx_r_flushed            (tx_r_flushed_dma),
      .tx_r_control            (tx_r_control_dma),

      // signals coming from gem_mac (tx fifo interface).
      .tx_r_rd                 (tx_r_rd_dma),

      // signals going to gem_mac.
      .dma_tx_status_tog       (dma_tx_status_tog_dma),
      .dma_rx_status_tog       (dma_rx_status_tog_dma),
      .rx_w_overflow           (rx_w_overflow_dma),

      // signals going to gem_reg_top.
      .tx_dma_stable_tog       (tx_dma_stable_tog_dma),
      .tx_dma_complete_ok      (tx_dma_complete_ok_dma),
      .tx_dma_buffers_ex       (tx_dma_buffers_ex_dma),
      .tx_dma_buff_ex_mid      (tx_dma_buff_ex_mid_dma),
      .tx_dma_hresp_notok      (tx_dma_hresp_notok_dma),
      .tx_dma_descr_ptr        (tx_dma_descr_ptr_dma),
      .tx_dma_descr_ptr_tog    (tx_dma_descr_ptr_tog_dma),
      .tx_dma_go               (tx_dma_go_dma),
      .tx_dma_late_col         (tx_dma_late_col_dma),
      .tx_dma_toomanyretry     (tx_dma_toomanyretry_dma),
      .tx_dma_underflow        (tx_dma_underflow_dma),
      .rx_dma_stable_tog       (rx_dma_stable_tog_dma),
      .rx_dma_complete_ok      (rx_dma_complete_ok_dma),
      .rx_dma_resource_err     (rx_dma_resource_err_dma),
      .rx_dma_buff_not_rdy     (rx_dma_buff_not_rdy_dma),
      .rx_dma_hresp_notok      (rx_dma_hresp_notok_dma),
      .rx_dma_descr_ptr        (rx_dma_descr_ptr_dma),
      .rx_dma_descr_ptr_tog    (rx_dma_descr_ptr_tog_dma)
    );

    assign fill_lvl_breached = {p_edma_queues{1'b0}};
    assign disable_rx               = 1'b0;
    assign disable_tx               = 1'b0;
    assign axi_tx_frame_too_large   = 1'b0;
  end

  // Create wires for connecting to the packet buffer DMA SRAM interfaces
  wire          tx_sram_wea_int;    // Port A is always used for write
  wire          tx_sram_ena_int;
  wire  [p_edma_tx_pbuf_addr-1:0]
                tx_sram_addra_int;
  wire  [p_edma_tx_pbuf_data-1:0]
                tx_sram_dia_int;
  wire  [p_edma_tx_pbuf_pwid-1:0]
                tx_sram_dia_par_int;
  wire  [p_edma_tx_pbuf_data-1:0]   // With optional read when SPRAM
                tx_sram_doa_int;
  wire  [p_edma_tx_pbuf_pwid-1:0]   // With optional read when SPRAM
                tx_sram_doa_par_int;
  wire          tx_sram_web_int;    // Port B is always read only
  wire          tx_sram_enb_int;
  wire  [p_edma_tx_pbuf_addr-1:0]
                tx_sram_addrb_int;
  wire  [p_edma_tx_pbuf_data-1:0]
                tx_sram_dob_int;
  wire  [p_edma_tx_pbuf_pwid-1:0]
                tx_sram_dob_par_int;

  wire          rx_sram_wea_int;    // Port A is always used for write
  wire          rx_sram_ena_int;
  wire  [p_edma_rx_pbuf_addr-1:0]
                rx_sram_addra_int;
  wire  [p_edma_rx_pbuf_data-1:0]
                rx_sram_dia_int;
  wire  [p_edma_rx_pbuf_pwid-1:0]
                rx_sram_dia_par_int;
  wire  [p_edma_rx_pbuf_data-1:0]   // With optional read when SPRAM
                rx_sram_doa_int;
  wire  [p_edma_rx_pbuf_pwid-1:0]   // With optional read when SPRAM
                rx_sram_doa_par_int;
  wire          rx_sram_web_int;    // Port B is always read only
  wire          rx_sram_enb_int;
  wire  [p_edma_rx_pbuf_addr-1:0]
                rx_sram_addrb_int;
  wire  [p_edma_rx_pbuf_data-1:0]
                rx_sram_dob_int;
  wire  [p_edma_rx_pbuf_pwid-1:0]
                rx_sram_dob_par_int;

  if ((p_edma_axi == 1) && (p_edma_tx_pkt_buffer == 1)) begin : gen_pbuf_axi_dma
    edma_pbuf_axi_top #(.grouped_params(grouped_params)) i_edma_pbuf_axi_top (

      // clock and reset.
      .tx_r_clk                (tx_r_clk),
      .tx_r_rst_n              (tx_r_rst_n),
      .rx_w_clk                (rx_clk),
      .rx_w_rst_n              (n_rxreset),
      .n_hreset                (ambarst_n),
      .hclk                    (ambaclk),

      .awid                    (awid),
      .awaddr                  (awaddr),
      .awaddr_par              (awaddr_par),
      .awlen                   (awlen),
      .awsize                  (awsize),
      .awburst                 (awburst),
      .awlock                  (awlock),
      .awcache                 (awcache),
      .awprot                  (awprot),
      .awqos                   (awqos),
      .awvalid                 (awvalid),
      .awready                 (awready),
      .wdata                   (wdata),
      .wdata_par               (wdata_par),
      .wstrb                   (wstrb),
      .wlast                   (wlast),
      .wready                  (wready),
      .wvalid                  (wvalid),
      .bresp                   (bresp),
      .bvalid                  (bvalid),
      .bready                  (bready),
      .arid                    (arid),
      .araddr                  (araddr),
      .araddr_par              (araddr_par),
      .arlen                   (arlen),
      .arsize                  (arsize),
      .arburst                 (arburst),
      .arlock                  (arlock),
      .arcache                 (arcache),
      .arprot                  (arprot),
      .arqos                   (arqos),
      .arvalid                 (arvalid),
      .arready                 (arready),
      .rdata                   (rdata),
      .rdata_par               (rdata_par),
      .rresp                   (rresp),
      .rlast                   (rlast),
      .rvalid                  (rvalid),
      .rready                  (rready),

      // signals coming from gem_mac (rx fifo interface).
      .rx_w_wr                 (rx_w_wr_dma),
      .rx_w_data               (rx_w_data_dma),
      .rx_w_data_par           (rx_w_data_par_dma),
      .rx_w_sop                (rx_w_sop_dma),
      .rx_w_eop                (rx_w_eop_dma),
      .rx_w_err                (rx_w_err_dma),

      // When using the packet buffer, we need to delay the
      // handshake between the MAC and the REG block, so
      // that stats are updated at the correct time
      // 'rx_end_tog' comes from the mac to indicate
      // the stats are valid
      // 'rx_status_wr_tog' is sent back to the MAC to indicate
      // the pkt buffer has captured the stats from the MAC
      // 'rx_pkt_end_tog' indicates to the reg block
      // that stats are ready
      // 'rx_pkt_status_wr_tog' indicates from the reg block
      // that stats have been captured
      .rx_end_tog              (1'b0),
      .rx_status_wr_tog        (),
      .rx_pkt_end_tog          (rx_pkt_end_tog_dma),
      .rx_pkt_status_wr_tog    (rx_pkt_status_wr_tog_dma),

       // optionally, the TX DMA can be triggered by toggling
       // the trigger_dma_tx_start input.  Note this does
       // not affect the software mechanism for triggering
       // tx_start
      .trigger_dma_tx_start    (trigger_dma_tx_start),

      // the OR mask is used at the head of the DMA to force the
      // address of data buffer accesses only to that of the mask
      // value. The value in the mask register should only be used
      // by the DMA at the start of any packet transfer, so that
      // dynamic changes in the register value only affect full packets
      // (buffers do not end up being split in 2 different areas of memory).
      .dma_addr_or_mask        (dma_addr_or_mask),

      // signals coming from gem_mac (gem_tx).
      .dma_tx_end_tog          (dma_tx_end_tog_dma),
      .dma_tx_small_end_tog    (1'b0),
      .collision_occured       (collision_occured_dma),
      .late_coll_occured       (late_coll_occured_dma),
      .too_many_retries        (too_many_retries_dma),
      .underflow_frame         (underflow_frame_dma),

      // signals coming from gem_mac (gem_rx).
      .dma_rx_end_tog          (dma_rx_end_tog_dma),
      .rx_w_bad_frame          (rx_w_bad_frame_dma),
      .rx_w_frame_length       (rx_w_frame_length_dma),
      .rx_w_vlan_tagged        (rx_w_vlan_tagged_dma),
      .rx_w_prty_tagged        (rx_w_prty_tagged_dma),
      .rx_w_tci                (rx_w_tci_dma),
      .queue_ptr_rx            (rx_w_queue),

      // signals coming from gem_mac (gem_filter).
      .rx_w_broadcast_frame    (rx_w_broadcast_frame_dma),
      .rx_w_mult_hash_match    (rx_w_mult_hash_match_dma),
      .rx_w_uni_hash_match     (rx_w_uni_hash_match_dma),
      .rx_w_ext_match1         (rx_w_ext_match1_dma),
      .rx_w_ext_match2         (rx_w_ext_match2_dma),
      .rx_w_ext_match3         (rx_w_ext_match3_dma),
      .rx_w_ext_match4         (rx_w_ext_match4_dma),
      .rx_w_add_match1         (rx_w_add_match_dma[0]),
      .rx_w_add_match2         (rx_w_add_match_dma[1]),
      .rx_w_add_match3         (rx_w_add_match_dma[2]),
      .rx_w_add_match4         (rx_w_add_match_dma[3]),
      .rx_w_add_match5         (rx_w_add_match_dma[4]),
      .rx_w_add_match6         (rx_w_add_match_dma[5]),
      .rx_w_add_match7         (rx_w_add_match_dma[6]),
      .rx_w_add_match8         (rx_w_add_match_dma[7]),
      .rx_w_type_match1        (rx_w_type_match1_dma),
      .rx_w_type_match2        (rx_w_type_match2_dma),
      .rx_w_type_match3        (rx_w_type_match3_dma),
      .rx_w_type_match4        (rx_w_type_match4_dma),
      .rx_w_checksumi_ok       (rx_w_checksumi_ok_dma),
      .rx_w_checksumt_ok       (rx_w_checksumt_ok_dma),
      .rx_w_checksumu_ok       (rx_w_checksumu_ok_dma),
      .rx_w_snap_frame         (rx_w_snap_frame_dma),
      .rx_w_crc_error          (rx_w_crc_error_dma),
      .rx_w_l4_offset          (rx_w_l4_offset_dma),
      .rx_w_pld_offset         (rx_w_pld_offset_dma),

      // Stats going to the register block ...
      .rx_dma_pkt_flushed      (rx_dma_pkt_flushed),
      .rx_pkt_dbuff_overflow   (rx_pkt_dbuff_overflow),

      // signals coming from gem_reg_top (gem_registers).
      .full_duplex             (full_duplex),
      .force_discard_on_err    (force_discard_on_err),
      .force_discard_on_err_q  (force_discard_on_err_q),
      .force_max_ahb_burst_tx  (force_max_ahb_burst_tx),
      .force_max_ahb_burst_rx  (force_max_ahb_burst_rx),
      .rx_dma_stat_capt_tog    (rx_dma_stat_capt_tog),
      .tx_dma_stat_capt_tog    (tx_dma_stat_capt_tog),
      .rx_buff_not_rdy_pclk    (rx_buff_not_rdy_pclk),
      .dma_bus_width           (dma_bus_width),
      .rx_toe_enable           (rx_toe_enable),
      .tx_dma_descr_base_addr  (tx_dma_descr_base_addr),
      .tx_dma_descr_base_par   (tx_dma_descr_base_par),
      .enable_transmit         (enable_transmit_dma),
      .enable_receive          (enable_receive_dma),
      .new_receive_q_ptr       (new_receive_q_ptr),
      .new_transmit_q_ptr      (new_transmit_q_ptr),
      .tx_start_pclk           (tx_start_pclk),
      .tx_halt_pclk            (tx_halt_pclk),
      .flush_rx_pkt_pclk       (flush_rx_pkt_pclk),
      .hdr_data_splitting_en   (hdr_data_splitting_en),
      .infinite_last_dbuf_size_en(infinite_last_dbuf_size_en),
      .crc_error_report        (crc_error_report),
      .rx_dma_descr_base_addr  (rx_dma_descr_base_addr),
      .rx_dma_descr_base_par   (rx_dma_descr_base_par),
      .rx_dma_buffer_size      (rx_dma_buffer_size),
      .rx_dma_buffer_offset    (rx_dma_buffer_offset),
      .ahb_burst_length        (ahb_burst_length),
      .rx_no_crc_check         (rx_no_crc_check),
      .jumbo_enable            (jumbo_enable),
      .jumbo_max_length        (jumbo_max_length),
      .endian_swap             (endian_swap),

      .axi_tx_frame_too_large  (axi_tx_frame_too_large),
      .axi_xaction_out         (axi_xaction_out),
      .disable_tx              (disable_tx),
      .disable_rx              (disable_rx),

      // signals going to gem_mac (tx fifo interface).
      .tx_r_data               (tx_r_data_dma),
      .tx_r_data_par           (tx_r_data_par_dma),
      .tx_r_mod                (tx_r_mod_dma),
      .tx_r_sop                (tx_r_sop_dma),
      .tx_r_eop                (tx_r_eop_dma),
      .tx_r_err                (tx_r_err_dma),
      .tx_r_valid              (tx_r_valid_dma),
      .tx_r_data_rdy           (tx_r_data_rdy_dma),
      .dma_is_busy             (dma_is_busy),
      .tx_r_underflow          (tx_r_underflow_dma),
      .tx_r_flushed            (tx_r_flushed_dma),
      .tx_r_control            (tx_r_control_dma),
      .tx_r_frame_size         (tx_r_frame_size_dma),
      .tx_r_frame_size_vld     (tx_r_frame_size_vld_dma),
      .tx_r_launch_time        (tx_r_launch_time_dma),
      .tx_r_launch_time_vld    (tx_r_launch_time_vld_dma),

      // signals coming from gem_mac (tx fifo interface).
      .tx_r_rd                 (tx_r_rd_dma),
      .tx_r_rd_int             (tx_r_rd_int_dma),
      .tx_r_queue_int          (tx_r_queue_int_dma),

      // signals going to gem_mac.
      .dma_tx_status_tog       (dma_tx_status_tog_dma),
      .dma_rx_status_tog       (dma_rx_status_tog_dma),
      .rx_w_overflow           (rx_w_overflow_dma),

      // signals for TX packet buffer if included
      .tx_pbuf_size            (tx_pbuf_size),
      .tx_pbuf_tcp_en          (tx_pbuf_tcp_en),
      .tx_cutthru_threshold    (tx_cutthru_threshold),
      .tx_cutthru              (tx_cutthru),

      // SRAM interface
      .tx_sram_wea             (tx_sram_wea_int),
      .tx_sram_ena             (tx_sram_ena_int),
      .tx_sram_addra           (tx_sram_addra_int),
      .tx_sram_dia             (tx_sram_dia_int),
      .tx_sram_dia_par         (tx_sram_dia_par_int),
      .tx_sram_doa             (tx_sram_doa_int),
      .tx_sram_doa_par         (tx_sram_doa_par_int),
      .tx_sram_web             (tx_sram_web_int),
      .tx_sram_enb             (tx_sram_enb_int),
      .tx_sram_addrb           (tx_sram_addrb_int),
      .tx_sram_dob             (tx_sram_dob_int),
      .tx_sram_dob_par         (tx_sram_dob_par_int),

      .rx_sram_wea             (rx_sram_wea_int),
      .rx_sram_ena             (rx_sram_ena_int),
      .rx_sram_addra           (rx_sram_addra_int),
      .rx_sram_dia             (rx_sram_dia_int),
      .rx_sram_dia_par         (rx_sram_dia_par_int),
      .rx_sram_doa             (rx_sram_doa_int),
      .rx_sram_doa_par         (rx_sram_doa_par_int),
      .rx_sram_web             (rx_sram_web_int),
      .rx_sram_enb             (rx_sram_enb_int),
      .rx_sram_addrb           (rx_sram_addrb_int),
      .rx_sram_dob             (rx_sram_dob_int),
      .rx_sram_dob_par         (rx_sram_dob_par_int),

      // signals going to RX packet buffer if included
      .rx_pbuf_size            (rx_pbuf_size),
      .rx_cutthru_threshold    (rx_cutthru_threshold),
      .rx_cutthru              (rx_cutthru),


      // signals going to gem_reg_top.
      .tx_dma_stable_tog       (tx_dma_stable_tog_dma),
      .tx_dma_complete_ok      (tx_dma_complete_ok_dma),
      .tx_dma_buffers_ex       (tx_dma_buffers_ex_dma),
      .tx_dma_buff_ex_mid      (tx_dma_buff_ex_mid_dma),
      .tx_dma_hresp_notok      (tx_dma_hresp_notok_dma),
      .tx_dma_descr_ptr        (tx_dma_descr_ptr_dma),
      .tx_dma_descr_ptr_tog    (tx_dma_descr_ptr_tog_dma),
      .tx_dma_go               (tx_dma_go_dma),
      .tx_dma_late_col         (tx_dma_late_col_dma),
      .tx_dma_toomanyretry     (tx_dma_toomanyretry_dma),
      .tx_dma_underflow        (tx_dma_underflow_dma),
      .tx_dma_int_queue        (tx_dma_int_queue),
      .rx_dma_stable_tog       (rx_dma_stable_tog_dma),
      .rx_dma_complete_ok      (rx_dma_complete_ok_dma),
      .rx_dma_resource_err     (rx_dma_resource_err_dma),
      .rx_dma_buff_not_rdy     (rx_dma_buff_not_rdy_dma),
      .rx_dma_hresp_notok      (rx_dma_hresp_notok_dma),
      .rx_dma_int_queue        (rx_dma_int_queue),

      .rx_databuf_wr_q         (rx_databuf_wr_q),

      .rx_dma_descr_ptr        (rx_dma_descr_ptr_dma),
      .rx_dma_descr_ptr_tog    (rx_dma_descr_ptr_tog_dma),

      .tx_pbuf_segments        (tx_pbuf_segments),
      .tx_disable_queue        (tx_disable_queue),
      .rx_disable_queue        (rx_disable_queue),
      .axi_qos_q_mapping       (axi_qos_q_mapping),

      // AXI specific
      .use_aw2b_fill           (use_aw2b_fill),
      .max_num_axi_ar2r        (max_num_axi_ar2r),
      .max_num_axi_aw2w        (max_num_axi_aw2w),

      .rsc_en                  (rsc_en),
      .rsc_stop                (rsc_stop),
      .rsc_push                (rsc_push),
      .tcp_seqnum              (tcp_seqnum),
      .tcp_syn                 (tcp_syn),
      .tcp_payload_len         (tcp_payload_len),
      .rsc_clr_tog             (rsc_clr_tog),

      // 64b addressing and extended BD from reg_top
      .upper_tx_q_base_addr        (upper_tx_q_base_addr),
      .upper_tx_q_base_par         (upper_tx_q_base_par),
      .upper_rx_q_base_addr        (upper_rx_q_base_addr),
      .upper_rx_q_base_par         (upper_rx_q_base_par),
      .dma_addr_bus_width          (dma_addr_bus_width),

      .tx_bd_extended_mode_en      (tx_bd_extended_mode_en),
      .tx_bd_ts_mode               (tx_bd_ts_mode),

      .rx_bd_extended_mode_en      (rx_bd_extended_mode_en),
      .rx_bd_ts_mode               (rx_bd_ts_mode),

      // Timestamp for current tx packet
      .tx_timestamp                (tx_timestamp_edma),

      // Timestamp for current rx packet
      .rx_timestamp                (rx_timestamp_edma),

      // RAS - Timestamp parity protection
      .tx_timestamp_prty           (tx_timestamp_prty_edma),
      .rx_timestamp_prty           (rx_timestamp_prty_edma),

      // debug port
      .tx_dpram_fill_lvl           (tx_dpram_fill_lvl_dbg),
      .rx_dpram_fill_lvl           (rx_dpram_fill_lvl_dbg),

      // ASF - signals going to gem_reg_top
      .asf_dap_tx_rd_err           (asf_dap_tx_rd_err),
      .asf_dap_tx_wr_err           (asf_dap_tx_wr_err),
      .asf_dap_rx_wr_err           (asf_dap_rx_wr_err),
      .asf_dap_rx_rd_err           (asf_dap_rx_rd_err),
      .asf_integrity_dma_err       (asf_integrity_dma_err),

       // lockup detection
      .tx_edma_full_pkt_inc        (tx_edma_full_pkt_inc),
      .tx_edma_used_bit_vec        (tx_edma_used_bit_vec),
      .tx_edma_lockup_flush        (tx_edma_lockup_flush),
      .rx_edma_overflow            (rx_edma_overflow),

      .axi_tx_full_adj_0           (axi_tx_full_adj_0),
      .axi_tx_full_adj_1           (axi_tx_full_adj_1),
      .restart_counter_top         (restart_counter_top),

      // PTP frame decoded signals
      .event_frame_tx              (event_frame_tx),
      .general_frame_tx            (general_frame_tx ),
      .sof_rx                      (sof_rx),
      .event_frame_rx              (event_frame_rx),
      .general_frame_rx            (general_frame_rx),

      // Signals to/from gem_rx for per queue rx flushing
      .max_val_pclk                   (max_val_pclk),
      .limit_num_bytes_allowed_ambaclk(limit_num_bytes_allowed_ambaclk),
      .fill_lvl_breached              (fill_lvl_breached)

    );
  end

  if ((p_edma_axi == 0) && (p_edma_tx_pkt_buffer == 1)) begin : gen_pbuf_ahb_dma
    edma_pbuf_ahb_top #(.grouped_params(grouped_params)) i_edma_pbuf_ahb_top (

      // clock and reset.
      .tx_r_clk                (tx_r_clk),
      .tx_r_rst_n              (tx_r_rst_n),
      .rx_w_clk                (rx_clk),
      .rx_w_rst_n              (n_rxreset),
      .n_hreset                (ambarst_n),
      .hclk                    (ambaclk),

      // Amba AHB interface signals.
      .hgrant                  (hgrant),
      .hready                  (hready),
      .hresp                   (hresp),
      .hrdata                  (hrdata),
      .hbusreq                 (hbusreq),
      .hlock                   (hlock),
      .haddr                   (haddr),
      .htrans                  (htrans),
      .hwrite                  (hwrite),
      .hsize                   (hsize),
      .hburst                  (hburst),
      .hprot                   (hprot),
      .hwdata                  (hwdata),

      // signals coming from gem_mac (rx fifo interface).
      .rx_w_wr                 (rx_w_wr_dma),
      .rx_w_data               (rx_w_data_dma),
      .rx_w_data_par           (rx_w_data_par_dma),
      .rx_w_sop                (rx_w_sop_dma),
      .rx_w_eop                (rx_w_eop_dma),
      .rx_w_err                (rx_w_err_dma),

      // When using the packet buffer, we need to delay the
      // handshake between the MAC and the REG block, so
      // that stats are updated at the correct time
      // 'rx_end_tog' comes from the mac to indicate
      // the stats are valid
      // 'rx_status_wr_tog' is sent back to the MAC to indicate
      // the pkt buffer has captured the stats from the MAC
      // 'rx_pkt_end_tog' indicates to the reg block
      // that stats are ready
      // 'rx_pkt_status_wr_tog' indicates from the reg block
      // that stats have been captured
      .rx_end_tog              (1'b0),
      .rx_status_wr_tog        (),
      .rx_pkt_end_tog          (rx_pkt_end_tog_dma),
      .rx_pkt_status_wr_tog    (rx_pkt_status_wr_tog_dma),

       // optionally, the TX DMA can be triggered by toggling
       // the trigger_dma_tx_start input.  Note this does
       // not affect the software mechanism for triggering
       // tx_start
      .trigger_dma_tx_start    (trigger_dma_tx_start),

      // the OR mask is used at the head of the DMA to force the
      // address of data buffer accesses only to that of the mask
      // value. The value in the mask register should only be used
      // by the DMA at the start of any packet transfer, so that
      // dynamic changes in the register value only affect full packets
      // (buffers do not end up being split in 2 different areas of memory).
      .dma_addr_or_mask        (dma_addr_or_mask),

      // signals coming from gem_mac (gem_tx).
      .dma_tx_end_tog          (dma_tx_end_tog_dma),
      .dma_tx_small_end_tog    (1'b0),
      .collision_occured       (collision_occured_dma),
      .late_coll_occured       (late_coll_occured_dma),
      .too_many_retries        (too_many_retries_dma),
      .underflow_frame         (underflow_frame_dma),

      // signals coming from gem_mac (gem_rx).
      .dma_rx_end_tog          (dma_rx_end_tog_dma),
      .rx_w_bad_frame          (rx_w_bad_frame_dma),
      .rx_w_frame_length       (rx_w_frame_length_dma),
      .rx_w_vlan_tagged        (rx_w_vlan_tagged_dma),
      .rx_w_prty_tagged        (rx_w_prty_tagged_dma),
      .rx_w_tci                (rx_w_tci_dma),
      .queue_ptr_rx            (rx_w_queue),

      // signals coming from gem_mac (gem_filter).
      .rx_w_broadcast_frame    (rx_w_broadcast_frame_dma),
      .rx_w_mult_hash_match    (rx_w_mult_hash_match_dma),
      .rx_w_uni_hash_match     (rx_w_uni_hash_match_dma),
      .rx_w_ext_match1         (rx_w_ext_match1_dma),
      .rx_w_ext_match2         (rx_w_ext_match2_dma),
      .rx_w_ext_match3         (rx_w_ext_match3_dma),
      .rx_w_ext_match4         (rx_w_ext_match4_dma),
      .rx_w_add_match1         (rx_w_add_match_dma[0]),
      .rx_w_add_match2         (rx_w_add_match_dma[1]),
      .rx_w_add_match3         (rx_w_add_match_dma[2]),
      .rx_w_add_match4         (rx_w_add_match_dma[3]),
      .rx_w_add_match5         (rx_w_add_match_dma[4]),
      .rx_w_add_match6         (rx_w_add_match_dma[5]),
      .rx_w_add_match7         (rx_w_add_match_dma[6]),
      .rx_w_add_match8         (rx_w_add_match_dma[7]),
      .rx_w_type_match1        (rx_w_type_match1_dma),
      .rx_w_type_match2        (rx_w_type_match2_dma),
      .rx_w_type_match3        (rx_w_type_match3_dma),
      .rx_w_type_match4        (rx_w_type_match4_dma),
      .rx_w_checksumi_ok       (rx_w_checksumi_ok_dma),
      .rx_w_checksumt_ok       (rx_w_checksumt_ok_dma),
      .rx_w_checksumu_ok       (rx_w_checksumu_ok_dma),
      .rx_w_snap_frame         (rx_w_snap_frame_dma),
      .rx_w_crc_error          (rx_w_crc_error_dma),
      .rx_w_l4_offset          (rx_w_l4_offset_dma),
      .rx_w_pld_offset         (rx_w_pld_offset_dma),

      // Stats going to the register block ...
      .rx_dma_pkt_flushed      (rx_dma_pkt_flushed),
      .rx_pkt_dbuff_overflow   (rx_pkt_dbuff_overflow),

      // signals coming from gem_reg_top (gem_registers).
      .full_duplex             (full_duplex),
      .force_discard_on_err    (force_discard_on_err),
      .force_discard_on_err_q  (force_discard_on_err_q),
      .force_max_ahb_burst_tx  (force_max_ahb_burst_tx),
      .force_max_ahb_burst_rx  (force_max_ahb_burst_rx),
      .rx_dma_stat_capt_tog    (rx_dma_stat_capt_tog),
      .tx_dma_stat_capt_tog    (tx_dma_stat_capt_tog),
      .rx_buff_not_rdy_pclk    (rx_buff_not_rdy_pclk),
      .dma_bus_width           (dma_bus_width),
      .rx_toe_enable           (rx_toe_enable),
      .tx_dma_descr_base_addr  (tx_dma_descr_base_addr),
      .enable_transmit         (enable_transmit_dma),
      .enable_receive          (enable_receive_dma),
      .new_receive_q_ptr       (new_receive_q_ptr),
      .new_transmit_q_ptr      (new_transmit_q_ptr),
      .tx_start_pclk           (tx_start_pclk),
      .tx_halt_pclk            (tx_halt_pclk),
      .flush_rx_pkt_pclk       (flush_rx_pkt_pclk),
      .hdr_data_splitting_en   (hdr_data_splitting_en),
      .infinite_last_dbuf_size_en(infinite_last_dbuf_size_en),
      .crc_error_report        (crc_error_report),
      .rx_dma_descr_base_addr  (rx_dma_descr_base_addr),
      .rx_dma_descr_base_par   (rx_dma_descr_base_par),
      .rx_dma_buffer_size      (rx_dma_buffer_size),
      .rx_dma_buffer_offset    (rx_dma_buffer_offset),
      .ahb_burst_length        (ahb_burst_length),
      .rx_no_crc_check         (rx_no_crc_check),
      .jumbo_enable            (jumbo_enable),
      .jumbo_max_length        (jumbo_max_length),
      .endian_swap             (endian_swap),

      // signals going to gem_mac (tx fifo interface).
      .tx_r_data               (tx_r_data_dma),
      .tx_r_data_par           (tx_r_data_par_dma),
      .tx_r_mod                (tx_r_mod_dma),
      .tx_r_sop                (tx_r_sop_dma),
      .tx_r_eop                (tx_r_eop_dma),
      .tx_r_err                (tx_r_err_dma),
      .tx_r_valid              (tx_r_valid_dma),
      .tx_r_data_rdy           (tx_r_data_rdy_dma),
      .dma_is_busy             (dma_is_busy),
      .tx_r_underflow          (tx_r_underflow_dma),
      .tx_r_flushed            (tx_r_flushed_dma),
      .tx_r_control            (tx_r_control_dma),
      .tx_r_frame_size         (tx_r_frame_size_dma),
      .tx_r_frame_size_vld     (tx_r_frame_size_vld_dma),

      // signals coming from gem_mac (tx fifo interface).
      .tx_r_rd                 (tx_r_rd_dma),
      .tx_r_rd_int             (tx_r_rd_int_dma),
      .tx_r_queue_int          (tx_r_queue_int_dma),

      // signals going to gem_mac.
      .dma_tx_status_tog       (dma_tx_status_tog_dma),
      .dma_rx_status_tog       (dma_rx_status_tog_dma),
      .rx_w_overflow           (rx_w_overflow_dma),

      // signals for TX packet buffer if included
      .tx_pbuf_size            (tx_pbuf_size),
      .tx_pbuf_tcp_en          (tx_pbuf_tcp_en),
      .tx_cutthru_threshold    (tx_cutthru_threshold),
      .tx_cutthru              (tx_cutthru),

      // SRAM interface
      .tx_sram_wea             (tx_sram_wea_int),
      .tx_sram_ena             (tx_sram_ena_int),
      .tx_sram_addra           (tx_sram_addra_int),
      .tx_sram_dia             (tx_sram_dia_int),
      .tx_sram_dia_par         (tx_sram_dia_par_int),
      .tx_sram_doa             (tx_sram_doa_int),
      .tx_sram_doa_par         (tx_sram_doa_par_int),
      .tx_sram_web             (tx_sram_web_int),
      .tx_sram_enb             (tx_sram_enb_int),
      .tx_sram_addrb           (tx_sram_addrb_int),
      .tx_sram_dob             (tx_sram_dob_int),
      .tx_sram_dob_par         (tx_sram_dob_par_int),

      .rx_sram_wea             (rx_sram_wea_int),
      .rx_sram_ena             (rx_sram_ena_int),
      .rx_sram_addra           (rx_sram_addra_int),
      .rx_sram_dia             (rx_sram_dia_int),
      .rx_sram_dia_par         (rx_sram_dia_par_int),
      .rx_sram_doa             (rx_sram_doa_int),
      .rx_sram_doa_par         (rx_sram_doa_par_int),
      .rx_sram_web             (rx_sram_web_int),
      .rx_sram_enb             (rx_sram_enb_int),
      .rx_sram_addrb           (rx_sram_addrb_int),
      .rx_sram_dob             (rx_sram_dob_int),
      .rx_sram_dob_par         (rx_sram_dob_par_int),

      // signals going to RX packet buffer if included
      .rx_pbuf_size            (rx_pbuf_size),
      .rx_cutthru_threshold    (rx_cutthru_threshold),
      .rx_cutthru              (rx_cutthru),


      // signals going to gem_reg_top.
      .tx_dma_stable_tog       (tx_dma_stable_tog_dma),
      .tx_dma_complete_ok      (tx_dma_complete_ok_dma),
      .tx_dma_buffers_ex       (tx_dma_buffers_ex_dma),
      .tx_dma_buff_ex_mid      (tx_dma_buff_ex_mid_dma),
      .tx_dma_hresp_notok      (tx_dma_hresp_notok_dma),
      .tx_dma_descr_ptr        (tx_dma_descr_ptr_dma),
      .tx_dma_descr_ptr_tog    (tx_dma_descr_ptr_tog_dma),
      .tx_dma_go               (tx_dma_go_dma),
      .tx_dma_late_col         (tx_dma_late_col_dma),
      .tx_dma_toomanyretry     (tx_dma_toomanyretry_dma),
      .tx_dma_underflow        (tx_dma_underflow_dma),
      .tx_dma_int_queue        (tx_dma_int_queue),
      .rx_dma_stable_tog       (rx_dma_stable_tog_dma),
      .rx_dma_complete_ok      (rx_dma_complete_ok_dma),
      .rx_dma_resource_err     (rx_dma_resource_err_dma),
      .rx_dma_buff_not_rdy     (rx_dma_buff_not_rdy_dma),
      .rx_dma_hresp_notok      (rx_dma_hresp_notok_dma),
      .rx_dma_int_queue        (rx_dma_int_queue),

      .rx_databuf_wr_q         (rx_databuf_wr_q),

      .rx_dma_descr_ptr        (rx_dma_descr_ptr_dma),
      .rx_dma_descr_ptr_tog    (rx_dma_descr_ptr_tog_dma),

      .tx_pbuf_segments        (tx_pbuf_segments),
      .tx_top_q_id             (dma_top_q_id),

      // 64b addressing and extended BD from reg_top
      .upper_tx_q_base_addr        (upper_tx_q_base_addr),
      .upper_rx_q_base_addr        (upper_rx_q_base_addr),
      .upper_rx_q_base_par         (upper_rx_q_base_par),
      .dma_addr_bus_width          (dma_addr_bus_width),

      .tx_bd_extended_mode_en      (tx_bd_extended_mode_en),
      .tx_bd_ts_mode               (tx_bd_ts_mode),

      .rx_bd_extended_mode_en      (rx_bd_extended_mode_en),
      .rx_bd_ts_mode               (rx_bd_ts_mode),

      // Timestamp for current tx packet
      .tx_timestamp                (tx_timestamp_edma),

      // Timestamp for current rx packet
      .rx_timestamp                (rx_timestamp_edma),

      // RAS - Timestamp parity protection
      .tx_timestamp_prty           (tx_timestamp_prty_edma),
      .rx_timestamp_prty           (rx_timestamp_prty_edma),

      // debug port
      .tx_dpram_fill_lvl           (tx_dpram_fill_lvl_dbg),
      .rx_dpram_fill_lvl           (rx_dpram_fill_lvl_dbg),

      // ASF - signals going to gem_reg_top
      .asf_dap_tx_rd_err           (asf_dap_tx_rd_err),
      .asf_dap_tx_wr_err           (asf_dap_tx_wr_err),
      .asf_dap_rx_wr_err           (asf_dap_rx_wr_err),
      .asf_dap_rx_rd_err           (asf_dap_rx_rd_err),

       // lockup detection
      .tx_edma_full_pkt_inc        (tx_edma_full_pkt_inc),
      .tx_edma_used_bit_vec        (tx_edma_used_bit_vec),
      .tx_edma_lockup_flush        (tx_edma_lockup_flush),
      .rx_edma_overflow            (rx_edma_overflow),

      .axi_tx_full_adj_0           (axi_tx_full_adj_0),
      .axi_tx_full_adj_1           (axi_tx_full_adj_1),
      .restart_counter_top         (restart_counter_top),

      // PTP frame decoded signals
      .event_frame_tx              (event_frame_tx),
      .general_frame_tx            (general_frame_tx ),
      .sof_rx                      (sof_rx),
      .event_frame_rx              (event_frame_rx),
      .general_frame_rx            (general_frame_rx),

      // Signals to edma for per queue rx flushing
      .max_val_pclk                   (max_val_pclk),
      .limit_num_bytes_allowed_ambaclk(limit_num_bytes_allowed_ambaclk),
      .fill_lvl_breached              (fill_lvl_breached)

    );

    // Launch Times not supported with AHB DMA ..
    assign tx_r_launch_time_dma     = {p_edma_queues{32'd0}};
    assign tx_r_launch_time_vld_dma = {p_edma_queues{1'd0}};
    assign rsc_clr_tog              = {p_edma_queues{1'b0}};

    // No AXI transaction monitoring in AHB DMA...
    assign axi_xaction_out  = 1'b0;

    // Currently no AHB integrity checking
    assign asf_integrity_dma_err  = 1'b0;

    // disable_rx and tx are not used in AHB mode .. Same with AXI specific signals
    assign disable_rx               = 1'b0;
    assign disable_tx               = 1'b0;
    assign axi_tx_frame_too_large   = 1'b0;
  end

  // Handle SRAM protection and routing.
  if (p_edma_tx_pkt_buffer == 1) begin : gen_pkt_buf_sram

    if (p_edma_asf_dap_prot || p_edma_asf_ecc_sram) begin : gen_sram_prot

      // Start with TX Port A protection.
      // This is always used as a write port
      cdnsdru_asf_sram_protect_v1 #(
        .p_addr_width   (p_edma_tx_pbuf_addr),
        .p_data_width   (p_edma_tx_pbuf_data),
        .p_use_ecc      (p_edma_asf_ecc_sram),
        .p_write_prot   (1'b1),              // Always used for writing
        .p_read_check   (1'b0),
        .p_read_latency (32'd1)
      ) i_tx_sram_prot_a (
        .clock          (ambaclk),
        .reset_n        (ambarst_n),
        .int_sram_en    (tx_sram_ena_int),
        .int_sram_we    (tx_sram_wea_int),
        .int_sram_addr  (tx_sram_addra_int),
        .int_sram_di    (tx_sram_dia_int),  // Note that parity is dropped
        .int_sram_do    (),
        .sram_chk_en    (1'b0),
        .sram_en        (tx_sram_ena),
        .sram_we        (tx_sram_wea),
        .sram_addr      (tx_sram_addra),
        .sram_di        (tx_sram_dia),
        .sram_do        ({p_edma_tx_pbuf_data{1'b0}}),
        .corr_err       (),
        .uncorr_err     (),
        .err_addr       ()
      );

      // Port B protection.
      // When in SPRAM mode, the top level wiring connects the read data with Port A
      // and the internal DMA commands are also mirrored to this port that it is
      // easier to connect up.
      cdnsdru_asf_sram_protect_v1 #(
        .p_addr_width   (p_edma_tx_pbuf_addr),
        .p_data_width   (p_edma_tx_pbuf_data),
        .p_use_ecc      (p_edma_asf_ecc_sram),
        .p_write_prot   (1'b0),              // Never for writing
        .p_read_check   (1'b1),              // Always for reading
        .p_read_latency (32'd1)
      ) i_tx_sram_prot_b (
        .clock          (tx_r_clk),
        .reset_n        (tx_r_rst_n),
        .int_sram_en    (tx_sram_enb_int && !block_sram_ecc_check),
        .int_sram_we    (tx_sram_web_int),
        .int_sram_addr  (tx_sram_addrb_int),
        .int_sram_di    ({p_edma_tx_pbuf_data{1'b0}}),
        .int_sram_do    (tx_sram_dob_int),
        .sram_chk_en    (1'b1),
        .sram_en        (tx_sram_enb),
        .sram_we        (tx_sram_web),
        .sram_addr      (tx_sram_addrb),
        .sram_di        (),
        .sram_do        (tx_sram_dob),
        .corr_err       (tx_corr_err),
        .uncorr_err     (tx_uncorr_err),
        .err_addr       (tx_err_addr)
      );

      // Need to re-generate parity
      cdnsdru_asf_parity_gen_v1 #(.p_data_width(p_edma_tx_pbuf_data)) i_gen_par_tx_b(
        .odd_par    (1'b0),
        .data_in    (tx_sram_dob_int),
        .data_out   (),
        .parity_out (tx_sram_dob_par_int)
      );
      // Ports are mirrored
      assign tx_sram_doa_int      = tx_sram_dob_int;
      assign tx_sram_doa_par_int  = tx_sram_dob_par_int;

      // Similarly for RX
      cdnsdru_asf_sram_protect_v1 #(
        .p_addr_width   (p_edma_rx_pbuf_addr),
        .p_data_width   (p_edma_rx_pbuf_data),
        .p_use_ecc      (p_edma_asf_ecc_sram),
        .p_write_prot   (1'b1),              // Always used for writing
        .p_read_check   (1'b0),
        .p_read_latency (32'd1)
      ) i_rx_sram_prot_a (
        .clock          (rx_clk),
        .reset_n        (n_rxreset),
        .int_sram_en    (rx_sram_ena_int),
        .int_sram_we    (rx_sram_wea_int),
        .int_sram_addr  (rx_sram_addra_int),
        .int_sram_di    (rx_sram_dia_int),  // Note that parity is dropped
        .int_sram_do    (),
        .sram_chk_en    (1'b0),
        .sram_en        (rx_sram_ena),
        .sram_we        (rx_sram_wea),
        .sram_addr      (rx_sram_addra),
        .sram_di        (rx_sram_dia),
        .sram_do        ({p_edma_rx_pbuf_data{1'b0}}),
        .corr_err       (),
        .uncorr_err     (),
        .err_addr       ()
      );

      // Port B protection.
      // When in SPRAM mode, the top level wiring connects the read data with Port A
      // and the internal DMA commands are also mirrored to this port that it is
      // easier to connect up.
      cdnsdru_asf_sram_protect_v1 #(
        .p_addr_width   (p_edma_rx_pbuf_addr),
        .p_data_width   (p_edma_rx_pbuf_data),
        .p_use_ecc      (p_edma_asf_ecc_sram),
        .p_write_prot   (1'b0),              // Never for writing
        .p_read_check   (1'b1),              // Always for reading
        .p_read_latency (32'd1)
      ) i_rx_sram_prot_b (
        .clock          (ambaclk),
        .reset_n        (ambarst_n),
        .int_sram_en    (rx_sram_enb_int),
        .int_sram_we    (rx_sram_web_int),
        .int_sram_addr  (rx_sram_addrb_int),
        .int_sram_di    ({p_edma_rx_pbuf_data{1'b0}}),
        .int_sram_do    (rx_sram_dob_int),
        .sram_chk_en    (1'b1),
        .sram_en        (rx_sram_enb),
        .sram_we        (rx_sram_web),
        .sram_addr      (rx_sram_addrb),
        .sram_di        (),
        .sram_do        (rx_sram_dob),
        .corr_err       (rx_corr_err),
        .uncorr_err     (rx_uncorr_err),
        .err_addr       (rx_err_addr)
      );

      // Need to re-generate parity
      cdnsdru_asf_parity_gen_v1 #(.p_data_width(p_edma_rx_pbuf_data)) i_gen_par_rx_b(
        .odd_par    (1'b0),
        .data_in    (rx_sram_dob_int),
        .data_out   (),
        .parity_out (rx_sram_dob_par_int)
      );
      // Ports are mirrored
      assign rx_sram_doa_int      = rx_sram_dob_int;
      assign rx_sram_doa_par_int  = rx_sram_dob_par_int;

    end else begin : gen_no_sram_prot
      assign tx_sram_wea            = tx_sram_wea_int;
      assign tx_sram_ena            = tx_sram_ena_int;
      assign tx_sram_addra          = tx_sram_addra_int;
      assign tx_sram_dia            = tx_sram_dia_int;
      assign tx_sram_doa_int        = tx_sram_doa;
      assign tx_sram_doa_par_int    = {p_edma_tx_pbuf_pwid{1'b0}};
      assign tx_sram_web            = tx_sram_web_int;
      assign tx_sram_enb            = tx_sram_enb_int;
      assign tx_sram_addrb          = tx_sram_addrb_int;
      assign tx_sram_dob_int        = tx_sram_dob;
      assign tx_sram_dob_par_int    = {p_edma_tx_pbuf_pwid{1'b0}};
      assign rx_sram_wea            = rx_sram_wea_int;
      assign rx_sram_ena            = rx_sram_ena_int;
      assign rx_sram_addra          = rx_sram_addra_int;
      assign rx_sram_dia            = rx_sram_dia_int;
      assign rx_sram_doa_int        = rx_sram_doa;
      assign rx_sram_doa_par_int    = {p_edma_rx_pbuf_pwid{1'b0}};
      assign rx_sram_web            = rx_sram_web_int;
      assign rx_sram_enb            = rx_sram_enb_int;
      assign rx_sram_addrb          = rx_sram_addrb_int;
      assign rx_sram_dob_int        = rx_sram_dob;
      assign rx_sram_dob_par_int    = {p_edma_rx_pbuf_pwid{1'b0}};
      assign tx_corr_err            = 1'b0;
      assign tx_uncorr_err          = 1'b0;
      assign tx_err_addr            = {p_edma_tx_pbuf_addr{1'b0}};
      assign rx_corr_err            = 1'b0;
      assign rx_uncorr_err          = 1'b0;
      assign rx_err_addr            = {p_edma_rx_pbuf_addr{1'b0}};
    end
  end else begin : gen_no_pkt_buf_dma
    // These are just internal wires, not used but tie off to avoid floating signals
    assign tx_sram_wea_int            = 1'b0;
    assign tx_sram_ena_int            = 1'b0;
    assign tx_sram_addra_int          = {p_edma_tx_pbuf_addr{1'b0}};
    assign tx_sram_dia_int            = {p_edma_tx_pbuf_data{1'b0}};
    assign tx_sram_dia_par_int        = {p_edma_tx_pbuf_pwid{1'b0}};
    assign tx_sram_doa_int            = {p_edma_tx_pbuf_data{1'b0}};
    assign tx_sram_doa_par_int        = {p_edma_tx_pbuf_pwid{1'b0}};
    assign tx_sram_web_int            = 1'b0;
    assign tx_sram_enb_int            = 1'b0;
    assign tx_sram_addrb_int          = {p_edma_tx_pbuf_addr{1'b0}};
    assign tx_sram_dob_int            = {p_edma_tx_pbuf_data{1'b0}};
    assign tx_sram_dob_par_int        = {p_edma_tx_pbuf_pwid{1'b0}};
    assign rx_sram_wea_int            = 1'b0;
    assign rx_sram_ena_int            = 1'b0;
    assign rx_sram_addra_int          = {p_edma_rx_pbuf_addr{1'b0}};
    assign rx_sram_dia_int            = {p_edma_rx_pbuf_data{1'b0}};
    assign rx_sram_dia_par_int        = {p_edma_rx_pbuf_pwid{1'b0}};
    assign rx_sram_doa_int            = {p_edma_rx_pbuf_data{1'b0}};
    assign rx_sram_doa_par_int        = {p_edma_rx_pbuf_pwid{1'b0}};
    assign rx_sram_web_int            = 1'b0;
    assign rx_sram_enb_int            = 1'b0;
    assign rx_sram_addrb_int          = {p_edma_rx_pbuf_addr{1'b0}};
    assign rx_sram_dob_int            = {p_edma_rx_pbuf_data{1'b0}};
    assign rx_sram_dob_par_int        = {p_edma_rx_pbuf_pwid{1'b0}};
    assign tx_corr_err                = 1'b0;
    assign tx_uncorr_err              = 1'b0;
    assign tx_err_addr                = {p_edma_tx_pbuf_addr{1'b0}};
    assign rx_corr_err                = 1'b0;
    assign rx_uncorr_err              = 1'b0;
    assign rx_err_addr                = {p_edma_rx_pbuf_addr{1'b0}};
  end

  assign event_frame_rx   = sync_frame_rx | delay_req_rx | pdelay_req_rx | pdelay_resp_rx;

//------------------------------------------------------------------------------
// instantiate gem_lockup_detect
// The addition of a monitor that can detect lockups that
// may have been caused from some unexpected fault
//------------------------------------------------------------------------------

  // Instantiate the lockup detection logic for the DMA part of the design only if not legacy

  if (p_edma_tx_pkt_buffer == 1'b1)
  begin : gen_pbuf_lockup_det
    // Generate pulse per queue as packet passes FIFO i/f
    wire  [p_edma_queues-1:0]      tx_fif_full_pkt_inc; // Per queue pulse on tx_r_valid & tx_r_eop
    genvar loop_q;
    for (loop_q = 0; loop_q < p_edma_queues[31:0]; loop_q = loop_q+1) begin : gen_loop
      assign tx_fif_full_pkt_inc[loop_q]  = tx_r_valid_dma && tx_r_eop_dma && ({{28{1'b0}},tx_r_queue_dma} == loop_q);
    end

    edma_lockup_detect #(
      .p_edma_queues      (p_edma_queues),
      .p_edma_spram       (p_edma_spram)
    ) i_edma_lockup_detect (
      .hclk                   (ambaclk),
      .n_hreset               (ambarst_n),
      .pclk                   (pclk),
      .n_preset               (n_preset),
      .tx_clk                 (tx_clk),
      .n_txreset              (n_txreset),
      .rx_clk                 (rx_clk),
      .n_rxreset              (n_rxreset),
      .lockup_time            (dma_lockup_time),
      .lockup_prescale_tog    (lockup_prescale_tog),
      .full_duplex            (full_duplex),
      .rsc_en                 (|rsc_en),
      .tx_cutthru             (tx_cutthru),
      .rx_cutthru             (rx_cutthru),
      .tx_lockup_mon_en       (dma_tx_lockup_mon_en),
      .rx_lockup_mon_en       (dma_rx_lockup_mon_en),
      .tx_lockup_q_en         (dma_tx_lockup_q_en),
      .tx_enable              (enable_transmit),
      .rx_enable              (enable_receive),
      .tx_disable_queue       (tx_disable_queue),
      .tx_start_pclk          (tx_start_pclk),
      .tx_edma_full_pkt_inc   (tx_edma_full_pkt_inc),
      .tx_edma_used_bit_vec   (tx_edma_used_bit_vec),
      .tx_edma_lockup_flush   (tx_edma_lockup_flush),
      .tx_fif_full_pkt_inc    (tx_fif_full_pkt_inc),

      .rx_w_wr                (rx_w_wr_dma),
      .rx_w_eop               (rx_w_eop_dma),
      .rx_w_err               (rx_w_err_dma),

      .rx_edma_overflow       (rx_edma_overflow),
      .rx_dma_pkt_flushed     (rx_dma_pkt_flushed),
      .rx_dma_complete_ok     (rx_dma_complete_ok),

      .tx_lockup_detected     (dma_tx_lockup_detected),
      .rx_lockup_detected     (dma_rx_lockup_detected)
    );
  end


  end // gen_dma
  endgenerate

  assign tx_timestamp_edma       =  tx_r_timestamp[41:0];
  assign rx_timestamp_edma       =  rx_w_timestamp[41:0];

  // Instantiate the lockup detection logic for the MAC part of the design
  gem_mac_lockup_detect i_mac_lockup_detect (
    .tx_clk             (tx_clk),
    .n_txreset          (n_txreset),
    .rx_clk             (rx_clk),
    .n_rxreset          (n_rxreset),
    .pclk               (pclk),
    .n_preset           (n_preset),
    .lockup_prescale_val(lockup_prescale_val),
    .lockup_prescale_tog(lockup_prescale_tog),
    .tx_lockup_time     (tx_mac_lockup_time),
    .rx_lockup_time     (rx_mac_lockup_time),
    .tx_enable          (enable_transmit),
    .rx_enable          (enable_receive),
    .tx_r_valid         (tx_r_valid_lockup),
    //.tx_r_sop         (tx_r_sop_lockup),     Commented and not deleted for future enhancements
    .tx_r_eop           (tx_r_eop_lockup),
    //.tx_sop_pulse     (lu_det_tx_sop_pulse), Commented and not deleted for future enhancements
    .tx_eop_pulse       (lu_det_tx_eop_pulse),
    .rx_w_wr            (rx_w_wr_mac),
    //.rx_w_sop         (rx_w_sop_mac),        Commented and not deleted for future enhancements
    .rx_w_eop           (rx_w_eop_mac),
    .rx_w_err           (rx_w_err_mac),
    .rx_w_bad_frame     (rx_w_bad_frame),
    .tx_lockup_mon_en   (tx_lockup_mon_en),
    .rx_lockup_mon_en   (rx_lockup_mon_en),
    .tx_lockup_detected (tx_lockup_detected),
    .rx_lockup_detected (rx_lockup_detected)
  );


//------------------------------------------------------------------------------
// instantiate gem_reg_top (gem_registers & gem_pclk_syncs).
//------------------------------------------------------------------------------

   gem_reg_top #(.grouped_params(grouped_params))

   i_gem_reg_top (

      // system signals.
      .n_preset                (n_preset),
      .pclk                    (pclk),
      .n_tsureset              (n_tsureset),
      .tsu_clk                 (tsu_clk),
      .n_txreset               (n_txreset),
      .tx_clk                  (tx_clk),
      .n_hreset                (ambarst_n),
      .hclk                    (ambaclk),
      .n_rxreset               (n_rxreset),
      .rx_clk                  (rx_clk),

      // APB interface signals.
      .paddr                   (paddr),
      .prdata                  (prdata),
      .prdata_par              (prdata_par),
      .pwdata                  (pwdata),
      .pwdata_par              (pwdata_par),
      .pwrite                  (pwrite),
      .penable                 (penable),
      .psel                    (psel),
      .perr                    (perr),

      // other top level signals.
      .ext_interrupt_in        (ext_interrupt_in),
      .mdio_in                 (mdio_in),
      .mdio_en                 (mdio_en),
      .mdio_out                (mdio_out),
      .mdc                     (mdc),
      .ethernet_int            (ethernet_int_bus[15:0]),
      .loopback                (loopback),
      .half_duplex             (half_duplex),
      .speed_mode              (speed_mode),
      .tx_byte_mode            (tx_byte_mode),
      .rx_no_crc_check         (rx_no_crc_check),
      .user_out                (user_out),
      .user_in                 (user_in),

      // handshaking between gem_mac and gem_reg_top.
      .tx_end_tog              (tx_end_tog_mac),
      .tx_status_wr_tog        (tx_status_wr_tog),
      .tx_pause_tog_ack        (tx_pause_tog_ack),

      .rx_dma_pkt_flushed      (rx_dma_pkt_flushed_reg),
      .rx_pkt_dbuff_overflow   (rx_pkt_dbuff_overflow),

      .rx_end_tog              (rx_end_tog_reg),
      .rx_status_wr_tog        (rx_status_wr_tog_reg),
      .rx_frame_rxed_ok        (rx_frame_rxed_ok_reg),
      .rx_bytes_in_frame       (rx_bytes_in_frame_reg),
      .rx_broadcast_frame      (rx_broadcast_frame_reg),
      .rx_multicast_frame      (rx_multicast_frame_reg),
      .rx_align_error          (rx_align_error_reg),
      .rx_crc_error            (rx_crc_error_reg),
      .rx_short_error          (rx_short_error_reg),
      .rx_long_error           (rx_long_error_reg),
      .rx_jabber_error         (rx_jabber_error_reg),
      .rx_symbol_error         (rx_symbol_error_reg),
      .rx_pause_frame          (rx_pause_frame_reg),
      .rx_pause_nonzero        (rx_pause_nonzero_reg),
      .rx_length_error         (rx_length_error_reg),
      .rx_ip_ck_error          (rx_ip_ck_error_reg),
      .rx_tcp_ck_error         (rx_tcp_ck_error_reg),
      .rx_udp_ck_error         (rx_udp_ck_error_reg),
      .rx_overflow             (rx_overflow_reg),

      .pfc_negotiate           (pfc_negotiate),
      .rx_pfc_paused           (rx_pfc_paused),
      .lpi_indicate            (lpi_indicate),
      .wol                     (wol),

      // signals coming from gem_tx.
      .tx_frame_txed_ok        (tx_frame_txed_ok),
      .tx_bytes_in_frame       (tx_bytes_in_frame),
      .tx_broadcast_frame      (tx_broadcast_frame),
      .tx_multicast_frame      (tx_multicast_frame),
      .tx_single_coll_frame    (tx_single_coll_frame),
      .tx_multi_coll_frame     (tx_multi_coll_frame),
      .tx_late_coll_frame      (tx_late_coll_frame),
      .tx_deferred_tx_frame    (tx_deferred_tx_frame),
      .tx_crs_error_frame      (tx_crs_error_frame),
      .tx_coll_occured         (tx_coll_occured),
      .tx_pause_time           (tx_pause_time),
      .tx_pause_time_tog       (tx_pause_time_tog),
      .tx_pause_frame_txed     (tx_pause_frame_txed),
      .tx_pfc_pause_frame_txed (tx_pfc_pause_frame_txed),

      // handshaking between edma_top and gem_reg_top.
      .tx_dma_stable_tog       (tx_dma_stable_tog),
      .tx_dma_stat_capt_tog    (tx_dma_stat_capt_tog),
      .rx_dma_stable_tog       (rx_dma_stable_tog),
      .rx_dma_stat_capt_tog    (rx_dma_stat_capt_tog),

      // signals coming from edma_tx.
      .tx_dma_complete_ok      (tx_dma_complete_ok),
      .tx_dma_buffers_ex       (tx_dma_buffers_ex),
      .tx_dma_buff_ex_mid      (tx_dma_buff_ex_mid),
      .tx_dma_go               (tx_dma_go),
      .tx_dma_hresp_notok      (tx_dma_hresp_notok),
      .tx_dma_descr_ptr        (tx_dma_descr_ptr),
      .tx_dma_descr_ptr_tog    (tx_dma_descr_ptr_tog),
      .tx_dma_late_col         (tx_dma_late_col),
      .tx_dma_toomanyretry     (tx_dma_toomanyretry),
      .tx_dma_underflow        (tx_dma_underflow),
      .tx_too_many_retries     (tx_too_many_retries),
      .tx_underflow_frame      (tx_underflow_frame),
      .tx_dma_int_queue        (tx_dma_int_queue),

      // signals coming from edma_rx.
      .rx_dma_complete_ok      (rx_dma_complete_ok),
      .rx_dma_buff_not_rdy     (rx_dma_buff_not_rdy),
      .rx_dma_resource_err     (rx_dma_resource_err),
      .rx_dma_hresp_notok      (rx_dma_hresp_notok),
      .rx_dma_descr_ptr        (rx_dma_descr_ptr),
      .rx_dma_descr_ptr_tog    (rx_dma_descr_ptr_tog),
      .rx_dma_int_queue        (rx_dma_int_queue),

      // signals coming from gem_pcs_register.
      .pcs_link_state          (pcs_link_state),
      .pcs_an_complete         (pcs_an_complete),
      .np_data_int             (np_data_int),
      .mac_pause_tx_en         (mac_pause_tx_en),
      .mac_pause_rx_en         (mac_pause_rx_en),
      .mac_full_duplex         (mac_full_duplex),

      // signals going to edma_top.
      .rx_dma_descr_base_addr  (rx_dma_descr_base_addr),
      .rx_dma_descr_base_par   (rx_dma_descr_base_par), // TOIMPRV tx/rx and upper base addresses for ahb and legacy dma
      .tx_dma_descr_base_addr  (tx_dma_descr_base_addr),
      .tx_dma_descr_base_par   (tx_dma_descr_base_par),
      .rx_dma_buffer_size      (rx_dma_buffer_size),
      .rx_dma_buffer_offset    (rx_dma_buffer_offset),
      .new_receive_q_ptr       (new_receive_q_ptr),
      .new_transmit_q_ptr      (new_transmit_q_ptr),
      .rx_buff_not_rdy_pclk    (rx_buff_not_rdy_pclk),
      .tx_start_pclk           (tx_start_pclk),
      .tx_halt_pclk            (tx_halt_pclk),
      .flush_rx_pkt_pclk       (flush_rx_pkt_pclk),
      .hdr_data_splitting_en   (hdr_data_splitting_en),
      .infinite_last_dbuf_size_en(infinite_last_dbuf_size_en),
      .ahb_burst_length        (ahb_burst_length),
      .endian_swap             (endian_swap),
      .axi_tx_frame_too_large  (axi_tx_frame_too_large),
      .axi_xaction_out         (axi_xaction_out),
      .disable_tx              (disable_tx),
      .disable_rx              (disable_rx),

      .screener_type1_regs     (screener_type1_regs),
      .screener_type2_regs     (screener_type2_regs),
      .scr2_compare_regs       (scr2_compare_regs),
      .scr2_ethtype_regs       (scr2_ethtype_regs),

      // signals going to edma_top (gem_hclk_syncs) and gem_mac.
      .enable_transmit         (enable_transmit),
      .enable_receive          (enable_receive),
      .dma_bus_width           (dma_bus_width),

      // signals going to packet buffers
      .rx_pbuf_size            (rx_pbuf_size),
      .rx_cutthru_threshold    (rx_cutthru_threshold),
      .rx_cutthru              (rx_cutthru),
      .crc_error_report        (crc_error_report),
      .tx_pbuf_size            (tx_pbuf_size),
      .tx_pbuf_tcp_en          (tx_pbuf_tcp_en),
      .tx_cutthru_threshold    (tx_cutthru_threshold),
      .tx_cutthru              (tx_cutthru),

      //signals going to gem_pcs
      .alt_sgmii_mode          (alt_sgmii_mode),
      .sgmii_mode              (sgmii_mode),
      .uni_direct_en           (uni_direct_en),

      // signals going to gem_mac.
      .ign_ipg_rx_er           (ign_ipg_rx_er),
      .rx_bad_preamble         (rx_bad_preamble),
      .stretch_enable          (stretch_enable),
      .stretch_ratio           (stretch_ratio),
      .min_ifg                 (min_ifg),
      .retry_test              (retry_test),
      .tx_pause_quantum        (tx_pause_quantum),
      .tx_pause_quantum_par    (tx_pause_quantum_par),
      .tx_pause_quantum_p1     (tx_pause_quantum_p1),
      .tx_pause_quantum_p1_par (tx_pause_quantum_p1_par),
      .tx_pause_quantum_p2     (tx_pause_quantum_p2),
      .tx_pause_quantum_p2_par (tx_pause_quantum_p2_par),
      .tx_pause_quantum_p3     (tx_pause_quantum_p3),
      .tx_pause_quantum_p3_par (tx_pause_quantum_p3_par),
      .tx_pause_quantum_p4     (tx_pause_quantum_p4),
      .tx_pause_quantum_p4_par (tx_pause_quantum_p4_par),
      .tx_pause_quantum_p5     (tx_pause_quantum_p5),
      .tx_pause_quantum_p5_par (tx_pause_quantum_p5_par),
      .tx_pause_quantum_p6     (tx_pause_quantum_p6),
      .tx_pause_quantum_p6_par (tx_pause_quantum_p6_par),
      .tx_pause_quantum_p7     (tx_pause_quantum_p7),
      .tx_pause_quantum_p7_par (tx_pause_quantum_p7_par),
      .tx_pause_frame_req      (tx_pause_frame_req),
      .tx_pause_frame_zero     (tx_pause_frame_zero),
      .tx_pfc_frame_req        (tx_pfc_frame_req),
      .tx_pfc_frame_pri        (tx_pfc_frame_pri),
      .tx_pfc_frame_pri_par    (tx_pfc_frame_pri_par),
      .tx_pfc_frame_zero       (tx_pfc_frame_zero),
      .tx_lpi_en               (tx_lpi_en),
      .ifg_eats_qav_credit     (ifg_eats_qav_credit),
      .tw_sys_tx_time          (tw_sys_tx_time),
      .pause_enable            (pause_enable),
      .rx_1536_en              (rx_1536_en),
      .jumbo_enable            (jumbo_enable),
      .force_discard_on_err    (force_discard_on_err),
      .force_max_ahb_burst_rx  (force_max_ahb_burst_rx),
      .force_max_ahb_burst_tx  (force_max_ahb_burst_tx),
      .check_rx_length         (check_rx_length),
      .strip_rx_fcs            (strip_rx_fcs),
      .store_udp_offset        (store_udp_offset),
      .pfc_enable              (pfc_enable),
      .ptp_unicast_ena         (ptp_unicast_ena),
      .rx_ptp_unicast          (rx_ptp_unicast),
      .tx_ptp_unicast          (tx_ptp_unicast),
      .rx_fill_level_low       (rx_fill_level_low),
      .rx_fill_level_high      (rx_fill_level_high),

      // precision time protocol signals for IEEE 1588 support
      .sync_frame_rx           (sync_frame_rx),
      .delay_req_rx            (delay_req_rx),
      .pdelay_req_rx           (pdelay_req_rx),
      .pdelay_resp_rx          (pdelay_resp_rx),
      .sync_frame_tx           (sync_frame_tx),
      .delay_req_tx            (delay_req_tx),
      .pdelay_req_tx           (pdelay_req_tx),
      .pdelay_resp_tx          (pdelay_resp_tx),

      .store_rx_ts             (store_rx_ts),
      .tsu_timer_sec           (tsu_timer_sec),
      .tsu_timer_nsec          (tsu_timer_nsec),
      .tsu_timer_sec_wr        (tsu_timer_sec_wr),
      .tsu_timer_nsec_wr       (tsu_timer_nsec_wr),
      .tsu_timer_adj_ctrl      (tsu_timer_adj_ctrl),
      .tsu_timer_adj           (tsu_timer_adj),
      .tsu_timer_adj_wr        (tsu_timer_adj_wr),
      .tsu_timer_incr          (tsu_timer_incr),
      .tsu_timer_incr_wr       (tsu_timer_incr_wr),
      .tsu_timer_alt_incr      (tsu_timer_alt_incr),
      .tsu_timer_num_incr      (tsu_timer_num_incr),
      .tsu_sec_incr            (tsu_sec_incr),
      .tsu_timer_nsec_cmp      (tsu_timer_nsec_cmp),
      .tsu_timer_sec_cmp       (tsu_timer_sec_cmp),
      .tsu_timer_nsec_cmp_wr   (tsu_timer_nsec_cmp_wr),
      .timer_strobe            (timer_strobe),
      .tsu_timer_cmp_val       (tsu_timer_cmp_val),
      .tsu_timer_cnt           (tsu_timer_cnt[93:16]),
      .tsu_timer_cnt_par       (tsu_timer_cnt_par[11:2]),
      .tsu_ptp_tx_timer_in     (tsu_ptp_tx_timer_out_mac),
      .tsu_ptp_rx_timer_in     (tsu_ptp_rx_timer_out_mac),
      .tsu_ptp_tx_timer_prty_in(tsu_ptp_tx_timer_prty_out_mac),
      .tsu_ptp_rx_timer_prty_in(tsu_ptp_rx_timer_prty_out_mac),
      .one_step_sync_mode      (one_step_sync_mode),
      .oss_correction_field    (oss_correction_field),
      .ext_tsu_timer_en        (ext_tsu_timer_en),

      // signals going to gem_mac (gem_filter).
      .back_pressure           (back_pressure),
      .full_duplex             (full_duplex),
      .loopback_local          (loopback_local),
      .en_half_duplex_rx       (en_half_duplex_rx),
      .rx_no_pause_frames      (rx_no_pause_frames),
      .rx_toe_enable           (rx_toe_enable),
      .ext_match_en            (ext_match_en),
      .uni_hash_en             (uni_hash_en),
      .multi_hash_en           (multi_hash_en),
      .no_broadcast            (no_broadcast),
      .copy_all_frames         (copy_all_frames),
      .rm_non_vlan             (rm_non_vlan),
      .hash                    (hash),
      .mask_add1               (mask_add1),
      .spec_add_filter_regs    (spec_add_filter_regs),
      .spec_add_filter_active  (spec_add_filter_active),
      .spec_add1_tx            (spec_add1_tx),
      .spec_add1_tx_par        (spec_add1_tx_par),
      .spec_type1              (spec_type1),
      .spec_type2              (spec_type2),
      .spec_type3              (spec_type3),
      .spec_type4              (spec_type4),
      .spec_type1_active       (spec_type1_active),
      .spec_type2_active       (spec_type2_active),
      .spec_type3_active       (spec_type3_active),
      .spec_type4_active       (spec_type4_active),
      .wol_ip_addr             (wol_ip_addr),
      .wol_mask                (wol_mask),
      .dma_addr_or_mask        (dma_addr_or_mask),
      .stacked_vlantype        (stacked_vlantype),

      .tx_pbuf_segments        (tx_pbuf_segments),
      .tx_disable_queue        (tx_disable_queue),
      .rx_disable_queue        (rx_disable_queue),

      // Credit Based Shaping
      .cbs_enable           (cbs_enable),
      .cbs_q_a_id           (cbs_q_a_id),
      .cbs_q_b_id           (cbs_q_b_id),
      .idleslope_q_a        (idleslope_q_a),
      .idleslope_q_b        (idleslope_q_b),
      .port_tx_rate         (port_tx_rate),
      .dwrr_ets_control     (dwrr_ets_control),
      .bw_rate_limit        (bw_rate_limit),

      .soft_config_fifo_en  (soft_config_fifo_en),

      .jumbo_max_length     (jumbo_max_length),
      .ext_rxq_sel_en       (ext_rxq_sel_en),

      // AXI specific
      .use_aw2b_fill        (use_aw2b_fill),
      .max_num_axi_ar2r     (max_num_axi_ar2r),
      .max_num_axi_aw2w     (max_num_axi_aw2w),

      .rsc_en               (rsc_en),

      .upper_tx_q_base_addr        (upper_tx_q_base_addr),
      .upper_tx_q_base_par         (upper_tx_q_base_par),
      .upper_rx_q_base_addr        (upper_rx_q_base_addr),
      .upper_rx_q_base_par         (upper_rx_q_base_par),
      .dma_addr_bus_width          (dma_addr_bus_width),

      .tx_dpram_fill_lvl_dbg       (tx_dpram_fill_lvl_dbg),
      .rx_dpram_fill_lvl_dbg       (rx_dpram_fill_lvl_dbg),

      .axi_tx_full_adj_0           (axi_tx_full_adj_0),
      .axi_tx_full_adj_1           (axi_tx_full_adj_1),
      .axi_tx_full_adj_2           (axi_tx_full_adj_2),
      .axi_tx_full_adj_3           (axi_tx_full_adj_3),

      // RSC specific
      .rsc_clr_tog                 (rsc_clr_tog),

      .restart_counter_top         (restart_counter_top),

      .tx_bd_extended_mode_en      (tx_bd_extended_mode_en),
      .tx_bd_ts_mode               (tx_bd_ts_mode),

      .rx_bd_extended_mode_en      (rx_bd_extended_mode_en),
      .rx_bd_ts_mode               (rx_bd_ts_mode),

      .sel_mii_on_rgmii            (sel_mii_on_rgmii),

      // EnST signals
      .enst_en                     (enst_en),
      .start_time                  (start_time),
      .on_time                     (on_time),
      .off_time                    (off_time),

      // ASF external status inputs
      .asf_dap_paddr_err       (asf_dap_paddr_err),
      .asf_dap_prdata_err      (asf_dap_prdata_err),
      .asf_dap_rdata_err       (asf_dap_rdata_err),
      .asf_csr_pcs_err         (asf_csr_pcs_err),
      .asf_csr_mmsl_err        (asf_csr_mmsl_err),
      .asf_dap_pcs_tx_err      (asf_dap_pcs_tx_err),
      .asf_dap_pcs_rx_err      (asf_dap_pcs_rx_err),
      .asf_dap_mmsl_tx_err     (asf_dap_mmsl_tx_err),
      .asf_dap_mmsl_rx_err     (asf_dap_mmsl_rx_err),

      // ASF - from SRAM protection
      .tx_corr_err                 (tx_corr_err),
      .tx_uncorr_err               (tx_uncorr_err),
      .tx_err_addr                 (tx_err_addr),
      .rx_corr_err                 (rx_corr_err),
      .rx_uncorr_err               (rx_uncorr_err),
      .rx_err_addr                 (rx_err_addr),

      .asf_dap_txclk_err           (asf_dap_txclk_err),
      .asf_dap_rxclk_err           (asf_dap_rxclk_err),
      .asf_dap_dma_err             (asf_dap_dma_err),
      .asf_integrity_dma_err       (asf_integrity_dma_err),
      .asf_integrity_tsu_err       (asf_integrity_tsu_err),
      .asf_integrity_tx_sched_err  (asf_integrity_tx_sched_err),
      .asf_host_trans_to_err       (asf_host_trans_to_err),

      // signals from lockup detection
      .tx_lockup_detected         (tx_lockup_detected),
      .rx_lockup_detected         (rx_lockup_detected),
      .dma_tx_lockup_detected     (dma_tx_lockup_detected),
      .dma_rx_lockup_detected     (dma_rx_lockup_detected),

      // signals going to lockup detection
      .dma_tx_lockup_mon_en       (dma_tx_lockup_mon_en),
      .dma_rx_lockup_mon_en       (dma_rx_lockup_mon_en),
      .dma_tx_lockup_q_en         (dma_tx_lockup_q_en),
      .tx_lockup_mon_en           (tx_lockup_mon_en),
      .rx_lockup_mon_en           (rx_lockup_mon_en),
      .lockup_prescale_val        (lockup_prescale_val),
      .dma_lockup_time            (dma_lockup_time),
      .tx_mac_lockup_time         (tx_mac_lockup_time),
      .rx_mac_lockup_time         (rx_mac_lockup_time),

      // 802.1CB Control and Status
      .frer_to_cnt                 (frer_to_cnt),
      .frer_rtag_ethertype         (frer_rtag_ethertype),
      .frer_strip_rtag             (frer_strip_rtag),
      .frer_6b_tag                 (frer_6b_tag),
      .frer_en_vec_alg             (frer_en_vec_alg),
      .frer_use_rtag               (frer_use_rtag),
      .frer_seqnum_oset            (frer_seqnum_oset),
      .frer_seqnum_len             (frer_seqnum_len),
      .frer_scr_sel_1              (frer_scr_sel_1),
      .frer_scr_sel_2              (frer_scr_sel_2),
      .frer_vec_win_sz             (frer_vec_win_sz),
      .frer_en_elim                (frer_en_elim),
      .frer_en_to                  (frer_en_to),
      .frer_to_tog                 (frer_to_tog),
      .frer_rogue_tog              (frer_rogue_tog),
      .frer_ooo_tog                (frer_ooo_tog),
      .frer_err_upd_tog            (frer_err_upd_tog),
      .frer_err_upd_val            (frer_err_upd_val),

      // Rx traffic policing registers
      .rx_q_flush                  (rx_q_flush_pclk),

      // per type 2 screener rate limiting algorithm registers
      .scr2_rate_lim               (scr2_rate_lim),
      .scr_excess_rate             (scr_excess_rate),

      // toggle to stats, indicating a frame flushed by mode2, 3, or 4
      .frame_flushed_tog           (frame_flushed_tog),

      // AXI QoS configuration
      .axi_qos_q_mapping           (axi_qos_q_mapping),

      // Link Fault Signalling
      .link_fault_signal_en        (link_fault_signal_en),
      .link_fault_status           (link_fault_status),

      // ASF configuration
      .asf_trans_to_en             (asf_trans_to_en),
      .asf_trans_to_time           (asf_trans_to_time),

      // ASF signalling
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

//------------------------------------------------------------------------------
// Synchronizing some bits of rx_q_flush_pclk to rx_clk domain and hclk domain
//------------------------------------------------------------------------------
   genvar m;
   genvar n;
   // Only synchronize the bits to the hclk domain if not in FIFO mode and RX-packet buffer mode is defined
   generate if ((p_edma_ext_fifo_interface == 1'b0) && (p_edma_rx_pkt_buffer == 1)) begin: gen_rx_q_flush_sync_ambaclk
     for(n=0; n<p_edma_queues[31:0]; n=n+1)
     begin: queue_loop
       reg limit_num_bytes_allowed_pclk;

       // Synchronising bit 1 of rx_q_flush_pclk in hclk/aclk domain
       cdnsdru_datasync_v1 i_rx_q_flush_bit1_ambaclk (
       .clk     (ambaclk),
       .reset_n (ambarst_n),
       .din     (rx_q_flush_pclk[(32*n)+1]),
       .dout    (force_discard_on_err_q[n])
       );

       // Mode2 is allowed only if Mode3 is not. We will do here the AND operation
       // rather than in the ambaclk domain, where it would result as a convergence issue
       // Also, it will be registered in its source domain before it will be synced to the
       // ambaclk domain to improve the MTBF
       always @ (posedge pclk or negedge n_preset)
       begin
         if(~n_preset)
           limit_num_bytes_allowed_pclk <= 1'b0;
         else
           limit_num_bytes_allowed_pclk <= rx_q_flush_pclk[(32*n)+2] && ~rx_q_flush_pclk[(32*n)+3];
       end

       // Synchronising bit 2 of rx_q_flush_pclk in hclk/aclk domain
       cdnsdru_datasync_v1 i_rx_q_flush_bit2_ambaclk(
         .clk    (ambaclk),
         .reset_n(ambarst_n),
         .din    (limit_num_bytes_allowed_pclk),
         .dout   (limit_num_bytes_allowed_ambaclk[n])
       );

     end
   end else begin: gen_no_rx_q_flush_sync_ambaclk
     assign force_discard_on_err_q          = {p_edma_queues{1'b0}};
     assign limit_num_bytes_allowed_ambaclk = {p_edma_queues{1'b0}};
   end
   endgenerate

   generate for (m=0; m<p_edma_queues[31:0]; m=m+1)
   begin: gen_rx_q_flush_sync_rx_clk
     // Synchronising bit 0 of rx_q_flush_pclk in rx_clk domain
     cdnsdru_datasync_v1 i_rx_q_flush_bit0_rxclk(
       .clk    (rx_clk),
       .reset_n(n_rxreset),
       .din    (rx_q_flush_pclk[32*m]),
       .dout   (drop_all_frames_rx_clk[m])
     );

     // Synchronising bit 3 of rx_q_flush_pclk in rx_clk domain
     cdnsdru_datasync_v1 i_rx_q_flush_bit3_rxclk(
       .clk    (rx_clk),
       .reset_n(n_rxreset),
       .din    (rx_q_flush_pclk[(32*m)+3]),
       .dout   (limit_frames_size_rx_clk[m])
     );
     assign max_val_pclk [(15+(m*16)):(m*16)] = rx_q_flush_pclk [(32*m)+31:(32*m)+16]; // max_val is a static
   end
   endgenerate

//------------------------------------------------------------------------------
// instantiate gem_tsu
// precision time protocol signals for IEEE 1588 support
//------------------------------------------------------------------------------
generate if (p_edma_tsu == 1'b1) begin : gen_tsu
  wire  tsu_timer_sec_wr_s;
  wire  tsu_timer_nsec_wr_s;
  wire  tsu_timer_adj_wr_s;
  wire  tsu_timer_incr_wr_s;
  wire  tsu_timer_nsec_cmp_wr_s;

  if (p_edma_tsu_clk == 1) begin : gen_using_tsu_clk
    // Synchronise the control signals to the TSU externally to ensure that if
    // we also instantiate a duplicate TSU there will not be any convergence issues
    // as both units need to operate in tandem.
    cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tsu_timer_adj_wr (
      .clk    (tsu_clk),
      .reset_n(n_tsureset),
      .din    (tsu_timer_adj_wr),
      .dout   (tsu_timer_adj_wr_s)
    );
    cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tsu_timer_sec_wr (
      .clk    (tsu_clk),
      .reset_n(n_tsureset),
      .din    (tsu_timer_sec_wr),
      .dout   (tsu_timer_sec_wr_s)
    );
    cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tsu_timer_nsec_wr (
      .clk    (tsu_clk),
      .reset_n(n_tsureset),
      .din    (tsu_timer_nsec_wr),
      .dout   (tsu_timer_nsec_wr_s)
    );
    cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tsu_timer_incr_wr (
      .clk    (tsu_clk),
      .reset_n(n_tsureset),
      .din    (tsu_timer_incr_wr),
      .dout   (tsu_timer_incr_wr_s)
    );
    cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tsu_timer_nsec_cmp_wr (
      .clk    (tsu_clk),
      .reset_n(n_tsureset),
      .din    (tsu_timer_nsec_cmp_wr),
      .dout   (tsu_timer_nsec_cmp_wr_s)
    );
  end else begin : gen_not_using_tsu_clk
    assign tsu_timer_adj_wr_s   = tsu_timer_adj_wr;
    assign tsu_timer_sec_wr_s   = tsu_timer_sec_wr;
    assign tsu_timer_nsec_wr_s  = tsu_timer_nsec_wr;
    assign tsu_timer_incr_wr_s  = tsu_timer_incr_wr;
    assign tsu_timer_nsec_cmp_wr_s = tsu_timer_nsec_cmp_wr;
  end


   gem_tsu #(
      .p_edma_tsu_clk       (p_edma_tsu_clk),
      .p_edma_ext_tsu_timer (p_edma_ext_tsu_timer),
      .p_edma_asf_dap_prot  (p_edma_asf_dap_prot)
   ) i_gem_tsu (

      // clock and reset
      .tsu_clk                 (tsu_clk),
      .n_tsureset              (n_tsureset),

      // external input signals
      .gem_tsu_ms              (gem_tsu_ms),
      .gem_tsu_inc_ctrl        (gem_tsu_inc_ctrl),

      // signals from gem_registers
      .tsu_timer_sec           (tsu_timer_sec),
      .tsu_timer_nsec          (tsu_timer_nsec),
      .tsu_timer_sec_wr        (tsu_timer_sec_wr_s),
      .tsu_timer_nsec_wr       (tsu_timer_nsec_wr_s),
      .tsu_timer_adj_ctrl      (tsu_timer_adj_ctrl),
      .tsu_timer_adj           (tsu_timer_adj),
      .tsu_timer_adj_wr        (tsu_timer_adj_wr_s),
      .tsu_timer_incr          (tsu_timer_incr),
      .tsu_timer_incr_wr       (tsu_timer_incr_wr_s),
      .tsu_timer_alt_incr      (tsu_timer_alt_incr),
      .tsu_timer_num_incr      (tsu_timer_num_incr),
      .tsu_timer_nsec_cmp      (tsu_timer_nsec_cmp),
      .tsu_timer_sec_cmp       (tsu_timer_sec_cmp),
      .tsu_timer_nsec_cmp_wr   (tsu_timer_nsec_cmp_wr_s),

      // signals to gem_registers
       // external tsu timer ports
      .ext_tsu_timer           (ext_tsu_timer),
      .ext_tsu_timer_par       (ext_tsu_timer_par),
      .ext_tsu_timer_en        (ext_tsu_timer_en),

      .timer_strobe            (timer_strobe),
      .tsu_sec_incr            (tsu_sec_incr),
      .tsu_timer_cnt           (tsu_timer_cnt),
      .tsu_timer_cnt_par       (tsu_timer_cnt_par),
      .tsu_timer_cmp_val       (tsu_timer_cmp_val)
   );

  //------------------------------------------------------------------------------
  // ASF - instantiate gem_tsu_
  // Protection to precision time protocol signals for IEEE 1588 support
  //------------------------------------------------------------------------------
  if (p_edma_asf_prot_tsu == 1) begin : gen_tsu_protect

   wire  [93:0] tsu_timer_cnt_dplc;     // TSU duplicate timer count value
   wire  [11:0] tsu_timer_cnt_par_dplc;
   wire         timer_strobe_dplc;
   wire         tsu_sec_incr_dplc;
   wire         tsu_timer_cmp_val_dplc;

   //The second instance of the TSU
   gem_tsu #(
      .p_edma_tsu_clk       (p_edma_tsu_clk),
      .p_edma_ext_tsu_timer (p_edma_ext_tsu_timer),
      .p_edma_asf_dap_prot  (p_edma_asf_dap_prot)
   ) i_gem_tsu_asf_duplc (

      // clock and reset
      .tsu_clk                 (tsu_clk),
      .n_tsureset              (n_tsureset),

      // external input signals
      .gem_tsu_ms              (gem_tsu_ms),
      .gem_tsu_inc_ctrl        (gem_tsu_inc_ctrl),

      // signals from gem_registers
      .tsu_timer_sec           (tsu_timer_sec),
      .tsu_timer_nsec          (tsu_timer_nsec),
      .tsu_timer_sec_wr        (tsu_timer_sec_wr_s),
      .tsu_timer_nsec_wr       (tsu_timer_nsec_wr_s),
      .tsu_timer_adj_ctrl      (tsu_timer_adj_ctrl),
      .tsu_timer_adj           (tsu_timer_adj),
      .tsu_timer_adj_wr        (tsu_timer_adj_wr_s),
      .tsu_timer_incr          (tsu_timer_incr),
      .tsu_timer_incr_wr       (tsu_timer_incr_wr_s),
      .tsu_timer_alt_incr      (tsu_timer_alt_incr),
      .tsu_timer_num_incr      (tsu_timer_num_incr),
      .tsu_timer_nsec_cmp      (tsu_timer_nsec_cmp),
      .tsu_timer_sec_cmp       (tsu_timer_sec_cmp),
      .tsu_timer_nsec_cmp_wr   (tsu_timer_nsec_cmp_wr_s),

      // signals to gem_registers
       // external tsu timer ports
      .ext_tsu_timer           (ext_tsu_timer),
      .ext_tsu_timer_par       (ext_tsu_timer_par),
      .ext_tsu_timer_en        (ext_tsu_timer_en),

      .timer_strobe            (timer_strobe_dplc),
      .tsu_sec_incr            (tsu_sec_incr_dplc),
      .tsu_timer_cnt           (tsu_timer_cnt_dplc),
      .tsu_timer_cnt_par       (tsu_timer_cnt_par_dplc),
      .tsu_timer_cmp_val       (tsu_timer_cmp_val_dplc)
   );

   assign asf_integrity_tsu_err = ({timer_strobe,
                                    tsu_sec_incr,
                                    tsu_timer_cnt,
                                    tsu_timer_cnt_par,
                                    tsu_timer_cmp_val}) != ({timer_strobe_dplc,
                                                              tsu_sec_incr_dplc,
                                                              tsu_timer_cnt_dplc,
                                                              tsu_timer_cnt_par_dplc,
                                                              tsu_timer_cmp_val_dplc});

  end else begin : gen_no_tsu_protect
   assign asf_integrity_tsu_err = 1'b0;
  end

  /////////////////////////////////////////////////
  // ASF - timestamp value parity protection
  // Need to regenerate the parity as only 42-bits used
  // by the DMA so check and regenerate here.
  if (p_edma_asf_dap_prot == 1'b1) begin : gen_ts_capt_par

    gem_par_chk_regen #(.p_chk_dwid (78),.p_new_dwid(42)) i_regen_rx_w_timestamp_edma (
      .odd_par  (1'b0),
      .chk_dat  (rx_w_timestamp),
      .chk_par  (rx_w_timestamp_par),
      .new_dat  (rx_timestamp_edma),
      .dat_out  (),
      .par_out  (rx_timestamp_prty_edma),
      .chk_err  (asf_dap_mac_rx_ts_err)
    );
    gem_par_chk_regen #(.p_chk_dwid (78),.p_new_dwid(42)) i_regen_tx_r_timestamp_edma (
      .odd_par  (1'b0),
      .chk_dat  (tx_r_timestamp),
      .chk_par  (tx_r_timestamp_par),
      .new_dat  (tx_timestamp_edma),
      .dat_out  (),
      .par_out  (tx_timestamp_prty_edma),
      .chk_err  (asf_dap_mac_tx_ts_err)
    );

  end else begin : gen_no_ts_parity
    assign asf_dap_mac_rx_ts_err  = 1'b0;
    assign asf_dap_mac_tx_ts_err  = 1'b0;
    assign rx_timestamp_prty_edma = 6'd0;
    assign tx_timestamp_prty_edma = 6'd0;
  end
  ////////////////////////////////////////////////

end else begin : gen_no_tsu
  assign tsu_timer_cmp_val      = 1'b0;
  assign tsu_timer_cnt          = {94{1'b0}};
  assign tsu_timer_cnt_par      = {12{1'b0}};
  assign timer_strobe           = 1'b0;
  assign tsu_sec_incr           = 1'b0;
  assign asf_dap_mac_rx_ts_err  = 1'b0;
  assign asf_dap_mac_tx_ts_err  = 1'b0;
  assign asf_integrity_tsu_err  = 1'b0;
  assign rx_timestamp_prty_edma = 6'd0;
  assign tx_timestamp_prty_edma = 6'd0;
end
endgenerate


endmodule
