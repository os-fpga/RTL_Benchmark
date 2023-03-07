// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include <stdio.h>
#include <stdarg.h>
#include <inttypes.h>

#include "platform.h"
#include "core_v5.h"
#include "interrupt.h"

nds_interrupt_handler_p intr_handler_tab[INTERRUPT_NO];
nds_interrupt_handler_p nmi_handler_tab[NMI_NO];
nds_exception_handler_p general_exc_handler_tab[GENERAL_EXC_NO];

extern char _start[];

extern int main();
extern void ae350_init(void);
static inline void select_hart(void);

volatile int ae350_mpbootup_done __attribute__((section(".sharedata"))) = 0;

void __attribute__((naked, no_execit, no_profile_instrument_function, section(".loader"))) boot_loader(void) {
#ifdef __LP64__
        __asm__ __volatile__ ("ld t0, start_address\n"
			      "jr t0\n"
			      ".p2align 3\n"
			      "start_address: .dword _start\n" ::: "t0");
#else
        __asm__ __volatile__ ("lw t0, start_address\n"
			      "jr t0\n"
			      ".p2align 2\n"
			      "start_address: .word _start\n" ::: "t0");
#endif

	__builtin_unreachable();
}

static inline void __attribute__((noreturn)) wait_sync_inline() {
	while (!ae350_mpbootup_done) ;

	__asm__ __volatile__ ("la t0, reset_handler");
	__asm__ __volatile__ ("jr t0");
}

static inline void __attribute__((noreturn)) exit_inline(int status) {
	if (status == SUCCESS) {
		DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_PASSED;
	}
	else {
		DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_FAILED;
	}
	while(1) {
		__asm__ __volatile__ ("wfi");
	}
}

void exit(int status) {
	exit_inline(status);
}

void skip(const char *fmt, ...) {
	va_list va;

	va_start(va, fmt);
	vprintf(fmt, va);
	va_end(va);

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_SKIPPED;
	while(1);
}

static void go_to_main(void) {
	int ret = main();
	exit(ret);
}

void __platform_init(void) {
	int ilm_size;
	int dlm_size;

        if (check_l2c_exist()) {
                wait_l2c_init();
                set_csr(NDS_MCACHE_CTL, MCACHE_CTL_DC_COHEN);
	        while((read_csr(NDS_MCACHE_CTL) & MCACHE_CTL_DC_COHSTA) == 0x0);
        }

	if (!(DUALCORE_RUN || ALLCORE_RUN)) {
		ilm_size = (read_csr(NDS_MICM_CFG) >> 15) & 0x1f;
		if (ilm_size != 0) {
			set_csr(NDS_MILMB, 0x1);
		}
		dlm_size = (read_csr(NDS_MDCM_CFG) >> 15) & 0x1f;
		if (dlm_size != 0) {
			set_csr(NDS_MDLMB, 0x1);
		}
	}

	select_hart();
}

void reset_handler(void) {
	volatile int run_id = 0;

	run_id = read_csr(NDS_MHARTID);

	ae350_init();

	if ((ALLCORE_RUN || DUALCORE_RUN) && (run_id == NDS_AE350_RUN_ID)) {
		ae350_mpbootup_done = 1;
	}

	write_csr(NDS_MEPC, (uintptr_t) go_to_main);
	__asm__ __volatile__ ("mret");
}

void __attribute__((naked)) nmi_handler() {
	register long x1  asm("x1");
	register long x4  asm("x4");
	register long x5  asm("x5");
	register long x6  asm("x6");
	register long x7  asm("x7");
	register long x10 asm("x10");
	register long x11 asm("x11");
	register long x12 asm("x12");
	register long x13 asm("x13");
	register long x14 asm("x14");
	register long x15 asm("x15");
#ifndef __riscv_32e
	register long x16 asm("x16");
	register long x17 asm("x17");
	register long x28 asm("x28");
	register long x29 asm("x29");
	register long x30 asm("x30");
	register long x31 asm("x31");
#endif
	__asm__ __volatile__ ("addi sp, sp, %0" :: "i"(-34*REGBYTES));
	register long * volatile addr asm("sp");
	*(addr + 1)  = x1;
	*(addr + 4)  = x4;
	*(addr + 5)  = x5;
	*(addr + 6)  = x6;
	*(addr + 7)  = x7;
	*(addr + 10) = x10;
	*(addr + 11) = x11;
	*(addr + 12) = x12;
	*(addr + 13) = x13;
	*(addr + 14) = x14;
	*(addr + 15) = x15;
#ifndef __riscv_32e
	*(addr + 16) = x16;
	*(addr + 17) = x17;
	*(addr + 28) = x28;
	*(addr + 29) = x29;
	*(addr + 30) = x30;
	*(addr + 31) = x31;
#endif

	if (DEV_WDT->ST) {
		nmi_handler_tab[NMI_NO_WDT](NMI_NO_WDT);
	}
	else {
		exit(FAIL);
	}

	x1  = *(addr + 1);
	x4  = *(addr + 4);
	x5  = *(addr + 5);
	x6  = *(addr + 6);
	x7  = *(addr + 7);
	x10 = *(addr + 10);
	x11 = *(addr + 11);
	x12 = *(addr + 12);
	x13 = *(addr + 13);
	x14 = *(addr + 14);
	x15 = *(addr + 15);
#ifndef __riscv_32e
	x16 = *(addr + 16);
	x17 = *(addr + 17);
	x28 = *(addr + 28);
	x29 = *(addr + 29);
	x30 = *(addr + 30);
	x31 = *(addr + 31);
#endif
	__asm__ __volatile__ ("addi sp, sp, %0" :: "i"(34*REGBYTES));
	__asm__ __volatile__ ("mret" :: "r"(x1),
	                                "r"(x4),
	                                "r"(x5),
	                                "r"(x6),
	                                "r"(x7),
#ifndef __riscv_32e
	                                "r"(x16),
	                                "r"(x17),
	                                "r"(x28),
	                                "r"(x29),
	                                "r"(x30),
	                                "r"(x31),
#endif
	                                "r"(x10),
	                                "r"(x11),
	                                "r"(x12),
	                                "r"(x13),
	                                "r"(x14),
	                                "r"(x15)
	                     );
}

void supervisor_ei_handler() {
	int int_id;
        
	int_id = DEV_PLIC->TARGET_ATTR[NDS_AE350_PLIC_STGT].CLAIM_COMP;
        if (int_id == 0) return ;
	intr_handler_tab[int_id](int_id);
	DEV_PLIC->TARGET_ATTR[NDS_AE350_PLIC_STGT].CLAIM_COMP = int_id;
}


void machine_ei_handler(int int_id) {
        if (int_id == 0) return ;
	intr_handler_tab[int_id](int_id);

#ifdef NDS_AE350_MULTI_HART
        unsigned int hart_id = read_csr(NDS_MHARTID);
	DEV_PLIC->TARGET_ATTR[2*hart_id].CLAIM_COMP = int_id;
#else
	__nds__plic_complete_interrupt(int_id);
#endif
}

__attribute__((weak)) void mswi_handler(void) {
        clear_csr(NDS_MIE, MIP_MSIP);
}

__attribute__((weak)) void mti_handler(void) {
        clear_csr(NDS_MIE, MIP_MTIP);
}

void bus_write_error_li_handler(SAVED_CONTEXT *context) {
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR](context);
}

void trap_handler(unsigned long cause, SAVED_CONTEXT *context) {
	if ((cause & MCAUSE_INT) && ((cause & MCAUSE_CAUSE) == IRQ_S_EXT)) 
		{
		supervisor_ei_handler();
	}
	else if ((cause & MCAUSE_INT) && ((cause & MCAUSE_CAUSE) == IRQ_M_EXT)) {
#ifdef NDS_AE350_MULTI_HART
                unsigned int hart_id = read_csr(NDS_MHARTID);
        	machine_ei_handler(DEV_PLIC->TARGET_ATTR[2*hart_id].CLAIM_COMP);
#else
		machine_ei_handler(__nds__plic_claim_interrupt());
#endif
	}
	else if ((cause & MCAUSE_INT) && ((cause & MCAUSE_CAUSE) == IRQ_M_SOFT)) {
		mswi_handler();
	}
	else if ((cause & MCAUSE_INT) && ((cause & MCAUSE_CAUSE) == IRQ_M_TIMER)) {
		mti_handler();
	}
	else if ((cause & MCAUSE_INT) && (((cause & MCAUSE_CAUSE) == IRQ_BWE) || ((cause & MCAUSE_CAUSE) == (IRQ_BWE + 256)))) {
		bus_write_error_li_handler(context);
	}
	else if (!(cause & MCAUSE_INT) && ((cause & MCAUSE_CAUSE) < GENERAL_EXC_NO)) {
		if (general_exc_handler_tab[cause] == 0) {
			exit(FAIL);
		}
		else {
			general_exc_handler_tab[cause](context);
		}
	}
	else {
		exit(FAIL);
	}
}

static inline void select_hart(void) {
	int smu_rst_reg = 0;
	volatile int run_id = 0;

	run_id = read_csr(NDS_MHARTID);

	if (DUALCORE_RUN || ALLCORE_RUN) {
		if (DUALCORE_RUN && (run_id > 1)) {
			exit_inline(SUCCESS); 
		}
		if (run_id > 0) {
			wait_sync_inline();
		}
	}
	else {
		if ((NDS_AE350_RUN_ID != 0) && (run_id == 0)) {
			smu_rst_reg = DEV_SMU->HARTS_RESET_REG;
			DEV_SMU->HARTS_RESET_REG = (smu_rst_reg | (1 << NDS_AE350_RUN_ID));
		
			exit_inline(SUCCESS); 
		}
		if (NDS_AE350_RUN_ID != run_id) {
			exit_inline(SUCCESS);
		}
	}
}
