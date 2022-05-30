#ifndef SPW_FSM_T_H
#define SPW_FSM_T_H

#include <systemc.h>

#define ERROR_RESET 0
#define ERROR_WAIT  1
#define READY       2
#define STARTED	    3
#define CONNECTING  4
#define RUN	    5

class SPW_FSM_SC;

SC_MODULE(SPW_FSM_SC)
{

	/*FSM signal*/
	sc_in<bool> CLOCK;
	sc_in<bool> RESET;
	sc_in<bool> LINK_START;
	sc_in<bool> LINK_DISABLE;
	sc_in<bool> AUTO_START;
	sc_out<sc_uint<4> > FSM_SPW_OUT;

	/*Signal come from RX Receiver*/
	sc_in<bool> GOT_FCT_RX;
	sc_in<bool> GOT_TIMECODE_RX;
	sc_in<bool> GOTNCHAR_RX;
	sc_in<bool> GOTNULL_RX;
	sc_in<bool> GOTBIT_RX;
	sc_in<bool> CREDITERROR_RX;
	sc_in<bool> RXERROR_RX;
	sc_out<bool> ENABLE_RX;

	/*Signal come from TX Transmit*/
	sc_out<bool> ENABLE_TX;
	sc_out<bool> SEND_NULL_TX;
	sc_out<bool> SEND_FCT_TX;
	sc_out<bool> SEND_NCHAR_TX;
	sc_out<bool> SEND_TIMECODE_TX;
	
	/*RESET TX / RX*/
	sc_out<bool> RESET_TX;
	sc_out<bool> RESET_RX;

	bool After128;

	bool After64;

	sc_uint<4> state_fsm_spw;

	void FSM()
	{

		//cout << "STARTING FSM SPW SC" << endl;
		
		while(1)
		{

			if(!RESET)
			{
				FSM_SPW_OUT = state_fsm_spw = ERROR_RESET;
				ENABLE_TX 	= false;
				SEND_NULL_TX 	= false;
				SEND_FCT_TX	= false;
				SEND_NCHAR_TX	= false;
				SEND_TIMECODE_TX= false;
				RESET_TX = true;
				RESET_RX = true;
			}else
			{
				FSM_SPW_OUT = state_fsm_spw;

				switch(state_fsm_spw)
				{
					case ERROR_RESET:
						RESET_TX = true;
						RESET_RX = true;
						ENABLE_TX = false;
						ENABLE_RX = false;
						if(After64 == true)
						{
							state_fsm_spw = ERROR_WAIT;
						}
						//cout << "ERROR RESET" << endl;
					break;
					case ERROR_WAIT:
						RESET_TX  = true;
						ENABLE_TX = false;
						RESET_RX  = false;
						ENABLE_RX = true;

						if(After128 == true)
						{
							state_fsm_spw = READY;
						}else if(RXERROR_RX || GOT_FCT_RX || GOTNCHAR_RX || GOT_TIMECODE_RX)
						{
							state_fsm_spw = ERROR_RESET;
						}

						//cout << "ERROR WAIT" << endl;
					break;
					case READY:
						RESET_TX   = true;
						RESET_RX   = false;
						ENABLE_RX  = true;
						if(RXERROR_RX || GOT_FCT_RX || GOTNCHAR_RX || GOT_TIMECODE_RX)
						{
							state_fsm_spw = ERROR_RESET;
						}
						else if((!LINK_DISABLE) && (LINK_START ||(AUTO_START && GOTNULL_RX)))
						{
							state_fsm_spw = STARTED;
						}
						
						//cout << "READY" << endl;
					break;
					case STARTED:
						RESET_TX     = false;
						RESET_RX     = false;
						SEND_NULL_TX = true;
						ENABLE_TX    = true;
						ENABLE_RX    = true;

						if(RXERROR_RX || GOT_FCT_RX || GOTNCHAR_RX || GOT_TIMECODE_RX || After128 )
						{
							state_fsm_spw = ERROR_RESET;
						}
						else if(GOTNULL_RX && GOTBIT_RX)
						{
							state_fsm_spw = CONNECTING;
						}
						//cout << "STARTED" << endl;
					break;
					case CONNECTING:

						RESET_TX     = false;
						RESET_RX     = false;
						ENABLE_TX    = true;
						ENABLE_RX    = true;

						SEND_NULL_TX = true;
						SEND_FCT_TX  = true;


						if(RXERROR_RX || GOTNCHAR_RX || GOT_TIMECODE_RX || After128 )
						{
							state_fsm_spw = ERROR_RESET;
						}else if(GOT_FCT_RX)
						{
							state_fsm_spw = RUN;
						}
						//cout << "CONNECTING" << endl;
					break;
					case RUN:

						SEND_NULL_TX 	 = true;
						ENABLE_TX        = true;
						SEND_FCT_TX  	 = true;
						SEND_NCHAR_TX	 = true;
						SEND_TIMECODE_TX = true;
						ENABLE_RX    	 = true;

						if(RXERROR_RX || CREDITERROR_RX || LINK_DISABLE)
						{
							state_fsm_spw = ERROR_RESET;
							//cout << "RX ERROR DETECTED" << endl;
						}
						else
						{
							state_fsm_spw = RUN;
						}

						//cout << "RUN" << endl;
					break;
				}
			}
			wait(1);
		}
	}


	void TIMER_ADTER128()
	{
		while(1)
		{
		  if(!RESET)
		  {
			After128 = false;
		  }
		  else
		  {
			if(state_fsm_spw == ERROR_WAIT || state_fsm_spw == STARTED || state_fsm_spw == CONNECTING)
			{
				After128 = false;
		  		wait(639);
		  		After128 = true;
			}
		  }
			wait(1);
		}
	}

	void TIMER_ADTER64()
	{
		while(1)
		{
		  if(!RESET)
		  {
			After64 = false;
		  }
		  else
		  {
			if(state_fsm_spw == ERROR_RESET)
			{
				After64 = false;
		  		wait(319);
		 		After64 = true;
			}
		  }
			wait(1);
		}
	}


	SC_CTOR(SPW_FSM_SC)
	{
		SC_CTHREAD(FSM,CLOCK.pos());
		SC_CTHREAD(TIMER_ADTER64,CLOCK.pos());
		SC_CTHREAD(TIMER_ADTER128,CLOCK.pos());
	}

};

#endif
