#ifndef __ATCAPBBRG100_H
#define __ATCAPBBRG100_H

#include <inttypes.h>
#include "general.h"


// ======================================================
// ATCAPBBRG100 register definition
// ======================================================
// ATCAPBBRG100 registers

typedef struct {
	__IO  uint32_t IDREV;			// (0x00) ID and revision register
	__IO uint32_t RESERVED0[4];		// (0x04 ~ 0x10) reserved register
	__IO uint32_t CTRL;			// (0x14) reserved register
	__IO uint32_t RESERVED1[2];		// (0x18 ~ 0x1c) reserved register
	__IO uint32_t SLV[31];			// (0x20 ~ 0x98) registers
} ATCAPBBRG100_RegDef;

// ATCAPBBRG100 ID and revision register
#define ATCAPBBRG100_VER_MINOR_MASK	(BIT_MASK(3, 0))	// minor revision
#define ATCAPBBRG100_VER_MINOR_OFFSET	(0)
#define ATCAPBBRG100_VER_MINOR_DEFAULT	(0x1)
#define ATCAPBBRG100_VER_MAJOR_MASK	(BIT_MASK(7, 4))	// major revision
#define ATCAPBBRG100_VER_MAJOR_OFFSET	(4)
#define ATCAPBBRG100_VER_MAJOR_DEFAULT	(0x0)
#define ATCAPBBRG100_VER_ID_MASK	(BIT_MASK(31, 8))	// ID
#define ATCAPBBRG100_VER_ID_OFFSET	(8)
#define ATCAPBBRG100_VER_ID_DEFAULT	(0x000210)
#define ATCAPBBRG100_VER_DEFAULT	(\
					ATCAPBBRG100_DEFAULT(VER, MINOR) |\
					ATCAPBBRG100_DEFAULT(VER, MAJOR) |\
					ATCAPBBRG100_DEFAULT(VER, ID) \
					)

// ATCAPBBRG100 control register
#define ATCAPBBRG100_CR_WBUF_EN_MASK	(BIT_MASK(0, 0))	// force master is higher priority
#define ATCAPBBRG100_CR_WBUF_EN_OFFSET	(0)
#define ATCAPBBRG100_CR_WBUF_EN_DEFAULT	(0x0)
#define ATCAPBBRG100_CR_DEFAULT		(\
					ATCAPBBRG100_DEFAULT(CR, WBUF_EN) \
					)

// ATCAPBBRG100 interrupt status register
#define ATCAPBBRG100_SLV_OFFSET_MASK	(BIT_MASK(23, 10))	// Master 0 interrupt status
#define ATCAPBBRG100_SLV_OFFSET_OFFSET	(0)
#define ATCAPBBRG100_SLV_OFFSET_DEFAULT	(0x0)
#define ATCAPBBRG100_SLV_SIZE_MASK	(BIT_MASK(3, 0))	// Master 1 interrupt status
#define ATCAPBBRG100_SLV_SIZE_OFFSET	(0)
#define ATCAPBBRG100_SLV_SIZE_DEFAULT	(0x0)
#define ATCAPBBRG100_SLV_DEFAULT	(\
					ATCAPBBRG100_DEFAULT(SLV, OFFSET) |\
					ATCAPBBRG100_DEFAULT(SLV, SIZE) \
					)


// ======================================================
// ATCAPBBRG100 access macro
// ======================================================
#define ATCAPBBRG100_SET_FIELD(var, reg, field, value)	SET_FIELD(var, ATCAPBBRG100_##reg##_##field##_##MASK, ATCAPBBRG100_##reg##_##field##_##OFFSET, value)
#define ATCAPBBRG100_GET_FIELD(var, reg, field)		GET_FIELD(var, ATCAPBBRG100_##reg##_##field##_##MASK, ATCAPBBRG100_##reg##_##field##_##OFFSET)
#define ATCAPBBRG100_TEST_FIELD(var, reg, field)	TEST_FIELD(var, ATCAPBBRG100_##reg##_##field##_##MASK)

#define ATCAPBBRG100_EXTRACT(reg, field, value)		EXTRACT_FIELD(value, ATCAPBBRG100_##reg##_##field##_##MASK, ATCAPBBRG100_##reg##_##field##_##OFFSET )
#define ATCAPBBRG100_PREPARE(reg, field, value)		PREPARE_FIELD(value, ATCAPBBRG100_##reg##_##field##_##MASK, ATCAPBBRG100_##reg##_##field##_##OFFSET )

#define ATCAPBBRG100_DEFAULT(reg, field)		PREPARE_FIELD(ATCAPBBRG100_##reg##_##field##_##DEFAULT, ATCAPBBRG100_##reg##_##field##_##MASK, ATCAPBBRG100_##reg##_##field##_##OFFSET )

#endif // __ATCAPBBRG100_H

