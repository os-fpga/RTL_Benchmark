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
//   Filename:           gem_pcs_rx_fault.v
//   Module Name:        gem_pcs_rx_fault
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
//   Description :            This module monitors the data and control signals
//                            coming from XGMII interface for error sequences
//                            and generates link_status and an interrupt signal
//                            that indicates a change in the link status.
//
//------------------------------------------------------------------------------

// Include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module  gem_pcs_rx_fault (

  // System Signals
  input            rx_clk,               // receiver clock
  input            n_rx_reset,           // reset
  input            link_fault_signal_en, // 802.3cb link fault signalling enabled
  input            sync_status,          // synchronization status

  // Signals coming from pipeline
  input     [15:0] rx_code,              // datapath enable
  input      [1:0] rx_control,           // control

  // Output signals
  output reg [1:0] link_fault_status     // 00 - OK; 01 - local fault; 10 - remote fault; 11 - link interruption

);

  // Internal Signals
  reg [2:0]     last_seq_type;     // last error sequence type received
  reg [8:0]     col_count;         // counts good words received in
                                   // consecution
  reg [1:0]     current_state;     // current state of the state  machine
  reg [1:0]     next_state;        // next state of the state machine
  reg [1:0]     seq_cnt;           // counts error sequences of same type

  wire          col_done;          // indicates 128 good words received in
                                   // consecution

  wire          c5;                // condition for driving state machine
                                   // and seq_cnt
  wire          c6;                // condition for driving state machine
                                   // and seq_cnt
  wire          cond_s0;           // condition for driving state machine
  wire          cond_s1;           // condition for driving state machine
  wire          cond_s2;           // condition for driving state machine
  wire          cond_s3;           // condition for driving state machine
  wire          fault_sequence;    // false sequence detected
  wire [2:0]    fault;             // fault type


  reg [1:0]     data_Z_1to0;
  reg [1:0]     data_Z_1to0_nxt;
  reg           valid_fault_nxt;
  reg           valid_fault;
  reg           seq_oset_det;
  reg [1:0]     det_fault_seq_nxt_state;
  reg [1:0]     det_fault_seq_state;
  reg           det_s0_7;
  reg           valid_fault_s0;
  wire          os_boundary_det;

  parameter S0    = 2'b00;
  parameter S1    = 2'b01;
  parameter S2    = 2'b10;
  parameter S3    = 2'b11;

  parameter IDLE  = 2'b00;
  parameter COUNT = 2'b01;
  parameter FAULT = 2'b10;

//------------------------------------------------------------------------------
// rx_code is simply the decoded stream. All we can be sure about is that the
// start of the fault will occur at some point on [7:0].
// The sequence ordered set will appear from the PMA as:
//
//   /K28.5/W0/K28.5/W1/K28.5/W2/K28.5/W3
//
// Where /W0/, /W1/, /W2/, /W3/ are the 10-bit /Dx.y/ version of S0, S1, S2, S3
// as defined per 127.2.4.2 and will never have a value of /D5.6/, /D16.2/,
// /D6.5/, /D26.4/.
//
// In order for the remainder of this module to operate, we need to first
// convert to XGMII:
//
// if (S0<7>, S1<7>, S2<7>, S3<7> = 0110) then output
//    XGMII = Sequence, Data X, Data Y, Data Z where
//      Sequence = 0x9c
//      Data X<7:0> = S1<1:0>, S0<5:0>
//      Data Y<7:0> = S2<3:0>, S1<5:2>
//      Data Z<7:0> = S3<5:0>, S2<5:4>
// else
//    XGMII = Idle, Idle, Idle, Idle
//      Idle = 0x07
//------------------------------------------------------------------------------

  assign os_boundary_det = {rx_control[0],rx_code[7:0]}  == 9'h1bc &&
                           {rx_control[1],rx_code[15]}   == 2'b01 &&
                           det_s0_7;

  always @(*)
  begin
    seq_oset_det    = 1'h0;
    data_Z_1to0_nxt = 2'b00;
    valid_fault_nxt = valid_fault;
    case (det_fault_seq_state)
      S0 :
      begin
        // Data X is always 0x00 for all 3 fault types.
        // Data X[5:0] = S0[5:0].
        valid_fault_nxt = {rx_control[1],rx_code[15:8]} == 9'h000;
        if (os_boundary_det)
        begin
          valid_fault_nxt = valid_fault_s0 && {rx_control[1],rx_code[15:8]} == 9'h0c0;
          det_fault_seq_nxt_state = S2;
        end
        else if ({rx_control[0],rx_code[7:0]} == 9'h1bc &&
                 {rx_control[1],rx_code[15]}  == 2'b00)
          det_fault_seq_nxt_state = S1;
        else
          det_fault_seq_nxt_state = det_fault_seq_state;
      end

      S1 :
      begin
        // Data X and Y are always 0x00 for all 3 fault types.
        // Data Y[3:0], Data X[7:6] = S1[5:0].
        // S1[7:6] is always 2'b11 for fault sequence sets.
        valid_fault_nxt = valid_fault && {rx_control[1],rx_code[15:8]} == 9'h0c0;
        if (os_boundary_det)
        begin
          valid_fault_nxt = valid_fault_s0 && {rx_control[1],rx_code[15:8]} == 9'h0c0;
          det_fault_seq_nxt_state = S2;
        end
        else
          det_fault_seq_nxt_state = S0;
      end

      S2 :    // Note that Data Z[3:0] holds the fault sequence type
              // (1=local, 2=remote, 3=link interruption).
              // Bits [1:0] of the data Z are in S2[5:4].
      begin
        // Data Y is always 0x00 for all 3 fault types.
        // Data Z[7:2] is always 0x00 for all 3 fault types.
        // Data Z[1:0] defines the fault type:
        //   S2<5:0> = Data Z<1:0>, Data Y<7:4>.
        // S2[7:6] is always 2'b11 for fault sequence sets.
        valid_fault_nxt = valid_fault && {rx_control[1],rx_code[15:14],rx_code[11:8]} == 7'b0110000;
        data_Z_1to0_nxt = rx_code[13:12];
        if (os_boundary_det)
        begin
          valid_fault_nxt = valid_fault_s0 && {rx_control[1],rx_code[15:8]} == 9'h0c0;  // it is thought this will always evalate to zero because valid_fault_s0 can never be 1 in state S2 - see ETH-1004
          det_fault_seq_nxt_state = S2;
        end
        else if ({rx_control[0],rx_code[7:0]} == 9'h1bc &&
                {rx_control[1],rx_code[15]}   == 2'b01)
          det_fault_seq_nxt_state = S3;
        else
          det_fault_seq_nxt_state = S0;
      end

      default : // S3. Bits [3:2] of the data Z are in S3[1:0].
      begin
        // Data Z is 0x01 for local fault.
        // Data Z is 0x02 for remote fault.
        // Data Z is 0x03 for link interruption fault:
        //   S3<5:0> = Data Z<7:2>.
        // S2[7:6] is always 2'b00 for fault sequence sets.
        valid_fault_nxt = valid_fault && {rx_control[1],rx_code[15:8]} == 9'h000;
        if (os_boundary_det)
        begin   // this block is understood to be unreachable because os_boundary_det cannot be 1 in state S3 - see ETH-1004
          valid_fault_nxt = valid_fault_s0 && {rx_control[1],rx_code[15:8]} == 9'h0c0;
          det_fault_seq_nxt_state = S2;
        end
        else
          det_fault_seq_nxt_state = S0;
        if ({rx_control[0],rx_code[7:0]} == 9'h1bc &&
            {rx_control[1],rx_code[15]}  == 2'b00)
          seq_oset_det = 1'b1;
      end
    endcase
  end

  always@(posedge rx_clk or negedge n_rx_reset)
  begin
     if (~n_rx_reset)
       begin
         data_Z_1to0         <= 2'b00;
         valid_fault         <= 1'b0;
         det_fault_seq_state <= S0;
         det_s0_7            <= 1'b0;
         valid_fault_s0      <= 1'b0;
       end
     else
       begin
         data_Z_1to0         <= data_Z_1to0_nxt;
         valid_fault         <= valid_fault_nxt;
         det_fault_seq_state <= det_fault_seq_nxt_state;
         det_s0_7            <= ({rx_control[0],rx_code[7:0]} == 9'h1bc &&
                                 {rx_control[1],rx_code[15]}  == 2'b00);
         valid_fault_s0      <= {rx_control[1],rx_code[15:8]} == 9'h000;
       end
  end

  // Sense for local fault sequence
  assign fault[0] = seq_oset_det && valid_fault_nxt && data_Z_1to0 == 2'h1;
  // Sense for remote fault sequence
  assign fault[1] = seq_oset_det && valid_fault_nxt && data_Z_1to0 == 2'h2;
  // Sense for link interruption sequence
  assign fault[2] = seq_oset_det && valid_fault_nxt && data_Z_1to0 == 2'h3;

  // Detects if the data is fault sequence
  assign  fault_sequence = |fault;

//------------------------------------------------------------------------------
// This piece of logic stores the fault sequence type for comparison on the
// arrival of next fault sequence. The select depends on the number of faulty
// columns received.
//------------------------------------------------------------------------------

   always@(posedge rx_clk or negedge n_rx_reset)
   begin
     if (~n_rx_reset)
       last_seq_type <= 3'b000;
     else
       begin
          if (~link_fault_signal_en) // if LFSM disabled
            last_seq_type <= 3'b000;
          else if (fault_sequence)
            last_seq_type <= fault;
       end
   end

//------------------------------------------------------------------------------
// Various conditions to be used in running seq_cnt and state machine.
//------------------------------------------------------------------------------

  // Case when fault type is different from previous fault sequence received
  assign c5 = fault_sequence && fault != last_seq_type ;

  // Case when fault type is same as that of  previous fault sequence received
  assign c6 = fault_sequence & fault == last_seq_type ;

//------------------------------------------------------------------------------
// State transition conditions.
//------------------------------------------------------------------------------

  // Detection of fault sequence, delayed by one clock period to meet the timing
  // requirements for state machine
  assign cond_s0 = fault_sequence ;

  // Case when when four fault sequences of same type are received continually
  // and no pair of fault sequences are separated by 128 good columns
  assign cond_s1 = (c6 & (seq_cnt == 2'b11));

  // Case when there is a mismatch between fault types either in  both the fault
  // sequence received or between the current fault sequence and the previous
  // fault sequence
  assign cond_s2 = c5 ;

  // Condition when 128 good columns are received in consecution with out any
  // intervening faulty column
  assign cond_s3 = col_done;

//------------------------------------------------------------------------------
// This state machine controls the output signals. It detects the occurrence of
// four fault sequences of same type (either local fault or remote fault) and
// hence its states are used to drive remote_fault and local_fault outputs.
// There are 3 states in the state machine:
//
// State 1 - is an idle state
// State 2 - which counts the fault sequences of same type
// State 3 - indicates that 4 fault sequences of same are occurred and hence
//           is used to drive fault outputs
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// State Machine Sequential Process
//------------------------------------------------------------------------------

  always@(posedge rx_clk or negedge n_rx_reset)
  begin
    if (~n_rx_reset)
      current_state <= IDLE;
    else
      begin
         if (~link_fault_signal_en) // if LFSM disabled
           current_state <= IDLE;
         else
           current_state <= next_state;
      end
  end

//------------------------------------------------------------------------------
// State Machine Combinatorial Logic
//------------------------------------------------------------------------------

  always@(*)
  begin
    case (current_state)
      IDLE:
        if (cond_s0)
          next_state        = COUNT;
        else
          next_state        = current_state;
      COUNT:
        begin
          if (cond_s1)
            next_state      = FAULT;
          else
            begin
              if (cond_s3)
                next_state  = IDLE;
              else
                next_state  = current_state;
            end
        end
      default: //FAULT
        begin
          if (cond_s2)
            next_state      = COUNT;
          else
            begin
               if (cond_s3)
                 next_state = IDLE;
               else
                 next_state = current_state;
            end
        end
    endcase
  end

//------------------------------------------------------------------------------
// Error sequence counter, it counts error sequence of same type without any
// intervening 128 good words between any pair of fault sequences.
// If error type changes it gets reset to 1.
// When 128 good columns occurs in succession, it get reset to value 0.
//------------------------------------------------------------------------------

  always@(posedge rx_clk or negedge n_rx_reset)
  begin
     if (~n_rx_reset)
       seq_cnt <= 2'b00;
     else
       begin
          if (~link_fault_signal_en) // if LFSM disabled
            seq_cnt <= 2'b00;
          else
          begin
            if (fault_sequence)
              begin
                if (c5)
                  seq_cnt <= 2'b01;
                else if (c6 & (seq_cnt != 2'b11))
                  seq_cnt <= seq_cnt + 1'b1;
              end
            else if (col_done)
              seq_cnt <= 2'b00;
          end
       end
  end

//------------------------------------------------------------------------------
// 8-bit modulo counter that counts number of columns not containing a fault
// sequence received in succession and gets reset every time a fault sequence
// occurs.
//------------------------------------------------------------------------------

  always@(posedge rx_clk or negedge n_rx_reset)
  begin
    if (~n_rx_reset)
      col_count <= 9'h000;
    else
      begin
        if (~link_fault_signal_en) // if LFSM disabled
          col_count <= 9'h000;
        else
          begin
            if (fault_sequence) // causes reset to value 0 or 1
              col_count <= 9'h000;
            else // increment
              col_count <= (col_count[7:0] + 8'h01);
          end
      end
  end

//------------------------------------------------------------------------------
// Indicates when 128 good words has received without any intervening error
// sequence. The col_count is a 9-bit modulo counter whose 9th bit indicates the
// reception of 128 good columns in succession.
//------------------------------------------------------------------------------

  assign col_done = col_count[8];

//------------------------------------------------------------------------------
// Final Output
//------------------------------------------------------------------------------
// link_fault_status: 00 - OK; 01 - local fault; 10 - remote fault; 11 - link interruption
// last_seq_type: [0] - local fault; [1] - remote fault; [2] - link interruption

  always@(posedge rx_clk or negedge n_rx_reset)
  begin
    if (~n_rx_reset)
      link_fault_status <= 2'b01;
    else
      begin
        if (~link_fault_signal_en) // if LFSM disabled
	  // make initial state of link_fault_status either remote fault or OK depending on sync_status to prevent a link fault from being generated as the LFSM is enabled
          link_fault_status <= {1'b0,~sync_status};
        else if (~sync_status) // signal local fault until synchronization has been acquired
          link_fault_status <= 2'b01;
        else
          begin
            if ((current_state == COUNT) & (next_state == FAULT))
              begin
                link_fault_status[0] <= last_seq_type[2] || last_seq_type[0]; // link_interruption || local_fault
                link_fault_status[1] <= last_seq_type[2] || last_seq_type[1]; // link_interruption || remote_fault
              end
            else if ((current_state == IDLE) || (next_state == IDLE))
              link_fault_status <= 2'b00;
          end
      end
  end

endmodule
