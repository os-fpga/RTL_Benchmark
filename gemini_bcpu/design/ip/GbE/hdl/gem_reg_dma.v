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
//   Filename:           gem_reg_dma.v
//   Module Name:        gem_reg_dma
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
//   Description    : Contains DMA related registers
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_dma (
  pclk,                       // APB clock
  n_preset,                   // Active low reset
  i_paddr,                    // Full APB address
  psel,                       // APB select
  write_registers,            // write to apb registers.
  read_registers,             // read from apb registers.
  pwdata,                     // APB write data
  pwdata_par,                 // Parity associated with pwdata
  enable_receive,             // receive enable signal from NWC Reg
  tx_go_pclk,                 // tx_go from DMA resynced to pclk.
  network_config,             // Network config register
  gem_dma_addr_width_is_64b,  // Compiled and configured to 64-bits addr
  dpram_fill_lvl_pclk,        // Fill levels
  rx_dpram_fill_lvl_pad_pclk, // receive fill level
  tx_dma_descr_ptr,           // Descriptor queue pointer for debug
  rx_dma_descr_ptr,           // Descriptor queue pointer for debug
  rsc_clr,                    // Receive Side Coalescing clear
  rsc_en,                     // RSC enable
  tx_disable_q,               // Software disable of queues
  rx_disable_q,               // Software disable of queues
  new_receive_q_ptr,          // asserted when new receive queue pointer
  new_transmit_q_ptr,         // asserted when new tx queue pointer
  tx_dma_descr_base_addr,     // TX queue base addresses
  tx_dma_descr_base_par,      // Parity for base addresses
  rx_dma_descr_base_addr,     // RX queue base addresses
  rx_dma_descr_base_par,      // Parity for base addresses
  rx_dma_buffer_size,         // RX DMA buffer sizes
  rx_dma_buffer_offset,       // byte offset of receive buffer from
  ahb_burst_length,           // AHB burst length control
  dma_addr_bus_width,         // 64 or 32-bit select
  endian_swap,                // Endian swap enable
  restart_counter_top,        // RSC control
  max_num_axi_aw2w,           // AXI configuration
  max_num_axi_ar2r,
  use_aw2b_fill,
  axi_tx_full_adj_0,          // Debug adjustment registers
  axi_tx_full_adj_1,
  axi_tx_full_adj_2,
  axi_tx_full_adj_3,
  dma_addr_or_mask,           // OR mask used for data-buffers
  rx_pbuf_size,               // Programmed size of RX DPRAM
  rx_cutthru_threshold,       // Threshold value
  rx_cutthru,                 // Enable for cut-thru operation
  rx_fill_level_low,          // watermark for transmitting zero pause frame
  rx_fill_level_high,         // watermark for transmitting non-zero pause frame
  hdr_data_splitting_en,      // Header Data Splitting enable
  inf_last_dbuf_size_en,      // data buffer pointed to by last descriptor is infinite size
  crc_error_report,           // Jumbo Length Reporting
  force_discard_on_err,       // Force packets to be discarded from PBUF after AHB error
  force_max_ahb_burst_rx,     // Force AHB  to always burst at max
  rx_bd_extended_mode_en,     // Enable extended buffer descriptors
  rx_bd_ts_mode,              // Timestamping in buffer descriptors
  upper_rx_q_base_addr,       // upper 32b base address for rx buffer descriptors
  upper_rx_q_base_par,        // Parity
  tx_cutthru_threshold,       // Threshold value
  tx_cutthru,                 // Enable for cut-thru operation
  sel_dpram_fill_lvl_dbg,     // Debug select
  tx_pbuf_size,               // Programmed size of TX DPRAM
  tx_pbuf_tcp_en,             // TCP TX checksum offload enable
  force_max_ahb_burst_tx,     // Force AHB  to always burst at max
  tx_bd_extended_mode_en,     // Enable extended buffer descriptors
  tx_bd_ts_mode,              // Timestamping in buffer descriptors
  upper_tx_q_base_addr,       // upper 32b base address for tx buffer descriptors
  upper_tx_q_base_par,        // Parity
  tx_pbuf_segments,           // Segment allocations for TX
  axi_qos_q_mapping,
  prdata_dma,                 // APB read data combinatorial
  perr_dma,                   // Perr signal registered
  dma_par_err                 // Parity error of registers
);
  parameter [1363:0] grouped_params = {
    208'd0,
    32'd1, // p_edma_queue
    32'd64,// p_edma_tx_pbuf_data
    32'd64,// p_edma_rx_pbuf_data
    32'd10,// p_edma_tx_pbuf_addr
    32'd10,// p_edma_rx_pbuf_addr
    32'd1, // p_edma_tx_pbuf_queue_segment_size
    32'd64,// p_emac_bus_width
    32'd64,// p_edma_bus_width
    32'd32,// p_edma_addr_width
    868'd0
  };

  `include "ungroup_params.v"
  input               pclk;                   // APB clock
  input               n_preset;               // Active low reset
  input       [11:0]  i_paddr;                // Full APB address
  input               psel;                   // APB select
  input               write_registers;        // write to apb registers.
  input               read_registers;         // read from apb registers.
  input       [31:0]  pwdata;                 // APB write data
  input       [3:0]   pwdata_par;             // Parity associated with pwdata
  input               enable_receive;         // receive enable signal from NWC Reg
  input               tx_go_pclk;             // tx_go from DMA resynced to pclk.
  input       [31:0]  network_config;         // Network config register
  input               gem_dma_addr_width_is_64b;  // Compiled and configured to 64-bits addr
  input       [15:0]  dpram_fill_lvl_pclk;    // Fill levels
  input       [15:0]  rx_dpram_fill_lvl_pad_pclk; // receive fill level
  input       [(p_edma_queues*32)-1:0]
                      tx_dma_descr_ptr;       // Descriptor queue pointer for debug
  input       [(p_edma_queues*32)-1:0]
                      rx_dma_descr_ptr;       // Descriptor queue pointer for debug
  input       [p_edma_queues-1:0]
                      rsc_clr;                // Receive Side Coalescing clear
  output      [14:0]  rsc_en;                 // RSC enable
  output      [15:0]  tx_disable_q;           // Software disable of queues
  output      [15:0]  rx_disable_q;           // Software disable of queues
  output  reg         new_receive_q_ptr;      // asserted when receive queue pointer
                                              // is written.
  output  reg         new_transmit_q_ptr;     // asserted when tx queue pointer
                                              // is written.
  output      [(p_edma_queues*32)-1:0]
                      tx_dma_descr_base_addr; // Queue base addresses
  output      [(p_edma_queues*4)-1:0]
                      tx_dma_descr_base_par;  // Parity for base addresses
  output      [(p_edma_queues*32)-1:0]
                      rx_dma_descr_base_addr;
  output      [(p_edma_queues*4)-1:0]
                      rx_dma_descr_base_par;  // Parity for base addresses
  output      [(p_edma_queues*8)-1:0]
                      rx_dma_buffer_size;     // RX DMA buffer sizes
  output      [1:0]   rx_dma_buffer_offset;   // byte offset of receive buffer from
                                              // buffer descriptor pointer.
  output      [4:0]   ahb_burst_length;       // AHB burst length control
  output              dma_addr_bus_width;     // 64 or 32-bit select
  output      [1:0]   endian_swap;            // Endian swap enable
  output  reg [3:0]   restart_counter_top;
  output      [7:0]   max_num_axi_aw2w;
  output      [7:0]   max_num_axi_ar2r;
  output              use_aw2b_fill;
  output      [p_edma_tx_pbuf_addr-1:0]
                      axi_tx_full_adj_0;      // Debug adjustment registers
  output      [p_edma_tx_pbuf_addr-1:0]
                      axi_tx_full_adj_1;
  output      [p_edma_tx_pbuf_addr-1:0]
                      axi_tx_full_adj_2;
  output      [p_edma_tx_pbuf_addr-1:0]
                      axi_tx_full_adj_3;
  output      [8:0]   dma_addr_or_mask;       // OR mask used for data-buffers
  output      [1:0]   rx_pbuf_size;           // Programmed size of RX DPRAM
  output      [p_edma_rx_pbuf_addr-1:0]
                      rx_cutthru_threshold;   // Threshold value
  output              rx_cutthru;             // Enable for cut-thru operation
  output              rx_fill_level_low;      // watermark for transmitting zero pause frame
  output              rx_fill_level_high;     // watermark for transmitting non-zero pause frame
  output              hdr_data_splitting_en;  // Header Data Splitting enable
  output              inf_last_dbuf_size_en;  // data buffer pointed to by last descriptor is infinite size
  output              crc_error_report;       // Jumbo Length Reporting
  output              force_discard_on_err;   // Force packets to be discarded from
                                              // PBUF after AHB error
  output              force_max_ahb_burst_rx; // Force AHB  to always burst at max
  output              rx_bd_extended_mode_en;
  output      [1:0]   rx_bd_ts_mode;
  output      [31:0]  upper_rx_q_base_addr;   // upper 32b base address for rx buffer descriptors
  output      [3:0]   upper_rx_q_base_par;    // Parity
  output      [p_edma_tx_pbuf_addr-1:0]
                      tx_cutthru_threshold;   // Threshold value
  output              tx_cutthru;             // Enable for cut-thru operation
  output      [4:0]   sel_dpram_fill_lvl_dbg; // Debug select
  output              tx_pbuf_size;           // Programmed size of TX DPRAM
  output              tx_pbuf_tcp_en;         // TCP TX checksum offload enable
  output              force_max_ahb_burst_tx; // Force AHB  to always burst at max
  output              tx_bd_extended_mode_en;
  output      [1:0]   tx_bd_ts_mode;
  output      [31:0]  upper_tx_q_base_addr;   // upper 32b base address for tx buffer descriptors
  output      [3:0]   upper_tx_q_base_par;    // Parity
  output      [47:0]  tx_pbuf_segments;       // Segment allocations for TX
  output      [(8*p_edma_queues)-1:0]
                      axi_qos_q_mapping;
  output  reg [31:0]  prdata_dma;             // APB read data combinatorial
  output  reg         perr_dma;               // Perr signal registered
  output              dma_par_err;            // Parity error of registers


  // Internals
  wire  [31:0]  tx_base_addr_arr[15:0];     // Base address for all queues
  wire  [31:0]  rx_base_addr_arr[15:0];     // Base address for all queues
  wire  [7:0]   rx_dma_buf_sz_arr[15:0];    // Array of buff size for all queues
  wire          dma_addr_bus_width_1;       // from dma_config reg
  reg   [1:0]   dma_config_r_7_6;           // DMA configuration register
  reg   [4:0]   dma_config_r_4_0;           // DMA configuration register
  wire  [31:0]  dma_config;                 // Full register
  wire  [31:0]  dma_config_func;            // Masked read value
  wire          rsc_clr_mask;               // RSC control registers
  wire  [31:0]  axi_tx_full_thresh0;        // Register read value
  wire  [31:0]  axi_tx_full_thresh1;        // Register read value
  wire  [15:0]  dma_q_par_err;              // Parity error of queue registers
  wire          rsc_par_err;                // Parity error of RSC registers
  wire          axi_par_err;                // Parity error of AXI specific registers
  wire          pbuf_rx_par_err;            // Parity error of Pbuf RX registers
  wire          pbuf_tx_par_err;            // Parity error of Pbuf TX registers
  wire  [31:0]  rx_water_mark;              // receive water mark value for apb read back
  wire  [7:0]   axi_qos_q_mapping_arr[15:0];// Array of QoS mappings for all possible queues.

  generate
    genvar  loop_q;
    genvar  loop_nq;
    for (loop_q = 0; loop_q < p_edma_queues[31:0]; loop_q = loop_q + 1)
    begin : gen_dma_q
      wire  [11:0]  tx_qbase_addr;
      wire  [11:0]  rx_qbase_addr;
      wire  [11:0]  rx_buf_size_base_addr;
      wire  [7:0]   new_buf_val;
      reg   [31:0]  tx_q_ptr;
      reg   [31:0]  rx_q_ptr;
      reg   [7:0]   rx_buf_size;

      // Determine base addresses for this queue
      if (loop_q == 0) begin : gen_0
        assign tx_qbase_addr         = `gem_transmit_q_ptr;
        assign rx_qbase_addr         = `gem_receive_q_ptr;
        assign rx_buf_size_base_addr = `gem_dma_config;  // Special case
        assign new_buf_val           =  pwdata[23:16];
      end
      else if (loop_q < 8) begin : gen_1_7
        assign tx_qbase_addr         = `gem_transmit_q1_ptr   + {loop_q[9:0]-1,2'b00};
        assign rx_qbase_addr         = `gem_receive_q1_ptr    + {loop_q[9:0]-1,2'b00};
        assign rx_buf_size_base_addr = `gem_dma_rxbuf_size_q1 + {loop_q[9:0]-1,2'b00};
        assign new_buf_val           =  pwdata[7:0];
      end
      else begin : gen_8_15
        assign tx_qbase_addr         = `gem_transmit_q8_ptr   + {loop_q[9:0]-8,2'b00};
        assign rx_qbase_addr         = `gem_receive_q8_ptr    + {loop_q[9:0]-8,2'b00};
        assign rx_buf_size_base_addr = `gem_dma_rxbuf_size_q8 + {loop_q[9:0]-8,2'b00};
        assign new_buf_val           =  pwdata[7:0];
      end

      // Register writes
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          tx_q_ptr    <= 32'h00000000;
          rx_q_ptr    <= 32'h00000000;
          rx_buf_size <= p_edma_rx_buffer_length_def;
        end
        else if (write_registers)
        begin
          if ((i_paddr == tx_qbase_addr) & ~tx_go_pclk)
            tx_q_ptr    <= pwdata;
          if ((i_paddr == rx_qbase_addr) & ~enable_receive)
            rx_q_ptr    <= pwdata;
          if (i_paddr == rx_buf_size_base_addr)
            rx_buf_size <= new_buf_val;
        end
      end

      // Assign to array
      // Note that bit 1 is not used.
//      assign tx_base_addr_arr[loop_q] = tx_q_ptr & 32'hfffffffd;
//      assign rx_base_addr_arr[loop_q] = rx_q_ptr & 32'hfffffffd;

      // Register read value is based on what DMA tells us it is looking at...
      assign tx_base_addr_arr[loop_q] = {tx_dma_descr_ptr[(32*loop_q)+31:(32*loop_q)+2],
                                          1'b0,tx_q_ptr[0]};
      assign rx_base_addr_arr[loop_q] = {rx_dma_descr_ptr[(32*loop_q)+31:(32*loop_q)+2],
                                          1'b0,rx_q_ptr[0]};

      assign rx_dma_buf_sz_arr[loop_q]= rx_buf_size;

      // Assign outputs
      assign tx_disable_q[loop_q]     = tx_q_ptr[0];
      assign rx_disable_q[loop_q]     = rx_q_ptr[0];
      assign rx_dma_buffer_size[(loop_q*8)+7:(loop_q*8)] = rx_buf_size;

      // For base addresses to the DMA, bottom 2-bits are zero'd
      assign tx_dma_descr_base_addr[(loop_q*32)+31:(loop_q*32)] =
                                        tx_q_ptr & 32'hfffffffc;
      assign rx_dma_descr_base_addr[(loop_q*32)+31:(loop_q*32)] =
                                        rx_q_ptr & 32'hfffffffc;

      // Optional parity protection
      if ((p_edma_asf_csr_prot == 1) ||
          (p_edma_asf_dap_prot == 1)) begin : gen_par
        reg   [3:0] tx_q_ptr_par;
        reg   [3:0] rx_q_ptr_par;
        reg         rx_buf_size_par;

        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
          begin
            tx_q_ptr_par    <= 4'h0;
            rx_q_ptr_par    <= 4'h0;
            rx_buf_size_par <= ^p_edma_rx_buffer_length_def;
          end
          else if (write_registers)
          begin
            if ((i_paddr == tx_qbase_addr) & ~tx_go_pclk)
              tx_q_ptr_par    <= pwdata_par;
            if ((i_paddr == rx_qbase_addr) & ~enable_receive)
              rx_q_ptr_par    <= pwdata_par;
            if (i_paddr == rx_buf_size_base_addr)
              rx_buf_size_par <= (loop_q == 0)  ? pwdata_par[2] : pwdata_par[0];
          end
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(72)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    ({rx_buf_size,
                        rx_q_ptr,
                        tx_q_ptr}),
          .parity_in  ({rx_buf_size_par,
                        rx_q_ptr_par,
                        tx_q_ptr_par}),
          .parity_err (dma_q_par_err[loop_q])
        );

        // Assign parity outputs.
        // Note that the bottom parity bit is adjusted to account for the zeroing of the
        // bottom 2-bits of the address sent to the DMA.
        assign tx_dma_descr_base_par[(loop_q*4)+3:(loop_q*4)] = tx_q_ptr_par ^ {3'b000,^tx_q_ptr[1:0]};
        assign rx_dma_descr_base_par[(loop_q*4)+3:(loop_q*4)] = rx_q_ptr_par ^ {3'b000,^rx_q_ptr[1:0]};
      end else begin : gen_no_par
        assign dma_q_par_err[loop_q]  = 1'b0;
        assign tx_dma_descr_base_par[(loop_q*4)+3:(loop_q*4)] = 4'h0;
        assign rx_dma_descr_base_par[(loop_q*4)+3:(loop_q*4)] = 4'h0;
      end

    end
    // Fill in non-existant queues
    for (loop_nq = p_edma_queues; loop_nq < 31'd16; loop_nq = loop_nq + 1)
    begin : gen_dma_nq
      assign tx_base_addr_arr[loop_nq]  = 32'h00000000;
      assign rx_base_addr_arr[loop_nq]  = 32'h00000000;
      assign rx_dma_buf_sz_arr[loop_nq] = 8'h00;
      assign tx_disable_q[loop_nq]      = 1'b0;
      assign rx_disable_q[loop_nq]      = 1'b0;
      assign dma_q_par_err[loop_nq]     = 1'b0;
    end
  endgenerate

  // The new_receive_q_ptr and new_transmit_q_ptr toggles are updated when
  // queue 0 is written.
  // Also write other common DMA configuration register here
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
    begin
      new_transmit_q_ptr  <= 1'b0;
      new_receive_q_ptr   <= 1'b0;
      dma_config_r_7_6    <= p_edma_endian_swap_def;
      dma_config_r_4_0    <= 5'h04;
      restart_counter_top <= 4'h7;
    end
    else if (write_registers)
    begin
      if ((i_paddr == `gem_transmit_q_ptr) & ~tx_go_pclk)
        new_transmit_q_ptr  <= ~new_transmit_q_ptr;
      if ((i_paddr == `gem_receive_q_ptr) & ~enable_receive)
        new_receive_q_ptr   <= ~new_receive_q_ptr;
      if (i_paddr == `gem_dma_config)
      begin
        dma_config_r_7_6    <= pwdata[7:6];
        dma_config_r_4_0    <= pwdata[4:0];
      end
      if (i_paddr == `gem_wd_counter)
        restart_counter_top <= pwdata[3:0];
    end
  end

  generate if (p_edma_tx_pkt_buffer == 1) begin : gen_dma_config_31_24
    reg   [2:0]   dma_config_r_30_28;         // DMA configuration register
    reg   [2:0]   dma_config_r_26_24;         // DMA configuration register
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
      begin
        dma_config_r_30_28  <= 3'h0;
        dma_config_r_26_24  <= 3'h0;
      end
      else if (write_registers)
      begin
        if (i_paddr == `gem_dma_config)
        begin
          dma_config_r_30_28  <= pwdata[30:28];
          dma_config_r_26_24  <= pwdata[26:24];
        end
      end
    end
    assign dma_config[30:28]  = dma_config_r_30_28;
    assign dma_config[26:24]  = dma_config_r_26_24;

    if (p_edma_asf_csr_prot == 1) begin : gen_par
      reg           dma_config_r_31;            // DMA configuration register (parity specific)
      reg           dma_config_r_27;            // DMA configuration register (parity specific)
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          dma_config_r_31     <= 1'b0;
          dma_config_r_27     <= 1'b0;
        end
        else if (write_registers)
        begin
          if (i_paddr == `gem_dma_config)
          begin
            dma_config_r_31     <= pwdata[31];
            dma_config_r_27     <= pwdata[27];
          end
        end
      end
      assign dma_config[31]     = dma_config_r_31;
      assign dma_config[27]     = dma_config_r_27;
    end else begin : gen_no_par
      assign dma_config[31]     = 1'b0;
      assign dma_config[27]     = 1'b0;
    end
  end else begin : gen_no_dma_config_31_24
    assign dma_config[31]     = 1'b0;
    assign dma_config[30:28]  = 3'd0;
    assign dma_config[27]     = 1'b0;
    assign dma_config[26:24]  = 3'd0;
  end
  endgenerate

  assign dma_config[7:6]  = dma_config_r_7_6;
  assign dma_config[4:0]  = dma_config_r_4_0;

  generate if (p_edma_tx_pkt_buffer == 1) begin : gen_dma_config_15_0
    reg   [5:0]   dma_config_r_13_8;          // DMA configuration register
    reg           dma_config_r_5;             // DMA configuration register
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
      begin
        dma_config_r_13_8   <= {3'h0,
                                p_edma_tx_pbuf_size_def,
                                p_edma_rx_pbuf_size_def};
        dma_config_r_5    <= 1'b0;
      end
      else if (write_registers)
      begin
        if (i_paddr == `gem_dma_config)
        begin
          dma_config_r_13_8   <= pwdata[13:8];
          dma_config_r_5      <= pwdata[5];
        end
      end
    end
    assign dma_config[13:8]   = dma_config_r_13_8;
    assign dma_config[5]      = dma_config_r_5;

    if (p_edma_asf_csr_prot == 1) begin : gen_par
      reg  [1:0]      dma_config_r_15_14;        // DMA configuration register (parity specific)
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          dma_config_r_15_14  <= 2'b00;
        end
        else if (write_registers)
        begin
          if (i_paddr == `gem_dma_config)
          begin
            dma_config_r_15_14     <= pwdata[15:14];
          end
        end
      end
      assign dma_config[15:14]     = dma_config_r_15_14;
    end else begin : gen_no_par
      assign dma_config[15:14]     = 2'b00;
    end

    // Mask out unused bits of dma_config for the non parity parts of this module (eg read data)
    assign dma_config_func  = {1'b0,
                               dma_config[30:28],
                               1'b0,
                               dma_config[26:16],
                               2'b00,
                               dma_config[13:5],
                               dma_config_r_4_0};

  end else begin : gen_no_dma_config_15_0
    assign dma_config[15:8]   = 8'h00;
    if (p_edma_asf_csr_prot == 1) begin : gen_par
      reg           dma_config_r_5;             // DMA configuration register (parity specific)
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          dma_config_r_5 <= 1'b0;
        end
        else if (write_registers)
        begin
          if (i_paddr == `gem_dma_config)
          begin
            dma_config_r_5 <= pwdata[5];
          end
        end
      end
      assign dma_config[5]  = dma_config_r_5;
    end else begin : gen_no_par
      assign dma_config[5]  = 1'b0;
    end

    // Mask out unused bits of dma_config for the non parity parts of this module (eg read data)
    assign dma_config_func  = {8'h00,
                               dma_config[23:16],
                               8'h00,
                               dma_config[7:6],
                               1'b0,
                               dma_config_r_4_0};

  end
  endgenerate

  assign dma_config[23:16]  = rx_dma_buf_sz_arr[0];  // Use the generated array version



  // -----------------------------------------------------------------------------
  //  APB register writes for RSC:
  // -----------------------------------------------------------------------------
  generate if ((p_edma_rsc == 1) && (p_edma_axi == 1) && (p_edma_queues > 32'd1)) begin : gen_rsc_reg
    wire  [15:0]  rsc_clr_pad;
    reg   [15:0]  rsc_en_r;
    reg           rsc_clr_mask_r;

    if (p_edma_queues < 32'd16) begin : gen_rsc_clr_pad
      assign rsc_clr_pad = {{(16-p_edma_queues){1'b1}},~rsc_clr[p_edma_queues-1:1],1'b0};
    end else begin : gen_no_rsc_clr_pad
      assign rsc_clr_pad  = {~rsc_clr[p_edma_queues-1:1],1'b0};
    end

    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
      begin
        rsc_en_r        <= 16'h0000;
        rsc_clr_mask_r  <= 1'b0;
      end
      else
      begin
        if (write_registers & i_paddr == `gem_rsc_control)
        begin
          rsc_en_r        <= pwdata[15:0];
          rsc_clr_mask_r  <= pwdata[16];
        end
        else if (|rsc_clr & ~rsc_clr_mask)
          // Clear is offset by 1
          rsc_en_r <= rsc_en_r & rsc_clr_pad;
      end
    end

    // Optional parity protection
    if (p_edma_asf_csr_prot == 1) begin : gen_par
      reg   [2:0] rsc_par;

      // Store associated parity
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          rsc_par <= 3'h0;
        else if (write_registers & i_paddr == `gem_rsc_control)
          rsc_par <= {pwdata[16],pwdata_par[1:0]};
        else if (|rsc_clr & ~rsc_clr_mask)
        begin
          rsc_par[2]  <= rsc_par[2];
          rsc_par[1]  <= ^{rsc_en_r[15:8] & rsc_clr_pad[15:8]};
          rsc_par[0]  <= ^{rsc_en_r[7:0] & rsc_clr_pad[7:0]};
        end
      end

      // Check the parity constantly
      cdnsdru_asf_parity_check_v1 #(.p_data_width(17)) i_par_chk (
        .odd_par    (1'b0),
        .data_in    ({rsc_clr_mask_r,rsc_en_r}),
        .parity_in  (rsc_par),
        .parity_err (rsc_par_err)
      );
    end else begin : gen_no_par
      assign rsc_par_err  = 1'b0;
    end

    assign rsc_en       = rsc_en_r[15:1];
    assign rsc_clr_mask = rsc_clr_mask_r;
  end else begin : gen_no_rsc
    assign rsc_en       = 15'h0000;
    assign rsc_clr_mask = 1'b0;
    assign rsc_par_err  = 1'b0;
  end
  endgenerate


  // Generate AXI specific registers
  generate if (p_edma_axi == 1) begin : gen_axi_reg
    localparam p_axi_qos_base  = `gem_axi_qos_cfg0;
    reg [7:0] max_num_axi_aw2w_r;
    reg [7:0] max_num_axi_ar2r_r;
    reg       use_aw2b_fill_r;
    reg [7:0] axi_tx_full_adj_0_r;
    reg [7:0] axi_tx_full_adj_1_r;
    reg [7:0] axi_tx_full_adj_2_r;
    reg [7:0] axi_tx_full_adj_3_r;

    wire  [p_edma_queues-1:0] axi_qos_par_err;

    genvar qos_loop1;
    // Loop through all possible queues to store the qos array
    for (qos_loop1=0;qos_loop1<16;qos_loop1=qos_loop1+1) begin : gen_qos_cfg
      localparam p_q_offset  = qos_loop1%4;  // Byte of pwdata to use.
      localparam p_cfg_addr  = p_axi_qos_base + ((qos_loop1/4) * 4);
      if (qos_loop1 < p_edma_queues[31:0]) begin : gen_exists
        reg [7:0] qos_cfg_r;
        always@(posedge pclk or negedge n_preset)
        begin
          if(~n_preset)
            qos_cfg_r   <= 8'h00;
          else
            if (write_registers & ({{20{1'b0}},i_paddr} == p_cfg_addr))
              qos_cfg_r <= pwdata[(p_q_offset*8)+7:(p_q_offset*8)];
        end

        assign axi_qos_q_mapping_arr[qos_loop1] = qos_cfg_r;
        assign axi_qos_q_mapping[(qos_loop1*8)+7:(qos_loop1*8)] = qos_cfg_r;

        // Optional parity protection
        if (p_edma_asf_csr_prot == 1) begin : gen_par
          reg axi_qos_cfg_par_r;
          always@(posedge pclk or negedge n_preset)
          begin
            if(~n_preset)
              axi_qos_cfg_par_r <= 1'b0;
            else
              if (write_registers & ({{20{1'b0}},i_paddr} == p_cfg_addr))
                axi_qos_cfg_par_r <= pwdata_par[p_q_offset];
          end
          // Check the parity constantly
          cdnsdru_asf_parity_check_v1 #(.p_data_width(8)) i_par_chk (
            .odd_par    (1'b0),
            .data_in    (qos_cfg_r),
            .parity_in  (axi_qos_cfg_par_r),
            .parity_err (axi_qos_par_err[qos_loop1])
          );
        end else begin : gen_no_par
          assign axi_qos_par_err[qos_loop1] = 1'b0;
        end
      end else begin : gen_no_exist
        assign axi_qos_q_mapping_arr[qos_loop1] = 8'h00;
      end
    end


    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
      begin
        use_aw2b_fill_r         <= 1'b0;
        max_num_axi_aw2w_r      <= 8'h01;
        max_num_axi_ar2r_r      <= 8'h01;
        axi_tx_full_adj_0_r     <= 8'd8;
        axi_tx_full_adj_1_r     <= 8'd6;
        axi_tx_full_adj_2_r     <= 8'd0;
        axi_tx_full_adj_3_r     <= 8'd0;
      end
      else
      begin
        if (write_registers)
        begin
          case (i_paddr)

            `gem_axi_max_pipeline :
            begin
              use_aw2b_fill_r    <= pwdata[16];
              max_num_axi_aw2w_r <= pwdata[15:8];
              max_num_axi_ar2r_r <= pwdata[7:0];
            end

            `gem_axi_tx_full_threshold0 :
            begin
              axi_tx_full_adj_0_r <= pwdata[7:0];
              axi_tx_full_adj_1_r <= pwdata[23:16];
            end

            `gem_axi_tx_full_threshold1 :
            begin
              axi_tx_full_adj_2_r <= pwdata[7:0];
              axi_tx_full_adj_3_r <= pwdata[23:16];
            end

            default : ;
          endcase
        end
      end
    end
    assign ahb_burst_length   = dma_config_r_4_0[4:0];
    assign max_num_axi_aw2w   = max_num_axi_aw2w_r;
    assign max_num_axi_ar2r   = max_num_axi_ar2r_r;
    assign use_aw2b_fill      = use_aw2b_fill_r;
    assign axi_tx_full_thresh1= {8'h00,axi_tx_full_adj_3_r,
                                  8'h00,axi_tx_full_adj_2_r};
    assign axi_tx_full_thresh0= {8'h00,axi_tx_full_adj_1_r,
                                  8'h00,axi_tx_full_adj_0_r};

    // Optional parity protection
    if (p_edma_asf_csr_prot == 1) begin : gen_par
      reg   [2:0] axi_max_pipe_par;
      reg   [1:0] axi_thresh0_par;
      reg   [1:0] axi_thresh1_par;
      wire        axi_par_err_int;

      // Store associated parity
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          axi_max_pipe_par  <= 3'b011;
          axi_thresh0_par   <= 2'b01;
          axi_thresh1_par   <= 2'b00;
        end
        else if (write_registers)
        begin
          if (i_paddr == `gem_axi_max_pipeline)
            axi_max_pipe_par  <= {pwdata[16],pwdata_par[1:0]};
          else if (i_paddr == `gem_axi_tx_full_threshold0)
            axi_thresh0_par   <= {pwdata_par[2],pwdata_par[0]};
          else if (i_paddr == `gem_axi_tx_full_threshold1)
            axi_thresh1_par   <= {pwdata_par[2],pwdata_par[0]};
        end
      end

      // Check the parity constantly
      cdnsdru_asf_parity_check_v1 #(.p_data_width(49)) i_par_chk (
        .odd_par    (1'b0),
        .data_in    ({use_aw2b_fill_r,
                      max_num_axi_aw2w_r,
                      max_num_axi_ar2r_r,
                      axi_tx_full_adj_3_r,
                      axi_tx_full_adj_2_r,
                      axi_tx_full_adj_1_r,
                      axi_tx_full_adj_0_r}),
        .parity_in  ({axi_max_pipe_par,
                      axi_thresh1_par,
                      axi_thresh0_par}),
        .parity_err (axi_par_err_int)
      );
      assign axi_par_err  = (|axi_qos_par_err) | axi_par_err_int;
    end else begin : gen_no_par
      assign axi_par_err  = 1'b0;
    end

  end else begin : gen_no_axi_reg

    reg   [4:0] ahb_burst_length_int;
    wire  [4:0] burst_length_mask;        // Mask for AHB burst length control

    // Force ahb_burst_length to legal values based on RX & TX DMA FIFO sizes
    // TX FIFO size is ignored if TX packet buffer is present
    assign burst_length_mask  = p_edma_tx_pkt_buffer == 1 ? 5'b11111 : // TX packet buffer
                  ((p_edma_rx_fifo_size >= 32'd16) & (p_edma_tx_fifo_size >= 32'd16)) ? 5'b11111 :
                  ((p_edma_rx_fifo_size >= 32'd8)  & (p_edma_tx_fifo_size >= 32'd8))  ? 5'b01111 :
                                                                                        5'b00111;

    // ahb_burst_length must be programmed one-hot
    // Also it is limited to max value based on DMA FIFO sizes
    always@(*)
    begin
      casex (dma_config_r_4_0 & burst_length_mask)
        5'b1xxxx : ahb_burst_length_int = 5'h10;
        5'b01xxx : ahb_burst_length_int = 5'h08;
        5'b001xx : ahb_burst_length_int = 5'h04;
        5'b0001x : ahb_burst_length_int = 5'h02;
        5'b00001 : ahb_burst_length_int = 5'h01;
        default  : ahb_burst_length_int = 5'h04; // keep at 4-beat
      endcase
    end

    assign ahb_burst_length   = ahb_burst_length_int;
    assign max_num_axi_aw2w   = 8'h00;
    assign max_num_axi_ar2r   = 8'h00;
    assign use_aw2b_fill      = 1'b0;
    assign axi_tx_full_thresh0= 32'd0;
    assign axi_tx_full_thresh1= 32'd0;
    assign axi_par_err        = 1'b0;
    assign axi_qos_q_mapping_arr[0]   = 8'h00;
    assign axi_qos_q_mapping_arr[1]   = 8'h00;
    assign axi_qos_q_mapping_arr[2]   = 8'h00;
    assign axi_qos_q_mapping_arr[3]   = 8'h00;
    assign axi_qos_q_mapping_arr[4]   = 8'h00;
    assign axi_qos_q_mapping_arr[5]   = 8'h00;
    assign axi_qos_q_mapping_arr[6]   = 8'h00;
    assign axi_qos_q_mapping_arr[7]   = 8'h00;
    assign axi_qos_q_mapping_arr[8]   = 8'h00;
    assign axi_qos_q_mapping_arr[9]   = 8'h00;
    assign axi_qos_q_mapping_arr[10]  = 8'h00;
    assign axi_qos_q_mapping_arr[11]  = 8'h00;
    assign axi_qos_q_mapping_arr[12]  = 8'h00;
    assign axi_qos_q_mapping_arr[13]  = 8'h00;
    assign axi_qos_q_mapping_arr[14]  = 8'h00;
    assign axi_qos_q_mapping_arr[15]  = 8'h00;
    assign axi_qos_q_mapping          = {(8*p_edma_queues){1'b0}};
  end
  endgenerate

  // Output assignment of adjustment registers, the maximum address width
  // is 16-bits and the 8-bit adjustment registers are already padded with
  // 8'd0 above.
  assign axi_tx_full_adj_0  = axi_tx_full_thresh0[p_edma_tx_pbuf_addr-1:0];
  assign axi_tx_full_adj_1  = axi_tx_full_thresh0[p_edma_tx_pbuf_addr+15:16];
  assign axi_tx_full_adj_2  = axi_tx_full_thresh1[p_edma_tx_pbuf_addr-1:0];
  assign axi_tx_full_adj_3  = axi_tx_full_thresh1[p_edma_tx_pbuf_addr+15:16];


  // -----------------------------------------------------------------------------
  //  APB register writes for Priority Queue DMA using packet buffer
  // -----------------------------------------------------------------------------
  generate if (p_edma_rx_pkt_buffer == 1) begin : gen_rx_pbuf_reg
    genvar  loop_q;
    genvar  loop_nq;
    reg   [7:0]   dma_addr_or_mask_r;
    reg           dma_addr_or_mask_tog;
    reg   [15:0]  rx_cutthru_threshold_r;
    reg           rx_cutthru_r;
    reg   [31:0]  rx_water_mark_r;
    wire          par_err_64b;

    // 64-bit addressing support
    if (p_edma_addr_width == 32'd64) begin : gen_64b_addr
      reg   [31:0]                  upper_rx_q_base_addr_r;
      always@(posedge pclk or negedge n_preset)
      begin
        if(~n_preset)
          upper_rx_q_base_addr_r    <= 32'd0;
        else
          if (write_registers & (i_paddr == `gem_upper_rx_q_base_addr))
            upper_rx_q_base_addr_r <= pwdata[31:0];
      end
      assign upper_rx_q_base_addr   = upper_rx_q_base_addr_r;

      // Optional parity protection
      if ((p_edma_asf_csr_prot == 1) ||
          (p_edma_asf_dap_prot == 1)) begin : gen_par
        reg   [3:0] addr_64_par;

        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
            addr_64_par <= 4'h0;
          else
            if (write_registers & (i_paddr == `gem_upper_rx_q_base_addr))
              addr_64_par[3:0]  <= pwdata_par;
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(32)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    (upper_rx_q_base_addr_r),
          .parity_in  (addr_64_par),
          .parity_err (par_err_64b)
        );

        assign upper_rx_q_base_par  = addr_64_par;

      end else begin : gen_no_par
        assign par_err_64b  = 1'b0;
        assign upper_rx_q_base_par  = 4'h0;
      end

    end
    else begin : gen_32b_addr
      assign upper_rx_q_base_addr = 32'd0;
      assign upper_rx_q_base_par  = 4'h0;
      assign par_err_64b          = 1'b0;
    end

    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
      begin
        dma_addr_or_mask_r        <= 8'h00;
        dma_addr_or_mask_tog      <= 1'b0;
        rx_cutthru_threshold_r    <= 16'hffff;
        rx_cutthru_r              <= 1'b0;
        rx_water_mark_r           <= 32'h00000000;
      end
      else
        if (write_registers)
        begin

          if (i_paddr == `gem_dma_addr_or_mask)
          begin
            dma_addr_or_mask_r    <= {pwdata[31:28],pwdata[3:0]};
            if (dma_addr_or_mask[7:0] != {pwdata[31:28],pwdata[3:0]})
              dma_addr_or_mask_tog  <= ~dma_addr_or_mask_tog;
          end

          if (i_paddr == `gem_pbuf_rxcutthru)
          begin
            rx_cutthru_threshold_r  <= pwdata[15:0];
            rx_cutthru_r            <= pwdata[31];
          end

          if (i_paddr == `gem_rx_water_mark)
          begin
            rx_water_mark_r  <= pwdata[31:0];
          end

        end
    end

    if (p_edma_tsu == 1'b1) begin : gen_rx_bd_ts_mode
      reg   [1:0]   rx_bd_ts_mode_r;
      always@(posedge pclk or negedge n_preset)
      begin
        if(~n_preset)
          rx_bd_ts_mode_r   <= 2'h0;
        else
          if (write_registers & (i_paddr == `gem_rx_bd_control))
            rx_bd_ts_mode_r <= pwdata[5:4];
      end
      assign rx_bd_ts_mode   = rx_bd_ts_mode_r;
    end else begin : gen_no_rx_bd_ts_mode
      assign rx_bd_ts_mode   = 2'b00;
    end

    // generate fill level signals for automatic transmission of pause frames when the receive SRAM fills up.
    // the rx_dpram_fill_lvl_pclk signal indicates how many words have been used in the receive SRAM. The
    // number of bytes used depends on the SRAM data-width.
    // the upper 16 bits of rx_water_mark_r indicate the low watermark and the lower 16 bits indicate the high water mark.
    // When rx_dpram_fill_lvl_pclk exceeds the high watermark assert rx_fill_level_high_r
    // When rx_dpram_fill_lvl_pclk is lower the low watermark assert rx_fill_level_low_r
    // If the 16 bit values set in rx_water_mark_r are all zero then then corresponding fill level signals are not asserted
    // gem_tx detects rising edges on the fill level signal and transmits a zero quantum pause frame or a non-zero frame as is required
    reg rx_fill_level_high_r, rx_fill_level_low_r;
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
      begin
        rx_fill_level_high_r <= 1'b0;
        rx_fill_level_low_r  <= 1'b0;
      end
      else
      begin
        if ((rx_water_mark_r[15:0] != 16'd0) & (rx_dpram_fill_lvl_pad_pclk > rx_water_mark_r[15:0]))
          rx_fill_level_high_r <= 1'b1;
        else
          rx_fill_level_high_r <= 1'b0;
        if ((rx_water_mark_r[31:16] != 16'd0) & (rx_dpram_fill_lvl_pad_pclk < rx_water_mark_r[31:16]))
          rx_fill_level_low_r <= 1'b1;
        else
          rx_fill_level_low_r <= 1'b0;
      end
    end

    assign dma_addr_or_mask       = {dma_addr_or_mask_tog,dma_addr_or_mask_r};
    assign rx_cutthru_threshold   = rx_cutthru_threshold_r[p_edma_rx_pbuf_addr-1:0];
    assign rx_cutthru             = rx_cutthru_r;
    assign rx_water_mark          = rx_water_mark_r;
    assign rx_fill_level_low      = rx_fill_level_low_r;
    assign rx_fill_level_high     = rx_fill_level_high_r;
    assign rx_pbuf_size           = dma_config_func[9:8];
    assign hdr_data_splitting_en  = dma_config_func[5];
    assign inf_last_dbuf_size_en  = dma_config_func[12];
    assign crc_error_report       = dma_config_func[13];
    assign force_discard_on_err   = dma_config_func[24];
    assign force_max_ahb_burst_rx = dma_config_func[25];
    assign rx_bd_extended_mode_en = dma_config_func[28];
    assign dma_addr_bus_width_1   = dma_config_func[30];

    // Optional parity protection
    if (p_edma_asf_csr_prot == 1) begin : gen_par
      wire        pbuf_rx_par_err_int;
      reg         dma_addr_mask_par;
      reg   [2:0] rx_cutthru_par;
      reg   [3:0] rx_watermark_par;
      wire        rx_bd_ctrl_par;

      // Store associated parity
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          dma_addr_mask_par <= 1'b0;
          rx_cutthru_par    <= 3'b000;
          rx_watermark_par  <= 4'b0000;
        end
        else if (write_registers)
        begin
          if (i_paddr == `gem_dma_addr_or_mask)
            dma_addr_mask_par <= ^{pwdata[31:28],pwdata[3:0]};
          if (i_paddr == `gem_pbuf_rxcutthru)
            rx_cutthru_par    <= {pwdata[31],pwdata_par[1:0]};
          if (i_paddr == `gem_rx_water_mark)
            rx_watermark_par  <= pwdata_par;
        end
      end

      if (p_edma_tsu == 1'b1) begin : gen_rx_bd_ts_mode
        reg rx_bd_ctrl_par_r;
        always@(posedge pclk or negedge n_preset)
        begin
          if(~n_preset)
            rx_bd_ctrl_par_r    <= 1'b0;
          else
            if (write_registers & (i_paddr == `gem_rx_bd_control))
              rx_bd_ctrl_par_r    <= ^pwdata[5:4];
        end
        assign rx_bd_ctrl_par = rx_bd_ctrl_par_r;
      end else begin : gen_no_rx_bd_ts_mode
        assign rx_bd_ctrl_par = 1'b0;
      end

      // Check the parity constantly
      cdnsdru_asf_parity_check_v1 #(.p_data_width(65)) i_par_chk (
        .odd_par    (1'b0),
        .data_in    ({rx_cutthru_r,rx_cutthru_threshold_r,
                      6'h00,rx_bd_ts_mode,
                      dma_addr_or_mask_r,
                      rx_water_mark_r}),
        .parity_in  ({rx_cutthru_par,
                      rx_bd_ctrl_par,
                      dma_addr_mask_par,
                      rx_watermark_par}),
        .parity_err (pbuf_rx_par_err_int)
      );
      assign pbuf_rx_par_err = pbuf_rx_par_err_int | par_err_64b;
    end else begin : gen_no_par
      assign pbuf_rx_par_err  = 1'b0;
    end

  end else begin : gen_no_rx_pbuf_reg
    assign dma_addr_bus_width_1   = 1'b0;
    assign dma_addr_or_mask       = 9'h000;
    assign rx_cutthru_threshold   = {p_edma_rx_pbuf_addr{1'b0}};
    assign rx_cutthru             = 1'b0;
    assign rx_water_mark          = 32'd0;
    assign rx_fill_level_low      = 1'b0;
    assign rx_fill_level_high     = 1'b0;
    assign rx_pbuf_size           = 2'b00;
    assign hdr_data_splitting_en  = 1'b0;
    assign inf_last_dbuf_size_en  = 1'b0;
    assign crc_error_report       = 1'b0;
    assign force_discard_on_err   = 1'b0;
    assign force_max_ahb_burst_rx = 1'b0;
    assign rx_bd_extended_mode_en = 1'b0;
    assign upper_rx_q_base_addr   = 32'd0;
    assign rx_bd_ts_mode          = 2'b00;
    assign pbuf_rx_par_err        = 1'b0;
    assign upper_rx_q_base_par    = 4'h0;
  end
  endgenerate

  generate if (p_edma_tx_pkt_buffer == 1) begin : gen_tx_pbuf_reg
    reg   [15:0]  tx_cutthru_threshold_r;
    reg           tx_cutthru_r;
    reg   [4:0]   sel_dpram_fill_lvl_dbg_r;
    wire          par_err_64b;

    localparam p_seg_rst_val = {1'b0,p_edma_tx_pbuf_num_segments_q15[2:0],1'b0,p_edma_tx_pbuf_num_segments_q14[2:0],
                                1'b0,p_edma_tx_pbuf_num_segments_q13[2:0],1'b0,p_edma_tx_pbuf_num_segments_q12[2:0],
                                1'b0,p_edma_tx_pbuf_num_segments_q11[2:0],1'b0,p_edma_tx_pbuf_num_segments_q10[2:0],
                                1'b0,p_edma_tx_pbuf_num_segments_q9[2:0],1'b0,p_edma_tx_pbuf_num_segments_q8[2:0],
                                1'b0,p_edma_tx_pbuf_num_segments_q7[2:0],1'b0,p_edma_tx_pbuf_num_segments_q6[2:0],
                                1'b0,p_edma_tx_pbuf_num_segments_q5[2:0],1'b0,p_edma_tx_pbuf_num_segments_q4[2:0],
                                1'b0,p_edma_tx_pbuf_num_segments_q3[2:0],1'b0,p_edma_tx_pbuf_num_segments_q2[2:0],
                                1'b0,p_edma_tx_pbuf_num_segments_q1[2:0],1'b0,p_edma_tx_pbuf_num_segments_q0[2:0]};


    // 64-bit addressing support
    if (p_edma_addr_width == 32'd64) begin : gen_64b_addr
      reg   [31:0]                  upper_tx_q_base_addr_r;
      always@(posedge pclk or negedge n_preset)
      begin
        if(~n_preset)
          upper_tx_q_base_addr_r    <= 32'd0;
        else
          if (write_registers & (i_paddr == `gem_upper_tx_q_base_addr))
            upper_tx_q_base_addr_r <= pwdata[31:0];
      end
      assign upper_tx_q_base_addr   = upper_tx_q_base_addr_r;

      // Optional parity protection
      if ((p_edma_asf_csr_prot == 1) ||
          (p_edma_asf_dap_prot == 1)) begin : gen_par
        reg   [3:0] addr_64_par;

        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
            addr_64_par <= 4'h0;
          else
            if (write_registers & (i_paddr == `gem_upper_tx_q_base_addr))
              addr_64_par[3:0]  <= pwdata_par;
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(32)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    (upper_tx_q_base_addr_r),
          .parity_in  (addr_64_par),
          .parity_err (par_err_64b)
        );

        assign upper_tx_q_base_par  = addr_64_par;

      end else begin : gen_no_par
        assign par_err_64b  = 1'b0;
        assign upper_tx_q_base_par  = 4'h0;
      end

    end
    else begin : gen_32b_addr
      assign upper_tx_q_base_addr = 32'd0;
      assign upper_tx_q_base_par  = 4'h0;
      assign par_err_64b          = 1'b0;
    end

    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
      begin
        tx_cutthru_threshold_r    <= 16'hffff;
        tx_cutthru_r              <= 1'b0;
        sel_dpram_fill_lvl_dbg_r  <= 5'h00;
      end
      else
        if (write_registers)
        begin

          if (i_paddr == `gem_pbuf_txcutthru)
          begin
            tx_cutthru_threshold_r  <= pwdata[15:0];
            tx_cutthru_r            <= pwdata[31];
          end

          if (i_paddr == `gem_dpram_fill_dbg)
            sel_dpram_fill_lvl_dbg_r <= {pwdata[7:4],pwdata[0]};  // Debug register not parity protected.

        end
    end

    if (p_edma_tsu == 1'b1) begin : gen_tx_bd_ts_mode
      reg   [1:0]   tx_bd_ts_mode_r;
      always@(posedge pclk or negedge n_preset)
      begin
        if(~n_preset)
          tx_bd_ts_mode_r           <= 2'd0;
        else
          if (write_registers & (i_paddr == `gem_tx_bd_control))
            tx_bd_ts_mode_r  <= pwdata[5:4];
      end
      assign tx_bd_ts_mode          = tx_bd_ts_mode_r;
    end else begin : gen_no_tx_bd_ts_mode
      assign tx_bd_ts_mode          = 2'b00;
    end

    assign tx_cutthru_threshold   = tx_cutthru_threshold_r[p_edma_tx_pbuf_addr-1:0];
    assign tx_cutthru             = tx_cutthru_r;
    assign sel_dpram_fill_lvl_dbg = sel_dpram_fill_lvl_dbg_r;
    assign tx_pbuf_size           = dma_config_func[10];
    assign tx_pbuf_tcp_en         = dma_config_func[11];
    assign force_max_ahb_burst_tx = dma_config_func[26];
    assign tx_bd_extended_mode_en = dma_config_func[29];

    // Optional parity protection
    // Note that the segment allocation registers are separated here to avoid lint
    // warnings of unused registers when parity is not defined.
    if (p_edma_asf_csr_prot == 1) begin : gen_par
      wire          pbuf_tx_par_err_int;
      reg   [7:0]   tx_seg_alloc_par;
      reg   [2:0]   tx_cutthru_par;
      wire          tx_bd_ctrl_par;
      reg   [63:0]  tx_pbuf_segments_int;

      localparam p_seg_par_rst_val = {^p_seg_rst_val[63:56],
                                      ^p_seg_rst_val[55:48],
                                      ^p_seg_rst_val[47:40],
                                      ^p_seg_rst_val[39:32],
                                      ^p_seg_rst_val[31:24],
                                      ^p_seg_rst_val[23:16],
                                      ^p_seg_rst_val[15:8],
                                      ^p_seg_rst_val[7:0]};

      // Store associated parity
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          tx_cutthru_par        <= 3'b000;
          tx_seg_alloc_par      <= p_seg_par_rst_val;
          tx_pbuf_segments_int  <= p_seg_rst_val;
        end
        else if (write_registers)
        begin
          if (i_paddr == `gem_pbuf_txcutthru)
            tx_cutthru_par    <= {pwdata[31],pwdata_par[1:0]};
          if (i_paddr == `gem_tx_q_seg_alloc_q07)
          begin
            tx_seg_alloc_par[3:0]       <= pwdata_par;
            tx_pbuf_segments_int[31:0]  <= pwdata;
          end
          if (i_paddr == `gem_tx_q_seg_alloc_q8f)
          begin
            tx_seg_alloc_par[7:4]       <= pwdata_par;
            tx_pbuf_segments_int[63:32] <= pwdata;
          end
        end
      end

      if (p_edma_tsu == 1'b1) begin : gen_tx_bd_ts_mode
        reg tx_bd_ctrl_par_r;
        always@(posedge pclk or negedge n_preset)
        begin
          if(~n_preset)
            tx_bd_ctrl_par_r    <= 1'b0;
          else
            if (write_registers & (i_paddr == `gem_tx_bd_control))
              tx_bd_ctrl_par_r    <= ^pwdata[5:4];
        end
        assign tx_bd_ctrl_par = tx_bd_ctrl_par_r;
      end else begin : gen_no_tx_bd_ts_mode
        assign tx_bd_ctrl_par = 1'b0;
      end

      // Check the parity constantly
      cdnsdru_asf_parity_check_v1 #(.p_data_width(89)) i_par_chk (
        .odd_par    (1'b0),
        .data_in    ({tx_cutthru_r,tx_cutthru_threshold_r,
                      6'h00,tx_bd_ts_mode,
                      tx_pbuf_segments_int}),
        .parity_in  ({tx_cutthru_par,
                      tx_bd_ctrl_par,
                      tx_seg_alloc_par}),
        .parity_err (pbuf_tx_par_err_int)
      );
      assign pbuf_tx_par_err = pbuf_tx_par_err_int | par_err_64b;

      assign tx_pbuf_segments[2:0]    = tx_pbuf_segments_int[2:0];
      assign tx_pbuf_segments[5:3]    = (p_edma_queues > 32'd1)   ? tx_pbuf_segments_int[6:4]   : 3'b000;
      assign tx_pbuf_segments[8:6]    = (p_edma_queues > 32'd2)   ? tx_pbuf_segments_int[10:8]  : 3'b000;
      assign tx_pbuf_segments[11:9]   = (p_edma_queues > 32'd3)   ? tx_pbuf_segments_int[14:12] : 3'b000;
      assign tx_pbuf_segments[14:12]  = (p_edma_queues > 32'd4)   ? tx_pbuf_segments_int[18:16] : 3'b000;
      assign tx_pbuf_segments[17:15]  = (p_edma_queues > 32'd5)   ? tx_pbuf_segments_int[22:20] : 3'b000;
      assign tx_pbuf_segments[20:18]  = (p_edma_queues > 32'd6)   ? tx_pbuf_segments_int[26:24] : 3'b000;
      assign tx_pbuf_segments[23:21]  = (p_edma_queues > 32'd7)   ? tx_pbuf_segments_int[30:28] : 3'b000;
      assign tx_pbuf_segments[26:24]  = (p_edma_queues > 32'd8)   ? tx_pbuf_segments_int[34:32] : 3'b000;
      assign tx_pbuf_segments[29:27]  = (p_edma_queues > 32'd9)   ? tx_pbuf_segments_int[38:36] : 3'b000;
      assign tx_pbuf_segments[32:30]  = (p_edma_queues > 32'd10)  ? tx_pbuf_segments_int[42:40] : 3'b000;
      assign tx_pbuf_segments[35:33]  = (p_edma_queues > 32'd11)  ? tx_pbuf_segments_int[46:44] : 3'b000;
      assign tx_pbuf_segments[38:36]  = (p_edma_queues > 32'd12)  ? tx_pbuf_segments_int[50:48] : 3'b000;
      assign tx_pbuf_segments[41:39]  = (p_edma_queues > 32'd13)  ? tx_pbuf_segments_int[54:52] : 3'b000;
      assign tx_pbuf_segments[44:42]  = (p_edma_queues > 32'd14)  ? tx_pbuf_segments_int[58:56] : 3'b000;
      assign tx_pbuf_segments[47:45]  = (p_edma_queues > 32'd15)  ? tx_pbuf_segments_int[62:60] : 3'b000;

    end else begin : gen_no_par
      assign pbuf_tx_par_err  = 1'b0;
      genvar seg_loop;
      for (seg_loop = 0; seg_loop < 8; seg_loop = seg_loop + 1)
      begin : gen_seg_q
        // Bottom 8 queues
        if (seg_loop < p_edma_queues[31:0]) begin : gen_l_exists
          reg [2:0] seg_r;
          always @(posedge pclk or negedge n_preset)
          begin
            if (~n_preset)
              seg_r <=  p_seg_rst_val[(seg_loop*4)+2:seg_loop*4];
            else if (write_registers & (i_paddr == `gem_tx_q_seg_alloc_q07))
              seg_r <= pwdata[(seg_loop*4)+2:seg_loop*4];
          end
          assign tx_pbuf_segments[(seg_loop*3)+2:seg_loop*3]  = seg_r;
        end else begin : gen_no_l_exists
          assign tx_pbuf_segments[(seg_loop*3)+2:seg_loop*3]  = 3'b000;
        end

        // Upper 8 queues
        if ((seg_loop + 8) < p_edma_queues[31:0]) begin : gen_u_exists
          reg [2:0] seg_r;
          always @(posedge pclk or negedge n_preset)
          begin
            if (~n_preset)
              seg_r <=  p_seg_rst_val[((seg_loop+8)*4)+2:(seg_loop+8)*4];
            else if (write_registers & (i_paddr == `gem_tx_q_seg_alloc_q8f))
              seg_r <= pwdata[(seg_loop*4)+2:seg_loop*4];
          end
          assign tx_pbuf_segments[((seg_loop+8)*3)+2:(seg_loop+8)*3]  = seg_r;
        end else begin : gen_no_u_exists
          assign tx_pbuf_segments[((seg_loop+8)*3)+2:(seg_loop+8)*3]  = 3'b000;
        end

      end
    end

  end else begin : gen_no_tx_pbuf_reg
    assign tx_cutthru_threshold   = {p_edma_tx_pbuf_addr{1'b0}};
    assign tx_cutthru             = 1'b0;
    assign sel_dpram_fill_lvl_dbg = 5'h00;
    assign tx_pbuf_size           = 1'b0;
    assign tx_pbuf_tcp_en         = 1'b0;
    assign force_max_ahb_burst_tx = 1'b0;
    assign tx_bd_extended_mode_en = 1'b0;
    assign upper_tx_q_base_addr   = 32'd0;
    assign tx_bd_ts_mode          = 2'b00;
    assign tx_pbuf_segments       = {48{1'b0}};
    assign pbuf_tx_par_err        = 1'b0;
    assign upper_tx_q_base_par    = 4'h0;
  end
  endgenerate

  // The prdata_dma should be registered externally.
  always @(*)
  begin
    if (read_registers)
      case (i_paddr)
        `gem_dma_config         : prdata_dma  = dma_config_func;
        `gem_receive_q_ptr      : prdata_dma  = rx_base_addr_arr[0];
        `gem_receive_q1_ptr     : prdata_dma  = rx_base_addr_arr[1];
        `gem_receive_q2_ptr     : prdata_dma  = rx_base_addr_arr[2];
        `gem_receive_q3_ptr     : prdata_dma  = rx_base_addr_arr[3];
        `gem_receive_q4_ptr     : prdata_dma  = rx_base_addr_arr[4];
        `gem_receive_q5_ptr     : prdata_dma  = rx_base_addr_arr[5];
        `gem_receive_q6_ptr     : prdata_dma  = rx_base_addr_arr[6];
        `gem_receive_q7_ptr     : prdata_dma  = rx_base_addr_arr[7];
        `gem_receive_q8_ptr     : prdata_dma  = rx_base_addr_arr[8];
        `gem_receive_q9_ptr     : prdata_dma  = rx_base_addr_arr[9];
        `gem_receive_q10_ptr    : prdata_dma  = rx_base_addr_arr[10];
        `gem_receive_q11_ptr    : prdata_dma  = rx_base_addr_arr[11];
        `gem_receive_q12_ptr    : prdata_dma  = rx_base_addr_arr[12];
        `gem_receive_q13_ptr    : prdata_dma  = rx_base_addr_arr[13];
        `gem_receive_q14_ptr    : prdata_dma  = rx_base_addr_arr[14];
        `gem_receive_q15_ptr    : prdata_dma  = rx_base_addr_arr[15];
        `gem_transmit_q_ptr     : prdata_dma  = tx_base_addr_arr[0];
        `gem_transmit_q1_ptr    : prdata_dma  = tx_base_addr_arr[1];
        `gem_transmit_q2_ptr    : prdata_dma  = tx_base_addr_arr[2];
        `gem_transmit_q3_ptr    : prdata_dma  = tx_base_addr_arr[3];
        `gem_transmit_q4_ptr    : prdata_dma  = tx_base_addr_arr[4];
        `gem_transmit_q5_ptr    : prdata_dma  = tx_base_addr_arr[5];
        `gem_transmit_q6_ptr    : prdata_dma  = tx_base_addr_arr[6];
        `gem_transmit_q7_ptr    : prdata_dma  = tx_base_addr_arr[7];
        `gem_transmit_q8_ptr    : prdata_dma  = tx_base_addr_arr[8];
        `gem_transmit_q9_ptr    : prdata_dma  = tx_base_addr_arr[9];
        `gem_transmit_q10_ptr   : prdata_dma  = tx_base_addr_arr[10];
        `gem_transmit_q11_ptr   : prdata_dma  = tx_base_addr_arr[11];
        `gem_transmit_q12_ptr   : prdata_dma  = tx_base_addr_arr[12];
        `gem_transmit_q13_ptr   : prdata_dma  = tx_base_addr_arr[13];
        `gem_transmit_q14_ptr   : prdata_dma  = tx_base_addr_arr[14];
        `gem_transmit_q15_ptr   : prdata_dma  = tx_base_addr_arr[15];
        `gem_dma_rxbuf_size_q1  : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[1]};
        `gem_dma_rxbuf_size_q2  : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[2]};
        `gem_dma_rxbuf_size_q3  : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[3]};
        `gem_dma_rxbuf_size_q4  : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[4]};
        `gem_dma_rxbuf_size_q5  : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[5]};
        `gem_dma_rxbuf_size_q6  : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[6]};
        `gem_dma_rxbuf_size_q7  : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[7]};
        `gem_dma_rxbuf_size_q8  : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[8]};
        `gem_dma_rxbuf_size_q9  : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[9]};
        `gem_dma_rxbuf_size_q10 : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[10]};
        `gem_dma_rxbuf_size_q11 : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[11]};
        `gem_dma_rxbuf_size_q12 : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[12]};
        `gem_dma_rxbuf_size_q13 : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[13]};
        `gem_dma_rxbuf_size_q14 : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[14]};
        `gem_dma_rxbuf_size_q15 : prdata_dma  = {24'd0,rx_dma_buf_sz_arr[15]};
        `gem_wd_counter         : prdata_dma  = {28'd0,restart_counter_top};
        `gem_rsc_control        : prdata_dma  = {15'h0000,rsc_clr_mask,rsc_en,1'b0};
        `gem_dma_addr_or_mask   : prdata_dma = {dma_addr_or_mask[7:4], 24'd0, dma_addr_or_mask[3:0]};
        `gem_pbuf_txcutthru     : prdata_dma = {tx_cutthru, {(31-p_edma_tx_pbuf_addr){1'b0}}, tx_cutthru_threshold};
        `gem_pbuf_rxcutthru     : prdata_dma = {rx_cutthru, {(31-p_edma_rx_pbuf_addr){1'b0}}, rx_cutthru_threshold};
        `gem_rx_water_mark      : prdata_dma = rx_water_mark;
        `gem_dpram_fill_dbg     : prdata_dma = {dpram_fill_lvl_pclk[15:0], 8'h00, sel_dpram_fill_lvl_dbg[4:1], 3'h0, sel_dpram_fill_lvl_dbg[0]};
        `gem_tx_q_seg_alloc_q07 : prdata_dma = {1'b0,tx_pbuf_segments[23:21],
                                                 1'b0,tx_pbuf_segments[20:18],
                                                 1'b0,tx_pbuf_segments[17:15],
                                                 1'b0,tx_pbuf_segments[14:12],
                                                 1'b0,tx_pbuf_segments[11:9],
                                                 1'b0,tx_pbuf_segments[8:6],
                                                 1'b0,tx_pbuf_segments[5:3],
                                                 1'b0,tx_pbuf_segments[2:0]};
        `gem_tx_q_seg_alloc_q8f : prdata_dma = {1'b0,tx_pbuf_segments[47:45],
                                                 1'b0,tx_pbuf_segments[44:42],
                                                 1'b0,tx_pbuf_segments[41:39],
                                                 1'b0,tx_pbuf_segments[38:36],
                                                 1'b0,tx_pbuf_segments[35:33],
                                                 1'b0,tx_pbuf_segments[32:30],
                                                 1'b0,tx_pbuf_segments[29:27],
                                                 1'b0,tx_pbuf_segments[26:24]};
        `gem_upper_tx_q_base_addr : prdata_dma = upper_tx_q_base_addr;
        `gem_upper_rx_q_base_addr : prdata_dma = upper_rx_q_base_addr;
        `gem_tx_bd_control        : prdata_dma = {26'd0,tx_bd_ts_mode,4'h0 };
        `gem_rx_bd_control        : prdata_dma = {26'd0,rx_bd_ts_mode,4'h0 };
        `gem_axi_max_pipeline       : prdata_dma = {15'h0000,use_aw2b_fill,max_num_axi_aw2w,max_num_axi_ar2r};
        `gem_axi_tx_full_threshold0 : prdata_dma = axi_tx_full_thresh0;
        `gem_axi_tx_full_threshold1 : prdata_dma = axi_tx_full_thresh1;
        `gem_axi_qos_cfg0           : prdata_dma = {axi_qos_q_mapping_arr[3],axi_qos_q_mapping_arr[2],
                                                    axi_qos_q_mapping_arr[1],axi_qos_q_mapping_arr[0]};
        `gem_axi_qos_cfg1           : prdata_dma = {axi_qos_q_mapping_arr[7],axi_qos_q_mapping_arr[6],
                                                    axi_qos_q_mapping_arr[5],axi_qos_q_mapping_arr[4]};
        `gem_axi_qos_cfg2           : prdata_dma = {axi_qos_q_mapping_arr[11],axi_qos_q_mapping_arr[10],
                                                    axi_qos_q_mapping_arr[9],axi_qos_q_mapping_arr[8]};
        `gem_axi_qos_cfg3           : prdata_dma = {axi_qos_q_mapping_arr[15],axi_qos_q_mapping_arr[14],
                                                    axi_qos_q_mapping_arr[13],axi_qos_q_mapping_arr[12]};
        default : prdata_dma  = 32'h00000000;
      endcase
    else
      prdata_dma  = 32'h00000000;
  end

  // Perr signal is similar to above. This is registered to match previous implementation
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      perr_dma  <= 1'b0;
    else if (psel)
      case (i_paddr)
        `gem_dma_config           : perr_dma  <= 1'b0;
        `gem_receive_q_ptr        : perr_dma  <= 1'b0;
        `gem_transmit_q_ptr       : perr_dma  <= 1'b0;
        `gem_dma_rxbuf_size_q1    : perr_dma  <= p_edma_queues < 32'd2;
        `gem_transmit_q1_ptr      : perr_dma  <= p_edma_queues < 32'd2;
        `gem_receive_q1_ptr       : perr_dma  <= p_edma_queues < 32'd2;
        `gem_dma_rxbuf_size_q2    : perr_dma  <= p_edma_queues < 32'd3;
        `gem_receive_q2_ptr       : perr_dma  <= p_edma_queues < 32'd3;
        `gem_transmit_q2_ptr      : perr_dma  <= p_edma_queues < 32'd3;
        `gem_dma_rxbuf_size_q3    : perr_dma  <= p_edma_queues < 32'd4;
        `gem_receive_q3_ptr       : perr_dma  <= p_edma_queues < 32'd4;
        `gem_transmit_q3_ptr      : perr_dma  <= p_edma_queues < 32'd4;
        `gem_receive_q4_ptr       : perr_dma  <= p_edma_queues < 32'd5;
        `gem_transmit_q4_ptr      : perr_dma  <= p_edma_queues < 32'd5;
        `gem_dma_rxbuf_size_q4    : perr_dma  <= p_edma_queues < 32'd5;
        `gem_receive_q5_ptr       : perr_dma  <= p_edma_queues < 32'd6;
        `gem_transmit_q5_ptr      : perr_dma  <= p_edma_queues < 32'd6;
        `gem_dma_rxbuf_size_q5    : perr_dma  <= p_edma_queues < 32'd6;
        `gem_receive_q6_ptr       : perr_dma  <= p_edma_queues < 32'd7;
        `gem_transmit_q6_ptr      : perr_dma  <= p_edma_queues < 32'd7;
        `gem_dma_rxbuf_size_q6    : perr_dma  <= p_edma_queues < 32'd7;
        `gem_receive_q7_ptr       : perr_dma  <= p_edma_queues < 32'd8;
        `gem_transmit_q7_ptr      : perr_dma  <= p_edma_queues < 32'd8;
        `gem_dma_rxbuf_size_q7    : perr_dma  <= p_edma_queues < 32'd8;
        `gem_receive_q8_ptr       : perr_dma  <= p_edma_queues < 32'd9;
        `gem_transmit_q8_ptr      : perr_dma  <= p_edma_queues < 32'd9;
        `gem_dma_rxbuf_size_q8    : perr_dma  <= p_edma_queues < 32'd9;
        `gem_receive_q9_ptr       : perr_dma  <= p_edma_queues < 32'd10;
        `gem_transmit_q9_ptr      : perr_dma  <= p_edma_queues < 32'd10;
        `gem_dma_rxbuf_size_q9    : perr_dma  <= p_edma_queues < 32'd10;
        `gem_receive_q10_ptr      : perr_dma  <= p_edma_queues < 32'd11;
        `gem_transmit_q10_ptr     : perr_dma  <= p_edma_queues < 32'd11;
        `gem_dma_rxbuf_size_q10   : perr_dma  <= p_edma_queues < 32'd11;
        `gem_receive_q11_ptr      : perr_dma  <= p_edma_queues < 32'd12;
        `gem_transmit_q11_ptr     : perr_dma  <= p_edma_queues < 32'd12;
        `gem_dma_rxbuf_size_q11   : perr_dma  <= p_edma_queues < 32'd12;
        `gem_receive_q12_ptr      : perr_dma  <= p_edma_queues < 32'd13;
        `gem_transmit_q12_ptr     : perr_dma  <= p_edma_queues < 32'd13;
        `gem_dma_rxbuf_size_q12   : perr_dma  <= p_edma_queues < 32'd13;
        `gem_receive_q13_ptr      : perr_dma  <= p_edma_queues < 32'd14;
        `gem_transmit_q13_ptr     : perr_dma  <= p_edma_queues < 32'd14;
        `gem_dma_rxbuf_size_q13   : perr_dma  <= p_edma_queues < 32'd14;
        `gem_receive_q14_ptr      : perr_dma  <= p_edma_queues < 32'd15;
        `gem_transmit_q14_ptr     : perr_dma  <= p_edma_queues < 32'd15;
        `gem_dma_rxbuf_size_q14   : perr_dma  <= p_edma_queues < 32'd15;
        `gem_receive_q15_ptr      : perr_dma  <= p_edma_queues < 32'd16;
        `gem_transmit_q15_ptr     : perr_dma  <= p_edma_queues < 32'd16;
        `gem_dma_rxbuf_size_q15   : perr_dma  <= p_edma_queues < 32'd16;
        `gem_wd_counter           : perr_dma  <= 1'b0;
        `gem_rsc_control          : perr_dma  <= (p_edma_rsc == 0) || (p_edma_axi == 0);
        `gem_pbuf_txcutthru       : perr_dma  <= p_edma_tx_pkt_buffer == 1'b0;
        `gem_pbuf_rxcutthru       : perr_dma  <= p_edma_rx_pkt_buffer == 1'b0;
        `gem_rx_water_mark        : perr_dma  <= p_edma_rx_pkt_buffer == 1'b0;
        `gem_dma_addr_or_mask     : perr_dma  <= p_edma_rx_pkt_buffer == 1'b0;
        `gem_dpram_fill_dbg       : perr_dma  <= p_edma_tx_pkt_buffer == 1'b0;
        `gem_tx_q_seg_alloc_q07   : perr_dma  <= (p_edma_tx_pkt_buffer == 1'b0);
        `gem_tx_q_seg_alloc_q8f   : perr_dma  <= (p_edma_tx_pkt_buffer == 1'b0) || (p_edma_queues < 32'd9);
        `gem_tx_bd_control        : perr_dma  <= (p_edma_tx_pkt_buffer == 1'b0) || (p_edma_tsu == 1'b0);
        `gem_rx_bd_control        : perr_dma  <= (p_edma_rx_pkt_buffer == 1'b0) || (p_edma_tsu == 1'b0);
        `gem_upper_tx_q_base_addr : perr_dma  <= (p_edma_addr_width != 32'd64);
        `gem_upper_rx_q_base_addr : perr_dma  <= (p_edma_addr_width != 32'd64);
        `gem_axi_max_pipeline       : perr_dma  <= p_edma_axi == 1'b0;
        `gem_axi_tx_full_threshold0 : perr_dma  <= p_edma_axi == 1'b0;
        `gem_axi_tx_full_threshold1 : perr_dma  <= p_edma_axi == 1'b0;
        `gem_axi_qos_cfg0           : perr_dma  <= (p_edma_axi == 1'b0);
        `gem_axi_qos_cfg1           : perr_dma  <= (p_edma_axi == 1'b0) || (p_edma_queues < 32'd5);
        `gem_axi_qos_cfg2           : perr_dma  <= (p_edma_axi == 1'b0) || (p_edma_queues < 32'd9);
        `gem_axi_qos_cfg3           : perr_dma  <= (p_edma_axi == 1'b0) || (p_edma_queues < 32'd13);
        default                     : perr_dma  <= 1'b1;  // No match for this module
      endcase
    else
      perr_dma  <= 1'b0;
  end


  // Output decodes
  assign rx_dma_buffer_offset = network_config[15:14];

  assign endian_swap    = dma_config_func[7:6];

  // The address bus width setting is a combination of hardware configuration
  // and software programming.
  assign dma_addr_bus_width = dma_addr_bus_width_1 & gem_dma_addr_width_is_64b;


  // Optional parity protection
  generate if (p_edma_asf_csr_prot == 1) begin : gen_par
    wire [2:0]  dma_config_par;
    reg         dma_config_par_r_0;
    reg         rst_count_par;
    wire        dma_cmn_par_err;  // Parity error of DMA common registers
    reg         dma_par_err_r;

    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
      begin
        dma_config_par_r_0  <= ^{p_edma_endian_swap_def,1'b0,5'h04};
        rst_count_par       <= 1'b1;
      end
      else if (write_registers)
      begin
        if (i_paddr == `gem_dma_config)
          dma_config_par_r_0  <= pwdata_par[0];
        if (i_paddr == `gem_wd_counter)
          rst_count_par       <= ^pwdata[3:0];
      end
    end
    assign dma_config_par[0] = dma_config_par_r_0;

    if (p_edma_tx_pkt_buffer == 1) begin : gen_par_pkt_buff
      reg   [1:0] dma_config_par_r_3_1;
      // Store associated parity
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          dma_config_par_r_3_1  <= {1'b0,
                                  ^{5'h00,p_edma_tx_pbuf_size_def,p_edma_rx_pbuf_size_def}};
        end
        else if (write_registers)
        begin
          if (i_paddr == `gem_dma_config)
            dma_config_par_r_3_1  <= {pwdata_par[3],pwdata_par[1]};
        end
      end
      assign dma_config_par[2:1] = dma_config_par_r_3_1;
    end else begin : gen_no_par_pkt_buff
      assign dma_config_par[2:1] = 2'b00;
    end


    // Check the parity constantly
    cdnsdru_asf_parity_check_v1 #(.p_data_width(28)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    ({restart_counter_top,
                    dma_config[31:24],
                    dma_config[15:0]}),
      .parity_in  ({rst_count_par,
                    dma_config_par}),
      .parity_err (dma_cmn_par_err)
    );

    // Combine and register parity check results
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        dma_par_err_r <= 1'b0;
      else
        dma_par_err_r <= (|dma_q_par_err)       |
                          dma_cmn_par_err       |
                          rsc_par_err           |
                          axi_par_err           |
                          pbuf_rx_par_err       |
                          pbuf_tx_par_err;
    end
    assign dma_par_err  = dma_par_err_r;
  end
  else begin : gen_no_par
    assign dma_par_err  = 1'b0;
  end
  endgenerate

endmodule
