static int reset_uart_calltf(char*user_data)
{

	vpiHandle RESET = vpi_handle_by_name("module_tb.RESET", NULL);
	vpiHandle RX        = vpi_handle_by_name("module_tb.RX", NULL);
	vpiHandle TX	    = vpi_handle_by_name("module_tb.TX", NULL);
	vpiHandle WORK_FR   = vpi_handle_by_name("module_tb.WORK_FR", NULL);

	reset.format=vpiIntVal;
	rx_value.format = vpiIntVal;
	tx_value.format = vpiIntVal;

	if(SC_UART->reset_set())
	{

		reset.value.integer = 1;
		vpi_put_value(RESET, &reset, NULL, vpiNoDelay);

		tx_value.value.integer = SC_UART->read_tx();
		vpi_put_value(RX, &tx_value, NULL, vpiNoDelay);

		vpi_get_value(TX, &rx_value);
		SC_UART->write_rx(rx_value.value.integer);

		reset.value.integer = SC_UART->get_baud_rate();
		vpi_put_value(WORK_FR, &reset, NULL, vpiNoDelay);
	
		//data.clear();
		//parity.clear();
		//SC_UART->clear_validation();
	}
	else
	{	
		reset.value.integer = 0;
		vpi_put_value(RESET, &reset, NULL, vpiNoDelay);
	}

	return 0;
}
