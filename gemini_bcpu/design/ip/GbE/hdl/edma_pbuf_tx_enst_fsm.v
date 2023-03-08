//------------------------------------------------------------------------------
// Copyright (c) 2015-2020 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_tx_enst_fsm.v
//   Module Name:        edma_pbuf_tx_enst_fsm
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
//   Description    : This is a FSM, which is managing the signals for
//                    the compares. The compares are performed through different "check points".
//                    These "check points" are:
//                              1) Start - add_frag_size_time is =< tsu time
//                              2) tsu time >= start_time - add_frag_size_time
//                              3) tsu time >= start_time
//                              4) tsu time >= start_time + on_time
//                              5) tsu time >= start_time + on_time + off_time - add_frag_size_time
//                              6) tsu time >= start_time + on_time + off_time
//
//         In this module, the compare_value can be chosen between acc_early
//         and acc, where acc_early is simply acc - addfragsize_count.
//         One of the function of the FSM is controlling the signals that are
//         selecting the value of the compare_value, depending whether we have
//         to check the 1st rather than 2nd checkpoint, or 4th rather than 5th.
//         In this way, if we are waiting for the early start (WOES) we will be
//         checking the acc_early, that would be start_time - addfragsize_count.
//         After that we will be waiting for the start (WOS), so we would be
//         checking for the acc value, that would be loaded with the on_time,
//         and so on...
//         The comparison is a "equal or greater than" because the tsu_time
//         can increment its value in a non-uniform way, so it would be
//         possible that we can miss the exact value, that's why we want
//         to use the condition ">=" instead of "=".
//
//------------------------------------------------------------------------------


//module definition
module edma_pbuf_tx_enst_fsm (
   input           tsu_clk,       // clk signal
   input           n_tsureset,    // reset signal
   input           enst_en_tsu,   // Enable signal for the queue
   input [93:16]   tsu_timer_cnt, // tsu time
   input  [31:0]   start_time,    // start time
   input  [16:0]   on_time,       // Number of bytes that are desidered to be transferred in the on_time(nsec). We will use this formula for the calculation of the on_time(nsec):
                                  // on_time(bytes) = on_time(nsec) * rate /8 => on_time(nsec) = 8 *(on_time(bytes) / rate).
                                  //   @ 2.5 Gbps the user will have to program the register with on_time(bytes)/2.5 !
                                  //   @ 1   Gbps the user will have to program the register with on_time(bytes)
                                  //   @ 100 Mbps the user will have to program the register with on_time(bytes)
                                  //   @ 10  Mbps the user will have to program the register with on_time(bytes)
   input [16:0]    off_time,      // off time expressed in bytes. As for the on_time input, the equation is the same:
                                  // off_time(bytes) = off_time(nsec) * rate /8 => off_time(nsec) = 8 *(off_time(bytes) / rate).
                                  //    @ 2.5 Gbps the user will have to program the register with off_time(bytes)/2.5 !
                                  //    @ 1   Gbps the user will have to program the register with off_time(bytes)
                                  //    @ 100 Mbps the user will have to program the register with off_time(bytes)
                                  //    @ 10  Mbps the user will have to program the register with off_time(bytes)
   input [1:0]     speed,         // This can encode 2.5 Gbps, 1Gbps, 100Mbps, 10Mbps:
                                  //   speed = 00 for 2.5 Gbps
                                  //   speed = 01 for 1   Gbps
                                  //   speed = 10 for 100 Mbps
                                  //   speed = 11 for 10  Mbps
   input [1:0]     add_frag_size, // This input encodes the number of bytes
                                  // that can be transferred before the pMAC
                                  // will have a chance to stop xmitting
                                  // to give the priority to the eMAC
                                  // 00 : 64  bytes
                                  // 01 : 128 bytes
                                  // 10:  192 bytes
                                  // 11:  256 bytes
   output reg      fsm_active,    // Indicates in the EnST process
   output reg      tsu_gatestate, // Indicates the queue is enabled to xmit
   output reg      tsu_hold       // 802.3br support signal
);

// -----------------------------------------------------------------------------
// Declaration of the signals and parameters
// -----------------------------------------------------------------------------

  wire [31:0] tsu_time;          // tsu_time
  wire        compare;           // Comparator
  wire        acc_load;          // Load accumulator
  wire        acc_on;            // Add on time to accumulator
  wire        acc_off;           // Add off time to accumulator
  wire        early;
  wire        tsu_time_wrap;
  wire [31:0] acc_early;
  reg  [31:0] acc;               // Accumulator.
  reg   [3:0] c_state;           // The current state of the FSM.
  reg   [3:0] n_state;           // The next    state of the FSM
  reg  [19:0] on_time_nsec;      // on_time_nsec = 8 * on_time(bytes) / rate
  reg  [19:0] off_time_nsec;     // on_time_nsec = 8 * on_time(bytes) / rate
  reg  [17:0] add_frag_size_time;
  reg  [31:0] compare_value;
  reg         tsu_time_30_reg;
  wire [19:0] on_time_x8;        // Shift and arithmetic operations on the
  wire [19:0] on_time_x2;        // on and off times to achieve effect of
  wire [20:0] on_time_x10;       // x10 and x100.
  wire [23:0] on_time_x10_x8;
  wire [23:0] on_time_x10_x2;
  wire [24:0] on_time_x100;
  wire [19:0] off_time_x8;
  wire [19:0] off_time_x2;
  wire [20:0] off_time_x10;
  wire [23:0] off_time_x10_x8;
  wire [23:0] off_time_x10_x2;
  wire [24:0] off_time_x100;
  wire [32:0] acc_p_on_time_nsec;
  wire [32:0] acc_p_off_time_nsec;
  wire [32:0] acc_wrap;

  parameter IDLE            = 4'b0000; // Idle
  parameter ACC_LD          = 4'b0001; // Load acc
  parameter EC              = 4'b0010; // Enable Check
  parameter WOES            = 4'b0011; // Wait on Early Start
  parameter WOS             = 4'b0100; // Wait on start
  parameter ACC_ON          = 4'b0101; // Load acc_on
  parameter WON             = 4'b0110; // Wait on state
  parameter ACC_OFF         = 4'b0111; // load acc off
  parameter WPE             = 4'b1000; // Wait for Early period
  parameter WP              = 4'b1001; // wait period

  parameter sm_2_5G         = 2'b00;   //speed: 2.5 Gbps
  parameter sm_1G           = 2'b01;   //speed: 1   Gbps
  parameter sm_100M         = 2'b10;   //speed: 100 Mbps
  parameter sm_10M          = 2'b11;   //speed: 10  Mbps

// -----------------------------------------------------------------------------
//  Beginning of code
// -----------------------------------------------------------------------------
//
  assign tsu_time      = tsu_timer_cnt[47:16];
  assign compare       = ((tsu_time >= compare_value) && ~tsu_time_wrap);

  // compare_value must be chosen accordingly to the early signal, which is
  // asserted when the FSM is waiting for one of the following:
  // tsu time >= start_time                      - add_frag_size_time
  // tsu time >= start_time + on_time + off_time - add_frag_size_time
  always @ *
  begin
    if(early)
      compare_value = acc_early;
    else
      compare_value = acc;
  end

  // State Machine
  // Sequential section
  always @ (posedge tsu_clk or negedge n_tsureset)
  begin
    if(~n_tsureset)
      c_state <= IDLE;
    else
      c_state <= n_state;
  end

  // State Machine
  // Combinatorial section
  always @ *
  begin
    if (~enst_en_tsu)
      n_state = IDLE;
    else
      case(c_state)
        IDLE:  n_state = ACC_LD;
        ACC_LD:n_state = EC;
        EC:    n_state = WOES;
        WOES:
        begin
          if(compare)
            n_state = WOS;
          else
            n_state = WOES;
        end
        WOS:
        begin
          if(compare)
            n_state = ACC_ON;
          else
            n_state = WOS;
        end
        ACC_ON: n_state = WON;
        WON:
        begin
          if(compare)
            n_state = ACC_OFF;
          else
            n_state = WON;
        end
        ACC_OFF: n_state = WPE;
        WPE:
        begin
          if(compare)
            n_state = WP;
          else
            n_state = WPE;
        end
        default: //WP
        begin
          if(compare)
            n_state = ACC_ON;
          else
            n_state = WP;
        end
      endcase
  end

  // Output Logic
  // We want to register all the signals crossing the domain
  // Because we don't want these signals to suffer from any glitch due
  // to the states transition and also it's a good use to register signals before
  // they will be sync-ed to reduce metastability risks.
  always @ (posedge tsu_clk or negedge n_tsureset)
  begin
    if(~n_tsureset)
      begin
        tsu_hold      <= 1'b0;
        tsu_gatestate <= 1'b1;
        fsm_active    <= 1'b0;
      end
    else
      begin
        tsu_hold      <= ((c_state == WOS)   ||(c_state == ACC_ON)||(c_state == WON)||(c_state==WP));
        tsu_gatestate <= ((c_state == ACC_ON)||(c_state == WON)   ||(c_state == IDLE));
        fsm_active    <=  (c_state != IDLE);
      end
  end

  // These signals can be combinatorial because some of them are used as a MUX selector
  // inside a sequential process (FSM), then any glitch won't have any effect on these
  assign acc_load      = (c_state  == ACC_LD);
  assign acc_on        = (c_state  == ACC_ON);
  assign acc_off       = (c_state  == ACC_OFF);
  assign early         = ((c_state == ACC_LD)||(c_state == EC)||(c_state == WOES)||(c_state == ACC_OFF)||(c_state == WPE));

  // Avoid using multipliers so perform 10x and 100x calculation through shift and add operations:
  assign on_time_x2   = {2'b00,on_time[16:0],1'b0}; // Shift and pad.
  assign on_time_x8   = {on_time[16:0],3'b000};     // Shift and pad.
  assign on_time_x10  = on_time_x2 + on_time_x8;
  assign off_time_x2  = {2'b00,off_time[16:0],1'b0}; // Shift and pad.
  assign off_time_x8  = {off_time[16:0],3'b000};     // Shift and pad.
  assign off_time_x10 = off_time_x2 + off_time_x8;

  // Cascade same operations to give 10x10
  assign on_time_x10_x2   = {2'b00,on_time_x10[20:0],1'b0}; // Shift and pad.
  assign on_time_x10_x8   = {on_time_x10[20:0],3'b000};     // Shift and pad.
  assign on_time_x100     = on_time_x10_x2 + on_time_x10_x8;
  assign off_time_x10_x2  = {2'b00,off_time_x10[20:0],1'b0}; // Shift and pad.
  assign off_time_x10_x8  = {off_time_x10[20:0],3'b000};     // Shift and pad.
  assign off_time_x100    = off_time_x10_x2 + off_time_x10_x8;

  // Calculation of the on_time_nsec and off_time_nsec using on_time, off_time, and speed
  // on_time_nsec and off_time_nsec cannot overflow because on_time and off_time register
  // should be set in order to keep their correspondant values in nanoseconds below 1.04 ms,
  // which can be represented with 20 bits.
  // For this reason all the warnings related to a possible overflow here can be waived.
  always @ *
    begin
      case (speed)
        sm_100M:
        begin                                                                                     
          on_time_nsec   = {on_time_x10[16:0],3'b000};  // on_time*8*10
          off_time_nsec  = {off_time_x10[16:0],3'b000}; // off_time*8*10
        end
        sm_10M:
        begin
          on_time_nsec   = {on_time_x100[16:0],3'b000}; // on_time*8*100
          off_time_nsec  = {off_time_x100[16:0],3'b000};// off_time*8*100
        end
        default:
        begin //For 2.5G and 1Gbps
          on_time_nsec   = {on_time ,3'b000};       // on_time*8
          off_time_nsec  = {off_time,3'b000};       // off_time*8
        end
      endcase
    end

  // Calculation of add_frag_size_time
  always @ *
  begin
    case(speed)
      sm_2_5G:
        case(add_frag_size)
          2'b00  : add_frag_size_time = 18'd205;
          2'b01  : add_frag_size_time = 18'd410;
          2'b10  : add_frag_size_time = 18'd615;
          default: add_frag_size_time = 18'd820;
        endcase
      sm_1G:
        case(add_frag_size)
          2'b00  : add_frag_size_time = 18'd512;
          2'b01  : add_frag_size_time = 18'd1024;
          2'b10  : add_frag_size_time = 18'd1536;
          default: add_frag_size_time = 18'd2048;
        endcase
      sm_100M:
        case(add_frag_size)
          2'b00  : add_frag_size_time = 18'd5120;
          2'b01  : add_frag_size_time = 18'd10240;
          2'b10  : add_frag_size_time = 18'd15360;
          default: add_frag_size_time = 18'd20480;
        endcase
      default: // sm_10M
        case(add_frag_size)
          2'b00  : add_frag_size_time = 18'd51200;
          2'b01  : add_frag_size_time = 18'd102400;
          2'b10  : add_frag_size_time = 18'd153600;
          default: add_frag_size_time = 18'd204800;
        endcase
    endcase
 end

//------------------------------------------------------------------------------
// Computational function
// This is an accumulator which is
//  - loaded to a set value on startup
//  - add the on_time
//  - add the off_time
//------------------------------------------------------------------------------

  // Need to detect the increment of the seconds section
  // in the tsu_time vector, because this will trigger
  // the accumulator to wrap as well
  always @ (posedge tsu_clk or negedge n_tsureset)
  begin
    if(~n_tsureset)
      tsu_time_30_reg <= 1'b0;
    else
      tsu_time_30_reg <= tsu_time[30];
  end

  assign tsu_time_wrap = tsu_time_30_reg != tsu_time[30];

  // the acc register is meant to wrap and in particular it will
  // be forced to wrap when tsu_time_wrap is set, meaning that
  // all the warnings related to a possible overflow for this
  // register can be waived.
  // Nevertheless it has been decided to adopt the policy of avoiding 
  // the warnings in the first place, so we will calculate some
  // quantities here and then truncate when using them.
  assign acc_wrap            = acc + 32'h04653600;
  assign acc_p_on_time_nsec  = acc + {12'd0,on_time_nsec};
  assign acc_p_off_time_nsec = acc + {12'd0,off_time_nsec};
  
  always @ (posedge tsu_clk or negedge n_tsureset)
  begin : p_acc
    if(~n_tsureset)
      acc <= 32'd0;
    else
      begin
        if(tsu_time_wrap)
          acc <= acc_wrap[31:0];
        else
          begin
            if(acc_load)
              acc <= start_time;
            else
              begin
                if (acc_on)
                  acc <= acc_p_on_time_nsec[31:0];
                else if (acc_off)
                  acc <= acc_p_off_time_nsec[31:0];
              end
          end
      end
  end

  // To detect the early state the add_frag_size_time must be subtracted from the
  // accumulator
  assign acc_early = acc - {14'd0,add_frag_size_time};

 endmodule
