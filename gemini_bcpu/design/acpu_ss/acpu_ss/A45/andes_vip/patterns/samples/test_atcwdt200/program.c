// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include <inttypes.h>

#include "ndslib.h"
#include "rand.h"

#include "platform.h"
#include "interrupt.h"

uint8_t  checking_pid = 0;

void bus_error_handler(SAVED_CONTEXT * content) {
        if (checking_pid)
	        skip("'Watchdog Timer' should be configured to run this test.\n");         
        else
                exit(1);
}

void reg_default()
{
	int i;

	if (DEV_WDT->CTRL != ATCWDT200_CTRL_DEFAULT)
		exit(0x01);

	if (DEV_WDT->ST != ATCWDT200_ST_DEFAULT)
		exit(0x02);

	for (i = 0; i < 3; i++)
		if (DEV_WDT->RESERVED[i] != 0)
			exit(0x03);

}

void reg_rw()
{
	uint32_t rand_base;
	uint32_t mask;

	rand_base = rand();
	DEV_WDT->IDREV = rand_base;
	mask = ATCWDT200_IDREV_ID_MASK;
	if ((DEV_WDT->IDREV & mask) != (ATCWDT200_IDREV_DEFAULT & mask))
		exit(0x11);

	rand_base = rand();
	rand_base = rand_base & (
			ATCWDT200_CTRL_RSTTIME_MASK | 					
			ATCWDT200_CTRL_RSTEN_MASK   | ATCWDT200_CTRL_INTEN_MASK |
			ATCWDT200_CTRL_CLK_MASK     | ATCWDT200_CTRL_EN_MASK);
	DEV_WDT->CTRL = rand_base;
	if (DEV_WDT->CTRL != ATCWDT200_CTRL_DEFAULT) 
		exit(0x12);
	DEV_WDT->WEN = ATCWDT200_WP_NUM;	
	rand_base = rand_base & 0xFFFFFFFE;
	DEV_WDT->CTRL = rand_base;
	if (DEV_WDT->CTRL != rand_base) 
		exit(0x13);

	DEV_WDT->WEN = ATCWDT200_WP_NUM; 
	DEV_WDT->CTRL = ATCWDT200_CTRL_DEFAULT;	
	DEV_WDT->CTRL = rand_base;
	if (DEV_WDT->CTRL != ATCWDT200_CTRL_DEFAULT) 
		exit(0x14);


}


int main(int argc, char** argv)
{
	general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;

        uint32_t mask;

        checking_pid = 1;
        mask = ATCWDT200_IDREV_ID_MASK;
        if ((DEV_WDT->IDREV & mask) != (ATCWDT200_IDREV_DEFAULT & mask))
                skip("'Watchdog Timer' should be configured to run this test.\n");

        checking_pid = 0;
	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_14;

	reg_default();

	reg_rw();

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_15;

	return 0;
}
