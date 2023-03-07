#ifndef __ATCBUSDEC200_H
#define __ATCBUSDEC200_H

#include <inttypes.h>
#include "general.h"

// ======================================================
// ATCBUSDEC200 register definition
// ======================================================
// ATCBUSDEC200 registers
typedef struct {
	__I  uint32_t IDREV;			// (0x00) ID and revision register
	__IO uint32_t RESERVED0[7];		// (0x04 ~ 0x1c) reserved register
	__IO uint32_t SLV[31];			// (0x20~0x98) Slave 1~31 base/size registers
} ATCBUSDEC200_RegDef;

// ATCBUSDEC200 ID and revision register
#define ATCBUSDEC200_VER_MINOR_MASK	(BIT_MASK(3, 0))	// minor revision
#define ATCBUSDEC200_VER_MINOR_OFFSET	(0)
#define ATCBUSDEC200_VER_MINOR_DEFAULT	(0x0)
#define ATCBUSDEC200_VER_MAJOR_MASK	(BIT_MASK(7, 4))	// major revision
#define ATCBUSDEC200_VER_MAJOR_OFFSET	(4)
#define ATCBUSDEC200_VER_MAJOR_DEFAULT	(0x0)
#define ATCBUSDEC200_VER_ID_MASK	(BIT_MASK(31, 8))	// ID
#define ATCBUSDEC200_VER_ID_OFFSET	(8)
#define ATCBUSDEC200_VER_ID_DEFAULT	(0x000320)
#define ATCBUSDEC200_VER_DEFAULT		(\
					ATCBUSDEC200_DEFAULT(VER, MINOR) |\
					ATCBUSDEC200_DEFAULT(VER, MAJOR) |\
					ATCBUSDEC200_DEFAULT(VER, ID) \
					)

// ATCBUSDEC200 slave 0~31 base/size register
#define ATCBUSDEC200_SLV_SIZE_MASK	(BIT_MASK(3, 0))	// size of the address space
#define ATCBUSDEC200_SLV_SIZE_OFFSET	(0)
#define ATCBUSDEC200_SLV_SIZE_DEFAULT	(0x0)			// depend on the configuration
#define ATCBUSDEC200_SLV_BASE_MASK	(BIT_MASK(31, 20))	// base address
#define ATCBUSDEC200_SLV_BASE_OFFSET	(20)			// (FIXME: in 24-bit mode.)
#define ATCBUSDEC200_SLV_BASE_DEFAULT	(0x0)			// depend on the configuration
#define ATCBUSDEC200_SLV_DEFAULT		(\
					ATCBUSDEC200_DEFAULT(SLV, SIZE) |\
					ATCBUSDEC200_DEFAULT(SLV, BASE) \
					)

#define ATCBUSDEC200_SLV_MASK		(\
					ATCBUSDEC200_SLV_SIZE_MASK |\
					ATCBUSDEC200_SLV_BASE_MASK \
					)

// ======================================================
// ATCBUSDEC200 access macro 
// ======================================================
#define ATCBUSDEC200_SET_FIELD(var, reg, field, value)	SET_FIELD(var, ATCBUSDEC200_##reg##_##field##_##MASK, ATCBUSDEC200_##reg##_##field##_##OFFSET, value)
#define ATCBUSDEC200_GET_FIELD(var, reg, field)		GET_FIELD(var, ATCBUSDEC200_##reg##_##field##_##MASK, ATCBUSDEC200_##reg##_##field##_##OFFSET)
#define ATCBUSDEC200_TEST_FIELD(var, reg, field)	TEST_FIELD(var, ATCBUSDEC200_##reg##_##field##_##MASK)

#define ATCBUSDEC200_EXTRACT(reg, field, value)		EXTRACT_FIELD(value, ATCBUSDEC200_##reg##_##field##_##MASK, ATCBUSDEC200_##reg##_##field##_##OFFSET )
#define ATCBUSDEC200_PREPARE(reg, field, value)		PREPARE_FIELD(value, ATCBUSDEC200_##reg##_##field##_##MASK, ATCBUSDEC200_##reg##_##field##_##OFFSET )

#define ATCBUSDEC200_DEFAULT(reg, field)		PREPARE_FIELD(ATCBUSDEC200_##reg##_##field##_##DEFAULT, ATCBUSDEC200_##reg##_##field##_##MASK, ATCBUSDEC200_##reg##_##field##_##OFFSET )

#endif // __ATCBUSDEC200_H

