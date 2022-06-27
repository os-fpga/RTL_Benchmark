#ifndef CONTROL_SC_H
#define CONTROL_SC_H

class Control_SC
{
	public:
	/*Constructor*/
	Control_SC();
	
	/*initialize systemC model*/
	//virtual void init();

	/*Reset the model*/
	virtual bool reset_set();
	virtual void clear_validation();

	/*Finish Simulation*/
	virtual unsigned int finish_simulation();

	/**/
	virtual unsigned int set_clock_rtl();
	virtual bool enable_change();

	/*Get the baud rate and set it to your DUT*/
	virtual int  get_baud_rate();

	/*We use functions to retreive values from RX / TX SytemC to Verilog*/
	virtual void write_rx(unsigned int a);
	virtual int read_tx();

	/**/
	virtual void get_value_sc_vlog(unsigned int value,unsigned int parity);

	/*Run the Env for a mmount off time*/
	virtual void run_sim();

	/*Tell to SystemC to finish*/
	virtual void stop_sim();

};
#endif
