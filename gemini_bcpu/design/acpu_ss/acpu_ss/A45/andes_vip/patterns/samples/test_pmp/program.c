#include <inttypes.h>

#include "ndslib.h"
#include "core_v5.h"
#include "interrupt.h"

#define PMP_R       0x01
#define PMP_W       0x02
#define PMP_X       0x04
#define PMP_A_OFF   0x00
#define PMP_A_TOR   0x08
#define PMP_A_NA4   0x10
#define PMP_A_NAPOT 0x18
#define PMP_L       0x80

volatile mcause;

void error_handler (SAVED_CONTEXT * context) {
        uint8_t  *except_pc;
        uint8_t  instr8;
        except_pc = read_csr(NDS_MEPC);
        instr8 = *(except_pc);
        if( (instr8 & 0x3) == 0x3)
                context->mepc = read_csr(NDS_MEPC) + 4;
        else
                context->mepc = read_csr(NDS_MEPC) + 2;
        mcause = read_csr(NDS_MCAUSE) & 0x3FF;
}

void IACCFAULT_error_handler (SAVED_CONTEXT * context) {
        context->mepc = read_csr(NDS_MEPC) + 4;
        mcause = read_csr(NDS_MCAUSE) & 0x3FF;
}

void ecall_handler (SAVED_CONTEXT * context) {
	context->mepc = read_csr(NDS_MEPC) + 4;

	long pmpaddr;
	long pmpcfg;
	long addr;

	// Test PMP entry
	write_csr(NDS_PMPADDR2, -1);
	pmpaddr = read_csr(NDS_PMPADDR2);
	if (pmpaddr == 0) {
		// Skip test if PMP entry 2 is not existed
		skip("'Number of PMP Entries' should be configured to larger than 1 to run this test.\n");
	}

	// Enable all region at PMP entry 2
	write_csr(NDS_PMPADDR2, -1);
	write_csr(NDS_PMPCFG0, 0x1f << 16);

	// Set up PMP entry 0 ~ 1
	asm volatile("la %0, memory_region" : "=r"(addr));
	addr   = addr >> 2;
	pmpcfg = (PMP_A_NAPOT | PMP_L);

	addr = (addr >> 1) << 1;
	write_csr(NDS_PMPADDR0, addr    );
	set_csr(NDS_PMPCFG0, pmpcfg);
}

int main (int argc, char** argv) {
	int *ptr;
	volatile int temp;

	// Enable handler
	general_exc_handler_tab[TRAP_M_IACCFAULT]  = IACCFAULT_error_handler;
	general_exc_handler_tab[TRAP_M_DLACCFAULT] = error_handler;
	general_exc_handler_tab[TRAP_M_DSACCFAULT] = error_handler;
	general_exc_handler_tab[TRAP_S_ECALL]      = ecall_handler;
	general_exc_handler_tab[TRAP_M_ECALL]      = ecall_handler;

	asm volatile("ecall");

	// Test load
	asm volatile("la %0, memory_region" : "=r"(ptr));
	temp = *ptr;
	if (mcause != TRAP_M_DLACCFAULT) {
		exit(1);
	}

	// Test store
	*ptr = 0;
	if (mcause != TRAP_M_DSACCFAULT) {
		exit(2);
	}

	// A memory region for PMP test
	// - support 4 to 4096 (power of 2) bytes setting of PMP_GRANULARITY
	asm volatile("j memory_region");  // skip nop codes
	asm volatile(".p2align 12");      // aligned to 4KiB
	asm volatile("memory_region:");
	asm volatile(".fill 1024, 4, 0x00000013");  // fill 4KiB nop for PMP test

	// Test fetch
	if (mcause != TRAP_M_IACCFAULT) {
		exit(3);
	}
}
