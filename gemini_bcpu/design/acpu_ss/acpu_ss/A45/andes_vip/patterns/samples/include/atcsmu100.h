#ifndef __ATCSMU100_H
#define __ATCSMU100_H

#include <inttypes.h>
#include "general.h"

typedef struct {
	__IO uint32_t PCS_CFG;			// (0x80 + 0x20*n) Power control slot configuration register
	__IO uint32_t PCS_SCRATCH;		// (0x84 + 0x20*n) Power control slot scratch pad
	__IO uint32_t PCS_MISC;			// (0x88 + 0x20*n) Power control MISC
	__IO uint32_t PCS_MISC2;		// (0x8c + 0x20*n) Reserved for PLS
	__IO uint32_t PCS_WE;			// (0x90 + 0x20*n) Power control slot wake up enable
	__IO uint32_t PCS_CTL;			// (0x94 + 0x20*n) Power control slot control
	__IO uint32_t PCS_STATUS;		// (0x98 + 0x20*n) Power control slot status
	__IO uint32_t RESERVED0;		// (0x9c + 0x20*n) Reserved register
} ATCSMU100_PCS_RegDef;

typedef struct {
	__IO uint32_t SYSTEMVER;		// (0x00) System version
	__IO uint32_t BOARDID;			// (0x04) Timestamp
	__IO uint32_t SYSTEMCFG;		// (0x08) System configuration register
	__IO uint32_t SMUVER;			// (0x0c) SMU version
	__IO uint32_t WRSR;			// (0x10) Wakeup and reset status register
	__IO uint32_t SMUCR;			// (0x14) SMU command register
	__IO uint32_t RESERVED0;		// (0x18) Reserved register
	__IO uint32_t WRMASK;			// (0x1c) Wake up mask register
	__IO uint32_t CER;			// (0x20) Clock enable register
	__IO uint32_t CRR;			// (0x24) System clock ratio register
	__IO uint32_t RESERVED1[2];		// (0x28 ~ 0x2c) Reserved register
	__IO uint32_t PCS_SEL;			// (0x30) Power control slot select
	__IO uint32_t RESERVED2[3];		// (0x34 ~ 0x3c) Reserved register
	__IO uint32_t SCRATCH;			// (0x40) Scratch register
	__IO uint32_t HARTS_RESET_REG;		// (0x44) HARTs reset register
	__IO uint32_t RESERVED3[2];		// (0x48 ~ 0x4c) Reserved register
	__IO uint32_t HART0_RST_VEC;		// (0x50) HART0 reset vector register
	__IO uint32_t HART1_RST_VEC;		// (0x54) HART1 reset vector register
	__IO uint32_t HART2_RST_VEC;		// (0x58) HART2 reset vector register
	__IO uint32_t HART3_RST_VEC;		// (0x5c) HART3 reset vector register
	__IO uint32_t HART0_RST_VEC_HI;		// (0x60) HART0 reset vector high register
	__IO uint32_t HART1_RST_VEC_HI;		// (0x64) HART1 reset vector high register
	__IO uint32_t HART2_RST_VEC_HI;		// (0x68) HART2 reset vector high register
	__IO uint32_t HART3_RST_VEC_HI;		// (0x6c) HART3 reset vector high register
	__IO uint32_t RESERVED4[4];		// (0x70 ~ 0x7c) Reserved register
	ATCSMU100_PCS_RegDef PCS[10];	        // (0x80 ~ 0x1bc) Power control slot
	__IO uint32_t RESERVED5[16];		// (0x1c0 ~ 0x1fc)
	__IO uint32_t HART4_RST_VEC;		// (0x200) HART4 reset vector register
	__IO uint32_t HART5_RST_VEC;		// (0x204) HART5 reset vector register
	__IO uint32_t HART6_RST_VEC;		// (0x208) HART6 reset vector register
	__IO uint32_t HART7_RST_VEC;		// (0x20c) HART7 reset vector register
	__IO uint32_t HART4_RST_VEC_HI;		// (0x210) HART4 reset vector high register
	__IO uint32_t HART5_RST_VEC_HI;		// (0x214) HART5 reset vector high register
	__IO uint32_t HART6_RST_VEC_HI;		// (0x218) HART6 reset vector high register
	__IO uint32_t HART7_RST_VEC_HI;		// (0x21c) HART7 reset vector high register
	__IO uint32_t RESERVED6[888];		// (0x220 ~ 0xffc)reserved register
	__IO uint32_t PINMUX_CTRL0;		// (0x1000) Pinmux Control 0
	__IO uint32_t PINMUX_CTRL1;		// (0x1004) Pinmux Control 1
} ATCSMU100_RegDef;

// ATCSMU100 ID and revision register
#define ATCSMU100_VER_MINOR_MASK	(BIT_MASK(3, 0))	// minor revision
#define ATCSMU100_VER_MINOR_OFFSET	(0)
#define ATCSMU100_VER_MINOR_DEFAULT	(0x0)
#define ATCSMU100_VER_MAJOR_MASK	(BIT_MASK(7, 4))	// major revision
#define ATCSMU100_VER_MAJOR_OFFSET	(4)
#define ATCSMU100_VER_MAJOR_DEFAULT	(0x0)
#define ATCSMU100_VER_ID_MASK		(BIT_MASK(31, 8))	// ID
#define ATCSMU100_VER_ID_OFFSET		(8)
#define ATCSMU100_VER_ID_DEFAULT	(0x000001)
#define ATCSMU100_VER_DEFAULT		(\
					ATCSMU100_DEFAULT(VER, MINOR) |\
					ATCSMU100_DEFAULT(VER, MAJOR) |\
					ATCSMU100_DEFAULT(VER, ID) \
					)

#define AE350_BOARDID_DEFAULT		0x0174b010

#define AE350_PD_ALWAYSON		0x0
#define AE350_PD_PLATFORM0		0x1
#define AE350_PD_PLATFORM1		0x2
#define AE350_PD_CPU0			0x3
#define AE350_PD_CPU1			0x4
#define AE350_PD_CPU2			0x5
#define AE350_PD_CPU3			0x6

#define AE350_SMU_WRSR_DBG		(0x1 << 10)
#define AE350_SMU_WRSR_ALM		(0x1 << 9)
#define AE350_SMU_WRSR_EXT		(0x1 << 8)
#define AE350_SMU_WRSR_SW		(0x1 << 4)
#define AE350_SMU_WRSR_WDT		(0x1 << 3)
#define AE350_SMU_WRSR_HW		(0x1 << 2)
#define AE350_SMU_WRSR_MPOR		(0x1 << 1)
#define AE350_SMU_WRSR_APOR		(0x1)

#define AE350_SMU_SMUCR_SOFT_RESET	0x3c
#define AE350_SMU_SMUCR_STANDBY		0x55
#define AE350_SMU_SMUCR_POWER_OFF	0x5a

#define AE350_SMU_CER_PIT		(0x1 << 10)
#define AE350_SMU_CER_WDT		(0x1 << 9)
#define AE350_SMU_CER_IIC		(0x1 << 8)
#define AE350_SMU_CER_GPIO		(0x1 << 7)
#define AE350_SMU_CER_SPI2		(0x1 << 6)
#define AE350_SMU_CER_SPI1		(0x1 << 5)
#define AE350_SMU_CER_UART2		(0x1 << 4)
#define AE350_SMU_CER_UART1		(0x1 << 3)
#define AE350_SMU_CER_PCLK		(0x1 << 2)
#define AE350_SMU_CER_HCLK		(0x1 << 1)
#define AE350_SMU_CER_CORE		0x1

#define AE350_SMU_CER_ALL		(AE350_SMU_CER_CORE | AE350_SMU_CER_HCLK | AE350_SMU_CER_PCLK | AE350_SMU_CER_UART1 | AE350_SMU_CER_UART2 | AE350_SMU_CER_SPI1 | AE350_SMU_CER_SPI2 | AE350_SMU_CER_GPIO | AE350_SMU_CER_IIC | AE350_SMU_CER_WDT | AE350_SMU_CER_PIT)

#define ATCSMU100_SYSTEMCFG_NHART       (0xff << 0)
#define ATCSMU100_SYSTEMCFG_L2C         (0x1  << 8)

#define ATCSMU100_SYSTEMCR_SYSCLK_SEL   (0x1 << 0)
#define ATCSMU100_SYSTEMCR_BUS_RATIO    (0x7 << 1)

#define ATCSMU100_SYSTEMCR_CCLKSEL_DIV1      0x0
#define ATCSMU100_SYSTEMCR_CCLKSEL_DIV2      0x1

#define ATCSMU100_SYSTEMCR_HPCLKSEL_1_1      (0x0 << 1)
#define ATCSMU100_SYSTEMCR_HPCLKSEL_1_2      (0x1 << 1)
#define ATCSMU100_SYSTEMCR_HPCLKSEL_1_4      (0x2 << 1)
#define ATCSMU100_SYSTEMCR_HPCLKSEL_2_2      (0x3 << 1)
#define ATCSMU100_SYSTEMCR_HPCLKSEL_2_4      (0x4 << 1)

#define ATCSMU100_RESET_VECTOR_DEFAULT  0x0000000080000000

#define ATCSMU100_PCS_CFG_RESET          0x0
#define ATCSMU100_PCS_CFG_DVFS           0x1
#define ATCSMU100_PCS_CFG_LIGHTSLEEP     0x2
#define ATCSMU100_PCS_CFG_DEEPSLEEP      0x3
#define ATCSMU100_PCS_CFG_CANCEL         0x4
#define ATCSMU100_PCS_CFG_TIMEOUT_DETECT 0x5

#define ATCSMU100_PCS_MISC_MEM_INIT3	(0x1    << 31)
#define ATCSMU100_PCS_MISC_MEM_INIT2	(0x1    << 30)
#define ATCSMU100_PCS_MISC_MEM_INIT1	(0x1    << 29)
#define ATCSMU100_PCS_MISC_MEM_INIT0	(0x1    << 28)
#define ATCSMU100_PCS_MISC_TO_CYC	(0xffff << 12)
#define ATCSMU100_PCS_MISC_RETEN_CYC	(0xff   <<  4)
#define ATCSMU100_PCS_MISC_ISO_CYC	(0xf    <<  0)

#define ATCSMU100_PCS_CTL_CMD		(0x7  <<  0)
#define ATCSMU100_PCS_CTL_PARAM		(0x1f <<  3)

#define ATCSMU100_PCS_STATUS_PEND_INT	(0x1  << 31)
#define ATCSMU100_PCS_STATUS_WAKEUP_INT	(0x1  << 30)
#define ATCSMU100_PCS_STATUS_CMD_STATUS	(0x7  <<  8)
#define ATCSMU100_PCS_STATUS_PD_STATUS	(0x1f <<  3)
#define ATCSMU100_PCS_STATUS_PD_TYPE	(0x7  <<  0)

#define ATCSMU100_PCS_STATUS_ACTIVE	0x0
#define ATCSMU100_PCS_STATUS_RESET	0x1
#define ATCSMU100_PCS_STATUS_SLEEP	0x2
#define ATCSMU100_PCS_STATUS_BUSY_WAIT	0x3
#define ATCSMU100_PCS_STATUS_TIMEOUT	0x7
#define ATCSMU100_PCS_STATUS_DEEP	0x10

// ======================================================
// ATCSMU100 access macro
// ======================================================
#define ATCSMU100_SET_FIELD(var, reg, field, value)	SET_FIELD(var, ATCSMU100_##reg##_##field##_##MASK, ATCSMU100_##reg##_##field##_##OFFSET, value)
#define ATCSMU100_GET_FIELD(var, reg, field)		GET_FIELD(var, ATCSMU100_##reg##_##field##_##MASK, ATCSMU100_##reg##_##field##_##OFFSET)
#define ATCSMU100_TEST_FIELD(var, reg, field)		TEST_FIELD(var, ATCSMU100_##reg##_##field##_##MASK)

#define ATCSMU100_EXTRACT(reg, field, value)		EXTRACT_FIELD(value, ATCSMU100_##reg##_##field##_##MASK, ATCSMU100_##reg##_##field##_##OFFSET )
#define ATCSMU100_PREPARE(reg, field, value)		PREPARE_FIELD(value, ATCSMU100_##reg##_##field##_##MASK, ATCSMU100_##reg##_##field##_##OFFSET )

#define ATCSMU100_DEFAULT(reg, field)			PREPARE_FIELD(ATCSMU100_##reg##_##field##_##DEFAULT, ATCSMU100_##reg##_##field##_##MASK, ATCSMU100_##reg##_##field##_##OFFSET )

#define SET_SMU_PINMUX_CTRL0_CF1	0x0
#define SET_SMU_PINMUX_CTRL1_CF1	0x0
#define SET_SMU_PINMUX_CTRL0_ORCA	0x0
#define SET_SMU_PINMUX_CTRL1_ORCA	0xaaa0000a


#endif // __ATCSMU100_H
