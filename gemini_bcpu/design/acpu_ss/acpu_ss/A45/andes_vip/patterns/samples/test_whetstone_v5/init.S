
#include "core_v5.h"

#define AHBDEC_BASE   0x00000000E0000000
#define SIM_CTL_BASE  (AHBDEC_BASE + 0x80000)

	.set VPE_PASS, 0x01234568
	.set VPE_FAIL, 0x01234569
	.set VPE_SKIP, 0x01234571

	.macro ProgramExit
		li	t0, SIM_CTL_BASE
		li	t1, VPE_PASS
		sw	t1, 0(t0)
	16:
		j	16b
	.endm

	.macro ProgramAbort
		li	t0, SIM_CTL_BASE
		li	t1, VPE_FAIL
		sw	t1, 0(t0)
	17:
		j	17b
	.endm

	.macro ProgramExitWFI
		li	t0, SIM_CTL_BASE
		li	t1, VPE_PASS
		sw	t1, 0(t0)
		wfi
	.endm

	.macro ProgramSkip
		li	t0, SIM_CTL_BASE
		li	t1, VPE_SKIP
		sw	t1, 0(t0)
	18:
		j	18b
	.endm

	.globl __platform_init
	.type __platform_init,@function
	.globl trap_handler
	.type trap_handler,@function
	.globl reset_handler
	.type reset_handler,@function

.section .loader,"ax"
	LOAD	t0, __start_addr
	jr	t0
.p2align 3
__start_addr:
	.dword _start
.text

__platform_init:
	# Only hart0 runs main program because the program doesn't support multi-harts
	csrr	t0, mhartid
	beqz	t0, ilm_check
	ProgramExitWFI

       # Turn on ILM/DLM after checking micm_cfg & mdcm_cfg
ilm_check:
       csrr    t0, micm_cfg
       srli    t0, t0, 15
       andi    t0, t0, 0x3f
       beqz    t0, dlm_check
ilm_tunon:
       csrsi   milmb, 0x1

dlm_check:
       csrr    t0, mdcm_cfg
       srli    t0, t0, 15
       andi    t0, t0, 0x3f
       beqz    t0, init_rodata
dlm_tunon:
       csrsi   mdlmb, 0x1

init_rodata:
	# init rodata
	la	t0, .rodata
	la	t1, rodata_lma
	la	a0, rodata_end
1:
	lw	s0, (t1)
	sw	s0, (t0)
	addi	t1, t1, 4
	addi	t0, t0, 4
	blt	t0, a0, 1b

	# Turn on I/D Cache after checking micm_cfg & mdcm_cfg
ic_check:
	csrr	t0, micm_cfg
	srli	t0, t0, 6
	andi	t0, t0, 0x7
	beqz	t0, dc_check
ic_turnon:
	csrr	t0, mcache_ctl
	ori	t0, t0, 0x1
	csrw	mcache_ctl, t0
dc_check:
	csrr	t0, mdcm_cfg
	srli	t0, t0, 6
	andi	t0, t0, 0x7
	beqz	t0, end_of_cacheset
dc_turnon:
	csrr	t0, mcache_ctl
	ori	t0, t0, 0x2
	csrw	mcache_ctl, t0
end_of_cacheset:

	ret

trap_handler:
	ProgramAbort

# printf()
	.align	2
	.globl	printf
	.func	printf
	.type	printf, @function
printf:
	ret
	.endfunc	# printf
	.size	printf, .-printf

# iprintf()
	.align	2
	.globl	iprintf
	.func	iprintf
	.type	iprintf, @function
iprintf:
	ret
	.endfunc	 # iprintf
	.size	iprintf, .-iprintf

# puts()
	.align	2
	.globl	puts
	.func	puts
	.type	puts, @function
puts:
	ret
	.endfunc	# puts
	.size	puts, .-puts

# putchar()
	.align	2
	.globl	putchar
	.func	putchar
	.type	putchar, @function
putchar:
	ret
	.endfunc	# putchar
	.size	putchar, .-putchar

####################################################################################
# scanf()
	.align	2
	.globl	scanf
	.func	scanf
	.type	scanf, @function
scanf:
	li	a0, 100
	sw	a0, 0(a1)
	ret
	.endfunc	# scanf
	.size	scanf, .-scanf

####################################################################################
#	.align	2
#	.globl	strcmp
#	.func	strcmp
#	.type	strcmp, @function
#strcmp:
#	ret
#	.endfunc	# strcmp
#	.size	strcmp, .-strcmp

####################################################################################
# time()
	.align	2
	.globl	time
	.func	time
	.type	time, @function
time:
	ret
	.endfunc	# time
	.size	time, .-time
####################################################################################
# malloc()
#	.align	2
#	.globl	malloc
#	.func	malloc
#	.type	malloc, @function
#malloc:
#	la	a1, malloc_ptr
#if __riscv_xlen == 64
#	ld	a0, 0(a1)
#	addi	a2, a0, 256
#	sd	a2, 0(a1)
#else
#	lw	a0, 0(a1)
#	addi	a2, a0, 256
#	sw	a2, 0(a1)
#endif
#	ret

.align 2
reset_handler:
	la	a0, stack + 4096
	mv	sp, a0


	#--------------------------------#
	#--- Extension Context status ---#
	#--------------------------------#
        # FPU handeling
        csrr    t0, misa
        andi    t0, t0, 0x28        # detect d and f extension
        beqz    t0, program_skip

	.set	MSTATUS_FS_MASK,	(0x3 << 13) # mstatus[14:13]
	.set	MSTATUS_FS_INIT,	(0x1 << 13)
        csrr    t0, mstatus
        li      t1, MSTATUS_FS_MASK
	xori    t1, t1, -1      # create clear mask
	and	t0, t0, t1      # clear mstatus.fs
        li      t1, MSTATUS_FS_INIT
	xor	t0, t0, t1      # set   mstatus.fs = INIT
        csrw    mstatus, t0
init_extension_end:

	fmv.w.x	f0, zero
	fmv.w.x f1, zero
        fmv.w.x f2, zero
        fmv.w.x f3, zero
        fmv.w.x f4, zero
        fmv.w.x f5, zero
        fmv.w.x f6, zero
        fmv.w.x f7, zero
        fmv.w.x f8, zero
        fmv.w.x f9, zero
        fmv.w.x f10, zero
        fmv.w.x f11, zero
        fmv.w.x f12, zero
        fmv.w.x f13, zero
        fmv.w.x f14, zero
        fmv.w.x f15, zero
        fmv.w.x f16, zero
        fmv.w.x f17, zero
        fmv.w.x f18, zero
        fmv.w.x f19, zero
        fmv.w.x f20, zero
        fmv.w.x f21, zero
        fmv.w.x f22, zero
        fmv.w.x f23, zero
        fmv.w.x f24, zero
        fmv.w.x f25, zero
        fmv.w.x f26, zero
        fmv.w.x f27, zero
        fmv.w.x f28, zero
        fmv.w.x f29, zero
        fmv.w.x f30, zero
        fmv.w.x f31, zero
	
	jal	main

program_end:
	ProgramExit

program_skip:
	jal ProgramSkipUser
#	ProgramSkip

####################################################################################
# Heap and Stack
.data
#malloc_ptr:
##if __riscv_xlen == 64
#	.dword	malloc_base
##else
#	.word	malloc_base
##endif
#
#.align 10
#malloc_base:
#	.space	1024
#
.align 10
stack:
	.space	4096
