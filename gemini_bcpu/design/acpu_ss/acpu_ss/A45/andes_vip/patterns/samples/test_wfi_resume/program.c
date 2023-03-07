// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include <inttypes.h>

#include "platform.h"
#include "ndslib.h"
#include "interrupt.h"

#ifndef NDS_TIMEOUT_COUNT
#define NDS_TIMEOUT_COUNT 1000
#endif

#ifndef NDS_RESUME_MIN
#define NDS_RESUME_MIN 50
#endif


volatile static uint32_t pit_isr_flag = 0;
uint8_t                  checking_pid = 0;

void bus_error_handler(SAVED_CONTEXT * content) {
        if (checking_pid)
                skip("'Programmable Interval Timer' should be configured to provide a wakeup event source to run this test.\n");         
        else
                exit(1);
}

static void pit_isr(uint32_t int_no)
{
	(*intr_disable_ptr)(int_no);
	DEV_PIT->INTEN = 0x0;

	(*intr_clear_ptr)(int_no);

	pit_isr_flag = DEV_PIT->INTST;
	DEV_PIT->INTST = pit_isr_flag;

	(*intr_enable_ptr)(int_no);
}


int main (int argc, char** argv) {
	uint32_t tmp32;
	uint32_t exit_code = 1;
	uint32_t mask;

        general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
        general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;

	(*intr_setup_ptr)(INT_NO_PIT, pit_isr);
	(*intr_enable_ptr)(INT_NO_PIT);
	
        checking_pid = 1;
        mask = ATCPIT100_VER_ID_MASK;
        if ((DEV_PIT->IDREV & mask) != (ATCPIT100_VER_DEFAULT & mask))
                skip("'Programmable Interval Timer' should be configured to provide a wakeup event source to run this test.\n");         

	checking_pid = 0;
	DEV_PIT->CHANNEL[0].CTRL = ATCPIT100_MODE_TMR16 | ATCPIT100_CLK_PCLK;
	tmp32 = rand();
	DEV_PIT->CHANNEL[0].RELOAD = NDS_RESUME_MIN + (tmp32 & 0xff);
	DEV_PIT->INTEN = 0x1;
	DEV_PIT->CHNEN = 0x1;

	DEV_SMU->CRR = SMU_CRR_CCLKSEL_DIV2 | SMU_CRR_HPCLKSEL_1_1;

	__asm__ __volatile__ ("wfi");

	if (pit_isr_flag == 0x1)
		exit_code = 0;

	return exit_code;
}

