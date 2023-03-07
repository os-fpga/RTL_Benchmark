// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include <inttypes.h>

#include "platform.h"
#include "ndslib.h"
#include "interrupt.h"
#include <stdio.h>

#ifndef NDS_TIMEOUT_COUNT
#define NDS_TIMEOUT_COUNT 5000
#endif


volatile static uint32_t gpio_isr_flag = 0;
uint8_t                  checking_pid = 0;


void bus_error_handler(SAVED_CONTEXT * content) {
        if (checking_pid)
	        skip("'GPIO Controller' should be configured to run this test.\n");         
        else
                exit(1);
}

static void wait_interrupt(uint32_t stage_no) {
	int i;

	for (i = 0; i < NDS_TIMEOUT_COUNT; i++) {
		if (gpio_isr_flag)
			break;
	}

	if (i == NDS_TIMEOUT_COUNT) {
		exit(256 + stage_no);
	}
}


static void gpio_isr(uint32_t int_no)
{

	(*intr_disable_ptr)(int_no);

	(*intr_clear_ptr)(int_no);

	DEV_GPIO->INTREN = 0;
	gpio_isr_flag = DEV_GPIO->INTRSTATUS;
	DEV_GPIO->INTRSTATUS = gpio_isr_flag;

	(*intr_enable_ptr)(int_no);
}

void test_channels(uint32_t channel_no)
{
	int			i;
	uint32_t		data32;
	volatile unsigned int	*mode_ptr = &DEV_GPIO->INTRMODE0;

	*mode_ptr = 0x0;
	DEV_GPIO->INTRMODE0 = 0x0;
	DEV_GPIO->INTRMODE1 = 0x0;
	DEV_GPIO->INTRMODE2 = 0x0;
	DEV_GPIO->INTRMODE3 = 0x0;
	DEV_GPIO->INTREN = 0xffffffff;
	for (i = 0; i < 10; i++)	
		;
	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_1;
	for (i = 0; i < 10; i++)	
		;
	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_0;
	for (i = 0; i < 100; i++)	
		;
	if (gpio_isr_flag)
		exit(510);	

	for (i = 0; i < channel_no; i++) {
		mode_ptr = &DEV_GPIO->INTRMODE0 + (i / 8);

		data32 = ATCGPIO100_INTR_MODE_HIGH_LEVEL << ((i % 8) * 4);
		*mode_ptr = data32;
		DEV_GPIO->INTREN = ((uint32_t)0x1) << i;

		DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_1;
		wait_interrupt(1);

		if (gpio_isr_flag != (((uint32_t)0x1) << i))
			exit(8 * i + 1);

		gpio_isr_flag = 0;

		data32 = ATCGPIO100_INTR_MODE_LOW_LEVEL << ((i % 8) * 4);
		*mode_ptr = data32;
		DEV_GPIO->INTREN = ((uint32_t)0x1) << i;

		DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_0;
		wait_interrupt(2);

		if (gpio_isr_flag != (((uint32_t)0x1) << i))
			exit(8 * i + 2);

		gpio_isr_flag = 0;

		data32 = ATCGPIO100_INTR_MODE_RISING_EDGE << ((i % 8) * 4);
		*mode_ptr = data32;
		DEV_GPIO->INTREN = ((uint32_t)0x1) << i;

		DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_1;
		wait_interrupt(3);

		if (gpio_isr_flag != (((uint32_t)0x1) << i))
			exit(8 * i + 3);

		gpio_isr_flag = 0;

		data32 = ATCGPIO100_INTR_MODE_FALLING_EDGE << ((i % 8) * 4);
		*mode_ptr = data32;
		DEV_GPIO->INTREN = ((uint32_t)0x1) << i;

		DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_0;
		wait_interrupt(4);

		if (gpio_isr_flag != (((uint32_t)0x1) << i))
			exit(8 * i + 4);

		gpio_isr_flag = 0;

		data32 = ATCGPIO100_INTR_MODE_DUAL_EDGE << ((i % 8) * 4);
		*mode_ptr = data32;

		DEV_GPIO->INTREN = ((uint32_t)0x1) << i;
		DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_1;
		wait_interrupt(5);

		if (gpio_isr_flag != (((uint32_t)0x1) << i))
			exit(8 * i + 5);

		gpio_isr_flag = 0;

		DEV_GPIO->INTREN = ((uint32_t)0x1) << i;
		DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_0;
		wait_interrupt(6);

		if (gpio_isr_flag != (((uint32_t)0x1) << i))
			exit(8 * i + 6);

		gpio_isr_flag = 0;

	}
}

int main (int argc, char** argv) {
	general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;

	uint32_t cfg;
	uint32_t channel_no;
        uint32_t mask;

	DEV_SMU->PINMUX_CTRL0 = SET_SMU_PINMUX_CTRL0_ORCA;
	DEV_SMU->PINMUX_CTRL1 = SET_SMU_PINMUX_CTRL1_ORCA;

        checking_pid = 1;
        mask = ATCGPIO100_IDREV_ID_MASK;
        if ((DEV_GPIO->IDREV & mask) != (ATCGPIO100_IDREV_DEFAULT & mask))
	        skip("'GPIO Controller' should be configured to run this test.\n");         

        checking_pid = 0;
	cfg = DEV_GPIO->CFG;

	if ((cfg & ATCGPIO100_CFG_INTR_SUPPORT) == 0)
		skip("Macro `ATCGPIO100_INTR_SUPPORT should be defined in atcgpio100_config.vh to enable the GPIO interrupt option to run this test.\n");

	(*intr_setup_ptr)(INT_NO_GPIO, gpio_isr);
	(*intr_enable_ptr)(INT_NO_GPIO);

	DEV_SIM_CONTROL->TEMP5 = 0;
	channel_no = atcgpio100_channel_no(cfg);
	DEV_SIM_CONTROL->TEMP6 = channel_no;


	if (cfg & ATCGPIO100_CFG_DEBOUNCE_SUPPORT) {
		DEV_GPIO->DEBOUNCECTRL = rand() & 0x3;
		DEV_GPIO->DEBOUNCEEN = rand();
	}

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_0;

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_14;

	test_channels(channel_no);

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_15;


	if (cfg & ATCGPIO100_CFG_DEBOUNCE_SUPPORT) {
		DEV_GPIO->DEBOUNCECTRL = (rand() & 0xff) | (1 << 31);
		DEV_GPIO->DEBOUNCEEN = rand();
	}

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_0;

	test_channels(channel_no);

	return 0;
}

