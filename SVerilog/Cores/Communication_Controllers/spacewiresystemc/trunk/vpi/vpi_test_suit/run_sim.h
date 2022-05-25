static int run_sim_calltf(char*user_data)
{

	vpiHandle LINKSTART  = vpi_handle_by_name("module_tb.LINK_START",NULL);
	vpiHandle LINKDISABLE= vpi_handle_by_name("module_tb.LINK_DISABLE",NULL);
	vpiHandle AUTOSTART  = vpi_handle_by_name("module_tb.AUTOSTART",NULL);

	vpiHandle DOUT       = vpi_handle_by_name("module_tb.Dout", NULL);
	vpiHandle SOUT       = vpi_handle_by_name("module_tb.Sout", NULL);
	vpiHandle DIN        = vpi_handle_by_name("module_tb.Din", NULL);
	vpiHandle SIN        = vpi_handle_by_name("module_tb.Sin", NULL);

	vpiHandle DTA        = vpi_handle_by_name("module_tb.SPW_SC_FSM", NULL);
	vpiHandle TX_CLOCK_OUT        = vpi_handle_by_name("module_tb.TX_CLOCK_OUT", NULL);

	vpiHandle i          = vpi_handle_by_name("module_tb.i", NULL);

	dout_value.format    = vpiIntVal;
	sout_value.format    = vpiIntVal;

	din_value.format     = vpiIntVal;
	sin_value.format     = vpiIntVal;

	fsm_value.format     = vpiIntVal;

	link_enable_value.format    = vpiIntVal;
	auto_start_value.format     = vpiIntVal;
	link_disable_value.format   = vpiIntVal;

	v_generate.format=vpiIntVal;
	//fsm_value.format     = vpiIntVal;
	//message_value.format = vpiIntVal;

	if(SC_TOP->finish_simulation() == 1)
	{
		v_generate.value.integer = 1;
		vpi_put_value(i, &v_generate, NULL, vpiNoDelay);
		SC_TOP->stop_sim();
		destroy(SC_TOP);
	}
	else
	{
		SC_TOP->run_sim();

		link_enable_value.value.integer  = SC_TOP->verilog_linkenable();
		vpi_put_value(LINKSTART, &link_enable_value, NULL, vpiNoDelay);

		auto_start_value.value.integer   = SC_TOP->verilog_autostart();
		vpi_put_value(AUTOSTART, &auto_start_value, NULL, vpiNoDelay);

		link_disable_value.value.integer = SC_TOP->verilog_linkdisable();
		vpi_put_value(LINKDISABLE, &link_disable_value, NULL, vpiNoDelay);

		sin_value.value.integer = SC_TOP->get_value_sout();
		din_value.value.integer = SC_TOP->get_value_dout();
		vpi_put_value(DIN, &din_value, NULL, vpiNoDelay);
		vpi_put_value(SIN, &sin_value, NULL, vpiNoDelay);

		vpi_get_value(SOUT, &sout_value);
		vpi_get_value(DOUT, &dout_value);
		SC_TOP->set_rx_sin(sout_value.value.integer);
		SC_TOP->set_rx_din(dout_value.value.integer);

		//fsm_value.value.integer = SC_TOP->get_spw_fsm();
		//vpi_put_value(DTA, &fsm_value, NULL, vpiNoDelay);

		//fsm_value.value.integer = SC_TOP->clock_tx();
		//vpi_put_value(TX_CLOCK_OUT, &fsm_value, NULL, vpiNoDelay);

	}


	return 0;
}
