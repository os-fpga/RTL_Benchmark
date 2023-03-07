#include <inttypes.h>

#include "ndslib.h"
#include "core_v5.h"
#include "interrupt.h"

#if __riscv_xlen == 64
	#define ROTATE_LEN 64
#else
	#define ROTATE_LEN 32
#endif

#ifndef NDS_MIN_ILM_SIZE
	#define NDS_MIN_ILM_SIZE 0x6000
#endif

long micm_cfg;
long milmb;
long ilm_size;

void ecall_handler(SAVED_CONTEXT * context) {
	context->mepc = read_csr(NDS_MEPC) + 4;

	// Read MICM_CFG
	micm_cfg = read_csr(NDS_MICM_CFG);

	// Ignore the testing in case of no ILM or ILM size small than program size
	ilm_size = (0x200 << ((micm_cfg >> 15) & 0x1f)) / sizeof(long);
	if (ilm_size < (NDS_MIN_ILM_SIZE / sizeof(long))) {
		skip("The size of ILM should be larger than or equal to 24 KiB to run this test.\n");
	}

	// Enable ILM
	set_csr(NDS_MILMB, 0x1);

	// Read MILMB
	milmb = read_csr(NDS_MILMB);

	// Turn on the ECC if exist
	if (((micm_cfg >> 21) & 0x3) != 0) {
		milmb |= 0x4;
		write_csr(NDS_MILMB, milmb);
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

	// Test address base
	base = ((milmb >> 10) << 10) + NDS_MIN_ILM_SIZE;

	asm  volatile ("lm_write_1:");
	test = data1;
	for (offset = 1; offset < ilm_size; offset = offset << 2) {
		test = rotr(test);
		*(base + offset) = test;
	}

	asm  volatile ("lm_read_1:");
	golden =  data1;
	for (offset = 1; offset < ilm_size; offset = offset << 2) {
		golden =  rotr(golden);
		test = *(base + offset);
		if (golden != test) {
			exit(1);
		}
	}

	asm  volatile ("lm_write_2:");
	test = data2;
	for (offset = (ilm_size >> 1); offset > 0; offset = offset >> 2) {
		test = rotr(test);
		*(base + offset) = test;
	}

	asm  volatile ("lm_read_2:");
	golden =  data2;
	for (offset = (ilm_size >> 1); offset > 0; offset = offset >> 2) {
		golden = rotr(golden);
		test = *(base + offset);
		if (golden != test) {
			exit(1);
		}
	}
}
