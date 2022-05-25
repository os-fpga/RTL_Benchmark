#ifndef SPW_RX_H
#define SPW_RX_H

#define STATE_RESET     0
#define STATE_ENABLED   1
#define STATE_GOT_BIT   2
#define STATE_GOT_NULL  3

#define ESC       0
#define FCT       1
#define EOP       2
#define EEP       3
#define DATA      4
#define TIME_CODE 5

class SPW_RX_SC;

SC_MODULE(SPW_RX_SC)
{

	sc_in<bool> RX_CLOCK;
	sc_in<uint>  DIN;
	sc_in<uint>  SIN;

	sc_in<bool> CLOCK_SYS;

	sc_in<bool> ENABLE_RX;
	sc_in<bool> RESET_RX;

	sc_out<bool> RX_ERROR;
	sc_out<bool> RX_CREDIT_ERROR;
	sc_out<bool> GOT_BIT;
	sc_out<bool> GOT_NULL;
	sc_out<bool> GOT_NCHAR;
	sc_out<bool> GOT_TIME_CODE;
	sc_out<bool> GOT_FCT;

	sc_out<bool> SEND_FCT_NOW_RX;

	sc_in<bool> BUFFER_READY;
	sc_out<sc_uint<9> > DATARX_FLAG;
	sc_out<bool> BUFFER_WRITE;

	sc_out<sc_uint<8> > TIME_OUT;
	sc_out<bool>	TICK_OUT;
	sc_out<bool>	CONTROL_FLAG_OUT;

	//INTERNAL 
	sc_uint<4> state_rx;

	sc_uint<4> control;
	sc_uint<10> data;
	sc_uint<10> timecode;

	sc_uint<4> control_sys =4;
	sc_uint<4> last_control_sys =4;

	sc_uint<10> data_sys;
	sc_uint<10> last_data;

	sc_uint<10> timecode_sys;
	sc_uint<10> last_timecode;

	sc_signal<bool> tag_found;

	unsigned int counter = 0;
	unsigned int counter_fct = 0;
	unsigned int counter_received_data = 0;
	bool enable_bit;
	bool first_time;

	bool connected = false;

	int cycles=0;

	bool control_found;
	bool data_found;
	bool time_code_found;


	bool last_is_control;
	bool last_is_data;


	bool NULL_FOUND;
	bool FCT_FOUND;
	bool DATA_FOUND;
	bool TIMECODE_FOUND;

	bool control_parity_error;
	bool data_parity_error;
	bool time_code_parity_error;
	bool invalid_combination;

	vector<sc_uint<9> > data_store;
	vector<sc_uint<9> > time_code;

	unsigned int last_char;

	void CalcPARITY()
	{
		control_parity_error = false;
		data_parity_error = false;
		time_code_parity_error = false;


		if(last_is_control)
		{
			if(control_found)
			{
				if(!(control_sys[2]^last_control_sys[0]^last_control_sys[1]) != control_sys[3])
				{
					control_parity_error = true;
				}
			}else if(data_found)
			{
				if(!(data_sys[8]^last_control_sys[0]^last_control_sys[1])  != data_sys[9])
				{
					data_parity_error = true;
				}
			}

		}else if(last_is_data)
		{
			if(control_found)
			{
				if(!(data_sys[8]^last_control_sys[0]^last_control_sys[1])  != data_sys[9])
				{
					control_parity_error = true;
				}
			}else if(data_found)
			{
				if(!(data_sys[8]^last_data[0]^last_data[1]^last_data[2]^last_data[3]^last_data[4]^last_data[5]^last_data[6]^last_data[7]) != data_sys[9])
				{
					data_parity_error = true;
				}
			}
		}

	}

	void gotFCT()
	{
		while(1)
		{
			if(!ENABLE_RX)
			{
				RX_CREDIT_ERROR = false;
				counter_fct = 1;
			}else
			{
				if(counter_fct*8 > 56)
				{
					RX_CREDIT_ERROR = true;
					wait(1);
					RX_CREDIT_ERROR = false;
				}
			}
			wait(1);
		}
	}

	void UPDATE_FCT()
	{
		while(1)
		{
			if(!ENABLE_RX)
			{
				SEND_FCT_NOW_RX = false;
				counter_received_data = 0;
			}else if(counter_received_data >= 64)
			{
				SEND_FCT_NOW_RX = true;
				counter_received_data = 0;
			}else { SEND_FCT_NOW_RX = false;}
			wait(1);
		}
	}


	void TIMER_ADTER850()
	{
		if(GOT_BIT)
		{
			cycles=0;
		}
	}

	void TIMER_850COUNTER()
	{
		if(!ENABLE_RX)
		{
			RX_ERROR = false;
			control_parity_error = false;
			data_parity_error = false;
			time_code_parity_error = false;
			invalid_combination = false;
			cycles = 0;
		}
		else
		{
			//if(GOT_BIT)
			//{
				if(cycles == 43 || control_parity_error || data_parity_error || time_code_parity_error || invalid_combination)
				{
					//RX_ERROR = true;
					#ifdef RX_ERROR_ENABLE
					cout << "ERROR RX ENABLE" << endl;
					cout << control_parity_error << endl;
					cout << data_parity_error << endl;
					cout << time_code_parity_error << endl;
					cout << invalid_combination << endl;
					#endif
				}
				else
				{
					RX_ERROR = false;
					cycles++;
				}
			//}
		}
	}


	void RX_GET_SIGNAL()
	{

		if( NULL_FOUND )
		{
			GOT_NULL   = true;
			GOT_FCT    = false;
			GOT_NCHAR  = false;
		}else if( FCT_FOUND )
		{
			GOT_FCT    = true;
			GOT_NULL   = false;
			GOT_NCHAR  = false;
		}else if( DATA_FOUND )
		{
			GOT_NCHAR  = true;
			GOT_FCT    = false;
			GOT_NULL   = false;
		}else if( TIMECODE_FOUND )
		{
			GOT_TIME_CODE = true;
			GOT_NCHAR  = false;
			GOT_FCT    = false;
			GOT_NULL   = false;
		}	

	}

	void RX_RECEIVER()
	{
		GOT_BIT        = true;
		NULL_FOUND     = false;
		FCT_FOUND      = false;
		DATA_FOUND     = false;
		TIMECODE_FOUND = false;

		last_is_control = false;
		last_is_data	= false;

		data_col_store.clear();

		if(!connected)
		{
			if(counter == 0)
			{
				timecode(0,0) = data(9,9) = control(3,3) = DIN;
				counter++;
			}
			else if(counter == 1)
			{
				timecode(1,1) = data(8,8) = control(2,2) = DIN;	
				counter++;		
			}
			else if(counter == 2)
			{
				timecode(2,2) = data(0,0) = control(1,1) = DIN;
				counter++;
			}else if(counter == 3)
			{
				data_col_store.clear();

				timecode(3,3) = data(1,1) = control(0,0) = DIN;

				counter = 0;

				if(last_control_sys(2,0) == 7 && control(2,0) == 4)
				{
					control_found = true;
					NULL_FOUND = true;
					FCT_FOUND = false;
					DATA_FOUND = false;

					last_char = ESC;

					data_rx_sc_o(0,control,last_control_sys,data,timecode_sys);

					if(counter_fct > 0)
					{
						counter_fct = counter_fct -1;
					}
											

				}else if(last_control_sys(2,0) != 7 && control(2,0) == 4)
				{
					last_char = FCT;
					counter_fct++;
					FCT_FOUND = true;
					connected = true;
					NULL_FOUND = false;

					data_rx_sc_o(1,control,last_control_sys,data,timecode_sys);

				}else if(last_control_sys(2,0) == 4 && control(2,0) == 7)
				{
					last_char = ESC;
					if(counter_fct > 0)
					{
						counter_fct = counter_fct -1;
					}
				}else
				{
					invalid_combination = true;
					connected = false;
					//cout << last_control_sys(2,0) <<  control_sys(2,0) << endl;

					data_rx_sc_o(4,control,last_control_sys,data,timecode_sys);
				}
				last_control_sys = control;
			}
		}
		else
		{
			if(counter == 0)
			{
				timecode(9,9) = data(9,9) = control(3,3) = DIN;
				counter++;
			}
			else if(counter == 1)
			{
				timecode(8,8) = data(8,8) = control(2,2) = DIN;	
				counter++;		
			}
			else if(counter == 2)
			{
				timecode(0,0) = data(0,0) = control(1,1) = DIN;
				counter++;
			}else if(counter == 3)
			{
				timecode(1,1) = data(1,1) = control(0,0) = DIN;
				
				if(control(2,2) == 1)
				{

					last_is_control = control_found;
					last_is_data	= data_found;

					control_found = true;
					data_found    = false;
					counter = 0;
					
					if(last_control_sys(2,0) == 7 && control(2,0) == 4)
					{
						control_found = true;
						NULL_FOUND = true;
						FCT_FOUND  = false;
						DATA_FOUND = false;
						last_char = ESC;
						
						data_rx_sc_o(0,control,last_control_sys,data,timecode_sys);

						if(counter_fct > 0)
						{
							counter_fct = counter_fct -1;
						}
											

					}else if(last_control_sys(2,0) != 7 && control(2,0) == 4)
					{
						last_char = FCT;
						counter_fct++;

						FCT_FOUND  = true;
						NULL_FOUND = false;
						DATA_FOUND = false;

						data_rx_sc_o(1,control,last_control_sys,data,timecode_sys);

					}else if(last_control_sys(2,0) != 7 && control(2,0) == 5)
					{

						last_char = EOP;

						FCT_FOUND  = false;
						NULL_FOUND = false;
						DATA_FOUND = true;
						
						data_rx_sc_o(2,control,last_control_sys,data,timecode_sys);

						if(counter_fct > 0)
						{
							counter_fct = counter_fct - 1;
						}

						counter_received_data = counter_received_data + 8;
					}else if(last_control_sys(2,0) != 7 && control(2,0) == 6)
					{

						//data_col_store.clear();

						last_char = EEP;

						FCT_FOUND  = false;
						NULL_FOUND = false;
						DATA_FOUND = true;
					
						data_rx_sc_o(3,control,last_control_sys,data,timecode_sys);

						if(counter_fct > 0)
						{
							counter_fct = counter_fct -1;
						}

						counter_received_data = counter_received_data + 8;
					}else if((last_control_sys(2,0) == 0 || last_control_sys(2,0) == 6) && control(2,0) == 7)
					{
						last_char = ESC;
						if(counter_fct > 0)
						{
							counter_fct = counter_fct -1;
						}
					}else if(last_control_sys(2,0) == 4 && control(2,0) == 7)
					{
						last_char = ESC;
						if(counter_fct > 0)
						{
							counter_fct = counter_fct -1;
						}
					}else if(last_control_sys(2,0) == 5 && control(2,0) == 7)
					{
						last_char = ESC;
						if(counter_fct > 0)
						{
							counter_fct = counter_fct -1;
						}
					}else
					{
						//data_col_store.clear();

						invalid_combination = true;
						connected = false;

						data_rx_sc_o(4,control,last_control_sys,data,timecode_sys);
					}
					last_control_sys = control;


				}
				else
				{
					counter++;
				}

				//cout << control.to_string(SC_HEX) << endl;
			}else if(counter == 4)
			{
				timecode(2,2) = data(2,2) = DIN;
				counter++;
			}else if(counter == 5)
			{
				timecode(3,3) = data(3,3) = DIN;
				counter++;
			}else if(counter == 6)
			{
				timecode(4,4) = data(4,4) = DIN;
				counter++;
			}else if(counter == 7)
			{
				timecode(5,5) = data(5,5) = DIN;
				counter++;
			}else if(counter == 8)
			{
				timecode(6,6) = data(6,6) = DIN;
				counter++;
			}else if(counter == 9)
			{
				timecode(7,7) = data(7,7) = DIN;
				
				last_is_control = control_found;
				last_is_data	= data_found;

				control_found = false;
				data_found    = true;
		
				if(data(8,8) == 0 && last_control_sys(2,0) != 7)
				{
					data_col_store.clear();
					
					FCT_FOUND = false;
					NULL_FOUND = false;
					DATA_FOUND = true;
					//data_store.push_back(data);
					last_char = DATA;

					control_sys = 0;
					last_control_sys =0;

					data_rx_sc_o(5,control,last_control_sys,data,timecode_sys);

					counter_received_data = counter_received_data + 8;

					//data_iteration++;
					last_data = data;

					if(counter_fct > 0)
					{
						counter_fct = counter_fct -1;
					}


				}else if(data(8,8) == 0 && last_control_sys(2,0) == 7)
				{
					FCT_FOUND  = false;
					NULL_FOUND = false;
					DATA_FOUND = false;
					TIMECODE_FOUND = true;

					timecode_sys = timecode;
					
					last_char = TIME_CODE;
					control_sys = 0;
					last_control_sys =0;

					data_rx_sc_o(6,control,last_control_sys,data,timecode_sys);

					if(counter_fct > 0)
					{
						counter_fct = counter_fct -1;
					}
				}
				counter = 0;
			}
		}

	}

	SC_CTOR(SPW_RX_SC)
	{
		SC_CTHREAD(gotFCT,CLOCK_SYS.pos());

		SC_CTHREAD(UPDATE_FCT,CLOCK_SYS.pos());

		SC_METHOD(TIMER_ADTER850);
		sensitive << RX_CLOCK.pos() << RX_CLOCK.neg();
		dont_initialize();

		SC_METHOD(TIMER_850COUNTER);
		sensitive << CLOCK_SYS.pos();
		dont_initialize();

		SC_METHOD(CalcPARITY);
		sensitive << RX_CLOCK.pos() << RX_CLOCK.neg();
		dont_initialize();

		SC_METHOD(RX_RECEIVER);
		sensitive << RX_CLOCK.pos() << RX_CLOCK.neg();
		dont_initialize();

		SC_METHOD(RX_GET_SIGNAL);
		sensitive << RX_CLOCK.pos() << RX_CLOCK.neg();
		dont_initialize();

	}
};
#endif
