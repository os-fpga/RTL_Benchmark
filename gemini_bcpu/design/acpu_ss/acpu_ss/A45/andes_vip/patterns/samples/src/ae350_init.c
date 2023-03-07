// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include <inttypes.h>

#include "platform.h"
#include "core_v5.h"
#include "ndslib.h"
#include "interrupt.h"

#ifndef HEAP_SIZE
#define HEAP_SIZE 0x2000
#endif

extern char _stack[];

uintptr_t dmac_addr_offset;

static void soc_init(void) {
	DEV_SMU->CER = 0x7ff;
}

void default_general_exc_handler(SAVED_CONTEXT *context) {
	exit(FAIL);
}

static void setup_interrupt(uint32_t intr_no, nds_interrupt_handler_p isr) {
	intr_handler_tab[intr_no] = isr;
}

void backup_intr_handler_tab() {
	uintptr_t *ptr = (uintptr_t *) INTR_BACKUP_BASE;
	for (int i=0; i < INTERRUPT_NO; i++) {
		*ptr = (uintptr_t) intr_handler_tab[i];
		ptr++;
	}

	__asm__ __volatile__ ("fence.i");

	uint32_t l2c_exist = (DEV_SMU->SYSTEMCFG >> 8) & 0x1;
	if (l2c_exist) {
	uint32_t l2c_cache_size = (DEV_L2C->CONFIG >> 7) & 0x1f;
		if (l2c_cache_size != 0) {
			DEV_L2C->M0_CCTL_CMD = 0b10010 ; 
			do {

			} while(DEV_L2C->CCTL_ST != 0x0);
		}
	}
}

void restore_intr_handler_tab() {
	uintptr_t * ptr = (uintptr_t *) INTR_BACKUP_BASE;
	for (int i=0; i < INTERRUPT_NO; i++) {
		intr_handler_tab[i] = (nds_interrupt_handler_p) *ptr;
		ptr++;
	}
}

static void enable_s_interrupt(uint32_t intr_no) {
	__nds__plic_set_priority(intr_no, 1);

	DEV_PLIC->TARGET_EN[NDS_AE350_PLIC_MTGT].INT_EN[0] &= 0x0;
	DEV_PLIC->TARGET_EN[NDS_AE350_PLIC_STGT].INT_EN[0] |= (1 << (intr_no & 0x1F));
}

static void enable_interrupt(uint32_t intr_no) {
#ifdef NDS_AE350_MULTI_HART
	__nds__plic_set_priority(intr_no, 1);
	DEV_PLIC->TARGET_EN[NDS_AE350_PLIC_MTGT].INT_EN[0] |= (1 << (intr_no & 0x1F));
	DEV_PLIC->TARGET_EN[NDS_AE350_PLIC_STGT].INT_EN[0] &= 0x0;
#else
	__nds__plic_set_priority(intr_no, 1);
	__nds__plic_enable_interrupt(intr_no);
#endif

}

static void disable_s_interrupt(uint32_t intr_no) {
	__nds__plic_set_priority(intr_no, 0);
}

static void disable_interrupt(uint32_t intr_no) {
	__nds__plic_set_priority(intr_no, 0);
}

static void clear_interrupt(uint32_t intr_no) {
}

void ae350_init(void) {
	int mmsc_cfg, misa_reg;
	int i;
	void *heap_base;
	int dlm_size;
	uintptr_t dlm_base;
        int run_id;

	run_id = read_csr(NDS_MHARTID);

	set_csr(NDS_MSTATUS, MSTATUS_MPIE);

	set_csr(NDS_MIE, (1 << IRQ_M_EXT) | (1 << IRQ_BWE) | (1 << IRQ_S_EXT));

	misa_reg = read_csr(NDS_MISA);
	misa_reg &= 0x00040000;
	mmsc_cfg = read_csr(NDS_MMSC_CFG);
	if (misa_reg == 0x0) {
		if (mmsc_cfg & 0x1000) {
			__nds__plic_set_feature(NDS_PLIC_FEATURE_VECTORED); 
		}
	}
	else {
		set_csr(NDS_SIE, (1 << IRQ_S_EXT));
		set_csr(0x9c4, (1 << IRQ_BWE));
		set_csr(NDS_MSTATUS, MSTATUS_SIE);
	        set_csr(NDS_SSTATUS, SSTATUS_SPIE);
		clear_csr(NDS_MSTATUS, MSTATUS_MPP);
		set_csr(NDS_MSTATUS, MSTATUS_SM);
	        set_csr(NDS_PMPADDR0, -1);
		set_csr(NDS_PMPCFG0, 0x1F);
	}

	if ( !(DUALCORE_RUN || ALLCORE_RUN) || (run_id == 0) ) {
		heap_base = _stack;

		heap_init(heap_base, HEAP_SIZE);

		dlm_size = (read_csr(NDS_MDCM_CFG) >> 15) & 0x1f;
		if ((dlm_size >= 6) && (mmsc_cfg & 0x4000)) {
			dlm_size = 1 << (dlm_size - 1 + 10);
			dlm_base = (read_csr(NDS_MDLMB) >> 10) << 10;
			if (((uintptr_t)heap_base >= dlm_base) && ((uintptr_t)heap_base < (dlm_base + dlm_size))) {
				dmac_addr_offset = (uintptr_t) (SLVPORT_DLM_BASE + (2 * run_id * (SLVPORT_DLM_BASE - SLVPORT_BASE)) - dlm_base);
			}
		}

		if (misa_reg == 0x0) {
		        intr_enable_ptr = enable_interrupt;
			intr_disable_ptr = disable_interrupt;
		}
		else {
			intr_enable_ptr = enable_s_interrupt;
			intr_disable_ptr = disable_s_interrupt;
		}

		intr_setup_ptr = setup_interrupt;
		intr_clear_ptr = clear_interrupt;

		for (i = 0; i < GENERAL_EXC_NO; i++) {
			general_exc_handler_tab[i] = default_general_exc_handler;
		}

		if(DEV_SMU->PCS[3].PCS_SCRATCH == 0xb) {
			restore_intr_handler_tab();
		}

		soc_init();
	}

}

