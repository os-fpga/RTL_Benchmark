// base: tri_mode_ethernet_mac_0_axi_lite_sm

#include <stdio.h>

#include "xil_io.h"
//#include "xstatus.h"

#include "tri_mode_emac.h"

#define TMEMAC_MDIO_TOUT    (0x1FFFFFFF)
#define TMEMAC_AN_TOUT      (0x1FFFFFFF)

// KC705 Evaluation Board Features:
//  ..On power-up, or on reset, the PHY is configured to operate in GMII mode with PHY address
//  0b00111 using the settings shown in Table 1-17. These settings can be overwritten via
//  software commands passed over the MDIO interface.
//  {Table 1-17: Board Connections for PHY Configuration Pins}
//
// 88E1111Datasheet_Rev_J.pdf:
//  2.3.4 Mode Switching
//  reg: 0_4, 0_1.12, 0_27.12, 
//  HWCFG_MODE[3:0] == 1011



// 
u32 u32_tmemac_base;// = XPAR_TMEMAC_0_BASEADDR;
// 
int phy_addr;
int phy_id1;
int phy_id2;
int phy_link_speed;
int phy_duplex;
/**/
int tri_mode_emac_phy_cfg(void);
int tri_mode_emac_phy_det(void);
int tmemac_phy_rd_reg(u8 reg_addr);
int tmemac_phy_wr_reg(u8 reg_addr, u16 reg_data);
/**/

int tri_mode_emac_init(tmemac_cfg_t *iv_tmemac_cfg)
{
    // dec vars
    int Value;

    // wr base
    u32_tmemac_base = iv_tmemac_cfg->base;

    // -> STARTUP
    Xil_Out32(u32_tmemac_base+CONFIG_MANAGEMENT_ADD, (1 << 6) | (24)); // MDIO Enable[6], Clock Divide[5:0]
    // -> UPDATE_SPEED
    Value = Xil_In32(u32_tmemac_base+SPEED_CONFIG_ADD);
    if (Value == 0) {
        Xil_Out32(+SPEED_CONFIG_ADD, (2 << 30)); // 2'b10 == 1Gbps, 
    }
    //xil_printf("ms=%x\n", Xil_In32(u32_tmemac_base+SPEED_CONFIG_ADD));
    // PHY cfg
    Value = tri_mode_emac_phy_cfg();
    if (Value < 0) {
        return Value;
    }
    
    // Reseting MAC RX
    Xil_Out32(u32_tmemac_base+RECEIVER_ADD, (1 << 31) | (1 << 28)); // Reset, Receiver Enable
    // Reseting MAC TX
    Xil_Out32(u32_tmemac_base+TRANSMITTER_ADD, (1 << 31) | (1 << 28)); // Reset, Transmit Enable
    // Disabling Flow control
    Xil_Out32(u32_tmemac_base+CONFIG_FLOW_CTRL_ADD, 0);
    // Configuring unicast address
    Xil_Out32(u32_tmemac_base+CONFIG_UNI1_CTRL_ADD, iv_tmemac_cfg->mac_high);   // high word
    Xil_Out32(u32_tmemac_base+CONFIG_UNI0_CTRL_ADD, iv_tmemac_cfg->mac_low);    // low ..
    // Setting core to promiscuous mode
    Xil_Out32(u32_tmemac_base+CONFIG_ADDR_CTRL_ADD, (1 << 31));
    
    // Final
    return 0;
}

int tri_mode_emac_phy_cfg(void)
{
#ifndef MSIM
    // dec vars
    int Value;
    u32 x;
    
    // PHY det
    if (tri_mode_emac_phy_det()) {
        return -1;
    }
    // further phy-cfg:
    // TSE_PHY_MDIO_1000BASE_T_CTRL
    if (tmemac_phy_wr_reg(TSE_PHY_MDIO_1000BASE_T_CTRL, 1 << 9)) { // 1G Full-Duplex
        return -2;
    }
    // TSE_PHY_MDIO_ADV
    if (tmemac_phy_wr_reg(TSE_PHY_MDIO_ADV, (1 << 8) | (1 << 6))) { // 100M Full-Duplex, 10M Full-Duplex
        return -3;
    }
    // HWCFG_MODE[3:0] == RGMII 
    Value = tmemac_phy_rd_reg(MRVL_PHY_MDIO_ESPEC_STS);
    Value &= ~(0x0F);
    Value |= MARVELL_PHY_RGMII; // [3:0] == 1011
    if (tmemac_phy_wr_reg(MRVL_PHY_MDIO_ESPEC_STS, Value)) {
        return -4;
    }
    // add/remove the clock delay
    Value = tmemac_phy_rd_reg(MRVL_PHY_MDIO_ESPEC_CTRL);
    Value &= ~((1 << 7) | (1 << 1));
    Value |= (1 << 7) | (0 << 1); // tri_mode_ethernet_mac_0_axi_lite_sm.v, MDIO_DELAY_RD_POLL
    if (tmemac_phy_wr_reg(MRVL_PHY_MDIO_ESPEC_CTRL, Value)) {
        return -5;
    }
    // set autoneg and reset
    Value = (1 << 15) | (1 << 12); // bit15: software reset, bit12 : AN enable (set after power up)
    if (tmemac_phy_wr_reg(TSE_PHY_MDIO_CONTROL, Value)) {
        return -6;
    }
    // w8 4 rst-low
    x = 0;
    do {
        Value = tmemac_phy_rd_reg(TSE_PHY_MDIO_CONTROL);
        if (++x == TMEMAC_AN_TOUT) {
            return -7;
        }
    } while((Value & (1 << 15)) == 1); // .. When the reset operation is done, this bit is cleared to 0 automatically.
    //xil_printf(" [phy_rst ] reg 0_0 = 0x%04x\n\r", Value);
    // Wait for Autonegotiation to complete
    x = 0;
    do {
        // useful ibala
        {
            volatile int wait;
            for (wait=0; wait < 100000; wait++);
            for (wait=0; wait < 100000; wait++);
        }
        // 
        Value = tmemac_phy_rd_reg(TSE_PHY_MDIO_STATUS);
        if (Value == -1) {
            return -8;
        }
        // 
        if (++x == TMEMAC_AN_TOUT) {
            xil_printf("ERR: Auto-Negotiation FAILED, STATUS: 0x%04x\n\r", tmemac_phy_rd_reg(TSE_PHY_MDIO_STATUS));
            return -9;
        }
    } while((Value & (1 << 5)) == 0);
    xil_printf(" [phy_rst ] OK, reg 0_1 = 0x%04x\n\r", Value);
    // get PHY-{Speed+Duplex}
    Value = tmemac_phy_rd_reg(MRVL_PHY_MDIO_SPEC_STS_C);
    if (Value == -1) { 
        return -10; 
    }
    //xil_printf("reg 0_17 = 0x%04x\n", Value);
    phy_duplex = Value && (1 << 13);
    phy_link_speed =    (Value && (1 << 15))?  1000 :
                        (Value && (1 << 14))?   100 :
                                                 10 ;
    xil_printf(" [phy_cfg ] Speed is 0x%x  Full Duplex is %x\n\r", phy_link_speed, phy_duplex);
#else
    phy_link_speed = 1000;
    phy_duplex = 1;
    printf(" [phy_init] MSIM: found Marvell 88E1111 PHY\n");
    printf(" [phy_cfg ] MSIM: Speed is %d  Full Duplex is %d\n", phy_link_speed, phy_duplex);
#endif // MSIM
    // Final
    return 0;
}

int tri_mode_emac_phy_det(void) // phy detection
{
    for (phy_addr = 0; phy_addr < 32; phy_addr++) {
        // TSE_PHY_MDIO_PHY_ID1
        phy_id1 = tmemac_phy_rd_reg(TSE_PHY_MDIO_PHY_ID1);
        if (phy_id1 == -1) { return -1; }
        // TSE_PHY_MDIO_PHY_ID2
        phy_id2 = tmemac_phy_rd_reg(TSE_PHY_MDIO_PHY_ID2);
        if (phy_id2 == -1) { return -1; }
        // check
        if (phy_id1 != phy_id2) {
            //xil_printf(" [phy_init] phyID = 0x%02x 0x%04x 0x%04x\n", phy_addr, phy_id1, phy_id2);
            // 
            if (MARVELL_PHY_ID_OK(phy_id1) & MARVELL_PHY_MODEL_OK(phy_id2)) {
                xil_printf(" [phy_init] found Marvell 88E1111 PHY\n\r");
                return 0;
            }
            // 
            break;
        }
    }
    return -1;
}

int tmemac_phy_rd_reg(u8 reg_addr) // phy reg-read
{
    u32 Value, j;
    // poll MDIO sts
    do {
        Value = Xil_In32(u32_tmemac_base+MDIO_CONTROL);
        if (++j == TMEMAC_MDIO_TOUT) {
            return -1;
        }
    } while((Value & (1 << 7)) == 0);// MDIO Control Word (0x504), [7] == MDIO ready: When set ..  previous transaction has completed..
    // post RD-req
    Value = (phy_addr << 24) |      // TX_PHYAD
            (reg_addr << 16) |      // TX_REGAD
            (MDIO_OP_RD << 14) |    // TX_OP
            (1 << 11);              // Initiate
    Xil_Out32(u32_tmemac_base+MDIO_CONTROL, Value);
    // poll RD-resp
    do {
        Value = Xil_In32(u32_tmemac_base+MDIO_RX_DATA);
        if (++j == TMEMAC_MDIO_TOUT) {
            return -1;
        }
    } while((Value & (1 << 16)) == 0);
    // Final
    return (Value & 0x0000FFFF); // [15:0]
}

int tmemac_phy_wr_reg(u8 reg_addr, u16 reg_data) // phy reg-write
{
    u32 Value, j;
    // poll MDIO sts
    do {
        Value = Xil_In32(u32_tmemac_base+MDIO_CONTROL);
        if (++j == TMEMAC_MDIO_TOUT) {
            return -1;
        }
    } while((Value & (1 << 7)) == 0);// MDIO Control Word (0x504), [7] == MDIO ready: When set ..  previous transaction has completed..
    // put WR-data
    Xil_Out32(u32_tmemac_base+MDIO_TX_DATA, reg_data);
    // post WR-req
    Value = (phy_addr << 24) |      // TX_PHYAD
            (reg_addr << 16) |      // TX_REGAD
            (MDIO_OP_WR << 14) |    // TX_OP
            (1 << 11);              // Initiate
    Xil_Out32(u32_tmemac_base+MDIO_CONTROL, Value);
    // Final
    return 0;
}
