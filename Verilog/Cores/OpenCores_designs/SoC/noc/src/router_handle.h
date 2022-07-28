/*
 * =====================================================================================
 *
 *       Filename:  router_handle.cc
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  04/02/2009 12:35:32 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Soontea Kwon (), Kwonst@skku.edu
 *        Company:  Mobile Electronics Lab
 *
 * =====================================================================================
 */
#ifndef ROUTER_HANDLE_H
#define ROUTER_HANDLE_H

#include <systemc>
using namespace sc_core;
using namespace sc_dt;
using namespace std;

class router_handle : public sc_module{
public:
	sc_in<bool>	clk;
	sc_in<bool> reset_n;

	sc_inout<sc_uint<16> c_data;
	sc_inout<sc_uint<16> w_data;
	sc_inout<sc_uint<16> e_data;
	sc_inout<sc_uint<16> n_data;
	sc_inout<sc_uint<16> s_data;
	
	SC_CTOR(router_handle){
		SC_THREAD(handle);
		sensitive << clk.pos();
	}

	void handle();
}
#endif
