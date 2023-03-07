#ifndef	__NCEPLMT100_H
#define	__NCEPLMT100_H

#include <inttypes.h>
#include "general.h"


// ======================================================
// NCEPLMT100 register definition
// ======================================================
// NCEPLMT100 registers

typedef struct {
	__IO uint32_t MTIME[2];		// (0x0  ~ 0x4 ) machine time 
	__IO uint32_t MTIMECMP0[2];	// (0x8  ~ 0xc ) machine time compare
	__IO uint32_t MTIMECMP1[2];	// (0x10 ~ 0x14) machine time compare
	__IO uint32_t MTIMECMP2[2];	// (0x18 ~ 0x1c) machine time compare
	__IO uint32_t MTIMECMP3[2];	// (0x20 ~ 0x24) machine time compare
	__IO uint32_t MTIMECMP4[2];	// (0x28 ~ 0x2c) machine time compare
	__IO uint32_t MTIMECMP5[2];	// (0x30 ~ 0x34) machine time compare
	__IO uint32_t MTIMECMP6[2];	// (0x38 ~ 0x3c) machine time compare
	__IO uint32_t MTIMECMP7[2];	// (0x40 ~ 0x44) machine time compare
} NCEPLMT100_RegDef;

#endif // __NCEPLMT100_H
