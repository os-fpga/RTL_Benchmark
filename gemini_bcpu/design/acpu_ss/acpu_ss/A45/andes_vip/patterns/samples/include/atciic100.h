#ifndef __ATCIIC100_H
#define __ATCIIC100_H

#include <inttypes.h>
#include "general.h"

// ======================================================
// atciic100 register definition
// ======================================================
// atciic100 registers

typedef struct {
        __I  unsigned int IDREV;                /* 0x00 ID and Revision Register */
             unsigned int RESERVED[3];          /* 0x04 ~ 0x0C Reserved */
        __I  unsigned int CFG;                  /* 0x10 Configuration Register */
        __IO unsigned int INTEN;                /* 0x14 Interrupt Enable Register */
        __IO unsigned int STATUS;               /* 0x18 Status Register */
        __IO unsigned int ADDR;                 /* 0x1C Address Register */
        __IO unsigned int DATA;                 /* 0x20 Data Register */
        __IO unsigned int CTRL;                 /* 0x24 Control Register */
        __IO unsigned int CMD;                  /* 0x28 Command Register */
        __IO unsigned int SETUP;                /* 0x2C Setup Register */
        __IO unsigned int TPM;                  /* 0x30 Timing Parameter Multiplier Register */
} ATCIIC100_RegDef;


#define ATCIIC100_IDREV_ID_MASK	(BIT_MASK(31, 8))
#define ATCIIC100_IDREV_ID_OFFSET	(8)
#define ATCIIC100_IDREV_ID_DEFAULT	(0x020210)
#define ATCIIC100_IDREV_REVMAJOR_MASK	(BIT_MASK(7, 4))
#define ATCIIC100_IDREV_REVMAJOR_OFFSET	(4)
#define ATCIIC100_IDREV_REVMAJOR_DEFAULT	(0x0)
#define ATCIIC100_IDREV_REVMINOR_MASK	(BIT_MASK(3, 0))
#define ATCIIC100_IDREV_REVMINOR_OFFSET	(0)
#define ATCIIC100_IDREV_REVMINOR_DEFAULT	(0x0)
#define ATCIIC100_IDREV_DEFAULT ( \
		ATCIIC100_DEFAULT(IDREV, ID) |\
		ATCIIC100_DEFAULT(IDREV, REVMAJOR) |\
		ATCIIC100_DEFAULT(IDREV, REVMINOR))

#define ATCIIC100_CFG_FIFODEPTH_MASK	(BIT_MASK(1, 0))
#define ATCIIC100_CFG_FIFODEPTH_OFFSET	(0)
#define ATCIIC100_CFG_FIFODEPTH_DEFAULT	(0)
#define ATCIIC100_CFG_DEFAULT ( \
		ATCIIC100_DEFAULT(CFG, FIFODEPTH))

#define ATCIIC100_INTEN_INTENCMPL_MASK	(BIT_MASK(9, 9))
#define ATCIIC100_INTEN_INTENCMPL_OFFSET	(9)
#define ATCIIC100_INTEN_INTENCMPL_DEFAULT	(0)
#define ATCIIC100_INTEN_INTENBYTERECV_MASK	(BIT_MASK(8, 8))
#define ATCIIC100_INTEN_INTENBYTERECV_OFFSET	(8)
#define ATCIIC100_INTEN_INTENBYTERECV_DEFAULT	(0)
#define ATCIIC100_INTEN_INTENBYTETRANS_MASK	(BIT_MASK(7, 7))
#define ATCIIC100_INTEN_INTENBYTETRANS_OFFSET	(7)
#define ATCIIC100_INTEN_INTENBYTETRANS_DEFAULT	(0)
#define ATCIIC100_INTEN_INTENSTART_MASK	(BIT_MASK(6, 6))
#define ATCIIC100_INTEN_INTENSTART_OFFSET	(6)
#define ATCIIC100_INTEN_INTENSTART_DEFAULT	(0)
#define ATCIIC100_INTEN_INTENSTOP_MASK	(BIT_MASK(5, 5))
#define ATCIIC100_INTEN_INTENSTOP_OFFSET	(5)
#define ATCIIC100_INTEN_INTENSTOP_DEFAULT	(0)
#define ATCIIC100_INTEN_INTENARBLOSE_MASK	(BIT_MASK(4, 4))
#define ATCIIC100_INTEN_INTENARBLOSE_OFFSET	(4)
#define ATCIIC100_INTEN_INTENARBLOSE_DEFAULT	(0)
#define ATCIIC100_INTEN_INTENADDR_MASK	(BIT_MASK(3, 3))
#define ATCIIC100_INTEN_INTENADDR_OFFSET	(3)
#define ATCIIC100_INTEN_INTENADDR_DEFAULT	(0)
#define ATCIIC100_INTEN_INTENHALF_MASK	(BIT_MASK(2, 2))
#define ATCIIC100_INTEN_INTENHALF_OFFSET	(2)
#define ATCIIC100_INTEN_INTENHALF_DEFAULT	(0)
#define ATCIIC100_INTEN_INTENFULL_MASK	(BIT_MASK(1, 1))
#define ATCIIC100_INTEN_INTENFULL_OFFSET	(1)
#define ATCIIC100_INTEN_INTENFULL_DEFAULT	(0)
#define ATCIIC100_INTEN_INTENEMPTY_MASK	(BIT_MASK(0, 0))
#define ATCIIC100_INTEN_INTENEMPTY_OFFSET	(0)
#define ATCIIC100_INTEN_INTENEMPTY_DEFAULT	(0)
#define ATCIIC100_INTEN_DEFAULT ( \
		ATCIIC100_DEFAULT(INTEN, INTENCMPL) |\
		ATCIIC100_DEFAULT(INTEN, INTENBYTERECV) |\
		ATCIIC100_DEFAULT(INTEN, INTENSTART) |\
		ATCIIC100_DEFAULT(INTEN, INTENSTOP) |\
		ATCIIC100_DEFAULT(INTEN, INTENARBLOSE) |\
		ATCIIC100_DEFAULT(INTEN, INTENADDR) |\
		ATCIIC100_DEFAULT(INTEN, INTENHALF) |\
		ATCIIC100_DEFAULT(INTEN, INTENFULL) |\
		ATCIIC100_DEFAULT(INTEN, INTENEMPTY))

#define ATCIIC100_IBST_LINESDA_MASK	(BIT_MASK(14, 14))
#define ATCIIC100_IBST_LINESDA_OFFSET	(14)
#define ATCIIC100_IBST_LINESDA_DEFAULT	(1)
#define ATCIIC100_IBST_LINESCL_MASK	(BIT_MASK(13, 13))
#define ATCIIC100_IBST_LINESCL_OFFSET	(13)
#define ATCIIC100_IBST_LINESCL_DEFAULT	(1)
#define ATCIIC100_IBST_GENCALL_MASK	(BIT_MASK(12, 12))
#define ATCIIC100_IBST_GENCALL_OFFSET	(12)
#define ATCIIC100_IBST_GENCALL_DEFAULT	(0)
#define ATCIIC100_IBST_BUSBUSY_MASK	(BIT_MASK(11, 11))
#define ATCIIC100_IBST_BUSBUSY_OFFSET	(11)
#define ATCIIC100_IBST_BUSBUSY_DEFAULT	(0)
#define ATCIIC100_IBST_ACK_MASK	(BIT_MASK(10, 10))
#define ATCIIC100_IBST_ACK_OFFSET	(10)
#define ATCIIC100_IBST_ACK_DEFAULT	(0)
#define ATCIIC100_IBST_INTCMPL_MASK	(BIT_MASK(9, 9))
#define ATCIIC100_IBST_INTCMPL_OFFSET	(9)
#define ATCIIC100_IBST_INTCMPL_DEFAULT	(0)
#define ATCIIC100_IBST_INTBYTERECV_MASK	(BIT_MASK(8, 8))
#define ATCIIC100_IBST_INTBYTERECV_OFFSET	(8)
#define ATCIIC100_IBST_INTBYTERECV_DEFAULT	(0)
#define ATCIIC100_IBST_INTBYTETRANS_MASK	(BIT_MASK(7, 7))
#define ATCIIC100_IBST_INTBYTETRANS_OFFSET	(7)
#define ATCIIC100_IBST_INTBYTETRANS_DEFAULT	(0)
#define ATCIIC100_IBST_INTSTART_MASK	(BIT_MASK(6, 6))
#define ATCIIC100_IBST_INTSTART_OFFSET	(6)
#define ATCIIC100_IBST_INTSTART_DEFAULT	(0)
#define ATCIIC100_IBST_INTSTOP_MASK	(BIT_MASK(5, 5))
#define ATCIIC100_IBST_INTSTOP_OFFSET	(5)
#define ATCIIC100_IBST_INTSTOP_DEFAULT	(0)
#define ATCIIC100_IBST_INTARBLOSE_MASK	(BIT_MASK(4, 4))
#define ATCIIC100_IBST_INTARBLOSE_OFFSET	(4)
#define ATCIIC100_IBST_INTARBLOSE_DEFAULT	(0)
#define ATCIIC100_IBST_INTADDR_MASK	(BIT_MASK(3, 3))
#define ATCIIC100_IBST_INTADDR_OFFSET	(3)
#define ATCIIC100_IBST_INTADDR_DEFAULT	(0)
#define ATCIIC100_IBST_INTHALF_MASK	(BIT_MASK(2, 2))
#define ATCIIC100_IBST_INTHALF_OFFSET	(2)
#define ATCIIC100_IBST_INTHALF_DEFAULT	(0)
#define ATCIIC100_IBST_INTFULL_MASK	(BIT_MASK(1, 1))
#define ATCIIC100_IBST_INTFULL_OFFSET	(1)
#define ATCIIC100_IBST_INTFULL_DEFAULT	(0)
#define ATCIIC100_IBST_INTEMPTY_MASK	(BIT_MASK(0, 0))
#define ATCIIC100_IBST_INTEMPTY_OFFSET	(0)
#define ATCIIC100_IBST_INTEMPTY_DEFAULT	(1)
#define ATCIIC100_IBST_DEFAULT ( \
		ATCIIC100_DEFAULT(IBST, LINESDA) |\
		ATCIIC100_DEFAULT(IBST, LINESCL) |\
		ATCIIC100_DEFAULT(IBST, GENCALL) |\
		ATCIIC100_DEFAULT(IBST, BUSBUSY) |\
		ATCIIC100_DEFAULT(IBST, ACK) |\
		ATCIIC100_DEFAULT(IBST, INTCMPL) |\
		ATCIIC100_DEFAULT(IBST, INTBYTERECV) |\
		ATCIIC100_DEFAULT(IBST, INTSTART) |\
		ATCIIC100_DEFAULT(IBST, INTSTOP) |\
		ATCIIC100_DEFAULT(IBST, INTARBLOSE) |\
		ATCIIC100_DEFAULT(IBST, INTADDR) |\
		ATCIIC100_DEFAULT(IBST, INTHALF) |\
		ATCIIC100_DEFAULT(IBST, INTFULL) |\
		ATCIIC100_DEFAULT(IBST, INTEMPTY))


#define ATCIIC100_ADDR_SLVADDR_MASK	(BIT_MASK(9, 0))
#define ATCIIC100_ADDR_SLVADDR_OFFSET	(0)
#define ATCIIC100_ADDR_SLVADDR_DEFAULT	(0)
#define ATCIIC100_ADDR_DEFAULT ( \
		ATCIIC100_DEFAULT(ADDR, SLVADDR))

#define ATCIIC100_DATA_DATA_MASK	(BIT_MASK(7, 0))
#define ATCIIC100_DATA_DATA_OFFSET	(0)
#define ATCIIC100_DATA_DATA_DEFAULT	(0)
#define ATCIIC100_DATA_DEFAULT ( \
		ATCIIC100_DEFAULT(DATA, DATA))

#define ATCIIC100_CTL_PHASE_S_MASK	(BIT_MASK(12, 12))
#define ATCIIC100_CTL_PHASE_S_OFFSET	(12)
#define ATCIIC100_CTL_PHASE_S_DEFAULT	(1)
#define ATCIIC100_CTL_PHASE_ADDR_MASK	(BIT_MASK(11, 11))
#define ATCIIC100_CTL_PHASE_ADDR_OFFSET	(11)
#define ATCIIC100_CTL_PHASE_ADDR_DEFAULT	(1)
#define ATCIIC100_CTL_PHASE_DATA_MASK	(BIT_MASK(10, 10))
#define ATCIIC100_CTL_PHASE_DATA_OFFSET	(10)
#define ATCIIC100_CTL_PHASE_DATA_DEFAULT	(1)
#define ATCIIC100_CTL_PHASE_P_MASK	(BIT_MASK(9, 9))
#define ATCIIC100_CTL_PHASE_P_OFFSET	(9)
#define ATCIIC100_CTL_PHASE_P_DEFAULT	(1)
#define ATCIIC100_CTL_RDWT_MASK	(BIT_MASK(8, 8))
#define ATCIIC100_CTL_RDWT_OFFSET	(8)
#define ATCIIC100_CTL_RDWT_DEFAULT	(0)
#define ATCIIC100_CTL_DATACNT_MASK	(BIT_MASK(7, 0))
#define ATCIIC100_CTL_DATACNT_OFFSET	(0)
#define ATCIIC100_CTL_DATACNT_DEFAULT	(0)
#define ATCIIC100_CTL_DEFAULT ( \	ATCIIC100_DEFAULT(CTL, PHASE_S) |\
		ATCIIC100_DEFAULT(CTL, PHASE_ADDR) |\
		ATCIIC100_DEFAULT(CTL, PHASE_DATA) |\
		ATCIIC100_DEFAULT(CTL, PHASE_P) |\
		ATCIIC100_DEFAULT(CTL, RDWT) |\
		ATCIIC100_DEFAULT(CTL, DATACNT))

#define ATCIIC100_CMD_CMD_MASK	(BIT_MASK(2, 0))
#define ATCIIC100_CMD_CMD_OFFSET	(0)
#define ATCIIC100_CMD_CMD_DEFAULT	(0)
#define ATCIIC100_CMD_DEFAULT ( \
		ATCIIC100_DEFAULT(CMD, CMD))

#define ATCIIC100_SETUP_SUDAT_MASK	(BIT_MASK(28, 24))
#define ATCIIC100_SETUP_SUDAT_OFFSET	(24)
#define ATCIIC100_SETUP_SUDAT_DEFAULT	(5)
#define ATCIIC100_SETUP_TSP_MASK	(BIT_MASK(23, 21))
#define ATCIIC100_SETUP_TSP_OFFSET	(21)
#define ATCIIC100_SETUP_TSP_DEFAULT	(1)
#define ATCIIC100_SETUP_THDDAT_MASK	(BIT_MASK(20, 16))
#define ATCIIC100_SETUP_THDDAT_OFFSET	(16)
#define ATCIIC100_SETUP_THDDAT_DEFAULT	(5)
#define ATCIIC100_SETUP_TSCLRATIO_MASK	(BIT_MASK(13, 13))
#define ATCIIC100_SETUP_TSCLRATIO_OFFSET	(13)
#define ATCIIC100_SETUP_TSCLRATIO_DEFAULT	(1)
#define ATCIIC100_SETUP_TSCLHI_MASK	(BIT_MASK(12, 4))
#define ATCIIC100_SETUP_TSCLHI_OFFSET	(4)
#define ATCIIC100_SETUP_TSCLHI_DEFAULT	(10)
#define ATCIIC100_SETUP_DMAEN_MASK	(BIT_MASK(3, 3))
#define ATCIIC100_SETUP_DMAEN_OFFSET	(3)
#define ATCIIC100_SETUP_DMAEN_DEFAULT	(0)
#define ATCIIC100_SETUP_MASTER_MASK	(BIT_MASK(2, 2))
#define ATCIIC100_SETUP_MASTER_OFFSET	(2)
#define ATCIIC100_SETUP_MASTER_DEFAULT	(0)
#define ATCIIC100_SETUP_ADDRESSING_MASK	(BIT_MASK(1, 1))
#define ATCIIC100_SETUP_ADDRESSING_OFFSET	(1)
#define ATCIIC100_SETUP_ADDRESSING_DEFAULT	(0)
#define ATCIIC100_SETUP_IICEN_MASK	(BIT_MASK(0, 0))
#define ATCIIC100_SETUP_IICEN_OFFSET	(0)
#define ATCIIC100_SETUP_IICEN_DEFAULT	(0)
#define ATCIIC100_SETUP_DEFAULT ( \
		ATCIIC100_DEFAULT(SETUP, TSP) |\
		ATCIIC100_DEFAULT(SETUP, THDDAT) |\
		ATCIIC100_DEFAULT(SETUP, TSCLRATIO) |\
		ATCIIC100_DEFAULT(SETUP, TSCLHI) |\
		ATCIIC100_DEFAULT(SETUP, DMAEN) |\
		ATCIIC100_DEFAULT(SETUP, MASTER) |\
		ATCIIC100_DEFAULT(SETUP, ADDRESSING) |\
		ATCIIC100_DEFAULT(SETUP, IICEN))

#define ATCIIC100_TPM_TPM_MASK	(BIT_MASK(4, 0))
#define ATCIIC100_TPM_TPM_OFFSET	(0)
#define ATCIIC100_TPM_TPM_DEFAULT	(0)
#define ATCIIC100_TPM_DEFAULT ( \
		ATCIIC100_DEFAULT(TPM, TPM))


// other macros
#define I2C_RD				(0x1)	// read
#define I2C_WR				(0x0)	// write
#define I2C_CMD(addr, rw)		( ((addr)<<0x1) | (rw) )
#define I2C_ACK				(0x0)	// ACK
#define I2C_NACK			(0x1)	// NACK
#define I2C_GC_ADDR			(0x0)	// general call address

#define	ATCIIC100_IIC_RST	0x5
#define	ATCIIC100_FIFO_CLR	0x4
#define	ATCIIC100_DO_NACK	0x3
#define	ATCIIC100_DO_ACK	0x2
#define	ATCIIC100_TRANS		0x1


// ======================================================
// atciic100 access macro
// ======================================================
#define ATCIIC100_SET_FIELD(var, reg, field, value)	SET_FIELD(var, ATCIIC100_##reg##_##field##_##MASK, ATCIIC100_##reg##_##field##_##OFFSET, value)
#define ATCIIC100_GET_FIELD(var, reg, field)		GET_FIELD(var, ATCIIC100_##reg##_##field##_##MASK, ATCIIC100_##reg##_##field##_##OFFSET)
#define ATCIIC100_TEST_FIELD(var, reg, field)		TEST_FIELD(var, ATCIIC100_##reg##_##field##_##MASK)

#define ATCIIC100_EXTRACT(reg, field, value)		EXTRACT_FIELD(value, ATCIIC100_##reg##_##field##_##MASK, ATCIIC100_##reg##_##field##_##OFFSET )
#define ATCIIC100_PREPARE(reg, field, value)		PREPARE_FIELD(value, ATCIIC100_##reg##_##field##_##MASK, ATCIIC100_##reg##_##field##_##OFFSET )

#define ATCIIC100_DEFAULT(reg, field)				PREPARE_FIELD(ATCIIC100_##reg##_##field##_##DEFAULT, ATCIIC100_##reg##_##field##_##MASK, ATCIIC100_##reg##_##field##_##OFFSET )

#endif // __ATCIIC100_H

