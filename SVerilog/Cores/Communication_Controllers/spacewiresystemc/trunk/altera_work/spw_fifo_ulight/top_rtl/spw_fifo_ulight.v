module SPW_ULIGHT_FIFO(
								input   FPGA_CLK1_50,
								input          [1:0] KEY,
								
								input		din_a,
								input		sin_a,
								//input		din_b,
								//input		sin_b,
								output	dout_a,
								output	sout_a,
								//output	dout_b,
								//output	sout_b,
								//////////// LED ////////////
								/* 3.3-V LVTTL */
								output   [7:0] LED

							);
							
	wire reset_spw_n_b;
	
	wire top_auto_start;
	wire top_link_start;
	wire top_link_disable;
	
	wire read_enable_rx;
	
	wire f_full_rx;
	wire f_empty_rx;
	
	wire f_empty_tx;
	wire f_full_tx;

	wire [2:0] clock_sel;	
	wire [5:0] top_fsm_i;	
	wire clk_400_mhz;
	wire clk_pll_mhz;
	wire ppll_100_MHZ;
   wire pll_tx_locked_export;	
	
	wire [8:0] datarx_out_flag;
	wire [13:0] monitor_a;
	
	wire top_tx_tick;
	wire [7:0] top_tx_time;
	
	wire [5:0] counter_fifotx;
	wire [5:0] counter_fiforx;
	
	wire top_tx_write;
	wire [8:0] top_tx_data;
	
	wire [7:0] time_out;
	wire tick_out;
	
	wire clk_250_sys;
	
	assign LED[7:7] = pll_tx_locked_export;
							
	ulight_fifo u0 (
		.auto_start_external_connection_export           (top_auto_start),       //           auto_start_external_connection.export
		.clk_clk                                         (FPGA_CLK1_50),         //           clk.clk
		.clock_sel_external_connection_export            (clock_sel),            //           clock_sel_external_connection.export
		.data_flag_rx_external_connection_export         (datarx_out_flag),      //           data_flag_rx_external_connection.export
		.data_info_external_connection_export            (monitor_a),            //           data_info_external_connection.export
		.data_read_en_rx_external_connection_export      (read_enable_rx),      //      data_read_en_rx_external_connection.export
		.fifo_empty_rx_status_external_connection_export (f_empty_rx), // fifo_empty_rx_status_external_connection.export
		.fifo_empty_tx_status_external_connection_export (f_empty_tx), // fifo_empty_tx_status_external_connection.export
		.fifo_full_rx_status_external_connection_export  (f_full_rx),  //  fifo_full_rx_status_external_connection.export
		.fifo_full_tx_status_external_connection_export  (f_full_tx),  //  fifo_full_tx_status_external_connection.export
		.led_pio_test_external_connection_export         (LED[4:0]),         //         led_pio_test_external_connection.export
		.link_disable_external_connection_export         (top_link_disable),         //         link_disable_external_connection.export
		.link_start_external_connection_export           (top_link_start),           //           link_start_external_connection.export
		/*
		.memory_mem_a                                    (<connected-to-memory_mem_a>),                                    //                                   memory.mem_a
		.memory_mem_ba                                   (<connected-to-memory_mem_ba>),                                   //                                         .mem_ba
		.memory_mem_ck                                   (<connected-to-memory_mem_ck>),                                   //                                         .mem_ck
		.memory_mem_ck_n                                 (<connected-to-memory_mem_ck_n>),                                 //                                         .mem_ck_n
		.memory_mem_cke                                  (<connected-to-memory_mem_cke>),                                  //                                         .mem_cke
		.memory_mem_cs_n                                 (<connected-to-memory_mem_cs_n>),                                 //                                         .mem_cs_n
		.memory_mem_ras_n                                (<connected-to-memory_mem_ras_n>),                                //                                         .mem_ras_n
		.memory_mem_cas_n                                (<connected-to-memory_mem_cas_n>),                                //                                         .mem_cas_n
		.memory_mem_we_n                                 (<connected-to-memory_mem_we_n>),                                 //                                         .mem_we_n
		.memory_mem_reset_n                              (<connected-to-memory_mem_reset_n>),                              //                                         .mem_reset_n
		.memory_mem_dq                                   (<connected-to-memory_mem_dq>),                                   //                                         .mem_dq
		.memory_mem_dqs                                  (<connected-to-memory_mem_dqs>),                                  //                                         .mem_dqs
		.memory_mem_dqs_n                                (<connected-to-memory_mem_dqs_n>),                                //                                         .mem_dqs_n
		.memory_mem_odt                                  (<connected-to-memory_mem_odt>),                                  //                                         .mem_odt
		.memory_mem_dm                                   (<connected-to-memory_mem_dm>),                                   //                                         .mem_dm
		.memory_oct_rzqin                                (<connected-to-memory_oct_rzqin>),                                //                                         .oct_rzqin
		*/
		.pll_0_locked_export                             (pll_tx_locked_export),                             //                             pll_0_locked.export
		.pll_0_outclk0_clk                               (clk_400_mhz),   
		//.pll_0_outclk1_clk                               (clk_250_sys), 		//                            pll_0_outclk0.clk
		.reset_reset_n                                   (reset_spw_n_b),                                   //                                    reset.reset_n
		.timecode_ready_rx_external_connection_export    (tick_out),    //    timecode_ready_rx_external_connection.export
		.timecode_rx_external_connection_export          (time_out),          //          timecode_rx_external_connection.export
		.timecode_tx_data_external_connection_export     (top_tx_time),     //     timecode_tx_data_external_connection.export
		.timecode_tx_enable_external_connection_export   (top_tx_tick),   //   timecode_tx_enable_external_connection.export
		.timecode_tx_ready_external_connection_export    (top_tx_ready_tick),    //    timecode_tx_ready_external_connection.export
		.write_data_fifo_tx_external_connection_export   (top_tx_data),   //   write_data_fifo_tx_external_connection.export
		.write_en_tx_external_connection_export          (top_tx_write),          //          write_en_tx_external_connection.export
		.fsm_info_external_connection_export             (top_fsm_i),             //             fsm_info_external_connection.export
		.counter_tx_fifo_external_connection_export      (counter_fifotx),      //      counter_tx_fifo_external_connection.export
		.counter_rx_fifo_external_connection_export      (counter_fiforx)       //      counter_rx_fifo_external_connection.export
	);
	
	spw_ulight_con_top_x A_SPW_TOP(
					 .ppll_100_MHZ(ppll_100_MHZ),
				 	 .ppllclk(clk_pll_mhz),
					 .reset_spw_n_b(reset_spw_n_b),
					 
					 //.clk_sys_250_mhz(clk_250_sys),
									
					 .top_sin(sin_a),
					 .top_din(din_a),
											
					 .top_auto_start(top_auto_start),
					 .top_link_start(top_link_start),
					 .top_link_disable(top_link_disable),

					 .top_tx_write(top_tx_write),
					 .top_tx_data(top_tx_data),

					 .top_tx_tick(top_tx_tick),
					 .top_tx_time(top_tx_time),

					 .read_rx_fifo_en(read_enable_rx),

					 .datarx_flag(datarx_out_flag),

					 .tick_out(tick_out),
					 .time_out(time_out),

					 .top_dout(dout_a),
					 .top_sout(sout_a),

					 .f_full(f_full_tx),
					 .f_empty(f_empty_tx),
					 .f_full_rx(f_full_rx),
					 .f_empty_rx(f_empty_rx),
					 .top_tx_ready_tick(top_tx_ready_tick),

					 .top_fsm(top_fsm_i),
											
					//.data_info(data_a),
					.counter_fifo_tx(counter_fifotx),
					.counter_fifo_rx(counter_fiforx)
				);
											
			debounce_db db_system_spwulight_b(
											.CLK(FPGA_CLK1_50),
											.PB(KEY[1]),
											.PB_state(reset_spw_n_b),
											.PB_down(LED[5:5])
										);
										
		  clock_reduce R_400_to_2_5_10_100_200_300MHZ(
										.clk(clk_400_mhz),
										.clock_sel(clock_sel),
										.reset_n(pll_tx_locked_export),
										.clk_reduced(clk_pll_mhz),
										.clk_100_reduced(ppll_100_MHZ)
									  );
									 
			detector_tokens m_x(
								.rx_din(dout_a),
								.rx_sin(sout_a),
								.rx_resetn(reset_spw_n_b),
								.info(monitor_a)
							 ); 
							
endmodule