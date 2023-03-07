#ifndef __ATCUART100_H
#define __ATCUART100_H

#include <inttypes.h>
#include "general.h"

/*****************************************************************************
 *  * Device Specific Peripheral Registers structures
 *****************************************************************************/

// ======================================================
// ATCUART100 register definition
// ======================================================
// ATCUART100 registers

typedef struct {
        __I  unsigned int IDREV;                /* 0x00 ID and Revision Register */
        __IO unsigned int RESERVED0[3];         /* 0x04 ~ 0x0C Reserved */
        __I  unsigned int CFG;                  /* 0x10 Hardware Configure Register */
        __IO unsigned int OSCR;                 /* 0x14 Over Sample Control Register */
        __IO unsigned int RESERVED1[2];         /* 0x18 ~ 0x1C Reserved */
        union {
                __IO unsigned int RBR;          /* 0x20 Receiver Buffer Register */
                __O  unsigned int THR;          /* 0x20 Transmitter Holding Register */
                __IO unsigned int DLL;          /* 0x20 Divisor Latch LSB */
        };
        union {
                __IO unsigned int IER;          /* 0x24 Interrupt Enable Register */
                __IO unsigned int DLM;          /* 0x24 Divisor Latch MSB */
        };
        union {
                __IO unsigned int IIR;          /* 0x28 Interrupt Identification Register */
                __O  unsigned int FCR;          /* 0x28 FIFO Control Register */
        };
        __IO unsigned int LCR;                  /* 0x2C Line Control Register */
        __IO unsigned int MCR;                  /* 0x30 Modem Control Register */
        __IO unsigned int LSR;                  /* 0x34 Line Status Register */
        __IO unsigned int MSR;                  /* 0x38 Modem Status Register */
        __IO unsigned int SCR;                  /* 0x3C Scratch Register */
} ATCUART100_RegDef;

// ATCUART100 id and revision register
#define ATCUART100_IDREV_ID_MASK	(BIT_MASK(31, 8))	// ID
#define ATCUART100_IDREV_ID_OFFSET	(8)
#define ATCUART100_IDREV_ID_DEFAULT	(0x020110)
#define ATCUART100_IDREV_REVMAJOR_MASK	(BIT_MASK(7, 4))	// Major revision number
#define ATCUART100_IDREV_REVMAJOR_OFFSET	(4)
#define ATCUART100_IDREV_REVMAJOR_DEFAULT	(0x0)
#define ATCUART100_IDREV_REVMINOR_MASK	(BIT_MASK(3, 0))	// Minor revision number
#define ATCUART100_IDREV_REVMINOR_OFFSET	(0)
#define ATCUART100_IDREV_REVMINOR_DEFAULT	(0x0)
#define ATCUART100_IDREV_DEFAULT		(\
					ATCUART100_DEFAULT(IDREV, ID) |\
					ATCUART100_DEFAULT(IDREV, REVMAJOR) |\
					ATCUART100_DEFAULT(IDREV, REVMINOR) \
					)

// ATCUART100 hardware configure register
#define ATCUART100_CFG_FIFO_DEPTH_MASK	(BIT_MASK(1, 0))	// fifo depth
#define ATCUART100_CFG_FIFO_DEPTH_OFFSET	(0)
#define ATCUART100_CFG_FIFO_DEPTH_DEFAULT	(0x0)
#define ATCUART100_CFG_DEFAULT		(\
					ATCUART100_DEFAULT(CFG, FIFO_DEPTH) \
					)

// ATCUART100 over sample control register
#define ATCUART100_OVERSAMPLE_OSC_MASK	(BIT_MASK(4, 0))	// fifo depth
#define ATCUART100_OVERSAMPLE_OSC_OFFSET	(0)
#define ATCUART100_OVERSAMPLE_OSC_DEFAULT	(0x10)
#define ATCUART100_OVERSAMPLE_DEFAULT		(\
					ATCUART100_DEFAULT(OVERSAMPLE, OSC) \
					)


// ATCUART100 interrupt enable register
#define ATCUART100_IER_RAI_MASK	(BIT_MASK(0, 0))	// received data available interrutp
#define ATCUART100_IER_RAI_OFFSET	(0)
#define ATCUART100_IER_RAI_DEFAULT	(0x0)
#define ATCUART100_IER_TEI_MASK	(BIT_MASK(1, 1))	// transmitter holding register empty interrupt
#define ATCUART100_IER_TEI_OFFSET	(1)
#define ATCUART100_IER_TEI_DEFAULT	(0x0)
#define ATCUART100_IER_RLSI_MASK	(BIT_MASK(2, 2))	// receiver line status interrupt 
#define ATCUART100_IER_RLSI_OFFSET	(2)
#define ATCUART100_IER_RLSI_DEFAULT	(0x0)
#define ATCUART100_IER_MSI_MASK	(BIT_MASK(3, 3))	// MODEM status interrupt 
#define ATCUART100_IER_MSI_OFFSET	(3)
#define ATCUART100_IER_MSI_DEFAULT	(0x0)
#define ATCUART100_IER_DEFAULT		(\
					ATCUART100_DEFAULT(IER, RAI) |\
					ATCUART100_DEFAULT(IER, TEI) |\
					ATCUART100_DEFAULT(IER, RLSI) |\
					ATCUART100_DEFAULT(IER, MSI) \
					)

// Divisor Latch LSB (DLL) (when DLAB = 1) 
#define ATCUART100_DLL_DLL_MASK	(BIT_MASK(7, 0))	// no interrutp pending 
#define ATCUART100_DLL_DLL_OFFSET	(0)
#define ATCUART100_DLL_DLL_DEFAULT	(0x1)
#define ATCUART100_DLL_DEFAULT		(\
					ATCUART100_DLL_DLL_DEFAULT\
					)

// Divisor Latch MSB (DLM) (when DLAB = 1) 
#define ATCUART100_DLM_DLM_MASK	(BIT_MASK(7, 0))	// no interrutp pending 
#define ATCUART100_DLM_DLM_OFFSET	(0)
#define ATCUART100_DLM_DLM_DEFAULT	(0x0)
#define ATCUART100_DLM_DEFAULT		(\
					ATCUART100_DLM_DLM_DEFAULT\
					)


// ATCUART100 interrupt identification register
#define ATCUART100_IIR_IP_MASK	(BIT_MASK(0, 0))	// no interrutp pending 
#define ATCUART100_IIR_IP_OFFSET	(0)
#define ATCUART100_IIR_IP_DEFAULT	(0x1)
#define ATCUART100_IIR_IIDC_MASK	(BIT_MASK(3, 1))	// interrupt identification code
#define ATCUART100_IIR_IIDC_OFFSET	(1)
#define ATCUART100_IIR_IIDC_DEFAULT	(0x0)

#define ATCUART100_IIR_B3B0_MASK	(BIT_MASK(3, 0))	// interrupt identification code
#define ATCUART100_IIR_B3B0_OFFSET	(0)
#define ATCUART100_IIR_B3B0_DEFAULT	(0x1)

#define ATCUART100_IIR_TFF_MASK	(BIT_MASK(4, 4))	// Tx FIFO full
#define ATCUART100_IIR_TFF_OFFSET	(4)
#define ATCUART100_IIR_TFF_DEFAULT	(0x0)

#define ATCUART100_IIR_FIFOME_MASK	(BIT_MASK(7, 6))	// FIFO mode enable
#define ATCUART100_IIR_FIFOME_OFFSET	(6)
#define ATCUART100_IIR_FIFOME_DEFAULT	(0x0)
#define ATCUART100_IIR_DEFAULT		(\
					ATCUART100_DEFAULT(IIR, IP) |\
					ATCUART100_DEFAULT(IIR, IIDC) |\
					ATCUART100_DEFAULT(IIR, FIFOME) \
					)

#define ATCUART100_IIR_RX_LINE	(0x6)
#define ATCUART100_IIR_RD_READY	(0x4)
#define ATCUART100_IIR_RC_TIMEOUT	(0xc)
#define ATCUART100_IIR_TX_EMPTY	(0x2)
#define ATCUART100_IIR_MODEM		(0x0)
#define ATCUART100_IIR_INT_NONE	(0x1)


// ATCUART100 FCR
#define ATCUART100_FCR_FEN_MASK		(BIT_MASK(0, 0))	//
#define ATCUART100_FCR_FEN_OFFSET		(0)
#define ATCUART100_FCR_FEN_DEFAULT		(0x0)
#define ATCUART100_FCR_RF_RST_MASK		(BIT_MASK(1, 1))	//
#define ATCUART100_FCR_RF_RST_OFFSET		(1)
#define ATCUART100_FCR_RF_RST_DEFAULT	(0x0)
#define ATCUART100_FCR_TF_RST_MASK		(BIT_MASK(2, 2))	//
#define ATCUART100_FCR_TF_RST_OFFSET		(2)
#define ATCUART100_FCR_TF_RST_DEFAULT	(0x0)
#define ATCUART100_FCR_DMA_EN_MASK		(BIT_MASK(3, 3))	//
#define ATCUART100_FCR_DMA_EN_OFFSET		(3)
#define ATCUART100_FCR_DMA_EN_DEFAULT	(0x0)
#define ATCUART100_FCR_TF_TRGL_MASK		(BIT_MASK(5, 4))	//
#define ATCUART100_FCR_TF_TRGL_OFFSET	(4)
#define ATCUART100_FCR_TF_TRGL_DEFAULT	(0x0)
#define ATCUART100_FCR_RF_TRGL_MASK		(BIT_MASK(7, 6))	// 
#define ATCUART100_FCR_RF_TRGL_OFFSET	(6)
#define ATCUART100_FCR_RF_TRGL_DEFAULT	(0x0)
#define ATCUART100_FCR_DEFAULT		(\
					ATCUART100_DEFAULT(FCR, FEN) |\
					ATCUART100_DEFAULT(FCR, RF_RST) |\
					ATCUART100_DEFAULT(FCR, TF_RST) |\
					ATCUART100_DEFAULT(FCR, DMA_EN) |\
					ATCUART100_DEFAULT(FCR, TF_TRGL) \
					ATCUART100_DEFAULT(FCR, RF_TRGL) \
					)

// ATCUART100 line control register
#define ATCUART100_LCR_WL0_MASK		(BIT_MASK(0, 0))
#define ATCUART100_LCR_WL0_OFFSET		(0)
#define ATCUART100_LCR_WL0_DEFAULT		(0x0)
#define ATCUART100_LCR_WL1_MASK		(BIT_MASK(1, 1))	
#define ATCUART100_LCR_WL1_OFFSET		(1)
#define ATCUART100_LCR_WL1_DEFAULT		(0x0)
#define ATCUART100_LCR_STOP_MASK		(BIT_MASK(2, 2))
#define ATCUART100_LCR_STOP_OFFSET		(2)
#define ATCUART100_LCR_STOP_DEFAULT		(0x0)
#define ATCUART100_LCR_PARITY_MASK		(BIT_MASK(3, 3))
#define ATCUART100_LCR_PARITY_OFFSET		(3)
#define ATCUART100_LCR_PARITY_DEFAULT	(0x0)
#define ATCUART100_LCR_EVEN_MASK		(BIT_MASK(4, 4))
#define ATCUART100_LCR_EVEN_OFFSET		(4)
#define ATCUART100_LCR_EVEN_DEFAULT		(0x0)
#define ATCUART100_LCR_STICK_MASK		(BIT_MASK(5, 5))
#define ATCUART100_LCR_STICK_OFFSET		(5)
#define ATCUART100_LCR_STICK_DEFAULT		(0x0)
#define ATCUART100_LCR_BREAK_MASK		(BIT_MASK(6, 6))
#define ATCUART100_LCR_BREAK_OFFSET		(6)
#define ATCUART100_LCR_BREAK_DEFAULT		(0x0)
#define ATCUART100_LCR_DLAB_MASK		(BIT_MASK(7, 7))
#define ATCUART100_LCR_DLAB_OFFSET		(7)
#define ATCUART100_LCR_DLAB_DEFAULT		(0x0)
#define ATCUART100_LCR_DEFAULT		(\
						ATCUART100_DEFAULT(LCR, WL0) |\
						ATCUART100_DEFAULT(LCR, WL1) |\
						ATCUART100_DEFAULT(LCR, STOP) |\
						ATCUART100_DEFAULT(LCR, PARITY) |\
						ATCUART100_DEFAULT(LCR, EVEN) |\
						ATCUART100_DEFAULT(LCR, STICK) |\
						ATCUART100_DEFAULT(LCR, BREAK) |\
						ATCUART100_DEFAULT(LCR, DLAB) \
						)


// ATCUART100 line status register
#define ATCUART100_LSR_DR_MASK	(BIT_MASK(0, 0))	// data ready 
#define ATCUART100_LSR_DR_OFFSET	(0)
#define ATCUART100_LSR_DR_DEFAULT	(0x0)
#define ATCUART100_LSR_OE_MASK	(BIT_MASK(1, 1))	// overrun error 
#define ATCUART100_LSR_OE_OFFSET	(1)
#define ATCUART100_LSR_OE_DEFAULT	(0x0)
#define ATCUART100_LSR_PE_MASK	(BIT_MASK(2, 2))		// pariry error 
#define ATCUART100_LSR_PE_OFFSET	(2)
#define ATCUART100_LSR_PE_DEFAULT	(0x0)
#define ATCUART100_LSR_FE_MASK	(BIT_MASK(3, 3))		// framing error 
#define ATCUART100_LSR_FE_OFFSET	(3)
#define ATCUART100_LSR_FE_DEFAULT	(0x0)
#define ATCUART100_LSR_BI_MASK	(BIT_MASK(4, 4))	// break interrupt 
#define ATCUART100_LSR_BI_OFFSET	(4)
#define ATCUART100_LSR_BI_DEFAULT	(0x0)
#define ATCUART100_LSR_THRE_MASK	(BIT_MASK(5, 5))	// transmitter holding regisetr empty 
#define ATCUART100_LSR_THRE_OFFSET	(5)
#define ATCUART100_LSR_THRE_DEFAULT	(0x0)
#define ATCUART100_LSR_TE_MASK	(BIT_MASK(6, 6))	// transmitter empry
#define ATCUART100_LSR_TE_OFFSET	(6)
#define ATCUART100_LSR_TE_DEFAULT	(0x0)
#define ATCUART100_LSR_ERF_MASK	(BIT_MASK(7, 7))	// error in RCVR FIFO
#define ATCUART100_LSR_ERF_OFFSET	(7)
#define ATCUART100_LSR_ERF_DEFAULT	(0x0)
#define ATCUART100_LSR_DEFAULT		(\
						ATCUART100_DEFAULT(LSR, DR) |\
						ATCUART100_DEFAULT(LSR, OE) |\
						ATCUART100_DEFAULT(LSR, PE) |\
						ATCUART100_DEFAULT(LSR, FE) |\
						ATCUART100_DEFAULT(LSR, BI) |\
						ATCUART100_DEFAULT(LSR, THRE) |\
						ATCUART100_DEFAULT(LSR, TE) |\
						ATCUART100_DEFAULT(LSR, ERF) \
						)

// ATCUART100 modem control register
#define ATCUART100_MCR_DTR_MASK			(BIT_MASK(0, 0))
#define ATCUART100_MCR_DTR_OFFSET		(0)
#define ATCUART100_MCR_DTR_DEFAULT		(0x0)
#define ATCUART100_MCR_RTS_MASK			(BIT_MASK(1, 1))
#define ATCUART100_MCR_RTS_OFFSET		(1)
#define ATCUART100_MCR_RTS_DEFAULT		(0x0)
#define ATCUART100_MCR_OUT1_MASK		(BIT_MASK(2, 2))
#define ATCUART100_MCR_OUT1_OFFSET		(2)
#define ATCUART100_MCR_OUT1_DEFAULT		(0x0)
#define ATCUART100_MCR_OUT2_MASK		(BIT_MASK(3, 3))
#define ATCUART100_MCR_OUT2_OFFSET		(3)
#define ATCUART100_MCR_OUT2_DEFAULT	(0x0)
#define ATCUART100_MCR_LOOP_MASK		(BIT_MASK(4, 4))
#define ATCUART100_MCR_LOOP_OFFSET		(4)
#define ATCUART100_MCR_LOOP_DEFAULT		(0x0)
#define ATCUART100_MCR_AFE_MASK			(BIT_MASK(5, 5))
#define ATCUART100_MCR_AFE_OFFSET		(5)
#define ATCUART100_MCR_AFE_DEFAULT		(0x0)
#define ATCUART100_MCR_DEFAULT		(\
						ATCUART100_DEFAULT(MCR, DTR) |\
						ATCUART100_DEFAULT(MCR, RTS) |\
						ATCUART100_DEFAULT(MCR, OUT1) |\
						ATCUART100_DEFAULT(MCR, OUT2) |\
						ATCUART100_DEFAULT(MCR, LOOP) |\
						ATCUART100_DEFAULT(MCR, AFE) \
						)




// ======================================================
// ATCUART100 access macro 
// ======================================================
#define ATCUART100_SET_FIELD(var, reg, field, value)		SET_FIELD(var, ATCUART100_##reg##_##field##_##MASK, ATCUART100_##reg##_##field##_##OFFSET, value)
#define ATCUART100_GET_FIELD(var, reg, field)		GET_FIELD(var, ATCUART100_##reg##_##field##_##MASK, ATCUART100_##reg##_##field##_##OFFSET)
#define ATCUART100_TEST_FIELD(var, reg, field)		TEST_FIELD(var, ATCUART100_##reg##_##field##_##MASK)

#define ATCUART100_TEST_BIT(reg, field, value)		VAR_TEST_BIT(value, ATCUART100_##reg##_##field##_##MASK)

#define ATCUART100_EXTRACT(reg, field, value)		EXTRACT_FIELD(value, ATCUART100_##reg##_##field##_##MASK, ATCUART100_##reg##_##field##_##OFFSET )
#define ATCUART100_PREPARE(reg, field, value)		PREPARE_FIELD(value, ATCUART100_##reg##_##field##_##MASK, ATCUART100_##reg##_##field##_##OFFSET )

#define ATCUART100_DEFAULT(reg, field)			PREPARE_FIELD(ATCUART100_##reg##_##field##_##DEFAULT, ATCUART100_##reg##_##field##_##MASK, ATCUART100_##reg##_##field##_##OFFSET )

#endif // __ATCUART100_H

