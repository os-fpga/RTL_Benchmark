#ifndef __ATFLCDC100_H
#define __ATFLCDC100_H

#include <inttypes.h>
#include "general.h"
#include "ndslib.h"
// ======================================================
// ATFLCDC100 register definition
// ======================================================
typedef struct atflcdc100_reg_t {
	__IO uint32_t LCDTIMING0;       // (0x00) LCD horizontal timing control 
	__IO uint32_t LCDTIMING1;       // (0x04) LCD vertical timing control
	__IO uint32_t LCDTIMING2;       // (0x08) LCD clock and signal polarity control
	__IO uint32_t RESERVED0;
	__IO uint32_t LCDFRAMEBASE;    // (0x10) LCD panel frame base address
	__IO uint32_t RESERVED1;
	__IO uint32_t LCDINTEN;         // (0x18) LCD interrupt enable mask
	__IO uint32_t LCDCONTROL;       // (0x1c) LCD panel pixel parameters
	__IO uint32_t LCDINTCLR;        // (0x20) LCD interrupt clear
	__O  uint32_t LCDINT;           // (0x24) LCD final masked interrupts
	__IO uint32_t RESERVED2[3];
	__IO uint32_t OSDCONTROL0;      // (0x34) OSD scaling and dimension control
	__IO uint32_t OSDCONTROL1;      // (0x38) OSD position control
	__IO uint32_t OSDCONTROL2;      // (0x3c) OSD foreground color control
	__IO uint32_t OSDCONTROL3;      // (0x40) OSD background color control
	__IO uint32_t GPIOCONTROL;      // (0x44) GPI/GPO control
} ATFLCDC100_RegDef;

// 0x00: LCD horizontal timing control
#define ATFLCDC100_TM0_HBP_MASK    (BIT_MASK(31, 24))
#define ATFLCDC100_TM0_HBP_OFFSET  (24)
#define ATFLCDC100_TM0_HFP_MASK    (BIT_MASK(23, 16))
#define ATFLCDC100_TM0_HFP_OFFSET  (16)
#define ATFLCDC100_TM0_HW_MASK     (BIT_MASK(15, 8))
#define ATFLCDC100_TM0_HW_OFFSET   (8)
#define ATFLCDC100_TM0_PL_MASK     (BIT_MASK(7, 2))
#define ATFLCDC100_TM0_PL_OFFSET   (2)

// 0x04: LCD vertical timing control
#define ATFLCDC100_TM1_VBP_MASK    (BIT_MASK(31, 24))
#define ATFLCDC100_TM1_VBP_OFFSET  (24)
#define ATFLCDC100_TM1_VFP_MASK    (BIT_MASK(23, 16))
#define ATFLCDC100_TM1_VFP_OFFSET  (16)
#define ATFLCDC100_TM1_VW_MASK     (BIT_MASK(15, 10))
#define ATFLCDC100_TM1_VW_OFFSET   (10)
#define ATFLCDC100_TM1_LF_MASK     (BIT_MASK(9, 0))
#define ATFLCDC100_TM1_LF_OFFSET   (0)

// 0x08: LCD clock and signal polarity control
#define ATFLCDC100_TM2_ADPEN_MASK     (BIT_MASK(15, 15))
#define ATFLCDC100_TM2_ADPEN_OFFSET   (15)
#define ATFLCDC100_TM2_IDE_MASK       (BIT_MASK(14, 14))
#define ATFLCDC100_TM2_IDE_OFFSET     (14)
#define ATFLCDC100_TM2_ICK_MASK       (BIT_MASK(13, 13))
#define ATFLCDC100_TM2_ICK_OFFSET     (13)
#define ATFLCDC100_TM2_IHS_MASK       (BIT_MASK(12, 12))
#define ATFLCDC100_TM2_IHS_OFFSET     (12)
#define ATFLCDC100_TM2_IVS_MASK       (BIT_MASK(11, 11))
#define ATFLCDC100_TM2_IVS_OFFSET     (11)
#define ATFLCDC100_TM2_DIVNO_MASK     (BIT_MASK(5, 0))
#define ATFLCDC100_TM2_DIVNO_OFFSET   (0)

// 0x10: LCD panel frame base address
#define ATFLCDC100_FB_BASE_MASK     (BIT_MASK(31, 6))
#define ATFLCDC100_FB_BASE_OFFSET   (6)
#define ATFLCDC100_FB_SIZE_MASK     (BIT_MASK(5, 0))
#define ATFLCDC100_FB_SIZE_OFFSET   (0)

// 0x18: LCD interrupt enable mask
#define ATFLCDC100_INTEN_BUSERR_MASK     (BIT_MASK(4, 4))
#define ATFLCDC100_INTEN_BUSERR_OFFSET   (4)
#define ATFLCDC100_INTEN_VST_MASK        (BIT_MASK(3, 3))
#define ATFLCDC100_INTEN_VST_OFFSET      (3)
#define ATFLCDC100_INTEN_NXTBASE_MASK    (BIT_MASK(2, 2))
#define ATFLCDC100_INTEN_NXTBASE_OFFSET  (2)
#define ATFLCDC100_INTEN_FIFOUDN_MASK    (BIT_MASK(1, 1))
#define ATFLCDC100_INTEN_FIFOUDN_OFFSET  (1)

// 0x1C: LCD panel pixel parameters
#define ATFLCDC100_LCDCTL_ENYCBCR_MASK    (BIT_MASK(18, 18))
#define ATFLCDC100_LCDCTL_ENYCBCR_OFFSET  (18)
#define ATFLCDC100_LCDCTL_EN420_MASK      (BIT_MASK(17, 17))
#define ATFLCDC100_LCDCTL_EN420_OFFSET    (17)
#define ATFLCDC100_LCDCTL_FIFOTH_MASK     (BIT_MASK(16, 16))
#define ATFLCDC100_LCDCTL_FIFOTH_OFFSET   (16)
#define ATFLCDC100_LCDCTL_PTYPE_MASK      (BIT_MASK(15, 15))
#define ATFLCDC100_LCDCTL_PTYPE_OFFSET    (15)
#define ATFLCDC100_LCDCTL_VCOMP_MASK      (BIT_MASK(13, 12))
#define ATFLCDC100_LCDCTL_VCOMP_OFFSET    (12)
#define ATFLCDC100_LCDCTL_LCDON_MASK      (BIT_MASK(11, 11))
#define ATFLCDC100_LCDCTL_LCDON_OFFSET    (11)
#define ATFLCDC100_LCDCTL_ENDIAN_MASK     (BIT_MASK(10, 9))
#define ATFLCDC100_LCDCTL_ENDIAN_OFFSET   (9)
#define ATFLCDC100_LCDCTL_BGR_MASK        (BIT_MASK(8, 8))
#define ATFLCDC100_LCDCTL_BGR_OFFSET      (8)
#define ATFLCDC100_LCDCTL_TFT_MASK        (BIT_MASK(5, 5))
#define ATFLCDC100_LCDCTL_TFT_OFFSET      (5)
#define ATFLCDC100_LCDCTL_BPP_MASK        (BIT_MASK(3, 1))
#define ATFLCDC100_LCDCTL_BPP_OFFSET      (1)
#define ATFLCDC100_LCDCTL_LCDEN_MASK      (BIT_MASK(0, 0))
#define ATFLCDC100_LCDCTL_LCDEN_OFFSET    (0)

// 0x20: LiCD interrupt clear
#define ATFLCDC100_INTCLR_BUSERR_MASK     (BIT_MASK(4, 4))
#define ATFLCDC100_INTCLR_BUSERR_OFFSET   (4)
#define ATFLCDC100_INTCLR_VST_MASK        (BIT_MASK(3, 3))
#define ATFLCDC100_INTCLR_VST_OFFSET      (3)
#define ATFLCDC100_INTCLR_NXTBASE_MASK    (BIT_MASK(2, 2))
#define ATFLCDC100_INTCLR_NXTBASE_OFFSET  (2)
#define ATFLCDC100_INTCLR_FIFOUDN_MASK    (BIT_MASK(1, 1))
#define ATFLCDC100_INTCLR_FIFOUDN_OFFSET  (1)

// 0x24: LCD final masked interrupts
#define ATFLCDC100_INTST_BUSERR_MASK     (BIT_MASK(4, 4))
#define ATFLCDC100_INTST_BUSERR_OFFSET   (4)
#define ATFLCDC100_INTST_VST_MASK        (BIT_MASK(3, 3))
#define ATFLCDC100_INTST_VST_OFFSET      (3)
#define ATFLCDC100_INTST_NXTBASE_MASK    (BIT_MASK(2, 2))
#define ATFLCDC100_INTST_NXTBASE_OFFSET  (2)
#define ATFLCDC100_INTST_FIFOUDN_MASK    (BIT_MASK(1, 1))
#define ATFLCDC100_INTST_FIFOUDN_OFFSET  (1)


//#define ATFLCDC100___MASK     (BIT_MASK(, ))
//#define ATFLCDC100___OFFSET   ()

// ======================================================
// ATFLCDC100 access macro 
// ======================================================
#define ATFLCDC100_SET_FIELD(var, reg, field, value) SET_FIELD(var, ATFLCDC100_##reg##_##field##_##MASK, ATFLCDC100_##reg##_##field##_##OFFSET, value)
#define ATFLCDC100_GET_FIELD(var, reg, field)        GET_FIELD(var, ATFLCDC100_##reg##_##field##_##MASK, ATFLCDC100_##reg##_##field##_##OFFSET)
#define ATFLCDC100_TEST_FIELD(var, reg, field)       TEST_FIELD(var, ATFLCDC100_##reg##_##field##_##MASK)

#define ATFLCDC100_TEST_BIT(reg, field, value)       VAR_TEST_BIT(value, ATFLCDC100_##reg##_##field##_##MASK)

#define ATFLCDC100_EXTRACT(reg, field, value)        EXTRACT_FIELD(value, ATFLCDC100_##reg##_##field##_##MASK, ATFLCDC100_##reg##_##field##_##OFFSET )
#define ATFLCDC100_PREPARE(reg, field, value)        PREPARE_FIELD(value, ATFLCDC100_##reg##_##field##_##MASK, ATFLCDC100_##reg##_##field##_##OFFSET )

#define ATFLCDC100_DEFAULT(reg, field)               PREPARE_FIELD(ATFLCDC100_##reg##_##field##_##DEFAULT, ATFLCDC100_##reg##_##field##_##MASK, ATFLCDC100_##reg##_##field##_##OFFSET )

#endif // __ATFLCDC100_H

