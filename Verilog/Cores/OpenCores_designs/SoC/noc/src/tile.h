/*
 * =====================================================================================
 *
 *       Filename:  tile.h
 *
 *    Description:  fifo test bench header file
 *
 *        Version:  1.0
 *        Created:  03/25/2009 11:26:55 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Soontea Kwon (), Kwonst@skku.edu
 *        Company:  Mobile Electronics Lab
 *
 * =====================================================================================
 */
#ifndef TILE_H
#define TILE_H

#include <systemc>
#include "fifo.h"
#include "core.h"
#include "router.h"
#include "photonic_sw.h"
using namespace sc_core;
using namespace sc_dt;
using namespace std;

class tile: public sc_module{
public:
	sc_in<bool>					clk;					//0.
	sc_in<bool>					reset_n;				//1.
	//Data.
	sc_signal<bool>				data_fifo_to_router;	//transfer data from fifo to router.
	sc_signal<bool>				data_router_to_fifo;	//transfer data from router to fifo.
	sc_signal<bool>				data_fifo_to_core;		//transfer data from fifo to core.
	sc_signal<bool>				data_core_to_fifo;		//transfer data from core to fifo.
	//write_n.
	sc_signal<bool>				core_to_fifo_write_n;		//Output data control pin a.
	sc_signal<bool>				router_to_fifo_write_n;		//Output data control pin a.
	
	//read_n.
	sc_signal<bool>				core_to_fifo_read_n;		//Input data control pin.
	sc_signal<bool>				router_to_fifo_read_n;		//Input data control pin.
	
	//select signal.
	sc_signal<sc_uint<2> >		wcore_to_fifo_sel;			//to read data to fifo between core and fifo.
	sc_signal<sc_uint<2> >		wfifo_to_core_sel;			//to write data to fifo between core and fifo.
	sc_signal<sc_uint<2> >		wfifo_to_router_sel;		//to read data to fifo between fifo and router.
	sc_signal<sc_uint<2> >		wrouter_to_fifo_sel;		//to write data to fifo between fifo and router.

	//empty & full signal.
	sc_signal<sc_uint<3> >		core_empty;					//State of FIFO is full.
	sc_signal<sc_uint<3> >		core_full;					//State of FIFO is empty.
	sc_signal<sc_uint<3> >		router_empty;				//State of FIFO is full.
	sc_signal<sc_uint<3> >		router_full;				//State of FIFO is empty.
	
	//West signal.
	sc_out<bool>				w_data_out;					//2
	sc_in<bool>					w_data_in;					//3
	sc_out<bool>				w_out_write_n;				//4.
	sc_in<bool>					w_in_write_n;				//5
	sc_out<sc_uint<3> >			w_out_full;					//6.
	sc_in<sc_uint<3> >			w_in_full;					//7.
	sc_out<sc_uint<2> >			w_out_sel;					//8.
	sc_in<sc_uint<2> >			w_in_sel;					//9.
	
	sc_signal<bool>				w_fifo_to_router_data;	//west fifo to router data.
	sc_signal<sc_uint<2> >				w_fifo_to_router_sel;   //west select signal.
	sc_signal<bool>				w_read_n;				//left input data control pin.
	sc_signal<sc_uint<3> >		w_empty;				//State of FIFO is full.
	//East signal.
	sc_out<bool>				e_data_out;					//10.
	sc_in<bool>					e_data_in;					//11.
	sc_out<bool>				e_out_write_n;				//12.
	sc_in<bool>					e_in_write_n;				//13.
	sc_out<sc_uint<3> >			e_out_full;					//14.
	sc_in<sc_uint<3> >			e_in_full;					//15.
	sc_out<sc_uint<2> >			e_out_sel;					//16.
	sc_in<sc_uint<2> >			e_in_sel;					//17.
	
	sc_signal<bool>				e_fifo_to_router_data;	//west fifo to router data.
	sc_signal<sc_uint<2> >				e_fifo_to_router_sel;   //west select signal.
	sc_signal<bool>				e_read_n;				//left input data control pin.
	sc_signal<sc_uint<3> >		e_empty;				//State of FIFO is full.

	//North signal.
	sc_out<bool>				n_data_out;					//18.
	sc_in<bool>					n_data_in;					//19.
	sc_out<bool>				n_out_write_n;				//20.
	sc_in<bool>					n_in_write_n;				//21.
	sc_out<sc_uint<3> >			n_out_full;					//22.
	sc_in<sc_uint<3> >			n_in_full;					//23.
	sc_out<sc_uint<2> >			n_out_sel;					//24.
	sc_in<sc_uint<2> >			n_in_sel;					//25.
	
	sc_signal<bool>				n_fifo_to_router_data;	//west fifo to router data.
	sc_signal<sc_uint<2> >		n_fifo_to_router_sel;   //west select signal.
	sc_signal<bool>				n_read_n;				//left input data control pin.
	sc_signal<sc_uint<3> >		n_empty;				//State of FIFO is full.
	
	//South signal.
	sc_out<bool>				s_data_out;					//26.
	sc_in<bool>					s_data_in;					//27.
	sc_out<bool>				s_out_write_n;				//28.
	sc_in<bool>					s_in_write_n;				//29.
	sc_out<sc_uint<3> >			s_out_full;					//30.
	sc_in<sc_uint<3> >			s_in_full;					//31.
	sc_out<sc_uint<2> >			s_out_sel;					//32.
	sc_in<sc_uint<2> >			s_in_sel;					//32.
	
	sc_signal<bool>				s_fifo_to_router_data;	//west fifo to router data.
	sc_signal<sc_uint<2> >		s_fifo_to_router_sel;   //west select signal.
	sc_signal<bool>				s_read_n;				//left input data control pin.
	sc_signal<sc_uint<3> >		s_empty;				//State of FIFO is full.

	sc_in<sc_logic>		e_oi_in;							//33.East oi input.
	sc_out<sc_logic>	e_oi_out;							//34.East oi output.
	sc_in<sc_logic>		w_oi_in;							//35.
	sc_out<sc_logic>	w_oi_out;							//36.
	sc_in<sc_logic>		s_oi_in;							//37.
	sc_out<sc_logic>	s_oi_out;							//38.
	sc_in<sc_logic>		n_oi_in;							//39.
	sc_out<sc_logic>	n_oi_out;							//41.

	sc_signal<sc_logic>		c_oi_in;
	sc_signal<sc_logic>		c_oi_out;
	sc_signal<sc_uint<16> >	oi_control;

	core *ip_core;
	virtual_fifo *core_to_router_fifo;
	virtual_fifo *router_to_core_fifo;

	virtual_fifo *north_fifo;
	virtual_fifo *south_fifo;
	virtual_fifo *east_fifo;
	virtual_fifo *west_fifo;

	router *router_fabric;
	photonic_sw *ph_sw;

	SC_HAS_PROCESS(router);

	tile(sc_module_name nm, int id, int column_num, int row_num):sc_module(nm){
		ip_core = new core("ip_core",id,column_num,row_num);
		core_to_router_fifo = new virtual_fifo("core_to_router_fifo");
		router_to_core_fifo = new virtual_fifo("router_to_core_fifo");
		router_fabric = new router("router_fabric",id,column_num,row_num);
		
		north_fifo = new virtual_fifo("north_fifo");
		south_fifo = new virtual_fifo("south_fifo");
		east_fifo = new virtual_fifo("east_fifo");
		west_fifo = new virtual_fifo("west_fifo");

		ph_sw = new photonic_sw("ph_sw");

		ip_core->clk(clk);
		ip_core->reset_n(reset_n);
		router_fabric->clk(clk);
		router_fabric->reset_n(reset_n);
		ph_sw->clock(clk);
		ph_sw->reset_n(reset_n);
		
		//router optical interconnects.
		router_fabric->c_oi_in(c_oi_in);
		router_fabric->c_oi_out(c_oi_out);
		router_fabric->oi_control(oi_control);
		ph_sw->e_oi_in(e_oi_in);
		ph_sw->e_oi_out(e_oi_out);
		ph_sw->w_oi_in(w_oi_in);
		ph_sw->w_oi_out(w_oi_out);
		ph_sw->s_oi_in(s_oi_in);
		ph_sw->s_oi_out(s_oi_out);
		ph_sw->n_oi_in(n_oi_in);
		ph_sw->n_oi_out(n_oi_out);
		ph_sw->c_oi_in(c_oi_out);
		ph_sw->c_oi_out(c_oi_in);
		ph_sw->oi_control(oi_control);


		//core data -> fifo -> router.
		ip_core->data_out(data_core_to_fifo);
		core_to_router_fifo->data_in(data_core_to_fifo);
		core_to_router_fifo->data_out(data_fifo_to_router);
		router_fabric->c_data_in(data_fifo_to_router);
		//core data <- fifo <- router.
		ip_core->data_in(data_fifo_to_core);
		router_to_core_fifo->data_out(data_fifo_to_core);
		router_to_core_fifo->data_in(data_router_to_fifo);
		router_fabric->c_data_out(data_router_to_fifo);
		//select signal : core->fifo->router.
		ip_core->core_to_fifo_sel(wcore_to_fifo_sel);
		core_to_router_fifo->x_to_fifo_sel(wcore_to_fifo_sel);
		core_to_router_fifo->fifo_to_x_sel(wfifo_to_router_sel);
		router_fabric->c_fifo_to_router_sel(wfifo_to_router_sel);
		//select signal : router->fifo->core.
		router_fabric->c_router_to_fifo_sel(wrouter_to_fifo_sel);
		router_to_core_fifo->x_to_fifo_sel(wrouter_to_fifo_sel);
		router_to_core_fifo->fifo_to_x_sel(wfifo_to_core_sel);
		ip_core->fifo_to_core_sel(wfifo_to_core_sel);
		//core write_n -> fifo write_n | fifo read_n -> router read_n.
		ip_core->write_n(core_to_fifo_write_n);
		core_to_router_fifo->write_n(core_to_fifo_write_n);
		core_to_router_fifo->read_n(router_to_fifo_read_n);
		router_fabric->c_read_n(router_to_fifo_read_n);
		//router write_n -> fifo write_n | fifo read_n -> core write_n.
		router_fabric->c_write_n(router_to_fifo_write_n);
		router_to_core_fifo->write_n(router_to_fifo_write_n);
		router_to_core_fifo->read_n(core_to_fifo_read_n);
		ip_core->read_n(core_to_fifo_read_n);
		//core & router full signal.
		ip_core->full(core_full);
		core_to_router_fifo->full(core_full);
		router_fabric->c_full(router_full);
		router_to_core_fifo->full(router_full);
		//core & router empty signal.
		ip_core->empty(core_empty);
		router_to_core_fifo->empty(core_empty);
		core_to_router_fifo->empty(router_empty);
		router_fabric->c_empty(router_empty);

		//West
		west_fifo->data_out(w_fifo_to_router_data);					//Fifo->router data.
		router_fabric->w_data_in(w_fifo_to_router_data);			//Fifo->router data.
		router_fabric->w_fifo_to_router_sel(w_fifo_to_router_sel);  //fifo select signal.
		west_fifo->fifo_to_x_sel(w_fifo_to_router_sel);	
		router_fabric->w_read_n(w_read_n);							//left input data control pin.
		west_fifo->read_n(w_read_n);
		router_fabric->w_empty(w_empty);							//State of FIFO is full.
		west_fifo->empty(w_empty);

		west_fifo->data_in(w_data_in);								//input data.
		west_fifo->full(w_out_full);
		west_fifo->write_n(w_in_write_n);
		west_fifo->x_to_fifo_sel(w_in_sel);

		router_fabric->w_data_out(w_data_out);						//Tile data_out.
		router_fabric->w_router_to_fifo_sel(w_out_sel);				//west select signal.
		router_fabric->w_write_n(w_out_write_n);					//left output data control pin.
		router_fabric->w_full(w_in_full);							//State of FIFO is empty.
		
		//east
		east_fifo->data_out(e_fifo_to_router_data);					//Fifo->router data.
		router_fabric->e_data_in(e_fifo_to_router_data);			//Fifo->router data.
		router_fabric->e_fifo_to_router_sel(e_fifo_to_router_sel);  //fifo select signal.
		east_fifo->fifo_to_x_sel(e_fifo_to_router_sel);	
		router_fabric->e_read_n(e_read_n);							//left input data control pin.
		east_fifo->read_n(e_read_n);
		router_fabric->e_empty(e_empty);							//State of FIFO is full.
		east_fifo->empty(e_empty);

		east_fifo->data_in(e_data_in);								//input data.
		east_fifo->full(e_out_full);
		east_fifo->write_n(e_in_write_n);
		east_fifo->x_to_fifo_sel(e_in_sel);

		router_fabric->e_router_to_fifo_sel(e_out_sel);				//west select signal.
		router_fabric->e_write_n(e_out_write_n);					//left output data control pin.
		router_fabric->e_data_out(e_data_out);						//Tile data_out.
		router_fabric->e_full(e_in_full);							//State of FIFO is empty.

		//north
		north_fifo->data_out(n_fifo_to_router_data);					//Fifo->router data.
		router_fabric->n_data_in(n_fifo_to_router_data);			//Fifo->router data.
		router_fabric->n_fifo_to_router_sel(n_fifo_to_router_sel);  //fifo select signal.
		north_fifo->fifo_to_x_sel(n_fifo_to_router_sel);	
		router_fabric->n_read_n(n_read_n);							//left input data control pin.
		north_fifo->read_n(n_read_n);
		router_fabric->n_empty(n_empty);							//State of FIFO is full.
		north_fifo->empty(n_empty);

		north_fifo->data_in(n_data_in);								//input data.
		north_fifo->full(n_out_full);
		north_fifo->write_n(n_in_write_n);
		north_fifo->x_to_fifo_sel(n_in_sel);

		router_fabric->n_router_to_fifo_sel(n_out_sel);				//west select signal.
		router_fabric->n_write_n(n_out_write_n);					//left output data control pin.
		router_fabric->n_data_out(n_data_out);						//Tile data_out.
		router_fabric->n_full(n_in_full);							//State of FIFO is empty.
		
		//south
		south_fifo->data_out(s_fifo_to_router_data);					//Fifo->router data.
		router_fabric->s_data_in(s_fifo_to_router_data);			//Fifo->router data.
		router_fabric->s_fifo_to_router_sel(s_fifo_to_router_sel);  //fifo select signal.
		south_fifo->fifo_to_x_sel(s_fifo_to_router_sel);	
		router_fabric->s_read_n(s_read_n);							//left input data control pin.
		south_fifo->read_n(s_read_n);
		router_fabric->s_empty(s_empty);							//State of FIFO is full.
		south_fifo->empty(s_empty);

		south_fifo->data_in(s_data_in);								//input data.
		south_fifo->full(s_out_full);
		south_fifo->write_n(s_in_write_n);
		south_fifo->x_to_fifo_sel(s_in_sel);

		router_fabric->s_data_out(s_data_out);						//Tile data_out.
		router_fabric->s_router_to_fifo_sel(s_out_sel);				//west select signal.
		router_fabric->s_write_n(s_out_write_n);					//left output data control pin.
		router_fabric->s_full(s_in_full);							//State of FIFO is empty.
	}
};

#endif
