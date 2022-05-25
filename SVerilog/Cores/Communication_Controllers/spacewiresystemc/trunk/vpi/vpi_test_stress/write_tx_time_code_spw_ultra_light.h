static int write_tx_time_code_spw_ultra_light_calltf(char*user_data)
{
	vpiHandle TX_TIMEC      = vpi_handle_by_name("module_tb.TOP_TX_TIME",NULL);
	vpiHandle TX_TICKE      = vpi_handle_by_name("module_tb.TOP_TX_TICK",NULL);
	vpiHandle TX_TICKREADY  = vpi_handle_by_name("module_tb.TOP_TX_READY_TICK",NULL);

	value_to_tx_timec.format = vpiIntVal;

	if(SC_TOP->reset_set())
	{

		if(SC_TOP->enable_time_code_tx_test())
		{
			switch(state_test_tx_timec)
			{
				case SEND_DATA:

					value_to_tx_timec.value.integer = 0;
					vpi_put_value(TX_TICKE, &value_to_tx_timec, NULL, vpiNoDelay);
					state_test_tx_timec = 59;
				break;
				case 59:
								
					value_to_tx_timec.value.integer = timecode;
					vpi_put_value(TX_TIMEC, &value_to_tx_timec, NULL, vpiNoDelay);

					vpi_get_value(TX_TICKREADY, &value_to_tx_timec);
					
					if(value_to_tx_timec.value.integer == 0)
					{
						value_to_tx_timec.value.integer = 1;						
						vpi_put_value(TX_TICKE , &value_to_tx_timec, NULL, vpiNoDelay);
						state_test_tx_timec = WAIT_DATA;
					}

				break;
				case WAIT_DATA:
						
					vpi_get_value(TX_TICKREADY, &value_to_tx_timec);
						
					if(value_to_tx_timec.value.integer == 1)
					{
						state_test_tx_timec = 60;
						
						value_to_tx_timec.value.integer = 0;
						vpi_put_value(TX_TICKE, &value_to_tx_timec, NULL, vpiNoDelay);
						
						//if(position > SC_TOP->size_data_test())
						//{
						//	value_to_tx.value.integer = 0;
						//	vpi_put_value(TX_WRITE, &value_to_tx, NULL, vpiNoDelay);
						//	state_test = 60;	
						//}					
					}
					else
					{
					}	
				break;
				case 60:
					state_test_tx_timec = SEND_DATA;
					timecode = timecode + 1;
				break;
			}
		}
		else
		{
			state_test_tx_timec = SEND_DATA;
		}
	}

	return 0;
}
