#include <inttypes.h>

#include "ndslib.h"
#include "core_v5.h"
#include "interrupt.h"

#if __riscv_xlen == 64
	#define ROTATE_LEN 64
#else
	#define ROTATE_LEN 32
#endif

#ifndef NDS_MIN_DLM_SIZE
	#define NDS_MIN_DLM_SIZE 0x100
#endif

long mdlmb;
long mdcm_cfg;
long dlm_size;

void ecall_handler(SAVED_CONTEXT * context) {
	context->mepc = read_csr(NDS_MEPC) + 4;

	// Read MDCM_CFG
	mdcm_cfg = read_csr(NDS_MDCM_CFG);

	// Ignore the testing in case of no DLM
	if (((mdcm_cfg >> 15) & 0x1f) != 0) {
		dlm_size = (0x200 << ((mdcm_cfg >> 15) & 0x1f)) / sizeof(long);
	}
	else {
		skip("Size of DLM should be larger than 0 KiB to run this test.\n");
	}

	// Enable DLM
	set_csr(NDS_MDLMB, 0x1);

	// Read MDLMB
	mdlmb = read_csr(NDS_MDLMB);

	// Turn on the ECC if exist
	if (((mdcm_cfg >> 21) & 0x3) != 0) {
		mdlmb |= 0x4;
		write_csr(NDS_MDLMB, mdlmb);
	}

}

long rotr(long num) {
	long result;
	result = (num >> 1) | (num << (ROTATE_LEN - 1));
	return result;
}

int main (int argc, char** argv) {

	// Set ECALL handler
	general_exc_handler_tab[TRAP_U_ECALL] = ecall_handler;
	general_exc_handler_tab[TRAP_S_ECALL] = ecall_handler;
	general_exc_handler_tab[TRAP_M_ECALL] = ecall_handler;

	asm volatile("ecall");

	long *base;
	long offset;
	long golden, test;
	long data1	= 0x5a5a5a5a;
	long data2	= 0x12345678;

	base = ((mdlmb >> 10) << 10) + NDS_MIN_DLM_SIZE;

	asm  volatile ("lm_write_1:");
	test = data1;
	for (offset = 1; offset < dlm_size; offset = offset << 2) {
		test = rotr(test);
		*(base + offset) = test;
	}

	asm  volatile ("lm_read_1:");
	golden =  data1;
	for (offset = 1; offset < dlm_size; offset = offset << 2) {
		golden =  rotr(golden);
		test = *(base + offset);
		if (golden != test) {
			exit(1);
		}
	}

	asm  volatile ("lm_write_2:");
	test = data2;
	for (offset = (dlm_size >> 1); offset > 0; offset = offset >> 2) {
		test = rotr(test);
		*(base + offset) = test;
	}

	asm  volatile ("lm_read_2:");
	golden =  data2;
	for (offset = (dlm_size >> 1); offset > 0; offset = offset >> 2) {
		golden = rotr(golden);
		test = *(base + offset);
		if (golden != test) {
			exit(1);
		}
	}
}



