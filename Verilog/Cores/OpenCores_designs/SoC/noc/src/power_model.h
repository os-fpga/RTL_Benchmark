/*
 * =====================================================================================
 *
 *       Filename:  power_model.h
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  04/14/2009 12:24:02 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Soontea Kwon (), Kwonst@skku.edu
 *        Company:  Mobile Electronics Lab
 *
 * =====================================================================================
 */

#ifndef POWER_MODEL_H
#define POWER_MODEL_H

#include <iostream>
using namespace std;

#define EI_POWER				ei_energy += 0.98e-3
#define TRANSMITTER_OI_POWER	oi_energy += 0.9e-3
#define RECEIVER_OI_ENERGY		oi_energy += 0.5e-3

#define EI_DELAY				ei_delay += 31.19e-12
#define TRANSMITTER_OI_DELAY	oi_delay += 77.3e-12
#define RECEIVER_OI_DELAY		oi_delay += 36.5e-12

void Energy_disp(void);

#endif
