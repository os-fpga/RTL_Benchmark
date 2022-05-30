static int global_init_calltf(char*user_data)
{

	vpiHandle TX_DATA      = vpi_handle_by_name("module_tb.TOP_TX_DATA",NULL);
	vpiHandle TX_WRITE     = vpi_handle_by_name("module_tb.TOP_TX_WRITE",NULL);
	vpiHandle TX_TICK      = vpi_handle_by_name("module_tb.TOP_TX_TICK",NULL);
	vpiHandle TX_TIME      = vpi_handle_by_name("module_tb.TOP_TX_TIME",NULL);

	vpiHandle BUFFER_READ   = vpi_handle_by_name("module_tb.BUFFER_READ",NULL);
	//vpiHandle TOPSENDFCTNOW    = vpi_handle_by_name("module_tb.TOP_SEND_FCT_NOW",NULL);

	vpiHandle LINKSTART    = vpi_handle_by_name("module_tb.LINK_START",NULL);
	vpiHandle LINKDISABLE  = vpi_handle_by_name("module_tb.LINK_DISABLE",NULL);
	vpiHandle AUTOSTART    = vpi_handle_by_name("module_tb.AUTO_START",NULL);
	vpiHandle RESETn       = vpi_handle_by_name("module_tb.RESETN",NULL);

	vpiHandle DOUT         = vpi_handle_by_name("module_tb.TOP_DOUT", NULL);
	vpiHandle SOUT         = vpi_handle_by_name("module_tb.TOP_SOUT", NULL);

	dout_value.format = vpiIntVal;
	sout_value.format = vpiIntVal;

	counter = 0;
	position = 0;
	counter_null = 0;
	state_test_rx=0;
	state_test_tx_timec=0;

	lib_handle = dlopen("./final_spw.so", RTLD_LAZY);

	if(!lib_handle)
	{
		fprintf(stderr, "%s\n", dlerror());
	}

	create = (Control_SC* (*)())dlsym(lib_handle, "create_object");
	destroy = (void (*)(Control_SC*))dlsym(lib_handle, "destroy_object");

	SC_TOP = (Control_SC*)create();
	SC_TOP->init();

	//SC_TOP->reset_set_low();

	sout_value.value.integer = SC_TOP->get_value_sout();
	dout_value.value.integer = SC_TOP->get_value_dout();

	vpi_put_value(DOUT, &dout_value, NULL, vpiNoDelay);
	vpi_put_value(SOUT, &sout_value, NULL, vpiNoDelay);

	dout_value.value.integer = 0;
	vpi_put_value(LINKSTART, &dout_value, NULL  , vpiNoDelay);
	vpi_put_value(LINKDISABLE, &dout_value, NULL, vpiNoDelay);
	vpi_put_value(AUTOSTART, &dout_value, NULL  ,vpiNoDelay);

	//vpi_put_value(CREDITERRORRX, &dout_value, NULL , vpiNoDelay);
	vpi_put_value(BUFFER_READ, &dout_value, NULL, vpiNoDelay);

	vpi_put_value(TX_DATA, &dout_value, NULL , vpiNoDelay);
	vpi_put_value(TX_WRITE, &dout_value, NULL, vpiNoDelay);

	vpi_put_value(TX_TICK, &dout_value, NULL , vpiNoDelay);
	vpi_put_value(TX_TIME, &dout_value, NULL , vpiNoDelay);

	dout_value.value.integer = 1;
	vpi_put_value(RESETn, &dout_value, NULL  , vpiNoDelay);

	return 0;
}
