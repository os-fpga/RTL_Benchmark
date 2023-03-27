//------------------------------------------------------------------------------
// Copyright (c) 2015-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_tfc_shaper.v
//   Module Name:        edma_tfc_shaper
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
//   Description  : Performs traffic shaping on the two highest priority
//                  queues as per 802.1Qav.
//                  Uses signed-magnitude addition where the MSB indicates
//                  the sign.
//------------------------------------------------------------------------------

module edma_tfc_shaper (

    // system signals
    clk,
    rst_n,
    complete_flush,

    // inputs from registers
    cbs_enable_q_a,
    cbs_enable_q_b,
    idleslope_q_a,
    idleslope_q_b,
    port_tx_rate,

    // Inputs
    packets_in_q_a,
    packets_in_q_b,
    cbs_dma_q_a,
    cbs_dma_q_b,
    mac_txing_dma_frame,

    // outputs
    cbs_queue
);

parameter P_PREAMBLE = 5'd8; // 8 bytes of preamble
parameter P_CRC      = 4'd4; // 4 bytes of preamble

// -----------------------------------------------------------------------------
// Port Declarations
// -----------------------------------------------------------------------------

   // system signals.
   input        rst_n;                      // active low async reset
   input        clk;                        // transmit clock
   input        complete_flush;             // soft reset (tx_enable)
   input        cbs_enable_q_a;             // Enable CBS on queue 0
   input        cbs_enable_q_b;             // Enable CBS on queue 1
   input [31:0] idleslope_q_a;              // idleSlope for queue 0
   input [31:0] idleslope_q_b;              // idleSlope for queue 1
   input [31:0] port_tx_rate;               // Transmit Rate
   input        packets_in_q_a;             // Frames are pending for highest priority queue
   input        packets_in_q_b;             // Frames are pending for lowest priority queue
   input        cbs_dma_q_a;                // Queue A is selected
   input        cbs_dma_q_b;                // Queue B is selected
   input        mac_txing_dma_frame;        // Mac is transmitting

   output [1:0] cbs_queue;                  // Next CBS queue to be serviced

// -----------------------------------------------------------------------------
// Type Declarations
// -----------------------------------------------------------------------------


   // Two jumbo frames will use up 42 bits to count in bytes
   // 1 additional bit added for overflow - bit 43
   // 1 additonal bit for signed representation - bit 44
   reg    [44:0] credit_q_a;           // Tx credit available for queue 0
   reg    [44:0] credit_q_b;           // Tx credit available for queue 1
   wire   [31:0] sendslope_q_a;        // Rate of change of credit for queue 0
   wire   [31:0] sendslope_q_b;        // Rate of change of credit for queue 1
   wire   [31:0] port_tx_rate;         // Max bandwidth of MAC
   wire   [31:0] total_data_q_a;       // last data includes CRC and Preamble
   wire   [31:0] total_data_q_b;       // last data includes CRC and Preamble

   reg     [1:0] cbs_queue;            // cbs queue

   wire          credit_non_neq_q_a;   // Allow transmit of queue 0
   wire          credit_non_neq_q_b;   // Allow transmit of queue 1
   wire          mac_txing_q_a;        // High priority queue is transmitting
   wire          mac_txing_q_b;        // Low priority queue is transmitting
   wire          not_reading_q_a;      // High queue not being accessed
   wire          not_reading_q_b;      // Low queue not being accessed
   wire          rst_q_a;              // Various conditinos can reset credit
   wire          rst_q_b;              // Various conditinos can reset credit
//   wire          prioritise_q_a;       // Prioritise high queue over low queue

   wire   [44:0] pre_calc_pos_inc_q_a;
   wire   [44:0] pre_calc_pos_inc_q_b;
   wire          block_pos_inc_q_a;
   wire          block_pos_inc_q_b;
   wire   [44:0] pre_calc_neg_inc_q_a;
   wire   [44:0] pre_calc_neg_inc_q_b;
   wire          block_neg_inc_q_a;
   wire          block_neg_inc_q_b;

// -----------------------------------------------------------------------------
// Main Code
// -----------------------------------------------------------------------------



// Transmit is allowed when credit is positive
  assign credit_non_neq_q_a = (~credit_q_a[44]);
  assign credit_non_neq_q_b = (~credit_q_b[44]);

// Indicate packet is being transmitted for that queue
  assign mac_txing_q_a = cbs_dma_q_a & mac_txing_dma_frame;
  assign mac_txing_q_b = cbs_dma_q_b & mac_txing_dma_frame;

// Rate of change of credit when transmitting
// reversed formuals from that defined in spec so result is a positive number
// to subtract from credit when transmitting.
  assign sendslope_q_a = port_tx_rate - idleslope_q_a;
  assign sendslope_q_b = port_tx_rate - idleslope_q_b;

// Idle when waiting to send packet so allow credit to increment
// Gated at the end of the packet to allow the additonal bytes due to preamble,
// crc, etc to be added.
  assign not_reading_q_a = ~mac_txing_q_a;
  assign not_reading_q_b = ~mac_txing_q_b;

// Reset credit when:
// (1) Enable is turned off
// (2) There is no more data to be serviced and the credit is positive
  assign rst_q_a = (~cbs_enable_q_a | complete_flush |
                     (~packets_in_q_a & ~mac_txing_q_a & credit_non_neq_q_a));

  assign rst_q_b = (~cbs_enable_q_b | complete_flush |
                     (~packets_in_q_b & ~mac_txing_q_b & credit_non_neq_q_b));

// High priority queue only has priority when it has more positive credit than queue1
// removed this on 26th May 2015
//  assign prioritise_q_a = (((~credit_q_a[44] & ~credit_q_b[44] &
//                            (credit_q_a[43:0] >= credit_q_b[43:0])) |
//                           (~credit_q_a[44] & (credit_q_b[44] | ~packets_in_q_b)))
//                            & packets_in_q_a) ? 1'b1 : 1'b0;

// Add additional bytes to account for CRC and preamble
  assign total_data_q_a = sendslope_q_a;
  assign total_data_q_b = sendslope_q_b;


// Block credit from incrementing too high and rolling over
// Currently set to the same for all speeds.
// By design, the integration of this module with the
// GEM core will prevent counters reaching an artificially
// high value as jumbo frames cannot be sent in store and forward
// configuration so this is just additonal protection.

assign pre_calc_pos_inc_q_a  = (credit_q_a[43:0] +
                               {12'h000, idleslope_q_a[31:0]});
assign block_pos_inc_q_a     = pre_calc_pos_inc_q_a[43];

assign pre_calc_pos_inc_q_b  = (credit_q_b[43:0] +
                              {12'h000, idleslope_q_b[31:0]});
assign block_pos_inc_q_b     = pre_calc_pos_inc_q_b[43];

assign pre_calc_neg_inc_q_a  = (credit_q_a[43:0] +
                               {12'h000, total_data_q_a[31:0]});
assign block_neg_inc_q_a     = pre_calc_neg_inc_q_a[43];

assign pre_calc_neg_inc_q_b  = (credit_q_b[43:0] +
                               {12'h000, total_data_q_b[31:0]});
assign block_neg_inc_q_b     = pre_calc_neg_inc_q_b[43];


// Keep track of the available credit - queue A - Highest Queue
// Positive value
// signed-magnitude addition
// MSB indicates sign - remaining bit represent magnitude
  always@(posedge clk or negedge rst_n)
  begin
    if (~rst_n)
      credit_q_a <= 45'd0;
    else if (rst_q_a)
      credit_q_a <= 45'd0;
    else if (not_reading_q_a)
      begin
        if (block_pos_inc_q_a)
          credit_q_a <= credit_q_a;

        // If credit is +ve and we are adding then just do addition
        else if (~credit_q_a[44])
          credit_q_a <= {credit_q_a[44], (credit_q_a[43:0] +
                         {12'h000, idleslope_q_a[31:0]})};
        // Credit is -ve and larger than idelslope
        // result is -ve
        else if (credit_q_a[43:0] > {12'h000, idleslope_q_a})
          credit_q_a <= {credit_q_a[44], (credit_q_a[43:0] -
                         {12'h000, idleslope_q_a[31:0]})};
        // Credit is -ve, and smaller than idleslope
        // result is +ve
        else if (credit_q_a[43:0] < {12'h000, idleslope_q_a[31:0]})
          credit_q_a <= {1'b0, ({12'h000, idleslope_q_a[31:0]} -
                         credit_q_a[43:0])};
        // Credit is -ve and adding idleslope of same magnitude
        else //if (credit_q_a[43:0] == {12'h000, idleslope_q_a[31:0]})
          credit_q_a <= 45'd0;
        //else
        //  credit_q_a <= credit_q_a;
      end
    else //if (mac_txing_q_a)
      begin
       if (~credit_q_a[44])
         begin
         if (credit_q_a[43:0] > {12'h000, total_data_q_a[31:0]})
           credit_q_a <= {credit_q_a[44], (credit_q_a[43:0] -
                          {12'h000, total_data_q_a[31:0]})};
         else if (credit_q_a[43:0] < {12'h000, total_data_q_a[31:0]})
           credit_q_a <= {1'b1, ({12'h000, total_data_q_a[31:0]} -
                          credit_q_a[43:0])};
         else //if (credit_q_a[43:0] == {12'h000, total_data_q_a[31:0]})
           credit_q_a <= 45'd0;
         end
       else if (~block_neg_inc_q_a)
         credit_q_a <= {credit_q_a[44], (credit_q_a[43:0] +
                        {12'h000, total_data_q_a[31:0]})};
       else
         credit_q_a <= credit_q_a;
      end
  end


// Keep track of the available credit - queue B
// Positive value
// signed-magnitude addition
// MSB indicates sign - remaining bit represent magnitude
  always@(posedge clk or negedge rst_n)
  begin
    if (~rst_n)
      credit_q_b <= 45'd0;
    else if (rst_q_b)
      credit_q_b <= 45'd0;
    else if (not_reading_q_b)
      begin
        if (block_pos_inc_q_b)
          credit_q_b <= credit_q_b;
        else if (~credit_q_b[44]) // both positive
          credit_q_b <= {credit_q_b[44], (credit_q_b[43:0] +
                         {12'h000, idleslope_q_b[31:0]})};
        else if (credit_q_b[43:0] > {12'h000, idleslope_q_b})
          credit_q_b <= {credit_q_b[44], (credit_q_b[43:0] -
                         {12'h000, idleslope_q_b[31:0]})};
        else if (credit_q_b[43:0] < {12'h000, idleslope_q_b[31:0]})
          credit_q_b <= {1'b0, ({12'h000, idleslope_q_b[31:0]} -
                         credit_q_b[43:0])};
        else
          credit_q_b <= 45'd0;
      end

    else //if (mac_txing_q_b)
      begin
       if (~credit_q_b[44])
         begin
         if (credit_q_b[43:0] > {12'h000, total_data_q_b[31:0]})
           credit_q_b <= {credit_q_b[44], (credit_q_b[43:0] -
                          {12'h000, total_data_q_b[31:0]})};
         else if (credit_q_b[43:0] < {12'h000, total_data_q_b[31:0]})
           credit_q_b <= {1'b1, ({12'h000, total_data_q_b[31:0]} -
                          credit_q_b[43:0])};
         else //if (credit_q_b[43:0] == {12'h000, total_data_q_b[31:0]})
           credit_q_b <= 45'd0;
         end
       else if (~block_neg_inc_q_b)
         credit_q_b <= {credit_q_b[44], (credit_q_b[43:0] +
                        {12'h000, total_data_q_b[31:0]})};
       else
         credit_q_b <= credit_q_b;
      end
  end


// Select which queue will be transmitted next.
// If both queues have positive credit the queue with the most credits will win
// This will be updated on each cycle and will reflect the current values of
// credit and will therefore be valid when the required queue_dma is updated.

// changed 26th May 2015 so that if both queues have positive credit the highest
// priority queue prevails
  always @(*)
  begin
    if (packets_in_q_a &
            (credit_non_neq_q_a & cbs_enable_q_a))
      cbs_queue = 2'b01;
    else if (packets_in_q_b &
            (credit_non_neq_q_b & cbs_enable_q_b))
      cbs_queue = 2'b10;
    else
      cbs_queue = 2'b00;
  end


endmodule


