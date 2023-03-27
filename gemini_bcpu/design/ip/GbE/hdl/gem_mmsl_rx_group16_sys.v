//------------------------------------------------------------------------------
// Copyright (c) 2016-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_mmsl_rx_group16_sys.v
//   Module Name:        gem_mmsl_rx_group16_sys
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
//   Description :      Receives data from the mii bridge and gathers it
//                      in 16-bits data vectors
//
//------------------------------------------------------------------------------


module gem_mmsl_rx_group16_sys (

  input             rx_clk,                  // clk
  input             n_rxreset,               // reset
  input             data_16,                 // data path mode
  input             data_4,                  // data path mode
  input       [3:0] c_state,                 // Main current FSM state
  input       [3:0] n_state,                 // Main next    FSM state
  input      [15:0] rxd_pcs,                 // Data from PCS
  input       [1:0] rxd_par_pcs,             // Optional parity
  input       [1:0] rx_dv_pcs,               // dv   from PCS
  input       [1:0] rx_dv_pcs_extended,      // dv   from PCS extended
  input       [1:0] rx_er_pcs,               // er   from PCS
  input       [7:0] data_source_pipe,        // data input to gather
  input             par_source_pipe,         // Parity
  input             dv_source_pipe,          // data valid to gather
  input             dv_source_pipe_extended, // data valid to gather, extended
  input             er_source_pipe,          // data error to gather

  output reg [15:0] rxd_word,                // 16 bits word to output
  output reg  [3:0] rxd_word_par,            // parity
  output reg  [3:0] rxd_dv,                  // data valid to output
  output reg  [3:0] rxd_dv_extended,
  output reg  [3:0] rxd_er,                  // data error to output
  output reg  [2:0] g_cnt,                   // gather counter to output
  output reg        rxd_ready                // rxd_ready strobe to output

);

  // -----------------------------------------------------------------------------
  // Signals and registers declaration
  // -----------------------------------------------------------------------------
  parameter INIT_RX = 4'b0000;
  reg       g_cnt_wrap;
  // -----------------------------------------------------------------------------
  // Gathering counter and rxd_ready implementation
  // -----------------------------------------------------------------------------

  always @ *
  begin
    if(data_4)
      g_cnt_wrap = (g_cnt == 3'b011);
    else
      g_cnt_wrap = (g_cnt == 3'b001);
  end

  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        g_cnt     <= 3'b000;
        rxd_ready <= 1'b0;
      end
    else
      begin
        if(data_16)
          begin
            rxd_ready <= 1'b1;
            g_cnt     <= 3'b000; // doesnt matter
          end
        else
          begin
            if(c_state!= INIT_RX)
              begin
                if(g_cnt_wrap)
                  begin
                    g_cnt     <= 3'b000;
                    rxd_ready <= 1'b1;
                  end
                else
                  begin
                    g_cnt     <= g_cnt + 3'b001;
                    rxd_ready <= 1'b0;
                  end
              end
            else
              begin
                g_cnt     <= 3'b000;
                rxd_ready <= 1'b1;
              end
          end
      end
  end

  // -----------------------------------------------------------------------------
  // Gathering system implementation
  // -----------------------------------------------------------------------------
  // Here we can build the rxd_word vector.
  // From now on, data_4, pcs. gmii mode will be
  // treated pretty much the same since we have either ways
  // this 16 bits rxd_word vector and the related
  // data valid and error obviously
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      begin
        rxd_word        <= 16'h0000;
        rxd_word_par    <= 4'h0;
        rxd_dv          <= 4'd0;
        rxd_dv_extended <= 4'd0;
        rxd_er          <= 4'd0;
      end
    else if(n_state == INIT_RX)
      begin
        rxd_word        <= 16'h0000;
        rxd_word_par    <= 4'h0;
        rxd_dv          <= 4'd0;
        rxd_dv_extended <= 4'd0;
        rxd_er          <= 4'd0;
      end
    else
      begin
        if(data_16)
          begin
            rxd_word        <= rxd_pcs;
            rxd_word_par    <= {rxd_par_pcs[1],rxd_par_pcs[1],rxd_par_pcs[0],rxd_par_pcs[0]};
            rxd_dv          <= {rx_dv_pcs[1], rx_dv_pcs[1], rx_dv_pcs[0], rx_dv_pcs[0]};
            rxd_dv_extended <= {rx_dv_pcs_extended[1], rx_dv_pcs_extended[1], rx_dv_pcs_extended[0], rx_dv_pcs_extended[0]};
            rxd_er          <= {rx_er_pcs[1], rx_er_pcs[1], rx_er_pcs[0], rx_er_pcs[0]};
          end
        else
          begin
            if(data_4)
              case(g_cnt)
                3'b000:
                begin
                  rxd_word[3:0]      <= data_source_pipe[3:0];
                  rxd_word_par[0]    <= par_source_pipe;
                  rxd_dv[0]          <= dv_source_pipe;
                  rxd_dv_extended[0] <= dv_source_pipe_extended;
                  rxd_er[0]          <= er_source_pipe;
                end
                3'b001:
                begin
                  rxd_word[7:4]      <= data_source_pipe[3:0];
                  rxd_word_par[1]    <= par_source_pipe;
                  rxd_dv[1]          <= dv_source_pipe;
                  rxd_dv_extended[1] <= dv_source_pipe_extended;
                  rxd_er[1]          <= er_source_pipe;
                end
                3'b010:
                begin
                  rxd_word[11:8]     <= data_source_pipe[3:0];
                  rxd_word_par[2]    <= par_source_pipe;
                  rxd_dv[2]          <= dv_source_pipe;
                  rxd_dv_extended[2] <= dv_source_pipe_extended;
                  rxd_er[2]          <= er_source_pipe;
                end
                default:
                begin
                  rxd_word[15:12]    <= data_source_pipe[3:0];
                  rxd_word_par[3]    <= par_source_pipe;
                  rxd_dv[3]          <= dv_source_pipe;
                  rxd_dv_extended[3] <= dv_source_pipe_extended;
                  rxd_er[3]          <= er_source_pipe;
                end
              endcase
            else // data_8in16 or just 8 bits data in a 8 bits word
              case(g_cnt)
                3'b000:
                begin
                  rxd_word[7:0]        <= data_source_pipe;
                  rxd_word_par[1:0]    <= {par_source_pipe, par_source_pipe};
                  rxd_dv[1:0]          <= {dv_source_pipe, dv_source_pipe};
                  rxd_dv_extended[1:0] <= {dv_source_pipe_extended, dv_source_pipe_extended};
                  rxd_er[1:0]          <= {er_source_pipe, er_source_pipe};
                end
                default:
                begin
                  rxd_word[15:8]       <= data_source_pipe;
                  rxd_word_par[3:2]    <= {par_source_pipe, par_source_pipe};
                  rxd_dv[3:2]          <= {dv_source_pipe, dv_source_pipe};
                  rxd_dv_extended[3:2] <= {dv_source_pipe_extended, dv_source_pipe_extended};
                  rxd_er[3:2]          <= {er_source_pipe, er_source_pipe};
                end
              endcase
          end
      end
  end

endmodule
