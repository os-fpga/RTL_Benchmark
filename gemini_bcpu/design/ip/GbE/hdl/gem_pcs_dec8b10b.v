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
//   Filename:           gem_pcs_dec8b10b.v
//   Module Name:        gem_pcs_dec8b10b
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
//   Description    : An 8b10b decoder that can be used for Gigabit Ethernet
//                    implementations.  The inputs to the decoder is the
//                    encoded 10-bit code group and the outputs will be an 8-bit
//                    decoded byte with an associated control signal to indicate
//                    whether the received code group was a special code group
//                    or a data code group.  In addition to this, a decoder
//                    error output is provided to indicate the presence of an
//                    error during the decoding stage.
//
//   Notes          : An asynchronous reset is now available.  However this
//                    should be activated once the appropriate datain and
//                    control inputs have been set as the reset will also cause
//                    a new disparity to be calculated after the reset pulse.
//                    In addition, sufficient time should be given after the
//                    reset pulse before the next clock edge to safeguard
//                    against any possible metastability problems.
//
//------------------------------------------------------------------------------


module gem_pcs_dec8b10b (
  input             clk,        // The system clock.
  input             n_reset,    // Asynchronous reset to decoder.
  input       [9:0] din,        // The encoded 10-bit code group.
  input             force_disp, // controls whether running disparity will
                                // be generated internally or set externally.
  input             disp,       // Running disparity input, used with above.

  output reg  [7:0] dout,       // The decoded byte.
  output reg        cont,       // Indicates whether code group was special.
  output reg        err,        // Signal to indicate if problems decoding.
  output            r_disp_out, // Running disparity output (async)
  output reg        r_disp      // Running disparity (registered)
);

  // Internal signals
  reg   [7:0] dataout;    // Decoded value to be clocked out on
  reg         control;    // next clock edge.
  reg         dec_err;    // Decoder error.
  reg         new_disp;   // Disparity at end of 4-bit sub block.
  reg         temp_disp;  // Temporary disparity after 5b6b block.
  reg   [4:0] sub5;       // Temporary variables for holding the upper
  reg   [2:0] sub3;       // and lower halfs of the output.
  wire  [9:0] datain;     // Data to decode
  wire        r_disp_mx;  // Running disparity muxed with force_disp.

  parameter p_init_r_val  = 10'h057;  // Initial value for sample register
  parameter p_init_op     = 9'h1f7;   // Initial output
  parameter p_init_disp   = 1'b0;     // Initial disparity
  parameter p_reg_ip      = 1'b0;     // Register input.

  // Optionally register the input for timing.
  generate
    if (p_reg_ip)
    begin: G_REG_IP
      reg [9:0] din_r1;   // din sampled on the rising clock edge

      // Sample the inputs on the rising edge of the clock
      always@(posedge clk or negedge n_reset)
      begin: p_synch
        if (n_reset == 1'b0)
          din_r1  <= p_init_r_val;
        else
          din_r1  <= din;
      end
      assign datain  = din_r1;
    end
    else
    begin: G_NO_REG_IP
      assign datain  = din;
    end
  endgenerate

  // Combinatorial running disparity output for daisy chaining
  assign r_disp_out = new_disp;

  // Running disparity to use internally is muxed with force_disp
  assign r_disp_mx  = force_disp  ? disp  : r_disp;

  // Update the internal running disparity.
  // On reset (asynchronous) reset all the running disparity to -ve.
  always@(posedge clk or negedge n_reset)
  begin: p_synch
    if (n_reset == 1'b0)
    begin: p_reset_init
      r_disp      <= p_init_disp;
      {cont,dout} <= p_init_op;
      err         <= 1'b0;
    end
    else
    begin: p_sample_ip
      r_disp  <= new_disp;
      dout    <= dataout;
      cont    <= control;
      err     <= dec_err;
    end
  end


  // The main combinatorial block that performs the actual decoding
  // and updates the new running disparity accordingly.
  // The decoding is split so that first a 6b5b decoding is performed
  // followed by a 4b3b with disparity calculation in between.
  always@(*)

  begin: p_dec6b5b    // Perform 6b5b decoding.

    dec_err = 1'b0;   // Initialise error o/p prior to encoding.
    control = 1'b0;
    sub5 = 5'h00;     // Initialise to avoid latch condition.
    sub3 = 3'h0;

    case (r_disp_mx)

      1'b0: // when negative disparity.

      begin: p_dec6b5b_r_disp_n

        case (datain[5:0])
          6'b111001: sub5 = 5'h00;     // Data code groups.
          6'b101110: sub5 = 5'h01;
          6'b101101: sub5 = 5'h02;
          6'b100011: sub5 = 5'h03;
          6'b101011: sub5 = 5'h04;
          6'b100101: sub5 = 5'h05;
          6'b100110: sub5 = 5'h06;
          6'b000111: sub5 = 5'h07;
          6'b100111: sub5 = 5'h08;
          6'b101001: sub5 = 5'h09;
          6'b101010: sub5 = 5'h0a;
          6'b001011: sub5 = 5'h0b;
          6'b101100: sub5 = 5'h0c;
          6'b001101: sub5 = 5'h0d;
          6'b001110: sub5 = 5'h0e;
          6'b111010: sub5 = 5'h0f;
          6'b110110: sub5 = 5'h10;
          6'b110001: sub5 = 5'h11;
          6'b110010: sub5 = 5'h12;
          6'b010011: sub5 = 5'h13;
          6'b110100: sub5 = 5'h14;
          6'b010101: sub5 = 5'h15;
          6'b010110: sub5 = 5'h16;
          6'b010111: sub5 = 5'h17;
          6'b110011: sub5 = 5'h18;
          6'b011001: sub5 = 5'h19;
          6'b011010: sub5 = 5'h1a;
          6'b011011: sub5 = 5'h1b;
          6'b011100: sub5 = 5'h1c;
          6'b011101: sub5 = 5'h1d;
          6'b011110: sub5 = 5'h1e;
          6'b110101: sub5 = 5'h1f;
          6'b111100: sub5 = 5'b11100;  // Special group
          default:
          begin: p_dec_err_6b5b_n
            dec_err = 1'b1;
          end // case: default
        endcase // case(datain[5:0])

        // Check for special code groups and activate control.
        case (datain)
          10'b0010111100:        // K28_0
          begin: p_dec_6b5b_K28_0_n
            sub5 = 5'b11100;
            sub3 = 3'b000;
            control = 1'b1;
          end
          10'b1001111100:        // K28_1
          begin: p_dec_6b5b_K28_1_n
            sub5 = 5'b11100;
            sub3 = 3'b001;
            control = 1'b1;
          end
          10'b1010111100:        // K28_2
          begin: p_dec_6b5b_K28_2_n
            sub5 = 5'b11100;
            sub3 = 3'b010;
            control = 1'b1;
          end
          10'b1100111100:        // K28_3
          begin: p_dec_6b5b_K28_3_n
            sub5 = 5'b11100;
            sub3 = 3'b011;
            control = 1'b1;
          end
          10'b0100111100:        // K28_4
          begin: p_dec_6b5b_K28_4_n
            sub5 = 5'b11100;
            sub3 = 3'b100;
            control = 1'b1;
          end
          10'b0101111100:        // K28_5
          begin: p_dec_6b5b_K28_5_n
            sub5 = 5'b11100;
            sub3 = 3'b101;
            control = 1'b1;
          end
          10'b0110111100:        // K28_6
          begin: p_dec_6b5b_K28_6_n
            sub5 = 5'b11100;
            sub3 = 3'b110;
            control = 1'b1;
          end
          10'b0001111100:        // K28_7
          begin: p_dec_6b5b_K28_7
            sub5 = 5'b11100;
            sub3 = 3'b111;
            control = 1'b1;
          end
          10'b0001010111:        // K23_7
          begin: p_dec_6b5b_K23_7_n
            sub5 = 5'b10111;
            sub3 = 3'b111;
            control = 1'b1;
          end
          10'b0001011011:        // K27_7
          begin: p_dec_6b5b_K27_7_n
            sub5 = 5'b11011;
            sub3 = 3'b111;
            control = 1'b1;
          end
          10'b0001011101:        // K29_7
          begin: p_dec_6b5b_K29_7_n
            sub5 = 5'b11101;
            sub3 = 3'b111;
            control = 1'b1;
          end
          10'b0001011110:        // K30_7
          begin: p_dec_6b5b_K30_7_n
            sub5 = 5'b11110;
            sub3 = 3'b111;
            control = 1'b1;
          end // case: 10'b0111101000
          default:  control = 1'b0;
        endcase // case(datain)

      end // case: 1'b0

      default:  // when positive disparity.

      begin: p_dec6b5b_r_disp_p

        case (datain[5:0])
          6'b000110: sub5 = 5'h00;        // Data code groups.
          6'b010001: sub5 = 5'h01;
          6'b010010: sub5 = 5'h02;
          6'b100011: sub5 = 5'h03;
          6'b010100: sub5 = 5'h04;
          6'b100101: sub5 = 5'h05;
          6'b100110: sub5 = 5'h06;
          6'b111000: sub5 = 5'h07;
          6'b011000: sub5 = 5'h08;
          6'b101001: sub5 = 5'h09;
          6'b101010: sub5 = 5'h0a;
          6'b001011: sub5 = 5'h0b;
          6'b101100: sub5 = 5'h0c;
          6'b001101: sub5 = 5'h0d;
          6'b001110: sub5 = 5'h0e;
          6'b000101: sub5 = 5'h0f;
          6'b001001: sub5 = 5'h10;
          6'b110001: sub5 = 5'h11;
          6'b110010: sub5 = 5'h12;
          6'b010011: sub5 = 5'h13;
          6'b110100: sub5 = 5'h14;
          6'b010101: sub5 = 5'h15;
          6'b010110: sub5 = 5'h16;
          6'b101000: sub5 = 5'h17;
          6'b001100: sub5 = 5'h18;
          6'b011001: sub5 = 5'h19;
          6'b011010: sub5 = 5'h1a;
          6'b100100: sub5 = 5'h1b;
          6'b011100: sub5 = 5'h1c;
          6'b100010: sub5 = 5'h1d;
          6'b100001: sub5 = 5'h1e;
          6'b001010: sub5 = 5'h1f;
          6'b000011: sub5 = 5'b11100;     // Special code group.
          default:
          begin: p_dec_err_6b5b_p
            dec_err = 1'b1;
          end // case: default
        endcase // case(datain[5:0])

        // Check for special code groups and activate control.

        case (datain)
          10'b1101000011:        // K28_0
          begin: p_dec_6b5b_K28_0_p
            sub5 = 5'b11100;
            sub3 = 3'b000;
            control = 1'b1;
          end
          10'b0110000011:        // K28_1
          begin: p_dec_6b5b_K28_1_p
            sub5 = 5'b11100;
            sub3 = 3'b001;
            control = 1'b1;
          end
          10'b0101000011:        // K28_2
          begin: p_dec_6b5b_K28_2_p
            sub5 = 5'b11100;
            sub3 = 3'b010;
            control = 1'b1;
          end
          10'b0011000011:        // K28_3
          begin: p_dec_6b5b_K28_3_p
            sub5 = 5'b11100;
            sub3 = 3'b011;
            control = 1'b1;
          end
          10'b1011000011:        // K28_4
          begin: p_dec_6b5b_K28_4_p
            sub5 = 5'b11100;
            sub3 = 3'b100;
            control = 1'b1;
          end
          10'b1010000011:        // K28_5
          begin: p_dec_6b5b_K28_5_p
            sub5 = 5'b11100;
            sub3 = 3'b101;
            control = 1'b1;
          end
          10'b1001000011:        // K28_6
          begin: p_dec_6b5b_K28_6_p
            sub5 = 5'b11100;
            sub3 = 3'b110;
            control = 1'b1;
          end
          10'b1110000011:        // K28_7
          begin: p_dec_6b5b_K28_7_p
            sub5 = 5'b11100;
            sub3 = 3'b111;
            control = 1'b1;
          end
          10'b1110101000:        // K23_7
          begin: p_dec_6b5b_K23_7_p
            sub5 = 5'b10111;
            sub3 = 3'b111;
            control = 1'b1;
          end
          10'b1110100100:        // K27_7
          begin: p_dec_6b5b_K27_7_p
            sub5 = 5'b11011;
            sub3 = 3'b111;
            control = 1'b1;
          end
          10'b1110100010:        // K29_7
          begin: p_dec_6b5b_K29_7_p
            sub5 = 5'b11101;
            sub3 = 3'b111;
            control = 1'b1;
          end
          10'b1110100001:        // K30_7
          begin: p_dec_6b5b_K30_7_p
            sub5 = 5'b11110;
            sub3 = 3'b111;
            control = 1'b1;
          end // case: 10'b1000010111
          default:  control = 1'b0;
        endcase // case(datain)

      end // case: 1'b1

    endcase // case(r_disp_mx)


    // Now the 6 bit sub block has been processed, a new running
    // disparity is needed to calculate the running disparity at
    // the end of the code group...

    // 1'b0 passed to denote calculate disp of 6 bit sub block.
    // Note that new_disp is used now...

    temp_disp = calc_disparity(r_disp_mx, datain[9:0], 1'b0);

    // Perform the 4b3b decoding on the rest of the data.  Only if
    // a special code group not already found.

    if (control == 1'b0)

      case (temp_disp) // do the same for the 4-bit sub block.

        1'b0:  // negative disparity

          case (datain[9:6])
            4'b1101: sub3 = 3'h0;
            4'b1001: sub3 = 3'h1;
            4'b1010: sub3 = 3'h2;
            4'b0011: sub3 = 3'h3;
            4'b1011: sub3 = 3'h4;
            4'b0101: sub3 = 3'h5;
            4'b0110: sub3 = 3'h6;
            4'b1110:
            begin
              case (datain[5:0])
                6'b110001,
                6'b110010,
                6'b110100:  sub3 = 3'h7;
                default:
                begin
                  dec_err = 1'b1;
                  sub3 = 3'h7;
                end
              endcase
            end
            4'b0111:
            begin
              if ( (datain[9:4] == 6'b011111) |
                    (datain[5:0] == 6'b000011) )
                dec_err = 1'b1;
              sub3 = 3'h7;
            end
            default:
            begin: p_dec_err_4b3b_n
              dec_err = 1'b1;
            end // case: default
          endcase // case(datain[9:6])

        default: // positive disparity..

          case (datain[9:6])
            4'b0010: sub3 = 3'h0;
            4'b1001: sub3 = 3'h1;
            4'b1010: sub3 = 3'h2;
            4'b1100: sub3 = 3'h3;
            4'b0100: sub3 = 3'h4;
            4'b0101: sub3 = 3'h5;
            4'b0110: sub3 = 3'h6;
            4'b0001:
            begin
              case (datain[5:0])
                6'b010111,   // Take care of some special cases.
                6'b011011,
                6'b011101,
                6'b011110,
                6'b001101,
                6'b001110,
                6'b001011:  sub3 = 3'h7;
                default:
                begin
                  dec_err = 1'b1;
                  sub3 = 3'h7;
                end
              endcase
            end
            4'b1000:
            begin
              if ( (datain[9:0] == 10'b1000111100) |
                   (datain[9:0] == 10'b1000001011) |
                   (datain[9:0] == 10'b1000001101) |
                   (datain[9:0] == 10'b1000001110) )
                dec_err = 1'b1;
              sub3 = 3'h7;
            end
            default:
            begin: p_dec_err_4b3b_p
              dec_err = 1'b1;
            end // case: default

          endcase // case(datain[9:6])

      endcase // case(temp_disp)

    else; // if control = 1'b0

    // Decoded result is concatenation of the 5-bt and 3-bit blocks.

    dataout = {sub3, sub5};

    // Now both block have been decoded, a new value needs to be
    // calculated for r_disp_mx for the next 6-bit block.

    new_disp = calc_disparity(temp_disp, datain, 1'b1);

  end


  // Define the r_disp calculation function..

  // This function calculates the running disparity of a 10-bit encoded
  // value using the current disparity value for non-disparity of the
  // input.  The calculation is based on sub-blocks, with the required
  // sub-block selected with the block_control input.
  function calc_disparity;
    input current_r_disp;       // Current running disparity.
    input [9:0] encoded_value;  // The 10-bit encoded input.
    input block_control;        // Select which block to calculate.

    begin

      case (block_control)// Determine which block to calculate.

        1'b0: // calculate r_disp at end of 6 bit sub block

          casex (encoded_value[5:0])
            6'b000xxx:  calc_disparity = 1'b0;
            6'b111xxx:  calc_disparity = 1'b1;
            6'b00100x:  calc_disparity = 1'b0;
            6'b001010:  calc_disparity = 1'b0;
            6'b001100:  calc_disparity = 1'b0;
            6'b001111:  calc_disparity = 1'b1;
            6'b01000x:  calc_disparity = 1'b0;
            6'b010010:  calc_disparity = 1'b0;
            6'b010100:  calc_disparity = 1'b0;
            6'b010111:  calc_disparity = 1'b1;
            6'b011000:  calc_disparity = 1'b0;
            6'b01111x:  calc_disparity = 1'b1;
            6'b011101:  calc_disparity = 1'b1;
            6'b011011:  calc_disparity = 1'b1;
            6'b10000x:  calc_disparity = 1'b0;
            6'b100010:  calc_disparity = 1'b0;
            6'b100100:  calc_disparity = 1'b0;
            6'b100111:  calc_disparity = 1'b1;
            6'b101000:  calc_disparity = 1'b0;
            6'b10111x:  calc_disparity = 1'b1;
            6'b101101:  calc_disparity = 1'b1;
            6'b101011:  calc_disparity = 1'b1;
            6'b110000:  calc_disparity = 1'b0;
            6'b11011x:  calc_disparity = 1'b1;
            6'b110101:  calc_disparity = 1'b1;
            6'b110011:  calc_disparity = 1'b1;
            default: calc_disparity = current_r_disp;
          endcase

        default: // calculate r_disp at end of 4 bit sub block

          casex (encoded_value[9:6])
            4'b00xx: calc_disparity = 1'b0;
            4'b11xx: calc_disparity = 1'b1;
            4'b0100: calc_disparity = 1'b0;
            4'b0111: calc_disparity = 1'b1;
            4'b1000: calc_disparity = 1'b0;
            4'b1011: calc_disparity = 1'b1;
            default: calc_disparity = current_r_disp;
          endcase

      endcase

    end

  endfunction // calc_disparity

endmodule // gem_pcs_dec8b10b


