// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include <inttypes.h>

#include "platform.h"
#include "ndslib.h"
#include "interrupt.h"

#define MAX_WAIT_CNT    1000000

volatile uint32_t	uart_isr_flag = 0;
volatile uint32_t	uart_isr_sts = 0;
volatile uint32_t	uart_isr_rxd = 0;
volatile uint32_t	uart_isr_lsr = 0;
uint8_t                 checking_pid = 0;

void bus_error_handler(SAVED_CONTEXT * content) {
        if (checking_pid)
	        skip("'UART1/UART2' should be configured to run this test.\n");         
        else
                exit(1);
}

void uart_wait_int(void) {
	uint32_t wait_cnt = 0;

	while (wait_cnt++ <= MAX_WAIT_CNT && uart_isr_flag == 0);

	if (uart_isr_flag == 0) {
		exit(0xccc9);
	}
	uart_isr_flag = 0;
}

void uart_isr(uint32_t int_no)
{
	ATCUART100_RegDef * dev_p = 0;

	intr_disable_ptr(int_no);

	if (int_no == INT_NO_UART1)
		dev_p = (ATCUART100_RegDef *)DEV_UART1;
	else if (int_no == INT_NO_UART2)
		dev_p = (ATCUART100_RegDef *)DEV_UART2;

	if (dev_p != 0) {		
		uart_isr_sts = dev_p->IIR & ATCUART100_IIR_B3B0_MASK;
		if (uart_isr_sts == ATCUART100_IIR_RD_READY) {
			uart_isr_flag |= 1;
			uart_isr_lsr = dev_p->LSR;
			uart_isr_rxd = dev_p->RBR;
		}
	}

	intr_clear_ptr(int_no);

	intr_enable_ptr(int_no);
}

void set_baudrate(ATCUART100_RegDef * dev_p, int divisor, int oversample)
{
	dev_p->OSCR = oversample;

	dev_p->LCR = 0x80; 
	dev_p->DLM = divisor >> 8; 
	dev_p->DLL= divisor & 0xff;
	dev_p->LCR = 0x0; 
}

void tx_rx_test()
{
	uint32_t lcr_rand;
	uint32_t bit_mask;
	uint32_t gold_data;
	uint32_t divisor_rand;
	uint32_t oversample_rand;

	lcr_rand = rand() & 0x3f;
	bit_mask = (0x1 << ((lcr_rand & 0x3) + 5)) -1;
	gold_data = rand() & 0xff;
	divisor_rand = (rand() & 0xff) + 1;	
	oversample_rand = rand() & 0x1f;

	ATCUART100_RegDef * dev1_p = (ATCUART100_RegDef *)DEV_UART1;
	ATCUART100_RegDef * dev2_p = (ATCUART100_RegDef *)DEV_UART2;

	set_baudrate(dev1_p, divisor_rand, oversample_rand);
	set_baudrate(dev2_p, divisor_rand, oversample_rand);

	dev1_p->LCR = lcr_rand;
	dev2_p->LCR = lcr_rand;
	dev1_p->IER = ATCUART100_PREPARE(IER, RAI, 0x1);
	dev2_p->IER = ATCUART100_PREPARE(IER, RAI, 0x1);

	uart_isr_flag = 0;
	dev1_p->RBR = gold_data; 
	uart_wait_int();

	if (uart_isr_sts != ATCUART100_IIR_RD_READY) exit(0xa1); 
	if (uart_isr_rxd != (gold_data & bit_mask)) exit(0xa3); 
	if (!(uart_isr_lsr & ATCUART100_LSR_DR_MASK)) exit(0xa2); 

	gold_data = (~gold_data) & 0xff;

	dev2_p->RBR = gold_data; 
	uart_wait_int();
	if (uart_isr_sts != ATCUART100_IIR_RD_READY) exit(0xb1); 
	if (uart_isr_rxd != (gold_data & bit_mask)) exit(0xb3); 
	if (!(uart_isr_lsr & ATCUART100_LSR_DR_MASK)) exit(0xb2); 

}

void cts_rts_test() {
	ATCUART100_RegDef * dev1_p = (ATCUART100_RegDef *)DEV_UART1;
	ATCUART100_RegDef * dev2_p = (ATCUART100_RegDef *)DEV_UART2;

	if (dev1_p->MSR != 0) {
		exit(0xd1);
	}
	if (dev2_p->MSR != 0) {
		exit(0xd2);
	}

	dev2_p->MCR = ATCUART100_PREPARE(MCR, RTS, 0x1);
	dev1_p->MCR = ATCUART100_PREPARE(MCR, RTS, 0x1);
	if (dev1_p->MSR != 0x11) {
		exit(0xd3);
	}
	if (dev2_p->MSR != 0x11) {
		exit(0xd4);
	}

	dev2_p->MCR = dev2_p->MCR ^ ATCUART100_PREPARE(MCR, RTS, 0x1);
	dev1_p->MCR = dev1_p->MCR ^ ATCUART100_PREPARE(MCR, RTS, 0x1);
	if (dev1_p->MSR != 0x01) {
		exit(0xd5);
	}
	if (dev2_p->MSR != 0x01) {
		exit(0xd6);
	}
}

int main (int argc, char** argv)
{
	general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;

        uint32_t mask;

        checking_pid = 1;
        mask = ATCUART100_IDREV_ID_MASK;
        if (((DEV_UART1->IDREV & mask) != (ATCUART100_IDREV_DEFAULT & mask)) || ((DEV_UART2->IDREV & mask) != (ATCUART100_IDREV_DEFAULT & mask)))
	        skip("'UART1/UART2' should be configured to run this test.\n");         

        checking_pid = 0;
	(*intr_setup_ptr)(INT_NO_UART1, uart_isr);
	(*intr_setup_ptr)(INT_NO_UART2, uart_isr);
	intr_enable_ptr(INT_NO_UART1);
	intr_enable_ptr(INT_NO_UART2);

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_14;

	tx_rx_test();

	cts_rts_test();

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_15;

	return 0;
}

