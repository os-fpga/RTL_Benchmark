// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include <inttypes.h>

#include "platform.h"
#include "ndslib.h"
#include "interrupt.h"


#ifndef NDS_TIMEOUT_COUNT
#define NDS_TIMEOUT_COUNT 1000000
#endif


volatile static uint32_t pit_isr_flag = 0;
uint8_t                  checking_pid = 0;


void bus_error_handler(SAVED_CONTEXT * content) {
        if (checking_pid)
	        skip("'Programmable Interval Timer' should be configured to run this test.\n");         
        else
                exit(1);
}

static void wait_interrupt(uint32_t stage_no) {
	int i;

	for (i = 0; i < NDS_TIMEOUT_COUNT; i++) {
		if (pit_isr_flag)
			break;
	}

	if (i == NDS_TIMEOUT_COUNT) {
		exit(256 + stage_no);
	}
}


static void pit_isr(uint32_t int_no)
{
	(*intr_disable_ptr)(int_no);

	(*intr_clear_ptr)(int_no);

	DEV_PIT->INTEN = 0;
	pit_isr_flag = DEV_PIT->INTST;
	DEV_PIT->INTST = pit_isr_flag;

	(*intr_enable_ptr)(int_no);
}


int main (int argc, char** argv) {
	general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;

	uint32_t cfg;
	uint32_t channel_no;
	int i;
	volatile uint32_t *ch_ctrl_ptr;
	volatile uint32_t *ch_cnt_ptr;
        uint32_t mask;

        checking_pid = 1;
        mask = ATCPIT100_VER_ID_MASK;
        if ((DEV_PIT->IDREV & mask) != (ATCPIT100_VER_DEFAULT & mask))
	        skip("'Programmable Interval Timer' should be configured to run this test.\n");         

        checking_pid = 0;
	cfg = DEV_PIT->CFG;
	channel_no = atcpit100_channel_no(cfg);

	(*intr_setup_ptr)(INT_NO_PIT, pit_isr);
	(*intr_enable_ptr)(INT_NO_PIT);

	ch_ctrl_ptr = &(DEV_PIT->CHANNEL[0].CTRL);
	ch_cnt_ptr = &(DEV_PIT->CHANNEL[0].RELOAD);

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_14;

	for (i = 0; i < channel_no; i++) {
		*ch_ctrl_ptr = ATCPIT100_MODE_TMR32 | ATCPIT100_CLK_PCLK;
		*ch_cnt_ptr = rand() & 0x0001ffff;

		DEV_PIT->INTEN = ((uint32_t)0x1) << (i * 4);

		DEV_PIT->CHNEN = ((uint32_t)0x1) << (i * 4);

		wait_interrupt(i * 10 + 1);

		if (pit_isr_flag != (((uint32_t)0x1) << (i * 4)))
			exit(i * 10 + 1);

		DEV_PIT->CHNEN = 0;
		pit_isr_flag = 0;

		*ch_ctrl_ptr = ATCPIT100_MODE_TMR16 | ATCPIT100_CLK_PCLK;
		*ch_cnt_ptr = rand() & 0x03ff03ff;

		DEV_PIT->INTEN = ((uint32_t)0x1) << (i * 4);

		DEV_PIT->CHNEN = ((uint32_t)0x1) << (i * 4);

		wait_interrupt(i * 10 + 2);

		if (pit_isr_flag != (((uint32_t)0x1) << (i * 4)))
			exit(i * 10 + 2);

		DEV_PIT->CHNEN = 0;
		pit_isr_flag = 0;

		DEV_PIT->INTEN = ((uint32_t)0x1) << (i * 4 + 1);

		DEV_PIT->CHNEN = ((uint32_t)0x1) << (i * 4 + 1);

		wait_interrupt(i * 10 + 3);

		if (pit_isr_flag != (((uint32_t)0x1) << (i * 4 + 1)))
			exit(i * 10 + 3);

		DEV_PIT->CHNEN = 0;
		pit_isr_flag = 0;

		*ch_ctrl_ptr = ATCPIT100_MODE_TMR8 | ATCPIT100_CLK_EXTCLK;
		*ch_cnt_ptr = rand() & 0x1f1f1f1f;

		DEV_PIT->INTEN = ((uint32_t)0x1) << (i * 4);

		DEV_PIT->CHNEN = ((uint32_t)0x1) << (i * 4);

		wait_interrupt(i * 10 + 4);

		if (pit_isr_flag != (((uint32_t)0x1) << (i * 4)))
			exit(i * 10 + 4);

		DEV_PIT->CHNEN = 0;
		pit_isr_flag = 0;

		DEV_PIT->INTEN = ((uint32_t)0x1) << (i * 4 + 1);

		DEV_PIT->CHNEN = ((uint32_t)0x1) << (i * 4 + 1);

		wait_interrupt(i * 10 + 5);

		if (pit_isr_flag != (((uint32_t)0x1) << (i * 4 + 1)))
			exit(i * 10 + 5);

		DEV_PIT->CHNEN = 0;
		pit_isr_flag = 0;

		DEV_PIT->INTEN = ((uint32_t)0x1) << (i * 4 + 2);

		DEV_PIT->CHNEN = ((uint32_t)0x1) << (i * 4 + 2);

		wait_interrupt(i * 10 + 6);

		if (pit_isr_flag != (((uint32_t)0x1) << (i * 4 + 2)))
			exit(i * 10 + 6);

		DEV_PIT->CHNEN = 0;
		pit_isr_flag = 0;

		DEV_PIT->INTEN = ((uint32_t)0x1) << (i * 4 + 3);

		DEV_PIT->CHNEN = ((uint32_t)0x1) << (i * 4 + 3);

		wait_interrupt(i * 10 + 7);

		if (pit_isr_flag != (((uint32_t)0x1) << (i * 4 + 3)))
			exit(i * 10 + 7);

		DEV_PIT->CHNEN = 0;
		pit_isr_flag = 0;

		*ch_ctrl_ptr = ATCPIT100_MODE_PWM_TMR16 | ATCPIT100_CLK_PCLK;
		*ch_cnt_ptr = rand() & 0x03ff03ff;

		DEV_PIT->INTEN = ((uint32_t)0x1) << (i * 4);

		DEV_PIT->CHNEN = ((uint32_t)0x1) << (i * 4);

		wait_interrupt(i * 10 + 8);

		if (pit_isr_flag != (((uint32_t)0x1) << (i * 4)))
			exit(i * 10 + 8);

		DEV_PIT->CHNEN = 0;
		pit_isr_flag = 0;

		*ch_ctrl_ptr = ATCPIT100_MODE_PWM_TMR8 | ATCPIT100_CLK_EXTCLK;
		*ch_cnt_ptr = rand() & 0x1f1f1f1f;

		DEV_PIT->INTEN = ((uint32_t)0x1) << (i * 4);

		DEV_PIT->CHNEN = ((uint32_t)0x1) << (i * 4);

		wait_interrupt(i * 10 + 9);

		if (pit_isr_flag != (((uint32_t)0x1) << (i * 4)))
			exit(i * 10 + 9);

		DEV_PIT->CHNEN = 0;
		pit_isr_flag = 0;

		DEV_PIT->INTEN = ((uint32_t)0x1) << (i * 4 + 1);

		DEV_PIT->CHNEN = ((uint32_t)0x1) << (i * 4 + 1);

		wait_interrupt(i * 10 + 10);

		if (pit_isr_flag != (((uint32_t)0x1) << (i * 4 + 1)))
			exit(i * 10 + 10);

		DEV_PIT->CHNEN = 0;
		pit_isr_flag = 0;

		ch_ctrl_ptr += 4;
		ch_cnt_ptr += 4;
	}

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_15;

	return 0;
}

