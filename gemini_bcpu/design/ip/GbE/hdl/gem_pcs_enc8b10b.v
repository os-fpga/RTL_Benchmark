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
//   Filename:           gem_pcs_enc8b10b.v
//   Module Name:        gem_pcs_enc8b10b
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
//   Description    : An 8b10b encoder that can be used for Gigabit Ethernet
//                    implementations.  The inputs to the encoder are the
//                    unencoded 8-bit data and a control signal to indicate
//                    whether a data code group or a special code group should
//                    be generated.  The output is a 10-bit encoded code group
//                    that can be decoded with the accompanying 8b10b decoder.
//                    Force disparity inputs are provided for flexibility and
//                    test purposes and need not be used if not required.
//
//   Notes          : The encoder error output indicates unexpected errors when
//                    encoding, this can only be caused by invalid special code
//                    groups.  However when performing simulations, this signal
//                    will also be activated if any of the inputs are not
//                    initialised.
//                    If required it may be possible to daisy chain two encoders
//                    together such that 16-bits of incoming data is encoded
//                    simultaneously.  This however has still to be tested in
//                    this release.
//                    An asynchronous reset is available.  However this
//                    should be activated once the appropriate datain and
//                    control inputs have been set as the reset will also cause
//                    a new disparity to be calculated after the reset pulse.
//                    In addition, sufficient time should be given after the
//                    reset pulse before the next clock edge to safeguard
//                    against any possible metastability problems.
//
//------------------------------------------------------------------------------


module gem_pcs_enc8b10b (
  input             clk,        // The system clock.
  input             n_reset,    // Asynchronous reset to encoder.
  input       [7:0] din,        // The unencoded 8-bit input.
  input             cont,       // control signal indicates special groups.
  input             force_disp, // controls whether running disparity will
                                // be generated internally or set externally.
  input             disp,       // Running disparity input, used with above.

  // Outputs
  output  reg [9:0] dout,       // The encoded 10-bit output.
  output  reg       err,        // Signal to indicate if problems encoding.
  output            r_disp_out  // Running disparity output.

);

  // Internal signals
  reg         enc_err;    // Encoding error flag (async)
  reg         new_disp;   // Next disparity (async)
  reg   [5:0] sub6;       // Temporary variables for holding the upper
  reg   [3:0] sub4;       // and lower halfs of the output.
  reg         r_disp;     // Internal running Disparity, 0=-ve, 1=+ve
  reg         temp_disp;  // Temporary disparity after 5b6b block.
  wire  [7:0] datain;     // Data to encode
  wire        control;    // Control indicator

  parameter p_init_r_val  = 9'h1f7;   // Initial value for sample register
  parameter p_init_op     = 10'h057;  // Initial output value
  parameter p_init_disp   = 1'b0;     // Initial running disparity
  parameter p_reg_ip      = 1'b1;     // Register input for timing.


  // Optionally register the input for timing.
  generate
    if (p_reg_ip)
    begin: G_REG_IP
      reg [7:0] din_r1;   // din and cont sampled on the rising
      reg       cont_r1;  // clock edge.

      // Sample the inputs on the rising edge of the clock
      always@(posedge clk or negedge n_reset)
      begin: p_synch
        if (n_reset == 1'b0)
          {cont_r1,din_r1} <= p_init_r_val;
        else
          {cont_r1,din_r1} <= {cont,din};
      end
      assign datain  = din_r1;
      assign control = cont_r1;
    end
    else
    begin: G_NO_REG_IP
      assign datain  = din;
      assign control = cont;
    end
  endgenerate

  assign r_disp_out = new_disp;

  // Update the internal running disparity.
  // On reset (asynchronous) reset all the output values and the
  // running disparity.
  always@(posedge clk or negedge n_reset)
  begin: p_synch
    if (n_reset == 1'b0)
    begin: p_reset_init
      r_disp <= p_init_disp;
      dout <= p_init_op;
      err <= 1'b0;
    end
    else
    begin: p_sample_ip
      err   <= enc_err;
      dout  <= {sub4, sub6};

      // set the running disparity
      if (force_disp == 1'b1)
        r_disp <= disp;
      else
        r_disp <= new_disp;
    end
  end


  // The main combinatorial block that performs the actual encoding
  // and updates the new running disparity accordingly.
  // The encoding is split so that first a 5b6b encoding is performed
  // followed by a 3b4b with disparity calculation in between.
  always@(*)
  begin: p_enc5b6b      // Perform 5b6b encoding.

    case (control)  // Check whether input is a control byte.

      1'b0:  // Not a control byte

        case (r_disp)

          1'b0:  // -ve disparity

            case (datain[4:0])
              5'h00: sub6 = 6'b111001;
              5'h01: sub6 = 6'b101110;
              5'h02: sub6 = 6'b101101;
              5'h03: sub6 = 6'b100011;
              5'h04: sub6 = 6'b101011;
              5'h05: sub6 = 6'b100101;
              5'h06: sub6 = 6'b100110;
              5'h07: sub6 = 6'b000111;
              5'h08: sub6 = 6'b100111;
              5'h09: sub6 = 6'b101001;
              5'h0a: sub6 = 6'b101010;
              5'h0b: sub6 = 6'b001011;
              5'h0c: sub6 = 6'b101100;
              5'h0d: sub6 = 6'b001101;
              5'h0e: sub6 = 6'b001110;
              5'h0f: sub6 = 6'b111010;
              5'h10: sub6 = 6'b110110;
              5'h11: sub6 = 6'b110001;
              5'h12: sub6 = 6'b110010;
              5'h13: sub6 = 6'b010011;
              5'h14: sub6 = 6'b110100;
              5'h15: sub6 = 6'b010101;
              5'h16: sub6 = 6'b010110;
              5'h17: sub6 = 6'b010111;
              5'h18: sub6 = 6'b110011;
              5'h19: sub6 = 6'b011001;
              5'h1a: sub6 = 6'b011010;
              5'h1b: sub6 = 6'b011011;
              5'h1c: sub6 = 6'b011100;
              5'h1d: sub6 = 6'b011101;
              5'h1e: sub6 = 6'b011110;
              default: sub6 = 6'b110101;
            endcase // case(datain[4:0])

          default:  // +ve disparity
            case (datain[4:0])
              5'h00: sub6 = 6'b000110;
              5'h01: sub6 = 6'b010001;
              5'h02: sub6 = 6'b010010;
              5'h03: sub6 = 6'b100011;
              5'h04: sub6 = 6'b010100;
              5'h05: sub6 = 6'b100101;
              5'h06: sub6 = 6'b100110;
              5'h07: sub6 = 6'b111000;
              5'h08: sub6 = 6'b011000;
              5'h09: sub6 = 6'b101001;
              5'h0a: sub6 = 6'b101010;
              5'h0b: sub6 = 6'b001011;
              5'h0c: sub6 = 6'b101100;
              5'h0d: sub6 = 6'b001101;
              5'h0e: sub6 = 6'b001110;
              5'h0f: sub6 = 6'b000101;
              5'h10: sub6 = 6'b001001;
              5'h11: sub6 = 6'b110001;
              5'h12: sub6 = 6'b110010;
              5'h13: sub6 = 6'b010011;
              5'h14: sub6 = 6'b110100;
              5'h15: sub6 = 6'b010101;
              5'h16: sub6 = 6'b010110;
              5'h17: sub6 = 6'b101000;
              5'h18: sub6 = 6'b001100;
              5'h19: sub6 = 6'b011001;
              5'h1a: sub6 = 6'b011010;
              5'h1b: sub6 = 6'b100100;
              5'h1c: sub6 = 6'b011100;
              5'h1d: sub6 = 6'b100010;
              5'h1e: sub6 = 6'b100001;
              default: sub6 = 6'b001010;
            endcase // case(datain[4:0])

        endcase // case(r_disp)

      default: // In the case of a control byte..

        case (r_disp)

          1'b0: // -ve disparity
            case (datain[4:0])
              5'b11100: sub6 = 6'b111100;
              5'b10111: sub6 = 6'b010111;
              5'b11011: sub6 = 6'b011011;
              5'b11101: sub6 = 6'b011101;
              5'b11110: sub6 = 6'b011110;
              default:  sub6 = 6'h00;   // $display("error in 5b6b encoding of control sub block %b", datain[4:0]);
            endcase // case(datain[4:0])
          default:  // +ve disparity
            case (datain[4:0])
              5'b11100: sub6 = 6'b000011;
              5'b10111: sub6 = 6'b101000;
              5'b11011: sub6 = 6'b100100;
              5'b11101: sub6 = 6'b100010;
              5'b11110: sub6 = 6'b100001;
              default:  sub6 = 6'h00;   // $display("error in 5b6b encoding of control sub block %b", datain[4:0]);
            endcase // case(datain[4:0])
        endcase // case(r_disp)

    endcase // case(control)


    // Now the 6 bit sub block has been calculated, a new running
    // disparity is needed to calculate the next 4 bit sub block.

    // 1'b0 passed to denote calculate disp of 6 bit sub block.

    temp_disp = calc_disparity(r_disp, {4'h0, sub6}, 1'b0);

    // Perform the 3b4b conversion on remaining 3-bits of data.

    case (control)   // Check whether is a control byte.

      1'b0:  // Not a control byte

        case (temp_disp)   // Use new running disparity for encode.

          1'b0:  // -ve disparity

            case (datain[7:5])
              3'h0: sub4 = 4'b1101;
              3'h1: sub4 = 4'b1001;
              3'h2: sub4 = 4'b1010;
              3'h3: sub4 = 4'b0011;
              3'h4: sub4 = 4'b1011;
              3'h5: sub4 = 4'b0101;
              3'h6: sub4 = 4'b0110;
              default: // Different values depending on input.
                if ( (datain[7:0] == 8'hf1) |
                     (datain[7:0] == 8'hf2) |
                     (datain[7:0] == 8'hf4) )
                  sub4 = 4'b1110;
                else
                  sub4 = 4'b0111;
            endcase // case(datain[7:5])

          default:  // +ve disparity

            case (datain[7:5])
              3'h0: sub4 = 4'b0010;
              3'h1: sub4 = 4'b1001;
              3'h2: sub4 = 4'b1010;
              3'h3: sub4 = 4'b1100;
              3'h4: sub4 = 4'b0100;
              3'h5: sub4 = 4'b0101;
              3'h6: sub4 = 4'b0110;
              default: // Different values depending on input.
                if ( (datain[7:0] == 8'heb) |
                     (datain[7:0] == 8'hed) |
                     (datain[7:0] == 8'hee) )
                  sub4 = 4'b0001;
                else
                  sub4 = 4'b1000;
            endcase // case(datain[7:5])

        endcase // case(temp_disp)

      default: // in the case of a control byte..

        case (temp_disp)

          1'b0:  // -ve disparity

            case (datain[7:5])
              3'h0: sub4 = 4'b1101;
              3'h1: sub4 = 4'b0110;
              3'h2: sub4 = 4'b0101;
              3'h3: sub4 = 4'b0011;
              3'h4: sub4 = 4'b1011;
              3'h5: sub4 = 4'b1010;
              3'h6: sub4 = 4'b1001;
              default: sub4 = 4'b1110;
            endcase // case(datain[7:5])

          default:  // +ve disparity

            case (datain[7:5])
              3'h0: sub4 = 4'b0010;
              3'h1: sub4 = 4'b1001;
              3'h2: sub4 = 4'b1010;
              3'h3: sub4 = 4'b1100;
              3'h4: sub4 = 4'b0100;
              3'h5: sub4 = 4'b0101;
              3'h6: sub4 = 4'b0110;
              default: sub4 = 4'b0001;
            endcase // case(datain[7:5])

        endcase // case(temp_disp)

    endcase // case(control)

    // The new disparity must be updated now for the next code.
    // The value 1'b1 denotes calculate disp of 4 bit sub block.

    new_disp = calc_disparity(temp_disp, {sub4, sub6}, 1'b1);

  end


  // Generate error signal for invalid control codes.
  always@(*)
  begin
    if (control == 1'b1) // Ensure only valid control codes are encoded.

      case (datain[7:0])
        8'h1c: enc_err = 1'b0; // Do nothing since these are valid...
        8'h3c: enc_err = 1'b0;
        8'h5c: enc_err = 1'b0; // Note that although error is generated for
        8'h7c: enc_err = 1'b0; // invalid control codes, the 10-bit encoded
        8'h9c: enc_err = 1'b0; // value is still generated.
        8'hbc: enc_err = 1'b0;
        8'hdc: enc_err = 1'b0;
        8'hfc: enc_err = 1'b0;
        8'hf7: enc_err = 1'b0;
        8'hfb: enc_err = 1'b0;
        8'hfd: enc_err = 1'b0;
        8'hfe: enc_err = 1'b0;
        default: // For all invalid control codes signal an error.
        begin: p_enc_cont_err
          enc_err = 1'b1;
        end // case: default
      endcase // case(datain[7:0])
    else
      enc_err = 1'b0;
  end


  // Define the r_disp calculation function..

  // This function calculates the running disparity of a 10-bit encoded
  // value using the current disparity value for non-disparity of the
  // input.  The calculation is based on sub-blocks, with the required
  // sub-block selected with the block_control input.
  function calc_disparity;
    input       current_r_disp; // Current running disparity.
    input [9:0] encoded_value;  // The 10-bit encoded input.
    input       block_control;  // Select which block to calculate.

    begin

      case (block_control)// Determine which block to calculate.

        1'b0: // calculate r_disp at end of 6 bit sub block

          casex (encoded_value[5:0])
            6'b000xxx:  calc_disparity = 1'b0;
            6'b111xxx:  calc_disparity = 1'b1;
            6'b00100x:  calc_disparity = 1'b0;
            6'b001010:  calc_disparity = 1'b0;
            6'b001100:  calc_disparity = 1'b0;
//            6'b001111:  calc_disparity = 1'b1;  // Does not exist, UNR.
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
//            6'b110000:  calc_disparity = 1'b0;  // Does not exist, UNR.
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

endmodule // gem_pcs_enc8b10b

