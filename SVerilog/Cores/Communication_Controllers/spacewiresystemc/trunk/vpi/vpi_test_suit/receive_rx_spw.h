static int receive_rx_spw_calltf(char*user_data)
{
	vpiHandle DATA_O   = vpi_handle_by_name("module_tb.DATA_O",NULL);
	vpiHandle RD_DATA  = vpi_handle_by_name("module_tb.RD_DATA",NULL);
	vpiHandle RX_EMPTY = vpi_handle_by_name("module_tb.RX_EMPTY",NULL);

	value_to_rx.format = vpiIntVal;

	if(SC_TOP->reset_set())
	{
		switch(state_test_rx)
		{
			case WAIT_DATA:
				vpi_get_value(RX_EMPTY, &value_to_rx);
				if(value_to_rx.value.integer == 1)
				{
					value_to_rx.value.integer = 0;
					vpi_put_value(RD_DATA, &value_to_rx, NULL, vpiNoDelay);
				}else
				{
					value_to_rx.value.integer = 1;
					vpi_put_value(RD_DATA, &value_to_rx, NULL, vpiNoDelay);
					state_test_rx =59;
				}
			break;
			case 59:
					state_test_rx =70;
			break;
			case 70:
					state_test_rx =71;
			break;
			case 71:
					state_test_rx =72;
			break;
			case 72:
					state_test_rx =73;
			break;
			case 73:
					state_test_rx =74;
			break;
			case 74:
					state_test_rx =60;
			break;
			case 60:
				vpi_get_value(DATA_O, &value_to_rx);
				SC_TOP->data_o(value_to_rx.value.integer,data_iteration_vlog);
				data_iteration_vlog++;
				state_test_rx =61;
			break;
			case 61:
				state_test_rx =WAIT_DATA;
				value_to_rx.value.integer = 0;
				vpi_put_value(RD_DATA, &value_to_rx, NULL, vpiNoDelay);

				if(data_iteration_vlog > SC_TOP->size_data_test_sc())
					data_iteration_vlog = 0;
			break;
		}
	}

	return 0;
}
