#ifndef __ATFMAC100_H
#define __ATFMAC100_H

#include <inttypes.h>
#include "general.h"
#include "ndslib.h"

// ======================================================
// ATFMAC100 function
// ======================================================
extern uint32_t txr_base;              // Tx ring base address
extern uint32_t rxr_base;              // Rx ring base address
extern uint32_t txbuf_base;            // Tx buffer base address
extern uint32_t rxbuf_base;            // Rx buffer base address
extern uint32_t txr_descnt;            // Tx ring descriptor count
extern uint32_t rxr_descnt;            // Rx ring descriptor count
extern uint32_t rem_txr_descnt;        // SW renmain free Tx descriptor count 
extern uint32_t rem_rxr_descnt;        // SW renmain free Rx descriptor count 
extern uint32_t txbuf_sizeub;          // Tx buffer size upper bound
extern uint32_t rxbuf_sizeub;          // Rx buffer size upper bound
extern uint32_t txdes_wrptr;           // SW write pointer to transmit descriptor
extern uint32_t txdes_rdptr;           // SW read  pointer to transmit descriptor
extern uint32_t rxdes_rdptr;           // SW read  pointer to receive  descriptor
extern uint32_t txpkt_dah;             // Destintation high address
extern uint32_t txpkt_dal;             // Destintation low  address
extern uint32_t chk_rpkt;              //
extern uint32_t pat_err;               //
extern uint32_t sw_txpkt_size;         // SW transmit packet size
extern uint32_t sw_txpkt_num;          // SW transmit packet number
extern uint32_t sw_txpkt_rem;          // 
extern volatile uint32_t sw_rxpkt_num; // SW receive  packet number
extern volatile uint32_t hw_txpkt_num; // HW transmit packet number 

extern void chk_rpkt_cont(uint32_t, uint32_t, uint32_t, uint32_t);
extern void chk_dw_cont(uint32_t, uint32_t, uint32_t);
extern void reset_txring(uint32_t, uint32_t);
extern void set_rxring(uint32_t, uint32_t, uint32_t, uint32_t, uint32_t, uint32_t, uint32_t, uint32_t);
extern void chk_txsts();
extern void chk_phy(uint32_t);

#ifdef _C_DEBUG_PRINT
	#define	DBG_PRINTF(fmt, args...)	do { printf(fmt, ## args);} while(0)
#else
	#define	DBG_PRINTF(fmt, args...)
#endif

// ======================================================
// ATFMAC100 register definition
// ======================================================
// ATFMAC100 registers

typedef struct {
	__IO uint32_t INTST;		// (0x00) Interrupt Status Register
	__IO uint32_t INTEN;		// (0x04) Interrupt Enable Register
	__IO uint32_t MADR;		// (0x08) MAC Most Significant Address Register
	__IO uint32_t LADR;		// (0x0c) MAC Least Significant Address Register
	__IO uint32_t MAHT[2];		// (0x10 ~ 0x14) Multicast Address Hash Table 0/1 Register
	__IO uint32_t TXPD;		// (0x18) Transmit Poll Demand Register
	__IO uint32_t RXPD;		// (0x1c) Receive Poll Demand Register
	__IO uint32_t TXRBADR;		// (0x20) Transmit Ring Base Address Register
	__IO uint32_t RXRBADR;		// (0x24) Receive Ring Base Address Register
	__IO uint32_t ITC;		// (0x28) Interrupt Timer Control Register
	__IO uint32_t APTC;		// (0x2c) Automatic Polling Timer Control Register
	__IO uint32_t DBLAC;		// (0x30) DMA Burst Length and Arbitration Control Register
	__I  uint32_t REV;		// (0x34) Revision Register
	__I  uint32_t FEATURE;		// (0x38) Feature Register
	__IO uint32_t RESERVED0[19];	// (0x3c ~ 0x84) Reserved Register
	__IO uint32_t MACCTRL;		// (0x88) MAC Control Register
	__IO uint32_t MACSTATUS;	// (0x8c) MAC Status Register
	__IO uint32_t PHYCTRL;		// (0x90) PHY Control Register
	__IO uint32_t PHYWDATA;		// (0x94) PHY Write Data Register
	__IO uint32_t FCTRL;		// (0x98) Flow Control Register
	__IO uint32_t BPR;		// (0x9c) Back Pressure Register
	__IO uint32_t WOLCTRL;		// (0xa0) Wake-On-LAN Control Register
	__IO uint32_t WOLSTATUS;	// (0xa4) Wake-On-LAN Status Register
	__IO uint32_t WFCRC;		// (0xa8) Wake-up Frame CRC Register
	__IO uint32_t RESERVED1;	// (0xac) Reserved Register
	__IO uint32_t WFBM[4];		// (0xb0 ~ 0xbc) Wake-up Frame Byte Mask 1/2/3/4th Double Word Register
	__IO uint32_t RESERVED2;	// (0xc0) Reserved Register
	__IO uint32_t TSEED;		// (0xc4) Test Seed Register
	__I  uint32_t DMAFIFOS;		// (0xc8) DMA/FIFO State Register
	__IO uint32_t TMOMDE;		// (0xcc) Test Mode Register
	__IO uint32_t RESERVED3;	// (0xd0) Reserved Register
	__I  uint32_t TXMCOLSCOL;	// (0xd4) TX_MCOL and TX_SCOL Counter Register
	__I  uint32_t RPFAEP;		// (0xd8) RPF and AEP Counter Register
	__I  uint32_t XMPG;		// (0xdc) XM and PG Counter Register
	__I  uint32_t RUNTTLCC;		// (0xe0) RUNT_CNT and TLCC Counter Register
	__I  uint32_t CRCERFTL;		// (0xe4) CRCER_CNT and FTL_CNT Counter Register
	__I  uint32_t RLCRCC;		// (0xe8) RLC and RCC Counter Register
	__I  uint32_t BROC;		// (0xec) BROC Counter Register
	__I  uint32_t MULCA;		// (0xf0) MULCA Counter Register
	__I  uint32_t RP;		// (0xf4) RP Counter Register
	__I  uint32_t XP;		// (0xf8) XP Counter Register
} ATFMAC100_RegDef;



typedef struct {
   uint32_t DAH;
   uint32_t DAL;
   uint32_t buf0_badr;  // Tx buffer 0 base address
   uint32_t buf1_badr;  // Tx buffer 1 base address
   uint32_t buf2_badr;  // Tx buffer 2 base address
   uint32_t buf3_badr;  // Tx buffer 3 base address
   uint16_t buf0_size;  // Tx buffer 0 size (16K)
   uint16_t buf1_size;  // Tx buffer 1 size (16K)
   uint16_t buf2_size;  // Tx buffer 2 size (16K)
   uint16_t buf3_size;  // Tx buffer 3 size (16K)
   uint32_t des_wrptr;  
   uint32_t data_badr;
   uint32_t txbuf_size;
   uint32_t txbuf_badr;
   uint16_t VLAN_tag;   // 16-bit VLAN tag context
   uint16_t LLC_length; // LLC frame Length field
   uint8_t LLC_pkt;     // LLC packet
   uint8_t IPCS_en;     // IP checksum offload enable
   uint8_t UDPCS_en;    // UDP checksum offload enable
   uint8_t TCPCS_en;    // TCP checksum offload enable
   uint8_t insert_VLAN; //insert VLAN tag
   uint8_t des_num;     // the number of descriptor in the transmit packet, only 1,2,3,4 is allowable
   uint8_t fts;        
   uint8_t lts;        
   uint8_t txic;       
   uint8_t tx2fic;     
} TX_PKT_CFG;

// 0x00: Interrupt Status Register
#define ATFMAC100_ISR_PHYSTS_CHG_MASK    (BIT_MASK(9, 9))  //
#define ATFMAC100_ISR_PHYSTS_CHG_OFFSET  (9)           
#define ATFMAC100_ISR_AHB_ERR_MASK       (BIT_MASK(8, 8))  //
#define ATFMAC100_ISR_AHB_ERR_OFFSET     (8)           
#define ATFMAC100_ISR_RPKT_LOST_MASK     (BIT_MASK(7, 7))  //
#define ATFMAC100_ISR_RPKT_LOST_OFFSET   (7)           
#define ATFMAC100_ISR_RPKT_SAV_MASK      (BIT_MASK(6, 6))  //
#define ATFMAC100_ISR_RPKT_SAV_OFFSET    (6)           
#define ATFMAC100_ISR_XPKT_LOST_MASK     (BIT_MASK(5, 5))  //
#define ATFMAC100_ISR_XPKT_LOST_OFFSET   (5)           
#define ATFMAC100_ISR_XPKT_OK_MASK       (BIT_MASK(4, 4))  //
#define ATFMAC100_ISR_XPKT_OK_OFFSET     (4)           
#define ATFMAC100_ISR_NOTXBUF_MASK       (BIT_MASK(3, 3))  //
#define ATFMAC100_ISR_NOTXBUF_OFFSET     (3)           
#define ATFMAC100_ISR_XPKT_FINISH_MASK   (BIT_MASK(2, 2))  //
#define ATFMAC100_ISR_XPKT_FINISH_OFFSET (2)           
#define ATFMAC100_ISR_NORXBUF_MASK       (BIT_MASK(1, 1))  //
#define ATFMAC100_ISR_NORXBUF_OFFSET     (1)           
#define ATFMAC100_ISR_RPKT_FINISH_MASK   (BIT_MASK(0, 0))  //
#define ATFMAC100_ISR_RPKT_FINISH_OFFSET (0)           

// 0x04: Interrupt Enable Register
#define ATFMAC100_IME_PHYSTS_CHG_MASK    (BIT_MASK(9, 9))  //
#define ATFMAC100_IME_PHYSTS_CHG_OFFSET  (9)           
#define ATFMAC100_IME_AHB_ERR_MASK       (BIT_MASK(8, 8))  //
#define ATFMAC100_IME_AHB_ERR_OFFSET     (8)           
#define ATFMAC100_IME_RPKT_LOST_MASK     (BIT_MASK(7, 7))  //
#define ATFMAC100_IME_RPKT_LOST_OFFSET   (7)           
#define ATFMAC100_IME_RPKT_SAV_MASK      (BIT_MASK(6, 6))  //
#define ATFMAC100_IME_RPKT_SAV_OFFSET    (6)           
#define ATFMAC100_IME_XPKT_LOST_MASK     (BIT_MASK(5, 5))  //
#define ATFMAC100_IME_XPKT_LOST_OFFSET   (5)           
#define ATFMAC100_IME_XPKT_OK_MASK       (BIT_MASK(4, 4))  //
#define ATFMAC100_IME_XPKT_OK_OFFSET     (4)           
#define ATFMAC100_IME_NOTXBUF_MASK       (BIT_MASK(3, 3))  //
#define ATFMAC100_IME_NOTXBUF_OFFSET     (3)           
#define ATFMAC100_IME_XPKT_FINISH_MASK   (BIT_MASK(2, 2))  //
#define ATFMAC100_IME_XPKT_FINISH_OFFSET (2)           
#define ATFMAC100_IME_NORXBUF_MASK       (BIT_MASK(1, 1))  //
#define ATFMAC100_IME_NORXBUF_OFFSET     (1)           
#define ATFMAC100_IME_RPKT_FINISH_MASK   (BIT_MASK(0, 0))  //
#define ATFMAC100_IME_RPKT_FINISH_OFFSET (0)           

// 0x28: Interrupt Timer Control Register
#define ATFMAC100_ITC_TXINT_TIME_SEL_MASK   (BIT_MASK(15, 15))  // 
#define ATFMAC100_ITC_TXINT_TIME_SEL_OFFSET (15)           
#define ATFMAC100_ITC_TXINT_THR_MASK        (BIT_MASK(14, 12))  // 
#define ATFMAC100_ITC_TXINT_THR_OFFSET      (12)           
#define ATFMAC100_ITC_TXINT_CNT_MASK        (BIT_MASK(11, 8))  // 
#define ATFMAC100_ITC_TXINT_CNT_OFFSET      (8)           
#define ATFMAC100_ITC_RXINT_TIME_SEL_MASK   (BIT_MASK(7, 7))  // 
#define ATFMAC100_ITC_RXINT_TIME_SEL_OFFSET (7)           
#define ATFMAC100_ITC_RXINT_THR_MASK        (BIT_MASK(6, 4))  // 
#define ATFMAC100_ITC_RXINT_THR_OFFSET      (4)           
#define ATFMAC100_ITC_RXINT_CNT_MASK        (BIT_MASK(3, 0))  // 
#define ATFMAC100_ITC_RXINT_CNT_OFFSET      (0)           
 
// 0x88: MAC Control Register
#define ATFMAC100_MACCR_RX_BROADPKT_MASK      (BIT_MASK(17, 17))  //
#define ATFMAC100_MACCR_RX_BROADPKT_OFFSET    (17)           
#define ATFMAC100_MACCR_RX_MULTIPKT_MASK      (BIT_MASK(16, 16))  //
#define ATFMAC100_MACCR_RX_MULTIPKT_OFFSET    (16)           
#define ATFMAC100_MACCR_FULLDUP_MASK          (BIT_MASK(15, 15))  //
#define ATFMAC100_MACCR_FULLDUP_OFFSET        (15)           
#define ATFMAC100_MACCR_CRC_APD_MASK          (BIT_MASK(14, 14))  //
#define ATFMAC100_MACCR_CRC_APD_OFFSET        (14)           
#define ATFMAC100_MACCR_RCV_MASK              (BIT_MASK(12, 12))  //
#define ATFMAC100_MACCR_RCV_OFFSET            (12)           
#define ATFMAC100_MACCR_RX_FTL_MASK           (BIT_MASK(11, 11))  //
#define ATFMAC100_MACCR_RX_FTL_OFFSET         (11)           
#define ATFMAC100_MACCR_RX_RUNT_MASK          (BIT_MASK(10, 10))  //
#define ATFMAC100_MACCR_RX_RUNT_OFFSET        (10)           
#define ATFMAC100_MACCR_HT_MULTI_EN_MASK      (BIT_MASK(9, 9))  //
#define ATFMAC100_MACCR_HT_MULTI_EN_OFFSET    (9)           
#define ATFMAC100_MACCR_RCV_EN_MASK           (BIT_MASK(8, 8))  //
#define ATFMAC100_MACCR_RCV_EN_OFFSET         (8)           
#define ATFMAC100_MACCR_ENRX_IN_HALFTX_MASK   (BIT_MASK(6, 6))  //
#define ATFMAC100_MACCR_ENRX_IN_HALFTX_OFFSET (6)           
#define ATFMAC100_MACCR_XMT_EN_MASK           (BIT_MASK(5, 5))  //
#define ATFMAC100_MACCR_XMT_EN_OFFSET         (5)           
#define ATFMAC100_MACCR_CRC_DIS_MASK          (BIT_MASK(4, 4))  //
#define ATFMAC100_MACCR_CRC_DIS_OFFSET        (4)           
#define ATFMAC100_MACCR_LOOP_EN_MASK          (BIT_MASK(3, 3))  //
#define ATFMAC100_MACCR_LOOP_EN_OFFSET        (3)           
#define ATFMAC100_MACCR_SW_RST_MASK           (BIT_MASK(2, 2))  //
#define ATFMAC100_MACCR_SW_RST_OFFSET         (2)           
#define ATFMAC100_MACCR_RDMA_EN_MASK          (BIT_MASK(1, 1))  //
#define ATFMAC100_MACCR_RDMA_EN_OFFSET        (1)           
#define ATFMAC100_MACCR_XDMA_EN_MASK          (BIT_MASK(0, 0))  //
#define ATFMAC100_MACCR_XDMA_EN_OFFSET        (0)           

// 0x90: PHY Control Register
#define ATFMAC100_PHYCR_MIIWR_MASK      (BIT_MASK(27, 27))  // 
#define ATFMAC100_PHYCR_MIIWR_OFFSET    (27)           
#define ATFMAC100_PHYCR_MIIRD_MASK      (BIT_MASK(26, 26))  // 
#define ATFMAC100_PHYCR_MIIRD_OFFSET    (26)           
#define ATFMAC100_PHYCR_REGAD_MASK      (BIT_MASK(25, 21))  // register address
#define ATFMAC100_PHYCR_REGAD_OFFSET    (21)           
#define ATFMAC100_PHYCR_PHYAD_MASK      (BIT_MASK(20, 16))  // phy address
#define ATFMAC100_PHYCR_PHYAD_OFFSET    (16)           
#define ATFMAC100_PHYCR_MIIRDATA_MASK   (BIT_MASK(15, 0))  // rdata
#define ATFMAC100_PHYCR_MIIRDATA_OFFSET (0)           

// 0x94: PHY Write Data Register
#define ATFMAC100_PHYWDATA_MIIWDATA_MASK   (BIT_MASK(15, 0))  // wdata
#define ATFMAC100_PHYWDATA_MIIWDATA_OFFSET (0)           

// 0xa0: Wake-On-LAN Control Register
#define ATFMAC100_WOLCR_WOL_TYPE_MASK      (BIT_MASK(25, 24))  //
#define ATFMAC100_WOLCR_WOL_TYPE_OFFSET    (24)           
#define ATFMAC100_WOLCR_SW_PDNPHY_MASK     (BIT_MASK(18, 18))  //
#define ATFMAC100_WOLCR_SW_PDNPHY_OFFSET   (18)           
#define ATFMAC100_WOLCR_WAKEUP_SEL_MASK    (BIT_MASK(17, 16))  //
#define ATFMAC100_WOLCR_WAKEUP_SEL_OFFSET  (16)           
#define ATFMAC100_WOLCR_PWRSAV_MASK        (BIT_MASK(15, 15))  //
#define ATFMAC100_WOLCR_PWRSAV_OFFSET      (15)           
#define ATFMAC100_WOLCR_WAKEUP4_EN_MASK    (BIT_MASK(6, 6))  //
#define ATFMAC100_WOLCR_WAKEUP4_EN_OFFSET  (6)           
#define ATFMAC100_WOLCR_WAKEUP3_EN_MASK    (BIT_MASK(5, 5))  //
#define ATFMAC100_WOLCR_WAKEUP3_EN_OFFSET  (5)           
#define ATFMAC100_WOLCR_WAKEUP2_EN_MASK    (BIT_MASK(4, 4))  //
#define ATFMAC100_WOLCR_WAKEUP2_EN_OFFSET  (4)           
#define ATFMAC100_WOLCR_WAKEUP1_EN_MASK    (BIT_MASK(3, 3))  //
#define ATFMAC100_WOLCR_WAKEUP1_EN_OFFSET  (3)           
#define ATFMAC100_WOLCR_MAGICPKT_EN_MASK   (BIT_MASK(2, 2))  //
#define ATFMAC100_WOLCR_MAGICPKT_EN_OFFSET (2)           
#define ATFMAC100_WOLCR_LINKCHG1_EN_MASK   (BIT_MASK(1, 1))  // read data
#define ATFMAC100_WOLCR_LINKCHG1_EN_OFFSET (1)          
#define ATFMAC100_WOLCR_LINKCHG0_EN_MASK   (BIT_MASK(0, 0))  // write data
#define ATFMAC100_WOLCR_LINKCHG0_EN_OFFSET (0)           

// 0xa4: Wake-On-LAN Status Register
#define ATFMAC100_WOLSR_WAKEUP4_STS_MASK    (BIT_MASK(6, 6))  //
#define ATFMAC100_WOLSR_WAKEUP4_STS_OFFSET  (6)           
#define ATFMAC100_WOLSR_WAKEUP3_STS_MASK    (BIT_MASK(5, 5))  //
#define ATFMAC100_WOLSR_WAKEUP3_STS_OFFSET  (5)           
#define ATFMAC100_WOLSR_WAKEUP2_STS_MASK    (BIT_MASK(4, 4))  //
#define ATFMAC100_WOLSR_WAKEUP2_STS_OFFSET  (4)           
#define ATFMAC100_WOLSR_WAKEUP1_STS_MASK    (BIT_MASK(3, 3))  //
#define ATFMAC100_WOLSR_WAKEUP1_STS_OFFSET  (3)           
#define ATFMAC100_WOLSR_MAGICPKT_STS_MASK   (BIT_MASK(2, 2))  //
#define ATFMAC100_WOLSR_MAGICPKT_STS_OFFSET (2)           
#define ATFMAC100_WOLSR_LINKCHG1_STS_MASK   (BIT_MASK(1, 1))  // read data
#define ATFMAC100_WOLSR_LINKCHG1_STS_OFFSET (1)          
#define ATFMAC100_WOLSR_LINKCHG0_STS_MASK   (BIT_MASK(0, 0))  // write data
#define ATFMAC100_WOLSR_LINKCHG0_STS_OFFSET (0)           


// ======================================================
// Pseudo timer 
// ======================================================
typedef struct{
	uint32_t  tick;
	uint32_t  alarm;
} TIMER_P; 

#define TIMER_INIT(t, a)      do {t.tick=0;t.alarm=a;} while(0)
#define TIMER_IS_TIMEOUT(t)   (t.tick>=t.alarm)
#define TIMER_NOT_TIMEOUT(t)  (t.tick<t.alarm)
#define TIMER_TICK(t)         (t.tick++)
#define TIMER_TIME(t)         (t.tick)

// ======================================================
// ATFMAC100 error number 
// ======================================================
#define ATFMAC100_ERR_RXPKT_VLAN  (-1)  // wrong rx vlan
#define ATFMAC100_ERR_RXPKT_DESC  (-2)  // wrong rx description
#define ATFMAC100_ERR_RXPKT_DATA  (-3)  // wrong rx data
#define ATFMAC100_ERR_RXPKT_NO    (-4)  // wrong rx packet number
#define ATFMAC100_ERR_TIMEOUT     (-5)  // timeout
#define ATFMAC100_ERR_DLM_CONFIG  (-6)  // wrong dlm config
#define ATFMAC100_ERR_RX_UNDERRUN (-7)  // under run
#define ATFMAC100_ERR_WRONG_INT   (-8)  // wrong interrupt
#define ATFMAC100_ERR_TXPKT_DATA  (-9)	// wrong tx data
#define ATFMAC100_ERR_TXPKT_NO    (-10)	// wrong tx packet number

// ======================================================
// ATFMAC100 access macro 
// ======================================================
#define ATFMAC100_SET_FIELD(var, reg, field, value) SET_FIELD(var, ATFMAC100_##reg##_##field##_##MASK, ATFMAC100_##reg##_##field##_##OFFSET, value)
#define ATFMAC100_GET_FIELD(var, reg, field)        GET_FIELD(var, ATFMAC100_##reg##_##field##_##MASK, ATFMAC100_##reg##_##field##_##OFFSET)
#define ATFMAC100_TEST_FIELD(var, reg, field)       TEST_FIELD(var, ATFMAC100_##reg##_##field##_##MASK)

#define ATFMAC100_TEST_BIT(reg, field, value)       VAR_TEST_BIT(value, ATFMAC100_##reg##_##field##_##MASK)

#define ATFMAC100_EXTRACT(reg, field, value)        EXTRACT_FIELD(value, ATFMAC100_##reg##_##field##_##MASK, ATFMAC100_##reg##_##field##_##OFFSET )
#define ATFMAC100_PREPARE(reg, field, value)        PREPARE_FIELD(value, ATFMAC100_##reg##_##field##_##MASK, ATFMAC100_##reg##_##field##_##OFFSET )

#define ATFMAC100_DEFAULT(reg, field)               PREPARE_FIELD(ATFMAC100_##reg##_##field##_##DEFAULT, ATFMAC100_##reg##_##field##_##MASK, ATFMAC100_##reg##_##field##_##OFFSET )

#endif // __ATFMAC100_H

