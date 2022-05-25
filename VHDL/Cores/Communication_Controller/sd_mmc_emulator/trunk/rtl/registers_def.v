// $Id: registers_def.v 912 2015-05-14 21:41:57Z nxp20190 $
//
// @brief Sango X7 Main SPI registers definition.
//
// @Author Roger Williams <roger.williams@nxp.com>
//
// (c) 2015 NXP Semiconductors. All rights reserved.
//
// PROPRIETARY INFORMATION
//
// The information contained in this file is the property of NXP Semiconductors.
// Except as specifically authorized in writing by NXP, the holder of this file:
// (1) shall keep all information contained herein confidential and shall protect
// same in whole or in part from disclosure and dissemination to all third parties
// and (2) shall use same for operation and maintenance purposes only.
// -----------------------------------------------------------------------------
// 0.03.1  2015-05-14 (RAW) Hard-code some parameters to get this working today
// 0.03.0  2015-05-13 (RAW) Adapted from XCtrl4 code for initial X7
//------------------------------------------------------------------------------

// RW register definitions
/* -----\/----- EXCLUDED -----\/-----
`define TG_DAT_I_DLY_INDEX 15:0
`define TG_TCTRL_AD 4'h00
`define TG_TCTRL_INDEX 31:16
`define TG_TQUEUE_AD 4'h02
`define TG_TQUEUE_INDEX 63:32
`define TG_MCTRL_AD 4'h08
`define TG_MCTRL_INDEX 79:64
`define TG_MCONF_AD 4'h0a
`define TG_MCONF_INDEX 95:80
`define TG_DEBUG_AD 4'h0f
`define TG_DEBUG_INDEX 111:96
`define TG_REG_BITS_W 111:0
`define TG_REG_W_NBITS 112
 -----/\----- EXCLUDED -----/\----- */
`define TG_DAT_I_DLY_INDEX 15:0
`define TG_TCTRL_AD 4'h00
`define TG_TCTRL_INDEX 31:16
`define TG_TQUEUE_AD 4'h02
`define TG_TQUEUE_INDEX 47:32
`define TG_MCTRL_AD 4'h08
`define TG_MCTRL_INDEX 63:48
`define TG_MCONF_AD 4'h0a
`define TG_MCONF_INDEX 79:64
`define TG_DEBUG_AD 4'h0f
`define TG_DEBUG_INDEX 95:80
`define TG_REG_BITS_W 95:0
`define TG_REG_W_NBITS 96

// R register definitions
`define TG_TQ_STAT_AD 4'h01
`define TG_TQ_STAT_INDEX 15:0
`define TG_MQ_STAT_AD 4'h09
`define TG_MQ_STAT_INDEX 31:16
`define TG_MQUEUE_AD 4'h0c
`define TG_MQUEUE_INDEX 47:32
`define TG_REG_BITS_R 47:0
`define TG_REG_R_NBITS 48

// control signal definitions
`define TG_TQUEUE_LD_INDEX 0
`define TG_MQUEUE_RD_INDEX 1
`define TG_REG_BITS_CTL 1:0
`define TG_REG_CTL_NBITS 2

// RW register definitions
`define DAT_I_DLY_INDEX 15:0
`define CONF_AD 6'h00
`define CONF_INDEX 31:16
`define TRIG_SRC_AD 6'h01
`define TRIG_SRC_INDEX 47:32
`define CTRL_AD 6'h02
`define CTRL_INDEX 63:48
`define IRQ_MASK_AD 6'h0a
`define IRQ_MASK_INDEX 79:64
`define IRQ_CLR_AD 6'h06
`define IRQ_CLR_INDEX 95:80
`define SYNC_AD 6'h07
`define SYNC_INDEX 111:96
`define FILTER_AD 6'h09
`define FILTER_INDEX 127:112
`define REG_BITS_W 127:0
`define REG_W_NBITS 128

// R register definitions
`define STAT_AD 6'h03
`define STAT_INDEX 15:0
`define IRQ_AD 6'h04
`define IRQ_INDEX 31:16
`define VERSION_AD 6'h3f
`define VERSION_INDEX 47:32
`define REG_BITS_R 47:0
`define REG_R_NBITS 48
