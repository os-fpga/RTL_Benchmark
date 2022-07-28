module async_mem_if(  async_dq, async_addr, async_ub_n, async_lb_n,
                      async_we_n, async_ce_n, async_oe_n,
                      wb_clk_i, wb_rst_i, wb_adr_i, wb_dat_i,
                      wb_we_i, wb_stb_i, wb_cyc_i, wb_sel_i,
                      wb_dat_o, wb_ack_o,
                      ce_setup, op_hold, ce_hold,
                      big_endian_if_i, lo_byte_if_i
                  );

  parameter AW = 32;
  parameter DW = 8;

  inout   [(DW-1):0]  async_dq;
  output  [(AW-1):0]  async_addr;
  output              async_ub_n;
  output              async_lb_n;
  output              async_we_n;
  output              async_ce_n;
  output              async_oe_n;
  input           wb_clk_i;
  input           wb_rst_i;
  input   [31:0]  wb_adr_i;
  input   [31:0]  wb_dat_i;
  input           wb_we_i;
  input           wb_stb_i;
  input           wb_cyc_i;
  input   [3:0]   wb_sel_i;
  output  [31:0]  wb_dat_o;
  output          wb_ack_o;
  input [3:0]     ce_setup;
  input [3:0]     op_hold;  // do not set to zero.
  input [3:0]     ce_hold;
  input           big_endian_if_i;
  input           lo_byte_if_i;


  //---------------------------------------------------
  // big endian bridge

  wire [31:0] beb_wb_dat_i;
  assign beb_wb_dat_i[7:0]    = big_endian_if_i ? wb_dat_i[31:24]  : wb_dat_i[7:0];
  assign beb_wb_dat_i[15:8]   = big_endian_if_i ? wb_dat_i[23:16]  : wb_dat_i[15:8];
  assign beb_wb_dat_i[23:16]  = big_endian_if_i ? wb_dat_i[15:8]   : wb_dat_i[23:16];
  assign beb_wb_dat_i[31:24]  = big_endian_if_i ? wb_dat_i[7:0]    : wb_dat_i[31:24];

  wire [31:0] beb_wb_dat_o;
  assign wb_dat_o[7:0]    = big_endian_if_i ? beb_wb_dat_o[31:24]  : beb_wb_dat_o[7:0];
  assign wb_dat_o[15:8]   = big_endian_if_i ? beb_wb_dat_o[23:16]  : beb_wb_dat_o[15:8];
  assign wb_dat_o[23:16]  = big_endian_if_i ? beb_wb_dat_o[15:8]   : beb_wb_dat_o[23:16];
  assign wb_dat_o[31:24]  = big_endian_if_i ? beb_wb_dat_o[7:0]    : beb_wb_dat_o[31:24];

  wire [3:0] beb_wb_sel_i;
  assign beb_wb_sel_i[0] = big_endian_if_i ? wb_sel_i[3] : wb_sel_i[0];
  assign beb_wb_sel_i[1] = big_endian_if_i ? wb_sel_i[2] : wb_sel_i[1];
  assign beb_wb_sel_i[2] = big_endian_if_i ? wb_sel_i[1] : wb_sel_i[2];
  assign beb_wb_sel_i[3] = big_endian_if_i ? wb_sel_i[0] : wb_sel_i[3];


  //---------------------------------------------------
  // wb_size_bridge
  wire [15:0] wb_lo_dat_o;
  wire [15:0] wb_lo_dat_i;
  wire [31:0] wb_lo_adr_o;
  wire        wb_lo_cyc_o;
  wire        wb_lo_stb_o;
  wire        wb_lo_we_o;
  wire [1:0]  wb_lo_sel_o;
  wire        wb_lo_ack_i;
  wire        wb_lo_err_i = 1'b0;
  wire        wb_lo_rty_i = 1'b0;


  wb_size_bridge i_wb_size_bridge(
                                    .wb_hi_clk_i(wb_clk_i),
                                    .wb_hi_rst_i(wb_rst_i),
                                    .wb_hi_dat_o(beb_wb_dat_o),
                                    .wb_hi_dat_i(beb_wb_dat_i),
                                    .wb_hi_adr_i( wb_adr_i ),
                                    .wb_hi_cyc_i(wb_cyc_i),
                                    .wb_hi_stb_i(wb_stb_i),
                                    .wb_hi_we_i(wb_we_i),
                                    .wb_hi_sel_i(beb_wb_sel_i),
                                    .wb_hi_ack_o(wb_ack_o),
                                    .wb_hi_err_o(),
                                    .wb_hi_rty_o(),

                                    .wb_lo_clk_o(),
                                    .wb_lo_rst_o(),
                                    .wb_lo_dat_i(wb_lo_dat_i),
                                    .wb_lo_dat_o(wb_lo_dat_o),
                                    .wb_lo_adr_o(wb_lo_adr_o),
                                    .wb_lo_cyc_o(wb_lo_cyc_o),
                                    .wb_lo_stb_o(wb_lo_stb_o),
                                    .wb_lo_we_o(wb_lo_we_o),
                                    .wb_lo_sel_o(wb_lo_sel_o),
                                    .wb_lo_ack_i(wb_lo_ack_i),
                                    .wb_lo_err_i(wb_lo_err_i),
                                    .wb_lo_rty_i(wb_lo_rty_i),

                                    .lo_byte_if_i(lo_byte_if_i)
                                  );


  // --------------------------------------------------------------------
  //  state machine inputs

  wire zero_ce_setup  = (ce_setup == 4'h0);
  wire zero_ce_hold   = (ce_hold  == 4'h0);
  wire wait_for_counter;


  // --------------------------------------------------------------------
  //  state machine

  localparam   STATE_DONT_CARE  = 4'b????;
  localparam   STATE_IDLE       = 4'b0001;
  localparam   STATE_CE_SETUP   = 4'b0010;
  localparam   STATE_OP_HOLD    = 4'b0100;
  localparam   STATE_CE_HOLD    = 4'b1000;

  reg [3:0] state;
  reg [3:0] next_state;

  always @(posedge wb_clk_i or posedge wb_rst_i)
    if(wb_rst_i)
      state <= STATE_IDLE;
    else
      state <= next_state;

  always @(*)
    case( state )
      STATE_IDLE:     if( wb_stb_i & wb_cyc_i )
                        if( zero_ce_setup )
                          next_state = STATE_OP_HOLD;
                        else
                          next_state = STATE_CE_SETUP;
                      else
                        next_state = STATE_IDLE;

      STATE_CE_SETUP: if( wait_for_counter )
                        next_state = STATE_CE_SETUP;
                      else
                        next_state = STATE_OP_HOLD;

      STATE_OP_HOLD:  if( wait_for_counter )
                        next_state = STATE_OP_HOLD;
                      else
                        if( zero_ce_hold )
                          next_state = STATE_IDLE;
                        else
                          next_state = STATE_CE_HOLD;

      STATE_CE_HOLD:  if( wait_for_counter )
                        next_state = STATE_CE_HOLD;
                      else
                        next_state = STATE_IDLE;

      default:        next_state = STATE_IDLE;
    endcase


  // --------------------------------------------------------------------
  //  state machine outputs

  wire assert_ce = (state != STATE_IDLE);
  wire assert_op = (state == STATE_OP_HOLD);

  assign wb_lo_ack_i =  ( (state == STATE_OP_HOLD) & ~wait_for_counter & zero_ce_hold) |
                        ( (state == STATE_CE_HOLD) & ~wait_for_counter );


  //---------------------------------------------------
  // async_dq_buffer
  reg [(DW-1):0] async_dq_buffer;
  wire async_dq_buffer_en  = (state == STATE_OP_HOLD);

  always @(posedge wb_clk_i)
    if(async_dq_buffer_en)
      async_dq_buffer <= async_dq;
    else
      async_dq_buffer <= async_dq_buffer;
      

  //---------------------------------------------------
  // bypass_mux

  wire  bypass_mux_en = (state == STATE_OP_HOLD) & zero_ce_hold;
  wire [(DW-1):0] bypass_mux;

  assign bypass_mux = bypass_mux_en ? async_dq : async_dq_buffer;


  // --------------------------------------------------------------------
  //  wait counter mux
  reg  [3:0] counter_mux;

  always @(*)
    case( next_state )
      STATE_CE_SETUP: counter_mux = ce_setup;
      STATE_OP_HOLD:  counter_mux = op_hold;
      STATE_CE_HOLD:  counter_mux = ce_hold;
      default:        counter_mux = 4'bxxxx;
    endcase


  // --------------------------------------------------------------------
  //  wait counter
  reg   [3:0] counter;
  wire        counter_load = ~(state == next_state);

  always @(posedge wb_clk_i)
    if( counter_load )
      counter <= counter_mux - 1'b1;
    else
      counter <= counter - 1'b1;

  assign wait_for_counter = (counter != 4'h0);


  //---------------------------------------------------
  // outputs

  generate
    if( DW == 16 )
      begin
        assign async_dq    = wb_lo_we_o ? wb_lo_dat_o : 16'hzz;
        assign async_addr  = wb_lo_adr_o[AW:1];
        assign wb_lo_dat_i = bypass_mux;
      end
    else
      begin
        assign async_dq    = wb_lo_we_o ? wb_lo_dat_o : 8'hz;
        assign async_addr  = wb_lo_adr_o[(AW-1):0];
        assign wb_lo_dat_i = {8'h00, bypass_mux};
      end
  endgenerate

  assign async_ub_n  = ~wb_lo_sel_o[1];
  assign async_lb_n  = ~wb_lo_sel_o[0];
  assign async_we_n  = ~( wb_lo_we_o & assert_op );
  assign async_ce_n  = ~( wb_stb_i & wb_cyc_i & assert_ce );
  assign async_oe_n  = ~( ~wb_lo_we_o & assert_op );


endmodule



//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

`timescale 1ns/10ps


module wb_size_bridge(
                        input         wb_hi_clk_i,
                        input         wb_hi_rst_i,
                        output [31:0] wb_hi_dat_o,
                        input  [31:0] wb_hi_dat_i,
                        input  [31:0] wb_hi_adr_i,
                        input         wb_hi_cyc_i,
                        input         wb_hi_stb_i,
                        input         wb_hi_we_i,
                        input  [3:0]  wb_hi_sel_i,
                        output        wb_hi_ack_o,
                        output        wb_hi_err_o,
                        output        wb_hi_rty_o,

                        output        wb_lo_clk_o,
                        output        wb_lo_rst_o,
                        input  [15:0] wb_lo_dat_i,
                        output [15:0] wb_lo_dat_o,
                        output [31:0] wb_lo_adr_o,
                        output        wb_lo_cyc_o,
                        output        wb_lo_stb_o,
                        output        wb_lo_we_o,
                        output [1:0]  wb_lo_sel_o,
                        input         wb_lo_ack_i,
                        input         wb_lo_err_i,
                        input         wb_lo_rty_i,
                        
                        input         lo_byte_if_i
                      );

  // --------------------------------------------------------------------
  //  state machine encoder
  reg [2:0] state_enc;
  
  wire state_enc_3_more_chunks  = state_enc[2];
  wire state_enc_1_more_chunks  = state_enc[1];
  wire state_enc_error          = state_enc[0];
  
  always @(*)
    case( { lo_byte_if_i, wb_hi_sel_i } )
      5'b1_0001:  state_enc = { 1'b0, 1'b0, 1'b0 };
      5'b1_0010:  state_enc = { 1'b0, 1'b0, 1'b0 };
      5'b1_0100:  state_enc = { 1'b0, 1'b0, 1'b0 };
      5'b1_1000:  state_enc = { 1'b0, 1'b0, 1'b0 };
      5'b1_0011:  state_enc = { 1'b0, 1'b1, 1'b0 };
      5'b1_1100:  state_enc = { 1'b0, 1'b1, 1'b0 };
      5'b1_1111:  state_enc = { 1'b1, 1'b0, 1'b0 };
      5'b0_0001:  state_enc = { 1'b0, 1'b0, 1'b0 };
      5'b0_0010:  state_enc = { 1'b0, 1'b0, 1'b0 };
      5'b0_0100:  state_enc = { 1'b0, 1'b0, 1'b0 };
      5'b0_1000:  state_enc = { 1'b0, 1'b0, 1'b0 };
      5'b0_0011:  state_enc = { 1'b0, 1'b0, 1'b0 };
      5'b0_1100:  state_enc = { 1'b0, 1'b0, 1'b0 };
      5'b0_1111:  state_enc = { 1'b0, 1'b1, 1'b0 };
      default:   state_enc = { 1'b0, 1'b0, 1'b1 };
    endcase
    
    
  // --------------------------------------------------------------------
  //  state machine

  localparam   STATE_DONT_CARE     = 4'b????;
  localparam   STATE_PASS_THROUGH  = 4'b0001;
  localparam   STATE_1_MORE_CHUNK  = 4'b0010;
  localparam   STATE_2_MORE_CHUNK  = 4'b0100;
  localparam   STATE_3_MORE_CHUNK  = 4'b1000;

  reg [3:0] state;
  reg [3:0] next_state;

  always @(posedge wb_hi_clk_i or posedge wb_hi_rst_i)
    if(wb_hi_rst_i)
      state <= STATE_PASS_THROUGH;
    else
      state <= next_state;

  always @(*)
    case( state )
      STATE_PASS_THROUGH: if( state_enc_1_more_chunks & wb_lo_ack_i & wb_hi_stb_i & wb_hi_cyc_i )
                            next_state = STATE_1_MORE_CHUNK;
                          else if( state_enc_3_more_chunks & wb_lo_ack_i & wb_hi_stb_i & wb_hi_cyc_i )
                            next_state = STATE_3_MORE_CHUNK;
                          else
                            next_state = STATE_PASS_THROUGH;

      STATE_3_MORE_CHUNK: if( wb_lo_ack_i )
                            next_state = STATE_2_MORE_CHUNK;
                          else
                            next_state = STATE_3_MORE_CHUNK;
                            
      STATE_2_MORE_CHUNK: if( wb_lo_ack_i )
                            next_state = STATE_1_MORE_CHUNK;
                          else
                            next_state = STATE_2_MORE_CHUNK;

      STATE_1_MORE_CHUNK: if( wb_lo_ack_i )
                            next_state = STATE_PASS_THROUGH;
                          else
                            next_state = STATE_1_MORE_CHUNK;
                        
      default:            next_state = STATE_PASS_THROUGH;
    endcase
    

  // --------------------------------------------------------------------
  //  byte enable & select
  reg [3:0] byte_enable;
  localparam   BYTE_N_ENABLED  = 4'b0000;
  localparam   BYTE_0_ENABLED  = 4'b0001;
  localparam   BYTE_1_ENABLED  = 4'b0010;
  localparam   BYTE_2_ENABLED  = 4'b0100;
  localparam   BYTE_3_ENABLED  = 4'b1000;
  
  reg [1:0] byte_select;
  localparam   BYTE_0_SELECTED  = 2'b00;
  localparam   BYTE_1_SELECTED  = 2'b01;
  localparam   BYTE_2_SELECTED  = 2'b10;
  localparam   BYTE_3_SELECTED  = 2'b11;
  localparam   BYTE_X_SELECTED  = 2'b??;

  always @(*)
    casez( { lo_byte_if_i, wb_hi_sel_i, state } )
      { 1'b1, 4'b0001, STATE_PASS_THROUGH }:  byte_enable = BYTE_0_ENABLED;
      { 1'b1, 4'b0010, STATE_PASS_THROUGH }:  byte_enable = BYTE_1_ENABLED;
      { 1'b1, 4'b0100, STATE_PASS_THROUGH }:  byte_enable = BYTE_2_ENABLED;
      { 1'b1, 4'b1000, STATE_PASS_THROUGH }:  byte_enable = BYTE_3_ENABLED;
      
      { 1'b1, 4'b0011, STATE_PASS_THROUGH }:  byte_enable = BYTE_0_ENABLED;
      { 1'b1, 4'b0011, STATE_1_MORE_CHUNK }:  byte_enable = BYTE_1_ENABLED;
      
      { 1'b1, 4'b1100, STATE_PASS_THROUGH }:  byte_enable = BYTE_2_ENABLED;
      { 1'b1, 4'b1100, STATE_1_MORE_CHUNK }:  byte_enable = BYTE_3_ENABLED;
      
      { 1'b1, 4'b1111, STATE_PASS_THROUGH }:  byte_enable = BYTE_0_ENABLED;
      { 1'b1, 4'b1111, STATE_3_MORE_CHUNK }:  byte_enable = BYTE_1_ENABLED;
      { 1'b1, 4'b1111, STATE_2_MORE_CHUNK }:  byte_enable = BYTE_2_ENABLED;
      { 1'b1, 4'b1111, STATE_1_MORE_CHUNK }:  byte_enable = BYTE_3_ENABLED;
      
      { 1'b0, 4'b????, STATE_DONT_CARE }:     byte_enable = BYTE_N_ENABLED;
      default:                                byte_enable = BYTE_N_ENABLED;
    endcase

  always @(*)
    case( byte_enable )
      BYTE_0_ENABLED:  byte_select = BYTE_0_SELECTED;
      BYTE_1_ENABLED:  byte_select = BYTE_1_SELECTED;
      BYTE_2_ENABLED:  byte_select = BYTE_2_SELECTED;
      BYTE_3_ENABLED:  byte_select = BYTE_3_SELECTED;
      default:  byte_select = 2'bxx;
    endcase
    

  // --------------------------------------------------------------------
  //  word enable & select
  reg [1:0] word_enable;
  localparam   WORD_N_ENABLED  = 2'b00;
  localparam   WORD_0_ENABLED  = 2'b01;
  localparam   WORD_1_ENABLED  = 2'b10;
  
  reg word_select;
  localparam   WORD_0_SELECTED  = 1'b0;
  localparam   WORD_1_SELECTED  = 1'b1;
  localparam   WORD_X_SELECTED  = 1'b?;

  always @(*)
    casez( { lo_byte_if_i, wb_hi_sel_i, state } )
      { 1'b0, 4'b0011, STATE_PASS_THROUGH }:  word_enable = WORD_0_ENABLED;
      { 1'b0, 4'b1100, STATE_PASS_THROUGH }:  word_enable = WORD_1_ENABLED;
      { 1'b0, 4'b0001, STATE_PASS_THROUGH }:  word_enable = WORD_0_ENABLED;
      { 1'b0, 4'b0010, STATE_PASS_THROUGH }:  word_enable = WORD_0_ENABLED;
      { 1'b0, 4'b0100, STATE_PASS_THROUGH }:  word_enable = WORD_1_ENABLED;
      { 1'b0, 4'b1000, STATE_PASS_THROUGH }:  word_enable = WORD_1_ENABLED;
            
      { 1'b0, 4'b1111, STATE_PASS_THROUGH }:  word_enable = WORD_0_ENABLED;
      { 1'b0, 4'b1111, STATE_1_MORE_CHUNK }:  word_enable = WORD_1_ENABLED;
      
      { 1'b1, 4'b????, STATE_DONT_CARE }:     word_enable = WORD_N_ENABLED;
      default:                                word_enable = WORD_N_ENABLED;
    endcase

  always @(*)
    case( word_enable )
      WORD_0_ENABLED: word_select = WORD_0_SELECTED;
      WORD_1_ENABLED: word_select = WORD_1_SELECTED;
      default:        word_select = 1'bx;
    endcase
    

  // --------------------------------------------------------------------
  //  write mux
  reg [1:0] byte_write_mux_enc;
  
  always @(*)
    casez( {lo_byte_if_i, byte_select, word_select} )
      { 1'b1, BYTE_0_SELECTED, WORD_X_SELECTED }: byte_write_mux_enc = 2'b00;
      { 1'b1, BYTE_1_SELECTED, WORD_X_SELECTED }: byte_write_mux_enc = 2'b01;
      { 1'b1, BYTE_2_SELECTED, WORD_X_SELECTED }: byte_write_mux_enc = 2'b10;
      { 1'b1, BYTE_3_SELECTED, WORD_X_SELECTED }: byte_write_mux_enc = 2'b11;
      { 1'b0, BYTE_X_SELECTED, WORD_0_SELECTED }: byte_write_mux_enc = 2'b00;
      { 1'b0, BYTE_X_SELECTED, WORD_1_SELECTED }: byte_write_mux_enc = 2'b10;
      default:                                    byte_write_mux_enc = 2'b00;
    endcase
  
  reg [7:0] byte_write_mux;

  always @(*)
    case( byte_write_mux_enc )
      2'b00:    byte_write_mux = wb_hi_dat_i[7:0];
      2'b01:    byte_write_mux = wb_hi_dat_i[15:8];
      2'b10:    byte_write_mux = wb_hi_dat_i[23:16];
      2'b11:    byte_write_mux = wb_hi_dat_i[31:24];
      default:  byte_write_mux = wb_hi_dat_i[7:0];
    endcase
    
  reg [7:0] word_write_mux;

  always @(*)
    case( word_select )
      WORD_0_SELECTED:  word_write_mux = wb_hi_dat_i[15:8];
      WORD_1_SELECTED:  word_write_mux = wb_hi_dat_i[31:24];
      default:          word_write_mux = wb_hi_dat_i[15:8];
    endcase
    
    
  // --------------------------------------------------------------------
  //  read buffer & bypass mux 
  
  // low side input mux
  wire [7:0] read_word_lo_mux = wb_lo_dat_i[7:0];
  wire [7:0] read_word_hi_mux = ( word_enable[0] | word_enable[1] )? wb_lo_dat_i[15:8] : wb_lo_dat_i[7:0];
  
  reg [31:0] read_buffer;
  
  wire read_buffer_0_enable = (byte_enable[0] | word_enable[0]) & ~wb_hi_we_i;
  wire read_buffer_1_enable = (byte_enable[1] | word_enable[0]) & ~wb_hi_we_i;
  wire read_buffer_2_enable = (byte_enable[2] | word_enable[1]) & ~wb_hi_we_i;
  wire read_buffer_3_enable = (byte_enable[3] | word_enable[1]) & ~wb_hi_we_i;
  
  always @(posedge wb_hi_clk_i)
    if( read_buffer_0_enable )
      read_buffer[7:0] <= read_word_lo_mux;
      
  always @(posedge wb_hi_clk_i)
    if( read_buffer_1_enable )
      read_buffer[15:8] <= read_word_hi_mux;
      
  always @(posedge wb_hi_clk_i)
    if( read_buffer_2_enable )
      read_buffer[23:16] <= read_word_lo_mux;
      
  always @(posedge wb_hi_clk_i)
    if( read_buffer_3_enable )
      read_buffer[31:24] <= read_word_hi_mux;
      
  wire [31:0] read_buffer_mux;
  
  // bypass read mux
  assign read_buffer_mux[7:0]   = read_buffer_0_enable ? read_word_lo_mux : read_buffer[7:0];
  assign read_buffer_mux[15:8]  = read_buffer_1_enable ? read_word_hi_mux : read_buffer[15:8];
  assign read_buffer_mux[23:16] = read_buffer_2_enable ? read_word_lo_mux : read_buffer[23:16];
  assign read_buffer_mux[31:24] = read_buffer_3_enable ? read_word_hi_mux : read_buffer[31:24];
      
      
  // --------------------------------------------------------------------
  //  misc logic
  wire [1:0] lo_addr_bits;
  assign lo_addr_bits = ( |byte_enable ) ? byte_select : { word_select, 1'b0 };
  
  wire all_done = ( ~(|state_enc) & (state == STATE_PASS_THROUGH) ) |
                  ( |state_enc & (state == STATE_1_MORE_CHUNK) );
                  
  reg [1:0] wb_lo_sel_r;                                  
  always @(*)
    casez( { lo_byte_if_i, wb_hi_sel_i, state } )      
      { 1'b0, 4'b0001, STATE_PASS_THROUGH }:  wb_lo_sel_r = 2'b01;
      { 1'b0, 4'b0010, STATE_PASS_THROUGH }:  wb_lo_sel_r = 2'b10;
      { 1'b0, 4'b0100, STATE_PASS_THROUGH }:  wb_lo_sel_r = 2'b01;
      { 1'b0, 4'b1000, STATE_PASS_THROUGH }:  wb_lo_sel_r = 2'b10;
      default:                                wb_lo_sel_r = 2'b11;
    endcase
    

    
  // --------------------------------------------------------------------
  //  output port assignments
  assign wb_hi_dat_o = read_buffer_mux;
  assign wb_hi_err_o = (wb_lo_err_i | state_enc_error) & wb_hi_stb_i & wb_hi_cyc_i;
  assign wb_hi_rty_o = wb_lo_rty_i;
  assign wb_hi_ack_o = all_done & wb_hi_stb_i & wb_hi_cyc_i & wb_lo_ack_i;
  
  assign wb_lo_adr_o = { wb_hi_adr_i[31:2], lo_addr_bits };
  assign wb_lo_clk_o = wb_hi_clk_i;
  assign wb_lo_rst_o = wb_hi_rst_i;
  assign wb_lo_cyc_o = wb_hi_cyc_i;
  assign wb_lo_stb_o = wb_hi_stb_i;
  assign wb_lo_we_o  = wb_hi_we_i & wb_hi_stb_i & wb_hi_cyc_i;
  assign wb_lo_dat_o = {word_write_mux, byte_write_mux};
  assign wb_lo_sel_o = wb_lo_sel_r;
  

endmodule

