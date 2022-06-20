static int execute_uart_calltf(char*user_data)
{

	vpiHandle RESET     = vpi_handle_by_name("module_tb.RESET", NULL);
	vpiHandle RX        = vpi_handle_by_name("module_tb.RX", NULL);
	vpiHandle START     = vpi_handle_by_name("module_tb.START", NULL);
	vpiHandle DATA_TX   = vpi_handle_by_name("module_tb.DATA_TX", NULL);
	vpiHandle WORK_FR   = vpi_handle_by_name("module_tb.WORK_FR", NULL);
	vpiHandle TX	    = vpi_handle_by_name("module_tb.TX", NULL);
	vpiHandle DATA_RX   = vpi_handle_by_name("module_tb.DATA_RX", NULL);
	vpiHandle PARITY_RX = vpi_handle_by_name("module_tb.PARITY_RX", NULL);
	vpiHandle READY_TX  = vpi_handle_by_name("module_tb.READY_TX", NULL);
	vpiHandle READY     = vpi_handle_by_name("module_tb.READY", NULL);


	reset.format	= vpiIntVal;
	rx_value.format = vpiIntVal;
	tx_value.format = vpiIntVal;
	ready_rx.format = vpiIntVal;
	start_tx.format = vpiIntVal;
	ready_tx.format = vpiIntVal;


	vpi_get_value(RESET, &reset);

	if(reset.value.integer == 0)
	{
		tx_value.value.integer = SC_UART->read_tx();
		vpi_put_value(RX, &tx_value, NULL, vpiNoDelay);

		vpi_get_value(TX, &rx_value);
		SC_UART->write_rx(rx_value.value.integer);

		SC_UART->run_sim();

		vpi_get_value(READY, &ready_rx);

		if(ready_rx.value.integer == 1)
		{
			vpi_get_value(READY_TX, &ready_tx);
			
			if(ready_tx.value.integer == 1)
			{
				start_tx.value.integer = 1;
				vpi_put_value(START, &start_tx, NULL, vpiNoDelay);
			}
		}
		else
		{
			vpi_get_value(READY_TX, &ready_tx);

			if(ready_tx.value.integer == 0)
			{
				start_tx.value.integer = 0;
				vpi_put_value(START, &start_tx, NULL, vpiNoDelay);
			}
		}

	}else
	{
		
	}



	return 0;
}
