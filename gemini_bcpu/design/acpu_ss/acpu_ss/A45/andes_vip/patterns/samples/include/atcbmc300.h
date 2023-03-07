#ifndef __ATCBMC300_H
#define __ATCBMC300_H

#include <inttypes.h>
#include "general.h"

// ======================================================
// ATCBMC300 register definition
// ======================================================
// ATCBMC300 registers
typedef struct {
	__IO uint32_t IDREV;		// (0x00) ID and revision register
	__IO uint32_t RESERVED0[3];	// (0x04 ~ 0x0c) reserved register
	__IO uint32_t PR;		// (0x10) priority register
	__IO uint32_t RESERVED1[59];	// (0x14~0xfc) reserved registers
	__IO uint64_t SLV[32];		// (0x100~0x1fc) AXI slave 1~31 base/size registers (64 bits)
} ATCBMC300_RegDef;

// ATCBMC300 ID and revision register
#define ATCBMC300_VER_MINOR_MASK	(BIT_MASK(3, 0))	// minor revision
#define ATCBMC300_VER_MINOR_OFFSET	(0)
#define ATCBMC300_VER_MINOR_DEFAULT	(0x0)
#define ATCBMC300_VER_MAJOR_MASK	(BIT_MASK(7, 4))	// major revision
#define ATCBMC300_VER_MAJOR_OFFSET	(4)
#define ATCBMC300_VER_MAJOR_DEFAULT	(0x0)
#define ATCBMC300_VER_ID_MASK		(BIT_MASK(31, 8))	// ID
#define ATCBMC300_VER_ID_OFFSET		(8)
#define ATCBMC300_VER_ID_DEFAULT	(0x000030)
#define ATCBMC300_VER_DEFAULT		(\
					ATCBMC300_DEFAULT(VER, MINOR) |\
					ATCBMC300_DEFAULT(VER, MAJOR) |\
					ATCBMC300_DEFAULT(VER, ID) \
					)

// ATCBMC300 priority register
#define ATCBMC300_PR_PRELOAD_MASK	(BIT_MASK(15, 0))	// priority reload value
#define ATCBMC300_PR_PRELOAD_OFFSET	(0)
#define ATCBMC300_PR_PRELOAD_DEFAULT	(0xf)
#define ATCBMC300_PR_PHIGH0_MASK	(BIT_MASK(31, 31))	// force master is higher priority
#define ATCBMC300_PR_PHIGH0_OFFSET	(31)
#define ATCBMC300_PR_PHIGH0_DEFAULT	(0x0)
#define ATCBMC300_PR_DEFAULT		(\
					ATCBMC300_DEFAULT(PR, PRELOAD) |\
					ATCBMC300_DEFAULT(PR, PHIGH0) \
					)

// ATCBMC300 AIX slave 0~31 base/size register (64 bits)
#define ATCBMC300_SLV_SIZE_MASK		(BIT_MASK(7, 0))	// size of the address space
#define ATCBMC300_SLV_SIZE_OFFSET	(0)
#define ATCBMC300_SLV_SIZE_DEFAULT	(0x0)			// depend on the configuration
#define ATCBMC300_SLV_BASE_MSB		(31)			// base address MSB (32-bit address mode) (fixme in 40/64-bit address mode)
#define ATCBMC300_SLV_BASE_MASK		(BIT_MASK(ATCBMC300_SLV_BASE_MSB, 20))	// base address
#define ATCBMC300_SLV_BASE_OFFSET	(20)
#define ATCBMC300_SLV_BASE_DEFAULT	(0x0)			// depend on the configuration
#define ATCBMC300_SLV_DEFAULT		(\
					ATCBMC300_DEFAULT(SLV, SIZE) |\
					ATCBMC300_DEFAULT(SLV, BASE) \
					)

#define ATCBMC300_SLV_MASK		(\
					ATCBMC300_SLV_SIZE_MASK |\
					ATCBMC300_SLV_BASE_MASK \
					)

// ======================================================
// ATCBMC300 access macro 
// ======================================================
#define ATCBMC300_SET_FIELD(var, reg, field, value)	SET_FIELD(var, ATCBMC300_##reg##_##field##_##MASK, ATCBMC300_##reg##_##field##_##OFFSET, value)
#define ATCBMC300_GET_FIELD(var, reg, field)		GET_FIELD(var, ATCBMC300_##reg##_##field##_##MASK, ATCBMC300_##reg##_##field##_##OFFSET)
#define ATCBMC300_TEST_FIELD(var, reg, field)		TEST_FIELD(var, ATCBMC300_##reg##_##field##_##MASK)

#define ATCBMC300_EXTRACT(reg, field, value)		EXTRACT_FIELD(value, ATCBMC300_##reg##_##field##_##MASK, ATCBMC300_##reg##_##field##_##OFFSET )
#define ATCBMC300_PREPARE(reg, field, value)		PREPARE_FIELD(value, ATCBMC300_##reg##_##field##_##MASK, ATCBMC300_##reg##_##field##_##OFFSET )

#define ATCBMC300_DEFAULT(reg, field)			PREPARE_FIELD(ATCBMC300_##reg##_##field##_##DEFAULT, ATCBMC300_##reg##_##field##_##MASK, ATCBMC300_##reg##_##field##_##OFFSET )

#endif // __ATCBMC300_H

