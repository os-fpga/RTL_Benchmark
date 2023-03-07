#ifndef __CORE_V5_H__
#define __CORE_V5_H__

#ifndef __ASSEMBLER__
#include <inttypes.h>
#endif

#define MSTATUS_UIE         0x00000001
#define MSTATUS_SIE         0x00000002
#define MSTATUS_HIE         0x00000004
#define MSTATUS_MIE         0x00000008
#define MSTATUS_UPIE        0x00000010
#define MSTATUS_SPIE        0x00000020
#define MSTATUS_HPIE        0x00000040
#define MSTATUS_MPIE        0x00000080
#define MSTATUS_SPP         0x00000100
#define MSTATUS_HPP         0x00000600
#define MSTATUS_SM          0x00000800
#define MSTATUS_MPP         0x00001800
#define MSTATUS_FS          0x00006000
#define MSTATUS_XS          0x00018000
#define MSTATUS_MPRV        0x00020000
#define MSTATUS_PUM         0x00040000
#define MSTATUS_MXR         0x00080000
#define MSTATUS_VM          0x1F000000
#define MSTATUS32_SD        0x80000000
#define MSTATUS64_SD        0x8000000000000000

#define SSTATUS_UIE         0x00000001
#define SSTATUS_SIE         0x00000002
#define SSTATUS_UPIE        0x00000010
#define SSTATUS_SPIE        0x00000020
#define SSTATUS_SPP         0x00000100
#define SSTATUS_FS          0x00006000
#define SSTATUS_XS          0x00018000
#define SSTATUS_SUM         0x00040000
#define SSTATUS_MXR         0x00080000
#define SSTATUS32_SD        0x80000000
#define SSTATUS64_SD        0x8000000000000000

#if __riscv_xlen == 64
#define MCAUSE_INT          0x8000000000000000UL
#define MCAUSE_CAUSE        0x7FFFFFFFFFFFFFFFUL
#else
#define MCAUSE_INT          0x80000000UL
#define MCAUSE_CAUSE        0x7FFFFFFFUL
#endif

#define IRQ_S_SOFT          1
#define IRQ_H_SOFT          2
#define IRQ_M_SOFT          3
#define IRQ_S_TIMER         5
#define IRQ_H_TIMER         6
#define IRQ_M_TIMER         7
#define IRQ_S_EXT           9
#define IRQ_H_EXT           10
#define IRQ_M_EXT           11
#define IRQ_SLPECC          16
#define IRQ_BWE             17

#define TRAP_M_IACCFAULT    1   //Instruction access fault
#define TRAP_M_DLACCFAULT   5   //Data load access fault
#define TRAP_M_DSACCFAULT   7   //Data store access fault
#define TRAP_U_ECALL        8
#define TRAP_S_ECALL        9
#define TRAP_H_ECALL        10
#define TRAP_M_ECALL        11
#define TRAP_M_IPAGFAULT    12  //Instruction page fault
#define TRAP_M_DLPAGFAULT   13  //Data load page fault
#define TRAP_M_DSPAGFAULT   15  //Data store page fault
#define TRAP_M_STACKOVF     32
#define TRAP_M_STACKUDF     33
#define TRAP_M_ACEDISABLE   34

#define MIP_SSIP            (1 << IRQ_S_SOFT)
#define MIP_HSIP            (1 << IRQ_H_SOFT)
#define MIP_MSIP            (1 << IRQ_M_SOFT)
#define MIP_STIP            (1 << IRQ_S_TIMER)
#define MIP_HTIP            (1 << IRQ_H_TIMER)
#define MIP_MTIP            (1 << IRQ_M_TIMER)
#define MIP_SEIP            (1 << IRQ_S_EXT)
#define MIP_HEIP            (1 << IRQ_H_EXT)
#define MIP_MEIP            (1 << IRQ_M_EXT)

#define SATP32_MODE	0x80000000
#define SATP32_ASID	0x7FC00000
#define SATP32_PPN	0x003FFFFF
#define SATP64_MODE	0xF000000000000000
#define SATP64_ASID	0x0FFFF00000000000
#define SATP64_PPN	0x00000FFFFFFFFFFF

#define SATP_MODE_OFF	0
#define SATP_MODE_SV32	1
#define SATP_MODE_SV39	8
#define SATP_MODE_SV48	9
#define SATP_MODE_SV57	10
#define SATP_MODE_SV64	11

#define PMP_R     0x01
#define PMP_W     0x02
#define PMP_X     0x04
#define PMP_A     0x18
#define PMP_L     0x80
#define PMP_TOR   0x08
#define PMP_NA4   0x10
#define PMP_NAPOT 0x18

/* PMA macros */
#define SCHEME_NAPOT                            3
#define SCHEME_TOR                              1
#define SCHEME_OFF                              0

#define NAPOT(base, size)                       (uintptr_t)(((size) > 0) ? ((((uintptr_t)(base) & (~((uintptr_t)(size) - 1))) >> 2) | (((uintptr_t)(size) - 1) >> 3)) : 0)
#define TOR(top)                                (uintptr_t)((top) >> 2)

#define PMACFG_NME(n,m,e)                        (((n) << 6) | ((m) << 2) | ((e) << 0))
#define PMA_NAMO_OFF                            0
#define PMA_NAMO_ON                             1
#define PMA_MTYP_DEVICE                         1
#define PMA_MTYP_NONCACHEABLE                   3
#define PMA_MTYP_CACHEABLE                      11
#define PMA_ETYP_NAPOT                          SCHEME_NAPOT
#define PMA_ETYP_TOR                            SCHEME_TOR
#define PMA_ETYP_PMA_OFF                        SCHEME_OFF

#define PTE_V		0x001 //Valid
#define PTE_R		0x002 //Read
#define PTE_W		0x004 //Write
#define PTE_X		0x008 //Execute
#define PTE_U		0x010 //User
#define PTE_G		0x020 //Global
#define PTE_A		0x040 //Accessed
#define PTE_D		0x080 //Dirty
#define PTE_SOFT	0x300 //Reserved for Software

/* PMA related CSRs */
#define NDS_PMACFG0_                            0xBC0
#define NDS_PMACFG1_                            0xBC1
#define NDS_PMACFG2_                            0xBC2
#define NDS_PMACFG3_                            0xBC3
#define NDS_PMAADDR0_                           0xBD0
#define NDS_PMAADDR1_                           0xBD1
#define NDS_PMAADDR2_                           0xBD2
#define NDS_PMAADDR3_                           0xBD3
#define NDS_PMAADDR4_                           0xBD4
#define NDS_PMAADDR5_                           0xBD5
#define NDS_PMAADDR6_                           0xBD6
#define NDS_PMAADDR7_                           0xBD7
#define NDS_PMAADDR8_                           0xBD8
#define NDS_PMAADDR9_                           0xBD9
#define NDS_PMAADDR10_                          0xBDA
#define NDS_PMAADDR11_                          0xBDB
#define NDS_PMAADDR12_                          0xBDC
#define NDS_PMAADDR13_                          0xBDD
#define NDS_PMAADDR14_                          0xBDE
#define NDS_PMAADDR15_                          0xBDF

#define PTE_PPN_SHIFT 10

#define RISCV_PGSHIFT 12
#define RISCV_PGSIZE (1 << RISCV_PGSHIFT)

#if __riscv_xlen == 64
# define SLL32    sllw
# define STORE    sd
# define LOAD     ld
# define LWU      lwu
# define LOG_REGBYTES 3
#else
# define SLL32    sll
# define STORE    sw
# define LOAD     lw
# define LWU      lw
# define LOG_REGBYTES 2
#endif
#define REGBYTES (1 << LOG_REGBYTES)

#ifndef __ASSEMBLER__

#include <nds_intrinsic.h>

#ifndef NDS_MMSC_CFG2
# if __riscv_xlen == 64
#  define NDS_MMSC_CFG2         0xFC2 
# else
#  define NDS_MMSC_CFG2         0xFC3 
# endif
#endif

#ifndef NDS_MMSC_CFG2_OFFSET
# if __riscv_xlen == 64
#  define NDS_MMSC_CFG2_OFFSET  0x20 
# else
#  define NDS_MMSC_CFG2_OFFSET  0x0 
# endif
#endif

#define MCACHE_CTL_IC_EN            0x00000001
#define MCACHE_CTL_DC_EN            0x00000002
#define MCACHE_CTL_IC_ECCEN         0x0000000C
#define MCACHE_CTL_DC_ECCEN         0x00000030
#define MCACHE_CTL_IC_RWECC         0x00000040
#define MCACHE_CTL_DC_RWECC         0x00000080
#define MCACHE_CTL_CCTL_SUEN        0x00000100
#define MCACHE_CTL_IPREF_EN         0x00000200
#define MCACHE_CTL_DPREF_EN         0x00000400
#define MCACHE_CTL_IC_FIRST_WORD    0x00000800
#define MCACHE_CTL_DC_FIRST_WORD    0x00001000
#define MCACHE_CTL_DC_WAROUND       0x00006000
#define MCACHE_CTL_DC_COHEN         0x00080000
#define MCACHE_CTL_DC_COHSTA        0x00100000

#define read_csr(reg)		__nds__csrr(reg)
#define write_csr(reg, val)	__nds__csrw(val, reg)
#define swap_csr(reg, val)	__nds__csrrw(val, reg)
#define set_csr(reg, bit)	__nds__csrrs(bit, reg)
#define clear_csr(reg, bit)	__nds__csrrc(bit, reg)

#endif

#endif	// __CORE_V5_H__
