// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package sysrst_ctrl_reg_pkg;

  // Param list
  parameter int NumCombo = 4;
  parameter int TimerWidth = 16;
  parameter int DetTimerWidth = 32;
  parameter int NumAlerts = 1;

  // Address widths within the block
  parameter int BlockAw = 8;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////

  typedef struct packed {
    logic        q;
  } sysrst_ctrl_reg2hw_intr_state_reg_t;

  typedef struct packed {
    logic        q;
  } sysrst_ctrl_reg2hw_intr_enable_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } sysrst_ctrl_reg2hw_intr_test_reg_t;

  typedef struct packed {
    logic        q;
    logic        qe;
  } sysrst_ctrl_reg2hw_alert_test_reg_t;

  typedef struct packed {
    logic [15:0] q;
  } sysrst_ctrl_reg2hw_ec_rst_ctl_reg_t;

  typedef struct packed {
    logic [15:0] q;
  } sysrst_ctrl_reg2hw_ulp_ac_debounce_ctl_reg_t;

  typedef struct packed {
    logic [15:0] q;
  } sysrst_ctrl_reg2hw_ulp_lid_debounce_ctl_reg_t;

  typedef struct packed {
    logic [15:0] q;
  } sysrst_ctrl_reg2hw_ulp_pwrb_debounce_ctl_reg_t;

  typedef struct packed {
    logic        q;
  } sysrst_ctrl_reg2hw_ulp_ctl_reg_t;

  typedef struct packed {
    logic        q;
  } sysrst_ctrl_reg2hw_wkup_status_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
    } key0_in;
    struct packed {
      logic        q;
    } key0_out;
    struct packed {
      logic        q;
    } key1_in;
    struct packed {
      logic        q;
    } key1_out;
    struct packed {
      logic        q;
    } key2_in;
    struct packed {
      logic        q;
    } key2_out;
    struct packed {
      logic        q;
    } pwrb_in;
    struct packed {
      logic        q;
    } pwrb_out;
    struct packed {
      logic        q;
    } ac_present;
    struct packed {
      logic        q;
    } bat_disable;
    struct packed {
      logic        q;
    } lid_open;
    struct packed {
      logic        q;
    } z3_wakeup;
  } sysrst_ctrl_reg2hw_key_invert_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
    } bat_disable_0;
    struct packed {
      logic        q;
    } ec_rst_l_0;
    struct packed {
      logic        q;
    } pwrb_out_0;
    struct packed {
      logic        q;
    } key0_out_0;
    struct packed {
      logic        q;
    } key1_out_0;
    struct packed {
      logic        q;
    } key2_out_0;
    struct packed {
      logic        q;
    } z3_wakeup_0;
    struct packed {
      logic        q;
    } flash_wp_l_0;
    struct packed {
      logic        q;
    } bat_disable_1;
    struct packed {
      logic        q;
    } ec_rst_l_1;
    struct packed {
      logic        q;
    } pwrb_out_1;
    struct packed {
      logic        q;
    } key0_out_1;
    struct packed {
      logic        q;
    } key1_out_1;
    struct packed {
      logic        q;
    } key2_out_1;
    struct packed {
      logic        q;
    } z3_wakeup_1;
    struct packed {
      logic        q;
    } flash_wp_l_1;
  } sysrst_ctrl_reg2hw_pin_allowed_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
    } bat_disable;
    struct packed {
      logic        q;
    } ec_rst_l;
    struct packed {
      logic        q;
    } pwrb_out;
    struct packed {
      logic        q;
    } key0_out;
    struct packed {
      logic        q;
    } key1_out;
    struct packed {
      logic        q;
    } key2_out;
    struct packed {
      logic        q;
    } z3_wakeup;
    struct packed {
      logic        q;
    } flash_wp_l;
  } sysrst_ctrl_reg2hw_pin_out_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
    } bat_disable;
    struct packed {
      logic        q;
    } ec_rst_l;
    struct packed {
      logic        q;
    } pwrb_out;
    struct packed {
      logic        q;
    } key0_out;
    struct packed {
      logic        q;
    } key1_out;
    struct packed {
      logic        q;
    } key2_out;
    struct packed {
      logic        q;
    } z3_wakeup;
    struct packed {
      logic        q;
    } flash_wp_l;
  } sysrst_ctrl_reg2hw_pin_out_value_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
    } pwrb_in_h2l;
    struct packed {
      logic        q;
    } key0_in_h2l;
    struct packed {
      logic        q;
    } key1_in_h2l;
    struct packed {
      logic        q;
    } key2_in_h2l;
    struct packed {
      logic        q;
    } ac_present_h2l;
    struct packed {
      logic        q;
    } ec_rst_l_h2l;
    struct packed {
      logic        q;
    } pwrb_in_l2h;
    struct packed {
      logic        q;
    } key0_in_l2h;
    struct packed {
      logic        q;
    } key1_in_l2h;
    struct packed {
      logic        q;
    } key2_in_l2h;
    struct packed {
      logic        q;
    } ac_present_l2h;
    struct packed {
      logic        q;
    } ec_rst_l_l2h;
  } sysrst_ctrl_reg2hw_key_intr_ctl_reg_t;

  typedef struct packed {
    logic [15:0] q;
  } sysrst_ctrl_reg2hw_key_intr_debounce_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic [15:0] q;
    } debounce_timer;
    struct packed {
      logic        q;
    } auto_block_enable;
  } sysrst_ctrl_reg2hw_auto_block_debounce_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
    } key0_out_sel;
    struct packed {
      logic        q;
    } key1_out_sel;
    struct packed {
      logic        q;
    } key2_out_sel;
    struct packed {
      logic        q;
    } key0_out_value;
    struct packed {
      logic        q;
    } key1_out_value;
    struct packed {
      logic        q;
    } key2_out_value;
  } sysrst_ctrl_reg2hw_auto_block_out_ctl_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
    } key0_in_sel;
    struct packed {
      logic        q;
    } key1_in_sel;
    struct packed {
      logic        q;
    } key2_in_sel;
    struct packed {
      logic        q;
    } pwrb_in_sel;
    struct packed {
      logic        q;
    } ac_present_sel;
  } sysrst_ctrl_reg2hw_com_sel_ctl_mreg_t;

  typedef struct packed {
    logic [31:0] q;
  } sysrst_ctrl_reg2hw_com_det_ctl_mreg_t;

  typedef struct packed {
    struct packed {
      logic        q;
    } bat_disable;
    struct packed {
      logic        q;
    } interrupt;
    struct packed {
      logic        q;
    } ec_rst;
    struct packed {
      logic        q;
    } rst_req;
  } sysrst_ctrl_reg2hw_com_out_ctl_mreg_t;

  typedef struct packed {
    logic        d;
    logic        de;
  } sysrst_ctrl_hw2reg_intr_state_reg_t;

  typedef struct packed {
    logic        d;
    logic        de;
  } sysrst_ctrl_hw2reg_ulp_status_reg_t;

  typedef struct packed {
    logic        d;
    logic        de;
  } sysrst_ctrl_hw2reg_wkup_status_reg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } ac_present;
    struct packed {
      logic        d;
      logic        de;
    } ec_rst_l;
    struct packed {
      logic        d;
      logic        de;
    } pwrb_in;
    struct packed {
      logic        d;
      logic        de;
    } key0_in;
    struct packed {
      logic        d;
      logic        de;
    } key1_in;
    struct packed {
      logic        d;
      logic        de;
    } key2_in;
    struct packed {
      logic        d;
      logic        de;
    } lid_open;
  } sysrst_ctrl_hw2reg_pin_in_value_reg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } combo0_h2l;
    struct packed {
      logic        d;
      logic        de;
    } combo1_h2l;
    struct packed {
      logic        d;
      logic        de;
    } combo2_h2l;
    struct packed {
      logic        d;
      logic        de;
    } combo3_h2l;
  } sysrst_ctrl_hw2reg_combo_intr_status_reg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } pwrb_h2l;
    struct packed {
      logic        d;
      logic        de;
    } key0_in_h2l;
    struct packed {
      logic        d;
      logic        de;
    } key1_in_h2l;
    struct packed {
      logic        d;
      logic        de;
    } key2_in_h2l;
    struct packed {
      logic        d;
      logic        de;
    } ac_present_h2l;
    struct packed {
      logic        d;
      logic        de;
    } ec_rst_l_h2l;
    struct packed {
      logic        d;
      logic        de;
    } pwrb_l2h;
    struct packed {
      logic        d;
      logic        de;
    } key0_in_l2h;
    struct packed {
      logic        d;
      logic        de;
    } key1_in_l2h;
    struct packed {
      logic        d;
      logic        de;
    } key2_in_l2h;
    struct packed {
      logic        d;
      logic        de;
    } ac_present_l2h;
    struct packed {
      logic        d;
      logic        de;
    } ec_rst_l_l2h;
  } sysrst_ctrl_hw2reg_key_intr_status_reg_t;

  // Register -> HW type
  typedef struct packed {
    sysrst_ctrl_reg2hw_intr_state_reg_t intr_state; // [330:330]
    sysrst_ctrl_reg2hw_intr_enable_reg_t intr_enable; // [329:329]
    sysrst_ctrl_reg2hw_intr_test_reg_t intr_test; // [328:327]
    sysrst_ctrl_reg2hw_alert_test_reg_t alert_test; // [326:325]
    sysrst_ctrl_reg2hw_ec_rst_ctl_reg_t ec_rst_ctl; // [324:309]
    sysrst_ctrl_reg2hw_ulp_ac_debounce_ctl_reg_t ulp_ac_debounce_ctl; // [308:293]
    sysrst_ctrl_reg2hw_ulp_lid_debounce_ctl_reg_t ulp_lid_debounce_ctl; // [292:277]
    sysrst_ctrl_reg2hw_ulp_pwrb_debounce_ctl_reg_t ulp_pwrb_debounce_ctl; // [276:261]
    sysrst_ctrl_reg2hw_ulp_ctl_reg_t ulp_ctl; // [260:260]
    sysrst_ctrl_reg2hw_wkup_status_reg_t wkup_status; // [259:259]
    sysrst_ctrl_reg2hw_key_invert_ctl_reg_t key_invert_ctl; // [258:247]
    sysrst_ctrl_reg2hw_pin_allowed_ctl_reg_t pin_allowed_ctl; // [246:231]
    sysrst_ctrl_reg2hw_pin_out_ctl_reg_t pin_out_ctl; // [230:223]
    sysrst_ctrl_reg2hw_pin_out_value_reg_t pin_out_value; // [222:215]
    sysrst_ctrl_reg2hw_key_intr_ctl_reg_t key_intr_ctl; // [214:203]
    sysrst_ctrl_reg2hw_key_intr_debounce_ctl_reg_t key_intr_debounce_ctl; // [202:187]
    sysrst_ctrl_reg2hw_auto_block_debounce_ctl_reg_t auto_block_debounce_ctl; // [186:170]
    sysrst_ctrl_reg2hw_auto_block_out_ctl_reg_t auto_block_out_ctl; // [169:164]
    sysrst_ctrl_reg2hw_com_sel_ctl_mreg_t [3:0] com_sel_ctl; // [163:144]
    sysrst_ctrl_reg2hw_com_det_ctl_mreg_t [3:0] com_det_ctl; // [143:16]
    sysrst_ctrl_reg2hw_com_out_ctl_mreg_t [3:0] com_out_ctl; // [15:0]
  } sysrst_ctrl_reg2hw_t;

  // HW -> register type
  typedef struct packed {
    sysrst_ctrl_hw2reg_intr_state_reg_t intr_state; // [51:50]
    sysrst_ctrl_hw2reg_ulp_status_reg_t ulp_status; // [49:48]
    sysrst_ctrl_hw2reg_wkup_status_reg_t wkup_status; // [47:46]
    sysrst_ctrl_hw2reg_pin_in_value_reg_t pin_in_value; // [45:32]
    sysrst_ctrl_hw2reg_combo_intr_status_reg_t combo_intr_status; // [31:24]
    sysrst_ctrl_hw2reg_key_intr_status_reg_t key_intr_status; // [23:0]
  } sysrst_ctrl_hw2reg_t;

  // Register offsets
  parameter logic [BlockAw-1:0] SYSRST_CTRL_INTR_STATE_OFFSET = 8'h 0;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_INTR_ENABLE_OFFSET = 8'h 4;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_INTR_TEST_OFFSET = 8'h 8;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_ALERT_TEST_OFFSET = 8'h c;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_REGWEN_OFFSET = 8'h 10;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_EC_RST_CTL_OFFSET = 8'h 14;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_ULP_AC_DEBOUNCE_CTL_OFFSET = 8'h 18;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_ULP_LID_DEBOUNCE_CTL_OFFSET = 8'h 1c;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_ULP_PWRB_DEBOUNCE_CTL_OFFSET = 8'h 20;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_ULP_CTL_OFFSET = 8'h 24;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_ULP_STATUS_OFFSET = 8'h 28;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_WKUP_STATUS_OFFSET = 8'h 2c;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_KEY_INVERT_CTL_OFFSET = 8'h 30;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_PIN_ALLOWED_CTL_OFFSET = 8'h 34;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_PIN_OUT_CTL_OFFSET = 8'h 38;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_PIN_OUT_VALUE_OFFSET = 8'h 3c;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_PIN_IN_VALUE_OFFSET = 8'h 40;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_KEY_INTR_CTL_OFFSET = 8'h 44;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_KEY_INTR_DEBOUNCE_CTL_OFFSET = 8'h 48;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_AUTO_BLOCK_DEBOUNCE_CTL_OFFSET = 8'h 4c;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_AUTO_BLOCK_OUT_CTL_OFFSET = 8'h 50;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_SEL_CTL_0_OFFSET = 8'h 54;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_SEL_CTL_1_OFFSET = 8'h 58;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_SEL_CTL_2_OFFSET = 8'h 5c;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_SEL_CTL_3_OFFSET = 8'h 60;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_DET_CTL_0_OFFSET = 8'h 64;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_DET_CTL_1_OFFSET = 8'h 68;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_DET_CTL_2_OFFSET = 8'h 6c;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_DET_CTL_3_OFFSET = 8'h 70;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_OUT_CTL_0_OFFSET = 8'h 74;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_OUT_CTL_1_OFFSET = 8'h 78;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_OUT_CTL_2_OFFSET = 8'h 7c;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COM_OUT_CTL_3_OFFSET = 8'h 80;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_COMBO_INTR_STATUS_OFFSET = 8'h 84;
  parameter logic [BlockAw-1:0] SYSRST_CTRL_KEY_INTR_STATUS_OFFSET = 8'h 88;

  // Reset values for hwext registers and their fields
  parameter logic [0:0] SYSRST_CTRL_INTR_TEST_RESVAL = 1'h 0;
  parameter logic [0:0] SYSRST_CTRL_INTR_TEST_SYSRST_CTRL_RESVAL = 1'h 0;
  parameter logic [0:0] SYSRST_CTRL_ALERT_TEST_RESVAL = 1'h 0;
  parameter logic [0:0] SYSRST_CTRL_ALERT_TEST_FATAL_FAULT_RESVAL = 1'h 0;

  // Register index
  typedef enum int {
    SYSRST_CTRL_INTR_STATE,
    SYSRST_CTRL_INTR_ENABLE,
    SYSRST_CTRL_INTR_TEST,
    SYSRST_CTRL_ALERT_TEST,
    SYSRST_CTRL_REGWEN,
    SYSRST_CTRL_EC_RST_CTL,
    SYSRST_CTRL_ULP_AC_DEBOUNCE_CTL,
    SYSRST_CTRL_ULP_LID_DEBOUNCE_CTL,
    SYSRST_CTRL_ULP_PWRB_DEBOUNCE_CTL,
    SYSRST_CTRL_ULP_CTL,
    SYSRST_CTRL_ULP_STATUS,
    SYSRST_CTRL_WKUP_STATUS,
    SYSRST_CTRL_KEY_INVERT_CTL,
    SYSRST_CTRL_PIN_ALLOWED_CTL,
    SYSRST_CTRL_PIN_OUT_CTL,
    SYSRST_CTRL_PIN_OUT_VALUE,
    SYSRST_CTRL_PIN_IN_VALUE,
    SYSRST_CTRL_KEY_INTR_CTL,
    SYSRST_CTRL_KEY_INTR_DEBOUNCE_CTL,
    SYSRST_CTRL_AUTO_BLOCK_DEBOUNCE_CTL,
    SYSRST_CTRL_AUTO_BLOCK_OUT_CTL,
    SYSRST_CTRL_COM_SEL_CTL_0,
    SYSRST_CTRL_COM_SEL_CTL_1,
    SYSRST_CTRL_COM_SEL_CTL_2,
    SYSRST_CTRL_COM_SEL_CTL_3,
    SYSRST_CTRL_COM_DET_CTL_0,
    SYSRST_CTRL_COM_DET_CTL_1,
    SYSRST_CTRL_COM_DET_CTL_2,
    SYSRST_CTRL_COM_DET_CTL_3,
    SYSRST_CTRL_COM_OUT_CTL_0,
    SYSRST_CTRL_COM_OUT_CTL_1,
    SYSRST_CTRL_COM_OUT_CTL_2,
    SYSRST_CTRL_COM_OUT_CTL_3,
    SYSRST_CTRL_COMBO_INTR_STATUS,
    SYSRST_CTRL_KEY_INTR_STATUS
  } sysrst_ctrl_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] SYSRST_CTRL_PERMIT [35] = '{
    4'b 0001, // index[ 0] SYSRST_CTRL_INTR_STATE
    4'b 0001, // index[ 1] SYSRST_CTRL_INTR_ENABLE
    4'b 0001, // index[ 2] SYSRST_CTRL_INTR_TEST
    4'b 0001, // index[ 3] SYSRST_CTRL_ALERT_TEST
    4'b 0001, // index[ 4] SYSRST_CTRL_REGWEN
    4'b 0011, // index[ 5] SYSRST_CTRL_EC_RST_CTL
    4'b 0011, // index[ 6] SYSRST_CTRL_ULP_AC_DEBOUNCE_CTL
    4'b 0011, // index[ 7] SYSRST_CTRL_ULP_LID_DEBOUNCE_CTL
    4'b 0011, // index[ 8] SYSRST_CTRL_ULP_PWRB_DEBOUNCE_CTL
    4'b 0001, // index[ 9] SYSRST_CTRL_ULP_CTL
    4'b 0001, // index[10] SYSRST_CTRL_ULP_STATUS
    4'b 0001, // index[11] SYSRST_CTRL_WKUP_STATUS
    4'b 0011, // index[12] SYSRST_CTRL_KEY_INVERT_CTL
    4'b 0011, // index[13] SYSRST_CTRL_PIN_ALLOWED_CTL
    4'b 0001, // index[14] SYSRST_CTRL_PIN_OUT_CTL
    4'b 0001, // index[15] SYSRST_CTRL_PIN_OUT_VALUE
    4'b 0001, // index[16] SYSRST_CTRL_PIN_IN_VALUE
    4'b 0011, // index[17] SYSRST_CTRL_KEY_INTR_CTL
    4'b 0011, // index[18] SYSRST_CTRL_KEY_INTR_DEBOUNCE_CTL
    4'b 0111, // index[19] SYSRST_CTRL_AUTO_BLOCK_DEBOUNCE_CTL
    4'b 0001, // index[20] SYSRST_CTRL_AUTO_BLOCK_OUT_CTL
    4'b 0001, // index[21] SYSRST_CTRL_COM_SEL_CTL_0
    4'b 0001, // index[22] SYSRST_CTRL_COM_SEL_CTL_1
    4'b 0001, // index[23] SYSRST_CTRL_COM_SEL_CTL_2
    4'b 0001, // index[24] SYSRST_CTRL_COM_SEL_CTL_3
    4'b 1111, // index[25] SYSRST_CTRL_COM_DET_CTL_0
    4'b 1111, // index[26] SYSRST_CTRL_COM_DET_CTL_1
    4'b 1111, // index[27] SYSRST_CTRL_COM_DET_CTL_2
    4'b 1111, // index[28] SYSRST_CTRL_COM_DET_CTL_3
    4'b 0001, // index[29] SYSRST_CTRL_COM_OUT_CTL_0
    4'b 0001, // index[30] SYSRST_CTRL_COM_OUT_CTL_1
    4'b 0001, // index[31] SYSRST_CTRL_COM_OUT_CTL_2
    4'b 0001, // index[32] SYSRST_CTRL_COM_OUT_CTL_3
    4'b 0001, // index[33] SYSRST_CTRL_COMBO_INTR_STATUS
    4'b 0011  // index[34] SYSRST_CTRL_KEY_INTR_STATUS
  };

endpackage

