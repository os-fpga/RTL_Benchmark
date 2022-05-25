
#ifndef __TRI_MODE_MAC_H__
#define __TRI_MODE_MAC_H__

#ifdef __cplusplus
extern "C" {
#endif

#include "xil_types.h"

// 
#define MARVELL_PHY_ID          (0x0141)
#define MARVELL_PHY_MODEL       (0x0CC0)    // 88E1111: [9:4] == 00100
#define MARVELL_PHY_MODEL_MSK   (0x0FF0)    

#define MARVELL_PHY_ID_OK(x)    (x == MARVELL_PHY_ID)
#define MARVELL_PHY_MODEL_OK(x) ((x & MARVELL_PHY_MODEL_MSK) == MARVELL_PHY_MODEL)
// 
#define MARVELL_PHY_RGMII       (0x0B)      // 88E1111Datasheet_Rev_J.pdf: HWCFG_MODE[3:0] == 1011 / reg 0_27


// Management configuration register address     (0x500)
#define CONFIG_MANAGEMENT_ADD   0x0500
// Flow control configuration register address   (0x40C)
#define CONFIG_FLOW_CTRL_ADD    0x040C

// Receiver configuration register address       (0x404)
#define RECEIVER_ADD            0x0404

// Transmitter configuration register address    (0x408)
#define TRANSMITTER_ADD         0x0408

// Speed configuration register address    (0x410)
#define SPEED_CONFIG_ADD        0x0410

// Unicast Word 0 configuration register address (0x700)
#define CONFIG_UNI0_CTRL_ADD    0x0700

// Unicast Word 1 configuration register address (0x704)
#define CONFIG_UNI1_CTRL_ADD    0x0704

// Address Filter configuration register address (0x708)
#define CONFIG_ADDR_CTRL_ADD    0x0708


// MDIO registers
#define MDIO_CONTROL            0x0504
#define MDIO_TX_DATA            0x0508
#define MDIO_RX_DATA            0x050C
// MDIO IF op
#define MDIO_OP_RD              2
#define MDIO_OP_WR              1
//

//#define IORD_XLNX_TEMAC_MDIO(base, reg) 
//#define IOWR_XLNX_TEMAC_MDIO(base, reg) 

/* IEEE PHY register definition */
enum {
    TSE_PHY_MDIO_CONTROL     = 0,
    TSE_PHY_MDIO_STATUS      = 1,
    TSE_PHY_MDIO_PHY_ID1     = 2,
    TSE_PHY_MDIO_PHY_ID2     = 3,
    TSE_PHY_MDIO_ADV         = 4,
    TSE_PHY_MDIO_REMADV      = 5,
    
    TSE_PHY_MDIO_AN_EXT              = 6,
    TSE_PHY_MDIO_1000BASE_T_CTRL     = 9,
    TSE_PHY_MDIO_1000BASE_T_STATUS   = 10,
    TSE_PHY_MDIO_EXT_STATUS          = 15
};
#define MRVL_PHY_MDIO_SPEC_STS_C    (17) // 88E1111Datasheet_Rev_J.pdf: Page 0, Register 17
#define MRVL_PHY_MDIO_ESPEC_CTRL    (20) // 88E1111Datasheet_Rev_J.pdf: Page Any, Registe 20
#define MRVL_PHY_MDIO_ESPEC_STS     (27) // 88E1111Datasheet_Rev_J.pdf: Page Any, Registe 27

typedef struct {
    // base-addr
    u32 base;
    // mac
    u32 mac_high;
    u32 mac_low;
    // ip-addr
    u32 ip_addr;
} tmemac_cfg_t;


int tri_mode_emac_init(tmemac_cfg_t *iv_tmemac_cfg);

#ifdef __cplusplus
}
#endif

#endif // __TRI_MODE_MAC_H__
