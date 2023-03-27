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
//   Filename:           gem_reg_tsu.v
//   Module Name:        gem_reg_tsu
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
//   Description    : Contains registers for timestamp operation
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_tsu # (
  parameter p_edma_tsu_clk        = 1'b0,
  parameter p_edma_ext_tsu_timer  = 1'b0,
  parameter p_parity_prot         = 1'b0,
  parameter p_dap_prot            = 1'b0
)(
  input               pclk,                 // APB clock
  input               n_preset,             // Active low reset
  input       [11:0]  i_paddr,              // Full APB address
  input               psel,                 // APB select
  input               write_registers,      // write to apb registers.
  input               read_registers,       // read from apb registers.
  input       [31:0]  pwdata,               // APB write data
  input       [3:0]   pwdata_par,           // Parity associated with pwdata
  input               timer_strobe,         // write timer sync strobe registers
  input               tsu_timer_cnt_pclk_vld,
  input       [77:0]  tsu_timer_cnt_pclk,   // TSU timer count value, pclk timed
  input       [77:0]  tsu_ptp_tx_timer_in,  // Timestamp synchronized to pclk
  input       [77:0]  tsu_ptp_rx_timer_in,  // Timestamp synchronized to pclk
  input       [9:0]   tsu_timer_cnt_par_pclk, // Parity for above TSU inputs
  input       [9:0]   tsu_ptp_tx_timer_par_in,
  input       [9:0]   tsu_ptp_rx_timer_par_in,
  input               ptp_tx_time_load,     // load timer value to PTP event
                                            // transmitted register
  input               ptp_rx_time_load,     // load timer value to PTP event
                                            // received register
  input               ptp_tx_ptime_load,    // load timer value to peer event
                                            // transmitted register
                                            // received register
  input               ptp_rx_ptime_load,    // load timer value to peer event
  output      [47:0]  tsu_timer_sec,        // TSU registered timer value seconds
  output      [29:0]  tsu_timer_nsec,       // TSU registered timer value nanoseconds
  output              tsu_timer_sec_wr,     // TSU timer seconds written
  output              tsu_timer_nsec_wr,    // TSU timer nanoseconds written
  output              tsu_timer_adj_wr,     // TSU timer adjust written
  output              tsu_timer_adj_ctrl,   // TSU timer add/subtract adjust
  output      [29:0]  tsu_timer_adj,        // TSU timer adjust
  output      [31:0]  tsu_timer_incr,       // TSU timer increment
  output              tsu_timer_incr_wr,    // TSU timer incr written
  output      [7:0]   tsu_timer_alt_incr,   // TSU timer alternative increment
  output      [7:0]   tsu_timer_num_incr,   // TSU timer number of increments
                                            // alternative increment value used
  output      [21:0]  tsu_timer_nsec_cmp,   // TSU timer comparison nanosecond upper 22 bits
  output              tsu_timer_nsec_cmp_wr, // indicates a comparison ns write
  output      [47:0]  tsu_timer_sec_cmp,    // TSU timer comparison second

  output  reg [31:0]  prdata_tsu,           // Read data (combinatorial)
  output  reg         perr_tsu,             // Similarly perr signal (registered)
  output              tsu_par_err,          // Parity error
  output              tsu_dap_err           // Parity error for datapath protection

);


  // Internal signals
  reg   [47:0]  tsu_timer_sec_r;      // TSU 1588 timer seconds from APB
  reg   [29:0]  tsu_timer_nsec_r;     // TSU 1588 timer nanoseconds from APB
  reg           tsu_timer_sec_wr_r;   // TSU timer seconds written
  reg           tsu_timer_nsec_wr_r;  // TSU timer nanoseconds written
  reg           tsu_timer_adj_wr_r;   // TSU timer adjust written
  reg           tsu_timer_adj_ctrl_r; // TSU 1588 timer adjust control
  reg   [29:0]  tsu_timer_adj_r;      // TSU 1588 timer adjust
  reg   [31:0]  tsu_timer_incr_r;     // TSU 1588 timer increment
  reg           tsu_timer_incr_wr_r;  // TSU timer incr written
  reg   [7:0]   tsu_timer_alt_incr_r; // TSU 1588 timer alternative
                                      // increment
  reg   [7:0]   tsu_timer_num_incr_r; // TSU timer number of increments
                                      // alternative increment value used
  reg   [21:0]  tsu_timer_nsec_cmp_r; // TSU timer comparison nanoseconds
                                      // upper 22 bits
  reg           tsu_timer_nsec_cmp_wr_r; // indicates a comparison ns write
  reg   [47:0]  tsu_timer_sec_cmp_r;  // TSU timer comparison seconds

  reg   [77:0]  tsu_ptp_tx_r;         // TSU PTP event frame transmitted
  reg   [77:0]  tsu_ptp_rx_r;         // TSU PTP event frame received
  reg   [77:0]  tsu_peer_tx_r;        // TSU peer event frame transmitted
  reg   [77:0]  tsu_peer_rx_r;        // TSU peer event frame received
  reg   [77:0]  timer_sync_str_r;     // timer sync strobe

  wire  [47:0]  timer_sync_sec_src;   // Seconds
  wire  [29:0]  timer_sync_nsec_src;  // Nanoseconds
  wire  [9:0]   timer_sync_par_src;   // Overall parity
  wire  [47:0]  tsu_ptp_tx_sec;
  wire  [29:0]  tsu_ptp_tx_nsec;
  wire  [47:0]  tsu_ptp_rx_sec;
  wire  [29:0]  tsu_ptp_rx_nsec;
  wire  [47:0]  tsu_peer_tx_sec;
  wire  [29:0]  tsu_peer_tx_nsec;
  wire  [47:0]  tsu_peer_rx_sec;
  wire  [29:0]  tsu_peer_rx_nsec;
  wire  [47:0]  timer_sync_str_sec;
  wire  [29:0]  timer_sync_str_nsec;


  // Register writes by software
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
    begin
      tsu_timer_sec_r         <= 48'd0;
      tsu_timer_nsec_r        <= 30'h00000000;
      tsu_timer_adj_ctrl_r    <= 1'b0;
      tsu_timer_adj_r         <= 30'h00000000;
      tsu_timer_sec_wr_r      <= 1'b0;
      tsu_timer_nsec_wr_r     <= 1'b0;
      tsu_timer_adj_wr_r      <= 1'b0;
      tsu_timer_incr_r        <= 32'h00000000;
      tsu_timer_alt_incr_r    <= 8'h00;
      tsu_timer_num_incr_r    <= 8'h00;
      tsu_timer_incr_wr_r     <= 1'b0;
      tsu_timer_sec_cmp_r     <= 48'd0;
      tsu_timer_nsec_cmp_r    <= 22'd0;
      tsu_timer_nsec_cmp_wr_r <= 1'b0;
    end
    else if (write_registers)
      case (i_paddr)
        `gem_tsu_timer_sec      :
        begin
          tsu_timer_sec_r[31:0] <= pwdata[31:0];
          tsu_timer_sec_wr_r    <= ~tsu_timer_sec_wr_r;
        end
        `gem_tsu_timer_msb_sec  : tsu_timer_sec_r[47:32]<= pwdata[15:0];
        `gem_tsu_timer_nsec     :
        begin
          tsu_timer_nsec_r      <= pwdata[29:0];
          tsu_timer_nsec_wr_r   <= ~tsu_timer_nsec_wr;
        end
        `gem_tsu_timer_adjust   :
        begin
          tsu_timer_adj_ctrl_r  <= pwdata[31];
          tsu_timer_adj_r       <= pwdata[29:0];
          tsu_timer_adj_wr_r    <= ~tsu_timer_adj_wr;
        end
        `gem_tsu_timer_incr     :
        begin
          tsu_timer_incr_r[31:24] <= pwdata[7:0];
          tsu_timer_alt_incr_r    <= pwdata[15:8];
          tsu_timer_num_incr_r    <= pwdata[23:16];
          tsu_timer_incr_wr_r     <= ~tsu_timer_incr_wr;
        end
        `gem_tsu_timer_incr_sub_nsec  :
        begin
          tsu_timer_incr_r[23:8]  <= pwdata[15:0];
          tsu_timer_incr_r[7:0]   <= pwdata[31:24];
        end
        `gem_tsu_sec_cmp      : tsu_timer_sec_cmp_r[31:0]   <= pwdata[31:0];
        `gem_tsu_msb_sec_cmp  : tsu_timer_sec_cmp_r[47:32]  <= pwdata[15:0];
        `gem_tsu_nsec_cmp     :
        begin
          tsu_timer_nsec_cmp_r    <= pwdata[21:0];
          tsu_timer_nsec_cmp_wr_r <= ~tsu_timer_nsec_cmp_wr;
        end


        default : ;
      endcase // case(i_paddr).
  end


  // Sample timer value if not using pclk.
  generate if (p_edma_tsu_clk == 1) begin : gen_tsu_clk
    reg [77:0]  tsu_timer_cnt_r;

    // register timer value
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        tsu_timer_cnt_r   <= {78{1'b0}};
      else
        if (tsu_timer_cnt_pclk_vld)
          tsu_timer_cnt_r <= tsu_timer_cnt_pclk;
    end

    // Optional store parity but this will only apply if data/address path parity is also
    // enabled since TSU will not generate parity unless that is on.
    if ((p_parity_prot == 1) && (p_dap_prot == 1)) begin : gen_par_store
      reg [9:0]   tsu_timer_cnt_par_r;
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          tsu_timer_cnt_par_r <= {10{1'b0}};
        else
          if (tsu_timer_cnt_pclk_vld)
            tsu_timer_cnt_par_r <= tsu_timer_cnt_par_pclk;
      end
      assign timer_sync_par_src = tsu_timer_cnt_par_r;
    end else begin : gen_no_par_store
      assign timer_sync_par_src = 10'h000;
    end

    assign timer_sync_sec_src   = tsu_timer_cnt_r[77:30];
    assign timer_sync_nsec_src  = tsu_timer_cnt_r[29:0];

  end else begin : gen_no_gen_tsu_clk
    assign timer_sync_sec_src   = tsu_timer_cnt_pclk[77:30];
    assign timer_sync_nsec_src  = tsu_timer_cnt_pclk[29:0];
    assign timer_sync_par_src   = tsu_timer_cnt_par_pclk;
  end // gen_tsu_clk
  endgenerate


  // Store timer value
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      timer_sync_str_r    <= {78{1'b0}};
    else
      if (timer_strobe)
        timer_sync_str_r  <= {timer_sync_sec_src,timer_sync_nsec_src};
  end


  // Store timer value when a PTP sync or delay request frame is detected
  // Also store timer value when a pdelay_req or pdelay_resp frame is detected
  always @(posedge pclk or negedge n_preset)
  begin
    if(~n_preset)
    begin
      tsu_ptp_tx_r  <= {78{1'b0}};
      tsu_ptp_rx_r  <= {78{1'b0}};
      tsu_peer_tx_r <= {78{1'b0}};
      tsu_peer_rx_r <= {78{1'b0}};
    end
    else
    begin
      if (ptp_tx_time_load)
        tsu_ptp_tx_r  <= tsu_ptp_tx_timer_in;
      if(ptp_rx_time_load)
        tsu_ptp_rx_r  <= tsu_ptp_rx_timer_in;
      if (ptp_tx_ptime_load)
        tsu_peer_tx_r <= tsu_ptp_tx_timer_in;
      if(ptp_rx_ptime_load)
        tsu_peer_rx_r <= tsu_ptp_rx_timer_in;
    end
  end


  // Assign internal register values to wires for lookup
  assign tsu_ptp_tx_sec       = tsu_ptp_tx_r[77:30];
  assign tsu_ptp_tx_nsec      = tsu_ptp_tx_r[29:0];
  assign tsu_ptp_rx_sec       = tsu_ptp_rx_r[77:30];
  assign tsu_ptp_rx_nsec      = tsu_ptp_rx_r[29:0];
  assign tsu_peer_tx_sec      = tsu_peer_tx_r[77:30];
  assign tsu_peer_tx_nsec     = tsu_peer_tx_r[29:0];
  assign tsu_peer_rx_sec      = tsu_peer_rx_r[77:30];
  assign tsu_peer_rx_nsec     = tsu_peer_rx_r[29:0];
  assign timer_sync_str_sec   = timer_sync_str_r[77:30];
  assign timer_sync_str_nsec  = timer_sync_str_r[29:0];
  assign tsu_timer_sec        = tsu_timer_sec_r;
  assign tsu_timer_nsec       = tsu_timer_nsec_r;
  assign tsu_timer_sec_wr     = tsu_timer_sec_wr_r;
  assign tsu_timer_nsec_wr    = tsu_timer_nsec_wr_r;
  assign tsu_timer_adj_wr     = tsu_timer_adj_wr_r;
  assign tsu_timer_adj_ctrl   = tsu_timer_adj_ctrl_r;
  assign tsu_timer_adj        = tsu_timer_adj_r;
  assign tsu_timer_incr       = tsu_timer_incr_r;
  assign tsu_timer_incr_wr    = tsu_timer_incr_wr_r;
  assign tsu_timer_alt_incr   = tsu_timer_alt_incr_r;
  assign tsu_timer_num_incr   = tsu_timer_num_incr_r;
  assign tsu_timer_nsec_cmp   = tsu_timer_nsec_cmp_r;
  assign tsu_timer_sec_cmp    = tsu_timer_sec_cmp_r;
  assign tsu_timer_nsec_cmp_wr = tsu_timer_nsec_cmp_wr_r;


  // APB read of registers.
  // The prdata_tsu should be registered externally.
  always @(*)
  begin
    if (read_registers)
      case (i_paddr)
        `gem_tsu_timer_msb_sec        : prdata_tsu  = {16'h0000,timer_sync_sec_src[47:32]};
        `gem_tsu_timer_sec            : prdata_tsu  = timer_sync_sec_src[31:0];
        `gem_tsu_timer_nsec           : prdata_tsu  = {2'b00,timer_sync_nsec_src[29:0]};
        `gem_tsu_sec_cmp              : prdata_tsu  = tsu_timer_sec_cmp[31:0];
        `gem_tsu_msb_sec_cmp          : prdata_tsu  = {16'h0000,tsu_timer_sec_cmp[47:32]};
        `gem_tsu_nsec_cmp             : prdata_tsu  = {10'h000,tsu_timer_nsec_cmp[21:0]};
        `gem_tsu_timer_incr           : prdata_tsu  = {8'h00,tsu_timer_num_incr[7:0],
                                                        tsu_timer_alt_incr[7:0],tsu_timer_incr[31:24]};
        `gem_tsu_timer_incr_sub_nsec  : prdata_tsu  = {tsu_timer_incr[7:0],8'h00, tsu_timer_incr[23:8]};
        `gem_tsu_ptp_tx_sec           : prdata_tsu  = tsu_ptp_tx_sec[31:0];
        `gem_tsu_ptp_tx_msb_sec       : prdata_tsu  = {16'h0000,tsu_ptp_tx_sec[47:32]};
        `gem_tsu_ptp_tx_nsec          : prdata_tsu  = {2'b00,tsu_ptp_tx_nsec[29:0]};
        `gem_tsu_ptp_rx_sec           : prdata_tsu  = tsu_ptp_rx_sec[31:0];
        `gem_tsu_ptp_rx_msb_sec       : prdata_tsu  = {16'h0000,tsu_ptp_rx_sec[47:32]};
        `gem_tsu_ptp_rx_nsec          : prdata_tsu  = {2'b00,tsu_ptp_rx_nsec[29:0]};
        `gem_tsu_peer_tx_sec          : prdata_tsu  = tsu_peer_tx_sec[31:0];
        `gem_tsu_peer_tx_msb_sec      : prdata_tsu  = {16'h0000,tsu_peer_tx_sec[47:32]};
        `gem_tsu_peer_tx_nsec         : prdata_tsu  = {2'b00,tsu_peer_tx_nsec[29:0]};
        `gem_tsu_peer_rx_sec          : prdata_tsu  = tsu_peer_rx_sec[31:0];
        `gem_tsu_peer_rx_msb_sec      : prdata_tsu  = {16'h0000,tsu_peer_rx_sec[47:32]};
        `gem_tsu_peer_rx_nsec         : prdata_tsu  = {2'b00,tsu_peer_rx_nsec[29:0]};
        `gem_tsu_strobe_sec           : prdata_tsu  = timer_sync_str_sec[31:0];
        `gem_tsu_strobe_msb_sec       : prdata_tsu  = {16'h0000,timer_sync_str_sec[47:32]};
        `gem_tsu_strobe_nsec          : prdata_tsu  = {2'b00,timer_sync_str_nsec[29:0]};
        default                       : prdata_tsu  = 32'h00000000;
      endcase
    else
      prdata_tsu  = 32'h00000000;
  end

  // Perr signal is similar to above. This is registered to match previous implementation
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      perr_tsu  <= 1'b0;
    else if (psel)
      case (i_paddr)
        `gem_tsu_sec_cmp              ,
        `gem_tsu_msb_sec_cmp          ,
        `gem_tsu_nsec_cmp             ,
        `gem_tsu_strobe_sec           ,
        `gem_tsu_strobe_msb_sec       ,
        `gem_tsu_strobe_nsec          ,
        `gem_tsu_timer_sec            ,
        `gem_tsu_timer_msb_sec        ,
        `gem_tsu_timer_nsec           ,
        `gem_tsu_timer_adjust         ,
        `gem_tsu_timer_incr           ,
        `gem_tsu_timer_incr_sub_nsec  ,
        `gem_tsu_ptp_tx_sec           ,
        `gem_tsu_ptp_tx_msb_sec       ,
        `gem_tsu_ptp_tx_nsec          ,
        `gem_tsu_ptp_rx_sec           ,
        `gem_tsu_ptp_rx_msb_sec       ,
        `gem_tsu_ptp_rx_nsec          ,
        `gem_tsu_peer_tx_sec          ,
        `gem_tsu_peer_tx_msb_sec      ,
        `gem_tsu_peer_tx_nsec         ,
        `gem_tsu_peer_rx_sec          ,
        `gem_tsu_peer_rx_msb_sec      ,
        `gem_tsu_peer_rx_nsec         : perr_tsu  <= 1'b0;
        default                       : perr_tsu  <= 1'b1;  // No match for this module
      endcase
    else
      perr_tsu  <= 1'b0;
  end


  // Optional parity protection
  generate if (p_parity_prot == 1) begin : gen_par
    reg   [5:0] sec_par;
    reg   [3:0] nsec_par;
    reg   [3:0] adj_par;
    reg   [3:0] incr_par;
    reg         alt_incr_par;
    reg         num_incr_par;
    reg   [5:0] sec_cmp_par;
    reg   [2:0] nsec_cmp_par;
    wire        opt_tsu_dap_err;
    wire        tsu_par_err_int;
    reg         tsu_par_err_r;

    // Store associated parity
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
      begin
        sec_par     <= 6'h00;
        nsec_par    <= 4'h0;
        adj_par     <= 4'h0;
        incr_par    <= 4'h0;
        alt_incr_par<= 1'b0;
        num_incr_par<= 1'b0;
        sec_cmp_par <= 6'h00;
        nsec_cmp_par<= 3'h0;
      end
      else if (write_registers)
      begin
        if (i_paddr == `gem_tsu_timer_sec)
          sec_par[3:0]    <= pwdata_par;
        if (i_paddr == `gem_tsu_timer_msb_sec)
          sec_par[5:4]    <= pwdata_par[1:0];
        if (i_paddr == `gem_tsu_timer_nsec)
          nsec_par        <= {^pwdata[29:24],pwdata_par[2:0]};
        if (i_paddr == `gem_tsu_timer_adjust)
          adj_par         <= {pwdata[30]^pwdata_par[3],pwdata_par[2:0]};
        if (i_paddr == `gem_tsu_timer_incr)
        begin
          incr_par[3]     <= pwdata_par[0];
          alt_incr_par    <= pwdata_par[1];
          num_incr_par    <= pwdata_par[2];
        end
        if (i_paddr == `gem_tsu_timer_incr_sub_nsec)
          incr_par[2:0]   <= {pwdata_par[1:0],pwdata_par[3]};
        if (i_paddr == `gem_tsu_sec_cmp)
          sec_cmp_par[3:0]<= pwdata_par;
        if (i_paddr == `gem_tsu_msb_sec_cmp)
          sec_cmp_par[5:4]<= pwdata_par[1:0];
        if (i_paddr == `gem_tsu_nsec_cmp)
          nsec_cmp_par    <= {^pwdata[21:16],pwdata_par[1:0]};
      end
    end

    // Check the parity constantly
    cdnsdru_asf_parity_check_v1 #(.p_data_width(232)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    ({2'h0,tsu_timer_nsec_cmp_r,
                    tsu_timer_sec_cmp_r,
                    tsu_timer_num_incr_r,
                    tsu_timer_alt_incr_r,
                    tsu_timer_incr_r,
                    tsu_timer_adj_ctrl_r,1'b0,tsu_timer_adj_r,
                    2'h0,tsu_timer_nsec_r,
                    tsu_timer_sec_r}),
      .parity_in  ({nsec_cmp_par,
                    sec_cmp_par,
                    num_incr_par,
                    alt_incr_par,
                    incr_par,
                    adj_par,
                    nsec_par,
                    sec_par}),
      .parity_err (tsu_par_err_int)
    );

    // If p_dap_prot is enabled, the TSU will also generate parity that we store
    // and check.
    if (p_dap_prot == 1) begin : gen_dap_check
      reg   [9:0] timer_sync_str_par;
      reg   [9:0] tsu_ptp_tx_par;
      reg   [9:0] tsu_ptp_rx_par;
      reg   [9:0] tsu_peer_tx_par;
      reg   [9:0] tsu_peer_rx_par;
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          timer_sync_str_par  <= 10'h000;
          tsu_ptp_tx_par      <= 10'h000;
          tsu_ptp_rx_par      <= 10'h000;
          tsu_peer_tx_par     <= 10'h000;
          tsu_peer_rx_par     <= 10'h000;
        end
        else
        begin
          if (timer_strobe)
            timer_sync_str_par  <= timer_sync_par_src;
          if (ptp_tx_time_load)
            tsu_ptp_tx_par      <= tsu_ptp_tx_timer_par_in;
          if(ptp_rx_time_load)
            tsu_ptp_rx_par      <= tsu_ptp_rx_timer_par_in;
          if (ptp_tx_ptime_load)
            tsu_peer_tx_par     <= tsu_ptp_tx_timer_par_in;
          if(ptp_rx_ptime_load)
            tsu_peer_rx_par     <= tsu_ptp_rx_timer_par_in;
        end
      end

      // Check the parity constantly
      cdnsdru_asf_parity_check_v1 #(.p_data_width(400)) i_par_chk (
        .odd_par    (1'b0),
        .data_in    ({2'b00,timer_sync_str_r,
                      2'b00,tsu_ptp_tx_r,
                      2'b00,tsu_ptp_rx_r,
                      2'b00,tsu_peer_tx_r,
                      2'b00,tsu_peer_rx_r}),
        .parity_in  ({timer_sync_str_par,
                      tsu_ptp_tx_par,
                      tsu_ptp_rx_par,
                      tsu_peer_tx_par,
                      tsu_peer_rx_par}),
        .parity_err (opt_tsu_dap_err)
      );

    end else begin : gen_no_dap_check
      assign opt_tsu_dap_err  = 1'b0;
    end

    // Register parity error
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        tsu_par_err_r <= 1'b0;
      else
        tsu_par_err_r <= tsu_par_err_int | opt_tsu_dap_err;
    end
    assign tsu_par_err  = tsu_par_err_r;

  end else begin : gen_no_par
    assign tsu_par_err  = 1'b0;
  end
  endgenerate

  // If Data/Address path parity protection is enabled, the TSU will also be generating
  // parity (which is stored and checked above for register reads if p_parity_prot is
  // also enabled).
  generate if (p_dap_prot == 1) begin : gen_dap_chk
    wire  tsu_dap_err_int;
    reg   tsu_dap_err_r;

    // Check parity constantly
    cdnsdru_asf_parity_check_v1 #(.p_data_width(240)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    ({2'b00,timer_sync_sec_src,timer_sync_nsec_src,
                    2'b00,tsu_ptp_tx_timer_in,
                    2'b00,tsu_ptp_rx_timer_in}),
      .parity_in  ({timer_sync_par_src,
                    tsu_ptp_tx_timer_par_in,
                    tsu_ptp_rx_timer_par_in}),
      .parity_err (tsu_dap_err_int)
    );

    // Register error
    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        tsu_dap_err_r <= 1'b0;
      else
        tsu_dap_err_r <= tsu_dap_err_int;
    end

    assign tsu_dap_err  = tsu_dap_err_r;
  end else begin : gen_no_dap_chk
    assign tsu_dap_err  = 1'b0;
  end
  endgenerate

endmodule
