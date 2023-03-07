#include <inttypes.h>
#include <stdio.h>

#include "ndslib.h"
#include "core_v5.h"
#include "interrupt.h"
#include "platform.h"



#if __riscv_xlen == 64
#define xlen_t uint64_t
#define XLEN 64
#else
#define xlen_t uint32_t
#define XLEN 32
#endif

#ifdef NDS_ECC_RAND_INJECT_CORR_ERROR
#define RAND_INJECT_ECC 1
#else
#define RAND_INJECT_ECC 0
#endif

/* L2C CCTL Command Index */
#define CCTL_L2_IX_INVAL                        0x0
#define CCTL_L2_IX_WB                           0x1
#define CCTL_L2_IX_WBINVAL                      0x2
#define CCTL_L2_PA_INVAL                        0x8
#define CCTL_L2_PA_WB                           0x9
#define CCTL_L2_PA_WBINVAL                      0xA
#define CCTL_L2_TGT_WRITE                       0x10
#define CCTL_L2_TGT_READ                        0x11
#define CCTL_L2_WBINVAL_ALL                     0x12


uint32_t index_lsb;
uint32_t index_msb;
uint32_t index_bw;

uint32_t offset_lsb;
uint32_t offset_msb;
uint32_t offset_bw;

uint32_t tag_lsb;
uint32_t tag_msb;
uint32_t tag_bw;

uint32_t dcache_way;
uint32_t dcache_set;
uint32_t dcache_line_size;

uint32_t l2c_exist = 0;
L2C_RegDef *   l2c_reg;

/*           CCTL command format
#----------------------------------------
#                  VA
#|--------------------------------------|
#|    TAG    |    IDX    |    OFFSET    |
#|--------------------------------------|
#
#            IX (tag ram addr)
#|--------------------------------------|
#|          | WAY |    IDX   |  OFFSET  |
#|--------------------------------------|
#
#         TAG (tag ram data)
#        |tag_bw + 3    |  3 |2        0|
#|--------------------------------------|
#|       |      TAG     |LOCK|   MESI   |
#|--------------------------------------|
*/

uint32_t func_log2(uint64_t x){
    uint32_t r = 0;
    r |= ((x & 0xFFFFFFFF00000000UL) != 0UL) << 5;
    r |= ((x & 0xFFFF0000FFFF0000UL) != 0UL) << 4;
    r |= ((x & 0xFF00FF00FF00FF00UL) != 0UL) << 3;
    r |= ((x & 0xF0F0F0F0F0F0F0F0UL) != 0UL) << 2;
    r |= ((x & 0xCCCCCCCCCCCCCCCCUL) != 0UL) << 1;
    r |= ((x & 0xAAAAAAAAAAAAAAAAUL) != 0UL) << 0;
    return x ? r : XLEN;
}

xlen_t rotr(xlen_t num) {
    xlen_t result;
    result = (num >> 1) | (num << (XLEN - 1));
    return result;
}

uint32_t get_palen(){
    uint32_t palen;
    uint32_t has_mmu = 0;
    xlen_t satp;
    xlen_t mepc;
    xlen_t temp;

    if ((read_csr(NDS_MISA) >> 18) & 0x1) { // S-Mode support
        /*
         * set the msb of csr_satp to test if there is mmu
         * + if there is no mmu, csr_satp is tied to zero
         * + if there is mmu, msb of csr_satp stand for mmu sheme
         *      sv32 for rv32
         *      sv39 for rv64
         */
        temp = 0x1UL << (XLEN - 1);
        set_csr(NDS_SATP, temp);
        satp = read_csr(NDS_SATP);
        has_mmu = (satp & temp) != 0;
    }

    if(has_mmu){
        /*
         * max palen is
         *      56 for rv64
         *      34 for rv32
         */
        uint32_t max_palen = (XLEN == 64) ? 56 : 34;
        xlen_t palen_mask = (1UL << (max_palen - 12)) - 1;
        temp = palen_mask;
        set_csr(NDS_SATP, temp);
        temp = read_csr(NDS_SATP) & palen_mask;
        write_csr(NDS_SATP, satp);
        palen = func_log2(temp + 1) + 12;

    } else {
        /*
         * use csr_mepc to test the bit width of virtual address
         */
        mepc = read_csr(NDS_MEPC);
        temp = ~(xlen_t)0U;
        write_csr(NDS_MEPC, temp);
        temp = read_csr(NDS_MEPC) | 0x03;
        write_csr(NDS_MEPC, mepc);
        palen = func_log2(temp + 1);
    }

    return palen;

}



void ecall_handler(SAVED_CONTEXT * context) {
    xlen_t mdcm_cfg;
    xlen_t mcache_ctl;
    int32_t mdcm_cfg_line_size;
    int32_t mdcm_cfg_way;
    int32_t mdcm_cfg_set;
    int32_t mdcm_cfg_seth;
    int32_t mdcm_cfg_dc_ecc;

    context->mepc += 4;
    l2c_exist = (DEV_SMU->SYSTEMCFG >> 8) & 0x1;
    l2c_reg = (L2C_RegDef *) L2C_BASE;
    // Read MDCM_CFG
    mdcm_cfg        = read_csr(NDS_MDCM_CFG);

    mdcm_cfg_seth           = (mdcm_cfg >> 24) & 0x01;
    mdcm_cfg_dc_ecc         = (mdcm_cfg >> 10) & 0x3;
    mdcm_cfg_line_size      = (mdcm_cfg >> 6) & 0x7;
    mdcm_cfg_way            = (mdcm_cfg >> 3) & 0x7;
    mdcm_cfg_set            = (mdcm_cfg >> 0) & 0x7;

    // Ignore the testing in case of no D-CACHE
    if (mdcm_cfg_line_size == 0) {
        skip("The size of D-Cache should be larger than 0 KiB to run this test.\n");
    }
    // Ignore the testing in case of random inject ecc error
    if (RAND_INJECT_ECC == 1) {
        skip("Macro `NDS_ECC_RAND_INJECT_CORR_ERROR should not be defined to run this test. This test is not compatible with random ECC error injection.\n");
    }

    dcache_line_size        = 1 << (mdcm_cfg_line_size + 2);
    dcache_way              = mdcm_cfg_way + 1;
    dcache_set              = mdcm_cfg_seth ? (32 >> mdcm_cfg_set) : (1 << (mdcm_cfg_set + 6));

    offset_lsb              = 0;
    offset_msb              = func_log2(dcache_line_size) - 1;
    offset_bw               = offset_msb - offset_lsb + 1;

    index_lsb               = offset_msb + 1;
    index_bw                = func_log2(dcache_set);
    index_msb               = index_lsb + index_bw - 1;

    tag_lsb                 = index_msb + 1;
    tag_msb                 = get_palen() - 1;
    tag_bw                  = tag_msb - tag_lsb + 1;

    // Turn on the ECC if exist
    if (mdcm_cfg_dc_ecc != 0) {
        mcache_ctl = read_csr(NDS_MCACHE_CTL);
        mcache_ctl |= 0x30;
        write_csr(NDS_MCACHE_CTL, mcache_ctl);
    }
    asm volatile ("fence.i");       // Flush all dcache data before disable it
    if (l2c_exist == 1) {
	    DEV_L2C->M0_CCTL_CMD = CCTL_L2_WBINVAL_ALL;
	    while(L2C_GET_FIELD(l2c_reg->CCTL_ST, CCTL_ST, M0) != 0);    // Wait cmd finishes
    }
    clear_csr(NDS_MCACHE_CTL, 2);   // Turn off dcache to avoid L/S data mismatching

    // Return to M-mode
    if (((context->mstatus >> 11) & 0x3) != 3) {
        context->mstatus |= 0x1800;
    }
}


int main (int argc, char** argv) {

    // Set ECALL handler
    general_exc_handler_tab[TRAP_U_ECALL] = ecall_handler;
    general_exc_handler_tab[TRAP_S_ECALL] = ecall_handler;
    general_exc_handler_tab[TRAP_M_ECALL] = ecall_handler;

    asm volatile("ecall");

    xlen_t golden, test, golden_tmp;
    xlen_t seed = 0x5a5a5a5a5a5a5a5a;

    // tag ram
    //                 |tag_bw+4  4|  3 |2  0|
    //tag format:  |  0|     tag   |lock|mesi|
    xlen_t rtag_mask = (0x01UL << (tag_bw + 4)) - 1;

    asm  volatile ("tag_write:");
    test = seed;
    for (xlen_t i = 0; i < dcache_way; i++) {
        for (xlen_t j = (1UL << index_lsb); j < (1UL << tag_lsb); j <<= 1) {
            test = rotr(test);
            write_csr(0x7cb/*NDS_MCCTLBEGINADDR*/, j + (i << (index_msb + 1)));
            write_csr(0x7cd/*NDS_MCCTLDATA*/     , test                      );
            write_csr(0x7cc/*NDS_MCCTLCOMMAND*/  , 21 /*L1D_IX_WTAG*/        );
        }
    }

    asm  volatile ("tag_read:");
    golden =  seed;
    for (xlen_t i = 0; i < dcache_way; i++) {
        for (xlen_t j = (1UL << index_lsb); j < (1UL << tag_lsb); j <<= 1) {
            golden = rotr(golden);
            write_csr(0x7cb/*NDS_MCCTLBEGINADDR*/ , j + (i << (index_msb + 1)));
            write_csr(0x7cc/*NDS_MCCTLCOMMAND*/   , 19 /*L1D_IX_RTAG*/        );
            test = read_csr(0x7cd/*NDS_MCCTLDATA*/                            );
            golden_tmp = golden & rtag_mask;
            if (golden_tmp != test) {
                exit(1);
            }
        }
    }

    // data ram
    asm  volatile ("data_write:");
    test = seed;
    for (xlen_t i = 0; i < dcache_way; i++) {
        for (xlen_t j = (1UL << index_lsb); j < (1UL << tag_lsb); j <<= 1) {
            for (xlen_t k = 0; k < (1UL << index_lsb); k += XLEN/8) {
                test = rotr(test);
                write_csr(0x7cb/*NDS_MCCTLBEGINADDR*/, k + j + (i << (index_msb + 1)));
                write_csr(0x7cd/*NDS_MCCTLDATA*/     , test                          );
                write_csr(0x7cc/*NDS_MCCTLCOMMAND*/  , 22 /*L1D_IX_WDATA*/           );
            }
        }
    }

    asm  volatile ("data_read:");
    golden = seed;
    for (xlen_t i = 0; i < dcache_way; i++) {
        for (xlen_t j = (1UL << index_lsb); j < (1UL << tag_lsb); j <<= 1) {
            for (xlen_t k = 0; k < (1UL << index_lsb); k += XLEN/8) {
                golden = rotr(golden);
                write_csr(0x7cb/*NDS_MCCTLBEGINADDR*/ , k + j + (i << (index_msb + 1)));
                write_csr(0x7cc/*NDS_MCCTLCOMMAND*/   , 20 /*L1D_IX_RDATA*/           );
                test = read_csr(0x7cd/*NDS_MCCTLDATA*/                                );
                if (golden != test) {
                    exit(1);
                }
            }

        }
    }
}

