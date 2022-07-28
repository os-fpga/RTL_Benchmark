/*
 * =====================================================================================
 *
 *       Filename:  power_model.cc
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  04/14/2009 12:24:57 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Soontea Kwon (), Kwonst@skku.edu
 *        Company:  Mobile Electronics Lab
 *
 * =====================================================================================
 */

#include "power_model.h"

extern double ei_energy;
extern double oi_energy;
extern double ei_delay;
extern double oi_delay;

void Energy_disp(void)
{
	cout << endl;
	cout << "----------------------------------------------------------" << endl;
  	cout << "Consumption Energy of NoC" << endl;
	cout << "Energy of electrical interconnects: " << ei_energy << endl;
	cout << "Energy of optical interconnects   : " << oi_energy << endl;;
	cout << "total energy                      : " << ei_energy + oi_energy << endl;
	cout << "Delay of electrical interconnects : " << ei_delay << endl;
	cout << "Delay of optical interconnects    : " << oi_delay << endl;
	cout << "Toal Delay                        : " << ei_delay + oi_delay << endl;
}
