//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2008-2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//   Checked In : $Date: 2012-10-24 10:29:00 +0100 (Wed, 24 Oct 2012) $
//   Revision   : $Revision: 226216 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ WAKE-UP INTERRUPT CONTROLLER
//-----------------------------------------------------------------------------

module cm0p_wic
  #(parameter IRQDIS    = 32'h00000000,  // IRQ disable support
    parameter WICLINES  = 8)             // Number of WIC lines (2..34)
   (input  wire         FCLK,
    input  wire         RESETn,

    input  wire [31:0]  IRQ,         // External interrupt request
    input  wire         NMI,         // No mask interrupt
    input  wire         RXEV,        // Receive Event signal

    input  wire         WICLOAD,     // WIC mask load from core
    input  wire         WICCLEAR,    // WIC mask clear from core
    input  wire  [31:0] WICMASKISR,  // WIC interrupt sensitivity mask
    input  wire         WICMASKNMI,  // WIC NMI sensitivity mask
    input  wire         WICMASKRXEV, // WIC event sensitivity mask
    input  wire         WICENREQ,    // WIC enable request from PMU
    input  wire         WICDSACKn,   // WIC enable ack from core

    output wire         WAKEUP,      // Wake up request to PMU
    output wire [33:0]  WICSENSE,    // IRQ, NMI and RXEV sensitivity
    output wire [31:0]  WICPENDISR,  // Pended interrupt request
    output wire         WICPENDNMI,  // Pended NMI interrupt request
    output wire         WICPENDRXEV, // Pended event interrupt request
    output wire         WICDSREQn,   // WIC enable request to core
    output wire         WICENACK);   // WIC enable ack to PMU

  // --------------------------------------------------------------------------
  // Regs
  // --------------------------------------------------------------------------
  wire [31:0] mask_q;          // interrupt mask register
  wire [31:0] pend_q;          // interrupt pend register
  reg         wic_actv_q;
  reg         wic_ds_req_q;
  reg         wic_en_ack_q;

  // --------------------------------------------------------------------------
  // Configurability
  // --------------------------------------------------------------------------

  wire [31:0] irq_dis      = IRQDIS[31:0];

  wire [31:0] wiclines_m   = { (WICLINES > 33), (WICLINES > 32),
                               (WICLINES > 31), (WICLINES > 30),
                               (WICLINES > 29), (WICLINES > 28),
                               (WICLINES > 27), (WICLINES > 26),
                               (WICLINES > 25), (WICLINES > 24),
                               (WICLINES > 23), (WICLINES > 22),
                               (WICLINES > 21), (WICLINES > 20),
                               (WICLINES > 19), (WICLINES > 18),
                               (WICLINES > 17), (WICLINES > 16),
                               (WICLINES > 15), (WICLINES > 14),
                               (WICLINES > 13), (WICLINES > 12),
                               (WICLINES > 11), (WICLINES > 10),
                               (WICLINES >  9), (WICLINES >  8),
                               (WICLINES >  7), (WICLINES >  6),
                               (WICLINES >  5), (WICLINES >  4),
                               (WICLINES >  3), (WICLINES >  2)
                             };

  wire [31:0] cfg_wiclines = wiclines_m & (~irq_dis);

  //----------------------------------------------------------------------------
  // WIC enable handshake
  //----------------------------------------------------------------------------
  // Request WIC mode sleep if PMU request is asserted
  wire                wic_ds_req_set = WICENREQ & WICDSREQn;
  wire                wic_ds_req_clr = ~WICDSREQn & ~WICENREQ;

  always @(posedge FCLK or negedge RESETn)
    if(~RESETn)
      wic_ds_req_q <= 1'b0;
    else if (wic_ds_req_set | wic_ds_req_clr)
      wic_ds_req_q <= wic_ds_req_set;

  // Acknowledge PMU request if core accepts
  wire                wic_en_ack_set = ~WICDSACKn & ~WICENACK;
  wire                wic_en_ack_clr = WICENACK & WICDSACKn;

  always @(posedge FCLK or negedge RESETn)
    if(~RESETn)
      wic_en_ack_q <= 1'b0;
    else if (wic_en_ack_set | wic_en_ack_clr)
      wic_en_ack_q <= wic_en_ack_set;

  //----------------------------------------------------------------------------
  // LOAD/CLEAR WIC NMI & RXEV sensitivity
  //----------------------------------------------------------------------------

  // Set mask value depending on operation
  wire       nxt_mask_nmi  = WICLOAD & WICMASKNMI;
  wire       nxt_mask_rxev = WICLOAD & WICMASKRXEV;
  reg        mask_nmi_q;
  reg        mask_rxev_q;

  wire       mask_en       = (WICCLEAR | WICLOAD);

  always @(posedge FCLK or negedge RESETn)
    begin
      if (~RESETn)
      begin
        mask_nmi_q  <= 1'b0;
        mask_rxev_q <= 1'b0;
      end
      else
      begin
        if (mask_en)
        begin
          mask_nmi_q  <= nxt_mask_nmi;
          mask_rxev_q <= nxt_mask_rxev;
        end
      end
    end

  //----------------------------------------------------------------------------
  // LOAD/CLEAR WIC IRQ sensitivity
  //----------------------------------------------------------------------------

  genvar i0;

  generate
  if (WICLINES > 2) begin: gen_wicsense

  wire [WICLINES-3:0] nxt_mask_irq;
  reg  [WICLINES-3:0] mask_irq_q;


  // Set mask value depending on operation
  assign nxt_mask_irq = {WICLINES-2{WICLOAD}} & WICMASKISR[WICLINES-3:0];

  for(i0 = 0; i0 < 32; i0 = i0 + 1) begin : gen_wic_sense
     if((WICLINES > (i0 + 2)) && (IRQDIS[i0] == 1'b0)) begin : gen_wic_sense_reg
        always @(posedge FCLK or negedge RESETn)
          if (~RESETn)
            mask_irq_q[i0] <= 1'b0;
          else
            if (mask_en)
              mask_irq_q[i0] <= nxt_mask_irq[i0];

        assign mask_q[i0] = mask_irq_q[i0];

     end else begin : gen_wic_sense_zero
        assign mask_q[i0] = 1'b0;
     end
  end

  end else begin: gen_no_wicsense

  assign mask_q = {32{1'b0}};

  end
  endgenerate

  wire [33:0] wic_sense = {mask_q, mask_nmi_q, mask_rxev_q};

  //----------------------------------------------------------------------------
  // Pend NMI & RXEV interrupts
  //----------------------------------------------------------------------------

  reg         pend_nmi_q;
  reg         pend_rxev_q;
  wire        nxt_pend_nmi    = ~WICCLEAR & (NMI  | pend_nmi_q);
  wire        nxt_pend_rxev   = ~WICCLEAR & (RXEV | pend_rxev_q);

  wire        pend_wr_en      = (WICLOAD | wic_actv_q);
  wire        pend_nmi_wr_en  = pend_wr_en & (WICCLEAR | NMI);
  wire        pend_rxev_wr_en = pend_wr_en & (WICCLEAR | RXEV);

  // NMI/RXEV pend register
  always @(posedge FCLK or negedge RESETn)
    begin
    if (~RESETn)
      begin
      pend_nmi_q  <= 1'b0;
      pend_rxev_q <= 1'b0;
      end
    else
      begin
      if (pend_nmi_wr_en)
          pend_nmi_q  <= nxt_pend_nmi;
      if (pend_rxev_wr_en)
          pend_rxev_q <= nxt_pend_rxev;
      end
    end

  //----------------------------------------------------------------------------
  // Pend IRQ interrupts
  //----------------------------------------------------------------------------

  genvar i1;

  generate
  if (WICLINES > 2) begin: gen_wicpend

  reg  [WICLINES-3:0] pend_irq_q;
  wire [WICLINES-3:0] nxt_pend_irq   = {WICLINES-2{~WICCLEAR}} &
                                       (IRQ[WICLINES-3:0] | pend_irq_q);

  wire        pend_irq_wr_en = pend_wr_en & (WICCLEAR | (|IRQ));

  for(i1 = 0; i1 < 32; i1 = i1 + 1) begin : gen_wic_pend
     if((WICLINES > (i1 + 2)) && (IRQDIS[i1] == 1'b0)) begin : gen_wic_pend_reg
        always @(posedge FCLK or negedge RESETn)
          if (~RESETn)
            pend_irq_q[i1] <= 1'b0;
          else
            if (pend_irq_wr_en)
              pend_irq_q[i1] <= nxt_pend_irq[i1];

        assign pend_q[i1] = pend_irq_q[i1];

     end else begin : gen_wic_pend_zero
        assign pend_q[i1] = 1'b0;
     end
  end

  end else begin: gen_no_wicpend

  assign pend_q = {32{1'b0}};

  end
  endgenerate

  wire [33:0] wic_pend = {pend_q, pend_nmi_q, pend_rxev_q};

  //----------------------------------------------------------------------------
  // Active status register
  //----------------------------------------------------------------------------
  always @(posedge FCLK or negedge RESETn)
    if (~RESETn)
      wic_actv_q <= 1'b0;
    else if (WICLOAD | WICCLEAR)
      wic_actv_q <= WICLOAD;

  //----------------------------------------------------------------------------
  // Request wake-up
  //----------------------------------------------------------------------------
  // Wake up if something has been pended that is observed
  wire        wake_up = (|(wic_pend & wic_sense));

  //----------------------------------------------------------------------------
  // Output assignments
  //----------------------------------------------------------------------------
  assign      WAKEUP      = wake_up;
  assign      WICSENSE    = (wic_sense & {cfg_wiclines, 2'b11}) ;
  assign      WICPENDISR  = (pend_q  & cfg_wiclines) | IRQ;
  assign      WICPENDNMI  = (pend_nmi_q  | NMI);
  assign      WICPENDRXEV = (pend_rxev_q | RXEV);
  assign      WICDSREQn   = ~wic_ds_req_q;
  assign      WICENACK    = wic_en_ack_q;

endmodule
