#ifndef ROUTER_H
#define ROUTER_H

#include <systemc>
#include <iostream>
#include "define.h"
#include "packet_header.h"
#include "power_model.h"
using namespace sc_core;
using namespace sc_dt;
using namespace std;

#define CORE_ADDRESS	0
#define WEST_ADDRESS	3
#define EAST_ADDRESS	6
#define NORTH_ADDRESS	9
#define SOUTH_ADDRESS	12
#define OI_ADDRESS		15

#define WRITE_ADDRESS	0
#define READ_ADDRESS	3

extern double ei_energy;
extern double oi_energy;
extern double ei_delay;
extern double oi_delay;

typedef struct PORT{
	bool		set;
	bool		conn_type;
	sc_uint<4>	inport;
	sc_uint<4>	outport;
	sc_uint<2>	in_ch;
	sc_uint<2>	out_ch;
};

typedef struct OI_PORT{
	bool set;
	sc_uint<4> inport;
	sc_uint<4> outport;
};

class router : public sc_module{
public:
//-------------------------west----------------------------------------------------
	sc_in<bool>			w_data_in;		//west input data port.
	sc_out<bool>		w_data_out;		//west output data port.
	
	sc_out<sc_uint<2> >	w_fifo_to_router_sel;	//west select signal.
	sc_out<sc_uint<2> >	w_router_to_fifo_sel;	//west select signal.
	sc_out<bool>		w_write_n;				//left output data control pin.
	sc_out<bool>		w_read_n;		//left input data control pin.
	sc_in<sc_uint<3> >	w_empty;        //State of FIFO is full.
	sc_in<sc_uint<3> >	w_full;         //State of FIFO is empty.
//-----------------------east------------------------------------------------------
	sc_in<bool>			e_data_in;		//east input data port.
	sc_out<bool>		e_data_out;		//east output data port.

	sc_out<sc_uint<2> >	e_fifo_to_router_sel;	//east select signal.
	sc_out<sc_uint<2> >	e_router_to_fifo_sel;	//east select signal.
	sc_out<bool>		e_write_n;		//right output data control pin.
	sc_out<bool>		e_read_n;		//right input data control pin.
	sc_in<sc_uint<3> >	e_empty;		//State of FIFO is full.
	sc_in<sc_uint<3> >	e_full;			//State of FIFO is empty.
//-----------------------north-----------------------------------------------------
	sc_in<bool>			n_data_in;		//north nput data port.
	sc_out<bool>		n_data_out;		//north output data port.
	
	sc_out<sc_uint<2> >	n_fifo_to_router_sel;	//north select signal.
	sc_out<sc_uint<2> >	n_router_to_fifo_sel;	//north select signal.

	sc_out<bool>		n_write_n;		//north output data control pin.
	sc_out<bool>		n_read_n;       //north input data control pin.
	sc_in<sc_uint<3> >	n_empty;        //State of FIFO is full.
	sc_in<sc_uint<3> >	n_full;         //State of FIFO is empty.
//-------------------------south---------------------------------------------------
	sc_in<bool>			s_data_in;      //south input data port.
	sc_out<bool>		s_data_out;		//south output data port.
	
	sc_out<sc_uint<2> >	s_fifo_to_router_sel;	//north select signal.
	sc_out<sc_uint<2> >	s_router_to_fifo_sel;	//north select signal.

	sc_out<bool>		s_write_n;      //south output data control pin.
	sc_out<bool>		s_read_n;       //south input data control pin.
	sc_in<sc_uint<3> >	s_empty;        //State of FIFO is full.
	sc_in<sc_uint<3> >	s_full;         //State of FIFO is empty.
//-----------------------core------------------------------------------------------
	sc_in<bool>			c_data_in;      //core input data port.
	sc_out<bool>		c_data_out;     //core output data port.

	sc_out<sc_uint<2> >	c_fifo_to_router_sel;	//north select signal.
	sc_out<sc_uint<2> >	c_router_to_fifo_sel;	//north select signal.

	sc_out<bool>		c_write_n;      //core output data control pin.
	sc_out<bool>		c_read_n;       //core input data control pin.
	sc_in<sc_uint<3> >	c_empty;        //State of FIFO is full.
	sc_in<sc_uint<3> >	c_full;         //State of FIFO is empty.
//---------------------------------------------------------------------------------
	sc_in<bool>			reset_n;
	sc_in<bool>			clk;
//--------------------Optical interconnects----------------------------------------
	sc_in<sc_logic>			c_oi_in;
	sc_out<sc_logic>		c_oi_out;
	sc_out<sc_uint<16> >	oi_control;
	
	sc_signal<sc_uint<16> >		c_data;
	sc_signal<sc_uint<8> >		c_address;


	SC_HAS_PROCESS(router);
	
	router(sc_module_name nm, int id, int column_num, int row_num): sc_module(nm){
		router_id = id;
		x_num = column_num;
		y_num = row_num;
		
		SC_THREAD(core_receive_data);
		sensitive << clk.pos() << clk.neg();
		SC_THREAD(core_transfer_data);
		sensitive << clk.pos() << clk.neg();

		SC_THREAD(west_receive_data);
		sensitive << clk.pos() << clk.neg();
		SC_THREAD(west_transfer_data);
		sensitive << clk.pos() << clk.neg();

		SC_THREAD(east_receive_data);
		sensitive << clk.pos() << clk.neg();
		SC_THREAD(east_transfer_data);
		sensitive << clk.pos() << clk.neg();

		SC_THREAD(north_receive_data);
		sensitive << clk.pos() << clk.neg();
		SC_THREAD(north_transfer_data);
		sensitive << clk.pos() << clk.neg();

		SC_THREAD(south_receive_data);
		sensitive << clk.pos() << clk.neg();
		SC_THREAD(south_transfer_data);
		sensitive << clk.pos() << clk.neg();

		SC_THREAD(oi_receive_data);
		sensitive << clk.pos() << clk.neg();
		SC_THREAD(oi_transfer_data);
		sensitive << clk.pos() << clk.neg();

		SC_THREAD(direction_handle);
		sensitive << clk.pos();
	}

protected:
	//control register between input channel and outport channel. 
	//where num in port[num] is input channel.
	PORT				port[16];			//Electrical interconnects register.			
	OI_PORT				ois_port[5];		//Optical interconnects register.
	sc_uint<17>			rbuffer[50];		//temporally store data from input channel.
	sc_uint<17>			oi_rbuffer;			//temporally store data from input channel.
	sc_uint<18>			tbuffer[50];		//temporally store data for transmitter.
	sc_uint<18>			oi_tbuffer;			//temporally store data for transmitter.
	sc_uint<16>			tbuffer_state;		//tbuffer present whether using or not using.
	sc_uint<6>			router_id;			//router identification.
	sc_uint<6>			x_num;				
	sc_uint<6>			y_num;

	sc_uint<16>			control_state;

	//function decode head flit.
	char header_decoder(sc_uint<8> addr);

#ifdef ROUTER_DEBUG
	void receive_data(sc_in<bool> *data_in, sc_out<sc_uint<2> > *fifo_to_router_sel, 
					  sc_out<bool> *read_n, sc_in<sc_uint<3> > *empty, sc_uint<8> address,
					  char *debug_string, unsigned char debug_en);
	
	void transfer_data(sc_out<bool> *data_out, sc_out<sc_uint<2> > *router_to_fifo_sel,
					   sc_out<bool> *write_n, sc_in<sc_uint<3> > *full, sc_uint<8> address,
					   char *debug_string, unsigned char debug_en);
#else
	void receive_data(sc_in<bool> *data_in, sc_out<sc_uint<2> > *fifo_to_router_sel, 
					  sc_out<bool> *read_n, sc_in<sc_uint<3> > *empty, sc_uint<8> address);

	void transfer_data(sc_out<bool> *data_out, sc_out<sc_uint<2> > *router_to_fifo_sel,
					   sc_out<bool> *write_n, sc_in<sc_uint<3> > *full, sc_uint<8> address);
#endif
	char direction_decision(char dst_x, char dst_y, char router_x, char router_y);
	void oi_receive_data();
	void oi_transfer_data();

	void core_receive_data();
	void core_transfer_data();
	
	void west_receive_data();
	void west_transfer_data();

	void east_receive_data();
	void east_transfer_data();
	
	void north_receive_data();
	void north_transfer_data();
	
	void south_receive_data();
	void south_transfer_data();

	void direction_handle();

	sc_uint<16> out_direction(sc_uint<8> out_going, sc_uint<16> go_a, sc_uint<16> go_b, 
							  sc_uint<16> go_c, sc_uint<16> go_d, sc_uint<16> go_e);
	void optical_sw(sc_uint<8> ch);

};

#endif
