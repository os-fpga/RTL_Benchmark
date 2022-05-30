static int global_reset_calltf(char*user_data)
{

	vpiHandle RESETnSPWTCR	= vpi_handle_by_name("module_tb.RESETn", NULL);
	reset.format = vpiIntVal;

	if(!SC_TOP->reset_set())
	{
		reset.value.integer = 0;
		vpi_put_value(RESETnSPWTCR, &reset, NULL, vpiNoDelay);
		state_test = 0;
		state_test_rx=1;
		position = counter = 0;
		SC_TOP->end_tx_test();
	}else
	{
		reset.value.integer = 1;
		vpi_put_value(RESETnSPWTCR, &reset, NULL, vpiNoDelay);
	}

	return 0;
}
