//------------------------------------------------------------------------------
// Copyright (c) 2006-2020 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_axi_fe_desc_buff.v
//   Module Name:        edma_pbuf_axi_fe_desc_buff
//
//   Release Revision:   r1p12f3
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
//   Description    :     Primary and secondary descriptor buffers and
//                        descriptor generation logic for TCP segmentation and
//                        UDP fragmentation
//
//------------------------------------------------------------------------------


module edma_pbuf_axi_fe_desc_buff # (

    parameter p_edma_lso                    = 1'b0,
    parameter p_edma_asf_dap_prot           = 1'b0,
    parameter p_axi_tx_descr_rd_buff_bits   = 4'd2,
    parameter p_axi_tx_descr_rd_buff_depth  = 2**p_axi_tx_descr_rd_buff_bits,
    parameter p_descr_width                 = 64,
    parameter p_descr_pwidth                = (p_descr_width+7)/8,
    parameter p_num_queues                  = 32'd1,
    parameter p_edma_tx_pbuf_addr           = 32'd0,
    parameter p_edma_tx_pbuf_data           = 32'd0,
    parameter p_this_queue                  = 32'd0

  ) (

    input                                   aclk,
    input                                   n_areset,

    input                                   enable_tx,

    input   [p_descr_width-1:0]             db1_in,
    input   [p_descr_pwidth-1:0]            db1_in_par,
    input                                   db1_push,
    input                                   descr_rd_req_end,
    input                                   descr_rd_resp_end,

    output                                  db1_full,

    output  [p_descr_width+3:0]             db2_out_axi,
    output  [p_descr_pwidth-1:0]            db2_out_axi_par,    // Parity only for the data bits, excludes top 4.
    output  [p_descr_width+3:0]             db2_out_nxt_axi,
    output  [p_descr_pwidth-1:0]            db2_out_nxt_axi_par,
    input                                   db2_pop_axi,
    output  [p_axi_tx_descr_rd_buff_bits:0] db2_fill_axi,
    output                                  db2_empty_axi,

    output  [p_descr_width+3:0]             db2_out_dma,
    output  [p_descr_pwidth-1:0]            db2_out_dma_par,
    input                                   db2_pop_dma,
    output                                  db2_empty_dma,

    input   [p_edma_tx_pbuf_addr+1:0]       sram_fill_lvl,
    input   [p_edma_tx_pbuf_addr+1:0]       sram_max_fill_lvl,
    input                                   sram_full,
    input                                   q0_dpram_full,
    input   [7:0]                           num_pkts_in_buf,
    input   [1:0]                           dma_bus_width,
    input                                   tx_cutthru,
    input   [p_edma_tx_pbuf_addr+1:0]       requested_axi_data,
    input   [p_edma_tx_pbuf_addr+1:0]       axi_tx_full_adj_0,
    input   [3:0]                           ahb_dma_queue_ptr,

    output                                  single_frame_too_big,
    output                                  db1_out_par_err,
    output                                  db2_out_par_err


  );


  wire                                  inc1_db1_fill;
  wire                                  dec1_db1_fill;
  wire                                  dec2_db1_fill;
  reg   [p_axi_tx_descr_rd_buff_bits:0] db1_fill;
  wire  [p_axi_tx_descr_rd_buff_bits:0] db1_fill_one;
  wire  [p_axi_tx_descr_rd_buff_bits:0] db1_fill_two;
  reg                                   db1_pop;
  wire                                  db1_empty;

  wire  [p_descr_width-1:0]             db1_out;
  wire  [p_descr_pwidth-1:0]            db1_out_par;
  wire                                  db1_out_last_bit;
  wire                                  db1_out_used_bit;
  wire                                  db1_out_tso_bit;
  wire                                  db1_out_ufo_bit;

  wire                                  db1_out_tso_en;
  wire                                  db1_out_ufo_en;

  reg                                   db1_out_first_descr;

  wire  [p_descr_width-1:0]             dgen_hdr_descr;
  wire  [p_descr_pwidth-1:0]            dgen_hdr_descr_par;

  reg                                   db2_push;
  wire                                  db2_full_axi;
  wire                                  db2_full_dma;

  reg   [p_descr_width-1:0]             db2_in;
  reg   [p_descr_pwidth-1:0]            db2_in_par;
  wire  [p_descr_width-1:0]             db2_tso_ufo_in;
  wire  [p_descr_pwidth-1:0]            db2_tso_ufo_in_par;
  reg                                   db2_in_gh;
  reg                                   db2_in_fh;
  reg                                   db2_in_lh;
  reg                                   db2_in_ni;

  reg   [13:0]                          dgen_mss_mfs;
  wire  [13:0]                          dgen_udp_max_frag;
  wire                                  invalid_udp_max_frag;
  reg   [13:0]                          dgen_len;
  reg   [13:0]                          dgen_rem_len;
  reg   [13:0]                          dgen_rem_len_r;
  reg   [31:0]                          dgen_addr;
  reg                                   last_gen_pyld;

  wire  [13:0]                          required_sram_bytes_db2_in;
  wire  [13:0]                          required_sram_bytes_db2_out;
  wire  [20:0]                          required_sram_stripes;
  reg   [15:0]                          required_sram_stripes_db2;
  reg   [15:0]                          required_sram_stripes_db2_in;
  reg   [15:0]                          required_sram_stripes_db2_in_x;
  reg   [15:0]                          required_sram_stripes_db2_out;
  wire  [14:0]                          reserved_stripes;
  wire  [14:0]                          reserved_stripes_xtra;
  reg                                   sram_space_ok;
  wire                                  multi_buffer_error;

  // State machine current and next state vectors
  reg   [3:0]                           dgen_sm_cs;
  wire  [3:0]                           dgen_sm_ns;

  // State machine states
  localparam
    DGEN_IDLE             = 4'b0000,
    DGEN_TSO_1ST_HDR      = 4'b0001,
    DGEN_TSO_RPT_HDR      = 4'b0010,
    DGEN_TSO_NXT_PYLD_HDR = 4'b0011,
    DGEN_TSO_PYLD         = 4'b0100,
    DGEN_UFO_1ST_HDR      = 4'b0101,
    DGEN_UFO_RPT_HDR      = 4'b0110,
    DGEN_UFO_NXT_PYLD_HDR = 4'b0111,
    DGEN_UFO_PYLD         = 4'b1000;


  // ======================================================================================
  // Primary descriptor buffer
  // Standard FIFO - pushed by AXI descriptor read, popped by descriptor generator
  // logic when generated descriptors are delivered to the secondary buffer
  // Fill and full calculated separately to take pending descriptor fetches into account
  // ======================================================================================
  localparam p_pri_buf_width = p_edma_asf_dap_prot ? p_descr_width + p_descr_pwidth  : p_descr_width;

  wire  [p_pri_buf_width-1:0] pri_buf_in, pri_buf_out;
  wire  [p_pri_buf_width+3:0] sec_buf_in, sec_buf_out_1, sec_buf_out_1_nxt, sec_buf_out_2;

  generate if (p_edma_asf_dap_prot > 0) begin : gen_pri_buf_par
    assign pri_buf_in = {db1_in_par,db1_in};
    assign {db1_out_par, db1_out} = pri_buf_out;
    assign sec_buf_in = {db2_in_par,db2_in_gh, db2_in_fh, db2_in_lh, db2_in_ni, db2_in};
    assign {db2_out_axi_par,db2_out_axi}          = sec_buf_out_1;
    assign {db2_out_nxt_axi_par,db2_out_nxt_axi}  = sec_buf_out_1_nxt;
    assign {db2_out_dma_par,db2_out_dma}          = sec_buf_out_2;
  end else begin : gen_pri_buf_no_par
    assign pri_buf_in = db1_in;
    assign db1_out    = pri_buf_out;
    assign db1_out_par= {p_descr_pwidth{1'b0}};
    assign sec_buf_in = {db2_in_gh, db2_in_fh, db2_in_lh, db2_in_ni, db2_in};
    assign db2_out_axi          = sec_buf_out_1;
    assign db2_out_axi_par      = {p_descr_pwidth{1'b0}};
    assign db2_out_nxt_axi      = sec_buf_out_1_nxt;
    assign db2_out_nxt_axi_par  = {p_descr_pwidth{1'b0}};
    assign db2_out_dma          = sec_buf_out_2;
    assign db2_out_dma_par      = {p_descr_pwidth{1'b0}};
  end
  endgenerate

  edma_gen_fifo #(

    .FIFO_WIDTH       (p_pri_buf_width),
    .FIFO_DEPTH       (p_axi_tx_descr_rd_buff_depth),
    .FIFO_ADDR_WIDTH  (p_axi_tx_descr_rd_buff_bits)

  ) i_tx_descr_pri_buff (

    .clk_pcie   (aclk),
    .rst_n      (n_areset),

    .flush      (~enable_tx),

    .qempty     (db1_empty),
    .qfull      (),
    .qlevel     (),

    .push       (db1_push),
    .din        (pri_buf_in),

    .pop        (db1_pop),
    .qout       (pri_buf_out)

  );


  // ======================================================================================
  //  Primary descriptor buffer fill level
  //    - must be incremented on an AXI descriptor read request so that the fill level
  //      includes the descriptors that have been requested. Therefore it must be decremented
  //      if descriptor is not pushed to the FIFO when it is received - this can be coincident
  //      with a normal pop due to an existing descriptor being processed
  // ======================================================================================

  // Increment by 1 on descriptor read request
  assign inc1_db1_fill = descr_rd_req_end;

  // Decrement by 1 if pop OR if buffer wasn't pushed on descr read response, but not both
  assign dec1_db1_fill = db1_pop ^ (descr_rd_resp_end && ~db1_push);

  // Decrement by 2 if pop AND if buffer wasn't pushed on descr read response
  assign dec2_db1_fill = db1_pop && descr_rd_resp_end && ~db1_push;

  // Single and dual increment/decrement values padded to fill counter width
  assign db1_fill_one = {{p_axi_tx_descr_rd_buff_bits{1'b0}},1'b1};

  generate if (p_axi_tx_descr_rd_buff_bits == 4'd1) begin : gen_descr_rd_buff_eq1
      assign db1_fill_two = 2'd2;
  end else begin : gen_descr_rd_buff_neq1
      assign db1_fill_two = {{p_axi_tx_descr_rd_buff_bits-1{1'b0}},2'd2};
  end
  endgenerate

  // Fill level counter
  // Note: There will be no read request if the 
  // buffer descriptor is already full so db1_fill
  // won't overflow. Having said that, AFL complains
  // because it is not clever enough to reckon this
  // and then we are going to fix it in the RTL
  
  wire [p_axi_tx_descr_rd_buff_bits+1:0] db1_fill_p1;
  assign                                 db1_fill_p1 = db1_fill + db1_fill_one;
  
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      db1_fill <= {p_axi_tx_descr_rd_buff_bits+1{1'b0}};
    else
    begin
      if (~enable_tx)
        db1_fill <= {p_axi_tx_descr_rd_buff_bits+1{1'b0}};
      else
        case ({inc1_db1_fill, dec1_db1_fill, dec2_db1_fill})

          3'b100 : // inc1 only: increment by 1
            db1_fill <= db1_fill_p1[p_axi_tx_descr_rd_buff_bits:0];

          3'b010, 3'b101 : // dec1 only, or inc1 and dec2: decrement by 1
            db1_fill <= db1_fill - db1_fill_one;

          3'b001 : // dec2 only: decrement by 2
            db1_fill <= db1_fill - db1_fill_two;

          default : // inc1 and dec1, or no activity: no change
            db1_fill <= db1_fill;

        endcase
    end
  end

  // Generate full flag from top bit of calculated fill value
  // The MAC can hold a maximum of 256 packets in the buffers. We need to make sure we
  // don't get near this value otherwise there is potential for some AXI fabrics to stall
  // due to GEM not being able to accept any more descriptor data.
  // Just look at top 2-bits so set full if 128+64 packets in GEM. This will only occur if
  // the SRAM is at least 16KBytes and we see a constant stream of minimum sized packets.
  assign db1_full = db1_fill[p_axi_tx_descr_rd_buff_bits] | (&num_pkts_in_buf[7:6]);


  // ======================================================================================
  // Descriptor Generator Logic
  // ======================================================================================

  // Decode various bits of descriptor in primary buffer
  assign db1_out_last_bit     = db1_out[47];
  assign db1_out_used_bit     = db1_out[63];
  assign db1_out_tso_bit      = db1_out[50];
  assign db1_out_ufo_bit      = (db1_out[50:49] == 2'b01);

  // Validate TSO and UFO enable bits
  // Only valid if p_edma_lso parameter is set
  // Only valid if descriptor is the first descriptor of the frame i.e. the header descriptor
  // Ignore bit if descriptor length field is empty
  // Ignore bit if last bit is set - TSO/UFO requires a separate payload descriptor
  assign db1_out_tso_en = db1_out_tso_bit     && (p_edma_lso == 1) &&
                          ~db1_empty          && ~db1_out_used_bit &&
                          db1_out_first_descr && ~db1_out_last_bit;

  assign db1_out_ufo_en = db1_out_ufo_bit     && (p_edma_lso == 1) &&
                          ~db1_empty          && ~db1_out_used_bit &&
                          db1_out_first_descr && ~db1_out_last_bit;

  // Indicate when the descriptor in the primary buffer is the first descriptor
  // of software supplied frame
  generate if (p_edma_lso == 1'b1) begin : gen_first_descr
    always @ (posedge aclk or negedge n_areset)
    begin
      if (~n_areset)
        db1_out_first_descr <= 1'b1;
      else
        if (~enable_tx)
          db1_out_first_descr <= 1'b1;
        else
          if (db1_pop)
            db1_out_first_descr <= db1_out_last_bit || db1_out_used_bit;
    end
  end else begin : gen_no_first_descr
    wire zero;
    assign zero = 1'b0;
    always @(zero) db1_out_first_descr = zero;
  end
  endgenerate


  // Flag TSO/UFO multi buffer error
  //  - descriptor currently in primary descriptor buffer has used bit set or has zero value
  //    length field and last bit set
  //  - only relevant when TSO/UFO is underway and descriptor in primary descriptor buffer
  //    is a payload descriptor
  assign multi_buffer_error = db1_out_used_bit || (db1_out_last_bit && (db1_out[45:32] == 14'd0));


  // State machine state vector
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      dgen_sm_cs <= DGEN_IDLE;
    else
      if (~enable_tx)
        dgen_sm_cs <= DGEN_IDLE;
      else
        dgen_sm_cs <= dgen_sm_ns;
  end


  // State machine next state logic
  //  Only active if LSO is enabled via p_edma_lso
  //  When inactive functionality dependent on LSO states will be
  //  optimised out by synthesis
  generate
    if (p_edma_lso == 1)
    begin : gen_lso_sm

      reg   [3:0] dgen_sm_ns_i;

      assign dgen_sm_ns = dgen_sm_ns_i;

      always @ *
      begin

        dgen_sm_ns_i = dgen_sm_cs;

        case (dgen_sm_cs)

          DGEN_TSO_1ST_HDR :
            // Proceed to payload state when header descriptor is pushed to
            // secondary buffer
            if (db2_push)
              dgen_sm_ns_i = DGEN_TSO_PYLD;

          DGEN_TSO_PYLD :
            // Return to IDLE for multi buffer errors - mid buffer used
            // bit or zero length last buffer
            // Return to IDLE when last SW payload descriptor for large TSO
            // frame is processed - otherwise repeat header descriptor
            // Differentiate between repeated header for the current SW payload
            // descriptor and repeated header for next SW payload descriptor
            // as differnet flags are set for each case
            if (db2_push)
            begin
              if (multi_buffer_error)
                dgen_sm_ns_i = DGEN_IDLE;
              else
                if (last_gen_pyld)
                begin
                  if (db1_out_last_bit)
                    dgen_sm_ns_i = DGEN_IDLE;
                  else
                    dgen_sm_ns_i = DGEN_TSO_NXT_PYLD_HDR;
                end
                else
                  dgen_sm_ns_i = DGEN_TSO_RPT_HDR;
            end


          DGEN_TSO_RPT_HDR :
            // Return to TSO payload state to continue
            // processing current payload TSO descriptor
            if (db2_push)
              dgen_sm_ns_i = DGEN_TSO_PYLD;


          DGEN_TSO_NXT_PYLD_HDR :
            // Return to TSO payload state to start
            // processing next payload TSO descriptor
            if (db2_push)
              dgen_sm_ns_i = DGEN_TSO_PYLD;


          DGEN_UFO_1ST_HDR :
            // Proceed to payload state when header descriptor is pushed to
            // secondary buffer
            if (db2_push)
              dgen_sm_ns_i = DGEN_UFO_PYLD;


          DGEN_UFO_PYLD :
            // Return to IDLE for multi buffer errors - mid buffer used
            // bit or zero length last buffer
            // Return to IDLE when last SW payload descriptor for large UFO
            // frame is processed - otherwise repeat header descriptor
            // Differentiate between repeated header for current SW payload
            // descriptor and repeated header for next SW payload descriptor
            // as differnet flags are set for each case
            if (db2_push)
            begin
              if (multi_buffer_error)
                dgen_sm_ns_i = DGEN_IDLE;
              else
                if (last_gen_pyld)
                begin
                  if (db1_out_last_bit)
                    dgen_sm_ns_i = DGEN_IDLE;
                  else
                    dgen_sm_ns_i = DGEN_UFO_NXT_PYLD_HDR;
                end
                else
                  dgen_sm_ns_i = DGEN_UFO_RPT_HDR;
            end


          DGEN_UFO_RPT_HDR :
            // Return to UFO payload state to continue
            // processing current payload TSO descriptor
            if (db2_push)
              dgen_sm_ns_i = DGEN_UFO_PYLD;


          DGEN_UFO_NXT_PYLD_HDR :
            // Return to UFO payload state to start
            // processing next payload TSO descriptor
            if (db2_push)
              dgen_sm_ns_i = DGEN_UFO_PYLD;


          default : // DGEN_IDLE
            // FSM remains in IDLE state for normal descriptors and moves to
            // TSO/UFO 1st header states for TSO/UFO header descriptors
            if (db1_out_tso_en)
                dgen_sm_ns_i = DGEN_TSO_1ST_HDR;
              else
                if (db1_out_ufo_en)
                  dgen_sm_ns_i = DGEN_UFO_1ST_HDR;

        endcase

      end

    end
    else
    begin : gen_no_lso_sm

      assign dgen_sm_ns = DGEN_IDLE;

    end
  endgenerate


  // Generate secondary descriptor buffer push signals
  // Push whenever there is space in the secondary buffer and there is a descriptor in the
  // primary buffer - exception being that when the state machine is in the idle state the
  // push does not occur for TSO/UFO header descriptors. This is because the TSO/UFO
  // header descriptor is stored in the header descriptor register so that the
  // first payload descriptor can be examined and the appropriate flags set when pushing
  // the header descriptor to the secondary buffer. Pushing of the header descriptors for
  // subsequent gennerated frames is also dependent on the primary buffer not being empty
  // as again payload descriptor visibility is required to set the header descriptor flags
  // Do not push until there is enough space in the AHB DMA SRAM to hold the associated
  // data - indicated by sram_space_ok
  always @ *
  begin
    if (dgen_sm_cs == DGEN_IDLE)
      db2_push = ~db2_full_axi   && ~db2_full_dma &&
                 ~db1_empty      && sram_space_ok &&
                 ~db1_out_tso_en && ~db1_out_ufo_en;
    else
      db2_push = ~db2_full_axi && ~db2_full_dma &&
                 ~db1_empty    && sram_space_ok;
  end


  // Load header descriptor register
  // Only for TSO/UFO frames
  // Load as state machine leaves idle state
  generate if (p_edma_lso == 1) begin : gen_lso_dgen
    reg [p_descr_width-1:0] dgen_hdr_descr_r;

    always @ (posedge aclk or negedge n_areset)
    begin
      if (~n_areset)
        dgen_hdr_descr_r    <= {p_descr_width{1'b0}};
      else
        if ((dgen_sm_cs == DGEN_IDLE) && (db1_out_tso_en || db1_out_ufo_en))
          dgen_hdr_descr_r  <= db1_out;
    end
    assign dgen_hdr_descr = dgen_hdr_descr_r;
    // TOIMPRV can protect dgen_len and dgen_addr
    assign db2_tso_ufo_in = {db1_out[p_descr_width-1:48], // word 2 (if present) and word 1 - unmodified
                              1'b1,                       // always set last bit for payload descriptors
                              db1_out[46],                // word 1 bit 14 - unmodified
                              dgen_len,                   // word 1 bits [13:0] - length field
                              dgen_addr                   // word 0 bits [31:0] - buffer address
                            };

    if (p_edma_asf_dap_prot == 1) begin : gen_par
      reg [p_descr_pwidth-1:0]  dgen_hdr_descr_par_r;
      always @ (posedge aclk or negedge n_areset)
        begin
        if (~n_areset)
          dgen_hdr_descr_par_r  <= {p_descr_pwidth{1'b0}};
        else
          if ((dgen_sm_cs == DGEN_IDLE) && (db1_out_tso_en || db1_out_ufo_en))
            dgen_hdr_descr_par_r  <= db1_out_par;
      end
      assign dgen_hdr_descr_par = dgen_hdr_descr_par_r;

    // tx_descr_wr_data_par_clean is a combinatorial re-gen based on tx_descr_wr_data_clean
    // which is a transform of tx_descr_wr_data.
    gem_par_chk_regen #(.p_chk_dwid (p_descr_width)) i_regen_tx_descr_wr_data_par (
      .odd_par  (1'b0),
      .chk_dat  (db1_out),
      .chk_par  (db1_out_par),
      .new_dat  (db2_tso_ufo_in),
      .dat_out  (),
      .par_out  (db2_tso_ufo_in_par),
      .chk_err  (db1_out_par_err)
     );
    end else begin : gen_no_par
      assign dgen_hdr_descr_par = {p_descr_pwidth{1'b0}};
      assign db1_out_par_err    = 1'b0;
      assign db2_tso_ufo_in_par = {p_descr_pwidth{1'b0}};
    end

  end else begin : gen_no_lso_dgen
    assign dgen_hdr_descr     = {p_descr_width{1'b0}};
    assign dgen_hdr_descr_par = {p_descr_pwidth{1'b0}};
    assign db2_tso_ufo_in     = {p_descr_width{1'b0}};
    assign db2_tso_ufo_in_par = {p_descr_pwidth{1'b0}};

    if (p_edma_asf_dap_prot == 1) begin : gen_par_check
      cdnsdru_asf_parity_check_v1 #(
        .p_data_width (p_descr_width)
      ) i_par_chk (
        .odd_par    (1'b0),
        .data_in    (db1_out),
        .parity_in  (db1_out_par),
        .parity_err (db1_out_par_err)
      );
    end else begin : gen_no_par_check
      assign db1_out_par_err  = 1'b0;
    end

  end
  endgenerate


  // Generate primary descriptor buffer pop signals
  // Dependent on state machine state
  // DGEN_IDLE        - pop when delivering normal descriptor to secondary buffer
  //                    or when delivering TSO/UFO header to header register
  // DGEN_TSO_PYLD    - pop when last generated descriptor of SW descriptor
  //                    is pushed to secondary buffer
  // DGEN_UFO_PYLD    - pop when last generated descriptor of SW descriptor
  //                    is pushed to secondary buffer
  always @ *
  begin
    case (dgen_sm_cs)
      DGEN_IDLE         : db1_pop = db2_push || db1_out_tso_en || db1_out_ufo_en;
      DGEN_TSO_PYLD     : db1_pop = db2_push && last_gen_pyld;
      DGEN_UFO_PYLD     : db1_pop = db2_push && last_gen_pyld;
      default           : db1_pop = 1'b0;
    endcase
  end


  // Modify descriptor data as it is transferred from primary descriptor buffer
  // or header register to secondary descriptor buffer
  // Set GH (generated header), FH (first leader) and LH (last header) flags for
  // TSO/UFO header descriptors depending on payload descriptor content
  // Set NI (no increment) flag (for debug and writeback descriptor pointer)
  // for TSO/UFO header and payload descriptors.
  //
  // Data modification is dependent on state machine state:

  // DGEN_IDLE             - Default case
  //                         Descriptor comes from primary buffer
  //                         No modification of descriptor fields
  //                         No setting of GH/FH/LH/NI

  // DGEN_*_1ST_HDR        - Descriptor comes from header descriptor register
  //                         No modification of descriptor fields
  //                         Set GH and FH
  //                         Set LH if new payload length does not exceed MSS/MFS
  //                         and the payload descriptor has the last bit set
  //                         Clear NI

  // DGEN_*_RPT_HDR        - Descriptor comes from header descriptor register
  //                         No modification of descriptor fields
  //                         Set GH
  //                         Clear FH
  //                         Set LH if remaining payload length does not exceed MSS/MFS
  //                         and the payload descriptor has the last bit set
  //                         Set NI

  // DGEN_*_NXT_PYLD_HDR   - Descriptor comes from header descriptor register
  //                         No modification of descriptor fields
  //                         Set GH
  //                         Clear FH
  //                         Set LH if new payload length does not exceed MSS/MFS
  //                         and the payload descriptor has the last bit set
  //                         Set NI

  // DGEN_*_PYLD           - Descriptor comes primary buffer
  //                         Modify descriptor address and length fields
  //                         Clear GH/FH/LH
  //                         Set NI if remaining payload length exceeds MSS/MFS

  always @ *
  begin
    case (dgen_sm_cs)
      DGEN_TSO_1ST_HDR,
      DGEN_UFO_1ST_HDR :
      begin
        db2_in    = dgen_hdr_descr;
        db2_in_par= dgen_hdr_descr_par;
        db2_in_gh = 1'b1;
        db2_in_fh = 1'b1;
        db2_in_lh = multi_buffer_error || (last_gen_pyld && db1_out_last_bit);
        db2_in_ni = 1'b0;
      end

      DGEN_TSO_RPT_HDR,
      DGEN_TSO_NXT_PYLD_HDR,
      DGEN_UFO_RPT_HDR,
      DGEN_UFO_NXT_PYLD_HDR :
      begin
        db2_in    = dgen_hdr_descr;
        db2_in_par= dgen_hdr_descr_par;
        db2_in_gh = 1'b1;
        db2_in_fh = 1'b0;
        db2_in_lh = multi_buffer_error || (last_gen_pyld && db1_out_last_bit);
        db2_in_ni = 1'b1;
      end

      DGEN_TSO_PYLD,
      DGEN_UFO_PYLD :
      begin
        db2_in    = db2_tso_ufo_in;
        db2_in_par= db2_tso_ufo_in_par; // Special recalculation.
        db2_in_gh = 1'b0;
        db2_in_fh = 1'b0;
        db2_in_lh = 1'b0;
        db2_in_ni = ~last_gen_pyld;
      end

      default :
      begin
        db2_in    = db1_out;
        db2_in_par= db1_out_par;
        db2_in_gh = 1'b0;
        db2_in_fh = 1'b0;
        db2_in_lh = 1'b0;
        db2_in_ni = 1'b0;
      end
    endcase
  end

  // Get MSS or MFS value from payload descriptor word 1 bits 29:16
  // If programmed value is 0, MSS is 536 and MFS is 1518
  always @ *
  begin
    if ((dgen_sm_cs == DGEN_TSO_1ST_HDR) ||
        (dgen_sm_cs == DGEN_TSO_RPT_HDR) ||
        (dgen_sm_cs == DGEN_TSO_NXT_PYLD_HDR) ||
        (dgen_sm_cs == DGEN_TSO_PYLD))
      dgen_mss_mfs = (db1_out[61:48] == 14'd0) ? 14'd536 : db1_out[61:48];
    else
      dgen_mss_mfs = (db1_out[61:48] == 14'd0) ? 14'd1518 : db1_out[61:48];
  end

  // Calculate the UDP max fragment value from the max frame size value
  // MFS includes header and FCS. Header size can be obtained from header
  // descriptor length field. FCS is 4 bytes.

  assign dgen_udp_max_frag = dgen_mss_mfs - dgen_hdr_descr[45:32] - 14'd4;


  // Flag if relationship between the max frame size and the header size results
  // in a negative fragment size or in a fragment size of less than 8 bytes
  // In this case no fragmentation will occur
  
  wire [14:0] dgen_hdr_descr_45_32_p4;
  assign      dgen_hdr_descr_45_32_p4 = (dgen_hdr_descr[45:32] + 14'd4);
  
  assign invalid_udp_max_frag = (dgen_hdr_descr_45_32_p4 >= {1'b0,dgen_mss_mfs}) ||
                                 dgen_udp_max_frag < 14'd8;


  // Calculate the generated payload descriptor length field value
  // For TCP this is the greater of MSS or the remaining SW payload
  // descriptor length
  // For UDP this is the greater of max fragment and the remaining SW payload
  // descriptor length. However, if the frame will not be the last fragment then
  // there is a further limitation that the payload buffer length is a multiple
  // of 8 bytes - this limitation is due to the encoding of the IPv4 fragment offset field
  always @ *
  begin
    if ((dgen_sm_cs == DGEN_TSO_1ST_HDR) ||
        (dgen_sm_cs == DGEN_TSO_RPT_HDR) ||
        (dgen_sm_cs == DGEN_TSO_NXT_PYLD_HDR) ||
        (dgen_sm_cs == DGEN_TSO_PYLD))
    begin
      // TCP
      if (dgen_rem_len > dgen_mss_mfs)
        dgen_len = dgen_mss_mfs;
      else
        dgen_len = dgen_rem_len;
    end
    else
    begin
      // UDP
      if ((dgen_rem_len > dgen_udp_max_frag) && ~invalid_udp_max_frag)
        dgen_len = dgen_udp_max_frag & 14'h3FF8; // multiple of 8 bytes
      else
        dgen_len = dgen_rem_len;
    end
  end


  // Flag when generated header/payload descriptor pair is the last for
  // a SW descriptor buffer
  // Flag will be valid during genration of both the header and payload descriptors
  always @ *
  begin
    if ( (dgen_sm_cs == DGEN_TSO_1ST_HDR) ||
         (dgen_sm_cs == DGEN_TSO_RPT_HDR) ||
         (dgen_sm_cs == DGEN_TSO_NXT_PYLD_HDR) ||
         (dgen_sm_cs == DGEN_TSO_PYLD) )
      //TCP
      last_gen_pyld = dgen_rem_len <= dgen_mss_mfs;
    else
      //UDP
      last_gen_pyld = (dgen_rem_len <= dgen_udp_max_frag) || invalid_udp_max_frag;
  end

  // Address and remaining length counters for generated payload descriptors
  // Load when a new SW payload descriptor starts being processed
  // - actual load takes place when the header descriptor for first generated frame
  //   is pushed to the secondary buffer
  // Address counter is then incremented and remaining length counter is decremented
  // by the value of the generated payload descriptor length field as  the payload
  // descriptors are pushed into the secondary buffer
  generate if (p_edma_lso == 1'b1) begin : gen_dgen
    
    wire [32:0] dgen_addr_p_len;
    assign      dgen_addr_p_len = dgen_addr + {18'd0,dgen_len};
    
    always @ (posedge aclk or negedge n_areset)
    begin
      if (~n_areset)
        dgen_addr <= 32'd0;
      else
        if (~enable_tx)
          dgen_addr <= 32'd0;
        else
          if (db2_push)
          begin
            if ((dgen_sm_cs == DGEN_TSO_1ST_HDR) ||
                (dgen_sm_cs == DGEN_TSO_NXT_PYLD_HDR) ||
                (dgen_sm_cs == DGEN_UFO_1ST_HDR) ||
                (dgen_sm_cs == DGEN_UFO_NXT_PYLD_HDR))
              // Load counters from new SW payload descriptor
              dgen_addr <= db1_out[31:0];
            else
              if ((dgen_sm_cs == DGEN_TSO_PYLD) ||
                  (dgen_sm_cs == DGEN_UFO_PYLD))
                // Increment/decrement
                dgen_addr <= dgen_addr_p_len[31:0];
          end
    end
  end else begin : gen_no_dgen
    wire   zero;
    assign zero = 1'b0;
    always @(zero) dgen_addr = {32{zero}};
  end
  endgenerate

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      dgen_rem_len_r <= 14'd0;
    else
      if (~enable_tx)
        dgen_rem_len_r <= 14'd0;
      else
        if (db2_push)
        begin
          if ((dgen_sm_cs == DGEN_TSO_1ST_HDR) ||
              (dgen_sm_cs == DGEN_TSO_NXT_PYLD_HDR) ||
              (dgen_sm_cs == DGEN_UFO_1ST_HDR) ||
              (dgen_sm_cs == DGEN_UFO_NXT_PYLD_HDR))
              // Load counters from new SW payload descriptor
            dgen_rem_len_r  <= db1_out[45:32];
          else
            if ((dgen_sm_cs == DGEN_TSO_PYLD) ||
                (dgen_sm_cs == DGEN_UFO_PYLD))
              // Increment/decrement
              dgen_rem_len_r <= dgen_rem_len - dgen_len;
        end
  end

  // Combinational version of remaining length counter
  //  - used by logic which determines length field value of generated descriptors
  //  - takes value of SW payload descriptopr length field when the header descriptor
  //    is being processed. This is necessary so header descriptor LH flag can be
  //    set as the header descriptor is pushed to the secondary buffer
  always @ *
  begin
    if ((dgen_sm_cs == DGEN_TSO_1ST_HDR) ||
        (dgen_sm_cs == DGEN_TSO_NXT_PYLD_HDR) ||
        (dgen_sm_cs == DGEN_UFO_1ST_HDR) ||
        (dgen_sm_cs == DGEN_UFO_NXT_PYLD_HDR))
      dgen_rem_len  = db1_out[45:32];
    else
      dgen_rem_len  = dgen_rem_len_r;
  end


  // ======================================================================================
  // Secondary descriptor buffer
  // FIFO has 2 read ports - 1 for AXI TX data request logic and 1 for responses to
  // AHB DMA descriptor read requests. AHB DMA can lag AXI TX data request logic significantly
  // AXI read port outputs both current and next values - when FIFO has at least 2 enties and
  // the current value is a header descriptor the next value will be the payload descriptor
  // ======================================================================================
  edma_gen_fifo_2rp #(

    .FIFO_WIDTH       (p_pri_buf_width+4),
    .FIFO_DEPTH       (p_axi_tx_descr_rd_buff_depth),
    .FIFO_ADDR_WIDTH  (p_axi_tx_descr_rd_buff_bits)

  ) i_tx_descr_sec_buff (

    .clk_pcie      (aclk),
    .rst_n         (n_areset),

    .flush         (~enable_tx),

    .din           (sec_buf_in),
    .push          (db2_push),

    // port 1 is the AXI port
    .qout_1        (sec_buf_out_1),
    .qout_nxt_1    (sec_buf_out_1_nxt),
    .pop_1         (db2_pop_axi),
    .qempty_1      (db2_empty_axi),
    .qfull_1       (db2_full_axi),
    .qlevel_1      (db2_fill_axi),

    // port 2 is the DMA port
    .qout_2        (sec_buf_out_2),
    .pop_2         (db2_pop_dma),
    .qempty_2      (db2_empty_dma),
    .qfull_2       (db2_full_dma),
    .qlevel_2      ()

  );


  //=====================================================================
  // Calculate if there is enough space in AHB SRAM for the data associated
  // with the descriptor which is about to be pushed into the secondary buffer
  //=====================================================================

  // Extract the number of bytes required for the buffer data from the
  // descriptor length field
  assign required_sram_bytes_db2_in  = db2_in[63]      ? 14'd0 : db2_in[45:32];
  assign required_sram_bytes_db2_out = db2_out_axi[63] ? 14'd0 : db2_out_axi[45:32];


  // Calculate the number of SRAM locations needed to accomodate the data for the
  // descriptor
  // For 128 bit SRAM, can always have 4 words per location
  // For 64 bit SRAM, will only get 1 word per location if DMA bus width is 32-bit
  // For 32 bit SRAM, will always get 1 word per location

  // Need to add some stripes onto this (up to 4 for status words and
  // 2 due to delay in underlying AHB DMA in updating the sram_fill_lvl.
  // The number of status words is 2 for 128bit DPRAM, 3 for 64 and 4 for 32.
  // Add one more stripe to reserved stipres to take into accound the MOD on
  // required_sram_bytes_db2_in. EG in 32 bit mode, if required_sram_bytes_db2_in
  // = 1-3 bytes, you will need a single stripe to hold it. But we only look at
  // bits [1:0] of required_sram_bytes_db2_in in the code below, so that would
  // be ignored.
  // there are additional status words associated with the previous
  // frame that we also need to take into account here if the previous frame
  // was sent to the same queue as the current
  // frame. This is because the decision on the required sram stripes for
  // the current frame occurs before the status words for the previous frame
  // have actually been written to the SRAM (occurs in lower level AHB DMA)).
  // The number of status words is 2 for 128bit DPRAM, 3 for 64 and 4 for 32.
  reg   [1:0]                           tx_fill_lvl_multiplier;
  always @*
  begin
    if (p_edma_tx_pbuf_data == 32'd128)
      case (dma_bus_width)
        2'd0    : tx_fill_lvl_multiplier = 2'd2; // Four 32b words per 128b word
        2'd1    : tx_fill_lvl_multiplier = 2'd1; // Two 64b words per 128b word
        default : tx_fill_lvl_multiplier = 2'd0;
      endcase
    else
      tx_fill_lvl_multiplier = 2'd0;
  end

  assign reserved_stripes       = p_edma_tx_pbuf_data == 32'd128 ? (15'd2 << tx_fill_lvl_multiplier) + 15'd3 : 15'd7;
  assign reserved_stripes_xtra  = {{28{1'b0}},ahb_dma_queue_ptr} == p_this_queue ?
                                    p_edma_tx_pbuf_data == 32'd128  ? (15'd4 << tx_fill_lvl_multiplier) + 15'd3
                                                                    : 15'd11
                                                                    : reserved_stripes;

  always @ *
  begin
    case (dma_bus_width)
      2'b00 : // 32-bit
      begin
        required_sram_stripes_db2_in    = {3'd0, required_sram_bytes_db2_in[13:2]}  + reserved_stripes;
        required_sram_stripes_db2_out   = {3'd0, required_sram_bytes_db2_out[13:2]} + reserved_stripes;
        required_sram_stripes_db2_in_x  = {3'd0, required_sram_bytes_db2_in[13:2]}  + reserved_stripes_xtra;
      end
      2'b01 : // 64-bit
      begin
        required_sram_stripes_db2_in    = {4'd0, required_sram_bytes_db2_in[13:3]}  + reserved_stripes;
        required_sram_stripes_db2_out   = {4'd0, required_sram_bytes_db2_out[13:3]} + reserved_stripes;
        required_sram_stripes_db2_in_x  = {4'd0, required_sram_bytes_db2_in[13:3]}  + reserved_stripes_xtra;
      end
      default : // 128-bit
      begin
        required_sram_stripes_db2_in    = {5'd0, required_sram_bytes_db2_in[13:4]}  + reserved_stripes;
        required_sram_stripes_db2_out   = {5'd0, required_sram_bytes_db2_out[13:4]} + reserved_stripes;
        required_sram_stripes_db2_in_x  = {5'd0, required_sram_bytes_db2_in[13:4]}  + reserved_stripes_xtra;
      end
    endcase
  end

  // Count the number of sram stripes required for the descriptors currently in the secondary buffer
  // Increment as buffer is pushed and decrement as buffer is popped
  // Push and pop can occur simultaneously
  
  wire [16:0] required_sram_striped_db2_p_in;
  assign      required_sram_striped_db2_p_in = required_sram_stripes_db2 + required_sram_stripes_db2_in;
  
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      required_sram_stripes_db2 <= 16'd0;
    else if (~enable_tx)
      required_sram_stripes_db2 <= 16'd0;
    else if (db2_push && ~db2_pop_axi)
      required_sram_stripes_db2 <= required_sram_striped_db2_p_in[15:0];
    else if (~db2_push && db2_pop_axi)
      required_sram_stripes_db2 <= required_sram_stripes_db2 - required_sram_stripes_db2_out;
    else if (db2_push && db2_pop_axi)
      required_sram_stripes_db2 <= required_sram_stripes_db2 + required_sram_stripes_db2_in - required_sram_stripes_db2_out;
  end

  // Calculate total space required to allow a buffer push.
  // Include the threshold value whic AXI DMA requires to be available before issuing an AXI read
  //  - otherwise the situation will arise where the descriptor is pushed into the buffer but the
  //    AXI DMA cannot immediately fetch the associated data
  
  // The following is done for LINT purposes
  wire                    [16:0] required_sram_stripes_tmp1;
  wire [p_edma_tx_pbuf_addr+2:0] required_sram_stripes_tmp2;
  wire                    [19:0] required_sram_stripes_tmp1_pad;
  wire                    [19:0] required_sram_stripes_tmp2_pad;
  
  // Calculating the individual addends adding elements with the same size with each other
  assign required_sram_stripes_tmp1     = required_sram_stripes_db2 + required_sram_stripes_db2_in_x;
  assign required_sram_stripes_tmp2     = requested_axi_data        + axi_tx_full_adj_0;
  
  // Will pad both addends to be the all the same size before do the add to avoid any LINT warnings
  assign required_sram_stripes_tmp1_pad = {3'd0,required_sram_stripes_tmp1};
  assign required_sram_stripes_tmp2_pad = {{(20-(p_edma_tx_pbuf_addr+3)){1'b0}},required_sram_stripes_tmp2};
  
  // Now do the add
  assign required_sram_stripes          = required_sram_stripes_tmp1_pad + required_sram_stripes_tmp2_pad;
  
  // In non-priority queuing implementations, we can assume there is enough space if we are in full duplex
  // This is because the MAC side will free up DPRAM resources as the frame is being transmitted so we can simply keep the DPRAM topped up
  // In half duplex, this is not the case, so we should simply not attempt to start requesting the frame until there is sufficient space for
  // the full packet.
  // With priority queueing enabled, it is more complex.  we want to avoid any possibility that the underlying DMA can
  // get into DATA state requesting data for a long time while we are unable to complete it due to lack of DPRAM space

  // If we are in cuthru mode then we will always state there is enough space available as the payload is greater than the buffers size

  // Calculate if there is enough space in the AHB DMA SRAM buffer for the data associated with the descriptor that is ready to be pushed into the
  // secondary buffer descriptor
  always @ *
  begin
      // Note. The > calculation below is expanded to 16 bits as the edma_tx_pbuf_addr size can be of varying lengths, and it can sometimes
      // be greater than or less than the required_sram_stripes
      sram_space_ok = (db2_in[63] & ~q0_dpram_full) || // used bit set - we cant commit that to db2 if Q0 is already full as it will cause a used-bit
                      ((({{17-p_edma_tx_pbuf_addr{1'b0}}, sram_fill_lvl} > {3'h0, required_sram_stripes[15:0]}) & ~sram_full & !db2_in[63]) || tx_cutthru);
  end

  assign single_frame_too_big =  ({3'h0, required_sram_stripes_db2_in} > {{17-p_edma_tx_pbuf_addr{1'b0}}, sram_max_fill_lvl}) & ~tx_cutthru & ~db1_empty;

  // Additional checks on the db2 outputs
  generate if (p_edma_asf_dap_prot == 1) begin : gen_par_chk_db2
    wire  db2_out_axi_err;
    wire  db2_out_nxt_axi_err;
    wire  db2_out_dma_err;

    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_descr_width)) i_par_chk_db2_out_axi (
      .odd_par(1'b0),
      .data_in(db2_out_axi[p_descr_width-1:0]),
      .parity_in(db2_out_axi_par[p_descr_pwidth-1:0]),
      .parity_err(db2_out_axi_err)
    );
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_descr_width)) i_par_chk_db2_out_nxt_axi (
      .odd_par(1'b0),
      .data_in(db2_out_nxt_axi[p_descr_width-1:0]),
      .parity_in(db2_out_nxt_axi_par[p_descr_pwidth-1:0]),
      .parity_err(db2_out_nxt_axi_err)
    );
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_descr_width)) i_par_chk_db2_out_dma (
      .odd_par(1'b0),
      .data_in(db2_out_dma[p_descr_width-1:0]),
      .parity_in(db2_out_dma_par[p_descr_pwidth-1:0]),
      .parity_err(db2_out_dma_err)
    );
    assign db2_out_par_err  = db2_out_axi_err | db2_out_nxt_axi_err | db2_out_dma_err;
  end else begin : gen_no_par_chk_db2
    assign db2_out_par_err  = 1'b0;
  end
  endgenerate

endmodule //edma_pbuf_axi_fe_descr_buff
