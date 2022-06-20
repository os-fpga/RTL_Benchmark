static int global_init_calltf(char*user_data)
{

	vpiHandle DATA_I  = vpi_handle_by_name("module_tb.DATA_I",NULL);
	vpiHandle WR_DATA  = vpi_handle_by_name("module_tb.WR_DATA",NULL);
	vpiHandle RD_DATA  = vpi_handle_by_name("module_tb.RD_DATA",NULL);
	vpiHandle TICK_IN  = vpi_handle_by_name("module_tb.TICK_IN",NULL);
	vpiHandle TIME_IN  = vpi_handle_by_name("module_tb.TIME_IN",NULL);
	vpiHandle TX_CLK_DIV  = vpi_handle_by_name("module_tb.TX_CLK_DIV",NULL);

	vpiHandle LINKSTART  = vpi_handle_by_name("module_tb.LINK_START",NULL);
	vpiHandle LINKDISABLE= vpi_handle_by_name("module_tb.LINK_DISABLE",NULL);
	vpiHandle AUTOSTART  = vpi_handle_by_name("module_tb.AUTOSTART",NULL);
	vpiHandle RESETn     = vpi_handle_by_name("module_tb.RESETn",NULL);

	vpiHandle DIN     = vpi_handle_by_name("module_tb.Din", NULL);
	vpiHandle SIN     = vpi_handle_by_name("module_tb.Sin", NULL);

	dout_value.format = vpiIntVal;
	sout_value.format = vpiIntVal;

	counter = 0;
	position = 0;
	counter_null = 0;
	state_test_rx=0;

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

	vpi_put_value(DIN, &dout_value, NULL, vpiNoDelay);
	vpi_put_value(SIN, &sout_value, NULL, vpiNoDelay);

	dout_value.value.integer = 0;
	vpi_put_value(LINKSTART, &dout_value, NULL, vpiNoDelay);
	vpi_put_value(LINKDISABLE, &dout_value, NULL, vpiNoDelay);
	vpi_put_value(AUTOSTART, &dout_value, NULL, vpiNoDelay);

	vpi_put_value(DATA_I, &dout_value, NULL, vpiNoDelay);
	vpi_put_value(WR_DATA, &dout_value, NULL, vpiNoDelay);
	vpi_put_value(RD_DATA, &dout_value, NULL, vpiNoDelay);
	vpi_put_value(TICK_IN, &dout_value, NULL, vpiNoDelay);
	vpi_put_value(TIME_IN, &dout_value, NULL, vpiNoDelay);
	vpi_put_value(TX_CLK_DIV, &dout_value, NULL, vpiNoDelay);

	dout_value.value.integer = 1;
	vpi_put_value(RESETn, &dout_value, NULL, vpiNoDelay);

	return 0;
}
