static int receive_rx_time_code_spw_ultra_light_calltf(char*user_data)
{
	//vpiHandle CREDIT_ERROR_RX  = vpi_handle_by_name("module_tb.CREDIT_ERROR_RX",NULL);
	//vpiHandle SEND_FCT_NOW 	   = vpi_handle_by_name("module_tb.TOP_SEND_FCT_NOW",NULL);

	//vpiHandle DATARX_FLAG      = vpi_handle_by_name("module_tb.DATARX_FLAG",NULL);
	//vpiHandle BUFFER_WRITE     = vpi_handle_by_name("module_tb.BUFFER_WRITE",NULL);

	vpiHandle TIME_OUT	   = vpi_handle_by_name("module_tb.TIME_OUT",NULL);
	vpiHandle TICK_OUT	   = vpi_handle_by_name("module_tb.TICK_OUT",NULL);

	return 0;
}
