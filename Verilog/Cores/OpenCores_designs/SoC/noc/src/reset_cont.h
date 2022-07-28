/*
 * =====================================================================================
 *
 *       Filename:  reset_cont.h
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  04/09/2009 06:41:10 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Soontea Kwon (), Kwonst@skku.edu
 *        Company:  Mobile Electronics Lab
 *
 * =====================================================================================
 */
#ifndef RESET_CONT_H
#define RESET_CONT_H

#include <systemc>
#include <iostream>
using namespace sc_core;
using namespace std;

class reset : public sc_module{
public:
	sc_out<bool>	reset_n;
	sc_in<bool>		clk;

	SC_CTOR(reset){
		SC_THREAD(reset_handle);
	}
protected:
	void reset_handle(){
		reset_n.write(false);
		wait(20,SC_NS);
		reset_n.write(true);
		wait(20,SC_NS);
	}
};

#endif

