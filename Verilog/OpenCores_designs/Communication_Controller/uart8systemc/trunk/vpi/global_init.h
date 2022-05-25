static int global_init_calltf(char*user_data)
{

	vpiHandle RESET     = vpi_handle_by_name("module_tb.RESET", NULL);
	vpiHandle START     = vpi_handle_by_name("module_tb.START", NULL);
	vpiHandle WORK_FR   = vpi_handle_by_name("module_tb.WORK_FR", NULL);
	vpiHandle RX        = vpi_handle_by_name("module_tb.RX", NULL);
	vpiHandle TX	    = vpi_handle_by_name("module_tb.TX", NULL);

	reset.format=vpiIntVal;
	rx_value.format = vpiIntVal;
	tx_value.format = vpiIntVal;

	reset.value.integer = 0;
	vpi_put_value(START, &reset, NULL, vpiNoDelay);
	vpi_put_value(RESET, &reset, NULL, vpiNoDelay);
	
	counter = 0;
	counter_reset = 0;

	lib_handle = dlopen("./sc_uart.so", RTLD_LAZY);
	
	if(!lib_handle)
	{
		fprintf(stderr, "%s\n", dlerror());
	}
	
	create = (Control_SC* (*)())dlsym(lib_handle, "create_object");
	destroy = (void (*)(Control_SC*))dlsym(lib_handle, "destroy_object");
	//ThreadSC  = (ThreadSCRun_dl) dlsym(lib_handle, "ThreadSCRun");
	
	SC_UART = (Control_SC*)create();
	//SC_UART->set_baud_rate(115200,50);
	//SC_UART->init();
	//SC_UART->set_period_clock_sc(20);

	reset.value.integer = SC_UART->get_baud_rate();
	vpi_put_value(WORK_FR, &reset, NULL, vpiNoDelay);

	tx_value.value.integer = SC_UART->read_tx();
	vpi_put_value(RX, &tx_value, NULL, vpiNoDelay);

	vpi_get_value(TX, &rx_value);
	SC_UART->write_rx(rx_value.value.integer);

	return 0;
}
