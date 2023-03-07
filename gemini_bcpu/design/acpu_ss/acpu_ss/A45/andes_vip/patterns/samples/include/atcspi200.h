#ifndef __ATCSPI200_H
#define __ATCSPI200_H

#include <inttypes.h>
#include "general.h"

#ifndef SPI_MEM_BASE
	#define	SPI_MEM_BASE 0
#endif
#ifndef SPI_MEM_SIZE
	#define SPI_MEM_SIZE 0
#endif

/*****************************************************************************
 *  * Device Specific Peripheral Registers structures
 *****************************************************************************/

// ======================================================
// ATCSPI200 register definition
// ======================================================
// ATCSPI200 registers
typedef struct {
        __I  unsigned int IDREV;                /* 0x00 ID and revision register */
        __IO unsigned int RESERVED0[3];         /* 0x04 ~ 0x0c Reserved */
        __IO unsigned int TRANSFMT;             /* 0x10 SPI transfer format register */
        __IO unsigned int DIRECTIO;             /* 0x14 SPI direct IO control register */
        __IO unsigned int RESERVED1[2];         /* 0x18 ~ 0x1c Reserved */
        __IO unsigned int TRANSCTRL;            /* 0x20 SPI transfer control register */
        __IO unsigned int CMD;                  /* 0x24 SPI command register */
        __IO unsigned int ADDR;                 /* 0x28 SPI address register */
        __IO unsigned int DATA;                 /* 0x2c SPI data register */
        __IO unsigned int CTRL;                 /* 0x30 SPI conrtol register */
        __I  unsigned int STATUS;               /* 0x34 SPI status register */
        __IO unsigned int INTREN;               /* 0x38 SPI interrupt enable register */
        __O  unsigned int INTRST;               /* 0x3c SPI interrupt status register */
        __IO unsigned int TIMING;               /* 0x40 SPI interface timing register */
        __IO unsigned int RESERVED2[3];         /* 0x44 ~ 0x4c Reserved */
        __IO unsigned int MEMCTRL;              /* 0x50 SPI memory access control register */
        __IO unsigned int RESERVED3[3];         /* 0x54 ~ 0x5c Reserved */
        __IO unsigned int SLVST;                /* 0x60 SPI slave status register */
        __I  unsigned int SLVDATACNT;           /* 0x64 SPI slave data count register */
        __IO unsigned int RESERVED4[5];         /* 0x68 ~ 0x78 Reserved */
        __I  unsigned int CONFIG;               /* 0x7c Configuration register */
} ATCSPI200_RegDef;

// REG SPI data control: TRANSMODE
#define TRANSMODE_WRnRD      0x0
#define TRANSMODE_WRonly     0x1
#define TRANSMODE_RDonly     0x2
#define TRANSMODE_WR_RD      0x3
#define TRANSMODE_RD_WR      0x4
#define TRANSMODE_WR_DMY_RD  0x5
#define TRANSMODE_RD_DMY_WR  0x6
#define TRANSMODE_NoneData   0x7
#define TRANSMODE_DMY_WR     0x8
#define TRANSMODE_DMY_RD     0x9
#define TRANSMODE_LAST	TRANSMODE_DMY_RD

// Memory SPI Data Control and interface timing setting : CMD_R
#define MEM_CMD_R        0x0   // 0x03
#define MEM_CMD_FR       0x1   // 0x0B
#define MEM_CMD_DOFR     0x2   // 0x3B
#define MEM_CMD_QOFR     0x3   // 0x6B
#define MEM_CMD_DIOFR    0x4   // 0xBB
#define MEM_CMD_QIOFR    0x5   // 0xEB

// SPI INTERRUPT
#define SPI_ENDINT         ATCSPI200_INTREN_ENDINTEN_MASK
#define SPI_TXFIFOINT      ATCSPI200_INTREN_TXFIFOINTEN_MASK
#define SPI_RXFIFOINT      ATCSPI200_INTREN_RXFIFOINTEN_MASK
#define SPI_TXFIFOURINT    ATCSPI200_INTREN_TXFIFOURINTEN_MASK
#define SPI_RXFIFOORINT    ATCSPI200_INTREN_RXFIFOORINTEN_MASK
#define SPI_SLVCMDINT      ATCSPI200_INTREN_SLVCMDEN_MASK

#define MAX_TRAN_BYTES	512
#define MAX_RECV_BYTES	512

#define SLV_OP_RD_ST	0x05
#define SLV_OP_RD_ST2	0x15
#define SLV_OP_RD_ST4	0x25
#define SLV_OP_RD_DAT	0x0b
#define SLV_OP_RD_DAT2	0x0c
#define SLV_OP_RD_DAT4	0x0e
#define SLV_OP_WR_DAT	0x51
#define SLV_OP_WR_DAT2	0x52
#define SLV_OP_WR_DAT4	0x54


// ID and Revision Register
#define ATCSPI200_IDREV_ID_MASK           (BIT_MASK(31, 8))
#define ATCSPI200_IDREV_ID_OFFSET         (8)
#define ATCSPI200_IDREV_ID_DEFAULT        (0x020020)
#define ATCSPI200_IDREV_REVMAJOR_MASK     (BIT_MASK(7, 4))
#define ATCSPI200_IDREV_REVMAJOR_OFFSET   (4)
#define ATCSPI200_IDREV_REVMAJOR_DEFAULT  (0x0)
#define ATCSPI200_IDREV_REVMINOR_MASK     (BIT_MASK(3, 0))
#define ATCSPI200_IDREV_REVMINOR_OFFSET   (0)
#define ATCSPI200_IDREV_REVMINOR_DEFAULT  (0x0)
#define ATCSPI200_IDREV_DEFAULT           ( \
		                          ATCSPI200_DEFAULT(IDREV, ID) |\
		                          ATCSPI200_DEFAULT(IDREV, REVMAJOR) |\
		                          ATCSPI200_DEFAULT(IDREV, REVMINOR)\
		                          )

// SPI Transfer Format Register
#define ATCSPI200_TRANSFMT_ADDRLEN_MASK      (BIT_MASK(17, 16))
#define ATCSPI200_TRANSFMT_ADDRLEN_OFFSET    (16)
#define ATCSPI200_TRANSFMT_ADDRLEN_DEFAULT   (0x2)
#define ATCSPI200_TRANSFMT_DATALEN_MASK      (BIT_MASK(12, 8))
#define ATCSPI200_TRANSFMT_DATALEN_OFFSET    (8)
#define ATCSPI200_TRANSFMT_DATALEN_DEFAULT   (0x7)
#define ATCSPI200_TRANSFMT_DATAMERGE_MASK    (BIT_MASK(7, 7))
#define ATCSPI200_TRANSFMT_DATAMERGE_OFFSET  (7)
#define ATCSPI200_TRANSFMT_DATAMERGE_DEFAULT (1)
#define ATCSPI200_TRANSFMT_MOSIBIDIR_MASK    (BIT_MASK(4, 4))
#define ATCSPI200_TRANSFMT_MOSIBIDIR_OFFSET  (4)
#define ATCSPI200_TRANSFMT_MOSIBIDIR_DEFAULT (0)
#define ATCSPI200_TRANSFMT_LSB_MASK          (BIT_MASK(3, 3))
#define ATCSPI200_TRANSFMT_LSB_OFFSET        (3)
#define ATCSPI200_TRANSFMT_LSB_DEFAULT       (0)
#define ATCSPI200_TRANSFMT_SLVMODE_MASK      (BIT_MASK(2, 2))
#define ATCSPI200_TRANSFMT_SLVMODE_OFFSET    (2)
#define ATCSPI200_TRANSFMT_SLVMODE_DEFAULT   (0)
#define ATCSPI200_TRANSFMT_CPOL_MASK         (BIT_MASK(1, 1))
#define ATCSPI200_TRANSFMT_CPOL_OFFSET       (1)
#define ATCSPI200_TRANSFMT_CPOL_DEFAULT      (0)
#define ATCSPI200_TRANSFMT_CPHA_MASK         (BIT_MASK(0, 0))
#define ATCSPI200_TRANSFMT_CPHA_OFFSET       (0)
#define ATCSPI200_TRANSFMT_CPHA_DEFAULT      (0)
#define ATCSPI200_TRANSFMT_DEFAULT           ( \
		                             ATCSPI200_DEFAULT(TRANSFMT, ADDRLEN) |\
		                             ATCSPI200_DEFAULT(TRANSFMT, DATALEN) |\
		                             ATCSPI200_DEFAULT(TRANSFMT, DATAMERGE) |\
		                             ATCSPI200_DEFAULT(TRANSFMT, MOSIBIDIR) |\
		                             ATCSPI200_DEFAULT(TRANSFMT, LSB) |\
		                             ATCSPI200_DEFAULT(TRANSFMT, SLVMODE) |\
		                             ATCSPI200_DEFAULT(TRANSFMT, CPOL) |\
		                             ATCSPI200_DEFAULT(TRANSFMT, CPHA) \
		                             )

// SPI Direct IO Control Register
#define ATCSPI200_DIRECTIO_DIRECTIOEN_MASK     (BIT_MASK(24, 24))
#define ATCSPI200_DIRECTIO_DIRECTIOEN_OFFSET   (24)
#define ATCSPI200_DIRECTIO_DIRECTIOEN_DEFAULT  (0)
#define ATCSPI200_DIRECTIO_HOLD_OE_MASK        (BIT_MASK(21, 21))
#define ATCSPI200_DIRECTIO_HOLD_OE_OFFSET      (21)
#define ATCSPI200_DIRECTIO_HOLD_OE_DEFAULT     (0)
#define ATCSPI200_DIRECTIO_WP_OE_MASK          (BIT_MASK(20, 20))
#define ATCSPI200_DIRECTIO_WP_OE_OFFSET        (20)
#define ATCSPI200_DIRECTIO_WP_OE_DEFAULT       (0)
#define ATCSPI200_DIRECTIO_MISO_OE_MASK        (BIT_MASK(19, 19))
#define ATCSPI200_DIRECTIO_MISO_OE_OFFSET      (19)
#define ATCSPI200_DIRECTIO_MISO_OE_DEFAULT     (0)
#define ATCSPI200_DIRECTIO_MOSI_OE_MASK        (BIT_MASK(18, 18))
#define ATCSPI200_DIRECTIO_MOSI_OE_OFFSET      (18)
#define ATCSPI200_DIRECTIO_MOSI_OE_DEFAULT     (0)
#define ATCSPI200_DIRECTIO_SCLK_OE_MASK        (BIT_MASK(17, 17))
#define ATCSPI200_DIRECTIO_SCLK_OE_OFFSET      (17)
#define ATCSPI200_DIRECTIO_SCLK_OE_DEFAULT     (0)
#define ATCSPI200_DIRECTIO_CS_OE_MASK          (BIT_MASK(16, 16))
#define ATCSPI200_DIRECTIO_CS_OE_OFFSET        (16)
#define ATCSPI200_DIRECTIO_CS_OE_DEFAULT       (0)
#define ATCSPI200_DIRECTIO_HOLD_O_MASK         (BIT_MASK(13, 13))
#define ATCSPI200_DIRECTIO_HOLD_O_OFFSET       (13)
#define ATCSPI200_DIRECTIO_HOLD_O_DEFAULT      (1)
#define ATCSPI200_DIRECTIO_WP_O_MASK           (BIT_MASK(12, 12))
#define ATCSPI200_DIRECTIO_WP_O_OFFSET         (12)
#define ATCSPI200_DIRECTIO_WP_O_DEFAULT        (1)
#define ATCSPI200_DIRECTIO_MISO_O_MASK         (BIT_MASK(11, 11))
#define ATCSPI200_DIRECTIO_MISO_O_OFFSET       (11)
#define ATCSPI200_DIRECTIO_MISO_O_DEFAULT      (0)
#define ATCSPI200_DIRECTIO_MOSI_O_MASK         (BIT_MASK(10, 10))
#define ATCSPI200_DIRECTIO_MOSI_O_OFFSET       (10)
#define ATCSPI200_DIRECTIO_MOSI_O_DEFAULT      (0)
#define ATCSPI200_DIRECTIO_SCLK_O_MASK         (BIT_MASK(9, 9))
#define ATCSPI200_DIRECTIO_SCLK_O_OFFSET       (9)
#define ATCSPI200_DIRECTIO_SCLK_O_DEFAULT      (0)
#define ATCSPI200_DIRECTIO_CS_O_MASK           (BIT_MASK(8, 8))
#define ATCSPI200_DIRECTIO_CS_O_OFFSET         (8)
#define ATCSPI200_DIRECTIO_CS_O_DEFAULT        (1)
#define ATCSPI200_DIRECTIO_HOLD_I_MASK         (BIT_MASK(5, 5))
#define ATCSPI200_DIRECTIO_HOLD_I_OFFSET       (5)
#define ATCSPI200_DIRECTIO_HOLD_I_DEFAULT      (0)
#define ATCSPI200_DIRECTIO_WP_I_MASK           (BIT_MASK(4, 4))
#define ATCSPI200_DIRECTIO_WP_I_OFFSET         (4)
#define ATCSPI200_DIRECTIO_WP_I_DEFAULT        (0)
#define ATCSPI200_DIRECTIO_MISO_I_MASK         (BIT_MASK(3, 3))
#define ATCSPI200_DIRECTIO_MISO_I_OFFSET       (3)
#define ATCSPI200_DIRECTIO_MISO_I_DEFAULT      (0)
#define ATCSPI200_DIRECTIO_MOSI_I_MASK         (BIT_MASK(2, 2))
#define ATCSPI200_DIRECTIO_MOSI_I_OFFSET       (2)
#define ATCSPI200_DIRECTIO_MOSI_I_DEFAULT      (0)
#define ATCSPI200_DIRECTIO_SCLK_I_MASK         (BIT_MASK(1, 1))
#define ATCSPI200_DIRECTIO_SCLK_I_OFFSET       (1)
#define ATCSPI200_DIRECTIO_SCLK_I_DEFAULT      (0)
#define ATCSPI200_DIRECTIO_CS_I_MASK           (BIT_MASK(0, 0))
#define ATCSPI200_DIRECTIO_CS_I_OFFSET         (0)
#define ATCSPI200_DIRECTIO_CS_I_DEFAULT        (0)
#define ATCSPI200_DIRECTIO_DEFAULT             ( \
		                               ATCSPI200_DEFAULT(DIRECTIO, DIRECTIOEN) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, HOLD_OE) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, WP_OE) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, MISO_OE) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, MOSI_OE) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, SCLK_OE) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, CS_OE) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, HOLD_O) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, WP_O) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, MISO_O) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, MOSI_O) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, SCLK_O) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, CS_O) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, HOLD_I) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, WP_I) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, MISO_I) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, MOSI_I) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, SCLK_I) |\
		                               ATCSPI200_DEFAULT(DIRECTIO, CS_I) \
		                               )

// SPI Transfer Control Register
#define ATCSPI200_TRANSCTRL_CMDEN_MASK         (BIT_MASK(30, 30))
#define ATCSPI200_TRANSCTRL_CMDEN_OFFSET       (30)
#define ATCSPI200_TRANSCTRL_CMDEN_DEFAULT      (0)
#define ATCSPI200_TRANSCTRL_ADDREN_MASK        (BIT_MASK(29, 29))
#define ATCSPI200_TRANSCTRL_ADDREN_OFFSET      (29)
#define ATCSPI200_TRANSCTRL_ADDREN_DEFAULT     (0)
#define ATCSPI200_TRANSCTRL_ADDRFMT_MASK       (BIT_MASK(28, 28))
#define ATCSPI200_TRANSCTRL_ADDRFMT_OFFSET     (28)
#define ATCSPI200_TRANSCTRL_ADDRFMT_DEFAULT    (0)
#define ATCSPI200_TRANSCTRL_TRANSMODE_MASK     (BIT_MASK(27, 24))
#define ATCSPI200_TRANSCTRL_TRANSMODE_OFFSET   (24)
#define ATCSPI200_TRANSCTRL_TRANSMODE_DEFAULT  (0)
#define ATCSPI200_TRANSCTRL_DUALQUAD_MASK      (BIT_MASK(23, 22))
#define ATCSPI200_TRANSCTRL_DUALQUAD_OFFSET    (22)
#define ATCSPI200_TRANSCTRL_DUALQUAD_DEFAULT   (0)
#define ATCSPI200_TRANSCTRL_TOKENEN_MASK       (BIT_MASK(21, 21))
#define ATCSPI200_TRANSCTRL_TOKENEN_OFFSET     (21)
#define ATCSPI200_TRANSCTRL_TOKENEN_DEFAULT    (0)
#define ATCSPI200_TRANSCTRL_WRTRANCNT_MASK     (BIT_MASK(20, 12))
#define ATCSPI200_TRANSCTRL_WRTRANCNT_OFFSET   (12)
#define ATCSPI200_TRANSCTRL_WRTRANCNT_DEFAULT  (0)
#define ATCSPI200_TRANSCTRL_TOKENVALUE_MASK    (BIT_MASK(11, 11))
#define ATCSPI200_TRANSCTRL_TOKENVALUE_OFFSET  (11)
#define ATCSPI200_TRANSCTRL_TOKENVALUE_DEFAULT (0)
#define ATCSPI200_TRANSCTRL_DUMMYCNT_MASK      (BIT_MASK(10, 9))
#define ATCSPI200_TRANSCTRL_DUMMYCNT_OFFSET    (9)
#define ATCSPI200_TRANSCTRL_DUMMYCNT_DEFAULT   (0)
#define ATCSPI200_TRANSCTRL_RDTRANCNT_MASK     (BIT_MASK(8, 0))
#define ATCSPI200_TRANSCTRL_RDTRANCNT_OFFSET   (0)
#define ATCSPI200_TRANSCTRL_RDTRANCNT_DEFAULT  (0)
#define ATCSPI200_TRANSCTRL_DEFAULT            ( \
		                               ATCSPI200_DEFAULT(TRANSCTRL, CMDEN) |\
		                               ATCSPI200_DEFAULT(TRANSCTRL, ADDREN) |\
		                               ATCSPI200_DEFAULT(TRANSCTRL, ADDRFMT) |\
		                               ATCSPI200_DEFAULT(TRANSCTRL, TRANSMODE) |\
		                               ATCSPI200_DEFAULT(TRANSCTRL, DUALQUAD) |\
		                               ATCSPI200_DEFAULT(TRANSCTRL, TOKENEN) |\
		                               ATCSPI200_DEFAULT(TRANSCTRL, WRTRANCNT) |\
		                               ATCSPI200_DEFAULT(TRANSCTRL, TOKENVALUE) |\
		                               ATCSPI200_DEFAULT(TRANSCTRL, DUMMYCNT) |\
		                               ATCSPI200_DEFAULT(TRANSCTRL, RDTRANCNT) \
		                               )

// SPI Command Register
#define ATCSPI200_CMD_CMD_MASK    (BIT_MASK(7, 0))
#define ATCSPI200_CMD_CMD_OFFSET  (0)
#define ATCSPI200_CMD_CMD_DEFAULT (0)
#define ATCSPI200_CMD_DEFAULT     ( \
		                  ATCSPI200_DEFAULT(CMD, CMD) \
		                  )

// SPI Address Register
#define ATCSPI200_ADDR_ADDR_MASK    (BIT_MASK(31, 0))
#define ATCSPI200_ADDR_ADDR_OFFSET  (0)
#define ATCSPI200_ADDR_ADDR_DEFAULT (0)
#define ATCSPI200_ADDR_DEFAULT      ( \
		                    ATCSPI200_DEFAULT(ADDR, ADDR) \
		                    )

// SPI DATA Register
#define ATCSPI200_DATA_DATA_MASK    0xFFFFFFFF //(BIT_MASK(31, 0))
#define ATCSPI200_DATA_DATA_OFFSET  (0)
#define ATCSPI200_DATA_DATA_DEFAULT (0)
#define ATCSPI200_DATA_DEFAULT      ( \
		                    ATCSPI200_DEFAULT(DATA, DATA) \
		                    )

// SPI Control Register
#define ATCSPI200_CTRL_TXTHRES_MASK      (BIT_MASK(20, 16))
#define ATCSPI200_CTRL_TXTHRES_OFFSET    (16)
#define ATCSPI200_CTRL_TXTHRES_DEFAULT   (0)
#define ATCSPI200_CTRL_RXTHRES_MASK      (BIT_MASK(12, 8))
#define ATCSPI200_CTRL_RXTHRES_OFFSET    (8)
#define ATCSPI200_CTRL_RXTHRES_DEFAULT   (0)
#define ATCSPI200_CTRL_TXDMAEN_MASK      (BIT_MASK(4, 4))
#define ATCSPI200_CTRL_TXDMAEN_OFFSET    (4)
#define ATCSPI200_CTRL_TXDMAEN_DEFAULT   (0)
#define ATCSPI200_CTRL_RXDMAEN_MASK      (BIT_MASK(3, 3))
#define ATCSPI200_CTRL_RXDMAEN_OFFSET    (3)
#define ATCSPI200_CTRL_RXDMAEN_DEFAULT   (0)
#define ATCSPI200_CTRL_TXFIFORST_MASK    (BIT_MASK(2, 2))
#define ATCSPI200_CTRL_TXFIFORST_OFFSET  (2)
#define ATCSPI200_CTRL_TXFIFORST_DEFAULT (0)
#define ATCSPI200_CTRL_RXFIFORST_MASK    (BIT_MASK(1, 1))
#define ATCSPI200_CTRL_RXFIFORST_OFFSET  (1)
#define ATCSPI200_CTRL_RXFIFORST_DEFAULT (0)
#define ATCSPI200_CTRL_SPIRST_MASK       (BIT_MASK(0, 0))
#define ATCSPI200_CTRL_SPIRST_OFFSET     (0)
#define ATCSPI200_CTRL_SPIRST_DEFAULT    (0)
#define ATCSPI200_CTRL_DEFAULT           ( \
		                         ATCSPI200_DEFAULT(CTRL, TXTHRES) |\
		                         ATCSPI200_DEFAULT(CTRL, RXTHRES) |\
		                         ATCSPI200_DEFAULT(CTRL, TXDMAEN) |\
		                         ATCSPI200_DEFAULT(CTRL, RXDMAEN) |\
		                         ATCSPI200_DEFAULT(CTRL, TXFIFORST) |\
		                         ATCSPI200_DEFAULT(CTRL, RXFIFORST) |\
		                         ATCSPI200_DEFAULT(CTRL, SPIRST) \
		                         )

// SPI Status Register
#define ATCSPI200_STATUS_TXNUM_UPPER_MASK      (BIT_MASK(29,28))
#define ATCSPI200_STATUS_TXNUM_UPPER_OFFSET    (28)
#define ATCSPI200_STATUS_TXNUM_UPPER_DEFAULT   (0)
#define ATCSPI200_STATUS_RXNUM_UPPER_MASK      (BIT_MASK(25,24))
#define ATCSPI200_STATUS_RXNUM_UPPER_OFFSET    (24)
#define ATCSPI200_STATUS_RXNUM_UPPER_DEFAULT   (0)
#define ATCSPI200_STATUS_TXFULL_MASK           (BIT_MASK(23, 23))
#define ATCSPI200_STATUS_TXFULL_OFFSET         (23)
#define ATCSPI200_STATUS_TXFULL_DEFAULT        (0)
#define ATCSPI200_STATUS_TXEMPTY_MASK          (BIT_MASK(22, 22))
#define ATCSPI200_STATUS_TXEMPTY_OFFSET        (22)
#define ATCSPI200_STATUS_TXEMPTY_DEFAULT       (1)
#define ATCSPI200_STATUS_TXNUM_LOWER_MASK      (BIT_MASK(21, 16))
#define ATCSPI200_STATUS_TXNUM_LOWER_OFFSET    (16)
#define ATCSPI200_STATUS_TXNUM_LOWER_DEFAULT   (0)
#define ATCSPI200_STATUS_RXFULL_MASK           (BIT_MASK(15, 15))
#define ATCSPI200_STATUS_RXFULL_OFFSET         (15)
#define ATCSPI200_STATUS_RXFULL_DEFAULT        (0)
#define ATCSPI200_STATUS_RXEMPTY_MASK          (BIT_MASK(14, 14))
#define ATCSPI200_STATUS_RXEMPTY_OFFSET        (14)
#define ATCSPI200_STATUS_RXEMPTY_DEFAULT       (1)
#define ATCSPI200_STATUS_RXNUM_LOWER_MASK      (BIT_MASK(13, 8))
#define ATCSPI200_STATUS_RXNUM_LOWER_OFFSET    (8)
#define ATCSPI200_STATUS_RXNUM_LOWER_DEFAULT   (0)
#define ATCSPI200_STATUS_SPIACTIVE_MASK        (BIT_MASK(0, 0))
#define ATCSPI200_STATUS_SPIACTIVE_OFFSET      (0)
#define ATCSPI200_STATUS_SPIACTIVE_DEFAULT     (0)
#define ATCSPI200_STATUS_DEFAULT               ( \
		                               ATCSPI200_DEFAULT(STATUS, TXNUM_UPPER) |\
		                               ATCSPI200_DEFAULT(STATUS, RXNUM_UPPER) |\
		                               ATCSPI200_DEFAULT(STATUS, TXFULL) |\
		                               ATCSPI200_DEFAULT(STATUS, TXEMPTY) |\
		                               ATCSPI200_DEFAULT(STATUS, TXNUM_LOWER) |\
		                               ATCSPI200_DEFAULT(STATUS, RXFULL) |\
		                               ATCSPI200_DEFAULT(STATUS, RXEMPTY) |\
		                               ATCSPI200_DEFAULT(STATUS, RXNUM_LOWER) |\
		                               ATCSPI200_DEFAULT(STATUS, SPIACTIVE) \
		                               )

// SPI Interrupt Enable Register
#define ATCSPI200_INTREN_SLVCMDEN_MASK         (BIT_MASK(5, 5))
#define ATCSPI200_INTREN_SLVCMDEN_OFFSET       (5)
#define ATCSPI200_INTREN_SLVCMDEN_DEFAULT      (0)
#define ATCSPI200_INTREN_ENDINTEN_MASK         (BIT_MASK(4, 4))
#define ATCSPI200_INTREN_ENDINTEN_OFFSET       (4)
#define ATCSPI200_INTREN_ENDINTEN_DEFAULT      (0)
#define ATCSPI200_INTREN_TXFIFOINTEN_MASK      (BIT_MASK(3, 3))
#define ATCSPI200_INTREN_TXFIFOINTEN_OFFSET    (3)
#define ATCSPI200_INTREN_TXFIFOINTEN_DEFAULT   (0)
#define ATCSPI200_INTREN_RXFIFOINTEN_MASK      (BIT_MASK(2, 2))
#define ATCSPI200_INTREN_RXFIFOINTEN_OFFSET    (2)
#define ATCSPI200_INTREN_RXFIFOINTEN_DEFAULT   (0)
#define ATCSPI200_INTREN_TXFIFOURINTEN_MASK    (BIT_MASK(1, 1))
#define ATCSPI200_INTREN_TXFIFOURINTEN_OFFSET  (1)
#define ATCSPI200_INTREN_TXFIFOURINTEN_DEFAULT (0)
#define ATCSPI200_INTREN_RXFIFOORINTEN_MASK    (BIT_MASK(0, 0))
#define ATCSPI200_INTREN_RXFIFOORINTEN_OFFSET  (0)
#define ATCSPI200_INTREN_RXFIFOORINTEN_DEFAULT (0)
#define ATCSPI200_INTREN_DEFAULT               ( \
		                               ATCSPI200_DEFAULT(INTREN, SLVCMDEN) |\
		                               ATCSPI200_DEFAULT(INTREN, ENDINTEN) |\
		                               ATCSPI200_DEFAULT(INTREN, TXFIFOINTEN) |\
		                               ATCSPI200_DEFAULT(INTREN, RXFIFOINTEN) |\
		                               ATCSPI200_DEFAULT(INTREN, TXFIFOURINTEN) |\
		                               ATCSPI200_DEFAULT(INTREN, RXFIFOORINTEN) \
		                               )

// SPI Interrupt Status Register
#define ATCSPI200_INTRST_SLVCMDINT_MASK      (BIT_MASK(5, 5))
#define ATCSPI200_INTRST_SLVCMDINT_OFFSET    (5)
#define ATCSPI200_INTRST_SLVCMDINT_DEFAULT   (0)
#define ATCSPI200_INTRST_ENDINT_MASK         (BIT_MASK(4, 4))
#define ATCSPI200_INTRST_ENDINT_OFFSET       (4)
#define ATCSPI200_INTRST_ENDINT_DEFAULT      (0)
#define ATCSPI200_INTRST_TXFIFOINT_MASK      (BIT_MASK(3, 3))
#define ATCSPI200_INTRST_TXFIFOINT_OFFSET    (3)
#define ATCSPI200_INTRST_TXFIFOINT_DEFAULT   (0)
#define ATCSPI200_INTRST_RXFIFOINT_MASK      (BIT_MASK(2, 2))
#define ATCSPI200_INTRST_RXFIFOINT_OFFSET    (2)
#define ATCSPI200_INTRST_RXFIFOINT_DEFAULT   (0)
#define ATCSPI200_INTRST_TXFIFOURINT_MASK    (BIT_MASK(1, 1))
#define ATCSPI200_INTRST_TXFIFOURINT_OFFSET  (1)
#define ATCSPI200_INTRST_TXFIFOURINT_DEFAULT (0)
#define ATCSPI200_INTRST_RXFIFOORINT_MASK    (BIT_MASK(0, 0))
#define ATCSPI200_INTRST_RXFIFOORINT_OFFSET  (0)
#define ATCSPI200_INTRST_RXFIFOORINT_DEFAULT (0)
#define ATCSPI200_INTRST_DEFAULT             ( \
		                             ATCSPI200_DEFAULT(INTRST, SLVCMDINT) |\
		                             ATCSPI200_DEFAULT(INTRST, ENDINT) |\
		                             ATCSPI200_DEFAULT(INTRST, TXFIFOINT) |\
		                             ATCSPI200_DEFAULT(INTRST, RXFIFOINT) |\
		                             ATCSPI200_DEFAULT(INTRST, TXFIFOURINT) |\
		                             ATCSPI200_DEFAULT(INTRST, RXFIFOORINT) \
		                             )

// SPI Interface timing Setting
#define ATCSPI200_TIMING_CS2SCLK_MASK     (BIT_MASK(13, 12))
#define ATCSPI200_TIMING_CS2SCLK_OFFSET   (12)
#define ATCSPI200_TIMING_CS2SCLK_DEFAULT  (0)
#define ATCSPI200_TIMING_CSHT_MASK        (BIT_MASK(11, 8))
#define ATCSPI200_TIMING_CSHT_OFFSET      (8)
#define ATCSPI200_TIMING_CSHT_DEFAULT     (0x2)
#define ATCSPI200_TIMING_SCLK_DIV_MASK    (BIT_MASK(7, 0))
#define ATCSPI200_TIMING_SCLK_DIV_OFFSET  (0)
#define ATCSPI200_TIMING_SCLK_DIV_DEFAULT (0x1)
#define ATCSPI200_TIMING_DEFAULT          ( \
		                          ATCSPI200_DEFAULT(TIMING, CS2SCLK) |\
		                          ATCSPI200_DEFAULT(TIMING, CSHT) |\
		                          ATCSPI200_DEFAULT(TIMING, SCLK_DIV) \
		                          )

// SPI Memory Access Control Register
#define ATCSPI200_MEMCTRL_MEMCTRLCHG_MASK    (BIT_MASK(8, 8))
#define ATCSPI200_MEMCTRL_MEMCTRLCHG_OFFSET  (8)
#define ATCSPI200_MEMCTRL_MEMCTRLCHG_DEFAULT (0)
#define ATCSPI200_MEMCTRL_MEMRDCMD_MASK      (BIT_MASK(3, 0))
#define ATCSPI200_MEMCTRL_MEMRDCMD_OFFSET    (0)
#define ATCSPI200_MEMCTRL_MEMRDCMD_DEFAULT   (0x0)
#define ATCSPI200_MEMCTRL_DEFAULT            ( \
		                             ATCSPI200_DEFAULT(MEMCTRL, MEMCTRLCHG) |\
		                             ATCSPI200_DEFAULT(MEMCTRL, MEMRDCMD) \
		                            )

// SPI Slave Status Register
#define ATCSPI200_SLVST_UNDERRUN_MASK	    (BIT_MASK(18, 18))
#define ATCSPI200_SLVST_UNDERRUN_OFFSET	    (18)
#define ATCSPI200_SLVST_UNDERRUN_DEFAULT    (0)
#define ATCSPI200_SLVST_OVERRUN_MASK	    (BIT_MASK(17, 17))
#define ATCSPI200_SLVST_OVERRUN_OFFSET	    (17)
#define ATCSPI200_SLVST_OVERRUN_DEFAULT	    (0)
#define ATCSPI200_SLVST_READY_MASK	    (BIT_MASK(16, 16))
#define ATCSPI200_SLVST_READY_OFFSET	    (16)
#define ATCSPI200_SLVST_READY_DEFAULT	    (0)
#define ATCSPI200_SLVST_USR_Status_MASK	    (BIT_MASK(15, 0))
#define ATCSPI200_SLVST_USR_Status_OFFSET   (0)
#define ATCSPI200_SLVST_USR_Status_DEFAULT  (0)
#define ATCSPI200_SLVST_DEFAULT             ( \
		                            ATCSPI200_DEFAULT(SLVST, UNDERRUN) |\
		                            ATCSPI200_DEFAULT(SLVST, OVERRUN) |\
		                            ATCSPI200_DEFAULT(SLVST, READY) |\
		                            ATCSPI200_DEFAULT(SLVST, USR_Status)\
                                            )

// SPI Slave Data Count Register
#define ATCSPI200_SLVDATACNT_WCNT_MASK	    (BIT_MASK(25, 16))
#define ATCSPI200_SLVDATACNT_WCNT_OFFSET    (16)
#define ATCSPI200_SLVDATACNT_WCNT_DEFAULT   (0)
#define ATCSPI200_SLVDATACNT_RCNT_MASK      (BIT_MASK(9, 0))
#define ATCSPI200_SLVDATACNT_RCNT_OFFSET    (0)
#define ATCSPI200_SLVDATACNT_RCNT_DEFAULT   (0)
#define ATCSPI200_SLVDATACNT_DEFAULT        ( \
		                            ATCSPI200_DEFAULT(SLVDATACNT, WCNT) |\
		                            ATCSPI200_DEFAULT(SLVDATACNT, RCNT) \
		                            )

// Configuration Register
#define ATCSPI200_CONFIG_SLAVE_MASK          (BIT_MASK(14, 14))
#define ATCSPI200_CONFIG_SLAVE_OFFSET        (14)
#define ATCSPI200_CONFIG_SLAVE_DEFAULT       (0)
#define ATCSPI200_CONFIG_EILMMEM_MASK        (BIT_MASK(13, 13))
#define ATCSPI200_CONFIG_EILMMEM_OFFSET      (13)
#define ATCSPI200_CONFIG_EILMMEM_DEFAULT     (0)
#define ATCSPI200_CONFIG_AHBMEM_MASK         (BIT_MASK(12, 12))
#define ATCSPI200_CONFIG_AHBMEM_OFFSET       (12)
#define ATCSPI200_CONFIG_AHBMEM_DEFAULT      (0)
#define ATCSPI200_CONFIG_DIRECTIO_MASK       (BIT_MASK(11, 11))
#define ATCSPI200_CONFIG_DIRECTIO_OFFSET     (11)
#define ATCSPI200_CONFIG_DIRECTIO_DEFAULT    (0)
#define ATCSPI200_CONFIG_QUADSPI_MASK        (BIT_MASK(9, 9))
#define ATCSPI200_CONFIG_QUADSPI_OFFSET      (9)
#define ATCSPI200_CONFIG_QUADSPI_DEFAULT     (1)
#define ATCSPI200_CONFIG_DUALSPI_MASK        (BIT_MASK(8, 8))
#define ATCSPI200_CONFIG_DUALSPI_OFFSET      (8)
#define ATCSPI200_CONFIG_DUALSPI_DEFAULT     (1)
#define ATCSPI200_CONFIG_TXFIFOSIZE_MASK     (BIT_MASK(7, 4))
#define ATCSPI200_CONFIG_TXFIFOSIZE_OFFSET   (4)
#define ATCSPI200_CONFIG_TXFIFOSIZE_DEFAULT  (0x1)
#define ATCSPI200_CONFIG_RXFIFOSIZE_MASK     (BIT_MASK(3, 0))
#define ATCSPI200_CONFIG_RXFIFOSIZE_OFFSET   (0)
#define ATCSPI200_CONFIG_RXFIFOSIZE_DEFAULT  (0x1)
#define ATCSPI200_CONFIG_DEFAULT             ( \
		                             ATCSPI200_DEFAULT(CONFIG, SLAVE) |\
		                             ATCSPI200_DEFAULT(CONFIG, EILMMEM) |\
		                             ATCSPI200_DEFAULT(CONFIG, AHBMEM) |\
		                             ATCSPI200_DEFAULT(CONFIG, DIRECTIO) |\
		                             ATCSPI200_DEFAULT(CONFIG, QUADSPI) |\
		                             ATCSPI200_DEFAULT(CONFIG, DUALSPI) |\
		                             ATCSPI200_DEFAULT(CONFIG, TXFIFOSIZE) |\
		                             ATCSPI200_DEFAULT(CONFIG, RXFIFOSIZE) \
		                             )

// ======================================================
// ATCSPI200 access macro
// ======================================================
#define ATCSPI200_SET_FIELD(var, reg, field, value)	SET_FIELD(var, ATCSPI200_##reg##_##field##_##MASK, ATCSPI200_##reg##_##field##_##OFFSET, value)

#define ATCSPI200_SET_FIELD2(var, reg, field1, value1, field2, value2) do{\
	var = ((var) & ~(ATCSPI200_##reg##_##field1##_##MASK | ATCSPI200_##reg##_##field2##_##MASK)) | \
	ATCSPI200_PREPARE(reg, field1, value1) | ATCSPI200_PREPARE(reg, field2, value2);\
}while (0)

#define ATCSPI200_SET_FIELD3(var, reg, field1, value1, field2, value2, field3, value3) do{\
	var = ((var) & ~(ATCSPI200_##reg##_##field1##_##MASK | ATCSPI200_##reg##_##field2##_##MASK | ATCSPI200_##reg##_##field3##_##MASK)) | \
	ATCSPI200_PREPARE(reg, field1, value1) | ATCSPI200_PREPARE(reg, field2, value2) | ATCSPI200_PREPARE(reg, field3, value3);\
}while (0)



#define ATCSPI200_GET_FIELD(var, reg, field)		GET_FIELD(var, ATCSPI200_##reg##_##field##_##MASK, ATCSPI200_##reg##_##field##_##OFFSET)
#define ATCSPI200_TEST_FIELD(var, reg, field)		TEST_FIELD(var, ATCSPI200_##reg##_##field##_##MASK)

#define ATCSPI200_TEST_BIT(reg, field, value)		VAR_TEST_BIT(value, ATCSPI200_##reg##_##field##_##MASK)

#define ATCSPI200_EXTRACT(reg, field, value)		EXTRACT_FIELD(value, ATCSPI200_##reg##_##field##_##MASK, ATCSPI200_##reg##_##field##_##OFFSET )
#define ATCSPI200_PREPARE(reg, field, value)		PREPARE_FIELD(value, ATCSPI200_##reg##_##field##_##MASK, ATCSPI200_##reg##_##field##_##OFFSET )

#define ATCSPI200_DEFAULT(reg, field)			PREPARE_FIELD(ATCSPI200_##reg##_##field##_##DEFAULT, ATCSPI200_##reg##_##field##_##MASK, ATCSPI200_##reg##_##field##_##OFFSET )

#endif // __ATCSPI200_H
