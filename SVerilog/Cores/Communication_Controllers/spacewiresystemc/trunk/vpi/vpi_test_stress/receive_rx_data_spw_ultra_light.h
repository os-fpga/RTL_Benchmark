static int receive_rx_data_spw_ultra_light_calltf(char*user_data)
{
	vpiHandle DATARX_FLAG   = vpi_handle_by_name("module_tb.DATARX_FLAG",NULL);
	vpiHandle BUFFER_READ   = vpi_handle_by_name("module_tb.BUFFER_READ",NULL);
	vpiHandle F_FULL_RX     = vpi_handle_by_name("module_tb.F_FULL_RX",NULL);
	vpiHandle F_EMPTY_RX    = vpi_handle_by_name("module_tb.F_EMPTY_RX",NULL);
	vpiHandle COUNTER_FIFO_RX      = vpi_handle_by_name("module_tb.COUNTER_FIFO_RX",NULL);

	value_to_rx.format = vpiIntVal;
	
	if(SC_TOP->reset_set())
	{

		//printf("state: %d\n",state_test_rx);

		switch(state_test_rx)
		{
			case 0:
				vpi_get_value(F_EMPTY_RX, &value_to_rx);
				if(value_to_rx.value.integer == 1)
					state_test_rx = 1;
			break;
			case 1:
				value_to_rx.value.integer = 0;
				vpi_put_value(BUFFER_READ, &value_to_rx, NULL, vpiNoDelay);
				state_test_rx = 2;
			break;
			case 2:
				value_to_rx.value.integer = 0;
				vpi_get_value(COUNTER_FIFO_RX, &value_to_rx);
				if(value_to_rx.value.integer > 0)
				{
					state_test_rx = 3;
				}
			break;
			case 3:

				if(LOOPBACK_VLOG_EN == 0)
				{
					vpi_get_value(DATARX_FLAG, &value_to_rx);
					SC_TOP->data_o(value_to_rx.value.integer,data_rx_received_cnt);
			
					data_rx_received_cnt++;

					if(data_rx_received_cnt == SC_TOP->size_data_test_sc())
						data_rx_received_cnt = 0;
				}

				if(LOOPBACK_VLOG_EN == 1)
				{
					vpi_get_value(DATARX_FLAG, &value_to_rx);
					SC_TOP->data_rx_vlog_loopback_o(value_to_rx.value.integer,data_rx_received_cnt);
			
					data_rx_received_cnt++;

					if(data_rx_received_cnt == SC_TOP->size_data_test_vlog())
						data_rx_received_cnt = 0;
				}

				state_test_rx = 4;
			break;
			case 4:
				value_to_rx.value.integer = 1;
				vpi_put_value(BUFFER_READ, &value_to_rx, NULL, vpiNoDelay);
				state_test_rx = 5;
			break;
			case 5:
				value_to_rx.value.integer = 0;
				vpi_put_value(BUFFER_READ, &value_to_rx, NULL, vpiNoDelay);

				vpi_get_value(F_EMPTY_RX, &value_to_rx);
				if(value_to_rx.value.integer == 1)
					state_test_rx = 1;
			break;
		}

	}

	return 0;
}
