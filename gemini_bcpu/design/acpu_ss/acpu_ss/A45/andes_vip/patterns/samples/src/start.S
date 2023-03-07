/*
 * Copyright (c) 2017 Andes Technology Corporation
 * All rights reserved.
 *
 * This file defines the reset/nmi/trap handlers, the reset initialization code
 * and the trap entry table for Vectored-PLIC.
 *
 * Please note that the code in this file is to facilitate AndesCore processor
 * verification and it is NOT a goal for this code to be used in production.
 * For sample production version of start.S, please find it in Andes Startup
 * demos.
 */

#include "core_v5.h"

	.section .init
	.globl _start
	.type _start,@function

	/* vectore table for Vectored PLIC */
_trap_entry_vplic:
	.word	m_trap_entry
	.word	_EI_1_HANDLER_WRAPPER
	.word	_EI_2_HANDLER_WRAPPER
	.word	_EI_3_HANDLER_WRAPPER
	.word	_EI_4_HANDLER_WRAPPER
	.word	_EI_5_HANDLER_WRAPPER
	.word	_EI_6_HANDLER_WRAPPER
	.word	_EI_7_HANDLER_WRAPPER
	.word	_EI_8_HANDLER_WRAPPER
	.word	_EI_9_HANDLER_WRAPPER
	.word	_EI_10_HANDLER_WRAPPER
	.word	_EI_11_HANDLER_WRAPPER
	.word	_EI_12_HANDLER_WRAPPER
	.word	_EI_13_HANDLER_WRAPPER
	.word	_EI_14_HANDLER_WRAPPER
	.word	_EI_15_HANDLER_WRAPPER
	.word	_EI_16_HANDLER_WRAPPER
	.word	_EI_17_HANDLER_WRAPPER
	.word	_EI_18_HANDLER_WRAPPER
	.word	_EI_19_HANDLER_WRAPPER
	.word	_EI_20_HANDLER_WRAPPER
	.word	_EI_21_HANDLER_WRAPPER
	.word	_EI_22_HANDLER_WRAPPER
	.word	_EI_23_HANDLER_WRAPPER
	.word	_EI_24_HANDLER_WRAPPER
	.word	_EI_25_HANDLER_WRAPPER
	.word	_EI_26_HANDLER_WRAPPER
	.word	_EI_27_HANDLER_WRAPPER
	.word	_EI_28_HANDLER_WRAPPER
	.word	_EI_29_HANDLER_WRAPPER
	.word	_EI_30_HANDLER_WRAPPER
	.word	_EI_31_HANDLER_WRAPPER

_start:
	j _reset_handler

_reset_handler:
	/* Save t0 to determine reset or NMI */
	csrr    t0, mcause
	bnez    t0, nmi_handler

	/* Initialize all gpr */
	li	x1, 0
	li	x2, 0
	li	x3, 0
	li	x4, 0
	li	x5, 0
	li	x6, 0
	li	x7, 0
	li	x8, 0
	li	x9, 0
	li	x10, 0
	li	x11, 0
	li	x12, 0
	li	x13, 0
	li	x14, 0
	li	x15, 0
#ifndef __riscv_32e
	li	x16, 0
	li	x17, 0
	li	x18, 0
	li	x19, 0
	li	x20, 0
	li	x21, 0
	li	x22, 0
	li	x23, 0
	li	x24, 0
	li	x25, 0
	li	x26, 0
	li	x27, 0
	li	x28, 0
	li	x29, 0
	li	x30, 0
	li	x31, 0
#endif
#ifdef __riscv_flen
	/* Initialize floating point register */
	csrr	x15, misa
	srli	x15, x15, 5
	andi	x15, x15, 1
	beqz	x15, 1f

	/* Set mstatus.FS */
	li	x14, 0x1 << 13
	csrs	mstatus, x14

	fmv.w.x f0, x0
	fmv.w.x f1, x0
	fmv.w.x f2, x0
	fmv.w.x f3, x0
	fmv.w.x f4, x0
	fmv.w.x f5, x0
	fmv.w.x f6, x0
	fmv.w.x f7, x0
	fmv.w.x f8, x0
	fmv.w.x f9, x0
	fmv.w.x f10, x0
	fmv.w.x f11, x0
	fmv.w.x f12, x0
	fmv.w.x f13, x0
	fmv.w.x f14, x0
	fmv.w.x f15, x0
	fmv.w.x f16, x0
	fmv.w.x f17, x0
	fmv.w.x f18, x0
	fmv.w.x f19, x0
	fmv.w.x f20, x0
	fmv.w.x f21, x0
	fmv.w.x f22, x0
	fmv.w.x f23, x0
	fmv.w.x f24, x0
	fmv.w.x f25, x0
	fmv.w.x f26, x0
	fmv.w.x f27, x0
	fmv.w.x f28, x0
	fmv.w.x f29, x0
	fmv.w.x f30, x0
	fmv.w.x f31, x0
1:
#endif

	/* Initialize vector register */
	csrr	x15, misa
	srli	x15, x15, 21
	andi	x15, x15, 1
	beqz	x15, 1f

	csrr	x15, mstatus

	/* Set mstatus.VS */
	li	x14, 0x1 << 9
	csrs	mstatus, x14

	.word 0x01007757  /* vsetvli a4,zero,e32,m1,tu,mu,d1 */

	.word 0x5e003057  /*vmv.v.i	v0,0 */
	.word 0x5e0030d7  /*vmv.v.i	v1,0 */
	.word 0x5e003157  /*vmv.v.i	v2,0 */
	.word 0x5e0031d7  /*vmv.v.i	v3,0 */
	.word 0x5e003257  /*vmv.v.i	v4,0 */
	.word 0x5e0032d7  /*vmv.v.i	v5,0 */
	.word 0x5e003357  /*vmv.v.i	v6,0 */
	.word 0x5e0033d7  /*vmv.v.i	v7,0 */
	.word 0x5e003457  /*vmv.v.i	v8,0 */
	.word 0x5e0034d7  /*vmv.v.i	v9,0 */
	.word 0x5e003557  /*vmv.v.i	v10,0*/
	.word 0x5e0035d7  /*vmv.v.i	v11,0*/
	.word 0x5e003657  /*vmv.v.i	v12,0*/
	.word 0x5e0036d7  /*vmv.v.i	v13,0*/
	.word 0x5e003757  /*vmv.v.i	v14,0*/
	.word 0x5e0037d7  /*vmv.v.i	v15,0*/
	.word 0x5e003857  /*vmv.v.i	v16,0*/
	.word 0x5e0038d7  /*vmv.v.i	v17,0*/
	.word 0x5e003957  /*vmv.v.i	v18,0*/
	.word 0x5e0039d7  /*vmv.v.i	v19,0*/
	.word 0x5e003a57  /*vmv.v.i	v20,0*/
	.word 0x5e003ad7  /*vmv.v.i	v21,0*/
	.word 0x5e003b57  /*vmv.v.i	v22,0*/
	.word 0x5e003bd7  /*vmv.v.i	v23,0*/
	.word 0x5e003c57  /*vmv.v.i	v24,0*/
	.word 0x5e003cd7  /*vmv.v.i	v25,0*/
	.word 0x5e003d57  /*vmv.v.i	v26,0*/
	.word 0x5e003dd7  /*vmv.v.i	v27,0*/
	.word 0x5e003e57  /*vmv.v.i	v28,0*/
	.word 0x5e003ed7  /*vmv.v.i	v29,0*/
	.word 0x5e003f57  /*vmv.v.i	v30,0*/
	.word 0x5e003fd7  /*vmv.v.i	v31,0*/

	csrw	mstatus, x15
1:

        .option push
        .option norelax
        /* Initialize global pointer */
	LOAD gp, __global_pointer_addr
        .option pop

	/* Initialize stack pointer */
	LOAD 	t0, _stack_addr
	csrr 	t1, mhartid
	li	t2, 0x8000
	/* Separate the SP of each HART by 32kiB */
1:
	beqz	t1, 2f
	add 	t0, t0, t2
	addi	t1, t1, -1
	j	1b
2:
	mv 	sp, t0

#ifdef __nds_execit
	/* Check HW for CoDense */
	csrr	a0, mmsc_cfg
	li	a1, (1 << 3)
	and	a2, a0, a1
	beqz	a2, 1f
	/* Initialize the table base of CoDense instruction */
	la	a0, _ITB_BASE_
	csrw	uitb, a0
1:
#endif

	/* Check clic support */
	csrr t1, mmsc_cfg
	srli t1, t1, 0x1b
	andi t1, t1, 0x1
	beqz t1, 1f
	la   t0, _trap_entry_vclic
        csrw 0x307, t0       # mtvt = 0x307
	la t0, m_trap_entry
	ori  t0, t0, 0x3
	j    _mtvec_set	
1:
	/* Set the detelgation if S-mode is supported */
	la t0, s_trap_entry
	csrr t1, misa
	srli t1, t1, 0x12
	andi t1, t1, 0x1
	beqz t1, _init_mtvec
	/* Set mideleg to delegate trap in S-mode */
	csrr t1, mideleg
	li   t2, 0x00000200
	or  t1, t1, t2
	csrw mideleg, t1
	/* Disable Vectored PLIC */
        csrr t1, 0x7d0
        andi  t1, t1, -3
        csrw 0x7d0, t1
	csrw stvec, t0

	la t0, m_trap_entry
	j _mtvec_set

_init_mtvec:
	/* Initial machine trap-vector Base */
	la t0, m_trap_entry
	csrr t1, mmsc_cfg
	srli t1, t1, 0xc
	andi t1, t1, 0x1
	beqz t1, _mtvec_set
	/* Enable Vectored PLIC */
	csrr t1, 0x7d0
	ori  t1, t1, 0x2
	csrw 0x7d0, t1
	la t0, _trap_entry_vplic
_mtvec_set:
	csrw mtvec, t0

1:

	#/* Do PMP setting for all regions with all permissions except for last byte */
	li t0, 0xf
	csrw pmpcfg0, t0
	li t0, -1
	csrw pmpaddr0, t0

	/* Do system low level setup. It must be a leaf function */
	call __platform_init

	/* Load data section */
	la a0, __data_lmastart
	LOAD a1, __data_start_addr
	LOAD a2, _edata_addr
	beq a0, a1, 2f
	bgeu a1, a2, 2f
1:
	lw t0, (a0)
	sw t0, (a1)
	addi a0, a0, 4
	addi a1, a1, 4
	bltu a1, a2, 1b
2:

	/* Clear bss section */
	LOAD a0, _edata_addr
	LOAD a1, _end_addr
	bgeu a0, a1, 2f
1:
	sw zero, (a0)
	addi a0, a0, 4
	bltu a0, a1, 1b
2:

	/* Clear sharedata section */
	LOAD a0, __sharedata_start_addr
	LOAD a1, __sharedata_end_addr
	bgeu a0, a1, 2f
1:
	sw zero, (a0)
	addi a0, a0, 4
	bltu a0, a1, 1b
2:

	/* System reset handler */
	call reset_handler

	/* Infinite loop, if returned accidently */
1:	j 1b

	.weak __platform_init
__platform_init:
	ret

	.p2align 3
__global_pointer_addr:
	.dword	__global_pointer$
_stack_addr:
	.dword	_stack
__data_start_addr:
	.dword	__data_start
_edata_addr:
	.dword	_edata
_end_addr:
	.dword	_end
__sharedata_start_addr:
	.dword	__sharedata_start
__sharedata_end_addr:
	.dword	__sharedata_end

	.section .text
	.align 6

.global m_trap_entry
m_trap_entry:
	addi sp, sp, -32*REGBYTES

	/* Save caller registers */
	STORE x1, 0*REGBYTES(sp)
	STORE x4, 1*REGBYTES(sp)
	STORE x5, 2*REGBYTES(sp)
	STORE x6, 3*REGBYTES(sp)
	STORE x7, 4*REGBYTES(sp)
	STORE x10, 5*REGBYTES(sp)
	STORE x11, 6*REGBYTES(sp)
	STORE x12, 7*REGBYTES(sp)
	STORE x13, 8*REGBYTES(sp)
	STORE x14, 9*REGBYTES(sp)
	STORE x15, 10*REGBYTES(sp)
#ifndef __riscv_32e
	STORE x16, 11*REGBYTES(sp)
	STORE x17, 12*REGBYTES(sp)
	STORE x28, 13*REGBYTES(sp)
	STORE x29, 14*REGBYTES(sp)
	STORE x30, 15*REGBYTES(sp)
	STORE x31, 16*REGBYTES(sp)
#endif

	/* Save mstatus and mepc */
	csrr t0, mepc
	csrr t1, mstatus
	csrr t2, mxstatus

	STORE t0, 17*REGBYTES(sp)
	STORE t1, 18*REGBYTES(sp)
	STORE t2, 19*REGBYTES(sp)

	/* Call trap handler */
	csrr a0, mcause
	mv   a1, sp
	call trap_handler

	/* Disable interrupt */
	csrrci a5, mstatus, MSTATUS_MIE

	/* Restore mstatus and mepc */
	LOAD t0, 17*REGBYTES(sp)
	LOAD t1, 18*REGBYTES(sp)
	LOAD t2, 19*REGBYTES(sp)

	csrw mepc, t0
	csrw mstatus, t1
	csrw mxstatus, t2

	/* Restore caller registers */
	LOAD x1, 0*REGBYTES(sp)
	LOAD x4, 1*REGBYTES(sp)
	LOAD x5, 2*REGBYTES(sp)
	LOAD x6, 3*REGBYTES(sp)
	LOAD x7, 4*REGBYTES(sp)
	LOAD x10, 5*REGBYTES(sp)
	LOAD x11, 6*REGBYTES(sp)
	LOAD x12, 7*REGBYTES(sp)
	LOAD x13, 8*REGBYTES(sp)
	LOAD x14, 9*REGBYTES(sp)
	LOAD x15, 10*REGBYTES(sp)
#ifndef __riscv_32e
	LOAD x16, 11*REGBYTES(sp)
	LOAD x17, 12*REGBYTES(sp)
	LOAD x28, 13*REGBYTES(sp)
	LOAD x29, 14*REGBYTES(sp)
	LOAD x30, 15*REGBYTES(sp)
	LOAD x31, 16*REGBYTES(sp)
#endif

	addi sp, sp, 32*REGBYTES
	mret

	.align 2
s_trap_entry:
        addi sp, sp, -32*REGBYTES

        /* Save caller registers */
        STORE x1, 0*REGBYTES(sp)
        STORE x4, 1*REGBYTES(sp)
        STORE x5, 2*REGBYTES(sp)
        STORE x6, 3*REGBYTES(sp)
        STORE x7, 4*REGBYTES(sp)
        STORE x10, 5*REGBYTES(sp)
        STORE x11, 6*REGBYTES(sp)
        STORE x12, 7*REGBYTES(sp)
        STORE x13, 8*REGBYTES(sp)
        STORE x14, 9*REGBYTES(sp)
        STORE x15, 10*REGBYTES(sp)
#ifndef __riscv_32e
        STORE x16, 11*REGBYTES(sp)
        STORE x17, 12*REGBYTES(sp)
        STORE x28, 13*REGBYTES(sp)
        STORE x29, 14*REGBYTES(sp)
        STORE x30, 15*REGBYTES(sp)
        STORE x31, 16*REGBYTES(sp)
#endif

        /* Save sstatus and sepc */
        csrr t0, sepc
        csrr t1, sstatus

        STORE t0, 17*REGBYTES(sp)
        STORE t1, 18*REGBYTES(sp)

        /* Call trap handler */
        csrr a0, scause
        mv a1, sp
        call trap_handler

        /* Disable interrupt */
        csrrci a5, sstatus, SSTATUS_SIE

        /* Restore mstatus and mepc */
        LOAD t0, 17*REGBYTES(sp)
        LOAD t1, 18*REGBYTES(sp)

        csrw sepc, t0
        csrw sstatus, t1

        /* Restore caller registers */
        LOAD x1, 0*REGBYTES(sp)
        LOAD x4, 1*REGBYTES(sp)
        LOAD x5, 2*REGBYTES(sp)
        LOAD x6, 3*REGBYTES(sp)
        LOAD x7, 4*REGBYTES(sp)
        LOAD x10, 5*REGBYTES(sp)
        LOAD x11, 6*REGBYTES(sp)
        LOAD x12, 7*REGBYTES(sp)
        LOAD x13, 8*REGBYTES(sp)
        LOAD x14, 9*REGBYTES(sp)
        LOAD x15, 10*REGBYTES(sp)
#ifndef __riscv_32e
        LOAD x16, 11*REGBYTES(sp)
        LOAD x17, 12*REGBYTES(sp)
        LOAD x28, 13*REGBYTES(sp)
        LOAD x29, 14*REGBYTES(sp)
        LOAD x30, 15*REGBYTES(sp)
        LOAD x31, 16*REGBYTES(sp)
#endif

        addi sp, sp, 32*REGBYTES
        sret

	.weak trap_handler
trap_handler:
1:	j 1b

	.weak nmi_handler
nmi_handler:
1:	j 1b

	.weak machine_ei_handler
machine_ei_handler:
1:	j 1b


_EI_1_HANDLER_WRAPPER:
_EI_2_HANDLER_WRAPPER:
_EI_3_HANDLER_WRAPPER:
_EI_4_HANDLER_WRAPPER:
_EI_5_HANDLER_WRAPPER:
_EI_6_HANDLER_WRAPPER:
_EI_7_HANDLER_WRAPPER:
_EI_8_HANDLER_WRAPPER:
_EI_9_HANDLER_WRAPPER:
_EI_10_HANDLER_WRAPPER:
_EI_11_HANDLER_WRAPPER:
_EI_12_HANDLER_WRAPPER:
_EI_13_HANDLER_WRAPPER:
_EI_14_HANDLER_WRAPPER:
_EI_15_HANDLER_WRAPPER:
_EI_16_HANDLER_WRAPPER:
_EI_17_HANDLER_WRAPPER:
_EI_18_HANDLER_WRAPPER:
_EI_19_HANDLER_WRAPPER:
_EI_20_HANDLER_WRAPPER:
_EI_21_HANDLER_WRAPPER:
_EI_22_HANDLER_WRAPPER:
_EI_23_HANDLER_WRAPPER:
_EI_24_HANDLER_WRAPPER:
_EI_25_HANDLER_WRAPPER:
_EI_26_HANDLER_WRAPPER:
_EI_27_HANDLER_WRAPPER:
_EI_28_HANDLER_WRAPPER:
_EI_29_HANDLER_WRAPPER:
_EI_30_HANDLER_WRAPPER:
_EI_31_HANDLER_WRAPPER:
	addi sp, sp, -32*REGBYTES

	/* Save caller registers */
	STORE x1, 0*REGBYTES(sp)
	STORE x4, 1*REGBYTES(sp)
	STORE x5, 2*REGBYTES(sp)
	STORE x6, 3*REGBYTES(sp)
	STORE x7, 4*REGBYTES(sp)
	STORE x10, 5*REGBYTES(sp)
	STORE x11, 6*REGBYTES(sp)
	STORE x12, 7*REGBYTES(sp)
	STORE x13, 8*REGBYTES(sp)
	STORE x14, 9*REGBYTES(sp)
	STORE x15, 10*REGBYTES(sp)
#ifndef __riscv_32e
	STORE x16, 11*REGBYTES(sp)
	STORE x17, 12*REGBYTES(sp)
	STORE x28, 13*REGBYTES(sp)
	STORE x29, 14*REGBYTES(sp)
	STORE x30, 15*REGBYTES(sp)
	STORE x31, 16*REGBYTES(sp)
#endif

	/* Save mstatus and mepc */
	csrr t0, mepc
	csrr t1, mstatus
	csrr t2, mxstatus

	STORE t0, 17*REGBYTES(sp)
	STORE t1, 18*REGBYTES(sp)
	STORE t2, 19*REGBYTES(sp)

	/* Call machine external interrupt handler */
	csrr a0, mcause
	csrr a1, mtvec
	andi a1, a1, 0x3
	beqz a1, 1f
	andi a0, a0, 0x3ff
	addi a0, a0, -0x12
1:
	call machine_ei_handler

	/* Disable interrupt */
	csrrci a5, mstatus, MSTATUS_MIE

	/* Restore mstatus and mepc */
	LOAD t0, 17*REGBYTES(sp)
	LOAD t1, 18*REGBYTES(sp)
	LOAD t2, 19*REGBYTES(sp)

	csrw mepc, t0
	csrw mstatus, t1
	csrw mxstatus, t2

	/* Restore caller registers */
	LOAD x1, 0*REGBYTES(sp)
	LOAD x4, 1*REGBYTES(sp)
	LOAD x5, 2*REGBYTES(sp)
	LOAD x6, 3*REGBYTES(sp)
	LOAD x7, 4*REGBYTES(sp)
	LOAD x10, 5*REGBYTES(sp)
	LOAD x11, 6*REGBYTES(sp)
	LOAD x12, 7*REGBYTES(sp)
	LOAD x13, 8*REGBYTES(sp)
	LOAD x14, 9*REGBYTES(sp)
	LOAD x15, 10*REGBYTES(sp)
#ifndef __riscv_32e
	LOAD x16, 11*REGBYTES(sp)
	LOAD x17, 12*REGBYTES(sp)
	LOAD x28, 13*REGBYTES(sp)
	LOAD x29, 14*REGBYTES(sp)
	LOAD x30, 15*REGBYTES(sp)
	LOAD x31, 16*REGBYTES(sp)
#endif

	addi sp, sp, 32*REGBYTES
	mret

.align 12
_trap_entry_vclic:
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	m_trap_entry
	.word	_EI_1_HANDLER_WRAPPER
	.word	_EI_2_HANDLER_WRAPPER
	.word	_EI_3_HANDLER_WRAPPER
	.word	_EI_4_HANDLER_WRAPPER
	.word	_EI_5_HANDLER_WRAPPER
	.word	_EI_6_HANDLER_WRAPPER
	.word	_EI_7_HANDLER_WRAPPER
	.word	_EI_8_HANDLER_WRAPPER
	.word	_EI_9_HANDLER_WRAPPER
	.word	_EI_10_HANDLER_WRAPPER
	.word	_EI_11_HANDLER_WRAPPER
	.word	_EI_12_HANDLER_WRAPPER
	.word	_EI_13_HANDLER_WRAPPER
	.word	_EI_14_HANDLER_WRAPPER
	.word	_EI_15_HANDLER_WRAPPER
	.word	_EI_16_HANDLER_WRAPPER
	.word	_EI_17_HANDLER_WRAPPER
	.word	_EI_18_HANDLER_WRAPPER
	.word	_EI_19_HANDLER_WRAPPER
	.word	_EI_20_HANDLER_WRAPPER
	.word	_EI_21_HANDLER_WRAPPER
	.word	_EI_22_HANDLER_WRAPPER
	.word	_EI_23_HANDLER_WRAPPER
	.word	_EI_24_HANDLER_WRAPPER
	.word	_EI_25_HANDLER_WRAPPER
	.word	_EI_26_HANDLER_WRAPPER
	.word	_EI_27_HANDLER_WRAPPER
	.word	_EI_28_HANDLER_WRAPPER
	.word	_EI_29_HANDLER_WRAPPER
	.word	_EI_30_HANDLER_WRAPPER
	.word	_EI_31_HANDLER_WRAPPER

