//-----------------------------------------------------------------------------
// module: serial.vhd
// This file contains modules for serial I/O.
//
// OVERVIEW of contents:  One rs232 transmitter block
//                        One rs232 receiver block
//
// Author: John Clayton
// Date  : Nov.  7, 2000
// Update: Nov.  7, 2000 Created this file, with RS232tx block only
//                       The rs232tx block has no double buffering.
// Update: Nov.  9, 2000 Separated clock generator circuitry into "clock_gen"
// Update: Nov. 29, 2000 Added rs232rx block
// Update: Nov. 30, 2000 Moved contents of "async_tx" and "async_rx" from 
//                       blocks.vhd to this file.
// Update: May   7, 2001 Translated this file from VHDL to verilog, using 
//                       "xhdl"
// Update: May   8, 2001 Since the output of xhdl was rather "spotty", I have
//                       fixed errors and filled in the "holes" in the code.
//                       In addition, I have tried to wean this file from
//                       its previous use and dependency upon "blocks.v"
//                       (also translated from VHDL, but consisting of rather
//                       trivial modules.)
// Update: May   8, 2001 Converted to synchronous resets on all flip-flops.
// Update: May  16, 2001 Re-worked the state machines for rs232rx and rs232tx.
// Update: July 25, 2001 Changed the polarity of q[] in rs232_tx, so that its
//                       output will be the desired (high) level upon initial
//                       FPGA configuration, even before or without a reset!
// Update: Jan. 30, 2002 Corrected the formula in STEP 1: Find the ratio.
//                       (Thanks to Shehryar Shaheen at the University of
//                        Limerick for pointing out the error.)
// Update: June 28, 2002 Fixed "clock_gen" so that it uses the dds_clk.
// Update: Dec.  5, 2002 Removed clock_gen, since there is now a separate block
//                       called "autobaud_with_tracking" which takes over the
//                       function of generating the BAUD clock.
//                       Also removed "clock_gen_select"
//                       Also, removed lengthy instructions concerning how to
//                       set up a DDS to generate a BAUD clock.
//

//-----------------------------------------
// This block takes care of receiving an RS232 input word,
// from the "rxd" line in a serial fashion.
// The user is responsible for providing appropriate CLK
// and clock enable (CE) to achieve the desired Baudot interval
// (NOTE: the state machine operates at "CLOCK_FACTOR_PP" times the
//   desired BAUD rate.  Set it to anything between 2 and 16,
//   inclusive.  Values higher than 16 will not "buy" much for you,
//   and the state machine might not work well for values less than
//   four either, because of the difficulty in sampling rxd at the
//   "middle" of the bit time.  However, it may be useful to adjust
//   the clock_factor around in order to generate good BAUD clocks
//   from odd Fclk frequencies on your board.)
// Each time the "data_ready" line drives high the unit has put
// a newly received data word into its output buffer, and is possibly
// already in the process of receiving the next one.
// Note that support is not provided for 1.5 stop bits, only integral
// numbers of stop bits are allowed.  However, a selection >2 for
// number of stop bits will still work (it will simply receive
// and count additional stop bits before reporting "word_ready"

module rs232rx (
                clk,
                rx_clk,
                reset,
                rxd,
                read,
                data,
                data_ready,
                error_over_run,
                error_under_run,
                error_all_low
                );

// Parameter declarations
parameter START_BITS_PP  = 1;
parameter DATA_BITS_PP  = 8;
parameter STOP_BITS_PP  = 1;
parameter CLOCK_FACTOR_PP  = 16;

// State encodings, provided as parameters
// for flexibility to the one instantiating the module

parameter m1_idle = 0;
parameter m1_start = 1;
parameter m1_shift = 3;
parameter m1_over_run = 2;
parameter m1_under_run = 4;
parameter m1_all_low = 5;
parameter m1_extra_1 = 6;
parameter m1_extra_2 = 7;
parameter m2_data_ready_flag = 1;
parameter m2_data_ready_ack = 0;


// I/O declarations
input clk; 
input rx_clk; 
input reset;
input rxd;
input read;

output [DATA_BITS_PP-1:0] data;
output data_ready;
output error_over_run;
output error_under_run;
output error_all_low;

reg [DATA_BITS_PP-1:0] data;
//reg data_ready;
wire data_ready;
reg error_over_run;
reg error_under_run;
reg error_all_low;

// Local signal declarations
`define TOTAL_RX_BITS START_BITS_PP + DATA_BITS_PP + STOP_BITS_PP

wire word_xfer_l;
wire mid_bit_l;
wire start_bit_l;
wire stop_bit_l;
wire all_low_l;

reg [3:0] intrabit_count_l;
reg [`TOTAL_RX_BITS-1:0] q;
reg shifter_preset;
reg [2:0] m1_state;
reg [2:0] m1_next_state;
reg m2_state;
reg m2_next_state;


  // State register
  always @(posedge clk)
  begin : m1_state_register
    if (reset) m1_state <= m1_idle;
    else m1_state <= m1_next_state;
  end 

  always @(m1_state 
           or reset
           or rxd
           or mid_bit_l
           or all_low_l
           or start_bit_l
           or stop_bit_l
           )
  begin : m1_state_logic
  
    // Output signals are low unless set high in a state condition.
    shifter_preset <= 0;
    error_over_run <= 0;
    error_under_run <= 0;
    error_all_low <= 0;
  
    case (m1_state)

      m1_idle :
        begin
          shifter_preset <= 1'b1;
          if (~rxd) m1_next_state <= m1_start;
          else m1_next_state <= m1_idle;
        end

      m1_start :
        begin
          if (~rxd && mid_bit_l) m1_next_state <= m1_shift;
          else if (rxd && mid_bit_l) m1_next_state <= m1_under_run;
          else m1_next_state <= m1_start;
        end

      m1_shift :
        begin
          if (all_low_l) m1_next_state <= m1_all_low;
          else if (~start_bit_l && ~stop_bit_l) m1_next_state <= m1_over_run;
          else if (~start_bit_l && stop_bit_l) m1_next_state <= m1_idle;
          else m1_next_state <= m1_shift;
        end

      m1_over_run :
        begin
          error_over_run <= 1;
          shifter_preset <= 1'b1;
          if (reset) m1_next_state <= m1_idle;
          else m1_next_state <= m1_over_run;
        end
      
      m1_under_run :
        begin
          error_under_run <= 1;
          shifter_preset <= 1'b1;
          if (reset) m1_next_state <= m1_idle;
          else m1_next_state <= m1_under_run;
        end
        
      m1_all_low :
        begin
          error_all_low <= 1;
          shifter_preset <= 1'b1;
          if (reset) m1_next_state <= m1_idle;
          else m1_next_state <= m1_all_low;
        end
        
      default : m1_next_state <= m1_idle;
    endcase 
  end 
  assign word_xfer_l = ((m1_state == m1_shift) && ~start_bit_l && stop_bit_l);

  // State register
  always @(posedge clk)
  begin : m2_state_register
    if (reset) m2_state <= m2_data_ready_ack;
    else m2_state <= m2_next_state;
  end 

  // State transition logic
  always @(m2_state or word_xfer_l or read)
  begin : m2_state_logic
    case (m2_state)
      m2_data_ready_ack:
            begin
              //data_ready <= 1'b0;
              if (word_xfer_l) m2_next_state <= m2_data_ready_flag;
              else m2_next_state <= m2_data_ready_ack;
            end
      m2_data_ready_flag:
            begin
              //data_ready <= 1'b1;
              if (read) m2_next_state <= m2_data_ready_ack;
              else m2_next_state <= m2_data_ready_flag;
            end
      default : m2_next_state <= m2_data_ready_ack;
    endcase 
  end 
  assign data_ready = (m2_state == m2_data_ready_flag);

  // This counts within a bit-time.
  always @(posedge clk)
  begin
    if (shifter_preset) intrabit_count_l <= 0;
    else if (rx_clk)
    begin
      if (intrabit_count_l == (CLOCK_FACTOR_PP-1)) intrabit_count_l <= 0;
      else intrabit_count_l <= intrabit_count_l + 1;
    end
  end
  // This signal gets one "rx_clk" at the middle of the bit time.
  assign mid_bit_l = ((intrabit_count_l==(CLOCK_FACTOR_PP / 2)) && rx_clk);

  // This is the shift register
  always @(posedge clk)
  begin : rxd_shifter
    if (shifter_preset) q <= -1; // Set to all ones.
    else if (mid_bit_l) q <= {rxd,q[`TOTAL_RX_BITS-1:1]};
  end
  // Note: The definitions of "start_bit_l" and "stop_bit_l" could
  //       well be updated to include _all_ of the start and stop bits.
  assign start_bit_l = q[0];
  assign stop_bit_l = q[`TOTAL_RX_BITS-1];
  assign all_low_l = ~(| q); // Bit-wise or of the entire shift register


  // This is the output buffer
  always @(posedge clk)
  begin : rxd_output
    if (reset) data <= 0;
    else if (word_xfer_l) 
      data <= q[START_BITS_PP+DATA_BITS_PP-1:START_BITS_PP];
  end

endmodule

//`undef TOTAL_RX_BITS


//-----------------------------------------
// This block takes care of framing up an RS232 output word,
// and sending it out the "txd" line in a serial fashion.
// The user is responsible for providing appropriate clk
// and clock enable (tx_clk) to achieve the desired Baudot interval
// (a new bit is transmitted each (tx_clk/clock_factor) pulses)
// (NOTE: the state machine operates at "clock_factor" times the
//   desired BAUD rate.  Set it to anything between 2 and 16,
//   inclusive.  It may be useful to adjust the clock_factor in order to
//   generate good BAUD clocks from odd Fclk frequencies on your board.)
// A load operation is requested by bringing the "load" line high.  However,
// the load will only be accepted when load_request is also high (which  
// just happens to coincide with tx_clk_1x inside of the state machine...)
// Therefore, the "load_request" line may be used as a bus acknowledgement.
// (load_request = "ack_o" in Wishbone terminology -- but it only lasts for
//  one single clk cycle, so be careful how you use it!)
//
// If the "load_request" line is tied to "load," the unit will send
// data characters continuously, with no gaps in between transmissions.
//
// Note that support is not provided for 1.5 stop bits, only integral
// numbers of stop bits are allowed.  A selection of more than 2 for
// number of stop bits will still work fine, it will simply introduce
// a delay between characters being transmitted, although the length
// of the transmitter shift register will also grow to include one
// stage for each stop bit requested...

module rs232tx (
                clk,
                tx_clk,
                reset,
                load,
                data,
                load_request,
                txd
                );

  parameter START_BITS_PP  = 1;
  parameter DATA_BITS_PP  = 8;
  parameter STOP_BITS_PP  = 1;
  parameter CLOCK_FACTOR_PP  = 16;
  parameter TX_BIT_COUNT_BITS_PP = 4;  // = ceil(log(total_bits)/log(2)));

// State encodings, provided as parameters
// for flexibility to the one instantiating the module
  parameter m1_idle = 0;
  parameter m1_waiting = 1;
  parameter m1_sending = 3;
  parameter m1_sending_last_bit = 2;


// I/O declarations
  input clk;
  input tx_clk;
  input reset;
  input load;
  input[DATA_BITS_PP-1:0] data;
  output load_request;
  output txd;

  reg load_request;

// local signals
  `define TOTAL_TX_BITS START_BITS_PP + DATA_BITS_PP + STOP_BITS_PP
  
  reg [`TOTAL_TX_BITS-1:0] q;                 // Actual tx shifter
  reg [TX_BIT_COUNT_BITS_PP-1:0] tx_bit_count_l;
  reg [3:0] prescaler_count_l;
  reg [1:0] m1_state;
  reg [1:0] m1_next_state;

  wire [`TOTAL_TX_BITS-1:0] tx_word = {{STOP_BITS_PP{1'b1}},
                                   data,
                                   {START_BITS_PP{1'b0}}};
  wire begin_last_bit;
  wire start_sending;
  wire tx_clk_1x;

  // This is a prescaler to produce the actual transmit clock.
  always @(posedge clk)
  begin
    if (reset) prescaler_count_l <= 0;
    else if (tx_clk)
    begin
      if (prescaler_count_l == (CLOCK_FACTOR_PP-1)) prescaler_count_l <= 0;
      else prescaler_count_l <= prescaler_count_l + 1;
    end
  end
  assign tx_clk_1x = ((prescaler_count_l == (CLOCK_FACTOR_PP-1) ) && tx_clk);

  // This is the transmitted bit counter
  always @(posedge clk)
  begin
    if (start_sending) tx_bit_count_l <= 0;
    else if (tx_clk_1x)
    begin
      if (tx_bit_count_l == (`TOTAL_TX_BITS-2)) tx_bit_count_l <= 0;
      else tx_bit_count_l <= tx_bit_count_l + 1;
    end
  end
  assign begin_last_bit = ((tx_bit_count_l == (`TOTAL_TX_BITS-2) ) && tx_clk_1x);

  assign start_sending = (tx_clk_1x && load);


  // This state machine handles sending out the transmit data
  
  // State register.
  always @(posedge clk)
  begin : state_register
    if (reset) m1_state <= m1_idle;
    else m1_state <= m1_next_state;
  end

  // State transition logic
  always @(m1_state or tx_clk_1x or load or begin_last_bit)
  begin : state_logic
    // Signal is low unless changed in a state condition.
    load_request <= 0;
    case (m1_state)
      m1_idle :
            begin
              load_request <= tx_clk_1x;
              if (tx_clk_1x && load) m1_next_state <= m1_sending;
              else m1_next_state <= m1_idle;
            end
      m1_sending :
            begin
              if (begin_last_bit) m1_next_state <= m1_sending_last_bit;
              else m1_next_state <= m1_sending;
            end
      m1_sending_last_bit :
            begin
              load_request <= tx_clk_1x;
              if (load & tx_clk_1x) m1_next_state <= m1_sending;
              else if (tx_clk_1x) m1_next_state <= m1_idle;
              else m1_next_state <= m1_sending_last_bit;
            end
      default :
            begin
              m1_next_state <= m1_idle;
            end
    endcase
  end


  // This is the transmit shifter
  always @(posedge clk)
  begin : txd_shifter
    if (reset) q <= 0;  // set output to all ones
    else if (start_sending) q <= ~tx_word;
    else if (tx_clk_1x) q <= {1'b0,q[`TOTAL_TX_BITS-1:1]};
  end
  
  assign txd = ~q[0];

endmodule

