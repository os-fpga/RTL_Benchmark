static int global_counter_calltf(char*user_data)
{
		vpiHandle i = vpi_handle_by_name("module_tb.i", NULL);
		vpiHandle READY     = vpi_handle_by_name("module_tb.READY", NULL);
		vpiHandle RESET     = vpi_handle_by_name("module_tb.RESET", NULL);

		v_generate.format=vpiIntVal;
		ready_rx.format  =vpiIntVal;
		reset.format	= vpiIntVal;
			

		if(counter > 100)
		{
			v_generate.value.integer = 1;
			vpi_put_value(i, &v_generate, NULL, vpiNoDelay);
			SC_UART->stop_sim();
			destroy(SC_UART);
		}

		vpi_get_value(READY, &ready_rx);
		vpi_get_value(RESET, &reset);
		
		if(ready_rx.value.integer == 1 && reset.value.integer == 0)
		{
			counter = counter + 1;	
		}


		return 0;
		
}
