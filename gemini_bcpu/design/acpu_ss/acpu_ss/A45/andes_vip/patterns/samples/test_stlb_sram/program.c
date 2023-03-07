#include <inttypes.h>
#include <stdint.h>
#include <string.h>

#include "ndslib.h"
#include "core_v5.h"
#include "interrupt.h"

/* Note: macros below should not be modified */
/* ISA base related macros */
#if     __riscv_xlen == 64
#define MAX_PA_BIT      56
#define LEVEL_PPN_BIT   9
#define SATP_MODE       SATP64_MODE
#define SATP_ASID       SATP64_ASID
#define SATP_PPN        SATP64_PPN
#define SATP_MODE_LSB   60 
#define SATP_ASID_LSB   44
#define SATP_PPN_LSB    0
#define MAX_PAGE_TABLE_LEVELS 4
typedef uint64_t UINT;
typedef int64_t  INT;
#else   //__riscv_xlen == 32
#define MAX_PA_BIT                              34
#define LEVEL_PPN_BIT                           10
#define SATP_MODE       SATP32_MODE
#define SATP_ASID       SATP32_ASID
#define SATP_PPN        SATP32_PPN
#define SATP_MODE_LSB   31 
#define SATP_ASID_LSB   22
#define SATP_PPN_LSB    0
#define MAX_PAGE_TABLE_LEVELS 2
typedef uint32_t UINT;
typedef int32_t  INT;
#endif
#define MISA_S          (1UL << 18)
typedef uint32_t INSTR;

/* PRIV related macros */
#define PRIV_M          3
#define PRIV_S          1
#define PRIV_U          0
#define MSTATUS_MPP_LSB 11

/* MMU scheme related macros */
#define PTE_PPN_BIT             (MAX_PA_BIT - 12)
#define INPAGE_PTE_COUNT        (1 << LEVEL_PPN_BIT)

#define PAGE_4K         0
#define PAGE_MEGA       1
#define PAGE_GIGA       2
#define PAGE_TERA       3

#define PTE_ATTR_D      0x80
#define PTE_ATTR_A      0x40
#define PTE_ATTR_G      0x20
#define PTE_ATTR_U      0x10
#define PTE_ATTR_X      0x08
#define PTE_ATTR_W      0x04
#define PTE_ATTR_R      0x02
#define PTE_ATTR_V      0x01

#define ITDT_ON(mode, asid, ppn)        write_csr(NDS_SATP, \
                                                (((UINT)mode << SATP_MODE_LSB) & SATP_MODE) |\
                                                (((UINT)asid << SATP_ASID_LSB) & SATP_ASID) |\
                                                (((UINT)ppn  << SATP_PPN_LSB)  & SATP_PPN));

#define ITDT_OFF()                      write_csr(NDS_SATP, \
                                                (((UINT)SATP_MODE_OFF << SATP_MODE_LSB) & SATP_MODE));

#define P2ALIGN(x, n)                   (((x) + n - 1) & ~(n - 1))
#define DBG_PRINT(fmt, args...)

/* Memory region settings */
#define MEM_REGION_BASE_PA                      (P2ALIGN((UINT)__sharedata_start, 4096))
#define MEM_REGION_SIZE                         (6 * 0x1000)    // 6 pages

/* Address mappings */
#define PAGE_TABLE_BASE_PA                      MEM_REGION_BASE_PA + 0x0000

#define SIM_CONTROL_BASE_VA                     ((uintptr_t)DEV_SIM_CONTROL)
#define SIM_CONTROL_BASE_PA                     ((uintptr_t)DEV_SIM_CONTROL)
#define SIM_CONTROL_SIZE                        0x00002000UL
#define SIM_CONTROL_OFFSET                      SIM_CONTROL_BASE_PA - SIM_CONTROL_BASE_VA // PA - VA

///* Test regions */
#define DATA_REGION_BASE_VA                     MEM_REGION_BASE_PA + 0x500
#define DATA_REGION_BASE_PA                     MEM_REGION_BASE_PA + 0x500
#define DATA_REGION_SIZE                        0x00800000UL
#define DATA_REGION_OFFSET                      DATA_REGION_BASE_PA - DATA_REGION_BASE_VA // PA - VA


typedef struct {
        UINT attrib     : 10;
        UINT ppn        : PTE_PPN_BIT;
} pte_entry_t;

typedef struct {
        pte_entry_t pte_entry[INPAGE_PTE_COUNT] __attribute__ ((aligned(0x1000)));
} pte_page_t;

typedef enum {BARE=0, SV32=1, SV39=8, SV48=9} mmu_scheme_e;

extern unsigned char __executable_start[];      // Map to __TEXT_BASE in ld script
extern unsigned char _stack[];                  // Map to _stack in ld script
extern unsigned char __sharedata_start[];              // Map to _sharedata in ld script

pte_page_t* g_pg_tables;
pte_page_t* g_pg_alloc_ptr;

static const mmu_scheme_e test_schemes[4] = {SV48, SV39, SV32, BARE};
mmu_scheme_e g_test_scheme;

void page_alloc(mmu_scheme_e scheme, pte_page_t* ppg, UINT va, UINT pa, UINT pg_rlevel, UINT attrib) {
        UINT            vpn[MAX_PAGE_TABLE_LEVELS];
        UINT            ppn;
        UINT            pg_table_level;
        UINT            alloc_level;
        UINT            vpn_level;
        UINT            pte_level;
        pte_entry_t*    ppte;
        UINT            _vpn;

        switch (scheme) {
                case (SV32): pg_table_level = 2; break;
                case (SV39): pg_table_level = 3; break;
                case (SV48): pg_table_level = 4; break;
                default:     pg_table_level = 0;
        }

        alloc_level = pg_table_level - pg_rlevel;

        // Calculate VPN/PPN
        for (vpn_level = 0, _vpn = va >> 12; vpn_level < pg_table_level; ++vpn_level, _vpn/=INPAGE_PTE_COUNT) {
                vpn[pg_table_level-vpn_level-1] = _vpn % INPAGE_PTE_COUNT;
        }
        ppn = (pa >> 12) & ~((1UL << (LEVEL_PPN_BIT * pg_rlevel)) - 1UL);

        // Traverse PTEs
        for (pte_level = 0; pte_level < alloc_level; ++pte_level) {
                ppte = &(ppg->pte_entry[vpn[pte_level]]);
                if (pte_level == alloc_level - 1) { // leaf PTE
                        if (ppte->attrib & PTE_ATTR_V) { // valid PTE
                                ppte->attrib |= attrib;
                        } else { // invalid PTE
                                ppte->ppn = ppn;
                                ppte->attrib = attrib | PTE_ATTR_V;
                        }
                } else { // non-leaf PTE
                        if (ppte->attrib & PTE_ATTR_V) { // valid PTE
                                ppg = (pte_page_t*)((UINT)(ppte->ppn) << 12);
                        } else { // invalid PTE
                                memset((char*)g_pg_alloc_ptr, 0, sizeof(pte_page_t));
                                ppte->ppn = (UINT)(g_pg_alloc_ptr) >> 12;
                                ppte->attrib = PTE_ATTR_V;
                                ppg = (g_pg_alloc_ptr++);
                        }
                }
        }
	/* SFENCE.VMA */
	asm("SFENCE.VMA\n\t");
}

void ecall_handler(SAVED_CONTEXT * context) {

        UINT i;

        // skip pattern when S-mode is not supported
        if ((read_csr(NDS_MISA) & MISA_S) == 0) {
                skip("Supervisor Mode should be configured to run this test: config Privilege Modes should be configured to 'Machine + Supervisor + User'.\n");
        }

        i = 0;
        do {
                write_csr(NDS_SATP, ((UINT)(g_test_scheme = test_schemes[i++]) << SATP_MODE_LSB) & SATP_MODE);
        } while (((read_csr(NDS_SATP) & SATP_MODE) >> SATP_MODE_LSB) != g_test_scheme);

        // skip the pattern when MMU only supports bare mode
        if (g_test_scheme == BARE) {
                skip("Page-Based Virtual Memory should be configured to sv32/sv39/sv48 to run this test.\n");
        } else {
                write_csr(NDS_SATP, ((UINT)(BARE) << SATP_MODE_LSB) & SATP_MODE);
        }

        // set return to S-mode
        context->mstatus = (context->mstatus & ~MSTATUS_MPP) | (PRIV_S << MSTATUS_MPP_LSB);

        // set return pc
	context->mepc += 4;
}

void ipagefault_handler (SAVED_CONTEXT * context) {
        UINT va, pa;
        pte_page_t*     ppg;

        context->mepc = read_csr(NDS_MEPC);
        va = read_csr(NDS_MTVAL);

        pa = va;   // For undefined pages, PA = VA

        ppg = (pte_page_t*)((read_csr(NDS_SATP) & SATP_PPN) << 12);

        page_alloc(g_test_scheme, ppg, va, pa, PAGE_4K, PTE_ATTR_A | PTE_ATTR_X);

}

void dlpagefault_handler (SAVED_CONTEXT * context) {
        UINT va, pa;
        pte_page_t*     ppg;

        context->mepc = read_csr(NDS_MEPC);
        va = read_csr(NDS_MTVAL);

        if (va >= DATA_REGION_BASE_VA && va < DATA_REGION_BASE_VA + DATA_REGION_SIZE) {
                pa = DATA_REGION_BASE_PA + DATA_REGION_OFFSET;   // For test pages, PA = VA + DATA_REGION_OFFSET
        } else if (va >= (uintptr_t)__executable_start && va < (uintptr_t)__executable_start + 0x8000) {
                pa = va;   // For executable space, PA = VA
        } else {
                exit(1);
        }

        ppg = (pte_page_t*)((read_csr(NDS_SATP) & SATP_PPN) << 12);

        page_alloc(g_test_scheme, ppg, va, pa, PAGE_4K, PTE_ATTR_D | PTE_ATTR_A | PTE_ATTR_W | PTE_ATTR_R);

}

void dspagefault_handler (SAVED_CONTEXT * context) {
        UINT va, pa;
        pte_page_t*     ppg;

        context->mepc = read_csr(NDS_MEPC);
        va = read_csr(NDS_MTVAL);

        if (va >= DATA_REGION_BASE_VA && va < DATA_REGION_BASE_VA + DATA_REGION_SIZE) {
                exit(1);
        } else if (va >= SIM_CONTROL_BASE_VA && va < SIM_CONTROL_BASE_VA + SIM_CONTROL_SIZE) {
                pa = va + SIM_CONTROL_OFFSET;   // For SIM_CONTROL pages, PA = VA
        } else {
                pa = va;   // For undefined pages, PA = VA
        }

        ppg = (pte_page_t*)((read_csr(NDS_SATP) & SATP_PPN) << 12);

        page_alloc(g_test_scheme, ppg, va, pa, PAGE_4K, PTE_ATTR_D | PTE_ATTR_A | PTE_ATTR_W | PTE_ATTR_R);

}

void init_pte_page_base () {
        g_pg_tables     = (pte_page_t*)PAGE_TABLE_BASE_PA;
        g_pg_alloc_ptr  = g_pg_tables + 1;
        memset((char*)g_pg_tables, 0, sizeof(pte_page_t));
}

int main (int argc, char** argv) {
        // Enable handlers
        general_exc_handler_tab[TRAP_M_IPAGFAULT]  = ipagefault_handler;
        general_exc_handler_tab[TRAP_M_DLPAGFAULT] = dlpagefault_handler;
        general_exc_handler_tab[TRAP_M_DSPAGFAULT] = dspagefault_handler;
        general_exc_handler_tab[TRAP_U_ECALL] = ecall_handler;
        general_exc_handler_tab[TRAP_S_ECALL] = ecall_handler;
        general_exc_handler_tab[TRAP_M_ECALL] = ecall_handler;

        // Check environment in M-mode
        // Setup mmap settings in M-mode
        asm volatile("ecall");

        // Initialize top-level PTE page
        init_pte_page_base();

	volatile uint32_t  i;
	volatile uint32_t  j;
	volatile uint32_t  vpt_data;
        volatile uint32_t* vpt_var = (volatile UINT*)DATA_REGION_BASE_VA;

        // Enable memory translation
        ITDT_ON(g_test_scheme, 0, ((UINT)g_pg_tables) >> 12);

	for (i = 0; i < 7; i++) {
		for (j = 0; j < 4; j++) {
			vpt_data = *(vpt_var + (1 << (i + 10)) + (j << 18));
		        if(vpt_data != (i * 4 + j))  exit(1);
			*(vpt_var + (1 << (i + 10)) + (j << 18)) = vpt_data + 1;
		}
	}
        return 0;
}

