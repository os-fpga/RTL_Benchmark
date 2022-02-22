///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  e_sdio_host_controller
// File Name:    e_sdio_host_controller.v
// 
// Version 1.0   April  1, 2006  -Original
// Version 1.1   Feb.   7, 2007  -Added 16 bit support
// Version 1.2   May.   14,2007  -Fixed cmd to cmd delay
//                               -SDIO power on switch clock line level
//                               -Used latched signal for datline0
//                               -Optimized to use fifo controllers
//                               -Modified to use one RAMBLOCK instead of two
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns


module top(
															reset,
															sys_clk,
															sd_bclkx2,
															intr,
															sdio_clk,
															sdio_on,
															dreq,
															sdio_cd,
															sdio_wp,
															sdio_cmd,
															sdio_dat,
															cs,
															we,
															be_n,
															addr,
															wdata,
															rdata,
															push,
															pop,
															pop_data,
															sdclk_freq,
															volt_supported,
															max_current33v,
															max_current30v,
															max_current18v,
							
															// CEATA interrupts
															fifo_sel_h,
													        fifo_sel_l,
														    fifo_sel_h_d1

														);

	input reset;
	input sys_clk;
	input sd_bclkx2;
	output intr;
 	// sd card interface
	output sdio_clk;   //pragma attribute sdio_clk nopad true
	output sdio_on;
	output dreq;
	input sdio_cd;
	input sdio_wp;
	inout sdio_cmd;
	inout[3:0] sdio_dat;
	// system interface (register path)
	input cs;
	input we;
	input		[1:0]		be_n;
	input[8:1] addr;
	input		[15:0]	wdata;
	output	[15:0]	rdata;
	// system interface (FIFO path)	  
	input push;
	input pop;
	output[15:0] pop_data;
	// capabilities
	input[5:0] sdclk_freq;
	input[2:0] volt_supported;
	input[7:0] max_current33v;
	input[7:0] max_current30v;
	input[7:0] max_current18v;
    
	//////////////////////////// 
	// CEATA interrupts
	input fifo_sel_h;
	input fifo_sel_l;
	input fifo_sel_h_d1;
//	wire   [15:0] normal_int_st;
	
	wire   reset ;
	wire   sys_clk ;
	wire   sd_bclkx2 ;
	wire   intr ;
	wire   sdio_clk ;
	wire   sdio_on ;
	wire   dreq ;
	wire   sdio_cd ;
	wire   sdio_wp ;
	wire   sdio_cmd ;
	wire  [3:0] sdio_dat ;
	wire   cs ;
	wire   we ;
	wire  [8:1] addr ;
	wire  [15:0]	rdata ;
	wire   push ;
	wire   pop ;
	wire  [15:0] pop_data ;
	wire  [5:0] sdclk_freq ;
	wire  [2:0] volt_supported ;
	wire  [7:0] max_current33v ;
	wire  [7:0] max_current30v ;
	wire  [7:0] max_current18v ;
	wire				fifo_rst;
	
	
	//--------------------------------------------------------------------------
	//--------------------------------------------------------------------------
	//-----------------------------------
	// component declaration
	//-----------------------------------
	//-----------------------------------
	// signal declaration
	//-----------------------------------	  
	wire   sd_clk_int ;
	wire  sd_clkn;
	wire  buffer_write_en;
	wire  buffer_read_en;
	wire  sdio_intr;
	wire  write_resp;
	wire	[15:0]	resp_data;
	wire [2:0] resp_addr;
	wire  cmd_rst;
	wire  dat_rst;
//	wire  all_rst;
	wire  intr_gap_en;
	wire  read_wait_en;
	wire  continue_req;
	wire  stop_at_gap_req;
	wire  dat_req;
	wire  intr_gap_en_sync2;
	wire  continue_req_sync2;
	wire  stop_at_gap_req_sync2;
	wire  dat_req_sync2;
	wire  dat_width;
	wire  data_dir;
	wire  block_cnt_0;
	wire  send_cmd;
	wire [3:0] timeout_cfg;
	wire [11:0] block_size_reg;
	wire [31:0] argu_data;
	wire [1:0] resp_type;
	wire  cmd_crc_check;
	wire  cmd_index_check;
	wire  data_present;
	wire [1:0] cmd_type;
	wire [5:0] cmd_index;
	wire  load_clock_div;
	wire  sd_clock_en;
	wire  int_clock_en;
	wire  high_speed;
	wire [7:0] clock_div;
	wire  wp_level;
	wire  cd_level;
	wire  card_stable;
	wire  card_inserted;
	wire  sd_pon;
	wire  sd_pop;
	wire [7:0] xmit_data;
	wire  sd_push;
	wire [7:0] rcv_data;
	wire  dat_active;
	wire  dec_block_cnt;
	wire  sdclk_disable;
	wire  dat_end_error;
	wire  dat_timeout_error;
	wire  dat_crc_error;
	wire [3:0] dat_level;
	wire  cmd_end;
	wire  resp_end;
	wire  check_busy;
	wire  cmd_active;
	wire  cmd_done;
	wire  resp_end_error;
	wire  cmd_timeout_error;
	wire  cmd_crc_error;
	wire  cmd_index_error;
	wire  cmd_level;
	wire  cmd_done_p;
	wire	cmd_active_sync2;
	wire  dat_active_sync2;
	wire  dec_block_cnt_p;
	wire  cmd_timeout_error_p;
	wire  cmd_crc_error_p;
	wire  resp_end_error_p;
	wire  cmd_index_error_p;
	wire  dat_timeout_error_p;
	wire  dat_crc_error_p;
	wire  dat_end_error_p;
	wire  send_cmd_sync2;
	wire  block_cnt_0_sync2;
	wire  sd_clock_en_sync2;
	wire  int_clock_en_sync2;
	wire  load_clock_div_p;
	wire  sdclk_disable_sync2;
	wire  buffer_read_rdy;
	wire  buffer_write_rdy;
   wire  rd_dat_end;
   wire  wr_dat_end;
	wire  datline0;
	
	assign	fifo_rst	= reset | dat_rst;

//--------------------------------------------------------------------------

  // begin of architecture
  //--------------------------------------------------------------------------
  e_registers e_REG(
      .reset(reset),
    .clk(sys_clk),
    .sd_clk(sd_clk_int),
    .intr(intr),
    .cs(cs),
    .we(we),
    .be_n(be_n),
    .addr(addr),
    .wdata(wdata),
    .rdata(rdata),
    .sdclk_freq(sdclk_freq),
    .volt_supported(volt_supported),
    .max_current33v(max_current33v),
    .max_current30v(max_current30v),
    .max_current18v(max_current18v),
    .buffer_write_en(buffer_write_en),
    .buffer_read_en(buffer_read_en),
    .cmd_rst(cmd_rst),
    .dat_rst(dat_rst),
    .all_rst(all_rst),
    .high_speed(high_speed),
    .send_cmd(send_cmd),
    .cmd_crc_check(cmd_crc_check),
    .cmd_index_check(cmd_index_check),
    .cmd_index(cmd_index),
    .resp_type(resp_type),
    .argu_data(argu_data),
    .resp_addr(resp_addr),
    .resp_data(resp_data),
    .write_resp(write_resp),
    .cmd_active(cmd_active_sync2),
    .resp_end_error_p(resp_end_error_p),
    .cmd_timeout_error_p(cmd_timeout_error_p),
    .cmd_crc_error_p(cmd_crc_error_p),
    .cmd_index_error_p(cmd_index_error_p),
    .cmd_done_p(cmd_done_p),
    .cmd_level(cmd_level),
    .dat_width(dat_width),
    .data_dir(data_dir),
    .block_cnt_0(block_cnt_0),
    .block_size_reg(block_size_reg),
    .timeout_cfg(timeout_cfg),
    .data_present(data_present),
    .cmd_type(cmd_type),
    .intr_gap_en(intr_gap_en),
    .read_wait_en(read_wait_en),
	.continue_req (continue_req),
	.stop_at_gap_req (stop_at_gap_req),
    .dat_active(dat_active_sync2),
	.dat_req (dat_req_sync2),
    .dec_block_cnt_p(dec_block_cnt_p),
    .dat_end_error_p(dat_end_error_p),
    .dat_timeout_error_p(dat_timeout_error_p),
    .dat_crc_error_p(dat_crc_error_p),
    .sdio_intr(sdio_intr),
    .dat_level(dat_level),
    .load_clock_div(load_clock_div),
    .sd_clock_en(sd_clock_en),
    .int_clock_en(int_clock_en),
    .clock_div(clock_div),
    .wp_level(wp_level),
    .cd_level(cd_level),
    .card_stable(card_stable),
    .card_inserted(card_inserted),
    .sd_pon(sd_pon),
	.dreq(dreq),
	.normal_int_st( normal_int_st )
	 );

  e_tx_fifo	e_TXFIFO(
                        .fifo_sel_h    ( fifo_sel_h ),
								.fifo_sel_l    ( fifo_sel_l ),
  
      						.rst(fifo_rst),
								.clk(sys_clk),
							   .sd_clk(sd_clk_int),
								.block_size_reg(block_size_reg),
								.dat_end(wr_dat_end),
								.push(push),
								.push_data(wdata),
							   .buffer_write_en(buffer_write_en),
							   .pop(sd_pop),
							   .pop_data(xmit_data),
							   .buffer_read_rdy(buffer_read_rdy)
								);

  e_rx_fifo e_RXFIFO(
                        .fifo_sel_h    ( fifo_sel_h_d1 ),
								.fifo_sel_l    ( fifo_sel_l ),
													 
      						.rst(fifo_rst),
								.clk(sys_clk),
								.sd_clk(sd_clk_int),
								.block_size_reg(block_size_reg),
                        .dat_end(rd_dat_end),
								.push(sd_push),
								.push_data(rcv_data),
								.buffer_write_rdy(buffer_write_rdy),
								.pop(pop),
								.pop_data(pop_data),
 								.buffer_read_en( buffer_read_en )
								);

  e_dat_control e_DAT_CTRL(           .reset( reset ),
									       .rst( dat_rst ),
										    .clk(sd_clk_int),
										    .clkn(sd_clkn),
										    .high_speed(high_speed),
										    .intr_gap_en(intr_gap_en_sync2),
										    .read_wait_en(read_wait_en),
											.continue_req           ( continue_req_sync2   ),
											.stop_at_gap_req        (stop_at_gap_req_sync2 ),
										    .dat_width(dat_width),
										    .data_dir(data_dir),
										    .block_cnt_0(block_cnt_0_sync2),
										    .block_size_reg(block_size_reg),
										    .timeout_cfg(timeout_cfg),
										    .data_present(data_present),
										    .cmd_type(cmd_type),
										    .cmd_end(cmd_end),
										    .resp_end(resp_end),
											.resp_end_no_err         ( resp_end_no_err ),
										    .check_busy(check_busy),
										    .cmd_active(cmd_active),
										    .xmit_data(xmit_data),
										    .buffer_read_rdy(buffer_read_rdy),
										    .buffer_write_rdy(buffer_write_rdy),
										    .rcv_data(rcv_data),
										    .pop_data(sd_pop),
										    .push_data(sd_push),
										    .dat_active(dat_active),
											.dat_req                  (dat_req),
											.dec_block_cnt            (dec_block_cnt),
                                  .wr_dat_end(wr_dat_end),
                                  .rd_dat_end(rd_dat_end),
										    .dat_end_error(dat_end_error),
										    .timeout_error(dat_timeout_error),
										    .crc_error(dat_crc_error),
										    .sdio_intr(sdio_intr),
										    .sdclk_disable(sdclk_disable),
										    .dat_level(dat_level),
						   .dat(sdio_dat),
						   .datline0(datline0)
										  );

  e_cmd_control e_CMD_CTRL(           .reset( reset ),
									            .rst( cmd_rst ),
										    .clk(sd_clk_int),
										    .clkn(sd_clkn),
										    .high_speed(high_speed),
                           							    .datline0(datline0), 
										    .send_cmd(send_cmd_sync2),
										    .cmd_crc_check(cmd_crc_check),
										    .cmd_index_check(cmd_index_check),
										    .cmd_index(cmd_index),
										    .resp_type(resp_type),
										    .argu_data(argu_data),
										    .resp_addr(resp_addr),
										    .resp_data(resp_data),
										    .write_resp(write_resp),
										    .cmd_end(cmd_end),
										    .resp_end(resp_end),
										    .resp_end_no_err( resp_end_no_err ),
										    .check_busy(check_busy),
										    .o_cmd_active(cmd_active),
										    .cmd_done(cmd_done),
										    .resp_end_error(resp_end_error),
										    .timeout_error(cmd_timeout_error),
										    .crc_error(cmd_crc_error),
										    .cmd_index_error(cmd_index_error),
										    .cmd_level(cmd_level),
										    .cmd(sdio_cmd)
										  );

  e_clock_mng e_CLK_MNG(
								      .rst(reset),
									    .sd_clk_2x(sd_bclkx2),
									    .sd_clock_en(sd_clock_en_sync2),
									    .sdclk_disable(sdclk_disable_sync2),
						.sdio_on(sdio_on),
									    .int_clock_en(int_clock_en_sync2),
									    .clock_div(clock_div),
									    .load_clock_div_p(load_clock_div_p),
									    .sd_clkn(sd_clkn),
									    .sd_clk(sdio_clk),
									    .sd_clk_int(sd_clk_int)
									  );

  e_card_detect e_CD_PWR(
      .rst(reset),
    .clk(sys_clk),
    .sd_pon(sd_pon),
    .wp_level(wp_level),
    .cd_level(cd_level),
    .card_stable(card_stable),
    .card_inserted(card_inserted),
    .cd(sdio_cd),
    .wp(sdio_wp),
	.pon(sdio_on)
	);

  e_sync e_SYNC_1(
					      .rst(reset),
						    .sys_clk(sys_clk),
						    .sd_clk(sd_clk_int),
						    .sd_bclkx2(sd_bclkx2),
						    .send_cmd(send_cmd),
						    .cmd_active(cmd_active),
						    .cmd_done(cmd_done),
						    .cmd_timeout_error(cmd_timeout_error),
						    .cmd_crc_error(cmd_crc_error),
						    .resp_end_error(resp_end_error),
						    .cmd_index_error(cmd_index_error),
                            .intr_gap_en             ( intr_gap_en     ) ,
                            .continue_req            ( continue_req    ) ,
                            .stop_at_gap_req         ( stop_at_gap_req ) ,
						    .block_cnt_0(block_cnt_0),
						    .dat_active(dat_active),
							.dat_req                 ( dat_req         ),
							.dec_block_cnt           ( dec_block_cnt   ),
						    .dat_timeout_error(dat_timeout_error),
						    .dat_crc_error(dat_crc_error),
						    .dat_end_error(dat_end_error),
						    .sd_clock_en(sd_clock_en),
						    .int_clock_en(int_clock_en),
						    .load_clock_div(load_clock_div),
                      .sdclk_disable(sdclk_disable),
						    .send_cmd_sync2(send_cmd_sync2),
						    .cmd_active_sync2(cmd_active_sync2),
						    .cmd_done_p(cmd_done_p),
						    .cmd_timeout_error_p(cmd_timeout_error_p),
						    .cmd_crc_error_p(cmd_crc_error_p),
						    .resp_end_error_p(resp_end_error_p),
						    .cmd_index_error_p(cmd_index_error_p),
                            .intr_gap_en_sync2             ( intr_gap_en_sync2     ) ,
                            .continue_req_sync2            ( continue_req_sync2    ) ,
                            .stop_at_gap_req_sync2         ( stop_at_gap_req_sync2 ) ,
						    .block_cnt_0_sync2(block_cnt_0_sync2),
						    .dat_active_sync2(dat_active_sync2),
						    .dec_block_cnt_p(dec_block_cnt_p),
							.dat_req_sync2                 ( dat_req_sync2         ), 
						    .dat_timeout_error_p(dat_timeout_error_p),
						    .dat_crc_error_p(dat_crc_error_p),
						    .dat_end_error_p(dat_end_error_p),
						    .sd_clock_en_sync2(sd_clock_en_sync2),
						    .int_clock_en_sync2(int_clock_en_sync2),
						    .load_clock_div_p(load_clock_div_p),
                      .sdclk_disable_sync2(sdclk_disable_sync2)
						  );

    //--------------------------------------------------------------------------
// end of architecture
//--------------------------------------------------------------------------


endmodule
