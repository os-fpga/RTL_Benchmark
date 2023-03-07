#include <inttypes.h>

#include "ndslib.h"
#include "core_v5.h"
#include "interrupt.h"

volatile unsigned long test_data[8192]           __attribute__((section(".sharedata"))) = {0};
volatile unsigned long test_start_addr;
unsigned long isz;
unsigned long dsz;

void ecall_handler(SAVED_CONTEXT * context) {
	context->mepc = read_csr(NDS_MEPC) + 4;

	unsigned long micm_cfg	= read_csr(NDS_MICM_CFG);
	unsigned long mdcm_cfg	= read_csr(NDS_MDCM_CFG);
		      isz	= ((micm_cfg >> 6) & 0x7);  //icache line size
		      dsz	= ((mdcm_cfg >> 6) & 0x7);

	// Ignore  testing in case of no Icache or Dcache
	if ((isz == 0) && (dsz == 0)) {
                skip("I-Cache or D-Cache should be configured to run this test, and their sizes should be larger than 0 KiB.\n");
	}

	// Turn on Icache and Dcache
	if (isz != 0) {
		set_csr(NDS_MCACHE_CTL,1);
	}
	if (dsz != 0) {
		set_csr(NDS_MCACHE_CTL,2);
	}

	test_start_addr = (unsigned long) test_data;
}

int main (int argc, char** argv) {

	// Set ECALL handler
	general_exc_handler_tab[TRAP_U_ECALL] = ecall_handler;
	general_exc_handler_tab[TRAP_S_ECALL] = ecall_handler;
	general_exc_handler_tab[TRAP_M_ECALL] = ecall_handler;

	asm volatile("ecall");

	int i, j;
	unsigned long offset;

	unsigned long data_pat    = 0xf1f11ff1;
	unsigned long data_1;
	unsigned long data_2;

	unsigned long ret_insn    = 0x00008067;// jr ra
	unsigned long abort_insn  = 0x00000000;// illegal instrution
	unsigned long *ptr;

	// Save RA
	volatile int save_ra;
	asm volatile("mv %0, ra" : "=r"(save_ra));

	// Test D-Cache
	if (dsz != 0) {
		offset	= (8*1024/8);	
		ptr 	= (unsigned long*) test_start_addr;
		data_1  = *ptr;
		ptr    -= offset;

	// Store data
		for(i = 0;i < 8; i++) {
			ptr    += offset;
			data_1 += data_pat;
			*ptr    = data_1;
		}
	// Check data
		ptr 	= (unsigned long*)test_start_addr;
		data_2  = *ptr;
		ptr    -= offset;
		for(i = 0;i < 8; i++) {
			ptr    += offset;
			data_1  = *ptr;
			if((data_1 ^ data_2) != 0) {
				exit(1);
			}
			data_2 += data_pat;
		}
	}
	// Test I-Cache
	if (isz != 0) {
	// Store instruction
		offset	= (8*1024/8);
		ptr 	= (unsigned long*)test_start_addr;
		ptr    -= offset;
		for(i = 0;i < 8; i++) {
			ptr    += offset;
			*ptr = ret_insn;
        	        for(j = 0;j < 8; j++) {
                	        ptr += 1;
                        	*ptr = abort_insn;
	                }
			ptr = (ptr - 8);
		}
		asm volatile ("fence.i");	// Write-back all data in caches

	// Load instruction
		ptr 	= (unsigned long*)test_start_addr;
		ptr    -= offset;
		for(i = 0;i < 8; i++) {
			ptr += offset;
			asm volatile ("jalr %0" :: "r"(ptr));
		}
	}

	// Restore RA
	asm volatile("mv ra, %0" : "=r"(save_ra));
}


