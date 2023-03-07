// Address mapping for AE350

#ifndef __AE350_H
#define __AE350_H

#define __I                     volatile const  /* 'read only' permissions      */
#define __O                     volatile        /* 'write only' permissions     */
#define __IO                    volatile        /* 'read / write' permissions   */


//----------------------------------------
// Memory Map
//----------------------------------------
#define SLVPORT_BASE		0xA0000000
#define SLVPORT_DLM_BASE	0xA0200000
#define INTR_BACKUP_BASE	(DDR3_MEM_BASE + 0x00400000)

#define DFS_REG_BASE		0xC0200000

#define SPI1_MEM_BASE		0x80000000
#define SMC_MEM_BASE		0x88000000
#define BMC_BASE		0xC0000000
#define PLIC_BASE		0xE4000000
#define PLMT_BASE		0xE6000000
#define PLMT0_BASE		PLMT_BASE
#define PLMT1_BASE		PLMT_BASE
#define PLMT2_BASE		PLMT_BASE
#define PLMT3_BASE		PLMT_BASE
#define PLMT4_BASE		PLMT_BASE
#define PLMT5_BASE		PLMT_BASE
#define PLMT6_BASE		PLMT_BASE
#define PLMT7_BASE		PLMT_BASE
#define PLIC_SW_BASE		0xE6400000
#define PLDM_BASE		0xE6800000
#define AHBDEC_BASE		0xE0000000
#define DDR3_MEM_BASE		0x0
#define DDR3_MEM_SIZE		0x80000000
#define SPI_MEM_SIZE		0x00100000
#define SIM_CONTROL_BASE	(AHBDEC_BASE + 0x80000)
#define L2C_BASE		0xE0500000
#define MAC_BASE		0xe0100000
#define LCDC_BASE		0xe0200000
#define SMC_REG_BASE		0xe0400000
#define APBBRG_BASE		0xF0000000

// AHB Reserved
#define AHB_RESERVED1_BASE	0xd0000000

// APB devices
#define SMU_BASE		0xF0100000
#define UART1_BASE		0xF0200000
#define UART2_BASE		0xF0300000
#define PIT_BASE		0xF0400000
#define TIMER_BASE		0xF0400000
#define WDT_BASE		0xF0500000
#define RTC_BASE		0xF0600000
#define GPIO_BASE		0xF0700000
#define I2C_BASE		0xF0A00000
#define SPI1_BASE		0xF0B00000
#define DMAC_BASE		0xF0C00000
#define SSP_BASE		(APBBRG_BASE + 0x00d00000)
#define SDC_BASE		(APBBRG_BASE + 0x00e00000)
#define SPI2_BASE		0xF0F00000
#define SPI3_BASE		(APBBRG_BASE + 0x01900000)
#define SPI4_BASE		(APBBRG_BASE + 0x01a00000)
#define I2C2_BASE		(APBBRG_BASE + 0x01b00000)
#define DTROM_BASE		(APBBRG_BASE + 0x02000000)


#ifndef __ASSEMBLER__

#include "atcbmc300.h"
#include "atcdmac300.h"
#include "atcdmac300_pat.h"
#include "atcapbbrg100.h"
#include "atcgpio100.h"
#include "atcrtc100.h"
#include "atcpit100.h"
#include "atcwdt200.h"
#include "atciic100.h"
#include "atcuart100.h"
#include "atcspi200.h"
#include "atcsmu100.h"
#include "cluster.h"
#include "l2c.h"
#include "sim_control.h"
#include "nceplmt100.h"
#include "ncepldm200.h"
#include "nceplic100.h"
#include "atcbusdec200.h"
#include "atfsdc010.h"
#include "atfmac100.h"
#include "atfssp020.h"
#include "atflcdc100.h"
#include "atfsmc020.h"
#include "general.h"


/*
 * Define 'NDS_PLIC_BASE' and 'NDS_PLIC_SW_BASE' before include platform
 * intrinsic header file to active PLIC/PLIC_SW related intrinsic functions.
 */
#define NDS_PLIC_BASE        PLIC_BASE
#define NDS_PLIC_SW_BASE     PLIC_SW_BASE
#include "nds_v5_platform.h"

/*****************************************************************************
 *  * Peripheral device declaration
 ****************************************************************************/
#define AE350_BMC		((ATCBMC300_RegDef *)		BMC_BASE)
#define AE350_DMAC		((ATCDMAC300_RegDef *)		DMAC_BASE)
#define AE350_APBBRG		((ATCAPBBRG100_RegDef *)	APBBRG_BASE)
#define AE350_GPIO		((ATCGPIO100_RegDef *)		GPIO_BASE)
#define AE350_RTC		((ATCRTC100_RegDef *)		RTC_BASE)
#define AE350_PIT		((ATCPIT100_RegDef *)		PIT_BASE)
#define AE350_WDT		((ATCWDT200_RegDef *)		WDT_BASE)
#define AE350_SDC		((ATFSDC010_RegDef *)		SDC_BASE)
#define AE350_MAC		((ATFMAC100_RegDef *)		MAC_BASE)
#define AE350_LCDC		((ATFLCDC100_RegDef *)          LCDC_BASE)
#define AE350_SMC_REG		((ATFSMC020_RegDef *)           SMC_REG_BASE)
#define AE350_IIC		((ATCIIC100_RegDef *)		I2C_BASE)
#define AE350_IIC2		((ATCIIC100_RegDef *)		I2C2_BASE)
#define AE350_UART1		((ATCUART100_RegDef *)		UART1_BASE)
#define AE350_UART2		((ATCUART100_RegDef *)		UART2_BASE)
#define AE350_SPI1		((ATCSPI200_RegDef *)		SPI1_BASE)
#define AE350_SPI2		((ATCSPI200_RegDef *)		SPI2_BASE)
#define AE350_SPI3		((ATCSPI200_RegDef *)		SPI3_BASE)
#define AE350_SPI4		((ATCSPI200_RegDef *)		SPI4_BASE)
#define AE350_SMU		((ATCSMU100_RegDef *)		SMU_BASE)
#define AE350_SIM_CONTROL	((SIM_CONTROL_RegDef *)		SIM_CONTROL_BASE)
#define AE350_PLMT		((NCEPLMT100_RegDef *)		PLMT_BASE)
#define AE350_PLMT0		((NCEPLMT100_RegDef *)		PLMT0_BASE)
#define AE350_PLMT1		((NCEPLMT100_RegDef *)		PLMT1_BASE)
#define AE350_PLMT2		((NCEPLMT100_RegDef *)		PLMT2_BASE)
#define AE350_PLMT3		((NCEPLMT100_RegDef *)		PLMT3_BASE)
#define AE350_PLMT4		((NCEPLMT100_RegDef *)		PLMT4_BASE)
#define AE350_PLMT5		((NCEPLMT100_RegDef *)		PLMT5_BASE)
#define AE350_PLMT6		((NCEPLMT100_RegDef *)		PLMT6_BASE)
#define AE350_PLMT7		((NCEPLMT100_RegDef *)		PLMT7_BASE)
#define AE350_PLDM		((NCEPLDM200_RegDef *)		PLDM_BASE)
#define AE350_SSP		((ATFSSP020_RegDef *)		SSP_BASE)
#define AE350_AHBDEC		((ATCBUSDEC200_RegDef *)	AHBDEC_BASE)
#define AE350_PLIC              ((NCEPLIC100_REG_S *)           PLIC_BASE)
#define AE350_PLIC_SW           ((NCEPLIC100_REG_S *)           PLIC_SW_BASE)

#define AE350_L2C		((L2C_RegDef *)			L2C_BASE)

#define DEV_BMC			AE350_BMC
#define DEV_DMAC		AE350_DMAC
#define DEV_APBBRG		AE350_APBBRG
#define DEV_GPIO		AE350_GPIO
#define DEV_RTC			AE350_RTC
#define DEV_PIT			AE350_PIT
#define DEV_WDT			AE350_WDT
#define DEV_SDC			AE350_SDC
#define DEV_MAC			AE350_MAC
#define DEV_LCDC                AE350_LCDC
#define DEV_SMC_REG             AE350_SMC_REG
#define DEV_IIC			AE350_IIC
#define DEV_IIC2		AE350_IIC2
#define DEV_UART1		AE350_UART1
#define DEV_UART2		AE350_UART2
#define DEV_SPI1		AE350_SPI1
#define DEV_SPI2		AE350_SPI2
#define DEV_SPI3		AE350_SPI3
#define DEV_SPI4		AE350_SPI4
#define DEV_SMU			AE350_SMU
#define DEV_SIM_CONTROL		AE350_SIM_CONTROL
//#define DEV_PLMT		AE350_PLMT
#define DEV_PLDM		AE350_PLDM
#define DEV_SSP			AE350_SSP
#define DEV_AHBDEC		AE350_AHBDEC
#define DEV_PLIC	        AE350_PLIC
#define DEV_PLIC_SW	        AE350_PLIC_SW
#define DEV_L2C			AE350_L2C

// ---------------------------------------
// Trap Context structure
// ---------------------------------------
typedef struct {
	union {
		struct {
			long x1;
			long x4;
			long x5;
			long x6;
			long x7;
			long x10;
			long x11;
			long x12;
			long x13;
			long x14;
			long x15;
			long x16;
			long x17;
			long x28;
			long x29;
			long x30;
			long x31;
		};
		long caller_regs[17];
	};
	long mepc;
	long mstatus;
} SAVED_CONTEXT;
#endif  /* __ASSEMBLER__ */

//----------------------------------------
// Interrupt Number
//----------------------------------------
#define INTERRUPT_NO		32	// Number of HW Interrupts

#define INT_NO_RTC		1
#define INT_NO_RTC_ALARM	2
#define INT_NO_PIT		3
#define INT_NO_TIMER		3
#define INT_NO_SPI1		4
#define INT_NO_SPI2		5
#define INT_NO_I2C		6
#define INT_NO_GPIO		7
#define INT_NO_GPIO0		7
#define INT_NO_GPIO1		7
#define INT_NO_UART1		8
#define INT_NO_UART2		9
#define INT_NO_DMAC		10
#define INT_NO_BMC		11
#define INT_NO_SW		12
#define INT_NO_CPU_LDMA		13
#define INT_NO_SPI3		15
//#define INT_NO_SPI4		16
#define INT_NO_L2		16
#define INT_NO_SSP		17
#define INT_NO_SDC		18
#define INT_NO_MAC		19
#define INT_NO_LCDC		20
#define INT_NO_STANDBY          26
#define INT_NO_WAKEUPOK         27


// ---------------------------------------
// NMI Number
// ---------------------------------------
#define NMI_NO			1	// Number of NMIs

#define NMI_NO_WDT		0

// ---------------------------------------
// General Exception Number
// ---------------------------------------
#define GENERAL_EXC_NO			16

#define GENERAL_EXC_PRECISE_BUS_ERROR	5
#define GENERAL_EXC_IMPRECISE_BUS_ERROR	7

//----------------------------------------
// DMA request number
//----------------------------------------
#define DMA_NO_SPI1_TX		0
#define DMA_NO_SPI1_RX		1
#define DMA_NO_SPI2_TX		2
#define DMA_NO_SPI2_RX		3
#define DMA_NO_UART1_TX		4
#define DMA_NO_UART1_RX		5
#define DMA_NO_UART2_TX		6
#define DMA_NO_UART2_RX		7
#define DMA_NO_I2C		8
#define DMA_NO_SPI3_TX		9
#define DMA_NO_SPI3_RX		10
#define DMA_NO_SPI4_TX		11
#define DMA_NO_SPI4_RX		12
#define DMA_NO_I2C2		13
#define DMA_NO_SDC		DMA_NO_VENDOR_TX

//----------------------------------------
// SMU clock definition
//----------------------------------------
#define SMU_CRR_CCLKSEL_DIV1      0x0
#define SMU_CRR_CCLKSEL_DIV2      0x1

#define SMU_CRR_HPCLKSEL_1_1      (0x0 << 1)
#define SMU_CRR_HPCLKSEL_1_2      (0x1 << 1)
#define SMU_CRR_HPCLKSEL_1_4      (0x2 << 1)
#define SMU_CRR_HPCLKSEL_2_2      (0x3 << 1)
#define SMU_CRR_HPCLKSEL_2_4      (0x4 << 1)

//----------------------------------------
// BUS configuration
//----------------------------------------
#define BUS_DATA_MASK		0xffffffff
#define APB_MASK		0x0fffffff

//----------------------------------------
// SPI testing
//----------------------------------------
#if defined(NDS_SPI4_TEST)
	#define DEV_SPI			DEV_SPI4
	#define INT_NO_SPI		INT_NO_SPI4
	// for slave mode testing
	#define INT_NO_SPI_MASTER	INT_NO_SPI1
	#define INT_NO_SPI_SLAVE	INT_NO_SPI4
	#define DEV_SPI_MASTER		DEV_SPI1
	#define DEV_SPI_SLAVE		DEV_SPI4
#elif defined(NDS_SPI3_TEST)
	#define DEV_SPI			DEV_SPI3
	#define INT_NO_SPI		INT_NO_SPI3
	// for slave mode testing
	#define INT_NO_SPI_MASTER	INT_NO_SPI1
	#define INT_NO_SPI_SLAVE	INT_NO_SPI3
	#define DEV_SPI_MASTER		DEV_SPI1
	#define DEV_SPI_SLAVE		DEV_SPI3
#elif defined(NDS_SPI2_TEST)
	#define DEV_SPI			DEV_SPI2
	#define INT_NO_SPI		INT_NO_SPI2
	// for slave mode testing
	#define INT_NO_SPI_MASTER	INT_NO_SPI1
	#define INT_NO_SPI_SLAVE	INT_NO_SPI2
	#define DEV_SPI_MASTER		DEV_SPI1
	#define DEV_SPI_SLAVE		DEV_SPI2
#else
	#define DEV_SPI			DEV_SPI1
	#define INT_NO_SPI		INT_NO_SPI1
	// for slave mode testing
	#define INT_NO_SPI_MASTER	INT_NO_SPI2
	#define INT_NO_SPI_SLAVE	INT_NO_SPI1
	#define DEV_SPI_MASTER		DEV_SPI2
	#define DEV_SPI_SLAVE		DEV_SPI1
#endif

//----------------------------------------
// UART testing
//----------------------------------------
#ifdef NDS_UART2_TEST
	#define DEV_UART		DEV_UART2
	#define INT_NO_UART		INT_NO_UART2
#else
	#define DEV_UART		DEV_UART1
	#define INT_NO_UART		INT_NO_UART1
#endif

//----------------------------------------
// Multicore testing
//----------------------------------------
#ifdef NDS_AE350_DUALCORE_RUN
	#define NDS_AE350_RUN_ID	0
	#define DEV_PLMT		AE350_PLMT0
#elif NDS_AE350_ALLCORE_RUN
	#define NDS_AE350_RUN_ID	0
	#define DEV_PLMT		AE350_PLMT0
#elif NDS_HART0_RUN
	#define NDS_AE350_RUN_ID	0
	#define DEV_PLMT		AE350_PLMT0
#elif NDS_HART1_RUN
	#define NDS_AE350_RUN_ID	1
	#define DEV_PLMT		AE350_PLMT1
#elif NDS_HART2_RUN
	#define NDS_AE350_RUN_ID	2
	#define DEV_PLMT		AE350_PLMT2
#elif NDS_HART3_RUN
	#define NDS_AE350_RUN_ID	3
	#define DEV_PLMT		AE350_PLMT3
#elif NDS_HART4_RUN
	#define NDS_AE350_RUN_ID	4
	#define DEV_PLMT		AE350_PLMT4
#elif NDS_HART5_RUN
	#define NDS_AE350_RUN_ID	5
	#define DEV_PLMT		AE350_PLMT5
#elif NDS_HART6_RUN
	#define NDS_AE350_RUN_ID	6
	#define DEV_PLMT		AE350_PLMT6
#elif NDS_HART7_RUN
	#define NDS_AE350_RUN_ID	7
	#define DEV_PLMT		AE350_PLMT7
#else
// single-core case
	#define NDS_AE350_RUN_ID	0
	#define DEV_PLMT		AE350_PLMT
#endif

#define NDS_AE350_PLIC_MTGT	(NDS_AE350_RUN_ID * 2)
#define NDS_AE350_PLIC_STGT	((NDS_AE350_RUN_ID * 2) + 1)
#define NDS_AE350_PLICSW_TGT	NDS_AE350_RUN_ID

#ifdef NDS_AE350_DUALCORE_RUN
	#define DUALCORE_RUN		1
#else
	#define DUALCORE_RUN		0
#endif

#ifdef NDS_AE350_ALLCORE_RUN
	#define ALLCORE_RUN		1
#else
	#define ALLCORE_RUN		0
#endif


#endif // __AE350_H
