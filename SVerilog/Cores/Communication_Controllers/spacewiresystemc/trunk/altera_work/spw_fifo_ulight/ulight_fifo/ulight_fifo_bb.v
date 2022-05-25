
module ulight_fifo (
	auto_start_external_connection_export,
	clk_clk,
	clock_sel_external_connection_export,
	counter_rx_fifo_external_connection_export,
	counter_tx_fifo_external_connection_export,
	data_flag_rx_external_connection_export,
	data_info_external_connection_export,
	data_read_en_rx_external_connection_export,
	fifo_empty_rx_status_external_connection_export,
	fifo_empty_tx_status_external_connection_export,
	fifo_full_rx_status_external_connection_export,
	fifo_full_tx_status_external_connection_export,
	fsm_info_external_connection_export,
	led_pio_test_external_connection_export,
	link_disable_external_connection_export,
	link_start_external_connection_export,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	pll_0_locked_export,
	pll_0_outclk0_clk,
	reset_reset_n,
	timecode_ready_rx_external_connection_export,
	timecode_rx_external_connection_export,
	timecode_tx_data_external_connection_export,
	timecode_tx_enable_external_connection_export,
	timecode_tx_ready_external_connection_export,
	write_data_fifo_tx_external_connection_export,
	write_en_tx_external_connection_export);	

	output		auto_start_external_connection_export;
	input		clk_clk;
	output	[2:0]	clock_sel_external_connection_export;
	input	[5:0]	counter_rx_fifo_external_connection_export;
	input	[5:0]	counter_tx_fifo_external_connection_export;
	input	[8:0]	data_flag_rx_external_connection_export;
	input	[13:0]	data_info_external_connection_export;
	output		data_read_en_rx_external_connection_export;
	input		fifo_empty_rx_status_external_connection_export;
	input		fifo_empty_tx_status_external_connection_export;
	input		fifo_full_rx_status_external_connection_export;
	input		fifo_full_tx_status_external_connection_export;
	input	[5:0]	fsm_info_external_connection_export;
	output	[4:0]	led_pio_test_external_connection_export;
	output		link_disable_external_connection_export;
	output		link_start_external_connection_export;
	output	[12:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[7:0]	memory_mem_dq;
	inout		memory_mem_dqs;
	inout		memory_mem_dqs_n;
	output		memory_mem_odt;
	output		memory_mem_dm;
	input		memory_oct_rzqin;
	output		pll_0_locked_export;
	output		pll_0_outclk0_clk;
	input		reset_reset_n;
	input		timecode_ready_rx_external_connection_export;
	input	[7:0]	timecode_rx_external_connection_export;
	output	[7:0]	timecode_tx_data_external_connection_export;
	output		timecode_tx_enable_external_connection_export;
	input		timecode_tx_ready_external_connection_export;
	output	[8:0]	write_data_fifo_tx_external_connection_export;
	output		write_en_tx_external_connection_export;
endmodule
