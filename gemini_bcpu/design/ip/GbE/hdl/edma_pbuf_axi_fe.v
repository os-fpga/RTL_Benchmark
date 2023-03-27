//------------------------------------------------------------------------------
// Copyright (c) 2006-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_axi_fe.v
//   Module Name:        edma_pbuf_axi_fe
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
//   Description       :      AXI front end driver
//
//------------------------------------------------------------------------------


module edma_pbuf_axi_fe # (

  parameter p_edma_lso        = 1'b0,
  parameter p_edma_rsc        = 1'b0,
  parameter p_num_queues      = 32'd1,
  parameter p_num_queues_m1   = p_num_queues - 32'd1,

  // The following parameter defines the number of bits used to describe
  // the depth of the FIFO that is needed to keep track of the number
  // of aw or ar accesses being triggered before the accompanying data
  // busses
  //
  parameter p_axi_access_pipeline_bits  = 4'd2,
  parameter p_axi_access_pipeline_depth = 2**p_axi_access_pipeline_bits,

  parameter p_axi_tx_descr_rd_buff_bits  = 4'd2,
  parameter p_axi_tx_descr_rd_buff_depth = 2**p_axi_tx_descr_rd_buff_bits,

  parameter p_axi_rx_descr_rd_buff_bits  = 4'd2,
  parameter p_axi_rx_descr_rd_buff_depth = 2**p_axi_rx_descr_rd_buff_bits,

  parameter p_axi_tx_descr_wr_buff_bits  = 4'd2,
  parameter p_axi_tx_descr_wr_buff_depth = 2**p_axi_tx_descr_wr_buff_bits,

  parameter p_axi_rx_descr_wr_buff_bits  = 4'd2,
  parameter p_axi_rx_descr_wr_buff_depth = 2**p_axi_rx_descr_wr_buff_bits,

  parameter p_edma_addr_width   = 32'd64,
  parameter p_edma_addr_pwid    = p_edma_addr_width/8,
  parameter p_edma_bus_width    = 32'd64,
  parameter p_edma_bus_pwid     = p_edma_bus_width/8,
  parameter p_edma_tx_pbuf_addr = 32'd64,
  parameter p_edma_tx_pbuf_data = 32'd64,
  parameter p_edma_rx_pbuf_addr = 32'd64,
  parameter p_edma_rx_pbuf_data = 32'd64,

  parameter p_edma_axi_arcache_value  = 4'd0,
  parameter p_edma_axi_awcache_value  = 4'd0,
  parameter p_edma_axi_prot_value     = 3'd0,

  // RAS - parameter for TX datapath protection
  parameter p_edma_asf_dap_prot       = 1'b0,
  parameter p_edma_asf_integrity_prot = 1'b0,

  parameter p_edma_tsu                = 1'b1
) (

  // Constaints
  input  [(p_edma_tx_pbuf_addr*p_num_queues)-1:0] TX_PBUF_MAX_FILL_LVL,

  input                                 aclk,
  input                                 n_areset,

  output      [3:0]                     arid,
  output reg  [p_edma_addr_width-1:0]   araddr,
  output reg  [p_edma_addr_pwid-1:0]    araddr_par,
  output      [1:0]                     arburst,
  output reg  [7:0]                     arlen,
  output reg  [2:0]                     arsize,
  output      [3:0]                     arcache,
  output      [2:0]                     arprot,
  output      [1:0]                     arlock,
  output reg  [3:0]                     arqos,
  output reg                            arvalid,
  input                                 arready,

  input       [1:0]                     rresp,
  input       [p_edma_bus_width-1:0]    rdata,
  input       [p_edma_bus_pwid-1:0]     rdata_par,
  input                                 rlast,
  input                                 rvalid,
  output reg                            rready,

  output      [3:0]                     awid,
  output      [p_edma_addr_width-1:0]   awaddr,
  output      [p_edma_addr_pwid-1:0]    awaddr_par,
  output      [1:0]                     awburst,
  output      [7:0]                     awlen,
  output reg  [2:0]                     awsize,
  output      [3:0]                     awcache,
  output      [2:0]                     awprot,
  output      [1:0]                     awlock,
  output reg  [3:0]                     awqos,
  output reg                            awvalid,
  input                                 awready,

  output      [p_edma_bus_width-1:0]    wdata,
  output      [p_edma_bus_pwid-1:0]     wdata_par,
  output      [p_edma_bus_pwid-1:0]     wstrb,
  output reg                            wlast,
  output                                wvalid,
  input                                 wready,

  input       [1:0]                     bresp,
  input                                 bvalid,
  output                                bready,

  // AHB RX interfaces
  // 00 - descriptor
  // 02 - data
  // common response signals
  output                         hgrant_00,  //hgrant for master 00
  input  [2:0]                   hburst_00,  //hburst for master 00
  input  [1:0]                   htrans_00,  //htrans for master 00
  input  [2:0]                   hsize_00,   //hsize for master 00
  input                          hwrite_00,  //hwrite for master 00
  input  [p_edma_addr_width-1:0] haddr_00,   //haddr for master 00
  input  [p_edma_addr_pwid-1:0]  haddr_00_par,
  input  [p_edma_bus_width-1:0]  hwdata_00,  //hwdata for master 00 (RX descriptor)
  input  [p_edma_bus_pwid-1:0]   hwdata_00_par,

  input                          hbusreq_02,  //hbusreq for master 02
  output                         hgrant_02,   //hgrant for master 02
  input  [2:0]                   hburst_02,   //hburst for master 02
  input  [1:0]                   htrans_02,   //htrans for master 02
  input  [2:0]                   hsize_02,    //hsize for master 02
  input                          hwrite_02,   //hwrite for master 02
  input  [p_edma_addr_width-1:0] haddr_02,    //haddr for master 02
  input  [p_edma_addr_pwid-1:0]  haddr_02_par,
  input  [p_edma_bus_width-1:0]  hwdata_02,   //hwdata for master 02
  input  [p_edma_bus_pwid-1:0]   hwdata_02_par,

  output [p_edma_bus_width-1:0]  hrdata_rx,
  output [p_edma_bus_pwid-1:0]   hrdata_rx_par,
  output [1:0]                   hresp_rx,
  output                         hready_rx,

   output                        cur_descr_rd_valid,  // Next descriptor is available
   input                         cur_descr_rd_rdy,    // This module can consume the descriptor
   output  [96:0]                cur_descr_rd,        // The actual descriptor
   output  [12:0]                cur_descr_rd_par,    // Parity
   output  [31:0]                cur_descr_rd_add,    // The memory address where the descriptor is located
   output   [3:0]                cur_descr_rd_add_par,// Parity for the writeback address
   output   [3:0]                cur_descr_rd_queue,  // The queue the traffic belongs to
   output                        buff_stripe_vld,     // Packet data is available
   input                         buff_stripe_rdy,     // This module can consume the data
   output                        buff_stripe_last,    // This is the last stripe of the packet
   output [127:0]                buff_stripe,         // the actual data
   output  [15:0]                buff_stripe_par,


  // Dedicated interface for TX descriptor writebacks
  // AHB 01 is for discriptor reads only
  input                          tx_descr_wr_vld,
  output                         tx_descr_wr_rdy,
  input  [63:0]                  tx_descr_wr_data,
  input  [7:0]                   tx_descr_wr_data_par,
  input  [41:0]                  tx_descr_wr_ts,            // TX timestamp
  input  [5:0]                   tx_descr_wr_ts_par,        // RAS -TS - parity protection for tx_descr_wr_data_ts
  input  [9:0]                   tx_descr_wr_sts,
  output [9:0]                   reflected_tx_sts,
  output                         reflected_tx_sts_vld,

  //---------------------------------------------
  // Common config
  //---------------------------------------------
  input  [1:0]                           dma_bus_width,
  input  [1:0]                           endian_swap,
  input  [4:0]                           burst_length,
  input  [31:0]                          upper_tx_q_base_addr,
  input  [3:0]                           upper_tx_q_base_par,
  input  [31:0]                          upper_rx_q_base_addr,
  input  [3:0]                           upper_rx_q_base_par,
  input                                  dma_addr_bus_width,
  input                                  use_aw2b_fill,
  input  [7:0]                           max_num_axi_ar2r,
  input  [7:0]                           max_num_axi_aw2w,
  input  [p_num_queues-1:0]              rx_disable_queue,
  input  [p_num_queues-1:0]              tx_disable_queue,
  input  [p_num_queues*8-1:0]            axi_qos_q_mapping,

  //---------------------------------------------
  // TX
  //---------------------------------------------
  input                                          enable_tx,
  input                                          trigger_dma_tx_start,
  input                                          tx_start_pulse,
  input                                          tx_stop_pulse,
  input                                          new_tx_q_ptr_pulse,      // New queue pointer written
  input  [(32*p_num_queues)-1:0]                 tx_buff_base_addr,       // tx descriptor list base addresses (list per queue)
  input  [(4*p_num_queues)-1:0]                  tx_buff_base_par,
  input                                          dma_has_seen_err,
  input                                          force_max_ahb_burst_tx,
  input                                          tx_cutthru,
  input                                          tx_extended_bd_mode_en,  // enable extended BD mode, which is used to Descriptor TS insertion
  input  [p_num_queues-1:0]                      buffer_full_q,
  input  [(p_num_queues-1)*8+7:0]                num_pkts_in_buf,
  input  [(p_edma_tx_pbuf_addr*p_num_queues)-1:0] dpram_fill_lvl,
  input [p_edma_tx_pbuf_addr-1:0]                 axi_tx_full_adj_0,
  input [p_edma_tx_pbuf_addr-1:0]                 axi_tx_full_adj_1,
  output         disable_tx,          // identifies a major error




  //---------------------------------------------
  // RX
  //---------------------------------------------
  input  [(32*p_num_queues)-1:0]                 rx_buff_base_addr,
  input  [(4*p_num_queues)-1:0]                  rx_buff_base_par,
  input                                          last_data_to_buff_dph,
  input  [13:0]                                  full_pkt_size,
  input                                          enable_rx,
  input                                          rx_descr_ptr_reset,
  input                                          from_rx_dma_used_bit_read,
  input  [3:0]                                   from_rx_dma_queue_ptr,
  input  [(32*p_num_queues)-1:0]                 from_rx_dma_descr_ptr,
  input  [(4*p_num_queues)-1:0]                  from_rx_dma_descr_ptr_par,
  input  [11:0]                                  from_rx_dma_buff_depth,
  input                                          rx_stat_capt_pulse,      // dma_rx status has been captured
  input                                          force_max_ahb_burst_rx,
  input                                          rx_cutthru,
  input                                          rx_extended_bd_mode_en,  // enable extended BD mode, which is used to Descriptor TS insertion
  input                                          new_descr_fetch_trig,
  input                                          part_pkt_written,
  input  [3:0]                                   queue_ptr_rx_aph,    // Identifies queue (AHB address phase timed)
  input  [3:0]                                   queue_ptr_rx_dph,    // Identifies which (AHB data phase timed)
  input  [3:0]                                   queue_ptr_rx_mod,    // Identifies which (AHB address phase timed + 1 cycle with a delay when RSC updates are happening)

   // outputs going to registers block (pclk) for interrupt generation
  output                                      rx_dma_stable_tog,   //
  output                                      rx_dma_buff_not_rdy, // used buffer descriptor read
  output                                      rx_dma_complete_ok,  // good frame is successfully stored
  output                                      rx_dma_resource_err, // no buffers available for storage
  output [3:0]                                rx_dma_int_queue,    // Identifies which queue the interupt is destined
  output  reg                                 axi_xaction_out,

  input   [p_edma_addr_width-1:0]             next_buffer_start_add,
  input   [p_edma_addr_pwid-1:0]              next_buffer_start_add_par,
  input                                       host_update_buf_add,
  input                                       rsc_coalescing_ended,
  input    [15:0]                             rsc_write_strobe,

  // Memory Update interface
  input                                       rsc_update_valid,
  output                                      rsc_update_ready,
  input                                       rsc_update_last,
  input                                       rsc_update_descr,
  input  [p_edma_addr_width-1:0]              rsc_update_addr,
  input  [p_edma_addr_pwid-1:0]               rsc_update_addr_par,
  input  [31:0]                               rsc_update_data,
  input  [3:0]                                rsc_update_data_par,
  input  [15:0]                               rsc_update_ben,

  output                                      disable_rx,           // identifies a major error
  output                                      axi_tx_frame_too_large,

  output [(p_num_queues*32)-1:0]              axi_tx_dma_descr_ptr,
  output                                      axi_tx_dma_descr_ptr_tog,

  // ASF - signals going to gem_reg_top
  output                                      asf_dap_axi_tx_err,
  output                                      asf_dap_axi_rx_err,
  output                                      asf_dap_axi_err,
  output                                      asf_integrity_err,

  // Lockup detection
  output [p_num_queues-1:0]                   full_pkt_inc,
  output [p_num_queues-1:0]                   used_bit_vec,
  output                                      lockup_flush

  );


  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  // INTERNAL SIGNALS
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------


  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  // TX
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  // TX descriptor read signal declarations
  wire          arvalid_tx_descr;
  wire          arready_tx_descr;
  wire  [63:0]  araddr_tx_descr;
  wire  [7:0]   araddr_tx_descr_par;
  wire  [7:0]   arlen_tx_descr;
  wire  [2:0]   arsize_tx_descr;

  wire          rvalid_tx_descr;
  wire          rready_tx_descr;


  // TX data read signal declarations
  wire          arvalid_tx_data;
  wire          arready_tx_data;
  wire  [63:0]  araddr_tx_data;
  wire  [7:0]   araddr_tx_data_par;
  wire  [7:0]   arlen_tx_data;
  wire  [2:0]   arsize_tx_data;

  wire          rvalid_tx_data;
  wire          rready_tx_data;

  // Shift araddr_tx_data based on dma_bus_width
  reg   [p_edma_addr_width-1:0] araddr_tx_data_s;
  wire  [p_edma_addr_pwid-1:0]  araddr_tx_data_s_par;

  // TX descriptor write signal declarations
  wire          awvalid_tx_descr;
  wire          awready_tx_descr;
  wire  [63:0]  awaddr_tx_descr;
  wire   [7:0]  awaddr_tx_descr_par;
  wire   [7:0]  awlen_tx_descr;
  wire   [2:0]  awsize_tx_descr;

  wire          wvalid_tx_descr;
  wire          wready_tx_descr;
  wire [127:0]  wdata_tx_descr;
  wire  [15:0]  wdata_tx_descr_par;
  wire          wlast_tx_descr;

  wire          ar_ahb_less_beats;
  wire          ar_first_req_of_buf;
  wire          ar_tcp_hdr;
  wire          ar_udp_hdr;

  wire          r_ahb_less_beats;
  wire          r_first_burst_of_buf;
  wire          r_tcp_hdr;
  wire          r_udp_hdr;

  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  // RX
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  wire   [2:0]                  hburst_rx;  //hburst for master rx
  wire   [2:0]                  hsize_rx;   //hsize for master rx
  wire   [p_edma_addr_width-1:0] haddr_rx;   //haddr for master rx
  wire   [p_edma_addr_pwid-1:0]  haddr_rx_par;

  // RX descriptor write signal declarations ...
  wire  [31:0]                  rx_descr_wr_fifo_add_out;
  wire  [3:0]                   rx_descr_wr_fifo_add_par_out;
  wire  [1:0]                   rx_descr_wr_pop_state;

  // Arithmetic operations to subtract 4, 8, 12, 16, 20 from rx_descr_wr_fifo_add_out.
  // Top 4-bits is parity.
  wire  [35:0]                  rx_descr_wr_fifo_add_out_m4;
  wire  [35:0]                  rx_descr_wr_fifo_add_out_m8;
  wire  [35:0]                  rx_descr_wr_fifo_add_out_m12;
  wire  [35:0]                  rx_descr_wr_fifo_add_out_m16;
  wire  [35:0]                  rx_descr_wr_fifo_add_out_m20;

  // RX descriptor read signal declarations
  wire                          rx_descr_rd_req;
  wire  [7:0]                   rx_descr_len;
  wire  [63:0]                  rx_descr_addr;
  wire  [7:0]                   rx_descr_addr_par;
  wire  [2:0]                   rx_descr_size;


  // RX descriptor write signal declarations
  wire                          rx_descr_wr_fifo_dat_pop;
  wire  [127:0]                 rx_descr_wr_data;
  wire  [15:0]                  rx_descr_wr_data_par;
  wire  [8:0]                   rx_data_len;
  wire  [p_edma_addr_width-1:0] rx_data_addr;
  wire  [p_edma_addr_pwid-1:0]  rx_data_addr_par;

  wire                          rx_data_wr_req;
  wire                          rx_descr_wr_req;
  wire                          last_data_to_buff;

  wire  [127:0]                 hwdata_02_pad;  // Pad to avoid lint issues
  wire  [15:0]                  hwdata_02_par_pad;

  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  // Common
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------

  reg           [3:0] araddr_byte;

  wire          ar_req_tx_descr;
  wire          ar_req_tx_data;
  wire          ar_req_rx;
  reg           ar_grant_tx_descr;
  reg           ar_grant_tx_data;
  reg           ar_grant_rx;
  reg           ar_grant_tx_descr_hold;
  reg           ar_grant_tx_data_hold;
  reg           ar_grant_rx_hold;
  reg           ar_pending;


  wire          aw_req_tx;
  reg           aw_grant_tx;
  reg   [2:0]   aw_grant_rx;
  reg           aw_grant_tx_hold;
  reg   [2:0]   aw_grant_rx_hold;
  reg           aw_pending;

  reg   [3:0]   aw_wstrb;


  reg   [15:0]  wstrb_128;
  reg  [127:0]  wdata_128;
  reg   [15:0]  wdata_128_par;

  wire          addressing_64b;
  wire          r_is_tx;
  wire          r_is_descr;
  wire  [3:0]   r_num_pad;
  wire          ar_last_req_of_buf;
  wire          r_last_burst_of_buf;
  wire          ar2r_pipeline_full;
  wire          w_is_tx;
  wire          w_is_rsc_update;
  wire  [3:0]   w_num_pad;
  wire  [3:0]   w_wstrb;
  wire  [7:0]   w_len;
  wire          w_is_pad;
  wire          w_is_descr;
  wire          aw_last_burst_of_buf;
  reg   [7:0]   w_access_cnt;
  wire          aw2w_pipeline_full;
  wire          aw2b_full;
  wire          w_last_burst_of_buf;
  wire          b_is_tx;
  wire          b_is_descr;
  wire          w2b_pipeline_full;
  wire  [p_axi_access_pipeline_bits:0]     aw2w_pipeline_fill;
  wire  [p_axi_access_pipeline_bits:0]     ar2r_pipeline_fill;
  wire  [6:0]                              w2b_pipeline_din;
  wire  [p_axi_access_pipeline_bits:0]     w2b_pipeline_fill;


  reg [8:0]   awlen_p;      // Padded signals to avoid lint warnings due to params
  reg [64:0]  awaddr_p;
  reg [8:0]   awaddr_par_p;


//---------------------------------------------
  reg   [5:0]   aw_rx_beats_rem_vld_r;
  wire  [4:0]   aw_rx_beats_rem_vld;
  wire  [12:0]  num_tx_beats_remaining;
  wire  [11:0]  num_rx_beats_remaining;
  wire  [p_num_queues-1:0]            rx_descr_rd_req_issued;

  wire  [1:0]                         rx_descr_wr_cnt;
  reg                                 flush_rx_wr_fifos;
  reg                                 flush_tx_wr_fifos;
  reg                                 flush_rx_rd_fifos;
  reg                                 flush_tx_rd_fifos;
  reg                                 enable_rx_d1;
  reg                                 enable_tx_d1;
  wire  [3:0]                         r_araddr;
  wire  [3:0]                         ar_queue_rx;
  wire  [3:0]                         ar_queue_tx_descr;
  wire  [3:0]                         ar_queue_tx_data;
  wire  [3:0]                         aw_queue_tx_descr;
  reg   [3:0]                         ar_queue;
  wire  [3:0]                         r_queue;
  wire                                rx_eof_written;
  wire                                aw_is_tx_descr;
  wire                                aw_is_rx_descr;

  wire  [3:0]                         rx_descr_add_wr_queue;
  wire  [3:0]                         rx_descr_wr_queue;
  wire  [3:0]                         rx_rsc_wr_queue;
  wire                                b_is_last;
  wire  [3:0]                         b_rx_queue;
  reg                                 waiting_rsc_ready;
  wire                                rsc_update_valid_int;
  wire                                rsc_update_last_int;
  wire                                rsc_update_descr_int;
  wire  [p_edma_addr_width-1:0]       rsc_update_addr_int;
  wire  [p_edma_addr_pwid-1:0]        rsc_update_addr_par_int;
  wire  [127:0]                       rsc_update_data_int;
  wire  [15:0]                        rsc_update_data_par_int;
  wire  [15:0]                        rsc_update_ben_int;

  wire                                bvalid_tx_descr;
  wire                                bready_tx_descr;
  wire                                aw_is_rx_rsc;
  wire                                aw_is_rx_data;
  wire                                valid_end_swap;
  wire                                w2b_pipeline_push;
  wire                                w2b_pipeline_pop;

  wire                                asf_integrity_ar2r_fifo_err;
  wire                                asf_integrity_aw2w_fifo_err;
  wire                                asf_integrity_w2b_fifo_err;

  reg  [3:0]                          awqos_rx_descr;
  reg  [3:0]                          awqos_rx_data;
  reg  [3:0]                          awqos_rx_rsc;
  reg  [3:0]                          awqos_tx_descr;
  reg  [3:0]                          arqos_rx_descr;
  reg  [3:0]                          arqos_tx_descr;
  reg  [3:0]                          arqos_tx_data;

  localparam RX_DESCR_WR_WORD1 = 2'b01;


  assign addressing_64b = dma_addr_bus_width;

  // We will always be able to accept the write response
  assign bready       = 1'b1;

  // Bursts will always be INCR
  assign arburst      = 2'b01;
  assign awburst      = 2'b01;

  // Same ID used for all accesses
  assign  awid        = 4'h0;
  assign  arid        = 4'h0;

  // The GEM doesnt lock any accesses when in PBUF mode,
  // so just tie off a*lock
  assign arlock       = 2'b00;
  assign awlock       = 2'b00;

  // Tie off cache signals
  assign arcache      = p_edma_axi_arcache_value;
  assign awcache      = p_edma_axi_awcache_value;

  // Tie off prot signals
  assign arprot       = p_edma_axi_prot_value;
  assign awprot       = p_edma_axi_prot_value;

  // AR arbitration
  // Priority is RX > TX Data > TX descriptor
  assign ar_req_rx       = rx_descr_rd_req  && ~ar2r_pipeline_full;
  assign ar_req_tx_data  = arvalid_tx_data  && ~ar2r_pipeline_full;
  assign ar_req_tx_descr = arvalid_tx_descr && ~ar2r_pipeline_full;

  always @ *
  begin
    if (~ar_pending)
    begin
      if (ar_req_rx)
      begin
        ar_grant_rx       = 1'b1;
        ar_grant_tx_data  = 1'b0;
        ar_grant_tx_descr = 1'b0;
      end
      else
        if (ar_req_tx_data)
        begin
          ar_grant_rx       = 1'b0;
          ar_grant_tx_data  = 1'b1;
          ar_grant_tx_descr = 1'b0;
        end
        else
          if (ar_req_tx_descr)
          begin
            ar_grant_rx       = 1'b0;
            ar_grant_tx_data  = 1'b0;
            ar_grant_tx_descr = 1'b1;
          end
          else
          begin
            ar_grant_rx       = 1'b0;
            ar_grant_tx_data  = 1'b0;
            ar_grant_tx_descr = 1'b0;
          end
    end
    else
    begin
      ar_grant_rx       = ar_grant_rx_hold;
      ar_grant_tx_data  = ar_grant_tx_data_hold;
      ar_grant_tx_descr = ar_grant_tx_descr_hold;
    end
  end

  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      ar_pending <= 1'b0;
    else
      if (arvalid && ~arready)
        ar_pending <= 1'b1;
      else
        if (arready)
          ar_pending <= 1'b0;
  end

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      ar_grant_rx_hold        <= 1'b0;
      ar_grant_tx_data_hold   <= 1'b0;
      ar_grant_tx_descr_hold  <= 1'b0;
    end
    else
    begin
      if (ar_grant_rx && ~arready)
        ar_grant_rx_hold <= 1'b1;
      else
        if (arready)
          ar_grant_rx_hold <= 1'b0;

      if (ar_grant_tx_data && ~arready)
        ar_grant_tx_data_hold <= 1'b1;
      else
        if (arready)
          ar_grant_tx_data_hold <= 1'b0;

      if (ar_grant_tx_descr && ~arready)
        ar_grant_tx_descr_hold <= 1'b1;
      else
        if (arready)
          ar_grant_tx_descr_hold <= 1'b0;
    end
  end


  // AW arbitration
  // Priority is TX > RX
  // RX arbitrates between data and descriptor internally

  assign aw_req_tx = awvalid_tx_descr && ~aw2w_pipeline_full;

  always @ *
  begin
    if (~aw_pending)
    begin
      if (aw_req_tx)
      begin
        aw_grant_rx = 3'b000;
        aw_grant_tx = 1'b1;
      end
      else
      begin
        aw_grant_tx = 1'b0;
        if (rx_descr_wr_req && ~aw2w_pipeline_full)
          aw_grant_rx = 3'b100;
        else if (rsc_update_valid_int && ~waiting_rsc_ready && ~aw2w_pipeline_full)
          aw_grant_rx = 3'b010;
        else if (rx_data_wr_req  && ~aw2w_pipeline_full)
          aw_grant_rx = 3'b001;
        else
          aw_grant_rx = 3'b000;
      end
    end
    else
    begin
      aw_grant_rx = aw_grant_rx_hold;
      aw_grant_tx = aw_grant_tx_hold;
    end
  end

  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      aw_pending <= 1'b0;
    else
      if (awvalid && ~awready)
        aw_pending <= 1'b1;
      else
        if (awready)
          aw_pending <= 1'b0;
  end

    // Monitor when it is safe to drive the AW request line
    // there are 3 sources for the RX, rx descriptor wr, rx data wr, and rsc wr
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      aw_grant_rx_hold <= 3'b000;
      aw_grant_tx_hold <= 1'b0;
    end
    else
    begin
      if (|aw_grant_rx && ~awready)
        aw_grant_rx_hold <= aw_grant_rx;
      else
        if (awready)
          aw_grant_rx_hold <= 3'b000;

      if (aw_grant_tx && ~awready)
        aw_grant_tx_hold <= 1'b1;
      else
        if (awready)
          aw_grant_tx_hold <= 1'b0;
    end
  end

  reg [7:0]                   awlen_hold;
  reg   [p_edma_addr_width-1:0] awaddr_hold;
  wire  [p_edma_addr_pwid-1:0]  awaddr_hold_par;
  reg [2:0]                   awsize_hold;
  reg                         awvalid_hold;
  reg  [3:0]                  awqos_hold;
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      awvalid_hold  <= 1'b0;
      awaddr_hold   <= {p_edma_addr_width{1'b0}};
      awsize_hold   <= 3'b000;
      awlen_hold    <= 8'h00;
      awqos_hold    <= 4'h0;
    end
    else
    begin
      if (awvalid & ~(|aw_grant_rx_hold))
      begin
        awvalid_hold  <= awvalid;
        awaddr_hold   <= awaddr;
        awsize_hold   <= awsize;
        awlen_hold    <= awlen;
        awqos_hold    <= awqos;
      end
    end
  end

  // Optionally pipeline the awaddr_par if parity protection enabled
  generate if (p_edma_asf_dap_prot == 1) begin : gen_awaddr_hold_par
    reg   [p_edma_addr_pwid-1:0]  awaddr_hold_par_r;
    always@(posedge aclk or negedge n_areset)
    begin
      if (~n_areset)
        awaddr_hold_par_r <= {p_edma_addr_pwid{1'b0}};
      else
        if (awvalid & ~(|aw_grant_rx_hold))
          awaddr_hold_par_r <= awaddr_par;
    end
    assign awaddr_hold_par  = awaddr_hold_par_r;
  end else begin : gen_no_awaddr_hold_par
    assign awaddr_hold_par  = {p_edma_addr_pwid{1'b0}};
  end
  endgenerate

  // Drive the AR channel
  // araddr_byte is used to identify first data byte on incoming tx data
  always @ *
  begin
    if (ar_grant_tx_data)
    begin
      arvalid         = 1'b1;
      araddr_byte     = araddr_tx_data[3:0];
      araddr          = araddr_tx_data_s[p_edma_addr_width-1:0];
      araddr_par      = araddr_tx_data_s_par[p_edma_addr_pwid-1:0];
      arsize          = arsize_tx_data;
      arlen           = arlen_tx_data;
      arqos           = arqos_tx_data;
      ar_queue        = ar_queue_tx_data;
    end
    else
      if (ar_grant_tx_descr)
      begin
        arvalid         = 1'b1;
        araddr_byte     = araddr_tx_descr[3:0];
        araddr          = araddr_tx_descr[p_edma_addr_width-1:0];
        araddr_par      = araddr_tx_descr_par[p_edma_addr_pwid-1:0];
        arsize          = arsize_tx_descr;
        arlen           = arlen_tx_descr;
        arqos           = arqos_tx_descr;
        ar_queue        = ar_queue_tx_descr;
      end
      else // RX or no requestor
      begin
        arvalid         = ar_grant_rx;
        araddr_byte     = rx_descr_addr[3:0];
        araddr          = rx_descr_addr[p_edma_addr_width-1:0];
        araddr_par      = rx_descr_addr_par[p_edma_addr_pwid-1:0];
        arsize          = rx_descr_size;
        arlen           = rx_descr_len;
        arqos           = arqos_rx_descr;
        ar_queue        = ar_queue_rx;
      end
  end

  // araddr_tx_data_s is based on araddr_tx_data and dma_bus_width
  always@(*)
  begin
    case (dma_bus_width)
      2'b00   : araddr_tx_data_s = {araddr_tx_data[p_edma_addr_width-1:2], 2'd0};
      2'b01   : araddr_tx_data_s = {araddr_tx_data[p_edma_addr_width-1:3], 3'd0};
      default : araddr_tx_data_s = {araddr_tx_data[p_edma_addr_width-1:4], 4'd0};
    endcase
  end

  // Optionally regenerate parity
  generate if (p_edma_asf_dap_prot == 1) begin : gen_araddr_tx_data_s_par
    gem_par_chk_regen #(.p_chk_dwid(64), .p_new_dwid(p_edma_addr_width)) i_regen_par (
      .odd_par  (1'b0),
      .chk_dat  (araddr_tx_data),
      .chk_par  (araddr_tx_data_par),
      .new_dat  (araddr_tx_data_s),
      .dat_out  (),
      .par_out  (araddr_tx_data_s_par),
      .chk_err  ()
    );
  end else begin : gen_no_araddr_tx_data_s_par
    assign araddr_tx_data_s_par = {p_edma_addr_pwid{1'b0}};
  end
  endgenerate


  // Validate ARREADY with ARVALID and ARGRANT so underlying
  // blocks do not have to replicate arbitration logic or monitor
  // ar2r FIFO fill level
  assign arready_tx_descr = ar_grant_tx_descr && arready;
  assign arready_tx_data  = ar_grant_tx_data  && arready;

  // Validate RVALID with TX/RX and descriptopr/data flags so underlying
  // blocks do not have to monitor ar2r FIFO output
  assign rvalid_tx_descr = |ar2r_pipeline_fill && r_is_tx && r_is_descr && rvalid;
  assign rvalid_tx_data  = |ar2r_pipeline_fill && r_is_tx && ~r_is_descr && rvalid;

  // Select RREADY from appropriate source depending on source of
  // corresponding AR request
  always @ *
  begin
    if (|ar2r_pipeline_fill && r_is_tx && r_is_descr && ~flush_tx_rd_fifos)
      rready = rready_tx_descr;
    else
      if (|ar2r_pipeline_fill && r_is_tx && ~r_is_descr && ~flush_tx_rd_fifos)
        rready = rready_tx_data;
      else
        rready = 1'b1;
  end

  // Validate AWREADY with AWGRANT and fifo status so underlying
  // blocks do not have to replicate arbitration logic or monitor
  // aw2w FIFO fill level
  assign awready_tx_descr = aw_grant_tx && awready;

  // Validate WVAILD and WREADY with TX/RX and descriptopr/data flags so underlying
  // blocks do not have to monitor aw2w FIFO output
  assign wvalid_tx_descr = wvalid && w_is_tx && w_is_descr;
  assign wready_tx_descr = wready && w_is_tx && w_is_descr;

  // Validate BVAILD and BREADY with TX/RX and descriptopr/data flags so underlying
  // blocks do not have to monitor aw2b FIFO output
  assign bvalid_tx_descr = bvalid && b_is_tx && b_is_descr;
  assign bready_tx_descr = bready && b_is_tx && b_is_descr;

  // Drive the AW channel

  // Set TX descriptor writes to be top priority,
  // followed by RX descriptor writes, RX RSC writes, and then finally RX data writes
  assign aw_is_tx_descr = awvalid_tx_descr && aw_grant_tx;
  assign aw_is_rx_descr = aw_grant_rx[2];
  assign aw_is_rx_rsc   = aw_grant_rx[1];
  assign aw_is_rx_data  = aw_grant_rx[0];

  // Arithmetic operation on rx_descr_wr_fifo_add_out is separated out for parity
  // protection and regeneration.
  // The following operations are required:
  //  -4
  //  -8
  //  -12
  //  -16
  //  -20
  edma_arith_par #(
    .p_dwidth (32),
    .p_pwidth (4),
    .p_has_par(p_edma_asf_dap_prot)
  ) i_arith_rx_descr_wr_addr[4:0] (
    .in_val (rx_descr_wr_fifo_add_out),
    .in_par (rx_descr_wr_fifo_add_par_out),
    .op_val ({32'd20,32'd16,32'd12,32'd8,32'd4}),
    .op_add (1'b0),
    .out_val({rx_descr_wr_fifo_add_out_m20[31:0],
              rx_descr_wr_fifo_add_out_m16[31:0],
              rx_descr_wr_fifo_add_out_m12[31:0],
              rx_descr_wr_fifo_add_out_m8[31:0],
              rx_descr_wr_fifo_add_out_m4[31:0]}),
    .out_par({rx_descr_wr_fifo_add_out_m20[35:32],
              rx_descr_wr_fifo_add_out_m16[35:32],
              rx_descr_wr_fifo_add_out_m12[35:32],
              rx_descr_wr_fifo_add_out_m8[35:32],
              rx_descr_wr_fifo_add_out_m4[35:32]})
  );

  integer    loop_1;
  integer    loop_2;
  always @(*)
  begin
    awqos_rx_descr = axi_qos_q_mapping[3:0];
    awqos_tx_descr = axi_qos_q_mapping[3:0];
    awqos_rx_data  = axi_qos_q_mapping[7:4];
    awqos_rx_rsc   = axi_qos_q_mapping[7:4];
    arqos_rx_descr = axi_qos_q_mapping[3:0];
    arqos_tx_descr = axi_qos_q_mapping[3:0];
    arqos_tx_data  = axi_qos_q_mapping[7:4];

    for (loop_1=0; loop_1 < p_num_queues[31:0]; loop_1 = loop_1 + 1)
    begin
      for (loop_2=0; loop_2 < 4; loop_2 = loop_2 + 1)
      begin
        if (loop_1[3:0] == rx_descr_add_wr_queue) awqos_rx_descr[loop_2]  = axi_qos_q_mapping[loop_1*8+4+loop_2];
        if (loop_1[3:0] == aw_queue_tx_descr)     awqos_tx_descr[loop_2]  = axi_qos_q_mapping[loop_1*8+4+loop_2];
        if (loop_1[3:0] == from_rx_dma_queue_ptr) awqos_rx_data[loop_2]   = axi_qos_q_mapping[loop_1*8+loop_2];
        if (loop_1[3:0] == rx_rsc_wr_queue)       awqos_rx_rsc[loop_2]    = axi_qos_q_mapping[loop_1*8+loop_2];

        if (loop_1[3:0] == ar_queue_rx)           arqos_rx_descr[loop_2]  = axi_qos_q_mapping[loop_1*8+4+loop_2];
        if (loop_1[3:0] == ar_queue_tx_descr)     arqos_tx_descr[loop_2]  = axi_qos_q_mapping[loop_1*8+4+loop_2];
        if (loop_1[3:0] == ar_queue_tx_data)      arqos_tx_data[loop_2]   = axi_qos_q_mapping[loop_1*8+loop_2];
      end
    end
  end

  always @ *
  begin
    if (aw_grant_tx)
    begin
      awvalid       = aw_is_tx_descr;
      awaddr_p      = {1'b0, awaddr_tx_descr};
      awaddr_par_p  = {1'b0,awaddr_tx_descr_par};
      awsize        = awsize_tx_descr;
      awlen_p       = {1'b0, awlen_tx_descr};
      awqos         = awqos_tx_descr;
    end
    else if (|aw_grant_rx_hold) // RX or no request
    begin
      awvalid       = awvalid_hold;
      awaddr_p      = {{(65-p_edma_addr_width){1'b0}},awaddr_hold};
      awaddr_par_p  = {{(9-p_edma_addr_pwid){1'b0}},awaddr_hold_par};
      awsize        = awsize_hold;
      awlen_p       = {1'b0,awlen_hold};
      awqos         = awqos_hold;
    end
    else
    begin
      if (aw_is_rx_descr)  // rx descriptor write
                           // WORD 0 and WORD 1 are the same for all modes
                           // subsequent words depend on operating mode
                           // e.g. TS may be written to either WORDS 2 and 3 or WORDS 4 and 5
      begin
        awvalid       = aw_grant_rx[2];
        awqos         = awqos_rx_descr;
        if (~rx_extended_bd_mode_en)
          if (rx_descr_wr_pop_state == RX_DESCR_WR_WORD1 & dma_bus_width == 2'b00)
          begin
            awaddr_p      = {1'b0, (upper_rx_q_base_addr & {32{addressing_64b}}),
                            rx_descr_wr_fifo_add_out_m4[31:0]}; // WORD 0
            awaddr_par_p  = {1'b0, (upper_rx_q_base_par & {4{addressing_64b}}),
                            rx_descr_wr_fifo_add_out_m4[35:32]};
          end
          else
          begin
            awaddr_p      = {1'b0, (upper_rx_q_base_addr & {32{addressing_64b}}),
                            rx_descr_wr_fifo_add_out};  // WORD 1
            awaddr_par_p  = {1'b0, (upper_rx_q_base_par & {4{addressing_64b}}),
                            rx_descr_wr_fifo_add_par_out[3:0]};
          end
        else
        begin
          if (dma_bus_width == 2'b00)  // 32-bit access
            case (rx_descr_wr_cnt)
              2'b00:
              begin
                awaddr_p      = {1'b0, (upper_rx_q_base_addr & {32{addressing_64b}}),
                                  rx_descr_wr_fifo_add_out};
                awaddr_par_p  = {1'b0, (upper_rx_q_base_par & {4{addressing_64b}}),
                                  rx_descr_wr_fifo_add_par_out[3:0]};
              end
              2'b01:
              begin
                awaddr_p      = {1'b0, (upper_rx_q_base_addr & {32{addressing_64b}}),
                                  rx_descr_wr_fifo_add_out_m4[31:0]};
                awaddr_par_p  = {1'b0, (upper_rx_q_base_par & {4{addressing_64b}}),
                                rx_descr_wr_fifo_add_out_m4[35:32]};
              end
              2'b10:
                if (addressing_64b)
                begin
                  awaddr_p      = {1'b0, upper_rx_q_base_addr, rx_descr_wr_fifo_add_out_m16[31:0]};
                  awaddr_par_p  = {1'b0, upper_rx_q_base_par, rx_descr_wr_fifo_add_out_m16[35:32]};
                end
                else
                begin
                  awaddr_p      = {33'h000000000, rx_descr_wr_fifo_add_out_m8[31:0]};
                  awaddr_par_p  = {5'h00, rx_descr_wr_fifo_add_out_m8[35:32]};
                end
              default:
                if (addressing_64b)
                begin
                  awaddr_p      = {1'b0, upper_rx_q_base_addr, rx_descr_wr_fifo_add_out_m20[31:0]};
                  awaddr_par_p  = {1'b0, upper_rx_q_base_par, rx_descr_wr_fifo_add_out_m20[35:32]};
                end
                else
                begin
                  awaddr_p      = {33'h000000000, rx_descr_wr_fifo_add_out_m12[31:0]};
                  awaddr_par_p  = {5'h00, rx_descr_wr_fifo_add_out_m12[35:32]};
                end
            endcase
          else  // 128-bit and 64-bit access
            if (rx_descr_wr_cnt == 2'b00)
            begin
              awaddr_p      = {1'b0, (upper_rx_q_base_addr & {32{addressing_64b}}),
                                rx_descr_wr_fifo_add_out};
              awaddr_par_p  = {1'b0, (upper_rx_q_base_par & {4{addressing_64b}}),
                                rx_descr_wr_fifo_add_par_out[3:0]};
            end
            else
              if (addressing_64b)
              begin
                awaddr_p      = {1'b0, upper_rx_q_base_addr, rx_descr_wr_fifo_add_out_m16[31:0]};
                awaddr_par_p  = {1'b0, upper_rx_q_base_par, rx_descr_wr_fifo_add_out_m16[35:32]};
              end
              else
              begin
                awaddr_p      = {33'h000000000, rx_descr_wr_fifo_add_out_m8[31:0]};
                awaddr_par_p  = {5'h00, rx_descr_wr_fifo_add_out_m8[35:32]};
              end
        end

        if (dma_bus_width == 2'b00)
          awsize  = 3'h2;  //  32-bit access
        else
          awsize  = 3'h3;  // 64-bit access

        awlen_p = 9'h000;
      end

      else if (aw_is_rx_data | p_edma_rsc == 0)
      begin // rx data write
        awqos = awqos_rx_data;
        if (rx_cutthru)
        begin
          awvalid     = aw_grant_rx[0] & aw_is_rx_data;
          if (~addressing_64b)// must be 32b addressing so set upper 32 address bits to 0
          begin
            awaddr_p      = {{33{1'b0}}, haddr_rx[31:0]};
            awaddr_par_p  = {5'd0, haddr_rx_par[3:0]};
          end
          else
          begin
            awaddr_p      = {{(65-p_edma_addr_width){1'b0}}, haddr_rx};
            awaddr_par_p  = {{(9-p_edma_addr_pwid){1'b0}}, haddr_rx_par};
          end
          awsize      = hsize_rx;
          awlen_p[1:0]  = {2{hburst_rx[0] & |hburst_rx[2:1]}};
          awlen_p[2]    = hburst_rx[2];
          awlen_p[3]    = hburst_rx[1] & hburst_rx[2];
          awlen_p[8:4]  = 5'h00;
        end
        else
        begin
          awvalid       = aw_grant_rx[0] & aw_is_rx_data;
          if (~addressing_64b)// must be 32b addressing so set upper 32 address bits to 0
          begin
            awaddr_p      = {{33{1'b0}},rx_data_addr[31:0]};
            awaddr_par_p  = {5'd0, rx_data_addr_par[3:0]};
          end
          else
          begin
            awaddr_p      = {{(65-p_edma_addr_width){1'b0}},rx_data_addr};
            awaddr_par_p  = {{(9-p_edma_addr_pwid){1'b0}}, rx_data_addr_par};
          end
          awsize        = 2'h2 + dma_bus_width;
          awlen_p       = rx_data_len - 9'h001;
        end
      end

      else if (p_edma_rsc == 1) // Update interface
      begin
        awvalid     = aw_grant_rx[1] & rsc_update_valid_int & ~waiting_rsc_ready;
        awqos       = awqos_rx_rsc;
        if (~addressing_64b)// must be 32b addressing so set upper 32 address bits to 0
        begin
          awaddr_p      = {{33{1'b0}},rsc_update_addr_int[31:0]};
          awaddr_par_p  = {5'd0, rsc_update_addr_par_int[3:0]};
        end
        else
        begin
          awaddr_p      = {{(65-p_edma_addr_width){1'b0}}, rsc_update_addr_int};
          awaddr_par_p  = {{(9-p_edma_addr_pwid){1'b0}}, rsc_update_addr_par_int};
        end
        if (rsc_update_descr_int)
          awsize  = 3'h2;  //  32-bit access only for descriptor updates
        else
        casex (dma_bus_width)
          2'b00:  awsize  = 3'h2;  //  32-bit access
          2'b01:  awsize  = 3'h3;  //  64-bit access
          default:awsize  = 3'h4;  // 128-bit access
        endcase
        awlen_p  = 9'h000;
      end

      else
      begin
        awvalid       = 1'b0;
        awqos         = 4'h0;
        awlen_p       = 9'h000;
        awsize        = 3'h2;
        awaddr_p      = {65{1'b0}};
        awaddr_par_p  = {9{1'b0}};
      end

    end
  end
  assign awlen      = awlen_p[7:0];
  assign awaddr     = awaddr_p[p_edma_addr_width-1:0];
  assign awaddr_par = awaddr_par_p[p_edma_addr_pwid-1:0];

  // The RSC Update interface sets rsc_update_valid until the rsc_update_ready
  // is returned. That wont be until the data is issued.  We need a signal
  // that identifies the gap between valid and ready, to ensure we dont keep
  // driving awvalid
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      waiting_rsc_ready  <= 1'b0;
    else
    begin
      if (p_edma_rsc == 0)
        waiting_rsc_ready  <= 1'b0;
      else if (rsc_update_valid_int & awvalid & ~aw_is_rx_data & ~aw_is_rx_descr & aw_grant_rx[1] & awready)
        waiting_rsc_ready  <= 1'b1;
      else if (wvalid & wready & w_is_rsc_update)
        waiting_rsc_ready  <= 1'b0;
    end
  end

  // aw_strb is used to eventually drive wstrb
  // have 1 bit for each byte.
  assign valid_end_swap = (((aw_is_rx_descr | aw_is_tx_descr) & endian_swap[0]) |
                           ~(aw_is_rx_descr | aw_is_tx_descr) & endian_swap[1]);
  always @ *
  begin
    if (dma_bus_width == 2'b00)
      aw_wstrb = 4'h1;
    else
      if (dma_bus_width == 2'b01)
      begin
        if (awsize == 3'h2) // 32 bit xfer in 64 bit bus
          aw_wstrb = {2'b00,({awaddr[2],~awaddr[2]} ^ {2{valid_end_swap}})};
        else
          aw_wstrb = 4'h3;
      end
      else  // 128bit bus
      begin
        if (awsize == 3'h2) // 32 bit xfer in 128 bit bus
          aw_wstrb = {awaddr[3:2] == {2{~valid_end_swap}},
                      awaddr[3:2] == {~valid_end_swap,valid_end_swap},
                      awaddr[3:2] == {valid_end_swap,~valid_end_swap},
                      awaddr[3:2] == {2{valid_end_swap}}};
        else
        if (awsize == 3'h3)
        begin
          aw_wstrb = {{2{awaddr[3]}},{2{~awaddr[3]}}} ^ {4{valid_end_swap}};
        end
        else
        // we need to mask bytes 4 to 7 if this is a TX descriptor write
        // as we dont have the address to send
        begin
          if (aw_is_tx_descr & aw_grant_tx & ~addressing_64b & tx_extended_bd_mode_en)
            aw_wstrb = valid_end_swap ? 4'b0111 : 4'b1110;
          else
            aw_wstrb = 4'hf;
        end
      end
  end


  // Implement the AW and AR FIFOs
  // we need this to track the AR channel to the R response
  // and the AW channel to the B
  // We need this to direct the responses to the appropriate
  // AHB ports
  localparam p_ar2r_fifo_dw  = 19;
  localparam p_ar2r_fifo_pw  = 3;
  localparam p_ar2r_fifo_w   = (p_edma_asf_integrity_prot == 1)  ? p_ar2r_fifo_dw + p_ar2r_fifo_pw
                                                                : p_ar2r_fifo_dw;
  wire  [p_ar2r_fifo_dw-1:0]  ar2r_in_tmp, ar2r_out_tmp;
  wire  [p_ar2r_fifo_w-1:0]   ar2r_fifo_in, ar2r_fifo_out;

  assign ar2r_in_tmp = {ar_ahb_less_beats,
                        ar_first_req_of_buf,
                        ar_tcp_hdr,
                        ar_udp_hdr,
                        ar_queue,
                        araddr_byte,
                        num_tx_beats_remaining[3:0],
                        ar_last_req_of_buf,
                        (ar_grant_tx_descr | ar_grant_rx),
                        (ar_grant_tx_descr | ar_grant_tx_data)};

  assign {r_ahb_less_beats,
          r_first_burst_of_buf,
          r_tcp_hdr,
          r_udp_hdr,
          r_queue,
          r_araddr,
          r_num_pad,
          r_last_burst_of_buf,
          r_is_descr,
          r_is_tx}          = ar2r_out_tmp;

  // Parity protection for integrity check of FIFO
  generate if (p_edma_asf_integrity_prot == 1) begin : gen_par_ar2r_fifo
    wire  [p_ar2r_fifo_pw-1:0]  ar2r_in_par_tmp, ar2r_out_par_tmp;

    // Generate parity
    cdnsdru_asf_parity_gen_v1 #(
      .p_data_width (p_ar2r_fifo_dw)
    ) i_par_gen (
      .odd_par    (1'b0),
      .data_in    (ar2r_in_tmp),
      .data_out   (),
      .parity_out (ar2r_in_par_tmp)
    );

    assign ar2r_fifo_in     = {ar2r_in_par_tmp, ar2r_in_tmp};
    assign {ar2r_out_par_tmp,
            ar2r_out_tmp}   = ar2r_fifo_out;

    // Parity check of outputs
    cdnsdru_asf_parity_check_v1 #(
      .p_data_width (p_ar2r_fifo_dw)
    ) i_par_chk (
      .odd_par    (1'b0),
      .data_in    (ar2r_out_tmp),
      .parity_in  (ar2r_out_par_tmp),
      .parity_err (asf_integrity_ar2r_fifo_err)
    );

  end else begin : gen_no_par_ar2r_fifo
    assign ar2r_fifo_in     = ar2r_in_tmp;
    assign ar2r_out_tmp     = ar2r_fifo_out;
    assign asf_integrity_ar2r_fifo_err  = 1'b0;
  end
  endgenerate

  edma_gen_fifo #( .FIFO_WIDTH      (p_ar2r_fifo_w),
                   .FIFO_DEPTH      (p_axi_access_pipeline_depth),
                   .FIFO_ADDR_WIDTH (p_axi_access_pipeline_bits)
                 ) i_ar_to_r_pipeline_fifo (

    .qout       (ar2r_fifo_out),
    .qempty     (),
    .qfull      (),
    .qlevel     (ar2r_pipeline_fill),
    .clk_pcie   (aclk),
    .rst_n      (n_areset),

    .din        (ar2r_fifo_in),
    .push       (arvalid & arready),
    .flush      (1'b0),
    .pop        (rvalid & rready & rlast)
  );

  assign ar2r_pipeline_full = ar2r_pipeline_fill == p_axi_access_pipeline_depth[p_axi_access_pipeline_bits:0] |
                              ar2r_pipeline_fill == max_num_axi_ar2r[p_axi_access_pipeline_bits:0];

  // aw_last_burst_of_buf and num_rx_beats_remaining are only valid for 1 clock cycle.
  // if awready is not high on this cycle, then it wont be written into
  // this FIFO below properly.  Need to regenerate signals that will remain valid
  // until awready is high ..

  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      aw_rx_beats_rem_vld_r <= 6'h00;
    else if (awready)
      aw_rx_beats_rem_vld_r <= 6'h00;
    else if (awvalid & !aw_rx_beats_rem_vld_r[5])
      aw_rx_beats_rem_vld_r <= {1'b1,aw_last_burst_of_buf,num_rx_beats_remaining[3:0]};
  end

  assign aw_rx_beats_rem_vld = aw_rx_beats_rem_vld_r[5] ? aw_rx_beats_rem_vld_r[4:0]
                                                        : {aw_last_burst_of_buf,num_rx_beats_remaining[3:0]};


  localparam p_aw2w_fifo_dw  = 20;
  localparam p_aw2w_fifo_pw  = 3;
  localparam p_aw2w_fifo_w   = (p_edma_asf_integrity_prot == 1)  ? p_aw2w_fifo_dw + p_aw2w_fifo_pw
                                                                : p_aw2w_fifo_dw;
  wire  [p_aw2w_fifo_dw-1:0]  aw2w_in_tmp, aw2w_out_tmp;
  wire  [p_aw2w_fifo_w-1:0]   aw2w_fifo_in, aw2w_fifo_out;

  assign aw2w_in_tmp  = {(aw_is_rx_rsc & aw_grant_rx[1]),
                         aw_rx_beats_rem_vld[3:0],
                         aw_rx_beats_rem_vld[4],
                         aw_wstrb,
                         awlen,
                         ((aw_is_rx_descr & aw_grant_rx[2]) | (aw_is_tx_descr & aw_grant_tx)),
                         aw_grant_tx};
  assign {w_is_rsc_update,
          w_num_pad,
          w_last_burst_of_buf,
          w_wstrb,
          w_len,
          w_is_descr,
          w_is_tx}    = aw2w_out_tmp;


  // Parity protection for integrity check of FIFO
  generate if (p_edma_asf_integrity_prot == 1) begin : gen_par_aw2w_fifo
    wire  [p_aw2w_fifo_pw-1:0]  aw2w_in_par_tmp, aw2w_out_par_tmp;

    // Generate parity
    cdnsdru_asf_parity_gen_v1 #(
      .p_data_width (p_aw2w_fifo_dw)
    ) i_par_gen (
      .odd_par    (1'b0),
      .data_in    (aw2w_in_tmp),
      .data_out   (),
      .parity_out (aw2w_in_par_tmp)
    );

    assign aw2w_fifo_in     = {aw2w_in_par_tmp, aw2w_in_tmp};
    assign {aw2w_out_par_tmp,
            aw2w_out_tmp}   = aw2w_fifo_out;

    // Parity check of outputs
    cdnsdru_asf_parity_check_v1 #(
      .p_data_width (p_aw2w_fifo_dw)
    ) i_par_chk (
      .odd_par    (1'b0),
      .data_in    (aw2w_out_tmp),
      .parity_in  (aw2w_out_par_tmp),
      .parity_err (asf_integrity_aw2w_fifo_err)
    );

  end else begin : gen_no_par_aw2w_fifo
    assign aw2w_fifo_in = aw2w_in_tmp;
    assign aw2w_out_tmp = aw2w_fifo_out;
    assign asf_integrity_aw2w_fifo_err  = 1'b0;
  end
  endgenerate

  edma_gen_fifo #( .FIFO_WIDTH(p_aw2w_fifo_w),
                   .FIFO_DEPTH(p_axi_access_pipeline_depth),
                   .FIFO_ADDR_WIDTH(p_axi_access_pipeline_bits)
                 ) i_aw_to_w_pipeline_fifo (

    .qout       (aw2w_fifo_out),
    .qempty     (),
    .qfull      (),
    .qlevel     (aw2w_pipeline_fill),
    .clk_pcie   (aclk),
    .rst_n      (n_areset),

    .din        (aw2w_fifo_in),
    .push       (awvalid & awready),
    .flush      (1'b0),
    .pop        (wvalid & wready & wlast)
  );

  assign aw2w_pipeline_full     = use_aw2b_fill ? aw2b_full :
                                  aw2w_pipeline_fill >= (p_axi_access_pipeline_depth[p_axi_access_pipeline_bits:0]) |
                                  aw2w_pipeline_fill >= (max_num_axi_aw2w[p_axi_access_pipeline_bits:0]) ;

  // Not using AXI ID's - everything sequential
  assign w2b_pipeline_push      = (wvalid & wready & wlast);
  assign w2b_pipeline_pop       = (bvalid & bready);
  assign w2b_pipeline_din[1:0]  = {(w_is_descr | (w_is_rsc_update & rsc_update_descr_int & p_edma_rsc == 1)),w_is_tx};

  // Bit 2 is used to eventually set b_is_last, which is used for 2 purposes ...
  //  1. to understand when a descriptor writeback is possible (following the last data write to any buffer of a frame)
  //  2. To understand when the last descriptor writeback of a frame has been completed - in RSC, this is the very last one!
  assign w2b_pipeline_din[2]    = w_is_descr      ? rx_descr_wr_fifo_dat_pop & rx_eof_written  : // This is set on the last write of the last descriptor
                                  w_is_rsc_update ? rsc_update_descr_int & rsc_update_last_int  :
                                                    last_data_to_buff; // This is set on the last data to any buffer of a frame

  assign w2b_pipeline_din[6:3]  = w_is_rsc_update ? rx_rsc_wr_queue : rx_descr_wr_queue;

  localparam p_w2b_fifo_dw = 7;
  localparam p_w2b_fifo_pw = 1;
  localparam p_w2b_fifo_w  = (p_edma_asf_integrity_prot == 1)  ? p_w2b_fifo_dw + p_w2b_fifo_pw
                                                              : p_w2b_fifo_dw;
  wire  [p_w2b_fifo_dw-1:0] w2b_in_tmp, w2b_out_tmp;
  wire  [p_w2b_fifo_w-1:0]  w2b_fifo_in, w2b_fifo_out;

  assign w2b_in_tmp = w2b_pipeline_din;
  assign {b_rx_queue,
          b_is_last,
          b_is_descr,
          b_is_tx}  = w2b_out_tmp;

  // Parity protection for integrity check of FIFO
  generate if (p_edma_asf_integrity_prot == 1) begin : gen_par_w2b_fifo
    wire  [p_w2b_fifo_pw-1:0]  w2b_in_par_tmp, w2b_out_par_tmp;

    // Generate parity
    cdnsdru_asf_parity_gen_v1 #(
      .p_data_width (p_w2b_fifo_dw)
    ) i_par_gen (
      .odd_par    (1'b0),
      .data_in    (w2b_in_tmp),
      .data_out   (),
      .parity_out (w2b_in_par_tmp)
    );

    assign w2b_fifo_in     = {w2b_in_par_tmp, w2b_in_tmp};
    assign {w2b_out_par_tmp,
            w2b_out_tmp}   = w2b_fifo_out;

    // Parity check of outputs
    cdnsdru_asf_parity_check_v1 #(
      .p_data_width (p_w2b_fifo_dw)
    ) i_par_chk (
      .odd_par    (1'b0),
      .data_in    (w2b_out_tmp),
      .parity_in  (w2b_out_par_tmp),
      .parity_err (asf_integrity_w2b_fifo_err)
    );

  end else begin : gen_no_par_w2b_fifo
    assign w2b_fifo_in = w2b_in_tmp;
    assign w2b_out_tmp = w2b_fifo_out;
    assign asf_integrity_w2b_fifo_err  = 1'b0;
  end
  endgenerate

  edma_gen_fifo #( .FIFO_WIDTH(p_w2b_fifo_w),
                   .FIFO_DEPTH(p_axi_access_pipeline_depth),
                   .FIFO_ADDR_WIDTH(p_axi_access_pipeline_bits)
                 ) i_w_to_b_pipeline_fifo (

    .qout       (w2b_fifo_out),
    .qempty     (),
    .qfull      (w2b_pipeline_full),
    .qlevel     (w2b_pipeline_fill),
    .clk_pcie   (aclk),
    .rst_n      (n_areset),

    .din        (w2b_fifo_in),
    .push       (w2b_pipeline_push),
    .flush      (1'b0),
    .pop        (w2b_pipeline_pop)
  );

  // check issuing capability is correct
  reg    [p_axi_access_pipeline_bits:0] aw2b_fill;
  wire [p_axi_access_pipeline_bits+1:0] aw2b_fill_1;
  wire [p_axi_access_pipeline_bits+1:0] aw2b_fill_p_aw2b_fill_1;
  
  assign aw2b_fill_1        = {{p_axi_access_pipeline_bits+1{1'b0}},1'b1};
  assign aw2b_fill_p_aw2b_fill_1 = aw2b_fill + aw2b_fill_1[p_axi_access_pipeline_bits:0];
  
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      aw2b_fill  <= {p_axi_access_pipeline_bits+1{1'b0}};
    end
    else
    begin
      if (awvalid & awready)
      begin
        if (!(bvalid & bready))
          aw2b_fill <= aw2b_fill_p_aw2b_fill_1[p_axi_access_pipeline_bits:0];
      end
      else if (bvalid & bready)
        aw2b_fill  <= aw2b_fill - aw2b_fill_1[p_axi_access_pipeline_bits:0];
    end
  end
  assign aw2b_full = aw2b_fill >= (p_axi_access_pipeline_depth[p_axi_access_pipeline_bits:0]) |
                     aw2b_fill >= (max_num_axi_aw2w[p_axi_access_pipeline_bits:0]) ;


  // Drive the W channel
  // First count the number of write data and compare with length that was set in AWLEN
  // We need this to determine when to set wlast
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      w_access_cnt  <= 8'h00;
    end
    else
    begin
      if (wvalid & wready & wlast)
        w_access_cnt  <= 8'h00;
      else if (wvalid & wready)
        w_access_cnt  <= w_access_cnt + 8'h01;
    end
  end

  // Flush the W channel if something was requested just before the enable went low ...
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      flush_rx_rd_fifos  <= 1'b0;
      flush_tx_rd_fifos  <= 1'b0;
      flush_rx_wr_fifos  <= 1'b0;
      flush_tx_wr_fifos  <= 1'b0;
      enable_rx_d1       <= 1'b0;
      enable_tx_d1       <= 1'b0;
    end
    else
    begin
      enable_rx_d1    <= enable_rx;
      enable_tx_d1    <= enable_tx;

      if (~enable_tx & enable_tx_d1) // dropping enable
      begin
        flush_tx_rd_fifos <= 1'b1;
        flush_tx_wr_fifos <= 1'b1;
      end
      else
      begin
        if ((ar2r_pipeline_fill == {p_axi_access_pipeline_bits+1{1'b0}}) && ~arvalid_tx_descr && ~arvalid_tx_data)
          flush_tx_rd_fifos     <= 1'b0;

        if ((aw2w_pipeline_fill == {p_axi_access_pipeline_bits+1{1'b0}}) && ~awvalid_tx_descr &&
            (w2b_pipeline_fill  == {p_axi_access_pipeline_bits+1{1'b0}}) && ~wvalid)
          flush_tx_wr_fifos     <= 1'b0;
      end

      if (~enable_rx & enable_rx_d1)
      begin
        flush_rx_rd_fifos     <= 1'b1;
        flush_rx_wr_fifos     <= 1'b1;
      end
      else
      begin
        if (rx_descr_ptr_reset & rx_cutthru)
          flush_rx_rd_fifos     <= 1'b1;
        else if (~(|rx_descr_rd_req_issued))
          flush_rx_rd_fifos     <= 1'b0;
        if ((aw2w_pipeline_fill == {p_axi_access_pipeline_bits+1{1'b0}}) &
            (w2b_pipeline_fill  == {p_axi_access_pipeline_bits+1{1'b0}}))
          flush_rx_wr_fifos     <= 1'b0;
      end
    end
  end


  // Assert wvalid whenever the aw2w FIFO is not empty - this indicates that there is at least 1 data transfer
  // pending
  // Must also take fill level of w2b FIFO into account
  assign wvalid = |aw2w_pipeline_fill && ~w2b_pipeline_full;

  // For RSC xfers, we can set the ready back to the RSC module when the write data is pushed
  always @ *
  begin
    if (w_is_tx)  // tx bd write
    begin
      wlast             = wlast_tx_descr;
      wdata_128         = wdata_tx_descr;
      wdata_128_par     = wdata_tx_descr_par;
      wstrb_128         = {{4{w_wstrb[3]}},{4{w_wstrb[2]}},{4{w_wstrb[1]}},{4{w_wstrb[0]}}};
    end
    else
    begin
      if (w_is_descr)  // rx bd write
      begin
        wlast     = 1'b1;
        wstrb_128 = {{4{w_wstrb[3]}},{4{w_wstrb[2]}},{4{w_wstrb[1]}},{4{w_wstrb[0]}}};
        if (endian_swap[0])
        begin
          wdata_128         = {2{rx_descr_wr_data[7:0], rx_descr_wr_data[15:8], rx_descr_wr_data[23:16],  rx_descr_wr_data[31:24],
                                rx_descr_wr_data[39:32],rx_descr_wr_data[47:40],rx_descr_wr_data[55:48],  rx_descr_wr_data[63:56]}};
          wdata_128_par     = {2{rx_descr_wr_data_par[0], rx_descr_wr_data_par[1], rx_descr_wr_data_par[2], rx_descr_wr_data_par[3],
                                  rx_descr_wr_data_par[4], rx_descr_wr_data_par[5], rx_descr_wr_data_par[6], rx_descr_wr_data_par[7]}};
        end
        else
        begin
          wdata_128         = rx_descr_wr_data;
          wdata_128_par     = rx_descr_wr_data_par;
        end
      end
      else if (w_is_rsc_update & p_edma_rsc == 1)
      begin
        wstrb_128         = rsc_update_ben_int;
        wlast             = 1'b1;
        wdata_128         = rsc_update_data_int;
        wdata_128_par     = rsc_update_data_par_int;
      end
      else  // rx data bufer write
      begin
        wstrb_128 = p_edma_rsc == 1 ? rsc_write_strobe : {{4{w_wstrb[3]}},{4{w_wstrb[2]}},{4{w_wstrb[1]}},{4{w_wstrb[0]}}};
        wlast     = w_access_cnt == w_len;
        wdata_128         = hwdata_02_pad[127:0];
        wdata_128_par     = hwdata_02_par_pad[15:0];
      end
    end
  end
  assign wdata      = ~w_is_pad ? wdata_128[p_edma_bus_width-1:0]     : {p_edma_bus_width{1'b0}};
  assign wdata_par  = ~w_is_pad ? wdata_128_par[p_edma_bus_pwid-1:0]  : {p_edma_bus_pwid{1'b0}};
  assign wstrb      = wvalid    ? wstrb_128[p_edma_bus_pwid-1:0]      : {p_edma_bus_pwid{1'b0}};

  generate if (p_edma_bus_width < 32'd128) begin : gen_pad_hwdata_02
    assign hwdata_02_pad      = {{(128-p_edma_bus_width){1'b0}},hwdata_02};
    assign hwdata_02_par_pad  = {{(16-p_edma_bus_pwid){1'b0}},hwdata_02_par};
  end else begin : gen_no_pad_hwdata_02
    assign hwdata_02_pad      = hwdata_02;
    assign hwdata_02_par_pad  = hwdata_02_par;
  end
  endgenerate


 edma_pbuf_axi_fe_tx # (

  .p_edma_tsu                    (p_edma_tsu),
  .p_edma_lso                    (p_edma_lso),
  .p_num_queues                  (p_num_queues),
  .p_num_queues_m1               (p_num_queues_m1),

  .p_axi_access_pipeline_bits    (p_axi_access_pipeline_bits),
  .p_axi_access_pipeline_depth   (p_axi_access_pipeline_depth),

  .p_axi_tx_descr_rd_buff_bits   (p_axi_tx_descr_rd_buff_bits),
  .p_axi_tx_descr_rd_buff_depth  (p_axi_tx_descr_rd_buff_depth),

  .p_axi_tx_descr_wr_buff_bits   (p_axi_tx_descr_wr_buff_bits),
  .p_axi_tx_descr_wr_buff_depth  (p_axi_tx_descr_wr_buff_depth),

  .p_edma_tx_pbuf_addr           (p_edma_tx_pbuf_addr),
  .p_edma_bus_width              (p_edma_bus_width),
  .p_edma_bus_pwid               (p_edma_bus_pwid),
  .p_edma_addr_width             (p_edma_addr_width),
  .p_edma_tx_pbuf_data           (p_edma_tx_pbuf_data),

  // RAS - parameter for TX datapath protection
  .p_edma_asf_dap_prot           (p_edma_asf_dap_prot)

  ) i_edma_pbuf_axi_fe_tx (

  .TX_PBUF_MAX_FILL_LVL              (TX_PBUF_MAX_FILL_LVL),

  .aclk                              (aclk),
  .n_areset                          (n_areset),

  .cur_descr_rd_valid                (cur_descr_rd_valid),
  .cur_descr_rd_rdy                  (cur_descr_rd_rdy),
  .cur_descr_rd                      (cur_descr_rd),
  .cur_descr_rd_par                  (cur_descr_rd_par),
  .cur_descr_rd_add                  (cur_descr_rd_add),
  .cur_descr_rd_add_par              (cur_descr_rd_add_par),
  .cur_descr_rd_queue                (cur_descr_rd_queue),
  .buff_stripe_vld                   (buff_stripe_vld),
  .buff_stripe_rdy                   (buff_stripe_rdy),
  .buff_stripe_last                  (buff_stripe_last),
  .buff_stripe                       (buff_stripe),
  .buff_stripe_par                   (buff_stripe_par),

  .tx_descr_wr_vld                   (tx_descr_wr_vld),
  .tx_descr_wr_rdy                   (tx_descr_wr_rdy),
  .tx_descr_wr_data                  (tx_descr_wr_data),
  .tx_descr_wr_data_par              (tx_descr_wr_data_par),
  .tx_descr_wr_ts                    (tx_descr_wr_ts),
  .tx_descr_wr_ts_par                (tx_descr_wr_ts_par),
  .tx_descr_wr_sts                   (tx_descr_wr_sts),
  .reflected_tx_sts                  (reflected_tx_sts),
  .reflected_tx_sts_vld              (reflected_tx_sts_vld),

  .new_tx_q_ptr_pulse                (new_tx_q_ptr_pulse),
  .enable_tx                         (enable_tx),
  .trigger_dma_tx_start              (trigger_dma_tx_start),
  .tx_start_pulse                    (tx_start_pulse),
  .tx_stop_pulse                     (tx_stop_pulse),
  .tx_buff_base_addr                 (tx_buff_base_addr),
  .tx_buff_base_par                  (tx_buff_base_par),
  .dma_has_seen_err                  (dma_has_seen_err),
  .force_max_ahb_burst_tx            (force_max_ahb_burst_tx),
  .tx_cutthru                        (tx_cutthru),
  .tx_extended_bd_mode_en            (tx_extended_bd_mode_en),
  .buffer_full_q                     (buffer_full_q),
  .num_pkts_in_buf                   (num_pkts_in_buf),
  .dpram_fill_lvl                    (dpram_fill_lvl),
  .axi_tx_full_adj_0                 (axi_tx_full_adj_0),
  .axi_tx_full_adj_1                 (axi_tx_full_adj_1),
  .tx_disable_queue                  (tx_disable_queue),

  .disable_tx                        (disable_tx),

  .dma_bus_width                     (dma_bus_width),
  .endian_swap                       (endian_swap),
  .burst_length                      (burst_length),
  .upper_tx_q_base_addr              (upper_tx_q_base_addr),
  .upper_tx_q_base_par               (upper_tx_q_base_par),

  .r_num_pad                         (r_num_pad),

  .arvalid_descr                     (arvalid_tx_descr),
  .arready_descr                     (arready_tx_descr),
  .arlen_descr                       (arlen_tx_descr),
  .araddr_descr                      (araddr_tx_descr),
  .araddr_descr_par                  (araddr_tx_descr_par),
  .arsize_descr                      (arsize_tx_descr),

  .arvalid_data                      (arvalid_tx_data),
  .arready_data                      (arready_tx_data),
  .arlen_data                        (arlen_tx_data),
  .araddr_data                       (araddr_tx_data),
  .araddr_data_par                   (araddr_tx_data_par),
  .arsize_data                       (arsize_tx_data),

  .rvalid_descr                      (rvalid_tx_descr),
  .rready_descr                      (rready_tx_descr),
  .rvalid_data                       (rvalid_tx_data),
  .rready_data                       (rready_tx_data),
  .rdata                             (rdata),
  .rdata_par                         (rdata_par),
  .rresp                             (rresp),
  .rlast                             (rlast),


  .awvalid_descr                     (awvalid_tx_descr),
  .awready_descr                     (awready_tx_descr),
  .awaddr_descr                      (awaddr_tx_descr),
  .awaddr_descr_par                  (awaddr_tx_descr_par),
  .awlen_descr                       (awlen_tx_descr),
  .awsize_descr                      (awsize_tx_descr),

  .wvalid_descr                      (wvalid_tx_descr),
  .wready_descr                      (wready_tx_descr),
  .wdata_descr                       (wdata_tx_descr),
  .wdata_descr_par                   (wdata_tx_descr_par),
  .wlast_descr                       (wlast_tx_descr),

  .bvalid_descr                      (bvalid_tx_descr),
  .bready_descr                      (bready_tx_descr),
  .bresp                             (bresp),

  .ar_last_req_of_buf                (ar_last_req_of_buf),
  .r_last_burst_of_buf               (r_last_burst_of_buf),

  .flush_tx_wr_fifos                 (flush_tx_wr_fifos),
  .flush_tx_rd_fifos                 (flush_tx_rd_fifos),

  .addressing_64b                    (addressing_64b),

  .r_araddr                          (r_araddr),
  .num_tx_beats_remaining            (num_tx_beats_remaining),

  .ar_ahb_less_beats                 (ar_ahb_less_beats),
  .ar_first_req_of_buf               (ar_first_req_of_buf),
  .ar_tcp_hdr                        (ar_tcp_hdr),
  .ar_udp_hdr                        (ar_udp_hdr),
  .ar_queue_descr                    (ar_queue_tx_descr),
  .ar_queue_data                     (ar_queue_tx_data),
  .aw_queue_descr                    (aw_queue_tx_descr),

  .r_ahb_less_beats                  (r_ahb_less_beats),
  .r_first_burst_of_buf              (r_first_burst_of_buf),
  .r_tcp_hdr                         (r_tcp_hdr),
  .r_udp_hdr                         (r_udp_hdr),
  .r_queue                           (r_queue),

  .axi_tx_dma_descr_ptr              (axi_tx_dma_descr_ptr),
  .axi_tx_dma_descr_ptr_tog          (axi_tx_dma_descr_ptr_tog),

  .frame_too_large                   (axi_tx_frame_too_large),

  // ASF - signals going to gem_reg_top
  .asf_dap_axi_tx_err                (asf_dap_axi_tx_err),

  // Lockup detection
  .full_pkt_inc                      (full_pkt_inc),
  .used_bit_vec                      (used_bit_vec),
  .lockup_flush                      (lockup_flush)

  );


  edma_pbuf_axi_fe_rx # (

  .p_num_queues                    (p_num_queues),
  .p_num_queues_m1                 (p_num_queues_m1),
  .p_edma_rsc                      (p_edma_rsc),

  .p_axi_rx_descr_rd_buff_bits     (p_axi_rx_descr_rd_buff_bits),
  .p_axi_rx_descr_rd_buff_depth    (p_axi_rx_descr_rd_buff_depth),

  .p_axi_rx_descr_wr_buff_bits     (p_axi_rx_descr_wr_buff_bits),
  .p_axi_rx_descr_wr_buff_depth    (p_axi_rx_descr_wr_buff_depth),

  .p_edma_rx_pbuf_addr             (p_edma_rx_pbuf_addr),
  .p_edma_bus_width                (p_edma_bus_width),
  .p_edma_addr_width               (p_edma_addr_width),
  .p_edma_rx_pbuf_data             (p_edma_rx_pbuf_data),

  // RAS - parameters
  .p_edma_asf_dap_prot             (p_edma_asf_dap_prot)

  ) i_edma_pbuf_axi_fe_rx (

  .aclk                             (aclk),
  .n_areset                         (n_areset),

  .hgrant_00                        (hgrant_00),
  .hburst_00                        (hburst_00),
  .htrans_00                        (htrans_00),
  .hsize_00                         (hsize_00),
  .hwrite_00                        (hwrite_00),
  .haddr_00                         (haddr_00),
  .haddr_00_par                     (haddr_00_par),
  .hwdata_00                        (hwdata_00),
  .hwdata_00_par                    (hwdata_00_par),

  .hbusreq_02                       (hbusreq_02),
  .hgrant_02                        (hgrant_02),
  .hburst_02                        (hburst_02),
  .htrans_02                        (htrans_02),
  .hsize_02                         (hsize_02),
  .hwrite_02                        (hwrite_02),
  .haddr_02                         (haddr_02),
  .haddr_02_par                     (haddr_02_par),

  .hrdata_rx                        (hrdata_rx),
  .hrdata_rx_par                    (hrdata_rx_par),
  .hresp_rx                         (hresp_rx),
  .hready_rx                        (hready_rx),

  .last_data_to_buff                (last_data_to_buff),
  .full_pkt_size                    (full_pkt_size),
  .enable_rx                        (enable_rx),
  .rx_descr_ptr_reset               (rx_descr_ptr_reset),
  .from_rx_dma_used_bit_read        (from_rx_dma_used_bit_read),
  .from_rx_dma_queue_ptr            (from_rx_dma_queue_ptr),
  .from_rx_dma_descr_ptr            (from_rx_dma_descr_ptr),
  .from_rx_dma_descr_ptr_par        (from_rx_dma_descr_ptr_par),
  .from_rx_dma_buff_depth           (from_rx_dma_buff_depth),
  .rx_buff_base_addr                (rx_buff_base_addr),
  .rx_buff_base_par                 (rx_buff_base_par),
  .rx_stat_capt_pulse               (rx_stat_capt_pulse),
  .force_max_ahb_burst_rx           (force_max_ahb_burst_rx),
  .rx_cutthru                       (rx_cutthru),
  .rx_extended_bd_mode_en           (rx_extended_bd_mode_en),
  .new_descr_fetch_trig             (new_descr_fetch_trig),
  .part_pkt_written                 (part_pkt_written),
  .queue_ptr_rx_aph                 (queue_ptr_rx_aph),
  .queue_ptr_rx_dph                 (queue_ptr_rx_dph),
  .queue_ptr_rx_mod                 (queue_ptr_rx_mod),

  .rx_dma_stable_tog                (rx_dma_stable_tog),
  .rx_dma_buff_not_rdy              (rx_dma_buff_not_rdy),
  .rx_dma_complete_ok               (rx_dma_complete_ok),
  .rx_dma_resource_err              (rx_dma_resource_err),
  .b_rx_queue                       (b_rx_queue),
  .rx_dma_int_queue                 (rx_dma_int_queue),
  .disable_rx                       (disable_rx),
  .rx_disable_queue                 (rx_disable_queue),

  .dma_bus_width                    (dma_bus_width),
  .endian_swap                      (endian_swap[0]),
  .burst_length                     (burst_length),
  .upper_rx_q_base_addr             (upper_rx_q_base_addr),
  .upper_rx_q_base_par              (upper_rx_q_base_par),
  .dma_addr_bus_width               (dma_addr_bus_width),


  .arvalid                          (arvalid),
  .arready                          (arready),
  .rvalid                           (rvalid),
  .rready                           (rready),
  .rdata                            (rdata),
  .rdata_par                        (rdata_par),
  .rresp                            (rresp),

  .awvalid                          (awvalid),
  .awready                          (awready),
  .wvalid                           (wvalid),
  .wready                           (wready),
  .wlast                            (wlast),
  .bresp                            (bresp),
  .bvalid                           (bvalid),
  .bready                           (bready),

  .rx_descr_add_wr_queue            (rx_descr_add_wr_queue),
  .rx_descr_wr_queue                (rx_descr_wr_queue),
  .rx_rsc_wr_queue                  (rx_rsc_wr_queue),

  .next_buffer_start_add            (next_buffer_start_add),
  .next_buffer_start_add_par        (next_buffer_start_add_par),
  .host_update_buf_add              (host_update_buf_add),
  .rsc_coalescing_ended             (rsc_coalescing_ended),

  // Memory Update interface
  .rsc_update_valid_i               (rsc_update_valid),
  .rsc_update_descr_i               (rsc_update_descr),
  .rsc_update_last_i                (rsc_update_last),
  .rsc_update_ready_o               (rsc_update_ready),
  .rsc_update_addr_i                (rsc_update_addr),
  .rsc_update_addr_par_i            (rsc_update_addr_par),
  .rsc_update_data_i                (rsc_update_data),
  .rsc_update_data_par_i            (rsc_update_data_par),
  .rsc_update_ben_i                 (rsc_update_ben),

  .rsc_update_valid_o               (rsc_update_valid_int),
  .rsc_update_last_o                (rsc_update_last_int),
  .rsc_update_descr_o               (rsc_update_descr_int),
  .rsc_update_addr_o                (rsc_update_addr_int),
  .rsc_update_addr_par_o            (rsc_update_addr_par_int),
  .rsc_update_data_o                (rsc_update_data_int),
  .rsc_update_data_par_o            (rsc_update_data_par_int),
  .rsc_update_ben_o                 (rsc_update_ben_int),

  .argrant                          (ar_grant_rx),
  .awgrant                          (aw_grant_rx),
  .awgrant_hold                     (aw_grant_rx_hold),

  .flush_rx_wr_fifos                (flush_rx_wr_fifos),
  .flush_rx_rd_fifos                (flush_rx_rd_fifos),
  .r_is_tx                          (r_is_tx),
  .r_is_descr                       (r_is_descr),
  .w_is_tx                          (w_is_tx),
  .w_num_pad                        (w_num_pad),
  .w_is_descr                       (w_is_descr),
  .w_is_rsc_update                  (w_is_rsc_update),
  .w_last_burst_of_buf              (w_last_burst_of_buf),
  .b_is_tx                          (b_is_tx),
  .b_is_descr                       (b_is_descr),
  .w2b_pipeline_full                (w2b_pipeline_full),
  .raddr_bit3                       (r_araddr[3]),
  .current_rx_queue_resp            (r_queue),
  .aw_is_rx_descr                   (aw_is_rx_descr),
  .aw_is_rx_data                    (aw_is_rx_data),
  .b_is_last                        (b_is_last),

  .rx_descr_wr_data                 (rx_descr_wr_data),
  .rx_descr_wr_data_par             (rx_descr_wr_data_par),
  .rx_descr_wr_req                  (rx_descr_wr_req),
  .rx_descr_rd_req_issued           (rx_descr_rd_req_issued),
  .rx_descr_wr_cnt                  (rx_descr_wr_cnt),
  .last_data_to_buff_dph            (last_data_to_buff_dph),
  .rx_eof_written                   (rx_eof_written),

  .hburst_rx                        (hburst_rx),
  .hsize_rx                         (hsize_rx),
  .haddr_rx                         (haddr_rx),
  .haddr_rx_par                     (haddr_rx_par),
  .rx_descr_wr_fifo_add_out         (rx_descr_wr_fifo_add_out),
  .rx_descr_wr_fifo_add_par_out     (rx_descr_wr_fifo_add_par_out),
  .rx_descr_len                     (rx_descr_len),
  .rx_descr_addr                    (rx_descr_addr),
  .rx_descr_addr_par                (rx_descr_addr_par),
  .rx_descr_size                    (rx_descr_size),
  .aw_last_burst_of_buf             (aw_last_burst_of_buf),

  .rx_descr_wr_pop_state            (rx_descr_wr_pop_state),
  .rx_descr_wr_fifo_dat_pop         (rx_descr_wr_fifo_dat_pop),
  .rx_data_addr                     (rx_data_addr),
  .rx_data_addr_par                 (rx_data_addr_par),
  .rx_data_wr_req                   (rx_data_wr_req),
  .rx_descr_rd_req                  (rx_descr_rd_req),
  .rx_data_len                      (rx_data_len),
  .w_is_pad                         (w_is_pad),
  .num_rx_beats_remaining           (num_rx_beats_remaining),
  .current_rx_queue_req             (ar_queue_rx),
  .asf_dap_axi_rx_err               (asf_dap_axi_rx_err)


  );

  // -----------------------------------------------------------------------------
  // ASF - End to end data path parity protection
  // -----------------------------------------------------------------------------
  generate if (p_edma_asf_dap_prot == 1) begin : gen_dp_parity
    wire  dap_wdata_err;
    wire  dap_araddr_err;
    wire  dap_awaddr_err;

    // Parity check for wdata passed outside the design.
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_edma_bus_width)) i_par_chk_wdata (
       .odd_par(1'b0),
       .data_in(wdata),
       .parity_in(wdata_par),
       .parity_err(dap_wdata_err)
    );
    // Parity check for araddr passed outside the design.
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_edma_addr_width)) i_par_chk_araddr (
       .odd_par(1'b0),
       .data_in(araddr),
       .parity_in(araddr_par),
       .parity_err(dap_araddr_err)
    );
    // Parity check for awaddr passed outside the design.
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_edma_addr_width)) i_par_chk_awaddr (
       .odd_par(1'b0),
       .data_in(awaddr),
       .parity_in(awaddr_par),
       .parity_err(dap_awaddr_err)
    );
    assign asf_dap_axi_err  = dap_wdata_err | dap_araddr_err | dap_awaddr_err;
  end else begin : gen_no_dp_parity
    assign asf_dap_axi_err  = 1'b0;
  end
  endgenerate

  // Register integrity error
  generate if (p_edma_asf_integrity_prot == 1) begin : gen_asf_integrity
    reg asf_integrity_err_r;
    always@(posedge aclk or negedge n_areset)
    begin
      if (~n_areset)
        asf_integrity_err_r <= 1'b0;
      else
        asf_integrity_err_r <= asf_integrity_ar2r_fifo_err  |
                                asf_integrity_aw2w_fifo_err |
                                asf_integrity_w2b_fifo_err;
    end
    assign asf_integrity_err  = asf_integrity_err_r;
  end else begin : gen_no_asf_integrity
    assign asf_integrity_err  = 1'b0;
  end
  endgenerate

  always@(posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      axi_xaction_out <= 1'b0;
    else
      axi_xaction_out <= |aw2b_fill | (|ar2r_pipeline_fill);
  end

endmodule //edma_pbuf_axi_fe
