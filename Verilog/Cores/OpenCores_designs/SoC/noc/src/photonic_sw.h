/*
 * =====================================================================================
 *
 *       Filename:  photonic_sw.h
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  04/14/2009 02:15:17 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Soontea Kwon (), Kwonst@skku.edu
 *        Company:  Mobile Electronics Lab
 *
 * =====================================================================================
 */

#ifndef PHOTONIC_SW_H
#define PHOTONIC_SW_H

#include <iostream>
#include <systemc>
#include "define.h"
using namespace std;
using namespace sc_core;
using namespace sc_dt;

class photonic_sw : public sc_module{
public:
	sc_in<bool>			reset_n;
	sc_in<bool>			clock;

	sc_in<sc_logic>     e_oi_in;        //0.East oi input.
	sc_out<sc_logic>    e_oi_out;       //1.East oi output.
	sc_in<sc_logic>     w_oi_in;        //2.
	sc_out<sc_logic>    w_oi_out;       //3.
	sc_in<sc_logic>     s_oi_in;        //4.
	sc_out<sc_logic>    s_oi_out;       //5.
	sc_in<sc_logic>     n_oi_in;		//6.
	sc_out<sc_logic>    n_oi_out;       //7.

	sc_in<sc_logic>     c_oi_in;		//8.
	sc_out<sc_logic>    c_oi_out;		//9.
	sc_in<sc_uint<16> >  oi_control;		//10.

	SC_CTOR(photonic_sw){
		SC_THREAD(sw_control);
		sensitive << oi_control << c_oi_in << e_oi_in << w_oi_in << s_oi_in << n_oi_in 
			<< reset_n.neg() << clock.pos() << clock.neg();
	}
protected:
	void sw_control();
	
};

#endif

