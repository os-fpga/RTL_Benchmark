// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include <inttypes.h>

#include "platform.h"
#include "ndslib.h"
#include "interrupt.h"

void bus_error_handler(SAVED_CONTEXT * content) {
	skip("'APB Bridge' should be configured to run this test.\n");
}

void default_value_test() {
	uint32_t i;
	uint32_t mask;

	mask = ATCAPBBRG100_VER_ID_MASK;
	if ((DEV_APBBRG->IDREV & mask) != (ATCAPBBRG100_VER_DEFAULT & mask))
		exit(0x1);

	for (i = 0; i < 4; i++) {
		if (DEV_APBBRG->RESERVED0[i] != 0)
			exit(0x2+i);
	}

	if (DEV_APBBRG->CTRL != ATCAPBBRG100_CR_DEFAULT)
		exit(0x7);

	if (DEV_APBBRG->RESERVED1[0] != 0)
		exit(0x8);

	if (DEV_APBBRG->RESERVED1[1] != 0)
		exit(0x9);

	for (i = 1; i <=31; i++) {
		DEV_SIM_CONTROL->TEMP6 = i;
		DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_2;
		while (DEV_SIM_CONTROL->TEMP6 != 0x99);	

		if (DEV_SIM_CONTROL->TEMP7 != DEV_APBBRG->SLV[i-1])
			exit(0x100+i);
	}

}

void reg_rw_test() {
	uint32_t temp;
	uint32_t rdata;
	uint32_t i;
	uint32_t mask;


	temp = rand();
	mask = ATCAPBBRG100_VER_ID_MASK;
	DEV_APBBRG->IDREV = temp;
	if ((DEV_APBBRG->IDREV & mask) != (ATCAPBBRG100_VER_DEFAULT & mask)) exit(0x41);

	for (i = 0; i < 4; i++) {
		DEV_APBBRG->RESERVED0[i] = temp;
		if (DEV_APBBRG->RESERVED0[i] != 0)
			exit(0x42+i);
	}

	temp = rand();
	DEV_APBBRG->CTRL = temp;
	if (DEV_APBBRG->CTRL != (ATCAPBBRG100_CR_WBUF_EN_MASK & temp))
		exit(0x47);

	for (i = 0; i < 1; i++) {
		DEV_APBBRG->RESERVED1[i] = temp;
		if (DEV_APBBRG->RESERVED1[i] != 0)
			exit(0x48+i);
	}

	temp = rand();
	for (i = 0; i < 31; i++) {
		rdata = DEV_APBBRG->SLV[i];
		DEV_APBBRG->SLV[i] = temp;
		if (DEV_APBBRG->SLV[i] != rdata) exit(0x49 + i);
	}

}

int main (int argc, char** argv) {
	general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;
	uint32_t mask;

	mask = ATCAPBBRG100_VER_ID_MASK;

	if ((DEV_APBBRG->IDREV & mask) != (ATCAPBBRG100_VER_DEFAULT & mask))
		skip("'APB Bridge' should be configured to run this test.\n");

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_14;

	default_value_test();

	reg_rw_test();

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_15;

	return 0;
}

