static int run_sim_calltf(char*user_data)
{
	#ifndef LOOPBACK_VLOG
	#define LOOPBACK_VLOG
		vpiHandle DOUT         = vpi_handle_by_name("module_tb.TOP_DOUT", NULL);
		vpiHandle SOUT         = vpi_handle_by_name("module_tb.TOP_SOUT", NULL);
		vpiHandle DIN          = vpi_handle_by_name("module_tb.TOP_DIN", NULL);
		vpiHandle SIN          = vpi_handle_by_name("module_tb.TOP_SIN", NULL);
	#endif
	vpiHandle DTA        = vpi_handle_by_name("module_tb.SPW_SC_FSM", NULL);
	//vpiHandle TX_CLOCK_OUT        = vpi_handle_by_name("module_tb.TX_CLOCK_OUT", NULL);

	vpiHandle i          = vpi_handle_by_name("module_tb.i", NULL);
	vpiHandle tx_clock   = vpi_handle_by_name("module_tb.time_clk_ns", NULL);


	dout_value.format    = vpiIntVal;
	sout_value.format    = vpiIntVal;

	din_value.format     = vpiIntVal;
	sin_value.format     = vpiIntVal;

	fsm_value.format     = vpiIntVal;

	v_generate.format=vpiIntVal;
	fsm_value.format     = vpiIntVal;
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

		if(LOOPBACK_VLOG_EN == 0)	
		{
			sin_value.value.integer = SC_TOP->get_value_sout();
			din_value.value.integer = SC_TOP->get_value_dout();
			vpi_put_value(DIN, &din_value, NULL, vpiNoDelay);
			vpi_put_value(SIN, &sin_value, NULL, vpiNoDelay);

			vpi_get_value(SOUT, &sout_value);
			vpi_get_value(DOUT, &dout_value);

			SC_TOP->set_rx_sin(sout_value.value.integer);
			SC_TOP->set_rx_din(dout_value.value.integer);

			fsm_value.value.integer = SC_TOP->get_spw_fsm();
			vpi_put_value(DTA, &fsm_value, NULL, vpiNoDelay);

			vpi_get_value(tx_clock, &sout_value);

		}

		if(sout_value.value.integer != SC_TOP->verilog_frequency())
		{
			sin_value.value.integer = SC_TOP->verilog_frequency();
			vpi_put_value(tx_clock, &sin_value, NULL, vpiNoDelay);
		}

		//fsm_value.value.integer = SC_TOP->clock_tx();
		//vpi_put_value(TX_CLOCK_OUT, &fsm_value, NULL, vpiNoDelay);

	}


	return 0;
}
