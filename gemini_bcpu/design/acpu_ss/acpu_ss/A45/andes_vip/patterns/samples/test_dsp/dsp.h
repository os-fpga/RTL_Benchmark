#include <inttypes.h>

#include "ndslib.h"
#include "core_v5.h"
#include "interrupt.h"

void pre_check_dsp(void);

#undef __nds__clrov
#undef __nds__rdov
__attribute__( ( always_inline ) ) static inline unsigned int __nds__rdov(void) {
	unsigned int result;
	asm volatile ("\tcsrrs %0, 0x801, x0" : "=r" (result) :: "memory");
	return(result);
}
__attribute__( ( always_inline ) ) static inline void __nds__clrov(void) {
	asm volatile("csrrci x0, 0x801, 1" ::: "memory");
}



__attribute__( ( always_inline ) ) static inline int __nds__maddr32 (int res, int rs1, int rs2) {
	res = res + (rs1 * rs2);
	return res;
}//no spec, compiler team offer

__attribute__( ( always_inline ) ) static inline int __nds__msubr32 (int res, int rs1, int rs2) {
	res = res - (rs1 * rs2);
	return res;
}//no spec, compiler team offer

__attribute__( ( always_inline ) ) static inline unsigned long long __nds__mulr64 (unsigned int rs1, unsigned int rs2) {
	unsigned long long res;
	asm volatile ("mulr64 %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//no spec, compiler team offer fail in 64bit
__attribute__( ( always_inline ) ) static inline long long __nds__mulsr64 (int rs1, int rs2) {
	long long res;
	asm volatile ("mulsr64 %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//no spec, compiler team offer fail in 64bit



#if __riscv_xlen == 64


__attribute__( ( always_inline ) ) static inline long __nds__sraiw_u(int rs1, unsigned int imm) {
	long res;
	asm volatile ("sraiw.u %0, %1, %2" : "=r" (res) : "r"(rs1), "i"(imm): "memory");
	return res;
}//in spec, compiler not support yet

#undef __nds__sadd64
#undef __nds__ssub64
#undef __nds__smsr64
#undef __nds__uraddw
#undef __nds__smul8
#undef __nds__smulx8
#undef __nds__umul8
#undef __nds__umulx8
#undef __nds__ursubw
#undef __nds__ukaddw
__attribute__( ( always_inline ) ) static inline long long __nds__sadd64 (long long rs1, long long rs2) {
	long long res;
	asm volatile ("add64 %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail
__attribute__( ( always_inline ) ) static inline long long __nds__ssub64 (long long rs1, long long rs2) {
	long long res;
	asm volatile ("sub64 %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail
__attribute__( ( always_inline ) ) static inline long long __nds__smsr64 (long long res, long rs1, long rs2) {
	asm volatile ("smsr64 %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail
__attribute__( ( always_inline ) ) static inline unsigned long __nds__uraddw(unsigned int rs1, unsigned int rs2) {
	unsigned long res;
	asm volatile ("uraddw %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail
__attribute__( ( always_inline ) ) static inline unsigned long long __nds__smul8(unsigned int rs1, unsigned int rs2) {
	unsigned long long res;
	asm volatile ("smul8 %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail
__attribute__( ( always_inline ) ) static inline unsigned long long __nds__smulx8(unsigned int rs1, unsigned int rs2) {
	unsigned long long res;
	asm volatile ("smulx8 %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail
__attribute__( ( always_inline ) ) static inline unsigned long long __nds__umul8(unsigned int rs1, unsigned int rs2) {
	unsigned long long res;
	asm volatile ("umul8 %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail
__attribute__( ( always_inline ) ) static inline unsigned long long __nds__umulx8(unsigned int rs1, unsigned int rs2) {
	unsigned long long res;
	asm volatile ("umulx8 %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail
__attribute__( ( always_inline ) ) static inline unsigned long __nds__ursubw(unsigned int rs1, unsigned int rs2) {
	unsigned long res;
	asm volatile ("ursubw %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail
__attribute__( ( always_inline ) ) static inline unsigned long __nds__ukaddw(unsigned int rs1, unsigned int rs2) {
	unsigned long res;
	asm volatile ("ukaddw %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail


__attribute__( ( always_inline ) ) static inline unsigned long __nds__wexti(long long rs1, unsigned int imm) {
	unsigned long res;
	asm volatile ("wexti %0, %1, %2" : "=r" (res) : "r"(rs1), "i"(imm): "memory");
	return res;
}//in spec, compiler intrinsic fail, now differ with spec

#else

#undef __nds__kmmwt2
#undef __nds__kmmwt2_u
__attribute__( ( always_inline ) ) static inline long __nds__kmmwt2 (long rs1, unsigned long rs2) {
	long res;
	asm volatile ("kmmwt2 %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail, now differ with spec
__attribute__( ( always_inline ) ) static inline long __nds__kmmwt2_u (long rs1, unsigned long rs2) {
	long res;
	asm volatile ("kmmwt2.u %0, %1, %2" : "=r" (res) : "r"(rs1), "r"(rs2): "memory");
	return res;
}//in spec, compiler intrinsic fail, now differ with spec

#endif


