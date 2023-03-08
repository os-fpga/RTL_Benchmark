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
//   Filename:           gem_reg_int_sts.v
//   Module Name:        gem_reg_int_sts
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
//   Description    : Contains all interrupts and tx/rx status registers for GEM.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_int_sts (
  input               pclk,                   // APB clock
  input               n_preset,               // Active low reset
  input       [11:0]  i_paddr,                // Full APB address
  input               psel,                   // APB select
  input               write_registers,        // write to apb registers.
  input               read_registers,         // read from apb registers.
  input       [31:0]  pwdata,                 // APB write data
  input               gigabit,                // Operating 1/2.5G mode
  input               disable_tx_pclk,        // disable TX due to major error
  input               disable_rx_pclk,        // disable RX due to major error
  input               ext_interrupt_pclk,     // pclk pulse indicating a
                                              // rising edge on ext interrupt pin.
  input               tx_frame_too_large_pclk,// TX AXI frame too large for SRAM
  input               link_fault_signal_en,   // 802.3cb link fault signalling enabled
  input       [1:0]   link_fault_status_pclk, // Link Fault Signalling
  input               pcs_link_state,         // current link state of PCS
  input               pcs_an_complete,        // PCS autonegotiation complete
  input               np_data_int,            // Next page data required
  input               tx_late_col_pclk,       // pclk pulse on late collision frame.
  input               tx_go_pclk,             // tx_go from DMA resynced to pclk.
  input               tx_ok_pclk,             // pclk pulse for frame txed OK
  input               tx_ok_mod_pclk,         // moderated pclk pulse for frame txed OK
  input               rx_ok_pclk,             // pclk pulse for frame rxed OK
  input               rx_ok_mod_pclk,         // moderated pclk pulse for frame rxed OK
  input               tx_coll_occ_pclk,       // pclk pulse if frame had a collision
  input               tx_toomanyretry_pclk,   // pclk pulse if frame had too many retries.
  input               tx_pause_zero_pclk,     // pclk pulse when pause timer reaches
                                              // zero or zero pause frame rxed.
  input               tx_pause_ok_pclk,       // pclk pulse for 802.3 pause frame txed OK
  input               tx_pfc_pause_ok_pclk,   // pclk pulse for PFC pause frame txed OK
  input               tx_underrun_pclk,       // pclk pulse when tx underrun occured
  input               tx_buffers_ex_pclk,     // pclk pulse when tx buffers are exhausted.
  input               tx_buff_ex_mid_pclk,    // pclk pulse when tx buffers are
                                              // exhausted mid frame.
  input               tx_hresp_notok_pclk,    // pclk pulse when hresp not OK
                                              // happened during TX DMA.
  input               rx_hresp_notok_pclk,    // pclk pulse when the RX pipeline or
                                              // FIFO overflowed due to bandwidth.
  input               rx_buff_not_rdy_pclk,   // pclk pulse when used bit was read
                                              // during RX DMA operation.
  input               rx_dma_overrun_pclk,    // DMA RX overflow
  input       [3:0]   tx_dma_int_queue,       // Identifies which queue the
  input       [3:0]   rx_dma_int_queue,       // interrupt is destined for
  input               man_done,               // PHY management done
  input               dma_tx_lockup_detected, // Lockup detected signals
  input               dma_rx_lockup_detected,
  input               tx_lockup_detected,
  input               rx_lockup_detected,

  input               timer_cmp_val_int,      // TSU timer comparison valid interrut
  input               tsu_incr_sec_int,       // Timer seconds increment
  input               ptp_sync_tx_int,        // PTP sync frame transmit interrupt
  input               ptp_del_tx_int,         // PTP delay_req frame transmit interrupt
  input               ptp_pdel_req_tx_int,    // PTP pdelay_req transmit interrupt
  input               ptp_pdel_resp_tx_int,   // PTP pdelay_resp frame transmit interrupt
  input               ptp_sync_rx_int,        // PTP sync frame receive interrupt
  input               ptp_del_rx_int,         // PTP delay_req frame receive interrupt
  input               ptp_pdel_req_rx_int,    // PTP pdelay_req receive interrupt
  input               ptp_pdel_resp_rx_int,   // PTP pdelay_resp frame receive interrupt
  input               wol_pulse,              // wake on LAN indication pclk synced
  input               lpi_indicate_pclk,      // LPI detected
  input               lpi_indicate_del,       // Delayed for edge detection
  input               rx_pause_nz_pclk,       // pclk pulse for 802.3
                                              // pause frame with non-zero quantum
                                              // or any type of PFC pause frame
                                              // rxed OK.
  output  reg [31:0]  int_moderation,         // interrupt moderation register value
  output  reg [31:0]  prdata_ints,            // Read data (combinatorial)
  output  reg         perr_ints,              // Similarly perr signal (reg)
  output      [15:0]  ethernet_int            // ethernet MAC interrupt signal, 1 per queue

);

  parameter p_edma_irq_read_clear     = 1'b0;
  parameter p_edma_tx_pkt_buffer      = 1'b1;
  parameter p_edma_rx_pkt_buffer      = 1'b1;
  parameter p_edma_queues             = 32'd1;
  parameter p_edma_tsu                = 1'b1;
  parameter p_edma_axi                = 1'b1;
  parameter p_edma_has_pcs            = 1'b1;
  parameter p_edma_ext_fifo_interface = 1'b0;
  parameter p_has_dma                 = (p_edma_ext_fifo_interface == 1'b0);

  // Define interrupt bits which actually exists
  parameter p_int_exists  = {
                              2'b11,                    // 31:30
                              (p_edma_tsu == 1),        // 29
                              2'b11,                    // 28:27
                              (p_edma_tsu == 1),        // 26
                              8'b11111111,              // 25:18
                              (p_edma_has_pcs == 1),    // 17
                              (p_edma_has_pcs == 1),    // 16
                              4'b1111,                  // 15:12
                              (p_has_dma == 1),         // 11
                              1'b1,                     // 10
                              (p_edma_has_pcs == 1),    // 9
                              1'b0,                     // 8 Reserved
                              1'b1,                     // 7
                              (p_has_dma == 1),         // 6
                              2'b11,                    // 5:4
                              (p_has_dma == 1),         // 3
                              (p_has_dma == 1),         // 2
                              2'b11                     // 1:0
                            };
  // Similarly for queues 1 to 15
  parameter p_intq_exists = {
                              20'h00000,                // 31:12
                              1'b1,                     // 11
                              1'b0,                     // 10
                              2'b00,                    // 9:8
                              3'b111,                   // 7:5
                              2'b00,                    // 4:3
                              2'b11,                    // 2:1
                              1'b0                      // 0
                            };

  // Internal signals
  wire  [31:0]      int_trigger_q0;     // Interrupt sources for queue 0.
  wire  [31:0]      int_mask[15:0];     // Interrupt mask register for all queues
  wire  [31:0]      int_status[15:0];   // Interrupt status register for all queues
  wire  [15:0]      write_int_ena;      // Write to interrupt enable reg for all queue
  wire  [15:0]      write_int_dis;      // Write to interrupt disable reg for all queue
  wire  [15:0]      write_int_mask;     // Write to interrupt mask reg for all queues
  wire  [15:0]      acc_int_status;     // Access interrupt status reg for all queues
  wire              write_tx_status;    // apb write to tx status registers.
  wire              write_rx_status;    // apb write to rx status registers.
  wire              int_bit5_src;       // Too many retries, common for all queues
  wire              lpi_indicate_pulse; // pulse when lpi_indicate changes
  reg               man_done_last;      // Delay for interrupt generation

  // Transmit Status Register
  wire          dma_tx_lockup_detected_status;  // bit 10 in tx status register.
  reg           tx_lockup_detected_status;  // bit 9 in tx status register.
  wire          tx_hresp_status;            // bit 8 in tx status register.
  reg           late_coll_status;           // bit 7 in tx status register.
  reg           tx_underrun_status;         // bit 6 in tx status register.
  reg           tx_frm_comp_status;         // bit 5 in tx status register.
  wire          tx_buf_ex_mid_status;       // bit 4 in tx status register.
  reg           too_many_ret_status;        // bit 2 in tx status register.
  reg           coll_occured_status;        // bit 1 in tx status register.
  wire          tx_buff_exh_status;         // bit 0 in tx status register.

  // Receive status Register
  wire          dma_rx_lockup_detected_status;  // bit 5 in rx status register.
  reg           rx_lockup_detected_status;  // bit 4 in rx status register.
  wire          rx_hresp_status;            // bit 3 in rx status register.
  reg           rx_overrun_status;          // bit 2 in rx status register.
  reg           rx_frm_comp_status;         // bit 1 in rx status register.
  wire          rx_buf_notrdy_status;       // bit 0 in rx status register.
  wire          link_change_pclk;           // Change in PCS link state

  // Lockup detection
  wire          tx_lockup_detected_re;      // Rising edge detection
  wire          rx_lockup_detected_re;      // Rising edge detection
  wire          dma_tx_lockup_detected_re;  // Rising edge detection
  wire          dma_rx_lockup_detected_re;  // Rising edge detection


  // Decode APB write access to status registers
  assign write_tx_status      = write_registers &
                                (i_paddr == `gem_transmit_status);

  assign write_rx_status      = write_registers &
                                (i_paddr == `gem_receive_status);

  // generate pulse for every transition
  assign lpi_indicate_pulse = lpi_indicate_pclk ^ lpi_indicate_del;


  generate if (p_edma_has_pcs == 1) begin : gen_has_pcs
    // link_fault_status
    // For 2.5GBASE-X operation these two bits return the state of link_fault in the LFSM defined in Figure 46-11 of IEEE 802.3.
    // 00  OK
    // 01  local fault
    // 10  remote fault
    // 11  link interruption

    // detect change in link state of PCS for interrupt status
    reg         [2:0] pcs_link_state_del; // Delayed PCS link state
    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
        pcs_link_state_del  <= 3'b000;
      else
        pcs_link_state_del  <= {link_fault_status_pclk,pcs_link_state};
    end
    assign link_change_pclk = (link_fault_signal_en) ? (link_fault_status_pclk[0] ^ pcs_link_state_del[1]) |
                                                       (link_fault_status_pclk[1] ^ pcs_link_state_del[2])
                                                     : (pcs_link_state ^ pcs_link_state_del[0]);
  end
  else
  begin : gen_no_pcs
    assign link_change_pclk = 1'b0;
  end
  endgenerate

  // used to generate interrupt on rising edge.
  always@(posedge pclk or negedge n_preset)
  begin
    if(~n_preset)
      man_done_last <= 1'b1;
    else
      man_done_last <= man_done;
  end


  // Edge detect for lockup signalling
  edma_toggle_detect i_edma_toggle_detect_tx_lockup_re (
    .clk      (pclk),
    .reset_n  (n_preset),
    .din      (tx_lockup_detected),
    .rise_edge(tx_lockup_detected_re),
    .fall_edge(),
    .any_edge ()
  );
  edma_toggle_detect i_edma_toggle_detect_rx_lockup_re (
    .clk      (pclk),
    .reset_n  (n_preset),
    .din      (rx_lockup_detected),
    .rise_edge(rx_lockup_detected_re),
    .fall_edge(),
    .any_edge ()
  );

  // Lockup detection for DMA only exists if packet buffer mode
  generate
  if (p_edma_rx_pkt_buffer == 1) begin : gen_rx_pbuf_sts

    reg   dma_rx_lockup_status;

    // Rising edge detect status signal from lockup detection
    edma_toggle_detect i_edma_toggle_detect_dma_rx_lockup_re (
      .clk      (pclk),
      .reset_n  (n_preset),
      .din      (dma_rx_lockup_detected),
      .rise_edge(dma_rx_lockup_detected_re),
      .fall_edge(),
      .any_edge ()
    );

    // this sets bit 5 in the receive status register when a lockup detected on RX
    // Cleared by writing a 1 to this bit.
    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        dma_rx_lockup_status <= 1'b0;
      else
        dma_rx_lockup_status <= dma_rx_lockup_detected_re |
                                 (dma_rx_lockup_status &
                                 ~(write_rx_status & pwdata[5]));
    end
    assign dma_rx_lockup_detected_status = dma_rx_lockup_status;
  end else begin : gen_no_rx_pbuf_sts
    assign dma_rx_lockup_detected_re      = 1'b0;
    assign dma_rx_lockup_detected_status  = 1'b0;
  end
  if (p_edma_tx_pkt_buffer == 1) begin : gen_tx_pbuf_sts

    reg   dma_tx_lockup_status;

    // Rising edge detect status signal from lockup detection
    edma_toggle_detect i_edma_toggle_detect_dma_tx_lockup_re (
      .clk      (pclk),
      .reset_n  (n_preset),
      .din      (dma_tx_lockup_detected),
      .rise_edge(dma_tx_lockup_detected_re),
      .fall_edge(),
      .any_edge ()
    );

    // this sets bit 10 in the transmit status register when a lockup detected on TX
    // Cleared by writing a 1 to this bit.
    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        dma_tx_lockup_status <= 1'b0;
      else
        dma_tx_lockup_status <= dma_tx_lockup_detected_re |
                                 (dma_tx_lockup_status &
                                 ~(write_tx_status & pwdata[10]));
    end
    assign dma_tx_lockup_detected_status = dma_tx_lockup_status;
  end else begin : gen_no_tx_pbuf_sts
    assign dma_tx_lockup_detected_re  = 1'b0;
    assign dma_tx_lockup_detected_status  = 1'b0;
  end
  endgenerate


  // too many retries interrupt bit in interrupt status register.
  assign int_bit5_src = (tx_toomanyretry_pclk | (tx_late_col_pclk & gigabit));

  // Assign available interrupt triggers for queue 0.
  assign int_trigger_q0[31] = tx_lockup_detected_re | dma_tx_lockup_detected_re;
  assign int_trigger_q0[30] = rx_lockup_detected_re | dma_rx_lockup_detected_re;
  assign int_trigger_q0[29] = timer_cmp_val_int;
  assign int_trigger_q0[28] = wol_pulse;
  assign int_trigger_q0[27] = lpi_indicate_pulse;
  assign int_trigger_q0[26] = tsu_incr_sec_int;
  assign int_trigger_q0[25] = ptp_pdel_resp_tx_int;
  assign int_trigger_q0[24] = ptp_pdel_req_tx_int;
  assign int_trigger_q0[23] = ptp_pdel_resp_rx_int;
  assign int_trigger_q0[22] = ptp_pdel_req_rx_int;
  assign int_trigger_q0[21] = ptp_sync_tx_int;
  assign int_trigger_q0[20] = ptp_del_tx_int;
  assign int_trigger_q0[19] = ptp_sync_rx_int;
  assign int_trigger_q0[18] = ptp_del_rx_int;
  assign int_trigger_q0[17] = np_data_int;
  assign int_trigger_q0[16] = pcs_an_complete;
  assign int_trigger_q0[15] = ext_interrupt_pclk;
  assign int_trigger_q0[14] = tx_pause_ok_pclk | tx_pfc_pause_ok_pclk;
  assign int_trigger_q0[13] = tx_pause_zero_pclk;
  assign int_trigger_q0[12] = rx_pause_nz_pclk;
  assign int_trigger_q0[11] = (p_edma_axi == 1) ? (disable_rx_pclk | disable_tx_pclk)
                                                : ((rx_dma_int_queue == 4'd0) & rx_hresp_notok_pclk) |
                                                  ((tx_dma_int_queue == 4'd0) & tx_hresp_notok_pclk);
  assign int_trigger_q0[10] = rx_dma_overrun_pclk;
  assign int_trigger_q0[9]  = link_change_pclk;
  assign int_trigger_q0[8]  = 1'b0;
  assign int_trigger_q0[7]  = tx_ok_mod_pclk & (tx_dma_int_queue == 4'd0 | int_moderation[23:16] != 8'd0);
  assign int_trigger_q0[6]  = (p_edma_axi == 1 & (disable_tx_pclk | tx_buff_ex_mid_pclk | tx_frame_too_large_pclk)) |
                              (tx_buff_ex_mid_pclk & tx_dma_int_queue == 4'd0);
  assign int_trigger_q0[5]  = int_bit5_src & tx_dma_int_queue == 4'd0;
  assign int_trigger_q0[4]  = tx_underrun_pclk;
  assign int_trigger_q0[3]  = tx_buffers_ex_pclk;
  assign int_trigger_q0[2]  = rx_buff_not_rdy_pclk & (rx_dma_int_queue == 4'd0);
  assign int_trigger_q0[1]  = rx_ok_mod_pclk & (rx_dma_int_queue == 4'd0 | int_moderation[7:0] != 8'd0);
  assign int_trigger_q0[0]  = man_done & ~man_done_last;

  assign write_int_ena[0]   = write_registers & (i_paddr == `gem_int_enable);
  assign write_int_dis[0]   = write_registers & (i_paddr == `gem_int_disable);
  assign write_int_mask[0]  = write_registers & (i_paddr == `gem_int_mask);
  assign acc_int_status[0]  = (i_paddr == `gem_int_status);

  // Address decoding for queues 1-15
  generate
    genvar loop_1;
    genvar loop_2;
    for (loop_1 = 1; loop_1 < 8; loop_1 = loop_1 + 1)
    begin : gen_dec_1_7
      assign write_int_ena[loop_1]  = write_registers & (i_paddr == (`gem_int_q1_enable - 12'h004 + ({loop_1[9:0],2'b00})));
      assign write_int_dis[loop_1]  = write_registers & (i_paddr == (`gem_int_q1_disable - 12'h004 + ({loop_1[9:0],2'b00})));
      assign write_int_mask[loop_1] = write_registers & (i_paddr == (`gem_int_q1_mask - 12'h004 + ({loop_1[9:0],2'b00})));
      assign acc_int_status[loop_1] = (i_paddr == (`gem_int_q1_status - 12'h004 + ({loop_1[9:0],2'b00})));
    end

    // Split into two parts as address map is split.
    for (loop_2 = 0; loop_2 < 8; loop_2 = loop_2 + 1)
    begin : gen_dec_8_15
      assign write_int_ena[8+loop_2]  = write_registers & (i_paddr == (`gem_int_q8_enable + ({loop_2[9:0],2'b00})));
      assign write_int_dis[8+loop_2]  = write_registers & (i_paddr == (`gem_int_q8_disable + ({loop_2[9:0],2'b00})));
      assign write_int_mask[8+loop_2] = write_registers & (i_paddr == (`gem_int_q8_mask + ({loop_2[9:0],2'b00})));
      assign acc_int_status[8+loop_2] = (i_paddr == (`gem_int_q8_status + ({loop_2[9:0],2'b00})));
    end
  endgenerate

  // APB register writes
  always @(posedge pclk or negedge n_preset)
  begin : p_write_register //begin p_write_register
    if (~n_preset)
    begin
      int_moderation <= 32'd0;
    end
    else
      if (write_registers) // begin if (write_registers)
      begin
        case (i_paddr)
          `gem_int_moderation :
          begin
            int_moderation <= pwdata;
          end
          default : ;
        endcase
      end
  end

  // Generate interrupt bits for queue 0.
  generate
    genvar        loop_int;
    wire  [31:0]  int_status_q0;
    wire  [31:0]  int_mask_q0;
    for (loop_int = 0; loop_int < 32; loop_int = loop_int + 1)
    begin : gen_int_q0
      if (p_int_exists[loop_int])
      begin : gen_int
        gem_reg_int #(.p_edma_irq_read_clear(p_edma_irq_read_clear)) i_int (
          .pclk             (pclk),
          .n_preset         (n_preset),
          .write_int_ena    (write_int_ena[0]),
          .write_int_dis    (write_int_dis[0]),
          .write_int_mask   (write_int_mask[0]),
          .write_int_status (acc_int_status[0] & write_registers),
          .read_int_status  (acc_int_status[0] & read_registers),
          .int_trigger      (int_trigger_q0[loop_int]),
          .pwdata           (pwdata[loop_int]),
          .int_mask         (int_mask_q0[loop_int]),
          .int_status       (int_status_q0[loop_int])
        );
      end
      else
      begin : gen_no_int
        assign int_status_q0[loop_int]  = 1'b0;
        assign int_mask_q0[loop_int]    = 1'b0;
      end
    end
    assign int_status[0]      = int_status_q0;
    assign int_mask[0]        = int_mask_q0;
    assign ethernet_int[0]    = |int_status_q0;
  endgenerate

  // Generate interrupts for remaining queues if they exist.
  genvar  loop_nq;
  generate
    if(p_edma_queues > 32'd1) begin: gen_remaining_queues
      genvar  loop_q;
      genvar  loop_intq;
      for (loop_q = 1; loop_q < p_edma_queues[4:0]; loop_q = loop_q + 1)
      begin : gen_int_q
        wire  [31:0]  int_trigger;
        wire  [31:0]  int_status_q;
        wire  [31:0]  int_mask_q;

        assign int_trigger[31:12] = 20'h00000;
        assign int_trigger[11]    = ((rx_dma_int_queue == loop_q[3:0]) & rx_hresp_notok_pclk) |
                                    ((tx_dma_int_queue == loop_q[3:0]) & tx_hresp_notok_pclk);
        assign int_trigger[10:8]  = 3'b000;
        assign int_trigger[7]     = tx_ok_pclk & (tx_dma_int_queue == loop_q[3:0]);
        assign int_trigger[6]     = tx_buff_ex_mid_pclk & (tx_dma_int_queue == loop_q[3:0]);
        assign int_trigger[5]     = int_bit5_src & (tx_dma_int_queue == loop_q[3:0]);
        assign int_trigger[4:3]   = 2'b00;
        assign int_trigger[2]     = rx_buff_not_rdy_pclk & (rx_dma_int_queue == loop_q[3:0]);
        assign int_trigger[1]     = rx_ok_pclk & (rx_dma_int_queue == loop_q[3:0]);
        assign int_trigger[0]     = 1'b0;

        for (loop_intq = 0; loop_intq < 32; loop_intq = loop_intq + 1)
        begin : gen_int_q
          if (p_intq_exists[loop_intq])
          begin : gen_int
            gem_reg_int #(.p_edma_irq_read_clear(p_edma_irq_read_clear)) i_int_q (
              .pclk             (pclk),
              .n_preset         (n_preset),
              .write_int_ena    (write_int_ena[loop_q]),
              .write_int_dis    (write_int_dis[loop_q]),
              .write_int_mask   (write_int_mask[loop_q]),
              .write_int_status (acc_int_status[loop_q] & write_registers),
              .read_int_status  (acc_int_status[loop_q] & read_registers),
              .int_trigger      (int_trigger[loop_intq]),
              .pwdata           (pwdata[loop_intq]),
              .int_mask         (int_mask_q[loop_intq]),
              .int_status       (int_status_q[loop_intq])
            );
          end
          else
          begin : gen_no_int
            assign int_status_q[loop_intq]  = 1'b0;
            assign int_mask_q[loop_intq]    = 1'b0;
          end
        end
        assign int_status[loop_q]   = int_status_q;
        assign int_mask[loop_q]     = int_mask_q;
        assign ethernet_int[loop_q] = |int_status_q;
      end
    end
    // Fill in non-existant queues
    if(p_edma_queues<32'd16) begin: gen_int_nq
      for (loop_nq = p_edma_queues; loop_nq < 16; loop_nq = loop_nq + 1)
      begin : gen_loop
        assign int_status[loop_nq]      = 32'h00000000;
        assign int_mask[loop_nq]        = 32'h00000000;
        assign ethernet_int[loop_nq]    = 1'b0;
      end
    end
  endgenerate


  //------------------------------------------------------------------------------
  // Transmit status register
  //------------------------------------------------------------------------------

  // this sets bit 9 in the transmit status register when a lockup detected on TX
  // Cleared by writing a 1 to this bit.
  always@(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      tx_lockup_detected_status <= 1'b0;
    else
      tx_lockup_detected_status <= tx_lockup_detected_re |
                                  (tx_lockup_detected_status &
                                  ~(write_tx_status & pwdata[9]));
  end

  // DMA specific TX Status registers
  generate if (p_has_dma == 1) begin : gen_dma_tx_sts
    reg tx_hresp_status_r;
    reg tx_buf_ex_mid_status_r;
    reg tx_buff_exh_status_r;

    // this sets bit 8 in the transmit status register when a AHB hresp
    // error is seen during TX DMA.
    // Cleared by writing a 1 to this bit.
    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        tx_hresp_status_r <= 1'b0;
      else
        tx_hresp_status_r <= ((p_edma_axi == 1 && disable_tx_pclk) ||
                            ((tx_hresp_notok_pclk |
                            (tx_hresp_status_r & ~(write_tx_status & pwdata[8])))));
    end
    // this sets bit 4 in the transmit status register when a the transmit
    // buffers are mid frame exhausted. Cleared by writing a 1 to this bit.
    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        tx_buf_ex_mid_status_r <= 1'b0;
      else
        tx_buf_ex_mid_status_r <= tx_buff_ex_mid_pclk |
                                  (tx_frame_too_large_pclk && p_edma_axi == 1) |
                                  (disable_tx_pclk && p_edma_axi == 1) |
                                  (tx_buf_ex_mid_status_r &
                                  ~(write_tx_status & pwdata[4]));
    end
    // this sets bit 0 in the transmit status register when a the transmit
    // buffers are exhausted. Cleared by writing a 1 to this bit.
    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        tx_buff_exh_status_r <= 1'b0;
      else
        tx_buff_exh_status_r <= tx_buffers_ex_pclk |
                                (tx_buff_exh_status_r &
                                  ~(write_tx_status & pwdata[0]));
    end
    assign tx_hresp_status      = tx_hresp_status_r;
    assign tx_buf_ex_mid_status = tx_buf_ex_mid_status_r;
    assign tx_buff_exh_status   = tx_buff_exh_status_r;
  end
  else
  begin : gen_no_dma_tx_sts
    assign tx_hresp_status      = 1'b0;
    assign tx_buf_ex_mid_status = 1'b0;
    assign tx_buff_exh_status   = 1'b0;
  end
  endgenerate

  // this sets bit 7 in the transmit status register when a late
  // collision occurs in gigabit mode only.
  // Cleared by writing a 1 to this bit.
  always@(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      late_coll_status <= 1'b0;
    else
      late_coll_status <= (tx_late_col_pclk & gigabit) |
                          (late_coll_status &
                          ~(write_tx_status & pwdata[7]));
  end

  // this sets bit 6 in the transmit status register when frame
  // transmission is aborted due to a failure of the tx fifo
  // to read from memory in time. Cleared by writing a 1 to this bit.
  always@(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      tx_underrun_status <= 1'b0;
    else
      tx_underrun_status <= tx_underrun_pclk |
                              (tx_underrun_status &
                                ~(write_tx_status & pwdata[6]));
  end

  // this sets bit 5 in the transmit status register when a frame
  // has been transmitted. Cleared by writing a 1 to this bit.
  always@(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      tx_frm_comp_status <= 1'b0;
    else
      tx_frm_comp_status <= tx_ok_pclk |
                              (tx_frm_comp_status & ~
                                (write_tx_status & pwdata[5]));
  end


  // this sets bit 2 in the transmit status register when frame
  // transmission is aborted due to too many retries.
  // Cleared by writing a 1 to this bit.
  always@(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      too_many_ret_status <= 1'b0;
    else
      too_many_ret_status <= tx_toomanyretry_pclk |
                              (too_many_ret_status &
                                ~(write_tx_status & pwdata[2]));
  end

  // this sets bit 1 in the transmit status register when a collision occurs.
  // Cleared by writing a 1 to this bit.
  always@(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      coll_occured_status <= 1'b0;
    else
      coll_occured_status <= tx_coll_occ_pclk |
                              (coll_occured_status &
                                ~(write_tx_status & pwdata[1]));
  end


  //------------------------------------------------------------------------------
  // Receive status register
  //------------------------------------------------------------------------------

  // this sets bit 4 in the receive status register when a lockup detected on RX
  // Cleared by writing a 1 to this bit.
  always@(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_lockup_detected_status <= 1'b0;
    else
      rx_lockup_detected_status <= rx_lockup_detected_re |
                                    (rx_lockup_detected_status &
                                    ~(write_rx_status & pwdata[4]));
  end

  // DMA specific RX status registers
  generate if (p_has_dma == 1) begin : gen_dma_rx_sts
    reg rx_hresp_status_r;
    reg rx_buf_notrdy_status_r;
    // this sets bit 3 in the receive status register when an AHB hresp
    // error is received during RX DMA
    // Cleared by writing a 1 to this bit.
    // In AXI mode, hresp is set by disable_rx_pclk not rx_hresp_notok_pclk
    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        rx_hresp_status_r <= 1'b0;
      else
        rx_hresp_status_r <= ((p_edma_axi == 1 && disable_rx_pclk) ||
                            ((rx_hresp_notok_pclk |
                              (rx_hresp_status_r & ~(write_rx_status & pwdata[3])))));

    end
    // this sets bit 0 in the receive status register when there are no more
    // receive buffers available.
    // Cleared by writing a 1 to this bit.
    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        rx_buf_notrdy_status_r <= 1'b0;
      else
        rx_buf_notrdy_status_r <= rx_buff_not_rdy_pclk |
                                  (rx_buf_notrdy_status_r &
                                    ~(write_rx_status & pwdata[0]));
    end
    assign rx_hresp_status      = rx_hresp_status_r;
    assign rx_buf_notrdy_status = rx_buf_notrdy_status_r;
  end
  else
  begin : gen_no_dma_rx_sts
    assign rx_hresp_status      = 1'b0;
    assign rx_buf_notrdy_status = 1'b0;
  end
  endgenerate

  // this sets bit 2 in the receive status register when receive data dma
  // cannot complete in time.
  // Cleared by writing a 1 to this bit.
  always@(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_overrun_status <= 1'b0;
    else
      rx_overrun_status <= rx_dma_overrun_pclk |
                            (rx_overrun_status &
                              ~(write_rx_status & pwdata[2]));
  end

  // this sets bit 1 in the receive status register when a frame is received.
  // Cleared by writing a 1 to this bit.
  always@(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      rx_frm_comp_status <= 1'b0;
    else
      rx_frm_comp_status <= rx_ok_pclk |
                              (rx_frm_comp_status &
                                ~(write_rx_status & pwdata[1]));
  end


  //------------------------------------------------------------------------------
  // APB read of interrupts and status registers.
  //------------------------------------------------------------------------------

  // The prdata_ints should be registered externally.
  always @(*)
  begin
    if (read_registers)
      case (i_paddr)
        `gem_transmit_status  : prdata_ints = {21'd0,
                                               dma_tx_lockup_detected_status,
                                               tx_lockup_detected_status,
                                               tx_hresp_status,
                                               late_coll_status,
                                               tx_underrun_status,
                                               tx_frm_comp_status,
                                               tx_buf_ex_mid_status,
                                               tx_go_pclk,
                                               too_many_ret_status,
                                               coll_occured_status,
                                               tx_buff_exh_status};
        `gem_receive_status : prdata_ints = {26'd0,
                                               dma_rx_lockup_detected_status,
                                               rx_lockup_detected_status,
                                               rx_hresp_status,
                                               rx_overrun_status,
                                               rx_frm_comp_status,
                                               rx_buf_notrdy_status};
        `gem_int_status     : prdata_ints = int_status[0];
        `gem_int_q1_status  : prdata_ints = int_status[1];
        `gem_int_q2_status  : prdata_ints = int_status[2];
        `gem_int_q3_status  : prdata_ints = int_status[3];
        `gem_int_q4_status  : prdata_ints = int_status[4];
        `gem_int_q5_status  : prdata_ints = int_status[5];
        `gem_int_q6_status  : prdata_ints = int_status[6];
        `gem_int_q7_status  : prdata_ints = int_status[7];
        `gem_int_q8_status  : prdata_ints = int_status[8];
        `gem_int_q9_status  : prdata_ints = int_status[9];
        `gem_int_q10_status : prdata_ints = int_status[10];
        `gem_int_q11_status : prdata_ints = int_status[11];
        `gem_int_q12_status : prdata_ints = int_status[12];
        `gem_int_q13_status : prdata_ints = int_status[13];
        `gem_int_q14_status : prdata_ints = int_status[14];
        `gem_int_q15_status : prdata_ints = int_status[15];
        `gem_int_mask       : prdata_ints = int_mask[0];
        `gem_int_q1_mask    : prdata_ints = int_mask[1];
        `gem_int_q2_mask    : prdata_ints = int_mask[2];
        `gem_int_q3_mask    : prdata_ints = int_mask[3];
        `gem_int_q4_mask    : prdata_ints = int_mask[4];
        `gem_int_q5_mask    : prdata_ints = int_mask[5];
        `gem_int_q6_mask    : prdata_ints = int_mask[6];
        `gem_int_q7_mask    : prdata_ints = int_mask[7];
        `gem_int_q8_mask    : prdata_ints = int_mask[8];
        `gem_int_q9_mask    : prdata_ints = int_mask[9];
        `gem_int_q10_mask   : prdata_ints = int_mask[10];
        `gem_int_q11_mask   : prdata_ints = int_mask[11];
        `gem_int_q12_mask   : prdata_ints = int_mask[12];
        `gem_int_q13_mask   : prdata_ints = int_mask[13];
        `gem_int_q14_mask   : prdata_ints = int_mask[14];
        `gem_int_q15_mask   : prdata_ints = int_mask[15];
        `gem_int_moderation : prdata_ints = {int_moderation};
        default             : prdata_ints = 32'h00000000;
      endcase
    else
      prdata_ints = 32'h00000000;
  end

  // Perr signal is similar to above. This is registered to match previous implementation
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      perr_ints <= 1'b0;
    else if (psel)
      case (i_paddr)
        `gem_transmit_status  : perr_ints <= 1'b0;
        `gem_receive_status   : perr_ints <= 1'b0;
        `gem_int_status       : perr_ints <= 1'b0;
        `gem_int_enable       : perr_ints <= 1'b0;
        `gem_int_disable      : perr_ints <= 1'b0;
        `gem_int_mask         : perr_ints <= 1'b0;
        `gem_int_q1_status    : perr_ints <= p_edma_queues < 32'd2;
        `gem_int_q1_enable    : perr_ints <= p_edma_queues < 32'd2;
        `gem_int_q1_disable   : perr_ints <= p_edma_queues < 32'd2;
        `gem_int_q1_mask      : perr_ints <= p_edma_queues < 32'd2;
        `gem_int_q2_status    : perr_ints <= p_edma_queues < 32'd3;
        `gem_int_q2_enable    : perr_ints <= p_edma_queues < 32'd3;
        `gem_int_q2_disable   : perr_ints <= p_edma_queues < 32'd3;
        `gem_int_q2_mask      : perr_ints <= p_edma_queues < 32'd3;
        `gem_int_q3_status    : perr_ints <= p_edma_queues < 32'd4;
        `gem_int_q3_enable    : perr_ints <= p_edma_queues < 32'd4;
        `gem_int_q3_disable   : perr_ints <= p_edma_queues < 32'd4;
        `gem_int_q3_mask      : perr_ints <= p_edma_queues < 32'd4;
        `gem_int_q4_status    : perr_ints <= p_edma_queues < 32'd5;
        `gem_int_q4_enable    : perr_ints <= p_edma_queues < 32'd5;
        `gem_int_q4_disable   : perr_ints <= p_edma_queues < 32'd5;
        `gem_int_q4_mask      : perr_ints <= p_edma_queues < 32'd5;
        `gem_int_q5_status    : perr_ints <= p_edma_queues < 32'd6;
        `gem_int_q5_enable    : perr_ints <= p_edma_queues < 32'd6;
        `gem_int_q5_disable   : perr_ints <= p_edma_queues < 32'd6;
        `gem_int_q5_mask      : perr_ints <= p_edma_queues < 32'd6;
        `gem_int_q6_status    : perr_ints <= p_edma_queues < 32'd7;
        `gem_int_q6_enable    : perr_ints <= p_edma_queues < 32'd7;
        `gem_int_q6_disable   : perr_ints <= p_edma_queues < 32'd7;
        `gem_int_q6_mask      : perr_ints <= p_edma_queues < 32'd7;
        `gem_int_q7_status    : perr_ints <= p_edma_queues < 32'd8;
        `gem_int_q7_enable    : perr_ints <= p_edma_queues < 32'd8;
        `gem_int_q7_disable   : perr_ints <= p_edma_queues < 32'd8;
        `gem_int_q7_mask      : perr_ints <= p_edma_queues < 32'd8;
        `gem_int_q8_status    : perr_ints <= p_edma_queues < 32'd9;
        `gem_int_q8_enable    : perr_ints <= p_edma_queues < 32'd9;
        `gem_int_q8_disable   : perr_ints <= p_edma_queues < 32'd9;
        `gem_int_q8_mask      : perr_ints <= p_edma_queues < 32'd9;
        `gem_int_q9_status    : perr_ints <= p_edma_queues < 32'd10;
        `gem_int_q9_enable    : perr_ints <= p_edma_queues < 32'd10;
        `gem_int_q9_disable   : perr_ints <= p_edma_queues < 32'd10;
        `gem_int_q9_mask      : perr_ints <= p_edma_queues < 32'd10;
        `gem_int_q10_status   : perr_ints <= p_edma_queues < 32'd11;
        `gem_int_q10_enable   : perr_ints <= p_edma_queues < 32'd11;
        `gem_int_q10_disable  : perr_ints <= p_edma_queues < 32'd11;
        `gem_int_q10_mask     : perr_ints <= p_edma_queues < 32'd11;
        `gem_int_q11_status   : perr_ints <= p_edma_queues < 32'd12;
        `gem_int_q11_enable   : perr_ints <= p_edma_queues < 32'd12;
        `gem_int_q11_disable  : perr_ints <= p_edma_queues < 32'd12;
        `gem_int_q11_mask     : perr_ints <= p_edma_queues < 32'd12;
        `gem_int_q12_status   : perr_ints <= p_edma_queues < 32'd13;
        `gem_int_q12_enable   : perr_ints <= p_edma_queues < 32'd13;
        `gem_int_q12_disable  : perr_ints <= p_edma_queues < 32'd13;
        `gem_int_q12_mask     : perr_ints <= p_edma_queues < 32'd13;
        `gem_int_q13_status   : perr_ints <= p_edma_queues < 32'd14;
        `gem_int_q13_enable   : perr_ints <= p_edma_queues < 32'd14;
        `gem_int_q13_disable  : perr_ints <= p_edma_queues < 32'd14;
        `gem_int_q13_mask     : perr_ints <= p_edma_queues < 32'd14;
        `gem_int_q14_status   : perr_ints <= p_edma_queues < 32'd15;
        `gem_int_q14_enable   : perr_ints <= p_edma_queues < 32'd15;
        `gem_int_q14_disable  : perr_ints <= p_edma_queues < 32'd15;
        `gem_int_q14_mask     : perr_ints <= p_edma_queues < 32'd15;
        `gem_int_q15_status   : perr_ints <= p_edma_queues < 32'd16;
        `gem_int_q15_enable   : perr_ints <= p_edma_queues < 32'd16;
        `gem_int_q15_disable  : perr_ints <= p_edma_queues < 32'd16;
        `gem_int_q15_mask     : perr_ints <= p_edma_queues < 32'd16;
        `gem_int_moderation   : perr_ints <= 1'b0;
        default               : perr_ints <= 1'b1;  // No match for this module
      endcase
    else
      perr_ints <= 1'b0;
  end


endmodule
