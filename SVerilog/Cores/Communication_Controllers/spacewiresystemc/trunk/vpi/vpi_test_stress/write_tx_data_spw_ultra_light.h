static int write_tx_data_spw_ultra_light_calltf(char*user_data)
{
	vpiHandle TX_DATA      = vpi_handle_by_name("module_tb.TOP_TX_DATA",NULL);
	vpiHandle TX_WRITE     = vpi_handle_by_name("module_tb.TOP_TX_WRITE",NULL);
	vpiHandle F_FULL       = vpi_handle_by_name("module_tb.F_FULL",NULL);
	vpiHandle F_EMPTY      = vpi_handle_by_name("module_tb.F_EMPTY",NULL);
	vpiHandle COUNTER_FIFO_TX      = vpi_handle_by_name("module_tb.COUNTER_FIFO_TX",NULL);

	value_to_tx.format = vpiIntVal;

	if(SC_TOP->reset_set())
	{
		if(SC_TOP->start_tx_test())
		{

			//printf("state: %d\n",state_test);

			switch(state_test)
			{
				case SEND_DATA:

					value_to_tx.value.integer = 0;
					vpi_put_value(TX_WRITE, &value_to_tx, NULL, vpiNoDelay);

					value_to_tx.value.integer = SC_TOP->take_data(position);
					vpi_put_value(TX_DATA, &value_to_tx, NULL, vpiNoDelay);

					state_test = 59;
				break;
				case 59:
								
					vpi_get_value(COUNTER_FIFO_TX, &value_to_tx);
					
					if(value_to_tx.value.integer < 63 )
					{
						value_to_tx.value.integer = 1;						
						vpi_put_value(TX_WRITE, &value_to_tx, NULL, vpiNoDelay);
						state_test = WAIT_DATA;
						position = position + 1;
					}
					else
					{


					}

				break;
				case WAIT_DATA:

					value_to_tx.value.integer = 0;						
					vpi_put_value(TX_WRITE, &value_to_tx, NULL, vpiNoDelay);
	
					//vpi_get_value(F_FULL, &value_to_tx);
						
					state_test = SEND_DATA;

					if(position < SC_TOP->size_data_test_vlog())
					{
						//value_to_tx.value.integer = 0;
						//vpi_put_value(TX_WRITE, &value_to_tx, NULL, vpiNoDelay);
						state_test = SEND_DATA;	
					}
					else
					{
						//value_to_tx.value.integer = 0;
						//vpi_put_value(TX_WRITE, &value_to_tx, NULL, vpiNoDelay);
						state_test = 60;
						printf("value is %d\n",position);
					}					
	
				break;
				case 60:
					SC_TOP->end_tx_test();
					counter = position = state_test = 0;
				break;
			}
		}
		else
		{
			position = 0;
		}

	}

	return 0;
}
