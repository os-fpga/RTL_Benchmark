
#ifndef __ATCDMAC300_H
#define __ATCDMAC300_H

#include "general.h"

typedef struct {
	__IO uint32_t CTRL;
	__IO uint32_t TRANSIZE;
	__IO uint32_t SRCADDRL;
	__IO uint32_t SRCADDRH;
	__IO uint32_t DSTADDRL;
	__IO uint32_t DSTADDRH;
	__IO uint32_t LLPL;
	__IO uint32_t LLPH;
} ATCDMAC300_CHANNEL_REG;

typedef struct {
	__IO  uint32_t IDREV;			// 0x000 ID and revision register
	__IO uint32_t RESERVED0[3];		// 0x004 ~ 0x00c reserved register
	__IO  uint32_t CFG;			// 0x010 configuration register
	__IO uint32_t RESERVED1[3];		// 0x014 ~ 0x01c reserved register
	__IO uint32_t CTRL;			// 0x020 control register
	__IO uint32_t CHABORT;			// 0x024 channel abort register
	__IO uint32_t RESERVED2[2];		// 0x028 ~ 0x02c reserved register
	__IO uint32_t INTSTATUS;		// 0x030 channel interrupt status register
	__IO uint32_t CHEN;			// 0x034 channel enable status register
	__IO uint32_t RESERVED3[2];		// 0x038 ~ 0x03c reserved register
        ATCDMAC300_CHANNEL_REG   CHANNEL[8];    /* 0x040 ~ 0x5c Channel #n Registers */	
} ATCDMAC300_RegDef;

typedef struct {
	uint32_t CTRL;
	uint32_t TRANSIZE;
	uint32_t SRCADDRL;
	uint32_t SRCADDRH;
	uint32_t DSTADDRL;
	uint32_t DSTADDRH;
	uint32_t LLPL;
	uint32_t LLPH;
} ATCDMAC300_CHAIN_REG;

// ATCDMAC300 ID and revision register
#define ATCDMAC300_VER_MINOR_MASK	(BIT_MASK(3, 0))	// minor revision
#define ATCDMAC300_VER_MINOR_OFFSET	(0)
#define ATCDMAC300_VER_MINOR_DEFAULT	(0x0)
#define ATCDMAC300_VER_MAJOR_MASK	(BIT_MASK(7, 4))	// major revision
#define ATCDMAC300_VER_MAJOR_OFFSET	(4)
#define ATCDMAC300_VER_MAJOR_DEFAULT	(0x0)
#define ATCDMAC300_VER_ID_MASK		(BIT_MASK(31, 8))	// ID
#define ATCDMAC300_VER_ID_OFFSET		(8)
#define ATCDMAC300_VER_ID_DEFAULT	(0x010230)
#define ATCDMAC300_VER_DEFAULT		(\
					ATCDMAC300_DEFAULT(VER, MINOR) |\
					ATCDMAC300_DEFAULT(VER, MAJOR) |\
					ATCDMAC300_DEFAULT(VER, ID) \
					)
#define ATCDMAC300_CTRL_DEFAULT			0x0
#define ATCDMAC300_ENSTATUS_DEFAULT		0x0
#define ATCDMAC300_ABT_DEFAULT			0x0
#define ATCDMAC300_TTS_WIDTH			32
// ======================================================
// ATCDMAC300 register fields
// ======================================================
#define ATCDMAC300_CFG_CHNUM_MASK		(BIT_MASK(3, 0))
#define ATCDMAC300_CFG_CHNUM_OFFSET		(0)
#define ATCDMAC300_CFG_FIFODEP_MASK		(BIT_MASK(9, 4))
#define ATCDMAC300_CFG_FIFODEP_OFFSET		(4)
#define ATCDMAC300_CFG_REQNUM_MASK		(BIT_MASK(14, 10))
#define ATCDMAC300_CFG_REQNUM_OFFSET		(10)
#define ATCDMAC300_CFG_BUSNUM_MASK		(BIT_MASK(15, 15))
#define ATCDMAC300_CFG_BUSNUM_OFFSET		(15)
#define ATCDMAC300_CFG_CORENUM_MASK		(BIT_MASK(16, 16))
#define ATCDMAC300_CFG_CORENUM_OFFSET		(16)
#define ATCDMAC300_CFG_ADDRWIDTH_MASK		(BIT_MASK(23, 17))
#define ATCDMAC300_CFG_ADDRWIDTH_OFFSET		(17)
#define ATCDMAC300_CFG_DATAWIDTH_MASK		(BIT_MASK(25, 24))
#define ATCDMAC300_CFG_DATAWIDTH_OFFSET		(24)
#define ATCDMAC300_CFG_REQSYNC_MASK		(BIT_MASK(30, 30))
#define ATCDMAC300_CFG_REQSYNC_OFFSET		(30)
#define ATCDMAC300_CFG_CHAIN_MASK		(BIT_MASK(31, 31))
#define ATCDMAC300_CFG_CHAIN_OFFSET		(31)

#define ATCDMAC300_CHCTRL_SRCBUSIF_MASK		(BIT_MASK(31,31))
#define ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET	(31)
#define ATCDMAC300_CHCTRL_DSTBUSIF_MASK		(BIT_MASK(30,30))
#define ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET	(30)
#define ATCDMAC300_CHCTRL_PRI_MASK		(BIT_MASK(29,29))
#define ATCDMAC300_CHCTRL_PRI_OFFSET		(29)
#define ATCDMAC300_CHCTRL_SRCBRST_MASK		(BIT_MASK(27,24))
#define ATCDMAC300_CHCTRL_SRCBRST_OFFSET	(24)
#define ATCDMAC300_CHCTRL_SRCWDTH_MASK		(BIT_MASK(23,21))
#define ATCDMAC300_CHCTRL_SRCWDTH_OFFSET	(21)
#define ATCDMAC300_CHCTRL_DSTWDTH_MASK		(BIT_MASK(20,18))
#define ATCDMAC300_CHCTRL_DSTWDTH_OFFSET	(18)
#define ATCDMAC300_CHCTRL_SRCMODE_MASK		(BIT_MASK(17,17))
#define ATCDMAC300_CHCTRL_SRCMODE_OFFSET	(17)
#define ATCDMAC300_CHCTRL_DSTMODE_MASK		(BIT_MASK(16,16))
#define ATCDMAC300_CHCTRL_DSTMODE_OFFSET	(16)
#define ATCDMAC300_CHCTRL_SRCADDR_MASK		(BIT_MASK(15,14))
#define ATCDMAC300_CHCTRL_SRCADDR_OFFSET	(14)
#define ATCDMAC300_CHCTRL_DSTADDR_MASK		(BIT_MASK(13,12))
#define ATCDMAC300_CHCTRL_DSTADDR_OFFSET	(12)
#define ATCDMAC300_CHCTRL_SRCREQ_MASK		(BIT_MASK(11,8))
#define ATCDMAC300_CHCTRL_SRCREQ_OFFSET		(8)
#define ATCDMAC300_CHCTRL_DSTREQ_MASK		(BIT_MASK(7,4))
#define ATCDMAC300_CHCTRL_DSTREQ_OFFSET		(4)
#define ATCDMAC300_CHCTRL_INTABT_MASK		(BIT_MASK(3,3))
#define ATCDMAC300_CHCTRL_INTABT_OFFSET		(3)
#define ATCDMAC300_CHCTRL_INTERR_MASK		(BIT_MASK(2,2))
#define ATCDMAC300_CHCTRL_INTERR_OFFSET		(2)
#define ATCDMAC300_CHCTRL_INTTC_MASK		(BIT_MASK(1,1))
#define ATCDMAC300_CHCTRL_INTTC_OFFSET		(1)
#define ATCDMAC300_CHCTRL_CHEN_MASK		(BIT_MASK(0,0))
#define ATCDMAC300_CHCTRL_CHEN_OFFSET		(0)

#define ATCDMAC300_CHCTRL_LLPL_MASK		(BIT_MASK(31,3))
#define ATCDMAC300_CHCTRL_LLPL_OFFSET		(0)
#define ATCDMAC300_CHCTRL_LLPBUSIF_MASK		(BIT_MASK(0,0))
#define ATCDMAC300_CHCTRL_LLPBUSIF_OFFSET	(0)

#define ATCDMAC300_CHSTATUS_TC_MASK		(BIT_MASK(23,16))
#define ATCDMAC300_CHSTATUS_TC_OFFSET		(16)
#define ATCDMAC300_CHSTATUS_ABT_MASK		(BIT_MASK(15,8))
#define ATCDMAC300_CHSTATUS_ABT_OFFSET		(8)
#define ATCDMAC300_CHSTATUS_ERR_MASK		(BIT_MASK(7,0))
#define ATCDMAC300_CHSTATUS_ERR_OFFSET		(0)

// ======================================================
// ATCDMAC300 function
// ======================================================
extern uint32_t remap_dmac_addrh(uintptr_t);
extern uint32_t remap_dmac_addrl(uintptr_t);
extern uintptr_t unmap_dmac_addr(uintptr_t);
extern uint32_t rand_chctrl_without_hdshake_int(uint8_t, uint8_t, uint8_t, uint8_t);
extern void rand_ch_setup(void);
extern int wait_complete_check_status(uint8_t, ATCDMAC300_RegDef *);
extern void insert_abort_resume_wait_complete(uint8_t, ATCDMAC300_RegDef *, __IO uint32_t *);
extern int data_comparison(uint8_t *, uint8_t *, uint32_t, uint8_t, uint8_t, uint8_t, uint8_t);

extern void rand_chain_without_hdshake_int(ATCDMAC300_CHAIN_REG *, ATCDMAC300_CHAIN_REG *, uint32_t, uint32_t, uint8_t, uint8_t, uint32_t, uint8_t, uint8_t);

extern ATCDMAC300_CHANNEL_REG * ch_setup[8];
extern volatile uint8_t dmac_tc_flag;
extern volatile uint8_t dmac_abt_flag;
extern volatile uint8_t dmac_err_flag;
// ======================================================
// ATCDMAC300 access macro 
// ======================================================
#define ATCDMAC300_GET_FIELD(var, reg, field)		GET_FIELD(var, ATCDMAC300_##reg##_##field##_##MASK, ATCDMAC300_##reg##_##field##_##OFFSET)
#define ATCDMAC300_SET_FIELD(var, reg, field, value)	SET_FIELD(var, ATCDMAC300_##reg##_##field##_##MASK, ATCDMAC300_##reg##_##field##_##OFFSET, value)
#define ATCDMAC300_PREPARE_FIELD(value, reg, field)	PREPARE_FIELD(value, ATCDMAC300_##reg##_##field##_##MASK, ATCDMAC300_##reg##_##field##_##OFFSET)
#define ATCDMAC300_ALIGN_MASK(var)			(~((1 << var) - 1))

#define ATCDMAC300_DEFAULT(reg, field)			PREPARE_FIELD(ATCDMAC300_##reg##_##field##_##DEFAULT, ATCDMAC300_##reg##_##field##_##MASK, ATCDMAC300_##reg##_##field##_##OFFSET )
// ======================================================
// ATCDMAC300 value macro
// ======================================================
#define ATCDMAC300_BUSIF_0		0
#define ATCDMAC300_BUSIF_1		1
#define ATCDMAC300_NORMAL_MODE		0
#define ATCDMAC300_HANDSHAKE_MODE	1
#define ATCDMAC300_UNMASK_INT		0
#define ATCDMAC300_MASK_INT		1
#define ATCDMAC300_CH_ENABLE		1
#define ATCDMAC300_CH_DISABLE		0
#define ATCDMAC300_ADDR_INC		0	// incremental address
#define ATCDMAC300_ADDR_DEC		1	// decremental address
#define ATCDMAC300_ADDR_FIX		2	// fixed address
#define ATCDMAC300_SIZE_BYTE		0	// byte size
#define ATCDMAC300_SIZE_HFWORD		1	// hfword size
#define ATCDMAC300_SIZE_WORD		2	// word size
#define ATCDMAC300_SIZE_2WORD		3	// dubble word size
#define ATCDMAC300_SIZE_4WORD		4	// four word size
#define	ATCDMAC300_MAX_CH_NUM		8
#define	ATCDMAC300_BRST_1T		0	// burst 1 transfers
#define	ATCDMAC300_BRST_2T		1	// burst 2 transfers
#define	ATCDMAC300_BRST_4T		2	// burst 4 transfers
#define	ATCDMAC300_BRST_8T		3	// burst 8 transfers
#define	ATCDMAC300_BRST_16T		4	// burst 16 transfers
#define	ATCDMAC300_BRST_32T		5	// burst 32 transfers
#define	ATCDMAC300_BRST_64T		6	// burst 64 transfers
#define	ATCDMAC300_BRST_128T		7	// burst 128 transfers
#define	ATCDMAC300_BRST_256T		8	// burst 256 transfers
#define	ATCDMAC300_BRST_512T		9	// burst 512 transfers
#define	ATCDMAC300_BRST_1024T		10	// burst 1024 transfers

#ifdef AE300_DATA_WIDTH_128
	#define	ATCDMAC300_DATA_SIZE 4
#else
	#define	ATCDMAC300_DATA_SIZE 3
#endif // AE300_DATA_WIDTH

#ifdef ATCDMAC110_DATA_WIDTH_64                 // only used in atcdmac110 compatible mode
        #define ATCDMAC110_DATA_SIZE 3
#else
        #define ATCDMAC110_DATA_SIZE 2
#endif // ATCDMAC110_DATA_WIDTH

#ifdef AE300_ADDR_WIDTH_64
	#define ATCDMAC300_ADDRH_MASK		0
	#define ATCDMAC300_ADDRH_OFFSET		32
	#define	ATCDMAC300_ADDR_WIDTH 		64
#elif AE300_ADDR_WIDTH_40
	#define ATCDMAC300_ADDRH_MASK		0
	#define ATCDMAC300_ADDRH_OFFSET		32
	#define	ATCDMAC300_ADDR_WIDTH 		40
#else
	#define ATCDMAC300_ADDRH_MASK		(1 << 32) - 1
	#define ATCDMAC300_ADDRH_OFFSET		32
	#define	ATCDMAC300_ADDR_WIDTH 		32
#endif // AE300_ADDR_WIDTH

#ifdef NDS_AE350_MULTI_HART
	#define ATCDMAC300_CHCTRL_SRCADDR_OPTIONS	2    // FIXED type transaction is not supported by L2C for cacheable space 
	#define ATCDMAC300_CHCTRL_DSTADDR_OPTIONS	2
#else
	#define ATCDMAC300_CHCTRL_SRCADDR_OPTIONS	3
	#define ATCDMAC300_CHCTRL_DSTADDR_OPTIONS	3
#endif // NDS_AE350_MULTI_HART

#endif //__ATCDMAC300_H
