#ifndef __ATFSDC010_H
#define __ATFSDC010_H

#include <inttypes.h>
#include "general.h"


typedef struct {
	__IO uint32_t CMD;			// (0x00) Command register
	__IO uint32_t ARG;			// (0x04) Argument register
	__I  uint32_t RESP[4];			// (0x08 ~ 0x0c) Response register0
	__I  uint32_t RESPCMD;			// (0x18) Responded command register
	__IO uint32_t DATACTRL;			// (0x1c) Data control register
	__IO uint32_t DATATIMER;		// (0x20) Data timer register
	__IO uint32_t DATALEN;			// (0x24) Data length register
	__I  uint32_t STATUS;			// (0x28) Status register
	__IO uint32_t CLEAR;			// (0x2c) Clear register
	__IO uint32_t INTMASK;			// (0x30) Interrupt mask register
	__IO uint32_t PWCTRL;			// (0x34) Power control register
	__IO uint32_t CKCTRL;			// (0x38) Clock control register
	__IO uint32_t BWIDTH;			// (0x3c) Bus width register
	__IO uint32_t DATAWINDOW;		// (0x40) Data window register
	__IO uint32_t MMCINT;			// (0x44) MMC interrupt response time register
	__IO uint32_t GPO;			// (0x48) General purpose output
	__IO uint32_t RESERVED0[8];		// (0x4c ~ 0x68)
	__IO uint32_t SDIOCTRL[2];		// (0x6c ~ 0c70 ) SDIO control register1/2
	__I  uint32_t SDIOSTATUS;		// (0x74) SDIO status register
	__IO uint32_t RESERVED1[9];		// (0x78 ~ 0x98) 
	__I  uint32_t FEATURE;			// (0x9c) Feature register 
	__I  uint32_t REV;			// (0xa0) Revision register
} ATFSDC010_RegDef;


// 0x00: Command Register
#define ATFSDC010_CMD_MMC_INTSTOP_MASK     (BIT_MASK(11, 11)) 
#define ATFSDC010_CMD_MMC_INTSTOP_OFFSET   (11) 
#define ATFSDC010_CMD_RST_MASK             (BIT_MASK(10, 10)) 
#define ATFSDC010_CMD_RST_OFFSET           (10) 
#define ATFSDC010_CMD_EN_MASK              (BIT_MASK(9, 9)) 
#define ATFSDC010_CMD_EN_OFFSET            (9) 
#define ATFSDC010_CMD_APP_MASK             (BIT_MASK(8, 8)) 
#define ATFSDC010_CMD_APP_OFFSET           (8) 
#define ATFSDC010_CMD_LONGRSP_MASK         (BIT_MASK(7, 7)) 
#define ATFSDC010_CMD_LONGRSP_OFFSET       (7) 
#define ATFSDC010_CMD_NEEDRSP_MASK         (BIT_MASK(6, 6)) 
#define ATFSDC010_CMD_NEEDRSP_OFFSET       (6) 
#define ATFSDC010_CMD_IDX_MASK             (BIT_MASK(5, 0)) 
#define ATFSDC010_CMD_IDX_OFFSET           (0) 

// 0x1C: Data Control Register
#define ATFSDC010_DCR_FIFO_RST_MASK     (BIT_MASK(10, 10)) 
#define ATFSDC010_DCR_FIFO_RST_OFFSET   (10) 
#define ATFSDC010_DCR_DMA_TYPE_MASK     (BIT_MASK(9, 8)) 
#define ATFSDC010_DCR_DMA_TYPE_OFFSET   (8) 
#define ATFSDC010_DCR_FIFO_TH_MASK      (BIT_MASK(7, 7)) 
#define ATFSDC010_DCR_FIFO_TH_OFFSET    (7) 
#define ATFSDC010_DCR_DATA_EN_MASK      (BIT_MASK(6, 6)) 
#define ATFSDC010_DCR_DATA_EN_OFFSET    (6) 
#define ATFSDC010_DCR_DMA_EN_MASK       (BIT_MASK(5, 5)) 
#define ATFSDC010_DCR_DMA_EN_OFFSET     (5) 
#define ATFSDC010_DCR_DATA_W_MASK       (BIT_MASK(4, 4)) 
#define ATFSDC010_DCR_DATA_W_OFFSET     (4) 
#define ATFSDC010_DCR_BLK_SIZE_MASK     (BIT_MASK(3, 0)) 
#define ATFSDC010_DCR_BLK_SIZE_OFFSET   (0) 

// 0x20: Data Timer Register
#define ATFSDC010_DATA_TIMER_MASK     (BIT_MASK(31, 0)) 
#define ATFSDC010_DATA_TIMER_OFFSET   (0) 

// 0x24: Data Length Register
#define ATFSDC010_DATA_LEN_MASK       (BIT_MASK(31, 0)) 
#define ATFSDC010_DATA_LEN_OFFSET     (0)

// 0x28: Status Register
#define ATFSDC010_ST_DATA0_MASK           (BIT_MASK(17, 17)) 
#define ATFSDC010_ST_DATA0_OFFSET         (17) 
#define ATFSDC010_ST_SDIO_IRPT_MASK       (BIT_MASK(16, 16)) 
#define ATFSDC010_ST_SDIO_IRPT_OFFSET     (16) 
#define ATFSDC010_ST_WRITE_PROT_MASK      (BIT_MASK(12, 12)) 
#define ATFSDC010_ST_WRITE_PROT_OFFSET    (12) 
#define ATFSDC010_ST_CARD_DETECT_MASK     (BIT_MASK(11, 11)) 
#define ATFSDC010_ST_CARD_DETECT_OFFSET   (11) 
#define ATFSDC010_ST_CARD_CHANGE_MASK     (BIT_MASK(10, 10)) 
#define ATFSDC010_ST_CARD_CHANGE_OFFSET   (10) 
#define ATFSDC010_ST_FIFO_ORUN_MASK       (BIT_MASK(9, 9)) 
#define ATFSDC010_ST_FIFO_ORUN_OFFSET     (9) 
#define ATFSDC010_ST_FIFO_URUN_MASK       (BIT_MASK(8, 8)) 
#define ATFSDC010_ST_FIFO_URUN_OFFSET     (8) 
#define ATFSDC010_ST_DATA_END_MASK        (BIT_MASK(7, 7)) 
#define ATFSDC010_ST_DATA_END_OFFSET      (7) 
#define ATFSDC010_ST_CMD_SENT_MASK        (BIT_MASK(6, 6)) 
#define ATFSDC010_ST_CMD_SENT_OFFSET      (6) 
#define ATFSDC010_ST_DATA_CRCOK_MASK      (BIT_MASK(5, 5)) 
#define ATFSDC010_ST_DATA_CRCOK_OFFSET    (5) 
#define ATFSDC010_ST_RSP_CRCOK_MASK       (BIT_MASK(4, 4)) 
#define ATFSDC010_ST_RSP_CRCOK_OFFSET     (4) 
#define ATFSDC010_ST_DATA_TIMEOUT_MASK    (BIT_MASK(3, 3)) 
#define ATFSDC010_ST_DATA_TIMEOUT_OFFSET  (3) 
#define ATFSDC010_ST_RSP_TIMEOUT_MASK     (BIT_MASK(2, 2)) 
#define ATFSDC010_ST_RSP_TIMEOUT_OFFSET   (2) 
#define ATFSDC010_ST_DATA_CRCFAIL_MASK    (BIT_MASK(1, 1)) 
#define ATFSDC010_ST_DATA_CRCFAIL_OFFSET  (1) 
#define ATFSDC010_ST_RSP_CRCFAIL_MASK     (BIT_MASK(0, 0)) 
#define ATFSDC010_ST_RSP_CRCFAIL_OFFSET   (0) 


// 0x38: Clock Control Register
#define ATFSDC010_CLK_DIS_MASK     (BIT_MASK(8, 8)) 
#define ATFSDC010_CLK_DIS_OFFSET   (8) 
#define ATFSDC010_CLK_SD_MASK      (BIT_MASK(7, 7)) 
#define ATFSDC010_CLK_SD_OFFSET    (7) 
#define ATFSDC010_CLK_DIV_MASK     (BIT_MASK(6, 0)) 
#define ATFSDC010_CLK_DIV_OFFSET   (0) 

// 0x3C: Bus Width Register
#define ATFSDC010_BW_DETECT_MASK    (BIT_MASK(5, 5)) 
#define ATFSDC010_BW_DETECT_OFFSET  (5) 
#define ATFSDC010_BW_WIDE4_MASK     (BIT_MASK(2, 2)) 
#define ATFSDC010_BW_WIDE4_OFFSET   (2) 
#define ATFSDC010_BW_WIDE8_MASK     (BIT_MASK(1, 1)) 
#define ATFSDC010_BW_WIDE8_OFFSET   (1) 
#define ATFSDC010_BW_WIDE1_MASK     (BIT_MASK(0, 0)) 
#define ATFSDC010_BW_WIDE1_OFFSET   (0) 

// 0x6C: SDIO Control Register1
#define ATFSDC010_SDIOCR1_BLKNO_MASK        (BIT_MASK(31, 15)) 
#define ATFSDC010_SDIOCR1_BLKNO_OFFSET      (15) 
#define ATFSDC010_SDIOCR1_EN_MASK           (BIT_MASK(14, 14)) 
#define ATFSDC010_SDIOCR1_EN_OFFSET         (14) 
#define ATFSDC010_SDIOCR1_READWAIT_MASK     (BIT_MASK(13, 13)) 
#define ATFSDC010_SDIOCR1_READWAIT_OFFSET   (13) 
#define ATFSDC010_SDIOCR1_BLKMODE_MASK      (BIT_MASK(12, 12)) 
#define ATFSDC010_SDIOCR1_BLKMODE_OFFSET    (12) 
#define ATFSDC010_SDIOCR1_BLKSIZE_MASK      (BIT_MASK(11, 0)) 
#define ATFSDC010_SDIOCR1_BLKSIZE_OFFSET    (0) 

// 0x9C: Feature Register
#define ATFSDC010_FEATURE_FIFODEPTH_MASK      (BIT_MASK(7, 0)) 
#define ATFSDC010_FEATURE_FIFODEPTH_OFFSET    (0) 

//#define ATFSDC010___MASK     (BIT_MASK(, )) 
//#define ATFSDC010___OFFSET   () 

// ======================================================
// SDC INDEX CMD Mapping
// ======================================================
#define ATFSDC010_CMDIDX_GO_IDLE_STATE           0
#define ATFSDC010_CMDIDX_MMC_OP_COND             1
#define ATFSDC010_CMDIDX_ALL_SEND_CID            2
#define ATFSDC010_CMDIDX_SEND_RELATIVE_ADDR      3
#define ATFSDC010_CMDIDX_SET_DSR                 4
#define ATFSDC010_CMDIDX_SELECT_CARD             7
#define ATFSDC010_CMDIDX_SEND_CSD                9
#define ATFSDC010_CMDIDX_SEND_CID                10
#define ATFSDC010_CMDIDX_STOP_TRANSMISSION       12
#define ATFSDC010_CMDIDX_SEND_STATUS             13
#define ATFSDC010_CMDIDX_GO_INACTIVE_STATE       15
#define ATFSDC010_CMDIDX_SET_BLOCKLEN            16
#define ATFSDC010_CMDIDX_READ_SINGLE_BLOCK       17
#define ATFSDC010_CMDIDX_READ_MULTIPLE_BLOCK     18
#define ATFSDC010_CMDIDX_WRITE_SINGLE_BLOCK      24
#define ATFSDC010_CMDIDX_WRITE_MULTIPLE_BLOCK    25
#define ATFSDC010_CMDIDX_PROGRAM_CSD             27
#define ATFSDC010_CMDIDX_ERASE_SECTOR_START      32
#define ATFSDC010_CMDIDX_ERASE_SECTOR_END        33
#define ATFSDC010_CMDIDX_ERASE                   38
#define ATFSDC010_CMDIDX_LOCK_UNLOCK             42
#define ATFSDC010_CMDIDX_APP                     55
#define ATFSDC010_CMDIDX_GET                     56

// ======================================================
// SDC Status definition
// ======================================================
#define ATFSDC010_ST_RSP_CRCOK           0x010
#define ATFSDC010_ST_DATA_CRCOK          0x020
#define ATFSDC010_ST_DATA_END            0x080
#define ATFSDC010_ST_FIFO_URUN           0x100

// ======================================================
// ATFSDC010 function
// ======================================================
extern void poll_cmd_sent();
extern void poll_rsp();
extern void poll_data_crc();
extern void poll_fifo_urun();
extern void poll_fifo_orun();
extern void poll_data_end();

// Global variable
extern volatile uint32_t sdc_isr_flag;

// ======================================================
// ATFSDC010 access macro 
// ======================================================
#define ATFSDC010_SET_FIELD(var, reg, field, value) SET_FIELD(var, ATFSDC010_##reg##_##field##_##MASK, ATFSDC010_##reg##_##field##_##OFFSET, value)
#define ATFSDC010_GET_FIELD(var, reg, field)        GET_FIELD(var, ATFSDC010_##reg##_##field##_##MASK, ATFSDC010_##reg##_##field##_##OFFSET)
#define ATFSDC010_TEST_FIELD(var, reg, field)       TEST_FIELD(var, ATFSDC010_##reg##_##field##_##MASK)

#define ATFSDC010_TEST_BIT(reg, field, value)       VAR_TEST_BIT(value, ATFSDC010_##reg##_##field##_##MASK)

#define ATFSDC010_EXTRACT(reg, field, value)        EXTRACT_FIELD(value, ATFSDC010_##reg##_##field##_##MASK, ATFSDC010_##reg##_##field##_##OFFSET )
#define ATFSDC010_PREPARE(reg, field, value)        PREPARE_FIELD(value, ATFSDC010_##reg##_##field##_##MASK, ATFSDC010_##reg##_##field##_##OFFSET )

#define ATFSDC010_DEFAULT(reg, field)               PREPARE_FIELD(ATFSDC010_##reg##_##field##_##DEFAULT, ATFSDC010_##reg##_##field##_##MASK, ATFSDC010_##reg##_##field##_##OFFSET )

#endif // __ATFSDC010_H

