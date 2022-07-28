/*
 * =====================================================================================
 *
 *       Filename:  photonic_sw.cc
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  04/14/2009 02:20:24 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Soontea Kwon (), Kwonst@skku.edu
 *        Company:  Mobile Electronics Lab
 *
 * =====================================================================================
 */

#include "photonic_sw.h"

void photonic_sw :: sw_control()
{
	sc_uint<16> contr_temp = 0;
	unsigned short temp = 0;

	while(true){
		if(!reset_n.read()){
			
		}
		else{ 
			contr_temp = oi_control.read();
			temp = contr_temp;
			if(contr_temp & EAST_TO_CORE){
				c_oi_out.write(e_oi_in.read());
			}
			else if(contr_temp & EAST_TO_SOUTH){
				s_oi_out.write(e_oi_in.read());
			}
			else if(contr_temp & EAST_TO_NORTH){
				n_oi_out.write(e_oi_in.read());
			}
			else if(!(contr_temp & (SOUTH_TO_WEST|NORTH_TO_WEST|CORE_TO_WEST))){
				w_oi_out.write(e_oi_in.read());
			}
			
			if(contr_temp & WEST_TO_CORE){
				c_oi_out.write(w_oi_in.read());
			}
			else if(contr_temp & WEST_TO_SOUTH){
				s_oi_out.write(w_oi_in.read());
			}
			else if(contr_temp & WEST_TO_NORTH){
				n_oi_out.write(w_oi_in.read());
			}
			else if(!(contr_temp &(SOUTH_TO_EAST|NORTH_TO_EAST|CORE_TO_EAST))){
				e_oi_out.write(w_oi_in.read());
			}
			
			if(contr_temp & SOUTH_TO_CORE){
				c_oi_out.write(s_oi_in.read());
			}
			else if(contr_temp & SOUTH_TO_EAST){
				e_oi_out.write(s_oi_in.read());
			}
			else if(contr_temp & SOUTH_TO_WEST){
				w_oi_out.write(s_oi_in.read());
			}
			else if(!(contr_temp & (EAST_TO_NORTH|WEST_TO_NORTH|CORE_TO_NORTH))){
				n_oi_out.write(s_oi_in.read());
			}
			
			if(contr_temp & NORTH_TO_CORE){
				c_oi_out.write(n_oi_in.read());
			}
			else if(contr_temp & NORTH_TO_EAST){
				e_oi_out.write(n_oi_in.read());
			}
			else if(contr_temp & NORTH_TO_WEST){
				w_oi_out.write(n_oi_in.read());
			}
			else if(!(contr_temp & (EAST_TO_SOUTH|WEST_TO_SOUTH|CORE_TO_SOUTH))){
				s_oi_out.write(n_oi_in.read());
			}

			if(contr_temp & CORE_TO_EAST){
				e_oi_out.write(c_oi_in.read());
			}
			else if(contr_temp & CORE_TO_WEST){
				w_oi_out.write(c_oi_in.read());
			}
			else if(contr_temp & CORE_TO_SOUTH){
				s_oi_out.write(c_oi_in.read());
			}
			else if(contr_temp & CORE_TO_NORTH){
				n_oi_out.write(c_oi_in.read());
			}
		}
		wait();
	}
}
