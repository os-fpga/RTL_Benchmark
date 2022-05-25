static int write_tx_spw_calltf(char*user_data)
{
	vpiHandle DATA_I   = vpi_handle_by_name("module_tb.DATA_I",NULL);
	vpiHandle WR_DATA  = vpi_handle_by_name("module_tb.WR_DATA",NULL);
	vpiHandle TX_FULL  = vpi_handle_by_name("module_tb.TX_FULL",NULL);

	value_to_tx.format = vpiIntVal;

	if(SC_TOP->reset_set())
	{
		if(SC_TOP->start_tx_test())
		{
			switch(state_test)
			{
				case SEND_DATA:
					value_to_tx.value.integer = SC_TOP->take_data(position);
					vpi_put_value(DATA_I, &value_to_tx, NULL, vpiNoDelay);
					state_test = 59;
				break;
				case 59:
					value_to_tx.value.integer = 1;
					vpi_put_value(WR_DATA, &value_to_tx, NULL, vpiNoDelay);
					state_test = WAIT_DATA;
				break;
				case WAIT_DATA:
					value_to_tx.value.integer = 0;
					vpi_put_value(WR_DATA, &value_to_tx, NULL, vpiNoDelay);

					if(position <= SC_TOP->size_data_test_vlog())
					{
						vpi_get_value(TX_FULL, &value_to_tx);
						if(value_to_tx.value.integer == 1)
						{
						}
						else
						{
							state_test = SEND_DATA;
							//counter = counter + 1;
							position = position + 1;
						}
					}
					if(position > SC_TOP->size_data_test_vlog()) 
					{
						state_test = 60;
					}
				break;
				case 60:
					SC_TOP->end_tx_test();
					counter = position = state_test = 0;
				break;
			}
		}

		if(SC_TOP->enable_time_code_tx_test())
		{

		}
	}

	return 0;
}
