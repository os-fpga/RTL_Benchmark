//------------------------------------------------------------------------------
// Copyright (c) 2016-2019 Cadence Design Systems, Inc.
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
//   Filename:           gem_mmsl_rx_output_driver.v
//   Module Name:        gem_mmsl_rx_output_driver
//
//   Release Revision:   r1p12f1
//   Release SVN Tag:    gem_gxl_det0102_r1p12f1
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
//   Description :      This module implements the output driver,
//                      which is basically a huge multiplexer
//
//------------------------------------------------------------------------------


module gem_mmsl_rx_output_driver (

  input       [3:0] n_state,
  input       [3:0] n_state_pipe4,
  input       [3:0] n_state_pipe2,
  input      [15:0] data_to_driver,
  input       [3:0] dv_to_driver,
  input       [3:0] er_to_driver,
  input       [3:0] par_to_driver,
  input       [2:0] fw_cnt,
  input             data_16,
  input             data_8in16,
  input             data_4,
  input             rx_halt,
  input       [3:0] n_halt_state,
  input       [2:0] g_cnt,
  input             fw_all_word,
  input      [15:0] rxd_prev,
  input       [3:0] rxd_par_prev,

  output reg  [7:0] pmac_rxd,
  output reg        pmac_rxd_par,
  output reg        pmac_rx_dv,
  output reg        pmac_rx_er,

  output reg [15:0] pmac_rxd_pcs,
  output reg  [1:0] pmac_rxd_par_pcs,
  output reg  [1:0] pmac_rx_dv_pcs,
  output reg  [1:0] pmac_rx_er_pcs

);

  // -----------------------------------------------------------------------------
  // Signals and registers declaration
  // -----------------------------------------------------------------------------

  // Main FSM from gem_mmsl_rx_proc
  parameter INIT_RX                   = 4'b0000;
  parameter IDLE_N_CHECK_FOR_START    = 4'b0001;
  parameter REPLACE_SMD               = 4'b0010;
  parameter P_RECEIVE_DATA            = 4'b0011;
  parameter WAIT_FOR_DV_FALSE         = 4'b0100;
  parameter WAIT_N_CHECK_FOR_RESUME   = 4'b0101;
  parameter INCREMENT_FRAG_COUNT      = 4'b0110;
  parameter ASSEMBLY_ERROR            = 4'b0111;
  parameter BAD_FRAG                  = 4'b1000;
  parameter EXPRESS                   = 4'b1001;
  parameter LPI                       = 4'b1010;

  // rx_halt FSM from gem_mmsl_rx_proc
  parameter HALT                     = 4'b0001;
  parameter HALT_THEN_CONT           = 4'b0110;
  parameter WAIT_FOR_START           = 4'b0111;
  parameter BUFFER_HALT_CONT         = 4'b1000;
  parameter FW_ERR_THEN_IDLE         = 4'b1001;

  wire error_forward;
  wire wait_for_start;

  assign error_forward  = (n_halt_state == FW_ERR_THEN_IDLE);
  assign wait_for_start = (n_halt_state == WAIT_FOR_START) && (data_16? (n_state_pipe4 != LPI) : (n_state_pipe2 != LPI));
  
  // -----------------------------------------------------------------------------
  // Output driver implementation
  // -----------------------------------------------------------------------------

  always @ *
  begin
    if((n_state == EXPRESS)||(n_state == BAD_FRAG))
      begin
        pmac_rxd      = 8'd0;
        pmac_rxd_par  = 1'b0;
        pmac_rx_dv    = 1'd0;
        pmac_rx_er    = 1'd0;

        pmac_rxd_pcs      = 16'd0;
        pmac_rxd_par_pcs  = 2'b00;
        pmac_rx_dv_pcs    = 2'd0;
        pmac_rx_er_pcs    = 2'd0;
      end
    else if(rx_halt||error_forward||wait_for_start)
      begin
        if(data_16||data_8in16)
          begin
            pmac_rxd          = 8'd0;
            pmac_rxd_par      = 1'b0;
            pmac_rx_dv        = 1'd0;
            pmac_rx_er        = 1'd0;

            pmac_rxd_pcs      = 16'd0;
            pmac_rxd_par_pcs  = 2'b00;
            pmac_rx_dv_pcs    = {2{~wait_for_start}};
            pmac_rx_er_pcs    = {2{error_forward}};
          end
        else
          begin
            pmac_rxd          = 8'd0;
            pmac_rxd_par      = 1'b0;
            pmac_rx_dv        = ~wait_for_start;
            pmac_rx_er        = error_forward;

            pmac_rxd_pcs      = 16'd0;
            pmac_rxd_par_pcs  = 2'b00;
            pmac_rx_dv_pcs    = 2'd0;
            pmac_rx_er_pcs    = 2'd0;
          end
      end
    else
      begin
        if(data_16)
          begin
            pmac_rxd      = 8'd0;
            pmac_rxd_par  = 1'b0;
            pmac_rx_dv    = 1'd0;
            pmac_rx_er    = 1'd0;
            case (n_state_pipe4)
              INIT_RX, EXPRESS, BAD_FRAG, ASSEMBLY_ERROR:
              begin
                pmac_rxd_pcs      = 16'd0;
                pmac_rxd_par_pcs  = 2'b00;
                pmac_rx_dv_pcs    = 2'd0;
                pmac_rx_er_pcs    = 2'd0;
              end

              WAIT_FOR_DV_FALSE:
              begin
                pmac_rxd_pcs      = 16'd0;
                pmac_rxd_par_pcs  = 2'b00;
                pmac_rx_dv_pcs    = 2'b11;
                pmac_rx_er_pcs    = 2'b00;
              end

              IDLE_N_CHECK_FOR_START, LPI, P_RECEIVE_DATA, INCREMENT_FRAG_COUNT:
              begin
                pmac_rxd_pcs      = data_to_driver;
                pmac_rxd_par_pcs  = {par_to_driver[3],par_to_driver[0]};
                pmac_rx_dv_pcs    = {dv_to_driver[3],dv_to_driver[0]};
                pmac_rx_er_pcs    = {er_to_driver[3],er_to_driver[0]};
              end

              REPLACE_SMD:
              begin
                pmac_rxd_pcs      = 16'hd555;
                pmac_rxd_par_pcs  = 2'b10;
                pmac_rx_dv_pcs    = {dv_to_driver[3],dv_to_driver[0]};
                pmac_rx_er_pcs    = {er_to_driver[3],er_to_driver[0]};
              end
              
              default: //WAIT_N_CHECK_FOR_RESUME:
              begin
                if(fw_all_word)
                  begin
                    pmac_rxd_pcs      = rxd_prev;
                    pmac_rxd_par_pcs  = {rxd_par_prev[3],rxd_par_prev[0]};
                    pmac_rx_dv_pcs    = 2'b11;
                    pmac_rx_er_pcs    = 2'b00;
                  end
                else
                  begin
                    pmac_rxd_pcs      = {8'h00,rxd_prev[7:0]};
                    pmac_rxd_par_pcs  = {1'b0,rxd_par_prev[0]};
                    pmac_rx_dv_pcs    = 2'b01;
                    pmac_rx_er_pcs    = 2'b00;
                  end
              end
            endcase
          end
        else // ~data_16
          begin
            case (n_state_pipe2)
              INIT_RX, EXPRESS, BAD_FRAG, ASSEMBLY_ERROR:
              begin
                pmac_rxd          = 8'd0;
                pmac_rxd_par      = 1'b0;
                pmac_rx_dv        = 1'd0;
                pmac_rx_er        = 1'd0;

                pmac_rxd_pcs      = 16'd0;
                pmac_rxd_par_pcs  = 2'b00;
                pmac_rx_dv_pcs    = 2'd0;
                pmac_rx_er_pcs    = 2'd0;
              end

              WAIT_FOR_DV_FALSE:
              begin
                pmac_rxd          = 8'd0;
                pmac_rxd_par      = 1'b0;
                pmac_rx_dv        = data_8in16? 1'd0: 1'd1;
                pmac_rx_er        = 1'd0;

                pmac_rxd_pcs      = 16'd0;
                pmac_rxd_par_pcs  = 2'b00;
                pmac_rx_dv_pcs    = data_8in16? 2'b11: 2'b00;
                pmac_rx_er_pcs    = 2'd0;
              end

              REPLACE_SMD:
              begin
                if(~data_4)
                  begin
                    case(g_cnt)
                      3'b001:
                      begin
                        if(data_8in16)
                          begin
                            pmac_rxd          = 8'd0;
                            pmac_rxd_par      = 1'b0;
                            pmac_rx_dv        = 1'd0;
                            pmac_rx_er        = 1'd0;

                            pmac_rxd_pcs      = {data_to_driver[7:0],data_to_driver[7:0]};
                            pmac_rxd_par_pcs  = {2{par_to_driver[0]}};
                            pmac_rx_dv_pcs    = {dv_to_driver[0],dv_to_driver[0]};
                            pmac_rx_er_pcs    = {er_to_driver[0],er_to_driver[0]};
                          end
                        else
                          begin
                            pmac_rxd          = data_to_driver[7:0];
                            pmac_rxd_par      = par_to_driver[0];
                            pmac_rx_dv        = dv_to_driver[0];
                            pmac_rx_er        = er_to_driver[0];

                            pmac_rxd_pcs      = 16'd0;
                            pmac_rxd_par_pcs  = 2'b00;
                            pmac_rx_dv_pcs    = 2'd0;
                            pmac_rx_er_pcs    = 2'd0;
                          end
                      end
                      default: // 3'b000
                      begin
                        if(data_8in16)
                          begin
                            pmac_rxd          = 8'd0;
                            pmac_rxd_par      = 1'b0;
                            pmac_rx_dv        = 1'd0;
                            pmac_rx_er        = 1'd0;

                            pmac_rxd_pcs      = 16'hd5d5;
                            pmac_rxd_par_pcs  = 2'b11;
                            pmac_rx_dv_pcs    = {dv_to_driver[3],dv_to_driver[3]};
                            pmac_rx_er_pcs    = {er_to_driver[3],er_to_driver[3]};
                          end
                        else
                          begin
                            pmac_rxd          = 8'hd5;
                            pmac_rxd_par      = 1'b1;
                            pmac_rx_dv        = dv_to_driver[3];
                            pmac_rx_er        = er_to_driver[3];

                            pmac_rxd_pcs      = 16'd0;
                            pmac_rxd_par_pcs  = 2'b00;
                            pmac_rx_dv_pcs    = 2'd0;
                            pmac_rx_er_pcs    = 2'd0;
                          end
                      end
                    endcase
                  end
                else //data_4
                  begin
                    pmac_rxd_pcs      = 16'd0;
                    pmac_rxd_par_pcs  = 2'b00;
                    pmac_rx_dv_pcs    = 2'd0;
                    pmac_rx_er_pcs    = 2'd0;
                    case(g_cnt)
                      3'b001:
                      begin
                        pmac_rxd      = {4'd0, data_to_driver[3:0]};
                        pmac_rxd_par  = par_to_driver[0];
                        pmac_rx_dv    = dv_to_driver[0];
                        pmac_rx_er    = er_to_driver[0];
                      end
                      3'b010:
                      begin
                        pmac_rxd      = {4'd0, data_to_driver[7:4]};
                        pmac_rxd_par  = par_to_driver[1];
                        pmac_rx_dv    = dv_to_driver[1];
                        pmac_rx_er    = er_to_driver[1];
                      end
                      3'b011:
                      begin
                        pmac_rxd      = {4'h0, 4'h5};
                        pmac_rxd_par  = par_to_driver[2];
                        pmac_rx_dv    = dv_to_driver[2];
                        pmac_rx_er    = er_to_driver[2];
                      end
                      default:
                      begin
                        pmac_rxd      = {4'h0, 4'hd};
                        pmac_rxd_par  = par_to_driver[3];
                        pmac_rx_dv    = dv_to_driver[3];
                        pmac_rx_er    = er_to_driver[3];
                      end
                    endcase
                  end
              end
                            
              WAIT_N_CHECK_FOR_RESUME:
              begin
                if(~data_4)
                  begin
                    case(fw_cnt)
                      3'b000:
                      begin
                        if(data_8in16)
                          begin
                            pmac_rxd         = 8'd0;
                            pmac_rxd_par     = 1'b0;
                            pmac_rx_dv       = 1'd0;
                            pmac_rx_er       = 1'd0;

                            pmac_rxd_pcs     = {rxd_prev[7:0],rxd_prev[7:0]};
                            pmac_rxd_par_pcs = {2{rxd_par_prev[0]}};
                            pmac_rx_dv_pcs   = 2'b11;
                            pmac_rx_er_pcs   = 2'b00;
                          end
                        else
                          begin
                            pmac_rxd         = rxd_prev[7:0];
                            pmac_rxd_par     = rxd_par_prev[0];
                            pmac_rx_dv       = 1'b1;
                            pmac_rx_er       = 1'b0;

                            pmac_rxd_pcs     = 16'd0;
                            pmac_rxd_par_pcs = 2'b00;
                            pmac_rx_dv_pcs   = 2'd0;
                            pmac_rx_er_pcs   = 2'd0;
                          end
                      end
                      default: // 3'b001
                      begin
                        if(data_8in16)
                          begin
                            pmac_rxd         = 8'd0;
                            pmac_rxd_par     = 1'b0;
                            pmac_rx_dv       = 1'd0;
                            pmac_rx_er       = 1'd0;

                            pmac_rxd_pcs     = {rxd_prev[15:8],rxd_prev[15:8]};
                            pmac_rxd_par_pcs = {2{rxd_par_prev[3]}};
                            pmac_rx_dv_pcs   = 2'b11;
                            pmac_rx_er_pcs   = 2'b00;
                          end
                        else
                          begin
                            pmac_rxd_pcs     = 16'd0;
                            pmac_rxd_par_pcs = 2'b00;
                            pmac_rx_dv_pcs   = 2'd0;
                            pmac_rx_er_pcs   = 2'd0;

                            pmac_rxd         = rxd_prev[15:8];
                            pmac_rxd_par     = rxd_par_prev[3];
                            pmac_rx_dv       = 1'b1;
                            pmac_rx_er       = 1'b0;
                          end
                      end
                    endcase
                  end
                else //data_4
                  begin
                    pmac_rxd_pcs      = 16'd0;
                    pmac_rxd_par_pcs  = 2'b00;
                    pmac_rx_dv_pcs    = 2'd0;
                    pmac_rx_er_pcs    = 2'd0;
                    case(fw_cnt)
                      3'b000:
                      begin
                        pmac_rxd     = {4'h0, rxd_prev[3:0]};
                        pmac_rxd_par = rxd_par_prev[0];
                        pmac_rx_dv   = 1'b1;
                        pmac_rx_er   = 1'b0;
                      end
                      3'b001:
                      begin
                        pmac_rxd     = {4'h0, rxd_prev[7:4]};
                        pmac_rxd_par = rxd_par_prev[1];
                        pmac_rx_dv   = 1'b1;
                        pmac_rx_er   = 1'b0;
                      end
                      3'b010:
                      begin
                        pmac_rxd     = {4'h0,rxd_prev[11:8]};
                        pmac_rxd_par = rxd_par_prev[2];
                        pmac_rx_dv   = 1'b1;
                        pmac_rx_er   = 1'b0;
                      end
                      default: // 3'b011
                      begin
                        pmac_rxd     = {4'h0,rxd_prev[15:12]};
                        pmac_rxd_par = rxd_par_prev[3];
                        pmac_rx_dv   = 1'b1;
                        pmac_rx_er   = 1'b0;
                      end
                    endcase
                  end
              end
              
              default: //IDLE_N_CHECK_FOR_START, LPI, P_RECEIVE_DATA, INCREMENT_FRAG_COUNT:
              begin
                if(~data_4)
                  begin
                    case(g_cnt)
                      3'b001:
                      begin
                        if(data_8in16)
                          begin
                            pmac_rxd          = 8'd0;
                            pmac_rxd_par      = 1'b0;
                            pmac_rx_dv        = 1'd0;
                            pmac_rx_er        = 1'd0;
                            
                            pmac_rxd_pcs      = {data_to_driver[7:0],data_to_driver[7:0]};
                            pmac_rxd_par_pcs  = {par_to_driver[0],par_to_driver[0]};
                            pmac_rx_dv_pcs    = {dv_to_driver[0],dv_to_driver[0]};
                            pmac_rx_er_pcs    = {er_to_driver[0],er_to_driver[0]};
                          end
                        else // if ~data_8in16
                          begin
                            pmac_rxd          = data_to_driver[7:0];
                            pmac_rxd_par      = par_to_driver[0];
                            pmac_rx_dv        = dv_to_driver[0];
                            pmac_rx_er        = er_to_driver[0];

                            pmac_rxd_pcs      = 16'd0;
                            pmac_rxd_par_pcs  = 2'b00;
                            pmac_rx_dv_pcs    = 2'd0;
                            pmac_rx_er_pcs    = 2'd0;
                          end
                      end
                      default: // 3'b000
                      begin
                        if(data_8in16)
                          begin
                            pmac_rxd          = 8'd0;
                            pmac_rxd_par      = 1'b0;
                            pmac_rx_dv        = 1'b0;
                            pmac_rx_er        = 1'b0;

                            pmac_rxd_pcs      = {data_to_driver[15:8],data_to_driver[15:8]};
                            pmac_rxd_par_pcs  = {par_to_driver[3],par_to_driver[3]};
                            pmac_rx_dv_pcs    = {dv_to_driver[3],dv_to_driver[3]};
                            pmac_rx_er_pcs    = {er_to_driver[3],er_to_driver[3]};
                          end
                        else // ~data_8in16
                          begin
                            pmac_rxd          = data_to_driver[15:8];
                            pmac_rxd_par      = par_to_driver[3];
                            pmac_rx_dv        = dv_to_driver[3];
                            pmac_rx_er        = er_to_driver[3];

                            pmac_rxd_pcs      = 16'd0;
                            pmac_rxd_par_pcs  = 2'b00;
                            pmac_rx_dv_pcs    = 2'd0;
                            pmac_rx_er_pcs    = 2'd0;
                          end
                      end
                    endcase
                  end
                else //data_4
                  begin
                    pmac_rxd_pcs      = 16'd0;
                    pmac_rxd_par_pcs  = 2'b00;
                    pmac_rx_dv_pcs    = 2'd0;
                    pmac_rx_er_pcs    = 2'd0;
                    case(g_cnt)
                      3'b001:
                      begin
                        pmac_rxd      = {4'd0,data_to_driver[3:0]};
                        pmac_rxd_par  = par_to_driver[0];
                        pmac_rx_dv    = dv_to_driver[0];
                        pmac_rx_er    = er_to_driver[0];
                      end
                      3'b010:
                      begin
                        pmac_rxd      = {4'd0,data_to_driver[7:4]};
                        pmac_rxd_par  = par_to_driver[1];
                        pmac_rx_dv    = dv_to_driver[1];
                        pmac_rx_er    = er_to_driver[1];
                      end
                      3'b011:
                      begin
                        pmac_rxd      = {4'd0,data_to_driver[11:8]};
                        pmac_rxd_par  = par_to_driver[2];
                        pmac_rx_dv    = dv_to_driver[2];
                        pmac_rx_er    = er_to_driver[2];
                      end
                      default:
                      begin
                        pmac_rxd      = {4'd0,data_to_driver[15:12]};
                        pmac_rxd_par  = par_to_driver[3];
                        pmac_rx_dv    = dv_to_driver[3];
                        pmac_rx_er    = er_to_driver[3];
                      end
                    endcase
                  end
              end
            endcase
          end
      end
  end

endmodule
