
#include "platform.h"
#include "ndslib.h"
#include "interrupt.h"

#include <stdio.h>
#include <inttypes.h>

#ifndef NDS_TEST_TIMEOUT
#define NDS_TEST_TIMEOUT	1000000
#endif

uint8_t  checking_pid = 0;
uint32_t ctr_mask;
volatile uint32_t int_status = 0;

void bus_error_handler(SAVED_CONTEXT * content) {
        if (checking_pid)
	        skip("'Real-Time Clock' should be configured to run this test.\n");         // skip when this IP is not exist.
        else
                exit(1);
}

static uint32_t rand_counter(void) {
	uint32_t ctr;
	uint32_t day;
	uint32_t hour;
	uint32_t min;
	uint32_t sec;
	uint32_t tmp;

	tmp = rand();

	// Trim the second field to range 58~59
	sec = tmp & 0x1;
	sec += 58;
	tmp >>= 1;

	// Set the minute field to 59
	min = 59;

	// Set the hour field to 23
	hour = 23;

	// Set the day field to a random value
	day = tmp;

	ctr = (day << 17) | (hour << 12) | (min << 6) | sec;
	ctr &= ctr_mask;

	return (ctr);
}


void rtc_isr(uint32_t int_no) {
	uint32_t this_status;

	// disable the interrupt
	(*intr_disable_ptr)(int_no);

	this_status = DEV_RTC->STATUS;

#ifdef NDS_DEBUG
	printf("RTC interrupt with status = 0x%02x\n", this_status);
#endif

	int_status |= this_status;
	DEV_RTC->STATUS = this_status;

	// clear the interrupt
	(*intr_clear_ptr)(int_no);

	// enable the interrupt
	(*intr_enable_ptr)(int_no);
}


int main(int argc, char *argv[]) {
	general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;

	uint32_t prev_counter;
	volatile int i;
        uint32_t mask;

        checking_pid = 1;
        mask = ATCRTC100_IDREV_ID_MASK;
        if ((DEV_RTC->IDREV & mask) != (ATCRTC100_IDREV_ID_DEFAULT & mask))
	        skip("'Real-Time Clock' should be configured to run this test.\n");         // skip when this IP is not exist.

        checking_pid = 0;
	(*intr_setup_ptr)(INT_NO_RTC, rtc_isr);
	(*intr_enable_ptr)(INT_NO_RTC);

	// Get the counter width
	DEV_RTC->CNTR = 0xffffffff;
	ctr_mask = DEV_RTC->CNTR;

	prev_counter = rand_counter();

	i = 0;
	while (!(DEV_RTC->STATUS & 0x10000) && (++i < NDS_TEST_TIMEOUT));
	if (i >= NDS_TEST_TIMEOUT) {
		printf("Test aborted with timeout count = %d.\n", NDS_TEST_TIMEOUT);
		return 1;
	}

	DEV_RTC->CNTR = prev_counter;

#ifdef NDS_DEBUG
	printf("Counter is set to 0x%08x\n", prev_counter);
#endif

	// Enable RTC and interrupts
	DEV_RTC->CTRL = 0xf9;

	for (i = 0; i < NDS_TEST_TIMEOUT; i++)
		if ((int_status & 0x78) == 0x78) {
			break;
		}

	if (i == NDS_TEST_TIMEOUT) {
		printf("Test aborted with timeout count = %d.\n", NDS_TEST_TIMEOUT);
		return 1;
	}

	return 0;
}
