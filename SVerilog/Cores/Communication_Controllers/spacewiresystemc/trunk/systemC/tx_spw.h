#ifndef SPW_TX_T_H
#define SPW_TX_T_H

#define START  	        0
#define SEND_NULL_START 1
#define SEND_FCT_START  2
#define SEND_NULL       3
#define SEND_FCT        4
#define SEND_NCHAR      5
#define SEND_TIMEC      6

#define TYPE_TIMECODE      4
#define TYPE_FCT           5
#define TYPE_NCHAR         6
#define TYPE_EOP_EEP 	   7
#define TYPE_NULL 	   8

class SPW_TX_SC;

SC_MODULE(SPW_TX_SC)
{
	//SIGNALS
	sc_in<bool> CLOCK_TX;
	sc_in<bool> RESET_TX;

	sc_in<bool> CLOCK_SYS;

	sc_in<bool> TICKIN_TX;
	sc_in<sc_uint<8> > TIMEIN_CONTROL_FLAG_TX;

	sc_in<bool> TXWRITE_TX;
	sc_in<sc_uint<9> > TXDATA_FLAGCTRL_TX;

	sc_in<bool> SEND_FCT_NOW;

	sc_in<bool> ENABLE_TX;
	sc_in<bool> SEND_NULL_TX;
	sc_in<bool> SEND_FCT_TX;
	sc_in<bool> SEND_NCHAR_TX;
	sc_in<bool> SEND_TIME_CODE_TX;
	sc_in<bool> GOTFCT_TX;

	sc_out<bool> READY_TX;
	sc_out<bool> READY_TICK;
	sc_out<uint> DOUT;
	sc_out<uint> SOUT;
	sc_out<sc_uint<4> > FSM_TX;

	//INTERNAL
	sc_uint<9> TXDATA_FLAGCTRL_TX_AUX;
	sc_uint<9> TXDATA_FLAGCTRL_TX_LAST;

	sc_uint<8> LAST_TIMEIN_CONTROL_FLAG_TX;

	sc_uint<8> NULL_TOKEN;
	sc_uint<4> FCT_TOKEN;
	sc_uint<9> DATA_TOKEN;
	sc_uint<14> TIMEC_TOKEN;

	sc_uint<14> ALL_TOKEN;

	sc_uint<4> state_tx;


	sc_signal<bool> enable_null;
	sc_signal<bool> enable_fct;
	sc_signal<bool> enable_time_code;
	sc_signal<bool> enable_n_char;

	bool first_time;
	bool working;
	
	unsigned int last_type;	
	unsigned int COUNTER;
	unsigned int counter_first_time;

	uint FCT_COUNTER;

	uint FCT_SEND = 0;

	sc_uint<4> ESC;
	sc_uint<4> EOP;
	sc_uint<4> EEP;
	sc_uint<4> FCT;

	sc_uint<8> NULL_S;
	sc_uint<14> TIME_CODE;

	uint DOUT_LAST;
	uint SOUT_LAST;

	//STATE MACHINE CONTROL
	void TYPE_DATA_STATE()
	{
		//cout << "TYPE_DATA_STATE" << endl;
			
			if(RESET_TX)
			{
				//cout << "RESETED" << " " << RESET_TX << endl;
				state_tx = START;
				DOUT_LAST = 0;
				COUNTER = 0;
				FCT_COUNTER = 0;
				counter_first_time = 0;
				//FCT_SEND = 0;

				last_type = TYPE_NULL;

				first_time       = true;
				enable_null	 = false;
				enable_fct	 = false;
				enable_time_code = false;
				enable_n_char	 = false;
			}
			else
			{
				FSM_TX = state_tx;
				//cout << "STATE TX: " << state_tx << endl;
				switch(state_tx)
				{
					case START:

						if(SEND_NULL_TX && ENABLE_TX)
						{
							enable_null	 = true;
							enable_fct	 = false;
							enable_time_code = false;
							enable_n_char	 = false;
							state_tx = SEND_NULL_START;
						}
					break;
					case SEND_NULL_START:

						enable_null	 = true;
						enable_fct	 = false;
						enable_time_code = false;
						enable_n_char	 = false;
						
						state_tx = SEND_NULL_START;
						last_type = TYPE_NULL;

						if(SEND_NULL_TX && SEND_FCT_TX && ENABLE_TX && counter_first_time > 0)
						{
							if(COUNTER == 7)
							{
								state_tx = SEND_FCT_START;						
							}
							//cout << enable_fct << endl;
						}
					break;
					case SEND_FCT_START:
						
						enable_null	 = false;
						enable_fct	 = true;
						enable_time_code = false;
						enable_n_char	 = false;

						if(COUNTER == 3)
							FCT_SEND = FCT_SEND - 1;

						if(SEND_FCT_TX && FCT_SEND > 0)
						{
							state_tx =  SEND_FCT_START;
						}
						else
						{
							if(FCT_SEND == 0)
								state_tx =  SEND_NULL;
						}
						
						//cout << enable_null << " " << enable_fct << endl;
					break;
					case SEND_NULL:

						if(COUNTER == 7)
						{
							if(TICKIN_TX)
							{
								state_tx =  SEND_TIMEC;
							}else if(FCT_SEND > 0)
							{
								state_tx =  SEND_FCT;
							}else if(TXWRITE_TX && FCT_COUNTER  > 0)
							{
								state_tx =  SEND_NCHAR;
							}else
							{
								state_tx =  SEND_NULL;
							}
						}
						else
						{
								enable_null 	 = true;
								enable_fct	 = false;
								enable_time_code = false;
								enable_n_char	 = false;
						}
					break;
					case SEND_FCT:
						if(COUNTER == 3)
						{

							FCT_SEND = FCT_SEND - 1;

							if(TICKIN_TX)
							{
								state_tx =  SEND_TIMEC;
							}else if(FCT_SEND > 0)
							{
								state_tx =  SEND_FCT;
							}else if(TXWRITE_TX && FCT_COUNTER  > 0)
							{
								state_tx =  SEND_NCHAR;
							}else 
							{
								state_tx =  SEND_NULL;
							}
						}
						else
						{
							enable_null	 = false;
							enable_fct	 = true;
							enable_time_code = false;
							enable_n_char	 = false;
						}
					break;
					case SEND_NCHAR:

						if(TXDATA_FLAGCTRL_TX_AUX[8])
						{
							if(COUNTER == 3)
							{
								FCT_COUNTER = FCT_COUNTER - 1;

								if(TICKIN_TX)
								{
									state_tx =  SEND_TIMEC;
								}else if(TXWRITE_TX && FCT_COUNTER > 0)
								{
									state_tx =  SEND_NCHAR;
								}else
								{
									state_tx =  SEND_NULL;
								}
							}
						}
						else
						{
							if(COUNTER == 9)
							{
								FCT_COUNTER = FCT_COUNTER - 1;

								if(TICKIN_TX)
								{
									state_tx =  SEND_TIMEC;
								}else if(TXWRITE_TX && FCT_COUNTER > 0)
								{
									state_tx =  SEND_NCHAR;
								}else
								{
									state_tx =  SEND_NULL;
								}
							}
						}

						enable_null	 = false;
						enable_fct	 = false;
						enable_time_code = false;
						enable_n_char	 = true;
					break;
					case SEND_TIMEC:
						if(COUNTER == 13)
						{
							if(TICKIN_TX)
							{
								state_tx =  SEND_TIMEC;
							}else if(FCT_SEND > 0)
							{
								state_tx =  SEND_FCT;
							}else if(TXWRITE_TX && FCT_COUNTER > 0)
							{
								state_tx =  SEND_NCHAR;
							}else
							{
								state_tx =  SEND_NULL;
							}
						}
						else
						{
							enable_null	 = false;
							enable_fct	 = false;
							enable_time_code = true;
							enable_n_char	 = false;
						}
					break;
				}
			}
	}

	/*SLOTS OPEN IN OTHER SIDE*/
	void FCT_COUNTER_M()
	{
		if(RESET_TX)
		{
			FCT_COUNTER = 0;
		}
		else
		{
			 if(SEND_FCT_TX && GOTFCT_TX)
			 {
				if(FCT_COUNTER < 49)
					FCT_COUNTER = FCT_COUNTER + 8;
				else
					FCT_COUNTER = FCT_COUNTER + 7;
				//cout << "DATA TO SEND" << " " << FCT_COUNTER <<endl;
			 }
		}
	}

	/*TAKE  FCT SEND FASE */
	void FCT_COUNTER_SEND()
	{
			if(RESET_TX)
				FCT_SEND=7;
			else 
			{
				if(SEND_FCT_NOW)
				{
					FCT_SEND = FCT_SEND + 1;
					//cout << "DATA RECEIVED" <<endl;
				}
			}
	}


	void PROCESS_DATA()
	{
		if(RESET_TX)
		{

			COUNTER = 0;

			DOUT = 0;
			SOUT = 0;

			DOUT_LAST = 0;

			NULL_TOKEN[7] = 0;
			NULL_TOKEN[6] = 0;
			NULL_TOKEN[5] = 1;
			NULL_TOKEN[4] = 0;
			NULL_TOKEN[3] = 1;
			NULL_TOKEN[2] = 1;
			NULL_TOKEN[1] = 1;
			NULL_TOKEN[0] = 0;

			FCT_TOKEN[3] = 0;
			FCT_TOKEN[2] = 0;
			FCT_TOKEN[1] = 1;
			FCT_TOKEN[0] = 0;

			DATA_TOKEN;

			TIMEC_TOKEN[13] = 0;
			TIMEC_TOKEN[12] = 0;
			TIMEC_TOKEN[11] = 0;
			TIMEC_TOKEN[10] = 0;
			TIMEC_TOKEN[9]  = 0;
			TIMEC_TOKEN[8]  = 0;
			TIMEC_TOKEN[7]  = 0;
			TIMEC_TOKEN[6]  = 0;
			TIMEC_TOKEN[5]  = 0;
			TIMEC_TOKEN[4]  = 0;
			TIMEC_TOKEN[3]  = 1;
			TIMEC_TOKEN[2]  = 1;
			TIMEC_TOKEN[1]  = 1;
			TIMEC_TOKEN[0]  = 0;

		}
		else
		{

			READY_TX   = false;
			READY_TICK = false;
			EEP_EOP    = false;

			if(SEND_NULL_TX)
			{

				//if(TXWRITE_TX && COUNTER == 0)
					TXDATA_FLAGCTRL_TX_AUX = TXDATA_FLAGCTRL_TX;
				//else
				//	TXDATA_FLAGCTRL_TX_AUX = TXDATA_FLAGCTRL_TX_AUX;

				//if(TXWRITE_TX && COUNTER == 5)
				//	READY_TX = true;			

				if(enable_null)
				{
					ALL_TOKEN = (0,NULL_TOKEN);
				}else if(enable_fct)
				{
					ALL_TOKEN = (0,FCT_TOKEN);
				}else if(enable_time_code)
				{
					ALL_TOKEN = TIMEC_TOKEN;
				}else if(enable_n_char)
				{
					ALL_TOKEN = (0,TXDATA_FLAGCTRL_TX_AUX.range(7,0),TXDATA_FLAGCTRL_TX_AUX[8],0);
				}

				if(COUNTER == 0)
				{
					if(last_type == TYPE_NULL || last_type == TYPE_FCT)
					{
						if(DOUT == !(ALL_TOKEN[1]^0))
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}

						DOUT = !(ALL_TOKEN[1]^0);

					}else if(last_type == TYPE_NCHAR)
					{

						if(DOUT == !(ALL_TOKEN[1]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]))
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}

						DOUT = !(ALL_TOKEN[1]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]);
					}
					else if(last_type == TYPE_EOP_EEP)
					{
		
						if(DOUT == !(ALL_TOKEN[1]^1))
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}

						DOUT = !(ALL_TOKEN[1]^1);
					}else if(last_type == TYPE_TIMECODE)
					{

						if(DOUT == !(ALL_TOKEN[1]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]))
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}

						DOUT = !(ALL_TOKEN[1]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]);
					}

					COUNTER++;
				}
				else
				{
					if(enable_null)
					{
						if(DOUT == ALL_TOKEN[COUNTER])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}

						DOUT = ALL_TOKEN[COUNTER];

						if(COUNTER == 7)
						{
							COUNTER = 0;
							last_type = TYPE_NULL;
					
							if(state_tx == SEND_NULL_START)
								counter_first_time = counter_first_time + 1;
						}
						else
						{
							COUNTER++;
						}
					}else if(enable_fct)
					{

						if(DOUT == ALL_TOKEN[COUNTER])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}

						DOUT = ALL_TOKEN[COUNTER];

						if(COUNTER == 3)
						{
							COUNTER = 0;
							last_type = TYPE_FCT;
						}
						else
						{
							COUNTER++;
						}
					}else if(enable_time_code)
					{
						if(DOUT == ALL_TOKEN[COUNTER])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}

						DOUT = ALL_TOKEN[COUNTER];

						if(COUNTER == 13)
						{
							COUNTER = 0;
							READY_TICK = true;
							last_type = TYPE_TIMECODE;
							LAST_TIMEIN_CONTROL_FLAG_TX = TIMEIN_CONTROL_FLAG_TX;
						}
						else
						{
							COUNTER++;
						}
					}else if(enable_n_char)
					{

						if(DOUT == ALL_TOKEN[COUNTER])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}

						DOUT = ALL_TOKEN[COUNTER];

						if(TXDATA_FLAGCTRL_TX_AUX[8])
						{
							if(COUNTER == 3)
							{
								COUNTER = 0;
								READY_TX = true;
								TXDATA_FLAGCTRL_TX_LAST = TXDATA_FLAGCTRL_TX_AUX;
								last_type = TYPE_EOP_EEP;
							}
							else
							{
								COUNTER++;
							}
						}
						else
						{
							if(COUNTER == 9)
							{
								COUNTER = 0;
								READY_TX = true;
								TXDATA_FLAGCTRL_TX_LAST = TXDATA_FLAGCTRL_TX_AUX;
								last_type = TYPE_NCHAR;
							}
							else
							{
								COUNTER++;
							}
						}
					}
				}
			}
			else
			{
				DOUT = 0;
				SOUT = 0;
			}
		}					
	}//END METHOD

	SC_CTOR(SPW_TX_SC)
	{
		SC_METHOD(FCT_COUNTER_SEND);
		sensitive << CLOCK_SYS.pos();

		SC_METHOD(FCT_COUNTER_M);
		sensitive << CLOCK_SYS.pos();

		//SC_METHOD(ALL_HERE);
		//sensitive << CLOCK_TX.pos();

		SC_METHOD(PROCESS_DATA);
		sensitive << CLOCK_TX.pos();

		SC_METHOD(TYPE_DATA_STATE);
		sensitive << CLOCK_TX.pos();
	}	
};
#endif
